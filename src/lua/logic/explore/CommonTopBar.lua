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

local CommonTopBar = class("CommonTopBar",BaseLayer)

function CommonTopBar:ctor( roomType, pageIndex )
	-- body
	self.super.ctor(self,data)
	self.roomType = roomType
	self.pageIndex = pageIndex
	self.roomCfg, self.roomDetailCfg, self.stageCfg = ExploreDataMgr:getCabinCfg(self.roomType)

	self:init("lua.uiconfig.explore.commonTopBar")
end

function CommonTopBar:initUI( ui )
	-- body
	self.super.initUI(self,ui)

	self.Image_3 = TFDirector:getChildByPath(ui,"Image_3"):hide()
	self.Panel_touched = TFDirector:getChildByPath(ui,"Panel_touched"):hide()

	self.panel_top = TFDirector:getChildByPath(ui,"panel_top")
	self.panel_bottom = TFDirector:getChildByPath(ui,"panel_bottom")
	self.top_pos = self.panel_top:getPosition()
	self.bottom_pos = self.panel_bottom:getPosition()

	self.Button_return = TFDirector:getChildByPath(ui,"Button_return")
	self.Label_name = TFDirector:getChildByPath(ui,"Label_name")
	self.Image_stageIcon = TFDirector:getChildByPath(ui,"Image_stageIcon")
	self.Label_stage = TFDirector:getChildByPath(ui,"Label_stage")
	self.Button_help = TFDirector:getChildByPath(ui,"Button_help")
	self.Button_changeRoom = TFDirector:getChildByPath(ui,"Button_changeRoom")
	self.Panel_pageItem = TFDirector:getChildByPath(ui,"Panel_pageItem")
	self.Panel_roomItem = TFDirector:getChildByPath(ui,"Panel_roomItem")
	self.Label_tip = TFDirector:getChildByPath(ui,"Label_tip")

	self.Label_name:setSkewX(15)
	self.Label_stage:setSkewX(15)
	self.Label_tip:setSkewX(15)

	local ScrollView_page = TFDirector:getChildByPath(ui,"ScrollView_page")
	self.uiList_page = UIListView:create(ScrollView_page)

	local ScrollView_room = TFDirector:getChildByPath(ui,"ScrollView_room")
	self.uiList_room = UIListView:create(ScrollView_room)

	self:refreshView()
	self:updataPageList()
end

function CommonTopBar:showAnim()
	self.panel_top:stopAllActions()
    self.panel_bottom:stopAllActions()
	self.panel_top:setPosition(self.top_pos)
	self.panel_bottom:setPosition(self.bottom_pos)
	ViewAnimationHelper.doMoveFadeInAction(self.panel_top, {direction = 3, distance = 30, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(self.panel_bottom, {direction = 4, distance = 30, ease = 1})
end

function CommonTopBar:checkRedPoint( ... )
	-- body
	for k, item in ipairs(self.uiList_room:getItems()) do
		local data = item.data or TabDataMgr:getData("ExploreCabinUi", k)
		local Image_redTip = TFDirector:getChildByPath(item,"Image_redTip")
		local showRedPoint = false

		for k,v in pairs(data.pageUi) do
			showRedPoint = ExploreDataMgr:checkRedPoint(data.type,v.fileName,v.pageIndex)
			if showRedPoint then break end
		end

		Image_redTip:setVisible(showRedPoint)
	end

	for pageIndex,item in ipairs(self.uiList_page:getItems()) do
		local Image_redTip = TFDirector:getChildByPath(item,"Image_redTip")
		local v = self.roomCfg.pageUi[pageIndex]
		local realFileName = "lua.logic.explore."..v.fileName
		local pageClass = requireNew(realFileName)
		local showRedPoint = ExploreDataMgr:checkRedPoint(self.roomType,v.fileName,v.pageIndex)
		
		Image_redTip:setVisible(showRedPoint)
	end
end

function CommonTopBar:registerEvents( ... )
	-- body
	self.super.registerEvents(self)
    EventMgr:addEventListener(self, EV_EXPLORE_CABIN_REFRESH, handler(self.refreshView, self))
    EventMgr:addEventListener(self, EV_BAG_EXPLORE_EQUIP_UPDATE, handler(self.checkRedPoint, self))
    EventMgr:addEventListener(self, EV_EXPLORE_CABIN_TASK_REFRESH, handler(self.checkRedPoint, self))
    EventMgr:addEventListener(self, EV_EXPLORE_CABIN_TECH_REFRESH, handler(self.checkRedPoint, self))
    EventMgr:addEventListener(self, EV_BAG_EXPLORE_TREATURE_UPDATE, handler(self.checkRedPoint, self))
    EventMgr:addEventListener(self, EV_EXPLORE_UPGRADE_KNOWLEDGE, handler(self.checkRedPoint, self))
    EventMgr:addEventListener(self, EV_EXPLORE_CABIN_EQUIP_REFRESH, handler(self.checkRedPoint, self))
    EventMgr:addEventListener(self, EV_EXPLORE_TASK_RED_POINT, handler(self.checkRedPoint, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.checkRedPoint, self))


	self.Button_help:onClick(function ( ... )
		-- body
        local layer = require("lua.logic.common.HelpView"):new(self.roomCfg.helpInterface)
        AlertManager:addLayer(layer)
        AlertManager:show()
	end)

	self.Button_return:onClick(function ( ... )
		-- body
		if self:getParent() then
			AlertManager:closeLayer	(self:getParent())
		end
	end)

	self.Button_changeRoom:onClick(function ( ... )
		-- body
		if not self.Panel_touched:isVisible() then
			self:playShowRoomAni()
		end
		self.Image_3:setVisible(not self.Image_3:isVisible())
		self.Panel_touched:setVisible(not self.Panel_touched:isVisible())

	end)

	self.Panel_touched:onClick(function ( ... )
		-- body
		self.Image_3:setVisible(false)
		self.Panel_touched:setVisible(false)
	end)

end

function CommonTopBar:playShowRoomAni( ... )
	-- body
	for k,v in ipairs(self.uiList_room:getItems()) do
		v.defaultPos = v.defaultPos or v:getPosition()
		local tagetPos = v.defaultPos
		v:setPositionX(tagetPos.x + 80)
		local arr = {
			DelayTime:create(k*0.02),
			MoveTo:create(0.2,tagetPos)
		}
		v:runAction(CCSequence:create(arr))
	end
end

function CommonTopBar:refreshView( ... )
	-- body
	self.roomCfg, self.roomDetailCfg, self.stageCfg = ExploreDataMgr:getCabinCfg(self.roomType)
	self.Label_name:setText(self.roomDetailCfg.name)
	self.Image_stageIcon:setTexture(self.stageCfg.stageIcon)

	local stageLevel = ExploreDataMgr:getRoomStageLevel(self.roomType)
	self.Label_stage:setTextById(13311242,stageLevel)
	--self.Label_stage:setTextById(13311242,self.stageCfg.stageLevel)

	self.Image_stageIcon:setVisible(self.roomCfg.showStage)
	self.Label_stage:setVisible(self.roomCfg.showStage)
	self:updateRoomList()
	self:updataPageList()
	self:checkRedPoint()
end

function CommonTopBar:updateRoomList( ... )

	local function checkUnlock( roomCfg ) -- 策划说的只添加前端的舱室解锁逻辑
		-- body
		local unlock = true
		if roomCfg.unlockCondition then

			for k,v in pairs(roomCfg.unlockCondition) do
				local _cfg, detailCfg = ExploreDataMgr:getCabinCfg(k)
				if detailCfg.level < v then
					unlock = false
					break;
				end
			end
		end
		return unlock
	end

	-- body
	local roomList = TabDataMgr:getData("ExploreCabinUi")

	local showRoom = {}

	for k,v in ipairs(roomList) do
		if checkUnlock(v) then
			table.insert(showRoom,v)
		end
	end

	for k,v in ipairs(showRoom) do
		local item = self.uiList_room:getItem(k)
		if not item then
			item = self.Panel_roomItem:clone()
			self.uiList_room:pushBackCustomItem(item)
			item:setName("shipRoom"..k)
		end
		item.data = v
		self:updateRoomItem(item, v)
	end
end

function CommonTopBar:updateRoomItem( item, data )
	-- body
	local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
	local Image_cur = TFDirector:getChildByPath(item,"Image_cur")
	local Label_name = TFDirector:getChildByPath(Image_cur,"Label_name")
	local Label_level = TFDirector:getChildByPath(Image_cur,"Label_level")

	local Image_normal = TFDirector:getChildByPath(item,"Image_normal")

	local isCurRoom = data.type == self.roomType

	local parent = isCurRoom and Image_cur or Image_normal
	local Label_name = TFDirector:getChildByPath(parent,"Label_name")
	local Label_level = TFDirector:getChildByPath(parent,"Label_level")

	local roomCfg,detailCfg,stageCfg = ExploreDataMgr:getCabinCfg(data.type)
	Label_name:setText(detailCfg.name)
	Label_level:setText("Lv."..detailCfg.level)

	Label_level:setVisible(roomCfg.showLevel)

	Image_cur:setVisible(isCurRoom)
	Image_normal:setVisible(not isCurRoom)
	Image_icon:setTexture(data.thumbnail)

	item:setTouchEnabled(true)
	item:onClick(function ( ... )
		-- body

		if self.roomType == data.type then return end

		if self:getParent() then
			AlertManager:closeLayer(self:getParent())
		end

		local realFileName = "explore."..data.pageUi[1].fileName
		Utils:openView(realFileName, data.type, 1, data.pageUi[1].pageIndex)
	end)

end

function CommonTopBar:updataPageList( ... )
	-- body
	local pageList = self.roomCfg.pageUi
	if #pageList == 0 then self.uiList_page:setVisible(false)  return end

	for k,v in ipairs(pageList) do
		local item = self.uiList_page:getItem(k)
		if not item then
			item = self.Panel_pageItem:clone()
			item:setName("roomPage"..k)
			self.uiList_page:pushBackCustomItem(item)
			item:setTouchEnabled(true)
			item:onClick(function ( ... )
				-- body
				--todo open v.fileName
				if self.pageIndex == k then return end

				local roomType = self.roomType
				if self:getParent() then
					AlertManager:closeLayer(self:getParent())
				end

				local realPath = "explore."..v.fileName
				Utils:openView(realPath, roomType, k, v.pageIndex)

			end)
		end

		local Label_pageName = TFDirector:getChildByPath(item,"Label_pageName")
		local Image_select = TFDirector:getChildByPath(item,"Image_select")
		Label_pageName:setText(v.name)

		Image_select:setVisible(k == self.pageIndex)

	end
	self.uiList_page:doLayout()
end

return CommonTopBar