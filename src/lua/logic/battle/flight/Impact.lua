local enum        = import("..enum")
local ActionMgr   = import("..ActionMgr")
local levelParse  = import("..LevelParse")
local SpellBase   = import(".SpellBase")

local eEvent      = enum.eEvent

---@class Impact : Spell
local Impact = class("Impact", SpellBase)

function Impact:ctor(captain, data)
    self.super.ctor(self, captain, data)
end

function Impact:init()
    self.deltaSpeed      = self.data.range / 21
    self.super.init(self)
end

function Impact:reset()
    self.super.reset(self)
    self.action         = ActionMgr.createMoveAction()
end

function Impact:destroy()
    self.super.destroy(self)
    self.deltaSpeed      = nil
    self.action          = nil
end

function Impact:stop()
    if self.data.isEnd then
        self.cancel = true
    end
    self:reset()
end

---@protected
function Impact:doCast()
    if self.captain and self.captain.fighter then
        self.captain.fighter:playAni(self.data.actionName, false, function()
            self.action:stop()
            if "function" == type(self.completeHandle) and not self.cancel then
                EventMgr:dispatchEvent(eEvent.EVENT_CHANGE_MAP_SPEED, 0)
                self.completeHandle()
            end
            self:reset()
        end)
        local pos = self.captain:getPosition()
        if not levelParse:canMove(pos.x + self.data.range, pos.y) then
            EventMgr:dispatchEvent(eEvent.EVENT_CHANGE_MAP_SPEED, self.deltaSpeed)
        end
    end
end

function Impact:onEvent(event)
    if self.action then
        self.action:start(self.captain, 0.35, ccp(self.data.range, 0))
    end
end

function Impact:tryCast(completeHandle)
    if self.super.tryCast(self, completeHandle) then
        self:doCast()
        return self
    end
end

return Impact