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
* 
]]
local BaseDataMgr = import(".BaseDataMgr")
local CatListCfg = TabDataMgr:getData("CatList")
local MaokaActivityMgr = class("MaokaActivityMgr", BaseDataMgr)


function MaokaActivityMgr:init( ... )
	-- body
    TFDirector:addProto(s2c.ACTIVITY_RESP_MAID_NESS_INFO, self, self.onRecvMaidNessInfo)
    TFDirector:addProto(s2c.ACTIVITY_RESP_CAT_UP_LEVEL, self, self.onRecvCatUpLevel)
    TFDirector:addProto(s2c.ACTIVITY_RESP_FORMULA_UP_LEVEL, self, self.onRecvFormulaUpLevel)
    TFDirector:addProto(s2c.ACTIVITY_RESP_CAT_RECRUIT, self, self.onCatRecruitRsp)
    TFDirector:addProto(s2c.ACTIVITY_RESP_SET_MAID_NESS_ID, self, self.onSetMaidNessIdRsp)
    TFDirector:addProto(s2c.ACTIVITY_RESP_START_SPECIAL_MAKE_FORMULA, self, self.onStartSpecialMakeRsp)
    TFDirector:addProto(s2c.ACTIVITY_RESP_SPECIAL_MAKE_FORMULA, self, self.onSpecialMakeResurtRsp)
    TFDirector:addProto(s2c.ACTIVITY_RESP_MAKE_FORMULA, self, self.onMakeResurtRsp)
    TFDirector:addProto(s2c.ACTIVITY_RESP_START_CAT_EXPLORE, self, self.onStartCatExploreRsp)
    TFDirector:addProto(s2c.ACTIVITY_RESP_REFRESH_DAILY_TASK, self, self.onRefreshTaskRsp)
end

function MaokaActivityMgr:setActivityData( activityInfo )
	-- body
	self.activityInfo = activityInfo
	local taskList = self:getYinyeTaskList()
	self.targetList = {}
	for k,v in ipairs(taskList) do
		local itemInfo = self:getActivityItemInfo(v)
		if itemInfo then
			table.insert(self.targetList,itemInfo.target)
		end
	end
	table.sort(self.targetList,function ( a,b )
		-- body
		return a < b
	end)
	
end

function MaokaActivityMgr:onActivityAdd( ... )
	-- body
	self:SEND_ACTIVITY_REQ_MAID_NESS_INFO()
end

function MaokaActivityMgr:onLoginOut( ... )
	-- body
	self:reset()
end

function MaokaActivityMgr:reset()
	self.activityInfo = nil
	self.maidNessInfo = {}
end

function MaokaActivityMgr:onRecvMaidNessInfo( event)
	-- body
	local data = event.data
	if not data then return end
	self.maidNessInfo = self.maidNessInfo or {}
	for k,v in pairs(data) do
		if k == "catList" or k == "formulaList" or k == "maidList" or k == "taskList" or k == "toyList" then
			self.maidNessInfo[k] = self.maidNessInfo[k] or {}
			for _k,_v in ipairs(v) do
				if _v.ct == EC_SChangeType.DELETE then
					for __k,__v in ipairs(self.maidNessInfo[k]) do
						if __v.id == _v.id then
							table.remove(self.maidNessInfo[k],__k)
						end
					end
				else
					local hasAdd = false
					for __k,__v in ipairs(self.maidNessInfo[k]) do
						if __v.id == _v.id then
							self.maidNessInfo[k][__k] = _v
							hasAdd = true
							break
						end
					end
					if not hasAdd then
						table.insert(self.maidNessInfo[k],_v)
					end
				end
			end
		else
			self.maidNessInfo[k] = v
		end
	end

	EventMgr:dispatchEvent(EV_MAOKA_ALLDATA_RSP)
end

function MaokaActivityMgr:onRecvCatUpLevel( event)
	-- body
	local data = event.data
	if not data then return end
	

end

function MaokaActivityMgr:onRecvFormulaUpLevel( event)
	-- body
	local data = event.data
	if not data then return end
	
end

function MaokaActivityMgr:onCatRecruitRsp( event)
	-- body
	local data = event.data
	if not data then return end
	EventMgr:dispatchEvent(EV_MAOKA_RECRUIT_RSP,data.rewards)
end

function MaokaActivityMgr:onSetMaidNessIdRsp( event)
	-- body
	local data = event.data
	if not data then return end
	self.maidNessInfo.maidId = data.maidId
	Utils:showTips(13316798)
	EventMgr:dispatchEvent(EV_MAOKA_ALLDATA_RSP)
end

function MaokaActivityMgr:onStartSpecialMakeRsp( event)
	-- body
	local data = event.data
	if not data then return end
	EventMgr:dispatchEvent(EV_MAOKA_START_MAKE_RSP,data)
end

function MaokaActivityMgr:onStartCatExploreRsp( event)
	-- body
	local data = event.data
	if not data then return end
end

function MaokaActivityMgr:onRefreshTaskRsp( event)
	-- body
	local data = event.data
	if not data then return end
	self.maidNessInfo.count = data.count
end

function MaokaActivityMgr:onSpecialMakeResurtRsp(event)
	-- body
	local data = event.data
	if not data then return end

	EventMgr:dispatchEvent(EV_MAOKA_MAKE_RSP,data)
end

function MaokaActivityMgr:onMakeResurtRsp( event)
	-- body
	local data = event.data
	if not data then return end
	EventMgr:dispatchEvent(EV_MAOKA_MAKE_RSP,data)
end

function MaokaActivityMgr:getMaidInfo( maidId )

	if not maidId then return self.maidNessInfo.maidList or {} end
	if not self.maidNessInfo.maidList then return nil end

	for k,v in ipairs(self.maidNessInfo.maidList) do
		if v.id == maidId then
			return v
		end
	end
	return nil
end

function MaokaActivityMgr:getCatInfo( catId )

	if not catId then return self.maidNessInfo.catList or {} end
	if not self.maidNessInfo.catList then return nil end


	for k,v in ipairs(self.maidNessInfo.catList) do
		if v.id == catId then
			return v
		end
	end
	return nil
end

function MaokaActivityMgr:getFormulaInfo( formulaId )

	if not formulaId then return self.maidNessInfo.formulaList or {} end

	if not self.maidNessInfo.formulaList then return nil end

	for k,v in ipairs(self.maidNessInfo.formulaList) do
		if v.id == formulaId then
			return v
		end
	end
	return nil
end

function MaokaActivityMgr:getCatTaskInfo( taskId )
	if not taskId then return self.maidNessInfo.taskList or {} end

	if not self.maidNessInfo.taskList then return nil end


	for k,v in ipairs(self.maidNessInfo.taskList) do
		if v.id == taskId then
			return v
		end
	end
	return nil
end

function MaokaActivityMgr:getToyInfo(id)
	if not id then return self.maidNessInfo.toyList or {} end

	if not self.maidNessInfo.toyList then return nil end

	for k,v in ipairs(self.maidNessInfo.toyList) do
		if v.id == id then
			return v
		end
	end
	return nil
end

function MaokaActivityMgr:getToyAddValue()
	local inSceneToy = self:getToyInfo()
	local addValue = 0
	local curTime = ServerDataMgr:getServerTime()
	for k,v in ipairs(inSceneToy) do
		if v.etime > curTime then
			local itemCfg = GoodsDataMgr:getItemCfg(v.id)
			local _addValue = itemCfg.useProfit.timeBenefit
			addValue = addValue + _addValue
		end
	end
	return addValue
end

function MaokaActivityMgr:playMaokaCg()
	if not self.activityInfo then return end
	local cg_cfg = TabDataMgr:getData("Cg")[self.activityInfo.extendData.cg]
    local layer = require("lua.logic.common.CgView"):new(cg_cfg.cg, cg_cfg.backGround, true,nil)

    AlertManager:addLayer(layer,AlertManager.NONE)
    AlertManager:show()
end

function MaokaActivityMgr:getFormulaSpeed()
	return self:getTotalSpeed() - self:getCatTotalSpeed()
end

function MaokaActivityMgr:getTotal()
	return self.maidNessInfo.total or 0
end

function MaokaActivityMgr:getMaidId()
	return self.maidNessInfo.maidId or 0
end

function MaokaActivityMgr:getTriggerTime()
	return self.maidNessInfo.triggerTime or 0
end

function MaokaActivityMgr:getDailyTaskRefreshCost( ... )
	-- body
	if not self.activityInfo or not self.maidNessInfo.count then return end
	return self.activityInfo.extendData.refreshCost[self.maidNessInfo.count + 1] 
end

function MaokaActivityMgr:getTarget( ... )
	-- body
	local curValue = self:getTotal()
	local tmpTarget = 0
	if #self.targetList == 0 then 
		self:setActivityData(self.activityInfo) 
	end
	for k,v in ipairs(self.targetList) do
		if curValue < v then
			tmpTarget = v
			break
		end
	end
	if tmpTarget == 0 then
		return "MAX"
	end
	return curValue.."/"..tmpTarget
end

function MaokaActivityMgr:getTotalSpeed( ... )
	-- body
	return self.maidNessInfo.totalNum or 0
end

function MaokaActivityMgr:getCatTotalSpeed( ... )
	-- body
	return self.maidNessInfo.totalCat or 0
end

function MaokaActivityMgr:getCatTask(  )
	-- body
	if not self.activityInfo then return {} end
	local taskList = {}
	if self.activityInfo.extendData.exploreTask then
		for k,v in ipairs(self.activityInfo.extendData.exploreTask) do
			if table.find(self.activityInfo.items,v) ~= -1 and self:getActivityItemInfo(v) then
				table.insert(taskList,v)
			end
		end
	end

	if self.activityInfo.extendData.storyTask then
		for k,v in ipairs(self.activityInfo.extendData.storyTask) do
			if table.find(self.activityInfo.items,v) ~= -1 and self:getActivityItemInfo(v) then
				table.insert(taskList,v)
			end
		end
	end
	return taskList
end

function MaokaActivityMgr:checkCatTaskRedPoint(  )
	-- body
	if not self.activityInfo then return false end
	local taskList = self:getCatTask()
	for k,v in ipairs(taskList) do
		local taskInfo, progressInfo = self:getActivityItemInfo(v)
		if progressInfo.status == EC_TaskStatus.GET then
			return true
		end
	end
	return false
end

function MaokaActivityMgr:checkDailyTaskRedPoint(  )
	-- body
	if not self.activityInfo then return false end
	local taskList = self:getDailyTaskList()
	for k,v in ipairs(taskList) do
		local taskInfo, progressInfo = self:getActivityItemInfo(v)
		if progressInfo.status == EC_TaskStatus.GET then
			return true
		end
	end

	local taskList = self:getYinyeTaskList()
	for k,v in ipairs(taskList) do
		local taskInfo, progressInfo = self:getActivityItemInfo(v)
		if progressInfo.status == EC_TaskStatus.GET then
			return true
		end
	end
	return false
end

function MaokaActivityMgr:checkCatRecruitRedPoint(  )
	-- body
	if not self.activityInfo then return false end
	local costId = self:getRecruitCost()
	
	return GoodsDataMgr:getItemCount(costId) > 0
end

function MaokaActivityMgr:getActivityItemInfo( itemId )
	-- body
	if not self.activityInfo then return end
	local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, itemId)
	local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, itemId)
	return itemInfo,  progressInfo
end

function MaokaActivityMgr:submitItemInfo( itemId )
	ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityInfo.id, itemId)
end

function MaokaActivityMgr:tijiaoItemInfo( itemId )
	ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityInfo.id, itemId)
end

function MaokaActivityMgr:getCatListByTaskId( taskId )
	-- body
	local catList = self:getCatInfo()
	local inTask = {}
	for k,v in ipairs(catList) do
		if taskId == v.taskId then
			table.insert(inTask, v.id)
		end
	end
	return inTask
end

function MaokaActivityMgr:getAddValueList( ... )
	-- body
	local list = {}
	for i = 1,2 do
		if i == 1 then
			table.insert(list,{type = 1, value = self:getFormulaSpeed()})
		elseif i == 2 then
			table.insert(list,{type = 2, value = self.maidNessInfo.totalCat})
		end
	end
	return list
end

function MaokaActivityMgr:getPaiQianCatList( taskInfo )
	-- body
	local catList = clone(self:getCatInfo())

	table.sort(catList,function ( cat1, cat2)
		-- body
		local value1 = CatListCfg[cat1.id].attribute[cat1.level][1]
		local value2 = CatListCfg[cat2.id].attribute[cat2.level][1]
		if value1 == value2 then
			return cat1.id < cat2.id
		else
			return value1 > value2
		end
	end)

	local needCats = taskInfo.extendData.catCount

	for k,v in ipairs(catList) do
		if needCats > 0 and v.taskId == 0 then
			v.isFirst = true
			needCats = needCats - 1
		elseif needCats <= 0 then
			break;
		end
	end

	if taskInfo.extendData.catTaskList then
		catList = {}
		for i,v in ipairs(taskInfo.extendData.catTaskList) do
			table.insert(catList,{id = v})
		end
	end

	for i = #catList,1,-1 do
		local info = self:getCatInfo(catList[i].id)
		if not info or info.taskId ~= 0 then -- 一键派遣出去把已上阵的猫丢弃
			table.remove(catList,i)
		end
	end
	return catList
end

function MaokaActivityMgr:getMeterialList(  )
	-- body
	local formulaList = TabDataMgr:getData("CatFormula")
	local meterialList = {}
	for k,v in pairs(formulaList) do
		for i,l in pairs(v.materialList) do
			meterialList[i] = true
		end
	end

	return table.keys(meterialList)
end

function MaokaActivityMgr:getFormulaUpLevelCost(  )
	-- body
	if not self.activityInfo then return 660229 end

	return self.activityInfo.extendData.costId or 660229
end

function MaokaActivityMgr:getRecruitCost(  )
	-- body
	if not self.activityInfo then return 660230 end

	return self.activityInfo.extendData.recruitItem or 660230
end

function MaokaActivityMgr:getStoreIds(  )
	-- body
	if not self.activityInfo then return  end

	return self.activityInfo.extendData.storeIds
end

function MaokaActivityMgr:getDailyTaskList(  )
	if not self.activityInfo then return {} end
	local taskList = {}
	if self.activityInfo.extendData.dailyTask then
		for k,v in ipairs(self.activityInfo.extendData.dailyTask) do
			if table.find(self.activityInfo.items,v) ~= -1 and self:getActivityItemInfo(v) then
				table.insert(taskList,v)
			end
		end
	end

	return taskList
end

function MaokaActivityMgr:getToyIdList(  )
	if not self.activityInfo then return {} end
	return self.activityInfo.extendData.toyList or {}
end

function MaokaActivityMgr:getYinyeTaskList(  )
	if not self.activityInfo then return {} end
	local taskId = self.activityInfo.extendData.businessTask[1]
	if not self:getActivityItemInfo(taskId) then return {} end
	return self.activityInfo.extendData.businessTask or {}
end

function MaokaActivityMgr:getActivityInfo(  )
	return self.activityInfo or {}
end

function MaokaActivityMgr:isMaokaActivity( activityId )
	if not self.activityInfo then return false end
	return self.activityInfo.id == activityId
end

function MaokaActivityMgr:getCatRoomUrlList(  )
	if not self.activityInfo then return nil end
	return self.activityInfo.extendData.liveWeb
end

function MaokaActivityMgr:showHelpView( ... )
	-- body
	if not self.activityInfo then return end
	Utils:openView("common.HelpView", self.activityInfo.extendData.helpID)
	
end

function MaokaActivityMgr:showFormulaHelpView( ... )
	-- body
	if not self.activityInfo then return end
	Utils:openView("common.HelpView", self.activityInfo.extendData.helpID2)
	
end

function MaokaActivityMgr:SEND_ACTIVITY_REQ_MAID_NESS_INFO(...)
	TFDirector:send(c2s.ACTIVITY_REQ_MAID_NESS_INFO,{...})
end


function MaokaActivityMgr:SEND_ACTIVITY_REQ_CAT_UP_LEVEL(...)
	TFDirector:send(c2s.ACTIVITY_REQ_CAT_UP_LEVEL,{...})
end


function MaokaActivityMgr:SEND_ACTIVITY_REQ_FORMULA_UP_LEVEL(...)
	TFDirector:send(c2s.ACTIVITY_REQ_FORMULA_UP_LEVEL,{...})
end

function MaokaActivityMgr:SEND_ACTIVITY_REQ_CAT_RECRUIT(...)
	TFDirector:send(c2s.ACTIVITY_REQ_CAT_RECRUIT,{...})
end

function MaokaActivityMgr:SEND_ACTIVITY_REQ_SET_MAID_NESS_ID(...)
	TFDirector:send(c2s.ACTIVITY_REQ_SET_MAID_NESS_ID,{...})
end

function MaokaActivityMgr:SEND_ACTIVITY_REQ_REFRESH_DAILY_TASK(...)
	TFDirector:send(c2s.ACTIVITY_REQ_REFRESH_DAILY_TASK,{...})
end

function MaokaActivityMgr:SEND_ACTIVITY_REQ_START_SPECIAL_MAKE_FORMULA(...)
	TFDirector:send(c2s.ACTIVITY_REQ_START_SPECIAL_MAKE_FORMULA,{...})
end

function MaokaActivityMgr:SEND_ACTIVITY_REQ_SPECIAL_MAKE_FORMULA(...)
	TFDirector:send(c2s.ACTIVITY_REQ_SPECIAL_MAKE_FORMULA,{...})
end

function MaokaActivityMgr:SEND_ACTIVITY_REQ_MAKE_FORMULA(...)
	TFDirector:send(c2s.ACTIVITY_REQ_MAKE_FORMULA,{...})
end

function MaokaActivityMgr:SEND_ACTIVITY_REQ_START_CAT_EXPLORE(...)
	TFDirector:send(c2s.ACTIVITY_REQ_START_CAT_EXPLORE,{...})
end

function MaokaActivityMgr:SEND_ACTIVITY_REQ_USEING_TOY(...)
	TFDirector:send(c2s.ACTIVITY_REQ_USEING_TOY,{...})
end
return MaokaActivityMgr:new()