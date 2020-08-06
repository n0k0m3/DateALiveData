
local AssistMainView = class("AssistMainView", BaseLayer)

function AssistMainView:initData(selectActivityId)
    self.defaultSelectActivityId_ = selectActivityId

    self.activityItem_ = {}
    self.activityModel_ = {}

    self.createModelClass_ = {
        [EC_ActivityType2.TASK] = requireNew("lua.logic.activity.TaskActivityView"),
        [EC_ActivityType2.STORE] = requireNew("lua.logic.activity.StoreActivityView"),
        [EC_ActivityType2.ASSIST] = requireNew("lua.logic.activity.AssistActivityView"),
    }
end

function AssistMainView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.activityMainView")
end

function AssistMainView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_activityItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_activityItem")

    local ScrollView_activity = TFDirector:getChildByPath(self.Panel_root, "ScrollView_activity")
    self.ListView_activity = UIListView:create(ScrollView_activity)
    self.Panel_activity = TFDirector:getChildByPath(self.Panel_root, "Panel_activity")

    self:refreshView()
end

function AssistMainView:addActivityItem()
    local Panel_activityItem = self.Panel_activityItem:clone()
    local foo = {}
    foo.root = Panel_activityItem
    foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select")
    foo.Image_icon = TFDirector:getChildByPath(foo.root, "Image_icon")
    foo.Image_new = TFDirector:getChildByPath(foo.Image_icon, "Image_new"):hide()
    self.activityItem_[foo.root] = foo
    self.ListView_activity:pushBackCustomItem(foo.root)
end

function AssistMainView:updateActivtyItem(index)
    local activity = self.activityInfo_[index]

    local item = self.ListView_activity:getItem(index)
    local foo = self.activityItem_[item]
    foo.Image_icon:setTexture(activity.titleIcon)
    foo.root:onClick(function()
            self:selectActivity(index)
    end)

    self:updateActivtyItemRedPoint(index)
end

function AssistMainView:updateActivtyItemRedPoint(index)
    local activity = self.activityInfo_[index]
    local item = self.ListView_activity:getItem(index)
    local foo = self.activityItem_[item]

    local isShow = ActivityDataMgr2:isShowRedPoint(activity.id)
    foo.Image_new:setVisible(isShow)
end

function AssistMainView:selectActivity(index, force)
    if #self.activityInfo_ == 0 then return end
    if self.selectIndex_ == index and not force then return end
    self.selectIndex_ = index

    for i, v in ipairs(self.ListView_activity:getItems()) do
        local isSelect = i == index
        local foo = self.activityItem_[v]
        foo.Image_select:setVisible(isSelect)
        foo.Image_icon:setOpacity(isSelect and 255 or 125)
    end

    local activityInfo = self.activityInfo_[index]
    local type_ = activityInfo.activityType

    local model = self.activityModel_[activityInfo.id]
    if not model then
        model = self:addModelItem(activityInfo.id, type_)
        self.activityModel_[activityInfo.id] = model
    end
    if model and model.updateActivity then
        model:updateActivity()
    end

    for k, v in pairs(self.activityModel_) do
        v:setVisible(activityInfo.id == k)
    end
end

function AssistMainView:addModelItem(activitId, type_)
   local modelClass = self.createModelClass_[type_]
    local model
    if modelClass then
        model = modelClass:new(activitId)
        self:addLayerToNode(model, self.Panel_activity)
    end
    return model
end


function AssistMainView:refreshView()
    self:updateAllActivity()
end

function AssistMainView:updateAllActivity()
    self.activityInfo_ = ActivityDataMgr2:getAssistActivityInfo()
    local items = self.ListView_activity:getItems()
    local cap = #self.activityInfo_ - #items

    for i = 1, math.abs(cap) do
        if cap > 0 then
            self:addActivityItem()
        else
            local item = self.ListView_activity:getItem(1)
            self.ListView_activity:removeItem(1)
            self.activityItem_[item] = nil
        end
    end

    -- 移除没有的活动
    for k, v in pairs(self.activityModel_) do
        local activityInfo = ActivityDataMgr2:getActivityInfo(k)
        if not activityInfo then
            v:removeFromParent()
            self.activityModel_[k] = nil
        end
    end

    -- 更新活动信息
    for i, v in ipairs(self.activityInfo_) do
        self:updateActivtyItem(i)
    end

    -- 选中
    if self.selectIndex_ then
        if self.selectIndex_ > #self.activityInfo_ then
            self:selectActivity(#self.activityInfo_, true)
        else
            self:selectActivity(self.selectIndex_, true)
        end
    else
        local index = 1
        if self.defaultSelectActivityId_ then
            for i, v in ipairs(self.activityInfo_) do
                if v.id == self.defaultSelectActivityId_ then
                    index = i
                    break
                end
            end
        end
        self:selectActivity(index, true)
    end

    self:addCountDownTimer()
end

function AssistMainView:registerEvents()
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onUpdateProgressEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.onUpdateActivityEvent, self))
end

function AssistMainView:removeEvents()
    self:removeCountDownTimer()
end

function AssistMainView:onCountDownPer()
    for i, v in ipairs(self.activityInfo_) do
        local model = self.activityModel_[v.id]
        if model and model.onUpdateCountDownEvent then
            model:onUpdateCountDownEvent()
        end
    end
end

function AssistMainView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.onCountDownPer, self))
    end
end

function AssistMainView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
    end
end

function AssistMainView:onUpdateProgressEvent()
    local activityInfo = self.activityInfo_[self.selectIndex_]
    local model = self.activityModel_[activityInfo.id]
    if model and model.onUpdateProgressEvent then
        model:onUpdateProgressEvent()
    end

    for i, v in ipairs(self.activityInfo_) do
        self:updateActivtyItemRedPoint(i)
    end
end

function AssistMainView:onSubmitSuccessEvent(activitId, itemId, reward)
   local model = self.activityModel_[activitId]
    if model and model.onSubmitSuccessEvent then
        model:onSubmitSuccessEvent(activitId, itemId, reward)
    end
end

function AssistMainView:onUpdateActivityEvent()
    self:updateAllActivity()
end

return AssistMainView
