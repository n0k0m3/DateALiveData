local AngelInfo = class("AngelInfo", BaseLayer)


function AngelInfo:ctor(data)
    self.super.ctor(self,data)
    self.skillid = data.skillid;
    self.heroid  = data.heroid;
    self.isfriend = data.isfriend;
    self.backTag = data.backTag

    self.scrollOfIndexT = {
        [1] = 0,
        [2] = 1,
        [5] = 2,
        [3] = 3,
        [4] = 4
    }

    self.indexOfScrollT = {
        [0] = 1,
        [1] = 2,
        [2] = 5,
        [3] = 3,
        [4] = 4
    }

    self.scrollToIndex = self.scrollOfIndexT[data.idx];
    self.curIndex = data.idx;

    self:init("lua.uiconfig.angel.angelInfo")
    self:showTopBar();
end

function AngelInfo:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui
    AngelInfo.ui = ui
    self.Button_camera  = TFDirector:getChildByPath(ui,"Button_camera");
    self.Panel_lock     = TFDirector:getChildByPath(ui,"Panel_lock");
    self.Panel_info     = TFDirector:getChildByPath(ui,"Panel_info");
    self.panel_effect   = TFDirector:getChildByPath(ui,"Panel_effect")
    self.pageView       = TFDirector:getChildByPath(ui,"PageView_effect");
    self.panel_bottom   = TFDirector:getChildByPath(ui,"bottom");
    self.Button_down    = TFDirector:getChildByPath(ui,"Button_down");
    self.Button_reset   = TFDirector:getChildByPath(ui,"Button_reset");
    self.Label_title    = TFDirector:getChildByPath(ui,"Label_title-Copy1");

    self.foucsT = {}
    for i=1,5 do
        local foucs = TFDirector:getChildByPath(self.ui,"Image_foucs"..i);
        local label = TFDirector:getChildByPath(foucs,"Label_type");
        label:setTextById(EC_Angel_Type_Name[i]);

        table.insert(self.foucsT,foucs);
    end

    self.panel_effect.orgX  = self.panel_effect:getPositionX();
    local ScrollView_tab = TFDirector:getChildByPath(ui, "ScrollView_angelInfo_1")
    self.ListView = UIListView:create(ScrollView_tab)
    self.item           = TFDirector:getChildByPath(ui,"Panel_item");

    self.Label_skill_name   = TFDirector:getChildByPath(ui,"Label_skill_name");
    self.Image_skill_icon   = TFDirector:getChildByPath(ui,"Image_skill_icon");
    self.Label_skill_desc   = TFDirector:getChildByPath(ui,"Label_skill_desc");
    self.Label_skill_point  = TFDirector:getChildByPath(ui,"Label_skill_point");
    self.Label_zuan         = TFDirector:getChildByPath(ui,"Label_zuan");

    self:updateSkillInfo();
    self:updatePage();
    self:updateEffectList();

    self.pageView:scrollToPage(self.scrollToIndex,0);
    self:setFoucs();
end

function AngelInfo:updateUI()
    self:updateSkillInfo();
    self:updateEffectList();

    self:updatePage();
    -- local index = self.pageView:getCurPageIndex();
    -- self:updateOnePage(index);
end

function AngelInfo:updateSkillInfo()
    local skillInfo = TabDataMgr:getData("Skill",self.skillid);
    if self.curIndex == 4 then
        skillInfo = TabDataMgr:getData("PassiveSkills",self.skillid);
    end
    self.Label_skill_name:setTextById(skillInfo.name);
    self.Label_skill_desc:setTextById(skillInfo.des);
    self.Image_skill_icon:setTexture(skillInfo.icon);
    self.Label_title:setTextById(EC_Angel_Type_Name2[self.curIndex]);

    local count = HeroDataMgr:getSkillPoint(self.heroid)
    local max   = HeroDataMgr:getSkillPointMax(self.heroid);
    self.Label_skill_point:setString(count.."/"..max);

    self.Label_zuan:setString(GoodsDataMgr:getItemCount(EC_SItemType.DIAMOND));
end

function AngelInfo:updateEffectList()
    self.ListView:removeAllItems();
    if self.curIndex ~= 5 then
        local talents = AngelDataMgr:getTalents(self.heroid,self.skillid)
        for pos,v in pairs(talents) do
            local lv = HeroDataMgr:getAngelTalentLv(self.heroid,self.curIndex,pos);
            if lv > 0 then
                local item = self.item:clone();
                local Image_icon = TFDirector:getChildByPath(item,"Image_icon");
                Image_icon:setTexture(AngelDataMgr:getOneTalentIcon(self.heroid,self.skillid,pos,1));

                local Label_skill = TFDirector:getChildByPath(item,"Label_skill");
                Label_skill:setTextById(AngelDataMgr:getOneTalentTips1(self.heroid,self.skillid,pos,lv))--setTextById(AngelDataMgr:getOneTalentName(self.heroid,self.skillid,k,1));

                local Label_lv = TFDirector:getChildByPath(item,"Label_lv");
                Label_lv:setString("Lv"..lv);

                self.ListView:pushBackCustomItem(item);
            end
        end
    end
end

function AngelInfo:registerEvents()
    EventMgr:addEventListener(self,EV_HERO_LEVEL_UP,handler(self.updateUI, self))
    
    if self.isfriend == true and self.backTag == "teamFight" then
        -- self.topLayer.Button_main:setTexture("ui/cc.png")
        self:setMainBtnCallback(function()
                TeamFightDataMgr:openTeamView()
            end)
    end

    self.pageView:addMEListener(TFPAGEVIEW_CHANGED, function ()
        self:pageViewChanged();
    end)

    self.Button_camera:onClick(function()
            self:onTouchCamera();
        end)

    self.Button_down:onClick(function()
            self:onTouchCamera();
        end)

    self.Button_reset:onClick(function()
            local layer = require("lua.logic.angel.AngelReset"):new({heroid = self.heroid});
            AlertManager:addLayer(layer)
            AlertManager:show()
        end)

    self.Button_reset:setVisible(not self.isfriend)
end

function getRotationAngle(px1, py1, px2, py2) 
    local o = px2 - px1;
    local a = py2 - py1;
    local at = math.atan(o/a) / math.pi * 180.0;
    
    if a < 0 then
        if o < 0 then
            at = 180 + math.abs(at);
        else
            at = 180 - math.abs(at);    
        end
    end
    
    return at;
end

function AngelInfo:linkItem(page,orgpos,targetpos)
    local orgItem = page:getChildByName("item"..orgpos);
    local targetItem = page:getChildByName("item"..targetpos);

     local org_position = orgItem:getParent():convertToWorldSpace(orgItem:getPosition());
     local tar_position = targetItem:getParent():convertToWorldSpace(targetItem:getPosition());
     local len = math.sqrt((tar_position.x - org_position.x) * (tar_position.x - org_position.x) + (tar_position.y - org_position.y) * (tar_position.y - org_position.y));

     local angle = getRotationAngle(org_position.x,org_position.y,tar_position.x,tar_position.y)

     local line = TFImage:create("ui/682.png");
     line:setContentSize(CCSizeMake(5,len));
     line:setAnchorPoint(ccp(0.5,0));
     line:setScale9Enabled(true);
     line:setPosition(orgItem:getPosition());
     line:setRotation(angle)
     page:addChild(line);
end

function AngelInfo:setOneTalentItemLock(item,locktype,lockneed)
    local lockItem = item:getChildByName("lockItem")
    if lockItem then
        lockItem:removeFromParent(true);
    end

    Utils:setNodeColor(item,ccc3(128,128,128));
    local lockItem = self.Panel_lock:clone();
    local lockLabel = TFDirector:getChildByPath(lockItem,"Label_lock");
    lockItem:setPosition(0,0);
    item:addChild(lockItem,999);
    lockItem:setName("lockItem");
    if locktype == AngelDataMgr.LOCK_TYPE.STAR then
        -- lockLabel:setString(lockneed.."星解锁");
        lockLabel:setTextById(100000003,lockneed);
    elseif locktype == AngelDataMgr.LOCK_TYPE.LVL then
        -- lockLabel:setString("解锁条件:天使星级达到" .. lockneed .. "级");
        lockLabel:setTextById(100000004, lockneed);
    else
        -- lockLabel:setString("未解锁");
        lockLabel:setTextById(450010);
    end

    for j = 1 ,4 do
        TFDirector:getChildByPath(item,"Image_lock"..j):hide();
    end
end

function AngelInfo:updateOneTalentItem(item,skillid,pos,lv,type)
    local icon = TFDirector:getChildByPath(item,"Image_icon");
    icon:setTexture(AngelDataMgr:getOneTalentIcon(self.heroid,skillid,pos,1));
    local talentid,islock,locktype,lockneed
    if lv == 0 then
        talentid = AngelDataMgr:getTalentId(self.heroid,skillid,pos,1);
        islock,locktype,lockneed = AngelDataMgr:checkUnlock(talentid,self.heroid)
    else
        talentid = AngelDataMgr:getTalentId(self.heroid,skillid,pos,lv);
        islock,locktype,lockneed = AngelDataMgr:checkUnlock(talentid,self.heroid)
    end
    
    for j = 1 , 4 do
        local Image_lock = TFDirector:getChildByPath(item,"Image_lock"..j);
        if j > AngelDataMgr:getOneTalentMaxLv(self.heroid,skillid,pos) then
            Image_lock:hide();
        else
            local talentid = AngelDataMgr:getTalentId(self.heroid,skillid,pos,j);
            local fronts = AngelDataMgr:getTalentFrontPos(talentid);
            if fronts then
                for k,v in pairs(fronts) do
                    self:linkItem(item:getParent(),pos,v);
                end
            end
            
            Image_lock:show();
            if j <= lv then
                Image_lock:setTexture("ui/674.png");
            else
                Image_lock:setTexture("ui/675.png");
            end
        end
    end

    if not islock then
        self:setOneTalentItemLock(item,locktype,lockneed);
    else
        local lockItem = item:getChildByName("lockItem")
        if lockItem then
            lockItem:removeFromParent(true);
        end
        Utils:setNodeColor(item,ccc3(255,255,255));
    end

    item:setTouchEnabled(true);
    item:onClick(function()
            if self.isfriend then
                return;
            end
            local layer = require("lua.logic.angel.AngelTalentAdd"):new({heroid = self.heroid,skillid = skillid,pos = pos,_type = type});
            AlertManager:addLayer(layer)
            AlertManager:show()
        end)
end

function AngelInfo:updateOnePage(index)
    local _type = self.indexOfScrollT[index]
    local skillid = HeroDataMgr:getAngelSkllID(self.heroid,_type);
    if skillid then
        local page = self.pageView:getPage(index);
        for pos=1,9 do
            local item = page:getChildByName("item"..pos);
            item:setVisible(AngelDataMgr:getPosIsHave(self.heroid,skillid,pos));
            if AngelDataMgr:getPosIsHave(self.heroid,skillid,pos) then
                local lv = HeroDataMgr:getAngelTalentLv(self.heroid,_type,pos)
                self:updateOneTalentItem(item,skillid,pos,lv,_type);
            end
        end

        local skillInfo = TabDataMgr:getData("Skill",skillid);
        if _type == 4 then
            skillInfo = TabDataMgr:getData("PassiveSkills",skillid);
        end 
        
        local Label_name = TFDirector:getChildByPath(page,"Label_name");
        Label_name:setTextById(13017)--skillInfo.name);

        local Label_skill_point_use = TFDirector:getChildByPath(page,"Label_skill_point_use");
        local usepoint = HeroDataMgr:calcOneAngelSkillPointUse(self.heroid,_type);
        Label_skill_point_use:setString(usepoint);--HeroDataMgr:getSkillPoint(self.heroid).."/"..HeroDataMgr:getSkillPointMax(self.heroid));
    end
end

function AngelInfo:updatePage()
    for i = 1,5 do
        if i < 5 then
            self:updateOnePage(self.scrollOfIndexT[i])
        else
            local page = self.pageView:getPage(self.scrollOfIndexT[i]);
            local skillid = HeroDataMgr:getAngelSkllID(self.heroid,i);
            local skillInfo = TabDataMgr:getData("Skill",skillid);
            local skillLv   = HeroDataMgr:getAngelLevel(self.heroid);
            dump(skillLv);

            local Label_name = TFDirector:getChildByPath(page,"Label_name");
            Label_name:setTextById(13017); --setTextById(skillInfo.name);

            local Label_lv   = TFDirector:getChildByPath(page,"Label_lv");
            Label_lv:setString(EC_Num2Roman[skillLv]);

            local Image_icon = TFDirector:getChildByPath(page,"Image_icon");
            Image_icon:setTexture(skillInfo.icon);

            local Label_skill_point_use = TFDirector:getChildByPath(page,"Label_skill_point_use");
            local usepoint = HeroDataMgr:calcOneAngelSkillPointUse(self.heroid,_type);
            Label_skill_point_use:setString(usepoint);
        end
    end
end

function AngelInfo:setFoucs()
    for k,v in pairs(self.foucsT) do
        if k == self.curIndex then
            v:setTexture("ui/689.png")
        else
            v:setTexture("ui/688.png")
        end
    end
end

function AngelInfo:pageViewChanged()
    local index = self.pageView:getCurPageIndex();
    self.curIndex = self.indexOfScrollT[index];
    self.skillid  = HeroDataMgr:getAngelSkllID(self.heroid,self.curIndex);

    self:setFoucs();

    if self.skillid then
        self:updateEffectList();
        self:updateSkillInfo();
    end 
end

function AngelInfo:onTouchCamera()
    self.isTouchCamera = not self.isTouchCamera
    self.Panel_info:setVisible(not self.isTouchCamera);
    self.panel_effect:setClippingEnabled(not self.isTouchCamera)
    self.panel_bottom:setVisible(self.isTouchCamera)
    self.Button_camera:setVisible(not self.isTouchCamera)
    if self.isTouchCamera then
        self.panel_effect:setPositionX(GameConfig.WS.width / 2 - self.panel_effect:getSize().width / 2)
    else
        self.panel_effect:setPositionX(self.panel_effect.orgX)
    end
end

function AngelInfo:onHide()
    self.super.onHide(self)
end

function AngelInfo:removeUI()
    self.super.removeUI(self)
end

return AngelInfo;