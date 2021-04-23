--[[
    @desc：StoreSnowFestivalView
    @date: 2020-11-23 18:24:03
]]

local StoreSnowFestivalView = class("StoreSnowFestivalView",BaseLayer)

function StoreSnowFestivalView:initData(activityId)
    self.activityId_ = activityId
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    self.goodsLvDic = {}
    local goodsData = ActivityDataMgr2:getItems(self.activityId_)
    for i, _id in pairs(goodsData) do
        local _itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, _id)
        local _lv = _itemInfo.extendData.snowFesStoreLv
        if not self.goodsLvDic[_lv] then
            self.goodsLvDic[_lv] = {}
        end 
        table.insert(self.goodsLvDic[_lv], _itemInfo)
    end
    self.gridViews = {}
    self.listPanel = {}
end

function StoreSnowFestivalView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.storeSnowFestivalView")
end

function StoreSnowFestivalView:initUI(ui)
    self.super.initUI(self,ui)

    self.listGoodsView = UIListView:create(self._ui.listView_all)
    self._ui.gridView_goods:hide()

    self:initListView()
end

function StoreSnowFestivalView:registerEvents()
    EventMgr:addEventListener(self, EV_ICE_SNOW_BOOK_DATA, handler(self.updateListPanel, self))
end


function StoreSnowFestivalView:initListView()
    self.listGoodsView:removeAllItems()
    for lv, data in pairs(self.goodsLvDic) do
        local Panel_resource = self._ui.Panel_resource:clone()
        self.listPanel[lv] = Panel_resource
        self.listGoodsView:pushBackCustomItem(Panel_resource)

        local _gridView = self._ui.gridView_goods:clone()
        self.listGoodsView:pushBackCustomItem(_gridView)
        local gridView = UIGridView:create(_gridView)
        local hightDis = 10
        gridView:setItemModel(self._ui.Panel_storeGoodsItem)
        gridView:setColumn(3)
        gridView:setColumnMargin(5)
        gridView:setRowMargin(hightDis)
        gridView:setVisible(true)
        self:updateGridView(gridView, data, lv)
        _gridView:setTouchEnabled(false)
        _gridView:setBounceEnabled(false)
        local goodsHight = self._ui.Panel_storeGoodsItem:getSize().height + hightDis
        _gridView:setSize(ccs(self._ui.gridView_goods:getSize().width, math.ceil(#data / 3) * goodsHight))
        self.gridViews[lv] = gridView

        -- 底部加个空隙
        local disPanel = TFPanel:create()
        disPanel:setContentSize(ccs(20, 25))
        disPanel:setOpacity(0)
        self.listGoodsView:pushBackCustomItem(disPanel)
    end
    self:updateListPanel()
end

function StoreSnowFestivalView:updateListPanel()
    local curLv = ActivityDataMgr2:getSnowAchive("snowFesStoreLv") or 1
    for lv, panel in ipairs(self.listPanel) do
        local Image_resource = TFDirector:getChildByPath(panel, "Image_resource")
        local Image_lock = TFDirector:getChildByPath(panel, "Image_lock")
        local Label_lv = TFDirector:getChildByPath(panel, "Label_lv")
        local Label_lockLvTxt = TFDirector:getChildByPath(panel, "Label_lockLvTxt")
        local Label_lockLv = TFDirector:getChildByPath(Label_lockLvTxt, "Label_lockLv")

        Image_resource:setVisible(curLv >= lv)
        Image_lock:setVisible(curLv < lv)
        Label_lv:setVisible(curLv >= lv)
        Label_lockLvTxt:setVisible(curLv < lv)
        Label_lv:setTextById(13202313, lv)
        Label_lockLv:setText("Lv"..lv)
    end
    self.listGoodsView:doLayout()
end

function StoreSnowFestivalView:updateGridView(gridView, data, lv)
    local itemNums = #gridView:getItems()
    local gap = itemNums - #data
    for i = 1, math.abs(gap) do
        if gap > 0 then
            gridView:removeLastItem()
        else
            gridView:pushBackDefaultItem()
        end
    end

    for k, itemInfo in ipairs(data) do
        local item = gridView:getItem(k)
        item:show()
        local Label_name = TFDirector:getChildByPath(item, "Label_name")
        local goodsId, goodsCount = next(itemInfo.reward)
        local goodsCfg = GoodsDataMgr:getItemCfg(goodsId)
        Label_name:setTextById(goodsCfg.nameTextId)

        local Panel_head = TFDirector:getChildByPath(item, "Panel_head")
        if not item.Panel_goodsItem then
            item.Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            item.Panel_goodsItem:Scale(0.8)
            item.Panel_goodsItem:AddTo(Panel_head):Pos(0, 0)
        end
        PrefabDataMgr:setInfo(item.Panel_goodsItem, goodsId, goodsCount)
        
        local Panel_cost = TFDirector:getChildByPath(item, "Panel_cost_2")
        local Label_buy_tip = TFDirector:getChildByPath(item, "Label_buy_tip")
        local Label_countLimit = TFDirector:getChildByPath(item, "Label_countLimit")
        local img_descBg = TFDirector:getChildByPath(item, "img_descBg")
        local lab_desc = TFDirector:getChildByPath(img_descBg, "lab_desc")
        local Image_icon = TFDirector:getChildByPath(Panel_cost, "Image_icon")
        local Label_count = TFDirector:getChildByPath(Panel_cost, "Label_count")
        local Label_countRed = TFDirector:getChildByPath(Panel_cost, "Label_countRed")
        local Button_buy = TFDirector:getChildByPath(item, "Button_buy")

        if itemInfo.extendData.limitType == 1 then
            lab_desc:setTextById(270494)
        end
        img_descBg:setVisible(itemInfo.extendData.limitType == 1)

        local isCanBuy, remainCount = ActivityDataMgr2:getRemainBuyCount(self.activityInfo_.activityType, itemInfo.id)
        if itemInfo.details then
            Label_countLimit:setTextById(itemInfo.details, remainCount)
            Label_countLimit:show()
        else
            Label_countLimit:hide()
        end

        Label_buy_tip:setVisible(false)
        Button_buy:setVisible(true)
        local tipId = Utils:getStoreBuyTipId(itemInfo.extendData, 1)
        if tipId or remainCount <= 0 then
            Button_buy:setVisible(false)
            Label_buy_tip:setVisible(true)
            if tipId then
                Label_buy_tip:setTextById(13202319)
                Label_buy_tip:setColor(ccc3(215, 236, 252))
            end
            if remainCount <= 0 then
                Label_buy_tip:setTextById(13202320)
                Label_buy_tip:setColor(ccc3(40, 94, 168))
            end
        end
        Panel_cost:setVisible(not Label_buy_tip:isVisible())
        

        local targetId, targetNum = next(itemInfo.target)
        local costCfg = GoodsDataMgr:getItemCfg(targetId)
        Image_icon:setTexture(costCfg.icon)
        Image_icon:onClick(function()
            Utils:showInfo(targetId)
        end)
        Label_count:setText(targetNum)
        Label_countRed:setText(targetNum)
        Label_count:setVisible(GoodsDataMgr:currencyIsEnough(targetId, targetNum))
        Label_countRed:setVisible(not Label_count:isVisible())

        Button_buy:onClick(function()
            local callFunc = function ( ... )  
                local curLv = ActivityDataMgr2:getSnowAchive("snowFesStoreLv") or 1
                if curLv < lv then
                    Utils:showTips(13202314)
                    return
                end
                local isEnough = ActivityDataMgr2:currencyIsEnough(self.activityInfo_.activityType, itemInfo.id)
                if isEnough then
                    Utils:openView("activity.ActivityBuyConfirmView", self.activityId_, itemInfo.id)
                else
                    Utils:showTips(302200)
                end
            end

            local tipId = Utils:getStoreBuyTipId(itemInfo.extendData, 2) 
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

function StoreSnowFestivalView:onUpdateProgressEvent()
    self:refreshView()
end

function StoreSnowFestivalView:refreshView()
    for lv, data in pairs(self.goodsLvDic) do
        if self.gridViews[lv] then
            self:updateGridView(self.gridViews[lv], data, lv)
            self.gridViews[lv]:doLayout()
        end
    end
end

return StoreSnowFestivalView