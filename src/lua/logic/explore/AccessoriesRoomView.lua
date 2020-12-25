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
local AccessoriesRoomView = class("AccessoriesRoomView",BaseLayer)

function AccessoriesRoomView:ctor( data )
	-- body
	self.super.ctor(self,data)
	self.roomType = ShipRoomType.ACCESSORIES
	self.pageIndex = ExploreDataMgr:getPageIndex(self.roomType, "AccessoriesRoomView")
	self:addTopBar()
	self:init("lua.uiconfig.explore.accessoriesRoom")
end

function AccessoriesRoomView:onShow(  )
	-- body
	self.super.onShow(self)
	if not self.hasPlayEffect then
		self.Panel_show:hide()
		self.Panel_pos1:hide()
		self.Panel_pos2:hide()
		self.Panel_pos3:hide()
		self.topBar:hide()
		self.hasPlayEffect = true
		self.ui:timeOut(function ( ... )
			-- body
			self:playEffect( ... )
		end)
	end
  	GameGuide:checkGuide(self)
end

function AccessoriesRoomView.checkRedPoint( roomType )
	-- body
	return ExploreDataMgr:checkAccessoriesRoomRedPoint(roomType)
end

function AccessoriesRoomView:playEffect( ... )
	-- body
	self.Spine_effect:show()
	self.Spine_effect1:show()
	self.Spine_effect:addMEListener(TFARMATURE_EVENT,
            function()
					self.Panel_show:show()
					self.Panel_pos1:show()
					self.Panel_pos2:show()
					self.Panel_pos3:show()
            		self.topBar:show()
					ViewAnimationHelper.doMoveFadeInAction(self.Panel_show, {direction = 1, distance = 0, ease = 2, delay = 0.1, time = 0.2,callback = function ( ... )
						-- body
    					self.ui:runAnimation("Action0",-1)
					end})
               		ViewAnimationHelper.doMoveFadeInAction(self.Panel_pos1, {direction = 1, distance = 30, ease = 2, delay = 0.2, time = 0.2})
               		ViewAnimationHelper.doMoveFadeInAction(self.Panel_pos2, {direction = 2, distance = 30, ease = 2, delay = 0.3, time = 0.2})
               		ViewAnimationHelper.doMoveFadeInAction(self.Panel_pos3, {direction = 4, distance = 30, ease = 2, delay = 0.4, time = 0.2})
               		
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

function AccessoriesRoomView:initData()
	self.roomData = ExploreDataMgr:getCabinData(self.roomType)
	self.roomCfg, self.roomDetailCfg, self.stageCfg = ExploreDataMgr:getCabinCfg(self.roomType)
end

function AccessoriesRoomView:addTopBar()
	self.topBar = requireNew("lua.logic.explore.CommonTopBar"):new(self.roomType, self.pageIndex)
	self:addChild(self.topBar,100)
end

function AccessoriesRoomView:initUI(ui)
	-- body
	self.super.initUI(self,ui)

	self.Panel_show = TFDirector:getChildByPath(ui,"Panel_show")
	self.Spine_effect = TFDirector:getChildByPath(ui,"Spine_effect"):hide()
	self.Spine_effect1 = TFDirector:getChildByPath(ui,"Spine_effect1"):hide()
	self.Panel_pos1 = TFDirector:getChildByPath(ui,"Panel_pos1")
	self.Panel_pos2 = TFDirector:getChildByPath(ui,"Panel_pos2")
	self.Panel_pos3 = TFDirector:getChildByPath(ui,"Panel_pos3")

	self.Label_name = TFDirector:getChildByPath(ui,"Label_name")
	self.Label_name:setTextById(13311248)
	self.Panel_item = TFDirector:getChildByPath(ui,"Panel_item")
	self:refreshView()
	self.Image_icon = TFDirector:getChildByPath(ui,"Image_icon")
	self.Image_icon:setTexture(self.roomCfg.picture)
end

function AccessoriesRoomView:registerEvents(ui)
	-- body
	self.super.registerEvents(self,ui)
    EventMgr:addEventListener(self, EV_EXPLORE_CABIN_EQUIP_REFRESH, handler(self.refreshView, self))
    EventMgr:addEventListener(self, EV_EXPLORE_CABIN_REFRESH, handler(self.refreshView, self))   

end

function AccessoriesRoomView:getPosNeedLevel( pos )
	-- body
	local cabins = TabDataMgr:getData("ExploreCabin")

	for k,v in ipairs(cabins) do
		if v.type == self.roomType and v.holeSize >= pos then
			return v.level
		end
	end
	return 9999
end

function AccessoriesRoomView:getPosEquipData( pos )
	-- body
	if not self.roomData.equip then return nil end

	for k,v in pairs(self.roomData.equip) do
		if v.index == pos then
			return v
		end
	end
	return nil
end

function AccessoriesRoomView:refreshView( ... )
	self:initData()
	-- body
	local accessoriesCfgs = self.roomCfg.team
	for i = 1,3 do
		local teamPos = accessoriesCfgs[i]
		local pos = TFDirector:getChildByPath(self.ui,"Panel_pos"..i)
		local Image_dd = TFDirector:getChildByPath(pos,"Image_dd")
		local Label_name = TFDirector:getChildByPath(pos,"Label_name")

		Label_name:setTextById(teamPos.name)

		for k = 1,3 do
			local _pos = teamPos.list[k]
			local Panel_item = TFDirector:getChildByPath(pos,"equipPos".._pos)
			if not Panel_item then
				Panel_item = self.Panel_item:clone()
				Panel_item:setPosition(ccp(77 + 80*(k-1),80))
				local Spine_effect = TFDirector:getChildByPath(Panel_item,"Spine_effect")
				Spine_effect:play("animation",true)
				pos:addChild(Panel_item)
				Panel_item:setName("equipPos".._pos)
			end
			local Image_normal = TFDirector:getChildByPath(Panel_item,"Image_normal")
			local Image_add = TFDirector:getChildByPath(Panel_item,"Image_add")
			local Image_lock = TFDirector:getChildByPath(Panel_item,"Image_lock")
			local Label_unlockLv = TFDirector:getChildByPath(Panel_item,"Label_unlockLv")
			local Image_icon = TFDirector:getChildByPath(Panel_item,"Image_icon")
			local Image_redTip = TFDirector:getChildByPath(Panel_item,"Image_redTip")
			local Image_quality = TFDirector:getChildByPath(Panel_item,"Image_quality")
			
			local pos = teamPos.list[k]
			local unLocklevel = self:getPosNeedLevel(pos)
			local isLock = self.roomDetailCfg.level < unLocklevel
			Image_lock:setVisible(isLock)
			if unLocklevel ~= 9999 then
				Label_unlockLv:setText("Lv."..unLocklevel)
			else
				Label_unlockLv:setTextById(600027)
			end
			local equip = self:getPosEquipData(pos)
			Image_add:setVisible((not equip) and (not isLock))
			Image_normal:setVisible(equip and (not isLock))
			if equip then
				local equipCfg = TabDataMgr:getData("ExploreEquip",equip.cid) 
				Image_normal:setTexture("ui/explore/growup/accessories/equip/quality_"..equipCfg.quality..".png")
				Image_icon:setTexture(equipCfg.icon)
				Image_quality:setTexture(EC_ItemIcon[equipCfg.quality])
			end

			Image_add:setTouchEnabled(true)
			Image_normal:setTouchEnabled(true)
			Image_redTip:setVisible(not equip and AccessoriesRoomView.checkRedPoint(self.roomType))
			local function callBackFunc( isUp, chooseEquipId )
				-- body
				if isUp then
					ExploreDataMgr:SEND_EXPLORE_EXPLORE_EQUIP_PUT_ON(chooseEquipId, self.roomType, self.choosePos)
				else
					ExploreDataMgr:SEND_EXPLORE_EXPLORE_EQUIP_PUT_DOWN(self.roomType, self.choosePos)
				end
			end

			local function touchFunc()
				self.choosePos = pos
				local equip = self:getPosEquipData(pos)
				local equipId = equip and equip.id
				Utils:openView("explore.EquipAccessoriesTip", self.roomType, equipId, callBackFunc)
			end

			Image_add:onClick(touchFunc)
			Image_normal:onClick(touchFunc)
		end
	end
end

function AccessoriesRoomView:removeEvents( ... )
	-- body
	self.super.removeEvents(self)
end

return AccessoriesRoomView