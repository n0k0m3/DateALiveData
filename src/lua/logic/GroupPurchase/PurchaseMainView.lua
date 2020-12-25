--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

local PurchaseMainView = class("PurchaseMainView", BaseLayer)

local ColorDark = ccc3(48,53,74)
local ColorWhite = ccc3(255,255,255)
local RequestInterval = 10
local ImageDefault = "ui/activity/groupPurchase/pay_add.png"

function PurchaseMainView:ctor(...)
	self.super.ctor(self, ...)

	self:initData(...)

	self:init('lua.uiconfig.activity.PurchaseMainView')

	self:initTableView()
	self:initView(EC_GroupType.ALL)
	self:requestHallInfo()
	self:requestMyTeamInfo()
end


function PurchaseMainView:initData(giftData)
	self.giftData = giftData
	self.giftId = giftData.rechargeCfg.id

	self.data = nil			--列表数据

	self.panelType = nil

	self.updateCountDown = RequestInterval

	self.canClickUpdate = true

	self.timeInterval = TabDataMgr:getData("DiscreteData", 90015).data.maxTime 
end

function PurchaseMainView:initUI(ui)
	self.super.initUI(self, ui)

	self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
	self.bg = TFDirector:getChildByPath(self.Panel_root, "bg")
	self.bg:setTouchEnabled(true)
	self.bg:setSwallowTouch(true)

	self.panel_friend = TFDirector:getChildByPath(ui, "panel_friend")
	self.panel_friend.unselected = TFDirector:getChildByPath(self.panel_friend, "friend_unselected")
	self.panel_friend.selected = TFDirector:getChildByPath(self.panel_friend, "friend_selected")
	self.panel_friend.label = TFDirector:getChildByPath(self.panel_friend, "label")
	self.panel_friend.unselected:setTouchEnabled(true)
	self.panel_friend.unselected:addMEListener(TFWIDGET_CLICK, function()
		self:selectPanel(EC_GroupType.Friend)
	end)
	
	self.panel_all = TFDirector:getChildByPath(ui, "panel_all")
	self.panel_all.unselected = TFDirector:getChildByPath(self.panel_all, "all_unselected")
	self.panel_all.selected = TFDirector:getChildByPath(self.panel_all, "all_selected")
	self.panel_all.label = TFDirector:getChildByPath(self.panel_all, "label")
	self.panel_all.unselected:setTouchEnabled(true)
	self.panel_all.unselected:addMEListener(TFWIDGET_CLICK, function()
		self:selectPanel(EC_GroupType.ALL)
	end)

	self.touchmask = TFDirector:getChildByPath(ui, "touchmask")
	self.touchmask:setTouchEnabled(true)
	self.touchmask:setSwallowTouch(true)

	self.prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

	self.Button_refresh = TFDirector:getChildByPath(ui, "Button_refresh")
	self.Button_refresh.label = TFDirector:getChildByPath(self.Button_refresh, "label")
	self.Button_refresh.text = self.Button_refresh.label:getText()
end

function PurchaseMainView:registerEvents()
	EventMgr:addEventListener(self, EV_GROUP_PURCHASE_REFRESH, handler(self.updateView, self))
	EventMgr:addEventListener(self, EV_GROUP_PURCHASE_JOIN, handler(self.onJoin, self))

	self._ui.Button_create:onClick(function()
		local teamId = ActivityDataMgr2:getGPTeamIdByGiftId(self.giftId)
		if teamId ~= nil then
			Utils:showTips(14300293)
			return;
		end
		EventMgr:dispatchEvent(EV_GROUP_PURCHASE_OPEN_PANEL, {type =EC_GroupOpenPanel.Create, giftId=self.giftId, giftData = self.giftData})
	end)

	self.Button_refresh:onClick(function()
		TFDirector:send(c2s.RECHARGE_REQ_REFRESH_GROUP_TEAM_LIST, {self.giftId})
		self.canClickUpdate = false
	end)

	self._ui.Button_return:onClick(function()
		EventMgr:dispatchEvent(EV_GROUP_PURCHASE_CLOSE_PANEL, {type = EC_GroupOpenPanel.Hall, target = self})
	end)

	self._ui.Button_tryRoom:onClick(function()
		EventMgr:dispatchEvent(EV_GROUP_PURCHASE_OPEN_PANEL, {type =EC_GroupOpenPanel.Room, giftId = self.giftId})
	end)
end

function PurchaseMainView:initTableView()
	local list = TFDirector:getChildByPath(self.ui, "List")
	self.tableView = Utils:scrollView2TableView(list)
	self.tableView:setDirection(TFTableView.TFSCROLLHORIZONTAL)
	self.tableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.tableCellSize,self))
    self.tableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCells,self))
    self.tableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex,self))
end

function PurchaseMainView:tableCellSize(tableView, idx)
	local size = self.prefab:getSize()
    return size.height, size.width + 5
end

function PurchaseMainView:numberOfCells(tableView)
	local size = 0;
	if self.data then
		size = #self.data
	end
    return size
end

function PurchaseMainView:tableCellAtIndex(tableView,idx)
	
    local cell = tableView:dequeueCell()
    local item = nil
    if nil == cell then
        cell = TFTableViewCell:create()
        item = self.prefab:clone()
        item:show()
        item:setPosition(ccp(0,0))
        cell:addChild(item)
        cell.item = item	
	else
		item = cell.item
    end
	self:initCell(item, self.data[idx + 1])
    return cell
end

function PurchaseMainView:initCell(cell, data)
	cell.groupName = TFDirector:getChildByPath(cell, "groupName")
	cell.panel_originator = TFDirector:getChildByPath(cell, "panel_originator")
	cell.panel_originator.name = TFDirector:getChildByPath(cell.panel_originator, "name")
	cell.panel_originator.head = TFDirector:getChildByPath(cell.panel_originator, "head")
	cell.panel_originator.headFrame = TFDirector:getChildByPath(cell.panel_originator.head, "headFrame")

	cell.panel_partner = TFDirector:getChildByPath(cell, "panel_partner")
	cell.panel_partner.name1 = TFDirector:getChildByPath(cell, "Partner1.name")
	cell.panel_partner.head1 = TFDirector:getChildByPath(cell, "Partner1.head")
	cell.panel_partner.default1 = TFDirector:getChildByPath(cell, "Partner1.default")
	cell.panel_partner.headFrame1 = TFDirector:getChildByPath(cell.panel_partner.head1, "headFrame")


	cell.panel_partner.name2 = TFDirector:getChildByPath(cell, "Partner2.name")
	cell.panel_partner.head2 = TFDirector:getChildByPath(cell, "Partner2.head")
	cell.panel_partner.default2 = TFDirector:getChildByPath(cell, "Partner2.default")
	cell.panel_partner.headFrame2 = TFDirector:getChildByPath(cell.panel_partner.head2, "headFrame")

	cell.time = TFDirector:getChildByPath(cell, "time")

	cell.button_purchase = TFDirector:getChildByPath(cell, "button_purchase")
	cell.button_purchase:onClick(function()
		local myGPData = ActivityDataMgr2:getMyGroupPurchaseInfo(self.giftId)
		if myGPData then--已经有队伍了
			Utils:showTips(14300293)
			return;
		end

		local confirmCall = function ( ... )
				local isEnough, notEnoughItem = RechargeDataMgr:currencyIsEnough(self.giftData.exchangeCost)
				if not isEnough then
					Utils:showAccess(notEnoughItem.id)
					return;
				end
				TFDirector:send(c2s.RECHARGE_REQ_JOIN_GROUP_TEAM, {data["teamId"]})
			end
		local rstr = TextDataMgr:getTextAttr(14300298)
        local content = string.format(rstr.text, self.giftData.exchangeCost[1].num, TabDataMgr:getData("Item", self.giftData.exchangeCost[1].id).icon)
        Utils:openView("common.ReConfirmTipsView", {tittle = 14210305, content = content, reType = false, confirmCall = confirmCall})
		
	end)
	cell.button_purchase.label = TFDirector:getChildByPath(cell.button_purchase, "label")

	if data.isMySelf then
		cell.button_purchase:setTouchEnabled(false)
		cell.button_purchase.label:setTextById(14300290)
	else
		cell.button_purchase:setTouchEnabled(true)
		cell.button_purchase.label:setTextById(14300291)
	end

	cell.panel_partner.name1:setVisible(false)
	cell.panel_partner.name2:setVisible(false)
	cell.panel_partner.head1:setVisible(false)
	cell.panel_partner.head2:setVisible(false)
	cell.panel_partner.default1:setVisible(true)
	cell.panel_partner.default2:setVisible(true)
	cell.time:setVisible(false)

	cell.groupName:setText(self.giftData.name)

	self:updateCellMembers(cell,data)
end

function PurchaseMainView:updateCellMembers(cell, data)
	local creator = data.creator
	local partner = data.partner
	
	local function updateHeadFrame(node, frameID)
		local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getAvatarFrameIconPath(frameID==0 and 10000 or frameID)
		if avatarFrameIcon then
			node:setTexture(avatarFrameIcon)
		end
		local headFrameEffect = node:getChildByName("headFrameEffect")
		if headFrameEffect then
		    headFrameEffect:removeFromParent()
		end
		if avatarFrameEffect ~= "" then
		    headFrameEffect = SkeletonAnimation:create(avatarFrameEffect)
		    headFrameEffect:setAnchorPoint(ccp(0,0))
		    headFrameEffect:setPosition(ccp(0,0))
		    headFrameEffect:play("animation", true)
		    headFrameEffect:setName("headFrameEffect")
		    node:addChild(headFrameEffect, 1)
		end
	end

	if creator[1] then
		cell.panel_originator.name:setText(creator[1].playerName)
		local portraiCfg = TabDataMgr:getData("Portrait", creator[1].portraitCid == 0 and 101 or creator[1].portraitCid)
		if portraiCfg then
			cell.panel_originator.head:setTexture(portraiCfg.icon)			
		end
		updateHeadFrame(cell.panel_originator.headFrame, creator[1].portraitFrameId)
	else
		cell.panel_originator.name:setText("")
		cell.panel_originator.head:setTexture(ImageDefault)
	end

	for i = 1, 2 do
		if partner[i] == nil then
			cell.panel_partner["name"..i]:setText("")
			cell.panel_partner["head"..i]:setVisible(false)
			cell.panel_partner["head"..i]:setTexture(ImageDefault)
			cell.panel_partner["default"..i]:setVisible(true)
		else
			cell.panel_partner["name"..i]:setText(partner[i].playerName)
			cell.panel_partner["name"..i]:setVisible(true)
			local portraiCfg = TabDataMgr:getData("Portrait", partner[i].portraitCid==0 and 101 or partner[i].portraitCid)
			cell.panel_partner["head"..i]:setTexture(portraiCfg.icon)
			cell.panel_partner["head"..i]:setVisible(true)
			cell.panel_partner["default"..i]:setVisible(false)
			updateHeadFrame(cell.panel_partner["headFrame"..i], partner[i].portraitFrameId)
		end
	end
end

function PurchaseMainView:initView(type_)
	self:selectPanel(type_)
end

function PurchaseMainView:updateView(data)
	ActivityDataMgr2:setGPUpdateVarible(false, self.giftId)	--记录，每次登陆每个礼包只请求一次
	self:refreshList()
	self:addTimeCounter()
end

function PurchaseMainView:selectPanel(panel)
	if panel == self.panelType  then
		return;
	end
	if panel == EC_GroupType.Friend then
		self.panel_friend.unselected:setVisible(false)
		self.panel_friend.selected:setVisible(true)
		self.panel_friend.label:setColor(ColorWhite)

		self.panel_all.unselected:setVisible(true)
		self.panel_all.selected:setVisible(false)
		self.panel_all.label:setColor(ColorDark)
	elseif panel == EC_GroupType.ALL then
		self.panel_all.unselected:setVisible(false)
		self.panel_all.selected:setVisible(true)
		self.panel_all.label:setColor(ColorWhite)

		self.panel_friend.unselected:setVisible(true)
		self.panel_friend.selected:setVisible(false)
		self.panel_friend.label:setColor(ColorDark)		
	end
	self.panelType = panel

	self:refreshList()
end

function PurchaseMainView:refreshList()
	self.data = ActivityDataMgr2:getGPHallInfo(self.panelType, self.giftId)
	if self.data == nil then
		return;
	end
	self.tableView:reloadData()
end



function PurchaseMainView:addTimeCounter()
	if self.counter == nil then
		self.counter = TFDirector:addTimer(1000, -1, nil, handler(self.onCountDownPer, self))
	end
end

function PurchaseMainView:onCountDownPer(dt)
	if self.counter == nil then
		return;
	end
	self:updateListTime(dt)
	self:updateBtnCountDown(dt)
end

function PurchaseMainView:updateListTime(dt)

	for k, v in ipairs(self.data or {}) do
		local curCell = self.tableView:cellAtIndex(k - 1)
		if curCell then
			local itemCell = curCell.item
			local txt_time = TFDirector:getChildByPath(itemCell, 'time')
			if txt_time then
				txt_time:setVisible(true)
				local lefttime = v.createTime + self.timeInterval * 60 - ServerDataMgr:getServerTime()
				if lefttime < 0 then
					lefttime = 0
				end		
				local _,h,m,s = Utils:getDHMS(lefttime,true)
				txt_time:setTextById(800026, h,m,s)
			end
		end
	end
end

function PurchaseMainView:updateBtnCountDown(dt)
	if self.canClickUpdate then
		self.Button_refresh.label:setText(self.Button_refresh.text)
		return;
	end
	self.updateCountDown = self.updateCountDown - 1
	local str = "(%s)"
	if self.updateCountDown < 0 then
		self.updateCountDown = RequestInterval
		str = ""
		self.canClickUpdate = true
	end
	self.Button_refresh.label:setText(self.Button_refresh.text .. string.format(str, math.floor(self.updateCountDown)))
end

function PurchaseMainView:stopTimeCounter()
	if self.counter then
		TFDirector:stopTimer(self.counter)
        TFDirector:removeTimer(self.counter)
        self.counter = nil
	end
end

function PurchaseMainView:isNeedUpdate()
	return ActivityDataMgr2:getGPUpdateVarible()
end

function PurchaseMainView:removeEvents()
	self:stopTimeCounter()
end

function PurchaseMainView:requestMyTeamInfo()
	TFDirector:send(c2s.RECHARGE_REQ_MY_GROUP_TEAM, {})
end

function PurchaseMainView:requestHallInfo()
	if not self:isNeedUpdate() then
		return
	end
	TFDirector:send(c2s.RECHARGE_REQ_REFRESH_GROUP_TEAM_LIST, {self.giftId})
end

function PurchaseMainView:onJoin(teamInfo)
	EventMgr:dispatchEvent(EV_GROUP_PURCHASE_OPEN_PANEL, {type = EC_GroupOpenPanel.Room, giftId = self.giftId})
end

return PurchaseMainView
