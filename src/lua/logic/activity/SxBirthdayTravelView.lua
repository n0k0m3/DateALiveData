
local SxBirthdayTravelView = class("SxBirthdayTravelView", BaseLayer)

function SxBirthdayTravelView:initData()
    local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.SX_BIRTHDAY)
    if #activity > 0 then
        self.activityId_ = activity[1]
        self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    else
        Utils:showTips("没有十香生日活动")
    end
    self.taskItems_ = {}
end

function SxBirthdayTravelView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.activity.sxBirthdayTravelView")
end

function SxBirthdayTravelView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_taskItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_taskItem")

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")
    self.Label_name = TFDirector:getChildByPath(Image_content, "Label_name")
    local ScrollView_task = TFDirector:getChildByPath(Image_content, "ScrollView_task")
    self.ListView_task = UIListView:create(ScrollView_task)

    self:refreshView()
end

function SxBirthdayTravelView:addTaskItem()
    local foo = {}
    foo.root = self.Panel_taskItem:clone()
    foo.Image_receive_bg = TFDirector:getChildByPath(foo.root, "Image_receive_bg")
    foo.Label_name = TFDirector:getChildByPath(foo.Image_receive_bg, "Label_name")
    foo.Image_geted_bg = TFDirector:getChildByPath(foo.root, "Image_geted_bg")
	foo.finishMask = TFDirector:getChildByPath(foo.root, "finishMask")
    foo.Label_name_geted = TFDirector:getChildByPath(foo.Image_geted_bg, "Label_name_geted")
    foo.Image_percent = TFDirector:getChildByPath(foo.root, "Image_percent")
    foo.LoadingBar_percent = TFDirector:getChildByPath(foo.Image_percent, "LoadingBar_percent")
    foo.Label_progress = TFDirector:getChildByPath(foo.Image_percent, "Label_progress")
    local ScrollView_reward = TFDirector:getChildByPath(foo.root, "ScrollView_reward")
    foo.ListView_reward = UIListView:create(ScrollView_reward)
    foo.Button_receive = TFDirector:getChildByPath(foo.root, "Button_receive")
    foo.Label_receive = TFDirector:getChildByPath(foo.Button_receive, "Label_receive")
    foo.Label_geted = TFDirector:getChildByPath(foo.root, "Label_geted")
    foo.Label_ing = TFDirector:getChildByPath(foo.root, "Label_ing")
	foo.Label_Title = TFDirector:getChildByPath(foo.root, "Label_Title")
	foo.Label_Title:setTextById(13300446)

    self.taskItems_[foo.root] = foo
    self.ListView_task:pushBackCustomItem(foo.root)
end

function SxBirthdayTravelView:refreshView()
    self:updateAllTaskItem()
end

function SxBirthdayTravelView:updateAllTaskItem()
    if not self.activityId_ then return end

    local taskData = ActivityDataMgr2:getItems(self.activityId_)
	local tempTaskData = {}
	for i, val in ipairs(taskData) do
		local task = {id = val}
		local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, val)
		if progressInfo.status == EC_TaskStatus.GET then
			task.order = 1
		elseif progressInfo.status == EC_TaskStatus.ING then
			task.order = 2
		elseif progressInfo.status == EC_TaskStatus.GETED then
			task.order = 3
		end
		table.insert(tempTaskData, task)
	end
	table.sort(tempTaskData, function(a,b)		
		return a.order < b.order
	end)

    local items = self.ListView_task:getItems()
    local gap = #tempTaskData - #items
    for i = 1, math.abs(gap) do
        if gap > 0 then
            self:addTaskItem()
        else
            local item = self.ListView_task:getItem(1)
            self.taskItems_[item] = nil
            self.ListView_task:removeItem(1)
        end
    end

    for i, v in ipairs(tempTaskData) do
        local item = self.ListView_task:getItem(i)
        local foo = self.taskItems_[item]
        local taskInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, v.id)
		dump(taskInfo)
        local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, v.id)
        foo.Label_name:setText(taskInfo.extendData.des2)
        foo.Label_name_geted:setText(taskInfo.extendData.des2)
        foo.Image_receive_bg:setVisible(progressInfo.status ~= EC_TaskStatus.GETED)
        foo.Image_geted_bg:setVisible(progressInfo.status == EC_TaskStatus.GETED)
		foo.finishMask:setVisible(progressInfo.status == EC_TaskStatus.GETED)
        foo.Label_ing:setVisible(progressInfo.status == EC_TaskStatus.ING)
        foo.Button_receive:setVisible(progressInfo.status == EC_TaskStatus.GET)
        foo.Label_geted:setVisible(progressInfo.status == EC_TaskStatus.GETED)
        foo.Label_progress:setTextById(800005, progressInfo.progress, taskInfo.target)
        local percent = clampf(progressInfo.progress / taskInfo.target * 100, 0, 100)
        foo.LoadingBar_percent:setPercent(percent)

        foo.ListView_reward:removeAllItems()
        for cid, num in pairs(taskInfo.reward) do
            local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            Panel_goodsItem:Scale(0.7)
            PrefabDataMgr:setInfo(Panel_goodsItem, cid, num)
            foo.ListView_reward:pushBackCustomItem(Panel_goodsItem)
        end

        foo.Button_receive:onClick(function()
                ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId_, v.id)
        end)
        dump(taskInfo)
    end
end

function SxBirthdayTravelView:registerEvents()
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onUpdateProgressEvent, self))

    self.Button_close:onClick(function()
            AlertManager:closeLayer(self)
    end)
end

function SxBirthdayTravelView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId_ ~= activitId then return end
    Utils:showReward(reward)
    self:updateAllTaskItem()
end

function SxBirthdayTravelView:onUpdateProgressEvent()
    self:updateAllTaskItem()
end

return SxBirthdayTravelView
