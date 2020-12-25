--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local InvitingView = class("InvitingView", BaseLayer)

function InvitingView:ctor(...)
	self.super.ctor(self, ...)
	self:initData(...)
	self:init('lua.uiconfig.activity.InvitingView')
end

function InvitingView:initData(giftId, activityInfo)
	self.giftId = giftId
	self.activityInfo = activityInfo
	self.giftData = RechargeDataMgr:getGiftSingleData(giftId)

	self.data = {}
	self.tabCell = {}

	self:initListData()

end

function InvitingView:initListData()
	local temp = {}
	self.fiendInfo = FriendDataMgr:getFriendInfo()

	for k, v in pairs(self.fiendInfo) do
		if temp[v.pid] == nil and v.online then
			temp[v.pid] = v
		end
	end

	self.unionMember = clone(LeagueDataMgr:getUnionMembers())

	local myPlayerID = MainPlayer:getPlayerId()
	for k, v in pairs(self.unionMember) do
		v.pid = v.playerId
		if temp[v.pid] == nil and v.pid ~= myPlayerID and v.online then
			temp[v.pid] = v
		end
	end
	for k, v in pairs(temp) do
		table.insert(self.data, v)
	end
end

function InvitingView:initUI(ui)
	self.super.initUI(self, ui)

	local list = TFDirector:getChildByPath(ui, "List")
	self.ListView = UIListView:create(list)
	self.tableView = Utils:scrollView2TableView(list)
	self.tableView:setDirection(TFTableView.TFSCROLLVERTICAL)
	self.tableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.tableCellSize,self))
    self.tableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCells,self))
    self.tableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex,self))
	self.prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
	self.touchmask = TFDirector:getChildByPath(ui, "touchmask")
	self.touchmask:setTouchEnabled(true)
	self.touchmask:setSwallowTouch(true)

	self.noFriendTips = TFDirector:getChildByPath(ui, "noFriendTips")
	self.noFriendTips:setVisible(false)

	self:refreshView()
end

function InvitingView:tableCellSize(tableView, idx)
	local size = self.prefab:getSize()
    return size.height + 5, size.width
end

function InvitingView:numberOfCells(tableView)
    return table.count(self.data)
end

function InvitingView:tableCellAtIndex(tableView,idx)
	local cell = tableView:dequeueCell()
    local item = nil
    if nil == cell then
        cell = TFTableViewCell:create()
        local item = self.prefab:clone()
        item:show()
        item:setPosition(ccp(0,0))
        cell:addChild(item)
        cell.item = item
		self:initListCell(item, self.data[idx + 1])
    end
    return cell
end

function InvitingView:registerEvents()
	self._ui.Button_return:onClick(function()
		EventMgr:dispatchEvent(EV_GROUP_PURCHASE_CLOSE_PANEL, {target = self})
	end)
end

function InvitingView:refreshView(tp)	
	self.tableView:reloadData()
	self.noFriendTips:setVisible(#self.data == 0)
end

function InvitingView:initListCell(cell, cellData)
	cell.head = TFDirector:getChildByPath(cell, "head")
	cell.name = TFDirector:getChildByPath(cell, "name")
	cell.lv = TFDirector:getChildByPath(cell, "lv")
	cell.power = TFDirector:getChildByPath(cell, "power")
	cell.btn_send = TFDirector:getChildByPath(cell, "btn_send")
	cell.btn_sendInvit = TFDirector:getChildByPath(cell, "btn_sendInvit")
	cell.btn_complete = TFDirector:getChildByPath(cell, "btn_complete")
	cell.headFrame = TFDirector:getChildByPath(cell, "headFrame")
	
	local isDoing = (table.indexOf(cellData.groupGiftIds or {}, self.giftId) ~= -1)

	cell.btn_send:setTouchEnabled(false)
	cell.btn_send:setVisible(false)

	cell.btn_complete:setTouchEnabled(false)
	cell.btn_complete:setVisible(isDoing)

	cell.btn_sendInvit:setVisible(not isDoing)
	cell.btn_sendInvit:onClick(function()
		local giftData = RechargeDataMgr:getGiftSingleData(self.giftId)	
		local teamId = ActivityDataMgr2:getGPTeamIdByGiftId(self.giftId)

		local cost = {[1] = {id = giftData.exchangeCost[1].id, num = giftData.exchangeCost[1].num}}
		local content = {str = string.format(TextDataMgr:getText(14300294),giftData.name), teamId = teamId, activtyID = self.activityInfo["id"],giftId = self.giftId,
				cost =cost,showItemtab = self.giftData.firstBuyItem[1]}
		local msg = {
			2,
			EC_ChatState.GROUP_PURCHASE,
			json.encode(content),		
			cellData.pid or cellData.playerId,
			self.giftId
		}

		TFDirector:send(c2s.CHAT_CHAT,msg)

		cell.btn_send:setVisible(true)
		cell.btn_sendInvit:setVisible(false)
	end)

	cell.lv:setText("Lv." ..cellData.lvl)

	local nameFlag = TextDataMgr:getText(13410013)
	cell.name:setText(nameFlag.. ": " ..cellData.name)

	local powerFlag = TextDataMgr:getText(700016)
	cell.power:setText(powerFlag.. ": ".. cellData.fightPower)
	local portraiCfg = TabDataMgr:getData("Portrait", cellData.portraitCid == 0 and 101 or cellData.portraitCid)
	if portraiCfg then
		cell.head:setTexture(portraiCfg.icon)
	end

	local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getAvatarFrameIconPath(cellData.portraitFrameCid == 0 and 10000 or cellData.portraitFrameCid)

	if avatarFrameIcon then
		cell.headFrame:setTexture(avatarFrameIcon)
	end
    local headFrameEffect = cell.headFrame:getChildByName("headFrameEffect")
    if headFrameEffect then
        headFrameEffect:removeFromParent()
    end
    if avatarFrameEffect ~= "" then
        headFrameEffect = SkeletonAnimation:create(avatarFrameEffect)
        headFrameEffect:setAnchorPoint(ccp(0,0))
        headFrameEffect:setPosition(ccp(0,0))
        headFrameEffect:play("animation", true)
        headFrameEffect:setName("headFrameEffect")
        cell.headFrame:addChild(headFrameEffect, 1)
    end
end

return InvitingView


--endregion
