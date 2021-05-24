--[[
    @desc：BingKaiStoreView
    @date: 2021-03-24 14:30:07
]]

local BingKaiStoreView = class("BingKaiStoreView",BaseLayer)

function BingKaiStoreView:initData(activityId)
    self.activityId = activityId
    self.activityInfo = ActivityDataMgr2:getActivityInfo(activityId)
    dump(self.activityInfo)
end

function BingKaiStoreView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.bingKaiStoreView")
end

function BingKaiStoreView:initUI(ui)
    self.super.initUI(self,ui)

    local year, month, day = Utils:getDate(self.activityInfo.showStartTime or 0)
	self._ui.act_timeStart:setTextById(1410001,year, month, day)
	year, month, day = Utils:getDate(self.activityInfo.endTime or 0)
    self._ui.act_timeEnd:setTextById(1410001,year, month, day)

    self.gridGoodsView = UIGridView:create(self._ui.gridView_goods)
    self.gridGoodsView:setItemModel(self._ui.Panel_storeGoodsItem)
    self.gridGoodsView:setColumn(3)
    self.gridGoodsView:setColumnMargin(-5)
    self.gridGoodsView:setRowMargin(0)

    self._ui.Label_tips:setTextById(63830)
    self._ui.Label_tips:show()
    self:updateTopBanner()

    self:refreshStoreView()
end

function BingKaiStoreView:registerEvents()
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, function()
        self:refreshStoreView()
        self:updateTopBanner()
    end)
end

function BingKaiStoreView:updateTopBanner()
    local extendData = self.activityInfo.extendData
    if extendData and extendData.showCurrency and #extendData.showCurrency > 0 then
        local asset = string.split(extendData.showCurrency, ",")
        self._ui.Label_tips:setVisible(table.count(asset) == 1)
        for i = 1 , 6 do
            local id = tonumber(asset[i])
            local assertItem = self._ui["Panel_asset_"..i]
            if id then
                local itemCfg = GoodsDataMgr:getItemCfg(id)
                assertItem:getChildByName("Image_icon"):setTexture(itemCfg.icon)
                assertItem:getChildByName("Label_count"):setText(GoodsDataMgr:getItemCount(id))
                assertItem:setTouchEnabled(true)
                assertItem:onClick(function()
                    Utils:showInfo(id)
                end)
                assertItem:show()
            else
                assertItem:hide()
            end
        end
    end
end

function BingKaiStoreView:refreshStoreView()
    local tmpGoodsData = ActivityDataMgr2:getItems(self.activityId)
    local frontData = {}
    local hadUsedData = {}
    for i, id in ipairs(tmpGoodsData) do
        local isCanBuy = ActivityDataMgr2:getRemainBuyCount(self.activityInfo.activityType, id)
        if isCanBuy then
            table.insert(frontData, id)
        else
            table.insert(hadUsedData, id)
        end
    end
    local goodsData = frontData
    table.insertTo(goodsData, hadUsedData)

    self.gridGoodsView:AsyncUpdateItem(goodsData, function(item, itemId, idx)
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, itemId)
        local Label_countLimit = TFDirector:getChildByPath(item, "Label_countLimit")
        local img_descBg = TFDirector:getChildByPath(item, "img_descBg")
        local lab_desc = TFDirector:getChildByPath(item, "lab_desc")
        local Image_icon = TFDirector:getChildByPath(item, "Image_icon")
        local Label_count = TFDirector:getChildByPath(item, "Label_count")
        local Label_countRed = TFDirector:getChildByPath(item, "Label_countRed")
        local goodsPos = TFDirector:getChildByPath(item, "Panel_head")
        local Button_buy = TFDirector:getChildByPath(item, "Button_buy")
        local img_lock = TFDirector:getChildByPath(item, "img_lock")
        local lab_lockDesc = TFDirector:getChildByPath(img_lock, "lab_lockDesc")

        local lockDunId = itemInfo.extendData.lockDun
        local isPasslevel = true
        if lockDunId then
            local levelCfg = FubenDataMgr:getLevelCfg(lockDunId)
            if levelCfg then
                isPasslevel = FubenDataMgr:isPassPlotLevel(lockDunId)
                local extTxt = ""
                if levelCfg.difficulty == 1 then
                    extTxt = 3202028
                elseif levelCfg.difficulty == 2 then
                    extTxt = 300121
                elseif levelCfg.difficulty == 3 then
                    extTxt = 300122
                end
                if extTxt ~= "" then
                    extTxt = TextDataMgr:getText(extTxt)
                end
                lab_lockDesc:setText(extTxt..(TextDataMgr:getText(300963, FubenDataMgr:getLevelName(lockDunId))))
            end
        end
        img_lock:setVisible(not isPasslevel)

        img_descBg:hide()
        local isCanBuy, remainCount = ActivityDataMgr2:getRemainBuyCount(self.activityInfo.activityType, itemId)
        if itemInfo.details then
            Label_countLimit:setTextById(itemInfo.details, remainCount)
        else
            Label_countLimit:hide()
        end
        local goodsId, goodsNum = next(itemInfo.reward)
        local goodsCfg = GoodsDataMgr:getItemCfg(goodsId)
        TFDirector:getChildByPath(item, "Label_name"):setTextById(goodsCfg.nameTextId)
        if not item.goods then
            item.goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            item.goods:Scale(0.8)
            item.goods:AddTo(goodsPos):Pos(0, 0)
        end
        PrefabDataMgr:setInfo(item.goods, goodsId, goodsNum)

        local costId, costNum = next(itemInfo.target)
        local costCfg = GoodsDataMgr:getItemCfg(costId)
        Image_icon:setTexture(costCfg.icon)
        Label_count:setText(costNum)
        Label_countRed:setText(costNum)
        local isEnough = GoodsDataMgr:currencyIsEnough(costId, costNum)
        Label_count:setVisible(isEnough)
        Label_countRed:setVisible(not isEnough)

        Button_buy:setTouchEnabled(isCanBuy and isPasslevel)
        Button_buy:setGrayEnabled(not isCanBuy)
        Button_buy:onClick(function()
            local isEnough = ActivityDataMgr2:currencyIsEnough(self.activityInfo.activityType, itemId)
            if isEnough then
                Utils:openView("activity.ActivityBuyConfirmView", self.activityId, itemId)
            else
                Utils:showTips(302200)
            end
        end)
        return item
    end)
end

function BingKaiStoreView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activitId == activitId then
        self:refreshStoreView()
    end
end

function BingKaiStoreView:onUpdateProgressEvent()
    self:refreshStoreView()
end

return BingKaiStoreView