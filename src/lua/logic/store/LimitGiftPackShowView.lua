local LimitGiftPackShowView = class("LimitGiftPackShowView", BaseLayer)

function LimitGiftPackShowView:initDta()
    self.data = RechargeDataMgr:getPushGift()
    RechargeDataMgr:resetPushGift()
end

function LimitGiftPackShowView:ctor(...)
    self.super.ctor(self)
    self:initDta(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.recharge.LimitGiftPackShowView")
end

function LimitGiftPackShowView:initUI(ui)
    self.super.initUI(self,ui) 

    self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
    self.Label_name = TFDirector:getChildByPath(ui,"Label_name")
    self.Label_time = TFDirector:getChildByPath(ui,"Label_time")
    self.Label_price = TFDirector:getChildByPath(ui,"Label_price")
    self.Button_buy = TFDirector:getChildByPath(ui,"Button_buy")
    self.Label_buy = TFDirector:getChildByPath(ui,"Label_buy")
    self.Panel_gifts = TFDirector:getChildByPath(ui,"Panel_gifts")
    self.Image_exchange_org = TFDirector:getChildByPath(ui,"Image_exchange_org"):hide()
    self.Image_exchange = TFDirector:getChildByPath(ui,"Image_exchange"):hide()

    self:refresView()
end

function LimitGiftPackShowView:refresView()
    self.Label_name:setText(self.data.name)
    self.Label_buy:setString("￥ "..self.data.rechargeCfg.price)
    local serverTime = ServerDataMgr:getServerTime()
    local str = ""
    if self.data.triggerEndDate - serverTime > 0 then
        local day, hour, min = Utils:getFuzzyDHMS(self.data.triggerEndDate - serverTime, true)
        str = TextDataMgr:getText(100000074,day, hour, min)
    end
    self.Label_time:setText(str)

    if self.data.buyType == 1 then
        self.Label_price:setString(self.data.originalPrice)
        local exchangeCfg = GoodsDataMgr:getItemCfg(self.data.exchangeCost[1].id)
        self.Image_exchange_org:setTexture(exchangeCfg.icon)
        self.Image_exchange_org:setSize(CCSizeMake(40,40))
        self.Image_exchange_org:show()
        self.Label_price:setPositionX(self.Label_price:getPositionX())
        self.Image_exchange:show()
        self.Image_exchange:setTexture(exchangeCfg.icon)
        self.Image_exchange:setSize(CCSizeMake(45,45))
        self.Label_buy:setString(self.data.exchangeCost[1].num)
    else
        self.Label_price:setString("￥ "..self.data.originalPrice)
    end

    local items = self.data.item
    if #items > 0 then
        for i, v in ipairs(items) do
            local goodItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            PrefabDataMgr:setInfo(goodItem, v.id, v.num)
            self.Panel_gifts:addChild(goodItem)
            goodItem:setPosition(ccp(-55 + (3 - #items) * 50 + i * 115, 55))
        end
    end
end

function LimitGiftPackShowView:payOverBack()
    AlertManager:closeLayer(self)
end

function LimitGiftPackShowView:registerEvents()
    EventMgr:addEventListener(self,EV_RECHARGE_UPDATE,handler(self.payOverBack, self))

    self.Button_buy:onClick(function()
        RechargeDataMgr:getOrderNO(self.data.rechargeCfg.id)
    end)

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return LimitGiftPackShowView