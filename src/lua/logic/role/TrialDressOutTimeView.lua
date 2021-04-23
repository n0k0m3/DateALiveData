--[[
version: creator 2.4.1
Author: 张鹏程
Date: 2020-11-12 10:17:23
--]]
--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

local TrialDressOutTimeView = class("TrialDressOutTimeView", BaseLayer)
function TrialDressOutTimeView:ctor(...)
	self.super.ctor(self)

	self:initData(...)

	self:showPopAnim(true)
	
	self:init("lua.uiconfig.role.trialDressOutTimeView")
end

function TrialDressOutTimeView:initData(dressId, bOuttime)
	self.bOuttime = bOuttime
	
	self.data = GoodsDataMgr:getItemCfg(dressId)
	local arr = TabDataMgr:getData("DiscreteData", 90040).data	

	self.rechargeIds = arr[dressId]
	print(dressId,arr,self.rechargeIds)

	local dressInfo = GoodsDataMgr:getDress(dressId)
	if bOuttime then
		GoodsDataMgr:saveLocalTrialDress()
	end
	EventMgr:addEventListener(self,EV_RECHARGE_UPDATE,function(reward)
		if reward and table.count(reward) > 0 then
			if self.buying then
				self.buying = false
				AlertManager:closeLayer(self)
			end
		end
	end)
end

function TrialDressOutTimeView:initUI(ui)
	self.super.initUI(self,ui)

	self.Panel_base = TFDirector:getChildByPath(self.ui, "Panel_base")
	local DressNode = TFDirector:getChildByPath(self.ui, "DressNode")
	DressNode:setTexture(self.data.dressImg)

	local Button_buy_1 = TFDirector:getChildByPath(ui, "Button_buy_1")
	Button_buy_1.px = Button_buy_1:getPositionX()
	local Button_buy_2 = TFDirector:getChildByPath(ui, "Button_buy_2")
	Button_buy_2.px = Button_buy_2:getPositionX()

	Button_buy_1:onClick(function()
		self.buying = true
		RechargeDataMgr:getOrderNO(self.rechargeIds[1])
	end)

	local rechargeData = RechargeDataMgr:getOneRechargeCfg(self.rechargeIds[1])
	if rechargeData then
		local price = TFDirector:getChildByPath(Button_buy_1, "price")
		price:setText(rechargeData.exchangeCost[1].num)

		local costIcon = TFDirector:getChildByPath(Button_buy_1, "costIcon")
		local CNY = TFDirector:getChildByPath(Button_buy_1, "CNY")
		if rechargeData.buyType == 0 then
			CNY:show()
			CNY:setText("¥")
			costIcon:hide()
		else
			local cfg = GoodsDataMgr:getItemCfg(rechargeData.exchangeCost[1]["id"])
			costIcon:show()
			costIcon:setTexture(cfg.icon)
			CNY:hide()
		end
	else
		Button_buy_1:hide()
	end

	
	Button_buy_2:onClick(function()
		self.buying = true
		RechargeDataMgr:getOrderNO(self.rechargeIds[2])
	end)

	rechargeData = RechargeDataMgr:getOneRechargeCfg(self.rechargeIds[2])
	if rechargeData then
		local price = TFDirector:getChildByPath(Button_buy_2, "price")
		price:setText(rechargeData.exchangeCost[1].num)

		local costIcon = TFDirector:getChildByPath(Button_buy_2, "costIcon")
		local CNY = TFDirector:getChildByPath(Button_buy_2, "CNY")
		if rechargeData.buyType == 0 then
			CNY:show()
			CNY:setText("¥")
			costIcon:hide()
		else
			local cfg = GoodsDataMgr:getItemCfg(rechargeData.exchangeCost[1]["id"])
			costIcon:show()
			costIcon:setTexture(cfg.icon)
			CNY:hide()
		end
	else
		Button_buy_2:hide()
		Button_buy_1:setPositionX(Button_buy_2.px)
	end

	

	local Button_cancel = TFDirector:getChildByPath(self.ui, "Button_cancel")
	Button_cancel:onClick(function()
		AlertManager:closeLayer(self)
	end)
	local richtext = "r3061"
	if self.bOuttime then
		richtext = "r3062"
	end
	local name =TextDataMgr:getText(self.data.nameTextId)
	TFDirector:getChildByPath(self.ui, "richtext"):setTextById(richtext, name)
	--TFDirector:getChildByPath(self.ui, "richtext"):setLineSpacing(10)
	
end

function TrialDressOutTimeView:onClose()
	self.super.onClose(self)
	
	self:checkNextTrial()
end

function TrialDressOutTimeView:checkNextTrial()
	local val = GoodsDataMgr:queueDeleteDressList()
	if val then
		local arr = TabDataMgr:getData("DiscreteData", 90040).data	
		local rechargeIds = arr[val] or {}
		
		local outtime1 = false
		local rechargeData1 = RechargeDataMgr:getOneRechargeCfg(rechargeIds[1])
		if rechargeData1 then
			if ServerDataMgr:getServerTime() >= rechargeData1.endDate then
				outtime1 = true
			end
		else
			outtime1 = true
		end

		local outtime2 = false
		local rechargeData2 = RechargeDataMgr:getOneRechargeCfg(rechargeIds[2])
		if rechargeData2 then
			if ServerDataMgr:getServerTime() >= rechargeData2.endDate then
				outtime2 = true
			end
		else
			outtime2 = true
		end

		if outtime1 and outtime2 then
			GoodsDataMgr:removeAndSaveDeleteDressList(val)
			self:checkNextTrial()
			return
		end	
		Utils:openView("role.TrialDressOutTimeView", val, self.bOuttime)
	end
end

return TrialDressOutTimeView

--endregion
