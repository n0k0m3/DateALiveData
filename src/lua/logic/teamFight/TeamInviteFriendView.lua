local TeamInviteFriendView = class("TeamInviteFriendView",BaseLayer)

function TeamInviteFriendView:initData(data)
	self.fiendList = data
end

function TeamInviteFriendView:ctor(...)
	self.super.ctor(self)
	self:initData(...)
	self:showPopAnim(true)
	self:init("lua.uiconfig.teamFight.teamInviteFriendView")
end

function TeamInviteFriendView:initUI(ui)
    self.super.initUI(self, ui)
    local root_panel = TFDirector:getChildByPath(ui,"Panel_root")
	root_panel:onClick(function()
		AlertManager:closeLayer(self)
	end)
	local friendScroll = TFDirector:getChildByPath(root_panel,"ScrollView_friend")
	local close_btn = TFDirector:getChildByPath(root_panel,"Button_close")
	close_btn:onClick(function( ... )
		AlertManager:closeLayer(self)
	end)
	self.friendListView = UIListView:create(friendScroll)
	local friendItem_model = friendScroll:getChildByName("Panel_friendItem")
	friendItem_model:setVisible(false)
	self.friendListView:setItemModel(friendItem_model)
	for i = 1,#self.fiendList do
		local friendInfo = self.fiendList[i]
		local item = self.friendListView:pushBackDefaultItem()
		item:setVisible(true)

		item.Image_diban = TFDirector:getChildByPath(item, "Image_diban")
		item.Image_icon = TFDirector:getChildByPath(item.Image_diban, "Image_icon")
		item.Image_icon_cover_frame = TFDirector:getChildByPath(item.Image_diban, "Image_icon_cover_frame")
		item.Label_name = TFDirector:getChildByPath(item.Image_diban, "Label_name")
		item.Label_power = TFDirector:getChildByPath(item.Image_diban, "Label_power")
		item.Label_level = TFDirector:getChildByPath(item.Image_diban, "Label_level")
		item.Invite_btn = TFDirector:getChildByPath(item.Image_diban, "Button_invite")

		local heroCfg = TabDataMgr:getData("Hero", friendInfo.leaderCid)
		local portraitCid = friendInfo.portraitCid > 0 and friendInfo.portraitCid or friendInfo.leaderCid
    	local icon = AvatarDataMgr:getAvatarIconPath(portraitCid)
		item.Image_icon:setTexture(icon)
		local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getAvatarFrameIconPath(friendInfo.portraitFrameCid)
		item.Image_icon_cover_frame:setTexture(avatarFrameIcon)
		local headFrameEffect = item.Image_icon_cover_frame:getChildByName("headFrameEffect")
		if headFrameEffect then
			headFrameEffect:removeFromParent()
		end
		if avatarFrameEffect ~= "" then
			headFrameEffect = SkeletonAnimation:create(avatarFrameEffect)
			headFrameEffect:setAnchorPoint(ccp(0,0))
			headFrameEffect:setPosition(ccp(0,0))
			headFrameEffect:play("animation", true)
			headFrameEffect:setName("headFrameEffect")
			item.Image_icon_cover_frame:addChild(headFrameEffect, 1)
		end

		-- item.Label_quality:setText(EC_HeroQuality[heroCfg.rarity])
		item.Label_name:setText(friendInfo.name)
		item.Label_level:setTextById(700034, friendInfo.lvl)
		item.Label_power:setText(friendInfo.fightPower)
		item.Invite_btn:onClick(function()
			TeamFightDataMgr:inviteFriend(friendInfo.pid)
			AlertManager:closeLayer(self)
		end)
		local lastReport = TeamFightDataMgr:getLastFriendInviteTime(friendInfo.pid)
		if lastReport then
			if lastReport.lastSendTime then
				local curtime = ServerDataMgr:getServerTime()
                local difftime = curtime - lastReport.lastSendTime
                if difftime < 15 then
                    timelong = lastReport.lastSendTime + 15 - curtime
                    Utils:makeCDProgressBar(item.Invite_btn,timelong,item.Invite_btn:getTextureNormalName())
                end
			end
		end
	end
end

return TeamInviteFriendView

