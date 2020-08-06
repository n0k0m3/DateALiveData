local LeagueMainScene = class("LeagueMainScene", BaseScene)

function LeagueMainScene:ctor()
    self.super.ctor(self)

    local layer = requireNew("lua.logic.league.LeagueMainLayer"):new()
    self:addLayer(layer)
end

function LeagueMainScene:onEnter()
    self.super.onEnter(self)
end

function LeagueMainScene:onExit()
    self.super.onExit(self)
end

return LeagueMainScene
