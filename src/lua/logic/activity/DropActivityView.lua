local DropActivityView = class("DropActivityView", BaseLayer)

function DropActivityView:initData(activityId)
    self.activityId_ = activityId
    self:updateActivityData()
end

function DropActivityView:ctor(...)
    self.super.ctor(self)
    self:initData(...)

    local uiName = self.activityInfo_ .extendData.uiName or "dropActivityView"
    self:init("lua.uiconfig.activity."..uiName)
end

function DropActivityView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()


    self.Image_ad = TFDirector:getChildByPath(self.Panel_root, "Image_ad")
    self.Label_date = TFDirector:getChildByPath(self.Image_ad, "Label_date")
    self.Label_extra_timing = TFDirector:getChildByPath(self.Image_ad, "Label_extra_timing")
    self.Label_multiple_timing = TFDirector:getChildByPath(self.Image_ad, "Label_multiple_timing")
    local Image_info = TFDirector:getChildByPath(self.Image_ad, "Image_info")
    local Panel_reward = TFDirector:getChildByPath(self.Image_ad, "Panel_reward")
    self.Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    self.Panel_goodsItem:AddTo(Panel_reward):Pos(0, 0):Scale(0.9)
    self.Label_limit_title = TFDirector:getChildByPath(Image_info, "Label_limit_title")
    self.Label_limit = TFDirector:getChildByPath(Image_info, "Label_limit")
    self.Label_every_limit_title = TFDirector:getChildByPath(Image_info, "Label_every_limit_title")
    self.Label_every_limit = TFDirector:getChildByPath(Image_info, "Label_every_limit")

    self.ListView_des = UIListView:create(TFDirector:getChildByPath(ui, "ScrollView_des"))
    self.Panel_des_item = TFDirector:getChildByPath(ui , "Panel_des")

    if self.activityInfo_.extendData.activityShowType == EC_ActivityType2.FANSHI_ASSIST then   --感恩节反十活动修改
        self.Label_extra_timing:hide()
         self.Label_multiple_timing:hide()
         self.Image_ad:getChildByName("Button_get"):onClick(function( ... )
             FunctionDataMgr:jPlotFuben()
         end)
         self.Image_ad:getChildByName("Button_send"):onClick(function( ... )
             FunctionDataMgr:jActivity(300)
         end)
    end


    self:refreshView()
end

function DropActivityView:updateActivityData()
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    local itemId = self.activityInfo_.items[1]
    self.extendData_ = nil
    if itemId then
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, itemId)
        self.itemId_ = itemId
        self.extendData_ = itemInfo.extendData
    end
end

function DropActivityView:updateActivity()
    if self.extendData_ then
        local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, self.itemId_)
        self.Panel_goodsItem:hide()
        if self.extendData_.keyItem then
            self.Panel_goodsItem:show()
            PrefabDataMgr:setInfo(self.Panel_goodsItem, self.extendData_.keyItem)
        end
        self.Label_multiple_timing:hide()
        self.Label_extra_timing:hide()
        if self.extendData_.changeType == EC_ActivityDropChangeType.MULTIPLE then
            self.Label_limit_title:setTextById(1890009)
            self.Label_every_limit_title:setTextById(1890010)
            self.Label_timing = self.Label_multiple_timing:show()
        else
            self.Label_limit_title:setTextById(1890007)
            self.Label_every_limit_title:setTextById(1890008)
            self.Label_timing = self.Label_extra_timing:show()
        end
        local totalProgress = progressInfo.extend.totle or 0
        local everyProgress = progressInfo.progress or 0
        self.Label_limit:setTextById(800005, totalProgress, self.extendData_.totalLimit)
        self.Label_every_limit:setTextById(800005, everyProgress, self.extendData_.dailyLimit)
        self.Image_ad:setTexture(self.activityInfo_.showIcon)
        self:updateCountDonw()

        local title = string.gsub(self.activityInfo_.activityTitle, "\\n", "\n")

        self.ListView_des:removeAllItems()

        local Panel_des_item = self.Panel_des_item:clone()
        Panel_des_item.Label_title = Panel_des_item:getChildByName("Label_title")
        Panel_des_item.Label_title:setTextById(title)
        Panel_des_item:setContentSize(Panel_des_item.Label_title:getContentSize())

        self.ListView_des:pushBackCustomItem(Panel_des_item)

         if self.activityInfo_.extendData.activityShowType == EC_ActivityType2.FANSHI_ASSIST then   --感恩节反十活动修改
            self.Label_timing:hide()
         end
    end
end

function DropActivityView:refreshView()

end

function DropActivityView:updateCountDonw()
    local isEnd = ActivityDataMgr2:isEnd(self.activityId_)
    local serverTime = ServerDataMgr:getServerTime()
    if isEnd then
        local remainTime = math.max(0, self.activityInfo_.showEndTime - serverTime)
        local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
        self.Label_timing:setTextById(1890011, day, hour, min)
    else
        local remainTime = math.max(0, self.activityInfo_.endTime - serverTime)
        local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
        self.Label_timing:setTextById(1890011, day, hour, min)
    end
end

function DropActivityView:registerEvents()

end

function DropActivityView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId_ ~= activitId then return end
end

function DropActivityView:onUpdateProgressEvent()
    self:updateActivityData()
    self:updateActivity()
end

function DropActivityView:onUpdateCountDownEvent()
    self:updateCountDonw()
end

return DropActivityView
