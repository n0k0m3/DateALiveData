--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
* -- 大世界数据管理器
]]

local OSDEnum     = require("lua.logic.osd.OSDEnum")
local ErrorCode   = OSDEnum.ErrorCode
local OSDConnector= require("lua.logic.osd.OSDConnector")
local WorldRoomDataMgr = class("WorldRoomDataMgr",BaseDataMgr)

function WorldRoomDataMgr:ctor()
 	-- body
 	self:initData()
 	--大世界服信息
	TFDirector:addProto(s2c.NEW_WORLD_RES_PRE_ENTER_NEW_WORLD, self, self.onRevPreEnterNewWord ,false)
	--进入大世界
	TFDirector:addProto(s2c.NEW_WORLD_RES_ENTER_NEW_WORLD, self, self.onRevEnterNewWord,false)
	--玩家位置同步
	TFDirector:addProto(s2c.NEW_WORLD_SYNC_AREA_PLAYER_POS, self, self.onRevSyncAreaPlayerPos,false)
	--玩家换装
	TFDirector:addProto(s2c.NEW_WORLD_RES_CHANGE_APPEARANCE,self,self.onRevChangeAppearance,false)
	--玩家进入大世界
	TFDirector:addProto(s2c.NEW_WORLD_RES_AREA_PLAYER_ENTER,self,self.onRevAreaPlyerEnter,false)
	--玩家离开场景
	TFDirector:addProto(s2c.NEW_WORLD_RES_AREA_PLAYER_LEAVE, self, self.onRevAreaPlayerLeave,false)
	--聊天消息
	TFDirector:addProto(s2c.NEW_WORLD_RES_NEW_WORLD_CHAT, self, self.onRevChatInfo)
	--切换房间
	TFDirector:addProto(s2c.NEW_WORLD_RES_CHANGE_NEW_WORLD_ROOM, self, self.onRevChangeRoom)
	--切换房间
	TFDirector:addProto(s2c.NEW_WORLD_RES_ENTER_UNION_ROOM, self, self.onRevChangeRoom)
	-- 游戏服操作返回
	TFDirector:addProto(s2c.NEW_WORLD_RESP_WORLD_OPERATE, self, self.onRevGameServerOperateRsp)
	-- npc数据即时刷新
	TFDirector:addProto(s2c.NEW_WORLD_WORLD_ROOM_DECORATE, self, self.onRevDecorateUpdate)
	-- 同步服操作返回
	TFDirector:addProto(s2c.NEW_WORLD_RESP_FIGHT_WORLD_OPERATE, self, self.onRevWorldRoomOperate)
	-- npc数据定时刷新
	TFDirector:addProto(s2c.NEW_WORLD_RESP_SYNC_FIGHT_WORLD_DECORATE, self, self.onRevSyncRoomData)
	-- npc数据定时刷新
	TFDirector:addProto(s2c.NEW_WORLD_RESP_WORLD_RELEVANT_DATA, self, self.onRevWorldRelevantData)
	-- npc数据定时刷新
	TFDirector:addProto(s2c.NEW_WORLD_RESP_AREA_SHOW_TIME, self, self.onRevWorldShowTimes)

	TFDirector:addProto(s2c.NEW_WORLD_RESP_AREA_SHOW_DATA, self, self.onRevAreaShowData)

end

function WorldRoomDataMgr:reset()
    self:initData()
end

function WorldRoomDataMgr:onLogin( ... )
	-- body
	TFDirector:send(c2s.NEW_WORLD_REQ_WORLD_RELEVANT_DATA,{1})
	return {c2s.NEW_WORLD_REQ_WORLD_RELEVANT_DATA}
end

--连接到大世界服务器
function WorldRoomDataMgr:connectServer()
	OSDConnector:connect(self.serverInfo)
end

function WorldRoomDataMgr:closeConnection()
	OSDConnector:close()
end
--连接大世界服务器成功
function WorldRoomDataMgr:onConnected()
	print("连接成功请求计入大世界",self.tmproomType)
	if not self.tmproomType or self.tmproomType == 1 or self.tmproomType == 2 then
		OSDDataMgr:sendEnterNewWord()
	else 
		self:sendEnterNewWord()
	end
end

--连击大世界服务器失败
function WorldRoomDataMgr:onConnectError()
	print("连接大世界服务器失败")
	hideLoading()
	EventMgr:dispatchEvent(EV_OSD.EV_LEAVE)
end


function WorldRoomDataMgr:initData( ... )
	-- body
	self.serverInfo = {}
	self.roomType = nil
	self.controlerMap = self.controlerMap or {}
	self.extDataControlerMap = self.extDataControlerMap or {}
end

function WorldRoomDataMgr:getControlByRoomType(roomType )
	-- body
	if not self.controlerMap[roomType] then
		if roomType == WorldRoomType.ZNQ_WORLD or roomType == WorldRoomType.ZNQ_UNION then -- 两个管理器使用统一对象
			local control = require("lua.logic.2020ZNQ.AmusementPackControl"):new()
			self.controlerMap[roomType] = control
			-- self.controlerMap[WorldRoomType.ZNQ_UNION] = control
		end
	end

	return self.controlerMap[roomType]
end

function WorldRoomDataMgr:getExtDataControlByType(roomType )
	-- body
	if not self.extDataControlerMap[roomType] then
		if roomType == WorldRoomType.ZNQ_WORLD or roomType == WorldRoomType.ZNQ_UNION then -- 两个管理器使用统一对象
			local control = require("lua.logic.2020ZNQ.AmusementPackDataControl"):new()
			self.extDataControlerMap[WorldRoomType.ZNQ_WORLD] = control
			self.extDataControlerMap[WorldRoomType.ZNQ_UNION] = control
		end
	end

	return self.extDataControlerMap[roomType]
end

function WorldRoomDataMgr:onRevPreEnterNewWord( event )
	-- body
	local data = event.data
	if data.roomType == 0 then
		Utils:showTips(205014)
		return 
	end
	self.tmproomType = data.roomType
	if not data.roomType or data.roomType == WorldRoomType.OSD_WORLD or data.roomType == WorldRoomType.OSD_UNION then
		OSDDataMgr:onRevPreEnterNewWord(event)
	else
		self:handlePreEnter(data)
	end
end

function WorldRoomDataMgr:handlePreEnter(data)

	print("-----------------handlePreEnter1-------------------")
	print(data)
	local host = self.serverInfo.host
	local port = self.serverInfo.port
	self.serverInfo.roomID    = data.roomId  --房间ID
	self.serverInfo.host      = data.fightServerHost --地址
	self.serverInfo.port      = data.fightServerPort --端口
	
	--服務器地址和端口没有改变的情况下不需要断开连接直接发送切换场景的请求
	OSDConnector:close()

	local mapCfg = TabDataMgr:getData("WorldMap",data.roomType)
	OSDConnector:setReconnectCount(mapCfg.netReconnectCount)
	OSDConnector:setHeartBeatDeal(mapCfg.heartBeatDeal)
	--尝试连接到服务器
	OSDConnector:connect(self.serverInfo)
	showLoading()
	--刷新房间号
	EventMgr:dispatchEvent(EV_OSD.EV_REFRESH_OSDROOM)
end

function WorldRoomDataMgr:clearChatInfoList()
	self.chatInfoList = {}
	ChatDataMgr:clearBigWorldData()
end

function WorldRoomDataMgr:getChatInfoList()
	return self.chatInfoList
end

function WorldRoomDataMgr:onRevEnterNewWord( event )
	local data = event.data
	if event.errorCode ~= 0 then
		self:doError(event.errorCode)
		return 
	end

	self.roomType = data.roomType
	if not data.roomType or data.roomType == WorldRoomType.OSD_WORLD or data.roomType == WorldRoomType.OSD_UNION then
		OSDDataMgr:onRevEnterNewWord(event)
	else
		local controler = self:getControlByRoomType(data.roomType)
		

		controler:initData()
		local mapCfg = TabDataMgr:getData("WorldMap",data.roomType)
		if mapCfg then
			controler:setMapInfo(mapCfg.mapResource)
			controler:setModelScale(mapCfg.modelScale)
			controler:setMoveSpeed(mapCfg.moveSpeed)
			controler:setMaxPlayerNumInScene(mapCfg.syncPlayerNum)
			controler:setBornPos(mapCfg.bornPos)
			controler:setCameraFixZ(mapCfg.cameraScope)
			if mapCfg.cameraSlowMoveSpeed then
				controler:setCameraSlowMoveDel(mapCfg.cameraSlowMoveSpeed / 1000)
			end

			if mapCfg.synPosTime then
				controler:setSynPosTime(mapCfg.synPosTime / 1000)
			end

			if mapCfg.whiteModel == "" then
				mapCfg.whiteModel = nil
			end
			controler:setGhost(mapCfg.whiteModel)

			if mapCfg.playerInterActions then
				controler:setPlayerInterActions(mapCfg.playerInterActions)
			end
		end
		--清除聊天记录
		self:clearChatInfoList()
		local data = event.data
		print("--------------onRevEnterNewWord---------------------")
		local playerInfos = data.playerInfos
		for i, playerInfo in ipairs(playerInfos) do
			controler:updateActorData(playerInfo)
		end

		local roomDecorate = data.roomDecorate or {}

		for i, roomInfo in ipairs(roomDecorate) do
			roomInfo.isCanClear = true
			controler:updateActorData(roomInfo)
		end
		controler:deriveData()
		controler:enterRoom()
	end
end

function WorldRoomDataMgr:onRevSyncAreaPlayerPos( event )
	-- body
	local data = event.data
	if not data.roomType or data.roomType == WorldRoomType.OSD_WORLD or data.roomType == WorldRoomType.OSD_UNION then
		OSDDataMgr:onRevSyncAreaPlayerPos(event)
	else
		local controler = self:getControlByRoomType(data.roomType)
		local data = event.data
		if not data then return end
		-- print("--------------onRevSyncAreaPlayerPos---------------------")
		-- print(data)
		for i , playerInfo  in ipairs(data.playerInfos) do
			controler:syncHeroPos(playerInfo)
		end	
	end
end

function WorldRoomDataMgr:onRevChangeAppearance( event )
	-- body
	local data = event.data
	if not data.roomType or data.roomType == WorldRoomType.OSD_WORLD or data.roomType == WorldRoomType.OSD_UNION then
		OSDDataMgr:onRevChangeAppearance(event)
	else
		local controler = self:getControlByRoomType(data.roomType)

		local data = event.data
		print("--------------onRevChangeAppearance---------------------")
		-- print(data)
		controler:changeSkin(data)
	end
end

function WorldRoomDataMgr:onRevAreaPlyerEnter( event )
	local data = event.data
	if not data.roomType or data.roomType == WorldRoomType.OSD_WORLD or data.roomType == WorldRoomType.OSD_UNION then
		OSDDataMgr:onRevAreaPlyerEnter(event)
	else
		local controler = self:getControlByRoomType(data.roomType)
		local data = event.data
		print("--------------onRevAreaPlyerEnter---------------------")
		local playerInfo = data.playerInfo
		controler:updateActorData(playerInfo)
		controler:deriveData()
	end
end

function WorldRoomDataMgr:onRevAreaPlayerLeave( event )
	local data = event.data
	if not data.roomType or data.roomType == WorldRoomType.OSD_WORLD or data.roomType == WorldRoomType.OSD_UNION then
		OSDDataMgr:onRevAreaPlayerLeave(event)
	else
		local controler = self:getControlByRoomType(data.roomType)
		local data = event.data
		print("--------------onRevAreaPlayerLeave---------------------")
		if MainPlayer:getPlayerId() == data.pid then --自己俩开大世界
			EventMgr:dispatchEvent(EV_OSD.EV_LEAVE)
		else--其他玩家来开大世界
			controler:removeActorDataByPid(data.pid)
			controler:deriveData()
		end
	end
end

function WorldRoomDataMgr:onRevChatInfo( event )
	-- body
	local data = event.data
	if not data.roomType or data.roomType == WorldRoomType.OSD_WORLD or data.roomType == WorldRoomType.OSD_UNION then
		OSDDataMgr:onRevChatInfo(event)
	else
		-- local controler = self:getControlByRoomType(data.roomType)
		local data = event.data
		data.channel = EC_ChatType.BIG_WORLD
		data.fun     = 1
		local event  = {} 
		event.data = data
		ChatDataMgr:onRecvChatInfo(event)
		table.insert(self.chatInfoList,data)
		if #self.chatInfoList > 2 then 	
			table.remove(self.chatInfoList,1)
		end
		EventMgr:dispatchEvent(EV_OSD.CHATINFO_ADD,data)
	end
end

function WorldRoomDataMgr:onRevChangeRoom( event )
	if event.errorCode ~= 0 then
		self:doError(event.errorCode)
		return 
	end
	local data = event.data
	if not data.roomType or data.roomType == WorldRoomType.OSD_WORLD or data.roomType == WorldRoomType.OSD_UNION then
		self.roomType = data.roomType
		OSDDataMgr:onRevChangeRoom(event)
	else
		self:handlePreEnter(data)
	end
end

function WorldRoomDataMgr:onRevGameServerOperateRsp( event )
	-- body
	local data = event.data

	if not data.roomType or data.roomType == WorldRoomType.OSD_WORLD or data.roomType == WorldRoomType.OSD_UNION then
	else
		local extData = json.decode(data.ext)
		if extData.reward then
			Utils:showReward(extData.reward)
		end
	end
end

function WorldRoomDataMgr:onRevDecorateUpdate( event )
	local data = event.data
	if not data.roomType or data.roomType == WorldRoomType.OSD_WORLD or data.roomType == WorldRoomType.OSD_UNION then
	else

		local controler = self:getControlByRoomType(data.roomType)
		if data.roomDecorate then
			for k,v in ipairs(data.roomDecorate) do
				if data.ct == EC_SChangeType.DELETE then
					controler:removeActorDataByPid(v.pid)
				else
					v.isCanClear = true
					controler:updateActorData(v)
				end
			end
			controler:deriveData()
		end
	end
end

function WorldRoomDataMgr:onRevWorldRoomOperate( event )
	local data = event.data
	if not data.roomType or data.roomType == WorldRoomType.OSD_WORLD or data.roomType == WorldRoomType.OSD_UNION then
	else
		local controler = self:getControlByRoomType(data.roomType)
		local extData = json.decode(data.ext)
		controler:operateAction(extData)
	end
end

function WorldRoomDataMgr:onRevSyncRoomData(event)
	local data = event.data
	if not data.roomType or data.roomType == WorldRoomType.OSD_WORLD or data.roomType == WorldRoomType.OSD_UNION then
	else
		local controler = self:getControlByRoomType(data.roomType)
		controler:clearServerNpcActorData()
		local roomDecorate = data.roomDecorate or {}
		for i, roomInfo in ipairs(roomDecorate) do
			roomInfo.isCanClear = true
			controler:updateActorData(roomInfo)
		end
		controler:deriveData()
	end
end

function WorldRoomDataMgr:onRevWorldRelevantData( event )
	local data = event.data
	if not data then return end
    self.relevantData = data.relevantData
	if not data.roomType or data.roomType == WorldRoomType.OSD_WORLD or data.roomType == WorldRoomType.OSD_UNION then
	else

		if not data then return end
		local controler = self:getExtDataControlByType(data.roomType)
		controler:parseWorldRelevantData(data)
	end
	EventMgr:dispatchEvent(EV_WORLD_ROOM_EXTDATA_RSP)
end

function WorldRoomDataMgr:onRevWorldShowTimes( event )
	local data = event.data
	if not data.roomType or data.roomType == WorldRoomType.OSD_WORLD or data.roomType == WorldRoomType.OSD_UNION then
	else
		
		if not data then return end
		local controler = self:getExtDataControlByType(data.roomType)
		controler:parseShowTimerData(data)
	end
	EventMgr:dispatchEvent(EV_WORLD_AREA_TIME)
end


function WorldRoomDataMgr:getRoomID()
	return self.serverInfo.roomID or "1"
end

function WorldRoomDataMgr:getRoomType()
	return self.roomType
end


function WorldRoomDataMgr:exitRoom(  )
	-- body
	local controler = self:getControlByRoomType(roomType or self.roomType)
	if controler:exitRoom() then
		self:reset()
    	OSDConnector:close()
	end
end

--请求进入大世界
function WorldRoomDataMgr:sendEnterNewWord()
	local content = 
	{
		self.serverInfo.roomID or "1",
		MainPlayer:getPlayerId()
	}
	OSDConnector:send(c2s.NEW_WORLD_REQ_ENTER_NEW_WORLD,content)
	--设置正式秘钥
	OSDConnector:setEncodeKeys(OSDConnector.EncodeKeys)
end

function WorldRoomDataMgr:doError(errorCode)
	if errorCode == ErrorCode.E_240025
	or errorCode == ErrorCode.E_240026
	or errorCode == ErrorCode.E_240028
	or errorCode == ErrorCode.E_240029 then
		--退出同屏场景
		OSDConnector.showTips(errorCode)
		EventMgr:dispatchEvent(EV_OSD.EV_LEAVE)
	end  
end

--发送角色移动消息
function WorldRoomDataMgr:sendPositionChange(pos,dir)
	if self.inColding then return end
	local curdt = self:getWorldRoomUpdateTotalDt()
	local content = { math.floor(pos.x) , math.floor(pos.y) ,math.floor(dir), math.floor(curdt*1000)}
	-- print("OSDDataMgr:sendPositionChange" ,content)
	OSDConnector:send(c2s.NEW_WORLD_REQ_POSITION_CHANGE,content)
end

function WorldRoomDataMgr:sendChangeRoom(roomId, roomType)
	local content = {roomId, roomType}
	TFDirector:send(c2s.NEW_WORLD_REQ_CHANGE_NEW_WORLD_ROOM,content)
end
--请求进入帮会房间
function WorldRoomDataMgr:sendChangeRoomToUnion(roomType)
	local content = {roomType}
	TFDirector:send(c2s.NEW_WORLD_REQ_ENTER_UNION_ROOM,content)
end

function WorldRoomDataMgr:sendReqRelevantData(roomType)
	local content = {roomType}
	TFDirector:send(c2s.NEW_WORLD_REQ_WORLD_RELEVANT_DATA,content)
end

function WorldRoomDataMgr:worldRoomOperateByType( type, obj )
	-- body
	obj.roomId = self:getRoomID() or "1"
	obj.roomType = self.roomType
	obj.pid = obj.pid and tostring(obj.pid) or nil
	local string = json.encode(obj)
	TFDirector:send(c2s.NEW_WORLD_REQ_WORLD_OPERATE,{type, string} )
end

function WorldRoomDataMgr:setColdingState( isColding )
	-- body
	self.inColding = isColding
end

function WorldRoomDataMgr:getCurControl( )
	-- body
	if self.roomType then
		return self:getControlByRoomType(self.roomType)
	end
	return nil
end

function WorldRoomDataMgr:getCurExtDataControl( )
	-- body
	if self.roomType then
		return self:getExtDataControlByType(self.roomType)
	end
	return nil
end

function WorldRoomDataMgr:getRoomIDRange(roomType)
	-- body
	local mapCfg = TabDataMgr:getData("WorldMap",roomType)

	return mapCfg.worldRoomStart + 1, mapCfg.worldRoomStart + mapCfg.param.roomMaxNum
end

function WorldRoomDataMgr:getMaxInterButtonNum( ... )
	-- body
	local mapCfg = TabDataMgr:getData("WorldMap",self.roomType)
	return mapCfg and mapCfg.interButtonNum or 0
end

function WorldRoomDataMgr:getCurWorldSceneName(roomType)
	-- body
	local roomType = roomType or self.roomType
	local sceneName = ""
	if roomType == WorldRoomType.ZNQ_WORLD or roomType == WorldRoomType.ZNQ_UNION then
		sceneName = "AmusementPackScene"
	elseif roomType == WorldRoomType.OSD_WORLD or roomType == WorldRoomType.OSD_UNION then
		sceneName = "BaseOSDScene"
	end
	return sceneName
end

function WorldRoomDataMgr:getRelevantData( ... )
	-- body
	return self.relevantData or {}
end

function WorldRoomDataMgr:Send_GetTouFang()
	TFDirector:send(c2s.NEW_WORLD_REQ_AREA_SHOW_DATA, {self.roomType or WorldRoomType.ZNQ_WORLD})
end

function WorldRoomDataMgr:onRevAreaShowData(event)
	local data = event.data
	if not data then
		return
	end
	EventMgr:dispatchEvent(EV_WORLD_AREA_DATA,data)
end

function WorldRoomDataMgr:setWorldRoomUpdateTotalDt( dt )
	-- body
	self.curdt = dt
end

function WorldRoomDataMgr:getWorldRoomUpdateTotalDt(  )
	-- body
	return self.curdt or 0
end

return WorldRoomDataMgr:new()