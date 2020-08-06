local BlackAndWhiteActivityView = class("BlackAndWhiteActivityView", BaseLayer)


function BlackAndWhiteActivityView:ctor(...)
    self.super.ctor(self)
    self:init("lua.uiconfig.activity.BlackAndWhiteActivityView")

end

function BlackAndWhiteActivityView:initUI(ui)
	self.super.initUI(self, ui)
	
	uiRoot = TFDirector:getChildByPath(ui, "Panel_root")
	--imageContent = TFDirector:getChildByPath(uiRoot, "Image_content")
	
	self._rankBtn = TFDirector:getChildByPath(ui, "Image_rank"):hide()
	self._gotoBtn = TFDirector:getChildByPath(ui, "Image_main")
	
	self._time = TFDirector:getChildByPath(ui, "label_time")
	self._item = TFDirector:getChildByPath(ui, "Image_item")
	self._cost = TFDirector:getChildByPath(ui, "Label_itemcost")
	
	self:refreshView()
end

function BlackAndWhiteActivityView:refreshView()
	
	--刷新道具消耗
	local cfg = BlackAndWhiteDataMgr:getCfg()
	for k, v in ipairs(cfg) do
		local cfg = TabDataMgr:getData("HighTeamDungeon", v)
		if #table.keys(cfg.joinCost) > 0  then
			local key = table.keys(cfg.joinCost)[1]
			local value = cfg.joinCost[key]
			--costItemId = key
			--costNum = value
			self._item:setTexture(GoodsDataMgr:getItemCfg(key).icon)
			self._cost:setText("消耗" .. value .. "/" .. GoodsDataMgr:getItemCount(key, false))
			--self._uis[index][6]:setScale(0.3)
			--self._uis[index][7]:setText(value)
			--self._uis[index][6]:onClick(function()
			--		Utils:showInfo(key, nil, true)
			--end)
		end
		break
	end
	
	--设置活动时间
	local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.BLACK_WHITE)
	if #activity > 0 then
		self.activityId_ = activity[1]
        self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId_)
		
		local _startyear, _startmonth, _startday = Utils:getDate(self.activityInfo.startTime, true)
		
		local _endyear, _endmonth, _endday = Utils:getDate(self.activityInfo.endTime, true)
		self._time:setText(_startmonth .. "." .. _startday .. " - " .. _endmonth .. "." .. _endday)
	end
	
	dump(self.activityInfo)
	print(ServerDataMgr:getServerTime())
	
end

function BlackAndWhiteActivityView:registerEvents()
	self._rankBtn:onClick(
		function()
			BlackAndWhiteDataMgr:send_NEW_WORLD_REQ_BLACK_WHITE_RANK()
		end)
	self._gotoBtn:onClick(
		function()
			local serverTime = ServerDataMgr:getServerTime()
			if serverTime > self.activityInfo.endTime then
				Utils:showTips(14110403)
			else
				local myLv = MainPlayer:getPlayerLv()
				if myLv < TabDataMgr:getData("DiscreteData",81029).data.level then
					Utils:showTips(14110423)
				else
					BlackAndWhiteDataMgr:send_NEW_WORLD_REQ_BLACK_WHITE()
				end
				
			end
			--BlackAndWhiteDataMgr:send_NEW_WORLD_REQ_BLACK_WHITE()
			--Utils:openView("blackAndWhite.BlackAndWhiteMainView")
		end)
		
	EventMgr:addEventListener(self, EV_ACTIVITY_BLACKWHITE_RANKING, handler(self.onOpenBlackWhiteRanking, self))
end


function BlackAndWhiteActivityView:onOpenBlackWhiteRanking(data)
	dump(data)
    Utils:openView("blackAndWhite.BlackAndWhiteRankingView", data)
end

return BlackAndWhiteActivityView