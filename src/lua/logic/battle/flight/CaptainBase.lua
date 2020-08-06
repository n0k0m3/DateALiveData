local StateMachine      = import("..StateMachine")
local BattleConfig      = import("..BattleConfig")
local BattleUtils       = import("..BattleUtils")
local BattleMgr         = import("..BattleMgr")
local Property          = import("..PropertyEx")
local StateMgr          = import("..StateMgr")
local EventTrigger      = import("..EventTrigger")
local enum              = import("..enum")
local levelParse        = import("..LevelParse")
local ObjectPool        = import(".ObjectPool")

--local bufferMgr         = BattleMgr.getBufferMgr()
local heroMgr           = BattleMgr.getHeroMgr()
local eAttrType         = enum.eAttrType
local eFlightState      = enum.eFlightState
local eFlightStateEvent = enum.eFlightStateEvent
local eBFState          = enum.eBFState
local eEvent            = enum.eEvent
local eHurtType         = enum.eHurtType

local barragePool       = ObjectPool.new("BARRAGE_POOL", 64, "release")

---@class CaptainBase
local CaptainBase       = class("CaptainBase")

---@param data table
function CaptainBase:ctor(data)
    self.elide_ = true --拾取道具的时候忽略范围检查
    self:reset(data)
end

function CaptainBase:reset(data)
    self.recycled        = nil
    self.data            = data
    self.useDebut        = false --需要使用登场
    self.debuted         = false --是否已登场（上场保护）
    self.offStage        = false --死亡但没销毁

    self.bufferEffectMap = {}
    self.barrages        = {}
    self.barragesState   = {}  -- 暂停前状态
    self.position3D      = me.Vertex3F(0, 0, 0)
    self.actionNames     = BattleDataMgr:getActionNames(data.model)
    self.skinIndex       = 1
    self.dir             = nil

    self.showTiming      = 0

    self.property        = Property.new()
    self.property:parseFrom(data)
    self.property:setListener(handler(self.onAttrTrigger, self))

    --self.stateMgr = StateMgr:new(self)
    self:init()
end

---@param cfg table
function CaptainBase:initFsm(cfg)
    cfg.callbacks = {
        onleavestate = handler(self.onLeaveState, self),
        onafterevent = handler(self.onEnterState, self),
    }
    self.fsm      = StateMachine:instace()
    self.fsm:setupState(cfg)
end

function CaptainBase:init()
    local bornPoint   = self.data.position or levelParse:getBornPos()

    self.position3D.x = bornPoint.x or self.position3D.x
    self.position3D.y = bornPoint.y or self.position3D.y
    self.position3D.z = bornPoint.z or self.position3D.y
    self.fighter:setPosition(self.position3D.x, self.position3D.y)
    self.fighter:retain()

    heroMgr:add(self)
    EventMgr:dispatchEvent(eEvent.EVENT_ACTOR_ADD_TO_LAYER, self.fighter)
    EventMgr:dispatchEvent(eEvent.EVENT_NOTICE_HP, self:getMaxHp())
end

function CaptainBase:release()
    heroMgr:remove(self)
    self:removeAllBuff()
    if self.fighter then
        self.fighter:destroy()
        self.fighter:release()
        ---@type FighterBase
        self.fighter = nil
    end
    self:barragesRelease()
end

function CaptainBase:recycle()
    heroMgr:remove(self)
    self:removeAllBuff()
    self:pause()
    if self.fighter then
        self.fighter:recycle()
    end
    self:barragesRecycle()
    self.data            = nil
    self.useDebut        = nil
    self.debuted         = nil
    self.offStage        = nil

    self.bufferEffectMap = nil
    self.position3D      = nil
    self.actionNames     = nil
    self.skinIndex       = nil
    self.showTiming      = nil
    self.property        = nil
    --self.stateMgr        = nil
    self.fsm             = nil
    self.roleAction      = nil
    self.sortY           = nil
    self.boundingBox     = nil
end

function CaptainBase:barragesRelease()
    if self.barrages then
        for k, barrage in pairs(self.barrages) do
            if not tolua.isnull(barrage) then
                barrage:Stop()
                barrage:removeFromParent()
            end
            self.barrages[k] = nil
        end
    end
    self.barrages      = nil
    self.barragesState = nil
end

function CaptainBase:barragesRecycle()
    for k, barrage in pairs(self.barrages) do
        if not tolua.isnull(barrage) then
            barrage:Stop()
            barrage:retain()
            barrage:removeFromParent()
            barrage.owner           = nil
            barrage.cfg             = nil
            barrage.config          = nil
            barrage.emiters         = nil
            barrage.bulletContainer = nil
            barrage:SetOnEmitHandle(nil)
            barrage:SetOnEmitCompleteHandle(nil)
            if not barragePool:push(barrage) then
                barrage:release()
            end
        end
        self.barrages[k] = nil
    end
    self.barrages      = nil
    self.barragesState = nil
end

function CaptainBase:getData()
    return self.data
end

function CaptainBase:hasAliveBarrage()
    for _, barrage in pairs(self.barrages) do
        if not tolua.isnull(barrage) then
            return true
        end
    end
    return false
end

function CaptainBase:getAngleDatas()
    return self.data.angleDatas
end

function CaptainBase:getPosition()
    return self.position3D
end

function CaptainBase:getTimeScale()
    return 1
end

function CaptainBase:getActionTimeScale()
    return 1
end

function CaptainBase:setVisible(value)
    if self.fighter then
        if value then
            self.fighter:show()
            self:fire()
        else
            self.fighter:hide()
            self:ceasefire()
        end
    end
end

function CaptainBase:pause()
    if self.fighter then
        self.fighter:pause()
    end
    self:ceasefire()
end

function CaptainBase:resume()
    if self.fighter then
        self.fighter:resume()
    end
    self:fire()
end

---@param dt number
function CaptainBase:update(dt)
    self.showTiming = self.showTiming + dt
    if self.fighter then
        self.fighter:update(dt)
    end
    if self.recycled then
        self:recycle()
    end
end

function CaptainBase:getShowTiming()
    return self.showTiming
end

---@param attrType eAttrType
---@param value number
function CaptainBase:setValue(attrType, value)
    self.property:setValue(attrType, value)
end

---@param cfg table
function CaptainBase:getAtkHurt(cfg)
    return self.property:getValue(eAttrType.ATTR_ATK) * (cfg and cfg.damagePercent or 1)
end

function CaptainBase:getBumpBurt()

end

---@param attrType eAttrType
---@param value number
function CaptainBase:changeValue(attrType, value)
    self.property:changeValue(attrType, value)
    if attrType == eAttrType.ATTR_NOW_HP then
        local point = self.fighter:getBonePosition("body")
        point.x     = point.x + RandomGenerator.random(-10, 10)
        point.y     = point.y + 90 + RandomGenerator.random(-10, 10)
        EventMgr:dispatchEvent(eEvent.EVENT_TIP, math.ceil(value), point, eHurtType.NORMAL, true)
    end
end

---@param bdbox string
function CaptainBase:getCollisionWithName(bdbox)
    bdbox = bdbox or self.data.bodyArea[1] or "bdbox"
    if self.fighter then
        return self.fighter:getCollisionWithName(bdbox)
    end
    return {}
end

---@param bdbox string
function CaptainBase:getCenterPoint(bdbox)
    bdbox = bdbox or self.data.bodyArea[1] or "bdbox"
    local box = self:getCollisionWithName(bdbox)
    return BattleUtils.polygonCenterPoint(box)
end

---@param bdbox string
---@return me.rect
function CaptainBase:getBoundingBox(bdbox)
    bdbox = bdbox or self.data.bodyArea[1] or "bdbox"
    if self.fighter then
        return self.fighter:getBoundingBox(bdbox)
    end
    return me.rect(0, 0, 0, 0)
end

--function CaptainBase:getBoundingBoxStatic(bdbox)
--    if not self.boundingBox then
--        self.boundingBox = self:getBoundingBox(bdbox)
--        self.boundingBox.origin.x = self.boundingBox.origin.x - self.position3D.x
--        self.boundingBox.origin.y = self.boundingBox.origin.y - self.position3D.y
--    end
--    return me.rect(self.boundingBox.origin.x + self.position3D.x, self.boundingBox.origin.y + self.position3D.y,  self.boundingBox.size.width, self.boundingBox.size.height)
--end

function CaptainBase:getBonePosition(boneName)
    if self.fighter then
        return self.fighter:getBonePosition(boneName)
    end
    return self:getPosition()
end

function CaptainBase:getDir()
    return self.dir
end

function CaptainBase:setDir(dir)
    if self.fighter and self.dir ~= dir then
        self.dir = dir
        self.fighter:setDir(dir)
    end
end

---@param xv number
---@param yv number
---@param fix boolean
function CaptainBase:move(xv, yv, fix)
end

function CaptainBase:findNearestEnemy()
end

function CaptainBase:findRandomEnemy()
end

function CaptainBase:fire()
    if self.barrages then
        for _, barrage in pairs(self.barrages) do
            if not tolua.isnull(barrage) and self.barragesState[barrage] == "FIRE" then
                barrage:Resume()
            end
        end
    end
end

function CaptainBase:ceasefire()
    self.barragesState = {}
    if self.barrages then
        for _, barrage in pairs(self.barrages) do
            self.barragesState[barrage] = barrage.isStop and "STOP" or "FIRE"
            barrage:Stop()
        end
    end
end

function CaptainBase:getHp()
    return self.property:getValue(eAttrType.ATTR_NOW_HP)
end

function CaptainBase:getMaxHp()
    return self.property:getValue(eAttrType.ATTR_MAX_HP)
end

function CaptainBase:getHpPercent()
    return self.property:getValue(eAttrType.ATTR_NOW_HP) * 10000 / self.property:getValue(eAttrType.ATTR_MAX_HP)
end

function CaptainBase:getAnger()
    return self.property:getValue(eAttrType.ATTR_NOW_AGR)
end

function CaptainBase:getAngerPercent()
    return self.property:getValue(eAttrType.ATTR_NOW_AGR) * 10000 / self.property:getValue(eAttrType.ATTR_MAX_AGR)
end

function CaptainBase:getMaxAnger()
    return self.property:getValue(eAttrType.ATTR_MAX_AGR)
end

function CaptainBase:getEnergy()
    return self.property:getValue(eAttrType.ATTR_NOW_ENERGY)
end

function CaptainBase:getMaxEnergy()
    return self.property:getValue(eAttrType.ATTR_MAX_ENERGY)
end

function CaptainBase:getEnergyPercent()
    return self.property:getValue(eAttrType.ATTR_NOW_ENERGY) * 10000 / 100 --self.property:getValue(eAttrType.ATTR_MAX_ENERGY)
end

function CaptainBase:getShield()
    return self.property:getValue(eAttrType.ATTR_NOW_SLD)
end

function CaptainBase:getShieldPercent()
    return self.property:getValue(eAttrType.ATTR_NOW_SLD) * 10000 / self.property:getValue(eAttrType.ATTR_MAX_HP)
end

function CaptainBase:isDead()
    return not self:isAlive()
end

function CaptainBase:isAlive()
    if not self.fighter then
        return false
    end
    return self.property:getValue(eAttrType.ATTR_NOW_HP) > 0
end

function CaptainBase:isDebuted()
    return self.debuted
end

function CaptainBase:isOffStage()
    return self.offStage
end

---@param rect rect
function CaptainBase:isInRect(rect)
    -- 陈凡老师指导修改道具捡取判定范围
    local bodyRect = self:getBoundingBox("bdbox")
    return me.rectIntersectsRect(rect,bodyRect)
end

CaptainBase.hitTestProp = CaptainBase.isInRect

function CaptainBase:getRoleAction(action)
    if self.actionNames then
        return self.actionNames[self.skinIndex][action]
    end
end
--保存动作的数据
function CaptainBase:setRoleAction(data)
    self.roleAction = data
end

function CaptainBase:isInAir()
    local pos = self.position3D
    return math.ceil(pos.z - pos.y) > 1
end

function CaptainBase:ready()
end

function CaptainBase:setBarrage(barrage)
    if self.fighter then
        ---@type TFBarrageEx
        local barrageNode = self.barrages[barrage]
        if not barrageNode then
            local parent = self.fighter:getParent()
            barrageNode  = barragePool:pop()
            if barrageNode then
                barrageNode.bulletContainer = parent
                parent:addChild(barrageNode)
                barrageNode:release() -- sub retain count
                barrageNode:init()
            else
                barrageNode = TFBarrageEx:new(parent)
                parent:addChild(barrageNode)
            end
            barrageNode:setCameraMask(self.fighter:getCameraMask())
            barrageNode.owner             = self
            barrageNode.cfg               = barrage
            local damagePercent           = self.data.damagePercent
            barrageNode.cfg.damagePercent = (damagePercent == 0 or not damagePercent) and 1 or damagePercent * 0.01
            barrageNode:SetOnEmitHandle(handler(self.onEmit, self))
            barrageNode:SetOnEmitCompleteHandle(handler(self.onEmitComplete, self))
            self.barrages[barrage] = barrageNode
        end
        barrageNode:Emit(barrage.emitter)
        if barrage.cfg.isLoop then
            barrageNode:Resume()
        else
            barrageNode:Stop()
        end
        self.fighter:setPosition(self.position3D)
    end
end

function CaptainBase:hasAliveBullet()
    for _, barrage in pairs(self.barrages) do
        if BulletCache:GetBulletCount(barrage) > 0 then
            return true
        end
    end
    return false
end

-- state event
function CaptainBase:doEvent(eventName, ...)
    local canDo = self.fsm:canDoEvent(eventName)
    if canDo then
        self.fsm:doEvent(eventName, ...)
    else
        --print("can not doEvent "..tostring(eventName).." in current state "..self.fsm:getState())
    end
    return canDo
end

function CaptainBase:onEnterState(event)
    local args = unpack(event.args)
    local to   = event.to
    if to == eFlightState.ST_BORN then
        self:onBorn(args)
    elseif to == eFlightState.ST_DEBUT then
        self:onDebut(args)
    elseif to == eFlightState.ST_STAND then
        self:onStand(args)
        self:onEventTrigger(eBFState.E_STAND, self)
    elseif to == eFlightState.ST_FORWARD then
        self:onForward({from = event.from, dir = args})
        self:onEventTrigger(eBFState.E_STAND, self)
    elseif to == eFlightState.ST_BACKWARD then
        self:onBackward({from = event.from, dir = args})
        self:onEventTrigger(eBFState.E_STAND, self)
    elseif to == eFlightState.ST_MOVE then
        self:onMove(args)
        self:onEventTrigger(eBFState.E_MOVE, self)
    elseif to == eFlightState.ST_SKILL then
        self:onCast(args)
    elseif to == eFlightState.ST_HIT then
        self:onHurt(args)
    elseif to == eFlightState.ST_OFFSTAGE then
        self:onOffStage(args)
    elseif to == eFlightState.ST_DIE then
        self:onDead(args)
    elseif to == eFlightState.ST_FALL then
        self:onFall(args)
    elseif to == eFlightState.ST_WIN then
        self:onWin(args)
    elseif to == StateMachine.WILDCARD then
    else
        printError("暂时不支持此状态")
    end
end

function CaptainBase:onLeaveState(event)
    local from = event.from
    local to   = event.to
    if from == eFlightState.ST_SKILL then
        if self.fighter then
            self.fighter.skeletonNode:setToSetupPose()
        end
    elseif from == eFlightState.ST_MOVE or from ==  eFlightState.ST_FORWARD or from == eFlightState.ST_BACKWARD then
        self:stopMoveEffect()
    end
    --if from == eFlightState.ST_SKILL then
    --    self.fighter:stopAllActions()
    --    self:onLeaveSK(event)
    --elseif from == eFlightState.ST_MOVE then
    --    self:stopMoveEffect()
    --    if to ~= eFlightState.ST_STAND then
    --        self:endToAI()
    --    end
    --end
end

function CaptainBase:onBorn(args)
    if self.fighter then
        self.fighter:show()
    end
end

---@param part number
function CaptainBase:onDebut(part)
end

function CaptainBase:onStand(args)
    self.useDebut = false
end

---@param event table
function CaptainBase:onForward(event)
end

---@param event table
function CaptainBase:onBackward(event)
end

function CaptainBase:onMove(args)
end

---@param args table{hurt=number, effectName=string, actionName=string, scale=number, pos=ccp, deadActionName=string}
function CaptainBase:onHurt(args)
    self.property:changeValue(eAttrType.ATTR_NOW_HP, args.hurt)
    if self:isDead() then
        local exist = self:hasAliveBarrage()
        if exist then
            self:doEvent(eFlightStateEvent.BH_OFFSTAGE, true)
        else
            self:doEvent(eFlightStateEvent.BH_DIE, {deadAction=args.deadAction, recycled = true, delayed = args.delayed})
        end
    end
    if self.fighter then
        if args.effectName and args.effectName ~= "" then
            local pos = me.pSub(args.pos, self:getPosition())
            self.sortY = 0
            self.fighter:playEffect(args.effectName, args.scale, args.actionName, pos, args.flipX, function ()
                self.sortY = nil
                if "function" == type(args.handle) then
                    args.handle()
                end
            end, args.zOrder)
        end
        if self:isAlive() then
            self.fighter:flashRed()
        end
    end
end

function CaptainBase:onOffStage(args)
    self.offStage = true
    self.debuted  = false
    self:removeAllBuff()
    self:stopMoveEffect()
    for k, barrage in pairs(self.barrages) do
        if k.cfg and k.cfg.isDelete then
            BulletCache:RecycleByOwner(barrage)
        end
    end
    EventMgr:dispatchEvent(eEvent.EVENT_CAPTAIN_OFFSTAGE, self)
end

---@param args table {deadAction=string, recycled=boolean}
function CaptainBase:onDead(args)
    self.debuted = false
    self:onEventTrigger(eBFState.E_DEAD)
end

function CaptainBase:onFall(args)
end

function CaptainBase:onEmit(barrage, config, state, bullets)
    if state == 0 then
        if self.fighter then
            self.fighter:playEmit(barrage, config)
        end
    elseif state == 1 then
        if bullets and #bullets > 0 then
            local attacker
            local enemy
            for _, bullet in ipairs(bullets) do
                bullet:setCameraMask(self.fighter:getCameraMask())
                --bullet.getSortY = function()  -- 暂时保留，修改编辑器后可能会用这段代码
                --    if self.fighter then
                --        return self.fighter:getSortY() + 1
                --    end
                --    return self.position3D.y
                --end
                local bulletParent = bullet:getParent()
                if bulletParent then
                    bulletParent:setZOrder(1024)
                end
                attacker = bullet.owner.owner
                if bullet.isFindOnce and (not attacker or not enemy) then
                    if bullet.ChooseTarget == 0 then
                        enemy = attacker:findNearestEnemy()
                    elseif bullet.ChooseTarget == 1 then
                        enemy = attacker:findRandomEnemy()
                    end
                end
                if enemy then
                    BulletCache:AimAtPos(bullet, enemy:getCenterPoint())
                end
            end
        end
    end
end

function CaptainBase:onEmitComplete(barrage)
    barrage.currentEmitIndex = (barrage.currentEmitIndex or 0) + 1
    if barrage.currentEmitIndex >= #barrage.config then
        barrage:Emit(barrage.config)
        barrage:Stop()
        barrage.currentEmitIndex = 0
    end
end

function CaptainBase:clearBullet()
    if self.barrages then
        for _, barrage in pairs(self.barrages) do
            BulletCache:RecycleByOwner(barrage)
        end
    end
end

-- buffer
--[[
function CaptainBase:getBFEffectAddTimes(id)
    local times = 0
    for k, effect in ipairs(self.bufferEffectMap) do
        if effect:getId() == id then
            times = times + effect:getAddTimes()
        end
    end
    return times
end

function CaptainBase:getBFEffect(id)
    for k, effect in ipairs(self.bufferEffectMap) do
        if effect:getId() == id then
            return effect
        end
    end
end
function CaptainBase:addBFEffect(bufferEffect)
    table.insert(self.bufferEffectMap, bufferEffect)
end
function CaptainBase:removeBFEffect(bufferEffect)
    -- self.bufferEffectMap[bufferEffect:getObjectID()] = nil
    table.removeItem(self.bufferEffectMap, bufferEffect)
end
function CaptainBase:handlBufferEffect(dt)
    --TODO 测试貌似在update 里删除 effect 没毛病
    self:walkBufferEffectWalk(function(effect)
        effect:update(dt)
    end)
end

--获取buffer效果
function CaptainBase:getBufferEffectMap()
    return self.bufferEffectMap
end

function CaptainBase:getBuffer(id)
    for i, buffer in ipairs(self.bufferList) do
        if buffer:getID() == id then
            return buffer
        end
    end
end
--移除特殊类型buffer effect
function CaptainBase:removeSpecialTypeEffect(specialType)
    local effectMap = self.bufferEffectMap
    for k = #effectMap, 1, -1 do
        local effect = effectMap[k]
        if effect:getSpecialType() == specialType then
            effect:removeSelf()
        end
    end
end

function CaptainBase:walkBufferEffectWalk(callfunc)
    for index = #self.bufferEffectMap, 1, -1 do
        local effect = self.bufferEffectMap[index]
        if effect then
            callfunc(effect)
        end
    end
end
--]]

function CaptainBase:playMoveEffect()
    if not self.isPlayMoveSoundEffect then
        if self.data.moveType == 0 then
            self.isPlayMoveSoundEffect = BattleUtils.playEffect(BattleConfig.MOVE_EFFECT, true)
        elseif self.data.moveType == 1 then
            self.isPlayMoveSoundEffect = BattleUtils.playEffect(BattleConfig.FLY_EFFECT, true)
        end
    end
end

function CaptainBase:stopMoveEffect()
    if self.isPlayMoveSoundEffect then
        TFAudio.stopEffect(self.isPlayMoveSoundEffect)
        self.isPlayMoveSoundEffect = nil
    end
end

function CaptainBase:removeAllBuff()

end

--动画帧事件
function CaptainBase:onArmatureEvent(event, model, action)
    if self.offStage then return end
    if event.name == enum.eArmtureEvent.HURT then
        self:doAttack()
    elseif event.name == enum.eArmtureEvent.MUSIC then
        --音效触发
        self:doMusicEvent(event.pramN, model, action)
    elseif event.name == enum.eArmtureEvent.EFFECT then
        --特效触发
        --self:doEffectEvent(event.pramN)
    end
    self:onEventWithSpell(event)
end

function CaptainBase:doEffectEvent(pramN)
    if self.roleAction then
        if self.roleAction.triggerEvent == "effect" .. pramN then
            local effectPoint  = self.roleAction.effectPoint
            local resourceUp   = self.roleAction.resourceUp
            local motionUp     = self.roleAction.motionUp
            local resourceDown = self.roleAction.resourceDown
            local motionDown   = self.roleAction.motionDown
            local pos          = self:getRelativeBonePosition(effectPoint)
            for index, resource in ipairs(resourceUp) do
                local animation    = motionUp[index]
                local skeletonNode = self.fighter:playEffect(resource, nil, animation)
                skeletonNode:setPosition(pos)
                skeletonNode:setZOrder(3)
            end
            for index, resource in ipairs(resourceDown) do
                local animation    = motionDown[index]
                local skeletonNode = self.fighter:playEffect(resource, nil, animation)
                skeletonNode:setPosition(pos)
                skeletonNode:setZOrder(-1)
            end
        end
    end
end

function CaptainBase:doMusicEvent(pramN, model, actionName)
    local eventName  = enum.eArmtureEvent.MUSIC .. pramN
    local resource   = model or self.data.model
    local action     = actionName or self.fighter:getFixAnimation()
    local musicData = BattleDataMgr:getActorMusicDatas(resource, action, eventName)
    if musicData then
        for _, data in ipairs(musicData) do
            local handle = BattleUtils.playEffect(data.resource, false, data.volume * 0.01)
            if handle then
                TFAudio.setFinishCallback(handle, function ()
                end)
            end
        end
    end
end

function CaptainBase:onEventTrigger(event, target, param)
    if not event then
        printError("hero onEventTrigger event is nil")
    end
end

function CaptainBase:onAttrTrigger(attrType, value)
    --bufferMgr:walk(function(buffer)
    --    buffer:onAttrTrigger(self, attrType, value)
    --end)
    --self:walkBufferEffectWalk(function(effect)
    --    effect:onAttrTrigger(self, attrType, value)
    --end)
end

function CaptainBase:doAttack()
end

function CaptainBase:onEventWithSpell(event)
end

--[[
function CaptainBase:walkBufferEffectWalk(callfunc)
    for index = #self.bufferEffectMap, 1, -1 do
        local effect = self.bufferEffectMap[index]
        if effect then
            callfunc(effect)
        end
    end
end

function CaptainBase:onSkillEffectRemove(effectNode)
    self:walkBufferEffectWalk(function(effect)
        effect:onSkillEffectRemove(effectNode)
    end)
end

function CaptainBase:delAState(state, objectID)
    --if self.stateMgr then
    --    self.stateMgr:delState(state,objectID)
    --end
end
--]]
return CaptainBase
