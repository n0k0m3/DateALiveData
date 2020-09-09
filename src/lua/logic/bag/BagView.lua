
local BagView = class("BagView", BaseLayer)

function BagView:initData(mainSelectIndex, selectIndex)
    self.btnConfig_ = {
        -- {
        --     txt = 301001,
        --     bag = {EC_Bag.ANGEL},
        --     sellType = EC_BagSellType.MULTISELECT,
        --     category = EC_BagCategory.ANGEL,
        -- },
        {
            txt = 301002,
            iconImg = "ui/bag/new_ui/new_11.png",
            bag = {EC_Bag.SPIRIT},
            sellType = EC_BagSellType.MULTISELECT,
            category = EC_BagCategory.EQUIPMENT,
        },
        {
            txt = 301003,
            iconImg = "ui/bag/new_ui/new_12.png",
            bag = {EC_Bag.MATERIAL, EC_Bag.ITEM, EC_Bag.GIFT, EC_Bag.HOUSE},
            sellType = EC_BagSellType.SINGLESELECT,
            category = EC_BagCategory.MATERIAL,
            config_Ex = {
                {
                    txt = 14300200,
                    iconImg = "ui/bag/new_ui/drawing.png",
                    bag = {EC_Bag.DRAWING},
                    category = EC_BagCategory.MATERIAL,
                    sellType = EC_BagSellType.SINGLESELECT,
                    isExtend = true
                },
                {
                    txt = 14300201,
                    iconImg = "ui/bag/new_ui/fragment.png",
                    bag = {EC_Bag.FRAGMENT},
                    category = EC_BagCategory.MATERIAL,
                    sellType = EC_BagSellType.SINGLESELECT,
                    isExtend = true
                },
                {
                    txt = 14300202,
                    iconImg = "ui/fairy/new_ui/tab_2.png",
                    bag = {EC_Bag.CRYSTYL},
                    category = EC_BagCategory.MATERIAL,
                    sellType = EC_BagSellType.SINGLESELECT,
                    isExtend = true
                },
                {
                    txt = 14300203,
                    iconImg = "ui/bag/new_ui/other.png",
                    bag = {EC_Bag.MATERIAL},
                    category = EC_BagCategory.MATERIAL,
                    sellType = EC_BagSellType.SINGLESELECT,
                    isExtend = true
                },
                
            },
            isExtendOpen = false

        },
        {
            txt = 301004,
            iconImg = "ui/bag/new_ui/new_13.png",
            bag = {EC_Bag.USEITEM},
            sellType = EC_BagSellType.SINGLESELECT,
            category = EC_BagCategory.ITEM,
			
        },
        {
            txt = 225007,
            iconImg = "ui/fairy/new_ui/tab_6.png",
            bag = {EC_Bag.NEWEQUIP},
            category = EC_BagCategory.NEWEQUIP,
        },
        --{
        --    txt = 301023,
        --    iconImg = "ui/fairy/new_ui/tab_7.png",
        --    bag = {EC_Bag.TRAILCARD},
        --    category = EC_BagCategory.TRAILCARD,
        --    sellType = EC_BagSellType.SINGLESELECT,
        --},
        {
            txt = 1100001,
            iconImg = "ui/fairy/new_ui/tab_8.png",
            bag = {EC_Bag.BAOSHI},
            category = EC_BagCategory.BAOSHI,
            sellType = EC_BagSellType.MULTISELECT,
        },
        
    }

    self.ruleType = {
        Level = 1,
        Quality = 2,
        SubType = 3,
        Suit = 4,
    }
    self.ruleText_ = {
        [self.ruleType.Level] = 301017,
        [self.ruleType.Quality] = 301016,
        [self.ruleType.SubType] = 301015,
        [self.ruleType.Suit] = 301022,
    }
    self.orderText_ = {301018, 301019}

    self.defaultSelectIndex_ = selectIndex or 1
	self.mainSelectIndex = mainSelectIndex or 1

    self.defaultSelectRuleIndex_ = self.ruleType.Level
    self.selectRuleIndex_ = self.defaultSelectRuleIndex_
    self.selectOrderIndex_ = 1
    self.lastEquipSellBtnStarIdx = -1
    self.selectBaoshiRarity = -1

    self.selectIndex_ = nil
    self.scrollBar_ = {}
    self.GridView_item = {}
    self.cacheGoodsItem_ = {}
    self.goodsItem_ = {}
    self.loadItemIndex_ = {}
    self.goodsData_ = {}
    self.isCache_ = {}
    self.isSellModel_ = false
    self.sellSelectItem_ = {}
    self.sellSelectData_ = {}

    self.equipSellBtns = {}
    self.baoshiRarityItem = {}

    -- 倒计时
    self.countDownTimer_ = nil

    self.extendIdxTabs = {}
end

function BagView:getClosingStateParams()
    return {self.mainSelectIndex, self.selectIndex_}
end

function BagView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.bag.itemBagView")
end

function BagView:initUI(ui)
    self:showTopBar()

    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    local Panel_middle = TFDirector:getChildByPath(self.Panel_root, "Panel_middle")
    self.ScrollView_item = TFDirector:getChildByPath(Panel_middle, "ScrollView_item"):hide()
    self.Image_scrollBarModel = TFDirector:getChildByPath(Panel_middle, "Image_scrollBarModel"):hide()
    self.Label_capacity = TFDirector:getChildByPath(Panel_middle, "Label_capacity")
    self.Label_capacity_percent = TFDirector:getChildByPath(Panel_middle, "Label_capacity_percent")
    self.LoadingBar_capacity = TFDirector:getChildByPath(Panel_middle, "LoadingBar_capacity")

    self.Panel_bottom = TFDirector:getChildByPath(self.Panel_root, "Panel_bottom")
    self.Button_sell = TFDirector:getChildByPath(self.Panel_bottom, "Button_sell")
    self.Panel_left = TFDirector:getChildByPath(self.Panel_root, "Panel_left")

    local ScrollView_tab = TFDirector:getChildByPath(self.Panel_left, "ScrollView_tab")
    self.ListView_tab = UIListView:create(ScrollView_tab)
    self.Panel_sell = TFDirector:getChildByPath(self.Panel_bottom, "Panel_sell")
    self.Button_cancel = TFDirector:getChildByPath(self.Panel_sell, "Button_cancel")
    self.Button_realSell = TFDirector:getChildByPath(self.Panel_sell, "Button_realSell")
    self.Panel_sellType_1 = TFDirector:getChildByPath(self.Panel_bottom, "Panel_sellType_1")
    self.Button_sellAdd = TFDirector:getChildByPath(self.Panel_sellType_1, "Button_sellAdd")
    self.Button_sellSub = TFDirector:getChildByPath(self.Panel_sellType_1, "Button_sellSub")
    self.Label_sellCount = TFDirector:getChildByPath(self.Panel_sellType_1, "Label_sellCount")
    self.Button_sellMax = TFDirector:getChildByPath(self.Panel_sellType_1, "Button_sellMax")
    self.Button_merge    = TFDirector:getChildByPath(self.Panel_bottom,"Button_merge"):hide()
    self.Button_specialCompose    = TFDirector:getChildByPath(self.Panel_bottom,"Button_specialCompose"):hide()
    self.Button_decompose    = TFDirector:getChildByPath(self.Panel_bottom,"Button_decompose"):hide()
    

    self.Panel_sort = TFDirector:getChildByPath(ui, "Panel_sort")

    self.Panel_sellEquip = TFDirector:getChildByPath(self.Panel_sell, "Panel_sellEquip")
    for i = 1, 3 do
        local Button_sellStar = TFDirector:getChildByPath(self.Panel_sellEquip, "Button_sellStar"..i)
        Button_sellStar.imageSelect = Button_sellStar:getChild("Image_select")
        Button_sellStar.star = i
        table.insert(self.equipSellBtns, Button_sellStar)
        Button_sellStar:onClick(function(sender)
            local function clearSellSelect()
                for i1, v1 in ipairs(self.sellSelectItem_) do
                    self:updateSelectGoodsItem(v1, false)
                end
                self.sellSelectItem_ = {}
                self.sellSelectData_ = {}
            end
            local goodsData = self.goodsData_[self.selectIndex_]
            local gridView = self.GridView_item[self.selectIndex_]
            clearSellSelect()
            if self.lastEquipSellBtnStarIdx ~= sender.star then
                self.lastEquipSellBtnStarIdx = sender.star
                for i2, v2 in ipairs(goodsData) do
                    local cfgEquip = TabDataMgr:getData("Equipment", v2.cid)
                    if cfgEquip.star == sender.star and cfgEquip.subType ~= 100 and not EquipmentDataMgr:getEquipIsLockOrUsing(v2.id) then
                        local item = gridView:getItem(i2)
                        if item then
                            self:selectGoodsItem(item, v2)
                        else
                            self.lastEquipSellBtnStarIdx = -1
                            clearSellSelect()
                            break
                        end
                    end
                end
            else
                self.lastEquipSellBtnStarIdx = -1
            end
            for i, v in ipairs(self.equipSellBtns) do
                if self.lastEquipSellBtnStarIdx == i then
                    v.imageSelect:show()
                else
                    v.imageSelect:hide()
                end
            end
        end)
    end

    self.Panel_baoshi_rarity = TFDirector:getChildByPath(self.Panel_sell, "Panel_baoshi_rarity")
    for i = 1, 3 do
        local Panel_quality_item = TFDirector:getChildByPath(self.Panel_baoshi_rarity, "Panel_quality_item"..i)
        Panel_quality_item.Image_bg = Panel_quality_item:getChild("Image_bg")
        Panel_quality_item.rarity = i
        table.insert(self.baoshiRarityItem, Panel_quality_item)
        Panel_quality_item:setTouchEnabled(true)
        Panel_quality_item:onClick(function(sender)
            local function clearSellSelect()
                for i1, v1 in ipairs(self.sellSelectItem_) do
                    self:updateSelectGoodsItem(v1, false)
                end
                self.sellSelectItem_ = {}
                self.sellSelectData_ = {}
            end
            local goodsData = self.goodsData_[self.selectIndex_]
            local gridView = self.GridView_item[self.selectIndex_]
            clearSellSelect()
            if self.selectBaoshiRarity ~= sender.rarity then
                self.selectBaoshiRarity = sender.rarity
                for i2, v2 in ipairs(goodsData) do
                    local gemCfg = EquipmentDataMgr:getGemCfg(v2.cid)
                    if gemCfg.rarity == sender.rarity and not EquipmentDataMgr:checkGemInUse(v2.id) then
                        local item = gridView:getItem(i2)
                        if item then
                            self:selectGoodsItem(item, v2)
                        else
                            self.selectBaoshiRarity = -1
                            clearSellSelect()
                            break
                        end
                    end
                end
            else
                self.selectBaoshiRarity = -1
            end
            for i, v in ipairs(self.baoshiRarityItem) do
                if self.selectBaoshiRarity == i then
                    v.Image_bg:setTexture("ui/fairy/new_ui/baoshi/071.png")
                else
                    v.Image_bg:setTexture("ui/fairy/new_ui/baoshi/072.png")
                end
            end
        end)
    end

    self.Button_sort_order = TFDirector:getChildByPath(self.Panel_sort, "Button_sort_order")
    self.Label_order_name = TFDirector:getChildByPath(self.Button_sort_order, "Label_order_name")
    self.Image_order_icon = TFDirector:getChildByPath(self.Button_sort_order, "Image_order_icon")
    self.Panel_order = TFDirector:getChildByPath(self.Panel_sort, "Panel_order"):hide()
    self.button_order = {}
    for i = 1, 2 do
        local Label_order = TFDirector:getChildByPath(self.Panel_order, "Label_order_" .. i)
        Label_order:setTextById(self.orderText_[i])
        self.button_order[i] = TFDirector:getChildByPath(self.Panel_order, "Button_order_" .. i)
    end

    self.Button_sortRule = TFDirector:getChildByPath(self.Panel_sort, "Button_sortRule")
    self.Label_sortRule = TFDirector:getChildByPath(self.Button_sortRule, "Label_sortRule")
    self.Panel_sortRule = TFDirector:getChildByPath(self.Panel_sort, "Panel_sortRule"):hide()
    self.Button_rule = {}
    for i = 1, 4 do
        local Button_rule = TFDirector:getChildByPath(self.Panel_sortRule, "Button_rule_" .. i)
        TFDirector:getChildByPath(Button_rule, "Label_nameSelect"):setTextById(self.ruleText_[i])
        self.Button_rule[i] = Button_rule
    end

    self.Panel_tabItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_tabItem")
    self.Panel_tabItem.Icon_menu = TFDirector:getChildByPath(self.Panel_tabItem, "Icon_menu")
    self.Panel_tabItem.Icon_menu:setVisible(false)

    self.Panel_headItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_headItem")
    self.Image_starItem = TFDirector:getChildByPath(self.Panel_prefab, "Image_starItem")

    self.Panel_tabItemNull = TFDirector:getChildByPath(self.Panel_prefab, "Panel_tabItemNull")


    self.Label_capacity:enableOutline(ccc4(0,0,0,50),1)
    self.Label_capacity_percent:enableOutline(ccc4(0,0,0,50),1)
    self.Label_order_name:enableOutline(ccc4(0,0,0,50),1)
    self.Label_sortRule:enableOutline(ccc4(0,0,0,50),1)
    TFDirector:getChildByPath(Panel_middle, "Label_capacity_name"):enableOutline(ccc4(0,0,0,50),1)
    TFDirector:getChildByPath(self.Button_realSell, "Label_itemBagView_1"):enableOutline(ccc4(0,0,0,75),1)
    TFDirector:getChildByPath(self.Button_cancel, "Label_cancel"):enableOutline(ccc4(0,0,0,75),1)
    TFDirector:getChildByPath(self.Button_sell, "Label_sell"):enableOutline(ccc4(0,0,0,75),1)
    TFDirector:getChildByPath(self.Button_merge, "Label_merge"):enableOutline(ccc4(0,0,0,75),1)
    TFDirector:getChildByPath(self.Button_specialCompose, "Label_merge"):enableOutline(ccc4(0,0,0,75),1)
    TFDirector:getChildByPath(self.Button_decompose, "Label_merge"):enableOutline(ccc4(0,0,0,75),1)

    self.Panel_touch = TFDirector:getChildByPath(self.Panel_root, "Panel_touch")
    self.touch3DPanel = TFDirector:getChildByPath(ui, "panel_3DTouch")

    self:refreshView()
    GoodsDataMgr:checkRecover()
end

function BagView:onShow()
    self.super.onShow(self)
    self.touch3DPanel:hide()
end

function BagView:refreshView()
    self.Label_sortRule:setTextById(self.ruleText_[1])
    self.Label_order_name:setTextById(self.orderText_[1])
    self.Image_order_icon:setFlipY(self.selectOrderIndex_ == 1)

    self:initGridView()

    self.Panel_sell:hide()

    self:initTabBtn()

    self:selectTabBtn(self.defaultSelectIndex_)

    self:addCountDownTimer()
end

function BagView:initGridView()

    for i, v in ipairs(self.btnConfig_) do
        if self.scrollBar_[i] == nil then
            local Image_scrollBar = self.Image_scrollBarModel:clone():show()
            local Image_scrollBarInner = TFDirector:getChildByPath(Image_scrollBar, "Image_scrollBarInner")
            Image_scrollBar:AddTo(self.Image_scrollBarModel:getParent())
            local scrollBar = UIScrollBar:create(Image_scrollBar, Image_scrollBarInner)
            self.scrollBar_[i] = scrollBar
        end

        if self.GridView_item[i] == nil then
            local ScrollView_item = self.ScrollView_item:clone():show()
            ScrollView_item:AddTo(self.ScrollView_item:getParent(), 1)
            local GridView_item = UIGridView:create(ScrollView_item)
            GridView_item:setItemModel(self.Panel_headItem)
            GridView_item:setColumn(7)
            GridView_item:setColumnMargin(10)
            GridView_item:setRowMargin(10)
            GridView_item:setScrollBar(scrollBar)
            self.GridView_item[i] = GridView_item
        end
    end
end

function BagView:initTabBtn()
    self.ListView_tab:setItemsMargin(2)
    self.tabBtn_ = {}
    for i, v in ipairs(self.btnConfig_) do
        local Panel_tabItem = self.Panel_tabItem:clone()
        local item = {}
        item.Label_name = TFDirector:getChildByPath(Panel_tabItem, "Label_name")
        item.Image_normal = TFDirector:getChildByPath(Panel_tabItem, "Image_normal")
        item.Image_select = TFDirector:getChildByPath(Panel_tabItem, "Image_select")
        item.Image_icon = TFDirector:getChildByPath(Panel_tabItem, "Image_icon")
        item.Icon_menu = TFDirector:getChildByPath(Panel_tabItem, "Icon_menu")
        item.Image_touch = TFDirector:getChildByPath(Panel_tabItem, "Image_touch")

        self.tabBtn_[i] = item
        item.Image_icon:setTexture(v.iconImg)
        item.Label_name:setTextById(v.txt)
        item.Icon_menu:setVisible(v.config_Ex and #v.config_Ex > 0)

        self.ListView_tab:pushBackCustomItem(Panel_tabItem)
    end
end

function BagView:selectTabBtn(index)

    if index > #self.btnConfig_ then--选择扩展按钮
        local n_ = index - #self.btnConfig_
        self:selectTabBtn(self.mainSelectIndex)
        
        local item = self.tabBtn_Ex[n_]
        self:clickExBtn(item, n_)
    else
        self:updateBtnView(index)
        self:updateExtendBtn(index)
    end    
end

function BagView:updateBtnView(index)
    local config = self.btnConfig_[index]
    if config == nil then
        return;
    end
    if self.selectIndex_ == index and not (config.config_Ex and #config.config_Ex > 0) then return end
    self.selectIndex_ = index
    local btnConfig = self.btnConfig_[self.selectIndex_]

    for i, v in ipairs(self.tabBtn_) do
        local isSelect = (i == index)
        v.Image_normal:setVisible(not isSelect)
        v.Image_select:setVisible(isSelect)
    end

    local function __opacity()
        for i, v in ipairs(self.GridView_item) do
            local visible = (index == i)
            v:setVisible(visible)
            if visible then
                for _, item in ipairs(v:getItems()) do
                    item:Alpha(0)
                end
            end
        end
    end

    for i, v in ipairs(self.scrollBar_) do
        v:setVisible(index == i)
    end

    if btnConfig.category == EC_BagCategory.EQUIPMENT then
        __opacity()
        self.Panel_sort:show()
        self:selectSortRule()
    else
        self.Panel_sort:hide()

        if btnConfig.config_Ex and #btnConfig.config_Ex > 0 then
            
        else
            __opacity()
            self:updateBag(self.selectIndex_)
        end
    end

    local isMultiType = (btnConfig.sellType == EC_BagSellType.MULTISELECT)
    self.Panel_sellType_1:setVisible(not isMultiType)

    self.isCache_[index] = true

    self:buttonSellStatusUpdate()

    if self.Panel_sell:isVisible() then
        self:setSellVisible(false)
    end
end

function BagView:clickExBtn(sender,index)
   if self.curBtnInfoEx then
      self.curBtnInfoEx.Image_normal:setVisible(true)
      self.curBtnInfoEx.Image_select:setVisible(false)
   end
   self.tabBtn_[index].Image_normal:setVisible(true)
   self.tabBtn_[index].Image_select:setVisible(false)

   sender.item.Image_normal:setVisible(false)
   sender.item.Image_select:setVisible(true)
   self.curBtnInfoEx = sender.item

   self:updateBtnView(#self.tabBtn_ + sender.item.idx)
end

function BagView:updateExtendBtn(index)
    print("123123",self.defaultSelectIndex_)
    local btnConfig = self.btnConfig_[self.selectIndex_ or self.defaultSelectIndex_]
    if btnConfig == nil then
        return;
    end

    if btnConfig.config_Ex and btnConfig.isExtendOpen == false then
        self.tabBtn_Ex = {}

        local __clickCallBack = function(sender)
           if self.curBtnInfoEx then
               self.curBtnInfoEx.Image_normal:setVisible(true)
               self.curBtnInfoEx.Image_select:setVisible(false)
           end
           self.tabBtn_[index].Image_normal:setVisible(true)
           self.tabBtn_[index].Image_select:setVisible(false)

           sender.item.Image_normal:setVisible(false)
           sender.item.Image_select:setVisible(true)
           self.curBtnInfoEx = sender.item

           self:updateBtnView(#self.tabBtn_ + sender.item.idx)
        end
        for k, v in pairs(btnConfig.config_Ex) do
           local Panel_tabItemNull = self.Panel_tabItemNull:clone()

           local idx = index + k
           self.ListView_tab:insertCustomItem(Panel_tabItemNull, idx)

           table.insert(self.extendIdxTabs, idx)

           local Panel_tabItem = self.Panel_tabItem:clone()
           Panel_tabItem:setAnchorPoint(ccp(0.5,0.50))
           Panel_tabItemNull:addChild(Panel_tabItem)

           local size = self.Panel_tabItem:getContentSize()
           Panel_tabItem:setPosition(ccp(0, 0))

           local item = {}
           item.Label_name = TFDirector:getChildByPath(Panel_tabItem, "Label_name")
           item.Image_normal = TFDirector:getChildByPath(Panel_tabItem, "Image_normal")
           item.Image_normal:setTexture("ui/bag/new_ui/new_01.png")
           item.Image_normal:setContentSize(CCSizeMake(95,96))
           item.Image_normal:setVisible(true)
           item.Image_select = TFDirector:getChildByPath(Panel_tabItem, "Image_select")
           item.Image_select:setVisible(false)
           item.Image_icon = TFDirector:getChildByPath(Panel_tabItem, "Image_icon")
           Image_touch = TFDirector:getChildByPath(Panel_tabItem, "Image_touch")
           item.idx = k

           Image_touch.item = item
           item.Image_icon:setTexture(v.iconImg)
           item.Label_name:setTextById(v.txt)

           Image_touch:onClick(__clickCallBack)

           self.btnConfig_[#self.btnConfig_ + 1] = v

           self.tabBtn_Ex[k] = Image_touch
        end


        self.tabBtn_[index].Icon_menu:setRotation(0)

        self:initGridView()

        __clickCallBack(self.tabBtn_Ex[1])

        if #btnConfig.config_Ex > 0 then
            btnConfig.isExtendOpen = true
        end
    else--close ExtendBtn
        for i = #self.extendIdxTabs, 1, -1 do
            local idx = self.extendIdxTabs[i]
            self.ListView_tab:removeItem(idx)
        end

        self.extendIdxTabs = {}

        self.curBtnInfoEx = nil

        for i = #self.btnConfig_, 1, -1 do
            local v = self.btnConfig_[i]
            if v.config_Ex and v.isExtendOpen == true then
                 v.isExtendOpen = false
                 self.tabBtn_[i].Icon_menu:setRotation(-90)
            end

            if v.isExtend == true then
                table.remove(self.btnConfig_, i)
            end
        end
    end


    --
end

function BagView:updateBag(index)
    self:updateGoodsData(index)
    self.loadItemIndex_[self.selectIndex_] = 1
    if self.isCache_[index] then
        self:showGoodsItem()
    else
        self:fillGoodsItem()
    end

    self:updateCapacity()
end

function BagView:updateCapacity()
    local data = self.goodsData_[self.selectIndex_]
    self.Label_capacity:setTextById(800005, #data, 999)
    self.Label_capacity_percent:setText(string.format("%0.1f",(#data / 999 * 100)).."%")
    self.LoadingBar_capacity:setPercent(#data / 999 * 100)
end

function BagView:showGoodsItem()
    local goodsData = self.goodsData_[self.selectIndex_]
    if goodsData == nil then
        return;
    end
    local loadIndex = self.loadItemIndex_[self.selectIndex_]
    local firstData = goodsData[loadIndex]
    if not firstData then return end

    local gridView = self.GridView_item[self.selectIndex_]
    local column = gridView:getColumn()
    local fadeInDuration = 0.15
    local delayDuration = 0.05
    for i = loadIndex, math.min(loadIndex + column - 1, #goodsData) do
        local item = gridView:getItem(i)
        if not item then
            item = self:addGoodsItem()
            item:Alpha(0)
        end
        item:fadeIn(fadeInDuration)
        self:updateGoodsItem(item, goodsData[i])
    end
    local seq = Sequence:create({
            DelayTime:create(delayDuration),
            CallFunc:create(function()
                    self.loadItemIndex_[self.selectIndex_] = loadIndex + column
                    self:showGoodsItem()
            end)
    })
    self.Panel_root:stopAllActions()
    self.Panel_root:runAction(seq)
end

function BagView:fillGoodsItem()
    local loadIndex = self.loadItemIndex_[self.selectIndex_]
    local goodsData = self.goodsData_[self.selectIndex_]
    if goodsData == nil then
        return
    end
    local data = goodsData[loadIndex]
    if not data then return end

    local item = self.GridView_item[self.selectIndex_]:getItem(loadIndex)
    if not item then
        item = self:addGoodsItem()
        item:Alpha(0)
    end
    self:updateGoodsItem(item, data)
    local fadeInDuration = 0.2
    local delayDuration = 0.05
    item:fadeIn(fadeInDuration)
    local seq = Sequence:create({
            DelayTime:create(delayDuration),
            CallFunc:create(function()
                    self.loadItemIndex_[self.selectIndex_] = loadIndex + 1
                    self:fillGoodsItem()
            end)
    })
    item:runAction(seq)
end

function BagView:addGoodsItem()
    local item = self.GridView_item[self.selectIndex_]:pushBackDefaultItem()
    local foo = {}
    foo.root = item
    foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select")
    foo.Image_limit = TFDirector:getChildByPath(foo.root, "Image_limit")
    foo.Label_time = TFDirector:getChildByPath(foo.root, "Label_time")
    foo.Panel_aging = TFDirector:getChildByPath(foo.root, "Panel_aging")
    foo.Image_new = TFDirector:getChildByPath(foo.root, "Image_new")
    foo.Image_lock = TFDirector:getChildByPath(foo.root, "Image_lock")
    foo.Panel_head = TFDirector:getChildByPath(foo.root, "Panel_head")
    foo.Label_aging = TFDirector:getChildByPath(foo.Image_aging, "Label_aging")
    foo.Image_carry = TFDirector:getChildByPath(foo.root, "Image_carry")
    foo.trail_flag = TFDirector:getChildByPath(foo.root, "trail_flag")
    foo.Panel_pos = TFDirector:getChildByPath(foo.root, "Panel_pos"):hide()

    --限时图标
    local limit_icon = TFImage:create("ui/bag/new_ui/limit.png");
    foo.root:addChild(limit_icon,999)
    limit_icon:setPosition(ccp(30,40));
    limit_icon:hide();
    foo.limit_icon = limit_icon;

    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    Panel_goodsItem:setTouchEnabled(false)
    Panel_goodsItem:Pos(0, 0)
    Panel_goodsItem:AddTo(foo.Panel_head)
    foo.Panel_goodsItem = Panel_goodsItem
    self.goodsItem_[item] = foo
    return item
end

function BagView:updateGoodsItem(item, data)
    local itemCfg = GoodsDataMgr:getItemCfg(data.cid)
    local foo = self.goodsItem_[item]
    if not foo then
        item = self:addGoodsItem();--何博修改的
        foo = self.goodsItem_[item];
    end
    foo.Image_select:hide()
    foo.Label_time:hide()
    foo.trail_flag:hide()
    foo.Panel_aging:hide()
    foo.limit_icon:setVisible(data.outTime)
    PrefabDataMgr:setInfo(foo.Panel_goodsItem, data.id, data.num)

    -- 是否装备
    if itemCfg.superType == EC_ResourceType.SPIRIT then
        local isCarry = EquipmentDataMgr:isUesing(data.id)
        foo.Image_carry:setVisible(isCarry)
    elseif itemCfg.superType == EC_ResourceType.FETTERS then
        local isCarry = EquipmentDataMgr:checkNewEquipInUse(itemCfg.id)
        foo.Image_carry:setVisible(isCarry)
    elseif itemCfg.superType == EC_ResourceType.BAOSHI then
        local isCarry = EquipmentDataMgr:checkGemInUse(data.id)
        foo.Image_carry:setVisible(isCarry)
    else
        foo.Image_carry:hide()
    end

    foo.Image_new:setVisible(GoodsDataMgr:isNewGet(data.id))
    GoodsDataMgr:clearNew(data.id)

    -- 是否限时道具
    if data.outTime then
        -- foo.Label_time:show()
        self:updateOutTime(item, data)
    end

    --是否锁定
    foo.Image_lock:setVisible(data.isLock)

    -- 判断是否已达上限
    local count = GoodsDataMgr:getItemCount(data.cid)
    if itemCfg.subType == 100 and itemCfg.superType == EC_ResourceType.SPIRIT then
        count = data.num
    end

    local isOverflow = count >= itemCfg.totalMax
    if itemCfg.superType == EC_ResourceType.FETTERS then
        isOverflow = false
    end
    
    if itemCfg.superType == EC_ResourceType.TRAILCARD then
        isOverflow = false
        foo.trail_flag:show()
    end
    foo.Image_limit:setVisible(isOverflow)

    if itemCfg.superType == EC_ResourceType.BAOSHI then
        foo.Panel_pos:show()
        TFDirector:getChildByPath(foo.Panel_pos, "Image_pos_bg"):setTexture(EquipmentDataMgr:getGemPosBg(itemCfg.quality))
        for i=1,4 do
            TFDirector:getChildByPath(foo.Panel_pos, "Image_pos"..i):setTexture(itemCfg.skillType == i and "ui/fairy/new_ui/baoshi/032.png" or "ui/fairy/new_ui/baoshi/031.png")
        end
    end

    -- foo.Panel_head:onClick(function()
    --         if self.isSellModel_ then
    --             self:selectGoodsItem(item, data)
    --         else
    --             if itemCfg.superType == EC_ResourceType.SPIRIT then
    --                 local index
    --                 for i, v in ipairs(self.btnConfig_) do
    --                     if v.category == EC_BagCategory.EQUIPMENT then
    --                         index = i
    --                         break
    --                     end
    --                 end
    --                 if index then
    --                     local equipment = self.goodsData_[index]
    --                     local equips = {}
    --                     for i, v in ipairs(equipment) do
    --                         table.insert(equips, v.id)
    --                     end
    --                     Utils:openView("Equipment.EquipmentInfo", {equipmentId = data.id,equips = equips, fromBag = true})
    --                 end
    --             elseif itemCfg.superType == EC_ResourceType.FETTERS then
    --                 if not FunctionDataMgr:checkFuncOpen(80) then
    --                     return
    --                 end 
    --                 Utils:openView("fairyNew.EquipSuitBagShowView",{cid = itemCfg.id})
    --             -- elseif itemCfg.superType == EC_ResourceType.TRAILCARD then
    --             --     local isHave = HeroDataMgr:getIsHave(itemCfg.useProfit.id)
    --             --     if isHave then -- 出售试用卡
    --             --         GoodsDataMgr:checkRecover( )
    --             --     else
    --             --         Utils:showInfo(data.cid, data.id, true)
    --             --     end
    --             elseif itemCfg.superType == EC_ResourceType.BAOSHI then
    --                 Utils:openView("fairyNew.BaoshiDetailView", {id = data.id,cid = data.cid,heroId = itemCfg.heroId,pos = itemCfg.skillType,fromBag = true})
    --             else
    --                 Utils:showInfo(data.cid, data.id, true)
    --             end
    --         end
    -- end)

    local function headPanel_Clicked(node, data)
        if self.isSellModel_ then
            self:selectGoodsItem(item, data)
        else
            if itemCfg.superType == EC_ResourceType.SPIRIT then
                local index
                for i, v in ipairs(self.btnConfig_) do
                    if v.category == EC_BagCategory.EQUIPMENT then
                        index = i
                        break
                    end
                end
                if index then
                    local equipment = self.goodsData_[index]
                    local equips = {}
                    for i, v in ipairs(equipment) do
                        table.insert(equips, v.id)
                    end
                    Utils:openView("Equipment.EquipmentInfo", {equipmentId = data.id,equips = equips, fromBag = true})
                end
            elseif itemCfg.superType == EC_ResourceType.FETTERS then
                if not FunctionDataMgr:checkFuncOpen(80) then
                    return
                end 
                Utils:openView("fairyNew.EquipSuitBagShowView",{cid = itemCfg.id})
        -- elseif itemCfg.superType == EC_ResourceType.TRAILCARD then
            --     local isHave = HeroDataMgr:getIsHave(itemCfg.useProfit.id)
            --     if isHave then -- 出售试用卡
            --         GoodsDataMgr:checkRecover( )
            --     else
            --         Utils:showInfo(data.cid, data.id, true)
            --     end
            elseif itemCfg.superType == EC_ResourceType.BAOSHI then
                Utils:openView("fairyNew.BaoshiDetailView", {id = data.id,cid = data.cid,heroId = itemCfg.heroId,pos = itemCfg.skillType,fromBag = true})
            else
                Utils:showInfo(data.cid, data.id, true)               
            end
        end
    end
    local function headPanel_Touch3D(node, data)       
        --质点不可出售
        local itemCfg = GoodsDataMgr:getItemCfg(data.cid)
        if itemCfg.superType == EC_ResourceType.FETTERS then
            return
        end
        if self.touch3DPanel:isVisible() then return end
        self.touch3DPanel:show()

        local bgImg = TFDirector:getChildByPath(self.touch3DPanel, "img_bg")
        bgImg:setOpacity(0)
        bgImg:setScale(0)      
        
        local sellBtn = TFDirector:getChildByPath(self.touch3DPanel, "btn_sell")
        sellBtn:show()
        sellBtn:setPosition(ccp(7, 25))
        TFDirector:getChildByPath(sellBtn, "label_sell"):enableOutline(ccc4(0,0,0,75),1)

        local sellAllBtn = TFDirector:getChildByPath(self.touch3DPanel, "btn_sellAll")
        sellAllBtn:show()
        sellAllBtn:setPosition(ccp(5, -24))
        TFDirector:getChildByPath(sellAllBtn, "label_sellAll"):enableOutline(ccc4(0,0,0,75),1)

        local pos = node:getPosition()
        local wp = node:getParent():convertToWorldSpace(pos)
        local endPos = self.touch3DPanel:convertToNodeSpaceAR(wp)
        local itemScrollViewSize = self.ScrollView_item:getContentSize()
        if (itemScrollViewSize.width - node:getParent():getPositionX()) > 250 then           
            endPos.x = endPos.x + node:getContentSize().width*1.8
            endPos.y = endPos.y + node:getContentSize().height*0.6        
            bgImg:setFlipX(true)
            local btnConfig = self.btnConfig_[self.selectIndex_]
            if btnConfig.category == EC_BagCategory.EQUIPMENT then
                sellAllBtn:hide()            
                sellBtn:setPosition(ccp(5, 0))
                endPos.x = endPos.x - 10
                bgImg:setPosition(endPos) 
            else
                endPos.x = endPos.x - 10
                bgImg:setPosition(endPos) 
                bgImg:setPosition(endPos) 
            end             
        else
            endPos.x = endPos.x - node:getContentSize().width*0.6
            endPos.y = endPos.y + node:getContentSize().height*0.6
            bgImg:setPosition(endPos)                 
            bgImg:setFlipX(false)      
            local btnConfig = self.btnConfig_[self.selectIndex_]  
            if btnConfig.category == EC_BagCategory.EQUIPMENT then
                sellAllBtn:hide()            
                sellBtn:setPosition(ccp(-5, 0))
                endPos.x = endPos.x + 10
                bgImg:setPosition(endPos) 
            else
                endPos.x = endPos.x + 10
                bgImg:setPosition(endPos) 

                sellBtn:setPosition(ccp(-8, 21))
                sellAllBtn:setPosition(ccp(-8, -28))
            end            
        end

        local fadeIn = FadeIn:create(0.1)
        local scaleTo = ScaleTo:create(0.1, 1)
        bgImg:stopAllActions()
        bgImg:runAction(Spawn:create({fadeIn, scaleTo}))

        sellBtn:addMEListener(TFWIDGET_CLICK, audioClickfun(handler(function()
            self:send3DTouchItem(sellBtn, data) 

            self.touch3DPanel:hide()
        end, self)),1)
        sellAllBtn:addMEListener(TFWIDGET_CLICK, audioClickfun(handler(function()          
            self:send3DTouchItem(sellAllBtn, data)                  
            self.touch3DPanel:hide()
        end, self)),1)
    end
    self:registerTouchFunc(foo.Panel_head, data, headPanel_Clicked, headPanel_Touch3D) 
end

function BagView:registerTouchFunc(node, data, clickCallBack, touch3DCallBack)
    local onTouched = function(eventName, ...)
            local params = {...}
            local sender = params[1]
            local touchPos = params[2]
            local forceParam = params[#params]

            if sender:hitTest(touchPos) then
                print("forceParam === ", forceParam, eventName)

                if eventName == "began" then
                    self.isShowSubMenu = false
                end

                local maxForce = forceParam.maxForce                           
                if not Utils:isSuport3DTouch(maxForce)then
                    self.isShowSubMenu = false
                -- elseif itemCfg.superType == EC_ResourceType.TRAILCARD then
                --     local isHave = HeroDataMgr:getIsHave(itemCfg.useProfit.id)
                --     if isHave then -- 出售试用卡
                --         GoodsDataMgr:checkRecover( )
                --     else
                --         Utils:showInfo(data.cid, data.id, true)
                --     end
                else
                    local force = forceParam.force 
                    if force >= maxForce * (SettingDataMgr:getTouchPower() / 100) then
                        self.isShowSubMenu = true
                    end
                end

                if self.isShowSubMenu then
                    if touch3DCallBack then touch3DCallBack(node, data) end
                else
                    if eventName == "ended" then
                        if clickCallBack then clickCallBack(node, data) end
                    end
                end
            end
        end

    node:addMEListener(TFWIDGET_TOUCHBEGAN, function(...)
        onTouched("began", ...)
    end)
    node:addMEListener(TFWIDGET_TOUCHMOVED, function(...)
        onTouched("moved", ...)
    end)
    node:addMEListener(TFWIDGET_TOUCHENDED, function(...)
        onTouched("ended", ...)
    end)
    node:addMEListener(TFWIDGET_TOUCHCANCELLED, function(...)
        onTouched("cancelled", ...)
    end)

    self.touch3DPanel:addMEListener(TFWIDGET_CLICK, audioClickfun(handler(function()
        self.touch3DPanel:hide()
    end, self)),1)
end

function BagView:send3DTouchItem(sender, data)
    local itemCfg = GoodsDataMgr:getItemCfg(data.cid)
    if itemCfg.superType == EC_ResourceType.SPIRIT then
        if EquipmentDataMgr:isUesing(data.id) then
            Utils:showTips(490012)
            return
        end
        if EquipmentDataMgr:getEquipIsLock(data.id) then
            Utils:showTips(490017)
            return
        end
    end

    local goodsNum = 1
    local btnConfig = self.btnConfig_[self.selectIndex_]
    local sellAllBtn = TFDirector:getChildByPath(self.touch3DPanel, "btn_sellAll")
    if sender == sellAllBtn and not(btnConfig.category == EC_BagCategory.EQUIPMENT) then
        goodsNum = data.num
    end    
    local sellGoods = {}
    table.insert(sellGoods, {data.id, goodsNum})

    local sellFunc = function()
        Utils:openView("bag.ItemSellConfirmView", sellGoods, function()               
            StoreDataMgr:sendSellGoods(sellGoods)
        end)
    end

    if btnConfig.category == EC_BagCategory.EQUIPMENT then
        local isStepUp = false
        for k, v in pairs(sellGoods) do
            local equipStep = EquipmentDataMgr:getEquipStep(v[1])
            if equipStep and equipStep > 0 then
                isStepUp = true
                break
            end
        end

        --选中出售的质点有已经突破的
        if isStepUp then
            local params = {
                ["msg"] = 111000085,
                ["title"] = 1454021,
                ["confirm_title"] = 800010,
                ["comfirmCallback"] = sellFunc,
                ["cancel_title"] = 800029,
                ["cancelCallback"] = nil,
                ["showtype"] = EC_GameAlertType.comfirmAndCancel,
            }
            showGameAlert(params)
            return
        end
    end

    sellFunc()
end

function BagView:updateSelectGoodsItem(item, isSelect)
    local goodsItem = self.goodsItem_[item]
    goodsItem.Image_select:setVisible(isSelect)
end

function BagView:selectGoodsItem(item, data)
    local btnConfig = self.btnConfig_[self.selectIndex_]
    local goodsItem = self.goodsItem_[item]
    local itemCfg = GoodsDataMgr:getItemCfg(data.cid)
    if itemCfg.superType == EC_ResourceType.SPIRIT then
        if EquipmentDataMgr:isUesing(data.id) then
            Utils:showTips(490012)
            return
        end
        if EquipmentDataMgr:getEquipIsLock(data.id) then
            Utils:showTips(490017)
            return
        end

        if EquipmentDataMgr:getEquipStarLevel(data.id) > 0 then
            Utils:showTips(490406)
            return
        end
    end

    if itemCfg.superType == EC_ResourceType.BAOSHI then
        if EquipmentDataMgr:checkGemInUse(data.id) then
            Utils:showTips(1100028)
            return
        end
    end

    if btnConfig.sellType == EC_BagSellType.MULTISELECT then
        local index = table.indexOf(self.sellSelectItem_, item)
        local isSelect = not (index ~= -1)
        if isSelect then
            table.insert(self.sellSelectItem_, item)
            self.sellSelectData_[#self.sellSelectItem_] = {
                num = 1,
                data = data,
            }
        else
            table.remove(self.sellSelectItem_, index)
            table.remove(self.sellSelectData_, index)
        end
        self:updateSelectGoodsItem(item, isSelect)
    else
        local index = table.indexOf(self.sellSelectItem_, item)
        local isSelect = not (index ~= -1)
        local originItem = self.sellSelectItem_[1]
        if originItem then
            self:updateSelectGoodsItem(originItem, false)
        end
        if isSelect then
            self.sellSelectItem_[1] = item
            self.sellSelectData_[1] = {
                num = 1,
                data = data,
            }
        else
            self.sellSelectItem_ = {}
            self.sellSelectData_ = {}
        end
        self:updateSelectGoodsItem(item, isSelect)
    end
    self:updateSellInfo()
end

function BagView:splitGoods(goodsId)
    local goodsInfo = GoodsDataMgr:getSingleItem(goodsId)
    local goodsCfg = GoodsDataMgr:getItemCfg(goodsInfo.cid)
    local goods = {}
    if goodsCfg.pileUp then
        if goodsCfg.pileUp and goodsCfg.gridMax ~= 0 then
            local count = math.floor(goodsInfo.num / goodsCfg.gridMax)
            for i = 1, count do
                local cItem = clone(goodsInfo)
                cItem.num = goodsCfg.gridMax
                local remain = table.insert(goods, cItem)
            end
        end
        local remainNum = math.fmod(goodsInfo.num, goodsCfg.gridMax)
        if remainNum > 0 then
            local cItem = clone(goodsInfo)
            cItem.num = remainNum
            table.insert(goods, cItem)
        end
    else
        table.insert(goods, clone(goodsInfo))
    end

    return goods
end

function BagView:updateGoodsData(index)
    local config = self.btnConfig_[index]
    self.goodsData_[index] = {}
    for _, v in ipairs(config.bag) do
        local bag = GoodsDataMgr:getBag(v)
        for _, item in pairs(bag) do
            local splitGoods = self:splitGoods(item.id)
            local goodsCfg = GoodsDataMgr:getItemCfg(item.cid)
            -- if goodsCfg.subType == 100 and goodsCfg.superType == EC_ResourceType.SPIRIT then
            --     local itemindex = self:getEquipGoodsIndex(index,item.cid)
            --     local splitGoodClone = clone(splitGoods)[1]
            --     if not itemindex then
            --         splitGoodClone.merge = {}
            --         splitGoodClone.num = 1
            --         table.insert(splitGoodClone.merge,clone(splitGoods)[1])
            --         table.insert(self.goodsData_[index], splitGoodClone)
            --     else
            --         local mergeitem = self.goodsData_[index][itemindex]
            --         if not mergeitem.merge then
            --             mergeitem.merge = {}
            --         end
            --         mergeitem.num = mergeitem.num + 1
            --         table.insert(mergeitem.merge,clone(splitGoods)[1])
            --     end
            -- else
            --end
            if goodsCfg.superType == EC_ResourceType.FETTERS then
                if goodsCfg.display then
                    table.insertTo(self.goodsData_[index], splitGoods)
                end
            elseif goodsCfg.superType == EC_ResourceType.BAOSHI then
                if goodsCfg.showType == 0 then
                    table.insertTo(self.goodsData_[index], splitGoods)
                end
            else
                table.insertTo(self.goodsData_[index], splitGoods)
            end
        end
    end
    self:goodsDataSort(index)
end

function BagView:getEquipGoodsIndex(index,itemCid)
    local equipGoodsIndex
    for k,v in ipairs(self.goodsData_[index]) do
        if itemCid == v.cid then
            equipGoodsIndex = k
            break
        end
    end
    return equipGoodsIndex
end

function BagView:goodsDataSort(index)
    local data = self.goodsData_[index]
    local btnConfig = self.btnConfig_[index]
    if btnConfig.category == EC_BagCategory.ANGEL then
    elseif btnConfig.category == EC_BagCategory.EQUIPMENT then
        local function __equipSort(equipList)
            if self.selectRuleIndex_ == self.ruleType.SubType then
                table.sort(equipList, function(a, b)
                               local cfgA = TabDataMgr:getData("Equipment", a.cid)
                               local cfgB = TabDataMgr:getData("Equipment", b.cid)
                               if cfgA.subType == cfgB.subType then
                                   if cfgA.quality == cfgB.quality then
                                       if a.level == b.level then
                                           return a.cid < b.cid
                                       end
                                       return a.level > b.level
                                   end
                                   return cfgA.quality > cfgB.quality
                               end
                               return cfgA.subType < cfgB.subType
                end)
            elseif self.selectRuleIndex_ == self.ruleType.Quality then
                table.sort(equipList, function(a, b)
                               local cfgA = TabDataMgr:getData("Equipment", a.cid)
                               local cfgB = TabDataMgr:getData("Equipment", b.cid)
                               if cfgA.quality == cfgB.quality then
                                   if a.level == b.level then
                                       if cfgA.subType == cfgB.subType then
                                           return a.cid < b.cid
                                       end
                                       return cfgA.subType < cfgB.subType
                                   end
                                   return a.level > b.level
                               end
                               return cfgA.quality > cfgB.quality
                end)
            elseif self.selectRuleIndex_ == self.ruleType.Level then
                table.sort(equipList, function(a, b)
                               local cfgA = TabDataMgr:getData("Equipment", a.cid)
                               local cfgB = TabDataMgr:getData("Equipment", b.cid)
                               if a.level == b.level then
                                   if cfgA.quality == cfgB.quality then
                                       if cfgA.subType == cfgB.subType then
                                           return a.cid < b.cid
                                       end
                                       return cfgA.subType < cfgB.subType
                                   end
                                   return cfgA.quality > cfgB.quality
                               end
                               return a.level > b.level
                end)
            elseif self.selectRuleIndex_ == self.ruleType.Suit then
                table.sort(equipList, function(a, b)
                    local cfgA = TabDataMgr:getData("Equipment", a.cid)
                    local cfgB = TabDataMgr:getData("Equipment", b.cid)
                    if cfgA.suit[1] and cfgB.suit[1] then
                        if cfgA.suit[1] == cfgB.suit[1] then
                            if a.cid == b.cid then
                                return a.level > b.level
                            end
                            return a.cid < b.cid
                        end
                        return cfgA.suit[1] > cfgB.suit[1]
                    end
                    if cfgA.suit[1] then 
                        return true
                    end
                    if cfgB.suit[1] then
                        return false
                    end
                    if a.cid == b.cid then
                        return a.level > b.level
                    end
                    return a.cid < b.cid
                end)
            end
        end
        self.selectRuleIndex_ = self.selectRuleIndex_ or self.defaultSelectRuleIndex_
        local carry = {}
        local notCarry = {}

        for i, v in ipairs(data) do
            if EquipmentDataMgr:getEquipShowType(v.id) == 0 then
                if EquipmentDataMgr:isUesing(v.id) then
                    table.insert(carry, v)
                else
                    table.insert(notCarry, v)
                end
            end
        end
        __equipSort(carry)
        __equipSort(notCarry)
        data = {}
        if self.selectOrderIndex_ == 1 then
            for i = 1, #carry, 1 do
                table.insert(data, carry[i])
            end
            for i = 1, #notCarry, 1 do
                table.insert(data, notCarry[i])
            end
        else
            for i = #carry, 1, -1 do
                table.insert(data, carry[i])
            end
            for i = #notCarry, 1, -1 do
                table.insert(data, notCarry[i])
            end
        end
    elseif btnConfig.category == EC_BagCategory.MATERIAL then
        table.sort(data, function(a, b)
                       local itemCfgA = GoodsDataMgr:getItemCfg(a.cid)
                       local itemCfgB = GoodsDataMgr:getItemCfg(b.cid)
                       local astar = itemCfgA.star or 1
                       local bstar = itemCfgB.star or 1
                       if astar == bstar then
                           if itemCfgA.quality == itemCfgB.quality then
                               if itemCfgA.id == itemCfgB.id then
                                   return a.num > b.num
                               end
                               return itemCfgA.id > itemCfgB.id
                           end
                           return itemCfgA.quality > itemCfgB.quality
                       end
                       return astar > bstar

        end)
    elseif btnConfig.category == EC_BagCategory.ITEM then
        table.sort(data, function(a, b)
                       local itemCfgA = GoodsDataMgr:getItemCfg(a.cid)
                       local itemCfgB = GoodsDataMgr:getItemCfg(b.cid)
                       if itemCfgA.star == itemCfgB.star then
                           if itemCfgA.id == itemCfgB.id then
                               return a.num > b.num
                           end
                           return itemCfgA.id > itemCfgB.id
                       end
                       return itemCfgA.star > itemCfgB.star
        end)
    elseif btnConfig.category == EC_BagCategory.NEWEQUIP then
         table.sort(data, function(a, b)
                       local cfgA = GoodsDataMgr:getItemCfg(a.cid)
                       local cfgB = GoodsDataMgr:getItemCfg(b.cid)
                       local ause = (EquipmentDataMgr:checkNewEquipInUse(cfgA.id) == true and 1 or 0)
                       local buse = (EquipmentDataMgr:checkNewEquipInUse(cfgB.id) == true and 1 or 0)
                       if a.hid ~= 0 and b.hid == 0 then
                            return true
                       elseif b.hid ~= 0 and a.hid == 0 then
                            return false
                       end
                       if ause == buse then
                           if a.level == b.level then
                               if cfgA.quality == cfgB.quality then
                                    return a.cid < b.cid
                               end
                               return cfgA.quality > cfgB.quality
                           else
                                return a.level > b.level
                           end
                       else
                            return ause > buse
                       end
                end)
    elseif btnConfig.category == EC_BagCategory.TRAILCARD then
        table.sort(data, function(a, b)
                       local cfgA = GoodsDataMgr:getItemCfg(a.cid)
                       local cfgB = GoodsDataMgr:getItemCfg(b.cid)
                        return cfgA.order > cfgB.order
                end)
    elseif btnConfig.category == EC_BagCategory.BAOSHI then
         table.sort(data, function(a, b)
                       local cfgA = GoodsDataMgr:getItemCfg(a.cid)
                       local cfgB = GoodsDataMgr:getItemCfg(b.cid)
                       local ause = (EquipmentDataMgr:checkGemInUse(a.id) == true and 1 or 0)
                       local buse = (EquipmentDataMgr:checkGemInUse(b.id) == true and 1 or 0)
                       if cfgA.type == cfgB.type then
                            if ause == buse then
                               if cfgA.rarity == cfgB.rarity then
                                   if cfgA.heroId == cfgB.heroId then
                                        return cfgA.id < cfgB.id
                                   end
                                   return cfgA.heroId < cfgB.heroId
                               else
                                    return cfgA.rarity > cfgB.rarity
                               end
                           else
                                return ause > buse
                           end
                       else
                            return cfgA.type < cfgB.type
                       end
                end)
    end
    self.goodsData_[index] = data
end

function BagView:holdDownAction(isAddOp)
    local speedTiming = 0
    local timing = 0
    local needTime = 0
    local entryFalg = false

    local function action(dt)
        timing = timing + dt
        speedTiming = speedTiming + dt
        if speedTiming >= 3.0 then
            entryFalg = true
            needTime = 0.01
        elseif speedTiming > 0.5 then
            entryFalg = true
            needTime = 0.05
        end
        if entryFalg and timing >= needTime then
            self:singleSellOp(isAddOp)
            timing = 0
        end
    end

    self.holdDownTimer_ = TFDirector:addTimer(0, -1, nil, action)
end

function BagView:singleSellOp(isAddOp)
    for i, v in ipairs(self.sellSelectData_) do
        if isAddOp then
            v.num = math.min(v.num + 1, v.data.num)
        else
            v.num = math.max(v.num - 1, 1)
        end
        break
    end
    self:updateSellInfo()
end

function BagView:registerEvents()
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onItemUpdateEvent, self))
    EventMgr:addEventListener(self, EV_BAG_EQUIPMENT_UPDATE, handler(self.onItemUpdateEvent, self))
    EventMgr:addEventListener(self, EV_STORE_SELL_SUCCESS, handler(self.onItemSellEvent, self))
    EventMgr:addEventListener(self, EV_BAG_RECOVER_ITEM, handler(self.onRecoverItem, self))
    EventMgr:addEventListener(self, EV_BAG_GEMS_UPDATE, handler(self.onItemUpdateEvent, self))

    self.Button_sell:onClick(function()
            self:setSellVisible(true)
            self:updateSellInfo()
    end)

    self.Button_realSell:onClick(function()
        -- if not self:isCurTabHaveGoods() then
        --     Utils:showTips(301020)
        --     return
        -- end
        if not self:isCanSellAction() then
            Utils:showTips(301021)
            return
        end

        local sellGoods = {}
        --local sellProfits = {}
        for _, v in pairs(self.sellSelectData_) do
            local itemCfg = GoodsDataMgr:getItemCfg(v.data.cid)
            if itemCfg.subType == 100 and itemCfg.superType == EC_ResourceType.SPIRIT then
                if v.data.num then
                    table.insert(sellGoods, {v.data.id, v.data.num})
                end
            else
                table.insert(sellGoods, {v.data.id, v.num})
            end
            --local itemCfg = GoodsDataMgr:getItemCfg(v.data.cid)
            --for i, pv in ipairs(itemCfg.sellProfit) do
            --    local getItemCid = pv[1]
            --    local getItemCount = v.num * pv[2]
            --    sellProfits[getItemCid] = sellProfits[getItemCid] or 0
            --    sellProfits[getItemCid] = sellProfits[getItemCid] + getItemCount
            --end
        end
        Utils:openView("bag.ItemSellConfirmView", sellGoods, function()
            self:setSellVisible(false)
            StoreDataMgr:sendSellGoods(sellGoods)
        end)
    end)

    self.Button_sellAdd:onTouch(function(event)
            if not self:isCanSellAction() then return end
            if event.name == "began" then
                TFAudio.playSound(Utils:getKVP(1001,"ui_clickSound"))
                self:singleSellOp(true)
                self:holdDownAction(true)
            elseif event.name == "ended" then
                if self.holdDownTimer_ then
                    TFDirector:removeTimer(self.holdDownTimer_)
                    self.holdDownTimer_ = nil
                end
            end
    end)

    self.Button_sellSub:onTouch(function(event)
            if not self:isCanSellAction() then return end
            if event.name == "began" then
                TFAudio.playSound(Utils:getKVP(1001,"ui_clickSound"))
                self:singleSellOp(false)
                self:holdDownAction(false)
            elseif event.name == "ended" then
                if self.holdDownTimer_ then
                    TFDirector:removeTimer(self.holdDownTimer_)
                    self.holdDownTimer_ = nil
                end
            end
    end)

    self.Button_sellMax:onClick(function()
            if not self:isCanSellAction() then return end
            for i, v in ipairs(self.sellSelectData_) do
                v.num = v.data.num
                break
            end
            self:updateSellInfo()
    end)

    self.Button_cancel:onClick(function()
            self:setSellVisible(false)
    end)

    for i, v in ipairs(self.tabBtn_) do
        v.Image_touch:onClick(function()
                self:selectTabBtn(i)
				self.mainSelectIndex = i
        end)
    end

    self.Button_sortRule:onClick(function()
            self:setSortRuleVisible()
    end)

    self.Button_sort_order:onClick(function()
            self:setSortOrderVisible()
    end)

    for i, v in ipairs(self.button_order) do
        v:onClick(function()
                self:setSellVisible(false)
                self.selectOrderIndex_ = i
                self:selectSortOrder()
        end)
    end

    for i, v in ipairs(self.Button_rule) do
        v:onClick(function()
                self:setSellVisible(false)
                self:selectSortRule(i)
        end)
    end

    self.Panel_touch:setSize(GameConfig.WS)
    self.Panel_touch:setSwallowTouch(false)
    self.Panel_touch:onTouch(function()
            self.Panel_order:hide()
            self.Panel_sortRule:hide()
    end)

    self.Button_merge:onClick(function()
        Utils:openView("fairyNew.BaoshiComposeView")
    end)

    self.Button_specialCompose:onClick(function()
        Utils:openView("fairyNew.BaoshiSpecialComposeView")
    end)

    self.Button_decompose:onClick(function()
        Utils:openView("fairyNew.BaoshiDecomposeView")
    end)
end

function BagView:setSortRuleVisible(visible)
    if visible or self.Panel_sortRule:isVisible() then
        self.Panel_sortRule:setVisible(false)
    else
        self.Panel_sortRule:setVisible(true)
    end
    local ruleText = self.ruleText_[self.selectRuleIndex_]
    self.Label_sortRule:setTextById(ruleText)
end

function BagView:setSortOrderVisible(visible)
    if visible or self.Panel_order:isVisible() then
        self.Panel_order:setVisible(false)
    else
        self.Panel_order:setVisible(true)
    end
end

function BagView:selectSortOrder()
    self.Label_order_name:setTextById(self.orderText_[self.selectOrderIndex_])
    self.Image_order_icon:setFlipY(self.selectOrderIndex_ == 1)
    self:updateBag(self.selectIndex_)
    self:setSortOrderVisible(true)
end

function BagView:selectSortRule(index)
    self.selectRuleIndex_ = index or self.defaultSelectRuleIndex_
    self:updateBag(self.selectIndex_)
    self:setSortRuleVisible(true)
end

function BagView:removeEvents()
    self:removeCountDownTimer()
end

function BagView:addCountDownTimer()
    if self.countDownTimer_ then return end
    self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.onCountDownPer, self))
end

function BagView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
        self.countDownTimer_ = nil
    end
end

function BagView:onCountDownPer()
    local goodsData = self.goodsData_[self.selectIndex_]
    if goodsData == nil then
        return
    end
    local gridView = self.GridView_item[self.selectIndex_]
    for i, v in ipairs(goodsData) do
        if v.outTime and v.outTime > 0 then
            local item = gridView:getItem(i)
            if item then
                self:updateOutTime(item, v)
            end
        end
    end
end

function BagView:setSellVisible(isSellModel)
    self.sellSelectItem_ = {}
    self.sellSelectData_ = {}
    self.isSellModel_ = isSellModel

    local gridView = self.GridView_item[self.selectIndex_]
    for i, v in ipairs(gridView:getItems()) do
        self:updateSelectGoodsItem(v, false)
    end

    local size = self.Panel_sell:Size()
    if isSellModel then
        if not self.Panel_sell:isVisible() then
            self.Panel_sell:PosY(-size.height)
            local seq = Sequence:create({
                    Show:create(),
                    MoveBy:create(0.1, ccp(0, size.height)),
            })
            self.Panel_sell:stopAllActions()
            self.Panel_sell:runAction(seq)
        end
    else
        if self.Panel_sell:isVisible() then
            self.Panel_sell:PosY(0)
            local seq = Sequence:create({
                    MoveBy:create(0.1, ccp(0, -size.height)),
                    Hide:create(),
            })
            self.Panel_sell:stopAllActions()
            self.Panel_sell:runAction(seq)
        end
    end

    if self.btnConfig_[self.selectIndex_].category == EC_BagCategory.EQUIPMENT then
        self.Panel_sellEquip:setVisible(true)
        self.lastEquipSellBtnStarIdx = -1
        for i, v in ipairs(self.equipSellBtns) do
            v.imageSelect:hide()
        end
    else
        self.Panel_sellEquip:setVisible(false)
    end
    if self.btnConfig_[self.selectIndex_].category == EC_BagCategory.BAOSHI then
        self.Panel_baoshi_rarity:setVisible(true)
        self.selectBaoshiRarity = -1
        for i, v in ipairs(self.baoshiRarityItem) do
            v.Image_bg:setTexture("ui/fairy/new_ui/baoshi/072.png")
        end
    else
        self.Panel_baoshi_rarity:setVisible(false)
    end

end

function BagView:updateSellInfo()
    local count = 0
    for _, v in pairs(self.sellSelectData_) do
        count = count + v.num
    end
    local btnConfig = self.btnConfig_[self.selectIndex_]
    if btnConfig.sellType ~= EC_BagSellType.MULTISELECT then
        self.Label_sellCount:setText(count)
    end
    --if count > 0 then
    --    local getItemCid
    --    local getItemCount = 0
    --    for _, v in pairs(self.sellSelectData_) do
    --        local itemCfg = GoodsDataMgr:getItemCfg(v.data.cid)
    --        local sellProfit = itemCfg.sellProfit[1]
    --        getItemCid = sellProfit[1]
    --        getItemCount = getItemCount + v.num * sellProfit[2]
    --    end
    --    local itemCfg = GoodsDataMgr:getItemCfg(getItemCid)
    --    self.Label_sellGetCount:setText(getItemCount)
    --    self.Image_sellGetIcon:setTexture(itemCfg.icon)
    --end
end

function BagView:isCurTabHaveGoods()
    return self.goodsData_[self.selectIndex_] and #self.goodsData_[self.selectIndex_] > 0 or false
end

function BagView:isCanSellAction()
    local rets = #self.sellSelectData_ > 0
    return rets
end

function BagView:buttonSellStatusUpdate()
    local tabHaveGoods = self:isCurTabHaveGoods() and self.btnConfig_[self.selectIndex_].sellType
    self.Button_sell:setGrayEnabled(not tabHaveGoods)
    self.Button_sell:setTouchEnabled(tabHaveGoods)
    self.Button_merge:setVisible(self.btnConfig_[self.selectIndex_].category == EC_BagCategory.BAOSHI)
    self.Button_specialCompose:setVisible(self.btnConfig_[self.selectIndex_].category == EC_BagCategory.BAOSHI)
    self.Button_decompose:setVisible(self.btnConfig_[self.selectIndex_].category == EC_BagCategory.BAOSHI)
end

function BagView:updateOutTime(item, data)
    local remainTime = math.max(0, data.outTime - ServerDataMgr:getServerTime())
    local isInvalid= (remainTime == 0)

    local goodsItem = self.goodsItem_[item]
    -- goodsItem.Label_time:setVisible(not isInvalid)
    -- goodsItem.Panel_aging:setVisible(isInvalid)
    goodsItem.Image_limit:hide()

    if not failure then
        local _, hour, min = Utils:getFuzzyDHMS(remainTime, true)
        goodsItem.Label_time:setTextById(301011, hour, min)
    end
end

function BagView:getSubBtnIdx(configList, bagType)
    for k, v in ipairs(configList) do
        if table.indexOf(v.bag, bagType) ~= -1 then
            return k
        end
    end
    return nil
end

function BagView:onItemUpdateEvent(oldGoods, goods)
    if not self.btnConfig_ then
        return
    end
    local cid
    for _, v in pairs({oldGoods, goods}) do
        if v then
            cid = v.cid
            break
        end
    end
    if not cid then
        return
    end
    local tabIndex
    for i, v in ipairs(self.btnConfig_) do
        local itemCfg = GoodsDataMgr:getItemCfg(cid)
        if v.config_Ex and #v.config_Ex > 0 then
            local subIdx = self:getSubBtnIdx(v.config_Ex, itemCfg.bagType)
            if subIdx then
                tabIndex = #self.btnConfig_ + subIdx
            end
        else
            if table.indexOf(v.bag, itemCfg.bagType) ~= -1 then
                tabIndex = i
                break
            end
        end
    end

    if not tabIndex then return end
    if self.selectIndex_ ~= tabIndex then return end

    local goodsData = self.goodsData_[self.selectIndex_]
    local gridView = self.GridView_item[self.selectIndex_]

    if oldGoods and goods then
        local goodsId = goods.id
        local goodsCid = goods.cid
        local goodsCfg = GoodsDataMgr:getItemCfg(goodsCid)
        -- 更新
        local index
        local sameGoods = {}
        for i, v in ipairs(goodsData) do
            if v.id == goods.id then
                if goodsCfg.pileUp then
                    table.insert(sameGoods, i)
                else
                    index = i
                end
            end
        end

        local needUpdateGoods = {}
        if #sameGoods > 0 then
            local splitGoods = self:splitGoods(goodsId)
            if #splitGoods < #sameGoods then
                local removeIndex = {}
                for i = #sameGoods, 1, -1 do
                    if i > #splitGoods then
                        table.insert(removeIndex, sameGoods[i])
                        table.remove(goodsData, sameGoods[i])
                    else
                        goodsData[sameGoods[i]] = splitGoods[i]
                        table.insert(needUpdateGoods, sameGoods[i])
                    end
                end
                gridView:removeItems(removeIndex)
            else
                for i, v in ipairs(splitGoods) do
                    if i > #sameGoods then
                        table.insert(goodsData, v)
                        self:addGoodsItem()
                        table.insert(needUpdateGoods, #goodsData)
                    else
                        goodsData[sameGoods[i]] = v
                        table.insert(needUpdateGoods, sameGoods[i])
                    end
                end
            end
        else
            goodsData[index] = GoodsDataMgr:getSingleItem(goodsId)
            table.insert(needUpdateGoods, index)
        end
        for i, v in ipairs(needUpdateGoods) do
            local item = gridView:getItem(v)
            self:updateGoodsItem(item, goodsData[v])
        end
    else
        if not oldGoods then
            -- 新增
            local splitGoods = self:splitGoods(goods.id)
            local goodsCfg = GoodsDataMgr:getItemCfg(goods.cid)
            if goodsCfg.subType == 100 and goodsCfg.superType == EC_ResourceType.SPIRIT then
                local itemindex = self:getEquipGoodsIndex(self.selectIndex_,goods.cid)
                local splitGoodClone = clone(splitGoods)[1]
                if not itemindex then
                    splitGoodClone.merge = {}
                    splitGoodClone.num = 1
                    table.insert(splitGoodClone.merge,clone(splitGoods)[1])
                    table.insert(goodsData, splitGoodClone)
                    local item = self:addGoodsItem()
                    self:updateGoodsItem(item, splitGoodClone)
                else
                    local mergeitem = self.goodsData_[self.selectIndex_][itemindex]
                    if not mergeitem.merge then
                        mergeitem.merge = {}
                    end
                    mergeitem.num = mergeitem.num + 1
                    table.insert(mergeitem.merge,clone(splitGoods)[1])

                    local item = gridView:getItem(itemindex)
                    self:updateGoodsItem(item, goodsData[itemindex])

                end
            else
                table.insertTo(goodsData, splitGoods)
                for i, v in ipairs(splitGoods) do
                    local item = self:addGoodsItem()
                    self:updateGoodsItem(item, v)
                end
            end
        else
            -- 删除
            local removeIndex = {}
            for i = #goodsData, 1, -1 do
                if goodsData[i].id == oldGoods.id then
                    table.insert(removeIndex, i)
                    table.remove(goodsData, i)
                end
            end
            gridView:removeItems(removeIndex)
        end
    end
    self:updateCapacity()
    self:buttonSellStatusUpdate()
end

function BagView:onItemSellEvent(reward)
    Utils:showReward(reward)
end

function BagView:onRecoverItem( data )
    if data and data.itemList and #data.itemList > 0 then
        Utils:openView("bag.RecoverItemView",data)
    end
end



return BagView
