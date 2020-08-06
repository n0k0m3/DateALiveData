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
* -- 圣诞关卡界面
]]

local ChristmasTaskView = class("ChristmasTaskView",BaseLayer)

function ChristmasTaskView:ctor( data )
	-- body
	self.super.ctor(self,data)
	self:showPopAnim(true)
	self:init("lua.uiconfig.activity.christmasTaskView")
end

function ChristmasTaskView:initUI(ui)
	-- body
	self.super.initUI(self,ui)
	self.Button_teamRoom = TFDirector:getChildByPath(ui,"Button_teamRoom")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	self.Button_help = TFDirector:getChildByPath(ui,"Button_help")
	local ScrollView_dungeon = TFDirector:getChildByPath(ui,"ScrollView_dungeon")
	self.uiList_dungeon = UIListView:create(ScrollView_dungeon)
	self.uiList_dungeon:setItemsMargin(5)

	self.Button_refresh = TFDirector:getChildByPath(ui,"Button_refresh")
	self.refresh_Image_icon = TFDirector:getChildByPath(self.Button_refresh,"Image_icon")
	self.refresh_Label_num = TFDirector:getChildByPath(self.Button_refresh,"Label_num")


	self.Panel_cost1 = TFDirector:getChildByPath(ui,"Panel_cost1")
	self.Image_icon = TFDirector:getChildByPath(self.Panel_cost1,"Image_icon")
	self.Label_num = TFDirector:getChildByPath(self.Panel_cost1,"Label_num")

	self.Label_timing = TFDirector:getChildByPath(ui,"Label_timing")
	self.Label_count = TFDirector:getChildByPath(ui,"Label_count")

	self.Panel_dungeon = TFDirector:getChildByPath(ui,"Panel_dungeon")
	self:refreshView()

	self.Button_help:onClick(function ( ... )
		if self.activityInfo.extendData.helpInterface then
			local layer = require("lua.logic.common.HelpView"):new(self.activityInfo.extendData.helpInterface)
	        AlertManager:addLayer(layer)
	        AlertManager:show()
	    end
	end)
end

function ChristmasTaskView:addCountDownTimer(  )
	-- body
	self.timer = TFDirector:addTimer(1000,-1,nil,function ( ... )
		self:onCountDownCall()
	end)
	self:onCountDownCall()
end

function ChristmasTaskView:removeCountDownTimer( ... )
	-- body
	if self.timer then
		TFDirector:stopTimer(self.timer)
		TFDirector:removeTimer(self.timer)
		self.timer = nil

	end
end

function ChristmasTaskView:refreshView()

    local activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.CHRISTMAS_FIGHT)[1]
    self.activityInfo = ActivityDataMgr2:getActivityInfo(activityId)
    if (not activityId) or (not self.activityInfo) then 
    	self:removeEvents()
    	AlertManager:closeLayer(self) 
    	return 
    end

  	if not self.activityInfo.dungeonInfo then
	    return
	end	

	local dungeonLevels = self.activityInfo.dungeonInfo.levels or {}
	self.uiList_dungeon:removeAllItems()
	for k,dungeonLevel in ipairs(dungeonLevels) do
		local dungeonItem = self.Panel_dungeon:clone()
		self:updateDungeon(dungeonItem, dungeonLevel)
		self.uiList_dungeon:pushBackCustomItem(dungeonItem)
	end

	local id,num = next(self.activityInfo.extendData.showcost)
	self.Image_icon:setTexture(GoodsDataMgr:getItemCfg(tonumber(id)).icon)
	self.Label_num:setText(num)


	self.Image_icon:setTouchEnabled(true)
	
	self.Image_icon:onClick(function ( ... )
		-- body
		Utils:showInfo(tonumber(id))
	end)
end

function ChristmasTaskView:onCountDownCall()
	-- body
	local time = self.activityInfo.dungeonInfo.refreshTime or 0
	self.Label_timing:setText(Utils:getTimeCountDownString(time,2))

	self.Label_count:setText( self.activityInfo.extendData.helpnum - self.activityInfo.dungeonInfo.helpCount)

    local casts	= self.activityInfo.extendData.DungeonCost or {}
	local index = math.min(self.activityInfo.dungeonInfo.refreshCount + 1,#casts)
	
	local cost = casts[index]
	local costId,costNum = next(cost)

	
	if costId then
		self.refresh_Image_icon:show()
		self.refresh_Label_num:show()
		self.refresh_Image_icon:setTexture( GoodsDataMgr:getItemCfg(tonumber(costId)).icon )
		self.refresh_Label_num:setText( costNum )
		-- self.refresh_Image_icon:setTouchEnabled(true)
		self.refresh_Image_icon:onClick(function ( ... )
			-- body
			Utils:showInfo(tonumber(costId))
		end)
	else
		self.refresh_Image_icon:hide()
		self.refresh_Label_num:hide()
	end
end

function ChristmasTaskView:registerEvents( ... )
	self.super.registerEvents(self)

	self:addCountDownTimer()

	self.Button_close:onClick(function ( ... )
		AlertManager:closeLayer(self)
	end)
	
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, function ( ... )
        self:refreshView()
    end)
    
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, function ( ... )
        self:refreshView()
    end)

    local sureFunc = function ( ... )
    	-- body
    	ActivityDataMgr2:request_CHRISTMAS_REQ2019_CHRISTMAS_REFRESH()
    end


    self.Button_refresh:onClick(function ( ... )
    	-- body
    	local casts	= self.activityInfo.extendData.DungeonCost or {}
		local index = math.min(self.activityInfo.dungeonInfo.refreshCount + 1,#casts)
		local cost = casts[index]
		local id,num = next(cost)

    	local hasNotFinish = false

    	for k,v in pairs(self.activityInfo.dungeonInfo.levels) do
    		if not v.pass then
    			hasNotFinish = true
    		end
    	end
    	
    	local strId = "r2130507"
	    if hasNotFinish then
	    	strId = "r2130508"
	    end

	    local args = {
		        tittle = 2107025,
		        reType = "christmastaskrefresh",
		        content = TextDataMgr:getRText(strId,tonumber(num),#casts - self.activityInfo.dungeonInfo.refreshCount,#casts),
		        confirmCall = function ()
					if self.activityInfo.dungeonInfo.refreshCount >= #casts then
						Utils:showTips(13100075)
						return
					end

		        	if GoodsDataMgr:currencyIsEnough(tonumber(id),tonumber(num)) then
		        		sureFunc()
		            else
		                Utils:showAccess(tonumber(id))
		        	end
		        end,
		    }
		Utils:showReConfirm(args)
    end)

    self.Button_teamRoom:onClick(function ( ... )
		Utils:openView("teamPve.TeamRoomView",4)
    end)
end

function ChristmasTaskView:removeEvents()
	-- body
	self.super.removeEvents(self)
	self:removeCountDownTimer()
end

function ChristmasTaskView:updateDungeon( item, dungeonInfo)
	-- body
	local dungeonCfg = TabDataMgr:getData("SnowDungeon", dungeonInfo.cid)
	local image_icon = TFDirector:getChildByPath(item,"image_icon")
	local Image_gray = TFDirector:getChildByPath(item,"Image_gray")
	local Label_ChapterName = TFDirector:getChildByPath(item,"Label_ChapterName")
	image_icon:setTexture(dungeonCfg.pic)
	Label_ChapterName:setTextById(dungeonCfg.levelName)
	Image_gray:setVisible(dungeonInfo.pass)
	item:setTouchEnabled(not dungeonInfo.pass)
	item:onClick(function ( ... )
		local _cfg = dungeonCfg
		local costId
		local costNum

		if #table.keys(_cfg.cost) > 0 then
			costId = table.keys(_cfg.cost)[1]
			costNum = _cfg.cost[costId]
		end

		if costId and GoodsDataMgr:getItemCount(costId) < costNum then
			Utils:showTips(2100101)
			return
		end

		local previewData = {levelCfg = clone(_cfg),costData = {id = costId, num = costNum , hasnum = GoodsDataMgr:getItemCount(costId)},levelStat = {buyCount = 0, isGetFirstReward = not dungeonInfo.pass,remainCount = 1}}
		local view = requireNew("lua.logic.teamFight.TeamLevelPreview"):new(previewData)
		AlertManager:addLayer(view)
 		AlertManager:show()
	end)
end

return ChristmasTaskView