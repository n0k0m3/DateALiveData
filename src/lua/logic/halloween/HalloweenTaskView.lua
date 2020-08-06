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
* -- 万圣节任务界面
]]

local HalloweenTaskView = class("HalloweenTaskView",BaseLayer)

function HalloweenTaskView:ctor( ... )
	-- body
	self.super.ctor(self,...)
	self:initData(...)
  	self:showPopAnim(true)
	self:init("lua.uiconfig.halloween.halloweenTaskView")
end

function HalloweenTaskView:initData( activityId )
	-- body
	self.activityId = activityId
	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	self.task_ = {}
	for i, v in pairs(self.activityInfo.extendData.sendDayAwardList) do
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, v)
        local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, v)
       	if not progressInfo.extend.rFlag then
            table.insert(self.task_, itemInfo)
        end
    end

   	table.sort( self.task_, function ( a, b )
   		local progressInfo1 = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, a.id)
   		local progressInfo2 = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, b.id)
        if progressInfo1.status == progressInfo2.status then
            return a.id > b.id
        elseif progressInfo1.status == EC_TaskStatus.GETED then
            return false
        elseif progressInfo2.status == EC_TaskStatus.GETED then
            return true
        elseif progressInfo1.status == EC_TaskStatus.GET then
            return true
        elseif progressInfo2.status == EC_TaskStatus.GET then
            return false
        end
   	end )
end

function HalloweenTaskView:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	local ScrollView_task = TFDirector:getChildByPath(ui,"ScrollView_task")
	self.uiList_task = UIListView:create(ScrollView_task)
	self.tip1 = TFDirector:getChildByPath(ui,"tip1")
	self.Panel_item = TFDirector:getChildByPath(ui,"Panel_item")
	self:updateView()
	self.tip1:setTextById(2109050)
end

function HalloweenTaskView:registerEvents( ... )
	-- body
	EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, function ( ... )
			self:initData(self.activityId)
			self:updateView()
		end)
	self.Button_close:onClick(function ( ... )
		AlertManager:closeLayer(self)
	end)
end

function HalloweenTaskView:updateView( )
	-- body
	self.uiList_task:removeAllItems()
	for k,v in pairs(self.task_) do
		local item = self.Panel_item:clone()
		self:updateItem(item,v)
		self.uiList_task:pushBackCustomItem(item)
	end
end

function HalloweenTaskView:updateItem( item, data )
	-- body
	local Panel_normal = TFDirector:getChildByPath(item, "Panel_normal")
	local Panel_ing = TFDirector:getChildByPath(item, "Panel_ing")
	local Button_get = TFDirector:getChildByPath(item, "Button_get")
	local Image_getted = TFDirector:getChildByPath(item, "Image_getted")
	local label_ing = TFDirector:getChildByPath(item, "label_ing")
	local Image_get = TFDirector:getChildByPath(item, "Image_get")
	local ScrollView_reward = TFDirector:getChildByPath(item, "ScrollView_reward")

	local task_des1 = TFDirector:getChildByPath(Panel_ing, "task_des")
	local task_des2 = TFDirector:getChildByPath(Panel_normal, "task_des")
	local label_progress = TFDirector:getChildByPath(item, "label_progress")

	if not item.rewardList then
		item.rewardList = UIListView:create(ScrollView_reward)
	end

   	local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, data.id)

	Panel_ing:setVisible(progressInfo.status == EC_TaskStatus.ING)
	Panel_normal:setVisible(progressInfo.status ~= EC_TaskStatus.ING)
	Image_getted:setVisible(progressInfo.status == EC_TaskStatus.GETED)
	Image_get:setVisible(progressInfo.status == EC_TaskStatus.GET)
	label_ing:setVisible(progressInfo.status == EC_TaskStatus.ING)

	task_des1:setText(data.extendData.des2)
	task_des2:setText(data.extendData.des2)

	label_progress:setText("("..progressInfo.progress.."/"..data.target..")")
	if progressInfo.status ~= EC_TaskStatus.ING then
		label_progress:setText("("..data.target.."/"..data.target..")")
	end

	item.rewardList:removeAllItems()
	local idx = 1 
	for id,num in pairs(data.reward) do
        local itemCfg = GoodsDataMgr:getItemCfg(id)
        local panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        panel_goodsItem:Scale(0.6)
        PrefabDataMgr:setInfo(panel_goodsItem, id, num)
        panel_goodsItem:setPosition(me.p(0, 0))
        item.rewardList:pushBackCustomItem(panel_goodsItem)
	    idx = idx + 1
	end

	Button_get:onClick(function ( ... )
		 ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, data.id)
	end)
end

return HalloweenTaskView