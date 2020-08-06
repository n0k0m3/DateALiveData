local BaseDataMgr = import(".BaseDataMgr")
local TabDataMgr = class("TabDataMgr", BaseDataMgr)


local function readOnly(t)
	for x, y in pairs(t) do
		if type(x) == "table" then
			if type(y) == "table" then
				t[readOnly(x)] = readOnly[y]
			else
				t[readOnly(x)] = y
			end
		elseif type(y) == "table" then
			t[x] = readOnly(y)
		end
	end

	local proxy = {}
	local mt = {
		-- hide the actual table being accessed
		-- __metatable = "read only table",
		__index = function(tab, k) return t[k] end,
        __ipairs = function() return ipairs(t) end,
		__pairs = function() return pairs(t) end,
		__newindex = function (t,k,v)
			error("attempt to update a read-only table", 2)
		end,
        __istabdatamgr = true,
        __getrawdata = function() return t end,
    }
	setmetatable(proxy, mt)
	return proxy
end

function TabDataMgr:init()
    self.tabData_ = {}
    self.language = GAME_LANGUAGE_VAR
end

function TabDataMgr:lazyInit(name)
    if self.tabData_[name] then return end
    local status, data = xpcall(
        function()
            local data = require("lua.table." .. name)
            -- self.tabData_[name] = readOnly(data)
            self.tabData_[name] = data
        end,
        function(msg)
            if not string.find(msg, string.format("'%s' not found:", name)) then
                printError("load table error: ", msg)
            end
        end
    )
end

function TabDataMgr:getData(name, id)
    if not name then return self.tabData_ end
    --多语言表支持
    local language = self.language
    if language~= "" then
        if not self.LanguageTable  then
            local tabelStringName = ""
            
            local config = require("lua.table.EnglishTable")
            tabelStringName = "table"..language
            self.LanguageTable = clone(config)
            local changeTable = {}
            for k,v in pairs(self.LanguageTable) do
                changeTable[v[tabelStringName]] = v.id
            end
            self.LanguageTable = changeTable
        end
        if self.LanguageTable[name..language] then
            name = name..language
        end
    end

    if not self.tabNameFitter_ then
        local config = require("lua.table.DiscreteData")[51504]
        self.tabNameFitter_ = clone(config.data)
    end

    if self.tabNameFitter_ and self.tabNameFitter_[name] then
        local _fitter = self.tabNameFitter_[name]
        for k,v in pairs(_fitter) do
            if id and id >= v.min and id <= v.max then
                name = k
                break;
            end
        end
    end

    self:lazyInit(name)
    if id then
        if not self.tabData_[name] then
            local errMsg = string.format("TabDataMgr:getData table=%s id=%s table is nil!",tostring(name),tostring(id))
            Bugly:ReportLuaException(errMsg)
            Box(errMsg..tostring(debug.traceback()))
            return
        elseif not self.tabData_[name][id] then
            local errMsg = string.format("TabDataMgr:getData table=%s id=%s data is nil!",tostring(name),tostring(id))
            Bugly:ReportLuaException(errMsg)
            if id > 0 then
                Box(errMsg..tostring(debug.traceback()))
            end
            return
        end
        return self.tabData_[name][id]  -- 这里不能简单暴力的 return {}, 调用者需要做相应判断
    else
        return self.tabData_[name] or {}
    end
end

function TabDataMgr:updateString(key, value)
    if self.tabData_["String"] and tonumber(key) and value then
        self.tabData_["String"][tonumber(key)] = {id = tonumber(key), text = tostring(value)}
    end
end

function TabDataMgr:reset()
    self.tabData_ = {}
end

return TabDataMgr:new()
