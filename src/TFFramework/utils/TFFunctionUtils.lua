--[[--
	与函数处理相关的方法

	--By: yun.bo
	--2013/7/8
]]

local TFFunction_MT = {}
TFFunction_MT.__index = TFFunction_MT
TFFunction_MT.__call = function(tb, func, ...)
	if func and type(func) == 'function' then
		return func(...)
	end
end

TFFunction = setmetatable({}, TFFunction_MT)
function TFFunction.call(func, ...)
	if func and type(func) == 'function' then
		return func(...)
	end
end

print_ = print
function print(...)
	local n = select('#', ...)

	local tb = {}

	table.insert(tb, '[' .. os.date() .. ']')
	for i = 1, n do
		local v = select(i, ...)
		local str = serialize(v)
		table.insert(tb, str)
	end

    local ret = table.concat(tb, '  ')

	print_(ret)

    return ret
end

if decoda_output ~= nil then
    local de_print = print
    function print(...)
        local ret = de_print(...)
        if ret then 
            decoda_output(ret)
        end
    end
end

function isNaN(x)
	return x ~= x
end