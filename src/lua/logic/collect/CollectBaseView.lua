local CollectBaseView = class("CollectBaseView",BaseLayer)

function CollectBaseView:ctor(...)
	self.super.ctor(self)
	self:initData(...)
	self:init("lua.uiconfig.collect.collectBaseView")	
end

function CollectBaseView:initData(defaultLeftBar)
	self.defaultLeftBar = defaultLeftBar or 1
end

function CollectBaseView:initUI(ui)
	self.super.initUI(self,ui)
	local root_panel = ui:getChildByName("Panel_root")
	self.panel_root = root_panel
	local left_scroll = root_panel:getChildByName("ScrollView_leftbar")
	self.left_bar_listview = UIListView:create(left_scroll)
	self.leftbar_models = {}
	for i=1,4 do
		self.leftbar_models[i] = root_panel:getChildByName("Panel_bar_"..i)
	end
	self.trophy_panel = root_panel:getChildByName("Panel_trophy")
	self.img_listbar = root_panel:getChildByName("Image_scrollBar")
	local Image_scrollBarInner = TFDirector:getChildByPath(self.img_listbar, "Image_scrollBarInner")
    self.scrollBar = UIScrollBar:create(self.img_listbar, Image_scrollBarInner)
	self.pulldown_panel = self.trophy_panel:getChildByName("Panel_pulldown")
end

function CollectBaseView:registCallback(param)
	self.tabSelCallback = param.tabSelCallback
	self.filtSelCallback = param.filtSelCallback
end

function CollectBaseView:makeLeftBar(param)
	self.left_bar_listview:removeAllItems()
	local leftBarCount = table.count(param)
	for i = 1,leftBarCount do
		local tmleftbarCfg = param[i]
		local tmleftbar = self.leftbar_models[tmleftbarCfg.bartype]:clone()
		self.left_bar_listview:pushBackCustomItem(tmleftbar)
		tmleftbar.btn_sel = tmleftbar:getChildByName("Button_sel")
		tmleftbar.img_sel = tmleftbar:getChildByName("Image_sel_sign")
		local tmlb_title = tmleftbar:getChildByName("Label_title")
		tmleftbar.img_sel:setVisible(false)
		tmlb_title:setTextById(tmleftbarCfg.title)
		tmleftbar.btn_sel:setTextureNormal("ui/collect/TJ_JL_anniu_0.png")
		tmleftbar.btn_sel.idx = i
		tmleftbar.btn_sel.tabCfg = tmleftbarCfg.extCfg
		tmleftbar.btn_sel.filtCfg = tmleftbarCfg.filt
		tmleftbar.btn_sel.bartype = tmleftbarCfg.bartype
		tmleftbar.btn_sel:onClick(function()
			self:onClickTabbar(tmleftbar)
		end)
		if tmleftbarCfg.bartype == 4 then
			local star_panel = tmleftbar:getChildByName("Panel_star")
			for sidx=1,5 do
				star_panel:getChildByName("Image_star_"..sidx):setVisible(sidx <= tmleftbarCfg.quantity)
			end
		else
			tmleftbar:getChildByName("Image_icon"):setTexture(tmleftbarCfg.icon)
		end
	end
	self:makePulldown()
	self:jumpToTab(self.defaultLeftBar)
end

function CollectBaseView:jumpToTab(idx)
	local leftBar = self.left_bar_listview:getItem(idx)
	if leftBar == nil then
		return;
	end
	self:onClickTabbar(leftBar)
end

function CollectBaseView:onClickTabbar(tmleftbar)
	tmleftbar.btn_sel:setTextureNormal("ui/collect/TJ_JL_anniu_1.png")
	tmleftbar.img_sel:setVisible(true)
	local allitems = self.left_bar_listview:getItems()
	for k,v in ipairs(allitems) do
		local tmcheckBtn = v.btn_sel
		if tmcheckBtn.idx ~= tmleftbar.btn_sel.idx then
			tmcheckBtn:setTextureNormal("ui/collect/TJ_JL_anniu_0.png")
			v.img_sel:setVisible(false)
		end
	end
	if self.tabSelCallback then
		self.tabSelCallback(tmleftbar.btn_sel.tabCfg)
	end
	self:updatePulldown(tmleftbar.btn_sel.filtCfg,tmleftbar.btn_sel.filtCfg.default)
end

function CollectBaseView:makePulldown()
	self.btn_pulldown = self.pulldown_panel:getChildByName("Button_pulldown")
	self.pulldown_window = self.pulldown_panel:getChildByName("Panel_window")
	self.pulldown_winCell = self.pulldown_window:getChildByName("Panel_pullwin")
	local scroll_menu = self.pulldown_winCell:getChildByName("ScrollView_menu")
	local pulldown_cell = scroll_menu:getChildByName("Panel_cell")
	self.defaultPulldownCellSize = pulldown_cell:getContentSize()
	self.btn_pulldown.stat = false
	self.btn_pulldown.unclick = false
	self.pulldown_btnlist = UIListView:create(scroll_menu)
	self.pulldown_btnlist:setItemModel(pulldown_cell)
	pulldown_cell:setVisible(false)
end

function CollectBaseView:updatePulldown(param,selfilt)
	self.pulldown_winCell:stopAllActions()
	local listcount = table.count(param.list)
	local filtkeys = table.keys(param.list)
	table.sort( filtkeys, function(a,b)
		return a < b
	end )
	self.curwindownsize = me.size(self.defaultPulldownCellSize.width,self.defaultPulldownCellSize.height*listcount)
	self.btn_pulldown.title = param.list[selfilt].title
	self.btn_pulldown:getChildByName("Label_title"):setTextById(self.btn_pulldown.title)
	self.pulldown_btnlist:removeAllItems()
	self.pulldown_window:setContentSize(self.curwindownsize)
	self.pulldown_btnlist:setContentSize(self.curwindownsize)
	self.pulldown_winCell:setPosition(me.p(0,0))

	for i = 1,listcount do
		local tmitem = self.pulldown_btnlist:pushBackDefaultItem()
		tmitem:setVisible(true)
		tmitem.filtKey = filtkeys[i]
		if i==1 and i < listcount then
			tmitem:getChildByName("Image_option"):setTexture("ui/playerInfo/medal/ui_09.png")
		elseif i < listcount then
			tmitem:getChildByName("Image_option"):setTexture("ui/playerInfo/medal/ui_12.png")
		else
			tmitem:getChildByName("Image_option"):setTexture("ui/playerInfo/medal/ui_10.png")
		end
		tmitem.title = param.list[filtkeys[i]].title
		tmitem:getChildByName("Label_title"):setTextById(tmitem.title)
		tmitem.itemlist = param.list[filtkeys[i]].itemlist
		tmitem:setTouchEnabled(true)
		tmitem:onClick(function()
			if self.btn_pulldown.unclick == true then
				return
			end
			self.btn_pulldown.unclick = true
			local actionarr = {MoveTo:create(0.1,me.p(0,0)),CallFunc:create(function()
				self.btn_pulldown.unclick = false
				self.btn_pulldown.stat = false
				if self.btn_pulldown.title ~= tmitem.title then
					self.btn_pulldown.title = tmitem.title
					self.btn_pulldown:getChildByName("Label_title"):setTextById(self.btn_pulldown.title)
					if self.filtSelCallback then
						self.filtSelCallback(tmitem.itemlist,tmitem.filtKey)
					end
				end
			end)}
			self.pulldown_winCell:runAction(Sequence:create(actionarr))
		end)
	end
	self.btn_pulldown:onClick(function()
		if self.btn_pulldown.unclick == true then
			return
		end
		self.btn_pulldown.unclick = true
		if self.btn_pulldown.stat == false then
			local actionarr = {MoveTo:create(0.1,me.p(0,-self.curwindownsize.height)),CallFunc:create(function()
				self.btn_pulldown.unclick = false
				self.btn_pulldown.stat = true
			end)}
			self.pulldown_winCell:runAction(Sequence:create(actionarr))
		else
			local actionarr = {MoveTo:create(0.1,me.p(0,0)),CallFunc:create(function()
				self.btn_pulldown.unclick = false
				self.btn_pulldown.stat = false
			end)}
			self.pulldown_winCell:runAction(Sequence:create(actionarr))
		end
	end)
	if self.filtSelCallback then
		self.filtSelCallback(param.list[selfilt].itemlist,selfilt)
	end
end

function CollectBaseView:updateTrophy(pageType)
	local param = CollectDataMgr:getCollectsProcessByPage(pageType)
	
	local player_name_lb = self.trophy_panel:getChildByName("Label_player_name")
	local player_pid_lb = player_name_lb:getChildByName("Label_pid")
	local lodingbar_collect = self.trophy_panel:getChildByName("LoadingBar_progress")
	local trophy_value_lb = self.trophy_panel:getChildByName("Label_tropy_value")
	local trophy_percent_lb = self.trophy_panel:getChildByName("Label_percent_value")
	player_name_lb:setString(CollectDataMgr:getPlayerName())
	player_pid_lb:setString(string.format("ID: %s",tostring(CollectDataMgr:getPlayerId())))
	lodingbar_collect:setPercent(param.percent)
	trophy_percent_lb:setString(tostring(param.percent))
	trophy_value_lb:setString(tostring(param.trophy))
end


function CollectBaseView:refreshView()
	
end

function CollectBaseView:registerEvents()
	
end




return CollectBaseView