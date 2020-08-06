local BlackAndWhiteTaskView = class("BlackAndWhiteTaskView", BaseLayer)


function BlackAndWhiteTaskView:initData()
    local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.BLACK_WHITE)
	
    --self.activityId_ = activity[1]
    if #activity > 0 then
		 self.activityId_ = activity[1]
        self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    else
        Utils:showTips(219007)
        return
    end
end


function BlackAndWhiteTaskView:ctor(...)
    self.super.ctor(self)
	self:initData()
	self:showPopAnim(true)
    self:init("lua.uiconfig.blackAndWhite.BlackAndWhiteTaskView")

end

function BlackAndWhiteTaskView:initUI(ui)
	self.super.initUI(self, ui)
	

    self.Panel_touch = TFDirector:getChildByPath(self.ui, "Panel_base")
    self.Panel_touch:setSwallowTouch(true)	
		
	
	self._taskItem = TFDirector:getChildByPath(ui, "Panel_task_item")
	
	self._closeBtn = TFDirector:getChildByPath(ui, "Button_close")
	
	local ScrollView_task = TFDirector:getChildByPath(ui, "ScrollView_task")
    self._scrollViewTask = UIListView:create(ScrollView_task)
    self._scrollViewTask:setItemsMargin(2)
	if self.activityId_ then
		self:refreshView()
	end
end

function BlackAndWhiteTaskView:onUpdateProgressEvent()
    self:refreshView()
end

function BlackAndWhiteTaskView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId_ ~= activitId then return end
    --self.receiveCount_ = self.receiveCount_ + 1
	self.receiveReward_ = {}
    --if self.receiveCount_ < #self.canGetItems_ then
    --    table.insertTo(self.receiveReward_, reward)
   -- else
        table.insertTo(self.receiveReward_, reward)
        Utils:showReward(self.receiveReward_)
    --end
end

function BlackAndWhiteTaskView:registerEvents()
	EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
	EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onUpdateProgressEvent, self))
	self._closeBtn:onClick(function()
        AlertManager:closeLayer(self)
    end)
	
		    self.Panel_touch:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

function BlackAndWhiteTaskView:refreshView()
	self.taskData = {}
    local tab1,tab2,tab3 = {},{},{}
	print("-----------------self.activityId_=" .. self.activityId_)
    local itemIds = ActivityDataMgr2:getItems(self.activityId_)
	print("-----------------#itemIds=" .. #itemIds .. ",self.activityId_=" .. self.activityId_)
    for k,v in ipairs(itemIds) do
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, v)
		dump(itemInfo)
		--if itemInfo.extendData.type == EC_ChronoCrossTaskType.Single then
            local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, v)
            if progressInfo.status == EC_TaskStatus.GET then
                table.insert(tab1,v)
            end
            if progressInfo.status == EC_TaskStatus.ING then
               table.insert(tab2,v)
            end
            if progressInfo.status == EC_TaskStatus.GETED then
                table.insert(tab3,v)
            end
        --end
	end
	
	 for k,v in ipairs(tab1) do
        table.insert(self.taskData,v)
    end

    for k,v in ipairs(tab2) do
        table.insert(self.taskData,v)
    end

    for k,v in ipairs(tab3) do
        table.insert(self.taskData,v)
    end
	
	local items = self._scrollViewTask:getItems()
    local gap = #items - #self.taskData

    for i = 1, math.abs(gap) do
        if gap > 0 then
            self._scrollViewTask:removeItem(1)
        else
            local item = self._taskItem:clone()
            self._scrollViewTask:pushBackCustomItem(item)
        end
    end

	for i = 1, #self.taskData do
		local item =  self._scrollViewTask:getItem(i)
		local data = self.taskData[i]
		self:updateItem(item,data)
	end	
end

function BlackAndWhiteTaskView:updateItem(item, data) 
	local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, data)
    local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, data)
	
	
	local label_TaskName = TFDirector:getChildByPath(item, "Label_BlackAndWhiteTaskView_1")
	label_TaskName:setTextById(itemInfo.details)
	
	local label_Desc =  TFDirector:getChildByPath(item, "Label_desc")
	label_Desc:setText(itemInfo.extendData.des2)

	local progress = (progressInfo.progress > itemInfo.target and itemInfo.target or progressInfo.progress)
	
	local label_Progress = TFDirector:getChildByPath(item, "Label_progress")
	label_Progress:setText( progress .."/"..itemInfo.target)
	
	local LoadingBar_progress = TFDirector:getChildByPath(item, "LoadingBar_progress")
	local percent = math.min(1, progress / itemInfo.target)
    LoadingBar_progress:setPercent(percent * 100)
	
	
	--奖励物品
	local Panel_reward = TFDirector:getChildByPath(item, "Panel_reward")
	
	local itemIndex = 0
    Panel_reward:removeAllChildren()
    for cid, num in pairs(itemInfo.reward) do
        itemIndex = itemIndex + 1
        local posX = 50 + (itemIndex-1)*110*0.8
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:Scale(0.8)
        Panel_goodsItem:setPosition(ccp(posX,45))
        Panel_reward:addChild(Panel_goodsItem)
        PrefabDataMgr:setInfo(Panel_goodsItem, cid, num)
    end
	
	
	local button_Receive = TFDirector:getChildByPath(item, "Button_Receive")
	local label_Conduct = TFDirector:getChildByPath(item, "Label_Conduct")
	local label_Geted = TFDirector:getChildByPath(item, "Label_Geted")
	local isReceive = progressInfo.status == EC_TaskStatus.GET
    local isGeted = progressInfo.status == EC_TaskStatus.GETED
    local isIng = progressInfo.status == EC_TaskStatus.ING
	button_Receive:setVisible(isReceive)
    label_Conduct:setVisible(isIng)
    label_Geted:setVisible(isGeted)
	
	
	
    button_Receive:onClick(function()
        ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId_,data)
    end)

end

return BlackAndWhiteTaskView