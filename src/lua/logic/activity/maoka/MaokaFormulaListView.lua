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

local MaokaFormulaListView = class("MaokaFormulaListView",BaseLayer)

function MaokaFormulaListView:ctor( formulaId )
	-- body
	self.super.ctor(self)
	self.curFormula = formulaId
	self:init("lua.uiconfig.activity.formulaList")
end

function MaokaFormulaListView:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	
	self.Button_return = TFDirector:getChildByPath(ui,"Button_return")
	self.Button_levelUp = TFDirector:getChildByPath(ui,"Button_levelUp")
    self.Button_help = TFDirector:getChildByPath(ui, "Button_help")

	self.Panel_levelUp = TFDirector:getChildByPath(ui,"Panel_levelUp")
	self.Panel_levelUp.Image_normal = TFDirector:getChildByPath(self.Panel_levelUp,"Image_normal")
	self.Panel_levelUp.Image_select = TFDirector:getChildByPath(self.Panel_levelUp,"Image_select")
	self.Panel_compose = TFDirector:getChildByPath(ui,"Panel_compose")
	self.Panel_compose.Image_normal = TFDirector:getChildByPath(self.Panel_compose,"Image_normal")
	self.Panel_compose.Image_select = TFDirector:getChildByPath(self.Panel_compose,"Image_select")

	self.Panel_item = TFDirector:getChildByPath(ui,"Panel_item")

	self.panel_right = TFDirector:getChildByPath(ui,"Image_2")

	local ScrollView_list = TFDirector:getChildByPath(ui,"ScrollView_list")
	self.gridView_list = UIGridView:create(ScrollView_list)
	self.gridView_list:setItemModel(self.Panel_item)
	self.gridView_list:setColumn(5)
	self.gridView_list:setColumnMargin(0)
	self.gridView_list:setRowMargin(0)
	self:updateContent()
end

function MaokaFormulaListView:removeEvents( ... )
	-- body
	self.super.removeEvents(self)
	self:removeLevelUpTimer()
end

function MaokaFormulaListView:removeLevelUpTimer( ... )
	-- body
	if self.timerLevelUp  then
		TFDirector:stopTimer(self.timerLevelUp)
		TFDirector:removeTimer(self.timerLevelUp)
		self.timerLevelUp = nil
	end
end

function MaokaFormulaListView:registerEvents( ... )
	self.super.registerEvents(self)
	-- body
	self.Button_return:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)

	self.Button_levelUp:onTouch(function(event)
		if event.name == "ended" then
			self:removeLevelUpTimer()
	    end

	    if event.name == "began" then
			if not self:levelUpTouchFunc() then
				if not self.timerLevelUp then
					self.timerLevelUp = TFDirector:addTimer(500,-1,nil,function ( ... )
						-- body
						self:levelUpTouchFunc()
					end)
				end
			end
	    end
	end)

	EventMgr:addEventListener(self, EV_MAOKA_ALLDATA_RSP, function ( )
        -- body
        self:updateContent()
    end)

	EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, function ( )
        -- body
        self:updateContent()
    end)

    self.Button_help:onClick(function ( ... )
        -- body
        MaokaActivityMgr:showFormulaHelpView( )
    end)
    

    self.Panel_compose:onClick(function ( ... )
    	-- body
    	Utils:openView("activity.maoka.MaokaFormulaMakeView")
    end)
end

function MaokaFormulaListView:levelUpTouchFunc( ... )
	-- body
	if not self.curFormula then
		self:removeLevelUpTimer()
		return true
	end

	local formulaInfo = MaokaActivityMgr:getFormulaInfo(self.curFormula)
	local formulaCfg = TabDataMgr:getData("CatFormula",self.curFormula)
	if not formulaInfo then
		Utils:showTips(13316792)
		self:removeLevelUpTimer()
		return true
	elseif formulaInfo.level >= formulaCfg.maxLevel then
		Utils:showTips(13316791)
		self:removeLevelUpTimer()
		return true
	end
	local costId = MaokaActivityMgr:getFormulaUpLevelCost()
	if GoodsDataMgr:getItemCount(costId) <= 0 then
		Utils:showTips(13316850)
		self:removeLevelUpTimer()
		return true
	end
	local list = {}
	table.insert(list,{MaokaActivityMgr:getFormulaUpLevelCost(), 1})
	MaokaActivityMgr:SEND_ACTIVITY_REQ_FORMULA_UP_LEVEL(self.curFormula,list)
end

function MaokaFormulaListView:updateContent( ... )
	-- body
	local catFormula = TabDataMgr:getData("CatFormula")

	if not self.showFormulaList then
		self.showFormulaList = {}
		for k,v in pairs(catFormula) do
			if not v.timeLimit then
				table.insert( self.showFormulaList, v )
			end
		end
	end

	table.sort(self.showFormulaList,function ( obj1,obj2)
		-- body
		local isHave1 = MaokaActivityMgr:getFormulaInfo(obj1.id) and true or false
		local isHave2 = MaokaActivityMgr:getFormulaInfo(obj2.id) and true or false

		if isHave1 == isHave2 then
			return obj1.id < obj2.id
		else
			return isHave1
		end
	end)

	self.curFormula = self.curFormula or self.showFormulaList[1].id

	local index = 0
	for k,v in pairs(self.showFormulaList) do
		index = index + 1
		local item = self.gridView_list:getItem(index)
		if not item then
			item = self.gridView_list:pushBackDefaultItem()
		end
		self:updateItem(item, v)
	end

	self:updateRightPanel()
end

function MaokaFormulaListView:updateItem( item, cfg)
	-- body
	local Image_normal = TFDirector:getChildByPath(item,"Image_normal"):hide()
	local Image_unlock = TFDirector:getChildByPath(item,"Image_unlock"):hide()
	local Image_select = TFDirector:getChildByPath(item,"Image_select")

	local formulaInfo = MaokaActivityMgr:getFormulaInfo(cfg.id)
	local showNode = formulaInfo and Image_normal or Image_unlock

	Image_select:setVisible(self.curFormula == cfg.id)
	showNode:show()
	local Image_icon = TFDirector:getChildByPath(showNode,"Image_icon")

	if formulaInfo then
		local level = formulaInfo.level
		local Label_up = TFDirector:getChildByPath(showNode,"Label_up")
		local Label_lv = TFDirector:getChildByPath(showNode,"Label_lv")

		Label_lv:setText("Lv."..formulaInfo.level)
		Label_up:setTextById(13316714,formulaInfo.num)
	end

	Image_icon:setTexture(cfg.icon)
	item:setTouchEnabled(true)

	item:onClick(function ( ... )
		-- body
		if self.curFormula == cfg.id then return end
		self.curFormula = cfg.id
		self:updateContent()
	end)
end

function MaokaFormulaListView:updateRightPanel( ... )
	-- body
	if not self.initRightPanel then
		self.initRightPanel = true
		self.Label_speed = TFDirector:getChildByPath(self.panel_right,"Label_speed")
		self.Label_name = TFDirector:getChildByPath(self.panel_right,"Label_name")
		self.Label_des = TFDirector:getChildByPath(self.panel_right,"Label_des")
		self.Label_num = TFDirector:getChildByPath(self.panel_right,"Label_num")
		self.Image_icon = TFDirector:getChildByPath(self.panel_right,"Image_icon")
		self.Image_costIcon = TFDirector:getChildByPath(self.panel_right,"Image_costIcon")	
		self.Image_exp = TFDirector:getChildByPath(self.panel_right,"Image_exp")
		self.LoadingBar_exp = TFDirector:getChildByPath(self.Image_exp,"LoadingBar_exp")
		self.Label_lv = TFDirector:getChildByPath(self.Image_exp,"Label_lv")

	end

	local formulaCfg = TabDataMgr:getData("CatFormula",self.curFormula)

	self.Label_name:setTextById(formulaCfg.nameTextId)
	self.Label_des:setTextById(formulaCfg.desTextId)
	self.Image_icon:setTexture(formulaCfg.icon)
	local costId = MaokaActivityMgr:getFormulaUpLevelCost()
	self.Image_costIcon:setTexture(GoodsDataMgr:getItemCfg(costId).icon)

	self.Image_costIcon:setTouchEnabled(true)
	self.Image_costIcon:onClick(function ( ... )
		-- body
		Utils:showInfo(costId)
	end)
	self.Label_num:setText(GoodsDataMgr:getItemCount(costId))
	self.Label_speed:setTextById(13316714,MaokaActivityMgr:getFormulaSpeed())

	local formulaInfo = MaokaActivityMgr:getFormulaInfo(self.curFormula)
	self.Image_exp:setVisible(formulaInfo)
	if formulaInfo then
		local level = formulaInfo.level
		if level >= formulaCfg.maxLevel then
			self.LoadingBar_exp:setPercent(100)
		else
			self.LoadingBar_exp:setPercent(formulaInfo.exp*100/formulaCfg.exp[level])
		end
		self.Label_lv:setText("Lv."..level)
	end
end

return MaokaFormulaListView