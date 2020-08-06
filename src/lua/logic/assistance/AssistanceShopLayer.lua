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
*  好友助力
* 
]]

local AssistanceShopLayer = class("AssistanceShopLayer", BaseLayer)

function AssistanceShopLayer:ctor( data )
    self.super.ctor(self, data)
    self:initData(data)
    self:showPopAnim(true)
    self:init("lua.uiconfig.assistance.assistanceShopLayer")
end

function AssistanceShopLayer:initData( data )
    self.activityInfo = AssistanceDataMgr:getActivityStoreInfo()
    self.chooseItemIdx = 0
    self.itemNodeList = {}
end

function AssistanceShopLayer:initUI( ui )
	self.super.initUI(self, ui)
    self.rootPanel = TFDirector:getChildByPath(ui, "panel_root")
    self.uiPanel = TFDirector:getChildByPath(self.rootPanel, "panel_ui")
    self.closeBtn = TFDirector:getChildByPath(self.uiPanel, "btn_close")

    self.storeIconImg = TFDirector:getChildByPath(self.uiPanel, "img_scoreIcon")
    self.storeNumLabel = TFDirector:getChildByPath(self.uiPanel, "label_num")

    self.goodsPanel = TFDirector:getChildByPath(self.uiPanel, "panel_goods")
    local goodsScrollView = TFDirector:getChildByPath(self.uiPanel, "scrollView_goods")
    self.goodsUIListView = UIListView:create(goodsScrollView)

    local goodsModelPanel = TFDirector:getChildByPath(ui, "panel_goodsItem")
    goodsModelPanel:hide()
    self.goodsUIListView:setItemModel(goodsModelPanel)

    self:updateUI()
end

function AssistanceShopLayer:onShow( )
    self.super.onShow(self)
end

function AssistanceShopLayer:updateCostItemNum()
    local storeItemId = tonumber(self.activityInfo.extendData.showCurrency)
    local itemCfg = GoodsDataMgr:getItemCfg(storeItemId)
    self.storeIconImg:setTexture(itemCfg.icon)
    self.storeIconImg:onClick(function()
        Utils:showInfo(storeItemId)
    end)
    self.storeNumLabel:setText(GoodsDataMgr:getItemCount(storeItemId))
end

function AssistanceShopLayer:updateUI( )   
    self:updateCostItemNum()
    self:updateGoodsList()
end

function AssistanceShopLayer:registerEvents( )
	self.super.registerEvents(self)

    EventMgr:addEventListener(self, EV_RESFRIENDHELPACTIVITYPRE, handler(self.onResFriendHelpActivityPre, self))
    EventMgr:addEventListener(self, EV_RESFRIENDHELPREWARDADDRESS, handler(self.onResFriendHelpRewardAddress, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onRecvSubmitActivity, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onBagItemUpdate, self))
    
    self.closeBtn:onClick(function(sender)
        AlertManager:closeLayer(self)
    end)
end

function AssistanceShopLayer:removeEvents( )
    self.super.removeEvents(self)
end

function AssistanceShopLayer:updateGoodsList( )
    self.goodsUIListView:removeAllItems()

    if self.activityInfo == nil then return end
    local itemsData = ActivityDataMgr2:getItems(self.activityInfo.id)
    for _idx,_itemId in ipairs(itemsData) do
        local item = self.goodsUIListView:pushBackDefaultItem()
        self:udpateGood(item, _idx, _itemId)
        item:show()
        table.insert(self.itemNodeList, item)
    end 
end

function AssistanceShopLayer:udpateGood( item, idx, itemId )   
    --条目信息
    local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, itemId)

    local goodsId, goodsCount
    for k, v in pairs(itemInfo.reward) do
        goodsId = k
        goodsCount = v
        break
    end
    local goodsCfg = GoodsDataMgr:getItemCfg(goodsId)
    local nameLabel = TFDirector:getChildByPath(item, "label_name")
    nameLabel:setTextById(goodsCfg.nameTextId)

    local goodItemPanel = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    goodItemPanel:Scale(0.8)
    local headPanel = TFDirector:getChildByPath(item, "panel_head")
    headPanel:removeAllChildren()
    goodItemPanel:AddTo(headPanel):Pos(0, 0)
    PrefabDataMgr:setInfo(goodItemPanel, goodsId, goodsCount)

    -- 限购
    local timeLabel = TFDirector:getChildByPath(item, "label_time")
    local isCanBuy, remainCount = ActivityDataMgr2:getRemainBuyCount(self.activityInfo.activityType, itemId)
    if itemInfo.details then
        timeLabel:setTextById(itemInfo.details, remainCount)
    else
        timeLabel:hide()
    end

    local costPanel = TFDirector:getChildByPath(item, "panel_cost")
    costPanel.iconImg = TFDirector:getChildByPath(costPanel, "img_icon")
    costPanel.countLabel = TFDirector:getChildByPath(costPanel, "label_count")
    costPanel.countRedLabel = TFDirector:getChildByPath(costPanel, "label_countRed")

    local costId = {}
    for k, v in pairs(itemInfo.target) do
        table.insert(costId, k)
    end
    table.sort(costId, function(a, b)
        return a < b
    end)
  
    local id = costId[1]
    local num = itemInfo.target[id]
    if id and num then
        local costCfg = GoodsDataMgr:getItemCfg(id)
        costPanel.iconImg:setTexture(costCfg.icon)
        costPanel.countLabel:setText(num)
        costPanel.countRedLabel:setText(num)
        local isEnough = GoodsDataMgr:currencyIsEnough(id, num)
        costPanel.countLabel:setVisible(isEnough)
        costPanel.countRedLabel:setVisible(not isEnough)
        costPanel:show()
        Utils:adaptSize(costPanel, false, true)
        costPanel.iconImg:onClick(function()
            Utils:showInfo(id)
        end)
    end
    
    local exchangeBtn = TFDirector:getChildByPath(item, "btn_exchange")
    local exchangeLabel = TFDirector:getChildByPath(exchangeBtn, "label_exchange")
    local addressLabel = TFDirector:getChildByPath(exchangeBtn, "label_address")
    addressLabel:hide()

    if (remainCount > 0) and isCanBuy then --达成兑换条件
        exchangeLabel:show()
        addressLabel:hide()
    elseif (remainCount > 0) and (not isCanBuy) then --兑换道具不足
        exchangeLabel:show()
        addressLabel:hide()
    elseif (remainCount <= 0) and (not isCanBuy) then --兑换成功
        exchangeLabel:hide()
        addressLabel:show()
    end

    exchangeBtn:onClick(function(sender)
        self.chooseItemIdx = idx
        if isCanBuy then
            if not GoodsDataMgr:currencyIsEnough(id, num) then
                Utils:showAccess(id)
                return
            end           
            local formatStr = TextDataMgr:getText(112000132)
            local storeItemId = tonumber(self.activityInfo.extendData.showCurrency)
            local itemCfg = GoodsDataMgr:getItemCfg(storeItemId)
            local content = string.format(formatStr, itemCfg.icon, num)
            Utils:openView("common.ReConfirmTipsView", {tittle = 112000158, content = content, reType = nil, confirmCall = function()
                AssistanceDataMgr:sendReqFriendHelpActivityPre()
            end})          
        else
            AssistanceDataMgr:sendReqFriendHelpRewardAddress(goodsId)
            return
       end
    end)
end

--拉取默认地址
function AssistanceShopLayer:onResFriendHelpActivityPre( data )    
    Utils:openView("assistance.AssistanceAddrLayer", {addressData = data, itemIdx = self.chooseItemIdx})
end

--兑换地址查看
function AssistanceShopLayer:onResFriendHelpRewardAddress( data )
    Utils:openView("assistance.AssistanceAddrConfirmLayer", data)
end

--兑换成功
function AssistanceShopLayer:onRecvSubmitActivity( activityid, activitEntryId, rewards )
    if activityid == nil then return end
    if not(self.activityInfo.id == activityid) then return end
    Utils:showTips(900211)
    local itemsData = ActivityDataMgr2:getItems(activityid)
    for _idx,_itemId in ipairs(itemsData) do
        if _itemId == activitEntryId then
            self:udpateGood(self.itemNodeList[_idx], _idx, activitEntryId)
            return
        end
    end
end

function AssistanceShopLayer:onBagItemUpdate( )
    --兑换道具
    self:updateCostItemNum()
    --刷新兑换商店道具状态
    local itemsData = ActivityDataMgr2:getItems(self.activityInfo.id)
    for _idx,_itemId in ipairs(itemsData) do
        self:udpateGood(self.itemNodeList[_idx], _idx, _itemId)          
    end
end

return AssistanceShopLayer
