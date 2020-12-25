--[[
    @desc：DepotView
    @date: 2020-10-12 15:52:51
]]

local DepotView = class("DepotView",BaseLayer)

function DepotView:initData(data)
    self.data = data
    self.isHadClicked = {}
end

function DepotView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.supplyNew.depotView")

    self:refreshView()
end

function DepotView:initUI(ui)
    self.super.initUI(self,ui)

    self.scroll_listSupply = UIGridView:create(self._ui.scroll_listSupply)
    self.scroll_listSupply:setItemModel(self._ui.panel_cell)
    self.scroll_listSupply:setColumn(3)
    self.scroll_listSupply:setColumnMargin(6)
    self.scroll_listSupply:setRowMargin(5)

    self.scroll_listGift = UIGridView:create(self._ui.scroll_listGift)
    self.scroll_listGift:setItemModel(self._ui.panel_cell)
    self.scroll_listGift:setColumn(3)
    self.scroll_listGift:setColumnMargin(6)
    self.scroll_listGift:setRowMargin(5)

    self.scroll_listSupport = UIGridView:create(self._ui.scroll_listSupport)
    self.scroll_listSupport:setItemModel(self._ui.panel_cell)
    self.scroll_listSupport:setColumn(3)
    self.scroll_listSupport:setColumnMargin(6)
    self.scroll_listSupport:setRowMargin(5)

    self._ui.Label_timeNext:hide()
end

function DepotView:registerEvents()
    EventMgr:addEventListener(self, EV_STORE_BUYINFO_UPDATE, handler(self.updateGirdView, self))
    EventMgr:addEventListener(self, EV_STORE_REFRESH,handler(self.updateAllInfo, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.updateGirdView, self))
    EventMgr:addEventListener(self, EV_STORE_UPDATE_CFG, handler(self.updateAllInfo, self))
end

function DepotView:updateAllInfo()
    self:updateGirdView()
    self:updateRefreshInfo()
end

function DepotView:updateRefreshInfo()
    if not self.storeCfg_ then
        return
    end
    local storeInfo = StoreDataMgr:getStoreInfo(self.storeCfg_.id)
    local outOfTime = storeInfo.todayRefreshCount + 1 > #self.storeCfg_.refreshCostNum
    local count = outOfTime and storeInfo.todayRefreshCount or storeInfo.todayRefreshCount + 1
    local refreshCostId = self.storeCfg_.refreshCostId
    local itemCfg = GoodsDataMgr:getItemCfg(refreshCostId)
    self._ui.Button_refresh:setGrayEnabled(outOfTime)
    self._ui.Button_refresh:setTouchEnabled(not outOfTime)
    self._ui.img_cost_icon:setTexture(itemCfg.icon)
    local refreshCostNum = self.storeCfg_.refreshCostNum[count]
    self._ui.lab_cost_num:setTextById(302201, refreshCostNum)
    if GoodsDataMgr:currencyIsEnough(refreshCostId, refreshCostNum) then
        self._ui.lab_cost_num:setColor(me.WHITE)
    else
        self._ui.lab_cost_num:setColor(me.RED)
    end
    self._ui.Image_cost:setTouchEnabled(true)
    self._ui.Image_cost:onClick(function()
        Utils:showInfo(refreshCostId)
    end)
end

function DepotView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.onCountDownPer, self))
    end
end

function DepotView:onCountDownPer()
    local storeInfo = StoreDataMgr:getStoreInfo(self.storeCid_)
    local remainTime = math.max(0, storeInfo.nextRefreshTime - ServerDataMgr:getServerTime())
    local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
    if day == "00" then
        self._ui.Label_time:setTextById(800027, hour, min)
    else
        self._ui.Label_time:setTextById(800044, day, hour, min)
    end

    -- local _bool = false
    -- if self.data.id == 4 then
    --     local storeData 
    --     local storeData = StoreDataMgr:getOpenStore(EC_StoreType.NEW_SUPPORT)
    --     if storeData[1] then
    --         local groupRefreshTime = StoreDataMgr:getStoreInfo(storeData[1]).groupRefreshTime
    --         if groupRefreshTime then
    --             local day, hour, min = Utils:getFuzzyDHMS(groupRefreshTime - ServerDataMgr:getServerTime(), true)
    --             self._ui.Label_timeNext:setTextById(800044, day, hour, min)
    --             _bool = true
    --         end
    --     end
    --     self._ui.Label_timeNext:setVisible(_bool)
    -- end
end

function DepotView:refreshView()
    local id = tonumber(self.data.id)
    self._ui.Image_show:setVisible(nil ~= self.data.bannerimg)
    if self.data.bannerimg then
        local img = "ui/supplyNew/supply/"..self.data.bannerimg..".png"
        self._ui.Image_show:setTexture(img)
    end

    local children = self._ui.Panel_base:getChildren()
    local _name = "Panel_"..id
    for i, v in ipairs(children) do
        local name = v:getName()
        v:setVisible(name == "Image_show" or name == _name)
    end

    if not self.isHadClicked[id] then
        if id == 1 then     -- 旅程补给站
            self:updateGirdView()
        end 

        if id == 2 then     -- 礼包币专属
            self:updateGirdView()
        end 

        if id == 3 and table.count(self._ui.Panel_3:getChildren()) == 0 then    -- 养成基金
            local layer = requireNew("lua.logic.supplyNew.FundNewView"):new()
            layer:AddTo(self._ui.Panel_3)
        end

        if id == 4 then  -- 特勤支援
            local storeData = StoreDataMgr:getOpenStore(EC_StoreType.NEW_SUPPORT)
            if storeData[1] then
                self.storeCid_ = storeData[1]
                self.storeCfg_ = StoreDataMgr:getStoreCfg(self.storeCid_)
            else
                Box("特勤商店未开启！")
            end
            self._ui.Button_refresh:onClick(function()
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

            self:addCountDownTimer()
            self:updateRefreshInfo()
            self:updateGirdView()
        end
        self.isHadClicked[id] = true
    end
end

function DepotView:updateGirdView()
    local id = tonumber(self.data.id)
    local data = nil
    local girdView = nil

    if id == 1 then
        girdView = self.scroll_listSupply
        data = StoreDataMgr:getCommodity(100000)
    end

    if id == 2 then
        girdView = self.scroll_listGift
        local realData = {}
        local serverTime = ServerDataMgr:getServerTime()
        for k,v in ipairs(RechargeDataMgr:getGiftListByType(21)) do
            if v.startDate and v.endDate then
                if serverTime >= v.startDate and serverTime < v.endDate then
                    table.insert(realData, v)
                end
            else
                table.insert(realData, v)
            end
        end
        if #realData ~= 0 then
            data = realData
        end
        self._ui.lab_noData:setVisible(nil == data)
    end

    if id == 4 then
        girdView = self.scroll_listSupport
        data = StoreDataMgr:getCommodity(self.storeCid_)
    end

    if not girdView then
        return
    end

    girdView:initParams()
    girdView:doLayout()
    if not data then
        girdView:setVisible(false)
        return
    end

    local items = girdView:getItems()
    local gap = #data - #items
    if gap > 0 then
        for i = 1, math.abs(gap) do
            girdView:pushBackDefaultItem()
        end
    else
        for i = 1, math.abs(gap) do
            girdView:removeItem(1)
        end
    end

    local items = girdView:getItems()
    for i, item in ipairs(items) do
        local _data = data[i]
        if _data then
            item:show()
            local commodityCfg
            self:updateItem(item, _data)
        end
    end
end

function DepotView:updateItem(item, _data)
    local id = tonumber(self.data.id)
    local commodityCfg
    local Button_buy = TFDirector:getChildByPath(item, "Button_buy")
    local img_limitDi = TFDirector:getChildByPath(item, "img_limitDi")
    local Label_limit = TFDirector:getChildByPath(img_limitDi, "Label_limit")
    local img_di = TFDirector:getChildByPath(item, "img_di")
    local Label_tips = TFDirector:getChildByPath(item, "Label_tips"):hide()

    if id == 4 or id == 1 then
        commodityCfg = StoreDataMgr:getCommodityCfg(_data)
        local isCanBuy, remainCount = StoreDataMgr:getRemainBuyCount(_data)
        img_limitDi:setVisible(#commodityCfg.sellDescribtion > 0)
        if img_limitDi:isVisible() then
            Label_limit:setTextById(commodityCfg.sellDescribtion, remainCount)
        end

        Button_buy:setTouchEnabled(isCanBuy)
        img_di:setGrayEnabled(not isCanBuy)
        Button_buy:onClick(function()
                local isEnough = StoreDataMgr:currencyIsEnough(_data)
                if isEnough then
                    Utils:openView("store.BuyConfirmView", _data)
                else
                    Utils:showAccess(commodityCfg.priceType[1])
                end
        end)
    elseif id == 2 then
        commodityCfg = _data
        commodityCfg.goodInfo = _data.item
        commodityCfg.priceType = {_data.exchangeCost[1].id}
        commodityCfg.priceVal = {_data.exchangeCost[1].num}
        local _str = commodityCfg.buyCount - RechargeDataMgr:getBuyCount(commodityCfg.rechargeCfg.id).."/"..commodityCfg.buyCount
        Label_limit:setTextById("r2008", _str)
        Label_tips:show()
        Label_tips:setText(commodityCfg.des2)
        
        Button_buy:onClick(function()
            if commodityCfg.buyCount ~= 0 and commodityCfg.buyCount - RechargeDataMgr:getBuyCount(commodityCfg.rechargeCfg.id) <= 0 then
                Utils:showTips(800117)
                return
            end
            RechargeDataMgr:getOrderNO(commodityCfg.rechargeCfg.id)
        end)
    end
   
    local Label_name = TFDirector:getChildByPath(item, "Label_name")
    local Panel_cost = TFDirector:getChildByPath(item, "Panel_cost")
    local Image_cost_icon = TFDirector:getChildByPath(item, "Image_cost_icon")
    local Label_cost_num = TFDirector:getChildByPath(item, "Label_cost_num")
    local Label_cost_num_red = TFDirector:getChildByPath(item, "Label_cost_num_red")
    local Image_icon = TFDirector:getChildByPath(item, "Image_icon")
    local Image_tag = TFDirector:getChildByPath(item, "Image_tag"):hide()
    local Image_not_buy = TFDirector:getChildByPath(item, "Image_not_buy"):hide()
    local Label_not_buy = TFDirector:getChildByPath(Image_not_buy, "Label_not_buy")
    Label_not_buy:setTextById(277003)
    local Image_sale = TFDirector:getChildByPath(item, "Image_sale")
    local Label_sale = TFDirector:getChildByPath(Image_sale, "Label_sale")
    local Label_count = TFDirector:getChildByPath(item, "Label_count"):hide()

    local goods = commodityCfg.goodInfo[1]
    local goodsId, goodsCount = goods.id, goods.num
    local goodsCfg = GoodsDataMgr:getItemCfg(goodsId)
    Label_name:setText(commodityCfg.name)
    if not commodityCfg.name then
        Label_name:setTextById(goodsCfg.nameTextId)
    end 
    -- Image_icon:setTexture(goodsCfg.icon)
    if not item.goodItem then
        item.goodItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        item.goodItem:setScale(0.9)
        item:addChild(item.goodItem)
        item.goodItem:Pos(Image_icon:getPosition())
    end
    PrefabDataMgr:setInfo(item.goodItem, goodsId, goodsCount)

    local costId = commodityCfg.priceType[1]
    local costNum = commodityCfg.priceVal[1]
    local costCfg = GoodsDataMgr:getItemCfg(costId)

    Image_cost_icon:setTexture(costCfg.icon)
    Label_cost_num:setText(costNum)
    Label_cost_num_red:setText(costNum)
    local isEnough = GoodsDataMgr:currencyIsEnough(costId, costNum)
    Label_cost_num:setVisible(isEnough)
    Label_cost_num_red:setVisible(not isEnough)
    Label_count:setTextById(800007, goodsCount)
    Utils:adaptSize(Panel_cost, false, true)

    if type(commodityCfg.tag) == "number" then
        local tagVisible = commodityCfg.tag > 0
        Image_sale:setVisible(tagVisible)
        if tagVisible then
            Label_sale:setTextById(277004, commodityCfg.tag / 1000)
        end
    else
        if commodityCfg.tag then
            local buyCount = RechargeDataMgr:getBuyCount(commodityCfg.rechargeCfg.id)
            if buyCount == 0 then
                Label_sale:setText(commodityCfg.tagDes)
            elseif commodityCfg.tagDes2 ~= "" then
                Label_sale:setText(commodityCfg.tagDes2)
            else
                Image_title_di:hide()
            end
            Image_sale:setVisible(true)
        else
            Image_sale:setVisible(false)
        end 
    end
   
    -- Image_not_buy:setVisible(not isCanBuy)
end

function DepotView:removeEvents()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
        self.countDownTimer_ = nil
    end
end

return DepotView