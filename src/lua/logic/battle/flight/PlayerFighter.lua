local BattleUtils  = import("..BattleUtils")
local BattleConfig = import("..BattleConfig")
local ResLoader    = import("..ResLoader")
local enum         = import("..enum")
local FighterBase  = import(".FighterBase")

local eFlightAnimation = enum.eFlightAnimation

local function nodeScaleX(node, scaleX, dir)
    if node then
        local pos = node:getPosition()
        if dir == enum.eDir.LEFT then
            node:setPosition(ccp(-math.abs(pos.x), pos.y))
            node:setScaleX(-math.abs(scaleX))
        elseif dir == enum.eDir.RIGHT then
            node:setPosition(ccp(math.abs(pos.x), pos.y))
            node:setScaleX(math.abs(scaleX))
        end
    end
end

local function removeSkeletonNode(node)
    if node then
        node:removeMEListener(TFARMATURE_EVENT)
        node:removeMEListener(TFARMATURE_COMPLETE)
        node:removeFromParent()
        node = nil
    end
end

---@class PlayerFighter : FighterBase
local PlayerFighter    = class("PlayerFighter",FighterBase)

---@param captain PlayerCaptain
function PlayerFighter:ctor(captain)
    self.super.ctor(self, captain)
    self.launcherEventsIndex = {}
    local model           = self.captain.data.model
    local scale           = self.captain.data.modelSize
    self:init(model, scale)
end

function PlayerFighter:init(model, scale)
    self.super.init(self, model, scale)
    local effect = self.captain.data.launchEffect
    if effect and effect.effectName and effect.effectName ~= "" then
        if effect.normalActionName and effect.normalActionName ~= "" then
            self.normalActionName = effect.normalActionName
        end
        if effect.launchActionName and effect.launchActionName ~= "" then
            self.launchActionName = effect.launchActionName
        end
        if effect.launchPointName and effect.launchPointName ~= "" then
            self.launchPointName = effect.launchPointName
        end
        self.launchOffset = effect.offset or ccp(0, 0)
        self.launcherNode = ResLoader.createRole(effect.effectName, effect.scale or BattleConfig.FLIGHT_MODEL_SCALE)

        self.launcherNode:setScheduleUpdateWhenEnter(false)
        self.launcherNode:hide()

        self:addChild(self.launcherNode)
        if self.normalActionName then
            self.launcherNode:play(self.normalActionName, 1)
        else
            self.launcherNode:playByIndex(0, 1)
        end
        self.launcherNode:setPosition(ccp(80, 50))
        self.launcherNode:addMEListener(TFARMATURE_EVENT, handler(self.onLauncherArmatureEvent, self))
    end

    effect = self.captain.data.moveEffect
    if effect and effect.effectName and effect.effectName ~= "" then
        self.moveEffectNode = ResLoader.createRole(effect.effectName, effect.scale or BattleConfig.FLIGHT_MODEL_SCALE)
        self.moveEffectNode:setScheduleUpdateWhenEnter(false)
        self.moveEffectNode:hide()
        self:addChild(self.moveEffectNode)
        if effect.actionName then
            self.moveEffectNode:play(effect.actionName, 1)
        else
            self.moveEffectNode:playByIndex(0, 10)
        end
        self.moveEffectNode:setPosition(effect.offset or ccp(0, 0))
    end
    --self.launcherNode:addMEListener(TFARMATURE_EVENT, handler(self.onArmatureEvent, self))
end

function PlayerFighter:destroy()
    removeSkeletonNode(self.launcherNode)
    removeSkeletonNode(self.moveEffectNode)
    self.super.destroy(self)
end

function PlayerFighter:update(dt)
    self.super.update(self, dt)
    if self.launcherNode then
        self.launcherNode:update(dt*0.001)
    end
    if self.moveEffectNode then
        self.moveEffectNode:update(dt*0.001)
    end
end

function PlayerFighter:setPosition(x, y)
    self.super.setPosition(self, x, y)
    -- self.pos + launcher.pos + launcherPoint + offset
    if self.captain.barrages then
        local pos             = self:getPosition()
        if self.launcherNode then
            local launcherPoint   = self.launchPointName and self.launcherNode:getBonePosition(self.launchPointName) or ccp(0, 0)
            local launcherNodePos = self.launcherNode:getPosition()
            local launcherOffset  = self.launchOffset
            local scaleX          = self.launcherNode:getScaleX()
            local scaleY          = self.launcherNode:getScaleY()
            pos                   = ccp(pos.x + launcherNodePos.x + launcherPoint.x * scaleX + launcherOffset.x,
                    pos.y + launcherNodePos.y + launcherPoint.y * scaleY + launcherOffset.y)
        end
        local posCenter = self.captain:getCenterPoint()
        for k, barrage in pairs(self.captain.barrages) do
            if k.cfg.keyCode then
                if not k.casting then
                    barrage:UpdateEmitPos(posCenter)
                end
            else
                barrage:UpdateEmitPos(pos)
            end
        end
    end
end

function PlayerFighter:setDir(dir)
    self.super.setDir(self, dir)
    local scaleX = self.skeletonNode:getScaleX()
    nodeScaleX(self.launcherNode, scaleX, dir)
    nodeScaleX(self.moveEffectNode, scaleX, dir)
end

function PlayerFighter:show()
    self.super.show(self)
    if self.launcherNode then
        self.launcherNode:show()
    end
    if self.moveEffectNode then
        self.moveEffectNode:show()
    end
end

function PlayerFighter:hide()
    self.super.hide(self)
    if self.launcherNode then
        self.launcherNode:hide()
    end
    if self.moveEffectNode then
        self.moveEffectNode:hide()
    end
end

function PlayerFighter:pause()
    if self.launcherNode then
        self.launcherNode:stop()
    end
    if self.moveEffectNode then
        self.moveEffectNode:stop()
    end
    self.super.pause(self)
end

function PlayerFighter:resume()
    if self.launcherNode then
        self.launcherNode:resume()
    end
    if self.moveEffectNode then
        self.moveEffectNode:resume()
    end
    self.super.resume(self)
end

function PlayerFighter:playForward()
    self:playAni(eFlightAnimation.FORWARD, true)
end

function PlayerFighter:playBackward()
    self:playAni(eFlightAnimation.BACKWARD, true)
end

function PlayerFighter:playForwardToBackward(callback)
    self:playAni(eFlightAnimation.FORWARD2BACKWARD, false, callback)
end

function PlayerFighter:playBackwardToForward(callback)
    self:playAni(eFlightAnimation.BACKWARD2FORWARD, false, callback)
end

function PlayerFighter:playDead(name, callback)
    self.super.playDead(self, name, callback)
    if self.launcherNode then
        self.launcherNode:hide()
    end
    if self.moveEffectNode then
        self.moveEffectNode:hide()
    end
    self:playAni(name or eFlightAnimation.DIE, false, callback)
end

function PlayerFighter:playEmit(barrage, config)
    if self.launcherNode then
        if self.launchActionName then
            self.launcherNode:addMEListener(TFARMATURE_COMPLETE, function(node)
                node:removeMEListener(TFARMATURE_COMPLETE)
                if self.normalActionName then
                    self.launcherNode:play(self.normalActionName, 1)
                else
                    self.launcherNode:playByIndex(0, 1)
                end
            end)
            self.launcherNode:play(self.launchActionName, 0)
            self.launcherEventsIndex = {}
        end
    else
        if self.launchActionName then
            self:playAni(self.launchActionName, false, function()
                self:playByIndex(0, 1)
            end)
        end
    end
end

function PlayerFighter:playSkill(callback)
    self:playAni(eFlightAnimation.SKILL, false, callback)
end

function PlayerFighter:playWin(callback)
    --self:playAni(eFlightAnimation.WIN, false, callback)
    if callback then
        callback()
    end
end

function PlayerFighter:addEffect(effectNode, zOrder)
    zOrder = zOrder or 1
    effectNode:setCameraMask(self:getCameraMask())
    self:addChild(effectNode, zOrder)
end


function PlayerFighter:onLauncherArmatureEvent(...)
    if self.captain and self.captain.data then
        local event                          = BattleUtils.translateArmtureEventData(...)
        self.launcherEventsIndex[event.name] = (self.launcherEventsIndex[event.name] or 0) + 1
        event.pramN                          = self.launcherEventsIndex[event.name]
        local model = self.captain.data.launchEffect.effectName
        self.captain:onArmatureEvent(event, model, self.launchActionName)
    end
end

return PlayerFighter