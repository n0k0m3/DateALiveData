local MakeFoodView = class("MakeFoodView", BaseLayer)

function MakeFoodView:ctor()
	self.super.ctor(self)
    self:initData()
    self:init("lua.uiconfig.newCity.makeFoodView")
end

function MakeFoodView:initData()

    self.FoodListItem_ = {}
    self.MaterialsItem_ = {}
    self.ability = {}
	self.menuItem_ = {}
	self.allQuicklyMsg = {}

    self.maxType = 3
    self.maxMaterialsCnt = 5
    self.checkBoxNameId = {252001,252002,252003}
    self.titleNameId = {252000,252004,252007}
    self.cookPregressNameId = {252009,252010,252011}
    self.qteTipTextId = {252013,252014,252015}
    self.lastQteScore = 0

	self.maxCookCnt = 1
	self.clickCookCnt = 1
	self.curMenuId = 1

    self.enumQteType = {}
    self.enumQteType["Circle"] = 1
    self.enumQteType["LongPress"] = 2
    self.enumQteType["QuickClick"] = 3
    self.enumQteType["Max"] = 4
    self.checkBoxRes = {click = "ui/common/edge_select.png",normal = "ui/common/edge_normal.png"}
    self.cookQte = TabDataMgr:getData("CookQte")
    self.lastQteIntegral = 0
    self.data = MakeFoodDataMgr:getFoodBaseInfo()

	self.menuBaseInfo = {}
	self.menuBaseInfo[1] = {sortId = 1,pos = ccp(104,20),rotate = 0,zorder = 3,opciaty = 255}
	self.menuBaseInfo[2] = {sortId = 2,pos = ccp(97,16),rotate = 0,zorder = 2,opciaty = 200}
	self.menuBaseInfo[3] = {sortId = 3,pos = ccp(95,25),rotate = 2,zorder = 1,opciaty = 125}
	self.changeMenuTime = 0.1

    self.lastCookLeftTime = nil
    if self.data then
	    local lastChoosedFoodId = self.data.foodId
		if lastChoosedFoodId == 0 then
			lastChoosedFoodId = 1
		end
		print("lastChoosedFoodId:",lastChoosedFoodId)
		self.foodInfo = MakeFoodDataMgr:getFoodInfoById(lastChoosedFoodId)
		if not self.foodInfo then
			return
		end
		self.choosedFood = self.foodInfo
		self.curMenuId = self.foodInfo.foodType or 1
	    if self.curMenuId > self.maxType then
	    	Box("wrong data")
	    end
	else
		self.curMenuId = 1
	end
end

function MakeFoodView:initUI(ui)

	self.super.initUI(self, ui)

	self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
	self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

	self.Image_qteResult = TFDirector:getChildByPath(self.Panel_prefab,"Image_qteResult")
	self.Panel_foodItemRoot1 = TFDirector:getChildByPath(self.Panel_prefab, "Panel_foodItemRoot1")

	self.Panel_content = TFDirector:getChildByPath(self.Panel_root,"Panel_content")
	self.Panel_makefood = TFDirector:getChildByPath(self.Panel_content,"Panel_makefood")

	self.Panel_cookingPL = TFDirector:getChildByPath(self.Panel_makefood,"Panel_cookingPL")
	self.LoadingBar_bg = TFDirector:getChildByPath(self.Panel_cookingPL,"LoadingBar_bg")

	self.Panel_makefoodAward = TFDirector:getChildByPath(self.Panel_content,"Panel_makefoodAward"):hide()
	self.Spine_title = TFDirector:getChildByPath(self.Panel_makefoodAward,"Spine_title")
	self.AwardBtn = TFDirector:getChildByPath(self.Panel_makefoodAward,"Button_getAward")

	self.Panel_menu = TFDirector:getChildByPath(self.Panel_root,"Panel_menu")
	self.Panel_menuPos = self.Panel_menu:getPosition()
	self.Panel_menuTouch = TFDirector:getChildByPath(self.Panel_root,"Panel_menuTouch")
	self.Panel_menuTouch:setSwallowTouch(false)
	self.menutab_ = {}
	self.GridView_item = {}
	self.controlDot = {}
	for i=1,3 do
		local tab = {}
		tab.pL = TFDirector:getChildByPath(self.Panel_menu,"Image_menu"..i)
		local Label_menuName = TFDirector:getChildByPath(tab.pL,"Label_menuName")
		Label_menuName:setTextById(self.checkBoxNameId[i])
		local ScrollView_item = TFDirector:getChildByPath(tab.pL,"ScrollView_Item")
		local GridView_item = UIGridView:create(ScrollView_item)
		GridView_item:setItemModel(self.Panel_foodItemRoot1)
		GridView_item:setColumn(2)
		GridView_item:setColumnMargin(2)
		GridView_item:setRowMargin(2)
		tab.scrollVie = ScrollView_item
		self.GridView_item[i]= GridView_item
		table.insert(self.menutab_,tab)

		local controlBg = TFDirector:getChildByPath(self.Panel_menu,"Image_control_bg"..i)
		self.controlDot[i] = TFDirector:getChildByPath(controlBg,"Image_control_dot")
	end

	self.Image_new_tip = TFDirector:getChildByPath(self.Panel_menu,"Image_new_tip")
	self.Image_tip_dot = TFDirector:getChildByPath(self.Image_new_tip,"Image_tip_dot")

	--烹饪条件
	self.Panel_Menudetail = TFDirector:getChildByPath(self.Panel_root,"Panel_Menudetail")
	self.Panel_menuDetailPos = self.Panel_Menudetail:getPosition()
	self.cookConditionTx = {}
	for i = 1,2 do
		self.cookConditionTx[i] = TFDirector:getChildByPath(self.Panel_Menudetail, "Label_skill"..i)
	end
	self.Label_menuName = TFDirector:getChildByPath(self.Panel_Menudetail,"Label_menuName")

	self.Image_material_bg1 = TFDirector:getChildByPath(self.Panel_Menudetail,"Image_material_bg1")
	self.Image_material_bg2 = TFDirector:getChildByPath(self.Panel_Menudetail,"Image_material_bg2")
	self.Panel_menuInfo = TFDirector:getChildByPath(self.Panel_Menudetail,"Panel_menuInfo")
	--材料
	self.Panel_makeFoodMaterial = {}
	for i = 1,self.maxMaterialsCnt do
		local materialPL = TFDirector:getChildByPath(self.Panel_Menudetail, "Panel_material_"..i)
		local Image_item = TFDirector:getChildByPath(materialPL, "Image_item")
		local Label_count = TFDirector:getChildByPath(materialPL, "Label_count")
		local Image_tip = TFDirector:getChildByPath(materialPL, "Image_tip")
		self.Panel_makeFoodMaterial[i] = {}
		self.Panel_makeFoodMaterial[i].materialPL = materialPL
		self.Panel_makeFoodMaterial[i].Image_item = Image_item
		self.Panel_makeFoodMaterial[i].Label_count = Label_count
		self.Panel_makeFoodMaterial[i].Image_tip = Image_tip
	end

	self.cookBtn = TFDirector:getChildByPath(self.Panel_Menudetail, "Button_cook")
	self.Label_makefood = TFDirector:getChildByPath(self.cookBtn, "Label_makefood")
	self.cookBtnMore = TFDirector:getChildByPath(self.Panel_Menudetail, "Button_cook_more")
	self.Label_makefood_more = TFDirector:getChildByPath(self.cookBtnMore, "Label_makefood_more")

	self.cookingBar = {}
	self.markTx = {}
	self.markSpine = {}
	self.markDot = {}
	for i = 1,3 do
		self.cookingBar[i] = TFDirector:getChildByPath(self.LoadingBar_bg,"LoadingBar_cookProgress"..i)
		local Image_loadingmark = TFDirector:getChildByPath(self.LoadingBar_bg,"Image_loadingmark"..i)
		self.markTx[i] = Image_loadingmark
		self.markSpine[i]  = {}
		self.markSpine[i].text = TFDirector:getChildByPath(Image_loadingmark,"Spine_text")
		local dotBg = TFDirector:getChildByPath(self.LoadingBar_bg,"Image_dot"..i)
		self.markDot[i] = TFDirector:getChildByPath(dotBg,"Image_liang")
	end
	local cookingTitleBg = TFDirector:getChildByPath(self.Panel_cookingPL,"Image_cookTitle")
	self.Label_foodIcon = TFDirector:getChildByPath(cookingTitleBg,"Image_foodIcon")
	self.Spine_award_di = TFDirector:getChildByPath(cookingTitleBg,"Spine_award_di"):hide()
	self.Spine_award_up = TFDirector:getChildByPath(cookingTitleBg,"Spine_award_up")

	self.Image_timeBarBg = TFDirector:getChildByPath(self.Panel_cookingPL,"Image_timeBarBg")
	self.LoadingBar_timeBar = TFDirector:getChildByPath(self.Image_timeBarBg,"LoadingBar_timeBar")	
	self.Label_makeFoodTime = TFDirector:getChildByPath(self.Image_timeBarBg,"Label_makeFoodTime")

	--qte7
	self.qteView = {}
	self.Panel_qteView = TFDirector:getChildByPath(self.Panel_cookingPL,"Panel_qteView")
	self.Panel_qteView:setVisible(false)
	for qteType=1,self.enumQteType.Max-1 do
		local qte = TFDirector:getChildByPath(self.Panel_qteView,"Button_qteTYpe"..qteType)	
		if qteType == self.enumQteType["LongPress"] then
			self.longPressBar = TFDirector:getChildByPath(qte,"LoadingBar_qteLongPressBar")
			self.longPressBarPosX = self.longPressBar:getPositionX()
		end
		qte:setVisible(false)
		self.qteView[qteType] = qte
	end
	self.Spine_qte = TFDirector:getChildByPath(self.Panel_qteView,"Spine_qte")

	self.Image_hand = TFDirector:getChildByPath(self.Panel_qteView,"Image_hand")
	self.handPos = self.Image_hand:getPosition()
	self.Image_hand:setVisible(false)

	self.Spine_cook = TFDirector:getChildByPath(self.Panel_makefood, "Spine_cook")
	self.animationPos = {}
	self.animationPos.srcPos = self.Spine_cook:getPosition()
	self.animationPos.desPos = ccp(0,self.animationPos.srcPos.y)

	self:initFoodData()
	
end


function MakeFoodView:initFoodData()

	local recordCnt = MakeFoodDataMgr:getRecordCnt()
	self.Image_new_tip:setVisible(recordCnt <= 2)
	if recordCnt <= 2 then
		local act = CCSequence:create({
			CCSpawn:create({
				CCMoveTo:create(1.2,ccp(40,0)),
				CCFadeOut:create(1.2)
			}),
			CCDelayTime:create(0.1),
			CCCallFunc:create(function()
				self.Image_tip_dot:setOpacity(255)
				self.Image_tip_dot:setPositionX(-71)
			end)
		})
		self.Image_tip_dot:runAction(CCRepeatForever:create(act))
		MakeFoodDataMgr:saveRecordCnt()
	end


	self.datingId = MakeFoodDataMgr:getDatingId()
	if self.datingId then
		self:hideTopBar()
		self:initDatingCook(self.datingId)
		self:timeOut(function()
			self:startCookAnimation(1)
		end,0.1)
	else
		self:initNoramlCook()
		self:updateMainView()
	end
end

function MakeFoodView:initDatingCook(datingId)

	self.Panel_menu:setVisible(false)
	self.Panel_Menudetail:setVisible(false)
	self.Panel_cookingPL:setVisible(false)
	self.score = 0
	self.cooking = false
	self.foodList = {}
	local datingFood = MakeFoodDataMgr:getDatingFood(datingId)
	if datingFood then
		self.foodList = datingFood
	end

	if not self.foodList[1] then
		return
	end
	self.ability = self.foodList[1].ability
	self:updateAbility()

	self.MaterialsItem_ = self.foodList[1].materials
	self:refreshMaterials()

	self.choosedFood = self.foodList[1]
end

function MakeFoodView:initFoodMenu()

	for meueType=1,3 do
		local foodList = MakeFoodDataMgr:getFoodlistByType(meueType)
		local gridView = self.GridView_item[meueType]
		for k,v in ipairs(foodList) do
			local item = gridView:getItem(k)
			if not item then
				item = self:addGoodsItem(meueType,v)
			end
			self:updateMenuItem(item,v)
		end
	end

	self:initMenu()
	local gridId = 1
	if self.choosedFood then
		local foodList = MakeFoodDataMgr:getFoodlistByType(self.curMenuId)
		for k,v in ipairs(foodList) do
			if v.id == self.choosedFood.id then
				gridId = k
				break
			end
		end
	end
	self:setCurMenuList(self.curMenuId,gridId)
end

function MakeFoodView:initMenu()

	local nextMenuId = self.curMenuId
	for i=1,3 do
		local zorder = self.menuBaseInfo[i].zorder
		local opciaty = self.menuBaseInfo[i].opciaty
		local rotate = self.menuBaseInfo[i].rotate
		local pos = self.menuBaseInfo[i].pos
		self.menuBaseInfo[nextMenuId].sortId = i
		self.menutab_[nextMenuId].pL:setZOrder(zorder)
		self.menutab_[nextMenuId].pL:setPosition(pos)
		self.menutab_[nextMenuId].pL:setOpacity(opciaty)
		self.menutab_[nextMenuId].pL:setRotation(rotate)
		self.menutab_[nextMenuId].scrollVie:setVisible(self.curMenuId == nextMenuId)
		nextMenuId = nextMenuId + 1
		if nextMenuId > 3 then
			nextMenuId = 1
		end
	end

end


function MakeFoodView:setCurMenuList(meueType,index)

	local foodList = MakeFoodDataMgr:getFoodlistByType(meueType)
	if not foodList then
		return
	end
	local gridView = self.GridView_item[meueType]
	local item = gridView:getItem(index)

	for i=1,3 do
		self.controlDot[i]:setVisible(i == meueType)
	end

	self:selectMenuItem(item,foodList[index])
end

function MakeFoodView:addGoodsItem(meueType,data)
	local item = self.GridView_item[meueType]:pushBackDefaultItem()
	item:setSwallowTouch(true)
	local foo = {}
	foo.root = item
	foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select"):hide()
	foo.Image_newtip = TFDirector:getChildByPath(foo.root, "Image_newtip")
	foo.Image_item = TFDirector:getChildByPath(foo.root, "Image_item")
	local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
	Panel_goodsItem:setTouchEnabled(false)
	Panel_goodsItem:Pos(0, 0)
	Panel_goodsItem:setScale(0.7)
	Panel_goodsItem:AddTo(foo.Image_item)
	foo.Panel_goodsItem = Panel_goodsItem
	foo.data = data
	self.menuItem_[item] = foo
	return item
end

function MakeFoodView:updateMenuItem(item,data)

	local foo = self.menuItem_[item]
	local config = GoodsDataMgr:getItemCfg(data.presentId)
	if config then
		PrefabDataMgr:setInfo(foo.Panel_goodsItem, data.presentId)
	end
	--材料是否充足
	local isEnough = self:setFoodNewDot(data)
	foo.Image_newtip:setVisible(isEnough)
end

function MakeFoodView:selectMenuItem(item,data)
	if self.selectedItem then
		self.selectedItem.Image_select:setVisible(false)
	end

	self.selectedItem = self.menuItem_[item]

	self.selectedItem.Image_select:setVisible(true)

	self.choosedFood = data

	local config = GoodsDataMgr:getItemCfg(data.presentId)
	if config then
		local name = TextDataMgr:getText(config.nameTextId)
		--self.Label_menuName:setText("制作"..name.."的材料需要")
        self.Label_menuName:setTextById(111000097, name)
	end

	self.ability = data.ability
	self:updateAbility()

	self.MaterialsItem_ = data.materials
	self:refreshMaterials()

	self.maxCookCnt = 1
	local makeCnt = self:getMakeFoodTimes()

	self.cookBtnMore:setVisible(makeCnt >= 5)
	if makeCnt >= 5 then
		self.Label_makefood:setTextById(252023,1)
		if makeCnt >= 10 then
			self.Label_makefood_more:setTextById(252023,10)
			self.maxCookCnt = 10
		else
			self.Label_makefood_more:setTextById(252023,5)
			self.maxCookCnt = 5
		end
	else
		self.Label_makefood:setTextById(252025)
		self.maxCookCnt = 1
	end
end

function MakeFoodView:initNoramlCook()

	--上一次烹饪的剩余时间
	self.haveAward = false
	if self.data then
		local foodInfo = MakeFoodDataMgr:getFoodInfoById(self.data.foodId)
		self.endCookTime = self.data.endTime
		self.lastCookLeftTime = self.endCookTime - ServerDataMgr:getServerTime()
		self.cooking = self.lastCookLeftTime > 0 
		self.score = self.data.integral
		self.haveAward = self.lastCookLeftTime <= 0
	else
		self.score = 0
		self.cooking = false
		self.lastCookLeftTime = nil
	end
end

--料理可以烹饪
function MakeFoodView:setFoodNewDot(foodinfo)

	if not foodinfo then
		return false
	end

	local isEnough = MakeFoodDataMgr:isEnoughCook(foodinfo.materials)
	if not isEnough then
		return false
	end

	local isEnoughAbility = MakeFoodDataMgr:isEnoughAbility(foodinfo.ability)
	if not isEnoughAbility then
		return false
	end

	return true
end

function MakeFoodView:updateMainView()

	self.Panel_menu:setVisible(not self.cooking)
	self.Panel_Menudetail:setVisible(not self.cooking)
	self.Panel_cookingPL:setVisible(self.cooking)

	if not self.cooking then
		if self.haveAward then
			self:showAwardPL()
		else
			self.Panel_makefoodAward:setVisible(false)
		end
		self:initFoodMenu()
	else
		self:showCookingPL()
	end
end

--开始调理制作,移动桌子的操作
function MakeFoodView:playCookAnimation()
	self.Spine_cook:play(self:getEffectNameByID(4),false)
	self.Spine_cook:addMEListener(TFARMATURE_COMPLETE,function()
		self:timeOut(function()
			self.Spine_cook:removeMEListener(TFARMATURE_COMPLETE)
	    	self.Spine_cook:play(self:getEffectNameByID(5),true)
	    end, 0)
    end) 
end


--显示材料和能力满足的最大烹饪次数
function MakeFoodView:getMakeFoodTimes()

	local makeCnt = math.huge
	for k,v in ipairs(self.MaterialsItem_) do
		local ownCount = GoodsDataMgr:getItemCount(v[1])
		local needCount = v[2]
		local perCnt = math.floor(ownCount/needCount)
		if makeCnt > perCnt then
			makeCnt = perCnt
		end
	end

	return makeCnt
end

--刷新材料
function MakeFoodView:refreshMaterials()

	local materialCnt = #self.MaterialsItem_
	self.Image_material_bg1:setVisible(materialCnt <= 3)
	self.Image_material_bg2:setVisible(materialCnt > 3)
	local posY = materialCnt > 3 and 0 or -35
	self.Panel_menuInfo:setPositionY(posY)

	for i=1,self.maxMaterialsCnt do
		self.Panel_makeFoodMaterial[i].materialPL:setVisible(i<=materialCnt)
		local itemInfo = self.MaterialsItem_[i]
		if not itemInfo then
			self.Panel_makeFoodMaterial[i].Label_count:setVisible(false)
			self.Panel_makeFoodMaterial[i].Image_item:setVisible(false)
			self.Panel_makeFoodMaterial[i].Image_tip:setVisible(false)
		else
			self.Panel_makeFoodMaterial[i].Image_item:setVisible(true)
			self.Panel_makeFoodMaterial[i].Label_count:setVisible(true)
			local Panel_goodsItem = self.Panel_makeFoodMaterial[i].Image_item:getChildByName("Panel_goodsItem")
			if not Panel_goodsItem then
				Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
				Panel_goodsItem:setTouchEnabled(false)
				Panel_goodsItem:Pos(0, 0)
				Panel_goodsItem:AddTo(self.Panel_makeFoodMaterial[i].Image_item)
			end
			PrefabDataMgr:setInfo(Panel_goodsItem, itemInfo[1])

			local count = GoodsDataMgr:getItemCount(itemInfo[1])
			self.Panel_makeFoodMaterial[i].Image_tip:setVisible(count < itemInfo[2])
			self.Panel_makeFoodMaterial[i].Label_count:setText(count.."/"..itemInfo[2])
		    self.Panel_makeFoodMaterial[i].materialPL:onClick(function()
		    	if not self.datingId then	    	
	            	Utils:showInfo(itemInfo[1], nil, true)
	            end
	        end)
		end
						
	end
end

--烹饪能力需求	
function MakeFoodView:updateAbility()

	for i = 1,2 do
		if not self.ability[i] then
			self.cookConditionTx[i]:setVisible(false)
		else
			self.cookConditionTx[i]:setVisible(true)
			local itemInfo = self.ability[i]
			local count = GoodsDataMgr:getItemCount(itemInfo[1])
			local itemCfg = GoodsDataMgr:getItemCfg(itemInfo[1])
			local name = TextDataMgr:getText(itemCfg.nameTextId)
			if count < itemInfo[2] then
				self.cookConditionTx[i]:setColor(ccc3(220,20,60))
				self.cookConditionTx[i]:enableOutline(ccc4(220,20,60),1)
			else
				self.cookConditionTx[i]:setColor(ccc3(255,255,255))
				self.cookConditionTx[i]:enableOutline(ccc4(255,255,255),2)
			end
			self.cookConditionTx[i]:setText(name.." "..count.."/"..itemInfo[2])
		end
    end

end

--开始cook动画
function MakeFoodView:startCookAnimation(cookCnt)

	if not MakeFoodDataMgr:isEnoughCook(self.MaterialsItem_) then
		Utils:showTips(252017)
		return
	end

	if not MakeFoodDataMgr:isEnoughAbility(self.ability) then
		Utils:showTips(252022)
		return
	end

	self.clickCookCnt = cookCnt or 1
	self.score = 0
	self.lastQteIntegral = 0
	self.Spine_award_di:setVisible(false)
	if self.choosedFood then
		TFDirector:send(c2s.NEW_BUILDING_REQ_COOK_FOODBASE, {self.choosedFood.id,self.clickCookCnt});
	end

end

--显示烹饪界面
function MakeFoodView:showCookingPL()

	if not self.choosedFood then
		return
	end

	--锅的位置
	if self.lastCookLeftTime and self.lastCookLeftTime > 0 then
		self.Spine_cook:setPosition(self.animationPos.desPos)
	end

	--料理名字
	local config = GoodsDataMgr:getItemCfg(self.choosedFood.presentId)
	self.Label_foodIcon:setTexture(config.icon)
	self:resetCookingBar()
	self:updateCookingBar()

	--qte
	self:startTimeDown()

	self.Spine_cook:play(self:getEffectNameByID(4),false)
	self.Spine_cook:addMEListener(TFARMATURE_COMPLETE,function()
		self:timeOut(function()
			self.Spine_cook:removeMEListener(TFARMATURE_COMPLETE)
	    	self.Spine_cook:play(self:getEffectNameByID(5),true)
	    end, 0)
    end) 
end

--结束约会料理
function MakeFoodView:finishDatingCook()

	local datingJump = self.choosedFood.jump
	local jumpInfo = {}
	for k,v in pairs(datingJump) do
		table.insert(jumpInfo,{score = k,datingId = v})
	end
	table.sort(jumpInfo, function(a, b)
       return a.score < b.score
    end)

	local jumpId = jumpInfo[1].score
    for i=#jumpInfo,1,-1 do
    	if self.score >= jumpInfo[i].score then
			jumpId = jumpInfo[i].datingId
			break
		end
    end
    MakeFoodDataMgr:setDatingId(nil)
    EventMgr:dispatchEvent(EV_DATING_EVENT.miniGameCloseInfo, jumpId)
  	AlertManager:close()

end

--奖励界面
function MakeFoodView:showAwardPL()

	local award
	local integralT = self.choosedFood.integral
	dump(integralT)
	for i=#integralT,1,-1 do
		local curIntegralT = integralT[i]
		local score,rewardTab = self:getFoodRewardInfo(curIntegralT)
		if self.score >= score then
			award = rewardTab
			break
		end
	end

	if not award then
		self.haveAward = false
		return
	end
	print("award score:"..self.score)
	self.Panel_makefoodAward:setVisible(true)
	self.Spine_title:play("effect_ui_cook10",false)
	local itemIndex = 0
	for k,v in pairs(award) do
		itemIndex = itemIndex + 1
		local itemCnt = v*self.clickCookCnt
    	local item = self.Panel_makefoodAward:getChildByName("item"..itemIndex)
    	if not item then
    		item = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
	    	PrefabDataMgr:setInfo(item, k,itemCnt)
			item:setName("item"..itemIndex)
			item:setAnchorPoint(me.p(0.5,0.5))
			self.Panel_makefoodAward:addChild(item)
		else
			PrefabDataMgr:set_Panel_goodsItem(item, k,itemCnt)
    	end
	end

	local evenNumber = itemIndex%2
	local leftNumber = math.floor(itemIndex/2)
	local dis = 200
	local firstPosX = 0
	if evenNumber == 0 then
		firstPosX = -dis*(leftNumber-1)-dis/2
	else
		firstPosX = -dis*leftNumber
	end

	for i=1,itemIndex do
		local item = self.Panel_makefoodAward:getChildByName("item"..i)
		if item then
			item:setPosition(ccp(firstPosX+(i-1)*dis,0))
		end
	end
end

function MakeFoodView:getCookAward()

	if not self.choosedFood then
		return
	end
	print("self.choosedFood.id",self.choosedFood.id)
	TFDirector:send(c2s.NEW_BUILDING_REQ_GET_FOOD_BASE_AWARD, {self.choosedFood.id});
end

function MakeFoodView:resetCookingBar()
	self.curBarId = 1
	for i=1,3 do
		self.cookingBar[i]:setPercent(0)
		self.markTx[i]:setVisible(false)
		self.markSpine[i].text:setVisible(false)
		self.markDot[i]:setVisible(false)
	end
end

--设置烹饪进度信息
function MakeFoodView:updateCookingBar()

	self.cookBarMark = {}
	local integralT = self.choosedFood.integral
	local curIntegralT = integralT[self.curBarId]
	if not curIntegralT then
		return
	end

	local score,rewardTab = self:getFoodRewardInfo(curIntegralT)
	if self.curBarId == 1 then
		self.beforeCnt = 0
	end

	local percent = 0
	local curScore = self.score - self.beforeCnt
	curScore = curScore < 0 and 0 or curScore
	local curMaxScore = score - self.beforeCnt
	if curMaxScore > 0 then
		percent = curScore/curMaxScore*100
	end

	self.cookingBar[self.curBarId]:setPercent(percent)
	print("****self.score****",self.score,self.curBarId,curMaxScore,curScore,percent)
	if self.score >= score then
		self.beforeCnt = score
		self.markTx[self.curBarId]:setVisible(true)
		self.markDot[self.curBarId]:setVisible(true)
		self.markSpine[self.curBarId].text:setVisible(true)
		local effect = "effect_Goods_0"
		if self.curBarId == 1 then
			effect = "effect_Goods_0"
		elseif self.curBarId == 2 then
			effect = "effect_Goods_1"
		elseif self.curBarId == 3 then
			effect = "effect_Goods_3"
			self.Spine_award_di:setVisible(true)
			self.Spine_award_di:play("effect_Goods_2_xia",true)
			self.Spine_award_up:play("effect_Goods_2_shang",false)
		end
		self.markSpine[self.curBarId].text:play(effect,false)
		self.curBarId = self.curBarId + 1
	else
		self.markTx[self.curBarId]:setVisible(false)
		self.markDot[self.curBarId]:setVisible(false)
		self.markSpine[self.curBarId].text:setVisible(false)
	end

	if self.score >= self.choosedFood.maxintegral then
		self:timeOut(function()
			self:finishCook()
		end,0.2)
		return
	end
end

function MakeFoodView:startTimeDown()
	
	if self.lastCookLeftTime and self.lastCookLeftTime > 0 then
		local usedTime = self.choosedFood.cooktime - self.lastCookLeftTime
		self.startCookTime = ServerDataMgr:getServerTime() - usedTime
		print("self.lastCookLeftTime",self.lastCookLeftTime)
		self.Label_makeFoodTime:setText(self.lastCookLeftTime)
		local percent = self.lastCookLeftTime/self.choosedFood.cooktime*100
		self.LoadingBar_timeBar:setPercent(percent)
	else
		self.startCookTime = ServerDataMgr:getServerTime()
		self.Label_makeFoodTime:setText(self.choosedFood.cooktime)
		self.LoadingBar_timeBar:setPercent(100)
	end

	self.qteIndex = 1
	if self.lastCookLeftTime and self.lastCookLeftTime > 0 then
		local qtetab = self.choosedFood.qte
		local usedTime = self.choosedFood.cooktime - self.lastCookLeftTime
		local lastQteIndex
		for i=#qtetab,1,-1 do
			local curQteInfo = string.split(qtetab[i], ",")
			local qteId,showTime = tonumber(curQteInfo[1]),tonumber(curQteInfo[2])
			if usedTime >= showTime then
				lastQteIndex = i
				break
			end
		end
		print("lastQteIndex:"..tostring(lastQteIndex))
		if lastQteIndex then
			self.qteIndex = lastQteIndex
		end
	end

	self.Panel_qteView:setVisible(true)
	self:addCountDownTimer()

end

--重置烹饪动画
function MakeFoodView:restCookAnimation()

	self.cooking = false
	self.haveAward = true
	self:updateMainView()

	self.Panel_menu:setOpacity(255)
	self.Panel_menu:setPosition(self.Panel_menuPos)
	self.Panel_Menudetail:setOpacity(255)
	self.Panel_Menudetail:setPosition(self.Panel_menuDetailPos)
	self.Spine_cook:setPosition(self.animationPos.srcPos)

	for qteType=1,self.enumQteType.Max-1 do
		self.qteView[qteType]:setVisible(false)
	end	
end

function MakeFoodView:getFoodRewardInfo(foodRewardInfo)

	local rewardScore,rewardTab
	for k,v in pairs(foodRewardInfo) do
		rewardScore = k
		rewardTab = v
	end

	return rewardScore,rewardTab
end

function MakeFoodView:removeEvents()
    self:removeCountDownTimer()
    self:removeClickTimer()
end

function MakeFoodView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, -1, nil, handler(self.onCountDownPer, self))
    end
end

function MakeFoodView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
        self.countDownTimer_ = nil
    end
end

function MakeFoodView:onCountDownPer()



    if not self.choosedFood or not self.choosedFood.qte then
    	return
    end

    --倒计时
    local leftTime = self.endCookTime-ServerDataMgr:getServerTime()
	leftTime = leftTime < 0 and 0 or leftTime
	local percent =  leftTime/self.choosedFood.cooktime*100
	self.LoadingBar_timeBar:setPercent(percent)
	self.Label_makeFoodTime:setText(leftTime)

	self.curTime = self.choosedFood.cooktime - leftTime
	if self.curTime < 0 then
		self.curTime = 0
	end

	--校验开始计时时的分数
	if self.score == 0 then
		self.score = self.curTime*self.choosedFood.natureTime
	else
		self.score = self.score + self.choosedFood.natureTime
	end
	self:updateCookingBar()
	print("startQTE:",self.score,self.curTime,self.qteIndex)
	self:startQTE(self.qteIndex)	
	print("self.endCookTime:",self.endCookTime,ServerDataMgr:getServerTime())
	if self.endCookTime <= ServerDataMgr:getServerTime() and #self.allQuicklyMsg <=0 then

		--避免后台没有加上update的时间
		if self.score < self.choosedFood.cooktime then
			self.score = self.choosedFood.cooktime
		end
    	self:finishCook()
		return
	end
end


function MakeFoodView:startQTE(qteIndex)

	if not self.choosedFood.qte[qteIndex] then
		self.Panel_qteView:setVisible(false)
		return
	end
	print("1111111111111111111111")
	if not self.curQteCloseTime then
		print("xxxxxxxxxxxxxxxxxx")
		local curQteInfo = string.split(self.choosedFood.qte[qteIndex], ",")

		self.qteId,self.showTime = tonumber(curQteInfo[1]),curQteInfo[2]
		print("self.showTime1:",self.showTime)
		local qteInfo = self.cookQte[self.qteId]
		self.qteType = qteInfo.type or 1
		self.specialeffect = qteInfo.specialeffect
		if self.startCookTime + self.showTime <= ServerDataMgr:getServerTime() then
		
			self.curQteCloseTime = self.startCookTime + self.showTime + qteInfo.time
			if self.qteIndex == 1 then
				self.Image_hand:setVisible(true)
				local seq = Sequence:create({
	                    MoveTo:create(0.2, ccp(self.handPos.x-5, self.handPos.y+5)),
	                    MoveTo:create(0.2, self.handPos),
	            })
            	local action = RepeatForever:create(seq)
            	self.Image_hand:runAction(action)
			end
			self:setQteVisible(self.qteType,true,self.specialeffect)
			self.lastQteScore = 0
			if self.qteType == self.enumQteType["LongPress"] then
				self.longPressBar:setPercent(100)
			end
		end
	end
	print("self.curQteCloseTime:",self.curQteCloseTime,ServerDataMgr:getServerTime())
	if self.curQteCloseTime and self.curQteCloseTime <= ServerDataMgr:getServerTime() and ServerDataMgr:getServerTime() <= self.endCookTime then
		print("22222222222222222222222")
		if self.qteType == self.enumQteType.LongPress then
			self.showLongQte = true
			self:endTouchQte(self.qteType)
		else
			self:setQteVisible(self.qteType,false)
			if self.qteType == self.enumQteType.QuickClick then
				if #self.allQuicklyMsg > 0 then
					for k , v in pairs(self.allQuicklyMsg ) do
						TFDirector:send(c2s.NEW_BUILDING_REQ_UPLOAD_QTE_INTEGRAL, v)
					end
					self.allQuicklyMsg = {}
				end
			end
		end

		if self.Image_hand:isVisible() then		
			self.Image_hand:stopAllActions()
			self.Image_hand:setVisible(false)
		end
		
		self.qteIndex = self.qteIndex + 1
		self.curQteCloseTime = nil
	end
end

function MakeFoodView:setQteVisible(qteType,visible,effectName)

	if visible then
		if qteType == self.enumQteType.Circle then
			self.Spine_qte:setVisible(true)
			if not effectName then
				effectName = "effect_Key_8"
			end
			if effectName and effectName == "" then
				effectName = "effect_Key_8"
			end
			self.Spine_qte:play(effectName,false)
		else
			self.Spine_qte:setVisible(false)
		end	
	else
		self.Spine_qte:setVisible(false)
	end

	--发送服务器消息
	if qteType ~= self.enumQteType.QuickClick then
		if self.qteView[qteType]:isVisible() and (not visible) then
			print("lastQteScore******************:"..self.lastQteScore)
			local msg = {
				self.choosedFood.id,
				self.qteType,
				self.lastQteScore,
			}

			TFDirector:send(c2s.NEW_BUILDING_REQ_UPLOAD_QTE_INTEGRAL, msg);
		end
	end
	self.qteView[qteType]:setVisible(visible)
end

function MakeFoodView:beginTouchQte(qteType)
	if not self.cookQte[qteType] then
		return
	end

	local judgeTab = self.cookQte[qteType].judge
	local pointTab = self.cookQte[qteType].point
	local resTab  = self.cookQte[qteType].showimg

	if self.Image_hand:isVisible() then		
		self.Image_hand:stopAllActions()
		self.Image_hand:setVisible(false)
	end

	if qteType == self.enumQteType.Circle then

		local curIndx
		for k=#judgeTab,1,-1 do
			if self.curTime <= self.showTime + judgeTab[k] then
				curIndx = k
			end
		end
		
		if curIndx and pointTab[curIndx] and resTab[curIndx] then
			self.lastQteScore = self.lastQteScore + pointTab[curIndx]
			self:floateValuateText(resTab[curIndx])
			if self.Spine_qte:isVisible() then	
				self.Spine_qte:setVisible(false)
			end
		end
	elseif qteType == self.enumQteType.LongPress then
		if not self.clickTimer then
			self.showLongQte = true
			local sec = 0
			self.pressTime = 0
			if not self.Spine_qte:isVisible() then	
				self.Spine_qte:setVisible(true)
			end
			self.Spine_qte:play("effect_Key_1",true)
			local function update()
				self.pressTime = self.pressTime + 1
				local percent = 100-self.pressTime/(self.cookQte[qteType].time*60)*100
				if percent < 0 then
					percent = 0
				end
				self.longPressBar:setPercent(percent)
		    end
	        self.clickTimer = TFDirector:addTimer(1, -1, nil, update)
	    end
	elseif qteType == self.enumQteType.QuickClick then
		--self.lastQteScore = self.lastQteScore + pointTab[1]	
		self:floateValuateText(resTab[1])
		if not self.Spine_qte:isVisible() then	
			self.Spine_qte:setVisible(true)
		end
		self.Spine_qte:play("effect_Key_0",false)

		local msg = {
			self.choosedFood.id,
			self.qteType,
			pointTab[1],
		}
		table.insert(self.allQuicklyMsg , msg)
		
	end
end

function MakeFoodView:removeClickTimer()
	if self.clickTimer then
		TFDirector:removeTimer(self.clickTimer)
	    self.clickTimer = nil;
	end
end


--结束长按
function MakeFoodView:endTouchQte(qteType)

	if qteType ~= self.enumQteType.LongPress then 
		if qteType == self.enumQteType.Circle then
			self:setQteVisible(self.enumQteType.Circle,false)
		end
		return
	end

	if not self.showLongQte then
		return
	end

	self.showLongQte = not self.showLongQte

	local judgeTab = self.cookQte[qteType].judge
	local pointTab = self.cookQte[qteType].point
	local resTab  = self.cookQte[qteType].showimg

	if not self.pressTime then
		self.pressTime = 0
	end

	local percent = self.pressTime/(self.cookQte[qteType].time*60)*100
	local curIndx
	for k=#judgeTab,1,-1 do
		if percent <= judgeTab[k] then
			curIndx = k
		end
	end
	if curIndx and pointTab[curIndx] and resTab[curIndx] then
		self.lastQteScore = self.lastQteScore + pointTab[curIndx]
		if self.pressTime > 0 then
			self:floateValuateText(resTab[curIndx])
		else
			self.lastQteScore = 0
		end
	end
	self:setQteVisible(self.enumQteType.LongPress,false)
	self:removeClickTimer()
    self.pressTime = 0
    self.Spine_qte:setVisible(false)
end

--评价飘字
function MakeFoodView:floateValuateText(res)
	
	local Image_qteResult = self.Image_qteResult:clone()
	Image_qteResult:setPosition(ccp(0,50))
	Image_qteResult:setTexture("ui/makefood/"..res..".png")
	self.Panel_qteView:addChild(Image_qteResult)

	local seq = Sequence:create({
            MoveTo:create(0.3, ccp(0, 100)),
            CallFunc:create(function()
            	 Image_qteResult:removeFromParent()
            end),
    })
	Image_qteResult:runAction(seq)
end

function MakeFoodView:finishCook()

	self:removeCountDownTimer()

	self.lastCookLeftTime = nil
	if not self.datingId then
		self.curQteCloseTime = nil
		self.Panel_qteView:setVisible(false) 
	end
	print("ssssssssssssssss")
	--self:playCookingEndAnimate()
	if self.playEndAnimate then
		return
	end
	self.playEndAnimate = true
	--self.Spine_cook:stop()
	self:timeOut(function()
		self.Spine_cook:play(self:getEffectNameByID(6),false)
		self.Spine_cook:addMEListener(TFARMATURE_COMPLETE,function()
			self.playEndAnimate = false
			self.Spine_cook:removeMEListener(TFARMATURE_COMPLETE)
			self.Spine_cook:play(self:getEffectNameByID(2),true)
			if self.datingId then
				self:finishDatingCook()
			else
				self:restCookAnimation()
			end
		end)
	end,0)

end

------------------------消息事件反馈-------------------------------

--料理制作反馈
function MakeFoodView:onRecvCookFood(data)

	self.endCookTime = data.endTime

	local spawn = Spawn:create({
            CCFadeOut:create(0.2),
            MoveBy:create(0.2, ccp(-816, 0)),
    })
    self.Panel_menu:runAction(spawn)
	local spawnAct = Spawn:create({
		CCFadeOut:create(0.2),
		MoveBy:create(0.2, ccp(741, 0)),
	})
	self.Panel_Menudetail:runAction(spawnAct)

    local animationPanelSeq = Sequence:create({
            CCMoveTo:create(0.2,self.animationPos.desPos),
            CallFunc:create(function()
            	self.score = 0
            	self.cooking = true
                self:updateMainView()
                self:playCookAnimation() 
            end)
    })
    self.Spine_cook:runAction(animationPanelSeq)

end

--qte操作之后
function MakeFoodView:onRecvQte(data)
 	
 	if data then
 		--由于服务器发的是历史qte总和，所以需要减去之前的积分
 		--依赖服务器qte是为了防止qte作弊，客户端发送qte只是为了验证
 		self.score = self.score - self.lastQteIntegral
 		self.score = self.score + data.qteIntegral
 		self.lastQteIntegral = data.qteIntegral
		self:updateCookingBar()
	end
end

--领取奖励之后
function MakeFoodView:onRecvGetFoodBaseAward(data)

	if data then
		self.score = 0
		self.lastQteIntegral = 0
		self.haveAward = false
		Utils:showReward(data.rewards)
		self.Panel_makefoodAward:setVisible(false)
	end
end

--注册事件
function MakeFoodView:registerEvents()
	
	EventMgr:addEventListener(self, EV_FUNC_START_COOK, handler(self.onRecvCookFood, self))
	EventMgr:addEventListener(self, EV_FUNC_AFTER_QTE, handler(self.onRecvQte, self))
	EventMgr:addEventListener(self, EV_FUNC_GET_BASE_AWARD, handler(self.onRecvGetFoodBaseAward, self))
	
	self:setBackBtnCallback(function ()
		EventMgr:dispatchEvent(EV_CITY_INFO_CLOSE)
		EventMgr:dispatchEvent(EV_FUNC_NEW_FOOD)
		AlertManager:close()
	end)

	for qteType=1,self.enumQteType.Max-1 do
		self.qteView[qteType]:onTouch(function (event)
			if event.name == "ended" then
                self:endTouchQte(qteType)
            end
            if event.name == "began" then
                self:beginTouchQte(qteType)
            end
		end)	
	end

	self.cookBtn:onClick(function ()
		self:startCookAnimation(1)
	end)

	self.cookBtnMore:onClick(function ()
		self:startCookAnimation(self.maxCookCnt)
	end)

	self.AwardBtn:onClick(function ()
		self:getCookAward()
	end)

	local size = self.Panel_menuTouch:Size()
	local beginPos, endPos = me.p(0, 0), me.p(0, 0)
	self.Panel_menuTouch:onTouch(function(event)
		if event.name == "began" then
			beginPos = event.target:getTouchStartPos()
		elseif event.name == "moved" then

		elseif event.name == "ended" then
			endPos = event.target:getTouchEndPos()
			local offsetX = endPos.x - beginPos.x
			if not self.isTurn and offsetX > size.width * 0.2 then
				self.isTurn = true
				local act = CCSequence:create({
					CCCallFunc:create(function ()
						local nextMenuId = self.curMenuId+1
						if nextMenuId > 3 then
							nextMenuId = 1
						end
						self.menutab_[nextMenuId].scrollVie:setVisible(true)
					end),
					CCSpawn:create({
						CCMoveBy:create(self.changeMenuTime,ccp(30,0)),
						CCFadeTo:create(self.changeMenuTime,120),
						CCRotateBy:create(self.changeMenuTime,7)
					}),
					CCCallFunc:create(function()
						self.menuBaseInfo[self.curMenuId].sortId = 3
						local zorder = self.menuBaseInfo[3].zorder
						self.menutab_[self.curMenuId].pL:setZOrder(zorder)
						for i=1,3 do
							if self.curMenuId ~= i then
								local sortId = self.menuBaseInfo[i].sortId - 1
								sortId = sortId <= 0 and 3 or sortId
								self.menuBaseInfo[i].sortId = sortId
								local zorder = self.menuBaseInfo[sortId].zorder
								local opciaty = self.menuBaseInfo[sortId].opciaty
								local rotate = self.menuBaseInfo[sortId].rotate
								local pos = self.menuBaseInfo[sortId].pos
								self.menutab_[i].pL:setPosition(pos)
								self.menutab_[i].pL:setZOrder(zorder)
								self.menutab_[i].pL:setOpacity(opciaty)
								self.menutab_[i].pL:setRotation(rotate)
							end
						end
					end),
					CCDelayTime:create(0.1),
					CCSpawn:create({
						CCMoveTo:create(self.changeMenuTime,self.menuBaseInfo[3].pos),
						CCFadeTo:create(self.changeMenuTime,self.menuBaseInfo[3].opciaty),
						CCRotateTo:create(self.changeMenuTime,self.menuBaseInfo[3].rotate)
					}),
					CCCallFunc:create(function()
						local lastType = self.curMenuId
						self.menutab_[lastType].scrollVie:setVisible(false)
						self.curMenuId = self.curMenuId + 1;
						if self.curMenuId > 3 then
							self.curMenuId = 1
						end
						self.choosedFood = nil
						self:setCurMenuList(self.curMenuId,1)
						self.Spine_cook:play(self:getEffectNameByID(3, lastType),false)
						self.Spine_cook:addMEListener(TFARMATURE_COMPLETE,function()
							self:timeOut(function()
								self.Spine_cook:removeMEListener(TFARMATURE_COMPLETE)
								self.Spine_cook:play(self:getEffectNameByID(1),false)
								self.isTurn = false
								self.Spine_cook:addMEListener(TFARMATURE_COMPLETE,function()
									self.Spine_cook:removeMEListener(TFARMATURE_COMPLETE)
									self:timeOut(function()
										self.Spine_cook:play(self:getEffectNameByID(2),true)
									end, 0)
								end)
							end, 0)
						end)
					end),
				})
				self.menutab_[self.curMenuId].pL:runAction(act)
			end
		end
	end)

	for k,v in pairs(self.menuItem_) do
		v.root:onClick(function()
			self:selectMenuItem(k,v.data)
		end)
	end
end

function MakeFoodView:getEffectNameByID(id, lastType)
	local realType = lastType or self.curMenuId
	if realType == 1 then
		return "liaoli_"..id
	elseif realType == 2 then
		return "jiweijiu_"..id
	elseif realType == 3 then
		return "pengren_"..id
	end
end

return MakeFoodView