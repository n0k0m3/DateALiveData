local BattleConfig = import(".BattleConfig")
local enum         = import(".enum")
local eStateEvent  = enum.eStateEvent
local eEvent       = enum.eEvent
local eState       = enum.eState
local eCampType    = enum.eCampType
local eHurtType = enum.eHurtType
local eResType  =  enum.eResType
local eEffectType= enum.eEffectType
local eAttrType  = enum.eAttrType
local eDamageType  = enum.eDamageType
local eDamageAttr  = enum.eDamageAttr
local eDamageAttr2 = enum.eDamageAttr2
local eBodyType    = enum.eBodyType
local eBFState     = enum.eBFState
local eMonsterType = enum.eMonsterType
local eRoleType    = enum.eRoleType
local eDir         = enum.eDir
local BattleUtils = {}
local BattleMgr   = import(".BattleMgr")
local FLT_EPSILON = 0xFFFFFF

--多边形转矩形
function BattleUtils.polygon2Rect(pts)
    local minx     =  FLT_EPSILON
    local miny     =  FLT_EPSILON
    local maxx     = -FLT_EPSILON
    local maxy     = -FLT_EPSILON
    for _idx , point in ipairs(pts) do
        minx = math.min(minx,point.X or point.x)
        miny = math.min(miny,point.Y or point.y)
        maxx = math.max(maxx,point.X or point.x)
        maxy = math.max(maxy,point.Y or point.y)
    end
    return me.rect(minx,miny,maxx - minx,maxy -miny)
end


function BattleUtils.rectsCenterPoint(rect1, rect2)
    -- local rects = { ... }
    -- local rect  = rects[1]
    -- for index = 2 , #rects do
    --     local _rect = rects[index]
    --     rect = me.rectIntersection(_rect , rect)
    -- end
    local rect = me.rectIntersection(rect1 , rect2)
    return BattleUtils.rectCenterPoint(rect)
end

--矩形中心点
function BattleUtils.rectCenterPoint(rect)
    return me.p(rect.origin.x + rect.size.width/2, rect.origin.y + rect.size.height/2)
end

--多边形中心点
function BattleUtils.polygonCenterPoint(pts)
    local rect = BattleUtils.polygon2Rect(pts)
    return BattleUtils.rectCenterPoint(rect)
end

function BattleUtils.toC3b(text) --"FF00FF"
    -- local color = tonumber(text,16)
    -- local r     = bit_rshift(bit_and(value, 0xFF),16)
    -- local g     = bit_and(bit_rshift(value,8), 0xFF)
    -- local b     = bit_and(value, 0xFF)
    -- print("text",text)
    -- print("color",color)
    -- print("r",string.sub(text,1,2))
    -- print("g",string.sub(text,3,4))
    -- print("b",string.sub(text,5,6))
    -- text = "FFFFFFF0FF"
    while string.len(text) < 6 do
        text = "0"..text
    end
    if string.len(text) > 6 then
        text = string.sub(text,string.len(text)-7,string.len(text))
    end
    -- print("text"..text)
    local r     = tonumber(string.sub(text,1,2),16)
    local g     = tonumber(string.sub(text,3,4),16)
    local b     = tonumber(string.sub(text,5,6),16)
    return me.c3b(r,g,b)
end

-- 0.4秒
-- 0.1秒放大。0.1秒缩小。停留0.2秒，最后0.1秒开始渐隐。
-- 不进行移动。只进行出现位置的X\Y随机。
-- 这就是苍空的做法。我们先抄这个吧。= =

function BattleUtils.tipAni(node,callback)
    local ranValue = math.random(1,3)
    if ranValue == 1 then
        BattleUtils.tipAniRed(node,callback)
    elseif ranValue == 2 then
        BattleUtils.tipAniWhite(node,callback)
    elseif ranValue == 3 then
        BattleUtils.tipAniYellow(node,callback)
    end
end
function BattleUtils.tipAniYellow(node,callback)
    local scale1  = ScaleTo:create(0.06, 2)
    local scale2  = ScaleTo:create(0.04, 1)
    local delay   = DelayTime:create(0.15)
    local fadeOut = FadeOut:create(0.3)
    local callFunc = CallFunc:create(function()
            node:removeFromParent()
            if callback then
                callback()
            end
    end)
    local args=
    {
        scale1,
        scale2,
        delay,
        fadeOut,
        callFunc
    }
    node:runAction(Sequence:create(args))
end

function BattleUtils.tipAniRed(node,callback)
    local scale1  = ScaleTo:create(0.06, 2)
    local scale2  = ScaleTo:create(0.04, 1)
    local delay   = DelayTime:create(0.15)
    local fadeOut = FadeOut:create(0.5)
    local callFunc = CallFunc:create(function()
            node:removeFromParent()
            if callback then
                callback()
            end
    end)
    local args=
    {
        scale1,
        scale2,
        delay,
        fadeOut,
        callFunc
    }
    node:runAction(Sequence:create(args))
end

function BattleUtils.tipAniWhite(node,callback)
    local scale1  = ScaleTo:create(0.06, 2)
    local scale2  = ScaleTo:create(0.04, 1)
    local delay   = DelayTime:create(0.1)
    local fadeOut = FadeOut:create(0.5)
    local callFunc = CallFunc:create(function()
            node:removeFromParent()
            if callback then
                callback()
            end
    end)
    local args=
    {
        scale1,
        scale2,
        delay,
        fadeOut,
        callFunc
    }
    node:runAction(Sequence:create(args))
end

--修正UI显示保底5%
function BattleUtils.fixPercent(value)
    if value > 0 then
        return math.max(value,5)
    else
        return 0
    end
end


local RES_MASK_TYPE =
{
    [1]="ui/battle/085.png",
    [2]="ui/head_mask2.png"
}

--伤害计算
function BattleUtils.triggerHurt(srcHero,tarHero,hurtData,hitedBdboxs)
    local value_0 = 0
    local value_1 = 1
    --计算是否命中
    local hurtInfo  = BattleUtils.calcuHurt(srcHero,tarHero,hurtData,hitedBdboxs)
    -- print("hurtInfo",hurtInfo)
    local hurtType  = hurtInfo.hurtType
    local hurtValue = hurtInfo.hurtValue
    -- hurtValue = -10
    if hurtValue ~= value_0 then
        --连击+1 TODO 是否自计算控制角色的连击
        if srcHero:getCampType() == eCampType.Hero then
            EventMgr:dispatchEvent(eEvent.EVENT_ADD_COMBO,value_1)
        end
    end

    -- print("hurtValue--------------",hurtValue)
    if hurtValue < value_0 then
        srcHero:addHurtValue(math.abs(hurtValue),tarHero)
    end
    --最近一次造成伤害的值
    srcHero:setHurtValue(math.abs(hurtValue))
    --伤害分摊计算
    hurtValue = tarHero:doShareHurt(hurtValue)
    --计算伤害分摊结束
    if hurtInfo.weakness then --弱点伤害
        if hurtType ~= eHurtType.PREICE and hurtType ~= eHurtType.CRIT
        and hurtType ~= eHurtType.DODGE
        and hurtType ~= eHurtType.CRIT_PREICE  then
            hurtType = eHurtType.RUO_DIAN
        end
    end
    -- dump({"是否是弱点点伤害:"..tostring(hurtInfo.weakness)})
    --TODO 减血处理
    hurtInfo.realHurtValue = tarHero:changeHp(hurtValue,hurtType,srcHero,true,hurtInfo.point) or 0
    --最近一次被造成伤害的值
    tarHero:setRevHurtValue(math.abs(hurtValue))



    return hurtInfo
end


--屏幕震动
function BattleUtils.screenWobble(hurtData)
    local data = {
                    shakeCount = hurtData.shakeCount ,
                    shakeType  = hurtData.shakeType ,
                    shakeStrength  = hurtData.shakeStrength,
                    shakeInching = hurtData.shakeInching,
                    shakeSpeed   = hurtData.shakeSpeed
                 }
    EventMgr:dispatchEvent(eEvent.EVENT_SCREEN_WOBBLE, data)
end

---------
--是否命中
function BattleUtils.isHit(hit,dodge)
    --local n = hit + dodge
    --n = n <= 1 and 1 or n
    --local value    = hit / n *10000
    --local ranValue = RandomGenerator.random(0,10000)
    -- print("hit：",hit,"dodge",dodge,"value",value,"ranValue",ranValue)
    --return ranValue <= value
    local n = hit - dodge
    n = math.max(n,0)
    return BattleUtils.triggerTest10000(n)
end

function BattleUtils.isHit2(srcHero,tarHero)
    local srcProperty = srcHero:getProperty()
    local tarProperty = tarHero:getProperty()
    local srcHit      = srcProperty:getValue(eAttrType.ATTR_HIT_PER)
    local tarDodge    = tarProperty:getValue(eAttrType.ATTR_DODGE_PER)
    return BattleUtils.isHit(srcHit,tarDodge)
end

-- a)  如果是普攻则判断是否格挡：
-- i.  随机0-10000之间的一个数X
-- ii. X<=格挡值，则判定为格挡，否则继续判断。
-- b)  如果普攻未被格挡，则判断是否穿透：
-- i.  随机0-10000之间的一个数X
-- ii. X<=穿透值，则判定为穿透，否则继续判断。
--是否格挡
function BattleUtils.isParry(value)
    return BattleUtils.triggerTest10000(value)
end

--是否穿透
function BattleUtils.isPreice(value)
    return BattleUtils.triggerTest10000(value)
end


-- a)  N=己方暴击-敌方抗暴
-- b)  如果：N<=0，那么N=0否则N不变
-- c)  随机0-10000之间的一个数X
-- d)  X<=暴击值，则判定为暴击，否则判定为非暴击。

function BattleUtils.isCrit(crit,uncrit)
    local n = crit - uncrit
    n = math.max(n,0)
    -- print(string.format("crit =%s ,uncrit =%s , n= %s",crit,uncrit,n))
    return BattleUtils.triggerTest10000(n)
end

---------------
function BattleUtils.triggerTest(a,b,value)
    local ranValue = RandomGenerator.random(a,b)
    -- print("randValue",ranValue,"baseValue",value)
    return ranValue <= value
end

function BattleUtils.triggerTest100(value)
    return BattleUtils.triggerTest(1,100,value)
end

function BattleUtils.triggerTest1000(value)
    return BattleUtils.triggerTest(1,1000,value)
end

function BattleUtils.triggerTest10000(value)
    return BattleUtils.triggerTest(1,10000,value)
end


--生物类型伤害加成
local BodyTypeAddTab = {}
BodyTypeAddTab[eBodyType.HUMAN]     = eAttrType.ATTR_DMADD_HERO
BodyTypeAddTab[eBodyType.BIOLOGY]   = eAttrType.ATTR_DMADD_BIOLOGY
BodyTypeAddTab[eBodyType.MACHINERY] = eAttrType.ATTR_DMADD_MACHINERY
BodyTypeAddTab[eBodyType.SPIRIT]    = eAttrType.ATTR_DMADD_SPIRIT

--生物类型伤害减免
local BodyTypeSubTab = {}
BodyTypeSubTab[eBodyType.HUMAN]     = eAttrType.ATTR_DMSUB_HERO
BodyTypeSubTab[eBodyType.BIOLOGY]   = eAttrType.ATTR_DMSUB_BIOLOGY
BodyTypeSubTab[eBodyType.MACHINERY] = eAttrType.ATTR_DMSUB_MACHINERY
BodyTypeSubTab[eBodyType.SPIRIT]    = eAttrType.ATTR_DMSUB_SPIRIT

--攻击类型伤害加成
local DMTypeAddTab = {}
DMTypeAddTab[eDamageType.PT]  = eAttrType.ATTR_DMADD_PT
DMTypeAddTab[eDamageType.FZ]  = eAttrType.ATTR_DMADD_FZ
DMTypeAddTab[eDamageType.XL]  = eAttrType.ATTR_DMADD_XL
DMTypeAddTab[eDamageType.CCJ] = eAttrType.ATTR_DMADD_CCJ
DMTypeAddTab[eDamageType.DZ]  = eAttrType.ATTR_DMADD_DZ
DMTypeAddTab[eDamageType.JX]  = eAttrType.ATTR_DMADD_JX
DMTypeAddTab[eDamageType.EXTRA_SKILL_1]  = eAttrType.ATTR_DMADD_EXTRA_1



--攻击基础类型伤害加成
local DMTypeAddTabBase = {}
DMTypeAddTabBase[eDamageType.PT]  = eAttrType.ATTR_DMADD_PT_BASE
DMTypeAddTabBase[eDamageType.FZ]  = eAttrType.ATTR_DMADD_FZ_BASE
DMTypeAddTabBase[eDamageType.XL]  = eAttrType.ATTR_DMADD_XL_BASE
DMTypeAddTabBase[eDamageType.CCJ] = eAttrType.ATTR_DMADD_CCJ_BASE
DMTypeAddTabBase[eDamageType.DZ]  = eAttrType.ATTR_DMADD_DZ_BASE
DMTypeAddTabBase[eDamageType.JX]  = eAttrType.ATTR_DMADD_JX_BASE
DMTypeAddTabBase[eDamageType.EXTRA_SKILL_1]  = eAttrType.ATTR_DMADD_EXTRA_1_BASE

--攻击类型伤害减免 映射属性ID
local DMTypeSubTab = {}
DMTypeSubTab[eDamageType.PT]  = eAttrType.ATTR_DMSUB_PT
DMTypeSubTab[eDamageType.FZ]  = eAttrType.ATTR_DMSUB_FZ
DMTypeSubTab[eDamageType.XL]  = eAttrType.ATTR_DMSUB_XL
DMTypeSubTab[eDamageType.CCJ] = eAttrType.ATTR_DMSUB_CCJ
DMTypeSubTab[eDamageType.DZ]  = eAttrType.ATTR_DMSUB_DZ
DMTypeSubTab[eDamageType.JX]  = eAttrType.ATTR_DMSUB_JX

--属性伤害加成
local DMAttrAddTab = {}
DMAttrAddTab[eDamageAttr.PYHSIC]  = eAttrType.ATTR_DMADD_PYHSIC
DMAttrAddTab[eDamageAttr.FROZEN]  = eAttrType.ATTR_DMADD_FROZEN
DMAttrAddTab[eDamageAttr.FLAME]   = eAttrType.ATTR_DMADD_FLAME
DMAttrAddTab[eDamageAttr.BLAST]   = eAttrType.ATTR_DMADD_BLAST
DMAttrAddTab[eDamageAttr.THUNDER] = eAttrType.ATTR_DMADD_THUNDER
DMAttrAddTab[eDamageAttr.POISON]  = eAttrType.ATTR_DMADD_POISON
DMAttrAddTab[eDamageAttr.LIGHT]   = eAttrType.ATTR_DMADD_LIGHT
DMAttrAddTab[eDamageAttr.DARK]    = eAttrType.ATTR_DMADD_DARK
DMAttrAddTab[eDamageAttr.MIND]    = eAttrType.ATTR_DMADD_MIND
--属性伤害减免
local DMAttrSubTab = {}
DMAttrSubTab[eDamageAttr.PYHSIC]  = eAttrType.ATTR_DMSUB_PYHSIC
DMAttrSubTab[eDamageAttr.FROZEN]  = eAttrType.ATTR_DMSUB_FROZEN
DMAttrSubTab[eDamageAttr.FLAME]   = eAttrType.ATTR_DMSUB_FLAME
DMAttrSubTab[eDamageAttr.BLAST]   = eAttrType.ATTR_DMSUB_BLAST
DMAttrSubTab[eDamageAttr.THUNDER] = eAttrType.ATTR_DMSUB_THUNDER
DMAttrSubTab[eDamageAttr.POISON]  = eAttrType.ATTR_DMSUB_POISON
DMAttrSubTab[eDamageAttr.LIGHT]   = eAttrType.ATTR_DMSUB_LIGHT
DMAttrSubTab[eDamageAttr.DARK]    = eAttrType.ATTR_DMSUB_DARK
DMAttrSubTab[eDamageAttr.MIND]    = eAttrType.ATTR_DMSUB_MIND
--伤害类型暴击率映射
local DMTypeCritTab = {}
DMTypeCritTab[eDamageType.PT]  = eAttrType.ATTR_CRIT_PT
DMTypeCritTab[eDamageType.FZ]  = eAttrType.ATTR_CRIT_FZ
DMTypeCritTab[eDamageType.XL]  = eAttrType.ATTR_CRIT_XL
DMTypeCritTab[eDamageType.CCJ] = eAttrType.ATTR_CRIT_CCJ
DMTypeCritTab[eDamageType.DZ]  = eAttrType.ATTR_CRIT_DZ
DMTypeCritTab[eDamageType.JX]  = eAttrType.ATTR_CRIT_JX

-- function __testMapping()
--     print("DMTypeCritTab",DMTypeCritTab)
--     print("DMAttrSubTab",DMAttrSubTab)
--     print("DMAttrAddTab",DMAttrAddTab)
--     print("DMTypeSubTab",DMTypeSubTab)
--     print("DMTypeAddTab",DMTypeAddTab)
--     print("BodyTypeAddTab",BodyTypeAddTab)
--     print("BodyTypeSubTab",BodyTypeSubTab)
--     Box("xxxxx")
-- end

local function __getBodyTypeAdd(property,bodyType ,hurtData)
    local attrId = BodyTypeAddTab[bodyType]
    if attrId then
        return property:getValue(attrId) + BattleUtils.getExtendHurtValue(attrId,hurtData)
    end
    --Box("bodyType:"..tostring(bodyType))
    return 0
end

local function __getBodyTypeSub(property,bodyType)
    local attrId = BodyTypeSubTab[bodyType]
    if attrId then
        return property:getValue(attrId)
    end
    --Box("bodyType:"..tostring(bodyType))
    return 0
end

local function __getDMTypeAdd(property,damageType)
    local attrId = DMTypeAddTab[damageType]
    if attrId then
        return property:getValue(attrId)
    end
    return 0
end

local function __getDMTypeAddTabBase(property,damageType)
    local attrId = DMTypeAddTabBase[damageType]
    if attrId then
        return property:getValue(attrId)
    end
    return 0
end

local function __getDMTypeSub(property,damageType)
    local attrId = DMTypeSubTab[damageType]
    if attrId then
        return property:getValue(attrId)
    end
    return 0
end

function BattleUtils.getDMAttrAdd(property,damageAttr)
    local attrId = DMAttrAddTab[damageAttr]
    if attrId then
        return property:getValue(attrId)
    end
    return 0
end

function BattleUtils.getDMAttrSub(property,damageAttr)
    local attrId = DMAttrSubTab[damageAttr]
    if attrId then
        return property:getValue(attrId)
    end
    return 0
end

--获取伤害类型暴击率
local function __getDMTypeCrit(property,damageType)
    local attrId = DMTypeCritTab[damageType]
    if attrId then
        return property:getValue(attrId)
    end
    return 0
end


--hurtType
function BattleUtils.hurtType(damageType,srcHero,tarHero,hurtData)
    local srcProperty = srcHero:getProperty()
    local tarProperty = tarHero:getProperty()
    local tarParry    = tarProperty:getValue(eAttrType.ATTR_PARRY_PER)  + BattleUtils.getExtendTargetValue(eAttrType.ATTR_PARRY_PER,hurtData)
    local srcPreice   = srcProperty:getValue(eAttrType.ATTR_PREICE_PER) + BattleUtils.getExtendHurtValue(eAttrType.ATTR_PREICE_PER,hurtData)
    local srcCrit     = srcProperty:getValue(eAttrType.ATTR_CRIT_PER)   + BattleUtils.getExtendHurtValue(eAttrType.ATTR_CRIT_PER,hurtData)
    local tarUncrit   = tarProperty:getValue(eAttrType.ATTR_UNCRIT_PER) + BattleUtils.getExtendTargetValue(eAttrType.ATTR_UNCRIT_PER,hurtData)
    local srcHit      = srcProperty:getValue(eAttrType.ATTR_HIT_PER)    + BattleUtils.getExtendHurtValue(eAttrType.ATTR_HIT_PER,hurtData)
    local tarDodge    = tarProperty:getValue(eAttrType.ATTR_DODGE_PER)
    --伤害类型暴击率
    local srcCritAdd  = __getDMTypeCrit(srcProperty,damageType)
    srcCrit = srcCrit + srcCritAdd
    srcPreice = math.floor(srcPreice* (1 - srcProperty:getValue(eAttrType.ATTR_PREICE_INVALID_PERCENT)*0.0001))
    srcCrit   = math.floor(srcCrit* (1 - srcProperty:getValue(eAttrType.ATTR_CRIT_INVALID_PERCENT)*0.0001))
    if BattleUtils.isHit(srcHit,tarDodge) then
        if BattleUtils.isPTAttack(damageType) then --普通攻击
            if BattleUtils.isParry(tarParry) then
                return eHurtType.PARRY
            else
                local p = BattleUtils.isPreice(srcPreice)
                local c = BattleUtils.isCrit(srcCrit,tarUncrit)
                if p and c then 
                    return eHurtType.CRIT_PREICE
                elseif p then 
                    return eHurtType.PREICE
                elseif c then 
                    return eHurtType.CRIT
                else
                    return eHurtType.PUGONG
                end
            end
        else
            local p = BattleUtils.isPreice(srcPreice)
            local c = BattleUtils.isCrit(srcCrit,tarUncrit)
            if p and c then 
                return eHurtType.CRIT_PREICE
            elseif p then 
                return eHurtType.PREICE
            elseif c then 
                return eHurtType.CRIT
            else
                return eHurtType.SKILL
            end
        end
    else
        return eHurtType.DODGE --闪避
    end
    --TODO 闪避 for buffer test
    -- return eHurtType.CRIT
end

function BattleUtils.isPTAttack(damageType)
    if damageType == 0 or damageType == eDamageType.PT then
        return true
    end
end


-- 攻击伤害=（己方攻击*技能系数+（己方固定增伤-敌方固定减伤））*（1.5+(己方暴伤-敌方暴免)/10000）*
-- （1-减伤比）*（1+（己方增伤加成比-敌方减伤加成比）/10000）
-- 攻击伤害<=0则本次攻击无效，强制扣血1
function BattleUtils.calcuHurt(srcHero,tarHero,hurtData,hitedBdboxs)
--     print(DMTypeAddTab)
-- print(DMTypeSubTab)
--     print(DMAttrAddTab)
-- print(DMAttrSubTab)

    local value_0          = 0
    local value_1          = 1
    local value_0point0001 = 0.0001
-- Box("aaaa")
    local damageType    = hurtData.damageType
    local damageAttr    = hurtData.damageAttr
    local hurtType      = BattleUtils.hurtType(damageType,srcHero,tarHero,hurtData)
    --弱点攻击
    local weakness  , point  = tarHero:isWeakness(srcHero,hitedBdboxs,damageAttr)
    -- dump(weakness)
    -- dump(point)
    -- dump("-------------------------------")
    -- print("hurtType------------",hurtType)
    local srcProperty   = srcHero:getProperty()
    local tarProperty   = tarHero:getProperty()
    local srcAtk        = srcProperty:getValue(eAttrType.ATTR_ATK)
    local srcDMAdd      = srcProperty:getValue(eAttrType.ATTR_DMADD)
    local tarDMSub      = tarProperty:getValue(eAttrType.ATTR_DMSUB)
    local srcHAdd       = srcProperty:getValue(eAttrType.ATTR_HADD_PER) + BattleUtils.getExtendHurtValue(eAttrType.ATTR_HADD_PER,hurtData)
    local tarHSub       = tarProperty:getValue(eAttrType.ATTR_HSUB_PER)
    local srcDMAddRatio = srcProperty:getValue(eAttrType.ATTR_DMADD_PER)
    local tarDMSubRatio = tarProperty:getValue(eAttrType.ATTR_DMSUB_PER) + BattleUtils.getExtendTargetValue(eAttrType.ATTR_DMSUB_PER,hurtData)
    --扩展伤害减免
    local tarDMSubRatioEx = tarProperty:getValue(eAttrType.ATTR_DMSUB_RATIO_EX)
    if tarDMSubRatioEx > 9900 then 
        tarDMSubRatioEx = 9900
    elseif tarDMSubRatioEx < 0 then 
        tarDMSubRatioEx = 0
    end
    local hurtScale     = hurtData.hurtScale*value_0point0001
        -- local hurtScale     = hurtData.hurtScale
    -- dump({"hurtScale:",hurtScale,value_0point0001})
--    攻击方的所属伤害类型加成-受击方的所属伤害类型减免+
--    攻击方的所属伤害属性加成-受击方的所属伤害属性减免+
    local srcDMTypeAdd  = value_0
    local tarDMTypeSub  = value_0
    --技能基础类型伤害加成
    local srcDMTypeAddBase  = value_0

    local srcDMAttrAdd  = value_0
    local tarDMAttrSub  = value_0
    --生物类型伤害加成
    local srcBodyTypeAdd  = __getBodyTypeAdd(srcProperty,tarHero:getBodyType(),hurtData)
    --生物类型伤害减免
    local tarBodyTypeSub  = __getBodyTypeSub(tarProperty,tarHero:getBodyType())

    if damageType ~= value_0 then
        srcDMTypeAdd  = __getDMTypeAdd(srcProperty,damageType) --srcProperty:getValue(damageType)
        tarDMTypeSub  = __getDMTypeSub(tarProperty,damageType) --tarProperty:getValue(damageType + 100)

        srcDMTypeAddBase  = __getDMTypeAddTabBase(srcProperty,damageType)
        --print("DMType:["..srcDMTypeAdd..","..tarDMTypeSub.."]")
    end
    -- print("DMType:["..srcDMTypeAdd..","..tarDMTypeSub.."]",damageType)
    if damageAttr ~= value_0 then
        srcDMAttrAdd = BattleUtils.getDMAttrAdd(srcProperty,damageAttr) --srcProperty:getValue(damageAttr)
        tarDMAttrSub = BattleUtils.getDMAttrSub(tarProperty,damageAttr) --tarProperty:getValue(damageAttr + 100)
        -- print("DMAttr:["..srcDMAttrAdd..","..tarDMAttrSub.."]")
    end


--------新伤害计算公式
    local tarDefRatio = BattleUtils.getExtendTargetValue(eAttrType.ATTR_DEF_RATIO,hurtData)
    local tarDef  = tarProperty:getValue(eAttrType.ATTR_DEF)  --目标防御

    if tarDefRatio ~= 0 then 
        tarDef = tarDef + tarProperty:getBaseValue(eAttrType.ATTR_DEF)*tarDefRatio*0.0001
    end 

    local hurtValue = value_0
    local critAdd   = value_1 --暴击增伤
    local monsterAdd  = value_1 --怪物增伤
    local hurtInfo = {hurtType = hurtType, hurtValue=value_0 ,weakness = weakness ,point = point}
    if hurtType == eHurtType.DODGE  then--闪避
        --不计算伤害 buff不生效
        return hurtInfo
    elseif hurtType == eHurtType.PARRY  then--格挡
        --不计算伤害 buff生效
        return hurtInfo
    elseif hurtType == eHurtType.PUGONG then
        --普通伤害
        critAdd = value_1
    elseif hurtType == eHurtType.SKILL then
        --技能伤害
        critAdd = value_1
    elseif hurtType == eHurtType.PREICE then
        --穿透目标防御值按照0计算-->修改为防御力的0.5倍
        if tarDef >= 0 then
            tarDef = tarDef*0.5
        end
    elseif hurtType == eHurtType.CRIT then
        -- 普通伤害*（1+暴击加成）
        critAdd = 1.5 + (srcHAdd - tarHSub)*value_0point0001
    elseif hurtType == eHurtType.CRIT_PREICE then
        if tarDef >= 0 then
            tarDef = tarDef*0.5
        end
        critAdd = 1.5 + (srcHAdd - tarHSub)*value_0point0001
    end
    --怪物类型
    local tarMonsterType = tarHero:getMonsterType()
    if tarMonsterType == eMonsterType.MT_NORMAL  then
        --对精英怪伤害加成
        local _srcDMAdd = srcProperty:getValue(eAttrType.ATTR_DMADD_NORMAL) + BattleUtils.getExtendHurtValue(eAttrType.ATTR_DMADD_NORMAL,hurtData)
        monsterAdd = value_1 + _srcDMAdd*value_0point0001
    elseif tarMonsterType == eMonsterType.MT_ELITE then
        --对精英怪伤害加成
        local _srcDMAdd = srcProperty:getValue(eAttrType.ATTR_DMADD_ELITE) + BattleUtils.getExtendHurtValue(eAttrType.ATTR_DMADD_ELITE,hurtData)
        monsterAdd = value_1 + _srcDMAdd*value_0point0001
    elseif tarMonsterType == eMonsterType.MT_BOSS then
        --对Boss怪伤害加成
        local _srcDMAdd = srcProperty:getValue(eAttrType.ATTR_DMADD_BOSS) + BattleUtils.getExtendHurtValue(eAttrType.ATTR_DMADD_BOSS,hurtData)
        monsterAdd = value_1 + _srcDMAdd*value_0point0001
    end

    --减伤比
    local  dmSub = BattleUtils.defenseDecay(tarDef)
    -- 基础伤害=己方攻击*减伤比
    srcAtk = srcAtk*dmSub  + srcDMAdd - tarDMSub
    srcAtk = math.max(srcAtk,value_1)
-- 单属性伤害=（基础伤害*技能伤害比例）*（1+技能增伤-技能减伤）*
-- （1+属性增伤-属性减伤）*（1+类型增伤-类型减伤）*（1+精英增伤）*
-- （1+暴击增伤-暴击减伤）


    local hurtValue = srcAtk * hurtScale *
    (value_1 + (srcDMTypeAdd  - tarDMTypeSub)*value_0point0001) *
    (value_1 + srcDMTypeAddBase*value_0point0001) *
    (value_1 + (srcDMAttrAdd  - tarDMAttrSub)*value_0point0001) *
    (value_1 + (srcBodyTypeAdd- tarBodyTypeSub)*value_0point0001)*
    (value_1 + (srcDMAddRatio - tarDMSubRatio)*value_0point0001)*
    monsterAdd*critAdd*(value_1- tarDMSubRatioEx*value_0point0001)
    --穿透加层
    if hurtType == eHurtType.PREICE or
        hurtType == eHurtType.CRIT_PREICE then --BY龚老板
        local percentHurtAdd = srcProperty:getValue(eAttrType.ATTR_PREICE_ADD_PERCENT) + BattleUtils.getExtendHurtValue(eAttrType.ATTR_PREICE_ADD_PERCENT,hurtData)
        print("穿透伤害加成计算："..tostring(hurtValue).." 加成比："..tostring(percentHurtAdd))
        hurtValue = hurtValue *(1 + percentHurtAdd*value_0point0001)
    end

    --弱点伤加层计算
    if weakness then
        local weaknessHurtAdd = srcProperty:getValue(eAttrType.ATTR_WEAKNESS_ATTACK_PERCENT)
        hurtValue = hurtValue*(value_1 + weaknessHurtAdd*value_0point0001)
    end
    -- 1、霸体值存在时，角色减伤50% （废弃）
    -- 2、霸体值存在时，受到伤害时。霸体值按照受伤200%来扣除(在Hero处理) 
    hurtValue = math.max(math.ceil(hurtValue),value_1)
    
    if battleController.isNeedVerifyHurt() then
        BattleUtils.verifyHurt(srcHero,tarHero,hurtValue,hurtData,hurtType,weakness)
    end
    -- if srcHero:getRoleType() == 1 or srcHero:getRoleType()  == 4 then 
    --     hurtValue = hurtValue*20000
    -- else
    --     hurtValue = 10
    -- end
    local srcElementCfg =  TabDataMgr:getData("Restrain")[srcHero:getData().magicAttribute]
    local tarElementId = tarHero:getData().magicAttribute
    local refrainRate = 1
    if srcElementCfg then
        local magicUpData = TabDataMgr:getData("DiscreteData")[1100001].data
        
        for k ,v in pairs(srcElementCfg.underrestraint) do
            if v == tarElementId then
                refrainRate = magicUpData.magicDown/10000
                break
            end
        end
        
        for k ,v in pairs(srcElementCfg.Refrain) do
            if v == tarElementId then
                refrainRate = magicUpData.magicUp/10000
                break
            end
        end
        
    end
    hurtInfo.hurtValue = -hurtValue * refrainRate
    return hurtInfo
end

--伤害检查计数器
local verifyHurtTime1 = 0
local verifyHurtEveryTime1 = 1000
local verifyHurtTime2 = 0
local verifyHurtEveryTime2 = 3000
function BattleUtils.verifyHurt(srcHero,tarHero,hurtValue,hurtData,hurtType,weakness)
    if hurtValue  > 1000000000 then
        hurtValue  = 1000000000
    end
    local roleType  = srcHero:getRoleType()
    local roleType2 = tarHero:getRoleType()
    if roleType == eRoleType.Hero then
            local time = BattleUtils.gettime()
            if time - verifyHurtTime1 < verifyHurtEveryTime1 then
                return
            end
            verifyHurtTime1 = time
            local srcData = srcHero:getData()
            local tarData = tarHero:getData()
            local sData = {}
            sData[1]  = 1
            if srcData.limitCid then
                sData[2]  = 2
            else
                sData[2]  = 1
            end
            sData[3]  = srcData.cid
            sData[4]  = srcData.limitCid or 0
            sData[5]  = tarData.id
            sData[6]  = tarData.level
            sData[7]  = hurtData.id
            sData[8]  = hurtType  --伤害类型
            sData[9]  = hurtValue
            sData[10] = weakness
            sData[11] = tarHero:getResist() > 0
            sData[12] = hurtData.hurtScale
            sData[13] = srcHero:getProperty():getValue(eAttrType.ATTR_ATK)
            battleController.sendVerifyHurt(sData) 
    elseif roleType == eRoleType.Monster and roleType2  == eRoleType.Hero  then
            local time = BattleUtils.gettime()
            if time - verifyHurtTime2 < verifyHurtEveryTime2 then
                return
            end
            verifyHurtEveryTime2 = time

            local srcData = srcHero:getData()
            local tarData = tarHero:getData()
            local sData = {}
            sData[1]  = 2
            if tarData.limitCid then
                sData[2]  = 2
            else
                sData[2]  = 1
            end
            sData[3]  = tarData.cid
            sData[4]  = tarData.limitCid or 0

            sData[5]  = srcData.id
            sData[6]  = srcData.level
            sData[7]  = hurtData.id
            sData[8]  = hurtType  --伤害类型
            sData[9]  = hurtValue
            sData[10] = weakness
            sData[11] = tarHero:getResist() > 0
            sData[12] = hurtData.hurtScale
            sData[13] = srcHero:getProperty():getValue(eAttrType.ATTR_ATK)
            battleController.sendVerifyHurt(sData) 
    end

end
--矩形中心点
function BattleUtils.rectMidPoint(rect)
    return me.p(rect.origin.x + rect.size.width/2,rect.origin.y + rect.size.height/2)
end
--当前时间(毫秒数)
function BattleUtils.gettime()
    return socket.gettime()*1000
end
--四舍五入
function BattleUtils.round(decimal)
    return  math.floor(decimal + 0.5)
end

function BattleUtils.translateArmtureEventData(...)
    local data = {...}
    local event =  {
            skeleton  = data[1], --动画节点
            animation = data[2], --动作名称
            name      = data[3], --事件名称
            pramN     = data[4], --整型参数
            pramF     = data[5], --浮点型参数
            pramS     = ""       --字符串参数
            }
    return event
end


function BattleUtils.print(...)
    if BattleConfig.DEBUG then
        print(...)
    end
end

function BattleUtils.isPolygonInterSection(pts1, pts2)
    return Polygon.Intersect(pts1, pts2)
end

------------伤害转事件
--攻击者
local HurtEventTab = {}
HurtEventTab[eDamageType.PT]  = eBFState.E_PT_HURT
HurtEventTab[eDamageType.FZ]  = eBFState.E_SKILL1_HURT
HurtEventTab[eDamageType.XL]  = eBFState.E_SKILL2_HURT
HurtEventTab[eDamageType.CCJ] = eBFState.E_CCJ_HURT
HurtEventTab[eDamageType.DZ]  = eBFState.E_DZ_HURT
HurtEventTab[eDamageType.JX]  = eBFState.E_JX_HURT

HurtEventTab[eDamageType.EXTRA_SKILL_1]  = eBFState.E_EXTRA_SKILL_1_HURT
HurtEventTab[eDamageType.EXTRA_SKILL_2]  = eBFState.E_EXTRA_SKILL_2_HURT
HurtEventTab[eDamageType.EXTRA_SKILL_3]  = eBFState.E_EXTRA_SKILL_3_HURT
HurtEventTab[eDamageType.EXTRA_SKILL_4]  = eBFState.E_EXTRA_SKILL_4_HURT
HurtEventTab[eDamageType.EXTRA_SKILL_5]  = eBFState.E_EXTRA_SKILL_5_HURT

--目标受到伤害
local RevHurtEventTab = {}
RevHurtEventTab[eDamageType.PT]  = eBFState.E_REV_PT_HURT
RevHurtEventTab[eDamageType.FZ]  = eBFState.E_REV_SKILL1_HURT
RevHurtEventTab[eDamageType.XL]  = eBFState.E_REV_SKILL2_HURT
RevHurtEventTab[eDamageType.CCJ] = eBFState.E_REV_CCJ_HURT
RevHurtEventTab[eDamageType.DZ]  = eBFState.E_REV_DZ_HURT
RevHurtEventTab[eDamageType.JX]  = eBFState.E_REV_JX_HURT


--目标受到的属性伤害
local RevHurtAttrEventTab = {}
RevHurtAttrEventTab[eDamageAttr.PYHSIC]  = eBFState.E_REV_PHYSICAL
RevHurtAttrEventTab[eDamageAttr.FROZEN]  = eBFState.E_REV_FROZEN
RevHurtAttrEventTab[eDamageAttr.FLAME]   = eBFState.E_REV_FLAME
RevHurtAttrEventTab[eDamageAttr.BLAST]   = eBFState.E_REV_BLAST
RevHurtAttrEventTab[eDamageAttr.THUNDER] = eBFState.E_REV_THUNDER
RevHurtAttrEventTab[eDamageAttr.POISON]  = eBFState.E_REV_POISON
RevHurtAttrEventTab[eDamageAttr.LIGHT]   = eBFState.E_REV_LIGHT
RevHurtAttrEventTab[eDamageAttr.DARK]    = eBFState.E_REV_DARK
RevHurtAttrEventTab[eDamageAttr.MIND]    = eBFState.E_REV_MIND

--受击
local RevHitEventTab = {}
RevHitEventTab[eDamageType.PT]  = eBFState.E_PT_REV_HIT
RevHitEventTab[eDamageType.FZ]  = eBFState.E_SKILL1_REV_HIT
RevHitEventTab[eDamageType.XL]  = eBFState.E_SKILL2_REV_HIT
RevHitEventTab[eDamageType.CCJ] = eBFState.E_CCJ_REV_HIT
RevHitEventTab[eDamageType.DZ]  = eBFState.E_DZ_REV_HIT
RevHitEventTab[eDamageType.JX]  = eBFState.E_JX_REV_HIT

local HitEventTab = {}
HitEventTab[eDamageType.PT]  = eBFState.E_PT_HITED
HitEventTab[eDamageType.FZ]  = eBFState.E_SKILL1_HITED
HitEventTab[eDamageType.XL]  = eBFState.E_SKILL2_HITED
HitEventTab[eDamageType.CCJ] = eBFState.E_CCJ_HITED
HitEventTab[eDamageType.DZ]  = eBFState.E_DZ_HITED
HitEventTab[eDamageType.JX]  = eBFState.E_JX_HITED

HitEventTab[eDamageType.EXTRA_SKILL_1]  = eBFState.E_EXTRA_SKILL_1_HITED
HitEventTab[eDamageType.EXTRA_SKILL_2]  = eBFState.E_EXTRA_SKILL_2_HITED
HitEventTab[eDamageType.EXTRA_SKILL_3]  = eBFState.E_EXTRA_SKILL_3_HITED
HitEventTab[eDamageType.EXTRA_SKILL_4]  = eBFState.E_EXTRA_SKILL_4_HITED
HitEventTab[eDamageType.EXTRA_SKILL_5]  = eBFState.E_EXTRA_SKILL_5_HITED

--
local CritEventTab = {}
CritEventTab[eDamageType.PT]  = eBFState.E_PT_CRIT
CritEventTab[eDamageType.FZ]  = eBFState.E_SKILL1_CRIT
CritEventTab[eDamageType.XL]  = eBFState.E_SKILL2_CRIT
CritEventTab[eDamageType.CCJ] = eBFState.E_CCJ_CRIT
CritEventTab[eDamageType.DZ]  = eBFState.E_DZ_CRIT
CritEventTab[eDamageType.JX]  = eBFState.E_JX_CRIT

CritEventTab[eDamageType.EXTRA_SKILL_1]  = eBFState.E_EXTRA_SKILL_1_CRIT
CritEventTab[eDamageType.EXTRA_SKILL_2]  = eBFState.E_EXTRA_SKILL_2_CRIT
CritEventTab[eDamageType.EXTRA_SKILL_3]  = eBFState.E_EXTRA_SKILL_3_CRIT
CritEventTab[eDamageType.EXTRA_SKILL_4]  = eBFState.E_EXTRA_SKILL_4_CRIT
CritEventTab[eDamageType.EXTRA_SKILL_5]  = eBFState.E_EXTRA_SKILL_5_CRIT

--

local RevEventCritTab = {}
RevEventCritTab[eDamageType.PT]  = eBFState.E_PT_REV_CRIT
RevEventCritTab[eDamageType.FZ]  = eBFState.E_SKILL1_REV_CRIT
RevEventCritTab[eDamageType.XL]  = eBFState.E_SKILL2_REV_CRIT
RevEventCritTab[eDamageType.CCJ] = eBFState.E_CCJ_REV_CRIT
RevEventCritTab[eDamageType.DZ]  = eBFState.E_DZ_REV_CRIT
RevEventCritTab[eDamageType.JX]  = eBFState.E_JX_REV_CRIT

--瞄准事件
local AimEventTab = {}
AimEventTab[eDamageType.PT]  = eBFState.E_PT_AIM      --发动普攻 瞄准
AimEventTab[eDamageType.FZ]  = eBFState.E_SKILL1_AIM  --小技能1 瞄准
AimEventTab[eDamageType.XL]  = eBFState.E_SKILL2_AIM  --小技能2 瞄准
AimEventTab[eDamageType.CCJ] = eBFState.E_CCJ_AIM     --发动出场技能 瞄准
AimEventTab[eDamageType.DZ]  = eBFState.E_DZ_AIM      --发动大招 瞄准
AimEventTab[eDamageType.JX]  = eBFState.E_JX_AIM      --发动觉醒 瞄准

AimEventTab[eDamageType.EXTRA_SKILL_1] = eBFState.E_EXTRA_SKILL_1_AIM
AimEventTab[eDamageType.EXTRA_SKILL_2] = eBFState.E_EXTRA_SKILL_2_AIM
AimEventTab[eDamageType.EXTRA_SKILL_3] = eBFState.E_EXTRA_SKILL_3_AIM
AimEventTab[eDamageType.EXTRA_SKILL_4] = eBFState.E_EXTRA_SKILL_4_AIM
AimEventTab[eDamageType.EXTRA_SKILL_5] = eBFState.E_EXTRA_SKILL_5_AIM    

--攻击穿透事件
local PierceTab = {}
PierceTab[eDamageType.PT]  = eBFState.E_PT_DO_PIERCE
PierceTab[eDamageType.FZ]  = eBFState.E_SKILL1_DO_PIERCE
PierceTab[eDamageType.XL]  = eBFState.E_SKILL2_DO_PIERCE
PierceTab[eDamageType.CCJ] = eBFState.E_CCJ_DO_PIERCE
PierceTab[eDamageType.DZ]  = eBFState.E_DZ_DO_PIERCE
PierceTab[eDamageType.JX]  = eBFState.E_JX_DO_PIERCE

--制造属性伤害
local DoHurtAttrEventTab = {}
DoHurtAttrEventTab[eDamageAttr.PYHSIC]  = eBFState.E_DO_PHYSICAL
DoHurtAttrEventTab[eDamageAttr.FROZEN]  = eBFState.E_DO_FROZEN
DoHurtAttrEventTab[eDamageAttr.FLAME]   = eBFState.E_DO_FLAME
DoHurtAttrEventTab[eDamageAttr.BLAST]   = eBFState.E_DO_BLAST
DoHurtAttrEventTab[eDamageAttr.THUNDER] = eBFState.E_DO_THUNDER
DoHurtAttrEventTab[eDamageAttr.POISON]  = eBFState.E_DO_POISON
DoHurtAttrEventTab[eDamageAttr.LIGHT]   = eBFState.E_DO_LIGHT
DoHurtAttrEventTab[eDamageAttr.DARK]    = eBFState.E_DO_DARK
DoHurtAttrEventTab[eDamageAttr.MIND]    = eBFState.E_DO_MIND

-- dump(RevEventCritTa,"RevEventCritTab")
-- dump(CritEventTab,"CritEventTab")
-- dump(HitEventTab,"HitEventTab")
-- dump(RevHitEventTab,"RevHitEventTab")
-- dump(HurtEventTab,"HurtEventTab")
-- dump(RevHurtEventTab,"RevHurtEventTab")
-- dump(AimEventTab,"AimEventTab")
-- dump(PierceTab,"PierceTab")
-- dump(DoHurtAttrEventTab,"DoHurtAttrEventTab")
-- Box("---xx--")

function BattleUtils.getPierceEvent( damageType )
    return PierceTab[damageType] or eBFState.E_DO_PIERCE
end

function BattleUtils.getDoHurtAttrEvent( damageAttr )
    return DoHurtAttrEventTab[damageAttr] or eBFState.E_DO_PHYSICAL
end

function BattleUtils.getAimEvent( damageType )
    return AimEventTab[damageType] or eBFState.E_PT_AIM
end

function BattleUtils.getRevHurtAttrEvent( damageAttr )
    return RevHurtAttrEventTab[damageAttr] or eBFState.E_REV_PHYSICAL
end

function BattleUtils.getRevHurtEvent( damageType )
    return RevHurtEventTab[damageType] or eBFState.E_REV_PT_HURT
end

function BattleUtils.getHurtEvent(damageType)
    return HurtEventTab[damageType] or eBFState.E_PT_HURT
end

--受击事件
function BattleUtils.getRevHitEvent(damageType)
    return RevHitEventTab[damageType] or eBFState.E_PT_REV_HIT
end
--命中事件
function BattleUtils.getHitEvent(damageType)
    return HitEventTab[damageType] or eBFState.E_PT_HITED
end

function BattleUtils.getCritEvent(damageType)
    return CritEventTab[damageType] or eBFState.E_PT_CRIT
end

function BattleUtils.getRevCritEvent(damageType)
    return RevEventCritTab[damageType] or eBFState.E_PT_REV_CRIT
end

--存储上次播放的背景音乐
local curBgMusicRes
local preBgMusicRes

function BattleUtils.playPreMusic(bLoop)
    if preBgMusicRes then
        BattleUtils.playMusic(preBgMusicRes,bLoop)
    end
end

function BattleUtils.playMusic(res,bLoop)
    if bLoop == nil then
        bLoop = false
    end
    TFAudio.stopMusic()
    SafeAudioExchangePlay().stopAllBgm()
    -- 要想修改音量即时生效,无论音量大小都需要播放
    preBgMusicRes = curBgMusicRes
    curBgMusicRes = res
    TFAudio.playMusic(res, bLoop)
end

--音效播放
function BattleUtils.playEffect(res,bLoop,gain)
    if bLoop == nil then
        bLoop = false
    end
    local effect
    gain = gain or 1.0
    --保证修改音量即时生效
    local EffectVolume = TFAudio.getEffectsVolume()
    if EffectVolume > 0 and gain > 0 then
        effect = TFAudio.playEffect(res,bLoop,1,0,gain)
    end
    return effect
-- playEffect(const char* pszFilePath, bool bLoop, float pitch/* = 1.0f*/, float pan/* = 0.0f*/, float gain/* = 1.0f*/)
end


function BattleUtils.randomProbability(probability)
    local rMin = 1
    local rMax = 0
    table.walk(probability, function(v, k)
        rMax = rMax + v
    end)
    local r = RandomGenerator.random(rMin, rMax)
    for i, v in ipairs(probability) do
        if r <= v then
            return i
        end
        r = r - v
    end
end
-- 减伤比=参数1/((免伤比*敌方防御值)+参数2)
-- 暂定参数1=100，参数2=100
function BattleUtils.defenseDecay(def)
    def = math.max(def,-250)
    def = math.min(def,2000)
    return 100/(def*0.15+100)
end

function BattleUtils.shuffle(tbl)
    local size = #tbl
    for i = size, 1, -1 do
        local rand = RandomGenerator.random(size)
        tbl[i], tbl[rand] = tbl[rand], tbl[i]
    end
    return tbl
end

--阵营敌友关系
local campData = TabDataMgr:getData("Camp")
function BattleUtils.campState(camp1,camp2)
    if camp1 == camp2 then
        return 1
    end
    return campData[camp1].state[camp2]
end

function BattleUtils.getExtendHurtValue(attrType,data)
    return data["hurtValue"..attrType] or 0
end

function BattleUtils.getExtendTargetValue(attrType,data)
    return data["targetValue"..attrType] or 0
end

function BattleUtils:openView(moduleName,blockType ,...)
    local fullModuleName = string.format("lua.logic.%s", moduleName)
    local view = requireNew(fullModuleName):new(...)
    AlertManager:addLayer(view,blockType)
    AlertManager:show()
    return view
end

function BattleUtils.createParticle(id)
    local data         = TabDataMgr:getData("ParticleEffect",id)
    local particleNode = TFParticle:create(data.resource)
    particleNode:resetSystem()
    particleNode._data    = data
    particleNode._angle   = particleNode:getAngle() 
    particleNode._gravity = particleNode:getGravity()
    particleNode._setDir  = function(self,dir)
        if self._data.controlAngle == 1 then  
            if self._dir ~= dir then 
                local _angle   = self._angle
                local _gravity = self._gravity
                if dir == eDir.LEFT then
                    self:setAngle(180-_angle)
                    self:setGravity(ccp(-_gravity.x,_gravity.y))
                elseif dir == eDir.RIGHT then
                    self:setAngle(_angle)
                    self:setGravity(ccp(_gravity.x,_gravity.y))
                end
                self._dir = dir
            end
        end
    end
    return particleNode
end

function BattleUtils.isLowDevice()
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        return TFDeviceInfo:isLowDevice()  
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        return TFDeviceInfo:getFreeMem() / TFDeviceInfo:getTotalMem() < 0.2
    else
        return false
    end
end

--震动支持
function BattleUtils.vibrator()
    print_("BattleUtils.vibrator")
    TFDeviceInfo:Vibrator(100)
end

return BattleUtils

-- hurtValue507
-- hurtValue509
-- hurtValue503
-- hurtValue654
-- hurtValue655
-- hurtValue656
-- hurtValue650
-- hurtValue651
-- hurtValue652
-- hurtValue653
-- hurtValue505
-- targetValue502
-- targetValue508
-- targetValue504
