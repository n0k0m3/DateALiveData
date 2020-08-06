
local function Sequence_create(seq, arr)
    local tab = {}
    if type(arr) == "table" then
        tab = arr
    else
        local size = arr:size()
        for i = 0, size - 1 do
            tab[#tab + 1] = arr:objectAtIndex(i)
        end
    end
	return Sequence:createWithTable(tab)
end
rawset(Sequence, "create", Sequence_create)

local function Spawn_create(seq, arr)
    local tab = {}
    if type(arr) == "table" then
        tab = arr
    else
        local size = arr:size()
        for i = 0, size - 1 do
            tab[#tab + 1] = arr:objectAtIndex(i)
        end
    end
    return Spawn:createWithTable(tab)
end
rawset(Spawn, "create", Spawn_create)
