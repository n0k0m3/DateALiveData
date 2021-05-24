local CollectTokenView = class("CollectTokenView",BaseLayer)

function CollectTokenView:initData()
	self.pageUICfg = {}
	local tmPageUIcfg = CollectDataMgr:getPageUICfg(EC_CollectPage.TOKEN)
	for k,v in pairs(tmPageUIcfg) do
		table.insert(self.pageUICfg,v)
	end
	table.sort( self.pageUICfg, function(a,b)
		return a.order < b.order
	end )
end

function CollectTokenView:ctor()
	self.super.ctor(self)
	self:initData()
	self:init("lua.uiconfig.collect.collectTokenView")
end

function CollectTokenView:initUI(ui)
	self.super.initUI(self,ui)
	self.root_panel = ui:getChildByName("Panel_root")
	local base_panel = self.root_panel:getChildByName("Panel_base")
	self.collectBaseView = require("lua.logic.collect.CollectBaseView"):new()
    base_panel:addChild(self.collectBaseView)
    self.childArr:push(self.collectBaseView)


    self.token_model = self.root_panel:getChildByName("Panel_token_model")
    self.cellModel = {}
    self.cellModel[106003] = self.root_panel:getChildByName("Panel_single_cell")
    self.cellModel[106002] = self.root_panel:getChildByName("Panel_suit_cell")
    local scroll_list = self.root_panel:getChildByName("ScrollView_list")
    self.list_view = UIListView:create(scroll_list)
	self.list_view:setScrollBar(self.collectBaseView.scrollBar)
    self:initBaseUI()
end

function CollectTokenView:initBaseUI()
	local callbackCfg = {tabSelCallback = handler(self.onSelTab,self),filtSelCallback = handler(self.onSelFiltTab,self)}
	self.collectBaseView:registCallback(callbackCfg)
	self.collectBaseView:makeLeftBar(self.pageUICfg)
end

function CollectTokenView:onSelTab(tabInfo)
	self.tabTypeId = tabInfo.id
end

function CollectTokenView:onSelFiltTab(filtInfo,filtKey)
	self:updateInfoPage(filtInfo)
end

function CollectTokenView:updatePage()
	self.collectBaseView:updateTrophy(EC_CollectPage.TOKEN)
	CollectDataMgr:clearRedShow(EC_CollectPage.TOKEN)
end

function CollectTokenView:updateInfoPage(filtInfo)
	self.list_view:removeAllItems()
	me.TextureCache:removeUnusedTextures()
	SpineCache:getInstance():clearUnused()
	
	if self.tabTypeId == 106003 then
		self:updateSinglePage(filtInfo,filtKey)
	elseif self.tabTypeId == 106002 then
		self:updateSuitPage(filtInfo,filtKey)
	else

	end
end

function CollectTokenView:updateSinglePage(filtInfo)
	local collectCount = table.count(filtInfo)
	if collectCount >= 2 then
		table.sort( filtInfo, function(a,b)
			return a.order < b.order
		end )
	end
	if collectCount <= 0 then
		return
	end
	local cellCount = math.ceil(collectCount/7)
	for i=1,cellCount do
		local itemCell = self.cellModel[self.tabTypeId]:clone()
		self.list_view:pushBackCustomItem(itemCell)
		itemCell:setVisible(true)
		for j = 1,7 do
			local tokenInfo = filtInfo[7*(i-1)+j]
			if tokenInfo == nil then
				return
			end
			local itemCard = self.token_model:clone()
			itemCard:setPosition(me.p(0,0))
			itemCell:getChildByName("Panel_equip_"..j):getChildByName("Panel_equip_card"):addChild(itemCard)
			itemCell:getChildByName("Panel_equip_"..j):setVisible(true)
			itemCard:setVisible(true)
			itemCard.cid = tokenInfo.id
			local isunclock = CollectDataMgr:isCollectItemExist(tokenInfo.collecttype,tokenInfo.id)
			local tokenCfg = CollectDataMgr:getTokenCfg(tokenInfo.id)
			itemCell:getChildByName("Panel_equip_"..j):getChildByName("Image_lock"):setVisible(not isunclock)
			itemCell:getChildByName("Panel_equip_"..j):getChildByName("Label_title"):setTextById(tokenCfg.nameTextId)
			self:updateItemCard(itemCard,tokenInfo,isunclock,tokenCfg)
			
		end
	end
end

function CollectTokenView:updateItemCard(itemCard,tokenInfo,isunclock,tokenCfg)
	itemCard:getChildByName("Image_frame"):setTexture(EC_ItemIcon[tokenCfg.quality])
    local scroll_star = itemCard:getChildByName("ScrollView_star")
    local star_cell = scroll_star:getChildByName("Panel_star")
    local starsize = star_cell:getContentSize()
    local star_listView = UIListView:create(scroll_star)
    star_listView:setItemModel(star_cell)
    star_listView:setContentSize(me.size(starsize.width*tokenCfg.star,starsize.height))
    for st =1,tokenCfg.star do
    	star_listView:pushBackDefaultItem()
    end

	TFDirector:getChildByPath(itemCard,"Label_level_title"):setTextById(800006, "")
	TFDirector:getChildByPath(itemCard,"Label_level"):setText(tokenCfg.level)

	itemCard:getChildByName("Image_icon"):setTexture(tokenCfg.icon)
    CollectDataMgr:addItemTrophy(itemCard, tokenInfo.id)
	itemCard:onClick(function()
		if CollectDataMgr:getItemClickEnable() == false then
			return
		end
		Utils:showInfo(itemCard.cid)
	end)
end

function CollectTokenView:updateSuitPage(filtInfo)
	local collectCount = table.count(filtInfo)
	if collectCount <= 0 then
		return
	end
	local suitAllCfg = {}
	for i = 1,collectCount do
		local tmTokenInfo = filtInfo[i]
		local tmTokenCfg = CollectDataMgr:getTokenCfg(tmTokenInfo.id)
		local suitId = tonumber(tmTokenCfg.suitId)
		if suitAllCfg[suitId] == nil then
			local tmSuitCfg = CollectDataMgr:getTokenSuitCfg(suitId)
			suitAllCfg[suitId] = {suitCfg = tmSuitCfg,itemlist = {}}
		end
		table.insert(suitAllCfg[suitId].itemlist,tmTokenInfo)
	end
	local suitCount = table.count(suitAllCfg)
	local suitAllkeys = table.keys(suitAllCfg)
	if suitCount >= 2 then
		table.sort( suitAllkeys, function(a,b)
			return a < b
		end )
	end
	local cellCount = math.ceil(suitCount/2)
	for i=1,cellCount do
		local itemCell = self.cellModel[self.tabTypeId]:clone()
		self.list_view:pushBackCustomItem(itemCell)
		itemCell:setVisible(true)
		for j=1,2 do
			local suitInfo = suitAllCfg[suitAllkeys[2*(i-1)+j]]
			if suitInfo == nil then
				return
			end
			local item_cell_part = itemCell:getChildByName("Panel_part_"..j)
			item_cell_part:setVisible(true)
			item_cell_part:getChildByName("Image_title_bg"):getChildByName("Label_title"):setTextById(suitInfo.suitCfg.NameId)
			for t = 1,4 do
				local tokenInfo = suitInfo.itemlist[t]
				if tokenInfo then
					local itemCard = self.token_model:clone()
					itemCard:setPosition(me.p(0,0))
					item_cell_part:getChildByName("Panel_equip_"..t):getChildByName("Panel_equip_card"):addChild(itemCard)
					item_cell_part:getChildByName("Panel_equip_"..t):setVisible(true)
					itemCard:setVisible(true)
					itemCard.cid = tokenInfo.id
					local isunclock = CollectDataMgr:isCollectItemExist(tokenInfo.collecttype,tokenInfo.id)
					local tokenCfg = CollectDataMgr:getTokenCfg(tokenInfo.id)
					item_cell_part:getChildByName("Panel_equip_"..t):getChildByName("Image_lock"):setVisible(not isunclock)
					item_cell_part:getChildByName("Panel_equip_"..t):getChildByName("Image_null"):setVisible(false)
					self:updateItemCard(itemCard,tokenInfo,isunclock,tokenCfg)
				else
					item_cell_part:getChildByName("Panel_equip_"..t):getChildByName("Image_lock"):setVisible(false)
					item_cell_part:getChildByName("Panel_equip_"..t):getChildByName("Image_null"):setVisible(true)
				end
			end
		end
	end
end

function CollectTokenView:onShow()
	self.super.onShow(self)
	self:updatePage()
end

function CollectTokenView:registerEvents()
	
end

return CollectTokenView