-- 新大富翁道具卡页面
local DfwNewCardView = class("DfwNewCardView", BaseLayer)

local dfw = {}
function dfw.debug(str, ...) print(string.format(str, ...)) end

--[[
    滚动回调
]]
local function onScrollCallback(target, offsetRate, customOffsetRate)
    local items = target:getItem()
    for i, item in ipairs(items) do
        local rate = offsetRate[i]
        if rate then
            local rrate = 1 - rate
            local customRate = customOffsetRate[i]
            item:setOpacity(255 * rrate)
            item:setScale(rrate)
            item:setZOrder(rrate * 100)
        end
    end
end

local function updateCardDesScrollView(self)
    local cardCount = #self.cardsMap
    for i = 1, cardCount do
        local cardItem = self.turnView:getItem(i)
        local ScrollView_des = TFDirector:getChildByPath(cardItem, "ScrollView_des")
        ScrollView_des:setTouchEnabled(i == self.currIndex)
    end
end
--[[
    选中回调
]]
local function onSelectCard(self, target, index)
    dfw.debug("DfwNewCardView: the on select card index is %s", index)

    local selectedImage = self.Image_selected
    selectedImage:retain()
    selectedImage:removeFromParent()

    local item = self.turnView:getItem(index)
    local size = item:getSize()
    selectedImage:setPosition(0, 0)
    item:addChild(selectedImage)
    selectedImage:release()

    local cardData = self.cardsMap[index]
    if (cardData) then
        if (cardData.cid == self.currCardID) then
            self.Label_tip:setVisible(true)
        else
            self.Label_tip:setVisible(false)
        end

        self.currIndex = index

        updateCardDesScrollView(self)
    else
        dfw.debug("DfwNewCardView: the select card index %s data is invaild.", index)
        assert(false)
    end
end

--[[
    更新-装备上的道具卡
]]
local function onUpdateEquipCard(self, data)
    self.currCardID = data.equipItemCid

    for index, cardData in pairs(self.cardsMap) do
        if (cardData.id == self.currCardID) then
            self.turnView:scrollToItem(index)
            break
        end
    end
    AlertManager:closeLayer(self)
end

--[[
    构造函数
]]
function DfwNewCardView:ctor(cardID)
    DfwNewCardView.super.ctor(self)

    self:initData(cardID)
    self:init("lua.uiconfig.dafuwong.dfwNewCardView")
end

--[[
    初始化数据
]]
function DfwNewCardView:initData(cardID)
    dfw.debug("DfwNewCardView: the init card id is %s", cardID)

    -- 玩家当前装备的道具卡
    self.currCardID = cardID
    -- 当前选中的索引
    self.currIndex = 0
    -- 道具卡数据的映射表
    self.cardsMap = {}
end

--[[
    初始化视图
]]
function DfwNewCardView:initUI(ui)
    DfwNewCardView.super.initUI(self, ui)

    local Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_black = TFDirector:getChildByPath(Panel_root, "Panel_black")
    self.Button_ok = TFDirector:getChildByPath(Panel_root, "Button_ok")
    self.Image_selected = TFDirector:getChildByPath(Panel_root, "Image_selected"):hide()
    self.Label_tip = TFDirector:getChildByPath(Panel_root, "Label_tip"):hide()
    self.ScrollView_cards = TFDirector:getChildByPath(Panel_root, "ScrollView_cards")

    self.Button_outside = TFDirector:getChildByPath(self.ScrollView_cards, "Button_outside")

    self.turnView = UITurnView:create(self.ScrollView_cards)

    self.Label_no_card = TFDirector:getChildByPath(Panel_root, "Label_no_card")

    local Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
    self.Panel_cardItem = TFDirector:getChildByPath(Panel_prefab, "Image_cardItem")

    self.turnView:setItemModel(self.Panel_cardItem)

    self:updateCardView()
end

--[[
    更新视图
]]
local function updateScrollViewInnerSizeByLabel(self, scrollView, label)
    local size = label:getContentSize()

    local height = size.height > 70 and size.height or 70

    scrollView:setInnerContainerSize(CCSize(size.width, height))
    scrollView:jumpToTop()

    label:setPosition(ccp(size.width/2, height))
end
function DfwNewCardView:updateCardView()
    self.Label_no_card:setVisible(false)
    self.ScrollView_cards:setVisible(true)
    self.Panel_black:setTouchEnabled(false)
    self.Button_ok:setVisible(true)
    self.turnView:removeAllItems()

    -- 获得道具卡
    local cards = GoodsDataMgr:getBag(EC_Bag.DFW_CARD)

    self.currIndex = 0
    local cardCount = 0
    for _, card in pairs(cards) do
        local cardItem = self.turnView:pushBackItem()

        local cardCfg = TabDataMgr:getData("DfwCard", card.cid)
        cardItem:setTexture(cardCfg.buffCard)

        local nameLabel = TFDirector:getChildByPath(cardItem, "Label_name")
        local numLabel = TFDirector:getChildByPath(cardItem, "Label_card_num")

        local ScrollView_des = TFDirector:getChildByPath(cardItem, "ScrollView_des")
        local desLabel = TFDirector:getChildByPath(ScrollView_des, "Label_card_des")

        local cardItemCfg = TabDataMgr:getData("Item", card.cid)

        nameLabel:setTextById(cardCfg.title)
        desLabel:setTextById(cardCfg.buffDes)
        desLabel:setHorizontalAlignment(0)
        numLabel:setString(card.num.."/"..cardItemCfg.totalMax)

        updateScrollViewInnerSizeByLabel(self, ScrollView_des, desLabel)

        cardCount = cardCount + 1
        self.cardsMap[cardCount] = card

        if (card.cid == self.currCardID) then
            self.currIndex = cardCount
        end
    end

    print(string.format("DfwNewCardView: the cur index is %s, cardCount is %s", self.currIndex, cardCount))

    if (self.currIndex > 0) then
        self.turnView:scrollToItem(self.currIndex)
    else
        if (cardCount > 3) then 
            self.turnView:scrollToItem(3)
        elseif (cardCount == 3) then
            self.turnView:scrollToItem(2)
        elseif (cardCount == 0) then
            self.Label_no_card:setVisible(true)
            self.Label_no_card:setTextById(190000032)

            self.ScrollView_cards:setVisible(false)
            self.Button_ok:setVisible(false)
        elseif (cardCount < 3 and cardCount > 0) then
            self.turnView:scrollToItem(1)
        end
    end

    self.Panel_black:setTouchEnabled(true)
    self.Panel_black:onClick(function() AlertManager:closeLayer(self) end)
end

--[[
    注册响应事件
]]
function DfwNewCardView:registerEvents()
    EventMgr:addEventListener(self, EV_DFW_NEW_UPDATE_CARD, handler(onUpdateEquipCard, self))

    self.turnView:registerScrollCallback(onScrollCallback)
    self.turnView:registerSelectCallback(handler(onSelectCard, self))

    self.Button_outside:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_ok:onClick(function()
        dfw.debug("DfwNewCardView: the button is clicked, index is %s", self.currIndex)
        local cardData = self.cardsMap[self.currIndex]
        if (cardData) then
            dfw.debug("DfwNewCardView: the selected card ID is %s", cardData.cid)
            
            Utils:playSound(5001)

            DfwDataMgr:send_ZILLIONAIRE_REQ_EQUIP_ITEM(cardData.cid)
        else
            AlertManager:closeLayer(self)
        end
    end)
end

return DfwNewCardView