local CurtainLayer = class("CurtainLayer",BaseLayer)

function CurtainLayer:ctor(param)
	self.super.ctor(self)
	self.cfgData = param
	self:init("lua.uiconfig.battle.curtainLayer")
end

function CurtainLayer:initUI(ui)
	self.super.initUI(self,ui)
	self.root_panel = ui:getChildByName("Panel_root")
	self.curtainTop = self.root_panel:getChildByName("Image_bg_top")
    self.curtainBottom = self.root_panel:getChildByName("Image_bg_bottom")
    self.curtainTop:setPosition(me.p(0,840))
    self.curtainBottom:setPosition(me.p(0,-200))
    self.root_panel:setVisible(true)
    self.curtainTop:runAction(MoveTo:create(self.cfgData.duration or 1,me.p(0,740)))
    self.curtainBottom:runAction(Sequence:create({MoveTo:create(self.cfgData.duration or 1,me.p(0,-100)),CallFunc:create(function()
    	if self.cfgData.callback then
    		self.cfgData.callback()
    	end
    end)}))
    
    
end

function CurtainLayer:registerEvents()
	EventMgr:addEventListener(self, EV_BATTLE_CURTAIN, handler(self.curtainEvtHandle, self))
end

function CurtainLayer:curtainEvtHandle(param)
	if param.isShow == false then
		self.curtainTop:setPosition(me.p(0,740))
	    self.curtainBottom:setPosition(me.p(0,-100))
	    self.root_panel:setVisible(true)
	    self.curtainTop:runAction(MoveTo:create(param.duration or 1,me.p(0,840)))
	    self.curtainBottom:runAction(Sequence:create({MoveTo:create(param.duration or 1,me.p(0,-200)),CallFunc:create(function()
	        if param.callback then
	        	param.callback()
	        end
	        AlertManager:closeLayer(self)
	    end)}))
	end
end

return CurtainLayer