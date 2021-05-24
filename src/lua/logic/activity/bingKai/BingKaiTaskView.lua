--[[
    @desc：BingKaiTaskView
    @date: 2021-03-24 14:28:50
]]

local BingKaiTaskView = class("BingKaiTaskView",BaseLayer)

function BingKaiTaskView:initData(activityId)
    self.activityId = activityId
    self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)

    self.autoRewardItems = {}
    for i, v in ipairs(self.activityInfo.extendData.autoRewardItems) do
        self.autoRewardItems[v] = i
    end
    self.taskItems = {}
    dump(self.activityInfo)
end

function BingKaiTaskView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.bingKaiTaskView")
end

function BingKaiTaskView:initUI(ui)
    self.super.initUI(self,ui)
    self.listTask = UIListView:create(self._ui.list_task)
    self.listTask:setItemsMargin(5)

    local year, month, day = Utils:getDate(self.activityInfo.showStartTime or 0)
	self._ui.act_timeStart:setTextById(1410001,year, month, day)
	year, month, day = Utils:getDate(self.activityInfo.endTime or 0)
    self._ui.act_timeEnd:setTextById(1410001,year, month, day)

    if self.activityInfo.extendData.string then
        self._ui.lab_tip:setText(self.activityInfo.extendData.string)
    end

    self:updataListView()
end

function BingKaiTaskView:addTaskItem()
    local item = self._ui.Panel_taskItem:clone()
    local foo = {}
    foo.root = item
    foo.img_ing = TFDirector:getChildByPath(foo.root, "img_ing")
    foo.img_complete = TFDirector:getChildByPath(foo.root, "img_complete")
    foo.lab_complets = TFDirector:getChildByPath(foo.root, "lab_complets")
    foo.img_canGetAward = TFDirector:getChildByPath(foo.root, "img_canGetAward")
    foo.Label_progress = TFDirector:getChildByPath(foo.root, "Label_progress")
    foo.Label_progressTxt = TFDirector:getChildByPath(foo.root, "Label_progressTxt")
    foo.Label_desc = TFDirector:getChildByPath(foo.root, "Label_desc")
    foo.Button_goto = TFDirector:getChildByPath(foo.root, "Button_goto")
    foo.Button_receive = TFDirector:getChildByPath(foo.root, "Button_receive")
    foo.listAwards = UIListView:create(TFDirector:getChildByPath(foo.root, "ScrollView_awards"))
    foo.listAwards:setItemsMargin(18)
    self.taskItems[item] = foo
    self.listTask:pushBackCustomItem(item)
end

function BingKaiTaskView:updataListView()
    self.taskInfo = {}
    local taskData = ActivityDataMgr2:getItems(self.activityId)
    for i, _id in pairs(taskData) do
        local _taskInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, _id)
        if not self.autoRewardItems[_id] then
            table.insert(self.taskInfo, _taskInfo)
        end
    end

    table.sort(self.taskInfo, function(a, b)
        local stateA = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, a.id).status
        local stateB = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, b.id).status
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

function BingKaiTaskView:updateItem(item, data)
    local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, data.id)
    local extCfg = data.extendData
    item.img_ing:setVisible(progressInfo.status == EC_TaskStatus.ING)
    item.img_canGetAward:setVisible(progressInfo.status == EC_TaskStatus.GET)
    item.img_complete:setVisible(progressInfo.status == EC_TaskStatus.GETED)
    item.lab_complets:setVisible(progressInfo.status == EC_TaskStatus.GETED)
    item.Label_progress:setTextById(800005, progressInfo.progress, data.target)
    item.Label_desc:setText(extCfg.des2)
    item.Button_goto:setVisible(extCfg.jumpInterface and extCfg.jumpInterface ~= 0 and progressInfo.status == EC_TaskStatus.ING)
    item.Button_receive:setVisible(progressInfo.status == EC_TaskStatus.GET)

    local _ccColor 
    if progressInfo.status == EC_TaskStatus.GET then
        _ccColor = ccc3(26, 136, 105)
    else
        _ccColor = ccc3(86, 186, 255)
    end
    item.Label_progressTxt:setFontColor(_ccColor)
    item.Label_progress:setFontColor(_ccColor)

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
        ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId , data.id)
    end)
end

function BingKaiTaskView:registerEvents()
    local shareClick = false
    self._ui.btn_share:onClick(function()
        if not shareClick then
            self:timeOut(function()
                Utils:openView("activity.fanShi.FanShiSharePopView", self.activityId, "ui/activity/bingKai/share.png")
                shareClick = false
            end, 0.2)
        end
    end)
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onUpdateProgressEvent, self))
end


function BingKaiTaskView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId == activitId then
    	Utils:showReward(reward)
    end
end

function BingKaiTaskView:onUpdateProgressEvent()
    self:updataListView()
end

function BingKaiTaskView:onShow()
    self.super.onShow(self)
end

return BingKaiTaskView