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

local OneKeyActionTaskView = class("OneKeyActionTaskView",BaseLayer)

function OneKeyActionTaskView:ctor(  )
	-- body
	self.super.ctor(self)
	self.cacheTask = {}
	self:init("lua.uiconfig.explore.onkeyActionTaskView")
end

function OneKeyActionTaskView:initUI( ui )
	-- body
	self.super.initUI(self,ui)

	self.Button_sure = TFDirector:getChildByPath(ui,"Button_sure")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	local ScrollView_task = TFDirector:getChildByPath(ui,"ScrollView_task")
	self.uiList_task = UIListView:create(ScrollView_task)


	self.Panel_item = TFDirector:getChildByPath(ui,"Panel_item")
	self.Panel_roleItem = TFDirector:getChildByPath(ui,"Panel_roleItem")
	self:updateTaskList()
end

function OneKeyActionTaskView:registerEvents( ... )
	-- body
	self.super.registerEvents(self)
	self.Button_close:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)

	self.Button_sure:onClick(function ( ... )
		-- body
		local taskInfos = ExploreDataMgr:getCacheTaskPlan()
		local msg = {}

		for k,v in ipairs(taskInfos) do
			if table.find(self.cacheTask,v.taskId) == -1 then
				table.insert(msg,v)
			end
		end

		if #msg == 0 then 
			Utils:showTips(13322057) 
			return 
		end
		
		ExploreDataMgr:Send_EXPLORE_REQ_AFK_TASKS_DEAL(msg)
		AlertManager:closeLayer(self)
	end)
end

function OneKeyActionTaskView:updateTaskList( ... )
	-- body
	local taskInfos = ExploreDataMgr:getCacheTaskPlan()

	table.sort(taskInfos,function ( v1, v2)
		local taskCfg1 = TabDataMgr:getData("ExploreTask", v1.taskId)
		local taskCfg2 = TabDataMgr:getData("ExploreTask", v2.taskId)
		if taskCfg1.quality == taskCfg2.quality then
			return v1.taskId < v2.taskId
		else
			return taskCfg1.quality > taskCfg2.quality
		end
	end)

	local removeNum = #self.uiList_task:getItems() - #taskInfos

	if removeNum > 0 then
		for i = 1,removeNum do
			self.uiList_task:removeItem(1)
		end
	end

	for k,v in ipairs(taskInfos) do
		local item = self.uiList_task:getItem(k)
		if not item then
			item = self.Panel_item:clone()
			self.uiList_task:pushBackCustomItem(item)
		end
		self:updateTaskItem(item, v)
	end
end

function OneKeyActionTaskView:checkCondition(taskInfo,isExtCondition)
	local data = TabDataMgr:getData("ExploreTask", taskInfo.taskId)
	local condition = data.condition
	if isExtCondition then
		condition = data.extCondition
	end

	for k,v in pairs(condition) do
		if k == "heroQualityAndCount" then
			local quality, count = next(v)
			local fitCount = 0
			for _k,_role in pairs(taskInfo.heroId) do
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
			for _k,_role in pairs(taskInfo.heroId) do
				if _role == targetHeroId then
					hasTarget = true
				end
			end
			if not hasTarget then
				return false
			end
		elseif k == "heroCount" then
			local count = v

			if #taskInfo.heroId < count then
				return  false
			end
		elseif k == "totalFightingPower" then
			local targetPower = v
			local tmpPower = 0
			for _k,_role in pairs(taskInfo.heroId) do
				tmpPower = tmpPower + HeroDataMgr:getHeroPower(_role)
			end
			if tmpPower < targetPower then
				return false
			end
		elseif k == "heroTypeAndCount" then
			local type,count = next(v)
			local fitCount = 0
			for _k,_role in pairs(taskInfo.heroId) do
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
			for _k,_role in pairs(taskInfo.heroId) do
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
			for _k,_role in pairs(taskInfo.heroId) do
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

function OneKeyActionTaskView:updateTaskItem( item, taskInfo )
	-- body
	local task = TabDataMgr:getData("ExploreTask",taskInfo.taskId)
	local Label_taskName = TFDirector:getChildByPath(item,"Label_taskName")
	local Image_quality = TFDirector:getChildByPath(item,"Image_quality")
	local ScrollView_sit = TFDirector:getChildByPath(item,"ScrollView_sit")
	local ScrollView_reward = TFDirector:getChildByPath(item,"ScrollView_reward")
	local ScrollView_exReward = TFDirector:getChildByPath(item,"ScrollView_exReward")
	local Button_select = TFDirector:getChildByPath(item,"Button_select")

	Label_taskName:setTextById(task.name)
	Image_quality:setTexture(task.qualityIcon)

	Utils:createRewardListHor(ScrollView_reward,task.awardShow or {})
	local exAward = {}
	if self:checkCondition(taskInfo,true) then
		exAward = task.extAwardShow or {}
	end
	Utils:createRewardListHor(ScrollView_exReward,exAward)

	local hasIgnore = table.find(self.cacheTask,task.id) ~= -1
	local gouTexture = hasIgnore and "ui/explore/growup/command/task/dark_gou.png" or "ui/explore/general/record/7.png"
	Button_select:setTextureNormal(gouTexture)

	if not ScrollView_sit.uiList then
		ScrollView_sit.uiList = UIListView:create(ScrollView_sit)
	end

	local removeNum = #ScrollView_sit.uiList:getItems() - #taskInfo.heroId

	if removeNum > 0 then
		for i = 1,removeNum do
			ScrollView_sit.uiList:removeItem(1)
		end
	end

	for k,v in ipairs(taskInfo.heroId) do
		local item = ScrollView_sit.uiList:getItem(k)
		if not item then
			item = self.Panel_roleItem:clone()
			ScrollView_sit.uiList:pushBackCustomItem(item)
		end

		self:updateRoleItem(item, v)
	end

	Button_select:onClick(function ( ... )
		-- body
		if table.find(self.cacheTask,task.id) ~= -1 then
			table.remove(self.cacheTask, table.find(self.cacheTask,task.id))
		else
			table.insert(self.cacheTask,task.id)
		end

		local hasIgnore = table.find(self.cacheTask,task.id) ~= -1
		local gouTexture = hasIgnore and "ui/explore/growup/command/task/dark_gou.png" or "ui/explore/general/record/7.png"
		Button_select:setTextureNormal(gouTexture)
	end)
end

function OneKeyActionTaskView:updateRoleItem( item, heroId )
	-- body
	item:setScale(0.8)
	local Image_border = TFDirector:getChildByPath(item,"Image_border")
	local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
	local Image_cur = TFDirector:getChildByPath(item,"Image_cur")
	local Image_working = TFDirector:getChildByPath(item,"Image_working")
	local Image_select = TFDirector:getChildByPath(item,"Image_select")
	local Label_working = TFDirector:getChildByPath(item,"Label_working")
	local Label_cur = TFDirector:getChildByPath(item,"Label_cur")
	local Image_11 = TFDirector:getChildByPath(item,"Image_11")
	local Image_quality = TFDirector:getChildByPath(item,"Image_quality")
	Label_cur:setSkewX(15)
	Label_working:setSkewX(15)

	Image_icon:setTexture(HeroDataMgr:getIconPathById(heroId))
	Image_quality:setTexture(HeroDataMgr:getQualityPic(heroId))
	Image_cur:hide()
	Image_working:hide()
	Image_select:hide()
end

return OneKeyActionTaskView