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

local ItemInfoListView = class("ItemInfoListView", BaseLayer)

function ItemInfoListView:ctor( ... )
	-- body
	self.super.ctor(self,...)
	self:initData(...)
	self:showPopAnim(true)
	self:init("lua.uiconfig.activity.itemInfoListView")
end

function ItemInfoListView:initData( activityId )
	-- body
	self.activityId = activityId
	self.activityInfo = ActivityDataMgr2:getActivityInfo(activityId)
end

function ItemInfoListView:initUI( ui )
	-- body
	self.super.initUI(self, ui)

	local ScrollView_event = TFDirector:getChildByPath(ui,"ScrollView_event")
	self.Panel_eventItem = TFDirector:getChildByPath(ui,"Panel_eventItem")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")

	self.uiList_event = UIListView:create(ScrollView_event)
	self:refreshView()
end

function ItemInfoListView:registerEvents(  )
	-- body
	self.super.registerEvents(self)
	
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.refreshView, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))

	self.Button_close:onClick(function ( ... )
		AlertManager:closeLayer(self)
	end)
end

function ItemInfoListView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId ~= activitId then return end
    Utils:showReward(reward)
end

function ItemInfoListView:refreshView( ... )

	local events = ActivityDataMgr2:getItems(self.activityId)

	table.sort( events, function ( a, b )
		-- body
		local progressInfoA = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, a)
		local progressInfoB = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, b)

		if progressInfoA.status == progressInfoB.status then
			return a < b
		elseif progressInfoA.status == EC_TaskStatus.GETED then
			return false	
		elseif progressInfoB.status == EC_TaskStatus.GETED then
			return true
		elseif progressInfoA.status == EC_TaskStatus.GET then
			return true
		elseif progressInfoB.status == EC_TaskStatus.GET then
			return false
		end
	end )

	self.uiList_event:removeAllItems()
	for k,v in pairs(events) do
		local item = self.Panel_eventItem:clone()
		self.uiList_event:pushBackCustomItem(item)

		self:updateEventItem(item,v)
	end

end

function ItemInfoListView:updateEventItem( item, data )
	-- body
	local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, data)
	local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, data)

	local Label_des = TFDirector:getChildByPath(item,"Label_des")
	local Button_get = TFDirector:getChildByPath(item,"Button_get")
	local Image_ing = TFDirector:getChildByPath(item,"Image_ing")
	local Panel_geted = TFDirector:getChildByPath(item,"Panel_geted")
	local Label_ing = TFDirector:getChildByPath(item,"Label_ing")

	
	local id,num
	for i = 1,3 do
		local reward = TFDirector:getChildByPath(item,"Panel_reward"..i)
		id,num = next(itemInfo.reward,id)
		if id then
			local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
 			PrefabDataMgr:setInfo(Panel_goodsItem, id, num)
 			Panel_goodsItem:setScale(0.6)
			Panel_goodsItem:Pos(0, 0):AddTo(reward)
		else
			break
		end 
	end
	Label_des:setText(itemInfo.extendData.des2)

	Button_get:onClick(function ( ... )
		-- body
        ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, data)
	end)
	Button_get:setVisible(progressInfo.status == EC_TaskStatus.GET)
	Image_ing:setVisible(progressInfo.status == EC_TaskStatus.ING)
	Panel_geted:setVisible(progressInfo.status == EC_TaskStatus.GETED)
	Label_ing:setText(progressInfo.progress.."/"..itemInfo.target)
end


return ItemInfoListView