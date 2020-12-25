local LeagueApliesInfoView = class("LeagueApliesInfoView", BaseLayer)

function LeagueApliesInfoView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.league.leagueApliesInfoView")
end

function LeagueApliesInfoView:initData()
   
end

function LeagueApliesInfoView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Button_assent_all = TFDirector:getChildByPath(self.ui, "Button_assent_all")
    self.Button_decline_all = TFDirector:getChildByPath(self.ui, "Button_decline_all")
    self.Label_none = TFDirector:getChildByPath(self.ui, "Label_none")
    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")
    local ScrollView_aply = TFDirector:getChildByPath(self.ui, "ScrollView_aply")

    self.Panel_member_item = TFDirector:getChildByPath(self.ui, "Panel_member_item")

    self.ScrollView_aply = UIListView:create(ScrollView_aply)
    self.ScrollView_aply:setItemsMargin(5)

    self:refreshInfos()
end

function LeagueApliesInfoView:refreshInfos()
    self.ScrollView_aply:removeAllItems()
    self.Label_none:setVisible(true)
    local unionData = LeagueDataMgr:getMyUnionInfo()
    if unionData and unionData.applyList then
        for i,data in ipairs(unionData.applyList) do
            local item = self.Panel_member_item:clone()
            self:updateItem(item, data)
            self.ScrollView_aply:pushBackCustomItem(item)
        end
        self.Label_none:setVisible(#unionData.applyList <= 0)
    end
end

function LeagueApliesInfoView:updateItem(item, data)
    local Image_head = TFDirector:getChildByPath(item, "Image_head")
    local Image_head_frame_cover = TFDirector:getChildByPath(item, "Image_head_frame_cover")
    local Label_name = TFDirector:getChildByPath(item, "Label_name")
    local Label_power = TFDirector:getChildByPath(item, "Label_power")
    local Label_last_login = TFDirector:getChildByPath(item, "Label_last_login")
    local Label_level = TFDirector:getChildByPath(item, "Label_level")
    local Button_assent = TFDirector:getChildByPath(item, "Button_assent")
    local Button_decline = TFDirector:getChildByPath(item, "Button_decline")
    
    Image_head:setTexture(AvatarDataMgr:getAvatarIconPath(data.portraitCid))
    local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getAvatarFrameIconPath(data.portraitFrameCid)
    Image_head_frame_cover:setTexture(avatarFrameIcon)
    local headFrameEffect = Image_head_frame_cover:getChildByName("headFrameEffect")
    if headFrameEffect then
        headFrameEffect:removeFromParent()
    end
    if avatarFrameEffect ~= "" then
        headFrameEffect = SkeletonAnimation:create(avatarFrameEffect)
        headFrameEffect:setAnchorPoint(ccp(0,0))
        headFrameEffect:setPosition(ccp(0,0))
        headFrameEffect:play("animation", true)
        headFrameEffect:setName("headFrameEffect")
        Image_head_frame_cover:addChild(headFrameEffect, 1)
    end

    Label_name:setText(data.name)
    Label_power:setText(tostring(data.fightPower))
    Label_level:setText("Lv."..tostring(data.lvl))

    if data.online  then
        Label_last_login:setTextById(270446)
    else
        local nowDate = Utils:getUTCDate(ServerDataMgr:getServerTime())
        local lastLoginDate = Utils:getUTCDate(math.floor(data.lastLoginTime / 1000))
        local diffDate = TFDate.diff(nowDate, lastLoginDate)
        local day = diffDate:spandays()
        local hour = diffDate:spanhours()
        local min = diffDate:spanminutes()
        if day >= 1 then
            Label_last_login:setTextById(700036, math.floor(day))
        elseif hour >= 1 then
            Label_last_login:setTextById(700035, math.floor(hour))
        else
            Label_last_login:setTextById(700010, math.max(1, math.floor(min)))
        end
    end
    

    Button_assent:onClick(function()
        LeagueDataMgr:operateUnionMember(EC_UNIONType.ASSENT, {data.playerId})
    end)

    Button_decline:onClick(function()
        LeagueDataMgr:operateUnionMember(EC_UNIONType.DECLINE, {data.playerId})
    end)

    Image_head:setTouchEnabled(true)
    Image_head:onClick(function()
        if data.playerId ~= MainPlayer:getPlayerId() then
            MainPlayer:sendPlayerId(data.playerId)
        end
    end)
end

function LeagueApliesInfoView:registerEvents()
    EventMgr:addEventListener(self, EV_UNION_OPERAT_APLIES, handler(self.refreshInfos, self))
    EventMgr:addEventListener(self, EV_UNION_APPLY_UPDATE, handler(self.refreshInfos, self))

    self.Button_assent_all:onClick(function()
        local unionData = LeagueDataMgr:getMyUnionInfo()
        if unionData and unionData.applyList then
            local ids = {}
            for i, v in ipairs(unionData.applyList) do
                ids[#ids + 1] = v.playerId
            end
            LeagueDataMgr:operateUnionMember(EC_UNIONType.ASSENT, ids)
        end
    end)

    self.Button_decline_all:onClick(function()
        local unionData = LeagueDataMgr:getMyUnionInfo()
        if unionData and unionData.applyList then
            local ids = {}
            for i, v in ipairs(unionData.applyList) do
                ids[#ids + 1] = v.playerId
            end
            LeagueDataMgr:operateUnionMember(EC_UNIONType.DECLINE, ids)
        end
    end)

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return LeagueApliesInfoView