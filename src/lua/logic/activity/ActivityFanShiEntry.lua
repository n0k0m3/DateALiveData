local ActivityFanShiEntry = class("ActivityFanShiEntry", BaseLayer)

function ActivityFanShiEntry:ctor(...)
    self.super.ctor(self, ...)
    self:initData(...)
    self:init("lua.uiconfig.activity.fanshiActivityEntry")

    
end

function ActivityFanShiEntry:initData(...)

end

function ActivityFanShiEntry:initUI(ui)
    self.super.initUI(self, ui)

    local panel_root = ui:getChildByName("Panel_root")
    local ship_btn = panel_root:getChildByName("btn_entry")
    ship_btn:onClick(function(sender)
        FunctionDataMgr:jSimulationTrial(EC_ActivityFubenType.SIMULATION_TRIAL_4)
    end)
end

return ActivityFanShiEntry