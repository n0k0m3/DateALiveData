--[[
version: creator 2.4.1
Author: 张鹏程
Date: 2021-01-20 18:27:50
--]]

local FireworkStoreView = class("FireworkStoreView",BaseLayer)
function FireworkStoreView:ctor(...)
    self.super.ctor(self)
    self.block = AlertManager.BLOCK_CLOSE
    self:showPopAnim(true)
    self:initData(...)
    self:init("lua.uiconfig.activity.fireworkStoreView")
end

function FireworkStoreView:initUI(ui)
    self.super.initUI(self,ui)

    self.tableView                      = Utils:scrollView2TableView( TFDirector:getChildByPath(ui,"ScrollView"))
    self.Panel_item                     = TFDirector:getChildByPath(ui,"Panel_item")

    self.Label_diamondNum               = TFDirector:getChildByPath(ui,"Label_diamondNum")

    self.Image_coin_icon                = TFDirector:getChildByPath(ui,"Image_coin_icon"):hide()

    self.Button_close                   = TFDirector:getChildByPath(ui,"Button_close")

    self.Panel_tab                      = TFDirector:getChildByPath(ui,"Panel_tab")

    self.Label_act_time                 = TFDirector:getChildByPath(ui,"Label_act_time")

    local st_year, st_month, st_day = Utils:getDate(self.activityData[1].startTime)
    local en_year, en_month, en_day = Utils:getDate(self.activityData[1].showEndTime)
    self.Label_act_time:setTextById(63887, st_month, st_day, en_month, en_day)

    self:initView()
end

function FireworkStoreView:initView()
    self:initTableView()
    self:initTab()
end

function FireworkStoreView:updateView()
    local showCurrency = tonumber(self.activityData[self.curTabIdx].extendData.showCurrency or 0)
    local coin = self.Image_coin_icon:getParent():getChildByTag(9999)
    if coin == nil then
        coin = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        coin:setScale(0.5)
        coin:setTag(9999)
        coin:setPosition(self.Image_coin_icon:getPosition())
        TFDirector:getChildByPath(coin, "Image_frame"):hide()
        PrefabDataMgr:setInfo(coin, showCurrency)
        self.Image_coin_icon:getParent():addChild(coin)
    else
        PrefabDataMgr:setInfo(coin, showCurrency)
    end

    local count = GoodsDataMgr:getItemCount(showCurrency)
    self.Label_diamondNum:setText(count)

    local temp1 = {}
    local temp2 = {}
    local items = clone(self.storeItems[self.curTabIdx])
    dump(self.storeItems[self.curTabIdx])
    for i, val in ipairs(items) do
        local canbuy,remainCount = ActivityDataMgr2:getRemainBuyCount(self.activityData[self.curTabIdx].activityType, val)
        if remainCount == 0 then
            table.insert(temp2, val)
        else
            table.insert(temp1, val)
        end
    end
    local temp3 = {}
    table.insertTo(temp3, temp1)
    table.insertTo(temp3, temp2)
    self.goods = temp3
    dump(temp3)
    self.tableView:reloadData()
end

function FireworkStoreView:initData()
    self.activityData = {}
    self.storeItems = {}
    self.actId1 = 11172
    self.activityData[1] = ActivityDataMgr2:getActivityInfo(self.actId1)
    self.storeItems[1] = ActivityDataMgr2:getItems(self.actId1)
    

    self.actId2 = 11173
    self.activityData[2] = ActivityDataMgr2:getActivityInfo(self.actId2)
    self.storeItems[2] = ActivityDataMgr2:getItems(self.actId2)

    self.actId3 = 11174
    self.activityData[3] = ActivityDataMgr2:getActivityInfo(self.actId3)
    self.storeItems[3] = ActivityDataMgr2:getItems(self.actId3)
    print(self.storeItems)

    self.curTabIdx = nil

    self.tabItems = {}

    self.goods = {}
end

function FireworkStoreView:initTab()
    for i=1, 3 do
        local tab = TFDirector:getChildByPath(self.Panel_tab, "tab"..i)
        tab.Image_Select = TFDirector:getChildByPath(tab, "Image_Select"):hide()
        tab.Image_Unselet = TFDirector:getChildByPath(tab, "Image_Unselet"):show()
        tab.touch = TFDirector:getChildByPath(tab, "touch"):show()
        tab.touch:setTouchEnabled(true)
        tab.touch:addMEListener(TFWIDGET_CLICK,function()
            self:clickTab(i)
        end)
        table.insert(self.tabItems, tab)
    end
    
    self:clickTab(1)
end

function FireworkStoreView:onShow()
    self.super.onShow(self)   
    DatingDataMgr:triggerDating(self.__cname, "onShow")
end

function FireworkStoreView:clickTab(index)
    if self.curTabIdx == index then
        return
    end

    local tab
    if self.curTabIdx then
        tab = self.tabItems[self.curTabIdx]
        tab.Image_Select:hide()
        tab.Image_Unselet:show()
    end

    tab = self.tabItems[index]
    tab.Image_Select:show()
    tab.Image_Unselet:hide()

    self.curTabIdx = index

    self:updateView()
end

function FireworkStoreView:registerEvents()
    self.super.registerEvents(self)

    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.recProgressReward, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_DELETED, function ( activityId, extendData )
        -- body
        if self.actId1 == activityId or self.actId2 == activityId or self.actId3 == activityId then
            AlertManager:closeLayer(self)
        end
    end)

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

function FireworkStoreView:initTableView()
    self.tableView:setDirection(TFTableView.TFSCROLLHORIZONTAL)
	self.tableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.tableCellSize,self))
    self.tableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCells,self))
    self.tableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex,self))
end

function FireworkStoreView:numberOfCells(tableView)
	return #self.goods
end

function FireworkStoreView:tableCellSize(tableView)
	local size = self.Panel_item:getContentSize()
	return size.height, size.width
end

function FireworkStoreView:tableCellAtIndex(tableView, idx)
	local cell = tableView:dequeueCell()
    local item = nil
	if nil == cell then
        cell = TFTableViewCell:create()
        item = self.Panel_item:clone()
		item.idx = idx
        item:show()
        item:setPosition(ccp(0,0))
        cell:addChild(item)
        cell.item = item

		self:initCell(item, self.goods[idx + 1])	
	else
		item = cell.item
    end
	self:updateCell(item, self.goods[idx + 1])
	return cell
end

function FireworkStoreView:initCell(item, itemId)
    item.rewardpos      = TFDirector:getChildByPath(item, "rewardpos")
	item.Label_price    = TFDirector:getChildByPath(item, "Label_price")
	item.Label_buyLimit = TFDirector:getChildByPath(item, "Label_buyLimit")
    item.Image_coin     = TFDirector:getChildByPath(item, "Image_coin")
    item.Label_itemName = TFDirector:getChildByPath(item, "Label_itemName")
    item.Button_buy     = TFDirector:getChildByPath(item, "Button_buy")
    item.Label_tips     = TFDirector:getChildByPath(item, "Label_tips"):hide()
    item.Label_tips_got = TFDirector:getChildByPath(item, "Label_tips_got"):hide()
end

function FireworkStoreView:updateCell(item, itemId)
    local itemInfo = ActivityDataMgr2:getItemInfo(self.activityData[self.curTabIdx].activityType, itemId)
    if itemInfo then
        local id, num = next(itemInfo.reward)
        local goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        goods:setPosition(ccp(0,0))
        PrefabDataMgr:setInfo(goods, id, num)
        local cfg = GoodsDataMgr:getItemCfg(id)
        item.rewardpos:addChild(goods)
        item.Label_itemName:setTextById(cfg.nameTextId)

        local targetId, targetNum = next(itemInfo.target)
        local cfg = GoodsDataMgr:getItemCfg(targetId)
        item.Image_coin:setTexture(cfg.icon)
        item.Label_price:setText(targetNum)

        local canbuy,remainCount = ActivityDataMgr2:getRemainBuyCount(self.activityData[self.curTabIdx].activityType, itemId)
        if itemInfo.extendData.limitType == 1 then
            item.Label_buyLimit:setTextById(270509, remainCount)
        elseif itemInfo.extendData.limitType == 2 then
            item.Label_buyLimit:setTextById(3004021, remainCount)
        end
        local hasNum = GoodsDataMgr:getItemCount(id)
        if itemInfo.extendData.tipType and hasNum >= tonumber(itemInfo.extendData.tipType) and itemInfo.extendData.tipId then
            item.Label_tips:show()
            item.Label_tips:setTextById(itemInfo.extendData.tipId)
            item.Button_buy:hide()
            item.Label_tips_got:hide()
        else
            item.Label_tips:hide()
            item.Button_buy:show()

            if remainCount == 0 then
                item.Button_buy:hide()
                item.Label_tips_got:show()
            else
                item.Label_tips_got:hide()
                item.Button_buy:show()
            end
        end

        item.Button_buy:onClick(function()
            local callFunc = function ( ... )  
                local isEnough = ActivityDataMgr2:currencyIsEnough(self.activityData[self.curTabIdx].activityType, itemId)
                if isEnough then
                    Utils:openView("activity.ActivityBuyConfirmView", self.activityData[self.curTabIdx].id, itemId)
                else
                    Utils:showTips(302200)
                end
            end
    
            local tipId = Utils:getStoreBuyTipId(self.activityData[self.curTabIdx].extendData, 2) 
            if tipId then
                local args = {
                    tittle = 2107025,
                    reType = "buyGiftTip",
                    content = TextDataMgr:getText(tipId),
                    confirmCall = function ( ... )
                        callFunc();
                    end,
                }
                Utils:showReConfirm(args)
                return
            end
            
            callFunc()
        end)
    end
end

function FireworkStoreView:recProgressReward(reward)
    self:updateView()
end




return FireworkStoreView