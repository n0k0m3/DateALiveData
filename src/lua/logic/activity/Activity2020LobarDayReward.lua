--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local Activity2020LobarDayReward = class("Activity2020LobarDayReward",  BaseLayer)

function Activity2020LobarDayReward:ctor(...)
	self.super.ctor(self)
	self:initData(...)
	self:showPopAnim(true)
	self:init("lua.uiconfig.activity.LobarDayReward")
	self:initTableView()

	ActivityDataMgr2:requestLobarDayRank()

	self:clickTab(self.tabSelfScore)
end

function Activity2020LobarDayReward:initData(activityId)
	self.activityId = activityId
	self.activityData = ActivityDataMgr2:getActivityInfo(self.activityId)
	
	local extendData = self.activityData.extendData
	self.data = {personal = {},  union = {}}
	for i = 1, #extendData["personalReward"], 2 do
		local temp = {}
		temp.step = extendData["personalReward"][i]
		temp.rewardList = extendData["personalReward"][i + 1]
		table.insert(self.data.personal, temp)
	end
	local step = self.data.personal[#self.data.personal].step -1
	for k=#self.data.personal, 1, -1 do
		local temp = self.data.personal[k]
		temp.step0 = step + 1
		if self.data.personal[k - 1] then
			temp.step1 = self.data.personal[k - 1].step - 1
		else
			temp.step1 = -1
		end

		step = temp.step1
	end


	for i = 1, #extendData["pointsReward"], 2 do
		local temp = {}
		temp.step = extendData["pointsReward"][i]
		temp.rewardList = extendData["pointsReward"][i + 1]
		table.insert(self.data.union, temp)
	end
	step = self.data.union[#self.data.union].step -1
	for k=#self.data.union, 1, -1 do
		local temp = self.data.union[k]
		temp.step0 = step + 1
		if self.data.union[k - 1] then
			temp.step1 = self.data.union[k - 1].step - 1
		else
			temp.step1 = -1
		end

		step = temp.step1
	end

	self.currentTab = nil
end

function Activity2020LobarDayReward:initUI(ui)
	self.super.initUI(self, ui)
	self.Panel_ScoreItem = TFDirector:getChildByPath(self.ui, "Panel_ScoreItem")
	self.Panel_RankItem = TFDirector:getChildByPath(self.ui, "Panel_RankItem")
	self.Button_close = TFDirector:getChildByPath(ui, "Button_close")

	self.tabTotalScore = TFDirector:getChildByPath(ui, "tabTotalScore")
	self.tabTotalScore:setTextureNormal("ui/activity/lobarDay/tabDark.png")
	self.tabTotalScore.labelSelect = TFDirector:getChildByPath(self.tabTotalScore, "label_select")
	self.tabTotalScore.labelSelect:setVisible(false)
	self.tabTotalScore.labelUnSelect = TFDirector:getChildByPath(self.tabTotalScore, "label_unselect")
	self.tabTotalScore.labelUnSelect:setVisible(true)
	self.tabTotalScore.data = self.data["union"]

	self.tabSelfScore = TFDirector:getChildByPath(ui, "tabSelfScore")
	self.tabSelfScore:setTextureNormal("ui/activity/lobarDay/tabDark.png")
	self.tabSelfScore.labelSelect = TFDirector:getChildByPath(self.tabSelfScore, "label_select")
	self.tabSelfScore.labelSelect:setVisible(false)
	self.tabSelfScore.labelUnSelect = TFDirector:getChildByPath(self.tabSelfScore, "label_unselect")
	self.tabSelfScore.labelUnSelect:setVisible(true)
	self.tabSelfScore.data = self.data["personal"]

	self.tabRank = TFDirector:getChildByPath(ui, "tabRank")
	self.tabRank:setTextureNormal("ui/activity/lobarDay/tabDark.png")
	self.tabRank.labelSelect = TFDirector:getChildByPath(self.tabSelfScore, "label_select")
	self.tabRank.labelSelect:setVisible(false)
	self.tabRank.labelUnSelect = TFDirector:getChildByPath(self.tabSelfScore, "label_unselect")
	self.tabRank.labelUnSelect:setVisible(true)

	self.category = TFDirector:getChildByPath(ui, "category")
	self.category:setVisible(false)
	self.category.size = self.category:getContentSize()

	self.Panel_SelfRank = TFDirector:getChildByPath(ui, "Panel_SelfRank")
	self.Panel_SelfRank:setVisible(false)
	self.Panel_SelfRank.size = self.Panel_SelfRank:getSize()

	self.tip_NoRank = TFDirector:getChildByPath(ui, "tip_NoRank")
	self.tip_NoRank:setVisible(true)
end

function Activity2020LobarDayReward:registerEvents()
	EventMgr:addEventListener(self, EV_LOBAR_DAY_RANK_RECEIVE, handler(self.updateRank, self))

	self.Button_close:onClick(function()
		AlertManager:closeLayer(self)
	end)
	self.tabTotalScore:onClick(function(widget)
		self:clickTab(widget)
	end)
	self.tabSelfScore:onClick(function(widget)
		self:clickTab(widget)
	end)
	self.tabRank:onClick(function(widget)
		self:clickTab(widget)
	end)
end

function Activity2020LobarDayReward:clickTab(widget)
	if widget == self.currentTab then
		return
	end

	if self.currentTab then
		self.currentTab.labelSelect:setVisible(false)
		self.currentTab.labelUnSelect:setVisible(true)
		self.currentTab:setTextureNormal("ui/activity/lobarDay/tabDark.png")
	end
	
	widget:setTextureNormal("ui/activity/lobarDay/tabBright.png")
	widget.labelSelect:setVisible(true)
	widget.labelUnSelect:setVisible(false)

	if widget == self.tabRank then
		self.category:setVisible(true)
		self.Panel_SelfRank:setVisible(LeagueDataMgr:checkSelfInUnion())		

		self.tableView:setTableViewSize(ccs(self.tableView.size.width, self.tableView.size.height - self.category.size.height - self.Panel_SelfRank.size.height))
		self.tableView:setVerticalFillOrder(TFTableView.TFTabViewFILLTOPDOWN)
		self.tableView:setPositionY(self.tableView.originPos.y + self.Panel_SelfRank.size.height)

		if self.rankData and self.rankData.rankList and #self.rankData.rankList > 0 then
			self.tip_NoRank:setVisible(false)
		else
			self.tip_NoRank:setVisible(true)
		end

		self.prefab = self.Panel_RankItem
	else
		self.tip_NoRank:setVisible(false)
		self.category:setVisible(false)
		self.Panel_SelfRank:setVisible(false)
		self.tableView:setPositionY(self.tableView.originPos.y)

		if self.currentTab == self.tabRank then
			self.tableView:setTableViewSize(self.tableView.size)
			self.tableView:setVerticalFillOrder(TFTableView.TFTabViewFILLTOPDOWN)
		end

		self.prefab = self.Panel_ScoreItem

	end

	self.currentTab = widget

	self:updateSelfRank()

	self.tableView:reloadData()
end

function Activity2020LobarDayReward:initTableView()
	local ScrollView = TFDirector:getChildByPath(self.ui, "ScrollView")
	self.tableView = Utils:scrollView2TableView(ScrollView)
	self.tableView:setDirection(TFTableView.TFSCROLLVERTICAL)
	self.tableView:setVerticalFillOrder(TFTableView.TFTabViewFILLTOPDOWN)
	self.tableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.tableCellSize,self))
    self.tableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCells,self))
    self.tableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex,self))
	self.tableView.size = self.tableView:getTableViewSize()
	self.tableView.originPos = self.tableView:getPosition()
end

function Activity2020LobarDayReward:tableCellSize(tableView, idx)
	local size = self.prefab:getSize()
    return size.height, size.width + 5
end

function Activity2020LobarDayReward:numberOfCells(tableView)
	local size = 0;
	if self.currentTab.data then
		size = #self.currentTab.data
	end
    return size
end

function Activity2020LobarDayReward:tableCellAtIndex(tableView,idx)
    local cell = tableView:dequeueCell()
    local item = nil
	if nil == cell then
        cell = TFTableViewCell:create()
        item = self.prefab:clone()
		item.idx = idx
        item:show()
        item:setPosition(ccp(0,0))
        cell:addChild(item)
        cell.item = item	
	else
		item = cell.item
    end
	self:initCell(item, self.currentTab.data[idx + 1])
    return cell
end

function Activity2020LobarDayReward:initCell(cell, data)

	if self.currentTab == self.tabRank then
		local Image_Rank  = TFDirector:getChildByPath(cell, "Image_Rank")
		local playerRank  = TFDirector:getChildByPath(cell, "playerRank")
		local playerHead  = TFDirector:getChildByPath(cell, "playerHead")
		local playerName  = TFDirector:getChildByPath(cell, "playerName")
		local playerLv	  = TFDirector:getChildByPath(cell, "playerLv")
		local playerScore = TFDirector:getChildByPath(cell, "playerScore")

		local path = "ui/activity/assist/0%d.png"
		Image_Rank:setTexture(data.rank <= 3 and string.format(path, 37 + data.rank) or "")
		playerRank:setText(data.rank)
		playerRank:setVisible(data.rank > 3)
		self:updateHeadFrame(playerHead, data.headId)
		playerName:setText(data.playerName)
		playerLv:setText(data.playerLv)
		playerScore:setText(data.score)
	else
		local rewardStep = TFDirector:getChildByPath(cell, "rewardStep")
		if data.step1 ~= -1 then
			rewardStep:setTextById(14300335, data.step0, data.step1)--14300335
		else
			rewardStep:setTextById(14300327, data.step0)--14300335
		end

		if cell.rewardList then
			cell.rewardList:removeAllItems()
			cell.rewardList = nil
		end
		cell.rewardList = UIListView:create(TFDirector:getChildByPath(cell, "rewardList"))
		for k, v in pairs(data.rewardList) do
			local panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
			PrefabDataMgr:setInfo(panel_goodsItem, tonumber(k), v)
			panel_goodsItem:setScale(0.75)
			cell.rewardList:pushBackCustomItem(panel_goodsItem)
		end
	end
end

function Activity2020LobarDayReward:updateHeadFrame(node, headID, frameID)
	local portraiCfg = TabDataMgr:getData("Portrait", (headID==nil or headID==0) and 101 or headID)
	node:setTexture(portraiCfg.icon)

	local headFrame = TFDirector:getChildByPath(node,"playerHeadFrame")
	local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getAvatarFrameIconPath((frameID ==nil or frameID==0) and 10000 or frameID)
	headFrame:setVisible(true)
	if avatarFrameIcon then
		headFrame:setTexture(avatarFrameIcon)
	end
    local headFrameEffect = headFrame:getChildByName("headFrameEffect")
    if headFrameEffect then
        headFrameEffect:removeFromParent()
    end
    if avatarFrameEffect ~= "" then
        headFrameEffect = SkeletonAnimation:create(avatarFrameEffect)
        headFrameEffect:setAnchorPoint(ccp(0,0))
        headFrameEffect:setPosition(ccp(0,0))
        headFrameEffect:play("animation", true)
        headFrameEffect:setName("headFrameEffect")
        headFrame:addChild(headFrameEffect, 1)
    end
end

function Activity2020LobarDayReward:updateRank()
	self.rankData = ActivityDataMgr2:getLobarRank()
	self.tabRank.data = self.rankData.rankList
	if self.currentTab == self.tabRank then
		self.tableView:reloadData()	
	end
end

function Activity2020LobarDayReward:updateSelfRank()
	if self.currentTab == self.tabRank then
		self:initCell(self.Panel_SelfRank, self.rankData.selfRank)
	end
end


return Activity2020LobarDayReward


--endregion
