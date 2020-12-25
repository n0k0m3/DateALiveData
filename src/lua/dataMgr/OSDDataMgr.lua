local OSDEnum     = require("lua.logic.osd.OSDEnum")
local OSDConnector= require("lua.logic.osd.OSDConnector")
local OSDControl  = require("lua.logic.osd.OSDControl")
local enum        = require("lua.logic.battle.enum")
local eDir        = enum.eDir
local HeroType    = OSDEnum.HeroType
local ErrorCode   = OSDEnum.ErrorCode
local BaseDataMgr = import(".BaseDataMgr")
local OSDDataMgr = class("OSDDataMgr", BaseDataMgr)

function OSDDataMgr:init()
	self:initData()
	--副本数据
	TFDirector:addProto(s2c.NEW_WORLD_RES_NEW_WORLD_MISSION_INFO, self, self.onRecvNewWorldMissionInfo)
	--上次未完成组队战结果
    TFDirector:addProto(s2c.NEW_WORLD_RES_ENTER_REWARD_MISSION, self, self.onRecvEnterMissionRsp)
	--悬赏令使用记录
    TFDirector:addProto(s2c.NEW_WORLD_RES_REWARD_MISSION_RECORD, self, self.onRecvHuntingInvitationRecord)
    --悬赏令组队战结果推送
    TFDirector:addProto(s2c.NEW_WORLD_RES_REWARD_MISSION_RESULT, self, self.onRecvMissionResult)
    
end

function OSDDataMgr:initData()
	local datas   =  TabDataMgr:getData("modlePos")
	self.modelPos = {}
	for k,v in pairs(datas) do
		self.modelPos[v.name] = v
	end
	self.npcCfgMap = TabDataMgr:getData("Npc")
	self.chatInfoList = {}
	self:reset()
end

function OSDDataMgr:getModelPos(model)
	local data = self.modelPos[model]
	if data then 
		return ccp(data.xPos,data.yPos)
	end
	return ccp(0,200)
end
function OSDDataMgr:getNpcCfg(npcId )
	return self.npcCfgMap[npcId]
end

function OSDDataMgr:clearChatInfoList()
	self.chatInfoList = {}
	ChatDataMgr:clearBigWorldData()
end

function OSDDataMgr:getChatInfoList()
	return self.chatInfoList
end

function OSDDataMgr:transData(data,heroType)
	local ret  = {}
	ret.heroType = heroType
	ret.funcType = 0
	ret.pos         = ccp(0, 0)
	ret.dir         = eDir.RIGHT
	ret.bornEffect  = false
	ret.moveSpeed   = 340  --移动速度
	ret.actionIndex = 0
	ret.skinCid     = 0
	ret.unionName   = ""
	ret.quickName   = ""
	ret.allowShadow = true
	ret.titleId     = 0
	if heroType == HeroType.MainHero or heroType == HeroType.OtherHero  then 
		ret.pid        = data.pid
		ret.id         = data.heroCid
		ret.name       = data.pname
		ret.level      = data.level
		ret.skinCid     = data.skinCid
		ret.unionName  = data.unionName or ""
		ret.showCountry = data.showCountry
		ret.country = data.country
		ret.titleId     = data.titleId or 0
		if data.pos then 
			ret.pos    = ccp(data.pos.x,data.pos.y)
			ret.dir    =  data.dir 
		end
	    local skinData = TabDataMgr:getData("HeroSkin", ret.skinCid)
	    local formData = TabDataMgr:getData("HeroForm", skinData.beginForm)
	    
	    ret.actionIndex  = formData.actionIndex
		ret.model      = formData.model
		ret.scale      = 0.6 * formData.modelSize
		ret.bornEffect = true    --是否播放出生特效
          --是否播放出生特效
	elseif heroType == HeroType.NPC then
		ret.id         = data.id
		ret.pid        = data.id
		ret.name       = data.name
		ret.level      = 1
	    ret.model      = data.model
		ret.scale      = 0.6 * data.modelSize
		ret.funcType   = data.funcType
		ret.dir        = data.initDir or eDir.RIGHT
		ret.quickName  = data.quickName
		ret.headIcon  = data.headIcon
		ret.allowShadow = data.allowShadow
		if data.pos then 
			ret.pos    = ccp(data.pos.x,data.pos.y)
		end
	end
	return ret
end

function OSDDataMgr:getRoomID()
	return self.serverInfo.roomID or "1"
end

function OSDDataMgr:getMaxRoomID()
	return TabDataMgr:getData("DiscreteData",81006).data.roomNum
end

function OSDDataMgr:reset()
    self.serverInfo = {}
end

--登出的处理
function OSDDataMgr:onLoginOut()
    self:reset()
end

--登录时需要做的操作
function OSDDataMgr:onLogin()
    self:sendRspChapterInfo()
end

function OSDDataMgr:onEnterMain()
    
end

----------------------------





function OSDDataMgr:handlePreEnter(data)
	print("-----------------handlePreEnter-------------------")
	print(data)
	local host = self.serverInfo.host
	local port = self.serverInfo.port
	self.serverInfo.roomID    = data.roomId  --房间ID
	self.serverInfo.host      = data.fightServerHost --地址
	self.serverInfo.port      = data.fightServerPort --端口

	-- 清理场上玩家
	-- 玩家数据(未显示的玩家)
	OSDControl:clearHeroQueue()
	OSDControl:clearOtherPlayers()
	--清除聊天记录
	self:clearChatInfoList()
	--服務器地址和端口没有改变的情况下不需要断开连接直接发送切换场景的请求
	if host == self.serverInfo.host and port == self.serverInfo.port and OSDConnector:isConnected() then 
		self:sendEnterNewWord()
	else
		OSDConnector:close()
		--尝试连接到服务器
		OSDConnector:connect(self.serverInfo)
	end
	--刷新房间号
	EventMgr:dispatchEvent(EV_OSD.EV_REFRESH_OSDROOM)
end
--同屏错误码
-- enum.ErrorCode =
-- {
--   E_240024     = 240024	,--组队提示信息	您正在进入多人场景中																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																													
--   E_240025     = 240025	,--组队提示信息	房间不存在！																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																													
--   E_240026     = 240026	,--组队提示信息	房间人数已满，请重新尝试。																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																													
--   E_240027     = 240027	,--组队提示信息	你已经处于该场景中。																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																													
--   E_240028     = 240028	,--组队提示信息	连接出现异常，请稍后再试！																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																													
--   E_240029     = 240029	,--组队提示信息	处于异常的多人场景中，请稍后再试！		
-- }

--TODO 连接超时处理	？？？？																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																						
--错误码处理
function OSDDataMgr:doError(errorCode)
	if errorCode == ErrorCode.E_240025
	or errorCode == ErrorCode.E_240026
	or errorCode == ErrorCode.E_240028
	or errorCode == ErrorCode.E_240029 then
		--退出同屏场景
		EventMgr:dispatchEvent(EV_OSD.EV_LEAVE)
	end  
	OSDConnector.showTips(errorCode)
end

--聊天数据
function OSDDataMgr:onRevChatInfo(event)
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

--返回大世界游戏服地址
function OSDDataMgr:onRevPreEnterNewWord(event)
	if event.errorCode ~= 0 then
		self:doError(event.errorCode)
		return 
	end
	-- local data = event.data
	print("--------------onRevPreEnterNewWord---------------------")
	-- print(data)
	-- self.serverInfo.roomID    = data.roomId  --房间ID
	-- self.serverInfo.host      = data.fightServerHost --地址
	-- self.serverInfo.port      = data.fightServerPort --端口
	-- OSDConnector:close()
	-- --尝试连接到服务器
	-- OSDConnector:connect(self.serverInfo)
	-- --刷新房间号
	-- EventMgr:dispatchEvent(EV_OSD.EV_REFRESH_OSDROOM)
	self:handlePreEnter(event.data)
end


--[[
	[1] = {--ResEnterNewWorld
		[1] = {--repeated AreaPlayerInfo
			[1] = 'int32':pid	[ 玩家ID]
			[2] = 'string':pname	[ 玩家昵称]
			[3] = 'int32':level
			[4] = 'int32':heroCid
			[5] = 'int32':skinCid
			[6] = 'int32':unionId
			[7] = 'string':unionName
			[8] = {--AreaPlayerPos
				[1] = 'int32':x
				[2] = 'int32':y
				[3] = 'int32':dir
			},
		},
	}
--]]

--判断是否是自己
function OSDDataMgr:isMe(pid)
	return pid  == MainPlayer:getPlayerId()
end

--进入大世界
function OSDDataMgr:onRevEnterNewWord(event)
	if event.errorCode ~= 0 then
		self:doError(event.errorCode)
		return 
	end
	local data = event.data
	print("--------------onRevEnterNewWord---------------------")
	local playerInfos = data.playerInfos
	-- print(data)
	for i, playerInfo in ipairs(playerInfos) do
		if self:isMe(playerInfo.pid) then
			--更新自己的信息
		else
			local _data = self:transData(playerInfo,HeroType.OtherHero)
			OSDControl:addHeroData(_data)
		end
	end
	--登录
	local mainHero = OSDControl:getMainHero()
	if mainHero then 
		local pos = mainHero:getPosition()
		WorldRoomDataMgr:sendPositionChange(pos,1)
	end

end

--玩家位置同步
function OSDDataMgr:onRevSyncAreaPlayerPos(event)
	if event.errorCode ~= 0 then
		self:doError(event.errorCode)
		return 
	end
	local data = event.data
	-- print("--------------onRevSyncAreaPlayerPos---------------------")
	-- print(data)
	for i , playerInfo  in ipairs(data.playerInfos) do
		OSDControl:syncHeroPos(playerInfo)
	end	
end
--[[
	[1] = {--ResChangeAppearance
		[1] = 'int32':pid	[ 玩家ID]
		[2] = 'int32':heroCid
		[3] = 'int32':skinCid
	}
--]]
--玩家换装
function OSDDataMgr:onRevChangeAppearance(event)
	if event.errorCode ~= 0 then
		self:doError(event.errorCode)
		return 
	end
	local data = event.data
	print("--------------onRevChangeAppearance---------------------")
	-- print(data)
	OSDControl:changeSkin(data)
end

--[[
	[1] = {--ResAreaPlayerEnter
		[1] = {--AreaPlayerInfo
			[1] = 'int32':pid	[ 玩家ID]
			[2] = 'string':pname	[ 玩家昵称]
			[3] = 'int32':level
			[4] = 'int32':heroCid
			[5] = 'int32':skinCid
			[6] = 'int32':unionId
			[7] = 'string':unionName
			[8] = {--AreaPlayerPos
				[1] = 'int32':x
				[2] = 'int32':y
				[3] = 'int32':dir
			},
		},
	}
--]]

--玩家进入大世界
function OSDDataMgr:onRevAreaPlyerEnter(event)
	if event.errorCode ~= 0 then
		self:doError(event.errorCode)
		return 
	end
	local data = event.data
	print("--------------onRevAreaPlyerEnter---------------------")
	local playerInfo = data.playerInfo
	-- print(playerInfo)
	if self:isMe(playerInfo.pid) then
		--更新自己的信息
	else
		local _data = self:transData(playerInfo,HeroType.OtherHero)
		OSDControl:addHeroData(_data)
	end
end
--[[
	[1] = {--ResAreaPlayerLeave
		[1] = 'int32':pid
	}
--]]
--玩家离开场景
function OSDDataMgr:onRevAreaPlayerLeave(event)
	if event.errorCode ~= 0 then
		self:doError(event.errorCode)
		return a
	end
	local data = event.data
	print("--------------onRevAreaPlayerLeave---------------------")
	if MainPlayer:getPlayerId() == data.pid then --自己俩开大世界
		EventMgr:dispatchEvent(EV_OSD.EV_LEAV)
	else--其他玩家来开大世界
		OSDControl:removeHero(data.pid)
	end
end



function OSDDataMgr:onRevChangeRoom(event)
	print("--------------onRevChangeRoom---------------------")
	if event.errorCode ~= 0 then
		self:doError(event.errorCode)
		return 
	end

	self:handlePreEnter(event.data)

	-- --断开战斗服服务器
	-- OSDConnector:close()
end

-- 返回大世界游戏关卡任务数据
function OSDDataMgr:onRecvNewWorldMissionInfo(event)
	local data = event.data
	self.chapterInfoList = data
	EventMgr:dispatchEvent(EV_OSD.EV_REFRESH_CHAPTERINFO)
end




-- --进入同屏或者切线获取同屏玩家信息
-- function OSDDataMgr:onRecvAllPlayersInfo(event)
-- 	local data = event.data
-- 	print("[OSDDataMgr:onRecvAllPlayersInfo]")
-- 	if not data then return end
-- 	self.roomId    = data.roomId
-- 	self.maxRoomNum = data.roomIdMax
-- 	self.isInOSD = true
-- 	if data.type == 0 then
-- 		--进场景
-- 		OSDControl:enterOSD(data.playerInfo)
-- 	else
-- 		--切线
-- 		EventMgr:dispatchEvent(EV_REFRESH_OSDROOM)
-- 	end

-- 	OSDControl:clearHeroQueue()
-- 	for k, v in ipairs(data.playerInfo or {}) do
-- 		OSDControl:addHeroData(v, true)
-- 	end
-- end

-- --玩家信息变化推送
-- function OSDDataMgr:onRecvPlayerChangeInfo(event)
-- 	local data = event.data
-- 	if not data then return end
-- 	for k, v in ipairs(data.playerInfo or {}) do
-- 		OSDControl:updateHeroData(v)
-- 	end
-- end

-- --玩家离开推送
-- function OSDDataMgr:onRecvPlayerLeave(event)
-- 	local data = event.data
--     for k, v in ipairs(data.pid) do
--         OSDControl:removeHero(v)
--     end
-- end

-- --自己离开成功回包
-- function OSDDataMgr:onRecvSelfLeave(event)
-- 	self.isInOSD = false
-- end

-- --进入房间返回
-- function OSDDataMgr:onRecvEnterRoom(event)
-- 	local data = event.data
-- end



------------------------------------------------------------

function OSDDataMgr:sendChatInfo(content)
	TFDirector:send(c2s.NEW_WORLD_REQ_NEW_WORLD_CHAT,{content})
end
--请求大世界游戏服的信息(游戏服)
function OSDDataMgr:sendPreEnterNewWord()
	TFDirector:send(c2s.NEW_WORLD_REQ_PRE_ENTER_NEW_WORLD,{WorldRoomType.OSD_WORLD})
end

--请求换装(向游戏服发送)
function OSDDataMgr:sendChangeApperance(heroId,skinId)
	local content = 
	{
		heroId,
		tostring(skinId)
	}
	TFDirector:send(c2s.NEW_WORLD_REQ_CHANGE_APPEARANCE,content)
end


--请求离开大世界
function OSDDataMgr:sendLeave()
	print("--------------sendLeave------------------")
	-- local content = {}
	-- OSDConnector:send(c2s.NEW_WORLD_REQ_LEVE_NEW_WORLD,content)
end

--请求切换房间
function OSDDataMgr:sendChangeRoom(roomId)
	print("--------------sendChangeRoom------------------",roomId)
	local content = {roomId, WorldRoomType.OSD_WORLD}
	TFDirector:send(c2s.NEW_WORLD_REQ_CHANGE_NEW_WORLD_ROOM,content)
end

--请求进入帮会房间
function OSDDataMgr:sendChangeRoomToUnion()
	local content = {WorldRoomType.OSD_UNION}
	TFDirector:send(c2s.NEW_WORLD_REQ_ENTER_UNION_ROOM,content)
end

--请求关卡数据
function OSDDataMgr:sendRspChapterInfo()
	TFDirector:send(c2s.NEW_WORLD_REQ_NEW_WORLD_MISSION_INFO,{})
end



------------------------------------------------------------

function OSDDataMgr:getChapterInfo( chapterId )
	self.chapterInfoList = self.chapterInfoList or {}
	if self.chapterInfoList.chapterInfo then
		for k,v in pairs(self.chapterInfoList.chapterInfo) do
			if v.chapter == chapterId then
				return v
			end
		end
	end
	return {}
end

function OSDDataMgr:checkDungeonIsPass( dungeonId )
	self.chapterInfoList = self.chapterInfoList or {}
	if self.chapterInfoList.passedMission then
		return table.find(self.chapterInfoList.passedMission,dungeonId) ~= -1
	else
		return false
	end
end

function OSDDataMgr:checkDungeonHasFirtReward( dungeonId )
	self.chapterInfoList = self.chapterInfoList or {}
	if self.chapterInfoList.firstPassedMission then 
		return table.find(self.chapterInfoList.firstPassedMission,dungeonId) == -1 -- 有就是没有首通奖励
	else
		return true
	end
end

function OSDDataMgr:getDungeonFirtRewardFlushTime(  )
	self.chapterInfoList = self.chapterInfoList or {}
	return self.chapterInfoList.endTime or 0 
end

function OSDDataMgr:getDungeonFightCount( dungeonId )
	self.chapterInfoList = self.chapterInfoList or {}
	local count = 0
	if self.chapterInfoList.chapterInfo then
		for i,chapterInfo in pairs(self.chapterInfoList.chapterInfo) do
			for k,v in pairs(chapterInfo.mission) do
				if v.dungeonId == dungeonId then
					count = v.fightCount
				end
			end
		end
	end
	return count
end

--请求进入大世界
function OSDDataMgr:sendEnterNewWord()
	local content = 
	{
		self:getRoomID(),
		MainPlayer:getPlayerId()
	}
	OSDConnector:send(c2s.NEW_WORLD_REQ_ENTER_NEW_WORLD,content)
	--设置正式秘钥
	OSDConnector:setEncodeKeys(OSDConnector.EncodeKeys)
end

function OSDDataMgr:sendEnterHuntingInvitation(  ) --上次组队战结果
	TFDirector:send(c2s.NEW_WORLD_REQ_ENTER_REWARD_MISSION,{})
end

function OSDDataMgr:onRecvEnterMissionRsp( event ) --上次组队战结果
    local data = event.data
    if not data then
		Utils:openView("osd.HuntingInvitationView")
        return
    end
    local isFighting = data.isFighting
    if isFighting then
        Utils:showTips(240032)
        return
    end
    self.isShowResult = data.isShowResult
    self.isWin = data.isWin
    self.reward = data.rewards

	Utils:openView("osd.HuntingInvitationView")
end

function OSDDataMgr:showLastTeamFightResult()
	if not self.isShowResult then return end
	if self.isWin then
		if #table.keys(self.reward) > 0 then
			Utils:showReward(self.reward)
		else
        	Utils:showTips(240034)
		end
	else
        Utils:showTips(240033)
	end

    self.isShowResult = nil
    self.isWin = nil
    self.reward = nil
end

function OSDDataMgr:onRecvHuntingInvitationRecord( event )
	
    local data = event.data
    if not data then
        return
    end

    self.huntingInvitationRecord = {}
    self.huntingInvitationRecord.day = {} 
    for k,v in pairs(data.dayRecord) do
    	self.huntingInvitationRecord.day[v.difficulty] = v.count
    end

    self.huntingInvitationRecord.week = {} 
    for k,v in pairs(data.weekRecord) do
    	self.huntingInvitationRecord.week[v.difficulty] = v.count
    end

    EventMgr:dispatchEvent(EV_OSD.HUNTING_INVITATION_RECORD)
end

function OSDDataMgr:getHuntingInvitationCount( diff, isDay)
	if not self.huntingInvitationRecord then return 0 end
	if isDay then
		return self.huntingInvitationRecord.day[diff] or 0
	end

	return self.huntingInvitationRecord.week[diff] or 0
end

function OSDDataMgr:onRecvMissionResult( event )
	-- body 
	local data = event.data
    if not data then
        return
    end
    if data.result then
    	Utils:showTips(240035)
    else
    	Utils:showTips(240036)
    end
end

function OSDDataMgr:checkLevelEntranceRedState() -- 副本入口红点
	-- body
	local canChallenge = false
	self.chapterInfoList = self.chapterInfoList or {}
	local count = 0
	if self.chapterInfoList.chapterInfo then
		for i,chapterInfo in pairs(self.chapterInfoList.chapterInfo) do
			if chapterInfo.isOpen then
				for k,v in pairs(chapterInfo.mission) do
					local dungeonCfg = TabDataMgr:getData("HighTeamDungeon",v.dungeonId)
					local enough = true
					if dungeonCfg.rewardTime > 0 then
						local rewardCount = math.max(0,dungeonCfg.rewardTime - v.fightCount)
						if rewardCount == 0 then
							enough = false
						end
					end

					if #table.keys(dungeonCfg.joinCost) > 0  then
						local key = table.keys(dungeonCfg.joinCost)[1]
						local value = dungeonCfg.joinCost[key]
						if GoodsDataMgr:getItemCount(key) < value then
							enough = false
						end
					end
					if enough then
						canChallenge = true
						return canChallenge
					end
				end
			end
		end
	end
	return canChallenge
end

function OSDDataMgr:checkHuntingInvitationRedState( )
	local list = GoodsDataMgr:getItemsBySuperTyper(EC_ResourceType.HUNTINGINVITATIONCARD)
	return #list > 0
end

return OSDDataMgr:new()
