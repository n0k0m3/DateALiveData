local StateMachine   = import("..StateMachine")
local BattleConfig   = import("..BattleConfig")
local BattleUtils    = import("..BattleUtils")
local BattleMgr      = import("..BattleMgr")
local Operate        = import("..Operate")
local ActionMgr      = import("..ActionMgr")
local EventTrigger   = import("..EventTrigger")
local StateMgr       = import("..StateMgr")
local enum           = import("..enum")
local levelParse     = import("..LevelParse")
local CaptainBase    = import(".CaptainBase")
local PlayerFighter  = import(".PlayerFighter")
local WingmanCaptain = import(".WingmanCaptain")
local Bomb           = import(".Bomb")
local Impact         = import(".Impact")

--local bufferMgr         = BattleMgr.getBufferMgr()
local heroMgr           = BattleMgr.getHeroMgr()
local eAttrType         = enum.eAttrType
local eFlightState      = enum.eFlightState
local eFlightStateEvent = enum.eFlightStateEvent
local eBFState          = enum.eBFState
local eEvent            = enum.eEvent

local winSize = me.EGLView:getFrameSize()
local scaleX = 1 --(winSize.height/GameConfig.DESIGN_SIZE.height)

local function emitterTurn(cfg)
    for _, emit in ipairs(cfg.emitter) do
        if emit.Config.Angle <= 0 then
            emit.Config.Angle = -180 - emit.Config.Angle
        else
            emit.Config.Angle = 180 - emit.Config.Angle
        end
    end
    return cfg
end

---@class PlayerCaptain : CaptainBase
local PlayerCaptain     = class("PlayerCaptain", CaptainBase)

local fsmCfg         = {
    events  = {
        { name = eFlightStateEvent.BH_BORN, from = { StateMachine.WILDCARD}, to = eFlightState.ST_BORN },
        { name = eFlightStateEvent.BH_STAND, from = { eFlightState.ST_BORN}, to = eFlightState.ST_STAND },
        { name = eFlightStateEvent.BH_FORWARD, from = { eFlightState.ST_STAND, eFlightState.ST_BACKWARD, eFlightState.ST_SKILL, eFlightState.ST_HIT }, to = eFlightState.ST_FORWARD },
        { name = eFlightStateEvent.BH_BACKWARD, from = { eFlightState.ST_FORWARD, eFlightState.ST_SKILL, eFlightState.ST_HIT  }, to = eFlightState.ST_BACKWARD },
        { name = eFlightStateEvent.BH_SKILL, from = { eFlightState.ST_FORWARD, eFlightState.ST_BACKWARD, eFlightState.ST_HIT }, to = eFlightState.ST_SKILL },
        { name = eFlightStateEvent.BH_HIT, from = { eFlightState.ST_FORWARD, eFlightState.ST_BACKWARD, eFlightState.ST_SKILL, eFlightState.ST_HIT }, to = eFlightState.ST_HIT },
        { name = eFlightStateEvent.BH_OFFSTAGE, from = { eFlightState.ST_BORN, eFlightState.ST_FORWARD, eFlightState.ST_BACKWARD, eFlightState.ST_SKILL, eFlightState.ST_HIT }, to = eFlightState.ST_OFFSTAGE },
        { name = eFlightStateEvent.BH_DIE, from = { eFlightState.ST_OFFSTAGE, StateMachine.WILDCARD }, to = eFlightState.ST_DIE },
        { name = eFlightStateEvent.BH_WIN, from = { StateMachine.WILDCARD }, to = eFlightState.ST_WIN }, --获胜状态
    },
    initial = {
        event = StateMachine.WILDCARD,
        state = StateMachine.WILDCARD,
    }
}

function PlayerCaptain:ctor(data)
    self.super.ctor(self, data)
    self:initFsm(fsmCfg)

    self.actionMgr = ActionMgr.createMgr()
    self.operate   = Operate:new(self)

    --self.stateMgr = StateMgr:new(self)

    self.bullet = { index = 1, level = {} }
    for i, _ in ipairs(self.data.flySkills) do
        self.bullet.level[i] = 1
    end

    self.spells = {}
    self.property:dispatchChange()
    self.ignoreBlock = false
end

function PlayerCaptain:init()
    --- @type PlayerFighter
    self.fighter = PlayerFighter:new(self)
    self.super.init(self)
    self:setDir(enum.eDir.RIGHT)
    if self.data.wingman then
        --- @type WingmanCaptain
        self.wingman = WingmanCaptain:new(self, self.fighter)
        self.wingman:move(self.position3D)
    end
end

function PlayerCaptain:setVisible(value)
    self.super.setVisible(self, value)
    if self.wingman then
        if value then
            self.wingman:show()
        else
            self.wingman:hide()
        end
    end
end

function PlayerCaptain:update(dt)
    self.super.update(self, dt)
    if self.wingman then
        self.wingman:update(dt)
    end
    self:handleMove(dt)
    self.actionMgr:update(dt*0.001)

    if self.spells then
        for _, spell in pairs(self.spells) do
            spell:update(dt)
        end
    end
    --if self.beginDraw then
    --    self.dbgPoints =  self.dbgPoints or {}
    --    self.dbgPoints[#self.dbgPoints + 1] = self.fighter:getPosition()
    --    self.fighter:drawCollisionBox(self.dbgPoints)
    --end
end

function PlayerCaptain:changeAnger(value)
    self.property:changeValue(eAttrType.ATTR_NOW_AGR, value)
end

function PlayerCaptain:onPickUp(prop)
    local data = prop:getData()
    EventMgr:dispatchEvent(eEvent.EVENT_PICKUP, data)
    self:onEventTrigger(eBFState.E_PICKUP_ITEM)
    local pos = self:getCenterPoint() - self:getPosition()
    self.fighter:playEffect(data.getResource, data.scale, data.getAction, pos, false, function ()
        if data.type == enum.eFlightItemDropType.PLAYER_BARRAGE_UP then
            local index, level, barrages =  self.bullet.index, self.bullet.level, self.data.flySkills
            if level[index] < #barrages[index] then
                local cfg = barrages[index][level[index]]
                local barrageNode = self.barrages[cfg]
                if barrageNode then
                    barrageNode:Stop()
                end
                level[index] = level[index] + 1
                cfg = barrages[index][level[index]]
                barrageNode = self.barrages[cfg]
                if not barrageNode then
                    if self.dir == enum.eDir.LEFT then
                        cfg = emitterTurn(cfg)
                    end
                    self:setBarrage(cfg)
                end
            end
        elseif data.type == enum.eFlightItemDropType.WINGMAN_BARRAGE_UP then
            if self.wingman then
                self.wingman:upgrade(data.param)
            end
        elseif data.type == enum.eFlightItemDropType.ANGER_RECOVER then
            self.property:changeValue(eAttrType.ATTR_NOW_AGR, data.param)
        else
            printError("FlyLevelItem id:%d  type:%d 未实现还是配错了？", data.id, data.type)
        end
    end)
end

--检查是否是有效输入
function PlayerCaptain:isValidKey(keyCode)
    return not not self:getSkill(keyCode)
end

function PlayerCaptain:createAndPush(keyCode,eventType)
    self.operate:createAndPush(keyCode,eventType)
end

function PlayerCaptain:onKeyEvent(keyCode)
    if keyCode ~= -1 then
        self:doCast(keyCode)
    end
end

function PlayerCaptain:getSkill(keyCode)
    return self.spells[keyCode]
end

function PlayerCaptain:doCast(keyCode)
    local spell = self.spells[keyCode]
    if spell and spell:canCast() then
        self:doEvent(eFlightStateEvent.BH_SKILL, keyCode)
    end
end

---@param vx number
---@param vy number
function PlayerCaptain:setRokeVector(vx, vy)
    self.operate:setRokeVector(vx, vy)
end

function PlayerCaptain:getRokeVector()
    return self.operate:getRokeVector()
end

function PlayerCaptain:getBumpEffect()
    return  self.data.bumpEffect
end

function PlayerCaptain:getYRoller()
    return self.data.yRoller
end

function PlayerCaptain:setDir(dir)
    if dir ~= self.dir then
        self.super.setDir(self, dir)
        if self.barrages then
            for cfg, barrage in pairs(self.barrages) do
                self:setBarrage(emitterTurn(cfg))
            end
        end
        if self.wingman then
            self.wingman:setDir(dir)
        end
    end
end

function PlayerCaptain:handleMove(time)
    local state = self.fsm:getState()
    if state == eFlightState.ST_FORWARD or state == eFlightState.ST_BACKWARD or state == eFlightState.ST_STAND or eFlightState.ST_HIT == state or eFlightState.ST_SKILL == state then
        local speed  = math.abs(self.property:getValue(eAttrType.ATTR_MOVE_SPEED)) * time / 1000
        local vector = self.operate:getRokeVector()
        local xv     = speed * vector.x
        local yv     = speed * vector.y -- * BattleConfig.YV_ATTENUATION_RATIO
        if xv ~= 0 or yv ~= 0 then
            self:move(xv, yv, true)
            if self.spellWithCasting and not self.spellWithCasting:canChangeState() then
                return
            end
            if self.data.turnBack then
                if xv > 0 and self.dir == enum.eDir.LEFT then
                    self:doEvent(eFlightStateEvent.BH_FORWARD, enum.eDir.RIGHT)
                elseif xv < 0 and self.dir == enum.eDir.RIGHT then
                    self:doEvent(eFlightStateEvent.BH_BACKWARD, enum.eDir.LEFT)
                end
            else
                if xv >=  0 then
                    self:doEvent(eFlightStateEvent.BH_FORWARD)
                elseif xv < 0 then
                    self:doEvent(eFlightStateEvent.BH_BACKWARD)
                end
            end
        else
            if self.data.turnBack then
                if self.dir == enum.eDir.LEFT then
                    self:doEvent(eFlightStateEvent.BH_BACKWARD, enum.eDir.LEFT)
                elseif self.dir == enum.eDir.RIGHT then
                    self:doEvent(eFlightStateEvent.BH_FORWARD, enum.eDir.RIGHT)
                end
            else
                if state == eFlightState.ST_STAND or state == eFlightState.ST_BACKWARD then
                    self:doEvent(eFlightStateEvent.BH_FORWARD)
                end
            end
        end
    end
end

function PlayerCaptain:move(xv, yv, fix)
    if xv == 0 and yv == 0 then
        return
    end
    if self.fighter then
        local pos = self.position3D
        local nx  = pos.x + xv*scaleX
        local ny  = pos.y + yv*scaleX
        if levelParse:canMove(nx, ny) then
            pos.x = nx
            pos.y = ny
        elseif levelParse:canMove(nx, pos.y) then
            pos.x = nx
        elseif levelParse:canMove(pos.x, ny) then
            pos.y = ny
        else
            if fix then
                if xv ~= 0 and yv == 0 then
                    local mvU = levelParse:canMove(pos.x, pos.y + levelParse:getBlockSize())  --and battleController.canMove(pos.x , pos.y +40)
                    local mvD = levelParse:canMove(pos.x, pos.y - levelParse:getBlockSize())  --and battleController.canMove(pos.x , pos.y -40)
                    if mvD and mvU then
                        return
                    elseif mvD then
                        pos.y = pos.y - math.abs(xv)
                    elseif mvU then
                        pos.y = pos.y + math.abs(xv)
                    else
                        return
                    end
                else
                    return
                end
            else
                return
            end
        end
        pos.z = pos.y
        self.fighter:setPosition(pos.x, pos.z)
        self.fighter:drawCollisionBox()
        if self.wingman then
            self.wingman:move(pos)
        end
        EventTrigger:_onChangePos(self)
    end
end

function PlayerCaptain:findNearestEnemy()
    local heroes = heroMgr:getObjects()
    if #heroes == 0 then
        return nil
    end
    local pos1   = self:getPosition()
    local tmpDis = 0xFFFF
    local idx    = 0
    for index, hero in ipairs(heroes) do
        if hero:getData().roleType ~= enum.eRoleType.Hero then
            local pos2 = hero:getPosition()
            local dis  =ccpDistance(pos2, pos1)
            if dis < tmpDis and not hero:isOffStage() and hero:isAlive() then
                tmpDis = dis
                idx    = index
            end
        end
    end
    return idx > 0 and heroes[idx] or nil
end

function PlayerCaptain:findRandomEnemy()
    local heroes = heroMgr:getObjects()
    local count = #heroes
    if count < 2 then
        return nil
    end
    local targets = {}
    for _, captain in ipairs(heroes) do
        if captain:getData().roleType ~= enum.eRoleType.Hero and not captain:isOffStage() and captain:isDebuted() and captain:isAlive() then
            targets[#targets+1] = captain
        end
    end
    count = #targets
    if count > 0  then
        return targets[RandomGenerator.random(1, count)]
    end
    return nil
end

function PlayerCaptain:fire()
    self.super.fire(self)
    if self.wingman then
        self.wingman:fire()
    end
end

function PlayerCaptain:ceasefire()
    self.super.ceasefire(self)
    if self.wingman then
        self.wingman:ceasefire()
    end
end

function PlayerCaptain:renderMove(x, y, z)
    z = z or 0
    if x ~= 0 or y ~= 0 or z ~= 0 then
        if self.fighter then
            local pos = self.position3D
            local nx     = pos.x + x
            local ny     = pos.y + y --逻辑位置
            local nz     = pos.z + z --渲染位置Y
            if self.ignoreBlock then
                pos.x = nx
                pos.y = ny
                pos.z = ny
            else
                if levelParse:canMove(nx, ny) then
                    pos.x = nx
                    pos.y = ny
                elseif levelParse:canMove(nx, pos.y) then
                    pos.x = nx
                elseif levelParse:canMove(pos.x, ny) then
                    pos.y = ny
                elseif z ~= 0 and y == 0 then
                    pos.z = nz
                end
            end
            pos.z = math.max(pos.z, pos.y)
            self.fighter:setPosition(pos.x, pos.z)
            if self.wingman then
                self.wingman:move(pos)
            end
        end
    end
end

function PlayerCaptain:getRoleAction(action)
    if self.actionNames then
        return self.actionNames[self.skinIndex][action]
    end
end
--保存动作的数据
function PlayerCaptain:setRoleAction(data)
    self.roleAction = data
end

function PlayerCaptain:ready()
    self.super.ready(self)
    local barrages = self.data.flySkills
    local index, level = self.bullet.index, self.bullet.level
    if #barrages > 0 and level[index] and #barrages[index] >= level[index] and barrages[index][level[index]] then
        local barrage = barrages[index][level[index]]
        if barrage then
            self:setBarrage(barrage)
        end
    end
    for _, skill in pairs(self.data.skills) do
        if skill.type == 1 then
            self.spells[skill.keyCode] = Bomb:new(self, skill, self.fighter:getParent())
        elseif skill.type ==  2 then
            self.spells[skill.keyCode] = Impact:new(self, skill, self.fighter:getParent())
        end
    end
    if self.wingman then
        self.wingman:ready()
    end
    EventMgr:dispatchEvent(eEvent.EVENT_CAPTAIN_CHANGE, self)
    EventMgr:dispatchEvent(eEvent.EVENT_MAP_SCROLL_SWITCH, true)
end

function PlayerCaptain:hasAliveBarrage()
    local result = self.super.hasAliveBarrage(self)
    if self.wingman then
        return result or self.wingman:hasAliveBarrage()
    end
    return result
end

function PlayerCaptain:hasAliveBullet()
    local result = self.super.hasAliveBullet(self)
    if self.wingman then
        return result or self.wingman:hasAliveBullet()
    end
    return result
end

function PlayerCaptain:onBorn(args)
    self.super.onBorn(self, args)
    if self.fighter then
        self:doEvent(eFlightStateEvent.BH_STAND)
    end
    local action = ActionMgr.createMoveAction()
    local pos    = ccp(0, 0)
    if self.data.debutDir == enum.eMapMoveDirection.LEFT then
        pos = ccp(math.abs(self.position3D.x) + self.data.debutDistance, 0)
    elseif self.data.debutDir == enum.eMapMoveDirection.RIGHT then
        pos = ccp(math.abs(self.position3D.x) - GameConfig.WS.width - self.data.debutDistance, 0)
    elseif self.data.debutDir == enum.eMapMoveDirection.BOTTOM then
        pos = ccp(0, self.data.debutDistance + math.abs(self.position3D.y))
    elseif self.data.debutDir == enum.eMapMoveDirection.TOP then
        pos = ccp(0, -math.abs(math.abs(self.position3D.y) - GameConfig.WS.height + self.data.debutDistance))
    end
    pos.z            = pos.y
    self.ignoreBlock = true
    action:start(self, 1, pos, function()
        self.ignoreBlock = false
        self.debuted     = true
        self:ready()
    end)
end

function PlayerCaptain:onStand(args)
    self.super.onStand(self, args)
    if self.fighter then
        self.fighter:playForward()
        self:playMoveEffect()
    end
    if self.wingman then
        self.wingman:show()
    end
end

function PlayerCaptain:onForward(event)
    if self.fighter then
        local dir = event.dir
        if dir then
            if self.dir ~= dir then
                self.fighter:playBackwardToForward(function ()
                    self:setDir(dir)
                    self.fighter:playForward()
                end)
            end
        else
            if event.from == eFlightState.ST_BACKWARD then
                self.fighter:playBackwardToForward(function ()
                    self.fighter:playForward()
                end)
            else
                self.fighter:playForward()
            end

        end
    end
    self:playMoveEffect()
end

function PlayerCaptain:onBackward(event)
    if self.fighter then
        local dir = event.dir
        if dir then
            if self.dir ~= dir then
                self.fighter:playForwardToBackward(function ()
                    self:setDir(dir)
                    self.fighter:playBackward()
                end)
            end
        else
            if event.from == eFlightState.ST_FORWARD then
                self.fighter:playForwardToBackward(function ()
                    self.fighter:playBackward()
                end)
            else
                self.fighter:playBackward()
            end
        end
    end
    self:playMoveEffect()
end

function PlayerCaptain:onHurt(args)
    self.super.onHurt(self, args)
    EventMgr:dispatchEvent(eEvent.EVENT_LOSE_HP, args.hurt or 0)
end

function PlayerCaptain:onCast(keyCode)
    local spell = self.spells[keyCode]
    if spell and self.fighter and spell:canCast() then
        ---@type Spell
        self.spellWithCasting = spell:tryCast(function ()
            self.spellWithCasting = nil
            self:doEvent(eFlightStateEvent.BH_FORWARD)
        end)
        --self.fighter:playSkill(function ()
        --    bomb:doCast()
        --    self.fighter.skeletonNode:setToSetupPose()
        --    if self.data.turnBack then
        --        if self.dir == enum.eDir.LEFT then
        --            self:doEvent(eFlightStateEvent.BH_BACKWARD, enum.eDir.LEFT)
        --        elseif self.dir == enum.eDir.RIGHT then
        --            self:doEvent(eFlightStateEvent.BH_FORWARD, enum.eDir.RIGHT)
        --        end
        --    else
        --        self:doEvent(eFlightStateEvent.BH_FORWARD)
        --    end
        --end)
    end
end

function PlayerCaptain:onWin(handle)
    self:ceasefire()
    if self.fighter then
        self.fighter:playWin(function()
            local pos = ccp(0, 0)
            if self.data.leaveDir == enum.eMapMoveDirection.LEFT then
                pos = ccp( -(self.position3D.x+self.data.debutDistance), 0)
                self:setDir(enum.eDir.LEFT)
            elseif self.data.leaveDir == enum.eMapMoveDirection.RIGHT then
                pos = ccp(winSize.width - self.position3D.x + self.data.debutDistance, 0)
                self:setDir(enum.eDir.RIGHT)
            elseif self.data.leaveDir == enum.eMapMoveDirection.BOTTOM then
                pos = ccp(0, -(self.position3D.y+self.data.debutDistance))
            elseif self.data.leaveDir == enum.eMapMoveDirection.TOP then
                pos = ccp(0, winSize.height - self.position3D.y + self.data.debutDistance)
            end
            pos.z = pos.y
            self.fighter:playForward()
            local action = ActionMgr.createMoveAction()
            self.ignoreBlock = true
            action:start(self, 1, pos, function()
                self.ignoreBlock = false
                if type(handle) == "function" then
                    handle()
                end
                self:release()
            end)
        end)
    else
        if type(handle) == "function" then
            handle()
        end
        self:release()
    end
end

function PlayerCaptain:onOffStage(args)
    self:ceasefire()
    if self.wingman then
        if args then
            self.wingman:clearBullet()
        end
    end
    self.super.onOffStage(self, args)
end

function PlayerCaptain:onDead(args)
    self.super.onDead(self, args)
    if self.wingman then
        self.wingman:clearBullet()
        self.wingman:destroy()
        self.wingman = nil
    end

    local function fadeOut()
        self.fighter:fadeOut(function()
            self:release()
            EventMgr:dispatchEvent(eEvent.EVENT_HERO_DEAD, self)
        end)
    end
    self.fighter:playDead(args.deadAction, function()
        local pos0 = self:getCenterPoint()
        if self.data.debutDir == enum.eMapMoveDirection.LEFT or self.data.debutDir == enum.eMapMoveDirection.RIGHT then
            local offsetX1, offsetX2, offsetY1 = 0, 0, 0
            if self.dir == enum.eDir.LEFT then
                offsetX1, offsetX2 = 126, 20, 52
            elseif self.dir == enum.eDir.RIGHT then
                offsetX1, offsetX2 = -126, -20, -52
            end
            local pos1 = ccp(pos0.x + offsetX1, pos0.y+ offsetY1)
            local pos2 = ccp(pos1.x + offsetX2, -100)
            local actions = {
                EaseSineIn:create(BezierTo:create(0.8, {pos0, pos1, pos2})),
                CallFunc:create(fadeOut)
            }
            self.fighter:runAction(Sequence:createWithTable(actions))
        elseif self.data.debutDir == enum.eMapMoveDirection.BOTTOM or self.data.debutDir == enum.eMapMoveDirection.TOP then
            local pos1 = ccp(pos0.x, -100)
            local actions = {
                EaseSineIn:create(CCMoveTo:create(0.8, pos1)),
                CallFunc:create(fadeOut)
            }
            self.fighter:runAction(Sequence:createWithTable(actions))
        else
            fadeOut()
        end
    end)
    EventMgr:dispatchEvent(eEvent.EVENT_MAP_SCROLL_SWITCH, false)
end

function PlayerCaptain:onFall(args)
    local function fadeOut()
        self.fighter:fadeOut(function()
            self:release()
            EventMgr:dispatchEvent(eEvent.EVENT_HERO_DEAD, self)
        end)
    end
    self.fighter:playFall(function()
        local pos0   = self:getCenterPoint()
        local function nextPoint(point, angle, offX, offY)
            local radian = angle * 3.14159 / 180
            return  ccp(point.x - math.cos(radian)*offX, point.y - math.sin(radian)*offY)
        end
        local pos1 = nextPoint(pos0, 22, 52, 20)
        local pos2 = nextPoint(pos1, 59, 44, 84)
        local pos3 = nextPoint(pos2, 82, 10, pos2.y+200)
        local actions      = {
            --EaseIn:create(CCMoveTo:create(3, ccp(pos2.x, pos3.y)), 0.1),
            BezierTo:create(0.3, {pos0, pos1, pos2}),
            EaseSineIn:create(CCMoveTo:create(0.8, pos3)),
            CallFunc:create(fadeOut)
        }
        self.fighter:runAction(Sequence:createWithTable(actions))
    end)
end

function PlayerCaptain:onEmit(barrage, config, state, bullets)
    if state == 0 then
        if self.fighter and barrage.cfg and barrage.cfg.cfg and barrage.cfg.cfg.fireEffect then
            if barrage.cfg and barrage.cfg.cfg and barrage.cfg.cfg.fireEffect then
                local effect = barrage.cfg.cfg.fireEffect
                if effect.effectName and effect.effectName ~= "" then
                    local pos = effect.launchPoint and self.fighter:getRelativeBonePosition(effect.launchPoint) or ccp(0, 0)
                    pos = effect.offset and pos + effect.offset or pos
                    self.fighter:playEffect(effect.effectName, effect.scale or 1, effect.actionName, pos, not not effect.flipX)
                else
                    self.super.onEmit(self, barrage, config, state, bullets)
                end
            else
                self.super.onEmit(self, barrage, config, state, bullets)
            end
        end
    elseif state == 1 then
        self.super.onEmit(self, barrage, config, state, bullets)
    end
end

-- buffer
--[[
function PlayerCaptain:getBFEffectAddTimes(id)
    local times = 0
    for k, effect in ipairs(self.bufferEffectMap) do
        if effect:getId() == id then
            times = times + effect:getAddTimes()
        end
    end
    return times
end

function PlayerCaptain:getBFEffect(id)
    for k, effect in ipairs(self.bufferEffectMap) do
        if effect:getId() == id then
            return effect
        end
    end
end
function PlayerCaptain:addBFEffect(bufferEffect)
    table.insert(self.bufferEffectMap, bufferEffect)
end
function PlayerCaptain:removeBFEffect(bufferEffect)
    -- self.bufferEffectMap[bufferEffect:getObjectID()] = nil
    table.removeItem(self.bufferEffectMap, bufferEffect)
end
function PlayerCaptain:handlBufferEffect(dt)
    --TODO 测试貌似在update 里删除 effect 没毛病
    self:walkBufferEffectWalk(function(effect)
        effect:update(dt)
    end)
end

--获取buffer效果
function PlayerCaptain:getBufferEffectMap()
    return self.bufferEffectMap
end

function PlayerCaptain:getBuffer(id)
    for i, buffer in ipairs(self.bufferList) do
        if buffer:getID() == id then
            return buffer
        end
    end
end
--移除特殊类型buffer effect
function PlayerCaptain:removeSpecialTypeEffect(specialType)
    local effectMap = self.bufferEffectMap
    for k = #effectMap, 1, -1 do
        local effect = effectMap[k]
        if effect:getSpecialType() == specialType then
            effect:removeSelf()
        end
    end
end

function PlayerCaptain:walkBufferEffectWalk(callfunc)
    for index = #self.bufferEffectMap, 1, -1 do
        local effect = self.bufferEffectMap[index]
        if effect then
            callfunc(effect)
        end
    end
end

function PlayerCaptain:playMoveEffect()
    if not self.isPlayMoveEffect then
        if self.data.moveType == 0 then
            self.isPlayMoveEffect = BattleUtils.playEffect(BattleConfig.MOVE_EFFECT, true)
        elseif self.data.moveType == 1 then
            self.isPlayMoveEffect = BattleUtils.playEffect(BattleConfig.FLY_EFFECT, true)
        end
    end
end

function PlayerCaptain:stopMoveEffect()
    if self.isPlayMoveEffect then
        TFAudio.stopEffect(self.isPlayMoveEffect)
        self.isPlayMoveEffect = nil
    end
end

function PlayerCaptain:removeAllBuff()

end

function PlayerCaptain:removeAllEffect()
    for key , effectNode in ipairs(self.effetList or {}) do
        effectNode:removeFromParent()
    end
    self.effetList = {}
end

function PlayerCaptain:addEffect(effectNode,zorder,addEffectList)
    if addEffectList == nil then
        addEffectList = true
    end
    if self.fighter then
        self.effetList =  self.effetList or {}
        self.fighter:addEffect(effectNode,zorder)
        if addEffectList then
            effectNode:setDir(self:getDir())
            table.insert(self.effetList, effectNode)
        end
    end
end

function PlayerCaptain:removeEffect(effectNode)
    table.removeItem(self.effetList,effectNode)
end
--]]

function PlayerCaptain:findTargets()
    local heroes = heroMgr:getObjects()
    local list = {}
    for _, v in ipairs(heroes) do
        if v ~= self then
            list[#list+1] = v
        end
    end
    return list
end

--动画帧事件
--function PlayerCaptain:onArmatureEvent(event)
--    if event.name == enum.eArmtureEvent.HURT then
--    elseif event.name == enum.eArmtureEvent.MUSIC then
--        --音效触发
--        self:doMusicEvent(event.pramN)
--    elseif event.name == enum.eArmtureEvent.EFFECT then
--        --特效触发
--        self:doEffectEvent(event.pramN)
--    end
--end

function PlayerCaptain:onEventWithSpell(event)
    if self.spellWithCasting then
        self.spellWithCasting:onEvent(event)
        --self:doMusicEvent(event.pramN)
    end
end

function PlayerCaptain:doEffectEvent(pramN)
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

function PlayerCaptain:onEventTrigger(event, target, param)
    if not event then
        printError("hero onEventTrigger event is nil")
    end
    --bufferMgr:walk(function(buffer)
    --    buffer:onEventTrigger(self, event, target, param)
    --end)
    --self:walkBufferEffectWalk(function(effect)
    --    effect:onEventTrigger(self, event, target, param)
    --end)
end

function PlayerCaptain:onAttrTrigger(attrType, value)
    self.super.onAttrTrigger(self, attrType, value)
    if attrType == eAttrType.ATTR_NOW_HP
            or attrType == eAttrType.ATTR_NOW_AGR
            or attrType == eAttrType.ATTR_NOW_SLD
            or attrType == eAttrType.ATTR_NOW_RST
            or attrType == eAttrType.ATTR_NOW_ENERGY then
        EventMgr:dispatchEvent(eEvent.EVENT_HERO_ATTR_CHANGE, self)
    end
end

return PlayerCaptain