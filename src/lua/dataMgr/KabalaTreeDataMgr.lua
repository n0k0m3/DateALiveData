local BaseDataMgr = import(".BaseDataMgr")
local KabalaTreeDataMgr = class("KabalaTreeDataMgr", BaseDataMgr)
local UserDefalt = CCUserDefault:sharedUserDefault()
function KabalaTreeDataMgr:init()

	self:initData()
end

function KabalaTreeDataMgr:onLogin()
    TFDirector:send(c2s.QLIPHOTH_QLIPHOTH_TIME, {})
    return {s2c.QLIPHOTH_QLIPHOTH_TIME}
end

function KabalaTreeDataMgr:initData()

	self.kabalaGameCfg = TabDataMgr:getData("Kabalagame")
	self.KabalaServerDataCfg = TabDataMgr:getData("KabalaServerData")
	self.KabalaWorldCfg = TabDataMgr:getData("KabalaWorld")
	self.KabalaMissionCfg = TabDataMgr:getData("KabalaMission")
	self.KabalaformCfg = TabDataMgr:getData("Kabalaform")
	self.KabalaEventCfg = TabDataMgr:getData("KabalaEvent")
	self.DialogCfg = TabDataMgr:getData("Dialog")
	self.KabalaGridType = TabDataMgr:getData("KabalaGridType")
	self.KabalabuffCfg = TabDataMgr:getData("Kabalabuff")
	self.isWin = true
	self.pollution = Utils:getKVP(19001, "pollutionLimit")
	self.MaxEnergy = Utils:getKVP(19001, "oilValue").max

	--统计数据处理
	self.tatisticsData = {}
	self.statistics = {}
	self.mergeType = {}
	local eventCountCfg = TabDataMgr:getData("KabalaEventCount")
	for _,data in ipairs(eventCountCfg) do
		if not self.statistics[data.worldID] then
			self.statistics[data.worldID] = {}
		end
		table.insert(self.statistics[data.worldID],data)

		if data.isMerge then
			local eventType = self.KabalaEventCfg[data.eventID].eventType
			if eventType then
				self.mergeType[eventType] = {cfgData = data,eventId = data.eventID}
			end
		end
	end

	self:setOriginalGid()
	self:registerMsgEvent()
end

--注册服务器消息事件
function KabalaTreeDataMgr:registerMsgEvent()

	TFDirector:addProto(s2c.QLIPHOTH_QLIPHOTH_TREE_INFO, self, self.onRecvKabalaTreeInfo)
    TFDirector:addProto(s2c.QLIPHOTH_PARTICLE_WORLD_INFO, self, self.onRecvKabalaWorldInfo)
    TFDirector:addProto(s2c.QLIPHOTH_PARTICLE_WORLD_EVENT, self, self.onRecvTriggerEvent)
    TFDirector:addProto(s2c.QLIPHOTH_OPERATE_FORMATION, self, self.onRecvFormationInfo)
    TFDirector:addProto(s2c.QLIPHOTH_PARTICLE_MAP_POINT, self, self.onRecvPlayerMove)
    TFDirector:addProto(s2c.QLIPHOTH_QLIPHOTH_ITEMS, self, self.onRecvItemBag)
    TFDirector:addProto(s2c.QLIPHOTH_QLIPHOTH_MISSIONS, self, self.onRecvMissionInfo)
    TFDirector:addProto(s2c.QLIPHOTH_HERO_INFECTIONS, self, self.onRecvHeroEffect)
    TFDirector:addProto(s2c.QLIPHOTH_QLIPHOTH_ENERGY, self, self.onRecvKabalaEnergy)
	TFDirector:addProto(s2c.QLIPHOTH_PARTICLE_WORLD_AMBUSH, self, self.onRecvRandomAttack)
    TFDirector:addProto(s2c.QLIPHOTH_WORLD_TRANSFORM, self, self.onRecvTransport)
	TFDirector:addProto(s2c.QLIPHOTH_SHOP_PURCHASE, self, self.onRecvBuyItem)
    TFDirector:addProto(s2c.QLIPHOTH_SHOP_INFO, self, self.onRecvShopInfo)
    TFDirector:addProto(s2c.QLIPHOTH_USE_ITEM, self, self.onRecvUseBagItem)
    TFDirector:addProto(s2c.QLIPHOTH_QLIPHOTH_ITEMS_EVENT, self, self.onRecvEventItem)
	TFDirector:addProto(s2c.QLIPHOTH_QLIPHOTH_TASK_REWARD, self, self.onRecvFinishTask)
    TFDirector:addProto(s2c.QLIPHOTH_WORLD_POINT_EXPLORELO, self, self.onRecvSearchTarget)
	TFDirector:addProto(s2c.QLIPHOTH_QLIPHOTH_COIN, self, self.onRecvKabalaCoin)
    TFDirector:addProto(s2c.QLIPHOTH_WORLD_POINTS_REFRESH, self, self.onRecvUpdateMap)

    TFDirector:addProto(s2c.QLIPHOTH_PARTICLE_WORLD_STATUS, self, self.onRecvUpdateWorld)
    TFDirector:addProto(s2c.QLIPHOTH_QLIPHOTH_TIME, self, self.onRecvTime)
    TFDirector:addProto(s2c.QLIPHOTH_RANDOM_EVENTS, self, self.onRefreshRandomEvent)
	TFDirector:addProto(s2c.QLIPHOTH_TASK_EVENT_DISCOVER, self, self.onRecvDisCoverTask)
	TFDirector:addProto(s2c.QLIPHOTH_QLIPHOTH_BUFF, self, self.onRecvCurBuffs)
	TFDirector:addProto(s2c.QLIPHOTH_HIDDEN_EVENTS, self, self.onRecvHiddenEvents)
	TFDirector:addProto(s2c.QLIPHOTH_HIDDEN_EVENT_REWARD, self, self.onRecvHiddenRewwards)
	TFDirector:addProto(s2c.QLIPHOTH_GAME_EVENT, self, self.onTriggerGameEvent)
	TFDirector:addProto(s2c.QLIPHOTH_REPLY_GAME, self, self.onReplyGameInfo)
	TFDirector:addProto(s2c.QLIPHOTH_PERFORM_EVENT, self, self.onReplyPerformEvent)


end

--获取世界开放状态
function KabalaTreeDataMgr:getWorldState(worldId)

	local worldInfoCfg = self.KabalaWorldCfg[worldId]
	local worldTimeInfo = self:getTimeInfo(worldId)
	if not worldInfoCfg or not worldTimeInfo then
		return
	end

	local beginTime = worldTimeInfo.beginTime
	local endTime = worldTimeInfo.endTime
	local beforBeginTime = beginTime - worldTimeInfo.beSoon*60
	local curTime = ServerDataMgr:getServerTime()
	local beInThisWorld = worldId == 10001
	local maxCnt = #worldInfoCfg.missionParam+1
	local state,time
	if curTime < beforBeginTime then
		state =  Enum_WorldState.State_stabilize
		time = beginTime
	elseif curTime >= beforBeginTime and curTime < beginTime then
		state =  Enum_WorldState.State_willOpen
		time = beginTime
	elseif curTime >= beginTime and curTime < endTime then
		state =  Enum_WorldState.State_Opening
		time = endTime
	elseif curTime >= endTime then
		state =  Enum_WorldState.State_stabilize
	end

	return state,time,beInThisWorld,maxCnt
end

function KabalaTreeDataMgr:setOriginalGid()

	self.originalGidInfo = {}
	for mapCid,info in pairs(self.KabalaServerDataCfg) do

		local tab = {}
		local firstInfo = info.firstJsonData
		local mapSize = info.mapSize
		for id,gidId in ipairs(firstInfo) do
			local index = id - 1
			local posX = index%mapSize[1]
			local posY = math.floor(index/mapSize[1])
			tab[posX.."-"..posY] = gidId
		end
		self.originalGidInfo[mapCid] = tab
	end

end

function KabalaTreeDataMgr:removeKabalaTreeItem(tilePosMN)

	for i=#self.KabalaTreeItemMap,1,-1 do
		local pos = self.KabalaTreeItemMap[i].pos
		if pos.x == tilePosMN.x and tilePosMN.y == pos.y then
			table.remove(self.KabalaTreeItemMap,i)
			break
		end
	end

	self:cleanMapEvent(tilePosMN.x.."-"..tilePosMN.y)
end

function KabalaTreeDataMgr:getKabalaTreeItem(tilePosMN)

	local kabalaItem
	for k,v in pairs(self.KabalaTreeItemMap) do
		if v.pos.x == tilePosMN.x and tilePosMN.y == v.pos.y then
			kabalaItem = v
			break
		end
	end

	return kabalaItem
end

function KabalaTreeDataMgr:addKabalaTreeItem(item)

	table.insert(self.KabalaTreeItemMap,item)
end

function KabalaTreeDataMgr:getKabalaTreeItemMap()
	return self.KabalaTreeItemMap
end

function KabalaTreeDataMgr:getObstacleOffset()
	return 0,80
end

function KabalaTreeDataMgr:setKabalaTreeNpc(npc)

	self.kabalaTreeNpc = npc
end

function KabalaTreeDataMgr:getKabalaTreeNpc()
	return self.kabalaTreeNpc
end

function KabalaTreeDataMgr:getTileMapRes(mapId)

	local tileMapInfo = self.KabalaServerDataCfg[self.mapCid]
	if not tileMapInfo then
		return
	end
	local tileMapRes = tileMapInfo.mapPath.."/"..tileMapInfo.version.."/"..tileMapInfo.mapName
	return tileMapRes
end

function KabalaTreeDataMgr:getTextCoordinate()

	if not self.KabalaServerDataCfg[self.mapCid] then
		return
	end
	return self.KabalaServerDataCfg[self.mapCid].textCoordinate
end

function KabalaTreeDataMgr:getOriginalGid(pos)

	if not pos then
		return
	end

	local gidInfo = self.originalGidInfo[self.mapCid]
	if not gidInfo then
		return
	end

	return gidInfo[pos.x.."-"..pos.y]

end

function KabalaTreeDataMgr:getTileCost()

	local worldCfg = self.KabalaWorldCfg[self.curWorldId]
	if not worldCfg then
		return 0
	end

	return worldCfg.unlockCost
end

function KabalaTreeDataMgr:formateTime(timeVal)

	if timeVal < 0 then
		timeVal = 0
	end
	local hour= math.floor(timeVal / 3600)
	local min = math.floor(timeVal % 86400 % 3600 / 60)
	local seconds = math.floor(timeVal % 86400 % 3600 % 60 / 1)
	return string.format("%02d:%02d:%02d", hour, min, seconds)

end

function KabalaTreeDataMgr:initTileMapData(tileMap)

	self.searchZone = {}
	self.KabalaTreeItemMap = {}

	self.tileMap = tileMap
	self.mapSize = self.tileMap:getMapSize()
	self.tileSize = self.tileMap:getTileSize()
	self.winSize = me.Director:getVisibleSize()

	self:initEventTiled()
	self:initSearchZone()
end

function KabalaTreeDataMgr:initEventTiled()

	self.floorGid = {}
	local eventGid = {}
	for k,v in pairs(self.KabalaGridType) do
		if v.gridType == 1 then
			table.insert(eventGid,{gidType = v.id, gid = v.gridId})
		else
			self.floorGid[v.id] = v.gridId
		end
	end
	table.sort(eventGid,function(a,b)
		return a.gid < b.gid
	end)

	self.eventTiled = {}
	local eventLayer = self.tileMap:getLayer("Event")
	local tileXCount,tileYCount = self:getTileXYCount()
	for i=0,tileXCount-1 do
		for j=0,tileYCount-1 do

			local gid = eventLayer:getTileGIDAt(ccp(i,j))
			for k,v in ipairs(eventGid) do
				local gidType = v.gidType
				if gid <= v.gid then
					if not self.eventTiled[gidType] then
						self.eventTiled[gidType] = {}
					end
					local tileInfo = {pos = ccp(i,j), gid = gid}
					table.insert(self.eventTiled[gidType],tileInfo)
					break
				end
			end
		end
	end
end

function KabalaTreeDataMgr:getTileMap()
	return self.tileMap
end

function KabalaTreeDataMgr:setMapScale(mapScale)
	self.mapScale = mapScale
	local playerId = MainPlayer:getPlayerId()
	UserDefalt:setStringForKey("KabalaMapScale"..playerId,self.mapScale)
	UserDefalt:flush()
	self.tileMap:setScale(self.mapScale)
end

function KabalaTreeDataMgr:getMapScale()

	local playerId = MainPlayer:getPlayerId()
	local scale = UserDefalt:getStringForKey("KabalaMapScale"..playerId)
	scale = tonumber(scale)
	self.mapScale = scale or 0.65
	return self.mapScale
end

function KabalaTreeDataMgr:getTileXYCount()

    return self.mapSize.width,self.mapSize.height
end

function KabalaTreeDataMgr:getTileSize()

	local mapScale = self:getMapScale()
	local width = self.tileSize.width
	local height = self.tileSize.height
	return width,height
end

function KabalaTreeDataMgr:calcValueDis(point,desTiled)

    local distanceX = math.abs(desTiled.x - point.x)
    local distanceY = math.abs(desTiled.y - point.y)

    return distanceX + distanceY
end

--(x,y)->(M,N) convertToNormalPos的逆过程
function KabalaTreeDataMgr:convertToMN(x,y)

    local tileXCount,tileYCount = self:getTileXYCount()
    local tileWidth,tileHeight  = self:getTileSize()

    local originalPosX = tileWidth * tileXCount/2
    local originalPosY = tileHeight * tileYCount

    local M = (x - originalPosX)/tileWidth + (y - 90 - originalPosY)/(-tileHeight)
    local N = (y - 90 - originalPosY)/(-tileHeight) - (x - originalPosX)/tileWidth

    M = math.floor(M)
    N = math.floor(N)
    print(M,N,tileWidth,tileHeight)
    return M,N
end

--(M,N)->(x,y)
function KabalaTreeDataMgr:convertToPos(M,N)

	--tilePos(M,N) 原点坐标:tiled(M,N) = tiled(0,0) 的顶点坐标
    --x = 原点坐标X + M在像素坐标系X轴的偏移像素 * M + N在像素坐标系X轴的偏移像素 * N
    --  = originalPosX + tileWidth /2 * M + （-tileWidth/2） * N
    --x = originalPosX + (M – N) * tileWidth/2

    --y = 原点坐标Y + M在像素坐标系Y轴的偏移像素 * M + N在像素坐标系Y轴的偏移像素 * N
    --  = originalPosY + (-tileHeight / 2) * M + (-tileHeight / 2) * N
    --y = originalPosY + (M + N) * (-tileHeight / 2) + 90(块的三维高度)

    --so
    --M - N = (x - originalPosX)*2/tileWidth
    --M + N = (y - originalPosY)*2/(-tileHeight)

    local tileXCount,tileYCount = self:getTileXYCount()
    local tileWidth,tileHeight  = self:getTileSize()

    local originalPosX = tileWidth*tileXCount/2
    local originalPosY = tileHeight*tileYCount

    local x = originalPosX + (M - N) * tileWidth/2
    local y = originalPosY + (M + N) * (-tileHeight / 2) + 90
    return ccp(x,y)
end

function KabalaTreeDataMgr:convertToPosAR(x,y)

    local tileXCount,tileYCount = self:getTileXYCount()
    local tileWidth,tileHeight  = self:getTileSize()

    x = x - tileXCount*tileWidth/2
    y = y - tileYCount*tileHeight/2 - tileHeight/2
    return ccp(x,y)
end

--检测格子坐标是否在屏幕内
function KabalaTreeDataMgr:checkInScreen(tiledPosMN)

	if not tiledPosMN or not self.tileMap then
		return
	end

    local position = self:convertToPos(tiledPosMN.x,tiledPosMN.y)
    position = self.tileMap:convertToWorldSpace(position)

    if position.x < 0 or position.x > GameConfig.WS.width then
    	return false,position
    end

    if position.y < 0 or position.y > GameConfig.WS.height then
    	return false,position
    end

    return true,position
end

--设置地图拖动边界
function KabalaTreeDataMgr:setGridMapLimit()

    local scale = self:getMapScale()
    local winSize = me.Director:getVisibleSize()
    local tileXCount,tileYCount = self:getTileXYCount()
    local tileWidth,tileHeight  = self:getTileSize()

    self.limitLW = winSize.width/2 - tileWidth * tileXCount * scale /2
    if self.limitLW > 0 then
    	self.limitLW = -self.limitLW
    end
    self.limitRW = -self.limitLW
    self.limitDH = winSize.height/2 - tileHeight * tileYCount * scale /2
    if self.limitDH > 0 then
    	self.limitDH = -self.limitDH
    end
    self.limitUH = -self.limitDH

end

--拖动边界
function KabalaTreeDataMgr:detectEdges(point)

    if point.x > self.limitRW then
        point.x = self.limitRW
    end
    if point.x < self.limitLW then
        point.x = self.limitLW
    end
    if point.y > self.limitUH  then
        point.y = self.limitUH
    end
    if point.y < self.limitDH -180 then
        point.y = self.limitDH -180
    end

    return point
end

--不在地图范围内
function KabalaTreeDataMgr:existInMap(tiledPos)

	local tileXCount,tileYCount = self:getTileXYCount()
	local minX,maxX = 0,tileXCount -1
	local minY,maxY = 0,tileYCount -1
	if tiledPos.x < 0 or tiledPos.x > maxX or tiledPos.y < minY or tiledPos.y > maxY then
		return false
	end

	return true
end

--是否有格子(物理上不存在)
function KabalaTreeDataMgr:isNilTiled(tiledPos)

	local exist = self:existInMap(tiledPos)
	if not exist then
		return true
	end

	local layer = self.tileMap:getLayer("Plain")
	if layer then
		local gid = layer:getTileGIDAt(tiledPos)
		if gid ~= 0 then
			return false
		end
	end
	return true
end

--格子是否显示(物理上存在，只是opacity = 0)
function KabalaTreeDataMgr:getOpacity(tiledPos)

	local exist = self:existInMap(tiledPos)
	if not exist then
		return 0
	end

	local layer = self.tileMap:getLayer("Plain")
	if layer then
		local layerImg = layer:getTileAt(tiledPos)
		if not layerImg then
			return 0
		end

		local opacity = layerImg:getOpacity()
		return opacity
	end

	return 0
end

--是否存在障碍物
function KabalaTreeDataMgr:isObstacle(tiledPos)

	local exist = self:existInMap(tiledPos)
	if not exist then
		return true
	end

	local eventLayer = self.tileMap:getLayer("Event")
	if not eventLayer  then
		return false
	end

	local eventGidId = eventLayer:getTileGIDAt(tiledPos)
	if eventGidId == 2 then
		return true
	end

	return false
end

function KabalaTreeDataMgr:getAroundTileds(tiledPos,range)

	local layer = self.tileMap:getLayer("Plain")
	if not layer then
		return
	end

	local x,y = tiledPos.x,tiledPos.y
	local around = {}
	for i = -range,range do
		for j = -range,range do
			if i ~= 0 or j ~= 0 then
				table.insert(around,ccp(x+i,y+j))
			end
		end
	end
	return around
end

function KabalaTreeDataMgr:getSpawnTiledAround(tiledPos,circleNum)

	circleNum = circleNum or 1
	local layer = self.tileMap:getLayer("Plain")
	local aroundPos =  self:getAroundTileds(tiledPos,circleNum)
	local around = {}
	for k,v in ipairs(aroundPos) do
		local existInMap = self:existInMap(v)
		if existInMap then
			local sprite = layer:getTileAt(v)
			if sprite then
				local opacity = sprite:getOpacity()
				if opacity == 0 then
					table.insert(around,v)
				end
			end
		end
	end

	return around
end

--获取地面层的gid
function KabalaTreeDataMgr:getGroundLayerGid(type)
	return self.floorGid[type]
end

--初始化探索区域
function KabalaTreeDataMgr:initSearchZone()

	self.searchZone = {}
	local search = self.eventTiled[EC_EventLayerGid.Tile_Search]
	local searchDot = self.eventTiled[EC_EventLayerGid.Tile_SearchDot]
	local eventSearch = {}
	for k,v in pairs(self.KabalaEventCfg) do
		if v.eventType == 5 then
			self.searchZone[v.id] = {}
			if search then
				for i,titleInfo in pairs(search) do
					if titleInfo.gid == v.scanTileID then
						table.insert(self.searchZone[v.id],titleInfo.pos)
					end
				end
			end

			if searchDot then
				for i,titleInfo in pairs(searchDot) do
					if titleInfo.gid == v.eventParam[1] then
						table.insert(self.searchZone[v.id],titleInfo.pos)
					end
				end
			end
		end
	end
end

--获取探索区域
function KabalaTreeDataMgr:getSearchZone(eventId)

	if not self.searchZone[eventId] then
		return
	end

	return self.searchZone[eventId]
end

function KabalaTreeDataMgr:getSearchResult()
	return self.searchResult or false
end

function KabalaTreeDataMgr:setSearchResult(searchResult)
	self.searchResult = searchResult
end


function KabalaTreeDataMgr:getEventTilesByGid(tileType,gid)

	local tilesTab = self.eventTiled[tileType]
	for k,v in ipairs(tilesTab) do
		if v.gid == gid then
			return v.pos
		end
	end
	return nil
end

function KabalaTreeDataMgr:playStory(storyType,storyId,finishCallBack)

	if not storyType or not storyId then
		return
	end

	if storyType == 1 then
		local scriptId = storyId
		local param = {
	        groupid = scriptId,
	        callback = finishCallBack
	    }
		self:playCg(param)
	end

end

function KabalaTreeDataMgr:playCg(param)


    local view = requireNew("lua.logic.talk.TalkMainLayer"):new(param)
    AlertManager:addLayer(view,AlertManager.BLOCK)
    AlertManager:show()

end

function KabalaTreeDataMgr:getTaskInfo(taskId)

	if not self.KabalaMissionCfg[taskId] then
		return
	end

	return self.KabalaMissionCfg[taskId]
end

function KabalaTreeDataMgr:getTaskTargetInfo(taskId)

	local nameTextId
	local taskType = self.KabalaMissionCfg[taskId].missionType
	local param1,param2,param3 = self.KabalaMissionCfg[taskId].checkParam[1],self.KabalaMissionCfg[taskId].checkParam[2],self.KabalaMissionCfg[taskId].checkParam[3]
	local targetNum = param2 or 1
	local isSearchTask = taskType == 1004
	if taskType == 1003 then
		local monster = TabDataMgr:getData("Monster")[param2]
		nameTextId = monster.name
		targetNum = param3
	elseif taskType == 1002 then
		local item = TabDataMgr:getData("Item")[param1]
		nameTextId = item.nameTextId
	end

	return nameTextId,targetNum,isSearchTask
end

--判断是否是据点事件
function KabalaTreeDataMgr:checkIsStrongHold()

	local tilePosMN = self:getStronghold()
	if not tilePosMN then
		return
	end

	local eventId = self:getEventId(tilePosMN)
	if not eventId then
		return
	end

	if not self.KabalaEventCfg[eventId] then
		return
	end

	return self.KabalaEventCfg[eventId].eventType == 3
end

function KabalaTreeDataMgr:getTileGIdByEventId(eventId,eventValid)

	if not self.KabalaEventCfg[eventId] then
		return self.floorGid[EC_EventLayerGid.Tile_Normal]
	end

	local tileGid = self.floorGid[EC_EventLayerGid.Tile_Normal]
	local eventSubType = self.KabalaEventCfg[eventId].eventSubType
	local isDelete = self.KabalaEventCfg[eventId].isDelete
	local formID = self.KabalaEventCfg[eventId].formID
	for k,v in pairs(self.KabalaformCfg) do
		if v.tileGid ~= 0 then
			for i,j in pairs(v.eventType) do
				if eventSubType == j then
					tileGid = v.tileGid
					break
				end
			end
		end
	end

	if not eventValid then
		tileGid = self.floorGid[EC_EventLayerGid.Tile_Normal]
		if formID == 7 and (not eventValid) then
			tileGid = self.floorGid[EC_EventLayerGid.Tile_Blue]
		end
	end
	return tileGid,isDelete
end

--得到格子事件类型,展示资源
function KabalaTreeDataMgr:getTileEventRes(eventId,eventValid)

	if not self.KabalaEventCfg[eventId] then
		return
	end

	local eventType = self.KabalaEventCfg[eventId].eventType
	local formID = self.KabalaEventCfg[eventId].formID
	local eventParam = self.KabalaEventCfg[eventId].eventParam
	local eventText = self.KabalaEventCfg[eventId].eventText
	local oilCost = self.KabalaEventCfg[eventId].oilCost
	local prePlot = self.KabalaEventCfg[eventId].prePlot
	local isDelete = self.KabalaEventCfg[eventId].isDelete
	local showRes = self.KabalaEventCfg[eventId].showRes
	local offset
	local scaleInMap = 1
	local smallRes = self.KabalaEventCfg[eventId].showRes
	if self.KabalaformCfg[formID] then
		showRes = self.KabalaformCfg[formID].mapActorIcon
		offset = self.KabalaformCfg[formID].offset
		scaleInMap = self.KabalaformCfg[formID].scaleMap
		smallRes = self.KabalaformCfg[formID].miniMapIcon
	end

	--灯塔的特殊处理
	if formID == 7 and (not eventValid) then
		showRes = "ui/kabalatree/event/floor_spot_2.png"
		smallRes = "ui/kabalatree/event/small_spot_2.png"
	end
	return eventType,showRes,smallRes,offset,scaleInMap,eventParam,eventText,oilCost,prePlot,isDelete
end

--获取事件前置剧情
function KabalaTreeDataMgr:getTileEventPreStory(eventId)

	if not self.KabalaEventCfg[eventId] then
		return
	end

	return self.KabalaEventCfg[eventId].prePlot
end

function KabalaTreeDataMgr:getEventCfg(eventId)

	if not self.KabalaEventCfg[eventId] then
		return
	end

	return self.KabalaEventCfg[eventId]
end

function KabalaTreeDataMgr:isEffectHero(heroId)

	local worldCfg = self.KabalaWorldCfg[self.curWorldId]
	for k,v in ipairs(worldCfg.pollutionHero) do
		if v == heroId then
			return true
		end
	end
	return false
end

--判断英雄是否在阵型列表中
function KabalaTreeDataMgr:beInFormation(heroId)

	local selectRoleid = HeroDataMgr:getHeroRoleId(heroId);
	local index = 0
	local formation = self:getFormation()
	for k,v in pairs(formation) do
		local roleId = HeroDataMgr:getHeroRoleId(v);
		if roleId == selectRoleid then
			index =  k
			break
		end
	end
	return index
end

--初始英雄感染度
function KabalaTreeDataMgr:setHeroInfection(infectionTab)

	if not self.infections then
		return
	end

	infectionTab = infectionTab or {}
	for k,v in pairs(infectionTab) do
		self.infections[v.heroId] = v.infection
	end
end

--返回英雄感染度
function KabalaTreeDataMgr:getInfectionsByHeroId(heroId)

	return self.infections[heroId] or 0,self.pollution.max,self.pollution.fighting
end

--返回出生点
function KabalaTreeDataMgr:getBirthPostion()
	return self.birthPos or ccp(0,0)
end

function KabalaTreeDataMgr:getCurWorld()
	return self.curWorldId
end

function KabalaTreeDataMgr:getWorldCfg(worldId)
	return self.KabalaWorldCfg[worldId]
end

--返回地图信息
function KabalaTreeDataMgr:getMapInfo()
	return self.mapInfo
end

--获得地图任务信息
function KabalaTreeDataMgr:getMapMission()
	return self.missions or {}
end

--返回背包信息
function KabalaTreeDataMgr:getBag()
	return self.bagitems or {}
end

--返回阵型信息
function KabalaTreeDataMgr:getFormation()
	return self.formation or {}
end

--返回卡巴拉币
function KabalaTreeDataMgr:getKabalaCoin()

	local haveNum = GoodsDataMgr:getItemCount(570101)
	if haveNum < 0 then
		haveNum = 0
	end
	return haveNum or 0
end

--得到能量值
function KabalaTreeDataMgr:getEnergy()
	if self.qliphothEnergy and self.qliphothEnergy < 0 then
		self.qliphothEnergy = 0
	end
	return self.qliphothEnergy or 0
end

function KabalaTreeDataMgr:getMaxEnergy()
	return self.MaxEnergy
end

function KabalaTreeDataMgr:cleanMapEvent(pos)
	if not self.mapInfo[pos] then
		return
	end
	self.mapInfo[pos].event = 0
	self.mapInfo[pos].visual = false
end

--设置地图信息
function KabalaTreeDataMgr:setMapInfo(mapInfo)

	self.mapInfo = {}
	self.initHiddenEventInfo = {}
	for k,v in pairs(mapInfo) do
		local pos = v.x .."-"..v.y
		self.mapInfo[pos] = v
		if v.event > 0 then
			self:setStatisticsData(v.event)
			self:initHiddenEvent(v.event)
		end
	end
end

--刷新地图信息
function KabalaTreeDataMgr:updateMapInfo(mapInfo)

	if not self.mapInfo then
		return
	end

	for k,v in pairs(mapInfo) do
		local pos = v.x .."-"..v.y
		self.mapInfo[pos] = v
	end

	for k,v in pairs(self.mapInfo) do
		if v.event > 0 then
			self:setStatisticsData(v.event)
		end
	end
end

--得到格子上的事件ID
function KabalaTreeDataMgr:getEventId(tilePosMN)

	local pos = tilePosMN.x .."-"..tilePosMN.y
	if not self.mapInfo[pos] then
		return
	end

	return self.mapInfo[pos].event,self.mapInfo[pos].eventValid
end

function KabalaTreeDataMgr:isOpen(tilePosMN)

	local pos = tilePosMN.x .."-"..tilePosMN.y
	if not self.mapInfo[pos] then
		return false
	end
	return self.mapInfo[pos].visual
end

function KabalaTreeDataMgr:setRandomFightFlag(flag)
	self.fallRandomFight = flag
end

function KabalaTreeDataMgr:getRandomFightFlag()
	return self.fallRandomFight
end

function KabalaTreeDataMgr:getFightResult()
	return self.isWin
end

function KabalaTreeDataMgr:overKabalaFight(isWin_)

	self.isWin = isWin_
end

function KabalaTreeDataMgr:getFinalTaskDesc(missionId)

	if not self.KabalaWorldCfg[self.curWorldId] then
		return
	end

	if missionId == self.KabalaWorldCfg[self.curWorldId].finalMission then
		return self.KabalaWorldCfg[self.curWorldId].finalTaskDesc
	end
end

function KabalaTreeDataMgr:isBossTask(missionId)
	if not self.KabalaWorldCfg[self.curWorldId] then
		return
	end

	if missionId == self.KabalaWorldCfg[self.curWorldId].finalMission then
		return true
	end
end

function KabalaTreeDataMgr:getMissionStage(missionId)

	if not self.KabalaWorldCfg[self.curWorldId] then
		return
	end

	local missionParam = self.KabalaWorldCfg[self.curWorldId].missionParam
	for stage,stageMissions in ipairs(missionParam) do
		for k,taskid in ipairs(stageMissions) do
			if missionId == taskid then
				local missionType = self.KabalaMissionCfg[missionId].missionType
				return stage,missionType
			end
		end
	end
end

function KabalaTreeDataMgr:getTaskStageDesc(taskStageId)

	if not self.KabalaWorldCfg[self.curWorldId] then
		return
	end

	local desc = self.KabalaWorldCfg[self.curWorldId].taskDesc[taskStageId]
	return desc
end

--获取第一次进入质点世界的剧情ID
function KabalaTreeDataMgr:getFirstPlot()
	return self.firstPlot
end

function KabalaTreeDataMgr:setFirstPlot()
	self.firstPlot = nil
end

--战斗失败播放
function KabalaTreeDataMgr:getFailedPlotId()

	local failedPlot = self.KabalaWorldCfg[self.curWorldId].failedPlot
	if not failedPlot then
		return
	end

	return failedPlot
end

function KabalaTreeDataMgr:isFinishStageTask()
	return self.isCompleteStage
end

function KabalaTreeDataMgr:setFinishStageTask()
	self.isCompleteStage = false
end

function KabalaTreeDataMgr:getStepPlot()
	return self.stepPlot
end

function KabalaTreeDataMgr:setStepPlot()
	self.stepPlot = nil
end

function KabalaTreeDataMgr:showTaskAward()
	if self.taskAwardList and next(self.taskAwardList) then
		self.KabalaTreeAwardInst = Utils:openView("kabalaTree.KabalaTreeAward",self.taskAwardList)
	end
	self.taskAwardList = nil
end


function KabalaTreeDataMgr:getCurWorldId()
	return self.curWorldId
end

function KabalaTreeDataMgr:isInWorld()
	return self.inWorldFlag
end

function KabalaTreeDataMgr:setInWorldFage(inWorldFlag)
	self.inWorldFlag = inWorldFlag
end

function KabalaTreeDataMgr:getKabalaTreeAwardInst()
	return self.KabalaTreeAwardInst
end

function KabalaTreeDataMgr:setKabalaTreeAwardInst(awardInst)
	self.KabalaTreeAwardInst = awardInst
end

--获取新开启的格子
function KabalaTreeDataMgr:getNewOpenTitled()
	return self.newOpenTitled
end

function KabalaTreeDataMgr:clearNewOpenTitled()
	self.newOpenTitled = {}
end

function KabalaTreeDataMgr:isNewOpenTitled(titlePosMN)

	if not self.newOpenTitled then
		return
	end

	for k,v in pairs(self.newOpenTitled) do
		if titlePosMN.x == v.x and titlePosMN.y == v.y then
			return true
		end
	end
	return false
end

--返回据点坐标，只能在战斗占领据点后返回场景使用
function KabalaTreeDataMgr:getStronghold()
	return self.stronghold
end

function KabalaTreeDataMgr:clearStronghold()
	self.stronghold = nil
end

function KabalaTreeDataMgr:getScanCost()

	if not self.KabalaWorldCfg[self.curWorldId] then
		return 0
	end
	return self.KabalaWorldCfg[self.curWorldId].scanCost
end

--设置终极任务完成与否
function KabalaTreeDataMgr:setBosstaskState(isFinish)
	self.finishBossTask = isFinish
end

function KabalaTreeDataMgr:isFinishBossTask()

	return self.finishBossTask
end

function KabalaTreeDataMgr:getFinalPlot()

	if not self.curWorldId or not self.KabalaWorldCfg[self.curWorldId] then
		return 0
	end
	return self.KabalaWorldCfg[self.curWorldId].finalPlot
end

function KabalaTreeDataMgr:openCgView(moduleName, ...)
    local fullModuleName = string.format("lua.logic.%s", moduleName)
    local view = requireNew(fullModuleName):new(...)
    AlertManager:addLayer(view,AlertManager.BLOCK_CLOSE)
    AlertManager:show()
    return view
end

function KabalaTreeDataMgr:setFightViewFlag(flag)
	self.openFightView = flag
end

function KabalaTreeDataMgr:getFightViewFlag()
	return self.openFightView
end

function KabalaTreeDataMgr:getOpenTime()
    return self.startTime_, self.endTime_
end

function KabalaTreeDataMgr:isFunctionOpen()
    local serverTime = ServerDataMgr:getServerTime()
    local isOpen = serverTime >= self.startTime_ and serverTime < self.endTime_
    return isOpen
end

function KabalaTreeDataMgr:openKabalaTree()
	Utils:openView("kabalaTree.KabalaTreeMainView")
	--[[
	屏蔽卡巴拉开始的动画
	local playerId = MainPlayer:getPlayerId()
	local isPlayed = UserDefalt:getBoolForKey("KabalaCg"..playerId)
	if not isPlayed then
		UserDefalt:setBoolForKey("KabalaCg"..playerId,true)
	    UserDefalt:flush()
        DatingDataMgr:startDating(9101001)
	end
	]]
end

function KabalaTreeDataMgr:setSkipRandomMonsterFlag(skipMonster)
	self.skipMonster = skipMonster
	self:saveSkipRandomMonsterFlag()
end

function KabalaTreeDataMgr:getSkipRandomMonsterFlag()

	if not self.skipMonster then
		local id = MainPlayer:getPlayerId() or ""
	    local value = UserDefalt:getStringForKey("SkipRandomMonster"..id)
	    self.skipMonster = tonumber(value)
	    if not self.skipMonster then
	    	self.skipMonster = 1
	    end
	end
	return self.skipMonster
end

function KabalaTreeDataMgr:saveSkipRandomMonsterFlag()

	if not self.skipMonster then
		self.skipMonster = 1
	end

	local id = MainPlayer:getPlayerId() or ""
	self.skipMonster = UserDefalt:setStringForKey("SkipRandomMonster"..id,self.skipMonster)
	UserDefalt:flush()
end

--获得统计数据
function KabalaTreeDataMgr:setStatisticsData(eventId)

	local curMapStatisticData = self.statistics[self.curWorldId]
	if not curMapStatisticData then
		return
	end

	local eventCfg = self.KabalaEventCfg[eventId]
	if not eventCfg then
		return
	end

	local eventType = eventCfg.eventType
	if eventType and self.mergeType[eventType] then
		local data = {}
		local mergeEventID = self.mergeType[eventType].eventId
		local cfgData = self.mergeType[eventType].cfgData
		if not self.statisticsData[mergeEventID] then
			self.statisticsData[mergeEventID] = {cfgData = cfgData,count = 0,remainCount = 0,isCount = false,res = eventCfg.showRes}
		end
		self.statisticsData[mergeEventID].count = self.statisticsData[mergeEventID].count + 1
	else

		for k,v in ipairs(curMapStatisticData) do

			if eventId == v.eventID and v.isMerge == false then
				if not self.statisticsData[eventId] then
					self.statisticsData[eventId] = {cfgData = v,count = v.count,remainCount = 0,isCount = v.isCount,res = eventCfg.showRes}
				end
				self.statisticsData[eventId].remainCount = self.statisticsData[eventId].remainCount + 1
			end
		end
	end

end

function KabalaTreeDataMgr:updateStatisticsData(eventId)

	if not self.statisticsData[eventId] then
		return
	end

	self.statisticsData[eventId].remainCount = self.statisticsData[eventId].remainCount - 1
end

function KabalaTreeDataMgr:getStatisticsData()
	return self.statisticsData
end

function KabalaTreeDataMgr:getmapCid()
	return self.mapCid
end

function KabalaTreeDataMgr:getEventRefreshTime()
	return self.eventRefresh
end

function KabalaTreeDataMgr:setExploredPoints(points)

	if not points then
		return
	end

	self.exploredPoints = {}
	for k,v in ipairs(points) do
		local point = v.x.."-"..v.y
		self.exploredPoints[point] = ccp(v.x,v.y)
	end
end

function KabalaTreeDataMgr:isExploredPoint(point)

	if not self.exploredPoints then
		return
	end

	point = point.x.."-"..point.y
	return self.exploredPoints[point]
end

function KabalaTreeDataMgr:getTimeInfo(worldId)

	if not self.treeOpenTime[worldId] then
		return
	end

	return self.treeOpenTime[worldId]
end

--buffCid:和道具表一致
function KabalaTreeDataMgr:getBuffCfgInfo(buffCid)
	return self.KabalabuffCfg[buffCid]
end

function KabalaTreeDataMgr:getTimeBuffs()
	return self.timeBuff or {}
end

function KabalaTreeDataMgr:getPermanentBuffs()
	return self.permanentBuff or {}
end

function KabalaTreeDataMgr:getKabalaBuffs()
	return self.allBuff or {}
end

function KabalaTreeDataMgr:getNewBuffs()
	return self.newBuffs
end

function KabalaTreeDataMgr:clearNewBuffs()
	self.newBuffs = nil
end

function KabalaTreeDataMgr:updateKabalaBuff(buff,ct)

	if not buff then
		return
	end

	self.timeBuff = {}				--时效性buff
	self.permanentBuff = {}			--永久buff
	if not self.allBuff then
		self.allBuff = {}
	end
	if ct == 0 then
		self.allBuff = buff
	elseif ct == 1 then
		for k,v in ipairs(buff) do
			table.insert(self.allBuff,v)
		end
	elseif ct == 2 then
		for k,v in ipairs(buff) do
			for i=#self.allBuff,1,-1 do
				if self.allBuff[i].buffCid == v.buffCid then
					table.remove(self.allBuff,i)
				end
			end
		end
	end
	dump(self.allBuff)
	table.sort(self.allBuff,function (a,b)
		return a.begining > b.begining
	end)

	for k,v in ipairs(self.allBuff) do
		local cfgInfo = self:getBuffCfgInfo(v.buffCid)
		if cfgInfo then
			if cfgInfo.timerType == 1 then
				table.insert(self.permanentBuff,{itemId = v.buffCid,begining = v.begining,itemNum = v.useCount})
			elseif cfgInfo.timerType == 2 then
				local cnt = cfgInfo.timerTypeParam - v.useCount
				if cnt > 0 then
					table.insert(self.timeBuff,{itemId = v.buffCid,begining = v.begining,itemNum = cnt})
				end
			end
		end
	end
end

function KabalaTreeDataMgr:getDiscoverTaskPos()
	return self.discoverTaskPos
end

--刷出隐藏事件，但是未触发不会有进度同步
function KabalaTreeDataMgr:initHiddenEvent(eventId)

	local cfg = self.KabalaEventCfg[eventId]
	if not cfg then
		return
	end

	if cfg.isHidden then
		self.initHiddenEventInfo[eventId] = 0
	end

end

function KabalaTreeDataMgr:getInitHiddenEvent()
	return self.initHiddenEventInfo
end

function KabalaTreeDataMgr:setHiddenEventInfo(eventInfo)

	self.hiddenEventInfo = {}
	if not eventInfo then
		return
	end
	dump(eventInfo)
	for k,v in ipairs(eventInfo) do
		self.hiddenEventInfo[v.eventCid] = v.progress
	end

end


function KabalaTreeDataMgr:getHiddenEventInfo()
	return self.hiddenEventInfo or {}
end

--隐藏事件
function KabalaTreeDataMgr:updateHiddenEventInfo(points)
	dump(points)
	self.hiddenEventPoints = {}
	for k,v in pairs(points) do
		local tilePosX,tilePosY = v.x,v.y
		if v.event > 0 then
			local eventCfg = self:getEventCfg(v.event)
			if eventCfg and eventCfg.isHidden then
				table.insert(self.hiddenEventPoints,v)
			end
		end
	end
end

function KabalaTreeDataMgr:getHiddenEventPoints()
	return self.hiddenEventPoints
end

function KabalaTreeDataMgr:getHiddenEventPointsByIndex(index)
	dump(self.hiddenEventPoints)
	if not self.hiddenEventPoints then
		return
	end
	return self.hiddenEventPoints[index]
end

function KabalaTreeDataMgr:clearHiddenEventPoints()
	self.hiddenEventPoints = nil
end

function KabalaTreeDataMgr:getKabalaGameCfg(gameCid)
	return self.kabalaGameCfg[gameCid]
end


---------------------------------- 消 息 反 馈 -----------------------------

function KabalaTreeDataMgr:onReplyPerformEvent()

end

--卡巴拉树的基本信息
function KabalaTreeDataMgr:onRecvKabalaTreeInfo(event)

	local data = event.data
	if not data then
		return
	end

	local openWorldCid = data.openWorldCid
	local missionComplete = data.missionComplete
	self.qliphothCoin = data.qliphothCoin 					--卡巴拉代币
	self.qliphothEnergy = data.qliphothEnergy 				--能量值

	self.treeOpenTime = {}
	local worldTimes = data.worldTimes
	for k,info in ipairs(worldTimes) do
		local tab = {}
		tab.beginTime = info.begining
		tab.endTime = info.endTime
		tab.beSoon = info.beSoon
		self.treeOpenTime[info.worldCid] = tab
	end

	if data.firstUse then

	end
	EventMgr:dispatchEvent(EV_UPDATE_RESOURCE)
    EventMgr:dispatchEvent(EV_GET_TREE_INFO,openWorldCid,missionComplete)
end

--kabala世界信息
function KabalaTreeDataMgr:onRecvKabalaWorldInfo(event)

	local data = event.data
	if not data then
		return
	end
	self.statisticsData = {}
	self.curWorldId =  data.worldCid 											--世界Id
	self.birthPos = ccp(data.currentX,data.currentY) 							--当前坐标
	self.bagitems = data.items 													--道具背包列表
	self.missions = data.missions 												--任务列表
	self:setMapInfo(data.points) 												--地图信息
	self.formation = data.formation 											--阵营信息
	self.infections = {}
	self:setHeroInfection(data.infections) 										--英雄感染度
	self.qliphothCoin = data.qliphothCoin 										--卡巴拉代币
	self.qliphothEnergy = data.qliphothEnergy 									--能量值
	self.firstUse = data.firstUse
	self.mapCid = data.mapCid 													--地图ID
	self.eventRefresh = data.eventRefresh 										--地图事件刷新倒计时
	self:setExploredPoints(data.exploredPoints) 								--以探索的点

	self.allBuff = {}
	self.timeBuff = {}				--时效性buff
	self.permanentBuff = {}			--永久buff
	if data.buffs then
		self:updateKabalaBuff(data.buffs.buffs,data.buffs.ct)					--kabalabuff
	end

	self.discoverTaskPos = nil
	if data.foundLocation then
		self.discoverTaskPos = ccp(data.foundLocation.x,data.foundLocation.y)	--发现任务坐标
	end
	self.hiddenEventInfo = {}
	if data.hiddenEvents then
		self:setHiddenEventInfo(data.hiddenEvents.events)									--隐藏事件
	end

	local worldNameID = self.KabalaWorldCfg[self.curWorldId].worldName
	if self.firstUse then
		self.firstPlot = self.KabalaWorldCfg[self.curWorldId].startPlot
	end
	EventMgr:dispatchEvent(EV_UPDATE_RESOURCE)
	if not self:isInWorld() then
		EventMgr:dispatchEvent(EV_GET_WORLD_INFO,worldNameID)
	end
	EventMgr:dispatchEvent(EV_GET_MINIMAP)
end

--刷新地图数据
function KabalaTreeDataMgr:onRecvUpdateMap(event)

	local data = event.data
	if not data then
		return
	end

	self.statisticsData = {}
	self:updateMapInfo(data.points)

	EventMgr:dispatchEvent(EV_UPDATE_WORLD_INFO,data.points)
end

--刷新卡巴拉随机事件
function KabalaTreeDataMgr:onRefreshRandomEvent(event)

	local data = event.data
	if not data then
		return
	end
	self.eventRefresh = data.eventRefresh
	self.statisticsData = {}
	self:updateMapInfo(data.points)
	self:updateHiddenEventInfo(data.points)
	dump(data.points)

	EventMgr:dispatchEvent(EV_UPDATE_RANDOMEVENT)
	EventMgr:dispatchEvent(EV_UPDATE_WORLD_INFO,data.points)

end

--更新世界状态(同步世界关闭和开启)
function KabalaTreeDataMgr:onRecvUpdateWorld(event)

	local data = event.data
	if not data then
		return
	end

	local openWorldCid = data.treeInfo.openWorldCid
	local missionComplete = data.treeInfo.missionComplete
	self.qliphothCoin = data.treeInfo.qliphothCoin 					--卡巴拉代币
	self.qliphothEnergy = data.treeInfo.qliphothEnergy 				--能量值

	EventMgr:dispatchEvent(EV_UPDATE_RESOURCE)
	EventMgr:dispatchEvent(EV_UPDATE_TREE_INFO,openWorldCid,missionComplete,data.openStatus)
end

--玩家移动
function KabalaTreeDataMgr:onRecvPlayerMove(event)

	local data = event.data
	if not data then
		return
	end

	if data.event == 0 then
		local originalEventId = 0
		if  self.mapInfo[data.x.."-"..data.y] then
			originalEventId = self.mapInfo[data.x.."-"..data.y].event
			self.mapInfo[data.x.."-"..data.y].event = 0
		end
		EventMgr:dispatchEvent(EV_CLEAR_TILEDITEM,ccp(data.x,data.y),originalEventId)
	end

	EventMgr:dispatchEvent(EV_FUNC_MOVE,ccp(data.x,data.y),data.foundPoints)
end

--移动触发事件
function KabalaTreeDataMgr:onRecvTriggerEvent(event)

	local data = event.data
	if not data then
		return
	end

	EventMgr:dispatchEvent(EV_TRIGGER_EVENT,data.eventId,ccp(data.x,data.y))
end

--阵营信息
function KabalaTreeDataMgr:onRecvFormationInfo(event)

	local data = event.data
	if not data then
		return
	end
	self.formation = data.formation
	EventMgr:dispatchEvent(EV_UPDATE_FORMATION)
end

--背包信息
function KabalaTreeDataMgr:onRecvItemBag(event)

	local data = event.data
	if not data then
		return
	end
	dump("xxxx")
	self.bagitems = data.items
	EventMgr:dispatchEvent(EV_UPDATE_KABALABAG)
end

--任务信息
function KabalaTreeDataMgr:onRecvMissionInfo(event)

	local data = event.data
	if not data then
		return
	end
	self.missions = data.missions
	if not self.missions[1] then
		return
	end
	local id = self.missions[1].missionId
	if not data.completed then
		EventMgr:dispatchEvent(EV_UPDATE_KABALATASK,false)
		return
	end

	if not self.KabalaWorldCfg[self.curWorldId] then
		EventMgr:dispatchEvent(EV_UPDATE_KABALATASK,false)
		return
	end

	--检测是否是终极任务
	if id == self.KabalaWorldCfg[self.curWorldId].finalMission then

		local finalPlot = self.KabalaWorldCfg[self.curWorldId].finalPlot
		KabalaTreeDataMgr:setBosstaskState(true)
		if finalPlot ~= 0 then
			if self:isInWorld() then
				EventMgr:dispatchEvent(EV_UPDATE_KABALATASK,true,finalPlot)
			end
		end
		return
	end

	local stage = self:getMissionStage(id)
	if not stage then
		EventMgr:dispatchEvent(EV_UPDATE_KABALATASK,false)
		return
	end

	local stepPlot = self.KabalaWorldCfg[self.curWorldId].stepPlot[stage]
	if not stepPlot then
		EventMgr:dispatchEvent(EV_UPDATE_KABALATASK,false)
		return
	end

	self.isCompleteStage = true
	self.stepPlot = stepPlot
	if self:isInWorld() then
		EventMgr:dispatchEvent(EV_UPDATE_KABALATASK,true,self.stepPlot)
	end
end

--感染度情况
function KabalaTreeDataMgr:onRecvHeroEffect(event)

	local data = event.data
	if not data then
		return
	end

	self:setHeroInfection(data.infections)

	EventMgr:dispatchEvent(EV_UPDATE_HERO_INFECTION)
end

--能量值情况
function KabalaTreeDataMgr:onRecvKabalaEnergy(event)

	local data = event.data
	if not data then
		return
	end
	self.qliphothEnergy = data.qliphothEnergy
	EventMgr:dispatchEvent(EV_UPDATE_RESOURCE)
end

--卡巴拉coin(精华)
function KabalaTreeDataMgr:onRecvKabalaCoin(event)

	local data = event.data
	if not data then
		return
	end
	self.qliphothCoin = data.qliphothCoin
	EventMgr:dispatchEvent(EV_UPDATE_RESOURCE)
end

--伏击事件
function KabalaTreeDataMgr:onRecvRandomAttack(event)

	local data = event.data
	if not data or not self.curWorldId then
		return
	end

	local skip = self:getSkipRandomMonsterFlag()
    if skip and skip == 2 then
        return
    end

	self:setRandomFightFlag(true)
	local costEnergy = self.KabalaWorldCfg[self.curWorldId].ambushCost
	EventMgr:dispatchEvent(EV_TRIGGER_RANDOM_ATTACK,data.ambushId,costEnergy)
end

--传送
function KabalaTreeDataMgr:onRecvTransport(event)

	local data = event.data
	if not data then
		return
	end
	EventMgr:dispatchEvent(EV_TRIGGER_TRANSPORT,ccp(data.currentPoint.x,data.currentPoint.y),data.currentPoint.foundPoints)
end

--商店信息
function KabalaTreeDataMgr:onRecvShopInfo(event)

	local data = event.data
	if not data then
		return
	end
	EventMgr:dispatchEvent(EV_QLIPHOTH_SHOP_INFO,data.produces,data.nextRefresh)
	EventMgr:dispatchEvent(EV_UPDATE_STORE,data.produces,data.nextRefresh)
end

--使用背包道具
function KabalaTreeDataMgr:onRecvUseBagItem(event)

	local data = event.data
	if not data then
		return
	end

	local itemCfg = GoodsDataMgr:getItemCfg(data.items[1].itemId)
	local itemType = itemCfg.subType
	if itemType == Enum_KabalaItemType.ItemType_Buff or itemType == Enum_KabalaItemType.ItemType_BuffItem then
		return
	end

	Utils:showTips(3005019)
end

--拾取道具
function KabalaTreeDataMgr:onRecvEventItem(event)

	local data = event.data
	if not data then
		return
	end

	local allitems = data.items
	if not allitems then
		return
	end

	-- 道具
	local awardList = {}
    if allitems.items then
    	for k, v in pairs(allitems.items) do
            table.insert(awardList,{id = v.cid,num = v.num})
        end
    end

    if allitems.equipments then
    	for k, v in pairs(allitems.equipments) do
           table.insert(awardList,{id = v.cid,num = v.num})
        end
    end

    if allitems.dresss then
        for k, v in pairs(allitems.dresss) do
           table.insert(awardList,{id = v.cid,num = v.num})
        end
    end

    self.KabalaTreeAwardInst = Utils:openView("kabalaTree.KabalaTreeAward",awardList)

    --[[local eventId = 0
    if  self.mapInfo[data.x.."-"..data.y] then
     	eventId = self.mapInfo[data.x.."-"..data.y].event
 	end
    EventMgr:dispatchEvent(EV_CLEAR_TILEDITEM,ccp(data.x,data.y),eventId)]]

end

--完成任务
function KabalaTreeDataMgr:onRecvFinishTask(event)

	local data = event.data
	if not data then
		return
	end

	local allitems = data.items
	if not allitems then
		return
	end

	local awardList = {}
    if allitems.items then
    	for k, v in pairs(allitems.items) do
            table.insert(awardList,{id = v.cid,num = v.num})
        end
    end

    if allitems.equipments then
    	for k, v in pairs(allitems.equipments) do
           table.insert(awardList,{id = v.cid,num = v.num})
        end
    end

    if allitems.dresss then
        for k, v in pairs(allitems.dresss) do
           table.insert(awardList,{id = v.cid,num = v.num})
        end
    end

    self.taskAwardList = awardList
    if self:isInWorld() then
		self.KabalaTreeAwardInst = Utils:openView("kabalaTree.KabalaTreeAward",awardList)
	end
end

--指定点探索反馈
function KabalaTreeDataMgr:onRecvSearchTarget(event)

	local data = event.data
	if not data then
		return
	end
	self:setSearchResult(data.result)
	if data.result then
		self:setExploredPoints(data.exploredPoints)
	end
    EventMgr:dispatchEvent(EV_SEARCH_RESULT,data.result)
end

function KabalaTreeDataMgr:onRecvBuyItem(event)

	local data = event.data
    if not data then
        return
    end

    local reward = {}
    for k,v in ipairs(data.rewardItems) do
        table.insert(reward,{id = v.itemId,num = v.itemNum})
    end
    self.KabalaTreeAwardInst = Utils:openView("kabalaTree.KabalaTreeAward",reward)
    EventMgr:dispatchEvent(EV_UPDATE_STORE,data.produces)
end

function KabalaTreeDataMgr:onRecvTime(event)
    local data = event.data
    if not data then return end
    dump(data)
    self.startTime_ = data.startTime
    self.endTime_ = data.endTime
end

function KabalaTreeDataMgr:onRecvCurBuffs(event)

	local data = event.data
	if not data then return end
	dump(data)

	self:updateKabalaBuff(data.buffs,data.ct)
	--ct：1 新增 2：删除
	if data.ct == 1 then
		self.newBuffs = {}
		self.newBuffs = data.buffs
		--[[if self:isInWorld() then
			Utils:openView("kabalaTree.KabalaTreeAwardBuff",data.buffs[1].buffCid)
		end]]
	end

	EventMgr:dispatchEvent(EV_UPDATE_KABALABUFF,data.ct)

end

function KabalaTreeDataMgr:onRecvDisCoverTask(event)

	local data = event.data
	if not data then return end
	if data.add then
		self.discoverTaskPos = ccp(data.x,data.y)
	else
		self.discoverTaskPos = nil
	end
	EventMgr:dispatchEvent(EV_DISCOVER_TASK,data.add)
end

function KabalaTreeDataMgr:onRecvHiddenEvents(event)
	local data = event.data
	if not data then return end
	self:setHiddenEventInfo(data.events)
	EventMgr:dispatchEvent(EV_UPDATE_HIDDENEVENT)

end

function KabalaTreeDataMgr:onRecvHiddenRewwards(event)

	local data = event.data
	if not data then return end

	local allitems = data.items
	if not allitems then
		return
	end

	local awardList = {}
	if allitems.items then
		for k, v in pairs(allitems.items) do
			table.insert(awardList,{id = v.cid,num = v.num})
		end
	end

	if allitems.equipments then
		for k, v in pairs(allitems.equipments) do
			table.insert(awardList,{id = v.cid,num = v.num})
		end
	end

	if allitems.dresss then
		for k, v in pairs(allitems.dresss) do
			table.insert(awardList,{id = v.cid,num = v.num})
		end
	end

	self.taskAwardList = awardList
	if self:isInWorld() then
		self.KabalaTreeAwardInst = Utils:openView("kabalaTree.KabalaTreeAward",awardList)
	end
end

--触发卡巴拉小游戏
function KabalaTreeDataMgr:onTriggerGameEvent(event)

	local data = event.data
	if not data then return end

	EventMgr:dispatchEvent(EV_TRRIGGER_MINIGAME,data)
end

--卡巴拉小游戏回复
function KabalaTreeDataMgr:onReplyGameInfo(event)

	local data = event.data
	if not data then return end
	local allitems = data.items
	if not allitems then
		return
	end
	dump(data)

	local awardList = {}
	if allitems.items then
		for k, v in pairs(allitems.items) do
			table.insert(awardList,{id = v.cid,num = v.num})
		end
	end

	if allitems.equipments then
		for k, v in pairs(allitems.equipments) do
			table.insert(awardList,{id = v.cid,num = v.num})
		end
	end

	if allitems.dresss then
		for k, v in pairs(allitems.dresss) do
			table.insert(awardList,{id = v.cid,num = v.num})
		end
	end

	EventMgr:dispatchEvent(EV_REPLY_MINIGAME,data.gameCid,awardList,data.options)
end

function KabalaTreeDataMgr:checkVersion()

	local oldVersion = self:getOldVersion()
	local newVersionId = self:getKabalaVersion()
	local isNewVersion = newVersionId ~= oldVersion
	print("newVersionId",newVersionId)
	if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 and isNewVersion then
		local fullPath = me.FileUtils:fullPathForFilename("titledmap/kabalamap/"..oldVersion)
		local newPath = string.gsub(fullPath,"titledmap/kabalamap/"..oldVersion,"titledmap/kabalamap/"..newVersionId)
		print(fullPath,newPath)
		os.rename(fullPath,newPath)
	end
end

function KabalaTreeDataMgr:getKabalaVersion()
	local version = 0
	for mapCid,info in pairs(self.KabalaServerDataCfg) do
		version = info.version
		break
	end
	return tostring(version)
end

function KabalaTreeDataMgr:getOldVersion()
	local path = me.FileUtils:fullPathForFilename("titledmap/kabalamap")
	local fileName
	for file in lfs.dir(path) do
		if file ~= "." and file ~= ".." then
			fileName = file
			break
		end
	end
	return fileName
end


return KabalaTreeDataMgr:new()
