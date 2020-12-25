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
local GemAccessoriesTip = class("GemAccessoriesTip",BaseLayer)

function GemAccessoriesTip:ctor(roomType, gemId, callBackFunc )
	-- body
	self.super.ctor(self)
	self.gemData = GoodsDataMgr:getSingleItem(gemId)
	self.callBackFunc = callBackFunc

	self.roomData = ExploreDataMgr:getCabinData(roomType)
	self:showPopAnim(true)
	
	self.gemList = GoodsDataMgr:getItemsBySuperTyper(EC_ResourceType.EXPLORE_TREASURE,1)


	for i = #self.gemList,1,-1 do
		if self:checkIsWorking(self.gemList[i].id) then
			table.remove(self.gemList,i)
		end
	end

	table.sort( self.gemList, function ( v1, v2 )
		-- body
		local cfg1 = GoodsDataMgr:getItemCfg(v1.cid)
		local cfg2 = GoodsDataMgr:getItemCfg(v2.cid)

		if v1.star == v2.star then
			if cfg1.quality == cfg2.quality then
				return v1.cid < v2.cid
			else
				return cfg1.quality > cfg2.quality
			end
		else
			return v1.star > v2.star
		end
		
	end )

	self:init("lua.uiconfig.explore.gemAccessoriesTip")
end

function GemAccessoriesTip:initUI( ui )
	-- body
	self.super.initUI(self,ui)

	self.Button_equip = TFDirector:getChildByPath(ui,"Button_equip")
	self.Button_pullDown = TFDirector:getChildByPath(ui,"Button_pullDown")
	self.Button_cover = TFDirector:getChildByPath(ui,"Button_cover")

	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	self.Panel_gemSit = TFDirector:getChildByPath(ui,"Panel_gemSit")
	self.Panel_gemSit1 = TFDirector:getChildByPath(ui,"Panel_gemSit1")
	self.Label_tip1 = TFDirector:getChildByPath(ui,"Label_tip1")
	self.Label_state = TFDirector:getChildByPath(ui,"Label_state")
	self.Panel_goodItem = TFDirector:getChildByPath(ui,"Panel_goodItem")

	self.Panel_starItem = TFDirector:getChildByPath(ui,"Panel_starItem")
	self.Label_empty = TFDirector:getChildByPath(ui,"Label_empty")

	self.Label_empty:setVisible(#self.gemList == 0)
	local ScrollView_list = TFDirector:getChildByPath(ui,"ScrollView_list")
	self.uiGrid_list = UIGridView:create(ScrollView_list)
	self.uiGrid_list:setItemModel(self.Panel_goodItem)
	self.uiGrid_list:setColumn(4)
	self:refreshView()
end

function GemAccessoriesTip:onShow( ... )
	self.super.onShow(self)
  	GameGuide:checkGuide(self)
end

function GemAccessoriesTip:registerEvents( ... )
	-- body
	self.super.registerEvents(self)
	self.Button_equip:onClick(function ( ... )
		-- body
		if not self.selected then 
			Utils:showTips(13311260)
			return 
		end
		self.callBackFunc(true, self.selected.id)
		AlertManager:closeLayer(self)
	end)

	self.Button_pullDown:onClick(function ( ... )
		-- body
		self.callBackFunc(false)
		AlertManager:closeLayer(self)
	end)

	self.Button_cover:onClick(function ( ... )
		-- body
		self.callBackFunc(true, self.selected.id)
		AlertManager:closeLayer(self)
	end)

	self.Button_close:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)
end

function GemAccessoriesTip:refreshView( ... )
	-- body
	self:updateGemList()
	self:updateGemSit()
	self:updateGemSit1()
	self.Button_cover:setVisible(self.gemData and self.selected)
	self.Button_equip:setVisible(not self.gemData)
	self.Button_pullDown:setVisible(self.gemData and not self.selected)
end

function GemAccessoriesTip:checkIsWorking( uid )
	-- body
	self.roomData.treasure = self.roomData.treasure or {}
	for k,v in pairs(self.roomData.treasure) do
		if v.uuid == uid then
			return v.index
		end
	end
	return nil
end

function GemAccessoriesTip:updateGemList( ... )
	-- body
	for k,v in pairs(self.gemList) do
		local item = self.uiGrid_list:getItem(k)
		if not item then
			item = self.Panel_goodItem:clone()
			item:setName("item"..k)
			self.uiGrid_list:pushBackCustomItem(item)
		end

		local itemCfg = GoodsDataMgr:getItemCfg(v.cid)

		local Panel_good = TFDirector:getChildByPath(item,"Panel_good")
		local Image_working = TFDirector:getChildByPath(item,"Image_working")
		local Label_working = TFDirector:getChildByPath(item,"Label_working")
		Label_working:setSkewX(15)
		local Image_select = TFDirector:getChildByPath(item,"Image_select")

		if not Panel_good.goodItem then
			local panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        	panel_goodsItem:setPosition(ccp(0,0))
        	panel_goodsItem:setScale(Panel_good:getContentSize().width/panel_goodsItem:getContentSize().width)
        	panel_goodsItem:setAnchorPoint(Panel_good:getAnchorPoint())
        	Panel_good:addChild(panel_goodsItem)
        	Panel_good.goodItem = panel_goodsItem
		end

        PrefabDataMgr:setInfo(Panel_good.goodItem, v.cid)
        Panel_good.goodItem:setTouchEnabled(false)

        local isWorking = self:checkIsWorking(v.id)
     	Image_working:setVisible(isWorking)
     	Image_select:setVisible(self.selected == v)
     	item:setTouchEnabled(not isWorking)
     	item:onClick(function ( ... )
     		-- body
     		self.selected = v
     		self:refreshView()
     	end)
	end
	self.uiGrid_list:doLayout()
end

function GemAccessoriesTip:updateGemSit( ... )
	-- body
	local Panel_empty = TFDirector:getChildByPath(self.Panel_gemSit,"Panel_empty")
	local Panel_gem = TFDirector:getChildByPath(self.Panel_gemSit,"Panel_gem")

	Panel_empty:setVisible(not self.gemData)
	Panel_gem:setVisible(self.gemData)
	if self.gemData then
		self:updateAccessoriesInfo(Panel_gem, self.gemData)
	end
end

function GemAccessoriesTip:updateGemSit1( ... )
	-- body
	local Panel_empty = TFDirector:getChildByPath(self.Panel_gemSit1,"Panel_empty")
	local Panel_gem = TFDirector:getChildByPath(self.Panel_gemSit1,"Panel_gem")

	Panel_empty:setVisible(not self.selected)
	Panel_gem:setVisible(self.selected)
	if self.selected then
		self:updateAccessoriesInfo(Panel_gem,self.selected)
	end
end

function GemAccessoriesTip:updateAccessoriesInfo( item , data )
	-- body
	local gemCfg = GoodsDataMgr:getItemCfg(data.cid)


	local Image_quality = TFDirector:getChildByPath(item,"Image_quality")
	local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
	local Label_name = TFDirector:getChildByPath(item,"Label_name")
	local Panel_star = TFDirector:getChildByPath(item,"Panel_star")
	local Label_des3 = TFDirector:getChildByPath(item,"Label_des3")
	local ScrollView_desc = TFDirector:getChildByPath(item,"ScrollView_desc")
	local uilistview_des = item.uilistview_des
	if not uilistview_des then
		uilistview_des = UIListView:create(ScrollView_desc)
		item.uilistview_des = uilistview_des
	end

	local maxStar = #gemCfg.levelCost + 1
	local curStar = data.star
	Panel_star:removeAllChildren()
	for i = 1,maxStar do
		local starItem = self.Panel_starItem:clone()
		starItem:setPosition(ccp(10+(i-1)*25,0))
		Panel_star:addChild(starItem)

		local Image_light = TFDirector:getChildByPath(starItem,"Image_light")
		local Image_dark = TFDirector:getChildByPath(starItem,"Image_dark")
		Image_light:setVisible(i <= curStar)
		Image_dark:setVisible(i > curStar)
	end

	Image_quality:setTexture("ui/explore/growup/exhibition/tip/quality_"..gemCfg.quality..".png")
	Image_icon:setTexture(gemCfg.icon)
	Label_name:setTextById(gemCfg.nameTextId)
	local desTextId = gemCfg.des[curStar]
	Label_des3:setText("")

	uilistview_des:removeAllItems()
	local label = Label_des3:clone()
	label:setTextById(desTextId)
	label:setDimensions(355,0)
	uilistview_des:pushBackCustomItem(label)

end


return GemAccessoriesTip