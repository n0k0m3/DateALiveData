local BattleMgr   = import(".BattleMgr")
local BattleUtils = import(".BattleUtils")
local ResLoader   = import(".ResLoader")
local SkillEffect = import(".SkillEffect")
local BattleConfig= import(".BattleConfig")
local enum      = import(".enum")
local eEvent    = enum.eEvent
local eBFState         = enum.eBFState
local eAState          = enum.eAState
local eBFEffectType    = enum.eBFEffectType
local eBFTriggerObject = enum.eBFTriggerObject
local eBFTargetType    = enum.eBFTargetType
local eBFETakeType     = enum.eBFETakeType
local eBFETakeCondition = enum.eBFETakeCondition
local eSpecialType     = enum.eSpecialType
local eDir = enum.eDir
local eAttrType = enum.eAttrType
local _print = print
local print = BattleUtils.print
local eBufferEffectIconEvent = enum.eBufferEffectIconEvent
--效果叠加类型
local eBFAddType = enum.eBFAddType

--效果作用的目标类型
local eBFObjectType = enum.eBFObjectType

-- 1.属性变化
-- 2.附加状态
-- 3.模型变化
-- 4.释放技能
-- 5.受到技能
-- 6.执行buff
-- 7.特殊
--效果类型 TODO 未完成
local eBFEffectType = enum.eBFEffectType
-- 1.无参照对象
-- 2.buff触发对象
-- 3.buff作用对象
-- 4.状态来源方
-- 5.状态对应方

local eBFRTargetType = enum.eBFRTargetType

-------角色状态
local eBFHeroState = enum.eBFHeroState

-------效果移除类型
local eBFERemoveType =
{
   RT_NONE            =  0 ,
   RT_REMOVE_ALL      =  1 ,--移除叠加次数和
   RT_REMOVE_ME       =  2 ,--只移除效果对象 不对效果做任何处理
   RT_REMOVE_ADDTIMES =  3 ,--只移除叠加层数
}

local eAttackType =
{
    ALL= 1, --包涵所有
    PT = 2, --普攻
    FZ = 3,  --分支
    DZ = 4,--大招
    JX = 5,--觉醒
}
--终止条件扩展
-- 1.生效后终止
-- 2.造成伤害后终止
-- 3.受到伤害后终止
-- 4.切换角色时终止
-- 5.某属性达到对应条件
local eBFStopMode =
{
    SM_NONE          = 0,   --没有终止条件
    SM_EVENT_TRIGGER = 1,   --持续事件次数
    SM_ATTR_CHANGE   = 4,   --属性变化
    SM_TAKE          = 5,   --生效后移除
    SM_RMOVE_STATE   = 6,   --指定状态被移除
    SM_RMOVE_SKILL_EFFECT = 7,   --技能特效被移除
}

--buff 增减益类型
-- 1.增益buff
-- 2.减益debuff
-- 3.其他
-- 4.控制
local eBenefitType =
{
    BT_UNKNOW   = 0,
    BT_BUFF     = 1,
    BT_DEBUFF   = 2,
    BT_CTRL_XUANYUN    = 4,
    BT_CTRL_DONGJIE    = 5,
    BT_CTRL_JINGZHI    = 6,
    BT_CTRL_MH         = 7, --魅惑控制时间加层
    BT_CTRL_STOP_MOVE  = 8, --裁决(移动速度为哦)
}

--buffer效果更改HP类型
local eChangeHpType = 
{
    NORMAL   = 1, --需要计算伤害和防御
    ABSOLUTE = 2  --直接修改值
}

local bufferMgr = BattleMgr.getBufferMgr()


local BFEffect = class("BFEffect")

function BFEffect:ctor(data)
    self.data = data
    -- self.data.icon = "icon/system/128.png"
    -- self.data.iconDisplay = true
    self.nTime       = self.data.interval    --处理间隔触发
    -- 生效对象/宿主
    self.host       = nil
    -- buff提供者
    self.provideObj = nil
    --buff触发对象  --状态来源方
    self.triggerObj = nil
    --状态对应方
    self.receiveObj = nil

    self.bufferId = nil

    --持续时间
    self.nDuration  = 0
    self.sysStopTime = 0
    self.sysStartTime = 0
    --生效次数
    self.nTakeTimes = 0
    --生效状态
    self.addState = nil
    self.addParam = nil

    --当前叠加的层数
    self.nAddTimes = 0

    self.bEnabled  = true
    --技能特效节点
    self.effectNode =  nil

    -- 事件统计次数

    self.nEventTriggerTimes   = {}

    self.enableTakeEffect = true
    self.realAddTimes = 0
end

function BFEffect:getData()
    return self.data
end

function BFEffect:getCoverId()
    return self.data.coverId
end

function BFEffect:getPriority()
    return self.data.priority
end

function BFEffect:setTakeEffect(enable)
    if self.enableTakeEffect and not enable then
        self:removeEffect()
        self:releaseRenderNode()
        self:doIconEvent(eBufferEffectIconEvent.REMOVE)
    end
    if not self.enableTakeEffect and enable then
        self:doIconEvent(eBufferEffectIconEvent.ADD)
        if self.data.effectType ~= eBFEffectType.ET_STATE_CHANGE and 
           self.data.effectType ~= eBFEffectType.ET_STATE_CHANGE_RANDOM then
            self:releaseRenderNode()
            self:createRenderNode()
        end
    end
    self.enableTakeEffect = enable
end

--是否是负面效果
function BFEffect:isNegative()
    return self.data.benefitType >= 2
end
--是否为减少属性类效果
function BFEffect:isReduceAttr()
    return self.data.attrDebuff
end

--特殊类型 1是流血 2狂风
function BFEffect:getSpecialType()
    return self.data.specialType
end

-- ATTR_CTRL_PER   = 511 ,             -- 控制时间加成
-- ATTR_UNCTRL_PER = 512 ,             -- 受控时间减免
-- ATTR_BUFF_PER   = 513 ,             -- 增益时间加成
-- ATTR_DEBUFF_PER = 514               -- 减益时间减免
function BFEffect:getDuration()
    local value_0point0001 =0.0001
    local value_1          =1
    local duration    = self.data.duration
    if duration > 0 then
        local benefitType = self.data.benefitType
        if benefitType == eBenefitType.BT_BUFF then
            duration = duration*(value_1+self.host:getValue(eAttrType.ATTR_BUFF_PER)*value_0point0001)
        elseif benefitType == eBenefitType.BT_DEBUFF then
            duration = duration*(value_1-self.host:getValue(eAttrType.ATTR_DEBUFF_PER)*value_0point0001)
        elseif benefitType == eBenefitType.BT_CTRL_DONGJIE then
            if self.provideObj then
                local ratio = self.provideObj:getValue(eAttrType.ATTR_CTRL_PER) - self.host:getValue(eAttrType.ATTR_UNCTRL_PER)
                + self.provideObj:getValue(eAttrType.ATTR_CTRL_DJ) - self.host:getValue(eAttrType.ATTR_UNCTRL_DJ)
                duration = duration*( value_1 + ratio*value_0point0001)
            end
        elseif benefitType == eBenefitType.BT_CTRL_JINGZHI then
            if self.provideObj then
                local ratio = self.provideObj:getValue(eAttrType.ATTR_CTRL_PER) - self.host:getValue(eAttrType.ATTR_UNCTRL_PER)
                + self.provideObj:getValue(eAttrType.ATTR_CTRL_JZ) - self.host:getValue(eAttrType.ATTR_UNCTRL_JZ)
                duration = duration*( value_1 + ratio*value_0point0001 )
            end
        elseif benefitType == eBenefitType.BT_CTRL_XUANYUN then
            if self.provideObj then
                local ratio = self.provideObj:getValue(eAttrType.ATTR_CTRL_PER) - self.host:getValue(eAttrType.ATTR_UNCTRL_PER)
                + self.provideObj:getValue(eAttrType.ATTR_CTRL_XY) - self.host:getValue(eAttrType.ATTR_UNCTRL_XY)
                duration = duration*( value_1 + ratio*value_0point0001 )
            end
        elseif benefitType == eBenefitType.BT_CTRL_MH then --迷惑时间加层
            if self.provideObj then
                duration = duration*(value_1+self.provideObj:getValue(eAttrType.ATTR_CTRL_MH)*value_0point0001)
            end
        elseif benefitType == eBenefitType.BT_CTRL_STOP_MOVE then --裁决持续时间加成
            if self.provideObj then
                -- 归属为控制类，受到属性511和512的影响：
                -- 裁决类效果的持续时间=基础持续时间*（1+（施加者的511属性-承受者512属性）/10000）
                duration = duration*(value_1 + (self.provideObj:getValue(eAttrType.ATTR_CTRL_PER) -self.provideObj:getValue(eAttrType.ATTR_UNCTRL_PER)) *value_0point0001)
            end
        end
        duration = math.max(duration,0)
    end
    return duration
end
function BFEffect:isEnabled()
    if battleController.isRun() then
        return self.bEnabled
    end
end

function BFEffect:setEnabled(enabled)
    self.bEnabled = enabled
end

function BFEffect:updatePauseState(isPause)
    if self.nDuration > 0 then
        if isPause then
            if self.sysStopTime > 99999 then
                return
            end
            self.sysStopTime = battleController.getStopTime()
        else
            if battleController.isTiming() and self.sysStopTime > 99999 then
                self.sysStartTime = self.sysStartTime + (BattleUtils.gettime() - self.sysStopTime)
                self.sysStopTime = 0
            end
        end
    end
end

function BFEffect:resetSysTime()
    -- self.sysStartTime = BattleUtils.gettime()
    -- self.sysStopTime = 0
    -- if not battleController.isTiming() then
    --     self.sysStopTime = self.sysStartTime
    -- end
end

--效果ID 叠加的依据
function BFEffect:getId()
    return self.data.id
end

--叠加次数
function BFEffect:isMaxAddTimes()
    if self.data.maxSuperposition == -1 then
        return false
    else
        return self.nAddTimes >= self.data.maxSuperposition
    end
end

--最大生效次数
function BFEffect:isMaxTakeTimes()
    if self.data.effectTimes == -1 then --无限生效
        return false
    end
    return self.nTakeTimes >= self.data.effectTimes
end

--叠加时间
function BFEffect:addTestTime()
    self.nDuration  = self.nDuration + self:getDuration()
    self:resetSysTime()
end
--叠加
function BFEffect:addTest()
    local value_1 = 1
    local value_0 = 0
    self:tryTriggerNewEffect_before()
    if self:isMaxAddTimes() then
        print("达到最大叠加次数：",self.data.id , self.nAddTimes)
        if self.data.superpositionType == eBFAddType.AT_ADD2 then -- 达到最大层数时持续时间还是要刷新
            self.nDuration  = self:getDuration() 
            self:resetSysTime()
        end
        return
    end
    self.nDuration  = self:getDuration()
    self:resetSysTime()
    self.nTakeTimes = value_0  --如果是叠加的话也生效次数清0重先算
    --叠加层数
    self.nAddTimes  = self.nAddTimes + value_1  --层数
    --即时生效处理
    self:onAtOnce()
    --通过时间为0来控制是否是只生效一次
    if self.data.duration ~= value_0 then
        if self.nAddTimes == value_1 then  --第一层检查添加到管理器
            self:addToMgr()
        else
            self:doIconEvent(eBufferEffectIconEvent.UPDATE_ADDTIMES)  
        end
    else
        print("即刻生效一次的效果")
    end
    --检查是否有新特效触发
    if self:tryTriggerNewEffect() then
        --新特效触发了移除当前特效
        _print("新特效触发了移除当前特效")
        -- self:removeSelf()
        self:normalDestory()
    end
end


--替换原效果
function BFEffect:replace()
    _print("effect 替换"..self.data.id)
    if self.data.stopContent == eBFERemoveType.RT_REMOVE_ALL then
        if self.data.effectType ~= eBFEffectType.ET_CHANGE_SKIN and self.data.effectType ~= eBFEffectType.ET_FORCE_CHANGE_SKIN then --变身效果不需要做效果替换
            self:removeEffect()
        end
    end
    self.nAddTimes  = 1 --层数
    self.nTakeTimes = 0
    self.nEventTriggerTimes = {}
    self.nDuration  = self:getDuration()
    self:resetSysTime()
    --即时生效处理
    if self.data.effectType ~= eBFEffectType.ET_CHANGE_SKIN and self.data.effectType ~= eBFEffectType.ET_FORCE_CHANGE_SKIN then --变身效果不需要做效果替换
        self:onAtOnce()
    end

end
--
function BFEffect:getAddTimes()
    return self.nAddTimes
end

function BFEffect:update(dt)
    if self.skeletonNodes then 
        for i, skeletonNode in ipairs(self.skeletonNodes) do
            local pos = self.host:getActor():getRelativeBonePosition(skeletonNode.mount)
            skeletonNode:setPosition(pos)
            if not skeletonNode.effectsDir or skeletonNode.effectsDir == 0 then 
                local scaleX = skeletonNode:getScaleX()
                if self.host:getDir() == eDir.LEFT then
                    skeletonNode:setScaleX(-math.abs(scaleX))
                else
                    skeletonNode:setScaleX(math.abs(scaleX))
                end
            end
        end
    end
    if not self:isEnabled() then
        return
    end

    if battleController.isTiming() then
        --持续时间计算
        self:handlDuration(dt)
        --间隔触发效果
        self:handlInterval(dt)
    end
end


function BFEffect:handlInterval(dt)
    local effectiveWay = self.data.effectiveWay
    if effectiveWay == eBFETakeType.TT_INTERVAL or
        effectiveWay == eBFETakeType.TT_SKILL_EFFECT then
        self.nTime  = self.nTime  + dt
        if self.nTime > self.data.interval then
            self.nTime = 0
            self:onInterval()
        end
    elseif effectiveWay == eBFETakeType.TT_CHECK_EFFECT then
        self.nTime  = self.nTime  + dt
        if self.nTime > self.data.interval then
            self.nTime = 0
            if self.data.effectCondition > 0 then
                if not self:checkEffectCondition(self.host,self.data) then
                    self:normalDestory()
                end
            end
        end
    end
end

function BFEffect:bind(host,provideObj,triggerObj,receiveObj,bufferId)
    self.host       = host
    self.provideObj = provideObj
    self.triggerObj = triggerObj
    self.receiveObj = receiveObj
    self.bufferId = bufferId
    if self.data.effectType ~= eBFEffectType.ET_STATE_CHANGE and 
       self.data.effectType ~= eBFEffectType.ET_STATE_CHANGE_RANDOM then   
        self:createRenderNode()
    end
    if self.data.coverId > 0 then
        local enableTake = self.host:checkEffectTake(self, true)
        self:setTakeEffect(enableTake)
    end
end

function BFEffect:getHost()
    return self.host
end

function BFEffect:setEffectNode(effectNode)
    self.effectNode = effectNode
    -- if not self.effectNode then
    --     Box("effectNode is not nil 6b")
    -- end
end

--时间间隔触发
function BFEffect:onInterval()
   if effectiveWay == eBFETakeType.TT_SKILL_EFFECT then
        --检查自己有没对象产生碰撞
        if self.effectNode:hitTest(self.host) then
            self:takeEffect(self.nAddTimes)
        end
   else
        self:takeEffect(self.nAddTimes)
   end
end



--即刻生效
function BFEffect:onAtOnce()
    print("-----------onAtOnce---------")
    if self:isVaildTakeType(eBFETakeType.TT_AT_ONECE) then
        self:takeEffect(1)
    end
    if self:isVaildTakeType(eBFETakeType.TT_CHECK_EFFECT) then
        self:takeEffect(1)
    end
end

--检查生效类型
function BFEffect:isVaildTakeType(takeType)
    return self.data.effectiveWay == takeType
end

--生效效果展示
function BFEffect:showEffectName()
    if not self.bShowEffectName then
        self.bShowEffectName = true
        local desColour = self.data.desColour
        local des       = self.data.des
        if desColour > 0 then 
            local actor = self.host:getActor()
            if actor  then
                actor:showBufferEffectName(desColour,des)
            end
        end
    end
end

function BFEffect:fixValue(value)
    local maxNum = self.data.maxNum or 0
    if maxNum > 0 then 
        value = math.min(value,maxNum)
    elseif maxNum < 0 then 
        value = math.max(value,maxNum)
    end
    return value
end

--生效处理
function BFEffect:takeEffect(addTimes)
    if not self.enableTakeEffect then
        return
    end
    print("效果处理....................",self.data.id , self.nAddTimes)

    --扣除生效次数
    local value_0 = 0
    local value_1 = 1
    local value_0point0001 = 0.0001
    addTimes = addTimes or value_1
    local objectType = self.data.objectType
    -- if objectType == eBFObjectType.OT_HERO then --作用于目标
        local target = self.host
        local effectType = self.data.effectType
        local bAbsorb  = false
        if effectType == eBFEffectType.ET_ATTR_CHANGE   then       -- 属性变化
            --属性变更
            if self.data.referenceTarget == eBFRTargetType.RTT_NONE then --没有参照对象就是值类型
                local attrType  = self.data.attributeGrow
                local value     = self.data.effectNum
                print("attrType1 , value ",attrType,value)
                value = value*addTimes
                --buffer伤害类型加成减免
                ---- 配置值*[1+（buff触发对象的属性伤害加成-buff作用对象的属性伤害减免）]
                if attrType == eAttrType.ATTR_NOW_HP and value < value_0 then
                    if self.data.damageType ==  eChangeHpType.NORMAL then
                        bAbsorb = true
                        local def        = target:getValue(eAttrType.ATTR_DEF)
                        --防御衰减系数
                        local defDecay   = BattleUtils.defenseDecay(def)
                        local damageAttr  = self.data.damageAttr
                        local valueAdd  = BattleUtils.getDMAttrAdd(self.triggerObj:getProperty(),damageAttr)
                        local valueSub  = BattleUtils.getDMAttrSub(self.host:getProperty(),damageAttr)
                        local attrDecay1   = value_1 + (valueAdd - valueSub)*value_0point0001
                        -- Box("value:"..tostring(value).." defDecay:"..tostring(defDecay)
                        -- .." attrDecay1:"..tostring(attrDecay1)
                        value  = value*defDecay*attrDecay1
                        
                    end

                    -- _print(
                    --     " damageAttr:"..damageAttr..
                    --     " damageAttr2:"..damageAttr2..
                    --     " valueAdd:"..valueAdd..
                    --     " valueSub:"..valueSub..
                    --     " value:"..value
                    --     )
                end
                value = math.floor(value)-- 取整
                value = self:fixValue(value) --取值修正

                --TODO减血需要处理护盾和抵抗吸收
                if attrType == eAttrType.ATTR_NOW_HP then
                    if target:isAlive() then
                        local hp = target:getHp()
                        target:changeHp(value,nil,self.receiveObj)
                        --击杀事件
                        if self.provideObj then 
                            if hp > 0 and target:getHp() <= 0 then --目标HP为0
                                self.provideObj:onEventTrigger(eBFState.E_JI_SHA,target)
                            end
                        end
                    end
                    self:checkHurtValue(target,value)
                elseif attrType == eAttrType.ATTR_MAX_HP_RATIO then
                    if target:isAlive() then
                        target:changeValue(attrType,value)
                    end
                else
                    target:changeValue(attrType,value)
                end
                self.addState = attrType
                self.addParam = value
            else
                local attrType  =  self.data.attributeGrow
                local refAttrType    = self.data.attributeReference
                local referenceType  = self.data.referenceType  --1是基础值 2当前值
                local refTarget = self:getRefTarget()
                local value
                if referenceType == value_1 then
                    value = refTarget:getBaseValue(refAttrType)
                else
                    value = refTarget:getValue(refAttrType)
                end
                local ratio = self.data.ratio
                value = value*ratio*0.0001    --相对于初始属性？还是当前
                -- referenceTarget attributeReference  ratio
                value = value*addTimes
                --buffer伤害类型加成减免
                if attrType == eAttrType.ATTR_NOW_HP and value < value_1 then
                    if self.data.damageType ==  eChangeHpType.NORMAL then
                        bAbsorb = true
                        local def        = target:getValue(eAttrType.ATTR_DEF)
                        --防御衰减系数
                        local defDecay   = BattleUtils.defenseDecay(def)
                        local damageAttr = self.data.damageAttr
                        local valueAdd = BattleUtils.getDMAttrAdd(self.triggerObj:getProperty(),damageAttr)
                        local valueSub = BattleUtils.getDMAttrSub(self.host:getProperty(),damageAttr)
                        local attrDecay1   = 1 + (valueAdd - valueSub)*value_0point0001
                        -- Box("value:"..tostring(value).." defDecay:"..tostring(defDecay)
                        -- .." attrDecay1:"..tostring(attrDecay1)
                        value  = value*defDecay*attrDecay1

                    end
                    -- _print(
                    --     " damageAttr:"..damageAttr..
                    --     " damageAttr2:"..damageAttr2..
                    --     " valueAdd:"..valueAdd..
                    --     " valueSub:"..valueSub..
                    --     " value:"..value
                    --     )

                end
                value = math.floor(value)-- 取整
                value = self:fixValue(value) --取值修正
                -- _print("attrType2 , value ",self.data.id,attrType,value)
                --TODO减血需要处理护盾和抵抗吸收
                if attrType == eAttrType.ATTR_NOW_HP then
                    if target:isAlive() then                  
                        local hp = target:getHp()
                        target:changeHp(value,nil,self.receiveObj,bAbsorb)
                        --击杀事件
                        if self.provideObj then 
                            if hp > 0 and target:getHp() <= 0 then --目标HP为0
                                self.provideObj:onEventTrigger(eBFState.E_JI_SHA,target)
                            end
                        end
                    end
                    self:checkHurtValue(target,value)
                else
                    target:changeValue(attrType,value)
                end
                self.addState = attrType
                self.addParam = value
            end
        elseif effectType == eBFEffectType.ET_STATE_CHANGE then       -- 状态变更
            local states = self.data.effectState
            if #states > 0  then
                local state = self.data.effectState[1]
                -- print("状态变更...",self.data.id ,state)
                local result = target:addAState(state,self:getObjectID())
                self.addState = state
                if result then  --TODO 状态添加成功再创建特效
                    self:createRenderNode()
                end
            else
                Box("BufferEffect ["..self.data.id .."] effectState size = 0 ")
            end
        elseif effectType == eBFEffectType.ET_TIMESCALE_CHANGE then
            local timeScale = self.data.timeScale
            if timeScale then  --TODO 配置0-100
                target:changeSelfTimeScale(timeScale*0.01*addTimes)
            end
        elseif effectType == eBFEffectType.ET_TO_FLASH_BACK then
                local backTime = self.data.backTime
                if backTime then 
                    target:toFlashBack(backTime)
                end
        elseif effectType == eBFEffectType.ET_STATE_CHANGE_RANDOM then       -- 随机状态
            local states = self.data.effectState
            if #states > 0  then
                local state  = states[RandomGenerator.random(#states)]
                local result = target:addAState(state,self:getObjectID())
                self.addState = state
                if result then  --TODO 状态添加成功再创建特效
                    self:createRenderNode()
                end
            else
                Box("BufferEffect ["..self.data.id .."] effectState size = 0 ")
            end
        elseif effectType == eBFEffectType.ET_TRIGGER_EFFECT then
            if self.triggerObj then
                if self.data.actionId then
                    local formId = self.triggerObj:getFormId()
                    local skillEffectId = self.data.actionId[formId] or self.data.actionId[0]
                    if skillEffectId then
                        --是否需要考虑天使数据
                        local effectData = BattleDataMgr:getEffectData(skillEffectId ,self.triggerObj:getAngleDatas())
                        if effectData then
                            local fixPosition
                            if self.data.effectExecutor == 1 then
                                local position = self.host:getPosition3D()
                                fixPosition = me.Vertex3F(position.x,position.y,position.z)
                            elseif self.data.effectExecutor == 2 then
                                local position = self.host:getPosition3D()
                                fixPosition = me.Vertex3F(position.x,position.z,position.z)
                            end
                            SkillEffect.create(effectData,self.triggerObj,nil,nil,fixPosition)
                        end
                    end
                end
            end
        elseif effectType == eBFEffectType.ET_BUFFER_PRO_CHANGE then  --buffer 状态变更
            --修改自己存在buffer的概率
            local buffIds = self.data.changeId
            for _ , id in ipairs(buffIds) do
                local buffer = self.host:getBuffer(id)
                if buffer then
                    buffer:changeProbability(self.data.probabilityNum)
                end
            end

        elseif effectType == eBFEffectType.ET_TEMP_ATTR_CHANGE then --TODO 修改临时属性
            --临时属性变更
            if self.data.referenceTarget == eBFRTargetType.RTT_NONE then --没有参照对象就是值类型
                local attrType  = self.data.attributeGrow
                local value     = self.data.effectNum
                print("attrType1 , value ",attrType,value)
                value = value*addTimes
                value = math.floor(value)-- 取整
                value = self:fixValue(value)
                --修改临时属性
                target:changeTempValue(attrType,value)
                self.addState = attrType
                self.addParam = value
            else
                local attrType  =  self.data.attributeGrow
                local refAttrType    = self.data.attributeReference
                local referenceType  = self.data.referenceType  --1是基础值 2当前值
                local refTarget = self:getRefTarget()
                local value
                if referenceType == value_1 then
                    value = refTarget:getBaseValue(refAttrType)
                else
                    value = refTarget:getValue(refAttrType)
                end
                local ratio = self.data.ratio
                value = value*ratio*value_0point0001   --相对于初始属性？还是当前
                -- referenceTarget attributeReference  ratio
                value = value*addTimes
                value = math.floor(value)-- 取整
                value = self:fixValue(value)
                target:changeTempValue(attrType,value)
                self.addState = attrType
                self.addParam = value
            end

        elseif effectType == eBFEffectType.ET_REDUCE_SKILL_CD then -- 减少技能CD时间 (不可逆)
            local skillType = self.data.skillType
            local time      = self.data.cooldownChange
            local skills    = target:getSkillsByType(skillType)
            for i, skill in ipairs(skills) do
                skill:reduceCDTime(time)
            end
        elseif effectType == eBFEffectType.ET_SET_SKILL_CD then -- 设置技能CD上限
            local skillType = self.data.skillType
            local solecd      = self.data.solecd
            local fixed     = self.data.fixed
            local renovate = self.data.renovate
            local skills    = target:getSkillsByType(skillType)
            for i, skill in ipairs(skills) do
                skill:setCDControl(solecd,fixed,renovate)
            end
        elseif effectType == eBFEffectType.ET_SHARE_HURT then --伤害分担处理
            -- local state = self.data.effectState
            -- local team  = battleController.getTeam()
            -- if team then
            --     local heros  = team:getHerosEx()
            --     local _heros = {}
            --     for i, hero in ipairs(heros) do
            --         if self.host ~= hero then
            --             if hero:isAState(state) then
            --                 table.insert(_heros,hero)
            --             end
            --         end 
            --     end
            --     local heroSize = #_heros
            --     --本次受伤
            --     local value      = self.host:getValue(eAttrType.ATTR_REV_HURT)
            --     local shareRatio = self.host:getValue(eAttrType.ATTR_HURT_SHARE_RATIO)
            --     --每个伤害分摊的对象受到的伤害=（计算伤害*伤害分摊比率）/对象人数
            --     if heroSize > 0 then
            --         value = -math.floor(value*shareRatio*0.0001/heroSize)
            --         --处理分摊角色的伤害
            --         for i, hero in ipairs(_heros) do
            --             if hero:isAlive() then
            --                 target:changeHp(value,nil,self.host,true)
            --             end
            --         end
            --     end
            -- end
        elseif effectType == eBFEffectType.ET_CHANGE_CAMP then --修改阵营
            local camp  = self.data.camp
            target:setCamp(camp)
            if self.provideObj then 
                self.provideObj:changeValue(eAttrType.ATTR_CONFUSE_NUMS,1)
            end
        elseif effectType == eBFEffectType.ET_CHANGE_SKIN then --变换形态
            if target:canChangeSkin() then 
                self.addState = target:getFormId() --保存原形态ID
                local distortionId = self.data.distortionId
                target:changeSkinEx(distortionId ,self:getObjectID())
            end
        elseif effectType == eBFEffectType.ET_FORCE_CHANGE_SKIN then --强制变换形态
            self.addState = target:getFormId() --保存原形态ID
            local distortionId = self.data.distortionId
            target:changeSkinEx(distortionId ,self:getObjectID())
        elseif effectType == eBFEffectType.ET_MODEL_SCALE then --模型缩放
            local scale = self.data.modelscale*target:getSkeletonNodeScale()
            target:setSkeletonNodeScale(scale) 
        elseif effectType == eBFEffectType.ET_USE_SKILL then--使用技能
            local skillType = self.data.useSkillType
            target:castByType(skillType)
        elseif effectType == eBFEffectType.ET_EFFECT_UNABLED then--屏蔽指定效果
            local loseBuffEfferctId = self.data.loseBuffEfferctId
            for k,effectId in pairs(loseBuffEfferctId) do
                local effect = target:getBFEffect(effectId)
                if effect then
                    effect:setTakeEffect(false)
                end
            end
        end
    self.realAddTimes = self.realAddTimes + 1
    self:showEffectName()
    self:takeTimesAdd()
    self:onEventTakeEffect()
end

--移除叠加层数
function BFEffect:removeAddTimes(addTimes)
    self.nAddTimes = self.nAddTimes - addTimes
    self.realAddTimes = math.max(0, self.realAddTimes - addTimes)
    self:doIconEvent(eBufferEffectIconEvent.UPDATE_ADDTIMES)    
end

--移除效果处理
function BFEffect:removeEffect(addTimes)
    self.removeEffectIng = true
    print("移除效果处理....................",self.data.id)
    addTimes = addTimes or self.nAddTimes
    addTimes = math.min(addTimes,self.nAddTimes)
    if addTimes > 0 and self.realAddTimes > 0 then
        local objectType = self.data.objectType
        -- if objectType == eBFObjectType.OT_HERO then --作用于目标
            local target = self.host
            local effectType = self.data.effectType
            if effectType == eBFEffectType.ET_ATTR_CHANGE   then       -- 属性变化
                print(string.format("移除效果 attrType =%s , value=%s ,addTimes = %s",self.addState,self.addParam ,self.nAddTimes))
                if self.addState and self.addParam then
                    target:changeValue(self.addState,-self.addParam*addTimes)   --叠加了基层移除基层
                else
                    Box("移除效果错误A"..tostring(self.data.id))
                end
            elseif effectType == eBFEffectType.ET_STATE_CHANGE 
                or effectType == eBFEffectType.ET_STATE_CHANGE_RANDOM then       -- 状态移除
                print("移除效果 state=",self.addState)
                if self.addState then
                    target:delAState(self.addState,self:getObjectID())
                else
                    Box("移除效果错误B:"..tostring(self.data.id))
                end
            elseif effectType == eBFEffectType.ET_BUFFER_PRO_CHANGE then  --buffer 状态变更
            --修改自己存在buffer的概率
                local buffIds = self.data.changeId
                for _ , id in ipairs(buffIds) do
                    local buffer = self.host:getBuffer(id)
                    if buffer then
                        buffer:changeProbability(-self.data.probabilityNum)
                    end
                end
            elseif effectType == eBFEffectType.ET_CHANGE_CAMP then --修改阵营
                target:resetCamp() --重置为初始阵营
                if self.provideObj then 
                    self.provideObj:changeValue(eAttrType.ATTR_CONFUSE_NUMS,-1)
                end
            elseif effectType == eBFEffectType.ET_CHANGE_SKIN then --变换为原始形态
                if self.addState then 
                    target:recoverySkin(self:getObjectID())
                    self.addState = nil
                end
            elseif effectType == eBFEffectType.ET_FORCE_CHANGE_SKIN then --强制变换形态
                if self.addState then 
                    target:recoverySkin(self:getObjectID())
                    self.addState = nil
                end
            elseif effectType == eBFEffectType.ET_MODEL_SCALE then --模型缩放
                --还原
                local scale = target:getSkeletonNodeScale()
                scale = scale / self.data.modelscale
                target:setSkeletonNodeScale(scale) 
            elseif effectType == eBFEffectType.ET_TIMESCALE_CHANGE then
                local timeScale = self.data.timeScale
                if timeScale then  --TODO 配置0-100
                    target:changeSelfTimeScale(-timeScale*0.01*addTimes)
                end
            elseif effectType == eBFEffectType.ET_SET_SKILL_CD then -- 设置技能CD上限
                local skillType = self.data.skillType
                local skills    = target:getSkillsByType(skillType)
                for i, skill in ipairs(skills) do
                    skill:setCDControl(0)
                end
            elseif effectType == eBFEffectType.ET_EFFECT_UNABLED then--开放指定效果
                local loseBuffEfferctId = self.data.loseBuffEfferctId
                for k,effectId in pairs(loseBuffEfferctId) do
                    local effect = target:getBFEffect(effectId)
                    if effect then
                        effect:setTakeEffect(true)
                        effect:addTest()
                    end
                end
            end

        self:removeAddTimes(addTimes)
    end
    self.removeEffectIng = false
    -- 测试代码
    -- local effectIds = {1001}
    -- for i,effectId in ipairs(effectIds) do
    --     -- Box("--NEW EFFECT--"..effectId)
    --     self:_triggerNewEffects(effectId)
    -- end
end

--记录下添加的状态 或属性 方便移除的时候移除
--TODO 叠加并且 叠加以后生效的效果不一样的情况下会有问题




--属性参照对象(如果没有属性在参照对象即为值类型)
function BFEffect:getRefTarget()
    local referenceTarget = self.data.referenceTarget
    if referenceTarget == eBFRTargetType.RTT_TRIGGER then --buff触发对象
        return self.triggerObj
    elseif referenceTarget == eBFRTargetType.RTT_TARGET then --buff作用对象
        return self.host
    elseif referenceTarget == eBFRTargetType.RTT_PROV then --buff提供者
        return self.provideObj
    elseif referenceTarget == eBFRTargetType.RTT_EVENT_TAR then --状态对应方
        return self.receiveObj
    end
end


--TODO 扣除生效次数[生效次数用完是否需要移除效果?加参数控制]
function BFEffect:takeTimesAdd()
    if self.data.effectTimes == -1 then -- 无限次数生效
        return
    end
    self.nTakeTimes = self.nTakeTimes + 1
    if self.nTakeTimes >= self.data.effectTimes  then
        self:normalDestory()
    end
end

--持续时间计算
function BFEffect:handlDuration(dt)
    if self.data.duration == -1 then --永久
        return
    end
    if self.nDuration > 0 then
        -- _print("handlDuration "..self.data.id.." ,"..self.nDuration )
        self.nDuration = self.nDuration - dt
        if self:isTwinkleTime() then -- 小于3秒闪提示icon闪所
            self:twinkleIcon(true)
        else
            self:twinkleIcon(false)
        end
        if self.nDuration <= 0 then
            self:normalDestory()
        end
    end
end

function BFEffect:getSuplusTime()
    if self.nDuration > 0 then
        return self.nDuration
        -- local time = 0
        -- if self.sysStopTime > 9999 then
        --     time = BattleUtils.gettime() - self.sysStopTime
        -- end
        -- return math.max(self.nDuration - (BattleUtils.gettime() - self.sysStartTime - time),0)
    end
    return 0
end


function BFEffect:addToMgr()
    self:doIconEvent(eBufferEffectIconEvent.ADD)--添加
    self.host:addBFEffect(self)
    self.bEnabled = true
end
--移除自己
function BFEffect:removeSelf()
    if self.data.endEffectList and #self.data.endEffectList > 0 then 
        if self.host:getActor() then 
            self.host:getActor():createBufferEffects(self.data.endEffectList)
        end
    end
    self:doIconEvent(eBufferEffectIconEvent.REMOVE) --移除
    self:releaseRenderNode()
    self.bEnabled = false
    self.host:removeBFEffect(self)
    if self.data.coverId > 0 then
        self.host:checkEffectTake(self)
    end
end
--重置到非激活状态
function BFEffect:reset()

end

function BFEffect:getObjectID()
    return self.id
end

--技能特效特效移除终止
function BFEffect:onSkillEffectRemove(effectNode)
    -- _print("effect :"..effectNode:getObjectID().." will be remove ~")
    -- Box("aaa")
    if self:isVaildStopModel(eBFStopMode.SM_RMOVE_SKILL_EFFECT) then
        if self.effectNode  == effectNode then
            self:condDestory()
        end
    end
end

--状态移除
function BFEffect:onStateRemoveTrigger(source,event)
    -- if not self.bEnabled  then
    --     return
    -- end
    --保证事件触发对象和生效对象是同一个角色
    if source ~= self.host then
        return
    end
    if self.removeEffectIng then
        return
    end
    if self:isVaildStopModel(eBFStopMode.SM_RMOVE_STATE) then
        if self.data.stopStateId == event then --指定的移除状态
            self:condDestory()
        end
    end
end

--多时间终止的情况下计算终止事件的索引
function BFEffect:stopEventIndex(event)
    for index, v in ipairs(self.data.stopEventId) do
        if v == event then 
            return index
        end
    end
    return -1
end

--事件触发
function BFEffect:onEventTrigger(source,event,target)
    if not self:isEnabled()  then
        return
    end
    --保证事件触发对象和生效对象是同一个角色
    -- _print("onEventTrigger" ..tostring(source ~= self.host ),
        -- self.data.id,
        -- self.data.stopMode,
        -- self.data.stopEventId ,event)
    if source ~= self.host then
        return
    end
    -- 事件次数终止
    if self:isVaildStopModel(eBFStopMode.SM_EVENT_TRIGGER) then
        -- _print("xxx1")

        local index = self:stopEventIndex(event)
        if index > 0 then
                -- _print("xxx22" ..self.data.stopEventId , event)
            self.nEventTriggerTimes[index] = self.nEventTriggerTimes[index] or 0
            self.nEventTriggerTimes[index] = self.nEventTriggerTimes[index] + 1
            if self.nEventTriggerTimes[index]  >= self.data.eventTimes[index] then
                self:condDestory()
            end
        end
    end
end

--生效触发事件
function BFEffect:onEventTakeEffect()
    if self:isVaildStopModel(eBFStopMode.SM_TAKE) then
        self:condDestory()
    end
end

function BFEffect:onAttrTrigger(source,attrType,changeValue)
    if  not self:isEnabled()  then
        return
    end
    --保证事件触发对象和生效对象是同一个角色
    if source ~= self.host then
        return
    end
    if self.removeEffectIng then
        return
    end
    -- _print(string.format("___________onAttrTrigger(%s,%s)",attrType,value),self.data.stopMode)
    -- _print("eBFStopMode.SM_ATTR_CHANGE",eBFStopMode.SM_ATTR_CHANGE)
    ---终止条件判断
    if self:isVaildStopModel(eBFStopMode.SM_ATTR_CHANGE) then
        -- if self.data.stopMode == 4 then

        local checkAttribute = self.data.checkAttribute
        local checkResult  = self.data.checkResult
        local checkNum   = self.data.checkNum
        -- _print(">>>>>>>>>>>>>>>>>>",checkAttribute,checkResult,checkNum)
        if self:matchAttrType(attrType,checkAttribute)then
            local value = self.host:getValue(checkAttribute)
            if checkResult == 1 then --高于配置值
                if value > checkNum then
                    self:condDestory()
                end
            elseif checkResult == 2 then  --低于配置值
                if value < checkNum then
                    self:condDestory()
                end
            elseif checkResult == 3 then -- 等于   
                if value == checkNum then
                    self:condDestory()
                end
            elseif checkResult == 4 then -- 不等于
                if value ~= checkNum then
                    self:condDestory()
                end
            end
        end
    end
end

function BFEffect:matchAttrType(_attrType , attrType)
    if _attrType == attrType then
        return true
    elseif attrType == eAttrType.ATTR_NOW_HP or attrType == eAttrType.ATTR_MAX_HP  then
        if attrType == eAttrType.ATTR_LOASS_HP                     -- 当前失血量
        or attrType == eAttrType.ATTR_NOW_HP_PERCENT               -- 当前血量百分比
        or attrType == eAttrType.ATTR_LOASS_HP_PERCENT then        -- 当前血量损失的百分比
            return true
        end
    end
end


--检查终止模式
function BFEffect:isVaildStopModel(stopModel)
    --TODO stopMode修改为数组
    for i, v in ipairs(self.data.stopMode) do
        if v == stopModel then 
            return true
        end
    end
end

----正常终止 (1 ,--移除叠加次数和 2 ,--只移除效果对象 不对效果做任何处理
function BFEffect:normalDestory()
    if self.data.stopContent == eBFERemoveType.RT_REMOVE_ALL then
        self:removeEffect()
    end
    self:removeSelf()
end

--强制移除效果(角色死亡时)
function BFEffect:forceDestory()
    -- 效果不移除了
    -- if self.data.stopContent == eBFERemoveType.RT_REMOVE_ALL then
    --     while self.nAddTimes > 0 do 
    --         self:removeEffect()
    --     end
    -- end
    self:doIconEvent(eBufferEffectIconEvent.REMOVE) --移除
    self:releaseRenderNode()
    self.bEnabled = false
end


--特殊条件判断终止
function BFEffect:condDestory()
    if not self:isEnabled() then
        return
    end
    local otherContent = self.data.otherContent
    -- _print("_______otherContent",otherContent)
    if otherContent == eBFERemoveType.RT_NONE then
        return
    elseif otherContent == eBFERemoveType.RT_REMOVE_ME then
        self:removeSelf()
    elseif otherContent == eBFERemoveType.RT_REMOVE_ALL then
        self:removeEffect()
        self:removeSelf()
    elseif otherContent == eBFERemoveType.RT_REMOVE_ADDTIMES then
        self:removeEffect(self.data.decreaseSuperposition)
        if self.nAddTimes <= 0 then
            self:removeSelf()
        end
    end
end


--创建渲染节点
function BFEffect:createRenderNode()
-- resource    action  mount
-- printError("createRenderNode",self.data.resource)

    --创建第一次生效的触发特效
    if self.data.beginEffectList and #self.data.beginEffectList > 0 then 
        if self.host:getActor() then
            self.host:getActor():createBufferEffects(self.data.beginEffectList)
        end
    end
    if self.skeletonNodes then 
        return 
    end
    self.skeletonNodes = {}
    if self.host:getActor() then
        local scale      = BattleConfig.MODAL_SCALE * self.host:getSkeletonNodeScale()
        local cameraMask = self.host:getActor():getCameraMask()
        if self.provideObj  then
            local formId = self.provideObj:getFormId() 
            if self.data.effectList and #self.data.effectList > 0 then
                for i, resId in ipairs(self.data.effectList) do
                    local data = TabDataMgr:getData("BufferEffectList",resId)
                    if data.heroFormId == formId then
                        local renderNode = ResLoader.createEffect(data.resource,scale,true)
                        renderNode.mount = data.mount
                        renderNode.effectsDir = data.effectsDir
                        local scaleX = math.abs(renderNode:getScaleX())
                        if renderNode.effectsDir == 1 then --固定向右
                            renderNode:setScaleX(scaleX)
                        elseif renderNode.effectsDir == 2 then --固定向左 
                            renderNode:setScaleX(-scaleX)
                        end
                        local cameraMask = cameraMask
                        renderNode:setCameraMask(cameraMask)
                        table.insert(self.skeletonNodes,renderNode)
                        self.host:getActor():addChild(renderNode,data.zorder)
                        renderNode:play(data.action, 1)
                        return
                    end
                end
            end
        end

        for index = 1,2 do
            local resource = self.data["resource"..index]
            local action   = self.data["action"..index]
            local mount    = self.data["mount"..index]
            local zorder   = self.data["zorder"..index]

            if ResLoader.isValid(resource) then
                local renderNode = ResLoader.createEffect(resource,scale,true)
                renderNode.mount = mount
                renderNode.effectsDir = 0 --默认跟随角色方向
                renderNode:setCameraMask(cameraMask)
                table.insert(self.skeletonNodes,renderNode)
                self.host:getActor():addChild(renderNode,zorder)
                renderNode:play(action, 1)
            end
        end
    end
end




function BFEffect:releaseRenderNode()
    if self.skeletonNodes then 
        for i, skeletonNode in ipairs(self.skeletonNodes) do
            if skeletonNode.resPath then
                ResLoader.addCacheSpine(skeletonNode,skeletonNode.resPath)
            end
            skeletonNode:removeFromParent()
        end
        self.skeletonNodes = nil
    end
end

--效果叠加到一层数触发效果
--触发新效果后移除自己

function BFEffect:tryTriggerNewEffect()
    if self.data.superpositionEffective == 1 then
        -- Box("AAAAAAA  "..self.nAddTimes.." "..self.data.superpositionNum .." "..self.data.probability)
        if self.nAddTimes >= self.data.superpositionNum then
            if BattleUtils.triggerTest10000(self.data.probability) then
                local effectIds = self.data.newEffectIds
                for i,effectId in ipairs(effectIds) do
                    -- Box("--NEW EFFECT--"..effectId)
                    self:_triggerNewEffects(effectId)
                end
                return true
            end
        end
    end

end

function BFEffect:tryTriggerNewEffect_before()
    if self.data.superpositionEffective == 2 then
        -- Box("AAAAAAA  "..self.nAddTimes.." "..self.data.superpositionNum .." "..self.data.probability)
        if self.nAddTimes >= self.data.superpositionNum then
            if BattleUtils.triggerTest10000(self.data.probability) then
                local effectIds = self.data.newEffectIds
                for i,effectId in ipairs(effectIds) do
                    -- Box("--NEW EFFECT--"..effectId)
                    self:_triggerNewEffects(effectId)
                end
                return true
            end
        end
    end

end



--效果的生效对象(这和buffer 实现不不一样)
function BFEffect:getTakeTarget(data)

    local effectTarget = data.effectTarget
    if data.objectType == 1 then  --作用予单位
        if effectTarget == eBFTargetType.TT_ME then --自己（buff提供者）
            return {self.provideObj}
        elseif effectTarget == eBFTargetType.TT_TRIGGER then --buff触发对象
            return {self.host}
        elseif effectTarget == eBFTargetType.TT_EVENT_SRC then --状态来源方
            -- return {self:getTriggerTar()}
            Box("新效果不支持的类型"..tostring(effectTarget))
            return {}
        elseif effectTarget == eBFTargetType.TT_EVENT_TAR  then --状态对应方(状态目标)
            -- return {self:getEventTar()}
            Box("新效果不支持的类型"..tostring(effectTarget))
            return {}
        elseif effectTarget == eBFTargetType.TT_FRIENT  then --队友
            local targerts = self.provideObj:getAreaFrineds(-1)
            if data.targetID == 0 then
                return targerts
            end
            for i,v in ipairs(targerts) do
                if v:getData().id == data.targetID then 
                    return {v}
                end
            end
            return {}
        elseif effectTarget == eBFTargetType.TT_ENEMY  then --敌人
            return self.provideObj:getAreaEnemys(-1)
        elseif effectTarget == eBFTargetType.TT_FRIENT_TEAM  then --队友包涵自己
            return self.provideObj:getAreaFrineds(-1,nil,true)
        elseif effectTarget == eBFTargetType.TT_FRIENT_HERO then --友方 角色 
            local heros = self.provideObj:getAreaFrineds(-1,nil,true)
            local result = {}
            for i,hero in ipairs(heros) do
                local roleType = hero:getRoleType() 
                if roleType == eRoleType.Hero 
                or roleType == eRoleType.Assist
                or roleType == eRoleType.Team then 
                    table.insert(result,hero)
                end
            end
            return result
        elseif effectTarget == eBFTargetType.TT_FRIENT_MONSTER then --友方 怪
            local heros = self.provideObj:getCalls(-1,nil,1)
            local result = {}
            for i,hero in ipairs(heros) do
                table.insert(result,hero)
            end
            return result
        end
    else --不支持作用于范围 
        Box("不支持作用范围")
    end
end

function BFEffect:_triggerNewEffects(effectId)
    local data  = TabDataMgr:getData("BufferEffect",effectId)
    local takeObjs = self:getTakeTarget(data)
    for i, takeObj in ipairs(takeObjs) do
        if not data.effectPosition then  --false 时必须出战才能生效
            if not takeObj:isFight() then
                return
            end
        end
        self:_triggerNewEffect(data,takeObj)
    end
end

function BFEffect:checkAttrChangeState(takeObj,data)
    if data.attributeGrow and data.attributeGrow > 0 and (data.effectNum < 0 or data.ratio < 0) then
        if data.statestrike and #data.statestrike > 0 then
            for i,state in ipairs(data.statestrike) do
                if takeObj:isAState(state) then
                    return false
                end
            end
        end
    end
    return true
end

function BFEffect:_triggerNewEffect(data,takeObj)
    --免疫负面效果
    if takeObj:isAState(eAState.E_MIANYI_DBUFF) then
        if data.benefitType >= 2 then
            return
        end
    end

   --免疫减少属性的效果
    if takeObj:isAState(eAState.E_MIANYI_ATTR_DEBUFF) then
        if data.attrDebuff then
            return
        end
    end

    --受目标状态影响
    if not self:checkAttrChangeState(takeObj,data) then
        return
    end

    if not self:checkEffectCondition(takeObj, data) then
        return
    end
    
    _print("trigger new effect ...",data.id)
    local effectId = data.id
    if data.superpositionType == eBFAddType.AT_ADD1 then --完全叠加 各自生效
        --检查是都达到最大叠加层数
        local times  = takeObj:getBFEffectAddTimes(effectId)
        print("完全叠加各自生效",data.id , "已经叠加", times)
        if times < data.maxSuperposition or data.maxSuperposition == -1 then
            local effect = BFEffect:new(data)
            effect:bind(takeObj,self.provideObj,self.triggerObj,self.receiveObj)
            effect:addTest()
        else
            print("已达到最大叠加层数")
        end
    elseif data.superpositionType == eBFAddType.AT_NONE then --不能叠加
        print("不能叠加的效果",data.id)
        local effect = takeObj:getBFEffect(effectId)
        if not effect then
            effect = BFEffect:new(data)
            effect:bind(takeObj,self.provideObj,self.triggerObj,self.receiveObj)
            effect:addTest()
        end
    elseif data.superpositionType == eBFAddType.AT_REPLACE then --替换
        print("替换型效果",data.id)
        local effect = takeObj:getBFEffect(effectId)
        if not effect then
            effect = BFEffect:new(data)
            effect:bind(takeObj,self.provideObj,self.triggerObj,self.receiveObj)
            effect:addTest()
        else --效果替换处理
            effect:bind(takeObj,self.provideObj,self.triggerObj,self.receiveObj)
            effect:replace()
        end
    elseif data.superpositionType == eBFAddType.AT_ADD2 then --效果叠加 时间公用
        print("效果叠加效过",data.id)
        --叠加和生效效果处理
        local effect = takeObj:getBFEffect(effectId)
        if effect then
            effect:bind(takeObj,self.provideObj,self.triggerObj,self.receiveObj)
            --处理叠加
            effect:addTest()
        else
            --还未有生效的buf
            effect = BFEffect:new(data)
            effect:bind(takeObj,self.provideObj,self.triggerObj,self.receiveObj)
            effect:addTest()
        end
    elseif data.superpositionType == eBFAddType.AT_ADD3 then --效果不叠 时间累加
        print("效果不叠加时间累加效果",data.id)
        --叠加和生效效果处理
        local effect = takeObj:getBFEffect(effectId)
        if effect then
            effect:bind(takeObj,self.provideObj,self.triggerObj,self.receiveObj)
            --处理叠加
            effect:addTestTime() --时间叠加
        else
            --还未有生效的buf
            effect = BFEffect:new(data)
            effect:bind(takeObj,self.provideObj,self.triggerObj,self.receiveObj)
            effect:addTest()
        end
    end




end

function BFEffect:checkEffectCondition(takeObj,data)
    local condition = data.effectCondition
    if condition and condition > 0 then
        local targets = {}
        if condition == eBFETakeCondition.TC_TARGET_FRIEND then
            table.insertTo(targets,self.provideObj:getAreaFrineds(-1,nil,true))
            table.insertTo(targets,self.provideObj:getCalls(-1,100,1))
        elseif condition == eBFETakeCondition.TC_TARGET_ENEMY then
            table.insertTo(targets,self.provideObj:getAreaEnemys(-1))
            table.insertTo(targets,self.provideObj:getCalls(-1,100,2))
        elseif condition == eBFETakeCondition.TC_TARGET_ALL then
            table.insertTo(targets,battleController.getTeam():getHerosEx())
        elseif condition == eBFETakeCondition.TC_TARGET_FRIEND_CALL then
            table.insertTo(targets,self.provideObj:getCalls(-1,100,1))
        elseif condition == eBFETakeCondition.TC_TARGET_ENEMY_CALL then
            table.insertTo(targets,self.provideObj:getCalls(-1,100,2))
        elseif condition == eBFETakeCondition.TC_TARGET_CALL then
            table.insertTo(targets,self.provideObj:getCalls(-1,100))
        end
        if data.bodyCount > 0 then
            local realTargets = {}
            if data.bodyType >= 0 then
                for i,v in ipairs(targets) do
                    if v:isActive() and v:getBodyType() == data.bodyType then
                        table.insert(realTargets, v)
                    end
                end
                return #realTargets >= data.bodyCount
            else
                for i,v in ipairs(targets) do
                    if v:isActive() then
                        table.insert(realTargets, v)
                    end
                end
                return #realTargets >= data.bodyCount
            end
        end
    end
    return true
end

--icon 显示事件
function BFEffect:doIconEvent(eventType)
    --当前控制的角色才和boss才需要显示icon
    if self.host:isMe() or self.host:isManual(true) or self.host:isBoss() then 
        if self:isShowIcon() then  -- 0为只生效一次的不需要显示icon
            EventMgr:dispatchEvent(eEvent.EVENT_BUFFER_EFFECT_ICON,self,eventType)
        end
    end
end

--是否显示icon
function BFEffect:isShowIcon()
    if self.data.duration ~= 0 then  -- 0为只生效一次的不需要显示icon
        if self.data.iconDisplay and ResLoader.isValid(self.data.icon) then
            return true
        end
    end
end

function BFEffect:isForever()
    return self.data.duration == -1
end
--icon 闪烁
function BFEffect:twinkleIcon(flag)
    if self.bTwinkleIcon == nil or self.bTwinkleIcon ~= flag then
        self.bTwinkleIcon = flag 
        self:doIconEvent(eBufferEffectIconEvent.TWINKLE)
    end
end
--是否到了闪烁倒计时时间段
function BFEffect:isTwinkleTime()
    return self.nDuration <= 3000 and self.nDuration ~= -1
end

--获取buffer 效果类型
function BFEffect:getEffectType()
    return self.data.effectType
end

function BFEffect:getEffectState()
    return self.data.effectState[1] or 0
end
--统计buffer 持有者的伤害
function BFEffect:checkHurtValue(target,value)
    if self.provideObj and value < 0 then 
        self.provideObj:addHurtValue(math.abs(value),target)
        battleController.setDamageData(self.provideObj, math.abs(value), nil, nil, self.bufferId)
    end
end

function BFEffect:getBindBufferId()
    return self.bufferId
end
return BFEffect