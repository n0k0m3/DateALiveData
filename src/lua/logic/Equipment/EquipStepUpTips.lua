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
* 质点突破返还材料提示
* 
]]

local EquipStepUpTips = class("EquipStepUpTips", BaseLayer)

function EquipStepUpTips:ctor(data)
    self.super.ctor(self, data)
    self.data = data
    self.itemMargin = 10
    self:showPopAnim(true)
    self:init("lua.uiconfig.Equip.EquipStepUpTips")
end

function EquipStepUpTips:initUI(ui)
	self.super.initUI(self, ui)

	self.txt_title = TFDirector:getChildByPath(self.ui, "txt_title")
	self.txt_tip = TFDirector:getChildByPath(self.ui, "txt_tip")
	self.txt_title:setTextById(111000083)
	self.txt_tip:setTextById(111000084)

	local scrollView_items = TFDirector:getChildByPath(self.ui, "scrollView_items")

    self.scrollView_items = TFDirector:getChildByPath(self.ui, "scrollView_items")

    self.Button_ok = TFDirector:getChildByPath(self.ui, "Button_ok")
    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")

    self:updateList()
end

function EquipStepUpTips:updateList()
	local items = self.data.items or {}
	local itemCount = table.count(items)
	local goodsItem_prefab = PrefabDataMgr:getPrefab("Panel_goodsItem")
    local twidth = itemCount * (goodsItem_prefab:getSize().width + self.itemMargin)
    if twidth < self.scrollView_items:getSize().width then
        self.scrollView_items:setContentSize(CCSize(twidth, self.scrollView_items:getSize().height))
    end

    self.itemListView = UIListView:create(self.scrollView_items)
    self.itemListView:setItemsMargin(self.itemMargin)

	self.itemListView:removeAllItems()
	for k, v in pairs(self.data.items or {}) do
		local Panel_goodsItem = goodsItem_prefab:clone()
        PrefabDataMgr:setInfo(Panel_goodsItem, v.id, v.num)
        self.itemListView:pushBackCustomItem(Panel_goodsItem)
	end
end

function EquipStepUpTips:onRspStepEquip()
	AlertManager:closeLayer(self)
end

function EquipStepUpTips:registerEvents()
	EventMgr:addEventListener(self, EV_EQUIP_STEP_UP, handler(self.onRspStepEquip, self))

	self.Button_close:onClick(function()
    	AlertManager:closeLayer(self)
    end)

    self.Button_ok:onClick(function()
    	if not self.data then return end
    	EquipmentDataMgr:sendReqStepEquip(self.data.equipId, self.data.costEquipId)
    end)
end

return EquipStepUpTips
