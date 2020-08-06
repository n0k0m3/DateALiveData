local BaseDataMgr = import(".BaseDataMgr")
local CatchDollDataMgr = class("CatchDollDataMgr", BaseDataMgr)


function CatchDollDataMgr:ctor()
    self:init()
end

function CatchDollDataMgr:init()
	TFDirector:addProto(s2c.NEW_BUILDING_GET_GASHAPON_INFO, self, self.recvGashaponInfo)
	TFDirector:addProto(s2c.NEW_BUILDING_RESP_START_GASHAPON, self, self.recvGashaponStart)
	TFDirector:addProto(s2c.NEW_BUILDING_RESP_CHECK_GASHAPON_RESULT, self, self.recvGashaponCheck)
	TFDirector:addProto(s2c.NEW_BUILDING_RESP_REFRESH_GASHAPON_POOL, self, self.recvGashaponRefresh)
end

function CatchDollDataMgr:setGameWin(isGameWin)
	self.isGameWin = isGameWin
end

function CatchDollDataMgr:getGameWin()
	return self.isGameWin
end

function CatchDollDataMgr:getTarget()
	return {template = self.gameConfig.intent, num = self.gameConfig.number}
end

function CatchDollDataMgr:getCoinNumber()
	return self.gameConfig.times
end

function CatchDollDataMgr:goCatchDoll(param)
	if param and param.isCollect then
		self.isDating = true
		self.isCollect = true
		self:setGameWin(false)

		self.gameConfig = param.gameConfig
		self.coin = nil

		self:generateToyPool(self.gameConfig.gashapon)
		AlertManager:changeScene(SceneType.CATCHDOLL,true,TFSceneChangeType_PushBack)
		-- self.catchDollScene = require(SceneType.CATCHDOLL):new(true)
		-- me.Director:pushScene(self.catchDollScene,)
	else
		self.isCollect = false
		self.isDating = false

		CatchDollDataMgr:reqGashaponInfo()
	end
end

function CatchDollDataMgr:endGame()
	local currentScene = Public:currentScene()
   	if currentScene.__cname ~= "CatchDollScene" then
   		return;
   	end

	AlertManager:changeScene(SceneType.MainScene,nil,TFSceneChangeType_PopBack)
	-- me.Director:popScene()
	EventMgr:dispatchEvent(EV_CATCHDOLL_END)
end

function CatchDollDataMgr:isCollectMode()
	return self.isCollect
end

function CatchDollDataMgr:parseToyPoll(eggPool)
	local toyPool = Json.decode(eggPool)
	for _, line in ipairs(toyPool) do
		for i, toyDes in ipairs(line) do
			local toy = string.split(toyDes, "_")
			line[i] = {id = tonumber(toy[1]), template = tonumber(toy[2])}
		end
	end
	local beforecount = 0
	if self.toyPool then
		local beforecount = #self.toyPool
	end
	self.toyPool = toyPool
	if beforecount == 0 then
		EventMgr:dispatchEvent(EV_CATCHDOLL_REFRESH)
	end

end

function CatchDollDataMgr:recvGashaponInfo(event)
	-- print(event.data)
	self.catchEndTime = event.data.catchEndTime
	self.pollRefreshCdEndTime = event.data.pollRefreshCdEndTime
	self.id = event.data.eggPoolId

	self:parseToyPoll(event.data.eggPool)

	EventMgr:dispatchEvent(EV_CATCHDOLL_POOL_INFO)
end

function CatchDollDataMgr:getToyPool()
	return self.toyPool
end

function CatchDollDataMgr:ableToFresh()
	if self:getRefreshTime() < ServerDataMgr:getServerTime() then
		return true
	end
end

function CatchDollDataMgr:getRefreshTime()
	return math.floor(self.pollRefreshCdEndTime / 1000)
end

function CatchDollDataMgr:getTimeFormating(timeVal)
	if timeVal < 0 then
		timeVal = 0
	end

    local hour= math.floor(timeVal / 3600)
    local min = math.floor(timeVal % 86400 % 3600 / 60)
    local seconds = math.floor(timeVal % 86400 % 3600 % 60 / 1)
    return hour, min, seconds
end

function CatchDollDataMgr:getRefreshTimeDesc()
	local time = self:getRefreshTime() - ServerDataMgr:getServerTime()
	local hour, min, seconds = self:getTimeFormating(time)

	return string.format("%02d:%02d:%02d", hour, min, seconds)
end

function CatchDollDataMgr:getcatchEndTime()
	return math.floor(self.catchEndTime / 1000)
end

function CatchDollDataMgr:resetCountDownNumber()
	self.countDownNumber = 30
end

function CatchDollDataMgr:getCatchTimeCountDown()
	if self:isCollectMode() then
		self.countDownNumber = self.countDownNumber - 1
		return self.countDownNumber
	else
		return self:getcatchEndTime() - ServerDataMgr:getServerTime()
	end
end

function CatchDollDataMgr:recvGashaponStart(event)
	self.catchEndTime = event.data.catchEndTime
	EventMgr:dispatchEvent(EV_CATCHDOLL_START)
end

function CatchDollDataMgr:recvGashaponCheck(event)
	print("CatchDollDataMgr:recvGashaponCheck")
	print(event.data)
	print(event.data.eggIds)

	self:parseToyPoll(event.data.eggPool)
	Utils:showReward(event.data.rewards)
end

function CatchDollDataMgr:recvGashaponRefresh(event)
	print("CatchDollDataMgr:recvGashaponRefresh")
	print(event.data)

	self:parseToyPoll(event.data.eggPool)
	self.pollRefreshCdEndTime = event.data.pollRefreshCdEndTime

	EventMgr:dispatchEvent(EV_CATCHDOLL_REFRESH)
end

function CatchDollDataMgr:reqGashaponInfo()
	TFDirector:send(c2s.NEW_BUILDING_REQ_GET_GASHAPON_INFO, {})
end

function CatchDollDataMgr:reqGashaponStart()
	TFDirector:send(c2s.NEW_BUILDING_REQ_START_GASHAPON, {})
end

function CatchDollDataMgr:reqGashaponCheck(cids)
	TFDirector:send(c2s.NEW_BUILDING_REQ_CHECK_GASHAPON_RESULT, {cids})
end

function CatchDollDataMgr:reqGashaponRefresh()
	TFDirector:send(c2s.NEW_BUILDING_REQ_REFRESH_GASHAPON_POOL, {})
end

function CatchDollDataMgr:setCoin(coin)
	if self:isCollectMode() then
		self.coin = coin
	end
end

function CatchDollDataMgr:getCoin()
	if self:isCollectMode() then
		return self.coin or self:getCoinNumber()
	else
		return GoodsDataMgr:getItemCount(500017)
	end
end

function CatchDollDataMgr:saveToyPos(posTab)
	if self:isCollectMode() then
		return
	end

    local fileName = "posFile"
    local filePath = me.FileUtils:getWritablePath() .. 'cacheData/catchDoll/'

    if TFFileUtil:existFile(filePath) == false then
        TFFileUtil:createDir(filePath)
    end
    local path = string.format("%s%s.lua", filePath,fileName)
    Utils:writeTable(posTab, path)
end

function CatchDollDataMgr:loadToyPos()
	if self:isCollectMode() then
		return
	end

    local fileName = "posFile"
    local filePath = me.FileUtils:getWritablePath() .. 'cacheData/catchDoll/'

    local path = string.format("%s%s.lua", filePath,fileName)
    if TFFileUtil:existFile(path) == false then
        return
    end

    return Utils:readTable(path)
end

function CatchDollDataMgr:getGameBuildId()
	return 9
end

function CatchDollDataMgr:getToyConfig()
	return TabDataMgr:getData("Egg")
end

function CatchDollDataMgr:getClampsPower()
	if self:isCollectMode() then
		local poolNum = self.gameConfig.gashapon
		return TabDataMgr:getData("Gashapon")[poolNum].power
	else
		if self.id then
			return TabDataMgr:getData("Gashapon")[self.id].power
		else
			return 1
		end
	end
end

function CatchDollDataMgr:getToyMassFactor(template)
	if not template then
		return 1
	end

	local config  = self:getToyConfig()
	return config[template].weight
end

function CatchDollDataMgr:generateToyPool(poolNum)
	poolNum = poolNum or 1

	local toyConfig = TabDataMgr:getData("Gashapon")[poolNum]

	local lineMin = toyConfig.lineMin
	local lineMinCfg = {}
	if lineMin ~= "" then
		lineMin = string.split(lineMin, "|")
		for i, line in ipairs(lineMin) do
			line = string.split(line, ":")
			lineMinCfg[tonumber(line[2])] = lineMinCfg[tonumber(line[2])] or {}
			lineMinCfg[tonumber(line[2])][tonumber(line[1])] = lineMinCfg[tonumber(line[2])][tonumber(line[1])] or 0
			lineMinCfg[tonumber(line[2])][tonumber(line[1])] = lineMinCfg[tonumber(line[2])][tonumber(line[1])] + tonumber(line[3])
		end
	end

	local allMax = toyConfig.allMax
	local allMaxCfg = {}
	if allMax~= "" then
		allMax = string.split(allMax, "|")
		for i, line in ipairs(allMax) do
			line = string.split(line, ":")
			allMaxCfg[tonumber(line[1])] = tonumber(line[2])
		end
	end

	local eggItems = toyConfig.eggItems
	local cfg = {}
	local lines = string.split(eggItems, "|")
	for lineN, line in ipairs(lines) do
		cfg[lineN] = {}

		line = string.split(line, "+")
		local num = tonumber(line[1])

		local weightCfg = {}
		weightCfg.template = {}
		weightCfg.w = {}

		local weight = string.split(line[2], ",")
		local totalW = 0
		for _, w in ipairs(weight) do
			w = string.split(w, ":")
			if not (lineMinCfg[lineN] and lineMinCfg[lineN][tonumber(w[1])]) then
				table.insert(weightCfg.template, tonumber(w[1]))
				totalW = totalW + tonumber(w[2])
				table.insert(weightCfg.w, totalW)
			end
		end

		for template, n in ipairs(lineMinCfg[lineN] or {}) do
			for j = 1, n do
				table.insert(cfg[lineN], {template = template})
				if allMaxCfg[template] then
					allMaxCfg[template] = allMaxCfg[template] - 1
				end
			end
		end


		local initNum = #cfg[lineN]
		while #cfg[lineN] < num do
			local score = math.random(1, totalW)
			for i = 1, #weightCfg.w do
				if score <= weightCfg.w[i] then
					if allMaxCfg[weightCfg.template[i]] then
						if allMaxCfg[weightCfg.template[i]] > 0 then
							table.insert(cfg[lineN], {template = weightCfg.template[i]})
							allMaxCfg[weightCfg.template[i]] = allMaxCfg[weightCfg.template[i]] - 1
						else
							--skip
						end
					else
						table.insert(cfg[lineN], {template = weightCfg.template[i]})
					end
					break
				end
			end
		end

		for i = 1, initNum do
			local n = math.random(1, #cfg[lineN])
			local t
			t = cfg[lineN][i]
			cfg[lineN][i] = cfg[lineN][n]
			cfg[lineN][n] = t
		end
	end

	self.toyPool = cfg
end

return CatchDollDataMgr:new()