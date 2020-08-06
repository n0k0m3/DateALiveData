local TeamFightChangeHeroView = class("TeamFightChangeHeroView", BaseLayer)


function TeamFightChangeHeroView:ctor(data)
    self.super.ctor(self,data)
    -- HeroDataMgr:resetShowList(true)
    if data and #data > 0 then
        self.showHeros = data
    end

    self.showid = TeamFightDataMgr:getMySelHeroCid()
    self.showidx = HeroDataMgr:getShowIdxById(self.showid)

    if self.showHeros then
        self.showidx = 1
        for k,v in pairs(self.showHeros) do
            if v.id == self.showid then
                self.showidx = k
            end
        end
    else
        HeroDataMgr:resetShowList(true)
    end

    self.selectCell = nil;
    self.showCount = self.showHeros and #self.showHeros or HeroDataMgr:getShowCount()
    self.heroImg = {}

    self:showPopAnim(true)
    self:init("lua.uiconfig.fairy.formationLayer")
end

function TeamFightChangeHeroView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.panel_list         = TFDirector:getChildByPath(ui,"Panel_scroll");
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

    self.Image_back2 = TFDirector:getChildByPath(ui, "Image_back2")
    self.basePage = TFDirector:getChildByPath(ui,"background")
    self.basePage:setTouchEnabled(true)
    self.root_panel = TFDirector:getChildByPath(ui,"Panel_base")
    self.ui:setTouchEnabled(true)

    self.listView = UIListView:create(self.panel_list)

    self:initListView();

    self:changeShowOne();
    self.Button_info:setVisible(not self.showHeros)
    self.Label_buttom_tip:setVisible(not self.showHeros)
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
end

function TeamFightChangeHeroView:initListView()
    local count = self.showCount;

    self.selectImg = nil;
    for i=1,count do
        local item = self.panel_item:clone();

        --创建克制icon
        local startPos = item:getChildByName("Image_duty"):getPosition() + ccp(2 ,-180)
        item.panel_element = Utils:createElementPanel(item , 1 , startPos , nil , 0.5)
        self.listView:pushBackCustomItem(item);
        self:updateOneHead(item,i);

        item:setTouchEnabled(true);
        item:onClick(function()
                if self.showidx ~= i then
                    self.showidx = i
                    self.firstTouchIn  = true;
                end
                self.showid = self.showHeros and self.showHeros[i].id or HeroDataMgr:changeShowOne(i,self.firstTouchIn);
                self.firstTouchIn  = false;
                self:changeShowOne();

                local Image_select = TFDirector:getChildByPath(item,"Image_select");
                if self.showidx == i then
                    self.selectImg:hide();
                    Image_select:show()
                    self.selectImg = Image_select
                end
            end)
    end
end

function TeamFightChangeHeroView:initTableView()
    local  tableView =  TFTableView:create()
    tableView:setName("btnTableView")
    local tableViewSize = self.panel_list:getContentSize()
    tableView:setTableViewSize(CCSizeMake(tableViewSize.width, tableViewSize.height))
    tableView:setDirection(TFTableView.TFSCROLLHORIZONTAL)
    tableView:setPosition(self.panel_list:getPosition())
    tableView:setAnchorPoint(self.panel_list:getAnchorPoint());
    self.tableView = tableView

    self.tableView.logic = self

    tableView:addMEListener(TFTABLEVIEW_TOUCHED, TeamFightChangeHeroView.tableCellTouched)
    tableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, TeamFightChangeHeroView.cellSizeForTable)
    tableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, TeamFightChangeHeroView.tableCellAtIndex)
    tableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, TeamFightChangeHeroView.numberOfCellsInTableView)


    tableView:addMEListener(TFTABLEVIEW_CELLISBEGIN, TeamFightChangeHeroView.cellBegin)
    tableView:addMEListener(TFTABLEVIEW_CELLISEND, TeamFightChangeHeroView.cellEnd)


    self.panel_list:getParent():addChild(self.tableView,10)
end

function TeamFightChangeHeroView.tableCellTouched(table,cell)
    local self = cell.logic

    if self.showidx ~= cell.idx then
        self.showidx = cell.idx
    end
    self.showid = self.showHeros and self.showHeros[self.showidx].id or HeroDataMgr:getSelectedHeroId(self.showidx)
    self:changeShowOne()

    if self.tableView then
        self.tableView:reloadData();
    end
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

function TeamFightChangeHeroView.tableCellAtIndex(tab, idx)
    local self = tab.logic
    local cell = tab:dequeueCell();
    --idx = math.abs(idx - self.showCount )
    idx = idx + 1;
    if cell == nil then
        tab.cells = tab.cells or {}
        cell = TFTableViewCell:create();
        local item = self.panel_item:clone();
        item:setAnchorPoint(CCPointMake(0,0))
        item:setPosition(CCPointMake(0, 0))
        cell:addChild(item);
        cell.item = item;
         
    end

    if cell.item then
        self:updateOneHead(cell,idx);
    end

    cell.idx = idx
    cell.logic = self;
    return cell;
end

function TeamFightChangeHeroView:updateOneHead(cell,idx,isChange)
    local selectPoints = {}

    for i=1,4 do
        local point = TFDirector:getChildByPath(cell,"Image_select"..i);
        point:setVisible(false);
        table.insert(selectPoints,point);
    end
    --
    local heroid = self.showHeros and self.showHeros[idx].id or HeroDataMgr:getSelectedHeroId(idx);

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

    if isChange then
        self.heroImg[heroid]:removeFromParent();
        self.heroImg[heroid]:release();
        self.heroImg[heroid] = nil;
    end

    --防止直接拖动删除model
    if not self.heroImg[heroid] then
        local model = Utils:createHeroModel(heroid, Panel_model, 0.45, skinid,true)
        model:update(0.1)
        model:stop()

        --截屏
        local tx = CCRenderTexture:create(140,245)
        tx:begin()
        Panel_model:visit();
        tx:endToLua()

        -- if model then
        --    model:removeFromParent()
        --    Panel_model.model = nil
        -- end

        self.heroImg[heroid] = Sprite:createWithTexture(tx:getSprite():getTexture())
        self.heroImg[heroid]:setScaleY(-1)
        self.heroImg[heroid]:setPositionY(0)
        self.heroImg[heroid]:retain()
        self.heroImg[heroid]:setName("heroImg")
    end

    -- local heroImg =  Image_hero:getChildByName("heroImg")
    -- if heroImg then
    -- Image_hero:removeAllChildren()
    -- end

    local childs = Image_hero:getChildren();

    --防止self.heroImg[heroid]没有从上一个父节点移除
    if self.heroImg[heroid]:getParent() then
        self.heroImg[heroid]:removeFromParent();
    end
    Image_hero:addChild(self.heroImg[heroid])

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
    local panel_element = cell.panel_element
    PrefabDataMgr:setInfo(panel_element , hero.magicAttribute)
end

function TeamFightChangeHeroView.numberOfCellsInTableView(table)
    local self = table.logic
    return self.showCount;
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


function TeamFightChangeHeroView:onShow()
    self.super.onShow(self)
    if not self.showHeros then
        HeroDataMgr:resetShowList(true)
    end
    self.showCount = self.showHeros and #self.showHeros or HeroDataMgr:getShowCount()
    for i=1,self.showCount do
        local item = self.listView:getItem(i)
        self:updateOneHead(item,i)
    end
end

return TeamFightChangeHeroView;
