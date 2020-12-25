--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

local CreateComfirm = class("CreateComfirm", BaseLayer)
function CreateComfirm:ctor(...)
	self.super.ctor(self)
	self:initData(...)
	self:init('lua.uiconfig.activity.CreateComfirm')
	self:show()
end

function CreateComfirm:initData(giftId, giftData, activityInfo)
	self.isShow = true

	self.giftId = giftId
	self.giftData = giftData
	self.activityInfo = activityInfo
end

function CreateComfirm:show()
	self:runAction(Sequence:create({ScaleTo:create(0.05,1.1), ScaleTo:create(0.05,1)}))
end

function CreateComfirm:registerEvents()
	EventMgr:addEventListener(self, EV_GROUP_PURCHASE_CREATE, handler(self.onCreateSuccess, self))
end

function CreateComfirm:initUI(ui)
	self.super.initUI(self, ui)

	self._ui.Button_close:onClick(function()
		self:Close()
	end)
	self._ui.Button_confirm:onClick(function()
		local isEnough, notEnoughItem = RechargeDataMgr:currencyIsEnough(self.giftData.exchangeCost)
		if not isEnough then
			Utils:showAccess(notEnoughItem.id)
			return;
		end
		TFDirector:send(c2s.RECHARGE_REQ_CREATE_GROUP_TEAM, {self.giftId, self.isShow})
	end)
	self._ui.Button_cancel:onClick(function()
		self:Close()
	end)
	self._ui.TextArea_alert_info:setText()

	self._ui.selected:setVisible(self.isShow)
	self._ui.unselected:setVisible(true)

	self._ui.showInHall:setTouchEnabled(true)
	self._ui.showInHall:addMEListener(TFWIDGET_CLICK, function()
		self.isShow = not self.isShow
		self._ui.selected:setVisible(self.isShow)
		self._ui.unselected:setVisible(true)
	end)

	local rstr = TextDataMgr:getTextAttr(14300298)
    local content = string.format(rstr.text, self.giftData.exchangeCost[1].num, TabDataMgr:getData("Item", self.giftData.exchangeCost[1].id).icon)
	local str = string.format([[<font face="fangzheng_zhunyuan26" color="#C0C8D0">%s</font>]], content)
	local rich = TFRichText:create(ccs(500, 160))
    rich:Text(str)
	self._ui.TextArea_alert_info:Add(rich)
end

function CreateComfirm:onCreateSuccess(data)
	EventMgr:dispatchEvent(EV_GROUP_PURCHASE_OPEN_PANEL, {type =EC_GroupOpenPanel.Room, giftId = self.giftId})
	self:Close()
end

function CreateComfirm:Close()
	self:runAction(Sequence:create({ScaleTo:create(0.05,1.1), ScaleTo:create(0.1,1), CallFunc:create(function()
		EventMgr:dispatchEvent(EV_GROUP_PURCHASE_CLOSE_PANEL, {target = self})
	end)}))	
end

return CreateComfirm

--endregion
