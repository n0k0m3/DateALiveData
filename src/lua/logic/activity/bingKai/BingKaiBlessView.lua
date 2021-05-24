--[[
    @desc：BingKaiBlessView
    @date: 2021-03-24 14:30:46
]]

local BingKaiBlessView = class("BingKaiBlessView",BaseLayer)

function BingKaiBlessView:initData(activityId)
    self.activityId = activityId
    self.activityInfo = ActivityDataMgr2:getActivityInfo(activityId)

    self.itemIds = self.activityInfo.items
    self.selectIdx = nil
    dump(self.activityInfo)
    Utils:setLocalSettingValue("BingKaiBlessViewRed", "true")
end

function BingKaiBlessView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.bingKaiBlessView")
end

function BingKaiBlessView:initUI(ui)
    self.super.initUI(self,ui)
    local year, month, day = Utils:getDate(self.activityInfo.showStartTime or 0)
	self._ui.act_timeStart:setTextById(1410001,year, month, day)
	year, month, day = Utils:getDate(self.activityInfo.endTime or 0)
    self._ui.act_timeEnd:setTextById(1410001,year, month, day)

    self._ui.lab_desc:setTextById(63905)

    self.gridView = UIGridView:create(self._ui.ScrollView_Item)
    self.gridView:setItemModel(self._ui.panel_item)
    self.gridView:setColumn(4)
    self.gridView:setColumnMargin(5)
    self.gridView:setRowMargin(5)

    self:refreshGridView()
    self:initLive2dModel()
    self:refreshOthers()
end

function BingKaiBlessView:registerEvents()
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.refreshOthers, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, function()
        self:refreshGridView()
        self:refreshOthers()
    end)

    self._ui.btn_get:onClick(function()
        if not self.selectIdx then
            Utils:showTips(63920)
            return  
        end
        
        ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityInfo.id, self.itemIds[self.selectIdx], 1)
    end)
end

function BingKaiBlessView:onSubmitSuccessEvent(activityID, Entry, reward)
    if activityID == self.activityId then
        self.selectIdx = nil
        self:refreshGridView()
        self:refreshOthers()
        Utils:showReward(reward, nil, function()
            self:playRoleAct()
        end)
	end
end

function BingKaiBlessView:refreshGridView()
    self.gridView:AsyncUpdateItem(self.itemIds, function (item, itemId, idx)
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, itemId)
        if not itemInfo then
            return
        end
        local status = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, itemId).status
        local isCanBuy, remainCount = ActivityDataMgr2:getRemainBuyCount(self.activityInfo.activityType, itemId)

        local lab_itemName = item:getChildByName("lab_itemName")
        local panel_goods = item:getChildByName("panel_goods")
        item.imgSelectGoods = item:getChildByName("imgSelectGoods")
        local img_getted = item:getChildByName("img_getted") 

        lab_itemName:setText(itemInfo.name)

        if not item.goods then
            item.goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            item.goods:Scale(1.0)
            item.goods:getChildByName("Image_icon"):setScale(1.1)
            -- item.goods:getChildByName("Image_frame"):setVisible(false)
            item.goods:AddTo(panel_goods):Pos(0, 0)
        end
        local rewardId, num = next(itemInfo.reward)
        PrefabDataMgr:setInfo(item.goods, rewardId)

        item.imgSelectGoods:setVisible(self.selectIdx and self.selectIdx == idx)
        img_getted:setVisible(not isCanBuy)

        item.goods:setTouchEnabled(isCanBuy)
        item.goods:onClick(function()
            self.selectIdx = idx
            if not self.keepSelectItem then
                item.imgSelectGoods:show()
                self.keepSelectItem = item
            else
                self.keepSelectItem.imgSelectGoods:hide()
                item.imgSelectGoods:show()
            end
            self.keepSelectItem = item
            self:refreshOthers()
        end)
    end)
end

function BingKaiBlessView:initLive2dModel()
    local dressId = self.activityInfo.extendData.hero.dressId
    local modelId 
    local dressData = TabDataMgr:getData("Dress")[dressId]
    if dressData and dressData.type and dressData.type == 2 then
        modelId = dressData.highRoleModel
    else
        modelId = dressData.roleModel
    end
    local elvesNpcTable = ElvesNpcTable:createLive2dNpcID(modelId)
    if not elvesNpcTable then
        return
    else
        self.elvesNpc = elvesNpcTable.live2d
    end
    self.elvesNpc:registerEvents()
    self.elvesNpc:setScale(0.55)
    self.elvesNpc:AddTo(self._ui.panle_Live2d):Pos(ccp(0, 0))
end

function BingKaiBlessView:refreshOthers()
    local costId = tonumber(self.activityInfo.extendData.showCurrency)
    local itemCount = GoodsDataMgr:getItemCount(costId)
    self._ui.lab_showTimes:setTextById(63910, itemCount, GoodsDataMgr:getItemCfg(costId).totalMax)
    self._ui.btn_get:setTouchEnabled(itemCount > 0)
    self._ui.btn_get:setGrayEnabled(itemCount <= 0) 
end

function BingKaiBlessView:playRoleAct()
    if not self.elvesNpc then
        return
    end

    local actNames = self.activityInfo.extendData.hero.action
    local actName = actNames[math.random(1, #actNames)]
    self.elvesNpc:newStartAction(actName, EC_PRIORITY.NORMAL)
end

return BingKaiBlessView