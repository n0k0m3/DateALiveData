--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
* -- 礼包活动界面
]]

local GiftActivityView = class("GiftActivityView",BaseLayer)

function GiftActivityView:initData(activityId)
    self.activityId_ = activityId
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    self.goodsItems_ = {}
end

function GiftActivityView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    local uiName = self.activityInfo_.extendData.uiName or "giftActivityView"
    self:init("lua.uiconfig.activity."..uiName)
end

function GiftActivityView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.giftItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_gift")
    self.Label_timing = TFDirector:getChildByPath(ui, "Label_timing")
    local ScrollView_goods = TFDirector:getChildByPath(self.Panel_root, "ScrollView_goods")
    self.ListView_goods = UIListView:create(ScrollView_goods)
    self:refreshView( )
end

function GiftActivityView:refreshView( )
	-- body
	local giftData = RechargeDataMgr:getGiftData(self.activityInfo_.extendData.giftids)
    if not giftData then
        return
    end
    self.coolDown = {}
    self.ListView_goods:removeAllItems()
    local serverTime = ServerDataMgr:getServerTime()
    for k,v in ipairs(giftData) do
        local listItem = self.giftItem:clone()
        local items = v.item
        if v.startDate then
            if serverTime >= v.startDate and serverTime < v.endDate then
                self:updateGiftItem(listItem, v)
                self.ListView_goods:pushBackCustomItem(listItem)
            end
        else
            self:updateGiftItem(listItem, v)
            self.ListView_goods:pushBackCustomItem(listItem)
        end
    end
end

function GiftActivityView:updateGiftItem(item,data)
    local Image_diban   = TFDirector:getChildByPath(item,"Image_diban");
    local Label_price   = TFDirector:getChildByPath(item,"Label_price");
    Label_price:setString("￥ "..data.rechargeCfg.price);

    local Image_exchange = TFDirector:getChildByPath(item,"Image_exchange")
    if data.buyType == 1 then
        local exchangeCfg = GoodsDataMgr:getItemCfg(data.exchangeCost[1].id)
        Image_exchange:show()
        Image_exchange:setTexture(exchangeCfg.icon)
        Image_exchange:setSize(CCSizeMake(45,45))
        Image_exchange:setPositionX(Image_exchange:getPositionX() - 25)
        Label_price:setString(data.exchangeCost[1].num)
        Label_price:setPositionX(Label_price:getPositionX() + 35 / 2)
    end

    local Label_num     = TFDirector:getChildByPath(item,"Label_num");
    Label_num:setText(data.name);

    local Label_leftTime= TFDirector:getChildByPath(item,"Label_leftTime");
    Label_leftTime:setString(data.buyCount - RechargeDataMgr:getBuyCount(data.rechargeCfg.id));
    Label_leftTime:setVisible(data.buyCount ~= 0);

    local Label_buyCount     = TFDirector:getChildByPath(item,"Label_buyCount");
    Label_buyCount:setText(data.des2)
    Label_buyCount:setVisible(data.buyCount ~= 0);

    local Label_tips    = TFDirector:getChildByPath(item,"Label_tips");
    Label_tips:setVisible(data.buyCount ~= 0);

    local serverTime = ServerDataMgr:getServerTime()
    local Label_countdown = TFDirector:getChildByPath(item,"Label_countdown")
    Label_countdown:setText("")
    if data.startDate and serverTime >= data.startDate and serverTime < data.endDate then
        self.coolDown[Label_countdown] = data.endDate
    end
    local Button_buy        = TFDirector:getChildByPath(item,"Button_buy");

    local isCanBuy = true
    if data.buyCount ~= 0 and data.buyCount - RechargeDataMgr:getBuyCount(data.rechargeCfg.id) <= 0 then
        isCanBuy = false
    end

    if self.activityInfo_.extendData.activityShowType == 3 then
        Image_diban:setTexture( isCanBuy and "ui/activity/anniversary/gift_03.png" or "ui/activity/anniversary/gift_04.png" )
        Label_num:setFontColor( isCanBuy and ccc3(80,60,121) or ccc3(235,213,245))
        Label_buyCount:setFontColor( isCanBuy and ccc3(110,89,141) or ccc3(235,213,245))
        Label_countdown:setFontColor( isCanBuy and ccc3(110,89,141) or ccc3(235,213,245))
        Label_tips:setFontColor( isCanBuy and ccc3(235,213,245) or ccc3(235,213,245))
        Label_leftTime:setFontColor( isCanBuy and ccc3(235,213,245) or ccc3(252,56,112))
        Label_price:setColor( isCanBuy and ccc3(252,104,142) or ccc3(235,213,245))
        Button_buy:setTextureNormal(isCanBuy and "ui/activity/anniversary/gift_01.png" or "ui/activity/anniversary/gift_02.png")
        Button_buy:setTouchEnabled(isCanBuy)
    elseif self.activityInfo_.extendData.activityShowType == 4 then
        Image_diban:setTexture( isCanBuy and "ui/activity/activityMain3/n1.png" or "ui/activity/activityMain3/n2.png")
        local color = isCanBuy and ccc3(0x94,0xe1,0xff) or ccc3(0xc4,0xc6,0xe5)
        Label_num:setFontColor(isCanBuy and ccc3(255,255,255)or ccc3(0xc4,0xc6,0xe5))
        Label_buyCount:setFontColor(color)
        Label_countdown:setFontColor(color)
        Label_tips:setFontColor(color)
        Label_leftTime:setFontColor(color)
        Label_price:setColor(isCanBuy and ccc3(255,255,255)or ccc3(0xc4,0xc6,0xe5))
        Button_buy:setTextureNormal(isCanBuy and "ui/activity/activityMain3/b5.png" or "ui/activity/activityMain3/b7.png")
        Button_buy:setTouchEnabled(isCanBuy)
    elseif self.activityInfo_.extendData.activityShowType == 6 then
        --Image_diban:setTexture( isCanBuy and "ui/activity/assist/kuangsan/gift_004.png" or "ui/activity/assist/kuangsan/gift_004.png" )
        Label_num:setFontColor( isCanBuy and ccc3(154,60,66) or ccc3(154,60,66))
        Label_buyCount:setFontColor( isCanBuy and ccc3(255,198,199) or ccc3(255,198,199))
        Label_countdown:setFontColor( isCanBuy and ccc3(255,198,199) or ccc3(255,198,199))
        Label_tips:setFontColor( isCanBuy and ccc3(226,182,190) or ccc3(226,182,190))
        Label_leftTime:setFontColor( isCanBuy and ccc3(226,182,190) or ccc3(226,182,190))
        Label_price:setColor( isCanBuy and ccc3(210,94,95) or ccc3(210,94,95))
        Button_buy:setGrayEnabled(not isCanBuy)
        Button_buy:setTouchEnabled(isCanBuy)
    else
        Image_diban:setTexture( isCanBuy and "ui/activity/welfareActivity/bg_gift_normal.png" or "ui/activity/welfareActivity/bg_gift_gray.png" )
        Label_num:setFontColor( isCanBuy and ccc3(87,171,229) or ccc3(196,198,229))
        Label_buyCount:setFontColor( isCanBuy and ccc3(87,171,229) or ccc3(196,198,229))
        Label_tips:setFontColor( isCanBuy and ccc3(128,219,255) or ccc3(196,198,229))
        Label_leftTime:setFontColor( isCanBuy and ccc3(128,219,255) or ccc3(252,56,112))
        Button_buy:setGrayEnabled(not isCanBuy)
        Button_buy:setTouchEnabled(isCanBuy)
    end
    
    Button_buy:onClick(function()
        if data.buyCount ~= 0 and data.buyCount - RechargeDataMgr:getBuyCount(data.rechargeCfg.id) <= 0 then
            Utils:showTips(800117);
            return
        end
        RechargeDataMgr:getOrderNO(data.rechargeCfg.id);
    end)

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
    
    for k,v in ipairs(items) do
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:setPosition(ccp(0,0)):Scale(0.8)
        PrefabDataMgr:setInfo(Panel_goodsItem, v.id,v.num)
        local posItem = TFDirector:getChildByPath(Panel_item,"Image_reward_"..k)
        if posItem then
            posItem.hasitem = true
        	posItem:addChild(Panel_goodsItem)
	        Panel_goodsItem:onClick(function()
	            Utils:showInfo(v.id, nil, true)
	        end)
	    end
    end

    local posItem1 = TFDirector:getChildByPath(Panel_item,"Image_reward_"..1)
    local posItem2 = TFDirector:getChildByPath(Panel_item,"Image_reward_"..2)
    local posItem3 = TFDirector:getChildByPath(Panel_item,"Image_reward_"..3)
    local posItem4 = TFDirector:getChildByPath(Panel_item,"Image_reward_"..4)

    if not posItem3.hasitem then -- 上面一排没有物品
        posItem1:setPositionY(6)
        posItem2:setPositionY(6)
        if not posItem2.hasitem then
            posItem1:setPositionX(0)
        end
    elseif not posItem4.hasitem then
        posItem3:setPositionX(0)
    end
end
function GiftActivityView:onCountDownPer()

    if not self.coolDown then
        return
    end
    local serverTime = ServerDataMgr:getServerTime()
    for k,v in pairs(self.coolDown) do
        local str = ""
        if v-serverTime > 0 then
            local day, hour, min  = Utils:getFuzzyDHMS(v-serverTime, true)
            -- str = day.."天"..hour.."小时"..min.."分后结束"
            str =TextDataMgr:getText(100000074,day, hour, min)
        end
        k:setText(str)
    end
end

function GiftActivityView:updateCountDonw()
    self:onCountDownPer()
    local isEnd = ActivityDataMgr2:isEnd(self.activityId_)
    local serverTime = ServerDataMgr:getServerTime()
    if isEnd then
        local remainTime = math.max(0, self.activityInfo_.showEndTime - serverTime)
        local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
        if day == "00" then
            self.Label_timing:setTextById("r41004", hour, min)
        else
            self.Label_timing:setTextById("r41003", day, hour)
        end
    else
        local remainTime = math.max(0, self.activityInfo_.endTime - serverTime)
        local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
        if day == "00" then
            self.Label_timing:setTextById("r41002", hour, min)
        else
            self.Label_timing:setTextById("r41001", day, hour)
        end
    end
end

function GiftActivityView:registerEvents( ... )
    self.super.registerEvents(self)
    EventMgr:addEventListener(self,EV_RECHARGE_UPDATE,handler(self.refreshView, self))
end

function GiftActivityView:onUpdateProgressEvent()
     --self:refreshView()
end

function GiftActivityView:onUpdateActivityEvent()
    self:refreshView()
end

function GiftActivityView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId_ ~= activitId then return end
    Utils:showReward(reward)
end

function GiftActivityView:onUpdateCountDownEvent()
    self:updateCountDonw()
end

return GiftActivityView