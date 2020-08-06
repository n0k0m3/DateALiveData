local SkyLadderCardView = class("SkyLadderCardView", BaseLayer)

function SkyLadderCardView:ctor()
    self.super.ctor(self)
    self:initData()
    self:init("lua.uiconfig.skyladder.skyladderCardView")
end

function SkyLadderCardView:initData()
    self.ruleText_ = {3202017, 3202018, 3202019}
    self.orderText_ = {301018, 301019}
    self.ownedCardData_ = SkyLadderDataMgr:getOwnedCard()
    self.notOwnedCardData_ = SkyLadderDataMgr:getNotOwnedCard()
    self.saveType = 2
    local ruleIndex,orderIndex = SkyLadderDataMgr:getCardSortParam(self.saveType)

    self.defaultSelectRuleIndex_ = ruleIndex or 1
    self.defaultSelectOrderIndex_ = orderIndex or 1
    self.selectOrderIndex_ = self.defaultSelectOrderIndex_

    self.columnNum_ = 7
    self.ownedCardItems_ = {}
    self.notOwnedCardItems_ = {}

    self.sortRuleType = {
        Level = 1,
        Quality = 2,
        cost = 3,
    }

    self.sortType = {
        Desc = 1,
        Asc = 2
    }
end

function SkyLadderCardView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Image_ownedItem = TFDirector:getChildByPath(self.Panel_root, "Image_ownedItem")

    self.Image_notOwnedItem = TFDirector:getChildByPath(self.Panel_prefab, "Image_notOwnedItem")
    self.Panel_cardItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_cardItem")
    self.Image_costItem = TFDirector:getChildByPath(self.Panel_prefab, "Image_costItem")
    self.Panel_rowCardItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_rowCardItem")

    local Image_scrollBar = TFDirector:getChildByPath(self.Panel_root, "Image_scrollBar")
    local Image_scrollBarInner = TFDirector:getChildByPath(Image_scrollBar, "Image_scrollBarInner")
    local scrollBar = UIScrollBar:create(Image_scrollBar, Image_scrollBarInner)

    local ScrollView_content = TFDirector:getChildByPath(self.Panel_root, "ScrollView_content")
    self.ListView_content = UIListView:create(ScrollView_content)
    self.ListView_content:setItemsMargin(10)
    self.ListView_content:setScrollBar(scrollBar)

    self:refreshView()
end

function SkyLadderCardView:refreshView()
    self:initOwnedCard()
    self:initNotOwnedCard()
    self:selectRule(self.defaultSelectRuleIndex_)
end

function SkyLadderCardView:initOwnedCard()
    local Image_ownedItem = self.Image_ownedItem
    Image_ownedItem:ZO(2)
    local Label_zones_name = TFDirector:getChildByPath(Image_ownedItem, "Label_zones_name")
    Label_zones_name:setTextById(3202061)
    local Label_collect_num = TFDirector:getChildByPath(Image_ownedItem, "Label_collect_num")
    local Button_select_rule = TFDirector:getChildByPath(Image_ownedItem, "Button_select_rule")
    local Label_select_ruleName = TFDirector:getChildByPath(Button_select_rule, "Label_select_ruleName")
    Label_select_ruleName:setTextById(self.ruleText_[self.defaultSelectRuleIndex_])
    local Panel_rule = TFDirector:getChildByPath(Image_ownedItem, "Panel_rule"):hide()
    local Button_rule = {}
    for i = 1, 3 do
        local foo = {}
        Button_rule[i] = TFDirector:getChildByPath(Panel_rule, "Button_rule_" .. i)
        local Label_rule_name = TFDirector:getChildByPath(Button_rule[i], "Label_rule_name")
        Label_rule_name:setTextById(self.ruleText_[i])
    end
    Label_collect_num:setTextById(3202016, #self.ownedCardData_, #self.ownedCardData_ + #self.notOwnedCardData_)

    local Button_select_order = TFDirector:getChildByPath(Image_ownedItem, "Button_select_order")
    local Image_select_orderArrow = TFDirector:getChildByPath(Button_select_order, "Image_select_orderArrow")
    Image_select_orderArrow:setFlipY(self.defaultSelectOrderIndex_ == 1)
    local Label_select_orderName = TFDirector:getChildByPath(Button_select_order, "Label_select_orderName")
    Label_select_orderName:setTextById(self.orderText_[self.defaultSelectOrderIndex_])
    local Panel_order = TFDirector:getChildByPath(Image_ownedItem, "Panel_order"):hide()
    local Button_order = {}
    for i = 1, 2 do
        Button_order[i] = TFDirector:getChildByPath(Panel_order, "Button_order_" .. i)
        local Label_order_name = TFDirector:getChildByPath(Button_order[i], "Label_order_name")
        Label_order_name:setTextById(self.orderText_[i])
    end

    Button_select_rule:onClick(function()
            local visible = Panel_rule:isVisible()
            Panel_rule:setVisible(not visible)
    end)

    for i, v in ipairs(Button_rule) do
        v:onClick(function()
                Label_select_ruleName:setTextById(self.ruleText_[i])
                Panel_rule:hide()
                self:selectRule(i)
        end)
    end

    Button_select_order:onClick(function()
            local visible = Panel_order:isVisible()
            Panel_order:setVisible(not visible)
    end)

    for i, v in ipairs(Button_order) do
        v:onClick(function()
                Label_select_orderName:setTextById(self.orderText_[i])
                Image_select_orderArrow:setFlipY(i == 1)
                Panel_order:hide()
                self:selectOrder(i)
        end)
    end

    --self.ListView_content:pushBackCustomItem(Image_ownedItem)

    local row = math.ceil(#self.ownedCardData_ / self.columnNum_)
    for i = 1, row do
        local foo = self:addRowCardItem()
        self.ownedCardItems_[i] = foo
        self.ListView_content:pushBackCustomItem(foo.root)
    end
end

function SkyLadderCardView:initNotOwnedCard()
    local Image_notOwnedItem = self.Image_notOwnedItem:clone()
    local Label_collect_tip = TFDirector:getChildByPath(Image_notOwnedItem, "Label_collect_tip")
    Label_collect_tip:setTextById(3202023)
    self.ListView_content:pushBackCustomItem(Image_notOwnedItem)

    local row = math.ceil(#self.notOwnedCardData_ / self.columnNum_)
    for i = 1, row do
        local foo = self:addRowCardItem()
        self.notOwnedCardItems_[i] = foo
        self.ListView_content:pushBackCustomItem(foo.root)
    end
end

function SkyLadderCardView:addRowCardItem()
    local Panel_rowCardItem = self.Panel_rowCardItem:clone()
    local foo = {}
    foo.root = Panel_rowCardItem
    foo.Panel_card = {}
    for i = 1, 7 do
        local Panel_card = TFDirector:getChildByPath(foo.root, "Panel_card_" .. i)
        Panel_card:setBackGroundColorType(0)
        local bar = {}
        bar.root = self.Panel_cardItem:clone()
        bar.root:Pos(0, 0):AddTo(Panel_card)
        bar.Button_card = TFDirector:getChildByPath(bar.root, "Button_card")
        bar.Image_card_type = TFDirector:getChildByPath(bar.Button_card, "Image_card_type")
        bar.Label_card_lv = TFDirector:getChildByPath(bar.Button_card, "Label_card_lv")
        bar.Image_card = TFDirector:getChildByPath(bar.Button_card, "Image_card")
        local ScrollView_cost = TFDirector:getChildByPath(bar.Button_card, "ScrollView_cost")
        bar.ListView_cost = UIListView:create(ScrollView_cost)
        bar.ListView_cost:setItemsMargin(-5)
        bar.Label_card_name = TFDirector:getChildByPath(bar.Button_card, "Label_card_name")
        bar.Label_collect_state = TFDirector:getChildByPath(bar.Button_card, "Label_collect_state")
        bar.Label_collect_state:setTextById(3202024)
        bar.Image_progress = TFDirector:getChildByPath(bar.Button_card, "Image_progress")
        bar.LoadingBar_collect = TFDirector:getChildByPath(bar.Button_card, "LoadingBar_collect")
        bar.Label_collect = TFDirector:getChildByPath(bar.Button_card, "Label_collect")
        bar.Image_notown = TFDirector:getChildByPath(bar.root, "Image_notown")
        bar.Image_up = TFDirector:getChildByPath(bar.Button_card, "Image_up")
        bar.Spine_up = TFDirector:getChildByPath(bar.Button_card, "Spine_up")
        bar.Spine_up:play("animation", true)
        foo.Panel_card[i] = bar
    end
    return foo
end

function SkyLadderCardView:updateCardData()
    dump({self.selectRuleIndex_, self.selectOrderIndex_})

    local paramTab = {}
    paramTab.type = self.saveType
    paramTab.ruleIndex = self.selectRuleIndex_
    paramTab.orderIndex = self.selectOrderIndex_
    SkyLadderDataMgr:setCardSortParam(paramTab)

    local sortFunc
    if self.selectRuleIndex_ == self.sortRuleType.Level then
        sortFunc = function(a,b)
            local itemACfg = SkyLadderDataMgr:getRankMatchCardCfg(a.cardId)
            local itemBCfg = SkyLadderDataMgr:getRankMatchCardCfg(b.cardId)
            if self.selectOrderIndex_ == self.sortType.Desc then
                if a.cardLv == b.cardLv then
                    return itemACfg.order < itemBCfg.order
                end
                return a.cardLv > b.cardLv
            end
            return a.cardLv < b.cardLv
        end
    elseif self.selectRuleIndex_ == self.sortRuleType.Quality then
        sortFunc = function(a,b)
            local itemACfg = SkyLadderDataMgr:getRankMatchCardCfg(a.cardId)
            local itemBCfg = SkyLadderDataMgr:getRankMatchCardCfg(b.cardId)

            if self.selectOrderIndex_ == self.sortType.Desc then
                if itemACfg.quality == itemBCfg.quality then
                    return itemACfg.order < itemBCfg.order
                end
                return itemACfg.quality > itemBCfg.quality
            end
            return itemACfg.quality < itemBCfg.quality
        end
    elseif self.selectRuleIndex_ == self.sortRuleType.cost then
        sortFunc = function(a,b)
            local itemACfg = SkyLadderDataMgr:getRankMatchCardCfg(a.cardId)
            local itemBCfg = SkyLadderDataMgr:getRankMatchCardCfg(b.cardId)

            if self.selectOrderIndex_ == self.sortType.Desc then
                if itemACfg.cost == itemBCfg.cost then
                    return itemACfg.order < itemBCfg.order
                end
                return itemACfg.cost > itemBCfg.cost
            end
            return itemACfg.cost < itemBCfg.cost
        end
    end

    if not sortFunc then
        return
    end
    table.sort(self.ownedCardData_,sortFunc)
    table.sort(self.notOwnedCardData_,sortFunc)
end

function SkyLadderCardView:selectRule(index)
    if self.selectRuleIndex_ == index then return end
    self.selectRuleIndex_ = index
    self:updateCardData()
    self:updateAllCardItem()
end

function SkyLadderCardView:selectOrder(index)
    if self.selectOrderIndex_ == index then return end
    self.selectOrderIndex_ = index
    self:updateCardData()
    self:updateAllCardItem()
end

function SkyLadderCardView:updateCardItem(bar, cardInfo, isOwned)

    local cardCid = cardInfo.cardId
    local level = cardInfo.cardLv
    local itemCfg = SkyLadderDataMgr:getRankMatchCardCfg(cardCid)
    if not itemCfg then
        return
    end
    local isMax = itemCfg.maxLevel == level
    bar.Button_card:setTextureNormal(EC_SkyLadderCardFrame[itemCfg.quality])
    bar.Image_card_type:setTexture(EC_SkyLadderCardTypeIcon[itemCfg.abilityType])
    bar.Image_card:setTexture(itemCfg.icon)
    bar.Label_card_name:setTextById(itemCfg.nameTextId)
    bar.ListView_cost:removeAllItems()
    if isMax then
        bar.Label_card_lv:setText("Max")
    else
        bar.Label_card_lv:setTextById(800006, level)
    end
    for k = 1, itemCfg.cost do
        local Image_costItem = self.Image_costItem:clone()
        bar.ListView_cost:pushBackCustomItem(Image_costItem)
    end
    Utils:setAliginCenterByListView(bar.ListView_cost, true)
    bar.Label_collect_state:setVisible(not isOwned)
    bar.Image_progress:setVisible(isOwned and (not isMax ))
    bar.Button_card:onClick(function()
            Utils:openView("skyLadder.SkyLadderCardLevelUpView", cardCid)
    end)

    if isOwned then
        local covertCid
        for k,v in pairs(itemCfg.convertMax) do
            covertCid = k
            break
        end

        if not covertCid then
            return
        end
        local count = GoodsDataMgr:getItemCount(covertCid)
        local nextLevel = level + 1
        local nextCollectInfo = itemCfg.levelUpCoins[nextLevel]
        if nextCollectInfo then
            local costCount = nextCollectInfo[covertCid]
            bar.Label_collect:setTextById(800005, count, costCount)
            local percent = clampf(count / costCount * 100, 0, 100)
            bar.LoadingBar_collect:setPercent(percent)
            bar.Image_up:setVisible(percent < 100)
            bar.Spine_up:setVisible(percent == 100)
        end
    end
    bar.Image_notown:setVisible(not isOwned)
    local opacity = isOwned and 255 or 120
    bar.Button_card:setOpacity(opacity)
end

function SkyLadderCardView:updateAllCardItem()
    local row = math.ceil(#self.ownedCardData_ / self.columnNum_)
    for i, foo in ipairs(self.ownedCardItems_) do
        for j, bar in ipairs(foo.Panel_card) do
            local order = (i - 1) * self.columnNum_ + j
            local cardInfo = self.ownedCardData_[order]
            if cardInfo then
                bar.root:show()
                self:updateCardItem(bar, cardInfo, true)
            else
                bar.root:hide()
            end
        end
    end

    local row = math.ceil(#self.notOwnedCardData_ / self.columnNum_)
    for i, foo in ipairs(self.notOwnedCardItems_) do
        for j, bar in ipairs(foo.Panel_card) do
            local order = (i - 1) * self.columnNum_ + j
            if self.notOwnedCardData_[order] then
                local cardInfo = self.notOwnedCardData_[order]
                bar.root:show()
                self:updateCardItem(bar, cardInfo, false)
            else
                bar.root:hide()
            end
        end
    end
end

function SkyLadderCardView:onRecvUpdateCard()
    self:updateCardData()
    self:updateAllCardItem()
end

function SkyLadderCardView:registerEvents()

    EventMgr:addEventListener(self, EV_ADD_CARDS, handler(self.onRecvUpdateCard, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onRecvUpdateCard, self))
    EventMgr:addEventListener(self, EV_UPDATE_CARD_LV, handler(self.onRecvUpdateCard, self))

end

return SkyLadderCardView
