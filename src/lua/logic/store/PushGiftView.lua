--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local PushGiftView = class("PushGiftView", BaseLayer)
PushGiftView.ViewType = {
	[1] = "pushGiftRegression",
	[2] = "pushGiftBento",
	[3] = "pushGiftGold",
	[4] = "pushGiftCommon"
}
local function getView(type_)
	return PushGiftView.ViewType[type_]
end

function PushGiftView:initDta(data)
    self.data = data
	print("PushGiftView:", self.data)
	dump(self.data)
	self.extendData = json.decode(self.data["extendData"])

    RechargeDataMgr:tiggerGift(1)
end

function PushGiftView:ctor(...)
    self.super.ctor(self)
    self:initDta(...)
    self:showPopAnim(true)
	dump(self.extendData)
    self:init("lua.uiconfig.recharge."..getView(self.extendData["showType"]))
end

function PushGiftView:initUI(ui)
    self.super.initUI(self,ui) 

	self.Image_diban = TFDirector:getChildByPath(ui,"Image_diban")
	self.Image_diban:setSwallowTouch(false)
	self.Image_diban:setTouchEnabled(true)
    self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
    self.giftName = TFDirector:getChildByPath(ui,"giftName")
	self.DesLabel = TFDirector:getChildByPath(ui,"DesLabel")
    self.timeCount = TFDirector:getChildByPath(ui,"timeCount")

	self.empty_2 = TFDirector:getChildByPath(ui,"empty_2")
	self.empty_3 = TFDirector:getChildByPath(ui,"empty_3")
	self.originPrice = TFDirector:getChildByPath(ui,"originPrice")
	self.discountTag = TFDirector:getChildByPath(ui,"discountTag")
	self.discountPrice = TFDirector:getChildByPath(ui,"discountPrice")
    self.btn_pay = TFDirector:getChildByPath(ui,"btn_pay")
	self.nodeGift = TFDirector:getChildByPath(ui,"gifts")
	self.ImgCost = TFDirector:getChildByPath(ui,"ImgCost")
	self.imageDiscountTag = TFDirector:getChildByPath(ui,"imageDiscountTag")

    self:refresView()

	self:addTimer()
end

function PushGiftView:addTimer()
	if self.counter == nil then
		self.counter = TFDirector:addTimer(1000,-1,nil,function ( ... )
			self:refreshTime()
		end)
	end
end

function PushGiftView:removeEvents()
	if self.counter then
		TFDirector:stopTimer(self.counter)
        TFDirector:removeTimer(self.counter)
        self.counter = nil
	end
end

function PushGiftView:refreshTime()
	local serverTime = ServerDataMgr:getServerTime()
    local str = ""
    if self.data.triggerEndDate - serverTime > 0 then
        local hour, min = Utils:getFuzzyTime(self.data.triggerEndDate - serverTime, true)
		str = string.format(self.extendData["timeFormat"], hour, min)
    end
    self.timeCount:setText(str)
end

function PushGiftView:refresView()
    self.giftName:setText(self.data["name"])
	self.DesLabel:setText(self.extendData["showText"])
	self.discountPrice.x = self.discountPrice:getPositionX()
	if self.data.buyType == 1 then
		self.ImgCost:show()
		self.originPrice:hide()
		if self.imageDiscountTag then
			self.imageDiscountTag:hide()
		end
		self.discountTag:hide()

		local cfg = GoodsDataMgr:getItemCfg(self.data["exchangeCost"][1]["id"])
		self.ImgCost:setTexture(cfg.icon)		
		self.discountPrice:setText(self.data["exchangeCost"][1]["num"])
	else
		self.ImgCost:hide()
		self.originPrice:show()
		if self.imageDiscountTag then
			self.imageDiscountTag:show()
		end
		self.discountTag:show()
		self.originPrice:setText("$"..self.data["originalPrice"])
		self.discountTag:setTextById(277004, self.data["discount"])
		self.discountPrice:setText("$ ".. self.data["rechargeCfg"]["price"])
		self.discountPrice:setPositionX(self.discountPrice.x - 20)
	end


	self:refreshTime()


	self.empty_2:hide()
	self.empty_3:hide()
	local items = self.data["item"] or {}
	for i=1, 3 do

		local gift = self.nodeGift:getChildByName("gift"..i)
		local price = gift:getChildByName("price")
		price:setText("")
		if items[i] then
			gift:setVisible(true)
			
			gift:setTexture(GoodsDataMgr:getItemCfg(items[i].id).icon)
			gift:onClick(function ( ... )
				Utils:showInfo(items[i].id)
			end)
			gift:setTouchEnabled(true)
			price:setText(items[i].num)
		else
			if i == 2 then
				self.empty_2:show()
			end
			if i == 3 then
				self.empty_3:show()
			end
			gift:setVisible(false)
		end		
	end

end

function PushGiftView:payOverBack()
    AlertManager:closeLayer(self)
end

function PushGiftView:onClose()
	local pushGift = RechargeDataMgr:getPushGift(1)
	if pushGift then
		Utils:openView("store.PushGiftView", pushGift)
	end
end

function PushGiftView:registerEvents()
    EventMgr:addEventListener(self,EV_RECHARGE_UPDATE,handler(self.payOverBack, self))

    self.btn_pay:onClick(function()
        RechargeDataMgr:getOrderNO(self.data.rechargeCfg.id)
    end)

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end


return PushGiftView


--endregion
