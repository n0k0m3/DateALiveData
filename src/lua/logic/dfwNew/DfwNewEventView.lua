-- 新大富翁触发事件弹窗
local DfwNewEventView = class("DfwNewEventView", BaseLayer)

local EventState = {
    NOT_CARD = 0,
    SELECTED = 1,
    SELECTING = 2
}

--buff 类型
local BuffType = {
    FIX_ROLL = 1, -- 固定步数
    DOUBLE = 2,     -- 双倍奖励
    IMMUNE = 3,     -- 免疫惩罚
    ANY_ROLL = 4    -- 自选步数
}

--[[
    日志输出
]]
local dfw = {}
function dfw.debug(str, ...)
    if (true) then
        print(string.format(str, ...))
    end
end

local function updateScrollViewInnerSizeByLabel(self, scrollView, label)
    local size = label:getContentSize()

    local height = size.height > 70 and size.height or 70

    scrollView:setInnerContainerSize(CCSize(size.width, height))
    scrollView:jumpToTop()

    label:setPosition(ccp(size.width/2, height))
end
--[[
    获得道具卡
]]
local function onGetedCard(self, data)
    dfw.debug("DfwNewEventView: on geted card...is cards %s", self.isCards)
    dump(data)
    self.Button_ok:setVisible(false)

    if (self.isCards) then
        local idx = data.index
        local item = data.reward

        self.ScrollView_cards:setVisible(false)

        local size = self.Panel_black:getContentSize()
        self.Panel_black:setVisible(true)
        local spine = SkeletonAnimation:create("effect/HFdafuweng/HFdafuweng")
        spine:play("animation2", false)
        spine:addMEListener(TFARMATURE_COMPLETE,function()
            local cardID = item.id
            local cardCfg = TabDataMgr:getData("DfwCard", cardID)

            self.Image_reward_card:setVisible(true)
            self.Image_reward_card:setTexture(cardCfg.buffCard)

            local Label_name = TFDirector:getChildByPath(self.Image_reward_card, "Label_name")
            Label_name:setTextById(cardCfg.title)

            local ScrollView_des = TFDirector:getChildByPath(self.Image_reward_card, "ScrollView_des")
            local Label_card_des = TFDirector:getChildByPath(ScrollView_des, "Label_card_des")
            Label_card_des:setTextById(cardCfg.buffDes)
            Label_card_des:setHorizontalAlignment(0)

            updateScrollViewInnerSizeByLabel(self, ScrollView_des, Label_card_des)

            local goodsCount = GoodsDataMgr:getItemCount(cardID)
            local cardItemCfg = TabDataMgr:getData("Item", cardID)
            local Label_card_num = TFDirector:getChildByPath(self.Image_reward_card, "Label_card_num")
            Label_card_num:setString(goodsCount.."/"..cardItemCfg.totalMax)

            spine:retain()
            spine:removeFromParent()
            spine:setPosition(0, 0)
            self.Image_reward_card:addChild(spine)
            spine:release()

            spine:play("animation3", true)

            self.Panel_black:setTouchEnabled(true)
            self.Panel_black:onClick(function()
                AlertManager:closeLayer(self)
            end)
        end)
        spine:setPosition(size.width/2, size.height/2)
        self.Panel_black:addChild(spine)

    end
end

--[[
    选中回调
]]
local function onSelectCard(self, target, index)
    self.currSelectIndex = index

    dfw.debug("DfwNewEventView: the on select card index is %s", index)

    local selectedImage = self.Image_selected
    selectedImage:retain()
    selectedImage:removeFromParent()

    local item = self.turnView_cards:getItem(index)
    local size = item:getSize()
    selectedImage:setPosition(0, 0)
    item:addChild(selectedImage)
    selectedImage:release()
end

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
            item:setPositionZ(-customRate * 100)
            item:setZOrder(rrate * 100)
        end
    end
end

--[[
    构造函数
]]
function DfwNewEventView:ctor(status, eventID, rewards, buffID)
    DfwNewEventView.super.ctor(self)

    self:initData(status, eventID, rewards, buffID)
    self:init("lua.uiconfig.dafuwong.dfwNewEventView")
end

--[[
    初始化数据
]]
function DfwNewEventView:initData(status, eventID, rewards, buffID)
    dfw.debug("DfwNewEventView: the status %s, eventID %s, rewards %s", status, eventID, rewards)
    -- 不是选择道具卡
    if (not status or status == EventState.NOT_CARD) then
        self.eventID = eventID
        self.rewards = rewards

        self.isCards = false
    -- 正在选择道具卡（未选择）
    elseif (status == EventState.SELECTING) then
        self.isCards = true
    -- 已选择道具卡
    elseif (status == EventState.SELECTED) then
        self.isCards = true
    end

    self.buffID = buffID
end

--[[
    初始化视图
]]
function DfwNewEventView:initUI(ui)
    DfwNewEventView.super.initUI(self, ui)

    local Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_black = TFDirector:getChildByPath(Panel_root, "Panel_black"):hide()

    self.Image_content = TFDirector:getChildByPath(Panel_root, "Image_content")
    self.Button_recvive = TFDirector:getChildByPath(self.Image_content, "Button_receive"):hide()
    self.Button_close = TFDirector:getChildByPath(self.Image_content, "Button_close")

    local Panel_card_select = TFDirector:getChildByPath(Panel_root, "Panel_card_select")
    self.ScrollView_cards = TFDirector:getChildByPath(Panel_card_select, "ScrollView_cards")

    self.Button_ok = TFDirector:getChildByPath(Panel_card_select, "Button_ok")
    self.Image_selected = TFDirector:getChildByPath(Panel_card_select, "Image_selected")
    self.Image_reward_card = TFDirector:getChildByPath(Panel_card_select, "Image_reward_card"):hide()

    local Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
    self.Image_cardItem = TFDirector:getChildByPath(Panel_prefab, "Image_cardItem")

    self.turnView_cards = UITurnView:create(self.ScrollView_cards)
    self.turnView_cards:setItemModel(self.Image_cardItem)

    if (self.isCards) then
        self:updateCardsView()
    else
        self:updateEventView()
    end
end

--[[
    注册响应事件
]]
function DfwNewEventView:registerEvents()
    EventMgr:addEventListener(self, EV_DFW_NEW_GET_CARD, handler(onGetedCard, self))

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_ok:onClick(function()
        dfw.debug("DfwNewEventView: the current select index is %s", self.currSelectIndex)

        if (self.currSelectIndex) then
            DfwDataMgr:send_ZILLIONAIRE_REQ_CHOOSE_ITEM(self.currSelectIndex)
        end
    end)

    self.turnView_cards:registerScrollCallback(onScrollCallback)
    self.turnView_cards:registerSelectCallback(handler(onSelectCard, self))
end

--[[
    初始化道具卡视图
]]
function DfwNewEventView:updateCardsView()
    self.Image_content:setVisible(false)
    self.Button_ok:setVisible(true)
    self.Image_selected:setVisible(true)
    self.ScrollView_cards:setVisible(true)

    local turnView = self.turnView_cards
    turnView:removeAllItems()

    local cfgs = TabDataMgr:getData("DfwCard")
    for index, card in pairs(cfgs) do 
        turnView:pushBackItem()
    end

    turnView:scrollToItem(3)
end

--[[
    初始化事件视图
]]
function DfwNewEventView:updateEventView()
    self.Image_content:setVisible(true)
    self.Button_ok:setVisible(false)
    self.Image_selected:setVisible(false)
    self.ScrollView_cards:setVisible(false)

    local turnView = self.turnView_cards
    turnView:removeAllItems()

    dfw.debug("DfwNewEventView: the eventID is %s, the rewards is %s", self.eventID, self.rewards)

    if (self.eventID) then
        local eventCfg = TabDataMgr:getData("DfwEvent", self.eventID)
        if (eventCfg) then
            local Label_title = TFDirector:getChildByPath(self.Image_content, "Label_title")
            local Label_desc = TFDirector:getChildByPath(self.Image_content, "Label_desc")

            local Image_head = TFDirector:getChildByPath(self.Image_content, "Image_head")
            local Image_icon = TFDirector:getChildByPath(Image_head, "Image_icon")

            Label_title:setTextById(eventCfg.name)
            Label_desc:setTextById(eventCfg.des)
            Image_icon:setTexture(eventCfg.head)
        end
    end

    local hasDoubleBuff = false
    if (self.buffID and self.buffID > 0) then
        local cardCfg = TabDataMgr:getData("DfwCard", self.buffID)
        if (cardCfg) then
            hasDoubleBuff = (cardCfg.type == BuffType.DOUBLE) and true or false
        end
    end
    dfw.debug("DfwNewEventView: the buff id is %s, has double is %s", self.buffID, hasDoubleBuff)

    local Label_buff = TFDirector:getChildByPath(self.Image_content, "Label_buff")
    Label_buff:setTextById(190000037)
    Label_buff:setVisible(hasDoubleBuff)

    if (self.eventID and self.rewards) then
        local ScrollView_reward = TFDirector:getChildByPath(self.Image_content, "ScrollView_reward")
        ScrollView_reward:removeAllChildren()

        local rewardCount = #self.rewards
        for i = 1, rewardCount do
            local item = self.rewards[i]

            local px = 140 - (rewardCount - 1) * 60 + (i - 1) * 120
            
            local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            PrefabDataMgr:setInfo(Panel_goodsItem, item.id, item.num)
            Panel_goodsItem:setPosition(px, 45)
            Panel_goodsItem:setScale(0.8)
            ScrollView_reward:addChild(Panel_goodsItem)
        end
        self.Panel_black:setVisible(true)
        self.Panel_black:setTouchEnabled(true)
        self.Panel_black:onClick(function()
            AlertManager:closeLayer(self)
        end)
    elseif (not self.eventID and self.rewards) then
        self.Image_content:setVisible(false)
        Utils:showReward(self.rewards)
    elseif (not self.rewards and self.eventID) then
        TFDirector:getChildByPath(self.Image_content, "ScrollView_reward"):hide()
    else
        assert(false)
    end
end

return DfwNewEventView