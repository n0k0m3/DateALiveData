local StateMachine      = import("..StateMachine")
local BattleConfig      = import("..BattleConfig")
local BattleUtils       = import("..BattleUtils")
local BattleMgr         = import("..BattleMgr")
local EventTrigger      = import("..EventTrigger")
local GameObject        = import("..GameObject")
local enum              = import("..enum")
local AIAgent           = import("..AIAgent")
local MonsterFighter    = import(".MonsterFighter")
local CaptainBase       = import(".CaptainBase")
local ObjectPool        = import(".ObjectPool")

local heroMgr           = BattleMgr.getHeroMgr()
local eFlightState      = enum.eFlightState
local eFlightStateEvent = enum.eFlightStateEvent
local eEvent            = enum.eEvent

local ELAPSE_FPS = 16.666
local winSize    = me.EGLView:getFrameSize()
local scaleX     = 1--(winSize.width / GameConfig.DESIGN_SIZE.width)
if winSize.width < GameConfig.DESIGN_SIZE.width then
    scaleX = winSize.width/GameConfig.DESIGN_SIZE.width
end
local scaleY     = 1--(winSize.height / GameConfig.DESIGN_SIZE.height)

local monsterPool = ObjectPool.new("FLIGHT_MONSTER", 32, "release")

local fsmCfg = {
    events  = {
        { name = eFlightStateEvent.BH_BORN, from = { StateMachine.WILDCARD }, to = eFlightState.ST_BORN },
        { name = eFlightStateEvent.BH_DEBUT, from = { eFlightState.ST_BORN, eFlightState.ST_DEBUT }, to = eFlightState.ST_DEBUT },
        { name = eFlightStateEvent.BH_STAND, from = { eFlightState.ST_BORN, eFlightState.ST_DEBUT }, to = eFlightState.ST_STAND },
        { name = eFlightStateEvent.BH_MOVE, from = { eFlightState.ST_BORN, eFlightState.ST_STAND, eFlightState.ST_HIT, eFlightState.ST_SKILL }, to = eFlightState.ST_MOVE },
        { name = eFlightStateEvent.BH_SKILL, from = { eFlightState.ST_BORN, eFlightState.ST_STAND, eFlightState.ST_HIT, eFlightState.ST_SKILL, eFlightState.ST_MOVE }, to = eFlightState.ST_SKILL },
        { name = eFlightStateEvent.BH_HIT, from = { eFlightState.ST_BORN, eFlightState.ST_STAND, eFlightState.ST_SKILL, eFlightState.ST_HIT, eFlightState.ST_MOVE }, to = eFlightState.ST_HIT },
        { name = eFlightStateEvent.BH_OFFSTAGE, from = { eFlightState.ST_BORN, eFlightState.ST_DEBUT, eFlightState.ST_STAND, eFlightState.ST_HIT, eFlightState.ST_SKILL, eFlightState.ST_FALL, eFlightState.ST_MOVE }, to = eFlightState.ST_OFFSTAGE },
        { name = eFlightStateEvent.BH_DIE, from = { eFlightState.ST_OFFSTAGE, StateMachine.WILDCARD }, to = eFlightState.ST_DIE },
        --{ name = eFlightStateEvent.BH_WIN, from = { StateMachine.WILDCARD }, to = eFlightState.ST_WIN }, --获胜状态
    },
    initial = {
        event = StateMachine.WILDCARD,
        state = StateMachine.WILDCARD,
    }
}

local function spawnPathWithGameObject(position)
    local x, y = position.x, position.y
    local step = -3
    local points = {}
    while true do
        local yy = 0
        if y>GameConfig.WS.height - 200 then
            y = y - 5
            yy = y
        elseif y < 100 then
            y = y + 5
            yy = y
        else
            local xx = (x/GameConfig.WS.width)*2 - 1
            yy = (math.sin(xx*2*math.pi)+1)/2 * 100+y
            x = x + step
            if x <= 0 then
                step = -step
            elseif x >= GameConfig.WS.width then
                step = -step
            end
        end
        points[#points+1] = ccp(x, yy)
        if #points > 900 then
            break
        end
    end
    return points
end


---@class MonsterCaptain : CaptainBase
local MonsterCaptain    = class("MonsterCaptain", CaptainBase)

function MonsterCaptain:ctor(data)
    self.super.ctor(self, data)
end

function MonsterCaptain:reset(data)
    self.super.reset(self, data)
    self:initFsm(fsmCfg)

    if data.AI and data.AI ~= 0 then
        self.aiAgent = AIAgent:new(self,data.AI)
    else
        if me.platform == "win32" then
            Box(string.format("Monster id = (%d) not found Ai id %d", data.fixedMonster, data.AI))
        end
    end
    self.stopOrbit  = nil
    self.bornTime   = data.bornTime or 0
    self.useDebut   = self.bornTime ~= 0
    self.orbitIndex = 0
end

function MonsterCaptain:init()
    if not self.fighter then
        --- @type MonsterFighter
        self.fighter = MonsterFighter:new(self)
        self.super.init(self)
    else
        self.super.init(self)
        self.fighter:release()
        self.fighter:reset()
        self:resume()
    end
    self:setDir(self.data.turnBack and enum.eDir.RIGHT or enum.eDir.LEFT )
end

function MonsterCaptain:recycle()
    local model = self.data.model
    self.super.recycle(self)
    self.bornTime   = nil
    self.orbit      = nil
    self.orbitIndex = nil
    self.useDebut   = nil
    self.elapse     = nil
    self.aiAgent    = nil
    self.elapse     = nil
    if monsterPool:push(self, model) then
        self.recycled = nil
    else
        self:release()
    end
end

function MonsterCaptain:update(dt)
    self.super.update(self, dt)
    if self.orbit then
        --local deltaTime = math.floor(dt)
        --self.elapse = (self.elapse or 0) + deltaTime * math.abs(self.TimeScale or 1)
        self.elapse = (self.elapse or 0 ) + dt

        while self.elapse >= ELAPSE_FPS do
            self.orbitIndex = (self.orbitIndex or 0) + 1
            local orbitIndex = self.orbitIndex

            local lpos = self.orbit:GetPointAt(orbitIndex - 1)
            local pos = self.orbit:GetPointAt(orbitIndex)
            if pos and lpos then
                local seekPos = pos - lpos
                seekPos = ccp(seekPos.x, 0 - seekPos.y)
                self:move(seekPos.x, seekPos.y)
            end
            if self.orbitIndex > #self.orbit.points then
                if self.data.orbitLoop then
                    self.orbitIndex = self.data.bornTime
                else
                    self:doEvent(eFlightStateEvent.BH_OFFSTAGE, false)
                end
            elseif self.orbitIndex >= self.bornTime and self.bornTime ~= 0 then
                self.bornTime = 0
                self:doEvent(eFlightStateEvent.BH_DEBUT, 2)
            end
            self.elapse = self.elapse - ELAPSE_FPS
        end
    end
    if self.aiAgent then
        self.aiAgent:update(dt, self)
    end
end

function MonsterCaptain:move(xv, yv, fix)
    if xv == 0 and yv == 0 then
        return
    end
    if self.fighter then
        local pos = self.position3D
        local nx  = pos.x + xv*scaleX
        local ny  = pos.y + yv*scaleY
        pos.x = nx
        pos.y = ny
        pos.z = pos.y
        self.fighter:setPosition(pos.x, pos.z)
        self.debuted = (not self.offStage) and (nx >= 0 and nx <= GameConfig.WS.width) and (ny >= 0 and ny <= GameConfig.WS.height)
        --self.dbgPoints =  self.dbgPoints or {}
        --self.dbgPoints[#self.dbgPoints + 1] = ccp(nx, ny)
        --self.fighter:drawCollisionBox(self.dbgPoints)
        self:doEvent(eFlightStateEvent.BH_MOVE)
        EventTrigger:_onChangePos(self)
    end
end

function MonsterCaptain:findNearestEnemy()
    local heroes = heroMgr:getObjects()
    for _, hero in ipairs(heroes) do
        if hero:getData().roleType == enum.eRoleType.Hero then
            return hero
        end
    end
    return nil
end

function MonsterCaptain:findRandomEnemy()
    return self:findNearestEnemy()
end

function MonsterCaptain:ready()
    local barrages = self.data.flySkills
    if barrages then
        for i, barrage in ipairs(barrages) do
            local emitter = barrage.emitter
            if emitter then
                for _, emit in ipairs(barrage.emitter) do
                    --if self.data.turnBack then
                    if self.dir == enum.eDir.RIGHT then
                        if emit.Config.Angle <= 0 then
                            emit.Config.Angle = -180 - emit.Config.Angle
                        else
                            emit.Config.Angle = 180 - emit.Config.Angle
                        end
                    end
                end
                self:setBarrage(barrage)
            end
        end
    end
end

function MonsterCaptain:onBorn(args)
    self.super.onBorn(self)
    self:ready()
    if self.fighter then
        if self.useDebut then
            self:doEvent(eFlightStateEvent.BH_DEBUT, 1)
        else
            self.orbit = TFOrbit:LoadFromName(self.data.orbit)
            self:doEvent(eFlightStateEvent.BH_STAND)
        end
    end
end

function MonsterCaptain:onDebut(part)
    self.super.onDebut(self, part)
    if self.fighter then
        local name = self.data.bornActionName[part]
        if name then
            if part == 1 then
                self.fighter:playDebut(name)
                self.orbit = TFOrbit:LoadFromName(self.data.orbit)
            elseif part ==  2 then
                self.fighter:playDebut(name, function ()
                    self:doEvent(eFlightStateEvent.BH_STAND)
                end)
            end
        else
            self.orbit = TFOrbit:LoadFromName(self.data.orbit)
            self:doEvent(eFlightStateEvent.BH_STAND)
        end
    end
end

function MonsterCaptain:onStand(args)
    self.super.onStand(self, args)
    if self.fighter then
        self.fighter:playStand()
    end
end

function MonsterCaptain:onMove(args)
    self.moveState = args
    self.fighter:playMove()
    self:playMoveEffect()
end

function MonsterCaptain:onHurt(args)
    self.super.onHurt(self, args)
    if self:isDead() then
        local itemDrop = self.data.itemDrop
        if "table" == type(itemDrop) then
            for id, item in pairs(itemDrop) do
                local data
                if item.weight >= 10000 then
                    data = item.data
                else
                    local value = RandomGenerator.random(0, 10000)
                    if value <= item.weight then
                        data = item.data
                    end
                end
                if data then
                    local position = self:getPosition()
                    data.orbit = spawnPathWithGameObject(position)
                    self.fighter:drawCollisionBox(data.orbit)
                    local prop     = GameObject.createProp(data)
                    prop:setCameraMask(self.fighter:getCameraMask())
                    prop:setPosition(position)
                    prop:runAction(JumpTo:create(0.5, position, 60, 1))
                    prop:active()
                end
            end
        end
        if self.data.angerRecovery > 0 and args.attacker then
            args.attacker:changeAnger(self.data.angerRecovery)
        end
        if self.data.points > 0 then
            EventMgr:dispatchEvent(eEvent.EVENT_KILL_SCORE, self.data.points)
        end
    end
end

function MonsterCaptain:onOffStage(args)
    self.aiAgent = nil
    self:ceasefire()
    local callback = function()
        self.super.onOffStage(self, args)
        --if self.fighter then
        --    self.fighter:destroy()
        --    self.fighter:release()
        --    ---@type FighterBase
        --    self.fighter = nil
        --end
        if self.fighter then
            self.fighter:hide()
        end
    end
    if args and self.fighter then
        self.fighter:playDead(nil, callback)
    else
        callback()
    end
end

function MonsterCaptain:onDead(args)
    self.super.onDead(self, args)
    if not args.delayed then
        self.orbit = nil
    end
    local function doDead()
        self.fighter:hide()
        if args.recycled then
            self.recycled = true
        else
            self:release()
        end
    end
    if self.fighter and self.fighter:getParent() then
        self.fighter:playDead(args.deadAction, doDead)
    else
        doDead()
    end
end

function MonsterCaptain:onEmit(barrage, config, state, bullets)
    if state == 0 then
        if self.fighter and barrage.cfg and barrage.cfg.cfg and barrage.cfg.cfg.fireEffect then
            local effect = barrage.cfg.cfg.fireEffect
            if effect.effectName and effect.effectName ~= "" then
                local pos = effect.launchPointName and self.fighter:getRelativeBonePosition(effect.launchPointName) or ccp(0, 0)
                pos = effect.offset and pos + effect.offset or pos
                self.fighter:playEffect(effect.effectName, effect.scale or 1, effect.actionName, pos, not not effect.flipX)
            end
        end
    elseif state == 1 then
        self.super.onEmit(self, barrage, config, state, bullets)
    end

end

function MonsterCaptain:doAttack()
    ---@type PlayerCaptain
    local target  = self:findNearestEnemy()
    if target then
        local targetBox = target:getCollisionWithName("bdbox")
        local myBox = self:getCollisionWithName("bdbox_eff")
        if target:isDebuted() and not target:isOffStage() and BattleUtils.isPolygonInterSection(targetBox, myBox)  then
            --local pos = BattleUtils.polygonCenterPoint(targetBox)
            local args = { hurt       = -math.floor(target:getMaxHp()*0.03),
                           --attacker   = attacker,
                           --effectName = hitEffect and hitEffect.effectName,
                           --scale      = hitEffect and hitEffect.scale or 1,
                           --actionName = hitEffect and hitEffect.actionName,
                           --pos        = (hitEffect and hitEffect.offset) and pos + hitEffect.offset or pos
            }
            target:doEvent(enum.eFlightStateEvent.BH_HIT, args)
        end
    end
end

-- buffer
--[[
function MonsterCaptain:getBFEffectAddTimes(id)
    local times = 0
    for k, effect in ipairs(self.bufferEffectMap) do
        if effect:getId() == id then
            times = times + effect:getAddTimes()
        end
    end
    return times
end

function MonsterCaptain:getBFEffect(id)
    for k, effect in ipairs(self.bufferEffectMap) do
        if effect:getId() == id then
            return effect
        end
    end
end
function MonsterCaptain:addBFEffect(bufferEffect)
    table.insert(self.bufferEffectMap, bufferEffect)
end
function MonsterCaptain:removeBFEffect(bufferEffect)
    -- self.bufferEffectMap[bufferEffect:getObjectID()] = nil
    table.removeItem(self.bufferEffectMap, bufferEffect)
end
function MonsterCaptain:handlBufferEffect(dt)
    --TODO 测试貌似在update 里删除 effect 没毛病
    self:walkBufferEffectWalk(function(effect)
        effect:update(dt)
    end)
end

--获取buffer效果
function MonsterCaptain:getBufferEffectMap()
    return self.bufferEffectMap
end

function MonsterCaptain:getBuffer(id)
    for i, buffer in ipairs(self.bufferList) do
        if buffer:getID() == id then
            return buffer
        end
    end
end
--移除特殊类型buffer effect
function MonsterCaptain:removeSpecialTypeEffect(specialType)
    local effectMap = self.bufferEffectMap
    for k = #effectMap, 1, -1 do
        local effect = effectMap[k]
        if effect:getSpecialType() == specialType then
            effect:removeSelf()
        end
    end
end

function MonsterCaptain:walkBufferEffectWalk(callfunc)
    for index = #self.bufferEffectMap, 1, -1 do
        local effect = self.bufferEffectMap[index]
        if effect then
            callfunc(effect)
        end
    end
end

function MonsterCaptain:playMoveEffect()
    if not self.isPlayMoveEffect then
        if self.data.moveType == 0 then
            self.isPlayMoveEffect = BattleUtils.playEffect(BattleConfig.MOVE_EFFECT, true)
        elseif self.data.moveType == 1 then
            self.isPlayMoveEffect = BattleUtils.playEffect(BattleConfig.FLY_EFFECT, true)
        end
    end
end

function MonsterCaptain:stopMoveEffect()
    if self.isPlayMoveEffect then
        TFAudio.stopEffect(self.isPlayMoveEffect)
        self.isPlayMoveEffect = nil
    end
end

function MonsterCaptain:removeAllBuff()

end

--动画帧事件
function MonsterCaptain:onArmatureEvent(event)
    --if event.name == eArmtureEvent.HURT then
    --    self:hitTest(target)
    --elseif event.name == eArmtureEvent.MUSIC then
    --    --音效触发
    --    self:doMusicEvent(event.pramN)
    --elseif event.name == eArmtureEvent.EFFECT then
    --    --特效触发
    --    self:doEffectEvent(event.pramN)
    --end
end

function MonsterCaptain:doEffectEvent(pramN)
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

function MonsterCaptain:doMusicEvent(pramN)
    local eventName  = enum.eArmtureEvent.MUSIC .. pramN
    local resource   = self.data.model
    local action     = self.fighter:getFixAnimation()
    local musicDatas = BattleDataMgr:getActorMusicDatas(resource, action, eventName)
    if musicDatas then
        print(musicDatas)
        for i, musicData in ipairs(musicDatas) do
            local handle = BattleUtils.playEffect(musicData.resource, false, musicData.volume * 0.01)
            self:addSoundEffect(handle)
        end
    end
end

function MonsterCaptain:onEventTrigger(event, target, param)
    if not event then
        printError("hero onEventTrigger event is nil")
        Box("hero onEventTrigger event is nil")
    end
    -- print(string.format("onEventTrigger(%s,%s,%s)",self.data.name , event,param))
    -- 这段代码为战斗数据统计服务
    if event == eBFState.E_JI_SHA then
        --检查是不是使用入场技能击杀
        if self.skill then
            if self.skill:getKeyCode() == enum.eVKeyCode.SKILL_E then
                EventMgr:dispatchEvent(eEvent.EVENT_SKILL_ENTER_KILL, self)
            end
        end
    elseif event == eBFState.E_JX_ACTION then
        --使用觉醒技能次数统计
        EventMgr:dispatchEvent(eEvent.EVENT_SKILL_AWAKE, self)
    elseif event == eBFState.E_DZ_F_ACITON then
        EventMgr:dispatchEvent(eEvent.EVENT_SKILL_DAZHAO, self)
    end

    bufferMgr:walk(function(buffer)
        buffer:onEventTrigger(self, event, target, param)
    end)
    self:walkBufferEffectWalk(function(effect)
        effect:onEventTrigger(self, event, target, param)
    end)
end
--]]
function MonsterCaptain:onAttrTrigger(attrType, value)
    self.super.onAttrTrigger(self, attrType, value)
    if self.fighter then
        self.fighter:updateInfo()
    end
end

function MonsterCaptain:act_useSkill(id,bulletId)
    print("cast ", bulletId)
    local barrages = self.data.flySkills
    local result = false
    for _, cfg in ipairs(barrages) do
        if cfg.cfg.id == bulletId then
            local barrage = self.barrages[cfg]
            if barrage then
                barrage:Emit(cfg.emitter)
                barrage:Resume()
                result = true
            end
            break
        end
    end
    if result then
        self.aiAgent:endToActiveChildNode()
    else
        if me.platform == "win32" then
            Box(string.format("Monster id = (%d) not found bullet id (%d) when cast skill(AI)", self.data.fixedMonster, bulletId))
        end
    end
    return result
end

return MonsterCaptain