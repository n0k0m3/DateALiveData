local CollectMedalView = class("CollectMedalView",BaseLayer)
local Medal_subType = {
	["medal"] = 208001,						--勋章
	["title"] = 208002						--称号
}
function CollectMedalView:initData()
	self.pageUICfg = {}
	local tmPageUIcfg = CollectDataMgr:getPageUICfg(EC_CollectPage.MEDAL)
	for k,v in pairs(tmPageUIcfg) do
		table.insert(self.pageUICfg,v)
	end
	table.sort( self.pageUICfg, function(a,b)
		return a.order < b.order
	end )
end

function CollectMedalView:ctor()
	self.super.ctor(self)
	self:initData()
	self:init("lua.uiconfig.collect.collectMedalView")
end

function CollectMedalView:initUI(ui)
	self.super.initUI(self,ui)
	self.root_panel = ui:getChildByName("Panel_root")
	local base_panel = self.root_panel:getChildByName("Panel_base")
	self.collectBaseView = require("lua.logic.collect.CollectBaseView"):new()
    base_panel:addChild(self.collectBaseView)
    self.childArr:push(self.collectBaseView)
    self.medal_model = self.root_panel:getChildByName("Panel_medal_model")
	self.Panel_title_model = self.root_panel:getChildByName("Panel_title_model")
    self.medal_list_cell = self.root_panel:getChildByName("Panel_single_cell")
	self.Panel_single_cell2 = self.root_panel:getChildByName("Panel_single_cell2")
    local scroll_list = self.root_panel:getChildByName("ScrollView_list")
    self.list_view = UIListView:create(clone(scroll_list))
    self.list_view:setScrollBar(self.collectBaseView.scrollBar)

    self:initBaseUI()
end

function CollectMedalView:initBaseUI()
	local callbackCfg = {tabSelCallback = handler(self.onSelTab,self),filtSelCallback = handler(self.onSelFiltTab,self)}
	self.collectBaseView:registCallback(callbackCfg)
	self.collectBaseView:makeLeftBar(self.pageUICfg)
end

function CollectMedalView:onSelTab(tabInfo)
	
end

function CollectMedalView:onSelFiltTab(filtInfo,filtKey)
	self.filtKey = filtKey
	if self.filtKey == Medal_subType.medal then
		self:updateInfoPage(filtInfo)
	elseif self.filtKey == Medal_subType.title then
		self:updateTitlePage(filtInfo)
	end
end

function CollectMedalView:updatePage()
	self.collectBaseView:updateTrophy(EC_CollectPage.MEDAL)
	CollectDataMgr:clearRedShow(EC_CollectPage.MEDAL)
end

function CollectMedalView:updateTitlePage(filtInfo)
	self.list_view:removeAllItems()
	me.TextureCache:removeUnusedTextures()
	SpineCache:getInstance():clearUnused()

	local collectCount = table.count(filtInfo)
	if collectCount >= 2 then
		table.sort( filtInfo, function(a,b)
			return a.order < b.order
		end )
	end
	if collectCount <= 0 then
		return
	end
	local cellCount = math.ceil(collectCount/3)
	for i=1,cellCount do
		local itemCell = self.Panel_single_cell2:clone()
		itemCell:setVisible(true)
		self.list_view:pushBackCustomItem(itemCell)
		for j = 1,3 do
			local titleInfo = filtInfo[3*(i-1)+j]
			if titleInfo == nil then
				return
			end

			local itemCard = self.Panel_title_model:clone()
			itemCard:setPosition(me.p(0,0))
			itemCell:getChildByName("Panel_kidcell_"..j):addChild(itemCard)
			itemCard:setVisible(true)
			itemCard.cid = titleInfo.id
			local isunclock = CollectDataMgr:isCollectItemExist(titleInfo.collecttype,titleInfo.id)
			itemCard:getChildByName("Image_lock"):setVisible(not isunclock)
			local titleCfg = TitleDataMgr:getTitleCfg(titleInfo.id)
			itemCard:getChildByName("Label_title_name"):setTextById(titleCfg.notable)
			local image_title = itemCard:getChildByName("Image_title")
			image_title:removeAllChildren()
	        local skeletonTitleNode = SkeletonAnimation:create(titleCfg.showEffect)
	        skeletonTitleNode:play("animation", true)
	        skeletonTitleNode:setPosition(ccp(0,0))
	        skeletonTitleNode:setAnchorPoint(ccp(0,0))
	        image_title:addChild(skeletonTitleNode,1)

			itemCard:onClick(function()
			end)
		end
	end
end

function CollectMedalView:updateInfoPage(filtInfo)

	self.list_view:removeAllItems()
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
		local itemCell = self.medal_list_cell:clone()
		itemCell:setVisible(true)
		self.list_view:pushBackCustomItem(itemCell)
		for j = 1,5 do
			local medalInfo = filtInfo[5*(i-1)+j]
			if medalInfo == nil then
				return
			end
			local itemCard = self.medal_model:clone()
			itemCard:setPosition(me.p(0,0))
			itemCell:getChildByName("Panel_kidcell_"..j):addChild(itemCard)
			itemCard:setVisible(true)
			itemCard.cid = medalInfo.id
			local isunclock = CollectDataMgr:isCollectItemExist(medalInfo.collecttype,medalInfo.id)
			itemCard:getChildByName("Image_lock"):setVisible(not isunclock)
			local medalCfg = CollectDataMgr:getMedalCfg(medalInfo.id)
			itemCard:getChildByName("Image_medal"):setTexture(medalCfg.icon)
			local scaleRate = medalCfg.size[1] or 100
			itemCard:getChildByName("Image_medal"):setScale(scaleRate / 100)
			itemCard:getChildByName("Label_medal_name"):setTextById(medalCfg.name)
			local star_scroll = itemCard:getChildByName("ScrollView_star")
			local star_cell = star_scroll:getChildByName("Panel_star")
			local star_cell_size = star_cell:getContentSize()
			star_cell:setVisible(false)
			star_listview = UIListView:create(star_scroll)
			star_listview:setItemModel(star_cell)
			star_listview:setContentSize(me.size(star_cell_size.width*medalCfg.star,star_cell_size.height))
			for i=1,medalCfg.star do
				local staritem = star_listview:pushBackDefaultItem()
				staritem:setVisible(true)
			end
			itemCard:onClick(function()
				if CollectDataMgr:getItemClickEnable() == false then
					return
				end
				Utils:openView("playerInfo.MedalInfoView", itemCard.cid)
			end)
		end
	end
end

function CollectMedalView:onShow()
	self.super.onShow(self)
	self:updatePage()
end

function CollectMedalView:registerEvents()
	
end

return CollectMedalView