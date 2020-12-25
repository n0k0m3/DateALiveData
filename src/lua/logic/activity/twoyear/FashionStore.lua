local FashionStore = class("FashionStore", BaseLayer)

function FashionStore:initData()

    local activityIds = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.TWOYEAR_FASHION_STORE)
    if activityIds and activityIds[1] then
        self.activityId = activityIds[1]
        local activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
        if activityInfo then
            dump(activityInfo)
            self.giftId = activityInfo.extendData.giftId
            self.showItem = activityInfo.extendData.showItem
            self.refreshItemData = activityInfo.extendData.refreshItem
            self.dressId = activityInfo.extendData.dressId
            self.costId = activityInfo.extendData.cost
            self.activityInfo_ = activityInfo
            dump(activityInfo.extendData,"extendData")
        end
    end
    self.freeCount = 0
    self.leftCount = 0
end

function FashionStore:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.fashionStore")
end

function FashionStore:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.fashionStoreInfo_ = {}
    for i=1,2 do
        local btn = TFDirector:getChildByPath(self.Panel_root, "Button_type_"..i)
        local select = TFDirector:getChildByPath(btn, "Image_select")
        local Label_btn = TFDirector:getChildByPath(btn, "Label_btn")
        Label_btn:setSkewX(10)
        local Panel_info = TFDirector:getChildByPath(self.Panel_root, "Panel_info"..i)
        table.insert(self.fashionStoreInfo_,{btn = btn,select = select,Label_btn = Label_btn,pl = Panel_info})
    end

    self.Label_time_tip = TFDirector:getChildByPath(self.Panel_root, "Label_time_tip")
    self.Label_time_begin = TFDirector:getChildByPath(self.Panel_root, "Label_time_begin")
    self.Label_time_end = TFDirector:getChildByPath(self.Panel_root, "Label_time_end")
    self.Label_time_begin:setSkewX(10)
    self.Label_time_end:setSkewX(10)
    self.Label_time_tip:setSkewX(10)

    ---pannel1
    self.panel_content = TFDirector:getChildByPath(self.Panel_root, "Panel_content")
    self.Panel_live2d = TFDirector:getChildByPath(self.Panel_root, "panel_roleModel")
    self.Image_dressBg = TFDirector:getChildByPath(self.Panel_root, "image_bg")
    self.Image_dressBg.initPosX = self.Image_dressBg:getPositionX()

    self.Spine_effectHB = TFDirector:getChildByPath(self.Panel_root,"effectHB")
    self.Spine_effectH = TFDirector:getChildByPath(self.Panel_root,"effectH")

    self.Label_fashion_tip = TFDirector:getChildByPath(self.Panel_root,"Label_fashion_tip")
    self.Label_fashion_tip:setTextById(15010182)

    self.fashionItemTab = {}
    for i=1,3 do
        self.fashionItemTab[i] = TFDirector:getChildByPath(self.Panel_root,"Image_fashionItem"..i)
    end

    self.Button_fashionBuy = TFDirector:getChildByPath(self.Panel_root, "Button_fashionBuy")
    self.Label_fashionBuy = TFDirector:getChildByPath(self.Button_fashionBuy, "Label_fashionBuy")

    self.Image_fashion_cost = TFDirector:getChildByPath(self.Panel_root, "Image_fashion_cost")
    self.Image_cost_icon = TFDirector:getChildByPath(self.Image_fashion_cost, "Image_cost_icon")
    self.Label_cost_num = TFDirector:getChildByPath(self.Image_fashion_cost, "Label_cost_num")

    ---pannerl2
    self.Image_curOwn = TFDirector:getChildByPath(self.Panel_root, "Image_curOwn")
    self.fresh_cost_icon = TFDirector:getChildByPath(self.Panel_root, "fresh_cost_icon")
    self.fresh_cost_num = TFDirector:getChildByPath(self.Panel_root, "fresh_cost_num")
    self.Label_refresh_time = TFDirector:getChildByPath(self.Panel_root, "Label_refresh_time")
    self.Label_refresh_cnt = TFDirector:getChildByPath(self.Panel_root, "Label_refresh_cnt")
    self.fresh_cost_tip = TFDirector:getChildByPath(self.Panel_root, "fresh_cost_tip")
    self.Label_free_fresh_tip = TFDirector:getChildByPath(self.Panel_root, "Label_free_fresh_tip")
    self.Button_help =  TFDirector:getChildByPath(self.Panel_root, "Button_help")
    self.Label_money_refresh_cnt_tip = TFDirector:getChildByPath(self.Panel_root, "Label_money_refresh_cnt_tip")
    self.Label_money_refresh_cnt_tip:setTextById(15010167)
    self.Label_money_refresh_cnt = TFDirector:getChildByPath(self.Panel_root, "Label_money_refresh_cnt")


    self.Image_ownIcon = TFDirector:getChildByPath(self.Panel_root, "Image_ownIcon")
    self.Label_cur = TFDirector:getChildByPath(self.Panel_root, "Label_cur")
    local ScrollView_fashionStore = TFDirector:getChildByPath(self.Panel_root, "ScrollView_fashionStore")
    self.UIListView_fashionStore = UIListView:create(ScrollView_fashionStore)
    self.Button_refresh = TFDirector:getChildByPath(self.Panel_root, "Button_refresh")

    self.Label_full_tip = TFDirector:getChildByPath(self.Panel_root, "Label_full_tip"):hide()
    self.Label_full_tip:setTextById(15010181)
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
    self.fashionItem = TFDirector:getChildByPath(self.Panel_prefab, "fashionItem")
    self.Image_fashion_item = TFDirector:getChildByPath(self.Panel_prefab, "Image_fashion_item")

    TFDirector:send(c2s.ANNIVERSARY2ND_REQ_ANNIV_DRESS, {})

    self:initUILogic()
end



function FashionStore:initUILogic()

    if self.activityInfo_ then
        local startDate = Utils:getLocalDate(self.activityInfo_.startTime)
        local startDateStr = startDate:fmt("%Y.%m.%d")
        local endDate = Utils:getLocalDate(self.activityInfo_.endTime)
        local endDateStr = endDate:fmt("%Y.%m.%d")
        self.Label_time_begin:setText(startDateStr)
        self.Label_time_end:setText(endDateStr)
    end

    self:initFashionPL()
    self:choosePL(1)

end

function FashionStore:initFashionPL()

    self:updateBuyRechargeGift()

    local dressTable = TabDataMgr:getData("Dress")[self.dressId]
    if dressTable then
        local modelId = dressTable.roleModel
        if dressTable.type and dressTable.type == 2 then
            modelId = dressTable.highRoleModel
        end

        self.elvesRole = ElvesNpcTable:createLive2dNpcID(modelId,false,false,nil,false).live2d
        self.elvesRole:registerEvents()


        local offPos = dressTable.offSet
        if dressTable and dressTable.type and dressTable.type == 2 then
            if offPos and offPos.x and offPos.x ~= 0 and offPos.y and offPos.y ~= 0 then
                self.elvesRole:setPosition(ccp(-50,-80) + ccp(offPos.x,offPos.y))
            else
                self.elvesRole:setPosition(ccp(-50,-80));--位置
            end
        else
            self.elvesRole:setPosition(ccp(-50,-80));--位置
        end

        self.elvesRole:setScale(0.7); --缩放
        self.Panel_live2d:addChild(self.elvesRole)

        local spbackground
        if dressTable.background and #dressTable.background ~= 0 then
            spbackground = dressTable.background
        end

        if spbackground then
            if dressTable.kanbanEffect and dressTable.kanbanEffect ~= 0 then
                self:refreshEffect(dressTable.kanbanEffect)
            else
                self.effectSK = self.effectSK or {}
                for k,v in pairs(self.effectSK) do
                    v:removeFromParent()
                    self.effectSK[k] = nil
                end
            end
            self.effectSK = self.effectSK or {}
            for k,v in pairs(self.effectSK) do
                v:show()
            end
            if dressTable.backgroundEffect and dressTable.backgroundEffect ~= 0 then
                self:refreshEffect(dressTable.backgroundEffect,true)
            else
                self.effectSKB = self.effectSKB or {}
                for k,v in pairs(self.effectSKB) do
                    v:removeFromParent()
                    self.effectSKB[k] = nil
                end
            end
            self.effectSKB = self.effectSKB or {}
            for k,v in pairs(self.effectSKB) do
                v:show()
            end
            self.Image_dressBg:setTexture(spbackground)
        else
            self.effectSK = self.effectSK or {}
            for k,v in pairs(self.effectSK) do
                v:removeFromParent()
                self.effectSK[k] = nil
            end
            self.effectSKB = self.effectSKB or {}
            for k,v in pairs(self.effectSKB) do
                v:removeFromParent()
                self.effectSKB[k] = nil
            end
        end

        local size = self.panel_content:getContentSize()
        local scale = math.max(size.width/self.Image_dressBg:getContentSize().width,size.height/self.Image_dressBg:getContentSize().height)
        self.Image_dressBg:setScale(scale)
        self.Image_dressBg:setPositionX(self.Image_dressBg.initPosX + 30)
    end
    self.showItem = self.showItem or {}
    for k,v in ipairs(self.fashionItemTab) do
        local itemId = self.showItem[k]
        if itemId then
            local itemCfg = GoodsDataMgr:getItemCfg(itemId)
            if itemCfg then
                self.fashionItemTab[k]:show()
                self.fashionItemTab[k]:setTexture(itemCfg.icon)
            end
        else
            self.fashionItemTab[k]:hide()
        end
    end
end

function FashionStore:refreshEffect(effectIds,isBgEffect)
    local mgrTab = nil
    local prefab = nil
    if not isBgEffect then
        mgrTab = self.effectSK or {}
        self.effectSK = mgrTab
        prefab = self.Spine_effectH
    else
        mgrTab = self.effectSKB or {}
        self.effectSKB = mgrTab
        prefab = self.Spine_effectHB
    end
    prefab:hide()
    for k,v in pairs(mgrTab) do
        v:removeFromParent()
        mgrTab[k] = nil
    end

    if type(effectIds) ~= "table" then
        local effectId = effectIds
        effectIds = {effectId}
    end

    for k,effectId in pairs(effectIds) do
        local effect, cfg = Utils:createEffectByEffectId(effectId)
        if effect then
            local x = (cfg["offset"]["x"] or 0)
            local y = (cfg["offset"]["y"] or 0)
            effect:setPosition(ccp(prefab:getPositionX() + x - 125, prefab:getPositionY() + y))
            effect.savePos = effect:getPosition()
            effect:setZOrder(prefab:getZOrder())
            prefab:getParent():addChild(effect)
            table.insert(mgrTab, effect)
        end
    end
end

function FashionStore:updateCost()

    local rechargeInfo = RechargeDataMgr:getOneRechargeCfg(self.giftId)
    if not rechargeInfo then
        return
    end
    local costId,costNum = rechargeInfo.exchangeCost[1].id,rechargeInfo.exchangeCost[1].num
    self:setCostInfo(self.Image_cost_icon,self.Label_cost_num,costId,costNum)

    ---计算是第几次付费刷新
    local nextPayIndex = #self.refreshItemData - self.leftCount + 1
    if nextPayIndex <= 0 then
        nextPayIndex = 1
    elseif nextPayIndex > #self.refreshItemData then
        nextPayIndex = #self.refreshItemData
    end
    print(nextPayIndex)
    local costData = self.refreshItemData[nextPayIndex]
    local refreshId,refreshCostNum
    for k,v in pairs(costData) do
        refreshId,refreshCostNum = tonumber(k),v
        break
    end
    refreshCostNum = self.freeCount > 0 and 0 or refreshCostNum
    self:setCostInfo(self.fresh_cost_icon,self.fresh_cost_num,refreshId,refreshCostNum)

    ---特殊代币显示
    self:setCostInfo(self.Image_ownIcon,self.Label_cur,self.costId)
end

function FashionStore:setCostInfo(image,label,itemId,num)
    local cfg = GoodsDataMgr:getItemCfg(itemId)
    if not cfg then
        return
    end
    num = num or GoodsDataMgr:getItemCount(itemId)
    image:setTexture(cfg.icon)
    label:setText(num)
end


function FashionStore:choosePL(index)

    if self.oldChooseIndex == index then
        return
    end

    self.oldChooseIndex = index
    if index == 2 then
        TFDirector:send(c2s.ANNIVERSARY2ND_REQ_ANNIV_DRESS, {})
    end

    for k,v in ipairs(self.fashionStoreInfo_) do
        v.select:setVisible(k == index)
        v.pl:setVisible(k == index)
        local color = k == index and ccc3(255,255,255) or ccc3(175,223,254)
        v.Label_btn:setColor(color)
        local outLineColor = k == index and ccc4(88,111,188,255) or ccc4(64,64,139,255)
        v.Label_btn:enableOutline(outLineColor,2)
    end
end

function FashionStore:updateFashionStore(fashionData)
    dump(fashionData)
    if not fashionData then
        return
    end
    dump(fashionData,"fashionData")

    self.freeCount = math.max(fashionData.leftFreeCount or 0,0)
    self.leftCount = math.max(fashionData.leftCount or 0,0)

    ---总刷新次数
    self.Button_refresh:setTouchEnabled(self.leftCount > 0)
    self.Button_refresh:setGrayEnabled(self.leftCount <= 0)

    self.Label_refresh_cnt:setText(self.freeCount)

    local moneyCnt = self.freeCount ~= 0 and math.max(self.leftCount - self.freeCount,0) or self.leftCount
    self.Label_money_refresh_cnt:setText(moneyCnt)

    self.fresh_cost_tip:setVisible(self.freeCount <= 0)
    self.Label_free_fresh_tip:setVisible(self.freeCount > 0)

    self:updateFashionGoods(fashionData.randomDress or {})

    self.Label_refresh_time:stopAllActions()
    local deadline = fashionData.nextRestTime
    local act = CCSequence:create({
        CCCallFunc:create(function()
            local remainTime = math.max(0, deadline - ServerDataMgr:getServerTime())
            local day, hour, min,sec = Utils:getDHMS(remainTime, true)
            self.Label_refresh_time:setText(hour..":"..min..":"..sec)
        end),
        CCDelayTime:create(1)
    })
    self.Label_refresh_time:runAction(CCRepeatForever:create(act))

    self:updateCost()
end

function FashionStore:updateFashionGoods(randomDress)

    self.randomDress = randomDress or {}
    self.Label_full_tip:setVisible(#self.randomDress <= 0)
    self.UIListView_fashionStore:removeAllItems()
    for k,v in ipairs(self.randomDress) do
        local fashionItem = self.fashionItem:clone()
        self.UIListView_fashionStore:pushBackCustomItem(fashionItem)
        local rechargeInfo = RechargeDataMgr:getOneRechargeCfg(self.giftId)
        if not rechargeInfo then
            return
        end
        self:updateFashionItem(fashionItem,v)
    end
    self.UIListView_fashionStore:doLayout()
end

function FashionStore:updateFashionItem(item,rechargeCid)

    local data = RechargeDataMgr:getOneRechargeCfg(rechargeCid)
    if not data then
        return
    end

    local LabelName = TFDirector:getChildByPath(item,"LabelName")
    LabelName:setText(data.name)
    LabelName:setSkewX(12)

    local cfg = GoodsDataMgr:getItemCfg(data.item[1].id)
    if not cfg then
        return
    end

    local Image_dress_title = TFDirector:getChildByPath(item,"Image_dress_title")
    Image_dress_title:setVisible(cfg.superType == EC_ResourceType.DRESS )

    local Image_ldress_title = TFDirector:getChildByPath(item,"Image_ldress_title")
    Image_ldress_title:setVisible(cfg.superType == EC_ResourceType.REWARD )

    local icon = TFDirector:getChildByPath(item,"icon")
    if cfg.superType == EC_ResourceType.DRESS then
        icon:setTexture(cfg.dressImg)
    elseif cfg.superType == EC_ResourceType.REWARD then
        icon:setTexture(cfg.skinImg)
    end


    local Detail = TFDirector:getChildByPath(item,"Detail")
    Detail:setTouchEnabled(true)
    Detail:addMEListener(TFWIDGET_CLICK,function()
        if cfg.superType == EC_ResourceType.DRESS then
            Utils:showInfo(data.item[1].id, nil, true)
        elseif cfg.superType == EC_ResourceType.REWARD then
            Utils:openView("activity.FashionPreview", data.item[1].id)
        end
    end)

    local costData = data.exchangeCost[1]
    local costCfg = GoodsDataMgr:getItemCfg(costData.id)
    local CostIcon = TFDirector:getChildByPath(item,"CostIcon")
    CostIcon:setTexture(costCfg.icon)

    local originPrice = TFDirector:getChildByPath(item,"originPrice")
    originPrice:setText(costData.num)

    local ButtonPurchase = TFDirector:getChildByPath(item,"ButtonPurchase")
    ButtonPurchase:onClick(function()
        local exchangeId = costData.id
        local isEnough = GoodsDataMgr:currencyIsEnough(exchangeId,costData.num)
        if not isEnough then
            Utils:showAccess(exchangeId)
            return;
        end
        RechargeDataMgr:getOrderNO(data.rechargeCfg.id);
    end)

    local hasCount = GoodsDataMgr:getItemCount(data.item[1].id)
    local ButtonOwn = TFDirector:getChildByPath(item,"ButtonOwn")
    if hasCount > 0 then
        ButtonOwn:show()
        ButtonPurchase:hide()
    else
        ButtonOwn:hide()
        ButtonPurchase:show()
    end

end

function FashionStore:afterBuyFashion()
    if not self.randomDress then
        return
    end
    self.Label_full_tip:setVisible(#self.randomDress <= 0)
    self.UIListView_fashionStore:removeAllItems()
    for k,v in ipairs(self.randomDress) do
        local fashionItem = self.fashionItem:clone()
        self.UIListView_fashionStore:pushBackCustomItem(fashionItem)
        local rechargeInfo = RechargeDataMgr:getOneRechargeCfg(self.giftId)
        if not rechargeInfo then
            return
        end
        self:updateFashionItem(fashionItem,v)
    end
    self.UIListView_fashionStore:doLayout()
end

function FashionStore:updateBagData()
    self:updateCost()
    self:afterBuyFashion()
end

function FashionStore:updateBuyRechargeGift()
    local isCanBuy = true
    local giftData = RechargeDataMgr:getOneRechargeCfg(self.giftId)
    if giftData.buyCount ~= 0 and giftData.buyCount - RechargeDataMgr:getBuyCount(giftData.rechargeCfg.id) <= 0 then
        isCanBuy = false
    end
    local strId = isCanBuy and 3005047 or 800070
    self.Label_fashionBuy:setTextById(strId)
    self.Image_fashion_cost:setVisible(isCanBuy)
end

function FashionStore:registerEvents()

    EventMgr:addEventListener(self, EV_BAG_DRESS_UPDATE, handler(self.updateBagData, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.updateBagData, self))
    EventMgr:addEventListener(self, EV_UPDATE_TWOYEAR_FASHION, handler(self.updateFashionStore, self))
    EventMgr:addEventListener(self, EV_RECHARGE_UPDATE, handler(self.updateBuyRechargeGift, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_DELETED, function ( activityId )
        if self.activityId and self.activityId == activityId then
            Utils:showTips(14110403)
            AlertManager:closeLayer(self)
        end
    end)
    self.Button_fashionBuy:onClick(function()
        local giftData = RechargeDataMgr:getOneRechargeCfg(self.giftId)
        if giftData.buyCount ~= 0 and giftData.buyCount - RechargeDataMgr:getBuyCount(giftData.rechargeCfg.id) <= 0 then
            FunctionDataMgr:jStorePack( 328000 )
        else
            local costId,costNum = giftData.exchangeCost[1].id,giftData.exchangeCost[1].num
            local isEnough = GoodsDataMgr:currencyIsEnough(costId,costNum)
            if not isEnough then
                Utils:showAccess(costId)
                return;
            end
            RechargeDataMgr:getOrderNO(giftData.rechargeCfg.id);
        end
    end)

    for k,v in ipairs(self.fashionStoreInfo_) do
        v.btn:onClick(function()
            self:choosePL(k)
        end)
    end

    self.Button_refresh:onClick(function()

        if self.freeCount <= 0 then

            ---计算是第几次付费刷新
            local nextPayIndex = #self.refreshItemData - self.leftCount + 1
            if nextPayIndex < 0 then
                nextPayIndex = 1
            elseif nextPayIndex > #self.refreshItemData then
                nextPayIndex = #self.refreshItemData
            end

            local costData = self.refreshItemData[nextPayIndex]
            local refreshId,refreshCostNum
            for k,v in pairs(costData) do
                refreshId,refreshCostNum = tonumber(k),v
                break
            end

            if not refreshId or not refreshCostNum then
                return
            end

            local isEnough = GoodsDataMgr:currencyIsEnough(refreshId, refreshCostNum)
            if not isEnough then
                Utils:showAccess(refreshId)
            else
                TFDirector:send(c2s.ANNIVERSARY2ND_REQ_REFRESH_ANNIV_DRESS, {})
            end
        else
            TFDirector:send(c2s.ANNIVERSARY2ND_REQ_REFRESH_ANNIV_DRESS, {})
        end
    end)

    for k,v in ipairs(self.fashionItemTab) do
        v:onClick(function()
            if self.showItem[k] then
                Utils:showInfo(self.showItem[k])
            end
        end)
    end

    self.Image_curOwn:onClick(function()
        if self.costId then
            Utils:showInfo(self.costId)
        end
    end)

    self.Button_help:onClick(function()
        Utils:openView("common.HelpView", {3113})
    end)
end


return FashionStore
