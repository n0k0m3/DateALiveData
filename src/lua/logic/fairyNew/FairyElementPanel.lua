local FairyElementPanel = class("FairyElementPanel" , BaseLayer)

function FairyElementPanel:ctor()
	self.super.ctor(self)
	self:showPopAnim(true)
	self:init("lua.uiconfig.fairyNew.fairyElementPanel")
end

function FairyElementPanel:initUI(ui)
	self.super.initUI(self ,ui)

	self.ui = ui

	self.btn_close = TFDirector:getChildByPath(ui , "Button_close")
	self.btn_close:onClick(function( ... )
		AlertManager:closeLayer(self)
	end)

	self.btn_confirm = TFDirector:getChildByPath(ui , "Button_ready")
	self.btn_confirm:onClick(function( ... )
		AlertManager:closeLayer(self)
	end)

	self.Label_des = Label:create()
	self.Label_des:setFontName("font/MFLiHei_Noncommercial.ttf")
	self.Label_des:setTextById(190000063)
	self.Label_des:setFontSize(22)
	self.Label_des:setAnchorPoint(ccp(0 , 0.5))
	self.Label_des:setPosition(-347 , -180)
	self.ui:getChildByName("img_bg"):addChild(self.Label_des)
	self.Label_des:setFontColor(ccc3(0,0,0))

end


return FairyElementPanel