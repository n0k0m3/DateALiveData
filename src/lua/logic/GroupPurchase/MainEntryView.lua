--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local MainEntryView = class("MainEntryView", BaseLayer)

local PanelOrder = {BuyHall = 100, CreatePanel = 200, Room = 300, InvitPanel = 400}

function MainEntryView:ctor(...)
	self.super.ctor(self, ...)

	self:initData(...)

	self:init("lua.uiconfig.activity.MainEntryView")

	
end

function MainEntryView:enterFittingRoom()	
	local FittingRoom = requireNew("lua.logic.GroupPurchase.FittingRoom")
	local model = FittingRoom:new(nil, self, self.activityInfo)
	self:addLayerToNode(model, self,300)
end


function MainEntryView:initData(activityId, isShowRoom)
	self.curGift = nil
	self.giftNodes = {}
	self.activityId = activityId
	self.isShowRoom = isShowRoom

	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)

	local extData = self.activityInfo.extendData
	self.rechargeId = extData.rechange
end

function MainEntryView:registerEvents()
	EventMgr:addEventListener(self, EV_GROUP_PURCHASE_GET, handler(self.onGetGift, self))
	EventMgr:addEventListener(self, EV_GROUP_PURCHASE_QUERY_GIFT, handler(self.onQueryGift, self))
	EventMgr:addEventListener(self, EV_GROUP_PURCHASE_OPEN_PANEL, handler(self.openPanel, self))
	EventMgr:addEventListener(self, EV_GROUP_PURCHASE_CLOSE_PANEL, handler(self.closePanel, self))

	self.Button_try:onClick(function()
		self:enterDressView()
	end)
	
	self._ui.Button_purchase:onClick(function()
		local PurchaseMainView = requireNew("lua.logic.GroupPurchase.PurchaseMainView")
		local model = PurchaseMainView:new(self.curGift.giftData)
		self:addLayerToNode(model, self, PanelOrder.BuyHall)
	end)

end

function MainEntryView:updateActivity()
	--EventMgr:addEventListener(self, EV_GROUP_PURCHASE_OPEN_PANEL, handler(self.openPanel, self))	
end

function MainEntryView:initUI(ui)
	self.super.initUI(self,ui)

	self.Button_try = TFDirector:getChildByPath(ui, "Button_try")
	self.Button_try.originX = self.Button_try:getPositionX()
	self.Button_purchase = TFDirector:getChildByPath(ui, "Button_purchase")
	self.Button_purchase.originX = self.Button_purchase:getPositionX()
	self.Button_purchase.coin = self.Button_purchase:getChildByName("coin")
	self.Button_purchase.price = self.Button_purchase:getChildByName("price")
	self.Button_check = TFDirector:getChildByPath(ui, "Button_check")
	self.Button_check:onClick(function()
		local data = self.curGift.giftData
		if data == nil then
			return
		end
		 Utils:showInfo(data["firstBuyItem"][1].id, nil, true)
	end)


	self.touchmask = TFDirector:getChildByPath(ui, "touchmask")
	self.help = TFDirector:getChildByPath(ui, "help")
	self.help:onClick(function()
		Utils:openView("common.HelpView",{3109})
	end)
	self.touchmask:setTouchEnabled(true)
	self.touchmask:setSwallowTouch(true)

	self:initGift()
	self:refreshView()
	self:queryGiftStatus()
end

function MainEntryView:queryGiftStatus()
	TFDirector:send(c2s.RECHARGE_REQ_GROUP_GIFT_INFO, {})
end

function MainEntryView:refreshView()
	self._ui.ActivityTime:setText(Utils:getActivityDateString(self.activityInfo.startTime, self.activityInfo.endTime, self.activityInfo.extendData.dateStyle))
end

function MainEntryView:addItem(parent,id)
	local goodItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    PrefabDataMgr:setInfo(goodItem, id)
	parent:addChild(goodItem)
	goodItem:setVisible(true)
	goodItem:setPosition(0,0)
	goodItem:setTouchEnabled(false)
	return goodItem
end

function MainEntryView:initGift()

	local giftNode = TFDirector:getChildByPath(self.ui, "giftNode")
	for i = 1,2 do
		local giftId = self.rechargeId[i]
		local giftData = RechargeDataMgr:getGiftSingleData(giftId)

		local giftNode = giftNode:getChildByName("gift"..i)	
		giftNode.selected = giftNode:getChildByName("selected")
		giftNode.finish = giftNode:getChildByName("finish")
		giftNode.itemPos = giftNode:getChildByName("itemPos")

		giftNode.touchmask = giftNode:getChildByName("touchmask")
		giftNode.touchmask:setTouchEnabled(true)
		giftNode.touchmask:setSwallowTouch(false)
		giftNode.touchmask:addMEListener(TFWIDGET_CLICK, function(sender)
			self:selectGift(giftNode)
		end)

		giftNode.canGet = giftNode:getChildByName("get")
		giftNode.canGet:setTouchEnabled(true)
		giftNode.canGet:onClick(function()
			local msg = {
				giftNode.giftId
			}
			TFDirector:send(c2s.RECHARGE_REQ_RECEIVE_GROUP_GIFT, msg)
		end)

		self:addItem(giftNode.itemPos, giftData["firstBuyItem"][1].id)

		giftNode.saleTag = giftNode:getChildByName("saleTag")
		if tonumber(giftData.tagDes) then 
			giftNode.discount = giftNode.saleTag:getChildByName("discountScale")
			giftNode.discount:setTextById(277004, tonumber(giftData.tagDes))
			giftNode.saleTag:setVisible(true)
		else
			giftNode.saleTag:setVisible(false)
		end

		giftNode.giftData = giftData
		giftNode.giftId = giftId
		giftNode.status = 0

		table.insert(self.giftNodes, giftNode)
	end
end

function MainEntryView:selectGift(sender)
	if self.curGift == sender then
		return;
	end
	if self.curGift then
		self.curGift.selected:setVisible(false)
	end

	local data = sender.giftData
	sender.selected:setVisible(true)

	local isDress = self:isDressGift(data)
	self.Button_try:setVisible(isDress)
	self.Button_check:setVisible(not isDress)
	self.Button_purchase:setVisible(sender.status == 0)
	if not self.Button_purchase:isVisible() then
		self.Button_try:setPositionX(self.Button_purchase.originX)
	else
		self.Button_try:setPositionX(self.Button_try.originX)
	end

	local cost = data.exchangeCost[1]
	self.Button_purchase.price:setText(cost.num)

	local itemCfg = GoodsDataMgr:getItemCfg(cost.id)
	self.Button_purchase.coin:setTexture(itemCfg.icon)

	self.curGift = sender
end

function MainEntryView:onQueryGift()
	local statusData = ActivityDataMgr2:getGiftStatus()
	for i=1,#self.giftNodes do
		local giftNode = self.giftNodes[i]
		local giftID = giftNode.giftId
		if statusData[giftID] and statusData[giftID].status == 0 then		--不可领取
			giftNode.canGet:setVisible(false)
			giftNode.finish:setVisible(false)

		elseif statusData[giftID] and statusData[giftID].status == 1 then	--可领取
			giftNode.canGet:setVisible(true)
			giftNode.finish:setVisible(false)

		elseif statusData[giftID] and statusData[giftID].status == 2 then	--已完成
			giftNode.canGet:setVisible(false)
			giftNode.finish:setVisible(true)

		else
			giftNode.canGet:setVisible(false)
			giftNode.finish:setVisible(false)

		end
		giftNode.status = statusData[giftID].status
	end
	self:selectGift(self.giftNodes[1])
end

function MainEntryView:onGetGift(data)
	Utils:showReward(data.items)
	TFDirector:send(c2s.RECHARGE_REQ_GROUP_GIFT_INFO, {})
end

function MainEntryView:isDressGift(data)
	if nil == data then
		return;
	end
	local item = data.item[1]
	local firstNum = tonumber(tostring(item.id)[1])
	local ret = false
	if firstNum == 1 then		--灵装
		ret = false	
	elseif firstNum == 4 then	--时装
		ret = true	
	end
	return ret
end

--打开时装界面
function MainEntryView:enterDressView()
	local data = self.curGift.giftData
	if nil == data then
		return;
	end
	if not self:isDressGift(data)then
		return
	end

	local item = data.item[1]
	local function findHeroByDress(tab, format, id)
		local data = TabDataMgr:getData(tab)
		for k,v in pairs(data) do
			for s,q in pairs(v[format]) do
				if q == id then
					return v.id
				end
			end
		end
	end
	local heroId = findHeroByDress("Role", "dress", item.id)
	Utils:openView("role.NewRoleShowView", heroId, item.id)
end

function MainEntryView:openPanel(data)
	if data.type == EC_GroupOpenPanel.Room then
		local model = requireNew("lua.logic.GroupPurchase.FittingRoom"):new(self.activityInfo, data.giftId)
		self:addLayerToNode(model, self,PanelOrder.Room)

	elseif data.type == EC_GroupOpenPanel.Invit then
		local mgGPData = ActivityDataMgr2:getMyGroupPurchaseInfo(data.giftId)
		if #mgGPData.partner >= 2 then
			Utils:showTips(240004)
			return;
		end
		local model = requireNew("lua.logic.GroupPurchase.InvitingView"):new(data.giftId, self.activityInfo)
        self:addLayerToNode(model, self, PanelOrder.InvitPanel)

	elseif data.type == EC_GroupOpenPanel.Create then
		local model = requireNew("lua.logic.GroupPurchase.CreateComfirm"):new(data.giftId, data.giftData, self.activityInfo)
        self:addLayerToNode(model, self, PanelOrder.CreatePanel)
	end
end


function MainEntryView:closePanel(data)
	self:removeLayerFromNode(data.target, self)
	if data.type == EC_GroupOpenPanel.Hall then
		self:queryGiftStatus()
	end
end


return MainEntryView


--endregion
