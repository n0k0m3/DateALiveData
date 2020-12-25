--[[
    @desc: 全服应援活动界面
]]


local AllServerAssistanceActivity = class("AllServerAssistanceActivity",BaseLayer)

function AllServerAssistanceActivity:initData()
    self.activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.ALLSERVER_ASSISTANCE)[1]
    self.activityInfo =  ActivityDataMgr2:getActivityInfo(self.activityId)
end

function AllServerAssistanceActivity:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.allServerAssistanceActivity")
    
end

function AllServerAssistanceActivity:initUI(ui)
    self.super.initUI(self,ui)
    self._ui.label_timeTxt:setSkewX(10)
    self._ui.label_timeBegin:setSkewX(10)
    self._ui.label_timeEnd:setSkewX(10)
    self._ui.label_timeBegin:setTextById(1410001, Utils:getDate(self.activityInfo.startTime))
    self._ui.label_timeEnd:setTextById(1410001, Utils:getDate(self.activityInfo.endTime))
    self:updateScore()
end

function AllServerAssistanceActivity:registerEvents()
    self._ui.Button_go:onClick(function()
        Utils:openView("activity.AllServerAssistanceMainView", self.activityInfo)
    end)
    self._ui.btn_ques:onClick(function()
        Utils:openView("common.TxtRuleContentShowView", {63802})
    end)

    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.updateScore, self))
end

function AllServerAssistanceActivity:updateScore()
    local myScoreNum = GoodsDataMgr:getItemCount(self.activityInfo.extendData.itemId)
    self._ui.lab_myScore:setText(myScoreNum)
end

return AllServerAssistanceActivity