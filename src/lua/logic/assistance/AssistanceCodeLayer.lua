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
*  好友助力
* 
]]

local AssistanceCodeLayer = class("AssistanceCodeLayer", BaseLayer)

function AssistanceCodeLayer:ctor( data )
    self.super.ctor(self, data)
    self:initData(data)
    self:showPopAnim(true)
    self:init("lua.uiconfig.assistance.assistanceCodeLayer")
end

function AssistanceCodeLayer:initData( data )
    --AssistanceDataMgr:sendReqFriendHelpInfo()
    self.selPlayerModelPanel = nil
end

function AssistanceCodeLayer:initUI( ui )
	self.super.initUI(self, ui)
    self.rootPanel = TFDirector:getChildByPath(ui, "panel_root")
    self.uiPanel = TFDirector:getChildByPath(self.rootPanel, "panel_ui")

    self.codePanel = TFDirector:getChildByPath(self.uiPanel, "panel_code")
    self.codeLabel = TFDirector:getChildByPath(self.codePanel, "label_code")
    self.copyBtn = TFDirector:getChildByPath(self.codePanel, "btn_copy")

    self.helpBtn = TFDirector:getChildByPath(self.uiPanel, "btn_help")
    self.closeBtn = TFDirector:getChildByPath(self.uiPanel, "btn_close")

    self.friendHelpTipLabel = TFDirector:getChildByPath(self.uiPanel, "label_friendHelpTip")
    self.friendHelpTipLabel:hide()

    local playersScrollView = TFDirector:getChildByPath(self.uiPanel, "scrollView_players")
    self.playersUIListView = UIListView:create(playersScrollView)
    local playerModelPanel = TFDirector:getChildByPath(ui, "panel_playerModel")
    playerModelPanel:hide()
    self.playersUIListView:setItemModel(playerModelPanel)

    self.getAllBtn = TFDirector:getChildByPath(ui, "btn_get_all")
    self.shareBtn = TFDirector:getChildByPath(ui, "btn_share")

    self.playerScoreLabel = TFDirector:getChildByPath(self.uiPanel, "label_playerScore")
    self.playerScoreImg = TFDirector:getChildByPath(self.uiPanel, "img_scoreIcon")
    self.friendBtn = TFDirector:getChildByPath(self.uiPanel, "btn_friend")

    self.desLabel = TFDirector:getChildByPath(self.uiPanel, "label_des")
    self.desLabel:setTextById(112000124)

    self.btn_reward = TFDirector:getChildByPath(self.uiPanel , "btn_reward")

    self:updateUI()
end

function AssistanceCodeLayer:onShow( )
    self.super.onShow(self)
end

function AssistanceCodeLayer:registerEvents( )
	self.super.registerEvents(self)

    EventMgr:addEventListener(self, EV_RECV_PLAYERINFO, handler(self.onQueryFriendEvent, self))
    EventMgr:addEventListener(self, EV_RESQUICKRECEIVEFRIENDHELPTASK, handler(self.onResQuickReceiveFriendHelpTask, self))
    EventMgr:addEventListener(self, EV_RESRECEIVEFRIENDHELPTASK, handler(self.onResReceiveFriendHelpTask, self))
    EventMgr:addEventListener(self, EV_RESREFRESHFRIENDHELPTASK, handler(self.onResRefreshFriendHelpTask, self))
    EventMgr:addEventListener(self, EV_ASSISTANCE_FRIENDHELPINFOS, handler(self.updateUI, self))

    self.closeBtn:onClick(function(sender)
        AlertManager:closeLayer(self)
    end)

    self.helpBtn:onClick(function(sender)
        Utils:openView("assistance.AssistanceHelpLayer" , {uiName = "assistance.assistanceHelpLayer"})
    end)

    --一键领取
    self.getAllBtn:onClick(function(sender)
        AssistanceDataMgr:sendReqQuickReceiveFriendHelpTask()
    end)

    self.shareBtn:onClick(function(sender)
        Utils:openView("assistance.AssistanceShareLayer")
    end)

    self.copyBtn:onClick(function(sender)
        local content = self.codeLabel:getString()
        TFDeviceInfo:copyToPasteBord(content)
        Utils:showTips(600010)
    end)

    --尤茨游戏
    self.btn_reward:onClick(function ( ... )
         Utils:openView("assistance.AssistanceGameLayer")
    end)

    self.friendBtn:onClick(function(sender)
        FunctionDataMgr:jFriend(nil, true)
    end)
end

function AssistanceCodeLayer:removeEvents( )
    self.super.removeEvents(self)
end

function AssistanceCodeLayer:updateUI( )
    self:updatePlayersUIListView()

    if AssistanceDataMgr:checkPlayersTaskRedPoint() then
        self.getAllBtn:setTouchEnabled(true)
        self.getAllBtn:setGrayEnabled(false)
        self.getAllBtn:show()
    else
        self.getAllBtn:setTouchEnabled(false)
        self.getAllBtn:setGrayEnabled(true)
        self.getAllBtn:hide()
    end

    --我的邀请码
    self.codeLabel:setText(AssistanceDataMgr:getInviteCode())

    local itemId = AssistanceDataMgr:getTaskScoreItemId()
    self.playerScoreLabel:setText(GoodsDataMgr:getItemCount(itemId))
    local itemCfg = GoodsDataMgr:getItemCfg(itemId)
    self.playerScoreImg:setTexture(itemCfg.icon)
    self.playerScoreImg:onClick(function()
        Utils:showInfo(itemId)
    end)

    self.friendHelpTipLabel:hide()
    local list = AssistanceDataMgr:getFriendHelpInfo()
    if #list <= 0 then
        self.friendHelpTipLabel:show()
    end
end

function AssistanceCodeLayer:updatePlayersUIListView( ) 
    local list = AssistanceDataMgr:getFriendHelpInfo()
    local items = self.playersUIListView:getItems()
    local gap = #list - #items
    if gap > 0 then
        for i = 1, math.abs(gap) do
            self.playersUIListView:pushBackDefaultItem()
        end
    else
        for i = 1, math.abs(gap) do
            self.playersUIListView:removeItem(1)
        end
    end

    local items = self.playersUIListView:getItems()
    for i, item in ipairs(items) do
        local data = list[i]
        if data then
            item:show()
            self:updatePlayerModel(item, data)
        end
    end
end

function AssistanceCodeLayer:updatePlayerModel( playerModelPanel, friendInfo )
    local playerIconBgImg = TFDirector:getChildByPath(playerModelPanel, "img_player_icon_bg")
    
    local iconImg = TFDirector:getChildByPath(playerModelPanel, "img_icon")
    iconImg:setTouchEnabled(false)
    local portraitCid = friendInfo.portraitCid
    if portraitCid > 0 then
        local icon = AvatarDataMgr:getAvatarIconPath(portraitCid)
        iconImg:setTexture(icon)
    end 

    local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getAvatarFrameIconPath(friendInfo.portraitFrameCid)
    local coverFrameImg = TFDirector:getChildByPath(playerModelPanel, "img_icon_cover_frame")
    coverFrameImg:setTexture(avatarFrameIcon)

    local headFrameEffect = coverFrameImg:getChildByName("headFrameEffect")
    if headFrameEffect then
        headFrameEffect:removeFromParent()
    end
    if avatarFrameEffect ~= "" then
        headFrameEffect = SkeletonAnimation:create(avatarFrameEffect)
        headFrameEffect:setAnchorPoint(ccp(0,0))
        headFrameEffect:setPosition(ccp(0,0))
        headFrameEffect:play("animation", true)
        headFrameEffect:setName("headFrameEffect")
        coverFrameImg:addChild(headFrameEffect, 1)
    end

    local qualityImg = TFDirector:getChildByPath(playerModelPanel, "img_quality")
    qualityImg:hide()

    local nameLabel = TFDirector:getChildByPath(playerModelPanel, "label_name")
    nameLabel:setText(friendInfo.playerName)

    local scoreLabel = TFDirector:getChildByPath(playerModelPanel, "label_score")
    scoreLabel:setText(AssistanceDataMgr:getFriendScore(friendInfo.playerId) .."/" ..AssistanceDataMgr:getFriendMaxScore())

    local redTipImg = TFDirector:getChildByPath(playerModelPanel, "img_redTip")
    redTipImg:hide()
    if AssistanceDataMgr:checkAllTaskRedPoint(friendInfo.playerId) then
        redTipImg:show()
    end

    local selImg = TFDirector:getChildByPath(playerModelPanel, "img_sel")
    selImg:hide()

    playerModelPanel:setTouchEnabled(true)
    playerModelPanel:onClick(function(sender)
        if self.selPlayerModelPanel then
            TFDirector:getChildByPath(self.selPlayerModelPanel, "img_sel"):hide()
        end
        selImg:show()
        self.selPlayerModelPanel = playerModelPanel
        Utils:openView("assistance.AssistanceStatusLayer", {friendInfo = friendInfo})
    end)
end

function AssistanceCodeLayer:onQueryFriendEvent( friendInfo )
    local view = requireNew("lua.logic.chat.PlayerInfoView"):new(friendInfo)
    AlertManager:addLayer(view,AlertManager.BLOCK_AND_GRAY_CLOSE)
    AlertManager:show()
end

function AssistanceCodeLayer:onResQuickReceiveFriendHelpTask( )
    self:updateUI()
end

function AssistanceCodeLayer:onResReceiveFriendHelpTask( )
    self:updateUI()
end

function AssistanceCodeLayer:onResRefreshFriendHelpTask( )
    self:updateUI()
end

return AssistanceCodeLayer
