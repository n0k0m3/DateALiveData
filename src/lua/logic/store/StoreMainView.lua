
local StoreMainView = class("StoreMainView", BaseLayer)

function StoreMainView:initData(params)
    self.ListView_goods = {}
    self.tabBtn_ = {}
    self.defaultSelectIndex_ = 1
    self.selectIndex_ = nil
    self.goodsIconMap_ = {}
    local storeId = nil;
    local storeType = EC_StoreType.SUPPLY;
    if type(params) == "table" and table.count(params) >= 1 then
        storeId = params[1]
        storeType = params[2] or EC_StoreType.SUPPLY;
    else
        storeId = params;
    end

    self.storeData_ = StoreDataMgr:getOpenStore(storeType)

    if storeId then
        local index = table.indexOf(self.storeData_, storeId)
        if index ~= -1 then
            self.defaultSelectIndex_ = index
        end
    end

    -- 倒计时
    self.countDownTimer_ = nil

    -- 限时商店截止时间
    self.storeDeadLine_ = {}

    for i, v in ipairs(self.storeData_) do
        local rets, deadline = StoreDataMgr:isOpenTime(v)
        if rets and deadline then
            self.storeDeadLine_[v] = deadline
        end
    end

    self.storeType = storeType;
end

function StoreMainView:getClosingStateParams()
    local storeId = self.storeData_[self.selectIndex_]
    return {storeId}
end

function StoreMainView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.store.storeMainView")
end

function StoreMainView:initUI(ui)
    self:showTopBar()

    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide():show()

    local Panel_middle = TFDirector:getChildByPath(self.Panel_root, "Panel_middle")
    self.ScrollView_goodsModel = TFDirector:getChildByPath(Panel_middle, "ScrollView_goodsModel"):hide()
    self.Panel_refresh_cost = TFDirector:getChildByPath(Panel_middle, "Panel_refresh_cost")
    self.Button_refresh = TFDirector:getChildByPath(self.Panel_refresh_cost, "Button_refresh")
    self.Image_refreshIcon = TFDirector:getChildByPath(self.Panel_refresh_cost, "Image_refreshIcon")
    self.Label_refreshCount = TFDirector:getChildByPath(self.Panel_refresh_cost, "Label_refreshCount")
    self.Label_countDown = TFDirector:getChildByPath(Panel_middle, "Label_countDown")
    self.Label_countdown_time = TFDirector:getChildByPath(Panel_middle,"Label_countdown_time")

    local Panel_bottom = TFDirector:getChildByPath(self.Panel_root, "Panel_bottom")
    self.Panel_pages = TFDirector:getChildByPath(Panel_middle, "Panel_pages")
    local Panel_left = TFDirector:getChildByPath(self.Panel_root, "Panel_left")
    self.Label_deadLine = TFDirector:getChildByPath(Panel_middle, "Label_deadLine")
    local ScrollView_assets = TFDirector:getChildByPath(Panel_middle, "ScrollView_assets")
    self.ListView_assets = UIListView:create(ScrollView_assets)
    local ScrollView_store = TFDirector:getChildByPath(Panel_left, "ScrollView_store")
    self.ListView_store = UIListView:create(ScrollView_store)

    self.Panel_assetItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_assetItem")
    self.Panel_storeItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_storeItem")
    self.Panel_goodsItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_goodsItem")


    if self.storeType == EC_StoreType.ZNQ then
        self:setTopName(TextDataMgr:getText(14210004))
    end

    self:refreshView()
end

function StoreMainView:refreshView()
    self.ListView_assets:setInertiaScrollEnabled(false)
    if #self.storeData_ > 0 then
        self:showStoreList()
        self:selectTabBtn(self.defaultSelectIndex_)
        self:addCountDownTimer()
    end
end

function StoreMainView:showStoreList()
    for i, v in ipairs(self.storeData_) do
        local ScrollView_goods = self.ScrollView_goodsModel:clone():show()
        ScrollView_goods:AddTo(self.ScrollView_goodsModel:getParent())
        self.ListView_goods[i] = UIListView:create(ScrollView_goods)
        self.ListView_goods[i]:setItemsMargin(5)
    end

    for i, v in ipairs(self.storeData_) do
        local item = self.Panel_storeItem:clone()

        self.tabBtn_[i] = {}
        self.tabBtn_[i].Image_select = TFDirector:getChildByPath(item, "Image_select")
        self.tabBtn_[i].Label_name = TFDirector:getChildByPath(item, "Label_name")
        self.tabBtn_[i].Image_icon = TFDirector:getChildByPath(item, "Image_icon")
        self.tabBtn_[i].Image_touch = TFDirector:getChildByPath(item, "Image_touch")

        local storeCfg = StoreDataMgr:getStoreCfg(v)
        self.tabBtn_[i].Image_icon:setTexture(storeCfg.icon)
        self.tabBtn_[i].Label_name:setTextById(storeCfg.name)
        if self.storeDeadLine_[v] then

        end

        -- local tagVisible = #storeCfg.storeLabel > 0
        -- self.tabBtn_[i].Image_tag:setVisible(tagVisible)
        -- if tagVisible then
        --     self.tabBtn_[i].Image_tag:setTexture(storeCfg.storeLabel)
        -- end

        self.ListView_store:pushBackCustomItem(item)
    end
    self.ListView_store:scrollToItem(self.defaultSelectIndex_)
end

function StoreMainView:updateKanBanNiang()
    local storeId = self.storeData_[self.selectIndex_]
    local storeCfg = StoreDataMgr:getStoreCfg(storeId)
    if not self.kanBanNiangView_ then
        self.kanBanNiangView_ = requireNew("lua.logic.common.KanBanNiangView"):new()
        self.kanBanNiangView_:setExpandVisible(false)
        self:addLayer(self.kanBanNiangView_, 1)
    end
    self.kanBanNiangView_:setRoleSetId(storeCfg.roleSet)
end

function StoreMainView:removeStore(storeId)
    self.storeDeadLine_[storeId] = nil
    local index = table.indexOf(self.storeData_, storeId)
    self.ListView_store:removeItem(index)
    self.tabBtn_[index] = nil
    if self.selectIndex_ == index then
        self:selectTabBtn(1)
    end
end

function StoreMainView:selectTabBtn(index, force)
    if self.selectIndex_ == index and not force then return end
    self.selectIndex_ = index

    for i, v in pairs(self.tabBtn_) do
        if v then
            local isSelect = (index == i)
            v.Image_select:setVisible(isSelect)
        end
    end

    for i, v in ipairs(self.ListView_goods) do
        v:setVisible(index == i)
    end

    self:updateGoodsList()
    self:updateShowInfo()
    self:updateCountDonw()
end

function StoreMainView:updateShowInfo()
    self:updateAssets()
    self:updateRefreshInfo()
end

function StoreMainView:updateAssets()
    local storeId = self.storeData_[self.selectIndex_]
    local storeCfg = StoreDataMgr:getStoreCfg(storeId)

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

function StoreMainView:updateRefreshInfo()
    local storeId = self.storeData_[self.selectIndex_]
    local storeCfg = StoreDataMgr:getStoreCfg(storeId)
    local isAutoRefresh = storeCfg.autoRefreshCorn

    self.Button_refresh:setVisible(storeCfg.manualRefresh)
    self.Panel_refresh_cost:setVisible(storeCfg.manualRefresh)
    self.Label_countDown:setTextById(302202)
    self.Label_countDown:setVisible(isAutoRefresh)

    if not storeCfg.manualRefresh then return end

    local storeInfo = StoreDataMgr:getStoreInfo(storeId)
    local count = storeInfo.todayRefreshCount + 1
    local refreshCostId = storeCfg.refreshCostId
    local itemCfg = GoodsDataMgr:getItemCfg(refreshCostId)
    local outOfTime = count > #storeCfg.refreshCostNum
    self.Button_refresh:setGrayEnabled(outOfTime)
    self.Button_refresh:setTouchEnabled(not outOfTime)
    self.Image_refreshIcon:setTexture(itemCfg.icon)
    self.Label_refreshCount:setText("x0")
    if outOfTime then return end

    local refreshCostNum = storeCfg.refreshCostNum[count]
    self.Label_refreshCount:setTextById(302201, refreshCostNum)
end

function StoreMainView:updateGoodsList()
    if #self.storeData_ < 1 then
        return
    end
    local storeId = self.storeData_[self.selectIndex_]
    local data = StoreDataMgr:getCommodity(storeId)
    local ListView_goods = self.ListView_goods[self.selectIndex_]

    -- 增加商品条目
    local useItemList = ListView_goods:getItems()
    local gap = #data - #useItemList
    if gap > 0 then
        for i = 1, gap do
            local item = self.Panel_goodsItem:clone()
            local Image_diban = TFDirector:getChildByPath(item, "Image_diban")
            local foo = {}
            foo.root = item
            foo.Image_diban= Image_diban
            foo.Label_free = TFDirector:getChildByPath(Image_diban, "Label_free")
            foo.Panel_head = TFDirector:getChildByPath(Image_diban, "Panel_head")
            foo.Spine_color_down = TFDirector:getChildByPath(foo.Panel_head, "Spine_color_down"):hide()
            foo.Spine_color_up = TFDirector:getChildByPath(foo.Panel_head, "Spine_color_up"):hide()
            foo.Image_cost_bg = TFDirector:getChildByPath(Image_diban, "Image_cost_bg")
            foo.Label_name = TFDirector:getChildByPath(Image_diban, "Label_name")
            foo.Label_countLimit = TFDirector:getChildByPath(Image_diban, "Label_countLimit"):hide()
            foo.Label_timeLimit = TFDirector:getChildByPath(Image_diban, "Label_timeLimit"):hide()
            foo.Button_buy = TFDirector:getChildByPath(item, "Button_buy")
            foo.Label_buy = TFDirector:getChildByPath(item, "Label_buy")
            foo.Image_buyTag = TFDirector:getChildByPath(foo.Button_buy, "Image_buyTag"):hide()
            foo.Label_saleNum = TFDirector:getChildByPath(foo.Image_buyTag, "Label_saleNum")
            foo.Image_open_time = TFDirector:getChildByPath(Image_diban, "Image_open_time"):hide()
            foo.Label_open_time = TFDirector:getChildByPath(foo.Image_open_time, "Label_open_time")
            foo.Image_zhezhao   = TFDirector:getChildByPath(item, "Image_zhezhao")
            local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            Panel_goodsItem:ZO(1):AddTo(foo.Panel_head)
            Panel_goodsItem:Pos(0, 0)
            foo.Panel_goodsItem = Panel_goodsItem
            foo.Panel_cost = {}
            for i = 1, 3 do
                foo.Panel_cost[i] = {}
                foo.Panel_cost[i].root = TFDirector:getChildByPath(Image_diban, "Panel_cost_" .. i)
                foo.Panel_cost[i].Image_icon = TFDirector:getChildByPath(foo.Panel_cost[i].root, "Image_icon")
                foo.Panel_cost[i].Label_count = TFDirector:getChildByPath(foo.Panel_cost[i].root, "Label_count")
                foo.Panel_cost[i].Label_countRed = TFDirector:getChildByPath(foo.Panel_cost[i].root, "Label_countRed")
            end
            self.goodsIconMap_[item] = foo
            ListView_goods:pushBackCustomItem(item)
        end
    else
        for i = 1, math.abs(gap) do
            local item = ListView_goods:getItem(1)
            self.goodsIconMap_[item] = nil
            ListView_goods:removeItem(1)
        end
    end


    -- 更新商品信息
    useItemList = ListView_goods:getItems()
    for i, v in ipairs(useItemList) do
        self:updateGoodsItem(v, data[i])
    end
end

function StoreMainView:updateGoodsItem(item, commodityId)
    local commodityCfg = StoreDataMgr:getCommodityCfg(commodityId)
    local buyBeginTime = commodityCfg.buyBeginTime
    local foo = self.goodsIconMap_[item]
    local goods = commodityCfg.goodInfo[1]
    local goodsId, goodsCount = goods.id, goods.num
    local goodsCfg = GoodsDataMgr:getItemCfg(goodsId)
    PrefabDataMgr:setInfo(foo.Panel_goodsItem, goodsId, goodsCount)

    local tagVisible = commodityCfg.tag > 0
    foo.Image_buyTag:setVisible(tagVisible)
    if tagVisible then
        foo.Label_saleNum:setText(commodityCfg.tag / 1000)
    end

    -- 开放购买时间
    local isBeginBuy = true
    if type(buyBeginTime) == "table" and buyBeginTime.year then
        local beginDate = TFDate(buyBeginTime.year, buyBeginTime.month, buyBeginTime.day, buyBeginTime.hour, buyBeginTime.min, buyBeginTime.sec)
        print(beginDate)
        local serverTime = ServerDataMgr:getServerTime()
        local serverDate = TFDate(serverTime):tolocal()
        isBeginBuy = serverDate >= beginDate
        foo.Label_open_time:setTextById(303047, buyBeginTime.month, buyBeginTime.day)
    end
    foo.Image_open_time:setVisible(not isBeginBuy)

    local costId = commodityCfg.priceType
    local costNum = commodityCfg.priceVal

    foo.Button_buy:onTouch(function(event)
            if event.name == "ended" then
                local state = StoreDataMgr:getCommodityState(commodityId)
                foo.Button_buy:setGrayEnabled(state ~= 1)
            end
        end)
    
    foo.Button_buy:onClick(function()

            local state = StoreDataMgr:getCommodityState(commodityId)
            if state ~= 1 then
                if state == 3 then
                    Utils:showTips(14210003);
                else
                    local extra = StoreDataMgr:getCommodityCfg(commodityId).extra
                    extra = json.decode(extra)
                    if extra and extra.date then
                        Utils:showTips(14210005,extra.date);
                    end
                end
                foo.Button_buy:setGrayEnabled(state ~= 1)
                return
            end 

            local isEnough = StoreDataMgr:currencyIsEnough(commodityId)
            if isBeginBuy then
                if isEnough then
                    if goodsCfg.superType == EC_ResourceType.DRESS 
                    or goodsCfg.superType == EC_ResourceType.REWARD then
                        if GoodsDataMgr:getItemCount(goodsId) > 0 then
                            Utils:openView("store.RepeatBuyTipsView", commodityId)
                        else
                            Utils:openView("store.BuyConfirmView", commodityId)
                        end
                    -- 大富翁道具卡     
                    elseif (goodsCfg.superType == EC_ResourceType.DFW_NEW_CARD) then
                        -- 超出最大拥有数量
                        if GoodsDataMgr:getItemCount(goodsId) >= goodsCfg.totalMax then
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
    end)


    local quality = goodsCfg.quality
    if goodsCfg.superType == EC_ResourceType.HERO then
        quality = goodsCfg.rarity
    end
    if quality > EC_ItemQuality.WHITE then
        local downName = string.format("effect_ui7_%s_down", quality)
        foo.Spine_color_down:show():play(downName, true)
        local upName = string.format("effect_ui7_%s_up", quality)
        foo.Spine_color_up:show():play(upName, true)
    end
    local allCostNum = 0
    for i, v in ipairs(foo.Panel_cost) do
        local id = costId[i]
        local num = costNum[i]
        if id and num and num > 0 then
            allCostNum = allCostNum + 1
            local costCfg = GoodsDataMgr:getItemCfg(id)
            v.Image_icon:setTexture(costCfg.icon)
            v.Label_count:setText(num)
            v.Label_countRed:setText(num)
            local isEnough = GoodsDataMgr:currencyIsEnough(id, num)
            v.Label_countRed:setVisible(not isEnough)
            v.Label_count:setVisible(isEnough)
            v.root:show()
            Utils:adaptSize(v.root, false, true)
            v.Image_icon:onClick(function()
                    Utils:showInfo(id)
            end)
        else
            v.root:hide()
        end
    end
    --所有消耗总和为0显示免费
    if allCostNum > 0 then
        foo.Image_diban:setTexture("ui/store/new_ui/new_05.png")
        foo.Label_free:hide()
        foo.Image_cost_bg:show()
    else
        foo.Image_diban:setTexture("ui/store/new_ui/001.png")
        foo.Label_free:show()
        foo.Image_cost_bg:hide()
    end

    if #costId > 1 then
        foo.Image_cost_bg:setSize(CCSizeMake(194, 120))
    else
        foo.Image_cost_bg:setSize(CCSizeMake(194, 60))
    end

    if isBeginBuy then
        -- 限购
        local isCanBuy, remainCount = StoreDataMgr:getRemainBuyCount(commodityId)
        local visible = #commodityCfg.sellDescribtion > 0
        foo.Label_countLimit:setVisible(visible)
        if foo.Label_countLimit.__richText then
            foo.Label_countLimit.__richText:setVisible(visible)
        end
        if visible then
            foo.Label_countLimit:setTextById(commodityCfg.sellDescribtion, remainCount)
        end
        foo.Button_buy:setGrayEnabled(not isCanBuy)
        foo.Button_buy:setTouchEnabled(isCanBuy)
    end
    if commodityCfg.storeId == 190000 and LeagueDataMgr:getUnionLevel() < commodityCfg.openContVal then
        foo.Button_buy:setGrayEnabled(true)
        foo.Button_buy:setTouchEnabled(false)
        foo.Label_countLimit:setVisible(true)
        foo.Label_countLimit:setTextById("r2007", commodityCfg.openContVal)
    end

    local state = StoreDataMgr:getCommodityState(commodityId)
    foo.Button_buy:setGrayEnabled(state ~= 1)
    if state ~= 1 then
        foo.Button_buy:setDefaultClickEffectType(CLICKEFFECTTYPE_NONE);
    end

    foo.Image_zhezhao:setVisible(state > 1);
    foo.Label_name:setTextById(goodsCfg.nameTextId)
end

function StoreMainView:registerEvents()
    EventMgr:addEventListener(self, EV_STORE_BUYINFO_UPDATE, handler(self.onBuyInfoUpdateEvent, self))
    EventMgr:addEventListener(self, EV_STORE_REFRESH, handler(self.onRefreshEvent, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onItemUpdateEvent, self))
    EventMgr:addEventListener(self, EV_STORE_UPDATE_CFG, handler(self.onStoreCfgUpdateEvent, self))

    for i, v in ipairs(self.tabBtn_) do
        v.Image_touch:onClick(function()
                self:selectTabBtn(i)
        end)
    end

    self.Button_refresh:onClick(function()
            local storeId = self.storeData_[self.selectIndex_]
            local storeCfg = StoreDataMgr:getStoreCfg(storeId)
            local storeInfo = StoreDataMgr:getStoreInfo(storeId)
            local count = storeInfo.todayRefreshCount + 1
            local refreshCostId = storeCfg.refreshCostId
            local refreshCostNum = storeCfg.refreshCostNum[count]
            if GoodsDataMgr:currencyIsEnough(refreshCostId, refreshCostNum) then
                local function reaFresh()
                    TFDirector:send(c2s.STORE_REFRESH_STORE, {storeId})
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

function StoreMainView:removeEvents()
    self:removeCountDownTimer()
end

function StoreMainView:onCountDownPer(index)
    self:updateCountDonw()
end

function StoreMainView:addCountDownTimer(storeId)
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.onCountDownPer, self))
    end
end

function StoreMainView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
    end
end

function StoreMainView:updateCountDonw()
    local storeId = self.storeData_[self.selectIndex_]
    -- 商店刷新倒计时
    local storeInfo = StoreDataMgr:getStoreInfo(storeId)
    local remainTime = math.max(0, storeInfo.nextRefreshTime - ServerDataMgr:getServerTime())
    local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
    -- local timeVec = string.split(TextDataMgr:getTextAttr(302202).text,"：")
    if day == "00" then
        self.Label_countdown_time:setTextById(800027, hour, min)
    else
        self.Label_countdown_time:setTextById(800044, day, hour, min)
    end
    -- 限时商店倒计时
    self.Label_deadLine:hide()
    for i, v in ipairs(self.storeData_) do
        local deadline = self.storeDeadLine_[v]
        if deadline then
            local remainTime = math.max(0, deadline - ServerDataMgr:getServerTime())
            if remainTime == 0 then
                self:removeStore(v)
            else
                if i == self.selectIndex_ then
                    local _, hour, min = Utils:getFuzzyDHMS(remainTime, true)
                    self.Label_deadLine:setTextById(302203, hour, min)
                    self.Label_deadLine:show()
                end
            end

        -- else
        --     self.Label_deadLine:hide()
        end
    end
end

function StoreMainView:onBuyInfoUpdateEvent()
    self:updateGoodsList()
    self:updateShowInfo()
end

function StoreMainView:onRefreshEvent(storeId)
    self:updateRefreshInfo()
    self:updateGoodsList()
    self:updateShowInfo()
end

function StoreMainView:onClose()
    self.super.onClose(self)
end

function StoreMainView:onItemUpdateEvent()
    self:updateAssets()
    self:updateGoodsList()
end

function StoreMainView:onStoreCfgUpdateEvent()
    self:selectTabBtn(self.selectIndex_, true)
end

return StoreMainView
