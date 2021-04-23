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

local MaokaCatteryView = class("MaokaCatteryView",BaseLayer)

function MaokaCatteryView:ctor( ... )
	-- body
	self.super.ctor(self,...)
	self:init("lua.uiconfig.activity.cattery")
end

function MaokaCatteryView:initUI( ui )
	-- body
	self.super.initUI(self,ui)

	self.Button_return = TFDirector:getChildByPath(ui,"Button_return")
	self.Label_value = TFDirector:getChildByPath(ui,"Label_value")
	self.Button_get_cat = TFDirector:getChildByPath(ui,"Button_get_cat")
	self.Image_redPoint = TFDirector:getChildByPath(ui,"Image_redPoint")
	self.Label_total = TFDirector:getChildByPath(ui,"Label_total")

	local ScrollView_cat = TFDirector:getChildByPath(ui,"ScrollView_cat")

	self.uiList_cat = UIListView:create(ScrollView_cat)
	self.uiList_cat:setItemsMargin(60)

	self.Image_left = TFDirector:getChildByPath(ui,"Image_left")
	self.Image_right = TFDirector:getChildByPath(ui,"Image_right")
	self.Panel_item = TFDirector:getChildByPath(ui,"Panel_item")
	
    self.Image_redPoint:setVisible(MaokaActivityMgr:checkCatRecruitRedPoint())
	self:updateContent()
end

function MaokaCatteryView:updateContent( ... )
	-- body
	self.Label_value:setTextById(13316714,MaokaActivityMgr:getCatTotalSpeed())

	local catCfgs = TabDataMgr:getData("CatList")
	local catList = table.keys(catCfgs)

	table.sort(catList, function (v1,v2)
		-- body
		local have1 = MaokaActivityMgr:getCatInfo(v1) and true or false
		local have2 = MaokaActivityMgr:getCatInfo(v2) and true or false
		if have1 == have2 then 
			return v1 < v2 
		else
			return have1
		end
	end)

	for k,v in pairs(catList) do
		local item = self.uiList_cat:getItem(k)
		if not item then
			item = self.Panel_item:clone()
			self.uiList_cat:pushBackCustomItem(item)
		end
		local cfg = catCfgs[v]
		self:updateItem(item, cfg)
	end
	local ownNum = #MaokaActivityMgr:getCatInfo()
	self.Label_total:setText(ownNum.."/"..#catList)
end

function MaokaCatteryView:updateItem( item, catCfg )
	-- body
	local Panel_have = TFDirector:getChildByPath(item,"Panel_have")
	local Panel_nohave = TFDirector:getChildByPath(item,"Panel_nohave")
	local Label_name = TFDirector:getChildByPath(item,"Label_name")
	local Label_value = TFDirector:getChildByPath(item,"Label_value")
	local Image_working = TFDirector:getChildByPath(item,"Image_working")
	local Image_adventure = TFDirector:getChildByPath(item,"Image_adventure")
	local Image_noHave = TFDirector:getChildByPath(item,"Image_noHave")
	local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
	
	local data = MaokaActivityMgr:getCatInfo(catCfg.id)


	local level = data and data.level or 1
	Label_name:setTextById(catCfg.nameTextId)
	Image_icon:setTexture(catCfg.picture)
	Label_value:setTextById(13316714, catCfg.turnoverAdd[level] )

	Image_working:setVisible(data and data.taskId == 0)
	Image_adventure:setVisible(data and data.taskId ~= 0)
	Image_noHave:setVisible(not data)
	Panel_have:setVisible(data)
	Panel_nohave:setVisible(not data)
	if data then
		local LoadingBar_exp = TFDirector:getChildByPath(Panel_have,"LoadingBar_exp")
		local Button_food = TFDirector:getChildByPath(Panel_have,"Button_food")
		local Label_attr1 = TFDirector:getChildByPath(Panel_have,"Label_attr1")
		local Label_attr2 = TFDirector:getChildByPath(Panel_have,"Label_attr2")
		local Label_level = TFDirector:getChildByPath(Panel_have,"Label_level")
		local Image_addIcon = TFDirector:getChildByPath(Panel_have,"Image_addIcon")
		local Label_upValue = TFDirector:getChildByPath(Panel_have,"Label_upValue")
		
		Label_level:setText("Lv."..level)
		Label_attr1:setTextById(catCfg.des1, catCfg.attribute[level][2])	
		Label_attr2:setTextById(catCfg.des3,catCfg.attribute[level][1])
		Label_upValue:setTextById(13316715, MaokaActivityMgr:getToyAddValue())

		if level >= catCfg.maxLevel then
			LoadingBar_exp:setPercent(100)
		else
			LoadingBar_exp:setPercent(data.exp*100/catCfg.exp[level])
		end

		local toyInfo = MaokaActivityMgr:getToyInfo()
		for i = 1,5 do
			local toyIcon = TFDirector:getChildByPath(item,"Image_toy"..i)
			local id = toyInfo[i] and toyInfo[i].id or 0
			if id ~= 0 then
				toyIcon:show()
				toyIcon:setTexture(GoodsDataMgr:getItemCfg(id).icon)
			else
				toyIcon:hide()
			end
		end
		
		Button_food:onClick(function ( ... )
			-- body
			Utils:openView("activity.maoka.MaokaEatFoodTip",data.id)
		end)
	else
		local Label_des = TFDirector:getChildByPath(Panel_nohave,"Label_des")
		local Label_attr1 = TFDirector:getChildByPath(Panel_nohave,"Label_attr1")
		local Label_attr2 = TFDirector:getChildByPath(Panel_nohave,"Label_attr2")
		local Label_access = TFDirector:getChildByPath(Panel_nohave,"Label_access")
		Label_des:setTextById(catCfg.desTextId)
		Label_attr1:setTextById(catCfg.des1, catCfg.attribute[level][2])	
		Label_attr2:setTextById(catCfg.des3,catCfg.attribute[level][1])
		Label_access:setTextById(catCfg.getwayDes)
	end
end

function MaokaCatteryView:registerEvents( ... )
	self.super.registerEvents(self)
	self.Button_return:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)

	self.Button_get_cat:onClick(function ( ... )
		-- body
		local catList = MaokaActivityMgr:getCatInfo()
		if #catList >= table.count(TabDataMgr:getData("CatList")) then
			Utils:showTips(13316788)
			return 
		end
		Utils:openView("activity.maoka.MaokaCatRecruitView")
	end)

    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, function ( ... )
    	-- body
    	self.Image_redPoint:setVisible(MaokaActivityMgr:checkCatRecruitRedPoint())
    end)

	EventMgr:addEventListener(self, EV_MAOKA_ALLDATA_RSP, function ( activityId, extendData )
        -- body
        self:updateContent()
    end)
end
return MaokaCatteryView