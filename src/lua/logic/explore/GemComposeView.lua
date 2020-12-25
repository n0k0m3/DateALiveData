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
* 
]]
local GemComposeView = class("GemComposeView",BaseLayer)

function GemComposeView:ctor( data )
	-- body
	self.super.ctor(self,data)
	self.roomType = ShipRoomType.EXHIBITION
	self.pageIndex = ExploreDataMgr:getPageIndex(self.roomType, "GemComposeView")
	self:initData()
	self:addTopBar()
	self:init("lua.uiconfig.explore.gemComposeView")
end

function GemComposeView:onShow(  )
	-- body
	self.super.onShow(self)
  	GameGuide:checkGuide(self)
end

function GemComposeView.checkStarUpRedPoint( treasureCfg )
	-- body
	return ExploreDataMgr:checkTreasureStarUpRedPoint(treasureCfg)
end

function GemComposeView:initData()
	self.roomData = ExploreDataMgr:getCabinData(self.roomType)
	self.roomCfg, self.roomDetailCfg, self.stageCfg = ExploreDataMgr:getCabinCfg(self.roomType)
	self.showQuality = 0
	self.chooseList = {}
	local showLists = self:getShowTreasureList()
	self.selectTreasureId = self.selectTreasureId or showLists[1].id
end

function GemComposeView:addTopBar()
	self.topBar = requireNew("lua.logic.explore.CommonTopBar"):new(self.roomType, self.pageIndex)
	self:addChild(self.topBar,100)
end

function GemComposeView:getChooseQualityPieceNum( quality )
	-- body
	local chooseList = self.chooseList[quality] or {}
	local num = 0
	for k,v in pairs(chooseList) do
		num = num + v
	end
	return num
end

function GemComposeView:initUI(ui)
	-- body
	self.super.initUI(self,ui)


	self.Image_1 = TFDirector:getChildByPath(ui,"Image_1")
	self.Image_1.initPos = self.Image_1:getPosition()
	self.Panel_left = TFDirector:getChildByPath(ui,"Panel_left")
	self.Panel_left.initPos = self.Panel_left:getPosition()
	self.Label_item_des = TFDirector:getChildByPath(ui,"Label_item_des")
	local ScrollView_desc = TFDirector:getChildByPath(ui,"ScrollView_desc")
	self.UIListView_desc = UIListView:create(ScrollView_desc)
	self.Panel_mid = TFDirector:getChildByPath(ui,"Panel_mid")
	self.Panel_mid.initPos = self.Panel_mid:getPosition()
	self.Panel_right = TFDirector:getChildByPath(ui,"Panel_right")
	self.Panel_right.initPos = self.Panel_right:getPosition()

	self.Label_name = TFDirector:getChildByPath(ui,"Label_name")
	self.Label_des = TFDirector:getChildByPath(ui,"Label_des")
	self.Label_des1 = TFDirector:getChildByPath(ui,"Label_des1")
	self.Label_max = TFDirector:getChildByPath(ui,"Label_max")

	self.Image_quality = TFDirector:getChildByPath(self.Panel_mid,"Image_quality")
	self.Image_icon = TFDirector:getChildByPath(self.Panel_mid,"Image_icon")
	self.Button_compose = TFDirector:getChildByPath(self.Panel_mid,"Button_compose")
	self.Button_starUp = TFDirector:getChildByPath(self.Panel_mid,"Button_starUp")

	self.Panel_star = TFDirector:getChildByPath(ui,"Panel_star")
	self.Button_filter = TFDirector:getChildByPath(ui,"Button_filter")
	self.Panel_filterRoom = TFDirector:getChildByPath(ui,"Panel_filterRoom"):hide()
	self.Label_maxStar = TFDirector:getChildByPath(ui,"Label_maxStar")
	self.Spine_starUp = TFDirector:getChildByPath(ui,"Spine_starUp"):hide()


	self.Panel_costItem = TFDirector:getChildByPath(ui,"Panel_costItem")
	self.Panel_goodItem = TFDirector:getChildByPath(ui,"Panel_goodItem")
	self.Panel_filterItem = TFDirector:getChildByPath(ui,"Panel_filterItem")
	self.Panel_starItem = TFDirector:getChildByPath(ui,"Panel_starItem")

	local ScrollView_cost = TFDirector:getChildByPath(ui,"ScrollView_cost")
	self.uiList_cost = UIListView:create(ScrollView_cost)

	local ScrollView_list = TFDirector:getChildByPath(ui,"ScrollView_list")
	self.gridView_list = UIGridView:create(ScrollView_list)
	self.gridView_list:setItemModel(self.Panel_goodItem)
	self.gridView_list:setColumn(4)
	self:updateFilterList()
	self:refreshView()
	self:showAnim()
end

function GemComposeView:showAnim()
	local panel = self.Panel_value
	self.Image_1:stopAllActions()
    self.Panel_mid:stopAllActions()
    self.Panel_left:stopAllActions()
    self.Panel_right:stopAllActions()
	self.Image_1:setPosition(self.Image_1.initPos)
	self.Panel_mid:setPosition(self.Panel_mid.initPos)
	self.Panel_left:setPosition(self.Panel_left.initPos)
	self.Panel_right:setPosition(self.Panel_right.initPos)
	ViewAnimationHelper.doMoveFadeInAction(self.Image_1, {direction = 4, distance = 10, ease = 2, delay = 0.1, time = 0.2})
    ViewAnimationHelper.doMoveFadeInAction(self.Panel_mid, {direction = 4, distance = 10, ease = 2, delay = 0.15, time = 0.2})
    ViewAnimationHelper.doMoveFadeInAction(self.Panel_left, {direction = 1, distance = 30, ease = 1, delay = 0.2, time = 0.2})
    ViewAnimationHelper.doMoveFadeInAction(self.Panel_right, {direction = 2, distance = 30, ease = 1, delay = 0.25, time = 0.2})

    self.topBar:showAnim()
end

function GemComposeView:registerEvents(ui)
	-- body
	self.super.registerEvents(self,ui)

    EventMgr:addEventListener(self, EV_BAG_EXPLORE_TREATURE_UPDATE, handler(self.refreshView, self))

	self.Button_filter:onClick(function ( ... )
		-- body
		self.Panel_filterRoom:setVisible(not self.Panel_filterRoom:isVisible())
	end)

	self.Button_compose:onClick(function ( ... )
		-- body
		if not self:checkComposeCostEnough() then
    		Utils:showTips(13311257)
    		return
		end
		ExploreDataMgr:SEND_EXPLORE_EXPLORE_TREASURE_COMPOSE(self.selectTreasureId)
	end)

	self.Button_starUp:onClick(function ( ... )
		-- body
		if not self:checkStarUpCostEnough() then
    		Utils:showTips(13311257)
			return
		end

		local costMsg = self:getStarUpCostMsg()
		local _,treasure = next(GoodsDataMgr:getItem(self.selectTreasureId))
		ExploreDataMgr:SEND_EXPLORE_EXPLORE_TREASURE_STAR_UP(treasure.id, costMsg)
		self.chooseList = {}
		self:updateMidPanel()
	end)
end

function GemComposeView:getStarUpCosts( ... )
	-- body
	local curStar = self.treasureData and self.treasureData.star or 0
	local costs = self.treasureCfg.levelCost[curStar] or {}
	return costs
end

function GemComposeView:checkComposeCostEnough( ... )
	local costs = self.treasureCfg.syntheticCost
	for k,v in pairs(costs) do
		if v > GoodsDataMgr:getItemCount(k) then
			return false
		end
	end
	return true
end

function GemComposeView:checkStarUpCostEnough( ... )
	-- body
	local costs = self:getStarUpCosts()

	for i = 1,#costs do
		local c = costs[i]
		if c.type == 1 then
			if c.num > GoodsDataMgr:getItemCount(c.id)	then
				return false
			end
		elseif c.type == 2 then
			if c.num > self:getChooseQualityPieceNum(c.quality) then
				return false
			end
		end
	end
	return true
end

function GemComposeView:getStarUpCostMsg( ... )
	-- body
	local costs = self:getStarUpCosts()
	local costIds = {}
	for i = 1,#costs do
		local c = costs[i]
		if c.type == 1 then
			local _,item = next(GoodsDataMgr:getItem(c.id))
			table.insert(costIds,{1,{{item.id, c.num}}})
		elseif c.type == 2 then
			local cc = self.chooseList[c.quality]
			local qc = {}
			for k,v in pairs(cc) do
				local _,item = next(GoodsDataMgr:getItem(k))
				table.insert(qc,{item.id, v})
			end
			table.insert(costIds,{1,qc})
		end
	end
	return costIds
end

function GemComposeView:refreshView( ... )
	-- body
	self.treasureCfg = TabDataMgr:getData("ExploreTreasure",self.selectTreasureId)
	if GoodsDataMgr:getItem(self.selectTreasureId) then
		local _,treasureData = next(GoodsDataMgr:getItem(self.selectTreasureId))
		if self.treasureData and self.selectTreasureId == self.treasureData.cid then
			if self.treasureData.star < treasureData.star then
				self.isStarUp = true
			end
		end

		if not self.treasureData and self.preSelectTreasureId == self.selectTreasureId then
			self.isCompose = true
		end

		self.treasureData = clone(treasureData)
	else
		self.treasureData = nil
	end

	self:updateLeftPanel()
	self:updateMidPanel()
	self:updateRightPanel()

	if self.isStarUp then
		self:playEffectStarUp()
		self.isStarUp = false
	elseif self.isCompose then
		self:playEffectStarUp()
		self.isCompose = false
	end

	local Image_redTip = TFDirector:getChildByPath(self.Button_compose,"Image_redTip")
	Image_redTip:setVisible(self:checkComposeCostEnough())
	local Image_redTip = TFDirector:getChildByPath(self.Button_starUp,"Image_redTip")
	Image_redTip:setVisible(GemComposeView.checkStarUpRedPoint(self.treasureCfg))


	self.preSelectTreasureId = self.selectTreasureId
end

function GemComposeView:playEffectStarUp( ... )
	-- body
	self:timeOut(function()
		self.Spine_starUp:show()
		self.Spine_starUp:addMEListener( TFARMATURE_COMPLETE,function ( ... )
			-- body
			self.Spine_starUp:removeMEListener(TFARMATURE_COMPLETE)
			self.Spine_starUp:hide()
		end)
		self.Spine_starUp:play("animation",false)
		Utils:playSound(5049)
	end)
end

function GemComposeView:removeEvents( ... )
	-- body
	self.super.removeEvents(self)
end

function GemComposeView:updateRightPanel( ... )
	-- body
	self:updateTreasureList()
end

function GemComposeView:getShowTreasureList( ... )
	-- body
	local allCfgs = TabDataMgr:getData("ExploreTreasure")

	local showLists = {}

	for k,v in pairs(allCfgs) do
		if v.subType == 1 and (self.showQuality == 0 or self.showQuality == v.quality ) then
			table.insert(showLists, v)
		end
	end

	table.sort(showLists, function ( v1,v2 )
		-- body
		local hasItem1 = GoodsDataMgr:getItem(v1.id) and true or false
		local hasItem2 = GoodsDataMgr:getItem(v2.id) and true or false
		if hasItem1 == hasItem2 then
			if v1.quality == v2.quality then
				return v1.id < v2.id
			else
				return v1.quality > v2.quality
			end
		elseif hasItem1 then
			return true
		else
			return false	
		end
	end)
	return showLists
end

function GemComposeView:updateTreasureList( ... )
	-- body
	local showLists = self:getShowTreasureList()
	for k,v in pairs(showLists) do
		local item = self.gridView_list:getItem(k)
		if not item then
			item = self.Panel_goodItem:clone()
			self.gridView_list:pushBackCustomItem(item)
			item.goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
			item.goodsItem:setPosition(ccp(0,0))
			item.goodsItem:setScale(0.9)
			item:setName("item"..v.id)
			item:addChild(item.goodsItem)
		end

		local Image_select = TFDirector:getChildByPath(item,"Image_select")
		local Label_num = TFDirector:getChildByPath(item,"Label_num")
		local Image_flag = TFDirector:getChildByPath(item,"Image_flag")
		local Label_flag = TFDirector:getChildByPath(item,"Label_flag")
		local starUp_redPoint = TFDirector:getChildByPath(item,"Image_redTip")
		Label_flag:setSkewX(15)

		PrefabDataMgr:setInfo(item.goodsItem,v.id)

		Image_select:setVisible(self.selectTreasureId == v.id)

		item.goodsItem:setTouchEnabled(false)
		if GoodsDataMgr:getItem(v.id) then
			item.goodsItem:setOpacity(255)
			Label_num:hide()
		else
			item.goodsItem:setOpacity(120)
			Label_num:show()
		end
		
		starUp_redPoint:setVisible(GemComposeView.checkStarUpRedPoint(v))

		if self.selectTreasureId == v.id and self.isCompose then
			item.goodsItem:setOpacity(120)
			item.goodsItem:runAction(FadeIn:create(1))
		end

		local treasureCfg = GoodsDataMgr:getItemCfg(v.id)
		local composeCosts = treasureCfg.syntheticCost
		local _c,_v = next(composeCosts)
		local count = GoodsDataMgr:getItemCount(_c)
		Label_num:setText(string.format("%d/%d",count,_v))


		Image_flag:setVisible(GoodsDataMgr:getItemCount(v.id) == 0 and count >= _v )
		item:setTouchEnabled(true)
		item:onClick(function ( ... )
			-- body
			if self.selectTreasureId == v.id then return end
			self.chooseList = {}
			self.selectTreasureId = v.id
			self:refreshView()
		end)
	end

end

function GemComposeView:getTreasureQualitys( ... )
	-- body
	local allCfgs = TabDataMgr:getData("ExploreTreasure")

	local qualitys = {}

	for k,v in pairs(allCfgs) do
		if v.subType == 1 then
			qualitys[v.quality] = true
		end
	end
	return table.keys(qualitys)
end

function GemComposeView:updateFilterList( ... )
	-- body
	local filters = self:getTreasureQualitys()
	table.sort( filters, function ( a, b )
		-- body
		return a < b
	end )

	table.insert(filters ,0)
	self.Panel_filterRoom:removeAllChildren()
	for i = #filters,1,-1 do
		local item = self.Panel_filterItem:clone()
		item:setPosition(ccp(0,(i-1)*(item:getContentSize().height+1)))
		self.Panel_filterRoom:addChild(item)
		item:setTouchEnabled(true)
		local Label_filter = TFDirector:getChildByPath(item,"Label_filter")
		Label_filter:setTextById(13311300+filters[i])
		item:onClick(function ( ... )
			-- body
			if self.showQuality == filters[i] then return end
			self.showQuality = filters[i]
			self.gridView_list:removeAllItems()
			self:updateTreasureList()
			self.Panel_filterRoom:hide()
		end)
	end
end

function GemComposeView:updateMidPanel( ... )
	-- body
	local quality = self.treasureCfg.quality or 1
	self.Image_quality:setTexture("ui/explore/growup/exhibition/treasures/quality_"..quality..".png")
	self.Image_icon:setTexture(self.treasureCfg.icon)
	self.hasSelectTreasure = GoodsDataMgr:getItem(self.selectTreasureId)
	self.Button_compose:setVisible(not self.treasureData)
	self:updatePanelCostList()
	local isMaxStar = self.treasureData and self.treasureData.star > #self.treasureCfg.levelCost
	self.Label_maxStar:setVisible(isMaxStar)
	self.Label_max:setVisible(isMaxStar)
	self.Label_des1:setVisible(not isMaxStar)
	self.Button_starUp:setVisible(self.treasureData and not isMaxStar)
end

function GemComposeView:updatePanelCostList( ... )
	-- body
	self.uiList_cost:removeAllItems()
	if not self.hasSelectTreasure then
		local costs = self.treasureCfg.syntheticCost
		for k,v in pairs(costs) do
			local item = self.Panel_costItem:clone()
			local Image_bg = TFDirector:getChildByPath(item,"Image_bg")
			local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
			local Label_num = TFDirector:getChildByPath(item,"Label_num")
			local Label_num1 = TFDirector:getChildByPath(item,"Label_num1")
			local Image_finish = TFDirector:getChildByPath(item,"Image_finish"):hide()
			Image_bg:setTexture("ui/explore/growup/common/quality_di_"..GoodsDataMgr:getItemCfg(tonumber(k)).quality..".png")
			Image_icon:setTexture(GoodsDataMgr:getItemCfg(tonumber(k)).icon)

			local count = GoodsDataMgr:getItemCount(tonumber(k))

			Label_num1:setText(count.."/"..v)
			Label_num:setText(count.."/"..v)

			Label_num1:setVisible(count < v)
			Label_num:setVisible(count >= v)
			self.uiList_cost:pushBackCustomItem(item)

			Image_bg:setTouchEnabled(true)
			Image_bg:onClick(function ( ... )
				-- body
				Utils:showInfo(tonumber(k))
			end)
		end
	else
		local costs = self:getStarUpCosts()
		local ingoreIds = {}
		for k,v in pairs(costs) do
			if v.type == 1 then
				table.insert(ingoreIds,v.id)
			end
		end

		for k,v in pairs(costs) do
			local item = self.Panel_costItem:clone()
			local Image_bg = TFDirector:getChildByPath(item,"Image_bg")
			local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
			local Label_num = TFDirector:getChildByPath(item,"Label_num")
			local Label_num1 = TFDirector:getChildByPath(item,"Label_num1")
			local Image_finish = TFDirector:getChildByPath(item,"Image_finish"):hide()
			if v.type == 1 then
				Image_bg:setTexture("ui/explore/growup/common/quality_di_"..GoodsDataMgr:getItemCfg(tonumber(v.id)).quality..".png")
				Image_icon:setTexture(GoodsDataMgr:getItemCfg(tonumber(v.id)).icon)

				local count = GoodsDataMgr:getItemCount(tonumber(v.id))

				Label_num1:setText(count.."/"..v.num)
				Label_num:setText(count.."/"..v.num)

				Label_num1:setVisible(count < v.num)
				Label_num:setVisible(count >= v.num)
				Image_bg:setTouchEnabled(true)
				Image_bg:onClick(function ( ... )
					-- body
					Utils:showInfo(tonumber(v.id))
				end)
			elseif v.type == 2 then
				Image_bg:setTexture("ui/explore/growup/common/quality_di_"..v.quality..".png")
				Image_finish:setTexture("ui/explore/growup/common/quality_finish_"..v.quality..".png")
				Image_icon:setTexture(v.icon)

				local count = self:getChooseQualityPieceNum(v.quality)

				Label_num1:setText(count.."/"..v.num)
				Label_num:setText(count.."/"..v.num)

				Label_num1:setVisible(count < v.num)
				Label_num:setVisible(count >= v.num)
				Image_bg:setTouchEnabled(true)
				Image_finish:setVisible(count >= v.num)
				Image_icon:setVisible(count < v.num)
				local function callBackFunc( quality ,chooseList )
					-- body
					for k,v in pairs(chooseList) do
						if v == 0 then
							chooseList[k] = nil
						end
					end

					self.chooseList[quality] = chooseList
					self:updatePanelCostList()
				end

				Image_bg:onClick(function ( ... )
					-- body
					Utils:openView("explore.GemPieceChooseTip", v.quality, ingoreIds, v.num, callBackFunc)
				end)
			end

			self.uiList_cost:pushBackCustomItem(item)
		end
	end
	
	self.uiList_cost:setCenterArrange()
end

function GemComposeView:updateLeftPanel( ... )
	-- body
	self.Label_name:setTextById(self.treasureCfg.nameTextId)
	self.treasureCfg.levelCost = self.treasureCfg.levelCost or {}
	local maxStar = #self.treasureCfg.levelCost + 1
	local curStar = 0
	local desTextId = self.treasureCfg.des2[1]
	local desTextId1 = 13311267
	if self.treasureData then
		curStar = self.treasureData.star
		desTextId = self.treasureCfg.des2[curStar + 1] or self.treasureCfg.des2[curStar]
		desTextId1 = self.treasureCfg.des[curStar] or 13311267
	end
	self.Label_des:setTextById(desTextId1)
	self.Label_des1:setTextById(desTextId)

	self.UIListView_desc:removeAllItems()
	local size = self.UIListView_desc:getContentSize()
	local Label_content = self.Label_item_des:clone():Show()
	Label_content:setTextById(self.treasureCfg.desTextId)
	Label_content:setDimensions(size.width, 0)
	self.UIListView_desc:pushBackCustomItem(Label_content)

	self.Panel_star:removeAllChildren()
	for i = 1,maxStar do
		local starItem = self.Panel_starItem:clone()
		starItem:setPosition(ccp(7+(i-1)*30,0))
		self.Panel_star:addChild(starItem)

		local Image_light = TFDirector:getChildByPath(starItem,"Image_light")
		local Image_dark = TFDirector:getChildByPath(starItem,"Image_dark")
		Image_dark:setVisible(i > curStar)

		if self.isStarUp and i == curStar then
			self:timeOut(function()
				self:playStarAni(starItem)
			end)
		else
			Image_light:setVisible(i <= curStar)
		end
	end
end

function GemComposeView:playStarAni(starItem)

	local skeletonNode = SkeletonAnimation:create("effect/TS_texiao/TS_xingxing")
	skeletonNode:play("animation",0)
	skeletonNode:setAnchorPoint(ccp(0,0))
	starItem:addChild(skeletonNode, 1)
	skeletonNode:addMEListener( TFARMATURE_COMPLETE,function ( ... )
		-- body
		skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
		skeletonNode:removeFromParent()
		local Image_light = TFDirector:getChildByPath(starItem,"Image_light")
		Image_light:show()
	end)
end

return GemComposeView