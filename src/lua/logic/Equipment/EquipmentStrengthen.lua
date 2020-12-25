local EquipmentStrengthen = class("EquipmentStrengthen", BaseLayer)

local expAddRichText = [[<font face="fangzheng_zhunyuan" color="#000000">%d<font face="fangzheng_zhunyuan" color="#297600">+%d</font>/%d</font>]]
local expRichText = [[<font face="fangzheng_zhunyuan" color="#000000">%d/%d</font>]]
local expMaxRichText = [[<font face="fangzheng_zhunyuan" color="#000000">Max</font>]]

local Enum_EquipType = {
    Exp = 1,
    Normal = 2
}

function EquipmentStrengthen:ctor(data)
    self.super.ctor(self,data)
    self.paramData_ = data
    self.showList,self.equipCnt = EquipmentDataMgr:initShowListByStrengthen(data.equipmentId);
    self.showId = data.equipmentId
    self.heroid = data.heroid;
    -- self.pos    = data.pos;
    self.selectExp = 0;
    self.isMaxLevel = EquipmentDataMgr:calcLevelUp(self.showId,0);
    self.allItems = {};
    self.selectTab = {};
    self.loadedIndex_ = 1
    self:init("lua.uiconfig.Equip.EquipStrengthen")
    
    self:showTopBar();
end

function EquipmentStrengthen:getClosingStateParams()
    return {self.paramData_}
end

function EquipmentStrengthen:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	EquipmentStrengthen.ui = ui

	self.backBtn		= TFDirector:getChildByPath(ui,"Button_back");
	self.mainBtn		= TFDirector:getChildByPath(ui,"Button_main");
    self.changeBtn      = TFDirector:getChildByPath(ui,"Button_change");
    self.fastBtn        = TFDirector:getChildByPath(ui,"Button_fast");
    self.Panel_gold     = TFDirector:getChildByPath(ui,"Panel_gold");
    self.Label_gold     = TFDirector:getChildByPath(ui,"Label_gold");
    self.Image_cast_di  = TFDirector:getChildByPath(ui,"Image_cast_di");
    self.Panel_gold:setVisible(false);


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
    self.rightItem          = TFDirector:getChildByPath(ui,"Panel_item");

    --装备信息界面
    self.leftPanel          = TFDirector:getChildByPath(ui,"Panel_left");
    self.Image_equip_back   = TFDirector:getChildByPath(ui,"Image_equip_back");
    self.Label_name         = TFDirector:getChildByPath(ui,"Label_name");
    self.Image_equip        = TFDirector:getChildByPath(self.leftPanel,"Image_Equip");
    self.Image_type         = TFDirector:getChildByPath(self.leftPanel,"Image_type");
    local Panel_bottom =    TFDirector:getChildByPath(ui,"Panel_bottom")
    self.Label_cost_title   = TFDirector:getChildByPath(Panel_bottom,"Label_cost_title");
    self.Label_cost         = TFDirector:getChildByPath(Panel_bottom,"Label_cost");
    self.equip_cost         = TFDirector:getChildByPath(self.leftPanel,"equip_cost");
    self.Image_star1        = TFDirector:getChildByPath(self.leftPanel,"Image_star1");
    self.Image_star2        = TFDirector:getChildByPath(self.leftPanel,"Image_star2");
    self.Image_star3        = TFDirector:getChildByPath(self.leftPanel,"Image_star3");
    self.Image_star4        = TFDirector:getChildByPath(self.leftPanel,"Image_star4");
    self.Image_star5        = TFDirector:getChildByPath(self.leftPanel,"Image_star5");
    self.Image_stage1 = TFDirector:getChildByPath(self.leftPanel,"Image_stage1")
    self.Image_stage2 = TFDirector:getChildByPath(self.leftPanel,"Image_stage2")
    self.Image_stage3 = TFDirector:getChildByPath(self.leftPanel,"Image_stage3")
    self.LoadingBar_exp     = TFDirector:getChildByPath(self.leftPanel,"LoadingBar_exp");
    self.Label_lv_tips      = TFDirector:getChildByPath(self.leftPanel,"Label_lv_tips");
    self.Label_exp          = TFDirector:getChildByPath(self.leftPanel,"Label_exp");
    self.Label_level        = TFDirector:getChildByPath(self.leftPanel,"Label_level")
    self.Spine_level_up_tip = TFDirector:getChildByPath(self.leftPanel,"Spine_level_up_tip"):hide()
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

    self.Panel_attr      = TFDirector:getChildByPath(ui,"Panel_attr");
    self.LvLabel                       = TFDirector:getChildByPath(self.Panel_attr,"old_lv");
    self.hpLabel                       = TFDirector:getChildByPath(self.Panel_attr,"old_hp");
    self.atkLabel                      = TFDirector:getChildByPath(self.Panel_attr,"old_atk");
    self.defLabel                      = TFDirector:getChildByPath(self.Panel_attr,"old_def");
    self.LvLabel:setString(0); 
    self.hpLabel:setString(0); 
    self.atkLabel:setString(0);
    self.defLabel:setString(0);

    local Panel_right = TFDirector:getChildByPath(ui,"Panel_right")
    ViewAnimationHelper.doMoveFadeInAction(self.leftPanel, {direction = 2, distance = 30, time = 0.2, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(self.GuYouTitle, {direction = 2, distance = 30, time = 0.2, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(self.TeShuTitile, {direction = 2, distance = 30, time = 0.2, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(self.GuYouItem, {direction = 2, distance = 30, time = 0.2, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(self.Panel_attr, {direction = 2, distance = 30, time = 0.2, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(Panel_bottom, {direction = 2, distance = 30, time = 0.2, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(Panel_right, {direction = 2, distance = 10, time = 0.1, ease = 1})

    self.Button_ExpEquip    = TFDirector:getChildByPath(Panel_right,"Button_ExpEquip")
    self.ExpSelect = TFDirector:getChildByPath(self.Button_ExpEquip,"Image_select")
    self.Button_OtherEquip    = TFDirector:getChildByPath(Panel_right,"Button_OtherEquip")
    self.OtherSelect = TFDirector:getChildByPath(self.Button_OtherEquip,"Image_select")
    self.Panel_batch = TFDirector:getChildByPath(Panel_right,"Panel_batch")
    self.Button_down    = TFDirector:getChildByPath(self.Panel_batch,"Button_down");
    self.Button_up      = TFDirector:getChildByPath(self.Panel_batch,"Button_up");
    self.Button_max = TFDirector:getChildByPath(self.Panel_batch, "Button_max")
    self.Label_num      = TFDirector:getChildByPath(self.Panel_batch,"Label_num");

    self:chooseEquipType(Enum_EquipType.Exp)
end

function EquipmentStrengthen:chooseEquipType(equipType,isClick)

    self.chooseType = equipType

    self.ExpSelect:setVisible(equipType == Enum_EquipType.Exp)
    self.OtherSelect:setVisible(equipType == Enum_EquipType.Normal)
    self.fastBtn:setVisible(equipType == Enum_EquipType.Normal)
    self.Panel_batch:setVisible(false)
    self.selectExp = 0;
    self.allItems = {};
    self.selectTab = {};
    self.loadedIndex_ = 1
    self.lastSelect = nil;
    self.selectExpItem = nil
    local fitEquipList = {}
    self.showList,self.equipCnt = EquipmentDataMgr:initShowListByStrengthen(self.showId);
    for k,v in ipairs(self.showList) do
        local equipCid = EquipmentDataMgr:getEquipCid(v.id)
        local goodsCfg = GoodsDataMgr:getItemCfg(equipCid)
        if equipType == Enum_EquipType.Exp then
            if goodsCfg.subType == 100 and goodsCfg.superType == EC_ResourceType.SPIRIT then
                table.insert(fitEquipList,v)
            end
        else
            if goodsCfg.subType ~= 100 and goodsCfg.superType == EC_ResourceType.SPIRIT then
                table.insert(fitEquipList,v)
            end
        end
    end

    local showList = {}
    local num = 0;
    local idx = 0;
    for i,v in ipairs(fitEquipList) do
        num = num + 1;
        if num % 4 == 1 then
            idx = idx + 1;
        end

        showList[idx] = showList[idx] or {};
        table.insert(showList[idx],v);
    end

    self.showList = showList;
    self.equipCnt = num;

    self:loadEquipMent();
    if not isClick then
        self:updateEquipInfo();
    end
    self:updateAttrInfo()
end

function EquipmentStrengthen:loadEquipMent()
    local loadedIndex = self.loadedIndex_
    if loadedIndex <= 1 then
        self.ListView_right:removeAllItems()
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
            local data = self.showList[loadedIndex][i]
            subItem.data = data
            self:updateOneEquipment(self.showList[loadedIndex][i],subItem)
            table.insert(self.allItems,subItem)
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

function EquipmentStrengthen:updateOneEquipment(data,item)

    local id = data.id
    local starLv = EquipmentDataMgr:getEquipStarLv(id);
    local quality = EquipmentDataMgr:getEquipQuality(id);

    local Image_level_bg = TFDirector:getChildByPath(item,"Image_level_bg")
    local Label_lv_title = TFDirector:getChildByPath(item,"Label_lv_title")
    local LvLabel = TFDirector:getChildByPath(item,"Label_lv");
    Image_level_bg:setTexture(EC_ItemLevelIcon[quality])
    Label_lv_title:setString("Lv.")
    LvLabel:setString(EquipmentDataMgr:getEquipLv(id))


    --暂时屏蔽质点突破数值
    -- local stepLabel = TFDirector:getChildByPath(item,"label_level_step")
    -- stepLabel:setText(EquipmentDataMgr:getStepText(id))

    local Label_num = TFDirector:getChildByPath(item,"Label_num"):hide()
    local num = EquipmentDataMgr:getEquipNum(id)
    if num then
        Label_num:setVisible(true)
        Label_num:setText(num)
    end

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

    local typeIcon      = TFDirector:getChildByPath(item,"Image_type");
    local subType       = EquipmentDataMgr:getEquipSubType(id);
    typeIcon:setTexture(EC_EquipSubTypeIcon2[subType]);
    typeIcon:Size(CCSizeMake(24,24));

    local backImg       = TFDirector:getChildByPath(item,"Image_back");
    backImg:setTouchEnabled(true);
    backImg:onClick(function()
        if self.chooseType == Enum_EquipType.Exp then
            self:onTouchOneExpEquip(item)
        else
            self:onTouchOneEquip(item);
        end

    end)

    --dump(item:getParent():convertToWorldSpace(item:getPosition()))
end

function EquipmentStrengthen:onTouchOneExpEquip(item)

    if self.selectExpItem then
        if self.selectExpItem.data.id == item.data.id then
            return
        end
        self.selectExpItem.selectImg:setVisible(false)
    end
    self.selectTab = {}
    self.selectExp = 0
    self:updateAttrInfo()
    item.selectImg:setVisible(true)
    self.selectExpItem = item
    self.Panel_batch:setVisible(true)
    self.selectNum = 1
    self.Label_num:setString(self.selectNum);
    self:updateSelectExpItem()
end

function EquipmentStrengthen:updateBatchPanel(num)

    self.selectNum = self.selectNum + num;
    if self.selectNum <= 1 then
        self.selectNum = 1;
    end

    local maxCnt = self:getMaxCnt()
    if self.selectNum >= maxCnt then
        self.selectNum = maxCnt
    end
    dump(self.selectNum)
    self.Label_num:setString(self.selectNum);

    if num > 0 and self.isMaxLevel then
        toastMessage(TextDataMgr:getText(493009))
        return
    end

    self:updateSelectExpItem()
end

function EquipmentStrengthen:updateSelectExpItem()

    if #self.selectTab > self.selectNum then
        local delCnt = #self.selectTab - self.selectNum
        for i = #self.selectTab,self.selectNum+1,-1 do
            local item = self.selectExpItem.data.id
            if item then
                self.selectExp = self.selectExp - EquipmentDataMgr:getEquipTotalExp(item);
                table.remove(self.selectTab,i);
            end
        end
    else
        for i=#self.selectTab+1,self.selectNum do
            local item = self.selectExpItem.data.id
            if item then
                self.selectExp = self.selectExp + EquipmentDataMgr:getEquipTotalExp(item);
                table.insert(self.selectTab,item);
            end
        end
    end

    self:updateAttrInfo();
end

function EquipmentStrengthen:onTouchOneEquip(item)
    if item.selectImg:isVisible() then
        item.selectImg:setVisible(false);
        if item.data.merge then
            local totalExp = 0
            for k,v in ipairs(item.data.merge) do
                totalExp = totalExp + EquipmentDataMgr:getEquipTotalExp(v);
                table.removeItem(self.selectTab,v);
            end
            self.selectExp = self.selectExp - totalExp
        else
            self.selectExp = self.selectExp - EquipmentDataMgr:getEquipTotalExp(item.data.id);
            table.removeItem(self.selectTab,item.data.id);
        end
        self.lastSelect = self.selectTab[#self.selectTab];
    else
        if self.isMaxLevel then
            toastMessage(TextDataMgr:getText(493009))
            return;
        end
        if table.count(self.selectTab) <= 0 then
            self.prePercent = self.LoadingBar_exp:getPercent()
        end
        item.selectImg:setVisible(true)
        if item.data.merge then
            local totalExp = 0
            for k,v in ipairs(item.data.merge) do
                totalExp = totalExp + EquipmentDataMgr:getEquipTotalExp(v);
                table.insert(self.selectTab,v);
            end
            self.selectExp = self.selectExp + totalExp
        else
            self.selectExp = self.selectExp + EquipmentDataMgr:getEquipTotalExp(item.data.id);
            table.insert(self.selectTab,item.data.id);
        end
        self.lastSelect = item.data.id
    end


    self:updateAttrInfo();
end

function EquipmentStrengthen:updateAttrInfo()
    local curPercent = 0;
    local level      = 0;
    local lv         = EquipmentDataMgr:getEquipLv(self.showId);
    local maxLv      = EquipmentDataMgr:getEquipMaxLv(self.showId);
    self.isMaxLevel,level,curPercent = EquipmentDataMgr:calcLevelUp(self.showId,self.selectExp);
    self.Label_lv_tips:setString(level.."/"..maxLv);

    local exp       = EquipmentDataMgr:getEquipCurExp(self.showId);
    local maxExp    = EquipmentDataMgr:getEquipCurNeedExp(self.showId);
    if self.isMaxLevel then
        self.Label_exp:setString("MAX");
    else
        self.Label_exp:setString((exp + self.selectExp).."/"..maxExp);
    end

    -- if level > lv then
    --     self.LoadingBar_exp_add:setPercent(100)
    -- else
    --     self.LoadingBar_exp_add:setPercent(curPercent)
    -- end
    -- self.LoadingBar_exp_add:setVisible(self.selectExp > 0);

    local percent       = EquipmentDataMgr:getEquipExpPercent(self.showId);
    if self.selectExp > 0 then 
        if level > lv then
            self.LoadingBar_exp:setPercent(100)
        else
            self.LoadingBar_exp:setPercent(curPercent)
        end
        --Utils:loadingBarAddAction(self.LoadingBar_exp,curPercent)
    else
        self.LoadingBar_exp:setPercent(percent)
        --Utils:loadingBarAddAction(self.LoadingBar_exp,percent)
    end

    if self.isMaxLevel then
        self.LoadingBar_exp:setPercent(100)
    end
    
    if level > lv then
        self.cur_atk:setVisible(true)
        self.cur_def:setVisible(true)
        self.cur_hp:setVisible(true)


        self.cur_atk:setString("+" .. math.floor(EquipmentDataMgr:getEquipBaseAtk(self.showId,level)) - math.floor(EquipmentDataMgr:getEquipBaseAtk(self.showId,lv)));
        self.cur_def:setString("+" .. math.floor(EquipmentDataMgr:getEquipBaseDef(self.showId,level)) - math.floor(EquipmentDataMgr:getEquipBaseDef(self.showId,lv)));
        self.cur_hp:setString("+" .. math.floor(EquipmentDataMgr:getEquipBaseHp(self.showId,level)) - math.floor(EquipmentDataMgr:getEquipBaseHp(self.showId,lv)));

        self.cur_lv:setString(level);
    else
        self.cur_atk:setVisible(false)
        self.cur_def:setVisible(false)
        self.cur_hp:setVisible(false)
    end

    local needCfg = TabDataMgr:getData("DiscreteData", 4002)
    local coinsNum = self.selectExp * needCfg.data.ratio / 10000

    self.Panel_gold:setVisible(self.selectExp > 0);
    self.Label_gold:setString(coinsNum);
    self.Label_gold:setFontColor(coinsNum>GoodsDataMgr:getItemCount(500001) and ccc3(219,50,50) or ccc3(255,255,255))
end

function EquipmentStrengthen:updateEquipInfo()
    if self.heroid then
        local heroCost      = HeroDataMgr:getCost(self.heroid) + HeroDataMgr:getNewEquipCost(self.heroid)
        local herCostMax    = HeroDataMgr:getCostMax(self.heroid);
        self.Label_cost:setString(heroCost.."/"..herCostMax);
    end

    local showCost = (self.heroid ~= nil)
    self.Label_cost_title:setVisible(showCost)
    self.Label_cost:setVisible(showCost)
    --self.Image_cast_di:setVisible(showCost)

    local name = EquipmentDataMgr:getEquipName(self.showId);
    self.Label_name:setString(name..EquipmentDataMgr:getStepText(self.showId));
    
    self.Label_level:setString(EquipmentDataMgr:getEquipLv(self.showId))


    local lv = EquipmentDataMgr:getEquipLv(self.showId);
    local maxLv      = EquipmentDataMgr:getEquipMaxLv(self.showId);
    self.Label_lv_tips:setString(lv.."/"..maxLv);

    local exp       = EquipmentDataMgr:getEquipCurExp(self.showId);
    local maxExp    = EquipmentDataMgr:getEquipCurNeedExp(self.showId);
    self.Label_exp:setString(exp.."/"..maxExp);




    local subType       = EquipmentDataMgr:getEquipSubType(self.showId);
    self.Image_type:setTexture(EC_EquipSubTypeIcon2[subType]);
    self.Image_type:Size(CCSizeMake(40,40));


    local halfPaint     = EquipmentDataMgr:getEquipPaint(self.showId);
    self.Image_equip:setTexture(halfPaint);

    local starLv        = EquipmentDataMgr:getEquipStarLv(self.showId);
    for i=1,5 do
        self["Image_star"..i]:setVisible(i <= starLv);
    end
    local starLevel = EquipmentDataMgr:getEquipStarLevel(self.showId)
    self.Image_stage1:setVisible(starLevel >= 1 and starLevel < 3)
    self.Image_stage2:setVisible(starLevel == 2)
    self.Image_stage3:setVisible(starLevel == 3)


    local quality       = EquipmentDataMgr:getEquipQuality(self.showId);
    self.Image_equip_back:setTexture(EC_EquipBoard[quality]);
    --self.Image_equip:Size(CCSizeMake(142,200))
    self.Image_equip:setScale(0.4)
    local equipCost     = EquipmentDataMgr:getEquipCost(self.showId);
    self.equip_cost:setString(equipCost);

    local percent       = EquipmentDataMgr:getEquipExpPercent(self.showId);
    
    -- self.LoadingBar_exp_add:setPercent(0);
    -- self.LoadingBar_exp_add:setVisible(self.selectExp > 0);
    if self.isMaxLevel then
        self.LoadingBar_exp:setPercent(100)
        self.Label_exp:setString("MAX");
    else
        if self.prePercent then
            self.LoadingBar_exp:setPercent(self.prePercent)
        else
            self.LoadingBar_exp:setPercent(0)
        end
        Utils:loadingBarAddAction(self.LoadingBar_exp,percent)
    end

    self.ListView_left:removeAllItems();
    local scroll_view = TFDirector:getChildByPath(self.GuYouItem,"scroll_view")
    local GuYouDescLabel = TFDirector:getChildByPath(self.GuYouItem,"Label_title");
    local inherentDesc = EquipmentDataMgr:getEquipInherentAttrDesc(self.showId);
    GuYouDescLabel:setTextById(inherentDesc);
    local scrollSize = scroll_view:getContentSize()
    local txtSize = GuYouDescLabel:getSize()
    local realHeight = scrollSize.height
    if txtSize.height > scrollSize.height then
        realHeight = txtSize.height
    end
    scroll_view:setInnerContainerSize(CCSize(scrollSize.width, realHeight))
    GuYouDescLabel:setPosition(ccp(0, realHeight))
    

    if EquipmentDataMgr:getIsHaveSpecialAttr(self.showId) then
        local specialAttrs = EquipmentDataMgr:getEquipSpecialAttrs(self.showId);
        for k,v in ipairs(specialAttrs) do
            local TeShuItem = self.TeShuItem:clone();
            local desc = TFDirector:getChildByPath(TeShuItem,"Label_title");
            desc:setString(v.desc);
            local Image_zhuangshi = TFDirector:getChildByPath(TeShuItem,"Image_zhuangshi");
            Image_zhuangshi:setTexture(EC_equip_Special_icon[v.level]);
            self.ListView_left:pushBackCustomItem(TeShuItem);
        end
    end

    --属性
    -- local isuse = EquipmentDataMgr:isUesing(self.showId);
    self.old_lv:setString(EquipmentDataMgr:getEquipLv(self.showId)); 
    self.cur_lv:setString(EquipmentDataMgr:getEquipLv(self.showId)); 
    self.old_atk:setString(EquipmentDataMgr:getEquipmentAttrById(self.showId, EC_Attr.ATK))
    self.old_def:setString(EquipmentDataMgr:getEquipmentAttrById(self.showId, EC_Attr.DEF))
    self.old_hp:setString(EquipmentDataMgr:getEquipmentAttrById(self.showId, EC_Attr.HP))
    
end

function EquipmentStrengthen:onTouchButtonDown()
    self:updateBatchPanel(-1)
end

function EquipmentStrengthen:onTouchButtonUp()
    self:updateBatchPanel(1)
end

function EquipmentStrengthen:holdDownAction(isAddOp)
    local speedTiming = 0
    local timing = 0
    local needTime = 0
    local entryFalg = false

    local function action(dt)
        timing = timing + dt
        speedTiming = speedTiming + dt
        if speedTiming >= 3.0 then
            entryFalg = true
            needTime = 0.01
        elseif speedTiming > 0.5 then
            entryFalg = true
            needTime = 0.05
        end
        if entryFalg and timing >= needTime then
            if isAddOp then
                self:onTouchButtonUp()
            else
                self:onTouchButtonDown()
            end
            timing = 0
        end
    end

    self.timer = TFDirector:addTimer(0, -1, nil, action)
end

function EquipmentStrengthen:registerEvents()
    EventMgr:addEventListener(self,EV_EQUIPMENT_OPERATION,handler(self.onEquipmentOperation, self));
    
	self.backBtn:onClick(function ()
            AlertManager:close();
    end)

    self.mainBtn:onClick(function()
    		AlertManager:changeScene(SceneType.MainScene);
    	end)

    self.changeBtn:onClick(function()
            self:onTouchChangeBtn();
        end)

    self.fastBtn:onClick(function()
            self:onTouchFastBtn();
        end)

    self.Button_ExpEquip:onClick(function()
        self:chooseEquipType(Enum_EquipType.Exp,true)
    end)

    self.Button_OtherEquip:onClick(function()
        self:chooseEquipType(Enum_EquipType.Normal,true)
    end)

    self.Button_up:onTouch(function(event)
        if event.name == "ended" then
            TFDirector:removeTimer(self.timer)
            self.timer = nil;
        end
        if event.name == "began" then
            TFAudio.playSound(Utils:getKVP(1001,"ui_clickSound"))
            self:onTouchButtonUp();
            self:holdDownAction(true)
        end
    end)

    self.Button_down:onTouch(function(event)
        if event.name == "ended" then
            TFDirector:removeTimer(self.timer)
            self.timer = nil;
        end
        if event.name == "began" then
            TFAudio.playSound(Utils:getKVP(1001,"ui_clickSound"))
            self:onTouchButtonDown()
            self:holdDownAction(false);
        end
    end)

    self.Button_max:onClick(function()

        local maxCnt = self:getMaxCnt()
        self.selectTab = {}
        self.selectExp = 0
        self.selectNum = 1
        self:updateBatchPanel(maxCnt)
    end)
end

function EquipmentStrengthen:getMaxCnt()
    local totalExp = 0
    local maxCnt = 0
    local num = EquipmentDataMgr:getEquipNum(self.selectExpItem.data.id)
    if num then
        for i=1,num do
            local item = self.selectExpItem.data.id
            if item then
                local isMaxLevel= EquipmentDataMgr:calcLevelUp(self.showId,totalExp);
                if not isMaxLevel then
                    maxCnt = maxCnt + 1
                end
                totalExp = totalExp + EquipmentDataMgr:getEquipTotalExp(item);
            end
        end
    end
    maxCnt = maxCnt == 0 and 1 or maxCnt
    return maxCnt
end

function EquipmentStrengthen:onTouchChangeBtn()

    local isMaxLevel = EquipmentDataMgr:calcLevelUp(self.showId,0);
    if isMaxLevel then
        toastMessage(TextDataMgr:getText(493009))
        return
    end
    
    local gold = GoodsDataMgr:getGold();
    local needCfg = TabDataMgr:getData("DiscreteData", 4002)
    if table.count(self.selectTab) <= 0 then
        toastMessage(TextDataMgr:getText(493001))
        return;
    elseif self.selectExp * needCfg.data.ratio / 10000 > gold then
        toastMessage(TextDataMgr:getText(493004))
        return;
    end

    self:showChangeBtnEffect()
    self.oldEquipLevel = EquipmentDataMgr:getEquipLv(self.showId)
    EquipmentDataMgr:equipLevelUp(self.showId,self.selectTab);
end

function EquipmentStrengthen:showChangeBtnEffect()
    local effect = TFDirector:getChildByPath(self.changeBtn,"Spine_clickStrengthen")
    effect:playByIndex(0, -1, -1, 0)
end

function EquipmentStrengthen:onTouchFastBtn()
    local isHave = false
    for i=1,#self.allItems do
        local item = self.allItems[i];
        if EquipmentDataMgr:getEquipStarLv(item.data.id) < 4 then
            isHave = true
            local level ,curPercent;
            self.isMaxLevel,level,curPercent = EquipmentDataMgr:calcLevelUp(self.showId,self.selectExp);
            if not item.selectImg:isVisible() and not self.isMaxLevel then
                item.selectImg:setVisible(true)

                if item.data.merge then
                    local totalExp = 0
                    for k,v in ipairs(item.data.merge) do
                        totalExp = totalExp + EquipmentDataMgr:getEquipTotalExp(v);
                        table.insert(self.selectTab,v);
                    end
                    self.selectExp = self.selectExp + totalExp
                else
                    self.selectExp = self.selectExp + EquipmentDataMgr:getEquipTotalExp(item.data.id);
                    table.insert(self.selectTab,item.data.id);
                end
            end
        end
    end
    if not isHave then
        Utils:showTips(493010)
    end

    self:updateAttrInfo();
end

function EquipmentStrengthen:onHide()
	self.super.onHide(self)
end

function EquipmentStrengthen:removeUI()
	self.super.removeUI(self)
end

function EquipmentStrengthen:onEquipmentOperation(...)


    self:chooseEquipType( self.chooseType)

    self:updateEquipInfo();
    self:updateAttrInfo();
    local temp = {...}
    local arg = select("1", temp) 
    local nowLevel = EquipmentDataMgr:getEquipLv(self.showId)
    if nowLevel ~= self.oldEquipLevel then
        if arg[2] then
            Utils:playSound(1002)
            self:showLevelupEffect()
        end
    end
end

function EquipmentStrengthen:showLevelupEffect()
    local effect = TFDirector:getChildByPath(self.leftPanel,"Spine_levelUp")
    effect:playByIndex(0, -1, -1, 0)
    local showFunc = CallFunc:create(function() 
        local effectBig = TFDirector:getChildByPath(self.leftPanel,"Spine_EquipEffect")
        effectBig:playByIndex(0, -1, -1, 0)
        
    end)
    local delay = CCDelayTime:create(0.3)
    local seq = Sequence:createWithTwoActions(delay, showFunc)
    self:runAction(seq)
    self.Spine_level_up_tip:show()
    self.Spine_level_up_tip:play("chuxian",false)
	self.Spine_level_up_tip:addMEListener(TFARMATURE_COMPLETE,function()
		self:timeOut(function()
			self.Spine_level_up_tip:removeMEListener(TFARMATURE_COMPLETE)
			self.Spine_level_up_tip:play("xunhuan",true)
			self:timeOut(function()
				self.Spine_level_up_tip:hide()
			end, 1)
		end, 0)
	end)
end

function EquipmentStrengthen:onShow()
   self.super.onShow(self)
end

return EquipmentStrengthen;