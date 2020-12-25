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
local ExhibitionRoomInfoView = class("ExhibitionRoomInfoView",BaseLayer)

function ExhibitionRoomInfoView:ctor( roomType, pageIndex, pageType )
	-- body
	self.super.ctor(self,data)
	self.roomType = roomType
	self.pageIndex = pageIndex
	self.pageType = pageType
	self:addTopBar()
	self:init("lua.uiconfig.explore.exhibitionRoomInfo")
end

function ExhibitionRoomInfoView:onShow(  )
	-- body
	self.super.onShow(self)
  	GameGuide:checkGuide(self)
end

function ExhibitionRoomInfoView:showAnim()
	local panel = self.Panel_value
	self.Image_1:stopAllActions()
    self.Panel_model:stopAllActions()
    panel:stopAllActions()
	self.Image_1:setPosition(self.Image_1.initPos)
	self.Panel_model:setPosition(self.Panel_model.initPos)
	panel:setPosition(panel.initPos)
	ViewAnimationHelper.doMoveFadeInAction(self.Image_1, {direction = 4, distance = 10, ease = 2, delay = 0.1, time = 0.2})
    ViewAnimationHelper.doMoveFadeInAction(self.Panel_model, {direction = 4, distance = 10, ease = 2, delay = 0.15, time = 0.15, callback = function ( ... )
    	-- body
    	self.ui:runAnimation("Action0",-1)
    end })
    ViewAnimationHelper.doMoveFadeInAction(panel, {direction = 2, distance = 30, ease = 1})

    self.topBar:showAnim()
end

function ExhibitionRoomInfoView:initData()
	self.roomData = ExploreDataMgr:getCabinData(self.roomType)
	self.roomCfg, self.roomDetailCfg, self.stageCfg = ExploreDataMgr:getCabinCfg(self.roomType)
end

function ExhibitionRoomInfoView:addTopBar()
	self.topBar = requireNew("lua.logic.explore.CommonTopBar"):new(self.roomType, self.pageIndex)
	self:addChild(self.topBar,100)
end

function ExhibitionRoomInfoView:initUI(ui)
	-- body
	self.super.initUI(self,ui)

	self.Image_1 = TFDirector:getChildByPath(ui,"Image_1")
	self.Image_1.initPos = self.Image_1:getPosition()

	self.Panel_model = TFDirector:getChildByPath(ui,"Panel_model")
	self.Panel_model.initPos = self.Panel_model:getPosition()
	self.Panel_value = TFDirector:getChildByPath(ui,"Panel_value")
	self.Panel_value.initPos = self.Panel_value:getPosition()
	self.Label_allStar = TFDirector:getChildByPath(ui,"Label_allStar")
	self.Panel_valueItem = TFDirector:getChildByPath(ui,"Panel_valueItem")

	self:refreshView()
	self.Image_bg_shadow = TFDirector:getChildByPath(ui,"Image_bg_shadow")
	self.Image_bg_shadow:setTexture(self.roomCfg.bgShadow)
	self:showAnim()
end

function ExhibitionRoomInfoView:registerEvents(ui)
	-- body
	self.super.registerEvents(self,ui)
    EventMgr:addEventListener(self, EV_EXPLORE_CABIN_REFRESH, handler(self.refreshView, self))
end

function ExhibitionRoomInfoView:refreshView( ... )
	self:initData()
	local image_model = TFDirector:getChildByPath(self.Panel_model,"Image_model")
	image_model:setTexture(self.roomCfg.picture)
	self:updatePanelValue()
	self.Label_allStar:setText(self:getAllStarCount())
end

function ExhibitionRoomInfoView:updatePanelValue( ... )
	-- body
	local  ScrollView_value = TFDirector:getChildByPath(self.Panel_value,"ScrollView_value")

	if not self.uiList_value then
		self.uiList_value = UIListView:create(ScrollView_value)
	end
	self:updateValueList()
end

function ExhibitionRoomInfoView:getAllStarCount( ... )
	-- body
	local allCfgs = TabDataMgr:getData("ExploreTreasure")
	local starNum = 0
	for k,v in pairs(allCfgs) do
		if v.subType == 1 then
			local item = GoodsDataMgr:getItem(v.id)
			if item then
				local _,data = next(item)
				starNum = starNum + data.star
			end
		end
	end
	return starNum
end

function ExhibitionRoomInfoView:updateValueList( ... )
	-- body
	self.uiList_value:removeAllItems()
	local values = TabDataMgr:getData("ExploreTreasureStar")
	for k,v in ipairs(values) do
		for _k,_v in pairs(v.talent) do
			local item = self.Panel_valueItem:clone()
			local Image_style1 = TFDirector:getChildByPath(item,"Image_style1")
			local Image_style2 = TFDirector:getChildByPath(item,"Image_style2")

			local showStyle2 = self:getAllStarCount() < v.starConut
			Image_style1:setVisible(not showStyle2)
			Image_style2:setVisible(showStyle2)
			local parent = showStyle2 and Image_style2 or Image_style1

			local Label_starNum = TFDirector:getChildByPath(parent,"Label_starNum")
			local Label_heroUp = TFDirector:getChildByPath(parent,"Label_heroUp")
			local Label_shipUp = TFDirector:getChildByPath(parent,"Label_shipUp")

			Label_starNum:setText(v.starConut)
			Label_heroUp:setText(v.des1)
			Label_shipUp:setText(v.des2)
			self.uiList_value:pushBackCustomItem(item)
		end
	end
end

function ExhibitionRoomInfoView:removeEvents( ... )
	-- body
	self.super.removeEvents(self)
end

return ExhibitionRoomInfoView