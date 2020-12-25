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
*  新的充值界面
* 
]]

local RechargeMain = class("RechargeMain", BaseLayer)

local CardType = {
    MonthCard = 1,
    MonthCardEx = 2,
}

function RechargeMain:getClosingStateParams()
    return {self.selectIndex_}
end

function RechargeMain:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self.curType = "recharge"

    self:init("lua.uiconfig.recharge.rechargeMainNew")
end

function RechargeMain:initData(selectIndex)
    self.selectIndex_ = selectIndex or 1
end

function RechargeMain:initUI(ui)
    self.super.initUI(self, ui)

    self.Button_rechange = TFDirector:getChildByPath(ui, "Button_rechange")
    self.Button_rechangeNew = TFDirector:getChildByPath(self.Button_rechange, "Image_new")
    self.Image_charge_icon = TFDirector:getChildByPath(ui,"Image_charge_icon")

    self.btn_TokenMoney = TFDirector:getChildByPath(ui, "btn_TokenMoney")
    self.btn_TokenMoneyNew = TFDirector:getChildByPath(self.btn_TokenMoney, "Image_new")

    self.panel_cell = TFDirector:getChildByPath(ui, "panel_cell"):hide()

    self.scroll_list = TFDirector:getChildByPath(ui, "scroll_list")
    self.initSize = self.scroll_list:getContentSize()
    self.gridView = UIGridView:create(self.scroll_list)
	self.gridView:setItemModel(self.panel_cell)
	self.gridView:setColumn(4)
    self.gridView:setColumnMargin(4)
    self.gridView:setRowMargin(8)
    
    self:initTotal()
    self:initIOSMonth()
    self:initAndroidMonth()

    if self.selectIndex_ == 1 then
        self:onTouchBottomBtn(self.Button_rechange)
    elseif self.selectIndex_ == 2 then
        self:onTouchBottomBtn(self.totalBtn)
    elseif self.selectIndex_ == 3 then
        self:onTouchBottomBtn(self.btn_monthCard)
    elseif self.selectIndex_ == 4 then
        self:onTouchBottomBtn(self.btn_TokenMoney)
    end

    RechargeDataMgr:setClickMainLayerFlag()

    self:updateNew()
    self:addCountDownTimer()

    --屏蔽代币显示控制功能
    -- local mainFuncInfo_activity = FunctionDataMgr:getMainFuncInfo(205)
    -- if not mainFuncInfo_activity or  tobool(mainFuncInfo_activity.openWelfare) == false then
    --     self.btn_TokenMoney:hide()
    -- else
    --     self.btn_TokenMoney:show()
    -- end

end

--累充
function RechargeMain:initTotal()
    self.totalBtn = TFDirector:getChildByPath(self.ui, "btn_total")
    self.totalPanel = TFDirector:getChildByPath(self.ui, "panel_total"):hide()
    self.loadingBarImg = TFDirector:getChildByPath(self.totalPanel, "img_loadingBar")
    self.loadingBar = TFDirector:getChildByPath(self.totalPanel, "loadingBar_progress")
    self.progressEndLabel = TFDirector:getChildByPath(self.totalPanel, "label_progressEnd")
    self.totalPayTipLabel = TFDirector:getChildByPath(self.totalPanel, "label_totalPayTip")
    self.coinLabel = TFDirector:getChildByPath(self.totalPanel, "label_coin") 
    self.totalPayLabel = TFDirector:getChildByPath(self.totalPanel, "label_totalPay") 
    self.loadingBarArrowImg = TFDirector:getChildByPath(self.totalPanel, "img_loadingBarArrow") 
    self.coinImg = TFDirector:getChildByPath(self.totalPanel, "img_coin")
end

--安卓月卡
function RechargeMain:initAndroidMonth()
    self.panel_monthCardUI = TFDirector:getChildByPath(self.ui, "panel_monthCardUI"):hide()
    self.btn_monthCard = TFDirector:getChildByPath(self.ui, "btn_monthCard")
    local ScrollView_monthCard = TFDirector:getChildByPath(self.panel_monthCardUI, "panel_tableView")
    self.monthCardListView = UIListView:create(ScrollView_monthCard)
    self.monthCard_redDot = TFDirector:getChildByPath(self.btn_monthCard, "img_redDot")
    self.monthCard_day = TFDirector:getChildByPath(self.panel_monthCardUI, "label_day")
    self.panel_monthCard = TFDirector:getChildByPath(self.ui, "panel_monthCard")
end

--IOS月卡
function RechargeMain:initIOSMonth()
	self.panel_monthCardUIIOS = TFDirector:getChildByPath(self.ui, "panel_monthCardUIIOS"):hide()
    local ScrollView_monthCard = TFDirector:getChildByPath(self.panel_monthCardUIIOS, "panel_tableView")
    self.monthCardListViewIos = UIListView:create(ScrollView_monthCard)
    self.monthCard_dayIos = TFDirector:getChildByPath(self.panel_monthCardUIIOS, "label_day")
    self.panel_monthCardIos = TFDirector:getChildByPath(self.ui, "panel_monthCardIos")
    self.monthCard_label_time = TFDirector:getChildByPath(self.panel_monthCardUIIOS, "label_time")
    self.monthCard_label_rule = TFDirector:getChildByPath(self.panel_monthCardUIIOS, "label_rule")
    self.monthCard_label_rule:setText("")
    local ScrollView_list = TFDirector:getChildByPath(self.ui, "panel_ruleTableView")
    self.text_list = UIListView:create(ScrollView_list)
    self.text_list:setItemsMargin(20)

    local label_tip3 =  TFDirector:getChildByPath(self.panel_monthCardUIIOS,"label_tip3")
    label_tip3:setTextById(1605010)

    local helpData = TopHelpDataMgr:getHelpDataByIds({998})
    local textType = false
    for i, v in ipairs(helpData) do
        if v.type == 0 then
            textType = true
            for i, id in ipairs(v.desc) do
                local label = self.monthCard_label_rule:clone()
                label:setTextById(id)
                label:show()
                self.text_list:pushBackCustomItem(label)
                if i == 2 then --月卡续费协议
                    label:setTouchEnabled(true)
                    label:onClick(function()
                        Box(TextDataMgr:getText(id))
                        TFDeviceInfo:openUrl(TextDataMgr:getText(id))
                    end)
                    local image = TFImage:create("ui/recharge/monthcardIos/img_line.jpg")
                    label:addChild(image)
                    local size = image:getContentSize()
                    image:setContentSize(CCSizeMake(label:getContentSize().width - 400, size.height))
                    image:setPosition(ccp((label:getContentSize().width - 400)/2, -label:getContentSize().height - 3))
                end
            end
        end
    end
end

function RechargeMain:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, -1, nil, handler(self.onCountDownPer, self))
    end
end

function RechargeMain:onCountDownPer()
    if not self.coolDown then
        return
    end
    local serverTime = ServerDataMgr:getServerTime()
    for k,v in pairs(self.coolDown) do
        local str = ""
        if v - serverTime > 0 then
            local day, hour, min = Utils:getFuzzyDHMS(v - serverTime, true)
            str = TextDataMgr:getText(100000074,day, hour, min)
        end
        k:setText(str)
    end
end

function RechargeMain:onShow()
    self.super.onShow(self)
    self:updateRedDotTip()
end

function RechargeMain:onHide()
    self.super.onHide(self)
end

function RechargeMain:updateRedDotTip( )
    local totalRedDotTipImg = TFDirector:getChildByPath(self.totalBtn,"img_redDot")
    totalRedDotTipImg:setVisible(FunctionDataMgr:isOpen(RechargeDataMgr:getTotalOpenId()) and RechargeDataMgr:getTotalRedDotState())
end

function RechargeMain:updateUI()
    local function update()
        if self.curType == "recharge" then
            self:updateRechargeUI()
        elseif self.curType == "gift" then
            self:updateGiftUI()
        elseif self.curType == "monthCard" then
            self:updateMonthCardUI()
        elseif self.curType == "TokenMoney" then
            self:updateTokenMoneyUI()
        else
            self:updateTotalUI()
        end
    end
    self:timeOut(update, 0)
    self:updateNew()
end

function RechargeMain:updateNew()
    local flag = RechargeDataMgr:getRechargeTabFlag()
    self.Button_rechangeNew:setVisible(not flag)
end

function RechargeMain:updateGiftUI()
	local preSize = self.scroll_list:getContentSize()
	self.panel_monthCardUI:setVisible(false)
    self.panel_monthCardUIIOS:setVisible(false)
    self.gridView:setVisible(true)
    self.totalPanel:setVisible(false)

    self.scroll_list:setContentSize(self.initSize)
    self.gridView:initParams()
    self.gridView:doLayout()

    local giftData = RechargeDataMgr:getGiftData()
    if not giftData then
    	self.gridView:setVisible(false)
        return
    end

    self.coolDown = {}
    local realDataList = {}
    local serverTime = ServerDataMgr:getServerTime()
    for k,v in ipairs(giftData) do
        if v.startDate and v.endDate then
            if serverTime >= v.startDate and serverTime < v.endDate then
                table.insert(realDataList, v)
            end
        else
            table.insert(realDataList, v)
        end
    end

    local items = self.gridView:getItems()
    local gap = #realDataList - #items
    if gap > 0 then
        for i = 1, math.abs(gap) do
            self.gridView:pushBackDefaultItem()
        end
    else
        for i = 1, math.abs(gap) do
            self.gridView:removeItem(1)
        end
    end

    local items = self.gridView:getItems()
    for i, item in ipairs(items) do
        local data = realDataList[i]
        if data then
        	item:show()
            local cell_recharge = TFDirector:getChildByPath(item, "cell_recharge")
        	local cell_token = TFDirector:getChildByPath(item, "cell_token")
        	local cell_gift = TFDirector:getChildByPath(item, "cell_gift")
        	local cell_total = TFDirector:getChildByPath(item, "cell_total")
        	local cell_item = TFDirector:getChildByPath(item, "cell_item")
        	cell_recharge:hide()
        	cell_gift:show()
        	cell_total:hide()
        	cell_item:show()
        	cell_token:hide()
            self:updateGiftItem(cell_gift, data)
            Utils:createRewardItemStyle1(cell_item, data.item)
        end
    end

    if preSize.height ~= self.initSize.height then
    	self.scroll_list:jumpToTop()
    end
end

function RechargeMain:updateGiftItem(item, data)
	local Label_price   = TFDirector:getChildByPath(item,"Label_price")
    Label_price:setTextById(1605003, string.format("%.2f" ,data.rechargeCfg.price/100))

    local Image_exchange = TFDirector:getChildByPath(item,"Image_exchange"):hide()
    if data.buyType == 1 then
        local exchangeCfg = GoodsDataMgr:getItemCfg(data.exchangeCost[1].id)
        Image_exchange:show();
        Image_exchange:setTexture(exchangeCfg.icon)
        Image_exchange:setSize(CCSizeMake(45,45))
        Label_price:setString(data.exchangeCost[1].num)

        local exchangeWidth = Image_exchange:getContentSize().width * Image_exchange:getScale()
        local priceLabelWidth = Label_price:getContentSize().width
        local totalWidth = exchangeWidth + priceLabelWidth + 5
        Image_exchange:setPositionX(exchangeWidth / 2 - totalWidth / 2)
        Label_price:setPositionX(Image_exchange:getPositionX() + (exchangeWidth + priceLabelWidth) / 2 + 5)
    end

    local Label_num = TFDirector:getChildByPath(item,"Label_num")
    Label_num:setTextById(data.name)

    local Label_leftTime= TFDirector:getChildByPath(item,"Label_leftTime")
    Label_leftTime:setString(data.buyCount - RechargeDataMgr:getBuyCount(data.rechargeCfg.id))
    Label_leftTime:setVisible(data.buyCount ~= 0)

    local Label_tips = TFDirector:getChildByPath(item,"Label_tips")
    Label_tips:setVisible(data.buyCount ~= 0)

    local Label_desc = TFDirector:getChildByPath(item,"Label_desc")
    Label_desc:setTextById(data.des2)

    local serverTime = ServerDataMgr:getServerTime()
    local Label_countdown = TFDirector:getChildByPath(item,"Label_countdown")
    Label_countdown:setText("")
    if data.startDate and data.endDate and serverTime >= data.startDate and serverTime < data.endDate then
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

    local Button_buy = TFDirector:getChildByPath(item, "Button_buy")
    Button_buy:onClick(function()
        data.extendData = data.extendData or ""
        local tipId = Utils:getStoreBuyTipId(json.decode(data.extendData),2)
        if tipId then
            local args = {
                tittle = 2107025,
                reType = "buyGiftTip",
                content = TextDataMgr:getText(tipId),
                confirmCall = function ( ... )
                     if data.buyCount ~= 0 and data.buyCount - RechargeDataMgr:getBuyCount(data.rechargeCfg.id) <= 0 then
                        Utils:showTips(800117)
                        return
                    end
                    RechargeDataMgr:getOrderNO(data.rechargeCfg.id)
                end,
            }
            Utils:showReConfirm(args)
            return
        end

        if data.buyCount ~= 0 and data.buyCount - RechargeDataMgr:getBuyCount(data.rechargeCfg.id) <= 0 then
            Utils:showTips(800117)
            return
        end

        RechargeDataMgr:getOrderNO(data.rechargeCfg.id)
    end)

    Button_buy:setGrayEnabled(not isCanBuy)
    Button_buy:setTouchEnabled(isCanBuy)

    local Image_title_di = TFDirector:getChildByPath(item,"Image_title_di")
    local Label_title_desc = TFDirector:getChildByPath(item,"Label_title_desc")
    local Label_title_desc1 = TFDirector:getChildByPath(item,"Label_title_desc1")

    if data.tag then
        local tagType = data.tagIcon or 0
        local buyCount = RechargeDataMgr:getBuyCount(data.rechargeCfg.id)
        if buyCount == 0 then
            Label_title_desc:setTextById(data.tagDes)
            Label_title_desc1:setTextById(data.tagDes)
        elseif data.tagDes2 ~= "" then
            Label_title_desc:setTextById(data.tagDes2)
            Label_title_desc1:setTextById(data.tagDes2)
        else
            Image_title_di:hide()
        end
        if tagType == 1 then
            Image_title_di:setTexture("ui/recharge/new_ui/08.png")
        else
            Image_title_di:setTexture("ui/recharge/new_ui/07.png")
        end
        Label_title_desc:setVisible(tagType == 1)
        Label_title_desc1:setVisible(tagType ~= 1)
    else
        Image_title_di:hide()
    end
end

function RechargeMain:updateRechargeUI()
    self.coolDown = {}
	local preSize = self.scroll_list:getContentSize()
	self.panel_monthCardUI:setVisible(false)
    self.panel_monthCardUIIOS:setVisible(false)
    self.gridView:setVisible(true)
    self.totalPanel:setVisible(false)

    self.scroll_list:setContentSize(self.initSize)
    self.gridView:initParams()
    self.gridView:doLayout()

    local rechargeList = RechargeDataMgr:getRechargeList()
    local items = self.gridView:getItems()
    local gap = #rechargeList - #items
    if gap > 0 then
        for i = 1, math.abs(gap) do
            self.gridView:pushBackDefaultItem()
        end
    else
        for i = 1, math.abs(gap) do
            self.gridView:removeItem(1)
        end
    end

    local items = self.gridView:getItems()
    for i, item in ipairs(items) do
        local data = rechargeList[i]
        if data then
        	item:show()
            local cell_recharge = TFDirector:getChildByPath(item, "cell_recharge")
        	local cell_token = TFDirector:getChildByPath(item, "cell_token")
        	local cell_gift = TFDirector:getChildByPath(item, "cell_gift")
        	local cell_total = TFDirector:getChildByPath(item, "cell_total")
        	local cell_item = TFDirector:getChildByPath(item, "cell_item")
        	cell_recharge:show()
        	cell_gift:hide()
        	cell_token:hide()
        	cell_total:hide()
        	cell_item:hide()
        	self:updateRechargeItem(cell_recharge, data, false)
        end
    end

    if preSize.height ~= self.initSize.height then
    	self.scroll_list:jumpToTop()
    end
end

function RechargeMain:updateRechargeItem(item, data, isMonthCard)
	local Label_price = TFDirector:getChildByPath(item,"Label_price")
    
    Label_price:setTextById(1605003 ,string.format("%.2f" ,data.rechargeCfg.price/100))

    local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
    Image_icon:setTexture(data.icon)

    local Image_new = TFDirector:getChildByPath(item,"Image_new");
    Image_new:setVisible(isMonthCard and RechargeDataMgr:getMonthCardLeftTime() <= 0 )
    
    local Label_title = TFDirector:getChildByPath(item,"Label_title")
    Label_title:setTextById(13003)

    local panel_price = TFDirector:getChildByPath(item, "panel_price")
    panel_price:setVisible(not isMonthCard)

    local Image_zuan = TFDirector:getChildByPath(item, "Image_zuan")
    local comid = data.item[1].id
    local cfg = GoodsDataMgr:getItemCfg(comid)
    Image_zuan:setTexture(cfg.icon)

    local Label_num = TFDirector:getChildByPath(item,"Label_num")
    Label_num:setText(data.name)

    local Label_x = TFDirector:getChildByPath(item,"Label_x")

    if comid == EC_SItemType.TokenMoney then
        Label_title:setTextById(14300062)
    end

    local Label_desc    = TFDirector:getChildByPath(item,"Label_desc")
    Label_desc:setTextById(data.des1)
    Label_desc:setVisible((not isMonthCard) and (not(comid == EC_SItemType.TokenMoney)))

    local Label_desc_month = TFDirector:getChildByPath(item,"Label_desc_month")
    Label_desc_month:setTextById(data.des1)
    Label_desc_month:setVisible(isMonthCard)

    local Label_leftTime = TFDirector:getChildByPath(item,"Label_leftTime")
    Label_leftTime:setVisible(isMonthCard)

    local isOpenDoubleCard = ActivityDataMgr2:isOpen(EC_ActivityType2.DOUBLE_CARD)
    local Image_double = TFDirector:getChildByPath(item, "Image_double")
    Image_double:setVisible(isOpenDoubleCard and isMonthCard)

    local Image_title_di = TFDirector:getChildByPath(item, "Image_title_di")
    local Label_title_desc = TFDirector:getChildByPath(item, "Label_title_desc")
    local Label_title_desc1 = TFDirector:getChildByPath(item, "Label_title_desc1")
    Label_title:setVisible(data.tag)
    Image_title_di:setVisible(data.tag)
    if data.tag then
        local tagType = RechargeDataMgr:getTagType(data.rechargeCfg.id)
        local Label_title = TFDirector:getChildByPath(item, "Label_title")
        local buyCount = RechargeDataMgr:getBuyCount(data.rechargeCfg.id)
        if buyCount == 0 then
            Label_title_desc:setTextById(data.tagDes)
            Label_title_desc1:setTextById(data.tagDes)
        elseif data.tagDes2 ~= "" then
            Label_title_desc:setTextById(data.tagDes2)
            Label_title_desc1:setTextById(data.tagDes2)
        else
            Image_title_di:hide()
        end

        if tagType == 1 then
            Image_title_di:setTexture("ui/recharge/new_ui/08.png")
        else
            Image_title_di:setTexture("ui/recharge/new_ui/07.png")
        end
        Label_title_desc:setVisible(tagType == 1)
        Label_title_desc1:setVisible(tagType ~= 1)
    end

    local Button_buy = TFDirector:getChildByPath(item, "Button_buy")
    Button_buy:onClick(function()
        data.extendData = data.extendData or ""
        local tipId = Utils:getStoreBuyTipId(json.decode(data.extendData),2)
        if tipId then
            local args = {
                tittle = 2107025,
                reType = "buyGiftTip",
                content = TextDataMgr:getText(tipId),
                confirmCall = function ( ... )
                    RechargeDataMgr:getOrderNO(data.rechargeCfg.id)
                end,
            }
            Utils:showReConfirm(args)
            return
        end

        RechargeDataMgr:getOrderNO(data.rechargeCfg.id)

    end)

    local zuanWidth = Image_zuan:getContentSize().width * Image_zuan:getScale()
    local zuanPosX = Image_zuan:getPositionX()
    local numLabelWidth = Label_num:getContentSize().width
    local numLabelPosX = Label_num:getPositionX()
    local xLabelPosX = Label_x:getPositionX()
    local totalWidth = zuanWidth / 2 + math.abs(numLabelPosX - zuanPosX) + numLabelWidth
    Image_zuan:setPositionX(zuanWidth / 2 - totalWidth / 2)
    Label_x:setPositionX(Image_zuan:getPositionX() + math.abs(xLabelPosX - zuanPosX))
    Label_num:setPositionX(Label_x:getPositionX() + math.abs(numLabelPosX - xLabelPosX))
end

function RechargeMain:updateTotalUI()
    self.coolDown = {}
	local preSize = self.scroll_list:getContentSize()
	self.panel_monthCardUI:setVisible(false)
    self.panel_monthCardUIIOS:setVisible(false)
    self.gridView:setVisible(true)
    self.totalPanel:setVisible(true)

    local curSize = CCSize(self.initSize.width, 460)
    self.scroll_list:setContentSize(curSize)
    self.gridView:initParams()
    self.gridView:doLayout()

    --累计充值数
    local totalPayDiamond = RechargeDataMgr:getTotalPay()
    self.coinLabel:setString(string.format("%.2f" ,totalPayDiamond * 0.01) )

    local nextPayDiamond = RechargeDataMgr:getNextRewardCfgAmount()
    self.totalPayLabel:setString(nextPayDiamond * 0.01)
    self.totalPayLabel:setVisible(#RechargeDataMgr:getRewardIds() < #RechargeDataMgr:getRewardCfgs())

    local precent = math.min(totalPayDiamond/nextPayDiamond*100, 100)
    self.loadingBarArrowImg:setVisible(precent > 0 and #RechargeDataMgr:getRewardIds() < #RechargeDataMgr:getRewardCfgs())
    self.loadingBarArrowImg:setPositionX(self.loadingBarImg:getContentSize().width*precent*0.01)

    --充值进度
    self.loadingBar:setPercent(precent)
    self.loadingBarImg:setVisible(#RechargeDataMgr:getRewardIds() < #RechargeDataMgr:getRewardCfgs())

    self.totalPayTipLabel:setVisible(#RechargeDataMgr:getRewardIds() < #RechargeDataMgr:getRewardCfgs())
    self.coinImg:setVisible(#RechargeDataMgr:getRewardIds() < #RechargeDataMgr:getRewardCfgs())
    self.progressEndLabel:setVisible(#RechargeDataMgr:getRewardIds() >= #RechargeDataMgr:getRewardCfgs())

    local totalPayRewardCfg = RechargeDataMgr:getRewardCfgsBySort()
    local items = self.gridView:getItems()
    local gap = #totalPayRewardCfg - #items
    if gap > 0 then
        for i = 1, math.abs(gap) do
            self.gridView:pushBackDefaultItem()
        end
    else
        for i = 1, math.abs(gap) do
            self.gridView:removeItem(1)
        end
    end

    local items = self.gridView:getItems()
    for i, item in ipairs(items) do
        local data = totalPayRewardCfg[i]
        if data then
        	item:show()
        	local cell_recharge = TFDirector:getChildByPath(item, "cell_recharge")
        	local cell_token = TFDirector:getChildByPath(item, "cell_token")
        	local cell_gift = TFDirector:getChildByPath(item, "cell_gift")
        	local cell_total = TFDirector:getChildByPath(item, "cell_total")
        	local cell_item = TFDirector:getChildByPath(item, "cell_item")
        	cell_recharge:hide()
        	cell_gift:hide()
        	cell_total:show()
        	cell_item:show()
        	cell_token:hide()
            self:updateTotalItem(cell_total, data)
            cell_item:setPositionY(47)
            Utils:createRewardItemStyle1(cell_item, data.items, data.canReward)
        end
    end

    if preSize.height ~= curSize.height then
    	self.scroll_list:jumpToTop()
    end
end

function RechargeMain:updateTotalItem(item, data)
	--档位所需钻石数
    local totalDiamondLabel = TFDirector:getChildByPath(item, "label_totalDiamond")
    totalDiamondLabel:setString(string.format("%.2f" ,data.amount * 0.01))

    --简介
    local introLabel = TFDirector:getChildByPath(item, "label_intro")
    introLabel:setTextById(data.des)

    --需要达到的钻石数
    local payLabel = TFDirector:getChildByPath(item, "label_pay")
    local needPay = (data.amount - RechargeDataMgr:getTotalPay()) * 0.01
    payLabel:setString(TextDataMgr:getText(266101, needPay))

    payLabel:setVisible((not RechargeDataMgr:getRewardIdReachState(data.id)) and data.canReward)

    --暂未开启
    local unOpenLabel = TFDirector:getChildByPath(item, "label_unopen")
    unOpenLabel:setVisible(not data.canReward)

    --领取奖励
    local rewardBtn = TFDirector:getChildByPath(item, "btn_reward")
    rewardBtn:onClick(function()
        RechargeDataMgr:sendRewardTotalPay(data.id)
    end)
    rewardBtn:setVisible(data.canReward and RechargeDataMgr:getRewardIdReachState(data.id))
    rewardBtn:setGrayEnabled(RechargeDataMgr:getRewardIdReachState(data.id) and RechargeDataMgr:getRewardState(data.id))
    rewardBtn:setTouchEnabled(RechargeDataMgr:getRewardIdReachState(data.id) and (not RechargeDataMgr:getRewardState(data.id)))

    local label_reward = TFDirector:getChildByPath(rewardBtn, "label_reward")
    local label_rewarded = TFDirector:getChildByPath(rewardBtn, "label_rewarded")
    label_reward:setVisible(RechargeDataMgr:getRewardIdReachState(data.id) and (not RechargeDataMgr:getRewardState(data.id)))
    label_rewarded:setVisible(RechargeDataMgr:getRewardIdReachState(data.id) and RechargeDataMgr:getRewardState(data.id))
end

function RechargeMain:onGoodItemClickHandle(sender)
	if not sender.id then return end
	Utils:showInfo(sender.id, nil, true)
end

function RechargeMain:updateMonthCardUI()
    self.coolDown = {}
    self.gridView:setVisible(false)
    self.totalPanel:setVisible(false)

    --if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 or (CC_TARGET_PLATFORM == CC_PLATFORM_IOS and tonumber(TFDeviceInfo:getCurAppVersion()) >= 3.65) then
    if false then  --统一使用安卓月卡界面
        self.panel_monthCardUIIOS:setVisible(true)
    else
        self.panel_monthCardUI:setVisible(true)
    end
    
    --月卡剩余天数
    self.cardLeftTime = RechargeDataMgr:getMonthCardLeftTime()
    self.monthCard_day:setText(self.cardLeftTime)
    self.monthCard_dayIos:setText(self.cardLeftTime)

    --刷新月卡列表
    local monthCardData = RechargeDataMgr:getMonthCardList()
    if not monthCardData then
        return
    end
    self.cardType = CardType.MonthCard -- 月卡移除
    if self.cardLeftTime <= 0 then
        self.cardType = CardType.MonthCard
    else
        self.cardType = CardType.MonthCardEx
    end

    local useItemList = self.monthCardListView:getItems()
    local num = (#monthCardData - #useItemList)
    if num > 0 then
        for i = 1, num do
            local item = self.panel_monthCard:clone()
            self.monthCardListView:pushBackCustomItem(item)
            local itemIos = self.panel_monthCardIos:clone()
            self.monthCardListViewIos:pushBackCustomItem(itemIos)
        end
    end
    useItemList = self.monthCardListView:getItems()
    for i, v in ipairs(useItemList) do
        self:updateMonthCardItem(v, monthCardData[i])
    end

    useItemList = self.monthCardListViewIos:getItems()
    for i, v in ipairs(useItemList) do
        self:updateMonthCardItemIos(v, monthCardData[i])
    end
    RechargeDataMgr:getMonthCardSignData().subscibeTime = RechargeDataMgr:getMonthCardSignData().subscibeTime or 0

    if RechargeDataMgr:getMonthCardSignData().subscibeTime > 0 then
        local year, month, day = Utils:getDate(RechargeDataMgr:getMonthCardSignData().subscibeTime)
        self.monthCard_label_time:setTextById(1605008, year.. "/" .. month .. "/" .. day)
    else
        self.monthCard_label_time:setTextById(1605009)
    end
    self.monthCard_redDot:setVisible(RechargeDataMgr:getMonthCardLeftTime() <= 0)
end

function RechargeMain:updateTokenMoneyUI()
    self.coolDown = {}
    local preSize = self.scroll_list:getContentSize()
	self.panel_monthCardUI:setVisible(false)
    self.panel_monthCardUIIOS:setVisible(false)
    self.gridView:setVisible(true)
    self.totalPanel:setVisible(false)

    self.scroll_list:setContentSize(self.initSize)
    self.gridView:initParams()
    self.gridView:doLayout()

    local rechargeList = RechargeDataMgr:getTokenMoneyData()
    local items = self.gridView:getItems()
    local gap = #rechargeList - #items
    if gap > 0 then
        for i = 1, math.abs(gap) do
            self.gridView:pushBackDefaultItem()
        end
    else
        for i = 1, math.abs(gap) do
            self.gridView:removeItem(1)
        end
    end

    local items = self.gridView:getItems()
    for i, item in ipairs(items) do
        local data = rechargeList[i]
        if data then
        	item:show()
        	local cell_recharge = TFDirector:getChildByPath(item, "cell_recharge")
        	local cell_token = TFDirector:getChildByPath(item, "cell_token")
        	local cell_gift = TFDirector:getChildByPath(item, "cell_gift")
        	local cell_total = TFDirector:getChildByPath(item, "cell_total")
        	local cell_item = TFDirector:getChildByPath(item, "cell_item")
        	cell_recharge:hide()
        	cell_gift:hide()
        	cell_total:hide()
        	cell_item:hide()
        	cell_token:show()
        	self:updateRechargeItem(cell_token, data, false)
        end
    end

    if preSize.height ~= self.initSize.height then
    	self.scroll_list:jumpToTop()
    end
end

function RechargeMain:updateMonthCardItem(item, data)
    local img_title = TFDirector:getChildByPath(item, "img_title")
    local img_bg = TFDirector:getChildByPath(item, "img_bg")
    local img_icon = TFDirector:getChildByPath(item, "img_icon")
    local label_title = TFDirector:getChildByPath(item, "label_title")
    local label_intro1 = TFDirector:getChildByPath(item, "label_intro1")
    local label_intro2 = TFDirector:getChildByPath(item, "label_intro2")
    local label_intro3 = TFDirector:getChildByPath(item, "label_intro3")
    local label_pay = TFDirector:getChildByPath(item, "label_pay")
    local Image_tishi = TFDirector:getChildByPath(item, "Image_tishi"):hide()
    local titleBgImg = {[1] = "ui/recharge/CZ_YK_bg2.png", [4] = "ui/recharge/CZ_YK_bg3.png", [7] = "ui/recharge/CZ_YK_bg2.png"}
    img_title:setTexture(titleBgImg[data.type])
    img_icon:hide()

    label_intro3:setTextById(190000161)

    if not item.icon_spine then
        item.icon_spine = SkeletonAnimation:create(data.icon)
        local pos = img_icon:getPosition()
        item.icon_spine:setPosition(ccp(pos.x, pos.y - 30))
        item.icon_spine:setAnimationFps(GameConfig.ANIM_FPS)
        item.icon_spine:playByIndex(0, -1, -1, 1)
        item.icon_spine:setZOrder(2)
        img_icon:getParent():addChild(item.icon_spine)
    end
    label_title:setTextById(data.name)
    RechargeDataMgr:getMonthCardSignData().subscibeTime = RechargeDataMgr:getMonthCardSignData().subscibeTime or 0

    local year, month, day = Utils:getDate(RechargeDataMgr:getMonthCardSignData().subscibeTime)
    label_intro1:setTextById(1605008, year .. "/" .. month .. "/" .. day)
    label_intro2:setTextById(data.des1)
    if data.type == 7 then
        if RechargeDataMgr:getMonthCardSignData().subscibeTime > 0 then
            label_intro1:show()
        else
            label_intro1:hide()
        end
        label_intro3:show()
        Image_tishi:show()
        Image_tishi:setTouchEnabled(true)
        Image_tishi:onClick(function()
            local layer = require("lua.logic.store.MonthCardNew"):new({{998}, data})
            AlertManager:addLayer(layer)
            AlertManager:show()
        end)
    else
        label_intro1:hide()
        label_intro3:hide()
    end
    
    label_pay:setTextById(1605003 ,string.format("%.2f" ,data.rechargeCfg.price/100))

    img_bg:onClick(function ()
        if data.type == 7 then
            local layer = require("lua.logic.store.MonthCardNew"):new({{998}, data})
            AlertManager:addLayer(layer)
            AlertManager:show()
        else
            RechargeDataMgr:getOrderNO(data.rechargeCfg.id)
        end
    end)
end

function RechargeMain:updateMonthCardItemIos(item, data)
    local img_bg = TFDirector:getChildByPath(item, "img_bg")
    local img_icon = TFDirector:getChildByPath(item, "img_icon")
    local label_title = TFDirector:getChildByPath(item, "label_title")
    local label_pay = TFDirector:getChildByPath(item, "label_pay")
    img_icon:hide()

    if not item.icon_spine then
        item.icon_spine = SkeletonAnimation:create(data.icon)
        local pos = img_icon:getPosition()
        item.icon_spine:setPosition(ccp(pos.x, pos.y - 30))
        item.icon_spine:setAnimationFps(GameConfig.ANIM_FPS)
        item.icon_spine:playByIndex(0, -1, -1, 1)
        item.icon_spine:setZOrder(2)
        item.icon_spine:setScale(img_icon:getScale())
        img_icon:getParent():addChild(item.icon_spine)
    end
    label_title:setText(data.name)
    
    label_pay:setTextById(1605003 , string.format("%.2f" ,data.rechargeCfg.price / 100))

    img_bg:onClick(function ()
        if data.type == 7 then
            local layer = require("lua.logic.store.MonthCardNew"):new({{998}, data})
            AlertManager:addLayer(layer)
            AlertManager:show()
        else
            RechargeDataMgr:getOrderNO(data.rechargeCfg.id)
        end
    end)
end

function RechargeMain:onTouchBottomBtn(btn)

    --充值
    if btn == self.Button_rechange then
        self.selectIndex_ = 1
        self.Button_rechange:setTextureNormal("ui/common/left_side/side_select.png")
        self.Image_charge_icon:setTexture("ui/recharge/2.png")
        self.totalBtn:setTextureNormal("")
        self.btn_monthCard:setTextureNormal("")
        self.btn_TokenMoney:setTextureNormal("")
        self:updateRechargeUI()
        self.curType = "recharge"
        return
    end

    --累充
    if btn == self.totalBtn then
        self.selectIndex_ = 3
        self.totalBtn:setTextureNormal("ui/common/left_side/side_select.png")
        self.Image_charge_icon:setTexture("ui/recharge/3.png")
        self.Button_rechange:setTextureNormal("")
        self.btn_monthCard:setTextureNormal("")
        self.btn_TokenMoney:setTextureNormal("")
        self:updateTotalUI()
        self.curType = "total"
        return
    end

    --月卡
    if btn == self.btn_monthCard then
        self.selectIndex_ = 4
        self.btn_monthCard:setTextureNormal("ui/common/left_side/side_select.png")
        self.Image_charge_icon:setTexture("ui/recharge/3.png")
        self.Button_rechange:setTextureNormal("")
        self.totalBtn:setTextureNormal("")
        self.btn_TokenMoney:setTextureNormal("")
        self:updateMonthCardUI()
        self.curType = "monthCard"
        return
    end

    --代币
    if btn == self.btn_TokenMoney then
        self.selectIndex_ = 5
        self.btn_TokenMoney:setTextureNormal("ui/common/left_side/side_select.png")
        self.Image_charge_icon:setTexture("ui/recharge/3.png")
        self.Button_rechange:setTextureNormal("")
        self.totalBtn:setTextureNormal("")
        self.btn_monthCard:setTextureNormal("")
        self:updateTokenMoneyUI()
        self.curType = "TokenMoney"
        return
    end
end

function RechargeMain:registerEvents()
    self.super.registerEvents(self)
    self:registerCustomEvents()

    self.Button_rechange:onClick(function()
        self:onTouchBottomBtn(self.Button_rechange)
    end)

    self.totalBtn:onClick(function()
        if not FunctionDataMgr:checkFuncOpen(66) then
        	return 
        end 
        self:onTouchBottomBtn(self.totalBtn)
    end)

    self.btn_monthCard:onClick(function()
        self:onTouchBottomBtn(self.btn_monthCard)
    end)

    self.btn_TokenMoney:onClick(function()
        self:onTouchBottomBtn(self.btn_TokenMoney)
    end)
end

function RechargeMain:onResRewardTotalPayRsp(reward)
    Utils:showReward(reward)
    self:updateTotalUI()
end

function RechargeMain:registerCustomEvents( )
    EventMgr:addEventListener(self,EV_RECHARGE_UPDATE,handler(self.updateUI, self))
    EventMgr:addEventListener(self, RechargeDataMgr.RESREWARDTOTALPAY, handler(self.onResRewardTotalPayRsp, self))
end

function RechargeMain:removeCountDownTimer()
    if self.countDownTimer_ then
    	TFDirector:stopTimer(self.countDownTimer_)
        TFDirector:removeTimer(self.countDownTimer_)
        self.countDownTimer_ = nil
    end
end

function RechargeMain:removeEvents()
    self.super.removeEvents(self)
    self:removeCountDownTimer()
end

return RechargeMain
