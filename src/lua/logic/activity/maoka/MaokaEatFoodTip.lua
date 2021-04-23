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

local MaokaEatFoodTip = class("MaokaEatFoodTip",BaseLayer)

function MaokaEatFoodTip:ctor( catId )
	-- body
	self.super.ctor(self)
    self:showPopAnim(true)
	self.curCat = catId
	self.catInfo = MaokaActivityMgr:getCatInfo(self.curCat)
	self.catCfg = TabDataMgr:getData("CatList",self.curCat)
	self:init("lua.uiconfig.activity.eatFoodTip")
end

function MaokaEatFoodTip:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	self.Image_3 = TFDirector:getChildByPath(ui,"Image_3")
	self.Panel_right = TFDirector:getChildByPath(ui,"Panel_right")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	self.Button_touwei = TFDirector:getChildByPath(ui,"Button_touwei")
	self.Panel_item = TFDirector:getChildByPath(ui,"Panel_item")
	self:updateLeftPanel()
	self:updateRightPanel()
end

function MaokaEatFoodTip:removeEvents( ... )
	-- body
	self.super.removeEvents(self)
	self:removeTouweiTimer()
end

function MaokaEatFoodTip:removeTouweiTimer( ... )
	-- body
	if self.timerTouwei  then
		TFDirector:stopTimer(self.timerTouwei)
		TFDirector:removeTimer(self.timerTouwei)
		self.timerTouwei = nil
	end
end

function MaokaEatFoodTip:registerEvents( ... )
	self.super.registerEvents(self)
	-- body

	self.Button_close:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)

	-- body
	self.Button_touwei:onTouch(function(event)
		if event.name == "ended" then
			self:removeTouweiTimer()
	    end

	    if event.name == "began" then
			if not self:touweiTouchFunc() then
				print("====3333333333==========")
				if not self.timerTouwei then
					self.timerTouwei = TFDirector:addTimer(500,-1,nil,function ( ... )
						-- body
						self:touweiTouchFunc()
					end)
				end
			end
	    end
	end)

	EventMgr:addEventListener(self, EV_MAOKA_ALLDATA_RSP, function ( )
        -- body
        self.catInfo = MaokaActivityMgr:getCatInfo(self.curCat)
        self:updateLeftPanel()
        self:updateRightPanel()
    end)
end

function MaokaEatFoodTip:touweiTouchFunc( ... )
	-- body
	if not self.chooseId then
		Utils:showTips(13316786)
		self:removeTouweiTimer()
		return true
	end

	if self.catInfo.level >= self.catCfg.maxLevel then
		self:removeTouweiTimer()
		Utils:showTips(13316787)
		return true
	end

	if GoodsDataMgr:getItemCount(self.chooseId) <= 0 then
		self:removeTouweiTimer()
		Utils:showTips(13316888)
		return true
	end

	self.Spine_cat:play("special2",false)
	self.Spine_cat:addMEListener(TFARMATURE_COMPLETE, function(skeletonNode)
			skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
			self.Spine_cat:play("idle",true)
		end)
	local list = {}
	table.insert(list,{self.chooseId, 1})
	MaokaActivityMgr:SEND_ACTIVITY_REQ_CAT_UP_LEVEL(self.curCat,list)
end

function MaokaEatFoodTip:updateLeftPanel( ... )
	-- body
	if not self.initLeftPanel then
		self.initLeftPanel = true
		self.label_name = TFDirector:getChildByPath(self.Image_3,"Label_name")
		self.Spine_cat = TFDirector:getChildByPath(self.Image_3,"Spine_cat")
		self.Label_level = TFDirector:getChildByPath(self.Image_3,"Label_level")
		self.Label_exp = TFDirector:getChildByPath(self.Image_3,"Label_exp")
		self.LoadingBar_exp = TFDirector:getChildByPath(self.Image_3,"LoadingBar_exp")
		
		self.label_name:setTextById(self.catCfg.nameTextId)
		self.Spine_cat:setFile(self.catCfg.rolePath)
		self.Spine_cat:play("idle",true)
	end

	local level = self.catInfo.level
	self.Label_level:setText("Lv."..level)
	self.Label_exp:setText(self.catInfo.exp.."/"..self.catCfg.exp[level])

	if level >= self.catCfg.maxLevel then
		self.LoadingBar_exp:setPercent(100)
		self.Label_exp:setText("MAX")
	else
		self.LoadingBar_exp:setPercent(self.catInfo.exp*100/self.catCfg.exp[level])
	end
end

function MaokaEatFoodTip:updateRightPanel( ... )
	-- body
	if not self.initRightPanel then
		self.initRightPanel = true
		self.Label_des = TFDirector:getChildByPath(self.Panel_right,"Label_des")
		self.Label_attr1 = TFDirector:getChildByPath(self.Panel_right,"Label_attr1")
		self.Label_attr2 = TFDirector:getChildByPath(self.Panel_right,"Label_attr2")
		local ScrollView_list = TFDirector:getChildByPath(self.Panel_right,"ScrollView_list")

	    self.uiList_list = UIListView:create(ScrollView_list)
		self.uiList_list:setItemsMargin(20)
	end

	local level = self.catInfo.level
	self.Label_des:setTextById(self.catCfg.desTextId)
	self.Label_attr1:setTextById(self.catCfg.des2, self.catCfg.attribute[level][2], self.catCfg.turnoverAdd[level])
	self.Label_attr2:setTextById(self.catCfg.des4,self.catCfg.attribute[level][1])
	self:updateItemList()
end

function MaokaEatFoodTip:updateItemList( ... )
	-- body
	local  itemList = clone(self.catCfg.feedList) or {}
	
	local num = #itemList - #self.uiList_list:getItems()

	if num < 0 then
		for i = 1,math.abs(num) do
			self.uiList_list:removeItem(1)
		end
	end

	for k,v in ipairs(itemList) do
		local item = self.uiList_list:getItem(k)
		if not item then
			item = self.Panel_item:clone()
			self.uiList_list:pushBackCustomItem(item)
		end
		self:updateItem(item, v)
	end
end

function MaokaEatFoodTip:updateItem( item, data )
	-- body
	local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
	local Image_select = TFDirector:getChildByPath(item,"Image_select")
	local Label_num = TFDirector:getChildByPath(item,"Label_num")
	local Label_exp = TFDirector:getChildByPath(item,"Label_exp")
	
	local itemCfg = GoodsDataMgr:getItemCfg(data)

	Image_icon:setTexture(itemCfg.icon)
	Image_select:setVisible(self.chooseId == data)
	Label_num:setText("x"..GoodsDataMgr:getItemCount(data))
	Label_exp:setText("+"..itemCfg.useProfit.exp)

	Image_icon:setGrayEnabled(GoodsDataMgr:getItemCount(data) <= 0)
	item:setTouchEnabled(GoodsDataMgr:getItemCount(data) > 0)
	item:onClick(function ( ... )
		-- body
		if self.chooseId == data then return end

		self.chooseId = data
		self:updateItemList()
	end)
end
return MaokaEatFoodTip