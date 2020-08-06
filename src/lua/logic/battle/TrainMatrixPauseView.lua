local TrainMatrixPauseView = class("TrainMatrixPauseView", BaseLayer)
local enum          = import(".enum")
local statistics    = import(".Statistics")
local BattleUtils   = import(".BattleUtils")
local victoryDecide = import(".VictoryDecide")
local eEvent        = enum.eEvent

function TrainMatrixPauseView:initData()
    self.levelCid_ = BattleDataMgr:getPointId()
    self.levelCfg_ = BattleDataMgr:getLevelCfg()
end

function TrainMatrixPauseView:ctor(...)
    self.super.ctor(self, ...)
    self:initData(...)
    self:init("lua.uiconfig.battle.trainMatrixPauseView")
end

function TrainMatrixPauseView:initUI(ui)
    self.super.initUI(self, ui)

    self.Button_task   = TFDirector:getChildByPath(ui, "Button_task"):hide()
    self.Button_set   = TFDirector:getChildByPath(ui, "Button_set")
    self.Panel_pause   = TFDirector:getChildByPath(ui, "Panel_pause")
    self.Button_resume = TFDirector:getChildByPath(self.Panel_pause, "Button_resume")
    self.Button_exit   = TFDirector:getChildByPath(self.Panel_pause, "Button_exit")
    --
    self.Label_dian1   = TFDirector:getChildByPath(self.Panel_pause, "Label_dian1")
    self.Label_dian2   = TFDirector:getChildByPath(self.Panel_pause, "Label_dian2")

    self.Label_title   = TFDirector:getChildByPath(self.Panel_pause, "Label_title")

    self.Label_dian1:setText(TextDataMgr:getText(300835))
    self.Label_dian2:setText(TextDataMgr:getText(300836))
    self.Image_challenge = TFDirector:getChildByPath(self.Panel_pause, "Image_challenge")

    --关卡胜利条件
    --local victoryDecide = battleController.getVictoryDecide()
    local panelVictory  = self.Panel_pause:getChildByName("Panel_victory")
    local victoryCfgs  = victoryDecide.getData()
    panelVictory:setVisible(#victoryCfgs > 0)
    local nodeTips = {}
    nodeTips[1]   = panelVictory:getChildByName("Label_tip1")
    nodeTips[2]   = panelVictory:getChildByName("Label_tip2")
    for index, victoryCfg in ipairs(victoryCfgs) do
        dump(self.levelCid_)
        local text =  FubenDataMgr:getPassCondDesc(self.levelCid_, index)
        nodeTips[index]:setText(text)
        nodeTips[index]:show()
    end
end

function TrainMatrixPauseView:registerEvents()
    self.Button_task:onClick(function()
        Utils:openView("league.LeagueTrainingTaskView", false)
    end)
    self.Button_resume:addMEListener(TFWIDGET_CLICK, function()
        EventMgr:dispatchEvent(eEvent.EVENT_RESUME)
        AlertManager:closeLayer(self)
    end)
    self.Button_exit:addMEListener(TFWIDGET_CLICK, function()
        EventMgr:dispatchEvent(eEvent.EVENT_LEAVE)
        AlertManager:closeLayer(self)
    end)
    self.Button_set:addMEListener(TFWIDGET_CLICK, function()
        --EventMgr:dispatchEvent(eEvent.EVENT_LEAVE)
        --AlertManager:closeLayer(self)
        BattleUtils:openView("settings.SettingsView")
    end)

end

return TrainMatrixPauseView