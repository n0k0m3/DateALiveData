
local ActivityFundView = class("ActivityFundView", BaseLayer)

function ActivityFundView:initData(activityId_)
    self.activityId_ = activityId_
    self.goodsItems_ = {}
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
end

function ActivityFundView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.activity.activityFundView")
end

function ActivityFundView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    local ScrollView_goods = TFDirector:getChildByPath(self.Panel_root, "ScrollView_goods")
    self.ListView_goods = UIListView:create(ScrollView_goods)

    self.Image_left = TFDirector:getChildByPath(self.Panel_root, "Image_left"):hide()
    self.label_time = TFDirector:getChildByPath(self.Panel_root, "label_time")
    self.Button_buy = TFDirector:getChildByPath(self.Panel_root, "Button_buy")
    self.Label_buy = TFDirector:getChildByPath(self.Button_buy, "Label_buy")
    self.Label_desc = TFDirector:getChildByPath(self.Panel_root, "Label_desc")
    self.Label_buy_time = TFDirector:getChildByPath(self.Panel_root, "Label_buy_time")
    self.Label_desc_2 = TFDirector:getChildByPath(self.Panel_root, "Label_desc_2")
    self.Panel_fundItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_fundItem")


    self:updateGiftBagInfo()
end

function ActivityFundView:updateGiftBagInfo()

    if not self.activityInfo_ then
        return
    end

    self.Label_desc:setText(Utils:splitLanguageStringByTag(self.activityInfo_.extendData.des))

    self.giftData = RechargeDataMgr:getOneRechargeCfg(self.activityInfo_.extendData.rechargeId)

    if not self.giftData then
        return
    end

    local act = CCSequence:create({
        CCCallFunc:create(function()
            local curTime = ServerDataMgr:getServerTime()
            local endTime = self.giftData.endDate
            local remainTime = endTime - curTime
            local day, hour, min, sec = Utils:getTimeDHMZ(remainTime, true)
            if day == "00" then
                self.Label_buy_time:setTextById(190000078 ,hour  , min , sec)
            else
                self.Label_buy_time:setTextById(213514 ,day , hour , min)
            end
            if remainTime <= 0 then
                self.Label_buy_time:stopAllActions()
                self.Label_buy_time:setText("")
                self.Label_desc_2:setTextById(63649)
            else
                self.Label_desc_2:setText("")
            end
        end),
        CCDelayTime:create(1)
    })

    self.Label_buy_time:runAction(CCRepeatForever:create(act))

    self.Label_buy:setTextById(1325305 ,self.giftData.rechargeCfg.price / 100)

    local isCanBuy = true
    if self.giftData.buyCount ~= 0 and self.giftData.buyCount - RechargeDataMgr:getBuyCount(self.giftData.rechargeCfg.id) <= 0 then
        isCanBuy = false
    end

    self.Label_buy_time:setVisible(isCanBuy)
    self.Label_desc_2:setVisible(isCanBuy)
    self.Button_buy:setTouchEnabled(isCanBuy)
    self.Button_buy:setGrayEnabled(not isCanBuy)

    self.Label_buy_time:setPosition(self.Label_desc_2:getPosition())

    self:updateActivity()
end

function ActivityFundView:updateActivity()

    if not self.activityInfo_ then
        return
    end

    self.goodsData_ = ActivityDataMgr2:getItems(self.activityId_)
    local items = self.ListView_goods:getItems()
    local gap = #items - #self.goodsData_

    self.Image_left:setVisible(#self.goodsData_ > 5)

    for i = 1, math.abs(gap) do
        if gap > 0 then
            local item = self.ListView_goods:getItem(1)
            self.goodsItems_[item] = nil
            self.ListView_goods:removeItem(1)
        else
            local item = self:addGoodsItem()
            self.ListView_goods:pushBackCustomItem(item)
        end
    end
    for i, v in ipairs(self.ListView_goods:getItems()) do
        self:updateGoodsItem(i)
    end

    --local serverTime = ServerDataMgr:getServerTime()
    --local remainTime = math.max(0, self.activityInfo_.endTime - serverTime)
    --local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
    --local timeStr = ""
    --if day == "00" then
    --    timeStr = TextDataMgr:getText(800027,hour, min)
    --else
    --    timeStr = TextDataMgr:getText(800044,day, hour, min)
    --    self.Label_timing:setTextById(800044, day, hour, min)
    --end
    --self.Label_timing:setText(timeStr.."后结束")

    local _startyear, _startmonth, _startday = Utils:getDate(self.activityInfo_.showStartTime, true)
    local _endyear, _endmonth, _endday = Utils:getDate(self.activityInfo_.showEndTime, true)
    -- if self.activityInfo_.extendData.activityShowType and self.activityInfo_.extendData.activityShowType == 6 then
    --     self.label_time:setSkewX(10)
    --     self.label_time:setText(_startmonth .. "." .. _startday .. "             " .. _endmonth .. "." .. _endday)
    -- else
    --     self.label_time:setText(_startmonth .. "." .. _startday .. " - " .. _endmonth .. "." .. _endday)
    -- end

    self.label_time:setText(Utils:getActivityDateString(self.activityInfo_.startTime, self.activityInfo_.showEndTime, self.activityInfo_.extendData.dateStyle))
end

function ActivityFundView:addGoodsItem()
    local Panel_fundItem = self.Panel_fundItem:clone()
    local foo = {}
    foo.root = Panel_fundItem
    local Image_diban = TFDirector:getChildByPath(foo.root, "Image_diban")
    foo.Label_name = TFDirector:getChildByPath(Image_diban, "Label_name")
    foo.Image_goods = TFDirector:getChildByPath(foo.root, "Image_goods")
    foo.Button_buy = TFDirector:getChildByPath(foo.root, "Button_buy")
    foo.Label_condition = TFDirector:getChildByPath(foo.root, "Label_condition")
    foo.Image_condition = TFDirector:getChildByPath(foo.root, "Image_condition")
    foo.Image_geted = TFDirector:getChildByPath(foo.root, "Image_geted")
    foo.Image_canget = TFDirector:getChildByPath(foo.root, "Image_canget")
    foo.Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    local Image_frame = TFDirector:getChildByPath(foo.Panel_goodsItem, "Image_frame")
    if Image_frame then
        --Image_frame:setVisible(false)
    end
    foo.Panel_goodsItem:Scale(0.8)
    foo.Panel_goodsItem:AddTo(foo.Image_goods):Pos(0, 0)
    self.goodsItems_[foo.root] = foo

    return Panel_fundItem
end

function ActivityFundView:updateGoodsItem(index)
    local activityInfo = self.activityInfo_
    local itemId = self.goodsData_[index]
    local itemInfo = ActivityDataMgr2:getItemInfo(activityInfo.activityType, itemId)
    local progressInfo = ActivityDataMgr2:getProgressInfo(activityInfo.activityType, itemId)

    local item = self.ListView_goods:getItem(index)
    local foo = self.goodsItems_[item]

    foo.Image_goods:setTexture(itemInfo.extendData.icon)
    
    local target = itemInfo.target
    local progress = progressInfo.progress
    local conditionStr = string.format(itemInfo.extendData.des2,target)
    foo.Label_condition:setTextById(conditionStr , target)

    local goodsId, goodsCount
    for k, v in pairs(itemInfo.reward) do
        goodsId = k
        goodsCount = v
        break
    end
    local goodsCfg = GoodsDataMgr:getItemCfg(goodsId)
    foo.Label_name:setTextById(goodsCfg.nameTextId)
    PrefabDataMgr:setInfo(foo.Panel_goodsItem, goodsId,goodsCount)
    print(progressInfo.status)
    foo.Image_condition:setVisible(progressInfo.status == EC_TaskStatus.ING)
    foo.Image_canget:setVisible(progressInfo.status == EC_TaskStatus.GET)
    foo.Image_geted:setVisible(progressInfo.status == EC_TaskStatus.GETED)

    foo.Button_buy:onClick(function()
        ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId_, itemId)
    end)
end

function ActivityFundView:onSubmitSuccessEvent(activitId, itemId, reward)
    Utils:showReward(reward)
    self:updateActivity()
end

function ActivityFundView:onUpdateProgressEvent()
    self:updateActivity()
end

function ActivityFundView:registerEvents()

    EventMgr:addEventListener(self,EV_RECHARGE_UPDATE,handler(self.updateGiftBagInfo, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onUpdateProgressEvent, self))

    self.Button_buy:onClick(function()
        RechargeDataMgr:getOrderNO(self.giftData.rechargeCfg.id);
    end)
end

return ActivityFundView
