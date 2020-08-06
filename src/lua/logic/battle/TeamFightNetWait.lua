local enum   = import(".enum")
local eEvent = enum.eEvent
local TeamFightNetWait = class("TeamFightNetWait", BaseLayer)

function TeamFightNetWait:ctor()
    self.super.ctor(self)
    self:init("lua.uiconfig.teamFight.teamCountDown")
end


function TeamFightNetWait:initUI(ui)
    self.super.initUI(self, ui)
    self.panel_root        = TFDirector:getChildByPath(ui, "Panel_root")
    self:runCountDown()
end

function TeamFightNetWait:runCountDown()
    local countdownAnim = self.panel_root:getChildByName("Spine_anim")
    countdownAnim:addMEListener(TFARMATURE_COMPLETE,function(sklete)
        self:onEventClose()
    end)
    countdownAnim:play("animation",0)
end



function TeamFightNetWait:onEventClose()
    AlertManager:closeLayer(self)
end

function TeamFightNetWait:registerEvents()

end


function TeamFightNetWait.show()
    if not TeamFightNetWait.instance then
        local layer = TeamFightNetWait:new(data)
        AlertManager:addLayer(layer,AlertManager.BLOCK)
        AlertManager:show()
        TeamFightNetWait.instance = layer
    end
end

function TeamFightNetWait.hide()
    if TeamFightNetWait.instance then
        AlertManager:closeLayer(TeamFightNetWait.instance)
        TeamFightNetWait.instance = nil
    end
end

return TeamFightNetWait
