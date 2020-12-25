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
* 
]]

local YanHuaActivityEntrance = class("YanHuaActivityEntrance",BaseLayer)

function YanHuaActivityEntrance:ctor( data )
	self.super.ctor(self,data)
	self.activityId = data
	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	self:init("lua.uiconfig.activity.yanhuaActivityEntrance")
end

function YanHuaActivityEntrance:initUI( ui )
	self.super.initUI(self,ui)
	self.Image_bg = TFDirector:getChildByPath(ui, "Image_bg")
	self.label_time = TFDirector:getChildByPath(ui, "label_time")
	self.label_date = TFDirector:getChildByPath(ui, "label_date")
	self.Button_compose = TFDirector:getChildByPath(ui, "Button_compose")
	self.Button_go = TFDirector:getChildByPath(ui, "Button_go")
	self.Button_task = TFDirector:getChildByPath(ui, "Button_task")

    
    self.label_date:setText(Utils:getActivityDateString(self.activityInfo.startTime, self.activityInfo.endTime, self.activityInfo.extendData.dateStyle))

    self:updateCountDonw()

    if self.activityInfo.extendData.bgPath then	
    	self.Image_bg:setTexture(self.activityInfo.extendData.bgPath)
	end
end

function YanHuaActivityEntrance:onUpdateCountDownEvent()
    self:updateCountDonw()
end

function YanHuaActivityEntrance:updateCountDonw()
    self.label_time:setText(Utils:getTimeCountDownString(self.activityInfo.showEndTime))
end

function YanHuaActivityEntrance:registerEvents()
	self.super.registerEvents(self)
	self.Button_go:onClick(function ( ... )
		FunctionDataMgr:jCity()
	end)

	self.Button_compose:onClick(function ( ... )
		-- body
		Utils:openView("activity.YanHuaComposeView",self.activityId)
	end)

	self.Button_task:onClick(function ( ... )
		-- body
		Utils:openView("activity.ItemInfoListView",self.activityId)
	end)

end

return YanHuaActivityEntrance