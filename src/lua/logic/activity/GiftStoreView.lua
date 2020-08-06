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
* -- 活动礼包购买界面
]]

local GiftStoreView = class("GiftStoreView",BaseLayer)

function GiftStoreView:ctor( data )
	-- body
	self.super.ctor(self,data)
	self.activityId_ = data
	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId_)
    self:showPopAnim(true)
	self:init("lua.uiconfig.activity.giftStoreView")
end

function GiftStoreView:initUI( ui )
	-- body
	self.super.initUI(self,ui)

    self.Panel_pointItem = TFDirector:getChildByPath(ui, "Panel_pointItem")
    self.PageView_gift = TFDirector:getChildByPath(ui, "PageView_gift")

    self.Button_left = TFDirector:getChildByPath(ui, "Button_left")
    self.Button_right = TFDirector:getChildByPath(ui, "Button_right")

    local ScrollView_point = TFDirector:getChildByPath(ui, "ScrollView_point")
    self.ListView_point = UIListView:create(ScrollView_point)
    self.ListView_point:setItemsMargin(10)

	self.Panel_gift = TFDirector:getChildByPath(ui,"Panel_gift")

   

    self:refreshView()
    self:addCountDownTimer()
    self:onCountDownPer()
end


function GiftStoreView:removeEvents( ... )
    -- body
    self.super.removeEvents(self)
    self:removeCountDownTimer()
end

function GiftStoreView:refreshView()
	-- body

	local giftData = RechargeDataMgr:getGiftData(self.activityInfo.extendData.giftID)
    if not giftData then
        return
    end


    self.pointItems_ = {}
    self.ListView_point:removeAllItems()
    for i, v in ipairs(giftData) do
        local bar = {}
        bar.root = self.Panel_pointItem:clone()
        self.ListView_point:pushBackCustomItem(bar.root)
        bar.Image_normal = TFDirector:getChildByPath(bar.root, "Image_normal")
        bar.Image_select = TFDirector:getChildByPath(bar.root, "Image_select")
        self.pointItems_[i] = bar
    end
    Utils:setAliginCenterByListView(self.ListView_point, true)

    self.coolDown = {}
    local serverTime = ServerDataMgr:getServerTime()
    self.PageView_gift:clearAllPages()
    for i, v in ipairs(giftData) do
        local listItem = self.Panel_gift:clone()
        self.PageView_gift:addPage(listItem)
        local bar = {}
        bar.root = listItem
        if v.startDate then
            if serverTime >= v.startDate and serverTime < v.endDate then
                self:updateGiftItem(listItem, v)
            end
        else
            self:updateGiftItem(listItem, v)
        end
    end

    local function updatePageState()
        local curPageIndex = self.PageView_gift:getCurPageIndex()
        local count = self.PageView_gift:getPageCount()
        self.Button_left:setVisible(curPageIndex > 0)
        self.Button_right:setVisible(curPageIndex < count - 1)
        local realIndex = curPageIndex + 1

        for i, bar in ipairs(self.pointItems_) do
            bar.Image_normal:setVisible(i ~= realIndex)
            bar.Image_select:setVisible(i == realIndex)
        end
    end

    self.PageView_gift:addMEListener(TFPAGEVIEW_CHANGED, function()
             updatePageState()
    end)

    updatePageState()
end

function GiftStoreView:updateGiftItem(item,data)
    local Label_price   = TFDirector:getChildByPath(item,"Label_price");
    Label_price:setString("￥ "..data.rechargeCfg.price);

    local Label_num     = TFDirector:getChildByPath(item,"Label_num");
    Label_num:setText(data.name);

    local Label_leftTime= TFDirector:getChildByPath(item,"Label_leftTime");
    Label_leftTime:setString(data.buyCount - RechargeDataMgr:getBuyCount(data.rechargeCfg.id));
    Label_leftTime:setVisible(data.buyCount ~= 0);

    local Label_tips    = TFDirector:getChildByPath(item,"Label_tips");
    Label_tips:setVisible(data.buyCount ~= 0);

    local Label_desc    = TFDirector:getChildByPath(item,"Label_desc");
    --Label_desc:setVisible(data.resetType ~= 0);
    Label_desc:setText(data.des2);

    Label_tips:setSkewX(15)
    Label_leftTime:setSkewX(15)
    local serverTime = ServerDataMgr:getServerTime()
    local Label_countdown = TFDirector:getChildByPath(item,"Label_countdown")
    Label_countdown:setText("")
    if data.startDate and serverTime >= data.startDate and serverTime < data.endDate then
        self.coolDown[Label_countdown] = data.endDate
    end

    local Image_new = TFDirector:getChildByPath(item,"Image_new"):hide()
    if data.startDate and serverTime >= data.startDate and serverTime < data.endDate then
        if RechargeDataMgr:getBuyCount(data.rechargeCfg.id) == 0 then
            Image_new:setVisible(false)
        end
    end

    local time = os.date("*t",serverTime)
    if (time.wday - 1 == 1 or time.day == 1) and not RechargeDataMgr:getRechargeTabFlag() then --星期一 每月第一天
        if data.resetType > 1 then
            Image_new:setVisible(false)
        end
    end

    if RechargeDataMgr:isNewOpenGiftBag(data.rechargeCfg.id) then
        Image_new:setVisible(false)
        RechargeDataMgr:clearNewGiftBagFlag(data.rechargeCfg.id)
    end

    local isCanBuy = true
    if data.buyCount ~= 0 and data.buyCount - RechargeDataMgr:getBuyCount(data.rechargeCfg.id) <= 0 then
        isCanBuy = false
    end

    local Button_buy        = TFDirector:getChildByPath(item,"Button_buy");
    Button_buy:onClick(function()
        if data.buyCount ~= 0 and data.buyCount - RechargeDataMgr:getBuyCount(data.rechargeCfg.id) <= 0 then
            Utils:showTips(800117);
            return
        end
        RechargeDataMgr:getOrderNO(data.rechargeCfg.id);
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

    local scrollView_item = TFDirector:getChildByPath(item,"scrollView_item")
    if not scrollView_item.uiList then
        scrollView_item.uiList = UIListView:create(scrollView_item)
        scrollView_item.uiList:setItemsMargin(5)
    end
    local items = data.item
    if not items then
        return
    end

    for k,v in ipairs(items) do
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        PrefabDataMgr:setInfo(Panel_goodsItem, v.id,v.num)
        Panel_goodsItem:setScale(0.8)
        scrollView_item.uiList:pushBackCustomItem(Panel_goodsItem)
        Panel_goodsItem:onClick(function()
            Utils:showInfo(v.id, nil, true)
        end)
    end
end

function GiftStoreView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, -1, nil, handler(self.onCountDownPer, self))
    end
end

function GiftStoreView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
        self.countDownTimer_ = nil
    end
end

function GiftStoreView:onCountDownPer()

    if not self.coolDown then
        return
    end
    local serverTime = ServerDataMgr:getServerTime()
    for k,v in pairs(self.coolDown) do
        local str = ""
        if v-serverTime > 0 then
            local day, hour, min  = Utils:getFuzzyDHMS(v-serverTime, true)
            -- str = day.."天"..hour.."小时"..min.."分后结束"
            str =TextDataMgr:getText(213514,day, hour, min)
        end
        k:setText(str)
    end
end

function GiftStoreView:registerEvents()
    self.super.registerEvents(self)
	-- body
    EventMgr:addEventListener(self,EV_RECHARGE_UPDATE,handler(self.refreshView, self))

    self.Button_left:onClick(function()
            local curPageIndex = self.PageView_gift:getCurPageIndex()
            local count = self.PageView_gift:getPageCount()
            self.PageView_gift:scrollToPage(curPageIndex - 1)
    end)

    self.Button_right:onClick(function()
            local curPageIndex = self.PageView_gift:getCurPageIndex()
            local count = self.PageView_gift:getPageCount()
            self.PageView_gift:scrollToPage(curPageIndex + 1)
    end)

   
end

return GiftStoreView