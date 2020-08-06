
local UserDefault = CCUserDefault:sharedUserDefault()
local BaseDataMgr = import(".BaseDataMgr")
local GlobalVarDataMgr = class("GlobalVarDataMgr", BaseDataMgr)

local keyIndex = 1
local typeIndex = 2
local defaultsIndex = 3
local cacheIndex = 4

local function unMarshal(type_, value)
    if type_ == "boolean" then
        local v = tonumber(value)
        if v then
            return v == 1
        end
        return tobool(value)
    elseif type_ == "number" then
        return tonumber(value)
    end
    return tostring(value)
end

local function marshal(type_, value)
    if type_ == "boolean" then
        return value and "1" or "0"
    end
    return tostring(value)
end

function GlobalVarDataMgr:init()
    self.var_ = {}
    self.cacheKeys_ = {}
end

function GlobalVarDataMgr:reset()
    self.var_ = {}
end

function GlobalVarDataMgr:onEnterMain()
    self.var_[GV_MONTH_CARD_TIP] = true
end

function GlobalVarDataMgr:setValue(key, value)
    local config = key

    local key = config[keyIndex]
    local type_ = config[typeIndex]
    local defaultsValue = config[defaultsIndex]
    local isCache = config[cacheIndex]

    if type_ ~= type(value) then
        local log = string.format("全局变量(%s)设置值类型与预期值类型不匹配:%s", key, debug.traceback("", 2))
        Box(log)
        return
    end

    value = unMarshal(type_, value)
    self.var_[key] = value
    if isCache then
        UserDefault:setStringForKey(key, marshal(type_, value))
        UserDefault:flush()
    end
end

function GlobalVarDataMgr:getValue(key)
    local config = key
    if not config then return end

    local key = config[keyIndex]
    local type_ = config[typeIndex]
    local defaultsValue = config[defaultsIndex]
    local isCache = config[cacheIndex]

    local value = self.var_[key]
    if value == nil then
        if isCache then
            local v = UserDefault:getStringForKey(config[keyIndex])
            if #v > 0 then
                value = v
            else
                value = defaultsValue
            end
        end
    end
    value = unMarshal(type_, value)

    return value
end

return GlobalVarDataMgr:new()
