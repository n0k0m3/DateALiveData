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
* -- 活动入口界面
]]

local DuanwuHangUpEntrance = class("DuanwuHangUpEntrance",BaseLayer)

function DuanwuHangUpEntrance:ctor( data )
	-- body
	self.super.ctor(self,data)
	self.activityId = data
	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	self:init("lua.uiconfig.activity.duanwuHangupEntrance")
end

function DuanwuHangUpEntrance:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	self.Image_bg = TFDirector:getChildByPath(ui, "Image_bg")
	self.label_time = TFDirector:getChildByPath(ui, "label_time")
	self.label_date = TFDirector:getChildByPath(ui, "label_date")
	self.Button_jump = TFDirector:getChildByPath(ui, "Button_jump")
	self.Label_tip = TFDirector:getChildByPath(ui, "Label_tip")

	self.Panel_item = TFDirector:getChildByPath(ui, "Panel_item")

	local ScrollView_fort = TFDirector:getChildByPath(ui, "ScrollView_fort")
	self.uiList_fort = UIListView:create(ScrollView_fort)


    if self.activityInfo.extendData.dateRstring then
    	local dateStyle = self.activityInfo.extendData.dateStyle
    	local startDateStr = Utils:getDateString(self.activityInfo.startTime, dateStyle)
    	local endDateStr = Utils:getDateString(self.activityInfo.endTime, dateStyle)
    	self.label_date:setTextById(self.activityInfo.extendData.dateRstring, startDateStr, endDateStr)
	else
		self.label_date:setText(Utils:getActivityDateString(self.activityInfo.startTime, self.activityInfo.endTime, self.activityInfo.extendData.dateStyle))
	end
	self.Label_tip:setText(self.activityInfo.extendData.des2 or "")
	self:updateFortList()
	self:updateCountDown()

end

function DuanwuHangUpEntrance:updateFortList( ... )
	-- body
	local fortDatas = DuanwuHangUpDataMgr:getFortList()

	self.uiList_fort:removeAllItems()

	local index = 1
	for k,v in ipairs(fortDatas) do
		if v.state == 1 or v.state == 2 then
			local item = self.Panel_item:clone()
			self.uiList_fort:pushBackCustomItem(item)
			item.data = v
			local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
			local Label_name = TFDirector:getChildByPath(item,"Label_name")

			local fortCfg = TabDataMgr:getData("HangupEvtFort",v.id)
			Image_icon:setTexture(fortCfg.icon)
			Label_name:setTextById(fortCfg.name)
			index = index + 1
		end
	end
	self.uiList_fort:doLayout()
end

function DuanwuHangUpEntrance:registerEvents()
	self.super.registerEvents(self)
	EventMgr:addEventListener(self, EV_DUANWU_HANGUP_RECV_FORT, handler(self.updateFortList, self))
	self.Button_jump:onClick(function ( ... )
		Utils:openView("duanwu_hangup.DuanwuHangUpMainMapView")
	end)
end

function DuanwuHangUpEntrance:onUpdateCountDownEvent()
    self:updateCountDown()
end

function DuanwuHangUpEntrance:updateCountDown()
    local serverTime = ServerDataMgr:getServerTime()
    local remainTime = math.max(0, self.activityInfo.showEndTime - serverTime)
    local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
    if day == "00" then
        self.label_time:setTextById(self.activityInfo.extendData.hourRstring, hour, min)
    else
        self.label_time:setTextById(self.activityInfo.extendData.dayRstring, day, hour)
    end

    for k,v in ipairs(self.uiList_fort:getItems()) do
    	local data = v.data
    	local Label_timing = TFDirector:getChildByPath(v,"Label_timing")


		local isFinish = data.state == 2 or (data.state == 1 and ServerDataMgr:getServerTime() >= data.endTime)

		if data.event and data.event[1].state ~= 2 and data.event[1].state ~= 5 then
			isFinish = false
		end

    	if data.event and data.event[1].state ~= 2 and data.event[1].state ~= 5 and ServerDataMgr:getServerTime() > data.event[1].startTime then
    		Label_timing:setTextById(13200908)
    	elseif data.state == 1 and not isFinish then
    		Label_timing:setText(Utils:getTimeCountDownString(data.endTime,2))
    	else
    		Label_timing:setTextById(13200909)
    	end
    end
end

return DuanwuHangUpEntrance