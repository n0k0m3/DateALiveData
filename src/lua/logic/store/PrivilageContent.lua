--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local PrivilageContent = class("PrivilageContent", BaseLayer)

function PrivilageContent:ctor(cardType)
	self.super.ctor(self)
	self:showPopAnim(true)
	self:initData(cardType)

	self:init("lua.uiconfig.supplyNew.privilegeContent")
end

function PrivilageContent:initUI(ui)
	self.super.initUI(self, ui)

	self.closeBtn = TFDirector:getChildByPath(ui, "Button_close")
	self.closeBtn:onClick(function()
		AlertManager:closeLayer(self)
	end)
	self.name = TFDirector:getChildByPath(ui, "Label_name")
	self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
	self.list = UIListView:create( TFDirector:getChildByPath(ui, "list"))
	self.list:setItemsMargin(5)
	
	self:initView()
end

function PrivilageContent:initData(cardType)
	self.nameTextId = nil
	if cardType == EC_CardPrivilege.Month then
		self.nameTextId = 15010197
	else
		self.nameTextId = 15010198
	end	
	self.cfgs = RechargeDataMgr:getCardPrivilegeByType(cardType)
end

function PrivilageContent:initView()
	self.list:removeAllItems()

	local tag = TextDataMgr:getText(1454038)

	local cfgs = self.cfgs
    for i = 1, #cfgs do
        local item = self.Panel_prefab:clone()
        item:show()
        local name = TFDirector:getChildByPath(item, "name")
        local lab_desc     = TFDirector:getChildByPath(item, "content")
        lab_desc:setTextById(cfgs[i].describe)

        name:setText(tag.. " "..i)
        self.list:pushBackCustomItem(item)
    end

	self.name:setTextById(self.nameTextId)
end

return PrivilageContent


--endregion
