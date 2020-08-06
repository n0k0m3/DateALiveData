
local function dump_value_(v)
    if type(v) == "string" then
        v = "\"" .. v .. "\""
    end
    return tostring(v)
end

function dump(value, desciption, nesting)
    if type(nesting) ~= "number" then nesting = 10 end

    local lookupTable = {}
    local result = {}

    local traceback = string.split(debug.traceback("", 2), "\n")
    print("dump from: " .. string.trim(traceback[3]))

    local function dump_(value, desciption, indent, nest, keylen)
        desciption = desciption or "<var>"
        local spc = ""
        if type(keylen) == "number" then
            spc = string.rep(" ", keylen - string.len(dump_value_(desciption)))
        end
        if type(value) ~= "table" then
            result[#result +1 ] = string.format("%s%s%s = %s", indent, dump_value_(desciption), spc, dump_value_(value))
        elseif lookupTable[tostring(value)] then
            result[#result +1 ] = string.format("%s%s%s = *REF*", indent, dump_value_(desciption), spc)
        else
            lookupTable[tostring(value)] = true
            if nest > nesting then
                result[#result +1 ] = string.format("%s%s = *MAX NESTING*", indent, dump_value_(desciption))
            else
                result[#result +1 ] = string.format("%s%s = {", indent, dump_value_(desciption))
                local indent2 = indent.."    "
                local keys = {}
                local keylen = 0
                local values = {}
                for k, v in pairs(value) do
                    keys[#keys + 1] = k
                    local vk = dump_value_(k)
                    local vkl = string.len(vk)
                    if vkl > keylen then keylen = vkl end
                    values[k] = v
                end
                table.sort(keys, function(a, b)
                    if type(a) == "number" and type(b) == "number" then
                        return a < b
                    else
                        return tostring(a) < tostring(b)
                    end
                end)
                for i, k in ipairs(keys) do
                    dump_(values[k], k, indent2, nest + 1, keylen)
                end
                result[#result +1] = string.format("%s}", indent)
            end
        end
    end
    dump_(value, desciption, "- ", 1)

    for i, line in ipairs(result) do
        print(line)
    end
end

function printError(fmt, ...)
    TFLOG2(string.format(fmt, ...))
    TFLOG2(debug.traceback("", 2))
end

function bind(obj, method, ...)
    local arg = {...}
    return function(...)
        local args = {}
        table.insertTo(args, arg)
        table.insertTo(args, {...})
        return method(obj, unpack(args))
    end
end

function bind_reverse(obj, method, ...)
    local arg = {...}
    return function(...)
        local args = {}
        table.insertTo(arg, {...})
        table.insertTo(arg, arg)
        return method(obj, unpack(args))
    end
end

function import(moduleName, currentModuleName)
    local currentModuleNameParts
    local moduleFullName = moduleName
    local offset = 1

    while true do
        if string.byte(moduleName, offset) ~= 46 then -- .
            moduleFullName = string.sub(moduleName, offset)
            if currentModuleNameParts and #currentModuleNameParts > 0 then
                moduleFullName = table.concat(currentModuleNameParts, ".") .. "." .. moduleFullName
            end
            break
        end
        offset = offset + 1

        if not currentModuleNameParts then
            if not currentModuleName then
                local n,v = debug.getlocal(3, 1)
                currentModuleName = v
            end

            currentModuleNameParts = string.split(currentModuleName, ".")
        end
        table.remove(currentModuleNameParts, #currentModuleNameParts)
    end

    return require(moduleFullName)
end

function hex2rgb(hex)
    hex = hex:gsub("#","")
    local r = tonumber("0x"..hex:sub(1,2))
    local g = tonumber("0x"..hex:sub(3,4))
    local b = tonumber("0x"..hex:sub(5,6))
    return ccc3(r, g, b)
end

-- from "https://forums.coronalabs.com/topic/42019-split-utf-8-string-word-with-foreign-characters-to-letters/"
function string.UTF8ToCharArray(str)
    local charArray = {}
    local iStart = 0
    local strLen = str:len()

    local function bit(b)
        return 2 ^ (b - 1)
    end

    local function hasbit(w, b)
        return w % (b + b) >= b
    end

    local checkMultiByte = function(i)
        if (iStart ~= 0) then
            charArray[#charArray + 1] = str:sub(iStart, i - 1)
            iStart = 0
        end
    end

    for i = 1, strLen do
        local b = str:byte(i)
        local multiStart = hasbit(b, bit(7)) and hasbit(b, bit(8))
        local multiTrail = not hasbit(b, bit(7)) and hasbit(b, bit(8))

        if (multiStart) then
            checkMultiByte(i)
            iStart = i

        elseif (not multiTrail) then
            checkMultiByte(i)
            charArray[#charArray + 1] = str:sub(i, i)
        end
    end

    -- process if last character is multi-byte
    checkMultiByte(strLen + 1)

    return charArray
end


function clone(object)
    local lookup_table = {}
    local function _copy(object)
        local istabdatamgr = false
        if type(object) ~= "table" then
            return object
        else
            local mt = getmetatable(object)
            if mt then
                istabdatamgr = mt.__istabdatamgr
                if istabdatamgr then
                    object = mt.__getrawdata()
                end
            end
        end

        if lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for key, value in pairs(object) do
            new_table[_copy(key)] = _copy(value)
        end
        if istabdatamgr then
            return new_table
        else
            return setmetatable(new_table, getmetatable(object))
        end
    end
    return _copy(object)
end

function normalizeBool(value)
    return not (not value)
end

function table.shuffle(tbl)
    local size = #tbl
    for i = size, 1, -1 do
        local rand = math.random(size)
        tbl[i], tbl[rand] = tbl[rand], tbl[i]
    end
    return tbl
end
