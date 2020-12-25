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
* 同屏管理器
* 
]]

local BasicResUtils = import("lua.logic.mmoBasicClass.BasicResUtils")
local BasicControl = class("BasicControl")

function BasicControl:ctor()
	self:initData()
end

function BasicControl:initData()
	--地图信息
	
	--等待添加到舞台上的角色信息
	if not self.actorDataQueue then
		self.actorDataQueue = MEMapArray:new()
	end
	self.actorDataQueue:clear()

	self.mapInfo = nil
	self.mainHero = nil

	--同屏玩家角色列表
	if not self.heroList then
		self.heroList = MEMapArray:new()
	end
	self.heroList:clear()

	--npc列表
	if not self.npcList then
		self.npcList = MEMapArray:new()
	end
	self.npcList:clear()

	--触发的NPC ID
	self.triggerNpcId = 0

	--界面对象
	self.baseView = nil
	self.baseMap = nil
	self.bgmFile = nil

	self.focusNpcs = {}
	self.focusHeros = {}

	self.nSynPosTime = 0.1
	self.nSlowDel = 0.001
	self.playerInterActions = {}
end

function BasicControl:clear()
	self:initData()
end

function BasicControl:registerEvents()
	-- EventMgr:addEventListener(self, EV_OSD.EV_CLICK_HERO_EVENT, handler(self.onClickHero, self))
end

function BasicControl:removeEvents()
	EventMgr:removeEventListenerByTarget(self)
end

function BasicControl:checkInWorldRoomScene()
end

function BasicControl:enterRoom(heroList)
	self:registerEvents()

	self.willEnterScene = true
	-- self.isInWorldRoom = true
	--清楚临时数据避免loading 条显示错误
    BattleDataMgr:clearTempData()
    BasicResUtils:setCollectResListFunc(function ( resUtils )
    	-- body
    	return self:getResList(resUtils)
    end)
	BasicResUtils:loadAllRes(function()
     --    TFAudio.stopAllEffects()
    	-- TFAudio.stopMusic()
    	-- SafeAudioExchangePlay().stopAllBgm()
     --    TFAudio.playMusic(OSDConfig.BGM, true)
        --播放大世界背景音乐
        self.willEnterScene = false
        self:enterScene()
    end)
end

function BasicControl:enterScene()
 	-- body
end

function BasicControl:getResList( resUtils )
	-- body
	return {}
end

function BasicControl:setView(view)
	self.baseView = view
end

function BasicControl:setMap(map)
	self.baseMap = map
end


function BasicControl:updateData(data,newData)
	for k ,v in pairs(newData) do
		data[k] = v
	end
end

--[[-
	加入数据队列，用于创建同屏玩家
	isServerData: 是否为服务器数据
-]]
function BasicControl:updateActorData(actorData)
	local tmpData = self.actorDataQueue:objectByID(actorData.pid)
	if not tmpData then
		-- dump(ActorData)
		-- print("addActorData")
		self.actorDataQueue:pushbyid(actorData.pid, actorData)
	else
		dump(actorData)
		-- print("updateData")
		self:updateData(tmpData , actorData) --更新数据
	end
end

function BasicControl:deriveData( ... )


	for actor in self.actorDataQueue:iterator() do -- 重新整理列表
		if actor.inRoomPid then
			for k,v in pairs(actor.inRoomPid) do
				local _actor = self:getActorDataByPid(v)
				if not _actor or _actor.buildId == -1 or not _actor.buildId then
					actor.inRoomPid[k] = nil
				end
			end
		end
	end

	-- body
	for actor in self.actorDataQueue:iterator() do
		if actor.buildId then
			if actor.buildId == -1 then
				actor.buildId = nil
			else
				local buildIdData = self:getActorDataByPid(actor.buildId)
				if buildIdData then
					buildIdData.inRoomPid = buildIdData.inRoomPid or {}
					if not table.findOne(buildIdData.inRoomPid,function (v)
							return v == actor.pid
						end) then

						local needAdd = true
						for i = 1,table.count(buildIdData.inRoomPid) do
							if not buildIdData.inRoomPid[i] then
								buildIdData.inRoomPid[i] = actor.pid
								needAdd = false
								break
							end
						end
						if needAdd then
							local _id = #buildIdData.inRoomPid + 1
							table.insert(buildIdData.inRoomPid,actor.pid)
						end
					end
				else
					buildIdData = self:createNewEmptyData(actor.buildId)
	                self:updateActorData(buildIdData)
				end
			end
		end
	end
end

function BasicControl:createNewEmptyData( cfgId )
	-- body
	return { pid = cfgId }
end

-- {
 --       ├┄┄skinCid=1103011,
 --       ├┄┄heroCid=110301,
 --       ├┄┄pid=539556324
 --       ├┄┄}
local function _changeSkinData(data , newData)
	if data then
		for k,v in pairs(newData) do
			data[k] = v
		end
	end
end


function BasicControl:changeSkin(newData)
	data = self.actorDataQueue:objectByID(newData.pid)
	_changeSkinData(data,newData)
end

function BasicControl:getFocus()   
    return self.focusNpcs or {}, self.focusHeros or {}
end

function BasicControl:removeActorDataByPid( pid )
	-- body
	self.actorDataQueue:removeById(pid)
end

-- function BasicControl:sortActorData(aData, bData)
-- 	if aData.isFriend then
-- 		if bData.isFriend then
-- 			return aData.pid > bData.pid
-- 		else
-- 			return false
-- 		end
-- 	else
-- 		if bData.isFriend then
-- 			return false
-- 		else
-- 			return aData.pid > bData.pid
-- 		end
-- 	end
-- end

--切线清除当前屏幕显示玩家
function BasicControl:clearNoActorDataNode()
    local tmpRemoveArr = {}
    for hero in self:getHeroList():iterator() do
    	if not hero:isMainHero() then
	    	local actorData = self:getActorDataByPid(hero:getPid())
	        if not actorData then
	            tmpRemoveArr[#tmpRemoveArr + 1] = hero:getPid()
	        end
	    end
    end

    for k, v in ipairs(tmpRemoveArr) do
        self:removeHero(v)
    end

	tmpRemoveArr = {}
    for npc in self:getNPCList():iterator() do
    	local actorData = self:getActorDataByPid(npc:getPid())
        if not actorData then
            tmpRemoveArr[#tmpRemoveArr + 1] = npc:getPid()
        end
    end

    for k, v in ipairs(tmpRemoveArr) do
        self:removeNPC(v)
    end
end


--获取需要加入同屏的角色信息
function BasicControl:getNewActorData()
	if self.actorDataQueue:length() <= 0 then return nil end

	local actorData = self.actorDataQueue:front()
	self.actorDataQueue:removeById(actorData.pid)

	--已在同屏角色中
	if self.heroList:objectByID(actorData.pid) then
		return nil
	end

	return actorData
end

function BasicControl:getActorDataByPid( pid )
	-- body
	return self.actorDataQueue:objectByID(pid)
end

function BasicControl:clearActorQueue()
	if not self.actorDataQueue then
		self.actorDataQueue = MEMapArray:new()
	end
	self.actorDataQueue:clear()
end

function BasicControl:addHero(hero)
	local pid = hero:getPid()
	local tmpHero = self.heroList:objectByID(pid)
	if tmpHero then
		print("fuck hero, the map has wrong hero")
		tmpHero:removeActor()
		self.baseMap:removeActor(tmpHero)
		self.heroList:removeById(pid)
	end
	self.heroList:pushbyid(pid, hero)

	hero:addTo(self.baseMap)
	if hero:isMainHero() then
		self.mainHero = hero
	end
end

function BasicControl:sortHero(aHero, bHero)
	local aData = aHero:getData()
	local bData = bHero:getData()
	return aData.pid > bData.pid
end

function BasicControl:getHeroByPid(pid)
	if not self.heroList then return nil end

	return self.heroList:objectByID(pid)
end

--[[-
	pid
	keeyData: 是否保留数据
-]]
function BasicControl:removeHero(pid, keeyData)
	if not keeyData and self.actorDataQueue:objectByID(pid) then
		self.actorDataQueue:removeById(pid)
	end

	local hero = self.heroList:objectByID(pid)
	if hero then
		self.heroList:removeById(pid)
		self.baseMap:removeActor(hero)
		hero:removeActor()
	end
end

function BasicControl:addNPC(npc)
	local pid = npc:getPid()
	local tmpNpc = self.npcList:objectByID(pid)
	if tmpNpc then
		print("fuck npc, the map has wrong npc")
		self.npcList:removeById(pid)
		self.baseMap:removeActor(tmpNpc)
		tmpNpc:removeActor()
	end
	self.npcList:pushbyid(pid, npc)
	npc:addTo(self.baseMap)
end

function BasicControl:removeNPC(pid)
	local tmpNpc = self.npcList:objectByID(pid)
	if tmpNpc then
		self.npcList:removeById(pid)
		self.baseMap:removeActor(tmpNpc)
		tmpNpc:removeActor()
	end
end

--根据返回同步位置
function BasicControl:syncHeroPos(playerInfo)
	-- if playerInfo.pid ~= MainPlayer:getPlayerId() then
		local actorData = self.actorDataQueue:objectByID(playerInfo.pid)
		if actorData then 
			local pos = playerInfo.pos
			for k,v in pairs(pos) do
				actorData.pos[k] = v
			end
		end
	-- end
	
end

function BasicControl:getMapInfo()
	return self.mapInfo
	-- return "tongpinceshi001"
end

function BasicControl:setMapInfo( mapInfo )
	-- body
	self.mapInfo = mapInfo
end

function BasicControl:getMainHero()
	return self.mainHero
end

function BasicControl:getHeroList()
	return self.heroList
end

--获取除去主角的其他玩家列表
function BasicControl:getSortHeroList()
	local tmpHeroList = MEMapArray:new()
	for hero in self.heroList:iterator() do
        if not hero:isMainHero() then
        	tmpHeroList:pushbyid(hero:getPid(), hero)
        end
    end
	tmpHeroList:sort(handler(self.sortHero, self))
	return tmpHeroList
end

function BasicControl:getNPCList()
	return self.npcList
end

function BasicControl:updateRoles(dt)
    for hero in self:getHeroList():iterator() do
    	local actorData = self:getActorDataByPid(hero:getPid())
        hero:update(dt,actorData)
    end

    for npc in self:getNPCList():iterator() do
    	local actorData = self:getActorDataByPid(npc:getPid())
        npc:update(dt,actorData)
    end
end

--判断是否触发npc功能
function BasicControl:checkIsTriggerNpcFuc()
    local mainHero = self:getMainHero()
    if not mainHero then return end
    self.triggerChange = true
    self.focusNpcs = {}
    for npc in self:getNPCList():iterator() do
        local rect = npc:getNpcRect()
        local pos  = mainHero:getPosition3D()
        if me.rectContainsPoint(rect, pos) then
            table.insert(self.focusNpcs,npc:getPid())
        end
    end
end

--判断是否触发npc功能
function BasicControl:checkIsTriggerPlayerFuc()
    local mainHero = self:getMainHero()
    if not mainHero then return end
    self.triggerChange = true
    self.focusHeros = {}
    for hero in self:getHeroList():iterator() do
    	if hero ~= mainHero then
	        local rect = hero:getNpcRect()
	        local pos  = mainHero:getPosition3D()
	        if me.rectContainsPoint(rect, pos) then
	            table.insert(self.focusHeros,hero:getPid())
	        end
	    end
    end
end

function BasicControl:setMaxPlayerNumInScene( num )
	-- body
	self.syncLimitNum = num
end


function BasicControl:checkInScreen( ... )
	-- body
	self.addPlayerNum = 0
	self.syncLimitNum = self.syncLimitNum or 20 -- 默认同屏20人
	local syncPlayerNumber = 0

	local mainHero = self:getMainHero()
	if mainHero then
		self.actorDataQueue:sort(function(v1, v2)
			local distance1 = me.pGetDistance(mainHero:getPosition(),ccp(v1.pos.x,v1.pos.y))
			local distance2 = me.pGetDistance(mainHero:getPosition(),ccp(v2.pos.x,v2.pos.y))
			if distance1 == distance2 then
				return v1.pid < v2.pid
			else
				return distance1 < distance2
			end
		end)
	end

	for actorData in self.actorDataQueue:iterator() do
		local pos = actorData.pos
		local actorNode = self:getActorNodeByPid(actorData.pid)
		if actorNode then
			pos = actorNode:getPosition()
		end
		local inView = self.baseMap:checkInViewByPos(pos)
		if actorData.skinCid and self.syncLimitNum < syncPlayerNumber and inView and not actorData.buildId then
			inView = false
		elseif actorData.skinCid and inView then --只计算同屏可见的人数
			syncPlayerNumber = syncPlayerNumber + 1
		end

		if actorData.pid == MainPlayer:getPlayerId() then
			inView = true
		end
		-- todo 根据需求决定是否要处理
		self:actorInView(actorData, inView)
	end
end

function BasicControl:actorInView( actorData , inView)
	-- body
	local isHero = actorData.skinCid
	if isHero then
		if self.addPlayerNum > 1 and actorData.pid ~= MainPlayer:getPlayerId() then
			return
		end

		local hero = self:getHeroByPid(actorData.pid)
		if not hero and inView then
			self.addPlayerNum = self.addPlayerNum + 1
			self:createActor(actorData)
		end

		if hero then
			hero:hideSelf(inView)
		end
	else -- npc 逻辑 不做删除
		local npc = self:getNPCList():objectByID(actorData.pid)
		if not npc then
			self:createActor(actorData)
		end
	end
end

function BasicControl:createActor( actorData )
	-- body
	
end

function BasicControl:updateInFrame3( dt )
	-- body
	self:checkInScreen()
end

function BasicControl:updateInFrame6( dt )
	-- body
	self:checkIsTriggerNpcFuc()
	self:checkIsTriggerPlayerFuc()
end

function BasicControl:updateInFrame9( dt )
	-- body
end

function BasicControl:initUpdate( dt )
	-- body
	self:updateInFrame3(dt)
	self:updateInFrame6(dt)
	self:updateInFrame9(dt)
end

function BasicControl:update( dt )
	if self.willEnterScene then 
		return 
	end
	
	if not self.ncount then
		self:initUpdate(dt)
	end

	self:clearNoActorDataNode()
	self:updateRoles(dt)

	if self.ncount == 3 then
		self:updateInFrame3(dt)
	end

	if self.ncount == 6 then
		self:updateInFrame6(dt)
	end

	if self.ncount == 9 then
		self:updateInFrame9(dt)
	end
    self:resetFrameCount(  )
end

function BasicControl:lateUpdate( dt )
	-- body
end

function BasicControl:resetFrameCount( ... )
	-- body
	if not self.ncount or self.ncount >= 10 then
		self.ncount = 1
	else
		self.ncount = self.ncount + 1
	end
end

function BasicControl:getActorNodeByPid( pid )
	-- body
	local actor = self:getHeroByPid(pid)
	actor = actor or self:getNPCList():objectByID(pid)
	return actor
end

function BasicControl:exitRoom( ... )
	-- bodyupdateInFrame9
	if self.willEnterScene then return false end
	self:clearActorQueue()
	self:initData()
	return true
end

function BasicControl:setModelScale( scale )
	-- body
	self.modelScale = scale
end

function BasicControl:setMoveSpeed( speed )
	-- body
	self.baseMoveSpeed = speed
end

function BasicControl:getModelScale( ... )
	-- body
	return self.modelScale or 1
end

function BasicControl:getBaseMoveSpeed( ... )
	-- body
	return self.baseMoveSpeed or 200
end

function BasicControl:operateAction( operateData )
	-- body
	
end

function BasicControl:parseShowTimerData( data )
	-- body
	
end

function BasicControl:parseWorldRelevantData( data )
	-- body
	
end

function BasicControl:getBaseMap( )
	-- body
	return self.baseMap
end

--玩家聊天气泡
function BasicControl:heroTalk(chatInfo)
    --其他玩家的聊天气泡
    local hero = self:getActorNodeByPid(chatInfo.pid)
    if hero then 
        hero:playTalk(chatInfo.content)
    end
end

function BasicControl:clearServerNpcActorData()
	for actorData in self.actorDataQueue:iterator() do
		if actorData.isCanClear then
			self.actorDataQueue:removeById(actorData.pid)
		end
	end
end

function BasicControl:changeMainHeroToBornPos(index)
	
end

function BasicControl:setCurBgm( bgmFile )
	-- body
	self.bgmFile = bgmFile
end

function BasicControl:getCurBgm( ... )
	-- body
	return self.bgmFile
end

function BasicControl:getSynPosTime( ... )
	-- body
	return self.nSynPosTime or 0.1
end

function BasicControl:setBornPos( bornPos )
	-- body
	self.bornPos = bornPos
end

function BasicControl:setCameraFixZ( fixZ )
	-- body
	self.cameraFixZ = fixZ
end

function BasicControl:setCameraSlowMoveDel( dt )
	-- body
	self.nSlowDel = dt
end

function BasicControl:setSynPosTime( dt )
	-- body
	self.nSynPosTime = dt
end

function BasicControl:setGhost(resPath)
	self.ghost = resPath
end

function BasicControl:getGhost( ... )
	-- body
	return self.ghost
end

function BasicControl:setPlayerInterActions( playerInterActions )
	-- body
	self.playerInterActions = playerInterActions
end

return BasicControl
