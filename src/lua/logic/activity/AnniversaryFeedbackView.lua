--周年庆玩家回馈互动
local AnniversaryFeedbackView = class("AnniversaryFeedbackView", BaseLayer)

function AnniversaryFeedbackView:initData(activityId)
    self.activityId_   = activityId
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
end

function AnniversaryFeedbackView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.anniversaryFeedbackView")
end

function AnniversaryFeedbackView:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Image_ad      = TFDirector:getChildByPath(self.Panel_root, "Image_ad")
    self.Label_time    = TFDirector:getChildByPath(self.Panel_root, "Label_time")
    self.Label_desc1   = TFDirector:getChildByPath(self.Panel_root, "Label_desc1")
    self.Label_desc2   = TFDirector:getChildByPath(self.Panel_root, "Label_desc2")
    self.Label_tips    = TFDirector:getChildByPath(self.Panel_root, "Label_tips")
    self.Button_help   = TFDirector:getChildByPath(self.Panel_root, "Button_help")
    self.Button_submit = TFDirector:getChildByPath(self.Panel_root, "Button_submit")
    self.Label_tips:setTextById(14220012)    
    self.Label_title   = TFDirector:getChildByPath(self.Panel_root, "Label_title")
    self.Label_title:setTextById(14220060)    
    self.Label_timing = TFDirector:getChildByPath(self.Panel_root, "Label_timing")

end


-- "activityTitle" = "11"
-- [LUA-print] [09/13/19 11:14:45]  -     "activityType"  = 26
-- [LUA-print] [09/13/19 11:14:45]  -     "ct"            = 0
-- [LUA-print] [09/13/19 11:14:45]  -     "endTime"       = 1571414399
-- [LUA-print] [09/13/19 11:14:45]  -     "extendData" = {
-- [LUA-print] [09/13/19 11:14:45]  -         "createTime" = 1568198581487
-- [LUA-print] [09/13/19 11:14:45]  -         "onlineTime" = 22
-- [LUA-print] [09/13/19 11:14:45]  -         "reward"     = 22
-- [LUA-print] [09/13/19 11:14:45]  -     }
-- [LUA-print] [09/13/19 11:14:45]  -     "id"            = 10089
-- [LUA-print] [09/13/19 11:14:45]  -     "items" = {
-- [LUA-print] [09/13/19 11:14:45]  -     }
-- [LUA-print] [09/13/19 11:14:45]  -     "rank"          = 3
-- [LUA-print] [09/13/19 11:14:45]  -     "showEndTime"   = 1571414399
-- [LUA-print] [09/13/19 11:14:45]  -     "showIcon"      = "ui/activity/picture/ad102.png"
-- [LUA-print] [09/13/19 11:14:45]  -     "showStartTime" = 1564675201
-- [LUA-print] [09/13/19 11:14:45]  -     "startTime"     = 1564675201
-- [LUA-print] [09/13/19 11:14:45]  -     "titleIcon"     = "ui/activity/picture/icon104.png"
-- [LUA-print] [09/13/19 11:14:45]  - }

function AnniversaryFeedbackView:updateActivity()
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    local extendData = self.activityInfo_.extendData
    --创建时间
    local createTime = extendData.createTime or ServerDataMgr:getServerTime()
    createTime = createTime*0.001
    local year, month, day = Utils:getDate(createTime, true)
    local hour, min        = Utils:getTime(createTime, true)
    self.Label_time:setTextById(500029,year, month, day, hour, min)
    self.Label_desc1:setTextById("r307001", extendData.onlineTime or 0)
    self.Label_desc2:setTextById("r307002", extendData.reward or 0)
    dump(self.activityInfo_)
    self.Button_submit:hide()
    if self.activityInfo_.items then 
        for k, v in pairs(self.activityInfo_.items) do
            if self:getItemStatus(v) == EC_TaskStatus.GET then
                self.Button_submit:show()
                self.Button_submit:setGrayEnabled(false)
                self.Button_submit:setTouchEnabled(true)
            else
                self.Button_submit:show()
                self.Button_submit:setGrayEnabled(true)
                self.Button_submit:setTouchEnabled(false)
            end
        end
    end

    self:onUpdateCountDown()
end

function AnniversaryFeedbackView:getItemStatus(itemId)
    local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType,itemId)
    return progressInfo.status or EC_TaskStatus.ING
end

function AnniversaryFeedbackView:registerEvents()
    self.Button_submit:onClick(function()
        if self.activityInfo_.items then 
            for k, v in pairs(self.activityInfo_.items) do
                if self:getItemStatus(v) == EC_TaskStatus.GET then
                    ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId_ , v)
                    dump({"发送领奖请求",v})
                end
            end
        end
    end)
    self.Button_help:onClick(function() 
        -- Utils:showTips("查看帮助")
        local layer = require("lua.logic.common.HelpView"):new({2425})
        AlertManager:addLayer(layer)
        AlertManager:show()
    end)
end

function AnniversaryFeedbackView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId_ ~= activitId then return end
    Utils:showReward(reward)
end

function AnniversaryFeedbackView:onUpdateProgressEvent()
    self:updateActivity()
end

function AnniversaryFeedbackView:onUpdateCountDownEvent()
    self:onUpdateCountDown()
end
function AnniversaryFeedbackView:onUpdateCountDown()
    local isEnd = ActivityDataMgr2:isEnd(self.activityId_)
    local serverTime = ServerDataMgr:getServerTime()
    if isEnd then
        local remainTime = math.max(0, self.activityInfo_.showEndTime - serverTime)
        local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
        if day == "00" then
            self.Label_timing:setTextById("r41004", hour, min)
        else
            self.Label_timing:setTextById("r41003", day, hour)
        end
    else
        local remainTime = math.max(0, self.activityInfo_.endTime - serverTime)
        local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
        if day == "00" then
            self.Label_timing:setTextById("r41002", hour, min)
        else
            self.Label_timing:setTextById("r41001", day, hour)
        end
    end
end

return AnniversaryFeedbackView
