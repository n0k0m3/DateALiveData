local CollectPortraitView = class("CollectPortraitView",BaseLayer)

function CollectPortraitView:initData()
	self.pageUICfg = {}
	local tmPageUIcfg = CollectDataMgr:getPageUICfg(EC_CollectPage.PORTRAIT)
	for k,v in pairs(tmPageUIcfg) do
		table.insert(self.pageUICfg,v)
	end
	table.sort( self.pageUICfg, function(a,b)
		return a.order < b.order
	end )
end

function CollectPortraitView:ctor()
	self.super.ctor(self)
	self:initData()
	self:init("lua.uiconfig.collect.collectPortraitView")
end

function CollectPortraitView:initUI(ui)
	self.super.initUI(self,ui)
	self.root_panel = ui:getChildByName("Panel_root")
	local base_panel = self.root_panel:getChildByName("Panel_base")
	self.collectBaseView = require("lua.logic.collect.CollectBaseView"):new()
    base_panel:addChild(self.collectBaseView)
    self.childArr:push(self.collectBaseView)
    self.cardModel = {}
    self.cardModel[EC_CollectType.PORTRAIT] = self.root_panel:getChildByName("Panel_avatar_model")
    self.cardModel[EC_CollectType.PORTRAIT_FRAME] = self.root_panel:getChildByName("Panel_frame_model")
    self.cellModel = {}
    self.cellModel[EC_CollectType.PORTRAIT] = self.root_panel:getChildByName("Panel_avatar_cell")
    self.cellModel[EC_CollectType.PORTRAIT_FRAME] = self.root_panel:getChildByName("Panel_frame_cell")
    local scroll_list = self.root_panel:getChildByName("ScrollView_list")
    self.list_view = UIListView:create(scroll_list)
    self.list_view:setScrollBar(self.collectBaseView.scrollBar)
    self:initBaseUI()
end

function CollectPortraitView:initBaseUI()
	local callbackCfg = {tabSelCallback = handler(self.onSelTab,self),filtSelCallback = handler(self.onSelFiltTab,self)}
	self.collectBaseView:registCallback(callbackCfg)
	self.collectBaseView:makeLeftBar(self.pageUICfg)
end

function CollectPortraitView:onSelTab(tabInfo)
	
end

function CollectPortraitView:onSelFiltTab(filtInfo,filtKey)
	self:updateInfoPage(filtInfo)
end

function CollectPortraitView:updatePage()
	self.collectBaseView:updateTrophy(EC_CollectPage.PORTRAIT)
	CollectDataMgr:clearRedShow(EC_CollectPage.PORTRAIT)
end

function CollectPortraitView:updateInfoPage(filtInfo)
	self.list_view:removeAllItems()
	me.TextureCache:removeUnusedTextures()
	SpineCache:getInstance():clearUnused()
	
	local typeInfos = {}
	for i,info in ipairs(filtInfo) do
		local cfg = CollectDataMgr:getPortraitCfg(info.id)
		if not cfg then
			local errormsg = string.format("Portrait cfg not found id = %s", tostring(info.id))
			Box(errormsg)
		end
		typeInfos[cfg.titleType] = typeInfos[cfg.titleType] or {}
        table.insert(typeInfos[cfg.titleType], info)
	end
	local showInfos = {}
	for k,infos in pairs(typeInfos) do
        local showInfo
        if #infos > 1 then
            table.sort(infos,function(a, b)
                return a.order < b.order
            end)
            for i = #infos, 1, -1  do
                if CollectDataMgr:isCollectItemExist(infos[i].collecttype,infos[i].id) then
                    showInfo = infos[i]
                    break
                end
            end
            if not showInfo then
                showInfo = infos[1]
            end
        else
            showInfo = infos[1]
        end
        showInfos[#showInfos + 1] = showInfo
    end
    table.sort(showInfos, function(a,b)
		return a.order < b.order
	end )
	local collectCount = table.count(showInfos)
	if collectCount <= 0 then
		return
	end

	local cell_include = {[EC_CollectType.PORTRAIT] = 7,[EC_CollectType.PORTRAIT_FRAME] = 5}
	local collectSubType = showInfos[1].collecttype
	curCellSize = cell_include[collectSubType]
	local cellCount = math.ceil(collectCount/curCellSize)
	for i=1,cellCount do
		local itemCell = self.cellModel[collectSubType]:clone()
		self.list_view:pushBackCustomItem(itemCell)
		itemCell:setVisible(true)
		for j = 1,curCellSize do
			local portraitInfo = showInfos[curCellSize*(i-1)+j]
			if portraitInfo == nil then
				return
			end
			local itemCard = self.cardModel[portraitInfo.collecttype]:clone()
			itemCard:setPosition(me.p(0,0))
			itemCell:getChildByName("Panel_kidcell_"..j):addChild(itemCard)
			itemCard:setVisible(true)
			itemCard.cid = portraitInfo.id
			local isunclock = CollectDataMgr:isCollectItemExist(portraitInfo.collecttype,portraitInfo.id)
			itemCard:getChildByName("Image_cover"):setVisible(not isunclock)
			local portraitCfg = CollectDataMgr:getPortraitCfg(portraitInfo.id)

			local Image_icon = itemCard:getChildByName("Image_icon")
			Image_icon:setTexture(portraitCfg.icon)
			local effect = portraitCfg.ShowEffect1 ~= "" and portraitCfg.ShowEffect1 or portraitCfg.ShowEffect2
			local headEffect = Image_icon:getChildByName("headEffect")
			if headEffect then
				headEffect:removeFromParent()
			end
			if effect ~= "" then
				headEffect = SkeletonAnimation:create(effect)
				headEffect:setAnchorPoint(ccp(0,0))
				headEffect:setName("headEffect")
				headEffect:setPosition(ccp(0,0))
				headEffect:play("animation", true)
				Image_icon:addChild(headEffect, 1)
			end

			if portraitInfo.collecttype == EC_CollectType.PORTRAIT_FRAME then
				itemCard:getChildByName("Label_desc"):setTextById(portraitCfg.name)
				if #portraitCfg.toggle > 0  then
			        local extraData = AvatarDataMgr:getExtraData()
			        local month = extraData.month or 1
			        for k, v in pairs(portraitCfg.toggle) do
			            local months = v.month
			            local month1 = months[1]
			            local month2 = months[2]
			            if month >= month1 and month <= month2 then
			                itemCard:getChildByName("Image_icon"):setTexture(v.icon)
			                itemCard:getChildByName("Label_desc"):setTextById(v.name)
			                break
			            end
			        end
			    end
			end

			CollectDataMgr:addItemTrophy(itemCard, portraitInfo.id)
			itemCard:onClick(function()
				if CollectDataMgr:getItemClickEnable() == false then
					return
				end
			end)
		end
	end
end

function CollectPortraitView:onShow()
	self.super.onShow(self)
	self:updatePage()
end

function CollectPortraitView:registerEvents()
	
end

return CollectPortraitView