

local ActivityMainView = class("ActivityMainView", BaseLayer)
local DEFAULT_SHOW_TYPE = 1000
function ActivityMainView:initData(selectActivityId,activityShowType)
    self.defaultSelectActivityId_ = selectActivityId
    self.activityItem_ = {}
    self.activityModel_ = {}

    self.createModelClass_ = {
        [DEFAULT_SHOW_TYPE] ={  ---默认
            [EC_ActivityType2.TASK] = requireNew("lua.logic.activity.TaskActivityView"),
            [EC_ActivityType2.STORE] = requireNew("lua.logic.activity.StoreActivityView"),
            [EC_ActivityType2.ENTRUST] = requireNew("lua.logic.activity.JumpActivityView"),
            [EC_ActivityType2.DROP] = requireNew("lua.logic.activity.DropActivityView"),
            [EC_ActivityType2.RECHARGE] = requireNew("lua.logic.activity.RechargeActivityView"),
            [EC_ActivityType2.NEWYEARDATING] = requireNew("lua.logic.activity.NewYearEntranceView"),
            [EC_ActivityType2.ADD_RECHARGE] = requireNew("lua.logic.activity.AddRechargeActivityView"),
            [EC_ActivityType2.VALENTINE] = requireNew("lua.logic.activity.ValentineActivityView"),
            [EC_ActivityType2.WHITEVALENTINE] = requireNew("lua.logic.activity.WhiteValentineActivityView"),
            [EC_ActivityType2.DAFUWENG] = requireNew("lua.logic.activity.ChunrijiActivityView"),
            [EC_ActivityType2.CLOTHESE_SUMMON] = requireNew("lua.logic.activity.ClotheseSummonView"),
            [EC_ActivityType2.SX_BIRTHDAY] = requireNew("lua.logic.activity.SxBirthdayActivityView"),
            [EC_ActivityType2.MAID_COFFEE] = requireNew("lua.logic.activity.CoffeeActivityView"),
            [EC_ActivityType2.CGCOLLECTED] = requireNew("lua.logic.activity.EntrustEntranceView"),
            [EC_ActivityType2.SUMMONACTIVITY] = requireNew("lua.logic.activity.SummonActivityView"),
            [EC_ActivityType2.DUANWU_1] = requireNew("lua.logic.activity.DuanwuActivityView"),
            --[EC_ActivityType2.DROP] = requireNew("lua.logic.activity.BingoActivityView"),
            [EC_ActivityType2.BINGOGAME] = requireNew("lua.logic.activity.BingoActivityView"),
            [EC_ActivityType2.DFW_SUMMER] = requireNew("lua.logic.activity.SummerActivityView"),
            [EC_ActivityType2.DFW_AUTUMN] = requireNew("lua.logic.activity.AutumnActivityView"),
            [EC_ActivityType2.WELFARE_RECHEAGE] = requireNew("lua.logic.activity.WelfareRechargeView"),
            [EC_ActivityType2.WELFARE_SIGN] = requireNew("lua.logic.activity.WelfareSignView"),
            [EC_ActivityType2.WELFARE_TASK] = requireNew("lua.logic.activity.JumpActivityView"),
            [EC_ActivityType2.WELFARE_JUMP] = requireNew("lua.logic.activity.JumpActivityView"),
            [EC_ActivityType2.WELFARE_GIFT] = requireNew("lua.logic.activity.GiftActivityView"),
            [EC_ActivityType2.CHRONO_CROSS] = requireNew("lua.logic.activity.ChronoCrossActivityView"),
            [EC_ActivityType2.ANNIVERSARY_PREHEAT] = requireNew("lua.logic.activity.AnniversaryPreheatView"),
            [EC_ActivityType2.ANNIVERSARY_FEEDBACK] = requireNew("lua.logic.activity.AnniversaryFeedbackView"),
            [EC_ActivityType2.ONEYEAR_CELEBRATION] = requireNew("lua.logic.oneYear.CelebrationView"),
            [EC_ActivityType2.ONEYEAR_WELFARE] = requireNew("lua.logic.oneYear.WelfareView"),
            [EC_ActivityType2.ZNQ_HG] = requireNew("lua.logic.activity.ActivityZhouNianQingHuiYi"),
			[EC_ActivityType2.BLACK_WHITE] = requireNew("lua.logic.activity.BlackAndWhiteActivityView"),
            [EC_ActivityType2.ONEYEAR_DROP] = requireNew("lua.logic.activity.DropActivityView"),
			[EC_ActivityType2.HALLOWEEN] = requireNew("lua.logic.activity.HalloweenActivityView"),
            [EC_ActivityType2.SERVER_FUND] = requireNew("lua.logic.activity.ServerRechargeSmallView"),
            [EC_ActivityType2.FUND] = requireNew("lua.logic.activity.ActivityFundView"),
            [EC_ActivityType2.KUANGSAN_FUBEN] = requireNew("lua.logic.activity.JumpActivityView"),
            [EC_ActivityType2.CHRISTMAS_PRE] = requireNew("lua.logic.activity.ChristmasPreView"),
			[EC_ActivityType2.SCALE_9_GRID] = requireNew("lua.logic.activity.ActivityScale9"),
            [EC_ActivityType2.CHRISTMAS_FIGHT] = requireNew("lua.logic.activity.MapActivityContainer"),
            [EC_ActivityType2.CRAZY_DIAMOND] = requireNew("lua.logic.activity.CrazyDiamondActivityView"),
            [EC_ActivityType2.TURNTABLE] = requireNew("lua.logic.activity.TurntableActivityView"),
            [EC_ActivityType2.DFW_NEW] = requireNew("lua.logic.activity.DfwNewActivityView")
        },
        [3] = {
            [EC_ActivityType2.ONEYEAR_WELFARE] = requireNew("lua.logic.oneYear.WelfareView"),
        },
        [4] = {


        },
        [5] = {
            [EC_ActivityType2.COURAGE] = requireNew("lua.logic.courage.CourageEnterView"),
            [EC_ActivityType2.COURAGE_TASK] = requireNew("lua.logic.courage.CourageTaskView"),
        },
        [6] = {
            [EC_ActivityType2.ASSIST] = requireNew("lua.logic.activity.KuangsanAssistView"),
            [EC_ActivityType2.ONEYEAR_CELEBRATION] = requireNew("lua.logic.oneYear.CelebrationView"),
            [EC_ActivityType2.KSAN_CARD] = requireNew("lua.logic.activity.KuangsanTaskView"),
            [EC_ActivityType2.WELFARE_JUMP] = requireNew("lua.logic.activity.ActivityKuangSanEntry"),
        },
		[7] = {
			[EC_ActivityType2.WELFARE_JUMP] = requireNew("lua.logic.activity.ChrismasActivityEntry"),
		}
    }

    if activityShowType then
        self.topBarFileName = "ActivityMainView"..activityShowType
        self.activityShowType = activityShowType
    end

end

function ActivityMainView:getClosingStateParams()
    local activityInfo = self.activityInfo_[self.selectIndex_]
    return activityInfo and {activityInfo.id, activityInfo.extendData.activityShowType}
end

function ActivityMainView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    local uiName = "activityMainView"
    if self.activityShowType then
        uiName = "activityMainView"..self.activityShowType
    end
    self:init("lua.uiconfig.activity."..uiName)
end

function ActivityMainView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_activityItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_activityItem")

    local ScrollView_activity = TFDirector:getChildByPath(self.Panel_root, "ScrollView_activity")
    self.ListView_activity = UIListView:create(ScrollView_activity)
    self.Panel_activity = TFDirector:getChildByPath(self.Panel_root, "Panel_activity")

    self:refreshView()
end

function ActivityMainView:onShow()
    self.super.onShow(self)
    for k,v in pairs(self.activityInfo_) do
        if v.activityType == EC_ActivityType2.WELFARE_JUMP then
            self:updateActivtyItemRedPoint(k)
        end
    end
end

function ActivityMainView:refreshView()
    self:updateAllActivity()
    self:addCountDownTimer()
end

function ActivityMainView:updateAllActivity()
	--print("self.activityShowType=" .. self.activityShowType)
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(nil ,self.activityShowType)

    --在线积分活动不显示在活动窗口里
    for i = 1, #self.activityInfo_ do
        local activityInfo = self.activityInfo_[i]
        local type_ = activityInfo.activityType
        if type_ == EC_ActivityType2.ONLINE_SCORE_REWARD then
            table.remove(self.activityInfo_, i)
        end
    end
    -- 中秋节不显示掉落活动到界面
    if ActivityDataMgr2:getActivityUIType() == 1 then
        for i, v in ipairs(self.activityInfo_) do
            if v.activityType ==  EC_ActivityType2.DROP or v.activityType == EC_ActivityType2.ONEYEAR_DROP then
                table.remove(self.activityInfo_, i)
                break
            end
        end
    end
    local items = self.ListView_activity:getItems()
    local gap = #self.activityInfo_ - #items
    for i = 1, math.abs(gap) do
        if gap > 0 then
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
            self:removeLayerFromNode(v, self.Panel_activity)
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
end

function ActivityMainView:updateActivtyItem(index)
    local activity = self.activityInfo_[index]

    local item = self.ListView_activity:getItem(index)
    local foo = self.activityItem_[item]
    foo.Image_icon:setTexture(activity.titleIcon)
    foo.root:onClick(function()
            self:selectActivity(index)
    end)

    self:updateActivtyItemRedPoint(index)
end

function ActivityMainView:addModelItem(activitId, type_)
    local modelClassMap
    if self.activityShowType  then 
        modelClassMap = self.createModelClass_[self.activityShowType] or self.createModelClass_[DEFAULT_SHOW_TYPE] 
    else
        modelClassMap = self.createModelClass_[DEFAULT_SHOW_TYPE] 
    end
    local modelClass = modelClassMap[type_] or self.createModelClass_[DEFAULT_SHOW_TYPE][type_]
    if modelClass then
        local model = modelClass:new(activitId)
        self:addLayerToNode(model, self.Panel_activity)
        return model
    else
        Box("not found ModelClass for type:"..tostring(type_))
    end
end

function ActivityMainView:selectActivity(index, force)
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
		print("activityInfo.id===============" .. activityInfo.id)
		print("type_===============" .. type_)
        self.activityModel_[activityInfo.id] = model
    end
    if model and model.updateActivity then
        model:updateActivity()
    end

    for k, v in pairs(self.activityModel_) do
        v:setVisible(activityInfo.id == k)
    end
end

function ActivityMainView:updateActivtyItemRedPoint(index)
    local activity = self.activityInfo_[index]
    local item = self.ListView_activity:getItem(index)
    local foo = self.activityItem_[item]

    local isShow = ActivityDataMgr2:isShowRedPoint(activity.id)
    foo.Image_new:setVisible(isShow)
end

function ActivityMainView:addActivityItem()
    local Panel_activityItem = self.Panel_activityItem:clone()
    local foo = {}
    foo.root = Panel_activityItem
    foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select")
    foo.Image_icon = TFDirector:getChildByPath(foo.root, "Image_icon")
    foo.Image_new = TFDirector:getChildByPath(foo.Image_icon, "Image_new"):hide()
    self.activityItem_[foo.root] = foo
    self.ListView_activity:pushBackCustomItem(foo.root)
end

function ActivityMainView:addTaskModel()
    local method = self.createModelMethod_[v.activityType]
    if method then
        local view = method(self)
        view:updateActivity(v.id)
        self:addLayerToNode(view, self.Panel_activity)
    end
end

function ActivityMainView:addStoreModel()

end

function ActivityMainView:onHide()
    self.super.onHide(self)
    TFDirector:removeMEGlobalListener("applicationWillEnterForeground",function()
        EventMgr:dispatchEvent("applicationWillEnterForeground")
    end)
end

function ActivityMainView:registerEvents()
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onUpdateProgressEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.onUpdateActivityEvent, self))

    TFDirector:addMEGlobalListener("applicationWillEnterForeground", function()
        EventMgr:dispatchEvent("applicationWillEnterForeground")
    end)
end

function ActivityMainView:removeEvents()
    self:removeCountDownTimer()
end

function ActivityMainView:onCountDownPer()
    for i, v in ipairs(self.activityInfo_) do
        local model = self.activityModel_[v.id]
        if model and model.onUpdateCountDownEvent then
            model:onUpdateCountDownEvent()
        end
    end
end

function ActivityMainView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.onCountDownPer, self))
    end
end

function ActivityMainView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
    end
end

function ActivityMainView:onSubmitSuccessEvent(activitId, itemId, reward)
    local model = self.activityModel_[activitId]
    if model and model.onSubmitSuccessEvent then
        model:onSubmitSuccessEvent(activitId, itemId, reward)
    end
end

function ActivityMainView:onUpdateProgressEvent()
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

function ActivityMainView:onUpdateActivityEvent()
    self:updateAllActivity()
end

return ActivityMainView
