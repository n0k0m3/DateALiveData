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
* -- 挂机活动主界面
]]

local HangUpMainView = class("HangUpMainView", BaseLayer)

function HangUpMainView:ctor( ... )
	-- body
	self.super.ctor(self,...)
	self:initData(...)
	self.timingNode = {}
	self:init("lua.uiconfig.activity.hangUpMainView")
end

function HangUpMainView:initData( activityId )
	-- body
	self.activityId = activityId
	self.activityInfo = ActivityDataMgr2:getActivityInfo(activityId)
end

function HangUpMainView:initUI( ui )
	-- body
	self.super.initUI(self, ui)
	local Panel_mapView = TFDirector:getChildByPath(ui,"Panel_mapView")
	self.mapBg = createUIByLuaNew("lua.uiconfig.activity.newYearHangUpMap")

	
	self.mapBg:setAnchorPoint(ccp(0,0))
	self.mapView = require("lua.public.ScrollAndZoomView"):new(Panel_mapView:getContentSize(),self.mapBg:getContentSize())
	self.mapView:addChild(self.mapBg)
	self.mapView:setMinScale(0.5)
	self.mapView:setMaxScale(1)
    me.Director:setSingleEnabled(false)
    Panel_mapView:addChild(self.mapView)

    self.mapView:setNodeScale(0.5)
    self.mapView:focus(ccp(self.mapBg:getContentSize().width/2,self.mapBg:getContentSize().height/2))

	self.mapBg = TFDirector:getChildByPath(self.mapBg, "bg")

	self.Button_event = TFDirector:getChildByPath(ui,"Button_event")
	self.Button_sprite = TFDirector:getChildByPath(ui,"Button_sprite")
	self.Button_shop = TFDirector:getChildByPath(ui,"Button_shop")

	self.redPoint_event = TFDirector:getChildByPath(self.Button_event,"Image_new"):hide()
	self.redPoint_sprite = TFDirector:getChildByPath(self.Button_sprite,"Image_new"):hide()
	self.redPoint_shop = TFDirector:getChildByPath(self.Button_shop,"Image_new"):hide()

	self.Panel_eventItem = TFDirector:getChildByPath(ui,"Panel_eventItem")
	self:refreshEventNode()
end

function HangUpMainView:onShow( ... )
	-- body
	self.super.onShow(self)
	if self.activityInfo.extendData.datingId then
		if Utils:getLocalSettingValue("hangupDating"..self.activityInfo.extendData.datingId) ~= "TRUE" then
			FunctionDataMgr:jStartDating(self.activityInfo.extendData.datingId)
			Utils:setLocalSettingValue("hangupDating"..self.activityInfo.extendData.datingId,"TRUE")
		end
	end
end

function HangUpMainView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, -1, nil, handler(self.onCountDownPer, self))
    end
end

function HangUpMainView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
    end
end

function HangUpMainView:onCountDownPer()
  	for k,v in pairs(self.timingNode) do
  		if v.timingFunc then
	  		v.timingFunc()
	  	end
  	end
end

function HangUpMainView:addTimeFunc( node )
	-- body
	if table.find(self.timingNode, node) == -1 then
		table.insert(self.timingNode, node)
	end
end

function HangUpMainView:registerEvents(  )
	-- body
	self.super.registerEvents(self)

    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_HANGUP_EVENTLIST, handler(self.refreshEventNode, self))

    EventMgr:addEventListener(self, EV_ACTIVITY_DELETED, function ( activityId )
    		if self.activityId == activityId then
    			AlertManager:closeLayer(self)
    			Utils:showTips(14110403)
    		end
    	end)

	self.Button_event:onClick(function ( ... )
		-- body
		Utils:openView("activity.HangUpEventListView", self.activityId)
	end)

	self.Button_sprite:onClick(function ( ... )
		-- body
		Utils:openView("activity.HangUpSpriteTrainView", self.activityId)
	end)

	self.Button_shop:onClick(function ( ... )
		if self.activityInfo.extendData.jumpInterface then
			FunctionDataMgr:enterByFuncId(self.activityInfo.extendData.jumpInterface, unpack(self.activityInfo.extendData.jumpParamters or {}))
		end
	end)
	self:addCountDownTimer()
end

function HangUpMainView:removeEvents( ... )
	-- body
	self.super.removeEvents(self)
    me.Director:setSingleEnabled(true)
    self:removeCountDownTimer()
end

function HangUpMainView:refreshEventNode( ... )

	if not self.activityInfo.data then return end

	local events = self.activityInfo.data.eventList
	self.eventNodes = self.eventNodes or {}
	if #self.eventNodes > #events then
		for i = #self.eventNodes,#events,-1 do
			self.eventNodes[i]:removeFromParent()
			self.eventNodes[i] = nil
		end
	end

	for k,v in ipairs(events) do
		local eventItem = self.eventNodes[k]
		if not eventItem then
			eventItem = self.Panel_eventItem:clone()
			self.mapBg:addChild(eventItem)
			self.eventNodes[k] = eventItem
		end

		self:updateEventItem(eventItem, v)
	end
	local hasSpacialAward = self.activityInfo.data.specialAward and #self.activityInfo.data.specialAward > 0 
	self.redPoint_event:setVisible( hasSpacialAward )
end

function HangUpMainView:updateEventItem( item, data )
	-- body
	local btn_border = TFDirector:getChildByPath(item,"btn_border")
	local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
	local Image_up = TFDirector:getChildByPath(item,"Image_up")
	local Label_timing = TFDirector:getChildByPath(item,"Label_timing")
	local Spine_effect = TFDirector:getChildByPath(item,"Spine_effect")
	Spine_effect:playByIndex(0,-1,-1,1)

	local eventCfg = TabDataMgr:getData("HangUpEvent", data.eventId) 

	item:setPosition(ccp(eventCfg.pos.x,eventCfg.pos.y))
	if not eventCfg then return end
	btn_border:onClick(function ( ... )
		-- body
		Utils:openView("activity.HangUpEventDetailView", self.activityId, data.eventId)
	end)

	local showItemId = next(eventCfg.profit)

	Image_icon:setTexture(GoodsDataMgr:getItemCfg(showItemId).icon)
	
	Image_up:setVisible(data.isSpecial) 
	Label_timing:setSkewX(10)
	Label_timing.timingFunc =  function ()
		local time = data.eventEndTime or 0
		Label_timing:setText(Utils:getTimeCountDownString(time,1))
	end
	Label_timing.timingFunc()
	self:addTimeFunc(Label_timing)
	local spriteLists = data.roleIds or {}
	for i = 1,6 do
		local spriteItem = TFDirector:getChildByPath(item,"Panel_sprite"..i)
		spriteItem:hide()

		if spriteLists[i] then
			spriteItem:show()
			local spriteCfg = TabDataMgr:getData("HangUpRole", spriteLists[i])
			local Image_head = TFDirector:getChildByPath(spriteItem, "Image_head")
			Image_head:setTexture(spriteCfg.icon)
		end
 	end
end

return HangUpMainView