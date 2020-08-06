
local UseItemSelectView = class("UseItemSelectView", BaseLayer)

function UseItemSelectView:initData(itemId, itemNum)
    self.itemId_ = itemId
    self.itemNum_ = itemNum
    local itemInfo = GoodsDataMgr:getSingleItem(self.itemId_)
    self.itemCfg_ = GoodsDataMgr:getItemCfg(itemInfo.cid)
    self.selectItemData_ = self.itemCfg_.useProfit.custom.items
    self.selectCount_ = self.itemCfg_.useProfit.custom.count
    self.selectState_ = {}
    self.items_ = {}
    self.singleModel_ = (self.selectCount_ == 1)
    self.RichText_tips = nil
    self.costEnable_ = true
end

function UseItemSelectView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.bag.useItemSelectView")
end

function UseItemSelectView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")
    self.Image_tips_bg = TFDirector:getChildByPath(Image_content, "Image_tips_bg")
    self.Label_tips = TFDirector:getChildByPath(Image_content, "Label_tips")
    self.Button_ok = TFDirector:getChildByPath(Image_content, "Button_ok")
    self.Label_ok = TFDirector:getChildByPath(self.Button_ok, "Label_ok")
    self.Panel_size = TFDirector:getChildByPath(Image_content, "Panel_size")
    local ScrollView_reward = TFDirector:getChildByPath(Image_content, "ScrollView_reward")
    self.ListView_reward = UIListView:create(ScrollView_reward)
    -- self.ListView_cost = UIListView:create(ScrollView_cost)
    self.Label_name = TFDirector:getChildByPath(Image_content, "Label_name")
    self.Label_select_name = TFDirector:getChildByPath(Image_content, "Label_select_name"):hide()

    self.Panel_headItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_headItem")
    self.Image_starItem = TFDirector:getChildByPath(self.Panel_prefab, "Image_starItem")
    -- self.Panel_costItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_costItem")
    local ScrollView_desc = TFDirector:getChildByPath(Image_content, "ScrollView_desc")
    self.ScrollView_desc = UIListView:create(ScrollView_desc)

    self.Label_desc = TFDirector:getChildByPath(self.Panel_prefab, "Label_desc")

    self:refreshView()
end

function UseItemSelectView:refreshView()
    self.Label_name:setTextById(301024)
    self.Label_ok:setTextById(301026)

    local limitSize = self.Panel_size:getSize()
    for i, v in ipairs(self.selectItemData_) do
        local item = self:addRewardItem(Panel_headItem, i)
        self.ListView_reward:pushBackCustomItem(item)
    end
    local containerSize = self.ListView_reward:getInnerContainerSize()
    if containerSize.width <= limitSize.width then
        self.ListView_reward:s():setInertiaScrollEnabled(false)
        self.ListView_reward:s():setBounceEnabled(false)
        Utils:setAliginCenterByListView(self.ListView_reward, true)
    else
        self.ListView_reward:s():setContentSize(limitSize)
        self.ListView_reward:s():setBounceEnabled(true)
    end

    for i, v in ipairs(self.selectItemData_) do
        local item = self.ListView_reward:getItem(i)
        self:updateRewardItem(item, i)
    end

    -- for i, v in ipairs(self.itemCfg_.useCast) do
    --     local itemCfg = GoodsDataMgr:getItemCfg(v[1])
    --     local Panel_costItem = self.Panel_costItem:clone()
    --     local Image_costIcon = TFDirector:getChildByPath(Panel_costItem, "Image_costIcon")
    --     local Label_costNum = TFDirector:getChildByPath(Panel_costItem, "Label_costNum")
    --     local Label_costNumRed = TFDirector:getChildByPath(Panel_costItem, "Label_costNumRed")
    --     Image_costIcon:setTexture(itemCfg.icon)
    --     Label_costNum:setText(v[2])
    --     Label_costNumRed:setText(v[2])
    --     local isEnough = GoodsDataMgr:currencyIsEnough(v[1], v[2])
    --     if not isEnough then
    --         self.costEnable_ = false
    --     end
    --     Label_costNum:setVisible(isEnough)
    --     Label_costNumRed:setVisible(not isEnough)
    --     self.ListView_cost:pushBackCustomItem(Panel_costItem)
    -- end
    -- local containerSize = self.ListView_cost:getInnerContainerSize()
    -- self.ListView_cost:setContentSize(containerSize)

    self:updateSelectState()
end

function UseItemSelectView:addRewardItem()
    local item = self.Panel_headItem:clone()
    local foo = {}
    foo.root = item
    foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select"):hide()
    foo.Panel_head = TFDirector:getChildByPath(foo.root, "Panel_head")
    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    Panel_goodsItem:setTouchEnabled(false)
    Panel_goodsItem:Pos(0, 0):AddTo(foo.Panel_head, 1)
    foo.Panel_goodsItem = Panel_goodsItem
    self.items_[item] = foo
    return item
end

function UseItemSelectView:updateRewardItem(item, index)
    local foo = self.items_[item]
    local data = self.selectItemData_[index]
    local cid = data.id
    local num = data.num
    if GoodsDataMgr:isTimeLimitItem(data.id) then
        local itemTimeCfg = TabDataMgr:getItem("ItemTime", cid)
        cid = itemTimeCfg.itemId
    end
    local itemCfg = GoodsDataMgr:getItemCfg(cid)
    PrefabDataMgr:setInfo(foo.Panel_goodsItem, cid, num * self.itemNum_)

    foo.Panel_head:onClick(function()
            if self.singleModel_ then
                local originState = self.selectState_[index]
                self.selectState_ = {}
                self.selectState_[index] = not originState
                self:updateSelectState()
                for i, v in ipairs(self.ListView_reward:getItems()) do
                    local isSelect = (i == index)
                    local state = self.selectState_[i]
                    local bar = self.items_[v]
                    bar.Image_select:setVisible(isSelect and state)
                end
                local selectState = self.selectState_[index]
                self.Label_select_name:setVisible(selectState)
                self.Label_select_name:setTextById(itemCfg.nameTextId)

                self.ScrollView_desc:removeAllItems()
                local descItem = self.Label_desc:clone()
                descItem:setDimensions(680, 0)
                descItem:setTextById(itemCfg.desTextId)
                self.ScrollView_desc:pushBackCustomItem(descItem)
            else
                local rawState = self.selectState_[index]
                self.selectState_[index] = not self.selectState_[index]
                local selectCount = self:getSelectCount()
                if selectCount > self.selectCount_ then
                    self.selectState_[index] = rawState
                else
                    self:updateSelectState()
                    local isSelect = self.selectState_[index]
                    foo.Image_select:setVisible(isSelect)
                end
            end
    end)
end

function UseItemSelectView:registerEvents()
    EventMgr:addEventListener(self, EV_BAG_USE_ITEM, handler(self.onUseItemEvent, self))

    self.Button_close:onClick(
        function()
            AlertManager:closeLayer(self)
        end,
        EC_BTN.CLOSE)

    self.Button_ok:onClick(function()
            local selectIndex = {}
            for k, v in pairs(self.selectState_) do
                if v then
                    table.insert(selectIndex, k)
                end
            end
            GoodsDataMgr:useItem({{self.itemId_, self.itemNum_}}, "", "", selectIndex)
    end)
end

function UseItemSelectView:getSelectCount()
    local count = 0
    for k, v in pairs(self.selectState_) do
        if v  then
            count = count + 1
        end
    end
    return count
end

function UseItemSelectView:updateSelectState()
    local count = self:getSelectCount()
    local remainCount = math.max(0, self.selectCount_ - count)

    local selectOver = (remainCount == 0)
    if not selectOver then
        self.ScrollView_desc:setVisible(false)
        self.Label_tips:setTextById(301025, remainCount)
    else
        self.ScrollView_desc:setVisible(true)
    end
    self.Button_ok:setVisible(selectOver)
    -- self.ListView_cost:setVisible(selectOver)
    self.Image_tips_bg:setVisible(not selectOver)
end

function UseItemSelectView:onUseItemEvent(reward,isSkyLadderCardBag)
    AlertManager:closeLayer(self)
    if next(reward) then
        Utils:showReward(reward)
    end
end

return UseItemSelectView
