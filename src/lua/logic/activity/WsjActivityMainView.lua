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

local WsjActivityMainView = class("WsjActivityMainView",BaseLayer)

local ghostChatper = TabDataMgr:getData("GhostChapter")

function WsjActivityMainView:ctor(activityId )
	-- body
	self.super.ctor(self)
	self.activityId = activityId
	self.activityInfo = ActivityDataMgr2:getActivityInfo(activityId)
	self:init("lua.uiconfig.activity.wsjMainLayer")
end

function WsjActivityMainView:initUI( ui )
	-- body
	self.super.initUI(self,ui)

	self.Label_time = TFDirector:getChildByPath(ui,"Label_time")
	self.Label_time_tip = TFDirector:getChildByPath(ui,"Label_time_tip")

	self.Button_progress = TFDirector:getChildByPath(ui,"Button_progress")
	self.Button_rank = TFDirector:getChildByPath(ui,"Button_rank")
	self.Button_shop = TFDirector:getChildByPath(ui,"Button_shop")
	self.Panel_show = TFDirector:getChildByPath(ui,"Panel_show"):show()
	self.Panel_hide = TFDirector:getChildByPath(ui,"Panel_hide"):hide()
	self.Label_record_time = TFDirector:getChildByPath(ui,"Label_record_time")
	self.Label_rank = TFDirector:getChildByPath(ui,"Label_rank")

	self.Panel_buff_item = TFDirector:getChildByPath(ui,"Panel_buff_item")

	self.ScrollView_map = TFDirector:getChildByPath(ui,"ScrollView_map")

	local ScrollView_buff = TFDirector:getChildByPath(self.Panel_show,"ScrollView_buff")
	self.uiList_buff = UIListView:create(ScrollView_buff)

	self.Button_hide = TFDirector:getChildByPath(ui,"Button_hide")
	self.Button_show = TFDirector:getChildByPath(ui,"Button_show")

	self.Label_rank:setText("---")
	self.Label_record_time:setText("--:--:--")
	self:initMap()
	self:updateCountDown()
	ActivityDataMgr2:reqHalloweenPass()
	ActivityDataMgr2:send_ACTIVITY_REQ_ACTIVITY_RANK(self.activityId)
end

function WsjActivityMainView:registerEvents( ... )
	-- body
	self.super.registerEvents(self)

    EventMgr:addEventListener(self, EV_ACTIVITY_MORE_RANK, handler(self.updateRankInfo, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_HALLOWEEN_PASS_RSP, handler(self.updateBuffList, self))
	self.Button_progress:onClick(function ( ... )
		-- body
		Utils:openView("activity.WsjBuffListView",self.activityId)
	end)

	self.Button_rank:onClick(function ( ... )
		-- body
		Utils:openView("activity.WsjRankView",self.activityId)
	end)

	self.Button_shop:onClick(function ( ... )
		-- body
		if self.activityInfo.extendData.jumpInterface then
			FunctionDataMgr:enterByFuncId(self.activityInfo.extendData.jumpInterface, unpack(self.activityInfo.extendData.jumpParamters or {}))
		end
	end)

	self.Button_hide:onClick(function ( ... )
		-- body
		self.Panel_show:hide()
		self.Panel_hide:show()
	end)

	self.Button_show:onClick(function ( ... )
		-- body
		self.Panel_show:show()
		self.Panel_hide:hide()
	end)

	self:addCountTimer()
end

function WsjActivityMainView:updateBuffList( ... )
	-- body
	local index = 1
	for k,v in ipairs(self.activityInfo.extendData.chapterIdList) do  -- 异闻id同章节id相同
		local cfg = ghostChatper[v]

		if cfg then
			local item = self.uiList_buff:getItem(index)
			if not item then
				item = self.Panel_buff_item:clone()
				self.uiList_buff:pushBackCustomItem(item)
			end
			self:updateBuffItem(item, cfg)
		end
		index = index + 1
	end
end

function WsjActivityMainView:updateRankInfo( rankData )
	-- body
	if self.activityId ~= rankData.activityId then
		return
	end

	self.rank = rankData.myRank
	self.rankScore = rankData.myScore

	self.showRankList = ranks

	if self.rank == -1 then
		self.Label_rank:setTextById(14240013)
	else
		self.Label_rank:setText(self.rank)
	end

	if self.rankScore > 0 then
		local mill = self.rankScore%1000
		local sec = math.floor(self.rankScore/1000)%60
		local min = math.floor(math.floor(self.rankScore/1000)/60)%60
		self.Label_record_time:setText(string.format("%02d:%02d.%03d",min,sec,mill))
		else
		self.Label_record_time:setText("--:--:--")
	end
end

function WsjActivityMainView:removeEvents( ... )
	-- body
	self.super.removeEvents(self)
	self:removeCountTimer()
end

function WsjActivityMainView:addCountTimer( ... )
	-- body
	self.timer = TFDirector:addTimer(1000,-1,nil,handler(self.updateCountDown,self))
end

function WsjActivityMainView:removeCountTimer( ... )
	-- body
	if self.timer then
		TFDirector:stopTimer(self.timer)
		TFDirector:removeTimer(self.timer)
		self.timer = nil
	end
end

function WsjActivityMainView:onShow( )
	-- body
	self.super.onShow(self)

	DatingDataMgr:triggerDating(self.__cname,"onShow")
	if Utils:getLocalSettingValue("wsjBossChapterFirstClick") == "TRUE" then
		DatingDataMgr:triggerDating(self.__cname,"onShow2")
	end
end

function WsjActivityMainView:updateCountDown()
    local serverTime = ServerDataMgr:getServerTime()
    local remainTime = math.max(0, self.activityInfo.extendData.teamTime - serverTime)
    local remainTime1 = math.max(0, self.activityInfo.showEndTime - serverTime)
    local textId = 13316502
    if remainTime == 0 then
   		textId = 13316503
    	remainTime = remainTime1
    end
    local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
    self.Label_time:setTextById(13316414, day, hour, min)
    self.Label_time_tip:setTextById(textId)
end

function WsjActivityMainView:initMap()
	-- body
	local mapNode = createUIByLuaNew("lua.uiconfig.activity.mapPanel")
	local size = mapNode:getContentSize()
	local viewSize = self.ScrollView_map:getContentSize()
    self.ScrollView_map:setInnerContainerSize(size)

    self.ScrollView_map:setBounceEnabled(false)
    self.ScrollView_map:addChild(mapNode)
    mapNode:runAnimation("Action0",-1)

	self.ScrollView_map:setContentOffset(ccp((viewSize.width - size.width)/2,(viewSize.height - size.height)/2))
	self.chapterItems = {}
	for i = 1,6 do
		self.chapterItems[i] = TFDirector:getChildByPath(mapNode,"Panel_build"..i..".Button_build")
		self.chapterItems[i]:onClick(function ( ... )
			-- body
			if Utils:getLocalSettingValue("wsjBossChapterFirstClick") ~= "TRUE" then
				Utils:showTips(13316415)
				return
			end
			Utils:openView("fuben.FubenTheaterLevelTip",nil,nil,self.activityInfo.extendData.chapterIdList[i])
		end)
	end

	self.bossItem = TFDirector:getChildByPath(mapNode,"Panel_boss.Button_build")
	local arrow = TFDirector:getChildByPath(mapNode,"Panel_boss.Image_arrow")
	arrow:setVisible(Utils:getLocalSettingValue("wsjBossChapterFirstClick") ~= "TRUE")

	self.bossItem:onClick(function ( ... )
		-- body
		arrow:hide()
		Utils:setLocalSettingValue("wsjBossChapterFirstClick", "TRUE")

		if self.activityInfo.extendData.teamTime < ServerDataMgr:getServerTime() then
			Utils:showTips(13316504)
			return
		end
		local _levelCfg = TabDataMgr:getData("GhostDungeon",self.activityInfo.extendData.teamLevelId)
		Utils:openView("teamFight.TeamLevelPreview", {levelCfg = _levelCfg})
	end)
end

function WsjActivityMainView:updateBuffItem( item, cfg )
	-- body
	local Panel_finish = TFDirector:getChildByPath(item,"Panel_finish"):hide()
	local Panel_progress = TFDirector:getChildByPath(item,"Panel_progress"):hide()

	local passNum, totalNum = FubenDataMgr:getChapterPassLevelNum(cfg.id,EC_FBDiff.SIMPLE)
	local node = passNum >= totalNum and Panel_finish or Panel_progress
	node:show()
	local Label_content = TFDirector:getChildByPath(node,"Label_content")

	local nameText1 = TextDataMgr:getText(cfg.name1)
	local nameText2 = TextDataMgr:getText(cfg.name2)
	Label_content:setText(nameText1..nameText2..":("..passNum.."/"..totalNum..")")
end

return WsjActivityMainView