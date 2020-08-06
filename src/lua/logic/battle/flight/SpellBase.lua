local BattleUtils = import("..BattleUtils")
local enum        = import("..enum")

local eEvent      = enum.eEvent

---@class Spell
local Spell = class("Spell")

function Spell:ctor(captain, data)
    ---@type PlayerCaptain
    self.captain = captain
    self.data    = data
    self:init()
end

function Spell:init()
    self:reset()
    self.cd = 0 -- 开场无cd
end

function Spell:reset()
    self.completeHandle = nil
    self.casting        = nil
    self.eventsIndex    = {}
    self.soundMutex     = {}
    self.cd             = self.data.bulletCD
end

function Spell:destroy()
    self.cancel         = nil
    self.captain        = nil
    self.data           = nil
    self.completeHandle = nil
    self.casting        = nil
    self.cd             = nil
end

function Spell:getIcon()
    return self.data.keyIcon or ""
end

function Spell:getAngerCost()
    return self.data.angerCost or 0
end

function Spell:canChangeState()
    return false
end

function Spell:stop()
end

---@protected
function Spell:doCast()
end

function Spell:onEvent(event)
end

function Spell:canCast()
    return self.cd <= 0 and self.data.angerCost <= self.captain:getAnger() and not self.casting
end

function Spell:tryCast(completeHandle)
    if not self:canCast() then
        return
    end
    self.completeHandle = completeHandle
    self.casting     = true
    return self
end

function Spell:update(dt)
    self.cd = self.cd - dt
    if self.cd <= 0 then
        self.cd = 0
    end
    EventMgr:dispatchEvent(eEvent.EVENT_VKSTATE_CHANGE, { percent = self.cd * 100 / self.data.bulletCD, cd = math.ceil(self.cd*0.001),  keyCode = self.data.keyCode }, self.captain)
end

function Spell:getFixAnimation()
    if self.data.actionName and #self.data.actionName ~= 0 then
        return self.data.actionName
    end
    return self.data.effectName
end

function Spell:onArmatureEvent(...)
    if self.casting and self.captain then
        local event                  = BattleUtils.translateArmtureEventData(...)
        self.eventsIndex[event.name] = (self.eventsIndex[event.name] or 0) + 1
        event.pramN                  = self.eventsIndex[event.name]
        if event.name == enum.eArmtureEvent.MUSIC then
            self:doMusicEvent(event.pramN)
        end
    end
end

function Spell:doMusicEvent(pramN)
    local eventName  = enum.eArmtureEvent.MUSIC .. pramN
    local resource   = self.data.effectName
    local action     = self:getFixAnimation()
    local musicData = BattleDataMgr:getEffectMusicData(resource, action, eventName)
    if musicData then
        for _, data in ipairs(musicData) do
            BattleUtils.playEffect(data.resource, false, data.volume * 0.01)
            --if handle then
            --    TFAudio.setFinishCallback(handle)
            --end
        end
    end
end

return Spell