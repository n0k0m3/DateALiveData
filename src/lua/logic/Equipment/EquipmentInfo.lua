local EquipmentInfo = class("EquipmentInfo", BaseLayer)


function EquipmentInfo:ctor(data)
    self.super.ctor(self,data)
    self.paramData_ = data
    self.equipmentId = data.equipmentId;
    self.fromBag = data.fromBag;
    self.isfriend = data.isfriend
    self.backTag = data.backTag
    self.equips = data.equips;
    self.fromFairy = data.fromFairy
    self.isFromPokedex = data.isFromPokedex;
    self.isSkyladder = data.isSkyladder
    self.notAction = data.notAction
    self.ishave = true;
    if EquipmentDataMgr:isCid(self.equipmentId) then
        self.ishave = false;
    end

    if EquipmentDataMgr:isUesing(self.equipmentId) then
        self.heroid = EquipmentDataMgr:getHeroSid(self.equipmentId)--data.heroid;
        self.heroid = HeroDataMgr:getHeroCidBySid(self.heroid);
        self.pos = EquipmentDataMgr:getPosition(self.equipmentId);
    end
    self.selectLine = nil;
    self.part1 = nil;
    self.part2 = nil;
    self.equipPageIdx = 1
    self:init("lua.uiconfig.Equip.EquipInfoLayer")
    --EventMgr:addEventListener(self,EQUIPMENT_REPLACE_SPECIAL_ATTR,handler(self.EQUIPMENT_REPLACE_SPECIAL_ATTR, self));
    self:showTopBar();
end

function EquipmentInfo:getClosingStateParams()
    return {self.paramData_}
end

function EquipmentInfo:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui
    EquipmentInfo.ui = ui

    self.backBtn        = TFDirector:getChildByPath(ui,"Button_back");
    self.mainBtn        = TFDirector:getChildByPath(ui,"Button_main");
    self.changeBtn      = TFDirector:getChildByPath(ui,"Button_change");
    self.Image_changeRedTip = TFDirector:getChildByPath(self.changeBtn,"Image_redTip"):hide();
    self.strengthenBtn  = TFDirector:getChildByPath(ui,"Button_qianghua");
    self.strengthenRedTip = TFDirector:getChildByPath(self.strengthenBtn,"Image_redTip"):hide();
    self.reformBtn  = TFDirector:getChildByPath(ui,"Button_reform");
    self.convertBtn     = TFDirector:getChildByPath(ui,"Button_xilian");
    self.stepUpBtn = TFDirector:getChildByPath(ui,"Button_stepUp")
    self.Button_camera  = TFDirector:getChildByPath(ui,"Button_camera");
    self.Button_equip   = TFDirector:getChildByPath(ui,"Button_equip");
    self.Button_zuhe    = TFDirector:getChildByPath(ui,"Button_zuhe");
    self.Button_share   = TFDirector:getChildByPath(ui,"Button_share");
    self.Button_eval   = TFDirector:getChildByPath(ui,"Button_eval");
    self.Button_recycle   = TFDirector:getChildByPath(ui,"Button_recycle");
    self.Button_star_up = TFDirector:getChildByPath(ui,"Button_star_up")
    self.Image_StarUpredTip = TFDirector:getChildByPath(self.Button_star_up,"Image_redTip"):hide()
    self.Panel_buttons = TFDirector:getChildByPath(ui,"Panel_buttons")
    --TODO CLOSE
    --self.Button_suit = TFDirector:getChildByPath(ui,"Button_suit")
    self.Button_suit = TFDirector:getChildByPath(ui,"Button_suit"):hide()

    self.Button_recycle:setVisible(EquipmentDataMgr:getEquipSubType(self.equipmentId) ~= 100)
    local topLayer = TFDirector:currentScene():getTopLayer()
    local topname = topLayer and topLayer.__cname or ""
    if topname == "BagView" then
        self.Button_recycle:setVisible(true)
    else
        self.Button_recycle:setVisible(false)
    end

    --暂时屏蔽质点回收
    self.Button_recycle:hide()

    self.equipsPageView = TFDirector:getChildByPath(ui,"PageView_Equip");
    self.Panel_di       = TFDirector:getChildByPath(ui,"Panel_di");
    self.Panel_equip    = TFDirector:getChildByPath(ui,"Panel_equip"):show();
    self.Label_name     = TFDirector:getChildByPath(ui,"Label_name");
    self.Image_Equip    = TFDirector:getChildByPath(ui,"Image_Equip");
    self.Label_lv       = TFDirector:getChildByPath(ui,"Label_lv");
    self.Label_cost     = TFDirector:getChildByPath(ui,"Label_cost");
    self.Label_attr_hp  = TFDirector:getChildByPath(ui,"Label_attr_hp");
    self.Label_attr_atk = TFDirector:getChildByPath(ui,"Label_attr_atk");
    self.Label_attr_def = TFDirector:getChildByPath(ui,"Label_attr_def");
    self.Label_guyou    = TFDirector:getChildByPath(ui,"Label_guyou");
    self.Label_exp      = TFDirector:getChildByPath(ui,"Label_exp");
    self.LoadingBar_exp = TFDirector:getChildByPath(ui,"LoadingBar_exp");
    self.Label_NoAttr   = TFDirector:getChildByPath(ui,"Label_NoAttr"):hide();

    self.Image_TypeIcon       = TFDirector:getChildByPath(ui,"Image_TypeIcon");
    self.Label_TypeName       = TFDirector:getChildByPath(ui,"Label_TypeName");
    self.Label_CostNum       = TFDirector:getChildByPath(ui,"Label_CostNum");

    for i=1,5 do
        self["Image_star"..i] = TFDirector:getChildByPath(ui,"Image_star"..i);
    end    
    self.Image_stage1 = TFDirector:getChildByPath(ui,"Image_stage1")
    self.Image_stage2 = TFDirector:getChildByPath(ui,"Image_stage2")
    self.Image_stage3 = TFDirector:getChildByPath(ui,"Image_stage3")

    self.Button_locked = TFDirector:getChildByPath(ui, "Button_locked")
    self.Label_lock = TFDirector:getChildByPath(ui, "Label_lock")

    --self.specialListView = UIListView:create(self.ScrollView_tab)
    --self.specialListView:setTouchEnabled(false);
    self.scrollBgImg = TFDirector:getChildByPath(self.Panel_equip, "Image_info_bg")
    local ScrollView_all = TFDirector:getChildByPath(ui, "ScrollView_allElements");
    self.allElementsListView = UIListView:create(ScrollView_all)
    -- local Panel_guyou_title = TFDirector:getChildByPath(ui, "Panel_guyou_title")
    -- local Panel_teshu_title = TFDirector:getChildByPath(ui, "Panel_teshu_title")
    -- local Panel_teshu_Items = TFDirector:getChildByPath(ui, "Panel_teshu_Items")

    -- Panel_guyou_title:removeFromParent()
    -- Panel_teshu_title:removeFromParent()
    -- Panel_teshu_Items:removeFromParent()
    -- --self.specialListView:removeFromParent()
    -- self.allElementsListView:pushBackCustomItem(Panel_guyou_title)
    -- self.allElementsListView:pushBackCustomItem(Panel_teshu_title)
    -- self.allElementsListView:pushBackCustomItem(Panel_teshu_Items)
    --self.allElementsListView:pushBackCustomItem(self.specialListView)

    self.Panel_combination  = TFDirector:getChildByPath(ui,"Panel_combination"):hide();
    local ScrollView_comb   = TFDirector:getChildByPath(self.Panel_combination,"ScrollView_comb"); 
    self.combListView       = UIListView:create(ScrollView_comb);
    self.suitItem           = TFDirector:getChildByPath(ui,"Panel_taozhuang_title");
    self.Panel_zuhe_title   = TFDirector:getChildByPath(ui,"Panel_zuhe_title");
    self.Panel_skill_item   = TFDirector:getChildByPath(ui,"Panel_skill_item");
    self.Panel_EquipPage    = TFDirector:getChildByPath(ui,"Panel_EquipPage");
    self.Panel_EquipPage:setName("Panel_EquipPage")
    self.ScrollView_fazhen  = TFDirector:getChildByPath(ui,"ScrollView_fazhen"):hide();   

    local equipStepAttrPanel = TFDirector:getChildByPath(self.Panel_equip,"panel_step_attr")
    local equipStepScrollView = TFDirector:getChildByPath(equipStepAttrPanel,"scrollView_equipStep_attr")
    self.equipStepListView = UIListView:create(equipStepScrollView)

    local itemModel = TFDirector:getChildByPath(equipStepAttrPanel,"label_step_attr")
    itemModel:hide()
    self.equipStepListView:setItemModel(itemModel)

    for i=1,10 do
        self["Image_board"..i] = TFDirector:getChildByPath(self.ScrollView_fazhen,"Image_board"..i);
    end

    self.Panel_suit_show  = TFDirector:getChildByPath(ui,"Panel_suit_show"):hide()
    local ScrollView_suit   = TFDirector:getChildByPath(self.Panel_suit_show,"ScrollView_suit")
    self.ListView_suit       = UIListView:create(ScrollView_suit)
    self.ListView_suit:setItemsMargin(5)

    self.Panel_suit_item  = TFDirector:getChildByPath(ui,"Panel_suit_item")
    self.Panel_equip_item  = TFDirector:getChildByPath(ui,"Panel_equip_item")


    self.TeShuItem = TFDirector:getChildByPath(ui,"Panel_teshu_item");
    self:updatePageView();
    --self:updateUI();
    --self:updateCombinationInfo()


    if self.fromBag then
        self.changeBtn:setPositionX(self.changeBtn:getPositionX() + 142)
        self.strengthenBtn:setPositionX(self.strengthenBtn:getPositionX() + 142)
        self.convertBtn:setPositionX(self.convertBtn:getPositionX() + 142)
    end

    self.curPanel = self.Panel_equip;
    if self.fromBag and self.equips then
        self.Button_locked:show()
    elseif not self.fromFairy then
        self.Button_locked:hide()
    end

    if self.fromFairy then
        self.Button_locked:show()
    end

    local tmpImg = TFDirector:getChildByName(self.Button_equip,"Image_buttonEquip")
    tmpImg:setTexture("ui/Equipment/new_ui/new_48.png")
    local tmpImg2 = TFDirector:getChildByName(self.Button_zuhe,"Image_buttonZuhe")
    tmpImg2:setTexture("ui/Equipment/new_ui/new_47.png")

    

    ViewAnimationHelper.doMoveFadeInAction(self.Button_locked, {direction = 2, distance = 30, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(self.Button_camera, {direction = 2, distance = 30, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(self.Button_eval, {direction = 2, distance = 30, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(self.Button_recycle, {direction = 2, distance = 30, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(self.Image_Equip, {direction = 2, distance = 30, ease = 1})



end

function EquipmentInfo:EV_EQUIPMENT_OPERATION(data,upOrDown,removes)

    if not upOrDown then
        AlertManager:closeLayer(self);
        return;
    end

    if removes and #removes > 0 and self.fromBag and self.equips then
        for k,v in pairs(removes) do
            local index = table.indexOf(self.equips,v) - 1;
            table.removeItem(self.equips,v);
            self.equipsPageView:removePageAtIndex(index);
        end
    else
        self.equipmentId = data;
    end

    if EquipmentDataMgr:isUesing(self.equipmentId) then
        self.heroid = EquipmentDataMgr:getHeroSid(self.equipmentId)--data.heroid;
        self.heroid = HeroDataMgr:getHeroCidBySid(self.heroid);
        self.pos = EquipmentDataMgr:getPosition(self.equipmentId);
    end

    self:updatePageView();
end

function EquipmentInfo:onEquipRecycle(data)
    local delay = CCDelayTime:create(0.3);
    local callfunc = CCCallFunc:create(function()
           self:updateUI();
        end
        )
    self:runAction(CCSequence:create({delay,callfunc})); 
end

function EquipmentInfo:equipLockChangeResult()
    if EquipmentDataMgr:getEquipIsLock(self.equipmentId) then
        self.Button_locked:setTextureNormal("ui/fairy/new_ui/new_51.png");
    else
        self.Button_locked:setTextureNormal("ui/fairy/new_ui/new_46.png");
    end
end

function EquipmentInfo:updatePageView()
    local equipmentId   = self.equipmentId;
    local paintPath = EquipmentDataMgr:getEquipPaint(equipmentId);
    self.Image_Equip:setTexture(paintPath);
    me.TextureCache:removeUnusedTextures()

    local pos = EquipmentDataMgr:getEquipPaintPosition(equipmentId);
    local scale = EquipmentDataMgr:getEquipPaintScale(equipmentId);
    self.Image_Equip:setScale(scale);
    self.Image_Equip:setPosition(pos);
    if self.fromBag and self.equips then
        local idx = table.indexOf(self.equips,self.equipmentId)
        self.equipPageIdx = idx > 0 and idx or 1
        self.equipPos_ = pos
    end

    self:updateUI();
    self:updateCombinationInfo();
    self:updateSuitView()
end

function EquipmentInfo:updateUI()
    local equipmentId   = self.equipmentId;
    local maxLv = nil;
    maxLv = EquipmentDataMgr:getEquipMaxLv(equipmentId)
    
    local name      = EquipmentDataMgr:getEquipName(equipmentId); 
    self.Label_name:setString(name .. EquipmentDataMgr:getStepText(equipmentId));
    if self.isFromPokedex then
        self.Label_name:setString(name);
    end

    local lv        = EquipmentDataMgr:getEquipLv(equipmentId);
    --图鉴界面数值是最高的
    if self.isFromPokedex then
        lv = maxLv              
    end

    self.Label_lv:setString(lv .. "/" .. EquipmentDataMgr:getEquipMaxLv(equipmentId));

    if not self.ishave and not self.isFromPokedex then
        self.Label_lv:setString("1".."/"..EquipmentDataMgr:getEquipMaxLv(equipmentId));
    end

    -- local cost      = EquipmentDataMgr:getEquipCost(equipmentId);
    -- self.Label_cost:setString(cost);

    local subType   = EquipmentDataMgr:getEquipSubType(equipmentId);

    local topLayer = TFDirector:currentScene():getTopLayer()
    local topname = topLayer and topLayer.__cname or ""

    local hp        = EquipmentDataMgr:getEquipBaseHp(equipmentId,lv);
    self.Label_attr_hp:setString(math.floor(hp));
    
    local atk       = EquipmentDataMgr:getEquipBaseAtk(equipmentId,lv);
    self.Label_attr_atk:setString(math.floor(atk));
    
    local def       = EquipmentDataMgr:getEquipBaseDef(equipmentId,lv);
    self.Label_attr_def:setString(math.floor(def));

    

    local starLv    = EquipmentDataMgr:getEquipStarLv(equipmentId);
    for i=1,5 do
        if i > starLv then
            self["Image_star"..i]:setVisible(false);
        else
            self["Image_star"..i]:setVisible(true);
        end
    end
    local starLevel = EquipmentDataMgr:getEquipStarLevel(self.equipmentId)
    self.Image_stage1:setVisible(starLevel >= 1 and starLevel < 3)
    self.Image_stage2:setVisible(starLevel == 2)
    self.Image_stage3:setVisible(starLevel == 3)


    local cost      = EquipmentDataMgr:getEquipCost(self.equipmentId);
    local subType   = EquipmentDataMgr:getEquipSubType(self.equipmentId);
    local board = TFDirector:getChildByPath(self.ui, "Image_board" .. subType)
    local name = TFDirector:getChildByPath(board, "Label_type_name")
    self.Image_TypeIcon:setTexture(EC_EquipSubTypeIcon[subType]);
    if name then
        self.Label_TypeName:setText(name:getText())
    else
        self.Label_TypeName:setString("")
    end

    if subType == EC_EquipSubType.Daat or subType == EC_EquipSubType.Wanneng then
        self.Label_TypeName:setTextById(100000037)
    end

    self.Label_CostNum:setString(cost)
    

    local inherentDesc = EquipmentDataMgr:getEquipInherentAttrDesc(equipmentId);
    self.Label_guyou:setTextById(inherentDesc);
    self.allElementsListView:removeAllItems()

    local Panel_guyou_title = TFDirector:getChildByPath(self.ui, "Panel_guyou_title")
    local Panel_teshu_title = TFDirector:getChildByPath(self.ui, "Panel_teshu_title")
    local Panel_teshu_Items = TFDirector:getChildByPath(self.ui, "Panel_teshu_Items")

    --self.specialListView:removeFromParent()
    Panel_guyou_title:setVisible(false)
    local clone1 = Panel_guyou_title:clone()
    clone1:setVisible(true)

    Panel_teshu_title:setVisible(false)
    local clone2 = Panel_teshu_title:clone()
    clone2:setVisible(true)
    
    if EquipmentDataMgr:getIsHaveSpecialAttr(equipmentId) then
        self.Label_NoAttr:hide()
    else
        self.Label_NoAttr:show()
    end
    Panel_teshu_Items:setVisible(false)
    local clone3 = Panel_teshu_Items:clone()
    clone3:setVisible(true)


    self.allElementsListView:pushBackCustomItem(clone1)
    self.allElementsListView:pushBackCustomItem(clone2)
    self.allElementsListView:pushBackCustomItem(clone3)


    if EquipmentDataMgr:getIsHaveSpecialAttr(equipmentId) then
        local specialAttrs = EquipmentDataMgr:getEquipSpecialAttrs(equipmentId);
        for k,v in ipairs(specialAttrs) do
            local TeShuItem = self.TeShuItem:clone();
            local desc = TFDirector:getChildByPath(TeShuItem,"Label_title");
            desc:setString(v.desc);
            local Image_zhuangshi = TFDirector:getChildByPath(TeShuItem,"Image_zhuangshi");
            Image_zhuangshi:setTexture(EC_equip_Special_icon[v.level]);
           -- if not self.allElementsListView.pushed then

                self.allElementsListView:pushBackCustomItem(TeShuItem)
           -- end
        end
        --self.allElementsListView.pushed = true
    else

        --self.specialListView:removeAllItems();

    end

    if EquipmentDataMgr:getIsHaveSpecialAttr(equipmentId) then
        
    else
        local clone4 = clone3:clone()
        clone4:setVisible(false)
        self.allElementsListView:pushBackCustomItem(clone4)
    end


     self.Label_exp:setVisible(self.ishave);
     self.LoadingBar_exp:setVisible(self.ishave);
    if self.ishave then
        local exp       = EquipmentDataMgr:getEquipCurExp(equipmentId);
        local maxExp    = EquipmentDataMgr:getEquipCurNeedExp(equipmentId);
        self.Label_exp:setString(exp.."/"..maxExp);

        local percent       = EquipmentDataMgr:getEquipExpPercent(equipmentId);
        self.LoadingBar_exp:setPercent(percent);

        if EquipmentDataMgr:getEquipLv(equipmentId) >= EquipmentDataMgr:getEquipMaxLv(equipmentId) then
            self.Label_exp:setString("Max");
        end
    end


    --self.strengthenBtn:setVisible(self.ishave and EquipmentDataMgr:getEquipSubType(self.equipmentId) ~= EC_EquipSubType.Daat);
    --self.reformBtn:setVisible(self.ishave and EquipmentDataMgr:getEquipSubType(self.equipmentId) ~= EC_EquipSubType.Daat);
    --self.convertBtn:setVisible(self.ishave and EquipmentDataMgr:getEquipSubType(self.equipmentId) ~= EC_EquipSubType.Daat);
    --self.stepUpBtn:setVisible(self.ishave and EquipmentDataMgr:getEquipSubType(self.equipmentId) ~= EC_EquipSubType.Daat);

    local subType = EquipmentDataMgr:getEquipSubType(self.equipmentId)
    self.strengthenBtn:setVisible(self.ishave and subType ~= EC_EquipSubType.Daat and subType ~= EC_EquipSubType.Wanneng);
    self.reformBtn:setVisible(self.ishave and subType ~= EC_EquipSubType.Daat and subType ~= EC_EquipSubType.Wanneng);
    self.convertBtn:setVisible(self.ishave and subType ~= EC_EquipSubType.Daat and subType ~= EC_EquipSubType.Wanneng);
    self.stepUpBtn:setVisible(self.ishave and subType ~= EC_EquipSubType.Daat and subType ~= EC_EquipSubType.Wanneng);


    --self.Button_camera:setVisible(self.ishave)
    self.Button_star_up:setVisible(self.ishave and EquipmentDataMgr:getEquipStarGrow(self.equipmentId))
    self.Button_star_up:setPositionY(463)
    self.reformBtn:setPositionY(357)
    self.Button_recycle:setPositionY(259)
    
    if not self.Button_recycle:isVisible() then
        if not self.reformBtn:isVisible() then
            self.Button_star_up:setPositionY(259)
        else
            self.Button_star_up:setPositionY(357)
            self.reformBtn:setPositionY(259)
        end
    elseif not self.reformBtn:isVisible() then
        self.Button_star_up:setPositionY(357)
    end

    if self.fromFairy then
        local couldStrengthen = EquipmentDataMgr:equipCouldUp(equipmentId)
        self.strengthenRedTip:setVisible(couldStrengthen)

        local couldStrengthen = EquipmentDataMgr:equipCouldUpStar(equipmentId)
        self.Image_StarUpredTip:setVisible(couldStrengthen)

        local haveBetterEquip = EquipmentDataMgr:haveBetterEquip(equipmentId)
        self.Image_changeRedTip:setVisible(haveBetterEquip)
    end
    self:equipLockChangeResult()

    if self.notAction then
        self.Panel_buttons:hide()
        self.Panel_di:hide()
        self.Button_locked:hide()
    end

    self.equipStepListView:removeAllItems()
    local stepIndex = 1
    local equipCid = EquipmentDataMgr:getEquipCid( equipmentId )
    local advancedList = EquipmentDataMgr:getEquipAdvancedList( equipCid )
    for i,_addVanced in ipairs(advancedList) do
        local attrText = "  " .."+" ..i ..":"       
        local hp =EquipmentDataMgr:getEquipAdvancedHp( equipmentId, i)
        local hpcfg = HeroDataMgr:getAttributeConfig(EC_Attr.HP)       
        attrText = attrText ..TextDataMgr:getText(hpcfg.name) .."+" ..math.ceil(EquipmentDataMgr:getEquipBaseHp(equipmentId, 1)*hp) ..", "       
        local ap = EquipmentDataMgr:getEquipAdvancedAp( equipmentId, i)
        local atkcfg = HeroDataMgr:getAttributeConfig(EC_Attr.ATK)
        attrText = attrText ..TextDataMgr:getText(atkcfg.name) .."+" ..math.ceil(EquipmentDataMgr:getEquipBaseAtk(equipmentId, 1)*ap) ..", "
        local def = EquipmentDataMgr:getEquipAdvancedDef( equipmentId, i)
        local defcfg = HeroDataMgr:getAttributeConfig(EC_Attr.DEF)
        attrText = attrText ..TextDataMgr:getText(defcfg.name) .."+" ..math.ceil(EquipmentDataMgr:getEquipBaseDef(equipmentId, 1)*def)
        local item = self.equipStepListView:pushBackDefaultItem()
        item:setText(attrText)
        item:show()

        local equipStep = EquipmentDataMgr:getEquipStep( equipmentId )
        if self.isFromPokedex then
            equipStep = 0
        end       
        if equipStep >=  _addVanced.step then           
            item:setColor(ccc3(149,251,153))
        else
            item:setColor(ccc3(212,212,212))
        end

        if equipStep ==  _addVanced.step then
            stepIndex = i
        end
    end
    self.equipStepListView:jumpToItem(stepIndex)

    local equipStepAttrPanel = TFDirector:getChildByPath(self.Panel_equip,"panel_step_attr")
    equipStepAttrPanel:show()
    if #advancedList <= 0 then
        equipStepAttrPanel:hide()      
        self.allElementsListView:setContentSize(CCSize(350, 290))
        self.scrollBgImg:setContentSize(CCSize(482, 470))
    else       
        self.allElementsListView:setContentSize(CCSize(350, 205))
        self.scrollBgImg:setContentSize(CCSize(482, 375))
    end

    --屏蔽质点突破
    equipStepAttrPanel:hide()
    self.allElementsListView:setContentSize(CCSize(350, 290))
    self.scrollBgImg:setContentSize(CCSize(482, 470))
    self.stepUpBtn:hide()
end

function EquipmentInfo:updateCombinationInfo()
    self:resetTreeUi();
    local subType = EquipmentDataMgr:getEquipSubType(self.equipmentId);

    local typeTab = {}
    local combInfo = {}
    if EquipmentDataMgr:isUesing(self.equipmentId) then
        for i=1,3 do
            if HeroDataMgr:getIsHaveEquip(self.heroid,i) then
                local equipid = HeroDataMgr:getEquipIdByPos(self.heroid,i);
                local subType = EquipmentDataMgr:getEquipSubType(equipid);
                typeTab[i] = typeTab[i] or {};
                typeTab[i].equipid = equipid;
                typeTab[i].subType = subType;
            end
        end

        combInfo[1] = HeroDataMgr:checkCombByPos(self.heroid,1,2);
        combInfo[2] = HeroDataMgr:checkCombByPos(self.heroid,2,3);
        combInfo[3] = HeroDataMgr:checkCombByPos(self.heroid,1,3);
    end

    if table.count(typeTab) == 0 then
        typeTab[1] = {};
        typeTab[1].equipid = self.equipmentId;
        typeTab[1].subType = subType;
    end

    for k,v in pairs(typeTab) do
        if v.subType ~= EC_EquipSubType.Daat and v.subType ~= EC_EquipSubType.Wanneng then
            self["Image_board"..v.subType]:setTexture("ui/473.png");
            local Image_light   = TFDirector:getChildByPath(self["Image_board"..v.subType],"Image_light"):show();
            Image_light:setTexture("ui/474.png");

            local Image_icon    = TFDirector:getChildByPath(self["Image_board"..v.subType],"Image_icon");
            Image_icon:setTexture(EC_EquipSubTypeIcon[v.subType]);
            Image_icon:Size(CCSizeMake(100,100));

            local Image_title   = TFDirector:getChildByPath(self["Image_board"..v.subType],"Image_title");
            local Label_type_name=TFDirector:getChildByName(self["Image_board"..v.subType],"Label_type_name");

            Image_title:setTexture(EC_EquipSubTypeTitle[v.subType])
            Label_type_name:setColor(ccc3(252,242,175));

            if v.subType == subType then
                self["Image_board"..v.subType]:setTexture("ui/473.png");
                self.Image_select = TFDirector:getChildByPath(self["Image_board"..v.subType],"Image_select"):show();
                self:showInView(self["Image_board"..v.subType]);
                self.showSubType = v.subType
            end
        end
    end

    for k,v in pairs(combInfo) do
        if v.isok then
            TFDirector:getChildByPath(self.ScrollView_fazhen,"Image_link"..v.combid):show();
        end
    end

    local combSkill = EquipmentDataMgr:getEquipCombSkillInfo(self.equipmentId)
    for combId,info in pairs(combSkill) do
        local item = self.Panel_skill_item:clone();
        self:updateCombItem(item,info,combId,combInfo);
        self.combListView:pushBackCustomItem(item);
    end
    self.selectItem = nil
    self.selectImg = nil
end

function EquipmentInfo:updateSuitView()
    local suitInfos = EquipmentDataMgr:getEquipSuitInfos(self.equipmentId)
    self.ListView_suit:removeAllItems()
    for k,equips in pairs(suitInfos) do
        local item = self.Panel_suit_item:clone()
        self.ListView_suit:pushBackCustomItem(item)
        local Label_suit_name = TFDirector:getChildByPath(item,"Label_suit_name")
        local Label_suit_desc = TFDirector:getChildByPath(item,"Label_suit_desc")
        local ScrollView_equips = TFDirector:getChildByPath(item,"ScrollView_equips")
        local listViewEquips = UIListView:create(ScrollView_equips)
        listViewEquips:setItemsMargin(5)

        local suitCfg = TabDataMgr:getData("EquipmentSuit",tonumber(k))
        Label_suit_name:setTextById(suitCfg.suitNewPokedex)
        local skillInfo = TabDataMgr:getData("PassiveSkills",suitCfg.suitSkill)
        Label_suit_desc:setTextById(skillInfo.des)

        for i, equipCid in ipairs(equips) do
            local equipItem = self.Panel_equip_item:clone()
            equipItem:setScale(0.8)
            listViewEquips:pushBackCustomItem(equipItem)
            local starLv = EquipmentDataMgr:getEquipStarLv(equipCid)
            local quality = EquipmentDataMgr:getEquipQuality(equipCid)

            local Image_level_bg = TFDirector:getChildByPath(equipItem,"Image_level_bg")
            local Label_lv_title = TFDirector:getChildByPath(equipItem,"Label_lv_title")
            local LvLabel = TFDirector:getChildByPath(equipItem,"Label_lv")
            Image_level_bg:setTexture(EC_ItemLevelIcon[quality])
            Label_lv_title:setString("Lv.")
            LvLabel:setString(EquipmentDataMgr:getEquipLv(equipCid))

            --星级
            for i=1,5 do
                if i > starLv then
                    TFDirector:getChildByPath(equipItem,"Image_star"..i):setVisible(false)
                end    
            end

            local Image_back    = TFDirector:getChildByPath(equipItem,"Image_back");
            Image_back:setTexture(EC_ItemIcon[quality]);


            local iconpath      = EquipmentDataMgr:getEquipIcon(equipCid)
            local icon          = TFDirector:getChildByPath(equipItem,"Image_equip")
            icon:setTexture(iconpath)
            icon:Size(CCSizeMake(100,100))

            local typeIcon      = TFDirector:getChildByPath(equipItem,"Image_type")
            local subType       = EquipmentDataMgr:getEquipSubType(equipCid)
            typeIcon:setTexture(EC_EquipSubTypeIcon2[subType]);
            typeIcon:Size(CCSizeMake(24,24))

            local backImg       = TFDirector:getChildByPath(equipItem,"Image_back")
            backImg:setTouchEnabled(true)
            backImg:onClick(function()
                
            end)
        end
    end
end

function EquipmentInfo:showInView(item)
    local pos = item:getPosition();
    local size = item:getContentSize();
    local worldPoint = item:getParent():convertToWorldSpace(pos);

    local InnerContainer = self.ScrollView_fazhen:getInnerContainer();
    local viewSize = self.ScrollView_fazhen:getSize();
    local viewPos  = self.ScrollView_fazhen:convertToWorldSpace(ccp(0,0));--getParent():convertToWorldSpace(self.ScrollView_fazhen:getPosition());
    viewSize.height = viewSize.height + viewPos.y

    local moveY = nil
    if worldPoint.y + size.height / 2 > viewSize.height then
        moveY = - (worldPoint.y + size.height / 2 - viewSize.height);
    elseif  worldPoint.y - size.height / 2 < viewPos.y then
        moveY = viewPos.y - (worldPoint.y - size.height / 2);
    end

    if not moveY then
        return;
    end

    InnerContainer:runAction(CCMoveBy:create(0.2,ccp(0,moveY)));
end

function EquipmentInfo:updateCombItem(item,info,combId,combInfo)
    local Image_title_di    = TFDirector:getChildByPath(item,"Image_title_di");
    local Image_icon        = TFDirector:getChildByPath(item,"Image_icon");
    local Label_skill_name = TFDirector:getChildByPath(item,"Label_skill_name")
    local Label_skill_name_select = TFDirector:getChildByPath(item,"Label_skill_name_select")
    local descLabel         = TFDirector:getChildByPath(item,"Label_skill_desc");
    local orgSize           = descLabel:getContentSize();
    local selectImg         = TFDirector:getChildByPath(item,"Image_select");
    local Image_lock         = TFDirector:getChildByPath(item,"Image_lock")
    local Image_iconBGActiv = TFDirector:getChildByPath(item,"Image_iconBGActiv")
    local Image_iconBGLock = TFDirector:getChildByPath(item,"Image_iconBGLock")
    local Label_lv          = TFDirector:getChildByPath(item,"Label_lvcomb");
    local Image_lv_di       = TFDirector:getChildByPath(item,"Image_EquipInfoLayer_1");
    

    local isok = false;
    local lv = 0;
    local iconpath = TabDataMgr:getData("EquipmentCombination",combId).icon1
    for k,v in pairs(combInfo) do
        if v.combid == combId and v.isok then
            iconpath = TabDataMgr:getData("EquipmentCombination",combId).icon2
            isok = true;
            lv = v.lv;
            break;
        end
    end
    Image_icon:setTexture(iconpath);
    local skillInfo = TabDataMgr:getData("PassiveSkills",info.skill);
    Label_skill_name:setTextById(skillInfo.name);
    Label_skill_name_select:setTextById(skillInfo.name);
    Label_skill_name_select:setVisible(false)
    descLabel:setTextById(skillInfo.des);

    if isok then
        Image_iconBGActiv:setVisible(true)
        Image_iconBGLock:setVisible(false)
        
        Label_lv:setString("Lv."..lv);
    else
        Image_iconBGActiv:setVisible(false)
        Image_iconBGLock:setVisible(true)
        Utils:setNodeGray(Image_icon, true)
        Label_lv:setTextById(493006);
      
        -- Label_lv:setString("未激活");
        -- Label_lv:setColor(ccc3(0,0,0));
        -- descLabel:setColor(ccc3(0,0,0));
        -- descLabel:enableOutline(ccc4(0,0,0,0),-1);
    end

   


    item:setTouchEnabled(true);
    item:onClick(function()
            for combId,item in pairs(self.combListView:getItems()) do
                local skillName = TFDirector:getChildByPath(item,"Label_skill_name");
                skillName:setVisible(true)
                local skillNameSelect = TFDirector:getChildByPath(item,"Label_skill_name_select");
                skillNameSelect:setVisible(false)
            end

            if self.part1 then
                self.part1:hide();
                self.part1:stopAllActions();
            end

            if self.part2 then
                self.part2:hide();
                self.part2:stopAllActions();
            end
            Label_skill_name:setVisible(false)
            Label_skill_name_select:setVisible(true)

            if self.selectLine then
                self.selectLine:setVisible(false);
                self.selectLine:stopAllActions();
            end

            if self.selectItem then
                self.selectItem:stopAllActions();
                self.selectImg:hide();
            end

            self.part1 = self["Image_board"..info.needParticle[1]]:getChildByName("Image_select"):show();
            self.part2 = self["Image_board"..info.needParticle[2]]:getChildByName("Image_select"):show();
            self.selectLine = TFDirector:getChildByPath(self.ScrollView_fazhen,"Image_select_link"..combId):show();
            -- Public:BlinkAction(self.part1)
            -- Public:BlinkAction(self.part2)
            -- Public:BlinkAction(self.selectLine)


            if self.part1 ~= self.Image_select then
               self:showInView(self["Image_board"..info.needParticle[1]])
            end

            if self.part2 ~= self.Image_select then
                self:showInView(self["Image_board"..info.needParticle[2]])
            end

            local delay = CCDelayTime:create(4);
            local callfunc = CCCallFunc:create(function()
                    self.part1:stopAllActions();
                    self.part2:stopAllActions();
                    self.selectLine:stopAllActions();
                    if self.selectImg then 
                        self.selectImg:hide()
                    end
                    if self.part1 ~= self.Image_select then
                        self.part1:hide();
                    end

                    if self.part2 ~= self.Image_select then
                        self.part2:hide();
                    end

                    self.selectLine:hide();
                     Label_skill_name:setVisible(true)
                     Label_skill_name_select:setVisible(false)
                end)

            local actions = {
                    delay,
                    callfunc
                }
           item:runAction(Sequence:create(actions))

           if self.selectImg then
                self.selectImg:hide();
           end

           selectImg:show();

           self.selectItem = item;
           self.selectImg = selectImg;


        end)
end

function EquipmentInfo:resetTreeUi()
    for i=1,10 do
        self["Image_board"..i]:setTexture("ui/473.png");
        local Image_light   = TFDirector:getChildByPath(self["Image_board"..i],"Image_light");
        local Image_icon    = TFDirector:getChildByPath(self["Image_board"..i],"Image_icon");
        local Image_title   = TFDirector:getChildByPath(self["Image_board"..i],"Image_title");
        local Label_type_name=TFDirector:getChildByName(self["Image_board"..i],"Label_type_name");
        local Image_select  = TFDirector:getChildByName(self["Image_board"..i],"Image_select");

        Image_select:setVisible(false);
        Image_light:setTexture("");
        Image_icon:setTexture(EC_EquipSubTypeIcon[i]);
        Image_icon:Size(CCSizeMake(80,80));
        Image_title:setTexture(EC_EquipSubTypeTitle[i]);

        --Label_type_name:setColor(ccc3(0,0,0));
    end

    for i=1,22 do
        TFDirector:getChildByPath(self.ScrollView_fazhen,"Image_link"..i):hide();
        TFDirector:getChildByPath(self.ScrollView_fazhen,"Image_select_link"..i):hide();
    end
    self.combListView:removeAllItems();
end

function EquipmentInfo:onRspStepEquip(data)
    self.equipmentId = data.equipId

    if self.equips then
        local index = table.indexOf(self.equips, data.costEquipId) - 1
        table.removeItem(self.equips, data.costEquipId)
        self.equipsPageView:removePageAtIndex(index)
    end

    if EquipmentDataMgr:isUesing(self.equipmentId) then
        self.heroid = EquipmentDataMgr:getHeroSid(self.equipmentId)
        self.heroid = HeroDataMgr:getHeroCidBySid(self.heroid)
        self.pos = EquipmentDataMgr:getPosition(self.equipmentId)
    end

    self:updatePageView()
end

function EquipmentInfo:registerEvents()
    EventMgr:addEventListener(self,EV_EQUIPMENT_OPERATION,handler(self.EV_EQUIPMENT_OPERATION, self))
    EventMgr:addEventListener(self,EQUIPMENT_LOCK_RESULT,handler(self.equipLockChangeResult, self))
    EventMgr:addEventListener(self,EQUIPMENT_RECYCLERESULTS,handler(self.onEquipRecycle, self))
    EventMgr:addEventListener(self, EV_EQUIP_STEP_UP, handler(self.onRspStepEquip, self))

    self.backBtn:onClick(function ()
            AlertManager:close();
    end)

    self.mainBtn:onClick(function()
            AlertManager:changeScene(SceneType.MainScene)
        end)
    if self.isfriend == true and self.backTag == "teamFight" then
        -- self.topLayer.Button_main:setTexture("ui/cc.png")
        self:setMainBtnCallback(function()
                TeamFightDataMgr:openTeamView()
            end)
    end
    self.changeBtn:onClick(function()
            if self.fromBag then
                return;
            end

            if not EquipmentDataMgr:isCanUseEquip() then
                -- toastMessage("没有可使用的装备");
                Utils:showTips(493007)
                return
            end

            local list = EquipmentDataMgr:initShowList(self.heroid,self.pos);
            if table.count(list) <= 0 then
                -- toastMessage("没有可使用的装备");
                Utils:showTips(493007)
                return
            end
            self.callback = function()
                AlertManager:closeLayer(self)
            end
            Utils:openView("Equipment.EquipmentSelect", {heroid = self.heroid,pos = self.pos,ishave = true, closeBack = self.callback, isSkyladder = self.isSkyladder})
            -- local layer = require("lua.logic.Equipment.EquipmentSelect"):new({heroid = self.heroid,pos = self.pos,ishave = true, closeBack = self.callback});
            -- AlertManager:addLayer(layer)
            -- AlertManager:show()
        end)
    self.changeBtn:setVisible(self.ishave);
    self.changeBtn:setVisible(not self.fromBag);

    self.strengthenBtn:onClick(function()
            Utils:openView("Equipment.EquipmentStrengthen", {heroid = self.heroid,equipmentId = self.equipmentId})
            -- local layer = require("lua.logic.Equipment.EquipmentStrengthen"):new({heroid = self.heroid,equipmentId = self.equipmentId});
            -- AlertManager:addLayer(layer)
            -- AlertManager:show()
        end)
    self.strengthenBtn:setVisible(self.ishave and EquipmentDataMgr:getEquipSubType(self.equipmentId) ~= EC_EquipSubType.Daat and EquipmentDataMgr:getEquipSubType(self.equipmentId) ~= EC_EquipSubType.Wanneng);

    self.reformBtn:onClick(function()
        Utils:openView("Equipment.EquipmentReform", {heroid = self.heroid,equipmentId = self.equipmentId, equips = self.equips, fromBag = self.fromBag});
        
    end)
    self.reformBtn:setVisible(self.ishave and EquipmentDataMgr:getEquipSubType(self.equipmentId) ~= EC_EquipSubType.Daat and EquipmentDataMgr:getEquipSubType(self.equipmentId) ~= EC_EquipSubType.Wanneng);

    self.Button_star_up:setVisible(self.ishave and EquipmentDataMgr:getEquipStarGrow(self.equipmentId))
    self.Button_star_up:onClick(function()
        local starLevel = EquipmentDataMgr:getEquipStarLevel(self.equipmentId)
        if starLevel >= 3 then
            Utils:showTips(490407)
            return
        end
        Utils:openView("Equipment.EquipmentStarUp", {equipmentId = self.equipmentId})
    end)


    self.convertBtn:onClick(function()
            if EquipmentDataMgr:getIsHaveSpecialAttr(self.equipmentId) then
                Utils:openView("Equipment.EquipmentConvert", {heroid = self.heroid,equipmentId = self.equipmentId})
                -- local layer = require("lua.logic.Equipment.EquipmentConvert"):new({heroid = self.heroid,equipmentId = self.equipmentId});
                -- AlertManager:addLayer(layer)
                -- AlertManager:show()
            else
                Utils:showTips(490006)
            end
        end)
    self.convertBtn:setVisible(self.ishave and EquipmentDataMgr:getEquipSubType(self.equipmentId) ~= EC_EquipSubType.Daat and EquipmentDataMgr:getEquipSubType(self.equipmentId) ~= EC_EquipSubType.Wanneng);

    self.stepUpBtn:onClick(function()
        Utils:openView("Equipment.EquipStepUpLayer", {heroid = self.heroid, equipmentId = self.equipmentId, equips = self.equips, fromBag = self.fromBag})
    end)
    self.stepUpBtn:setVisible(self.ishave and EquipmentDataMgr:getEquipSubType(self.equipmentId) ~= EC_EquipSubType.Daat)

    self.Button_equip:onClick(function()
            if self.Panel_equip:isVisible() then return end
            local tmpImg = TFDirector:getChildByName(self.Button_equip,"Image_buttonEquip")
            --TODO CLOSE
            --tmpImg:setTexture("ui/Equipment/new_ui/a2.png");
            tmpImg:setTexture("ui/Equipment/new_ui/new_48.png");

            --self.Button_equip:getChildByName("Label_button_name"):setColor(ccc3(255,255,255));
            local tmpImg2 = TFDirector:getChildByName(self.Button_zuhe,"Image_buttonZuhe")
            --TODO CLOSE
            --tmpImg2:setTexture("ui/Equipment/new_ui/a1.png");
            tmpImg2:setTexture("ui/Equipment/new_ui/new_47.png");

            --self.Button_zuhe:getChildByName("Label_button_name"):setColor(ccc3(0,0,0));
            local tmpImg3 = TFDirector:getChildByName(self.Button_suit,"Image_buttonsuit")
            tmpImg3:setTexture("ui/Equipment/new_ui/a1.png")
            self.Panel_equip:setVisible(true);
            self.Panel_combination:setVisible(false);
            self.Panel_suit_show:setVisible(false);
            self.Image_Equip:show();
            self.equipsPageView:show();
            self.Button_camera:show();
            self.ScrollView_fazhen:hide();
            self.curPanel = self.Panel_equip;
            
            self:panelRightShow(self.Panel_equip)
        end)

    self.Button_zuhe:onClick(function()
            if self.Panel_combination:isVisible() then return end
            if EquipmentDataMgr:getEquipSubType(self.equipmentId) == EC_EquipSubType.Daat or EquipmentDataMgr:getEquipSubType(self.equipmentId) == EC_EquipSubType.Wanneng then
                Utils:showTips(490013);
                return;
            end

            local tmpImg = TFDirector:getChildByName(self.Button_equip,"Image_buttonEquip")
            --TODO CLOSE
            --tmpImg:setTexture("ui/Equipment/new_ui/a1.png");
            tmpImg:setTexture("ui/Equipment/new_ui/new_47.png");

            --self.Button_equip:getChildByName("Label_button_name"):setColor(ccc3(0,0,0));
            local tmpImg2 = TFDirector:getChildByName(self.Button_zuhe,"Image_buttonZuhe")
            --TODO CLOSE
            --tmpImg2:setTexture("ui/Equipment/new_ui/a2.png");
            tmpImg2:setTexture("ui/Equipment/new_ui/new_48.png");

            --self.Button_zuhe:getChildByName("Label_button_name"):setColor(ccc3(255,255,255));
            local tmpImg3 = TFDirector:getChildByName(self.Button_suit,"Image_buttonsuit")
            tmpImg3:setTexture("ui/Equipment/new_ui/a1.png")
            self.Panel_equip:setVisible(false);
            self.Panel_suit_show:setVisible(false);
            self.Image_Equip:hide();
            self.equipsPageView:hide();
            self.Button_camera:hide();
            self.ScrollView_fazhen:show();
            self.Panel_combination:setVisible(true);
            self.curPanel = self.Panel_combination;
            self:panelRightShow(self.Panel_combination)
            self:panelLeftShow(self.ScrollView_fazhen)
        end) 
    
    --TODO CLOSE
    -- self.Button_suit:onClick(function()
    --     if self.Panel_suit_show:isVisible() then return end
    --     local suit = EquipmentDataMgr:getEquipSuitInfo(self.equipmentId)
    --     if table.count(suit) < 1 then
    --         Utils:showTips(15000001)
    --         return
    --     end

    --     local tmpImg = TFDirector:getChildByName(self.Button_equip,"Image_buttonEquip")
    --     tmpImg:setTexture("ui/Equipment/new_ui/a1.png")
    --     local tmpImg2 = TFDirector:getChildByName(self.Button_zuhe,"Image_buttonZuhe")
    --     tmpImg2:setTexture("ui/Equipment/new_ui/a1.png")
    --     local tmpImg3 = TFDirector:getChildByName(self.Button_suit,"Image_buttonsuit")
    --     tmpImg3:setTexture("ui/Equipment/new_ui/a2.png")
    --     self.Panel_equip:setVisible(false)
    --     self.Panel_combination:setVisible(false)
    --     self.Image_Equip:hide()
    --     self.equipsPageView:hide()
    --     self.Button_camera:hide()
    --     self.ScrollView_fazhen:show()
    --     self.Panel_suit_show:setVisible(true)
    --     self.curPanel = self.Panel_suit_show
    --     self:panelRightShow(self.Panel_suit_show)
    --     self:panelLeftShow(self.ScrollView_fazhen)
    -- end) 


    self.Button_camera:onClick(function()
            self:onTouchCamera();
        end)

    self.ui:onClick(function()
            self:onTouchCamera();
        end)

    self.Button_share:onClick(function()
            self:onTouchCamera();
        end)

    self.Button_locked:onClick(function()
        EquipmentDataMgr:changeEquipLockStatus(self.equipmentId)
    end)

    self.Button_recycle:onClick(function()
        local layer = require("lua.logic.Equipment.EquipmentRecycle"):new({heroid = self.heroid,equipmentId = self.equipmentId})
        AlertManager:addLayer(layer)
        AlertManager:show()
    end)

    self.Button_eval:onClick(function()
        
        if not FunctionDataMgr:getModifyFuncIsOpen() then
            Utils:showTips(63826)
            return
        end
        local layer = require("lua.logic.fairyNew.EvaluationView"):new({heroOrEquip = 1, 
            heroId = self.equipmentId, callfunc = function()
            
        end})
        AlertManager:addLayer(layer)
        AlertManager:show()
    end)

    if self.isfriend then
        self.changeBtn:hide();
        self.strengthenBtn:hide();
        self.reformBtn:hide()
        self.convertBtn:hide();
        self.stepUpBtn:hide()
        self.mainBtn:hide()
        self.Button_star_up:hide()
    end


    if self.fromBag and self.equips then
        local function pageUp()
            if self.equipPageIdx < #self.equips then
                self.equipPageIdx = self.equipPageIdx + 1
                local function callBack()
                    self.Image_Equip:setOpacity(0)
                    self.Image_Equip:setPositionX(1500)
                    self:changeEquipPage(true)
                end
                local act1 = CCMoveTo:create(0.2, ccp(-400, self.equipPos_.y))
                local act2 = CCCallFuncN:create(callBack)
                self.Image_Equip:runAction(CCSequence:create({act1, act2}))
            else
                self.Image_Equip:setTouchEnabled(true)
                self.Image_Equip:runAction(CCMoveTo:create(0.2, self.equipPos_))
            end
        end

        local function pageDown()
            if self.equipPageIdx > 1 then
                self.equipPageIdx = self.equipPageIdx - 1
                local function callBack()
                    self.Image_Equip:setOpacity(0)
                    self.Image_Equip:setPositionX(-400)
                    self:changeEquipPage(false)
                end
                local act1 = CCMoveTo:create(0.2, ccp(1500, self.equipPos_.y))
                local act2 = CCCallFuncN:create(callBack)
                self.Image_Equip:runAction(CCSequence:create({act1, act2}))
            else
                self.Image_Equip:setTouchEnabled(true)
                self.Image_Equip:runAction(CCMoveTo:create(0.2, self.equipPos_))
            end
        end

        local function onTouchBegan(touch, location)
            touch.startPos = location
            return true
        end

        local function onTouchMoved(touch, location)
            touch.isMoved = true
            local offsetx = location.x - touch.startPos.x
            local offsety = location.y - touch.startPos.y
            self.Image_Equip:setPosition(ccp(self.equipPos_.x + offsetx, self.equipPos_.y))
        end

        local function onTouchUp(touch, location)
            local offsetx = location.x - touch.startPos.x
            if touch.isMoved then
                if math.abs(offsetx) > 100 then
                    self.Image_Equip:setTouchEnabled(false)
                    if offsetx < 0 then
                        pageUp()
                    else
                        pageDown()
                    end
                else
                    self.Image_Equip:runAction(CCMoveTo:create(0.04, self.equipPos_))
                end
            end
        end

        self.Image_Equip:setTouchEnabled(true)
        self.Image_Equip:addMEListener(TFWIDGET_TOUCHBEGAN, onTouchBegan)
        self.Image_Equip:addMEListener(TFWIDGET_TOUCHMOVED, onTouchMoved)
        self.Image_Equip:addMEListener(TFWIDGET_TOUCHENDED, onTouchUp)
    end
end

function EquipmentInfo:changeEquipPage(isUp)
    self.Image_Equip:stopAllActions()
    self.equipmentId = self.equips[self.equipPageIdx] or self.equipmentId
    if EquipmentDataMgr:isUesing(self.equipmentId) then
        self.heroid = EquipmentDataMgr:getHeroSid(self.equipmentId)
        self.heroid = HeroDataMgr:getHeroCidBySid(self.heroid)
        self.pos = EquipmentDataMgr:getPosition(self.equipmentId)
    end
    local paintPath = EquipmentDataMgr:getEquipPaint(self.equipmentId)
    self.Image_Equip:setTexture(paintPath)
    me.TextureCache:removeUnusedTextures()
    
    local pos = EquipmentDataMgr:getEquipPaintPosition(self.equipmentId)
    local scale = EquipmentDataMgr:getEquipPaintScale(self.equipmentId)
    self.Image_Equip:setScale(scale)
    self.Image_Equip:setOpacity(255)
    self.equipPos_ = pos
    self.Image_Equip:setPositionY(self.equipPos_.y)
    local function callBack()
        self.Image_Equip:setTouchEnabled(true)
        self:updateUI()
        self:updateCombinationInfo()
        self:updateSuitView()
    end
    local delay = isUp and 0.2 or 0.15
    local act1 = CCMoveTo:create(delay, self.equipPos_)
    act1 = EaseSineOut:create(act1)
    local act2 = CCCallFuncN:create(callBack)
    self.Image_Equip:runAction(CCSequence:create({act1, act2}))
end

function EquipmentInfo:onTouchCamera()
    Utils:openView("summon.SummonGetEquipmentView", EquipmentDataMgr:getEquipCid(self.equipmentId))


end

function EquipmentInfo:onShow()
    self.super.onShow(self)
   self:panelRightShow(self.Panel_equip)
   self:panelRightShow(self.Panel_combination)
   self:panelRightShow(self.Panel_di)
   self.selectItem = nil
   self.selectImg = nil
   if EquipmentDataMgr:getBackFromReform() then
        self.equipmentId = EquipmentDataMgr:getBackFromReform()
        EquipmentDataMgr:setBackFromReform(nil)
        self:updatePageView()
   end
   self:updateUI()

    me.TextureCache:removeUnusedTextures()
    SpineCache:getInstance():clearUnused()

end

function EquipmentInfo:onHide()
    self.super.onHide(self)
end

function EquipmentInfo:removeUI()
    self.super.removeUI(self)
end

function EquipmentInfo:panelRightShow(panel)
    panel:stopAllActions();
    panel:setOpacity(0);
    panel:setPositionX(panel:getPositionX() + 20)

    local actions = {
        CCMoveBy:create(0.2,ccp(-20,0));
        CCFadeIn:create(0.2);
    }

    panel:runAction(Spawn:create(actions));
end

function EquipmentInfo:panelRightHide(panel)
    panel:stopAllActions();
    panel:setPositionX(panel:getPositionX() - 20)

    local actions = {
        CCMoveBy:create(0.2,ccp(20,0));
        CCFadeOut:create(0.2);
    }

    panel:runAction(Spawn:create(actions));
end

function EquipmentInfo:panelLeftShow(panel)
    panel:stopAllActions();
    panel:setOpacity(0);
   

    panel:runAction(CCFadeIn:create(0.2))
end

function EquipmentInfo:panelLeftHide(panel)
    panel:stopAllActions();
   

    panel:runAction(CCFadeOut:create(0.2))
end

return EquipmentInfo;