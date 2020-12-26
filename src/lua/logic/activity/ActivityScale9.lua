--code by zpc
--2019/12/17

local ActivityScale9 = class("ActivityScale9", BaseLayer)
local uiPath = "lua.uiconfig.activity.scale9Activity"

function ActivityScale9:ctor(...)
	self.super.ctor(self, ...)

	self.activityID = ...
	self.selectTask = nil

	self.data_ = ActivityDataMgr2:getActivityInfo(self.activityID)
	dump(self.data_)
	if self.data_ == nil then
		return
	end
	self.data = self.data_.extendData

	EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, function(activityID, activitEntryId, rewards)
		if activityID == self.activityID then		
			local curIdx = table.indexOf(self.data.chestId, activitEntryId)
			if curIdx ~= -1 then
				local stringId = self.data.stringId or {}
				local showId = stringId[curIdx]
				Utils:showReward(rewards, nil, nil, showId)
			end
		end	
	end)

	self:init(uiPath);
end


function ActivityScale9:initUI(ui)
	self.super.initUI(self, ui)
	
	self.root = ui:getChildByName("Panel_root")
	self.uiGrids = self.root:getChildByName("Grids")
	self.uiRewards = self.root:getChildByName("Rewards")
	self.activityTime = self.root:getChildByName("activityTime")
	self.txt_desc = TFDirector:getChildByPath(ui,"txt_desc")
	self.txt_desc:setText(Utils:MultiLanguageStringDeal(self.data.des1))

	self.activityTime:setText(Utils:getActivityDateString(self.data_.startTime, self.data_.endTime, self.data_.extendData.dateStyle))
	
	local taskid = self.data.taskId

	self.scale9list = {}
	for i = 1, 9 do
		local gridBox = self.uiGrids:getChildByName("grid"..i)
		local config = ActivityDataMgr2:getItemInfo(self.data_.activityType,taskid[i])
		table.insert(self.scale9list, gridBox)
		gridBox.config	= config
		gridBox.hexagon = gridBox:getChildByName("hexagon")	
		gridBox.index	= gridBox.hexagon:getChildByName("index")	
		gridBox.task	= gridBox:getChildByName("task")
		gridBox.des		= gridBox.task:getChildByName("taskDescript")
		gridBox.state	= gridBox:getChildByName("taskState")	
		gridBox.btnFight= gridBox:getChildByName("btn_goto")
		gridBox.finish	= gridBox:getChildByName("finish")	

--		gridBox.showTask = true

		gridBox.hexagon:setVisible(true)
		gridBox.task:setVisible(false)
		gridBox.finish:setVisible(false)

		gridBox.index:setText(i)
		gridBox.des:setText(Utils:MultiLanguageStringDeal(config.extendData.des2))
		gridBox.state:setText("0/0")

		gridBox:setTouchEnabled(true)
		gridBox:addMEListener(TFWIDGET_CLICK, function()
			if gridBox.status == EC_TaskStatus.ING then
				if self.selectTask then
					self.selectTask.task:setVisible(false)
					self.selectTask.hexagon:setVisible(true)
					self.selectTask.click = false
				end
				gridBox.task:setVisible(true)
				gridBox.hexagon:setVisible(false)
				gridBox.click = true

				self.selectTask = gridBox
			elseif gridBox.status == EC_TaskStatus.GET then
				--todo send
				ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityID, config.id)
			end
		end)
		gridBox.btnFight:onClick(function()
            FunctionDataMgr:enterByFuncId(config.extendData.jumpInterface,config.extendData.parameter)
		end)	
	end

	
	local chestId = self.data.chestId
	self.rewards = {}
	for i = 1, 7 do
		local rewardBox = self.uiRewards:getChildByName("reward"..i)
		rewardBox.giftIcon = rewardBox:getChildByName("giftIcon")
		rewardBox.btnCheck = rewardBox:getChildByName("check")
		rewardBox.btnLabel = rewardBox.btnCheck:getChildByName("image_label")
		rewardBox.index	   = i
		table.insert(self.rewards, rewardBox)

		local config = ActivityDataMgr2:getItemInfo(self.data_.activityType,chestId[i])
		rewardBox.config = config
		rewardBox.status = EC_TaskStatus.GET

		rewardBox.reward = {}
		for k,v in pairs(config.reward) do
			table.insert(rewardBox.reward, {id = k,num = v})
		end
		
		local function callback_()
			if rewardBox.status == EC_TaskStatus.ING then
				Utils:previewReward(nil,rewardBox.reward)
			elseif rewardBox.status == EC_TaskStatus.GET then
				--todo sendGetMsg
				ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityID, config.id )
			elseif rewardBox.status == EC_TaskStatus.GETED then
				Utils:showTips(213502)
			end
		end
		
		rewardBox.btnCheck:onClick(function()
			callback_()
		end)
		rewardBox:setTouchEnabled(true)	
		rewardBox:addMEListener(TFWIDGET_CLICK, callback_)
	end

	self:refreshView()
end

function ActivityScale9:onShow()
	self.super.onShow(self)
	
end


--function ActivityScale9:onData(recieve)
--	if recieve == nil then
--		return;
--	end
--	self.data = recieve

--	self:refreshView(recieve)
--end

function ActivityScale9:refreshView()
	self:refreshGrid()
	
	self:refreshReward()
end



function ActivityScale9:refreshGrid()
	for i = 1, #self.scale9list do
		local ui = self.scale9list[i]
		local des = ui:getChildByName("taskDescript")
		local labelProcess = ui:getChildByName("taskState")
		local btnGoto = ui:getChildByName("btn_goto")

		local progress = ActivityDataMgr2:getProgressInfo(self.data_.activityType, ui.config.id)

		labelProcess:setText(progress.progress.."/"..ui.config.target)

		ui:setVisible(progress["status"] ~= EC_TaskStatus.GETED)
		
		ui.btnFight:setVisible(ui.config.extendData.jumpInterface and ui.config.extendData.jumpInterface > 0 )


		if progress["status"] == EC_TaskStatus.ING then
			ui.hexagon:setVisible(not ui.click)
			ui.task:setVisible(ui.click)
			ui.finish:setVisible(false)
			ui:setVisible(true)
		elseif progress["status"] == EC_TaskStatus.GET then
			ui.hexagon:setVisible(false)
			ui.task:setVisible(false)
			ui.finish:setVisible(true)
			ui:setVisible(true)
		elseif progress["status"] == EC_TaskStatus.GETED then
			ui.hexagon:setVisible(false)
			ui.task:setVisible(false)
			ui.finish:setVisible(false)
			ui:setVisible(false)
		end

		ui.status = progress.status	
	end
end

function ActivityScale9:refreshReward(gridData)
	local girdNum = #self.scale9list
	for i = 1, #self.rewards do
		local rewardBox = self.rewards[i]

		local progress = ActivityDataMgr2:getProgressInfo(self.data_.activityType, rewardBox.config["id"])

		self:setRewardBoxState(rewardBox, progress.status)

		rewardBox.status = progress.status		
	end
end

function ActivityScale9:setRewardBoxState(rewardBox, status)
	if status == EC_TaskStatus.ING then
		if rewardBox.index < 7 then
			rewardBox:setTexture("ui/activity/activityScale9/check_bg_small.png")
			rewardBox.giftIcon:setTexture("ui/activity/activityScale9/check_libao_small.png")
			rewardBox.btnCheck:setTextureNormal("ui/activity/activityScale9/check_biaoqian_small.png")
			rewardBox.btnLabel:setTexture("ui/activity/activityScale9/check_check_small.png")
		else
			rewardBox:setTexture("ui/activity/activityScale9/check_bg_big.png")
			rewardBox.giftIcon:setTexture("ui/activity/activityScale9/check_libao_big.png")
			rewardBox.btnCheck:setTextureNormal("ui/activity/activityScale9/check_biaoqian_big.png")
			rewardBox.btnLabel:setTexture("ui/activity/activityScale9/check_check_big.png")
		end

	elseif status == EC_TaskStatus.GET then
		if rewardBox.index < 7 then
			rewardBox:setTexture("ui/activity/activityScale9/reach_bg_small.png")
			rewardBox.giftIcon:setTexture("ui/activity/activityScale9/reach_libao_small.png")
			rewardBox.btnCheck:setTextureNormal("ui/activity/activityScale9/reach_biaoqian_small.png")
			rewardBox.btnLabel:setTexture("ui/activity/activityScale9/reach_get_small.png")
		else
			rewardBox:setTexture("ui/activity/activityScale9/reach_bg_big.png")
			rewardBox.giftIcon:setTexture("ui/activity/activityScale9/reach_libao_big.png")
			rewardBox.btnCheck:setTextureNormal("ui/activity/activityScale9/reach_biaoqian_big.png")
			rewardBox.btnLabel:setTexture("ui/activity/activityScale9/reach_get_big.png")
		end

	elseif  status == EC_TaskStatus.GETED then
		if rewardBox.index < 7 then
			rewardBox:setTexture("ui/activity/activityScale9/got_bg_small.png")
			rewardBox.giftIcon:setTexture("ui/activity/activityScale9/got_libao_small.png")
			rewardBox.btnCheck:setTextureNormal("ui/activity/activityScale9/got_biaoqian_small.png")
			rewardBox.btnLabel:setTexture("ui/activity/activityScale9/got_get_small.png")
		else
			rewardBox:setTexture("ui/activity/activityScale9/got_bg_big.png")
			rewardBox.giftIcon:setTexture("ui/activity/activityScale9/got_libao_big.png")
			rewardBox.btnCheck:setTextureNormal("ui/activity/activityScale9/got_biaoqian_big.png")
			rewardBox.btnLabel:setTexture("ui/activity/activityScale9/got_get_big.png")
		end
	
	end
end

function ActivityScale9:onUpdateProgressEvent()
	self:refreshView()
end



return ActivityScale9


