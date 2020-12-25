--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

local SzdyEntryView = class("SzdyEntryView", BaseLayer)

function SzdyEntryView:ctor(...)
	self.super.ctor(self)

	self:initData(...)

	self:init("lua.uiconfig.activity.szdyViewEntry")
	
	self:refreshView()
end

function SzdyEntryView:initData(activityid)
	self.activityId = activityid
	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	dump(self.activityInfo)
	self.costNum = 0

	self:updateData()
end

function SzdyEntryView:initUI(ui)
	self.super.initUI(self, ui)
	
	self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root") 
	self.Button_enter = TFDirector:getChildByPath(self.Panel_root, "Button_enter")
	
	self.act_timeStart = TFDirector:getChildByPath(ui, "act_timeStart")
	self.act_timeEnd = TFDirector:getChildByPath(ui, "act_timeEnd")

	self.Label_Item_Count = TFDirector:getChildByPath(ui, "Label_Item_Count")

	self.Panel_Item = TFDirector:getChildByName(ui, "Panel_Item")
	self.Panel_Item.Reward1 = TFDirector:getChildByName(self.Panel_Item, "Reward1")
	self.Panel_Item.Reward2 = TFDirector:getChildByName(self.Panel_Item, "Reward2")
	self.Panel_Item.Reward2.finish = TFDirector:getChildByName(self.Panel_Item, "finish"):Hide()
	self.Panel_Item.Reward2.got = TFDirector:getChildByName(self.Panel_Item, "got"):Hide()
	self.Panel_Item.Reward2.touch = TFDirector:getChildByName(self.Panel_Item, "touch"):Hide()
	self.Panel_Item.Reward2.touch:setTouchEnabled(true)
	self.Panel_Item.Reward2.touch:setSwallowTouch(true)
	self.Panel_Item.Reward2.touch:addMEListener(TFWIDGET_CLICK, function()
		local function __callBack()		
			ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, self.taskInfo.id, 1)
			ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, self.taskInfo.id, 1)
		end
		if GoodsDataMgr:getItemCount(tonumber(self.exchangeItemId)) > 0 then
			local view = Utils:openView("common.ConfirmBoxView")
			view:setCallback(function()
			   __callBack()
			end)
			local content = TextDataMgr:getText(63822)
			view:setContent(content)
		else
			__callBack()
		end
	end)
end

function SzdyEntryView:registerEvents()
	self.super.registerEvents(self)
	EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onTaskReceiveEvent, self))
	EventMgr:addEventListener(self,EV_ACTIVITY_UPDATE_PROGRESS,function()
		self:refreshView()
	end)
	EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, function()
		self:refreshView() 
	end)

	self.Button_enter:onClick(function()		
		Utils:openView("activity.SzdyView", self.activityid)
	end)
end

function SzdyEntryView:refreshView()
	self:updateData()

	if self.taskInfo == nil then
		return;
	end
	local rewards = self.taskInfo.reward
	local costs = self.taskInfo.extendData.cost
	if costs == nil or rewards == nil then
		return;
	end

	local temp;
	for k,v in pairs(rewards) do
		temp={id=k, num=v}
		break;
	end
	if temp and temp.id and temp.num then
		local panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
		PrefabDataMgr:setInfo(panel_goodsItem, tonumber(temp.id), tonumber(temp.num))
		panel_goodsItem:setScale(0.75)
		panel_goodsItem:AddTo(self.Panel_Item.Reward1):Pos(0,0)
	end
	self.exchangeItemId = temp.id

	temp = nil
	for k,v in pairs(costs) do
		temp={id=k, num=v}
		break;	
	end
	if temp and temp.id and temp.num then
		panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
		PrefabDataMgr:setInfo(panel_goodsItem, tonumber(temp.id), tonumber(temp.num))
		panel_goodsItem:setScale(0.75)
		panel_goodsItem:AddTo(self.Panel_Item.Reward2):Pos(0,0)
	end

	self.costNum = temp.num
	self.costId = temp.id

	local year, month, day = Utils:getDate(self.activityInfo.showStartTime or 0)
	local format = TextDataMgr:getText(1410001)
	self.act_timeStart:setTextById(1410001,year, month, day)

	year, month, day = Utils:getDate(self.activityInfo.showEndTime or 0)
	self.act_timeEnd:setTextById(1410001,year, month, day)

	self.Label_Item_Count:setTextById(15010037, GoodsDataMgr:getItemCount(tonumber(self.costId)))

	self:updateRewardStatus()
end

function SzdyEntryView:onTaskReceiveEvent(actId,entry,reward)
	if actId == self.activityId then
		if table.count(reward) > 0 then
			Utils:showReward(reward)
		end		
		self:refreshView() 
	end
end

function SzdyEntryView:updateData()
	self.taskInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, self.activityInfo.items[1])
	
	if self.taskInfo == nil then
		return
	end
	self.taskProgress = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, self.taskInfo.id)	
end

function SzdyEntryView:updateRewardStatus()
	self.Panel_Item.Reward2.finish:setVisible(false)
	self.Panel_Item.Reward2.got:setVisible(false)
	self.Panel_Item.Reward2.touch:setVisible(false)
	if self.taskProgress == nil then
		return
	end
	if self.taskProgress.status == EC_TaskStatus.GETED then
		self.Panel_Item.Reward2.got:setVisible(true)
	else
		if self.costNum <= GoodsDataMgr:getItemCount(tonumber(self.costId)) then
			self.Panel_Item.Reward2.touch:setVisible(true)
			self.Panel_Item.Reward2.finish:setVisible(true)
		end
	end
end


return SzdyEntryView

--endregion
