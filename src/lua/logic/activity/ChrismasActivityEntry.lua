local ChrismasActivityEntry = class("chrismasActivityEntry", BaseLayer)

function ChrismasActivityEntry:ctor(...)
	self.super.ctor(self, ...)
	self.activityID = ...
	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityID)

	self:init("lua.uiconfig.activity.chrismasActivityEntry")
end

function ChrismasActivityEntry:initUI(ui)
	self.super.initUI(self,ui)
	self.panel_root = ui:getChildByName("Panel_root") 
	self.btn_entry = ui:getChildByName("btn_entry") 

	self.activityTime = ui:getChildByName("activityTime") 

	self.activityTime:setText(Utils:getActivityDateString(self.activityInfo.startTime, self.activityInfo.endTime, self.activityInfo.extendData.dateStyle))


	self.btn_entry:onClick(function()
		Utils:openView("simulationTrial.SimulationTrialMainView",EC_ActivityFubenType.SIMULATION_TRIAL)
	end)
end



return ChrismasActivityEntry