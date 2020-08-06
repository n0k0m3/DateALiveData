local CollectorView = class("CollectorView",BaseLayer)

function CollectorView:initData()
	local tmCollectorCfg = CollectDataMgr:getCollectorCfg()
	self.collectCfg = {}
	for k,v in pairs(tmCollectorCfg) do
		if v.isOpen == true then
			table.insert(self.collectCfg,v)
		end
	end
	if table.count(self.collectCfg) >= 2 then
		table.sort(self.collectCfg, function(a,b)
			return a.cup < b.cup
		end )
	end

end

function CollectorView:ctor(param)
	self.super.ctor(self)
	self:initData()
	self:init("lua.uiconfig.collect.collectorView")
end

function CollectorView:initUI(ui)
	self.super.initUI(self,ui)
	self.root_panel = ui:getChildByName("Panel_root")
	local page_panel = self.root_panel:getChildByName("Panel_page")
	self.close_btn = page_panel:getChildByName("Button_close")
	local item_model = self.root_panel:getChildByName("Panel_cell")
	local scroll_list = page_panel:getChildByName("ScrollView_list")
	self.list_view = UIListView:create(scroll_list)
	self.list_view:setItemModel(item_model)
end

function CollectorView:refreshView()
	local rankInfo = CollectDataMgr:getRankInfo()
	for i,v in ipairs(self.collectCfg) do
		local tmItem = self.list_view:getItem(i)
		if tmItem == nil then
			tmItem = self.list_view:pushBackDefaultItem()
		end
		tmItem:setVisible(true)
		local isUnlock = (v.cup <= rankInfo.trophy)
		tmItem:getChildByName("Image_logo"):setTexture(v.icon)
		tmItem:getChildByName("Panel_lock"):setVisible(not isUnlock)
		tmItem:getChildByName("Label_trophy_value"):setString(tostring(v.cup))
		tmItem:getChildByName("Label_title"):setTextById(v.name)
		if isUnlock then
			tmItem:getChildByName("Image_title_bg"):setOpacity(255)
		else
			tmItem:getChildByName("Image_title_bg"):setOpacity(25)
		end
	end
end

function CollectorView:onShow()
	self.super.onShow(self)
	self:refreshView()
end

function CollectorView:registerEvents()
	
	self.root_panel:onClick(function()
		AlertManager:closeLayer(self)
	end)
	self.close_btn:onClick(function()
		AlertManager:closeLayer(self)
	end)
end

return CollectorView