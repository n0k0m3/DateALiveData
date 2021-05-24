local BaseDataMgr = import(".BaseDataMgr")
local GuideDataMgr = class("GuideDataMgr", BaseDataMgr)
local UserDefalt = CCUserDefault:sharedUserDefault()

local GuideType = {
	new_guide = 1,
	team_guide = 2,
}

function GuideDataMgr:ctor()
	self.guideData = TabDataMgr:getData("Guide")
	self.guideGroup = {}
	self.maxNewStep = 0
	self.triggerGuideGroupIds = {}
	local groupIds = {}
	for k,v in pairs(self.guideData) do
		self.guideGroup[v.guideId] = self.guideGroup[v.guideId] or {}
		self.guideGroup[v.guideId][v.id] = v
		if v.guideType == GuideType.new_guide then
			self.maxNewStep = self.maxNewStep + 1
		else
			if not groupIds[v.guideId] then
				groupIds[v.guideId] = {}
			end
			groupIds[v.guideId].id = v.id
			groupIds[v.guideId].fileName = v.fileName
			groupIds[v.guideId].level = v.triggerLevel
			groupIds[v.guideId].funcType = v.funcType
			if not groupIds[v.guideId].triggerCdt then
				groupIds[v.guideId].triggerCdt = {}
			end
			groupIds[v.guideId].triggerCdt = next(v.triggerCdt) and v.triggerCdt or groupIds[v.guideId].triggerCdt
		end
	end
	for k,v in pairs(groupIds) do
		table.insert(self.triggerGuideGroupIds, {group = tonumber(k), level = v.level , id = v.id, triggerCdt = v.triggerCdt, funcType = v.funcType, filename=v.fileName})
	end

	table.sort(self.triggerGuideGroupIds, function(a, b)
		return a.id < b.id
	end)

	self.bBattleGuideState = false --战斗教学是否完成
	self.m_guide_info = nil
	self.__groupId = 0
	self.__step = 0 
	self.newGuiding = false
	self.curPassLevelId = 0
	self.plotBack = false
	self.receiveServerStep = false
    self:init()
end

function GuideDataMgr:init()
	TFDirector:addProto(s2c.PLAYER_RES_NEW_PLAYER_GUIDE, self, self.recvSaveStep)
	TFDirector:addProto(s2c.EXPLORE_REQ_GUIDE_INFO, self, self.recvServerGuideGroup)
	TFDirector:addProto(s2c.EXPLORE_RES_ADD_GUIDE_STEP, self, self.recvAddServerGuideGroup)
end

function GuideDataMgr:onLogin()

	TFDirector:send(c2s.PLAYER_REQ_NEW_PLAYER_GUIDE, {-1})
	TFDirector:send(c2s.EXPLORE_REQ_GUIDE_INFO, {})
	return { s2c.PLAYER_RES_NEW_PLAYER_GUIDE,s2c.EXPLORE_REQ_GUIDE_INFO }

end

function GuideDataMgr:reset()

end

function GuideDataMgr:onLoginOut()
	self.isLogin = false
	self:resetGuideInfo()
	self:setIsStart(false)
	self.bBattleGuideState = false
	self.receiveServerStep = false
	self.newGuiding = false
end

function GuideDataMgr:initGuideInfo()
	self:checkEnablePass()
	self.__step = self.__step + 1
	self:resetNewGuideStep()
	
	if self.newGuiding and not self:isInGroupFirst() then
		self:setGroupFirst()
	end
	

	local serverid = ServerDataMgr:getCurrentServerID();
	--TODO close
	-- ios 审核服屏蔽新手引导
	if serverid == 99901 then
		self:setIsStart(false)
	else
		self:setIsStart(true)
	end
	-- self:setIsStart(true)
end

function GuideDataMgr:checkEnablePass()
	function adjustRealGuideId()
		local cfg = self:getCfgByStep(self.__step)
		if cfg and cfg.stepId > 0 and cfg.stepId > self.__step then
			self.__step = cfg.stepId
			adjustRealGuideId()
		end
	end
	local fCfg = self:getCfgByStep(math.max(self.__step, 1))
	if fCfg and fCfg.dunId > 0 then
		local pass = FubenDataMgr:isPassPlotLevel(fCfg.dunId)
		if not pass then
			return
		end
	end
	local cfg = self:getCfgByStep(self.__step)
	if cfg and cfg.stepId > 0 then
		self.__step = cfg.stepId
		adjustRealGuideId()
	else
		local cfg = self:getCfgByStep(self.__step + 1)
		if cfg and cfg.stepId > 0 and cfg.fileName == "FunctionOpenView" then
			self.__step = cfg.stepId
			adjustRealGuideId()
		end
	end
end

function GuideDataMgr:checkBattleGuideEnd()
	if not self.receiveServerStep then
		return
	end
	self:initGuideInfo()
	local pass = FubenDataMgr:isPassPlotLevel(101101)
    if not pass then
		self.__step = 3
	end
end

function GuideDataMgr:resetNewGuideStep()
	if self.__step > self.maxNewStep then
		self.newGuiding = false
		self:resetGuideInfo()
		CommonManager:setFirstLoginIn(false)
		return
	end
	CommonManager:setFirstLoginIn(true)
	for k,v in pairs(self.guideData) do
		if v.guideType == GuideType.new_guide and v.id == self.__step then
			self.__groupId = v.guideId
		end
	end
end

function GuideDataMgr:resetGuideInfo()
	self.m_guide_info = nil
	self.__groupId = 0
	self.__step = 0
end

function GuideDataMgr:getCurStepInfo()
	return  self.__step,self.__groupId
end

function GuideDataMgr:checkHasGuideInfo(ui)
	print("GuideDataMgr 111111111111111111111", self.__step, ui.__cname)
	if self.newGuiding then
		if ui.__cname == "FubenLevelView" then
			local fCfg = self:getCfgByStep(math.max(self.__step - 1, 1))
			if fCfg and fCfg.dunId > 0 then
				if self.plotBack then
					self.__step = self:findMinStepInCurGroup(ui.__cname)
				end
				self.plotBack = false
			end
		elseif ui.__cname == "SummonView" then
			EventMgr:dispatchEvent(EV_SUMMON_SELECT)
		end

		local info = self:getCfgByStep(self.__step)
		if info and ui.__cname == info.fileName then
			self.m_guide_info = info
			return true
		end
		self.m_guide_info = nil
		return false		
	end

	----触发约会
	local info = self:getCfgByStep(self.__step)
	if info then
		if info.guideId == self.__groupId then
			if info.fileName == ui.__cname then
				self.m_guide_info = info
				return true
			end
		else
			self:findCurTriggerGuideGroup(ui)
			self:setGroupFirst()
			info = self:getCfgByStep(self.__step)
			self.m_guide_info = info
			return true
		end
	else
		if self:findCurTriggerGuideGroup(ui) then
			self:setGroupFirst()
			info = self:getCfgByStep(self.__step)
			if info.fileName == ui.__cname then
				self.m_guide_info = info
				return true
			end
		end
	end

	self.m_guide_info = nil

	return false
end

function GuideDataMgr:findCurTriggerGuideGroup(ui)
	--local pid = MainPlayer:getPlayerId()
	--local saveTeamGroup = UserDefalt:getStringForKey("teamguidegroup"..pid)
	--local groupIds = {}
	--if saveTeamGroup ~= "" then
    --    local groupTable = string.split(saveTeamGroup,"|")
    --    for k,v in ipairs(groupTable) do
    --        local group = tonumber(v)
    --        if group then
    --        	groupIds[group] = 1
    --        end
    --    end
    --end
	local serverGroupIds = {}
	local courageGroupIds = CourageDataMgr:getTriggerGuideGroupIds()
	table.insertTo(serverGroupIds,courageGroupIds)
	local commonGroupIds = self:getServerGroupIds()
	table.insertTo(serverGroupIds,commonGroupIds)
    for i,v in ipairs(self.triggerGuideGroupIds) do
		local index = table.indexOf(serverGroupIds,v.group)
		if index == -1 then
			local guideState = true
			if v.funcType == EC_GuideFuncType.Courage then
				guideState = CourageDataMgr:getGuideState()
			end

			if guideState then
				local isFit = self:checkCondition(v.level,v.triggerCdt, ui, v.filename)
				if isFit then
					self.__groupId = v.group
					if v.funcType == EC_GuideFuncType.Courage then
						CourageDataMgr:addTriggerGuideGroupId(self.__groupId)
					end
					return true
				end
			end
		end
    end
    return false
end

function GuideDataMgr:checkCondition(level,triggerCdt, ui,filename)

	local fitCondition = true
	if next(triggerCdt) then
		print("触发条件",triggerCdt.fromView, ui.fromView)
		if triggerCdt.fromView then
			if triggerCdt.fromView == ui.fromView and MainPlayer:getPlayerLv() >= triggerCdt.limitLv then
				fitCondition = true	
			else
				fitCondition = false
			end
			if filename and filename ~= ui.__cname then
				fitCondition = false
			end
			return fitCondition
		end
		
		
		--关卡解锁触发的引导
		if triggerCdt.level and triggerCdt.fightCount then
			local levelInfo = FubenDataMgr:getLevelInfo(triggerCdt.level)
			print("关卡解锁触发的引导",levelInfo)
			if levelInfo and levelInfo.fightCount == triggerCdt.fightCount then
				fitCondition = true
			else
				fitCondition = false
			end
			return fitCondition
		end


		---背包道具
		local ownItemCondition = triggerCdt.ownItem
		if ownItemCondition and next(ownItemCondition) then
			for k,v in pairs(ownItemCondition) do
				local ownCnt = GoodsDataMgr:getItemCount(k)
				if ownCnt < v then
					fitCondition = false
					break
				end
			end
		end

		---ap值
		local apLess = triggerCdt.apLess
		if apLess then
			local apInfo = CourageDataMgr:getApInfo()
			if not apInfo then
				return
			end
			if not apInfo.value or not apInfo.limit then
				return
			end
			local cur,max = apInfo.value,apInfo.limit
			if cur >= apLess then
				fitCondition = false
			end
		end

		---
		local eventId = CourageDataMgr:getEventID()
		local eventFinishId = triggerCdt.eventFinish
		if eventFinishId and eventId ~= eventFinishId then
			fitCondition = false
		end

	else
		local playerLv = MainPlayer:getPlayerLv()
		fitCondition = playerLv >= level
	end
	return fitCondition
end

function GuideDataMgr:setCurPassLevel(levelCid)
	self.curPassLevelId = levelCid
end

function GuideDataMgr:setPlotLvlBackState(isBack)
	self.plotBack = isBack
end

function GuideDataMgr:findMinStepInCurGroup(cname)
	local minStep = self.__step
	local group = self.guideGroup[self.__groupId]
	for step,v in pairs(group) do
		if v.fileName == cname then
			minStep = math.min(minStep, step)
		end
	end
	return minStep
end

function GuideDataMgr:checkEnableControl(cfg)
	if not cfg.showContinue and cfg.uiEffect ~= "" then
		return false
	end
	return true
end

function GuideDataMgr:checkCurGroupOver()
	if self.newGuiding then
		if self.__step > self.maxNewStep then
			self.newGuiding = false
			self:resetGuideInfo()
			CommonManager:setFirstLoginIn(false)
			--EventMgr:dispatchEvent(EV_NEW_GUIDE_COMPLETE)
		else
			CommonManager:setFirstLoginIn(true)
			local cfg = self:getCfgByStep(self.__step)
			if cfg and cfg.guideId > self.__groupId then
				self.__groupId = cfg.guideId
			end
		end
	else
		if self.m_guide_info then
			local maxId = self:getCurGroupMaxId()
			if self.__step > maxId then
				--local pid = MainPlayer:getPlayerId()
		        --local saveInfoStr = UserDefalt:getStringForKey("teamguidegroup"..pid)
		        --saveInfoStr = saveInfoStr..self.__groupId.."|"
		        --UserDefalt:setStringForKey("teamguidegroup"..pid,saveInfoStr)
		        --UserDefalt:flush()

				local funcType = 0
				for i,v in ipairs(self.triggerGuideGroupIds) do
					if v.group == self.__groupId then
						funcType = v.funcType
						break
					end
				end
				if funcType == EC_GuideFuncType.Courage then
					CourageDataMgr:addTriggerGuideGroupId(self.__groupId)
				else
					self:addServerGuideGroupId(self.__groupId)
				end
				self:resetGuideInfo()
			end
		end
	end
end

function GuideDataMgr:getCurGuideInfo()
	return self.m_guide_info
end

function GuideDataMgr:isInNewGuide()
	return self.newGuiding
end

function GuideDataMgr:readyToStart()
	return self._isStart
end

function GuideDataMgr:getBattleGuideState()
	return self.bBattleGuideState
end

function GuideDataMgr:setBattleGuideState(state)
	self.bBattleGuideState = state
	self:saveStep(true)
end

function GuideDataMgr:getTabMinKey(tab,value)
	local min = 10000000
	for k,v in pairs(tab) do
		if k < min then
			min = k
		end
	end

	return min
end

function GuideDataMgr:getCfgByStep(step)
	if self.newGuiding then
		return self.guideData[step]
	end

	for guideId, group in pairs(self.guideGroup) do
		if self.__groupId == guideId then
			return group[step]
		end
	end
end

function GuideDataMgr:isInGroupFirst()
	local group = self.guideGroup[self.__groupId]
	for step,v in pairs(group) do
		if step == self.__step then
			local min = self:getTabMinKey(group,step)
			if min == self.__step then
				return true
			end
		end
	end

	return false
end

function GuideDataMgr:setGroupFirst()
	local group = self.guideGroup[self.__groupId]
	self.__step = self:getTabMinKey(group,self.__step)
	return self.__step
end

function GuideDataMgr:getCurGroupId()
	for i,v in ipairs(self.guideGroup) do
		for step,v2 in pairs(v) do
			if step == self.__step then
				return i;
			end
		end
	end

	return;
end

function GuideDataMgr:isInCurGroup(ui)
	local group = self.guideGroup[self.__groupId]
	for k,v in pairs(group) do
		if v.fileName == ui.__cname then
			return true;
		end
	end

	return false;
end

function GuideDataMgr:isCanJump(ui)
	local cfg = self:getCfgByStep(self.__step);

	if self:isInCurGroup(ui) and self:isInGroupFirst() and ui.__cname ~= cfg.fileName and not self:isBattle() then
		return true
	end

	return false;
end

function GuideDataMgr:isBattle()
	return self.isBattleEning;
end

function GuideDataMgr:setIsBattle(isend)
	self.isBattleEning = isend;
end

function GuideDataMgr:isStart()
	return self._isStart
end

function GuideDataMgr:setIsStart(isStart)
	self._isStart = isStart
end

function GuideDataMgr:skipGuide(isNewGuid)
	self.__step = isNewGuid and self.maxNewStep or self:getCurGroupMaxId()
	self:saveStep()
end

function GuideDataMgr:skipNewGuide()
	self:skipGuide(GuideDataMgr:isInNewGuide())
end

function GuideDataMgr:skipTeamGuideGroup( )
    local maxId = self:getCurGroupMaxId()
    self.__step = maxId
	self:saveStep()
end

function GuideDataMgr:saveStep(battleState)
	local msg = {
		self.__step
	}
	local cfg = self:getCfgByStep(self.__step)
	if cfg and cfg.stepId > 0 and cfg.stepId > self.__step then
		self.__step = cfg.stepId
	else
		self.__step = self.__step + 1
	end
	--CCUserDefault:sharedUserDefault():setIntegerForKey("guide_step",self.__step)
	if self.newGuiding then
		TFDirector:send(c2s.PLAYER_REQ_NEW_PLAYER_GUIDE, msg)
	end
	self:checkCurGroupOver()
end

function GuideDataMgr:getCurGroupMaxId(groupId)
	groupId = groupId or self.__groupId
	local maxId = 0
	local group = self.guideGroup[groupId] or {}
	for k, v in pairs(group) do
		maxId = math.max(maxId, k)
	end
	return maxId
end

function GuideDataMgr:recvSaveStep(event)
	local data = event.data
	print("GuideDataMgr:recvSaveStep", self.__step, data)
	--local step = CCUserDefault:sharedUserDefault():getIntegerForKey("guide_step")
	if data.guideId then
		if not self._isStart then
			self.__step = data.guideId
			self.receiveServerStep = true
		end
		if data.finish then
			self.newGuiding = false
		else
			self.newGuiding = true
		end
	end
end

function GuideDataMgr:getServerGroupIds()
	return self.serverGuideGroup
end

function GuideDataMgr:addServerGuideGroupId(id)
	table.insert(self.serverGuideGroup,id)
	TFDirector:send(c2s.EXPLORE_REQ_ADD_GUIDE_STEP, {id})
end

function GuideDataMgr:recvAddServerGuideGroup(event)

end

function GuideDataMgr:recvServerGuideGroup(event)
	local data = event.data
	if not data then
		return
	end
	self.serverGuideGroup = {}
	self.serverGuideGroup = data.stepInfo or {}
end

function GuideDataMgr:getServerGroupIds()
	return self.serverGuideGroup
end

function GuideDataMgr:addServerGuideGroupId(id)
	table.insert(self.serverGuideGroup,id)
	TFDirector:send(c2s.EXPLORE_REQ_ADD_GUIDE_STEP, {id})
end

function GuideDataMgr:recvAddServerGuideGroup(event)

end

function GuideDataMgr:recvServerGuideGroup(event)
	local data = event.data
	if not data then
		return
	end
	self.serverGuideGroup = {}
	self.serverGuideGroup = data.stepInfo or {}
end

return GuideDataMgr:new();
