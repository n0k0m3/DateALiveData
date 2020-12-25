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
local EquipAccessoriesTip = class("EquipAccessoriesTip",BaseLayer)

function EquipAccessoriesTip:ctor(roomType, equipId,  callBackFunc)
	-- body
	self.super.ctor(self)
	self.equipData = GoodsDataMgr:getSingleItem(equipId)
	self.callBackFunc = callBackFunc
	self:showPopAnim(true)
	self.roomData = ExploreDataMgr:getCabinData(roomType)
	self.equipList = GoodsDataMgr:getItemsBySuperTyper(EC_ResourceType.EXPLORE_ACCESSORIES,3)


	for i = #self.equipList,1,-1 do
		if self:checkIsWorking(self.equipList[i].id) then
			table.remove(self.equipList,i)
		end
	end

	table.sort( self.equipList, function ( v1, v2 )
		-- body
		-- body
		local cfg1 = GoodsDataMgr:getItemCfg(v1.cid)
		local cfg2 = GoodsDataMgr:getItemCfg(v2.cid)

		if cfg1.quality == cfg2.quality then
			return v1.cid < v2.cid
		else
			return cfg1.quality > cfg2.quality
		end
		
	end )
	self:init("lua.uiconfig.explore.equipAccessoriesTip")
end

function EquipAccessoriesTip:onShow( ... )
	-- body
	self.super.onShow(self)
	GameGuide:checkGuide(self);
end

function EquipAccessoriesTip:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	self.Button_equip = TFDirector:getChildByPath(ui,"Button_equip")
	self.Button_pullDown = TFDirector:getChildByPath(ui,"Button_pullDown")
	self.Button_cover = TFDirector:getChildByPath(ui,"Button_cover")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	self.Panel_equipSit = TFDirector:getChildByPath(ui,"Panel_equipSit")
	self.Panel_equipSit1 = TFDirector:getChildByPath(ui,"Panel_equipSit1")
	self.Label_tip1 = TFDirector:getChildByPath(ui,"Label_tip1")
	self.Label_state = TFDirector:getChildByPath(ui,"Label_state")
	self.Panel_goodItem = TFDirector:getChildByPath(ui,"Panel_goodItem")
	
	self.Label_empty = TFDirector:getChildByPath(ui,"Label_empty")

	self.Label_empty:setVisible(#self.equipList == 0)

	local ScrollView_list = TFDirector:getChildByPath(ui,"ScrollView_list")
	self.uiGrid_list = UIGridView:create(ScrollView_list)
	self.uiGrid_list:setItemModel(self.Panel_goodItem)
	self.uiGrid_list:setColumn(4)
	self:refreshView()
end

function EquipAccessoriesTip:registerEvents( ... )
	-- body
	self.super.registerEvents(self)
	self.Button_equip:onClick(function ( ... )
		-- body
		if not self.selected then 
			Utils:showTips(13311259)
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

function EquipAccessoriesTip:checkIsWorking( uid )
	-- body
	self.roomData.equip = self.roomData.equip or {}
	for k,v in pairs(self.roomData.equip) do
		if v.id == uid and v.index ~= 0 then
			return v.index
		end
	end
	return nil
end

function EquipAccessoriesTip:refreshView( ... )
	-- body
	self:updateEquipList()
	self:updateEquipSit()
	self:updateEquipSit1()
	self.Button_cover:setVisible(self.equipData and self.selected)
	self.Button_equip:setVisible(not self.equipData)
	self.Button_pullDown:setVisible(self.equipData and not self.selected)
end

function EquipAccessoriesTip:updateEquipList( ... )
	-- body
	for k,v in pairs(self.equipList) do
		local item = self.uiGrid_list:getItem(k)
		if not item then
			item = self.Panel_goodItem:clone()
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
end

function EquipAccessoriesTip:updateEquipSit( ... )
	-- body
	local Panel_empty = TFDirector:getChildByPath(self.Panel_equipSit,"Panel_empty")
	local Panel_accessoires = TFDirector:getChildByPath(self.Panel_equipSit,"Panel_accessoires")

	Panel_empty:setVisible(not self.equipData)
	Panel_accessoires:setVisible(self.equipData)
	if self.equipData then
		self:updateAccessoriesInfo(Panel_accessoires,self.equipData)
	end
end

function EquipAccessoriesTip:updateEquipSit1( ... )
	-- body
	local Panel_empty = TFDirector:getChildByPath(self.Panel_equipSit1,"Panel_empty")
	local Panel_accessoires = TFDirector:getChildByPath(self.Panel_equipSit1,"Panel_accessoires")

	Panel_empty:setVisible(not self.selected)
	Panel_accessoires:setVisible(self.selected)
	if self.selected then
		self:updateAccessoriesInfo(Panel_accessoires,self.selected)
	end
end

function EquipAccessoriesTip:updateAccessoriesInfo( item , data )
	-- body
	local equipCfg = GoodsDataMgr:getItemCfg(data.cid)

	local equipLevelCfg = ExploreDataMgr:getEquipLevelCfg(data.cid, data.level)

	local Image_quality = TFDirector:getChildByPath(item,"Image_quality")
	local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
	local Label_name = TFDirector:getChildByPath(item,"Label_name")
	local Label_des = TFDirector:getChildByPath(item,"Label_des")
	local Label_des1 = TFDirector:getChildByPath(item,"Label_des1")
	local Label_des3 = TFDirector:getChildByPath(item,"Label_des3")
	local ScrollView_desc = TFDirector:getChildByPath(item,"ScrollView_desc")
	local uilistview_des = item.uilistview_des
	if not uilistview_des then
		uilistview_des = UIListView:create(ScrollView_desc)
		item.uilistview_des = uilistview_des
	end

	Image_quality:setTexture("ui/explore/growup/accessories/tip/quality_"..equipCfg.quality..".png")
	Image_icon:setTexture(equipCfg.icon)
	Label_name:setText(equipCfg.name)
	Label_des:setText(equipCfg.des2)
	Label_des1:setText(equipCfg.des)

	Label_des3:setText("")
	uilistview_des:removeAllItems()
	local label = Label_des3:clone()
	label:setText(equipLevelCfg.desc)
	label:setDimensions(355,0)
	uilistview_des:pushBackCustomItem(label)
end


return EquipAccessoriesTip