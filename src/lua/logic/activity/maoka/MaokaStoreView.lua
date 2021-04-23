--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
* 
]]


local MaokaStoreView = requireNew("lua.logic.store.StoreMainView")
MaokaStoreView.__cname = "MaokaStoreView"

local function ctor(self, ...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.maokaStoreView")
end
rawset(MaokaStoreView, "ctor", ctor)

local function showStoreList(self)
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
        self.tabBtn_[i].Image_normal = TFDirector:getChildByPath(item, "Image_normal")
        self.tabBtn_[i].Label_name = TFDirector:getChildByPath(self.tabBtn_[i].Image_select, "Label_name")
        self.tabBtn_[i].Label_name1 = TFDirector:getChildByPath(self.tabBtn_[i].Image_normal, "Label_name")
        self.tabBtn_[i].Image_icon = TFDirector:getChildByPath(item, "Image_icon")
        self.tabBtn_[i].Image_touch = TFDirector:getChildByPath(item, "Image_touch")

        local storeCfg = StoreDataMgr:getStoreCfg(v)
        self.tabBtn_[i].Image_icon:setTexture(storeCfg.icon)
        self.tabBtn_[i].Label_name:setTextById(storeCfg.name)
        self.tabBtn_[i].Label_name1:setTextById(storeCfg.name)
        if self.storeDeadLine_[v] then

        end
        self.ListView_store:pushBackCustomItem(item)
    end
    self.ListView_store:scrollToItem(self.defaultSelectIndex_)
end
rawset(MaokaStoreView, "showStoreList", showStoreList)

local function selectTabBtn(self,index, force)
    if self.selectIndex_ == index and not force then return end
    self.selectIndex_ = index

    for i, v in pairs(self.tabBtn_) do
        if v then
            local isSelect = (index == i)
            v.Image_select:setVisible(isSelect)
            v.Image_normal:setVisible(not isSelect)
        end
    end

    for i, v in ipairs(self.ListView_goods) do
        v:setVisible(index == i)
    end

    self:updateGoodsList()
    self:updateShowInfo()
    self:updateCountDonw()
end
rawset(MaokaStoreView, "selectTabBtn", selectTabBtn)

local _registerEvents = MaokaStoreView.registerEvents
local function registerEvents(self)
    _registerEvents(self)

    self.Button_return = TFDirector:getChildByPath(self.ui,"Button_return")
    self.Button_return:onClick(function ( ... )
        -- body
        AlertManager:closeLayer(self)
    end)
end
rawset(MaokaStoreView, "registerEvents", registerEvents)

local function updateGoodsItem(self, item, commodityId)
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
                    if StoreDataMgr:getCommodityCfg(commodityId).extendData.date then
                        Utils:showTips(14210005,StoreDataMgr:getCommodityCfg(commodityId).extendData.date);
                    end
                end
                foo.Button_buy:setGrayEnabled(state ~= 1)
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

    foo.Button_buy:setVisible(true)
    foo.Panel_content:setVisible(true)
    foo.Label_buy_tip:setVisible(false)

    local tipId = Utils:getStoreBuyTipId(commodityCfg.extendData, 1)
    if tipId then
        foo.Button_buy:setVisible(not tipId)
        foo.Panel_content:setVisible(not tipId)
        foo.Label_buy_tip:setTextById(tipId)
        foo.Label_buy_tip:setVisible(tipId)
    end

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
        foo.Label_free:hide()
    else
        foo.Label_free:show()
    end

    local isCanBuy, remainCount = StoreDataMgr:getRemainBuyCount(commodityId)
    if isBeginBuy then
        -- 限购
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
    if not isCanBuy then
        --优先判断是否能购买
        foo.Button_buy:setVisible(true)
        foo.Panel_content:setVisible(true)
        foo.Label_buy_tip:setVisible(false)
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
rawset(MaokaStoreView, "updateGoodsItem", updateGoodsItem)

return MaokaStoreView