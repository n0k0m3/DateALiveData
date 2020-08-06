local CleanUpView = class("CleanUpView", BaseLayer)


function CleanUpView:ctor()
    self.super.ctor(self)
    self:init("lua.uiconfig.loginScene.cleanUpView")
end


function CleanUpView:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	self.Button_close = TFDirector:getChildByPath(self.ui,"Button_close")
	self.Button_cancle = TFDirector:getChildByPath(self.ui,"Button_cancle")
	self.Button_ok = TFDirector:getChildByPath(self.ui,"Button_ok")
	self:showPopAnim(true)
	self.ui:setTouchEnabled(true)
end

function CleanUpView:registerEvents()

	self.Button_close:onClick(function()
		self:getParent():removeLayer(self,true)
        --AlertManager:closeLayer(self)
    end)

	self.Button_cancle:onClick(function()
		self:getParent():removeLayer(self,true)
        --AlertManager:closeLayer(self)
    end)

	self.Button_ok:onClick(function()
        CommonManager:autoFixRes()
    end)

end

return CleanUpView
