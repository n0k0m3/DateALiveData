local AngelTalentAdd = class("AngelTalentAdd", BaseLayer)


function AngelTalentAdd:ctor(data)
    self.super.ctor(self,data)
    dump(data)
    self.skillid    = data.skillid;
    self.pos        = data.pos;
    self.heroid     = data.heroid;
    self._type      = data._type;
    self.lvl        = HeroDataMgr:getAngelTalentLv(self.heroid,data._type,self.pos)

    EventMgr:addEventListener(self,EV_HERO_LEVEL_UP,handler(self.updatePage, self));
    self:init("lua.uiconfig.angel.angelTalentAdd")
    self:showTopBar();
end

function AngelTalentAdd:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui
    AngelTalentAdd.ui = ui

    self.backBtn        = TFDirector:getChildByPath(ui,"Button_cancel");
    self.okBtn          = TFDirector:getChildByPath(ui,"Button_ok");
    self.nameLabel      = TFDirector:getChildByPath(ui,"tips1");
    self.desLabel       = TFDirector:getChildByPath(ui,"tips2");
    self.Image_icon     = TFDirector:getChildByPath(ui,"Image_icon");
    self.Label_skill_point = TFDirector:getChildByPath(ui,"Label_skill_point");
    self.Panel_lock     = TFDirector:getChildByPath(ui,"Panel_lock");
    self.need_icon      = TFDirector:getChildByPath(ui,"need_icon");
    self.need_tips1     = TFDirector:getChildByPath(ui,"need_tips1");
    self.need_tips2     = TFDirector:getChildByPath(self.Panel_lock,"need_tips2");

    self:updatePage();
end

function AngelTalentAdd:updatePage()
    self.lvl        = HeroDataMgr:getAngelTalentLv(self.heroid,self._type,self.pos)
    local maxLv = AngelDataMgr:getOneTalentMaxLv(self.heroid,self.skillid,self.pos);
    local showLv = self.lvl + 1
    if showLv >= maxLv then
        showLv = maxLv;
    end

    local talentid = AngelDataMgr:getTalentId(self.heroid,self.skillid,self.pos,showLv);
    local isunlock,locktype,lockneed = AngelDataMgr:checkUnlock(talentid,self.heroid)

    self.okBtn:setGrayEnabled(not isunlock);
    self.okBtn:setTouchEnabled(isunlock);
    self.Panel_lock:setVisible(not isunlock);

    if locktype == AngelDataMgr.LOCK_TYPE.STAR then
        self.need_tips2:setString("X"..lockneed);
        self.need_tips1:setString(TextDataMgr:getText(800033)..":");
        self.need_icon:show();
        self.need_tips2:setPositionX(22);
    elseif locktype == AngelDataMgr.LOCK_TYPE.LVL then
        self.need_tips2:setString("Lv."..lockneed);
        self.need_tips2:setPositionX(-7);
        self.need_tips1:setString(TextDataMgr:getText(800032)..":");
        self.need_icon:hide();
    elseif locktype == AngelDataMgr.LOCK_TYPE.FRONT then
        local needSkillNameID = AngelDataMgr:getOneTalentName(self.heroid,nil,nil,nil,lockneed);
        local pos,lv,_type = AngelDataMgr:getTalentPosLvType(lockneed);
        local needSkillName = TextDataMgr:getText(needSkillNameID);
        self.need_tips2:setString(needSkillName.."lv."..lv);
        self.need_tips2:setPositionX(-7);
        self.need_tips1:setString(TextDataMgr:getText(800034)..":");
        self.need_icon:hide();
    end

    local name = AngelDataMgr:getOneTalentName(self.heroid,self.skillid,self.pos,showLv)
    self.nameLabel:setString(TextDataMgr:getText(name).."Lv."..showLv);

    local des  = AngelDataMgr:getOneTalentDes(self.heroid,self.skillid,self.pos,showLv);
    self.desLabel:setTextById(des);

    local iconpath = AngelDataMgr:getOneTalentIcon(self.heroid,self.skillid,self.pos,showLv);
    self.Image_icon:setTexture(iconpath);

    local count = HeroDataMgr:getSkillPoint(self.heroid);
    self.Label_skill_point:setString(count);

    self.maxLv = AngelDataMgr:getOneTalentMaxLv(self.heroid,self.skillid,self.pos)
    for i=1,4 do
        local item = TFDirector:getChildByPath(self.ui,"Image_item"..i);
        if i > self.maxLv then
            item:setVisible(false);
        else
            local Label_desc    = TFDirector:getChildByPath(item,"Label_desc");
            local Label_need    = TFDirector:getChildByPath(item,"Label_need");

            local tips2         = AngelDataMgr:getOneTalentTips2(self.heroid,self.skillid,self.pos,i);
            Label_desc:setString("Lv."..i.."   "..tips2);

            local need          = AngelDataMgr:getOneTalentNeed(self.heroid,self.skillid,self.pos,i);
            Label_need:setString(need);

            if i <= self.lvl then
                item:setTexture("ui/693.png");
                Label_desc:setColor(ccc3(249,64,117));
            else
                item:setTexture("ui/692.png");
                Label_desc:setColor(ccc3(169,163,166));
            end
        end
    end

    self.okBtn:setVisible(self.lvl < self.maxLv);
end

function AngelTalentAdd:onTouchOK()

    local need = AngelDataMgr:getOneTalentNeed(self.heroid,self.skillid,self.pos,self.lvl + 1);
    local count = HeroDataMgr:getSkillPoint(self.heroid);
    if need > count then
        Utils:showTips(800031)
        return
    end

    local nextid = AngelDataMgr:getTalentId(self.heroid,self.skillid,self.pos,self.lvl + 1)
    AngelDataMgr:talentLevelUp(self.heroid,nextid)
end

function AngelTalentAdd:registerEvents()
    self.backBtn:onClick(function ()
            AlertManager:closeLayer(self)
    end)

    self.okBtn:onClick(function()
            self:onTouchOK();
        end)
end

function AngelTalentAdd:onTouchCamera()
end

function AngelTalentAdd:onHide()
    self.super.onHide(self)
end

function AngelTalentAdd:removeUI()
    self.super.removeUI(self)
end

return AngelTalentAdd;