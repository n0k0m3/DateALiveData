--[[
    -- 养成基金界面
]]

local FundGrowView = class("FundGrowView", BaseLayer)

function FundGrowView:initData()
    self.cfgs = {}
    for i, cfg in pairs(TabDataMgr:getData("DevelopmentFund")) do
        table.insert(self.cfgs, cfg)
    end
end

function FundGrowView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.recharge.fundView")
end

function FundGrowView:initUI(ui)
    self.super.initUI(self, ui)

    self.initViewSize = self._ui.scroll_list:getContentSize()
    self.view = UIGridView:create(self._ui.scroll_list)
	self.view:setItemModel(self._ui.panel_cell)
	self.view:setColumn(2)
    self.view:setColumnMargin(15)
    self.view:setRowMargin(15)
    self:updateView()
end

function FundGrowView:registerEvents()
    self.super.registerEvents(self)
    EventMgr:addEventListener(self, EV_GROWFUND_UPDATE, handler(self.updateView, self))
end

function FundGrowView:updateView()
    for i, cfg in ipairs(self.cfgs) do
        local serverData = RechargeDataMgr:getGrowFundById(cfg.id)
        self.cfgs[i].serverData = serverData
    end

    if #self.cfgs == 0  then
        self.view:setVisible(false)
        return
    end

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

function FundGrowView:updateItem(item, data)
    local bgDi =  TFDirector:getChildByPath(item, "img_di")
    local lab_lastDays = TFDirector:getChildByPath(bgDi, "lab_lastDays")
    local img_Icon = TFDirector:getChildByPath(bgDi, "img_Icon")

    local Button_buy = TFDirector:getChildByPath(bgDi, "Button_buy")
    local Image_exchange = TFDirector:getChildByPath(Button_buy, "Image_exchange")
    local Label_price = TFDirector:getChildByPath(Button_buy, "Label_price")
    local lab_buy = TFDirector:getChildByPath(Button_buy, "lab_buy")
    local lab_buyAgain = TFDirector:getChildByPath(Button_buy, "lab_buyAgain")

    local Image_fundView_1 = TFDirector:getChildByPath(bgDi, "Image_fundView_1")
    local img_nowGet = TFDirector:getChildByPath(Image_fundView_1, "img_nowGet")
    local lab_nowGet = TFDirector:getChildByPath(Image_fundView_1, "lab_nowGet")

    local Image_fundView_2 = TFDirector:getChildByPath(bgDi, "Image_fundView_2")
    local img_dayGet = TFDirector:getChildByPath(Image_fundView_2, "img_dayGet")
    local lab_dayGet = TFDirector:getChildByPath(Image_fundView_2, "lab_dayGet")

    local Button_get = TFDirector:getChildByPath(bgDi, "Button_get")
    local img_btnGet = TFDirector:getChildByPath(Button_get, "img_btnGet")
    local lab_getNum = TFDirector:getChildByPath(Button_get, "lab_getNum")

    local lab_keepDays = TFDirector:getChildByPath(bgDi, "lab_keepDays")

    Button_get:setVisible(false)

    if data.serverData then
        Button_get:setVisible(not data.serverData.todayAward)
        lab_lastDays:setText(data.serverData.restDays)
    else
        lab_lastDays:setText(0)
    end
    lab_buy:setVisible(not data.serverData)
    lab_buyAgain:setVisible(not lab_buy:isVisible())

    local goodsCfg2 = GoodsDataMgr:getItemCfg(data.reward[1][1])
    img_dayGet:setTexture(goodsCfg2.icon)
    img_dayGet:setSize(ccs(30,28))
    lab_dayGet:setText("x"..data.reward[1][2])
    img_btnGet:setTexture(img_dayGet:getTexture())
    img_btnGet:setSize(ccs(50,50))
    lab_getNum:setText(lab_dayGet:getText())

    local format_reward = {}
    for i, v in ipairs(data.reward) do
        table.insert( format_reward, {id = v[1],num = v[2]})
    end
    img_Icon:setTexture(data.titleIcon)
    img_Icon:setContentSize(ccs(147,102))
    img_Icon:setTouchEnabled(true)
    img_Icon:onClick(function()
        Utils:previewReward(nil,format_reward,0.5)
    end)

    Button_get:onClick(function()
        RechargeDataMgr:SendGrowFundRward(data.id)
    end)
    
    local fundCfg = RechargeDataMgr:getOneRechargeCfg(data.investMoneyID) 
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
end

return FundGrowView