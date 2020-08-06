local LeagueTrainingBriefView = class("LeagueTrainingBriefView", BaseLayer)

function LeagueTrainingBriefView:ctor(themeId)
    self.super.ctor(self)
    self:initData(themeId)
    self:showPopAnim(true)
    self:init("lua.uiconfig.league.leagueTrainingBriefView")
end

function LeagueTrainingBriefView:registerEvents()
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

function LeagueTrainingBriefView:initData(themeId)
    self.themeId = themeId
end

function LeagueTrainingBriefView:initUI(ui)
    self.super.initUI(self, ui)

    self.Button_close = TFDirector:getChildByPath(ui, "Button_close")

    self.Label_title1 = TFDirector:getChildByPath(ui, "Label_title1")
    self.Label_title2 = TFDirector:getChildByPath(ui, "Label_title2")
    self.Label_content1 = TFDirector:getChildByPath(ui, "Label_content1")
    self.Label_content2 = TFDirector:getChildByPath(ui, "Label_content2")

    if self.themeId then
        local themeCfg = LeagueDataMgr:getTrainMatrixThemeCfg(self.themeId)
        self.Label_content1:setTextById(themeCfg.trainingtitle2)
        self.Label_content2:setTextById(themeCfg.trainingdes2)
    end
end

return LeagueTrainingBriefView