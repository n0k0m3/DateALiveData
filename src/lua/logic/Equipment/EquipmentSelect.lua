local EquipmentSelect = class("EquipmentSelect", BaseLayer)


function EquipmentSelect:ctor(data)
    self.super.ctor(self,data)
    self.allList,self.allCnt,self.combList,self.combCnt,self.sameList,self.samCnt = EquipmentDataMgr:initShowList(data.heroid,data.pos,data.isSkyladder);
    
    self.showList,self.equipCnt = self.allList,self.allCnt;
    self.curList, self.curCnt = self.allList,self.allCnt
    self.showId   = self.showList[1][1];
    self.currentId= self.showList[1][1];
    self.ishave = data.ishave;
    self.heroid = data.heroid;
    self.isToEquip = data.isEquip
    self.pos    = data.pos;
    self.closeBack = data.closeBack
    self.isSkyladder = data.isSkyladder
    self.chooseConditionData = EquipmentDataMgr:getChooseCondition()
    self.recommendCids = {}
    self.equipRecommendCfg = TabDataMgr:getData("EquipmentRecommend")[self.heroid]
    for i=1,3 do
        local recommend = self.equipRecommendCfg["recommend"..i]
        if recommend and #recommend > 0 then
            for j, cid in ipairs(recommend) do
                if not self.recommendCids[cid] then
                    self.recommendCids[cid] = true
                end
            end
        end
    end
    self:init("lua.uiconfig.Equip.EquipSelectLayer")
    self.callback = data.callback
    self.loadedIndex_ = 1
    self:showTopBar();
end

function EquipmentSelect:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	EquipmentSelect.ui = ui
    self:addLockLayer()
    self.loadedIndex_ = 1
	self.backBtn		= TFDirector:getChildByPath(ui,"Button_back");
	self.mainBtn		= TFDirector:getChildByPath(ui,"Button_main");
    self.changeBtn      = TFDirector:getChildByPath(ui,"Button_change");
    self.Button_all     = TFDirector:getChildByPath(ui,"Button_all");
    self.Button_comb    = TFDirector:getChildByPath(ui,"Button_comb");
    self.Button_same    = TFDirector:getChildByPath(ui,"Button_same");
    self.Button_open    = TFDirector:getChildByPath(ui,"Button_open");
    self.Image_buttons  = TFDirector:getChildByPath(ui,"Image_buttons");
    self.Label_title    = TFDirector:getChildByName(self.Button_open,"Label_title");
    self.Label_title:setTextById(490022);

    --TODO CLOSE
    --self.Button_choose = TFDirector:getChildByPath(ui,"Button_choose")
    self.Button_choose = TFDirector:getChildByPath(ui,"Button_choose"):hide()

    self.Panel_comb     = TFDirector:getChildByPath(ui,"Panel_comb");

	local ScrollView_tab = TFDirector:getChildByPath(ui, "ScrollView_EquipSelectLayer_1")
    self.ListView_left = UIListView:create(ScrollView_tab)

    self.GuYouTitle 	= TFDirector:getChildByPath(ui,"Panel_guyou_title");
    --self.ListView_left:pushBackCustomItem(GuYouTitle);

    self.GuYouItem		= TFDirector:getChildByPath(ui,"Panel_guyou_item");
    --self.ListView_left:pushBackCustomItem(self.GuYouItem);

    self.TeShuTitile	= TFDirector:getChildByPath(ui,"Panel_teshu_title");
    --self.ListView_left:pushBackCustomItem(TeShuTitile);

    self.TeShuItem		= TFDirector:getChildByPath(ui,"Panel_teshu_item");
    --self.ListView_left:pushBackCustomItem(self.TeShuItem);

    local ScrollView_Right  = TFDirector:getChildByPath(ui,"ScrollView_right");
    self.ListView_right     = UIListView:create(ScrollView_Right);
    self.ListView_right:setItemsMargin(15)
    self.rightItem          = TFDirector:getChildByPath(ui,"Panel_item");

    --装备信息界面
    self.leftPanel          = TFDirector:getChildByPath(ui,"Panel_left");
    self.Panel_bottom          = TFDirector:getChildByPath(ui,"Panel_bottom")
    
    self.Image_equip_back   = TFDirector:getChildByPath(ui,"Image_equip_back");
    self.Label_name         = TFDirector:getChildByPath(ui,"Label_name");
    self.Image_equip        = TFDirector:getChildByPath(self.leftPanel,"Image_Equip");
    self.Image_type         = TFDirector:getChildByPath(self.leftPanel,"Image_type");
    self.Label_cost         = TFDirector:getChildByPath(self.Panel_bottom,"Label_cost");
    self.Label_cost_max         = TFDirector:getChildByPath(self.Panel_bottom,"Label_cost_max")
    self.Label_cost_maxNew         = TFDirector:getChildByPath(self.Panel_bottom,"Label_cost_maxNew")

    self.equip_cost         = TFDirector:getChildByPath(self.leftPanel,"equip_cost");
    self.Image_star1        = TFDirector:getChildByPath(self.leftPanel,"Image_star1");
    self.Image_star2        = TFDirector:getChildByPath(self.leftPanel,"Image_star2");
    self.Image_star3        = TFDirector:getChildByPath(self.leftPanel,"Image_star3");
    self.Image_star4        = TFDirector:getChildByPath(self.leftPanel,"Image_star4");
    self.Image_star5        = TFDirector:getChildByPath(self.leftPanel,"Image_star5");
    self.Label_level        = TFDirector:getChildByPath(self.leftPanel,"Label_level")
    self.Image_stage1 = TFDirector:getChildByPath(self.leftPanel,"Image_stage1")
    self.Image_stage2 = TFDirector:getChildByPath(self.leftPanel,"Image_stage2")
    self.Image_stage3 = TFDirector:getChildByPath(self.leftPanel,"Image_stage3")

    self.Label_lv_tips      = TFDirector:getChildByPath(self.leftPanel,"Label_lv_tips");
    self.Label_exp          = TFDirector:getChildByPath(self.leftPanel,"Label_exp");
    self.Label_level        = TFDirector:getChildByPath(self.leftPanel,"Label_level")
    self.LoadingBar_exp     = TFDirector:getChildByPath(self.leftPanel,"LoadingBar_exp");

    
    self.old_lv        = TFDirector:getChildByPath(ui,"old_lv");
    self.cur_lv        = TFDirector:getChildByPath(ui,"cur_lv");
    self.old_atk       = TFDirector:getChildByPath(ui,"old_atk");
    self.old_def       = TFDirector:getChildByPath(ui,"old_def");
    self.old_hp        = TFDirector:getChildByPath(ui,"old_hp");
    self.cur_atk       = TFDirector:getChildByPath(ui,"cur_atk");
    self.cur_def       = TFDirector:getChildByPath(ui,"cur_def");
    self.cur_hp        = TFDirector:getChildByPath(ui,"cur_hp");

    self.hp_arrow        = TFDirector:getChildByPath(ui,"hp_arrow");
    self.atk_arrow       = TFDirector:getChildByPath(ui,"atk_arrow");
    self.def_arrow       = TFDirector:getChildByPath(ui,"def_arrow");
    self.lv_arrow        = TFDirector:getChildByPath(ui,"lv_arrow");


    self.Label_change = TFDirector:getChildByPath(ui,"Label_change");

    self:updateOrgAttr();
    self:refreshShowData()
    self:updateEquipInfo();
    self:updateCombInfo();

    local Panel_right = TFDirector:getChildByPath(ui,"Panel_right")
    ViewAnimationHelper.doMoveFadeInAction(self.leftPanel, {direction = 2, distance = 30, time = 0.2, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(self.GuYouTitle, {direction = 2, distance = 30, time = 0.2, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(self.TeShuTitile, {direction = 2, distance = 30, time = 0.2, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(self.GuYouItem, {direction = 2, distance = 30, time = 0.2, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(self.Panel_bottom, {direction = 2, distance = 30, time = 0.2, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(Panel_right, {direction = 2, distance = 10, time = 0.1, ease = 1})
end

function EquipmentSelect:updateOrgAttr()
    if self.ishave then
       -- self.old_lv:setString(EquipmentDataMgr:getEquipLv(self.showId)); 
        print("#########2")
        self.old_atk:setString(EquipmentDataMgr:getEquipmentAttrById(self.showId, EC_Attr.ATK))
        self.old_def:setString(EquipmentDataMgr:getEquipmentAttrById(self.showId, EC_Attr.DEF))
        self.old_hp:setString(EquipmentDataMgr:getEquipmentAttrById(self.showId, EC_Attr.HP))
    else
        -- self.old_lv:setString(0); 
        self.old_atk:setString(0);
        self.old_def:setString(0);
        self.old_hp:setString(0); 
    end
    if self.isToEquip then
        -- self.old_lv:setString(EquipmentDataMgr:getEquipLv(self.showId)); 
        print("#########2")
        self.old_atk:setString(EquipmentDataMgr:getEquipmentAttrById(self.currentId, EC_Attr.ATK))
        self.old_def:setString(EquipmentDataMgr:getEquipmentAttrById(self.currentId, EC_Attr.DEF))
        self.old_hp:setString(EquipmentDataMgr:getEquipmentAttrById(self.currentId, EC_Attr.HP))
    end

end

function EquipmentSelect:loadEquipMent()
    local loadedIndex = self.loadedIndex_
    if loadedIndex <= 1 then
        self.ListView_right:removeAllItems()
        self.selectItem = nil
    end
    if loadedIndex > #self.showList then
        return 
    end
    local count  = self.equipCnt - ((loadedIndex - 1) * 4)

    local item = self.ListView_right:getItem(loadedIndex)
    if not item then
        item = self.rightItem:clone()
        self.ListView_right:pushBackCustomItem(item)
        item:Alpha(0)
    end
    local idx = 1
    for i=1,4 do
        local subItem = TFDirector:getChildByPath(item,"item"..i)
        if idx <= count then
            local id = self.showList[loadedIndex][i]
            subItem.id = id
            self:updateOneEquipment(id,subItem)
        else
            subItem:setVisible(false)
        end
        idx = idx + 1
    end

    local delayDuration = 0.06
    item:fadeIn(0.2)
    local action = Sequence:create({
            DelayTime:create(delayDuration),
            CallFunc:create(function()
                    self.loadedIndex_ = loadedIndex + 1
                    self:loadEquipMent()
            end)
    })
    item:runAction(action)
end

function EquipmentSelect:updateOneEquipment(id,item)
    local starLv = EquipmentDataMgr:getEquipStarLv(id);
    local quality = EquipmentDataMgr:getEquipQuality(id);

    local Image_level_bg = TFDirector:getChildByPath(item,"Image_level_bg")
    local Label_lv_title = TFDirector:getChildByPath(item,"Label_lv_title")
    local LvLabel = TFDirector:getChildByPath(item,"Label_lv");
    Image_level_bg:setTexture(EC_ItemLevelIcon[quality])
    Label_lv_title:setString("Lv.")
    LvLabel:setString(EquipmentDataMgr:getEquipLv(id));

    local stepLabel = TFDirector:getChildByPath(item,"label_level_step")
    stepLabel:setText(EquipmentDataMgr:getStepText(id))

    --星级
    for i=1,5 do
        if i > starLv then
            TFDirector:getChildByPath(item,"Image_star"..i):setVisible(false);
        end    
    end
    local Panel_star = TFDirector:getChildByPath(item,"Panel_star")
    local starLevel = EquipmentDataMgr:getEquipStarLevel(id)
    if starLevel >= 1 and starLevel < 2 then
        Panel_star:setScale(0.88)
    elseif starLevel >= 2 then
        Panel_star:setScale(0.8)
    else
        Panel_star:setScale(1.0)
    end
    local Image_stage1 = TFDirector:getChildByPath(Panel_star,"Image_stage1")
    local Image_stage2 = TFDirector:getChildByPath(Panel_star,"Image_stage2")
    local Image_stage3 = TFDirector:getChildByPath(Panel_star,"Image_stage3")
    Image_stage1:setVisible(starLevel >= 1 and starLevel <= 2)
    Image_stage2:setVisible(starLevel == 2)
    Image_stage3:setVisible(starLevel == 3)

    local Image_back    = TFDirector:getChildByPath(item,"Image_back");
    Image_back:setTexture(EC_ItemIcon[quality]);
    --Image_back:setSize(CCSizeMake(105,105));

    --是否使用中
    local isuse         = EquipmentDataMgr:isUesing(id);
    local useIcon       = TFDirector:getChildByPath(item,"Image_use");
    useIcon:setVisible(isuse);

    local iconpath      = EquipmentDataMgr:getEquipIcon(id);
    local icon          = TFDirector:getChildByPath(item,"Image_equip");
    icon:setTexture(iconpath);
    icon:Size(CCSizeMake(100,100));

    local selectImg     = TFDirector:getChildByPath(item,"Image_select");
    item.selectImg      = selectImg;
    selectImg:setVisible(false);

    if id == self.currentId then
        self.selectItem = item;
        selectImg:setVisible(true);
    end

    local typeIcon      = TFDirector:getChildByPath(item,"Image_type");
    local subType       = EquipmentDataMgr:getEquipSubType(id);
    typeIcon:setTexture(EC_EquipSubTypeIcon2[subType]);
    typeIcon:Size(CCSizeMake(24,24));

    local backImg       = TFDirector:getChildByPath(item,"Image_back");
    backImg:setTouchEnabled(true);
    backImg:onClick(function()
            self:onTouchOneEquip(item);
        end)

    --TODO CLOSE
    -- local Image_tuijian = TFDirector:getChildByPath(item,"Image_tuijian"):hide()
    -- local cid = EquipmentDataMgr:getEquipCid(id)
    -- if self.recommendCids[cid] then
    --     Image_tuijian:show()
    -- end
    local Image_tuijian = TFDirector:getChildByPath(item,"Image_tuijian"):hide()
end

function EquipmentSelect:onTouchOneEquip(item)
    -- if EquipmentDataMgr:isUesing(item.id) then
    --     toastMessage("装备使用中")
    --     return;
    -- end

    if self.selectItem then
        self.selectItem.selectImg:setVisible(false);
    end
    
    item.selectImg:setVisible(true);
    self.selectItem = item;
    self.currentId = item.id
    self:updateEquipInfo();
    self:updateCombInfo();
    self:updateOrgAttr()
end

function EquipmentSelect:updateCombInfo()
    local combInfo = {}
    if self.pos == 1 then
        local info = HeroDataMgr:checkCombByPos(self.heroid,1,2,self.currentId);
        table.insert(combInfo,info);
        local info = HeroDataMgr:checkCombByPos(self.heroid,1,3,self.currentId);
        table.insert(combInfo,info);
    elseif self.pos == 2 then
        local info = HeroDataMgr:checkCombByPos(self.heroid,1,1,self.currentId);
        table.insert(combInfo,info);
        local info = HeroDataMgr:checkCombByPos(self.heroid,1,3,self.currentId);
        table.insert(combInfo,info);
    else
        local info = HeroDataMgr:checkCombByPos(self.heroid,1,1,self.currentId);
        table.insert(combInfo,info);
        local info = HeroDataMgr:checkCombByPos(self.heroid,1,2,self.currentId);
        table.insert(combInfo,info);
    end

    local ishave = false
    for k,v in pairs(combInfo) do
        local panel = TFDirector:getChildByPath(self.Panel_comb,"skill"..k);
        panel:setVisible(v.isok);
        if v.isok then
            local skillInfo = TabDataMgr:getData("PassiveSkills",v.skillid);
            local descLabel = TFDirector:getChildByPath(panel,"Label_desc");
            descLabel:setTextById(skillInfo.des);
            local icon      = TFDirector:getChildByPath(panel,"Image_icon");
            local iconpath  = TabDataMgr:getData("EquipmentCombination",v.combid).icon2
            icon:setTexture(iconpath);
            ishave = true;
        end
    end

    self.Panel_comb:setVisible(ishave);
    if isHave then
        ViewAnimationHelper.doMoveFadeInAction(self.Panel_comb, {direction = 2, distance = 20, time = 0.2, ease = 1})
    end    
end

function EquipmentSelect:updateEquipInfo()
    local curPercent = 0;
    local level      = 0;
    local lv         = EquipmentDataMgr:getEquipLv(self.currentId);
    local maxLv      = EquipmentDataMgr:getEquipMaxLv(self.currentId);
    self.Label_lv_tips:setString(lv.."/"..maxLv);

    local exp       = EquipmentDataMgr:getEquipCurExp(self.currentId);
    local maxExp    = EquipmentDataMgr:getEquipCurNeedExp(self.currentId);
    
    self.Label_exp:setString(exp.."/"..maxExp);
    


    local percent       = EquipmentDataMgr:getEquipExpPercent(self.currentId);
    
    self.LoadingBar_exp:setPercent(percent)
   


    local subType       = EquipmentDataMgr:getEquipSubType(self.currentId);
    self.Image_type:setTexture(EC_EquipSubTypeIcon2[subType]);
    --self.Image_type:Size(CCSizeMake(40,40));

    local halfPaint     = EquipmentDataMgr:getEquipPaint(self.currentId);
    self.Image_equip:setTexture(halfPaint);
    --self.Image_equip:Size(CCSizeMake(142,200));
    self.Image_equip:setScale(0.4)
    -- self.Image_equip:Size(CCSizeMake(168,212));
    -- self.Image_equip:setPosition(ccp(150,305));

    local name = EquipmentDataMgr:getEquipName(self.currentId);
    self.Label_name:setString(name..EquipmentDataMgr:getStepText(self.currentId));

    self.Label_level:setString("Lv."..EquipmentDataMgr:getEquipLv(self.currentId))

    local starLv        = EquipmentDataMgr:getEquipStarLv(self.currentId);
    for i=1,5 do
        self["Image_star"..i]:setVisible(i <= starLv);
    end
    local starLevel = EquipmentDataMgr:getEquipStarLevel(self.currentId)
    self.Image_stage1:setVisible(starLevel >= 1 and starLevel < 3)
    self.Image_stage2:setVisible(starLevel == 2)
    self.Image_stage3:setVisible(starLevel == 3)

    local quality       = EquipmentDataMgr:getEquipQuality(self.currentId);
    self.Image_equip_back:setTexture(EC_EquipBoard[quality]);

    local equipCost     = EquipmentDataMgr:getEquipCost(self.currentId);
    self.equip_cost:setString(equipCost);

    local heroCost      = HeroDataMgr:getCost(self.heroid) + HeroDataMgr:getNewEquipCost(self.heroid)
    local herCostMax    = HeroDataMgr:getCostMax(self.heroid);
    local curECost      = EquipmentDataMgr:getEquipCost(self.showId);
    local addCost       = equipCost;

    if self.ishave then
        heroCost = heroCost - curECost;
    end

    self.Label_cost:setString((heroCost + addCost))
    self.Label_cost_maxNew:setString("/"..herCostMax)
    if (heroCost + addCost) > herCostMax then
        self.Label_cost:setColor(ccc3(253,56,112))
    else
        self.Label_cost:setColor(ccc3(255,255,255))
    end

    self.ListView_left:removeAllItems();
    local GuYouDescLabel = TFDirector:getChildByPath(self.GuYouItem,"Label_title");
    local inherentDesc = EquipmentDataMgr:getEquipInherentAttrDesc(self.currentId);
    GuYouDescLabel:setTextById(inherentDesc);

    if EquipmentDataMgr:getIsHaveSpecialAttr(self.currentId) then
        local specialAttrs = EquipmentDataMgr:getEquipSpecialAttrs(self.currentId);
        for k,v in ipairs(specialAttrs) do
            local TeShuItem = self.TeShuItem:clone();
            local desc = TFDirector:getChildByPath(TeShuItem,"Label_title");
            desc:setString(v.desc);
            self.ListView_left:pushBackCustomItem(TeShuItem);

            local Image_zhuangshi = TFDirector:getChildByPath(TeShuItem,"Image_zhuangshi");
            Image_zhuangshi:setTexture(EC_equip_Special_icon[v.level]);
        end
    end

    --属性
    -- local isuse = EquipmentDataMgr:isUesing(self.currentId);
   -- self.cur_lv:setString(math.floor(EquipmentDataMgr:getEquipLv(self.currentId))); 
    local curAtkValue = EquipmentDataMgr:getEquipmentAttrById(self.currentId, EC_Attr.ATK)
    local curDefValue = EquipmentDataMgr:getEquipmentAttrById(self.currentId, EC_Attr.DEF)
    local curHpValue = EquipmentDataMgr:getEquipmentAttrById(self.currentId, EC_Attr.HP)
    self.cur_atk:setString(curAtkValue)
    self.cur_def:setString(curDefValue)
    self.cur_hp:setString(curHpValue)

    local showAtkValue = EquipmentDataMgr:getEquipmentAttrById(self.showId, EC_Attr.ATK)
     if self.ishave and curAtkValue < showAtkValue then
         self.atk_arrow:setVisible(true);
         self.atk_arrow:setTexture("ui/Equipment/new_ui/new_11.png");
         self.cur_atk:setVisible(true)
         self.cur_atk:setColor(ccc3(255,118,146));
     elseif self.ishave and curAtkValue > showAtkValue then
         self.atk_arrow:setVisible(true);
         self.atk_arrow:setTexture("ui/Equipment/new_ui/new_12.png");
         self.cur_atk:setVisible(true)
         self.cur_atk:setColor(ccc3(64,255,5));
     else
         self.cur_atk:setColor(ccc3(255,255,255));
         self.atk_arrow:setVisible(false);
         self.cur_atk:setVisible(false)
     end

     local showDefValue = EquipmentDataMgr:getEquipmentAttrById(self.showId, EC_Attr.DEF)
     if self.ishave and curDefValue < showDefValue then
         self.cur_def:setColor(ccc3(255,118,146));
         self.cur_def:setVisible(true)
         self.def_arrow:setVisible(true);
         self.def_arrow:setTexture("ui/Equipment/new_ui/new_11.png");
     elseif self.ishave and curDefValue > showDefValue then
         self.cur_def:setColor(ccc3(64,255,5));
         self.cur_def:setVisible(true)

         self.def_arrow:setVisible(true);
         self.def_arrow:setTexture("ui/Equipment/new_ui/new_12.png");
     else
         self.cur_def:setColor(ccc3(255,255,255));
         self.def_arrow:setVisible(false);
         self.cur_def:setVisible(false)
     end

     local showHpValue = EquipmentDataMgr:getEquipmentAttrById(self.showId, EC_Attr.HP)
     if self.ishave and curHpValue < showHpValue then
         self.cur_hp:setColor(ccc3(255,118,146));
         self.cur_hp:setVisible(true)
         self.hp_arrow:setVisible(true);
         self.hp_arrow:setTexture("ui/Equipment/new_ui/new_11.png");
     elseif self.ishave and curHpValue > showHpValue then
        self.cur_hp:setColor(ccc3(64,255,5));
        self.cur_hp:setVisible(true)
         self.hp_arrow:setVisible(true);
         self.hp_arrow:setTexture("ui/Equipment/new_ui/new_12.png");
     else
         self.cur_hp:setColor(ccc3(255,255,255));
         self.hp_arrow:setVisible(false)
         self.cur_hp:setVisible(false)
     end

     if self.ishave and EquipmentDataMgr:getEquipLv(self.currentId) < EquipmentDataMgr:getEquipLv(self.showId) then
    --     self.cur_lv:setColor(ccc3(235,57,110));
    --     self.lv_arrow:setVisible(true);
    --     self.lv_arrow:setTexture("ui/449.png");
     elseif self.ishave and EquipmentDataMgr:getEquipLv(self.currentId) > EquipmentDataMgr:getEquipLv(self.showId) then
    --     self.cur_lv:setColor(ccc3(64,171,5));
    --     self.lv_arrow:setVisible(true);
    --     self.lv_arrow:setTexture("ui/450.png");
     else
    --     self.cur_lv:setColor(ccc3(0,0,0));
    --     self.lv_arrow:setVisible(false)
    end


    if not self.ishave then
        self.Label_change:setTextById(490018);
    elseif self.currentId == self.showId then
        self.Label_change:setTextById(490019);
    else
        if EquipmentDataMgr:isUesing(self.currentId) and EquipmentDataMgr:getHeroSid(self.currentId) ~= self.heroid then
            self.Label_change:setTextById(490021)
        else
            self.Label_change:setTextById(490020)
        end
    end

end

function EquipmentSelect:onTouchButtonOpen()
    if self.isOpen then
        self.isOpen = false
        self.Image_buttons:runAction(CCMoveTo:create(0.1,ccp(60,345)))
    else
        self.isOpen = true
        self.Image_buttons:runAction(CCMoveTo:create(0.1,ccp(60,115)))
    end
end

function EquipmentSelect:onEquipmentChooseCondition(data)
    self.chooseConditionData = data
    EquipmentDataMgr:setChooseCondition(data)
    self:refreshShowData()
end

function EquipmentSelect:refreshShowData()
    local newList = {}
    local newCount = {}
    for i, v in ipairs(self.curList) do
        for j, id in ipairs(v) do
            if #EquipmentDataMgr:getEquipSuitInfo(id) > 0 then
                local cid = EquipmentDataMgr:getEquipCid(id)
                if #self.chooseConditionData.cids < 1 or table.indexOf(self.chooseConditionData.cids, cid) ~= -1 then
                    table.insert(newList, id)
                end
            else
                if self.chooseConditionData.isSingle then
                    table.insert(newList, id)
                end
            end
        end
    end

    --TODO CLOSE
    -- local recommendId = {}
    -- for i = #newList, 1,-1 do
    --     local id = newList[i]
    --     local cid = EquipmentDataMgr:getEquipCid(id)
    --     if self.recommendCids[cid] then
    --         table.remove(newList,i)
    --         table.insert(recommendId,id)
    --     end
    -- end
    -- for i, id in ipairs(recommendId) do
    --     table.insert(newList,1,id)
    -- end

    local function Grouping(list)
        local showList = {}
        local num = 0
        local idx = 0
        for i,v in ipairs(list) do
            num = num + 1
            if num % 4 == 1 then
                idx = idx + 1
            end

            showList[idx] = showList[idx] or {}
            table.insert(showList[idx],v)
        end
        return showList,num
    end
    self.showList,self.equipCnt = Grouping(newList)
    self.loadedIndex_ = 1
    self:loadEquipMent()
end

function EquipmentSelect:registerEvents()
    EventMgr:addEventListener(self,EV_EQUIPMENT_OPERATION,handler(self.onEquipmentOperation, self));
    EventMgr:addEventListener(self,EV_SKYLADDER_EQUIP,handler(self.onEquipmentOperation, self));
    EventMgr:addEventListener(self,EQUIPMENT_SELECT_CHOOSE_CONDITION,handler(self.onEquipmentChooseCondition, self))

	self.backBtn:onClick(function ()
            AlertManager:close();
    end)

    self.mainBtn:onClick(function()
    		AlertManager:changeScene(SceneType.MainScene);
    	end)

    self.Button_open:onClick(function()
            self:onTouchButtonOpen()
        end)
    --TODO CLOSE
    -- self.Button_choose:onClick(function()
    --     Utils:openView("Equipment.EquipSelectChooseCondition", self.chooseConditionData)
    -- end)

    self.Button_all:onClick(function()
            self.showList,self.equipCnt = self.allList,self.allCnt;
            self.curList, self.curCnt = self.allList,self.allCnt
            self:refreshShowData()
            self.Button_all:setTextureNormal("ui/Equipment/new_ui/new_07.png");
            self.Button_comb:setTextureNormal("ui/Equipment/new_ui/new_07.png");
            self.Button_same:setTextureNormal("ui/Equipment/new_ui/new_07.png");
            self.Button_all:getChildByName("Label_all"):setFontColor(ccc3(252,225,64));
            self.Button_comb:getChildByName("Label_comb"):setFontColor(ccc3(255,255,255));
            self.Button_same:getChildByName("Label_same"):setFontColor(ccc3(255,255,255));
            self.Label_title:setTextById(490022);
            self:onTouchButtonOpen()
        end)

    self.Button_comb:onClick(function()
            self.showList,self.equipCnt = self.combList,self.combCnt;
            self.curList, self.curCnt = self.combList,self.combCnt
            self.selectItem = nil;
            self:refreshShowData()
            self.Button_all:setTextureNormal("ui/Equipment/new_ui/new_07.png");
            self.Button_comb:setTextureNormal("ui/Equipment/new_ui/new_07.png");
            self.Button_same:setTextureNormal("ui/Equipment/new_ui/new_07.png");
            self.Button_all:getChildByName("Label_all"):setFontColor(ccc3(255,255,255));
            self.Button_comb:getChildByName("Label_comb"):setFontColor(ccc3(252,225,64));
            self.Button_same:getChildByName("Label_same"):setFontColor(ccc3(255,255,255));
            self.Label_title:setTextById(490023);
            self:onTouchButtonOpen()
        end)

    self.Button_same:onClick(function()
            self.showList,self.equipCnt = self.sameList,self.samCnt;
            self.curList, self.curCnt = self.sameList,self.samCnt
            self.selectItem = nil;
            self:refreshShowData()
            self.Button_all:setTextureNormal("ui/Equipment/new_ui/new_07.png");
            self.Button_comb:setTextureNormal("ui/Equipment/new_ui/new_07.png");
            self.Button_same:setTextureNormal("ui/Equipment/new_ui/new_07.png");
            self.Button_all:getChildByName("Label_all"):setFontColor(ccc3(255,255,255));
            self.Button_comb:getChildByName("Label_comb"):setFontColor(ccc3(255,255,255));
            self.Button_same:getChildByName("Label_same"):setFontColor(ccc3(252,225,64));
            self.Label_title:setTextById(490024);
            self:onTouchButtonOpen()
        end)

    self.Button_same:setVisible(HeroDataMgr:getIsHaveEquip(self.heroid,self.pos));

    self.changeBtn:onClick(function()
            if self.ishave and self.currentId == self.showId then
                if not self.isSkyladder then
                    EquipmentDataMgr:takeOffEquipment(self.heroid,self.currentId,self.pos);
                else
                    SkyLadderDataMgr:takeOffSkyLadderEquipment(self.heroid,self.currentId,self.pos);
                end
            else
                local useEquip = function(show)
                    local heroCost      = HeroDataMgr:getCost(self.heroid) + HeroDataMgr:getNewEquipCost(self.heroid)
                    local herCostMax    = HeroDataMgr:getCostMax(self.heroid);
                    local curECost      = EquipmentDataMgr:getEquipCost(self.currentId);
                    if self.ishave then
                        heroCost        = heroCost - EquipmentDataMgr:getEquipCost(self.showId);
                    end

                    if heroCost + curECost > herCostMax then
                        Utils:showTips(490001);
                        return
                    end

                    if not self.isSkyladder then
                        EquipmentDataMgr:useEquipment(self.heroid,self.pos,self.currentId);
                    else
                        SkyLadderDataMgr:useSkyLadderEquipment(self.heroid,self.pos,self.currentId);
                    end
                    if not show then
                        AlertManager:close(self);
                        if self.callback then
                            self.callback()
                        end
                    end

                end
                
                if EquipmentDataMgr:isUesing(self.currentId) then
                    local name = HeroDataMgr:getNameById(tonumber(EquipmentDataMgr:getHeroSid(self.currentId)))
                    Utils:openView("common.ChangeEquipConfirmView", { heroName = name, callback = useEquip})
                else
                    useEquip(1)
                end
            end
            GameGuide:checkGuideEnd(self.guideFuncId)
        end)
end

function EquipmentSelect:onHide()
	self.super.onHide(self)
end

function EquipmentSelect:removeUI()
	self.super.removeUI(self)
end

function EquipmentSelect:onEquipmentOperation(equipid,upOrdown)
    if self.closeBack then
        self.closeBack()
    end
    AlertManager:close(self);
    -- self.selectItem = nil;
    -- self.ishave = upOrdown;
    -- self.showList,self.equipCnt = EquipmentDataMgr:initShowList(self.heroid,self.pos);
    -- self.showId   = self.showList[1][1];
    -- self.currentId= self.showList[1][1];
    --self:updateOrgAttr();
    -- self:updateAllEquipment();
    -- self:updateEquipInfo();
end

function EquipmentSelect:onShow()
    self.super.onShow(self)
    
    self:removeLockLayer()
    self:timeOut(function()
        GameGuide:checkGuide(self);
    end,0)
end


---------------------------guide------------------------------

--引导装备质点
function EquipmentSelect:excuteGuideFunc15001(guideFuncId)
    local targetNode = self.changeBtn
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

return EquipmentSelect;