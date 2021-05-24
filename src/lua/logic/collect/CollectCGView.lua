local CollectCGView = class("CollectCGView",BaseLayer)

function CollectCGView:initData(jumpTabIndex, playId)
	self.pageUICfg = {}
	local tmPageUIcfg = CollectDataMgr:getPageUICfg(EC_CollectPage.CG)
	for k,v in pairs(tmPageUIcfg) do
		table.insert(self.pageUICfg,v)
	end
	table.sort( self.pageUICfg, function(a,b)
		return a.order < b.order
	end )
	self.isActivityCG = false
	self.playId = playId

	self.jumpTabIndex = jumpTabIndex or 1
end

function CollectCGView:ctor(...)
	self.super.ctor(self)
	self:initData(...)
	self:init("lua.uiconfig.collect.collectCGView")
end

function CollectCGView:initUI(ui)
	self.super.initUI(self,ui)
	self.root_panel = ui:getChildByName("Panel_root")
	self.Panel_cgRoot = ui:getChildByName("Panel_cgShow")
	local base_panel = self.root_panel:getChildByName("Panel_base")
	self.collectBaseView = require("lua.logic.collect.CollectBaseView"):new(self.jumpTabIndex)
    base_panel:addChild(self.collectBaseView)
    self.childArr:push(self.collectBaseView)

    self.activityCell = self.root_panel:getChildByName("Panel_ext_cell")
    self.baseCell = self.root_panel:getChildByName("Panel_base_cell")
    self.baseModel = self.root_panel:getChildByName("Panel_baseCG_model")
    local scroll_list = self.root_panel:getChildByName("ScrollView_list")
    self.list_view = UIListView:create(scroll_list)
    self.list_view:setScrollBar(self.collectBaseView.scrollBar)
    self:initBaseUI()

	if self.playId then
		local cgCfg = CollectDataMgr:getCommonCGCfg(self.playId)
		self:playCG(cgCfg)
	end
end

function CollectCGView:initBaseUI()
	local callbackCfg = {tabSelCallback = handler(self.onSelTab,self),filtSelCallback = handler(self.onSelFiltTab,self)}
	self.collectBaseView:registCallback(callbackCfg)
	self.collectBaseView:makeLeftBar(self.pageUICfg)
end

function CollectCGView:onSelTab(tabInfo)
	self.isActivityCG = (tabInfo.id == 105003)
end

function CollectCGView:onSelFiltTab(filtInfo,filtKey)
	self.filtInfo = filtInfo
	self:updateInfoPage(filtInfo)
end

function CollectCGView:updatePage()
	self.collectBaseView:updateTrophy(EC_CollectPage.CG)
	CollectDataMgr:clearRedShow(EC_CollectPage.CG)
end

function CollectCGView:updateInfoPage(filtInfo)
	self.list_view:removeAllItems()
	me.TextureCache:removeUnusedTextures()
	
	if self.isActivityCG == true then
		self:updateActivityCGPage(filtInfo)
	else
		self:updateCommonCGPage(filtInfo)
	end
end

function CollectCGView:updateCommonCGPage(filtInfo)
	local cgTypeLogo = {
						[1] = {logo = "ui/collect/TJ_CG_icon_5.png",namebg = "ui/collect/TJ_CG_bg_1_3.png"},
						[2] = {logo = "ui/collect/TJ_CG_icon_6.png",namebg = "ui/collect/TJ_CG_bg_1_4.png"},
					}
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
		local itemCell = self.baseCell:clone()
		self.list_view:pushBackCustomItem(itemCell)
		itemCell:setVisible(true)
		for j = 1,3 do
			local cgInfo = filtInfo[3*(i-1)+j]
			if cgInfo == nil then
				return
			end
			local itemCard = self.baseModel:clone()
			itemCard:setPosition(me.p(0,0))
			itemCell:getChildByName("Panel_kidcell_"..j):addChild(itemCard)
			itemCard:setVisible(true)
			itemCard:getChildByName("Label_title"):setTextById(cgInfo.name)
			local isunclock = CollectDataMgr:isCollectItemExist(cgInfo.collecttype,cgInfo.id)
			itemCard:getChildByName("Image_lock"):setVisible(not isunclock)
			itemCard:getChildByName("Image_bg"):setVisible(isunclock)
			itemCard:getChildByName("Image_cg_icon"):setVisible(isunclock)
			itemCard:getChildByName("Image_type_logo"):setVisible(isunclock)
			itemCard:getChildByName("Image_type_bg"):setVisible(isunclock)
			local cgCfg = CollectDataMgr:getCommonCGCfg(cgInfo.id)
			itemCard:getChildByName("Image_type_logo"):setTexture(cgTypeLogo[cgCfg.type].logo)
			itemCard:getChildByName("Image_type_bg"):setTexture(cgTypeLogo[cgCfg.type].namebg)
			itemCard.cgCfg = cgCfg
			itemCard.unlock = isunclock
			local itemCfg = CollectDataMgr:getItemCfg(cgInfo.id)
			itemCard:getChildByName("Image_cg_icon"):setTexture(itemCfg.icon)

			CollectDataMgr:addItemTrophy(itemCard, cgInfo.id)
			itemCard:getChildByName("Image_bg"):onClick(function()
				if CollectDataMgr:getItemClickEnable() == false then
					return
				end
				if itemCard.unlock == false then
					return
				end
				self:playCG(itemCard.cgCfg)
			end)
		end
	end

end

function CollectCGView:playCG(cgCfg)
	if cgCfg.type == 1 then
		local winsize = me.Director:getWinSize()
		local defaultSize = me.size(1136,640)
		local origin = me.p((defaultSize.width - winsize.width)/2,(defaultSize.height - winsize.height)/2)
		local layer = require("lua.logic.common.CgView"):new(cgCfg.cg, cgCfg.backGround, true, function()
            self.topLayer:show()
        end,true)
        layer:setPosition(ccp(-self.Panel_cgRoot:getSize().width * 0.5 + origin .x, -self.Panel_cgRoot:getSize().height * 0.5 + origin.y))
        self.topLayer:hide()
        self.Panel_cgRoot:addChild(layer, 100)
	elseif cgCfg.type == 2 then
		if cgCfg.video ~= "" then
            TFAudio.stopAllEffects()
            local voideoView = Utils:openView("common.VideoView", cgCfg.video)
            voideoView:bindEndCallBack(function()
                SafeAudioExchangePlay().playBGM(self, true)
            end)
        end
	else

	end
end

function CollectCGView:updateActivityCGPage(filtInfo)
	local cgTypeLogo = {
						[1] = {logo = "ui/collect/TJ_CG_icon_5.png"},
						[2] = {logo = "ui/collect/TJ_CG_icon_6.png"},
						[3] = {logo = "ui/collect/TJ_CG_icon_7.png"},
					}
	local pokerIds = GoodsDataMgr:getSelfActivityPokers()
	local collectCount = table.count(filtInfo)
	if collectCount >= 2 then
		table.sort( filtInfo, function(a,b)
			return a.order < b.order
		end )
	end
	if collectCount <= 0 then
		return
	end
	for i=1,collectCount do
		local cgInfo = filtInfo[i]
		local isunclock,itemInfo = CollectDataMgr:isCollectItemExist(cgInfo.collecttype,cgInfo.id)
		if isunclock then
			local itemCell = self.activityCell:clone()
			self.list_view:pushBackCustomItem(itemCell)
			itemCell:setVisible(true)
			
			local activityCGCfg = CollectDataMgr:getActivityCGCfg(cgInfo.id)
			itemCell:getChildByName("Label_title"):setTextById(activityCGCfg.title)
			itemCell:getChildByName("Label_date"):setTextById(activityCGCfg.des1)
			itemCell:getChildByName("TextArea_desc"):setTextById(activityCGCfg.des2)
			itemCell:getChildByName("Image_cg_icon"):setTexture(activityCGCfg.icon)
			itemCell:getChildByName("Image_flag"):setTexture(activityCGCfg.tipIcon)
			local btn_get = itemCell:getChildByName("Button_get")
			btn_get:setVisible(isunclock and (table.count(activityCGCfg.reward) > 0) and CollectDataMgr:getItemClickEnable())
			btn_get.activityCfg = activityCGCfg
			if isunclock == true then
				for k,v in pairs(activityCGCfg.reward) do
					if CollectDataMgr:getItemClickEnable() == false then
						break
					end
					local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_dropGoodsItem"):clone()
		            Panel_goodsItem:Scale(0.75)
		            Panel_goodsItem:setPosition(me.p(0,0))
		            PrefabDataMgr:setInfo(Panel_goodsItem, {k}, 0,{})
		            Panel_goodsItem:getChildByName("Image_geted"):setVisible(itemInfo.rewardStat == 2)
					itemCell:getChildByName("Panel_reward"):addChild(Panel_goodsItem)
				end
				btn_get.canget = (itemInfo.rewardStat == 1)
				btn_get:setGrayEnabled(itemInfo.rewardStat ~= 1)
				btn_get:setTouchEnabled(itemInfo.rewardStat == 1)
				btn_get:onClick(function()
					if btn_get.canget == false or CollectDataMgr:getItemClickEnable() == false then
						return
					end
					CollectDataMgr:getCollectRewards(btn_get.activityCfg.id)
				end)
			end
			
			if activityCGCfg.link ~= "" then
				itemCell:getChildByName("Image_type_logo"):setTexture(cgTypeLogo[3].logo)
				itemCell.link = activityCGCfg.link
				itemCell:getChildByName("Image_cg_icon"):onClick(function()
					if CollectDataMgr:getItemClickEnable() == false then
						return
					end
					TFDeviceInfo:openUrl(itemCell.link)
				end)
				
			else
				local cgCfg = CollectDataMgr:getCommonCGCfg(cgInfo.id)
				itemCell:getChildByName("Image_type_logo"):setTexture(cgTypeLogo[cgCfg.type].logo)
				itemCell.cgCfg = cgCfg
				itemCell:getChildByName("Image_cg_icon"):onClick(function()
					if CollectDataMgr:getItemClickEnable() == false then
						return
					end
					self:playCG(itemCell.cgCfg)
				end)
			end
		end
	end


end

function CollectCGView:onShow()
	self.super.onShow(self)
	self:updatePage()
end

function CollectCGView:refreshView()
	self:updatePage()
	self:updateInfoPage(self.filtInfo)
end

function CollectCGView:registerEvents()
	EventMgr:addEventListener(self,EV_COLLECT_UPDATE_INFO,handler(self.refreshView, self))
end

return CollectCGView