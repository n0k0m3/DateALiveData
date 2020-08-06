local DEFAULT_CLAZZ_KEY = "DEFAULT_CLAZZ_KEY"
local DEFAULT_NAME_KEY  = "DEFAULT_NAME_KEY"

local Pool              = {}

---@type ObjectPool
local ObjectPool        = {
    clazz    = DEFAULT_CLAZZ_KEY,
    name     = DEFAULT_NAME_KEY,
    capacity = 16,
    raw      = {
        --[name1]  = {
        --    object1,
        --    object2,
        --    object3,
        --},
        --[name2] = {
        --    object1,
        --    object2,
        --    object3,
        --}
    }
}
ObjectPool.__index      = function(self, key)
    return ObjectPool[key] or (function()
        local t = {}
        rawset(self, key, t)
        return t
    end)()
end

---@param clazz any
---@param capacity number
---@param callerWhenRemove string if call remove|removeAll then object[caller]() end
---@return ObjectPool
function ObjectPool.new(clazz, capacity, callerWhenRemove)
    clazz          = clazz or DEFAULT_CLAZZ_KEY
    local instance = Pool[clazz]
    if not instance then
        instance          = setmetatable({ caller = callerWhenRemove }, ObjectPool)
        instance.capacity = capacity or instance.capacity
        instance.clazz    = clazz or instance.clazz
        Pool[clazz]       = instance
    end
    return instance
end

function ObjectPool.eraseByType(clazz)
    local pool = Pool[clazz]
    if pool then
        pool:removeAll()
    end
end

function ObjectPool.eraseAll()
    for key, pool in pairs(Pool) do
        pool:removeAll()
    end
end

---@param object any
---@param name string
function ObjectPool:push(object, name)
    name          = name or self.name
    local objects = self.raw[name]
    if not objects then
        objects        = {}
        self.raw[name] = objects
    end
    if #objects < self.capacity then
        objects[#objects + 1] = object
        return true
    end
end

function ObjectPool:count(name)
    name = name or self.name
    local objects = self.raw[name]
    if not objects then return 0 end
    return #objects
end

---@param name string
function ObjectPool:pop(name)
    name          = name or self.name
    local objects = self.raw[name]
    local pos     = objects and #objects or 0
    if pos > 0 then
        return table.remove(objects, pos)
    end
    return nil
end

---@param name string
function ObjectPool:remove(name)
    name          = name or self.name
    local objects = self.raw[name]
    if objects then
        local object
        for i = #objects, 1, -1 do
            object = table.remove(objects, i)
            if self.caller and object[self.caller] then
                object[self.caller](object)
            end
        end
    end
end

function ObjectPool:removeAll()
    for name, objects in pairs(self.raw) do
        local object
        for i = #objects, 1, -1 do
            object = table.remove(objects, i)
            if self.caller and object[self.caller] then
                object[self.caller](object)
            end
        end
        self.raw[name] = nil
    end
end

-- default instance
local default = ObjectPool.new()

-- module forwards calls to default instance
local module  = {}
for k in pairs(ObjectPool) do
    if k ~= "__index" then
        if k == "new" or "eraseByType" then
            module[k] = function(...)
                return ObjectPool[k](...)
            end
        else
            module[k] = function(...)
                return default[k](default, ...)
            end
        end
    end
end

return setmetatable(module, { __call = ObjectPool.new })


