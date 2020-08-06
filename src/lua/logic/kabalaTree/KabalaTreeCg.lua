local KabalaTreeCg = class("KabalaTreeCg",BaseLayer)

function KabalaTreeCg:ctor(callback)
	self.super.ctor(self)
	self.callback = callback
	self:init("lua.uiconfig.kabalaTree.kabalaTreeCg")
end

function KabalaTreeCg:initUI(ui)
	self.super.initUI(self,ui)
	self.root_panel = ui:getChildByName("Panel_root")
	self.curtainTop = self.root_panel:getChildByName("Image_bg_top")
    self.curtainBottom = self.root_panel:getChildByName("Image_bg_bottom")
    self.curtainTop:setPosition(me.p(0,840))
    self.curtainBottom:setPosition(me.p(0,-200))
    self.root_panel:setVisible(true)
    self.curtainTop:runAction(MoveTo:create(1,me.p(0,740)))
    self.curtainBottom:runAction(Sequence:create({MoveTo:create(1,me.p(0,-100)),CallFunc:create(function()
    	if self.callback then
    		self.callback()
    	end
    end)}))
    
end

function KabalaTreeCg:registerEvents()
	EventMgr:addEventListener(self, EV_CG_END, handler(self.curtainEvtHandle, self))
end

function KabalaTreeCg:curtainEvtHandle(callback)
	self.curtainTop:setPosition(me.p(0,740))
    self.curtainBottom:setPosition(me.p(0,-100))
    self.root_panel:setVisible(true)
    self.curtainTop:runAction(MoveTo:create(1,me.p(0,840)))
    self.curtainBottom:runAction(Sequence:create({MoveTo:create(1,me.p(0,-200)),CallFunc:create(function()
        if callback then
        	callback()
        end
        AlertManager:closeLayer(self)
    end)}))
end
return KabalaTreeCg