
local EventMgr = class("EventMgr")

function EventMgr:ctor()
    self:reset()
end

local function nilCheck(obj, szName)
    if not obj then
        print("EventMgr:[" .. szName .. '] can not be nil')
        if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
            local msg = "LUA addEventListener ERROR: " .. "\n"
            msg = msg .. debug.traceback()
            TFLOGERROR(msg)
        end
        return true
    end
    return false
end

function EventMgr:addEventListener(target, eventName, func, isOnce)
    if  nilCheck(target, 'target') or
        nilCheck(eventName, 'eventName') or
        nilCheck(func, 'func') then
        return
    end
    isOnce = not (not isOnce)

    local event = self.event_
    event[eventName] = event[eventName] or {}
    event[eventName][target] = event[eventName][target] or {}
    local funcs = event[eventName][target]
    for k, v in pairs(funcs) do
        if v.func and v.func == func then
            return
        end
    end

    if self.isDispatchEvent_ then
        local event = {
            target = target,
            eventName = eventName,
            func = func,
            isOnce = isOnce,
        }
        table.insert(self.addEvent_, event)
    else
        funcs[func] = {func = func, isOnce = isOnce}
        if DEBUG then
            funcs[func].debuginfo = debug.traceback()
        end
    end
end

function EventMgr:removeEventListener(target, eventName, func)
    local event = self.event_
    if not event[eventName] then return end

    local funcs = event[eventName][target]
    if not funcs then return end

    for k, v in pairs(funcs) do
        if v.func == func or not func then
            if self.isDispatchEvent_ then
                local event = {
                    target = target,
                    eventName = eventName,
                    func = func,
                }
                table.insert(self.removeEvent_, event)
            else
                funcs[k] = nil
            end
        end
    end

    self:clearEvent()
end

function EventMgr:clearEvent()
    local event = self.event_
    for eventName, targetList in pairs(event) do
        for target, funcs in pairs(targetList) do
            if not next(funcs) then
                targetList[target] = nil
            end
        end
        if not next(targetList) then
            event[eventName] = nil
        end
    end
end

function EventMgr:removeEventListenerByTarget(target)
    local event = self.event_
    for eventName, targetList in pairs(event) do
        if targetList[target] then
            self:removeEventListener(target, eventName)
        end
    end
end

function EventMgr:dispatchEvent(eventName, ...)
    local event = self.event_
    if not event[eventName] then return end
    
    self.isDispatchEvent_ = true
    for target, funcs in pairs(event[eventName]) do
        for _, v in pairs(funcs) do
            if target and target.getDescription then
                --判断是否为C++对象
                if not tolua.isnull(target) and not target.rclosing then
                    v.func(...)
                end
            else
                v.func(...)
            end
            if v.isOnce then
                self:removeEventListener(target, eventName, v.func)
            end
        end
    end
    self.isDispatchEvent_ = false

    -- 在事件派发时添加事件列表
    for i, event in ipairs(self.addEvent_) do
        self:addEventListener(event.target, event.eventName, event.func, event.isOnce)
    end
    self.addEvent_ = {}
    -- 在事件派发时删除事件列表
    for i, event in ipairs(self.removeEvent_) do
        self:removeEventListener(event.target, event.eventName, event.func)
    end
    self.removeEvent_ = {}
end

function EventMgr:dispathGlobalEvent(eventName, ...)
    self:dispatchEvent(self.globalTarget_, eventName, ...)
end

function EventMgr:addGlobalEventListener(eventName, func, isOnce)
    self:addEventListener(self.globalTarget_, eventName, func, isOnce)
end

function EventMgr:removeGlobalEventListener(eventName, func)
    self:removeEventListener(self.globalTarget_, eventName, func)
end

function EventMgr:reset()
    self.event_ = {}
    self.globalTarget_ = {}
    self.removeEvent_ = {}
    self.addEvent_ = {}
    self.isDispatchEvent_ = false
end

local instance = EventMgr:create()
return instance
