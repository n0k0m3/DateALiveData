local ActivityKuangSanEntry = class("ActivityKuangSanEntry", BaseLayer)

function ActivityKuangSanEntry:ctor(...)
    self.super.ctor(self, ...)
    print("ActivityKuangSanEntry")
    self:initData(...)
    self:init("lua.uiconfig.activity.kuangsanActivityEntry")

    
end

function ActivityKuangSanEntry:initData(...)

end

function ActivityKuangSanEntry:initUI(ui)
    self.super.initUI(self, ui)

    local panel_root = ui:getChildByName("Panel_root")
    local ship_btn = panel_root:getChildByName("btn_entry")
    ship_btn:onClick(function(sender)
        Utils:openView("simulationTrial.SimulationTrialMainView",EC_ActivityFubenType.SIMULATION_TRIAL_5)
    end)
end

return ActivityKuangSanEntry