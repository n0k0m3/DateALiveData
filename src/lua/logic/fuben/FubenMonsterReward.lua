--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local FubenMonsterReward = class("FubenMonsterReward", BaseLayer)

local FinishStatus = {
	CanGet = 1,
	CannotGet = 2,
	HasGet = 3	
}
local ListType = {
	Score = 1,
	Achive = 2
}

function FubenMonsterReward:ctor()
	self.super.ctor(self)
	self:showPopAnim(true)

	self:initData()
	self:init("lua.uiconfig.fuben.fubenMonsterTrialReward")

--	self:refreshView()
end

function FubenMonsterReward:initData()
	self.data = {[ListType.Score] = {}, [ListType.Achive] = {}}
	self.curBtn = nil
	self:initRewardList()
end

function FubenMonsterReward:initRewardList()
	self.data = {[ListType.Score] = {}, [ListType.Achive] = {}}

	local function func(taskId, dstTab)
		local config = TaskDataMgr:getTaskCfg(taskId)
		local taskInfo = TaskDataMgr:getTaskInfo(taskId) or {progress = 0, status = EC_TaskStatus.ING, virtual = true}
		local statusOrder;
		if taskInfo.status == EC_TaskStatus.ING then
			statusOrder = 2
		elseif taskInfo.status == EC_TaskStatus.GET then
			statusOrder = 1
		elseif taskInfo.status == EC_TaskStatus.GETED then
			statusOrder = 3
		end
		local temp = {
			taskInfo = taskInfo,
			config = config,
			statusOrder = statusOrder,
		}
		table.insert(dstTab,  temp)
	end
	
	local monsterTrialTaskConfig = FubenDataMgr:getMonsterTrialInfo()
	local scoreTask = monsterTrialTaskConfig["taskList"] or {}
	for k, v in pairs(scoreTask) do	
		func(v, self.data[ListType.Score])
	end
	
	local AllTask = TabDataMgr:getData("Task")
	for k, v in pairs(AllTask) do		
		if v.ext.type == 1 then
			func(v.id, self.data[ListType.Achive])
		end
	end

	for k, v in pairs(self.data) do
		table.sort(v, function(a, b)
			if a.statusOrder == b.statusOrder then
				return a.config.order < b.config.order
			else
				return a.statusOrder < b.statusOrder	
			end			
		end)
	end
end

function FubenMonsterReward:bindData()
	self.tabSelfScore.data = self.data[ListType.Score] or {}
	self.tabAchive.data = self.data[ListType.Achive] or {}
end

function FubenMonsterReward:initUI(ui)
	self.super.initUI(self,ui)

	self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
	self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")

	self.Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")

	self.Panel_ScoreItem = TFDirector:getChildByPath(self.Panel_root, "Panel_ScoreItem")

	self.tabSelfScore	= TFDirector:getChildByPath(self.Image_content, "tabSelfScore")
		
	self.tabAchive	   = TFDirector:getChildByPath(self.Image_content, "tabAchive")

	self:bindData()
	
	self:initTableView()

	self:selectList(self.tabSelfScore)
end

function FubenMonsterReward:registerEvents()
	self.super.registerEvents(self)
	EventMgr:addEventListener(self, EV_TASK_RECEIVE, handler(self.onTaskReceiveEvent, self))


	self.Button_close:onClick(function()
		AlertManager:closeLayer(self)
	end)
	self.tabSelfScore:onClick(function(widget)
		self:selectList(widget)
	end)
	self.tabAchive:onClick(function(widget)
		self:selectList(widget)
	end)
end

function FubenMonsterReward:selectList(widget)
	if widget == self.curBtn then
		return;
	end

	if self.curBtn then
		self.curBtn:setTextureNormal("ui/activity/lobarDay/tabDark.png")
	end
	widget:setTextureNormal("ui/activity/lobarDay/tabBright.png")

	self.curBtn = widget

	self.tableView:reloadData()
end

function FubenMonsterReward:initTableView()
	local list = TFDirector:getChildByPath(self.Image_content, "ScrollView")
	self.tableView = Utils:scrollView2TableView(list)
	self.tableView:setDirection(TFTableView.TFSCROLLVERTICAL)
	self.tableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.tableCellSize,self))
    self.tableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCells,self))
    self.tableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex,self))
end

function FubenMonsterReward:tableCellSize(tableView, idx)
	local size = self.Panel_ScoreItem:getSize()
    return size.height, size.width + 5
end

function FubenMonsterReward:numberOfCells(tableView)
	local size = #(self.curBtn.data or {});
	
    return size
end

function FubenMonsterReward:tableCellAtIndex(tableView,idx)
    local cell = tableView:dequeueCell()
    local item = nil
    if nil == cell then
        cell = TFTableViewCell:create()
        item = self.Panel_ScoreItem:clone()
        item:show()
        item:setPosition(ccp(0,0))
        cell:addChild(item)
        cell.item = item	
	else
		item = cell.item
    end

	self:initCell(item, self.curBtn.data[idx + 1])
    return cell
end

function FubenMonsterReward:initCell(cell, data)

	local rewardStep = cell:getChildByName("rewardStep")
	rewardStep:setTextById(data.config.des)
	local Button_CanGet = cell:getChildByName("Button_CanGet")
	local Button_CannotGet = cell:getChildByName("Button_CannotGet")
	local LabelhasGet = cell:getChildByName("LabelhasGet")
	local Label_progress = cell:getChildByName("Label_progress")
	Label_progress:setVisible(self.curBtn == self.tabAchive)
	Label_progress:setTextById(800005, data.taskInfo.progress, data.config.progress)
	if data.taskInfo.status == EC_TaskStatus.ING then
		LabelhasGet:setVisible(false)
		Button_CannotGet:setVisible(true)
		Button_CannotGet:setGrayEnabled(true)
		Button_CanGet:setVisible(false)	

		Button_CannotGet:onClick(function()
		Utils:showTips(2109034)
	end)
	elseif data.taskInfo.status == EC_TaskStatus.GET then
		LabelhasGet:setVisible(false)
		Button_CannotGet:setVisible(false)
		Button_CanGet:setVisible(true)
		Button_CanGet:onClick(function()
			TaskDataMgr:send_TASK_SUBMIT_TASK(data.taskInfo.cid)
		end)
	elseif data.taskInfo.status == EC_TaskStatus.GETED then
		LabelhasGet:setVisible(true)
		Button_CannotGet:setVisible(false)
		Button_CanGet:setVisible(false)
	end

	if cell.rewardList then
		cell.rewardList:removeAllItems()
		cell.rewardList = nil
	end
	cell.rewardList = UIListView:create(TFDirector:getChildByPath(cell, "rewardList"))
	cell.rewardList:setItemsMargin(2)
	for k, v in pairs(data.config.reward) do
		local panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
		PrefabDataMgr:setInfo(panel_goodsItem, tonumber(v[1]), v[2])
		panel_goodsItem:setScale(0.75)
		cell.rewardList:pushBackCustomItem(panel_goodsItem)
	end
end

function FubenMonsterReward:onTaskReceiveEvent(reward)
	 Utils:showReward(reward)
	self:initRewardList()
	self:bindData()
	self.tableView:reloadData()
end


return FubenMonsterReward

--endregion
