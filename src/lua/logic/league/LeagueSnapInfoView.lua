local LeagueSnapInfoView = class("LeagueSnapInfoView", BaseLayer)

function LeagueSnapInfoView:ctor(unionSnapInfo)
    self.super.ctor(self)
    self:initData(unionSnapInfo)
    self:showPopAnim(true)
    self:init("lua.uiconfig.league.leagueSnapInfoView")
end

function LeagueSnapInfoView:initData(unionSnapInfo)
   self.snapInfo_ = unionSnapInfo
end

function LeagueSnapInfoView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Button_apply = TFDirector:getChildByPath(self.ui, "Button_apply")
    self.Label_league_name = TFDirector:getChildByPath(self.ui, "Label_league_name")
    self.Label_leader_name = TFDirector:getChildByPath(self.ui, "Label_leader_name")
    self.Label_league_level = TFDirector:getChildByPath(self.ui, "Label_league_level")
    self.Label_member_num = TFDirector:getChildByPath(self.ui, "Label_member_num")
    self.Label_notice = TFDirector:getChildByPath(self.ui, "Label_notice")
    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")

    self:initContent()
end

function LeagueSnapInfoView:initContent()
    self.Button_apply:setVisible(not LeagueDataMgr:checkSelfInUnion())
    self.Button_apply:setTouchEnabled(self.snapInfo_.memberCount < self.snapInfo_.memberCountMax)
    self.Button_apply:setGrayEnabled(self.snapInfo_.memberCount >= self.snapInfo_.memberCountMax)

    local countryStr = ""
    if self.snapInfo_.showCountry and tonumber(self.snapInfo_.country)>0 then
        countryStr = " ("..LeagueDataMgr:getClubCountryDataById(self.snapInfo_.country).Countryabbreviations..")"
    end
    self.Label_league_name:setText(self.snapInfo_.name..countryStr)
    self.Label_leader_name:setText(self.snapInfo_.leaderName)
    self.Label_league_level:setText(self.snapInfo_.level)
    self.Label_member_num:setText(self.snapInfo_.memberCount.."/"..self.snapInfo_.memberCountMax)
    if  self.snapInfo_.notice and string.len(self.snapInfo_.notice) > 1 then
        self.Label_notice:setText(self.snapInfo_.notice)
    else
        self.Label_notice:setTextById(270356)
    end
end

function LeagueSnapInfoView:joinUnionSuccess()
    AlertManager:closeAll()
    Utils:openView("league.LeagueMainLayer")
end

function LeagueSnapInfoView:registerEvents()
    EventMgr:addEventListener(self, EV_UNION_BASE_INFO_UPDATE, handler(self.joinUnionSuccess, self))
    self.Button_apply:onClick(function()
        if MainPlayer:getPlayerLv() < self.snapInfo_.limitLevel then
            Utils:showTips(270487)
            return
        end

        LeagueDataMgr:operateUnionMember(EC_UNIONType.APLY, {self.snapInfo_.id})
    end)

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return LeagueSnapInfoView