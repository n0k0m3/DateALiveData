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
local CommonRoomView = class("CommonRoomView",BaseLayer)

function CommonRoomView:ctor( roomType, pageIndex, pageType )
	-- body
	self.super.ctor(self,data)
	self.roomType = roomType
	self.pageIndex = pageIndex
	self.pageType = pageType
	--self.__cname = "Room_"..roomType.. "_"..pageType
	self:addTopBar()
	self:initData()
	--print("xxxxxxxxxx","Room_"..roomType.. "_"..pageType)
	self:init("lua.uiconfig.explore.commonRoomInfo")
end

function CommonRoomView:onShow(  )
	-- body
	self.super.onShow(self)
  	GameGuide:checkGuide(self)
end

function CommonRoomView:initData()

	self.roomData = ExploreDataMgr:getCabinData(self.roomType)
	self.roomCfg, self.roomDetailCfg, self.stageCfg = ExploreDataMgr:getCabinCfg(self.roomType)
	self.preDetailCfg = self.preDetailCfg or self.roomDetailCfg

	if self.preDetailCfg.level < self.roomDetailCfg.level then
		self.isLevelUp = true

	end
end

function CommonRoomView:addTopBar()
	self.topBar = requireNew("lua.logic.explore.CommonTopBar"):new(self.roomType, self.pageIndex)
	self:addChild(self.topBar,100)
end

function CommonRoomView:initUI(ui)
	-- body
	self.super.initUI(self,ui)

	self.Image_1 = TFDirector:getChildByPath(ui,"Image_1")
	self.Image_1.initPos = self.Image_1:getPosition()

	self.Panel_model = TFDirector:getChildByPath(ui,"Panel_model")
	self.Panel_model.initPos = self.Panel_model:getPosition()
	self.Image_shadow = TFDirector:getChildByPath(ui,"Image_shadow")
	self.Image_bg_shadow = TFDirector:getChildByPath(ui,"Image_bg_shadow")
	self.Image_bg_shadow:setTexture(self.roomCfg.bgShadow)
	
	local pos = TFDirector:getChildByPath(ui,"pos")
	for i = 1,#self.roomCfg.poses do
		local _pos = pos:clone()
		_pos:setName("pos"..i)
		_pos:setPosition(self.roomCfg.poses[i])
		self.Panel_model:addChild(_pos)
	end

	self.Panel_info = TFDirector:getChildByPath(ui,"Panel_info")
	self.Panel_info.initPos = self.Panel_info:getPosition()

	self.Panel_value = TFDirector:getChildByPath(ui,"Panel_value")
	self.Panel_value.initPos = self.Panel_value:getPosition()

	self.Panel_valueItem = TFDirector:getChildByPath(ui,"Panel_valueItem")
	self.Label_attrText = TFDirector:getChildByPath(ui,"Label_attrText")
	self.Panel_costItem = TFDirector:getChildByPath(ui,"Panel_costItem")
	self.Spine_levelUp = TFDirector:getChildByPath(self.Panel_model,"Spine_levelUp"):hide()

	self.costGoods = TFDirector:getChildByPath(self.Panel_info,"CostGoods")
	self.costGoods.goodsIcon = TFDirector:getChildByPath(self.costGoods,"goodIcon")
	self.costGoods.goodsNum = TFDirector:getChildByPath(self.costGoods,"num")
	self.costGoods.goodsNum:setText("0/0")

	self.Button_lvUp = TFDirector:getChildByPath(ui,"Button_lvUp")
	self.lvUpRedTip = TFDirector:getChildByPath(self.Button_lvUp,"Image_redTip")
	self:refreshView()

	self:showAnim()
end

function CommonRoomView:showAnim()
	local panel = self.Panel_info
	if self.pageType == 2 then
		panel = self.Panel_value
	end
	self.Image_1:stopAllActions()
    self.Panel_model:stopAllActions()
    panel:stopAllActions()
	self.Image_1:setPosition(self.Image_1.initPos)
	self.Panel_model:setPosition(self.Panel_model.initPos)
	panel:setPosition(panel.initPos)
	ViewAnimationHelper.doMoveFadeInAction(self.Image_1, {direction = 4, distance = 10, ease = 2, delay = 0.1, time = 0.2})
	ViewAnimationHelper.doMoveFadeInAction(self.Image_shadow, {direction = 4, distance = 10, ease = 2, delay = 0.15, time = 0.15})
    ViewAnimationHelper.doMoveFadeInAction(self.Panel_model, {direction = 4, distance = 10, ease = 2, delay = 0.15, time = 0.15, callback = function ( ... )
    	-- body
    	self.ui:runAnimation("Action0",-1)
    end })

    
    ViewAnimationHelper.doMoveFadeInAction(panel, {direction = 2, distance = 30, ease = 1})

    self.topBar:showAnim()
end

function CommonRoomView:playEffectLevelUp( ... )
	-- body
	self.Spine_levelUp:show()
	self.Spine_levelUp:addMEListener( TFARMATURE_COMPLETE,function ( ... )
            	-- body
				self.Spine_levelUp:removeMEListener(TFARMATURE_COMPLETE)
				self.Spine_levelUp:hide()
	    end)
	self.Spine_levelUp:play("animation",false)
	Utils:playSound(5051)
end

function CommonRoomView:checkPreCondition( roomDetailCfg )
	-- body
	return ExploreDataMgr:checkCabinUpgradePreCondition(roomDetailCfg.type)
end

function CommonRoomView:registerEvents(ui)
	-- body
	self.super.registerEvents(self,ui)
    EventMgr:addEventListener(self, EV_EXPLORE_CABIN_REFRESH, handler(self.refreshView, self))

    self.Button_lvUp:onClick(function ( ... )
    	-- body
    	if not self:checkPreCondition(self.roomDetailCfg) then
    		Utils:showTips(13311258)
    		return
    	end
    	if not self:checkCostsEnough(self.roomDetailCfg) then
    		Utils:showTips(13311257)
    		return
    	end

    	ExploreDataMgr:SEND_EXPLORE_CABIN_UPGRADE(self.roomType)
    end)
end

function CommonRoomView:checkCostsEnough( roomDetailCfg )
	-- body
	return ExploreDataMgr:checkCabinUpgradeCostsEnough(roomDetailCfg.type)
end

function CommonRoomView:refreshView( ... )
	self:initData()
	self:updateModel()
	self:updatePanelInfo()
	self:updatePanelValue()
	self.Panel_info:setVisible(self.pageType == 1)
	self.Panel_value:setVisible(self.pageType == 2)

	if self.isLevelUp then
		self:playEffectLevelUp()
		self.isLevelUp = false
		self.preDetailCfg = self.roomDetailCfg
	end

	self.lvUpRedTip:setVisible(ExploreDataMgr:checkRedPoint(self.roomType,"CommonRoomView",1))
end

function CommonRoomView:getUnLockSitLevel( pos )
	-- body
	local cabins = TabDataMgr:getData("ExploreCabin")
	for k,v in ipairs(cabins) do
		if v.type == self.roomType and v.heroSize >= pos then
			return v.level
		end
	end
	return 15
end

function CommonRoomView:updateModel( ... )
	-- body
	local image_model = TFDirector:getChildByPath(self.Panel_model,"Image_model")
	image_model:setTexture(self.roomCfg.picture)
	for i = 1,5 do
		local pos = TFDirector:getChildByPath(self.Panel_model,"pos"..i)
		local Panel_lock = TFDirector:getChildByPath(pos,"Panel_lock")
		local Panel_role = TFDirector:getChildByPath(pos,"Panel_role")
		local Panel_empty = TFDirector:getChildByPath(pos,"Panel_empty")
		local Image_redTip = TFDirector:getChildByPath(pos,"Image_redTip")
		local Image_select = TFDirector:getChildByPath(pos,"Image_select")
		local Panel_touch = TFDirector:getChildByPath(pos,"Panel_touch")
		local Label_unLockLv = TFDirector:getChildByPath(Panel_lock,"Label_unLockLv")
		local Spine_effectLock = TFDirector:getChildByPath(Panel_empty,"Spine_effectLock")


		local isLock = i > self.roomDetailCfg.heroSize
		local unLockLv = self:getUnLockSitLevel(i)
		Label_unLockLv:setText("Lv."..unLockLv)

		local roleId
		self.roomData.driver = self.roomData.driver or {}
		for k,v in pairs(self.roomData.driver) do
			if v.index == i then
				roleId = v.heroId
				break;
			end
		end

		local isSelect = self.selectIdx == i
		Panel_lock:setVisible(isLock)
		Panel_role:setVisible(not isLock and roleId)
		Panel_empty:setVisible(not isLock and not roleId)
		Image_select:setVisible(not isLock)
		if roleId then
			local Image_head = TFDirector:getChildByPath(Panel_role,"Image_head")
			Image_head:setTexture(HeroDataMgr:getIconPathById(roleId))
		end
		local preIsLock = i > self.preDetailCfg.heroSize
		local isUnLock = not isLock and preIsLock
		Spine_effectLock:setVisible(isUnLock)
		if isUnLock then
			Spine_effectLock:addMEListener( TFARMATURE_COMPLETE,function ( ... )
            	-- body
  				Spine_effectLock:removeMEListener(TFARMATURE_COMPLETE)
  				Spine_effectLock:hide()
            end)
			Spine_effectLock:play("animation",false)
			Utils:playSound(5052)
		end
		Image_redTip:setVisible(not isLock and not roleId and ExploreDataMgr:checkRedPoint(self.roomType,"CommonRoomView",2))
		Panel_touch:setTouchEnabled(not isLock)
		Panel_touch:onClick(function ( ... )
			-- body
			self.selectIdx = i
			local function checkState( roleId )
				-- body
				local cabinCid = ExploreDataMgr:getRoleIsInCabin(roleId)

				if cabinCid then
					return TabDataMgr:getData("ExploreCabin",cabinCid).name
				end

			end

			local function sendMsg( roomType, isSure, heroId  )
				-- body
				if isSure then
					ExploreDataMgr:SEND_EXPLORE_CABIN_ADD_HERO( roomType, heroId, self.selectIdx)
				else
					local index = ExploreDataMgr:getRoleIsInCabinIndex(roomType, heroId)
					if index then
						ExploreDataMgr:SEND_EXPLORE_CABIN_REMOVE_HERO( roomType, index)
					end
				end
        		EventMgr:dispatchEvent(EV_EXPLORE_SHIP_CLOSE)
			end
			local function callBackFunc( isSure, heroId )
				-- body
				if not heroId then
					Utils:showTips(13311249)
					return
				end

				local roomType = self.roomType
				local cabinCid = ExploreDataMgr:getRoleIsInCabin(heroId)
				if isSure and cabinCid and TabDataMgr:getData("ExploreCabin",cabinCid).type == self.roomType then
					Utils:showTips(13311256)
					return
				end

				if not isSure and not cabinCid then
					return
				end

				if not isSure then
					roomType = TabDataMgr:getData("ExploreCabin",cabinCid).type
				end

				local cabinName = checkState(heroId)
				if isSure and cabinName then -- 该精灵在其他舱室
					local args = {
			            tittle = 2107025,
			            reType = "exploreHeroPullUp",
			            content = TextDataMgr:getText(13311254,cabinName),
			            confirmCall = function ( ... )
							sendMsg(roomType,isSure,heroId)
			            end,
			        }
			        Utils:showReConfirm(args)
			        return
				end


				if isSure and roleId then -- 当前坑位有精灵
					local args = {
			            tittle = 2107025,
			            reType = "exploreHeroPullUp",
			            content = TextDataMgr:getText(13311255,cabinName),
			            confirmCall = function ( ... )
							sendMsg(roomType,isSure,heroId)
			            end,
			        }
			        Utils:showReConfirm(args)
			        return
				end

				if not isSure then
				end

				sendMsg(roomType,isSure,heroId)
			end

			Utils:openView("explore.CommonShipTip",self.roomDetailCfg.name,roleId, checkState, callBackFunc)
		end)
	end
end

function CommonRoomView:updatePanelInfo( ... )
	-- body
	local Label_lvUpDes = TFDirector:getChildByPath(self.Panel_info,"Label_lvUpDes")
	local Label_level = TFDirector:getChildByPath(self.Panel_info,"Label_level")
	local ScrollView_attrs = TFDirector:getChildByPath(self.Panel_info,"ScrollView_attrs")
	local ScrollView_cost = TFDirector:getChildByPath(self.Panel_info,"ScrollView_cost")
	local Label_Max = TFDirector:getChildByPath(self.Panel_info,"Label_Max")

	local nextLevel = self.roomDetailCfg.level + 1
	local nextCabinCfg =  ExploreDataMgr:getCabinLevelCfg(self.roomType, nextLevel)

	if not self.uiList_cost then
		self.uiList_cost = UIListView:create(ScrollView_cost) 
	end

	Label_level:setText("Lv."..self.roomDetailCfg.level)
	if nextCabinCfg then
		Label_lvUpDes:setText(self.roomDetailCfg.des2)
	end

	Label_Max:setVisible(not nextCabinCfg)
	Label_lvUpDes:setVisible(nextCabinCfg)
	ScrollView_cost:setVisible(nextCabinCfg)
	self.Button_lvUp:setVisible(nextCabinCfg)

	self:updateAttrsList()
	self:updateCosts()
	self.costGoods:setVisible(nextCabinCfg)
end

function CommonRoomView:updatePanelValue( ... )
	-- body
	local  ScrollView_value = TFDirector:getChildByPath(self.Panel_value,"ScrollView_value")

	if not self.uiList_value then
		self.uiList_value = UIListView:create(ScrollView_value)
	end
	self:updateValueList()
end

function CommonRoomView:updateAttrsList( ... )
	-- body
	self.Label_attrText:setText(self.roomDetailCfg.des)
end

function CommonRoomView:updateCosts( ... )
	-- body
	local nextLevel = self.roomDetailCfg.level + 1
	local nextCabinCfg = ExploreDataMgr:getCabinLevelCfg(self.roomType,nextLevel)
	if not nextCabinCfg then
		nextCabinCfg = self.roomDetailCfg
	end
	local costsParts = {}
	local costsGoods = {}
	for k, v in pairs(nextCabinCfg.cost or {}) do
		if k == EC_SItemType.GOLD then
			costsGoods[k] = v
		else
			costsParts[k] = v
		end 
	end
	if table.count(costsGoods) > 0 then
		local itemId = EC_SItemType.GOLD
		local goodsCfg = GoodsDataMgr:getItemCfg(itemId)
		self.costGoods.goodsIcon:setTexture(goodsCfg.icon)
		local count = GoodsDataMgr:getItemCount(itemId)
		local color = count >= costsGoods[itemId] and me.WHITE or ccc3(255,91,141)
		self.costGoods.goodsNum:setColor(color)
		self.costGoods.goodsNum:setText(Utils:format_number(count).."/".. costsGoods[itemId])
	else
		self.costGoods.goodsNum:setText("0/0")
	end

	local itemCount = #self.uiList_cost:getItems() - table.count(costsParts)

	for i = 1,math.abs(itemCount) do
		if itemCount > 0 then
			self.uiList_cost:removeItem(1)
		else
			local item = self.Panel_costItem:clone()
			self.uiList_cost:pushBackCustomItem(item)
		end
	end

	local index = 1
	for k, v in pairs(costsParts) do
		local item = self.uiList_cost:getItem(index)
		index = index + 1
		local Panel_good = TFDirector:getChildByPath(item,"Panel_good")
		local Label_num = TFDirector:getChildByPath(item,"Label_num")
		local Label_num1 = TFDirector:getChildByPath(item,"Label_num1")

		if not Panel_good.Panel_goodsItem then
			local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
			Panel_goodsItem:setPosition(ccp(0,0))
			Panel_goodsItem:setScale(0.78)
			Panel_good:addChild(Panel_goodsItem)
			Panel_good.Panel_goodsItem = Panel_goodsItem
		end

		PrefabDataMgr:setInfo(Panel_good.Panel_goodsItem,tonumber(k))


		local count = GoodsDataMgr:getItemCount(tonumber(k))
		Label_num1:setText(GoodsDataMgr:getItemCount(tonumber(k),true).."/"..v)
		Label_num:setText(GoodsDataMgr:getItemCount(tonumber(k),true).."/"..v)

		Label_num1:setVisible(count < v)
		Label_num:setVisible(count >= v)

	end
	self.uiList_cost:setCenterArrange()
end

function CommonRoomView:updateValueList( ... )
	-- body

	local fightPowerTotal = ExploreDataMgr:getDirversFightPower(self.roomType)
	print(fightPowerTotal)
	self.uiList_value:removeAllItems()
	local values = ExploreDataMgr:getCabinAllCfg(self.roomType)
	for k,v in pairs(values) do
		local item = self.Panel_valueItem:clone()
		local Image_style1 = TFDirector:getChildByPath(item,"Image_style1")
		local Image_style2 = TFDirector:getChildByPath(item,"Image_style2")
		--local showStyle2 = self.roomData.fightPower < v.power
		local showStyle2 = fightPowerTotal < v.power
		Image_style1:setVisible(not showStyle2)
		Image_style2:setVisible(showStyle2)
		local parent = showStyle2 and Image_style2 or Image_style1

		local Label_lv = TFDirector:getChildByPath(parent,"Label_lv")
		local Label_power = TFDirector:getChildByPath(parent,"Label_power")
		local Label_attr = TFDirector:getChildByPath(parent,"Label_attr")

		Label_lv:setTextById(13311242,v.stageLevel)
		Label_power:setText(v.power)
		Label_attr:setText(v.des)
		self.uiList_value:pushBackCustomItem(item)
	end
end

function CommonRoomView:removeEvents( ... )
	-- body
	self.super.removeEvents(self)
end

return CommonRoomView