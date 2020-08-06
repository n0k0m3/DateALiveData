local MonthCardView = class("MonthCardView", BaseLayer)

function MonthCardView:ctor()
    self.super.ctor(self)
    self:initData()
    self:init("lua.uiconfig.activity.monthCardViewNew1")
end

function MonthCardView:registerEvents()
    EventMgr:addEventListener(self, EV_MONTHCARD_STATUS_UPDATE, handler(self.updateContentView, self))
    EventMgr:addEventListener(self, EV_MONTHCARD_GIFT_UPDATE, handler(self.updateGiftItemBuyCount, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.onCheckMonthCardDouble, self))

    self.ui:onClick(function()
        -- if self.extraPreviewPanel:isVisible() then
        --     self.extraPreviewPanel:hide()
        -- end
    end)

    self.Button_tab1:onClick(function()
        self:showSignPanel()
    end)
    
    self.Button_tab2:onClick(function()
        self:showGiftPanel()
    end)

    self.Button_buyCard:onClick(function()
        --写死调用月卡购买id为40 2020-04-14
        RechargeDataMgr:getOrderNO(40)
    end)

    self.Button_sign:onClick(function()
        RechargeDataMgr:sendMonthCardSignIn()
    end)

    self._ui.Image_day7:setTouchEnabled(true)
    self._ui.Image_day7:onClick(function(sender)
        -- if self.extraPreviewPanel:isVisible() then
        --     self.extraPreviewPanel:hide()
        -- else
            local reward = RechargeDataMgr:getMonthCardSignData().specialReward or {}
            if #reward <= 0 then
                return
            end
            Utils:previewReward(self.extraPreviewPanel, reward, 0.6)
            -- self.extraPreviewPanel:Pos(0, 0)
            -- self.extraPreviewPanel:show()
        -- end
    end)

    self.Button_buyCard_ios:onClick(function ( ... )
        local layer = require("lua.logic.store.MonthCard"):new({{998},RechargeDataMgr:getSubscribeMonthCardCfg()})
        AlertManager:addLayer(layer)
        AlertManager:show()
    end)

    self.button_monthCard_rule:onClick(function ( ... )
        local layer = require("lua.logic.store.MonthCard"):new({{998},RechargeDataMgr:getSubscribeMonthCardCfg(), noBtn = true})
        AlertManager:addLayer(layer)
        AlertManager:show()
    end)


end

function MonthCardView:initData()
    self.signImgs = {}
    self.isDoubleCardOpen = ActivityDataMgr2:isOpen(EC_ActivityType2.DOUBLE_CARD)
end

function MonthCardView:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui
    self.ui:Touchable(true)

    local Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
    self.Panel_giftItem1 = TFDirector:getChildByPath(Panel_prefab, "Panel_giftItem1")
    self.Panel_giftItem2 = TFDirector:getChildByPath(Panel_prefab, "Panel_giftItem2")

    self.Image_bg1 = TFDirector:getChildByPath(ui, "Image_bg1") 
    self.Button_buyCard = TFDirector:getChildByPath(ui, "Button_buyCard")
    self.Button_buyCard_ios = TFDirector:getChildByPath(ui, "Button_buyCard_ios")
    self.button_monthCard_rule = TFDirector:getChildByPath(ui, "button_monthCard_rule")

    --英文版屏蔽ios月卡续订
   -- if (me.platform == "ios" and tonumber(TFDeviceInfo:getCurAppVersion()) >= 3.65) or me.platform == "win32" then
    if false then
        self.Button_buyCard_ios:show()
        self.Button_buyCard:hide()
    else
        self.Button_buyCard_ios:hide()
        self.Button_buyCard:show()
    end

    self.Button_sign = TFDirector:getChildByPath(ui, "Button_sign")
    self.Image_double = TFDirector:getChildByPath(ui, "Image_double")
    self.Label_doubleTime = TFDirector:getChildByPath(ui, "Label_doubleTime")
    self.Label_buyCard = TFDirector:getChildByPath(ui, "Label_buyCard")
    self.Label_leftDay = TFDirector:getChildByPath(ui, "Label_leftDay")
    TFDirector:getChildByPath(ui, "Image_signDay"):hide()
    self.Label_signDay = TFDirector:getChildByPath(ui, "Label_signDay")
    self.Label_signTips = TFDirector:getChildByPath(ui, "Label_signTips")
    self.Label_signTips:setTextById(1605001)
    local price = TabDataMgr:getData("Recharge", 1).price
    self.Label_buyCard:setText(TextDataMgr:getText(1605002).."\n"..TextDataMgr:getText(1605003, tostring(price)))

    for i = 1, 2 do
        local bttab = TFDirector:getChildByPath(ui, "Button_tab"..i)
        bttab.imgSelect = bttab:getChild("Image_select")
        bttab.imgUnselect = bttab:getChild("Image_unselect")
        self["Button_tab"..i] = bttab
        self["Panel_tab"..i] = TFDirector:getChildByPath(ui, "Panel_tab"..i)
    end

    local Panel_signProgress = TFDirector:getChildByPath(ui, "Panel_signProgress")
    for i = 1, 7 do
        local img = TFDirector:getChildByPath(Panel_signProgress, "Image_day"..i)
        table.insert(self.signImgs, img)
    end
    self.Button_signExtra = TFDirector:getChildByPath(Panel_signProgress, "Button_signExtra")
    self.Panel_preview = TFDirector:getChildByPath(ui, "Panel_preview")
    -- self.extraPreviewPanel = Utils:previewReward()
    -- self.extraPreviewPanel:setAnchorPoint(ccp(1, 0.5))
    -- self.extraPreviewPanel:AddTo(self.Panel_preview)

    local Panel_reward = TFDirector:getChildByPath(ui, "Panel_reward")
    self.ListView_reward = UIListView:create(TFDirector:getChildByPath(Panel_reward, "ScrollView_reward"))
    self.ListView_reward:setItemsMargin(5)
    local Panel_extraReward = TFDirector:getChildByPath(ui, "Panel_extraReward")
    self.Image_extraTipsBg = TFDirector:getChildByPath(Panel_extraReward, "Image_extraTipsBg")
    self.Label_extraTips = TFDirector:getChildByPath(Panel_extraReward, "Label_extraTips")
    self.ListView_extra = UIListView:create(TFDirector:getChildByPath(Panel_extraReward, "ScrollView_extra"))

    self.ListView_gift = UIListView:create(TFDirector:getChildByPath(ui, "ScrollView_gift"))
    self.ListView_gift:setItemsMargin(0)

    self:updateContentView()
end

function MonthCardView:updateContentView()
    self.Label_signDay:setTextById("r2502", tostring(RechargeDataMgr:getMonthCardSignData().signDays or 0))
    self.Label_leftDay:setText(tostring(RechargeDataMgr:getMonthCardLeftTime()))
    self:showGiftPanel(true)
    self:showSignPanel(true)
    self:updateBgRes()
    self:addCountDownTimer()
end

function MonthCardView:updateBgRes()
    local defaultRes = "ui/monthcardNew1/bg.png"
    local cfg = TabDataMgr:getData("Portrait", 10003)
    if #cfg.toggle > 0  then
        local extraData = AvatarDataMgr:getExtraData()
        local month = extraData.month or 1
        for k, v in pairs(cfg.toggle) do
            local months = v.month
            local month1 = months[1]
            local month2 = months[2]
            if month >= month1 and month <= month2 and v.tg then
                defaultRes = v.tg
                break
            end
        end
    end
    self.Image_bg1:setTexture(defaultRes)
end

function MonthCardView:showSignPanel(bupdate)
    bupdate = tobool(bupdate)
    if bupdate then
        local signdata = RechargeDataMgr:getMonthCardSignData()

        --签到进度
        for i, v in ipairs(self.signImgs) do
            v:show()
            local imgNotget = v:getChildByName("imgNotget")
            local imgPass = v:getChildByName("imgPass")
            local imgNow = v:getChildByName("imgNow")
            imgPass:setVisible(tobool(i <= signdata.signDays))
            imgNotget:setVisible(tobool(i > signdata.signDays))
            imgNow:setVisible(false)
            if RechargeDataMgr:isMonthCardCanSign() then
                if tobool(i == signdata.signDays + 1) then
                    imgNow:setVisible(true)
                    imgPass:setVisible(false)
                end
            end
        end

        --双倍
        if self.isDoubleCardOpen then
            self.Image_double:show()
            local doubleCardId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.DOUBLE_CARD)
            local activityInfo = ActivityDataMgr2:getActivityInfo(doubleCardId[1])
            if activityInfo then
                local remainTime = math.max(0, activityInfo.endTime - ServerDataMgr:getServerTime())
                local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
                self.Label_doubleTime:setTextById(800044, day, hour, min)
            end
        else
            self.Image_double:hide()
        end

        --签到奖励
        local basereward = signdata.basrReward or {}
        self.ListView_reward:removeAllItems()
        for i, v in ipairs(basereward) do
            local reward = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone():Scale(0.6)
            local num = v.num
            if self.isDoubleCardOpen then
                num = num * 2
            end
            PrefabDataMgr:setInfo(reward, v.id, num)
            self.ListView_reward:pushBackCustomItem(reward)
        end

        --额外奖励
        local extrareward = signdata.specialReward or {}
        local extday = signdata.extDay or 0
        if extday > 1 then
            self.Image_extraTipsBg:show()
            -- self.Label_extraTips:setTextById("r2503", tostring(extday))
            self.Label_extraTips:setText(tostring(extday))
            self.ListView_extra:setVisible(false)
        else
            self.ListView_extra:removeAllItems()
            for i, v in ipairs(extrareward) do
                local reward = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone():Scale(0.6)
                PrefabDataMgr:setInfo(reward, v.id, v.num)
                self.ListView_extra:pushBackCustomItem(reward)
            end
            self.ListView_extra:setVisible(true)
            self.Image_extraTipsBg:hide()
        end

        local havecard = tobool(RechargeDataMgr:getMonthCardLeftTime() > 0)
        local cansign = RechargeDataMgr:isMonthCardCanSign()
        self.Button_sign:setTouchEnabled(havecard and cansign)
        self.Button_sign:setGrayEnabled(not havecard or not cansign)
    end
    self.Panel_tab1:show()
    self.Button_tab1.imgSelect:show()
    self.Button_tab1.imgUnselect:hide()
    self.Panel_tab2:hide()
    self.Button_tab2.imgSelect:hide()
    self.Button_tab2.imgUnselect:show()


    -- --屏蔽专属礼包按钮 2020-03-24
    -- self.Button_tab2:hide()
    --屏蔽月卡规则
    self.button_monthCard_rule:hide()
end

function MonthCardView:showGiftPanel(bupdate)
    -- self.extraPreviewPanel:hide()
    bupdate = tobool(bupdate)
    if bupdate then
        local giftdata = RechargeDataMgr:getMonthCardGiftData()
        --giftdata = {{id=1,color=1,name="礼包1",limitDes="每周一重置",buyCount=1,items={{id=500001,num=100},{id=500002,num=100}},price={{id=500001,num=100},{id=500002,num=900000}}},
        --            {id=2,color=2,name="礼包2",limitDes="每周一重置",buyCount=1,items={{id=500001,num=100},{id=500002,num=100}},price={{id=500001,num=100},{id=500002,num=100}}},
        --            {id=3,color=1,name="礼包3",limitDes="每周一重置",buyCount=1,items={{id=500001,num=100},{id=500002,num=100}},price={{id=500001,num=100},{id=500002,num=100}}},
        --            {id=4,color=2,name="礼包4",limitDes="每周一重置",buyCount=1,items={{id=500001,num=100},{id=500002,num=100}},price={{id=500001,num=100},{id=500002,num=100}}},}
        self.ListView_gift:removeAllItems()
        for i, v in ipairs(giftdata) do
            local gift = nil
            if v.color == 1 then
                gift = self.Panel_giftItem1:clone():show()
            else
                gift = self.Panel_giftItem2:clone():show()
            end
            gift.id = v.id
            gift:getChild("Label_name"):setTextById(v.name)
            gift:getChild("Label_revert"):setTextById(v.limitDes)
            gift:getChild("Label_buyCount"):setText(tostring(v.buyCount))
            local btBuy = TFDirector:getChildByPath(gift, "Button_buy")
            btBuy.id = v.id
            btBuy:onClick(function(sender)
                local args = {
                    tittle = 2107025,
                    reType = "buymonthCardgift",
                    content = TextDataMgr:getText(1605014),
                    confirmCall = function ( ... )
                        RechargeDataMgr:sendMonthCardGiftBy(sender.id)
                    end,
                }
                Utils:showReConfirm(args)
                return
            end)
            local monthCardInfo = RechargeDataMgr:getMonthCardInfo()
            local label_time_limit = gift:getChild("label_time_limit")
            if tobool(RechargeDataMgr:getMonthCardLeftTime() > 0) and v.ext.day and  monthCardInfo.lastEndTime and  monthCardInfo.lastGainDate ~= 0 then
                local lastBuyTime = monthCardInfo.lastGainDate
                local lastEndTime = monthCardInfo.lastEndTime
                if lastEndTime > 0 and lastBuyTime - lastEndTime  <= v.ext.day * 24 * 3600    then
                    label_time_limit:hide()
                else
                    label_time_limit:show()
                    function calcShowTime(startTime , endTime , limitDay )
                    local showTime
                        if endTime > 0 then
                           showTime =  startTime + (30+ limitDay) * 24 * 3600
                        else
                            showTime = startTime + (30+ limitDay) * 24 * 3600
                        end
                        return Utils:getTimeData(showTime)
                    end
                    local showCalcTime = calcShowTime(lastBuyTime , lastEndTime , v.ext.day)
                    local timeStrShow = string.format("%s-%s-%s %02d:%02d:%02d" , showCalcTime.Year,showCalcTime.Month,showCalcTime.Day,showCalcTime.Hour,showCalcTime.Minute , showCalcTime.Second)
                    label_time_limit:setTextById(190000043 ,timeStrShow)
                end
            else
                label_time_limit:hide()
            end
            local awardlistview = UIListView:create(gift:getChild("ScrollView_award"))
            awardlistview:setItemsMargin(4)
            local awardlist = v.items or {}
            for ai, av in ipairs(awardlist) do
                local award = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone():Scale(0.8)
                PrefabDataMgr:setInfo(award, av.id, av.num)
                awardlistview:pushBackCustomItem(award)
            end
            local costlist = v.price or {}
            local bCostEnough = true
            for ci, cv in ipairs(costlist) do
                local costimg = TFDirector:getChildByPath(gift, "Image_cost"..ci)
                if costimg then
                    local costitem = costimg:getChild("Image_item")
                    local costlb = costimg:getChild("Label_cost")
                    costimg:show()
                    costitem:setTexture(TabDataMgr:getData("Item", cv.id).icon)
                    costitem:setSize(me.size(40, 40))
                    local owncount = GoodsDataMgr:getItemCount(cv.id)
                    costlb:setText(cv.num)
                    if owncount >= cv.num then
                        costlb:setColor(ccc3(255, 255, 255))
                    else
                        bCostEnough = false
                        costlb:setColor(ccc3(255, 0, 0))
                    end
                end
                break
            end

            local havecard = tobool(RechargeDataMgr:getMonthCardLeftTime() > 0)
            local countEnough = tobool(v.buyCount > 0)
            btBuy:setTouchEnabled(havecard and bCostEnough and countEnough)
            btBuy:setGrayEnabled(not havecard or not bCostEnough or not countEnough)

            self.ListView_gift:pushBackCustomItem(gift)
        end
    end
    self.Panel_tab1:hide()
    self.Button_tab1.imgSelect:hide()
    self.Button_tab1.imgUnselect:show()
    self.Panel_tab2:show()
    self.Button_tab2.imgSelect:show()
    self.Button_tab2.imgUnselect:hide()
end

function MonthCardView:updateGiftItemBuyCount(id, buycount, price)
    local items = self.ListView_gift:getItems()
    for i, v in ipairs(items) do
        local btBuy = TFDirector:getChildByPath(v, "Button_buy")
        local bCostEnough = true
        local bCountEnough = true
        if v.id == id then
            v:getChild("Label_buyCount"):setText(tostring(buycount or 0))
            bCountEnough = tobool(buycount > 0)
            for ci, cv in ipairs(price) do
                local owncount = GoodsDataMgr:getItemCount(cv.id)
                if owncount < cv.num then
                    bCostEnough = false
                end
                break
            end
        else
            bCostEnough, bCountEnough = RechargeDataMgr:isMonthCardGiftCanBuy(v.id)
        end
        local havecard = tobool(RechargeDataMgr:getMonthCardLeftTime() > 0)
        btBuy:setTouchEnabled(havecard and bCostEnough and bCountEnough)
        btBuy:setGrayEnabled(not havecard or not bCostEnough or not bCountEnough)
    end
end

function MonthCardView:onCheckMonthCardDouble()
    local newstatus = ActivityDataMgr2:isOpen(EC_ActivityType2.DOUBLE_CARD)
    if self.isDoubleCardOpen ~= newstatus then
        self.isDoubleCardOpen = newstatus
        self:updateContentView()
    end
end

function MonthCardView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.onCountDownPer, self))
    end
end

function MonthCardView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
    end
end

function MonthCardView:onCountDownPer(dt)
   local giftdata = RechargeDataMgr:getMonthCardGiftData()
   for k ,v in pairs(giftdata) do

   end
end

function MonthCardView:removeEvents( ... )
    self:removeCountDownTimer()
end
return MonthCardView