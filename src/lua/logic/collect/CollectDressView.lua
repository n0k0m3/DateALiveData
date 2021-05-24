local CollectDressView = class("CollectDressView",BaseLayer)

function CollectDressView:initData()
	self.pageUICfg = {}
	local tmPageUIcfg = CollectDataMgr:getPageUICfg(EC_CollectPage.DRESS)
	for k,v in pairs(tmPageUIcfg) do
		table.insert(self.pageUICfg,v)
	end
	table.sort( self.pageUICfg, function(a,b)
		return a.order < b.order
	end )
end

function CollectDressView:ctor()
	self.super.ctor(self)
	self:initData()
	self:init("lua.uiconfig.collect.collectDressView")
end

function CollectDressView:initUI(ui)
	self.super.initUI(self,ui)
	self.root_panel = ui:getChildByName("Panel_root")
	local base_panel = self.root_panel:getChildByName("Panel_base")
	self.collectBaseView = require("lua.logic.collect.CollectBaseView"):new()
    base_panel:addChild(self.collectBaseView)
    self.childArr:push(self.collectBaseView)
    self.dress_model = self.root_panel:getChildByName("ClippingNode_dress_model")
    local dress_list_cell = self.root_panel:getChildByName("Panel_dress_cell")
    local scroll_list = self.root_panel:getChildByName("ScrollView_list")
    self.list_view = UIListView:create(scroll_list)
    self.list_view:setItemModel(dress_list_cell)
    self.list_view:setScrollBar(self.collectBaseView.scrollBar)
    self:initBaseUI()
end

function CollectDressView:initBaseUI()
	local callbackCfg = {tabSelCallback = handler(self.onSelTab,self),filtSelCallback = handler(self.onSelFiltTab,self)}
	self.collectBaseView:registCallback(callbackCfg)
	self.collectBaseView:makeLeftBar(self.pageUICfg)
end

function CollectDressView:onSelTab(tabInfo)
	
end

function CollectDressView:onSelFiltTab(filtInfo,filtKey)
	self:updateInfoPage(filtInfo)
end

function CollectDressView:updatePage()
	self.collectBaseView:updateTrophy(EC_CollectPage.DRESS)
	CollectDataMgr:clearRedShow(EC_CollectPage.DRESS)
end

function CollectDressView:updateInfoPage(filtInfo)
	self.list_view:removeAllItems()
	me.TextureCache:removeUnusedTextures()
	local collectCount = table.count(filtInfo)
	if collectCount >= 2 then
		table.sort( filtInfo, function(a,b)
			return a.order < b.order
		end )
	end
	local cellCount = math.ceil(collectCount/5)
	if table.count(filtInfo)%5 == 0 then
		cellCount = cellCount + 1
	end
	for i=1,cellCount do
		local itemCell = self.list_view:pushBackDefaultItem()
		itemCell:setVisible(true)
		for j = 1,5 do
			local dressInfo = filtInfo[5*(i-1)+j]
			local itemCardRoot = self.dress_model:clone()
			itemCardRoot:setPosition(me.p(0,0))
			itemCell:getChildByName("Panel_kidcell_"..j):addChild(itemCardRoot)
			local itemCard = itemCardRoot:getChildByName("Panel_dress_model")
			itemCard:setVisible(true)
			isNullCard = (dressInfo == nil)
			itemCard:getChildByName("Image_bg"):setVisible(not isNullCard)
			itemCard:getChildByName("Image_dress"):setVisible(not isNullCard)
			itemCard:getChildByName("Image_front"):setVisible(not isNullCard)
			itemCard:getChildByName("Image_lock"):setVisible(not isNullCard)
			itemCard:getChildByName("Image_null"):setVisible(isNullCard)
			if isNullCard then
				break
			end
			local isunclock = CollectDataMgr:isCollectItemExist(dressInfo.collecttype,dressInfo.id)
			itemCard.cid = dressInfo.id
			itemCard:getChildByName("Image_lock"):setVisible(not isunclock)
			local dressCfg = CollectDataMgr:getDressCfg(dressInfo.id)
			itemCard:getChildByName("Image_dress"):setTexture(dressCfg.dressImg)
			itemCard:getChildByName("Image_front"):getChildByName("Label_dress"):setTextById(dressCfg.nameTextId)

			CollectDataMgr:addItemTrophy(itemCard, dressInfo.id)
			itemCard:onClick(function()
				if CollectDataMgr:getItemClickEnable() == false then
					return
				end
				Utils:showInfo(itemCard.cid)
			end)
		end
	end
end

function CollectDressView:onShow()
	self.super.onShow(self)
	self:updatePage()
end

function CollectDressView:registerEvents()
	
end

return CollectDressView