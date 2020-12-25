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
local ExhibitionRoomView = class("ExhibitionRoomView",BaseLayer)

function ExhibitionRoomView:ctor( data )
	-- body
	self.super.ctor(self,data)
	self.roomType = ShipRoomType.EXHIBITION
	self.pageIndex = ExploreDataMgr:getPageIndex(self.roomType, "ExhibitionRoomView")
	self:addTopBar()
	self:init("lua.uiconfig.explore.exhibitionRoom")
end

function ExhibitionRoomView.checkRedPoint( roomType )
	-- body
	return ExploreDataMgr:checkExhibitionRoomRedPoint(roomType)
end

function ExhibitionRoomView:initData()
	self.roomData = ExploreDataMgr:getCabinData(self.roomType)
	self.roomCfg, self.roomDetailCfg, self.stageCfg = ExploreDataMgr:getCabinCfg(self.roomType)
end

function ExhibitionRoomView:addTopBar()
	self.topBar = requireNew("lua.logic.explore.CommonTopBar"):new(self.roomType, self.pageIndex)
	self:addChild(self.topBar,100)
end

function ExhibitionRoomView:initUI(ui)
	-- body
	self.super.initUI(self,ui)
	self.Spine_effect = TFDirector:getChildByPath(ui,"Spine_effect"):hide()
	self.Spine_effect1 = TFDirector:getChildByPath(ui,"Spine_effect1"):hide()
	self.Spine_effect2 = TFDirector:getChildByPath(ui,"Spine_effect2"):hide()
	self.Panel_show = TFDirector:getChildByPath(ui,"Panel_show")
	self.Panel_treasureShow = TFDirector:getChildByPath(ui,"Panel_treasureShow"):hide()
	self.Panel_treasure = TFDirector:getChildByPath(ui,"Panel_treasure")
	local Label_name = TFDirector:getChildByPath(self.Panel_show,"Label_name")
	self.Button_showTreasure = TFDirector:getChildByPath(self.Panel_show,"Button_showTreasure")
	Label_name:setTextById(13311246)
	local Label_name = TFDirector:getChildByPath(self.Panel_treasureShow,"Label_name")
	self.Button_hideTreasure = TFDirector:getChildByPath(self.Panel_treasureShow,"Button_hideTreasure")
	Label_name:setTextById(13311246)

	local ScrollView_treasure = TFDirector:getChildByPath(self.Panel_treasureShow,"ScrollView_treasure")
	self.uiList_treasure = UIListView:create(ScrollView_treasure)

	self:refreshView()
end

function ExhibitionRoomView:onShow( ... )
	-- body
	self.super.onShow(self)
	if not self.hasPlayEffect then
		self.Panel_show:hide()
		self.topBar:hide()
		self.hasPlayEffect = true
		self.ui:timeOut(function ( ... )
			-- body
			self:playEffect( ... )
		end)
	end
	GameGuide:checkGuide(self)
end

function ExhibitionRoomView:playEffect( ... )
	-- body
	self.Spine_effect2:show()
	self.Spine_effect1:show()
	

	self.Spine_effect2:addMEListener(TFARMATURE_EVENT,
            function()
            		self.Spine_effect:show()
					self.topBar:show()
					self.Spine_effect:addMEListener(
				            TFARMATURE_COMPLETE,
				            function()
				  				self.Spine_effect:removeMEListener(TFARMATURE_COMPLETE)
				               	self.Spine_effect:addMEListener(
						            TFARMATURE_COMPLETE,
						            function()
				  						self.Spine_effect:removeMEListener(TFARMATURE_COMPLETE)
				  						self.Spine_effect:hide()
						            	self.Panel_show:show()
						            end)
									self.Spine_effect:play("animation2",false)
				               	end)


					self.Spine_effect:play("animation",false)
					self.topBar:showAnim()
               	end)

	self.Spine_effect2:addMEListener(TFARMATURE_COMPLETE,
	            function()
						self.Spine_effect2:removeMEListener(TFARMATURE_COMPLETE)
					end)
	self.Spine_effect2:play("pingmu_xia",false)
	Utils:playSound(5053)

	self.Spine_effect1:addMEListener(TFARMATURE_COMPLETE,
	            function()
						self.Spine_effect1:removeMEListener(TFARMATURE_COMPLETE)
						self.Spine_effect1:hide()
					end)
	self.Spine_effect1:play("pingmu_shang",false)
end

function ExhibitionRoomView:registerEvents(ui)
	-- body
	self.super.registerEvents(self,ui)
    EventMgr:addEventListener(self, EV_BAG_EXPLORE_TREATURE_UPDATE, handler(self.refreshView, self))
    EventMgr:addEventListener(self, EV_EXPLORE_CABIN_REFRESH, handler(self.refreshView, self))

    self.Button_showTreasure:onClick(function ( ... )
    	-- body
    	self.Panel_treasureShow:show()
    	self.Panel_show:hide()
    end)

    self.Button_hideTreasure:onClick(function ( ... )
    	-- body
    	self.Panel_treasureShow:hide()
    	self.Panel_show:show()
    end)

	self.Panel_treasureShow:onClick(function ( ... )
		-- body
		self.Panel_treasureShow:hide()
		self.Panel_show:show()
	end)

end

function ExhibitionRoomView:getPosNeedLevel( pos )
	-- body
	local cabins = TabDataMgr:getData("ExploreCabin")

	for k,v in pairs(cabins) do
		if v.type == self.roomType and v.holeSize >= pos then
			return v.level
		end
	end
	return 15
end

function ExhibitionRoomView:getPosEquipData( pos )
	-- body
	if not self.roomData.treasure then return nil end
	for k,v in pairs(self.roomData.treasure) do
		if v.index + 1 == pos then
			return GoodsDataMgr:getSingleItem(v.uuid)
		end
	end
	return nil
end

function ExhibitionRoomView:refreshView( ... )
	self:initData()
	-- body
	for i = 1,5 do
		self:updatePos(i)
		self:updateTreasureInfo(i)
	end
	self.uiList_treasure:setCenterArrange()
end

function ExhibitionRoomView:updatePos( i )
	-- body
	local pos = TFDirector:getChildByPath(self.ui,"pos"..i)
	local Image_quality = TFDirector:getChildByPath(pos,"Image_quality")
	local Image_lock = TFDirector:getChildByPath(pos,"Image_lock")
	local Image_empty = TFDirector:getChildByPath(pos,"Image_empty")
	local Image_icon = TFDirector:getChildByPath(pos,"Image_icon")
	local Image_redTip = TFDirector:getChildByPath(Image_empty,"Image_redTip")

	local isLock = self:getPosNeedLevel(i) > self.roomDetailCfg.level
	local treasure = self:getPosEquipData(i)
	Image_quality:setVisible((not isLock) and treasure)
	Image_lock:setVisible(isLock)
	Image_empty:setVisible((not isLock) and (not treasure))

	if treasure then
		local treasureCfg = TabDataMgr:getData("ExploreTreasure",treasure.cid)
		Image_quality:setTexture("ui/explore/growup/exhibition/set/quality_"..treasureCfg.quality..".png")
		Image_icon:setTexture(treasureCfg.icon)
	end
	
	Image_empty:setTouchEnabled(true)
	Image_quality:setTouchEnabled(true)
	Image_redTip:setVisible(not treasure and ExhibitionRoomView.checkRedPoint(self.roomType))
	local function callBackFunc( isUp, chooseTreasureId )
		-- body
		if isUp then
			ExploreDataMgr:SEND_EXPLORE_EXPLORE_TREASURE_EQUIP( chooseTreasureId, self.choosePos - 1)
		else
			ExploreDataMgr:SEND_EXPLORE_EXPLORE_TREASURE_EQUIP( "0", self.choosePos - 1)
		end
	end

	local function touchFunc()
		self.choosePos = i
		local treasureId = treasure and treasure.id
		Utils:openView("explore.GemAccessoriesTip", self.roomType, treasureId, callBackFunc)
	end

	Image_empty:onClick(touchFunc)
	Image_quality:onClick(touchFunc)
end

function ExhibitionRoomView:updateTreasureInfo( i )
	-- body
	local item = self.uiList_treasure:getItem(i)
	if not item then
		item = self.Panel_treasure:clone()
		self.uiList_treasure:pushBackCustomItem(item)
	end

	local Panel_gemInfo = TFDirector:getChildByPath(item,"Panel_gemInfo")
	local Panel_empty = TFDirector:getChildByPath(item,"Panel_empty")
	local Panel_lock = TFDirector:getChildByPath(item,"Panel_lock")

	local isLock = self:getPosNeedLevel(i) > self.roomDetailCfg.level
	local treasure = self:getPosEquipData(i)
	Panel_gemInfo:setVisible((not isLock) and treasure)
	Panel_lock:setVisible(isLock)
	Panel_empty:setVisible((not isLock) and (not treasure))

	local Image_quality = TFDirector:getChildByPath(Panel_gemInfo,"Image_quality")
	local Image_icon = TFDirector:getChildByPath(Panel_gemInfo,"Image_icon")
	local Label_name = TFDirector:getChildByPath(Panel_gemInfo,"Label_name")
	local Label_des = TFDirector:getChildByPath(Panel_gemInfo,"Label_des")

	if treasure then
		local treasureCfg = TabDataMgr:getData("ExploreTreasure",treasure.cid)
		Image_quality:setTexture("ui/explore/growup/exhibition/set/quality_"..treasureCfg.quality..".png")
		local desTextId = treasureCfg.des[treasure.star]
		Image_icon:setTexture(treasureCfg.icon)
		Label_des:setTextById(desTextId)
		Label_name:setTextById(treasureCfg.nameTextId)
	end

	local Label_des = TFDirector:getChildByPath(Panel_lock,"Label_des")
	Label_des:setTextById(10000, self:getPosNeedLevel(i))
end

function ExhibitionRoomView:removeEvents( ... )
	-- body
	self.super.removeEvents(self)
end

return ExhibitionRoomView