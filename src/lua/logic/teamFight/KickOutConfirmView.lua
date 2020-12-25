local KickOutConfirmView = class("KickOutConfirmView",BaseLayer)

function KickOutConfirmView:ctor(member)
    self.super.ctor(self)
    self:showPopAnim(true)
    self.member = member
    self:init("lua.uiconfig.teamFight.kickOutConfirmView")
end

function KickOutConfirmView:initUI(ui)
    self.super.initUI(self, ui)
    self.panel_root        = TFDirector:getChildByPath(ui, "Panel_root")
    self.Button_close = TFDirector:getChildByPath(self.panel_root, "Button_close")
    self.Button_ok = TFDirector:getChildByPath(self.panel_root, "Button_ok")
    self.Label_kickOut = TFDirector:getChildByPath(self.panel_root, "Label_kickOut")
    self.Label_kickOut:setTextById(240042,self.member.name)
end

function KickOutConfirmView:AfterkickOut()
    AlertManager:closeLayer(self)
end

function KickOutConfirmView:registerEvents()

    EventMgr:addEventListener(self,EV_TEAM_FIGHT_TEAM_DATA,handler(self.AfterkickOut, self));
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
    self.Button_ok:onClick(function()
        TeamFightDataMgr:requestKickOutTeam(self.member.pid)
        AlertManager:closeLayer(self)
    end)
end

return KickOutConfirmView