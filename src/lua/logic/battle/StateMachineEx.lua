
local StateMachine = class("StateMachine")

StateMachine.WILDCARD = "WILDCARD"
function StateMachine:ctor()
end

function StateMachine:setupState(cfg)
    assert(type(cfg) == "table", "StateMachine:ctor() - invalid config")
    self.initial_    = cfg.initial
    self.events_     = cfg.events or {}
    self.callbacks_  = cfg.callbacks or {}
    self.map_        = {}
    self.current_    = nil
    for _, event in ipairs(self.events_) do
        self:addEvent_(event)
    end
    if self.initial_ then
        self:setState(self.initial_)
    end
end


function StateMachine:addEvent_(event)
    local from = {}
    if type(event.from) == "table" then
        for _, name in ipairs(event.from) do
            from[name] = true
        end
    elseif event.from then
        from[event.from] = true
    else
        from[StateMachine.WILDCARD] = true  --所有状态都可以到达
    end
    self.map_[event.to] = self.map_[event.to] or {}
    local map = self.map_[event.to]
    for state, _ in pairs(from) do
        map[state] = event.to
    end
end


function StateMachine:canToState(state)
    return true
end

function StateMachine:setState(state,...)
    local from = self.current_
    local to   = state
    local args = {...}
    local event = {
        from = from,
        to   = to,
        args = args,
    }
    self:beforeEvent_(event)
    if from == to then
        self:afterEvent_(event)
        return StateMachine.NOTRANSITION
    end

    self.current_ = to
    self:enterState_(event)
    self:changeState_(event)
    self:afterEvent_(event)
    return StateMachine.SUCCEEDED
end

function StateMachine:getState()
    return self.current_
end

function StateMachine:isState(state)
    return self.current_ == state
end




function StateMachine:doEvent(state,...)
    self:setState(state,...)
end


function StateMachine:canDoEvent()
    return true
end


local function doCallback_(callback, event)
    if callback then return callback(event) end
end

function StateMachine:changeState_(event)
    return doCallback_(self.callbacks_["onchangestate"], event)
end


function StateMachine:beforeEvent_(event)
     return doCallback_(self.callbacks_["onbeforeevent"], event)
end

function StateMachine:afterEvent_(event)
    return doCallback_(self.callbacks_["onbafterevent"], event)
end

function StateMachine:leaveState_(event, transition)
    return doCallback_(self.callbacks_["onleaveevent"], event)
end

function StateMachine:enterState_(event)
    return doCallback_(self.callbacks_["onenterevent"], event)

end

function StateMachine:onError_(event, error, message)
    -- print("%s [StateMachine] ERROR: error %s, event %s, from %s to %s", tostring(self.target_), tostring(error), event.name, event.from, event.to)
    printError("[StateMachine] "..message)
end

local exportMethods = {
    "setupState",
    "getState",
    "setState",
    "isState",
    "canToState",
    "canDoEvent",
    "doEventForce",
    "doEvent",
}

function StateMachine:instace()
    local com = StateMachine:create()
    local obj = {}
    for _, key in ipairs(exportMethods) do
        local m = com[key]
        obj[key] = function(__, ...)
            return m(com, ...)
        end
    end
    return obj
end

return StateMachine
