local PlayerInfoViewSimple = class("PlayerInfoViewSimple", BaseLayer)

function PlayerInfoViewSimple:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:setUsepreProcesUI()
    self:init("lua.uiconfig.chat.playerInfoViewSimple")
end

function PlayerInfoViewSimple:initData(playerInfo)
    self.playerInfo = playerInfo
end

function PlayerInfoViewSimple:initUI(ui)
    self.super.initUI(self, ui)
    -- head
    local portraitCid = self.playerInfo.portraitCid > 0 and self.playerInfo.portraitCid or self.playerInfo.helpFightHeroCid
    self._ui.Image_head:setTexture(AvatarDataMgr:getAvatarIconPath(portraitCid))
    local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getAvatarFrameIconPath(self.playerInfo.portraitFrameCid)
    self._ui.Image_head_frame_cover:setTexture(avatarFrameIcon)
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
            self._ui.Image_head_frame_cover:addChild(self.HeadFrameEffect, 1)
        end
    else
        if self.HeadFrameEffect then
            self.HeadFrameEffect:removeFromParent()
            self.HeadFrameEffect = nil
        end
    end
    -- name
    self._ui.Label_playerName:setText(self.playerInfo.name)
    -- lv
    self._ui.Label_lv:setText(self.playerInfo.lvl or 35)
    -- button
    self._ui.btnAddFriend:setVisible(not FriendDataMgr:isFriend(self.playerInfo.pid))
end

function PlayerInfoViewSimple:registerEvents()
    self._ui.Button_exit:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self._ui.btnAddFriend:onClick(function()
        local pid = self.playerInfo.pid
        AlertManager:close()
        FriendDataMgr:addFriend(pid)
    end)

    self._ui.btnCancel:onClick(function()
        AlertManager:closeLayer(self)
    end)

end

return PlayerInfoViewSimple