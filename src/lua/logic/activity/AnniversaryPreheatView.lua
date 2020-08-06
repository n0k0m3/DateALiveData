--中秋周年庆预热活动
local AnniversaryPreheatView = class("AnniversaryPreheatView", BaseLayer)

function AnniversaryPreheatView:initData(activityId)
    self.activityId_ = activityId
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
end

function AnniversaryPreheatView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.anniversaryPreheatView")
end

function AnniversaryPreheatView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root         = TFDirector:getChildByPath(ui, "Panel_root")
    self.Image_ad           = TFDirector:getChildByPath(self.Panel_root, "Image_ad")
    self.Label_times        = TFDirector:getChildByPath(self.Panel_root, "Label_times")
    self.Label_timing       = TFDirector:getChildByPath(self.Panel_root, "Label_timing")
    self.Button_reward      = TFDirector:getChildByPath(self.Panel_root, "Button_reward"):hide()
    self.Button_share       = TFDirector:getChildByPath(self.Panel_root, "Button_share")
    self.rewardButtons = {}
    local pos =  self.Button_reward:getPosition()
    for i,v in ipairs(self.activityInfo_.reward2) do
        local button = self.Button_reward:clone()
        button.Label_title = TFDirector:getChildByPath(button, "Label_title")
        button:show()
        button.rewardIndex = i
        button:setPosition(ccp(pos.x + 5 + (i -1) * 104 ,pos.y))
        self.Image_ad:addChild(button)
        button:onClick(handler(self.onClickReward,self))
        self.rewardButtons[i] = button
    end
    self:updateActivity()
    self:onUpdateCountDownEvent()
end

function AnniversaryPreheatView:onClickReward(target)
    local rewardIndex = target.rewardIndex or 1
    local reward = self.activityInfo_.reward2[rewardIndex]
    if reward then 
        local items = {}
        for k,v in pairs(reward) do
            if k ~= "times" then 
                table.insert(items,{id = k,num=v})
            end
        end
        Utils:previewReward(nil, items)
    end
end

function AnniversaryPreheatView:updateActivity()
    local shareNum = ShareDataMgr:getShareNum()
    for i ,button in ipairs(self.rewardButtons) do
        local reward = self.activityInfo_.reward2[i]
        if shareNum >= reward.times then 
            button.Label_title:setFontSize(20)
            button.Label_title:setTextById(13310005)
        else
            button.Label_title:setFontSize(18)
            button.Label_title:setText(tostring(reward.times)) 
        end
    end
    self.Label_times:setText(tostring(shareNum)) 
end

function AnniversaryPreheatView:registerEvents()
    EventMgr:addEventListener(self, EV_UPDATE_PLAYERINFO, handler(self.updateActivity, self))
    self.Button_share:onClick(function( )
        -- 跳转分享界面
        local info = ShareDataMgr:getShareInfoById(2)
        if not info then 
            return
        end
        Utils:openView("store.ShareMainView")
    end) 
end

function AnniversaryPreheatView:onUpdateCountDownEvent()
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

return AnniversaryPreheatView
