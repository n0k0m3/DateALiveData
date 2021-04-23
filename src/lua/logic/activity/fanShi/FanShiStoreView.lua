--[[
    @desc：FanShiStoreView
    @date: 2020-12-28 11:12:41
]]

local FanShiStoreView = class("FanShiStoreView",BaseLayer)

function FanShiStoreView:initData(activityId)
    self.activityId_ = activityId
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(activityId)
    self.storeData = {}
    local goodsData = ActivityDataMgr2:getItems(activityId)
    for i, _id in pairs(goodsData) do
        local _itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, _id)
        if not _itemInfo.extendData.hero then
            table.insert(self.storeData, _itemInfo)
        else
            self.specialItemInfo = _itemInfo
        end
    end
    -- dump(self.activityInfo_)
    -- dump(self.storeData)
end

function FanShiStoreView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.fanShiStoreView")
end

function FanShiStoreView:initUI(ui)
    self.super.initUI(self,ui)
    self.gridView = UIGridView:create(self._ui.gridView_goods)
    self.gridView:setItemModel(self._ui.Panel_storeGoodsItem)
    self.gridView:setColumn(1)

    local year, month, day = Utils:getDate(self.activityInfo_.showStartTime or 0)
	self._ui.act_timeStart:setTextById(1410001,year, month, day)
	year, month, day = Utils:getDate(self.activityInfo_.endTime or 0)
    self._ui.act_timeEnd:setTextById(1410001,year, month, day)

    self:updateLeftUI()
    self:updataGridView()
end

function FanShiStoreView:registerEvents()
   EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, function()
        self:updateLeftUI()
        self:updataGridView()
   end)
end

function FanShiStoreView:updateLeftUI()
    local _costId = tonumber(self.activityInfo_.extendData.showCurrency)
    local _cfg = GoodsDataMgr:getItemCfg(_costId)
    self._ui.lab_ItemNum:setTextById(1200001, TextDataMgr:getText(_cfg.nameTextId).. GoodsDataMgr:getItemCount(_costId))

    -- 特殊展示
    if not self.specialItemInfo then
        self._ui.panel_leftCost:hide()
        return
    else
        self._ui.panel_leftCost:show()
    end

    local goodsId, goodsCount = next(self.specialItemInfo.reward)
    if not self.specialItem then
        self.specialItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        self.specialItem:Scale(0.9)
        self.specialItem:AddTo(self._ui.panel_goods):Pos(0, 0)
    end
    PrefabDataMgr:setInfo(self.specialItem, goodsId, goodsCount)
    self._ui.lab_name:setTextById(GoodsDataMgr:getItemCfg(goodsId).nameTextId)

    local isCanBuy, remainCount = ActivityDataMgr2:getRemainBuyCount(self.activityInfo_.activityType, self.specialItemInfo.id)
    self._ui.spine_fanShiSpecial:setVisible(remainCount >= 1)
    self._ui.btn_changeGoods:setVisible(remainCount >= 1)
    self._ui.lab_completeChange:setVisible(remainCount <= 0)

    local targetId, targetNum = next(self.specialItemInfo.target)
    local costCfg = GoodsDataMgr:getItemCfg(targetId)
    self._ui.img_icon:setTexture(costCfg.icon)
    self._ui.lab_count:setText(targetNum)
    self._ui.lab_countRed:setText(targetNum)
    self._ui.lab_count:setVisible(GoodsDataMgr:currencyIsEnough(targetId, targetNum))
    self._ui.lab_countRed:setVisible(not self._ui.lab_count:isVisible())
    self._ui.btn_changeGoods:onClick(function()
        local isEnough = ActivityDataMgr2:currencyIsEnough(self.activityInfo_.activityType, self.specialItemInfo.id)
        if isEnough then
            ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId_, self.specialItemInfo.id, 1)
        else
            Utils:showTips(302200)
        end
    end)
end

function FanShiStoreView:updataGridView()
    local itemNums = #self.gridView:getItems()
    local gap = itemNums - #self.storeData
    for i = 1, math.abs(gap) do
        if gap > 0 then
            self.gridView:removeLastItem()
        else
            self.gridView:pushBackDefaultItem()
        end
    end

    for i, item in ipairs(self.gridView:getItems()) do
        local itemInfo = self.storeData[i]

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
        local img_descBg = TFDirector:getChildByPath(item, "img_descBg"):hide()
        local lab_desc = TFDirector:getChildByPath(img_descBg, "lab_desc")
        local Image_icon = TFDirector:getChildByPath(Panel_cost, "Image_icon")
        local Label_count = TFDirector:getChildByPath(Panel_cost, "Label_count")
        local Label_countRed = TFDirector:getChildByPath(Panel_cost, "Label_countRed")
        local Button_buy = TFDirector:getChildByPath(item, "Button_buy")

        if itemInfo.extendData.limitType == 1 then
            lab_desc:setTextById(270494)
        end
        -- img_descBg:setVisible(itemInfo.extendData.limitType == 1)

        local isCanBuy, remainCount = ActivityDataMgr2:getRemainBuyCount(self.activityInfo_.activityType, itemInfo.id)
        Label_countLimit:setText("")
        if itemInfo.details then
            Label_countLimit:setTextById(itemInfo.details, remainCount)
        end

        Label_buy_tip:setVisible(false)
        Button_buy:setVisible(true)
        local tipId = Utils:getStoreBuyTipId(itemInfo.extendData, 1)
        if tipId or remainCount <= 0 then
            Button_buy:setVisible(false)
            Label_buy_tip:setVisible(true)
            if tipId then
                Label_buy_tip:setTextById(13202319)
                -- Label_buy_tip:setColor(ccc3(215, 236, 252))
            end
            if remainCount <= 0 then
                Label_buy_tip:setTextById(13202320)
                -- Label_buy_tip:setColor(ccc3(40, 94, 168))
            end
        end
        Panel_cost:setVisible(not Label_buy_tip:isVisible())
        

        local targetId, targetNum = next(itemInfo.target)
        local costCfg = GoodsDataMgr:getItemCfg(targetId)
        Image_icon:setTexture(costCfg.icon)
        Image_icon:setSwallowTouch(false)
        -- Image_icon:onClick(function()
        --     Utils:showInfo(targetId)
        -- end)
        Label_count:setText(targetNum)
        Label_countRed:setText(targetNum)
        Label_count:setVisible(GoodsDataMgr:currencyIsEnough(targetId, targetNum))
        Label_countRed:setVisible(not Label_count:isVisible())

        Button_buy:onClick(function()
            local callFunc = function ()  
                local isEnough = ActivityDataMgr2:currencyIsEnough(self.activityInfo_.activityType, itemInfo.id)
                if isEnough then
                    local isEnough = ActivityDataMgr2:currencyIsEnough(self.activityInfo_.activityType, itemInfo.id)
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


return FanShiStoreView