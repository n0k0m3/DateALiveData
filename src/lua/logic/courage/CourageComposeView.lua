local CourageComposeView = class("CourageComposeView", BaseLayer)

function CourageComposeView:initData()

    self.goodsItem_ = {}
    self.targetNum = 1
    local store = StoreDataMgr:getOpenStore(EC_StoreType.COURAGE)
    self.storeCid_ = store[1]
    self.commodity_ = StoreDataMgr:getCommodity(self.storeCid_)
end

function CourageComposeView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.courage.courageComposeView")
end

function CourageComposeView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")
    self.Button_help = TFDirector:getChildByPath(self.Panel_root, "Button_help")

    local Panel_compose = TFDirector:getChildByPath(self.Panel_root, "Panel_compose")
    self.Image_target = TFDirector:getChildByPath(Panel_compose, "Image_target")
    self.costItems_ = {}
    for i=1,3 do
        local pl = TFDirector:getChildByPath(Panel_compose, "Panel_costitem"..i)
        local Image_item = TFDirector:getChildByPath(pl, "Image_item")
        local Label_item = TFDirector:getChildByPath(pl, "Label_item")
        local Label_num  = TFDirector:getChildByPath(pl, "Label_num")
        table.insert(self.costItems_,{pl = pl,item = Image_item,tip = Label_item, numTx = Label_num})
    end
    self.Image_border = TFDirector:getChildByPath(Panel_compose, "Image_border")

    self.Button_compose = TFDirector:getChildByPath(Panel_compose, "Button_compose")
    self.Label_targetNum = TFDirector:getChildByPath(Panel_compose, "Label_targetNum")
    self.Button_add = TFDirector:getChildByPath(Panel_compose, "Button_add")
    self.Button_del = TFDirector:getChildByPath(Panel_compose, "Button_del")
    self.Label_name = TFDirector:getChildByPath(Panel_compose, "Label_name")
    self.Label_itemInfo = TFDirector:getChildByPath(Panel_compose, "Label_itemInfo")

    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
    self.Panel_bagItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_bagItem")

    local Panel_item = TFDirector:getChildByPath(self.Panel_root, "Panel_item")
    local ScrollView_equip = TFDirector:getChildByPath(Panel_item, "ScrollView_equip")
    self.GridView_item = UIGridView:create(ScrollView_equip)
    self.GridView_item:setItemModel(self.Panel_bagItem)
    self.GridView_item:setColumn(4)
    self.GridView_item:setColumnMargin(10)
    self.GridView_item:setRowMargin(10)

    self:initUILogic()
end

function CourageComposeView:onShow()
    self.super.onShow(self)
    self:timeOut(function()
        GameGuide:checkGuide(self);
    end,0.1)
end

function CourageComposeView:initUILogic()

    self:updateTargetList()
end

function CourageComposeView:updateTargetList()

    for k,v in ipairs(self.commodity_) do
        local item = self.GridView_item:getItem(k)
        if not item then
            item = self:addGoodsItem()
        end
        self:updateGoodsItem(item, v)
        if not self.oldSelectItem then
           self:selectGoodsItem(item,v)
        end
        local commodinfo = StoreDataMgr:getCommodityCfg(v)
        if commodinfo then
            local isUnlock = StoreDataMgr:isUnlockCommodity(v)
            local isEnough = StoreDataMgr:currencyIsEnough(v, commodinfo.goodInfo[1].num)
            if isUnlock and isEnough then
                self:selectGoodsItem(item,v)
            end
        end
    end
end

function CourageComposeView:addGoodsItem()
    local item = self.GridView_item:pushBackDefaultItem()
    local foo = {}
    foo.root = item
    foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select"):hide()
    foo.Image_lock = TFDirector:getChildByPath(foo.root, "Image_lock")
    foo.Panel_not = TFDirector:getChildByPath(foo.root, "Panel_not")
    foo.Panel_head = TFDirector:getChildByPath(foo.root, "Panel_head")

    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    Panel_goodsItem:setTouchEnabled(false)
    Panel_goodsItem:Pos(0, 0)
    Panel_goodsItem:AddTo(foo.Panel_head)
    foo.Panel_goodsItem = Panel_goodsItem
    self.goodsItem_[item] = foo
    return item
end

function CourageComposeView:updateGoodsItem(item, commodityId)
    local foo = self.goodsItem_[item]
    if not foo then
        item = self:addGoodsItem();
        foo = self.goodsItem_[item];
    end
    local commodinfo = StoreDataMgr:getCommodityCfg(commodityId)
    if not commodinfo then
        return
    end
    local goods = commodinfo.goodInfo[1]
    if not goods then
        return
    end
    local goodsId, goodsCount = goods.id, goods.num
    PrefabDataMgr:setInfo(foo.Panel_goodsItem, goodsId)

    local isUnlock = StoreDataMgr:isUnlockCommodity(commodityId)
    foo.Image_lock:setVisible(not isUnlock)

    local isCanBuy = StoreDataMgr:getRemainBuyCount(commodityId)

    local isEnough = StoreDataMgr:currencyIsEnough(commodityId, goodsCount)
    foo.Panel_not:setVisible(not isEnough)
    foo.root:setGrayEnabled(not isEnough)

    foo.Panel_head:onClick(function()
        GameGuide:checkGuideEnd(self.guideFuncId)
        self:selectGoodsItem(item, commodityId)
    end)
end

function CourageComposeView:selectGoodsItem(item,commodityId)

    local commodinfo = StoreDataMgr:getCommodityCfg(commodityId)
    if not commodinfo then
        return
    end

    local isUnlock = StoreDataMgr:isUnlockCommodity(commodityId)
    if not isUnlock then
        Utils:showTips("未解锁")
        return
    end

    if self.oldSelectItem then
        local foo = self.goodsItem_[self.oldSelectItem];
        foo.Image_select:setVisible(false)
    end
    local foo = self.goodsItem_[item]
    foo.Image_select:setVisible(true)
    self.oldSelectItem = item

    self.commodityId = commodityId
    self.commodityNum = commodinfo.goodInfo[1].num

    self.targetNum = 1
    self.maxtargetNum = commodinfo.goodInfo[1].num

    local max = 99999
    for i=1,3 do
        local costId,costNum = commodinfo.priceType[i],commodinfo.priceVal[i]
        if costId and costNum then
            local ownNum = GoodsDataMgr:getItemCount(costId)
            local couldMakeNum = math.floor(ownNum/costNum)
            if couldMakeNum <= max then
                max = couldMakeNum
            end
        end
    end
    self.maxtargetNum = max
    self:updateTargetNum()
end


function CourageComposeView:updateTargetNum()
    self.Label_targetNum:setText(self.targetNum)
    self.Button_del:setTouchEnabled(self.targetNum > 1)
    self.Button_del:setGrayEnabled(self.targetNum <= 1)

    self.Button_add:setTouchEnabled(self.targetNum < self.maxtargetNum)
    self.Button_add:setGrayEnabled(self.targetNum >= self.maxtargetNum)
    local commodinfo = StoreDataMgr:getCommodityCfg(self.commodityId)
    if not commodinfo then
        return
    end
    self:updateCompsePL(commodinfo)
end

function CourageComposeView:updateCompsePL(commodinfo)
    local goods = commodinfo.goodInfo[1]
    if not goods then
        return
    end

    local goodsId, goodsCount = goods.id, goods.num

    local Panel_goodsItem = self.Image_target:getChildByName("Panel_goodsItem")
    if not Panel_goodsItem then
        Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:setName("Panel_goodsItem")
        Panel_goodsItem:setPosition(ccp(0,0))
        self.Image_target:addChild(Panel_goodsItem)
    end
    PrefabDataMgr:setInfo(Panel_goodsItem, goodsId,goodsCount)

    local itemCfg = GoodsDataMgr:getItemCfg(goodsId)
    self.Label_name:setTextById(itemCfg.nameTextId)
    self.Label_itemInfo:setTextById(itemCfg.desTextId)

    local cnt = 0
    for i=1,3 do
        local costId,costNum = commodinfo.priceType[i],(commodinfo.priceVal[i] and commodinfo.priceVal[i] * self.targetNum or nil)
        if not costId or not costNum then
            self.costItems_[i].pl:setVisible(false)
        else
            cnt = cnt + 1
            self.costItems_[i].pl:setVisible(true)
            local Panel_goodsItem = self.costItems_[i].item:getChildByName("Panel_goodsItem")
            if not Panel_goodsItem then
                Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
                Panel_goodsItem:setName("Panel_goodsItem")
                Panel_goodsItem:setPosition(ccp(0,0))
                self.costItems_[i].item:addChild(Panel_goodsItem)
            end
            local ownNum = GoodsDataMgr:getItemCount(costId)
            PrefabDataMgr:setInfo(Panel_goodsItem, costId,ownNum)
            local isEnuough = ownNum >= costNum
            self.costItems_[i].pl:setGrayEnabled(not isEnuough)
            self.costItems_[i].tip:setVisible(not isEnuough)
            self.costItems_[i].numTx:setText(costNum.."/"..ownNum)
            self.costItems_[i].numTx:setVisible(isEnuough)
        end
    end
    local res = cnt >= 3 and "009.png" or "010.png"
    self.Image_border:setTexture("ui/activity/courage/bag/"..res)

    if cnt >= 3 then
        self.costItems_[1].pl:setPositionX(191)
        self.costItems_[2].pl:setPositionX(483)
    else
        self.costItems_[1].pl:setPositionX(210)
        self.costItems_[2].pl:setPositionX(461)
    end
end

function CourageComposeView:addNum()
    local prenum = self.targetNum + 1

    self.targetNum = prenum
    self:updateTargetNum()
end

function CourageComposeView:delNum()
    local prenum = self.targetNum - 1
    if prenum <= 0 then
        return
    end

    self.targetNum = prenum
    self:updateTargetNum()
end

function CourageComposeView:onBuySuccessEvent(data)

    local rewardList = {}
    for k,v in pairs(data.goods) do
        table.insert(rewardList,Utils:makeRewardItem(v.id, v.num))
    end
    Utils:showReward(rewardList)

    for k,v in ipairs(self.commodity_) do
        local item = self.GridView_item:getItem(k)
        if not item then
            item = self:addGoodsItem()
        end
        self:updateGoodsItem(item, v)
    end
    self:selectGoodsItem(self.oldSelectItem,self.commodityId)
    --table.insert(rewardList,{id = 543247,num = 20})
    --EventMgr:dispatchEvent(EV_GET_NEW_COURAGE_ITEM, rewardList)
    --AlertManager:closeLayer(self)
end

function CourageComposeView:excuteGuideFunc30003(guideFuncId)
    local targetNode = self.oldSelectItem
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

function CourageComposeView:excuteGuideFunc30004(guideFuncId)
    local targetNode = self.Button_compose
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

function CourageComposeView:excuteGuideFunc30005(guideFuncId)
    local targetNode = self.Button_close
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end


function CourageComposeView:registerEvents()

    EventMgr:addEventListener(self, EV_STORE_BUY_SUCCESS, handler(self.onBuySuccessEvent, self))

    self.Button_close:onClick(function()
        GameGuide:checkGuideEnd(self.guideFuncId)
        AlertManager:closeLayer(self)
    end)

    self.Button_add:onClick(function()
        self:addNum()
    end)
    self.Button_del:onClick(function()
        self:delNum()
    end)

    self.Button_compose:onClick(function()
        GameGuide:checkGuideEnd(self.guideFuncId)
        if self.commodityId then
            Utils:playSound(5032)

            local commodinfo = StoreDataMgr:getCommodityCfg(self.commodityId)
            if not commodinfo then
                return
            end

            local couldMake = true
            for i=1,3 do
                local costId,costNum = commodinfo.priceType[i],commodinfo.priceVal[i]
                if costId and costNum then
                    local ownNum = GoodsDataMgr:getItemCount(costId)
                    if ownNum <  costNum then
                        couldMake = false
                        break
                    end
                end
            end

            if not couldMake then
                Utils:showTips(1100026)
                return
            end

            StoreDataMgr:send_STORE_BUY_GOODS(self.commodityId,self.targetNum)
        end
    end)

    self.Button_help:onClick(function()
        local layer = require("lua.logic.common.HelpView"):new({1053})
        AlertManager:addLayer(layer)
        AlertManager:show()
    end)
end


return CourageComposeView
