--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

local SnowCastleUpgradeComfirm = class("SnowCastleUpgradeComfirm", BaseLayer)
function SnowCastleUpgradeComfirm:ctor(...)
	self.super.ctor(self)

	self:showPopAnim(true)

	self:initData(...)

	self:init("lua.uiconfig.activity.snowCastleUpgradeComfirm")
end

function SnowCastleUpgradeComfirm:initUI(ui)
	self.super.initUI(self, ui)
	TFDirector:getChildByPath(ui,"Button_close"):onClick(function() AlertManager:closeLayer(self) end)
	TFDirector:getChildByPath(ui,"Image_content"):setTouchEnabled(true)
	TFDirector:getChildByPath(ui,"Image_content"):setSwallowTouch(true)
	
	local text = TextDataMgr:getText(self.cfg.optionTitle)
	local rich = TFRichText:create(ccs(500, 160))
	local str = string.format([[<font face="fangzheng_zhunyuan26" color="#1d4371">%s</font>]],text)
	rich:Text(str)
	local Label_proj_Name = TFDirector:getChildByPath(ui,"Label_proj_Name")
	Label_proj_Name:setText("")
	Label_proj_Name:addChild(rich)

	TFDirector:getChildByPath(ui,"Label_Descript"):setTextById(self.cfg.optionDes)
	TFDirector:getChildByPath(ui,"Button_Comfirm"):onClick(function(widget)
		--todo:send
		print("send",self.optionId)
		ActivityDataMgr2:sendSnowBookUpgrade(self.optionId)	
		widget:setTouchEnabled(false)	
	end)
	TFDirector:getChildByPath(ui,"Button_Cancel"):onClick(function()
		AlertManager:closeLayer(self)
	end)
end

function SnowCastleUpgradeComfirm:initData(optionId)
	print("optionId",optionId)
	self.optionId = optionId
	self.cfg = TabDataMgr:getData("EventMemshipOption", optionId)
	
end

function SnowCastleUpgradeComfirm:registerEvents()
	self.super.registerEvents(self)

	EventMgr:addEventListener(self, EV_ICE_SNOW_UPGRADE, handler(self.upgradeSucess, self))
end

function SnowCastleUpgradeComfirm:upgradeSucess()
--	local path = "lua.logic.activity.SnowDay.SnowCastleUpgradeSuccess"
--	TFDirector:unRequire(path);
--	local view = require(path):new(self.optionId)
--	view:setAnchorPoint(ccp(0.5,0.50))
--	self:addChild(view,9999)
	AlertManager:closeLayer(self)
	--Utils:openView("activity.SnowDay.SnowCastleUpgradeSuccess",self.optionId)
end


return SnowCastleUpgradeComfirm

--endregion
