local CollectEquipView = class("CollectEquipView",BaseLayer)

function CollectEquipView:initData()
	self.pageUICfg = {}
	local tmPageUIcfg = CollectDataMgr:getPageUICfg(EC_CollectPage.EQUIP)
	for k,v in pairs(tmPageUIcfg) do
		table.insert(self.pageUICfg,v)
	end
	table.sort( self.pageUICfg, function(a,b)
		return a.order < b.order
	end )
end

function CollectEquipView:ctor()
	self.super.ctor(self)
	self:initData()
	self:init("lua.uiconfig.collect.collectEquipView")
end

function CollectEquipView:initUI(ui)
	self.super.initUI(self,ui)
	self.root_panel = ui:getChildByName("Panel_root")
	local base_panel = self.root_panel:getChildByName("Panel_base")
	self.collectBaseView = require("lua.logic.collect.CollectBaseView"):new()
    base_panel:addChild(self.collectBaseView)
    self.childArr:push(self.collectBaseView)

    self.equip_model = self.root_panel:getChildByName("Panel_equip_model")
    self.cellModel = {}
    self.cellModel[203003] = self.root_panel:getChildByName("Panel_single_cell")
    self.cellModel[203002] = self.root_panel:getChildByName("Panel_three_cell")
    self.cellModel[203001] = self.root_panel:getChildByName("Panel_ten_cell")
    local scroll_list = self.root_panel:getChildByName("ScrollView_list")
    self.list_view = UIListView:create(scroll_list)
    self.list_view:setScrollBar(self.collectBaseView.scrollBar)
    self:initBaseUI()
end

function CollectEquipView:initBaseUI()
	local callbackCfg = {tabSelCallback = handler(self.onSelTab,self),filtSelCallback = handler(self.onSelFiltTab,self)}
	self.collectBaseView:registCallback(callbackCfg)
	self.collectBaseView:makeLeftBar(self.pageUICfg)
end

function CollectEquipView:onSelTab(tabInfo)
	
end

function CollectEquipView:onSelFiltTab(filtInfo,filtKey)
	self:updateInfoPage(filtInfo,filtKey)
end

function CollectEquipView:updatePage()
	self.collectBaseView:updateTrophy(EC_CollectPage.EQUIP)
	CollectDataMgr:clearRedShow(EC_CollectPage.EQUIP)
end

function CollectEquipView:updateInfoPage(filtInfo,filtKey)
	self.list_view:removeAllItems()
	me.TextureCache:removeUnusedTextures()
	SpineCache:getInstance():clearUnused()
	
	if filtKey == 203003 then
		self:updateSinglePage(filtInfo,filtKey)
	elseif filtKey == 203002 then
		self:updateThreeSuitPage(filtInfo,filtKey)
	elseif filtKey == 203001 then
		self:updateTenSuitPage(filtInfo,filtKey)
	else

	end
end

function CollectEquipView:updateSinglePage(filtInfo,filtKey)
	local collectCount = table.count(filtInfo)
	if collectCount >= 2 then
		table.sort( filtInfo, function(a,b)
			return a.order < b.order
		end )
	end
	if collectCount <= 0 then
		return
	end
	local cellCount = math.ceil(collectCount/5)
	for i=1,cellCount do
		local itemCell = self.cellModel[filtKey]:clone()
		self.list_view:pushBackCustomItem(itemCell)
		itemCell:setVisible(true)
		for j = 1,5 do
			local equipInfo = filtInfo[5*(i-1)+j]
			if equipInfo == nil then
				return
			end
			local itemCard = self.equip_model:clone()
			itemCard:setPosition(me.p(0,0))
			itemCell:getChildByName("Panel_equip_"..j):getChildByName("Panel_equip_card"):addChild(itemCard)
			itemCell:getChildByName("Panel_equip_"..j):setVisible(true)
			itemCard:setVisible(true)
			itemCard.cid = equipInfo.id
			local isunclock = CollectDataMgr:isCollectItemExist(equipInfo.collecttype,equipInfo.id)
			local equipCfg = CollectDataMgr:getEquipCfg(equipInfo.id)
			itemCell:getChildByName("Panel_equip_"..j):getChildByName("Label_title"):setTextById(equipCfg.name)
			self:updateItemCard(itemCard,equipInfo,isunclock,equipCfg)
		end
	end
end

function CollectEquipView:updateItemCard(itemCard,equipInfo,isunclock,equipCfg)
	itemCard:getChildByName("Image_cover"):setVisible(not isunclock)
	itemCard:getChildByName("Image_equip_back"):setTexture(EC_EquipBoard[equipCfg.quality])
	itemCard:getChildByName("Image_frame"):setTexture(EC_EquipFrame[equipCfg.quality])
	for t = 1, 5 do
        itemCard:getChildByName("Image_star_"..t):setVisible(t <= equipCfg.star)
    end
	itemCard:getChildByName("Label_levelTitle"):setTextById(800006, "")
	itemCard:getChildByName("Label_level"):setText(equipCfg.maxLevel)
	itemCard:getChildByName("Image_type"):setTexture(EC_EquipSubTypeIconBag[equipCfg.subType])
	itemCard:getChildByName("Label_cost"):setText(equipCfg.cost)
	itemCard:getChildByName("Image_icon"):setTexture(equipCfg.halfPaint)
	
	itemCard:onClick(function()
		if CollectDataMgr:getItemClickEnable() == false then
			return
		end
		Utils:showInfo(itemCard.cid)
	end)
end

function CollectEquipView:handleSuit(filtInfo)
	local suitAllCfg = {}
	local collectCount = table.count(filtInfo)
	if collectCount <= 0 then
		return suitAllCfg
	end
	local collectCount = table.count(filtInfo)
	if collectCount <= 0 then
		return suitAllCfg
	end
	for i = 1,collectCount do
		local tmEquipInfo = filtInfo[i]
		local tmEquipCfg = CollectDataMgr:getEquipCfg(tmEquipInfo.id)
		local suitIds = tmEquipCfg.suit
		for j, suitId in ipairs(suitIds) do
			if suitAllCfg[suitId] == nil then
				local tmSuitCfg = CollectDataMgr:getEquipSuitCfg(suitId)
				if tmSuitCfg then
					suitAllCfg[suitId] = {suitCfg = tmSuitCfg,itemlist = {}}
				else
					print("没有质点套装Id:"..suitId)
				end
			end
			if suitAllCfg[suitId] then
				table.insert(suitAllCfg[suitId].itemlist,tmEquipInfo)
			end
		end
	end
	return suitAllCfg
end

function CollectEquipView:updateThreeSuitPage(filtInfo,filtKey)
	local suitAllCfg = self:handleSuit(filtInfo)
	local suitCount = table.count(suitAllCfg)
	local suitAllkeys = table.keys(suitAllCfg)
	if suitCount >= 2 then
		table.sort( suitAllkeys, function(a,b)
			return a < b
		end )
	end
	local cellCount = math.ceil(suitCount/2)
	for i=1,cellCount do
		local itemCell = self.cellModel[filtKey]:clone()
		self.list_view:pushBackCustomItem(itemCell)
		itemCell:setVisible(true)
		for j=1,2 do
			local suitInfo = suitAllCfg[suitAllkeys[2*(i-1)+j]]
			local item_cell_part = itemCell:getChildByName("Panel_part_"..j)
			item_cell_part:setVisible(false)
			if suitInfo == nil then
				return
			end
			local item_cell_part = itemCell:getChildByName("Panel_part_"..j)
			item_cell_part:setVisible(true)
			item_cell_part:getChildByName("Image_title_bg"):getChildByName("Label_title"):setTextById(suitInfo.suitCfg.suitNewPokedex)
			for t = 1,3 do
				local equipInfo = suitInfo.itemlist[t]
				if equipInfo then
					local itemCard = self.equip_model:clone()
					itemCard:setPosition(me.p(0,0))
					item_cell_part:getChildByName("Panel_equip_"..t):getChildByName("Panel_equip_card"):addChild(itemCard)
					item_cell_part:getChildByName("Panel_equip_"..t):setVisible(true)
					itemCard:setVisible(true)
					itemCard.cid = equipInfo.id
					local isunclock = CollectDataMgr:isCollectItemExist(equipInfo.collecttype,equipInfo.id)
					local equipCfg = CollectDataMgr:getEquipCfg(equipInfo.id)
					self:updateItemCard(itemCard,equipInfo,isunclock,equipCfg)
				end
			end
		end
	end
end

function CollectEquipView:updateTenSuitPage(filtInfo,filtKey)
	local suitAllCfg = self:handleSuit(filtInfo)
	local suitCount = table.count(suitAllCfg)
	local suitAllkeys = table.keys(suitAllCfg)
	if suitCount >= 2 then
		table.sort( suitAllkeys, function(a,b)
			return a < b
		end )
	end
	local cellCount = suitCount
	for i=1,cellCount do
		local itemCell = self.cellModel[filtKey]:clone()
		self.list_view:pushBackCustomItem(itemCell)
		itemCell:setVisible(true)

		local suitInfo = suitAllCfg[suitAllkeys[i]]
		if suitInfo == nil then
			return
		end
		itemCell:getChildByName("Image_title_bg"):getChildByName("Label_title"):setTextById(suitInfo.suitCfg.suitNewPokedex)
		for t = 1,10 do
			local equipInfo = suitInfo.itemlist[t]
			if equipInfo then
				local itemCard = self.equip_model:clone()
				itemCard:setPosition(me.p(0,0))
				itemCell:getChildByName("Panel_equip_"..t):getChildByName("Panel_equip_card"):addChild(itemCard)
				itemCell:getChildByName("Panel_equip_"..t):setVisible(true)
				itemCell:getChildByName("Panel_equip_"..t):getChildByName("Image_null"):setVisible(false)
				itemCard:setVisible(true)
				itemCard.cid = equipInfo.id
				local isunclock = CollectDataMgr:isCollectItemExist(equipInfo.collecttype,equipInfo.id)
				local equipCfg = CollectDataMgr:getEquipCfg(equipInfo.id)
				self:updateItemCard(itemCard,equipInfo,isunclock,equipCfg)
			else
				itemCell:getChildByName("Panel_equip_"..t):getChildByName("Image_null"):setVisible(true)
			end
		end
		
	end

end

function CollectEquipView:onShow()
	self.super.onShow(self)
	self:updatePage()
end

function CollectEquipView:registerEvents()
	
end

return CollectEquipView