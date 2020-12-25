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
* --挂机活动特殊事件列表
]]
local HangUpEventListView = class("HangUpEventListView", BaseLayer)

function HangUpEventListView:ctor( ... )
	-- body
	self.super.ctor(self,...)
	self:initData(...)
	self:showPopAnim(true)
	self:init("lua.uiconfig.activity.eventListView")
end

function HangUpEventListView:initData( activityId )
	-- body
	self.activityId = activityId
	self.activityInfo = ActivityDataMgr2:getActivityInfo(activityId)
end

function HangUpEventListView:initUI( ui )
	-- body
	self.super.initUI(self, ui)

	local ScrollView_event = TFDirector:getChildByPath(ui,"ScrollView_event")
	self.Panel_eventItem = TFDirector:getChildByPath(ui,"Panel_eventItem")
	self.Label_process = TFDirector:getChildByPath(ui,"Label_process")
	self.Button_getAll = TFDirector:getChildByPath(ui,"Button_getAll")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")

	self.uiList_event = UIListView:create(ScrollView_event)
	self:refreshView()
end

function HangUpEventListView:registerEvents(  )
	-- body
	self.super.registerEvents(self)
	
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_HANGUP_SPECIALAWARD, handler(self.refreshView, self))
 	EventMgr:addEventListener(self, EV_ACTIVITY_DELETED, function ( activityId )
	    		if self.activityId == activityId then
	    			AlertManager:closeLayer(self)
	    		end
	    	end)
	self.Button_close:onClick(function ( ... )
		AlertManager:closeLayer(self)
	end)

	self.Button_getAll:onClick(function ( ... )
		ActivityDataMgr2:send_ACTIVITY_REQ_GET_HANG_UP_SEVENT_AWARD(self.activityId, 0)
	end)
end

function HangUpEventListView:refreshView( ... )
	-- body
	self.Label_process:setText("10/20")

	local events = self.activityInfo.data.specialAward or {}
	self.uiList_event:removeAllItems()
	for k,v in pairs(events) do
		local item = self.Panel_eventItem:clone()
		self.uiList_event:pushBackCustomItem(item)

		self:updateEventItem(item,v)
	end

end

function HangUpEventListView:updateEventItem( item, data )
	-- body
	local Label_des = TFDirector:getChildByPath(item,"Label_des")
	local Button_get = TFDirector:getChildByPath(item,"Button_get")
	local Image_ing = TFDirector:getChildByPath(item,"Image_ing")
	local Panel_geted = TFDirector:getChildByPath(item,"Panel_geted")

	local eventInfo = TabDataMgr:getData("HangUpTrigger",data.triggerId)
	local id,num
	for i = 1,2 do
		local reward = TFDirector:getChildByPath(item,"Panel_reward"..i):hide()
		id,num = next(eventInfo.reward,id)
		if id then
			reward:show()
			local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
 			PrefabDataMgr:setInfo(Panel_goodsItem, id, num)
 			Panel_goodsItem:setScale(0.6)
			Panel_goodsItem:Pos(0, 0):AddTo(reward)
		end 
	end

	Button_get:onClick(function ( ... )
		-- body
		ActivityDataMgr2:send_ACTIVITY_REQ_GET_HANG_UP_SEVENT_AWARD(self.activityId, data.id)
	end)
	Label_des:setTextById(eventInfo.heroDescribe)
	Button_get:setVisible(true)
	Image_ing:setVisible(false)
	Panel_geted:setVisible(false)
end


return HangUpEventListView