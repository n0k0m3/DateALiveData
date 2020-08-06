local AgoraTaskView = class("AgoraTaskView", BaseLayer)

local stateIcon = {
    [0] = "ui/agora/task/icon_0.png",-- 进行中
    [1] = "ui/agora/task/icon_1.png",    -- 可领取
    [2] = "ui/agora/task/icon_2.png",    -- 已领取
}

function AgoraTaskView:ctor()
    self.super.ctor(self)
    self:initData()
    self:showPopAnim(true)
    self:init("lua.uiconfig.agora.agoraTaskView")
end

function AgoraTaskView:initData()
    self.taskItems_ = {}
end

function AgoraTaskView:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui

    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")
    self.Label_title = TFDirector:getChildByPath(self.ui, "Label_title")
    self.Label_cooltip = TFDirector:getChildByPath(self.ui, "Label_cooltip")
    self.Label_cool_time = TFDirector:getChildByPath(self.ui, "Label_cool_time"):hide()

    local ScrollView_task = TFDirector:getChildByPath(self.ui, "ScrollView_task")
    self.ListView_task = UIListView:create(ScrollView_task)
    self.ListView_task:setItemsMargin(5)

    self.Panel_taskItem = TFDirector:getChildByPath(self.ui, "Panel_taskItem")
    self.totalTime = ServerDataMgr:getServerTime()+3600*6+25
    self:initUiInfo()
end

function AgoraTaskView:initUiInfo()

    self.Label_cooltip:setTextById(303037)
    self.Label_title:setTextById(303068)
    self:updateTaskList()
end

function AgoraTaskView:updateTaskList()

    self.activityId_ = nil
    local activityIds = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.CHRISTMAS)
    for k,v in ipairs(activityIds) do
        local itemInfo = ActivityDataMgr2:getItems(v)
        if itemInfo and itemInfo[1] ~= EC_Activity_CHRISTMAS_Subtype.ONLY_RECORD then
            self.activityId_ = v
            break
        end
    end

    if not self.activityId_ then
        return
    end

    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)

    self.taskData_ = {}
    local itemInfo = ActivityDataMgr2:getItems(self.activityId_)
    for k,v in ipairs(itemInfo) do
        if v ~= EC_Activity_CHRISTMAS_Subtype.ONLY_RECORD then
            table.insert(self.taskData_,v)
        end
    end

    local items = self.ListView_task:getItems()
    local gap = #items - #self.taskData_

    for i = 1, math.abs(gap) do
        if gap > 0 then
            local item = self.ListView_task:getItem(1)
            self.taskItems_[item] = nil
            self.ListView_task:removeItem(1)
        else
            local item = self:addTaskItem()
            self.ListView_task:pushBackCustomItem(item)
        end
    end
    for i, v in ipairs(self.ListView_task:getItems()) do
        self:updateTaskItem(i)
    end
end

function AgoraTaskView:addTaskItem()
    local Panel_taskItem = self.Panel_taskItem:clone()
    local foo = {}
    foo.root = Panel_taskItem
    foo.Image_icon = TFDirector:getChildByPath(foo.root, "Image_icon")
    foo.Label_desc = TFDirector:getChildByPath(foo.root, "Label_desc")
    foo.Label_state = TFDirector:getChildByPath(foo.root, "Label_state")
    foo.Image_diban = TFDirector:getChildByPath(foo.root, "Image_diban")
    foo.Image_finish = TFDirector:getChildByPath(foo.root, "Image_finish")
    foo.Label_desc = TFDirector:getChildByPath(foo.root, "Label_desc")

    foo.Image_reward = {}
    for i = 1, 3 do
        local bar = {}
        bar.root = TFDirector:getChildByPath(foo.root, "Image_reward_" .. i)
        bar.Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        bar.Panel_goodsItem:AddTo(bar.root):Pos(0, 0)
        foo.Image_reward[i] = bar
    end
    foo.Button_receive = TFDirector:getChildByPath(foo.root, "Button_receive")
    foo.Label_receive = TFDirector:getChildByPath(foo.root, "Label_receive")
    foo.Label_receive:setTextById(1300008)
    self.taskItems_[foo.root] = foo

    return Panel_taskItem
end

function AgoraTaskView:updateTaskItem(index)
    local activityInfo = self.activityInfo_
    local itemId = self.taskData_[index]

    local itemInfo = ActivityDataMgr2:getItemInfo(activityInfo.activityType, itemId)
    local progress = ActivityDataMgr2:getProgress(activityInfo.activityType, itemId)
    local progressInfo = ActivityDataMgr2:getProgressInfo(activityInfo.activityType, itemId)

    local item = self.ListView_task:getItem(index)
    local foo = self.taskItems_[item]

    foo.Image_icon:setTexture(stateIcon[progressInfo.status])

    local goodsId, goodsNum
    for i, v in ipairs(foo.Image_reward) do
        local id, num = next(itemInfo.reward, goodsId)
        if id then
            goodsId = id
            goodsNum = num
        end
        v.root:setVisible(tobool(id))
        if v.root:isVisible() then
            PrefabDataMgr:setInfo(v.Panel_goodsItem, goodsId, goodsNum)
        end
    end

    foo.Label_state:setVisible(progressInfo.status ~= EC_TaskStatus.GET)
    if progressInfo.status == EC_TaskStatus.GETED then
        foo.Label_state:setTextById(303039)
        foo.Label_state:setColor(ccc3(162,164,200));
    elseif progressInfo.status == EC_TaskStatus.ING then
        foo.Label_state:setTextById(2100020)
        foo.Label_state:setColor(ccc3(255,255,255));
    end

    foo.Label_desc:setText(itemInfo.extendData.des2)

    foo.Image_diban:setVisible(progressInfo.status ~= EC_TaskStatus.GETED)
    foo.Image_finish:setVisible(progressInfo.status == EC_TaskStatus.GETED)

    foo.Button_receive:setVisible(progressInfo.status == EC_TaskStatus.GET)
    foo.Button_receive:onClick(function()
        ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(activityInfo.id, itemId)
    end)

end

function AgoraTaskView:formateTime(timeVal)

    if timeVal < 0 then
        timeVal = 0
    end
    local hour= math.floor(timeVal / 3600)
    local min = math.floor(timeVal % 86400 % 3600 / 60)
    local seconds = math.floor(timeVal % 86400 % 3600 % 60 / 1)
    return string.format("%02d:%02d:%02d", hour, min, seconds)
end

function AgoraTaskView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId_ ~= activitId then return end
    Utils:showReward(reward)
end

function AgoraTaskView:onUpdateProgressEvent()
    self:updateTaskList()
end

function AgoraTaskView:registerEvents()

    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onUpdateProgressEvent, self))

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return AgoraTaskView