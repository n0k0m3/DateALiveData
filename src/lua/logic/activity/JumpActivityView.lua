--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
* -- 跳转活动类型
]]

local JumpActivityView = class("JumpActivityView",BaseLayer)

function JumpActivityView:ctor( data )
	self.super.ctor(self,data)
	self.activityId = data
	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	local uiName = self.activityInfo.extendData.uiName or "jumpActivityModel"
	self:init("lua.uiconfig.activity."..uiName)
end

function JumpActivityView:initUI( ui )
	self.super.initUI(self,ui)
	self.Image_bg = TFDirector:getChildByPath(ui, "Image_bg")
	self.label_time = TFDirector:getChildByPath(ui, "label_time")
	self.label_date = TFDirector:getChildByPath(ui, "label_date")
	self.Button_jump = TFDirector:getChildByPath(ui, "Button_jump")

    if self.activityInfo.extendData.dateRstring then
    	local dateStyle = self.activityInfo.extendData.dateStyle
    	local startDateStr = Utils:getDateString(self.activityInfo.startTime, dateStyle)
    	local endDateStr = Utils:getDateString(self.activityInfo.endTime, dateStyle)
    	self.label_date:setTextById(self.activityInfo.extendData.dateRstring, startDateStr, endDateStr)
	else
		self.label_date:setText(Utils:getActivityDateString(self.activityInfo.startTime, self.activityInfo.endTime, self.activityInfo.extendData.dateStyle))
	end

	if self.activityInfo.extendData.skewX then
		self.label_date:setSkewX(self.activityInfo.extendData.skewX)
		self.label_time:setSkewX(self.activityInfo.extendData.skewX)
	end
    self:updateCountDown()

    if self.activityInfo.extendData.bgPath then	
    	self.Image_bg:setTexture(self.activityInfo.extendData.bgPath)
	end
end

function JumpActivityView:onUpdateCountDownEvent()
    self:updateCountDown()
end

function JumpActivityView:updateCountDown()
    local serverTime = ServerDataMgr:getServerTime()
    local remainTime = math.max(0, self.activityInfo.showEndTime - serverTime)
    local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
    if day == "00" then
        self.label_time:setTextById(self.activityInfo.extendData.hourRstring, hour, min)
    else
        self.label_time:setTextById(self.activityInfo.extendData.dayRstring, day, hour)
    end
end

function JumpActivityView:registerEvents()
	self.super.registerEvents(self)
	self.Button_jump:onClick(function ( ... )
		self:jumpFunc()
	end)
end

function JumpActivityView:jumpFunc( ) 
	local activityInfo = self.activityInfo
	if activityInfo.activityType == EC_ActivityType2.WELFARE_TASK then
		Utils:openView("activity.WelfareTaskView",self.activityId)
	elseif activityInfo.activityType == EC_ActivityType2.ENTRUST then 
		Utils:openView("activity.ActivityEntrustView",self.activityId)
	elseif activityInfo.activityType == EC_ActivityType2.CGCOLLECTED then
		Utils:openView("activity.ActivitySpecialCgView",self.activityId)
	elseif activityInfo.activityType == EC_ActivityType2.KUANGSAN_FUBEN then
		FunctionDataMgr:jKsanFuben()
	elseif activityInfo.activityType == EC_ActivityType2.NEWYEAR_FUBEN or activityInfo.activityType == EC_ActivityType2.HWX_FUBEN then
		FunctionDataMgr:jSpecialFuben(activityInfo.activityType)
	elseif activityInfo.activityType == EC_ActivityType2.WSJ_2020 then
		Utils:openView("activity.WsjActivityMainView", self.activityId)
	elseif activityInfo.extendData.jumpInterface  then
		FunctionDataMgr:enterByFuncId(activityInfo.extendData.jumpInterface, unpack(activityInfo.extendData.jumpParamters or {}))
	end
end
return JumpActivityView