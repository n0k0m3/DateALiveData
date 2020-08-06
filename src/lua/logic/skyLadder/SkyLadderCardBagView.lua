
local SkyLadderCardBagView = class("SkyLadderCardBagView", BaseLayer)

function SkyLadderCardBagView:initData(fightCardPos)
    self.defaultSelectRuleIndex_ = 1
    self.ruleText_ = {3202017, 3202018, 3202019}
    self.orderText_ = {301018, 301019}
    self.ownedCardData_ = SkyLadderDataMgr:getOwnedCard()
    self.notOwnedCardData_ = SkyLadderDataMgr:getNotOwnedCard()

    self.saveType = 1
    local ruleIndex,orderIndex = SkyLadderDataMgr:getCardSortParam(self.saveType)
    self.defaultSelectRuleIndex_ = ruleIndex or 1
    self.defaultSelectOrderIndex_ = orderIndex or 1
    self.selectOrderIndex_ = self.defaultSelectOrderIndex_
    self.columnNum_ = 7
    self.ownedCardItems_ = {}
    self.fightCardPos = fightCardPos

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

function SkyLadderCardBagView:ctor(fightCardPos)
    self.super.ctor(self)
    self:initData(fightCardPos)
    self:init("lua.uiconfig.skyladder.skyladderCardBagView")
end

function SkyLadderCardBagView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_cardItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_cardItem")
    self.Image_costItem = TFDirector:getChildByPath(self.Panel_prefab, "Image_costItem")
    self.Panel_rowCardItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_rowCardItem")

    local Image_ownedItem = TFDirector:getChildByPath(self.Panel_root, "Image_ownedItem")
    self.Label_zones_name = TFDirector:getChildByPath(Image_ownedItem, "Label_zones_name")
    self.Label_collect_num = TFDirector:getChildByPath(Image_ownedItem, "Label_collect_num")

    self.Button_select_rule = TFDirector:getChildByPath(Image_ownedItem, "Button_select_rule")
    self.Label_select_ruleName = TFDirector:getChildByPath(self.Button_select_rule, "Label_select_ruleName")
    self.Panel_rule = TFDirector:getChildByPath(Image_ownedItem, "Panel_rule"):hide()
    self.Button_rule = {}
    for i = 1, 3 do
        local foo = {}
        self.Button_rule[i] = TFDirector:getChildByPath(self.Panel_rule, "Button_rule_" .. i)
        local Label_rule_name = TFDirector:getChildByPath(self.Button_rule[i], "Label_rule_name")
        Label_rule_name:setTextById(self.ruleText_[i])
    end
    self.Label_collect_num:setTextById(3202016, #self.ownedCardData_, #self.ownedCardData_ + #self.notOwnedCardData_)

    self.Button_select_order = TFDirector:getChildByPath(Image_ownedItem, "Button_select_order")
    self.Image_select_orderArrow = TFDirector:getChildByPath(self.Button_select_order, "Image_select_orderArrow")
    self.Label_select_orderName = TFDirector:getChildByPath(self.Button_select_order, "Label_select_orderName")
    self.Panel_order = TFDirector:getChildByPath(Image_ownedItem, "Panel_order"):hide()
    self.Button_order = {}
    for i = 1, 2 do
        self.Button_order[i] = TFDirector:getChildByPath(self.Panel_order, "Button_order_" .. i)
        local Label_order_name = TFDirector:getChildByPath(self.Button_order[i], "Label_order_name")
        Label_order_name:setTextById(self.orderText_[i])
    end

    self.Label_cost = TFDirector:getChildByPath(Image_ownedItem, "Label_cost")
    local ScrollView_cost = TFDirector:getChildByPath(Image_ownedItem, "ScrollView_cost")
    self.ListView_cost = UIListView:create(ScrollView_cost)
    self.ListView_cost:setItemsMargin(-5)

    local Image_scrollBar = TFDirector:getChildByPath(self.Panel_root, "Image_scrollBar")
    local Image_scrollBarInner = TFDirector:getChildByPath(self.Panel_root, "Image_scrollBarInner")
    local scrollBar = UIScrollBar:create(Image_scrollBar, Image_scrollBarInner)
    local ScrollView_content = TFDirector:getChildByPath(self.Panel_root, "ScrollView_content")
    self.ListView_content = UIListView:create(ScrollView_content)
    self.ListView_content:setScrollBar(scrollBar)

    self:refreshView()
end

function SkyLadderCardBagView:refreshView()
    self.Image_select_orderArrow:setFlipY(self.defaultSelectOrderIndex_ == 1)
    self.Label_select_orderName:setTextById(self.orderText_[self.defaultSelectOrderIndex_])

    self:initOwnedCard()
    self:selectRule(self.defaultSelectRuleIndex_)
end

function SkyLadderCardBagView:initOwnedCard()
    self.Label_collect_num:setTextById(3202016, #self.ownedCardData_, #self.ownedCardData_ + #self.notOwnedCardData_)

    local totalCost = SkyLadderDataMgr:getCardEquipMaxCost()
    local equipCardCost = 0
    local usingCardInfo = SkyLadderDataMgr:getUsingCards()
    for k,v in ipairs(usingCardInfo) do
        local itemCfg = SkyLadderDataMgr:getRankMatchCardCfg(v)
        if itemCfg then
            equipCardCost = equipCardCost + itemCfg.cost
        end
    end

    for i = 1, totalCost do
        local Image_costItem = self.Image_costItem:clone()
        local Image_cost_light = TFDirector:getChildByPath(Image_costItem, "Image_cost_light")
        Image_cost_light:setVisible(i <= equipCardCost)
        self.ListView_cost:pushBackCustomItem(Image_costItem)
    end
    Utils:setAliginCenterByListView(self.ListView_cost, true)
    local size = self.ListView_cost:getContentSize()
    self.Label_cost:PosX(self.ListView_cost:s():PosX() - size.width - 5)

    local row = math.ceil(#self.ownedCardData_ / self.columnNum_)
    for i = 1, row do
        local foo = self:addRowCardItem()
        self.ownedCardItems_[i] = foo
        self.ListView_content:pushBackCustomItem(foo.root)
    end
end

function SkyLadderCardBagView:addRowCardItem()
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
        bar.Image_disabled = TFDirector:getChildByPath(bar.root, "Image_disabled")
        bar.Image_card_type = TFDirector:getChildByPath(bar.Button_card, "Image_card_type")
        bar.Label_card_lv = TFDirector:getChildByPath(bar.Button_card, "Label_card_lv")
        bar.Image_card = TFDirector:getChildByPath(bar.Button_card, "Image_card")
        local ScrollView_cost = TFDirector:getChildByPath(bar.Button_card, "ScrollView_cost")
        bar.ListView_cost = UIListView:create(ScrollView_cost)
        bar.ListView_cost:setItemsMargin(-5)
        bar.Label_card_name = TFDirector:getChildByPath(bar.Button_card, "Label_card_name")
        bar.Image_use_not = TFDirector:getChildByPath(bar.Button_card, "Image_use_not")
        bar.Image_carry = TFDirector:getChildByPath(bar.Button_card, "Image_carry")
        local Label_not = TFDirector:getChildByPath(bar.Image_use_not, "Label_not")
        Label_not:setTextById(3202020)
        local Label_use_tip = TFDirector:getChildByPath(bar.Button_card, "Label_use_tip")
        Label_use_tip:setTextById(3202034)
        bar.Label_remain_cnt = TFDirector:getChildByPath(Label_use_tip, "Label_remain_cnt")
        foo.Panel_card[i] = bar
    end
    return foo
end

function SkyLadderCardBagView:selectRule(index)

    self.Label_select_ruleName:setTextById(self.ruleText_[index])
    self.Panel_rule:hide()

    if self.selectRuleIndex_ == index then return end
    self.selectRuleIndex_ = index

    self:updateCardData()
    self:updateAllCardItem()
end

function SkyLadderCardBagView:updateCardData()
    dump({self.selectRuleIndex_, self.selectOrderIndex_})
    local paramTab = {}
    paramTab.type = self.saveType
    paramTab.ruleIndex = self.selectRuleIndex_
    paramTab.orderIndex = self.selectOrderIndex_
    SkyLadderDataMgr:setCardSortParam(paramTab)
    local sortFunc
    if self.selectRuleIndex_ == self.sortRuleType.Level then
        sortFunc = function(a,b)
            local isUsingCardsA = SkyLadderDataMgr:isUsingCards(a.cardId) and 1 or 0
            local isUsingCardsB = SkyLadderDataMgr:isUsingCards(b.cardId) and 1 or 0
            local itemACfg = SkyLadderDataMgr:getRankMatchCardCfg(a.cardId)
            local itemBCfg = SkyLadderDataMgr:getRankMatchCardCfg(b.cardId)
            if isUsingCardsA == isUsingCardsB then
                if self.selectOrderIndex_ == self.sortType.Desc then
                    if a.cardLv == b.cardLv then
                        return itemACfg.order < itemBCfg.order
                    end
                    return a.cardLv > b.cardLv
                end
                return a.cardLv < b.cardLv
            else
                return isUsingCardsA > isUsingCardsB
            end
        end
    elseif self.selectRuleIndex_ == self.sortRuleType.Quality then
        sortFunc = function(a,b)
            local isUsingCardsA = SkyLadderDataMgr:isUsingCards(a.cardId) and 1 or 0
            local isUsingCardsB = SkyLadderDataMgr:isUsingCards(b.cardId) and 1 or 0
            local itemACfg = SkyLadderDataMgr:getRankMatchCardCfg(a.cardId)
            local itemBCfg = SkyLadderDataMgr:getRankMatchCardCfg(b.cardId)
            if isUsingCardsA == isUsingCardsB then
                if self.selectOrderIndex_ == self.sortType.Desc then
                    if itemACfg.quality == itemBCfg.quality then
                        return itemACfg.order < itemBCfg.order
                    end
                    return itemACfg.quality > itemBCfg.quality
                end
                return itemACfg.quality < itemBCfg.quality
            else
                return isUsingCardsA > isUsingCardsB
            end
        end
    elseif self.selectRuleIndex_ == self.sortRuleType.cost then
        sortFunc = function(a,b)
            local isUsingCardsA = SkyLadderDataMgr:isUsingCards(a.cardId) and 1 or 0
            local isUsingCardsB = SkyLadderDataMgr:isUsingCards(b.cardId) and 1 or 0
            local itemACfg = SkyLadderDataMgr:getRankMatchCardCfg(a.cardId)
            local itemBCfg = SkyLadderDataMgr:getRankMatchCardCfg(b.cardId)
            if isUsingCardsA == isUsingCardsB then
                if self.selectOrderIndex_ == self.sortType.Desc then
                    if itemACfg.cost == itemBCfg.cost then
                        return itemACfg.order < itemBCfg.order
                    end
                    return itemACfg.cost > itemBCfg.cost
                end
                return itemACfg.cost < itemBCfg.cost
            else
                return isUsingCardsA > isUsingCardsB
            end
        end
    end

    if not sortFunc then
        return
    end
    table.sort(self.ownedCardData_,sortFunc)
end

function SkyLadderCardBagView:selectOrder(index)
    self.Label_select_orderName:setTextById(self.orderText_[index])
    self.Image_select_orderArrow:setFlipY(index == 1)
    self.Panel_order:hide()

    if self.selectOrderIndex_ == index then return end
    self.selectOrderIndex_ = index

    self:updateCardData()
    self:updateAllCardItem()
end

function SkyLadderCardBagView:updateCardItem(bar, cardInfo)

    local cardCid = cardInfo.cardId
    local level = cardInfo.cardLv

    local itemCfg = SkyLadderDataMgr:getRankMatchCardCfg(cardCid)
    if not itemCfg then
        return
    end
    local isMax = level == itemCfg.maxLevel
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

    bar.Image_carry:setVisible(SkyLadderDataMgr:isUsingCards(cardCid))

    local cardcnt = SkyLadderDataMgr:getCardFightCnt(cardCid)
    bar.Label_remain_cnt:setText(cardcnt)
    bar.Image_disabled:setVisible(cardcnt == 0)
    for k = 1, itemCfg.cost do
        local Image_costItem = self.Image_costItem:clone()
        bar.ListView_cost:pushBackCustomItem(Image_costItem)
    end
    Utils:setAliginCenterByListView(bar.ListView_cost, true)
    bar.Button_card:onClick(function()
            Utils:openView("skyLadder.SkyLadderCardLevelUpView", cardCid,self.fightCardPos)
    end)
end

function SkyLadderCardBagView:updateAllCardItem()
    local row = math.ceil(#self.ownedCardData_ / self.columnNum_)
    for i, foo in ipairs(self.ownedCardItems_) do
        for j, bar in ipairs(foo.Panel_card) do
            local order = (i - 1) * self.columnNum_ + j
            local cardInfo = self.ownedCardData_[order]
            if cardInfo then
                bar.root:show()
                self:updateCardItem(bar, cardInfo)
            else
                bar.root:hide()
            end
        end
    end

end

function SkyLadderCardBagView:onRecvUpdateCard()
    self:updateCardData()
    self:updateAllCardItem()
end

function SkyLadderCardBagView:registerEvents()

    EventMgr:addEventListener(self, EV_ADD_CARDS, handler(self.onRecvUpdateCard, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onRecvUpdateCard, self))
    EventMgr:addEventListener(self, EV_UPDATE_CARD_LV, handler(self.onRecvUpdateCard, self))
    EventMgr:addEventListener(self, EV_UPDATE_CARD_FORMATION, handler(self.onRecvUpdateCard, self))

    self.Button_select_rule:onClick(function()
        local visible = self.Panel_rule:isVisible()
        self.Panel_rule:setVisible(not visible)
    end)

    for i, v in ipairs(self.Button_rule) do
        v:onClick(function()
            self:selectRule(i)
        end)
    end

    self.Button_select_order:onClick(function()
        local visible = self.Panel_order:isVisible()
        self.Panel_order:setVisible(not visible)
    end)

    for i, v in ipairs(self.Button_order) do
        v:onClick(function()
            self:selectOrder(i)
        end)
    end
end

return SkyLadderCardBagView
