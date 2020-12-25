
local BuyResourceView = class("BuyResourceView", BaseLayer)

function BuyResourceView:initData(itemId)
    self.itemId_ = itemId
    self.itemCfg_ = GoodsDataMgr:getItemCfg(itemId)
    self.itemRecoverCfg_ = StoreDataMgr:getItemRecoverCfg(self.itemCfg_.buyItemRecover)
    self.prices = clone(self.itemRecoverCfg_.price)

    local isHavePrivilege, cfg = RechargeDataMgr:getIsHavePrivilegeByType(104)

    self.discountNum = 0
    local _cfg = StoreDataMgr:getItemRecoverInfo(self.itemCfg_.buyItemRecover)
    if _cfg then
        self.discountNum = _cfg.discountNum or 0
    end 
    local buyCount = StoreDataMgr:getItemRecoverBuyCount(self.itemCfg_.buyItemRecover)
    if itemId == cfg.privilege.itemId and isHavePrivilege  then
        for i = 1, cfg.privilege.chance do
            table.insert(self.prices, buyCount + cfg.privilege.chance, self.prices[1])
        end
    end
end

function BuyResourceView:ctor(...) 
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.common.buyResourceView")
end

function BuyResourceView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    local Image_bg = TFDirector:getChildByPath(self.Panel_root, "Image_bg")
    self.Button_close = TFDirector:getChildByPath(Image_bg, "Button_close")
    self.Button_ok = TFDirector:getChildByPath(Image_bg, "Button_ok")
    self.Label_ok = TFDirector:getChildByPath(self.Button_ok, "Label_ok")
    self.Label_title = TFDirector:getChildByPath(Image_bg, "Label_title")
    self.Label_remainCount = TFDirector:getChildByPath(Image_bg, "Label_remainCount")
    self.Label_tips = TFDirector:getChildByPath(Image_bg, "Label_tips")

    self.Image_costIcon = TFDirector:getChildByPath(Image_bg, "Image_costIcon")
    self.Label_costNum = TFDirector:getChildByPath(self.Image_costIcon, "Label_costNum")
    self.Image_targetIcon = TFDirector:getChildByPath(Image_bg, "Image_targetIcon")
    self.Label_targetNum = TFDirector:getChildByPath(self.Image_targetIcon, "Label_targetNum")
    self.Label_targetItemDesc = TFDirector:getChildByPath(Image_bg, "Label_targetItemDesc")
    self:refreshView()
end

function BuyResourceView:refreshView()
    self.Label_title:setTextById(800020)
    local name = TextDataMgr:getText(self.itemCfg_.nameTextId)
    
    local buyCount = StoreDataMgr:getItemRecoverBuyCount(self.itemCfg_.buyItemRecover) + self.discountNum
    local remainCount = math.max(0, #self.prices - buyCount)
    self.Label_tips:setTextById("r30001", name, remainCount)

    self.cost = self.prices[buyCount + 1][1]
    local costCfg = GoodsDataMgr:getItemCfg(self.cost[1].id)
    local Panel_goodsItem= PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    PrefabDataMgr:setInfo(Panel_goodsItem, self.cost[1].id)
    Panel_goodsItem:setPosition(ccp(0,0))
    Panel_goodsItem:setScale(0.8)
    self.Image_costIcon:addChild(Panel_goodsItem)
    self.Label_costNum:setText(self.cost[1].num)

    --兑换物
    local targetItem= PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    PrefabDataMgr:setInfo(targetItem, self.itemId_)
    targetItem:setPosition(ccp(0,0))
    targetItem:setScale(0.8)
    self.Image_targetIcon:addChild(targetItem)
    self.Label_targetNum:setText(self.cost.targetNum)

    --描述
    self.Label_targetItemDesc:setTextById(self.itemCfg_.desTextId)
end

function BuyResourceView:registerEvents()
    EventMgr:addEventListener(self, EV_STORE_BUYRESOURCE, handler(self.onBuyResourceEvent, self))

    self.Button_close:onClick(
        function()
			print("self.Button_close:onClick")
            AlertManager:closeLayer(self)
        end, EC_BTN.CLOSE)

    self.Button_ok:onClick(function()
            local count = GoodsDataMgr:getItemCount(self.itemId_)
            if count < self.itemCfg_.totalMax then
                StoreDataMgr:send_PLAYER_REQ_BUY_RESOURCES(self.itemCfg_.buyItemRecover)
            else
                Utils:showTips(800024)
            end
    end)
end

function BuyResourceView:onBuyResourceEvent()
    Utils:showReward({{id = self.itemRecoverCfg_.item_id, num = self.cost.targetNum}})
    AlertManager:closeLayer(self)
end

return BuyResourceView
