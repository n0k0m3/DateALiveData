--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
* --试用精灵信息界面
*
]]
local FairyTrailDetailsLayer = class("FairyTrailDetailsLayer", BaseLayer)
local ResConfig = 	
{
    [110211] = {
    	tab_name_text_ids = {2108166,2108167,2108168,2108169,2108170},
        topBarFileName      = "FairyTrailDetailsLayer1",
    	backgroundTexture = "ui/simulation_trial/bg.png",
		showAcrs = true,
	 	normalBtnTexture = {
			"ui/simulation_trial/spriteInfo/icon2.png",
			"ui/simulation_trial/spriteInfo/icon3.png",
			"ui/simulation_trial/spriteInfo/icon1.png",
			"ui/simulation_trial/spriteInfo/icon4.png",
			"ui/simulation_trial/spriteInfo/icon5.png",
		},

		selectedBtnTexture = {
			"ui/simulation_trial/spriteInfo/icon2_select.png",
			"ui/simulation_trial/spriteInfo/icon3_select.png",
			"ui/simulation_trial/spriteInfo/icon1_select.png",
			"ui/simulation_trial/spriteInfo/icon4_select.png",
			"ui/simulation_trial/spriteInfo/icon5_select.png",
		},
		image_lockMsg_texture= "ui/simulation_trial/spriteInfo/bg2.png",
		btn_fangan_texture= "ui/simulation_trial/spriteInfo/a1.png",

	},
	 [111411] = {
	    tab_name_text_ids = {2108166,2108167,2108171,2108169,2108170},
	    topBarFileName      = "FairyTrailDetailsLayer2",
	    backgroundTexture = "ui/simulation_trial2/spriteInfo/bg3.png",
		normalBtnTexture = {
			"ui/simulation_trial2/spriteInfo/icon2.png",
			"ui/simulation_trial2/spriteInfo/icon3.png",
			"ui/simulation_trial2/spriteInfo/icon1.png",
			"ui/simulation_trial2/spriteInfo/icon4.png",
			"ui/simulation_trial2/spriteInfo/icon5.png",
		},

		selectedBtnTexture = {
			"ui/simulation_trial2/spriteInfo/icon2_select.png",
			"ui/simulation_trial2/spriteInfo/icon3_select.png",
			"ui/simulation_trial2/spriteInfo/icon1_select.png",
			"ui/simulation_trial2/spriteInfo/icon4_select.png",
			"ui/simulation_trial2/spriteInfo/icon5_select.png",
		},
		image_lockMsg_texture= "ui/simulation_trial2/spriteInfo/bg2.png",
		btn_fangan_texture= "ui/simulation_trial2/spriteInfo/a1.png",
    },
    [111511] = {
        tab_name_text_ids = {2108166,2108167,2108171,2108169,2108170},
    	topBarFileName      = "FairyTrailDetailsLayer3",
        backgroundTexture = "ui/simulation_trial2/spriteInfo/bg3.png",
    	normalBtnTexture = {
			"ui/simulation_trial2/spriteInfo/icon2.png",
			"ui/simulation_trial2/spriteInfo/icon3.png",
			"ui/simulation_trial2/spriteInfo/icon1.png",
			"ui/simulation_trial2/spriteInfo/icon4.png",
			"ui/simulation_trial2/spriteInfo/icon5.png",
		},

		selectedBtnTexture = {
			"ui/simulation_trial2/spriteInfo/icon2_select.png",
			"ui/simulation_trial2/spriteInfo/icon3_select.png",
			"ui/simulation_trial2/spriteInfo/icon1_select.png",
			"ui/simulation_trial2/spriteInfo/icon4_select.png",
			"ui/simulation_trial2/spriteInfo/icon5_select.png",
		},
		image_lockMsg_texture= "ui/simulation_trial2/spriteInfo/bg2.png",
		btn_fangan_texture= "ui/simulation_trial2/spriteInfo/a1.png",
    },

    [110113] = {
        tab_name_text_ids = {2108166,2108167,2108172,2108169,2108170},
    	topBarFileName      = "FairyTrailDetailsLayer4",
        backgroundTexture = "ui/simulation_trial4/spriteInfo/bg3.png",
    	normalBtnTexture = {
			"ui/simulation_trial4/spriteInfo/icon2.png",
			"ui/simulation_trial4/spriteInfo/icon3.png",
			"ui/simulation_trial4/spriteInfo/icon1.png",
			"ui/simulation_trial4/spriteInfo/icon4.png",
			"ui/simulation_trial4/spriteInfo/icon5.png",
		},

		selectedBtnTexture = {
			"ui/simulation_trial4/spriteInfo/icon2_select.png",
			"ui/simulation_trial4/spriteInfo/icon3_select.png",
			"ui/simulation_trial4/spriteInfo/icon1_select.png",
			"ui/simulation_trial4/spriteInfo/icon4_select.png",
			"ui/simulation_trial4/spriteInfo/icon5_select.png",
		},
		image_lockMsg_texture= "ui/simulation_trial4/spriteInfo/bg2.png",
		btn_fangan_texture= "ui/simulation_trial4/spriteInfo/a1.png",
    },
    [110414] = {
        tab_name_text_ids = {2108166,2108167,2108168,2108169,2108170},
    	topBarFileName      = "FairyTrailDetailsLayer5",
        backgroundTexture = "ui/simulation_trial5/bg3.png",
    	normalBtnTexture = {
			"ui/simulation_trial5/sx.png",
			"ui/simulation_trial5/zd.png",
			"ui/simulation_trial5/ts.png",
			"ui/simulation_trial5/jb.png",
			"ui/simulation_trial5/bs.png",
		},

		selectedBtnTexture = {
			"ui/simulation_trial5/sx-1.png",
			"ui/simulation_trial5/zd-1.png",
			"ui/simulation_trial5/ts-1.png",
			"ui/simulation_trial5/jb-1.png",
			"ui/simulation_trial5/bs-1.png",
		},
		image_lockMsg_texture= "ui/simulation_trial4/spriteInfo/bg2.png",
		btn_fangan_texture= "ui/simulation_trial4/spriteInfo/a1.png",
    },
--    [110414] = {
--        tab_name_text_ids = {2108166,2108167,2108168,2108169,2108170},
--    	topBarFileName      = "FairyTrailDetailsLayer4",
--        backgroundTexture = "ui/simulation_trial4/spriteInfo/bg3.png",
--    	normalBtnTexture = {
--			"ui/simulation_trial4/spriteInfo/icon2.png",
--			"ui/simulation_trial4/spriteInfo/icon3.png",
--			"ui/simulation_trial4/spriteInfo/icon1.png",
--			"ui/simulation_trial4/spriteInfo/icon4.png",
--			"ui/simulation_trial4/spriteInfo/icon5.png",
--		},

--		selectedBtnTexture = {
--			"ui/simulation_trial4/spriteInfo/icon2_select.png",
--			"ui/simulation_trial4/spriteInfo/icon3_select.png",
--			"ui/simulation_trial4/spriteInfo/icon1_select.png",
--			"ui/simulation_trial4/spriteInfo/icon4_select.png",
--			"ui/simulation_trial4/spriteInfo/icon5_select.png",
--		},
--		image_lockMsg_texture= "ui/simulation_trial4/spriteInfo/bg2.png",
--		btn_fangan_texture= "ui/simulation_trial4/spriteInfo/a1.png",
--    },
}

function FairyTrailDetailsLayer:initData(heroId)
	self.resConfig = ResConfig[heroId]
	self.topBarFileName = self.resConfig.topBarFileName
end
function FairyTrailDetailsLayer:ctor(data)
    self.super.ctor(self,data)
    self.selectCell = nil
    self.paramData_ = data

    self.partition  = 1
    self.angelParticleNode_ = {}

    self.showHeroId = HeroDataMgr.showid
    self.showSkinID = HeroDataMgr:getCurSkin(self.showHeroId)

    if data and data.showid then
    	self.showHeroId = data.showid;
    end
    self:initData(self.showHeroId)
	local evoData  = HeroDataMgr:getEvolutionNextCanUpDataByAll(self.showHeroId) or {}
	self.partition  = evoData.partition

	self.curSelectTab = nil
	self.heroPos = data.pos
	self.gotoWhichTab = data.gotoWhichTab
	self.skyladder = data.skyladder
	self.isGuide = data.isGuide
	self.heroTestCfg = TabDataMgr:getData("HeroTest",self.showHeroId)
    self:init("lua.uiconfig.fairyNew.fairyTrailDetails")
end

function FairyTrailDetailsLayer:getClosingStateParams()
    local param1 = {}
    param1.backTag = self.backTag
    param1.showid = self.showHeroId
    param1.pos = self.heroPos
    param1.gotoWhichTab = self.curSelectTab
	param1.skyladder = self.skyladder
    return {param1}
end

function FairyTrailDetailsLayer:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	FairyTrailDetailsLayer.ui = ui
	self:addLockLayer()
	self.tabButtons = {}
	self.tabPanels = {}
	self.skinItemsList_ = {}

	

	self.Image_b1           = TFDirector:getChildByPath(ui, "Image_b1")
	self.Image_b1:setTexture(self.resConfig.backgroundTexture)
	self.Panel_left			= TFDirector:getChildByPath(ui, "Panel_left")
	self.acrs  				= TFDirector:getChildByPath(self.Panel_left, "arcsBg")
	self.acrs:setVisible(not not self.resConfig.showAcrs)

	self.Panel_left_details = TFDirector:getChildByPath(ui, "Panel_left_details")
	self.Panel_right 		= TFDirector:getChildByPath(ui, "Panel_right")
	self.Panel_tabs			= TFDirector:getChildByPath(ui, "Panel_tabs")
	
	self.Panel_atts_info 	= TFDirector:getChildByPath(ui, "Panel_atts_info") 	--属性界面
	self.Panel_Equipment	= TFDirector:getChildByPath(ui, "Panel_Equipment")	--装备界面
	self.Panel_angel		= TFDirector:getChildByPath(ui, "Panel_angel")		--天使界面
	self.Panel_equip_suit		= TFDirector:getChildByPath(ui, "Panel_equip_suit")		--装备套装界面
	self.Panel_baoshi		= TFDirector:getChildByPath(ui, "Panel_baoshi")		--精灵宝石界面

	self.Image_background   = TFDirector:getChildByPath(ui, "background")

	self.Image_hero_power_bg= TFDirector:getChildByPath(ui, "Image_hero_power_bg")
	self.Image_hero			= TFDirector:getChildByPath(ui, "Image_hero")
	self.Panel_hero_touch   = TFDirector:getChildByPath(ui, "Panel_hero_touch")
	self.Label_hero_level	= TFDirector:getChildByPath(ui, "Label_hero_level")
	self.Label_hero_level_max	= TFDirector:getChildByPath(ui, "Label_hero_level_max")
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
	self.Panel_tupoLevel_lab_item = TFDirector:getChildByPath(ui, "Panel_tupoLevel_lab_item")
	self.Panel_tupoLevel_lab_item:setVisible(false)
	self.Panel_angel_skillDes_Item = TFDirector:getChildByPath(ui, "Panel_angel_skillDes_Item")
	self.Panel_angel_skillDes_Item:setVisible(false)

	
		--装备界面
	self.Label_cost 	= TFDirector:getChildByPath(self.Panel_Equipment,"Label_cost");
	self.Image_center_bg_effect 	= TFDirector:getChildByPath(self.Panel_Equipment,"Image_center_bg_effect")
	self.Image_center_name    = TFDirector:getChildByPath(self.Panel_Equipment,"Image_suitSkillName")
	local Image_lockMsg = TFDirector:getChildByPath(self.Panel_Equipment,"Image_lockMsg")
	Image_lockMsg:setTexture(self.resConfig.image_lockMsg_texture)

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
		self["equipPanel"..i].lock 				= TFDirector:getChildByPath(self["equipPanel"..i],"Image_lock"):hide()
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



	--天使
	self:initAngelLayer()
	
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
		foo.lock = TFDirector:getChildByPath(foo.Panel_info,"Image_lock"):hide()
		foo.Image_redTip = TFDirector:getChildByPath(foo.root,"Image_redTip"):hide()
		for i=1,5 do
			stars[i] = TFDirector:getChildByPath(foo.root,"Image_star"..i)
		end
		foo.stars = stars
		self.equip_suit_pos[i] = foo
	end
	local Panel_attr = TFDirector:getChildByPath(self.Panel_equip_suit,"Panel_attr")
	self.Panel_attr = Panel_attr
	self.Panel_hp = TFDirector:getChildByPath(Panel_attr,"Panel_hp")
	self.Panel_atk = TFDirector:getChildByPath(Panel_attr,"Panel_atk")
	self.Panel_def = TFDirector:getChildByPath(Panel_attr,"Panel_def")

	self.Label_atk_value = TFDirector:getChildByPath(Panel_attr,"Label_atk_value")
	self.Label_def_value = TFDirector:getChildByPath(Panel_attr,"Label_def_value")
	self.Label_hp_value = TFDirector:getChildByPath(Panel_attr,"Label_hp_value")

	local Panel_button_suit = TFDirector:getChildByPath(self.Panel_equip_suit,"Panel_button_suit")
	self.Panel_button_suit = Panel_button_suit
	self.Button_suit = TFDirector:getChildByPath(Panel_button_suit,"Button_suit")
	 self.Image_suits = {}
    for i = 1, 3 do
        self.Image_suits[i] = TFDirector:getChildByPath(Panel_button_suit,"Image_suit"..i)
    end
    self.Label_cost_suit = TFDirector:getChildByPath(self.Panel_equip_suit,"Label_cost")
    self.Label_cost_max_suit = TFDirector:getChildByPath(self.Panel_equip_suit,"Label_cost_max")



    --宝石相关
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
		foo.lock = TFDirector:getChildByPath(foo.root,"Image_lock"):hide()
        self.gem_pos[i] = foo
    end

	self.curPanel			= nil

	table.insert(self.tabPanels,{pl = self.Panel_atts_info,uiType = EC_FairyDetailUIType.Attr})
	table.insert(self.tabPanels,{pl = self.Panel_Equipment,uiType = EC_FairyDetailUIType.Equip})
	table.insert(self.tabPanels,{pl = self.Panel_angel,uiType = EC_FairyDetailUIType.Angle})
	table.insert(self.tabPanels,{pl = self.Panel_equip_suit,uiType = EC_FairyDetailUIType.NewEquip})
	table.insert(self.tabPanels,{pl = self.Panel_baoshi,uiType = EC_FairyDetailUIType.BaoShi})

	self.btn_attr = TFDirector:getChildByPath(self.Panel_tabs,"btn_attr")
	self.btn_zhidian = TFDirector:getChildByPath(self.Panel_tabs,"btn_zhidian")
	self.btn_angel = TFDirector:getChildByPath(self.Panel_tabs,"btn_angel")
	self.btn_jiban = TFDirector:getChildByPath(self.Panel_tabs,"btn_jiban")
	self.btn_bone = TFDirector:getChildByPath(self.Panel_tabs,"btn_bone")

	TFDirector:getChildByPath(self.btn_attr,"label_name"):setTextById(self.resConfig.tab_name_text_ids[1])
	TFDirector:getChildByPath(self.btn_zhidian,"label_name"):setTextById(self.resConfig.tab_name_text_ids[2])
	TFDirector:getChildByPath(self.btn_angel,"label_name"):setTextById(self.resConfig.tab_name_text_ids[3])
	TFDirector:getChildByPath(self.btn_jiban,"label_name"):setTextById(self.resConfig.tab_name_text_ids[4])
	TFDirector:getChildByPath(self.btn_bone,"label_name"):setTextById(self.resConfig.tab_name_text_ids[5])

	table.insert(self.tabButtons, {btn = self.btn_attr, panel = self.tabPanels[1].pl,id = 1,uiType = self.tabPanels[1].uiType})
	table.insert(self.tabButtons, {btn = self.btn_zhidian, panel = self.tabPanels[2].pl,id = 2,uiType = self.tabPanels[2].uiType})
	table.insert(self.tabButtons, {btn = self.btn_angel, panel = self.tabPanels[3].pl,id = 3,uiType = self.tabPanels[3].uiType})
	table.insert(self.tabButtons, {btn = self.btn_jiban, panel = self.tabPanels[4].pl,id = 4,uiType = self.tabPanels[4].uiType})
	table.insert(self.tabButtons, {btn = self.btn_bone, panel = self.tabPanels[5].pl,id = 5,uiType = self.tabPanels[5].uiType})

	for i,v in ipairs(self.tabButtons) do
		v.btn:setTexturePressed(self.resConfig.selectedBtnTexture[v.id]);
	end

	self:updateHeroBaseInfo()
	self:updateEquipLayer()

	ViewAnimationHelper.doMoveFadeInAction(self.Panel_hero_suit, {direction = 1, distance = 30, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(self.Button_eval, {direction = 1, distance = 30, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(self.Image_hero_power_bg, {direction = 2, distance = 30, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(self.Panel_right, {direction = 2, distance = 30, ease = 1})
    if self.gotoWhichTab then
		self:onBottomBtnTouch(self.gotoWhichTab)
	else
		self:onBottomBtnTouch(1)
	end

	
	self.panel_guide = TFDirector:getChildByPath(self.ui,"panel_guide"):hide()
	self.panel_guide:retain()
	self.panel_guide:removeFromParent()
	self.panel_guide:setZOrder(1000)
	self.panel_guide:setPositionX(GameConfig.WS.width/2)
	self:addChild(self.panel_guide)

	self.Panel_talk = {}
	self.Panel_talk[1] = TFDirector:getChildByPath(self.panel_guide,"Panel_talk1"):hide()
	self.Panel_talk[2] = TFDirector:getChildByPath(self.panel_guide,"Panel_talk2"):hide()
end

function FairyTrailDetailsLayer:onBaoshiChangeOver()
    self:updateBaoshiLayer()
	self:updateEquipSuitLayer()
end


function FairyTrailDetailsLayer:registerEvents()
	-- EventMgr:addEventListener(self,EV_FORMATION_CHANGE,handler(self.onFormationChange, self));
    EventMgr:addEventListener(self,EV_HERO_LEVEL_UP,handler(self.heroInfoChange, self));
    EventMgr:addEventListener(self,EV_HERO_PROPERTYCHANGE,handler(self.updateHeroBaseInfo, self));
    EventMgr:addEventListener(self,EQUIPMENT_DRESS_NEW_EQUIP,handler(self.updateEquipSuitLayer, self));
    EventMgr:addEventListener(self,EQUIPMENT_GEM_DRESS_OR_DROP,handler(self.onBaoshiChangeOver, self))
    EventMgr:addEventListener(self,EV_HERO_ANGLE_USE_TAB,handler(self.onHeroAngleAwake, self))


    self:setBackBtnCallback(function()
    	local showid = self.showHeroId
    	local backTag = self.backTag
        AlertManager:close();
 		--Utils:openView("fairyNew.FairyMainLayer", {showid=showid, friend=friend, backTag=backTag})
    end)
   

    for i,v in ipairs(self.tabButtons) do
	    v.btn:onClick(function()
	        self:onBottomBtnTouch(v.id)
    		GameGuide:checkGuideEnd(self.guideFuncId)
	    end)
    end

	self.Button_eval:onClick(function()
		local layer = require("lua.logic.fairyNew.EvaluationView"):new({heroOrEquip = 2, heroId = self.showHeroId, callfunc = function()
			
		end})
        AlertManager:addLayer(layer)
        AlertManager:show()
	end)

	
    --装备插槽
    for i=1,3 do
    	local equipBoard = self["equipPanel"..i];
    	equipBoard:setTouchEnabled(true);
		equipBoard:onClick(function()
			local layer = nil;
			print("touch in "..i);
			local _v,equipmentId = HeroDataMgr:getEquipIdByPos(self.showHeroId,i,true);
			if string.find(_v,"equipmentId") then
				_v = equipmentId
			end
			Utils:openView("Equipment.EquipmentInfo", {equipmentId = _v,heroid = self.showHeroId,pos = i,
				isfriend = false,backTag = self.backTag, fromFairy = true, isSkyladder = self.skyladder, notAction = true})
		end)
    end

	for i = 1, 6 do
		local foo = self.equip_suit_pos[i]
		foo.root:setTouchEnabled(true)
		foo.root:onClick(function()
			Utils:openView("fairyNew.EquipSuitMainLayer", {heroId = self.showHeroId, pos = i,isSkyladder = self.skyladder, notAction = true})
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
			self.selectGemPos = i
			local data = HeroDataMgr:getGemInfoByPos(self.showHeroId, i, true)
			Utils:openView("fairyNew.BaoshiDetailView", {heroId = self.showHeroId,pos = i,fromBag = false,notAction = true})
		end)
    end

end

function FairyTrailDetailsLayer:updateHeroBaseInfo()


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


	self.Label_hero_name:setText(HeroDataMgr:getNameById(self.showHeroId))
	self.Label_enName2:setText(HeroDataMgr:getEnName2(self.showHeroId))
	self.Label_enName:setText(HeroDataMgr:getEnName(self.showHeroId))
	self.Image_energy_rank:setVisible(false)
	self.Image_energy_rank:setPositionX(self.Label_hero_name:getPositionX() + self.Label_hero_name:getContentSize().width + 25)

	self.Label_suit_name:setText(HeroDataMgr:getTitleStr(self.showHeroId))

	local heroLv = HeroDataMgr:getLv(self.showHeroId)
	local maxexp = TabDataMgr:getData("LevelUp",heroLv).heroExp or "0";
	self.Label_hero_level:setString(heroLv)
	local maxLevel = TabDataMgr:getData("DiscreteData",9002).data.hmaxlvl
	self.Label_hero_level_max:setString("/ "..maxLevel)


	self.Label_hero_level_max:setPositionX(self.Label_hero_level:getPositionX() + self.Label_hero_level:getContentSize().width + 2)
	self.Image_sss_level:setTexture(HeroDataMgr:getQualityPic(self.showHeroId))
	self.Label_hero_power:setString(HeroDataMgr:getHeroPower(self.showHeroId))

	-- self:updateCompose()

	self:updateHeroAttsInfo()
	 
end

function FairyTrailDetailsLayer:onBottomBtnTouch(idx)
	if self.curSelectTab == idx then
		return
	end

	self.curSelectTab = idx
	self.gotoWhichTab = idx

	for i,v in ipairs(self.tabButtons) do
		if v.id == idx then
			v.btn:setTextureNormal(self.resConfig.selectedBtnTexture[v.id]);
			if self.curPanel ~= v.panel then
				self.curPanel = v.panel
				self:panelShow(v.panel)
			end
		else
			v.btn:setTextureNormal(self.resConfig.normalBtnTexture[v.id]);
			self:panelHide(v.panel)
		end
	end

	if idx == 2 then
		self:updateEquipLayer()
	elseif idx == 3 then
		self:updateAngelLayer()
	elseif idx == 4 then
		self:updateEquipSuitLayer()
	elseif idx == 5 then
		self:updateBaoshiLayer()		
	end


	if self.anim_hero then
		self.anim_hero:setVisible(true)
	end
	self.Panel_name_info:setVisible(true)
	self.Button_eval:setVisible(true )
	--self.Button_eval:setVisible(false)
	--self.Button_share:setVisible(self.curPanel ~= self.Panel_angel)
	self.Image_hero_power_bg:setVisible(true)

	-- self.Image_background:setTexture("ui/common/bg2.png")
	self.Image_suit_bg:setVisible(true)
	self.Label_suit_name:setVisible(true)
	if self.skyladder then
		self.Button_eval:setVisible(false)
	end
-- self.Image_background:hide()
	-- self.Image_background:setTexture(self.curPanel~=self.Panel_angel and "ui/common/bg2.png" or "ui/fairy_skill/BG.png")
	self.Image_suit_bg:setVisible(not (btn == self.Button_tab_4))
	self.Label_suit_name:setVisible(not (btn == self.Button_tab_4))
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

function FairyTrailDetailsLayer:updateEquipLayer()

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
	combInfo[1] = HeroDataMgr:checkCombByPos(self.showHeroId,1,2,nil,true);
	combInfo[2] = HeroDataMgr:checkCombByPos(self.showHeroId,2,3,nil,true);
	combInfo[3] = HeroDataMgr:checkCombByPos(self.showHeroId,1,3,nil,true);
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
		
		local _v,equipmentId = HeroDataMgr:getEquipIdByPos(self.showHeroId,1,true)
        local suitData1 = EquipmentDataMgr:getEquipSuitInfos(equipmentId)

        local _k,equipmentId2     = HeroDataMgr:getEquipIdByPos(self.showHeroId,2,true)
        local suitData2= EquipmentDataMgr:getEquipSuitInfos(equipmentId2)

        local _l,equipmentId3     = HeroDataMgr:getEquipIdByPos(self.showHeroId,3,true)
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
            size.height = size.height - 30
            Image_skill_desc:setContentSize(size)
            Image_skill_desc:runAction(Sequence:create({DelayTime:create(2), FadeOut:create(0.5)}))
            end)
	else
		self.Image_center_bg_effect:setVisible(false)
		self.Image_center_name:setVisible(false)
	end

	local Image_lockMsg = TFDirector:getChildByPath(self.Panel_Equipment,"Image_lockMsg")
	local tip = TFDirector:getChildByPath(Image_lockMsg,"Label_fairyTrailDetails_1")
	tip:setTextById(self.heroTestCfg.unlockTips.equipID)
	Image_lockMsg:setVisible(not HeroDataMgr:checkEquipmentUnLockState(self.showHeroId))
end

function FairyTrailDetailsLayer:updateEquipSuitLayer()
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
			level = equipInfo and equipInfo.level or equipCfg.level
			stage = equipInfo and equipInfo.stage or equipCfg.star
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
			foo.lock:setVisible(not HeroDataMgr:checkEquipSuitUnLockState(self.showHeroId))

			local canStrengthen = EquipmentDataMgr:newEquipCouldStrengthen(euipMent.cid)
			local canUpstage = EquipmentDataMgr:newEquipCouldUpStage(euipMent.cid)
			local showTip = canStrengthen or canUpstage
			foo.Image_redTip:setVisible(false)
		else
			foo.Panel_info:setVisible(false)
			local haveEquip = false
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
			foo.Image_redTip:setVisible(false)
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


	local Image_lockMsg = TFDirector:getChildByPath(self.Panel_equip_suit,"Image_lockMsg")
	local tip = TFDirector:getChildByPath(Image_lockMsg,"Label_fairyTrailDetails_1")
	tip:setTextById(self.heroTestCfg.unlockTips.newequipID)

	Image_lockMsg:setVisible(not HeroDataMgr:checkEquipSuitUnLockState(self.showHeroId))

	if HeroDataMgr:checkEquipSuitUnLockState(self.showHeroId) then
		self.Panel_attr:show()
		self.Panel_button_suit:show()
		self.Panel_equip_pos:setPositionY(197)
	else
		self.Panel_attr:hide()
		self.Panel_button_suit:hide()
		self.Panel_equip_pos:setPositionY(127)
	end

end

function FairyTrailDetailsLayer:updateOneEquip(idx)
	local ishave = HeroDataMgr:getIsHaveEquip(self.showHeroId ,idx,true);
	local equipBoard = self["equipPanel"..idx];
	if ishave and (not equipBoard.Panel_equip_info:isVisible()) then
		local effect = equipBoard:getChildByName("Spine_equiped")
		effect:playByIndex(0, -1, -1, 0)
	end
	equipBoard.Panel_equip_info:setVisible(ishave);
	equipBoard.Image_select:setVisible(false);
	if ishave then
		local _v,equipmentId 	= HeroDataMgr:getEquipIdByPos(self.showHeroId,idx,true);
		local quality = EquipmentDataMgr:getEquipQuality(equipmentId)
		equipBoard.Image_addBack:setTexture("ui/fairy_particle/" .. quality .. ".png")
	end
	if not ishave then
		equipBoard.Image_addBack:setTexture("ui/fairy_particle/ui_01.png")
	end
	equipBoard.Image_add:setVisible(false);
	local equipmentId = nil;
	if ishave then
		_v,equipmentId 	= HeroDataMgr:getEquipIdByPos(self.showHeroId,idx,true);
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
		local upEquip = EquipmentDataMgr:equipCouldUp(equipmentId)
		showRedTip = showRedTip or upEquip
		local upStar = EquipmentDataMgr:equipCouldUpStar(equipmentId)
		showRedTip = showRedTip or upStar
		local haveBeter = EquipmentDataMgr:haveBetterEquip(equipmentId)
		showRedTip = showRedTip or haveBeter
		equipBoard["Image_redTip"]:setVisible(false)
		equipBoard.lock:setVisible(not HeroDataMgr:checkEquipmentUnLockState(self.showHeroId))
	else
		-- equipBoard:setTexture("ui/445.png");
		-- equipBoard:setSize(CCSizeMake(125,160));
        equipBoard.skylock:setVisible(false)
        equipBoard.lock:setVisible(false)
		local haveEquip = false
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
		equipBoard["Image_redTip"]:setVisible(false)
	end

end

function FairyTrailDetailsLayer:getAngleSkillItemBySkillType(skillType)
	for i=1, 7 do
		local item = self["angelPanel"..i]
		if item:getTag() == skillType then
			return item
		end
	end
end

function FairyTrailDetailsLayer:initAngelLayer()
	self.fanganBtn = {}
	for i = 1,3 do
		local btn = TFDirector:getChildByPath(self.Panel_angel,"btn_fangan"..i)
		btn:setTexturePressed(self.resConfig.btn_fangan_texture)
		btn.name = TFDirector:getChildByPath(btn,"label_fanganName")
		self.fanganBtn[i] = btn
		btn:onClick(function ( ... )
			self.showAngelFangan = i
			self:updateAngelLayer()
		end)
		btn.name:setTextById(self.heroTestCfg["angelUp"..i].name)
	end

	local ScrollView_skillList = TFDirector:getChildByPath(self.Panel_angel,"ScrollView_skillList")
	self.angelSkillUIList = UIListView:create(ScrollView_skillList)

	self.btn_xiangxi = TFDirector:getChildByPath(self.Panel_angel,"btn_xiangxi")
	self.btn_changeFangAn = TFDirector:getChildByPath(self.Panel_angel,"btn_changeFangAn")
	self:updateAngelLayer()

	self.btn_xiangxi:onClick(function ( ... )
		-- body
		local lastPage = HeroDataMgr:getUseSkillStrategy(self.showHeroId)
		local cfg = self.heroTestCfg["angelUp"..self.showAngelFangan]
		local skillId = cfg.skill[1]
		local skillCfg = TabDataMgr:getData("Skill",skillId)
		HeroDataMgr:setTmpUseSkillStrategy(self.showHeroId, self.showAngelFangan)
		Utils:openView("angelNew.AngelInfo", {skillid = skillId,
						skillType = skillCfg.skillType,idx = 1,heroid = self.showHeroId,isfriend = false,backTag = self.backTag, isPass = false, notAction = true})
		
		HeroDataMgr:setTmpUseSkillStrategy(self.showHeroId, lastPage)
	end)

	self.btn_changeFangAn:onClick(function ( ... )
		-- body
		AngelDataMgr:doReqUseSkillStrategy(self.showHeroId, self.showAngelFangan)
	end)
	local label_fangan = TFDirector:getChildByPath(self.btn_changeFangAn,"label_fangan")
	local textID = 2108054
	if HeroDataMgr:getUseSkillStrategy(self.showHeroId) == self.showAngelFangan then
		textID = 2108055
	end
	label_fangan:setTextById(textID)
end

function FairyTrailDetailsLayer:updateAngelLayer()
	self.showAngelFangan = self.showAngelFangan or 1
	local cfg = self.heroTestCfg["angelUp"..self.showAngelFangan]
	for i = 1,3 do
		local texture = "ui/simulation_trial/spriteInfo/a2.png"
		if i == self.showAngelFangan then
			texture = self.resConfig.btn_fangan_texture --"ui/simulation_trial/spriteInfo/a1.png"
		end
		self.fanganBtn[i]:setTextureNormal(texture)
	end
	self.angelSkillUIList:removeAllItems()
	for i,v in pairs(cfg.skill) do

		local skillItem = self.Panel_angel_skillDes_Item:clone()
		skillItem:show()
		local skill_name = TFDirector:getChildByPath(skillItem,"skill_name")
		local ScrollView_des = TFDirector:getChildByPath(skillItem,"ScrollView_des")
		local skill_des = TFDirector:getChildByPath(skillItem,"skill_des")
		local Image_icon = TFDirector:getChildByPath(skillItem,"Image_icon")
		local Label_type = TFDirector:getChildByPath(skillItem,"Label_type")
		local skillCfg = TabDataMgr:getData("Skill",v)
		skill_name:setTextById(tonumber(skillCfg.name))
		skill_des:setTextById(tonumber(skillCfg.des))
		skill_des:setFontSize(16)
    	local childSize = skill_des:getSize()
    	local contentSize = ScrollView_des:getSize()
    	childSize.width   =  contentSize.width
    	if childSize.height < contentSize.height then 
    		local offset = contentSize.height - childSize.height
    		childSize.height = contentSize.height
    		ScrollView_des:setTouchEnabled(false)
    		skill_des:setPosition(me.p(0,offset))
    	else
    		ScrollView_des:setTouchEnabled(true)
    	end
   		ScrollView_des:setInnerContainerSize(childSize)
   		ScrollView_des:setSwallowTouch(true)
		ScrollView_des:onTouch(function (event)
			if event.name == "began" then
				self.angelSkillUIList:setInertiaScrollEnabled(false)
			elseif  event.name == "ended" then 
				self.angelSkillUIList:setInertiaScrollEnabled(true)
			end
		end)
		Label_type:setTextById(EC_Angel_Type_Name_Id[skillCfg.skillType]);
		Image_icon:setTexture(skillCfg.icon)

		self.angelSkillUIList:pushBackCustomItem(skillItem)
	end

	local passiveSkill =  TFDirector:getChildByPath(self.Panel_angel,"passiveSkill")
	for i,v in pairs (cfg.passiveSkill or {}) do
		local skillItem = TFDirector:getChildByPath(passiveSkill,"Image_skill_"..i)
		if skillItem then
			local Image_icon = TFDirector:getChildByPath(skillItem,"Image_icon")
			local skillCfg = TabDataMgr:getData("AngelSkillTree",v)
			Image_icon:setTexture(skillCfg.icon)
			Image_icon:setTouchEnabled(true)
			Image_icon:onClick(function ( ... )
				local skillId = v
				local desc = TextDataMgr:getText(skillCfg.describe)
				Utils:openView("fairyNew.FairySkillinfo",skillId,desc)
			end)
		end
	end

	local Image_lockMsg = TFDirector:getChildByPath(self.Panel_angel,"Image_lockMsg")
	local tip = TFDirector:getChildByPath(Image_lockMsg,"Label_fairyTrailDetails_1")
	tip:setTextById(self.heroTestCfg.unlockTips["angelUp"..self.showAngelFangan])
	Image_lockMsg:setVisible(not HeroDataMgr:checkAngelSkillUnLockState(self.showHeroId,self.showAngelFangan))
	self.btn_changeFangAn:setVisible(HeroDataMgr:checkAngelSkillUnLockState(self.showHeroId,self.showAngelFangan))
	self.btn_changeFangAn:setTouchEnabled(HeroDataMgr:getUseSkillStrategy(self.showHeroId) ~= self.showAngelFangan)
	self.btn_changeFangAn:setGrayEnabled(HeroDataMgr:getUseSkillStrategy(self.showHeroId) == self.showAngelFangan)
	local label_fangan = TFDirector:getChildByPath(self.btn_changeFangAn,"label_fangan")
	label_fangan:setTextById(HeroDataMgr:getUseSkillStrategy(self.showHeroId) == self.showAngelFangan and 2108055 or 2108054)
end

--宝石页面
function FairyTrailDetailsLayer:updateBaoshiLayer()
    local angelLv = HeroDataMgr:getAngelLevel(self.showHeroId);
  
    for i,foo in ipairs(self.gem_pos) do
        local data = HeroDataMgr:getGemInfoByPos(self.showHeroId, i,true)
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
			local haverBetter = EquipmentDataMgr:haverBetterStone(data.id)
			foo.redTip:setVisible(haverBetter)
			foo.lock:setVisible(not HeroDataMgr:checkGemsUnLockState(self.showHeroId))
	    else
	        foo.Image_bg:setVisible(false)
	        foo.Image_quality_bg:setVisible(false)
	        foo.Image_quality:setVisible(false)
	        foo.Image_icon:setVisible(false)
	        foo.lock:setVisible(false)
			local job = HeroDataMgr:getHeroJob(self.showHeroId)
			if job < 4 then
				local gemsInfos = EquipmentDataMgr:getGemInfosByHeroIdAndPos(self.showHeroId, i)
				foo.redTip:setVisible(#gemsInfos > 0)
			else
				foo.redTip:setVisible(false)
			end
	    end
    end

    local Image_lockMsg = TFDirector:getChildByPath(self.Panel_baoshi,"Image_lockMsg")
	local tip = TFDirector:getChildByPath(Image_lockMsg,"Label_fairyTrailDetails_1")
	tip:setTextById(self.heroTestCfg.unlockTips.stoneID)

	Image_lockMsg:setVisible(not HeroDataMgr:checkGemsUnLockState(self.showHeroId))

end

----------------------------------------------------------------------------------------------------

function FairyTrailDetailsLayer:panelHide(panel)
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

function FairyTrailDetailsLayer:panelShow(panel)
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

function FairyTrailDetailsLayer:panelRightShow(panel)

	panel:stopAllActions();
	panel:setOpacity(0);
	panel:setPositionX(panel:getPositionX() + 20)

	local actions = {
		CCMoveBy:create(0.2,ccp(-20,0));
		CCFadeIn:create(0.2);
	}
	
	panel:runAction(Spawn:create(actions));
	
end

function FairyTrailDetailsLayer:panelRightHide(panel)
	panel:stopAllActions();
	panel:setPositionX(panel:getPositionX() - 20)

	local actions = {
		CCMoveBy:create(0.2,ccp(20,0));
		CCFadeOut:create(0.2);
	}

	panel:runAction(Spawn:create(actions));
end

function FairyTrailDetailsLayer:panelLeftShow(panel)
	panel:stopAllActions();
	panel:setOpacity(0);
	panel:setPositionX(-5)

	local actions = {
		CCMoveTo:create(0.2,ccp(15,0)),
		CCFadeIn:create(0.2),
	}

	panel:runAction(Spawn:create(actions))
end

function FairyTrailDetailsLayer:panelLeftHide(panel)
	panel:stopAllActions();
	panel:setPositionX(15)

	local actions = {
		CCMoveTo:create(0.2,ccp(-5,0)),
		CCFadeOut:create(0.2),
	}

	panel:runAction(Spawn:create(actions));
end

function FairyTrailDetailsLayer:updateHeroAttsInfo()
	local tabMainAtts = HeroDataMgr:getAttributeConfigByType(1) --主要属性
	local tabSubAtts  = HeroDataMgr:getAttributeConfigByType(2) --次要属性

	self.ListView_atts:removeAllItems()

	local tupoItem = self.Panel_tupoLevel_lab_item:clone()
	tupoItem:setVisible(true)
	local level = TFDirector:getChildByPath(tupoItem,"label_level")
	level:setText(#HeroDataMgr:getCrystalInfo(self.showHeroId))
	self.ListView_atts:pushBackCustomItem(tupoItem)

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

function FairyTrailDetailsLayer:updateCompose()
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

	
	if spCnt < needCnt then
        Label_sp:setColor(ccc3(220,20,60));
    else
        Label_sp:setColor(ccc3(0,0,0));
    end
end

function FairyTrailDetailsLayer:initHeroAttItem(item, attData, attStr)
	item:setVisible(true)
	local Image_att_icon	= TFDirector:getChildByPath(item, "Image_att_icon")
	local Label_att_name	= TFDirector:getChildByPath(item, "Label_att_name")
	local Label_att_value   = TFDirector:getChildByPath(item, "Label_att_value")

	Image_att_icon:setTexture(attData.icon~="" and attData.icon or "ui/316.png")
	--Image_att_icon:setContentSize(CCSizeMake(48,48))
	Label_att_name:setTextById(attData.name)
	Label_att_value:setString(attStr)
end

function FairyTrailDetailsLayer:heroInfoChange()
	Utils:playSound(1002)
	self:updateHeroBaseInfo()
	self:updateEquipLayer()
	self:updateAngelLayer()
	self:updateBaoshiLayer()
	self:updateEquipSuitLayer()
	--self:updateSkinLayer()
end

function FairyTrailDetailsLayer:onHeroAngleAwake()
	self:updateAngelLayer()
end

function FairyTrailDetailsLayer:onHide()
	self.super.onHide(self)
	if not self.notHide then
		self:panelRightHide(self.Panel_right)
		self:panelLeftHide(self.Panel_tabs)
	end
end


function FairyTrailDetailsLayer:removeUI()
	self.super.removeUI(self)
end

function FairyTrailDetailsLayer:onShow()
	self.super.onShow(self)
	
	self:updateAngelLayer()
	 
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

    if self.isGuide and not self.curGuideCfg then
    	self:checkGuide()
    end

end


--适配属性界面ui
function FairyTrailDetailsLayer:adaptAttInfoUI(mainAttCount)
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

function FairyTrailDetailsLayer:onTouchFairy()
    print("self.showid = "..self.showHeroId)
    if HeroDataMgr:getIsHave(self.showHeroId) then
        print("self.showid = "..self.showHeroId)
        self:onBottomBtnTouch(1)
    end
end

function FairyTrailDetailsLayer:onTouchEquip()
    if HeroDataMgr:getIsHave(self.showHeroId) then
        self:onBottomBtnTouch(3)
    end
end

function FairyTrailDetailsLayer:checkGuide( )
	if self.curGuideCfg and self.curGuideCfg.nextGuideId == 0 then
		self.panel_guide:hide()
	else
		if not self.curGuideCfg then
			self.curGuideCfg = TabDataMgr:getData("HerotestGuide",self.heroTestCfg.guideId[self.gotoWhichTab])
		else
			self.curGuideCfg = TabDataMgr:getData("HerotestGuide", self.curGuideCfg.nextGuideId)
		end

		self:showGuide()
	end
end

function FairyTrailDetailsLayer:showGuide( )
	self.panel_guide:show()
	self.panel_guide:onClick(function ( ... )
		self:checkGuide()
	end)

	local guideCfg = self.curGuideCfg

	for k ,v in pairs(self.Panel_talk) do
		v:setVisible(k == guideCfg.talkPos)
	end

	local Panel_modle = TFDirector:getChildByPath(self.Panel_talk[guideCfg.talkPos],"Panel_modle")
    local Image_talk_bg = TFDirector:getChildByPath(self.Panel_talk[guideCfg.talkPos],"Image_talk_bg")
    local Label_title = TFDirector:getChildByPath(self.Panel_talk[guideCfg.talkPos],"Label_title")
    local Label_talk = TFDirector:getChildByPath(self.Panel_talk[guideCfg.talkPos],"Label_talk")
    Public:BlinkAction(Label_title);

    local elvesNpc = ElvesNpcTable:createLive2dNpcID(guideCfg.modelId,true,true,nil,false).live2d
    elvesNpc:setScale(0.35)
    elvesNpc:setPosition(ccp(0, -380))
    Panel_modle:addChild(elvesNpc, 1)
    elvesNpc:newStartAction(guideCfg.action,EC_PRIORITY.FORCE)
	Label_talk:setDimensions(250, 0)
    Label_talk:setString(guideCfg.des)
    local talkHeight = Label_talk:getContentSize().height
    Image_talk_bg:setSize(CCSizeMake(288, math.max(60, talkHeight + 50)))

    Label_talk:setString("")
    local list, len = Public:stringSplit(guideCfg.desc)
    local str = ""
    local time = 0.01
    for i, v in ipairs(list) do
        str = str .. v
        local function displyWord()
            local conText = str
            local acc = {
                CCDelayTime:create(time),
                CCCallFunc:create(function()
                    Label_talk:setOpacity(255)
                    Label_talk:setText(conText)
                    end)
            }
            Label_talk:runAction(CCSequence:create(acc))
        end
        displyWord()
        time = time + 0.06
    end
end

return FairyTrailDetailsLayer;
