--[[
    @desc：SupplyMainNewView
    @date: 2020-10-11 11:48:32
]]

local SupplyMainNewView = class("SupplyMainNewView",BaseLayer)

local ENUM_SUPPLYS = {
    ZHANLIN = 1,    -- 战令
    SUPPLY = 2,     -- 补给站
    MONTH_CARD = 3, -- 月卡
    WEEK_CARD = 4,  -- 周卡
    CONTRACT = 5,   -- 精灵契约
    GIFT = 6        -- 礼包
}

function SupplyMainNewView:initData(defaultLeftIdx, pageSelectId)
    self.tabBtnCfg = { }

    if GlobalFuncDataMgr:isOpen(7) then
        table.insert(self.tabBtnCfg , {name = 14300377,icon = "ui/recharge/gifts/new_1/006.png",topBannerDisId = 90038, tabType = ENUM_SUPPLYS.ZHANLIN})
    end
    table.insert(self.tabBtnCfg , {name = 14300378,icon = "ui/recharge/gifts/new_1/015.png",topBannerDisId = 90039, tabType = ENUM_SUPPLYS.SUPPLY})
    table.insert(self.tabBtnCfg , {name = 14300096,icon = "ui/recharge/gifts/new_1/004.png", tabType = ENUM_SUPPLYS.MONTH_CARD})
    if GlobalFuncDataMgr:isOpen(1) then
        table.insert(self.tabBtnCfg , {name = 14300348,icon = "ui/recharge/gifts/new_1/011.png", tabType = ENUM_SUPPLYS.WEEK_CARD})
    end
    if GlobalFuncDataMgr:isOpen(6) then
        table.insert(self.tabBtnCfg , {name = 14300099,icon = "ui/recharge/gifts/new_1/005.png", tabType = ENUM_SUPPLYS.CONTRACT})
    end

    local giftTypeList = { 21 , 22 , 23 , 24 , 25}
    local nameList = { 190000103 ,190000104 ,190000105 ,1650009 ,190000310}
    for k ,v in pairs(giftTypeList) do
        local realGiftDaya = RechargeDataMgr:getGiftDataByInterfaceType(v)
        if #realGiftDaya > 0 then
            table.insert(self.tabBtnCfg  , {
                name = nameList[k],
                icon = "ui/recharge/gifts/new_1/006.png",
                tabType = ENUM_SUPPLYS.GIFT,
                nowIdx = #self.tabBtnCfg + 1,
                giftType = v
            })
        end
    end

    for k ,v in pairs(self.tabBtnCfg) do
        if v.giftType and  v.giftType == defaultLeftIdx then
            defaultLeftIdx = v.nowIdx
            break
        end
    end
    self.defaultLeftIdx = defaultLeftIdx or 1
    self.pageSelectId = pageSelectId
    self.selectIndex = nil
    self.pageViews = {}
    self.keepPageSelectIdx = {}
end

function SupplyMainNewView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.supplyNew.supplyMainNewView")
end

function SupplyMainNewView:initUI(ui)
    self.super.initUI(self,ui)
    self.leftTabListView = UIListView:create(self._ui.ScrollView_tab_btn)
    self.leftTabListView:setItemsMargin(2)
    self.topTabListView = UIListView:create(self._ui.ScrollView_topBtn)
    self.topTabListView:setItemsMargin(1)

    self:initLeftTabBtns()
    self:selectTabIdx(self.defaultLeftIdx)
    if self.defaultLeftIdx >= 5 then
        self.leftTabListView:scrollToItem(self.defaultLeftIdx)
    end
end

function SupplyMainNewView:registerEvents()
    EventMgr:addEventListener(self,EV_RECHARGE_UPDATE,handler(self.updateTopTabBtn, self))
end

function SupplyMainNewView:initLeftTabBtns()
    self.leftTabListView:removeAllItems()
    for i, v in ipairs(self.tabBtnCfg) do
        local item = self._ui.Panel_tabItem:clone()
        TFDirector:getChildByPath(item, "img_icon"):setTexture(v.icon)
        TFDirector:getChildByPath(item, "Label_name"):setTextById(v.name)
        item.Image_select = TFDirector:getChildByPath(item, "Image_select")
        item.img_red = TFDirector:getChildByPath(item, "img_red"):hide()
        item:onClick(function()
            self:selectTabIdx(i)
        end)
        self.leftTabListView:pushBackCustomItem(item)
    end
end

function SupplyMainNewView:updateAllRed()
    local items = self.leftTabListView:getItems()
    for idx, v in ipairs(items) do
        local isShwow = false
        local btnCfg = self.tabBtnCfg[idx]

        -- 战令
        if btnCfg.tabType == ENUM_SUPPLYS.ZHANLIN then
            local state4 = TaskDataMgr:getDailyAwardRedShow()
            local state5 = TaskDataMgr:getTrainingShopTipsState()
            if self.selectIndex == idx then
                for i, _item in ipairs(self.topTabListView:getItems()) do
                    local topRedIshow = false
                    if _item.id == 5 then -- 战令商店
                        topRedIshow = state5
                    end
                    if _item.id == 4 then -- 培养专区
                        topRedIshow = state4
                    end
                    _item.img_red:setVisible(topRedIshow)
                end
            end
            isShwow = state5 or state4
        end

        -- 补给
        if btnCfg.tabType == ENUM_SUPPLYS.SUPPLY then
            local isFundRed = false
            if (GlobalFuncDataMgr:isOpen(2)) then
                isFundRed = RechargeDataMgr:isGrowFundViewShowRed()
            end
            if self.selectIndex == idx then
                for i, _item in ipairs(self.topTabListView:getItems()) do
                    local topRedIshow = false
                    if _item.id == 3 then -- 养成基金
                        topRedIshow = isFundRed
                    end
                    _item.img_red:setVisible(topRedIshow)
                end
            end
            isShwow = isFundRed
        end

        -- 月卡
        if btnCfg.tabType == ENUM_SUPPLYS.MONTH_CARD then   
            local havecard = tobool(RechargeDataMgr:getMonthCardLeftTime() > 0)
            local cansign = RechargeDataMgr:isMonthCardCanSign()
            isShwow = havecard and cansign      
        end
        -- 周卡
        if btnCfg.tabType == ENUM_SUPPLYS.WEEK_CARD then
            local weekCardRed = RechargeDataMgr:getWeekCardCanSign()
            isShwow = weekCardRed or isShwow
        end
        -- 精灵锲约
        if btnCfg.tabType == ENUM_SUPPLYS.CONTRACT then
            isShwow = SummonDataMgr:getCanGetTask()
        end
        v.img_red:setVisible(isShwow)
    end
    self.leftTabListView:doLayout()
end

function SupplyMainNewView:selectTabIdx(idx)
    if self.selectIndex == idx then
        return
    end
    self.selectIndex = idx
    for i,item in ipairs(self.leftTabListView:getItems()) do
        item.Image_select:setVisible(i == self.selectIndex)
    end

    local topBannerDisId = self.tabBtnCfg[idx] and self.tabBtnCfg[idx].topBannerDisId or nil
    local topData = nil
    if nil ~= topBannerDisId then
        self._ui.Image_topBtn:setVisible(true)
        local _data = self:getCurTopCanShowData()
        topData = _data[1]
        if self.pageSelectId then
            for i, v in ipairs(_data) do
                if self.pageSelectId == v.id then
                    topData = _data[i]
                    if not self.keepPageSelectIdx[self.selectIndex] then
                        self.keepPageSelectIdx[self.selectIndex] = i
                    end
                end
            end
        end
        self:updateTopTabBtn()
        self:updateAllRed()
    else
        self._ui.Image_topBtn:setVisible(false)
    end

    local addPageToContent = {
        -- [1] = function()
        --     self.pageViews[idx] = requireNew("lua.logic.supplyNew.RecommondView"):new(topData)
        -- end,
        -- [2] = function()
        --     self.pageViews[idx] = requireNew("lua.logic.supplyNew.DepotView"):new(topData)
        -- end,
        -- -- [3] = function()  --屏蔽最新月卡
        -- --     self.pageViews[idx] = requireNew("lua.logic.store.PrivilageCard"):new()
        -- -- end,
        
        -- [3] = function()
        --    self.pageViews[idx] = requireNew("lua.logic.activity.MonthCardView"):new()
        -- end,
        -- [4] = function()
        --    self.pageViews[idx] = requireNew("lua.logic.store.WeekCardView"):new()
        -- end,
        -- [5] = function()
        --    self.pageViews[idx] = requireNew("lua.logic.summon.SummonContractMainView"):new()
        -- end,
    }


    if GlobalFuncDataMgr:isOpen(7) then
        table.insert(addPageToContent , function( ... )
            self.pageViews[idx] = requireNew("lua.logic.supplyNew.RecommondView"):new(topData)
        end)
    end
    table.insert(addPageToContent , function( ... )
        self.pageViews[idx] = requireNew("lua.logic.supplyNew.DepotView"):new(topData)
    end)
    table.insert(addPageToContent , function( ... )
        self.pageViews[idx] = requireNew("lua.logic.activity.MonthCardView"):new()
    end)
    if GlobalFuncDataMgr:isOpen(1) then
        table.insert(addPageToContent , function( ... )
            self.pageViews[idx] = requireNew("lua.logic.store.WeekCardView"):new()
        end)
    end
    if GlobalFuncDataMgr:isOpen(6) then
        table.insert(addPageToContent , function( ... )
            self.pageViews[idx] = requireNew("lua.logic.summon.SummonContractMainView"):new()
        end)
    end

    local giftTypeList = { 21 , 22 , 23 , 24 , 25}
    local nameList = { 190000103 ,190000104 ,190000105 ,1650009 ,190000310}
    for k ,v in pairs(giftTypeList) do
        local realGiftDaya = RechargeDataMgr:getGiftDataByInterfaceType(v)
        if #realGiftDaya > 0 then
            table.insert(addPageToContent , function()
               self.pageViews[idx] = requireNew("lua.logic.store.HotMallView"):new(realGiftDaya)
               self.pageViews[idx]:updateContentView()
            end)
        end
    end
    if not self.pageViews[idx] then
        addPageToContent[idx]()
        self:addLayerToNode(self.pageViews[idx], self._ui.Panel_content)
    end
    for _idx, v in pairs(self.pageViews) do
        v:setVisible(_idx == idx)
    end
end

function SupplyMainNewView:updateTopTabBtn()
    local topBannerDisId = self.tabBtnCfg[self.selectIndex].topBannerDisId
    if not topBannerDisId then
        return
    end

    self.topTabListView:removeAllItems()
    for i, v in ipairs(self:getCurTopCanShowData()) do
        local normalSrcImg = "ui/supplyNew/%s1.png"
        local imgIcon = v.icon
        local item = self._ui.Panel_topItem:clone()
        TFDirector:getChildByPath(item, "Label_name"):setTextById(tonumber(v.name))
        item.Image_select = TFDirector:getChildByPath(item, "Image_select")
        item.img_red = TFDirector:getChildByPath(item, "img_red")
        item.img_icon = TFDirector:getChildByPath(item, "img_icon")

        -- 判断为补给页签
        local isSupply = (self.tabBtnCfg[self.selectIndex].tabType == ENUM_SUPPLYS.SUPPLY) and true or false
        if isSupply and v.id == 4 then -- 特权支援图片改为服务器下发
            local storeData = StoreDataMgr:getOpenStore(EC_StoreType.NEW_SUPPORT)
            if storeData[1] then
                local srcPic = StoreDataMgr:getStoreInfo(storeData[1]).pic
                if srcPic and srcPic ~= "" then
                    imgIcon = srcPic
                end
            end
        end

        item.img_icon:setTexture(string.format(normalSrcImg, imgIcon))
        item.id = v.id
        item:onClick(function()
            self:topBtnClickFunc(i)
            if isSupply then
                if v.id == 3 and not RechargeDataMgr:getDayHadInFundView() then
                    RechargeDataMgr:setDayHadInFundView()
                    self:updateAllRed()
                end
            end
        end)
        self.topTabListView:pushBackCustomItem(item)
    end
    self:topBtnClickFunc(self.keepPageSelectIdx[self.selectIndex] or 1)
end

function SupplyMainNewView:getCurTopCanShowData()
    local _data = {}
    local topBannerDisId = self.tabBtnCfg[self.selectIndex].topBannerDisId
    local data = Utils:getKVP(topBannerDisId)

    -- 判断为补给页签
    local isSupply = (self.tabBtnCfg[self.selectIndex].tabType == ENUM_SUPPLYS.SUPPLY) and true or false

    if isSupply then -- 补给站固定
        -- TODO CLOSE
        -- 屏蔽特勤支援
        for k, v in pairs(data) do
            if (v.id == 4) then
                table.remove(data, k)
            end
            if not GlobalFuncDataMgr:isOpen(2) then
                if (v.id == 3) then
                    table.remove(data, k)
                end
            end
        end

        return data
    end
    for i, v in ipairs(data) do
        if RechargeDataMgr:getLeftGiftCnt(tonumber(v.interface)) > 0 then
            table.insert(_data ,v)
        else
            -- 特殊处理添加
            if v.id == 5 or v.id == 4 then
                local needIn = false
                
                if v.id == 5 then
                    local warOrderActivity = ActivityDataMgr2:getWarOrderAcrivityInfo()
                    if warOrderActivity and warOrderActivity.id then
                        local trainingTaskData = ActivityDataMgr2:getItems(warOrderActivity.id)
                        for i, _id in ipairs(trainingTaskData) do
                            if tonumber(warOrderActivity.extendData.daytask) == _id then
                                if ActivityDataMgr2:getItemInfo(warOrderActivity.activityType, _id) then
                                    needIn = true
                                    break
                                end
                            end
                        end
                    end
                end

                if v.id == 4 then
                    local taskList = TaskDataMgr:getTask(EC_TaskType.DAY_GETAWARD)
                    if taskList and table.count(taskList) > 0 then
                        needIn = true
                    end
                end

                if needIn then
                    table.insert(_data ,v)
                end
            end
        end
    end

    return _data
end

function SupplyMainNewView:topBtnClickFunc(idx)
    local data = self:getCurTopCanShowData()
    if not data[idx] then
        idx = 1
    end
    for i, item in ipairs(self.topTabListView:getItems()) do
        local normalSrcImg = "ui/supplyNew/"..data[i].icon.."1.png"
        local pressSrcImg = "ui/supplyNew/"..data[i].icon.."2.png"
        item.Image_select:setVisible(idx == i)
        if idx == i then
            item.img_icon:setTexture(pressSrcImg)
        else
            item.img_icon:setTexture(normalSrcImg)
        end
    end
    self.keepPageSelectIdx[self.selectIndex] = idx

    local page = self.pageViews[self.selectIndex]
    if page and page.refreshView then
        page:initData(data[idx])
        page:refreshView()
    end
end

function SupplyMainNewView:onShow()
    self.super.onShow(self)
    self:updateAllRed()
end

return SupplyMainNewView