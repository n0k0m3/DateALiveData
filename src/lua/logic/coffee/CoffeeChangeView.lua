
local CoffeeChangeView = class("CoffeeChangeView", BaseLayer)

function CoffeeChangeView:initData()
    local spiritCost = Utils:getKVP(46016, "spiritCost")
    self.spiritCost_ = spiritCost / 1000 / 10000

    self.elfItems_ = {}
    self.selectMaidIndex_ = 1
    self.defaultSelectMaidIndex_ = 1
    self.defaultSelectRuleIndex_ = 5
end

function CoffeeChangeView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.coffee.coffeeChangeView")
end

function CoffeeChangeView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_elfItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_elfItem")

    local Image_elf = TFDirector:getChildByPath(self.Panel_root, "Image_elf")
    self.Image_fetters = TFDirector:getChildByPath(Image_elf, "Image_fetters")
    self.Label_fetters = {}
    self.Label_noFetters = {}
    for i = 1, 2 do
        self.Label_fetters[i] = TFDirector:getChildByPath(self.Image_fetters, "Label_fetters_" .. i)
        local Label_fetters = TFDirector:getChildByPath(self.Label_fetters[i], "Label_fetters")
        Label_fetters:setTextById(13410008)
        self.Label_noFetters[i] = TFDirector:getChildByPath(self.Image_fetters, "Label_noFetters_" .. i)
        self.Label_noFetters[i]:setTextById(13410009)
    end
    self.Button_elf = {}
    for i = 1, 3 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(Image_elf, "Button_elf_" .. i)
        foo.Image_head = TFDirector:getChildByPath(foo.root, "Image_frame.Image_head")
        foo.Image_head:setScale(0.75)
        foo.Label_name = TFDirector:getChildByPath(foo.root, "Label_name")
        foo.LoadingBar_percent = TFDirector:getChildByPath(foo.root, "Image_percent.LoadingBar_percent")
        foo.Label_percent = TFDirector:getChildByPath(foo.root, "Label_percent")
        foo.Label_rate = TFDirector:getChildByPath(foo.root, "Label_rate")
        foo.Image_elf_tip = TFDirector:getChildByPath(foo.root, "Image_elf_tip")
        foo.Image_star = {}
        for j = 1, 3 do
            foo.Image_star[j] = TFDirector:getChildByPath(foo.root, "Image_star_" .. j)
        end
        foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select")
        self.Button_elf[i] = foo
    end

    self.Panel_info = TFDirector:getChildByPath(self.Panel_root, "Panel_info")
    self.infoView_ = requireNew("lua.logic.coffee.CoffeeDetailsView"):new(true)
    local x = -GameConfig.WS.width * 0.5 + 160
    local y = -GameConfig.WS.height * 0.5 + 55
    self.infoView_:setPosition(ccp(x, y))
    self:addLayerToNode(self.infoView_, self.Panel_info)

    local Image_change = TFDirector:getChildByPath(self.Panel_root, "Image_change")
    self.Label_tips = TFDirector:getChildByPath(Image_change, "Image_tips.Label_tips")
    local ScrollView_elf = TFDirector:getChildByPath(Image_change, "ScrollView_elf")
    self.ListView_elf = UIListView:create(ScrollView_elf)
    self.Button_dispatch = TFDirector:getChildByPath(Image_change, "Button_dispatch")
    self.Label_dispatch = TFDirector:getChildByPath(self.Button_dispatch, "Label_dispatch")
    self.Button_filter = TFDirector:getChildByPath(Image_change, "Button_filter")
    self.Label_filter = TFDirector:getChildByPath(self.Button_filter, "Label_filter")
    self.Button_rule = {}
    self.Image_filter = TFDirector:getChildByPath(Image_change, "Image_filter"):hide()
    local ruleName = {13410019, 13410021, 13410021, 13410021, 13410022}
    self.Button_rule = {}
    for i = 1, 5 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(self.Image_filter, "Button_rule_" .. i)
        foo.Label_rule = TFDirector:getChildByPath(foo.root, "Label_rule")
        foo.Label_rule:setTextById(ruleName[i])
        self.Button_rule[i] = foo
    end

    self:refreshView()
end

function CoffeeChangeView:refreshView()
    self.Label_dispatch:setTextById(13410017)
    self.Label_filter:setTextById(13410018)
    self.Label_tips:setTextById(13410011)

    self:selectRule(self.defaultSelectRuleIndex_)
    self:updateWorkingMaid()
    self:selectMaid(self.selectMaidIndex_ or 1)
    self:selectWorkingMaid(self.selectWorkingIndex_ or 1)
end

function CoffeeChangeView:registerEvents()
    EventMgr:addEventListener(self, EV_COFFEE_MAID_CHANGE, handler(self.onMaidChangeEvent, self))
    EventMgr:addEventListener(self, EV_COFFEE_MAID_FEED, handler(self.onMaidFeedEvent, self))
    EventMgr:addEventListener(self, EV_COFFEE_MAIDINFO_UPDATE, handler(self.onMaidInfoUpdateEvent, self))


    self.Button_dispatch:onClick(function()
            local changeMaidId = self.maidData_[self.selectMaidIndex_]
            local originMaidId = self.workingMaid_[self.selectWorkingIndex_]
            CoffeeDataMgr:send_MAID_ACTIVITY_REQ_CHANGE_MAID_WORK(changeMaidId, originMaidId)
    end)

    self.Button_filter:onClick(function()
            local visible = self.Image_filter:isVisible()
            self.Image_filter:setVisible(not visible)
    end)

    self.Image_fetters:onClick(function()
            Utils:openView("coffee.CoffeeFettersView", self.fettersList_)
    end)

    for i, v in ipairs(self.Button_rule) do
        v.root:onClick(function()
                self:selectRule(i)
                self.Image_filter:hide()
        end)
    end
end

function CoffeeChangeView:removeEvents()
    CoffeeDataMgr:clearNewMaid()
end

function CoffeeChangeView:selectRule(index)
    self.selectRuleIndex_ = index

    self.workingMaid_ = CoffeeDataMgr:getWorkingMaid()
    local noWorkingMaid = CoffeeDataMgr:getNoWorkingMaid()
    local notHaveMaid = CoffeeDataMgr:getNotHaveMaid()
    -- self.noWorkingMaid_ = {}
    -- self.notHaveMaid_ = {}

    self.maidData_ = {}
    -- table.insertTo(self.maidData_, self.workingMaid_)

    if index == 1 then
        local fettersMaid = {}
        for i, v in ipairs(self.workingMaid_) do
            local maidCfg = CoffeeDataMgr:getMaidCfg(v)
            for _, buffCid in ipairs(maidCfg.fetterList) do
                local maidBuffCfg = CoffeeDataMgr:getMaidBuffCfg(buffCid)
                table.insertTo(fettersMaid, maidBuffCfg.role)
            end
        end
        fettersMaid = table.unique(fettersMaid)

        for i, v in ipairs(noWorkingMaid) do
            local maidCfg = CoffeeDataMgr:getMaidCfg(v)
            if table.indexOf(fettersMaid, maidCfg.id) ~= -1 then
                table.insert(self.maidData_, v)
            end
        end
        for i, v in ipairs(notHaveMaid) do
            local maidCfg = CoffeeDataMgr:getMaidCfg(v)
            if table.indexOf(fettersMaid, maidCfg.id) ~= -1 then
                table.insert(self.maidData_, v)
            end
        end
    elseif index == 2 then
        for i, v in ipairs(noWorkingMaid) do
            maidCfg = CoffeeDataMgr:getMaidCfg(v)
            if maidCfg.quality == 1 then
                table.insert(self.maidData_, v)
            end
        end
        for i, v in ipairs(notHaveMaid) do
            maidCfg = CoffeeDataMgr:getMaidCfg(v)
            if maidCfg.quality == 1 then
                table.insert(self.maidData_, v)
            end
        end
    elseif index == 3 then
        for i, v in ipairs(noWorkingMaid) do
            maidCfg = CoffeeDataMgr:getMaidCfg(v)
            if maidCfg.quality == 2 then
                table.insert(self.maidData_, v)
            end
        end
        for i, v in ipairs(notHaveMaid) do
            maidCfg = CoffeeDataMgr:getMaidCfg(v)
            if maidCfg.quality == 2 then
                table.insert(self.maidData_, v)
            end
        end
    elseif index == 4 then
        for i, v in ipairs(noWorkingMaid) do
            maidCfg = CoffeeDataMgr:getMaidCfg(v)
            if maidCfg.quality == 3 then
                table.insert(self.maidData_, v)
            end
        end
        for i, v in ipairs(notHaveMaid) do
            maidCfg = CoffeeDataMgr:getMaidCfg(v)
            if maidCfg.quality == 3 then
                table.insert(self.maidData_, v)
            end
        end
    elseif index == 5 then
        table.insertTo(self.maidData_, noWorkingMaid)
        table.insertTo(self.maidData_, notHaveMaid)
    end

    self:updateAllElfItems()
end

function CoffeeChangeView:selectWorkingMaid(index)
    if nil == index then return end
    self.selectWorkingIndex_ = index

    for i, v in ipairs(self.Button_elf) do
        v.Image_select:setVisible(i == index)
    end
    self.infoView_:updateInfo(self.workingMaid_[index])
end

function CoffeeChangeView:selectMaid(index)
    self.selectMaidIndex_ = index
    local maidId = self.maidData_[index]
    for i, v in ipairs(self.ListView_elf:getItems()) do
        local foo = self.elfItems_[v]
        foo.Image_select:setVisible(i == index)
    end

    local isNoWorking = CoffeeDataMgr:isNoWorkingMaid(maidId)
    self.Button_dispatch:setVisible(tobool(isNoWorking))

    self.infoView_:updateInfo(maidId)
end

function CoffeeChangeView:updateWorkingMaid()
    self.fettersList_ = CoffeeDataMgr:getMaidFetters(self.workingMaid_)
    local extraCoffeeInfo = CoffeeDataMgr:getExtraMaidInfo()
    local rate = extraCoffeeInfo.attributes[1] / 10000
    if rate == 0 then
        rate = 1
    end
    for i, v in ipairs(self.Button_elf) do
        local maidId = self.workingMaid_[i]
        local maidInfo = CoffeeDataMgr:getMaidInfo(maidId)
        local maidCfg = CoffeeDataMgr:getMaidCfg(maidId)
        v.Label_name:setTextById(maidCfg.name1)
        v.Image_head:setTexture(maidCfg.icon1)
        for j, Image_star in ipairs(v.Image_star) do
            Image_star:setVisible(j <= maidCfg.quality)
        end
        local strength = clamp(maidInfo.strength, 0, maidCfg.strength)
        local percnt = clamp(strength / maidCfg.strength * 100, 0, 100)
        v.LoadingBar_percent:setPercent(percnt)
        v.Label_percent:setTextById(800005, CoffeeDataMgr:converPower(strength), CoffeeDataMgr:converPower(maidCfg.strength))
        v.Image_elf_tip:setVisible(maidInfo.strength == 0)
        v.Label_rate:setTextById(13400257, self.spiritCost_ * rate * 60)

        local count = math.min(#self.Label_fetters, #self.Label_noFetters)
        for i = 1, count do
            local fettersCid = self.fettersList_[i]
            if fettersCid then
                local maidBuffCfg = CoffeeDataMgr:getMaidBuffCfg(fettersCid)
                self.Label_fetters[i]:setTextById(maidBuffCfg.name)
            end
            self.Label_fetters[i]:setVisible(tobool(fettersCid))
            self.Label_noFetters[i]:setVisible(not tobool(fettersCid))
        end

        v.root:onClick(function()
                self:selectWorkingMaid(i)
        end)
    end
    self:selectWorkingMaid(self.selectWorkingIndex_)
end

function CoffeeChangeView:updateAllElfItems()
    -- local count = #self.workingMaid_ + #self.noWorkingMaid_ + #self.notHaveMaid_
    for i, v1 in ipairs(self.maidData_) do
        for j, v2 in ipairs(self.workingMaid_) do
            if v1 == v2 then
                table.remove(self.maidData_, i)
            end
        end
    end

    local items = self.ListView_elf:getItems()
    local gap = #self.maidData_ - #items
    for i = 1, math.abs(gap) do
        if gap > 0 then
            self:addElfItem()
        else
            local item = self.ListView_elf:getItem(1)
            self.elfItems_[item] = nil
            self.ListView_elf:removeItem(1)
        end
    end

    local items = self.ListView_elf:getItems()
    for i, v in ipairs(items) do
        local foo = self.elfItems_[v]
        local maidId = self.maidData_[i]
        local maidCfg = CoffeeDataMgr:getMaidCfg(maidId)
        local isWorking = CoffeeDataMgr:isWorkingMaid(maidId)
        local isNoWorking = CoffeeDataMgr:isNoWorkingMaid(maidId)
        local isNotHave =  CoffeeDataMgr:isNotHaveMaid(maidId)
        foo.Panel_have:setVisible(isWorking or isNoWorking)
        foo.Image_frame:setVisible(isWorking or isNoWorking)
        foo.Label_notGet:setVisible(isNotHave)
        local haveNewMaid = CoffeeDataMgr:isNewMaid(maidId)
        foo.Image_new:setVisible(haveNewMaid)

        if isWorking then
            foo.root:Alpha(1)
        elseif isNoWorking then
            foo.root:Alpha(1)
        else
            foo.root:Alpha(0.5)
        end
        foo.Image_head:setTexture(maidCfg.icon1)
        for j, Image_star in ipairs(foo.Image_star) do
            Image_star:setVisible(j <= maidCfg.quality)
        end

        if isWorking or isNoWorking then
            local maidInfo = CoffeeDataMgr:getMaidInfo(maidId)
            local strength = clamp(maidInfo.strength, 0, maidCfg.strength)
            local percnt = clamp(strength / maidCfg.strength * 100, 0, 100)
            foo.LoadingBar_percent:setPercent(percnt)

            foo.Label_percent:setTextById(800005, CoffeeDataMgr:converPower(strength), CoffeeDataMgr:converPower(maidCfg.strength))
            foo.LoadingBar_percent_full:setPercent(percnt)
            foo.Label_percent_full:setTextById(800005, CoffeeDataMgr:converPower(strength), CoffeeDataMgr:converPower(maidCfg.strength))
            foo.LoadingBar_percent_full:setVisible(percnt == 100)
            foo.LoadingBar_percent:setVisible(percnt < 100)
        end

        foo.Button_elf:onClick(function()
                self:selectMaid(i)
        end)
    end

    -- local selectMaidIndex = self.defaultSelectMaidIndex_
    -- if self.selectMaidIndex_ then
    --     if self.selectMaidIndex_ <= #self.maidData_ then
    --         selectMaidIndex = self.selectMaidIndex_
    --     end
    -- end
    -- self:selectMaid(selectMaidIndex)
    -- local selectWorkingIndex = selectMaidIndex
    -- if selectWorkingIndex > #self.workingMaid_ then
    --     selectWorkingIndex = self.selectWorkingIndex_ or 1
    -- end
end

function CoffeeChangeView:getSelectMaidId(index)

end

function CoffeeChangeView:addElfItem()
    local foo = {}
    foo.root = self.Panel_elfItem:clone()
    foo.Button_elf = TFDirector:getChildByPath(foo.root, "Button_elf")
    foo.Image_frame = TFDirector:getChildByPath(foo.root, "Image_frame")
    foo.Image_head = TFDirector:getChildByPath(foo.Button_elf, "Image_head")
    foo.Image_head:setScale(0.75)
    foo.Panel_have = TFDirector:getChildByPath(foo.Button_elf, "Panel_have")
    foo.Image_new = TFDirector:getChildByPath(foo.Panel_have, "Image_new"):hide()
    foo.Image_percent = TFDirector:getChildByPath(foo.Panel_have, "Image_percent")
    foo.LoadingBar_percent_full = TFDirector:getChildByPath(foo.Image_percent, "LoadingBar_percent_full")
    foo.LoadingBar_percent = TFDirector:getChildByPath(foo.Image_percent, "LoadingBar_percent")
    foo.Label_percent_full = TFDirector:getChildByPath(foo.LoadingBar_percent_full, "Label_percent_full")
    foo.Label_percent = TFDirector:getChildByPath(foo.LoadingBar_percent, "Label_percent")
    foo.Image_star = {}
    for i = 1, 3 do
        foo.Image_star[i] = TFDirector:getChildByPath(foo.Button_elf, "Image_star_" .. i)
    end
    foo.Label_notGet = TFDirector:getChildByPath(foo.Button_elf, "Label_notGet")
    foo.Label_notGet:setTextById(13410039)
    foo.Image_select = TFDirector:getChildByPath(foo.Button_elf, "Image_select")
    self.elfItems_[foo.root] = foo
    self.ListView_elf:pushBackCustomItem(foo.root)
end

function CoffeeChangeView:onMaidChangeEvent()
    self:selectRule(self.selectRuleIndex_)
    self:updateWorkingMaid()
end

function CoffeeChangeView:onMaidFeedEvent()
    self:selectRule(self.selectRuleIndex_)
    self:updateWorkingMaid()
end

function CoffeeChangeView:onMaidInfoUpdateEvent()
    self:selectRule(self.selectRuleIndex_)
    -- self:updateWorkingMaid()
end

return CoffeeChangeView
