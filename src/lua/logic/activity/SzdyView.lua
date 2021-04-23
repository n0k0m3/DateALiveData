--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local StepType = {
	None = 1,
	GoHead = 2,
	GoBack = 3,
	Item = 4,
	EndBox = 5,
	Dice   = 6,
	Start = 7
}
local DiceState = {
    IDLE = "i",
    START = "q",
    TURN = "z",
}
local StepCount = {
	300201,
	300202,
	300203
}

local SzdyView = class("SzdyView", BaseLayer)
function SzdyView:ctor(...)
	self.super.ctor(self)
	self:initData(...)
	self:init("lua.uiconfig.activity.szdyView")

	ActivityDataMgr2:requestSZQYData(self.activityId)
end

function SzdyView:initData(activityId,costCount)
	self.activityId = activityId or 2058
	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	dump(self.activityInfo)

	self.costItemId = self.activityInfo.extendData.itemId

	self.data = nil
	self.route = {}
	self.stepPath = {}

	self.stepIndex = 1
	self.intervalSpace = nil	
	self.stationPoint = nil
	self.firstRound = true
	self.resetAnimationPlaying = false
	self.surpriseRewards = nil

	self.btnEnabled = true

	self.speedScale = self.activityInfo.extendData.speed or 10000
	self.speedScale = self.speedScale / 10000
end

function SzdyView:initUI(ui)
	self.super.initUI(self, ui)
	self.closeBtn = TFDirector:getChildByName(ui, "Button_close")
	self.closeBtn:onClick(function()
		AlertManager:closeLayer(self)
	end)

	self.Prefab_Step = TFDirector:getChildByName(ui, "Prefab_Step")
	self.Prefab_Step.size = self.Prefab_Step:getSize()	

	self.Button_add = TFDirector:getChildByName(ui, "Button_add")

	self.Role = TFDirector:getChildByName(ui, "Role")
	self.Role:setScale(0.8)
	self.Role.Spine_role = TFDirector:getChildByName(self.Role, "Spine_role")
	self.Role.Spine_role:setTimeScale(self.speedScale)

	self.content = TFDirector:getChildByName(ui, "content")
	self.content.size = self.content:getSize()	

	self.Dice = TFDirector:getChildByName(ui, "Dice")
	self.Label_DiceNum = TFDirector:getChildByName(ui, "Label_DiceNum")
	self.Label_DiceNum :setText(0)
	self.RestoreTimeTag = TFDirector:getChildByName(ui, "RestoreTimeTag"):Hide()
	self.restoreTime = TFDirector:getChildByName(ui, "restoreTime")
	self.restoreTime:setText("")

	self.Panel_Surprise = TFDirector:getChildByName(ui, "Panel_Surprise"):show()
	self.Panel_Surprise.ShieldLayer = TFDirector:getChildByName(self.Panel_Surprise, "ShieldLayer"):Hide()
	self.Panel_Surprise.ShieldLayer:setTouchEnabled(true)
	self.Panel_Surprise.ShieldLayer:setSwallowTouch(true)
	self.Panel_Surprise.ShieldLayer:addMEListener(TFWIDGET_CLICK,function(widget)		
		widget:hide()
		self.Panel_Surprise.Panel_pray:setOpacity(0)
		self.Panel_Surprise.Panel_pray:hide()	
		self.Panel_Surprise.Spine_surprise:stopAllActions()
		self.Panel_Surprise.Spine_surprise:hide()
		if self.surpriseRewards and table.count(self.surpriseRewards) > 0 then
			Utils:showReward(self.surpriseRewards, nil, function()
				self.surpriseRewards = nil
				self:endRound()
			end)
		end
	end)
	self.Panel_Surprise.Panel_pray = TFDirector:getChildByName(self.Panel_Surprise, "Panel_pray"):show()
	self.Panel_Surprise.Panel_pray:setOpacity(0)	

	self.Panel_Surprise.Spine_surprise = TFDirector:getChildByName(self.Panel_Surprise, "Spine_surprise"):Hide()
	self.Panel_Surprise.Spine_surprise:addMEListener(
            TFARMATURE_COMPLETE,
            function(_, aniName)
                if aniName == "animation2" then
					self.Panel_Surprise.ShieldLayer:show()
					self.Panel_Surprise.Panel_pray:show()
					self.Panel_Surprise.Panel_pray:runAction(FadeIn:create(0.2))
					self.Panel_Surprise.Spine_surprise:play("animation", true)
                end
            end)

	self.intervalSpace = ccs(self.content.size.width / 8, self.content.size.height / 6)

	self.touch_mask = TFDirector:getChildByName(ui, "touch_mask")
	self.touch_mask:setTouchEnabled(true)
	self.touch_mask:setSwallowTouch(true)
	self:showToushShield(false)

	self.Panel_share = TFDirector:getChildByName(ui, "Panel_share")
	self.ScrollView_reward = UIListView:create( TFDirector:getChildByName(self.Panel_share, "ScrollView_reward"))

	self.Button_share = TFDirector:getChildByName(ui, "Button_share")
	self.Button_share:onClick(function()
		Utils:openView("activity.SzdyShareView", self.activityId)
	end)

	self.Button_throw = TFDirector:getChildByName(ui, "Button_throw")
	self.Button_throw.effect = TFDirector:getChildByName(self.Button_throw, "throwEffect")
	self.Button_throw.effect:addMEListener(
            TFARMATURE_COMPLETE,
            function(_, aniName)
                local state = aniName[#aniName]
                if state == DiceState.START then
					self:runDiceEffect(self:getDiceAnimation(self.stepData.step, DiceState.TURN))
                elseif state == DiceState.TURN then
                    self:runDiceEffect(self:getDiceAnimation(self.stepData.step, DiceState.IDLE),true)
					self:launch()
                end
            end
        )

	self.Spine_reset = TFDirector:getChildByName(ui, "Spine_reset")
	self.Spine_reset:setTimeScale(0.5)
	self.Spine_reset:addMEListener(
            TFARMATURE_EVENT, 
			function(...)
			    self.resetAnimationPlaying = false
				self:updateData()
			end)

	self:addShareReward()

	self:runDiceEffect(self:getDiceAnimation(1, DiceState.IDLE),true)

end

function SzdyView:addShareReward()
	self.ScrollView_reward:removeAllItems()
	local taskInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, self.activityInfo.items[2])
	local rewards = taskInfo.reward or {}
	for k, v in pairs( rewards) do
		local item = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
		PrefabDataMgr:setInfo(item, k, v)
		item:setScale(0.7)
		self.ScrollView_reward:pushBackCustomItem(item)
	end	
end

function SzdyView:getDiceAnimation(point, state)
    local name = "hong" .. point .. state
    return name
end

function SzdyView:registerEvents()
	self.super.registerEvents(self)
	EventMgr:addEventListener(self,EV_SZQY_RESP_MAIN_DATA,handler(self.newRound, self))
	EventMgr:addEventListener(self,EV_SZQY_RESP_STEP,handler(self.startStep, self))
	EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.updateSaiziNum, self))
	EventMgr:addEventListener(self, EV_RECONECT_EVENT, function()
		self:launch(true) 
	end)

	self.Button_throw:onClick(function()
		if self.btnEnabled == false or self.Panel_Surprise.Spine_surprise:isVisible() then
			return 
		end

		if self.resetAnimationPlaying == false then
			if GoodsDataMgr:getItemCount(self.costItemId) > 0 then
				self:showToushShield(true)
				self.btnEnabled = false
				self:timeOut(function() self.btnEnabled = true end, 0.5)
				ActivityDataMgr2:requestSZQYStep(self.activityId)				
			else
				Utils:showAccess(self.costItemId)
			end
		end
	end)

	self.Button_add:onClick(function()
		Utils:openView("activity.SzdyBuyView", self.costItemId)		
	end)
end

function SzdyView:getRewardConfig(config)
	local ret = {}
	for k, v in pairs(config.reward) do
		id=k
		num=v
		table.insert(ret, {id=id, num=num})
		break;
	end
	return ret
end

function SzdyView:getPositionByIdx(index)
	index = index - 1
	local x = index % 10 + 1	
	local y = math.floor(index / 10)

	return ccp(self.Prefab_Step.size.width / 2 + (x-1) * (self.intervalSpace.width + 1), self.content.size.height - self.Prefab_Step.size.height / 2 - y * (self.intervalSpace.height + 1.7))
end

function SzdyView:refreshView()
	self.route = {}			
	for i = 1,	#self.mapConfig.seat do 
		local pos = self:getPositionByIdx(self.mapConfig.seat[i])
		local stepIcon = self.Prefab_Step:clone()
		stepIcon:setPosition(pos)
		self.content:addChild(stepIcon,10)

		local config = TabDataMgr:getData("SpaceIncident", self.mapConfig.incident[i])

		self:initStep(stepIcon, config, i)

		local rewards = self:getRewardConfig(config)
		local temp = {idx = i, Icon = stepIcon, pos = pos, config = config, rewards= rewards}
		table.insert(self.route, temp)
	end

	self:resetRole()

	self:updateSaiziNum()
end

function SzdyView:initStep(item, config, idx)
	item.bg		= item:getChildByName("step_bg")
	item.item_pos	= item:getChildByName("item_pos")
	item.Icon		= item:getChildByName("Icon")
	item.item_num	= item:getChildByName("item_num")
	item.ImageGet	= item:getChildByName("get")
	item.stepTip	= item:getChildByName("stepTip"):hide()
	item.ImageGet:Hide()
	item.Icon:Hide()
	item.item_num:Hide()
	item.item_pos:Hide()
	item.bg:Show()

	local function __showReward()
		--item.Icon:Hide()
		item.item_pos:Show()
		local rewards = self:getRewardConfig(config)
		if rewards[1] then			
			item.reward = item:getChildByName("reward item")
			if item.reward then
				item.reward:removeFromParent()
				item.reward = nil
			end
			item.reward = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
			local frame = item.reward:getChildByName("Image_frame")
			frame:hide()

			PrefabDataMgr:setInfo(item.reward, rewards[1].id, rewards[1].num)
			item.reward:AddTo(item.item_pos):Pos(0, 0)
			item.reward:setScale(0.65)

			item.reward:setName("reward item")

			item.ImageGet:setVisible(not ActivityDataMgr2:checkReward(idx - 1))
		end
	end
	if config.type ==  StepType.None then
		item.Icon:setTexture(config.icon1)
		item.Icon:show()
	elseif config.type ==  StepType.GoHead then
		local text1 = TextDataMgr:getText(63854)
		local text2 = TextDataMgr:getText(StepCount[ math.abs(config.reward.step)])
		local text = string.format(text1, text2)
		item.stepTip:show()
		item.stepTip:setString(text)
	elseif config.type ==  StepType.GoBack then
		item.stepTip:show()
		local text1 = TextDataMgr:getText(63853)
		local text2 = TextDataMgr:getText(StepCount[ math.abs(config.reward.step)])
		local text = string.format(text1, text2)
		item.stepTip:show()
		item.stepTip:setString(text)
	elseif config.type ==  StepType.Item then
		__showReward()
	elseif config.type ==  StepType.EndBox then
		item.Icon:show()
		item.Icon:setTexture(config.icon1)
		__showReward()
	elseif config.type ==  StepType.Dice then
		item.Icon:show()
		item.Icon:setTexture(config.icon1)
	elseif config.type ==  StepType.Start then
		item.Icon:show()
		item.Icon:setTexture(config.icon1)
	end
end

function SzdyView:resetRole()
	self:stepToDirect(1)
	self.Role:show()
	self.Dice:show()
end

function SzdyView:newRound()
	for i = 1,	#self.route do 
		self.route[i].Icon:removeFromParent()
		self.route[i].Icon = nil
	end
	self.route = {}

	if self.firstRound then
		self:updateData()
		self:launch(true)
	else
		self.Role:hide()
		self.Dice:hide()
		self.Spine_reset:play("animation",false)
		self.resetAnimationPlaying = true
	end	
	self.firstRound =false
end

function SzdyView:updateData()
	self.data = ActivityDataMgr2:getSZQYData()
	dump(self.data) 

	self.mapConfig = TabDataMgr:getData("SpaceBreak",self.data.contractId).ext

	self:resetStepData()

	self:showToushShield(false)	

	self:refreshView()

	self:stepToDirect(self.data.location + 1)

	self:addTimerUpdate()
end

function SzdyView:startStep(data)
	dump(data)
	
	self:resetStepData()

	self.stepData = data
	if data == nil then
		print("时之契约单步数据为空!!!!!!")
		return
	end	

	if self.route[self.stationPoint] == nil then
		return
	end

	local curOrder = self.route[self.stationPoint].idx
	local locations = clone(data.locations)
	if data.tiggerClear == true and #locations > 0 then
		table.remove(locations, #locations)
	end
	for k,v in ipairs(locations or {}) do
		if v ~= 0 then
			local luaIdx = v + 1
			local offset = luaIdx - curOrder
			local _step = offset > 0 and 1 or -1
			for i=curOrder + _step, luaIdx, _step do
				table.insert(self.stepPath,  i)
			end
			curOrder = v + 1
		end
	end

	self.Label_DiceNum:setText(GoodsDataMgr:getItemCount(self.costItemId))

	if #self.stepPath == 0 then
		self:launch()
	else
		self:runDiceEffect(self:getDiceAnimation(self.stepData.step, DiceState.START))
	end	
end

function SzdyView:launch(force)
	if #self.stepPath == 0 then			
		self:doEvents(force)
		return
	end
	self:stopAllActions()

	self:stepTo(self.stepPath[self.stepIndex])
end

function SzdyView:stepTo(index)
	if nil == index then
		self.Role.Spine_role:play("idle", true)			
		self:doEvents()
		self:resetStepData()
		self:showToushShield(false)	
		return;
	end

	local action = {}
	table.insert(action, CallFunc:create(function()
			self.Role.Spine_role:play("jump",false)	
		end))
	table.insert(action, Spawn:create({MoveTo:create(0.3 * self.speedScale, self.route[index].pos), 
									   Sequence:create({DelayTime:create(0.1 * self.speedScale), CallFunc:create(function()
												TFAudio.playSound("sound/ui/effect_dafuweng_2.mp3")
											end)})}))
	table.insert(action, CallFunc:create(function()
			self:stepToDirect(index)	
		end))
	table.insert(action, DelayTime:create(0.4 * self.speedScale))
	table.insert(action, CallFunc:create(function()	
			self.stepIndex = self.stepIndex + 1
			self:stepTo(self.stepPath[self.stepIndex])
		end))
	self.Role:runAction(Sequence:create(action))
end

function SzdyView:stepToDirect(index)
	if index == nil or self.route[index] == nil then
		return;
	end
	local dstPoint = self.route[index].pos
	self.Role:setPosition(dstPoint)
	self.stationPoint = index
end

function SzdyView:resetStepData()
	self.stepIndex = 1
	self.stepPath = {}
	self.stepData = nil	
end

function SzdyView:doEvents(force)
	local route = self.route[self.stationPoint]
	if route == nil then
		return;
	end

	if self.stepData and self.stepData.triggerClear == true then		--触发获得全部事件
		self.surpriseRewards = clone(self.stepData.rewards)		
		self.Panel_Surprise.Spine_surprise:show()
		self.Panel_Surprise.Spine_surprise:play("animation2", false)
		return
	end

	local hadGot = ActivityDataMgr2:getCurrentRewards()
	if route.config.type == StepType.Item then
		if hadGot == false then
			Utils:showReward(route.rewards)
			route.Icon.ImageGet:setVisible(true)
		end
		ret = true
	elseif route.config.type == StepType.EndBox then
		if force then
			self:endRound()
		else
			Utils:showReward(route.rewards,nil,function()
				self:endRound()
			end)
		end
	end
end

function SzdyView:showToushShield(show)
	self.touch_mask:setVisible(not not show)
	self.doing = not not show
end

function SzdyView:endRound()
	ActivityDataMgr2:requestResetSZQY(self.activityId)
end

function SzdyView:addTimerUpdate()
    if self.timerUpdate_ then
        return
    end
    self.timerUpdate_ = TFDirector:addTimer(1000, -1, nil, handler(self.onCountDownPer,self))
end

function SzdyView:onCountDownPer(dt)
	self.RestoreTimeTag:Show()
	local itemRecoverCfg = StoreDataMgr:getItemRecoverCfg(30)
	local recoverTime = MainPlayer:getRecoverTime(6)
	local diceCount = GoodsDataMgr:getItemCount(self.costItemId)
	if recoverTime == 0 or diceCount >= itemRecoverCfg.maxRecoverCount then
		self.RestoreTimeTag:Hide()
	else	
		local serverTime = ServerDataMgr:getServerTime()
		
		local _, hour, min, sec = Utils:getDHMS( math.max(recoverTime + itemRecoverCfg.cooldown - serverTime, 0), true)
		self.restoreTime:setTextById(800026,hour, min, sec)
	end
	self:updateSaiziNum()
end

function SzdyView:runDiceEffect(aniName,loop)
	self.Button_throw.effect:play(aniName, loop)	
end

function SzdyView:removeEvents()
    if self.timerUpdate_ then
        TFDirector:removeTimer(self.timerUpdate_)
        self.timerUpdate_ = nil
    end
end
function SzdyView:updateSaiziNum()
	self.Label_DiceNum:setText(GoodsDataMgr:getItemCount(self.costItemId))
end


return SzdyView
--endregion
