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
local WeaponRoomView = class("WeaponRoomView",BaseLayer)

function WeaponRoomView:ctor( roomType )
	-- body
	self.super.ctor(self,data)
	self.roomType = roomType
	self.pageIndex = ExploreDataMgr:getPageIndex(self.roomType, "WeaponRoomView")
	self:addTopBar()
	self:init("lua.uiconfig.explore.weaponRoom")
end

function WeaponRoomView:initData()
	self.roomData = ExploreDataMgr:getCabinData(self.roomType)
	self.roomCfg, self.roomDetailCfg, self.stageCfg = ExploreDataMgr:getCabinCfg(self.roomType)
	if not self.selectedWeaponId then
		for k,v in ipairs(self.roomCfg.equipId) do
			if GoodsDataMgr:getItem(v) then
				self.selectedWeaponId = v
				break;
			end
		end
	end
	self.selectedWeaponId = self.selectedWeaponId or self.roomCfg.equipId[1]


	local k
	if GoodsDataMgr:getItem(self.selectedWeaponId) then
		local curEquipData
		k,curEquipData = next(GoodsDataMgr:getItem(self.selectedWeaponId))

		if self.equipData then
			if self.equipData.cid == curEquipData.cid and self.equipData.level < curEquipData.level then
				self.isLevelUp = true
			end
		end
		self.equipData = clone(curEquipData)

	else
		Box("=====配件还没有对应道具=====",self.selectedWeaponId) -- 正常逻辑不会到这儿 ，不用做多语言
	end
end

function WeaponRoomView:addTopBar()
	self.topBar = requireNew("lua.logic.explore.CommonTopBar"):new(self.roomType, self.pageIndex)
	self:addChild(self.topBar,100)
end

function WeaponRoomView:initUI(ui)
	-- body
	self.super.initUI(self,ui)
	self.Panel_right = TFDirector:getChildByPath(ui,"Panel_right")
	self.Panel_mid = TFDirector:getChildByPath(ui,"Panel_mid")
	self.Panel_left = TFDirector:getChildByPath(ui,"Panel_left")
	self.Spine_effect = TFDirector:getChildByPath(ui,"Spine_effect"):hide()
	self.Spine_effect1 = TFDirector:getChildByPath(ui,"Spine_effect1"):hide()

	self.Image_shadow = TFDirector:getChildByPath(ui,"Image_shadow")
	self.Image_icon = TFDirector:getChildByPath(ui,"Image_icon")
	self.Button_advance = TFDirector:getChildByPath(ui,"Button_advance")
	self.Label_name = TFDirector:getChildByPath(ui,"Label_name")
	self.Label_level = TFDirector:getChildByPath(ui,"Label_level")
	self.Label_advanceDes = TFDirector:getChildByPath(ui,"Label_advanceDes")
	self.Label_des = TFDirector:getChildByPath(ui,"Label_des")
	self.Label_weaponName = TFDirector:getChildByPath(ui,"Label_weaponName")
	self.Panel_weaponItem = TFDirector:getChildByPath(ui,"Panel_weaponItem")
	self.Panel_skillItem = TFDirector:getChildByPath(ui,"Panel_skillItem")
	self.Panel_costItem = TFDirector:getChildByPath(ui,"Panel_costItem")
	self.Label_Max = TFDirector:getChildByPath(ui,"Label_Max")
	self.Label_Max1 = TFDirector:getChildByPath(ui,"Label_Max1")
	self.Spine_levelUp = TFDirector:getChildByPath(ui,"Spine_levelUp"):hide()
	self.advance_redTip = TFDirector:getChildByPath(self.Button_advance,"Image_redTip")

	local ScrollView_weapon = TFDirector:getChildByPath(ui,"ScrollView_weapon")
	self.uiList_weapon = UIListView:create(ScrollView_weapon)
	local ScrollView_skill = TFDirector:getChildByPath(ui,"ScrollView_skill")
	self.uiList_skill = UIListView:create(ScrollView_skill)

	local ScrollView_cost = TFDirector:getChildByPath(ui,"ScrollView_cost")
	self.uiList_cost = UIListView:create(ScrollView_cost)

	self.costGoods = TFDirector:getChildByPath(self.Panel_right,"CostGoods")
	self.costGoods.goodsIcon = TFDirector:getChildByPath(self.costGoods,"goodIcon")
	self.costGoods.goodsNumCost = TFDirector:getChildByPath(self.costGoods,"numCost")
	self.costGoods.goodsNumOwn = TFDirector:getChildByPath(self.costGoods,"numOwn")
	self.costGoods.goodsNumOwn:setText("0")
	self.costGoods.goodsNumCost:setText("/0")

	self:refreshView()
end

function WeaponRoomView:playEffectLevelUp( ... )
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

function WeaponRoomView:registerEvents(ui)
	-- body
	self.super.registerEvents(self,ui)
    EventMgr:addEventListener(self, EV_EXPLORE_CABIN_EQUIP_REFRESH, handler(self.refreshView, self))
    EventMgr:addEventListener(self, EV_BAG_EXPLORE_EQUIP_UPDATE, handler(self.refreshView, self))
    EventMgr:addEventListener(self, EV_EXPLORE_CABIN_REFRESH, handler(self.refreshView, self))

	self.Button_advance:onClick(function ( ... )
		-- body
		if not self.checkCostsEnough(self.selectedWeaponId) then
    		Utils:showTips(13311257)
			return
		end
		if not GoodsDataMgr:getItem(self.selectedWeaponId) then
			return 
		end
		local _,item = next(GoodsDataMgr:getItem(self.selectedWeaponId))
		ExploreDataMgr:SEND_EXPLORE_EXPLORE_EQUIP_UPGRADE(item.id, self.roomType)
	end)
end

function WeaponRoomView.checkCostsEnough( weaponId )
	-- body
	return ExploreDataMgr:checkWeaponUpgradeCostsEnough(weaponId)
end

function WeaponRoomView:refreshView( ... )
	-- body
	self:initData()
	self:updateWeaponList()
	self:updateSkillList()
	self:updateSkillInfo()
	if self.isLevelUp then
		self:playEffectLevelUp()
		self.isLevelUp = false
	end
end

function WeaponRoomView:updateSkillList( ... )
	-- body
	local weaponCfg = TabDataMgr:getData("ExploreEquip",self.selectedWeaponId)
	local skills = weaponCfg.skillShow or {}
	local num = #self.uiList_skill:getItems() - #skills

	for i = 1,math.abs(num) do
		if num > 0 then
			self.uiList_skill:removeItem(1)
		else
			local item = self.Panel_skillItem:clone()
			self.uiList_skill:pushBackCustomItem(item)
		end		
	end

	local focusIndex = nil

	for k,v in pairs(skills) do
		local item = self.uiList_skill:getItem(k)
		local isUnlock = self:updateSkillItem(item, v)
		if isUnlock then
			focusIndex = k
		end
	end

	if focusIndex then
		self.uiList_skill:scrollToItem(focusIndex)
	end
end

function WeaponRoomView:getSkillUnlockLevel( skillId )
	-- body
	local equipLevels = TabDataMgr:getData("ExploreEquipLevel")
	local keys = table.keys(equipLevels)
	table.sort(keys, function (a,b)
		-- body
		return a < b
	end )

	for _,k in ipairs(keys) do
		local v = equipLevels[k]
		if v.equipId == self.selectedWeaponId and table.find(v.talent, skillId) ~= -1 then
			return v.level
		end
	end
	return 0
end

function WeaponRoomView:updateSkillItem( item, skillId )
	-- body
	local skillCfg = TabDataMgr:getData("AfkEffect", skillId)
	local Panel_locked = TFDirector:getChildByPath(item,"Panel_locked")
	local Image_icon = TFDirector:getChildByPath(Panel_locked,"Image_icon")
	local label_lv = TFDirector:getChildByPath(Panel_locked,"label_lv")
	local Spine_lock = TFDirector:getChildByPath(item,"Spine_lock"):hide()
	local Panel_unlock = TFDirector:getChildByPath(item,"Panel_unlock")

	local level = self:getSkillUnlockLevel(skillId)
	local isLock = not self.equipData or  self.equipData.level < level
	Panel_unlock:setVisible(not isLock)
	Panel_locked:setVisible(isLock)

	Image_icon:setTexture(skillCfg.icon)
	label_lv:setText("Lv.".. level )
	if isLock then
		Image_icon:setTexture(string.sub(skillCfg.icon,0,-5).."_1.png")
	end

	local Image_icon = TFDirector:getChildByPath(Panel_unlock,"Image_icon")
	Image_icon:setTexture(skillCfg.icon)


	if isLock then
		Image_icon:setTexture(string.sub(skillCfg.icon,0,-5).."_1.png")
	end
	item:setTouchEnabled(true)
	item:onClick(function ( ... )
		-- body
		Utils:openView("explore.SkillInfoView",skillId,isLock)
	end)

	if self.isLevelUp and level == self.equipData.level then -- 解锁节能
		Spine_lock:show()
		Spine_lock:addMEListener(TFARMATURE_COMPLETE,function ( ... )
			-- body
			Spine_lock:removeMEListener(TFARMATURE_COMPLETE)
			Spine_lock:hide()
		end)

		Spine_lock:play("animation_wubian",false)
		Utils:playSound(5052)
		return true
	end
end

function WeaponRoomView:onShow(  )
	-- body
	self.super.onShow(self)
	if not self.hasPlayEffect then
		self.Panel_mid:hide()
		self.Panel_right:hide()
		self.Panel_left:hide()
		self.topBar:hide()
		self.hasPlayEffect = true
		self.ui:timeOut(function ( ... )
			-- body
			self:playEffect( ... )
		end)
	end
  	GameGuide:checkGuide(self)
end

function WeaponRoomView:playEffect( ... )
	-- body
	self.Spine_effect:show()
	self.Spine_effect1:show()
	self.Spine_effect:addMEListener( TFARMATURE_EVENT,
            function()
            		self.Panel_mid:show()
					self.Panel_right:show()
					self.Panel_left:show()
            		self.topBar:show()
					ViewAnimationHelper.doMoveFadeInAction(self.Panel_mid, {direction = 1, distance = 0, ease = 2, delay = 0.1, time = 0.2})
               		ViewAnimationHelper.doMoveFadeInAction(self.Panel_right, {direction = 2, distance = 30, ease = 2, delay = 0.2, time = 0.2})
               		ViewAnimationHelper.doMoveFadeInAction(self.Panel_left, {direction = 1, distance = 0, ease = 2, delay = 0.2, time = 0.2})
               		
               		self.topBar:showAnim()
               	end)
	self.Spine_effect:addMEListener(TFARMATURE_COMPLETE,
	            function()
						self.Spine_effect:removeMEListener(TFARMATURE_COMPLETE)
					end)
	self.Spine_effect:play("pingmu_xia",false)
	Utils:playSound(5053)

	self.Spine_effect1:addMEListener(TFARMATURE_COMPLETE,
	            function()
						self.Spine_effect1:removeMEListener(TFARMATURE_COMPLETE)
						self.Spine_effect1:hide()
					end)
	self.Spine_effect1:play("pingmu_shang",false)
end

function WeaponRoomView:updateWeaponList( ... )
	-- body
	local weaponList = self.roomCfg.equipId

	for k,v in ipairs(weaponList) do
		local item = self.uiList_weapon:getItem(k)
		if not item then
			item = self.Panel_weaponItem:clone()
			self.uiList_weapon:pushBackCustomItem(item)
			local Spine_effect = TFDirector:getChildByPath(item,"Spine_effect")
			Spine_effect:play("animation",true)

			item:setName("weapon"..k)
		end
		self:updateWeaponItem(item,v)
	end
	self.uiList_weapon:setCenterArrange()
end

function WeaponRoomView:updateWeaponItem(item, weaponId)
	-- body
	local weaponCfg = TabDataMgr:getData("ExploreEquip",weaponId)
	local Image_bg = TFDirector:getChildByPath(item,"Image_bg")
	local Icon = TFDirector:getChildByPath(item,"Icon")
	local Image_redTip = TFDirector:getChildByPath(item,"Image_redTip")
	local Spine_effect = TFDirector:getChildByPath(item,"Spine_effect")
	local Image_lock = TFDirector:getChildByPath(item,"Image_lock")
	Spine_effect:setVisible(weaponId == self.selectedWeaponId)
	
	Image_redTip:setVisible(WeaponRoomView.checkCostsEnough(weaponId))

	local unLock = GoodsDataMgr:getItem(weaponId) and true or false
	Image_bg:setOpacity(255)
	Icon:setOpacity(255)
	if weaponId == self.selectedWeaponId then
		Image_bg:setTexture("ui/explore/growup/weapon/005.png")
		Icon:setTexture(weaponCfg.icon)
	elseif unLock then
		Image_bg:setTexture("ui/explore/growup/weapon/004.png")
		Icon:setTexture(string.sub(weaponCfg.icon,0,-5).."_1.png")
	else
		Image_bg:setTexture("ui/explore/growup/weapon/017.png")
		Icon:setTexture(string.sub(weaponCfg.icon,0,-5).."_1.png")
		--Image_bg:setOpacity(70)
		Icon:setOpacity(70)
	end

	Image_lock:setVisible(not unLock)

	Image_bg:setTouchEnabled(true)
	Image_bg:onClick(function ( ... )
		-- body
		if self.selectedWeaponId == weaponId then return end

		if not GoodsDataMgr:getItem(weaponId) then 
			Utils:showTips(13311261)
			return 
		end
		self.selectedWeaponId = weaponId
		self:initData()
		self:updateWeaponList()
		self:updateSkillList()
		self:updateSkillInfo()
	end)	
end

function WeaponRoomView.getNextUpLevelCfg(weaponId)
	-- body
	return ExploreDataMgr:getWeaponNextUpLevelCfg(weaponId)
end

function WeaponRoomView:updateSkillInfo( ... )
	-- body
	local weaponCfg = TabDataMgr:getData("ExploreEquip",self.selectedWeaponId)

	self.Image_icon:setTexture(weaponCfg.showUi)
	self.Image_shadow:setTexture(string.sub(weaponCfg.showUi,0,-5).."_shadow.png")
	self.Label_name:setText(weaponCfg.name)
	self.Label_weaponName:setText(weaponCfg.name)

	local curLevel = self.equipData and self.equipData.level or 1
	local curLevelCfg = ExploreDataMgr:getEquipLevelCfg(self.selectedWeaponId, curLevel)
	self.Label_des:setText(curLevelCfg.desc2)

	local _,item
	if GoodsDataMgr:getItem(self.selectedWeaponId) then
		_,item = next(GoodsDataMgr:getItem(self.selectedWeaponId))
	end
	local level = item and item.level or 0
	self.Label_level:setText("Lv."..level)

	local cfg = self.getNextUpLevelCfg(self.selectedWeaponId) 
	self.advance_redTip:setVisible(WeaponRoomView.checkCostsEnough(self.selectedWeaponId))
	if cfg then
		self.Label_advanceDes:setText(cfg.desc)

		local costsParts = {}
		local costsGoods = {}
		for k, v in pairs(cfg.cost or {}) do
			if k == EC_SItemType.GOLD then
				costsGoods[k] = v
			else
				costsParts[k] = v
			end 
		end
		if table.count(costsGoods) > 0 then
			self.costGoods:show()
			local itemId = EC_SItemType.GOLD
			local goodsCfg = GoodsDataMgr:getItemCfg(itemId)
			self.costGoods.goodsIcon:setTexture(goodsCfg.icon)
			local count = GoodsDataMgr:getItemCount(itemId)
			local color = count >= costsGoods[itemId] and me.WHITE or ccc3(255,91,141)
			self.costGoods.goodsNumCost:setColor(color)
			self.costGoods.goodsNumOwn:setColor(color)
			self.costGoods.goodsNumCost:setText("/".. costsGoods[itemId])
			self.costGoods.goodsNumOwn:setText(Utils:format_number(count))
		else
			self.costGoods:hide()
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
		for k,v in pairs(costsParts) do
			local item = self.uiList_cost:getItem(index)
			index = index + 1

			local Panel_good = TFDirector:getChildByPath(item,"Panel_good")
			local Label_num = TFDirector:getChildByPath(item,"Label_num")
			local Label_num1 = TFDirector:getChildByPath(item,"Label_num1")

			if not Panel_good.panel_goodsItem then 
				local panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
				panel_goodsItem:setScale(0.75)
				panel_goodsItem:setPosition(ccp(0,0))

				Panel_good:addChild(panel_goodsItem)
				Panel_good.panel_goodsItem = panel_goodsItem
			end

			PrefabDataMgr:setInfo(Panel_good.panel_goodsItem, tonumber(k))

			local count = GoodsDataMgr:getItemCount(tonumber(k))
			Label_num1:setText(GoodsDataMgr:getItemCount(tonumber(k),true).."/"..v)
			Label_num:setText(GoodsDataMgr:getItemCount(tonumber(k),true).."/"..v)

			Label_num1:setVisible(count < v)
			Label_num:setVisible(count >= v)
		end
		self.uiList_cost:setCenterArrange()
	end

	local isMax = not cfg

	self.uiList_cost:setVisible(not isMax)
	self.Label_Max:setVisible(isMax)
	self.Label_Max1:setVisible(isMax)
	self.Button_advance:setVisible(not isMax)
	self.Label_advanceDes:setVisible(not isMax)
	self.costGoods:setVisible(not isMax)
end

function WeaponRoomView:removeEvents( ... )
	-- body
	self.super.removeEvents(self)
end

return WeaponRoomView