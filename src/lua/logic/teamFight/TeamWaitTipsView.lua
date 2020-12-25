TeamWaitTipsView = class("TeamWaitTipsView",BaseLayer)

function TeamWaitTipsView:ctor(...)
	self.super.ctor(self)
	self:showPopAnim(true)
    self:initData(...)
    self:init("lua.uiconfig.teamFight.waitTipsView")
end

function TeamWaitTipsView:initData(data)
	self.tipsData = data
end

function TeamWaitTipsView:initUI(ui)
	self.super.initUI(self, ui)
	local root_panel= TFDirector:getChildByPath(ui,"Panel_root")
    self.Panel_wait_leader = TFDirector:getChildByPath(root_panel, "Panel_wait_leader")
    self.Panel_wait_over = TFDirector:getChildByPath(root_panel, "Panel_wait_over")
    self.Panel_wait_out = TFDirector:getChildByPath(root_panel, "Panel_wait_out")


end

function TeamWaitTipsView:changeTipsData(data)
	self.tipsData = data
	
	self:refreshView()
end

function TeamWaitTipsView:refreshView()
	self.Panel_wait_leader:hide()
	self.Panel_wait_over:hide()
	self.Panel_wait_out:hide()
	if self.tipsData.tipsType == 1 then
		self.Panel_wait_leader:show()

	elseif self.tipsData.tipsType == 2 then
		self.Panel_wait_over:show()
	elseif self.tipsData.tipsType == 3 then
		self.Panel_wait_out:show()
	end
end

function TeamWaitTipsView:registerEvents()
	

end

return TeamWaitTipsView
