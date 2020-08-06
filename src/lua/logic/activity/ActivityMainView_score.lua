

local ActivityMainView_score = class("ActivityMainView_score", BaseLayer)
local DEFAULT_SHOW_TYPE = 1000
local Permanent_Activity = 9999
function ActivityMainView_score:initData(selectActivityId, type_)
    self.defaultSelectActivityId_ = selectActivityId
    self.activityShowType = type_
    self.activityItem_ = {}
    self.activityModel_ = {}

    self.createModelClass_ = {
        [1] = requireNew("lua.logic.activity.ScoreOnlineRewardView"),
        [2] = requireNew("lua.logic.activity.ActivityPermanent"),
    }

    
end
function ActivityMainView_score:getClosingStateParams()
    local activityInfo = self.activityInfo_[self.selectIndex_]
    return activityInfo and {activityInfo.id}
end

function ActivityMainView_score:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.activityMainView")
end

function ActivityMainView_score:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_activityItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_activityItem")

    local ScrollView_activity = TFDirector:getChildByPath(self.Panel_root, "ScrollView_activity")
    self.ListView_activity = UIListView:create(ScrollView_activity)
    self.Panel_activity = TFDirector:getChildByPath(self.Panel_root, "Panel_activity")

    self:refreshView()

end

function ActivityMainView_score:onShow()
    self.super.onShow(self)
--    for k,v in pairs(self.activityInfo_) do
--        if v.activityType == EC_ActivityType2.WELFARE_JUMP then
--            self:updateActivtyItemRedPoint(k)
--        end
--    end
end

function ActivityMainView_score:refreshView()
    self:updateAllActivity()
    self:addCountDownTimer()
end

function ActivityMainView_score:updateAllActivity()
	--print("self.activityShowType=" .. self.activityShowType)
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(nil ,self.activityShowType)
    if not self.activityInfo_ then
        return
    end
    print("活动数据")
    dump(self.activityInfo_)
    --
    self.ListView_activity:removeAllItems()

    for i = 1,2 do 
        self:addActivityItem()
        self:updateActivtyItem(i)
    end


    -- 选中
    if self.selectIndex_ then
        self:selectActivity(self.selectIndex_, true)
    else
        local index = 1
        if self.defaultSelectActivityId_ then
            for i, v in ipairs(self.activityInfo_ or {}) do
                if v.id == self.defaultSelectActivityId_ then
                    index = i
                    break
                end
            end
        end
        self:selectActivity(index, true)
    end
end

function ActivityMainView_score:updateActivtyItem(index)
    local item = self.ListView_activity:getItem(index)
    local foo = self.activityItem_[item]
    --foo.Image_icon:setTexture(activity.titleIcon)
    if index == 2 then
        foo.Image_icon:setTexture("ui/score/tab2.png")
    elseif index == 1 then
        foo.Image_icon:setTexture("ui/score/tab1.png")
    end
    foo.root:onClick(function()
            self:selectActivity(index)
    end)

    --self:updateActivtyItemRedPoint(index)
end

function ActivityMainView_score:addModelItem(activitId, type_)
    local modelClass = self.createModelClass_[type_]
    if modelClass then
        local model = modelClass:new(activitId)
        self:addLayerToNode(model, self.Panel_activity)
        return model
    else
        Box("not found ModelClass for type:"..tostring(type_))
    end
end

function ActivityMainView_score:selectActivity(index, force)
    if #self.activityInfo_ == 0 then return end
    if self.selectIndex_ == index and not force then return end
    self.selectIndex_ = index

    for i, v in ipairs(self.ListView_activity:getItems()) do
        local isSelect = i == index
        local foo = self.activityItem_[v]
        foo.Image_select:setVisible(isSelect)
        foo.Image_icon:setOpacity(isSelect and 255 or 125)
    end

    local activityInfo = self.activityInfo_[index] or {}

    local model = self.activityModel_[index]
    if not model then
        model = self:addModelItem(activityInfo.id, index)
        self.activityModel_[index] = model
    end

    if model and model.showDefault then
        model.showDefault(model)
    end

    if model and model.updateActivity then
        model:updateActivity(self.activityInfo_[index].items)
    end
    

    for k, v in pairs(self.activityModel_) do
        v:setVisible(index == k)
    end
end

function ActivityMainView_score:updateActivtyItemRedPoint(index)
    local activity = self.activityInfo_[index]
    local item = self.ListView_activity:getItem(index)
    local foo = self.activityItem_[item]

    local isShow = ActivityDataMgr2:isShowRedPoint(activity.id)
    foo.Image_new:setVisible(isShow)
end

function ActivityMainView_score:addActivityItem()
    local Panel_activityItem = self.Panel_activityItem:clone()
    local foo = {}
    foo.root = Panel_activityItem
    foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select")
    foo.Image_icon = TFDirector:getChildByPath(foo.root, "Image_icon")
    foo.Image_new = TFDirector:getChildByPath(foo.Image_icon, "Image_new"):hide()
    self.activityItem_[foo.root] = foo
    self.ListView_activity:pushBackCustomItem(foo.root)
end

function ActivityMainView_score:addTaskModel()
    local method = self.createModelMethod_[v.activityType]
    if method then
        local view = method(self)
        view:updateActivity(v.id)
        self:addLayerToNode(view, self.Panel_activity)
    end
end

function ActivityMainView_score:addStoreModel()

end

function ActivityMainView_score:onHide()
    self.super.onHide(self)
    TFDirector:removeMEGlobalListener("applicationWillEnterForeground",function()
        EventMgr:dispatchEvent("applicationWillEnterForeground")
    end)
end

function ActivityMainView_score:registerEvents()
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onUpdateProgressEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.onUpdateActivityEvent, self))

    TFDirector:addMEGlobalListener("applicationWillEnterForeground", function()
        EventMgr:dispatchEvent("applicationWillEnterForeground")
    end)
end

function ActivityMainView_score:removeEvents()
    self:removeCountDownTimer()
end

function ActivityMainView_score:onCountDownPer()
    for i, v in ipairs(self.activityInfo_ or {}) do
        local model = self.activityModel_[v.id]
        if model and model.onUpdateCountDownEvent then
            model:onUpdateCountDownEvent()
        end
    end
end

function ActivityMainView_score:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.onCountDownPer, self))
    end
end

function ActivityMainView_score:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
    end
end

function ActivityMainView_score:onSubmitSuccessEvent(activitId, itemId, reward)
    local model = self.activityModel_[self.selectIndex_]
    if model and model.onSubmitSuccessEvent then
        model:onSubmitSuccessEvent(activitId, itemId, reward)
    end
end

function ActivityMainView_score:onUpdateProgressEvent()
    local activityInfo = self.activityInfo_[self.selectIndex_]
    if not activityInfo then return end
    local model = self.activityModel_[activityInfo.id]
    if model and model.onUpdateProgressEvent then
        model:onUpdateProgressEvent()
    end

    for i, v in ipairs(self.activityInfo_) do
        self:updateActivtyItemRedPoint(i)
    end
end

function ActivityMainView_score:onUpdateActivityEvent()
    self:updateAllActivity()
end

return ActivityMainView_score
