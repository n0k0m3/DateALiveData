
local SupportStoreView = class("SupportStoreView", BaseLayer)

function SupportStoreView:initData(isEmbed)
    self.isEmbed_ = isEmbed
    self.dibanConfig_ = {
        [EC_ItemQuality.WHITE] = "ui/activity/support_store/TQZY_shangpin_bg0.png",
        [EC_ItemQuality.GREEN] = "ui/activity/support_store/TQZY_shangpin_bg1.png",
        [EC_ItemQuality.BLUE] = "ui/activity/support_store/TQZY_shangpin_bg3.png",
        [EC_ItemQuality.PURPLE] = "ui/activity/support_store/TQZY_shangpin_bg5.png",
        [EC_ItemQuality.ORANGE] = "ui/activity/support_store/TQZY_shangpin_bg4.png",
        [EC_ItemQuality.RED] = "ui/activity/support_store/TQZY_shangpin_bg6.png",
    }
    self.commodityItems_ = {}
    self.rowCount_ = 5

    local storeData = {}
    if isEmbed then
        storeData = StoreDataMgr:getOpenStore(EC_StoreType.SUPPORT_FIXED)
    else
        storeData = StoreDataMgr:getOpenStore(EC_StoreType.SUPPORT_LIMIT)
    end
    if storeData[1] then
        self.storeCid_ = storeData[1]
        self.commodityData_ = StoreDataMgr:getCommodity(self.storeCid_)
        self.storeCfg_ = StoreDataMgr:getStoreCfg(self.storeCid_)
    else
        Box("找不到特勤支援商店配置")
        self.commodityData_ = {}
    end
end

function SupportStoreView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.supportStoreView")
end

function SupportStoreView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide():show()

    self.Panel_commodityItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_commodityItem")

    self.Image_bg = TFDirector:getChildByPath(self.Panel_root, "Image_bg")
    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    local Image_scrollBar = TFDirector:getChildByPath(Image_content, "Image_scrollBar")
    local Image_scrollBarInner = TFDirector:getChildByPath(Image_scrollBar, "Image_scrollBarInner")
    local scrollBar = UIScrollBar:create(Image_scrollBar, Image_scrollBarInner)
    local ScrollView_commodity = TFDirector:getChildByPath(Image_content, "ScrollView_commodity")
    self.ListView_commodity = UIListView:create(ScrollView_commodity)
    self.ListView_commodity:setScrollBar(scrollBar)
    self.Image_plug = TFDirector:getChildByPath(Image_content, "Image_plug")
    local Image_time = TFDirector:getChildByPath(self.Panel_root, "Image_time")
    self.Label_support = TFDirector:getChildByPath(Image_time, "Label_support")
    self.Label_time = TFDirector:getChildByPath(Image_time, "Label_time")
    self.Image_cost = TFDirector:getChildByPath(self.Panel_root, "Image_cost")
    self.Label_cost_title = TFDirector:getChildByPath(self.Image_cost, "Label_cost_title")
    self.Label_cost_num = TFDirector:getChildByPath(self.Image_cost, "Label_cost_num")
    self.Image_cost_icon = TFDirector:getChildByPath(self.Image_cost, "Image_cost_icon")
    self.Button_refresh = TFDirector:getChildByPath(self.Panel_root, "Button_refresh")
    self.Label_refresh = TFDirector:getChildByPath(self.Button_refresh, "Label_refresh")

    self:refreshView()
end

function SupportStoreView:refreshView()
    self.Label_refresh:setTextById(700026)
    self.Label_cost_title:setTextById(100000113)
    self.Label_support:setTextById(277002)
    self.topLayer:setVisible(not self.isEmbed_)
    self.Image_bg:setVisible(true)
    self.Image_plug:setVisible(not self.isEmbed_)
    self.Button_refresh:setVisible(self.storeCfg_.manualRefresh)
    self.Image_cost:setVisible(self.storeCfg_.manualRefresh)

    self:updateAllCommodityItem()
    self:updateRefreshInfo()
    self:updateCountDonw()

    self:addCountDownTimer()
end

function SupportStoreView:updateRefreshInfo()
    local storeInfo = StoreDataMgr:getStoreInfo(self.storeCfg_.id)
    local outOfTime = storeInfo.todayRefreshCount + 1 > #self.storeCfg_.refreshCostNum
    local count = outOfTime and storeInfo.todayRefreshCount or storeInfo.todayRefreshCount + 1
    local refreshCostId = self.storeCfg_.refreshCostId
    local itemCfg = GoodsDataMgr:getItemCfg(refreshCostId)
    self.Button_refresh:setGrayEnabled(outOfTime)
    self.Button_refresh:setTouchEnabled(not outOfTime)
    self.Image_cost_icon:setTexture(itemCfg.icon)
    local refreshCostNum = self.storeCfg_.refreshCostNum[count]
    self.Label_cost_num:setTextById(302201, refreshCostNum)
end

function SupportStoreView:addCommodityItem()
    local Panel_commodityItem = self.Panel_commodityItem:clone()
    local foo = {}
    foo.root = Panel_commodityItem
    foo.Panel_commodity = {}
    for i = 1, 5 do
        local bar = {}
        bar.root = TFDirector:getChildByPath(foo.root, "Panel_commodity_" .. i)
        bar.Button_buy = TFDirector:getChildByPath(bar.root, "Button_buy")
        bar.Label_name = TFDirector:getChildByPath(bar.root, "Label_name")
        bar.Panel_cost = TFDirector:getChildByPath(bar.root, "Panel_cost")
        bar.Image_cost_icon = TFDirector:getChildByPath(bar.root, "Image_cost_icon")
        bar.Label_cost_num = TFDirector:getChildByPath(bar.root, "Label_cost_num")
        bar.Label_cost_num_red = TFDirector:getChildByPath(bar.root, "Label_cost_num_red")
        bar.Image_icon = TFDirector:getChildByPath(bar.root, "Image_icon")
        bar.Image_tag = TFDirector:getChildByPath(bar.root, "Image_tag"):hide()
        bar.Image_not_buy = TFDirector:getChildByPath(bar.root, "Image_not_buy")
        bar.Label_not_buy = TFDirector:getChildByPath(bar.Image_not_buy, "Label_not_buy")
        bar.Label_not_buy:setTextById(277003)

        bar.Image_limit = TFDirector:getChildByPath(bar.root, "Image_limit")
        bar.Label_limit = TFDirector:getChildByPath(bar.Image_limit, "Label_limit")
        bar.Image_sale = TFDirector:getChildByPath(bar.root, "Image_sale")
        bar.Label_sale = TFDirector:getChildByPath(bar.Image_sale, "Label_sale")
        bar.Label_count = TFDirector:getChildByPath(bar.root, "Label_count")
        foo.Panel_commodity[i] = bar
    end
    self.commodityItems_[foo.root] = foo
    self.ListView_commodity:pushBackCustomItem(foo.root)
end

function SupportStoreView:adjustCommodityItem()
    local count = #self.commodityData_
    local row = math.ceil(count / 5)
    local items = self.ListView_commodity:getItems()
    local gap = row - #items
    for i = 1, math.abs(gap) do
        if gap > 0 then
            self:addCommodityItem()
        else
            local item = self.ListView_commodity:getItem(1)
            self.commodityItems_[item] = nil
            self.ListView_commodity:removeItem(1)
        end
    end
end

function SupportStoreView:updateAllCommodityItem()
    self.commodityData_ = StoreDataMgr:getCommodity(self.storeCid_)
    self:adjustCommodityItem()
    for i, v in ipairs(self.ListView_commodity:getItems()) do
        local foo = self.commodityItems_[v]
        for j, bar in ipairs(foo.Panel_commodity) do
            local order = (i - 1) * self.rowCount_ + j
            local commodityCid = self.commodityData_[order]
            bar.root:setVisible(tobool(commodityCid))
            if bar.root:isVisible() then
                local commodityCfg = StoreDataMgr:getCommodityCfg(commodityCid)

                local goods = commodityCfg.goodInfo[1]
                local goodsId, goodsCount = goods.id, goods.num
                local goodsCfg = GoodsDataMgr:getItemCfg(goodsId)
                bar.Label_name:setTextById(goodsCfg.nameTextId)
                bar.Image_icon:setTexture(goodsCfg.icon)

                local costId = commodityCfg.priceType[1]
                local costNum = commodityCfg.priceVal[1]
                local costCfg = GoodsDataMgr:getItemCfg(costId)
                bar.Image_cost_icon:setTexture(costCfg.icon)
                bar.Label_cost_num:setText(costNum)
                bar.Label_cost_num_red:setText(costNum)
                local isEnough = GoodsDataMgr:currencyIsEnough(costId, costNum)
                bar.Label_cost_num:setVisible(isEnough)
                bar.Label_cost_num_red:setVisible(not isEnough)
                bar.Label_count:setTextById(800007, goodsCount)
                Utils:adaptSize(bar.Panel_cost, false, true)

                local isCanBuy, remainCount = StoreDataMgr:getRemainBuyCount(commodityCid)
                bar.Label_limit:setVisible(#commodityCfg.sellDescribtion > 0)
                if bar.Label_limit:isVisible() then
                    bar.Label_limit:setTextById(commodityCfg.sellDescribtion, remainCount)
                end

                local tagVisible = commodityCfg.tag > 0
                bar.Image_sale:setVisible(tagVisible)
                if tagVisible then
                    bar.Label_sale:setTextById(277004, commodityCfg.tag / 1000)
                end

                bar.Image_not_buy:setVisible(not isCanBuy)
                bar.Button_buy:setTouchEnabled(isCanBuy)
                bar.Button_buy:setTextureNormal(self.dibanConfig_[goodsCfg.quality])
                bar.Button_buy:onClick(function()
                        local isEnough = StoreDataMgr:currencyIsEnough(commodityCid)
                        if isEnough then
                            Utils:openView("store.BuyConfirmView", commodityCid)
                        else
                            Utils:showAccess(costId)
                        end
                end)
            end
        end
    end
end

function SupportStoreView:updateCountDonw()
    local storeInfo = StoreDataMgr:getStoreInfo(self.storeCid_)
    local remainTime = math.max(0, storeInfo.nextRefreshTime - ServerDataMgr:getServerTime())
    local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
    if day == "00" then
        self.Label_time:setTextById(800027, hour, min)
    else
        self.Label_time:setTextById(800044, day, hour, min)
    end
end

function SupportStoreView:registerEvents()
    EventMgr:addEventListener(self, EV_STORE_BUYINFO_UPDATE, handler(self.onBuyInfoUpdateEvent, self))
    EventMgr:addEventListener(self, EV_STORE_REFRESH, handler(self.onRefreshEvent, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onItemUpdateEvent, self))
    EventMgr:addEventListener(self, EV_STORE_UPDATE_CFG, handler(self.onStoreCfgUpdateEvent, self))

    self.Button_refresh:onClick(function()
            local storeInfo = StoreDataMgr:getStoreInfo(self.storeCfg_.id)
            local count = storeInfo.todayRefreshCount + 1
            local refreshCostId = self.storeCfg_.refreshCostId
            local refreshCostNum = self.storeCfg_.refreshCostNum[count]
            if GoodsDataMgr:currencyIsEnough(refreshCostId, refreshCostNum) then
                local function reaFresh()
                    TFDirector:send(c2s.STORE_REFRESH_STORE, {self.storeCfg_.id})
                end
                if MainPlayer:getOneLoginStatus(EC_OneLoginStatusType.ReConfirm_StoreFresh) then
                    reaFresh()
                else
                    local rstr = TextDataMgr:getTextAttr(302205)
                    local content = string.format(rstr.text, refreshCostNum, TabDataMgr:getData("Item", refreshCostId).icon)
                    Utils:openView("common.ReConfirmTipsView", {tittle = 302206, content = content, reType = EC_OneLoginStatusType.ReConfirm_StoreFresh, confirmCall = reaFresh})
                end

            else
                Utils:showAccess(refreshCostId)
            end
    end)
end

function SupportStoreView:removeEvents()
    self:removeCountDownTimer()
end

function SupportStoreView:onCountDownPer(index)
    self:updateCountDonw()
end

function SupportStoreView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.onCountDownPer, self))
    end
end

function SupportStoreView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
        self.countDownTimer_ = nil
    end
end

function SupportStoreView:onBuyInfoUpdateEvent()
    self:updateAllCommodityItem()
end

function SupportStoreView:onRefreshEvent(storeId)
    self:updateAllCommodityItem()
    self:updateRefreshInfo()
end

function SupportStoreView:onItemUpdateEvent()
    self:updateAllCommodityItem()
end

function SupportStoreView:onStoreCfgUpdateEvent()
    self:updateAllCommodityItem()
    self:updateRefreshInfo()
end

return SupportStoreView
