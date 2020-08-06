local CollectDatingView = class("CollectDatingView",BaseLayer)

function CollectDatingView:initData()
	self.pageUICfg = {}
	local tmPageUIcfg = CollectDataMgr:getPageUICfg(EC_CollectPage.DATING)
	for k,v in pairs(tmPageUIcfg) do
		table.insert(self.pageUICfg,v)
	end
	table.sort( self.pageUICfg, function(a,b)
		return a.order < b.order
	end )
end

function CollectDatingView:ctor()
	self.super.ctor(self)
	self:initData()
	self:init("lua.uiconfig.collect.collectDatingView")
end

function CollectDatingView:initUI(ui)
	self.super.initUI(self,ui)
	self.root_panel = ui:getChildByName("Panel_root")
	local base_panel = self.root_panel:getChildByName("Panel_base")
	self.collectBaseView = require("lua.logic.collect.CollectBaseView"):new()
    base_panel:addChild(self.collectBaseView)
    self.childArr:push(self.collectBaseView)
    local dating_list_cell = self.root_panel:getChildByName("Panel_dating_cell")
    local scroll_list = self.root_panel:getChildByName("ScrollView_list")
    self.list_view = UIListView:create(scroll_list)
    self.list_view:setItemModel(dating_list_cell)
    self.list_view:setScrollBar(self.collectBaseView.scrollBar)
    self:initBaseUI()
end

function CollectDatingView:initBaseUI()
	local callbackCfg = {tabSelCallback = handler(self.onSelTab,self),filtSelCallback = handler(self.onSelFiltTab,self)}
	self.collectBaseView:registCallback(callbackCfg)
	self.collectBaseView:makeLeftBar(self.pageUICfg)
end

function CollectDatingView:onSelTab(tabInfo)
	
end

function CollectDatingView:onSelFiltTab(filtInfo,filtKey)
	self:updateInfoPage(filtInfo)
end

function CollectDatingView:updatePage()
	self.collectBaseView:updateTrophy(EC_CollectPage.DATING)
	CollectDataMgr:clearRedShow(EC_CollectPage.DATING)
end

function CollectDatingView:handleGroup(filtInfo)
	self.list_view:removeAllItems()
	local groupAllCfg = {}
	local collectCount = table.count(filtInfo)
	if collectCount <= 0 then
		return groupAllCfg
	end
	local collectCount = table.count(filtInfo)
	if collectCount <= 0 then
		return groupAllCfg
	end
	for i = 1,collectCount do
		local tmDatingInfo = filtInfo[i]
		local groupId = tonumber(tmDatingInfo.extCfg.endSuit)
		if groupAllCfg[groupId] == nil then
			local tmgroupCfg = CollectDataMgr:getPageGroupCfg(groupId)
			if tmgroupCfg then
				groupAllCfg[groupId] = {groupCfg = tmgroupCfg,itemlist = {}}
			else
				print("没有约会分组Id:"..groupId)
			end
		end
		if groupAllCfg[groupId] then
			table.insert(groupAllCfg[groupId].itemlist,tmDatingInfo)
		end
	end
	return groupAllCfg
end

function CollectDatingView:updateInfoPage(filtInfo)
	local groupAllCfg = self:handleGroup(filtInfo)
	local groupCount = table.count(groupAllCfg)
	local groupAllkeys = table.keys(groupAllCfg)
	if groupCount >= 2 then
		table.sort( groupAllkeys, function(a,b)
			return a < b
		end )
	end
	local cellCount = groupCount
	for i=1,cellCount do
		local itemCell = self.list_view:pushBackDefaultItem()
		itemCell:setVisible(true)

		local groupInfo = groupAllCfg[groupAllkeys[i]]
		if groupInfo == nil then
			return
		end
		local isGroupUnlock = false
		local endingCount = table.count(groupInfo.itemlist)
		if endingCount <= 0 then
			return
		end
		if endingCount >=2 then
			table.sort(groupInfo.itemlist, function(a,b)
				return a.order < b.order
			end )
		end
		local group_bar = itemCell:getChildByName("Panel_group_bar")
		local scroll_ending = group_bar:getChildByName("ScrollView_dating")
		local dating_cell = scroll_ending:getChildByName("Panel_cell")
		local dating_listView = UIListView:create(scroll_ending)
		local datingCellSize = dating_cell:getContentSize()
		itemCell:setContentSize(datingCellSize)
		dating_listView:setItemModel(dating_cell)
		dating_listView:setContentSize(me.size(datingCellSize.width,datingCellSize.height*endingCount))
		dating_cell:setVisible(false)
		for t = 1,endingCount do
			local datingInfo = groupInfo.itemlist[t]
			if datingInfo then
				local itemEnding = dating_listView:pushBackDefaultItem()
				itemEnding:setVisible(true)
				itemEnding:getChildByName("Label_name_1"):setTextById(datingInfo.extCfg.name1)
				itemEnding:getChildByName("Label_name_2"):setTextById(datingInfo.extCfg.name2)
				
				local isunclock = CollectDataMgr:isCollectItemExist(datingInfo.collecttype,datingInfo.id)
				local nameFontSize = 24
				local nameFontSkew = 0
				if isunclock == true then
					isGroupUnlock = true
					itemEnding:getChildByName("Image_bg"):setTexture("ui/collect/TJ_YH_jiesuo.png")
				else
					itemEnding:getChildByName("Image_bg"):setTexture("ui/collect/TJ_YH_suoding.png")
					nameFontSkew = 15
					nameFontSize = 20
					itemEnding:getChildByName("Label_name_2"):setString("???")
				end
				itemEnding:getChildByName("Label_name_1"):setFontSize(nameFontSize)
				itemEnding:getChildByName("Label_name_2"):setFontSize(nameFontSize)
				itemEnding:getChildByName("Label_name_1"):setSkewX(nameFontSkew)
				itemEnding:getChildByName("Label_name_2"):setSkewX(nameFontSkew)
				itemEnding:getChildByName("Label_unlock"):setVisible(isunclock)
				itemEnding:getChildByName("Image_lock"):setVisible(not isunclock)
			end
		end
		group_bar:getChildByName("Label_gtitle_1"):setTextById(groupInfo.groupCfg.datingTitle1)
		group_bar:getChildByName("Label_gtitle_2"):setTextById(groupInfo.groupCfg.datingTitle2)
		group_bar:getChildByName("Label_stitle_1"):setTextById(groupInfo.groupCfg.datingTitle3)
		group_bar:getChildByName("Label_stitle_2"):setTextById(groupInfo.groupCfg.datingTitle4)
		local barFontColor = ccc3(249,56,112)
		if isGroupUnlock == false then
			barFontColor = ccc3(44,72,168)
			group_bar:getChildByName("Image_bg"):setTexture("ui/collect/TJ_YH_bg_2.png")
		end
		group_bar:getChildByName("Label_gtitle_1"):setVisible(isGroupUnlock and (groupInfo.groupCfg.datingTitle1 ~= 0))
		group_bar:getChildByName("Label_gtitle_1"):setFontColor(barFontColor)
		group_bar:getChildByName("Label_gtitle_2"):setFontColor(barFontColor)
		group_bar:getChildByName("Label_stitle_1"):setFontColor(barFontColor)
		group_bar:getChildByName("Label_stitle_2"):setFontColor(barFontColor)

		group_bar.isSpread = false
		group_bar.parentCell = itemCell
		group_bar.id = groupInfo.groupCfg.id
		group_bar.spreadCfg = {[1] = datingCellSize,[2] = me.size(me.size(datingCellSize.width,datingCellSize.height*(endingCount + 1)))}
		group_bar:onClick(function()
			if group_bar.isSpread == true then
				group_bar.parentCell:setContentSize(group_bar.spreadCfg[1])
				group_bar:setContentSize(group_bar.spreadCfg[1])
				group_bar.isSpread = false
				self.list_view:updateInnerContainerSize()
				self.list_view.doLayoutDirty_ = true
				return
			end
			local allItemCells = self.list_view:getItems()
			for k,v in ipairs(allItemCells) do
				local tmGroup_bar = v:getChildByName("Panel_group_bar")
				if tmGroup_bar.id ~= group_bar.id then
					v:setContentSize(tmGroup_bar.spreadCfg[1])
					tmGroup_bar:setContentSize(tmGroup_bar.spreadCfg[1])
					tmGroup_bar.isSpread = false
				end
			end
			group_bar.parentCell:setContentSize(group_bar.spreadCfg[2])
			group_bar:setContentSize(group_bar.spreadCfg[2])
			group_bar.isSpread = true
			self.list_view:updateInnerContainerSize()
			self.list_view.doLayoutDirty_ = true
		end)
	end	
end

function CollectDatingView:onShow()
	self.super.onShow(self)
	self:updatePage()
end

function CollectDatingView:registerEvents()
	
end

return CollectDatingView