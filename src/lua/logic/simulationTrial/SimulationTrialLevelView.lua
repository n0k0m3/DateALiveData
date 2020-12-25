local UserDefault = CCUserDefault:sharedUserDefault()
local SimulationTrialLevelView = class("SimulationTrialLevelView",BaseLayer)



-- 第一章 480001-480005   groupID  500002
-- 第二章 480006-480017   groupID  500003
-- local CHAPTERS  = { 500002 , 500003 }
-- 110211
-- 111301
-- 111401


--默认官气难度
local DEFAULT_LEVEL_DIFF = 1
local function setSelect(self,_select)
	self.Image_chapter_select:setVisible(_select)
	self.Image_chapter_normal:setVisible(not _select)
end

function SimulationTrialLevelView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig."..self.resConfig.ui)
end

function SimulationTrialLevelView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.Panel_prefab      = TFDirector:getChildByPath(ui, "Panel_prefab")
    self.Button_reward     = TFDirector:getChildByPath(self.Panel_prefab, "Button_reward")
	self.Button_reward:hide()


    self.Panel_chapter1  = TFDirector:getChildByPath(self.Panel_root, "Panel_chapter1")
    self.Button_reward1                = TFDirector:getChildByPath(self.Panel_chapter1, "Button_reward1")
    self.Button_reward1.Spine_effect   = TFDirector:getChildByPath(self.Button_reward1, "Spine_effect")
    self.Button_reward1.Spine_effect:playByIndex(0,1)
    self.Button_reward1.Label_title   = TFDirector:getChildByPath(self.Button_reward1, "Label_title")
	self.Button_reward1.Label_title:setTextById(self.resConfig.title)

	self.Button_reward1.Image_redPoint =  self.Button_reward1:getChildByName("Image_reward_redpoint")
	self.Panel_chapter1.checkPoints = {}
	for i=1,5 do  
		
		local node = TFDirector:getChildByPath(self.Panel_chapter1, "Button_cp"..i)
		node.Image_status = TFDirector:getChildByPath(node, "Image_status")
	    node.Label_title  = TFDirector:getChildByPath(node, "Label_title")
		node.Image_lock   = TFDirector:getChildByPath(node, "Image_lock")
		node.Spine_effect   = TFDirector:getChildByPath(node, "Spine_effect"):hide()
		self.Panel_chapter1.checkPoints[i] = node
	end


    self.Panel_chapter2    = TFDirector:getChildByPath(self.Panel_root, "Panel_chapter2")
    self.ScrollView_wave   = TFDirector:getChildByPath(self.Panel_chapter2, "ScrollView_wave")
    self.Image_loadbar_bg  = TFDirector:getChildByPath(self.Panel_chapter2, "Image_loadbar_bg")
    self.LoadingBar_reward = TFDirector:getChildByPath(self.Image_loadbar_bg, "LoadingBar_reward")

	--章节选择
	local Image_left = TFDirector:getChildByPath(self.Panel_root, "Image_left")
	self.Panel_tab1 = TFDirector:getChildByPath(self.Panel_root, "Panel_tab1")
	self.Panel_tab1.Image_chapter_normal = TFDirector:getChildByPath(self.Panel_tab1, "Image_chapter_normal")
	self.Panel_tab1.Image_chapter_select = TFDirector:getChildByPath(self.Panel_tab1, "Image_chapter_select")
	self.Panel_tab1.Label_chapter_name   = TFDirector:getChildByPath(self.Panel_tab1, "Label_chapter_name")
	self.Panel_tab1.Image_lock  = TFDirector:getChildByPath(self.Panel_tab1, "Image_lock")
	self.Panel_tab1.setSelect   = setSelect

	self.Panel_tab2 = TFDirector:getChildByPath(self.Panel_root, "Panel_tab2")
	self.Panel_tab2.Image_chapter_normal = TFDirector:getChildByPath(self.Panel_tab2, "Image_chapter_normal")
	self.Panel_tab2.Image_chapter_select = TFDirector:getChildByPath(self.Panel_tab2, "Image_chapter_select")
	self.Panel_tab2.Label_chapter_name   = TFDirector:getChildByPath(self.Panel_tab2, "Label_chapter_name")
	self.Panel_tab2.Image_lock  = TFDirector:getChildByPath(self.Panel_tab2, "Image_lock")
	self.Panel_tab2.setSelect = setSelect
    local datas = TabDataMgr:getData("DungeonLevelGroup")
	self.Panel_tab1.Label_chapter_name:setText(datas[self.resConfig.groupIds[1]].titleName)
	self.Panel_tab2.Label_chapter_name:setText(datas[self.resConfig.groupIds[2]].titleName)

	self.Panel_checkPoints = TFDirector:getChildByPath(self.ScrollView_wave,"Panel_checkPoints")
	--关卡和线
	self.Panel_chapter2.checkPoints = {}

	for index = 1 , 12 do
		local node = TFDirector:getChildByPath(self.Panel_checkPoints,"Panel_checkPoint"..index)
		node.Image_cp           = node:getChildByName("Image_cp")
		node.Image_cp_lock      = node:getChildByName("Image_cp_lock")
		node.Label_title        = node:getChildByName("Label_title")
		node.Image_finish 		= node:getChildByName("Image_finish")
		node.starList = {}
		node.Panel_star = node:getChildByName("Panel_star")
		for i=1,3 do
			node.starList[i] = node.Panel_star:getChildByName("Image_star_"..i)
		end
		self.Panel_chapter2.checkPoints[index] = node
	end
	--载入默认章节
	local lastChapterIndex = self:getLastChapterIndex()
	if lastChapterIndex == 2 then 
		if self:isChapterLock(lastChapterIndex) then 
			lastChapterIndex = 1
		end
	else
		lastChapterIndex = 1
	end

	self:changeChapter(lastChapterIndex)

end
local key_SimlationChapterIndex = "SimlationChapterIndex_"
function SimulationTrialLevelView:saveChapterIndex()
	local key = key_SimlationChapterIndex..self.heroId
	UserDefault:setStringForKey(key,tostring(self.chapterIndex))
end

function SimulationTrialLevelView:getLastChapterIndex()
	local key   = key_SimlationChapterIndex..self.heroId
	local value = UserDefault:getStringForKey(key)
	if not value or value == "" then 
		value = 1
	else
		value = tonumber(value)
	end 
	return value
end
--是否有任務獎勵可以領取
function SimulationTrialLevelView:hasTaskReward()
	local tasks = FubenDataMgr:getSimulationTrialHeroInfo(self.heroId).tasks
	if tasks then 
		for i,v in ipairs(tasks) do
			if v.status == 2 then 
				return true
			end
		end
	end
	return false
end

function SimulationTrialLevelView:isChapterLock(chapterIndex)
	if chapterIndex == 1 then
		return  false
	elseif chapterIndex == 2 then
		return not self:checkPlotLevelEnabled(self.resConfig.firstLevelCid) --检查第一个关卡是否开放来作为章节按钮的开放状态
	else
		return true
	end
end

function SimulationTrialLevelView:cloneReward()
	local item = self.Button_reward:clone()
	item:show()
	item.sketonNode            = TFDirector:getChildByPath(item, "Spine_reward_receive")
	item.Label_get_starnum     = TFDirector:getChildByPath(item, "Label_get_starnum")
	item.Image_reward_redpoint = TFDirector:getChildByPath(item, "Image_reward_redpoint")
    item.Spine_effect          = TFDirector:getChildByPath(item, "Spine_effect")
	item:onClick(function()
		--TODO 不可领取弹出预览/可领取直接领取 /已领取 弹出展示页面
		local rewardIndex = item.rewardIndex
		local data    = self.rewards[rewardIndex]
	    local isGet   = FubenDataMgr:checkLevelGroupStarRewardIsGet(self.levelGroupId,DEFAULT_LEVEL_DIFF, rewardIndex)
	    local isReach = FubenDataMgr:canGetLevelGroupStarReward(self.levelGroupId,DEFAULT_LEVEL_DIFF, rewardIndex)
	    if isReach and not isGet then --领取操作
            local levelGroupServerID = FubenDataMgr:getLevelGroupServerId(self.levelGroupId, DEFAULT_LEVEL_DIFF)
            FubenDataMgr:send_DUNGEON_GET_LEVEL_GROUP_REWARD(levelGroupServerID, DEFAULT_LEVEL_DIFF, data.tag)
	    else --预览
	    	Utils:openView("simulationTrial.SimulationTrialRewardPreview",self.levelGroupId ,rewardIndex)
	    end
	end)
	return item
end

function SimulationTrialLevelView:checkPlotLevelEnabled(levelCid)
	local enabled, preIsOpen, levelIsOpen = FubenDataMgr:checkPlotLevelEnabled(levelCid)
	local openDungeons = FubenDataMgr:getSimulationTrialHeroInfo(self.heroId).dungeonId
	local timeOpen = false
	if openDungeons then 
		for i,v in ipairs(openDungeons) do
			if levelCid == v then
				timeOpen = true
			end
		end
	end
	enabled = enabled and timeOpen
	return enabled, preIsOpen, levelIsOpen ,timeOpen
end

function SimulationTrialLevelView:updateLevelItem1(node, levelCid)
    local levelCfg         = FubenDataMgr:getLevelCfg(levelCid)
    local enabled, preIsOpen, levelIsOpen ,timeOpen = self:checkPlotLevelEnabled(levelCid)
    local levelInfo        = FubenDataMgr:getLevelInfo(levelCid)
   	-- dump({levelCid,enabled, preIsOpen, levelIsOpen ,timeOpen})
   	node:setGrayEnabled(not enabled)
   	node.Spine_effect:setVisible(enabled)
    node.Image_status:setVisible(enabled)
    node.Image_lock:setVisible(not enabled)
    node:setTouchEnabled(enabled)
    node.Label_title:setTextById(levelCfg.name)
    node:onClick(function()
        -- Utils:openView("fuben.FubenReadyView", levelCid)
        Utils:openView("fuben.FubenSquadView", EC_FBType.ACTIVITY , EC_ActivityFubenType.SIMULATION_TRIAL ,levelCid)
    end)
end




function SimulationTrialLevelView:updateLevelItem2(node, levelCid)
    local levelCfg         = FubenDataMgr:getLevelCfg(levelCid)
    local enabled, preIsOpen, levelIsOpen ,timeOpen = self:checkPlotLevelEnabled(levelCid)
    local levelInfo        = FubenDataMgr:getLevelInfo(levelCid)
   	-- dump({levelCid,enabled, preIsOpen, levelIsOpen ,timeOpen})
    node.Panel_star:setVisible(enabled)
	local starNum = 0
    if enabled  then
		starNum = FubenDataMgr:getStarNum(levelCid)
	    for i, v in ipairs(node.starList) do
	        v:show()
	        if i <= starNum then
	            v:setTexture(self.resConfig.star)
	        else
	            v:setTexture(self.resConfig.gray_star)
	        end
	    end
    end
    node.Image_cp:setTouchEnabled(enabled)
    node.Image_cp_lock:setTouchEnabled(not enabled)
	if node.Image_finish then
		node.Image_cp:setVisible(enabled and starNum == 0)
		node.Image_finish:setVisible(enabled and starNum ~= 0)
		node.Image_finish:setTouchEnabled(enabled)
		node.Image_finish:onClick(function()
			Utils:openView("fuben.FubenReadyView", levelCid)
		end)
	else
		node.Image_cp:setVisible(enabled)
	end
	node.Image_cp_lock:setVisible(not enabled)

    node.Label_title:setTextById(levelCfg.name)
    node.Image_cp:onClick(function()
    	Utils:openView("fuben.FubenReadyView", levelCid)
   	end)
    node.Image_cp_lock:onClick(function()
       	local enabled, preIsOpen, levelIsOpen ,timeOpen = self:checkPlotLevelEnabled(levelCid)
		if not timeOpen then 
			local timeInfo = self.levelOpenTab[levelCid]
		    if timeInfo then
				Utils:showTips(2108106,timeInfo.month,timeInfo.day)
		    end
		elseif not enabled then
			Utils:showTips(2108105)
		end
    end)
    return enabled
end

            -- local levelGroupCid = levelCfg.levelGroupId
            -- -- local levelGroupIndex = table.indexOf(self.levelGroup, levelGroupCid)
            -- FubenDataMgr:cacheSelectLevelGroup(levelGroupCid)
            -- FubenDataMgr:cacheSelectLevel(levelCid)
function SimulationTrialLevelView:initData(heroId)
	self.heroId    = heroId
    local cfg = FubenDataMgr:getSimulationTrialCfg(heroId)
    if not cfg then
        Box("no heroId "..tostring(heroId).." in SimulationTrialHigh")
        return
    end
	self.resConfig = cfg.chapter
	self.topBarFileName = self.resConfig.topHelp
	self.levelOpenTab = {}
	local cfg = TabDataMgr:getData("DiscreteData",self.resConfig.discreteId).data
	for i, _v in ipairs(cfg.dungeon) do
		if _v.hero == heroId then 
			for i,v in ipairs(_v.info) do
				local time = Utils:getTimeByDate(v.time)
				for _, levelID in ipairs(v.chapter) do
					local year, month, day = Utils:getDate(time)
				 	self.levelOpenTab[levelID] =  {time = time ,year = year ,month = month, day = day}
				end 
			end
		end
	end

	--1:选中 2:常规 3:灰置
	self.tabColor = {ccc3(255,255,255),ccc3(255,255,255),ccc3(255,255,255)}
	if self.resConfig.tabInfo then
		for k,v in ipairs(self.resConfig.tabInfo) do
			local color = Utils:covertToColorRGB(v)
			self.tabColor[k] = color
		end
	end
end

function SimulationTrialLevelView:refreshReward()
	if self.chapterIndex == 1 then 
		local _hasTaskReward = self:hasTaskReward()
		self.Button_reward1.Spine_effect:setVisible(_hasTaskReward) 
		self.Button_reward1.Image_redPoint:setVisible(_hasTaskReward)
	else
		-- local chapterId = self.levelGroupCfg.dungeonChapterId	
        local totalFightStarNum, totalDatingStarNum = FubenDataMgr:getLevelGroupTotalStarNum(self.levelGroupId, DEFAULT_LEVEL_DIFF)
        local fightStarNum, datingStarNum = FubenDataMgr:getLevelGroupStarNum(self.levelGroupId,DEFAULT_LEVEL_DIFF)
        -- dump({fightStarNum ,totalFightStarNum ,"fightStarNum1" ,tostring(self.levelGroupId)})
		self.LoadingBar_reward:setPercent(math.floor(fightStarNum*100/totalFightStarNum)) --计算进度
   		self.rewards = self.levelGroupCfg.reward[1]
   		-- self.stars_  = table.keys(self.rewards)
   		-- table.sort(self.stars_)
		local width  = self.Image_loadbar_bg:getSize().width
		local allStarNum = totalFightStarNum
		-- for i, v in ipairs(self.rewards) do
		-- 	allStarNum = allStarNum + v.cond[1]
		-- end
		local fixPercent = { 0 ,33 ,66,100,100,100,100,100 }
		if not self.rewardItems then 
			self.rewardItems = {}
			local num = 0
			for i, v in ipairs(self.rewards) do
				local item = self:cloneReward()
				self.rewardItems[i] = item
				self.Image_loadbar_bg:addChild(item)
				num =   v.cond[1]
				item.rewardIndex = i
				item.Label_get_starnum:setText(tostring(num))--v.cond[1])
				item:setPosition(ccp(width*num/allStarNum - width*0.5,15))
				-- item:setPosition(ccp(width*fixPercent[i]*0.01- width*0.5,15))
			end

		end

		for i, item in ipairs(self.rewardItems) do
			local isReach = FubenDataMgr:canGetLevelGroupStarReward(self.levelGroupId,DEFAULT_LEVEL_DIFF, i)
			local isGet   = FubenDataMgr:checkLevelGroupStarRewardIsGet(self.levelGroupId,DEFAULT_LEVEL_DIFF, i)
			item.Image_reward_redpoint:setVisible(isReach and not isGet)
			if isReach and not isGet then 
				item.Spine_effect:playByIndex(0,1)
				item.Spine_effect:setVisible(true)
			else
				item.Spine_effect:setVisible(false)
			end
			if isGet then
				item:setTextureNormal(self.resConfig.box_geted)
			else
				if isReach then 
					item:setTextureNormal(self.resConfig.box_reach)
				else
					item:setTextureNormal(self.resConfig.box_normal)
				end
			end
		end
	end 
end

function SimulationTrialLevelView:changeChapter(index)
	self.Panel_tab1.Image_lock:setVisible(self:isChapterLock(1))
    self.Panel_tab2.Image_lock:setVisible(self:isChapterLock(2))

	local color = self:isChapterLock(1) and self.tabColor[3] or self.tabColor[2]
	self.Panel_tab1.Label_chapter_name:setColor(color)
	local color = self:isChapterLock(2) and self.tabColor[3] or self.tabColor[2]
	self.Panel_tab2.Label_chapter_name:setColor(color)

	if self.chapterIndex == index then
		return
	end
	if self:isChapterLock(index) then 
		print("章节锁定")
		if index == 2 then 
 			local enabled, preIsOpen, levelIsOpen ,timeOpen = self:checkPlotLevelEnabled(self.resConfig.firstLevelCid)
 			if not timeOpen then 
				local timeInfo = self.levelOpenTab[self.resConfig.firstLevelCid]
				if timeInfo then
					Utils:showTips(2108104,timeInfo.month,timeInfo.day)
				end
			else
				Utils:showTips(2108111)
 			end
		end 
		return
	end

	self.chapterIndex = index
	self.Panel_tab1:setSelect(self.chapterIndex == 1)
    self.Panel_tab2:setSelect(self.chapterIndex == 2)


	self.levelGroupId  = self.resConfig.groupIds[self.chapterIndex]
	self.levels        = FubenDataMgr:getLevel(self.levelGroupId)


	--显示排序
	table.sort(self.levels,function (a,b)
       local cfgA = FubenDataMgr:getLevelCfg(a)
       local cfgB = FubenDataMgr:getLevelCfg(b)
       return cfgA.num < cfgB.num
	end)
    self.levelGroupCfg = FubenDataMgr:getLevelGroupCfg(self.levelGroupId)
       -- self.levelGroup_ = FubenDataMgr:getLevelGroup(411)
        -- self.levelGroupInfo = FubenDataMgr:getLevelGroupInfo(levelGroupId)

	if self.chapterIndex == 1 then 
		self.Panel_chapter1:show()
		self.Panel_chapter2:hide()
		local levelCount = #self.levels
		for i,v in ipairs(self.levels) do
			local node = self.Panel_chapter1.checkPoints[i]
			node:show()
			self:updateLevelItem1(node,v)
		end
		self.Panel_tab1.Label_chapter_name:setColor(self.tabColor[1])

		local color = self:isChapterLock(2) and self.tabColor[3] or self.tabColor[2]
		self.Panel_tab2.Label_chapter_name:setColor(color)
	else
		self.Panel_chapter1:hide()
		self.Panel_chapter2:show()
		local positon
		local levelCount = #self.levels
		for i,v in ipairs(self.levels) do
			local node = self.Panel_chapter2.checkPoints[i]
			node:show()
			local enable = self:updateLevelItem2(node,v)
			local pass   = FubenDataMgr:isPassPlotLevel(v)
			if not positon then 
				if enable and not pass then 
					positon = node:getPosition()
				end
			end
		end
		--自动跳转
		if positon then
		    local width   = self.ScrollView_wave:getInnerContainerSize().width
		    width = width - self.ScrollView_wave:getSize().width
		    local percet = math.floor((positon.x -  150)*100 / width)
		    percet = math.max(math.min(percet,100),0)
			self.ScrollView_wave:scrollTo(TF_SCROLLVIEW_SCROLL_TO_PERCENT_HORIZONTAL, 0.2, true, -percet, 0)
		end

		self.Panel_tab2.Label_chapter_name:setColor(self.tabColor[1])

		local color = self:isChapterLock(1) and self.tabColor[3] or self.tabColor[2]
		self.Panel_tab1.Label_chapter_name:setColor(color)

	end
    self:refreshReward()
    --緩存选中的章节
    self:saveChapterIndex()
end


function SimulationTrialLevelView:onSimulationTrialLevel()
	if not FubenDataMgr:getSimulationTrialIsOpen() then 
		AlertManager:closeLayer(self)
		return
	end

	if self.chapterIndex == 1 then 

		local levelCount = #self.levels
		for i,v in ipairs(self.levels) do
			local node = self.Panel_chapter1.checkPoints[i]
			node:show()
			self:updateLevelItem1(node,v)
		end
	else
		local levelCount = #self.levels
		for i,v in ipairs(self.levels) do
			local node = self.Panel_chapter2.checkPoints[i]
			node:show()
			self:updateLevelItem2(node,v)
		end
	end

	self:refreshReward()
end

function SimulationTrialLevelView:registerEvents()
	EventMgr:addEventListener(self, EV_SIMULATION_TRIAL_UPDATE, handler(self.onSimulationTrialLevel, self))
	EventMgr:addEventListener(self, EV_SIMULATION_TRIAL_TASK_REWARD, handler(self.refreshReward, self))
	EventMgr:addEventListener(self, EV_FUBEN_LEVELGROUPREWARD, handler(self.onGetLevelGroupRewardEvent, self))
	self.Panel_tab1:setTouchEnabled(true)
    self.Panel_tab1:onClick(function ()
    	self:changeChapter(1)
    end)

    self.Panel_tab2:setTouchEnabled(true)
    self.Panel_tab2:onClick(function ()
    	self:changeChapter(2)
    end)


	self.Button_reward1:onClick(function()
		Utils:openView("simulationTrial.SimulationTrialReward",self.heroId)
	end)

end



function SimulationTrialLevelView:onGetLevelGroupRewardEvent(diff, id)
	if self.chapterIndex == 2 then 
		local reward = self.levelGroupCfg.reward[DEFAULT_LEVEL_DIFF]
	    local data = reward[id]
	    if data then
		    local formatReward = {}
		    for k, v in pairs(data.reward) do
		        local item = Utils:makeRewardItem(k, v)
		        table.insert(formatReward, item)
		    end
		    Utils:showReward(formatReward)
		end
	end
	self:refreshReward()
end
function SimulationTrialLevelView:onShow()
	self.super.onShow(self)
	local rewards = FubenDataMgr:getSimulationTrialReward()
	if rewards and #rewards > 0 then
		FubenDataMgr:cleanSimulationTrialReward()
		Utils:openView("simulationTrial.HeroGrowUpView",rewards)
	end
end
return SimulationTrialLevelView


