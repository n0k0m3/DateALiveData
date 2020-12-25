local Activity2020LobarDay = class("Activity2020LobarDay", BaseLayer)
Activity2020LobarDay.OffsetY = 35

function Activity2020LobarDay:ctor(...)
	self.super.ctor(self)

	self:initData(...)

	self:init("lua.uiconfig.activity.LobarDayMain")

	self:refreshView()

	ActivityDataMgr2:requestLobarDayScore()
	ActivityDataMgr2:requestLobarConvert()
end


function Activity2020LobarDay:initData(activityId, selectIndex)
	self.currentTaskItem = nil

	self.selectIndex = selectIndex or 1

	self.activityId = activityId
	self.activityData = ActivityDataMgr2:getActivityInfo(self.activityId)

	self.taskItem = {}
	self.taskData = {}
	self.convertId = nil
	self.convertMax = nil
	self.originTaskNum = nil		--普通任务的数量

	self:configData()
	
end

function Activity2020LobarDay:configData()
	self.taskData = {}
	for i = 1, #(self.activityData.items or {}) do
		local itemId = self.activityData.items[i]
		local itemInfo = ActivityDataMgr2:getItemInfo(self.activityData.activityType, itemId)
		table.insert(self.taskData, itemInfo)
	end
	self.originTaskNum = #self.taskData

	for k, v in pairs(self.activityData.extendData.convertMax) do
		self.convertId = k
		self.convertMax = v
	end
end


function Activity2020LobarDay:initUI(ui)
	self.super.initUI(self, ui)

	self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

	self.TurnView = UITurnView:create(TFDirector:getChildByPath(ui, "list"))

	self.Prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
	self.Prefab.size = self.Prefab:getContentSize()
    self.TurnView:setItemModel(self.Prefab)

	self.Button_goto = TFDirector:getChildByPath(ui, "Button_goto")

	self.Button_reward = TFDirector:getChildByPath(ui, "Button_reward")

	self.Button_Union = TFDirector:getChildByPath(ui, "Button_Union")

	self.ScoreSelf = TFDirector:getChildByPath(ui, "ScoreSelf")
	self.ScoreSelf = TFDirector:getChildByPath(self.ScoreSelf, "score")
	self.ScoreTotal = TFDirector:getChildByPath(ui, "ScoreTotal")
	self.ScoreTotal = TFDirector:getChildByPath(self.ScoreTotal, "score")

	self.Image_taskDetail = TFDirector:getChildByPath(ui, "Image_taskDetail")
	self.task_des = TFDirector:getChildByPath(ui, "task_des")
	self.task_desEx = TFDirector:getChildByPath(ui, "task_desEx")
	self.task_title = TFDirector:getChildByPath(ui, "taskTitle")
	self.task_progress = TFDirector:getChildByPath(ui, "task_progress")

	self.Button_Canget = TFDirector:getChildByPath(ui, "Button_canget")
	self.Button_Canget:setVisible(false)
	self.Icon_finish = TFDirector:getChildByPath(ui, "Icon_finish")
	self.Icon_finish:setVisible(false)
	self.Icon_unfinish = TFDirector:getChildByPath(ui, "Icon_unfinish")
	self.Icon_unfinish:setVisible(false)

	self.act_timeStart = TFDirector:getChildByPath(ui, "act_timeStart")
	self.act_timeEnd = TFDirector:getChildByPath(ui, "act_timeEnd")

	self.Button_help = TFDirector:getChildByPath(ui, "Button_help")
end

function Activity2020LobarDay:registerEvents()
	EventMgr:addEventListener(self, EV_LOBAR_DAY_SCORE_RECEIVE, handler(self.updateScore, self))
	EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.updateScore, self))
	EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onRespGetReward, self))
	EventMgr:addEventListener(self, EV_LOBAR_DAY_CONVERT_PROGRESS, handler(self.updateSpecialTask, self))

	self.Button_goto:onClick(function()
		local taskData = self.currentTaskItem.taskData
		local param = taskData.extendData.parameter or {}
		local selectIndex = self.TurnView:getSelectIndex()
        FunctionDataMgr:enterByFuncId(taskData.extendData.jumpInterface,unpack(param))

		ActivityDataMgr2:setCacheTaskSelect(selectIndex)
	end)
	
	self.Button_Union:onClick(function()
		FunctionDataMgr:jUnion()
	end)

	self.Button_reward:onClick(function()
		Utils:openView("activity.Activity2020LobarDayReward", self.activityId)
	end)

	self.Button_Canget:onClick(function()
		if LeagueDataMgr:checkSelfInUnion() then
			local taskData = self.currentTaskItem.taskData
			ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, taskData.id)
		else
			Utils:openView("common.ReConfirmTipsView", {tittle = 13311184, content = TextDataMgr:getText(14300340), reType = false, confirmCall = function()
				local taskData = self.currentTaskItem.taskData
				ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, taskData.id)
			end})
		end
	end)

	self.Button_help:onClick(function()
		Utils:openView("common.HelpView", {3110})
	end)

	local function scrollCallback(target, offsetRate, customOffsetRate,index)
        local items = target:getItem()
        for i, item in ipairs(items) do
            local rate = offsetRate[i]
            local rrate = 1 - rate
            item:setZOrder(rrate * 100)

			if index == i then
				item:setPositionY(self.Prefab.size.height *0.5 + Activity2020LobarDay.OffsetY)
				item.BG_selected:setVisible(true)
				item.BG_unselected:setVisible(false)
			else
				item:setPositionY(self.Prefab.size.height *0.5)
				item.BG_selected:setVisible(false)
				item.BG_unselected:setVisible(true)
			end
        end
		self:showDetail(index)
    end
	self.TurnView:registerScrollCallback(scrollCallback)

	local function SelectTurnItem(target, selectIndex)
		local items = target:getItem()
		for i, item in ipairs(items) do
			local selectIndex = target:getSelectIndex()
			if selectIndex == i then
				item:setPositionY(self.Prefab.size.height *0.5 + Activity2020LobarDay.OffsetY)
				item.BG_selected:setVisible(true)
				item.BG_unselected:setVisible(false)
			else
				item:setPositionY(self.Prefab.size.height *0.5)
				item.BG_selected:setVisible(false)
				item.BG_unselected:setVisible(true)
			end
		end
		self:showDetail(selectIndex)
	end
    self.TurnView:registerSelectCallback(SelectTurnItem)
end

function Activity2020LobarDay:refreshView()
	self:initTaskList()

	local year, month, day = Utils:getDate(self.activityData.showStartTime)
	local format = TextDataMgr:getText(300324)
	local text = string.format(format, year).. string.format(format, string.format("%.2d", month)).. string.format("%.2d", day).."-"
	self.act_timeStart:setText(text)

	year, month, day = Utils:getDate(self.activityData.showEndTime)
	text = string.format(format, year).. string.format(format, string.format("%.2d", month)).. string.format("%.2d", day)
	self.act_timeEnd:setText(text)
end

function Activity2020LobarDay:initTaskList()
	for i=1, #self.taskData do
		self:addTask(i,self.taskData[i])
	end
	self:addTaskSpecial()
end

function Activity2020LobarDay:addTask(index, data, special)
	local item = self.TurnView:pushBackItem()
	item.origin = item:getPosition()
	item.index = index

	item.taskProgress = TFDirector:getChildByPath(item, "taskProgress")

	item.BG_selected = TFDirector:getChildByPath(item, "itemBG_selected")
	item.BG_selected.taskName = TFDirector:getChildByPath(item.BG_selected, "taskName")
	
	item.BG_unselected = TFDirector:getChildByPath(item, "itemBG_unselected")
	item.BG_unselected.taskName = TFDirector:getChildByPath(item.BG_unselected, "taskName")

	item:setTouchEnabled(true)
	item:addMEListener(TFWIDGET_CLICK, function()
		local selectIndex = self.TurnView:getSelectIndex()
        if item.index ~= selectIndex then
			self.TurnView:scrollToItem(item.index)
		end
	end)

	self:initTaskData(item, data, special)

	table.insert(self.taskItem, item)
end

function Activity2020LobarDay:addTaskSpecial()
	self:addTask(self.originTaskNum + 1, nil)
end

function Activity2020LobarDay:initTaskData(item, data, special)
	if data == nil then
		return
	end
	item.taskData = data
	item.special = special
	
	if special then
		item.taskProgress:setText(data.progress .."/".. self.convertMax)
	else
		local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityData.activityType, data.id)
		item.taskProgress:setText(progressInfo.progress .."/".. data.target)
	end

	item.BG_selected.taskName:setText(data.extendData["icon"])
	item.BG_selected:setVisible(false)
	item.BG_unselected.taskName:setText(data.extendData["icon"])
	item.BG_unselected:setVisible(true)
end

function Activity2020LobarDay:showDetail(index)
	local item = self.taskItem[index]
	local data = item.taskData
	self.task_des:setText(data.extendData["des2"])
	self.task_desEx:setText(data.extendData["des2"])
	self.task_des:setVisible(not (index==#self.taskItem))
	self.task_desEx:setVisible(index==#self.taskItem)
	
	self.task_title:setText(data.extendData["icon"])
	
	self:updateBtnStatus(data, item.special)

	self:updateReward(data, index==#self.taskItem)

	self.currentTaskItem = item
end

function Activity2020LobarDay:updateReward(data, isLast)
	for i=1,3 do
		local parent = TFDirector:getChildByPath(self.Image_taskDetail, "reward"..i)
		local shadow = TFDirector:getChildByPath(parent, "shadow")
		shadow:setVisible(not isLast)
		local child = TFDirector:getChildByPath(parent, "Child")
		if child then
			child:removeFromParent()
		end
	end
	local rewardTab = data.reward or {}
	local nodeIdx = 1
	for k, v in pairs(rewardTab) do
		local parent = TFDirector:getChildByPath(self.Image_taskDetail, "reward"..nodeIdx)
		if parent then
			local shadow = TFDirector:getChildByPath(parent, "shadow")
			shadow:Hide()
			local panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
			PrefabDataMgr:setInfo(panel_goodsItem, tonumber(k), v)
			panel_goodsItem:AddTo(parent):Pos(0, 0)
			panel_goodsItem:setScale(0.65)
			panel_goodsItem:setName("Child")
		end
		nodeIdx = nodeIdx + 1
	end
end

function Activity2020LobarDay:updateBtnStatus(data, special)
	if special then
		self.task_progress:setText(data.progress.."/".. self.convertMax)
		local isComplete = data.progress >= self.convertMax
		self.Button_Canget:setVisible(false)
		self.Icon_finish:setVisible(isComplete)
		self.Icon_unfinish:setVisible(not isComplete)

		self.Button_goto:setGrayEnabled(isComplete)
		self.Button_goto:setTouchEnabled(not isComplete)
	else
		local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityData.activityType, data.id)
		self.task_progress:setText(progressInfo.progress.."/"..data.target)
		if progressInfo.status == EC_TaskStatus.GET then
			self.Button_Canget:setVisible(true)
			self.Icon_finish:setVisible(false)
			self.Icon_unfinish:setVisible(false)

			self.Button_goto:setGrayEnabled(true)
			self.Button_goto:setTouchEnabled(false)
		elseif progressInfo.status == EC_TaskStatus.ING then
			self.Button_Canget:setVisible(false)
			self.Icon_finish:setVisible(false)
			self.Icon_unfinish:setVisible(true)
		
			self.Button_goto:setGrayEnabled(false)
			self.Button_goto:setTouchEnabled(true)
		elseif progressInfo.status == EC_TaskStatus.GETED then
			self.Button_Canget:setVisible(false)
			self.Icon_finish:setVisible(true)
			self.Icon_unfinish:setVisible(false)

			self.Button_goto:setGrayEnabled(true)
			self.Button_goto:setTouchEnabled(false)
		end
	end

	self.Button_goto:setVisible(FunctionDataMgr:isFuncIdExist(data.extendData.jumpInterface))
end

function Activity2020LobarDay:onUpdateProgressEvent()
	self:updateView()	
end



function Activity2020LobarDay:updateActivity()
	
end

function Activity2020LobarDay:updateView()
	self:configData()

	for i=1, #self.taskItem do
		self:initTaskData(self.taskItem[i], self.taskData[i])
	end

	self:showDetail(self.TurnView:getSelectIndex())

	self:updateScore()
end

function Activity2020LobarDay:updateScore()
	local itemNum = GoodsDataMgr:getItemCount(500110) or 0
	self.ScoreSelf:setText(itemNum)

	local totalScore = ActivityDataMgr2:getLobarScore()
	self.ScoreTotal:setText(totalScore)
end

function Activity2020LobarDay:onRespGetReward(activityID, Entry, reward)
	if activityID == self.activityId then
		Utils:showReward(reward)
		self:updateView()
	end
end

function Activity2020LobarDay:updateSpecialTask(data)
	local totalNum = 0
	if data.items and #data.items > 0 then
		totalNum = data.items[1].totalNum or totalNum
	end
	local extData = {
		extendData = {
			des2 = TextDataMgr:getText(14300334),
			icon = TextDataMgr:getText(14300333),
			jumpInterface = 26
		},
		id = 0,
		reward = {},
		target = self.convertMax,
		progress = totalNum
	}

	self:initTaskData(self.taskItem[#self.taskItem], extData, true)

	self.TurnView:scrollToItem(ActivityDataMgr2:getCacheTaskSelect() or 1)
end








return Activity2020LobarDay