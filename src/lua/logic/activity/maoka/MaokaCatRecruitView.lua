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

local MaokaCatRecruitView = class("MaokaCatRecruitView",BaseLayer)

function MaokaCatRecruitView:ctor( ... )
	-- body
	self.super.ctor(self,...)
	self:init("lua.uiconfig.activity.catRecruit")
end

function MaokaCatRecruitView:initUI( ui )
	-- body
	self.super.initUI(self,ui)

	self.Button_return = TFDirector:getChildByPath(ui,"Button_return")
	self.Button_recruit = TFDirector:getChildByPath(ui,"Button_recruit")
	self.Image_costIcon = TFDirector:getChildByPath(ui,"Image_costIcon")
	self.Label_costValue = TFDirector:getChildByPath(ui,"Label_costValue")
	self.Panel_left = TFDirector:getChildByPath(ui,"Panel_left")
	self.Panel_Recruiting = TFDirector:getChildByPath(ui,"Panel_Recruiting"):hide()
	self.Panel_fail = TFDirector:getChildByPath(ui,"Panel_fail"):hide()
	self.Panel_success = TFDirector:getChildByPath(ui,"Panel_success"):hide()
	self.Spine_ShowCat = TFDirector:getChildByPath(ui,"Spine_ShowCat")

	self.Panel_item = TFDirector:getChildByPath(ui,"Panel_item")


	local Image_4 = TFDirector:getChildByPath(ui,"Image_4")
	local Label_1 = TFDirector:getChildByPath(Image_4,"Label_1")
	local Label_2 = TFDirector:getChildByPath(Image_4,"Label_2")
	Label_1:setSkewX(10)
	Label_2:setSkewX(10)


	self:updateLeftPanel()
	self:updateRightRecruitingPanel()
	self:updateFailPanel()
end

function MaokaCatRecruitView:updateLeftPanel(  )
	-- body
	if not self.initLeftPanel then
		self.initLeftPanel = true
		self.Label_name = TFDirector:getChildByPath(self.Panel_left,"Label_name")
		self.Label_des = TFDirector:getChildByPath(self.Panel_left,"Label_des")
		self.Label_attr1 = TFDirector:getChildByPath(self.Panel_left,"Label_attr1")
		self.Label_attr2 = TFDirector:getChildByPath(self.Panel_left,"Label_attr2")
		self.Image_icon = TFDirector:getChildByPath(self.Panel_left,"Image_icon")
		local ScrollView_catList = TFDirector:getChildByPath(self.Panel_left,"ScrollView_catList")

		self.gridView_cat = UIGridView:create(ScrollView_catList)
		self.gridView_cat:setItemModel(self.Panel_item)
		self.gridView_cat:setColumn(4)
		self.gridView_cat:setColumnMargin(5)
	end
	local catList = TabDataMgr:getData("CatList")

	if not self.showCatList then
		self.showCatList = {}
		for k,v in pairs(catList) do
			if v.jackpot then
				table.insert( self.showCatList, v )
			end
		end
	end

	table.sort(self.showCatList,function ( obj1,obj2)
		-- body
		local isHave1 = MaokaActivityMgr:getCatInfo(obj1.id) and true
		local isHave2 = MaokaActivityMgr:getCatInfo(obj2.id) and true

		if isHave1 == isHave2 then
			return obj1.id < obj2.id
		else
			return isHave1
		end
	end)

	self.curCat = self.curCat or self.showCatList[1].id
	for k,v in ipairs(self.showCatList) do
		local item = self.gridView_cat:getItem(k)
		if not item then
			item = self.gridView_cat:pushBackDefaultItem()
		end

		self:updateItem(item, v)
	end

	local catCfg = catList[self.curCat]

	local catInfo = MaokaActivityMgr:getCatInfo(self.curCat)
	local level = catInfo and catInfo.level or 1
	self.Label_name:setTextById(catCfg.nameTextId)
	self.Image_icon:setTexture(catCfg.icon)
	self.Label_des:setTextById(catCfg.desTextId)
	self.Label_attr1:setTextById(catCfg.des2, catCfg.attribute[level][2],catCfg.turnoverAdd[level])
	self.Label_attr2:setTextById(catCfg.des4,catCfg.attribute[level][1])

	self.Spine_ShowCat:setFile(catCfg.rolePath)
	self.Spine_ShowCat:play("special1",true)
end

function MaokaCatRecruitView:updateItem( item, data )
	-- body
	local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
	local Image_select = TFDirector:getChildByPath(item,"Image_select")
	local Label_name = TFDirector:getChildByPath(item,"Label_name")
	local Image_geted = TFDirector:getChildByPath(item,"Image_geted")
	
	Label_name:setTextById(data.nameTextId)
	Image_icon:setTexture(data.icon)
	Image_geted:setVisible(MaokaActivityMgr:getCatInfo(data.id))
	Image_select:setVisible(self.curCat == data.id)

	item:setTouchEnabled(true)
	item:onClick(function ( ... )
		-- body
		if self.curCat == data.id then return end
		self.curCat = data.id
		self:updateLeftPanel()
		self.Spine_ShowCat:show()
		self.Panel_success:hide()
		self.Panel_Recruiting:hide()
		self.Panel_fail:hide()
	end)
	local costId = MaokaActivityMgr:getRecruitCost()
	self.Image_costIcon:setTexture(GoodsDataMgr:getItemCfg(costId).icon)

	self.Image_costIcon:setTouchEnabled(true)
	self.Image_costIcon:onClick(function ( ... )
		-- body
		Utils:showInfo(costId)
	end)
	self.Label_costValue:setText(GoodsDataMgr:getItemCount(costId))
end

function MaokaCatRecruitView:registerEvents( ... )
	self.super.registerEvents(self)
	-- body
	self.Button_return:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)

	self.Button_recruit:onClick(function ( ... )
		-- body
		local costId = MaokaActivityMgr:getRecruitCost()
		if GoodsDataMgr:getItemCount(costId) <= 0 then
			Utils:showTips(13316789)
			return 
		end
		MaokaActivityMgr:SEND_ACTIVITY_REQ_CAT_RECRUIT()
	end)

	EventMgr:addEventListener(self, EV_MAOKA_ALLDATA_RSP, function ( activityId, extendData )
        -- body
        self:updateLeftPanel()
    end)

	EventMgr:addEventListener(self, EV_MAOKA_RECRUIT_RSP, function ( rewards )
        -- body
        self.recruitCatId = rewards[1].id
        self.Panel_Recruiting:show()
        self.Panel_fail:hide()
        self.Spine_ShowCat:hide()
        self.Panel_success:show()
        self:updateSuccessPanel()
        self.showPanelImage:hide()
        self.Spine_cat:play("doumaobang1",false)
		self.Spine_cat:addMEListener(TFARMATURE_COMPLETE, function(skeletonNode)
				self.Spine_cat:removeMEListener(TFARMATURE_COMPLETE)
        		self.showPanelImage:show()
        		self.Panel_Recruiting:hide()
				self.Spine_cat:play("idle",true)
				self.ui:runAnimation("Action0",1)
				self.curCat = self.recruitCatId
				self:updateLeftPanel()
			end)
    end)

end

function MaokaCatRecruitView:updateRightRecruitingPanel(  )
	-- body
	if not self.initRecruitingPanel then
		self.initRecruitingPanel = true
		self.Label_3 = TFDirector:getChildByPath(self.Panel_Recruiting,"Label_3")
		self.Label_4 = TFDirector:getChildByPath(self.Panel_Recruiting,"Label_4")
		self.Label_5 = TFDirector:getChildByPath(self.Panel_Recruiting,"Label_5")
	end
	
end

function MaokaCatRecruitView:updateFailPanel(  )
	-- body
	if not self.initFailPanel then
		self.initFailPanel = true
		self.Label_6 = TFDirector:getChildByPath(self.Panel_fail,"Label_6")
	end
	
end

function MaokaCatRecruitView:updateSuccessPanel(  )
	-- body
	if not self.initSuccessPanel then
		self.initSuccessPanel = true
		self.r_Label_name = TFDirector:getChildByPath(self.Panel_success,"Label_name")
		self.r_Label_des = TFDirector:getChildByPath(self.Panel_success,"Label_des")
		self.r_Label_attr1 = TFDirector:getChildByPath(self.Panel_success,"Label_attr1")
		self.r_Label_attr2 = TFDirector:getChildByPath(self.Panel_success,"Label_attr2")
		self.Spine_cat = TFDirector:getChildByPath(self.Panel_success,"Spine_cat")
		self.showPanelImage = TFDirector:getChildByPath(self.Panel_success,"Image_6")
	end
	
	local catId = self.recruitCatId
	local catCfg = TabDataMgr:getData("CatList",catId)

	local catInfo = MaokaActivityMgr:getCatInfo(catId)
	local level = catInfo and catInfo.level or 1
	self.r_Label_name:setTextById(catCfg.nameTextId)
	self.Spine_cat:setFile(catCfg.rolePath)
	self.r_Label_des:setTextById(catCfg.desTextId)
	self.r_Label_attr1:setTextById(catCfg.des2, catCfg.attribute[level][2], catCfg.turnoverAdd[level])
	self.r_Label_attr2:setTextById(catCfg.des4,catCfg.attribute[level][1])

end
return MaokaCatRecruitView