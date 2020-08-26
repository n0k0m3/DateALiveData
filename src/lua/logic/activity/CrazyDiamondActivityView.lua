
local CrazyDiamondActivityView = class("CrazyDiamondActivityView", BaseLayer)

function CrazyDiamondActivityView:initData(activityId)
    self.activityId_ = activityId
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    self.openCrazyDiamondMainLayer = false
end

function CrazyDiamondActivityView:ctor(...)
    self.super.ctor(self)
    self:initData(...)    
    self:init("lua.uiconfig.activity.crazyDiamondActivityView")
end

function CrazyDiamondActivityView:initUI(ui)
    self.super.initUI(self, ui)

    self.rootPanel = TFDirector:getChildByPath(ui, "panel_root")
    self.timeLabel = TFDirector:getChildByPath(self.rootPanel, "label_time")
    self.tipLabel = TFDirector:getChildByPath(self.rootPanel, "label_tip")
    self.goBtn = TFDirector:getChildByPath(self.rootPanel, "btn_goto")
    self.tipLabel:enableOutline(ccc3(255 , 255 , 255))

    local bgPanel = TFPanel:create()
    bgPanel:setSize(CCSize(374 , 201))
    bgPanel:setBackGroundColorType(TF_LAYOUT_COLOR_SOLID)
    bgPanel:setBackGroundColor(ccc3(0 , 0 ,0))
    bgPanel:setBackGroundColorOpacity(80)
    bgPanel:setPosition(-188 , -99)
    self.rootPanel:getChildByName("img_content"):addChild(bgPanel)
end

function CrazyDiamondActivityView:onShow( )
    self.super.onShow(self)
    self.openCrazyDiamondMainLayer = false
end

function CrazyDiamondActivityView:updateActivity()
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    self.timeLabel:setText(Utils:getActivityDateString(self.activityInfo_.startTime, self.activityInfo_.endTime, self.activityInfo_.extendData.dateStyle))
    self.tipLabel:setTextById(100000341)
end

function CrazyDiamondActivityView:registerEvents()
    EventMgr:addEventListener(self,EV_ACTIVITY_RESP_CRAZY_DIAMOND_DRAW, handler(self.onRespCrazyDiamondDrawRsp,self))

    self.goBtn:onClick(function()
        local isEnd = ActivityDataMgr2:isEnd(self.activityId_)
        if isEnd then
            return
        end
        CrazyDiamondDataMgr:sendReqCrazyDiamondDraw(self.activityId_, false)
    end)
end

function CrazyDiamondActivityView:onRespCrazyDiamondDrawRsp( data )
    local topLayer = AlertManager:getTopLayer()
    if topLayer and topLayer.__cname ~= "ActivityMainView" then
        return
    end

    if not data.isDraw then
        if not self.openCrazyDiamondMainLayer then
            Utils:openView("activity.CrazyDiamondMainLayer",self.activityId_)
        end
        self.openCrazyDiamondMainLayer = true
    end
end

return CrazyDiamondActivityView
