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
* -- 新年副本
]]

local newYearMainLayer = class("newYearMainLayer",BaseLayer)

function newYearMainLayer:ctor( data )
	-- body
	self.super.ctor(self,data)

	self.timingNode = {}
	self.cityCfgs = TabDataMgr:getData("MojinDungeonCity")
	local displayMap = TabDataMgr:getData("MojinDungeonDisplay")
	self.displayCfgs = {}
	for k, v in pairs(displayMap) do
		self.displayCfgs[v.dungeon] = v
	end
	FubenDataMgr:cacheSelectFubenType(EC_FBType.NEWYEAR_FUBEN)

    self.activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.NEWYEAR_FUBEN)[1]
    self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	self:init("lua.uiconfig.activity.newYearMainLayer")
end

function newYearMainLayer:initUI( ui )
	-- body
	self.super.initUI(self,ui)

	self.map_scrollView = TFDirector:getChildByPath(ui,"ScrollView_map")
	self.Panel_ui = TFDirector:getChildByPath(ui,"Panel_ui")
	self.Button_task = TFDirector:getChildByPath(ui,"Button_task")
	self.redPoint_task = TFDirector:getChildByPath(self.Button_task,"RedTips") 
	self.Button_reward = TFDirector:getChildByPath(ui,"Button_reward")
	self.Button_shop = TFDirector:getChildByPath(ui,"Button_shop")
	self.Image_stage_bg = TFDirector:getChildByPath(ui,"Image_stage_bg")

	self.Panel_event_status = TFDirector:getChildByPath(ui,"Panel_event_status")
	self.bossItem = TFDirector:getChildByPath(ui,"bossItem")
	self.Panel_effect = TFDirector:getChildByPath(ui,"Panel_effect")

	self.Image_stage = TFDirector:getChildByPath(self.Image_stage_bg,"Image_stage")
	self.Label_stage = TFDirector:getChildByPath(self.Image_stage_bg,"Label_stage")
	self.Label_timing = TFDirector:getChildByPath(self.Image_stage_bg,"Label_timing")
	self.Label_unlock_value = TFDirector:getChildByPath(ui,"Label_unlock_value")
	self.Image_res_icon = TFDirector:getChildByPath(ui,"Image_res_icon")
	self.Label_res_num = TFDirector:getChildByPath(ui,"Label_res_num")

	self.Panel_resource = TFDirector:getChildByPath(ui,"Panel_resource")
	self.resource = {}
	for i = 1,3 do
		self.resource[i] = TFDirector:getChildByPath(ui,"resource_"..i)
	end
	
	self.Panel_stage1 = TFDirector:getChildByPath(ui,"Panel_stage1")
	self.Panel_stage1.Panel_boss_info = TFDirector:getChildByPath(self.Panel_stage1,"Panel_boss_info")
	self.Panel_stage1.Panel_score_info = TFDirector:getChildByPath(self.Panel_stage1,"Panel_score_info")
	self.Panel_stage1.Image_boss_icon = TFDirector:getChildByPath(self.Panel_stage1,"Image_boss_icon")
	self.Panel_stage1.Label_boss_name = TFDirector:getChildByPath(self.Panel_stage1,"Label_boss_name")
	self.Panel_stage1.Label_cityName = TFDirector:getChildByPath(self.Panel_stage1,"Label_cityName")
	self.Panel_stage1.Label_score_value = TFDirector:getChildByPath(self.Panel_stage1,"Label_score_value")
	self.Panel_stage1.Label_total_score_value = TFDirector:getChildByPath(self.Panel_stage1,"Label_total_score_value")

	self.Panel_stage2 = TFDirector:getChildByPath(ui,"Panel_stage2")
	local scrollView_bossList = TFDirector:getChildByPath(self.Panel_stage2,"scrollView_bossList")
	self.listView_boss = UIListView:create(scrollView_bossList)

	self:initMapLayer()
	self.Label_timing.timingFunc = function ( ... )
		if  not self.newYearFubenInfo then
			return
		end

		local stageId = 12032015 + self.newYearFubenInfo.stage - 1
		self.Label_stage:setTextById(stageId)
		local stageEnd = self.newYearFubenInfo.stageEnd
		local remandTime = math.max(0, stageEnd - ServerDataMgr:getServerTime())
		local day,hour, min, sec = Utils:getFuzzyDHMS(remandTime,true)
		if day == "00" then
	        self.Label_timing:setTextById(1260001, hour, min)
	    else
	        self.Label_timing:setTextById(800069, day, hour)
	    end
	end
	table.insert(self.timingNode,self.Label_timing)
	self.Label_timing.timingFunc()
	-- 打开界面时请求数据
	ActivityDataMgr2:Req2020FestivalInfo()
end

function newYearMainLayer:registerEvents(  )
	self.super.registerEvents(self)

    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_NEW_YEAR_FUBEN_INFO_UPDATE, handler(self.onUpdateCityInfo, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.onUpdateCityInfo, self))
	EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.checkRedPoint, self))
	EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.updateRes, self))
	
	self.Button_task:onClick(function ()
		Utils:openView("newyearFuben.NewYearTaskView")
	end)
	
	self.Button_reward:onClick(function ()
		Utils:openView("newyearFuben.NewYearScoreRewardView")
	end)
	
	self.Button_shop:onClick(function ()
		FunctionDataMgr:enterByFuncId(self.activityInfo.extendData.jumpInterface, unpack(self.activityInfo.extendData.jumpParamters or {}))
		end)
	self:addCountDownTimer()
end

function newYearMainLayer:onUpdateCityInfo()
	self.newYearFubenInfo = ActivityDataMgr2:getNewYearFubenInfo()
	if not self.newYearFubenInfo then return end

    self:initMapLayer()

	self.Label_timing.timingFunc()
  	self:checkRedPoint()
end

function newYearMainLayer:updateRes()
	if self.activityInfo then
		self.Label_res_num:setText(GoodsDataMgr:getItemCount(self.activityInfo.extendData.resource[1]))
	end
end

function newYearMainLayer:initMapLayer()
	self.Panel_stage1:hide()
	self.Panel_stage2:hide()
	self.cityNodes = self.cityNodes or {}
	if not self.cityMap then
		self.cityMap = createUIByLuaNew("lua.uiconfig.activity.newYearMap")
		self.map_scrollView:addChild(self.cityMap)
		self.map_scrollView:setInnerContainerSize(CCSizeMake(self.cityMap:getSize()))
		self.Panel_boss_bar = TFDirector:getChildByPath(self.cityMap,"Panel_boss_bar"):hide()
	end
	self.Panel_boss_bar:hide()
	if not self.newYearFubenInfo then
		return
	end
	self.bigBossData = nil
	self.bigBossCitiCfg = nil
	self.bossData = {}
	self.bossCitiCfg = {}
	local focusCityId = 1
	local unlockNum = 0
	local previewState = false
	for cityId = 1, 28 do
		local areas = self.newYearFubenInfo.cities[cityId] or {}
		local cityCfg
		for k, v in pairs(self.cityCfgs) do
			if v.city == cityId and v.name > 0 then
				cityCfg = v
				break
			end
		end
		if not self.cityNodes[cityId] then
			local point = TFDirector:getChildByPath(self.cityMap,"panel_point"..cityId)
			point.Label_name = TFDirector:getChildByPath(point,"Label_name")
			point.Label_name:enableOutline(ccc4(41,84,163,255),1)
			point.Image_lock = TFDirector:getChildByPath(point,"Image_lock")
			point.Panel_event1 = TFDirector:getChildByPath(point,"Panel_event1")
			point.Panel_event2 = TFDirector:getChildByPath(point,"Panel_event2")
			self.cityNodes[cityId] = point
		end
		local cityPoint = self.cityNodes[cityId]
		cityPoint:hide()
		cityPoint:setTouchEnabled(false)
		if table.count(areas) < 2 then
			cityPoint.Panel_event1:setPositionX(0)
		else
			cityPoint.Panel_event1:setPositionX(-35)
		end
		cityPoint.Label_name:setTextById(cityCfg.name)
		cityPoint.Image_lock:setPositionX(cityPoint.Label_name:getPositionX() - cityPoint.Label_name:getContentSize().width / 2 - 20)
		cityPoint.Image_lock:hide()
		cityPoint.Panel_event1:hide()
		cityPoint.Panel_event2:hide()
		local frontInfo = self:getCityInfo(cityCfg.cityUnlock)
		if frontInfo and frontInfo[1].dunPass then
			cityPoint:show()
			if cityCfg.sTime and cityCfg.sTime ~= "" then
				local time = Utils:string2time(cityCfg.sTime)
				if ServerDataMgr:getServerTime() < time then
					cityPoint.Image_lock:show()
					cityPoint:setTouchEnabled(true)
					cityPoint:onClick(function ( ... )
						Utils:showTips(cityCfg.openTips)
					end)
				end
			end
		end

		local newUnlock = false
		if not areas[1] then
			cityPoint.Image_lock:show()
		elseif areas[1].dungeon > 0 then
			cityPoint.Panel_event1:show()
			local cfgCity = self.cityCfgs[areas[1].dungeon]
			if self.newYearFubenInfo.stage == 1 and cfgCity.city > 1 then
				local frontInfo = self:getCityInfo(cfgCity.cityUnlock)
				if not areas[1].dunPass 
					and frontInfo 
					and not frontInfo[1].dunPass then
					cityPoint.Image_lock:show()
				end
				if frontInfo and frontInfo[1].dunPass and not areas[1].dunPass then
					focusCityId = cfgCity.city
					newUnlock = true
				end
			end
		end
		if not cityPoint.Image_lock:isVisible() then
			cityPoint:show()
			unlockNum = unlockNum + 1
			self:updatePanelEvent(cityPoint.Panel_event1, areas[1],cityId, 1, newUnlock)
		end

		if self.newYearFubenInfo.stage == 2 and areas[2] and areas[2].dungeon > 0 then
			cityPoint.Panel_event2:show()
			cityPoint.Panel_event2:setPositionX(35)
			local cfgDisplay = self.displayCfgs[areas[2].dungeon]
			if cfgDisplay.displayDetail == 2 then
				table.insert(self.bossData, areas[2])
				table.insert(self.bossCitiCfg, cityCfg)
				cityPoint.Panel_event2:setPositionX(65)
			end
			if cfgDisplay.displayDetail == 3 then
				self.bigBossData = areas[2]
				self.bigBossCitiCfg = cityCfg
				cityPoint.Panel_event2:setPositionX(65)
			end
			self:updatePanelEvent(cityPoint.Panel_event2, areas[2],cityId, 2)
		end
	end
	self.Label_unlock_value:setText(unlockNum.."/"..28)
	local itemCfg = GoodsDataMgr:getItemCfg(self.activityInfo.extendData.resource[1])
	self.Image_res_icon:setTexture(itemCfg.icon)
	self.Label_res_num:setText(GoodsDataMgr:getItemCount(self.activityInfo.extendData.resource[1]))

	local battleEnd = (self.activityInfo.extendData.activityduration.battleendtime - ServerDataMgr:getServerTime()) <= 0
	if self.bigBossData or battleEnd then
		self.Panel_stage1:show()
		self:updatePanelStage1()
	end
	if #self.bossData > 0 and not battleEnd then
		self.Panel_stage2:show()
		self:updatePanelStage2()
	end

	if self.lastFocusCityId ~= focusCityId then
		self:focusMap(focusCityId, true)
		self.lastFocusCityId = focusCityId
	end
end

function newYearMainLayer:updatePanelStage1()
	local maxScore = self.activityInfo.extendData.battlePointsReward[1] or 0
	local roundMax = self.activityInfo.extendData.battlePoints[1][2] or 0
	if self.bigBossData then
		self.Panel_stage1.Panel_boss_info:show()
		self.Panel_stage1.Panel_score_info:show()
		local cfgDisplay = self.displayCfgs[self.bigBossData.dungeon]

		self.Panel_stage1.Label_boss_name:setText(TextDataMgr:getText(12033025)..self.newYearFubenInfo.round.."/9")
		self.Panel_stage1.Image_boss_icon:setTexture(cfgDisplay.invadeIcon)
		self.Panel_stage1.Label_cityName:setTextById(self.bigBossCitiCfg.name)
		self.Panel_stage1.Image_boss_icon:setTouchEnabled(true)
		self.Panel_stage1.Image_boss_icon:onClick(function ( ... )
			self:focusMap(self.bigBossCitiCfg.city)
		end)
		self.Panel_stage1.Label_score_value:show()
		self.Panel_stage1.Label_score_value:setText(self.newYearFubenInfo.roundScore.."/"..roundMax)
	else
		self.Panel_stage1.Panel_boss_info:hide()
		self.Panel_stage1.Panel_score_info:show()
		self.Panel_stage1.Label_score_value:hide()
	end
	
	self.Panel_stage1.Label_total_score_value:setText(self.newYearFubenInfo.totalScore)
end

function newYearMainLayer:updatePanelStage2()
	self.listView_boss:removeAllItems()
	for i, v in ipairs(self.bossData) do
		local cityCfg = self.bossCitiCfg[i]
		local cfgDisplay = self.displayCfgs[v.dungeon]
		local bossItem = self.bossItem:clone()
		TFDirector:getChildByPath(bossItem,"Label_cityName"):setTextById(cityCfg.name)
		local Image_head = TFDirector:getChildByPath(bossItem,"Image_head")
		Image_head:setTexture(cfgDisplay.invadeIcon)

		self.listView_boss:pushBackCustomItem(bossItem)
		Image_head:setTouchEnabled(true)
		Image_head:onClick(function ( ... )
			self:focusMap(cityCfg.city)
		end)

	end
end

function newYearMainLayer:getCityInfo(cityId)
	for i,v in ipairs(self.newYearFubenInfo.cities) do
		if tonumber(i) == cityId then
			return v
		end
	end
end

function newYearMainLayer:updatePanelEvent(eventNode, data, cityId, area, newUnlock)
	if not eventNode.event_status then
		local Panel_event_status = self.Panel_event_status:clone()
		eventNode:addChild(Panel_event_status)
		Panel_event_status:setPosition(ccp(0,0))
		eventNode.event_status = Panel_event_status
	end

	local state = self.newYearFubenInfo.stage
	local cfgCity = self.cityCfgs[data.dungeon]
	local cfgDisplay = self.displayCfgs[data.dungeon]
	local Image_event_icon = TFDirector:getChildByPath(eventNode.event_status,"Image_event_icon")
	
	local Panel_res_collect = TFDirector:getChildByPath(eventNode.event_status,"Panel_res_collect"):hide()
	if newUnlock and state == 1 and not data.pass then
		if eventNode.event_status.Spine then
			eventNode.event_status.Spine:show()
		else
			local Spine_unlock = SkeletonAnimation:create("effect/eff_MJ_tiangongditu_tishi/eff_MJ_tiangongditu_tishi")
			eventNode.event_status:addChild(Spine_unlock, 10)
			Spine_unlock:playByIndex(0, -1, -1, 1)
			eventNode.event_status.Spine = Spine_unlock
		end
	else
		if eventNode.event_status.Spine then
			eventNode.event_status.Spine:removeFromParent()
			eventNode.event_status.Spine = nil
		end
	end
	Image_event_icon:setTexture(self:getEventIcon(data, cfgDisplay))
	if cfgDisplay.displayDetail == 2 or cfgDisplay.displayDetail == 3 then
		local frame = Sprite:create("ui/activity/newyear_fuben/boss_frame.png")
		Image_event_icon:addChild(frame)
	end
	if data.resOpen or (data.replaceGame and data.dunPass and data.replaceGame > 0) then
		Image_event_icon:setScale(0.65)
	else
		Image_event_icon:setScale(0.5)
	end

	if data.resOpen then
		Panel_res_collect:show()
		local LoadingBar_progress = TFDirector:getChildByPath(Panel_res_collect,"LoadingBar_progress")
		local Label_res_time = TFDirector:getChildByPath(Panel_res_collect,"Label_res_time")
		
		Label_res_time.timingFunc = function ( ... )
			local time = data.resUpTime or 0
			local remandTime = math.max(0, time - ServerDataMgr:getServerTime())
			local day,hour, min, sec = Utils:getTimeDHMZ(remandTime, true)
  			Label_res_time:setTextById(800026,hour, min, sec)
			
			local time1 = data.resStartTime or 0
  			local allTime = math.max(1, time - time1)
			LoadingBar_progress:setPercent(100 - remandTime*100/allTime)
			if data.resCount == self.activityInfo.extendData.collectCountLimit then
				Label_res_time:setTextById(12032018)
			end
		end
		if table.find(self.timingNode,Label_res_time) == -1 then
			table.insert(self.timingNode,Label_res_time)
		end
		Label_res_time.timingFunc()
	elseif cfgDisplay.displayDetail == 3 then
		self.Panel_boss_bar:show()
		local pos = eventNode:getPosition()
		local parentPos = eventNode:getParent():getPosition()
		pos.x = parentPos.x + pos.x
		pos.y = parentPos.y + pos.y
		self.Panel_boss_bar:setPosition(ccp(pos.x, pos.y + 25))
		local Image_boss_icon = TFDirector:getChildByPath(self.Panel_boss_bar,"Image_boss_icon")
		local Label_end_time = TFDirector:getChildByPath(self.Panel_boss_bar,"Label_end_time")
		Image_boss_icon:setTexture(cfgDisplay.invadeIcon)
		Label_end_time.timingFunc = function ( ... )
			local remandTime = math.max(0, data.replaceEnd - ServerDataMgr:getServerTime())
			local day, hour, min, sec = Utils:getTimeDHMZ(remandTime, true)
			if day == "00" then
  				Label_end_time:setTextById(800027,hour, min)
  			else
  				Label_end_time:setTextById(800069,day, hour)
  			end
		end

		if table.find(self.timingNode,Label_end_time) == -1 then
			table.insert(self.timingNode,Label_end_time)
		end
		Label_end_time.timingFunc()
	end

	eventNode:setTouchEnabled(true)
	eventNode:onClick(function ( ... )
		if  not self.newYearFubenInfo then
			return
		end

		if self.newYearFubenInfo.stage == 1 and cfgCity.city > 1 then
			local frontInfo = self:getCityInfo(cfgCity.cityUnlock)
			if not data.dunPass 
				and frontInfo 
				and not frontInfo[1].dunPass then
				return
			end
		end
		local battleEnd = (self.activityInfo.extendData.activityduration.battleendtime - ServerDataMgr:getServerTime()) <= 0
		if battleEnd then
			Utils:showTips(12033026)
			return 
		end
		self:focusMap(cityId)
		if data.resOpen then
			Utils:openView("newyearFuben.NewYearResCollectPopView",data,cfgCity)
			return
		end

		if data.dunPass and data.replaceGame and data.replaceGame > 1 then
			self:goToPlayGames(cityId, area, data.replaceGame)
			return
		end

		local levelCfg = FubenDataMgr:getLevelCfg(data.dungeon)
    	local levelGroupCfg_ = FubenDataMgr:getLevelGroupCfg(levelCfg.levelGroupId)
		local chapterCfg_ = FubenDataMgr:getChapterCfg(levelGroupCfg_.dungeonChapterId)

		if levelCfg.dungeonType == EC_FBLevelType.NEWYEAR_DATING then -- 约会类型直接开始约会
            FubenDataMgr:send_DUNGEON_FIGHT_START(data.dungeon)
		else
			local isCanFighting = true
	        local cost = levelCfg.cost[1]
	        if cost then
	            local challengeCount = 1
	            isCanFighting = GoodsDataMgr:currencyIsEnough(cost[1], cost[2] * challengeCount)
	        end

	        if not isCanFighting then
	            local goodsCfg = GoodsDataMgr:getItemCfg(cost[1])
	            local name = TextDataMgr:getText(goodsCfg.nameTextId)
	            Utils:showTips(2100034, name)
	            return
	        end
	        if cfgDisplay.displayDetail == 3 then
	        	Utils:openView("newyearFuben.NewYearBossPreview",data)
	        else
	        	Utils:openView("fuben.FubenSquadView", chapterCfg_.type, data)
	        end
		end
	end)
end

function newYearMainLayer:getEventIcon(data, cfgDisplay)
	if data.resOpen then
		return "ui/activity/newyear_fuben/event_icon04.png"
	end
	if data.dunPass and data.replaceGame and data.replaceGame > 1 then
		if data.replaceGame == 2 then
			return "ui/activity/newyear_fuben/event_icon05.png"
		elseif data.replaceGame == 3 then
			return "ui/activity/newyear_fuben/event_icon06.png"
		elseif data.replaceGame == 4 then
			return "ui/activity/newyear_fuben/event_icon07.png"
		elseif data.replaceGame == 5 then
			return "ui/activity/newyear_fuben/event_icon08.png"
		elseif data.replaceGame == 6 then
			return "ui/activity/newyear_fuben/event_icon09.png"
		end	
	end
	return cfgDisplay.levelicon
end

function newYearMainLayer:onSubmitSuccessEvent(activitId, itemId, reward)
	if activitId == self.activityId then
	    Utils:showReward(reward)
	end
end

function newYearMainLayer:onShow()
	self.super.onShow(self)
end

function newYearMainLayer:onHide()
    self.super.onHide(self)
    local offset = self.map_scrollView:getContentOffset()
    local offsetStr = offset.x.."|"..offset.y
    CCUserDefault:sharedUserDefault():setStringForKey(MainPlayer:getPlayerId().."mojinmapoffset",offsetStr)
end

 function newYearMainLayer:onExit()
    self.super.onExit(self)
    
 end

function newYearMainLayer:focusMap(cityId, isDelay)
	local cityNode = self.cityNodes[cityId]
	local contentSize = self.map_scrollView:getSize()
	local innerContainer = self.map_scrollView:getInnerContainer()
	innerContainer:stopAllActions()
	local innerSize = innerContainer:getSize()
	local position = cityNode:Pos()
	local offset = self.map_scrollView:getContentOffset()
	local posX = -(position.x - 1136 / 2) 
    local posY = -(position.y - 640 / 2)
    local maxX = 0
    local maxY = 0
    local minX = 1136 - innerSize.width
    local minY = 640 - innerSize.height
    posX = posX > maxX and maxX or posX
    posX = posX < minX and minX or posX
    posY = posY > maxY and maxY or posY
    posY = posY < minY and minY or posY
    local distancX = math.abs(posX - offset.x)
    local distancY = math.abs(posY - offset.y)
    local distance = math.max(distancX, distancY)
    local time = distance / 1000

    if isDelay then
    	local offsetStr = CCUserDefault:sharedUserDefault():getStringForKey(MainPlayer:getPlayerId().."mojinmapoffset")
		if offsetStr and offsetStr ~= "" then
    		local vector = string.split(offsetStr,"|")
    		self.map_scrollView:setContentOffset(ccp(vector[1],vector[2]))
    	end
    	if self.newYearFubenInfo.stage == 1 then
    		self:timeOut(function()
	            self.map_scrollView:setContentOffset(ccp(posX,posY), time)
	        end ,1)
    	end
    else
    	self.map_scrollView:setContentOffset(ccp(posX,posY), time)
    end
end

function newYearMainLayer:removeEvents( ... )
	-- body
	self.super.removeEvents(self)
	self:removeCountDownTimer()
end

function newYearMainLayer:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, -1, nil, handler(self.onCountDownPer, self))
    end
end

function newYearMainLayer:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
    end
end

function newYearMainLayer:onCountDownPer()
  	for k,v in pairs(self.timingNode) do
  		v.timingFunc()
  	end
end

function newYearMainLayer:checkRedPoint()
	if not self.newYearFubenInfo then return end
	local hasTaskCanGet = false
	local tasks = self.activityInfo.extendData.sendDayAwardList or {}
	for i, v in pairs(tasks) do
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, v)
        local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, v)
       	if progressInfo.status == EC_TaskStatus.GET then
            hasTaskCanGet = true
        end
    end

    self.redPoint_task:setVisible(hasTaskCanGet)
end


--跳转小游戏[cityId:城市ID，area：城市上的点位，gameType：游戏类型]
function newYearMainLayer:goToPlayGames(cityId, area, gameType)
	Utils:openView("newYear.GameEnter",cityId,area,gameType)
end

return newYearMainLayer