local NoLeagueLayer = class("NoLeagueLayer", BaseLayer)

function NoLeagueLayer:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.league.noLeagueLayer")
end

function NoLeagueLayer:initData()
   
end

function NoLeagueLayer:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Button_create_league = TFDirector:getChildByPath(self.ui, "Button_create_league")
    self.Button_join_league = TFDirector:getChildByPath(self.ui, "Button_join_league")

    self:initContent()
end

function NoLeagueLayer:initContent()
    
end

function NoLeagueLayer:registerEvents()
    self.Button_create_league:onClick(function()
        Utils:openView("league.CreateLeagueLayer")
    end)

    self.Button_join_league:onClick(function()
        Utils:openView("league.JoinLeagueLayer")
    end)
end

return NoLeagueLayer