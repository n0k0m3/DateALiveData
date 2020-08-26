local KabalaTreeStore = class("KabalaTreeStore", BaseLayer)

function KabalaTreeStore:ctor(data)
    self.super.ctor(self)
    self:initData(data)
    self:showPopAnim(true)
    self:init("lua.uiconfig.kabalaTree.kabalaTreeStore")
end

function KabalaTreeStore:registerEvents()

    EventMgr:addEventListener(self,EV_UPDATE_STORE,handler(self.updateGoodsList, self))
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

function KabalaTreeStore:initData(data)

    self.storeData = TabDataMgr:getData("KabalaShop")
    self.goodsListItem = {}
    self.goodsIconMap_ = {}

    self.data = data
end

function KabalaTreeStore:initUI(ui)

    self.super.initUI(self, ui)
    self.ui = ui
    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")
    self.Label_title = TFDirector:getChildByPath(self.ui, "Label_title")
    self.Label_coin = TFDirector:getChildByPath(self.ui, "Label_coin")
    self.Image_coin = TFDirector:getChildByPath(self.ui, "Image_coin")
    self.Label_time = TFDirector:getChildByPath(self.ui, "Label_time")

    local ScrollView_kabalaTreeStore = TFDirector:getChildByPath(self.ui, "ScrollView_kabalaTreeStore")
    self.ListView_goods = UIListView:create(ScrollView_kabalaTreeStore)

    self.Image_storeItem = TFDirector:getChildByPath(self.ui, "Panel_ItemBg")
    self.Label_title:setTextById(3003011)
    self._scheduleId   = TFDirector:addTimer(1000, -1, nil, handler(self.onCountDownPer, self))

    self:updateGoodsList(self.data.newItem , self.data.nextTime)
end

function KabalaTreeStore:updateKabalaCoin()


    local itemCfg = GoodsDataMgr:getItemCfg(570101)
    if itemCfg then
        local kabalaCoin = KabalaTreeDataMgr:getKabalaCoin()
        self.Label_coin:setText(kabalaCoin)
        self.Image_coin:setScale(0.6)
        self.Image_coin:setTexture(itemCfg.icon)
    end

end

function KabalaTreeStore:updateGoodsList(newItem,nextTime)


    if nextTime then
        self.nextFreshTime = nextTime
    end

    self:onCountDownPer()
    self:updateKabalaCoin()

    self.shopItem = {}
    for k,v in ipairs(newItem) do
        local itemCfg = self.storeData[v.itemId]
        if itemCfg then
            local goodsCfg = GoodsDataMgr:getItemCfg(itemCfg.ItemId)
            if  goodsCfg.superType == EC_ResourceType.KABALA and goodsCfg.subType == Enum_KabalaItemType.ItemType_BuffItem then
                table.insert(self.shopItem,{info = v,sortId = 2})
            else
                table.insert(self.shopItem,{info = v,sortId = 1})
            end
        end
    end

    table.sort(self.shopItem,function(a,b)
        return a.sortId < b.sortId
    end)
    local useItemList = self.ListView_goods:getItems()
    local gap = #self.shopItem - #useItemList
    if gap > 0 then
        for i = 1, gap do
            local itemBg = self.Image_storeItem:clone()
            local foo = {}
            foo.root = itemBg
            foo.item = TFDirector:getChildByPath(itemBg, "Image_storeItem")
            foo.Label_ItemName = TFDirector:getChildByPath(itemBg, "Label_ItemName")
            foo.Label_buff_desc = TFDirector:getChildByPath(itemBg, "Label_buff_desc")
            foo.Label_remainCnt = TFDirector:getChildByPath(itemBg, "Label_remainCnt")
            foo.Button_buy = TFDirector:getChildByPath(itemBg, "Button_buy")
            foo.Label_btn = TFDirector:getChildByPath(foo.Button_buy, "Label_btn")
            foo.currencyIcon = TFDirector:getChildByPath(itemBg, "Image_icon")
            foo.Label_price = TFDirector:getChildByPath(itemBg, "Label_price")
            self.goodsIconMap_[itemBg] = foo
            self.ListView_goods:pushBackCustomItem(itemBg)
        end
    else
        for i = 1, math.abs(gap) do
            local itemBg = self.ListView_goods:getItem(1)
            self.goodsIconMap_[itemBg] = nil
            self.ListView_goods:removeItem(1)
        end
    end

    -- 更新商品信息
    useItemList = self.ListView_goods:getItems()
    for i, v in ipairs(useItemList) do
        self:updateGoodsItem(v, self.shopItem[i])
    end

    --[[self.ListView_goods:removeAllItems()
    for k,v in ipairs(self.shopItem) do

        local itemCfg = self.storeData[v.info.itemId]
        if itemCfg then
            local itemBg = self.Image_storeItem:clone()
            local item = TFDirector:getChildByPath(itemBg, "Image_storeItem")
            local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            Panel_goodsItem:setScale(0.8)
            PrefabDataMgr:setInfo(Panel_goodsItem, itemCfg.ItemId, 1)

            Panel_goodsItem:setPosition(ccp(0,50))
            Panel_goodsItem:setTouchEnabled(true)
            Panel_goodsItem:onClick(function()
                Utils:showInfo(itemCfg.ItemId)
            end)
            item:addChild(Panel_goodsItem)

            --类型名字
            local Label_ItemName = TFDirector:getChildByPath(itemBg, "Label_ItemName")
            local goodsCfg = GoodsDataMgr:getItemCfg(itemCfg.ItemId)
            Label_ItemName:setTextById(goodsCfg.nameTextId)

            local Label_buff_desc = TFDirector:getChildByPath(itemBg, "Label_buff_desc")
            local Label_count = Panel_goodsItem:getChildByName("Label_count")
            Label_buff_desc:setText("")
            if goodsCfg.superType == EC_ResourceType.KABALA and goodsCfg.subType == Enum_KabalaItemType.ItemType_BuffItem then
                --local frameImg = Enum_KabalaItemFrame[itemCfg.quality]
                --if not frameImg then
                    --frameImg = Enum_KabalaItemFrame[Enum_KabalaItemQuality.blue]
                --end
                --Image_frame:setTexture(frameImg)
                Label_count:setText("")
                if goodsCfg.useProfit.fix then
                    local buffId = goodsCfg.useProfit.fix.items[1].id
                    local buffInfo = KabalaTreeDataMgr:getBuffCfgInfo(buffId)
                    if buffInfo then
                        local str = TextDataMgr:getText(3004043,buffInfo.timerTypeParam)
                        Label_buff_desc:setText(str)
                    end
                end
            end

            --剩余购买次数
            local leftCnt = itemCfg.maxNum - v.info.buyCount
            leftCnt = leftCnt > 0 and leftCnt or 0
            local Label_remainCnt = TFDirector:getChildByPath(itemBg, "Label_remainCnt")
            Label_remainCnt:setTextById(3004021,leftCnt)

            local Button_buy = TFDirector:getChildByPath(itemBg, "Button_buy")
            Button_buy:setGrayEnabled(leftCnt == 0)
            Button_buy:setTouchEnabled(leftCnt ~= 0)
            local Label_btn = TFDirector:getChildByPath(Button_buy, "Label_btn")
            Label_btn:setTextById(900661)
            Button_buy:onClick(function ()
                self:butItem(k)
            end)

            --消费
            local currencyIcon = TFDirector:getChildByPath(itemBg, "Image_icon")
            local Label_price = TFDirector:getChildByPath(itemBg, "Label_price")
            local priceId,priceNum = itemCfg.price[1],itemCfg.price[2]
            local costCfg = GoodsDataMgr:getItemCfg(priceId)
            currencyIcon:setTexture(costCfg.icon)
            currencyIcon:setScale(0.3)
            Label_price:setText(priceNum)
            local isEnough = GoodsDataMgr:currencyIsEnough(priceId, priceNum)
            local color = isEnough and me.BLACK or me.RED
            Label_price:setColor(color)

            self.ListView_goods:pushBackCustomItem(itemBg)
        end
    end]]
end

function KabalaTreeStore:updateGoodsItem(itemBg, shopItemInfo)

    local foo = self.goodsIconMap_[itemBg]
    if not foo then
        return
    end

    foo.root:setVisible(false)
    local itemCfg = self.storeData[shopItemInfo.info.itemId]
    if itemCfg then
        foo.root:setVisible(true)
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:setScale(0.8)
        PrefabDataMgr:setInfo(Panel_goodsItem, itemCfg.ItemId, 1)

        Panel_goodsItem:setPosition(ccp(0,50))
        Panel_goodsItem:setTouchEnabled(true)
        Panel_goodsItem:onClick(function()
            Utils:showInfo(itemCfg.ItemId)
        end)
        foo.item:addChild(Panel_goodsItem)

        --类型名字
        local goodsCfg = GoodsDataMgr:getItemCfg(itemCfg.ItemId)
        foo.Label_ItemName:setTextById(goodsCfg.nameTextId)

        local Label_count = Panel_goodsItem:getChildByName("Label_count")
        foo.Label_buff_desc:setText("")
        if goodsCfg.superType == EC_ResourceType.KABALA and goodsCfg.subType == Enum_KabalaItemType.ItemType_BuffItem then
            --local frameImg = Enum_KabalaItemFrame[itemCfg.quality]
            --if not frameImg then
            --frameImg = Enum_KabalaItemFrame[Enum_KabalaItemQuality.blue]
            --end
            --Image_frame:setTexture(frameImg)
            Label_count:setText("")
            if goodsCfg.useProfit.fix then
                local buffId = goodsCfg.useProfit.fix.items[1].id
                local buffInfo = KabalaTreeDataMgr:getBuffCfgInfo(buffId)
                if buffInfo then
                    local str = TextDataMgr:getText(3004043,buffInfo.timerTypeParam)
                    foo.Label_buff_desc:setText(str)
                end
            end
        end

        --剩余购买次数
        local leftCnt = itemCfg.maxNum - shopItemInfo.info.buyCount
        leftCnt = leftCnt > 0 and leftCnt or 0
        foo.Label_remainCnt:setTextById(3004021,leftCnt)

        foo.Button_buy:setGrayEnabled(leftCnt == 0)
        foo.Button_buy:setTouchEnabled(leftCnt ~= 0)
        foo.Label_btn:setTextById(900661)
        foo.Button_buy:onClick(function ()
            self:butItem(shopItemInfo)
        end)

        --消费
        local priceId,priceNum = itemCfg.price[1],itemCfg.price[2]
        local costCfg = GoodsDataMgr:getItemCfg(priceId)
        foo.currencyIcon:setTexture(costCfg.icon)
        foo.currencyIcon:setScale(0.3)
        foo.Label_price:setText(priceNum)
        local isEnough = GoodsDataMgr:currencyIsEnough(priceId, priceNum)
        local color = isEnough and me.BLACK or me.RED
        foo.Label_price:setColor(color)
    end

end

function KabalaTreeStore:butItem(shopItemInfo)

    if not shopItemInfo then
        return
    end

    local itemInfo = shopItemInfo
    local itemCfg = self.storeData[itemInfo.info.itemId]
    if not itemCfg then
        return
    end

    local leftCnt = itemCfg.maxNum - itemInfo.info.buyCount
    if leftCnt <= 0 then
        Utils:showTips(3005048)
        return
    end
    self.buyItemId = itemCfg.ItemId
    self.buyItemCnt = 1
    local priceId,priceNum = itemCfg.price[1],itemCfg.price[2]
    local isEnough = GoodsDataMgr:currencyIsEnough(priceId, priceNum)
    if not isEnough then
        Utils:showTips(3005025)
        return
    end

    local msg = {
        itemInfo.info.itemId,
        self.buyItemCnt
    }
    TFDirector:send(c2s.QLIPHOTH_SHOP_PURCHASE, msg)
end

function KabalaTreeStore:stopSchedule()
    if self._scheduleId then
        TFDirector:removeTimer(self._scheduleId)
        self._scheduleId = nil
    end
end

function KabalaTreeStore:removeEvents()
    self:stopSchedule()
end


function KabalaTreeStore:onCountDownPer()

    if not self.nextFreshTime then
        return
    end
    local leftTime = self.nextFreshTime - ServerDataMgr:getServerTime()
    if leftTime <= 0 then
        self:stopSchedule()
    else
        local timeStr = self:formateTime(leftTime)
        self.Label_time:setText(timeStr)
    end
end

function KabalaTreeStore:formateTime(timeVal)
    if timeVal < 0 then
        timeVal = 0
    end
    local hour= math.floor(timeVal / 3600)
    local min = math.floor(timeVal % 86400 % 3600 / 60)
    local seconds = math.floor(timeVal % 86400 % 3600 % 60 / 1)

    return string.format("%02d:%02d:%02d", hour, min, seconds)
end

return KabalaTreeStore