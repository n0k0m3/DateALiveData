--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local ResLoader = require("lua.logic.battle.ResLoader")
local COLUME = 4

local ValentinesDay = class("ValentinesDay", BaseLayer)
function ValentinesDay:ctor(...)
	self.super.ctor(self)

	self:initData(...)
	self:init("lua.uiconfig.activity.valentine_s_Day")
end

function ValentinesDay:initData(activityId)
	self.activityId = activityId
	self.activityData = ActivityDataMgr2:getActivityInfo(activityId)
	dump(ActivityDataMgr2.activityInfo_)
	self.flowerItemId = self.activityData.extendData.roseId
	self.roleIds = clone(self.activityData.extendData.voteOptions or {})

	table.insert(self.roleIds, 0)
	table.insert(self.roleIds, 0)
	table.insert(self.roleIds, 0)
	table.insert(self.roleIds, 0)
	--self.roleIds = {101,102,101,102,101,102,101,102,101,102,101,102,101,102,101,102,101,102,101,102,101,102,101,102,101,102,101,102,101,102,101,102}

	self.batchNumDefault = 1
	if GoodsDataMgr:getItemCount(self.flowerItemId) == 0 then
		self.batchNumDefault = 0
	end
	self.changeScale = 1
	self.roleItems = {}
	self.selectRole = nil
	self.lastRole = nil
	self.timing = 0
	self.sendEnabled = true
end

function ValentinesDay:initUI(ui)
	self.super.initUI(self, ui)

	self.Button_send					= TFDirector:getChildByPath(ui,"Button_send")
	self.Button_reward					= TFDirector:getChildByPath(ui,"Button_reward")
	self.voteCounter					= TFDirector:getChildByPath(ui,"voteCounter")
	self.ScrollView_Sprite				= TFDirector:getChildByPath(ui,"ScrollView_Sprite")
	self.ScrollView_Sprite:setInertiaScrollEnabled(true)
	self.ScrollView_Sprite.size			= self.ScrollView_Sprite:getContentSize()
	self.tableView						= Utils:scrollView2TableView( TFDirector:getChildByPath(ui,"tableview"))
	self.Panel_flowers					= TFDirector:getChildByPath(ui,"Panel_flowers")
	self.Panel_batch					= TFDirector:getChildByPath(ui,"Panel_batch")
	self.Panel_batch.Button_down		= TFDirector:getChildByPath(self.Panel_batch,"Button_down")
	self.Panel_batch.Button_up			= TFDirector:getChildByPath(self.Panel_batch,"Button_up")
	self.Panel_batch.Button_max			= TFDirector:getChildByPath(self.Panel_batch,"Button_max")
	self.Panel_batch.Label_num			= TFDirector:getChildByPath(self.Panel_batch,"Label_num")
	self.Panel_rank_item				= TFDirector:getChildByPath(ui,"Panel_rank_item")
	self.Panel_role_head				= TFDirector:getChildByPath(ui,"Panel_role_head")
	self.Panel_role_head.size 			= self.Panel_role_head:getContentSize()

	self.Image_updateTip				= TFDirector:getChildByPath(ui,"Image_updateTip"):hide()

	self.act_timeStart 					= TFDirector:getChildByPath(ui, "act_timeStart")
	self.act_timeEnd 					= TFDirector:getChildByPath(ui, "act_timeEnd")

	self:initRoleList()
	self:addTimer()
	self:initActTime()
end

function ValentinesDay:initActTime()
	local year, month, day = Utils:getDate(self.activityData.showStartTime)
	local format = TextDataMgr:getText(300324)
	local text = string.format(format, year).. string.format(format, string.format("%.2d", month)).. string.format("%.2d", day).."-"
	self.act_timeStart:setText(text)

	year, month, day = Utils:getDate(self.activityData.showEndTime)
	text = string.format(format, year).. string.format(format, string.format("%.2d", month)).. string.format("%.2d", day)
	self.act_timeEnd:setText(text)
end

function ValentinesDay:initRoleList()
	local row = math.ceil( #self.roleIds / COLUME)
	self.ScrollView_Sprite:setInnerContainerSize(ccs(self.ScrollView_Sprite.size.width, row * self.Panel_role_head.size.height))

	for i=1,#self.roleIds do
		if self.roleIds[i] ~= 0 then
			local roleCfg = TabDataMgr:getData("ValentinePortrait",self.roleIds[i])
			if roleCfg then
				local role = self.Panel_role_head:clone()
				role.cfg = roleCfg
				self.ScrollView_Sprite:addChild(role)

				role:setPosition(self:getItemPos(i))

				local head = role:getChildByName("head_frame")
				head:setTexture(roleCfg.icon)

				role.spine = TFDirector:getChildByPath(role, "spine")
				role.Image_bg_unselect = TFDirector:getChildByPath(role,"Image_bg_unselect"):show()
				role.Image_bg_select = TFDirector:getChildByPath(role,"Image_bg_select"):hide()
				role.Label_name = TFDirector:getChildByPath(role,"Label_name")
				role.Label_name:setText(roleCfg.name)
				role.selectEffect = TFDirector:getChildByPath(role,"selectEffect"):hide()

				local touch = TFDirector:getChildByPath(role,"touch"):show()
				touch:setTouchEnabled(true)
				touch:addMEListener(TFWIDGET_CLICK, function()
					self:selectRoleItem(role)
				end)
				role.touch = touch
			end
		else
			local role = self.Panel_role_head:clone():hide()
			self.ScrollView_Sprite:addChild(role)
		end
	end
end

function ValentinesDay:selectRoleItem(role)
	if self.selectRole == role then
		return
	end
	if self.selectRole then
		self.selectRole.Image_bg_unselect:show()
		self.selectRole.Image_bg_select:hide()
		self.selectRole.selectEffect:hide()
	end	

	role.Image_bg_unselect:hide()
	role.Image_bg_select:show()
	role.selectEffect:show()

	self.selectRole = role
end

function ValentinesDay:getItemPos(index)
	local container = self.ScrollView_Sprite:getInnerContainer()
	local prefabSize = self.Panel_role_head:getSize()
	local row = math.ceil( index / COLUME)
	local col = (index - 1) % COLUME
	return ccp((prefabSize.width + 4) * (col) + 5, container:getSize().height - (prefabSize.height + 5) * (row - 0.0))
end

function ValentinesDay:initTableView()
	self.tableView:setDirection(TFTableView.TFSCROLLVERTICAL)
	self.tableView:setVerticalFillOrder(TFTableView.TFTabViewFILLTOPDOWN)
	self.tableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.tableCellSize,self))
    self.tableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCells,self))
    self.tableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex,self))

	self.tableView:reloadData()
end

function ValentinesDay:numberOfCells(tableView)
	return #self.rankData + 1
end

function ValentinesDay:tableCellSize(tableView)
	local size = self.Panel_rank_item:getContentSize()
	return size.height, size.width
end

function ValentinesDay:tableCellAtIndex(tableView, idx)
	local cell = tableView:dequeueCell()
    local item = nil
	if nil == cell then

        cell = TFTableViewCell:create()
        item = self.Panel_rank_item:clone()
		item.idx = idx
        item:show()
        item:setPosition(ccp(0,0))
        cell:addChild(item)
        cell.item = item

		self:initCell(item)	
	else
		item = cell.item
    end
	self:updateCell(item, self.rankData[idx + 1], idx + 1)
	return cell
end

function ValentinesDay:initCell(item)
	item.votesPercent = TFDirector:getChildByPath(item, "votesPercent")
	item.icon_pos = TFDirector:getChildByPath(item, "icon_pos")
	item.Label_name = TFDirector:getChildByPath(item, "Label_name")
	item.head = TFImage:create()
	item.icon_pos:addChild(item.head)
	item.Label_votes_count = TFDirector:getChildByPath(item, "Label_votes_count")
end

function ValentinesDay:updateCell(item, data, idx)
	if idx > #self.rankData then
		item:hide()
		return
	else
		item:show()
	end
	local progress = 0
	if self.maxVotes == 0 then
		progress = 0
	else
		progress = tonumber(data.count) / self.maxVotes * 100
		if progress < 3 then
			progress = 3
		end
	end

	item.votesPercent:setPercent(progress)
	item.Label_votes_count:setTextById(15010051, data.count)

	local cfg = TabDataMgr:getData("ValentinePortrait",tonumber(data.optionId))
	item.Label_name:setText(cfg.name)
	item.head:setTexture(cfg.icon)
end

function ValentinesDay:refreshView()
	self.data = ActivityDataMgr2:getValentinesDayData()
	local rankData = clone(self.data.roseData)
	if self.rankData then
		for i=1,#rankData do
			local exsit = false
			for j=1,#self.rankData do
				if self.rankData[j].optionId == rankData[i].optionId then
					self.rankData[j].count = rankData[i].count
					exsit = true
					break
				end
			end
			if exsit == false then
				table.insert(self.rankData, rankData[i])
			end
		end
	else
		self.rankData = rankData
	end

	table.sort(self.rankData, function(A, B)
		if tonumber(A.count) == tonumber(B.count) then
			return A.optionId < B.optionId 
		else
			return tonumber(A.count) > tonumber(B.count)
		end				
	end)

	self.maxVotes = tonumber(self.rankData[1].count)
	

	self:initRanking()

	self:initFlowers()

	self:updateRedPoint()
end

function ValentinesDay:initRanking()
	self:initTableView()
end

function ValentinesDay:onShow()
	self.super.onShow(self)

	self:updateRedPoint()
end

function ValentinesDay:updateRedPoint()
	local isShow = false
	local items = ActivityDataMgr2:getItems(self.activityId)
	for k,v in pairs( items) do
		local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityData.activityType, v)
		if progressInfo.status == EC_TaskStatus.GET then
			isShow = true
			break;
		end
	end

	local ValentineData = ActivityDataMgr2:getValentinesDayData()
	if ValentineData then
		local takelist = ActivityDataMgr2:getVantinesProgress() or {}
		local rewards = self.activityData.extendData.rewards or {}
		for k,v in pairs(rewards) do             
			local index = table.indexOf(takelist, tostring(k))
			if index == -1 then
				if tonumber(ValentineData.totalCount or 0) > tonumber(k) then
					isShow = true
					break;
				end
			end
		end
	end            

	self.Image_updateTip:setVisible(isShow)
end

function ValentinesDay:addTimer()
	if self.timer__ == nil then
		self.timer__ = TFDirector:addTimer(100,nil,nil,function ( ... )
			self.timing = self.timing + 1
			if self.timing > 100 then
				self.timing = 0
				TFDirector:send(c2s.ACTIVITY2_REQ_VALENTINE_DATA,{})
			end

			if self.continueTouchSubStract then
				self:substractFlower(self.changeScale)
			end

			if self.continueTouchAdd then
				self:addFlower(self.changeScale)
			end
			self.changeScale = self.changeScale + 0.2
		end)
	end
end

function ValentinesDay:addFlower(scale)
	self.batchNumDefault = self.batchNumDefault + math.floor(scale)
	local max = GoodsDataMgr:getItemCount(self.flowerItemId)
	if self.batchNumDefault > max then
		self.batchNumDefault = max
	end

	self:updateFlowersCount()
end

function ValentinesDay:substractFlower(scale)
	self.batchNumDefault = self.batchNumDefault - math.floor(scale)
	if self.batchNumDefault < 1 then
		self.batchNumDefault = 1
	end

	self:updateFlowersCount()
end

function ValentinesDay:initFlowers()
	local flowerItemId = self.flowerItemId
	local flowerItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
	flowerItem:setPosition(0,0)
	flowerItem:setScale(0.7)
	PrefabDataMgr:setInfo(flowerItem, flowerItemId, GoodsDataMgr:getItemCount(flowerItemId))
	self.Panel_flowers:addChild(flowerItem)
	self.Panel_flowers.flowerItem = flowerItem

	self:updateFlowersCount()
end

function ValentinesDay:updateFlowersCount()
	local num = GoodsDataMgr:getItemCount(self.flowerItemId)
	if num > 0 then
		self.Panel_batch.Label_num:setText(self.batchNumDefault)
	else
		self.Panel_batch.Label_num:setText(0)
	end
end

function ValentinesDay:registerEvents()
	self.super.registerEvents(self)

	EventMgr:addEventListener(self, EV_VALENTINESDAY_MAIN_INFO, handler(self.refreshView, self))
	EventMgr:addEventListener(self, EV_VALENTINESDAY_FLOWERS_VOTES, handler(self.onVotesSucess, self))
	EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.updateFlowerNum, self))

	self.Panel_batch.Button_down:onClick(function()		
		self:substractFlower(1)
	end)
	self.Panel_batch.Button_down:onTouch(function(event)
		if event.name == "began" then
			self.changeScale = 0
			self.continueTouchSubStract = true
		elseif event.name == "ended" then
			self.continueTouchSubStract = false
			self.changeScale = 0
		end
	end)

	self.Panel_batch.Button_up:onClick(function()
		self:addFlower(1)
	end)
	self.Panel_batch.Button_up:onTouch(function(event)
		if event.name == "began" then
			self.changeScale = 0
			self.continueTouchAdd = true
		elseif event.name == "ended" then
			self.continueTouchAdd = false
			self.changeScale = 0
		end
	end)

	self.Panel_batch.Button_max:onClick(function()
		self.batchNumDefault = GoodsDataMgr:getItemCount(self.flowerItemId)
		self:updateFlowersCount()
	end)

	self.Button_reward:onClick(function()
		Utils:openView("activity.2021_spring.ValentinesReward", self.activityId)
	end)

	self.Button_send:onClick(function()
		--todo send
		if self.selectRole == nil then
			Utils:showTips(16500003)
			return
		end
		if GoodsDataMgr:getItemCount(self.flowerItemId) == 0 then
			Utils:showTips(16500004)
			return
		end

		if not self.sendEnabled then
			Utils:showTips(200007)
			return
		end

		self:creatSpine(self.selectRole)
		
		TFDirector:send(c2s.ACTIVITY2_REQ_SEND_ROSE,{self.selectRole.cfg.id, self.batchNumDefault})

		self.sendEnabled = false
		self:timeOut(function()
			self.sendEnabled = true
		end, 3)
	end)

	TFDirector:send(c2s.ACTIVITY2_REQ_VALENTINE_DATA,{})
end

function ValentinesDay:creatSpine(role)
	if self.anim_success == nil then		
		self.anim_success = ResLoader.createSpine("effect/effects_2021_aixin/effects_2021_aixin")
		self.selectRole.spine:addChild(self.anim_success)
		self.anim_success:play("animation")
	else
		self.anim_success:retain()
		self.anim_success:removeFromParent(false)

		role.spine:addChild(self.anim_success)		
		self.anim_success:release()
	end
end

function ValentinesDay:removeEvents()
	self.super.removeEvents(self)

	if self.timer__ then
		TFDirector:stopTimer(self.timer__)
		TFDirector:removeTimer(self.timer__)
		self.timer__ = nil
	end
end

function ValentinesDay:onVotesSucess()
	self:updateRedPoint()
	self.anim_success:play("animation")

	self.batchNumDefault = 1
	self:updateFlowersCount()

	TFAudio.playSound("sound/flowers.mp3")
end

function ValentinesDay:updateFlowerNum()
	local hasNum = GoodsDataMgr:getItemCount(self.flowerItemId)
	if self.Panel_flowers and self.Panel_flowers.flowerItem then
		PrefabDataMgr:setInfo(self.Panel_flowers.flowerItem, self.flowerItemId, hasNum)
	end

	if self.batchNumDefault > hasNum then
		self.batchNumDefault = hasNum
		self:updateFlowersCount()
	end
end


return ValentinesDay

--endregion
