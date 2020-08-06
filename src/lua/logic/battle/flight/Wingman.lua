local BattleUtils  = import("..BattleUtils")
local BattleConfig = import("..BattleConfig")
local ResLoader    = import("..ResLoader")
local enum         = import("..enum")

---@class Wingman
local Wingman      = class("Wingman", function()
    local node = CCNode:create()
    return node
end)

function Wingman:ctor(owner, parent)
    self.owner = owner
    local data = owner.captain.data.wingman
    local model  = data.model
    local scale  = data.modelSize or BattleConfig.FLIGHT_MODEL_SCALE

    self.skeletonNode = ResLoader.createRole(model, scale)

    self.skeletonNode:setScheduleUpdateWhenEnter(false)

    self:addChild(self.skeletonNode)
    self.skeletonNode:addMEListener(TFARMATURE_EVENT, handler(self.onArmatureEvent, self))
    if data.launchEffect and data.launchEffect.normalActionName and data.launchEffect.normalActionName ~= "" then
        self.normalActionName = data.launchEffect.normalActionName
    end
    if self.normalActionName then
        self.skeletonNode:play(self.normalActionName, 1)
    else
        self.skeletonNode:playByIndex(0, 1)
    end

    if data.launchEffect and data.launchEffect.launchActionName and data.launchEffect.launchActionName ~= "" then
        self.launchActionName = data.launchEffect.launchActionName
    end
end

function Wingman:addTo(panel)
    panel:addObject(self, 2)
end

function Wingman:setFlipX(flipX)
    local scaleX = self.skeletonNode:getScaleX()
    if flipX then
        scaleX= -math.abs(scaleX)
    else
        scaleX= math.abs(scaleX)
    end
    self.skeletonNode:setScaleX(scaleX)
end

function Wingman:setDir(dir)
    if dir == enum.eDir.LEFT then
        self:setFlipX(true)
    elseif dir == enum.eDir.RIGHT then
        self:setFlipX(false)
    end
end

function Wingman:destroy()
    if self.skeletonNode then
        self.skeletonNode:removeMEListener(TFARMATURE_EVENT)
        self.skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
        self.skeletonNode:removeFromParent()
        self.skeletonNode = nil
    end
    self:removeFromParent(true)
end

function Wingman:show()
    local show = rawget(CCNode, "show")
    show(self)
    if self.skeletonNode then
        self.skeletonNode:show()
    end
end

function Wingman:hide()
    local hide = rawget(CCNode, "hide")
    hide(self)
    if self.skeletonNode then
        self.skeletonNode:hide()
    end
end

function Wingman:offStage()
    self:hide()
    self:pause()
end

function Wingman:pause()
    if self.skeletonNode then
        self.skeletonNode:stop()
    end
end

function Wingman:resume()
    if self.skeletonNode then
        self.skeletonNode:resume()
    end
end

function Wingman:update(dt)
    if self.skeletonNode then
        self.skeletonNode:update(dt * 0.001)
    end
end

function Wingman:playEmit(barrage, config, state, bullets)
    if self.launchActionName then
        self.skeletonNode:addMEListener(TFARMATURE_COMPLETE, function(node)
            node:removeMEListener(TFARMATURE_COMPLETE)
            if self.normalActionName then
                self.skeletonNode:play(self.normalActionName, 1)
            else
                self.skeletonNode:playByIndex(0, 1)
            end
        end)
        self.skeletonNode:play(self.launchActionName, 0)
    end
end

function Wingman:onArmatureEvent(...)
    if self.wingman then
        local event                  = BattleUtils.translateArmtureEventData(...)
        self.eventsIndex[event.name] = self.eventsIndex[event.name] or 0
        self.eventsIndex[event.name] = self.eventsIndex[event.name] + 1
        event.pramN                  = self.eventsIndex[event.name]
        self.wingman:onArmatureEvent(event)
    end
end

return Wingman