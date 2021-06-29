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
	self.Button_jump:setScaleX(1)
	local act_time = TFDirector:getChildByPath(ui, "act_time")
	local act_timeStart = TFDirector:getChildByPath(ui, "act_timeStart")
	local act_timeEnd = TFDirector:getChildByPath(ui, "act_timeEnd")

    if self.activityInfo.extendData.dateRstring then
    	local dateStyle = self.activityInfo.extendData.dateStyle
    	local startDateStr = Utils:getUTCDateString(self.activityInfo.startTime, dateStyle)
    	local endDateStr = Utils:getUTCDateString(self.activityInfo.endTime, dateStyle)
    	self.label_date:setText(TextDataMgr:getText(self.activityInfo.extendData.dateRstring, startDateStr, endDateStr)..GV_UTC_TIME_STRING)
    	self.label_date:setFontSize(19)
	else
		self.label_date:setText(Utils:getActivityDateString(self.activityInfo.startTime, self.activityInfo.endTime, self.activityInfo.extendData.dateStyle))
	end

	if act_time then
		act_time:setTextById(1710002)
		local year, month, day = Utils:getUTCDateYMD(self.activityInfo.showStartTime or 0 , false , GV_UTC_TIME_ZONE)
		act_timeStart:setTextById(1410001,year, month, day)
		year, month, day = Utils:getUTCDateYMD(self.activityInfo.endTime or 0, false , GV_UTC_TIME_ZONE)
		act_timeEnd:setText(TextDataMgr:getText(1410001,year, month, day)..GV_UTC_TIME_STRING)
	end

	if self.activityInfo.extendData.skewX then
		self.label_date:setSkewX(self.activityInfo.extendData.skewX)
		self.label_time:setSkewX(self.activityInfo.extendData.skewX)
	end
    self:updateCountDown()

    if self.activityInfo.extendData.bgPath then	
    	self.Image_bg:setTexture(self.activityInfo.extendData.bgPath)
	end
	if self.activityInfo.extendData.buttonPath then	
		self.Button_jump:setTextureNormal(self.activityInfo.extendData.buttonPath)
		self.Button_jump:setPosition(300 , -90)
		if self.activityInfo.id == 58 then
			self.label_date:setPosition(-400 , 240)
		elseif self.activityInfo.id == 110 then
			self.label_date:setFontColor(ccc3(255 , 255 , 255))
			self.Button_jump:setPosition(350 , -200)
		elseif self.activityInfo.id == 105 then
			self.label_date:setFontColor(ccc3(255 , 255 , 255))
			self.Button_jump:setPosition(300 , -200)
			self.label_date:setPosition(-280 , 240)
			-- if self.Button_jump:getChildByName("Label_hunterLevelActivity_1") then
			-- 	self.Button_jump:getChildByName("Label_hunterLevelActivity_1"):hide()
			-- end
			self.Button_jump:getChildByName("Label_hunterLevelActivity_1"):setPositionX(0)
			self.Button_jump:getChildByName("Label_hunterLevelActivity_1"):setFontColor(ccc3(255 , 0 , 0))
		else
			self.label_date:setPosition(400 , 250)
		end
		if self.Button_jump:getChildByName("label_jump") then
			self.Button_jump:getChildByName("label_jump"):hide()
		end
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
		--FunctionDataMgr:jKsanFuben()  --狂三跳转修改为英文版特殊的
		FunctionDataMgr:enterByFuncId(activityInfo.extendData.jumpInterface, unpack(activityInfo.extendData.jumpParamters or {}))
	elseif activityInfo.activityType == EC_ActivityType2.NEWYEAR_FUBEN or activityInfo.activityType == EC_ActivityType2.HWX_FUBEN then
		FunctionDataMgr:jSpecialFuben(activityInfo.activityType)
	elseif activityInfo.activityType == EC_ActivityType2.WSJ_2020 then
		Utils:openView("activity.WsjActivityMainView", self.activityId)
	elseif activityInfo.activityType == EC_ActivityType2.DICUO_LINKAGE then
		Utils:openView("liandongChapter.ChapterMapLayer", self.activityId)
	elseif activityInfo.activityType == EC_ActivityType2.MAOKA then
        FunctionDataMgr:jWorldRoom(99)
	elseif activityInfo.extendData.jumpInterface  then
		FunctionDataMgr:enterByFuncId(activityInfo.extendData.jumpInterface, unpack(activityInfo.extendData.jumpParamters or {}))
	end
end
return JumpActivityView