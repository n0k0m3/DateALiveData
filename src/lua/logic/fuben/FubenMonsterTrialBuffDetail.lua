--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local FubenMonsterTrialBuffDetail = class("FubenMonsterTrialBuffDetail", BaseLayer)

function FubenMonsterTrialBuffDetail:ctor(...)
	self.super.ctor(self)
	self:showPopAnim(true)
	self:initData(...)
	self:init("lua.uiconfig.fuben.fubenMonsterTrialBuffDetail")
end

function FubenMonsterTrialBuffDetail:initData(data)
	self.config = data
end


function FubenMonsterTrialBuffDetail:initUI(ui)
	self.super.initUI(self, ui)
	self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
	self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")
	self.Button_close:onClick(function()
		AlertManager:closeLayer(self)
	end)

	self.buffIcon = TFDirector:getChildByPath(self.Panel_root, "buffIcon")
	self.buffIcon:setTexture(self.config.icon)
	self.buffIcon:setScale(1.5)

	self.Label_desc = TFDirector:getChildByPath(self.Panel_root, "Label_desc")
	local ext = TabDataMgr:getData("String", 15010031)
	self.Label_desc:setText(self.config.stringId ..", ".. ext.text)
end



return FubenMonsterTrialBuffDetail
--endregion
