--
-- Author: MiYu
-- Date: 2014-02-20 17:39:39
--

me = me or {}

me.isnull = tolua.isnull

me.notnull = function(...)
	return not tolua.isnull(...)
end

local acos = math.acos
function math.acos(v)
	return acos(clampf(v, -1, 1))
end

if not jit then 
    local _random= math.random
    function math.random(a, b)
        if not a and not b then return _random() end
        if not b then return _random(a) end

        a = math.floor(a)
        b = math.floor(b)

        local flag = 1
        if a < 0 and b < 0 then 
            flag = -1
            a = math.abs(a)
            b = math.abs(b)
        end

        if a > b then
            a, b = b, a
        end
        return _random(a, b) * flag
    end
end

local function dir(path, tb)
    tb = tb or {}
    for file in lfs.dir(path) do
        if file ~= "." and file ~= ".." then
            local f = path..'/'..file
            local attr = lfs.attributes (f)
            assert (type(attr) == "table")
            if attr.mode == "directory" then
                dir(f, tb)
            else
                table.insert(tb, f)
            end
        end
    end  
    return tb  
end
me.dir = dir

function Box(msg, title)
    CCMessageBox(msg or "", title or "")
end