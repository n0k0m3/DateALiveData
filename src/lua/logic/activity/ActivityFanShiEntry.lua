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
    	local funcIsOpen = FunctionDataMgr:checkFuncOpen(113)
        if funcIsOpen then
        	local chapterCfg = FubenDataMgr:getChapterCfg(EC_ActivityFubenType.SIMULATION_TRIAL_4)
        	local playerLevel = MainPlayer:getPlayerLv()
    		local unlock = chapterCfg.unlockLevel <= playerLevel
            if unlock and FubenDataMgr:getSimulationTrialIsOpen(EC_ActivityFubenType.SIMULATION_TRIAL_4) then
                FunctionDataMgr:jSimulationTrial(EC_ActivityFubenType.SIMULATION_TRIAL_4)
            else
                Utils:showTips(800003, chapterCfg.unlockLevel)
            end
        end
    end)
end

return ActivityFanShiEntry