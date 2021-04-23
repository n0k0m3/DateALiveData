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

local MaokaMaidListView = class("MaokaMaidListView",BaseLayer)

function MaokaMaidListView:ctor( ... )
	-- body
	self.super.ctor(self,...)
	self:init("lua.uiconfig.activity.maidList")
end

function MaokaMaidListView:initUI( ui )
	-- body
	self.super.initUI(self,ui)

	self.Button_set = TFDirector:getChildByPath(ui,"Button_set")
	self.Button_return = TFDirector:getChildByPath(ui,"Button_return")

	local ScrollView_maid = TFDirector:getChildByPath(ui,"ScrollView_maid")
	self.uiList_maid = UIListView:create(ScrollView_maid)
	self.uiList_maid:setItemsMargin(60)

	local ScrollView_upDetail = TFDirector:getChildByPath(ui,"ScrollView_upDetail")

	self.uiList_upDetail = UIListView:create(ScrollView_upDetail)
	self.uiList_upDetail:setItemsMargin(5)

	self.Image_left = TFDirector:getChildByPath(ui,"Image_left")
	self.Image_right = TFDirector:getChildByPath(ui,"Image_right")
	self.Panel_item = TFDirector:getChildByPath(ui,"Panel_item")
	self.Panel_upItem = TFDirector:getChildByPath(ui,"Panel_upItem")
	self.Label_total = TFDirector:getChildByPath(ui,"Label_total")
	self:updateContent()
end

function MaokaMaidListView:registerEvents( ... )
	self.super.registerEvents(self)
	-- body

	self.Button_return:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)

	self.Button_set:onClick(function ( ... )
		-- body
		if not self.curSelect then 
			Utils:showTips(13316793)
			return 
		end
		MaokaActivityMgr:SEND_ACTIVITY_REQ_SET_MAID_NESS_ID(self.curSelect)
	end)

	EventMgr:addEventListener(self, EV_MAOKA_ALLDATA_RSP, function ( activityId, extendData )
        -- body
        self:updateContent()
    end)

end

function MaokaMaidListView:updateContent( ... )
	-- body
	local hasMaid = {}
	local index = 0
	local maidCfgs = TabDataMgr:getData("CatMaid")
	local maidList = table.keys(maidCfgs)

	table.sort(maidList, function (v1,v2)
		-- body
		local have1 = MaokaActivityMgr:getMaidInfo(v1) and true or false
		local have2 = MaokaActivityMgr:getMaidInfo(v2) and true or false
		if have1 == have2 then 
			return v1 < v2 
		else
			return have1
		end
	end)
	for k,v in pairs(maidList) do

		if MaokaActivityMgr:getMaidInfo(v) then
			table.insert(hasMaid, maidCfgs[v])
		end
		index = index + 1
		local item = self.uiList_maid:getItem(index)
		if not item then
			item = self.Panel_item:clone()
			self.uiList_maid:pushBackCustomItem(item)
		end

		self:updateItem(item, maidCfgs[v])
	end

	local num = #hasMaid - #self.uiList_upDetail:getItems()

	if num < 0 then
		for i = 1,math.abs(num) do
			self.uiList_upDetail:removeItem(1)
		end
	end

	for k,v in ipairs(hasMaid) do
		local item = self.uiList_upDetail:getItem(k)
		if not item then
			item = self.Panel_upItem:clone()
			self.uiList_upDetail:pushBackCustomItem(item)
		end
		self:updateUpItem(item, v.formulaAdd)
	end
	
	local ownNum = #MaokaActivityMgr:getMaidInfo()
	self.Label_total:setText(ownNum.."/"..#maidList)
end

function MaokaMaidListView:updateItem( item, data )
	-- body
	local Label_name = TFDirector:getChildByPath(item,"Label_name")
	local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
	local Label_des = TFDirector:getChildByPath(item,"Label_des")
	local Label_access = TFDirector:getChildByPath(item,"Label_access")
	local Image_noHave = TFDirector:getChildByPath(item,"Image_noHave")
	local Image_using = TFDirector:getChildByPath(item,"Image_using")
	local Panel_up = TFDirector:getChildByPath(item,"Panel_up")
	local Image_select = TFDirector:getChildByPath(item,"Image_select")
	
	local isHave = MaokaActivityMgr:getMaidInfo(data.id)
	Label_name:setTextById(data.nameTextId)
	Image_icon:setTexture(data.picture)
	Label_des:setTextById(data.desTextId)
	Image_noHave:setVisible(not isHave)

	Label_access:setVisible(not isHave)
	Image_using:setVisible(isHave and MaokaActivityMgr:getMaidId() == data.id)
	Panel_up:setVisible(isHave)
	Label_access:setTextById(data.getwayDes)

	self:updateUpItem(Panel_up, data.formulaAdd)

	Image_select:setVisible(self.curSelect == data.id)
	item:setTouchEnabled(isHave)
	item:onClick(function ( ... )
		-- body
		if self.curSelect == data.id then return end

		self.curSelect = data.id
		self:updateContent()
	end)
end

function MaokaMaidListView:updateUpItem( item, data )
	-- body
	local Image_itemIcon = TFDirector:getChildByPath(item,"Image_itemIcon")
	local Label_value = TFDirector:getChildByPath(item,"Label_value")
	local Label_upName = TFDirector:getChildByPath(item,"Label_upName")

	local id, value = next(data)
	Image_itemIcon:setTexture(GoodsDataMgr:getItemCfg(id).icon)
	Label_value:setText((value/100).."%")
	Image_itemIcon:setGrayEnabled(not MaokaActivityMgr:getFormulaInfo(id))
	if Label_upName then
		Label_upName:setTextById(GoodsDataMgr:getItemCfg(id).nameTextId)
	end
	Image_itemIcon:setTouchEnabled(true)
	Image_itemIcon:onClick(function ( ... )
		-- body
		Utils:openView("activity.maoka.MaokaFormulaListView",id)
	end)
	
end
return MaokaMaidListView