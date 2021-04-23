--[[
    @desc：FanShiTaskView
    @date: 2020-12-28 11:13:30
]]

local FanShiTaskView = class("FanShiTaskView",BaseLayer)

function FanShiTaskView:initData(activityId)
    self.activityId_ = activityId
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    self.taskInfo = {}
    local taskData = ActivityDataMgr2:getItems(activityId)
    for i, _id in pairs(taskData) do
        local _taskInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, _id)
        table.insert(self.taskInfo, _taskInfo)
    end
   
    self.taskItems = {}
    self.isRequest = false
    -- dump(self.activityInfo_)
    -- dump(self.taskInfo)
end

function FanShiTaskView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.fanShiTaskView")
end

function FanShiTaskView:initUI(ui)
    self.super.initUI(self,ui)
    self.listTask = UIListView:create(self._ui.list_task)
    -- self.listTask:setItemsMargin(20)
    local year, month, day = Utils:getDate(self.activityInfo_.showStartTime or 0)
	self._ui.act_timeStart:setTextById(1410001,year, month, day)
	year, month, day = Utils:getDate(self.activityInfo_.endTime or 0)
    self._ui.act_timeEnd:setTextById(1410001,year, month, day)

    self:updataListView()
end

function FanShiTaskView:addTaskItem()
    local item = self._ui.Panel_taskItem:clone()
    local foo = {}
    foo.root = item
    foo.Label_progress = TFDirector:getChildByPath(foo.root, "Label_progress")
    foo.Image_icon = TFDirector:getChildByPath(foo.root, "Image_icon")
    foo.Label_name = TFDirector:getChildByPath(foo.root, "Label_name")
    foo.Label_desc = TFDirector:getChildByPath(foo.root, "Label_desc")
    foo.Button_goto = TFDirector:getChildByPath(foo.root, "Button_goto")
    foo.Button_receive = TFDirector:getChildByPath(foo.root, "Button_receive")
    foo.Label_geted = TFDirector:getChildByPath(foo.root, "Label_geted")
    foo.listAwards = UIListView:create(TFDirector:getChildByPath(foo.root, "ScrollView_awards"))
    foo.listAwards:setItemsMargin(10)
    self.taskItems[item] = foo
    self.listTask:pushBackCustomItem(item)
end

function FanShiTaskView:updataListView()
    table.sort(self.taskInfo, function(a, b)
        local stateA = ActivityDataMgr2:getProgressInfo(EC_ActivityType2.FAN_SHI_TASK, a.id).status
        local stateB = ActivityDataMgr2:getProgressInfo(EC_ActivityType2.FAN_SHI_TASK, b.id).status
        if stateA ~= stateB then
            if stateA == EC_TaskStatus.GET then
                return true
            elseif stateB == EC_TaskStatus.GET then
                return false
            elseif stateA == EC_TaskStatus.GETED then
                return false
            elseif stateB == EC_TaskStatus.GETED then
                return true
            end
        else
            return a.rank < b.rank
        end
    end)

    local gap = #self.taskInfo - #self.listTask:getItems()
    if gap > 0 then
        for i = 1 , gap do
            self:addTaskItem()
        end
    else
        for i = 1 , math.abs(gap) do
            self.listTask:removeItem(1)
        end
    end

    for i, v in ipairs(self.listTask:getItems()) do
        local item = self.taskItems[v]
        self:updateItem(item, self.taskInfo[i])
    end
end

function FanShiTaskView:updateItem(item, data)
    local progressInfo = ActivityDataMgr2:getProgressInfo(EC_ActivityType2.FAN_SHI_TASK, data.id)
    local extCfg = data.extendData
    item.Label_progress:setTextById(800005, progressInfo.progress, data.target)
    item.Label_name:hide()
    item.Image_icon:setTexture(extCfg.icon)
    item.Label_desc:setText(extCfg.des2)
    item.Button_goto:setVisible(extCfg.jumpInterface and extCfg.jumpInterface ~= 0 and progressInfo.status == EC_TaskStatus.ING)
    item.Button_receive:setVisible(progressInfo.status == EC_TaskStatus.GET)
    item.Label_geted:setVisible(progressInfo.status == EC_TaskStatus.GETED)

    local _gap = table.count(data.reward) - #item.listAwards:getItems()
    if _gap > 0 then
        for i = 1, _gap do
            local goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            goods:setScale(0.7)
            item.listAwards:pushBackCustomItem(goods)
        end
    else
        for i = 1, math.abs(_gap) do
            item.listAwards:removeItem(1)
        end
    end
    local i = 0
    for _id, _num in pairs(data.reward) do
        i = i + 1
        local goods = item.listAwards:getItems()[i]
        PrefabDataMgr:setInfo(goods, _id, _num)
    end

    item.Button_goto:onClick(function()
        FunctionDataMgr:enterByFuncId(extCfg.jumpInterface)
    end)
    item.Button_receive:onClick(function()
        ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId_ , data.id)
    end)
end

function FanShiTaskView:registerEvents()
    local shareClick = false
    self._ui.btn_share:onClick(function()
        if not shareClick then
            self:timeOut(function()
                Utils:openView("activity.fanShi.FanShiSharePopView", self.activityId_)
                shareClick = false
            end, 0.2)
        end
    end)
    EventMgr:addEventListener(self, EV_FANSHI_AWARD_DATA, handler(self.onRecvAwardPop, self))
end


function FanShiTaskView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId_ == activitId then
    	Utils:showReward(reward)
    end
end

function FanShiTaskView:onUpdateProgressEvent()
    self:updataListView()
end

function FanShiTaskView:onShow()
    self.super.onShow(self)
    if not self.isRequest then
        ActivityDataMgr2:SEND_ACTIVITY2_REQ_REVERSE_TEN_WINDOW()
        self.isRequest = true
    end
end

function FanShiTaskView:onRecvAwardPop(awardData)
    if awardData.coin and table.count(awardData.coin) > 0 then
        Utils:openView("activity.fanShi.FanShiAwardPopView", awardData.coin)
    end
end

return FanShiTaskView