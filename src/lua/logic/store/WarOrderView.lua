
local WarOrderView = class("WarOrderView", BaseLayer)

function WarOrderView:initData()

end

function WarOrderView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self.curType = "gift"

    self:init("lua.uiconfig.recharge.warOrderView")
end

function WarOrderView:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui

    self.Panel_recharge    = TFDirector:getChildByPath(ui,"Panel_recharge")
    self.Button_buy    = TFDirector:getChildByPath(self.Panel_recharge,"Button_buy")
    self.Image_gift_icon = TFDirector:getChildByPath(ui,"Image_gift_icon")
    self.Label_activity_time = TFDirector:getChildByPath(ui,"Label_time"):hide()

    local ScrollView_gift    = TFDirector:getChildByPath(ui, "ScrollView_gift")
    self.ScrollView_gift       = UIListView:create(ScrollView_gift)
    self.ScrollView_gift:setItemsMargin(5)

    self.rechargeItem   = TFDirector:getChildByPath(ui,"Panel_item")
    self.giftItem       = TFDirector:getChildByPath(ui,"Panel_gift")
    self.Panel_gift_big       = TFDirector:getChildByPath(ui,"Panel_gift_big")
   
    self:updateGiftUI()
    self:addCountDownTimer()
end

function WarOrderView:onShow()
    self.super.onShow(self)
end

function WarOrderView:updateUI()
    self:updateGiftUI()
end

function WarOrderView:registerEvents()
    EventMgr:addEventListener(self,EV_RECHARGE_UPDATE,handler(self.updateUI, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))

    self.Button_buy:onClick(function()
        FunctionDataMgr:jWarOrderBuy()
    end)
end

function WarOrderView:updateGiftUI()
    self.ScrollView_gift:setVisible(true)
    self.warOrderActivity = ActivityDataMgr2:getWarOrderAcrivityInfo()
    local trainingTaskData = ActivityDataMgr2:getItems(self.warOrderActivity.id)
    local itemInfo
    local progressInfo
    for i,v in ipairs(trainingTaskData) do
        if tonumber(self.warOrderActivity.extendData.daytask) == v then
            itemInfo = ActivityDataMgr2:getItemInfo(self.warOrderActivity.activityType, v)
            break
        end
    end
    local giftData = RechargeDataMgr:getWarOrderGiftData()
    self.coolDown = {}
    self.ScrollView_gift:removeAllItems()

    if itemInfo then
        progressInfo = ActivityDataMgr2:getProgressInfo(self.warOrderActivity.activityType, itemInfo.id)
        if progressInfo.status == EC_TaskStatus.GET then
            local listItem = self.giftItem:clone()
            self:updateTaskGiftItem(listItem, itemInfo)
            self.ScrollView_gift:pushBackCustomItem(listItem)
        end
    end
    local serverTime = ServerDataMgr:getServerTime()
    for k,v in ipairs(giftData) do
        print("v.rechargeCfg.id",v.rechargeCfg.id)
        local listItem
        local items = v.item
        if not items or #items < 3 then
            listItem = self.giftItem:clone()
        else
           listItem = self.Panel_gift_big:clone()
        end
        if v.startDate then
            if serverTime >= v.startDate and serverTime < v.endDate then
                self:updateGiftItem(listItem, v)
                self.ScrollView_gift:pushBackCustomItem(listItem)
            end
        else
            self:updateGiftItem(listItem, v)
            self.ScrollView_gift:pushBackCustomItem(listItem)
        end
    end

    if itemInfo then
        progressInfo = ActivityDataMgr2:getProgressInfo(self.warOrderActivity.activityType, itemInfo.id)
        if progressInfo.status == EC_TaskStatus.GETED then
            local listItem = self.giftItem:clone()
            self:updateTaskGiftItem(listItem, itemInfo)
            self.ScrollView_gift:pushBackCustomItem(listItem)
        end
    end
    self.ScrollView_gift:update()
end

function WarOrderView:updateTaskGiftItem(item,itemInfo)
    local progressInfo = ActivityDataMgr2:getProgressInfo(self.warOrderActivity.activityType, itemInfo.id)
    local isReceive = progressInfo.status == EC_TaskStatus.GET
    local isGeted = progressInfo.status == EC_TaskStatus.GETED

    local Label_price   = TFDirector:getChildByPath(item,"Label_price")
    if isReceive then
        Label_price:setTextById(1820002)
    else
        Label_price:setTextById(1300015)
    end
    Label_price:setAnchorPoint(ccp(0.5 , 0.5))
     Label_price:setPositionX(0)

    local Label_num     = TFDirector:getChildByPath(item,"Label_num")
    Label_num:setTextById(tonumber(itemInfo.details))

    local Label_leftTime= TFDirector:getChildByPath(item,"Label_leftTime"):hide()

    local Label_tips    = TFDirector:getChildByPath(item,"Label_tips"):hide()

    local Label_desc    = TFDirector:getChildByPath(item,"Label_desc")
    Label_desc:setTextById(1640001)

    local Label_countdown = TFDirector:getChildByPath(item,"Label_countdown")

    if TextDataMgr:getTextAttr(itemInfo.extendData.des2) then
        Label_countdown:setTextById(itemInfo.extendData.des2)
    else
        Label_countdown:setText(itemInfo.extendData.des2 or "")
    end


    local Image_new = TFDirector:getChildByPath(item,"Image_new"):hide()
    local Image_title_di = TFDirector:getChildByPath(item,"Image_title_di"):hide()

    local Button_buy        = TFDirector:getChildByPath(item,"Button_buy")
    Button_buy:setTouchEnabled(isReceive)
    Button_buy:setGrayEnabled(not isReceive)
    Button_buy:onClick(function()
        ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.warOrderActivity.id, itemInfo.id)
    end)

    local Panel_item = TFDirector:getChildByPath(item,"Panel_item")
    local reward = itemInfo.reward
    if not reward then
        return
    end

    local posX,deltaX = -115,115
    if table.count(reward) == 1 then
        posX = 0
    elseif table.count(reward) == 2 then
        posX,deltaX = -58,116
    end

    local idx = 1
    for cid,v in pairs(reward) do
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        PrefabDataMgr:setInfo(Panel_goodsItem, cid,v)
        Panel_goodsItem:setPosition(ccp(posX+deltaX*(idx-1),0))
        Panel_item:addChild(Panel_goodsItem)
        Panel_goodsItem:onClick(function()
            Utils:showInfo(cid, nil, true)
        end)
        idx = idx + 1
    end
end

function WarOrderView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.warOrderActivity.id == activitId then
        Utils:showReward(reward)
        self:timeOut(function()
            self:updateGiftUI()
        end, 0.3)
    end
end

function WarOrderView:updateGiftItem(item,data)
    local Label_price   = TFDirector:getChildByPath(item,"Label_price")
    Label_price:setAnchorPoint(ccp(0 , 0.5))
    Label_price:setPositionX(-5)

    local image_cost = TFDirector:getChildByPath(item , "img_icon")
    if image_cost then
         local costCfgData = RechargeDataMgr:getOneRechargeCfg(data.rechargeCfg.id).exchangeCost[1]
        image_cost:setTexture(GoodsDataMgr:getItemCfg(costCfgData.id).icon)

        Label_price:setText(costCfgData.num)
        image_cost:setPositionX(-5)
        image_cost:setAnchorPoint(ccp(1,0.5))
    end
   

    local Label_num     = TFDirector:getChildByPath(item,"Label_num")
    Label_num:setText(data.name)

    local Label_leftTime= TFDirector:getChildByPath(item,"Label_leftTime")
    Label_leftTime:setString(data.buyCount - RechargeDataMgr:getBuyCount(data.rechargeCfg.id))
    Label_leftTime:setVisible(data.buyCount ~= 0)

    local Label_tips    = TFDirector:getChildByPath(item,"Label_tips")
    Label_tips:setVisible(data.buyCount ~= 0)

    local Label_desc    = TFDirector:getChildByPath(item,"Label_desc")
    Label_desc:setText(data.des2)

    local serverTime = ServerDataMgr:getServerTime()
    local Label_countdown = TFDirector:getChildByPath(item,"Label_countdown")
    Label_countdown:setText("")
    if data.startDate and serverTime >= data.startDate and serverTime < data.endDate then
        self.coolDown[Label_countdown] = data.endDate
    end

    local Image_new = TFDirector:getChildByPath(item,"Image_new"):hide()
    if data.startDate and serverTime >= data.startDate and serverTime < data.endDate then
        if RechargeDataMgr:getBuyCount(data.rechargeCfg.id) == 0 then
            Image_new:setVisible(true)
        end
    end

    local time = os.date("*t",serverTime)
    if (time.wday - 1 == 1 or time.day == 1) and not RechargeDataMgr:getRechargeTabFlag() then --星期一 每月第一天
        if data.resetType > 1 then
            Image_new:setVisible(true)
        end
    end

    if RechargeDataMgr:isNewOpenGiftBag(data.rechargeCfg.id) then
        Image_new:setVisible(true)
        RechargeDataMgr:clearNewGiftBagFlag(data.rechargeCfg.id)
    end

    local isCanBuy = true
    if data.buyCount ~= 0 and data.buyCount - RechargeDataMgr:getBuyCount(data.rechargeCfg.id) <= 0 then
        isCanBuy = false
    end

    local Button_buy        = TFDirector:getChildByPath(item,"Button_buy")
    Button_buy:onClick(function()
        if data.buyCount ~= 0 and data.buyCount - RechargeDataMgr:getBuyCount(data.rechargeCfg.id) <= 0 then
            Utils:showTips(800117)
            return
        end

        local condition = TabDataMgr:getData("DiscreteData",46022).data
        local element = condition[data.rechargeCfg.id]
        if element then
            local canBuy = true
            for k, v in pairs(element) do
                local vec = string.split(v,",")
                if tonumber(k) == 3 then
                    for k1, v1 in pairs(vec) do
                        if RechargeDataMgr:getBuyCount(tonumber(v1)) <= 0 then
                            canBuy = false
                        end
                    end
                elseif tonumber(k) == 4 then
                    canBuy = false
                    for k1, v1 in pairs(vec) do
                        if RechargeDataMgr:getBuyCount(tonumber(v1)) > 0 then
                            canBuy = true
                        end
                    end
                end
                if canBuy then
                    RechargeDataMgr:getOrderNO(data.rechargeCfg.id)
                else
                    Utils:showTips(200025)
                end
            end
        else
            RechargeDataMgr:getOrderNO(data.rechargeCfg.id)
        end
    end)

    Button_buy:setGrayEnabled(not isCanBuy)
    Button_buy:setTouchEnabled(isCanBuy)

    local Image_title_di    = TFDirector:getChildByPath(item,"Image_title_di")
    local Label_title_desc     = TFDirector:getChildByPath(item,"Label_title_desc")
    local Label_title_desc1     = TFDirector:getChildByPath(item,"Label_title_desc1")

    if data.tag then
        local tagType = data.tagIcon or 0
        local buyCount      = RechargeDataMgr:getBuyCount(data.rechargeCfg.id)
        if buyCount == 0 then
            Label_title_desc:setText(data.tagDes)
            Label_title_desc1:setText(data.tagDes)
        elseif data.tagDes2 ~= "" then
            Label_title_desc:setText(data.tagDes2)
            Label_title_desc1:setText(data.tagDes2)
        else
            Image_title_di:hide()
        end
        print(tagType,data.rechargeCfg.id)
        if tagType == 1 then
            Image_title_di:setTexture("ui/recharge/8.png")
        else
            Image_title_di:setTexture("ui/recharge/7.png")
        end
        Label_title_desc:setVisible(tagType == 1)
        Label_title_desc1:setVisible(tagType ~= 1)
    else
        Image_title_di:hide()
    end

    local Panel_item = TFDirector:getChildByPath(item,"Panel_item")
    local items = data.item
    if not items then
        return
    end

    local posX,deltaX = -115,115
    if #items == 1 then
        posX = 0
    elseif #items == 2 then
        posX,deltaX = -58,116
    end

    for k,v in ipairs(items) do
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        PrefabDataMgr:setInfo(Panel_goodsItem, v.id,v.num)
        Panel_goodsItem:setPosition(ccp(posX+deltaX*(k-1),0))
        Panel_item:addChild(Panel_goodsItem)
        Panel_goodsItem:onClick(function()
            Utils:showInfo(v.id, nil, true)
        end)
    end
end

function WarOrderView:removeEvents()
    self:removeCountDownTimer()
end

function WarOrderView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, -1, nil, handler(self.onCountDownPer, self))
    end
end

function WarOrderView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
        self.countDownTimer_ = nil
    end
end

function WarOrderView:onCountDownPer()
    local serverTime = ServerDataMgr:getServerTime()
    local activityInfo = ActivityDataMgr2:getWarOrderAcrivityInfo()
    local isEnd = serverTime > activityInfo.endTime
    local remainTime
    if isEnd then
        remainTime = math.max(0, activityInfo.showEndTime - serverTime)
    else
        remainTime = math.max(0, activityInfo.endTime - serverTime) 
    end
    local day, hour, min, sec = Utils:getTimeDHMZ(remainTime, true)
    self.Label_activity_time:show()
    if day == "00" then
        self.Label_activity_time:setTextById(190000078, hour, min, sec)
    else
        self.Label_activity_time:setTextById(213514,day, hour, min)
    end

    if not self.coolDown then
        return
    end
    for k,v in pairs(self.coolDown) do
        local str = ""
        if v-serverTime > 0 then
            local day1, hour1, min1  = Utils:getFuzzyDHMS(v-serverTime, true)
            str =TextDataMgr:getText(100000074,day1, hour1, min1)
        end
        k:setText(str)
    end
end

function WarOrderView:onHide()
    self.super.onHide(self)
end

return WarOrderView
