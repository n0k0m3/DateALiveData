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
*  新版购买体力界面
* 
]]

local BuyTiliLayer = class("BuyTiliLayer", BaseLayer)

function BuyTiliLayer:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.common.buyTiliLayer")
end

function BuyTiliLayer:initData(itemId)
    self.itemId_ = itemId
    self.itemCfg_ = GoodsDataMgr:getItemCfg(itemId)
    self.itemRecoverCfg_ = StoreDataMgr:getItemRecoverCfg(self.itemCfg_.buyItemRecover)

    self.prices = clone(self.itemRecoverCfg_.price)
    -- 特权
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

    --可使用的体力道具
    self.useItems = Utils:getKVP(1111, "previewItem")
end

function BuyTiliLayer:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    local Image_bg = TFDirector:getChildByPath(self.Panel_root, "Image_bg")
    self.Button_close = TFDirector:getChildByPath(Image_bg, "Button_close")
    self.Button_ok = TFDirector:getChildByPath(Image_bg, "Button_ok")
    self.Label_ok = TFDirector:getChildByPath(self.Button_ok, "Label_ok")
    self.Label_title = TFDirector:getChildByPath(Image_bg, "Label_title")
    self.Label_tips = TFDirector:getChildByPath(Image_bg, "Label_tips")

    self.Image_costIcon = TFDirector:getChildByPath(Image_bg, "Image_costIcon")
    self.Label_costNum = TFDirector:getChildByPath(self.Image_costIcon, "Label_costNum")
    self.Image_targetIcon = TFDirector:getChildByPath(Image_bg, "Image_targetIcon")
    self.Label_targetNum = TFDirector:getChildByPath(self.Image_targetIcon, "Label_targetNum")

    self.img_item1 = TFDirector:getChildByPath(Image_bg, "img_item1")
    self.txt_num1 = TFDirector:getChildByPath(self.img_item1, "txt_num")
    self.btn_use1 = TFDirector:getChildByPath(self.img_item1, "btn_use")
    self.img_item2 = TFDirector:getChildByPath(Image_bg, "img_item2")
    self.txt_num2 = TFDirector:getChildByPath(self.img_item2, "txt_num")
    self.btn_use2 = TFDirector:getChildByPath(self.img_item2, "btn_use")

    self:updateUI()
end

function BuyTiliLayer:updateUI()
	self.Label_title:setTextById(800020)
    local name = TextDataMgr:getText(self.itemCfg_.nameTextId)
    
    local buyCount = StoreDataMgr:getItemRecoverBuyCount(self.itemCfg_.buyItemRecover) + self.discountNum
    local remainCount = math.max(0, #self.prices - buyCount)
    self.Label_tips:setTextById("r304006", name, remainCount)

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

    local Panel_goodsItem= PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    PrefabDataMgr:setInfo(Panel_goodsItem, self.useItems[1])
    Panel_goodsItem:setPosition(ccp(0,0))
    Panel_goodsItem:setScale(0.8)
    self.img_item1:addChild(Panel_goodsItem)

    local Panel_goodsItem= PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    PrefabDataMgr:setInfo(Panel_goodsItem, self.useItems[2])
    Panel_goodsItem:setPosition(ccp(0,0))
    Panel_goodsItem:setScale(0.8)
    self.img_item2:addChild(Panel_goodsItem)

    self:updateUseItems()
end

function BuyTiliLayer:updateUseItems()
	local num = GoodsDataMgr:getItemCount(self.useItems[1])
    self.txt_num1:setTextById(111000454, num)
    local isGray = false
    if num <= 0 then
    	isGray = true
    end
    self.btn_use1:setGrayEnabled(isGray)
    self.btn_use1:setTouchEnabled(not isGray)

    num = GoodsDataMgr:getItemCount(self.useItems[2])
    self.txt_num2:setTextById(111000454, num)

    local isGray = false
    if num <= 0 then
    	isGray = true
    end
    self.btn_use2:setGrayEnabled(isGray)
    self.btn_use2:setTouchEnabled(not isGray)
end

function BuyTiliLayer:registerEvents()
    EventMgr:addEventListener(self, EV_STORE_BUYRESOURCE, handler(self.onBuyResourceEvent, self))
    EventMgr:addEventListener(self, EV_BAG_USE_ITEM, handler(self.onUseItemEvent, self))

    self.Button_close:onClick(
        function()
            AlertManager:closeLayer(self)
        end, EC_BTN.CLOSE
    )

    self.Button_ok:onClick(function()
        local count = GoodsDataMgr:getItemCount(self.itemId_)
        if count < self.itemCfg_.totalMax then
            StoreDataMgr:send_PLAYER_REQ_BUY_RESOURCES(self.itemCfg_.buyItemRecover)
        else
            Utils:showTips(800024)
        end
    end)

    local useItemByCid = function(cid)
    	local item = GoodsDataMgr:getItem(cid)
    	local realId = ""
    	for k, v in pairs(item or {}) do
    		if v.id and v.id ~= "" then
    			realId = v.id
    			break
    		end
    	end
    	if realId == "" then
    		return
    	end
        GoodsDataMgr:useItem({{realId, 1}})
   	end

    self.btn_use1:onClick(function()
        useItemByCid(self.useItems[1])
    end)

    self.btn_use2:onClick(function()
        useItemByCid(self.useItems[2])
    end)
end

function BuyTiliLayer:onUseItemEvent(reward,isSkyLadderCardBag)
    self:updateUseItems()
    if next(reward) then
        Utils:showReward(reward)
    end
end

function BuyTiliLayer:onBuyResourceEvent()
    Utils:showReward({{id = self.itemRecoverCfg_.item_id, num = self.cost.targetNum}})
    AlertManager:closeLayer(self)
end

return BuyTiliLayer
