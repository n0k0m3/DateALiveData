local ManualMakeView = class("ManualMakeView", BaseLayer)

local MATH_MAX = math.max
local MATH_MIN = math.min
--手工制作
function ManualMakeView:ctor(params)
	self.super.ctor(self)
    self:initData(params)
    self:init("lua.uiconfig.newCity.manualMakeView")
end

function ManualMakeView:initData(params)
    self.MaterialsItem_ = {}
    self.ability = {}
    self.datingId_ = params.id

    self.maxMaterialsCnt = 6
    self.checkBoxNameId = {262000,262001,262002}
    self.titleNameId = {262017,262003,262006}
    self.progressNameId = {262008}
    self.gravitySpeed = tonumber(TextDataMgr:getText(262100)) or 30
    local speedLimit = string.gsub(TextDataMgr:getText(262101), "[[]", "")
    speedLimit = string.gsub(speedLimit, "[]]", "")
    local speedVec = string.split(speedLimit, ",")
    self.maxSpeed = tonumber(speedVec[1] or 30)
    self.minSpeed = tonumber(speedVec[2] or 5)

    self.manualBarMarkImg = {}
    self.manualBarMarkImg[1] = {normal = "ui/newCity/manual/ui_017.png",gray = "ui/newCity/manual/ui_016.png"}		--good
    self.manualBarMarkImg[2] = {normal = "ui/newCity/manual/ui_019.png",gray = "ui/newCity/manual/ui_018.png"}		--nice
    self.manualBarMarkImg[3] = {normal = "ui/newCity/manual/ui_021.png",gray = "ui/newCity/manual/ui_020.png"}		--perfect
    self.checkBoxRes = {click = "ui/common/edge_select.png",normal = "ui/common/edge_normal.png"}

	self.spine_textRes = {"effect_Goods_0","effect_Goods_1","effect_Goods_3"}

	self.menuBaseInfo = {}
	self.menuBaseInfo[1] = {sortId = 1,pos = ccp(104,20),rotate = 0,zorder = 3,opciaty = 255}
	self.menuBaseInfo[2] = {sortId = 2,pos = ccp(97,16),rotate = 0,zorder = 2,opciaty = 200}
	self.menuBaseInfo[3] = {sortId = 3,pos = ccp(95,25),rotate = 2,zorder = 1,opciaty = 125}
	self.changeMenuTime = 0.1

	self.maxMakeCnt = 1
	self.clickMakeCnt = 1

	self.menuItem_ = {}

	self.startDeltaLen = 39

    self.haveAward = false
	self.manualMakingInfo = ManualMakeDataMgr:getManualMakingInfo()
	if self.manualMakingInfo then
		local manualInfo = ManualMakeDataMgr:getManualInfoById(self.manualMakingInfo.manualId)
		self.endTime = self.manualMakingInfo.endTime
		self.leftTime = self.endTime - ServerDataMgr:getServerTime()
		self.making = self.leftTime > 0 
		self.score = self.manualMakingInfo.integral
		self.haveAward = self.leftTime <= 0
		self.choosedManual = manualInfo
		self.manualType = self.choosedManual.handworkType
		self.lastManualType = self.manualType
	else
		self.score = 0
		self.making = false
		self.endTime = 0
		self.leftTime = 0
		self.haveAward = false

		self.manualType = 1
		self.lastManualType = self.manualType
	end
	self.addScore = 0
	if self.datingId_ then
		TFDirector:send(c2s.NEW_BUILDING_REQ_GET_HAND_WORK_INFO, {false})
	else
		TFDirector:send(c2s.NEW_BUILDING_REQ_GET_HAND_WORK_INFO, {true})
	end
end

function ManualMakeView:initUI(ui)

	self.super.initUI(self, ui)
	if self.datingId_ then
		self.topLayer:setVisible(false)
	end

	self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
	self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

	self.Panel_manualItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_manualItem")
	self.Panel_material_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_material_item")
	self.Panel_content = TFDirector:getChildByPath(self.Panel_root,"Panel_content")
	self.Panel_manual = TFDirector:getChildByPath(self.Panel_content,"Panel_manual")


	self.Panel_making = TFDirector:getChildByPath(self.Panel_manual,"Panel_making")
	self.LoadingBar_bg = TFDirector:getChildByPath(self.Panel_making,"LoadingBar_bg")

	self.Panel_makeAward = TFDirector:getChildByPath(self.Panel_content,"Panel_makeAward")
	self.AwardBtn = TFDirector:getChildByPath(self.Panel_makeAward,"Button_getAward")
	self.Panel_rewards = TFDirector:getChildByPath(self.Panel_makeAward,"Panel_rewards")
	self.Panel_makeAward:setVisible(false)
	self.Panel_makeAward:setTouchEnabled(false)

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
		GridView_item:setItemModel(self.Panel_manualItem)
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

	self.makingBar = {}
	self.Image_loadingmark = {}
	self.markDot = {}
	self.markMarkBg = {}
	self.Spine_text = {}
	for i = 1,3 do
		self.makingBar[i] = TFDirector:getChildByPath(self.LoadingBar_bg,"LoadingBar_makeProgress"..i)
		local Image_loadingmark = TFDirector:getChildByPath(self.LoadingBar_bg,"Image_loadingmark"..i)
		self.markMarkBg[i] = Image_loadingmark
		local dotBg = TFDirector:getChildByPath(self.LoadingBar_bg,"Image_dot"..i)
		self.markDot[i] = TFDirector:getChildByPath(dotBg,"Image_liang")
		self.Spine_text[i] = {}
		self.Spine_text[i].spine = TFDirector:getChildByPath(Image_loadingmark,"Spine_text")
		self.Spine_text[i].isPlay = false
	end

	local Image_makingTitle = TFDirector:getChildByPath(self.Panel_making,"Image_makingTitle")
	self.Image_manualIcon = TFDirector:getChildByPath(Image_makingTitle,"Image_manualIcon")
	self.Spine_award_di = TFDirector:getChildByPath(Image_makingTitle,"Spine_award_di"):hide()
	self.Spine_award_up = TFDirector:getChildByPath(Image_makingTitle,"Spine_award_up")

	self.Image_timeBarBg = TFDirector:getChildByPath(self.Panel_making,"Image_timeBarBg")
	self.LoadingBar_timeBar = TFDirector:getChildByPath(self.Image_timeBarBg,"LoadingBar_timeBar")	
	self.Label_makingTime = TFDirector:getChildByPath(self.Image_timeBarBg,"Label_makingTime")

	self.Panel_controlView = TFDirector:getChildByPath(self.Panel_making,"Panel_controlView")
	self.Panel_controlView:setVisible(false)
	self.Panel_control_info = TFDirector:getChildByPath(self.Panel_controlView,"Panel_control_info")
	self.Button_zhuanzhu = TFDirector:getChildByPath(self.Panel_controlView,"Button_zhuanzhu")
	self.Image_circle = TFDirector:getChildByPath(self.Button_zhuanzhu,"Image_circle")

	self.Label_controlTip = TFDirector:getChildByPath(self.Panel_controlView,"Label_controlTip")
	self.Image_info_shears = TFDirector:getChildByPath(self.Panel_controlView,"Image_info_shears")
	self.Image_info_flag = TFDirector:getChildByPath(self.Panel_controlView,"Image_info_flag")
	self.Image_info_flag:setPositionY(self.startDeltaLen)
	self.Spine_partical = TFDirector:getChildByPath(self.Panel_controlView,"Spine_partical")
	self.Image_icon_shears = TFDirector:getChildByPath(self.Panel_controlView,"Image_icon_shears")

	--条件
	self.Panel_Menudetail = TFDirector:getChildByPath(self.Panel_root,"Panel_Menudetail")
	self.Panel_menuDetailPos = self.Panel_Menudetail:getPosition()
	self.conditionTx = {}
	for i = 1,2 do
		self.conditionTx[i] = TFDirector:getChildByPath(self.Panel_Menudetail, "Label_skill"..i)
	end
	self.Label_menuName = TFDirector:getChildByPath(self.Panel_Menudetail,"Label_menuName")

	self.Image_material_bg1 = TFDirector:getChildByPath(self.Panel_Menudetail,"Image_material_bg1")
	self.Image_material_bg2 = TFDirector:getChildByPath(self.Panel_Menudetail,"Image_material_bg2")
	self.Panel_menuInfo = TFDirector:getChildByPath(self.Panel_Menudetail,"Panel_menuInfo")

	--材料
	self.Panel_manualMaterial = {}
	for i = 1,self.maxMaterialsCnt do
		local materialPL = TFDirector:getChildByPath(self.Panel_Menudetail, "Panel_material_"..i)
		local Image_item = TFDirector:getChildByPath(materialPL, "Image_item")
		local Label_count = TFDirector:getChildByPath(materialPL, "Label_count")
		local Image_tip = TFDirector:getChildByPath(materialPL, "Image_tip")
		self.Panel_manualMaterial[i] = {}
		self.Panel_manualMaterial[i].materialPL = materialPL
		self.Panel_manualMaterial[i].Image_item = Image_item
		self.Panel_manualMaterial[i].Label_count = Label_count
		self.Panel_manualMaterial[i].Image_tip = Image_tip
	end

	self.Button_make = TFDirector:getChildByPath(self.Panel_Menudetail, "Button_make")
	self.Label_makeManual = TFDirector:getChildByPath(self.Button_make, "Label_makefood")
	self.Label_makeManual:setTextById(262007)
	self.Button_make_more = TFDirector:getChildByPath(self.Panel_Menudetail, "Button_make_more")
	self.Label_makeManual_more = TFDirector:getChildByPath(self.Button_make_more, "Label_makefood_more")
	self.Label_makeManual_more:setTextById(262007)

	-------------------------------------------------------------------------------------------

	self.Panel_Animation = TFDirector:getChildByPath(self.Panel_manual, "Panel_Animation")
	-- self.Spine_manualMake = TFDirector:getChildByPath(self.Panel_manual, "Spine_manualMake")
	-- self.Spine_manualMake:removeFromParent()
	self.Spine_manualMake = SkeletonAnimation:create("effect/xiaoyouxi/shizhi")
	self.Spine_manualMake:setScale(0.9)
	self.Panel_Animation:addChild(self.Spine_manualMake, 5)
	self.Spine_manualMake:play(self:getEffectNameByID(2),true)

	self.animationPos = {}
	self.animationPos.srcPos = self.Panel_Animation:getPosition()
	self.animationPos.desPos = ccp(0,self.animationPos.srcPos.y)


	self.shearsHeight = 55
	self.flagHeight = self.Image_info_flag:getSize().height
	self.maxHeight = 275

	local recordCnt = ManualMakeDataMgr:getRecordCnt()
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
		ManualMakeDataMgr:saveRecordCnt()
	end

	self:updateMainView()
end

--更新积分变动
function ManualMakeView:sendAddScore()
	if self.making then 
		ManualMakeDataMgr:updateManualMakingScore(self.score + self.addScore)
		self:updateMakingScore()
	end
end

--注册事件
function ManualMakeView:registerEvents()
	EventMgr:addEventListener(self, EV_FUNC_MANUAL_MAKING_INFO, handler(self.onRecvGetManualInfo, self))
	EventMgr:addEventListener(self, EV_FUNC_START_MAKE_MANUAL, handler(self.onRecvMakeManual, self))
	EventMgr:addEventListener(self, EV_FUNC_UPDATE_MANUAL_SCORE, handler(self.onRecvUpdateScore, self))
	EventMgr:addEventListener(self, EV_FUNC_GET_MANUAL_REWARD, handler(self.onRecvGetManualAward, self))

	self:setBackBtnCallback(function ()
		self:sendAddScore()
		AlertManager:close()
		EventMgr:dispatchEvent(EV_FUNC_MANUAL_RED_POINT)
	end)

	self:setMainBtnCallback(function()
        self:sendAddScore()
    	AlertManager:changeScene(SceneType.MainScene)
    end)

	self.Button_zhuanzhu:onTouch(function (event)
		if event.name == "began" then
            self:beginTouchBtn()
        end
		if event.name == "ended" then
            self:endTouchBtn()
        end
	end)

	self.Button_make:onClick(function ()
		self:startMakeManual(1)
	end)

	self.Button_make_more:onClick(function ()
		self:startMakeManual(self.maxMakeCnt)
	end)

	self.AwardBtn:onClick(function ()
		self:getManualAward()
	end)


	for k,v in pairs(self.menuItem_) do
		v.root:onClick(function()
			self:selectMenuItem(k,v.data)
		end)
	end

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
						local nextMenuId = self.manualType+1
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
						self.menuBaseInfo[self.manualType].sortId = 3
						local zorder = self.menuBaseInfo[3].zorder
						self.menutab_[self.manualType].pL:setZOrder(zorder)
						for i=1,3 do
							if self.manualType ~= i then
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
						local lastType = self.manualType
						self.menutab_[lastType].scrollVie:setVisible(false)
						self.manualType = self.manualType + 1;
						if self.manualType > 3 then
							self.manualType = 1
						end
						self.choosedFood = nil
						self:setCurMenuList(self.manualType,1)
						self.Spine_manualMake:play(self:getEffectNameByID(3, lastType),false)
						self.Spine_manualMake:addMEListener(TFARMATURE_COMPLETE,function()
							self:timeOut(function()
								self.Spine_manualMake:removeMEListener(TFARMATURE_COMPLETE)
								self.Spine_manualMake:play(self:getEffectNameByID(1),false)
								self.isTurn = false
								self.Spine_manualMake:addMEListener(TFARMATURE_COMPLETE,function()
									self.Spine_manualMake:removeMEListener(TFARMATURE_COMPLETE)
									self:timeOut(function()
										self.Spine_manualMake:play(self:getEffectNameByID(2),true)
									end, 0)
								end)
							end, 0)
						end)
					end),
				})
				self.menutab_[self.manualType].pL:runAction(act)
			end
		end
	end)
end


function ManualMakeView:updateMainView()

	self.Panel_menu:setVisible(not self.making)
	self.Panel_Menudetail:setVisible(not self.making)
	self.Panel_making:setVisible(self.making)
	if not self.making then
		if self.haveAward then
			self:showAwardPL()
		else
			self.Panel_makeAward:setVisible(false)
			self.Panel_makeAward:setTouchEnabled(false)
		end
		self:initHandWorkMenu()
	else
		self:showMakingPanel()
	end
end

function ManualMakeView:initHandWorkMenu()

	for meueType=1,3 do
		local manualList = ManualMakeDataMgr:getManualListByType(meueType)
		local gridView = self.GridView_item[meueType]
		for k,v in ipairs(manualList) do
			local item = gridView:getItem(k)
			if not item then
				item = self:addGoodsItem(meueType,v)
			end
			self:updateMenuItem(item,v)
		end
	end

	self:initMenu()
	local gridId = 1
	if self.choosedManual then
		local manualList = ManualMakeDataMgr:getManualListByType(self.manualType)
		for k,v in ipairs(manualList) do
			if v.id == self.choosedManual.id then
				gridId = k
				break
			end
		end
	end
	self:setCurMenuList(self.manualType,gridId)
end

function ManualMakeView:initMenu()

	local nextMenuId = self.manualType
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
		self.menutab_[nextMenuId].scrollVie:setVisible(self.manualType == nextMenuId)
		nextMenuId = nextMenuId + 1
		if nextMenuId > 3 then
			nextMenuId = 1
		end
	end

end


function ManualMakeView:setCurMenuList(meueType,index)

	local foodList = ManualMakeDataMgr:getManualListByType(meueType)
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

function ManualMakeView:addGoodsItem(meueType,data)
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

function ManualMakeView:updateMenuItem(item,data)

	local foo = self.menuItem_[item]
	local config = GoodsDataMgr:getItemCfg(data.presentId)
	if config then
		PrefabDataMgr:setInfo(foo.Panel_goodsItem, data.presentId)
	end
	--材料是否充足
	local isEnough = ManualMakeDataMgr:checkRedPointByCfg(data)
	foo.Image_newtip:setVisible(isEnough)
end

function ManualMakeView:selectMenuItem(item,data)
	if self.selectedItem then
		self.selectedItem.Image_select:setVisible(false)
	end

	self.selectedItem = self.menuItem_[item]

	self.selectedItem.Image_select:setVisible(true)

	self.choosedManual = data

	local config = GoodsDataMgr:getItemCfg(data.presentId)
	if config then
		local name = TextDataMgr:getText(config.nameTextId)
		--self.Label_menuName:setText("制作"..name.."的材料需要")
        self.Label_menuName:setTextById(111000097, name)
	end

	self.ability = data.ability
	self.MaterialsItem_ = data.materials
	self:refreshMaterials()

	self.maxCookCnt = 1
	local makeCnt = self:getMaxMakeTimes()

	--self.cookBtnMore:setVisible(makeCnt >= 5)
	--if makeCnt >= 5 then
	--	self.Label_makefood:setTextById(252023,1)
	--	if makeCnt >= 10 then
	--		self.Label_makefood_more:setTextById(252023,10)
	--		self.maxCookCnt = 10
	--	else
	--		self.Label_makefood_more:setTextById(252023,5)
	--		self.maxCookCnt = 5
	--	end
	--else
	--	self.Label_makefood:setTextById(252025)
	--	self.maxCookCnt = 1
	--end
end

function ManualMakeView:refreshTabRedPoint()
	for listType, box in ipairs(self.checkBox) do
		local btn = box.btn
		local redPoint = TFDirector:getChildByPath(btn,"Image_tab_red")
		local flag = ManualMakeDataMgr:checkRedPointByType(listType)
		redPoint:setVisible(flag)
	end
end

function ManualMakeView:refreshItemRedPoint()
	self.manualList = ManualMakeDataMgr:getManualListByType(self.manualType, self.datingId_)
	for i,v in ipairs(manualList) do
		local item = self.ListView_Manuallist:getItem(i)
		if item then
			local redPoint = TFDirector:getChildByPath(item,"Image_item_red")
			local flag = ManualMakeDataMgr:checkRedPointByCfg(v)
			redPoint:setVisible(flag)
		end
	end
end

function ManualMakeView:refreshMaterials()

	local materialCnt = #self.MaterialsItem_
	self.Image_material_bg1:setVisible(materialCnt <= 3)
	self.Image_material_bg2:setVisible(materialCnt > 3)
	local posY = materialCnt > 3 and 0 or -35
	self.Panel_menuInfo:setPositionY(posY)

	for i=1,self.maxMaterialsCnt do
		self.Panel_manualMaterial[i].materialPL:setVisible(i<=materialCnt)
		local itemInfo = self.MaterialsItem_[i]
		if not itemInfo then
			self.Panel_manualMaterial[i].Label_count:setVisible(false)
			self.Panel_manualMaterial[i].Image_item:setVisible(false)
			self.Panel_manualMaterial[i].Image_tip:setVisible(false)
		else
			self.Panel_manualMaterial[i].Image_item:setVisible(true)
			self.Panel_manualMaterial[i].Label_count:setVisible(true)
			local Panel_goodsItem = self.Panel_manualMaterial[i].Image_item:getChildByName("Panel_goodsItem")
			if not Panel_goodsItem then
				Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
				Panel_goodsItem:setTouchEnabled(false)
				Panel_goodsItem:Pos(0, 0)
				Panel_goodsItem:AddTo(self.Panel_manualMaterial[i].Image_item)
			end
			PrefabDataMgr:setInfo(Panel_goodsItem, itemInfo[1])

			local count = GoodsDataMgr:getItemCount(itemInfo[1])
			self.Panel_manualMaterial[i].Image_tip:setVisible(count < itemInfo[2])
			self.Panel_manualMaterial[i].Label_count:setText(count.."/"..itemInfo[2])
			self.Panel_manualMaterial[i].materialPL:onClick(function()
				if not self.datingId then
					Utils:showInfo(itemInfo[1], nil, true)
				end
			end)
		end

	end

	--消耗
	for i = 1,2 do
		if not self.ability[i] then
			self.conditionTx[i]:setVisible(false)
		else
			self.conditionTx[i]:setVisible(true)
			local itemInfo = self.ability[i]
			local count = GoodsDataMgr:getItemCount(itemInfo[1])
			local itemCfg = GoodsDataMgr:getItemCfg(itemInfo[1])
			local name = TextDataMgr:getText(itemCfg.nameTextId)
			if count < itemInfo[2] then
				self.conditionTx[i]:setColor(ccc3(220,20,60))
				self.conditionTx[i]:enableOutline(ccc4(220,20,60),1)
			else
				self.conditionTx[i]:setColor(ccc3(255,255,255))
				self.conditionTx[i]:enableOutline(ccc4(255,255,255),2)
			end
			self.conditionTx[i]:setText(name.." "..count.."/"..itemInfo[2])
		end
	end

	self:showMakeBtn()
end

function ManualMakeView:showMakeBtn()

	self.maxMakeCnt = 1
	local makeCnt = self:getMaxMakeTimes()
	self.Button_make_more:setVisible(makeCnt >= 5)
	if makeCnt >= 5 then
		self.Label_makeManual:setTextById(252024,1)
		if makeCnt >= 10 then
			self.Label_makeManual_more:setTextById(252024,10)
			self.maxMakeCnt = 10
		else
			self.Label_makeManual_more:setTextById(252024,5)
			self.maxMakeCnt = 5
		end
	else
		self.Label_makeManual:setTextById(262007)
		self.maxMakeCnt = 1
	end

end

--显示材料和能力满足的最大制作次数
function ManualMakeView:getMaxMakeTimes()
	dump(self.MaterialsItem_)
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

function ManualMakeView:isShortMaterial()
	local enoughCnt = 0
	for k,v in pairs(self.MaterialsItem_ ) do
		local count = GoodsDataMgr:getItemCount(v[1])
		if count < v[2] then
			return true
		end
	end

	return false
end

function ManualMakeView:isEnoughAbility()
	local enoughCnt = 0
	for k,v in pairs(self.ability) do
		local count = GoodsDataMgr:getItemCount(v[1])
		if count < v[2] then
			return false
		end
	end

	return true
end

function ManualMakeView:startMakeManual(cnt)
	if self:isShortMaterial() then
		Utils:showTips(262013)
		return
	end

	if not self:isEnoughAbility() then
		Utils:showTips(252022)
		return
	end

	self.clickMakeCnt = cnt or 1

	if self.choosedManual then
		ManualMakeDataMgr:sendReqMakeManual(self.choosedManual.id,self.clickMakeCnt)
	end
end

--显示制作界面
function ManualMakeView:showMakingPanel()
	if not self.choosedManual then
		return
	end
	self.controlStartTime = ServerDataMgr:getServerTime()
	local integral = self.choosedManual.integral
	local scoreValue = {}
	for i,info in ipairs(integral) do
		for score, rewards in pairs(info) do
			scoreValue[#scoreValue + 1] = score
		end
	end
	table.sort(scoreValue, function(a, b)
		return a < b
	end)
	-- local unitPoint = self.LoadingBar_bg:getSize().width / scoreValue[#scoreValue]
	-- for i,v in ipairs(scoreValue) do
	-- 	self.Image_loadingmark[i]:setPositionX(tonumber(v) * unitPoint)
	-- end
	--self.Image_info_flag:setSize(me.size(52,self.choosedManual.zonesize))
	self.Image_info_flag:setSize(me.size(52,55))
	self.flagHeight = self.Image_info_flag:getSize().height
	self.Image_info_flag:setPositionY(self.startDeltaLen)
	if not self.choosedManual then
		return
	end
	self.leftTime = self.endTime - ServerDataMgr:getServerTime()
	if self.leftTime and self.leftTime > 0 then
		self.Panel_Animation:setPosition(self.animationPos.desPos)
	end

	local config = GoodsDataMgr:getItemCfg(self.choosedManual.presentId)
	self.Image_manualIcon:setTexture(config.icon)

	for i=1,3 do
		self.Spine_text[i].isPlay = false
	end
	self.Spine_award_di:setVisible(false)
	self:onCountDownPer()
	self:updateMakingBar()
	self:startTimeDown()
	self:startScheduleUpdate()
	self.Spine_manualMake:play(self:getEffectNameByID(4),false)
	self.Spine_manualMake:addMEListener(TFARMATURE_COMPLETE,function()
		self:timeOut(function()
			self.Spine_manualMake:removeMEListener(TFARMATURE_COMPLETE)
	    	self.Spine_manualMake:play(self:getEffectNameByID(5),true)
	    end, 0)
    end) 
end

function ManualMakeView:startScheduleUpdate()
	local excursion = self.choosedManual.excursion
	local den = 1
	for k,v in pairs(excursion) do
		den = den + v[2]
	end
	self.probArray = {}
	for k,v in pairs(excursion) do
		self.probArray[#self.probArray + 1] = {v[1], v[2] / den * 100}
	end
	table.sort(self.probArray, function(a,b)
		return a[2] > b[2]
	end)
	self.excursion = 66
	self.excursiontime = MATH_MAX(self.choosedManual.excursiontime / 1000, 0.05)
	self.dropSpeed = self.choosedManual.dropspeed
	self.upcastSpeed = self.choosedManual.upcastspeed
	self.flagSpeed = 0
	self.flagDiretion = 2
	self.flagStartPosy = self.Image_info_flag:getPositionY()

    self.dropTime = 0
    self.touchTime = 0
	self.waitTime = self.excursiontime

	if not self.scheduleID then
		self.scheduleID = TFDirector:addTimer(0, -1, nil, handler(self.scheduleUpdate, self))
	end

end

function ManualMakeView:stopScheduleUpdate()
	if self.scheduleID then
		TFDirector:removeTimer(self.scheduleID)
		self.scheduleID = nil
	end
end

function ManualMakeView:scheduleUpdate(dt)
    if not self.choosedManual or self:checkeGameOverOrNot() then
		self:stopScheduleUpdate()
    	return
    end

    --剪刀移动
    self.waitTime = self.waitTime + dt
    if self.shearsMoving then
    	local posy = self.Image_info_shears:getPositionY()
    	if self.shearsDirection == 1 then
    		if posy >= (self.maxHeight - self.shearsHeight) then
    			self.shearsMoving = false
    		else
    			local movHeight = self.shearsSpeed * self.waitTime
    			--(self.shearsSpeed * self.waitTime) - (0.5 * self.gravitySpeed * self.waitTime * self.waitTime)
    			if movHeight < 0 or movHeight >= self.excursion then
    				self.shearsMoving = false
    			else
    				self.Image_info_shears:setPositionY(self.shearsStartPosY + movHeight)
    			end
    		end
    	else
    		if posy <= self.shearsHeight then
    			self.shearsMoving = false
    		else
    			local movHeight = self.shearsSpeed * self.waitTime
    			--0.5 * self.gravitySpeed * self.waitTime * self.waitTime
    			if movHeight < 0 or movHeight >= self.excursion then
    				self.shearsMoving = false
    			else
					local posY = self.shearsStartPosY - movHeight
					posY = posY < 66 and 66 or self.shearsStartPosY - movHeight
    				self.Image_info_shears:setPositionY(posY)
    			end
    		end
    	end
    end
    if self.waitTime > self.excursiontime then
    	self.waitTime = 0
    	self.shearsStartPosY = self.Image_info_shears:getPositionY()
    	self.shearsDirection = self:getShearsDirection()
    	local randomNum = math.random(100)
    	for i,v in ipairs(self.probArray) do
    		if randomNum >= v[1] then
    			self.excursion = v[1]
    			break
    		end
    	end
    	self.shearsSpeed = self.excursion / self.excursiontime
    	self.shearsMoving = true
    end

 	--标记区域移动
    if self.btnTouching then
    	self.lastTouchingTime = self.touchTime
    	if self.flagDiretion == 2 then
    		self.flagDiretion = 1
    	end
    	if self.touchTime % 10 == 0 then
    		self.flagSpeed = MATH_MIN(self.flagSpeed + self.upcastSpeed, self.maxSpeed)
	    	self.upTime = 0
	    	self.flagStartPosy = self.Image_info_flag:getPositionY()
    	end
    else
    	if self.lastTouchingTime and (self.touchTime - self.lastTouchingTime) > 5 then
    		self.flagSpeed = 0
    	end
    	if self.flagSpeed > 0 then
    		if self.flagDiretion ~= 1 then
    			self.flagDiretion = 1
    			self.flagStartPosy = self.Image_info_flag:getPositionY()
    			self.upTime = 0
    		end
    	elseif self.flagDiretion ~= 2 then
    		self.flagDiretion = 2
    		self.flagStartPosy = self.Image_info_flag:getPositionY()
    		self.dropTime = 0
    	end
    end
    if self.flagDiretion == 1 then
    	local flagPosy = self.Image_info_flag:getPositionY()
    	local speed = self.flagSpeed - self.gravitySpeed * self.upTime * 3
    	local maxPoy = self.maxHeight - self.flagHeight + self.startDeltaLen
    	if speed > 0 and flagPosy < maxPoy then
    		local movHeight = (self.flagSpeed * self.upTime) - (0.5 * self.gravitySpeed * self.upTime * self.upTime)
    		self.Image_info_flag:setPositionY(MATH_MIN(self.flagStartPosy + movHeight, maxPoy))
    		self.upTime = self.upTime + dt
    	else
    		self.flagSpeed = 0
    	end
    else
    	local movHeight = self.minSpeed * self.dropTime + 0.5 * (self.dropSpeed + self.gravitySpeed) * self.dropTime * self.dropTime
    	local posy = MATH_MAX(self.startDeltaLen, (self.flagStartPosy - movHeight))
    	self.Image_info_flag:setPositionY(posy)
    	self.dropTime = self.dropTime  + dt
    end
    self.touchTime = self.touchTime + 1
end

--direction 1(up) 2(down)
function ManualMakeView:getShearsDirection()
	local curPosY = self.Image_info_shears:getPositionY()
	local direction = math.random(2)
	if direction == 1 and curPosY >= (self.maxHeight - self.shearsHeight) then
		direction = 2
	end
	if direction == 2 and curPosY <= self.shearsHeight then
		direction = 1
	end
	return direction
end

function ManualMakeView:beginTouchBtn()
	if not self.btnTouching then
		local act = CCSequence:create({
			CCScaleTo:create(0.3,1),
			CCCallFunc:create(function()
				self.Image_circle:setScale(0.2)
			end)
		})
		self.Image_circle:runAction(act)
	end
	self.btnTouching = true
	self.touchTime = 0
end

function ManualMakeView:endTouchBtn()
	self.btnTouching = false
	self.touchTime = 0
end


function ManualMakeView:getManualAward()
	if not self.choosedManual then
		return
	end
	ManualMakeDataMgr:sendReqHandWorkReward(self.choosedManual.id)
end

function ManualMakeView:resetMakingBar()
	for i=1,3 do
		self.makingBar[i]:setPercent(0)
		self.markMarkBg[i]:setVisible(false)
		self.markDot[i]:setVisible(false)
	end
end

--是否结束制作
function ManualMakeView:checkeGameOverOrNot()
	local leftTime = self.endTime - ServerDataMgr:getServerTime()
	if leftTime <= 0 then
		return true
	end
    local maxIntegral = self.choosedManual.maxintegral
	local realScore = self.score + self.addScore
	if realScore > maxIntegral then
		return true
	end
	return false
end

--制作进度信息
function ManualMakeView:updateMakingBar()
	self:resetMakingBar()
	local integral = self.choosedManual.integral
	local maxIntegral = self.choosedManual.maxintegral

	local realScore = self.score + self.addScore
	local scores = {}
	for i,info in ipairs(integral) do
		for score, rewards in pairs(info) do
			if realScore >= tonumber(score) then

			end
			scores[#scores + 1] = score
		end
	end
	for i,v in ipairs(scores) do
		if realScore >= v then
			self.makingBar[i]:setPercent(100)
			self.markMarkBg[i]:setVisible(true)
			if not self.Spine_text[i].isPlay then
				self.Spine_text[i].spine:play(self.spine_textRes[i],false)
				self.Spine_text[i].isPlay = true
				if i==3 then
					self.Spine_award_di:setVisible(true)
					self.Spine_award_di:play("effect_Goods_2_xia",true)
					self.Spine_award_up:play("effect_Goods_2_shang",false)
				end
			end
			self.markDot[i]:setVisible(true)
		else
			self.markMarkBg[i]:setVisible(false)
			self.markDot[i]:setVisible(false)
			if i == 1 then
				local percent = realScore / v * 100
				self.makingBar[i]:setPercent(percent)
			else
				local minScore = MATH_MAX(realScore - scores[i - 1], 0)
				local percent = minScore / (v - scores[i - 1]) * 100
				self.makingBar[i]:setPercent(percent)
			end
		end
	end

	if realScore > maxIntegral then
		self:removeCountDownTimer()
    	self:sendAddScore()
    	--self.Panel_controlView:setVisible(false)
	end
end

function ManualMakeView:updateMakingScore()
	self.controlEndTime = ServerDataMgr:getServerTime()
	ManualMakeDataMgr:sendUpdateScore(self.choosedManual.id, self.addScore, self.controlStartTime, self.controlEndTime)
end

function ManualMakeView:startTimeDown()
	self.Panel_controlView:setVisible(true)
	self:addCountDownTimer()
end

--请求手工完成后的奖励
function ManualMakeView:getRward()
	if self.choosedManual then
		ManualMakeDataMgr:sendReqHandWorkReward(self.choosedManual.id)
	end
end

--制作完成
function ManualMakeView:restMakingAnimation()
	self.making = false
 	if self.playEndAnimate then
		return
	end
	self:timeOut(function()
		self.playEndAnimate = true
	 	self.Spine_manualMake:play(self:getEffectNameByID(6),false)
	 	self.Spine_manualMake:addMEListener(TFARMATURE_COMPLETE,function()
			self:timeOut(function()
				self.playEndAnimate = false
				self.Spine_manualMake:removeMEListener(TFARMATURE_COMPLETE)
				self.Spine_manualMake:play(self:getEffectNameByID(2),true)
				self.Panel_Animation:setPosition(self.animationPos.srcPos)
				self.Panel_menu:setOpacity(255)
				self.Panel_menu:setPosition(self.Panel_menuPos)
				self.Panel_Menudetail:setOpacity(255)
				self.Panel_Menudetail:setPosition(self.Panel_menuDetailPos)
		    	self:updateMainView()
		    end, 0)
	    end) 
    end, 0.1)
end

function ManualMakeView:removeEvents()
    self:removeCountDownTimer()
	self:stopScheduleUpdate()
end

function ManualMakeView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, -1, nil, handler(self.onCountDownPer, self))
    end
end

function ManualMakeView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
        self.countDownTimer_ = nil
    end
end

function ManualMakeView:onCountDownPer()
    if not self.choosedManual then
    	return
    end

    --倒计时
    local leftTime = self.endTime - ServerDataMgr:getServerTime()
    leftTime = math.max(leftTime, 0)
	local percent =  leftTime / self.choosedManual.worktime * 100
	self.LoadingBar_timeBar:setPercent(percent)
	self.Label_makingTime:setText(leftTime)

	self.score = self.score + self.choosedManual.natureTime
	if self:judgeControlValid() then
		self.addScore = self.addScore + 1
	end
	self:updateMakingBar()

	if leftTime <= 0 then
    	self:removeCountDownTimer()
    	self:sendAddScore()
		return
	end
end

--操作是否得分
function ManualMakeView:judgeControlValid()
	local rangeHeight = self.Image_info_flag:getSize().height
	local shearsY = self.Image_info_shears:getPositionY()
	local flagY = self.Image_info_flag:getPositionY()
	if shearsY >= flagY and shearsY <= flagY + rangeHeight then
		self.Spine_partical:play("effect_particle",false)
		self.Image_icon_shears:setTexture("ui/makefood/handwork/004.png")
		return true
	end
	self.Image_icon_shears:setTexture("ui/makefood/handwork/003.png")
	return false
end


--奖励界面
function ManualMakeView:showAwardPL()
	if not self.choosedManual then
		return
	end
	if self.datingId_ then
		self:getManualAward()
		return
	end
	self.Panel_makeAward:setVisible(true)
	self.Panel_makeAward:setTouchEnabled(true)
	self.Panel_makeAward:setSwallowTouch(true)
	local award
	local integralT = self.choosedManual.integral
	local rewards = {}
	for k,curIntegralT in pairs(integralT) do
		for score,v in pairs(curIntegralT) do
			rewards[#rewards + 1] = {tonumber(score), v}
		end
	end
	table.sort(rewards, function(a, b)
		return a[1] > b[1]
	end)
	for i,v in ipairs(rewards) do
		if (self.score + self.addScore) >= v[1] then
			award = clone(v[2])
			break
		end
	end
		
	if not award then
		award = rewards[#rewards] and clone(rewards[#rewards][2]) or {}
	end
	self.Panel_rewards:removeAllChildren()
	local itemIndex = 0

	for k,v in pairs(award) do		
		local item = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
		local itemCnt = v * self.clickMakeCnt
		PrefabDataMgr:setInfo(item, k,itemCnt)
		item:setAnchorPoint(me.p(0.5,0.5))
		itemIndex = itemIndex + 1
    	item:setName("item"..itemIndex)
    	self.Panel_rewards:addChild(item)
	end

	-- local evenNumber = itemCnt%2
	-- local leftNumber = math.floor(itemCnt/2)
	-- local dis = 200
	-- local firstPosX = 0
	-- if evenNumber == 0 then
	-- 	firstPosX = -dis*(leftNumber-1)-dis/2
	-- else
	-- 	firstPosX = -dis*leftNumber
	-- end
	for i=1,itemIndex do
		local item = self.Panel_rewards:getChildByName("item"..i)
		if item then
			item:setPosition(ccp((itemIndex * -100) - 100  + itemIndex * 200, 0))
		end
	end
end


-------------------------消息事件反馈-------------------------------
--手工信息更新
function ManualMakeView:onRecvGetManualInfo(data)
	self.manualMakingInfo = ManualMakeDataMgr:getManualMakingInfo()
	if self.manualMakingInfo then
		self.endTime = self.manualMakingInfo.endTime
		self.score = self.manualMakingInfo.integral
		self.leftTime = self.endTime - ServerDataMgr:getServerTime()
		self.making = self.leftTime > 0 
		self.addScore = 0

		local manualInfo = ManualMakeDataMgr:getManualInfoById(self.manualMakingInfo.manualId)
		self.choosedManual = manualInfo
		if self.choosedManual and self.manualMakingInfo.integral >= self.choosedManual.maxintegral then
			self.haveAward = true
			self:restMakingAnimation()
			return
		end
		if self.leftTime <= 0 then
			self.haveAward = true
			self:restMakingAnimation()
			return
		end
	end

	if self.making then
		self:updateMainView()
	end
end

--更新积分返回
function ManualMakeView:onRecvUpdateScore(data)
	self.controlStartTime = ServerDataMgr:getServerTime()
end

--请求制作返回
function ManualMakeView:onRecvMakeManual(data)
	self.manualMakingInfo = ManualMakeDataMgr:getManualMakingInfo()
	if self.manualMakingInfo then
		self.endTime = self.manualMakingInfo.endTime
		self.score = self.manualMakingInfo.integral
		self.addScore = 0
	end

	self:timeOut(function()
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
	            	self.making = true
	    			self:updateMainView()
	            end)
	    })
	    self.Panel_Animation:runAction(animationPanelSeq)
    end, 0)
end

--领取完奖励
function ManualMakeView:onRecvGetManualAward(data)
	self.manualMakingInfo = nil
	if self.datingId_ then
		local nextDatingId = ManualMakeDataMgr:getNextDatingId()
		nextDatingId = nextDatingId > 0 and nextDatingId or self.datingId_
		EventMgr:dispatchEvent(EV_DATING_EVENT.miniGameCloseInfo, nextDatingId)
		AlertManager:closeLayer(self)
		return
	end
	if data then
		self.score = 0
		self.haveAward = false
		self.Panel_makeAward:setVisible(false)
		self.Panel_makeAward:setTouchEnabled(false)
		Utils:showReward(data.rewards)
	end
	ManualMakeDataMgr:resetManualInfo()
	self:updateMainView()
end

function ManualMakeView:getEffectNameByID(id, lastType)

	local realType = lastType or self.manualType
	if realType == 1 then
		return "shipin_"..id
	elseif realType == 2 then
		return "wanou_"..id
	else
		return "huayi_"..id
	end
end

return ManualMakeView