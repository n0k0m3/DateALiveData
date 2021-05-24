

local ActivityMainView = class("ActivityMainView", BaseLayer)
local DEFAULT_SHOW_TYPE = 1000
function ActivityMainView:initData(selectActivityId,activityShowType)
    self.defaultSelectActivityId_ = selectActivityId
    self.activityItem_ = {}
    self.activityModel_ = {}

    self.createModelClass_ = {
        [DEFAULT_SHOW_TYPE] ={  ---默认
            [EC_ActivityType2.TASK] = requireNew("lua.logic.activity.TaskActivityView"),
            [EC_ActivityType2.NEW_BACKACTIVITY] = requireNew("lua.logic.activity.TaskActivityView"),
            [EC_ActivityType2.STORE] = requireNew("lua.logic.activity.StoreActivityView"),
            [EC_ActivityType2.ENTRUST] = requireNew("lua.logic.activity.JumpActivityView"),
            [EC_ActivityType2.DROP] = requireNew("lua.logic.activity.DropActivityView"),
            [EC_ActivityType2.RECHARGE] = requireNew("lua.logic.activity.RechargeActivityView"),
            [EC_ActivityType2.NEWYEARDATING] = requireNew("lua.logic.activity.NewYearEntranceView"),
            [EC_ActivityType2.ADD_RECHARGE] = requireNew("lua.logic.activity.AddRechargeActivityView"),
            [EC_ActivityType2.VALENTINE] = requireNew("lua.logic.activity.ValentineActivityView"),
            [EC_ActivityType2.WHITEVALENTINE] = requireNew("lua.logic.activity.WhiteValentineActivityView"),
            [EC_ActivityType2.CLOTHESE_SUMMON] = requireNew("lua.logic.activity.ClotheseSummonView"),
            [EC_ActivityType2.SX_BIRTHDAY] = requireNew("lua.logic.activity.SxBirthdayActivityView"),
            [EC_ActivityType2.MAID_COFFEE] = requireNew("lua.logic.activity.CoffeeActivityView"),
            [EC_ActivityType2.CGCOLLECTED] = requireNew("lua.logic.activity.EntrustEntranceView"),
            [EC_ActivityType2.SUMMONACTIVITY] = requireNew("lua.logic.activity.SummonActivityView"),
            [EC_ActivityType2.DUANWU_1] = requireNew("lua.logic.activity.DuanwuActivityView"),
            --[EC_ActivityType2.DROP] = requireNew("lua.logic.activity.BingoActivityView"),
            [EC_ActivityType2.BINGOGAME] = requireNew("lua.logic.activity.BingoActivityView"),
            --[EC_ActivityType2.DFW_AUTUMN] = requireNew("lua.logic.activity.ChunrijiActivityView"),  --春日祭活动入口ui暂时由Autumactivityview改为ChunrijiActivityVIew
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
            [EC_ActivityType2.PRAY_ACTIVITY] = requireNew("lua.logic.activity.PrayView"),
            [EC_ActivityType2.CHRISTMAS_FIGHT] = requireNew("lua.logic.activity.MapActivityContainer"),
            [EC_ActivityType2.CRAZY_DIAMOND] = requireNew("lua.logic.activity.CrazyDiamondActivityView"),
            [EC_ActivityType2.TURNTABLE] = requireNew("lua.logic.activity.TurntableActivityView"),
            [EC_ActivityType2.DFW_NEW] = requireNew("lua.logic.activity.DfwNewActivityView"),
            [EC_ActivityType2.HANG_UP] = requireNew("lua.logic.activity.HangUpEntrance"),
            [EC_ActivityType2.YANHUA_COMPOSE] = requireNew("lua.logic.activity.YanHuaActivityEntrance"),
            [EC_ActivityType2.FRIEND_BLESS] = requireNew("lua.logic.activity.FriendSendWordView"),
            [EC_ActivityType2.TANGHULU] = requireNew("lua.logic.activity.TanghuluMakeView"),
            [EC_ActivityType2.NEWYEAR_FUBEN] = requireNew("lua.logic.activity.JumpActivityView"),
            [EC_ActivityType2.CALL_BACK] = requireNew("lua.logic.activity.CallBackMainView"),
            [EC_ActivityType2.HWX_FUBEN] = requireNew("lua.logic.activity.JumpActivityView"),
			[EC_ActivityType2.GROUP_PURCHASE] = requireNew("lua.logic.GroupPurchase.MainEntryView"),
			[EC_ActivityType2.LOBARDAY_2020] = requireNew("lua.logic.activity.Activity2020LobarDay"),
            [EC_ActivityType2.SZQY] = requireNew("lua.logic.activity.SzdyEntryView"),
            [EC_ActivityType2.ALLSERVER_ASSISTANCE] = requireNew("lua.logic.activity.AllServerAssistanceActivity"),
            [EC_ActivityType2.LEAGUE_BACK] = requireNew("lua.logic.activity.LeagueBackView"),
			[EC_ActivityType2.DRESS_VOTE] = requireNew("lua.logic.activity.DressVoteEntry"),
            [EC_ActivityType2.DUANWU_HANGUP] = requireNew("lua.logic.duanwu_hangup.DuanwuHangUpEntrance"),
			[EC_ActivityType2.FASHIONWHOLESALE] = requireNew("lua.logic.activity.FashionWholesale"),
			[EC_ActivityType2.TREASUREHUNTING] = requireNew("lua.logic.activity.TreasureHuntingView"),
            [EC_ActivityType2.DETECTIVE_CHAPTER] = requireNew("lua.logic.activity.DetectiveChapterInfoActivity"),
            [EC_ActivityType2.DETECTIVE_CLUE] = requireNew("lua.logic.activity.DetectiveClueInfo"),
            [EC_ActivityType2.DETECTIVE_VOTE] = requireNew("lua.logic.activity.DetectiveVoteInfo"),
            [EC_ActivityType2.BOSS_CHALLENGE] = requireNew("lua.logic.activity.JumpActivityView"),
            [EC_ActivityType2.DUNGEON_DROP] = requireNew("lua.logic.activity.DropActivityView"),
            [EC_ActivityType2.WSJ_2020] = requireNew("lua.logic.activity.JumpActivityView"), 
            [EC_ActivityType2.ONLINE_SCORE_REWARD] = requireNew("lua.logic.activity.QuanfuzhuliViewEn"),
            [EC_ActivityType2.LAND_TURNTABLET] = requireNew("lua.logic.activity.LandTurnTabletView"),
            [EC_ActivityType2.DICUO_LINKAGE] = requireNew("lua.logic.activity.JumpActivityView"), 
            [EC_ActivityType2.CROSS_SUPPORT] = requireNew("lua.logic.activity.TaskActivityView"),
            [EC_ActivityType2.MAOKA] = requireNew("lua.logic.activity.JumpActivityView"),   
            [EC_ActivityType2.SNOW_FESTIVAL_TASK] = requireNew("lua.logic.activity.SnowFestivalTaskView"),
            [EC_ActivityType2.DICUO_LINKAGE] = requireNew("lua.logic.activity.JumpActivityView"),
            [EC_ActivityType2.CROSS_SUPPORT] = requireNew("lua.logic.activity.TaskActivityView"),  
            [EC_ActivityType2.STORE_SNOW_FESTIVAL] = requireNew("lua.logic.activity.StoreSnowFestivalView"),
            [EC_ActivityType2.SNOW_FESTIVAL_FIGHT] = requireNew("lua.logic.activity.SnowFestivalFightView"),
            [EC_ActivityType2.FAN_SHI_STORE] = requireNew("lua.logic.activity.fanShi.FanShiStoreView"),
            [EC_ActivityType2.FAN_SHI_TASK] = requireNew("lua.logic.activity.fanShi.FanShiTaskView"),
            [EC_ActivityType2.FAN_SHI_DOC] = requireNew("lua.logic.activity.fanShi.FanShiActivityDescView"),
            [EC_ActivityType2.HANTER] = requireNew("lua.logic.activity.TaskActivityView2"),
            [EC_ActivityType2.FLOWER_SEND] = requireNew("lua.logic.activity.2021_spring.ValentinesDay"),
            -- [EC_ActivityType2.FIREWORKS_PRODUCT] = requireNew("lua.logic.activity.2021_spring.FireFactoryView"),
            [EC_ActivityType2.SPRITE_FOR_GIFT] = requireNew("lua.logic.activity.SpriteForGift"),
            [EC_ActivityType2.SPRING_GIFT] = requireNew("lua.logic.activity.SpringGiftView"),
            [EC_ActivityType2.PIC_TASK_ACTIVITY] = requireNew("lua.logic.activity.PicWallTaskView"),
            [EC_ActivityType2.BINGKAI_BLESS] = requireNew("lua.logic.activity.bingKai.BingKaiBlessView"),
            [EC_ActivityType2.BINGKAI_STORE] = requireNew("lua.logic.activity.bingKai.BingKaiStoreView"),
            [EC_ActivityType2.BINGKAI_TASK] = requireNew("lua.logic.activity.bingKai.BingKaiTaskView"),
            [EC_ActivityType2.RETURN_GIFT] = requireNew("lua.logic.activity.ReturnGiftView"),
        },
        [2] = {
            [EC_ActivityType2.CGCOLLECTED] = requireNew("lua.logic.activity.JumpActivityView"),
        },
        [3] = {
            [EC_ActivityType2.ONEYEAR_WELFARE] = requireNew("lua.logic.oneYear.WelfareView"),
            [EC_ActivityType2.HALLOWEEN_GHOST] = requireNew("lua.logic.activity.PreHalloweenView"),
			[EC_ActivityType2.SNOW_BOOK] = requireNew("lua.logic.activity.SnowDay.SnowCastleMain"),	
			[EC_ActivityType2.SNOW_MEMORY] = requireNew("lua.logic.activity.SnowDay.SnowDayMemoryEntry"), 
        },
        [4] = {
            [EC_ActivityType2.ONLINE_SCORE_REWARD] = requireNew("lua.logic.activity.WhiteQueenSendScoreView"),
            [EC_ActivityType2.LEAGUE_SCORE_ASSIT] = requireNew("lua.logic.activity.WhiteQueenLeagueScoreView"),
            [EC_ActivityType2.LEAGUE_SCORE_RANK] = requireNew("lua.logic.activity.WhiteQueenScoreRankView"),
        },
        [5] = {
            [EC_ActivityType2.COURAGE] = requireNew("lua.logic.courage.CourageEnterView"),
            [EC_ActivityType2.COURAGE_TASK] = requireNew("lua.logic.courage.CourageTaskView"),
        },
        [6] = {
            [EC_ActivityType2.ASSIST] = requireNew("lua.logic.activity.KuangsanAssistView"),
            [EC_ActivityType2.ONEYEAR_CELEBRATION] = requireNew("lua.logic.oneYear.CelebrationView"),
            [EC_ActivityType2.KSAN_CARD] = requireNew("lua.logic.activity.KuangsanTaskView"),
            [EC_ActivityType2.WELFARE_JUMP] = requireNew("lua.logic.activity.JumpActivityView"),
        },
		[7] = {
			[EC_ActivityType2.WELFARE_JUMP] = requireNew("lua.logic.activity.ChrismasActivityEntry"),
		},
        [EC_ActivityType2.FANSHI_ASSIST] = {
            [EC_ActivityType2.WELFARE_JUMP] = requireNew("lua.logic.activity.ActivityFanShiEntry"),
        },
        [91] = {   --英文版白王应援活动 
            [EC_ActivityType2.ONLINE_SCORE_REWARD] = requireNew("lua.logic.activity.WhiteQueenSendScoreView"),
            [EC_ActivityType2.LEAGUE_SCORE_ASSIT] = requireNew("lua.logic.activity.WhiteQueenLeagueScoreView"),
            [EC_ActivityType2.LEAGUE_SCORE_RANK] = requireNew("lua.logic.activity.WhiteQueenScoreRankView"),
        },
    }

    if activityShowType then
        self.topBarFileName = "ActivityMainView"..activityShowType
        self.activityShowType = activityShowType
        if activityShowType == 91 then  --英文版单独处理白王应援活动top
            self.topBarFileName = "ActivityMainView91"
        end
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
        if self.activityShowType == 90 then  --游乐园入口特殊处理
            uiName = "activityMainView"..7
        else
            uiName = "activityMainView"..self.activityShowType
        end
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
	print("self.activityShowType=" , self.activityShowType)
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(nil ,self.activityShowType)
    --在线积分活动不显示在活动窗口里
    for i = 1, #self.activityInfo_ do
        local activityInfo = self.activityInfo_[i]
        local type_ = activityInfo.activityType
        if type_ == EC_ActivityType2.NEWGIFT_PACK_EN then
            table.remove(self.activityInfo_, i)
            break
        end
    end
    -- 中秋节、元宵节不显示掉落活动到界面
    -- if ActivityDataMgr2:getActivityUIType() == 1 or ActivityDataMgr2:getActivityUIType() == 2 then
    --     for i, v in ipairs(self.activityInfo_) do
    --         if v.activityType ==  EC_ActivityType2.DROP or v.activityType == EC_ActivityType2.ONEYEAR_DROP then
    --             table.remove(self.activityInfo_, i)
    --             break
    --         end
    --     end
    -- end
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

    local activityInfo = ActivityDataMgr2:getActivityInfo(activitId)
    if EC_ActivityType2.TASK == activityInfo.activityType and  activityInfo.extendData.uiClass and  activityInfo.extendData.uiClass ~= "" then
        modelClass = requireNew(activityInfo.extendData.uiClass)
    end

    if modelClass then
        local model = modelClass:new(activitId, self)
        self:addLayerToNode(model, self.Panel_activity)
        if self:getParent() then
            model:onShow()
        end
        return model
    else
        Box("not found ModelClass for type:"..tostring(type_))
    end
end

function ActivityMainView:selectActivity(index, force)
    if #self.activityInfo_ == 0 then return end
    if self.selectIndex_ == index and not force then return end

    ---关闭上一个页签model
    if self.selectIndex_ then
        local oldActivityInfo = self.activityInfo_[self.selectIndex_]
        if oldActivityInfo then 
            local oldModel = self.activityModel_[oldActivityInfo.id]
            if oldModel and oldModel.hideActivityModel then
                oldModel:hideActivityModel()
            end
        end
    end

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
    if not self.activityInfo_ then
        if self.countDownTimer_ then
            TFDirector:removeTimer(self.countDownTimer_)
        end
        return
    end
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
    if activitId == 21 and (not model or (model and not model:isVisible())) then  --根据活动id来强制转换成社团id目前全服应援固定21
        model = self.activityModel_[22]
    end
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
