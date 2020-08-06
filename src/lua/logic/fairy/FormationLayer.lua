local FormationLayer = class("FormationLayer", BaseLayer)

function FormationLayer:ctor(data)
    self.super.ctor(self,data)
    self.showid = HeroDataMgr:getTeamLeaderId();
    self.showidx = 1;
    self.selectCell = nil;

    self.pos = data._pos;
    self.changeToServer = data.changeToServer
    self.limitSimulationTrial = data.limitSimulationTrial
    self.containSimulationTrial = data.containSimulationTrial
    if self.limitSimulationTrial then 
        self.containSimulationTrial = true
        self.changeToServer = false
    end
    if data.isEndless then
        local endlessInfo = FubenDataMgr:getEndlessInfo()
        self.isEndlessRacingMode_ = FubenDataMgr:isEndlessRacingMode(endlessInfo.curStage)
    end

    self.isSkyLadder = tobool(data.isSkyLadder)

    HeroDataMgr:resetShowList(true,self.containSimulationTrial);
    self.showCount = HeroDataMgr:getShowCount();
    local isformation = HeroDataMgr:getIsFormationOn(self.pos);
    if isformation then
        self.showid = HeroDataMgr:getHeroIdByFormationPos(self.pos);
        self.showidx = HeroDataMgr:getShowIdxById(self.showid);
    else
        self.showidx,self.showid = HeroDataMgr:getUnFormationFirstId()
    end
    dump({"_________init:",self.showid,self.showidx ,self.pos})
    self.firstTouchIn = false;

    self.heroImg = {}

    self:showPopAnim(true)
    self:init("lua.uiconfig.fairy.formationLayer")
end

function FormationLayer:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui
    FormationLayer.ui = ui
    self:addLockLayer()

    self.panel_list    		= TFDirector:getChildByPath(ui,"Panel_scroll");
    self.panel_item			= TFDirector:getChildByPath(ui,"Panel_item");
    self.armyLabel			= TFDirector:getChildByPath(ui,"Label_up")
    self.Button_army		= TFDirector:getChildByPath(ui,"Button_ok");
    self.Button_info		= TFDirector:getChildByPath(ui,"Button_info");
    self.Button_cancel		= TFDirector:getChildByPath(ui,"Button_cancel");

    self.qualityImg			= TFDirector:getChildByPath(ui,"Image_hero_puality");
    self.qualityImg:setScale(0.2);

    self.titleLabel			= TFDirector:getChildByPath(ui,"Label_name_title");
    self.Label_power		= TFDirector:getChildByPath(ui,"Label_power");
    self.moodValue			= TFDirector:getChildByPath(ui,"moodValue");
    self.Image_head			= TFDirector:getChildByPath(ui,"Image_head");
    self.moodValueDesc		= TFDirector:getChildByPath(ui,"moodValueDesc");

    self.Image_back2 = TFDirector:getChildByPath(ui, "Image_back2")
    self.Label_buttom_tip = TFDirector:getChildByPath(ui, "Label_buttom_tip"):hide()
    self.Label_buttom_tip:setTextById(2108112)
    self.listView = UIListView:create(self.panel_list)

    self:initListView();

    -- self:initTableView();
    -- self.tableView:reloadData()

    self:changeShowOne();
end

function FormationLayer:initListView()
    local count = HeroDataMgr:getShowCount();
    self.selectImg = nil;
    for i=1,count do
        local heroid = HeroDataMgr:getSelectedHeroId(idx);
        local item = self.panel_item:clone();

        --创建克制icon
        local startPos = item:getChildByName("Image_duty"):getPosition() + ccp(105 ,-170)
        item.panel_element = Utils:createElementPanel(item , 1 , startPos , nil , 0.5)

        self.listView:pushBackCustomItem(item);
        self:updateOneHead(item,i);

        item:setTouchEnabled(true);
        item:onClick(function()
                if self.showidx ~= i then
                    self.showidx = i
                    self.firstTouchIn  = true;
                end
                self.showid = HeroDataMgr:changeShowOne(i,self.firstTouchIn);
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

function FormationLayer:updateUI()
    dump("FormationLayer")
    local count = HeroDataMgr:getShowCount();
    self.selectImg = nil;
    for i=1,count do
        local item = self.listView:getItem(i);
        self:updateOneHead(item,i,true);
    end
end

function FormationLayer:onFormationChange(heroid)
    if self.showid then
        VoiceDataMgr:playVoiceByHeroID("battle_play",self.showid)
        AlertManager:close()
    end
end

function FormationLayer:fitSkyLadderFight()
    local heroFightCnt = SkyLadderDataMgr:getHeroFightCnt(self.showid)
    heroFightCnt = heroFightCnt or 0
    return heroFightCnt ~= 0
end

function FormationLayer:registerEvents()
    EventMgr:addEventListener(self,EV_FORMATION_CHANGE,handler(self.onFormationChange, self));
    EventMgr:addEventListener(self,EV_HERO_LEVEL_UP,handler(self.updateUI, self));

    self.Button_army:onClick(function ()
        --if self.isSkyLadder then
        --    local heroFightCnt = SkyLadderDataMgr:getHeroFightCnt(self.showid)
        --    heroFightCnt = heroFightCnt or 0
        --    if heroFightCnt == 0 then
        --        Utils:showTips(100000061)
        --        return
        --    end
        --end
        if HeroDataMgr:getIsFormationOn(self.pos) and HeroDataMgr:getHeroIdByFormationPos(self.pos) ~= self.showid then
            if not self.changeToServer then
                local oldID = HeroDataMgr:getHeroIdByFormationPos(self.pos);
                HeroDataMgr:setFormationHero(self.pos,self.showid,oldID,self.limitSimulationTrial);
                EventMgr:dispatchEvent(EV_FORMATION_CHANGE,self.showid,oldID);
            else
                ---更换
                if self.isSkyLadder then
                    local isFit = self:fitSkyLadderFight()
                    if not isFit then
                        Utils:showTips(100000061)
                        return
                    end
                end
                HeroDataMgr:heroOnBattle(HeroDataMgr:getHeroIdByFormationPos(self.pos),self.showid);
            end
        else
            if not self.changeToServer then
                HeroDataMgr:setFormationHero(self.pos,self.showid,nil,self.limitSimulationTrial)
                EventMgr:dispatchEvent(EV_FORMATION_CHANGE,self.showid,nil);
            else
                ---编入，移除
                if not HeroDataMgr:getIsFormationOn(self.pos) then
                    if self.isSkyLadder then
                        local isFit = self:fitSkyLadderFight()
                        if not isFit then
                            Utils:showTips(100000061)
                            return
                        end
                    end
                end
                HeroDataMgr:heroOnBattle(self.showid);
            end
        end
        GameGuide:checkGuideEnd(self.guideFuncId)
        self.Button_army:setTouchEnabled(false)
    end)

    self.Button_info:onClick(function()
            --AlertManager:changeScene(SceneType.MainScene);
        if self.isSkyLadder then
            HeroDataMgr.showid = self.showid;
            Utils:openView("fairyNew.FairyDetailsLayer", {showid= self.showid, friend=false, gotoWhichTab = 3,skyladder = true})
        else
            local layer = Utils:openView("fairyNew.FairyDetailsLayer",{showid=self.showid, friend=false})
            layer:onTouchFairy()
        end
    end)

    self.Button_cancel:onClick(function ()
            AlertManager:close();
    end)
end

function FormationLayer:initTableView()
    local  tableView =  TFTableView:create()
    tableView:setName("btnTableView")
    local tableViewSize = self.panel_list:getContentSize()
    tableView:setTableViewSize(CCSizeMake(tableViewSize.width, tableViewSize.height))
    tableView:setDirection(TFTableView.TFSCROLLHORIZONTAL)
    tableView:setPosition(self.panel_list:getPosition())
    tableView:setAnchorPoint(self.panel_list:getAnchorPoint());
    self.tableView = tableView

    self.tableView.logic = self

    tableView:addMEListener(TFTABLEVIEW_TOUCHED, FormationLayer.tableCellTouched)
    tableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, FormationLayer.cellSizeForTable)
    tableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, FormationLayer.tableCellAtIndex)
    tableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, FormationLayer.numberOfCellsInTableView)


    tableView:addMEListener(TFTABLEVIEW_CELLISBEGIN, FormationLayer.cellBegin)
    tableView:addMEListener(TFTABLEVIEW_CELLISEND, FormationLayer.cellEnd)


    self.panel_list:getParent():addChild(self.tableView,10)
end

function FormationLayer.tableCellTouched(table,cell)
    local self = cell.logic

    if self.showidx ~= cell.idx then
        self.showidx = cell.idx
        self.firstTouchIn  = true;
    end
    self.showid = HeroDataMgr:changeShowOne(cell.idx,self.firstTouchIn);
    self.firstTouchIn  = false;
    self:changeShowOne();

    if self.tableView then
        self.tableView:reloadData();
    end
end

function FormationLayer:updateBaseInfo( ... )
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
    local hero = HeroDataMgr:getHero(self.showid)
    if hero then 
        self.Label_buttom_tip:setVisible(hero.heroStatus == 3)
    else
        self.Label_buttom_tip:hide()
    end
end

function FormationLayer:changeShowOne()

    self:updateBaseInfo();

    local ishave = HeroDataMgr:getIsHave(self.showid);
    local job = HeroDataMgr:getHeroJob(self.showid);
        dump({self.showid,self.pos ,job})
    if job == self.pos and HeroDataMgr:getFormationHeroCnt() == 1 then
        self.armyLabel:setTextById(2100122);
        self.Button_army:setGrayEnabled(true);
        self.Button_army:setTouchEnabled(false);
    elseif job == self.pos and HeroDataMgr:getFormationHeroCnt() > 1 then
        self.armyLabel:setTextById(2100122);
        self.Button_army:setGrayEnabled(false);
        self.Button_army:setTouchEnabled(true);
    elseif job < 4 then 
        self.armyLabel:setTextById(2100123);
        self.Button_army:setGrayEnabled(true);
        self.Button_army:setTouchEnabled(false);
    elseif job == 4 and HeroDataMgr:checkOnFormationByRole(self.showid) then
        --同一roleID 的角色我可以替换处理
        local roleId1
        local roleId2 = HeroDataMgr:getHeroRoleId(self.showid);
        local curID   = HeroDataMgr:getHeroIdByFormationPos(self.pos)
        if curID then
            roleId1 = HeroDataMgr:getHeroRoleId(curID)
        end
        if curID and roleId1 == roleId2 then
            self.Button_army:setGrayEnabled(false);
            self.Button_army:setTouchEnabled(true);
            self.armyLabel:setTextById(2100124); --更换队员
        else
            self.armyLabel:setTextById(2100123);
            self.Button_army:setGrayEnabled(true);
            self.Button_army:setTouchEnabled(false);
        end
    elseif job == 4 and not HeroDataMgr:getFormationIsFull() and HeroDataMgr:getIsFormationOn(self.pos) then
        self.Button_army:setGrayEnabled(false);
        self.Button_army:setTouchEnabled(true);
        self.armyLabel:setTextById(2100124); --更换队员
    elseif job == 4 and not HeroDataMgr:getFormationIsFull() then
        self.Button_army:setGrayEnabled(false);
        self.Button_army:setTouchEnabled(true);
        self.armyLabel:setTextById(2100125);
    elseif job == 4 and HeroDataMgr:getFormationIsFull() then
        self.Button_army:setGrayEnabled(false);
        self.Button_army:setTouchEnabled(true);
        self.armyLabel:setTextById(2100124);
    end


    local isformation = HeroDataMgr:getIsFormationOn(self.pos);
    local isformationID = HeroDataMgr:getHeroIdByFormationPos(self.pos);

    local ha = HeroDataMgr:getHero(self.showid) or {}
    local hb = HeroDataMgr:getHero(isformationID) or {}
    if ha.Inoperable or (isformation and hb.Inoperable) then
        self.Button_army:setGrayEnabled(true);
        self.Button_army:setTouchEnabled(false);
    end

    --无尽模式 英雄死亡后无法操作下阵bug
    if self.isEndlessRacingMode_ and not (job == self.pos and HeroDataMgr:getFormationHeroCnt() > 1 ) then
        local percent = FubenDataMgr:getEndlessHeroHpPercent(self.showid)
        percent = math.floor(percent / 100)
        if percent <= 0 then
            self.armyLabel:setTextById(100000039);
            self.Button_army:setGrayEnabled(true);
            self.Button_army:setTouchEnabled(false);
        end
    end


    self.Button_info:setVisible( not ha.Inoperable)
    self.Button_info:hide()
    if self.isSkyLadder then
        self.Button_info:setVisible(true)
    end
end

function FormationLayer.tableCellAtIndex(tab, idx)
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

function FormationLayer:updateOneHead(cell,idx,isChange)
    local selectPoints = {}

    for i=1,4 do
        local point = TFDirector:getChildByPath(cell,"Image_select"..i);
        point:setVisible(false);
        table.insert(selectPoints,point);
    end
    --
    local heroid = HeroDataMgr:getSelectedHeroId(idx);
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
    local Label_level 		= TFDirector:getChildByPath(Image_levelbg,"Label_level")
    Label_level:setText("Lv."..heroLv)

    --是否助战
    local assitance = HeroDataMgr:getIsAssist(heroid)
    local Image_assistant 	= TFDirector:getChildByPath(cell,"Image_assistant");
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
    local Label_jiyong = TFDirector:getChildByPath(Image_jinyong, "Label_jiyong")
    Label_jiyong:setTextById(300017)

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

    --天梯
    local Image_skyladder = TFDirector:getChildByPath(cell, "Image_skyladder")
    Image_skyladder:setVisible(self.isSkyLadder)
    if self.isSkyLadder then
        local heroFightCnt = SkyLadderDataMgr:getHeroFightCnt(heroid)
        heroFightCnt = heroFightCnt or 0
        local Label_ladder_cnt = TFDirector:getChildByPath(Image_skyladder, "Label_ladder_cnt")
        Label_ladder_cnt:setText(heroFightCnt)
        Image_jinyong:setVisible(heroFightCnt == 0)
        local Label_jiyong = TFDirector:getChildByPath(Image_jinyong, "Label_jiyong")
        Label_jiyong:setTextById(100000039)
    end

    local panel_element = cell.panel_element
    PrefabDataMgr:setInfo(panel_element , hero.magicAttribute)
end

function FormationLayer.numberOfCellsInTableView(table)
    local self = table.logic
    return HeroDataMgr:getShowCount();
end

function FormationLayer.cellBegin(table)
    local self = table.logic
end

function FormationLayer.cellEnd(table)
    local self = table.logic
end

function FormationLayer.cellSizeForTable(table,idx)
    self = table.logic
    return self.panel_item:getSize().height,self.panel_item:getSize().width
end

function FormationLayer:onHide()
    self.super.onHide(self)
end

function FormationLayer:removeUI()
    self.super.removeUI(self)
    --HeroDataMgr:changeDataToSelf();
end


function FormationLayer:onShow()
    self.super.onShow(self)
    
    self:removeLockLayer()
    HeroDataMgr:resetShowList(true,self.containSimulationTrial);
    self.showCount = HeroDataMgr:getShowCount();
    self:timeOut(function()
            GameGuide:checkGuide(self);
                 end,0)
end


---------------------------guide------------------------------

--引导点击编入按钮
function FormationLayer:excuteGuideFunc13001(guideFuncId)
    local targetNode = self.Button_army
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

return FormationLayer;
