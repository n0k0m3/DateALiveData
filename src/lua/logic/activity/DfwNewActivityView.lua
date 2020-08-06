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
* -- 大富翁活动类型
]]

local DfwNewActivityView = class("DfwNewActivityView",BaseLayer)

function DfwNewActivityView:ctor( data )
	self.super.ctor(self,data)
	self.activityId = data
	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	local uiName = self.activityInfo.extendData.uiName or "dfwNewActivityModel"
	self:init("lua.uiconfig.activity."..uiName)
end

function DfwNewActivityView:initUI( ui )
	self.super.initUI(self,ui)
	local Panel
	self.Image_bg = TFDirector:getChildByPath(ui, "Image_bg")
	self.label_time = TFDirector:getChildByPath(ui, "label_time")
	self.label_date = TFDirector:getChildByPath(ui, "label_date")
	self.Button_jump = TFDirector:getChildByPath(ui, "Button_jump")

	self:updateView()
end

function DfwNewActivityView:updateView()
	dump(self.activityInfo)

	local showStartTime = self.activityInfo.showStartTime
	local showEndTime = self.activityInfo.showEndTime

	local startDate = os.date("%Y.%m.%d", showStartTime)
	local endDate = os.date("%Y.%m.%d", showEndTime)

	local str = TextDataMgr:getText(100000330)
	self.label_date:setString(string.format("%s%s-%s", str, startDate, endDate))
end

function DfwNewActivityView:registerEvents()
	DfwNewActivityView.super.registerEvents(self)
	self.Button_jump:onClick(function ( ... )
		dump(self.activityInfo)

		Utils:openView("dfwNew.DfwNewMainView", self.activityId)	
	end)
end

return DfwNewActivityView