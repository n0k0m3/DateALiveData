--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local DressVoteEntry = class("DressVoteEntry", BaseLayer)

function DressVoteEntry:ctor(...)
	self.super.ctor(self)
	self:initData(...)
	self:init("lua.uiconfig.activity.dressVoteEntry")
	self:refreshView()
	ActivityDataMgr2:sendDressVoteUpdate()
end

function DressVoteEntry:initData(activityId)
	self.activityId	  = activityId
	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	dump(self.activityInfo)
	self.itemInfos	  = {} 
	local tempVoteInfo = {}
	for i=1, #(self.activityInfo.items or {}) do
		local itemId = self.activityInfo.items[i]
		local _itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, itemId)
		_itemInfo.itemId = itemId
		table.insert(self.itemInfos, _itemInfo)

		_itemInfo.extendData = _itemInfo.extendData or {}
		table.insert(tempVoteInfo, {itemId = self.activityInfo.items[i], total = _itemInfo.extendData.voteNum})
	end
	dump(self.itemInfos)
	ActivityDataMgr2:setDressVoteData(tempVoteInfo)
	
	table.sort(self.itemInfos, function(a, b)
		return a.rank < b.rank
	end)

	self.costItemId = nil	
	self.costItemNum = nil
	for k, v in pairs(self.activityInfo.extendData.cost or {}) do
		self.costItemId = tonumber(k)
		self.costItemNum = tonumber(v)
	end	

	self.curDress = nil
	self.costNum = 1
	self.timeDuration = 10
	self.dressList = {}
end

function DressVoteEntry:initUI(ui)
	self.super.initUI(self, ui)

	self.Panel_root		= TFDirector:getChildByPath(ui,"Panel_root")

	self.Image_dress	= TFDirector:getChildByPath(self.Panel_root,"Image_dress")
	self.Image_dress.load = false
	self.Image_dress_name	= TFDirector:getChildByPath(self.Panel_root,"Image_dress_name")

	self.Button_vote	= TFDirector:getChildByPath(self.Panel_root,"Button_vote")
	self.ImageActEnd	= TFDirector:getChildByPath(self.Panel_root,"ImageActEnd")

	self.act_time		= TFDirector:getChildByPath(self.Panel_root,"act_time")
	self.act_time.Start = TFDirector:getChildByPath(self.Panel_root,"act_timeStart")
	self.act_time.End	= TFDirector:getChildByPath(self.Panel_root,"act_timeEnd")

	self.Button_help	= TFDirector:getChildByPath(self.Panel_root,"Button_help")

	self.Button_search	= TFDirector:getChildByPath(self.Panel_root,"Button_search")

	self.dressListNode	= TFDirector:getChildByPath(self.Panel_root,"dressList")

	self.Panel_check	= TFDirector:getChildByPath(self.Panel_root,"Panel_check")

	self.Panel_ticket	= TFDirector:getChildByPath(self.Panel_root,"Panel_ticket")
	self.Panel_ticket.nodeCost		  = TFDirector:getChildByPath(self.Panel_ticket,"nodeCost")
	self.Panel_ticket.ticketNum		  = TFDirector:getChildByPath(self.Panel_ticket,"ticketNum")
	self.Panel_ticket.Button_subtrack = TFDirector:getChildByPath(self.Panel_ticket,"Button_subtrack")
	self.Panel_ticket.Button_add	  = TFDirector:getChildByPath(self.Panel_ticket,"Button_add")
	self.Panel_ticket.cost_num		  = TFDirector:getChildByPath(self.Panel_ticket,"cost_num")

	self.Label_descprit	= TFDirector:getChildByPath(self.Panel_root,"Label_descprit")
	self.Label_descprit:setTextById(15010048)

	for i =1, 3 do
		local dress = self.dressListNode:getChildByName("dress_"..i)
		dress.selected = TFDirector:getChildByPath(dress, "selected")
		dress.selected:setTouchEnabled(true)
		dress.selected:setSwallowTouch(true)
		dress.selected:addMEListener(TFWIDGET_CLICK, function()
			self:selectDress(dress)
		end)
		dress.selected.voteNum = TFDirector:getChildByPath(dress.selected, "voteNum")
		dress.selected.voteNum:setText("")
		dress.selected.rankNum = TFDirector:getChildByPath(dress.selected, "rankNum")
		dress.selected.rankNum:setText("")
		
		dress.unselected = TFDirector:getChildByPath(dress, "unselected")
		dress.unselected:setTouchEnabled(true)
		dress.unselected:setSwallowTouch(true)
		dress.unselected:addMEListener(TFWIDGET_CLICK, function()
			self:selectDress(dress)
		end)
		dress.unselected.voteNum = TFDirector:getChildByPath(dress.unselected, "voteNum")
		dress.unselected.voteNum:setText("")
		dress.unselected.rankNum = TFDirector:getChildByPath(dress.unselected, "rankNum")
		dress.unselected.rankNum:setText("")

		dress.selected:hide()
		dress.unselected:show()

		--bind data
		dress.data = self.itemInfos[i]	--ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, self.activityInfo.items[1])

		table.insert(self.dressList, dress)
	end	

	self:initDressInfo()
end

function DressVoteEntry:initDressInfo()	
	local itemVoteInfos = ActivityDataMgr2:getDressVoteData()
	for i=1,#self.dressList do
		local dress = self.dressList[i]
		local itemInfo = dress.data
		local data = itemVoteInfos[dress.data.itemId]
		
		local selectPath = string.sub(itemInfo.extendData.icon, 1, string.find(itemInfo.extendData.icon,".png") - 1) .."_s.png"

		dress.selected:setTexture(selectPath)
		dress.selected.voteNum:setTextById(15010051,data.total)
		dress.selected.voteNum:setSkewX(10)
		dress.selected.rankNum:setText(data.sort)
		dress.selected.rankNum:setSkewX(10)

		dress.unselected:setTexture(itemInfo.extendData.icon)
		dress.unselected.voteNum:setText(data.total)
		dress.unselected.rankNum:setText(data.sort)
	end

	local panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
	PrefabDataMgr:setInfo(panel_goodsItem, tonumber(self.costItemId), tonumber(0))
	panel_goodsItem:setScale(0.35)
	panel_goodsItem:AddTo(self.Panel_ticket.nodeCost):Pos(0,0)
	TFDirector:getChildByPath(panel_goodsItem, "Label_count"):hide()
	TFDirector:getChildByPath(panel_goodsItem, "Image_frame"):hide()
end

function DressVoteEntry:updateDressVoteNum()
	local itemVoteInfos = ActivityDataMgr2:getDressVoteData()	
	for i=1,#self.dressList do
		local dress = self.dressList[i]
		local data = itemVoteInfos[dress.data.itemId]		
		dress.selected.voteNum:setTextById(15010051,data.total)
		dress.selected.rankNum:setText(data.sort)
		dress.unselected.voteNum:setText(data.total)
		dress.unselected.rankNum:setText(data.sort)
	end
end

function DressVoteEntry:registerEvents()
	self.super.registerEvents(self)

	EventMgr:addEventListener(self,EV_VOTE_DRESS_SUCESS,	function(data)
																self:refreshCostNum()
																self:refreshTicketNum()
																self:updateDressVoteNum()
																if data.activityId == self.activityId then
																	Utils:showReward(data.rewards)									
																end
															end)

	EventMgr:addEventListener(self,EV_VOTE_DRESS_UPDATE,	function() 
																self:updateDressVoteNum() 
															end)

	EventMgr:addEventListener(self,EV_BAG_ITEM_UPDATE,		function() 
																self:refreshTicketNum()
																self:refreshCostNum()
															end)

	
	--bind click event
	self.Button_help:onClick(function() Utils:openView("common.HelpView", {2467}) end)

	self.Button_vote:onClick(function()
		local itemId = self.curDress.data.itemId
		if self.costNum < self.costItemNum then
			Utils:openView("bag.ItemAccessView", self.costItemId)
			return
		end
		local view = Utils:openView("common.ConfirmBoxView")
		view:setCallback(function()
		   ActivityDataMgr2:sendDressVoteComfirm(itemId, self.costNum)
		end)
		local content = TextDataMgr:getText(15010052)
		view:setContent(content)
	end)

	self.Button_search:onClick(function() Utils:openView("activity.DressVotePreView", self.curDress.data) end)

	self.Panel_check:setTouchEnabled(true)
	self.Panel_check:setSwallowTouch(true)
	self.Panel_check:addMEListener(TFWIDGET_CLICK, function()
		--AlertManager:closeLayer(self)
	end)

	self.Panel_ticket.Button_subtrack:onTouch(function(event)	
		self:onTouchChange(event, -1)
	end)

	self.Panel_ticket.Button_add:onTouch(function(event)		
		self:onTouchChange(event, 1)
	end)
end

function DressVoteEntry:onTouchChange(event, val)
	if event.name == "ended" then
		if self.timerChangeVote  then
			TFDirector:removeTimer(self.timerChangeVote)
			self.timerChangeVote = nil
		end
    end
    if event.name == "began" then
        TFAudio.playSound(Utils:getKVP(1001,"ui_clickSound"))
        self:changeCostNum(val)
        self:continueChange(val)
    end
end

function DressVoteEntry:continueChange(val)
	if self.timerChangeVote == nil then
		local delayTime = 0
		local const_c = 0.4
		local const_a = -0.05
		local const_min = 0.05
		local delayTime2 = 0
		self.timerChangeVote = TFDirector:addTimer(0,-1, nil, function(dt)
			delayTime = delayTime + dt
			delayTime2 = delayTime2 + dt
			local needTime = const_a * delayTime2*delayTime2 + const_c
			if needTime < const_min then
				needTime = const_min
			end
			if delayTime > needTime then
				self:changeCostNum(val)
				delayTime = 0
			end
		end)
	end
end

function DressVoteEntry:changeCostNum(val)
	self.costNum = self.costNum + val
	self:refreshCostNum()
end

function DressVoteEntry:refreshCostNum()
	local ticketNum = GoodsDataMgr:getItemCount(self.costItemId) or 0

	if self.costNum < 1 then
		self.costNum = 1
	end
	if self.costNum >= ticketNum then
		self.costNum = ticketNum
	end
	self.Panel_ticket.cost_num:setTextById(15010047, self.costNum)
end

function DressVoteEntry:refreshView()
	self:refreshTicketNum()
	self:refreshCostNum()

	self:refreshActTime()

	self:selectDress(self:getDressSelect())

	self:addActTimer()
end

function DressVoteEntry:refreshTicketNum()
	local ticketNum = GoodsDataMgr:getItemCount(self.costItemId) or 0
	local format = "%d/%d"
	self.Panel_ticket.ticketNum:setText( string.format(format,ticketNum, self.costItemNum))
end

function DressVoteEntry:refreshActTime()
	local year, month, day = Utils:getDate(self.activityInfo.showStartTime or 0)
	self.act_time.Start:setTextById(1410001,year, month, day)

	year, month, day = Utils:getDate(self.activityInfo.endTime or 0)
	self.act_time.End:setTextById(1410001,year, month, day)
end

function DressVoteEntry:selectDress(widget)
	if self.curDress == widget then
		return;
	end
	if self.curDress then
		self.curDress.selected:hide()
		self.curDress.unselected:show()
	end
	widget.selected:show()
	widget.unselected:hide()

	self:setDressPreView(widget)

	ActivityDataMgr2:sendDressVoteChange(widget.data.itemId)
	self.activityInfo.extendData.choice = widget.data.itemId

	self.curDress = widget
end

function DressVoteEntry:setDressPreView(widget)
	local data = widget.data
	self.Image_dress:stopAllActions()

	local function callFunc()
		local ret = nil
		if self.Image_dress.load then
			ret = FadeOut:create(0.2)
		end
		return ret
	end
	self.Image_dress:runAction(Sequence:create({callFunc(), CallFunc:create(function()
		self.Image_dress:setTexture(data.extendData.des2)
		self.Image_dress_name:setTexture(data.extendData.name)
		self.Image_dress.load = true
	end), FadeIn:create(0.4)}))	
end

function DressVoteEntry:addActTimer()
	if self.actTimer == nil then
		local delayTime = 0
		self.actTimer = TFDirector:addTimer(0,-1, nil, function(dt)
			if self.actTimer == nil then
				return
			end
			delayTime = delayTime + dt
			if delayTime > self.timeDuration then
				ActivityDataMgr2:sendDressVoteUpdate()
				delayTime = 0
			end

			self:updateActOverStatus()
		end)
	end
end

function DressVoteEntry:updateActOverStatus()
	local serverTime = ServerDataMgr:getServerTime()
	if serverTime > self.activityInfo.endTime and serverTime < self.activityInfo.showEndTime then
		self.Panel_ticket:hide()
		self.Button_vote:hide()
		self.ImageActEnd:show()

		if self.actTimer then
			TFDirector:removeTimer(self.actTimer)
			self.actTimer = nil
		end
	end
end

function DressVoteEntry:getDressSelect()
	local selectItemId = self.activityInfo.extendData.choice
	local retIdx = 1
	for i=1,#self.dressList do
		local dress = self.dressList[i]
		if selectItemId == dress.data.itemId then
			retIdx = i
		end
	end
	return self.dressList[retIdx]
end

function DressVoteEntry:removeEvents()
	self.super.removeEvents(self)

	if self.actTimer then
		TFDirector:removeTimer(self.actTimer)
		self.actTimer = nil
	end
	if self.timerChangeVote then
		TFDirector:removeTimer(self.timerChangeVote)
		self.timerChangeVote = nil
	end
end

return DressVoteEntry
--endregion
