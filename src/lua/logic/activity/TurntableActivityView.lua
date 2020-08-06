
local TurntableActivityView = class("TurntableActivityView", BaseLayer)

function TurntableActivityView:initData(activityId)
    self.activityId_ = activityId
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
end

function TurntableActivityView:ctor(...)
    self.super.ctor(self)
    self:initData(...)    
    self:init("lua.uiconfig.activity.turntableActivityView")
end

function TurntableActivityView:initUI(ui)
    self.super.initUI(self, ui)

    self.rootPanel = TFDirector:getChildByPath(ui, "panel_root")
    self.timeLabel = TFDirector:getChildByPath(self.rootPanel, "label_time")
    self.goBtn = TFDirector:getChildByPath(self.rootPanel, "btn_goto")
end

function TurntableActivityView:onShow( )
    self.super.onShow(self)
end

function TurntableActivityView:updateActivity()
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    self.timeLabel:setText(Utils:getActivityDateString(self.activityInfo_.startTime, self.activityInfo_.endTime, self.activityInfo_.extendData.dateStyle))
end

function TurntableActivityView:registerEvents()
    

    self.goBtn:onClick(function()
        local isEnd = ActivityDataMgr2:isEnd(self.activityId_)
        if isEnd then
            return
        end
        Utils:openView("activity.TurntableMainLayer",self.activityId_)
    end)
end

function TurntableActivityView:onRespCrazyDiamondDrawRsp( data )
   
end

return TurntableActivityView
