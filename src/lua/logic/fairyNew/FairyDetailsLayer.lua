local FairyDetailsLayer = class("FairyDetailsLayer", BaseLayer)


function FairyDetailsLayer:ctor(data)
    self.super.ctor(self,data)
    self.selectCell = nil
    self.paramData_ = data

    self.partition  = 1
    self.angelParticleNode_ = {}

    self.showHeroId = HeroDataMgr.showid
    self.showSkinID = HeroDataMgr:getCurSkin(self.showHeroId)

    if data and data.friend then
    	self.isfriend = true;
    	if data.backTag then
    		self.backTag = data.backTag
    	end
    	self.friendLv = data.friendLv
    end
    if data and data.showid then
    	self.showHeroId = data.showid;
    end
    if data and data.fromChatShare then
    	self.fromChatShare = data.fromChatShare
    end

	local evoData  = HeroDataMgr:getEvolutionNextCanUpDataByAll(self.showHeroId) or {}
	self.partition  = evoData.partition

	self.isShowCamera = false
	self.isShowShare = false
	self.curSelectTab = nil
	self.tabBtnInfo = {
	-- {name = TextDataMgr:getText(1454030), icon = "ui/fairy/new_ui/tab_1.png"},
	-- {name = TextDataMgr:getText(1454010), icon = "ui/fairy/new_ui/tab_2.png"},
	-- {name = TextDataMgr:getText(1454032), icon = "ui/fairy/new_ui/tab_3.png"},
	-- {name = TextDataMgr:getText(1454031), icon = "ui/fairy/new_ui/tab_4.png"},
	-- {name = TextDataMgr:getText(1454056), icon = "ui/fairy/new_ui/tab_6.png"},
	-- {name = TextDataMgr:getText(1454057), icon = "ui/fairy/new_ui/tab_8.png"},
	-- {name = TextDataMgr:getText(900318), icon = "ui/fairy/new_ui/tab_5.png"}
	}

	table.insert(self.tabBtnInfo , {name = TextDataMgr:getText(1454030), icon = "ui/fairy/new_ui/tab_1.png"})
	table.insert(self.tabBtnInfo , {name = TextDataMgr:getText(1454010), icon = "ui/fairy/new_ui/tab_2.png"})
	table.insert(self.tabBtnInfo , {name = TextDataMgr:getText(1454032), icon = "ui/fairy/new_ui/tab_3.png"})
	table.insert(self.tabBtnInfo , {name = TextDataMgr:getText(1454031), icon = "ui/fairy/new_ui/tab_4.png"})
	if GlobalFuncDataMgr:isOpen(8) then
		table.insert(self.tabBtnInfo , {name = TextDataMgr:getText(1454056), icon = "ui/fairy/new_ui/tab_6.png"})
	end
	if GlobalFuncDataMgr:isOpen(9) then
		table.insert(self.tabBtnInfo , {name = TextDataMgr:getText(1454057), icon = "ui/fairy/new_ui/tab_8.png"})
	end
	table.insert(self.tabBtnInfo , {name = TextDataMgr:getText(900318), icon = "ui/fairy/new_ui/tab_5.png"})
	

	self.heroPos = data.pos
	self.gotoWhichTab = data.gotoWhichTab
	self.skyladder = data.skyladder

    self:init("lua.uiconfig.fairyNew.fairyDetails")
end

function FairyDetailsLayer:getClosingStateParams()
    local param1 = {}
    if self.paramData_ then
        param1.friend = self.paramData_.friend
    end
    param1.backTag = self.backTag
    param1.showid = self.showHeroId
    param1.pos = self.heroPos
    param1.gotoWhichTab = self.curSelectTab
	param1.skyladder = self.skyladder
    return {param1}
end

function FairyDetailsLayer:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	FairyDetailsLayer.ui = ui
	self:addLockLayer()
	self.tabButtons = {}
	self.tabPanels = {}
	self.skinItemsList_ = {}

	self.Image_b1           = TFDirector:getChildByPath(ui, "Image_b1")
	self.Panel_left			= TFDirector:getChildByPath(ui, "Panel_left")
	self.Panel_left_details = TFDirector:getChildByPath(ui, "Panel_left_details")
	self.Panel_right 		= TFDirector:getChildByPath(ui, "Panel_right")
	self.Panel_right.origin = self.Panel_right:getPosition()
	self.Panel_crystal_points = TFDirector:getChildByPath(ui, "Panel_crystal_points")
	self.Panel_tabs			= TFDirector:getChildByPath(ui, "Panel_tabs")
	self.Panel_share        = TFDirector:getChildByPath(ui, "Panel_share")

	self.Panel_atts_info 	= TFDirector:getChildByPath(ui, "Panel_atts_info"):hide() 	--属性界面
	self.Panel_Equipment	= TFDirector:getChildByPath(ui, "Panel_Equipment"):hide()	--装备界面
	self.Panel_crystal		= TFDirector:getChildByPath(ui, "Panel_crystal"):hide()  	--突破界面
	self.Panel_skin 		= TFDirector:getChildByPath(ui, "Panel_skin"):hide()		--皮肤界面
	self.Panel_angel		= TFDirector:getChildByPath(ui, "Panel_angel"):hide()		--天使界面
	self.Panel_equip_suit		= TFDirector:getChildByPath(ui, "Panel_equip_suit"):hide()		--装备套装界面
	self.Panel_baoshi		= TFDirector:getChildByPath(ui, "Panel_baoshi"):hide()		--精灵宝石界面

	self.Image_background   = TFDirector:getChildByPath(ui, "background")

	self.Image_hero_power_bg= TFDirector:getChildByPath(ui, "Image_hero_power_bg")
	self.Image_hero			= TFDirector:getChildByPath(ui, "Image_hero")
	self.Panel_hero_touch   = TFDirector:getChildByPath(ui, "Panel_hero_touch")
	self.Label_hero_level	= TFDirector:getChildByPath(ui, "Label_hero_level")
	self.Label_hero_level_max	= TFDirector:getChildByPath(ui, "Label_hero_level_max")
	self.Label_barExpValue  = TFDirector:getChildByPath(ui, "Label_barExpValue")
	self.LoadingBar_exp	    = TFDirector:getChildByPath(ui, "LoadingBar_exp")
	self.Panel_name_info	= TFDirector:getChildByPath(ui, "Panel_name_info")
	self.Panel_hero_suit	= TFDirector:getChildByPath(self.Panel_left, "Panel_suit")
	self.Label_hero_name	= TFDirector:getChildByPath(ui, "Label_hero_name")
	self.Label_enName2	= TFDirector:getChildByPath(ui, "Label_enName2")
	self.Label_enName	= TFDirector:getChildByPath(ui, "Label_enName")
	self.Image_energy_rank = TFDirector:getChildByPath(ui, "Image_energy_rank")

	self.Label_suit_name	= TFDirector:getChildByPath(ui, "Label_suit_name")
	self.Image_suit_bg	= TFDirector:getChildByPath(ui, "Image_suit_bg")

	self.Image_sss_level	= TFDirector:getChildByPath(ui, "Image_sss_level")
	self.Label_hero_power   = TFDirector:getChildByPath(ui, "Label_hero_power")
	self.Image_unlock_item_icon  = TFDirector:getChildByPath(ui, "Image_unlock_item_icon")
	self.Label_unlock_item_count = TFDirector:getChildByPath(ui, "Label_unlock_item_count")
	self.Panel_heros_1 		= TFDirector:getChildByPath(ui, "Panel_heros_1")
	self.Panel_heros_2 		= TFDirector:getChildByPath(ui, "Panel_heros_2")
	self.Button_unlock_hero = TFDirector:getChildByPath(ui, "Button_unlock_hero")
	self.Button_upgrade		= TFDirector:getChildByPath(ui, "Button_upgrade")
	self.upgrade_redTip = TFDirector:getChildByPath(self.Button_upgrade, "Image_redTip"):hide()
	self.Button_eval		= TFDirector:getChildByPath(ui, "Button_eval")

	self.ListView_atts = UIListView:create(TFDirector:getChildByPath(ui, "ScrollView_atts"))
	-- self.ListView_other_atts= UIListView:create(TFDirector:getChildByPath(ui, "ScrollView_other_atts"))
	self.ListView_atts:setItemsMargin(8)
	-- self.ListView_other_atts:setItemsMargin(8)

	self.Panel_att_item     = TFDirector:getChildByPath(ui, "Panel_att_item")
	self.Panel_att_item:setVisible(false)
	self.Panel_skin_item	= TFDirector:getChildByPath(ui, "Panel_skin_model")
	self.Panel_skin_item:setVisible(false)
	self.skinItems			= self.Panel_skin_item
	self.Panel_mainatt_lab_item = TFDirector:getChildByPath(ui, "Panel_mainatt_lab_item")
	self.Panel_mainatt_lab_item:setVisible(false)
	self.Panel_otheratt_lab_item = TFDirector:getChildByPath(ui, "Panel_otheratt_lab_item")
	self.Panel_otheratt_lab_item:setVisible(false)

	self.skinScrollView 		= TFDirector:getChildByPath(self.Panel_skin,"ScrollView_skin");
	self.skinListView 		= UITurnView:create(self.skinScrollView);
	self.skinScrollView:setVisible(false)
	self.skinListView:setItemModel(self.Panel_skin_item)
	self.Button_skin_info	= TFDirector:getChildByPath(ui,"Button_skin_info");
	self.Button_skin_change = TFDirector:getChildByPath(ui,"Button_change");

	--结晶界面
	self.Image_crystal_item = TFDirector:getChildByPath(ui, "Image_crystal_item")
	self.Image_crystal_item:setVisible(false)
	self.Button_up_crystal  = TFDirector:getChildByPath(ui, "Button_up_crystal")
	self.Image_crysRedTip  = TFDirector:getChildByPath(self.Button_up_crystal, "Image_crysRedTip"):hide()

	self.Button_change_crystal  = TFDirector:getChildByPath(ui, "Button_change_crystal")
	self.Button_skinTrail  = TFDirector:getChildByPath(self.Panel_skin, "Button_skinTrail")

	--装备界面
	self.Label_cost 	= TFDirector:getChildByPath(self.Panel_Equipment,"Label_cost");
	self.Image_center_bg_effect 	= TFDirector:getChildByPath(self.Panel_Equipment,"Image_center_bg_effect")
	self.Image_center_name    = TFDirector:getChildByPath(self.Panel_Equipment,"Image_suitSkillName")
	self.Button_use_suit = TFDirector:getChildByPath(self.Panel_Equipment,"Button_use_suit")
	self.Button_save_suit = TFDirector:getChildByPath(self.Panel_Equipment,"Button_save_suit")

	for i=1,3 do
		self["equipPanel"..i] = TFDirector:getChildByPath(self.Panel_Equipment,"Image_equipment_di"..i);
		self["equipPanel"..i].Panel_equip_info 	= TFDirector:getChildByPath(self["equipPanel"..i],"Panel_equip_info");
		self["equipPanel"..i].Image_select 		= TFDirector:getChildByPath(self["equipPanel"..i],"Image_select");
		self["equipPanel"..i].Image_addBack 		= TFDirector:getChildByPath(self["equipPanel"..i],"Image_addBack");
		self["equipPanel"..i].Image_add 		= TFDirector:getChildByPath(self["equipPanel"..i],"Image_add")
		self["equipPanel"..i].Image_redTip 		= TFDirector:getChildByPath(self["equipPanel"..i],"Image_redTip"):hide();
		self["equipPanel"..i].Image_equipment 	= TFDirector:getChildByPath(self["equipPanel"..i],"Image_equipment");
		self["equipPanel"..i].Image_equip_type 	= TFDirector:getChildByPath(self["equipPanel"..i],"Image_equip_type");
		self["equipPanel"..i].text_cost 		= TFDirector:getChildByPath(self["equipPanel"..i],"text_cost");
		self["equipPanel"..i].Label_equipLv 	= TFDirector:getChildByPath(self["equipPanel"..i],"Label_equipLv");
		self["equipPanel"..i].Panel_star 		= TFDirector:getChildByPath(self["equipPanel"..i],"Panel_star")
		self["equipPanel"..i].star1 			= TFDirector:getChildByPath(self["equipPanel"..i],"Image_star1");
		self["equipPanel"..i].star2 			= TFDirector:getChildByPath(self["equipPanel"..i],"Image_star2");
		self["equipPanel"..i].star3 			= TFDirector:getChildByPath(self["equipPanel"..i],"Image_star3");
		self["equipPanel"..i].star4 			= TFDirector:getChildByPath(self["equipPanel"..i],"Image_star4");
		self["equipPanel"..i].star5 			= TFDirector:getChildByPath(self["equipPanel"..i],"Image_star5");
		self["equipPanel"..i].Image_stage1 		= TFDirector:getChildByPath(self["equipPanel"..i],"Image_stage1");
		self["equipPanel"..i].Image_stage2 		= TFDirector:getChildByPath(self["equipPanel"..i],"Image_stage2");
		self["equipPanel"..i].Image_stage3 		= TFDirector:getChildByPath(self["equipPanel"..i],"Image_stage3");

		--组合连线
		self["Image_link"..i]					= TFDirector:getChildByPath(self.Panel_Equipment,"Image_link"..i);

		--组合技能
		self["Label_skill_"..i.."_name"]		= TFDirector:getChildByPath(self.Panel_Equipment,"Label_skill_"..i.."_name");
		self["Label_skill_"..i.."_desc"]		= TFDirector:getChildByPath(self.Panel_Equipment,"Label_skill_"..i.."_desc");
		self["Image_nameBG"..i]		= TFDirector:getChildByPath(self.Panel_Equipment,"Image_nameBG"..i);

		--天梯装备锁定
		self["equipPanel"..i].skylock 			= TFDirector:getChildByPath(self["equipPanel"..i],"Image_skyladder_lock"):hide()
	end

	for i=1,3 do
		local actions =
        {   FadeTo:create(2,235),
            FadeTo:create(2,20)
        }
		local breath = CCRepeatForever:create(Sequence:create(actions))
		self["equipPanelBlink"..i] = TFDirector:getChildByPath(self.Panel_Equipment,"Image_equipment_di"..i)
		TFDirector:getChildByPath(self["equipPanelBlink"..i],"Image_add"):runAction(breath)
	end

	self.Panel_suit = TFDirector:getChildByPath(self.Panel_right,"Panel_suit"):hide();


	--天使
	self.angelPanel		= self.Panel_angel
	self.Button_Awaken	= TFDirector:getChildByPath(self.Panel_angel,"Button_Awaken");
	self.Button_angel_break = TFDirector:getChildByPath(self.Panel_angel,"Button_angel_break")
	self.Label_angel_break = TFDirector:getChildByPath(self.Button_angel_break,"Label_angel_break")
	self.Image_AwakeredTip = TFDirector:getChildByPath(self.Button_Awaken,"Image_redTip"):hide();
	self.Image_angel	= TFDirector:getChildByPath(self.ui,"Image_angel");
	for i=1,7 do
		self["angelPanel"..i] = TFDirector:getChildByPath(self.Panel_angel,"Image_skill_"..i);
	end
	for i=1,4 do
		self["passAngelPanel"..i] = TFDirector:getChildByPath(self.Panel_angel,"Image_pass_skill_"..i);
	end
	self.Panel_angel_info = TFDirector:getChildByPath(self.angelPanel,"Panel_angel_info")


	--装备羁绊
	self.Panel_equip_pos	= TFDirector:getChildByPath(self.Panel_equip_suit,"Panel_equip_pos")
	self.Spine_pos_bg = TFDirector:getChildByPath(self.Panel_equip_pos, "Spine_pos_bg")
	self.equip_suit_pos = {}
	for i = 1, 6 do
		local foo = {}
		local stars = {}
		foo.root = TFDirector:getChildByPath(self.Panel_equip_suit,"Panel_pos"..i)
		foo.Image_quality	= TFDirector:getChildByPath(foo.root,"Image_quality")
		foo.Image_icon	= TFDirector:getChildByPath(foo.root,"Image_icon")
		foo.Image_unlock	= TFDirector:getChildByPath(foo.root,"Image_unlock")
		foo.Image_lock	= TFDirector:getChildByPath(foo.root,"Image_lock")
		foo.Image_select	= TFDirector:getChildByPath(foo.root,"Image_select"):hide()
		foo.Label_level	= TFDirector:getChildByPath(foo.root,"Label_level")
		foo.Panel_info	= TFDirector:getChildByPath(foo.root,"Panel_info")
		foo.skyladderLock = TFDirector:getChildByPath(foo.root,"Image_skysuit_lock"):hide()
		foo.Image_redTip = TFDirector:getChildByPath(foo.root,"Image_redTip"):hide()
		for i=1,5 do
			stars[i] = TFDirector:getChildByPath(foo.root,"Image_star"..i)
		end
		foo.stars = stars
		self.equip_suit_pos[i] = foo
	end
	local Panel_attr = TFDirector:getChildByPath(self.Panel_equip_suit,"Panel_attr")
	self.Panel_hp = TFDirector:getChildByPath(Panel_attr,"Panel_hp")
	self.Panel_atk = TFDirector:getChildByPath(Panel_attr,"Panel_atk")
	self.Panel_def = TFDirector:getChildByPath(Panel_attr,"Panel_def")

	self.Label_atk_value = TFDirector:getChildByPath(Panel_attr,"Label_atk_value")
	self.Label_def_value = TFDirector:getChildByPath(Panel_attr,"Label_def_value")
	self.Label_hp_value = TFDirector:getChildByPath(Panel_attr,"Label_hp_value")

	local Panel_button_suit = TFDirector:getChildByPath(self.Panel_equip_suit,"Panel_button_suit")
	self.Button_suit = TFDirector:getChildByPath(Panel_button_suit,"Button_suit")
	 self.Image_suits = {}
    for i = 1, 3 do
        self.Image_suits[i] = TFDirector:getChildByPath(Panel_button_suit,"Image_suit"..i)
    end
    self.Label_cost_suit = TFDirector:getChildByPath(self.Panel_equip_suit,"Label_cost")
    self.Label_cost_max_suit = TFDirector:getChildByPath(self.Panel_equip_suit,"Label_cost_max")



    --宝石相关
    self.Button_merge = TFDirector:getChildByPath(self.Panel_baoshi,"Button_merge")
    self.Button_tujian = TFDirector:getChildByPath(self.Panel_baoshi,"Button_tujian")
    self.Button_specialCompose = TFDirector:getChildByPath(self.Panel_baoshi,"Button_specialCompose")
    self.Button_deCompose = TFDirector:getChildByPath(self.Panel_baoshi,"Button_deCompose")
    self.gem_pos = {}
    for i = 1, 4 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(self.Panel_baoshi,"Panel_pos_"..i)
        foo.Image_add   = TFDirector:getChildByPath(foo.root,"Image_add")
        foo.Image_bg  = TFDirector:getChildByPath(foo.root,"Image_bg")
        foo.Image_quality_bg    = TFDirector:getChildByPath(foo.root,"Image_quality_bg")
        foo.Image_quality  = TFDirector:getChildByPath(foo.root,"Image_quality")
        foo.Image_icon    = TFDirector:getChildByPath(foo.root,"Image_icon")
		foo.redTip = TFDirector:getChildByPath(foo.root,"Image_redtip"):hide()
        self.gem_pos[i] = foo
    end


	self.Button_share		= TFDirector:getChildByPath(ui, "Button_share")
	self.Button_camera		= TFDirector:getChildByPath(ui, "Button_camera")

	self.Button_weibo		= TFDirector:getChildByPath(self.Panel_share, "Button_weibo")
	self.Button_Qzone		= TFDirector:getChildByPath(self.Panel_share, "Button_Qzone")
	self.Button_QQ		= TFDirector:getChildByPath(self.Panel_share, "Button_QQ")
	self.Button_weixin		= TFDirector:getChildByPath(self.Panel_share, "Button_weixin")

	self.curPanel			= nil

	table.insert(self.tabPanels,{pl = self.Panel_atts_info,uiType = EC_FairyDetailUIType.Attr})
	table.insert(self.tabPanels,{pl = self.Panel_crystal,uiType = EC_FairyDetailUIType.Crystal})
	table.insert(self.tabPanels,{pl = self.Panel_Equipment,uiType = EC_FairyDetailUIType.Equip})
	table.insert(self.tabPanels,{pl = self.Panel_angel,uiType = EC_FairyDetailUIType.Angle})
	if GlobalFuncDataMgr:isOpen(8) then
		table.insert(self.tabPanels,{pl = self.Panel_equip_suit,uiType = EC_FairyDetailUIType.NewEquip})
	end
	if GlobalFuncDataMgr:isOpen(9) then
		table.insert(self.tabPanels,{pl = self.Panel_baoshi,uiType = EC_FairyDetailUIType.BaoShi})
	end
	
	table.insert(self.tabPanels,{pl = self.Panel_skin,uiType = EC_FairyDetailUIType.Skin})

	self.ListView_tab = UIListView:create(TFDirector:getChildByPath(ui, "ScrollView_tab"))
	self.ListView_tab:setItemsMargin(1)
	self.Button_tab_item = TFDirector:getChildByPath(ui, "Button_tab_item")

	CommentDataMgr:sendReqAllComments({2,self.showHeroId})
	self.Panel_danmu = TFDirector:getChildByPath(self.Panel_left,"Panel_danmu")
	local pram = {
	    parent = self.Panel_danmu,
	    type = EC_DanmuType.EVALUATION,
	    autoRun = true,
	    rowNum = 6,
	    resetIndex = true,  
	}

	self.danmuFrame = Utils:createDanmuFrame(pram)

	self.Panel_evaluation = TFDirector:getChildByPath(self.Panel_right,"Panel_evaluation")
	self.Panel_evaluation.origin = self.Panel_evaluation:getPosition()
	self.Panel_EvaluationItem = TFDirector:getChildByPath(self.ui,"Panel_EvaluationItem")
	self.lableItem = TFDirector:getChildByPath(self.ui,"Panel_newCommentLabel")

	local ScrollView_Evaluation = TFDirector:getChildByPath(self.Panel_evaluation,"ScrollView_Evaluation")
	self.uiList_Evaluation = UIListView:create(ScrollView_Evaluation)
	self.TextField_Evaluation = TFDirector:getChildByPath(self.Panel_evaluation,"TextField_Evaluation")
	self.label_evaluation = TFDirector:getChildByPath(self.Panel_evaluation,"label_evaluation")

	self.Button_Evaluation = TFDirector:getChildByPath(self.Panel_evaluation,"Button_Evaluation")

	local params = {
        _type = EC_InputLayerType.OK,
        buttonCallback = function()
            self:onTouchSendBtn()
        end,
        closeCallback = function()
            self:onCloseInputLayer()
        end
    }
    self.inputLayer = require("lua.logic.common.InputLayer"):new(params)
    self:addLayer(self.inputLayer,1000)


	local skyLadderShowId = {[3] = 1,[4] = 1,[5] = 1}
	for i=1,#self.tabBtnInfo do
		local btnItem = self.Button_tab_item:clone()
		local Image_tab_icon = TFDirector:getChildByPath(btnItem, "Image_tab_icon")
		local label_name = TFDirector:getChildByPath(btnItem, "Label_label_name")
		local info = self.tabBtnInfo[i]
		Image_tab_icon:setTexture(info.icon)
		label_name:setText(info.name)
		if i == 4 then
			label_name:setText(HeroDataMgr:getHeroWeaponName(self.showHeroId))
		end
		---天梯隐藏按钮
		if self.skyladder  then
			if skyLadderShowId[i] then
				self.ListView_tab:pushBackCustomItem(btnItem)
				table.insert(self.tabButtons, {btn = btnItem, panel = self.tabPanels[i].pl,id = i,uiType = self.tabPanels[i].uiType})
			end
		else
			self.ListView_tab:pushBackCustomItem(btnItem)
			table.insert(self.tabButtons, {btn = btnItem, panel = self.tabPanels[i].pl,id = i,uiType = self.tabPanels[i].uiType})
		end
	end

	self.Button_eval:setVisible(not self.isfriend)
	self.Button_upgrade:setVisible(not self.isfriend)
	self.Button_skin_change:setVisible(not self.isfriend)
	self.Button_up_crystal:setVisible(not self.isfriend)
	self.Button_skinTrail:setVisible(not self.isfriend)
    self.Button_merge:setVisible(not self.isfriend)
    self.Button_specialCompose:setVisible(not self.isfriend)
    self.Button_deCompose:setVisible(not self.isfriend)
    self.Button_suit:setVisible(not self.isfriend)


	self:updateHeroBaseInfo()
	self:updateEquipLayer()

	
	self:initCrystalPoints()

	local skins = HeroDataMgr:getSkins(self.showHeroId);
	for i,v in ipairs(skins) do
		if not self.skinItemsList_[i] then
			self:addSkinItem(i, v)
		end
		self:updateSkinItem(i)
	end	

	ViewAnimationHelper.doMoveFadeInAction(self.Panel_hero_suit, {direction = 1, distance = 30, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(self.Button_camera, {direction = 1, distance = 30, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(self.Button_eval, {direction = 1, distance = 30, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(self.Image_hero_power_bg, {direction = 2, distance = 30, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(self.Panel_right, {direction = 2, distance = 30, ease = 1})
    if self.gotoWhichTab then
		self:onBottomBtnTouch(self.gotoWhichTab)
	else
		self:onBottomBtnTouch(1)
	end

	self:updateLeftBar()
end



function FairyDetailsLayer:onTouchSendBtn()

end

function FairyDetailsLayer:updateLeftBar()

	if self.isfriend then
		return
	end

	for k,v in ipairs(self.tabButtons) do
		local Image_redTip = TFDirector:getChildByPath(v.btn, "Image_redTip")
		if v.uiType == EC_FairyDetailUIType.Attr then
			local showRedTip = HeroDataMgr:heroCouldUpLevel(self.showHeroId)
			Image_redTip:setVisible(showRedTip)
		elseif v.uiType == EC_FairyDetailUIType.Angle then
			local showRedTip = HeroDataMgr:heroCouldUpAngle(self.showHeroId)
			Image_redTip:setVisible(showRedTip)
		elseif v.uiType == EC_FairyDetailUIType.Equip then
			local showRedTip = HeroDataMgr:heroCouldUpEquip(self.showHeroId)
			Image_redTip:setVisible(showRedTip)
		elseif v.uiType == EC_FairyDetailUIType.NewEquip then
			local showRedTip = HeroDataMgr:heroCouldUpNewEquip(self.showHeroId)
			Image_redTip:setVisible(showRedTip)
		elseif v.uiType == EC_FairyDetailUIType.BaoShi then
			local showRedTip = HeroDataMgr:haveStoneEquip(self.showHeroId)
			Image_redTip:setVisible(showRedTip)
		elseif v.uiType == EC_FairyDetailUIType.Crystal then
			local showRedTip = HeroDataMgr:crystalRedTip(self.showHeroId)
			Image_redTip:setVisible(showRedTip)
		end
	end

end

function FairyDetailsLayer:onNewEquipControlOver(data)
    self:updateEquipSuitLayer()
	self:updateLeftBar()
end

function FairyDetailsLayer:onBaoshiChangeOver()
    self:updateBaoshiLayer()
	self:updateEquipSuitLayer()
end

function FairyDetailsLayer:onItemUpdateEvent()
	self:updateCrystalLayer()
end

function FairyDetailsLayer:spiritInfoChange()
	self:updateAngelLayer()
end

function FairyDetailsLayer:angelBreakOver()
	Utils:openView("fairyNew.FairyAngelBreakUpOverView",{heroId = self.showHeroId,lastLevel = self.angelBreakLevel})
end

function FairyDetailsLayer:onCloseInputLayer()
    self.TextField_Evaluation:closeIME()
end



function FairyDetailsLayer:onCommentResult()
    local toSendId = self.showHeroId

    local msg = {2, toSendId}
    CommentDataMgr:sendReqAllComments(msg)
end

function FairyDetailsLayer:onPriseResult()
    local toSendId = self.showHeroId
    local msg = {2, toSendId}
    CommentDataMgr:sendReqAllComments(msg)
end

function FairyDetailsLayer:onGetAllComments(data)
	local contentOffset 
	if #self.uiList_Evaluation:getItems() > 0 then
		contentOffset = self.uiList_Evaluation.scrollView_:getContentOffset()
	end
    self.uiList_Evaluation:removeAllItems()
    local function handleEachInfo(info) 
	    for i, v in ipairs(info) do
	        local item = self.Panel_EvaluationItem:clone()
	        local playerName = TFDirector:getChildByPath(item, "Label_name")
	        local comment = TFDirector:getChildByPath(item, "Label_desc")
	        local bg_other = TFDirector:getChildByPath(item, "bg_other")
	        local bg_self = TFDirector:getChildByPath(item, "bg_self")
	        local Panel_ydz = TFDirector:getChildByPath(item, "Panel_ydz")
	        local Panel_wdz = TFDirector:getChildByPath(item, "Panel_wdz")
	        local playerId = TFDirector:getChildByPath(item, "Label_number")


	        local playerIcon = TFDirector:getChildByPath(item, "Image_icon")
	        local upNum
	        if  CCUserDefault:sharedUserDefault():getStringForKey(MainPlayer:getPlayerId() .. v.playerId .. v.commentDate) == "up" then
	           	Panel_ydz:show()	
	           	Panel_wdz:hide()
				upNum = TFDirector:getChildByPath(Panel_ydz, "Label_up_num")
	        else
				upNum = TFDirector:getChildByPath(Panel_wdz, "Label_up_num")
	        	Panel_wdz:show()
	        	Panel_ydz:hide()
	        end

	        bg_self:setVisible(MainPlayer:getPlayerId() == v.playerId)
	        bg_other:setVisible(MainPlayer:getPlayerId() ~= v.playerId)
	        local Image_up = TFDirector:getChildByPath(Panel_wdz,"Image_up")
	        Image_up:setTouchEnabled(true)
	        Image_up:onClick(function()
		            if  CCUserDefault:sharedUserDefault():getStringForKey(MainPlayer:getPlayerId() .. v.playerId .. v.commentDate) == "up" then
		                return
		            end
		          	CCUserDefault:sharedUserDefault():setStringForKey(MainPlayer:getPlayerId() .. v.playerId .. v.commentDate, "up")
		            local tempImg = TFImage:create("ui/fairy/evaluation/003.png")
		            Image_up:addChild(tempImg)
		            local scale = ScaleTo:create(0.2, 1.5)
		            local fade = FadeOut:create(0.2)
		            local remove = CallFunc:create(function() tempImg:removeFromParent() end)
		            local spw = {scale, fade}
		            local seq = {Spawn:create(spw), remove}
		            tempImg:runAction(Sequence:create(seq))
		            local toSendId = self.showHeroId

		            local msg = {v.playerId, 2, toSendId, item:getTag()}
		            CommentDataMgr:sendUp(msg)
	            end)
	        playerName:setText(v.name)
	        comment:setText(v.comment)
	        upNum:setText(v.prise < 9999 and v.prise or "9999+")
	        playerId:setText(v.playerId)
	        item:setTag(v.commentDate)
	        playerIcon:setTexture(HeroDataMgr:getSmallIconPathByIdInEvaview(v.heroId))

	        self.uiList_Evaluation:pushBackCustomItem(item)
	    end
	end
    if data.hotInfo then
        handleEachInfo(data.hotInfo)
    end
    if data.newInfo then
        local lableItem = self.lableItem:clone()
        self.uiList_Evaluation:pushBackCustomItem(lableItem)
        handleEachInfo(data.newInfo)
    end
    if contentOffset then
	    self.uiList_Evaluation.scrollView_:setContentOffset(contentOffset)
	end
end

function FairyDetailsLayer:registerEvents()
	-- EventMgr:addEventListener(self,EV_FORMATION_CHANGE,handler(self.onFormationChange, self));
    EventMgr:addEventListener(self,EV_HERO_LEVEL_UP,handler(self.heroInfoChange, self));
    EventMgr:addEventListener(self,EV_HERO_CHANGE_SKIN,handler(self.updateSkin, self));
    EventMgr:addEventListener(self,EV_HERO_PROPERTYCHANGE,handler(self.updateHeroBaseInfo, self));
    --EventMgr:addEventListener(self,EV_HERO_REFRESH,handler(self.onRefresh, self));
    EventMgr:addEventListener(self,EV_HERO_ACTIVECRYSTAL,handler(self.onHeroActiveCrystal, self)); --突破结晶消息的回调
    EventMgr:addEventListener(self,EV_HERO_ACTIVECRYSTAL_BATCH,handler(self.onHeroActiveCrystal, self));
    EventMgr:addEventListener(self,EV_HERO_ANGLE_AWAKE,handler(self.onHeroAngleAwake, self)); --天使觉醒消息的回调

    EventMgr:addEventListener(self,EQUIPMENT_DRESS_NEW_EQUIP,handler(self.onNewEquipControlOver, self))
    EventMgr:addEventListener(self,EQUIPMENT_STRENGTHEN_NEW_EQUIP,handler(self.onNewEquipControlOver, self))
    EventMgr:addEventListener(self,EQUIPMENT_ADVANCE_NEW_EQUIP,handler(self.onNewEquipControlOver, self))
    EventMgr:addEventListener(self,EQUIPMENT_GEM_DRESS_OR_DROP,handler(self.onBaoshiChangeOver, self))

	EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onItemUpdateEvent, self))
	EventMgr:addEventListener(self,EV_SKYLADDER_EQUIP,handler(self.onRecvUpdateSkyInfo, self))
	EventMgr:addEventListener(self,EV_HERO_REFRESH_SPRIT,handler(self.spiritInfoChange, self))
	EventMgr:addEventListener(self,EV_HERO_ANGEL_BREAK,handler(self.angelBreakOver, self))

    EventMgr:addEventListener(self,EV_COMMENT_COMMENTRESULT,handler(self.onCommentResult, self));
    EventMgr:addEventListener(self,EV_COMMENT_GETCOMMENT,handler(self.onGetAllComments, self));
    EventMgr:addEventListener(self,EV_COMMENT_PRISERESULT,handler(self.onPriseResult, self));

    self:setBackBtnCallback(function()
    	local showid = self.showHeroId
    	local friend = self.isfriend
    	local backTag = self.backTag
        AlertManager:close();
 		--Utils:openView("fairyNew.FairyMainLayer", {showid=showid, friend=friend, backTag=backTag})
    end)
    if self.isfriend == true then
        if self.backTag == "teamFight" then
            -- self.topLayer.Button_main:setTexture("ui/cc.png")
            self:setMainBtnCallback(function()
                TeamFightDataMgr:openTeamView()
            end)
        end
    end

    for i,v in ipairs(self.tabButtons) do
	    v.btn:onClick(function()
	        self:onBottomBtnTouch(v.id)
    		GameGuide:checkGuideEnd(self.guideFuncId)
	    end)
    end

     local function onTextFieldChangedHandleAcc(input)
        local text = input:getText()
        local list = string.UTF8ToCharArray(text)
        if #list <= 40 then
            local new_text = string.gsub(text, "·", "")
            input:setText(new_text)	
	        self.label_evaluation:setText(text)
	        self.inputLayer:listener(text)
        end
    end

    local function onTextFieldAttachAcc(input)
        local text = ""
        local new_text = string.gsub(text, "·", "")
        input:setText(new_text)
        self.inputLayer:show();
        self.inputLayer:listener(input:getText())
    end

    self.TextField_Evaluation:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleAcc)
    self.TextField_Evaluation:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
    self.TextField_Evaluation:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)
 	self.label_evaluation:onClick(function()
        self.label_evaluation:setText("")
        self.label_evaluation.isSet = true
        self.TextField_Evaluation:openIME()
    end)
    self.Button_Evaluation:onClick(function ()
        local text = self.label_evaluation:getText()
        if #text == 0 or not self.label_evaluation.isSet then
            -- toastMessage("发送内容不能为空")
            Utils:showTips(800104)
        else
            local toSendId = self.showHeroId

            self.TextField_Evaluation:setText("")
            self.label_evaluation:setText("")

            local msg = {2, toSendId, text}
            CommentDataMgr:sendComment(msg)
        end
    end)
	
	self.Button_upgrade:onClick(function()
		self.notHide = true
    	local layer = require("lua.logic.fairyNew.FairyLevelUp"):new(self.showHeroId)
        AlertManager:addLayer(layer)
        AlertManager:show()
        GameGuide:checkGuideEnd(self.guideFuncId)
	end)
    self.Button_skin_info:onClick(function()
		if self.showSkinID then
			Utils:showInfo(self.showSkinID)
		end
	end)
    self.Button_skin_change:onClick(function()
		HeroDataMgr:changeSkin(self.showHeroId,self.showSkinID, false);
	end)
	self.Button_camera:onClick(function()
		self:onTouchBtnCamera()
	end)

	self.Button_share:onClick(function()
		self:onTouchBtnShare()
	end)
	self.ui:setTouchEnabled(true)
	self.ui:onClick(function()
		if self.isShowCamera then
			self:onTouchBtnCamera()
			self.Image_b1:setTexture("ui/fairy/new_ui/new_bg_01.png")
		end
		self.Panel_share:setVisible(false)
		
		self.isShowShareing = false
	end)

	self.Button_change_crystal:onClick(function()
		self.partition = self.partition or 0
		if self.partition then
			self.partition = self.partition + 1
			self.partition = self.partition > 7 and 1 or self.partition
		else
			self.partition = 1
		end
		self:updateCrystalLayer()
	end)
	self.Button_up_crystal:onClick(function()
		HeroDataMgr.showid = self.showHeroId
		Utils:openView("fairyNew.FairyEvolutionLayer")
		-- HeroDataMgr:getCrystalInfo(self.showHeroId)
		GameGuide:checkGuideEnd(self.guideFuncId)
	end)
	

	self.Button_eval:onClick(function()
		-- 还原弹幕功能为旧的评价功能
		-- TODO OPEN
		local layer = require("lua.logic.fairyNew.EvaluationView"):new({heroOrEquip = 2, heroId = self.showHeroId, callfunc = function()
			
		end})
        AlertManager:addLayer(layer)
		AlertManager:show()

		-- TO DO CLOSE
        -- if not FunctionDataMgr:getModifyFuncIsOpen() then
        --     Utils:showTips(63826)
        --     return
        -- end
		
  		-- if not self.Panel_danmu:isVisible() then
	  	-- 	self.Button_eval:setTextureNormal("ui/fairy/evaluation/011.png")
	  	-- 	self.Panel_danmu:show()
	  	-- 	self.Panel_evaluation:show()
	  	-- 	self:panelRightShow(self.Panel_evaluation)

	  	-- 	for i,v in ipairs(self.tabButtons) do
		-- 		if HeroDataMgr:getIsHave(self.showHeroId) then
		-- 			v.btn:setTextureNormal("")
		-- 			self:panelHide(v.panel)
		-- 		end
		-- 	end
		-- else
		-- 	self.Button_eval:setTextureNormal("ui/fairy/evaluation/012.png")
		-- 	self.Panel_danmu:hide()
		-- 	self:panelHide(self.Panel_evaluation)
		-- 	for i,v in ipairs(self.tabButtons) do
		-- 		if v.id == self.curSelectTab then
		-- 			v.btn:setTextureNormal("ui/fairy/new_ui/tab_btn_select.png");
		-- 			self.curPanel = v.panel
		-- 			self:panelShow(v.panel)
		-- 		end
		-- 	end
		-- end

	end)

	--微博分享
	self.Button_weibo:onClick(function()
		
	end)
	--QQ空间分享
	self.Button_Qzone:onClick(function()
		
	end)
	--QQ分享
	self.Button_QQ:onClick(function()
		
	end)
	--微信分享
	self.Button_weixin:onClick(function()
		
	end)

    --装备插槽
    for i=1,3 do
    	local equipBoard = self["equipPanel"..i];
    	equipBoard:setTouchEnabled(true);
		equipBoard:onClick(function()
			local layer = nil;
			print("touch in "..i);
			local ishave = HeroDataMgr:getIsHaveEquip(self.showHeroId ,i);
			if ishave and not self.isfriend then
				local equipmentId = HeroDataMgr:getEquipIdByPos(self.showHeroId,i);
				Utils:openView("Equipment.EquipmentInfo", {equipmentId = equipmentId,heroid = self.showHeroId,pos = i,
					isfriend = self.isfriend,backTag = self.backTag, fromFairy = true, isSkyladder = self.skyladder})
				-- layer = require("lua.logic.Equipment.EquipmentInfo"):new({equipmentId = equipmentId,heroid = self.showHeroId,pos = i,
				-- 	isfriend = self.isfriend,backTag = self.backTag, fromFairy = true});
			else
				if self.isfriend then
					return
				end


				if not EquipmentDataMgr:isCanUseEquip() then
					-- toastMessage("没有可使用的装备");
					Utils:showTips(493007)
					return
				end

				local list = EquipmentDataMgr:initShowList(self.showHeroId,i,self.skyladder);
				if table.count(list) <= 0 then
					-- toastMessage("没有可使用的装备");
					Utils:showTips(493007)
					return
				end

				local hideAni = function()
					self.notHide = true
				end
				Utils:openView("Equipment.EquipmentSelect", {heroid = self.showHeroId,pos = i,ishave = ishave, isEquip = true, callback = hideAni,isSkyladder = self.skyladder})
				--layer = require("lua.logic.Equipment.EquipmentSelect"):new({heroid = self.showHeroId,pos = i,ishave = ishave, isEquip = true, callback = hideAni});
			end
			--
        	-- AlertManager:addLayer(layer)
        	-- AlertManager:show()
        	GameGuide:checkGuideEnd(self.guideFuncId)
		end)
    end

    for i=1,7 do
		self["angelPanel"..i]:setTouchEnabled(true);
		self["angelPanel"..i]:onClick(function()
				if self["angelPanel"..i].skillid and not self.isfriend then
					Utils:openView("angelNew.AngelInfo", {skillid = self["angelPanel"..i].skillid,
						skillType = self["angelPanel"..i].skillType,idx = i,heroid = self.showHeroId,isfriend = self.isfriend,backTag = self.backTag, isPass = false})
					-- local layer = require("lua.logic.angelNew.AngelInfo"):new({skillid = self["angelPanel"..i].skillid,
					-- 	skillType = self["angelPanel"..i].skillType,idx = i,heroid = self.showHeroId,isfriend = self.isfriend,backTag = self.backTag, isPass = false});
			  --       AlertManager:addLayer(layer)
			  --       AlertManager:show()
			    end
			end)
	end

	for i=1,4 do
		self["passAngelPanel"..i]:setTouchEnabled(true);
		self["passAngelPanel"..i]:onClick(function()
				if  not self.isfriend then
					Utils:openView("angelNew.AngelInfo", {skillid = self["passAngelPanel"..i].skillid,
						skillType = self["passAngelPanel"..i].skillType,idx = i,heroid = self.showHeroId,isfriend = self.isfriend,backTag = self.backTag, isPass = true, whichSlot = i})
					-- local layer = require("lua.logic.angelNew.AngelInfo"):new({skillid = self["passAngelPanel"..i].skillid,
					-- 	skillType = self["passAngelPanel"..i].skillType,idx = i,heroid = self.showHeroId,isfriend = self.isfriend,backTag = self.backTag, isPass = true, whichSlot = i});
			  --       AlertManager:addLayer(layer)
			  --       AlertManager:show()
			    end
			end)
	end

	for i = 1, 6 do
		local foo = self.equip_suit_pos[i]
		foo.root:setTouchEnabled(true)
		foo.root:onClick(function()
			if self.isfriend then
				return
			end
			if i > TabDataMgr:getData("DiscreteData",51001).data.openNum then
				Utils:showTips(100000043)
				return
			end
			if EquipmentDataMgr:getAllNewEquipsCount() < 1 then
 				-- toastMessage("没有可携带的信物"); 				
 				Utils:showTips(100000053)
 				return
  			end
			Utils:openView("fairyNew.EquipSuitMainLayer", {heroId = self.showHeroId, pos = i,isSkyladder = self.skyladder})
		end)
	end

	for i, v in ipairs(self.Image_suits) do
        v:setTouchEnabled(true)
        v:onClick(function()
            local suiIds = EquipmentDataMgr:getNewEquipSuitEffectByHeroId(self.showHeroId)
            if suiIds[i] then
                local suitCfg = EquipmentDataMgr:getNewEquipSuitCfg(suiIds[i])
                local str = TextDataMgr:getTextAttr(suitCfg.desTextId).text
                toastMessage(str)
            else
                Utils:showTips(100000044)
            end
        end)
    end

    for i,v in ipairs(self.gem_pos) do
    	local foo = self.gem_pos[i]
		foo.root:setTouchEnabled(true)
		foo.root:onClick(function()
			if self.isfriend then
				return
			end
			self.selectGemPos = i
			local data = HeroDataMgr:getGemInfoByPos(self.showHeroId, i)
			if data then
				Utils:openView("fairyNew.BaoshiDetailView", {heroId = self.showHeroId,pos = i,fromBag = false})
			else
				Utils:openView("fairyNew.BaoshiChooselView", {heroId = self.showHeroId,pos = i,fromBag = false})
			end
		end)
    end
    self.Button_merge:onClick(function()
		Utils:openView("fairyNew.BaoshiComposeView")
	end)

    self.Button_specialCompose:onClick(function()
		Utils:openView("fairyNew.BaoshiSpecialComposeView")
	end)

    self.Button_deCompose:onClick(function()
		Utils:openView("fairyNew.BaoshiDecomposeView")
	end)



	self.Button_suit:onClick(function()
		Utils:openView("fairyNew.EquipSuitBagShowView")
	end)

	self.Button_use_suit:onClick(function()
		Utils:openView("Equipment.EquipReviewLayer",{isSave = false, heroId = self.showHeroId})
	end)

	self.Button_save_suit:onClick(function()
		Utils:openView("Equipment.EquipReviewLayer",{isSave = true, heroId = self.showHeroId})
	end)

    self.Button_Awaken:onClick(function()
		if HeroDataMgr:getIsHave(self.showHeroId) then
			self.notHide = true
			local angelLv = HeroDataMgr:getAngelLevel(self.showHeroId);
			if angelLv >= 5 then
				Utils:showTips(450033)
				return
			end

            local costNum,costId = HeroDataMgr:getAwakenNeed(self.showHeroId)
            if GoodsDataMgr:currencyIsEnough(costId, costNum) then
                HeroDataMgr:angelAwaken(self.showHeroId)
            else
                Utils:showAccess(costId)
            end
		end
	end)

	self.Button_angel_break:onClick(function()
		self.angelBreakLevel = HeroDataMgr:getAngelBreakLevel(self.showHeroId,self.isfriend)
		Utils:openView("fairyNew.FairyAngelEnergyBreakView",{heroId = self.showHeroId})
	end)

	local function scrollCallback(target, offsetRate, customOffsetRate)
        local items = target:getItem()
        for i, item in ipairs(items) do
            local rate = offsetRate[i]
            local rrate = 1 - rate
            local customRate = customOffsetRate[i]
            local rCustomRate = 1 - customRate
            item:setOpacity(255 * rrate)
            item:setPositionZ(-customRate * 100)
            item:setZOrder(rrate * 100)
        end
    end

    self.skinListView:registerScrollCallback(scrollCallback)
    self.skinListView:registerSelectCallback(handler(self.onSelectItems, self))

    self.Button_skinTrail:onClick(function ( ... )
    	local args = {
            tittle = 2107025,
            content = TextDataMgr:getText(2107024),
            reType = EC_OneLoginStatusType.ReConfirm_Practice,
            confirmCall = function()
                FubenDataMgr:enterPracticeLevel(self.showHeroId,self.showSkinID)
            end,
        }
        Utils:showReConfirm(args)
    end)
end

function FairyDetailsLayer:onSelectItems(target, selectIndex)
	local foo = self.skinItemsList_[selectIndex]
	if self.showSkinID ~= foo.skinId and self.skinScrollView:isVisible() then
		
		self.showSkinID        = foo.skinId         
		self.anim_hero = Utils:createHeroModel(self.showHeroId, self.Image_hero, nil,self.showSkinID)

		local skinInfo = TabDataMgr:getData("HeroSkin", foo.skinId )
		local modelInfo = TabDataMgr:getData("HeroModle",skinInfo.paint)
		local offsetPos = self.anim_hero:getPosition()
		local prePos = self.anim_hero:getPosition()
		if modelInfo.paintDetailPosition then
			offsetPos = prePos + modelInfo.paintDetailPosition
		end

		self.anim_hero:setPosition(offsetPos)
		if modelInfo.paintDetailSize then
			self.anim_hero:setScale(modelInfo.paintDetailSize)
		else
			self.anim_hero:setScale(0.5)
		end
		self:updateSkinBtnState()
   	end
end

function FairyDetailsLayer:updateHeroBaseInfo()


	local skinId =  HeroDataMgr:getCurSkin(self.showHeroId)
	local skinInfo = TabDataMgr:getData("HeroSkin", skinId)
	local modelInfo = TabDataMgr:getData("HeroModle",skinInfo.paint)


	self.anim_hero = Utils:createHeroModel(self.showHeroId, self.Image_hero)
	local offsetPos = self.anim_hero:getPosition()
	local prePos = self.anim_hero:getPosition()
	if modelInfo.paintDetailPosition then
		offsetPos = prePos + modelInfo.paintDetailPosition
	end
	if not self.heroPos then
		self.anim_hero:setPosition(offsetPos)
	end
	if modelInfo.paintDetailSize then
		self.anim_hero:setScale(modelInfo.paintDetailSize)
	else
		self.anim_hero:setScale(0.5)
	end
	if self.heroPos then
		self.anim_hero:setScale(0.75)
		local offsetPos = self.anim_hero:getPosition()
		local prePos = self.anim_hero:getPosition()
		if modelInfo.paintDetailPosition then
			offsetPos = prePos + modelInfo.paintDetailPosition
		end
		local Image_heroPlace = TFDirector:getChildByPath(self.ui, "Image_heroPlace")
		self.anim_hero:setPosition(self.Image_hero:convertToNodeSpaceAR(self.heroPos))
		self.heroPos = nil
		self.anim_hero:runAction(CCMoveTo:create(0.2, offsetPos))
		if modelInfo.paintDetailSize then
			self.anim_hero:runAction(CCScaleTo:create(0.2, modelInfo.paintDetailSize))
		else
			self.anim_hero:runAction(CCScaleTo:create(0.2, 0.5))
		end
	end

	local canlevelup = HeroDataMgr:checkCanLevelUp(self.showHeroId);
	if canlevelup then
		self.Button_upgrade:setGrayEnabled(false)
		self.Button_upgrade:setTouchEnabled(true);
	else
		self.Button_upgrade:setGrayEnabled(true,true)
		self.Button_upgrade:setTouchEnabled(false);
	end

	if not self.isfriend then
		local couldUpNextLevel = HeroDataMgr:heroCouldUpLevel(self.showHeroId)
		self.upgrade_redTip:setVisible(couldUpNextLevel)
	end

	self.Label_hero_name:setText(HeroDataMgr:getNameById(self.showHeroId))
	self.Label_enName2:setText(HeroDataMgr:getEnName2(self.showHeroId))
	self.Label_enName:setText(HeroDataMgr:getEnName(self.showHeroId))
	self.Image_energy_rank:setVisible(false)
	self.Image_energy_rank:setPositionX(self.Label_hero_name:getPositionX() + self.Label_hero_name:getContentSize().width + 25)

	self.Label_suit_name:setText(HeroDataMgr:getTitleStr(self.showHeroId))

	local heroLv = HeroDataMgr:getLv(self.showHeroId)
	local maxexp = TabDataMgr:getData("LevelUp",heroLv).heroExp or "0";
	self.Label_hero_level:setString(heroLv)
	self.Label_hero_level_max:setString("/ "..HeroDataMgr:getCurLevelMax(self.showHeroId))

	if self.isfriend and self.friendLv then
		self.Label_hero_level_max:setString("/ ".. self.friendLv)
	end

	self.Label_hero_level_max:setPositionX(self.Label_hero_level:getPositionX() + self.Label_hero_level:getContentSize().width + 2)
	self.Label_barExpValue:setString((HeroDataMgr:getExp(self.showHeroId) or "0").."/"..maxexp)
	Utils:loadingBarAddAction(self.LoadingBar_exp,HeroDataMgr:getExpPercent(self.showHeroId));
	self.Image_sss_level:setTexture(HeroDataMgr:getQualityPic(self.showHeroId))
	self.Label_hero_power:setString(HeroDataMgr:getHeroPower(self.showHeroId))

	-- self:updateCompose()

	self:updateHeroAttsInfo()
	self:updateLeftBar()
end

function FairyDetailsLayer:onBottomBtnTouch(idx)
	if self.curSelectTab == idx and not self.Panel_danmu:isVisible() then
		return
	end

	local dressIdx = 5 
	local isUseIdx = false
	if GlobalFuncDataMgr:isOpen(8) and GlobalFuncDataMgr:isOpen(9) then
		dressIdx = 7
		isUseIdx = true
	end


	if idx == 2 then
		if not FunctionDataMgr:checkFuncOpen(29) then
			return
		end		
	elseif idx == 3 then
		if not FunctionDataMgr:checkFuncOpen(32) then
			return
		end
	elseif idx == 4 then
		if not FunctionDataMgr:checkFuncOpen(31) then
			return
		end
	elseif idx == 5 and isUseIdx then
		if not FunctionDataMgr:checkFuncOpen(80) then
			return
		end
	elseif idx == 6 and isUseIdx then
		if not FunctionDataMgr:checkFuncOpen(107) then
			return
		end
	end

	local isEvaluation = self.Panel_danmu:isVisible()
	self.Button_eval:setTextureNormal("ui/fairy/evaluation/012.png")
	self.Panel_danmu:hide()
	self:panelHide(self.Panel_evaluation)

	self.curSelectTab = idx
	self.gotoWhichTab = idx
	for i,v in ipairs(self.tabButtons) do
		if v.id == idx then
			v.btn:setTextureNormal("ui/fairy/new_ui/tab_btn_select.png");
			if self.curPanel ~= v.panel or isEvaluation then
				self.curPanel = v.panel
				self:panelShow(v.panel)
			end
		else
			if HeroDataMgr:getIsHave(self.showHeroId) then
				v.btn:setTextureNormal("")
				self:panelHide(v.panel)
			end
		end
	end

	


	if idx == dressIdx then
		if self.showSkinID ~= HeroDataMgr:getCurSkin(self.showHeroId) then
			self.anim_hero = Utils:createHeroModel(self.showHeroId, self.Image_hero)
			self.showSkinID = HeroDataMgr:getCurSkin(self.showHeroId)
			local skinInfo = TabDataMgr:getData("HeroSkin", HeroDataMgr:getCurSkin(self.showHeroId) )
			local modelInfo = TabDataMgr:getData("HeroModle",skinInfo.paint)
			local offsetPos = self.anim_hero:getPosition()
			local prePos = self.anim_hero:getPosition()
			if modelInfo.paintDetailPosition then
				offsetPos = prePos + modelInfo.paintDetailPosition
			end

			self.anim_hero:setPosition(offsetPos)
			if modelInfo.paintDetailSize then
				self.anim_hero:setScale(modelInfo.paintDetailSize)
			else
				self.anim_hero:setScale(0.5)
			end
		end
	end

	
	if idx == dressIdx then
		self:updateSkinBtnState()
	elseif idx == 3 then
		self:updateEquipLayer()
	elseif idx == 4 then
		self:updateAngelLayer()
	elseif idx == 2 then
		self:updateCrystalLayer()
	elseif idx == 5 and isUseIdx then
		self:updateEquipSuitLayer()
	elseif idx == 6 and isUseIdx then
		self:updateBaoshiLayer()
	elseif idx == 1 then	
		self:updateHeroBaseInfo()	
	end

	local showAngelFlag = self.curPanel == self.Panel_angel or self.curPanel == self.Panel_baoshi
	if self.angelModel then
		self.angelModel:setVisible(showAngelFlag)
	end
	if self.anim_hero then
		self.anim_hero:setVisible(not showAngelFlag)
	end
	self.Panel_name_info:setVisible(not showAngelFlag)
	--self.Panel_suit:setVisible(self.curPanel ~= self.Panel_angel)
	self.Button_eval:setVisible(not showAngelFlag and not self.isfriend)
	--self.Button_eval:setVisible(false)
	self.Button_camera:setVisible(not showAngelFlag)
	--self.Button_share:setVisible(self.curPanel ~= self.Panel_angel)
	self.Image_hero_power_bg:setVisible(not showAngelFlag)

	self.Image_background:setTexture(not showAngelFlag and "ui/common/bg2.png" or "ui/fairy_skill/BG.png")
	self.Image_suit_bg:setVisible(not showAngelFlag)
	self.Label_suit_name:setVisible(not showAngelFlag)
	if self.skyladder then
		self.Button_camera:setVisible(false)
		self.Button_eval:setVisible(false)
	end

	self.Image_background:setTexture(self.curPanel~=self.Panel_angel and "ui/common/bg2.png" or "ui/fairy_skill/BG.png")
	self.Image_suit_bg:setVisible(not (btn == self.Button_tab_4))
	self.Label_suit_name:setVisible(not (btn == self.Button_tab_4))

	if idx == dressIdx then
		self.showSkinID = self.skinItemsList_[1].skinId
		self.skinScrollView:setVisible(true)
		self.skinScrollView:setOpacity(0)
		self.skinScrollView:runAction(CCFadeIn:create(0.2))
		self.skinListView:scrollToItem(1)
		self:updateSkinBtnState()

		--self.showSkinID = HeroDataMgr:getCurSkin(self.showHeroId)
	else
		self.skinScrollView:setVisible(false)
	end

end

function FairyDetailsLayer:addSkinItem(idx, skinId)	
	local item = self.skinListView:pushBackItem()
	local foo = {}
	foo.root = item
	item:setVisible(true)
	foo.image = TFDirector:getChildByPath(foo.root,"Image_skin")
	foo.skinId = skinId
	foo.imageLock = TFDirector:getChildByPath(foo.root,"Image_lock")
	foo.Label_skin_name	= TFDirector:getChildByName(foo.root,"Label_skin")
	foo.Panel_Touch	= TFDirector:getChildByName(foo.root,"Panel_Touch")
	foo.Button_skinDetail = TFDirector:getChildByName(foo.root,"Button_skinDetail")
	foo.Image_using = TFDirector:getChildByPath(foo.root, "Image_using")
	self.skinItemsList_[idx] = foo
	
   	return foo.root
end

function FairyDetailsLayer:updateSkinItem(idx)
    local foo = self.skinItemsList_[idx]
    local skinData = TabDataMgr:getData("HeroSkin",foo.skinId)
    local item = foo.root
    item:setVisible(true)
    item:setTouchEnabled(true)
    local isUnlock = HeroDataMgr:checkSkinUnlock(foo.skinId)
    local curskinID     = self.showSkinID or HeroDataMgr:getCurSkin(self.showHeroId)
	local isUsing = tobool(HeroDataMgr:getCurSkin(self.showHeroId) == foo.skinId)
	if curskinID == foo.skinId then
	    --self.Button_skin_change:setGrayEnabled(true,true);
	    self.Button_skin_change:setTouchEnabled(false);
	    --self.showSkinID = item.skinID;
	elseif not isUnlock then
	    --self.Button_skin_change:setGrayEnabled(true,true);
	    self.Button_skin_change:setTouchEnabled(false);
	else
	    --self.Button_skin_change:setGrayEnabled(false);
	    self.Button_skin_change:setTouchEnabled(true);
	end
	foo.Image_using:setVisible(isUsing)
	foo.imageLock:setVisible(not isUnlock)
	foo.Label_skin_name:setTextById(skinData.nameTextId)
	foo.image:setTexture(TabDataMgr:getData("HeroSkin", foo.skinId).skinImg)
  	foo.Panel_Touch:onClick(function()
       if self.showSkinID ~= foo.skinId then
			self.showSkinID        = foo.skinId           
			self.anim_hero = Utils:createHeroModel(self.showHeroId, self.Image_hero, nil,self.showSkinID)

			local skinInfo = TabDataMgr:getData("HeroSkin", foo.skinId )
			local modelInfo = TabDataMgr:getData("HeroModle",skinInfo.paint)
			local offsetPos = self.anim_hero:getPosition()
			local prePos = self.anim_hero:getPosition()
			if modelInfo.paintDetailPosition then
				offsetPos = prePos + modelInfo.paintDetailPosition
			end

			self.anim_hero:setPosition(offsetPos)

			if modelInfo.paintDetailSize then
				self.anim_hero:setScale(modelInfo.paintDetailSize)
			else
				self.anim_hero:setScale(0.5)
			end
			self.skinListView:scrollToItem(idx)
			self:updateSkinBtnState()
       end
   end)
  	foo.Button_skinDetail:onClick(function()
  		if self.showSkinID then
  			self.notHide = true
			Utils:showInfo(self.showSkinID , nil , true)
		end
  	end)
end

function FairyDetailsLayer:updateSkin(delay)
	--VoiceDataMgr:playVoiceByHeroID("change_equip",self.showHeroId)
	for i, v in ipairs(self.skinItemsList_) do
		self:updateSkinItem(i)
	end
	self:updateSkinBtnState()
	self.showSkinID = HeroDataMgr:getCurSkin(self.showHeroId)
	VoiceDataMgr:playVoiceByHeroID("change_hero",self.showHeroId);
end


function FairyDetailsLayer:refreshSkinListView( )
	-- for i,v in ipairs(self.skinListView:getItems()) do
 --        self:updateSkinItem(v,i)
 --    end
end


function FairyDetailsLayer:updateSkinBtnState()
	local curskinID 	= HeroDataMgr:getCurSkin(self.showHeroId);
	local skinID 		= self.showSkinID
	local isUnlock		= HeroDataMgr:checkSkinUnlock(skinID);
	self.Button_skinTrail:setVisible(false);
	if curskinID == skinID then
    	self.Button_skin_change:setVisible(false);
    	self.Button_skin_change:setTouchEnabled(false);
    elseif not isUnlock then
    	self.Button_skin_change:setVisible(false);
    	self.Button_skin_change:setTouchEnabled(false);
    	self.Button_skinTrail:setVisible(true)
    else
    	self.Button_skin_change:setVisible(true);
    	self.Button_skin_change:setTouchEnabled(true);
   	end

   	if self.isfriend then
   		self.Button_skin_change:setVisible(false)
    	self.Button_skinTrail:setVisible(false)
   	end
end

local linkTexture = {
	"ui/fairy_particle/ui_08.png",
	"ui/fairy_particle/ui_08.png",
	"ui/fairy_particle/ui_08.png",
	"ui/fairy_particle/ui_06.png",
}

local lightLinkTexture = {
	"ui/fairy_particle/ui_14.png",
	"ui/fairy_particle/ui_14.png",
	"ui/fairy_particle/ui_14.png",
	"ui/fairy_particle/ui_07.png",
}

function FairyDetailsLayer:updateEquipLayer()
	--TODO CLOSE
	--self.Button_use_suit:setVisible(not self.isfriend)
	--self.Button_save_suit:setVisible(not self.isfriend)
	self.Button_use_suit:hide()
	self.Button_save_suit:hide()
	local equipedState = HeroDataMgr:checkEquipmentUnLockState(self.showHeroId)
	self.Button_save_suit:setGrayEnabled(not equipedState)
	self.Button_save_suit:setTouchEnabled(equipedState)
	if self.skyladder then
		self.Button_use_suit:setVisible(false)
		self.Button_save_suit:setVisible(false)
	end
	local ishave = HeroDataMgr:getIsHave(self.showHeroId);
	local costMax = HeroDataMgr:getCostMax(self.showHeroId)
	if type(costMax) == "table" then
		costMax = costMax.val
	end
	local curCost = HeroDataMgr:getCost(self.showHeroId) + HeroDataMgr:getNewEquipCost(self.showHeroId)
	self.Label_cost:setString(curCost.."/"..costMax);
	for i=1,3 do
		self:updateOneEquip(i);
	end

	local combInfo = {}
	combInfo[1] = HeroDataMgr:checkCombByPos(self.showHeroId,1,2);
	combInfo[2] = HeroDataMgr:checkCombByPos(self.showHeroId,2,3);
	combInfo[3] = HeroDataMgr:checkCombByPos(self.showHeroId,1,3);
	local flag = true
	for i=1,3 do
		local textureTab = linkTexture
		local arrow = self["Image_link"..i]:getChildByName("Image_link_arrow"..i);
		if combInfo[i].isok then
			textureTab = lightLinkTexture;
		else
			flag = false
		end
		self["Image_link"..i]:getChildByName("Image_Link"):setTexture(textureTab[i]);
		
		if flag then
			self["Image_link"..i]:getChildByName("Image_Link"):setVisible(true)
			local effectLink = TFDirector:getChildByPath(self["Image_link"..i], "Spine_active")
			effectLink:addMEListener(TFARMATURE_COMPLETE,function(_skeletonNode)
		        _skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
		        self["Image_link"..i]:getChildByName("Image_Link"):setVisible(true)
		    end)
			effectLink:playByIndex(0, -1, -1, 0)
		end
		arrow:setTexture(textureTab[4]);
		local skillInfo = TabDataMgr:getData("PassiveSkills",combInfo[i].skillid);
		self["Label_skill_"..i.."_name"]:setTextById(skillInfo.name);
		self["Label_skill_"..i.."_desc"]:setTextById(skillInfo.des);
		self["Label_skill_"..i.."_name"]:setVisible(combInfo[i].isok);
		self["Label_skill_"..i.."_desc"]:setVisible(combInfo[i].isok);
		self["Image_nameBG"..i]:setVisible(combInfo[i].isok);
	end
	if flag then
		
		local equipmentId     = HeroDataMgr:getEquipIdByPos(self.showHeroId,1)
        local suitData1 = EquipmentDataMgr:getEquipSuitInfos(equipmentId)

        local equipmentId2     = HeroDataMgr:getEquipIdByPos(self.showHeroId,2)
        local suitData2= EquipmentDataMgr:getEquipSuitInfos(equipmentId2)

        local equipmentId3     = HeroDataMgr:getEquipIdByPos(self.showHeroId,3)
        local suitData3 = EquipmentDataMgr:getEquipSuitInfos(equipmentId3)

        local flagOneSuit = false
        local suitid = -1
        for k, v in pairs(suitData1) do
        	if suitData2[k] and suitData3[k] then
        		suitid = tonumber(k)
        		flagOneSuit = true
        	end
        end
        if flagOneSuit then
        	self.Image_center_bg_effect:setVisible(true)
			self.Image_center_name:setVisible(true)
		else
			self.Image_center_bg_effect:setVisible(false)
			self.Image_center_name:setVisible(false)
		end
        if suitid ~= -1 and TabDataMgr:getData("EquipmentSuit",suitid).icon and TabDataMgr:getData("EquipmentSuit",suitid).nameIcon then
       	 	self.Image_center_bg_effect:setTexture(TabDataMgr:getData("EquipmentSuit",suitid).icon)
       	 	self.Image_center_name:setTexture(TabDataMgr:getData("EquipmentSuit",suitid).nameIcon)
       	else
       		self.Image_center_bg_effect:setTexture("");
       		self.Image_center_name:setTexture("");
   		end

        self.Image_center_bg_effect:onClick(function()
            local skillID = TabDataMgr:getData("EquipmentSuit",suitid).suitSkill
            local skillInfo = TabDataMgr:getData("PassiveSkills",skillID)
            local Label_skill_desc = TFDirector:getChildByPath(self.Panel_Equipment,"Label_suitDesc")
            local Image_skill_desc = TFDirector:getChildByPath(self.Panel_Equipment,"Image_suitDesc")

            Image_skill_desc:setVisible(true)
            Label_skill_desc:setTextById(skillInfo.des)
            
            Label_skill_desc:setVisible(true)
            Image_skill_desc:setOpacity(255)
            local size = Label_skill_desc:getContentSize()
            size.width = size.width + 20
            size.height = size.height
            Image_skill_desc:setContentSize(size)
            Image_skill_desc:runAction(Sequence:create({DelayTime:create(2), FadeOut:create(0.5)}))
            end)
	else
		self.Image_center_bg_effect:setVisible(false)
		self.Image_center_name:setVisible(false)
	end
end

function FairyDetailsLayer:updateEquipSuitLayer()
	local fetterInfo = HeroDataMgr:getNewEquipFetterInfo(self.showHeroId)
	local openNum = TabDataMgr:getData("DiscreteData",51001).data.openNum
	local suiIds = EquipmentDataMgr:getNewEquipSuitEffectByHeroId(self.showHeroId)
	for i,foo in ipairs(self.equip_suit_pos) do
		foo.Image_unlock:setVisible(i <= openNum)
		foo.Panel_info:setVisible(i <= openNum)
		foo.Image_lock:setVisible(i > openNum)
		foo.Image_unlock:removeAllChildren()
		local euipMent = HeroDataMgr:getNewEquipInfoByPos(self.showHeroId, i)
		if euipMent then
			for m,suitId in pairs(suiIds) do
                local suitCfg = EquipmentDataMgr:getNewEquipSuitCfg(suitId)
                for n,cid in ipairs(suitCfg.suitarmsID) do
                    if tonumber(euipMent.cid) == tonumber(cid) then
                        local imageEffect = CCSprite:create("ui/new_equip/TZ_bg_7.png")
                        foo.Image_unlock:addChild(imageEffect, 5)
                    end
                end
            end
			local equipCfg = EquipmentDataMgr:getNewEquipCfg(euipMent.cid)
			local equipInfo = EquipmentDataMgr:getNewEquipInfoByCid(euipMent.cid)
			local level, stage
			if self.isFriend then
				level = euipMent.level
				stage = euipMent.stage
			else
				level = equipInfo and equipInfo.level or 1
				stage = equipInfo and equipInfo.stage or 1
			end
			foo.Panel_info:setVisible(true)
			foo.Image_icon:setScale(0.7)
			foo.Image_icon:setTexture(equipCfg.icon)
			foo.Image_quality:setTexture(EquipmentDataMgr:getNewEquipQualityIcon(equipCfg.quality))
			foo.Label_level:setText(tostring(level))
			local maxStar = EquipmentDataMgr:getNewEquipMaxStar(euipMent.cid)
			local posArrar = EquipmentDataMgr:getNewEquipStarPosArrar(maxStar)
			for j,v in ipairs(foo.stars) do
				if j <= maxStar then
		            v:setVisible(true)
		            v:setPosition(posArrar[j])
		            if j <= stage then
		                v:setTexture("ui/common/star.png")
		            else
		                v:setTexture("ui/common/starBack.png")
		            end
		        else
		            v:setVisible(false)
		        end
			end
			local bindHero = SkyLadderDataMgr:getSkyHeroNewEquipBind(euipMent.id)
			foo.skyladderLock:setVisible(self.skyladder and bindHero == self.showHeroId)

			if not self.isfriend then
				local canStrengthen = EquipmentDataMgr:newEquipCouldStrengthen(euipMent.cid)
				local canUpstage = EquipmentDataMgr:newEquipCouldUpStage(euipMent.cid)
				local showTip = canStrengthen or canUpstage
				foo.Image_redTip:setVisible(showTip)
			end
		else
			foo.Panel_info:setVisible(false)
			local haveEquip = false
			if not self.isfriend then
				local job = HeroDataMgr:getHeroJob(self.showHeroId)
				if job < 4 then
					local cost = HeroDataMgr:getCost(self.showHeroId) + HeroDataMgr:getNewEquipCost(self.showHeroId)
					local costmax = HeroDataMgr:getCostMax(self.showHeroId)
					local list = EquipmentDataMgr:getNewEquipsBySortType(self.showHeroId,1);
					if table.count(list) > 0 then
						for i1, v in ipairs(list) do
							if v.heroId == "0" then
								local equipCfg = EquipmentDataMgr:getNewEquipCfg(v.cid)
								local equipcost = equipCfg.cost
								if equipcost <= costmax - cost then
									haveEquip = true
									break
								end
							end
						end
					end
				end
			end
			foo.Image_redTip:setVisible(haveEquip)
		end
	end

	local costMax = HeroDataMgr:getCostMax(self.showHeroId)

    self.Label_cost_max_suit:setString("/"..costMax)
    local curCost = HeroDataMgr:getCost(self.showHeroId) + HeroDataMgr:getNewEquipCost(self.showHeroId)
    self.Label_cost_suit:setString(tostring(curCost))
    self.Label_cost_suit:setPositionX(self.Label_cost_max_suit:getPositionX() - self.Label_cost_max_suit:getContentSize().width - 2)

	local position = {ccp(17, 37), ccp(243, 37), ccp(17,6)}
	local allValus = EquipmentDataMgr:getHeroNewEquipAttribute(self.showHeroId)
	local hpValue = allValus[EC_Attr.HP] or 0 
	local atkValue = allValus[EC_Attr.ATK] or 0
	local defValue = allValus[EC_Attr.DEF] or 0
	self.Label_hp_value:setText(hpValue)
	self.Label_atk_value:setText(atkValue)
	self.Label_def_value:setText(defValue)
	self.Panel_hp:setVisible(true)
	self.Panel_atk:setVisible(true)
	self.Panel_def:setVisible(true)
	self.Panel_hp:setPosition(position[1])
	self.Panel_atk:setPosition(position[2])
	self.Panel_def:setPosition(position[3])

	if hpValue <= 0 then
		self.Panel_def:setPosition(self.Panel_atk:getPosition())
		self.Panel_atk:setPosition(self.Panel_hp:getPosition())
		self.Panel_hp:setVisible(false)
	end
	if atkValue <= 0 then
		self.Panel_def:setPosition(self.Panel_atk:getPosition())
		self.Panel_atk:setVisible(false)
	end
	if defValue <= 0 then
		self.Panel_def:setVisible(false)
	end

    for i, v in ipairs(self.Image_suits) do
    	v:removeAllChildren()
        if suiIds[i] then
            local suitCfg = EquipmentDataMgr:getNewEquipSuitCfg(suiIds[i])
            v:setTexture(suitCfg.icon)
            local spineEffect = SkeletonAnimation:create("effect/effect_ui25/effect_ui25")
            spineEffect:play("down",true)
            v:addChild(spineEffect, -1)
        else
            v:setTexture("ui/new_equip/029.png")
        end
    end
end

function FairyDetailsLayer:updateOneEquip(idx)
	local ishave = HeroDataMgr:getIsHaveEquip(self.showHeroId ,idx);
	local equipBoard = self["equipPanel"..idx];
	if ishave and (not equipBoard.Panel_equip_info:isVisible()) then
		local effect = equipBoard:getChildByName("Spine_equiped")
		effect:playByIndex(0, -1, -1, 0)
	end
	equipBoard.Panel_equip_info:setVisible(ishave);
	equipBoard.Image_select:setVisible(false);

	if ishave then
		local equipmentId 	= HeroDataMgr:getEquipIdByPos(self.showHeroId,idx);
		local quality = EquipmentDataMgr:getEquipQuality(equipmentId)
		equipBoard.Image_addBack:setTexture("ui/fairy_particle/" .. quality .. ".png")

		local stepBgImg = TFDirector:getChildByPath(equipBoard.Panel_equip_info, "img_step_bg")
        stepBgImg:show()
        local stepLabel = TFDirector:getChildByPath(stepBgImg, "label_step")      
        stepLabel:setText(EquipmentDataMgr:getStepText(equipmentId))
        local step = EquipmentDataMgr:getEquipStep(equipmentId)
        if step <= 0 then
            stepBgImg:hide()
        end
	end
	if not ishave then
		equipBoard.Image_addBack:setTexture("ui/fairy_particle/ui_01.png")
	end
	equipBoard.Image_add:setVisible(false);
	if self.isfriend then
		equipBoard.Image_add:setVisible(false);
	end
	local equipmentId = nil;
	if ishave then
		equipmentId 	= HeroDataMgr:getEquipIdByPos(self.showHeroId,idx);
		local halfpath 	= EquipmentDataMgr:getEquipHalfPaint2(equipmentId);
		equipBoard.Image_equipment:setTexture(halfpath);
		-- equipBoard.Image_equipment:Size(CCSizeMake(125,157));
		-- equipBoard.Image_equipment:setPositionY(80);
		-- equipBoard.Image_equipment:setPositionX(61);

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
		local starLevel = EquipmentDataMgr:getEquipStarLevel(equipmentId)
		if starLevel >= 1 and starLevel < 2 then
			equipBoard["Panel_star"]:setScale(0.85)
		elseif starLevel >= 2 then
			equipBoard["Panel_star"]:setScale(0.75)
		else
			equipBoard["Panel_star"]:setScale(1.0)
		end
	    equipBoard["Image_stage1"]:setVisible(starLevel >= 1 and starLevel <= 2)
	    equipBoard["Image_stage2"]:setVisible(starLevel == 2)
	    equipBoard["Image_stage3"]:setVisible(starLevel == 3)
		-- local quality       = EquipmentDataMgr:getEquipQuality(equipmentId);
		-- equipBoard:setTexture(EC_EquipBoard[quality]);
		-- equipBoard:setSize(CCSizeMake(125,160));

		local cost 		= EquipmentDataMgr:getEquipCost(equipmentId);
		equipBoard.text_cost:setString(cost);

		local subType 	= EquipmentDataMgr:getEquipSubType(equipmentId);
		equipBoard.Image_equip_type:setTexture(EC_EquipSubTypeIcon2[subType]);
		equipBoard.Image_equip_type:Size(CCSizeMake(24,24));

		---天梯绑定关系
		local bindHero = SkyLadderDataMgr:getSkyHeroEquipBind(equipmentId)
		equipBoard.skylock:setVisible(self.skyladder and bindHero == self.showHeroId)


		local showRedTip = false
		if not self.isfriend then
			local upEquip = EquipmentDataMgr:equipCouldUp(equipmentId)
			showRedTip = showRedTip or upEquip
			local upStar = EquipmentDataMgr:equipCouldUpStar(equipmentId)
			showRedTip = showRedTip or upStar
			local haveBeter = EquipmentDataMgr:haveBetterEquip(equipmentId)
			showRedTip = showRedTip or haveBeter
		end
		equipBoard["Image_redTip"]:setVisible(showRedTip)
	else
		-- equipBoard:setTexture("ui/445.png");
		-- equipBoard:setSize(CCSizeMake(125,160));
        equipBoard.skylock:setVisible(false)
		local haveEquip = false
		if not self.isfriend then
			local job = HeroDataMgr:getHeroJob(self.showHeroId)
			if job < 4 then
				local list = EquipmentDataMgr:initShowList(self.showHeroId,idx);
				if table.count(list) > 0 then
					local cost = HeroDataMgr:getCost(self.showHeroId) + HeroDataMgr:getNewEquipCost(self.showHeroId)
					local costmax = HeroDataMgr:getCostMax(self.showHeroId)
					for i1, v1 in ipairs(list) do
						for i2, v2 in ipairs(v1) do
							local equipcost = EquipmentDataMgr:getEquipCost(v2)
							if equipcost <= costmax - cost then
								haveEquip = true
								break
							end
						end
					end
				end
			end
		end
		equipBoard["Image_redTip"]:setVisible(haveEquip)
	end

end

function FairyDetailsLayer:getAngleSkillItemBySkillType(skillType)
	for i=1, 7 do
		local item = self["angelPanel"..i]
		if item:getTag() == skillType then
			return item
		end
	end
end

function FairyDetailsLayer:updateAngelLayer()
    local skillTypes = {EC_SKILL_TYPE.NORMAL, EC_SKILL_TYPE.SKILL_1, EC_SKILL_TYPE.SKILL_2, 
        EC_SKILL_TYPE.BISHA, EC_SKILL_TYPE.SHANBI, EC_SKILL_TYPE.JUEXING, EC_SKILL_TYPE.QIEHUAN}

	local curSKillPoint    = AngelDataMgr:getAngleTabCurUseSkillPoint(self.showHeroId)
	for i,skillType in pairs(EC_SKILL_TYPE) do
		
		if skillType < 8 then
			local angleBase = AngelDataMgr:getAngleBaseData(self.showHeroId,skillType)
			local skillid = HeroDataMgr:getSkinAngleSkillID(self.showHeroId,skillType);
			local item = self:getAngleSkillItemBySkillType(skillType)
			if not skillid then
				-- item:hide();
			else
				item:show();
				item.skillid = skillid;
				item.skillType = skillType
				local iconPath = "";
				local skillInfo = TabDataMgr:getData("Skill",skillid);
				-- if i == 4 then
				-- 	skillInfo = TabDataMgr:getData("PassiveSkills",skillid);
				-- end

				local Image_icon = TFDirector:getChildByPath(item,"Image_icon");
				if skillInfo then
					Image_icon:setTexture(skillInfo.icon);
				end

				local Label_num = TFDirector:getChildByPath(item,"Label_num");
				local usepoint 	= HeroDataMgr:calcOneAngelSkillPointUse(self.showHeroId,i);
				Label_num:setString(usepoint);

				local Label_type = TFDirector:getChildByPath(item,"Label_type");
				Label_type:setTextById(EC_Angel_Type_Name_Id[skillType]);

				local Image_redTip = TFDirector:getChildByPath(item,"Image_redTip"):hide();
				if not self.isfriend then
					local job = HeroDataMgr:getHeroJob(self.showHeroId)
					if job < 4 then
						local couldUp = false
						if skillType ~= EC_SKILL_TYPE.JUEXING and angleBase then
							for pos,skillId in pairs(angleBase) do
								local curLevel = AngelDataMgr:getSkillLevel(self.showHeroId, skillType, pos)
								local maxLevel = AngelDataMgr:getSkillMaxLevel(self.showHeroId, skillType, pos)
								local oneLvSkillId = AngelDataMgr:getAngleBaseData(self.showHeroId, skillType, pos, 1)
								local isUnlock = AngelDataMgr:getIsUnlockSkill(oneLvSkillId)
								if isUnlock and curLevel < maxLevel then
									local nextLvSkillId = AngelDataMgr:getAngleBaseData(self.showHeroId, skillType, pos, curLevel + 1)
									local nextLevelConfig  = AngelDataMgr:getAngleConfig(nextLvSkillId)
									local isUnlockNextLv,notUnlockNextLvCode,notUnlockNextLvTips = AngelDataMgr:getIsUnlockSkill(nextLvSkillId)
									couldUp = couldUp or curSKillPoint >= nextLevelConfig.needSkillPiont
								end
							end
						end
						Image_redTip:setVisible(couldUp)
					end
				end
			end
		end
	end

	for i=1, 4 do
        local data = AngelDataMgr:getHeroCurrUsePassiveSkillData(self.showHeroId, i)
        local config = AngelDataMgr:getAngleConfig(data.skillId)

        local Image_passSkill = TFDirector:getChildByPath(self.angelPanel,"Image_pass_icon_" .. i)
        if config then
        	Image_passSkill:setTexture(config.icon)
        else
        	Image_passSkill:setTexture("")
        end
        local isUnlock = AngelDataMgr:getIsUnlockPassiveSkillSlot(self.showHeroId, i)
        if not isUnlock then
        	local Image_lock = TFDirector:getChildByPath(self.angelPanel,"Image_pass_lock_" .. i)
        	Image_lock:setVisible(true)
        else
        	local Image_lock = TFDirector:getChildByPath(self.angelPanel,"Image_pass_lock_" .. i)
        	Image_lock:setVisible(false)
        end

		local Image_redTip = TFDirector:getChildByPath(self.angelPanel,"Image_redTip_" .. i):hide()

        local isHaveLoadSkill = AngelDataMgr:getIsLoadPassiveSkillByPos(self.showHeroId, i)
        if not isHaveLoadSkill and isUnlock then
        	local Image_add = TFDirector:getChildByPath(self.angelPanel,"Image_pass_add_" .. i)
        	Image_add:setVisible(true)
			if not self.isfriend then
				Image_redTip:setVisible(true)
			end
        else
        	local Image_add = TFDirector:getChildByPath(self.angelPanel,"Image_pass_add_" .. i)
        	Image_add:setVisible(false)
        end
    end

	local Label_skill_point = TFDirector:getChildByPath(self.angelPanel,"Label_skill_point");
	local count = AngelDataMgr:getAngleTabCurUseSkillPoint(self.showHeroId)
	local max 	= HeroDataMgr:getSkillPointMax(self.showHeroId)
    Label_skill_point:setString(count.."/"..max);

    local angelLv = HeroDataMgr:getAngelLevel(self.showHeroId);

    for i=1,5 do
    	local star = TFDirector:getChildByPath(self.angelPanel,"Image_star"..i);
    	if i > angelLv then
    		star:hide();
    	else
    		star:show();
    	end
    end

    local Label_angel_name = TFDirector:getChildByPath(self.angelPanel,"Label_angel_name");
    local name = HeroDataMgr:getAngelName(self.showHeroId);
    Label_angel_name:setTextById(name);

    --TODO CLOSE
    --local Label_angel_level = TFDirector:getChildByPath(self.angelPanel,"Label_angel_level")
    --Label_angel_level:setText("Lv."..HeroDataMgr:getAngelBreakLevel(self.showHeroId))
    local Label_angel_level = TFDirector:getChildByPath(self.angelPanel,"Label_angel_level"):hide()
    
    local angelLv = HeroDataMgr:getAngelLevel(self.showHeroId);
    if angelLv >= 5 then
    	self.Button_Awaken:hide();
    	TFDirector:getChildByPath(self.angelPanel,"Image_fairyMain_2"):hide();
    	TFDirector:getChildByPath(self.angelPanel,"Label_awaken_point"):hide();
    else
    	self.Button_Awaken:show();
    	TFDirector:getChildByPath(self.angelPanel,"Label_awaken_point"):show();
	    local Label_awaken_point 	= TFDirector:getChildByPath(self.angelPanel,"Label_awaken_point"):show();
	    local Image_awake_icon	 	= TFDirector:getChildByPath(self.angelPanel,"Image_awake_icon");
	    local need,needid 			= HeroDataMgr:getAwakenNeed(self.showHeroId);
	    local needCfg	  			= GoodsDataMgr:getItemCfg(needid)
	    local count = GoodsDataMgr:getItemCount(needid);
	    Label_awaken_point:setString(count.."/"..need);
	    Image_awake_icon:setTexture(needCfg.icon);
	    Image_awake_icon:setSize(CCSizeMake(64,64));
	    if count < need then
	    	Label_awaken_point:setColor(ccc3(253,56,112))
	    else
	    	Label_awaken_point:setColor(ccc3(255,255,255))
	    end
		self.Image_AwakeredTip:setVisible(count >= need)
	    TFDirector:getChildByPath(self.angelPanel,"Image_fairyMain_2"):show();
    	TFDirector:getChildByPath(self.angelPanel,"Label_awaken_point"):show();
    end

    self.Button_angel_break:hide()
    self.Panel_angel_info:setPositionY(-120)
    --TODO CLOSE
    -- if not self.isfriend and HeroDataMgr:checkAngelBreakUpEnable(self.showHeroId) then
    -- 	self.Button_angel_break:show()
    -- 	self.Panel_angel_info:setPositionY(0)
    -- 	self.Label_angel_break:setText(HeroDataMgr:getHeroWeaponName(self.showHeroId)..TextDataMgr:getText(10931235))
    -- end

    -- 天使粒子特效
    for i, v in ipairs(self.angelParticleNode_) do
        if not tolua.isnull(v) then
        	v:removeFromParent()
        end
    end
    local effect = HeroDataMgr:getAngelModelEffect(self.showHeroId)
    for i, v in ipairs(effect) do
        local particleNode  = TFParticle:create(v.effect)
        particleNode:setName("particleNode")
        particleNode:resetSystem()
        particleNode:setZOrder(v.order)
        local position = ccpAdd(self.Image_angel:Pos(), offset)
        particleNode:setPosition(position)
        self.Image_angel:getParent():addChild(particleNode)
        self.angelParticleNode_[i] = particleNode
    end

    --天使形象
    if self.angelModel then
        self.angelModel:removeFromParent();
        self.angelModel = nil;
    end
    local modelPath = HeroDataMgr:getAngelModelPath(self.showHeroId);
    local posOffset = HeroDataMgr:getAngelModelPosOffset(self.showHeroId);
    local scale 	= HeroDataMgr:getAngelModelScale(self.showHeroId)
    local angelModel = SkeletonAnimation:create(modelPath)
    angelModel:setAnimationFps(GameConfig.ANIM_FPS)
    angelModel:playByIndex(0, -1, -1, 1)
    self.Image_angel:getParent():addChild(angelModel);
    angelModel:setPositionX(self.Image_angel:getPositionX() + posOffset.x + 50);
    angelModel:setPositionY(self.Image_angel:getPositionY() + posOffset.y);
    angelModel:setScale(scale * 0.8);
    angelModel:setVisible(self.curPanel == self.angelPanel or self.curPanel == self.Panel_baoshi);
    self.angelModel = angelModel;

    local awakenLabel = self.Button_Awaken:getChildByName("Label_fairyMain_1");
    awakenLabel:setString(HeroDataMgr:getHeroWeaponName(self.showHeroId).." "..TextDataMgr:getText(2200003));

    if angelLv < 5 then
        TFDirector:getChildByPath(self.angelPanel,"Image_fairyMain_2"):setVisible(not self.isfriend)
        self.Button_Awaken:setVisible(not self.isfriend)
        TFDirector:getChildByPath(self.angelPanel,"Label_awaken_point"):setVisible(not self.isfriend)
    end
    TFDirector:getChildByPath(self.angelPanel,"Label_skill_point"):setVisible(not self.isfriend)
    TFDirector:getChildByPath(self.angelPanel,"Image_fairyMain_1"):setVisible(not self.isfriend)

    if self.anim_hero then
    	local showAngelFlag = self.curPanel == self.Panel_angel or self.curPanel == self.Panel_baoshi
		self.anim_hero:setVisible(not showAngelFlag)
	end

end

--宝石页面
function FairyDetailsLayer:updateBaoshiLayer()
    local angelLv = HeroDataMgr:getAngelLevel(self.showHeroId);
    for i=1,5 do
    	local star = TFDirector:getChildByPath(self.Panel_baoshi,"Image_star"..i);
    	if i > angelLv then
    		star:hide()
    	else
    		star:show()
    	end
    end

    local Label_skill_name = TFDirector:getChildByPath(self.Panel_baoshi,"Label_skill_name");
    local name = HeroDataMgr:getAngelName(self.showHeroId);
    Label_skill_name:setTextById(name);


    -- 天使粒子特效
    for i, v in ipairs(self.angelParticleNode_) do
    	if not tolua.isnull(v) then
        	v:removeFromParent()
        end
    end
    local effect = HeroDataMgr:getAngelModelEffect(self.showHeroId)
    for i, v in ipairs(effect) do
        local particleNode  = TFParticle:create(v.effect)
        particleNode:setName("particleNode")
        particleNode:resetSystem()
        particleNode:setZOrder(v.order)
        local position = ccpAdd(self.Image_angel:Pos(), offset)
        particleNode:setPosition(position)
        self.Image_angel:getParent():addChild(particleNode)
        self.angelParticleNode_[i] = particleNode
    end

    --天使形象
    if self.angelModel then
        self.angelModel:removeFromParent();
        self.angelModel = nil;
    end
    local modelPath = HeroDataMgr:getAngelModelPath(self.showHeroId);
    local posOffset = HeroDataMgr:getAngelModelPosOffset(self.showHeroId);
    local scale 	= HeroDataMgr:getAngelModelScale(self.showHeroId)
    local angelModel = SkeletonAnimation:create(modelPath)
    angelModel:setAnimationFps(GameConfig.ANIM_FPS)
    angelModel:playByIndex(0, -1, -1, 1)
    self.Image_angel:getParent():addChild(angelModel)
    angelModel:setPositionX(self.Image_angel:getPositionX() + posOffset.x + 50)
    angelModel:setPositionY(self.Image_angel:getPositionY() + posOffset.y)
    angelModel:setScale(scale * 0.8)
    angelModel:setVisible(self.curPanel == self.Panel_angel or self.curPanel == self.Panel_baoshi)
    self.angelModel = angelModel

    for i,foo in ipairs(self.gem_pos) do
        local data = HeroDataMgr:getGemInfoByPos(self.showHeroId, i)
        if data then
	        local cfg = EquipmentDataMgr:getGemCfg(data.cid)
	        foo.Image_bg:setVisible(true)
	        foo.Image_quality_bg:setVisible(true)
	        foo.Image_quality:setVisible(true)
	        foo.Image_icon:setVisible(true)
	        foo.Image_icon:setTexture(cfg.icon)
	        foo.Image_bg:setTexture(EquipmentDataMgr:getGemIconBg(cfg.quality))
	        foo.Image_quality_bg:setTexture(EquipmentDataMgr:getGemQualityBg(cfg.quality))
	        foo.Image_quality:setTexture(EquipmentDataMgr:getGemRarityIcon(cfg.rarity))
			if not self.isfriend then
				local haverBetter = EquipmentDataMgr:haverBetterStone(data.id)
				foo.redTip:setVisible(haverBetter)
			end
	    else
	        foo.Image_bg:setVisible(false)
	        foo.Image_quality_bg:setVisible(false)
	        foo.Image_quality:setVisible(false)
	        foo.Image_icon:setVisible(false)
			if not self.isfriend then
				local job = HeroDataMgr:getHeroJob(self.showHeroId)
				if job < 4 then
					local gemsInfos = EquipmentDataMgr:getGemInfosByHeroIdAndPos(self.showHeroId, i)
					foo.redTip:setVisible(#gemsInfos > 0)
				else
					foo.redTip:setVisible(false)
				end
			end
	    end
    end
end

----------------------------------结晶突破相关-----------------------------------
function FairyDetailsLayer:updateCrystalLayer()
	local partition = self.partition or 1 --当前选中的是第几阶段的突破信息
	local evoDatas  = HeroDataMgr:getEvolutionDataByPartition(self.showHeroId, partition) or {}

	self.tabEvoItem = {}
	self.tabEvoLine = {}

	for i, v in ipairs(self.tabPoints) do
		v:setVisible(false)
	end

	for i, v in ipairs(evoDatas) do
		local cellIndex = tonumber(v.coordinates)
		local imgCell   = self.tabPoints[cellIndex]
		self:initOneCrystalItem(imgCell, v)
		imgCell:setVisible(true)

		self.tabEvoItem[partition] = self.tabEvoItem[partition] or {}
		self.tabEvoItem[partition][v.cell] = imgCell
	end

	HeroDataMgr:setShowEvoPartition(partition)

	local panel = TFDirector:getChildByPath(self.Panel_crystal, "Panel_crystalPages")
	for i=1, 7 do
		local isFinish = HeroDataMgr:getEvolutionPartitionIsFinish(self.showHeroId, i)
		local icon = TFDirector:getChildByPath(panel, "Image_icon_"..i)
		icon:setTexture(isFinish and "ui/fairy_crystal/new_08.png" or "ui/fairy_crystal/new_07.png")
		icon:setTouchEnabled(true)
		icon:onClick(function()
            if not self.isfriend then
                Utils:openView("fairyNew.FairyEvolutionLayer", {showid=self.showHeroId, partition=i, friend=self.isfriend, backTag=self.backTag})
            end
		end)
	end

	--初始化突破点连线
	local evoDatas  = HeroDataMgr:getEvolutionDataByPartition(self.showHeroId, partition)
	for i, v in ipairs(evoDatas) do
		for i2, v2 in ipairs(v.neighborId) do
			local key = v.cell.."-"..v2
			local key2 = v2.."-"..v.cell
			if not self.tabEvoLine[key] and not self.tabEvoLine[key2] then
				local startItem = self.tabEvoItem[partition][v.cell]
				local endItem   = self.tabEvoItem[partition][v2]
				if not endItem then
					-- if self.tabEvoItem[page+1] then
					-- 	endItem = self.tabEvoItem[page+1][v2]
					-- end
				else
					if startItem and endItem then
						local startPos = ccp(startItem:getPosition())
						local endPos   = ccp(endItem:getPosition())
						local dist = ccpDistance(startPos,endPos)

						local lineSize = CCSizeMake(dist,5)
						local line = TFImage:create("ui/fairy_crystal/new_09.png")
						
						local isFinish  = HeroDataMgr:getEvolutionIsFinish(v)
						local neighborEvoData = HeroDataMgr:getEvolutionDataById(v.heroId, v.partition, v2)
						local isFinishNeighbor  = false
						if neighborEvoData then
							isFinishNeighbor = HeroDataMgr:getEvolutionIsFinish(neighborEvoData)
						end
						local isFinishBoth = isFinish and isFinishNeighbor						
						line:setTexture(isFinishBoth and "ui/fairy_crystal/new_10.png" or "ui/fairy_crystal/new_09.png")
						line:setContentSize(lineSize)
						if isFinishBoth then
							line:setContentSize(CCSizeMake(dist,15))
						end
						
						line:setAnchorPoint(ccp(0, 0.5))						
						line:setPosition(startPos)

						local angle = HeroDataMgr:getAngleByPos(startPos,endPos)
						line:setRotation(angle)

						self.Panel_crystal_points:addChild(line,1)

						self.tabEvoLine[key] = line
						self.tabEvoLine[key2] = line
					end
				end
			end
		end
	end

	if not self.isfriend then
		local showTip = HeroDataMgr:crystalRedTip(self.showHeroId)
		self.Image_crysRedTip:setVisible(showTip)
	end
end

function FairyDetailsLayer:initOneCrystalItem(item, data)
	local isUnlock = HeroDataMgr:getEvolutionIsUnlock(data)
	local icon = TFDirector:getChildByPath(item, "Image_crystal_icon")
	if isUnlock then
		local isFinish  = HeroDataMgr:getEvolutionIsFinish(data)
		item:setTexture(isFinish and "ui/fairy_crystal_details/6.png" or "ui/fairy_crystal_details/5.png")
		if data.icon ~= "" then
			icon:setTexture(data.icon)
		end

		if data.cellIcon and isFinish then
			item:setTexture("ui/fairy_crystal/better.png")
		end
		if data.cellIcon and (not isFinish) then
			item:setTexture("ui/fairy_crystal/betterLock.png")
		end
	else
		item:setTexture("ui/fairy_crystal_details/5.png")
		icon:setTexture(data.icon)
	end

	item:onClick(function()
		local tips = TFDirector:getChildByPath(item, "Label_des") 
		tips:setVisible(true)
		tips:setOpacity(255)
		tips:setText(data.des)
		tips:runAction(Sequence:create({DelayTime:create(1), FadeOut:create(0.5)}))


        local tipsBack = TFDirector:getChildByPath(item, "Image_tipsBack") 

        tipsBack:setVisible(true)
        tipsBack:setOpacity(255)
        local size = tips:getContentSize()
        size.width = size.width + 25
        size.height = size.height + 22
        tipsBack:setContentSize(size)
        tipsBack:runAction(Sequence:create({DelayTime:create(1), FadeOut:create(0.5)}))



	end)
end

function FairyDetailsLayer:initCrystalPoints()
	self.tabPoints = {}
	local itemSize = CCSizeMake(55,65)
	local pnlSize  = self.Panel_crystal_points:getContentSize()
	local offsetX, offsetY = 80, 60

	for i=1, 38 do
		local pos = HeroDataMgr:getCellIndexPos(i,itemSize.width,itemSize.height,offsetX,offsetY,pnlSize.height)

		local imgPoint = self.Image_crystal_item:clone()
		imgPoint:setVisible(false)
		imgPoint:setPosition(pos)

		-- local lab  = TFLabel:create()
		-- lab:setText("i:"..tostring(i))
		-- lab:setFontSize(24)
		-- lab:setPosition(0,0)
		-- lab:setAnchorPoint(ccp(0.5,0.5))
		-- lab:setColor(ccc3(0,0,255))
		-- imgPoint:addChild(lab)

		self.Panel_crystal_points:addChild(imgPoint,2)

		self.tabPoints[i] = imgPoint
	end
end
----------------------------------------------------------------------------------------------------

function FairyDetailsLayer:panelHide(panel)
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

function FairyDetailsLayer:panelShow(panel)
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

function FairyDetailsLayer:panelRightShow(panel)

	panel:stopAllActions();
	panel:setOpacity(0);
	panel:setPositionX(panel.origin.x + 20)

	local actions = {
		CCMoveBy:create(0.2,ccp(-20,0));
		CCFadeIn:create(0.2);
	}
	
	panel:runAction(Spawn:create(actions));
	
end

function FairyDetailsLayer:panelRightHide(panel)
	panel:stopAllActions();
	panel:setPositionX(panel:getPositionX() - 20)

	local actions = {
		CCMoveBy:create(0.2,ccp(20,0));
		CCFadeOut:create(0.2);
	}

	panel:runAction(Spawn:create(actions));
end

function FairyDetailsLayer:panelLeftShow(panel)
	panel:stopAllActions();
	panel:setOpacity(0);
	panel:setPositionX(-5)

	local actions = {
		CCMoveTo:create(0.2,ccp(15,0)),
		CCFadeIn:create(0.2),
	}

	panel:runAction(Spawn:create(actions))
end

function FairyDetailsLayer:panelLeftHide(panel)
	panel:stopAllActions();
	panel:setPositionX(15)

	local actions = {
		CCMoveTo:create(0.2,ccp(-5,0)),
		CCFadeOut:create(0.2),
	}

	panel:runAction(Spawn:create(actions));
end

function FairyDetailsLayer:updateHeroAttsInfo()
	local tabMainAtts = HeroDataMgr:getAttributeConfigByType(1) --主要属性
	local tabSubAtts  = HeroDataMgr:getAttributeConfigByType(2) --次要属性

	self.ListView_atts:removeAllItems()

	-- self:adaptAttInfoUI(#tabMainAtts)
	local mainAttTitle = self.Panel_mainatt_lab_item:clone()
	mainAttTitle:setVisible(true)
	self.ListView_atts:pushBackCustomItem(mainAttTitle)

	for i, att in ipairs(tabMainAtts) do
		local attStr = HeroDataMgr:getAttributeValueStr(self.showHeroId, att.attributeId)
		--if attStr then
			local item = self.Panel_att_item:clone()
			self:initHeroAttItem(item, att, attStr)
			self.ListView_atts:pushBackCustomItem(item)
		--end	
	end

	local mainAttTitle = self.Panel_otheratt_lab_item:clone()
	mainAttTitle:setVisible(true)
	self.ListView_atts:pushBackCustomItem(mainAttTitle)

	for i, att in ipairs(tabSubAtts) do
		local attStr = HeroDataMgr:getAttributeValueStr(self.showHeroId, att.attributeId)
		-- if attStr then
			local item = self.Panel_att_item:clone()
			self:initHeroAttItem(item, att, attStr)
			self.ListView_atts:pushBackCustomItem(item)
		-- end
	end
end

function FairyDetailsLayer:updateCompose()
	if self.isfriend then
	
		return;
	end

	local ishave = HeroDataMgr:getIsHave(self.showHeroId);

	local needs,id,needCnt;
	if not ishave then
		needs = HeroDataMgr:getComposeNeed(self.showHeroId);--合成
		for k,v in pairs(needs) do
			id = k;
			needCnt = v;
		end
	else
		needs = HeroDataMgr:getProgressNeed(self.showHeroId);--进阶
		id = needs[1]
		needCnt = needs[2]
	end

	local icon = self.Image_unlock_item_icon
	local iconPath = TabDataMgr:getData("Item",id).icon;
	icon:setTexture(iconPath);
	icon:setContentSize(CCSizeMake(64,64));

	local Label_sp = self.Label_unlock_item_count
	local spCnt = GoodsDataMgr:getItemCount(id);
	Label_sp:setString(spCnt.."/"..needCnt);

	local Label_sp_text = TFDirector:getChildByPath(self.Button_unlock_hero,"Label_fairyMain_1");

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

function FairyDetailsLayer:initHeroAttItem(item, attData, attStr)
	item:setVisible(true)
	local Image_att_icon	= TFDirector:getChildByPath(item, "Image_att_icon")
	local Label_att_name	= TFDirector:getChildByPath(item, "Label_att_name")
	local Label_att_value   = TFDirector:getChildByPath(item, "Label_att_value")

	Image_att_icon:setTexture(attData.icon~="" and attData.icon or "ui/316.png")
	--Image_att_icon:setContentSize(CCSizeMake(48,48))
	Label_att_name:setTextById(attData.name)
	Label_att_value:setString(attStr)
end

function FairyDetailsLayer:onTouchBtnCamera()
	-- if self.isShowCameraing then
	-- 	return
	-- end
	-- local isShowCamera = self.Panel_right:isVisible()
	-- self.isShowCamera = isShowCamera

	-- self.topLayer:setVisible(not isShowCamera)
	-- self.Panel_left_details:setVisible(not isShowCamera)
	-- self.Panel_right:setVisible(not isShowCamera)
	-- self.Panel_tabs:setVisible(not isShowCamera)
	-- self.Button_camera:setVisible(not isShowCamera)
	-- self.Button_share:setVisible(isShowCamera)
	-- local moveDist = isShowCamera and 200 or -200
	-- local move = CCMoveBy:create(0.2, ccp(moveDist,0))
	-- local call = CCCallFunc:create(function()
	-- 	self.isShowCameraing = false
	-- end)
	-- local seq  = CCSequence:createWithTable({move,call})
	-- self.Image_hero:stopAllActions()
	-- self.Image_hero:runAction(seq)
	-- self.isShowCameraing = true
	-- if not isShowCamera then
	-- 	self.Image_b1:setTexture("ui/fairy/new_ui/new_bg_01.png")
	-- else
	-- 	self.Image_b1:setTexture("ui/fairy/new_ui/new_bg_03.png")
	-- end

	local OldValue = USE_NATIVE_VLC 
    if me.platform == 'android' then 
        USE_NATIVE_VLC = true
    end
    local heroCfg_ = GoodsDataMgr:getItemCfg(self.showHeroId)
    local videoView = Utils:openView("common.VideoView", unpack(heroCfg_.bornVideo))
    videoView:setIshowShare(true)
    videoView:setEndLoop(true)
    videoView:bindVideoClickCallBack(function(index)  	
        if index > 1 then
            videoView:stopVideo()
        end
        return false
    end)
    USE_NATIVE_VLC = OldValue
end

function FairyDetailsLayer:onTouchBtnShare()
	if self.isShowShareing then
		return
	end
	self.Button_share:setVisible(false)
	local isShowShare = self.Panel_right:isVisible()
	self.isShowShare = isShowShare
	if isShowShare then
		self.Panel_share:setVisible(false)
		--self.Image_b1:setTexture("ui/fairy/new_ui/new_bg_01.png")
	else
		self.Panel_share:setVisible(true)
		--self.Image_b1:setTexture("ui/fairy/new_ui/new_bg_03.png")
		self:updateSharePanel()
	end

	-- self.topLayer:setVisible(not isShowShare)
	-- self.Panel_left_details:setVisible(not isShowShare)
	-- self.Panel_right:setVisible(not isShowShare)
	-- self.Panel_tabs:setVisible(not isShowShare)
	-- self.Button_camera:setVisible(not isShowShare)

	-- local moveDist = isShowShare and 200 or -200
	-- local move = CCMoveBy:create(0.2, ccp(moveDist,0))
	-- local call = CCCallFunc:create(function()
	-- 	self.isShowShareing = false
	-- end)
	-- local seq  = CCSequence:createWithTable({move,call})
	-- self.Image_hero:stopAllActions()
	-- self.Image_hero:runAction(seq)
	self.isShowShareing = true
end

function FairyDetailsLayer:updateSharePanel()
	local updateHeroBaseInfo = 1
	local Label_share_name = TFDirector:getChildByPath(self.Panel_share, "Label_share_name")
	Label_share_name:setText(HeroDataMgr:getNameById(self.showHeroId))
	local quality = HeroDataMgr:getQuality(self.showHeroId)
	for i=1,5 do
		local starStr = "Image_star"..i
		local star = TFDirector:getChildByPath(self.Panel_share, starStr)
		if quality >= i then
			star:setVisible(false) --分享界面不显示星星了
		else
			star:setVisible(false)
		end
	end

	local Image_share_level = TFDirector:getChildByPath(self.Panel_share, "Image_share_level")
	Image_share_level:setTexture(HeroDataMgr:getQualityPic(self.showHeroId))
end

function FairyDetailsLayer:onHeroActiveCrystal(data)
	self:updateHeroBaseInfo()
	self:updateCrystalLayer()
end

function FairyDetailsLayer:heroInfoChange()
	Utils:playSound(1002)
	self:updateHeroBaseInfo()
	self:updateEquipLayer()
	self:updateCrystalLayer()
	self:updateAngelLayer()
	self:updateBaoshiLayer()
	--self:updateSkinLayer()
end

function FairyDetailsLayer:onHeroAngleAwake()
	Utils:playSound(1001)
	self:updateAngelLayer()
	self:updateLeftBar()
end

function FairyDetailsLayer:onRecvUpdateSkyInfo()
    self:updateHeroBaseInfo()
	self:updateEquipLayer()
end

function FairyDetailsLayer:onHide()
	self.super.onHide(self)
	if not self.notHide then
		self:panelRightHide(self.Panel_right)
		self:panelLeftHide(self.Panel_tabs)
	end
end

function FairyDetailsLayer:removeEvents( ... )
	-- body
	self.super.removeEvents(self)
	self.danmuFrame:removeEvents()
end


function FairyDetailsLayer:removeUI()
	self.super.removeUI(self)
	if self.fromChatShare then
		HeroDataMgr:changeDataToSelf()
	end
end

function FairyDetailsLayer:onShow()
	self.super.onShow(self)
	
	self:updateAngelLayer()
	self:updateLeftBar()
	self:updateBaoshiLayer()
	if self.curSelectTab == 3 then
		self:updateEquipLayer()
	end
	
	if not self.notHide then
		self:panelRightShow(self.Panel_right)
		self:panelLeftShow(self.Panel_tabs)
	end
	self.notHide = false
	self:timeOut(function()
        GameGuide:checkGuide(self);
    end,0.05)
    self:timeOut(function()
    	self:removeLockLayer()
    	if self.Panel_right:getOpacity() == 0 then
       		self.Panel_right:runAction(CCFadeIn:create(0.2))
       		self.Panel_tabs:runAction(CCFadeIn:create(0.2))
		end
    end,0.1)
end


--适配属性界面ui
function FairyDetailsLayer:adaptAttInfoUI(mainAttCount)
	-- local height = mainAttCount * self.Panel_att_item:getContentSize().height + (mainAttCount-1)*self.ListView_main_atts:getItemsMargin()
	-- local size = self.ListView_main_atts:getContentSize()
	-- size.height = height
	-- self.ListView_main_atts:setContentSize(size)
	-- local imgBg = TFDirector:getChildByPath(self.Panel_atts_info, "Image_fairyDetails_3")
	-- size = imgBg:getContentSize()
	-- size.height = height + 15
	-- imgBg:setContentSize(size)

	-- local Image_fairyDetails_2 = TFDirector:getChildByPath(self.Panel_atts_info, "Image_fairyDetails_2-Copy2")
	-- Image_fairyDetails_2:setPositionY(imgBg:getPositionY()-size.height-Image_fairyDetails_2:getContentSize().height*0.5)

	-- local Image_fairyDetails_4 = TFDirector:getChildByPath(self.Panel_atts_info, "Image_fairyDetails_4")
	-- size = Image_fairyDetails_4:getContentSize()
	-- size.height = Image_fairyDetails_2:getPositionY()-Image_fairyDetails_2:getContentSize().height*0.5
	-- Image_fairyDetails_4:setContentSize(size)
	-- size.height = size.height - 12
	-- self.ListView_other_atts:setContentSize(size)
end

function FairyDetailsLayer:onTouchFairy()
    print("self.showid = "..self.showHeroId)
    if HeroDataMgr:getIsHave(self.showHeroId) then
        print("self.showid = "..self.showHeroId)
        self:onBottomBtnTouch(1)
    end
end

function FairyDetailsLayer:onTouchEquip()
    if HeroDataMgr:getIsHave(self.showHeroId) then
        self:onBottomBtnTouch(3)
    end
end


---------------------------guide------------------------------

--引导点击升级
function FairyDetailsLayer:excuteGuideFunc11001(guideFuncId)
    local targetNode = self.Button_upgrade
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode, ccp(-35.5, 0))
end

--引导点击详细按钮
function FairyDetailsLayer:excuteGuideFunc10002(guideFuncId)
    local targetNode = self.Button_detail
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

--引导点击结晶
function FairyDetailsLayer:excuteGuideFunc11003(guideFuncId)
    local targetNode = self.tabButtons[2].btn
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

--引导点击前往突破
function FairyDetailsLayer:excuteGuideFunc11004(guideFuncId)
    local targetNode = self.Button_up_crystal
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

--引导点击质点
function FairyDetailsLayer:excuteGuideFunc11005(guideFuncId)
    local targetNode = self.tabButtons[3].btn
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

--引导点击质点左上角槽位
function FairyDetailsLayer:excuteGuideFunc11006(guideFuncId)
    local targetNode = self["equipPanel"..1].Image_addBack
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode, ccp(-30, 0))
end

return FairyDetailsLayer;
