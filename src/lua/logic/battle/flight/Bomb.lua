local ResLoader   = import("..ResLoader")
local BattleMgr   = import("..BattleMgr")
local BattleUtils = import("..BattleUtils")
local enum        = import("..enum")
local SpellBase   = import(".SpellBase")

local heroMgr     = BattleMgr.getHeroMgr()

---@param parent CCNode
---@param effectName string
---@param actionName string
---@param scale number
---@param position ccp
---@param handle function
local function createEffect(parent, effectName, actionName, scale, position, handle)
    local effectNode = ResLoader.createEffect(effectName, scale)

    effectNode:setPosition(me.p(0, 0))
    effectNode:setAnimationFps(GameConfig.ANIM_FPS)
    effectNode:setColor(me.WHITE)
    effectNode:setRotation(0)
    effectNode:setToSetupPose()
    effectNode:clearTracks()

    if actionName and actionName ~= "" then
        effectNode:play(actionName, 0)
    else
        effectNode:playByIndex(0, 0)
    end
    effectNode:addMEListener(TFARMATURE_COMPLETE, function(node)
        node:removeMEListener(TFARMATURE_COMPLETE)
        node:removeFromParent()
        if type(handle) == "function" then
            handle()
        end
    end)
    effectNode:setPosition(position)
    --if flipX then
    --    effectNode:setScaleX(-math.abs(effectNode:getScaleX()))
    --end
    if not tolua.isnull(parent) then
        effectNode:setCameraMask(parent:getCameraMask())
        parent:addChild(effectNode)
    end
    return effectNode
end

---@class Bomb : Spell
local Bomb = class("Bomb", SpellBase)

function Bomb:ctor(captain, data, parent)
    self.super.ctor(self, captain, data)
    self.parent  = parent
    self:init()
end

function Bomb:init()
    self.ELAPSE_INTERVAL = self.data.interval * 1000
    self.position        = ccp(GameConfig.WS.width / 2, GameConfig.WS.height / 2)
    self.defaultHurtArgs = { hurt       = -(self.captain:getAtkHurt() * self.data.damagePercent),
                             effectName = self.data.hitEffect and self.data.hitEffect.effectName,
                             scale      = self.data.hitEffect and self.data.hitEffect.scale or 1,
                             actionName = self.data.hitEffect and self.data.hitEffect.actionName,
                             pos        = (self.data.hitEffect and self.data.hitEffect.offset) and self.data.hitEffect.offset or ccp(0, 0)
    }
    self.super.init(self)
end

function Bomb:reset()
    self.super.reset(self)
    self.effectNode     = nil
    self.elapse         = 0
end

function Bomb:destroy()
    if self.effectNode and not tolua.isnull(self.effectNode) then
        self.effectNode:removeMEListener(TFARMATURE_COMPLETE)
        self.effectNode:removeFromParent()
        self.effectNode = nil
    end
    self.ELAPSE_INTERVAL = nil
    self.parent          = nil
    self.elapse          = nil
    self.super.destroy(self)
end

function Bomb:canChangeState()
    return true
end

function Bomb:stop()
    if self.data.isEnd then
        self.cancel = true
    end
    if self.effectNode and not tolua.isnull(self.effectNode) then
        self.effectNode:stop()
        self.effectNode:removeMEListener(TFARMATURE_COMPLETE)
        self.effectNode:removeFromParent()
        self.effectNode = nil
    end
    self:reset()
end

---@protected
function Bomb:doCast()
    local scale     = (self.data.scale == nil or self.data.scale == 0) and 1 or self.data.scale
    self.effectNode = createEffect(self.parent, self.data.effectName, self.data.actionName, scale, self.position, function()
        if "function" == type(self.completeHandle) and not self.cancel then
            self.completeHandle()
        end
        self:reset()
    end)
    self.effectNode:addMEListener(TFARMATURE_EVENT, handler(self.onArmatureEvent, self))
end

function Bomb:tryCast(completeHandle)
    if self.super.tryCast(self, completeHandle) then
        local castEffect = self.data.fireEffect
        if castEffect.effectName and castEffect.effectName ~= "" then
            local pos = self.captain:getCenterPoint() - self.captain:getPosition()
            createEffect(self.captain.fighter, castEffect.effectName,
                    castEffect.actionName, castEffect.scale, pos, function()
                        self:doCast()
                    end)
        else
            self:doCast()
        end
        return self
    end
end

function Bomb:update(dt)
    if not tolua.isnull(self.effectNode) and not self.cancel then
        local myBox = self.effectNode:getCollisionWithName(self.data.colliderName)
        self.elapse = (self.elapse or 0) + math.floor(dt * 1000)
        while self.elapse >= self.ELAPSE_INTERVAL do
            for _, captain in ipairs(heroMgr:getObjects()) do
                if captain ~= self.captain then
                    captain:clearBullet()
                    local roleBox = captain:getCollisionWithName()
                    if captain:isDebuted() and not captain:isOffStage() and BattleUtils.isPolygonInterSection(roleBox, myBox) then
                        local pos = BattleUtils.polygonCenterPoint(roleBox)
                        local args = clone(self.defaultHurtArgs)
                        args.attacker = self.captain
                        args.pos = pos + args.pos
                        captain:doEvent(enum.eFlightStateEvent.BH_HIT, args)
                    end
                end
            end
            self.elapse = self.elapse - self.ELAPSE_INTERVAL
        end
    end
    self.super.update(self, dt)
end

return Bomb