--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local FubenMonsterTrialBuffDetail = class("FubenMonsterTrialBuffDetail", BaseLayer)

function FubenMonsterTrialBuffDetail:ctor(data,descId,iconScale)
	self.super.ctor(self)
	self:showPopAnim(true)
	self:initData(data,descId,iconScale)
	self:init("lua.uiconfig.fuben.fubenMonsterTrialBuffDetail")
end

function FubenMonsterTrialBuffDetail:initData(data,descId,iconScale)
	self.config = data
	self.descId = descId
	self.iconScale = iconScale or 1.5
end


function FubenMonsterTrialBuffDetail:initUI(ui)
	self.super.initUI(self, ui)
	self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
	self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")
	self.Button_close:onClick(function()
		AlertManager:closeLayer(self)
	end)

	self.Image_buff_bg = TFDirector:getChildByPath(self.Panel_root, "Image_buff_bg")

	self.buffIcon = TFDirector:getChildByPath(self.Panel_root, "buffIcon")
	self.buffIcon:setTexture(self.config.icon)
	self.buffIcon:setScale(self.iconScale)

	self.Label_desc = TFDirector:getChildByPath(self.Panel_root, "Label_desc")
	if not self.descId then
		local ext = TabDataMgr:getData("String", 15010031)
		self.Label_desc:setText(self.config.stringId ..", ".. ext.text)
	else
		self.Label_desc:setTextById(self.descId)
	end

end



return FubenMonsterTrialBuffDetail
--endregion
