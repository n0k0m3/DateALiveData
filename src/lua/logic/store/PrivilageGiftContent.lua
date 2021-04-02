--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

local PrivilageGiftContent = class("PrivilageGiftContent", BaseLayer)

function PrivilageGiftContent:ctor(cfg)
	self.super.ctor(self)
    self:initData(cfg)
    self:init("lua.uiconfig.supplyNew.privilegeGiftContent")
end

function PrivilageGiftContent:initData(cfg)

	self:showPopAnim(true)
	self.cfg = cfg or {}
end

function PrivilageGiftContent:initUI(ui)
	self.super.initUI(self, ui)

	self.closeBtn = TFDirector:getChildByPath(ui, "Button_close")
	self.closeBtn:onClick(function()
		AlertManager:closeLayer(self)
	end)
	self.name = TFDirector:getChildByPath(ui, "Label_name")
	self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
	self.list = UIListView:create( TFDirector:getChildByPath(ui, "list"))
	self.list:setItemsMargin(5)

	self.Label_limit = TFDirector:getChildByPath(ui, "Label_limit")
	local str = string.format(self.cfg.des1, self.cfg.buyCount - RechargeDataMgr:getBuyCount(self.cfg.rechargeCfg.id))
	self.Label_limit:setText(str)
	self.Label_desc = TFDirector:getChildByPath(ui, "Label_desc")
	self.Label_desc:setText(self.cfg.des2)

	self.btn_buy = TFDirector:getChildByPath(ui, "btn_buy")
	self.btn_buy:onClick(function()
		local args = {
            tittle = 2107025,
            reType = "buymonthCardgift",
            content = TextDataMgr:getText(1605014),
            confirmCall = function ( ... )
				RechargeDataMgr:getOrderNO(self.cfg.rechargeCfg.id)
            end,
        }
        Utils:showReConfirm(args)
	end)

	self.btn_buy.price = TFDirector:getChildByPath(self.btn_buy, "price")

	self:initView()
	
	EventMgr:addEventListener(self,EV_RECHARGE_UPDATE,function()
		local str = string.format(self.cfg.des1, self.cfg.buyCount - RechargeDataMgr:getBuyCount(self.cfg.rechargeCfg.id))
		self.Label_limit:setText(str)
	end);
end

function PrivilageGiftContent:initView()
	self.list:removeAllItems()
	local items = self.cfg.item or {}
	self.list:AsyncUpdateItem(items, function ( ... )
		-- body
        local prefab = self.Panel_prefab:clone()
        prefab:show()
        return prefab
      
	end, function ( prefab, data )
		-- body
		local itemCfg = GoodsDataMgr:getItemCfg(data.id)

        local name = TFDirector:getChildByPath(prefab, "name")
		name:setTextById(itemCfg.nameTextId)

        local content     = TFDirector:getChildByPath(prefab, "content")
        content:setText("X" ..data.num)

		local Panel_Item = TFDirector:getChildByPath(prefab, "Panel_Item")
		local Item = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone():Scale(0.75):Pos(0,0)
        PrefabDataMgr:setInfo(Item, data.id, 0)
		TFDirector:getChildByPath(Item, "Label_count"):hide()
		Panel_Item:addChild(Item)
	end)

	self.name:setText(self.cfg.name)

	self.btn_buy.price:setText("￥" .. self.cfg.rechargeCfg.price)
end


return PrivilageGiftContent

--endregion
