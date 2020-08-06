
local ChristmasSignInView = class("ChristmasSignInView", BaseLayer)

function ChristmasSignInView:initData(isEmbed)
    self.isEmbed_ = isEmbed
    self.signInItems_ = {}
    self.canGetItems_ = {}
    self.receiveReward_ = {}
    self.receiveCount_ = 0
    local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.CHRISTMAS_SIGN)
    if #activity > 0 then
        self.activityId_ = activity[1]
        self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    end

    if not self.isEmbed_ then
        ActivityDataMgr:setChristmasSignInFlag(true)
    end
end

function ChristmasSignInView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.activity.christmasSignInView")
end

function ChristmasSignInView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_signInItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_signInItem")

    self.Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Button_close = TFDirector:getChildByPath(self.Image_content, "Button_close")
    self.Panel_day = {}
    for i = 1, 7 do
        self.Panel_day[i] = TFDirector:getChildByPath(self.Image_content, "Panel_day_" .. i)
        self.Panel_day[i]:setBackGroundColorType(0)
    end
    self.Label_timing = TFDirector:getChildByPath(self.Image_content, "Image_timing.Label_timing")
    self.Button_sign_in = TFDirector:getChildByPath(self.Image_content, "Button_sign_in")
    self.Label_sign_in = TFDirector:getChildByPath(self.Button_sign_in, "Label_sign_in")
    self.Label_tips = TFDirector:getChildByPath(self.Image_content, "Label_tips")

    self:refreshView()
end

function ChristmasSignInView:refreshView()
    self.Label_tips:setTextById(1890005)

    local items = ActivityDataMgr2:getItems(self.activityId_)
    for i, v in ipairs(items) do
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, v)
        local Panel_signInItem = self.Panel_signInItem:clone()
        Panel_signInItem:Pos(0, 0):AddTo(self.Panel_day[i])
        local foo = {}
        foo.root = Panel_signInItem
        foo.Image_day = TFDirector:getChildByPath(foo.root, "Image_day")
        foo.Label_day = TFDirector:getChildByPath(foo.Image_day, "Label_day")
        foo.Image_geted = TFDirector:getChildByPath(foo.root, "Image_geted")
        foo.Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        foo.Panel_goodsItem:Pos(0, 0):AddTo(foo.root)
        if i == 7 then
            foo.Image_day:PosY(foo.Image_day:PosY() - 30)
        end
        self.signInItems_[i] = foo
    end

    self:updateSignItemInfo()

    self.Button_close:setVisible(not self.isEmbed_)
    if self.isEmbed_ then
        self.Image_content:Pos(55, -34)
    end

    self:addCountDownTimer()
end

function ChristmasSignInView:updateSignItemInfo()
    local items = ActivityDataMgr2:getItems(self.activityId_)
    for i, v in ipairs(items) do
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, v)
        local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, v)
        local rewardCid, rewardNum = next(itemInfo.reward)
        local foo = self.signInItems_[i]

        PrefabDataMgr:setInfo(foo.Panel_goodsItem, rewardCid, rewardNum)
        foo.Image_geted:setVisible(progressInfo.status == EC_TaskStatus.GETED)
        local chineseNumber = Utils:getChineseNumber(i)
        foo.Label_day:setTextById(1890006, chineseNumber)
    end

    local canGet = ActivityDataMgr2:isShowRedPoint(self.activityId_)
    self.Button_sign_in:setTouchEnabled(canGet)
    self.Button_sign_in:setGrayEnabled(not canGet)
    self.Label_sign_in:setTextById(canGet and 1810001 or 1300015)

    self:updateCountDonw()
end

function ChristmasSignInView:registerEvents()
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onUpdateProgressEvent, self))

    self.Button_close:onClick(function()
            AlertManager:closeLayer(self)
    end)

    self.Button_sign_in:onClick(function()
            local items = ActivityDataMgr2:getItems(self.activityId_)
            self.canGetItems_ = {}
            self.receiveCount_ = 0
            self.receiveReward_ = {}
            for i, v in ipairs(items) do
                local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, v)
                if progressInfo.status == EC_TaskStatus.GET then
                    table.insert(self.canGetItems_, v)
                end
            end
            for i, v in ipairs(self.canGetItems_) do
                ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId_, v)
            end
            self.Button_sign_in:setTouchEnabled(false)
            self.Button_sign_in:setGrayEnabled(true)
    end)
end

function ChristmasSignInView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId_ ~= activitId then return end
    self.receiveCount_ = self.receiveCount_ + 1
    if self.receiveCount_ < #self.canGetItems_ then
        table.insertTo(self.receiveReward_, reward)
    else
        table.insertTo(self.receiveReward_, reward)
        Utils:showReward(self.receiveReward_)
    end
end

function ChristmasSignInView:updateCountDonw()
    local isEnd = ActivityDataMgr2:isEnd(self.activityId_)
    local serverTime = ServerDataMgr:getServerTime()
    if isEnd then
        local remainTime = math.max(0, self.activityInfo_.showEndTime - serverTime)
        local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
        if day == "00" then
            self.Label_timing:setTextById("r43008", hour, min)
        else
            self.Label_timing:setTextById("r43007", day, hour)
        end
    else
        local remainTime = math.max(0, self.activityInfo_.endTime - serverTime)
        local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
        if day == "00" then
            self.Label_timing:setTextById("r43006", hour, min)
        else
            self.Label_timing:setTextById("r43005", day, hour)
        end
    end

end

function ChristmasSignInView:onUpdateProgressEvent()
    self:updateSignItemInfo()
end

function ChristmasSignInView:removeEvents()
    self:removeCountDownTimer()
end

function ChristmasSignInView:onCountDownPer(index)
    self:updateCountDonw()
end

function ChristmasSignInView:addCountDownTimer(storeId)
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.onCountDownPer, self))
    end
end

function ChristmasSignInView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
    end
end

return ChristmasSignInView
