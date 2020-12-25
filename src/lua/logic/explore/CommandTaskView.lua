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
local CommandTaskView = class("CommandTaskView",BaseLayer)

function CommandTaskView:ctor( data )
	self.super.ctor(self,data)
	self.roomType = ShipRoomType.COMMAND
	self.pageIndex = ExploreDataMgr:getPageIndex(self.roomType, "CommandTaskView")
	self:addTopBar()
	self:init("lua.uiconfig.explore.commandTask")
end

function CommandTaskView:onShow(  )
	-- body
	self.super.onShow(self)
	if not self.hasPlayEffect then
		self.Panel_show:hide()
		self.topBar:hide()
		self.hasPlayEffect = true
		self.ui:timeOut(function ( ... )
			-- body
  			self:updateTaskList()
			self:playEffect( ... )
		end)
	end
	GameGuide:checkGuide(self)
end

function CommandTaskView.checkTaskRedPoint( taskData )
	-- body
	return ExploreDataMgr:checkTaskRedPoint(taskData)
end

function CommandTaskView:playEffect( ... )
	-- body
	self.Spine_effect:show()
	self.Spine_effect1:show()
	self.Spine_effect:addMEListener(TFARMATURE_EVENT,
            function()
            		self.Panel_show:show()
            		self.topBar:show()
					ViewAnimationHelper.doMoveFadeInAction(self.Panel_show, {direction = 1, distance = 0, ease = 2, delay = 0.1, time = 0.2})
               		self.topBar:showAnim()
               	end)


	self.Spine_effect:addMEListener(TFARMATURE_COMPLETE,
	            function()
						self.Spine_effect:removeMEListener(TFARMATURE_COMPLETE)
					end)
	self.Spine_effect:play("pingmu_xia",false)
	Utils:playSound(5053)

	self.Spine_effect1:addMEListener(TFARMATURE_COMPLETE,
	            function()
						self.Spine_effect1:removeMEListener(TFARMATURE_COMPLETE)
						self.Spine_effect1:hide()
					end)
	self.Spine_effect1:play("pingmu_shang",false)
end

function CommandTaskView:initData()
	self.roomData = ExploreDataMgr:getCabinData(self.roomType)
	self.roomCfg, self.roomDetailCfg, self.stageCfg = ExploreDataMgr:getCabinCfg(self.roomType)

	self.taskLists = clone(self.roomData.task) or {}
	table.sort(self.taskLists, function(v1, v2)
		local taskCfg1 = TabDataMgr:getData("ExploreTask", v1.id)
		local taskCfg2 = TabDataMgr:getData("ExploreTask", v2.id)
		if taskCfg1.quality == taskCfg2.quality then
			return v1.id < v2.id
		else
			return taskCfg1.quality > taskCfg2.quality
		end
	end)
	self.selectIdx = self.selectIdx or 1
	if self.selectIdx > #self.taskLists then
		self.selectIdx = 1
	end
end

function CommandTaskView:addTopBar()
	self.topBar = requireNew("lua.logic.explore.CommonTopBar"):new(self.roomType, self.pageIndex)
	self:addChild(self.topBar,100)
end

function CommandTaskView:initUI(ui)
	self.super.initUI(self,ui)

	self.Panel_show = TFDirector:getChildByPath(ui,"Panel_show")
	self.Spine_effect = TFDirector:getChildByPath(ui,"Spine_effect")
	self.Spine_effect1 = TFDirector:getChildByPath(ui,"Spine_effect1"):hide()

	self.button_paiqian = TFDirector:getChildByPath(ui,"button_paiqian")
	self.button_acceleration = TFDirector:getChildByPath(ui,"button_acceleration")
	self.button_getAward = TFDirector:getChildByPath(ui,"button_getAward")
	self.Label_gettedAward = TFDirector:getChildByPath(ui,"Label_gettedAward")

	self.Image_condition = TFDirector:getChildByPath(ui,"Image_condition")
	self.Label_condition_tip = TFDirector:getChildByPath(ui,"Label_condition_tip")

	self.Label_taskdes = TFDirector:getChildByPath(ui,"Label_taskdes")
	self.Image_rule1 = TFDirector:getChildByPath(ui,"Image_rule1")
	self.Image_rule1_s = TFDirector:getChildByPath(ui,"Image_rule1_s")
	self.Image_rule2 = TFDirector:getChildByPath(ui,"Image_rule2")
	self.Image_rule2_s = TFDirector:getChildByPath(ui,"Image_rule2_s")
	self.Label_name = TFDirector:getChildByPath(ui,"Label_name")
	self.Image_curTask_Icon = TFDirector:getChildByPath(ui,"Image_curTask_Icon")

	self.Button_cost = TFDirector:getChildByPath(ui, "Button_cost"):hide()
	self.Label_costNum = TFDirector:getChildByPath(self.Button_cost, "Label_costNum")
	self.Image_costIcon = TFDirector:getChildByPath(self.Button_cost, "Image_costIcon")
	self.Label_cost = TFDirector:getChildByPath(self.Button_cost, "Label_cost")
	self.Label_cost:setTextById(300020)
	self.Label_timming = TFDirector:getChildByPath(ui, "Label_timming"):hide()

	local ScrollView_task = TFDirector:getChildByPath(ui,"ScrollView_task")
	self.uiList_task = UIListView:create(ScrollView_task)
	self.ScrollView_reward = TFDirector:getChildByPath(ui,"ScrollView_reward")
	self.ScrollView_EXreward = TFDirector:getChildByPath(ui,"ScrollView_EXreward")
	self.Panel_taskItem = TFDirector:getChildByPath(ui,"Panel_taskItem")
	self.Panel_sitItem = TFDirector:getChildByPath(ui,"Panel_sitItem")
	self.Panel_working = TFDirector:getChildByPath(ui,"Panel_working")
	self.Panel_finished = TFDirector:getChildByPath(ui,"Panel_finished")

	self.Button_oneKeyAction = TFDirector:getChildByPath(ui,"Button_oneKeyAction")
	self.Button_oneKeyGet = TFDirector:getChildByPath(ui,"Button_oneKeyGet")

	self.Image_6 = TFDirector:getChildByPath(ui,"Image_6")
	self.Image_3 = TFDirector:getChildByPath(ui,"Image_3")
	self.Label_tip1 = TFDirector:getChildByPath(ui,"Label_tip1")
	self.Label_tip2 = TFDirector:getChildByPath(ui,"Label_tip2")


	local ScrollView_sit = TFDirector:getChildByPath(ui,"ScrollView_sit")
	self.uiList_sit = UIListView:create(ScrollView_sit)
	self:refreshView()
end

function CommandTaskView:registerEvents(ui)
	self.super.registerEvents(self,ui)
	EventMgr:addEventListener(self, EV_EXPLORE_CABIN_TASK_REFRESH, handler(self.refreshView, self))
    EventMgr:addEventListener(self, EV_EXPLORE_CHOOSE_HERO, handler(self.onChooseEvent, self))
    EventMgr:addEventListener(self, EV_EXPLORE_CABIN_REFRESH, handler(self.refreshView, self))

	self.button_paiqian:onClick(function()
		local selectTask = self:getSelectTaskInfo()
		if not selectTask then return end
		if not selectTask.tmpHeroId or #selectTask.tmpHeroId <= 0 then
			--没有派遣的精灵
			Utils:showTips(13311249)
			return
		end

		if not self:checkCondition( ) then
			Utils:showTips(13311250)
			return
		end

		ExploreDataMgr:SEND_EXPLORE_EXPLORE_TASK_DEAL(selectTask.id, selectTask.tmpHeroId)
	end)

	self.button_acceleration:onClick(function()
		local selectTask = self:getSelectTaskInfo()
		if not selectTask then return end
		local taskCfg = TabDataMgr:getData("ExploreTask", selectTask.id)
		local costId, costNum
		for id, num in pairs(taskCfg.fastFinishCost) do
            costId = id
            costNum = num
            break
        end

        local costIcon = TabDataMgr:getData("Item", costId).icon
        local rstr = TextDataMgr:getTextAttr(13311252)
        local formatStr = rstr and rstr.text or ""
        local content = string.format(formatStr, costNum, costIcon)
        Utils:openView("common.ReConfirmTipsView", {tittle = 13311251, content = content, confirmCall = function()
        	ExploreDataMgr:SEND_EXPLORE_EXPLORE_TASK_ACCELERATION(selectTask.id)
        end})
	end)

	self.button_getAward:onClick(function()
		local selectTask = self:getSelectTaskInfo()
		if not selectTask then return end
		ExploreDataMgr:SEND_EXPLORE_EXPLORE_TASK_GET_AWARD(selectTask.id)
	end)

	self.Button_cost:onClick(function(sender)
		if sender.id then
			Utils:showInfo(sender.id)
		end
	end)
	self:addCountDownTimer()

	self.Button_oneKeyGet:onClick(function ( ... )
		-- body
		ExploreDataMgr:Send_EXPLORE_REQ_GET_ALL_AFK_TASK_AWARD()
	end)

	self.Button_oneKeyAction:onClick(function ( ... )
		-- body
		local taskInfos = ExploreDataMgr:getCacheTaskPlan()
		if #taskInfos > 0 then
			Utils:openView("explore.OneKeyActionTaskView")
		else
			Utils:showTips(13322054)
		end
	end)
end

function CommandTaskView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.onCountDownPer, self))
    end
end

function CommandTaskView:onCountDownPer()
	local selectTask = self:getSelectTaskInfo()
	if not selectTask then return end
	local data = TabDataMgr:getData("ExploreTask", selectTask.id)

	if not selectTask.startTime then
		self.Label_timming:hide()
		return
	end

	local remaindTime = selectTask.startTime + data.costTime - ServerDataMgr:getServerTime()
	if remaindTime <= 0 and selectTask.state == 1 then
		selectTask.state = 2
		self:updateTaskInfo()
	end
	if selectTask.state ~= 1 then
		self.Label_timming:hide()
		return
	end

	self.Label_timming:show()

	local serverTime = ServerDataMgr:getServerTime()
	local remainTime = math.max(0, selectTask.startTime + data.costTime - serverTime)
	local day, hour, min, sec = Utils:getTimeDHMZ(remainTime, true)
	local timeStr = ""
	if day == "00" then
		timeStr = TextDataMgr:getText(1260001, hour, min)
	else
		timeStr = TextDataMgr:getText(800069, day, hour)
	end
	self.Label_timming:setText(timeStr)
end

function CommandTaskView:refreshView( ... )
	self:initData()
	self:updateTaskList()
	self:updateSitList()
	self:updateTaskInfo()
	ExploreDataMgr:Send_EXPLORE_REQ_EXPLORE_TASK_PLAN()
end

function CommandTaskView:updateSitList()
	local selectTask = self:getSelectTaskInfo()
	if not selectTask then return end
	local maxSit = 3
	for i = 1, maxSit do
		local item = self.uiList_sit:getItem(i)
		if not item then
			item = self.Panel_sitItem:clone()
			self.uiList_sit:pushBackCustomItem(item)
			item:setName("sit"..i)
		end
		item.index = i
		if (selectTask.state == 1 or selectTask.state == 2) and not selectTask.tmpHeroId[i] then
			--派遣中
			item:hide()
		else
			item:show()
			self:updateSitItem(item, i, selectTask.tmpHeroId[i])
		end
	end
	self.uiList_sit:doLayout()
	self.uiList_sit:setCenterArrange()

end

function CommandTaskView:updateSitItem(item, idx, roleId)
	local selectTask = self:getSelectTaskInfo()
	local Panel_empty = TFDirector:getChildByPath(item,"Panel_empty")
	local Spine_effect = TFDirector:getChildByPath(Panel_empty,"Spine_effect")
	Spine_effect:play("animation",true)
	
	local Panel_role = TFDirector:getChildByPath(item,"Panel_role")
	local Panel_finish = TFDirector:getChildByPath(item,"Panel_finish")
	local Image_halfIcon = TFDirector:getChildByPath(Panel_role,"Image_halfIcon")
	local Image_roleBg = TFDirector:getChildByPath(Panel_role,"Image_roleBg")
	local Image_quality = TFDirector:getChildByPath(Panel_role,"Image_quality")

	local selectTask = self:getSelectTaskInfo()

	Panel_empty:setVisible(selectTask.state ~= 3 and not roleId)
	Panel_role:setVisible(selectTask.state ~= 3 and roleId)
	Panel_finish:setVisible(selectTask.state == 3)

	if roleId then
		local heroData = HeroDataMgr:getHero(roleId)
        local skinData = TabDataMgr:getData("HeroSkin", heroData.skinCid)
		Image_halfIcon:setTexture(skinData.teamPic)
		Image_roleBg:setTexture(skinData.backdrop)
		Image_halfIcon:setPosition(ccp(skinData.pos.x,skinData.pos.y))
		Image_halfIcon:setPosition(ccp(skinData.pos.x,skinData.pos.y))
		Image_halfIcon:setScale(skinData.pos.scale*0.5)
		Image_quality:setTexture(HeroDataMgr:getQualityPic(roleId))
	end

	item:setTouchEnabled(true)
	if selectTask.state == 1 or selectTask.state == 2 then
		item:setTouchEnabled(false)
	end
	item:onClick(function()
		local data = TabDataMgr:getData("ExploreTask", selectTask.id)
		Utils:openView("explore.CommandTaskSelectView", roleId, selectTask.tmpHeroId)
	end)
end

function CommandTaskView:onChooseEvent(isUp, heroId, replaceHeroId)
	local selectTask = self:getSelectTaskInfo()
	if not selectTask or not heroId then return end

	if isUp then
		if replaceHeroId then
			local index = table.indexOf(selectTask.tmpHeroId, replaceHeroId)
	        if index ~= -1 then
	            table.remove(selectTask.tmpHeroId, index)
	        end
		end
		if table.indexOf(selectTask.tmpHeroId, heroId) == -1 then
			table.insert(selectTask.tmpHeroId, heroId)
		end
	else
		for k, v in pairs(selectTask.tmpHeroId) do
			if v == heroId then
				table.remove(selectTask.tmpHeroId, k)
				break
			end
		end
	end
	self:updateSitList()
	self:updateTaskInfo()
end

function CommandTaskView:updateTaskList()
	local num = #self.uiList_task:getItems() - #self.taskLists
	for i = 1, math.abs(num) do
		if num > 0 then
			self.uiList_task:removeItem(1)
		else
			local item = self.Panel_taskItem:clone()
			self.uiList_task:pushBackCustomItem(item)
		end
	end

	local hasAward = false
	local canAction = false

	for k, v in ipairs(self.taskLists) do
		local item = self.uiList_task:getItem(k)
		self:updateTaskItem(item, k, v)

		if ExploreDataMgr:checkTaskRedPoint(v) then
			hasAward = true
		end

		if v.state == 0 then
			canAction = true
		end
	end
	self.uiList_task:doLayout()

	self.Button_oneKeyGet:setVisible(hasAward)
	self.Button_oneKeyAction:setVisible(canAction)
end

function CommandTaskView:updateTaskItem(item, index, taskData)
	local Image_quality = TFDirector:getChildByPath(item,"Image_quality")
	local Icon_quality = TFDirector:getChildByPath(item,"Icon_quality")
	local Image_flag = TFDirector:getChildByPath(item,"Image_flag")
	local Label_flag = TFDirector:getChildByPath(item,"Label_flag")
	local Image_finish = TFDirector:getChildByPath(item,"Image_finish")
	Label_flag:setSkewX(15)
	local Image_canget = TFDirector:getChildByPath(item,"Image_canget")
	local Label_canget = TFDirector:getChildByPath(Image_canget,"Label_canget")
	Label_canget:setSkewX(15)
	local Image_redTip = TFDirector:getChildByPath(item,"Image_redTip")

	local taskCfg = TabDataMgr:getData("ExploreTask",taskData.id)
	Icon_quality:setTexture(taskCfg.qualityIcon)
	Image_flag:setVisible(taskData.state == 1)

	--Image_canget:setVisible(taskData.state == 2)
	Image_finish:setVisible(taskData.state == 3)

	Image_canget:setVisible(CommandTaskView.checkTaskRedPoint(taskData))
	Image_redTip:setVisible(false)
	local path = "ui/explore/growup/command/task/013.png"
	if self.selectIdx == index then
		if taskCfg.quality >= 3 then
			path = "ui/explore/growup/command/task/012.png"
		else
			path = "ui/explore/growup/command/task/011.png"
		end
		item:setPositionX(60)
	else
		if taskCfg.quality >= 3 then
			path = "ui/explore/growup/command/task/014.png"
		else
			path = "ui/explore/growup/command/task/013.png"
		end
		item:setPositionX(50)
	end
	Image_quality:setTexture(path)

	Image_quality.index = index
	Image_quality:setTouchEnabled(true)
	Image_quality:onClick(function(sender)
		if self.selectIdx == sender.index then
			return
		end
		self:resetSelectTaskHero()
		self.selectIdx = sender.index or 1
		self:updateTaskList()
		self:updateTaskInfo()
		self:updateSitList()
	end)
end

function CommandTaskView:checkCondition(isExtCondition)
	local selectTask = self:getSelectTaskInfo()
	if not selectTask then return false end
	local data = TabDataMgr:getData("ExploreTask", selectTask.id)
	local condition = data.condition
	if isExtCondition then
		condition = data.extCondition
	end

	for k,v in pairs(condition) do
		if k == "heroQualityAndCount" then
			local quality, count = next(v)
			local fitCount = 0
			for _k,_role in pairs(selectTask.tmpHeroId) do
				if HeroDataMgr:getQuality(_role) >= quality then
					fitCount = fitCount + 1
				end
			end
			if fitCount < count then
				return false
			end
		elseif k == "haveTargetHero" then
			local targetHeroId = v
			local hasTarget = false
			for _k,_role in pairs(selectTask.tmpHeroId) do
				if _role == targetHeroId then
					hasTarget = true
				end
			end
			if not hasTarget then
				return false
			end
		elseif k == "heroCount" then
			local count = v

			if #selectTask.tmpHeroId < count then
				return  false
			end
		elseif k == "totalFightingPower" then
			local targetPower = v
			local tmpPower = 0
			for _k,_role in pairs(selectTask.tmpHeroId) do
				tmpPower = tmpPower + HeroDataMgr:getHeroPower(_role)
			end
			if tmpPower < targetPower then
				return false
			end
		elseif k == "heroTypeAndCount" then
			local type,count = next(v)
			local fitCount = 0
			for _k,_role in pairs(selectTask.tmpHeroId) do
				if type == HeroDataMgr:getHero(_role).attrType then
					fitCount = fitCount + 1
				end
			end

			if fitCount < count then
				return false
			end
		elseif k == "targetQuality" then
			local targetHero, quality = next(v)
			local hasTarget = false
			for _k,_role in pairs(selectTask.tmpHeroId) do
				if _role == targetHero then
					hasTarget = true
				end
			end
			if not hasTarget then return false end

			local _quality = HeroDataMgr:getQuality(targetHero)
			if _quality < quality then
				return false
			end
		elseif k == "targetFightingPower" then
			local targetHero, fightingPower = next(v)

			local hasTarget = false
			for _k,_role in pairs(selectTask.tmpHeroId) do
				if _role == targetHero then
					hasTarget = true
				end
			end

			if not hasTarget then return false end
			
			local _fightingPower = HeroDataMgr:getHeroPower(targetHero)
			if _fightingPower < fightingPower then
				return false
			end
		end
	end
	return true
end

function CommandTaskView:updateTaskInfo()
	local selectTask = self:getSelectTaskInfo()
	if not selectTask then return end
	local data = TabDataMgr:getData("ExploreTask", selectTask.id)
	self.Label_taskdes:setText(data.describe1)
	self.Panel_working:setVisible(selectTask.state == 1)
	self.Panel_finished:setVisible(selectTask.state == 3)

	local costId, costNum
	for id, num in pairs(data.fastFinishCost) do
        costId = id
        costNum = num
        break
    end
    self.Button_cost.id = costId
    self.Image_costIcon:setTexture(GoodsDataMgr:getItemCfg(costId).icon)
    self.Label_costNum:setText(costNum)

	self.Image_3:setTexture("ui/explore/growup/command/task/019.png")
	local isFit = self:checkCondition()
	self.Image_rule1:setVisible(not isFit)
	self.Image_rule1_s:setVisible(isFit)

	if selectTask.state == 0 then
		self.button_paiqian:setVisible(isFit)
		self.Label_condition_tip:setVisible(not isFit)
	else
		self.button_paiqian:setVisible(false)
		self.Label_condition_tip:setVisible(false)
	end


	local res = isFit and "ui/explore/growup/command/task/003.png" or "ui/explore/growup/command/task/024.png"
	self.Image_condition:setTexture(res)

	isFit = self:checkCondition(true)
	self.Image_rule2:setVisible(not isFit)
	self.Image_rule2_s:setVisible(isFit)

	self:updateTaskRule(self.Image_rule1, data.describe2)
	self:updateTaskRule(self.Image_rule1_s, data.describe2)
	self:updateTaskRule(self.Image_rule2, data.describe3)
	self:updateTaskRule(self.Image_rule2_s, data.describe3)

	self.Label_name:setTextById(data.name)
	self.Image_curTask_Icon:setTexture(data.icon)

	if selectTask.state == 3 then
		self.Image_curTask_Icon:setTexture("ui/explore/growup/command/task/icon_finish.png")
	end

	Utils:createRewardListHor(self.ScrollView_reward,data.awardShow or {})
	Utils:createRewardListHor(self.ScrollView_EXreward,data.extAwardShow or {})

	self.Label_tip1:setVisible(table.count(data.awardShow) > 0 )
	self.Image_6:setVisible(table.count(data.extAwardShow) > 0 )
	self.Label_tip2:setVisible(table.count(data.extAwardShow) > 0 )

	self.button_acceleration:setVisible(selectTask.state == 1)
	self.Button_cost:setVisible(selectTask.state == 1)
	self.button_getAward:setVisible(selectTask.state == 2)
	self.Label_gettedAward:setVisible(selectTask.state == 3)

	self:onCountDownPer()

end

function CommandTaskView:updateTaskRule(ruleImg, string)
	ruleImg:setVisible(ruleImg:isVisible() and string ~= "")
	local Label_rule = TFDirector:getChildByPath(ruleImg,"Label_rule")
	Label_rule:setText(string)
end

function CommandTaskView:getSelectTaskInfo()
	local selectTask = self.taskLists[self.selectIdx]
	if selectTask then
		selectTask.heroId = selectTask.heroId or {}
		selectTask.tmpHeroId = selectTask.tmpHeroId or clone(selectTask.heroId)
	end
	return selectTask
end

function CommandTaskView:resetSelectTaskHero()
	local selectTask = self:getSelectTaskInfo()
	if selectTask then
		selectTask.tmpHeroId = clone(selectTask.heroId) or {}
	end
end

function CommandTaskView:removeEvents()
	self.super.removeEvents(self)
	if self.countDownTimer_ then
        TFDirector:stopTimer(self.countDownTimer_)
        TFDirector:removeTimer(self.countDownTimer_)
        self.countDownTimer_ = nil
	end
end

return CommandTaskView