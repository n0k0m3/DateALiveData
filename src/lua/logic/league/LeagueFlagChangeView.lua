local LeagueFlagChangeView = class("LeagueFlagChangeView", BaseLayer)

function LeagueFlagChangeView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.league.leagueFlagChangeView")
end

function LeagueFlagChangeView:initData(...)
    self.m_items = {}
end

function LeagueFlagChangeView:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui

    self.Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab")
    self.Panel_class = TFDirector:getChildByPath(self.Panel_prefab, "Panel_class")
    self.Panel_flag_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_flag_item")

    self.Panel_content = TFDirector:getChildByPath(self.ui,"Panel_content")
    self.Button_close = TFDirector:getChildByPath(self.Panel_content,"Button_close")
    self.Label_title = TFDirector:getChildByPath(self.Panel_content, "Label_title")
    self.Label_sub_title = TFDirector:getChildByPath(self.Label_title, "Label_sub_title")
    self.Image_flag = TFDirector:getChildByPath(self.Panel_content, "Image_flag")
    self.Label_name = TFDirector:getChildByPath(self.Panel_content, "Label_name")
    self.Label_desc = TFDirector:getChildByPath(self.Panel_content, "Label_desc")
    self.Button_use = TFDirector:getChildByPath(self.Panel_content, "Button_use")
    self.Label_use = TFDirector:getChildByPath(self.Button_use, "Label_use")

    local ScrollView_list = TFDirector:getChildByPath(self.Panel_content, "ScrollView_list")
    self.ScrollView_list = UIListView:create(ScrollView_list)
    self.ScrollView_list:setItemsMargin(0)
    local Image_scrollBarModel = TFDirector:getChildByPath(self.Panel_content, "Image_scrollBarModel")
    local Image_scrollBarInner = TFDirector:getChildByPath(Image_scrollBarModel, "Image_scrollBarInner")
    local scrollBar = UIScrollBar:create(Image_scrollBarModel, Image_scrollBarInner)
    self.ScrollView_list:setScrollBar(scrollBar)

    self:refreshFlagView()
    LeagueDataMgr:setUnionFlagUnlockRedPoint(false)
end

function LeagueFlagChangeView:refreshFlagView()
    self.flagsData = LeagueDataMgr:getFlagCfgArrayData()
    local curCid = LeagueDataMgr:getUionEmblem()
    local selectCfg
    if self.select_cid then
        selectCfg = LeagueDataMgr:getEmblemCfgById(self.select_cid)
    elseif curCid > 0 then
        selectCfg = LeagueDataMgr:getEmblemCfgById(curCid)
    else
        selectCfg = self.flagsData[1] or LeagueDataMgr:getDefaultEmblemCfg()
    end
    self:updateSelectFlag(selectCfg)
    if #self.m_items > 0 then
        self:updateFlagItems()
        return
    end
    self.m_items = {}
    local row = 1
    local col = 1
    local totalHeight = 20
    local panel = self.Panel_class:clone()
    for i, cfg in ipairs(self.flagsData) do
        row = math.ceil(i / 4)
        col = (i - 1) % 4 + 1
        local item = self.Panel_flag_item:clone()
        local size = item:getContentSize()
        item:setPosition(ccp(col * size.width - size.width / 2 + (col - 1) * 25, - 20 - row * size.height + size.height / 2 - (row - 1) * 25))
        panel:addChild(item, 5)
        self:updateFlagItem(item, cfg)
        table.insert(self.m_items, item)
    end
    totalHeight = totalHeight + row * 194
    panel:setSize(CCSizeMake(panel:getContentSize().width, totalHeight))
    self.ScrollView_list:pushBackCustomItem(panel)
end

function LeagueFlagChangeView:updateFlagItem(item, cfg)
    if not cfg then
        return
    end
    local curCid = LeagueDataMgr:getUionEmblem()
    local Image_icon = TFDirector:getChildByPath(item, "Image_icon")
    local Image_select = TFDirector:getChildByPath(item, "Image_select")
    local Image_lock = TFDirector:getChildByPath(item, "Image_lock")
    local Image_using = TFDirector:getChildByPath(item, "Image_using")
    Image_icon:setTexture(cfg.icon)
    Image_icon:setSize(CCSizeMake(120, 120))
    Image_icon:setScale(cfg.size[1] / 100)
    Image_select:setSize(CCSizeMake(176, 192))
    Image_lock:setVisible(not LeagueDataMgr:checkEmlemUnlock(cfg.id))
    Image_using:setVisible(cfg.id == curCid)
    if cfg.id == self.select_cid then
        if self.selectedImg then
            self.selectedImg:setVisible(false)
        end
        self.selectedImg = Image_select
    end
    Image_select:setVisible(cfg.id == self.select_cid)
    
    item:setTouchEnabled(true)
    item:onClick(function()
        self:updateSelectFlag(cfg)
        if self.selectedImg then
            self.selectedImg:setVisible(false)
        end
        self.selectedImg = Image_select
        self.selectedImg:setVisible(true)
    end)
end

function LeagueFlagChangeView:updateSelectFlag(cfg)
    if not cfg then
        self.Image_flag:setVisible(false)
        self.Label_name:setVisible(false)
        self.Label_desc:setVisible(false)
        self.Button_use:setVisible(false)
        return
    else
        self.Image_flag:setVisible(true)
        self.Label_name:setVisible(true)
        self.Label_desc:setVisible(true)
        self.Button_use:setVisible(true)
    end
    self.Button_use:setVisible(true)
    self.Image_flag:setTexture(cfg.icon)
    self.Image_flag:setScale(cfg.size[2] / 100)
    self.Label_name:setTextById(cfg.name)
    self.Label_desc:setTextById(cfg.accessdes)
    local curCid = LeagueDataMgr:getUionEmblem()
    if cfg.id ~= curCid and LeagueDataMgr:checkEmlemUnlock(cfg.id) then
        self.Button_use:setVisible(true)
    else
        self.Button_use:setVisible(false)
    end
    self.select_cid = cfg.id
    self.Image_flag:setSize(CCSizeMake(94, 94))
end

function LeagueFlagChangeView:updateFlagItems()
    self.flagsData = LeagueDataMgr:getFlagCfgArrayData()
    local num = 1
    for i, cfg in ipairs(self.flagsData) do
        if num <= #self.m_items then
            local item = self.m_items[num]
            self:updateFlagItem(item, cfg)
            num = num + 1
        end
    end
end

function LeagueFlagChangeView:onFlagUpdate()
    local selectCfg
    self:updateFlagItems()
    local curCid = LeagueDataMgr:getUionEmblem()
    local selectCfg
    if self.select_cid then
        selectCfg = LeagueDataMgr:getEmblemCfgById(self.select_cid)
    elseif curCid > 0 then
        selectCfg = LeagueDataMgr:getEmblemCfgById(curCid)
    else
        selectCfg = self.flagsData[1] or LeagueDataMgr:getDefaultEmblemCfg()
    end    
    self:updateSelectFlag(selectCfg)
end

function LeagueFlagChangeView:registerEvents()
    EventMgr:addEventListener(self, EV_UNION_FLAG_CHANGE, handler(self.onFlagUpdate, self))
    
    self.Button_use:onClick(function()
        LeagueDataMgr:UpdateUnionInfo(EC_UNION_EDIT_Type.FLAG, tostring(self.select_cid))
    end)

    self.Button_close:onClick(function()
        AlertManager:close()
    end, EC_BTN.CLOSE)
end

return LeagueFlagChangeView