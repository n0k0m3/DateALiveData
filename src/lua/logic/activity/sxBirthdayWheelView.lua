--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

local sxBirthdayWheelView =  class("sxBirthdayWheelView", BaseLayer)

local EventType = {
	Item = 1, --获取物品
	Dating = 2	--约会
}
local DatingEventId = 0		--约会事件ID
local WheelScale = 8		--转盘格子数量
local SpeedUpRound = 2		--减速前已经转的圈数
local MinInterval = 0.05	--最小时间间隔(最大速度)
local MaxInterval = 1		--最大时间间隔(最小速度)

local PosOffset = {1.5,1.5,1.5,1.5,1,1,0.5,0.5}

function sxBirthdayWheelView:ctor(...)
	self.super.ctor(self)
	self:showPopAnim(true)
	self:initData(...)
	self:init("lua.uiconfig.activity.sxBirthdayWheelView")
end


function sxBirthdayWheelView:initData(cityCid)
	self.cityCid_ = cityCid
	self.cityCfg_ = SxBirthdayDataMgr:getActivityCityCfg(self.cityCid_)
	self.costCid_, self.costNum_ = next(self.cityCfg_.cost)
	self.costCfg_ = GoodsDataMgr:getItemCfg(self.costCid_)

	self.tabInterval = {}
	self.tabIntervalPart1 = {0.5,0.45,0.3,0.15}	--初始化为加速时间段

	self.tabRewardsNode = {}
	self.events = {}
	for i=1,WheelScale do
		if i == WheelScale then
			table.insert(self.events, {index = i,	eventId = DatingEventId,  eventIcon = "ui/newCity/city_job/031.png", type = EventType.Dating})
		else
			local eventId = self.cityCfg_["event"][i]
			local eventCfg = SxBirthdayDataMgr:getTohkaEventCfg(eventId)
			print("eventId" .. eventId)
			table.insert(self.events, {index = i,	eventId = eventId,  eventIcon = eventCfg.eventIcon, type = EventType.Item})
		end
	end

	local speedUpNum = #self.tabIntervalPart1
	--匀速的时间
	for i=1, WheelScale * SpeedUpRound - speedUpNum do
		table.insert(self.tabIntervalPart1,	MinInterval)
	end
end

function sxBirthdayWheelView:initUI(ui)
	self.super.initUI(self, ui)

	self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
	self.Button_close = TFDirector:getChildByPath(ui, "Button_close")
	self.Btn_comfirm = TFDirector:getChildByPath(ui, "btn_comfirm")

	self.Image_bg =  TFDirector:getChildByPath(ui, "Image_bg")
	self.Image_bg:setTouchEnabled(true)
	self.Image_bg:setSwallowTouch(true)

	self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
	self.Panel_prefab:setTouchEnabled(true)
	self.Panel_prefab:setSwallowTouch(true)

	self.Panel_wheel = TFDirector:getChildByPath(ui, "Panel_wheel")
	self.wheel_rewards = TFDirector:getChildByPath(ui, "wheel_rewards")
	self.wheelHead = TFDirector:getChildByPath(ui, "wheelHead")
	self.runnerShow = TFDirector:getChildByPath(ui, "runnerShow")
	self.runnerHide = TFDirector:getChildByPath(ui, "runnerHide")

	self.Label_cost_num = TFDirector:getChildByPath(ui, "Label_cost_num")
	self.Image_cost_icon = TFDirector:getChildByPath(ui, "Image_cost_icon")
	self.Label_cost_num:setText(self.costNum_)
    self.Image_cost_icon:setTexture(self.costCfg_.icon)
    self.Image_cost_icon:Touchable(true)
    self.Image_cost_icon:onClick(function()
            Utils:showInfo(self.costCid_)
    end)

	self:initWheel()
end

function sxBirthdayWheelView:registerEvents()
	self.super.registerEvents(self)

	EventMgr:addEventListener(self, EV_SXBIRTHDAY_EXPLORE, handler(self.onExploreEvent, self))

	self.Button_close:onClick(function()
		AlertManager:closeLayer(self)
	end)
	self.Btn_comfirm:onClick(function()
		local count = GoodsDataMgr:getItemCount(self.costCid_)
        if count < self.costNum_ then
            if StoreDataMgr:canContinueBuyItemRecover(self.costCfg_.buyItemRecover) then
                Utils:openView("common.BuyResourceView", self.costCid_)
            else
                Utils:showTips(800021)
            end
        else
			SxBirthdayDataMgr:send_BIRTH_DAY_REQ_EXPLORE(self.cityCid_)
		end
	end)
end

function sxBirthdayWheelView:initWheel()
	for i=1, WheelScale do
		local rewardNode = TFDirector:getChildByPath(self.wheel_rewards, "reward"..i)	
		
		rewardNode.origin = ccp(rewardNode:getPositionX(), rewardNode:getPositionY() + PosOffset[i])
		rewardNode.eventData = self.events[i]

		rewardNode.Icon = TFDirector:getChildByPath(rewardNode, "icon")
		rewardNode.Icon:setTexture(rewardNode.eventData.eventIcon)
		rewardNode.Icon:setScale(0.8)
		table.insert(self.tabRewardsNode, rewardNode)
	end

	self:resetRunner(self.tabRewardsNode[1])
end

function sxBirthdayWheelView:resetRunner(rewardNode)
	self.runnerShow:setPosition(rewardNode.origin)
	self.runnerShow.origin = rewardNode.origin

	self.runnerHide:setPosition(rewardNode.origin)
	self.runnerHide.origin = rewardNode.origin

	self.runnerShow.eventData = rewardNode.eventData
	self.runnerHide.eventData = rewardNode.eventData
end

function sxBirthdayWheelView:launchWheel(eventID)
	self.Panel_prefab:setVisible(true)

	self:resetRunner(self.runnerShow)
	self:calculateStayPos(eventID)
	self:WheelRun()
end

function sxBirthdayWheelView:WheelRun()
	local step = 0
	local function funcMoveTo(rewardNode)
		step = step + 1
		local delay = self.tabInterval[step]
		if delay == nil then
			if self.funcExplore then
				self:runAction(Sequence:create({DelayTime:create(0.5), CallFunc:create(function()
					self:funcExplore()
					self.funcExplore = nil
					self.Panel_prefab:setVisible(false)
				end)}))		
			end
			return
		end

		local idx = rewardNode.eventData.index +1
		if idx > WheelScale then
			idx = 1
		end
		local node = self.tabRewardsNode[idx]
		local a_sq = Sequence:create({MoveTo:create(delay, node.origin), CallFunc:create(function()	
				Utils:playSound(5006)
				self:resetRunner(node)	
				funcMoveTo(node)
		end)})
		self.runnerHide:runAction(a_sq)
	end

	funcMoveTo(self.tabRewardsNode[self.runnerShow.eventData.index])
end

function sxBirthdayWheelView:calculateStayPos(eventId)
	self.tabInterval = {}
	for i = 0, #self.tabIntervalPart1 do
		table.insert(self.tabInterval, self.tabIntervalPart1[i])
	end

	local targetReward;
	for k, v in pairs(self.tabRewardsNode) do
		local eventData = v.eventData
		if eventId == eventData.eventId then
			targetReward = v
			break;
		end
	end

	--计算目标奖励距离当前位置的格子需要移动的格子数量
	local indexOffset = (targetReward.eventData.index - self.runnerShow.eventData.index + WheelScale) % WheelScale

	--距离太短就多转一圈，不然突然减速到0显得太突兀
	if indexOffset < WheelScale / 2 then
		indexOffset = indexOffset + WheelScale
	end

	--减速的时间段
	local tabIntervalPart2 = {}
	--求二次函数的二次项常数
	local rake = (MaxInterval - MinInterval) / ( indexOffset * indexOffset)
	for i=1, indexOffset do
		table.insert(tabIntervalPart2,	0.7*rake * (i * i) + MinInterval)		
	end
	for i = 0, #tabIntervalPart2 do
		table.insert(self.tabInterval, tabIntervalPart2[i])
	end
end

function sxBirthdayWheelView:onExploreEvent(eventCid, rewards)
    local eventCfg = SxBirthdayDataMgr:getTohkaEventCfg(eventCid)
    if eventCfg.type == EventType.Item then
		self.funcExplore = function()
			Utils:openView("activity.SxBirthdayRewardView", self.cityCid_, eventCid, rewards)
		end
		self:launchWheel(eventCid)
    elseif eventCfg.type == EventType.Dating then
		self.funcExplore = function()			
			Utils:openView("activity.SxBirthdayDatingView", eventCid)
			AlertManager:closeLayer(self)
		end
		self:launchWheel(DatingEventId)
    end
end

return sxBirthdayWheelView

--endregion
