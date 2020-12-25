--[[
    -- 养成基金新界面
]]

local FundNewView = class("FundNewView", BaseLayer)

function FundNewView:initData()
    self.cfgs = {}
    for i, cfg in pairs(TabDataMgr:getData("DevelopmentFund")) do
        table.insert(self.cfgs, cfg)
    end
end

function FundNewView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.supplyNew.fundNewView")
end

function FundNewView:initUI(ui)
    self.super.initUI(self, ui)

    self.initViewSize = self._ui.scroll_list:getContentSize()
    self.view = UIGridView:create(self._ui.scroll_list)
	self.view:setItemModel(self._ui.panel_cell)
	self.view:setColumn(2)
    self.view:setColumnMargin(12)
    self.view:setRowMargin(5)
    self:updateView()
end

function FundNewView:registerEvents()
    self.super.registerEvents(self)
    EventMgr:addEventListener(self, EV_GROWFUND_UPDATE, handler(self.updateView, self))
end

function FundNewView:updateView()
    for i, cfg in ipairs(self.cfgs) do
        local serverData = RechargeDataMgr:getGrowFundById(cfg.id)
        self.cfgs[i].serverData = serverData
    end

    for j, v in ipairs(self.cfgs) do
        local fundCfg = RechargeDataMgr:getOneRechargeCfg(v.investMoneyID)
        if fundCfg.startDate and fundCfg.endDate then -- 限时基金礼包
            local timeNow = ServerDataMgr:getServerTime()
            if timeNow < fundCfg.startDate then -- 未开始
                table.remove(self.cfgs, j)
            end
            if timeNow > fundCfg.endDate then -- 已结束 显示时间外还不能移除的情况
                local tmp = nil
                if v.serverData and v.serverData.restDays then
                    if v.serverData.restDays > 0 or (v.serverData.restDays == 0 and not v.serverData.todayAward)  then
                        tmp = j
                    end
                end
                if not tmp then
                    table.remove(self.cfgs, j)
                end
            end
        end
    end

    table.sort(self.cfgs, function(a, b)
        return tonumber(a.reorder) > tonumber(b.reorder)
    end)

    if #self.cfgs == 0  then
        self.view:setVisible(false)
        return
    end

    self:removerAllItemTimer()
    local items = self.view:getItems()
    local gap = #self.cfgs - #items
    if gap > 0 then
        for i = 1, math.abs(gap) do
            self.view:pushBackDefaultItem()
        end
    else
        for i = 1, math.abs(gap) do
            self.view:removeItem(1)
        end
    end

    local items = self.view:getItems()
    for i, item in ipairs(items) do
        local data = self.cfgs[i]
        if data then
            self:updateItem(item, data)
        end
    end
end

function FundNewView:updateItem(item, data)
    local lab_lastDays = TFDirector:getChildByPath(item, "lab_lastDays")

    local Button_buy = TFDirector:getChildByPath(item, "Button_buy")
    Button_buy:setTouchEnabled(true)
    Button_buy:setGrayEnabled(false)
    local Image_exchange = TFDirector:getChildByPath(Button_buy, "Image_exchange")
    local Label_price = TFDirector:getChildByPath(Button_buy, "Label_price")
    if not Label_price.posy then
        Label_price.posy = Label_price:getPositionY()
    end
    local lab_buy = TFDirector:getChildByPath(Button_buy, "lab_buy"):hide()
    local lab_buyAgain = TFDirector:getChildByPath(Button_buy, "lab_buyAgain"):hide()

    local panel_getNow = TFDirector:getChildByPath(item, "panel_getNow")
    local img_nowGet = TFDirector:getChildByPath(panel_getNow, "img_nowGet")
    local lab_nowGet = TFDirector:getChildByPath(panel_getNow, "lab_nowGet")

    local Image_fundView_2 = TFDirector:getChildByPath(item, "Image_fundView_2")
    local img_dayGet = TFDirector:getChildByPath(Image_fundView_2, "img_dayGet")
    local lab_dayGet = TFDirector:getChildByPath(Image_fundView_2, "lab_dayGet")

    local Button_get = TFDirector:getChildByPath(item, "Button_get")
    -- local img_btnGet = TFDirector:getChildByPath(item, "img_btnGet")
    local lab_getNum = TFDirector:getChildByPath(Button_get, "lab_getNum")
    local lab_get    = TFDirector:getChildByPath(Button_get, "lab_get")

    local lab_name = TFDirector:getChildByPath(item, "lab_name")
    local img_icon = TFDirector:getChildByPath(item, "img_icon")

    local lab_keepDays = TFDirector:getChildByPath(item, "lab_keepDays")

    local img_time       = TFDirector:getChildByPath(item, "img_time"):hide()
    local lab_lastTime   = TFDirector:getChildByPath(item, "lab_lastTime")
    local lab_limitTimes = TFDirector:getChildByPath(item, "lab_limitTimes")

    local Label_priceOldLine = TFDirector:getChildByPath(item, "Label_priceOldLine"):hide()
    local Label_priceOld = TFDirector:getChildByPath(item, "Label_priceOld")

    Button_get:setVisible(false)
    img_icon:setTexture(data.titleIcon)
    lab_name:setTextById(tonumber(data.notable))

    if data.serverData then
        Button_get:setVisible(not data.serverData.todayAward)
        lab_lastDays:setText(data.serverData.restDays)
    else
        lab_lastDays:setText(0)
    end

    if not item.ScrollView_award then
        item.ScrollView_award = UIListView:create(TFDirector:getChildByPath(item, "ScrollView_award"))
    end
    item.ScrollView_award:removeAllItems()
    for i, v in ipairs(data.reward) do
        local goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        PrefabDataMgr:setInfo(goodsItem, v[1], v[2])
        goodsItem:setScale(0.75)
        item.ScrollView_award:pushBackCustomItem(goodsItem)
    end

    local format_reward = {}
    for i, v in ipairs(data.reward) do
        table.insert( format_reward, {id = v[1],num = v[2]})
    end

    Button_get:onClick(function()
        RechargeDataMgr:SendGrowFundRward(data.id)
    end)
    
    local fundCfg = RechargeDataMgr:getOneRechargeCfg(data.investMoneyID) 
    local hadboughtCount = RechargeDataMgr:getBuyCount(data.investMoneyID)

    if fundCfg.startDate and fundCfg.endDate then
        local function timerFunc()
            local timeNow = ServerDataMgr:getServerTime()
            local str = ""
            if fundCfg.endDate - timeNow > 0 then
                local day, hour, min = Utils:getDHMS(fundCfg.endDate - timeNow, true)
                -- str = TextDataMgr:getText(100000074,day, hour, min)
                str = TextDataMgr:getText(23029, day)
            else
                -- self:updateView()
            end
            local residueBuyCount = fundCfg.buyCount - RechargeDataMgr:getBuyCount(data.investMoneyID) 
            lab_limitTimes:setTextById(23030, residueBuyCount)
            lab_lastTime:setText(str)
            img_time:setVisible(str ~= "")
            if fundCfg.buyCount ~= 0 then
                Button_buy:setGrayEnabled(str == "" or residueBuyCount <= 0)
                Button_buy:setTouchEnabled(str ~= "" and residueBuyCount > 0)
            else
                Button_buy:setGrayEnabled(str == "")
                Button_buy:setTouchEnabled(str ~= "")
            end
        end
        timerFunc()
        if not item.timer then
            item.timer = TFDirector:addTimer(10000, -1, nil, timerFunc)
        end
    else
        lab_limitTimes:setTextById(14220014)
        img_time:hide()
    end

    Label_price:setText(fundCfg.exchangeCost[1].num) 
    Image_exchange:setTexture( GoodsDataMgr:getItemCfg(fundCfg.exchangeCost[1].id).icon)
    Image_exchange:setSize(ccs(35,35))
    Button_buy:onClick(function()
        RechargeDataMgr:getOrderNO(data.investMoneyID)
    end)

    local goodsCfg1 = GoodsDataMgr:getItemCfg(fundCfg.firstBuyItem[1].id)
    img_nowGet:setTexture(goodsCfg1.icon)
    img_nowGet:setSize(ccs(30,28))
    lab_nowGet:setText("x"..fundCfg.firstBuyItem[1].num)

    lab_keepDays:setText(fundCfg.days or "")

    if not Label_priceOldLine:isVisible() then
        Label_price:setPositionY(Label_price.posy - 13)
    end
end

function FundNewView:removerAllItemTimer()
    for i, item in ipairs(self.view:getItems()) do
        if item.timer then
            TFDirector:removeTimer(item.timer)
            item.timer = nil
        end
    end
end

function FundNewView:removeEvents()
    self.super.removeEvents(self)
    self:removerAllItemTimer()
end

return FundNewView