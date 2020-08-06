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
* -- 万圣节游戏界面
]]

local HalloweenGameView = class("HalloweenGameView",BaseLayer)

function HalloweenGameView:ctor( data )
	-- body
	self.super.ctor(self,data)
	self.activityId = data
	self:initData()
	BlockGameDataMgr:resqBlockInfo(self.activityId)
  	self:showPopAnim(true)
	self:init("lua.uiconfig.halloween.halloweenGameView")
end

function HalloweenGameView:initData()
	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	self.boxTask = {}
	for k,v in pairs(self.activityInfo.extendData.speedLinkList) do
		local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType,v)
		table.insert(self.boxTask,itemInfo)
	end
end

function HalloweenGameView:initUI( ui )
	-- body
	self.super.initUI(self,ui)

	self.Panel_box = TFDirector:getChildByPath(ui,"Panel_box")
	self.Panel_Grid = TFDirector:getChildByPath(ui,"Panel_Grid")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	local ScrollView_grid = TFDirector:getChildByPath(ui,"ScrollView_grid")

	local viewSize = ScrollView_grid:getContentSize()
	local itemSize = self.Panel_Grid:getContentSize()

	local column = math.floor(viewSize.width/itemSize.width)
	local offset = (viewSize.width - column*itemSize.width)/(column -1)
	self.uiGrid_grid = UIGridView:create(ScrollView_grid)
   	self.uiGrid_grid:setItemModel(self.Panel_Grid)
   	self.uiGrid_grid:setColumn(column)
   	self.uiGrid_grid:setColumnMargin(offset)
   	self.uiGrid_grid:setRowMargin(offset)
   	self.column = column

	self.label_successNum = TFDirector:getChildByPath(ui,"label_successNum")
	self.loadingBar = TFDirector:getChildByPath(ui,"loadingBar")
	self.Button_reset = TFDirector:getChildByPath(ui,"Button_reset")
	self.cost_icon = TFDirector:getChildByPath(ui,"cost_icon")
	self.cost_num = TFDirector:getChildByPath(ui,"cost_num")
	self.Button_help = TFDirector:getChildByPath(ui,"Button_help")

	self:updateView()
end

function HalloweenGameView:registerEvents( ... )
	-- body

    EventMgr:addEventListener(self, EV_BLOCKGAME_INFO_RSP, handler(self.updateView, self))
    EventMgr:addEventListener(self, EV_BLOCKGAME_ACTION_RSP, handler(self.actionRsp, self))
	EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, function ( ... )
			self:updateBoxStatus()
		end)

	self.Button_close:onClick(function ( ... )
		--EventMgr:dispatchEvent(EV_ACTIVITY_UPDATE_PROGRESS)
		AlertManager:closeLayer(self)
	end)

	self.Button_reset:onClick(function ( ... )

		local canReset = true
		for k,v in pairs(self.boxTask) do
			local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType,v.id)
			if progressInfo.status ~= EC_TaskStatus.GETED then
				canReset = false
			end
		end
		if canReset then
			BlockGameDataMgr:resetGame(self.activityId)
		else
			Utils:showTips(2109039)
		end
	end)

	self.Button_help:onClick(function ( ... )
		-- body
	end)
end

function HalloweenGameView:getGridPic( id )
	local gridCfg = TabDataMgr:getData("SpeedLink",id)
	return gridCfg.pic
end

function HalloweenGameView:actionRsp( data )
	local blockInfo = data.speedLink
	local remove = data.remove or {}

	local lastLocation = 0
	for k,v in pairs(self.blockInfos) do
		if v.id == blockInfo.id and v.location ~= blockInfo.location then
			lastLocation = v.location
		end
	end

	self:playOpenGridAni(blockInfo,function ( ... )
		self:updateSuccessPanel()
		if table.count(remove) > 0 then
			for k,v in pairs(remove) do
					self.ui:timeOut(function ()
					self:playCloseGridAni(v)
				end,0.2)
			end
			Utils:playSound(5023)
		else
			if lastLocation ~= 0 then
				local item = self.uiGrid_grid:getItem(blockInfo.location)
				if not item then return end
				local Image_flag = TFDirector:getChildByPath(item,"Image_flag")
				local item1 = self.uiGrid_grid:getItem(lastLocation)
				if not item1 then return end
				local Image_flag1 = TFDirector:getChildByPath(item1,"Image_flag")

				Image_flag:setOpacity(0)
				Image_flag1:setOpacity(0)
				local arr = {
					CCFadeIn:create(0.2),
					CCFadeOut:create(0.2)
				}
				local arr1 = {
					CCFadeIn:create(0.2),
					CCFadeOut:create(0.2)
				}
				Image_flag1:runAction(CCSequence:create(arr))
				Image_flag:runAction(CCSequence:create(arr1))

				Utils:playSound(5022)
			end
		end
	end)

end

function HalloweenGameView:updateSuccessPanel( ... )
	local number = BlockGameDataMgr:getSuccessNum()
	self.label_successNum:setText(number)

	if self.activityInfo.extendData.speedLinkCost then
		self.cost_icon:show()
		self.cost_num:show()
		for k,v in pairs(self.activityInfo.extendData.speedLinkCost) do
			self.cost_icon:setTexture(GoodsDataMgr:getItemCfg(tonumber(k)).icon)
			self.cost_num:setText(GoodsDataMgr:getItemCount(tonumber(k)))
			self.cost_icon:setTouchEnabled(true)
			self.cost_icon:onClick(function ( ... )
				Utils:showInfo(k)
			end)
		end
	else
		self.cost_icon:hide()
		self.cost_num:hide()
	end
end

function HalloweenGameView:playOpenGridAni( blockInfo ,callBack)
	-- body
	self.playAning = true
	local item = self.uiGrid_grid:getItem(blockInfo.location)
	if not item then return end
	local Image_card = TFDirector:getChildByPath(item,"Image_card")

	local arr = {
		CCScaleTo:create(0.2,0,1),
		CCCallFunc:create(function ( ... )
			Image_card:setTexture(self:getGridPic(blockInfo.id))
			item:setTouchEnabled(false)
		end),
		CCScaleTo:create(0.2,1,1),
		CCCallFunc:create(function ( ... )
			callBack()
			self.playAning = false
		end),
	}

	Image_card:runAction(CCSequence:create(arr))

end

function HalloweenGameView:playCloseGridAni( idx )
	-- body
	self.playAning = true
	local item = self.uiGrid_grid:getItem(idx)
	if not item then return end
	local Image_card = TFDirector:getChildByPath(item,"Image_card")

	local arr = {
		CCScaleTo:create(0.2,0,1),
		CCCallFunc:create(function ( ... )
			local imageIdx = 35+(idx+math.ceil(idx/self.column))%2
			Image_card:setTexture("ui/Halloween/Popup/0"..imageIdx..".png")
			item:setTouchEnabled(true)
			self.playAning = false
		end),
		CCScaleTo:create(0.2,1,1),
	}

	Image_card:runAction(CCSequence:create(arr))
end

function HalloweenGameView:updateView()
	-- body
	self:updateGridList()
	self:updateBoxStatus()
	self:updateSuccessPanel()
end

function HalloweenGameView:updateGridList()
	local gridNum = 1
	self.uiGrid_grid:removeAllItems()
	for i = 1,24 do
		local item = self.uiGrid_grid:pushBackDefaultItem()
		self:updateGridItem(item, i)
	end
end

function HalloweenGameView:checkCostEnough( ... )
	local enough = true
	if self.activityInfo.extendData.speedLinkCost then
		for k,v in pairs(self.activityInfo.extendData.speedLinkCost) do
			if not GoodsDataMgr:currencyIsEnough(tonumber(k), v ) then
				enough = false
			end
		end
	end
	return enough
end

function HalloweenGameView:updateGridItem(item, idx)
	-- body
	local Image_card = TFDirector:getChildByPath(item,"Image_card")
	local Image_flag = TFDirector:getChildByPath(item,"Image_flag"):setOpacity(0)
	if idx then
		local imageIdx = 35+(idx+math.ceil(idx/self.column))%2
		Image_card:setTexture("ui/Halloween/Popup/0"..imageIdx..".png")
	end
	item:onClick(function ( ... )
		-- body
		if self.playAning then return end
		if self:checkCostEnough() then
			BlockGameDataMgr:choiceBlock(self.activityId,idx)
		else
			Utils:showTips(2109038)
		end
	end)

	local blockInfos = BlockGameDataMgr:getBlockInfo_(  ) or {}

	for k,v in pairs(blockInfos) do
		if v.location == idx then
			Image_card:setTexture(self:getGridPic(v.id))
			item:setTouchEnabled(false)
		end
	end

	self.blockInfos = blockInfos

end

function HalloweenGameView:getBoxTaskMaxTargetAndProgress()
	local target = 0 
	local progress = 0
	for k,v in ipairs(self.boxTask) do
		local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType,v.id)
		target = math.max(target,tonumber(v.target))
		progress = math.max(progress,progressInfo.progress)
	end
	return target,progress
end

function HalloweenGameView:updateBoxStatus()
	local maxTarget,maxProgress =  self:getBoxTaskMaxTargetAndProgress()
	self.boxItems = self.boxItems or {}
	for k,v in ipairs(self.boxTask) do

		local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType,v.id)
		if not self.boxItems[k] then
			local pointPercent = tonumber(v.target)/maxTarget
			local item = self.Panel_box:clone()
			local posX = pointPercent*self.loadingBar:getContentSize().width - self.loadingBar:getContentSize().width/2 + self.loadingBar:Pos().x -15
			item:setPosition(ccp(posX,self.loadingBar:getPositionY()))
			item:setZOrder(2)
			self.loadingBar:getParent():addChild(item)
			self.boxItems[k] = item
		end
		self:updateBoxItem(self.boxItems[k], v)
	end

	self.loadingBar:setPercent(maxProgress/maxTarget*100)
end

function HalloweenGameView:updateBoxItem(item, data)
	local Image_box = TFDirector:getChildByPath(item,"Image_box")
	local label_progress = TFDirector:getChildByPath(item,"label_progress")

	local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType,data.id)
	local picPath = ""
	if progressInfo.status == EC_TaskStatus.ING then
		picPath = "ui/Halloween/Popup/032.png"
	elseif progressInfo.status == EC_TaskStatus.GET then
		picPath = "ui/Halloween/Popup/031.png"
	elseif progressInfo.status == EC_TaskStatus.GETED then
		picPath = "ui/Halloween/Popup/030.png"
	end

	Image_box:setTexture(picPath)

	label_progress:setText(data.target)
	Image_box:setTouchEnabled(true)
	Image_box:onClick(function ( ... )
		if progressInfo.status == EC_TaskStatus.GET then
		 	ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, data.id)
		else
			self:showRewardPreview(item, data.reward)
		end
	end)

end

function HalloweenGameView:showRewardPreview(item, reward)
    -- self.Image_preview:AnchorPoint(ccp(0.5, 0))
    local format_reward = {}
    for k, v in pairs(reward) do
        local item = Utils:makeRewardItem(k, v)
        table.insert(format_reward, item)
    end

    local wp = item:convertToWorldSpaceAR(me.p(0, 0))
    local np = self.ui:convertToNodeSpaceAR(wp)
    self.Image_preview = Utils:previewReward(self.Image_preview, format_reward, 0.6)
end


return HalloweenGameView