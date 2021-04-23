--[[
    @desc：FanShiActivityDescView
    @date: 2020-12-28 11:14:27
]]

local FanShiActivityDescView = class("FanShiActivityDescView",BaseLayer)

function FanShiActivityDescView:initData(activityId)
    self.activityId_ = activityId
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(activityId)
    dump(self.activityInfo_)
end

function FanShiActivityDescView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.fanShiActivityDescView")
end

function FanShiActivityDescView:initUI(ui)
    self.super.initUI(self,ui)

    local year, month, day = Utils:getDate(self.activityInfo_.showStartTime or 0)
	self._ui.act_timeStart:setTextById(1410001,year, month, day)
	year, month, day = Utils:getDate(self.activityInfo_.endTime or 0)
    self._ui.act_timeEnd:setTextById(1410001,year, month, day)

    self._ui.lab_desc:setTextById(self.activityInfo_.activityTitle)
    self._ui.lab_desc:setLineHeight(35)
end

function FanShiActivityDescView:registerEvents()

end

return FanShiActivityDescView