local enum = import(".enum")
local eSelectType = enum.eSelectType
local eTeamType   = enum.eTeamType
local eDir        = enum.eDir
local selectTarget = {}

--target	areaW	aweaH	cond	targetNum

--target 2 自己 1 对方
local function getMenbers(hero,data)
	local team = battleController.getTeam()
	return team:getMenbers_(hero:getCamp(),data.target)
end

--最近
function selectTarget.nearly(hero,data)
	return selectTarget.rect(hero,data)
end

--所有
function selectTarget.all(hero,data)
	return getMenbers(hero,data)
end

--矩形区域
function selectTarget.rect(hero,data)
	local aliveHeros = getMenbers(hero,data)
	local srcPos     = me.p(hero:getPosition())
	local area       = data.area
	-- print("area",area)
	local rect       = me.rect( area[1], area[2], area[3], area[4])
	if hero:getDir() == eDir.LEFT then
		rect.origin.x = -(rect.size.width + rect.origin.x)
	end
	rect.origin = me.pAdd(srcPos,rect.origin)
	local targetHeros = {}
	for index , targetHero in ipairs(aliveHeros) do
		if targetHero:isInRect(rect) then
			targetHero._tmp = hero:distance(targetHero)
			table.insert(targetHeros, targetHero)
		end
	end
	--按由近到远排个序
	table.sort(targetHeros,function ( a ,b )
		return a._tmp < b._tmp
	end)
	return targetHeros
end

--矩形区域
function selectTarget.noDirRect(hero,data)
	local targetHeros = {}
	local area       = data.area
	local aliveHeros = getMenbers(hero,data)
	if #area < 4 or area[3] == -1 or area[4] == -1 then
		for index , targetHero in ipairs(aliveHeros) do
			table.insert(targetHeros, targetHero)
		end
		return targetHeros
	end

	local srcPos     = me.p(hero:getPosition())
	-- print("area",area)
	local rect       = me.rect( area[1], area[2], area[3], area[4])
	rect.origin = me.pAdd(srcPos,rect.origin)
	for index , targetHero in ipairs(aliveHeros) do
		if targetHero:isInRect(rect) then
			targetHero._tmp = hero:distance(targetHero)
			table.insert(targetHeros, targetHero)
		end
	end
	--按由近到远排个序
	table.sort(targetHeros,function ( a ,b )
		return a._tmp < b._tmp
	end)
	return targetHeros
end

--随机
function selectTarget.random(hero,data)
	local aliveHeros = selectTarget.rect(hero,data)
	local ret = {}
	for index = 1, data.targetNum do
		if #aliveHeros > 0 then
			local idx = RandomGenerator.random(1,#aliveHeros)
			local targetHero = table.remove(aliveHeros,idx)
			table.insert(ret,targetHero)
		else
			break
		end
	end
	return ret
end

--最远
function selectTarget.far(hero,data)
	local heros = selectTarget.rect(hero,data)
	--倒序
	local tmpHeros = {}
	for _ , tmpHero in ipairs(heros) do
		table.insert(tmpHeros, 1, tmpHero)
	end
	return tmpHeros
end


--最低血
function selectTarget.lowHP(hero,data)
	local aliveHeros = selectTarget.rect(hero,data)
	table.sort(aliveHeros,function ( a ,b )
		return a:getHp() < b:getHp()
	end)
	local ret = {}
	for k , target in ipairs(aliveHeros) do
		if #ret < data.targetNum then
			table.insert(ret, target)
		end
	end
	return ret
end

--死亡
function selectTarget.die(hero,data)
	-- assert(false,"selectTarget.die no implement")
	return {}
end

--自己
function selectTarget.myself(hero,data)
	return {hero}
end



local funMap = {}

local function init()
	funMap[eSelectType.NEARLY] = selectTarget.nearly
	-- funMap[eSelectType.ALL]    = selectTarget.all
	funMap[eSelectType.RECT]   = selectTarget.rect
	funMap[eSelectType.NO_DIR_RECT]   = selectTarget.noDirRect
	funMap[eSelectType.RANDOM] = selectTarget.random
	funMap[eSelectType.FAR]    = selectTarget.far
	funMap[eSelectType.LOWHP]  = selectTarget.lowHP
	funMap[eSelectType.DIE]    = selectTarget.die
	funMap[eSelectType.MYSELF] = selectTarget.myself
end


function selectTarget.getFun(selectType)
	-- print("get select fun",selectType)
	return funMap[selectType]
end

--组织通用寻敌数据
function selectTarget.createData(target,area,targetNum)
	-- print("get select fun",selectType)
	return { target = target, area = area , targetNum = targetNum}
end
function selectTarget.selectTarget(hero,target,area,targetNum,selectType)
	local func = selectTarget.getFun(selectType)
	local data = selectTarget.createData(target,area,targetNum)
	return func(hero,data)
end

init()

return selectTarget
