--[[
    @desc：RecommondView
    @date: 2020-10-11 15:27:03
]]

local RecommondView = class("RecommondView",BaseLayer)

function RecommondView:initData(data)
    self.data = data
end

function RecommondView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.supplyNew.recommondView")

    self:refreshView()
end

function RecommondView:initUI(ui)
    self.super.initUI(self,ui)
    self.gridView = UIGridView:create(self._ui.scroll_list)
	self.gridView:setItemModel(self._ui.panel_cell)
	self.gridView:setColumn(4)
    self.gridView:setColumnMargin(10)
    self.gridView:setRowMargin(10)

    self:addCountDownTimer()
end

function RecommondView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(500, -1, nil, handler(self.onCountDownPer, self))
    end
end

function RecommondView:onCountDownPer()
    if not self.coolDown then
        return
    end
    local serverTime = ServerDataMgr:getServerTime()
    for k,v in pairs(self.coolDown) do
        local str = ""
        if v - serverTime > 0 then
            local day, hour, min = Utils:getFuzzyDHMS(v - serverTime, true)
            str = TextDataMgr:getText(4007008,day, hour, min)
        end
        k.Label_countdown:setText(str)
        k:setVisible(str ~= "")
    end
end

function RecommondView:registerEvents()
    EventMgr:addEventListener(self,EV_RECHARGE_UPDATE,handler(self.updateContentView, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
end

function RecommondView:onSubmitSuccessEvent(activitId, itemId, reward)
    local warOrderActivity = ActivityDataMgr2:getWarOrderAcrivityInfo()
    if warOrderActivity.id == activitId then
        Utils:showReward(reward)
        self:timeOut(function()
            self:updateContentView()
        end, 0.3)
    end
end

function RecommondView:updateContentView()
    self.gridView:setVisible(true)
    self.gridView:initParams()
    self.gridView:doLayout()

    local giftData = RechargeDataMgr:getGiftListByType(tonumber(self.data.interface))
    if self.data.id == 5 then -- 战令商店
        local itemInfo
        local progressInfo
        local warOrderActivity = ActivityDataMgr2:getWarOrderAcrivityInfo()
        if warOrderActivity and warOrderActivity.id then
            local trainingTaskData = ActivityDataMgr2:getItems(warOrderActivity.id)
            for i,v in ipairs(trainingTaskData) do
                if tonumber(warOrderActivity.extendData.daytask) == v then
                    itemInfo = ActivityDataMgr2:getItemInfo(warOrderActivity.activityType, v)
                    break
                end
            end
            if itemInfo then
                progressInfo = ActivityDataMgr2:getProgressInfo(warOrderActivity.activityType, itemInfo.id)
                if progressInfo.status == EC_TaskStatus.GET or progressInfo.status == EC_TaskStatus.GETED then
                    itemInfo.item = {} 
                    for _id, _num in pairs(itemInfo.reward) do
                        table.insert(itemInfo.item,{id = _id, num = _num})
                    end
                    table.insert(giftData, itemInfo)
                end
            end
        end
    end

    if not giftData then
        self.gridView:setVisible(false)
        return
    end

    self.coolDown = {}
    local realDataList = {}
    local serverTime = ServerDataMgr:getServerTime()
    for k,v in ipairs(giftData) do
        if v.startDate and v.endDate then
            if serverTime >= v.startDate and serverTime < v.endDate then
                table.insert(realDataList, v)
            end
        else
            table.insert(realDataList, v)
        end
    end

    self.gridView:AsyncUpdateItem(realDataList, function ( item , data )
        -- body
        if data then
            item:show()
            local cell_gift = TFDirector:getChildByPath(item, "cell_gift")
            local cell_item = TFDirector:getChildByPath(item, "cell_item")
            cell_gift:show()
            cell_item:show()
            self:updateGiftItem(cell_gift, data)
            if data.item then
                self:updateCellItem(cell_item, data.item)
            end
        end
    end)
   
end

function RecommondView:updateGiftItem(item, data)
    local Button_buy = TFDirector:getChildByPath(item, "Button_buy"):show()
    local Button_get = TFDirector:getChildByPath(item, "Button_get"):hide()
    local Image_title_di = TFDirector:getChildByPath(item,"Image_title_di"):hide()
    local img_rightIcon  = TFDirector:getChildByPath(item,"img_rightIcon"):hide()
    local Label_title_desc = TFDirector:getChildByPath(item,"Label_title_desc")
    local Label_title_desc1 = TFDirector:getChildByPath(item,"Label_title_desc1")
    local Label_desc = TFDirector:getChildByPath(item,"Label_desc")
    local Label_num = TFDirector:getChildByPath(item,"Label_num")
    local img_countBg = TFDirector:getChildByPath(item,"img_countBg")
    local Label_countdown = TFDirector:getChildByPath(img_countBg,"Label_countdown")
    
    if not data.rechargeCfg and self.data.id == 5 then
        local warOrderActivity = ActivityDataMgr2:getWarOrderAcrivityInfo()
        local progressInfo = ActivityDataMgr2:getProgressInfo(warOrderActivity.activityType, data.id)

        local Label_price = TFDirector:getChildByPath(item,"Label_price")
        local Label_txt = TFDirector:getChildByPath(Button_get,"Label_txt")
        Label_desc:hide()
        img_countBg:setVisible(false)
        Button_buy:setVisible(false)
        Button_get:show()
        Label_num:setTextById(data.details)
        local isReceive = progressInfo.status == EC_TaskStatus.GET
        local isGeted = progressInfo.status == EC_TaskStatus.GETED
        if isReceive then
            Label_txt:setTextById(1820002)
        else
            Label_txt:setTextById(1300015)
        end

        Button_get:setGrayEnabled(isGeted)
        Button_get:setTouchEnabled(not isGeted)

        Button_get:onClick(function()
            ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(warOrderActivity.id, data.id)
        end)
        return
    end

    local Label_price    = TFDirector:getChildByPath(item,"Label_price")
    local Label_oldPriceLine = TFDirector:getChildByPath(item,"Label_oldPriceLine")
    local Label_oldPrice = TFDirector:getChildByPath(item,"Label_oldPrice")

    if not Label_price.oldPos then
        Label_price.oldPos  = Label_price:getPosition()
    end
    Label_price:setString("￥"..data.rechargeCfg.price)

    if data.discount and data.discount ~= "" then
        Label_oldPriceLine:setVisible(true)
        Label_oldPrice:setText(data.discount)
    else
        Label_oldPriceLine:setVisible(false)
        Label_price:setPositionY(Label_price.oldPos.y - 10)
    end
    
    local Image_exchange = TFDirector:getChildByPath(item,"Image_exchange")
    local btnSrc ="ui/supplyNew/recommond/"
    if data.buyType == 1 then
        local exchangeCfg = GoodsDataMgr:getItemCfg(data.exchangeCost[1].id)
        Image_exchange:show();
        Image_exchange:setTexture(exchangeCfg.icon)
        Image_exchange:setSize(CCSizeMake(40,40))
        Label_price:setString(data.exchangeCost[1].num);
        Label_price:setPositionX(Label_price.oldPos.x) 
        Button_buy:setTextureNormal(btnSrc.."2.png")
    else
        Label_price:setPositionX(Label_price.oldPos.x - 20)
        Image_exchange:hide()
        Button_buy:setTextureNormal(btnSrc.."1.png")
    end

    Label_num:setText(Utils:MultiLanguageStringDeal(data.name))

    local Label_leftTime= TFDirector:getChildByPath(item,"Label_leftTime")
    Label_leftTime:setString(data.buyCount - RechargeDataMgr:getBuyCount(data.rechargeCfg.id).."/"..data.buyCount)
    Label_leftTime:setVisible(data.buyCount ~= 0)

    local Label_tips = TFDirector:getChildByPath(item,"Label_tips")
    Label_tips:setVisible(data.buyCount ~= 0)

    Label_desc:setText(Utils:MultiLanguageStringDeal(data.des2))
    Label_desc:show()

    local serverTime = ServerDataMgr:getServerTime()
    Label_countdown:setText("")
    img_countBg.Label_countdown = Label_countdown
    img_countBg:setVisible(false)
    if data.startDate and data.endDate and serverTime >= data.startDate and serverTime < data.endDate then
        self.coolDown[img_countBg] = data.endDate
    end

    if RechargeDataMgr:isNewOpenGiftBag(data.rechargeCfg.id) then
        RechargeDataMgr:clearNewGiftBagFlag(data.rechargeCfg.id)
    end

    local isCanBuy = true
    if data.buyCount ~= 0 and data.buyCount - RechargeDataMgr:getBuyCount(data.rechargeCfg.id) <= 0 then
        isCanBuy = false
    end

    Button_buy:onClick(function()
        local callFunc = function ( ... )
            if data.buyCount ~= 0 and data.buyCount - RechargeDataMgr:getBuyCount(data.rechargeCfg.id) <= 0 then
                Utils:showTips(800117)
                return
            end

        if self.data.id == 5 then
            local condition = TabDataMgr:getData("DiscreteData",46022).data
            local element = condition[data.rechargeCfg.id]
            if element then
                local canBuy = true
                for k, v in pairs(element) do
                    local vec = string.split(v,",")
                    if tonumber(k) == 3 then
                        for k1, v1 in pairs(vec) do
                            if RechargeDataMgr:getBuyCount(tonumber(v1)) <= 0 then
                                canBuy = false
                            end
                        end
                    elseif tonumber(k) == 4 then
                        canBuy = false
                        for k1, v1 in pairs(vec) do
                            if RechargeDataMgr:getBuyCount(tonumber(v1)) > 0 then
                                canBuy = true
                            end
                        end
                    end
                    if not canBuy then
                        local args = {
                            tittle = 2107025,
                            content = TextDataMgr:getText(200025),
                            reType = false,
                            confirmCall = function()
                                FunctionDataMgr:jWarOrderBuy()
                            end,
                        }
                        Utils:showReConfirm(args)
                        return
                    end
                end
            end
        end
            RechargeDataMgr:getOrderNO(data.rechargeCfg.id)
        end

        if data.extendData then
            local tipId = Utils:getStoreBuyTipId(json.decode(data.extendData),2)
            if tipId then
                local args = {
                    tittle = 2107025,
                    reType = "buyGiftTip",
                    content = TextDataMgr:getText(tipId),
                    confirmCall = function ( ... )
                        callFunc()
                    end,
                }
                Utils:showReConfirm(args)
                return
            end
        end

        callFunc()

    end)

    Button_buy:setGrayEnabled(not isCanBuy)
    Button_buy:setTouchEnabled(isCanBuy)

    if data.tag then
        Image_title_di:show()
        local tagType = data.tagIcon or 0
        local buyCount = RechargeDataMgr:getBuyCount(data.rechargeCfg.id)
        if buyCount == 0 then
            Label_title_desc:setText(data.tagDes)
            Label_title_desc1:setText(data.tagDes)
        elseif data.tagDes2 ~= "" then
            Label_title_desc:setText(data.tagDes2)
            Label_title_desc1:setText(data.tagDes2)
        else
            Image_title_di:hide()
        end
        Label_title_desc:setVisible(tagType == 1)
        Label_title_desc1:setVisible(tagType ~= 1)
    end
end

function RecommondView:updateCellItem(item, data, canTouch, posY)
	posY = posY or 25
	if canTouch == nil then
		canTouch = true
	end
	item:setPositionY(posY)

	local posList = {}
	posList[1] = {{0, -15, 0.65}}
	posList[2] = {{-38, -15, 0.65}, {38, -15, 0.65}}
	posList[3] = {{-38, 20, 0.65}, {38, 20, 0.65}, {0, -50, 0.55}}
	posList[4] = {{-38, 20, 0.65}, {38, 20, 0.65}, {33, -50, 0.55}, {-33, -50, 0.55}}

	if not item.list then
		item.list = {}
	end

	local curPos = posList[4]
	if #data < 4 then
		curPos = posList[#data]
	end
	for i = 1, 4 do
		local goodItem = item.list[i]
		if i <= #data then
			if not goodItem then
				goodItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
				item.list[i] = goodItem
				item:addChild(goodItem)
				goodItem:onClick(handler(self.onGoodItemClickHandle, self))
			end
			goodItem:setTouchEnabled(canTouch)
			goodItem:setScale(curPos[i][3])
			goodItem:setPosition(ccp(curPos[i][1], curPos[i][2]))
			goodItem:show()
			goodItem.id = data[i].id
			PrefabDataMgr:setInfo(goodItem, data[i].id, data[i].num)
		else
			if goodItem then
				goodItem.id = nil
				goodItem:hide()
				goodItem:setTouchEnabled(false)
			end
		end
	end
end

function RecommondView:refreshView()
    self._ui.Image_show:setVisible(nil ~= self.data.bannerimg)
    self.gridView:setVisible(self._ui.Image_show:isVisible())
    if self.data.bannerimg then
        local img = "ui/supplyNew/recommond/"..self.data.bannerimg..".png"
        self._ui.Image_show:setTexture(img)
    end
    self:updateContentView()
end

return RecommondView