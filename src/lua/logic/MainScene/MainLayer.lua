local MainLayer = class("MainLayer", BaseLayer)

function MainLayer:initData()

end

function MainLayer:init(uipath)
	self.uipath_ = uipath
	self.super.init(self,uipath)
	
end

function MainLayer:ctor(data)
    self.super.ctor(self,data)
    self:initData()

    self.isShowDress = false;
    self.isCamera = false;
    self.modelId  = 0;
    self.feellingInfoShowTime_ = 0

    self.isTouchRole = false
	
    self.showRffect = data
    self.giftButton = {}

    self.UTC_TIME = -7  --主界面显示时区为UTC-7

    self.overdueTime = TabDataMgr:getData("DiscreteData")[1100009].data  --折扣券即将过期提示时间

	--[[
    if Utils:isNewYearMainLayerUi() then
        self:init("lua.uiconfig.NewYear.MainLayer")
    elseif FunctionDataMgr:isMainLayerOneYearUI() then
        self:init("lua.uiconfig.MainScene.OneCelebrationMainLayer")
    else
        self:init("lua.uiconfig.MainScene.DefaultMainLayer")
	--self:init("lua.uiconfig.MainScene.MainLayer")
    end
	]]
	--self:init("lua.uiconfig.MainScene.WanKryptonMainLayer")

	local uidata = TabDataMgr:getData("Uichange", MainUISettingMgr:getui())

	if uidata then
		print("init--------------------------------------------=" .. MainUISettingMgr:getui())
		-- dump(uidata)
		self:init(uidata.uiConfig)
	else
		self:init("lua.uiconfig.MainScene.DefaultMainLayer")
	end
end

function MainLayer:isOneCelebrationMainLayer()
	return self.uipath_ == "lua.uiconfig.MainScene.OneCelebrationMainLayer"
end

function MainLayer:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui
    MainLayer.ui = ui
    self:addLockLayer()

    self.dateBtn = TFDirector:getChildByPath(ui,"button_yuehui");
    self.battleBtn = TFDirector:getChildByPath(ui,"Button_zuozhan");
    self.Button_fairy = TFDirector:getChildByPath(ui,"Button_fairy");
    self.fairyImage_unlock = TFDirector:getChildByPath(self.Button_fairy,"Image_unlock");
    self.Image_roleup = TFDirector:getChildByPath(self.Button_fairy,"Image_roleup"):hide()
    self.fairyTips    = TFDirector:getChildByPath(ui,"RedTips");
    self.Button_bag = TFDirector:getChildByPath(ui, "Button_bag")
    self.Panelzuozhan = TFDirector:getChildByPath(ui,"Panelzuozhan")
    self.Panelyuehui = TFDirector:getChildByPath(ui,"Panelyuehui");
    self.Panelyuehui:setVisible(false)
    self.Panelzuozhan:setVisible(false)

    self.Image_switch_role = TFDirector:getChildByPath(ui,"Image_switch_role");
    self.Image_yuehuiRedTips = TFDirector:getChildByPath(self.dateBtn,"Image_yuehuiRedTips")

    self.info_di = TFDirector:getChildByPath(ui, "info_di")
    self.Panel_player_level = TFDirector:getChildByPath(ui, "Panel_player_level")

    local Image_player_icon_bg = TFDirector:getChildByPath(ui, "Image_player_icon_bg")
    self.playerIcon         = TFDirector:getChildByPath(ui, "Image_player_icon")
    self.Image_icon_cover_frame         = TFDirector:getChildByPath(ui, "Image_icon_cover_frame")
    self.Image_player_redTip = TFDirector:getChildByPath(ui, "Image_player_redTip"):hide()

    self.Button_hideUI = TFDirector:getChildByPath(ui, "Button_hideUI")

    self.playerName         = TFDirector:getChildByPath(ui,"TextArea_name");
    self.playerLv           = TFDirector:getChildByPath(ui,"Label_Player_level");
    self.tiliLabel          = TFDirector:getChildByPath(ui,"Label_tili_count");
    self.goldLabel          = TFDirector:getChildByPath(ui,"Label_coin_count");
    self.Image_coin         = TFDirector:getChildByPath(ui,"Image_coin")
    self.diamondsLabel      = TFDirector:getChildByPath(ui,"Label_zuan_count");
    self.LoadingBar_Exp     = TFDirector:getChildByPath(ui,"LoadingBar_Exp");
    self.tiliAdd            = TFDirector:getChildByPath(ui,"Button_add_tili");
    self.goldAdd            = TFDirector:getChildByPath(ui,"Button_add_coin");
    self.Button_setting    = TFDirector:getChildByPath(ui,"Button_setting");
    self.diamondsAdd        = TFDirector:getChildByPath(ui,"Button_add_zuan");
    self.Image_tili_bg = TFDirector:getChildByPath(ui,"Image_tili_bg")

    self.Panel_system = TFDirector:getChildByPath(ui,"Panel_system"):hide()
    self.TextArea_system = TFDirector:getChildByPath(ui,"TextArea_system")
    self.TextArea_system.oPos = self.TextArea_system:Pos()

    self.Panel_black = TFDirector:getChildByPath(self.ui,"Panel_black")
    self.Panel_black:setSize(GameConfig.WS)
    self.Panel_black:setOpacity(0)

    self.imageNpc = TFDirector:getChildByPath(self.ui,"Image_role")
    self.Spine_effectH = TFDirector:getChildByPath(self.ui, "Spine_effectH")
    if self.Spine_effectH then
        self.Spine_effectH:hide()
    end
    self.Spine_effectHB = TFDirector:getChildByPath(self.ui, "Spine_effectHB")
    if self.Spine_effectHB then
        self.Spine_effectHB:hide()
    end

    self.Panel_left         = TFDirector:getChildByPath(ui,"Panel_left");
    self.Panel_leftBtList = TFDirector:getChildByPath(ui, "Panel_btList")
    self:initLeftButtons()
    self.Panel_right        = TFDirector:getChildByPath(ui,"Panel_right");
    self.Panel_feelling_info       = TFDirector:getChildByPath(self.Panel_right,"Panel_feelling_info"):hide()
    self.initFeelingPos = self.Panel_feelling_info:getPosition()
    self.Button_notice    = TFDirector:getChildByPath(self.Panel_left,"Button_notice");
    self.Button_ScoreReward = TFDirector:getChildByPath(self.Panel_left, "Button_ScoreReward")
    self.Button_ScoreReward:setVisible(false)

    self.Image_noticeTip = TFDirector:getChildByPath(self.Button_notice, "Image_noticeTip")


    
	if not self:isOneCelebrationMainLayer() then
		 self.Button_friend = TFDirector:getChildByPath(self.Panel_right,"Button_friend");
	else
		 self.Button_friend = TFDirector:getChildByPath(self.Panel_right,"Button_friend");
	end	
   
	
    self.Image_friendTip = TFDirector:getChildByPath(self.Button_friend, "Image_friendTip")
    self.Image_friendTip.Label_title = TFDirector:getChildByPath(self.Button_friend, "Label_title")
	if not self:isOneCelebrationMainLayer() then
		self.Button_mail        = TFDirector:getChildByPath(self.Panel_right,"Button_mail");
	else
		self.Button_mail        = TFDirector:getChildByPath(self.Panel_left,"Button_mail");
	end
    
    -- --暂时屏蔽邮件
    -- self.Button_mail:hide()

    
    self.Image_mailTip = TFDirector:getChildByPath(self.Button_mail, "Image_mailTip")
    self.Image_mailTip.Label_title = TFDirector:getChildByPath(self.Button_mail, "Label_title")
	--self.Button_Training = TFDirector:getChildByPath(self.Panel_left, "Button_Training")
    self.Button_welfare     = TFDirector:getChildByPath(self.Panel_left, "Button_welfare")
    self.Label_welfare      = TFDirector:getChildByPath(self.Button_welfare, "Label_welfare")
    self.Image_welfareTip = TFDirector:getChildByPath(self.Button_welfare, "Image_welfareTip")
    self.Button_wj = TFDirector:getChildByPath(self.Panel_left, "Button_wj"):hide()
    self.Image_wjTip = TFDirector:getChildByPath(self.Button_wj, "Image_wjTip"):show()
	if not self:isOneCelebrationMainLayer() then
		self.Button_activity = TFDirector:getChildByPath(self.Panel_left, "Button_activity"):show()
	else
		self.Button_activity = TFDirector:getChildByPath(self.Panel_left, "Button_activity"):show()
	end	
    self.Button_activity2 = TFDirector:getChildByPath(self.Panel_right, "Button_Activity2"):show()
    self.Image_activityTip = TFDirector:getChildByPath(self.Button_activity, "Image_activityTip")
    self.Image_activityTip2 = TFDirector:getChildByPath(self.Button_activity2, "Image_activityTip")
    self.Button_assistance = TFDirector:getChildByPath(self.Panel_left, "Button_assistance")
    self.Image_assistanceTip = TFDirector:getChildByPath(self.Button_assistance, "Image_assistanceTip"):hide()
    self.Button_assistance:hide()
    self.Button_focus = TFDirector:getChildByPath(self.Panel_left, "Button_focus")
    self.Image_focusTip = TFDirector:getChildByPath(self.Button_focus, "Image_focusTip")
    self.Button_update = TFDirector:getChildByPath(self.Panel_left, "Button_update")
    self.Image_updateTip = TFDirector:getChildByPath(self.Button_update, "Image_updateTip")
    self.Button_newYear = TFDirector:getChildByPath(self.Panel_left, "Button_newYear"):hide();
    self.Image_newYearTip = TFDirector:getChildByPath(self.Button_newYear, "Image_newYearTip")
    self.Button_monthCard = TFDirector:getChildByPath(self.Panel_left, "Button_monthCard")
    self.Label_monthCard = TFDirector:getChildByPath(self.Button_monthCard, "Label_monthCard")
    self.Label_monthCard:setTextById(1670001)
    self.Image_monthCardTip = TFDirector:getChildByPath(self.Button_monthCard, "Image_monthCardTip")
    self.Button_preview = TFDirector:getChildByPath(self.Panel_left, "Button_preview"):hide();
    self.Image_previewTip = TFDirector:getChildByPath(self.Button_preview, "Image_previewTip")
    self.btn_zhuifan = TFDirector:getChildByPath(self.Panel_left, "btn_zhuifan"):hide()
    self.Image_zhuifan = TFDirector:getChildByPath(self.btn_zhuifan, "Image_zhuifan"):hide()
    self.Button_OneYearShare = TFDirector:getChildByPath(self.Panel_left, "Button_OneYearShare"):hide()
    self.Image_lvli = TFDirector:getChildByPath(self.Button_OneYearShare, "Image_lvli")
    self.Button_sxsr = TFDirector:getChildByPath(self.Panel_left, "Button_sxsr"):hide();
    self.Image_sxsrTip = TFDirector:getChildByPath(self.Panel_left, "Image_sxsrTip"):hide();
    self.Button_dispatch = TFDirector:getChildByPath(self.Panel_right, "Button_dispatch")

    --暂时屏蔽指挥按钮
    self.Button_dispatch:hide()
	
    self.Image_dispatchTips = TFDirector:getChildByPath(self.Button_dispatch, "Image_dispatchTips"):hide()
    self.Image_dispatchTips.Label_title = TFDirector:getChildByPath(self.Button_dispatch,"Label_title")

    self.Button_gongzhu = TFDirector:getChildByPath(self.Panel_left, "Button_gongzhu")

    local __pos = self.Button_wj:getPosition()

    if not FunctionDataMgr:isMainLayerOneYearUI() and self:isOneCelebrationMainLayer() then
        self.Button_wj:setPosition(self.Button_focus:getPosition());
        self.Button_focus:setPosition(__pos);
    end

    self.Button_assist = TFDirector:getChildByPath(self.Panel_left, "Button_assist")
    self.Image_assist_Tip = TFDirector:getChildByPath(self.Button_assist, "Image_assist_Tip"):show()

    self.Button_newPlayer = TFDirector:getChildByPath(self.Panel_left, "Button_newPlayer")
    self.Image_newPlayerTip = TFDirector:getChildByPath(self.Button_newPlayer, "Image_newPlayerTip"):show()

    self.Button_Activity5 = TFDirector:getChildByPath(self.ui, "Button_Activity5")
    self.Image_activity_red5 = TFDirector:getChildByPath(self.ui, "Image_activity_red5"):hide()
    self.Button_Activity6 = TFDirector:getChildByPath(self.ui, "Button_Activity6")
    self.Image_activity_red6 = TFDirector:getChildByPath(self.ui, "Image_activity_red6"):hide()
    self.Button_Activity7 = TFDirector:getChildByPath(self.ui, "Button_Activity7")
    self.Image_activity_red7 = TFDirector:getChildByPath(self.ui, "Image_activity_red7"):hide()


    --创建反十活动图标
    self.Button_Activity1001 = TFButton:create("ui/activity/fanshiAssist/fanshiActivity.png")
    self.Button_Activity1001:setPosition(488 , 62)
    self.Button_Activity1001:hide()
    self.Image_activity_red1001 = TFImage:create("ui/common/news_small.png")
    self.Button_Activity1001:addChild(self.Image_activity_red1001)
    self.Image_activity_red1001:hide()
    self.Image_activity_red1001:setPosition(49 , 0)
    TFDirector:getChildByPath(self.Panel_right , "Panel_clip"):addChild(self.Button_Activity1001)



    self.Button_backPlayer = TFDirector:getChildByPath(self.Panel_left, "Button_backPlayer")
    self.Image_backPlayerTip = TFDirector:getChildByPath(self.Button_backPlayer, "Image_backPlayerTip"):show()

    self.Image_chat         = TFDirector:getChildByPath(ui,"Image_chat");
    self.Image_chat_redPoint     = TFDirector:getChildByPath(ui,"Image_redPoint");
    self.Image_red_packet     = TFDirector:getChildByPath(ui,"Image_red_packet")
    self.Image_redPack_tips     = TFDirector:getChildByPath(ui,"Image_redPack_tips")
    self.Panel_chat_di      = TFDirector:getChildByPath(ui,"Panel_chat_di");
    self.Label_message      = TFDirector:getChildByPath(ui,"Label_message");


    self.img_chat_new_tip = TFImage:create("ui/recharge/new.png")
    self.img_chat_new_tip:setPosition(40 ,10)
    self.Image_chat:addChild(self.img_chat_new_tip , 1)
    self.img_chat_new_tip:hide()


    self.Panel_bottom       = TFDirector:getChildByPath(ui,"Panel_bottom");
    self.Panel_chat         = TFDirector:getChildByPath(ui,"Panel_chat");
    -- self.Panel_chat_di:setOpacity(0)

    self.Panel_middle       = TFDirector:getChildByPath(ui,"Panel_middle");

    self.Panel_top = TFDirector:getChildByPath(ui, "Panel_top")

    self.background = TFDirector:getChildByPath(ui, "background")
    self.background.savePos = self.background:getPosition()

    self.topLayer = self.topLayer or TFDirector:getChildByPath(ui,"top_part2")

    self.Button_camera  = TFDirector:getChildByPath(ui, "Button_camera")
    self.Button_camera2 = TFDirector:getChildByPath(ui, "Button_camera2")
    self.Button_pokedex = TFDirector:getChildByPath(self.Panel_right, "Button_pokedex")
    self.Image_poker_tip = TFDirector:getChildByPath(self.Button_pokedex, "Image_poker_tip"):hide()
    self.Image_poker_tip.Label_title = TFDirector:getChildByPath(self.Button_pokedex, "Label_title")
    --self.infoStationBtn = TFDirector:getChildByPath(self.Panel_right, "btn_infoStation")
    -- self.infoStationBtn:setVisible(InfoStationDataMgr:getEnterState())
    self.infoStationWhiteImage = TFDirector:getChildByPath(self.Panel_right, "Image_MainLayer_1(5)")
    self.infoStationWhiteImage:setVisible(InfoStationDataMgr:getEnterState())
    self.Button_task = TFDirector:getChildByPath(self.Panel_right, "Button_task")

    self.Button_giftpacks = TFDirector:getChildByPath(self.Panel_left, "Button_elf_contract")
    self.image_new = TFDirector:getChildByPath(self.Button_giftpacks, "image_new"):hide()
    self.Image_redTips = TFDirector:getChildByPath(self.Button_giftpacks, "Image_redTips"):hide()
    self.Label_left_time = TFDirector:getChildByPath(self.Button_giftpacks, "Label_left_time"):hide()



    self.Button_RoleTeach = TFDirector:getChildByPath(self.Panel_left, "Button_RoleTeach"):hide();
    self.btn_zhibo = TFDirector:getChildByPath(self.Panel_left, "btn_zhibo"):hide()
    self.img_zhibo = TFDirector:getChildByPath(self.btn_zhibo, "img_zhibo"):hide()

    self.Button_serverGiftActivity = TFDirector:getChildByPath(self.Panel_left, "Button_serverGiftActivity")
    if self.Button_serverGiftActivity then
        self.Image_serverGiftTip = TFDirector:getChildByPath(self.Button_serverGiftActivity, "Image_serverGiftTip")
    end

    self.Image_taskTips = TFDirector:getChildByPath(self.Button_task, "Image_taskTips")
    self.Image_taskTips.Label_title = TFDirector:getChildByPath(self.Button_task, "Label_title")

    self.Button_shop = TFDirector:getChildByPath(self.Panel_bottom, "Button_shop")
    self.Button_recharge = TFDirector:getChildByPath(self.Panel_bottom, "Button_recharge")
    self.Image_MainLayer_new = TFDirector:getChildByPath(self.Button_recharge, "Image_MainLayer_new"):hide()

    self.Button_zhaohuan    = TFDirector:getChildByPath(self.Panel_bottom, "Button_zhaohuan")
    self.Image_summon_tip = TFDirector:getChildByPath(self.Button_zhaohuan, "Image_summon_tip"):hide()
    self.Image_upTips = TFDirector:getChildByPath(self.Button_zhaohuan, "Image_upTips"):hide()
    self.panel_contractSummon = TFDirector:getChildByPath(self.Button_zhaohuan, "panel_contractSummon"):hide()
    self.Panel_camera   = TFDirector:getChildByPath(self.ui, "Panel_camera")
    self.Panel_camera:setVisible(false)
    if DEBUG and DEBUG == 1 and CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
		--Box("1")
		local Image_camera = TFDirector:getChildByPath(ui, "Image_camera")
        Image_camera:setVisible(true)
		Image_camera:setPosition(ccp(1034,-100))
		self.Button_camera:setVisible(true)
    else
        TFDirector:getChildByPath(ui, "Image_camera"):setVisible(false)
		self.Button_camera:setVisible(false)
    end
    self.Button_camera2:setVisible(false);

    self.Panel_ai_chat = TFDirector:getChildByPath(self.ui,"Panel_ai_chat"):hide()
    self.aichat_initPos = self.Panel_ai_chat:getPosition()
    self.ai_Image_head = TFDirector:getChildByPath(self.Panel_ai_chat,"Image_head")
    self.Label_hero_name = TFDirector:getChildByPath(self.Panel_ai_chat,"Label_hero_name")
    self.Panel_ai_mask = TFDirector:getChildByPath(self.Panel_ai_chat,"Panel_ai_mask")
    self.Label_ai_message = TFDirector:getChildByPath(self.Panel_ai_chat,"Label_ai_message")
	
	self.Association_TextArea_name = TFDirector:getChildByPath(self.ui,"Association_TextArea_name")
	
    self.Button_phone    = TFDirector:getChildByPath(self.Panel_bottom,"Button_phone")
    self.Spine_phone = TFDirector:getChildByPath(self.Button_phone,"Spine_phone")
    self.Spine_phone:setVisible(false)
    self.Image_newtip = TFDirector:getChildByPath(self.Button_phone, "Image_newtip")

    self.Button_league = TFDirector:getChildByPath(self.Panel_bottom, "Button_league")
    self.Image_leagueTip = TFDirector:getChildByPath(self.Button_league, "RedTips")


    self.Button_ARCamera    = TFDirector:getChildByPath(self.Panel_bottom,"Button_ARCamera")

    self.Panel_player_info_touch = TFDirector:getChildByPath(self.ui,"Panel_player_info_touch")
    -- self.Panel_player_info_touch:setTouchEnabled(false)
	
    self.label_serverTime = TFLabel:create()
    self.label_serverTime:setFontName("font/MFLiHei_Noncommercial.ttf")
    self.label_serverTime:setFontSize(20)
    self.label_serverTime:setAnchorPoint(ccp(0 , 0.5))
    self.label_serverTime:setPosition(5 , -15)
    self.label_serverTime:enableOutline(ccc4(0,0,0,255), 1)
    local  time_s_hour , time_s_min , time_s_sec = ServerDataMgr:customUtcTimeForServer()
    self.label_serverTime:setString(string.format("%02d:%02d:%02d UTC-7" , time_s_hour , time_s_min , time_s_sec))

    self.Panel_player_info_touch:addChild(self.label_serverTime)

    self.Panel_activity = TFDirector:getChildByPath(ui,"Panel_activity");
    self.activityItem = TFDirector:getChildByPath(self.Panel_activity,"activity_1");
    -- self.activity2 = TFDirector:getChildByPath(self.Panel_activity,"activity_2");
    self.image_dot = {}
    for i=1,9 do
        self.image_dot[i] = TFDirector:getChildByPath(self.Panel_activity,"Image_dot"..i)
    end

    self.PageView_Activity = TFDirector:getChildByPath(self.Panel_activity,"PageView_Activity")
    self.PageView_Activity:setDirection(0)
    self.PageView_Activity:addMEListener(TFPAGEVIEW_SCROLLENDED, function()
        self:pageScrollEnd()
    end)

    -- self.Button_backLogin = TFDirector:getChildByPath(self.Panel_right, "Button_backLogin");
    -- self.Button_backLogin:setVisible(false);

    self.Panel_feelling_info = TFDirector:getChildByPath(self.Panel_right,"Panel_feelling_info")
    -- self.Label_feelling_name = TFDirector:getChildByPath(self.Panel_feelling_info,"Label_feelling_name")
    self.Label_feelling_level = TFDirector:getChildByPath(self.Panel_feelling_info,"Label_feelling_level")
    self.Label_feelling_percent = TFDirector:getChildByPath(self.Panel_feelling_info,"Label_feelling_percent")
    -- self.Label_feelling_reach_max = TFDirector:getChildByPath(self.Panel_feelling_info,"Label_feelling_reach_max")
    self.LoadingBar_feelling_bar = TFDirector:getChildByPath(self.Panel_feelling_info,"LoadingBar_feelling_bar")
    self.Button_feellint_edit = TFDirector:getChildByPath(self.Panel_feelling_info,"Button_feellint_edit")
    self.Btn_aiChat = TFDirector:getChildByPath(self.Panel_feelling_info,"Btn_aiChat")
    self.imgBtnaiChatRed = TFDirector:getChildByPath(self.Btn_aiChat,"img_redNew")
    self.Img_lockAiChat = TFDirector:getChildByPath(self.Panel_feelling_info,"img_lockAiChat")
    self.Img_lockAiChat:hide()

    self.panel_touch = TFDirector:getChildByPath(ui, "panel_touch")
    self.img_menu_bg = TFDirector:getChildByPath(self.panel_touch, "img_menu_bg")
    self.panel_touch:setVisible(false)
    self.panel_touch:setTouchEnabled(false)
    self.isShowSubMenu = false

    self.panel_zhaohuan = TFDirector:getChildByPath(self.img_menu_bg, "panel_zhaohuan")
    self.btn_jl = TFDirector:getChildByPath(self.panel_zhaohuan, "btn_jl")
    self.btn_zd = TFDirector:getChildByPath(self.panel_zhaohuan, "btn_zd")

    self.panel_recharge = TFDirector:getChildByPath(self.img_menu_bg, "panel_recharge")
    self.btn_recharge_a = TFDirector:getChildByPath(self.panel_recharge, "btn_recharge_a")
    self.btn_recharge_b = TFDirector:getChildByPath(self.panel_recharge, "btn_recharge_b")
    self.btn_recharge_c = TFDirector:getChildByPath(self.panel_recharge, "btn_recharge_c")

    self.panel_shop = TFDirector:getChildByPath(self.img_menu_bg, "panel_shop")
    self.btn_shop_a = TFDirector:getChildByPath(self.panel_shop, "btn_shop_a")
    self.btn_shop_b = TFDirector:getChildByPath(self.panel_shop, "btn_shop_b")

    self.ui:runAnimation("Action4",1)

    self.button_Caociyuan = TFDirector:getChildByPath(ui,"button_Caociyuan")
    self.Image_CaociyuanClip = TFDirector:getChildByPath(ui,"Image_CaociyuanClip")
    self.button_OneYear   = TFDirector:getChildByPath(ui,"button_OneYear")
    self.Image_OneYearClip = TFDirector:getChildByPath(ui,"Image_OneYearClip")

    self.GiftRoot = TFDirector:getChildByPath(self.ui,"GiftRoot")

    if FunctionDataMgr:isMainLayerOneYearUI() then
        self.Image_OneYearClip:setVisible(false)
        self.Image_CaociyuanClip:setVisible(false)
		if self:isOneCelebrationMainLayer() then
			self.redBtnObjs = {
				{redPoint = self.Image_noticeTip, normolState = "a5.png", redState = "a6.png"},
				{redPoint = self.Image_mailTip,normolState = "a9.png", redState = "a10.png"},
				{redPoint = self.Image_welfareTip,normolState = "a3.png", redState = "a4.png"},
				{redPoint = self.Image_activityTip,normolState = "a7.png", redState = "a8.png"},
				{redPoint = self.Image_focusTip,normolState = "a1.png", redState = "a2.png"},
				{redPoint = self.Image_previewTip,normolState = "c7.png", redState = "c8.png"},
				{redPoint = self.Image_wjTip,normolState = "c5.png", redState = "c6.png"},
				{redPoint = self.Image_updateTip, normolState = "c1.png", redState = "c2.png"},
				{redPoint = self.Image_backPlayerTip,normolState = "c3.png", redState = "c4.png"},
				{redPoint = self.Image_leagueTip, normolState = "c15_2.png", redState = "c15_3.png"},
				{redPoint = self.Image_poker_tip, normolState = "b3.png", redState = "b4.png"},
				{redPoint = self.Image_taskTips, normolState = "b1.png", redState = "b2.png"},
				{redPoint = self.Image_dispatchTips, normolState = "b7.png", redState = "b8.png"},
				{redPoint = self.Image_friendTip,normolState = "b5.png", redState = "b6.png"}
			}
		end
    end
	
	if not self:isOneCelebrationMainLayer() then
		self.Panel_btListEx = TFDirector:getChildByPath(self.Panel_left, "Panel_btListEx")
		self.Button_btnListEx = TFDirector:getChildByPath(self.Panel_left, "Button_btnListEx")
        self.Button_btnListEx.effect = TFDirector:getChildByPath(self.Button_btnListEx, "Spine_WanKryptonMainLayer_1")
		if self.Button_btnListEx.effect then 
            self.Button_btnListEx.effect:play("idle_3",0)
        end
        self.Panel_btListEx:hide()


        self.Button_kefu = self:createCustomBtnOnBear("ui/mainLayer/new_ui/kefu_btn.png" , ccp(52 , 101) , "http://api-en.datealive.com/yhdzz/customer?" , true)
        self.Button_fb = self:createCustomBtnOnBear("ui/mainLayer/new_ui/btn_fb.png" , ccp(52 , 101) , "https://www.facebook.com/DALSpiritPledge.Global")
        self.Button_twitter = self:createCustomBtnOnBear("ui/mainLayer/new_ui/btn_twitter.png" , ccp(52 , 101) , "https://twitter.com/SpiritPledgeDAL")
	end

    local activityInfos = ActivityDataMgr2:getActivityInfo(nil,2)
    self.Button_activity2:setVisible(#activityInfos > 0)

    local activityInfos = ActivityDataMgr2:getActivityInfo(nil,5)
    self.Button_Activity5:setVisible(#activityInfos > 0)

    local activityInfos = ActivityDataMgr2:getActivityInfo(nil,6)
    self.Button_Activity6:setVisible(#activityInfos > 0)

    local activityInfos = ActivityDataMgr2:getActivityInfo(nil,EC_ActivityType2.FANSHI_ASSIST)
    self.Button_Activity1001:setVisible(#activityInfos > 0)

    local activityInfos = ActivityDataMgr2:getActivityInfo(nil,7)
    self.Button_Activity7:setVisible(#activityInfos > 0)

    if self.Button_serverGiftActivity then
        local activityInfos = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.SERVER_GIFT)
        self.Button_serverGiftActivity:setVisible(#activityInfos > 0)
    end

    self:updatePlayerInfo();
    self:updateSystemChat("")
    self:refreshRedTips()
    self:addTimerUpdate()

    self:setBackGroundByTime()
    self:updateAction();
    --self:updateLive2d()
    self:playRoleVoice()
    self:addIPText()
	
	if self.Association_TextArea_name then
		local unionData = LeagueDataMgr:getMyUnionInfo()
		if not unionData then
			self.Association_TextArea_name:hide()
		else
			self.Association_TextArea_name:show()
                local countryStr = ""
                if unionData.showCountry and tonumber(unionData.country)>0 then
                    countryStr = " ("..LeagueDataMgr:getClubCountryDataById(unionData.country).Countryabbreviations..")"
                end
			self.Association_TextArea_name:setText(unionData.name..countryStr)
		end
	end
end

function MainLayer:addIPText()
    if CC_TARGET_PLATFORM ~= CC_PLATFORM_WIN32 then
        return
    end

    local Panel_player_info = TFDirector:getChildByPath(self.Panel_top, "Panel_player_info")
    local ipText = TFLabel:create()
    ipText:setFontSize(18)
    ipText:setTextAreaSize(CCSize(250, 0))
    ipText:setTextVerticalAlignment(0)
    ipText:setTextHorizontalAlignment(0)
    ipText:setPosition(ccp(5, -72))
    ipText:setAnchorPoint(ccp(0, 1))
    ipText:setFontColor(ccc3(255, 255, 255))
    ipText:enableStroke(ccc3(0, 0, 0), 1)
    ipText:setZOrder(100)
    Panel_player_info:addChild(ipText)

    local serverInfo = ServerDataMgr:getCurrentServerInfo()
    if serverInfo then
        local ip = serverInfo.gameServerIp
        local port = serverInfo.gameServerPort
        local groupName = LogonHelper:getGroupName()
        local serverName = LogonHelper:getServerName() or "*"
        local serverGroupConfig = ServerDataMgr:getServerList(groupName)
        local realName = groupName
        if serverGroupConfig and serverGroupConfig.name then
            realName = serverGroupConfig.name
        end
        local innerStr = realName .. ":" .. serverName .. "(" .. groupName .. ")"
        local str = "server: " .. innerStr .. "\n"
        str = str .."ip: " .. ip .. " port: " .. port
        ipText:setText(str)
    end
end

function MainLayer:refreshBg(imageBg, bgPath)
    if bgPath then
        imageBg:setTexture(bgPath)
    end
    local height = imageBg:Size().height
    local width = imageBg:Size().width
    local scaleDisH = GameConfig.WS.height / height
    local scaleDisW = GameConfig.WS.width / width
    local scale = scaleDisH < scaleDisW and scaleDisW or scaleDisH
    local newWidth = width * scale
    local newHeigth = height * scale
    imageBg.disScale = scale
    imageBg.disSize = imageBg:Size()
    imageBg:setContentSize(CCSizeMake(newWidth, newHeigth))

    local dressData = RoleDataMgr:useDressFindData()
    if dressData and dressData.highRoleModel ~= 0 then
        DatingPhoneDataMgr:keepMainBgTexture(false)
    else
        DatingPhoneDataMgr:keepMainBgTexture(imageBg:getTexture())
    end
end

function MainLayer:checkImageBgPos(offsetPos)
    local curPosX = self.background:Pos().x
    local curPosY = self.background:Pos().y
    local disMaxW = nil
    local disMaxH = nil
    local scale = self.background:getScale()
    local oScale = math.max(GameConfig.WS.width/self.background:Size().width,GameConfig.WS.height/self.background:Size().height)
    disMaxW = math.max((scale - oScale) * self.background:Size().width/2,0)
    disMaxH = math.max((scale - oScale) * self.background:Size().height/2,0)

    if disMaxW and disMaxH then
        offsetPos = offsetPos or {}
        offsetPos.x = offsetPos.x or curPosX - self.background.savePos.x
        offsetPos.y = offsetPos.y or curPosY - self.background.savePos.y
        local offsetX = math.min(math.abs(offsetPos.x),disMaxW)
        local offsetY = math.min(math.abs(offsetPos.y),disMaxH)
        if offsetPos.x < 0 then
            offsetX = -offsetX
        end
        if offsetPos.y < 0 then
            offsetY = -offsetY
        end
        curPosX = self.background.savePos.x + offsetX
        curPosY = self.background.savePos.y + offsetY
    end
    return curPosX, curPosY
end

function MainLayer:initLeftButtons()
    if self:isOneCelebrationMainLayer() then
        return
    end

    local tmAllBtns = self.Panel_leftBtList:getChildren()
    self.beginPosList = {} 
    for k,v in ipairs(tmAllBtns) do
		-- print("tmAllBtns------------------------------------------------" .. v:getName())
		-- print("tmAllBtns------------------------------------------------" .. v:getPosition().x .. "," .. v:getPosition().y)
        v.beginPoint = v:getPosition()
        table.insert(self.beginPosList,v:getPosition())
    end
	if self:isOneCelebrationMainLayer() then
		table.sort(self.beginPosList,function ( p1 , p2)
			if math.abs(p1.x - p2.x) < 10  then 
				return p1.y > p2.y
			else 
				return p1.x < p2.x
			end
		end)
	end
end

function MainLayer:updateLeftButtons()
	
    local tmAllBtns  = self.Panel_leftBtList:getChildren()
    local panel_weiba = self.Panel_leftBtList:getChildByName("Panel_newyaer")

    local function OneYearLeftBtnsAct()
        self.oneYearShowBtns = {}
        local idx_1 = 1
        for k,v in ipairs(tmAllBtns) do
            -- 按钮位置无需改变的
            local tempBtnNames = {"Button_notice","Button_mail","Button_welfare", "Button_activity","Button_focus","Button_OneYearShare" }
            local isExist = false 
            for i, name in ipairs(tempBtnNames) do
                if v:getName() == name then
                    if not v.pos then
                        v.pos = v:getPosition()
                    else
                        v:setPosition(v.pos)
                    end
                    table.insert(self.oneYearShowBtns,v)
                    isExist = true
                    break
                end 
            end
            if not isExist and v:isVisible() then
                if idx_1 <= 3 then
					print("getName=" .. v:getName())
					local ui_ =  self.Panel_leftBtList:getChildByName(string.format( "btnPos_%d", idx_1))
					if ui_ then
						local pos = ui_:getPosition()
						v:setPosition(pos)
						idx_1 = idx_1 + 1
						table.insert(self.oneYearShowBtns,v)
					end
                else
                    v:setVisible(false)
                end
            end
        end
    end

    -- 周年庆左侧按钮位置控制
    if FunctionDataMgr:isMainLayerOneYearUI() then
        OneYearLeftBtnsAct()
        --return
    end
    -- 周年庆时间到了并一直在主界面
    if not self.beginPosList and not FunctionDataMgr:isMainLayerOneYearUI() then
        OneYearLeftBtnsAct()
        --return
    end


	--不需要调整按钮位置
	if self:isOneCelebrationMainLayer() then
		--[[
		local idx = 1
		for k,v in ipairs(tmAllBtns) do
			if v:isVisible() then
				if v:getName() ~= "Panel_newyaer" then
					if idx == 7 then 
						idx = idx + 1
					end
					v:setPosition(self.beginPosList[idx])
					idx  = idx + 1
				end
			end
		end
		]]
	else
		local tmAllBtns2 = {self.Button_notice, self.Button_welfare, self.Button_activity,self.Button_focus, self.Button_ScoreReward, self.Button_RoleTeach, self.btn_zhibo }
        if self.Button_serverGiftActivity then
            table.insert(tmAllBtns2,self.Button_serverGiftActivity)
        end
		local idx = 1
		for k,v in ipairs(tmAllBtns2) do
			if v:isVisible() then
				if v:getName() ~= "Panel_newyaer" then
					v:setPosition(self.beginPosList[idx])
					--print("=========" .. v:getName())
					--print("==============================================self.beginPosList[idx]=" .. idx .. "," ..self.beginPosList[idx].x .. "," .. self.beginPosList[idx].y)
					idx  = idx + 1
				end
			end
		end
		
		local tmAllBtns3 = { self.Button_kefu , self.Button_fb, self.Button_twitter,self.Button_update, self.Button_backPlayer, self.Button_wj,self.Button_preview,self.Button_OneYearShare,self.btn_zhuifan}
		local tmAllBtnspos3 = {ccp(52,104),ccp(165,104),ccp(265,104),ccp(52,43),ccp(165,43),ccp(265,43)}
        local idx = 1
        local isShowSpineBtn = false
		for k,v in ipairs(tmAllBtns3) do
			if v:isVisible() then
				v:setPosition(tmAllBtnspos3[idx])
                idx  = idx + 1
                isShowSpineBtn = true
			end
        end
        self.Button_btnListEx:setVisible(isShowSpineBtn)
	end		
		
    if panel_weiba then
        panel_weiba:setVisible(true)
        idx = math.min(idx ,7)  
        panel_weiba:setPosition(self.beginPosList[idx])
    end
	
end

function MainLayer:showLeftBtnAnim()
    self:updateLeftButtons()
    local tmAllBtns = nil
    if not FunctionDataMgr:isMainLayerOneYearUI() then
        tmAllBtns = self.Panel_leftBtList:getChildren()
    else
        tmAllBtns = self.oneYearShowBtns
    end
    
    local idx = 1
    for k,v in ipairs(tmAllBtns) do
        local dtPos = v:getPosition()
        local deltaX = -10*idx
        local curPos = me.p(dtPos.x + deltaX,dtPos.y)
        v:setPosition(curPos)
        local actSpawn = {MoveTo:create(0.05*idx + 0.1,dtPos)}
        if v:isVisible() then
            v:setScale(0.85)
            v:setOpacity(0)
            local actSeq = {DelayTime:create(idx*0.05+0.1),ScaleTo:create(0.1,1)}

            local tmnSpawn = {FadeIn:create(0.05*idx +0.3),Sequence:create(actSeq)}
            actSpawn[#actSpawn + 1] = Spawn:create(tmnSpawn)
            idx = idx + 1
        end
        if #actSpawn > 1 then
            v:runAction(Spawn:create(actSpawn))
        else
            v:runAction(actSpawn[1])
        end
        if v.pos then
            v:setPosition(v.pos)
        end
    end
    if self.Button_newPlayer:isVisible() then
        self.Button_newPlayer:setScale(0.85)
        self.Button_newPlayer:setOpacity(0)
        local orgPos = self.Button_newPlayer:getPosition()
        self.Button_newPlayer:setPosition(me.p(orgPos.x - 20,orgPos.y))
        self.Button_newPlayer:runAction(Spawn:create({FadeIn:create(0.3),MoveTo:create(0.3,orgPos),ScaleTo:create(0.3,1)}))
    end

    if self.Button_Activity5:isVisible() then
        self.Button_Activity5:setScale(0.85)
        self.Button_Activity5:setOpacity(0)
        local orgPos = self.Button_Activity5:getPosition()
        self.Button_Activity5:setPosition(me.p(orgPos.x - 20,orgPos.y))
        self.Button_Activity5:runAction(Spawn:create({FadeIn:create(0.3),MoveTo:create(0.3,orgPos),ScaleTo:create(0.3,1)}))
    end

    if self.Button_Activity6:isVisible() then
        self.Button_Activity6:setScale(0.85)
        self.Button_Activity6:setOpacity(0)
        local orgPos = self.Button_Activity6:getPosition()
        self.Button_Activity6:setPosition(me.p(orgPos.x - 20,orgPos.y))
        self.Button_Activity6:runAction(Spawn:create({FadeIn:create(0.3),MoveTo:create(0.3,orgPos),ScaleTo:create(0.3,1)}))
    end

    if self.Button_Activity1001:isVisible() then
        self.Button_Activity1001:setScale(0.85)
        self.Button_Activity1001:setOpacity(0)
        local orgPos = self.Button_Activity1001:getPosition()
        self.Button_Activity1001:setPosition(me.p(orgPos.x - 20,orgPos.y))
        self.Button_Activity1001:runAction(Spawn:create({FadeIn:create(0.3),MoveTo:create(0.3,orgPos),ScaleTo:create(0.3,1)}))
    end

    if self.Button_Activity7:isVisible() then
        self.Button_Activity7:setScale(0.85)
        self.Button_Activity7:setOpacity(0)
        local orgPos = self.Button_Activity7:getPosition()
        self.Button_Activity7:setPosition(me.p(orgPos.x - 20,orgPos.y))
        self.Button_Activity7:runAction(Spawn:create({FadeIn:create(0.3),MoveTo:create(0.3,orgPos),ScaleTo:create(0.3,1)}))
    end

end

function MainLayer:refreshEffect(effectIds,isBgEffect)
    local mgrTab = nil
    local prefab = nil
    if not isBgEffect then
        mgrTab = self.effectSK or {}
        self.effectSK = mgrTab
        prefab = self.Spine_effectH
    else
        mgrTab = self.effectSKB or {}
        self.effectSKB = mgrTab
        prefab = self.Spine_effectHB
    end

    for k,v in pairs(mgrTab) do
        v:removeFromParent()
        mgrTab[k] = nil
    end

    if type(effectIds) ~= "table" then
        local effectId = effectIds
        effectIds = {effectId}
    end

    for k,effectId in pairs(effectIds) do
        mgrTab[effectId] = Utils:createEffectByEffectId(effectId)
        if not mgrTab[effectId] then
            return
        end

        mgrTab[effectId]:setPosition(prefab:getPosition())
        prefab:getParent():addChild(mgrTab[effectId], prefab:getZOrder())
    end
end

function MainLayer:setBackGroundByTime()
    local dressData = RoleDataMgr:useDressFindData()
    local spbackground = nil
    if dressData and dressData.background and #dressData.background ~= 0 then
        spbackground = dressData.background
    end

    if spbackground then
        local spine = self.background:getChildByName("oneYeaeBgSpine")
        if spine then
            spine:removeFromParent()
        end

        if dressData.kanbanEffect and dressData.kanbanEffect ~= 0 then
            self:refreshEffect(dressData.kanbanEffect)
        else
            self.effectSK = self.effectSK or {}
            for k,v in pairs(self.effectSK) do
                v:removeFromParent()
                self.effectSK[k] = nil
            end
        end
        self.effectSK = self.effectSK or {}
        for k,v in pairs(self.effectSK) do
            v:show()
        end
        if dressData.backgroundEffect and dressData.backgroundEffect ~= 0 then
            self:refreshEffect(dressData.backgroundEffect,true)
        else
            self.effectSKB = self.effectSKB or {}
            for k,v in pairs(self.effectSKB) do
                v:removeFromParent()
                self.effectSKB[k] = nil
            end
        end
        self.effectSKB = self.effectSKB or {}
        for k,v in pairs(self.effectSKB) do
            v:show()
        end
        self.background:setTexture(spbackground)
        self:ResolutionAdaptation()
       
        self:refreshBg(self.background)
        dressData.scale = dressData.scale or 1
        self.background:setScale(dressData.scale)
        local curPosX, curPosY = self:checkImageBgPos(dressData.bgOffset)
        self.background:Pos(curPosX, curPosY)
        return
    else
        self.effectSK = self.effectSK or {}
            for k,v in pairs(self.effectSK) do
                v:removeFromParent()
                self.effectSK[k] = nil
            end
        self.effectSKB = self.effectSKB or {}
        for k,v in pairs(self.effectSKB) do
            v:removeFromParent()
            self.effectSKB[k] = nil
        end
    end

    if Utils:isNewYearMainLayerUi() then
        self:refreshBg(self.background,"ui/newyear/bg_newyear.png")
    else
        local res = "ui/mainLayer/new_ui/bg_morning.png"
        local curDayCid,curNightCid = SceneSoundDataMgr:getCurSceneCid()
        local sceneDayCfg = SceneSoundDataMgr:getMainSceneChange(curDayCid)
        local sceneNightCfg = SceneSoundDataMgr:getMainSceneChange(curNightCid)
        local hour = Utils:getTime(ServerDataMgr:getServerTime())
        if hour <= 18 and hour >= 6 then
            if sceneDayCfg and sceneDayCfg.background then
                res = sceneDayCfg.background
            end
        else
            if sceneNightCfg and sceneNightCfg.background then
                res = sceneNightCfg.background
            else
                res = "ui/mainLayer/new_ui/bg_nightfall.png"
            end
        end

        -- 周年庆固定骨骼背景
        if FunctionDataMgr:isMainLayerOneYearUI() then
            local spine = self.background:getChildByName("oneYeaeBgSpine")
            local defaultBgDayId = Utils:getKVP(46017,"defaultDayScene")
                if curDayCid == defaultBgDayId and nil == spbackground then
                    if not spine then
                        local tempSpine = SkeletonAnimation:create("effect/ui_effect_oneYearKanban/effects_ZNQ_kanban")
                        tempSpine:setName("oneYeaeBgSpine")
                        tempSpine:play("animation", true)
                        tempSpine:setVisible(true)
                        tempSpine:setPosition(self.Spine_effectHB:getPosition())
                        self.background:addChild(tempSpine, self.Spine_effectHB:getZOrder())
                    end
                else
                    if spine then
                        spine:removeFromParent()
                    end
                end
        end
        self:refreshBg(self.background,res)
    end
    self.background:setScale(1)
    self.background:Pos(self.background.savePos)
end

function MainLayer:refreshBg(imageBg, bgPath)
    if bgPath then
        imageBg:setTexture(bgPath)
    end
    local height = imageBg:Size().height
    local width = imageBg:Size().width
    local scaleDisH = GameConfig.WS.height / height
    local scaleDisW = GameConfig.WS.width / width
    local scale = scaleDisH < scaleDisW and scaleDisW or scaleDisH
    local newWidth = width * scale
    local newHeigth = height * scale
    imageBg.disScale = scale
    imageBg.disSize = imageBg:Size()
    imageBg:setContentSize(CCSizeMake(newWidth, newHeigth))

    if  RoleDataMgr:useDressFindData().highRoleModel ~= 0 then
        DatingPhoneDataMgr:keepMainBgTexture(false)
    else
        DatingPhoneDataMgr:keepMainBgTexture(imageBg:getTexture())
    end
end

function MainLayer:updateMainBgm(h)

    local bgmCid
    local curDayBgmCid,curNightBgmCid = SceneSoundDataMgr:getCurSceneBgmId()
    local defaultDay,defaultNight,defaultDayBgm,defaultNightBgm = SceneSoundDataMgr:getDefaultData()
    local hour = Utils:getTime(ServerDataMgr:getServerTime())
    if hour <= 18 and hour >= 6 then
        bgmCid = defaultDayBgm and 0 or curDayBgmCid
    else
        bgmCid = defaultNightBgm and 0 or curNightBgmCid
    end

    local soundCfg = SceneSoundDataMgr:getSoundInfoByCid(bgmCid)
    if soundCfg then
        AudioExchangePlay.playBGM(self, true,soundCfg.bgm)
    else
        local dressData = RoleDataMgr:useDressFindData()
        if dressData and dressData.type and dressData.type == 2 and dressData.kanbanBgm and #dressData.kanbanBgm ~= 0 then
            AudioExchangePlay.playBGM(self, true,dressData.kanbanBgm)
            if not dressData.kanbanBgmId then
                return
            end

            if dressData.kanbanBgmId == 0 then
                return
            end

            local dayBgm = defaultDayBgm and dressData.kanbanBgmId or 0
            local nightBgm = defaultNightBgm and dressData.kanbanBgmId or 0
            if defaultDayBgm or defaultNightBgm then
                SceneSoundDataMgr:Send_SetBackGround(0,0,dayBgm,nightBgm)
            end
        else
            AudioExchangePlay.playBGM(self, true)
        end
    end
end


function MainLayer:addActivity(info)
    local layer = TFPanel:create()
    local activityImg = self.activityItem:clone()
    activityImg:setTexture(info.adicon)
    activityImg:setVisible(true)
    layer:addChild(activityImg)

    self.PageView_Activity:addPage(layer)
end

function MainLayer:updateAction()

    self.PageView_Activity:removeAllPages()
    self.mainAdBoardCfg = {}
    local cfg = MainAdDataMgr:getMainBoardInfo()
    if not cfg then
        return
    end

    table.sort(cfg, function(a, b)
       return a.sort < b.sort
    end)
    self.curPageIndex = 1
    self.openActivityCnt = 0
    for k,v in ipairs(cfg) do
        if v.isOpen == 1 then
            local inTime = self:AdBoardIsInOpenTime(v)
            local open = self:AdBoardIsOpen(v.Id)
            local openByPlate = self:AdBoardIsOpenByPlate(v)
            if open and inTime and openByPlate then
                table.insert(self.mainAdBoardCfg,v)
                self:addActivity(v)
                self.openActivityCnt = self.openActivityCnt + 1
            end
        end
    end

    for i=1,9 do
        self.image_dot[i]:setVisible(i<= self.openActivityCnt)
    end

    local function onActivityCountDownPer()
        if tolua.isnull(self.PageView_Activity) then

            return
        end
        local curIndex = self.PageView_Activity:getCurPageIndex()
        curIndex = curIndex + 1
        if curIndex >= #self.mainAdBoardCfg then
            curIndex = 0
        end
        self.PageView_Activity:scrollToPage(curIndex, 0)
    end
    self.PageView_Activity:stopAllActions()
    self.PageView_Activity:runAction(RepeatForever:create(Sequence:create({DelayTime:create(3.0),CallFunc:create(function()
        onActivityCountDownPer()
    end)})))

    local size = self.Panel_activity:Size()
    local beginPos, endPos = me.p(0, 0), me.p(0, 0)
    self.PageView_Activity:onTouch(function(event)
        if event.name == "began" then
            beginPos = event.target:getTouchStartPos()
            self.PageView_Activity:stopAllActions()
        elseif event.name == "moved" then

        elseif event.name == "ended" then
            endPos = event.target:getTouchEndPos()
            local offsetY = endPos.y - beginPos.y
            if math.abs(offsetY) > size.height * 0.2 then
                local curIndex = self.PageView_Activity:getCurPageIndex()
                curIndex = curIndex + 1
                if curIndex >= #self.mainAdBoardCfg then
                    curIndex = 0
                end
                self.PageView_Activity:scrollToPage(curIndex, 0)
            else
                self.curPageIndex = self.PageView_Activity:getCurPageIndex() + 1
                local cfgInfo = self.mainAdBoardCfg[self.curPageIndex]
                if not cfgInfo then
                    return
                end

                --activityType: 0:界面名字跳转 1:福利活动 2:活动 3:function 跳转(暂时这样，需要整理需求)
                if cfgInfo.activityType == 1 then
                    if ActivityDataMgr:getIsHaveActs() then
                        Utils:openActivityPage(tonumber(cfgInfo.jumpId))
                    end
                elseif cfgInfo.activityType == 2 then
                    FunctionDataMgr:jActivity(tonumber(cfgInfo.jumpId))
                elseif cfgInfo.activityType == 3 then
                    FunctionDataMgr:enterByFuncId(tonumber(cfgInfo.jumpId))
                else
                    Utils:openView(cfgInfo.jumpId)
                end
            end
            self.PageView_Activity:stopAllActions()
            self.PageView_Activity:runAction(RepeatForever:create(Sequence:create({DelayTime:create(3.0),CallFunc:create(function()
                onActivityCountDownPer()
            end)})))
        end
    end)
end

function MainLayer:AdBoardIsInOpenTime(adInfo)

    --不用开启和关闭限制
    if not adInfo.startTime or not adInfo.endTime then
        return  true
    end
    local curTime =  ServerDataMgr:getServerTime()
    -- print(adInfo.id,adInfo.endTime,adInfo.startTime)
    if adInfo.startTime and adInfo.endTime and (curTime >= adInfo.startTime and curTime <=adInfo.endTime) then
        return true
    end
    return false
end

--依据平台判定
function MainLayer:AdBoardIsOpenByPlate(adInfo)

    if not adInfo.os then
        return  true
    end

    local open = false
    for k,v in ipairs(adInfo.os) do
        if v == CC_TARGET_PLATFORM then
            open = true
            break
        end
    end

    return open
end

function MainLayer:AdBoardIsOpen(id)
    --萌新
    if id == 5 then
        local cnt =  RechargeDataMgr:getBuyCount(100)
        local isOpen = FunctionDataMgr:isOpenByServer(59)
        if cnt == 0 and isOpen then
            return true
        end
    --七日活动
    elseif id == 2 then
        local info = ActivityDataMgr:getActIdx(EC_ActivityType.SEVENDAY)
        if info ~= -1 then
            return true
        end
    else
        return true
    end
end

function MainLayer:pageScrollEnd()

    self.curPageIndex = self.PageView_Activity:getCurPageIndex() + 1
    local str = nil
    for i = 1,self.openActivityCnt do
        if self.curPageIndex == i then
            if FunctionDataMgr:isMainLayerOneYearUI() then
                str = "ui/mainLayer3/j2.png"
            else
                str = "ui/mainLayer3/new_ui/activity_tab_01.png"
            end
            
        else
            if FunctionDataMgr:isMainLayerOneYearUI() then
                str = "ui/mainLayer3/j1.png"
            else
                str = "ui/mainLayer/new_ui/activity_tab_02.png"
            end
            
        end
        self.image_dot[i]:setTexture(str)
    end

end

function MainLayer:updateShareView()
    --美久分享
    local info =  ShareDataMgr:getShareInfoById(2)
    if info and info.show then
        Utils:openView("store.ShareMainView")
    end
end

function MainLayer:updatePlayerInfo()
    print("ace updatePlayerInfo")

    local tiliTop = TabDataMgr:getData("LevelUp", MainPlayer:getPlayerLv()).maxEnergy;
    self.playerName:setString(MainPlayer:getPlayerName());
    local heroCid = MainPlayer:getAssistId()
    self.playerIcon:setTexture(AvatarDataMgr:getSelfAvatarIconPath())
    local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getSelfAvatarFrameIconPath()
    self.Image_icon_cover_frame:setTexture(avatarFrameIcon)
    if avatarFrameEffect ~= "" then
        if self.HeadFrameEffect then
            self.HeadFrameEffect:removeFromParent()
            self.HeadFrameEffect = nil
        end
        if not self.HeadFrameEffect then
            self.HeadFrameEffect = SkeletonAnimation:create(avatarFrameEffect)
            self.HeadFrameEffect:setAnchorPoint(ccp(0,0))
            self.HeadFrameEffect:setPosition(ccp(0,0))
            self.HeadFrameEffect:play("animation", true)
            self.Image_icon_cover_frame:addChild(self.HeadFrameEffect, 1)
        end
    else
        if self.HeadFrameEffect then
            self.HeadFrameEffect:removeFromParent()
            self.HeadFrameEffect = nil
        end
    end

    local playerLevel = MainPlayer:getPlayerLv()
    if playerLevel > 9 then
        self.playerLv:setFontSize(24)
    else
        self.playerLv:setFontSize(30)
    end
    self.playerLv:setText(playerLevel);
    self.goldLabel:setText(GoodsDataMgr:getGold(true));
    self.diamondsLabel:setText(GoodsDataMgr:getDiamond());
    self.tiliLabel:setText(GoodsDataMgr:getItemCount(EC_SItemType.POWER).."/"..tiliTop);
    self.LoadingBar_Exp:setPercent(MainPlayer:getExpProgress())
    
    if not FunctionDataMgr:isMainLayerOneYearUI() then
        local nameWidth = self.playerName:getSize().width
        local maxWidth = math.max(nameWidth + 130, 190)
        --self.info_di:setSize(CCSizeMake(maxWidth, 62))
        --self.Panel_player_level:PosX(maxWidth - self.Panel_player_level:getSize().width / 2)
    end


end

function MainLayer:onAvatarUpdata()
    local iconPath = AvatarDataMgr:getSelfAvatarIconPath()
    self.playerIcon:setTexture(iconPath)
    local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getSelfAvatarFrameIconPath()
    self.Image_icon_cover_frame:setTexture(avatarFrameIcon)
    if avatarFrameEffect ~= "" then
        if self.HeadFrameEffect then
            self.HeadFrameEffect:removeFromParent()
            self.HeadFrameEffect = nil
        end
        if not self.HeadFrameEffect then
            self.HeadFrameEffect = SkeletonAnimation:create(avatarFrameEffect)
            self.HeadFrameEffect:setAnchorPoint(ccp(0,0))
            self.HeadFrameEffect:setPosition(ccp(0,0))
            self.HeadFrameEffect:play("animation", true)
            self.Image_icon_cover_frame:addChild(self.HeadFrameEffect, 1)
        end
    else
        if self.HeadFrameEffect then
            self.HeadFrameEffect:removeFromParent()
            self.HeadFrameEffect = nil
        end
    end
end

function MainLayer:updateSystemChat(content,chatState)
    local battlename = nil
    local levellimit = nil
    local nTeamType = 1
    local lab = self.TextArea_system
    if self.TextArea_system.lab then
        self.TextArea_system.lab:RemoveSelf()
        self.TextArea_system.lab = nil
    end

    if chatState and chatState == EC_ChatState.TEAM then
        battlename = content.battlename
        levellimit = content.levellimit
        nTeamType = content.nTeamType
        if not battlename then
            Box("battlename为空")
        end
        if not levellimit then
            Box("levellimit为空")
        end

        local textAttr = TextDataMgr:getTextAttr("r60001")
        local text = TextDataMgr:getFormatText(textAttr,levellimit,battlename)
        if nTeamType == 2 then
            textAttr = TextDataMgr:getTextAttr("r60002")
            text = TextDataMgr:getFormatText(textAttr,battlename)
        end
        lab = TFRichText:create():Text(text):AddTo(self.TextArea_system:getParent()):AnchorPoint(self.TextArea_system:AnchorPoint())
        self.TextArea_system.lab = lab
        self.TextArea_system:setVisible(false)
        self.Panel_system:setVisible(true)
    else
        self.TextArea_system:setVisible(content ~= "")
        self.TextArea_system:setText(content)
        self.Panel_system:setVisible(content ~= "")
    end
    lab:Pos(ccp(self.Panel_system:getSize().width, 13))
    local disx = lab:getSize().width
    local speed = 50
    local time = disx / speed
    lab:stopAllActions()
    local acList = {
        MoveTo:create(time,ccp(-disx,13)),
        DelayTime:create(0.1),
        CCCallFunc:create(function()
            lab:stopAllActions()
            self.Panel_system:setVisible(false)
        end)
    }
    local seqAc = Sequence:create(acList)
    lab:runAction(seqAc)
end


function MainLayer:openPhoneAi(clickRoleId)

    local data = {
        ruleId = self.datingRuleId,
        timeFrame = self.datingTimeFrame,
        clickRole = clickRoleId
    }

    if CC_TARGET_PLATFORM ~= CC_PLATFORM_ANDROID then
        self:onHideLive2D()
        local seqAct = Sequence:create({
            CCFadeOut:create(0.5),
            CCCallFunc:create(function()
                Utils:setScreenOrientation(SCREEN_ORIENTATION_PORTRAIT)
                AlertManager:changeScene(SceneType.Phone,data);
            end)
        })
        self.ui:runAction(seqAct)
    else
        Utils:setScreenOrientation(SCREEN_ORIENTATION_PORTRAIT)
        AlertManager:changeScene(SceneType.Phone,data);
    end
end

function MainLayer:onUpdateMainScene()
    self:setBackGroundByTime()
    self:updateMainBgm()
end


function MainLayer:closeMainLayer(...)
	--[[
	--print("MainLayer:closeMainLayer===============" .. self:getZOrder())
	local scene = Public:currentScene()
    if scene and scene.___mainLayer then
		--local getZOrder = self:getZOrder()
		--Box("---=" .. scene.__cname)
		--local layer = AlertManager:getTopLayer()
		--AlertManager:close(layer)
		print("MainLayer:closeMainLayer close----------------" .. scene.__cname)
		scene:removeLayer(self,true)
		local layer = requireNew("lua.logic.MainScene.MainLayer"):new(true)
		scene:addLayer(layer)
		
		--layer:setZOrder(1)
        scene.___mainLayer = layer
    end
	]]

end


function MainLayer:registerEvents()
    EventMgr:addEventListener(self, EV_RECV_CHATINFO, handler(self.onRecvMessage, self))
    EventMgr:addEventListener(self, EV_RED_POINT_UPDATE_CHAT,handler(self.onRedPointUpdateChat, self))
    EventMgr:addEventListener(self, EV_UPDATE_PLAYERINFO, handler(self.updatePlayerInfo, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.updatePlayerInfo, self))
    EventMgr:addEventListener(self, EV_SWITCH_PRIVATE, handler(self.onSwitchPrivate, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.touchRoleToFavor, handler(self.onTouchRoleToFavor, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.touchRole, handler(self.onTouchRole, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.refreshRedTips, handler(self.onRefreshRedTips, self))
    EventMgr:addEventListener(self, EV_FRIEND_UPDATE, handler(self.onRedPointUpdateFriend, self))
    EventMgr:addEventListener(self, EV_CITY_WORKING_FINISH, handler(self.onRedPointUpdateCity, self))
    EventMgr:addEventListener(self, EV_CITY_WORKING_GETREWARD, handler(self.onRedPointUpdateCity, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.cityDatingTips, handler(self.onRedPointUpdateCity, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.datingOverTime, handler(self.onDatingFail, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.refreshRoleModel, handler(self.onRecvUpdateLive2D, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.triggerPhoneDating, handler(self.onPhoneDating, self))
    EventMgr:addEventListener(self, EV_RED_POINT_UPDATE_MAIL, handler(self.onRedPointUpdateMail, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.outTimePhoneDating, handler(self.phoneDatingOutTime, self))
    EventMgr:addEventListener(self, EV_SUMMON_COMPOSE_UPDATE, handler(self.onRedPointUpdateSummon, self))
    EventMgr:addEventListener(self, EV_RECHARGE_UPDATE,handler(self.updateAction, self))
    EventMgr:addEventListener(self, EV_MAIN_WENJUAN_UPDATE, handler(self.onUpdateWenJuanEvent, self))
    EventMgr:addEventListener(self, EV_MAIN_FOCUS_UPDATE, handler(self.onUpdateMainFuncEvent, self))
    EventMgr:addEventListener(self, EV_MAIN_AD, handler(self.updateAction, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.onUpdateActivitysState, self))
    EventMgr:addEventListener(self, InfoStationDataMgr.UPDATESTATION, handler(self.onUpdateStationRsp, self))
    EventMgr:addEventListener(self, EV_AVATAR_UPDATE, handler(self.onAvatarUpdata, self))
    EventMgr:addEventListener(self, EV_GET_ACTIVITYPOKER_REWAARD, handler(self.onRedPointUpdatePoker, self))
    EventMgr:addEventListener(self, EV_HIDE_MAIN_LIVE2D, handler(self.onHideLive2D, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.refreshFavorLevelUP, handler(self.onRefreshFavorLevelUP, self))
    EventMgr:addEventListener(self, EV_UNION_BASE_INFO_UPDATE, handler(self.onRedPointUpdateUnion, self))
    EventMgr:addEventListener(self, EV_UNION_NOTICE_CHANGE, handler(self.onRedPointUpdateUnion, self))
    EventMgr:addEventListener(self, EV_UNION_APPLY_UPDATE, handler(self.onRedPointUpdateUnion, self))
    EventMgr:addEventListener(self, EV_HUNTER_INFO_UPDATE, handler(self.onRedPointUpdateUnion, self))
    EventMgr:addEventListener(self, EV_HUNTER_REWARDLIST_UPDATE, handler(self.onRedPointUpdateUnion, self))
    EventMgr:addEventListener(self,EV_UNION_QUIT_UNION, handler(self.onQuitUnionBack, self))
    EventMgr:addEventListener(self,EV_NEW_GUIDE_COMPLETE, handler(self.checkAdsShowEnable, self))
    EventMgr:addEventListener(self,EV_DATING_EVENT.robotDialogue, handler(self.onRecvRobotDialogue, self))
    EventMgr:addEventListener(self,EV_UPDATE_SUMMONCONTRACT, handler(self.flushZhaoHuanBtn, self))

    EventMgr:addEventListener(self, EV_ASSISTANCE_FRIENDHELPINFOS, handler(self.onRedPointUpdateFriendHelp, self))
    EventMgr:addEventListener(self,EV_CHANGE_MAINSCENE_INFO, handler(self.onRecvUpdateLive2D, self))
    EventMgr:addEventListener(self,EV_UPDATE_SWITCH_STATE,handler(self.checkSwitchTime, self))
    EventMgr:addEventListener(self,EV_START_SWITCH_TIME,handler(self.startSwitchTime, self))
    EventMgr:addEventListener(self,EV_CHANGE_MAINSCENE_INFO, handler(self.onUpdateMainScene, self))
	
    EventMgr:addEventListener(self,EV_ITEM_RECYCLING_RESULT, handler(self.onRecyclingItems, self))
	EventMgr:addEventListener(self,EV_LIMIT_GIFT_PUSH, handler(self.onCheckPushGift, self))
	
	if not self:isOneCelebrationMainLayer() then
		--self.Panel_btListEx = TFDirector:getChildByPath(self.Panel_left, "Panel_btListEx")
		--self.Button_btnListEx = TFDirector:getChildByPath(self.Panel_left, "Button_btnListEx")
		--self.Panel_btListEx:hide()
		self.Button_btnListEx:onClick(function()
			self.Panel_btListEx:setVisible(not self.Panel_btListEx:isVisible())
            if self.Button_btnListEx.effect then 
                if self.Panel_btListEx:isVisible() then 
                    self.Button_btnListEx.effect:play("idle_1",0)
                else
                    self.Button_btnListEx.effect:play("idle_3",0)
                end
            end
		end)
	end
	

    self.tiliAdd:onClick(function()
            local itemCfg = GoodsDataMgr:getItemCfg(EC_SItemType.POWER)
            if StoreDataMgr:canContinueBuyItemRecover(itemCfg.buyItemRecover) then
                 Utils:openView("common.BuyTiliLayer", itemCfg.id)
            else
                Utils:showTips(800021)
            end
    end)
    self.goldAdd:onClick(function()
            local itemCfg = GoodsDataMgr:getItemCfg(EC_SItemType.GOLD)
            if StoreDataMgr:canContinueBuyItemRecover(itemCfg.buyItemRecover) then
                Utils:openView("common.BuyResourceView", itemCfg.id)
            else
                Utils:showTips(800021)
            end
    end)
    self.Image_coin:setTouchEnabled(true)
    self.Image_coin:onClick(function()
        Utils:showInfo(EC_SItemType.GOLD)
    end)
    self.diamondsAdd:onClick(function()
            FunctionDataMgr:jPay()
    end)

    -- 约会
    self.dateBtn:onClick(function ()
            --FunctionDataMgr:jDating()
            FunctionDataMgr:jCity()
            GameGuide:checkGuideEnd(self.guideFuncId)
    end)

    -- self.Panelyuehui:setTouchEnabled(true)
    -- self.Panelyuehui:onClick(function ()
    --         FunctionDataMgr:jCity()
    --         GameGuide:checkGuideEnd(self.guideFuncId)
    -- end)

    -- 副本
    self.battleBtn:onClick(function ()
        TFAssetsManager:downloadHeroAssets(function()
            --检查更新
            MainPlayer:checkVersion();
            FunctionDataMgr:jPlotFuben()
            GameGuide:checkGuideEnd(self.guideFuncId)
        end,true)
    end)

    self.Panelzuozhan:setTouchEnabled(false)
    -- self.Panelzuozhan:onClick(function ()
    --         --检查更新
    --         MainPlayer:checkVersion();
    --         FunctionDataMgr:jPlotFuben()
    -- end)

    -- 拍照
    self.Button_camera:onClick(function()
            ---------临时用于测试战斗剧情对话------------------------------
            local layer = require("lua.logic.test.StoryTestView"):new()
            AlertManager:addLayer(layer,BLOCK_AND_GRAY)
            AlertManager:show()

    -----------------------------------------

            --self:onTouchCamera()
    end)

    -- 拍照
    self.Button_camera2:onClick(function()
            self:onTouchCamera()
    end)

    self.Button_fairy:onClick(function()
            Utils:openView("fairyNew.FairyMainLayer")

            -- local layer = requireNew("lua.logic.fairyNew.FairyMainLayer"):new()
            -- AlertManager:addLayer(layer)
            -- AlertManager:show()
            GameGuide:checkGuideEnd(self.guideFuncId)
    end)

    -- 背包
    self.Button_bag:onClick(function()
            FunctionDataMgr:jBag()
    end)

    --玩家信息设置
    self.Panel_player_info_touch:onClick(function()
        Utils:openView("playerInfo.PlayerSetting")
            --local layer = require("lua.logic.playerInfo.PlayerSetting"):new()
            --AlertManager:addLayer(layer)
            --AlertManager:show()
    end)

    -- 聊天
    self.Image_chat:setTouchEnabled(true)
    self.Image_chat:onClick(function()
            self:onChatViewOpen();
    end)
    self.Panel_chat_di:onClick(function()
            self:onChatViewOpen();
    end)
    -- 召唤
    -- self.Button_zhaohuan:onClick(function()  --改为3dtouch事件响应
    --         --检查更新
    --         MainPlayer:checkVersion();
    --         FunctionDataMgr:jSummonMain()
    --         GameGuide:checkGuideEnd(self.guideFuncId)
    -- end)

    --modify by beck 触摸事件
    self:registerTouchEvent(self.Button_zhaohuan)
    self:registerTouchEvent(self.Button_recharge)
    self:registerTouchEvent(self.Button_shop)
    self.panel_touch:onClick(function()
        self:hideSubMenu()
    end)

    self.btn_jl:onClick(function()
        FunctionDataMgr:jSummon()
    end)

    self.btn_zd:onClick(function()
        FunctionDataMgr:jCompose()
    end)

    self.btn_recharge_a:onClick(function()
        FunctionDataMgr:jPay(1)
    end)

    self.btn_recharge_b:onClick(function()
        FunctionDataMgr:jPay(2)
    end)

    self.btn_recharge_c:onClick(function()
        FunctionDataMgr:jPay(3)
    end)

    self.btn_shop_a:onClick(function()
        FunctionDataMgr:jStore(100000)
    end)

    self.btn_shop_b:onClick(function()
        FunctionDataMgr:jStore(160000)
    end)

    -- self.Button_backLogin:onClick(function()
    --         AlertManager:changeScene(SceneType.LOGIN,true);
    --     end)

    self.Button_notice:onClick(function()
            if me.platform == "win32" then
                --Utils:openView("login.NoticeBoard")
            elseif me.platform == "android" then
                if HeitaoSdk then
                    HeitaoSdk.isFunctionSupported("showAnnouncement");
                end               
            else
                if tonumber(TFDeviceInfo:getCurAppVersion()) >= 3.10 then
                    if HeitaoSdk then
                        HeitaoSdk.isFunctionSupported("showAnnouncement");
                    end                   
                else
                    if HeitaoSdk then
                        HeitaoSdk.isFunctionSupported("contactCustomerService");
                    end                    
                end
            end
            -- Utils:openView("MainScene.NoticeView")
            -- Utils:openView("MainScene.ProclamationView")
    end)

    self.Button_friend:onClick(function()
            FunctionDataMgr:jFriend()
    end)

    self.Button_mail:onClick(function()
            FunctionDataMgr:jEmail()
    end)

    self.Button_shop:onClick(function()
            --FunctionDataMgr:jStore()  --改为3dtouch事件响应
    end)

    self.Button_task:onClick(function()
            FunctionDataMgr:jTask()
            GameGuide:checkGuideEnd(self.guideFuncId)
    end)


    self.Panel_task = TFDirector:getChildByPath(self.ui,"Panel_task");
    self.Panel_task:onClick(function()
            FunctionDataMgr:jTask()
        end)

    self.Button_giftpacks:onClick(function()
            GlobalVarDataMgr:setValue(GV_ELF_CONTRACT_TIP, true)
            Utils:openView("store.GiftPackMainView")
    end)

    if self.Button_RoleTeach then
        self.Button_RoleTeach:onClick(function()
            Utils:openView("datingPhone.RoleTeachBuyView")
        end)
    end

    self.Button_pokedex:onClick(function()
            FunctionDataMgr:jPokedex()
    end)
    
    self.Button_phone:onClick(function()
        self.Panel_ai_chat:setVisible(false)
        if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 or RELEASE_TEST then
            self:openPhoneAi()
        else
            if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS and tonumber(TFDeviceInfo:getCurAppVersion()) < 3.50) or
                    (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID and tonumber(TFDeviceInfo:getCurAppVersion()) < 3.50) then
                Utils:openView("datingPhone.PhoneMainView",self.datingRuleId,self.datingTimeFrame)
            else
                self:openPhoneAi()
            end
        end
    end)

    self.Button_ARCamera:onClick(function()
        Utils:openView("ar.ARMainLayer")
    end)

    -- 福利
    self.Button_welfare:onClick(function()
            --Utils:openView("task.TaskSignInView")
            if ActivityDataMgr:getIsHaveActs() then
                Utils:openView("activity.ActivityMain")
            end
    end)

    -- 问卷
    self.Button_wj:onClick(function()
            self:onClickButton_wj();
    end)

     self.Button_ScoreReward:onClick(
         function ()
             Utils:openView("activity.ActivityMainView_score", 1,EC_ActivityType2.ONLINE_SCORE_REWARD)
         end
     )

    -- 活动
    self.Button_activity:onClick(function()
        FunctionDataMgr:jActivity()
    end)


    self.Button_activity2:onClick(function ()
        FunctionDataMgr:jActivity2()
    end)

    --周年庆活动
    if self.button_OneYear then
        self.button_OneYear:onClick(function ()
            FunctionDataMgr:jActivity3()
        end)
    end

    if self.button_Caociyuan then
        self.button_Caociyuan:onClick(function ()
            FunctionDataMgr:jActivity4()
        end)
    end

    --应援活动
    self.Button_assist:onClick(function()
        Utils:openView("activity.AssistMainView")
    end)

    --萌新
    self.Button_newPlayer:onClick(function()
        Utils:openView("activity.CuteNewPlayerView")
    end)

    --试胆大会
    self.Button_Activity5:onClick(function()
        FunctionDataMgr:jActivity5()
    end)

    --狂三应援
    self.Button_Activity6:onClick(function()
        FunctionDataMgr:jActivity6()
    end)

    --反十应援活动
    self.Button_Activity1001:onClick(function()
        FunctionDataMgr:jActivity1001()
    end)

    --狂三应援
    self.Button_Activity7:onClick(function()
        FunctionDataMgr:jActivity7()
    end)


    self.Button_backPlayer:onClick(function()
        Utils:openView("activity.BackPlayerView")
    end)

    --设置
    self.Button_setting:onClick(function()
        Utils:openView("settings.SettingsView")
    end)

    self.Button_feellint_edit:onClick(function ()
            --Utils:openView("role.RoleShowView")
        --Utils:openView("role.NewRoleShowView")
        local checkExtId = TFAssetsManager:getCheckInfo(11)
        if checkExtId then
            TFAssetsManager:downloadAssetsOfFunc(checkExtId,function()
                Utils:openView("role.NewRoleShowView")
            end,true)
            return
        else
            TFAssetsManager:downloadHeroAssets(function()
                Utils:openView("role.NewRoleShowView")
            end,true)
        end
    end)

    self.Btn_aiChat:onClick(function(sender)
        -- local function callback()
        --     if DatingPhoneDataMgr:isShowBtnAIChatRed() and  DatingPhoneDataMgr:isUsedPhoneAi() then
        --         DatingPhoneDataMgr:Send_ClearAiMessageRedPoint()
        --     end
        --     DatingPhoneDataMgr:setBtnAIChatRed(false)
        --     Utils:openView("datingPhone.SceondAIChatView")
        -- end
        -- if RoleDataMgr:getUseId() ~= 101 then
        --     Utils:openView("chronoCross.ChronoTaskConfirmView",{titleStrId = 100000147,tipStrId = 100000146,},callback)
        -- else
        --     callback()
        -- end
    end)

    -- 充值
    self.Button_recharge:onClick(function ()
         --FunctionDataMgr:jPayGift()  --改为3dtouch事件响应
    end)

    -- 关注
    self.Button_focus:onClick(function ()
            local info = FunctionDataMgr:getMainFuncInfo(EC_MainFuncType.FOLLOW)
            if info and info.openWelfare then
                FunctionDataMgr:send_PLAYER_REQ_OPEN_WELFARE_INFO(info.type)
                Utils:showWebView(info.welfareUrl)
            end
    end)

    -- 更新
    self.Button_update:onClick(function()
            local info = FunctionDataMgr:getMainFuncInfo(EC_MainFuncType.UPDATE)
            if info and info.openWelfare then
                FunctionDataMgr:send_PLAYER_REQ_OPEN_WELFARE_INFO(info.type)
                Utils:showWebView(info.welfareUrl)
            end
    end)

    self.Button_OneYearShare:onClick(function()
        local info = FunctionDataMgr:getMainFuncInfo(EC_MainFuncType.RESUME)
        if info and info.openWelfare then
            FunctionDataMgr:send_PLAYER_REQ_OPEN_WELFARE_INFO(info.type)
            Utils:openView("store.OneYearShareView")
        end
    end)

    --新年福利
    self.Button_newYear:onClick(function()
            local info = FunctionDataMgr:getMainFuncInfo(EC_MainFuncType.NEW_YEAR)
            if info and info.openWelfare then
                FunctionDataMgr:send_PLAYER_REQ_OPEN_WELFARE_INFO(info.type)
                ActivityDataMgr:sendNewYear();
            end
    end)

    --十香生日 & 体验服论坛
    self.Button_sxsr:onClick(function()
            local info = FunctionDataMgr:getMainFuncInfo(EC_MainFuncType.SXSR)
            if info and info.openWelfare then
                FunctionDataMgr:send_PLAYER_REQ_OPEN_WELFARE_INFO(info.type)
                -- 十香生日
                -- local timestamp = ServerDataMgr:getServerTime();
                -- local key = "@#112qazxswedc7*$%#@!*&2dduebvg";
                -- local server_groupid = ServerDataMgr:getServerGroupID();
                -- local playerid = MainPlayer:getPlayerId();
                -- local playername = MainPlayer:getPlayerName();
                -- local sign = md5.sumhexa(server_groupid..playerid..key..timestamp)

                -- TFDeviceInfo:openUrl(info.welfareUrl.."?playerid="..playerid.."&server_groupid="..server_groupid.."&playername="..playername.."&timestamp="..timestamp.."&sign="..sign);

                 -- 体验服
                local timestamp = ServerDataMgr:getServerTime();
                local key = "7d535f32abaf132fd8b7b7dd2598177d";
                local server_groupid = ServerDataMgr:getServerGroupID();
                local playerid = MainPlayer:getPlayerId();
                local playername = MainPlayer:getPlayerName();
                local token = md5.sumhexa("sid="..server_groupid.."&role_id="..playerid.."&time="..timestamp..key)
                TFDeviceInfo:openUrl(info.welfareUrl.."&role_id="..playerid.."&sid="..server_groupid.."&playername="..playername.."&timestamp="..timestamp.."&token="..token);
            end
        end)

    self.Image_tili_bg:setTouchEnabled(true)
    self.Image_tili_bg:onClick(function ()
        showItemCoolDownTips(EC_SItemType.POWER, self.Image_tili_bg)
    end)

    --大世界
    --self.infoStationBtn:setTextureNormal("icon/fuben/Dungeon_xialamu_1.png")
    -- self.infoStationBtn:onClick(function( )
    --     --FunctionDataMgr:jInfoStation( )
    --     -- Utils:showWebView("http://smi.datealive.com/yhdzz/special/2")
    --     --跳转到大世界入口
    --     FunctionDataMgr:jActivityFubenBigWorld()
    -- end)

    --社团
    self.Button_league:onClick(function()
        FunctionDataMgr:jUnion()
    end)

    -- 月卡
    self.Button_monthCard:onClick(function()
            Utils:openView("store.MonthlyCardTipView")
    end)

    self.Panel_ai_chat:onClick(function()
        if self.Panel_ai_chat:isVisible() then
            DatingPhoneDataMgr:Send_ClearAiMessageRedPoint()
        end
        self.Panel_ai_chat:setVisible(false)
        Utils:openView("datingPhone.SceondAIChatView", self.messageRoleId)
        DatingPhoneDataMgr:setBtnAIChatRed(false)
        -- if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 or RELEASE_TEST then
        --     self:openPhoneAi(self.messageRoleId)
        -- else
        --     if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS and tonumber(TFDeviceInfo:getCurAppVersion()) < 3.50) or
        --             (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID and tonumber(TFDeviceInfo:getCurAppVersion()) < 3.50) then
        --         Utils:openView("datingPhone.PhoneMainView",self.datingRuleId,self.datingTimeFrame)
        --     else
        --         self:openPhoneAi(self.messageRoleId)
        --     end
        -- end
    end)

    self.Button_preview:onClick(function ()
        FunctionDataMgr:send_PLAYER_REQ_OPEN_WELFARE_INFO(EC_MainFuncType.PREVIEW)
        Utils:openView("MainScene.Preview");
    end)

    self.btn_zhuifan:onClick(function ()
        local info = FunctionDataMgr:getMainFuncInfo(EC_MainFuncType.ZHUIFAN)
        if info and info.openWelfare then
            FunctionDataMgr:send_PLAYER_REQ_OPEN_WELFARE_INFO(info.type)
            TFDeviceInfo:openUrl(info.welfareUrl)
        end
    end)

    if self.btn_zhibo then
        self.btn_zhibo:onClick(function()
            local info = FunctionDataMgr:getMainFuncInfo(EC_MainFuncType.ZHIBO)
            if info and info.openWelfare then
                FunctionDataMgr:send_PLAYER_REQ_OPEN_WELFARE_INFO(info.type)
                TFDeviceInfo:openUrl(info.welfareUrl)
            end
        end)
    end

    self.Button_hideUI:onClick(function()
        self:hideOrShowUI(false)
    end)

    self.background:onClick(function()
        self:hideOrShowUI(true)
    end)

    self.Button_assistance:onClick(function()
        FunctionDataMgr:jAssistanceCode()          
    end)
    self.Button_dispatch:onClick(function()
        FunctionDataMgr:jDispatch()
        GameGuide:checkGuideEnd(self.guideFuncId)
    end)

    if self.Button_gongzhu then
        self.Button_gongzhu:onClick(function()
            FunctionDataMgr:jTask(EC_TaskPage.TRAININIG)
        end)
    end

    if self.Button_serverGiftActivity then
        self.Button_serverGiftActivity:onClick(function (  )
            Utils:openView("activity.ServerRechargeView")
        end)
    end
end

function MainLayer:createCustomBtnOnBear(texture , pos , openUrl  , needParam)
    local  btn_ = TFButton:create(texture)
    btn_:setPosition(pos)
    self.Panel_btListEx:addChild(btn_)
    if needParam then
        btn_:onClick(function( ... )
             if me.platform == "win32" then
                return
            end
            local url = openUrl --"http://api-en.datealive.com/yhdzz/customer?"
            local vname = string.url_encode(TFDeviceInfo:getCurAppVersion())
            local uid = string.url_encode(HeitaoSdk.getuserid())
            local sid = string.url_encode(ServerDataMgr:getServerGroupID())
            local role_name = string.url_encode(MainPlayer:getPlayerName())
            local role_id = string.url_encode(MainPlayer:getPlayerId())
            local lang = "en"
            if GAME_LANGUAGE_VAR == EC_LanguageType.Chinese then
                lang = "cn"
            end
            if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
                url = url .."vname=" ..vname .."&uid=" ..uid .."&sid=" ..sid .."&role_name=" ..role_name .."&role_id=" ..role_id .."&lang=" ..lang
                local idfa = string.url_encode(((TFDeviceInfo:getMachineOnlyID()) or 1))
                url = url .."&idfa=" ..idfa
            elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
                local vcode = string.url_encode(TFDeviceInfo:getAppVersionCode() or 0)
                url = url .."vname=" ..vname .."&vcode=" ..vcode .."&uid=" ..uid .."&sid=" ..sid .."&role_name=" ..role_name .."&role_id=" ..role_id .."&lang=" ..lang
                local imei = "000000000000000"
                if HeitaoSdk then
                    local custom = HeitaoSdk.getcustom()
                    if custom ~= "" then
                        local jsonData = json.decode(custom)
                        if jsonData ~= nil and jsonData.imei ~= nil and jsonData.imei ~= "" then
                            imei = jsonData.imei
                        end
                    end
                end
                url = url .."&imei=" ..imei
            end
            TFDeviceInfo:openUrl(url)
        end)

    else
        btn_:onClick(function( ... )
            if me.platform == "win32" then
                return
            end
            local url = openUrl --"http://api-en.datealive.com/yhdzz/customer?"
            TFDeviceInfo:openUrl(url)
        end)
    end
    

    return btn_
end

function MainLayer:registerTouchEvent(node)
    node:addMEListener(TFWIDGET_TOUCHBEGAN, function(...)
        self:onTouchEvent("began", ...)
    end)
    node:addMEListener(TFWIDGET_TOUCHMOVED, function(...)
        self:onTouchEvent("moved", ...)
    end)
    node:addMEListener(TFWIDGET_TOUCHENDED, function(...)
        self:onTouchEvent("ended", ...)
    end)
    node:addMEListener(TFWIDGET_TOUCHCANCELLED, function(...)
        self:onTouchEvent("cancelled", ...)
    end)

    if self.Button_gongzhu then
        self.Button_gongzhu:onClick(function()
            FunctionDataMgr:jTask(EC_TaskPage.TRAININIG)
        end)
    end
end

--为了实现3dtouch
function MainLayer:onTouchEvent(eventName, ...)
    local params = {...}
    local sender = params[1]
    local touchPos = params[2]
    local forceParam = params[#params]

    --打开功能面板
    local openFuncPanel = function()
        if sender == self.Button_zhaohuan then
            MainPlayer:checkVersion()
            FunctionDataMgr:jSummonMain()
            GameGuide:checkGuideEnd(self.guideFuncId)
        elseif sender == self.Button_recharge then
            FunctionDataMgr:jPay()
        elseif sender == self.Button_shop then
            FunctionDataMgr:jStore()
        end
    end

    if sender:hitTest(touchPos) then
        print("forceParam === ", forceParam, eventName)

        if eventName == "began" then
            self.isShowSubMenu = false
        end

        local maxForce = forceParam.maxForce
        local force = forceParam.force
        --新手引导 OR 关闭3dtouch，直接打开召唤面板
        if Utils:isSuport3DTouch(maxForce) == false then
            self.isShowSubMenu = false
        else
            if force >= maxForce * (SettingDataMgr:getTouchPower() / 100) then
                self.isShowSubMenu = true
            end
        end

        if self.isShowSubMenu then
            --打开子菜单面板
            print("show sub menu")
            self:showSubMenu(sender)
        else
            if eventName == "ended" then
                openFuncPanel()
            end
        end
    end
end

function MainLayer:showSubMenu(sender)
    if self.panel_touch:isVisible() then return end

    self.panel_touch:setVisible(true)
    self.panel_touch:setTouchEnabled(true)

    self.img_menu_bg:setOpacity(0)
    self.img_menu_bg:setScale(0)

    if sender == self.Button_zhaohuan then
        self.panel_zhaohuan:setVisible(true)
        self.panel_recharge:setVisible(false)
        self.panel_shop:setVisible(false)
    elseif sender == self.Button_recharge then
        self.panel_zhaohuan:setVisible(false)
        self.panel_recharge:setVisible(true)
        self.panel_shop:setVisible(false)
    elseif sender == self.Button_shop then
        self.panel_zhaohuan:setVisible(false)
        self.panel_recharge:setVisible(false)
        self.panel_shop:setVisible(true)
    end

    local pos = sender:getPosition()
    local wp = sender:getParent():convertToWorldSpace(pos)
    local endPos = self.panel_touch:convertToNodeSpaceAR(wp)
    endPos.x = endPos.x - 100
    endPos.y = endPos.y + 30
    self.img_menu_bg:setPosition(endPos)

    local fadeIn = FadeIn:create(0.1)
    local scaleTo = ScaleTo:create(0.1, 1)
    self.img_menu_bg:runAction(Spawn:create({fadeIn, scaleTo}))
end

function MainLayer:hideSubMenu()
    self.isShowSubMenu = false
    self.panel_touch:setVisible(false)
    self.panel_touch:setTouchEnabled(false)
end

function MainLayer:hideOrShowUI(uiVisible)

    if self.isTouchRole then
        self.isTouchRole = false
        return
    end
    self.Panel_top:setVisible(uiVisible)
    self.Panel_right:setVisible(uiVisible)
    self.Panel_bottom:setVisible(uiVisible)
    self.Panel_chat:setVisible(uiVisible)
    self.topLayer:setVisible(uiVisible)
    self.Panel_left:setVisible(uiVisible)
    self.label_serverTime:setVisible(uiVisible)

    self.GiftRoot:setVisible(uiVisible) 
end

function MainLayer:onClickButton_wj()
    local wjInfo = FunctionDataMgr:getWenJuanInfo()
    if wjInfo and wjInfo.openAsk then
        TFDeviceInfo:openUrl(wjInfo.askUrl)
        self.Image_wjTip:hide()
        CCUserDefault:sharedUserDefault():setBoolForKey(MainPlayer:getPlayerId().."isTouchWJ",true);
    end
end

function MainLayer:onTouchCamera()
    if self.isShowDress then
        return;
    end

    if not self.isCamera then
        self.isCamera = true
        self:widgetHide();
        self.Panel_top:runAction(CCMoveBy:create(0.2,ccp(0,180)))
        self.topLayer:runAction(CCMoveBy:create(0.2,ccp(0,180)))
        self.Panel_bottom:runAction(CCMoveBy:create(0.2,ccp(0,-100)));
        self.Button_camera2:setVisible(true);
        self.Panel_camera:setVisible(true)
        self.elvesNpc:runAction(Sequence:create({CCMoveBy:create(0.2,ccp(300,0))}));
    else
        self.isCamera = false
        self:widgetShow();
        self.Panel_top:runAction(CCMoveBy:create(0.2,ccp(0,-180)))
        self.topLayer:runAction(CCMoveBy:create(0.2,ccp(0,-180)))
        self.Panel_bottom:runAction(CCMoveBy:create(0.2,ccp(0,100)));
        self.Button_camera2:setVisible(false);
        self.Panel_camera:setVisible(false);
        self.elvesNpc:runAction(Sequence:create({CCMoveBy:create(0.2,ccp(-300,0))}));
    end
end

function MainLayer:widgetHide()
    self.Panel_left:runAction(CCFadeOut:create(0.2));
    self.Panel_right:runAction(CCFadeOut:create(0.2));
    -- self.Panel_bottom:runAction(CCMoveBy:create(0.2,ccp(0,-100)));
    self.Panel_chat:runAction(CCMoveBy:create(0.2,ccp(-455,0)));
    --self.Panel_top:runAction(CCMoveBy:create(0.2,ccp(0,80)))

    self.GiftRoot:runAction(CCFadeOut:create(0.2))
end

function MainLayer:widgetShow()
    self.Panel_left:runAction(Sequence:create({CCDelayTime:create(0.2),CCFadeIn:create(0.2)}))--CCFadeIn:create(0.2));
    self.Panel_right:runAction(Sequence:create({CCDelayTime:create(0.2),CCFadeIn:create(0.2)}))--CCFadeIn:create(0.2));
    -- self.Panel_bottom:runAction(Sequence:create({CCDelayTime:create(0.2),CCMoveBy:create(0.2,ccp(0,100))}))
    self.Panel_chat:runAction(Sequence:create({CCDelayTime:create(0.2),CCMoveBy:create(0.2,ccp(455,0))}))
    --self.Panel_top:runAction(Sequence:create({CCDelayTime:create(0.2),CCMoveBy:create(0.2,ccp(0,-80))}))
    
    self.GiftRoot:runAction(Sequence:create({CCDelayTime:create(0.2),CCFadeIn:create(0.2)}))
end

function MainLayer:onChatViewClose()
    self.chatView.closeState = true
    self:widgetShow();
    if self.elvesNpc then
        self.elvesNpc:runAction(Sequence:create({CCMoveBy:create(0.2,ccp(-600,0))}));
    end
    for k, v in pairs(self.effectSK) do
        v:runAction(Sequence:create({CCMoveBy:create(0.2,ccp(-600,0))}))
    end
    self.ui:timeOut(function()
            self.chatView.closeState = nil
            self.chatView = nil
        end,0.3)
end

function MainLayer:onSwitchPrivate()
    local topView = AlertManager:getLayer(-1)
    if topView.__cname ~= "ChatView" then
        self:onChatViewOpen(true)
    end
end

function MainLayer:onChatViewOpen(isOpenInput)
    --if not FunctionDataMgr:checkFuncOpen(42) then return end

    if self.chatView then
        return
    end

    self:widgetHide();
    if self.elvesNpc then
        self.elvesNpc:runAction(Sequence:create({CCMoveBy:create(0.2,ccp(600,0))}));
    end
    for k, v in pairs(self.effectSK) do
        v:runAction(Sequence:create({CCMoveBy:create(0.2,ccp(600,0))}))
    end
    local ChatView = require("lua.logic.chat.ChatView")
    ChatView.show(function ( )
            print("chatView onClosed")
            self:onChatViewClose();
    end,isOpenInput)

    self.chatView = ChatView
end

function MainLayer:onRecvUpdateLive2D()

    local firstFlag = RoleSwitchDataMgr:getFirstFlag()
    if self.isPlaying or firstFlag then
        return
    end

    self.isPlaying = true
    RoleSwitchDataMgr:setSwitchAnimateState(true)
    local act = CCSequence:create({
        CCFadeIn:create(1),
        CCCallFunc:create(function()
            self:onUpdateMainScene()
            self:updateLive2d()
        end),
        CCDelayTime:create(0.5),
        CCFadeOut:create(1),
        CCCallFunc:create(function()
            RoleSwitchDataMgr:resetSwitchTime()
            self.Panel_black:stopAllActions()
            self.isPlaying = false
            RoleSwitchDataMgr:setSwitchAnimateState(false)
        end),
    })
    self.Panel_black:runAction(act)
end

function MainLayer:updateLive2d()

    if self.chatView then
        return
    end
    local modelId = RoleDataMgr:getModel(RoleDataMgr:getUseId())
    if self.elvesNpc then
        pos = self.elvesNpc:getPosition();
        self.elvesNpc:removeFromParent();
        self.elvesNpc = nil;
    end

    local dressData = RoleDataMgr:useDressFindData()
    if dressData and dressData.type and dressData.type == 2 then
        modelId = dressData.highRoleModel
    end

    self.modelId = modelId

    local elvesNpcTable = ElvesNpcTable:createLive2dNpcID(modelId,true,true,nil,true)
    if not elvesNpcTable then
        return
    else
        self.elvesNpc = elvesNpcTable.live2d
    end

    local offPos = dressData.offSet

    if dressData and dressData.type and dressData.type == 2 then
        if offPos and offPos.x and offPos.x ~= 0 and offPos.y and offPos.y ~= 0 then
            self.elvesNpc:setPosition(ccp(410,-100) + ccp(offPos.x,offPos.y))
        else
            self.elvesNpc:setPosition(ccp(410,-100));--位置
        end
    else
        self.elvesNpc:setPosition(ccp(410,-100));--位置
    end

    local uidata = TabDataMgr:getData("Uichange", MainUISettingMgr:getui())
    local uiInitPos = ccp(0, 0)
    if uidata and uidata.popupLocation and uidata.popupLocation.x and uidata.popupLocation.y then
        uiInitPos = ccp(uidata.popupLocation.x, uidata.popupLocation.y)
    end
    local initPos = clone(self.initFeelingPos)
    if dressData and dressData.popupOffset then
        local popupOffset = dressData.popupOffset
        local withUichange = popupOffset.withUichange
        local offX = popupOffset.x or 0
        local offY = popupOffset.y or 0
        initPos.x = initPos.x + offX
        initPos.y = initPos.y + offY

        if withUichange == 1 or (not popupOffset.x and not popupOffset.y) then
            initPos.x = initPos.x + uiInitPos.x
            initPos.y = initPos.y + uiInitPos.y
        end
    end

    self.Panel_feelling_info:setPosition(initPos)

    self.elvesNpc:registerEvents();
    self.elvesNpc:setScale(0.7); --缩放
    self.imageNpc:getParent():addChild(self.elvesNpc)
    self.elvesNpc:setZOrder(self.imageNpc:getZOrder())


    self.imageNpc:setVisible(false)

    self:setBackGroundByTime()
end

function MainLayer:playRoleVoice()
    local remainTime = ServerDataMgr:getServerTime()
    local hour, min = Utils:getFuzzyTime(remainTime)
    print("hour ",hour)
    if hour >= 18 then
        self.voiceHandle = VoiceDataMgr:playVoice("mian_night",RoleDataMgr:getUseId())
    elseif hour >= 12 then
        self.voiceHandle = VoiceDataMgr:playVoice("mian_afternoon",RoleDataMgr:getUseId())
    elseif hour >= 6 then
        self.voiceHandle = VoiceDataMgr:playVoice("mian_morning",RoleDataMgr:getUseId())
    elseif hour >= 0 then
        self.voiceHandle = VoiceDataMgr:playVoice("mian_dawn",RoleDataMgr:getUseId())
    end
end

function MainLayer:removeUI()
    self.super.removeUI(self)
end

function MainLayer:onRecvMessage(chatInfo) 
    if not chatInfo then --清除提示
        if self.Label_message.lab then
            self.Label_message.lab:RemoveSelf()
            self.Label_message.lab = nil
            self.Label_message:setText("")
            self.Label_message:stopAllActions()
        end
        return
    end
    local parentSizeWidth = self.Panel_chat_di and self.Panel_chat_di:getSize().width or 288
    local chatType = chatInfo.chatType
    local actions =
        {
            CCFadeIn:create(0.2),
            CCDelayTime:create(4),
            CCFadeOut:create(0.2)
        }
    -- self.Panel_chat_di:stopAllActions()
    -- self.Panel_chat_di:runAction(CCSequence:create(actions))
    local content = ""
    if chatInfo.fun and chatInfo.fun == EC_ChatState.CHAT then
        if chatType == EC_ChatType.SYSTEM then
            -- content = "[系统]"..chatInfo.content
            content = TextDataMgr:getText(800100)..chatInfo.content            
            self:updateSystemChat(content,chatInfo.fun)
        elseif chatType == EC_ChatType.PRIVATE then
            -- content = "[私聊]"..chatInfo.pname..":"..chatInfo.content
             content = TextDataMgr:getText(800101)..chatInfo.content   
        elseif chatType == EC_ChatType.GUILD then
            -- content = "[帮会]"..chatInfo.pname..":"..chatInfo.content
            self.chat_guild_type = true
             content = TextDataMgr:getText(800102)..chatInfo.content   
        elseif chatType == EC_ChatType.WORLD then
            -- content = "[世界]"..chatInfo.pname..":"..chatInfo.content
             content = TextDataMgr:getText(800103)..chatInfo.content   
        end
    elseif chatInfo.fun and chatInfo.fun == EC_ChatState.TEAM then
        content = json.decode(chatInfo.content)
        if chatType == EC_ChatType.SYSTEM then
            self:updateSystemChat(content,chatInfo.fun)
        end
    elseif chatInfo.fun and chatInfo.fun == EC_ChatState.RED_PACK then
        self.chat_guild_type = true
        content = json.decode(chatInfo.content)
    elseif chatInfo.fun == EC_ChatState.MARQUEE then
        content = chatInfo.content       
        self:updateSystemChat(content,chatInfo.fun)
        return
    end
    local battlename = nil
    local levellimit = nil
    local nTeamType = 1
    if self.Label_message.lab then
        self.Label_message.lab:RemoveSelf()
        self.Label_message.lab = nil
    end

    local lab = self.Label_message
    if chatInfo.fun and chatInfo.fun == EC_ChatState.TEAM and content then
        battlename = content.battlename
        levellimit = content.levellimit
        nTeamType = content.nTeamType
        if not battlename then
            Box("battlename为空")
        end
        if not levellimit then
            Box("levellimit为空")
        end

        local textAttr = TextDataMgr:getTextAttr("r60001")
        local text = TextDataMgr:getFormatText(textAttr,levellimit,battlename)
        if nTeamType == 2 then
            textAttr = TextDataMgr:getTextAttr("r60002")
            text = TextDataMgr:getFormatText(textAttr,battlename)
        end
        lab = TFRichText:create():Text(text):AddTo(self.Label_message:getParent()):AnchorPoint(self.Label_message:AnchorPoint()):Pos(self.Label_message:Pos())
        self.Label_message.lab = lab
        self.Label_message:hide()
        self.chat_guild_type = false
        -- lab = self.Label_message:setTextById("r60001",levellimit,battlename) --在这里此方法存在自动换行
    elseif chatInfo.fun and chatInfo.fun == EC_ChatState.RED_PACK and content then
        self.Label_message:show()
        self.Label_message:setText(content.bless)
        self.chat_guild_type = true
    end

    local size = lab:getContentSize()
    lab:stopAllActions()
    if size.width > parentSizeWidth then
        local posx = parentSizeWidth - size.width -5
        local time = math.abs(posx) / 50
        lab:setPositionX(0)
        local actions =
            {
                CCDelayTime:create(1),
                MoveTo:create(time,me.p(posx,0)),
                CCDelayTime:create(1),
                MoveTo:create(time,me.p(0,0))
            }
        local ac = RepeatForever:create(CCSequence:create(actions))
        lab:runAction(ac)
    else
        lab:setPositionX(0)
    end
end

function MainLayer:onQuitUnionBack()
    self:onRedPointUpdateUnion()
    self:onRedPointUpdateChat()
    if self.chat_guild_type then
        self.Label_message:setText("")
        if self.Label_message.lab then
            self.Label_message.lab:RemoveSelf()
            self.Label_message.lab = nil
            self.Label_message:stopAllActions()
        end
    end
end

--聊天小红点更新
function MainLayer:onRedPointUpdateChat()
    local readState = ChatDataMgr:getReadState()
    self.Image_chat_redPoint:setVisible(not readState)
    local redPacket = ChatDataMgr:getUnionRedPacketReadState()
    self.Image_red_packet:setVisible(redPacket)
    if FunctionDataMgr:isMainLayerOneYearUI() then
        self.Image_redPack_tips:setVisible(false)
    else
        self.Image_redPack_tips:setVisible(redPacket)
    end


    if  self.img_chat_new_tip then
        if not ChatDataMgr:getReadState(EC_ChatType.PRIVATE) then
            self.img_chat_new_tip:show()
        elseif not ChatDataMgr:getReadState(EC_ChatType.GUILD) then
            self.img_chat_new_tip:show()
        else
            self.img_chat_new_tip:hide()
        end
    end
    
    
end

function MainLayer:refreshTitle(node)
    if node.Label_title then 
        if node:isVisible() then 
            node.Label_title:enableStroke(ccc4(0XE8,0X8B,0XD8,0XFF),1)
        else
            node.Label_title:enableStroke(ccc4(0X49,0X57,0X7F,0XFF),1)
        end
    end
end

function MainLayer:onRedPointUpdateMail()
    local isShow = MailDataMgr:checkRedPoint()
    self.Image_mailTip:setVisible(isShow)
    self:refreshTitle(self.Image_mailTip)
end

function MainLayer:onRedPointUpdateSummon()
    local isShow = SummonDataMgr:isShowRedPointInMainView()
    self.Image_summon_tip:setVisible(isShow)
end

function MainLayer:onRedPointUpdateTask()
    local isShow = TaskDataMgr:isShowRedPointInMainView()
    self.Image_taskTips:setVisible(isShow)
    self:refreshTitle(self.Image_taskTips)
end

function MainLayer:onRedPointUpdateFriend()
    local isShow = FriendDataMgr:isShowRedPointInMainView()
    self.Image_friendTip:setVisible(isShow)
    self:refreshTitle(self.Image_friendTip)
end

function MainLayer:onRedPointUpdateWelfare()
    local isShow = ActivityDataMgr:checkRedPoint();
    self.Image_welfareTip:setVisible(isShow);
end

function MainLayer:onRedPointUpdateCity()
    local show = CityDataMgr:isShowRedPointInMainView()
    if DatingDataMgr:isHaveCityDating() then
        show = true
    end
    --self.Image_cityTip:setVisible(show)
end

function MainLayer:onRedPointUpdatePoker()
    local isShow = CollectDataMgr:checkCollectRedPoint()
    self.Image_poker_tip:setVisible(isShow)
    self:refreshTitle(self.Image_poker_tip)
end

function MainLayer:onRedPointUpdateUnion()
    self.Image_leagueTip:setVisible(LeagueDataMgr:getAllUnionRedPoint())
	
	if self.Association_TextArea_name then
		local unionData = LeagueDataMgr:getMyUnionInfo()
		if not unionData then
			self.Association_TextArea_name:hide()
		else
			self.Association_TextArea_name:show()
            local countryStr = ""
            if unionData.showCountry and tonumber(unionData.country) > 0 then
                countryStr = " ("..LeagueDataMgr:getClubCountryDataById(unionData.country).Countryabbreviations..")"
            end
			self.Association_TextArea_name:setText(unionData.name .. countryStr)
		end
		
	end
end

function MainLayer:onRedPointUpdateActivity()
    local isShow = ActivityDataMgr2:isShowRedPointInMainView()
    self.Image_activityTip:setVisible(isShow)
    local isShow = ActivityDataMgr2:isShowRedPointInMainView(2)
    self.Image_activityTip2:setVisible(isShow)
    local isShow = ActivityDataMgr2:isShowRedPointInMainView(5)
    self.Image_activity_red5:setVisible(isShow)
    local isShow = ActivityDataMgr2:isShowRedPointInMainView(6)
    self.Image_activity_red6:setVisible(isShow)
    local isShow = ActivityDataMgr2:isShowRedPointInMainView(1001)
    self.Image_activity_red1001:setVisible(isShow)
    local isShow = ActivityDataMgr2:isShowRedPointInMainView(7)
    self.Image_activity_red7:setVisible(isShow)

end

function MainLayer:onRedPointUpdateDispatch()
    local isShow = DispatchDataMgr:checkHasRewards()
    self.Image_dispatchTips:setVisible(isShow)
    self:refreshTitle(self.Image_dispatchTips)
end

function MainLayer:onRedPointUpdateAssistActivity()
    local activitys = ActivityDataMgr2:getAssistActivityInfo()
    if #activitys < 1 then
        self.Button_assist:setVisible(false)
        return
    end
    self.Button_assist:setVisible(false)
    local isShow = ActivityDataMgr2:isAssistRedPoint()
    self.Image_assist_Tip:setVisible(isShow)
end

function MainLayer:onRedPointNewOrBackPlayerActivity()
    local activitys = ActivityDataMgr2:getNewPlayerActivityInfo(true)
    if #activitys < 1 then
        self.Button_newPlayer:setVisible(false)
    else
        self.Button_newPlayer:setVisible(true)
    end
    
   -- local isShow = ActivityDataMgr2:isNewPlayerRedPoint(true)
   -- self.Image_newPlayerTip:setVisible(isShow)

    local activitysBack = ActivityDataMgr2:getNewPlayerActivityInfo(false)
    if #activitysBack < 1 then
        self.Button_backPlayer:setVisible(false)
        return
    end
    self.Button_backPlayer:setVisible(true)
    local isShow = ActivityDataMgr2:isBackPlayerRedPoint(EC_ActivityType2.BACKPLAYER) or
                    ActivityDataMgr2:isBackPlayerRedPoint(EC_ActivityType2.BACKACTIVITY)
    self.Image_backPlayerTip:setVisible(isShow)

    local extendData = json.decode(activitysBack[1].extendData)
    if extendData and extendData.showType == 1 and (not MainPlayer:getOneLoginStatus(EC_OneLoginStatusType.ReConfirm_ShowBackTips)) then
        MainPlayer:setOneLoginStatus(EC_OneLoginStatusType.ReConfirm_ShowBackTips, 1)
        Utils:openView("activity.BackPlayerTipsView", extendData.return_day)
    end
end

function MainLayer:onTouchRoleToFavor(favorValue)
    local data = {}
    data.favorValue = favorValue
    data.pos = ccp(130,400)
    local layer = require("lua.logic.common.FavorUpView"):new(data)
    -- AlertManager:addLayer(layer,AlertManager.NONE)
    -- AlertManager:show()
    self.imageNpc:getParent():addChild(layer,1000);
    self:refreshFeellingInfo()
end

function MainLayer:refreshFeellingInfo()

    local roleId = RoleDataMgr:getUseId()

    -- local imageNewRed = self.Btn_aiChat:getChildByName("img_redNew")
    -- if not DatingPhoneDataMgr:isUsedPhoneAi() and roleId == 101 then
    --     imageNewRed:setVisible(true)
    -- else
    --     if self.messageRoleId == roleId then
    --         imageNewRed:setVisible(true)
    --     else
    --         imageNewRed:setVisible(false)
    --     end
    -- end

    self.imgBtnaiChatRed:setVisible(DatingPhoneDataMgr:isShowBtnAIChatRed())

    -- local _bool = nil
    -- if DatingPhoneDataMgr:getPhoneBaseCfg(roleId).openAI then
    --     _bool = true
    -- else
    --     _bool = false
    -- end
    -- self.Btn_aiChat:setTouchEnabled(_bool)
    -- self.Btn_aiChat:setVisible(_bool)
    -- self.Img_lockAiChat:setVisible(not _bool)

    --屏蔽ai聊天室入口
    self.Btn_aiChat:setTouchEnabled(false)
    self.Btn_aiChat:setTextureNormal("ui/mainLayer/L3.png")
    self.Btn_aiChat:setFlipY(false)
    self.imgBtnaiChatRed:hide()

    self.Panel_feelling_info:show()
    self.Label_feelling_level:setText("LV."..RoleDataMgr:getFavorLevel(roleId))
    local curFavor = RoleDataMgr:getFavor(roleId)
    local maxFavor = RoleDataMgr:getCurLvMaxFavor(roleId)
    local percent = curFavor / maxFavor * 100
    self.LoadingBar_feelling_bar:setPercent(percent)
    -- if not GoodsDataMgr:getItem(EC_SItemType.ROLETOUCHTIMES) or GoodsDataMgr:getItemCount(EC_SItemType.ROLETOUCHTIMES) == 0 then
    --     self.Label_feelling_reach_max:show()
    -- else
    --     self.Label_feelling_reach_max:hide()
    -- end
    self.Label_feelling_percent:setText(curFavor.."/"..maxFavor)
end

local timerUpdate_ = nil;
function MainLayer:addTimerUpdate()
    if self.timerUpdate_ then
        return
    end
    self.timerUpdate_ = TFDirector:addTimer(1000, -1, nil, handler(self.onCountDownPer,self))
    timerUpdate_ = self.timerUpdate_;
end

function MainLayer:onCountDownPer(dt)

    local  time_s_hour , time_s_min , time_s_sec = ServerDataMgr:customUtcTimeForServer()
    self.label_serverTime:setString(string.format("%02d:%02d:%02d UTC-7" , time_s_hour , time_s_min , time_s_sec))

    if not self.feellingInfoShowTime_ then
        TFDirector:removeTimer(timerUpdate_)
        self.timerUpdate_ = nil
        timerUpdate_ = nil
        return;
    end

    self.feellingInfoShowTime_ = self.feellingInfoShowTime_ + 1
    if self.feellingInfoShowTime_ > 3 then
        self.Panel_feelling_info:hide()
    end


    --屏蔽补给站礼包时间显示
    -- local giftBagEndTime = RechargeDataMgr:getLimitGiftBagTime()
    -- if giftBagEndTime > 0 and giftBagEndTime > ServerDataMgr:getServerTime() then
    --     local day, hour, min = Utils:getFuzzyDHMS(giftBagEndTime - ServerDataMgr:getServerTime(), true)
    --     self.Label_left_time:show()
    --     self.Label_left_time:setTextById(1260001, tostring(hour), tostring(min))
    -- else
    --     self.Label_left_time:hide()
    -- end

    self:updateGiftTime()
end

function MainLayer:onTouchRole()

    self.isTouchRole = true
    if self.voiceHandle then
        TFAudio.stopEffect(self.voiceHandle)
        self.voiceHandle = nil
    end
    self.feellingInfoShowTime_ = 0
    self:refreshFeellingInfo()

    self.Image_switch_role:stopAllActions()
    local stopTime = ServerDataMgr:getServerTime() + 10
    local seqact = Sequence:create({
        DelayTime:create(1),
        CallFunc:create(function()
            if ServerDataMgr:getServerTime() >= stopTime then
                self.Image_switch_role:stopAllActions()
                self:checkSwitchTime()
            end
        end)

    })
    self.Image_switch_role:runAction(CCRepeatForever:create(seqact))
end

function MainLayer:onRefreshRedTips()
    self:refreshRedTips()
end

function MainLayer:refreshRedTips()
    if RoleDataMgr:isElvesStateTip() or CityJobDataMgr:checkJobEventDown() then
        self.Image_yuehuiRedTips:show()
    else
        self.Image_yuehuiRedTips:hide()
    end
end

function MainLayer:onDatingFail()
    self:showFailDatingLayer()
end

function MainLayer:showFailDatingLayer()
    local cityDatingInfo = DatingDataMgr:getReserveFailScript(true)
    if cityDatingInfo then
        DatingDataMgr:sendGetSciptMsg(cityDatingInfo.datingType,nil,nil,nil,nil,cityDatingInfo.cityDatingId)
    end
end

function MainLayer:onShow()
    self.super.onShow(self)
    self.ui:show()

    self.dateBtn:setTouchEnabled(true)
    self.battleBtn:setTouchEnabled(true)
    self.Button_Activity1001:setTouchEnabled(true)

    --活动按钮是否显示
    self.Button_activity:setVisible(table.count(ActivityDataMgr2:getActivityInfo()) > 0);
    --检查更新
    MainPlayer:checkVersion()

    self:onRedPointUpdateChat()
    self:onRedPointUpdateTask()
    self:onRedPointUpdateWelfare()
    self:onRedPointUpdateFriend()
    self:onRedPointUpdateCity()
    self:onRedPointUpdateActivity()
    self:onRedPointUpdateAssistActivity()
    self:onRedPointNewOrBackPlayerActivity()
    self:onRedPointUpdateMail()
    self:onRedPointUpdateSummon()
    self:onRedPointUpdatePoker()
    self:onRedPointUpdateUnion()
    self:onRedPointUpdateDispatch()

    --检查过期折扣券
    self:checkOverdueCoupon()

    --self.Image_noticeTip:setVisible(TaskDataMgr:getTempValue())
    --self.Image_noticeTip:setVisible(NoticeDataMgr:getNoticeCount() > 0)
    self.Image_noticeTip:setVisible(false)
    self.Image_wjTip:setVisible(not MainPlayer:getIsTouchWJ());
    self.fairyTips:setVisible(HeroDataMgr:checkRedPoint());
    if self.chatView and not self.chatView.closeState then
        self:onChatViewClose()
    end

    local redPoin = TitleDataMgr:checkTitleRedState()
    self.Image_player_redTip:setVisible(redPoin)

    -- 月卡充值提示
    self:updateMonthCardState()

    -- 更新问卷显示状态
    self:updateWenJuanState()

    -- 更新打开网页类按钮状态
    local mainFuncInfo = FunctionDataMgr:getMainFuncInfo()
    for k, v in pairs(mainFuncInfo) do
        self:updateMainFuncState(k)
    end

    self:oneYearUIDeal()

    if self.button_Caociyuan and not self.button_Caociyuan:isVisible() then
        self.ui:runAnimation("Action4",1)
    else
        --self.ui:runAnimation("Action0",1)
    end
    
    self:updateLive2d()
    self:showLeftBtnAnim()
    self:timeOut(function()
        self:removeLockLayer()
        GameGuide:checkGuide(self);
    end,0.1)

    self:showFailDatingLayer()

    self:onPhoneDating()
    self:phoneDatingOutTime()
    self:checkShowAiMessage()
    self:checkNewRecharge()
    self:checkStarEvaluate()
    self:check206TypeInfo()
    self:checkPreview();
    self:updateGiftPacksState()
    self:checkAdsShowEnable()
    self:checkOneYearShare()
    self:updateMainBgm()

    self:checkSwitchTime()
    self:onCheckPushGift()

    HeroDataMgr:changeDataToSelf()

    self:flushZhaoHuanBtn()


    SpineCache:getInstance():clearUnused();
    me.TextureCache:removeUnusedTextures();
    collectgarbage("collect");

    --[[local phoneBackState = DatingPhoneDataMgr:getPhoneBackState()
    if phoneBackState then
        --self:onHideLive2D()
        self.ui:setOpacity(0)
        local seqAct = Sequence:create({
            CCFadeIn:create(1),
            CCCallFunc:create(function()
                DatingPhoneDataMgr:setPhoneBackState()
            end)
        })
        self.ui:runAction(seqAct)
    end]]


    local haveUnlockHero = HeroDataMgr:checkLockHero()
    self.fairyImage_unlock:setVisible(haveUnlockHero)
    if not haveUnlockHero then
        local haveHeroUp = HeroDataMgr:checkHeroUp()
        self.Image_roleup:setVisible(haveHeroUp)
    else
        self.Image_roleup:setVisible(false)
    end
    
    if self.Button_gongzhu then
        self.Button_gongzhu:hide()
        if ActivityDataMgr2:isWarOrderActivityOpen() then
            self.Button_gongzhu:show()
        end
    end
	
	if self.showRffect then
		local changeEffect = SkeletonAnimation:create("effect/effect_WK_zhuanchang/effect_WK_zhuanchang")
        changeEffect:hide()
        changeEffect:setPosition(ccp(GameConfig.WS.width*0.5,GameConfig.WS.height*0.5))
        self.ui:addChild(changeEffect, 1000)
        changeEffect:addMEListener(TFARMATURE_COMPLETE,function(skeletonNode)
            skeletonNode:removeFromParent(true)
        end)
        self.showRffect = false
        TFDirector:addTimer(3, 1, nil, handler(function()
            changeEffect:show()
            changeEffect:play("animation", true)
        end, self))


		--self.Spine_changeEffect:playByIndex(0,0)
		
		--Box("123")
		--headEffect = SkeletonAnimation:create("effect/effect_WK_zhuanchang/effect_WK_zhuanchang")
		--headEffect:setAnchorPoint(ccp(0,0))
		--headEffect:setName("headEffect")
		--headEffect:setPosition(ccp(0,0))
		--headEffect:play("animation", true)
		--self.ui:addChild(headEffect, 1)
	end

    self:onUpdateServerGiftRedPoint()


    --请求回收过期物品
    FunctionDataMgr:request_ITEM_REQ_TIME_OUT_ITEM_CONVERT()

    --TODO CLOSE
    self.Button_ARCamera:hide()
    -- self.Button_ARCamera:show()
    -- if not(CC_TARGET_PLATFORM == CC_PLATFORM_IOS or CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID or CC_TARGET_PLATFORM == CC_PLATFORM_WIN32) then
    --     self.Button_ARCamera:hide()
    -- end
    

end

function MainLayer:onUpdateServerGiftRedPoint(  )
    -- body
    if not self.Image_serverGiftTip then return end
    self.Image_serverGiftTip:hide()
    local activityInfos = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.SERVER_GIFT)
    if #activityInfos > 0 then
        for k,v in ipairs(activityInfos) do
            local items = ActivityDataMgr2:getItems(v)
            for _,v in ipairs(items) do
                local progressInfo = ActivityDataMgr2:getProgressInfo(EC_ActivityType2.SERVER_GIFT,v)
                if progressInfo.status == EC_TaskStatus.GET then
                    self.Image_serverGiftTip:show()
                    return
                end
            end
        end
    end
end

function MainLayer:oneYearUIDeal()
    if FunctionDataMgr:isMainLayerOneYearUI() then
        -- 周年庆红点按钮状态更改
        self:redBtnCheckState()
        -- 周年庆活动按钮
        self:updateOneYearBtns()
	else
		self:updateOneYearBtns()
    end
end

function MainLayer:redBtnCheckState()
    if not self.redBtnObjs or #self.redBtnObjs == 0  then
        return
    end
    for i, tab in ipairs(self.redBtnObjs) do
        local redPoint = tab.redPoint
        local btn = redPoint:getParent()
        local normolSource = "ui/mainLayer3/"..tab.normolState
        local redSource = "ui/mainLayer3/"..tab.redState

        if redPoint:isVisible() then
            btn:setTextureNormal(redSource)
        else
            btn:setTextureNormal(normolSource)
        end
    end
end

function MainLayer:updateOneYearBtns()
        self.button_Caociyuan:setVisible(FunctionDataMgr:isMainLayerOneYearUI("chaociyuanBtn"))
        self.button_OneYear:setVisible(FunctionDataMgr:isMainLayerOneYearUI("oneyearBtn"))
		self.Image_CaociyuanClip:setVisible(FunctionDataMgr:isMainLayerOneYearUI("chaociyuanBtn"))
        self.Image_OneYearClip:setVisible(FunctionDataMgr:isMainLayerOneYearUI("oneyearBtn"))
        if self.button_OneYear:isVisible() then
            local activityInfos = ActivityDataMgr2:getActivityInfo(nil,3)
            self.button_OneYear:setVisible(#activityInfos > 0)
        end
        if self.button_Caociyuan:isVisible() then
            local activityInfos = ActivityDataMgr2:getActivityInfo(nil,4)
            self.button_Caociyuan:setVisible(activityInfos and #activityInfos > 0)
        end

        -- 活动按钮动作
        local function runBtnAct(btn, img)
            local act = Sequence:create({
                    CallFunc:create(function()
                        btn:setVisible(false)
                        img:setVisible(true)
                    end),
                    ScaleTo:create(0.3, 1.3),
                    CallFunc:create(function()
                        btn:setVisible(true)
                        img:setVisible(false)
                    end)
                })
                img:runAction(act)
        end
        if self.button_OneYear:isVisible() then
            runBtnAct(self.button_OneYear,self.Image_OneYearClip)
        end
        if self.button_Caociyuan:isVisible() then
            runBtnAct(self.button_Caociyuan,self.Image_CaociyuanClip)
        end
		
		--按钮移动位置
		if not self:isOneCelebrationMainLayer() then
			if  (self.Button_Activity5 and self.Button_Activity5:isVisible()) or (self.Button_Activity6 and self.Button_Activity6:isVisible()) or (self.Button_Activity1001 and self.Button_Activity1001:isVisible()) or (self.button_OneYear and self.button_OneYear:isVisible()) or (self.button_Caociyuan and self.button_Caociyuan:isVisible()) or (self.Button_Activity7 and self.Button_Activity7:isVisible()) then
                self.dateBtn:setPosition(ccp(393,200))
				self.battleBtn:setPosition(ccp(581,200))
				
				self.Button_dispatch:setPosition(ccp(649,347))
				self.Button_task:setPosition(ccp(573,369))
				self.Button_pokedex:setPosition(ccp(494,352))
				self.Button_mail:setPosition(ccp(344,351))
				self.Button_friend:setPosition(ccp(422,369))
				
				self.Panel_activity:setPosition(ccp(467,448))
			end
		end
		
end

function MainLayer:checkAdsShowEnable()
    if GuideDataMgr:isInNewGuide() then
        self:updateShareView()
        return
    end
    local ret = self:checkShowNewGuyGift()
    if not ret then
        self:updateShareView()
    end
    self:checkChristmasSignIn()
    self:checkChristmasBag()
    self:checkSevenSign()



end

function MainLayer:checkOneYearShare()
    local info = FunctionDataMgr:getMainFuncInfo(EC_MainFuncType.RESUME)
    if info and info.openWelfare then
        local openTip = ShareDataMgr:getOpenTipFlag()
        if openTip == 0 then
            Utils:openView("store.OneYearShareView")
            ShareDataMgr:setOpenTipFlag()
        end
    end
end

function MainLayer:updateMonthCardState()
    local remainDay = RechargeDataMgr:getMonthCardLeftTime()
    -- dump(remainDay)
    self.Button_monthCard:setVisible(remainDay > 0 and remainDay <= 5)
    if self.Button_monthCard:isVisible() then
        local isShowMonthCardTip = GlobalVarDataMgr:getValue(GV_MONTH_CARD_TIP)
        self.Image_monthCardTip:setVisible(tobool(isShowMonthCardTip))
    end
end

function MainLayer:removeEvents()
    if self.timerUpdate_ then
        TFDirector:removeTimer(self.timerUpdate_)
        self.timerUpdate_ = nil
        timerUpdate_ = nil;
    end

    if self.flushContractTimer then
        TFDirector:stopTimer(self.flushContractTimer)
        TFDirector:removeTimer(self.flushContractTimer)
        self.flushContractTimer = nil
    end

    --移除点击事件 解决进入木桩副本快速点击跳转约会的问题
    self.dateBtn:removeMEListener(TFWIDGET_CLICK)
    self.battleBtn:removeMEListener(TFWIDGET_CLICK)
end

--手机抖动
function MainLayer:shakePhone()

    --[[local isUsed = DatingPhoneDataMgr:isUsedPhoneAi()
    if not isUsed then
        self.Spine_phone:play("animation2",true)
        self.Image_newtip:setVisible(true)
        return
    end]]

    local isNewPhone,ruleId =  DatingDataMgr:getPhoneDating()
    if isNewPhone then
        self.Spine_phone:play("animation2",true)
        self.Image_newtip:setVisible(true)
        return
    end

    local messageRoleId =  DatingPhoneDataMgr:getMessageRoleId()
    if messageRoleId then
        self.Spine_phone:play("animation3",true)
        self.Image_newtip:setVisible(true)
        return
    end

    local isNewOutTime = DatingPhoneDataMgr:isNewOutTimePhoneDating()
    if isNewOutTime then
        self.Spine_phone:play("animation2",true)
        self.Image_newtip:setVisible(true)
    end

    self.Spine_phone:play("animation",true)
    self.Image_newtip:setVisible(false)
end

--检测5星好评
function MainLayer:checkStarEvaluate()
    if true then
        return
    end
    --android屏蔽
    if CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        if HeitaoSdk then
            --国服安卓引导到tap评价用的
            -- local customId = HeitaoSdk.getcustom()
            -- if not customId or customId == "" then
            --     return
            -- end
            -- customId = json.decode(customId).chid
            -- print("customId:",customId)
            -- print(type(customId))
            -- if type(customId) == "string" then
            --     customId = tonumber(customId)
            -- end
            -- if customId ~= 10134000 then
            --     return
            -- end
        end
        --onestore包没有5星评价
        if EX_ASSETS_ENABLE and (HeitaoSdk and tonumber(HeitaoSdk.getplatformId()) == 3) then return end
    else
        --999001服务器屏蔽
        --TODO close
        -- local serverid = ServerDataMgr:getCurrentServerID()
        -- if serverid == 999001 then
        --     return
        -- end
    end

    --检测5星好评
    local evaluateFlage = CommonManager:getStarEvaluateFlage()
    dump(evaluateFlage)
    if not evaluateFlage then
        return
    end

    local playerId = MainPlayer:getPlayerId()
    local isRecord = CCUserDefault:sharedUserDefault():getBoolForKey(playerId.."Evaluate")
    dump(isRecord)
    if isRecord then
        return
    end

    local playerLv = MainPlayer:getPlayerLv()
    if playerLv >= 30 then
        return
    end
    Utils:openView("MainScene.EvaluateView")
end

--未购买萌新礼包的玩家,在跑完新手引导后弹出界面提示
function MainLayer:checkShowNewGuyGift()
    local cnt =  RechargeDataMgr:getBuyCount(100)
    local isOpen = FunctionDataMgr:isOpenByServer(59)
    local show = (cnt == 0 and isOpen)
    if not show then
        return false
    end

    local playerId = MainPlayer:getPlayerId()
    local isJumpSecond = CCUserDefault:sharedUserDefault():getBoolForKey(playerId.."NewGuyGifySecondJump")

    local isLoginIn = CommonManager:getFirstLoginIn()
    if isLoginIn and isJumpSecond then
        return false
    end

    --判断是否弹出过
    local isSave = CommonManager:getNewGuyGifyBagFlage()
    if isSave then
        if not CommonManager:getNewGuyGiftBagIsCanJumpSecond() then
            return false
        end
    end

    Utils:openView("store.NewGuyGiftBag")
    CommonManager:saveNewGuyGiftBagIsCanJumpSecond()
    return true
end

function MainLayer:checkChristmasSignIn()
    local isLoginIn = CommonManager:getFirstLoginIn()
    if isLoginIn then
        return false
    end

    if ActivityDataMgr:getChristmasSignInFlag() then
        return false
    end

    local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.CHRISTMAS_SIGN)
    if #activity > 0 then
        if ActivityDataMgr2:isShowRedPoint(activity[1]) then
            Utils:openView("activity.ChristmasSignInView")
        end
    end
end

function MainLayer:checkSevenSign()
    local isLoginIn = CommonManager:getFirstLoginIn()
    if isLoginIn then
        return false
    end

    if GlobalVarDataMgr:getValue(GV_FULI_SEVENSIGNIN_FLAG) then
        return false
    end

    local actIndex = ActivityDataMgr:getActIdx(EC_ActivityType.SEVENDAY)
    if actIndex ~= -1 then
        local isCanReceive = ActivityDataMgr:getIsCanReceive(actIndex)
        if isCanReceive then
            GlobalVarDataMgr:setValue(GV_FULI_SEVENSIGNIN_FLAG, true)
            Utils:openView("activity.SevenSignView")            
        end
    end
end

function MainLayer:checkChristmasBag()

    local isOpen = CommonManager:getChristmasBagFlage()
    if  isOpen then
        return
    end

    local adInfo = MainAdDataMgr:getAdInfoById(26)
    if not adInfo then
        return
    end

    local inTime = self:AdBoardIsInOpenTime(adInfo)
    if not inTime then
        return
    end

    local giftData = RechargeDataMgr:getGiftData()
    if not giftData then
        return
    end
    local giftBuyState = {}
    for k,v in ipairs(giftData) do
        if v.rechargeCfg.id == 264 or v.rechargeCfg.id == 265 or v.rechargeCfg.id == 266 then
            local isCanBuy = true
            if v.buyCount ~= 0 and v.buyCount - RechargeDataMgr:getBuyCount(v.rechargeCfg.id) <= 0 then
                isCanBuy = false
            end
            giftBuyState[v.rechargeCfg.id] = isCanBuy
        end
    end

    local showWnd = false
    if giftBuyState[266] and (giftBuyState[264] or giftBuyState[265]) then
        showWnd = true
    end

    if not showWnd then
        return
    end

    Utils:openView("store.ChristmasBag")
end

function MainLayer:check206TypeInfo()
    if GuideDataMgr:isInNewGuide() then
        return
    end
    local typeId = 206
    local info = FunctionDataMgr:getMainFuncInfo(typeId);
    local NO_TIPS_IN_LOGIN =  MainPlayer:getOneLoginStatus("NO_TIPS_IN_LOGIN");
    if not info or NO_TIPS_IN_LOGIN or not info.openWelfare then
        return;
    end

    local playerid                      = MainPlayer:getPlayerId()
    local noTipsToday ,recordTime       = FunctionDataMgr:getType206AdvertisementState();

    if not noTipsToday then
        MainPlayer:setOneLoginStatus("NO_TIPS_IN_LOGIN", 1)
        local groupId = 0
        if HeitaoSdk then
            groupId = math.floor(HeitaoSdk.getplatformId() / 10000)
        end
        local createTime = MainPlayer:getCreateTime()
        local playerLv = MainPlayer:getPlayerLv()
        local totalPay = RechargeDataMgr:getTotalPay() * 0.01
        local attach = "&sid=" .. groupId .. "&role_id=" .. playerid .. "&role_level=" .. playerLv
        attach = attach .. "&pay_amount=" .. totalPay .. "&create_time=" .. createTime
        local webView = Utils:showWebView(info.welfareUrl, nil, nil, attach)
        if webView then
            webView:setIsRecordNoTipsToday(true)
        end
    end
end

function MainLayer:checkPreview()
    local typeId = EC_MainFuncType.PREVIEW
    local info = FunctionDataMgr:getMainFuncInfo(typeId)
    if info and tobool(info.openWelfare) then
        local openWebView = function(pid, newtime, url)
            CCUserDefault:sharedUserDefault():setStringForKey("previewopenTime_"..pid, newtime)
            CCUserDefault:sharedUserDefault():flush()
            Utils:openView("MainScene.Preview");
        end
        local playerid = MainPlayer:getPlayerId()
        local opentime = CCUserDefault:sharedUserDefault():getStringForKey("previewopenTime_"..playerid)
        local servertime = ServerDataMgr:getServerTime()
        if opentime == "" then
            openWebView(playerid, servertime, info.welfareUrl)
        else
            opentime = tonumber(opentime)
            if (servertime - opentime) >= 86400 then
                openWebView(playerid, servertime, info.welfareUrl)
            end
        end
    end
end

function MainLayer:startSwitchTime()

    local isInSwitch = RoleSwitchDataMgr:getSwitchState()
    if not isInSwitch then
        self.Image_switch_role:stopAllActions()
        return
    end

    local seqact = Sequence:create({
        DelayTime:create(1),
        CallFunc:create(function()
            local nextSwitchTime = RoleSwitchDataMgr:getNextSwitchTime()
            if ServerDataMgr:getServerTime() >= nextSwitchTime then
                self.Image_switch_role:stopAllActions()
                RoleSwitchDataMgr:setFirstFlag(false)
                RoleSwitchDataMgr:setNextRole()
            end
        end)

    })
    self.Image_switch_role:runAction(CCRepeatForever:create(seqact))
end

function MainLayer:checkSwitchTime()

    local isInSwitch = RoleSwitchDataMgr:getSwitchState()
    if not isInSwitch then
        self.Image_switch_role:stopAllActions()
        return
    end

    local nextSwitchTime = RoleSwitchDataMgr:getNextSwitchTime()
    if ServerDataMgr:getServerTime() >= nextSwitchTime then
        self.Image_switch_role:stopAllActions()
        RoleSwitchDataMgr:setFirstFlag(false)
        RoleSwitchDataMgr:setNextRole()
        return
    end

    local seqact = Sequence:create({
        DelayTime:create(1),
        CallFunc:create(function()
            local nextSwitchTime = RoleSwitchDataMgr:getNextSwitchTime()
            if ServerDataMgr:getServerTime() >= nextSwitchTime then
                self.Image_switch_role:stopAllActions()
                RoleSwitchDataMgr:setFirstFlag(false)
                RoleSwitchDataMgr:setNextRole()
            end
        end)

    })
    self.Image_switch_role:runAction(CCRepeatForever:create(seqact))
end

function MainLayer:onPhoneDating()
    -- self:shakePhone()
    self.Spine_phone:play("animation",true)
    local isNewPhone,ruleId,datingTimeFrame =  DatingDataMgr:getPhoneDating()
    if isNewPhone then
        self.datingRuleId = ruleId
        self.datingTimeFrame = datingTimeFrame
        self.Image_newtip:setVisible(true)
    else
        self.datingRuleId = nil
        self.datingTimeFrame = nil
        DatingDataMgr:setPhoneDating(nil,nil,nil)
        self.Image_newtip:setVisible(false)
    end
end

--手机约会过期提示
function MainLayer:phoneDatingOutTime()
    --self:shakePhone()
end

function MainLayer:checkShowAiMessage()
    --屏蔽ai气泡
     self.Panel_ai_chat:hide()
     
--暂时注释 2020 03 09
 --    local isNewPhone,ruleId,datingTimeFrame =  DatingDataMgr:getPhoneDating()
 --    if isNewPhone then
 --        return
 --    end

 --    local triggerFlag = DatingPhoneDataMgr:getTriggerFlag()
 --    if not triggerFlag then
 --        return
 --    end

 --    if not DatingPhoneDataMgr:isHaveChatWhihAI() then
	-- 	return
 --    end
    
 --    --等级判断
	-- local playerLv = MainPlayer:getPlayerLv()
	-- if playerLv <= DatingPhoneDataMgr:needPlayerLv() then
	-- 	return
	-- end

 --    local seqact = Sequence:create({
 --        DelayTime:create(1),
 --        CallFunc:create(function()
 --            -- dump(ServerDataMgr:getOnlineTime())
 --            if ServerDataMgr:getOnlineTime() > DatingPhoneDataMgr:needOnlineTime() and not DatingPhoneDataMgr:getHaveRequest() then
 --                DatingPhoneDataMgr:Send_AiTriiger()
 --            end
 --        end)
        
 --    })
 --    self.Panel_ai_chat:runAction(CCRepeatForever:create(seqact))
end

---展示Ai聊天消息弹窗
function MainLayer:showAiMessageTip()

    self.Panel_ai_chat:stopAllActions()

    TFDeviceInfo:Vibrator(100)
    self.Panel_ai_chat:setVisible(true)
    self.Panel_ai_chat:setOpacity(0)
    self.Panel_ai_chat:setPosition(self.aichat_initPos)
    local spawnAct = CCSpawn:create({
        CCFadeIn:create(0.5),
        CCMoveBy:create(0.5,ccp(0, 100))
    })

    local seqAct = Sequence:create({
        spawnAct,
        -- CCDelayTime:create(5),
        -- CCCallFunc:create(function()
        --     self.Panel_ai_chat:setVisible(false)
        -- end)
    })
    self.Panel_ai_chat:runAction(seqAct)

    -- self:shakePhone()
end

function MainLayer:onRecvRobotDialogue(data)

    if not data then
        return
    end
    if not data.returnMsg then
        return
    end

    if data.type ~= EC_PhoneChatType.Message then
        return
    end

    local contentStr = {}
    for k,jsonMessage in ipairs(data.returnMsg) do
        local message = json.decode(jsonMessage)
        local messageContent = self:transformDigueStr(message.content)
        local content = string.htmlspecialchars(messageContent)
        local moodid = message.moodid                   ---表情代码
        local faceNum = message.num                     ---表情数量
        local fileName = message.file_name or ""        ---语音文件文件名
        local faceInfo = DatingPhoneDataMgr:getFaceInfoById(moodid)
        if faceInfo then
            for i=1,faceNum do
                content = content..faceInfo.sourcecode
            end
        end
        content = self:transformDigueStr(content)
        table.insert(contentStr,{content = content,type = EC_PhoneContentType.Normal,fileName = fileName})
    end

    ---只做一条处理
    dump(contentStr[1].content)
    self.messageRoleId = data.roleId
    local roleInfo = DatingPhoneDataMgr:getRoleInfoById(data.roleId)
    self.ai_Image_head:setTexture(roleInfo.icon)
    self.Label_hero_name:setTextById(roleInfo.nameId)

    local inputText = contentStr[1].content
    local faceCfg = DatingPhoneDataMgr:getFaceEmotion()
    local matchCnt,cnt = 0,0
    for k,v in ipairs(faceCfg) do
        inputText,cnt = string.gsub(inputText,v.specialcode,v.convermotion)
        if matchCnt == 0 then
            matchCnt = cnt
        end
    end
    inputText = string.gsub(inputText, "\n", "<br/>")
    local posY = matchCnt == 0 and 10 or 20
    local richText = self.Panel_ai_mask:getChildByName("richTx")
    if not richText then
        richText = TFRichText:create(ccs(690, 30))
        richText:AnchorPoint(me.p(0, 1))
        richText:setName("richTx")
        self.Panel_ai_mask:addChild(richText,2)
    end
    richText:setPosition(ccp(0,posY))
    richText:Text(TextDataMgr:getFormatText(TextDataMgr:getTextAttr("r301007"),inputText))
    local size = richText:getSize()
    dump(size)
    self.Label_ai_message:setVisible(size.height > 40)

    --保存
    local dialogueStr = EC_PhoneSaveType.robot..contentStr[1].content
    DatingPhoneDataMgr:insertDialogue(self.messageRoleId,dialogueStr)
    DatingPhoneDataMgr:writeDialogue()

    DatingPhoneDataMgr:setMessgeRoleId(self.messageRoleId)

    -- 新消息红点提示
    if self.messageRoleId then
        DatingPhoneDataMgr:setBtnAIChatRed(true)
    end

    self:showAiMessageTip()
end

function MainLayer:transformDigueStr(inputStr)

    local faceEmotionCfg = DatingPhoneDataMgr:getFaceEmotion()
    for k,v in ipairs(faceEmotionCfg) do
        inputStr = string.gsub(inputStr,v.conversioncode,v.specialcode)
    end

    return inputStr
end


function MainLayer:checkNewRecharge()

    local flag = RechargeDataMgr:getClickMainLayerFlag()
    if flag then
        self.Image_MainLayer_new:setVisible(false)
        return
    end

    if FunctionDataMgr:isOpen(RechargeDataMgr:getTotalOpenId()) and RechargeDataMgr:getTotalRedDotState() then
        self.Image_MainLayer_new:setVisible(true)
    end

    local exist = RechargeDataMgr:existGiftBagNewFlag()
    if exist then
        self.Image_MainLayer_new:setVisible(true)
    end

end

function MainLayer:updateWenJuanState()
    local wjInfo = FunctionDataMgr:getWenJuanInfo()
    if wjInfo and wjInfo.openAsk then
        self.Button_wj:show()
    else
        self.Button_wj:hide()
    end
    self:updateLeftButtons()
end

function MainLayer:updateGiftPacksState(  )
    self.Button_giftpacks:show()

    self.Image_redTips:hide()
    local redState = false
    local havecard = tobool(RechargeDataMgr:getMonthCardLeftTime() > 0)
    local cansign = RechargeDataMgr:isMonthCardCanSign()
    local canGetTask = SummonDataMgr:getCanGetTask()
    --暂时屏蔽养成基金红点判断
    --if RechargeDataMgr:isGrowFundViewShowRed() or (havecard and cansign) or canGetTask then
    if (havecard and cansign) or canGetTask then
        redState = true
    end
    if redState then
        self.Image_redTips:show()        
    end
end

function MainLayer:updateMainFuncState(type_)
    local mainFuncInfo = FunctionDataMgr:getMainFuncInfo(type_)
    if mainFuncInfo then
        if type_ == EC_MainFuncType.FOLLOW then
            self.Button_focus:setVisible(tobool(mainFuncInfo.openWelfare))
            self.Image_focusTip:setVisible(tobool(mainFuncInfo.isShowRed))
        elseif type_ == EC_MainFuncType.UPDATE then
            self.Button_update:setVisible(tobool(mainFuncInfo.openWelfare))
            self.Image_updateTip:setVisible(tobool(mainFuncInfo.isShowRed))
        elseif type_ == EC_MainFuncType.NEW_YEAR then
            self.Button_newYear:setVisible(tobool(mainFuncInfo.openWelfare))
            self.Image_newYearTip:setVisible(tobool(mainFuncInfo.isShowRed))
        elseif type_ == EC_MainFuncType.PREVIEW then
            self.Button_preview:setVisible(tobool(mainFuncInfo.openWelfare))
            self.Image_previewTip:setVisible(tobool(mainFuncInfo.isShowRed))
        elseif type_ == EC_MainFuncType.SXSR then
            self.Button_sxsr:setVisible(tobool(mainFuncInfo.openWelfare))
            self.Image_sxsrTip:setVisible(tobool(mainFuncInfo.isShowRed))
        elseif type_ == EC_MainFuncType.RESUME then
            self.Button_OneYearShare:setVisible(tobool(mainFuncInfo.openWelfare))
            self.Image_lvli:setVisible(tobool(mainFuncInfo.isShowRed))
        elseif type_ == EC_MainFuncType.SCORE then
            self.Button_ScoreReward:setVisible(tobool(mainFuncInfo.openWelfare))
            self.Image_lvli:setVisible(tobool(mainFuncInfo.isShowRed))
        elseif type_ == EC_MainFuncType.ZHUIFAN then
            self.btn_zhuifan:setVisible(tobool(mainFuncInfo.openWelfare))
            self.Image_zhuifan:setVisible(tobool(mainFuncInfo.isShowRed))
        elseif type_ == EC_MainFuncType.ZHIBO then
            self.btn_zhibo:setVisible(tobool(mainFuncInfo.openWelfare))
            self.img_zhibo:setVisible(tobool(mainFuncInfo.isShowRed))
        end
    else
        if type_ == EC_MainFuncType.FOLLOW then
            self.Button_focus:hide()
        elseif type_ == EC_MainFuncType.UPDATE then
            self.Button_update:hide()
        elseif type_ == EC_MainFuncType.NEW_YEAR then
            self.Button_newYear:hide();
        elseif type_ == EC_MainFuncType.PREVIEW then
            self.Button_preview:hide();
        elseif type_ == EC_MainFuncType.SXSR then
            self.Button_sxsr:hide();
        elseif type_ == EC_MainFuncType.RESUME then
            self.Button_OneYearShare:hide();
        elseif type_ == EC_MainFuncType.SCORE then
            self.Button_ScoreReward:hide();
        elseif type_ == EC_MainFuncType.ZHUIFAN then
            self.btn_zhuifan:hide();
        elseif type_ == EC_MainFuncType.ZHIBO then
            self.btn_zhibo:hide();
        end
    end
    self:updateLeftButtons()
end

function MainLayer:onUpdateWenJuanEvent()
    self:updateWenJuanState()
end

function MainLayer:onUpdateMainFuncEvent(type_)
    self:updateMainFuncState(type_)
end

function MainLayer:onUpdateActivitysState()
    self:onRedPointUpdateActivity()
    self:onRedPointUpdateAssistActivity()
    self:onRedPointNewOrBackPlayerActivity()
    local activityInfos = ActivityDataMgr2:getActivityInfo(nil,2)
    self.Button_activity2:setVisible(#activityInfos > 0)

    local activityInfos = ActivityDataMgr2:getActivityInfo(nil,5)
    self.Button_Activity5:setVisible(#activityInfos > 0)

    local activityInfos = ActivityDataMgr2:getActivityInfo(nil,6)
    self.Button_Activity6:setVisible(#activityInfos > 0)

    local activityInfos = ActivityDataMgr2:getActivityInfo(nil,1001)
    self.Button_Activity1001:setVisible(#activityInfos > 0)

    local activityInfos = ActivityDataMgr2:getActivityInfo(nil,7)
    self.Button_Activity7:setVisible(#activityInfos > 0)

    if self.Button_serverGiftActivity then
        local activityInfos = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.SERVER_GIFT)
        self.Button_serverGiftActivity:setVisible(#activityInfos > 0)
    end

    if FunctionDataMgr:isMainLayerOneYearUI() then
        if self.button_OneYear:isVisible() then
            local activityInfos = ActivityDataMgr2:getActivityInfo(nil,3)
            self.button_OneYear:setVisible(#activityInfos > 0)
        end
        if self.button_Caociyuan:isVisible() then
            local activityInfos4 = ActivityDataMgr2:getActivityInfo(nil,4)
            self.button_Caociyuan:setVisible(activityInfos4 and #activityInfos4 > 0)
        end
    end
end

function MainLayer:onUpdateStationRsp( )
    -- self.infoStationBtn:setVisible(InfoStationDataMgr:getEnterState())
    -- self.infoStationWhiteImage:setVisible(InfoStationDataMgr:getEnterState())
end

--试炼状态更新
-- function MainLayer:onUpdateSimulationTrial()
--     -- --试炼开启的情况下显示试炼，否则显示夏拉姆 ，情报站不在显示
--     if FunctionDataMgr:isOpen(113) and FubenDataMgr:getSimulationTrialIsOpen() then
--         --跳转模拟试炼
--         self.infoStationBtn:setTextureNormal("ui/mainui/main_shilian.png")
--         self.infoStationBtn:onClick(function()
--             FunctionDataMgr:jActivityFubenSimulationTrial()
--         end)
--     else
--         大世界
--         self.infoStationBtn:setTextureNormal("icon/fuben/Dungeon_xialamu_1.png")
--         self.infoStationBtn:onClick(function()
--              FunctionDataMgr:jActivityFubenBigWorld()
--         end)
--     end
-- end

function MainLayer:onHideLive2D()
    if self.elvesNpc then
        self.elvesNpc:hide()
    end
end

function MainLayer:onRefreshFavorLevelUP(lastLevel,newLevel)
    local data = {}
    data.lastLevel = lastLevel
    data.newLevel = newLevel
    local favorUpgradeLayer = require("lua.logic.dating.FavorUpgradeLayer"):new(data)
    AlertManager:addLayer(favorUpgradeLayer,AlertManager.BLOCK,AlertManager.TWEEN_NONE)
    AlertManager:show()
end

function MainLayer:flushZhaoHuanBtn(  )
    -- body
    local label_timing = TFDirector:getChildByPath(self.panel_contractSummon,"label_contract_timing")

    local function flushContractSummonTime( ... )
        local contractInfo = SummonDataMgr:getSummonContractInfo()
        if contractInfo.summonInfo then
            local remainTime = math.max(contractInfo.summonInfo.endTime - ServerDataMgr:getServerTime())
            local day,hour,min,sec = Utils:getTimeDHMZ(remainTime)
            label_timing:setTextById(1325313, hour, min, sec)
            if remainTime > 0 then
                self.panel_contractSummon:show()
                self.Image_upTips:hide()
                if not self.flushContractTimer then
                    self.flushContractTimer = TFDirector:addTimer(1000,-1,nil,flushContractSummonTime)
                end
            else
                SummonDataMgr:resertSummon()
                local isOpenNoob = SummonDataMgr:isOpenNoob()
                self.Image_upTips:setVisible(isOpenNoob)
                self.panel_contractSummon:hide()
            end

        else
            local isOpenNoob = SummonDataMgr:isOpenNoob()
            self.Image_upTips:setVisible(isOpenNoob)
            self.panel_contractSummon:hide()
        end
    end

    flushContractSummonTime()
end

---------------------------guide------------------------------

--引导任务
function MainLayer:excuteGuideFunc1001(guideFuncId)
    local targetNode = self.Button_task
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

--引导作战
function MainLayer:excuteGuideFunc1002(guideFuncId)
    local targetNode = self.battleBtn
    self.guideFuncId = guideFuncId
    self.dateBtn:setTouchEnabled(false)
    self.Button_Activity1001:setTouchEnabled(false)
    GameGuide:guideTargetNode(targetNode)
end

--引导召唤
function MainLayer:excuteGuideFunc1003(guideFuncId)
    local targetNode = self.Button_zhaohuan
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode, ccp(0, 13))
end

--引导精灵
function MainLayer:excuteGuideFunc1004(guideFuncId)
    local targetNode = self.Button_fairy
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode, ccp(0, 13))
end

--引导约会
function MainLayer:excuteGuideFunc1005(guideFuncId)
    local targetNode = self.dateBtn
    self.guideFuncId = guideFuncId
    self.battleBtn:setTouchEnabled(false)
    GameGuide:guideTargetNode(targetNode)
end

--引导指挥作战
function MainLayer:excuteGuideFunc20000(guideFuncId)
    local targetNode = self.Button_dispatch
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

function MainLayer:check()
end

function MainLayer:onHide()
    self:addLockLayer()
    self.super.onHide(self)
    if self.elvesNpc and self.elvesNpc.effectHandle and not self.chatView then
        TFAudio.stopEffect(self.elvesNpc.effectHandle)
        self.elvesNpc.effectHandle = nil
    end
    if self.voiceHandle then
        TFAudio.stopEffect(self.voiceHandle)
        self.voiceHandle = nil
    end

    if self.elvesNpc and not self.chatView then
        self.elvesNpc:removeFromParent();
        self.elvesNpc = nil;
    end
    self.Panel_ai_chat:stopAllActions()
    self.Panel_ai_chat:setVisible(false)
end

function MainLayer:onRecyclingItems(data)
    if next(data) then
        Utils:openView("bag.RecyclingItems", data)
    end

end

function MainLayer:onCheckPushGift()
    self:updatePushGiftList()
	local giftData = RechargeDataMgr:getPushGift(1)
    if giftData then
        local currentScene = Public:currentScene()
        if currentScene and currentScene:getTopLayer() and currentScene:getTopLayer().__cname == "MainLayer" then
            --Utils:openView("store.LimitGiftPackShowView")
			Utils:openView("store.PushGiftView", giftData)
        end
    end
end

function MainLayer:updatePushGiftList()
	local GiftRoot = TFDirector:getChildByPath(self.ui,"GiftRoot");
	if GiftRoot == nil then
		return;
	end
    GiftRoot:setPositionX(234)
	GiftRoot:removeAllChildren()
	local giftPrefab = TFDirector:getChildByPath(self.ui,"PrefabGift");
	local limitData = RechargeDataMgr:getLimitGiftData()   
    if not limitData then return end
	local scale = 1
	for i = 1, #limitData do
		local data = limitData[i]
		local serverTime = ServerDataMgr:getServerTime()	
		if data.triggerEndDate and data.triggerEndDate - serverTime > 0 then
			local exData = json.decode(data.extendData)
			if exData then
				local clone = giftPrefab:clone()	
				clone.data = data

				GiftRoot:addChild(clone)
				clone:setPosition(0,0)
				clone:setScale(scale)
				clone.size = clone:getSize()
				clone:setPositionX((i - 1) * 70)

				clone.button = clone:getChildByName("Button_Gift")
				clone.button:setTextureNormal(exData["Icon"]);
				clone.button:onClick(function()
					 Utils:openView("store.PushGiftView", clone.data)
				end)

				clone.Name = clone:getChildByName("Name")
				clone.Name:setText(data["name"])
                clone.Name:setSkewX(10)

				clone.TimeCount = clone:getChildByName("TimeCount")		
                clone.TimeCount:setPositionY(-32)
                clone.Name:setPositionY(0)
				local hour, min = Utils:getFuzzyTime(data.triggerEndDate - serverTime, true)
				local str = TextDataMgr:getText(301011,hour, min)
				clone.TimeCount:setText(str)

				table.insert(self.giftButton, clone)
			end
		end		
	end
end

function MainLayer:updateGiftTime()
	local serverTime = ServerDataMgr:getServerTime()	
	for k, btn in pairs(self.giftButton) do
		if btn.data then
			local TimeCount = btn:getChildByName("TimeCount")
            local time = math.max(btn.data.triggerEndDate - serverTime,0)						
			local hour, min = Utils:getFuzzyTime(time, true)
			local str = TextDataMgr:getText(301011,hour, min)
			TimeCount:setText(str)
		end
	end
end

--检查过期折扣券
function MainLayer:checkOverdueCoupon( ... )
    if GuideDataMgr:isInNewGuide() then
        return
    end
    if Utils:getIsDayChangeBySaveData( "IsJumpOverdueCoupon" ) then
        local time_1 = self.overdueTime.thirdNotification.leftTime[1]
        local time_2 = self.overdueTime.secondNotification.leftTime[1]
        local goodsData = {}
        local originItem , convertItem = GoodsDataMgr:getOverdueCouponData(1002 ,time_1 * 60 , time_2 * 60)
        goodsData.originItem = originItem
        goodsData.convertItem = convertItem
        if #goodsData.originItem >0 or #goodsData.convertItem >0 then
            Utils:openView("bag.OverduePromptView", goodsData)
        else
            Utils:clearDayChageSaveData( "IsJumpOverdueCoupon" )
        end
    end
end

return MainLayer;

--[[强制热更]]
