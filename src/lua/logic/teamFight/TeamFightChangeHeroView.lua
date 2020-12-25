local TeamFightChangeHeroView = class("TeamFightChangeHeroView", BaseLayer)
local enum_ruleId = {
    power_up = 1,
    power_down = 2,
    level_up = 3,
    level_down = 4,
    default = 5
}

function TeamFightChangeHeroView:ctor(data)
    self.super.ctor(self,data)
    -- HeroDataMgr:resetShowList(true)
    if data and #data > 0 then
        self.showHeros = data
    end

    self.showid = TeamFightDataMgr:getMySelHeroCid()
    self.showidx = HeroDataMgr:getShowIdxById(self.showid)
    self.showHeroIds = {}
    if self.showHeros then
        self.showidx = 1
        for k,v in pairs(self.showHeros) do
            if v.id == self.showid then
                self.showidx = k
            end
            table.insert(self.showHeroIds,v.id)
        end
    else
        local showList = clone(HeroDataMgr:resetShowList(true))
        for k,v in ipairs(showList) do
            local showIndex = HeroDataMgr:getSelectedHeroIdx(v);
            local heroid = HeroDataMgr:getSelectedHeroId(showIndex)
            table.insert(self.showHeroIds,heroid)
        end
    end


    self.selectCell = nil;
    self.showCount = self.showHeros and #self.showHeros or HeroDataMgr:getShowCount()

    self.sortRule = {{lable = 14300313,ruleId = enum_ruleId.power_up,isUp = true},
                     {lable = 14300314,ruleId = enum_ruleId.power_down,isUp = false},
                     {lable = 14300315,ruleId = enum_ruleId.level_up,isUp = true},
                     {lable = 14300316,ruleId = enum_ruleId.level_down,isUp = false},
                     {lable = 14300317,ruleId = enum_ruleId.default,isUp = true}}

    self:showPopAnim(true)
    self:init("lua.uiconfig.fairy.formationLayer")
end

function TeamFightChangeHeroView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.tableView          = TFDirector:getChildByPath(ui,"tableView")
    self.panel_item         = TFDirector:getChildByPath(ui,"Panel_item");
    self.armyLabel          = TFDirector:getChildByPath(ui,"Label_up")
    self.Button_army        = TFDirector:getChildByPath(ui,"Button_ok");
    self.Button_info        = TFDirector:getChildByPath(ui,"Button_info");
    self.Button_cancel      = TFDirector:getChildByPath(ui,"Button_cancel");

    self.qualityImg         = TFDirector:getChildByPath(ui,"Image_hero_puality");
    self.qualityImg:setScale(0.2);

    self.titleLabel         = TFDirector:getChildByPath(ui,"Label_name_title");
    self.Label_power        = TFDirector:getChildByPath(ui,"Label_power");
    self.moodValue          = TFDirector:getChildByPath(ui,"moodValue");
    self.Image_head         = TFDirector:getChildByPath(ui,"Image_head");
    self.moodValueDesc      = TFDirector:getChildByPath(ui,"moodValueDesc");
    self.Label_buttom_tip      = TFDirector:getChildByPath(ui,"Label_buttom_tip");
    self.Panel_hwx = TFDirector:getChildByPath(ui,"Panel_hwx"):hide();

    self.Image_back2 = TFDirector:getChildByPath(ui, "Image_back2")
    self.basePage = TFDirector:getChildByPath(ui,"background")
    self.basePage:setTouchEnabled(true)
    self.root_panel = TFDirector:getChildByPath(ui,"Panel_base")
    self.ui:setTouchEnabled(true)

    self.Button_sort_order = TFDirector:getChildByPath(ui, "Button_sort_order")
    self.Label_order_name = TFDirector:getChildByPath(self.Button_sort_order, "Label_order_name")
    self.Image_order_icon = TFDirector:getChildByPath(self.Button_sort_order, "Image_order_icon")

    local ScrollView_rule = TFDirector:getChildByPath(ui, "ScrollView_rule"):hide()
    self.ListView_rule = UIListView:create(ScrollView_rule)
    self.Button_rule = TFDirector:getChildByPath(ui, "Button_rule")

    self.tableViewNew = TFTableView:create()
    self.tableViewNew:setTableViewSize(self.tableView:getContentSize())
    self.tableViewNew:setDirection(TFTableView.TFSCROLLHORIZONTAL)
    self.tableViewNew:setVerticalFillOrder(TFTableView.TFTabViewFILLTOPDOWN)

    self.tableViewNew:addMEListener(TFTABLEVIEW_SIZEFORINDEX, self.cellSizeForTable)
    self.tableViewNew:addMEListener(TFTABLEVIEW_SIZEATINDEX, self.tableCellAtIndex)
    self.tableViewNew:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, self.numberOfCellsInTableView)

    self.tableViewNew.logic = self
    self.tableView:addChild(self.tableViewNew)

    self.Button_info:setVisible(not self.showHeros)
    self.Label_buttom_tip:setVisible(false)

    self:updateRuleList()

    self:changeShowOne();
end

function TeamFightChangeHeroView:registerEvents()
    EventMgr:addEventListener(self, EV_TEAM_RUN_BATTLE_SCENE,handler(self.closeUILayer,self))
    EventMgr:addEventListener(self, EV_TEAM_CLOSE_HERO_CHANGE_VIEW,handler(self.closeUILayer,self))
    self.Button_army:onClick(function ()
        local limitId = nil
        if self.showHeros then
            limitId = self.showHeros[self.showidx].limitId
        end
        TeamFightDataMgr:requestChangeHero(self.showid, limitId)
         AlertManager:closeLayer(self)
    end)

    self.Button_info:onClick(function()
            --AlertManager:changeScene(SceneType.MainScene);
            local layer = requireNew("lua.logic.fairyNew.FairyMainLayer"):new({showid = self.showid,friend = false,backTag = "teamFight"})
            AlertManager:addLayer(layer)
            AlertManager:show()
        end)

    self.Button_cancel:onClick(function ()
            AlertManager:closeLayer(self)
    end)
    self.ui:onClick(function ()
             AlertManager:closeLayer(self)
    end)

    self.Button_sort_order:onClick(function()
        local visible = self.ListView_rule:s():isVisible()
        self.ListView_rule:s():setVisible(not visible)
    end)
end

function TeamFightChangeHeroView.cellSizeForTable(table, idx)
    local self = table.logic
    local size = self.panel_item:getContentSize() 
    return size.height, size.width
end

   
function TeamFightChangeHeroView.tableCellAtIndex(table, idx)
    local self = table.logic
    local cell = table:dequeueCell()
    if nil == cell then
        table.cells = table.cells or {}
        cell = TFTableViewCell:create()
        local parentNode = self.panel_item:clone()
        parentNode:setVisible(true)
        parentNode:setPosition(ccp(0,0))
        cell:addChild(parentNode)
        cell.node = parentNode
        table.cells[cell] = true


    end
    local itemNode = cell.node
    self:updateOneHead(itemNode, idx + 1)
    return cell
end

function TeamFightChangeHeroView.numberOfCellsInTableView(table)
    return TeamFightChangeHeroView.showHeros and #TeamFightChangeHeroView.showHeros or HeroDataMgr:getShowCount()
end

function TeamFightChangeHeroView:updateRuleList()
    for k,v in ipairs(self.sortRule) do
        local ruleItem = self.Button_rule:clone()
        local Label_btn_name = TFDirector:getChildByPath(ruleItem,"Label_btn_name")
        local Image_btn_icon = TFDirector:getChildByPath(ruleItem,"Image_btn_icon")
        Label_btn_name:setTextById(v.lable)
        local scaleY = v.isUp and 1 or -1
        Image_btn_icon:setScaleY(scaleY)
        self.ListView_rule:pushBackCustomItem(ruleItem)
        ruleItem:onClick(function()
            self:selectSortRule(v)
        end)
    end

    local defaultInfo = self.sortRule[5]
    self.ruleId = defaultInfo.ruleId
    self.Label_order_name:setTextById(defaultInfo.lable)
    local scaleY = defaultInfo.isUp and 1 or -1
    self.Image_order_icon:setScaleY(scaleY)
end

function TeamFightChangeHeroView:selectSortRule(ruleInfo)
    self.ruleId = ruleInfo.ruleId
    self.Label_order_name:setTextById(ruleInfo.lable)
    local scaleY = ruleInfo.isUp and 1 or -1
    self.Image_order_icon:setScaleY(scaleY)
    self.ListView_rule:s():hide()
    self:sortHeroShowId()

    self.showid = self.ruleId == enum_ruleId.default and HeroDataMgr:changeShowOne(self.showidx,self.firstTouchIn) or self.showHeroIds[self.showidx]

    self:changeShowOne();

    self:updateUI()
end

function TeamFightChangeHeroView:sortHeroShowId()

    local function sortFunc(a,b)

        local heroInfoA = HeroDataMgr:getHero(a)
        local heroInfoB = HeroDataMgr:getHero(b)

        if self.ruleId == enum_ruleId.power_up then
            return heroInfoA.fightPower < heroInfoB.fightPower
        elseif self.ruleId == enum_ruleId.power_down then
            return heroInfoA.fightPower > heroInfoB.fightPower
        elseif self.ruleId == enum_ruleId.level_up then
            return heroInfoA.lvl < heroInfoB.lvl
        elseif self.ruleId == enum_ruleId.level_down then
            return heroInfoA.lvl > heroInfoB.lvl
        end
    end
    table.sort(self.showHeroIds,sortFunc)
end

function TeamFightChangeHeroView:updateBaseInfo( ... )
    -- body
    self.titleLabel:setTextById(HeroDataMgr:getTitleStrId(self.showid));
    self.qualityImg:setTexture(HeroDataMgr:getQualityPic(self.showid));
    self.Label_power:setString(math.floor(HeroDataMgr:getHeroPower(self.showid)));

    local roleid = HeroDataMgr:getHeroRoleId(self.showid);
    local isHaveRole = RoleDataMgr:getIsHave(roleid)
    self.Image_back2:setVisible(isHaveRole)
    if isHaveRole then
        self.moodValue:setString(RoleDataMgr:getMood(roleid));
        self.Image_head:setTexture(RoleDataMgr:getMoodIcon(roleid));
        self.moodValueDesc:setString(RoleDataMgr:getMoodDes(roleid))
    end

    local visible = self.Button_info:isVisible()
    local posX = visible and 294 or 355
    self.Button_sort_order:setPositionX(posX)
end

function TeamFightChangeHeroView:changeShowOne()

    self:updateBaseInfo()
    local isRepeat = TeamFightDataMgr:checkIsHeroRepeatWithOther(self.showid)
    if isRepeat == true then
        self.armyLabel:setTextById(2100072)
        self.Button_army:setGrayEnabled(true)
        self.Button_army:setTouchEnabled(false)
    else
        if self.showid == TeamFightDataMgr:getMySelHeroCid() then
            self.armyLabel:setTextById(240017)
            self.Button_army:setGrayEnabled(true)
            self.Button_army:setTouchEnabled(false)
        else
            self.armyLabel:setTextById(2100073)
            self.Button_army:setGrayEnabled(false)
            self.Button_army:setTouchEnabled(true)
        end
    end
end

function TeamFightChangeHeroView:updateOneHead(cell,idx,isChange)
    cell:setTouchEnabled(true);
    cell:onClick(function()
        if self.showidx ~= idx then
            self.showidx = idx
            self.firstTouchIn  = true;
        end
        self.showid = self.ruleId == enum_ruleId.default and HeroDataMgr:changeShowOne(idx,self.firstTouchIn) or self.showHeroIds[idx]
        self.firstTouchIn  = false;
        self:changeShowOne();

        local Image_select = TFDirector:getChildByPath(cell,"Image_select");
        if self.showidx == idx and self.selectImg then
            self.selectImg:hide();
            Image_select:show()
            self.selectImg = Image_select
        end
    end)

    local selectPoints = {}
    for i=1,4 do
        local point = TFDirector:getChildByPath(cell,"Image_select"..i);
        point:setVisible(false);
        table.insert(selectPoints,point);
    end
    --
    local defaultHeroId = self.showHeros and self.showHeros[idx].id or HeroDataMgr:getSelectedHeroId(idx);
    local heroid = self.ruleId == enum_ruleId.default and defaultHeroId or self.showHeroIds[idx]

    local skinid = HeroDataMgr:getCurSkin(heroid);
    local data = TabDataMgr:getData("HeroSkin", skinid)

    local Panel_mask = TFDirector:getChildByPath(cell, "Panel_mask")
    local Image_diban = TFDirector:getChildByPath(Panel_mask, "Image_diban")
    local Panel_model = TFDirector:getChildByPath(Panel_mask, "Panel_model")
    Panel_model:setBackGroundColorType(0)
    local Image_hero = TFDirector:getChildByPath(cell, "Image_hero")
    Image_diban:setTexture(data.backdrop)

    local trail_flag = TFDirector:getChildByPath(cell, "trail_flag")
    trail_flag:setVisible(HeroDataMgr:getHero(heroid).heroStatus == 2);


    if Panel_model.model then
        Panel_model.model:removeFromParent()
        Panel_model.model = nil
    end
    
    local heroImg = Utils:getHeroModelImgSrc(heroid, skinid)
    if heroImg then
        Image_hero:setTexture(heroImg)
    else
        local model = Utils:createHeroModel(heroid, Panel_model, 0.45, skinid,true)
        model:update(0.1)
        model:stop()
    end

    --等级
    local heroLv = HeroDataMgr:getLv(heroid)
    local Image_levelbg = TFDirector:getChildByPath(cell, "Image_levelbg")
    local Label_level       = TFDirector:getChildByPath(Image_levelbg,"Label_level")
    Label_level:setText("Lv."..heroLv)

    --是否助战
    local assitance = HeroDataMgr:getIsAssist(heroid)
    local Image_assistant   = TFDirector:getChildByPath(cell,"Image_assistant");
    Image_assistant:setVisible(false)

    -- local icon = TFDirector:getChildByPath(cell.item,"Image_hero");
    -- local Image_di = TFDirector:getChildByPath(cell.item, "Image_di")
    -- icon:setTexture(data.endIcon);
    -- icon:setSize(ccs(140,245))
    --Image_di:setTexture(data.backdrop)

    local name = TFDirector:getChildByPath(cell,"Label_name");
    name:setLineHeight(22)
    name:setTextById(HeroDataMgr:getNameStrId(heroid));

    local jobIcon = TFDirector:getChildByPath(cell,"Image_duty");
    local iconpath = HeroDataMgr:getHeroJobIconPath(heroid);
    jobIcon:setVisible(iconpath ~= "")
    jobIcon:setTexture(iconpath);

    local Image_select = TFDirector:getChildByPath(cell,"Image_select");
    Image_select:setVisible(self.showidx == idx)
    if Image_select:isVisible() then
        self.selectImg = Image_select;
    end

    local ishave = HeroDataMgr:getIsHave(heroid);
    for i=1,HeroDataMgr:getShowOneCount(idx) do
        --selectPoints[i]:setVisible(true);
        --减少精灵数量，暂时隐藏
        selectPoints[i]:setVisible(false)
        if HeroDataMgr:isSelected(idx,i) then
            selectPoints[i]:setTexture("ui/373.png");
        else
            selectPoints[i]:setTexture("ui/374.png");
        end
    end

    local hero = HeroDataMgr:getHero(heroid);
    local Image_xianding = TFDirector:getChildByPath(cell,"Image_xianding");
    Image_xianding:setVisible(tobool(hero.isLimitHero))
    local Image_shiyong = TFDirector:getChildByPath(cell,"Image_shiyong");
    Image_shiyong:setVisible(tobool(hero.heroStatus == 3))
    local Image_jinyong = TFDirector:getChildByPath(cell,"Image_jinyong");
    Image_jinyong:setVisible((hero.job > 3 and  hero.Inoperable))

    local Image_skyladder = TFDirector:getChildByPath(cell, "Image_skyladder")
    Image_skyladder:hide()

    -- 无尽竞速模式
    local Image_endless_hp = TFDirector:getChildByPath(cell, "Image_endless_hp")
    Image_endless_hp:setVisible(tobool(self.isEndlessRacingMode_))
    if Image_endless_hp:isVisible() then
        local LoadingBar_hp = TFDirector:getChildByPath(Image_endless_hp, "LoadingBar_hp")
        local Image_endless_dead = TFDirector:getChildByPath(cell, "Image_endless_dead")
        local Label_endless_dead = TFDirector:getChildByPath(Image_endless_dead, "Label_endless_dead")
        local percent = FubenDataMgr:getEndlessHeroHpPercent(heroid)
        percent = math.floor(percent / 100)
        LoadingBar_hp:setPercent(percent)
        Image_endless_dead:setVisible(percent <= 0)
        Label_endless_dead:setTextById(310018)
    else
        Image_levelbg:PosY(Image_levelbg:PosY() - 12)
    end
    -- local panel_element = cell.panel_element
    -- PrefabDataMgr:setInfo(panel_element , hero.magicAttribute)
end

function TeamFightChangeHeroView.cellBegin(table)
    local self = table.logic
end

function TeamFightChangeHeroView.cellEnd(table)
    local self = table.logic
end

function TeamFightChangeHeroView:closeUILayer()
    AlertManager:closeLayer(self)
end

function TeamFightChangeHeroView.cellSizeForTable(table,idx)
    self = table.logic
    return self.panel_item:getSize().height,self.panel_item:getSize().width
end

function TeamFightChangeHeroView:onHide()
    self.super.onHide(self)
end

function TeamFightChangeHeroView:removeUI()
    self.super.removeUI(self)
end

function TeamFightChangeHeroView:updateUI()
    self.tableViewNew:reloadData()
end

function TeamFightChangeHeroView:onShow()

    self.showHeroIds = {}
    if self.showHeros then
        for k,v in pairs(self.showHeros) do
            table.insert(self.showHeroIds,v.id)
        end
    else
        local showList = clone(HeroDataMgr:resetShowList(true))
        for k,v in ipairs(showList) do
            local showIndex = HeroDataMgr:getSelectedHeroIdx(v);
            local heroid = HeroDataMgr:getSelectedHeroId(showIndex)
            table.insert(self.showHeroIds,heroid)
        end
    end
    self:updateUI()
end

return TeamFightChangeHeroView;
