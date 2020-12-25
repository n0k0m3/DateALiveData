
local BossChallegeMainView = class("BossChallegeMainView",BaseLayer)

function BossChallegeMainView:ctor( data )
	self.super.ctor(self,data)
	self:initData()
	self:init("lua.uiconfig.fuben.bossChallegeMainView")
end

function BossChallegeMainView:initData( )
	self.bossCfg = FubenDataMgr:getBossChallengeCurLevel()
	self.medalItems = {500128,500129,500130}
end

function BossChallegeMainView:initUI( ui )
	self.super.initUI(self,ui)
	local Image_open_time = TFDirector:getChildByPath(ui,"Image_open_time")
	self.stageLabel       = TFDirector:getChildByPath(Image_open_time,"Label_title")
	self.stageTimeLabel   = TFDirector:getChildByPath(Image_open_time,"Label_open_time")
	self.stageRount 	  = TFDirector:getChildByPath(Image_open_time,"Label_round")
	self.Image_hero       = TFDirector:getChildByPath(ui,"Image_hero")
	self.Label_boss_name = TFDirector:getChildByPath(ui,"Label_boss_name")
	self.Panel_tips_info  = TFDirector:getChildByPath(ui,"Panel_tips_info")
	self.Label_tips = TFDirector:getChildByPath(self.Panel_tips_info,"Label_tips")
	self.ImageTips = {}
	for i=1,3 do
		self.ImageTips[i] = TFDirector:getChildByPath(self.Panel_tips_info,"Image_tips"..i)
	end

	self.Panel_level_info = TFDirector:getChildByPath(ui,"Panel_level_info")
	
	local ScrollView_flags     = TFDirector:getChildByPath(self.Panel_level_info,"ScrollView_flags")
	self.ListViewFlags = UIListView:create(ScrollView_flags)
	local ScrollView_rewards     = TFDirector:getChildByPath(self.Panel_level_info,"ScrollView_rewards")
	self.ListViewRewards = UIListView:create(ScrollView_rewards)

	self.Button_enter     = TFDirector:getChildByPath(ui,"Button_enter")
	self.Panel_prefabe    = TFDirector:getChildByPath(ui,"Panel_prefabe")
	self.Panel_flag_item  = TFDirector:getChildByPath(self.Panel_prefabe,"Panel_flag_item")
	self.Panel_reward_item  = TFDirector:getChildByPath(self.Panel_prefabe,"Panel_reward_item")

	self:refreshView()
	self:addCountDownTimer()
end

function BossChallegeMainView:refreshView()
	self.Image_hero:setTexture(self.bossCfg.bossPicture)
	self.Image_hero:setScale(self.bossCfg.roleSize or 0.6)
	local pos = ccp(373 + self.bossCfg.pictureOffset.x,312 + self.bossCfg.pictureOffset.y)
	self.Image_hero:setPosition(pos)

    self:updateTimeFunc()
	self:updatePanelTipsInfo()
	self:updatePanelLevelInfo()
end


function BossChallegeMainView:updatePanelTipsInfo()
	self.Label_tips:setText(TextDataMgr:getText(12035010))
	local activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.BOSS_CHALLENGE)[1]
    if activityId then 
    	self.activityInfo = ActivityDataMgr2:getActivityInfo(activityId)
    	for i,v in ipairs(self.medalItems) do
    		local image_icon = self.ImageTips[i]
    		local itemCfg = GoodsDataMgr:getItemCfg(self.medalItems[i])
    		image_icon:setTexture(itemCfg.icon)
    		
    		local count = self.activityInfo.extendData.medalRecord and self.activityInfo.extendData.medalRecord[self.medalItems[i]] or 0
    		TFDirector:getChildByPath(image_icon,"Label_tip_count"):setText("x"..count)
    	end
    end
end

function BossChallegeMainView:updatePanelLevelInfo( )
	self.ListViewFlags:removeAllItems()
	local goalDescribe = self.bossCfg.goalDescribe
	for i,desc in ipairs(goalDescribe) do
		local item = self.Panel_flag_item:clone()
		local itemCfg = GoodsDataMgr:getItemCfg(self.medalItems[i])
		TFDirector:getChildByPath(item,"Image_flag_icon"):setTexture(itemCfg.icon)
		TFDirector:getChildByPath(item,"Label_flag_desc"):setText(desc)
		local isReach = FubenDataMgr:judgeStarIsActive(self.bossCfg.dungeonID, i)
		TFDirector:getChildByPath(item,"Image_state"):setVisible(isReach)
		self.ListViewFlags:pushBackCustomItem(item)
	end

	self.ListViewRewards:removeAllItems()
	local activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.BOSS_CHALLENGE)[1]
    if activityId then 
    	self.activityInfo = ActivityDataMgr2:getActivityInfo(activityId)
    	local items = ActivityDataMgr2:getItems(activityId)
    	for k,v in pairs(items) do
    		local info = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, v)
    		local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, v)

    		if table.count(info.reward) > 0 then
    			local item = self.Panel_reward_item:clone()
				TFDirector:getChildByPath(item,"Label_get"):setVisible(progressInfo.status == EC_TaskStatus.ING)
				TFDirector:getChildByPath(item,"Label_geted"):setVisible(progressInfo.status == EC_TaskStatus.GETED)
				local Button_get = TFDirector:getChildByPath(item,"Button_get")
				Button_get:setVisible(progressInfo.status == EC_TaskStatus.GET)
				Button_get:setTouchEnabled(progressInfo.status == EC_TaskStatus.GET)
				Button_get:onClick(function ()
					ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityInfo.id, v)
				end)

				local ListViewItems = UIListView:create(TFDirector:getChildByPath(item,"ScrollView_items"))
				for cid,count in pairs(info.reward) do
			        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
			        Panel_goodsItem:Scale(0.63)
			        PrefabDataMgr:setInfo(Panel_goodsItem, cid, count)
			        ListViewItems:pushBackCustomItem(Panel_goodsItem)
			    end

			    local madelInfo = {}
       			for madelCid,madelNum in pairs(progressInfo.extend.itemsCount) do
       				table.insert(madelInfo,{cid = tonumber(madelCid),num = madelNum})
       			end
       			table.sort(madelInfo, function (a,b)
       				return a.cid < b.cid
       			end)
			    for i=1,3 do
			    	local info = madelInfo[i]
			    	local image_icon = TFDirector:getChildByPath(item,"Image_madel_icon"..i)
			    	local Label_count = TFDirector:getChildByPath(image_icon,"Label_count")
			    	if info then
				    	local itemCfg = GoodsDataMgr:getItemCfg(info.cid)
				    	image_icon:setTexture(itemCfg.icon)
				    	image_icon:setScale(0.60)
				    	Label_count:setText("x"..info.num)
				    else
				    	image_icon:hide()
				    	Label_count:hide()
				    end
			    end
				self.ListViewRewards:pushBackCustomItem(item)
    		end
    	end
    end
end


function BossChallegeMainView:updateTimeFunc()
	local openTime,closeTime,readyTime,endTime,curRound,maxRound = FubenDataMgr:getBossChallengeTimes()
	local serverTime = ServerDataMgr:getServerTime()
	if readyTime > 0 then
		self.stageLabel:setTextById(3300017)
        local remainTime = math.max(0, readyTime - serverTime)
        local day, hour, min = Utils:getFuzzyDHMS(remainTime)
        if day > 0 then
        	hour = hour + day * 24
        end
        self.stageTimeLabel:setTextById("r80003", hour, min)
        if remainTime > 0 then
        	self.Button_enter:setTouchEnabled(false)
        	self.Button_enter:setGrayEnabled(true)
        else
        	self.Button_enter:setTouchEnabled(true)
        	self.Button_enter:setGrayEnabled(false)
        end
    else
    	self.stageLabel:setTextById(3300018)
        local remainTime = math.max(0, endTime - serverTime)
        local day, hour, min = Utils:getFuzzyDHMS(remainTime)
        if day > 0 then
        	hour = hour + day * 24
        end
        self.stageTimeLabel:setTextById("r80001", hour, min)
        self.Button_enter:setTouchEnabled(true)
        self.Button_enter:setGrayEnabled(false)
    end
    self.stageRount:setText(TextDataMgr:getText(12035009)..curRound.."/"..maxRound)
    if closeTime > 0 and closeTime < serverTime then
    	AlertManager:closeLayer(self)
    end
end

function BossChallegeMainView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityInfo.id == activitId then
    	Utils:showReward(reward)
    end
    self:updatePanelLevelInfo()
end


function BossChallegeMainView:registerEvents()
	self.super.registerEvents(self)
	self.Button_enter:onClick(function ( ... )
		Utils:openView("fuben.BossChallegePreview", self.bossCfg.id)
	end)
	
	EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.refreshView, self))
	EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.updatePanelLevelInfo, self))
end

function BossChallegeMainView:removeCountDownTimer()
	if self.countDownTimer_ then
		TFDirector:stopTimer(self.countDownTimer_)
		TFDirector:removeTimer(self.countDownTimer_)
		self.countDownTimer_ = nil
	end
end

function BossChallegeMainView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(5000, -1, nil, handler(self.updateTimeFunc, self))
    end
end

function BossChallegeMainView:removeEvents()
    self:removeCountDownTimer()
end


return BossChallegeMainView