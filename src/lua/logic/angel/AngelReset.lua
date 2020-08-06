local AngelReset = class("AngelReset", BaseLayer)


function AngelReset:ctor(data)
    self.super.ctor(self,data)
    self.heroid     = data.heroid;
    self.selectTable = {};
    self.seletfoucs = {};
    
    self:init("lua.uiconfig.angel.angelReset")
    self:showTopBar();
end

function AngelReset:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui
    AngelReset.ui = ui

    self.backBtn        = TFDirector:getChildByPath(ui,"Button_cancel");
    self.okBtn          = TFDirector:getChildByPath(ui,"Button_ok");
    self.Label_free     = TFDirector:getChildByPath(ui,"Label_free");
    self.Label_free_Tips= TFDirector:getChildByPath(ui,"tips2");
    self.Image_zuan     = TFDirector:getChildByPath(ui,"Image_zuan");
    self.Label_zuan     = TFDirector:getChildByPath(ui,"Label_zuan");

    for i=1,4 do
        local item = TFDirector:getChildByPath(self.ui,"Image_item"..i);
        local imageSelect = TFDirector:getChildByPath(item,"Image_select"..i);

        local skillid = HeroDataMgr:getAngelSkllID(self.heroid,i);
        local skillInfo = TabDataMgr:getData("Skill",skillid);
        if i == 4 then
            skillInfo = TabDataMgr:getData("PassiveSkills",skillid);
        end 
        local Image_icon  = TFDirector:getChildByPath(item,"Image_icon");
        Image_icon:setTexture(skillInfo.icon);

        local gou       = TFDirector:getChildByPath(item,"Image_gou");
        gou:setVisible(false);
        table.insert(self.seletfoucs,gou);
        item:setTouchEnabled(true)
        imageSelect:setTouchEnabled(true)
        item:onClick(function()
                self:onTouchItem(i);
            end)
        imageSelect:onClick(function()
                self:onTouchItem(i);
            end)
    end
    self:updatePage();
end

function AngelReset:onTouchItem(index)

    local use = HeroDataMgr:calcOneAngelSkillPointUse(self.heroid,index);
    if use <= 0  then
        Utils:showTips(100000005);
        return;
    end

    self.seletfoucs[index]:setVisible(not self.seletfoucs[index]:isVisible());
    if table.indexOf(self.selectTable,index) ~= -1 then
        table.removeItem(self.selectTable,index);
    else
        table.insert(self.selectTable,index)
    end
end

function AngelReset:updatePage()
    self.selectTable = {};
    for i=1,4 do
        local item = TFDirector:getChildByPath(self.ui,"Image_item"..i);
        local Label_num = TFDirector:getChildByPath(item,"Label_num");
        local usepoint  = HeroDataMgr:calcOneAngelSkillPointUse(self.heroid,i);
        Label_num:setString(usepoint);
        local gou       = TFDirector:getChildByPath(item,"Image_gou");
        gou:setVisible(false);

        local Label_desc = TFDirector:getChildByPath(item,"Label_desc");
        Label_desc:setTextById(EC_Angel_Type_Name[i]);
    end

    self.Label_free:setString(HeroDataMgr:getAngelResetFreeTimes());

    local data = Utils:getKVP(8001);
    local playerLv = MainPlayer:getPlayerLv();
    self.Label_free:setVisible(playerLv >= data.resetPlv and HeroDataMgr:getAngelResetFreeTimes() > 0);
    self.Label_free_Tips:setVisible(playerLv >= data.resetPlv and HeroDataMgr:getAngelResetFreeTimes() > 0);

    local id,num;
    for k,v in pairs(data.resetCost) do
        id = k;
        num = v;
    end
    self.Image_zuan:setVisible(playerLv >= data.resetPlv and HeroDataMgr:getAngelResetFreeTimes() <= 0);
    self.Label_zuan:setString(num);
end

function AngelReset:onTouchOK()
    if #self.selectTable <= 0 then
        Utils:showTips(1100001);
        return
    end

    local data = Utils:getKVP(8001);
    local playerLv = MainPlayer:getPlayerLv();
    local id,num;
    for k,v in pairs(data.resetCost) do
        id = k;
        num = v;
    end

    local iscan = false;
    if playerLv < data.resetPlv then
        iscan = true;
    elseif HeroDataMgr:getAngelResetFreeTimes() > 0 then
        iscan = true;
    elseif GoodsDataMgr:getItemCount(id) >= num then
        iscan = true;
    end

    if not iscan then
        Utils:showTips(800048)
        return;
    end

    HeroDataMgr:resetAngelTree(self.heroid,self.selectTable);
end

function AngelReset:registerEvents()
    EventMgr:addEventListener(self,EV_HERO_LEVEL_UP,handler(self.updatePage, self));
    
    self.backBtn:onClick(function ()
            AlertManager:closeLayer(self)
    end)

    self.okBtn:onClick(function()
            self:onTouchOK();
        end)
end

function AngelReset:onTouchCamera()
end

function AngelReset:onHide()
    self.super.onHide(self)
end

function AngelReset:removeUI()
    self.super.removeUI(self)
end

return AngelReset;