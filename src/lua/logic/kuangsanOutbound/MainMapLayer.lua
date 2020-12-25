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
* -- 副本主界面
]]

local MainMapLayer = class("MainMapLayer",BaseLayer)

function MainMapLayer:ctor( data )
	-- body
	self.super.ctor(self,data)

	self.timingNode = {}

	FubenDataMgr:cacheSelectFubenType(EC_FBType.KSAN_FUBEN)
    self.activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.KUANGSAN_FUBEN)[1]
    self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	self:init("lua.uiconfig.activity.mainMapLayer")
end

function MainMapLayer:initUI( ui )
	-- body
	self.super.initUI(self,ui)

	local map_scrollView = TFDirector:getChildByPath(ui,"ScrollView_map")
	self.map_scrollView = UIListView:create(map_scrollView)
	self.Panel_ui = TFDirector:getChildByPath(ui,"Panel_ui")
	self.Button_task = TFDirector:getChildByPath(ui,"Button_task")
	self.redPoint_task = TFDirector:getChildByPath(self.Button_task,"RedTips") 
	self.Button_rank = TFDirector:getChildByPath(ui,"Button_rank")
	self.Button_collect = TFDirector:getChildByPath(ui,"Button_collect")
	self.redPoint_collect = TFDirector:getChildByPath(self.Button_collect,"RedTips") 
	self.Button_shop = TFDirector:getChildByPath(ui,"Button_shop")
	self.Image_stage_bg = TFDirector:getChildByPath(ui,"Image_stage_bg")

	self.Panel_point_status = TFDirector:getChildByPath(ui,"Panel_point_status")
	self.Panel_effect = TFDirector:getChildByPath(ui,"Panel_effect")

	self.Image_stage = TFDirector:getChildByPath(self.Image_stage_bg,"Image_stage")
	self.Label_stage = TFDirector:getChildByPath(self.Image_stage_bg,"Label_stage")
	self.Label_timing = TFDirector:getChildByPath(self.Image_stage_bg,"Label_timing")

	self.Panel_resource = TFDirector:getChildByPath(ui,"Panel_resource")
	self.resource = {}
	for i = 1,3 do
		self.resource[i] = TFDirector:getChildByPath(ui,"resource_"..i)
	end

	
	self.Panel_stage = {}
	for i = 1,3 do
		self.Panel_stage[i] = TFDirector:getChildByPath(ui,"Panel_stage"..i)
	end

	self:initMapLayer()

	self.Panel_ui:hide()
	self.Label_timing.timingFunc = function ( ... )
		if  not self.activityInfo.historyInfo then
			return
		end

		local camp = self.activityInfo.historyInfo.camp
		if camp ~=0 then
			self.Image_stage:setTexture("ui/activity/kuangsan_fuben/main/boss_smallHead_"..camp..".png")
		end

		local stageId = 12032015 + self.activityInfo.historyInfo.stage - 1
		self.Label_stage:setTextById(stageId)
		local stageEnd = self.activityInfo.historyInfo.stageEnd
		local remandTime = math.max(0, stageEnd - ServerDataMgr:getServerTime())
		local day,hour, min, sec = Utils:getFuzzyDHMS(remandTime,true)
		if day == "00" then
	        self.Label_timing:setTextById(1260001, hour, min)
	    else
	        self.Label_timing:setTextById(800069, day, hour)
	    end

		self:updateResourcePanel()
	end
	table.insert(self.timingNode,self.Label_timing)
	self.Label_timing.timingFunc()
	-- 打开界面时请求数据
	ActivityDataMgr2:send_ACTIVITY_REQ_KURUMI_HISTORY_INFO()
	ActivityDataMgr2:send_ACTIVITY_REQ_KURUMI_HISTORY_RANK()
end

function MainMapLayer:registerEvents(  )
	self.super.registerEvents(self)

    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_KUANGSAN_FUBEN_CITYRSP, handler(self.onUpdateCityInfo, self))
    EventMgr:addEventListener(self, EV_KUANGSAN_FUBEN_RANKS, handler(self.onUpdateCityInfo, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.onUpdateCityInfo, self))
	EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.checkRedPoint, self))
	
	self.Button_task:onClick(function ()
			Utils:openView("kuangsanOutbound.KsOutbountTaskView")
		end)
	
	self.Button_rank:onClick(function ()
			Utils:openView("kuangsanOutbound.KsOutRankView")
		end)
	
	self.Button_collect:onClick(function ()
			Utils:openView("kuangsanOutbound.KsOutbountResCollectView")
		end)
	
	self.Button_shop:onClick(function ()
		FunctionDataMgr:enterByFuncId(self.activityInfo.extendData.jumpInterface, unpack(self.activityInfo.extendData.jumpParamters or {}))
		end)
	self:addCountDownTimer()
end

function MainMapLayer:onUpdateCityInfo()
    self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	if not self.activityInfo.historyInfo then return end

    local curstage = self.activityInfo.historyInfo.stage

    local stage = curstage

    local cityInfo = self:getCityInfo(self.activityInfo.extendData.unlockCampCity)
    if cityInfo and cityInfo.pass and self.activityInfo.historyInfo.camp == 0 then
    	Utils:openView("kuangsanOutbound.KsOutbountCampChooseView")
    end

    for k,v in pairs(self.Panel_stage) do
    	v:setVisible(k == stage)
    end

    if stage == 1 then
    	self:updateStagePanel1()
    elseif stage == 2 then
    	self:updateStagePanel2()
    elseif stage == 3 then
    	self:updateStagePanel3()
    end

    self:initMapLayer()

	self.Label_timing.timingFunc()
	self:updateResourcePanel()
  	self:checkRedPoint()
	self.Panel_ui:show()
end

function MainMapLayer:onSubmitSuccessEvent(activitId, itemId, reward)
	if activitId == self.activityId then
	    Utils:showReward(reward)
	end
end

function MainMapLayer:updateStagePanel1()
	local Label_progress = TFDirector:getChildByPath(self.Panel_stage[1],"Label_progress")

	local cityNumbers = table.count(TabDataMgr:getData("KurumiCity"))

	local occupys = 0
	for k,v in pairs(self.activityInfo.historyInfo.cities) do
		if v.pass then
			occupys = occupys + 1
		end
	end

	Label_progress:setText(occupys.."/"..cityNumbers)
end

function MainMapLayer:updateStagePanel2()
	local scrollView_bossList = TFDirector:getChildByPath(self.Panel_stage[2],"scrollView_bossList")
	local bossItem = TFDirector:getChildByPath(self.Panel_stage[2],"bossItem"):hide()

	if not scrollView_bossList.uiList then
		scrollView_bossList.uiList = UIListView:create(scrollView_bossList)
	end

	local bosses = self:getBossInCity( )
	scrollView_bossList.uiList:removeAllItems()
	for k,v in pairs(bosses) do
		local item = bossItem:clone()
		item:show()
		local Image_head = TFDirector:getChildByPath(item,"Image_head")
		local Label_cityName = TFDirector:getChildByPath(item,"Label_cityName")
		--todo 数据填充
		local cityCfg = TabDataMgr:getData("KurumiCity",v.id)

		Label_cityName:setTextById(cityCfg.name)
		Image_head:setTexture("ui/activity/kuangsan_fuben/main/boss_smallHead_"..v.camp..".png")

		scrollView_bossList.uiList:pushBackCustomItem(item)
	end
end

function MainMapLayer:getBossInCity( )
	local bosses = {}
	for k,v in pairs(self.activityInfo.historyInfo.cities) do
		if v.invaded then
			for _k,_v in pairs(v.invadedCamp) do
				table.insert(bosses, { camp = _v, id = v.id } )
			end
		end
	end
	return bosses
end

function MainMapLayer:updateStagePanel3()
	local scrollView_rankList = TFDirector:getChildByPath(self.Panel_stage[3],"scrollView_rankList")
	local rankItem = TFDirector:getChildByPath(self.Panel_stage[3],"rankItem"):hide()

	if not scrollView_rankList.uiList then
		scrollView_rankList.uiList = UIListView:create(scrollView_rankList)
	end
	scrollView_rankList.uiList:removeAllItems()

	self.activityInfo.historyRank = self.activityInfo.historyRank or {}
	local historyRankTemp = {}
	for _rankIdx,_rankInfo in ipairs(self.activityInfo.historyRank) do
		historyRankTemp[_rankInfo.camp] = {info = _rankInfo, rank = _rankIdx}
	end

	local ranks = {}
	local noRanks = {}
	for _,_camp in ipairs(self.activityInfo.extendData.campChose) do
		if historyRankTemp[_camp] then
			table.insert(ranks,{camp = _camp, score = historyRankTemp[_camp].info.score, rank = historyRankTemp[_camp].rank})
		else
			table.insert(noRanks,{camp = _camp, score = 0})
		end
	end
	table.sort(ranks, function( a,b )
		return a.rank < b.rank
	end)
	table.sort(noRanks, function( a, b )
		return a.camp < b.camp
	end)
	for i,_info in ipairs(noRanks) do
		table.insert(ranks, _info)
	end
	
	for k,v in ipairs(ranks) do
		local item = rankItem:clone()
		item:show()
		local Image_head = TFDirector:getChildByPath(item,"Image_head")
		local Label_bossName = TFDirector:getChildByPath(item,"Label_bossName")
		local score = TFDirector:getChildByPath(item,"score")
		local Image_rank = TFDirector:getChildByPath(item,"Image_rank")
		local icon = TFDirector:getChildByPath(item,"icon")
		icon:setTexture("ui/activity/kuangsan_fuben/main/camppoint.png")
		Image_head:setTexture("ui/activity/kuangsan_fuben/main/boss_smallHead_"..v.camp..".png")
		score:setText(v.score)
		Label_bossName:setTextById(12032032 + v.camp - 1)

		local rk = 10 + k - 1
		Image_rank:setTexture("ui/activity/kuangsan_fuben/main/0"..rk..".png")

		scrollView_rankList.uiList:pushBackCustomItem(item)
	end
end
function MainMapLayer:updateResourcePanel()
	local showResourceIds = self.activityInfo.extendData.resource or {}
	for k,v in ipairs(self.resource) do
		local id = showResourceIds[k]
		if id then
			v:setVisible(true)
			local icon = TFDirector:getChildByPath(v,"icon")
			local Label_num = TFDirector:getChildByPath(v,"Label_num")
			icon:setTexture(GoodsDataMgr:getItemCfg(id).icon)
			Label_num:setText(GoodsDataMgr:getItemCount(id))
		else
			v:setVisible(false)
		end
	end
end

function MainMapLayer:getCityInfo(id)
	if not self.activityInfo.historyInfo then return nil end
	for k,v in pairs(self.activityInfo.historyInfo.cities) do
		if v.id == id then
			return v
		end
	end
	return nil
end

function MainMapLayer:initMapLayer()
	-- body
	self.cityNodes = self.cityNodes or {}

	local citys = TabDataMgr:getData("KurumiCity")

	if not self.cityMap then
		self.cityMap = createUIByLuaNew("lua.uiconfig.activity.cityMap")
		self.map_scrollView:pushBackCustomItem(self.cityMap)
	end

	local function createEffectAni( aniNode )
		local image1 = TFDirector:getChildByPath(aniNode,"image_1")
		local image2 = TFDirector:getChildByPath(aniNode,"image_2")
		local image3 = TFDirector:getChildByPath(aniNode,"image_3")

		local seq = Sequence:create({
                    CallFunc:create(function()
                        image1:setScale(1)
                        image1:setOpacity(255)
                    end),
                    Spawn:create({
                            --CallFunc:create(function()
                            --        item:show()
                            --end),
                            CCFadeOut:create(0.5),
                            ScaleTo:create(0.5, 1.1),
                            --Sequence:create({
                            --        ScaleTo:create(0.05, 1.5),
                            --        DelayTime:create(0.1),
                            --        ScaleTo:create(0.05, 1.0),
                            --}),
                    })
            })
        image1:runAction(CCRepeatForever:create(seq))
	end
	local focusCityId = 1
	for k,v in ipairs(citys) do
		if not self.cityNodes[v.id] then
			local point = TFDirector:getChildByPath(self.cityMap,"panel_point"..k)
			local Panel_status = TFDirector:getChildByPath(point,"Panel_status")
			point.statusNode = self.Panel_point_status:clone()
			point.statusNode:setPosition(ccp(0,0))
			Panel_status:addChild(point.statusNode)

			local Panel_effect = TFDirector:getChildByPath(point.statusNode,"Panel_effect")
			local Spine_curEffect = TFDirector:getChildByPath(point.statusNode,"Spine_curEffect")
			Spine_curEffect:playByIndex(0,-1,-1,1)
			point.curEffect = Spine_curEffect
			point.Panel_effect = self.Panel_effect:clone()
			point.Panel_effect:setPosition(ccp(0,0))
			Panel_effect:addChild(point.Panel_effect)
			createEffectAni(point.Panel_effect)
			self.cityNodes[v.id] = point
		end
		local cityPoint = self.cityNodes[v.id]
		local info = self:getCityInfo(v.id)
		local preInfo = self:getCityInfo(v.cityUnlock)
		if info and (not info.pass and (not preInfo or preInfo.pass) or info.invaded) then
			focusCityId = v.id
		end

		self:updatePointStatus(cityPoint, v, info)
	end
	if self.lastFocusCityId ~= focusCityId then
		self:focusMap(focusCityId)
		self.lastFocusCityId = focusCityId
	end


	local info = self:getCityInfo(1)
end

function MainMapLayer:onShow()
	self.super.onShow(self)
	if not CCUserDefault:sharedUserDefault():getBoolForKey("isPlayKuansanFubenDating"..MainPlayer:getPlayerId()..self.activityInfo.extendData.datingUID) then 
		FunctionDataMgr:jStartDating(self.activityInfo.extendData.datingUID)
		CCUserDefault:sharedUserDefault():setBoolForKey("isPlayKuansanFubenDating"..MainPlayer:getPlayerId()..self.activityInfo.extendData.datingUID,true)
	end
end

function MainMapLayer:focusMap(cityId)

	local cityNode = self.cityNodes[cityId]
	local posX = cityNode:getPositionX()

	local offsetX = self.map_scrollView:getContentSize().width/2 - posX
	local minOffsetX = self.map_scrollView:getContentSize().width - self.cityMap:getContentSize().width

    local percentX = 0
    if offsetX ~= 0 then
        percentX = offsetX * 100 / minOffsetX
    end
   
    percentX = math.max(0,percentX)
    percentX = math.min(100,percentX)
    self.map_scrollView.scrollView_:scrollTo(TF_SCROLLVIEW_SCROLL_TO_PERCENT_HORIZONTAL, 0.2, false, -percentX, 0)
end

function MainMapLayer:updatePointStatus(cityNode, cityCfg, data)

	local image_icon = TFDirector:getChildByPath(cityNode,"image_icon")

	image_icon:onClick(function ( ... )
		if not data then
			Utils:showTips(cityCfg.openTips)
			return
		end

		local levelCfg = FubenDataMgr:getLevelCfg(data.dungeon)
    	local levelGroupCfg_ = FubenDataMgr:getLevelGroupCfg(levelCfg.levelGroupId)
		local chapterCfg_ = FubenDataMgr:getChapterCfg(levelGroupCfg_.dungeonChapterId)

		if levelCfg.dungeonType == EC_FBLevelType.KUANGSAN_DATING then -- 约会类型直接开始约会
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
			local cityInfo = self:getCityInfo(cityCfg.id)
			Utils:openView("fuben.FubenSquadView", chapterCfg_.type, cityInfo)
		
		end
	end)

	local item = cityNode.statusNode
	local Image_bar_bg = TFDirector:getChildByPath(item,"Image_bar_bg")
	local Image_lock = TFDirector:getChildByPath(item,"Image_lock")
	local Label_name = TFDirector:getChildByPath(item,"Label_name")
	local Panel_status2 = TFDirector:getChildByPath(item,"Panel_status2"):hide()
	local Panel_status3 = TFDirector:getChildByPath(item,"Panel_status3"):hide()


	function updateStatus2( ... )
		local Image_head = TFDirector:getChildByPath(Panel_status2,"Image_head")
		local Label_timing = TFDirector:getChildByPath(Panel_status2,"Label_timing")

		local camp = data.invadedCamp[1]
		Image_head:setTexture("ui/activity/kuangsan_fuben/main/boss_smallHead_"..camp..".png")
		
		Label_timing.timingFunc = function ( ... )
			local remandTime = math.max(0, data.invadedEnd - ServerDataMgr:getServerTime())
			local day, hour, min, sec = Utils:getTimeDHMZ(remandTime, true)
  			Label_timing:setTextById(800069,day, hour)
		end

		if table.find(self.timingNode,Label_timing) == -1 then
			table.insert(self.timingNode,Label_timing)
		end
		Label_timing.timingFunc()
	end

	function updateStatus3( ... )

		for k,v in pairs(data.invadedCamp) do
			local boss = TFDirector:getChildByPath(Panel_status3,"boss"..k)

			local Image_head = TFDirector:getChildByPath(boss,"Image_head")
			Image_head:setTexture("ui/activity/kuangsan_fuben/main/boss_smallHead_"..v..".png")
		end
	end

	function updateBaseInfo( ... )

		Image_bar_bg:setVisible(data.resOpen)
		local loadingBar_process = TFDirector:getChildByPath(Image_bar_bg,"loadingBar_process")
		local Label_process = TFDirector:getChildByPath(Image_bar_bg,"Label_process")
		local Image_flag = TFDirector:getChildByPath(Image_bar_bg,"Image_flag")
		
		Label_process.timingFunc = function ( ... )
			local time = data.resUpTime or 0
			local remandTime = math.max(0, time - ServerDataMgr:getServerTime())
			local day,hour, min, sec = Utils:getTimeDHMZ(remandTime, true)
  			Label_process:setTextById(800026,hour, min, sec)
			
			local time1 = data.resStartTime or 0
  			local allTime = math.max(1, time - time1)
			loadingBar_process:setPercent(100 - remandTime*100/allTime)
			if data.resCount == cityCfg.collectLimit then
				Label_process:setTextById(12032018)
			end
		end

		if table.find(self.timingNode,Label_process) == -1 then
			table.insert(self.timingNode,Label_process)
		end

		Label_process.timingFunc()
	end

	Label_name:setTextById(cityCfg.name)
	local preCityData = self:getCityInfo(cityCfg.cityUnlock)
	local unLock =  cityCfg.cityUnlock == 0 or (preCityData and preCityData.pass)
	
	Image_bar_bg:setVisible(data)
	Image_lock:setVisible(not unLock)
	image_icon:setTouchEnabled(unLock)
	cityNode.Panel_effect:setVisible(data)

	if unLock then
		image_icon:setColor(ccc3(255,255,255))
	else
		image_icon:setColor(ccc3(150,150,150))
	end

	cityNode.curEffect:setVisible(unLock and (not data or not data.pass))

	if data then
		updateBaseInfo()
		local status = 1
		if data.invaded then
			status = self.activityInfo.historyInfo.stage
		end

		cityNode.Panel_effect:setVisible(status ~= 1 )

		if status == 2 then
			Panel_status2:show()
			updateStatus2()
		end
		
		if status == 3 then
			Panel_status3:show()
			updateStatus3()
		end
	end

end

function MainMapLayer:removeEvents( ... )
	-- body
	self.super.removeEvents(self)
	self:removeCountDownTimer()
end

function MainMapLayer:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, -1, nil, handler(self.onCountDownPer, self))
    end
end

function MainMapLayer:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
    end
end

function MainMapLayer:onCountDownPer()
  	for k,v in pairs(self.timingNode) do
  		v.timingFunc()
  	end
end

function MainMapLayer:checkRedPoint()
	if not self.activityInfo.historyInfo then return end
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

    local canCollect = false
    for k,v in pairs(self.activityInfo.historyInfo.cities) do
    	if v.resCount and v.resCount > 0 then
    		canCollect = true
    	end
	end
	self.redPoint_collect:setVisible(canCollect)
end

return MainMapLayer