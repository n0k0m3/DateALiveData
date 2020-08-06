local EquipmentRecycle = class("EquipmentRecycle", BaseLayer)


function EquipmentRecycle:ctor(data)
    self.super.ctor(self,data)
    self.showId = data.equipmentId
    self.heroid = data.heroid;
    self:init("lua.uiconfig.Equip.EquipRecycle")
    self.info = {}
    EquipmentDataMgr:getEquipRecycleItems(self.showId)

end

function EquipmentRecycle:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
    self:showTopBar()

    self.backBtn        = TFDirector:getChildByPath(ui,"Button_back");
    self.mainBtn        = TFDirector:getChildByPath(ui,"Button_main");
    self.changeBtn      = TFDirector:getChildByPath(ui,"Button_change");
    self.fastBtn        = TFDirector:getChildByPath(ui,"Button_fast");
    self.itemLeft        = TFDirector:getChildByPath(ui,"itemToRec1");
    self.itemRight        = TFDirector:getChildByPath(ui,"itemToRec2");
    self.Panel_goodsRowItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_goodsRowItem")
    self.ScrollView_left = TFDirector:getChildByPath(ui, "ScrollView_left")
    self.ScrollView_right = TFDirector:getChildByPath(ui, "ScrollView_right")
    self.Panel_diamond = TFDirector:getChildByPath(ui, "Panel_diamond")
    self.Panel_gold = TFDirector:getChildByPath(ui, "Panel_gold")
    self.Label_EquipName = TFDirector:getChildByPath(ui, "Label_EquipName")
    self.Label_left_title = TFDirector:getChildByPath(ui, "Label_left_title")
    self.Label_right_title = TFDirector:getChildByPath(ui, "Label_right_title")
    self.Label_normal = TFDirector:getChildByPath(ui, "Label_normal")
    self.Label_highClass = TFDirector:getChildByPath(ui, "Label_highClass")
    self.Label_recycle_tips = TFDirector:getChildByPath(ui, "Label_recycle_tips")

    self.Label_EquipName:setText(EquipmentDataMgr:getEquipName(self.showId)..EquipmentDataMgr:getStepText(self.showId))
    local data = Utils:getKVP(4003)
    self.Label_left_title:setTextById(491001, data.normal.ratio / 100 .. "%")
    self.Label_right_title:setTextById(491001, data.rare.ratio / 100 .. "%")
    self.Label_normal:setTextById(491002)
    self.Label_highClass:setTextById(491003)
    self.Label_recycle_tips:setTextById(491004)


	self:updateLeftEquipment(self.itemLeft, self.showId)
    self:updateRightEquipment(self.itemRight, self.showId)
    local star = EquipmentDataMgr:getEquiGrowthpStar(self.showId)
    local lv     = EquipmentDataMgr:getEquipLv(self.showId)
    local totalExp = EquipmentDataMgr:getEquipCurExp(self.showId)
    for i=1,lv - 1 do
        totalExp = totalExp + TabDataMgr:getData("EquipmentGrowth",star).needExp[i];
    end

    local ratio1 = data.normal.ratio
    local ratio2 = data.rare.ratio
    local growthCostRatio = data.rare.growthCostRatio
    self.costCoin = 0
    self.costDiamond = data.rare.baseCost[500002] + math.floor(growthCostRatio / 10000 * totalExp)

    local goldNum = TFDirector:getChildByPath(self.Panel_gold,"Label_gold")
    local diamondNum = TFDirector:getChildByPath(self.Panel_diamond,"Label_gold")
    diamondNum:setText(self.costDiamond)
    goldNum:setText(self.costCoin)
    if self.costDiamond > GoodsDataMgr:getItemCount(500002) then
        diamondNum:setColor(ccc3(220,20,60))
    end
    if self.costCoin > GoodsDataMgr:getItemCount(500001) then
        goldNum:setColor(ccc3(220,20,60))
    end

    -- local totalExp1 = totalExp * ratio1 / 10000
    -- local totalExp2 = totalExp * ratio2 / 10000


    -- local item = {}
    -- local data2 = Utils:getKVP(4004)
    -- item[1], item[2], item[3], item[4] = data2.equipment[1], data2.equipment[2],data2.equipment[3],data2.equipment[4]

    -- local exp1, exp2, exp3, exp4 = EquipmentDataMgr:getEquipTotalExp(item[1]),
    -- EquipmentDataMgr:getEquipTotalExp(item[2]),
    -- EquipmentDataMgr:getEquipTotalExp(item[3]),
    -- EquipmentDataMgr:getEquipTotalExp(item[4]);

    -- local numLeft = {}
    -- local yu1 = totalExp1 % exp1
    -- numLeft[1] = (totalExp1 - yu1) / exp1

    -- local yu2 = yu1 % exp2
    -- numLeft[2] = (yu1 - yu2) / exp2

    -- local yu3 = yu2 % exp3
    -- numLeft[3] = (yu2 - yu3) / exp3

    -- local yu4 = yu3 % exp4
    -- numLeft[4] = (yu3 - yu4) / exp4

    -- local numRight = {}
    -- local yu1_1 = totalExp2 % exp1
    -- numRight[1] = (totalExp2 - yu1_1) / exp1

    -- local yu2_1 = yu1_1 % exp2
    -- numRight[2] = (yu1_1 - yu2_1) / exp2

    -- local yu3_1 = yu2_1 % exp3
    -- numRight[3] = (yu2_1 - yu3_1) / exp3

    -- local yu4_1 = yu3_1 % exp4
    -- numRight[4] = (yu3_1 - yu4_1) / exp4

    self.Panel_goodsItem_prefab = PrefabDataMgr:getPrefab("Panel_goodsItem")

    self.GridView_reward = UIGridView:create(self.ScrollView_left)
    self.GridView_reward:setItemModel(self.Panel_goodsItem_prefab)

    self.GridView_rewardRight = UIGridView:create(self.ScrollView_right)
    self.GridView_rewardRight:setItemModel(self.Panel_goodsItem_prefab)

    -- for i = 1, 4 do
    --     if numLeft[i] ~= 0 then
    --         local Panel_goodsItem = self.Panel_goodsItem_prefab:clone()
    --         PrefabDataMgr:setInfo(Panel_goodsItem, item[i], numLeft[i])
    --         --self.GridView_reward:pushBackCustomItem(Panel_goodsItem)
    --     end
    -- end

    -- for i = 1, 4 do
    --     if numRight[i] ~= 0 then
    --         local Panel_goodsItem = self.Panel_goodsItem_prefab:clone()
    --         PrefabDataMgr:setInfo(Panel_goodsItem, item[i], numRight[i])
    --         --self.GridView_rewardRight:pushBackCustomItem(Panel_goodsItem)
    --     end
    -- end

    -- local strengthRatio = TabDataMgr:getData("DiscreteData",4002).data.ratio
    -- local goldNumNormal = totalExp1 * strengthRatio / 10000
    -- local goldNumRare = totalExp2 * strengthRatio / 10000

    -- if goldNumNormal ~= 0 then
    --     local Panel_goodsItem = self.Panel_goodsItem_prefab:clone()
    --     PrefabDataMgr:setInfo(Panel_goodsItem, 500001, goldNumNormal)
    --     --self.GridView_reward:pushBackCustomItem(Panel_goodsItem)
    -- end

    -- if goldNumRare ~= 0 then
    --     local Panel_goodsItemRare = self.Panel_goodsItem_prefab:clone()
    --     PrefabDataMgr:setInfo(Panel_goodsItemRare, 500001, goldNumRare)
    --     --self.GridView_rewardRight:pushBackCustomItem(Panel_goodsItemRare)
    -- end
    self.leftPanel = TFDirector:getChildByPath(ui,"Panel_left")
    self.rightPanel = TFDirector:getChildByPath(ui,"Panel_right")

    ViewAnimationHelper.doMoveFadeInAction(self.leftPanel, {direction = 1, distance = 30, time = 0.2, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(self.rightPanel, {direction = 2, distance = 30, time = 0.2, ease = 1})

end



function EquipmentRecycle:updateLeftEquipment(item, id)
    local starLv = EquipmentDataMgr:getEquipStarLv(id);
    local quality = EquipmentDataMgr:getEquipQuality(id);

    local Image_level_bg = TFDirector:getChildByPath(item,"Image_level_bg")
    local Label_lv_title = TFDirector:getChildByPath(item,"Label_lv_title")
    local LvLabel = TFDirector:getChildByPath(item,"Label_lv");
    Image_level_bg:setTexture(EC_ItemLevelIcon[quality])
    Label_lv_title:setString("Lv.")
    LvLabel:setString(EquipmentDataMgr:getEquipLv(id))

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

    --是否使用中
    -- local isuse         = EquipmentDataMgr:isUesing(id);
    -- local useIcon       = TFDirector:getChildByPath(item,"Image_use");
    -- useIcon:setVisible(isuse);

    local iconpath      = EquipmentDataMgr:getEquipIcon(id);
    local icon          = TFDirector:getChildByPath(item,"Image_equip");
    icon:setTexture(iconpath);
    icon:Size(CCSizeMake(100,100));


    -- local typeIcon      = TFDirector:getChildByPath(item,"Image_type");
    -- local subType       = EquipmentDataMgr:getEquipSubType(id);
    -- typeIcon:setTexture(EC_EquipSubTypeIcon2[subType]);
    -- typeIcon:Size(CCSizeMake(24,24));

end

function EquipmentRecycle:onRecvResults(data)
    local delay = CCDelayTime:create(0.3);
    local callfunc = CCCallFunc:create(function()
            self.GridView_reward:removeAllItems()
            self.GridView_rewardRight:removeAllItems()
            self:updateLeftEquipment(self.itemLeft, self.showId)
            self:updateRightEquipment(self.itemRight, self.showId)
        end
        )
    self:runAction(CCSequence:create({delay,callfunc}));

    Utils:showReward(data.items)
    local diamondNum = TFDirector:getChildByPath(self.Panel_diamond,"Label_gold")
    local data = Utils:getKVP(4003)

    diamondNum:setText(data.rare.baseCost[500002])
end

function EquipmentRecycle:onGetRecycleItems(data)
    local info = data.recycleInfo
    self.info =  data.recycleInfo
    for k, v in ipairs(info[1].returnItem) do
        local Panel_goodsItem = self.Panel_goodsItem_prefab:clone()
        PrefabDataMgr:setInfo(Panel_goodsItem, v.id, v.num)
        self.GridView_reward:pushBackCustomItem(Panel_goodsItem)
    end
    for k, v in ipairs(info[2].returnItem) do
        local Panel_goodsItem = self.Panel_goodsItem_prefab:clone()
        PrefabDataMgr:setInfo(Panel_goodsItem, v.id, v.num)
        self.GridView_rewardRight:pushBackCustomItem(Panel_goodsItem)
    end
    local diamondNum = TFDirector:getChildByPath(self.Panel_diamond,"Label_gold")
    diamondNum:setText(info[2].costItem[1].num)
end

function EquipmentRecycle:updateRightEquipment(item, id)
    local starLv = EquipmentDataMgr:getEquipStarLv(id);
    local quality = EquipmentDataMgr:getEquipQuality(id);

    local Image_level_bg = TFDirector:getChildByPath(item,"Image_level_bg")
    local Label_lv_title = TFDirector:getChildByPath(item,"Label_lv_title")
    local LvLabel = TFDirector:getChildByPath(item,"Label_lv");
    Image_level_bg:setTexture(EC_ItemLevelIcon[quality])
    Label_lv_title:setString("Lv.")
    LvLabel:setString("1")

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

    --是否使用中
    -- local isuse         = EquipmentDataMgr:isUesing(id);
    -- local useIcon       = TFDirector:getChildByPath(item,"Image_use");
    -- useIcon:setVisible(isuse);

    local iconpath      = EquipmentDataMgr:getEquipIcon(id);
    local icon          = TFDirector:getChildByPath(item,"Image_equip");
    icon:setTexture(iconpath);
    icon:Size(CCSizeMake(100,100));


    -- local typeIcon      = TFDirector:getChildByPath(item,"Image_type");
    -- local subType       = EquipmentDataMgr:getEquipSubType(id);
    -- typeIcon:setTexture(EC_EquipSubTypeIcon2[subType]);
    -- typeIcon:Size(CCSizeMake(24,24));

end

function EquipmentRecycle:registerEvents()
    EventMgr:addEventListener(self,EQUIPMENT_RECYCLERESULTS,handler(self.onRecvResults, self))
    EventMgr:addEventListener(self,EQUIPMENT_GETRECYCLEITEMS,handler(self.onGetRecycleItems, self))

	self.backBtn:onClick(function ()
            AlertManager:close();
    end)

    self.mainBtn:onClick(function()
    		AlertManager:changeScene(SceneType.MainScene);
    	end)

    self.changeBtn:onClick(function()
            if EquipmentDataMgr:getEquipLv(self.showId) <= 1 then
                Utils:showTips(491007)
                return
            end
            if GoodsDataMgr:getItemCount(500001) < self.costCoin then
                -- toastMessage("金币不足")
                Utils:showTips(493004)
                return
            end
            self:onTouchChangeBtn();
        end)

    self.fastBtn:onClick(function()
            if EquipmentDataMgr:getEquipLv(self.showId) <= 1 then
                Utils:showTips(491007)
                return
            end
            if GoodsDataMgr:getItemCount(500002) < self.costDiamond then
                -- toastMessage("钻石不足")
                Utils:showTips(800048)
                return
            end
            self:onTouchFastBtn();
        end)
end

function EquipmentRecycle:onTouchChangeBtn()
    Utils:openView("Equipment.EquipmentRecycleConfirm",1,self.showId,self.info)
    --TFDirector:send(c2s.EQUIPMENT_REQ_EQUIP_RECYCLE,{1,tostring(self.showId)});
end

function EquipmentRecycle:showChangeBtnEffect()
    local effect = TFDirector:getChildByPath(self.changeBtn,"Spine_clickStrengthen")
    effect:playByIndex(0, -1, -1, 0)
end

function EquipmentRecycle:onTouchFastBtn()
    Utils:openView("Equipment.EquipmentRecycleConfirm",2,self.showId,self.info)
    --TFDirector:send(c2s.EQUIPMENT_REQ_EQUIP_RECYCLE,{2,tostring(self.showId)});
end

function EquipmentRecycle:onHide()
	self.super.onHide(self)
end

function EquipmentRecycle:removeUI()
	self.super.removeUI(self)
end



function EquipmentRecycle:onShow()
    self.super.onShow(self)
end

return EquipmentRecycle;
