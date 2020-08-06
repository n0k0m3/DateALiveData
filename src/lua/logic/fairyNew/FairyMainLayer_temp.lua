local FairyMainLayer = class("FairyMainLayer", BaseLayer)


function FairyMainLayer:ctor(data)
    self.super.ctor(self,data)

    -- self:init("lua.uiconfig.fairyNew.fairyMain")
end

function FairyMainLayer:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	FairyMainLayer.ui = ui
end

function FairyMainLayer:registerEvents()
	
end

function FairyMainLayer:onHide()
	self.super.onHide(self)
end

function FairyMainLayer:removeUI()
	self.super.removeUI(self)
end

function FairyMainLayer:onShow()
	self.super.onShow(self)
end


return FairyMainLayer;
