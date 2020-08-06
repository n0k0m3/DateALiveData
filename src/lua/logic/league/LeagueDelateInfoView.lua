local LeagueDelateInfoView = class("LeagueDelateInfoView", BaseLayer)

function LeagueDelateInfoView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.league.leagueDelateInfoView")
end

function LeagueDelateInfoView:initData()
   
end

function LeagueDelateInfoView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Button_join = TFDirector:getChildByPath(self.ui, "Button_join")
    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")
    self.Label_top_tips = TFDirector:getChildByPath(self.ui, "Label_top_tips")
    self.Label_bottum_tips = TFDirector:getChildByPath(self.ui, "Label_bottum_tips")
    local ScrollView_members = TFDirector:getChildByPath(self.ui, "ScrollView_members")

    self.Panel_member_item = TFDirector:getChildByPath(self.ui, "Panel_member_item")

    self.ScrollView_members = UIListView:create(ScrollView_members)
    self.ScrollView_members:setItemsMargin(5)

    self.Label_join = TFDirector:getChildByPath(self.Button_join, "Label_join")
    self.Label_join:setTextById(270367)
    self.Label_top_tips:setTextById(276009)
    self.Label_bottum_tips:setTextById(276010)
end

function LeagueDelateInfoView:onShow()
    self.super.onShow(self)
    LeagueDataMgr:ReqImpeachList()
end

function LeagueDelateInfoView:refreshInfos(data)
    self.ScrollView_members:removeAllItems()
    local members = data.members
    local joinFlag = false
    if members then
        table.sort(members, function(a, b)
            return a.allContribution > b.allContribution
        end)
        for i,data in ipairs(members) do
            if data.playerId == MainPlayer:getPlayerId() then
                joinFlag = true
            end
            local item = self.Panel_member_item:clone()
            self:updateItem(item, data)
            self.ScrollView_members:pushBackCustomItem(item)
        end
    end

    if not joinFlag then
        self.Button_join:setGrayEnabled(false)
        self.Button_join:setTouchEnabled(true)
    else
        self.Button_join:setGrayEnabled(true)
        self.Button_join:setTouchEnabled(false)
    end
end

function LeagueDelateInfoView:updateItem(item, data)
    local Image_head = TFDirector:getChildByPath(item, "Image_head")
    local Image_head_frame_cover = TFDirector:getChildByPath(item, "Image_head_frame_cover")
    local Label_name = TFDirector:getChildByPath(item, "Label_name")
    local Label_power = TFDirector:getChildByPath(item, "Label_power")
    local Label_last_login = TFDirector:getChildByPath(item, "Label_last_login")
    local Label_level = TFDirector:getChildByPath(item, "Label_level")
    local Label_active_value = TFDirector:getChildByPath(item, "Label_active_value")
    
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

    if data.online then
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
    Label_active_value:setText(tostring(data.allContribution))
end

function LeagueDelateInfoView:registerEvents()
    EventMgr:addEventListener(self, EV_UNION_IMPATCH_LIST, handler(self.refreshInfos, self))

    self.Button_join:onClick(function()
        LeagueDataMgr:operateUnionMember(EC_UNIONType.IMPEACH_LEADER)
    end)

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return LeagueDelateInfoView