
local insert = table.insert
local format = string.format
local tostring = tostring
local type = type

--[[--
    将对象序列化
]]
function serialize(t)
    local mark={}
    local assign={}

    local tb_cache = {}
    local function tb(len)
        if tb_cache[len] then 
            return tb_cache[len]
        end
        local ret = ''
        while len > 1 do
            ret = ret .. '       '
            len = len - 1
        end
        if len >= 1 then
            ret = ret .. '├┄┄'
        end
        tb_cache[len] = ret
        return ret
    end

    local function table2str(t, parent, deep)
        if type(t) == "table" and t.__tostring then 
            return tostring(t)
        end

        deep = deep or 0
        mark[t] = parent
        local ret = {}
        table.foreach(t, function(f, v)
            local k = type(f)=="number" and "["..f.."]" or tostring(f)
            local t = type(v)
            if t == "userdata" or t == "function" or t == "thread" or t == "proto" or t == "upval" then
                insert(ret, format("%s=%q", k, tostring(v)))
            elseif t == "table" then
                local dotkey = parent..(type(f)=="number" and k or "."..k)
                if mark[v] then
                    insert(assign, dotkey.."="..mark[v])
                else
                    insert(ret, format("%s=%s", k, table2str(v, dotkey, deep + 1)))
                end
            elseif t == "string" then
                insert(ret, format("%s=%q", k, v))
            elseif t == "number" then
                if v == math.huge then
                    insert(ret, format("%s=%s", k, "math.huge"))
                elseif v == -math.huge then
                    insert(ret, format("%s=%s", k, "-math.huge"))
                else
                    insert(ret, format("%s=%s", k, tostring(v)))
                end
            else
                insert(ret, format("%s=%s", k, tostring(v)))
            end
        end)
        return "{\n" .. tb(deep + 2) .. table.concat(ret,",\n" .. tb(deep + 2)) .. '\n' .. tb(deep+1) .."}"
    end

    if type(t) == "table" then
        if t.__tostring then 
            return tostring(t)
        end
        local str = format("%s%s",  table2str(t,"_"), table.concat(assign," "))
        return "\n<<table>>" .. str
    else
        return tostring(t)
    end
end

--[[--
    根据指定类型打印日志, 有效日志将会保存在输出文件夹的log目录中
    @param kType: 日志类型:TFLOG_ERROR(错误日志), TFLOG_INFO(记录日志), TFLOG_WARNING(警告日志)
    @param fmt: 格式控制
    @param ...: 输出数据
    @return nil
]]
function TFLOG(kType, fmt, ...)
    local str = format(fmt, ...)
    if kType == TFLOG_ERROR then
        TFLOGERROR(str)
    elseif kType == TFLOG_INFO then 
        TFLOGINFO(str)
    elseif kType == TFLOG_WARNING then 
        TFLOGWARNING(str)
    else
        print(str)
    end
end


function TFLOG2(szMsg, kType)
    kType = kType or TFLOG_INFO
    if kType == TFLOG_ERROR then
        TFLOGERROR(szMsg)
    elseif kType == TFLOG_INFO then 
        TFLOGINFO(szMsg)
    elseif kType == TFLOG_WARNING then 
        TFLOGWARNING(szMsg)
    end
end

--[[
    * useful for test
    * not test in real machine
    * by: baiyun
]]
function import(moduleName, currentModuleName)
    local currentModuleNameParts
    local moduleFullName = moduleName
    local offset = 1

    if not currentModuleNameParts then
        if not currentModuleName then
            local source = debug.getinfo(2, 'lS').source
            currentModuleName = source
            currentModuleName = currentModuleName['1:-5']
            currentModuleName = string.gsub(currentModuleName, '/', '.')
        end
        currentModuleNameParts = string.split(currentModuleName, ".")
    end
    while true do
        if string.byte(moduleName, offset) ~= 46 then -- .
            moduleFullName = string.sub(moduleName, offset)
            if currentModuleNameParts and #currentModuleNameParts > 0 then
                moduleFullName = table.concat(currentModuleNameParts, ".") .. "." .. moduleFullName
            end
            break
        end
        offset = offset + 1
        table.remove(currentModuleNameParts, #currentModuleNameParts)
    end
    return require(moduleFullName)
end

function handler(func, self)
    return function(...)  
        if not func then return end
        return func(self, ...) 
    end
end

function tonum(v, base, def)
    return tonumber(v, base) or (def or 0)
end

function toint(val)
	if val > 0 then 
		return math.floor(val)
	end
	return math.ceil(val)
end

function tobool(v)
    return (v ~= nil and v ~= false)
end

function totable(v)
    if type(v) ~= "table" then v = {} end
    return v
end

function isset(arr, key)
    local t = type(arr)
    return (t == "table" or t == "userdata") and arr[key] ~= nil
end

require2 = function(path)
    local oldPath = path
    path = path:gsub('%.', '/')
    path = path .. '.lua'
    local content = io.readfile(path)

    content = string.gsub(content, 'switch%s*%(([%w_]+)%)%s*%{(.-)%}', function(caseWord, content)
        local str = ''
        local first = true
        string.gsub(content, [[case%s*([%w_'"]+)%s*:(.-)break]], function(key, val)
            if key ~= 'default' then 
                if first then 
                    str = str .. format("if %s == %s then\n\t%s\n", caseWord, key, val)
                else 
                    str = str .. format("elseif %s == %s then\n\t%s\n", caseWord, key, val)
                end
            else 
                if first then 
                    str = str .. format("if true then\n\t%s\n", val)
                else 
                    str = str .. format("else\n\t%s\n", val)
                end
            end
            first = false
            return ''
        end)
        str = str .. 'end\n'

        return str
    end)
    local ret, err = loadstring(content)
    if ret then
        ret, val = xpcall(ret, __G__TRACKBACK__)
        if ret then 
            package.loaded[path] = val
            return val
        end
        return ret
    else 
        err = format("\nlua: erroe loading module '%s' from file '%s':\n", oldPath, path) .. err
        error(err)
        return false
    end
end

--计算图片缓存的使用情况和占用内存情况
function calculateTextureCache()
    local keys = me.TextureCache:textureKeys()
    local nLen = keys:size()

    local nUsed = 0
    local nMem = 0
    local nUsedMem = 0
    local newVersion = false
    if Texture2D.getBitsPerPixelForFormat then 
        newVersion = true
    end 
    for i = 0, nLen - 1 do 
        local name = keys:at(i)
        local tex = me.TextureCache:textureForKey(name:getCString())
        local bpp = newVersion and tex:getBitsPerPixelForFormat() or tex:bitsPerPixelForFormat()
        local bytes = tex:getPixelsWide() * tex:getPixelsHigh() * bpp / 8 / 1024
        nMem = nMem + bytes
        if tex:retainCount() > 1 then 
            nUsed = nUsed + 1 
            nUsedMem = nUsedMem + bytes
        end
    end

    return nUsed,nLen,nUsedMem,nMem;
end

--[[
Example: cclog("error:XXXXXXX")    此句将在输出调试器中显示红色字体
         cclog("WARNING:XXXXXX")   如果调试器中勾选了显示警告，这里将会在调试器上显示蓝色字体，否则不显示
]]


function cclog(...) 
     if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
        print(...)
     end
end

local function utf8CharSize(char)
	if not char then
	    return 0
	elseif char > 240 then
	    return 4
	elseif char > 225 then
	    return 3
	elseif char > 192 then
	    return 2
	else
	    return 1
	end
end
    
--分离utf8字符串
function getStringTable(str)
    if type(str) ~= "string" then
        error("bad argument #1 to 'utf8len' (string expected, got ".. type(str).. ")")
    end

    local pos = 1
    local len = str:len()
    local strTab = {}
    while pos <= len do
        local char = string.byte(str, pos)
        local delta = utf8CharSize(char)
        table.insert( strTab, str:sub(pos, pos + delta - 1) )
        pos = pos + delta 
    end
    return strTab
end

local function CallError(msg)
    if not msg then return end

    print("----------------------------------------\n", msg, "\n", debug.traceback())

    local msg = "[Call on SafeHandle] LUA ERROR: \n" .. tostring(msg) .. "\n"
    msg = msg .. debug.traceback()

    if ErrorCodeManager then
        ErrorCodeManager:reportErrorMsg(msg)
    end

    if VERSION_DEBUG == true then
        TFLOGERROR(msg)
    else
        -- if Bugly then 
        --     Bugly:ReportLuaException(msg)
        -- end
        if Crashlytics then
            Crashlytics:reportLuaException(msg)
        end
    end
end

function SafeHandle(func)
    local call = function(params)
        if func then 
            local ok, err = pcall(func, unpack(params))
            if not ok then 
                local debugInfo = debug.getinfo(func)
                if debugInfo then
                    local source = ""
                    local linedefined = debugInfo.linedefined or 0
                    if debugInfo.source then
                        local start = string.find(debugInfo.source, "/")
                        if start then
                            source = string.sub(debugInfo.source, start,string.len(debugInfo.source))
                        end
                    end
                    err = string.format("Line:[%s] File:[%s] \n %s",tostring(linedefined),source,err)
                end
                CallError(err)
                return false
            else
                return true
            end 
        end
        return true
    end
    return call
end

function SafeAudioExchangePlay()
    if AudioExchangePlay == nil then
        AudioExchangePlay = require("lua.public.AudioExchangePlay")
    end
    return AudioExchangePlay
end