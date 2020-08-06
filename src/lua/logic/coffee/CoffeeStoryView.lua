
local CoffeeStoryView = class("CoffeeStoryView", BaseLayer)

function CoffeeStoryView:initData()
    self.defaultSelectIndex_ = 1
    self.coffeeItems_ = {}
    self.maidItems_ = {}
end

function CoffeeStoryView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.coffee.coffeeStoryView")
end

function CoffeeStoryView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Image_coffeeItem = TFDirector:getChildByPath(self.Panel_prefab, "Image_coffeeItem")
    self.Image_maidItem = TFDirector:getChildByPath(self.Panel_prefab, "Image_maidItem")

    self.Panel_tab = {}
    self.ListView_tab = {}
    for i = 1, 2 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(self.Panel_root, "Panel_tab_" .. i)
        foo.Button_tab_normal = TFDirector:getChildByPath(foo.root, "Button_tab_normal")
        foo.Image_icon_normal = TFDirector:getChildByPath(foo.Button_tab_normal, "Image_icon_normal")
        foo.Label_name_normal = TFDirector:getChildByPath(foo.Button_tab_normal, "Label_name_normal")
        foo.Image_tab_select = TFDirector:getChildByPath(foo.root, "Image_tab_select")
        foo.Image_icon_select = TFDirector:getChildByPath(foo.Image_tab_select, "Image_icon_select")
        foo.Label_name_select = TFDirector:getChildByPath(foo.Image_icon_select, "Label_name_select")
        self.Panel_tab[i] = foo

        local ScrollView_tab = TFDirector:getChildByPath(self.Panel_root, "ScrollView_tab_" .. i)
        self.ListView_tab[i] = UIListView:create(ScrollView_tab)
        self.ListView_tab[i]:setItemsMargin(20)
    end

    self:refreshView()
end

function CoffeeStoryView:refreshView()
    self:selectTab(self.defaultSelectIndex_)
end

function CoffeeStoryView:addMaidItem()
    local foo = {}
    foo.root = self.Image_maidItem:clone()
    foo.Image_title = TFDirector:getChildByPath(foo.root, "Image_title")
    foo.Label_title = TFDirector:getChildByPath(foo.Image_title, "Label_title")
    foo.Image_head = TFDirector:getChildByPath(foo.root, "Image_head")
    foo.Image_icon = TFDirector:getChildByPath(foo.Image_head, "Image_icon")
    local Image_cond = TFDirector:getChildByPath(foo.root, "Image_cond")
    foo.Label_cond = TFDirector:getChildByPath(Image_cond, "Label_cond")
    local ScrollView_reward = TFDirector:getChildByPath(Image_cond, "ScrollView_reward")
    foo.ListView_reward = UIListView:create(ScrollView_reward)
    foo.Label_number = TFDirector:getChildByPath(Image_cond, "Label_number")
    foo.Button_dating = TFDirector:getChildByPath(foo.root, "Button_dating")
    foo.Label_dating = TFDirector:getChildByPath(foo.Button_dating, "Label_dating")
    foo.Label_not_reach = TFDirector:getChildByPath(foo.root, "Label_not_reach")
    foo.Button_review = TFDirector:getChildByPath(foo.root, "Button_review")
    foo.Label_review = TFDirector:getChildByPath(foo.Button_review, "Label_review")
    foo.Image_elf = {}
    for i = 1, 3 do
        local bar = {}
        bar.root = TFDirector:getChildByPath(foo.root, "Image_elf_" .. i)
        bar.originPositon = bar.root:Pos()
        bar.Image_head = TFDirector:getChildByPath(bar.root, "Image_head")
        foo.Image_elf[i] = bar
    end
    self.maidItems_[foo.root] = foo
    self.ListView_tab[2]:pushBackCustomItem(foo.root)
end

function CoffeeStoryView:addCoffeeItem()
    local foo = {}
    foo.root = self.Image_coffeeItem:clone()
    foo.Image_title = TFDirector:getChildByPath(foo.root, "Image_title")
    foo.Label_title = TFDirector:getChildByPath(foo.Image_title, "Label_title")
    foo.Image_icon = TFDirector:getChildByPath(foo.root, "Image_head.Image_icon")
    local Image_cond = TFDirector:getChildByPath(foo.root, "Image_cond")
    foo.Label_cond = TFDirector:getChildByPath(Image_cond, "Label_cond")
    foo.Label_number = TFDirector:getChildByPath(Image_cond, "Label_number")
    foo.Button_dating = TFDirector:getChildByPath(foo.root, "Button_dating")
    foo.Label_dating = TFDirector:getChildByPath(foo.Button_dating, "Label_dating")
    foo.Label_not_reach = TFDirector:getChildByPath(foo.root, "Label_not_reach")
    foo.Button_review = TFDirector:getChildByPath(foo.root, "Button_review")
    foo.Label_review = TFDirector:getChildByPath(foo.Button_review, "Label_review")
    self.coffeeItems_[foo.root] = foo
    self.ListView_tab[1]:pushBackCustomItem(foo.root)
end

function CoffeeStoryView:updateCoffeeTab()
    local data, activitId = CoffeeDataMgr:getItems(3)
    local activityInfo = ActivityDataMgr2:getActivityInfo(activitId)
    local items = self.ListView_tab[1]:getItems()
    local gap = #data - #items
    for i = 1, math.abs(gap) do
        if gap > 0 then
            self:addCoffeeItem()
        else
            local item = self.ListView_tab[1]:getItem(1)
            self.coffeeItems_[item] = nil
            self.ListView_tab[1]:removeItem(1)
        end
    end

    for i, v in ipairs(self.ListView_tab[1]:getItems()) do
        local itemId = data[i]
        local foo = self.coffeeItems_[v]
        local itemInfo = ActivityDataMgr2:getItemInfo(activityInfo.activityType, itemId)
        local progressInfo = ActivityDataMgr2:getProgressInfo(activityInfo.activityType, itemId)
        foo.Label_cond:setText(itemInfo.extendData.des2)
        foo.Button_dating:setVisible(progressInfo.status == EC_TaskStatus.GET)
        foo.Label_not_reach:setVisible(progressInfo.status == EC_TaskStatus.ING)
        foo.Button_review:setVisible(progressInfo.status == EC_TaskStatus.GETED)
        foo.Label_title:setText(itemInfo.details)
        foo.Label_number:setText(itemInfo.target)
        foo.Label_cond:setText(itemInfo.extendData.des2)
        foo.Button_dating:setVisible(progressInfo.status == EC_TaskStatus.GET)
        foo.Label_not_reach:setVisible(progressInfo.status == EC_TaskStatus.ING)
        foo.Button_review:setVisible(progressInfo.status == EC_TaskStatus.GETED)
        foo.Image_icon:setTexture(itemInfo.extendData.icon)

        foo.Button_dating:onClick(function()
                FunctionDataMgr:jStartDating(itemInfo.extendData.dating)
        end)

        foo.Button_review:onClick(function()
                FunctionDataMgr:jStartDating(itemInfo.extendData.dating)
        end)
    end
end

function CoffeeStoryView:updateMaidTab()
    local data, activitId = CoffeeDataMgr:getItems(2)
    local activityInfo = ActivityDataMgr2:getActivityInfo(activitId)
    local items = self.ListView_tab[2]:getItems()
    local gap = #data - #items
    for i = 1, math.abs(gap) do
        if gap > 0 then
            self:addMaidItem()
        else
            local item = self.ListView_tab[2]:getItem(1)
            self.maidItems_[item] = nil
            self.ListView_tab[2]:removeItem(1)
        end
    end

    for i, v in ipairs(self.ListView_tab[2]:getItems()) do
        local itemId = data[i]
        local foo = self.maidItems_[v]
        local itemInfo = ActivityDataMgr2:getItemInfo(activityInfo.activityType, itemId)
        local progressInfo = ActivityDataMgr2:getProgressInfo(activityInfo.activityType, itemId)
        foo.Label_cond:setText(itemInfo.extendData.des2)
        foo.Button_dating:setVisible(progressInfo.status == EC_TaskStatus.GET)
        foo.Label_not_reach:setVisible(progressInfo.status == EC_TaskStatus.ING)
        foo.Button_review:setVisible(progressInfo.status == EC_TaskStatus.GETED)
        foo.Label_title:setText(itemInfo.details)

        local maidList = itemInfo.extendData.maidList
        local beginIndex = #maidList == 3 and 1 or 2
        for _, bar in ipairs(foo.Image_elf) do
            bar.root:hide()
            bar.root:Alpha(1)
            bar.root:Pos(bar.originPositon)
        end
        local index = 1
        for i = beginIndex, #foo.Image_elf do
            local maidId = maidList[index]
            local maidCfg = CoffeeDataMgr:getMaidCfg(maidId)
            local isHave = CoffeeDataMgr:isHaveSameMaid(maidId)
            local bar = foo.Image_elf[i]
            bar.root:show()
            if beginIndex == 2 then
                bar.root:PosY(bar.root:PosY() + 50)
            end
            bar.Image_head:setTexture(maidCfg.icon1)
            bar.root:Alpha(isHave and 1 or 0.5)
            index = index + 1
            bar.root:onClick(function()
                    Utils:openView("coffee.CoffeeDetailsView", false, maidId)
            end)
        end

        local items = foo.ListView_reward:getItems()
        if #items ~= table.count(itemInfo.reward) then
            foo.ListView_reward:removeAllItems()
            for cid, num in pairs(itemInfo.reward) do
                local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
                Panel_goodsItem:Scale(0.6)
                foo.ListView_reward:pushBackCustomItem(Panel_goodsItem)
            end
            Utils:setAliginCenterByListView(foo.ListView_reward, true)
        end
        local index = 1
        for cid, num in pairs(itemInfo.reward) do
            local Panel_goodsItem = foo.ListView_reward:getItem(index)
            PrefabDataMgr:setInfo(Panel_goodsItem, cid, num)
            index = index + 1
        end

        foo.Button_dating:onClick(function()
                FunctionDataMgr:jStartDating(itemInfo.extendData.dating)
        end)

        foo.Button_review:onClick(function()
                FunctionDataMgr:jStartDating(itemInfo.extendData.dating)
        end)
    end
end

function CoffeeStoryView:selectTab(index)
    if self.selectIndex_ == index then return end
    self.selectIndex_ = index

    for i, v in ipairs(self.Panel_tab) do
        local isSelect = i == index
        v.Image_tab_select:setVisible(isSelect)
        v.Button_tab_normal:setVisible(not isSelect)
    end

    for i ,v in ipairs(self.ListView_tab) do
        v:s():setVisible(i == index)
    end

    if index == 1 then
        self:updateCoffeeTab()
    else
        self:updateMaidTab()
    end
end

function CoffeeStoryView:registerEvents()
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onUpdateProgressEvent, self))

    for i, v in ipairs(self.Panel_tab) do
        v.Button_tab_normal:onClick(function()
                self:selectTab(i)
        end)
    end
end

function CoffeeStoryView:onUpdateProgressEvent()
    self:updateCoffeeTab()
    self:updateMaidTab()
end

return CoffeeStoryView
