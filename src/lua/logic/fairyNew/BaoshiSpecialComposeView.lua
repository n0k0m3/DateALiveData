--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
* -- 材料合成宝石界面
]]
local BaoshiSpecialComposeView = class("BaoshiSpecialComposeView",BaseLayer)

function BaoshiSpecialComposeView:ctor( data )
	-- body
	self.super.ctor(self,data)
	self:initData(data)
	self:init("lua.uiconfig.fairyNew.baoshiSpecialComposeView")
end

function BaoshiSpecialComposeView:initData( data )
	self.curStage = 1
	local stone = TabDataMgr:getData("Stone")
	self.stoneData = {}
	for k,v in pairs(stone) do
		self.stoneData[v.heroId] = self.stoneData[v.heroId] or {}
		self.stoneData[v.heroId][v.superType] = self.stoneData[v.heroId][v.superType] or {}
		self.stoneData[v.heroId][v.superType][v.rarity] = self.stoneData[v.heroId][v.superType][v.rarity] or {}
		self.stoneData[v.heroId][v.superType][v.rarity][v.skillType] = v
	end

	local stoneSmelt = TabDataMgr:getData("StoneSmelt")

	self.stoneSmelt = {}

	for k,v in pairs(stoneSmelt) do
		self.stoneSmelt[v.type] = self.stoneSmelt[v.type] or {}
		table.insert(self.stoneSmelt[v.type],v)
	end


	self.types = table.keys(self.stoneSmelt)

	table.sort(self.types,function ( a ,b )
		return a < b
	end)

	for k,v in pairs(self.stoneSmelt) do
		table.sort(v,function ( a, b)
			return a.rarity < b.rarity
		end)
	end

	self.curHero = nil
	self.curRarity = nil
	self.curSkillType = nil

	self.curTypeIdx = 0
	self.showType = self.types[1] -- 43 宝石，44 图纸

	self.heroList = {}
	HeroDataMgr:resetShowList(true);
	local showCount = HeroDataMgr:getShowCount()
	for idx = 1,showCount do
		local heroid = HeroDataMgr:getSelectedHeroId(idx);
		table.insert(self.heroList,heroid)
	end

end

function BaoshiSpecialComposeView:initUI( ui )
	self.super.initUI(self,ui)
	local Panel_left = TFDirector:getChildByPath(ui,"Panel_left")
	self.Panel_center = TFDirector:getChildByPath(Panel_left,"Panel_center")

	self.posItem = {}
	for i = 1,3 do
		self.posItem[i] = TFDirector:getChildByPath(Panel_left,"Panel_pos"..i)
		self.posItem[i].Image_icon = TFDirector:getChildByPath(self.posItem[i],"Image_icon")
		self.posItem[i].image_sel = TFDirector:getChildByPath(self.posItem[i],"image_sel")
	end


	self.Image_angel_icon = TFDirector:getChildByPath(Panel_left,"Image_angel_icon")
	self.btn_compose = TFDirector:getChildByPath(Panel_left,"btn_compose")
	self.btn_qieye = TFDirector:getChildByPath(ui,"btn_qieye")
	self.btn_qieye1 = TFDirector:getChildByPath(ui,"btn_qieye1")
	self.Panel_item = TFDirector:getChildByPath(ui,"Panel_item")

	local Panel_right = TFDirector:getChildByPath(ui,"Panel_right")
	self.Panel_Gray = TFDirector:getChildByPath(Panel_right,"Panel_Gray")
	local ScrollView_baoshi = TFDirector:getChildByPath(Panel_right,"ScrollView_baoshi")
	self.uiGrid_baoshi = UIGridView:create(ScrollView_baoshi)
  	self.uiGrid_baoshi:setItemModel(self.Panel_item)
  	self.uiGrid_baoshi:setColumn(4)
  	self.btn_choose = TFDirector:getChildByPath(Panel_right,"btn_choose")
  	self.Label_choose = TFDirector:getChildByPath(Panel_right,"Label_choose")
  	self.Label_choose1 = TFDirector:getChildByPath(Panel_right,"Label_choose1")
  	self.Label_choose2 = TFDirector:getChildByPath(Panel_right,"Label_choose2")
  	self.btn_sure = TFDirector:getChildByPath(Panel_right,"btn_sure")

  	self.costItem = {}
  	for i = 1,2 do
  		self.costItem[i] = TFDirector:getChildByPath(Panel_right,"Panel_cost"..i)
  		self.costItem[i].Image_res_icon = TFDirector:getChildByPath(self.costItem[i],"Image_res_icon") 
  		self.costItem[i].Label_res_num = TFDirector:getChildByPath(self.costItem[i],"Label_res_num") 
  	end

  	self:updateLeft()
  	self:updateList()
  	self:updateRight()
end

function BaoshiSpecialComposeView:registerEvents(  )
	self.super.registerEvents(self)
	self.btn_sure:onClick(function ( ... )
		if (self.curStage == 1 and self.curRarity) 
			or (self.curStage == 2 and self.curHero)
			or (self.curStage == 3 and self.curSkillType) then
			self.curStage = self.curStage + 1
			self:updateLeft()
  			self:updateList()
			self:updateRight()
			if self.curStage == 4 then
				TFDirector:getChildByPath(self.btn_compose,"effect"):playByIndex(0,-1,-1,0)
			end
		else
			Utils:showTips(1100052)
		end
	end)

	self.btn_compose:onClick(function ( ... )
		if self.curStage ~= 4 then
			Utils:showTips(1100045)
		else
			local cost = {}
			local key = "consume"
			if self.curHero ~= 0 and self.curSkillType ~= 0 then
				key = "consume3"
			elseif self.curHero ~= 0 then
				key = "consume2"
			end
			local cost = self.stoneSmelt[self.showType][self.curRarityIdx][key]

			local isEnough = true

			for k,v in pairs(cost) do
				if not GoodsDataMgr:currencyIsEnough(k, v) then
					isEnough = false
				end
			end

			if isEnough then
				EquipmentDataMgr:reqRecomposeGem(self.curHero,self.curRarity,self.curSkillType,self.showType)
			else
				Utils:showTips(1100046)
			end
		end
	end)

	self.btn_qieye:onClick(function ( ... )
		self.showType = self.types[1]
		self.curHero = nil
		self.curRarity = nil
		self.curSkillType = nil
		self.curRarityIdx = nil
		self.curStage = 1
		self:updateLeft()
  		self:updateList()
		self:updateRight()
	end)

	self.btn_qieye1:onClick(function ( ... )
		self.showType = self.types[2]
		self.curHero = nil
		self.curRarity = nil
		self.curSkillType = nil
		self.curRarityIdx = nil
		self.curStage = 1
		self:updateLeft()
  		self:updateList()
		self:updateRight()
	end)


	self.btn_choose:onClick(function ( ... )
		self.curStage = self.curStage - 1
		self.curStage = math.max(1,self.curStage)
		self.curRarity = self.curStage > 1 and self.curRarity or nil
		self.curRarityIdx = self.curStage > 1 and self.curRarityIdx or nil
		self.curHero = self.curStage > 2 and self.curHero or nil
		self.curSkillType = self.curStage > 3 and self.curSkillType or nil
		self:updateLeft()
  		self:updateList()
		self:updateRight()
	end)

	EventMgr:addEventListener(self,EQUIPMENT_GEM_RECOMPOSE_GEM,function ( data )
		-- body
		Utils:showReward(data.items)
		self.curHero = nil
		self.curRarity = nil
		self.curRarityIdx = nil
		self.curSkillType = nil
		self.curStage = 1
		self:updateLeft()
  		self:updateList()
		self:updateRight()
	end)
end

function BaoshiSpecialComposeView:updateLeft()
	self.btn_qieye1:setTextureNormal(self.showType == self.types[2] and "ui/fairy/new_ui/baoshi/btn_qieye_s.png" or "ui/fairy/new_ui/baoshi/btn_qieye.png")
	self.btn_qieye:setTextureNormal(self.showType == self.types[1] and "ui/fairy/new_ui/baoshi/btn_qieye_s.png" or "ui/fairy/new_ui/baoshi/btn_qieye.png")
	self.btn_qieye:getChildByName("label_text"):setTextById(1100050)
	self.btn_qieye1:getChildByName("label_text"):setTextById(1100051)
	if self.curHero and self.curRarity and self.curSkillType and self.curHero ~= 0 and self.curSkillType ~= 0 then
		local cfg = self.stoneData[self.curHero][self.showType][self.curRarity][self.curSkillType]
		self:updateBaoshiItem(self.Panel_center,cfg)
	else
	    local Image_bg = TFDirector:getChildByPath(self.Panel_center,"Image_bg")
	    local Image_icon = TFDirector:getChildByPath(self.Panel_center,"Image_icon")
	    local Image_quality = TFDirector:getChildByPath(self.Panel_center,"Image_quality"):hide()
	    local Image_quality_bg = TFDirector:getChildByPath(self.Panel_center,"Image_quality_bg"):hide()
		Image_icon:setTexture("icon/stone/random/524008.png")
		Image_bg:setTexture(EquipmentDataMgr:getGemIconBg(self.curRarity))
	end

	self.posItem[1].image_sel:setVisible(self.curStage == 1)
	self.posItem[2].image_sel:setVisible(self.curStage == 2)
	self.posItem[3].image_sel:setVisible(self.curStage == 3)

	if self.curRarity then
		self.posItem[1].Image_icon:show()
		self.posItem[1].Image_icon:setTexture(self.stoneSmelt[self.showType][self.curRarityIdx].icon) -- 品阶
		self.posItem[1].Image_icon:setScale(90/self.posItem[1].Image_icon:getContentSize().width)
	else
		self.posItem[1].Image_icon:hide()
	end

	if self.curHero then
		self.posItem[2].Image_icon:show()
		self.posItem[2].Image_icon:setTexture(self.curHero ~= 0 and HeroDataMgr:getHeadIconPathById(self.curHero) or "icon/stone/random/524008.png") -- 头像
	else
		self.posItem[2].Image_icon:hide()	
	end

	if self.curSkillType then
		self.posItem[3].Image_icon:show()
		if self.curSkillType ~= 0 and self.curHero ~= 0 then
			local stoneCfg = self.stoneData[self.curHero][self.showType][self.curRarity][self.curSkillType]
			self.posItem[3].Image_icon:setTexture(stoneCfg.skillIcon) -- 技能icon 
		else
			self.posItem[3].Image_icon:setTexture("icon/stone/random/524008.png") -- 问号
		end
	else
		self.posItem[3].Image_icon:hide()
	end
	self.btn_compose:setVisible(self.curStage == 4)
	-- self.btn_compose:setTextureNormal(self.curStage == 4 and "ui/fairy/new_ui/baoshi/052.png" or "ui/fairy/new_ui/baoshi/055.png" )
	if self.curStage == 1 then
		self.Image_angel_icon:setTexture("ui/fairy/new_ui/baoshi/059.png")
	elseif self.curStage == 2 then
		self.Image_angel_icon:setTexture("ui/fairy/new_ui/baoshi/056.png")
	elseif self.curStage == 3 then
		self.Image_angel_icon:setTexture("ui/fairy/new_ui/baoshi/057.png")
	else
		self.Image_angel_icon:setTexture("ui/fairy/new_ui/baoshi/058.png")
	end
end


function BaoshiSpecialComposeView:updateBaoshiItem(item, cfg)
    local Image_bg = TFDirector:getChildByPath(item,"Image_bg")
    local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
    local Image_quality = TFDirector:getChildByPath(item,"Image_quality"):show()
    local Image_quality_bg = TFDirector:getChildByPath(item,"Image_quality_bg"):show()
    Image_bg:setTexture(EquipmentDataMgr:getGemIconBg(cfg.quality))
    Image_icon:setTexture(cfg.icon)
    Image_quality:setTexture(EquipmentDataMgr:getGemRarityIcon(cfg.rarity))
    Image_quality_bg:setTexture(EquipmentDataMgr:getGemQualityBg(cfg.quality))
end

function BaoshiSpecialComposeView:updateList( )
	self.currentSelectItem = nil
	if self.curStage == 1 then
		self:updateRarityList()
	elseif self.curStage == 2 then
		self:updateHeroList()
	elseif self.curStage == 3 then
		self:updateSkillList()
	end
end

function BaoshiSpecialComposeView:updateRight()
	self.Panel_Gray:setVisible(self.curStage == 4)
	local textId = math.min(1100049,1100046+self.curStage - 1)
	self.Label_choose1:setVisible(self.curStage > 1)
	self.Label_choose1:setTextById(textId)

	textId = math.min(1100049,1100046+self.curStage)
	self.Label_choose:setTextById(textId)

	textId = math.min(1100049,1100046+self.curStage + 1)
	self.Label_choose2:setVisible(self.curStage < 3)
	self.Label_choose2:setTextById(textId)
	
	self.btn_choose:setVisible(self.curStage > 1)
	for k,v in pairs(self.costItem) do
		v:hide()
	end

	if self.curRarityIdx then
		local cost = {}
		local key = "consume"
		if self.curHero ~= 0 and self.curSkillType and self.curSkillType ~= 0 then
			key = "consume3"
		elseif self.curHero and self.curHero ~= 0 then
			key = "consume2"
		end
		local cost = self.stoneSmelt[self.showType][self.curRarityIdx][key]
		local index = 1 
		for k,v in pairs(cost) do
			local item = self.costItem[index]
			if item then
				item:show()
				local cfg = GoodsDataMgr:getItemCfg(k)
				item.Image_res_icon:setTexture(cfg.icon)
				item.Label_res_num:setText(v)

				if not GoodsDataMgr:currencyIsEnough(k,v) then
					item.Label_res_num:setFontColor(ccc3(255,0,0))
				else
					item.Label_res_num:setFontColor(ccc3(255,255,255))
				end
				item:setTouchEnabled(true)
				item:onClick(function ( ... )
					Utils:showInfo(k)
				end)
			end
			index = index + 1
		end
	end
end

function BaoshiSpecialComposeView:updateHeroList(  )
	local list = clone(self.heroList)
	table.insert(list,1,0)
	self.uiGrid_baoshi:removeAllItems()
	for k,v in pairs(list) do
		local item = self.uiGrid_baoshi:pushBackDefaultItem()
		local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
		local Image_select = TFDirector:getChildByPath(item,"Image_select")
		local Image_pos_bg = TFDirector:getChildByPath(item,"Image_pos_bg"):hide()
		local Image_bg = TFDirector:getChildByPath(item,"Image_bg")
		Image_bg:setTexture("ui/common/frame_normal.png")
		local texture = ""
		if v ~= 0 then
			texture = HeroDataMgr:getHeadIconPathById(v)
		else
			texture = "icon/stone/random/524008.png"
			Image_icon:setPositionX(0)
		end
		Image_select:setVisible(v == self.curHero)
		Image_icon:setTexture(texture)
		item:setTouchEnabled(true)
		item:onClick(function ( ... )
			self.curHero = v
			if self.currentSelectItem  then self.currentSelectItem:hide() end
			Image_select:setVisible(true)
			self.currentSelectItem = Image_select
			self:updateRight()
		end)
	end
end

function BaoshiSpecialComposeView:updateRarityList(  )
	local list = self.stoneSmelt[self.showType]	
	self.uiGrid_baoshi:removeAllItems()
	for k,v in pairs(list) do
		local item = self.uiGrid_baoshi:pushBackDefaultItem()
		local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
		local Image_select = TFDirector:getChildByPath(item,"Image_select")
		local Image_pos_bg = TFDirector:getChildByPath(item,"Image_pos_bg"):hide()
		local Image_bg = TFDirector:getChildByPath(item,"Image_bg")
		Image_bg:setTexture(EquipmentDataMgr:getGemIconBg(v.rarity))
		local texture = v.icon		
		Image_select:setVisible(k == self.curRarityIdx)
		Image_icon:setTexture(texture)
		item:setTouchEnabled(true)
		item:onClick(function ( ... )
			self.curRarity = v.rarity
			self.curRarityIdx = k
			if self.currentSelectItem  then self.currentSelectItem:hide() end
			Image_select:setVisible(true)
			self.currentSelectItem = Image_select
			self:updateRight()
		end)
	end
end

function BaoshiSpecialComposeView:updateSkillList(  )
	local list = {}
	if self.curHero ~= 0 then
		local tableSkll = {}
		tableSkll = self.stoneData[self.curHero][self.showType][self.curRarity]
		list = table.keys(tableSkll)
	end

	table.insert(list,1,0)
	self.uiGrid_baoshi:removeAllItems()
	for k,v in pairs(list) do
		local item = self.uiGrid_baoshi:pushBackDefaultItem()
		local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
		local Image_select = TFDirector:getChildByPath(item,"Image_select")
		local Image_pos_bg = TFDirector:getChildByPath(item,"Image_pos_bg")
		local Image_bg = TFDirector:getChildByPath(item,"Image_bg")
		Image_bg:setTexture("ui/common/frame_normal.png")
		local texture = ""
		local stoneCfg
		if v ~= 0 then
			stoneCfg = self.stoneData[self.curHero][self.showType][self.curRarity][v]
			texture = stoneCfg.skillIcon
			for i=1,4 do
		        local Image_pos = TFDirector:getChildByPath(item,"Image_pos"..i)
		        Image_pos:setTexture(stoneCfg.skillType == i and "ui/fairy/new_ui/baoshi/032.png" or "ui/fairy/new_ui/baoshi/031.png")
		    end
		else
			texture = "icon/stone/random/524008.png"
		end

		Image_select:setVisible(v == self.curSkillType)
		Image_icon:setTexture(texture)
		item:setTouchEnabled(true)
		item:onClick(function ( ... )
			self.curSkillType = v
			if self.currentSelectItem  then self.currentSelectItem:hide() end
			Image_select:setVisible(true)
			self.currentSelectItem = Image_select
			self:updateRight()
		end)
	end
end

function BaoshiSpecialComposeView:removeEvents()
    self.super.removeEvents(self)
    HeroDataMgr:resetShowList()
end

return BaoshiSpecialComposeView