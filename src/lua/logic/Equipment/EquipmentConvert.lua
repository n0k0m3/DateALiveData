local EquipConvert = class("EquipConvert", BaseLayer)


function EquipConvert:ctor(data)
    self.super.ctor(self,data)
    self.showList,self.equipCnt = EquipmentDataMgr:initShowListByConvert(data.equipmentId);
    self.curList = self.showList
    self.curCnt = self.equipCnt
    self.showId   = data.equipmentId;
    self.chooseCondition = {star = {},suit = {},color = {},word = {}}
    dump(EquipmentDataMgr:getEquipCid(self.showId))
    self.heroid   = data.heroid;
    self.selectId = nil;
    self.attrIdx   = nil;
    self.heroid = data.heroid;
    self.pos    = data.pos;
    self.rightItems = {};
    self.loadedIndex_ = 1
    self:init("lua.uiconfig.Equip.EquipConvert")
   
    self:showTopBar();
end

function EquipConvert:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	EquipConvert.ui = ui

	self.backBtn		= TFDirector:getChildByPath(ui,"Button_back");
	self.mainBtn		= TFDirector:getChildByPath(ui,"Button_main");
    self.changeBtn      = TFDirector:getChildByPath(ui,"Button_change");
    self.fastBtn        = TFDirector:getChildByPath(ui,"Button_fast");
    self.Panel_gold     = TFDirector:getChildByPath(ui,"Panel_gold");
    self.Label_gold     = TFDirector:getChildByPath(ui,"Label_gold");
    self.Image_gold     = TFDirector:getChildByPath(ui,"Image_gold");
    self.Label_nothing    = TFDirector:getChildByPath(ui,"Label_nothing");

    self.Panel_gold:setVisible(false);

    self.Label_cost     = TFDirector:getChildByPath(ui,"Label_cost");
    self.Label_cost_title = TFDirector:getChildByPath(ui,"Label_cost_title")
    self.Image_cast_di  = TFDirector:getChildByPath(ui,"Image_cast_di");

    local ScrollView_Right  = TFDirector:getChildByPath(ui,"ScrollView_right");
    self.ListView_right     = UIListView:create(ScrollView_Right);
    self.rightItem          = TFDirector:getChildByPath(ui,"Panel_item");

    --装备信息界面
    self.leftPanel                    = TFDirector:getChildByPath(ui,"Panel_left_1");
    self.leftPanel.Image_equip_back   = TFDirector:getChildByPath(self.leftPanel,"Image_equip_back");
    self.leftPanel.Image_frame   = TFDirector:getChildByPath(self.leftPanel,"Image_frame");                 
    self.leftPanel.Image_equip        = TFDirector:getChildByPath(self.leftPanel,"Image_Equip");
    self.leftPanel.Image_type         = TFDirector:getChildByPath(self.leftPanel,"Image_type");

    self.Panel_bottom         = TFDirector:getChildByPath(ui,"Panel_bottom")
    self.leftPanel.Label_cost         = TFDirector:getChildByPath(self.Panel_bottom,"Label_cost");
    self.leftPanel.equip_cost         = TFDirector:getChildByPath(self.leftPanel,"equip_cost");
    self.leftPanel.Image_star1        = TFDirector:getChildByPath(self.leftPanel,"Image_star1");
    self.leftPanel.Image_star2        = TFDirector:getChildByPath(self.leftPanel,"Image_star2");
    self.leftPanel.Image_star3        = TFDirector:getChildByPath(self.leftPanel,"Image_star3");
    self.leftPanel.Image_star4        = TFDirector:getChildByPath(self.leftPanel,"Image_star4");
    self.leftPanel.Image_star5        = TFDirector:getChildByPath(self.leftPanel,"Image_star5");
    self.leftPanel.Panel_star        = TFDirector:getChildByPath(self.leftPanel,"Panel_star");
    self.leftPanel.Image_stage1        = TFDirector:getChildByPath(self.leftPanel,"Image_stage1");
    self.leftPanel.Image_stage2        = TFDirector:getChildByPath(self.leftPanel,"Image_stage2");
    self.leftPanel.Image_stage3        = TFDirector:getChildByPath(self.leftPanel,"Image_stage3");
    self.leftPanel.listView           = TFDirector:getChildByPath(self.leftPanel,"ScrollView_EquipSelectLayer_1");
    self.leftPanel.listView           = UIListView:create(self.leftPanel.listView);
    self.leftPanel.item               = TFDirector:getChildByPath(ui,"Panel_item_cur");
    self.leftPanel.Label_level_title         = TFDirector:getChildByPath(self.leftPanel,"Label_level_title")
    self.leftPanel.Label_level         = TFDirector:getChildByPath(self.leftPanel,"Label_level")

    
    self.rightPanel                    = TFDirector:getChildByPath(ui,"Panel_left_2");
    self.rightPanel.Image_equip_back   = TFDirector:getChildByPath(self.rightPanel,"Image_equip_back")
    self.rightPanel.Image_frame   = TFDirector:getChildByPath(self.rightPanel,"Image_frame"); 
    self.rightPanel.Image_equip        = TFDirector:getChildByPath(self.rightPanel,"Image_Equip");
    self.rightPanel.Image_type         = TFDirector:getChildByPath(self.rightPanel,"Image_type");
    self.rightPanel.Label_cost         = TFDirector:getChildByPath(self.rightPanel,"Label_cost");
    self.rightPanel.equip_cost         = TFDirector:getChildByPath(self.rightPanel,"equip_cost");
    self.rightPanel.Image_star1        = TFDirector:getChildByPath(self.rightPanel,"Image_star1");
    self.rightPanel.Image_star2        = TFDirector:getChildByPath(self.rightPanel,"Image_star2");
    self.rightPanel.Image_star3        = TFDirector:getChildByPath(self.rightPanel,"Image_star3");
    self.rightPanel.Image_star4        = TFDirector:getChildByPath(self.rightPanel,"Image_star4");
    self.rightPanel.Image_star5        = TFDirector:getChildByPath(self.rightPanel,"Image_star5");
    self.rightPanel.Panel_star        = TFDirector:getChildByPath(self.rightPanel,"Panel_star");
    self.rightPanel.Image_stage1        = TFDirector:getChildByPath(self.rightPanel,"Image_stage1");
    self.rightPanel.Image_stage2        = TFDirector:getChildByPath(self.rightPanel,"Image_stage2");
    self.rightPanel.Image_stage3        = TFDirector:getChildByPath(self.rightPanel,"Image_stage3");
    self.rightPanel.listView           = TFDirector:getChildByPath(self.rightPanel,"ScrollView_EquipSelectLayer_1");
    self.rightPanel.listView           = UIListView:create(self.rightPanel.listView);
    self.rightPanel.panel_info         = TFDirector:getChildByPath(self.rightPanel,"panel_info");
    self.rightPanel.item               = TFDirector:getChildByPath(ui,"Panel_item_cll");
    self.rightPanel.Label_level_title         = TFDirector:getChildByPath(self.rightPanel,"Label_level_title")
    self.rightPanel.Label_level         = TFDirector:getChildByPath(self.rightPanel,"Label_level")

    self.Button_choose = TFDirector:getChildByPath(ui,"Button_choose"):hide()

    self.LvLabel                       = TFDirector:getChildByPath(ui,"old_lv");
    self.hpLabel                       = TFDirector:getChildByPath(ui,"old_hp");
    self.atkLabel                      = TFDirector:getChildByPath(ui,"old_atk");
    self.defLabel                      = TFDirector:getChildByPath(ui,"old_def");

    self:loadEquipMent();
    self:updateLeftEquipInfo();
    self:updateRightEquipInfo()


    --self:showTipsLayer();
    --self:selectAction(1);
    
    local Panel_right = TFDirector:getChildByPath(ui,"Panel_right")
    local Panel_comb = TFDirector:getChildByPath(ui,"Panel_comb")
    ViewAnimationHelper.doMoveFadeInAction(self.leftPanel, {direction = 2, distance = 30, time = 0.2, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(self.Panel_bottom, {direction = 2, distance = 30, time = 0.2, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(Panel_comb, {direction = 2, distance = 30, time = 0.2, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(Panel_right, {direction = 2, distance = 10, time = 0.1, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(self.changeBtn, {direction = 2, distance = 10, time = 0.1, ease = 1})
end

function EquipConvert:loadEquipMent()
    local loadedIndex = self.loadedIndex_
    if loadedIndex <= 1 then
        self.ListView_right:removeAllItems()
    end
    self.Label_nothing:setVisible(self.curCnt < 1)
    if loadedIndex > #self.curList then
        return 
    end
    local count  = self.curCnt - ((loadedIndex - 1) * 4)

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
            local id = self.curList[loadedIndex][i]
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

function EquipConvert:updateOneEquipment(id,item)
    local starLv = EquipmentDataMgr:getEquipStarLv(id);
    local quality = EquipmentDataMgr:getEquipQuality(id);

    local Image_level_bg = TFDirector:getChildByPath(item,"Image_level_bg")
    local Label_lv_title = TFDirector:getChildByPath(item,"Label_lv_title")
    local LvLabel = TFDirector:getChildByPath(item,"Label_lv");
    Image_level_bg:setTexture(EC_ItemLevelIcon[quality])
    Label_lv_title:setString("Lv.")
    LvLabel:setString(EquipmentDataMgr:getEquipLv(id));

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
            self:onTouchOneEquip(item);
        end)
end

function EquipConvert:onTouchOneEquip(item)
    if self.doing then
        return;
    end
    
    local callback = function()
        if self.selectImg then
            self.selectImg:setVisible(false);
        end

        item.selectImg:setVisible(true)
        self.selectImg = item.selectImg;

        self:showLeftEquipInfo()

        self.selectId = item.id;
        self:updateNeedGold();
        self:updateRightEquipInfo();
    end

    self.isChoiceSpecial = not (EquipmentDataMgr:getEquipStarLevel(item.id) < 1)
    if EquipmentDataMgr:getEquipStarLv(item.id) > 1 and (not MainPlayer:getOneLoginStatus(EC_OneLoginStatusType.ReConfirm_EquipConvert)) then
        local view = Utils:openView("common.ConfirmConvertView")

        -- if self.isChoiceSpecial then
        --     view:setRecoverTipsShow()
        -- elseif EquipmentDataMgr:getEquipStarLv(item.id) >= 5 then
        --     view:setGoodTipsShow()
        -- end
        
        -- TODO CLOSE
        -- 还原为旧的质点提示
        if EquipmentDataMgr:getEquipStarLv(item.id) >= 5 then
            view:setGoodTipsShow()
        end

        view:setCallback(function()
                callback()
        end)
    else
        callback()
    end

end

function EquipConvert:updateNeedGold()
    self.Panel_gold:setVisible(self.showId ~= nil);
    if self.showId then
        local star = EquipmentDataMgr:getEquipStarLv(self.showId);
        -- local needGold = TabDataMgr:getData("DiscreteData",4001).data.price[star][500001];
        local attrIdxs = self:getSelectDestAttrIndexs()
        local num      = #attrIdxs
        local id, needGold = next(EquipmentDataMgr:getXilianNeedGold(star,num, self.isChoiceSpecial))
        --needGold = needGold * star;
        if num == 0 then
            needGold = 0
        end
        self.Image_gold:setTexture(GoodsDataMgr:getItemCfg(id).icon)
        self.Image_gold:setTouchEnabled(true)
        self.Image_gold:onClick(function ()
                Utils:showInfo(id)
            end)
        self.Label_gold:setString(needGold.."");
        self.Label_gold:setFontColor(needGold>GoodsDataMgr:getItemCount(id) and ccc3(219,50,50) or ccc3(255,255,255))
    end
end

function EquipConvert:updateArrows()
    local destAttrIndexs = self:getSelectDestAttrIndexs()
    local srcAttrIndexs  = self:getSelectSrcAttrIndexs()
    local Image_arrow = TFDirector:getChildByPath(self.ui, "Image_arrow")
    local Spine_Equal = Image_arrow:getChildByName("Spine_Equal")
    if #destAttrIndexs < #srcAttrIndexs then
        Image_arrow:setTexture("ui/Equipment/new_ui/new_42.png")
        Spine_Equal:setVisible(false)
    elseif #destAttrIndexs > #srcAttrIndexs then
        Image_arrow:setTexture("ui/Equipment/new_ui/rightArrow.png")
        Spine_Equal:setVisible(false)
    elseif #destAttrIndexs == #srcAttrIndexs and (#destAttrIndexs ~= 0) then
        Image_arrow:setTexture("")
        Spine_Equal:setVisible(true)
    end
end

function EquipConvert:updateLeftEquipInfo()

    if self.heroid then
        local heroCost      = HeroDataMgr:getCost(self.heroid) + HeroDataMgr:getNewEquipCost(self.heroid)
        local herCostMax    = HeroDataMgr:getCostMax(self.heroid);
        self.Label_cost:setString(heroCost.."/"..herCostMax);
    end

    if not self.selectId then
        self:resetLeftEquipInfo();
    end

    local showcost = (self.heroid ~= nil)
    self.Label_cost:setVisible(showcost)
    self.Label_cost_title:setVisible(showcost)
    self.Image_cast_di:setVisible(showcost)

    local subType       = EquipmentDataMgr:getEquipSubType(self.showId);
    self.leftPanel.Image_type:setTexture(EC_EquipSubTypeIconBag[subType]);

    local halfPaint     = EquipmentDataMgr:getEquipHalfPaint(self.showId);
    self.leftPanel.Image_equip:setTexture(halfPaint);
    -- self.leftPanel.Image_equip:Size(CCSizeMake(160,200));
    self.leftPanel.Image_equip:Size(CCSizeMake(142,200));
    --self.leftPanel.Image_equip:setPosition(ccp(150,305));

    local starLv        = EquipmentDataMgr:getEquipStarLv(self.showId);
    local quality       = EquipmentDataMgr:getEquipQuality(self.showId);
    for i=1,5 do
        self.leftPanel["Image_star"..i]:setVisible(i <= starLv);
    end

    local starLevel = EquipmentDataMgr:getEquipStarLevel(self.showId)
    if starLevel >= 1 and starLevel < 2 then
        self.leftPanel["Panel_star"]:setScale(0.88)
    elseif starLevel >= 2 then
        self.leftPanel["Panel_star"]:setScale(0.8)
    else
        self.leftPanel["Panel_star"]:setScale(1.0)
    end
    self.leftPanel["Image_stage1"]:setVisible(starLevel >= 1 and starLevel <= 2)
    self.leftPanel["Image_stage2"]:setVisible(starLevel == 2)
    self.leftPanel["Image_stage3"]:setVisible(starLevel == 3)

    self.leftPanel.Image_equip_back:setTexture(EC_EquipBoard[quality]);
    self.leftPanel.Image_frame:setTexture(EC_EquipFrame[quality])
    --self.leftPanel.Image_equip_back:setSize(CCSizeMake(170,210));

    local equipCost     = EquipmentDataMgr:getEquipCost(self.showId);
    self.leftPanel.equip_cost:setString(equipCost);
    self.leftPanel.Label_level_title:setString("Lv.")
    self.leftPanel.Label_level:setString(EquipmentDataMgr:getEquipLv(self.showId));


    self.leftPanel.listView:removeAllItems();

    local selectImg,selectDesc;
    if EquipmentDataMgr:getIsHaveSpecialAttr(self.showId) then
        self.orgSpecialAttrs = EquipmentDataMgr:getEquipSpecialAttrs(self.showId);
        for k,v in ipairs(self.orgSpecialAttrs) do
            local TeShuItem = self.leftPanel.item:clone();
            local desc = TFDirector:getChildByPath(TeShuItem,"desc");
            desc:setString(v.desc);
            local zhuangshi = TFDirector:getChildByPath(TeShuItem,"Image_zhuangshi");
            zhuangshi:setTexture(EC_equip_Special_icon[v.level])
            self.leftPanel.listView:pushBackCustomItem(TeShuItem);


            TeShuItem:setTouchEnabled(true);
            TeShuItem:onClick(function ( )
                    if self.doing then
                        return
                    end 
                    local img = TFDirector:getChildByPath(TeShuItem,"Image_select")
                    local isSelect = not img:isVisible()

                    -- if selectImg then
                    --     selectImg:setVisible(false);
                    -- end

                    -- if selectDesc then
                    --     selectDesc:setColor(ccc3(0,0,0));
                    -- end

                    -- selectImg = :show();

                    img:setVisible(isSelect)

                    selectDesc = TFDirector:getChildByPath(TeShuItem,"desc");
                    --selectDesc:setColor(isSelect and ccc3(235,57,110) or ccc3(0,0,0));
                    self.attrIdx = k;

                    TeShuItem.select = isSelect

                    local specialAttrs = EquipmentDataMgr:getEquipSpecialAttrs(self.showId);
                    local cid = EquipmentDataMgr:getEquipCid(self.showId)
                    dump(cid)
                    dump(specialAttrs)

                    self:updateNeedGold()
                    self:updateArrows()
            end) 
        end
    end
end

function EquipConvert:getSelectDestAttrIndexs()
    local orgSpecialAttrs = EquipmentDataMgr:getEquipSpecialAttrs(self.showId);
    -- dump(orgSpecialAttrs)
    local items = self.leftPanel.listView:getItems()
    local idxs  = {}
    for i, item in ipairs(items) do
        if true == item.select then
            table.insert(idxs, orgSpecialAttrs[i].index)
        end
    end
    return idxs
end

function EquipConvert:getSelectSrcAttrIndexs()
    local idxs  = {}
    if self.selectId then
        local oldSpecialAttrs = EquipmentDataMgr:getEquipSpecialAttrs(self.selectId);
        -- dump(oldSpecialAttrs)
        local items = self.rightPanel.listView:getItems()
        for i, item in ipairs(items) do
            if true == item.select then
                table.insert(idxs, oldSpecialAttrs[i].index)
            end
        end
    end
    return idxs
end

function EquipConvert:resetRightEquipInfo()
    self.rightPanel.panel_info:setVisible(false);
    self.rightPanel.listView:removeAllItems();

    self.LvLabel:setString(0); 
    self.hpLabel:setString(0); 
    self.atkLabel:setString(0);
    self.defLabel:setString(0);
end

function EquipConvert:resetLeftEquipInfo()
    local Label_EquipConvert_1 = TFDirector:getChildByPath(self.ui,"Label_EquipConvert_1");
    Label_EquipConvert_1:setVisible(false)
    local Image_arrow = TFDirector:getChildByPath(self.ui,"Image_arrow");
    Image_arrow:setVisible(false)
    local Image_arrowBig = TFDirector:getChildByPath(self.ui,"Image_arrowBig");
    Image_arrowBig:setVisible(false)
end

function EquipConvert:showLeftEquipInfo()
    local Label_EquipConvert_1 = TFDirector:getChildByPath(self.ui,"Label_EquipConvert_1");
    Label_EquipConvert_1:setVisible(true)
    local Image_arrow = TFDirector:getChildByPath(self.ui,"Image_arrow");
    Image_arrow:setVisible(true)
    local Image_arrowBig = TFDirector:getChildByPath(self.ui,"Image_arrowBig");
    Image_arrowBig:setVisible(true)
    if not self.selectId then
        self.leftPanel:runAction(CCMoveTo:create(0.2,ccp(6,81)))
    end
end

function EquipConvert:updateRightEquipInfo()
    if not self.selectId then
        self:resetRightEquipInfo();
        return;
    end
    self.rightPanel.panel_info:setVisible(true);
    local subType       = EquipmentDataMgr:getEquipSubType(self.selectId);
    self.rightPanel.Image_type:setTexture(EC_EquipSubTypeIconBag[subType]);

    local halfPaint     = EquipmentDataMgr:getEquipHalfPaint(self.selectId);
    self.rightPanel.Image_equip:setTexture(halfPaint);
    --self.rightPanel.Image_equip:Size(CCSizeMake(140,180));
    self.rightPanel.Image_equip:Size(CCSizeMake(142,200));
    --self.rightPanel.Image_equip:setPosition(ccp(150,305));

    local starLv        = EquipmentDataMgr:getEquipStarLv(self.selectId);
    local quality       = EquipmentDataMgr:getEquipQuality(self.selectId);
    for i=1,5 do
        self.rightPanel["Image_star"..i]:setVisible(i <= starLv);
    end
    local starLevel = EquipmentDataMgr:getEquipStarLevel(self.selectId)
    if starLevel >= 1 and starLevel < 2 then
        self.rightPanel["Panel_star"]:setScale(0.88)
    elseif starLevel >= 2 then
        self.rightPanel["Panel_star"]:setScale(0.8)
    else
        self.rightPanel["Panel_star"]:setScale(1.0)
    end
    self.rightPanel["Image_stage1"]:setVisible(starLevel >= 1 and starLevel <= 2)
    self.rightPanel["Image_stage2"]:setVisible(starLevel == 2)
    self.rightPanel["Image_stage3"]:setVisible(starLevel == 3)
    self.rightPanel.Image_equip_back:setTexture(EC_EquipBoard[quality]);
    self.rightPanel.Image_frame:setTexture(EC_EquipFrame[quality])
    --self.rightPanel.Image_equip_back:setSize(CCSizeMake(151,192));

    local equipCost     = EquipmentDataMgr:getEquipCost(self.selectId);
    self.rightPanel.equip_cost:setString(equipCost);
    self.rightPanel.Label_level_title:setString("Lv.")
    self.rightPanel.Label_level:setString(EquipmentDataMgr:getEquipLv(self.selectId));


    self.rightPanel.listView:removeAllItems();

    self.LvLabel:setString(EquipmentDataMgr:getEquipLv(self.selectId)); 
    self.hpLabel:setString(EquipmentDataMgr:getEquipmentAttrById(self.selectId, EC_Attr.HP))
    self.atkLabel:setString(EquipmentDataMgr:getEquipmentAttrById(self.selectId, EC_Attr.ATK))
    self.defLabel:setString(EquipmentDataMgr:getEquipmentAttrById(self.selectId, EC_Attr.DEF))

    local selectImg;
    self.rightItems = {};
    if EquipmentDataMgr:getIsHaveSpecialAttr(self.selectId) then
        local specialAttrs = EquipmentDataMgr:getEquipSpecialAttrs(self.selectId);
        dump(specialAttrs);
        for k,v in ipairs(specialAttrs) do
            local TeShuItem = self.rightPanel.item:clone();
            local desc = TFDirector:getChildByPath(TeShuItem,"desc");
            desc:setString(v.desc);
            local Image_zhuanshi = TFDirector:getChildByPath(TeShuItem,"Image_zhuangshi");
            Image_zhuanshi:setTexture(EC_equip_Special_icon[v.level]); 
            
            self.rightPanel.listView:pushBackCustomItem(TeShuItem);

            TeShuItem.Image_select = TFDirector:getChildByPath(TeShuItem,"Image_select");
            TeShuItem.desc = desc;
            table.insert(self.rightItems,TeShuItem);

            TeShuItem:setTouchEnabled(true);
            TeShuItem:onClick(function ( )
                    if self.doing then
                        return
                    end 
                    local img = TFDirector:getChildByPath(TeShuItem,"Image_select")
                    local isSelect = not img:isVisible()

                    img:setVisible(isSelect)

                    local selectDesc = TFDirector:getChildByPath(TeShuItem,"desc");
                    --selectDesc:setColor(isSelect and ccc3(235,57,110) or ccc3(0,0,0));

                    TeShuItem.select = isSelect

                    local specialAttrs = EquipmentDataMgr:getEquipSpecialAttrs(self.selectId);
                    local cid = EquipmentDataMgr:getEquipCid(self.selectId)
                    dump(cid)
                    dump(specialAttrs)
                    self:updateArrows()
            end) 
        end
    end

    
    
end

function EquipConvert:updateShowData()
    local newList = {}
    local newCount = {}
    for i, v in ipairs(self.showList) do
        for j, id in ipairs(v) do
            local isRevert = self.chooseCondition.isRevert
            local starState = isRevert
            local suitState = isRevert
            local colorState = isRevert
            if #self.chooseCondition.star > 0 then
                if (table.indexOf(self.chooseCondition.star, EquipmentDataMgr:getEquipStarLv(id)) ~= -1 and EquipmentDataMgr:getEquipStarLevel(id) < 1 ) or (table.indexOf(self.chooseCondition.star, 6) ~= -1 and EquipmentDataMgr:getEquipStarLevel(id) >= 1 ) then
                    starState = not isRevert
                end
            else
                starState = true
            end
            if #self.chooseCondition.suit > 0 then
                local suitIds = #EquipmentDataMgr:getEquipSuitInfo(id)
                if #self.chooseCondition.suit > 1 or (suitIds > 0 and self.chooseCondition.suit[1] == 2) or (suitIds < 1 and self.chooseCondition.suit[1] == 1) then
                    suitState = not isRevert
                end
            else
                suitState = true
            end
            local attrs = EquipmentDataMgr:getEquipSpecialAttrs(id)
            if #self.chooseCondition.color > 0 then
                for k, attr in pairs(attrs) do
                    if table.indexOf(self.chooseCondition.color, attr.level) ~= -1 then
                        if #self.chooseCondition.word > 0 then
                            if table.indexOf(self.chooseCondition.word,attr._superType) ~= -1 then
                                colorState = not isRevert
                                break
                            end
                        else
                            colorState = not isRevert
                            break
                        end
                    end
                end
            else
                if #self.chooseCondition.word > 0 then
                    for k, attr in pairs(attrs) do
                        if table.indexOf(self.chooseCondition.word,attr._superType) ~= -1 then
                            colorState = not isRevert
                            break
                        end
                    end
                else
                    colorState = true
                end
            end
            if starState and suitState and colorState then
                table.insert(newList, id)
            end
        end
    end
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
    self.curList,self.curCnt = Grouping(newList)
    self.loadedIndex_ = 1
    self:resetRightEquipInfo()
    self:loadEquipMent()
    self:updateLeftEquipInfo()
end

function EquipConvert:onChooseCondition(data)
    self.chooseCondition = data
    self.attrIdx = nil;
    self.selectId = nil;
    self.oldSpecialAttrs = nil;
    self.selectImg = nil;
    self.doing = false;
    self:updateShowData()
    self.leftPanel:runAction(CCMoveTo:create(0.2,ccp(156,81)))
end

function EquipConvert:registerEvents()
    EventMgr:addEventListener(self,EQUIPMENT_CHANGE_SPECIAL_ATTR,handler(self.onEquipmentOperation, self));
    EventMgr:addEventListener(self,EQUIPMENT_REPLACE_SPECIAL_ATTR,handler(self.onEquipmentConvertOK, self));
    EventMgr:addEventListener(self,EQUIPMENT_CONVERT_CHOOSE_CONDITION,handler(self.onChooseCondition, self))

	self.backBtn:onClick(function ()
            AlertManager:close();
    end)

    self.mainBtn:onClick(function()
    		AlertManager:changeScene(SceneType.MainScene);
    	end)

    self.changeBtn:onClick(function()
            self:onTouchChangeBtn();
        end)

    self.Button_choose:onClick(function ()
        Utils:openView("Equipment.EquipConvertChooseCondition")
    end)
end

function EquipConvert:onTouchChangeBtn()
    if self.doing == true then
        return;
    end
    if not self.selectId then
        toastMessage(TextDataMgr:getText(493001))
        return;
    end

    self.destAttrIndexs = self:getSelectDestAttrIndexs()
    self.srcAttrIndexs  = self:getSelectSrcAttrIndexs()

    if #self.destAttrIndexs <= 0 then
        toastMessage(TextDataMgr:getText(493002))
        return;
    elseif #self.destAttrIndexs ~= #self.srcAttrIndexs then
        toastMessage(TextDataMgr:getText(493003))
        return;
    end

    local star = EquipmentDataMgr:getEquipStarLv(self.showId);

    local id, needGold = next(EquipmentDataMgr:getXilianNeedGold(star, #self.destAttrIndexs, self.isChoiceSpecial))
    local goldCount = GoodsDataMgr:getItemCount(id);
    if needGold > goldCount then
        toastMessage(TextDataMgr:getText(493011));
        return;
    end

    self.doing = true;
    self.oldSpecialAttrs = EquipmentDataMgr:getEquipSpecialAttrs(self.selectId);

    self.allAttrs = EquipmentDataMgr:getEquipSpecialAttrs(self.showId)
    self.allNewAttrs = EquipmentDataMgr:getEquipSpecialAttrs(self.selectId)

    self.oldAttrs = self:getChangeOldAttrs(self.showId)
    self.newAttrs = self:getChangeNewAttrs(self.selectId)

    EquipmentDataMgr:equipConvert(self.showId,self.destAttrIndexs,self.selectId,self.srcAttrIndexs);
end

function EquipConvert:getChangeOldAttrs()
    local orgSpecialAttrs = EquipmentDataMgr:getEquipSpecialAttrs(self.showId);
    local attrs = {}    
    for i, v in ipairs(self.destAttrIndexs) do
        for i2, v2 in ipairs(orgSpecialAttrs) do
            if v == v2.index then
                table.insert(attrs, v2)
                break
            end
        end
    end
    return attrs
end

function EquipConvert:getChangeNewAttrs()
    local specialAttrs = EquipmentDataMgr:getEquipSpecialAttrs(self.selectId);
    local attrs = {}    
    for i, v in ipairs(self.srcAttrIndexs) do
        for i2, v2 in ipairs(specialAttrs) do
            if v == v2.index then
                table.insert(attrs, v2)
                break
            end
        end
    end
    return attrs
end

function EquipConvert:onHide()
	self.super.onHide(self)
end

function EquipConvert:removeUI()
	self.super.removeUI(self)
end

function EquipConvert:onEquipmentOperation(data)
    self.changeData = data;
    --self:showTipsLayer();
    -- local attrIdx = 0
    -- for k,v in pairs(self.oldSpecialAttrs) do
    --     if v.index == self.changeData.attrIndexInCostEquipment then
    --         attrIdx = k;
    --     end
    -- end

    -- self:selectAction(attrIdx);

    self:showTipsLayer();
end

function EquipConvert:showTipsLayer()
    local function okCallfunc(isok)
        print("local function okCallfunc()")
        self.doing = false;
        EquipmentDataMgr:equipConvertOK(self.showId,isok)
    end

    local newData;
    for k,v in pairs(self.oldSpecialAttrs) do
        if v.index == self.changeData.attrIndexInCostEquipment then
            newData = v;
            break;
        end
    end

    local actions = {
    CCDelayTime:create(0.2),
    CCCallFunc:create(function()
            local layer = require("lua.logic.Equipment.EquipConvertTips"):new({oldData = self.oldAttrs,newData = self.newAttrs,
                oldAllData = self.allAttrs, newAllData = self.allNewAttrs, okCallFunc = okCallfunc, showid = self.selectId});
            AlertManager:addLayer(layer)
            AlertManager:show()
            EquipmentDataMgr:equipConvertConfirm(self.changeData)
        end)
    }


    self:runAction(Sequence:create(actions));
end

function EquipConvert:onEquipmentConvertOK(data)
    EventMgr:dispatchEvent(EV_EQUIPMENT_OPERATION,self.showId,true,{self.selectId});
    self.attrIdx = nil;
    self.selectId = nil;
    self.oldSpecialAttrs = nil;
    self.selectImg = nil;
    self.doing = false;
    self.showList,self.equipCnt = EquipmentDataMgr:initShowListByConvert(self.showId);
    self.curList = self.showList
    self.curCnt = self.equipCnt
    self:updateShowData()
    self:updateNeedGold();
    self.leftPanel:runAction(CCMoveTo:create(0.2,ccp(156,81)))
    if data.success then
        Utils:playSound(1003) 
        self:showConvertEffect()
    end
end

function EquipConvert:showConvertEffect()
   local effectLight = TFDirector:getChildByPath(self.leftPanel, "Spine_convert") 
   effectLight:playByIndex(0, -1, -1, 0)
   local effectWords = TFDirector:getChildByPath(self.ui, "Spine_complete") 
   effectWords:setVisible(true)
   effectWords:playByIndex(0, -1, -1, 0)
   effectWords:addMEListener(TFARMATURE_COMPLETE,function(_skeletonNode)
        _skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
        _skeletonNode:setVisible(false)
    end)
end
function EquipConvert:selectAction(idx)
    local  timetab = {}
    local total = #self.rightItems * 2 + idx;
    local itemCnt = #self.rightItems;
    local delay = 1.5;
    timetab.run1 = total * 0.4;
    timetab.run2 = total * 0.3;
    timetab.run3 = total * 0.2;
    timetab.run4 = total * 0.1;
    timetab.run1time = delay / 4 / timetab.run1
    timetab.run2time = delay / 4 / timetab.run2
    timetab.run3time = delay / 4 / timetab.run3
    timetab.run4time = delay / 4 / timetab.run4

    local time = 0
    local totime = timetab.run1time;
    local idx = 0;
    local timeIndex = 1;
    local Image_select,desc;
    local function delayToGame(dt)
        time = time + dt;
        if time >= totime then
            local index = idx % itemCnt;
            if index == 0 then index = itemCnt end
            if Image_select then
                Image_select:hide()
                desc:setColor(ccc3(0,0,0));
            end
            Image_select = self.rightItems[index].Image_select:show();
            desc         = self.rightItems[index].desc;
            desc:setColor(ccc3(235,57,110));

            idx = idx + 1;
            if idx > total then
                self:showTipsLayer();
                TFDirector:removeTimer(self.timer)
                self.timer = nil
            end

            local function calcNums(timeIndex)
                local  total = 0
                if timeIndex > 0 then
                    for i=1,timeIndex do
                        if i <= timeIndex then
                            total = total + timetab["run"..i]
                        end
                    end
                end

                return total;
            end

            if idx > timetab["run"..timeIndex] +  calcNums(timeIndex - 1) then
                timeIndex = timeIndex + 1;
                if timeIndex >= 4 then
                    timeIndex = 4;
                end
                totime = timetab["run"..timeIndex.."time"]
            end
            time = 0; 
        end
    end
    self.timer = TFDirector:addTimer(0, -1, nil, delayToGame)
end


return EquipConvert;