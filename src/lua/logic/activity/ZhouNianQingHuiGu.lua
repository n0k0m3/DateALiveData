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
* -- 周年庆活动回顾界面
]]

local ZhouNianQingHuiGu = class("ZhouNianQingHuiGu",BaseLayer)
local AnniversaryMonthBgTab = TabDataMgr:getData("AnniversarymonthBg")

function ZhouNianQingHuiGu:ctor( data )
	self.super.ctor(self,data)
	self.activityId = data
	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	self:init("lua.uiconfig.activity.znqHuiGuView")
end

function ZhouNianQingHuiGu:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	local ScrollView_huigu = TFDirector:getChildByPath(ui,"ScrollView_huigu")
	local Panel_item = TFDirector:getChildByPath(ui,"Panel_item")

	self.GridView_reward = UIGridView:create(ScrollView_huigu)
	self.GridView_reward:setItemModel(Panel_item)
	self.GridView_reward:setColumn(3)
	for k,v in ipairs(AnniversaryMonthBgTab) do
		local item = self.GridView_reward:pushBackDefaultItem()
		self:updateItem(item,v)
	end
end

function ZhouNianQingHuiGu:registerEvents( )
	-- body
	self.super.registerEvents(self)

    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, function ( ... )
    	if self.resqOpenHuiGu then
    		Utils:openView("activity.ZhouNianQingMain",{activityId = self.activityId, isHuiGu = true, month = self.month, day = 1})
    		self.resqOpenHuiGu = false
    		self.month = nil
    	end
    end)
end

function ZhouNianQingHuiGu:updateItem(item, data)
	-- body
	local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
	local Label_name = TFDirector:getChildByPath(item,"Label_name")
	local Image_lock = TFDirector:getChildByPath(item,"Image_lock")
	local Image_unlock = TFDirector:getChildByPath(item,"Image_unlock")
	local Label_year = TFDirector:getChildByPath(item,"Label_year")

	Image_icon:setTexture(data.reviewBg)
	Label_name:setText(data.date)
	Label_year:setText(data.year)
	local hasFinish = data.month < self.activityInfo.extendData.yearMonth
	if data.month ==  self.activityInfo.extendData.yearMonth then
		hasFinish = ActivityDataMgr2:checkYearActivityCurMonthStatus(self.activityId,data.month)
	end
	Image_lock:setVisible(not hasFinish)
	Image_unlock:setVisible(hasFinish)

	item:setTouchEnabled(hasFinish)
	item:onClick(function ( ... )
		-- body
		if #ActivityDataMgr2:getYearActivityItemsByMonth(self.activityId,data.month) > 0 then
    		Utils:openView("activity.ZhouNianQingMain",{activityId = self.activityId, isHuiGu = true, month = data.month, day = 1})
		else
			ActivityDataMgr2:getNewYearActivityItems(self.activityId,data.month)
			self.resqOpenHuiGu = true
			self.month = data.month
		end

	end)
end

return ZhouNianQingHuiGu