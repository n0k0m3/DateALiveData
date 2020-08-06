--[[--
	字符串操作

	--By: yun.bo
	--2013/8/8
]]
local string = string
string.Empty = ""
local _byte = string.byte
local _char = string.char
local _substr = string.sub
local _gsub = string.gsub
local _upper = string.upper

local table = table
local _insert = table.insert
local _concat = table.concat

local type = type 
local error = error
local tonumber = tonumber
local tostring = tostring
local debug = debug
local pairs = pairs 
local ipairs = ipairs
local me = me

local StringUtils = {}

local mt = getmetatable('')
local nCharCode = 0
local _index = mt.__index

local idx = {}
local i, len, beg = 0, 0, 0

mt.__index = function(str, ...)
	local k = ...
	if 'number' == type(k) then
		return _index.sub(str, k, k)
	elseif 'string' == type(k) then
		if string[k] then
			return string[k]
		end
		i, len, beg = 1, #k, 0
		idx[1], idx[2], idx[3] = nil, nil, nil

		while i <= len do
			if k[i] == ':' then
				local num = tonumber(_substr(k, beg, i - 1))
				idx[#idx + 1] = num and num or false
				beg = i + 1
			else
				nCharCode = _byte(k, i) 
				if (nCharCode < 48 or nCharCode > 57) and nCharCode ~= 45 then
					error("can not index a string value: " .. str .. '[' .. k .. ']' .. debug.traceback())
				end
			end
			i = i + 1
		end
		idx[#idx + 1] = tonumber(_substr(k, beg))
		idx[1] = idx[1] or 1
		idx[2] = idx[2] or #str
		idx[3] = idx[3] or 1
		return _substr(str, idx[1], idx[2])
	elseif 'table' == type(k) then
		k[1] = k[1] or 1
		k[2] = k[2] or #str
		k[3] = k[3] or 1
		return _substr(str, k[1], k[2])
	else
		return _index[k]
	end
end

mt.__mul = function (str, nRep) -- '*'
	if type(nRep) == 'number' then
		local ret = ''
		while nRep > 0 do
			ret = ret .. str
			nRep = nRep - 1
		end
		return ret
	end
	return str .. nRep
end

mt.__sub = function (stra, strb) -- '-'
	if type(stra) == 'string' then
		strb = tostring(strb)
		return _gsub(stra, strb, "")
	end
	return stra
end


function string.comp(a, b)
	local ia = {}
	for i = 1, #a do 
		table.insert(ia, string.byte(a, i))
	end
	local ib = {}
	for i = 1, #b do 
		table.insert(ib, string.byte(b, i))
	end
	local i = 1
	while i <= #ia and i <= #ib do 
		if ia[i] ~= ib[i] then 
			return ia[i] < ib[i]
		else 	
			i = i + 1
		end
	end
	return #ia < #ib
end

--[[--

Convert special characters to HTML entities.

The translations performed are:

-   '&' (ampersand) becomes '&amp;'
-   '"' (double quote) becomes '&quot;'
-   "'" (single quote) becomes '&#039;'
-   '<' (less than) becomes '&lt;'
-   '>' (greater than) becomes '&gt;'

@param string input
@return string

]]
function string.htmlspecialchars(input)
    input = input or ""

    for k, v in pairs(string._htmlspecialchars_set) do
        input = _gsub(input, k, v)
    end
    return input
end
string._htmlspecialchars_set = {}
string._htmlspecialchars_set["&"] = "&amp;"
string._htmlspecialchars_set["\""] = "&quot;"
string._htmlspecialchars_set["'"] = "&#039;"
string._htmlspecialchars_set["<"] = "&lt;"
string._htmlspecialchars_set[">"] = "&gt;"

--[[--

Inserts HTML line breaks before all newlines in a string.

Returns string with '<br />' inserted before all newlines (\n).

@param string input
@return string

]]
function string.nl2br(input)
    return _gsub(input, "\n", "<br />")
end

--[[--

Returns a HTML entities formatted version of string.

@param string input
@return string

]]
function string.text2html(input)
    input = _gsub(input, "\t", "    ")
    input = string.htmlspecialchars(input)
    input = _gsub(input, " ", "&nbsp;")
    input = string.nl2br(input)
    return input
end

--[[--

Split a string by string.

@param string str
@param string delimiter
@return table

]]
function string.split(str, delimiter, plain)
    if not str then return {} end
    
    if (delimiter=='') then return false end
	if plain == nil then plain = true end
    local pos, arr = 0, {}
    -- for each divider found
    for st,sp in function() return string.find(str, delimiter, pos, plain) end do
        _insert(arr, _substr(str, pos, st - 1))
        pos = sp + 1
    end
    _insert(arr, _substr(str, pos))
    return arr
end

--[[--

Strip whitespace (or other characters) from the beginning of a string.

@param string str
@return string

]]
function string.ltrim(str)
    return _gsub(str, "^[ \t\n\r]+", "")
end

--[[--

Strip whitespace (or other characters) from the end of a string.

@param string str
@return string

]]
function string.rtrim(str)
    return _gsub(str, "[ \t\n\r]+$", "")
end

--[[--

Strip whitespace (or other characters) from the beginning and end of a string.

@param string str
@return string

]]
function string.trim(str)
    str = _gsub(str, "^[ \t\n\r]+", "")
    return _gsub(str, "[ \t\n\r]+$", "")
end

--[[--

Make a string's first character uppercase.

@param string str
@return string

]]
function string.ucfirst(str)
    return _upper(_substr(str, 1, 1)) .. _substr(str, 2)
end

--[[--

@param string str
@return string

]]
function string.urlencodeChar(char)
    return "%" .. string.format("%02X", _byte(c))
end

--[[--

URL-encodes string.

@param string str
@return string

]]
function string.urlencode(str)
    -- convert line endings
    str = _gsub(tostring(str), "\n", "\r\n")
    -- escape all characters but alphanumeric, '.' and '-'
    str = _gsub(str, "([^%w%.%- ])", string.urlencodeChar)
    -- convert spaces to "+" symbols
    return _gsub(str, " ", "+")
end

--[[--

Get UTF8 string length.

@param string str
@return int

]]
function string.utf8len(str)
    local len  = #str
    local left = len
    local cnt  = 0
    local arr  = {0, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc}
    while left ~= 0 do
        local tmp = _byte(str, -left)
        local i   = #arr
        while arr[i] do
            if tmp >= arr[i] then
                left = left - i
                break
            end
            i = i - 1
        end
        cnt = cnt + 1
    end
    return cnt
end

--[[--

Get Special string length.

@param string str
@return int

]]
function string.len2(str)
    local len  = #str
    local left = len
    local cnt  = 0
    local arr  = {0, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc}
    while left ~= 0 do
        local tmp = _byte(str, -left)
        local i   = #arr
        while arr[i] do
            if tmp >= arr[i] then
                left = left - i
                break
            end
            i = i - 1
        end
        cnt = cnt + 1
        if tmp > 0x7F then cnt = cnt + 1 end 
    end
    return cnt
end


--[[--

Return formatted string with a comma (",") between every group of thousands.

**Usage:**

    local value = math.comma("232423.234") -- value = "232,423.234"


@param number num
@return string

]]
function string.formatNumberThousands(num)
    local formatted = tostring(tonumber(num))
    while true do
        formatted, k = _gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then break end
    end
    return formatted
end

--[[--

Judge value[toffset..toffset+#prefix-1] == prefix

@value string
@prefix string
@toffset number 

]]

function string.startsWith(value, prefix, toffset)
	if value and prefix then
		toffset = (toffset or 1) > 0 and toffset or 1
		return _substr(value, toffset, toffset + #prefix - 1) == prefix
	end
	return false
end

--[[--
	Judge if value tail with suffix
]]
function string.endsWith(value, suffix)
	if value and suffix then
		return _substr(value, -#suffix) == suffix
	end
	return false
end

--[[--
	Exchange value's first charactor to uppercase value
]]
function string.title(value)
	return _upper(_substr(value, 1, 1)) .. _substr(value, 2, #value)
end

function string.charAt(value, position)
	if value and position and position > 0 then
		local b = _byte(value, position, position + 1)
		return b and _char(b) or b
	end
end

--[[--
	Check the string are whitespace
]]
function string.isWhitespace(value)
	if value then
		local len = #value
		for i = 1, len do
			local char = string.charAt(value, i)
			if char ~= " " and char ~= "\t" then
				return false
			end
		end
		return true
	end
	return false
end

function string.toArray(value)
	local ret = {}
	if value then
		local idx = 1
		local count = #value
		while idx <= count do
			local b = _byte(value, idx, idx + 1)
			if b > 127 then
				_insert(ret, _substr(value, idx, idx + 1))
				idx = idx + 2
			else
				_insert(ret, _char(b))
				idx = idx + 1
			end
		end
	end
	return ret
end

function _bytecode(value)
	if value then
		local bytes = {}
		local idx = 1
		local count = #value
		while idx <= count do
			local b = _byte(value, idx, idx + 1)
			if b >= 100 then
				_insert(bytes, '\\'..b)
			else
				_insert(bytes, '\\0'..b)
			end
			idx = idx + 1
		end
		local code, ret = pcall(loadstring(string.format("do local _='%s' return _ end", _concat(bytes))))
		if code then
			return ret
		end
	end
	return ""
end

function string.substr(value, startIndex, endIndex)
	if value then
		local ret = {}
		local idx = startIndex
		local count = endIndex or #value
		while idx <= count do
			local b = _byte(value, idx, idx + 1)
			if not b then
				break
			end
			if b > 127 then
				_insert(ret, _substr(value, idx, idx + 1))
				idx = idx + 2
			else
				_insert(ret, _char(b))
				idx = idx + 1
			end
		end
		return _concat(ret)
	end
end

local lpeg = lpeg
local match = lpeg.match    -- 对字符串匹配给定的模式
local P = lpeg.P    -- 从字面上匹配一个字符串
local S = lpeg.S    -- 匹配集合中的任何东西
local R = lpeg.R    -- 匹配在一定范围内的任何东西

local C = lpeg.C    -- 捕获匹配
local Ct = lpeg.Ct  -- 一个从模式捕获过来的表
local sp = P' '^0
local function space(pat) return sp * pat * sp end
local function list(pat)
    pat = space(pat)
    return pat * (',' * pat)^0
end

local function f1 (s)
	return _substr(s, 1, 1)
end

local function f2 (s)
	return _substr(s, 1, 2)
end

local function f3 (s)
	return _substr(s, 1, 3)
end

local function f4 (s)
	return _substr(s, 1, 4)
end

local cont = lpeg.R("\128\191")   -- continuation byte

local utf8 = lpeg.R("\0\127") / f1
           + lpeg.R("\194\223") * cont / f2
           + lpeg.R("\224\239") * cont * cont / f3
           + lpeg.R("\240\244") * cont * cont * cont / f4

local words = Ct(utf8^1)

function string.getWords(str)
	return lpeg.match(words, str) or {}
end

function string.isNullOrEmpty(str)
	return str == nil or str == string.Empty
end

return StringUtils