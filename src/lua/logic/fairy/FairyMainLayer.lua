local FairyMainLayer = class("FairyMainLayer", BaseLayer)


function FairyMainLayer:ctor(data)
    self.super.ctor(self,data)
    self.showData = data;
    self.topBarType_ = {EC_TopbarType.DIAMOND, EC_TopbarType.GOLD, EC_TopbarType.POWER}
    self.showid = HeroDataMgr:getTeamLeaderId();
    self.showidx = 1;
    self.selectCell = nil;
    self.showSkinID = nil;
    if data and data.friend then
    	self.isfriend = true;
    	HeroDataMgr:resetShowList(true);
    	if data.backTag then
    		self.backTag = data.backTag
    	end
    else
    	HeroDataMgr:resetShowList();
    end

    if data and data.showid then
    	self.showid = data.showid;
    	self.showidx = HeroDataMgr:getShowIdxById(self.showid);
    	self.showCount = HeroDataMgr:getShowCount();
    else
    	self.showid = HeroDataMgr:getTeamLeaderId();
    	self.showidx = 1;
    	self.showCount = HeroDataMgr:getShowCount();
    end
    self.firstTouchIn = false;
    self:init("lua.uiconfig.fairy.fairyMain")

    -- self:showTopBar()

    self.curPanel = nil;
    self.lastPanel = nil;
end

function FairyMainLayer:heroInfoChange()
	self:updateStrengthenLayer()
	self:updateEquipLayer();
	self:updateAngelLayer();
	self:updateCompose();
	self:updateOneHead(self.selectCell,self.showidx)
	self:updateBaseInfo()
	self:updateRedPoint();
	--self:changeShowOne();
end

function FairyMainLayer:onRefresh()
	if self.pos then
		HeroDataMgr:resetShowList(true);
	else
		HeroDataMgr:resetShowList();
	end

	self.showidx = HeroDataMgr:getShowIdxById(self.showid)
	self.tableView:reloadData();
	self:changeShowOne();
end

function FairyMainLayer:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	FairyMainLayer.ui = ui
	self.bottomBtns = {};

	self.Image_fairy    = TFDirector:getChildByPath(ui,"Image_fairy");
	self.Image_fairy_orgPos = self.Image_fairy:getPosition();
	self.Button_lingzhuang 	= TFDirector:getChildByPath(ui,"Button_lingzhuang");
	self.Button_tianshi		= TFDirector:getChildByPath(ui,"Button_tianshi");
	-- self.Button_lingzhuang:setTextureNormal("ui/fairy/035.png");
	-- self.Button_tianshi:setTextureNormal("ui/fairy/035.png");
	self.Button_lingzhuang:setTouchEnabled(false);
	self.Button_tianshi:setTouchEnabled(false);
	self.Button_army		= TFDirector:getChildByPath(ui,"Button_army");
	self.armyLabel 			= TFDirector:getChildByPath(ui,"Label_army_info");
	self.Label_power		= TFDirector:getChildByPath(ui,"Label_power");
	--self.Label_power:enableGlow(ccc4(255,255,255,255));
	self.Image_power		= TFDirector:getChildByPath(ui,"Image_power");
	
	-- self.backBtn 		= TFDirector:getChildByPath(ui,"Button_back");
	-- self.mainBtn 		= TFDirector:getChildByPath(ui,"Button_main");
	self.Button_skin	= TFDirector:getChildByPath(ui,"Button_skin");
	self.infoBtn 		= TFDirector:getChildByPath(ui,"Button_info");
	self.infoBtn:setTextureNormal("ui/xj023.png");
	self.fairyBtn		= TFDirector:getChildByPath(ui,"Button_fairy");
	self.panel_list 	= TFDirector:getChildByPath(ui,"Panel_scroll");
	self.panel_item 	= TFDirector:getChildByPath(ui,"Panel_item");
	self.infoTip		= TFDirector:getChildByPath(self.infoBtn,"RedTips")
	self.fairyTip		= TFDirector:getChildByPath(self.fairyBtn,"RedTips")
	self.equipTip		= TFDirector:getChildByPath(self.Button_lingzhuang,"RedTips")
	self.angelTip		= TFDirector:getChildByPath(self.Button_tianshi,"RedTips");

	self.Panel_left		= TFDirector:getChildByPath(ui,"Panel_left");
	self.Panel_skin		= TFDirector:getChildByPath(ui,"Panel_skin");

	self.panel_right 	= TFDirector:getChildByPath(ui,"Panel_right");
	self.panel_name 	= TFDirector:getChildByPath(ui,"Panel_name");
	self.fairyNameImg 	= TFDirector:getChildByPath(self.panel_name,"Image_hero_name");
	self.qualityImg		= TFDirector:getChildByPath(self.panel_name,"Image_hero_puality");
	self.titleImg		= TFDirector:getChildByPath(self.panel_name,"Image_hero_title");
	self.Image_type		= TFDirector:getChildByPath(self.panel_right,"Image_type");
	--self.Label_type		= TFDirector:getChildByPath(self.panel_right,"Label_type");
	self.Label_curExp	= TFDirector:getChildByPath(self.panel_right,"Label_curExp");
	self.Image_feature 	= TFDirector:getChildByPath(self.panel_right,"Image_feature");
	self.fariy_di 	 	= TFDirector:getChildByPath(self.ui,"Image_b3");

	--强化界面
	self.Label_lv		= TFDirector:getChildByPath(self.panel_right,"Label_lv");
	self.LoadingBar_lv	= TFDirector:getChildByPath(self.panel_right,"LoadingBar_lv");
	self.LoadingBar_lv:setPercent(0)
	self.Label_attr_atk	= TFDirector:getChildByPath(self.panel_right,"Label_attr_atk");
	self.Label_attr_def	= TFDirector:getChildByPath(self.panel_right,"Label_attr_def");
	self.Label_attr_hp	= TFDirector:getChildByPath(self.panel_right,"Label_attr_hp");
	self.levelupBtn 	= TFDirector:getChildByPath(ui,"Button_lvup");
	self.strengthenBtn	= TFDirector:getChildByPath(self.panel_right,"Button_tupo");
	self.Image_need_coin = TFDirector:getChildByPath(self.panel_right,"Image_need_coin");

	for i=1,3 do
		self["tupo_need_"..i] 	= TFDirector:getChildByPath(self.panel_right,"tupo_need_"..i);
		self["Label_need_"..i]	= TFDirector:getChildByPath(self.panel_right,"Label_need_"..i);
		self["Image_tupo_"..i]  = TFDirector:getChildByPath(self.panel_right,"Image_tupo_"..i);
	end
	self.tupo_need_gold		= TFDirector:getChildByPath(self.panel_right,"Label_tupo_need");
	self.strengthenLv 		= TFDirector:getChildByPath(self.panel_right,"Label_strengthen");

	--搭配控件
	for i=1,4 do
		self["Image_dapei_type"..i] = TFDirector:getChildByPath(self.panel_right,"Image_dapei_type"..i);
		self["Label_dapei_type"..i] = TFDirector:getChildByPath(self.panel_right,"Label_dapei_type"..i);
	end
	--特点描述控件
	for i=1,4 do
		self["Label_info_"..i] = TFDirector:getChildByPath(self.panel_right,"Label_info_"..i);
	end


	self.infoPanel 		= TFDirector:getChildByPath(self.panel_right,"Panel_info");
	self.strengthenPanel= TFDirector:getChildByPath(self.panel_right,"Panel_strengthen");
	self.equipPanel		= TFDirector:getChildByPath(self.panel_right,"Panel_Equipment");
	self.bottomPanel	= TFDirector:getChildByPath(ui,"Panel_bottom");
	
	--装备界面
	self.Label_cost 	= TFDirector:getChildByPath(self.equipPanel,"Label_cost");

	for i=1,3 do
		self["equipPanel"..i] = TFDirector:getChildByPath(self.equipPanel,"Image_equipment_di"..i);
		self["equipPanel"..i].Panel_equip_info 	= TFDirector:getChildByPath(self["equipPanel"..i],"Panel_equip_info");
		self["equipPanel"..i].Image_select 		= TFDirector:getChildByPath(self["equipPanel"..i],"Image_select");
		self["equipPanel"..i].Image_add 		= TFDirector:getChildByPath(self["equipPanel"..i],"Image_add");
		self["equipPanel"..i].Image_equipment 	= TFDirector:getChildByPath(self["equipPanel"..i],"Image_equipment");
		self["equipPanel"..i].Image_equip_type 	= TFDirector:getChildByPath(self["equipPanel"..i],"Image_equip_type");
		self["equipPanel"..i].text_cost 		= TFDirector:getChildByPath(self["equipPanel"..i],"text_cost");
		self["equipPanel"..i].Label_equipLv 	= TFDirector:getChildByPath(self["equipPanel"..i],"Label_equipLv");
		self["equipPanel"..i].star1 			= TFDirector:getChildByPath(self["equipPanel"..i],"Image_star1");
		self["equipPanel"..i].star2 			= TFDirector:getChildByPath(self["equipPanel"..i],"Image_star2");
		self["equipPanel"..i].star3 			= TFDirector:getChildByPath(self["equipPanel"..i],"Image_star3");
		self["equipPanel"..i].star4 			= TFDirector:getChildByPath(self["equipPanel"..i],"Image_star4");
		self["equipPanel"..i].star5 			= TFDirector:getChildByPath(self["equipPanel"..i],"Image_star5");

		--组合连线
		self["Image_link"..i]					= TFDirector:getChildByPath(self.equipPanel,"Image_link"..i);

		--组合技能
		self["Label_skill_"..i.."_name"]		= TFDirector:getChildByPath(self.equipPanel,"Label_skill_"..i.."_name");
		self["Label_skill_"..i.."_desc"]		= TFDirector:getChildByPath(self.equipPanel,"Label_skill_"..i.."_desc");
	end

	self.Panel_suit 							= TFDirector:getChildByPath(self.panel_right,"Panel_suit"):hide();


	--碎片合成相关
	self.composePanel 	= TFDirector:getChildByPath(self.infoPanel,"Panel_compose");
	self.Button_sp		= TFDirector:getChildByPath(self.composePanel,"Button_sp");

	--天使
	self.angelPanel		= TFDirector:getChildByPath(self.panel_right,"Panel_angel");
	self.Button_Awaken	= TFDirector:getChildByPath(self.angelPanel,"Button_Awaken");
	self.Image_angel	= TFDirector:getChildByPath(self.ui,"Image_angel");
	for i=1,5 do
		self["angelPanel"..i] = TFDirector:getChildByPath(self.angelPanel,"Image_skill_"..i);
	end

	if not self.pos then
		self.Button_army:hide();
		self.bottomPanel:setPositionX(self.bottomPanel:getPositionX() + 110)
	end

	--self.LoadingBar_lv:setAngle(45)
	--table.insert(self.bottomBtns,self.Button_army);
	table.insert(self.bottomBtns,{btn = self.Button_lingzhuang,panel = self.equipPanel});
	table.insert(self.bottomBtns,{btn = self.Button_tianshi,panel = self.angelPanel});
	table.insert(self.bottomBtns,{btn = self.infoBtn,panel = self.infoPanel});
	table.insert(self.bottomBtns,{btn = self.fairyBtn,panel = self.strengthenPanel});

	self:initTableView();
	self.tableView:reloadData()


	--皮肤
	local scrollView 		= TFDirector:getChildByPath(self.Panel_skin,"ScrollView_skin");
	self.skinListView 		= UIListView:create(scrollView);
	self.skinItems 			= TFDirector:getChildByPath(ui,"Panel_skin_item");
	self.Button_skin_info	= TFDirector:getChildByPath(ui,"Button_skin_info");
	self.Button_skin_change = TFDirector:getChildByPath(ui,"Button_change");

	self:onBottomBtnTouch(self.infoBtn);
	self:changeShowOne();
end

function FairyMainLayer:onBottomBtnTouch(btn)
	if self.curSelBtn == btn then
		return;
	end

	for k,v in pairs(self.bottomBtns) do
		if v.btn == btn then
			v.btn:setTextureNormal("ui/xj023.png");
			if self.curPanel ~= v.panel then
				self.curPanel = v.panel;
				self.curSelBtn = v.btn;
				self:panelShow(v.panel);
			end
		else
			if HeroDataMgr:getIsHave(self.showid) then
				v.btn:setTextureNormal("ui/xj022.png");
				self:panelHide(v.panel);
			end
		end
	end

	--
	self.Image_fairy:setVisible(self.curPanel ~= self.angelPanel);
	self.Button_skin:setVisible(self.curPanel ~= self.angelPanel and not self.isfriend);
	self.fairyNameImg:setVisible(self.curPanel ~= self.angelPanel);
	self.titleImg:setVisible(self.curPanel ~= self.angelPanel);
	self.qualityImg:setVisible(self.curPanel ~= self.angelPanel);
	self.Image_power:setVisible(self.curPanel ~= self.angelPanel);
	self.fariy_di:setVisible(self.curPanel ~= self.angelPanel);

	local suitIds = HeroDataMgr:checkSuit(self.showid);
	self.Panel_suit:setVisible(#suitIds > 0 and self.curPanel == self.equipPanel);

	if self.angelModel then
		self.angelModel:setVisible(self.curPanel == self.angelPanel);
	end
end

function FairyMainLayer:panelHide(panel)
	if not panel:isVisible() then
		return
	end

	local background = panel:getChildByName("Image_back")
	local subPanel	 = panel:getChildByName("Panel");

	if not background.orgpos then
		background.orgpos = background:getPosition();
	end

	panel:stopAllActions();
	background:stopAllActions();
	subPanel:stopAllActions();
	background:setPosition(background.orgpos);
	subPanel:setPosition(0,0);
	background:setOpacity(255);
	subPanel:setOpacity(255);


	local actions1 = {
		CCMoveBy:create(0.2,ccp(0,-30));
		CCFadeOut:create(0.2);
	}

	background:runAction(Spawn:create(actions1));

	local actions2 = {
		CCMoveBy:create(0.2,ccp(30,0));
		CCFadeOut:create(0.2);
	}

	subPanel:runAction(Spawn:create(actions2));

	local delay = CCDelayTime:create(0.25);
	local callfunc = CCCallFunc:create(function()
			background:setPositionY(background:getPositionY() + 30);
			subPanel:setPositionX(subPanel:getPositionX() - 30);
			panel:setVisible(false);
			background:setOpacity(255);
			subPanel:setOpacity(255);
		end)

	local actions3 = {
		delay,
		callfunc
	}
	panel:runAction(CCSequence:create(actions3));
end

function FairyMainLayer:panelShow(panel)
	local background = panel:getChildByName("Image_back")
	local subPanel	 = panel:getChildByName("Panel");

	if not background.orgpos then
		background.orgpos = background:getPosition();
	end

	panel:stopAllActions();
	background:stopAllActions();
	subPanel:stopAllActions();
	background:setPosition(background.orgpos);
	subPanel:setPosition(0,0);
	background:setOpacity(255);
	subPanel:setOpacity(255);

	background:setPositionY(background:getPositionY() + 30)
	subPanel:setPositionX(subPanel:getPositionX() + 30)
	background:setOpacity(0)
	subPanel:setOpacity(0)
	panel:setVisible(true);

	local actions1 = {
		CCMoveBy:create(0.2,ccp(0,-30));
		CCFadeIn:create(0.2);
	}

	background:runAction(Spawn:create(actions1));

	local actions2 = {
		CCMoveBy:create(0.2,ccp(-30,0));
		CCFadeIn:create(0.2);
	}

	subPanel:runAction(Spawn:create(actions2));
end

function FairyMainLayer:onFormationChange()
	local topLayer = AlertManager:getTopLayer();
	if topLayer.__cname == "FairyMainLayer" then
		AlertManager:close();
	end
end

function FairyMainLayer:onTouchFairy()
	print("self.showid = "..self.showid);
	if HeroDataMgr:getIsHave(self.showid) then
		print("self.showid = "..self.showid);
		self:onBottomBtnTouch(self.fairyBtn);
	end
end

function FairyMainLayer:onTouchEquip()
	if HeroDataMgr:getIsHave(self.showid) then
		self:onBottomBtnTouch(self.Button_lingzhuang);
	end
end

function FairyMainLayer:registerEvents()
	EventMgr:addEventListener(self,EV_FORMATION_CHANGE,handler(self.onFormationChange, self));
    EventMgr:addEventListener(self,EV_HERO_LEVEL_UP,handler(self.heroInfoChange, self));
    EventMgr:addEventListener(self,EV_HERO_CHANGE_SKIN,handler(self.updateSkinLayer, self));
    EventMgr:addEventListener(self,EV_HERO_REFRESH,handler(self.onRefresh, self));
    
    self:setBackBtnCallback(function()
    		if self.isShowSkin then
    			self:hideSkinLayer();
    		else
    			AlertManager:close();
    		end
    	end)
    if self.isfriend == true then
    	if self.backTag == "teamFight" then
    		-- self.topLayer.Button_main:setTexture("ui/cc.png")
    		self:setMainBtnCallback(function()
	    		TeamFightDataMgr:openTeamView()
	    	end)
    	end
	end

    self.Button_tianshi:onClick(function()
            if not JumpDataMgr:checkFuncOpen(7) then return end
            if HeroDataMgr:getIsHave(self.showid) then
    			self:onBottomBtnTouch(self.Button_tianshi);
    		end
    end)

    self.Button_lingzhuang:onClick(function()
    		Utils:showTips("test")
            -- if not JumpDataMgr:checkFuncOpen(8) then return end
    		self:onTouchEquip();

        end)

    self.infoBtn:onClick(function()
    		self:onBottomBtnTouch(self.infoBtn);
    	end)

    self.fairyBtn:onClick(function()
            if not JumpDataMgr:checkFuncOpen(6) then return end
            self:onTouchFairy()
    	end)

    self.levelupBtn:onClick(function ( ... )
    	-- body
    	local layer = require("lua.logic.fairy.FairyLevelUp"):new(self.showid)
        AlertManager:addLayer(layer)
        AlertManager:show()
    end)

    self.strengthenBtn:onClick(function()
    		HeroDataMgr:heroStrengthen(self.showid);
    	end)

    self.Button_army:onScaleClick(function()
    		self:onTouchButtonArmy();
    	end)


    --装备插槽
    for i=1,3 do
    	local equipBoard = self["equipPanel"..i];
    	equipBoard:setTouchEnabled(true);
		equipBoard:onClick(function()
			local layer = nil;
			print("touch in "..i);
			local ishave = HeroDataMgr:getIsHaveEquip(self.showid ,i);
			if ishave then
				local equipmentId = HeroDataMgr:getEquipIdByPos(self.showid,i);
				layer = require("lua.logic.Equipment.EquipmentInfo"):new({equipmentId = equipmentId,heroid = self.showid,pos = i,isfriend = self.isfriend,backTag = self.backTag});
			else
				if self.isfriend then
					return
				end

				if not EquipmentDataMgr:isCanUseEquip() then
					-- toastMessage("没有可使用的装备");
					Utils:showTips(493007)
					return
				end

				local list = EquipmentDataMgr:initShowList(self.showid,i);
				if table.count(list) <= 0 then
					-- toastMessage("没有可使用的装备");
					Utils:showTips(493007)
					return
				end

				layer = require("lua.logic.Equipment.EquipmentSelect"):new({heroid = self.showid,pos = i,ishave = ishave});
			end
			--
        	AlertManager:addLayer(layer)
        	AlertManager:show()
		end)
    end

    for i=1,5 do
		self["angelPanel"..i]:setTouchEnabled(true);
		self["angelPanel"..i]:onClick(function()
				local layer = require("lua.logic.angel.AngelInfo"):new({skillid = self["angelPanel"..i].skillid,idx = i,heroid = self.showid,isfriend = self.isfriend,backTag = self.backTag});
		        AlertManager:addLayer(layer)
		        AlertManager:show()
			end)
	end

    self.Button_sp:onClick(function()
	    	if HeroDataMgr:getIsHave(self.showid) then
                local needs = HeroDataMgr:getProgressNeed(self.showid);--合成
                local costId, costNum
	            costId = needs[1]
	            costNum = needs[2]

                if GoodsDataMgr:currencyIsEnough(costId, costNum) then
                    HeroDataMgr:heroProgress(self.showid)
                else
                    Utils:showAccess(costId)
                end
	    	else
	    		if HeroDataMgr:isCanCompose(self.showid) then
	    			HeroDataMgr:composeHero(self.showid);
	    		else
	    			local needs = HeroDataMgr:getComposeNeed(self.showid);--合成
	                local costId, costNum
	                for k, v in pairs(needs) do
	                    costId = k
	                    costNum = v
	                    break
	                end
	                Utils:showAccess(costId)
	    		end
	    	end
    	end)

    self.Button_Awaken:onClick(function()
    		if HeroDataMgr:getIsHave(self.showid) then
                local costNum,costId = HeroDataMgr:getAwakenNeed(self.showid)
                if GoodsDataMgr:currencyIsEnough(costId, costNum) then
                    HeroDataMgr:angelAwaken(self.showid)
                else
                    Utils:showAccess(costId)
                end
    		end
    	end)

    self.Button_skin:onClick(function()
    		self:onTouchSkin();
    	end)

    self.Button_skin_info:onClick(function()
    		if self.showSkinID then
    			Utils:showInfo(self.showSkinID)
    		end
    	end)

    self.Button_skin_change:onClick(function()
    		HeroDataMgr:changeSkin(self.showid,self.showSkinID);
    	end)
end

function FairyMainLayer:onTouchSkin()
	self.isShowSkin = true;
	self.Panel_left:hide();
	self.panel_right:hide();
	self.bottomPanel:hide();
	self.Button_skin:hide();
	self.qualityImg:hide();
	self.Panel_skin:show();
	self.panel_name:runAction(CCMoveBy:create(0.2,ccp(-150,0)));

	self:updateSkinLayer();
end

function FairyMainLayer:hideSkinLayer()
	self.isShowSkin = false;
	self.Panel_left:show();
	self.panel_right:show();
	self.bottomPanel:show();
	self.Button_skin:show();
	self.qualityImg:show();
	self.Panel_skin:hide();
	self.panel_name:runAction(CCMoveBy:create(0.2,ccp(150,0)));
	Utils:createHeroModel(self.showid,self.Image_fairy)
end

function FairyMainLayer:updateSkinBtnState()
	local curskinID 	= HeroDataMgr:getCurSkin(self.showid);
	local skinID 		= self.curSelSkinItem.skinID;
	local isUnlock		= HeroDataMgr:checkSkinUnlock(skinID);
	if curskinID == skinID then
    	self.Button_skin_change:setGrayEnabled(true,true);
    	self.Button_skin_change:setTouchEnabled(false);
    elseif not isUnlock then
    	self.Button_skin_change:setGrayEnabled(true,true);
    	self.Button_skin_change:setTouchEnabled(false);
    else
    	self.Button_skin_change:setGrayEnabled(false);
    	self.Button_skin_change:setTouchEnabled(true);
   	end
end

function FairyMainLayer:updateSkinLayer(delay)
	local skins = HeroDataMgr:getSkins(self.showid);
	self.skinListView:removeAllItems();
	self.curSelSkinItem = nil;
	local function update()
		for k,v in pairs(skins) do
			local item = self.skinItems:clone();
			item:setTouchEnabled(true);
			item.skinID = v;
			local skinData = TabDataMgr:getData("HeroSkin",v);
			local Image_head = TFDirector:getChildByPath(item,"Image_head");
			Image_head:setTexture(skinData.icon);
			Image_head:setSize(CCSizeMake(100,100))

			local Label_skin_name	= TFDirector:getChildByName(item,"Label_skin_name");
			Label_skin_name:setTextById(skinData.nameTextId);

			local Image_lock 	= TFDirector:getChildByPath(item,"Image_lock");
			local isUnlock		= HeroDataMgr:checkSkinUnlock(v);
			Image_lock:setVisible(not isUnlock);

			local Image_select2	= TFDirector:getChildByPath(item,"Image_select2");
			local Image_select 	= TFDirector:getChildByPath(item,"Image_select");
			local curskinID 	= HeroDataMgr:getCurSkin(self.showid);
			self.showSkinID 	= curskinID;
			Image_select2:setVisible(curskinID == v);
			Image_select:setVisible(curskinID == v);
			item.Image_select2 	= Image_select2;

			local Image_skin	= TFDirector:getChildByPath(item,"Image_skin");
			local fightModePath = HeroDataMgr:getFightModelPath(self.showid,v);
			local model 		= SkeletonAnimation:create(fightModePath);
			model:setAnimationFps(GameConfig.ANIM_FPS);
		    model:play("stand", 1)
		    Image_skin:getParent():addChild(model,2)
		    model:setPosition(Image_skin:getPosition());
		    model:setScale(0.5);
		    Image_lock:setZOrder(model:getZOrder() + 1);

		    if curskinID == v then
		    	model:play("move", 1);
		    	self.Button_skin_change:setGrayEnabled(true,true);
		    	self.Button_skin_change:setTouchEnabled(false);
		    	self.curSelSkinItem = item;
		    elseif not isUnlock then
		    	self.Button_skin_change:setGrayEnabled(true,true);
		    	self.Button_skin_change:setTouchEnabled(false);
		    else
		    	self.Button_skin_change:setGrayEnabled(false);
		    	self.Button_skin_change:setTouchEnabled(true);
		   	end

		   	item:onClick(function()
		   			if self.curSelSkinItem ~= item then
		   				self.curSelSkinItem.Image_select2:hide();
						item.Image_select2:show();
						self.curSelSkinItem = item;
						self.showSkinID		= item.skinID;
						dump(self.showSkinID);
						Utils:createHeroModel(self.showid, self.Image_fairy, nil,self.showSkinID);
						self:updateSkinBtnState();
		   			end
		   		end)

			self.skinListView:pushBackCustomItem(item);
		end
	end

	if delay then
		VoiceDataMgr:playVoiceByHeroID("change_equip",self.showid)
		self:timeOut(update,0);
	else
		update();
	end
end

function FairyMainLayer:onTouchButtonArmy()
	if HeroDataMgr:getIsFormationOn(self.pos) and HeroDataMgr:getHeroIdByFormationPos(self.pos) ~= self.showid then
		HeroDataMgr:heroOnBattle(HeroDataMgr:getHeroIdByFormationPos(self.pos),self.showid);
	else
		HeroDataMgr:heroOnBattle(self.showid);
	end
end

function FairyMainLayer:initTableView()
    local  tableView =  TFTableView:create()
    tableView:setName("btnTableView")
    local tableViewSize = self.panel_list:getContentSize()
    tableView:setTableViewSize(CCSizeMake(tableViewSize.width, tableViewSize.height))
    tableView:setDirection(TFTableView.TFSCROLLVERTICAL)
    tableView:setPosition(self.panel_list:getPosition())
    tableView:setAnchorPoint(self.panel_list:getAnchorPoint());
    self.tableView = tableView

    self.tableView.logic = self

    tableView:addMEListener(TFTABLEVIEW_TOUCHED, FairyMainLayer.tableCellTouched)
    tableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, FairyMainLayer.cellSizeForTable)
    tableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, FairyMainLayer.tableCellAtIndex)
    tableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, FairyMainLayer.numberOfCellsInTableView)


    tableView:addMEListener(TFTABLEVIEW_CELLISBEGIN, FairyMainLayer.cellBegin)
    tableView:addMEListener(TFTABLEVIEW_CELLISEND, FairyMainLayer.cellEnd)


    self.panel_list:getParent():addChild(self.tableView,10)
end

function FairyMainLayer.tableCellTouched(table,cell)
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

function FairyMainLayer:updateBaseInfo( ... )
	-- body
	print("showid = "..self.showid);
	Utils:createHeroModel(self.showid,self.Image_fairy)

	self.fairyNameImg:setTexture(HeroDataMgr:getNamePic(self.showid));
	self.fairyNameImg:setScale(0.76);
	self.qualityImg:setTexture(HeroDataMgr:getQualityPic(self.showid));
	self.titleImg:setTexture(HeroDataMgr:getTitlePic(self.showid));

	local tag = HeroDataMgr:getTypeIconPathAndString(self.showid);
	self.Image_type:setTexture(tag.icon);

	--搭配
	local labels = HeroDataMgr:getLabelsIconAndString(self.showid);
	for k,v in pairs(labels) do
		self["Label_dapei_type"..k]:setString(v.describe);
		self["Image_dapei_type"..k]:setTexture(v.icon);
	end

	--特点描述
	local tips = HeroDataMgr:getBattleTips(self.showid)
	for k,v in pairs(tips) do
		if k > 3 then
			break;
		end
		self["Label_info_"..k]:setString(v);
	end
	local featurePath = HeroDataMgr:getFeaturePath(self.showid);
	self.Image_feature:setTexture(featurePath);

	local ishave = HeroDataMgr:getIsHave(self.showid);
	self.Label_power:setVisible(ishave);
	self.Image_power:setVisible(ishave and self.curPanel ~= self.angelPanel);
	self.Label_power:setString(math.floor(HeroDataMgr:getHeroPower(self.showid)));

	local quality_di = TFDirector:getChildByPath(self.qualityImg,"Image_quality_di");
	local quality 	 = HeroDataMgr:getQuality(self.showid);
	if quality > 1 then
		quality_di:setTexture("ui/xj100.png");
	else
		quality_di:setTexture("ui/xj020.png");
	end

	--精灵底颜色
	self.fariy_di:setColor(HeroDataMgr:getDiBanColor(self.showid));
end

function FairyMainLayer:changeShowOne()
	if self.curChangeHeroHandle then
		TFAudio.stopEffect(self.curChangeHeroHandle)
		self.curChangeHeroHandle = nil
	end
	self.curChangeHeroHandle = VoiceDataMgr:playVoiceByHeroID("change_hero",self.showid);

	if not HeroDataMgr:getIsHave(self.showid) then
		self.infoPanel:setVisible(true);
		self.infoPanel:setOpacity(255)
		self.curPanel = self.infoPanel;
		self.infoBtn:setTextureNormal("ui/xj023.png")
	    self.strengthenPanel:setVisible(false);
	    self.equipPanel:setVisible(false);
	    self.angelPanel:setVisible(false);
	    self.Image_angel:setVisible(false);
	    self.Image_fairy:setVisible(true);
		self.fairyNameImg:setVisible(true);
		self.titleImg:setVisible(true);
		self.Button_skin:setVisible(true)
		self.qualityImg:setVisible(true);
		self.Image_power:setVisible(true);
		self.curSelBtn = self.infoBtn;
		if self.angelModel then
			self.angelModel:setVisible(false);
		end
		--self.Image_angel:setVisible(self.curPanel == self.angelPanel);
	end

    self.Button_tianshi:getChildByName("Label_button_info"):setString(HeroDataMgr:getHeroWeaponName(self.showid));
	--end
	self:updateBaseInfo();

	if HeroDataMgr:getIsHave(self.showid) then
		self:updateEquipLayer();
		self:updateStrengthenLayer();
		self:updateAngelLayer();
	end

	local ishave = HeroDataMgr:getIsHave(self.showid);

	if not ishave then
		self.fairyBtn:setTextureNormal("ui/xj022.png");
		self.fairyBtn:setTouchEnabled(false);

		self.Button_tianshi:setTextureNormal("ui/xj022.png");
		self.Button_tianshi:setTouchEnabled(false);
		self.Button_lingzhuang:setTextureNormal("ui/xj022.png");
		self.Button_lingzhuang:setTouchEnabled(false);

		Utils:setNodeGray(self.fairyBtn,true)
		Utils:setNodeGray(self.Button_lingzhuang,true)
		Utils:setNodeGray(self.Button_tianshi,true)
	else
		-- self.fairyBtn:setTextureNormal("");
		self.fairyBtn:setTouchEnabled(true);

		-- self.Button_tianshi:setTextureNormal("");
		self.Button_tianshi:setTouchEnabled(true);
		-- self.Button_lingzhuang:setTextureNormal("");
		self.Button_lingzhuang:setTouchEnabled(true);

		Utils:setNodeWhite(self.fairyBtn)
		Utils:setNodeWhite(self.Button_lingzhuang)
		Utils:setNodeWhite(self.Button_tianshi)
		--Utils:setNodeGray(self.Button_tianshi,true)
	end

	if self.isfriend then
		self.composePanel:hide();
		self.levelupBtn:hide();
		self.strengthenBtn:hide();
		TFDirector:getChildByPath(self.ui,"Image_need_back"):hide();
		self.Button_Awaken:hide();
    	TFDirector:getChildByPath(self.angelPanel,"Image_fairyMain_2"):hide();
    	TFDirector:getChildByPath(self.angelPanel,"Label_awaken_point"):hide();
    	self.Button_skin:hide();
	end

	--碎片相关
	self:updateCompose();
	self:updateRedPoint();

	if not ishave then
		return;
	end

	if not self.pos then
		return
	end

	local job = HeroDataMgr:getHeroJob(self.showid);
	if job == self.pos and HeroDataMgr:getFormationHeroCnt() == 1 then
		self.armyLabel:setTextById(2100122);
		--self.Button_army:setGrayEnabled(true);
		self.Button_army:setTouchEnabled(false);
	elseif job == self.pos and HeroDataMgr:getFormationHeroCnt() > 1 then
		self.armyLabel:setTextById(2100122);
		self.Button_army:setGrayEnabled(false);
		self.Button_army:setTouchEnabled(true);
	elseif job < 4 then
		self.armyLabel:setTextById(2100123);
		--self.Button_army:setGrayEnabled(true);
		self.Button_army:setTouchEnabled(false);
	elseif job == 4 and not HeroDataMgr:getFormationIsFull() and HeroDataMgr:getIsFormationOn(self.pos) then
		--self.Button_army:setGrayEnabled(false);
		self.Button_army:setTouchEnabled(true);
		self.armyLabel:setTextById(2100124);
	elseif job == 4 and not HeroDataMgr:getFormationIsFull() then
		--self.Button_army:setGrayEnabled(false);
		self.Button_army:setTouchEnabled(true);
		self.armyLabel:setTextById(2100125);
	elseif job == 4 and HeroDataMgr:getFormationIsFull() then
		--self.Button_army:setGrayEnabled(false);
		self.Button_army:setTouchEnabled(true);
		self.armyLabel:setTextById(2100124);
	end
end

function FairyMainLayer:updateCompose()
	if self.isfriend then
		return;
	end

	local ishave = HeroDataMgr:getIsHave(self.showid);

	self.composePanel:setVisible(not (ishave and HeroDataMgr:getQuality(self.showid) == 5));

	if not self.composePanel:isVisible() then
		return;
	end

	local needs,id,needCnt;
	if not ishave then
		needs = HeroDataMgr:getComposeNeed(self.showid);--合成
		for k,v in pairs(needs) do
			id = k;
			needCnt = v;
		end
	else
		needs = HeroDataMgr:getProgressNeed(self.showid);--进阶
		id = needs[1]
		needCnt = needs[2]
	end


	local icon = TFDirector:getChildByPath(self.composePanel,"Image_sp");
	local iconPath = TabDataMgr:getData("Item",id).icon;
	icon:setTexture(iconPath);
	icon:setContentSize(CCSizeMake(64,64));

	local Label_sp = TFDirector:getChildByPath(self.composePanel,"Label_sp");
	local spCnt = GoodsDataMgr:getItemCount(id);
	Label_sp:setString(spCnt.."/"..needCnt);

	local Label_sp_text = TFDirector:getChildByPath(self.composePanel,"Label_sp_text");

	if spCnt < needCnt then
        Label_sp:setColor(ccc3(220,20,60));
        Label_sp_text:setTextById(800070)
    else
        Label_sp:setColor(ccc3(0,0,0));
        if ishave then
        	Label_sp_text:setTextById(800071);
        else
       		Label_sp_text:setTextById(800072);
       	end
    end
end

local linkTexture = {
	"ui/430.png",
	"ui/431.png",
	"ui/432.png",
	"ui/425.png",
}

local lightLinkTexture = {
	"ui/433.png",
	"ui/434.png",
	"ui/435.png",
	"ui/426.png",
}

function FairyMainLayer:updateEquipLayer()
	local ishave = HeroDataMgr:getIsHave(self.showid);
	dump(self.showid)
	local curCost = HeroDataMgr:getCost(self.showid) + HeroDataMgr:getNewEquipCost(self.showid)
	self.Label_cost:setString(curCost.."/"..HeroDataMgr:getCostMax(self.showid));
	for i=1,3 do
		self:updateOneEquip(i);
	end

	local combInfo = {}
	combInfo[1] = HeroDataMgr:checkCombByPos(self.showid,1,2);
	combInfo[2] = HeroDataMgr:checkCombByPos(self.showid,2,3);
	combInfo[3] = HeroDataMgr:checkCombByPos(self.showid,1,3);

	for i=1,3 do
		local textureTab = linkTexture
		local arrow = self["Image_link"..i]:getChildByName("Image_link_arrow"..i);
		local Label_Unlit = self["Image_link"..i]:getChildByName("Label_Unlit");
		if combInfo[i].isok then
			textureTab = lightLinkTexture;
		end
		self["Image_link"..i]:setTexture(textureTab[i]);
		arrow:setTexture(textureTab[4]);
		Label_Unlit:setVisible(not combInfo[i].isok);

		local skillInfo = TabDataMgr:getData("PassiveSkills",combInfo[i].skillid);
		self["Label_skill_"..i.."_name"]:setTextById(skillInfo.name);
		self["Label_skill_"..i.."_desc"]:setTextById(skillInfo.des);
		self["Label_skill_"..i.."_name"]:setVisible(combInfo[i].isok);
		self["Label_skill_"..i.."_desc"]:setVisible(combInfo[i].isok);
	end

	--套装属性
	local suitIds = HeroDataMgr:checkSuit(self.showid);
	self.Panel_suit:setVisible(#suitIds > 0 and self.curPanel == self.equipPanel)
	if #suitIds > 0 then
	    local skillID = TabDataMgr:getData("EquipmentSuit",suitIds[1]).suitSkill;
	    local skillInfo = TabDataMgr:getData("PassiveSkills",skillID);
	    local nameImg 	= TFDirector:getChildByPath(self.Panel_suit,"Image_name");
	    nameImg:setTexture(TabDataMgr:getData("EquipmentSuit",suitIds[1]).icon);

	    --local Label_skill_name = TFDirector:getChildByPath(self.Panel_suit,"Label_skill_name");
	    local Label_skill_desc = TFDirector:getChildByPath(self.Panel_suit,"Label_skill_desc");
	    local icon 			   = TFDirector:getChildByPath(self.Panel_suit,"Image_icon");
	    --Label_skill_name:setTextById(skillInfo.name);
	    Label_skill_desc:setTextById(skillInfo.des);
	    icon:setTexture(skillInfo.icon or "");
	end
end

function FairyMainLayer:updateOneEquip(idx)
	local ishave = HeroDataMgr:getIsHaveEquip(self.showid ,idx);
	local equipBoard = self["equipPanel"..idx];
	equipBoard.Panel_equip_info:setVisible(ishave);
	equipBoard.Image_select:setVisible(ishave);
	equipBoard.Image_add:setVisible(not ishave);
	Public:BlinkAction(equipBoard.Image_add);
	if self.isfriend then
		equipBoard.Image_add:setVisible(false);
	end
	local equipmentId = nil;
	if ishave then
		equipmentId 	= HeroDataMgr:getEquipIdByPos(self.showid,idx);
		local halfpath 	= EquipmentDataMgr:getEquipHalfPaint(equipmentId);
		equipBoard.Image_equipment:setTexture(halfpath);
		equipBoard.Image_equipment:Size(CCSizeMake(125,157));
		equipBoard.Image_equipment:setPositionY(80);
		equipBoard.Image_equipment:setPositionX(61);

		local lv 		= EquipmentDataMgr:getEquipLv(equipmentId);
		equipBoard.Label_equipLv:setString(lv);

		local starLv	= EquipmentDataMgr:getEquipStarLv(equipmentId);
		for i=1,5 do
			if i > starLv then
				equipBoard["star"..i]:setVisible(false);
			else
				equipBoard["star"..i]:setVisible(true);
			end
		end
		local quality       = EquipmentDataMgr:getEquipQuality(equipmentId);
		equipBoard:setTexture(EC_EquipBoard[quality]);
		equipBoard:setSize(CCSizeMake(125,160));

		local cost 		= EquipmentDataMgr:getEquipCost(equipmentId);
		equipBoard.text_cost:setString(cost);

		local subType 	= EquipmentDataMgr:getEquipSubType(equipmentId);
		equipBoard.Image_equip_type:setTexture(EC_EquipSubTypeIcon2[subType]);
		equipBoard.Image_equip_type:Size(CCSizeMake(24,24));
	else
		equipBoard:setTexture("ui/445.png");
		equipBoard:setSize(CCSizeMake(125,160));
	end
end

function FairyMainLayer:updateAngelLayer()
	for i=1,4 do
		local skillid = HeroDataMgr:getAngelSkllID(self.showid,i);
		local item = self["angelPanel"..i];
		if not skillid then
			item:hide();
			break;
		end
		item:show();
		item.skillid = skillid;
		local iconPath = "";
		local skillInfo = TabDataMgr:getData("Skill",skillid);
		if i == 4 then
			skillInfo = TabDataMgr:getData("PassiveSkills",skillid);
		end

		local Image_icon = TFDirector:getChildByPath(item,"Image_icon");
		Image_icon:setTexture(skillInfo.icon);

		local Label_num = TFDirector:getChildByPath(item,"Label_num");
		local usepoint 	= HeroDataMgr:calcOneAngelSkillPointUse(self.showid,i);
		Label_num:setString(usepoint);

		local Label_type = TFDirector:getChildByPath(item,"Label_type");
		Label_type:setTextById(EC_Angel_Type_Name[i]);
	end

	local Label_skill_point = TFDirector:getChildByPath(self.angelPanel,"Label_skill_point");
	local count = HeroDataMgr:getSkillPoint(self.showid)
	local max 	= HeroDataMgr:getSkillPointMax(self.showid)
    Label_skill_point:setString(count.."/"..max);


    --主技能
    local skillid = HeroDataMgr:getAngelSkllID(self.showid,5);
    local skillInfo = TabDataMgr:getData("Skill",skillid)
	local item = self["angelPanel"..5];
	local Image_icon = TFDirector:getChildByPath(item,"Image_icon");
	Image_icon:setTexture(skillInfo.icon);
	local Label_type = TFDirector:getChildByPath(item,"Label_type");
	Label_type:setTextById(EC_Angel_Type_Name[5]);

    local angelLv = HeroDataMgr:getAngelLevel(self.showid);
    local Label_lv = TFDirector:getChildByPath(item,"Label_lv");
	Label_lv:setString(EC_Num2Roman[angelLv]);

    for i=1,5 do
    	local star = TFDirector:getChildByPath(self.angelPanel,"Image_star"..i);
    	if i > angelLv then
    		star:hide();
    	else
    		star:show();
    	end
    end

    local Label_angel_name = TFDirector:getChildByPath(self.angelPanel,"Label_angel_name");
    local name = HeroDataMgr:getAngelName(self.showid);
    Label_angel_name:setTextById(name);

    local angelLv = HeroDataMgr:getAngelLevel(self.showid);
    if angelLv >= 5 then
    	self.Button_Awaken:hide();
    	TFDirector:getChildByPath(self.angelPanel,"Image_fairyMain_2"):hide();
    	TFDirector:getChildByPath(self.angelPanel,"Label_awaken_point"):hide();
    else
    	self.Button_Awaken:show();
    	TFDirector:getChildByPath(self.angelPanel,"Label_awaken_point"):show();
	    local Label_awaken_point 	= TFDirector:getChildByPath(self.angelPanel,"Label_awaken_point"):show();
	    local Image_awake_icon	 	= TFDirector:getChildByPath(self.angelPanel,"Image_awake_icon");
	    local need,needid 			= HeroDataMgr:getAwakenNeed(self.showid);
	    local needCfg	  			= GoodsDataMgr:getItemCfg(needid)
	    local count = GoodsDataMgr:getItemCount(needid);
	    Label_awaken_point:setString(count.."/"..need);
	    Image_awake_icon:setTexture(needCfg.icon);
	    Image_awake_icon:setSize(CCSizeMake(64,64));
	    if count < need then
	    	Label_awaken_point:setColor(ccc3(255,0,0))
	    else
	    	Label_awaken_point:setColor(ccc3(0,0,0))
	    end

	    TFDirector:getChildByPath(self.angelPanel,"Image_fairyMain_2"):show();
    	TFDirector:getChildByPath(self.angelPanel,"Label_awaken_point"):show();
	end

	--天使形象
	if self.angelModel then
		self.angelModel:removeFromParent();
		self.angelModel = nil;
	end

	local modelPath = HeroDataMgr:getAngelModelPath(self.showid);
	local posOffset = HeroDataMgr:getAngelModelPosOffset(self.showid);
	local scale 	= HeroDataMgr:getAngelModelScale(self.showid)
	local angelModel = SkeletonAnimation:create(modelPath)
    angelModel:setAnimationFps(GameConfig.ANIM_FPS)
    angelModel:playByIndex(0, -1, -1, 1)
    self.Image_angel:getParent():addChild(angelModel);
	angelModel:setPositionX(self.Image_angel:getPositionX() + posOffset.x);
	angelModel:setPositionY(self.Image_angel:getPositionY() + posOffset.y);
	angelModel:setScale(scale);
	angelModel:setVisible(self.curPanel == self.angelPanel);
	self.angelModel = angelModel;

	local awakenLabel = self.Button_Awaken:getChildByName("Label_fairyMain_1");
	awakenLabel:setString(HeroDataMgr:getHeroWeaponName(self.showid)..TextDataMgr:getText(2200003));
  
end

function FairyMainLayer:updateStrengthenLayer()
	self.Label_lv:setString(""..HeroDataMgr:getLv(self.showid).."/"..HeroDataMgr:getCurLevelMax(self.showid));
	self.Label_attr_hp:setString(math.floor(HeroDataMgr:getHp(self.showid)));
	self.Label_attr_def:setString(math.floor(HeroDataMgr:getDef(self.showid)));
	self.Label_attr_atk:setString(math.floor(HeroDataMgr:getAtk(self.showid)));
	Utils:loadingBarAddAction(self.LoadingBar_lv,HeroDataMgr:getExpPercent(self.showid));

	local levelUpExp = HeroDataMgr:getLevelUpExp(self.showid)
	if levelUpExp <= 0 then
		self.Label_curExp:setString("max");
	else
		self.Label_curExp:setString(HeroDataMgr:getExp(self.showid).."/"..levelUpExp);
	end
	-- if HeroDataMgr:getLv(self.showid) >= HeroDataMgr:getCurLevelMax(self.showid) then
	-- 	self.LoadingBar_lv:setPercent(100);
	-- 	self.Label_curExp:setString("");
	-- end
	--突破
	local strengthenLv = HeroDataMgr:getStrengthenLv(self.showid);
	self.strengthenLv:setString("+"..strengthenLv);
	self.strengthenLv:setVisible(strengthenLv > 0);

	local idx = 1;
	if strengthenLv >= 10 then
		for i=1,3 do
			self["Image_tupo_"..i]:setVisible(false);
		end
		self.tupo_need_gold:setVisible(false);
		self.Image_need_coin:setVisible(false);
		self.strengthenBtn:setVisible(false);
	else
		local need = HeroDataMgr:getStrengthenNeed(self.showid);
		for k,v in pairs(need) do
			print("strengthen need id = "..v[1]);
			local itemcount = GoodsDataMgr:getItemCount(v[1]);
			local iconpath  = TabDataMgr:getData("Item",v[1]).icon;
			local color  	= TabDataMgr:getData("Item",v[1]).quality;
			if v[1] == EC_SItemType.GOLD then
				if itemcount < v[2] then
					self.tupo_need_gold:setColor(ccc3(220,20,60));
				else
					self.tupo_need_gold:setColor(ccc3(0,0,0));
				end
				self.tupo_need_gold:setString(itemcount.."/"..v[2]);
				self.tupo_need_gold:setVisible(true);
				self.Image_need_coin:setVisible(true);
			else
				self["tupo_need_"..idx]:setTexture(iconpath);
				self["tupo_need_"..idx]:setContentSize(CCSizeMake(80,80));
				self["Label_need_"..idx]:setString(itemcount.."/"..v[2]);
				if itemcount < v[2] then
					self["Label_need_"..idx]:setColor(ccc3(220,20,60));
				else
					self["Label_need_"..idx]:setColor(ccc3(0,0,0));
				end

				self["Image_tupo_"..idx]:setTexture(EC_ItemCIcon[color]);
				self["Image_tupo_"..idx]:setContentSize(CCSizeMake(100,100));
				self["tupo_need_"..idx]:setTouchEnabled(true);
				self["tupo_need_"..idx]:onClick(function()
						Utils:showInfo(v[1], nil, not self.isfriend);
					end)
				self["Image_tupo_"..idx]:setVisible(true);
				idx = idx + 1;
			end
		end

		self.strengthenBtn:setVisible(true);
	end

	local cantupo = HeroDataMgr:checkHeroStrengthen(self.showid);
	if cantupo then
		self.strengthenBtn:setGrayEnabled(false);
		self.strengthenBtn:setTouchEnabled(true);
	else
		self.strengthenBtn:setGrayEnabled(true,true);
		self.strengthenBtn:setTouchEnabled(false);
	end

	local canlevelup = HeroDataMgr:checkCanLevelUp(self.showid);
	if canlevelup then
		self.levelupBtn:setGrayEnabled(false)
		self.levelupBtn:setTouchEnabled(true);
	else
		self.levelupBtn:setGrayEnabled(true,true)
		self.levelupBtn:setTouchEnabled(false);
	end
end

function FairyMainLayer.tableCellAtIndex(tab, idx)
	local self = tab.logic
	local cell = tab:dequeueCell();
	idx = math.abs(idx - self.showCount )
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

function FairyMainLayer:updateOneHead(cell,idx)
	local selectPoints = {}

	for i=1,4 do
		local point = TFDirector:getChildByPath(cell.item,"Image_select_"..i);
		point:setVisible(false);
		table.insert(selectPoints,point);
	end
	--
	local heroid = HeroDataMgr:getSelectedHeroId(idx);

	local qualityLab = TFDirector:getChildByPath(cell.item,"Label_item_quality");
	qualityLab:setString(HeroDataMgr:getQualityStringById(heroid));

	local icon = TFDirector:getChildByPath(cell.item,"Image_icon");
	icon:setTexture(HeroDataMgr:getIconPathById(heroid));
	icon:setContentSize(CCSizeMake(	120,114));

	local jobIcon = TFDirector:getChildByPath(cell.item,"Image_duty");
	local iconpath = HeroDataMgr:getHeroJobIconPath(heroid);
	jobIcon:setVisible(iconpath ~= "")
	jobIcon:setTexture(iconpath);

	local ishave = HeroDataMgr:getIsHave(heroid);
	local lock   = TFDirector:getChildByPath(cell.item,"Image_lock");
	lock:setVisible(not ishave);

	local itembg = TFDirector:getChildByPath(cell.item,"item");
	local imgSel = TFDirector:getChildByPath(cell.item,"Image_select");
	if self.showidx == idx then
		itembg:setTexture("ui/405.png");
		imgSel:setVisible(true);
	else
		itembg:setTexture("ui/406.png");
		imgSel:setVisible(false);
	end

	if self.showidx == idx then
		self.selectCell = cell;
		for i=1,HeroDataMgr:getShowOneCount(idx) do
			selectPoints[i]:setVisible(true);
			if HeroDataMgr:isSelected(idx,i) then
				selectPoints[i]:setTexture("ui/410.png");
				local id = HeroDataMgr:getHeroId(idx,i);
				print("updateOneHead id 111====>:"..id)
				local isShowRed = HeroDataMgr:checkOneHero(id)
				if isShowRed and not self.isfriend then
					TFDirector:getChildByPath(cell.item,"localRedTips"):show();
				else
			    	TFDirector:getChildByPath(cell.item,"localRedTips"):hide();
				end
			else
				local id = HeroDataMgr:getHeroId(idx,i);
				local ishave = HeroDataMgr:getIsHave(id);
				if ishave then
					selectPoints[i]:setTexture("ui/411.png");
				else
					selectPoints[i]:setTexture("ui/412.png");
				end
			end
		end
	else
		for i=1,HeroDataMgr:getShowOneCount(idx) do
			selectPoints[i]:setVisible(true);
			if HeroDataMgr:isSelected(idx,i) then
				selectPoints[i]:setTexture("ui/407.png");
				local id = HeroDataMgr:getHeroId(idx,i);
				print("updateOneHead id 222====>:"..id)
				local isShowRed = HeroDataMgr:checkOneHero(id)
				if isShowRed and not self.isfriend then
					TFDirector:getChildByPath(cell.item,"localRedTips"):show();
				else
			    	TFDirector:getChildByPath(cell.item,"localRedTips"):hide();
				end
			else
				local id = HeroDataMgr:getHeroId(idx,i);
				local ishave = HeroDataMgr:getIsHave(id);
				if ishave then
					selectPoints[i]:setTexture("ui/408.png");
				else
					selectPoints[i]:setTexture("ui/409.png");
				end
			end
		end
	end
end

function FairyMainLayer.numberOfCellsInTableView(table)
	local self = table.logic
	return HeroDataMgr:getShowCount();
end

function FairyMainLayer.cellBegin(table)
	local self = table.logic
end

function FairyMainLayer.cellEnd(table)
	local self = table.logic
end

function FairyMainLayer.cellSizeForTable(table,idx)
	self = table.logic
	return self.panel_item:getSize().height,self.panel_item:getSize().width
end

function FairyMainLayer:onHide()
	self.super.onHide(self)
end

function FairyMainLayer:removeUI()
	self.super.removeUI(self)

	--从阵容界面打开指定精灵详细界面
	if self.showData and self.showData.showid then
		return;
	end

	HeroDataMgr:changeDataToSelf()
end

function FairyMainLayer:updateRedPoint()
	self.infoTip:setVisible((HeroDataMgr:isCanCompose(self.showid) or HeroDataMgr:chckCanProgress(self.showid)) and not self.isfriend);
	self.fairyTip:setVisible((HeroDataMgr:checkCanLevelUp(self.showid) or HeroDataMgr:checkHeroStrengthen(self.showid)) and not self.isfriend);
	self.equipTip:setVisible((HeroDataMgr:checkOneHeroEquip(self.showid)) and not self.isfriend);
	self.angelTip:setVisible((HeroDataMgr:checkOneHeroAngel(self.showid)) and not self.isfriend);
end

function FairyMainLayer:onShow()
	self.super.onShow(self)
end

return FairyMainLayer;
