local CollectSpriteView = class("CollectSpriteView",BaseLayer)

function CollectSpriteView:initData()
	self.pageUICfg = {}
	local tmPageUIcfg = CollectDataMgr:getPageUICfg(EC_CollectPage.SPRITE)
	for k,v in pairs(tmPageUIcfg) do
		table.insert(self.pageUICfg,v)
	end
	table.sort( self.pageUICfg, function(a,b)
		return a.order < b.order
	end )
end

function CollectSpriteView:ctor()
	self.super.ctor(self)
	self:initData()
	self:init("lua.uiconfig.collect.collectSpriteView")
end

function CollectSpriteView:initUI(ui)
	self.super.initUI(self,ui)
	self.root_panel = ui:getChildByName("Panel_root")
	local base_panel = self.root_panel:getChildByName("Panel_base")
	self.collectBaseView = require("lua.logic.collect.CollectBaseView"):new()
    base_panel:addChild(self.collectBaseView)
    self.childArr:push(self.collectBaseView)
    self.spriteShowPanel = self.root_panel:getChildByName("ClippingNode_sprite"):getChildByName("Panel_sprite")
    self.skin_model = self.root_panel:getChildByName("Panel_skin_model")
    local skin_list_cell = self.root_panel:getChildByName("Panel_skin_cell")
    local scroll_list = self.root_panel:getChildByName("ScrollView_list")
    self.list_view = UIListView:create(scroll_list)
    self.list_view:setItemModel(skin_list_cell)
    self.list_view:setScrollBar(self.collectBaseView.scrollBar)
    self:initBaseUI()
end

function CollectSpriteView:initBaseUI()
	local callbackCfg = {tabSelCallback = handler(self.onSelTab,self),filtSelCallback = handler(self.onSelFiltTab,self)}
	self.collectBaseView:registCallback(callbackCfg)
	self.collectBaseView:makeLeftBar(self.pageUICfg)
end

function CollectSpriteView:onSelTab(tabInfo)
	local heroId = tabInfo.relation
	local anim_hero = Utils:createTeamHeroModel(heroId, self.spriteShowPanel:getChildByName("Panel_spine"))
    self.spriteShowPanel:getChildByName("Label_name"):setString(HeroDataMgr:getName(heroId))
    local en_name = HeroDataMgr:getEnName2(heroId)
    self.spriteShowPanel:getChildByName("Label_en_name"):setString(en_name)
	local isHasHero = HeroDataMgr:getIsHave(heroId)
	local quality_img = self.spriteShowPanel:getChildByName("Image_quality")
    if isHasHero then
        quality_img:setTexture(HeroDataMgr:getQualityPic(heroId))
    else
        quality_img:setTexture(HeroDataMgr:getQualityPicNotHave(heroId))
    end

	local fight_img = self.spriteShowPanel:getChildByName("Image_fight")
	fight_img:setVisible(isHasHero)
	if isHasHero == false then
		return
	end
	fight_img:getChildByName("Label_power"):setString(tostring(math.floor(HeroDataMgr:getHeroPower(heroId))))
end

function CollectSpriteView:onSelFiltTab(filtInfo,filtKey)
	self:updateInfoPage(filtInfo)
end

function CollectSpriteView:updatePage()
	self.collectBaseView:updateTrophy(EC_CollectPage.SPRITE)
	CollectDataMgr:clearRedShow(EC_CollectPage.SPRITE)
end

function CollectSpriteView:updateInfoPage(filtInfo,filtKey)
	self.list_view:removeAllItems()
	local collectCount = table.count(filtInfo)
	if collectCount >= 2 then
		table.sort( filtInfo, function(a,b)
			return a.order < b.order
		end )
	end
	local cellCount = math.ceil(collectCount/3)
	if table.count(filtInfo)%3 == 0 then
		cellCount = cellCount + 1
	end
	for i=1,cellCount do
		local itemCell = self.list_view:pushBackDefaultItem()
		itemCell:setVisible(true)
		for j = 1,3 do
			local skinInfo = filtInfo[3*(i-1)+j]
			local itemCard = self.skin_model:clone()
			itemCard:setPosition(me.p(0,0))
			itemCell:getChildByName("Panel_kidcell_"..j):addChild(itemCard)
			itemCard:setVisible(true)
			isNullCard = (skinInfo == nil)
			itemCard:getChildByName("Image_bg"):setVisible(not isNullCard)
			itemCard:getChildByName("Image_skin"):setVisible(not isNullCard)
			itemCard:getChildByName("Image_front"):setVisible(not isNullCard)
			itemCard:getChildByName("Image_lock"):setVisible(not isNullCard)
			itemCard:getChildByName("Image_null"):setVisible(isNullCard)
			if isNullCard then
				break
			end
			local isunclock = CollectDataMgr:isCollectItemExist(skinInfo.collecttype,skinInfo.id)
			itemCard.cid = skinInfo.id
			itemCard:getChildByName("Image_lock"):setVisible(not isunclock)
			local skinCfg = CollectDataMgr:getSkinCfg(skinInfo.id)
			itemCard:getChildByName("Image_skin"):setTexture(skinCfg.skinImg)
			itemCard:getChildByName("Image_front"):getChildByName("Label_skin"):setTextById(skinCfg.nameTextId)

            CollectDataMgr:addItemTrophy(itemCard, skinInfo.id)
			itemCard:onClick(function()
				if CollectDataMgr:getItemClickEnable() == false then
					return
				end
				Utils:showInfo(itemCard.cid)
			end)
		end
	end
end



function CollectSpriteView:onShow()
	self.super.onShow(self)
	self:updatePage()
end

function CollectSpriteView:registerEvents()
	
end

return CollectSpriteView