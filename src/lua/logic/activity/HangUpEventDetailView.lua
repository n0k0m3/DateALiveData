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
* -- 挂机活动事件详细
]]
local HangUpEventDetailView = class("HangUpEventDetailView", BaseLayer)

function HangUpEventDetailView:ctor( ... )
	-- body
	self.super.ctor(self,...)
	self:initData(...)
	self:showPopAnim(true)
	self.timingNode = {}
	self:init("lua.uiconfig.activity.eventDetailView")
end

function HangUpEventDetailView:initData( activityId, eventId )
	-- body
	self.activityId = activityId
	self.eventId = eventId
	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	self.eventCfg = TabDataMgr:getData("HangUpEvent", eventId) 
end

function HangUpEventDetailView:initUI( ui )
	-- body
	self.super.initUI(self, ui)
	self.Label_title = TFDirector:getChildByPath(ui,"Label_title")
	self.Button_getAll = TFDirector:getChildByPath(ui,"Button_getAll")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	self.Label_process = TFDirector:getChildByPath(ui,"Label_process")
	self.Label_renshu = TFDirector:getChildByPath(ui,"Label_renshu")
	self.Label_des = TFDirector:getChildByPath(ui,"Label_des")
	self.Image_icon = TFDirector:getChildByPath(ui,"Image_icon")
	local ScrollView_sprite = TFDirector:getChildByPath(ui,"ScrollView_sprite")
	self.uiList_sprite = UIListView:create(ScrollView_sprite)
	self.Panel_eventItem = TFDirector:getChildByPath(ui,"Panel_eventItem")
	self.Panel_up = TFDirector:getChildByPath(ui,"Panel_up")
	self.Label_upNum = TFDirector:getChildByPath(ui,"Label_upNum")
	self.Label_upNum:setSkewX(10)

	self.Label_des:setTextById(self.eventCfg.describe)
	local showItemId = next(self.eventCfg.profit)
	self.Image_icon:setTexture(GoodsDataMgr:getItemCfg(showItemId).icon)

	self.Image_icon:setTouchEnabled(true)
	self.Image_icon:onClick(function ( ... )
		-- body
		Utils:showInfo(showItemId)
	end)

	self.Label_title:setTextById(self.eventCfg.name)

	self:refreshView()
end

function HangUpEventDetailView:getEventInfo( eventId )
	-- body
	for k,v in pairs(self.activityInfo.data.eventList) do
		if v.eventId == eventId then 
			return v
		end
	end
	return {}
end

function HangUpEventDetailView:removeEvents( ... )
	-- body
	self.super.removeEvents(self)
	self:removeCountDownTimer()
end

function HangUpEventDetailView:refreshView(  )
	-- body
	self.data = self:getEventInfo(self.eventId)
	self.Panel_up:setVisible(self.data.isSpecial)

	self.data.roleIds = self.data.roleIds or {}
	self.data.rewards = self.data.rewards or {}
	self.timingNode = {}
	for i = 1,self.eventCfg.maxRole do
		local item = self.uiList_sprite:getItem(i)
		if not item then
			item = self.Panel_eventItem:clone()
			self.uiList_sprite:pushBackCustomItem(item)
		end
		self:updateItem(item,i)
	end
	local curNum = self.data.rewards[1] and self.data.rewards[1].num or 0
	self.Label_process:setText(curNum.."/"..self.eventCfg.max)

	self.Label_renshu:setText(#self.data.roleIds.."/"..self.eventCfg.maxRole)
end

function HangUpEventDetailView:registerEvents(  )
	-- body
	self.super.registerEvents(self)

    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_HANGUP_EVENTLIST, handler(self.refreshView, self))
	self.Button_getAll:onClick(function ( ... )
		-- body
		local curNum = self.data.rewards[1] and self.data.rewards[1].num or 0
		if curNum > 0 then
			ActivityDataMgr2:send_ACTIVITY_REQ_GET_HANG_UP_AWARD(self.activityId,self.data.eventId)
		end
	end) 
	
	EventMgr:addEventListener(self, EV_ACTIVITY_DELETED, function ( activityId )
    		if self.activityId == activityId then
    			AlertManager:closeLayer(self)
    		end
    	end)

	self.Button_close:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)
	self:addCountDownTimer()
end

function HangUpEventDetailView:addTimeFunc( node )
	-- body
	if table.find(self.timingNode, node) == -1 then
		table.insert(self.timingNode, node)
	end
end

function HangUpEventDetailView:getSpriteInfoById( roleId )
	-- body
	for k,v in pairs(self.activityInfo.data.hangUpRoleInfo) do
		if v.roleId == roleId then
			return v
		end
	end
	return {}
end

function HangUpEventDetailView:updateItem( item, idx )
	-- body
	local roleId = self.data.roleIds[idx]
	local Panel_ing = TFDirector:getChildByPath(item, "Panel_ing"):hide()
	local Panel_empty = TFDirector:getChildByPath(item, "Panel_empty"):hide()
	local Button_leave = TFDirector:getChildByPath(item, "Button_leave")
	local Button_join = TFDirector:getChildByPath(item, "Button_join")

	if roleId then
		local roleInfo = self:getSpriteInfoById(roleId)
		local spriteInfo = TabDataMgr:getData("HangUpRole", roleId)
		Panel_ing:show()
		local Image_icon = TFDirector:getChildByPath(Panel_ing, "Image_icon")
		local Label_lv = TFDirector:getChildByPath(Panel_ing, "Label_lv")
		local Image_resicon = TFDirector:getChildByPath(Panel_ing, "Image_resicon")
		local Label_clsd = TFDirector:getChildByPath(Panel_ing, "Label_clsd")
		local Label_timing = TFDirector:getChildByPath(Panel_ing, "Label_timing")
		local Image_up = TFDirector:getChildByPath(Panel_ing, "Image_up")

		Image_icon:setTexture(spriteInfo.icon)
		Label_lv:setText("Lv."..roleInfo.level)
		local showItemId = roleInfo.rewards[1].id
		Image_resicon:setTexture(GoodsDataMgr:getItemCfg(showItemId).icon)
		Label_clsd:setTextById(14300205,roleInfo.rewards[1].num)
		Label_timing.timingFunc = function ( ... )
			local roleInfo_ = self:getSpriteInfoById(roleId)
			local time = roleInfo_.nextSettleTime or 0
			Label_timing:setText(Utils:getTimeCountDownString(time,2))
		end
		Label_timing.timingFunc()
		self:addTimeFunc(Label_timing)
		Image_up:setVisible(table.find(self.eventCfg.upHero,roleId) ~= -1)
	else
		Panel_empty:show()
	end

	Button_leave:onClick(function ( ... )
		-- body
		local args = {
            tittle = 2107025,
            content = TextDataMgr:getText(14300209),
            reType = "DOWNHANGUPROLE",
            confirmCall = function()
				ActivityDataMgr2:send_ACTIVITY_REQ_UP_OR_DOWN_HANG_UP_ROLE(self.activityId, roleId, false, self.data.eventId)
            end,
        }
        Utils:showReConfirm(args)
	end)

	Button_join:onClick(function ( ... )
		-- body
		Utils:openView("activity.HangUpChooseSpriteView",self.activityId, self.data.eventId)
	end)
end

function HangUpEventDetailView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, -1, nil, handler(self.onCountDownPer, self))
    end
end

function HangUpEventDetailView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
    end
end

function HangUpEventDetailView:onCountDownPer()
  	for k,v in pairs(self.timingNode) do
  		v.timingFunc()
  	end
end

function HangUpEventDetailView:addTimeFunc( node )
	-- body
	if table.find(self.timingNode, node) == -1 then
		table.insert(self.timingNode, node)
	end
end

return HangUpEventDetailView