local ItemSellConfirmView = class("ItemSellConfirmView", BaseLayer)

function ItemSellConfirmView:ctor(sellitems, sellcallback)
    self.super.ctor(self)
    self:initData(sellitems, sellcallback)
    self:showPopAnim(true)
    self:init("lua.uiconfig.bag.itemSellConfirmView")
end

function ItemSellConfirmView:initData(sellitems, sellcallback)
    self.sellItems = sellitems or {}
    self.sellCallBack = sellcallback
    self.itemMargin = 10
end

function ItemSellConfirmView:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui

    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_cancel")
    self.Button_ok = TFDirector:getChildByPath(self.ui, "Button_ok")

    self.scrollview = TFDirector:getChildByPath(self.ui, "ScrollView_recieve")

    StoreDataMgr:send_STORE_SELL_GOODS_PREVIEW(self.sellItems)
end

function ItemSellConfirmView:registerEvents()
    EventMgr:addEventListener(self, EV_BAG_SELL_PREVIEW, handler(self.onSellPreviewwEvent, self))

    self.Button_close:onClick(
            function()
                AlertManager:closeLayer(self)
            end, EC_BTN.CLOSE)

    self.Button_ok:onClick(function()
        if self.sellCallBack then
            self.sellCallBack()
        end
        AlertManager:closeLayer(self)
    end)
end

function ItemSellConfirmView:onSellPreviewwEvent(previews)
    previews = previews or {}
    local goodsItem_prefab = PrefabDataMgr:getPrefab("Panel_goodsItem")
    local itemCount = table.count(previews)
    local twidth = itemCount * (goodsItem_prefab:getSize().width + self.itemMargin)
    if twidth < self.scrollview:getSize().width then
        self.scrollview:setContentSize(CCSize(twidth, self.scrollview:getSize().height))
    end

    local ListView_item = UIListView:create(self.scrollview)
    ListView_item:setItemsMargin(self.itemMargin)
    ListView_item:setItemModel(goodsItem_prefab)
    for i, v in ipairs(previews) do
        local item = goodsItem_prefab:clone()
        PrefabDataMgr:setInfo(item, v.id, v.num)
        ListView_item:pushBackCustomItem(item)
    end
end

return ItemSellConfirmView