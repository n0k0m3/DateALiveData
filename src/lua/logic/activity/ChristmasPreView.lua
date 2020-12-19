
local ChristmasPreView = class("ChristmasPreView",BaseLayer)

function ChristmasPreView:ctor( data )
    self.super.ctor(self,data)
    self.activityId_ = data
    self.path = "ui/activity/christmas_pre/"
    self:init("lua.uiconfig.activity.christmasPreView")
end

function ChristmasPreView:initUI( ui )
    self.super.initUI(self,ui)

    self.btn_help = TFDirector:getChildByPath(ui,"btn_help")
    self.label_time = TFDirector:getChildByPath(ui,"label_time")
    self.label_des = TFDirector:getChildByPath(ui,"label_des")
    self.label_des_ex = TFDirector:getChildByPath(ui,"label_des_ex")

    self.label_number = TFDirector:getChildByPath(ui,"label_number")
    self.label_tip2 = TFDirector:getChildByPath(ui,"label_tip2")

    self.Image_title = TFDirector:getChildByPath(ui,"Image_title")

    self.Button_sell = TFDirector:getChildByPath(ui,"Button_sell")
    self.sellImage_icon = TFDirector:getChildByPath(self.Button_sell,"Image_icon")
    self.Label_price = TFDirector:getChildByPath(self.Button_sell,"Label_price")
    self.Label_cur_price = TFDirector:getChildByPath(self.Button_sell,"Label_cur_price")
    self.Label_discount = TFDirector:getChildByPath(self.Button_sell,"Label_discount")
    self.Image_dis = TFDirector:getChildByPath(self.Button_sell,"Image_dis")

    self.Image_bought = TFDirector:getChildByPath(ui,"Image_bought")
    self.Image_bought:setGrayEnabled(true)
    self.Image_discount = TFDirector:getChildByPath(ui,"Image_discount"):hide()

    self.Button_pre = TFDirector:getChildByPath(ui,"Button_pre")
    self.preImage_icon = TFDirector:getChildByPath(self.Button_pre,"Image_icon")
    self.preLabel_price = TFDirector:getChildByPath(self.Button_pre,"Label_price")

    self.Image_bar = TFDirector:getChildByPath(ui,"Image_bar")
    self.LoadingBar = TFDirector:getChildByPath(ui,"LoadingBar")
    self.barBgWidth = self.Image_bar:getContentSize().width

    self.Panel_items = TFDirector:getChildByPath(ui,"Panel_items"):hide()

    self:refreshView( )
    self:updateCountDonw()
end

function ChristmasPreView:refreshView()
    local saveStr = ActivityDataMgr2:getChristmasPreSaveStr()
    local curTime = ServerDataMgr:getServerTime()
    local timeFormate = Utils:getLocalDate(curTime)
    local formatStr = timeFormate:fmt("%Y-%m-%d")
    if saveStr ~= formatStr then
        local pid = MainPlayer:getPlayerId()
        local key = "christmasPreRedPoint"..pid
        CCUserDefault:sharedUserDefault():setStringForKey(key,formatStr)
        CCUserDefault:sharedUserDefault():flush()
        ActivityDataMgr2:setChristmasPreSaveStr(formatStr)
    end

    self:updateBuyNum()
    self:updateSellInfo()
    self:updateProgeress()
    self:startTimer()
end

function ChristmasPreView:updateBuyNum()
    self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId_)
    if not self.activityInfo then
        return
    end
    local curPersonNum = self.activityInfo.extendData.buyCount or 0
    self.label_des:setText(Utils:MultiLanguageStringDeal(self.activityInfo.extendData.des))
    self.label_des_ex:setText(Utils:MultiLanguageStringDeal(self.activityInfo.extendData.des1))
    self.label_number:setTextById(270611, curPersonNum)
    local items = ActivityDataMgr2:getItems(self.activityId_)
    local maxItemId = items[#items]
    if not maxItemId then
        return
    end
    local itemInfo = ActivityDataMgr2:getItemInfo(EC_ActivityType2.CHRISTMAS_PRE, maxItemId)
    local percent = math.floor(curPersonNum/itemInfo.target*100)
    self.LoadingBar:setPercent(percent)
end

function ChristmasPreView:updateProgeress()
    local items = ActivityDataMgr2:getItems(self.activityId_)
    local maxItemId = items[#items]
    if not maxItemId then
        return
    end

    local maxitemInfo = ActivityDataMgr2:getItemInfo(EC_ActivityType2.CHRISTMAS_PRE, maxItemId)
    local maxNum = maxitemInfo.target
    for k,v in ipairs(items) do
        self.itemNodes = self.itemNodes or {}
        local item = self.itemNodes[v]
        if not item then
            item = self.Panel_items:clone()
            item:setVisible(true)
            self.Image_bar:addChild(item)
            local itemInfo = ActivityDataMgr2:getItemInfo(EC_ActivityType2.CHRISTMAS_PRE, v)
            local posX = itemInfo.target/maxNum*self.barBgWidth
            item:setPosition(ccp(posX,75))
            self.itemNodes[v] = item
        end
        self:updateItem(item,v)
    end
end

function ChristmasPreView:updateItem(item, id)
    local progressInfo = ActivityDataMgr2:getProgressInfo(EC_ActivityType2.CHRISTMAS_PRE, id)
    local itemInfo = ActivityDataMgr2:getItemInfo(EC_ActivityType2.CHRISTMAS_PRE, id)
    local Image_goodbg = TFDirector:getChildByPath(item,"Image_goodbg")
    local Image_geted = TFDirector:getChildByPath(item,"Image_geted")
    local Label_get_num = TFDirector:getChildByPath(item,"Label_get_num")
    local Image_ing = TFDirector:getChildByPath(item,"Image_ing")
    local Label_ing_num = TFDirector:getChildByPath(Image_goodbg,"Label_ing_num")
    local Label_personNum = TFDirector:getChildByPath(item,"Label_personNum")
    Label_personNum:setText(itemInfo.target)
    progressInfo.status = progressInfo.status or EC_TaskStatus.ING
    Image_ing:setVisible(progressInfo.status == EC_TaskStatus.ING)
    Image_geted:setVisible(progressInfo.status >= EC_TaskStatus.GET)
    Label_get_num:setTextById(13310005)
    

    local imageNames = string.split(itemInfo.extendData.icon,"|")
    if not imageNames then
        return
    end
    print(imageNames)
    Image_goodbg:setTexture(self.path .. "m1.png")
    Label_ing_num:setText(imageNames[1])
end

function ChristmasPreView:updateSellInfo()
    if not self.activityInfo then
        return
    end

    local sellTime = self.activityInfo.extendData.sellTime/1000
    local curTime = ServerDataMgr:getServerTime()
    local isSellState = curTime >= sellTime

    self.Button_pre:setVisible(not isSellState)
    self.Button_sell:setVisible(isSellState)
 
    local preGiftId = self.activityInfo.extendData.giftID[1]
    local giftData = RechargeDataMgr:getOneRechargeCfg(preGiftId)
    local isBuyPreGift = false
    if giftData.buyCount ~= 0 and giftData.buyCount - RechargeDataMgr:getBuyCount(giftData.rechargeCfg.id) <= 0 then
        isBuyPreGift = true
    end
    --Ó¢ÎÄ°æÒÆ¶¯Í¼Æ¬
    self.Image_title:setPosition(234 , -80)
    if isSellState then
        self.Image_title:setTexture(self.path .. "t2.png")
        self.label_tip2:setTextById(270613)
    else
        self.Image_title:setTexture(self.path .. "t1.png")
        self.label_tip2:setTextById(270612)
    end
    self.Image_bar:setVisible(not isSellState)
    self.Image_discount:setVisible(isSellState)
    
    if isSellState then
        self.Label_cur_price:setVisible(isBuyPreGift)
        self.Image_dis:setVisible(isBuyPreGift)

        local discountId = self.activityInfo.extendData.discountId
        local discountData = RechargeDataMgr:getOneRechargeCfg(discountId)
        self.Label_cur_price:setText(discountData.exchangeCost[1].num)


        local originalId = self.activityInfo.extendData.originalId
        local originalData = RechargeDataMgr:getOneRechargeCfg(originalId)
        local exchangeCfg = GoodsDataMgr:getItemCfg(originalData.exchangeCost[1].id)
        self.Label_price:setText(originalData.exchangeCost[1].num)
        self.sellImage_icon:setTexture(exchangeCfg.icon)

        if self.Label_cur_price:isVisible() then
            self.Label_price:setPositionX(self.Label_cur_price:getPositionX() - self.Label_price:getContentSize().width/2)
        else
            local iconWidth = self.sellImage_icon:getContentSize().width * self.sellImage_icon:getScale()
            self.Label_price:setPositionX(iconWidth / 2)
        end

        local x = self.Label_price:getPositionX() - self.Label_price:getContentSize().width/2
        self.sellImage_icon:setPositionX(x)

        local isBuyGift = false
        if discountData.buyCount ~= 0 and discountData.buyCount - RechargeDataMgr:getBuyCount(discountData.rechargeCfg.id) <= 0 then
            isBuyGift = true
        end
        if originalData.buyCount ~= 0 and originalData.buyCount - RechargeDataMgr:getBuyCount(originalData.rechargeCfg.id) <= 0 then
            isBuyGift = true
        end
        self.Image_bought:setVisible(isBuyGift)
    else
        local preItemCfg = GoodsDataMgr:getItemCfg(giftData.exchangeCost[1].id)
        self.preImage_icon:setTexture(preItemCfg.icon)
        self.preLabel_price:setText(giftData.exchangeCost[1].num)

        self.Image_bought:setVisible(isBuyPreGift)
    end
end

function ChristmasPreView:showRewardPreview(item, reward)
    local format_reward = {}
    for k, v in pairs(reward) do
        local item = Utils:makeRewardItem(k, v)
        table.insert(format_reward, item)
    end
    self.Image_preview = Utils:previewReward(self.Image_preview, format_reward, 0.6)
end

function ChristmasPreView:removeEvents( ... )
    self.super.removeEvents(self)
end

function ChristmasPreView:startTimer()
    if not self.activityInfo then
        return
    end
    local sellTime = self.activityInfo.extendData.sellTime/1000
    local curTime = ServerDataMgr:getServerTime()
    if curTime > sellTime then
        return
    end
    self.label_time:stopAllActions()
    local act = CCSequence:create({
        CCDelayTime:create(1),
        CCCallFunc:create(function()
            local sellTime = self.activityInfo.extendData.sellTime/1000
            local curTime = ServerDataMgr:getServerTime()
            if curTime == sellTime then
                self:updateSellInfo()
                self.label_time:stopAllActions()
            end
        end)
    })
    self.label_time:runAction(CCRepeatForever:create(act))
end

function ChristmasPreView:updateCountDonw()
    if not self.activityInfo then
        return
    end
    local _startyear, _startmonth, _startday = Utils:getDate(self.activityInfo.startTime, true)
    local _endyear, _endmonth, _endday = Utils:getDate(self.activityInfo.endTime, true)
    self.label_time:setText(_startyear..".".._startmonth .. "." .. _startday .. "-".._endyear..".".. _endmonth .. "." .. _endday)

    self.label_time:setText(Utils:getActivityDateString(self.activityInfo.startTime, self.activityInfo.endTime, self.activityInfo.extendData.dateStyle))
end

function ChristmasPreView:onUpdateProgressEvent()
    self:updateProgeress()
end

function ChristmasPreView:onUpdateActivityEvent()
    self:updateBuyNum()
end

function ChristmasPreView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId_ ~= activitId then return end
    Utils:showReward(reward)
end

function ChristmasPreView:registerEvents()
    self.super.registerEvents(self)
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.onUpdateActivityEvent, self))
    EventMgr:addEventListener(self, EV_RECHARGE_UPDATE, handler(self.updateSellInfo, self))
    self.Button_sell:onClick(function()
        if not self.activityInfo then
            return
        end
        local preGiftId = self.activityInfo.extendData.giftID[1]
        local giftData = RechargeDataMgr:getOneRechargeCfg(preGiftId)
        local isBuyPreGift = false
        if giftData.buyCount ~= 0 and giftData.buyCount - RechargeDataMgr:getBuyCount(giftData.rechargeCfg.id) <= 0 then
            isBuyPreGift = true
        end
        local discountId = self.activityInfo.extendData.discountId
        local originalId = self.activityInfo.extendData.originalId
        local sellGiftId = isBuyPreGift and discountId or originalId

        local realCfg = RechargeDataMgr:getOneRechargeCfg(sellGiftId)
        local exchangeId = realCfg.exchangeCost[1].id
        local needNum = realCfg.exchangeCost[1].num

        if not self:checkTokenMoney(exchangeId, needNum) then
            Utils:showAccess(exchangeId)
            return;
        end
        local function cb()
            RechargeDataMgr:RECHARGE_REQ_CHARGE_EXCHANGE(sellGiftId)
        end
        local content = TextDataMgr:getText(270610, needNum)
        Utils:openView("common.ReConfirmTipsView", {tittle = 14210305, content = content, reType = false, confirmCall = cb,showCancle = true})
    end)

    self.Button_pre:onClick(function()
        if not self.activityInfo then
            return
        end
        local preGiftId = self.activityInfo.extendData.giftID[1]
        local rechargeCfg = RechargeDataMgr:getOneRechargeCfg(preGiftId)
        local exchangeId = rechargeCfg.exchangeCost[1].id
        local needNum = rechargeCfg.exchangeCost[1].num
        if not self:checkTokenMoney(exchangeId, needNum) then
            Utils:showAccess(exchangeId)
            return;
        end
        local function cb()
            RechargeDataMgr:RECHARGE_REQ_CHARGE_EXCHANGE(preGiftId)
        end
        local content = TextDataMgr:getText(270604, needNum)
        Utils:openView("common.ReConfirmTipsView", {tittle = 270605, content = content, reType = false, confirmCall = cb,showCancle = true})
    end)

    self.btn_help:onClick(function()
        Utils:openView("common.TxtRuleContentShowView", {13500104})
    end)
end

function ChristmasPreView:checkTokenMoney(id, num)
    local have = GoodsDataMgr:getItemCount(id)
    if num > have then
        return false
    end

    return true
end
return ChristmasPreView