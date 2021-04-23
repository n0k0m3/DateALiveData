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

local MaokaFormulaMakeView = class("MaokaFormulaMakeView",BaseLayer)

function MaokaFormulaMakeView:ctor( formulaId, etime)
	-- body
	self.super.ctor(self)
	self.formulaId = formulaId
	self.etime = etime
	self:resetData()
	self:init("lua.uiconfig.activity.formulaMake")
end

function MaokaFormulaMakeView:resetData( ... )
	-- body
	self.chooseMeterials = { 0,0,0,0 }
	self.selectPos = 1
	self:initMeterialList()
end

function MaokaFormulaMakeView:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	self.Image_right = TFDirector:getChildByPath(ui,"Image_right")
	self.Image_make = TFDirector:getChildByPath(ui,"Image_make")
	self.Panel_urgence = TFDirector:getChildByPath(ui,"Panel_urgence")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	self.Panel_item = TFDirector:getChildByPath(ui,"Panel_item")
	self.Panel_tab = TFDirector:getChildByPath(ui,"Panel_tab")
    self.Button_help = TFDirector:getChildByPath(ui, "Button_help")

	self:updateMakePanel()
	self:updateRightPanel()
	if self.formulaId and self.etime then
		self:updateUrgencePanel()
		self.Panel_urgence:show()
	else
		self.Panel_urgence:hide()
	end
end

function MaokaFormulaMakeView:registerEvents( ... )
	self.super.registerEvents(self)
	-- body

	self.Button_close:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)

    self.Button_help:onClick(function ( ... )
        -- body
        MaokaActivityMgr:showFormulaHelpView( )
    end)
    
	EventMgr:addEventListener(self, EV_MAOKA_MAKE_RSP,function(resultData)
	    	-- body
	    if resultData.rewards then

    		if self.formulaId and self.etime then
				AlertManager:closeLayer(self)
				Utils:showReward(resultData.rewards)
				return
			end

	    	local rewardId = resultData.rewards[1].id
	    	if resultData.success and resultData.formulaId == rewardId then
	    		local formulaCfg = TabDataMgr:getData("CatFormula",resultData.formulaId)
	    		self.Spine_effect:show()
	    		self.Spine_effect:play(formulaCfg.actionName,false)
				self.Spine_effect:addMEListener(TFARMATURE_COMPLETE, function(skeletonNode)
					self.Spine_effect:removeMEListener(TFARMATURE_COMPLETE)
	    			self.Spine_effect:hide()
    				Utils:openView("activity.maoka.MaokaComposeSuccessTip",resultData.rewards)
					self:resetData()
					self:updateMakePanel()
					self:updateRightPanel()
				end)
	    	elseif not resultData.success then
				self:resetData()
				self:updateMakePanel()
				self:updateRightPanel()
	    		Utils:openView("activity.maoka.MaokaComposeFailTip",resultData.rewards)
	    	else
				self:resetData()
				self:updateMakePanel()
				self:updateRightPanel()
	    		Utils:openView("activity.maoka.MaokaComposeRepeatTip",resultData.rewards)
	    	end
	    else
	    	Utils:showTips(13316849)
	    end
    end)

	self.Button_make:onClick(function ( ... )
		local list = {}
		for k,v in ipairs(self.chooseMeterials) do
			if v ~= 0 then
				list[v] = list[v] or 1
				list[v] = list[v] + 1
			end
		end

		if table.count(list) < 4 then
			Utils:showTips(13316790)
			return 
		end
		local msg = {}
		for k,v in pairs(list) do
			table.insert(msg,{k,v})
		end

		if self.formulaId and self.etime then
			MaokaActivityMgr:SEND_ACTIVITY_REQ_SPECIAL_MAKE_FORMULA(msg)
		else
			MaokaActivityMgr:SEND_ACTIVITY_REQ_MAKE_FORMULA(msg)
		end
	end)
    
	if self.formulaId and self.etime then
		self.timer = TFDirector:addTimer(1000,-1,nil,function ( ... )
			-- body
			self:onCountPer()
		end)
		self:onCountPer()
	end
end

function MaokaFormulaMakeView:onCountPer( ... )
	-- body
	if self.etime == ServerDataMgr:getServerTime() then
		local list = {}
		for k,v in ipairs(self.chooseMeterials) do
			list[v] = list[v] or 1
			list[v] = list[v] + 1
		end
		local msg = {}
		for k,v in pairs(list) do
			table.insert(msg,{k,v})
		end
		Utils:showTips(13316856)
		MaokaActivityMgr:SEND_ACTIVITY_REQ_SPECIAL_MAKE_FORMULA(msg)
		return
	end
	self.Label_time:setText(Utils:getTimeCountDownString(self.etime,2))
end

function MaokaFormulaMakeView:removeEvents( ... )
	-- body
	self.super.removeEvents(self)
	if self.timer then
		TFDirector:stopTimer(self.timer)
		TFDirector:removeTimer(self.timer)
		self.timer = nil
	end
end

function MaokaFormulaMakeView:initMeterialList( ... )
	-- body
	local meterialIds = MaokaActivityMgr:getMeterialList()
	local meterialList = {}
	for k,v in ipairs(meterialIds) do
		if GoodsDataMgr:getItemCount(v) > 0 then
			meterialList[v] = GoodsDataMgr:getItemCount(v)
		end
	end
	if self.formulaId then
		self.formulaCfg = TabDataMgr:getData("CatFormula",self.formulaId)
		meterialList = self.formulaCfg.materialList
	end
	self.showMeterialTab = {}
	for k,v in pairs(meterialList) do
		local itemCfg = GoodsDataMgr:getItemCfg(k)
		self.showMeterialTab[itemCfg.subType] = self.showMeterialTab[itemCfg.subType] or {}
		table.insert(self.showMeterialTab[itemCfg.subType],{id = k, num = v})
	end
end

function MaokaFormulaMakeView:updateRightPanel( ... )
	-- body
	if not self.initRightPanel then
		self.initRightPanel = true
		local ScrollView_tab = TFDirector:getChildByPath(self.Image_right,"ScrollView_tab")
		self.uiList_tab = UIListView:create(ScrollView_tab)
		self.uiList_tab:setItemsMargin(0)

		local ScrollView_list = TFDirector:getChildByPath(self.Image_right,"ScrollView_list")
		self.gridView_list = UIGridView:create(ScrollView_list)
		self.gridView_list:setItemModel(self.Panel_item)
		self.gridView_list:setColumn(4)
		self.gridView_list:setColumnMargin(15)
		self.gridView_list:setRowMargin(10)

		self.Button_make = TFDirector:getChildByPath(self.Image_right,"Button_make")
		self.Label_name = TFDirector:getChildByPath(self.Image_right,"Label_name")
		self.Label_des = TFDirector:getChildByPath(self.Image_right,"Label_des")
		self.Image_icon = TFDirector:getChildByPath(self.Image_right,"Image_icon")
	end

	self.showTabs = self.showTabs or table.keys(self.showMeterialTab)
	if #self.showTabs == 0 then self.showTabs = {11,12,13,14} end 
	self.curTab = self.curTab or self.showTabs[1]
	for i,v in ipairs(self.showTabs) do
		local item = self.uiList_tab:getItem(i)
		if not item then
			item = self.Panel_tab:clone()
			self.uiList_tab:pushBackCustomItem(item)
		end
		self:updateTabItem(item, v)
	end

	local meterialList = self.showMeterialTab[self.curTab] or {}

	local num = #meterialList - #self.gridView_list:getItems()

	if num < 0 then
		for i = 1,math.abs(num) do
			self.gridView_list:removeItem(1)
		end
	end

	for k,v in ipairs(meterialList) do
		local item = self.gridView_list:getItem(k)
		if not item then
			item = self.gridView_list:pushBackDefaultItem(item)
		end
		self:updateItem(item, v)
	end
	if not self.curItem then
		self.curItem = meterialList[1] and meterialList[1].id
	end
	if self.curItem then
		local itemCfg = GoodsDataMgr:getItemCfg(self.curItem)
		self.Label_name:setTextById(itemCfg.nameTextId)
		self.Label_des:setTextById(itemCfg.desTextId)
		self.Image_icon:setTexture(itemCfg.icon)
	else
		self.Label_name:hide()
		self.Label_des:hide()
		self.Image_icon:hide()
	end
end

function MaokaFormulaMakeView:updateMakePanel( ... )
	-- body
	if not self.initMakePanel then
		self.initMaketPanel = true
		self.Spine_effect = TFDirector:getChildByPath(self.ui,"Spine_effect"):hide()
		self.pos = {}
		for i = 1,4 do
			self.pos[i] = TFDirector:getChildByPath(self.Image_make,"Panel_pos"..i)
			self.pos[i].Image_add = TFDirector:getChildByPath(self.pos[i],"Image_add")
			self.pos[i].Image_icon = TFDirector:getChildByPath(self.pos[i],"Image_icon")
			self.pos[i].Image_select = TFDirector:getChildByPath(self.pos[i],"Image_select")
			self.pos[i]:setTouchEnabled(true)
			self.pos[i]:onClick(function ( ... )
				-- body
				if self.selectPos == i then
					return
				end
				self.selectPos = i
				self:updateMakePanel()
				if self.chooseMeterials[i] > 0 then
					self.curItem = self.chooseMeterials[i]
					self:updateRightPanel()
				end
			end)
		end
	end
	self.selectPos = self.selectPos or 1
	for i, v in ipairs(self.pos) do
		self.pos[i].Image_add:setVisible(self.chooseMeterials[i] == 0)
		self.pos[i].Image_icon:setVisible(self.chooseMeterials[i] ~= 0)
		self.pos[i].Image_select:setVisible(self.selectPos == i)

		if self.chooseMeterials[i] ~= 0 then
			self.pos[i].Image_icon:setTexture(GoodsDataMgr:getItemCfg(self.chooseMeterials[i]).icon)
		end
	end
end

function MaokaFormulaMakeView:updateUrgencePanel( ... )
	-- body
	if not self.initUrgencePanel then
		self.initUrgencePanel = true
		self.Label_target = TFDirector:getChildByPath(self.Panel_urgence,"Label_target")
		self.Label_name_ = TFDirector:getChildByPath(self.Panel_urgence,"Label_name")
		self.Label_time = TFDirector:getChildByPath(self.Panel_urgence,"Label_time")
	end

	self.Label_target:setTextById(self.formulaCfg.warningDes)
	self.Label_name_:setTextById(self.formulaCfg.nameTextId)
end

function MaokaFormulaMakeView:updateItem( item, data )
	-- body
	local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
	local Image_select = TFDirector:getChildByPath(item,"Image_select")
	local Label_num = TFDirector:getChildByPath(item,"Label_num")
	
	local itemCfg = GoodsDataMgr:getItemCfg(data.id)
	Image_icon:setTexture(itemCfg.icon)
	Image_select:hide()
	local subNum = 0
	for k,v in ipairs(self.chooseMeterials) do
		if v == data.id then
			subNum = subNum + 1
		end
	end

	Label_num:setText(data.num - subNum)

	item:setTouchEnabled(true)
	item:onClick(function ( ... )
		-- body
		self.curItem = data.id

		if table.find(self.chooseMeterials,data.id) ~= -1 then
			Utils:showTips(13316794)
			return 
		end

		self.chooseMeterials[self.selectPos] = data.id

		for k,v in ipairs(self.chooseMeterials) do
			if v == 0 then
				self.selectPos = k
				break
			end
		end
		self:updateRightPanel()
		self:updateMakePanel()
	end)
end

function MaokaFormulaMakeView:updateTabItem( item, data )
	-- body
	local Image_normal = TFDirector:getChildByPath(item,"Image_normal"):hide()
	local Image_select = TFDirector:getChildByPath(item,"Image_select"):hide()
	local isSelect = self.curTab == data

	local showNode = isSelect and Image_select or Image_normal
	showNode:show()
	local Label_name = TFDirector:getChildByPath(showNode,"Label_name")
	Label_name:setTextById(13316800+data)


	item:setTouchEnabled(true)
	item:onClick(function ( ... )
		if self.curTab == data then return end
		self.curTab = data
		self:updateRightPanel()
	end)
end

return MaokaFormulaMakeView