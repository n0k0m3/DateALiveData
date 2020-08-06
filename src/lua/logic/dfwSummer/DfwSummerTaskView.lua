
local DfwSummerTaskView = class("DfwSummerTaskView", BaseLayer)

function DfwSummerTaskView:initData()
    local store = StoreDataMgr:getStore(EC_StoreType.SUMMER)
    self.storeCid_ = store[1]
    self.storeCfg_ = StoreDataMgr:getStoreCfg(self.storeCid_)
    dump(self.storeCfg_)
    self.taskItems_ = {}
end

function DfwSummerTaskView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.dafuwong.dfwSummerTaskView")
end

function DfwSummerTaskView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_taskItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_taskItem")

    self.Button_refresh = TFDirector:getChildByPath(self.Panel_root, "Button_refresh")
    self.Label_refresh = TFDirector:getChildByPath(self.Button_refresh, "Label_refresh")
    self.Label_tip_time =TFDirector:getChildByPath(self.Button_refresh, "Label_tip_time")
    self.Image_cost = TFDirector:getChildByPath(self.Panel_root, "Image_cost")
    self.Image_cost_icon = TFDirector:getChildByPath(self.Image_cost, "Image_cost_icon")
    self.Label_cost_num = TFDirector:getChildByPath(self.Image_cost, "Label_cost_num")
    self.Panel_task = {}
    for i = 1, 3 do
        local foo = {}
        self.Panel_task[i] = TFDirector:getChildByPath(self.Panel_root, "Panel_task_" .. i)
    end

    self:refreshView()
end

function DfwSummerTaskView:initTask()
    for i, v in ipairs(self.Panel_task) do
        local foo = {}
        foo.root = self.Panel_taskItem:clone()
        foo.root:Pos(0, 0):AddTo(v)
        foo.Label_name = TFDirector:getChildByPath(foo.root, "Label_name")
        foo.Label_get_reward = TFDirector:getChildByPath(foo.root, "Label_get_reward")
        foo.Label_tips = TFDirector:getChildByPath(foo.root, "Label_tips")
        foo.Button_receive = TFDirector:getChildByPath(foo.root, "Button_receive")
        foo.Label_receive = TFDirector:getChildByPath(foo.Button_receive, "Label_receive")
        foo.Label_geted = TFDirector:getChildByPath(foo.root, "Label_geted")
        foo.Label_receive:setTextById(13210012)
        foo.Label_get_reward:setTextById(13210014)
        foo.Label_geted:setTextById(13210013)
        local Panel_reward = TFDirector:getChildByPath(foo.root, "Panel_reward")
        foo.Panel_reward = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        foo.Panel_reward:Pos(0, 0):AddTo(Panel_reward)
        local ScrollView_cost = TFDirector:getChildByPath(foo.root, "ScrollView_cost")
        foo.ListView_cost = UIListView:create(ScrollView_cost)
        self.taskItems_[i] = foo
    end

    self:updateAllTask()
end

function DfwSummerTaskView:updateAllTask()
    local commodityData = StoreDataMgr:getCommodity(self.storeCid_)
    for i, foo in ipairs(self.taskItems_) do
        local commodityCid = commodityData[i]
        local commodityCfg = StoreDataMgr:getCommodityCfg(commodityCid)
        foo.Label_name:setTextById(commodityCfg.title)
        foo.Label_tips:setTextById(commodityCfg.des)
        local goods = commodityCfg.goodInfo[1]
        local goodsCid, goodsNum = goods.id, goods.num
        PrefabDataMgr:setInfo(foo.Panel_reward, goodsCid)

        local costId = commodityCfg.priceType
        local costNum = commodityCfg.priceVal
        local count = math.min(#costId, #costNum)
        foo.ListView_cost:removeAllItems()
        for i = 1, count do
            local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            PrefabDataMgr:setInfo(Panel_goodsItem, costId[i], costNum[i])
            Panel_goodsItem:Scale(0.7)
            foo.ListView_cost:pushBackCustomItem(Panel_goodsItem)
        end
        Utils:setAliginCenterByListView(foo.ListView_cost, true)

        local isCanBuy, remainCount = StoreDataMgr:getRemainBuyCount(commodityCid)
        foo.Button_receive:setVisible(isCanBuy)
        foo.Label_geted:setVisible(not isCanBuy)

        foo.Button_receive:onClick(function()
                local isEnough = StoreDataMgr:currencyIsEnough(commodityCid)
                if isEnough then
                    StoreDataMgr:send_STORE_BUY_GOODS(commodityCid, 1)
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
        end)
    end
end

function DfwSummerTaskView:updateRefreshInfo()

    local isAutoRefresh = self.storeCfg_.autoRefreshCorn
    self.Image_cost:setVisible(isAutoRefresh)
    self.Button_refresh:setVisible(isAutoRefresh)
    if not isAutoRefresh then return end

    local storeCfg = StoreDataMgr:getStoreCfg(self.storeCid_)
    dump(storeCfg)
    local storeInfo = StoreDataMgr:getStoreInfo(self.storeCid_)
    local remainTime = math.max(0, storeInfo.nextRefreshTime - ServerDataMgr:getServerTime())
    local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
    if day == "00" then
        self.Label_tip_time:setTextById(800027, hour, min)
    else
        self.Label_tip_time:setTextById(800044, day, hour, min)
    end

    local count = storeInfo.todayRefreshCount + 1
    local refreshCostId = self.storeCfg_.refreshCostId
    local itemCfg = GoodsDataMgr:getItemCfg(refreshCostId)
    local outOfTime = count > #self.storeCfg_.refreshCostNum

    --self.Button_refresh:setGrayEnabled(outOfTime)
    --self.Button_refresh:setTouchEnabled(not outOfTime)

    self.Image_cost:setVisible(not outOfTime)

    self.Image_cost_icon:setTexture(itemCfg.icon)
    local refreshCostNum = outOfTime and 0 or self.storeCfg_.refreshCostNum[count]
    self.Label_cost_num:setText(refreshCostNum)

    self.Label_refresh:setVisible(outOfTime)
    local strId = outOfTime and 303041 or 100000131
    self.Label_refresh:setTextById(strId)
end

function DfwSummerTaskView:refreshView()
    self:initTask()
    self:updateRefreshInfo()
end

function DfwSummerTaskView:registerEvents()
    EventMgr:addEventListener(self, EV_STORE_BUYINFO_UPDATE, handler(self.onBuyInfoUpdateEvent, self))
    EventMgr:addEventListener(self, EV_STORE_REFRESH, handler(self.onRefreshEvent, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onItemUpdateEvent, self))
    EventMgr:addEventListener(self, EV_STORE_BUY_SUCCESS, handler(self.onBuySuccessEvent, self))

    self.Button_refresh:onClick(function()
            local storeInfo = StoreDataMgr:getStoreInfo(self.storeCid_)
            local count = storeInfo.todayRefreshCount + 1
            local refreshCostId = self.storeCfg_.refreshCostId
            local refreshCostNum = self.storeCfg_.refreshCostNum[count]
            if not refreshCostNum then
                Utils:showTips(303041)
                return
            end

            if GoodsDataMgr:currencyIsEnough(refreshCostId, refreshCostNum) then
                local function reaFresh()
                    TFDirector:send(c2s.STORE_REFRESH_STORE, {self.storeCid_})
                end
                if MainPlayer:getOneLoginStatus(EC_OneLoginStatusType.ReConfirm_Dafuweng) then
                    reaFresh()
                else
                    local rstr = TextDataMgr:getTextAttr(13210015)
                    local content = string.format(rstr.text, refreshCostNum, TabDataMgr:getData("Item", refreshCostId).icon)
                    Utils:openView("common.ReConfirmTipsView", {tittle = 13210016, content = content, reType = EC_OneLoginStatusType.ReConfirm_Dafuweng, confirmCall = reaFresh})
                end

            else
                Utils:showAccess(refreshCostId)
            end
    end)

end

function DfwSummerTaskView:onBuyInfoUpdateEvent()
end

function DfwSummerTaskView:onRefreshEvent(storeId)
    self:updateAllTask()
    self:updateRefreshInfo()
end

function DfwSummerTaskView:onItemUpdateEvent()

end

function DfwSummerTaskView:onBuySuccessEvent(data)
    self:updateAllTask()
    -- local commodityId = data.cid
    -- local commodityNum = data.num
    -- local commodityCfg = StoreDataMgr:getCommodityCfg(commodityId)
    -- local goods = commodityCfg.goods
    -- local goodsId, goodsCount
    -- for k, v in pairs(goods) do
    --     goodsId = k
    --     goodsCount = v
    --     break
    -- end
    -- goodsCount = goodsCount * commodityNum

    local rewardList = {}
    for k,v in pairs(data.goods) do
        table.insert(rewardList,Utils:makeRewardItem(v.id, v.num))
    end
    Utils:showReward(rewardList)
end

return DfwSummerTaskView
