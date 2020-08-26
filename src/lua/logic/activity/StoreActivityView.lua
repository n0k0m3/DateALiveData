
local StoreActivityView = class("StoreActivityView", BaseLayer)

function StoreActivityView:initData(activityId)
    self.activityId_ = activityId
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    self.goodsItems_ = {}
end

function StoreActivityView:ctor(...)
    self.super.ctor(self)
    self:initData(...)

    local uiName = self.activityInfo_.extendData.uiName or "storeActivityView"
    if self.activityInfo_.extendData.activityShowType == EC_ActivityType2.FANSHI_ASSIST then
        uiName = "storeActivityViewFanshi"
    end
    self:init("lua.uiconfig.activity."..uiName)
end

function StoreActivityView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_storeGoodsItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_storeGoodsItem")

    self.Image_ad = TFDirector:getChildByPath(self.Panel_root, "Image_ad")
    self.Label_date = TFDirector:getChildByPath(self.Image_ad, "Label_date")
    self.Label_timing = TFDirector:getChildByPath(ui, "Label_timing")
    local ScrollView_goods = TFDirector:getChildByPath(self.Panel_root, "ScrollView_goods")
    self.ListView_goods = UIListView:create(ScrollView_goods)
    local Panel_resource = TFDirector:getChildByPath(self.Panel_root, "Panel_resource")
    self.Panel_asset = {}
    for i = 1, 3 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(Panel_resource, "Panel_asset_" .. i):hide()
        foo.Image_icon = TFDirector:getChildByPath(foo.root, "Image_icon")
        foo.Label_count = TFDirector:getChildByPath(foo.root, "Label_count")
        self.Panel_asset[i] = foo
    end
    self.Label_tips = TFDirector:getChildByPath(Panel_resource, "Label_tips"):hide()

    self:refreshView()
end

function StoreActivityView:updateActivity()
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    self.goodsData_ = ActivityDataMgr2:getItems(self.activityId_)

    local items = self.ListView_goods:getItems()
    local gap = #items - #self.goodsData_

    for i = 1, math.abs(gap) do
        if gap > 0 then
            local item = self.ListView_goods:getItem(1)
            self.goodsItems_[item] = nil
            self.ListView_goods:removeItem(1)
        else
            local item = self:addGoodsItem()
            self.ListView_goods:pushBackCustomItem(item)
        end
    end
    for i, v in ipairs(self.ListView_goods:getItems()) do
        self:updateGoodsItem(i)
    end

    -- local startDate = Utils:getLocalDate(self.activityInfo_.startTime)
    -- local startDateStr = startDate:fmt("%Y.%m.%d")
    -- local endDate = Utils:getLocalDate(self.activityInfo_.endTime)
    -- local endDateStr = endDate:fmt("%Y.%m.%d")

    self.Label_date:setText(Utils:getActivityDateString(self.activityInfo_.startTime, self.activityInfo_.endTime, self.activityInfo_.extendData.dateStyle))
    self.Image_ad:setTexture(self.activityInfo_.showIcon)

    local extendData = self.activityInfo_.extendData
    if extendData and extendData.showCurrency and #extendData.showCurrency > 0 then
        self.Label_tips:show()
        local asset = string.split(extendData.showCurrency, ",")
        for i, v in ipairs(asset) do
            local id = tonumber(v)
            local itemCfg = GoodsDataMgr:getItemCfg(id)
            local foo = self.Panel_asset[i]
            foo.root:show()
            foo.Image_icon:setTexture(itemCfg.icon)
            foo.Label_count:setText(GoodsDataMgr:getItemCount(id))
        end
    end

    self:updateCountDonw()
end

function StoreActivityView:addGoodsItem()
    local Panel_storeGoodsItem = self.Panel_storeGoodsItem:clone()
    local foo = {}
    foo.root = Panel_storeGoodsItem
    local Image_diban = TFDirector:getChildByPath(foo.root, "Image_diban")
    foo.Label_countLimit = TFDirector:getChildByPath(Image_diban, "Label_countLimit")
    foo.Label_name = TFDirector:getChildByPath(Image_diban, "Label_name")
    foo.Panel_head = TFDirector:getChildByPath(Image_diban, "Panel_head")

    foo.Image_back_no_stuff = TFDirector:getChildByPath(foo.root, "Image_back_no_stuff")
    foo.Image_back_active = TFDirector:getChildByPath(foo.root, "Image_back_active")

    foo.Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    foo.Panel_goodsItem:Scale(0.8)
    foo.Panel_goodsItem:AddTo(foo.Panel_head):Pos(0, 0)
    foo.Panel_cost = {}
    for i = 1, 3 do
        local bar = {}
        bar.root = TFDirector:getChildByPath(Image_diban, "Panel_cost_" .. i)
        bar.Image_di = TFDirector:getChildByPath(bar.root, "Image_di")
        bar.Image_di_red = TFDirector:getChildByPath(bar.root, "Image_di_red")
        bar.Image_icon = TFDirector:getChildByPath(bar.root, "Image_icon")
        bar.Label_count = TFDirector:getChildByPath(bar.root, "Label_count")
        bar.Label_countRed = TFDirector:getChildByPath(bar.root, "Label_countRed")
        bar.originPosY_ = bar.root:PosY()
        foo.Panel_cost[i] = bar
    end
    foo.Button_buy = TFDirector:getChildByPath(foo.root, "Button_buy")
    self.goodsItems_[foo.root] = foo

    return Panel_storeGoodsItem
end

function StoreActivityView:updateGoodsItem(index)
    local activityInfo = self.activityInfo_
    local itemId = self.goodsData_[index]
    local itemInfo = ActivityDataMgr2:getItemInfo(activityInfo.activityType, itemId)

    local item = self.ListView_goods:getItem(index)
    local foo = self.goodsItems_[item]

    local goodsId, goodsCount
    for k, v in pairs(itemInfo.reward) do
        goodsId = k
        goodsCount = v
        break
    end
    local goodsCfg = GoodsDataMgr:getItemCfg(goodsId)
    foo.Label_name:setTextById(goodsCfg.nameTextId)
    PrefabDataMgr:setInfo(foo.Panel_goodsItem, goodsId, goodsCount)

    local costId = {}
    for k, v in pairs(itemInfo.target) do
        table.insert(costId, k)
    end
    table.sort(costId, function(a, b)
                   return a < b
    end)
    local _isEnough = true
    for i, v in ipairs(foo.Panel_cost) do
        local id = costId[i]
        local num = itemInfo.target[id]
        if id and num then
            local costCfg = GoodsDataMgr:getItemCfg(id)
            v.Image_icon:setTexture(costCfg.icon)
            v.Label_count:setText(num)
            v.Label_countRed:setText(num)
            local isEnough = GoodsDataMgr:currencyIsEnough(id, num)
            v.Label_count:setVisible(isEnough)
            v.Label_countRed:setVisible(not isEnough)
            v.root:show()
            Utils:adaptSize(v.root, false, true)
            v.Image_icon:onClick(function()
                    Utils:showInfo(id)
            end)
            if v.Image_di_red then
                v.Image_di_red:setVisible(not isEnough)
            end
            if not isEnough then
                _isEnough = isEnough
            end
        else
            v.root:hide()
        end
    end

    if #costId == 1 then
        local costItem = foo.Panel_cost[1].root
        local posY = foo.Panel_cost[1].originPosY_
        costItem:PosY(posY + 36)
    elseif #costId == 2 then
        for i, v in ipairs(foo.Panel_cost) do
            local posY = v.originPosY_
            v.root:PosY(posY + 18)
        end
    end

    -- 限购
    local isCanBuy, remainCount = ActivityDataMgr2:getRemainBuyCount(activityInfo.activityType, itemId)
    if itemInfo.details then
        foo.Label_countLimit:setTextById(itemInfo.details, remainCount)
    else
        foo.Label_countLimit:hide()
    end
    foo.Button_buy:setGrayEnabled(not isCanBuy)
    foo.Button_buy:setTouchEnabled(isCanBuy)

    if foo.Image_back_no_stuff then 
        foo.Image_back_no_stuff:setVisible(not _isEnough)
    end 
    if foo.Image_back_active then 
        foo.Image_back_active:setVisible(isCanBuy and _isEnough)
    end
    foo.Button_buy:onClick(function()
            local isEnough = ActivityDataMgr2:currencyIsEnough(activityInfo.activityType, itemId)
            if isEnough then
                Utils:openView("activity.ActivityBuyConfirmView", activityInfo.id, itemId)
            else
                Utils:showTips(302200)
            end
    end)
end

function StoreActivityView:refreshView()
    self.Label_tips:setTextById(5000008)
end

function StoreActivityView:updateCountDonw()
    local isEnd = ActivityDataMgr2:isEnd(self.activityId_)
    local serverTime = ServerDataMgr:getServerTime()
    if isEnd then
        local remainTime = math.max(0, self.activityInfo_.showEndTime - serverTime)
        local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
        if day == "00" then
            self.Label_timing:setTextById("r41004", hour, min)
        else
            self.Label_timing:setTextById("r41003", day, hour)
        end
    else
        local remainTime = math.max(0, self.activityInfo_.endTime - serverTime)
        local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
        if day == "00" then
            self.Label_timing:setTextById("r41002", hour, min)
        else
            self.Label_timing:setTextById("r41001", day, hour)
        end
    end
end

function StoreActivityView:registerEvents()

end

function StoreActivityView:onSubmitSuccessEvent(activitId, itemId, reward)
    self:updateActivity()
end

function StoreActivityView:onUpdateProgressEvent()
    self:updateActivity()
end

function StoreActivityView:onUpdateCountDownEvent()
    self:updateCountDonw()
end

return StoreActivityView
