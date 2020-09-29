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
*
* 地图基础UI视图
* 
]]

local MapUtils = import(".MapUtils")
local BaseMap = import(".BaseMap")
local BaseHero = import(".BaseHero")
local RokerView = import(".RokerView")
local BaseCamera = import(".BaseCamera")
local OSDControl = import(".OSDControl")
local OSDConfig = import(".OSDConfig")
local BattleConfig = require("lua.logic.battle.BattleConfig")
local OSDEnum  = import(".OSDEnum")
local HeroType = OSDEnum.HeroType
local FuncType = OSDEnum.FuncType
local enum = require("lua.logic.battle.enum")
-- local eCameraFlag = enum.eCameraFlag
local OSDConnector = import(".OSDConnector")
local BaseMapView = class("BaseMapView", BaseLayer)

function BaseMapView:ctor(...)
	self.super.ctor(self, ...)
	self:init("lua.uiconfig.osd.MapLayer")
	self:loadMap()
    self:initFuncListView()
    self.isReConnect = false        --是否重连
    OSDControl:setView(self)
end

function BaseMapView:initUI(ui)
	self.super.initUI(self, ui)

	self.rootPanel = TFDirector:getChildByPath(ui, "panel_root")
	self.uiPanel = TFDirector:getChildByPath(ui, "panel_ui")
    local Panel_roll_message = TFDirector:getChildByPath(self.uiPanel, "Panel_roll_message")
    Panel_roll_message:hide()
    -- self.panel_chat_message = TFDirector:getChildByPath(self.uiPanel, "Panel_chat_message")
    -- self.image_redpoint     = TFDirector:getChildByPath(self.uiPanel, "Image_redpoint")
    -- self.image_redpoint:hide()
    -- local scrollView_chat_message =TFDirector:getChildByPath(self.uiPanel, "ScrollView_chat_message")
    -- self.chatListView = UIListView:create(scrollView_chat_message)
	self.mapPanel = TFDirector:getChildByPath(self.rootPanel, "panel_map")
	self.returnBtn = TFDirector:getChildByPath(self.uiPanel, "btn_return")
	self.btnInteraction = TFDirector:getChildByPath(self.uiPanel, "btn_interaction") --互动
    self.btnInteraction:hide()
    self.btnChange = TFDirector:getChildByPath(self.uiPanel, "Button_change") --切换角色

	self.rokerPanel = TFDirector:getChildByPath(self.uiPanel, "panel_roker")

	self.infoPanel = TFDirector:getChildByPath(self.uiPanel, "panel_player_info")
	self.infoPanel:setTouchEnabled(true)

	self.playerInfoBg = TFDirector:getChildByPath(self.infoPanel, "info_di")
    self.levelPanel = TFDirector:getChildByPath(self.infoPanel, "panel_player_level")
    self.headIcon = TFDirector:getChildByPath(self.infoPanel, "img_player_icon")
    self.headFrame = TFDirector:getChildByPath(self.infoPanel, "img_icon_cover_frame")
    self.nameTxt = TFDirector:getChildByPath(self.infoPanel, "txt_name")
    self.levelTxt = TFDirector:getChildByPath(self.infoPanel, "txt_level")
    self.expBar = TFDirector:getChildByPath(self.infoPanel, "exp_bar")
    self.btn_help = TFDirector:getChildByPath(self.uiPanel, "btn_help")

    local topRightPanel = TFDirector:getChildByPath(self.uiPanel, "panel_top_right")
    self.odsdiaTxt = TFDirector:getChildByPath(topRightPanel, "txt_odsdia_count")
    self.coinTxt = TFDirector:getChildByPath(topRightPanel, "txt_coin_count")
    self.diamondTxt = TFDirector:getChildByPath(topRightPanel, "txt_zuan_count")

    self.odsdiaAddBtn = TFDirector:getChildByPath(topRightPanel, "btn_add_odsdia")
    self.goldAddBtn = TFDirector:getChildByPath(topRightPanel, "btn_add_coin")
    self.diamondAddBtn = TFDirector:getChildByPath(topRightPanel, "btn_add_zuan")
    self.setBtn = TFDirector:getChildByPath(topRightPanel, "btn_setting")
    self.button_chat = TFDirector:getChildByPath(topRightPanel, "Button_chat")
    self.button_chat.redPoint = TFDirector:getChildByPath(self.button_chat , "Image_redpoint")
    self.button_chat.redPoint:hide()
    self.btn_room = TFDirector:getChildByPath(topRightPanel, "btn_room")
    -- self.roomPanelTouch = TFDirector:getChildByPath(topRightPanel, "panel_room_touch")
    -- self.roomIdTextfield = TFDirector:getChildByPath(topRightPanel, "textfield_roomId")
    self.roomIdTxt = TFDirector:getChildByPath(topRightPanel, "txt_roomId")
    self.btn_room:setTouchEnabled(true)

    --功能列表
    self.panel_funcitons = TFDirector:getChildByPath(self.uiPanel, "Panel_funcitons")
    self.funcListView    = TFDirector:getChildByPath(self.panel_funcitons, "ScrollView_list")
    self.funcListView   = UIListView:create(self.funcListView);
    self.panelTouch      = TFDirector:getChildByPath(self.panel_funcitons, "Panel_top")

    self.label_fun_title = TFDirector:getChildByPath(self.panelTouch, "Label_fun_title")
    self.image_flag = TFDirector:getChildByPath(self.panelTouch, "Image_MapLayer_1")
    self.Image_redPoint = TFDirector:getChildByPath(self.panelTouch, "Image_redPoint")

    --prefab
    local panel_prefab   = TFDirector:getChildByPath(ui, "Panel_prefab")
    self.prefabFunItem   = TFDirector:getChildByPath(panel_prefab, "Panel_item")
    self.panel_chatInfo  = TFDirector:getChildByPath(panel_prefab, "Panel_chatInfo")


    --选择房间
    self.panel_change_room = TFDirector:getChildByPath(ui, "panel_change_room")
    self.panel_change_room:setTouchEnabled(false)
    self.panel_change_room:hide()
    self.btn_change_room   = TFDirector:getChildByPath(self.panel_change_room, "Button_room")
    self.label_roomNums   = TFDirector:getChildByPath(self.btn_change_room, "label_roomNums")
    self.label_roomNums:setText("1 - "..OSDDataMgr:getMaxRoomID())
    self.btn_gonghui       = TFDirector:getChildByPath(self.panel_change_room, "Button_gonghui")
    self.tf_input          = TFDirector:getChildByPath(self.panel_change_room, "TextField_input")
    self:initInpuLayer()
    --摇杆
	self.rokerView = RokerView:new(self.rokerPanel)
    self:updateSettingData()
	self:updatePlayerInfo()
    self:updateRoomUI()
    -- self:initRingTask()

end

function BaseMapView:initInpuLayer()
    local params = {
        _type = EC_InputLayerType.SEND,
        buttonCallback = function()
            self:onTouchSendRoomBtn()
        end,
        closeCallback = function()
            self:onCloseInputLayer()
        end
    }
    self.inputLayer = require("lua.logic.common.InputLayer"):new(params)
    self:addLayer(self.inputLayer, 1000)
end


function BaseMapView:loadMap()
	self.baseMap = BaseMap:new()
    self.baseMap:initMapElement()
	self.mapPanel:addChild(self.baseMap)

    local mainHero = OSDControl:getMainHero()
    self.rokerView:setDelegate(mainHero)
    self.camera = BaseCamera:new(mainHero:getPosition())
    self.camera:setFocusNode(mainHero)
end

function BaseMapView:onXXXXXXXXXX()
    
    -- if OSDConnector:isConnected() then 

    -- end
    if not  self.xxxxxxxxxxxxxxxxx then 
        self.xxxxxxxxxxxxxxxxx = true
        OSDDataMgr:sendPreEnterNewWord()
    end
end


function BaseMapView:onShow()
    self.super.onShow(self)
    AudioExchangePlay.playBGM(self, true)
	self.ui:runAnimation("Action0", 1)
    self:onXXXXXXXXXX()
    -- self:showFailDatingLayer()
	-- self:onPhoneDating()
    -- self:phoneDatingOutTime()
    -- self:onRedPointUpdateSummon()
    -- self:checkNewRecharge()
    self:onRedPointUpdate()
    if self.chatView and not self.chatView.closeState then
    	self:onChatViewClose()
    end
end

-- function BaseMapView:onRedPointUpdateSummon()
--     local isShow = SummonDataMgr:isShowRedPointInMainView()
--     self.zhaohuanTip:setVisible(isShow)
-- end

--手机约会
-- function BaseMapView:onPhoneDating()
--     self:shakePhone()
--     local isNewPhone, ruleId, datingTimeFrame = DatingDataMgr:getPhoneDating()
--     if isNewPhone then
--         self.datingRuleId = ruleId
--         self.datingTimeFrame = datingTimeFrame
--     else
--         self.datingRuleId = nil
--         self.datingTimeFrame = nil
--         DatingDataMgr:setPhoneDating(nil, nil, nil)
--     end
-- end

--手机约会过期提示
-- function BaseMapView:phoneDatingOutTime()
--     self:shakePhone()
-- end

-- function BaseMapView:onDatingFail()
--     self:showFailDatingLayer()
-- end

-- function BaseMapView:showFailDatingLayer()
--     local cityDatingInfo = DatingDataMgr:getReserveFailScript(true)
--     if cityDatingInfo then
--         DatingDataMgr:sendGetSciptMsg(cityDatingInfo.datingType,nil,nil,nil,nil,cityDatingInfo.cityDatingId)
--     end
-- end

--手机抖动
-- function BaseMapView:shakePhone()
--     local isUsed = DatingPhoneDataMgr:isUsedPhoneAi()
--     if not isUsed then
--         self.phoneSpine:play("animation2",true)
--         self.phoneTip:setVisible(true)
--         return
--     end

--     local isNewPhone, ruleId =  DatingDataMgr:getPhoneDating()
--     if isNewPhone then
--         self.phoneSpine:play("animation2",true)
--         self.phoneTip:setVisible(true)
--         return
--     end

--     local isNewOutTime = DatingPhoneDataMgr:isNewOutTimePhoneDating()
--     if isNewOutTime then
--         self.phoneSpine:play("animation2",true)
--         self.phoneTip:setVisible(true)
--         return
--     end

--     self.phoneSpine:play("animation",true)
--     self.phoneTip:setVisible(false)
-- end

-- function BaseMapView:checkNewRecharge()
--     local flag = RechargeDataMgr:getClickMainLayerFlag()
--     if flag then
--     	self.rechargeTip:setVisible(false)
--         return
--     end

--     if FunctionDataMgr:isOpen(RechargeDataMgr:getTotalOpenId()) and RechargeDataMgr:getTotalRedDotState() then
--         self.rechargeTip:setVisible(true)
--     end

--     local exist = RechargeDataMgr:existGiftBagNewFlag()
--     if exist then
--         self.rechargeTip:setVisible(have)
--     end
-- end

function BaseMapView:updatePlayerInfo()
    local tiliTop = TabDataMgr:getData("LevelUp", MainPlayer:getPlayerLv()).maxEnergy
    self.nameTxt:setString(MainPlayer:getPlayerName())
    local heroCid = MainPlayer:getAssistId()
    self.headIcon:setTexture(AvatarDataMgr:getSelfAvatarIconPath())
    local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getSelfAvatarFrameIconPath()
    self.headFrame:setTexture(avatarFrameIcon)
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
            self.headFrame:addChild(self.HeadFrameEffect, 1)
        end
    else
        if self.HeadFrameEffect then
            self.HeadFrameEffect:removeFromParent()
            self.HeadFrameEffect = nil
        end
    end

    local playerLevel = MainPlayer:getPlayerLv()
    if playerLevel > 9 then
        self.levelTxt:setFontSize(24)
    else
        self.levelTxt:setFontSize(30)
    end
    self.levelTxt:setText(playerLevel)
    self.expBar:setPercent(MainPlayer:getExpProgress())

    local nameWidth = self.nameTxt:getSize().width
    local maxWidth = math.max(nameWidth + 130, 190)
    self.playerInfoBg:setSize(CCSizeMake(maxWidth, 62))
    self.levelPanel:PosX(maxWidth - self.levelPanel:getSize().width / 2)

    self.coinTxt:setText(GoodsDataMgr:getGold(true))
    self.diamondTxt:setText(GoodsDataMgr:getDiamond(true))
    local maxTili = TabDataMgr:getData("LevelUp", MainPlayer:getPlayerLv()).maxEnergy;
    self.odsdiaTxt:setText(GoodsDataMgr:getItemCount(EC_SItemType.POWER).."/"..maxTili)

end

function BaseMapView:onAvatarUpdata()
    local iconPath = AvatarDataMgr:getSelfAvatarIconPath()
    self.headIcon:setTexture(iconPath)
    local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getSelfAvatarFrameIconPath()
    self.headFrame:setTexture(avatarFrameIcon)
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
            self.headFrame:addChild(self.HeadFrameEffect, 1)
        end
    else
        if self.HeadFrameEffect then
            self.HeadFrameEffect:removeFromParent()
            self.HeadFrameEffect = nil
        end
    end
end

function BaseMapView:onChatViewOpen(isOpenInput)
    if self.chatView then
        return
    end

    local chatView = require("lua.logic.chat.ChatView")
    chatView.show(function ()
        self:onChatViewClose()
    end, isOpenInput, EC_ChatViewType.OSD)
    self.chatView = chatView
end

function BaseMapView:onChatViewClose()
    self.chatView.closeState = true
    self.ui:timeOut(function()
        self.chatView.closeState = nil
        self.chatView = nil
    end, 0.3)
end

function BaseMapView:onSwitchPrivate()
    local topView = AlertManager:getLayer(-1)
    if topView.__cname ~= "ChatView" then
        self:onChatViewOpen(true)
    end
end

function BaseMapView:update(dt)
	self.baseMap:update(dt)
	self.camera:update(dt)
    self.rokerView:update(dt)
    self.detailTime = self.detailTime or 0
    self.detailTime = dt + self.detailTime 
    if self.detailTime > 1 then
        self.detailTime = 0
        self:updateFuncListRedState()
    end
end

--initFuncListView
function BaseMapView:initFuncListView()
    local npcList = OSDControl:getNPCList()
    -- Box("xxx"..tostring(#npcList))
    local lastItem 
     for npc in OSDControl:getNPCList():iterator() do
        local data = npc:getData()
        local item = self:cloneFunItem()
        self.funcListView:pushBackCustomItem(item)
        item.funcType = npc:getFuncType()
        item.textTitle:setText(data.quickName)
        item.imageRedPoint:hide()
        item:setTouchEnabled(true)
        item:onClick(handler(self.onClickFunItem,self))
        lastItem = item
    end
    if lastItem then 
        lastItem.image_line:hide()
    end
end

--NPC 功能类型
local checkRedStatFunc = {  --暂时屏蔽夏拉姆部分功能红点
    [FuncType.FUN_BEN] = handler(OSDDataMgr.checkLevelEntranceRedState,OSDDataMgr), -- 副本红点检测方法
    [FuncType.Bounty] = handler(OSDDataMgr.checkHuntingInvitationRedState,OSDDataMgr), -- 悬赏令红点检测方法
    [FuncType.LuckDraw] = handler(SummonDataMgr.isCanTeamSummon,SummonDataMgr), -- 召唤红点检测方法
    --[FuncType.Seq_War] = handler(SkyLadderDataMgr.isNewTurn,SkyLadderDataMgr), -- 天梯红点检测方法
    [FuncType.Task] = handler(TaskDataMgr.isShowRedPointInOSDView,TaskDataMgr), -- 任务检测方法
}

function BaseMapView:updateFuncListRedState(  )
    -- body
    local items = self.funcListView:getItems()
    for k,v in pairs(items) do
        if checkRedStatFunc[v.funcType] then
            v.imageRedPoint:setVisible( checkRedStatFunc[v.funcType]() )
        end
    end
end
--
function BaseMapView:cloneFunItem()
    local item    = self.prefabFunItem:clone()
    item.textTitle     = item:getChildByName("Label_fun_title")
    item.imageRedPoint = item:getChildByName("Image_redPoint")
    item.image_arrow   = item:getChildByName("Image_arrow")
    item.image_line   = item:getChildByName("Image_line")
    return item
end

function BaseMapView:onClickFunItem(item)
    -- Utils:showTips(tostring(item.funcType))
    OSDControl:doFunc(item.funcType)
end

function BaseMapView:showFuncRed()
    for k,v in pairs(checkRedStatFunc) do
        if v() then
            return true
        end
    end
    return false
end

function BaseMapView:registerEvents()
	if self.rokerView then
		self.rokerView:registerEvents()
	end
    self.panelTouch.open = false --默认关闭
    self.funcListView:setVisible(self.panelTouch.open) 
    self.panelTouch:setTexture("ui/osd/main/008.png")
    self.image_flag:setVisible(self.panelTouch.open)
    self.label_fun_title:setVisible(self.panelTouch.open)
    self.Image_redPoint:setVisible(self:showFuncRed())
    self.panelTouch:onClick(function()
        if not self.panelTouch.open then
            self.panelTouch.open = true
            self.Image_redPoint:setVisible(false)
            self.panelTouch:setTexture("ui/osd/main/012.png")
        else
            self.panelTouch.open = false
            self.Image_redPoint:setVisible(self:showFuncRed())
            self.panelTouch:setTexture("ui/osd/main/008.png")
        end
        self.image_flag:setVisible(self.panelTouch.open)
        self.label_fun_title:setVisible(self.panelTouch.open)
        self.funcListView:setVisible(self.panelTouch.open)  
    end)


    --打开聊天信息
    self.button_chat:setTouchEnabled(true)
    self.button_chat:onClick(function()
            local ChatView = require("lua.logic.chat.ChatView")
            ChatView.show(nil,false,false,true)
        end)


    -- self.btn_help:hide()
    self.btn_help:onClick(function ( ... )
        local layer = require("lua.logic.common.HelpView"):new({2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016})
        AlertManager:addLayer(layer)
        AlertManager:show()
    end)
    --test
    -- self.cameraBtn:onClick(function()
    -- end)

    -- self.panelRingTask.imgBG:onClick(function()
    --     self:taskTrigger(true)
    -- end)

	--玩家信息设置
    self.infoPanel:onClick(function()
    	Utils:openView("playerInfo.PlayerSetting")
    end)

    self.odsdiaAddBtn:onClick(function()
        local itemCfg = GoodsDataMgr:getItemCfg(EC_SItemType.POWER)
        if StoreDataMgr:canContinueBuyItemRecover(itemCfg.buyItemRecover) then
            Utils:openView("common.BuyTiliLayer", itemCfg.id)
        else
            Utils:showTips(800021)
        end
    end)

    self.goldAddBtn:onClick(function()
        local itemCfg = GoodsDataMgr:getItemCfg(EC_SItemType.GOLD)
        if StoreDataMgr:canContinueBuyItemRecover(itemCfg.buyItemRecover) then
            Utils:openView("common.BuyResourceView", itemCfg.id)
        else
            Utils:showTips(800021)
        end
    end)

	self.diamondAddBtn:onClick(function()
        FunctionDataMgr:jPay()
    end)

    --设置
    self.setBtn:onClick(function()
        local layer = Utils:openView("settings.SettingsView") -- 策划需求直接定位战斗页签
        layer:showPanelBattle()
        layer:changeBtnSelStatus("battle")
    end)


    self.tf_input:addMEListener(TFTEXTFIELD_DETACH, handler(self.onTextFieldChangedHandleAcc, self))
    self.tf_input:addMEListener(TFTEXTFIELD_ATTACH, handler(self.onTextFieldAttachAcc, self))
    self.tf_input:addMEListener(TFTEXTFIELD_TEXTCHANGE, handler(self.onTextFieldChangedHandleAcc, self))
    --打开房间选择界面
    self.btn_room:onClick(function()
        self.panel_change_room:setTouchEnabled(true)
        self.panel_change_room:show()
    end)

    --打开输入框
    self.btn_change_room:onClick(function()
        -- 打开输入框
        self.tf_input:openIME()
    end)
    --切换到工会房间
    self.btn_gonghui:onClick(function()
        self.tf_input:closeIME()
        self.panel_change_room:hide()
        self.panel_change_room:setTouchEnabled(false)
        --TODO 特殊房间号
        OSDDataMgr:sendChangeRoomToUnion()
    end)

    self.panel_change_room:onClick(function()
        self.tf_input:closeIME()
        self.panel_change_room:hide()
        self.panel_change_room:setTouchEnabled(false)
    end)

    -- self.fairyBtn:onClick(function()
    -- 	Utils:openView("fairyNew.FairyMainLayer")
    -- end)

    -- 背包
    -- self.bagBtn:onClick(function()
    --     FunctionDataMgr:jBag()
    -- end)

    -- 召唤
    -- self.zhaohuanBtn:onClick(function()
    --     --检查更新
    --     MainPlayer:checkVersion()
    --     FunctionDataMgr:jSummonMain()
    -- end)

    -- self.shopBtn:onClick(function()
    --     FunctionDataMgr:jStore()
    -- end)

    -- self.phoneBtn:onClick(function()
    --     Utils:openView("datingPhone.PhoneMainView",self.datingRuleId,self.datingTimeFrame)
    -- end)

    -- -- 充值
    -- self.rechargeBtn:onClick(function ()
    -- 	FunctionDataMgr:jPayGift()
    -- end)

	self.returnBtn:onClick(function()
        local args = {
            tittle = 2107025,
            content = TextDataMgr:getText(14110234),
            reType = EC_OneLoginStatusType.ReConfirm_ExitTeamScene,
            confirmCall = function()
                OSDDataMgr:sendLeave()
                self:onLeave()
            end,
        }
        Utils:showReConfirm(args)
    end)

    --互动处理
	self.btnInteraction:onClick(function()
        OSDControl:doFocusFunc()
    end)
    --切换角色(屏蔽换装功能)
    self.btnChange:setVisible(false)
    self.btnChange:setTouchEnabled(false)
    self.btnChange:onClick(function()
        if not OSDConnector:isConnected() then
            --TODO 无法连接到服务器不能切换皮肤
            Utils:showTips(240037)
            return
        end
        local hero = OSDControl:getMainHero()
        local function changeSkin(heroId,skinId)
            local skinSid = HeroDataMgr:getSkinSid(skinId)
            OSDDataMgr:sendChangeApperance(heroId,skinSid)
        end
        local params = 
        {
            heroId   = hero:getId(),
            skinId   = hero:getSkinId(),
            callFunc = changeSkin
        }
        Utils:openView("osd.SelectHeroLayer",params)
    end)
    --规则说明
    -- self.btnRule:onClick(function()

    -- end)
    self:addMEListener(TFWIDGET_ENTERFRAME, self.update)
    self:addMEListener(TFWIDGET_EXIT, handler(self._onExit, self))

    --注册全局事件
    EventMgr:addEventListener(self, EV_UPDATE_PLAYERINFO, handler(self.updatePlayerInfo, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.updatePlayerInfo, self))
    -- EventMgr:addEventListener(self, EV_DATING_EVENT.triggerPhoneDating, handler(self.onPhoneDating, self))
    -- EventMgr:addEventListener(self, EV_DATING_EVENT.datingOverTime, handler(self.onDatingFail, self))
    -- EventMgr:addEventListener(self, EV_DATING_EVENT.outTimePhoneDating, handler(self.phoneDatingOutTime, self))
    EventMgr:addEventListener(self, EV_AVATAR_UPDATE, handler(self.onAvatarUpdata, self))
    -- EventMgr:addEventListener(self, EV_SUMMON_COMPOSE_UPDATE, handler(self.onRedPointUpdateSummon, self))
    --切换到私聊
    -- EventMgr:addEventListener(self, EV_SWITCH_PRIVATE, handler(self.onSwitchPrivate, self))
    --聊天消息
    -- EventMgr:addEventListener(self, EV_RECV_CHATINFO, handler(self.onRecvChatMsg, self)
    -- --设置改变
    EventMgr:addEventListener(self, EV_SETTING_CHANGE, handler(self.onSettingChange, self))
    EventMgr:addEventListener(self, EV_OSD.EV_REFRESH_OSDROOM, handler(self.updateRoom, self))
    EventMgr:addEventListener(self, EV_OSD.FOCUS_CHANGE , handler(self.onFocusChange, self))
    --退出同屏場景
    EventMgr:addEventListener(self, EV_OSD.EV_LEAVE, handler(self.onLeave, self))
    --聊天消息变更
    EventMgr:addEventListener(self, EV_OSD.CHATINFO_ADD, handler(self.onRecvChatMsg, self))

    EventMgr:addEventListener(self, EV_RED_POINT_UPDATE_CHAT, handler(self.onRedPointUpdate, self))


end

function BaseMapView:_onExit()

    OSDConnector:close()
    OSDControl:exitOSD()
    --清理场景上的节点
    self.mapPanel:removeAllChildren()
    me.TextureCache:removeUnusedTextures()
    TFDirector:clearMovieClipCache()
    me.FrameCache:removeUnusedSpriteFrames()
    SpineCache:getInstance():clearUnused()
end

--离开大世界
function BaseMapView:onLeave()
    OSDConnector:close()
    AlertManager:changeScene(SceneType.MainScene)
end

function BaseMapView:onFocusChange()
    self.btnInteraction:setVisible(OSDControl:getFocus()~=nil)
end

function BaseMapView:onRecvChatMsg(chatInfo)
    --显示气泡
    self.baseMap:heroTalk(chatInfo)
    -- local content     = "【附近】"..chatInfo.pname..":"..chatInfo.content
    -- local chatNode    = self.panel_chatInfo:clone()
    -- local label_content = chatNode:getChildByName("Label_content")
    -- local label = label_content:setTextById("r302001",chatInfo.pname,chatInfo.content)
    -- chatNode:setContentSize(CCSizeMake(chatNode:getContentSize().width,label:getContentSize().height + 11))
    -- self.chatListView:pushBackCustomItem(chatNode)
    
    -- if #self.chatListView:getItems() > 3 then
    --     self.chatListView:removeItem(1)
    -- end
    -- self.chatListView:scrollToBottom(0.2)
end

--聊天小红点更新
function BaseMapView:onRedPointUpdate()
    for key , chatType in pairs(EC_ChatType) do
        local readState = ChatDataMgr:getReadState(chatType)
        if chatType == EC_ChatType.GUILD and readState then
            readState = not ChatDataMgr:getUnionRedPacketReadState()
        end
        if not readState then 
            self.button_chat.redPoint:show()
            return
        end
    end
    self.button_chat.redPoint:hide()
end

-- --切换房间前准备
-- function BaseMapView:resetScene()
--     --发送离开
--     OSDDataMgr:sendLeave()
--     --断开连接
--     OSDConnector:close()
--     OSDDataMgr:clearChatInfoList()
--     --清除玩家数据
--     OSDControl:clearHeroQueue()  
--     --清除同屏玩家
--     self.baseMap:clearOtherPlayers()
--     -- self.baseMap:resetMainHeroPos()
-- end


--切换频道
function BaseMapView:updateRoom()
    self:updateRoomUI()
end

function BaseMapView:updateRoomUI()
    local roomId = OSDDataMgr:getRoomID()
    if tonumber(roomId) < 90000 then 
        self.roomIdTxt:setText(string.format("%02d", roomId))
        self.tf_input:setText(string.format("%02d", roomId))
    else
        self.roomIdTxt:setTextById(270459)
        self.tf_input:setText(string.format("%02d", math.random(OSDDataMgr:getMaxRoomID())))
    end

    self.tf_input.lastText = self.tf_input:getText()
end

function BaseMapView:onTouchSendRoomBtn()
    local content = self.tf_input:getText()
    if content and #content > 0 and tonumber(content) then
        local roomId = math.floor(tonumber(content))
        roomId = math.min(math.max(1,roomId),OSDDataMgr:getMaxRoomID())
        if roomId == tonumber(OSDDataMgr:getRoomID()) then
            --已在当前频道
            Utils:showTips(240027)
        else
            self.panel_change_room:hide()
            self.panel_change_room:setTouchEnabled(false)
            OSDDataMgr:sendChangeRoom(roomId)
        end
    else
        Utils:showTips(800104)
    end
end

function BaseMapView:onCloseInputLayer()
    self.tf_input:closeIME()
    self.tf_input:setText(self.tf_input.lastText)
end

function BaseMapView:onTextFieldChangedHandleAcc(input)
    self.inputLayer:listener(input:getText())
end

function BaseMapView:onTextFieldAttachAcc(input)
    self.inputLayer:show()
    self.inputLayer:visit()
    self.inputLayer:listener(input:getText())
end

function BaseMapView:updateSettingData()
    BattleConfig.ROKER_FIX_POSTION  = SettingDataMgr:getBattleRoke()
    OSDConfig.SHOW_OTHER_PLAYER_NUM = SettingDataMgr:getNumberOfScreensVal()
end

function BaseMapView:onSettingChange()
    local preShowPlayerNum = OSDConfig.SHOW_OTHER_PLAYER_NUM
    self:updateSettingData()
    if preShowPlayerNum ~= OSDConfig.SHOW_OTHER_PLAYER_NUM then
        --修改同屏显示玩家数量
        self.baseMap:changeShowPlayersNum()
    end
end

function BaseMapView:removeEvents()
    self:removeMEListener(TFWIDGET_ENTERFRAME)
	if self.rokerView then
		self.rokerView:removeEvents()
	end
end

function BaseMapView:removeUI()

end

return BaseMapView
