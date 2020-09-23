local TitleMainView = class("TitleMainView", BaseLayer)

function TitleMainView:ctor()
    self.super.ctor(self)
    self:initData()
    self:showPopAnim(true)
    self:init("lua.uiconfig.playerInfo.titleChangeView")
end

function TitleMainView:initData()
    self.tabItems_ = {}
    self.titleIdx = 0
    self.classify = nil
    self.classify_name = {
    {TextDataMgr:getText(1326513),"entire"},
    {TextDataMgr:getText(1326510),"attainment"}, 
    {TextDataMgr:getText(1326511),"challenge"},
    {TextDataMgr:getText(1326512),"exercise"}
    }
end

function TitleMainView:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui
    self.Panel_title = TFDirector:getChildByPath(self.ui, "Panel_title")
    self.Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab")
    ---预制
    self.Panel_title_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_title_item")
    self.Button_tab = TFDirector:getChildByPath(self.Panel_prefab, "Button_tab")
    self.Panel_attr_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_attr_item")

    self.Button_close = TFDirector:getChildByPath(self.Panel_title, "Button_close")

    ---称号分类
    local ScrollView_tab_list = TFDirector:getChildByPath(self.Panel_title, "ScrollView_tab_list")
    self.ListView_tab = UIListView:create(ScrollView_tab_list)

    ---称号列表
    local ScrollView_title_list = TFDirector:getChildByPath(self.Panel_title, "ScrollView_title_list")
    self.ListView_title = UIGridView:create(ScrollView_title_list)
    self.ListView_title:setItemModel(self.Panel_title_item)
    self.ListView_title:setColumn(3)
    self.ListView_title:setColumnMargin(3)
    self.ListView_title:setRowMargin(5)

    self.Label_type_name = TFDirector:getChildByPath(self.Panel_title, "Label_type_name")

    ---展示区域
    self.Panel_show = TFDirector:getChildByPath(self.Panel_title, "Panel_show")
    self.Button_use_title = TFDirector:getChildByPath(self.Panel_title, "Button_use_title")
    self.Label_use_frame = TFDirector:getChildByPath(self.Button_use_title, "Label_use_frame")

    self.Label_get_time = TFDirector:getChildByPath(self.Panel_show, "Label_get_time")
    self.Label_last_time = TFDirector:getChildByPath(self.Panel_show, "Label_last_time")
    self.Button_up = TFDirector:getChildByPath(self.Panel_show, "Button_up")
    self.Button_down = TFDirector:getChildByPath(self.Panel_show, "Button_down")
    self.Button_detail = TFDirector:getChildByPath(self.Panel_show, "Button_detail")
    self.Panel_page = TFDirector:getChildByPath(self.Panel_show, "Panel_page")

    self.Image_title_effect = TFDirector:getChildByPath(self.ui, "Image_title_effect")
    self.ScrollView_attr = UIGridView:create(TFDirector:getChildByPath(self.Panel_show, "ScrollView_attr"))
    self.ScrollView_attr:setItemModel(self.Panel_attr_item)
    self.ScrollView_attr:setColumn(2)
    self.ScrollView_attr:setColumnMargin(30)
    self.ScrollView_attr:setRowMargin(2)

    self:initTabList()
    self:selectTitleClassify(1)
    TitleDataMgr:changeRedState(false)
end

function TitleMainView:initTabList()
    for i, v in ipairs(self.classify_name) do
        local tabItem = self.Button_tab:clone()
        self.ListView_tab:pushBackCustomItem(tabItem)
        self.tabItems_[i] = tabItem
        tabItem:onClick(function()
            self:selectTitleClassify(i)
        end)
    end
end

function TitleMainView:selectTitleClassify(classify)
    if self.classify == classify then
        return
    end
    self.classify = classify
    self.chooseTitleCfg = nil
    self.chooseTitleId = 0
    for k, item in pairs(self.tabItems_) do
        local Image_tab_select = TFDirector:getChildByPath(item, "Image_tab_select"):hide()
        local Label_title = TFDirector:getChildByPath(item, "Label_title")
        local Label_title_english = TFDirector:getChildByPath(item, "Label_title_english")
        local names = self.classify_name[tonumber(k)]
        Label_title:setText(names[1])
        Label_title_english:setText(names[2])
        if classify == tonumber(k) then
            Image_tab_select:show()
            Label_title:setColor(ccc3(255,255,255))
            Label_title_english:setColor(ccc3(255,255,255))
        else
            Label_title:setColor(ccc3(73,85,127))
            Label_title_english:setColor(ccc3(73,85,127))
        end
    end
    self.Label_type_name:setText(self.classify_name[classify][1])
    self.Image_title_effect:removeAllChildren()
    self:updateTitleList()
end

function TitleMainView:titleControlBack()
    if self.isTakeOff then
        Utils:showTips(1327106)
    else
        Utils:showTips(1327105)
    end
    self:updateTitleList()
end

function TitleMainView:updateTitleList()

    self.chooseImg = nil
    self.chooseTitleCfg = nil

    self.ListView_title:removeAllItems()
    local titleCfgs = TitleDataMgr:getEnableShowTitles(self.classify - 1)
    for i,cfg in ipairs(titleCfgs) do
        local titleItem = self.Panel_title_item:clone()
        self:updateTitleItem(titleItem, cfg)
    end

    self:initTitleBaseUI()
end

function TitleMainView:updateTitleItem(titleItem,cfg)

    local titleInfo = TitleDataMgr:getTitleCfg(cfg.id)
    if not titleInfo then
        return
    end
    local isOwn = TitleDataMgr:getOwnTitleById(titleInfo.id)
    local Image_title_icon = TFDirector:getChildByPath(titleItem, "Image_title_icon")
    local skeletonTitleNode = TitleDataMgr:getTitleEffectSkeletonModle(titleInfo.id, 1)
    Image_title_icon:addChild(skeletonTitleNode,10)

    local Image_item_lock = TFDirector:getChildByPath(titleItem, "Image_item_lock")
    Image_item_lock:setVisible(not isOwn)

    local Image_use_bg = TFDirector:getChildByPath(titleItem, "Image_use_bg")
    local equipdTitleId = TitleDataMgr:getEquipedTitleId()
    Image_use_bg:setVisible(equipdTitleId == cfg.id)

    local Panel_page = TFDirector:getChildByPath(titleItem, "Panel_page")
    local showTypeCfgs = TitleDataMgr:getTileCfgByTitleType(cfg.titleType)
    if #showTypeCfgs > 1 then
        for i,v in ipairs(showTypeCfgs) do
            local pageImg 
            if v.id == cfg.id then
                pageImg = Sprite:create("ui/title/change/ui_006.png")
            else
                pageImg = Sprite:create("ui/title/change/ui_005.png")
            end
            pageImg:setPosition(ccp(i * 15, 0))
            Panel_page:addChild(pageImg)            
        end
    end


    local isCheckTitleId = TitleDataMgr:isCheckTitleId(cfg.id)
    local ownTitleInfo = TitleDataMgr:getOwnTitleById(cfg.id)
    local Image_new_red = TFDirector:getChildByPath(titleItem, "Image_new_red")
    Image_new_red:setVisible(false)

    local Image_item_choose = TFDirector:getChildByPath(titleItem, "Image_item_choose"):hide()
    if not self.chooseImg then
        Image_item_choose:setVisible(true)
        self.chooseImg = Image_item_choose
        self.chooseTitleCfg = cfg
        self.chooseTitleId = cfg.id
    end

    titleItem:onClick(function()
        if self.chooseImg then
            self.chooseImg:setVisible(false)
        end
        self.chooseImg = Image_item_choose
        self.chooseImg:setVisible(true)
        self.chooseTitleCfg = cfg
        self.chooseTitleId = cfg.id
        self:initTitleBaseUI()
    end)

    self.ListView_title:pushBackCustomItem(titleItem)
end

function TitleMainView:initTitleBaseUI()
    if not self.chooseTitleCfg then
        self.Panel_show:hide()
        return
    end
    self.Panel_show:show()
    self.showTypeCfgs = TitleDataMgr:getTileCfgByTitleType(self.chooseTitleCfg.titleType)
    self.Panel_page:removeAllChildren()
    self.pageImgs = {}
    local num = #self.showTypeCfgs / 2
    for i,v in ipairs(self.showTypeCfgs) do
        local pageImg = Sprite:create("ui/title/change/ui_005.png")
        pageImg:setPosition(ccp((i - num) * 15, 0))
        self.Panel_page:addChild(pageImg)
        self.pageImgs[i] = pageImg
        if v.id == self.chooseTitleCfg.id then
            self.titleIdx = i
        end
    end
    self:updatePageUI()
    self:updateTitleBaseInfo()
end

function TitleMainView:updateTitleBaseInfo()
    local titleInfo = TitleDataMgr:getTitleCfg(self.chooseTitleCfg.id)
    local createTime,lastTime,isOwn = "","",false
    local ownTitleInfo = TitleDataMgr:getOwnTitleById(self.chooseTitleCfg.id)
    if ownTitleInfo then
        isOwn = true
        --local year, month, day = Utils:getDate(ownTitleInfo.createTime, true)
        createTime = Utils:getUTCDate(ownTitleInfo.createTime, GV_UTC_TIME_ZONE):fmt("%Y.%m.%d")..GV_UTC_TIME_STRING
    else
        createTime = TextDataMgr:getText(1327104)
    end
    if titleInfo.timeDescription > 0 then
        lastTime = TextDataMgr:getText(titleInfo.timeDescription)
    elseif titleInfo.effectivetime == -1 then
        lastTime = TextDataMgr:getText(4007007)
    else
        local day, hour, min = Utils:getFuzzyDHMS(titleInfo.effectivetime, true)
        lastTime = TextDataMgr:getText(270353, day, hour, min)
    end  
    self.Label_get_time:setTextById(111000101, createTime)
    self.Label_last_time:setString(TextDataMgr:getText(4007003)..lastTime)

    self.ScrollView_attr:removeAllItems()
    if table.count(titleInfo.baseAttribute) < 1 then
        
    else
        local attrCnt = 0
        for k,v in pairs(titleInfo.baseAttribute) do
            local item = self.Panel_attr_item:clone()
            self.ScrollView_attr:pushBackCustomItem(item)
            local Label_attr = TFDirector:getChildByPath(item, "Label_attr"):hide()
            local attConfig = HeroDataMgr:getAttributeConfig(k)
            if attConfig then
                Label_attr:show()
                local value = math.abs(tonumber(v) / 100)
                local attValue = string.format("%."..attConfig.decimal.."f",value)
                attValue = string.format(attConfig.displayFormat,attValue)
                local attrNameStr = TextDataMgr:getText(attConfig.name)
                Label_attr:setText(attrNameStr.." "..attValue)
            end
        end
    end

    self.Button_use_title:setTouchEnabled(isOwn and self.chooseTitleId == self.chooseTitleCfg.id)
    self.Button_use_title:setGrayEnabled(not isOwn or self.chooseTitleId ~= self.chooseTitleCfg.id)

    local equipdTitleId = TitleDataMgr:getEquipedTitleId()
    if equipdTitleId == self.chooseTitleCfg.id then
        self.Label_use_frame:setTextById(111000102)
    else
        self.Label_use_frame:setTextById(111000103)
    end


    -- local captainHeroId
    -- local roleCnt = HeroDataMgr:getShowCount()
    -- for i=1,roleCnt do
    --     local heroid = HeroDataMgr:getSelectedHeroId(i)
    --     local job = HeroDataMgr:getHeroJob(heroid)
    --     if job == 1 then
    --         captainHeroId = heroid
    --     end
    -- end

    -- if captainHeroId then
    --     local model = Utils:createHeroModel(captainHeroId, self.Panel_show, titleInfo.size1 * 0.01,nil)
    --     model:setAnchorPoint(ccp(0.5, 0.5))
    --     model:setPosition(ccp(titleInfo.excursion1[1], titleInfo.excursion1[2] - 150))
    -- end

    self.Image_title_effect:removeAllChildren()
    local skeletonTitleNode = TitleDataMgr:getTitleEffectSkeletonModle(titleInfo.id, 1)
    self.Image_title_effect:addChild(skeletonTitleNode,10)
end

function TitleMainView:changeTitleIdx(isLeft)
    if isLeft then
        self.titleIdx = self.titleIdx + 1
    else
        self.titleIdx = self.titleIdx - 1
    end
    if self.titleIdx < 1 then
        self.titleIdx = 1
    end
    if self.titleIdx > #self.showTypeCfgs then
        self.titleIdx = #self.showTypeCfgs
    end
    self.chooseTitleCfg = self.showTypeCfgs[self.titleIdx]
    self:updatePageUI()
    self:updateTitleBaseInfo()
end

function TitleMainView:updatePageUI()
    for i,pageImg in ipairs(self.pageImgs) do
        if i == self.titleIdx then
            pageImg:setTexture("ui/title/change/ui_006.png")
        else
            pageImg:setTexture("ui/title/change/ui_005.png")
        end
    end
end

function TitleMainView:registerEvents()

    EventMgr:addEventListener(self, EV_UPDATE_TITLE, handler(self.updateTitleList, self))
    EventMgr:addEventListener(self, EV_EQUIP_OR_TAKEOFF_TITLE, handler(self.titleControlBack, self))

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    local function onTouchBegan(touch, location)
        touch.startPos = location
        return true
    end

    local function onTouchMoved(touch, location)
        local offset = location.x - touch.startPos.x
        if math.abs(offset) > 10 then
            touch.isMoved = true
        end
    end

    local function onTouchUp(touch, location)
        local offset = location.x - touch.startPos.x
        if touch.isMoved and math.abs(offset) > 30 then
            if offset < 0 then
                self:changeTitleIdx(true)
            else
                self:changeTitleIdx(false)
            end
        end
    end

    self.Image_title_effect:setTouchEnabled(true)
    self.Image_title_effect:addMEListener(TFWIDGET_TOUCHBEGAN, onTouchBegan)
    self.Image_title_effect:addMEListener(TFWIDGET_TOUCHMOVED, onTouchMoved)
    self.Image_title_effect:addMEListener(TFWIDGET_TOUCHENDED, onTouchUp)
    self.Image_title_effect:setSwallowTouch(false)

    self.Button_up:onClick(function()
        self:changeTitleIdx(false)
    end)

    self.Button_down:onClick(function()
        self:changeTitleIdx(true)
    end)

    self.Button_detail:onClick(function()
        Utils:openView("Title.TitleDetailView",self.chooseTitleCfg.id)
    end)

    self.Button_use_title:onClick(function()

        local ownTitleInfo = TitleDataMgr:getOwnTitleById(self.chooseTitleCfg.id)
        if not ownTitleInfo then
            return
        end

        local equipdTitleId = TitleDataMgr:getEquipedTitleId()
        if equipdTitleId == self.chooseTitleCfg.id then
            self.isTakeOff = true
            TitleDataMgr:Send_TakeOffTitleId(self.chooseTitleCfg.id)
        else
            self.isTakeOff = false
            TitleDataMgr:Send_EquipTitleId(self.chooseTitleCfg.id)
        end
    end)

end

return TitleMainView