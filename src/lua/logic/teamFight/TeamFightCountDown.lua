
local TeamFightCountDown = class("TeamFightCountDown", BaseLayer)

function TeamFightCountDown:ctor(data)
    self.super.ctor(self)
    self.data = data
    self:init("lua.uiconfig.teamFight.teamCountDown")
end


function TeamFightCountDown:initUI(ui)
    self.super.initUI(self, ui)
    self.panel_root        = TFDirector:getChildByPath(ui, "Panel_root")
    self:runCountDown()
end

function TeamFightCountDown:runCountDown()
    local countdownAnim = self.panel_root:getChildByName("Spine_anim")
    countdownAnim:addMEListener(TFARMATURE_COMPLETE,function(sklete)
        self:onCountDownEnd()
    end)
    countdownAnim:play("animation",0)
end

function TeamFightCountDown:onCountDownEnd()
    local battleController = require("lua.logic.battle.BattleController")
    battleController.enterTeamBattle(self.data)
    AlertManager:closeLayer(self)
end



function TeamFightCountDown:registerEvents()

end

return TeamFightCountDown
