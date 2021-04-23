--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local SzdyShareView = class("SzdyShareView", BaseLayer)
function SzdyShareView:ctor(...)
	self.super.ctor(self)
	--self:showPopAnim(true)
	self:initData(...)
	self:init("lua.uiconfig.activity.szdyShareView")
end

function SzdyShareView:initData(activityId)
	self.activityId = activityId
	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
end

function SzdyShareView:initUI(ui)
	self.super.initUI(self,ui)

	TFDirector:getChildByPath(ui, "Button_close"):onClick(function()
		AlertManager:closeLayer(self)
	end)

	self:timeOut(function()
        local ret = self:shareResult()
        if ret then
            ActivityDataMgr2:ReqShareComplete(self.activityId)
        end
    end, 0.1)
end

function SzdyShareView:onShow()
	self.super.onShow(self)
end

function SzdyShareView:shareResult()
    local ret = false
    if HeitaoSdk then
        ret = HeitaoSdk.takeScreenshot();
    else
        ret = takeScreenshot()
        ret = true
    end
    return ret
end

function SzdyShareView:submitReward()
	local taskInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, self.activityInfo.items[2])
	if taskInfo.status == EC_TaskStatus.GET then
		ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, self.activityInfo.items[2])
	end
end

function SzdyShareView:showReward(activitId, entryid,rewards)
	if self.activityId == activitId and rewards and #rewards > 1 then	
		Utils:showReward(rewards)	
	end
end

function SzdyShareView:registerEvents()
	self.super.registerEvents(self)

	EventMgr:addEventListener(self, EV_ACTIVITY_SHARE_COMPLETE, handler(self.submitReward, self))
	EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.showReward, self))
end

return SzdyShareView


--endregion
