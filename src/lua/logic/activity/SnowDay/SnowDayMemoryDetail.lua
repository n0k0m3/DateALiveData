
local SnowDayMemoryDetail = class("SnowDayMemoryDetail", BaseLayer)

function SnowDayMemoryDetail:ctor(...)
	self.super.ctor(self)
	self:initData(...)
	self:showPopAnim(true)
	self:init("lua.uiconfig.activity.snowDayMemoryDetail")
end

function SnowDayMemoryDetail:initData(activityId, cfg_Id)
	self.activityId = activityId
	self.cfg_Id = cfg_Id
	self:updateData()
end

function SnowDayMemoryDetail:updateData()
	self.activityData = ActivityDataMgr2:getActivityInfo(self.activityId)

	self.itemInfo = ActivityDataMgr2:getItemInfo(self.activityData.activityType, self.cfg_Id)
	dump(self.itemInfo)

	self.progressInfo = ActivityDataMgr2:getProgressInfoWithoutDefault(self.activityData.activityType, self.cfg_Id)
	--dump(self.progressInfo)

	local id, num  = next(self.itemInfo.extendData.taskCost or {})
	self.taskCost = {id=tonumber(id),num=num}
	dump(self.taskCost)
end

function SnowDayMemoryDetail:initUI(ui)
	self.super.initUI(self, ui)
	self.Label_title = TFDirector:getChildByPath(ui, "Label_title")
	self.Label_title:setText(self.itemInfo.extendData.des)

	self.Button_close = TFDirector:getChildByPath(ui, "Button_close")
	self.Button_close:onClick(function() AlertManager:closeLayer(self) end)

	self.Label_Descript = TFDirector:getChildByPath(ui, "Label_Descript")
	self.Label_Descript:setText(self.itemInfo.extendData.des2)

	self.HeadIcon = TFDirector:getChildByPath(ui, "HeadIcon")
	self.Image_CG = TFDirector:getChildByPath(ui, "Image_CG")
	

	self.Label_tip_bright_bg = TFDirector:getChildByPath(ui, "Label_tip_bright_bg"):hide()
	self.Label_tip_lock = TFDirector:getChildByPath(ui, "Label_tip_lock"):hide()
	self.Image_Item = TFDirector:getChildByPath(ui, "Image_Item")
	self.RewardArr = UIListView:create( TFDirector:getChildByPath(ui, "RewardArr"))

	self.PanelCost = TFDirector:getChildByPath(ui, "PanelCost"):hide()
	self.Label_cost = TFDirector:getChildByPath(self.PanelCost, "Label_cost")
	if self.itemInfo.extendData.type == 2 then
		self.Label_cost:setTextById(500022, tonumber(self.taskCost.num or 0))
		self.ImageCost = TFDirector:getChildByPath(self.PanelCost, "ImageCost")
		local item = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone():show()
		item:setPosition(0,0)
		item:setScale(0.75)
		PrefabDataMgr:setInfo(item, tonumber(self.taskCost.id or 0), nil)
		self.ImageCost:addChild(item)
	end

	self.Button_enter = TFDirector:getChildByPath(ui, "Button_enter"):hide()
	self.Button_enter:onClick(function()	
		ActivityDataMgr2:sendEnterSnowMemory(self.itemInfo.id)
	end)
	self.Button_commit = TFDirector:getChildByPath(ui, "Button_commit"):hide()
	self.Button_commit:onClick(function()
		if self.itemInfo.extendData.type == 2 then
			if not RechargeDataMgr:currencyIsEnough({self.taskCost})then
				Utils:showInfo(self.taskCost.id)
				return
			end
		end
		ActivityDataMgr2:sendEnterSnowMemory(self.itemInfo.id)
	end)

	self.Panel_Head = TFDirector:getChildByPath(ui, "Panel_Head"):hide()
	self.Panel_CG = TFDirector:getChildByPath(ui, "Panel_CG"):hide()

	self.Button_CallBack = TFDirector:getChildByPath(ui, "Button_CallBack"):hide()
	self.Button_CallBack:onClick(function()
		DatingDataMgr:startDating(self.itemInfo.extendData.datingScriptId)
	end)

	self:refreshView()
	self:addReward()
end

function SnowDayMemoryDetail:refreshView()
	self.Label_tip_bright_bg:hide()
	self.Button_commit:hide()
	self.Button_enter:hide()
	self.Image_Item:hide()
	self.PanelCost:hide()
	self.Panel_Head:hide()
	self.Panel_CG:hide()

	
	if self.itemInfo.extendData.type == 2 then --小型回忆
		
		self.Panel_Head:show()
		self.HeadIcon:setTexture(self.itemInfo.extendData.iconShow or "")
	else
		self.Panel_CG:show()
		self.Image_CG:setTexture(self.itemInfo.extendData.iconShow or "")
	end

	if self.progressInfo == nil then
		self.Image_Item:show()
		self.Label_tip_lock:show()
		return
	end


	if self.progressInfo.status == EC_TaskStatus.GETED then		
		if self.itemInfo.extendData.type == 2 then--小型回忆
			self.Panel_Head:show()
			self.Label_tip_bright_bg:show()						
		else
			self.Button_CallBack:show()
			self.Panel_CG:show()
		end
	else
		self.Image_Item:show()
		if self.itemInfo.extendData.type == 2 then--小型回忆
			self.Button_commit:show()
			self.PanelCost:show()
			self.Panel_Head:show()
		else
			self.Button_enter:show()
			self.Panel_CG:show()
		end			
	end		
end

function SnowDayMemoryDetail:update(data)
	self:updateData()
	self:refreshView()
	dump(data)
	if self.itemInfo.extendData.type == 1 then		
		if data.status == 0 then	--进入游戏
			Utils:openView("activity.SnowDay.SnowDayLittleGame2",self.itemInfo.extendData)
		elseif data.status == 1 then
			if not AlertManager:getLayerBySpecialName("SnowDayLittleGame") then
				self.Button_enter:setTouchEnabled(false)
				self:runAction(Sequence:create({DelayTime:create(2), CallFunc:create(function()
					self.Button_enter:setTouchEnabled(true)
				end)}))
				DatingDataMgr:startDating(self.itemInfo.extendData.datingScriptId)
			end		
		end
	end	
	local reward = data.reward or {}
	if table.count(reward) > 0 then
		Utils:showReward(reward)
	end
end

function SnowDayMemoryDetail:addReward()
	self.RewardArr:removeAllItems()
	local rewards = self.itemInfo.reward or {}
	for key, num in pairs(rewards) do
		local item = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone():show()
		PrefabDataMgr:setInfo(item, key, num)
		item:setScale(0.65)
		self.RewardArr:pushBackCustomItem(item)
	end
end

function SnowDayMemoryDetail:updateView()
	self:updateData()
	self:refreshView()
end

function SnowDayMemoryDetail:registerEvents()
	self.super.registerEvents(self)
	EventMgr:addEventListener(self, EV_ICE_SNOW_LEVEL_DETAIL, handler(self.update, self))
	EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.updateView, self))
end

return SnowDayMemoryDetail