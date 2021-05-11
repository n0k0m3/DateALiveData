local levelParse   = import(".LevelParse")
local BattleUtils  = import(".BattleUtils" )
local BattleConfig = import(".BattleConfig" )
local ResLoader    = import(".ResLoader")
local BattleMgr    = import(".BattleMgr")
local enum         = import(".enum")
local effectMgr    = BattleMgr.getEffectMgr()
local selectTarget = import(".selectTarget")
local BattleTimerManager = import(".BattleTimerManager")
local eDir        = enum.eDir
local eEvent      = enum.eEvent
local eStateEvent = enum.eStateEvent
local eCameraFlag = enum.eCameraFlag
local eHurtType   = enum.eHurtType
local eBuffStateType = enum.eBuffStateType
local eHurtMoveType = enum.eHurtMoveType
local eEffectType = enum.eEffectType
local eState = enum.eState
local eAngerRule = enum.eAngerRule
local eArmtureEvent = enum.eArmtureEvent
local eHostType  = enum.eHostType
local eSelectType = enum.eSelectType
local eBFState    = enum.eBFState
local eAState     = enum.eAState
local eVKeyCode   = enum.eVKeyCode
local eAttrType   = enum.eAttrType
local eBFSkillEvent = enum.eBFSkillEvent
local eCampType   = enum.eCampType
local eHurtWay    = enum.eHurtWay
local eState      = enum.eState
local eMonsterType = enum.eMonsterType
local eSpecialType = enum.eSpecialType
local eShowState   = enum.eShowState
local eWithstandDir= enum.eWithstandDir
--障碍物管理器
local obstacleMgr = BattleMgr.getObstacleMgr()
local _print = print
local print = BattleUtils.print
local math   = math
local heroMgr = BattleMgr.getHeroMgr()

--[[
自己
最近的敌人
最远的敌人
随机敌人
无
--]]

local  eParent =
{

    CASTER    = 1,   -- 施法者
    TARGET    = 2,   -- 目标
    MAP       = 3,   -- 地图
    UI        = 4,   -- 显示在UI层
}

local eSkeletonScale = 
{
    UI = 0.6
}

local ePlace =
{
    NONE          = 0 , --(0,0)
    TARGET        = 1 , --目标位置
    CASTER_MOUNT  = 2 , --施法者骨骼
    CASTER        = 3 , --施法者位置
    TARGET_MOUNT  = 4 , --目标骨骼
    RANDOM        = 5 ,  -- 随机位置
    CASTER_MAP_CENTER = 7 ,  --施法者当前地图中心
    -- （0无1目标位置2施法者挂点位置）
}

--发射型特效
local eTailType =
{
    STRAIGHT       = 0 , --直线  （左右镜像）
    STEEP          = 1 , --跟踪
    ANGLE_STEEP    = 2 , --角度跟踪
    TARGET_POS     = 3 , --目标位置
    ROUND          = 4 , --环形飞行
    S_CURVE        = 5 , --S曲线前进
    REFRACTION     = 6 , --折射前进
    ANGLE          = 7 , --直线角度飞行（角度旋转）
    BEZIER         = 8 , --贝塞尔(目标位置)
    RANDOM_POS     = 9 , --直线目标位置
    BEZIER_POS     = 10 , --贝塞尔(根据速度和时间计算目标位置)
    BEZIER_RANDOM_POS  = 11 , --贝塞尔曲线随机位置
    TARGET_SHADOW_POS  = 12 , --目标影子位置
    BEZIER_POS_HIT     = 13 , --贝塞尔曲线检测碰撞
    TIMMER_FIND_POS     = 14 , --定时弹射指定位置

}


local eTriggerHostType =
{
    ACTION   = 1,  -- 动作触发
    EFFECT   = 2,  -- 特效触发
}
--牵引类型
local ePullType =
{
    NONE   = 0, --无迁移
    CENTER = 1, --中心点
    FIXED  = 2, --固定方向
    RECT_CENTER = 3, --范围中心
}
local function pGetAngle(self,other)
    local a2 = me.pNormalize(self)
    local b2 = me.pNormalize(other)
    local angle = math.atan2(me.pCross(a2, b2), me.pDot(a2, b2) )
    if math.abs(angle) < 1.192092896e-7 then
        return 0.0
    end
    return angle
end

local function randomValue( value )
    value = math.floor(math.abs(value)/3)
    return RandomGenerator.random(-value ,value)
end

local function randomValue2( value )
    value = math.floor(math.abs(value)/3)
    return RandomGenerator.random(-value ,0)
end

local powf = math.pow
local function bezierat(  a,  b,  c,  d,  t )

    return (powf(1-t,3) * a +
            3*t*(powf(1-t,2))*b +
            3*powf(t,2)*(1-t)*c +
            powf(t,3)*d )
end



local function pGetAngle(self,other)
    local a2 = me.pNormalize(self)
    local b2 = me.pNormalize(other)
    local angle = math.atan2(me.pCross(a2, b2), me.pDot(a2, b2) )
    if math.abs(angle) < 1.192092896e-7 then
        return 0.0
    end
    return angle
end


local Effect = class("Effect",function ()
	local node = CCNode:create()
    BattleMgr.bindActionMgr(node)
    return node
end)

function Effect:getObjectID()
    return self.id
end

--瞄准事件触发
function Effect:tryTriggerAIMEvent(damageType,target)
    local aimEvent = BattleUtils.getAimEvent(damageType)
    --通用瞄准
    self.srcHero:onEventTrigger(eBFState.E_AIM,target)
    target:onEventTrigger(eBFState.E_REV_AIM)
    self.srcHero:onEventTrigger(aimEvent,target)
end
--清理特效释放者的临时属性
function Effect:cleanTempProperty(target)
    self.srcHero:cleanTempProperty()
    if target then
        target:cleanTempProperty()
    end
end

--命中事件触发
function Effect:tryTriggerEvent(damageType,damageAttr,target,realHurtValue)
    --命中
    if not self.bTriggerHitEvent then
        self.bTriggerHitEvent = true
        --通用命中事件
        self.srcHero:onEventTrigger(eBFState.E_HITED,target)
        self.hitEvent = true
        local event = BattleUtils.getHitEvent(damageType)
        if event then
            self.srcHero:onEventTrigger(event,target)
        end

    end
    --制造属性伤害
    local doHurtAttrEvent = BattleUtils.getDoHurtAttrEvent( damageAttr )
    self.srcHero:onEventTrigger(doHurtAttrEvent,target)



    --受击事件
    self.triggerRevHitEvents = self.triggerRevHitEvents or {}
    local objId = target:getObjectID()
    if not self.triggerRevHitEvents[objId] then
        self.triggerRevHitEvents[objId] = true
        --通用受击
        target:onEventTrigger(eBFState.E_REV_HIT,self.srcHero)
        local event = BattleUtils.getRevHitEvent(damageType)
        if event then
            target:onEventTrigger(event,self.srcHero)
        end
    end

    --伤害事件
    local hurtEvent = BattleUtils.getHurtEvent(damageType)
    self.srcHero:onEventTrigger(hurtEvent,target)
    self.srcHero:onEventTrigger(eBFState.E_HURT,target)
    --受到伤害
    local revHurtEvent = BattleUtils.getRevHurtEvent(damageType)
    target:onEventTrigger(revHurtEvent,self.srcHero)
    local revHurtAttrEvent = BattleUtils.getRevHurtAttrEvent(damageAttr)
    target:onEventTrigger(revHurtAttrEvent,self.srcHero)

    target:onEventTrigger(eBFState.E_REV_HURT,self.srcHero)

    --真实受伤事件
    if realHurtValue and realHurtValue < 0 then
        target:onEventTrigger(eBFState.E_REV_REAL_HURT,self.srcHero)
    end  

    --目标背击事件
    if self:isHitBack(target) then
        -- _print("产生背击")
        target:onEventTrigger(eBFState.E_REV_BACK_HURT,self.srcHero)
    end
end

function Effect:createLine()
    if BattleConfig.SHOW_HITBOX then
        if not self.drawNode  then
            self.drawNode = TFDrawNode:create()
            EventMgr:dispatchEvent(eEvent.EVENT_EFFECT_ADD_TO_LAYER,self.drawNode,3)
        end
    end
end

function Effect:createDebugInfo()
    if BattleConfig.SHOW_HITBOX then
        if self.effectData.hurtWay ~= 0 then
            local node =  self.shadow or self
            local scale = node:getScaleY()
            self.textPos = TFLabel:create()
            self.textPos:setText("[0,0,0]")
            self.textPos:setFontSize(18)
            self.textPos:setPosition(ccp(0,20))
            self.textPos:setAnchorPoint(ccp(0.5,0.5))
            self.textPos:setFontColor(ccc3(255,0,0))
            node:addChild(self.textPos,999)

            local minV = self.effectData.yRoller[2]
            local maxV = self.effectData.yRoller[1]

            self.textLineTop = TFLabel:create()
            self.textLineTop:setText("-------------------"..maxV.."-------------------")
            self.textLineTop:setFontSize(18)
            self.textLineTop:setPosition(ccp(0,maxV))
            self.textLineTop:setAnchorPoint(ccp(0.5,0.5))
            self.textLineTop:setFontColor(ccc3(255,255,0))
            node:addChild(self.textLineTop,1000)

            self.textLineBottom = TFLabel:create()
            self.textLineBottom:setText("-------------------"..maxV.."-------------------")
            self.textLineBottom:setFontSize(18)
            self.textLineBottom:setPosition(ccp(0,-minV))
            self.textLineBottom:setAnchorPoint(ccp(0.5,0.5))
            self.textLineBottom:setFontColor(ccc3(255,255,0))
            node:addChild(self.textLineBottom,1000)
            local cameraMask = node:getCameraMask()
            self.textPos:setCameraMask(cameraMask)
            self.textLineTop:setCameraMask(cameraMask)
            self.textLineBottom:setCameraMask(cameraMask)
        end
    end
end
function Effect:destoryLine()
    if BattleConfig.SHOW_HITBOX then
        if self.drawNode  then
             self.drawNode:removeFromParent()
             self.drawNode = nil
        end
    end
end

--
function Effect:drawNodeClear()
    if BattleConfig.SHOW_HITBOX then
        if self.drawNode then
            self.drawNode:clear()
        end
    end
end

--创建气泡文字
function Effect:createText()
    local bubble  = self.effectData.bubble 
    if bubble and bubble > 0 then
        local colorValue = self.effectData.bubbleColor or {}
        local offsetPos  = self.effectData.bubbleOffsetPos or {}
        local position   = ccp(offsetPos[1] or 0,offsetPos[2] or 0)
        local color      = me.c3b( colorValue[1] or 255 ,colorValue[2] or 255 ,colorValue[3] or 255 )
        self.text = TFLabel:create()
        self.text:setFontName("font/fangzheng_zhunyuan.ttf")
        self.text:setAnchorPoint(ccp(0.5,0.5))
        self.text:setFontSize(18)
        self.text:setFontColor(color)
        self.text:setPosition(position) 
        self.text:setTextById(bubble)
        self:addChild(self.text,999999)
    end
end


--创建粒子特效
function Effect:createParticles()
    local  particleEffect = self.effectData.particleEffect
    if particleEffect and #particleEffect > 0 then 
        self.particleNodes = self.particleNodes or {}
        for k, id  in ipairs(particleEffect) do
            local particleNode = BattleUtils.createParticle(id)
            local zorder  = particleNode._data.zorder
            --特效层级(0在所有角色下层，1在所有人物上层，2根据地图Y值排序)
            if zorder == 0 then 
                EventMgr:dispatchEvent(eEvent.EVENT_EFFECT_ADD_TO_LAYER,particleNode ,1)
            elseif zorder == 1 then 
                EventMgr:dispatchEvent(eEvent.EVENT_EFFECT_ADD_TO_LAYER,particleNode ,3)
            elseif zorder == 2 then 
                EventMgr:dispatchEvent(eEvent.EVENT_EFFECT_ADD_TO_LAYER,particleNode)
            else
                EventMgr:dispatchEvent(eEvent.EVENT_EFFECT_ADD_TO_LAYER,particleNode)
                dump(particleNode._data)
                Box("粒子Zorder配置错误:"..tostring(id).."->"..tostring(zorder))
            end
            table.insert(self.particleNodes,particleNode) 
        end
    end
end

--更新粒子位置
function Effect:updateParticle()
    if self.particleNodes then 
        for i,particleNode in ipairs(self.particleNodes) do
            local data     = particleNode._data
            local position = self:getBonePosition(data.mount)
            particleNode:setPosition(position)
            --
            particleNode:_setDir(self:getDir())
        end
    end
end

--移除粒子
function Effect:releaseParticle()
    if self.particleNodes then
        for i, particleNode in ipairs(self.particleNodes) do
            particleNode:removeFromParent()
        end
        self.particleNodes = nil
    end
end

function Effect:drawLine(rect,rollerType)
    if BattleConfig.SHOW_HITBOX then
        if self.drawNode then
            -- self.drawNode:clear()
            if rollerType == 1 or rollerType == 2  then
                local pts = clone(rect)
                pts[#pts+1] = pts[1]
                for i = 1, #pts - 1 do
                    self.drawNode:drawLine(pts[i], pts[i + 1], ccc4(0, 1, 0, 1))
                end
            else
                local origin = rect.origin
                local size   = rect.size
                local  pts   = {  origin,
                                me.p(origin.x ,origin.y + size.height),
                                me.p(origin.x + size.width,origin.y + size.height),
                                me.p(origin.x + size.width,origin.y ),
                                origin
                               }
                for i = 1, #pts - 1 do
                    self.drawNode:drawLine(pts[i], pts[i + 1], ccc4(1, 0, 0, 1))
                end
            end
        end
    end
end

function Effect:ctor(data)
    -- _print("create effect data ID:", data.id,"objectId:",self.id)
    -- print("EFFCT CTOR",data)
	self.effectData   = data
	self.skeletonNode = nil
    self.srcHero      = nil --施法者
    --伤害事件记数
    self.eventCount = {}
    self.eventCount.hurt  = 0
    self.eventCount.music = 0
    self.nTime = 0
    --特效地面位置
    self.position3D    = me.Vertex3F(0,0,0)
    self:addMEListener(TFWIDGET_EXIT,  handler(self._onExit,self))
    self:addMEListener(TFWIDGET_ENTER, handler(self._onEnter,self))
    self.objectIds = {}
    --命中记数器
    self.nHitCount = 0
    self.hitedBdboxs = {}
    self.soundEffects = {}
    self._limitDis = 4
end

--命中记数
function Effect:addHitCount()
    self.nHitCount = self.nHitCount + 1
    if self.effectData.totalTime > 0 then
        if self.effectData.addTime > 0 then
            self.effectData.totalTime = self.effectData.totalTime + self.effectData.addTime
            self.effectData.totalTime = math.min(self.effectData.totalTime,self.effectData.addtimeLimit)
        end
    end
end

function Effect:isValidObject(id)
    for i, v in ipairs(self.objectIds) do
        if v == id then
            return true
        end
    end
    return false
end

--回收特效
function Effect:playConnectEffect()
    if self.srcHero:isDead() then
        return
    end
    local effectIds = self.effectData.connectEffect
    for i,effectId in ipairs(effectIds) do
        if effectId ~= 0 then --0表示不存在的特效
            local effectData = BattleDataMgr:getEffectData(effectId,self.srcHero:getAngleDatas())
            if effectData then
                Effect.create(effectData,self.srcHero,eTriggerHostType.EFFECT,self)
            end
        end
    end
end

--触发新特效
function Effect:createNewEffect(effectId)
    if self.bPreRemove then 
        return 
    end
    if self.srcHero:isDead() then
        return
    end
    if effectId > 0 then
        local effectData = BattleDataMgr:getEffectData(effectId,self.srcHero:getAngleDatas())
        if effectData then
            Effect.create(effectData,self.srcHero,eTriggerHostType.EFFECT,self)
        end
    end
end
function Effect:releaseSkeletonNode()
    if self.skeletonNode then
        _print("释放特效:"..self.skeletonNode.resPath)
        -- self.skeletonNode:removeMEListener(TFARMATURE_EVENT)
        -- self.skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
        ResLoader.addCacheSpine(self.skeletonNode,self.skeletonNode.resPath)
        self.skeletonNode:removeFromParent(true)
        self.skeletonNode = nil
    end
end


--特效回收触发
function Effect:_onExit()
    -- print("Effect",self.id,"_onExit")
    --TODO 特定的特效检查移除事件
    if self.effectData.grabEndType == 0 then --抓取状态随特效结束而结束 
        self:onGraspEnd()
    end
    self:releaseParticle()
    self:stopSoundEffect()
    if self.hostType == eTriggerHostType.EFFECT then
        if self.parentNode then
            self.parentNode:release()
        end
    end
    heroMgr:walk(function(hero)
        hero:onSkillEffectRemove(self)
    end)
    if self.effectData.useMask > 0 then
        EventMgr:dispatchEvent(eEvent.EVENT_MAP_MASK,false)
    end
    self:destoryLine()
    effectMgr:remove(self)
end
function Effect:_onEnter()
    -- print("Effect",self.id,"_onEnter")
    effectMgr:add(self)
    if effectMgr:isPause() then
        self:pause()
    end
    if self.effectData.useMask > 0 then
        EventMgr:dispatchEvent(eEvent.EVENT_MAP_MASK,true)
    end
    self:createLine()
end

function Effect:pause()
    if self.skeletonNode then
        self.skeletonNode:stop()
    end
end

function Effect:resume()
    if self.skeletonNode then
        self.skeletonNode:resume()
    end
end

--用于排序(地图的位置)
function Effect:getSortY()
    return self.position3D.y
end


--目标选择
function Effect:selectTarget(hero)
    hero = hero or self.srcHero
    local target       = 2 --找敌方
    local area         = self.effectData.area
    local selectNumber = self.effectData.selectNumber
    local selectType   = self.effectData.effectTarget 
    if selectType == 0 then 
        selectType = 8
    end
    return selectTarget.selectTarget(hero,target,area,selectNumber,selectType)
end

--目标选择随在空气墙里面的位置
function Effect:randomTarPos(checkDir)
    local pos  = self.srcHero:getPosition()
    local area = self.effectData.area
    local rect = me.rect( area[1], area[2], area[3], area[4])
    if checkDir then 
        local dir =  self.srcHero:getDir() 
        if dir == eDir.LEFT then 
            rect.origin.x = -(rect.size.width + rect.origin.x)
        end
    end
    rect.origin = me.pAdd(pos,rect.origin)
    pos = levelParse:randomPos(rect)
    return pos
end

function Effect:selectNearlyTarget()
    local target = 2
    local team = battleController.getTeam()
    local heros = team:getMenbers_(self.srcHero:getCamp(),target)
    local targetHeros = {}
    for k,targetHero in pairs(heros) do
        local posx1 = self:getPosition()
        local posx2 = targetHero:getPosition3D()
        targetHero._tmp = me.pGetDistance(posx1,posx2)
        table.insert(targetHeros, targetHero)
    end
    table.sort(targetHeros,function ( a ,b )
        return a._tmp < b._tmp
    end)
    return targetHeros[1]
end

--找到所有目标
function Effect:getAllTarget()
    if self.effectData.target == 1 then
        return self.srcHero:getAreaFrineds(-1)
    elseif self.effectData.target == 2 then
        return battleController.getTeam():getHerosEx()
    elseif self.effectData.target == 3 then
        return {self.srcHero}
    elseif self.effectData.target == 4 then
        return self.srcHero:getAreaFrineds(-1,nil,true)
    end
    return self.srcHero:findTargets()
end

function Effect:getRelativeBonePosition(boneName)
    if self.skeletonNode then
        local  pos    = self.skeletonNode:getBonePosition(boneName)
        local scaleX  = self.skeletonNode:getScaleX()
        local scaleY  = self.skeletonNode:getScaleY()
        pos.x = pos.x*scaleX
        pos.y = pos.y*scaleY
        return pos
    end
    return ccp(0,0)
end

function Effect:getBonePosition(boneName)
    local position = self:getWorldPosition()
    local pos      = self:getRelativeBonePosition(boneName)
    return me.pAdd(position, pos)
end

function Effect:_fixPosition_()

    local _position3D = clone(self.position3D)
    _position3D.y = _position3D.z
    if not battleController.canMove(_position3D.x ,_position3D.y) then
        self:fixNearPosition(_position3D)
        if not battleController.canMove(_position3D.x ,_position3D.y) then --休整以再检查是否在一定区域
            local size = levelParse:getBlockSize()
            local index = 0
            while true do 
                index = index + 1
                                    -- print_("wo cao grasp fix position warning foreach index:"..tostring(index))
                if index > 50 then 
                    Box("wo cao grasp fix position warning foreach index:"..tostring(index))
                end
                if battleController.canMove(_position3D.x - index *size ,_position3D.y) then 
                    _position3D.x = _position3D.x - index *size
                    break
                elseif battleController.canMove(_position3D.x + index *size ,_position3D.y) then 
                    _position3D.x = _position3D.x + index *size
                    break
                elseif battleController.canMove(_position3D.x  ,_position3D.y + index *size) then
                    _position3D.y = _position3D.y + index *size
                    break
                elseif battleController.canMove(_position3D.x  ,_position3D.y - index *size) then
                    _position3D.y = _position3D.y - index *size
                    break
                elseif battleController.canMove(_position3D.x - index *size ,_position3D.y - index *size) then
                    _position3D.x = _position3D.x - index *size
                    _position3D.y = _position3D.y - index *size
                    break
                elseif battleController.canMove(_position3D.x + index *size ,_position3D.y - index *size) then
                    _position3D.x = _position3D.x + index *size
                    _position3D.y = _position3D.y - index *size
                    break

                elseif battleController.canMove(_position3D.x - index *size ,_position3D.y + index *size) then
                    _position3D.x = _position3D.x - index *size
                    _position3D.y = _position3D.y + index *size
                    break
                elseif battleController.canMove(_position3D.x + index *size ,_position3D.y + index *size) then
                    _position3D.x = _position3D.x + index *size
                    _position3D.y = _position3D.y + index *size
                    break
                end
            end
        end
    end
    _position3D.z = _position3D.y
    self.position3D = _position3D
end

function Effect:fixNearPosition(pos)
    -- dump(pos)
    local rect = levelParse:getMoveRect()
    if pos.x < rect.origin.x then 
        pos.x = rect.origin.x + BattleConfig.SPACE_AIRWALL + 1
    elseif pos.x > rect.origin.x + rect.size.width then
        pos.x = rect.origin.x + rect.size.width - BattleConfig.SPACE_AIRWALL - 1 
    end

    if pos.y < rect.origin.y then 
        pos.y = rect.origin.y + 10
    elseif pos.y > rect.origin.y + rect.size.height then
        pos.y = rect.origin.y + rect.size.height -10
    end
    -- dump(rect)
    -- dump(pos)
    -- print_("-----------------------fixNearPosition--------------------------")
end

--x/z 渲染位置
function Effect:setPosition3D(x,y,z)
    if x then
        self.position3D.x = x 
    end
    if y then
        self.position3D.y = y 
    end
    if z then
        self.position3D.z = z 
    end
    self:setPosition(self.position3D.x,self.position3D.z)

end

function Effect:setPositionX(x)
    self.position3D.x = x 
    self:setPosition(self.position3D.x,self.position3D.z)
end

function Effect:setPositionY(y)
    self.position3D.y = y 
end

function Effect:setPositionZ(z)
    self.position3D.z = z
    self:setPosition(self.position3D.x,self.position3D.z)
end
--影子的位置
function Effect:getPosition3D()
    return self.position3D
end

function Effect:initialPos(tarHero)
    local host = self.parentNode
    local place = self.effectData.place
    --虚拟位置
    local parent = self.effectData.parent
    if place == ePlace.NONE then --(0,0)
        -- self:setPosition(0,0)
    elseif place == ePlace.RANDOM then --(0,0)
        local position = self:randomTarPos()
        self:setPosition3D(position.x , position.y , position.y)
    elseif place == ePlace.TARGET then --目标位置
        if tarHero then
            local position = tarHero:getPosition()
            self:setPosition3D(position.x , position.y , position.y)
        else
            local position = self.srcHero:getPosition()
            self:setPosition3D(position.x , position.y , position.y)
        end
    elseif place == ePlace.CASTER then --施法者的位置
        if parent == eParent.MAP 
            or parent == eParent.UI  then
            local position = host:getWorldPosition3D()
            self:setPosition3D(position.x , position.y , position.y)
        else
            local position = host:getPosition()
            self:setPosition3D(position.x , position.y , position.y)
        end
    elseif place == ePlace.CASTER_MOUNT then --施法者的骨骼位置
            if parent == eParent.MAP 
                or parent == eParent.UI  then
                local position = host:getBonePosition(self.effectData.mount)
                self:setPosition3D(position.x , position.y , position.y)
            else
                local position = host:getRelativeBonePosition(self.effectData.mount)
                self:setPosition3D(position.x , position.y , position.y)
            end
    elseif place == ePlace.TARGET_MOUNT then --目标骨骼位置
        if  parent == eParent.MAP 
            or parent == eParent.UI  then
            if tarHero then
                local position = tarHero:getBonePosition(self.effectData.mount)
                self:setPosition3D(position.x , position.y , position.y)
            else
                local position = self.srcHero:getPosition()
                self:setPosition3D(position.x , position.y , position.y)
            end
        else
            if tarHero then
                local position = tarHero:getRelativeBonePosition(self.effectData.mount)
                self:setPosition3D(position.x , position.y , position.y)
            else
                -- local position = self.srcHero:getPosition()
                self:setPosition3D(0 , 0 , 0)
            end
        end
    elseif place == ePlace.CASTER_MAP_CENTER then
        local pos = self.srcHero:getPosition()
        local rect = levelParse:getMoveRect()
        self.position3D.y = rect.origin.y + rect.size.height / 2
        local winSize = me.Director:getWinSize()
        if pos.x < rect.origin.x + winSize.width / 2 then 
            self.position3D.x = rect.origin.x + winSize.width / 2
        elseif pos.x > rect.origin.x + rect.size.width -winSize.width / 2 then
            self.position3D.x = rect.origin.x + rect.size.width -winSize.width / 2
        else
            self.position3D.x = pos.x
        end
        self:setPositionZ(self.position3D.y)
    end
    
    --Y 方向位置修正
    local skewingPixelY = self.effectData.skewingPixelY
    if skewingPixelY then
        self.position3D.z = self.position3D.z + skewingPixelY
        self:setPositionZ(self.position3D.z)
    end


    if parent == eParent.CASTER then
        local position = host:getPosition()
        self.position3D.y = position.y

    elseif parent == eParent.TARGET then
        local position = host:getPosition()
        self.position3D.y = position.y
    elseif parent == eParent.MAP then  --地图上的
        -- 挂点为地图的时候计算偏移
        -- x字段：以角色当前坐标X为准，正值为前方，负值为后方
        -- Y字段：以角色当前坐标和X字段偏移为准，0为角色当前Y坐标。
        -- 1~10为Y轴从下到上10条路。
        local placeSkewingX = self.effectData.placeSkewingX
        local placeSkewingY = self.effectData.placeSkewingY
        local pram = host:getDir() == eDir.RIGHT and 1 or -1
        if place == ePlace.CASTER_MAP_CENTER then
            pram = 1
        end
        if placeSkewingX ~= 0 then
            self.position3D.x = self.position3D.x + placeSkewingX*pram
            self:setPositionX(self.position3D.x)
        end
        --
        if placeSkewingY ~= 0 then
            local rect = battleController.getAirwall()
            self.position3D.z = rect.origin.y + rect.size.height*(placeSkewingY-0.5)/10
            self:setPositionZ(self.position3D.z)
        end
        -- self:setPosition3D(self._initPos.x,self._initPos.y,self._initPos.z)
        if place == ePlace.CASTER_MOUNT then --施法者的骨骼位置
            self.position3D.y = host:getWorldPosition3D().y
        else
            self.position3D.y = self.position3D.z
        end
        --挂在地图上的特效才考虑影子偏移
        if skewingPixelY  then 
            if self.effectData.shadowSkewing then 
                self.position3D.y = self.position3D.y + skewingPixelY
            end 
        end
    elseif parent == eParent.UI then  --地图上的
        local placeSkewingX = self.effectData.placeSkewingX
        local placeSkewingY = self.effectData.placeSkewingY
        if placeSkewingX ~= 0 then
            self.position3D.x = self.position3D.x + placeSkewingX
            self:setPositionX(self.position3D.x)
        end
        if placeSkewingY ~= 0 then
            self.position3D.z = self.position3D.z + placeSkewingY
            self:setPositionZ(self.position3D.z)
        end

        if place == ePlace.CASTER_MOUNT then --施法者的骨骼位置
            self.position3D.y = host:getWorldPosition3D().y
        else
            self.position3D.y = self.position3D.z
        end
    else
        printError("Effect parent error")
    end
end

--同步特效和角色动作的播放速度
function Effect:syncTimeScale()
    local scale = self.srcHero:getActionTimeScale()
    self.skeletonNode:setTimeScale(scale)
end

--支持特效作为父节点添加特效
function Effect:addEffect(child,zOrder)
    -- _print("xxaddEffectxx"..tostring(child).." | "..tostring(self))
    zOrder = zOrder or 1
    child:setDir(self:getDir())
    child:setCameraMask(self:getCameraMask())
    self:addChild(child,zOrder)
end

--挂在角色身上的才才需要和人物攻速同步
function Effect:addToParent(target)
    local host = self.parentNode
    local parent = self.effectData.parent
    --showParent为1时，加入施法者特效列表,在角色切换动作的时候需要移除对应的特效，
    --如果特效的父基点是角色默认是加入列表的
    local showParent = self.effectData.showParent
    if parent == eParent.CASTER then
        if self.effectData.zorder == 0 then --人物下层
            host:addEffect(self,-1)
        else
            host:addEffect(self,1)
        end
        if showParent == 1 then
            self.srcHero:addEffectToList(self)
        end
    elseif parent == eParent.TARGET then
        if not target then
            Box(""..tostring(self.effectData.id).." not find target !")
            target = hero
        end

        if self.effectData.zorder == 0 then --人物下层
            target:addEffect(self,-1)
        else
            target:addEffect(self,1)
        end 
        if showParent == 1 then
            self.srcHero:addEffectToList(self)
        end
    elseif parent == eParent.MAP then  --地图上的
        if self.effectData.zorder == 0 then --人物下层
            EventMgr:dispatchEvent(eEvent.EVENT_EFFECT_ADD_TO_LAYER,self,1)
        elseif self.effectData.zorder == 1 then --人物上层
            EventMgr:dispatchEvent(eEvent.EVENT_EFFECT_ADD_TO_LAYER,self,3)
        else
            EventMgr:dispatchEvent(eEvent.EVENT_EFFECT_ADD_TO_LAYER,self,2)
        end
        if showParent == 1 then
            self.srcHero:addEffectToList(self)
        end
    elseif parent == eParent.UI then  --UI层的
        
        _print("55555555555555555555555",self.effectData.id)
        EventMgr:dispatchEvent(eEvent.EVENT_ADDTO_UI_EFFECT,self)
        if showParent == 1 then
            self.srcHero:addEffectToList(self)
        end
    else
        printError("Effect parent error")
    end
    if self.effectData.showSpeed then
        self:syncTimeScale()
    end
    if self.effectData.effectType == eEffectType.NORMAL then
        self:setDir(host:getDir())
    end
    self:doBlast()
end

--气浪效果
function Effect:doBlast()
    if BattleConfig.SHADER_BLAST then
        --气浪强度取值范围(1 - 20)
        local blastLevel = math.floor(self.effectData.blastLevel* battleController.getBlastLevel()*0.2)
        if blastLevel > 0  then
            self:setCameraMask(eCameraFlag.CF_EFFECT)
            EventMgr:dispatchEvent(eEvent.EVENT_HIT_BLAST,blastLevel )
        end
    end
end

--模糊效果
function Effect:doBlur(hurtData)
    if BattleConfig.SHADER_BLUR then
        local fuzzyLevel = math.floor(hurtData.fuzzyLevel * battleController.getBlurLevel())
        if fuzzyLevel > 0 then
            self:setCameraMask(eCameraFlag.CF_MAP)
            EventMgr:dispatchEvent(eEvent.EVENT_HIT_BLUR,hurtData.fuzzyTime,fuzzyLevel)
        end
    end
end

--检查是否需主要目标
function Effect:isNeedMainTarget()
    local parent = self.effectData.parent
    if parent == eParent.TARGET then
        return 2
    end
    local place = self.effectData.place
    if place == ePlace.TARGET then --目标位置
        return 1
    elseif place == ePlace.TARGET_MOUNT then --目标骨骼位置
        return 1
    end
    return 0
end

function Effect:active(srcHero,hostType,effect,mainTarget)
	self.srcHero    = srcHero
    self:createSkeletonNode()
    if hostType == eTriggerHostType.EFFECT then
        self.parentNode = effect
        self.parentNode:retain()
    else
        self.parentNode = self.srcHero
    end
    self.hostType = hostType
    self.mainTarget = mainTarget
    --设置初始位置
    self:initialPos(mainTarget)
    --添加到父节点
    self:addToParent(mainTarget)
    --触发魔女时间
    self:triggerWitchTime()
    self:showBubble()
    self:triggerNewEffect()
end

function Effect:triggerNewEffect()
    if self.effectData.triggernewEffects and #self.effectData.triggernewEffects > 0 then
        local effects = effectMgr:getObjects()
        for i,v in ipairs(self.effectData.triggernewEffects) do
            for j,effect in ipairs(effects) do
                if effect.effectData and effect.effectData.id == v then
                    effect:createTriggerEffect(self.effectData.id)
                end
            end
        end
    end
end

function Effect:createTriggerEffect(srcId)
    if self.effectData.Generateeffect and self.effectData.Generateeffect[srcId] then
        for i,effectId in ipairs(self.effectData.Generateeffect[srcId]) do
            self:createNewEffect(effectId)
        end
        if self.effectData.disappear then
            self:preRemove()
        end
    end
end

function Effect:checkRemove()
    if self.bPreRemove  then
        self:remove(true)
    end
end

--预移除
function Effect:preRemove()
    self.bPreRemove = true
end

--重管理器移除
function Effect:remove(clean)
    self:playConnectEffect()
    self:checkNotHitEvent(true)
    --移除监听
    if self.skeletonNode then
        self.skeletonNode:removeMEListener(TFARMATURE_EVENT)
        self.skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
    end
    local parent = self.effectData.parent
    if parent == eParent.CASTER then
        self.srcHero:removeEffect(self)
    else
        if self.effectData.showParent == 1 then
           self.srcHero:removeEffect(self) 
        end
    end
    if clean then
        if self.bindParentNode then
            self.bindParentNode:removeFromParent()
        else
            self.skeletonNode:removeFromParent(true)
            if self.skeletonNode.resPath then
                ResLoader.addCacheSpine(self.skeletonNode,self.skeletonNode.resPath)
            end
            self:removeFromParent()
        end
    end
end

function Effect:setBindParent(node)
    self.bindParentNode = node
end

function Effect:checkNotHitEvent(endCheck)
    if endCheck then
        if not self.notHitEvent and not self.hitEvent then
            local hurtId   = self:getHurtId(1)
            if hurtId ~= 0 then
                local hurtData = BattleDataMgr:getHurtData(hurtId,self.srcHero:getAngleDatas())
                if hurtData then
                    self.srcHero:onEventTrigger(eBFState.E_NOT_HITED)
                    self.notHitEvent = true
                    local event = BattleUtils.getNotHitEvent(hurtData.damageType)
                    if event then
                        self.srcHero:onEventTrigger(event)
                    end
                end
            end
        end
    else
        if not self.hitEvent then
            local hurtId   = self:getHurtId(1)
            if hurtId ~= 0 then
                local hurtData = BattleDataMgr:getHurtData(hurtId,self.srcHero:getAngleDatas())
                if hurtData then
                    self.srcHero:onEventTrigger(eBFState.E_NOT_HITED)
                    self.notHitEvent = true
                    local event = BattleUtils.getNotHitEvent(hurtData.damageType)
                    if event then
                        self.srcHero:onEventTrigger(event)
                    end
                end
            end
        end
    end
end


function Effect:onArmtureComplete(skeletonNode)
	if self.skeletonNode then
		self.skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
        self.skeletonNode:removeMEListener(TFARMATURE_EVENT)
    	-- self.skeletonNode:removeFromParent()
	end
	self:preRemove(true)
end

function Effect:onArmtureEvent(...)
    
	local event = BattleUtils.translateArmtureEventData(...)
	local eventName = event.name
    self.eventCount[eventName] = self.eventCount[eventName] or 0
    self.eventCount[eventName] = self.eventCount[eventName] + 1
    local pramN = self.eventCount[eventName]
    if eventName == eArmtureEvent.HURT then   --伤害判定
        local hutrWay = self.effectData.hurtWay 
        if self.effectData.hurtWay == eHurtWay.HW_NONE then 
            self:triggerNoHitBufferByOrder(pramN)
        elseif self.effectData.hurtWay == eHurtWay.HW_FRAME then
            self:handlHurt(pramN)
            self:handlSummonMonster(pramN)
            self:checkNotHitEvent()
        end
    elseif eventName == eArmtureEvent.MUSIC then  --音效触发
        self:handlMusic(pramN)
    elseif eventName == eArmtureEvent.EFFECT then  --特效触发特效
        self:handlEffect(pramN)
    elseif eventName == eArmtureEvent.LIMIT_DODGE then  --极限闪避
        self:handlLimitDodge(pramN)
    elseif eventName == eArmtureEvent.GRASP_START then  --抓取开始
        self:onGraspStart(pramN)
    elseif eventName == eArmtureEvent.GRASP_END then  --抓取结束
        self:onGraspEnd(pramN)
    elseif eventName == eArmtureEvent.GRASP_CHANGE then  --抓取状态变更
        self:onGraspChange(pramN)
    else
        print("not support event",eventName)
    end

end


--召唤
function Effect:handlSummonMonster(pramN)
        -- print_("召唤-----怪物等级:"..tostring(self.srcHero:getData().level))
    local callEvent       = self.effectData.callEvent
    local monsterSections = self.effectData.callMonsterSection
    local sectionSites    = self.effectData.sectionSite
    local callMount       = self.effectData.callMount
    local effectLimit = self.effectData.callLimit
    if callEvent == eArmtureEvent.HURT..pramN then
            local positon = self:getWorldPosition()
            local level   = self.srcHero:getData().level or 1
            local callLimit = self.srcHero:getData().callLimit --召唤上限制
            local callType  = self.srcHero:getData().callReplenish --召唤类型 (补充/替换)
            local heros     = self.srcHero:getCallHeros()
            local num       = #heros
            dump({"召唤:",self.srcHero:getName(),level,callLimit,callType,num})
            local _monsterSections = {}
            if callType == 0 then --补充召唤  超过上限不再召唤 
                local canCallNum = callLimit - num --还有招几个
                if effectLimit > 0 then
                    local curCount = 0
                    local monsterIds = {}
                    for m,sectionid in ipairs(monsterSections) do
                        local monsterSectionCfg = TabDataMgr:getData("MonsterSection", sectionid)
                        for n,monsterId in ipairs(monsterSectionCfg.fixedMonster) do
                            table.insert(monsterIds,monsterId)
                        end
                    end
                    for i,v in ipairs(heros) do
                        if table.indexOf(monsterIds,v:getData().id) ~= -1 then
                            curCount = curCount + 1
                        end
                    end
                    canCallNum = effectLimit - curCount
                    canCallNum = math.min(canCallNum, callLimit - num)
                end
                local callIndex = 0
                while(callIndex < canCallNum and callIndex < #monsterSections) do
                    callIndex = callIndex + 1
                    table.insert(_monsterSections,monsterSections[callIndex])
                end
            elseif callType == 1 then --替换召唤 超过上限 根据时间移除 
                _monsterSections = monsterSections
                local killNums = #_monsterSections + num - callLimit  
                if killNums > 0 then 
                    killNums = math.min(killNums,num)
                    for index = 1,killNums do
                        local hero = heros[index]
                        if hero then 
                            hero:setValue(eAttrType.ATTR_NOW_HP,0,true)
                        end
                    end
                end
            elseif callType == 3 then --无限制
                _monsterSections = monsterSections
            end
            -- _print("召唤-----怪物:", level,monsterSection)
            for index , id in ipairs(_monsterSections) do
                local site = sectionSites[index]
                local pos  = nil
                if site == 2 then
                    pos = positon
                elseif site == 3 then --骨骼位置
                    pos = self:getBonePosition(callMount)
                end
                if pos then 
                    if not levelParse:canMove(pos.x,pos.y) then 
                        local heroPos = self.srcHero:getPosition()
                        local rect    = me.rect(heroPos.x -150, heroPos.y - 100 , 300, 200)
                        pos = levelParse:randomPos(rect)
                        -- print("随机位置：",pos)
                    end
                end
                EventMgr:dispatchEvent(EV_SKILL_BRUSH_MONSTER , self.srcHero , id , pos , level)
            end
    end
end

--极限闪避
function Effect:handlLimitDodge(pramN)
    local targets = self:getAllTarget()
    for k , target in ipairs(targets) do
        if self:hitTest(target) then
            --目标角色设置极限闪避状态
            target:addAState(eAState.E_LIMIT_DODGE) 
        end
    end
end

--魔女时间触发
function Effect:triggerWitchTime()
    local witchTimeId = self.effectData.witchTimeId
    if witchTimeId and witchTimeId > 0 then
        local data = TabDataMgr:getData("WitchTime", witchTimeId)
        self.srcHero:getTeam():triggerWitchTime(self.srcHero:getCamp(),data)
    end
end

--由特效触发的特效
function Effect:handlEffect(pramN)
    local eventName  = eArmtureEvent.EFFECT..pramN
    -- _print("特效触发特效事件:"..eventName)
    if self.srcHero:isDead() then
        --角色死亡不再创建新特效
        return
    end
    local effectIds    = self.effectData.triggerEffects
    local probability  = self.effectData.triggerEffectsOdds
    for i,id in ipairs(effectIds) do
        --新特效触发概率判断
        if BattleUtils.triggerTest10000(probability) then
            --Box("effect trigger effect"..tostring(id))
            local effectData = BattleDataMgr:getEffectData(id,self.srcHero:getAngleDatas())
            if effectData then
                if table.find(effectData.triggerEvents, eventName) ~=-1 then
                    Effect.create(effectData,self.srcHero,eTriggerHostType.EFFECT,self)
                else
                    -- Box("xxxxx not find  effect"..tostring(id))
                end
            else
                Box("trigger not find  effect"..tostring(id))
            end
        end
    end
end

--特效触发音效
function Effect:handlMusic(pramN)
    local eventName  = eArmtureEvent.MUSIC..pramN
    --音效事件
    local resource = self.effectData.resource
    local action   = self.effectData.action
    local musicDatas = BattleDataMgr:getEffectMusicData(resource,action,eventName)
    if musicDatas then
        for i, musicData in ipairs(musicDatas) do
            local handle = BattleUtils.playEffect(musicData.resource,false,musicData.volume*0.01)
            if musicData.stopJudge == 1 then
                self:addSoundEffect(handle)
            end
        end
    end
end

function Effect:addSoundEffect(handle)
    if handle and handle > 0 then
        self.soundEffects[#self.soundEffects + 1] = handle
    end
end

--特效销毁时 关闭所有音效
function Effect:stopSoundEffect()
    if #self.soundEffects > 0 then
        for i , handle in ipairs(self.soundEffects) do
            if TFAudio.isEffectPlaying(handle) then
                TFAudio.stopEffect(handle)
            end
        end
        self.soundEffects = {}
    end
end

function Effect:getHurtId(order)
    local length = #self.effectData.hurtList
    local hurtId = 0
    if length > 0  then
        if order > length then
    	   order = (order -1) % length + 1
        end
        -- _print("CAO CAO ",xx , order,self.effectData.hurtList)
    	hurtId = self.effectData.hurtList[order]
    end
    -- _print("hurtId:"..hurtId)
    return  hurtId
end
--更新特效方向
function Effect:updateDir()
    if self.effectData.effectsOrientationX == 3 then --跟随角色朝向
        local src_dir = self.srcHero:getDir()
        local dir     = self:getDir()
        if dir ~= src_dir then 
            self:setDir(src_dir)
        end
    end
end
--普通特效生效
function Effect:setDir(dir)
    --如果指定了朝向着按照指定的方向
    if self.effectData.effectsOrientationX == 1 then
        dir = eDir.RIGHT
    elseif self.effectData.effectsOrientationX == 2 then
        dir = eDir.LEFT
    end
    local scaleX = math.abs(self.skeletonNode:getScaleX())
    if dir == eDir.LEFT then
        self.skeletonNode:setScaleX(-scaleX)
    else
        self.skeletonNode:setScaleX(scaleX)
    end
end

function Effect:getDir(dir)
    local sacleX = self.skeletonNode:getScaleX()
    return sacleX < 0 and eDir.LEFT or eDir.RIGHT
end

--施法者的位置
function Effect:getCasterPosition()
    return me.p(self.parentNode:getPosition())
end

function Effect:getHurtRefPosition(hurtData)
    return self:getCasterPosition()
end

function Effect:getHurtActionPram(target,hurtData)
    local tarPos = target:getPosition()
    local refPos = self:getHurtRefPosition(hurtData)
-- floatType
-- floatAngle  floatSpeed
-- floorMove
-- floorSpeed
    local prama   = { floatType = 1 , dir = 1, a = 0 , v = 0 , t = 0 ,d = 0}
    prama.floatType = hurtData.floatType
    prama.v =  hurtData.moveSpeed
    if hurtData.floatType == 1 then -- 角度位移
        if tarPos.x > refPos.x then
            prama.dir =  1
            prama.a   = hurtData.floatAngle
        else
            prama.dir = -1
            if hurtData.floatAngle >= 0  then
                prama.a   = 180 - hurtData.floatAngle
            else
                prama.a   = -180 - hurtData.floatAngle
            end
        end
    else --水平位移
        prama.t   = math.abs(hurtData.floorMove/math.max(1,hurtData.moveSpeed))
        -- _print("prama.t:",hurtData.floorMove , hurtData.moveSpeed ,prama.t)
        if tarPos.x > refPos.x then
            prama.dir = 1
            prama.d   = hurtData.floorMove
        else
            prama.dir = -1
            prama.d   = -hurtData.floorMove
        end
    end

    return prama
end


--检查是否是背击
function Effect:isHitBack(target)
    local px = self.srcHero:getPositionX()  --self:getWorldPosition().x
    px  = px - target:getPositionX()
    local tarDir = target:getDir()
    if tarDir == eDir.LEFT then
        return px > 0
    elseif tarDir == eDir.RIGHT then
        return px < 0
    end
end

--计算2个角色的相对位置
local function calculationDir(src,target)
    local offset = src:getPositionX() - target:getPositionX()
    if target:getDir() == eDir.LEFT then
        if offset > 0 then
            return eWithstandDir.BEHIND
        else
            return eWithstandDir.FRONT
        end
    else
        if offset > 0 then
            return eWithstandDir.FRONT
        else
            return eWithstandDir.BEHIND
        end
    end
end

function Effect:triggerHurt(target,hurtData)
    self:addHitCount()
    if hurtData.isCalHurt == 0 then
        return
    end
    if hurtData.isShieldingSkillHurt == 2 then --不处理伤害和显示
        return
    end

	-- 免疫--无敌时，减益buff不生效、不会有受击动作。有受击特效，会有弹字提示：免疫
	-- 霸体--无视击退击飞
	------------------------
        local hurtStiff = hurtData.hurtStiff or 0
        target:setValue(eAttrType.ATTR_NOW_HURT_STIFF,hurtStiff)
        --受击删除极限闪避状态
        target:delAState(eAState.E_LIMIT_DODGE)

        --检查目标是否触发招架
        if target:isTriggerParry(calculationDir(self.srcHero,target)) then
            target:showState(eShowState.ZhaoJia) --招架
            return 
        end

		--伤害计算
		if target:isImmune() then
			target:showState(eShowState.MianYi) --伤害免疫
            target:onEventTrigger(eBFState.E_GETHIT_IMMUNE,self.srcHero) --受击免疫事件
            --TODO 将来可能要播防御特效？ 防御特效的位置如何计算
            --local weakness  , point  = tarHero:isWeakness(srcHero,self.hitedBdboxs,hurtData.damageAttr)
            return
		end
        --正面伤害免疫
        if target:isAState(eAState.E_ZM_SHMY) then
            if not self:isHitBack(target) then  --非背击(正面伤害)
                target:showState(eShowState.MianYi)
                return 
            end
        end
        
        --霸体判定
        local isSuperarmor =  target:isSuperarmor()
        local damageType = hurtData.damageType
        local damageAttr = hurtData.damageAttr
        local hp = target:getHp()
		local hurtInfo = BattleUtils.triggerHurt(self.srcHero,target,hurtData,self.hitedBdboxs)
        local realHurtValue = hurtInfo.realHurtValue
        --UI Boss 血条更新
        if target:enableUpdateBossPanel() then
            if hurtInfo.hurtValue ~= 0 then
                EventMgr:dispatchEvent(eEvent.EVENT_BOSS_CHANGE, target)
            end
        end
        --击杀事件
        if hp > 0 and target:getHp() <= 0 then --目标HP为0
            self.srcHero:onEventTrigger(eBFState.E_JI_SHA,target)
        end
        -- --最近一次造成伤害的值
        -- self.srcHero:setHurtValue(math.abs(hurtInfo.hurtValue))
        -- --最近一次被造成伤害的值
        -- target:setRevHurtValue(math.abs(hurtInfo.hurtValue))

        --每次伤害事件触发
        if hurtData.triggerEvent > 0 then
            self.srcHero:onEventTrigger(hurtData.triggerEvent,target)
        end

		if hurtInfo.hurtType == eHurtType.DODGE then --闪避
			print("闪避-------------")
            self.srcHero:onEventTrigger(eBFState.E_REV_DODGE,target)
            target:onEventTrigger(eBFState.E_DODGE,self.srcHero)
			return
		elseif hurtInfo.hurtType == eHurtType.PARRY then --格挡
            print("格挡-------------")
            self.srcHero:onEventTrigger(eBFState.E_REV_PT_BLOCK,target)
            target:onEventTrigger(eBFState.E_BLOCK,self.srcHero)
			return
        elseif hurtInfo.hurtType == eHurtType.CRIT then--暴击
            print("暴击-------------")
            --事件触发
            self:tryTriggerEvent(damageType,damageAttr,target,realHurtValue)
            --通用暴击
            self.srcHero:onEventTrigger(eBFState.E_CRIT,target)
            target:onEventTrigger(eBFState.E_REV_CRIT,self.srcHero)
            --伤害类型暴击
            local critEvent    = BattleUtils.getCritEvent(damageType)
            local revCritEvent = BattleUtils.getRevCritEvent(damageType)
            self.srcHero:onEventTrigger(critEvent,target)
            target:onEventTrigger(revCritEvent,self.srcHero)
        elseif hurtInfo.hurtType == eHurtType.PREICE then
                    --事件触发
            self:tryTriggerEvent(damageType,damageAttr,target,realHurtValue)
            print("穿透-------------")
            self.srcHero:onEventTrigger(eBFState.E_DO_PIERCE,target)
            local pierceEvent     = BattleUtils.getPierceEvent(damageType)
            self.srcHero:onEventTrigger(pierceEvent,target)
        elseif hurtInfo.hurtType == eHurtType.CRIT_PREICE then 

            self:tryTriggerEvent(damageType,damageAttr,target,realHurtValue)
            --通用暴击
            self.srcHero:onEventTrigger(eBFState.E_CRIT,target)
            target:onEventTrigger(eBFState.E_REV_CRIT,self.srcHero)
            --伤害类型暴击
            local critEvent    = BattleUtils.getCritEvent(damageType)
            local revCritEvent = BattleUtils.getRevCritEvent(damageType)
            self.srcHero:onEventTrigger(critEvent,target)
            target:onEventTrigger(revCritEvent,self.srcHero)

            --穿透
            self.srcHero:onEventTrigger(eBFState.E_DO_PIERCE,target)
            local pierceEvent     = BattleUtils.getPierceEvent(damageType)
            self.srcHero:onEventTrigger(pierceEvent,target)
        else
            print("正常攻击-------------")
            --事件触发
            self:tryTriggerEvent(damageType,damageAttr,target,realHurtValue)
		end


        if self:isHitBack(target) then
            self.srcHero:onEventTrigger(eBFState.E_BACK_SKILL_HURT,target)
        end
    
		-- end

	    --有受击动作播放受击动作，再做死亡判定
	    --否则直接坐死亡判定
	    --受击动作
	    local isHurtAction = false
        --倒地状态
        if target:isFall() then
            isHurtAction = hurtData.isHurtFall        --倒地是否播受击动作
        else
            isHurtAction = hurtData.isHurtAction      --是否播受击动作
        end
        if not isSuperarmor then 
            isSuperarmor =  target:isSuperarmor()
        end
	    if isSuperarmor or not isHurtAction then
            if not target:isInAir() then
                local state = target:getState()
                if target:isDead() and state ~= eState.ST_DIE and state ~= eState.ST_FLOAT then
                    target:doEvent(eStateEvent.BH_DIE)
                end
            else --在空中并且死了
                if target:isDead()  then
                    local pram = self:getHurtActionPram(target,hurtData)
                    target:doHurtAction(pram)
                    --命中停顿
                    if hurtData.hitStop > 0 then
                        battleController.setStopFrame(hurtData.hitStop)
                    end
                    -- if hurtData.hitMusic > 0 then
                    --     target:playHitMusic(hurtData.hitMusic)
                    -- end
                end
            end
        else
            if not target:isAState(eAState.E_DONG_JIE) then 
                
                local state = target:getState()
                if target:isDead() then 
                    if state ~= eState.ST_DIE and state ~= eState.ST_FLOAT  then
                        target:doEvent(eStateEvent.BH_DIE)
                    end
                else
                    local pram = self:getHurtActionPram(target,hurtData)
                    target:doHurtAction(pram)
                    --命中停顿
                    if hurtData.hitStop > 0 then
                        battleController.setStopFrame(hurtData.hitStop)
                    end
                end

                -- --受击音效
                -- if hurtData.hitMusic > 0 then           
                --     target:playHitMusic(hurtData.hitMusic)
                -- end
            end
	    end
        -- --命中音效
        if hurtData.hitMusic > 0 then           
            target:playHitMusic(hurtData.hitMusic)
        end

--被击特效
        if battleController.isShowAttackEffect(self.srcHero) then 
    		local effectName      = self.effectData.hurtEffect
    		local hurtEffectAngle = self.effectData.hurtEffectAngle
    		local hurtEffectScale = self.effectData.hurtEffectScale*BattleConfig.MODAL_SCALE*target:getSkeletonNodeScale()
            local hurtActionUp    =  self.effectData.hurtActionUp
            local hurtActionDown  =  self.effectData.hurtActionDown
    		if ResLoader.isValid(effectName) then
                if ResLoader.isValid(hurtActionUp) then
                    target:getActor():playHitEffect(effectName,hurtEffectScale,hurtEffectAngle,hurtActionUp,2,hurtInfo.point)
                end
                if ResLoader.isValid(hurtActionDown) then
                    target:getActor():playHitEffect(effectName,hurtEffectScale,hurtEffectAngle,hurtActionDown,-1,hurtInfo.point)
                end
    		end
        end
		--受击回怒
		-- target:doAngerRule(eAngerRule.RULE_GETHIT)
        --命中抖屏

end



function Effect:handlHurt(order)
    print("hitTest index----",order)
end

--在地图里碰撞框的位置
function Effect:getWorldBoundingBox(bdbox)
    local rect = self.skeletonNode:getBoundingBox2(bdbox)
    local pos  = self:getWorldPosition()
    rect.origin = me.pAdd(pos,rect.origin)
    --挂载在地图上无需转换
    return rect
end
function Effect:getCollisionWithName(bdbox )
    return self.skeletonNode:getCollisionWithName(bdbox)
end

--在地图里的位置
function Effect:getWorldPosition()
    local pos = self:getPosition()
    local parentType = self.effectData.parent
    if parentType == eParent.CASTER or parent == eParent.TARGET then
        -- local parentNode = self:getParent()
        local parentNode = self.parentNode
        local _pos = clone(parentNode:getPosition())
        if _pos.z then
            _pos.y = _pos.z
        end
        return me.pAdd(pos,_pos)
    else
        --地图上不需要做处理
    end
    return pos
end

--在地图里的位置
function Effect:getWorldPosition3D()
    local pos = clone(self.position3D)
    local parentType = self.effectData.parent
    if parentType == eParent.CASTER or parent == eParent.TARGET then
        -- local parentNode = self:getParent()
        local parentNode = self.parentNode
        local _pos = parentNode:getPosition3D()
        pos.x = pos.x + _pos.x
        pos.y = _pos.y
        pos.z = pos.z + _pos.z
        return pos
    end
    return pos
end

--垂直范围判断
function Effect:checkRoller(target)
    local posY = self.position3D.y
    local _minV , _maxV = target:getRoller()
    if self.effectData.yRollerSetShadow then
        posY = (_minV + _maxV) / 2
    end
    if self.effectData.parent == eParent.CASTER then
        posY = self:getCasterPosition().y
    end
    local minV = posY - self.effectData.yRoller[2]
    local maxV = posY + self.effectData.yRoller[1]
    if (_maxV < minV ) or (_minV > maxV ) then   --TODO 还需要验证
        return false
    end

    -- print(posY,minV,maxV,tarY)
    -- if tarY >= minV and tarY <= maxV then
    --     -- print(">>>>>>>>>>>true>>>>>>>>>>>>>>>")
    --     return true
    -- end
    return true
end


--碰撞判定
function Effect:hitTest(target,checkRoller)
    self.hitedBdboxs = {}
    if checkRoller == nil then
        checkRoller = true
    end
    if checkRoller then
        if not self:checkRoller(target) then
            return false
        end
    end
    local rollerType = self.effectData.rollerType
    --TODO目前检测只要一个满足条件就认为产生伤害
    local bdbox_effs = self.effectData.roller
    local bdboxs     = target:getBodyArea()
    self:drawNodeClear()
    for a , bdbox_eff in ipairs(bdbox_effs) do
        for b , bdbox in ipairs(bdboxs) do
            if rollerType == 1 then --多边形碰撞
                --多边形碰撞
                local pts1  = self:getCollisionWithName(bdbox_eff)
                local pts2  = target:getCollisionWithName(bdbox)
                self:drawLine(pts1 ,rollerType)
                self:drawLine(pts2 ,rollerType)
                local result = BattleUtils.isPolygonInterSection(pts1,pts2)
                if result then
                    local rect     = self:getWorldBoundingBox(bdbox_eff)
                    local hitrect  = target:getBoundingBox(bdbox)
                    local point    = BattleUtils.rectsCenterPoint(hitrect , rect)
                    table.insert(self.hitedBdboxs,{name=bdbox,point = point})
                    -- return true
                end
            elseif rollerType == 2 then --特殊碰撞判定
                local pts1  = self:getCollisionWithName(bdbox_eff)
                local pos   = target:getPosition3D()
                local width = 10
                local pts2 = {ccp(pos.x - width ,pos.y -width ),ccp(pos.x + width ,pos.y -width),ccp(pos.x +width ,pos.y +width),ccp(pos.x-width  ,pos.y + width)}
                self:drawLine(pts1 ,rollerType)
                self:drawLine(pts2 ,rollerType)
                local result = BattleUtils.isPolygonInterSection(pts1,pts2)
                if result then
                    local rect     = self:getWorldBoundingBox(bdbox_eff)
                    local hitrect  = target:getBoundingBox(bdbox)
                    local point    = BattleUtils.rectsCenterPoint(hitrect , rect)
                    table.insert(self.hitedBdboxs,{name=bdbox,point = point})
                    -- return true
                end

            else
                --矩形碰撞
                local rect = self:getWorldBoundingBox(bdbox_eff)
                if #self.effectData.boxcorrect > 0 then
                    rect.origin.x = rect.origin.x + self.effectData.boxcorrect[1] or 0
                    rect.origin.y = rect.origin.y + self.effectData.boxcorrect[2] or 0
                    rect.size.width = rect.size.width + self.effectData.boxcorrect[3] or 0
                    rect.size.height = rect.size.height + self.effectData.boxcorrect[4] or 0
                end
                self:drawLine(rect,rollerType)
                if rect.size.width < 1 or rect.size.height < 1 then
                    _print("hit test box error", rect)
                    break
                end
                local hitrect  = target:getBoundingBox(bdbox)
                self:drawLine(hitrect ,rollerType)
                if hitrect.size.width < 1 or hitrect.size.height < 1 then
                    -- 碰撞框大小为0
                    _print("hit test target box error", hitrect)
                    break
                end
                local result = me.rectIntersectsRect(rect,hitrect)
                if result then
                    local point = BattleUtils.rectsCenterPoint(hitrect , rect)
                    table.insert(self.hitedBdboxs,{name=bdbox,point = point})
                    -- return true
                end
            end
        end
    end
    -- _print(self.hitedBdboxs)
    return #self.hitedBdboxs > 0


    -- dump(bdbox_effs)
    -- dump(bdboxs)
    -- Box("aaaaa")
    -- if rollerType == 1 then
    --     --多边形碰撞
    --     local pts1  = self:getCollisionWithName(bdbox_eff)
    --     local pts2  = target:getCollisionWithName(bdbox)
    --     self:drawLine(pts1 ,rollerType)
    --     return BattleUtils.isPolygonInterSection(pts1,pts2)
    -- else
    --     --矩形碰撞
    --     local rect = self:getWorldBoundingBox(bdbox_eff)
    --     self:drawLine(rect,rollerType)
    --     if rect.size.width < 1 or rect.size.height < 1 then
    --         _print("hit test box error", rect)
    --         return false
    --     end
    --     local hitrect  = target:getBoundingBox(bdbox)
    --     if hitrect.size.width < 1 or hitrect.size.height < 1 then
    --         -- 碰撞框大小为0
    --         _print("hit test target box error", rect)
    --         return false
    --     end
    --     return me.rectIntersectsRect(rect,hitrect)
    -- end
end

function Effect:skeletonNodeUpdata(dt)
    dt = dt*0.001
    self:retain()
    if self.skeletonNode then
        self.skeletonNode:update(dt)
    end
    self:release()
    if BattleConfig.SHOW_HITBOX then
        if self.textPos then
            self.textPos:setText(string.format("[%0.0f,%0.0f,%0.0f]",self.position3D.x,self.position3D.y,self.position3D.z))
        end
    end
end

function Effect:getSkeletonModalSize()
    local scale = self.effectData.scale*self.srcHero:getSkeletonNodeScale()
    local parent = self.effectData.parent
    if parent == eParent.UI then
        scale = scale * eSkeletonScale.UI
        local curWidth = me.EGLView:getDesignResolutionSize().width
        local fitScale = (curWidth - 1386) / 1386 * scale
        if fitScale > 0 then
            if scale + fitScale > 1.0 then
                self.fitScale = fitScale
            else
                scale = scale + fitScale
            end
        end
    else
        scale = scale * BattleConfig.MODAL_SCALE
    end
    return scale
end
function Effect:createSkeletonNode()
    if not self.effectData.scale then
        Box("effect data not sacel")
    end
    if self.effectData.resource == "" then
        Box("effect data not resource "..tostring(self.effectData.id))
    end
    local scale = self:getSkeletonModalSize()
	self.skeletonNode = ResLoader.createEffect(self.effectData.resource,scale,true)
    self.skeletonNode:setScheduleUpdateWhenEnter(false)
    local loop  = self.effectData.loop
    if not loop then
        self.skeletonNode:addMEListener(TFARMATURE_COMPLETE,handler(self.onArmtureComplete,self))
	end
    self.skeletonNode:addMEListener(TFARMATURE_EVENT,handler(self.onArmtureEvent,self))
	self:addChild(self.skeletonNode)
    self.skeletonNode:play(self.effectData.action, loop)
    local color =  self.effectData.actionColor
    if ResLoader.isValid(color) then
        color = BattleUtils.toC3b(color)
        self.skeletonNode:setColor(color)
    end
    --特效角度旋转处理
    if self.effectData.effectType == eEffectType.NORMAL then
        local effectAngle = self.effectData.effectAngle
        if effectAngle and effectAngle ~= 0 then 
            self.skeletonNode:setRotation(effectAngle)
        end
    end

    self:handlMusic(0)
    self:createParticles()
    self:createText()
    if not battleController.isShowAttackEffect(self.srcHero) then 
        if self.effectData.display and self.effectData.display == 1 then --强制显示

        else
            self.skeletonNode:hide()
        end
    end
end

function Effect:isTimeOut()
    if self.effectData.effectType == eEffectType.EMIT then
        local tailType = self.effectData.tailType
        if tailType == eTailType.BEZIER or
           tailType == eTailType.BEZIER_POS or 
           tailType == eTailType.BEZIER_RANDOM_POS or 
           tailType == eTailType.BEZIER_POS_HIT then
            if self._elapsedTime >= self._durationTime then
                return true
            end
        end
    end
    if self.nTime >  self.effectData.totalTime then
        return true
    end
    return false
end

function Effect:update(time)

end

function Effect:playEndEffect()
    if self.bPreRemove then 
        return
    end
    if battleController.isShowAttackEffect(self.srcHero) then 
        local effectName = self.effectData.endEffect
        if ResLoader.isValid(effectName) then
            local effectAction = self.effectData.endEffectAction
            local endEffectScale = self.effectData.endEffectScale*BattleConfig.MODAL_SCALE*self.srcHero:getSkeletonNodeScale()
            local skeletonNode = ResLoader.createEffect(effectName,endEffectScale,true)
            skeletonNode:setPosition(ccp(0,0))
            skeletonNode:addMEListener(TFARMATURE_COMPLETE,function(skeletonNode)
                skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
                if skeletonNode.resPath then
                    ResLoader.addCacheSpine(skeletonNode,skeletonNode.resPath)
                end
                skeletonNode:removeFromParent()
            end)
            skeletonNode:play(effectAction, 0)
            local node = CCNode:create()
            node:setPosition(self:getWorldPosition())
            node:addChild(skeletonNode)
            EventMgr:dispatchEvent(eEvent.EVENT_EFFECT_ADD_TO_LAYER,node,2)
        end
    end
end
-- 我伤害判定时调用
function Effect:triggerNoHitBufferByOrder(order)
    local hurtId   = self:getHurtId(order)
    if hurtId == 0 then
        return
    end
    local hurtData = BattleDataMgr:getHurtData(hurtId,self.srcHero:getAngleDatas())
    self:triggerNoHitBuffer(hurtData)
end
--帧事件触发 不检查碰撞
function Effect:triggerNoHitBuffer(hurtData)
    for i,nohitbuffId in ipairs(hurtData.nohitbuffId) do
        self.srcHero:onSkillTrigger(eBFSkillEvent.SE_HURT,nohitbuffId,self.srcHero)
    end
end
--检查配碰撞
function Effect:triggerBuffer(hurtData,target)
    -- if not target then
    --     Box("><><><><><<><><")
    -- end
    --hurt事件触发
    for i,buffId in ipairs(hurtData.buffId) do    
        self.srcHero:onSkillTrigger(eBFSkillEvent.SE_HURT,buffId,target)
    end

    --背击buff触发
    if self:isHitBack(target) then
        self.srcHero:onEventTrigger(eBFState.E_MAKE_BACK_HURT,target)
    end
end

function Effect:isShowHitLine()
    if self.srcHero then
        return self.srcHero:isManual(true)
    end
end
function Effect:setAlreadyShowHitLine(bShow)
    self.bAlreadyShowHitLine = bShow
end
function Effect:showHitLine(pos,hurtData)
    if hurtData.isShieldingSkillHurt == 2 then
        return
    end
    if self:isShowHitLine() then
        if not self.bAlreadyShowHitLine then
            EventMgr:dispatchEvent(eEvent.EVENT_SHOW_HITLINE,pos)
            self:setAlreadyShowHitLine(true)
            self:doBlur(hurtData)
        end
    end
end

function Effect:recoveryAnger(hurtData)
    if self.srcHero then
        if hurtData.anger ~= 0 then
            if not hurtData.anger then
                dump(hurtData)
                Box("AAAAA")
            end
            self.srcHero:changeAnger(hurtData.anger)
        end
        if hurtData.extraAnger ~= 0 then
            self.srcHero:changeEnergy(hurtData.extraAnger)
        end
    end
end

function Effect:recoveryAnger1(hurtData)
    if not self.bRecoveryAngerFlag then
        self:recoveryAnger(hurtData)
    end
    self.bRecoveryAngerFlag = true
end

--导弹闪红处理
function Effect:doFlashRed()
    if not self.skeletonNode.flashRed then
        if self.nTime*2 > self.effectData.totalTime then
            self.skeletonNode.flashRed = 1  --闪红
            Effect.BlinkAction(self.skeletonNode,0.5)
        elseif self.nTime*5/4 > self.effectData.totalTime then
            self.skeletonNode.flashRed = 2 --加快闪红
            Effect.BlinkAction(self.skeletonNode,0.5)
        end
    elseif self.skeletonNode.flashRed == 1 then
        if self.nTime*5/4 >  self.effectData.totalTime then
            self.skeletonNode.flashRed = 2 --加快闪红
            Effect.BlinkAction(self.skeletonNode,0.1)
        end
    end
end

--是否背击
function Effect:isStrikeBack(target)
    --目标的朝向
    local tarPos    = target:getPosition()
    local tarDir    = target:getDir()
    local pos       = self:getWorldPosition()
    if tarDir  == eDir.LEFT then
        return pos.x > tarPos.x
    else
        return pos.x < tarPos.x
    end
end
function Effect:screenWobble(hurtData,isHited)
    --无视命中抖动
    if hurtData.shakeType ~= 0 then
        if self.srcHero:isManual(true) then
            if hurtData.shakeOption == 0 then
                BattleUtils.screenWobble(hurtData)
            elseif hurtData.shakeOption == 1 then --命中震屏
                if isHited then
                    BattleUtils.screenWobble(hurtData)
                end
            end
        end
    end
end
--子弹类型特效命中震屏处理
function Effect:screenWobbleOnce(hurtData)
    if not self.bScreenWobbleOnce then
        self.bScreenWobbleOnce = true
        self:screenWobble(hurtData,true)
    end
end

--是否有抓取功能
function Effect:isGrasp()
    return #self.effectData.grabShow > 0
end

function Effect:getGraspData(eventName)
    if #self.effectData.grabShow > 0 then
        if not self.graspDatas then
            self.graspDatas = {}           
            for i, id in ipairs(self.effectData.grabShow) do
                local data = TabDataMgr:getData("SkillGrab",id)
                self.graspDatas[data.grabFrames] = data
            end  
            dump(self.graspDatas)
            -- Box("xxxxx")
        end
        return self.graspDatas[eventName]
    end
end

--触发抓取
function Effect:onGraspStart(num)
    print_("onGraspStart :"..tostring(num))

    local eventName = eArmtureEvent.GRASP_START..tostring(num)
    local data = self:getGraspData(eventName)
    if data then
        -- self.curGraspData = data
        -- dump(data)
        local grabEndType = self.effectData.grabEndType --（0随特效结束而结束、1随时间结束而结束
        local duration = nil
        if grabEndType == 1 then 
            duration = self.effectData.grabEndTime
        end

        local triggerShowType   = data.triggerShowType 
        local triggerShowAction = data.triggerShowAction 
        -- local triggerTier       = data.triggerTier
        local triggerAngle      = data.triggerAngle
        -- local grabSpeed         = data.grabSpeed
        local resource          = data.resource
        local action            = data.action
        local parent            = data.parent
        self.effectData.grabSpeed = data.grabSpeed
        --抓取的列表
        self.graspHeroList = self.graspHeroList or {} 
        --找场上所有敌人 
        local heros = self:getAllTarget()
                        -- Box("xxxxxasdf"..tostring(#heros))
        --检查角色是否被抓取
        for i, hero in ipairs(heros) do
            local objId = self.srcHero:getObjectID()
                                        -- Box("bbbbb")
            if hero:canCrasp(objId) then
                -- Box("1111")
                if self:hitTest(hero) then
                    -- Box("2222")
                    if triggerShowType == 0 then --动作无变化
                        hero:doGrasp(objId,self,nil,triggerAngle,duration)
                    elseif triggerShowType == 1 then --隐藏
                        hero:doGrasp(objId,self,nil,triggerAngle,duration)
                        hero:setVisible(false)
                    elseif triggerShowType == 2 then --指定动作
                        hero:doGrasp(objId,self,triggerShowAction,triggerAngle,duration)
                    end
                    if ResLoader.isValid(resource) then 
                        local scale = BattleConfig.MODAL_SCALE*hero:getSkeletonNodeScale()
                        if parent == 0 then 
                            hero:getActor():playEffect(resource,scale,action)
                        else --挂在到地图
                            local  skeletonNode = ResLoader.createEffect(resource,scale,true)
                            skeletonNode:play(action,0)
                            skeletonNode:addMEListener(TFARMATURE_COMPLETE,function ( skeletonNode )
                                skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
                                if skeletonNode.resPath then
                                    ResLoader.addCacheSpine(skeletonNode,skeletonNode.resPath)
                                end
                                skeletonNode:removeFromParent()
                            end)
                            local pos3d = hero:getPosition3D()
                            skeletonNode:setPosition(ccp(pos3d.x,pos3d.z))
                            EventMgr:dispatchEvent(eEvent.EVENT_EFFECT_ADD_TO_LAYER,skeletonNode)
                        end
                    end
                    table.insert(self.graspHeroList,hero)
                end
            end
        end
    end
end


--抓取结束
function Effect:onGraspChange(num)
    print_("onGraspChange :"..tostring(num))

    if self.graspHeroList and #self.graspHeroList > 0 then
        local eventName = eArmtureEvent.GRASP_CHANGE..tostring(num)
        local data = self:getGraspData(eventName)
        if data then
            -- self.curGraspData = data
            local triggerShowType   = data.triggerShowType 
            local triggerShowAction = data.triggerShowAction 
            -- local triggerTier       = data.triggerTier
            local triggerAngle      = data.triggerAngle
            local grabSpeed         = data.grabSpeed
            local resource          = data.resource
            local action            = data.action
            local parent            = data.parent
            self.effectData.grabSpeed = grabSpeed

            for i, hero in ipairs(self.graspHeroList) do
                if triggerShowType == 0 then --动作无变化
                    print_("onGraspChange 动作无变化")
                elseif triggerShowType == 1 then --隐藏模型
                    print_("onGraspChange 隐藏模型")
                    hero:setVisible(false)
                elseif triggerShowType == 2 then --指定动作
                    print_("onGraspChange 指定动作.."..tostring(triggerShowAction))
                    hero:playAnimation(triggerShowAction)
                    hero:setVisible(true)
                end
                --角度
                hero:setRotation(triggerAngle)
                if ResLoader.isValid(resource) then 
                    local scale = BattleConfig.MODAL_SCALE*hero:getSkeletonNodeScale()
                    if parent == 0 then 
                        hero:getActor():playEffect(resource,scale,action)
                    else --挂在到地图
                        local  skeletonNode = ResLoader.createEffect(resource,scale,true)
                        skeletonNode:play(action,0)
                        skeletonNode:addMEListener(TFARMATURE_COMPLETE,function ( skeletonNode )
                            skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
                            if skeletonNode.resPath then
                                ResLoader.addCacheSpine(skeletonNode,skeletonNode.resPath)
                            end
                            skeletonNode:removeFromParent()
                        end)
                        local pos3d = hero:getPosition3D()
                        skeletonNode:setPosition(ccp(pos3d.x,pos3d.z))
                        EventMgr:dispatchEvent(eEvent.EVENT_EFFECT_ADD_TO_LAYER,skeletonNode)
                    end
                end
            end
        end
    end

      
    -- --角度动作
    -- --角度变化
    -- local ratation  = 0
    -- local animation = "floor"
    -- for i, hero in ipairs(self.graspHeroList) do
    --     hero:setRotation(ratation)
    --     hero:playAnimation(ratation)
    -- end
end

--从抓取列表里移除
function Effect:removeGraspHero(hero)
    if self.graspHeroList then 
        table.removeItem(self.graspHeroList,hero)
    end
end

--抓取结束
function Effect:onGraspEnd(num)
    -- print_("onGraspEnd :"..tostring(num))
    -- num 为空时 特效结束调用
    if self.graspHeroList and #self.graspHeroList > 0 then 
        if num then
            local eventName = eArmtureEvent.GRASP_END..tostring(num)
            local data = self:getGraspData(eventName)
            if data then 
                local resource          = data.resource
                local action            = data.action
                local parent            = data.parent
                for i,hero in ipairs(self.graspHeroList) do
                     hero:doGraspHurtAction()
                    if ResLoader.isValid(resource) then 
                        local scale = BattleConfig.MODAL_SCALE*hero:getSkeletonNodeScale()
                        if parent == 0 then 
                            hero:getActor():playEffect(resource,scale,action)
                        else --挂在到地图
                            local  skeletonNode = ResLoader.createEffect(resource,scale,true)
                            skeletonNode:play(action,0)
                            skeletonNode:addMEListener(TFARMATURE_COMPLETE,function ( skeletonNode )
                                skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
                                if skeletonNode.resPath then
                                    ResLoader.addCacheSpine(skeletonNode,skeletonNode.resPath)
                                end
                                skeletonNode:removeFromParent()
                            end)
                            local pos3d = hero:getPosition3D()
                            skeletonNode:setPosition(ccp(pos3d.x,pos3d.z))
                            EventMgr:dispatchEvent(eEvent.EVENT_EFFECT_ADD_TO_LAYER,skeletonNode)
                        end
                    end
                end 
            end
        else --被动移除
            for i,hero in ipairs(self.graspHeroList) do
                 hero:doGraspHurtAction()
            end 
        end
    end
    self.graspHeroList = nil
end


--抓取位置刷新
function Effect:graspUpdate(time)
    time = time * 0.001
    if self.graspHeroList and #self.graspHeroList > 0 then 
        --骨骼位置
        local moveSpeed = self.effectData.grabSpeed --移动速度
        if moveSpeed == 0 then
            -- print_("moveSpeed is 00000000000000000000000000000000000")
            return 
        end
        local mountPoint = self.effectData.mountPoint --移动速度
        local pos     = self:getWorldPosition()
        local bonePos = self:getBonePosition(mountPoint)
        for i, hero in ipairs(self.graspHeroList) do
            -- hero:setPosition3D(bonePos.x,pos.y,bonePos.y) --抓取位置变更
            local heroPos3D = hero:getPosition3D()
            local heroPos2D = ccp(heroPos3D.x,heroPos3D.z)
            local dis    = me.pGetDistance(bonePos,heroPos2D)
            if math.floor(dis) >  4 then   --抓取位置变更
                local sub        = me.pSub(bonePos,heroPos2D)
                local angel      = pGetAngle(me.p(0,0),sub)
                local xv = math.floor(math.cos(angel)*moveSpeed)*time
                local yv = math.floor(math.sin(angel)*moveSpeed)*time
                if math.abs(xv) > math.abs(sub.x)  then 
                    xv = sub.x
                end
                if math.abs(yv) > math.abs(sub.y)  then 
                    yv = sub.y
                end
                heroPos3D.x = heroPos3D.x + xv
                heroPos3D.z = heroPos3D.z + yv
                -- if self.curGraspData then
                --     -- 1在自身角色上方，2在自身角色下方
                --     if self.curGraspData.triggerTier == 2 then
                --         heroPos3D.y = pos.y -1
                --     elseif self.curGraspData.triggerTier == 1 then  
                --         heroPos3D.y = pos.y +1
                --     end 
                -- else
                --     heroPos3D.y = pos.y - 1
                -- end
                hero:setPosition3D(heroPos3D.x,heroPos3D.y,heroPos3D.z)
            end

        end
    end
end

--创建影子
function Effect:createShadow()
    if battleController.isShowAttackEffect(self.srcHero) then 
        local shadowEffect = self.effectData.shadowEffect 
        if not ResLoader.isValid(shadowEffect) then
            shadowEffect = "ui/battle/shadow.png"
            -- Box(string.format("skillEffect [%s] shadowEffect is nil",self.effectData.id))
        end
        local scale = self.effectData.shadowScale 
        if scale == 0 then 
            scale = 1
        elseif scale < 0 then  --小于0的情况下不显示影子 （BY林一峰）
            return 
        end
        local shadow = TFImage:create(shadowEffect)
        shadow:setScale(scale)
        return  shadow
    end
end

--检查目标是否回被牵引
function Effect:isTraction(target)
    if not target:canTraction() then
        return false
    end
    -- isJudgeY == 1 时判定牵引 发、判定垂直范围
    if self.effectData.isJudgeY == 1 then 
        if not self:checkRoller(target) then
            return false
        end
    end
    local position   = target:getPosition()
    local bdbox_effs = self.effectData.roller
    for k, bdbox_eff in pairs(bdbox_effs) do
        --TODO 牵引只处理矩形框
        local rect = self:getWorldBoundingBox(bdbox_eff)
        if rect.size.width > 1 or rect.size.height > 1 then
            if me.rectContainsPoint(rect,position) then
                return true
            end
        end
    end
    return false
end


--处理牵引
function Effect:excuteTraction(dt)
    dt = dt * 0.001
    local pullType = self.effectData.pullType
    if pullType == ePullType.CENTER then
        local moveSpeed = self.effectData.pullSpeedX*dt
        local c_pos = self:getWorldPosition()
        c_pos.y =  c_pos.y + self.effectData.pullCenter
        local heros = self.srcHero:getAreaEnemys(-1)
        for i,hero in ipairs(heros) do
            --检查碰撞
            if self:isTraction(hero) then
                local t_pos = hero:getPosition()
                local distance = me.pGetDistance(t_pos,c_pos)
                if distance ~= 0 then
                    t_pos = me.pSub(t_pos,c_pos)
                    local xv = t_pos.x/distance*moveSpeed
                    local yv = t_pos.y/distance*moveSpeed
                    --TODO 有点二
                    if t_pos.x < 0 then
                        if t_pos.x + xv > 0 then
                            xv = -t_pos.x
                        end
                    elseif t_pos.x > 0 then
                        if t_pos.x + xv < 0 then
                            xv = -t_pos.x
                        end
                    else
                        xv = 0
                    end
                    if t_pos.y < 0 then
                        if t_pos.y + yv > 0 then
                            yv = -t_pos.y
                        end
                    elseif t_pos.y > 0 then
                        if t_pos.y + yv < 0 then
                            yv = -t_pos.y
                        end
                    else
                        yv = 0
                    end
                    hero:traction(xv ,yv)
                end
            end
        end
    elseif pullType== ePullType.FIXED then
        --目标
        local heros = self.srcHero:getAreaEnemys(-1)
        local xv = self.effectData.pullSpeedX*dt
        local yv = self.effectData.pullSpeedY*dt
        for i,hero in ipairs(heros) do
            if self:isTraction(hero) then
                hero:traction(xv ,yv)
            end
        end
    elseif pullType == ePullType.RECT_CENTER then
        local bdbox_effs = self.effectData.roller
        local rect
        for k, bdbox_eff in pairs(bdbox_effs) do
            rect = self:getWorldBoundingBox(bdbox_eff)
            break
        end
        if not rect 
            or rect.size.width > 1000 
            or rect.size.height > 1000 
            or rect.size.width < 1 
            or rect.size.height < 1 
            or rect.origin.x > 10000 
            or rect.origin.x < -10000 then
            return
        end
        local moveSpeed = self.effectData.pullSpeedX*dt
        local c_pos = ccp(rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height / 10)
        local heros = self.srcHero:getAreaEnemys(-1)
        for i,hero in ipairs(heros) do
            --检查碰撞
            if self:isTraction(hero) then
                local t_pos = hero:getPosition()
                local distance = me.pGetDistance(t_pos,c_pos)
                if distance ~= 0 then
                    t_pos = me.pSub(t_pos,c_pos)
                    local xv = t_pos.x/distance*moveSpeed
                    local yv = t_pos.y/distance*moveSpeed
                    --TODO 有点二
                    if t_pos.x < 0 then
                        if t_pos.x + xv > 0 then
                            xv = -t_pos.x
                        end
                    elseif t_pos.x > 0 then
                        if t_pos.x + xv < 0 then
                            xv = -t_pos.x
                        end
                    else
                        xv = 0
                    end
                    if t_pos.y < 0 then
                        if t_pos.y + yv > 0 then
                            yv = -t_pos.y
                        end
                    elseif t_pos.y > 0 then
                        if t_pos.y + yv < 0 then
                            yv = -t_pos.y
                        end
                    else
                        yv = 0
                    end
                    hero:traction(xv ,yv)
                end
            end
        end
    end

end

--技能特效触发气泡
function Effect:showBubble()
    local data = self.effectData
    local textId = data.bubbleText
    local colors = data.bubbleColors
    if textId > 0 then 
        local actor = self.srcHero:getActor()
        if actor then 
            actor:showBubble(textId,colors)
        end
    end
end


--常规特效
local NormalEffect = class("NormalEffect",Effect)

function NormalEffect:ctor(data)
    self.super.ctor(self,data)
end

function NormalEffect:active(srcHero,hostType,effect,mainTarget)
    self.super.active(self,srcHero,hostType,effect,mainTarget)
    if self.effectData.hurtWay == eHurtWay.HW_HIT_TEST then
        --有可能根据碰撞判断
        self.tarList = self:getAllTarget()
        --障碍物也只做一次伤害
        self.objectIds = {}
        local objects  = obstacleMgr:getObjects()
        for i,object in ipairs(objects) do
            table.insert(self.objectIds,object:getObjectID())
        end
    end
    self:createDebugInfo()
end

function NormalEffect:update(dt)
    dt = dt* self.srcHero:getTimeScale()
    self.nTime = self.nTime + dt
    self:updateDir()
    self:skeletonNodeUpdata(dt)
    self:graspUpdate(dt)
    self:updateParticle()
    -- _print("xxxxxxxxxxxxxxxxxxxx",self.effectData.hurtWay )
    --碰撞检测
    if self.effectData.hurtWay == eHurtWay.HW_HIT_TEST then
        -- _print("self.effectData.hurtWay::",self.effectData.hurtWay)
        self:handlHurt2(1)
    end
    -- 牵引处理
    self:excuteTraction(dt)
    --如果普通特效配置了循环 也需要做倒计时处理
    if self.effectData.loop then  
        --自动回收判定
        if self:isTimeOut() then
            self:playEndEffect()
            self:preRemove(true)
        end
    end
    --检查特效移除
    self:checkRemove()
end

function NormalEffect:handlHurt2(order)
    -- print("hitTest index----",order)
    local hurtId   = self:getHurtId(order)
    -- _print("hurtId",self.effectData.id, order ,hurtId, #self.effectData.hurtList)
    -- dump(self.effectData.hurtList)
    if not hurtId or hurtId == 0  then
        return
    end
    local hurtData = BattleDataMgr:getHurtData(hurtId,self.srcHero:getAngleDatas())
    local recoveryFlag = false
    for index = #self.tarList , 1 ,-1 do
        local target = self.tarList[index]
           -- print(">>>>>>>>>>>>>>>>>>111")
        if not target:isRealDead() then
            if target:canHit(hurtData.isHurtFloor) then -- 判断是否可以攻击倒地目标
                if self:hitTest(target) then
                    -- _print("是否是背击:"..tostring(self:isStrikeBack(target)))
                    self:tryTriggerAIMEvent(hurtData.damageType,target)
                    self:recoveryAnger1(hurtData)
                    self:triggerBuffer(hurtData,target)
                    self:triggerHurt(target,hurtData)
                    --清理释放者的临时属性
                    self:cleanTempProperty(target)
                    print("hitTest2----",true)
                    if self.effectData.hurtWay == eHurtWay.HW_HIT_TEST then --帧事件不做移除处理
                        battleController._eatMonsterItem(target, self.srcHero)
                        table.remove(self.tarList,index)
                    end
                    self:showHitLine(target:getPosition(),hurtData)
                    if self.effectData.recycle > 0 then
                        if self.nHitCount >= self.effectData.recycle then
                            self:preRemove(true)
                            return
                        end
                    end
                end
            end
        else
    -- 死亡的排除掉
            table.remove(self.tarList,index)
        end
    end


    --障碍物碰撞判定(有效碰撞有需要需要剔除)
    local objects = obstacleMgr:getObjects()
    for index = #objects  , 1  , -1 do
        local object = objects[index]
        if self:isValidObject(object:getObjectID()) then
            if object:canHurt() and self:hitTest(object) then
                table.removeItem(self.objectIds,object:getObjectID())
                object:doHurt(self.srcHero)
            end
        else
            table.removeItem(self.objectIds,object:getObjectID())
        end
    end


end


--垂直范围判断(特效攻击特效专用)
function NormalEffect:checkRoller_effect(effect)
    local posY = self.position3D.y
    local tarY = effect:getWorldPosition3D().y
    if self.effectData.yRollerSetShadow then
        posY = tarY
    end
    if self.effectData.parent == eParent.CASTER then
        posY = self:getCasterPosition().y
    end
    local minV = posY - self.effectData.yRoller[2]
    local maxV = posY + self.effectData.yRoller[1]
    -- print(posY,minV,maxV,tarY)
    if tarY >= minV and tarY <= maxV then
        -- print(">>>>>>>>>>>true>>>>>>>>>>>>>>>")
        return true
    end
    return false
end

function NormalEffect:hitTestEffect(target)
    if target.bPreRemove then 
        return false
    end
    if not self:checkRoller_effect(target) then
        return false
    end

    local rollerType = self.effectData.rollerType
    --TODO目前检测只要一个满足条件就认为产生伤害
    local bdbox_effs = self.effectData.roller
    local bdboxs     = target.effectData.roller
    self:drawNodeClear()
    for a , bdbox_eff in ipairs(bdbox_effs) do
        for b , bdbox in ipairs(bdboxs) do
            if rollerType == 1 then --多边形碰撞
                --多边形碰撞
                local pts1  = self:getCollisionWithName(bdbox_eff)
                local pts2  = target:getCollisionWithName(bdbox)
                self:drawLine(pts1 ,rollerType)
                self:drawLine(pts2 ,rollerType)
                local result = BattleUtils.isPolygonInterSection(pts1,pts2)
                if result then
                    return true
                end
            else
                --矩形碰撞
                local rect = self:getWorldBoundingBox(bdbox_eff)
                self:drawLine(rect,rollerType)
                if rect.size.width < 1 or rect.size.height < 1 then
                    _print("hit test effect1 box error", rect)
                    break
                end
                local hitrect  = target:getWorldBoundingBox(bdbox)
                self:drawLine(hitrect ,rollerType)
                if hitrect.size.width < 1 or hitrect.size.height < 1 then
                    -- 碰撞框大小为0
                    _print("hit test effect2 box error", hitrect)
                    break
                end
                local result = me.rectIntersectsRect(rect,hitrect)
                if result then
                    return true
                end
            end
        end
    end

end





function NormalEffect:handlHurt(order)
    -- print("hitTest index----",order)
    -- self.effectData.crashEffect = 2
    if self.effectData.crashEffect == 2 then  -- 特效可以攻击放射行特效
        local sufferChange = self.effectData.sufferChange   --被命中特效的变化（0无影响，1回收，2直接删除不触发回收）
        local newEffect    = self.effectData.newEffect
        --找到所有可以攻击的特效
        local camp   = self.srcHero:getCamp() 
        local objects = effectMgr:getObjects()
        local effectList  = {}
        for i, effect in ipairs(objects) do
            -- print_("111111111111111111111")
            if effect.effectData.effectType == eEffectType.EMIT and effect.effectData.isEffectHit == 0 then --放出型特效
                local _camp = effect.srcHero:getCamp() 
                -- print_("22222222222222222222222222"..tostring(BattleUtils.campState(camp,_camp) ))
                if BattleUtils.campState(camp,_camp) == 2 then
                    -- print_("3333333333333333")
                    if self:hitTestEffect(effect) then 
                        -- print_("攻击到特效了。。。。。。。。。。。")
                        if newEffect > 0 then 
                            effect:createNewEffect(newEffect)
                        end
                        if sufferChange == 1 then --移除带回收特效
                            effect:playEndEffect()
                            effect:preRemove()
                        elseif sufferChange == 2 then --移除不带回收特效
                            effect:preRemove()
                        end
                    end
                end  
            end
        end 
    end
    --
    local hurtId   = self:getHurtId(order)
    if hurtId == 0 then
        return
    end
    local hurtData = BattleDataMgr:getHurtData(hurtId,self.srcHero:getAngleDatas())
    self:triggerNoHitBuffer(hurtData)
    self.bRecoveryAngerFlag = false
    local isHited = false --是否命中
    --hurt事件触发
    local targets = self:getAllTarget()
    for k , target in ipairs(targets) do
        if target:canHit(hurtData.isHurtFloor) then
            if self:hitTest(target) then
                -- _print("是否是背击:"..tostring(self:isStrikeBack(target)))
                self:tryTriggerAIMEvent(hurtData.damageType,target)
                self:recoveryAnger1(hurtData)
                --
                self:triggerBuffer(hurtData,target)
                --TODO 伤害处理
                self:triggerHurt(target,hurtData)
                --清理释放者的临时属性
                self:cleanTempProperty(target)
                -- print("hitTest true ----",hurtId)
                self:showHitLine(target:getPosition(),hurtData)
                isHited = true
            else
                -- print("hitTest false ----",hurtId)
            end
        end
    end

    self:setAlreadyShowHitLine(false)
    --障碍物碰撞判定
    local objects = obstacleMgr:getObjects()
    for index = #objects  , 1  , -1 do
        if objects[index]:canHurt() and self:hitTest(objects[index]) then
            objects[index]:doHurt(self.srcHero)
        end
    end
    --震屏处理
    self:screenWobble(hurtData,isHited)
end




--发射型特效
local EmitEffect = class("EmitEffect",Effect)

function EmitEffect:ctor(data)
    self.super.ctor(self,data)
    --发射性特效
    self.tarList      = {}  --所有目标
    self.tarHero      = nil --锁定的目标
    --初始化速度
    self.xv = 0
    self.yv = 0
    self.prePos       = me.p(0,0)
    self.xyv        = 0
    --feudal目标位置导弹使用
    self.tarPos     = me.p(0,0)
end


function EmitEffect:getSortY()
    if self.effectData.tailType == eTailType.STRAIGHT then --直线
        return self.position3D.y
    else
        return 9999  --跟踪导弹在最上层
    end
end



    -- STRAIGHT       = 0 , --直线
    -- STEEP          = 1 , --跟踪
    -- ANGLE_STEEP    = 2 , --角度跟踪

function EmitEffect:active(srcHero,hostType,effect,mainTarget)
    -- self.effectData.besselHeight = -300
    self.super.active(self,srcHero,hostType,effect,mainTarget)
    local hostDir = self.parentNode:getDir()
    if self.effectData.effectsOrientationX == 1 then --指定向右
        hostDir = eDir.RIGHT
    elseif self.effectData.effectsOrientationX == 2 then --向左
        hostDir = eDir.LEFT
    end
    self.prePos = self:getPosition()
    self._rotation = 0
    local tailType  = self.effectData.tailType
    local emitSpeed = self.effectData.emitSpeed
    local totalTime = self.effectData.totalTime

    if tailType == eTailType.BEZIER_RANDOM_POS then -- 11 贝塞尔曲线随机随机位置
        self.tarPos = self:randomTarPos(true)
        local startPos       = self:getWorldPosition()
        local endPosition    = me.pSub(self.tarPos,startPos)
        local controlPoint_1 = me.p(0,0)
        local controlPoint_2 = me.p(endPosition.x/3,self.effectData.besselHeight)
        self._config = {
                        controlPoint_1 = controlPoint_1,
                        controlPoint_2 = controlPoint_2,
                        endPosition    = endPosition
                       }
        local distance     = me.pGetDistance(controlPoint_2,controlPoint_1) + me.pGetDistance(endPosition,controlPoint_2)
        self._elapsedTime  = 0
        self._durationTime = distance/emitSpeed --算出持续时间
        self._startPos     = me.p(0,0)

    elseif tailType == eTailType.RANDOM_POS then
        --寻找锁定的目标
        -- self.tarHero = self:selectTarget()[1]
        self.tarList = self:getAllTarget() --目标丢失的情况下使用
        self.tarPos = self:randomTarPos()
        local dis  = me.pGetDistance(self.tarPos,self.prePos)
        -- local passTime   = dis/self.effectData.emitSpeed
        local sub        = me.pSub(self.tarPos,self.prePos)
        local angel      = pGetAngle(me.p(0,0),sub)
        local rotation   = -1*math.deg(angel)
        -- self._xv = sub.x/passTime
        -- self._yv = sub.y/passTime
        self._xv = math.floor(math.cos(angel)*emitSpeed)
        self._yv = math.floor(math.sin(angel)*emitSpeed)
        self.skeletonNode:setRotation(rotation)
    elseif tailType == eTailType.TIMMER_FIND_POS then
        self.movePauseTime = 0
        self.tarHero = self:selectNearlyTarget()
        self.tarList = self:getAllTarget() --目标丢失的情况下使用
        if not self.tarHero then
            self.tarHero = self.tarList[1]
        end
        if self.tarHero then
            self.tarPos  = self.tarHero:getHitPosition()
        else
            if hostDir == eDir.LEFT then
                self.tarPos = me.pAdd(self.prePos,me.p(-400,0))
            else
                self.tarPos = me.pAdd(self.prePos,me.p(400,0))
            end
        end
        local area = self.effectData.area
        local rect = me.rect( area[1], area[2], area[3], area[4])
        rect.origin = me.pAdd(self.tarPos,rect.origin)
        self.tarPos = levelParse:randomPos(rect)
        
        local dis  = me.pGetDistance(self.tarPos,self.prePos)
        local sub        = me.pSub(self.tarPos,self.prePos)
        local angel      = pGetAngle(me.p(0,0),sub)
        self._xv = math.floor(math.cos(angel)*self.effectData.emitSpeed)
        self._yv = math.floor(math.sin(angel)*self.effectData.emitSpeed)
    elseif tailType == eTailType.TARGET_POS or tailType == eTailType.TARGET_SHADOW_POS then --(飞目标位置)
        --寻找锁定的目标
        self.tarHero = self:selectTarget()[1]
        self.tarList = self:getAllTarget() --目标丢失的情况下使用
        if self.tarHero then
            if tailType == eTailType.TARGET_POS then
                self.tarPos  = self.tarHero:getHitPosition() --计算锁定的位置
            else
                self.tarPos  = self.tarHero:getPosition() --计算锁定影子位置
            end
        else --TODO 没有找到目标
            if hostDir == eDir.LEFT then
                self.tarPos = me.pAdd(self.prePos,me.p(-800,0))
            else
                self.tarPos = me.pAdd(self.prePos,me.p(800,0))
            end
        end
        local dis  = me.pGetDistance(self.tarPos,self.prePos)
        -- local passTime   = dis/self.effectData.emitSpeed
        local sub        = me.pSub(self.tarPos,self.prePos)
        local angel      = pGetAngle(me.p(0,0),sub)
        local rotation   = -1*math.deg(angel)
        -- self._xv = sub.x/passTime
        -- self._yv = sub.y/passTime
        self._xv = math.floor(math.cos(angel)*emitSpeed)
        self._yv = math.floor(math.sin(angel)*emitSpeed)
        self.skeletonNode:setRotation(rotation)
    elseif tailType == eTailType.STRAIGHT then
        self.xyv = emitSpeed
        self._xv = self.xyv
        self._yv = 0
        --做镜像操作
        if hostDir == eDir.LEFT then
            self.xyv = -emitSpeed
            self._xv = self.xyv
            local scale = self.skeletonNode:getScaleX()
            self.skeletonNode:setScaleX(-math.abs(scale))
        end

        if self.effectData.rotation ~= 0 then
            self.xyv  = self.effectData.emitSpeed
            local rotation = self.effectData.rotation
            local angel =  math.rad(rotation)   -- math.pi/6*5
            self._xv = math.floor(math.cos(angel)*self.effectData.emitSpeed)
            self._yv = math.floor(math.sin(angel)*self.effectData.emitSpeed)
            self._rotation = rotation
        end

        self.tarList = self:getAllTarget()
        --创建影子
        self.shadow = self:createShadow()
        if self.shadow then
            EventMgr:dispatchEvent(eEvent.EVENT_EFFECT_ADD_TO_LAYER,self.shadow,1)
        end

        --保存障碍物的ID
        self.objectIds = {}
        local objects  = obstacleMgr:getObjects()
        for i,object in ipairs(objects) do
            table.insert(self.objectIds,object:getObjectID())
        end

    elseif tailType == eTailType.ANGLE or  tailType == eTailType.REFRACTION then --直线
        -- _print("xxxxID: ",self.effectData.id)
        self.xyv  = self.effectData.emitSpeed
        local rotation = self.effectData.rotation
        if hostDir == eDir.LEFT then
            self.xyv  = -self.effectData.emitSpeed
            rotation = 180 - self.effectData.rotation
        end
        local angel =  math.rad(rotation)   -- math.pi/6*5
        self._xv = math.floor(math.cos(angel)*self.effectData.emitSpeed)
        self._yv = math.floor(math.sin(angel)*self.effectData.emitSpeed)
        self.skeletonNode:setRotation(-rotation)
        self._rotation = rotation


        self.tarList = self:getAllTarget()
        --创建影子
        self.shadow = self:createShadow()
        if self.shadow then
            EventMgr:dispatchEvent(eEvent.EVENT_EFFECT_ADD_TO_LAYER,self.shadow,1)
        end
        --保存障碍物的ID
        self.objectIds = {}
        local objects  = obstacleMgr:getObjects()
        for i,object in ipairs(objects) do
            table.insert(self.objectIds,object:getObjectID())
        end

elseif tailType == eTailType.ROUND or tailType == eTailType.S_CURVE then --直线


        self.xyv  = self.effectData.emitSpeed
        local rotation = -90  --self.effectData.rotation
        if shostDir == eDir.LEFT then
            self.xyv  = -self.effectData.emitSpeed
            rotation = 180 - rotation
        end
        local angel =  math.rad(rotation)   -- math.pi/6*5
        self._xv = math.floor(math.cos(angel)*self.effectData.emitSpeed)
        self._yv = math.floor(math.sin(angel)*self.effectData.emitSpeed)
        self.skeletonNode:setRotation(-rotation)
        self._rotation = rotation


        self.tarList = self:getAllTarget()
        --创建影子
        self.shadow = self:createShadow()
        if self.shadow then
            EventMgr:dispatchEvent(eEvent.EVENT_EFFECT_ADD_TO_LAYER,self.shadow,1)
        end
        --保存障碍物的ID
        self.objectIds = {}
        local objects  = obstacleMgr:getObjects()
        for i,object in ipairs(objects) do
            table.insert(self.objectIds,object:getObjectID())
        end
    elseif tailType == eTailType.STEEP then --跟踪
        --寻找锁定的目标
        self.tarHero = self:selectTarget()[1]
        self.tarList = self:getAllTarget() --目标丢失的情况下使用
    elseif tailType == eTailType.ANGLE_STEEP then --角度跟踪
        --寻找锁定的目标
        self.tarHero = self:selectTarget()[1]
        self.tarList = self:getAllTarget() --目标丢失的情况下使用

        --确定初始方向
        if self.tarHero then
            local pos  = self.tarHero:getHitPosition() --计算锁定的位置
            if pos.x > self.prePos.x then
                self.angelTailDir = eDir.RIGHT
            else
                self.angelTailDir = eDir.LEFT
            end
        else
            self.angelTailDir = self.srcHero:getDir()
        end
    elseif tailType == eTailType.BEZIER then --贝塞尔曲线
        local startPos = self:getWorldPosition()
        local tarPos   = me.p(200,0)
        self.tarHero = self:selectTarget()[1]
        self.tarList = self:getAllTarget()
        if self.tarHero then
            tarPos     = self.tarHero:getPosition() --计算锁定的位置
        else
            --TODO 未找到目标,以释放者的位置为基础做左右位移
            local srcPos = self.srcHero:getPosition()
            if hostDir == eDir.LEFT then
                tarPos = me.pAdd(srcPos,me.p(-300,0))
            else
                tarPos = me.pAdd(srcPos,me.p(300,0))
            end
        end

        local endPosition    = me.pSub(tarPos,startPos)
        local controlPoint_1 = me.p(0,0)
        local controlPoint_2 = me.p(endPosition.x/3,self.effectData.besselHeight)
        self._config = {
                        controlPoint_1 = controlPoint_1,
                        controlPoint_2 = controlPoint_2,
                        endPosition    = endPosition
                       }
        local distance     = me.pGetDistance(controlPoint_2,controlPoint_1) + me.pGetDistance(endPosition,controlPoint_2)
        self._elapsedTime  = 0
        self._durationTime = distance/emitSpeed --算出持续时间
        self._startPos     = me.p(0,0)
    elseif  tailType == eTailType.BEZIER_POS or tailType == eTailType.BEZIER_POS_HIT then --贝塞尔曲线根据速度时间和朝向计算位置        
        -- _print(self._durationTime) --算出持续时间
        -- dump(self._config)
        local startPos = self:getWorldPosition()
        local tarPos   = me.p(200,0)
        self.tarHero = self:selectTarget()[1]
        self.tarList = self:getAllTarget()
        local offsetX = emitSpeed*totalTime*0.001
        --计算目标位置
        local srcPos = self.srcHero:getPosition()
        if hostDir == eDir.LEFT then
            tarPos = me.pAdd(srcPos,me.p(-offsetX,0))
        else
            tarPos = me.pAdd(srcPos,me.p(offsetX,0))
        end
        local endPosition    = me.pSub(tarPos,startPos)
        local controlPoint_1 = me.p(0,0)
        local controlPoint_2 = me.p(endPosition.x/3,self.effectData.besselHeight)
        self._config = {
                        controlPoint_1 = controlPoint_1,
                        controlPoint_2 = controlPoint_2,
                        endPosition    = endPosition
                       }
        local distance     = me.pGetDistance(controlPoint_2,controlPoint_1) + me.pGetDistance(endPosition,controlPoint_2)
        self._elapsedTime  = 0
        self._durationTime = totalTime*0.001 --distance/emitSpeed --算出持续时间
        self._startPos     = me.p(0,0)
    end
    self:createDebugInfo()
end

function EmitEffect:checkResetMoveParams(time)
    local tailType  = self.effectData.tailType
    if tailType == eTailType.TIMMER_FIND_POS then
        if self.effectData.pauseTime > 0 then
            self.movePauseTime = self.movePauseTime or 0
            self.movePauseTime = self.movePauseTime + time
            if self.movePauseTime > self.effectData.pauseTime then
                self.movePauseTime = 0
                local hostDir = self.parentNode:getDir()
                self.tarHero = self:selectNearlyTarget()
                self.prePos = self:getPosition()
                if not self.tarHero then
                    self.tarHero = self.tarList[1]
                end
                if self.tarHero then
                    self.tarPos  = self.tarHero:getHitPosition()
                else
                    if hostDir == eDir.LEFT then
                        self.tarPos = me.pAdd(self.prePos,me.p(-400,0))
                    else
                        self.tarPos = me.pAdd(self.prePos,me.p(400,0))
                    end
                end
                local area = self.effectData.area
                local rect = me.rect( area[1], area[2], area[3], area[4])
                rect.origin = me.pAdd(self.tarPos,rect.origin)
                self.tarPos = levelParse:randomPos(rect)
                local dis  = me.pGetDistance(self.tarPos,self.prePos)
                local sub        = me.pSub(self.tarPos,self.prePos)
                local angel      = pGetAngle(me.p(0,0),sub)
                self._xv = math.floor(math.cos(angel)*self.effectData.emitSpeed)
                self._yv = math.floor(math.sin(angel)*self.effectData.emitSpeed)
            end
        end
    end
end


function EmitEffect:logic(time)
    self:checkResetMoveParams(time)
    local tailType = self.effectData.tailType
    -- print("tailType:::",tailType)
    if tailType == eTailType.TARGET_POS 
    or tailType == eTailType.RANDOM_POS 
    or tailType == eTailType.TARGET_SHADOW_POS
    or tailType == eTailType.TIMMER_FIND_POS then --锁定目标位置
        self:toTargetPos(time)
    elseif tailType == eTailType.STRAIGHT then --直线
        self:straight(time)
    elseif tailType == eTailType.ANGLE then
        self:straight(time)
    elseif tailType == eTailType.STEEP then --跟踪
        self:tail(time)
    elseif tailType == eTailType.ANGLE_STEEP then --角度跟踪
        self:angleTail(time)
    elseif tailType == eTailType.ROUND then --环形前进
        self:round(time)
    elseif tailType == eTailType.S_CURVE then --S曲线
        self:s_curve(time)
    elseif tailType == eTailType.REFRACTION then --折射
        self:refraction(time)
    elseif tailType == eTailType.BEZIER 
        or tailType == eTailType.BEZIER_POS 
        or tailType == eTailType.BEZIER_RANDOM_POS
        or tailType == eTailType.BEZIER_POS_HIT then --贝塞尔曲线
        self:bezier(time)
    end
    self:move()
end


function EmitEffect:move()
    local lastPos = clone(self.position3D)
    local positionZ = self.position3D.z
    self.prePos.x = self.prePos.x + self.xv
    self.prePos.y = self.prePos.y + self.yv
    self.position3D.x = self.prePos.x 
    self.position3D.z = self.prePos.y
    local tailType = self.effectData.tailType
    if tailType == eTailType.BEZIER
        or tailType == eTailType.ANGLE_STEEP  
        or tailType == eTailType.BEZIER_POS 
        or tailType == eTailType.BEZIER_RANDOM_POS
        or tailType == eTailType.BEZIER_POS_HIT then --贝塞尔曲线
        self.position3D.y = self.position3D.z
    elseif tailType == eTailType.ANGLE 
        or tailType == eTailType.TARGET_SHADOW_POS
        or tailType == eTailType.TARGET_POS then
        self.position3D.y = self.position3D.y + self.position3D.z - positionZ
    elseif tailType == eTailType.STRAIGHT then
        if self._rotation ~= 0 then
            self.position3D.y = self.prePos.y
            if not battleController.canMove(self.position3D.x ,self.position3D.y) then
                self.position3D = lastPos
            end
        end
    end
    self:setPosition3D(self.position3D.x, self.position3D.y,self.position3D.z)
    --影子处理
    if self.shadow then
        self.shadow:setPosition(self.position3D.x,self.position3D.y)
    end

end

function EmitEffect:_onExit()
    self.super._onExit(self)
    if self.shadow then
        self.shadow:removeFromParent()
        self.shadow = nil
    end
end

function EmitEffect:update(time)
    time = time* self.srcHero:getTimeScale()
    self.nTime = self.nTime + time
    self:skeletonNodeUpdata(time)
    --自动回收判定
    if self:isTimeOut() then
        self:playEndEffect()
        self:preRemove(true)
    else
        self:logic(time)
        -- 牵引处理(放出型只支持直线)
        if self.effectData.tailType == eTailType.STRAIGHT then 
            self:excuteTraction(time)
        end
        self:updateParticle()
        --1帧处理碰撞/碰撞检测 是有帧事件出来碰撞
        if self.effectData.hurtWay == eHurtWay.HW_HIT_TEST then
            self:handlHurt(1)
        end
    end
    --检查移除
    self:checkRemove()
end

 --点对点
 --TODO 新增多受击框以后是否要调整
function EmitEffect:_hitTest(target)
    if target and target:isAlive() then
        --TODO 每一帧都检查有点费
        if self:hitTest(target,false) then
            return true
        else
            local targetPos  = target:getHitPosition()
            local dis        = me.pGetDistance(targetPos,self.prePos)
            if dis <  10 then
                return true
            end
        end
    end
    return false
end


function EmitEffect:handlHurt(order)
    local hurtId   = self:getHurtId(order)
    if hurtId == 0 then 
        return
    end
    local hurtData = BattleDataMgr:getHurtData(hurtId,self.srcHero:getAngleDatas())
    local tailType = self.effectData.tailType
    if self.effectData.hurtWay == eHurtWay.HW_FRAME then
        self:triggerNoHitBuffer(hurtData)
        self.tarList = self:getAllTarget() --子弹类型帧事件触发的特效调整为每次检查攻击目标
    end
    self.bRecoveryAngerFlag = false
    if tailType == eTailType.TARGET_POS 
    or tailType == eTailType.RANDOM_POS 
    or tailType == eTailType.TARGET_SHADOW_POS then
        for index = #self.tarList , 1 ,-1 do
            print("xxxxxxxxx>>>>>>>>>>>>>>",index)
            local target = self.tarList[index]
               -- print(">>>>>>>>>>>>>>>>>>111")
            if not target:isRealDead()  then
                if target:canHit(hurtData.isHurtFloor) then
                    if self:_hitTest(target) then
                        self:tryTriggerAIMEvent(hurtData.damageType,target)
                        self:screenWobbleOnce(hurtData)
                        self:recoveryAnger1(hurtData)
                        self:triggerBuffer(hurtData,target)
                        self:triggerHurt(target,hurtData)
                        --清理释放者的临时属性
                        self:cleanTempProperty(target)
                        self:showHitLine(target:getPosition(),hurtData)
                        print("hitTest TARGET_POS----",true)
                        --点对点的命中目标总是要回收的
                        self:preRemove(true)
                        return
                    end
                end
            else
        -- 死亡的排除掉
                table.remove(self.tarList,index)
            end
        end
        --是否已经抵达目标位置
        if self:isArriveTargetPos() then
            self:playEndEffect()
            self:preRemove(true)
            return
        end
        --固定目标的不打障碍物
    elseif tailType == eTailType.TIMMER_FIND_POS then
        for index = #self.tarList , 1 ,-1 do
            local target = self.tarList[index]
            if not target:isRealDead()  then
                if target:canHit(hurtData.isHurtFloor) then
                    if self:_hitTest(target) then
                        self:tryTriggerAIMEvent(hurtData.damageType,target)
                        self:screenWobbleOnce(hurtData)
                        self:recoveryAnger1(hurtData)
                        self:triggerBuffer(hurtData,target)
                        self:triggerHurt(target,hurtData)
                        --清理释放者的临时属性
                        self:cleanTempProperty(target)
                        self:showHitLine(target:getPosition(),hurtData)
                        return
                    end
                end
            else
                table.remove(self.tarList,index)
            end
        end
    elseif tailType == eTailType.BEZIER 
        or tailType == eTailType.BEZIER_POS
        or tailType == eTailType.BEZIER_RANDOM_POS then
        -- for index = #self.tarList , 1 ,-1 do
        --     print("xxxxxxxxx>>>>>>>>>>>>>>",index)
        --     local target = self.tarList[index]
        --        -- print(">>>>>>>>>>>>>>>>>>111")
        --     if not target:isRealDead() then
        --         if self:hitTest(target,false) then
        --             self:recoveryAnger1(hurtData)
        --             self:triggerBuffer(hurtData,target)
        --             self:triggerHurt(target,hurtData)
        --             self:showHitLine(target:getPosition(),hurtData)
        --             print("hitTest TARGET_POS----",true)
        --             --点对点的命中目标总是要回收的
        --             self:preRemove(true)
        --             return
        --         end
        --     else
        -- -- 死亡的排除掉
        --         table.remove(self.tarList,index)
        --     end
        -- end
        -- 不檢查傷害
        -- 到達目的地自動回收
        if self._elapsedTime >= self._durationTime then
            if self._startPos.y <= self._config.endPosition.y then
                self:playEndEffect()
                self:preRemove(true)
                return
            end
        end
    elseif tailType == eTailType.BEZIER_POS_HIT then
        for index = #self.tarList , 1 ,-1 do
            local target = self.tarList[index]
            if not target:isRealDead() then
                if self:hitTest(target,false) then
                    self:recoveryAnger1(hurtData)
                    self:triggerBuffer(hurtData,target)
                    self:triggerHurt(target,hurtData)
                    self:showHitLine(target:getPosition(),hurtData)
                    print("hitTest TARGET_POS----",true)
                    --点对点的命中目标总是要回收的
                    self:preRemove(true)
                    return
                end
            else
        -- 死亡的排除掉
                table.remove(self.tarList,index)
            end
        end
        if self._elapsedTime >= self._durationTime then
            if self._startPos.y <= self._config.endPosition.y then
                self:playEndEffect()
                self:preRemove(true)
                return
            end
        end
    elseif tailType == eTailType.STRAIGHT
        or tailType == eTailType.ANGLE
        or tailType == eTailType.ROUND
        or tailType == eTailType.S_CURVE
        or tailType == eTailType.REFRACTION then
        -- print(">>>>>>>>>>>>>>>>>>111",#self.tarList)
        local recoveryFlag = false
        for index = #self.tarList , 1 ,-1 do
            local target = self.tarList[index]
               -- print(">>>>>>>>>>>>>>>>>>111")
            if not target:isRealDead() then
                if target:canHit(hurtData.isHurtFloor) then -- 判断是否可以攻击倒地目标
                    if self:hitTest(target) then
                        self:tryTriggerAIMEvent(hurtData.damageType,target)
                        self:screenWobbleOnce(hurtData)
                        self:recoveryAnger1(hurtData)
                        self:triggerBuffer(hurtData,target)
                        self:triggerHurt(target,hurtData)
                        --清理释放者的临时属性
                        self:cleanTempProperty(target)
                        print("hitTest2----",true)
                        if self.effectData.hurtWay == 2 then --帧事件不做移除处理
                            table.remove(self.tarList,index)
                        end
                        self:showHitLine(target:getPosition(),hurtData)
                        if self.effectData.recycle > 0 then
                            if self.nHitCount >= self.effectData.recycle then
                                self:preRemove(true)
                                return
                            end
                        end
                    end
                end
            else
        -- 死亡的排除掉
                table.remove(self.tarList,index)
            end
        end


        --障碍物碰撞判定(有效碰撞有需要需要剔除)
        local objects = obstacleMgr:getObjects()
        for index = #objects  , 1  , -1 do
            local object = objects[index]
            if self:isValidObject(object:getObjectID()) then
                local _isBlockEmitEffect = object:isBlockEmitEffect() --障碍是否阻挡子弹
                local _canHurt           = object:canHurt()
                if _canHurt or _isBlockEmitEffect then 
                    if self:hitTest(object) then 
                        if _canHurt then 
                            table.removeItem(self.objectIds,object:getObjectID())
                            object:doHurt(self.srcHero)
                        end
                        if _isBlockEmitEffect then 
                            self:preRemove(true)
                            break
                        end
                    else

                    end
                end
            else
                table.removeItem(self.objectIds,object:getObjectID())
            end
        end
    elseif tailType == eTailType.ANGLE_STEEP then
        if self.tarHero then
            if self.tarHero:isAlive() then
                if self.tarHero:canHit(hurtData.isHurtFloor) then
                    if self:_hitTest(self.tarHero) then
                        self:tryTriggerAIMEvent(hurtData.damageType,self.tarHero)
                        self:screenWobbleOnce(hurtData)
                        self:recoveryAnger1(hurtData)
                        self:triggerBuffer(hurtData,self.tarHero)
                        self:triggerHurt(self.tarHero,hurtData)
                        --清理释放者的临时属性
                        self:cleanTempProperty(self.tarHero)
                        self:showHitLine(self.tarHero:getPosition(),hurtData)
                        self:preRemove(true)
                        return
                    end
                end
            else
                self:playEndEffect()
                self:preRemove(true)
                return
            end
        end
    elseif tailType == eTailType.STEEP then
        -- print(">>>>>>>>>>>>>>>>>>2222")
        if self.tarHero then
            if self.tarHero:isAlive() then
                if self.tarHero:canHit(hurtData.isHurtFloor) then
                    if self:_hitTest(self.tarHero) then
                        self:tryTriggerAIMEvent(hurtData.damageType,self.tarHero)
                        self:screenWobbleOnce(hurtData)
                        self:recoveryAnger1(hurtData)
                        self:triggerBuffer(hurtData,self.tarHero)
                        self:triggerHurt(self.tarHero,hurtData)
                        --清理释放者的临时属性
                        self:cleanTempProperty(self.tarHero)
                        self:showHitLine(self.tarHero:getPosition(),hurtData)
                        self:preRemove(true)
                        return
                    end
                end
            else
                self:playEndEffect()
                self:preRemove(true)
                return
            end
        end
        -- 计算跟踪子弹与其他玩家的碰撞
        -- for index = #self.tarList , 1 ,-1 do
        --     local target = self.tarList[index]
        --     if not target:isRealDead() then
        --         if self:hitTest(target) then
        --             self:triggerHurt(target,hurtData)
        --             table.remove(self.tarList,index)
        --             -- if self.effectData.recycle then
        --                 self:preRemove(true)
        --                 return
        --             -- end
        --         end
        --     else
        -- -- 死亡的排除掉
        --         table.remove(self.tarList,index)
        --     end
        -- end

    end
end

--检查是否抵达目标位置(点对点类型导弹)
function EmitEffect:isArriveTargetPos()
    local dis = me.pGetDistance(self.tarPos,self.prePos)
    if math.floor(dis) < 4 then
        return true
    end
    return false
end

--锁定目标位置
function EmitEffect:toTargetPos(time)
    time = time * 0.001
    self:doFlashRed()
    local targetPos  = self.tarPos
    local effectPos  = self.prePos
    local dis        = me.pGetDistance(targetPos,effectPos)
    local limitDis = math.sqrt(self.xv*self.xv + self.yv*self.yv)
    if limitDis > 4 then
        self._limitDis = limitDis
    end
    if math.floor(dis) < self._limitDis then
        self.xv = 0
        self.yv = 0
        return
    else
        self.xv = self._xv*time
        self.yv = self._yv*time
    end


end


    -- ROUND          = 4 , --环形飞行
    -- S_CURVE        = 5 , --S曲线前进
    -- REFRACTION     = 6 , --折射前进

--环形
function EmitEffect:round(time)
    time = time * 0.001
--旋转前进
    self._rotation = self._rotation +  time*360*self.xyv/(2*math.pi*100)
    self._rotation = self._rotation % 360
    local rotation  = self._rotation
    self.skeletonNode:setRotation(-rotation)
    local angel =  math.rad(rotation)
    self._xv = math.floor(math.cos(angel)*self.effectData.emitSpeed)
    self._yv = math.floor(math.sin(angel)*self.effectData.emitSpeed)
    self._xv = self._xv + self.xyv/4 --TODO 真实的移动速度 是否要计算半径衰减
    self.xv = self._xv*time
    self.yv = self._yv*time


end

--s曲线
function EmitEffect:s_curve(time)
    time = time * 0.001

--旋转前进
    self._rotation = self._rotation +  time*360*self.xyv/(2*math.pi*self.effectData.radius)
    self._rotation = self._rotation % 360
    local rotation  = self._rotation
    --S曲线
    if self.xyv > 0 then
        if self._rotation > 90  and self._rotation < 270 then
            rotation = 180 - self._rotation
        end
    else
        if self._rotation < 90 and self._rotation > 0 then
            rotation = 180 - self._rotation
        elseif self._rotation > 270 and self._rotation < 360 then
            rotation = 180 - self._rotation
        end
    end

    -- _print("self._rotation ",self._rotation )
    self.skeletonNode:setRotation(-rotation)
    local angel =  math.rad(rotation)
    self._xv = math.floor(math.cos(angel)*self.effectData.emitSpeed)
    self._yv = math.floor(math.sin(angel)*self.effectData.emitSpeed)

    self.xv = self._xv*time
    self.yv = self._yv*time

end

--折射
function EmitEffect:refraction(time)

    if self.willRefraction then --折射处理
        self.willRefraction = false
        self._rotation = - self._rotation
        local rotation = self._rotation
        self.skeletonNode:setRotation(-rotation)
        local angel =  math.rad(rotation)
        self._xv = math.floor(math.cos(angel)*self.effectData.emitSpeed)
        self._yv = math.floor(math.sin(angel)*self.effectData.emitSpeed)
    end

--TODO  根据时间折射
--     if not self.nRefractionTime then
--         self.nRefractionTime = 0
--     end
--     self.nRefractionTime = self.nRefractionTime + time
-- --折线前进
--     -- _print("self.nRefractionTime ",self.nRefractionTime, time ,self.effectData.refractionTime )
--     if self.nRefractionTime > self.effectData.refractionTime then
--         self.nRefractionTime  = 0
--         self._rotation = - self._rotation
--         local rotation = self._rotation
--         self.skeletonNode:setRotation(-rotation)
--         local angel =  math.rad(rotation)
--         self._xv = math.floor(math.cos(angel)*self.effectData.emitSpeed)
--         self._yv = math.floor(math.sin(angel)*self.effectData.emitSpeed)
--     end
    time = time * 0.001
    self.xv = self._xv*time
    self.yv = self._yv*time

    local willPos = self.position3D.y + self.yv
    local result , offset = battleController.checkVertical(willPos)
    if result == 1 then
        --下方折射
        if self.yv <= 0 then
            self.yv = self.yv + result
            time    = self.yv / self._yv
            self.xv = self._xv*time
            self.willRefraction = true
        end
    elseif result == 2 then
        --上方折射
        if self.yv >= 0 then
            self.yv = self.yv + result
            time    = self.yv / self._yv
            self.xv = self._xv*time
            self.willRefraction = true
        end
    end

    self.position3D.y = self.position3D.y + self.yv
end

function EmitEffect:straight(time)
    time = time * 0.001
    self.xv = self._xv*time
    self.yv = self._yv*time
end

--跟踪
function EmitEffect:tail(time)
    time = time * 0.001
    self:doFlashRed()
    if not self.tarHero then
        if self.xv == 0 and self.yv == 0 then
           if self.srcHero:getDir() == eDir.LEFT then
                self.skeletonNode:setRotation(180)
                self.xv  = -self.effectData.emitSpeed*time
                self.yv  = 0
            else
                self.skeletonNode:setRotation(0)
                self.xv  = self.effectData.emitSpeed*time
                self.yv  = 0
            end
        end
        return
    end
    local targetPos  = self.tarHero:getHitPosition()
    local effectPos  =  self.prePos
    local dis        = me.pGetDistance(targetPos,effectPos)
    if math.floor(dis) < 4 then
        self.xv = 0
        self.yv = 0
        return
    end
    local passTime   = dis/self.effectData.emitSpeed
    local sub        = me.pSub(targetPos,effectPos)
    local angel      = pGetAngle(me.p(0,0),sub)
    local rotation   = -1*math.deg(angel)
    self.skeletonNode:setRotation(rotation)
    self.xv = sub.x/passTime*time
    self.yv = sub.y/passTime*time
    --修正位置
    if math.abs(self.xv) > math.abs(sub.x) then
        self.xv = sub.x
    end
    if math.abs(self.yv) > math.abs(sub.y) then
        self.yv = sub.y
    end
end

--角度跟踪
function EmitEffect:angleTail(time)
    time = time * 0.001
    self:doFlashRed()
    if not self.tarHero then
        if self.xv == 0 and self.yv == 0 then
            if self.srcHero:getDir() == eDir.LEFT then
                self.skeletonNode:setRotation(180)
                self.xv  = -self.effectData.emitSpeed*time
                self.yv  = 0
            else
                self.skeletonNode:setRotation(0)
                self.xv  = self.effectData.emitSpeed*time
                self.yv  = 0
            end
        end
        return
    end
    local targetPos  = self.tarHero:getHitPosition()
    local effectPos  =  self.prePos
    local dis        = me.pGetDistance(targetPos,effectPos)
    if math.floor(dis) < 4 then
        self.xv = 0
        self.yv = 0
        return
    end
    local passTime   = dis/self.effectData.emitSpeed
    local sub        = me.pSub(targetPos,effectPos)
    local angel      = pGetAngle(me.p(0,0),sub)
    local rotation   = -1*math.deg(angel)
    --判断是否超出了攻击范围 设置目标丢失
    if self.angelTailDir == eDir.LEFT then
        if math.abs(rotation) < 45 then
            self.tarHero = nil
            return
        end
    else
        if math.abs(rotation) > 45 then
            self.tarHero = nil
            return
        end
    end
    self.skeletonNode:setRotation(rotation)
    self.xv = sub.x/passTime*time
    self.yv = sub.y/passTime*time
    --修正位置
    if math.abs(self.xv) > math.abs(sub.x) then
        self.xv = sub.x
    end
    if math.abs(self.yv) > math.abs(sub.y) then
        self.yv = sub.y
    end
end
--贝塞尔曲线
function EmitEffect:bezier(time)
    time = time * 0.001
    self._elapsedTime = self._elapsedTime + time
    time = math.min(1,self._elapsedTime/self._durationTime)
    local xa = 0
    local xb = self._config.controlPoint_1.x
    local xc = self._config.controlPoint_2.x
    local xd = self._config.endPosition.x

    local ya = 0
    local yb = self._config.controlPoint_1.y
    local yc = self._config.controlPoint_2.y
    local yd = self._config.endPosition.y
    local px = bezierat(xa, xb, xc, xd, time)
    local py = bezierat(ya, yb, yc, yd, time)
    self.xv = px - self._startPos.x
    self.yv = py - self._startPos.y
    self._startPos.x = px
    self._startPos.y = py
    if self.xv ~= 0 or self.yv ~= 0  then
        local angel      = pGetAngle(me.p(0,0),me.p(self.xv,self.yv)) 
        local rotation   = math.deg(angel)
        -- print_("rotation:"..rotation.."["..tostring(self.xv).." "..tostring(self.yv) .." angel:"..tostring(angel))
        -- 根据目标位置动态设置翻转
        if self.xv <= 0 then 
            self:setDir(eDir.LEFT)
            self.skeletonNode:setRotation(-rotation + 180)
        else
            self:setDir(eDir.RIGHT)
            self.skeletonNode:setRotation(-rotation)
        end            
    end
    -- _print("xv",self.xv ,"yv",self.yv)
end

--
function EmitEffect:setScale(scale)
    if self.effectData.tailType == eTailType.STRAIGHT then
        CCNode.setScale(self,scale)
    end
end

function Effect.BlinkAction(node,interval)
    BattleMgr.bindActionMgr(node)
    node:stopAllActions()
    interval = interval or 0.5
    local actions = {
        TintTo:create(interval, me.c3b(0xFF,0,0)),
        TintTo:create(0.1, me.c3b(0xFF,0xFF,0xFF)),
    }
    local repeatAction = RepeatForever:create(Sequence:create(actions))
   node:runAction(repeatAction)

end





----------------
function Effect.create(data,srcHero,hostType,host,fixPosition)
    -- _print("create Effect ID "..data.id)
    if not battleController.isCreateEffect(srcHero) then
        return
    end
    if not srcHero then
        Box(string.format("can not create Effect [%s] host is null",data.id))
    end

    if data.triggerDelay and data.triggerDelay > 0  then
        local timer = nil
        timer = BattleTimerManager:addTimer(data.triggerDelay,1,function()
                BattleTimerManager:removeTimer(timer)
                if srcHero:isAlive() and (host==nil or not tolua.isnull(host)) then
                    if host and host.bPreRemove then
                        return
                    end
                    local effect = Effect.create_(data,srcHero,hostType,host)
                    if fixPosition then 
                        if effect then 
                            effect:setPosition3D(fixPosition.x,fixPosition.y,fixPosition.y)
                        end
                    end
                end
        end,nil)
    else
        local effect = Effect.create_(data,srcHero,hostType,host)
        if fixPosition then 
            if effect then 
                effect:setPosition3D(fixPosition.x,fixPosition.y,fixPosition.y)
            end
        end
    end

end

function Effect.create_(data,srcHero,hostType,host)
    local mainTarget
    hostType = hostType or eTriggerHostType.ACTION
    if host then
        mainTarget = host.mainTarget
    end
    if data.effectType == eEffectType.EMIT then
        -- _print("data.id::::",data.id)

        local effect = EmitEffect:new(data)
        local flag = effect:isNeedMainTarget()
        if flag > 0 then
            mainTarget = mainTarget or effect:selectTarget(srcHero)[1]
            if not mainTarget or mainTarget:isDead() then
                if flag > 1 then
                    print("没有找到目标不释创建特效")
                    return
                end
            end
        end
        effect:active(srcHero,hostType,host,mainTarget)
        return effect
    else
        local effect = NormalEffect:new(data)
        local flag = effect:isNeedMainTarget()
        if flag > 0 then
            mainTarget = mainTarget or effect:selectTarget(srcHero)[1]
            if not mainTarget or mainTarget:isDead() then
                if flag > 1 then
                    print("没有找到目标不释创建特效")
                    return
                end
            end
        end
        effect:active(srcHero,hostType,host,mainTarget)
        return effect
    end

end

return Effect



