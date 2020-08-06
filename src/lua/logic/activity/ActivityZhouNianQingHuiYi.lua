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
* -- 周年庆回忆活动页签
]]

local ActivityZhouNianQingHuiYi = class("ActivityZhouNianQingHuiYi",BaseLayer)

function ActivityZhouNianQingHuiYi:ctor( data )
	self.super.ctor(self,data)
	self.activityId = data
	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	self:init("lua.uiconfig.activity.znqActivityModelView")
end

function ActivityZhouNianQingHuiYi:initUI( ui )
	self.super.initUI(self,ui)
	self.Image_bg = TFDirector:getChildByPath(ui, "Image_bg")
	self.label_date = TFDirector:getChildByPath(ui, "label_date")
	self.Button_jump = TFDirector:getChildByPath(ui, "Button_jump")
	self.Label_title = TFDirector:getChildByPath(ui, "Label_title")
	self.Label_desc = TFDirector:getChildByPath(ui, "Label_desc")

	local startDate = Utils:getLocalDate(self.activityInfo.startTime)
    local startDateStr = startDate:fmt("%m.%d")
    local endDate = Utils:getLocalDate(self.activityInfo.endTime)
    local endDateStr = endDate:fmt("%m.%d")
    self.label_date:setTextById(800041, startDateStr, endDateStr)
    self.Label_title:setSkewX(15)
    self.Label_title:setTextById(self.activityInfo.extendData.title)
    self.Label_desc:setTextById(self.activityInfo.extendData.desc)
   
end

function ActivityZhouNianQingHuiYi:registerEvents()
	self.super.registerEvents(self)
	self.Button_jump:onClick(function ( ... )
		self:jumpFunc()
	end)
end

function ActivityZhouNianQingHuiYi:jumpFunc( ) 
	Utils:openView("activity.ZhouNianQingRuKou",self.activityId)
end
return ActivityZhouNianQingHuiYi