
local StorePackMainView = class("StorePackMainView", BaseLayer)

function StorePackMainView:ctor(storeId)
    self.super.ctor(self)
    self:initData(storeId)
    self:init("lua.uiconfig.activity.storePackMainView")
end

function StorePackMainView:initData(storeId)
    self.tabBtns    = {}
    self.selectIndex = nil
    self.curStoreId = nil
    self.goodsIconMap_ = {}
    self.defaultIndex = 1
    self.storeIds = StoreDataMgr:getOpenStore(EC_StoreType.TWOYEAR)
    dump(self.storeIds)
    if storeId then
        local index = table.indexOf(self.storeIds, storeId)
        if index ~= -1 then
            self.defaultIndex = index
        end
    end

    self.countDownTimer_ = nil

    -- 限时商店截止时间
    self.storeDeadLine_ = {}

    for i, v in ipairs(self.storeIds) do
        local rets, deadline = StoreDataMgr:isOpenTime(v)
        if rets and deadline then
            self.storeDeadLine_[v] = deadline
        end
    end

end

function StorePackMainView:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab   = TFDirector:getChildByPath(self.ui, "Panel_prefab")
    self.Panel_tabItem  = TFDirector:getChildByPath(self.ui, "Panel_tabItem")
    self.Panel_content = TFDirector:getChildByPath(self.ui, "Panel_content")

    self.Label_deadLine = TFDirector:getChildByPath(self.ui, "Label_deadLine")

    local ScrollView_tab_btn    = TFDirector:getChildByPath(self.ui,"ScrollView_tab_btn")
    self.ListView_tab_btn = UIListView:create(ScrollView_tab_btn)
    self.ListView_tab_btn:setItemsMargin(2)

    local ScrollView_assets = TFDirector:getChildByPath(self.ui, "ScrollView_assets")
    self.ListView_assets = UIListView:create(ScrollView_assets)

    self.panel_cell = TFDirector:getChildByPath(self.ui, "Panel_cell")

    self.Label_full_tip = TFDirector:getChildByPath(self.ui, "Label_full_tip"):Hide()
    self.Label_full_tip:setTextById(15010180)
    local scroll_list = TFDirector:getChildByPath(self.ui, "scroll_list")
    self.TableView_item = Utils:scrollView2TableView(scroll_list)
    --Public:bindScrollFun(self.TableView_item)
    --self.TableView_item:setDirection(TFTableView.TFSCROLLHORIZONTAL)
    self.TableView_item:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.cellSizeForTable, self))
    self.TableView_item:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex, self))
    self.TableView_item:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCellsInTableView, self))


    self.Panel_assetItem = TFDirector:getChildByPath(self.ui, "Panel_assetItem")

    self.Button_sort_order = TFDirector:getChildByPath(self.ui, "Button_sort_order")
    self.Label_order_name = TFDirector:getChildByPath(self.ui, "Label_order_name")
    self.Panel_order = TFDirector:getChildByPath(self.ui, "Panel_order"):hide()
    self.Button_order_all = TFDirector:getChildByPath(self.ui, "Button_order_all")
    self.Button_order_unlock = TFDirector:getChildByPath(self.ui, "Button_order_unlock")
    self.Button_order_lock = TFDirector:getChildByPath(self.ui, "Button_order_lock")

    self.orderBtnStr = {15010130 ,15010131,15010132}
    self.orderBtn = {}
    for i=1,3 do
        self.orderBtn[i] = TFDirector:getChildByPath(self.ui, "Button_order_"..i)
        local Label_order = TFDirector:getChildByPath(self.orderBtn[i], "Label_order")
        Label_order:setTextById(self.orderBtnStr[i])
    end


    self:refreshView()
end

function StorePackMainView:refreshView()
    self.ListView_assets:setInertiaScrollEnabled(false)
    if #self.storeIds > 0 then
        self:initTabList()
        self:addCountDownTimer()
    end
end


function StorePackMainView:initTabList()
    self.ListView_tab_btn:removeAllItems()
    self.tabBtns = {}
    for i,v in ipairs(self.storeIds) do
        local storeCfg_ = StoreDataMgr:getStoreCfg(v)
        if storeCfg_ then
            local item = self.Panel_tabItem:clone()
            self.ListView_tab_btn:pushBackCustomItem(item)
            local Label_name = TFDirector:getChildByPath(item,"Label_name")
            Label_name:setTextById(storeCfg_.name)
            Label_name:setSkewX(10)
            local select = TFDirector:getChildByPath(item,"Image_select")
            local img_icon = TFDirector:getChildByPath(item,"img_icon")
            if storeCfg_.icon then
                img_icon:setTexture(storeCfg_.icon)
            end
            item:setTouchEnabled(true)
            item:onClick(function()
                self:selectTabIdx(i)
            end)
            table.insert(self.tabBtns,{item = item,select = select,Label_name = Label_name})
        end
    end
    self:selectTabIdx(self.defaultIndex)
end

function StorePackMainView:selectTabIdx(idx)

    if self.selectIndex == idx then
        return
    end
    self.selectIndex = idx

    for k,v in ipairs(self.tabBtns) do
        v.select:setVisible(k == self.selectIndex)
        local color = k == self.selectIndex and ccc3(255,255,255) or ccc3(175,223,254)
        v.Label_name:setColor(color)
        local outLineColor = k == self.selectIndex and ccc4(88,111,188,255) or ccc4(64,64,139,255)
        v.Label_name:enableOutline(outLineColor,2)
    end
    self.Panel_order:setVisible(false)
    self:orderCommodity(1)
    self:updateShowInfo()
    self:updateCountDonw()
end

function StorePackMainView:orderCommodity(ruleId)

    self.Label_order_name:setTextById(self.orderBtnStr[ruleId])
    local storeId = self.storeIds[self.selectIndex]
    if not storeId then
        return
    end

    self.ruleId = ruleId

    self.commodityData_ = {}
    local allCommondity = StoreDataMgr:getCommodity(storeId) or {}
    if ruleId == 1 then
        self.commodityData_ = allCommondity
    else
        local unlockTab,lockTab = {},{}
        for k,v in ipairs(allCommondity) do
            local isUnlock = StoreDataMgr:isUnlockCommodity(v)
            if isUnlock then
                table.insert(unlockTab,v)
            else
                table.insert(lockTab,v)
            end
        end
        if ruleId == 2 then
            self.commodityData_ = unlockTab
        else
            self.commodityData_ = lockTab
        end
    end

    self.Label_full_tip:setVisible(#self.commodityData_<= 0)

    self.TableView_item:reloadData()
end


function StorePackMainView:cellSizeForTable()
    local size = self.panel_cell:getContentSize()
    return size.height, size.width
end

function StorePackMainView:numberOfCellsInTableView()
    local cnt = math.ceil(#self.commodityData_/2)
    return cnt
end

function StorePackMainView:tableCellAtIndex(tab, idx)
    local cell = tab:dequeueCell()
    idx = idx + 1
    if not cell then
        cell = TFTableViewCell:create()
        local item = self.panel_cell:clone():show()
        --item:setAnchorPoint(ccp(0.5, 0.5))
        item:setPosition(ccp(0, 0))
        cell:addChild(item)
        cell.item = item
    end
    cell.idx = idx

    if cell.item then
        for i=1,2 do
            local root = TFDirector:getChildByPath(cell.item, "panel_item_"..i)
            local commodityIndex = (idx-1)*2+i
            local commodityId = self.commodityData_[commodityIndex]
            if not commodityId then
                root:hide()
            else
                root:show()
                self:updateCommodityItem(root, commodityId)
            end

        end
    end

    return cell
end

function StorePackMainView:updateShowInfo()
    self:updateAssets()
end

function StorePackMainView:updateCommodityItem(item, commodityId)

    local commodityCfg = StoreDataMgr:getCommodityCfg(commodityId)
    if not commodityCfg then
        return
    end

    local goods = commodityCfg.goodInfo[1]
    local goodsId, goodsCount = goods.id, goods.num

    local cell_item = TFDirector:getChildByPath(item, "cell_item")
    local Panel_goodsItem = cell_item:getChildByName("Panel_goodsItem")
    if not Panel_goodsItem then
        Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:ZO(1):AddTo(cell_item)
        Panel_goodsItem:Pos(0, 0)
        Panel_goodsItem:setName("Panel_goodsItem")
    end
    if Panel_goodsItem.ListView_star then
        Panel_goodsItem.ListView_star:removeAllItems()
        Panel_goodsItem.ListView_star = nil
    end
    PrefabDataMgr:setInfo(Panel_goodsItem, goodsId, goodsCount)

    local Label_name = TFDirector:getChildByPath(item, "Label_name")
    local goodsCfg = GoodsDataMgr:getItemCfg(goodsId)
    Label_name:setTextById(goodsCfg.nameTextId)

    ---消耗
    local costId = commodityCfg.priceType[1]
    local costNum = commodityCfg.priceVal[1]

    local costCfg = GoodsDataMgr:getItemCfg(costId)
    local Image_exchange = TFDirector:getChildByPath(item, "Image_exchange")
    Image_exchange:setTexture(costCfg.icon)
    Image_exchange:setScale(0.5)

    local Label_price = TFDirector:getChildByPath(item, "Label_price")
    Label_price:setText(costNum)

    ---开放购买时间
    local Label_countdown = TFDirector:getChildByPath(item, "Label_countdown")
    local isBeginBuy = true
    local buyBeginTime = commodityCfg.buyBeginTime
    if type(buyBeginTime) == "table" and buyBeginTime.year then
        local beginDate = TFDate(buyBeginTime.year, buyBeginTime.month, buyBeginTime.day, buyBeginTime.hour, buyBeginTime.min, buyBeginTime.sec)
        local serverTime = ServerDataMgr:getServerTime()
        local serverDate = TFDate(serverTime):tolocal()
        isBeginBuy = serverDate >= beginDate
        Label_countdown:setTextById(303047, buyBeginTime.month, buyBeginTime.day)
    end
    Label_countdown:setVisible(not isBeginBuy)

    local costId = commodityCfg.priceType
    local costNum = commodityCfg.priceVal

    local Button_buy = TFDirector:getChildByPath(item, "Button_buy")
    Button_buy:onTouch(function(event)
        if event.name == "ended" then
            local state = StoreDataMgr:getCommodityState(commodityId)
            Button_buy:setGrayEnabled(state ~= 1)
        end
    end)

    Button_buy:onClick(function()
        local state = StoreDataMgr:getCommodityState(commodityId)
        if state ~= 1 then
            if state == 3 then
                Utils:showTips(14210003);
            else
                if StoreDataMgr:getCommodityCfg(commodityId).extendData.date then
                    Utils:showTips(14210005,StoreDataMgr:getCommodityCfg(commodityId).extendData.date);
                end
            end
            Button_buy:setGrayEnabled(state ~= 1)
            return
        end

        local callFunc = function ( ... )
            local isEnough = StoreDataMgr:currencyIsEnough(commodityId)
            if isBeginBuy then
                if isEnough then
                    if goodsCfg.superType == EC_ResourceType.DRESS or goodsCfg.superType == EC_ResourceType.REWARD then
                        if GoodsDataMgr:getItemCount(goodsId) > 0 then
                            Utils:openView("store.RepeatBuyTipsView", commodityId)
                        else
                            Utils:openView("store.BuyConfirmView", commodityId)
                        end
                    else
                        Utils:openView("store.BuyConfirmView", commodityId)
                    end
                else
                    local costId = commodityCfg.priceType
                    local costNum = commodityCfg.priceVal
                    for i = 1, math.min(#costId, #costNum) do
                        if not GoodsDataMgr:currencyIsEnough(costId[i], costNum[i] * 1) then
                            Utils:showAccess(costId[i])
                            break
                        end
                    end
                end
            else
                Utils:showTips(303048)
            end
        end

        local tipId = Utils:getStoreBuyTipId(StoreDataMgr:getCommodityCfg(commodityId).extendData, 2)
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

        callFunc();

    end)

    Button_buy:setVisible(true)

    local Label_buy_tip = TFDirector:getChildByPath(item, "Label_buy_tip")
    Label_buy_tip:setVisible(false)

    local tipId = Utils:getStoreBuyTipId(commodityCfg.extendData, 1)
    if tipId then
        Button_buy:setVisible(not tipId)
        Label_buy_tip:setTextById(tipId)
        Label_buy_tip:setVisible(tipId)
    end

    ---限购
    local Label_limit_tips = TFDirector:getChildByPath(item, "Label_limit_tips")
    local isCanBuy, remainCount = StoreDataMgr:getRemainBuyCount(commodityId)
    if isBeginBuy then
        local visible = #commodityCfg.sellDescribtion > 0
        Label_limit_tips:setVisible(visible)
        if visible then
            Label_limit_tips:setTextById(commodityCfg.sellDescribtion,remainCount)
        end
    end

    if not isCanBuy then
        --优先判断是否能购买
        Button_buy:setVisible(true)
        Label_buy_tip:setVisible(false)
    end

    local Image_zhezhao = TFDirector:getChildByPath(item, "Image_zhezhao")
    local state = StoreDataMgr:getCommodityState(commodityId)
    Button_buy:setGrayEnabled(state ~= 1)
    Image_zhezhao:setVisible(state > 1);

    local Label_limitType_desc = TFDirector:getChildByPath(item, "Label_limitType_desc")
    local limitTypeStr = EC_StoreLimitString[commodityCfg.limitType] or ""
    --Label_limitType_desc:setTextById(limitTypeStr)
    Label_limitType_desc:setText("")
    local Image_lock = TFDirector:getChildByPath(item, "Image_lock")
    local isUnlock,isShow,openContVal = StoreDataMgr:isUnlockCommodity(commodityId)
    Image_lock:setVisible(not isUnlock)

    local Label_lock = TFDirector:getChildByPath(item, "Label_lock")
    Label_lock:setTextById(15010119,openContVal)

end

function StorePackMainView:updateData()
    self.storeIds = StoreDataMgr:getOpenStore(EC_StoreType.TWOYEAR)
    if #self.storeIds <= 0 then
        Utils:showTips(1710021)
        AlertManager:closeLayer(self)
    end
end

function StorePackMainView:updateAssets()

    local storeId = self.storeIds[self.selectIndex]
    if not storeId then
        return
    end
    local storeCfg = StoreDataMgr:getStoreCfg(storeId)
    if not storeCfg then return end
    local items = self.ListView_assets:getItems()
    local gap = #storeCfg.showCurrency - #items
    for i = 1, math.abs(gap) do
        if gap > 0 then
            local item = self.Panel_assetItem:clone()
            self.ListView_assets:pushBackCustomItem(item)
        else
            self.ListView_assets:removeItem(1)
        end
    end
    for i, v in ipairs(storeCfg.showCurrency) do
        local item = self.ListView_assets:getItem(i)
        local Image_icon = TFDirector:getChildByPath(item, "Image_icon")
        local Label_count = TFDirector:getChildByPath(item, "Label_count")
        local itemCfg = GoodsDataMgr:getItemCfg(v)
        Image_icon:setTexture(itemCfg.icon)
        Label_count:setText(GoodsDataMgr:getItemCount(v))
        Image_icon:onClick(function()
            Utils:showInfo(v, nil, true)
        end)
    end
end

function StorePackMainView:removeEvents()
    self:removeCountDownTimer()
end

function StorePackMainView:onCountDownPer(index)
    self:updateCountDonw()
end

function StorePackMainView:addCountDownTimer(storeId)
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.onCountDownPer, self))
    end
end

function StorePackMainView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
    end
end

function StorePackMainView:updateCountDonw()

    ---限时商店倒计时
    self.Label_deadLine:hide()
    for i, v in ipairs(self.storeIds) do
        local deadline = self.storeDeadLine_[v]
        if deadline then
            local remainTime = math.max(0, deadline - ServerDataMgr:getServerTime())
            if remainTime == 0 then
                self:removeStore(v)
            else
                if i == self.selectIndex then
                    local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
                    self.Label_deadLine:show()
                    self.Label_deadLine:setTextById(302203, day, hour, min)
                end
            end
        end
    end
end

---删除商店
function StorePackMainView:removeStore(storeId)

    self.storeDeadLine_[storeId] = nil
    local index = table.indexOf(self.storeIds, storeId)
    if index == -1 then
        return
    end
    self.ListView_tab_btn:removeItem(index)
    self.tabBtns[index] = nil
    if self.selectIndex == index then
        self:selectTabIdx(1)
    end
end

---更新商店配置
function StorePackMainView:onStoreCfgUpdateEvent()
    self:updateData()
    self:selectTabIdx(self.selectIndex, true)
end

function StorePackMainView:onItemUpdateEvent()
    self:updateData()
    self:updateAssets()
    self:orderCommodity(self.ruleId or 1)
end

function StorePackMainView:onRefreshEvent()
    self:updateData()
    self:orderCommodity(self.ruleId or 1)
    self:updateShowInfo()
end

function StorePackMainView:onBuyInfoUpdateEvent()
    self:updateData()
    self:orderCommodity(self.ruleId or 1)
    self:updateShowInfo()
end

function StorePackMainView:registerEvents()

    EventMgr:addEventListener(self, EV_STORE_BUYINFO_UPDATE, handler(self.onBuyInfoUpdateEvent, self))
    EventMgr:addEventListener(self, EV_STORE_REFRESH, handler(self.onRefreshEvent, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onItemUpdateEvent, self))
    EventMgr:addEventListener(self, EV_STORE_UPDATE_CFG, handler(self.onStoreCfgUpdateEvent, self))
    EventMgr:addEventListener(self, EV_OFFLINE_EVENT, handler(self.removeCountDownTimer, self))

    self.Button_sort_order:onClick(function ()
        local visible = self.Panel_order:isVisible()
        self.Panel_order:setVisible(not visible)
    end)

    for i=1,3 do
        self.orderBtn[i]:onClick(function()
            self:orderCommodity(i)
            self.Panel_order:hide()
        end)

    end

end


return StorePackMainView
