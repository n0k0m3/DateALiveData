--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

local FashionWholesale = class("FashionWholesale", BaseLayer)

function FashionWholesale:ctor(...)
	self.super.ctor(self)
	self:initData(...)
	self:init("lua.uiconfig.activity.fashionWholesale")

	self:initFashionList()
end

function FashionWholesale:initData(activityId)
	self.activityId = activityId
	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	--dump(self.activityInfo)
	self.data = {}
	local itemData = self.activityInfo.extendData.items or {}
	for i=1, #itemData do
		local rechargeData = RechargeDataMgr:getOneRechargeCfg(itemData[i])
		table.insert(self.data,rechargeData)
	end
	--dump(self.data)
	self.discountData = self.activityInfo.extendData.discount

	self.itemList = {}

	self.progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, self.activityInfo.items[1])
end

function FashionWholesale:initUI(ui)
	self.super.initUI(self,ui)
	self.Panel_root		= TFDirector:getChildByPath(ui,"Panel_root")
	self.Image_bg_0		= TFDirector:getChildByPath(ui,"Image_bg_0"):hide()
	self.Image_bg_1		= TFDirector:getChildByPath(ui,"Image_bg_1"):hide()

	self.Image_more		= TFDirector:getChildByPath(ui,"Image_more")
	self.Image_more:setVisible(#self.data > 3)

	self.Button_rule	= TFDirector:getChildByPath(ui,"Button_rule")

	self.FashionArray	= UIListView:create(TFDirector:getChildByPath(ui,"FashionArray"))

	self.LabelTime	= TFDirector:getChildByPath(self.Panel_ActTime,"LabelTime")

	self.Panel_prefab	= TFDirector:getChildByPath(ui,"Panel_prefab"):hide()

	self.Label_fashionNum	= TFDirector:getChildByPath(ui,"Label_fashionNum")
	self.Label_fashionNum:setSkewX(10)
	self.Label_fashionNum:setText(self.progressInfo.progress)

	self.Label_discount	= TFDirector:getChildByPath(ui,"Label_discount")	
	self.Label_discount:setSkewX(10)

	local discountScale = self:getDiscountNum()
	self.Label_discount:setTextById(277004,discountScale * 10)

	self.act_time		= TFDirector:getChildByPath(self.Panel_root,"act_time")
	self.act_time:setSkewX(10)
	self.act_time.Start = TFDirector:getChildByPath(self.Panel_root,"act_timeStart")
	self.act_time.Start:setSkewX(5)
	self.act_time.End	= TFDirector:getChildByPath(self.Panel_root,"act_timeEnd")
	self.act_time.End:setSkewX(5)

	local year, month, day = Utils:getDate(self.activityInfo.showStartTime or 0)
	self.act_time.Start:setTextById(1410001,year, month, day)

	year, month, day = Utils:getDate(self.activityInfo.endTime or 0)
	self.act_time.End:setTextById(1410001,year, month, day)

	self:changeBg()
end

function FashionWholesale:registerEvents()
	self.super.registerEvents(self)

	EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, function ( ... )		
		self:updateProgress()	
		self.Label_fashionNum:setText(self.progressInfo.progress)
		local discountScale = self:getDiscountNum()
		self.Label_discount:setTextById(277004,discountScale * 10)
	end)
	EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, function ( parm1, parm2 )
		self:updateView()
	end)

	EventMgr:addEventListener(self, EV_BAG_DRESS_UPDATE, function ( parm1, parm2 )
		self:updateView()
	end)
	self.Button_rule:onClick(function()
		Utils:openView("common.HelpView", {2468})
	end)
end

function FashionWholesale:initFashionList()
	self.FashionArray:removeAllItems()
	self.itemList = {}
	for i = 1, #self.data do
		local fashion = self.Panel_prefab:clone()
		fashion:show()
		self.FashionArray:insertCustomItem(fashion, i)
		self:initCell(fashion, self.data[i])
		table.insert(self.itemList, fashion)
	end
end

function FashionWholesale:initCell(item, data)
	local Name = TFDirector:getChildByPath(item,"LabelName")
	Name:setText(data.name)
	Name:setSkewX(12)
	
	local FashionIcon = TFDirector:getChildByPath(item,"FashionIcon")
	local fashionCfg;
	if self:isFashionDress(data.item[1].id) then
		fashionCfg = TabDataMgr:getData("Dress", data.item[1].id)
		FashionIcon:setTexture(fashionCfg.dressImg)
	else
		fashionCfg = TabDataMgr:getData("HeroSkin", data.item[1].id)
		FashionIcon:setTexture(fashionCfg.skinImg)
	end
	
	local Detail = TFDirector:getChildByPath(item,"Detail")
	Detail:setTouchEnabled(true)
	Detail:addMEListener(TFWIDGET_CLICK,function()
		if self:isFashionDress(data.item[1].id) then
			Utils:showInfo(data.item[1].id, nil, true, isNotShowTry_)
		else
			self:enterDressView(data.item[1].id)
		end
	end)
	
	local costData = data.exchangeCost[1]
	local costCfg = GoodsDataMgr:getItemCfg(costData.id)
	local CostIcon = TFDirector:getChildByPath(item,"CostIcon")
	CostIcon:setTexture(costCfg.icon)

	local originPrice = TFDirector:getChildByPath(item,"originPrice")
	originPrice:setText(costData.num)

	local discountScale = self:getDiscountNum()
	local discountPrice = TFDirector:getChildByPath(item,"discountPrice")
	discountPrice:setText( math.floor(costData.num * discountScale))
	
	local ButtonPurchase = TFDirector:getChildByPath(item,"ButtonPurchase")
	ButtonPurchase:onClick(function()	
		local exchangeId = costData.id
		local realPrice = math.floor(costData.num * discountScale)
		if not self:checkTokenMoney(exchangeId, realPrice) then
            Utils:showAccess(exchangeId)
            return;
        end
		Utils:openView("store.TokenPopView",data.rechargeCfg.id, realPrice);
	end)

	local hasCount = GoodsDataMgr:getItemCount(data.item[1].id)
	local ButtonOwn = TFDirector:getChildByPath(item,"ButtonOwn")
	if hasCount > 0 then
		ButtonOwn:show()
		ButtonPurchase:hide()
	else
		ButtonOwn:hide()
		ButtonPurchase:show()
	end
end

function FashionWholesale:checkTokenMoney(id, num)
    local have = GoodsDataMgr:getItemCount(id)
    if num > have then
        return false
    end

    return true
end

function FashionWholesale:isFashionDress(itemId)
	if nil == itemId then
		return;
	end

	local firstNum = tonumber(tostring(itemId)[1])
	local ret = false
	if firstNum == 1 then		--灵装
		ret = false	
	elseif firstNum == 4 then	--时装
		ret = true	
	end
	return ret
end

function FashionWholesale:enterDressView(fashionId)
	Utils:openView("activity.FashionPreview", fashionId)
end

function FashionWholesale:updateProgress()
	print("FashionWholesale:updateProgress")
	self.progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, self.activityInfo.items[1])
	self:changeBg()	
end

function FashionWholesale:getDiscountNum()
	local hasNum = self.progressInfo.progress
	local discountNum = 1000
	for k,v in pairs(self.discountData) do
		if hasNum == tonumber(k) then
			discountNum = v	
			break;
		end
	end
	return discountNum / 1000
end

function FashionWholesale:updateView()
	print("FashionWholesale:updateView")
	for i = 1, #self.itemList do
		self:initCell(self.itemList[i],	self.data[i])
	end
end

function FashionWholesale:changeBg()
	local fashionNum = self.progressInfo.progress
	self.Image_bg_0:setVisible(fashionNum > 0)
	self.Image_bg_1:setVisible(fashionNum == 0)
end

return FashionWholesale

--endregion
