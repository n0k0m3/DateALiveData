--[[
	结晶突破界面
]]

local FairyEvolutionLayer = class("FairyEvolutionLayer", BaseLayer)
local goodsTable = TabDataMgr:getData("Item")


function FairyEvolutionLayer:ctor(data)
    self.super.ctor(self,data)
	self.curPartition  = 0 --当前显示阶段
	self.curEvoCellId  = 0 --当前选中的格子id
	self.curEvoCellItem = nil
	self.isUseWanNeng = false;
    self.showHeroId = HeroDataMgr.showid    	
    self.paramData_ = data
    if data and data.friend then
    	self.isfriend = true;
    	if data.backTag then
    		self.backTag = data.backTag
    	end
    end

    if data and data.showid then
    	self.showHeroId = data.showid;
    end
    if data and data.partition then
	    self.initShowPartition = data.partition
	end
	
    if not self.initShowPartition then
		local evoData  = HeroDataMgr:getEvolutionNextCanUpDataByAll(self.showHeroId)
		self.initShowPartition = evoData.partition
    end

	self.isScrolling = false

    self:init("lua.uiconfig.fairyNew.fairyEvolution")
end

function FairyEvolutionLayer:getClosingStateParams()
    local param1 = {}
    if self.paramData_ then
        param1.friend = self.paramData_.friend
    end
    param1.backTag = self.backTag
    param1.showid = self.showHeroId
    param1.partition = self.curPartition
    return {param1}
end

function FairyEvolutionLayer:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	FairyEvolutionLayer.ui = ui
	self:addLockLayer()

	self.Panel_left			= TFDirector:getChildByPath(ui, "Panel_left")
	self.Panel_right		= TFDirector:getChildByPath(ui, "Panel_right")
	self.Panel_wn = 	TFDirector:getChildByPath(self.Panel_right, "Panel_wn")
	self.Button_evolution_max = TFDirector:getChildByPath(self.Panel_right, "Button_evolution_max")
	self.Image_wanneng = TFDirector:getChildByPath(self.Panel_right, "Image_wanneng")
	self.Label_wanneng = TFDirector:getChildByPath(self.Panel_right, "Label_wanneng")
	self.Label_wn_use = TFDirector:getChildByPath(self.Panel_right, "Label_wn_use")
	self.Image_select_di = TFDirector:getChildByPath(self.Panel_right, "Image_select_di")
	self.Button_evolution_max = TFDirector:getChildByPath(self.Panel_right, "Button_evolution_max")

	self.Panel_evolution      = TFDirector:getChildByPath(ui, "Panel_evolution")
	self.Panel_lines      = TFDirector:getChildByPath(ui, "Panel_lines")

	self.Label_evo_desc		  = TFDirector:getChildByPath(ui, "Label_evo_desc")
	self.ScrollView_material  = TFDirector:getChildByPath(ui, "ScrollView_material")
	self.ListView_material    = UIListView:create(self.ScrollView_material)
	self.Button_evolution     = TFDirector:getChildByPath(ui, "Button_evolution")
	self.Button_goLeft     = TFDirector:getChildByPath(ui, "Button_left")
	self.Button_goRight     = TFDirector:getChildByPath(ui, "Button_right")

	self.Image_evolution_bg   = TFDirector:getChildByPath(ui, "Image_evolution_bg")
	self.Image_evolution_level   = TFDirector:getChildByPath(ui, "Image_evolution_level")

	self.Panel_material_item  = TFDirector:getChildByPath(ui, "Panel_material_item")
	self.Panel_material_item:setVisible(false)
	
	self.Image_crystal_item   = TFDirector:getChildByPath(ui, "Image_crystal_item")
	self.Image_crystal_item:setVisible(false)

	self.Image_select    	  = TFImage:create("ui/fairy_crystal_details/7.png")
	self.Image_sss_level	= TFDirector:getChildByPath(ui, "Image_sss_level")
	self.Image_select:setVisible(true)
	self.Image_select:setScale(0.85)
	self.Panel_evolution:addChild(self.Image_select,1,1)

	self.Button_crystal = TFDirector:getChildByPath(ui,"Button_crystal");

	local size = self.Panel_evolution:getContentSize()
	self.pnlEvoBaseSize = CCSizeMake(size.width, size.height)
	size.width = size.width*10
	self.Panel_evolution:setContentSize(size)
	self.Panel_lines:setContentSize(size)

	self.Button_evolution:setVisible(not self.isfriend)

	self:updateEvolutionInfo()

	-- self:updateMaterialInfo()
	self:scrollToPage(self.initShowPartition,0.3)

	self.Image_sss_level:setTexture(HeroDataMgr:getQualityPic(self.showHeroId))
end

function FairyEvolutionLayer:registerEvents()
	EventMgr:addEventListener(self,EV_HERO_ACTIVECRYSTAL,handler(self.onHeroActiveCrystal, self)); --突破结晶消息的回调
	EventMgr:addEventListener(self,EV_HERO_ACTIVECRYSTAL_BATCH,handler(self.onHeroActiveCrystalBatch, self)); --突破结晶消息的回调
  	EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onItemUpdateEvent, self))
	
	self.startPos = nil
    local function onTouchBegan(touch, location)
    	self.startPos = location
    	return true
    end

    local function onTouchMoved(touch, location)
    end

    local function onTouchUp(touch, location)
       	local startPos = self.startPos
       	local endPos   = location
       	local dist     = endPos.x - startPos.x
       	if dist >= 40 then
       		self:scrollToPage(self.curPartition - 1)
       	elseif dist <= -40 then
       		self:scrollToPage(self.curPartition + 1)
       	end
    end

    self.Panel_evolution:addMEListener(TFWIDGET_TOUCHBEGAN, onTouchBegan);
    self.Panel_evolution:addMEListener(TFWIDGET_TOUCHMOVED, onTouchMoved);
    self.Panel_evolution:addMEListener(TFWIDGET_TOUCHENDED, onTouchUp);
    -- self.Panel_evolution:setSwallowTouch(false)

	self.Button_evolution:onClick(function()
		self.Button_evolution:setTouchEnabled(false)
		local evoData = self.curEvoCellItem.data
		if evoData then
    		HeroDataMgr:doReqActiveCrystal(evoData.heroId, evoData.partition, evoData.cell,self.isUseWanNeng)
    		GameGuide:checkGuideEnd(self.guideFuncId)
    		self.Panel_wn:getChildByName("Image_select"):hide();
			self.isUseWanNeng = false;
    	end
	end)

	self.Button_evolution_max:onClick(function()
			self.notHide = true	
			Utils:openView("fairyNew.FastEvolutionTips",self.showHeroId);
		end)

	self.Button_goLeft:onClick(function()
		self:scrollToPage(self.curPartition - 1)
		end
		)
	self.Button_goRight:onClick(function()
		self:scrollToPage(self.curPartition + 1)
		end
		)

	self.Button_crystal:onClick(function()
			Utils:openView("fairyNew.CrystalTransform");
		end)

	self.Panel_wn:setTouchEnabled(true)
	self.Panel_wn:onClick(function()
			local Image_select = self.Panel_wn:getChildByName("Image_select");
			self.isUseWanNeng = not self.isUseWanNeng
			Image_select:setVisible(self.isUseWanNeng)
			self:updateMaterialInfo();
		end)
end

function FairyEvolutionLayer:updateEvolutionInfo()	
	local partition = HeroDataMgr:getShowEvoPartition() --当前选中的是第几阶段的突破信息
	-- local partition = 1
	self.maxPartition = 7 --最大阶段

	self.tabEvoItem = {}
	

	--初始化结晶突破点
	local itemSize = CCSizeMake(57,77)
	local pnlSize  = self.pnlEvoBaseSize
	local offsetX, offsetY = 45, 87

	-- for i=1, 38 do
	-- 	local pos = HeroDataMgr:getCellIndexPos(i,itemSize.width,itemSize.height,offsetX,offsetY,pnlSize.height)

	-- 	local imgPoint = self.Image_crystal_item:clone()
	-- 	imgPoint:setVisible(true)
	-- 	imgPoint:setPosition(pos)

	-- 	local lab  = TFLabel:create()
	-- 	lab:setText("i:"..tostring(i))
	-- 	lab:setFontSize(24)
	-- 	lab:setPosition(0,0)
	-- 	lab:setAnchorPoint(ccp(0.5,0.5))
	-- 	lab:setColor(ccc3(0,0,255))
	-- 	imgPoint:addChild(lab)

	-- 	self.Panel_evolution:addChild(imgPoint,2)
	-- end

	-- local maxX, maxY = 0, 0
	for page=1, self.maxPartition do
		self.tabEvoItem[page] = {}
		local evoDatas  = HeroDataMgr:getEvolutionDataByPartition(self.showHeroId, page)
		for i, v in ipairs(evoDatas) do
			print("cell index:"..v.coordinates)

			local img = self:createOneEvoItem(v)
			local pos = HeroDataMgr:getCellIndexPos(tonumber(v.coordinates),itemSize.width,itemSize.height,offsetX,offsetY,pnlSize.height)
			-- pos.x = pos.x + (page-1)*itemSize.width*(7+1)
			pos.x = pos.x + (page-1)*pnlSize.width
			img:setPosition(pos)
			img:setZOrder(1)

			-- local lab  = TFLabel:create()
			-- lab:setText(""..tostring(v.cell))
			-- lab:setFontSize(24)
			-- lab:setPosition(0,0)
			-- lab:setAnchorPoint(ccp(0.5,0.5))
			-- lab:setColor(ccc3(0,0,255))
			-- img:addChild(lab)

			self.Panel_evolution:addChild(img,2,2)
			self.tabEvoItem[page][v.cell] = img
		end
	end
	self:updateLines()
	
end

function FairyEvolutionLayer:updateMaterialInfo()
	dump(self.curPartition)
	dump(self.curEvoCellId)

	local evoData  = HeroDataMgr:getEvolutionDataById(self.showHeroId, self.curPartition, self.curEvoCellId)
	if not evoData then
		return
	end
	print("updateMaterialInfo========================>")
	print(self.curPartition, self.curEvoCellId)

	self.ListView_material:removeAllItems()
	for k, v in pairs(evoData.material) do
		local item = self.Panel_material_item:clone()
		self:initOneMaterialItem(item, {goodsId=k, goodsCount=v})
		if k ~=  500001 then
			self.ListView_material:pushBackCustomItem(item)
		else
			local Label_needCoins = TFDirector:getChildByPath(self.Panel_right, "Label_needCoins")
			Label_needCoins:setString(v)
			Label_needCoins:setFontColor(v>GoodsDataMgr:getItemCount(500001) and ccc3(219,50,50) or ccc3(255,255,255))

		end
	end

	self.Label_evo_desc:setString(evoData.des)

	local sss_level = HeroDataMgr:getQuality(self.showHeroId)
	local Image_unlock_tips = TFDirector:getChildByPath(self.Panel_right, "Image_unlock_tips"):hide()
	local Image_evolutioned = TFDirector:getChildByPath(self.Panel_right, "Image_evolutioned"):hide()
	local Label_preLock = TFDirector:getChildByPath(self.Panel_right, "Label_preLock"):hide()
	self.Panel_wn:hide();
	if self.curPartition <= sss_level then
		local isUnlock = HeroDataMgr:getEvolutionIsUnlock(evoData)
		local isHaveGoods = HeroDataMgr:getEvoGoodsIsEnough(evoData)
		if isUnlock then
			local isUped = HeroDataMgr:getEvolutionIsFinish(evoData)
			if isUped then --已突破
				self.Button_evolution:hide()
				self.Button_evolution_max:hide();
				Image_evolutioned:show()
			else
				self.Button_evolution:show()
				self.Button_evolution_max:show();
				Utils:setNodeGray(self.Button_evolution, not isHaveGoods)
				self.Button_evolution:setTouchEnabled(isHaveGoods)

				Utils:setNodeGray(self.Button_evolution_max, not isHaveGoods)
				self.Button_evolution_max:setTouchEnabled(isHaveGoods)

				local show = not isHaveGoods;
				self.Panel_wn:setVisible(not isHaveGoods);
				self.Panel_wn:getChildByName("Image_select"):setVisible(self.isUseWanNeng);
				if self.Panel_wn:isVisible() then
					local wnCfg = TabDataMgr:getData("Item",510241)
					self.Image_wanneng:setTexture(wnCfg.icon);
					self.Image_wanneng:setSize(CCSizeMake(100,100));
					local needWN,WNCount,isEnough,isWNenough = HeroDataMgr:getEvoNeedWN(evoData);
					self.Label_wn_use:setText(WNCount);
					self.Label_wanneng:setText("/"..needWN);
					self.Label_wn_use:setFontColor(not isWNenough and ccc3(219,50,50) or ccc3(0,0,0))
					self.Label_wanneng:setPositionX(self.Label_wn_use:getPositionX() + self.Label_wn_use:getSize().width);
					if isEnough and self.isUseWanNeng then
						Utils:setNodeGray(self.Button_evolution, not isEnough)
						self.Button_evolution:setTouchEnabled(isEnough)

						Utils:setNodeGray(self.Button_evolution_max, not isEnough)
						self.Button_evolution_max:setTouchEnabled(isEnough)
					end
				end
			end
		else
			Label_preLock:show()
			self.Button_evolution:hide()
			self.Button_evolution_max:hide();
			self.Panel_wn:hide();
		end
	else
		
		self.Button_evolution:hide()
		self.Button_evolution_max:hide();
		self.Panel_wn:hide();
		Image_unlock_tips:show()
		TFDirector:getChildByPath(self.Panel_right, "Image_quality_icon"):setTexture(HeroDataMgr:getQualityPic(self.showHeroId, self.curPartition))
		-- Image_unlock_tips:setTexture(HeroDataMgr:getQualityPic(self.showHeroId))
		-- Image_unlock_tips:setContentSize(CCSizeMake(200,200))
		--Label_unlock_tips:setString(string.format("进阶到%s后解锁",EC_HeroQuality[self.curPartition]))
	end

	if self.Button_evolution:isVisible() then
		self.Button_evolution:setVisible(not self.isfriend);
		self.Button_evolution_max:setVisible(not self.isfriend);
	end
end

function FairyEvolutionLayer:createOneEvoItem(data)
	local item = self.Image_crystal_item:clone()
	self:initOneCrystalItem(item, data)
	return item
end

function FairyEvolutionLayer:initOneMaterialItem(item, data)
	item:setVisible(true)
	item.data = data

	local goodsData = goodsTable[data.goodsId]

	local imgBg   = TFDirector:getChildByPath(item, "Image_material_bg")
	imgBg:setTexture(EC_ItemIcon[goodsData.quality])
	imgBg:setContentSize(CCSizeMake(100,100))
	local imgIcon = TFDirector:getChildByPath(item, "Image_material_icon")
	imgIcon:setTexture(goodsData.icon)
	imgIcon:setContentSize(CCSizeMake(100,100))

	local currCount = GoodsDataMgr:getItemCount(data.goodsId)
	local labNeedCount = TFDirector:getChildByPath(item, "Label_material_need_count")
	local labCurrCount = TFDirector:getChildByPath(item, "Label_material_curr_count")
	local labName = TFDirector:getChildByPath(item, "Label_material_name")

	
	

	labNeedCount:setString( "/ "..data.goodsCount)
	labCurrCount:setFontColor(data.goodsCount>currCount and ccc3(219,50,50) or ccc3(0,0,0))
	labName:setTextById(goodsData.nameTextId)
	labCurrCount:setString(currCount)

	item:setTouchEnabled(true)
	item:onClick(function()
		self.notHide = true		
        Utils:showInfo(data.goodsId,nil,true);
	end)
end

function FairyEvolutionLayer:initOneCrystalItem(item, data)
	item:setVisible(true)
	item.data = data

	-- local isUnlock = HeroDataMgr:getEvolutionIsUnlock(data)
	-- local icon = TFDirector:getChildByPath(item, "Image_crystal_icon")
	-- icon:setTexture(data.icon)
	-- if isUnlock then
	-- 	local isFinish  = HeroDataMgr:getEvolutionIsFinish(data)
	-- 	item:setTexture(isFinish and "ui/fairy_crystal_details/6.png" or "ui/fairy_crystal_details/5.png")
	-- else
	-- 	item:setTexture("ui/fairy_crystal_details/16.png")
	-- end

	local icon = TFDirector:getChildByPath(item, "Image_crystal_icon")
	icon:setTexture(data.icon)
	local isFinish  = HeroDataMgr:getEvolutionIsFinish(data)
	item:setTexture(isFinish and "ui/fairy_crystal_details/6.png" or "ui/fairy_crystal_details/5.png")
	if data.cellIcon and isFinish then
		item:setTexture("ui/fairy_crystal/better.png")
	end
	if data.cellIcon and (not isFinish) then
		item:setTexture("ui/fairy_crystal/betterLock.png")
	end


	item:setTouchEnabled(true)
    item:setSwallowTouch(false)
	item:onClick(function()
		if not self.isScrolling then
			self:selectEvoItem(item)
		end
	end)
end

function FairyEvolutionLayer:selectEvoItem(item)
	if not item then
		return
	end
	local data = item.data
	self.Image_select:setPosition(item:getPosition())
	self.curEvoCellId = data.cell
	self.curEvoCellItem = item
	self:updateMaterialInfo()
end

function FairyEvolutionLayer:scrollToPage(pageIndex, dt)
	if self.isScrolling then
		return
	end
	if not pageIndex then
		return
	end
	if pageIndex<1 or pageIndex>7 then
		return
	end
	if pageIndex == self.curPartition then
		return
	end
	local moveToX = (pageIndex-1) * -self.pnlEvoBaseSize.width
	dt = dt or 0.3
	local moveEvo = CCMoveTo:create(dt, ccp(moveToX, 0))
	local callEvo = CCCallFunc:create(function()
		self.isScrolling = false	
	end)
	local moveLine = CCMoveTo:create(dt, ccp(moveToX, 0))
	local callLine = CCCallFunc:create(function()
		self.isScrolling = false	
	end)
	local seqLine  = CCSequence:create({moveLine, callLine})
	local seqEvo  = CCSequence:create({moveEvo, callEvo})

	self.isScrolling = true
	self.Panel_evolution:stopAllActions()
	self.Panel_lines:stopAllActions()
	self.Panel_evolution:runAction(seqEvo)
	self.Panel_lines:runAction(seqLine)
	self.curPartition = pageIndex
	self:updateCurrentEvoInfo()

end

function FairyEvolutionLayer:updateCurrentEvoInfo()
	self.curEvoCellId = HeroDataMgr:getEvolutionNextCanUpData(self.showHeroId, self.curPartition).cell
	dump(self.curPartition)
	dump(self.curEvoCellId)
	local cellItem    = self:getEvoItem(self.curPartition, self.curEvoCellId)
	self:selectEvoItem(cellItem)
	-- self:updateMaterialInfo()
	local bg = cellItem.data.bg

	local panel = TFDirector:getChildByPath(self.ui, "Panel_pageIndex")
	for i=1, 7 do
		local icon = TFDirector:getChildByPath(panel, "Image_icon_"..i)
		icon:setTexture("ui/common/page_controller_normal.png")
		if i == self.curPartition then
			icon:setTexture("ui/common/page_controller_select.png")
		end
	end

	-- self.Image_evolution_level:setTexture(bg)
end

function FairyEvolutionLayer:getEvoItem(partition, cellId)
	local cellItem = self.tabEvoItem[partition][cellId]
	return cellItem
end

function FairyEvolutionLayer:onHeroActiveCrystalBatch(data)
	self.isUseWanNeng = false;
	self.Button_evolution:setTouchEnabled(true);
	dump(data);
	for i,v in ipairs(data) do
		local neighborEvoData = HeroDataMgr:getEvolutionDataById(v.heroId,v.rarity,v.gridId)
		local item = self.tabEvoItem[neighborEvoData.partition][v.gridId]
		if item then
			self:initOneCrystalItem(item, neighborEvoData)
		end

		local effect = nil
		if neighborEvoData.cellIcon then
			effect = SkeletonAnimation:create("effect/effect_heroGrow_ui7/effect_heroGrow_ui7")
		else	
	    	effect = SkeletonAnimation:create("effect/effect_heroGrow_ui8/effect_heroGrow_ui8")
		end
	    effect:setAnimationFps(GameConfig.ANIM_FPS)	
	    item:addChild(effect)
	    effect:setPosition(ccp(10, 0))
	    effect:playByIndex(0, -1, -1, 0)  
	end

	local evoData  = HeroDataMgr:getEvolutionNextCanUpDataByAll(self.showHeroId)
	local cellItem    = self:getEvoItem(self.curPartition, evoData.cell)
	if evoData.partition ~= self.curPartition then
		self:scrollToPage(evoData.partition)
		cellItem    = self:getEvoItem(self.curPartition, evoData.cell)
	end
	Utils:playSound(1001)
    self:selectEvoItem(cellItem)
    self:updateLines();  
end

function FairyEvolutionLayer:onHeroActiveCrystal(data)
	print("FairyEvolutionLayer 收到了结晶突破消息")
	dump(data)
	self.isUseWanNeng = false;
	self.Button_evolution:setTouchEnabled(true)
	if not self.curEvoCellItem or not self.curEvoCellItem.data then
		return
	end
	dump(self.curEvoCellItem.data)
	if self.curEvoCellItem.data.heroId == data.heroId
		and self.curEvoCellItem.data.partition == data.rarity
		and self.curEvoCellItem.data.cell == data.gridId then
		--突破了当前选中的结晶，刷新界面
		-- self:initOneEvoItem(self.curEvoCellItem, self.curEvoCellItem.data)
		-- self:updateMaterialInfo()
		local evoData = HeroDataMgr:getEvolutionDataById(self.curEvoCellItem.data.heroId,self.curEvoCellItem.data.partition,self.curEvoCellItem.data.cell)
		self:initOneCrystalItem(self.curEvoCellItem, evoData)
		for i, cellId in ipairs(evoData.neighborId) do
			local neighborEvoData = HeroDataMgr:getEvolutionDataById(evoData.heroId,nil,cellId)
			local item = self.tabEvoItem[neighborEvoData.partition][cellId]
			if item then
				self:initOneCrystalItem(item, neighborEvoData)
			end
		end
		self:showSpendEffect()
		self:showBreakEffect()
		Utils:playSound(1001)


		local evoData  = HeroDataMgr:getEvolutionNextCanUpDataByAll(self.showHeroId)
		local cellItem    = self:getEvoItem(self.curPartition, evoData.cell)

		if evoData.partition ~= self.curPartition then
			self:scrollToPage(evoData.partition)
			cellItem    = self:getEvoItem(self.curPartition, evoData.cell)
		end

		
	end


	--Utils:showTips("突破成功！")
	self:updateLines()
end

function FairyEvolutionLayer:showSpendEffect() 
	local evoData = HeroDataMgr:getEvolutionDataById(self.curEvoCellItem.data.heroId,self.curEvoCellItem.data.partition,self.curEvoCellItem.data.cell)

	local count = 0
	for k,v in pairs(evoData.material) do
   		count = count + 1
	end
	local length = count - 1
	for i = 1, length do
		local effect = TFDirector:getChildByPath(self.Panel_right, "Spine_spend" .. i)
        effect:playByIndex(0, -1, -1, 0) 
        effect:addMEListener(TFARMATURE_COMPLETE,function(_skeletonNode)
        	local evoData  = HeroDataMgr:getEvolutionNextCanUpDataByAll(self.showHeroId)
			local cellItem    = self:getEvoItem(self.curPartition, evoData.cell)
            self:selectEvoItem(cellItem)  
            end)
    end
end

function FairyEvolutionLayer:showBreakEffect()
	local evoData =  self.curEvoCellItem.data
	local effect = nil
	if evoData.cellIcon then
		effect = SkeletonAnimation:create("effect/effect_heroGrow_ui7/effect_heroGrow_ui7")
	else	
    	effect = SkeletonAnimation:create("effect/effect_heroGrow_ui8/effect_heroGrow_ui8")
	end
    effect:setAnimationFps(GameConfig.ANIM_FPS)	
    self.curEvoCellItem:addChild(effect)
    effect:setPosition(ccp(10, 0))
    effect:playByIndex(0, -1, -1, 0)  
end

function FairyEvolutionLayer:updateLines()

	local lineCount = 0
	self.tabEvoLine = {}
	self.Panel_lines:removeAllChildren()
	--初始化突破点连线
	for page=1, self.maxPartition do
		-- self.tabEvoLine[a] = {}
		local evoDatas  = HeroDataMgr:getEvolutionDataByPartition(self.showHeroId, page)
		for i, v in ipairs(evoDatas) do
			for i2, v2 in ipairs(v.neighborId) do
				local key = v.cell.."-"..v2
				local key2 = v2.."-"..v.cell
				if not self.tabEvoLine[key] and not self.tabEvoLine[key2] then
					local startItem = self.tabEvoItem[page][v.cell]
					local endItem   = self.tabEvoItem[page][v2]
					if not endItem then
						if self.tabEvoItem[page+1] then
							endItem = self.tabEvoItem[page+1][v2]
						end
					end
					if startItem and endItem then
						local startPos = ccp(startItem:getPosition())
						local endPos   = ccp(endItem:getPosition())
						local dist = ccpDistance(startPos,endPos)
						local lineSize = CCSizeMake(dist,5)
						local line = TFImage:create("ui/fairy_crystal_details/25.png")
						local isFinish  = HeroDataMgr:getEvolutionIsFinish(v)
						local neighborEvoData = HeroDataMgr:getEvolutionDataById(v.heroId, v.partition, v2)
						local isFinishNeighbor  = false
						if neighborEvoData then
							isFinishNeighbor = HeroDataMgr:getEvolutionIsFinish(neighborEvoData)
						end
						local isFinishBoth = isFinish and isFinishNeighbor
						line:setTexture(isFinishBoth and "ui/fairy_crystal/new_10.png" or "ui/fairy_crystal/new_09.png")
						line:setContentSize(lineSize)
						if isFinishBoth then
							line:setContentSize(CCSizeMake(dist,15))
						end
						line:setAnchorPoint(ccp(0, 0.5))						
						line:setPosition(startPos)

						local angle = HeroDataMgr:getAngleByPos(startPos,endPos)
						line:setRotation(angle)

						self.Panel_lines:addChild(line,0,0)

						self.tabEvoLine[key] = line
						self.tabEvoLine[key2] = line

						lineCount = lineCount + 1
					end
				end
			end
		end
	end
	print("lineCount:========>")
	dump(lineCount)
end

function FairyEvolutionLayer:onHide()
	self.super.onHide(self)
	if not self.notHide then
		self:panelHide(self.Panel_left)
		self:panelHide(self.Panel_right)
	end
end

function FairyEvolutionLayer:removeUI()
	self.super.removeUI(self)
end

function FairyEvolutionLayer:onShow()
	self.super.onShow(self)
	if not self.notHide then
		self:panelShow(self.Panel_left)
		self:panelShow(self.Panel_right)
	end
	--self.notHide = false
	self:timeOut(function()
		self:removeLockLayer()
        GameGuide:checkGuide(self);
    end,0.02)
end

function FairyEvolutionLayer:panelHide(panel)
	if not panel:isVisible() then
		return
	end
	panel:setPositionX(panel:getPositionX() - 20)
	panel:stopAllActions();
	panel:setOpacity(255);


	local actions = {
		CCMoveBy:create(0.2,ccp(20,0));
		CCFadeOut:create(0.2);
	}

	panel:runAction(Spawn:create(actions));

end

function FairyEvolutionLayer:panelShow(panel)
	
	panel:setPositionX(panel:getPositionX() + 20)
	panel:stopAllActions();
	panel:setOpacity(0);


	local actions = {
		CCMoveBy:create(0.2,ccp(-20,0));
		CCFadeIn:create(0.2);
	}

	panel:runAction(Spawn:create(actions));

end



---------------------------guide------------------------------

--引导介绍突破材料
function FairyEvolutionLayer:excuteGuideFunc14001(guideFuncId)
    local targetNode = self.ListView_material:getItem(1)
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

--引导介绍属性加成
function FairyEvolutionLayer:excuteGuideFunc14002(guideFuncId)
    local targetNode = self.Label_evo_desc
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

--引导点击突破按钮
function FairyEvolutionLayer:excuteGuideFunc14003(guideFuncId)
    local targetNode = self.Button_evolution
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

function FairyEvolutionLayer:onItemUpdateEvent()
    self:updateMaterialInfo()
end

return FairyEvolutionLayer;
