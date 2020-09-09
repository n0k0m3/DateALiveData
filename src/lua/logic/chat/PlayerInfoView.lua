
local PlayerInfoView = class("PlayerInfoView", BaseLayer)

function PlayerInfoView:initData(playerInfo,backTag)
    self.playerInfo = playerInfo
    self.backTag = backTag
    self.name = playerInfo.name
    self.id = playerInfo.pid
    self.as = playerInfo.as
    self.hId = playerInfo.helpFightHeroCid
    self.head = HeroDataMgr:getPlayerIconPathById(self.hId)
    self.quality = HeroDataMgr:getQualityStringById(self.hId) or "SSS"
    self.lv = playerInfo.lvl or 35
    self.remark = playerInfo.remark
    self.titleId = playerInfo.titleId or 0
    print("self.hId ",self.hId)
    print("self.playerInfo.helpFightHeroCid ",self.playerInfo.helpFightHeroCid)
    self.heroCfg_ = TabDataMgr:getData("Hero", self.playerInfo.helpFightHeroCid)
end

function PlayerInfoView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    --self:showPopAnim(true)
    self:init("lua.uiconfig.chat.playerInfoView")
end

function PlayerInfoView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_touch = TFDirector:getChildByPath(self.ui, "Panel_touch")
    self.Panel_touch:setSwallowTouch(true)
    local ScrollView_info = TFDirector:getChildByPath(self.ui, "ScrollView_info")
   

    self.Panel_extra_info = TFDirector:getChildByPath(self.ui, "Panel_playerInfoView_ex")
    self.ScrollView_info_list = UIListView:create(ScrollView_info)
    --self.ScrollView_info:setScrollBar(scrollBar)
    self.Panel_extra_info:removeFromParent()
    self.ScrollView_info_list:pushBackCustomItem(self.Panel_extra_info)

    self.Label_no_title = TFDirector:getChildByPath(self.ui, "Label_no_title")
    self.Image_title_effect_bg = TFDirector:getChildByPath(self.ui, "Image_title_effect_bg")

    self.Image_title_bg = TFDirector:getChildByPath(self.ui , "Image_title_bg")
    --暂时屏蔽称号
    self.Image_title_bg:hide() --调整滚动区域
    ScrollView_info:setContentSize(CCSize(548 , 300))

    self:initHeadInfo()
    self:initPlayerInfo()
    self:initDeclaration()
    self:initBtn()
    self:initCollect()
    self:refreshUI()
end
--收藏
function PlayerInfoView:initCollect()
    self.Label_collect_title = TFDirector:getChildByPath(self.ui, "Label_collect_title") --称号
    self.Image_collect_rank  = TFDirector:getChildByPath(self.ui, "Image_collect_rank") --图标
    self.Label_collect_cup   = TFDirector:getChildByPath(self.ui, "Label_collect_cup")
    self.Label_collect_rank  = TFDirector:getChildByPath(self.ui, "Label_collect_rank")
end

function PlayerInfoView:refreshCollect()
    local element  = self.playerInfo.element
    local data = CollectDataMgr:getCurCollectorTitle(math.max(element.totleTrophy,1))
    --称号
    self.Label_collect_title:setTextById(data.name)
    --图标
    self.Image_collect_rank:setTexture(data.icon)
    self.Image_collect_rank:setScale(0.3)
    self.Label_collect_cup:setText(tostring(math.max(element.totleTrophy,1)))
    if element.rank == 0 then 
        self.Label_collect_rank:setTextById(263009)
    else
        self.Label_collect_rank:setTextById(100000121,tostring(element.rank))
    end
end

function PlayerInfoView:refreshUI()
    self:refreshHeadInfo()
    self:refreshPlayerInfo()
    self:refreshDeclaration()
    self:refreshBtn()
    self:refreshCollect()
end

function PlayerInfoView:initHeadInfo()
    self.Image_head = TFDirector:getChildByPath(self.ui, "Image_head")
    self.Label_quality = TFDirector:getChildByPath(self.ui, "Label_quality")
    self.Label_lv = TFDirector:getChildByPath(self.ui, "Label_lv")
    self.Image_head_frame_cover = TFDirector:getChildByPath(self.ui, "Image_head_frame_cover")
end

function PlayerInfoView:refreshHeadInfo()
    local portraitCid = self.playerInfo.portraitCid > 0 and self.playerInfo.portraitCid or self.playerInfo.helpFightHeroCid
    self.Image_head:setTexture(AvatarDataMgr:getAvatarIconPath(portraitCid))
    local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getAvatarFrameIconPath(self.playerInfo.portraitFrameCid)
    self.Image_head_frame_cover:setTexture(avatarFrameIcon)
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
            self.Image_head_frame_cover:addChild(self.HeadFrameEffect, 1)
        end
    else
        if self.HeadFrameEffect then
            self.HeadFrameEffect:removeFromParent()
            self.HeadFrameEffect = nil
        end
    end

    -- self.Image_head:setSize(CCSizeMake(100,100));
    self.Label_quality:setText(self.quality)
    self.Label_lv:setText(self.lv)
end

function PlayerInfoView:initPlayerInfo()
    self.Label_playerName = TFDirector:getChildByPath(self.ui, "Label_playerName")
    self.Label_playerId = TFDirector:getChildByPath(self.ui, "Label_playerId")
    --self.Label_as = TFDirector:getChildByPath(self.ui, "Label_as")
    self.Label_league_name = TFDirector:getChildByPath(self.ui, "Label_league_name")
    if self.playerInfo.unionId and self.playerInfo.unionId > 0 then
        self.Label_league_name:setText(self.playerInfo.unionId)
    else
        self.Label_league_name:setTextById(100000083)
    end
    
    
    self.Label_no_title:setVisible(not (self.titleId > 0))
    self.Image_title_effect_bg:setVisible(self.titleId > 0)
    local titleCfg = TitleDataMgr:getTitleCfg(self.titleId)
    if titleCfg then
        self.Image_title_effect_bg:removeAllChildren()
        local skeletonTitleNode = SkeletonAnimation:create(titleCfg.showEffect)
        skeletonTitleNode:play("animation", true)
        skeletonTitleNode:setPosition(ccp(0,0))
        skeletonTitleNode:setAnchorPoint(ccp(0,0))
        self.Image_title_effect_bg:addChild(skeletonTitleNode,1)
    end
end

function PlayerInfoView:refreshPlayerInfo()
    self.Label_playerName:setText(self.name)
    self.Label_playerId:setText(self.id)
    --self.Label_as:setText(self.as or self.Label_as:getText())

end

function PlayerInfoView:initDeclaration()
    self.Label_dec = TFDirector:getChildByPath(self.ui, "Label_dec")
end

function PlayerInfoView:refreshDeclaration()
    if self.remark == nil or self.remark == "" then
        return
    end
    self.Label_dec:setText(self.remark)
end

function PlayerInfoView:initBtn()
    self.Button_team = TFDirector:getChildByPath(self.ui, "Button_team")
    self.Button_addFriends = TFDirector:getChildByPath(self.ui, "Button_addFriends")
    self.Button_deleteFriends = TFDirector:getChildByPath(self.ui, "Button_deleteFriends")
    self.Button_private = TFDirector:getChildByPath(self.ui, "Button_private")
    self.Button_lockMessage = TFDirector:getChildByPath(self.ui, "Button_lockMessage")
    self.Button_unlockMessage = TFDirector:getChildByPath(self.ui, "Button_unlockMessage")
    self.Button_copy = TFDirector:getChildByPath(self.ui,"Button_copy")
    self.Button_report = TFDirector:getChildByPath(self.ui, "Button_report")
    self.Button_medal = TFDirector:getChildByPath(self.ui, "Button_medal")
    self.Button_exit  = TFDirector:getChildByPath(self.ui, "Button_exit")
    self.Button_league = TFDirector:getChildByPath(self.ui, "Button_league")
end

function PlayerInfoView:refreshBtn()
    local isFriend = FriendDataMgr:isFriend(self.id)
    local isShieldingFriend = FriendDataMgr:isShieldingFriend(self.id)
    self.Button_addFriends:setVisible(not isFriend)
    self.Button_deleteFriends:setVisible(isFriend)
    self.Button_lockMessage:setVisible(not isShieldingFriend)
    self.Button_unlockMessage:setVisible(isShieldingFriend)
    self.Button_league:setVisible(self.playerInfo.unionId and self.playerInfo.unionId > 0)
end

function PlayerInfoView:onSearchUnionBack(data)
    Utils:openView("league.LeagueSnapInfoView", data.union)
end

function PlayerInfoView:registerEvents()
    EventMgr:addEventListener(self, EV_UNION_SEARCH_UNION, handler(self.onSearchUnionBack, self))

    self.Button_team:onClick(function()
        HeroDataMgr:changeDataToFriend();
        Utils:openView("fairyNew.FairyMainLayer",{friend = true,backTag = self.backTag, friendLv = self.playerInfo.lvl})
    end)

    self.Button_medal:onClick(function()
        HeroDataMgr:changeDataToFriend();
        FamilyDataMgr:setIsFriendFamily(true)
        local playerInfo = self.playerInfo 
        if self.playerInfo.pid == MainPlayer:getPlayerId() then
            playerInfo = nil
        end
        FunctionDataMgr:jPokedex(playerInfo)
    end)

    self.Button_addFriends:onClick(function()
            local pid = self.id
            AlertManager:close()
            FriendDataMgr:addFriend(pid)
    end)

    self.Button_deleteFriends:onClick(function()
            local view = Utils:openView("common.ConfirmBoxView")
            view:setCallback(function()
                    FriendDataMgr:send_FRIEND_REQ_OPERATE(EC_FriendOp.DELETE_FRIEND, {self.id})
                    AlertManager:close()
            end)
            local content = TextDataMgr:getText(700040)
            view:setContent(content)
    end)

    self.Button_private:onClick(function()
            if not FunctionDataMgr:checkFuncOpen(42) then return end
            local playerInfo = {}
            playerInfo.playerId = self.id
            playerInfo.palyerName = self.name
            AlertManager:closeLayer(self)
            ChatDataMgr:addPlayerToPlist(playerInfo)
            EventMgr:dispatchEvent(EV_SWITCH_PRIVATE)
    end)

    self.Button_lockMessage:onClick(function()
            local view = Utils:openView("common.ConfirmBoxView")
            view:setCallback(function()
                    FriendDataMgr:send_FRIEND_REQ_OPERATE(EC_FriendOp.SHIELD_PLAYER, {self.id})
                    AlertManager:close()
            end)
            local content = TextDataMgr:getText(700038)
            view:setContent(content)
    end)

    self.Button_unlockMessage:onClick(function()
            local view = Utils:openView("common.ConfirmBoxView")
            view:setCallback(function()
                    FriendDataMgr:send_FRIEND_REQ_OPERATE(EC_FriendOp.LIFTED_SHIELD, {self.id})
                    AlertManager:close()
            end)
            local content = TextDataMgr:getText(700039)
            view:setContent(content)
    end)

    self.Button_copy:onClick(function()
        local content = self.Label_playerId:getString()
        TFDeviceInfo:copyToPasteBord(content)
        Utils:showTips(600010)
    end)

    self.Button_report:onClick(function()
        print("Button_report self.id ",self.id)
        Utils:openView("playerInfo.TipOff",self.id)
        --MainPlayer:reportPlayer(self.id)
    end)

    self.Panel_touch:onClick(function()
        AlertManager:closeLayer(self)
    end)
    
    self.Button_exit:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_league:onClick(function()
        LeagueDataMgr:SearchUnion(self.playerInfo.unionId)
    end)
end

return PlayerInfoView
