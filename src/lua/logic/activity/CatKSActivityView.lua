
local CatKSActivityView = class("CatKSActivityView", BaseLayer)

function CatKSActivityView:initData(activityId)
    self.activityId_ = activityId
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
end

function CatKSActivityView:ctor(...)
    self.super.ctor(self)
    self:initData(...)    
    self:init("lua.uiconfig.activity.catKSActivityView")
end

function CatKSActivityView:initUI(ui)
    self.super.initUI(self, ui)

    self.rootPanel = TFDirector:getChildByPath(ui, "panel_root")
    self.timeLabel = TFDirector:getChildByPath(self.rootPanel, "label_time")
    self.goBtn = TFDirector:getChildByPath(self.rootPanel, "btn_goto")
end

function CatKSActivityView:onShow( )
    self.super.onShow(self)
end

function CatKSActivityView:updateActivity()
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    self.timeLabel:setText(Utils:getActivityDateString(self.activityInfo_.startTime, self.activityInfo_.endTime, self.activityInfo_.extendData.dateStyle))
end

function CatKSActivityView:registerEvents()
    

    self.goBtn:onClick(function()
        local isEnd = ActivityDataMgr2:isEnd(self.activityId_)
        if isEnd then
            return
        end
        --跳转猫娘卡池
        FunctionDataMgr:jSummon(1)
    end)
end


return CatKSActivityView
