local SnowDayMemoryLevel = class("SnowDayMemoryLevel", BaseLayer)
local ResLoader = require("lua.logic.battle.ResLoader")

local eZorder = {
	Icon=1,
	Bright=2,
	CG=3,
	Lock=4,
	SpineDown=5,
	SpineUp=6,
}
function SnowDayMemoryLevel:ctor(...)
	self.super.ctor(self)
	--self:showPopAnim(true)

	self:initData(...)
	self:init("lua.uiconfig.activity.snowMemoryContent")
end

function SnowDayMemoryLevel:initData(activityId)
	self.activityId = activityId
	self.activityData = ActivityDataMgr2:getActivityInfo(activityId)
	--rpindump(self.activityData)

	self.curTab = nil
	self.snowBookData = ActivityDataMgr2:getSnowBookData()

	self.snowBuffInfo = ActivityDataMgr2:getSnowBuffInfo()


	self.unlockNum = {0,0,0}
end

function SnowDayMemoryLevel:initUI(ui)
	self.super.initUI(self, ui)	

	self.Button_Collection = TFDirector:getChildByPath(self.ui,"Button_Collection")
	self.Button_Collection:onClick(function()
		self.activityData.extendData.jumpParamters = self.activityData.extendData.jumpParamters or {}
		CollectDataMgr:readyOwnCollect()
		FunctionDataMgr:enterByFuncId(self.activityData.extendData.jumpInterface, self.activityData.extendData.jumpParamters[1])
	end)

	self.Panel_Help = TFDirector:getChildByPath(self.ui,"Panel_Help"):show()
	self.Panel_Help:setSwallowTouch(false)
	self.Panel_Help:addMEListener(TFWIDGET_CLICK,function()
		self.tipsBg:hide()
	end)
	self.Label_Name = TFDirector:getChildByPath(self.Panel_Help,"Label_Name")
	self.Label_Name:setText("")
	TFDirector:getChildByPath(self.Panel_Help,"content"):setTextById(13202306, self.snowBuffInfo["snowFesMemoryLv"] or 1)
	
	self.tipsBg = TFDirector:getChildByPath(self.Panel_Help,"tipsBg"):hide()
	self.tipsBg.content = TFDirector:getChildByPath(self.tipsBg,"content")

	self.Button_help = TFDirector:getChildByPath(self.Panel_Help,"Button_help")
	self.Button_help:onClick(function()
		self.tipsBg:setVisible(not self.tipsBg:isVisible())
	end)

	self.MainMemoryIconPrefab = TFDirector:getChildByPath(self.ui,"MainMemoryIconPrefab"):hide()

	self:initTab()
	self:initLevel()
end

function SnowDayMemoryLevel:initTab()
	local Panel_tab = TFDirector:getChildByPath(self.ui,"Panel_tab")
	self.tabArr = {}
	for i=1,3 do
		local tab = TFDirector:getChildByPath(Panel_tab,"tab_".. i):hide()
		tab.idx = i		
		tab.data = self.activityData.extendData["episodeGroup"][tostring(i)]
		tab.uiIdx = tonumber(tab.data.ui)
		tab.selectImg = TFDirector:getChildByPath(tab,"Image_select"):hide()
		tab.panel_lab = TFDirector:getChildByPath(tab,"panel_lab"):show()
		TFDirector:getChildByPath(tab.panel_lab,"Label"):show():setText(tab.data.title1)
		TFDirector:getChildByPath(tab.selectImg,"Label"):show():setText(tab.data.title1)
		TFDirector:getChildByPath(tab.panel_lab,"Label_Right"):show():setText(tab.data.title2)
		TFDirector:getChildByPath(tab.selectImg,"Label_Right"):show():setText(tab.data.title2)
		
		tab:setTouchEnabled(true)
		tab:addMEListener(TFWIDGET_CLICK, function(widget)
			self:selectTab(widget)
		end)
		
		table.insert(self.tabArr, tab)
	end
end

function SnowDayMemoryLevel:showLevel()
	self:selectTab(self.curTab or self.tabArr[1])
	--self:updateLevels()	
end

function SnowDayMemoryLevel:selectTab(widget)
	if self.curTab == widget then
		return
	end
	if self.curTab then
		self.levelArr[self.curTab.uiIdx].scrollView:hide()		
		self.curTab.selectImg:hide()
		self.curTab.panel_lab:show()
	end
	widget.selectImg:show()
	widget.panel_lab:hide()

	local scrollView = self.levelArr[widget.uiIdx].scrollView:show()	
	self:fadeAction(scrollView, .5, 255, 0)

	self.curTab = widget

	self:focusPos()

--	if self.levelArr[self.curTab.uiIdx].init == false then
--		self:updateLevels()
--	end
	self:updateLevels()

	self.Label_Name:setTextById(13202305,  self.unlockNum[self.curTab.uiIdx] or 0, self.snowBuffInfo["snowFesMemoryNum"] or 0)
end

function SnowDayMemoryLevel:focusPos()	
	local targetNode
	local snowFocusData = ActivityDataMgr2:getSnowFocusLoaction() or {}
	snowFocusData = snowFocusData[self.curTab.uiIdx]
	print(snowFocusData)
	if snowFocusData then
		local nodeArr = self.levelArr[self.curTab.uiIdx].Group
		for k,v in pairs(nodeArr) do
			local node = v

			if snowFocusData.itemId == node.cfg_Id then
				targetNode = node
				break;
			end
		end
	end

	local scrollView = self.levelArr[self.curTab.uiIdx].scrollView
	if targetNode then
		local tab = self.tabArr[targetNode.uiIdx]
		local levelRoot = self.levelArr[targetNode.uiIdx].Node
		if tab and tab == self.curTab  then
			local pos = targetNode:getPosition()
			local size = levelRoot:getSize()
			local xpercent = ( math.max(pos.x - 200, 0))/size.width * 100
			local ypercent = ( math.min(pos.y - 100, size.height)) /size.height * 100
			
			scrollView:scrollToPercentBothDirection(ccp(xpercent, 100-ypercent), 0.5, false)				
		end
	else
		scrollView:jumpToPercentBothDirection(ccp(50,50))
	end
end

function SnowDayMemoryLevel:initLevel()
	self.levelArr = {}
	
	for i=1,3 do
		local Memory_list = TFDirector:getChildByPath(self.ui,"Memory_list" .. i):hide()	
		--Memory_list:setClippingEnabled(true)
		local LevelNode = TFDirector:getChildByPath(Memory_list,"Panel_Level")
		LevelNode.idx = i
			
		self.levelArr[i] = {Node=LevelNode, Group={}, init = false, scrollView=Memory_list}
		local children = LevelNode:getChildren()
		for k,node in ipairs(children) do
			node.uiIdx = i
			
			self:initLevelNode(node)			
			table.insert(self.levelArr[i].Group, node)
		end
	end

	--self:updateLevels()
end

function SnowDayMemoryLevel:initLevelNode(node)
	local UIEditorData = node.UIEditorData or {}
	node.cfg_Id = tonumber(UIEditorData["cfg_Id"] or 0)
	node.link = TFDirector:getChildByPath(node,"link")		

end

function SnowDayMemoryLevel:fadeAction(node, duaration, opacityTo, opacityFrom)
	node:stopAllActions()
	if opacityFrom then
		node:setOpacity(opacityFrom)
	end	
	node:runAction(FadeTo:create(duaration, opacityTo))
end

function SnowDayMemoryLevel:updateLevels()
	
	local count = 0
	local Group = self.levelArr[self.curTab.uiIdx].Group	
	for _, node in ipairs(Group) do
		local itemInfo = ActivityDataMgr2:getItemInfo(self.activityData.activityType, node.cfg_Id)
		print(itemInfo.extendData.group)
		node.itemInfo = itemInfo
		if itemInfo then
			local path = itemInfo.extendData.lineUnlock or ""
			local progressInfo = ActivityDataMgr2:getProgressInfoWithoutDefault(self.activityData.activityType, itemInfo.id)
			if progressInfo then
				if progressInfo.status ~= EC_TaskStatus.GETED then					
					if node.Icon == nil then		
						local IconSpineDown, IconSpineUp												
						if itemInfo.extendData["uiType"] == 1 then	--小型回忆
							node.Icon = TFImage:create("ui/activity/2020SnowDay/memory/smallMemory.png")						
						elseif itemInfo.extendData["uiType"] == 2 then	--大型回忆
							node.Icon = TFImage:create("ui/activity/2020SnowDay/memory/largeMemory.png")
						else
							node.Icon = TFImage:create("ui/activity/2020SnowDay/memory/mainMemory.png")
						end
						node.Icon:setPosition(ccp(0,0))
						node.Icon:setZOrder(eZorder.Icon)
						node:addChild(node.Icon)																
					end
					node.Icon:show()

					if node.Icon_Lock then
						node.Icon_Lock:hide()
					end	

					if node.Icon_Bright then
						node.Icon_Bright:hide()
					end

					if node.link then
						path = string.gsub(path,".png","_1.png")
						node.link:setTexture(path)
					end

					if node.IconSpineDown == nil then
						local IconSpineDown, IconSpineUp												
						if itemInfo.extendData["uiType"] == 1 then	--小型回忆					
							IconSpineDown = ResLoader.createSpine("effect/activity_snowFes/snowFes_memory_s/snowFes_memory_s")		
							IconSpineDown:play("snowFes_memory_s_down",true)			

							IconSpineUp = IconSpineDown:clone()	
							IconSpineUp:play("snowFes_memory_s_up",true)		
							IconSpineUp:setPosition(ccp(-2,3))		
							
							
						elseif itemInfo.extendData["uiType"] == 2 then	--大型回忆
							IconSpineDown = ResLoader.createSpine("effect/activity_snowFes/snowFes_memory_l/snowFes_memory_l")
							IconSpineDown:play("snowFes_memory_l_down",true)	

							IconSpineUp = IconSpineDown:clone()	
							IconSpineUp:play("snowFes_memory_l_up",true)	
							IconSpineUp:setPosition(ccp(0,2))
						else
							IconSpineDown = ResLoader.createSpine("effect/activity_snowFes/snowFes_memory_m/snowFes_memory_m")
							IconSpineDown:play("snowFes_memory_m_down",true)	

							IconSpineUp = IconSpineDown:clone()	
							IconSpineUp:play("snowFes_memory_m_up",true)
							IconSpineUp:setPosition(ccp(0,3))
						end	
																				
						IconSpineDown:setZOrder(eZorder.SpineDown)
						node.IconSpineDown = IconSpineDown		
						node:addChild(IconSpineDown)

						IconSpineUp:setScale(1.0)
						IconSpineUp:setZOrder(eZorder.SpineUp)
						node:addChild(IconSpineUp)	
						node.IconSpineUp = IconSpineUp						
					end
					node.IconSpineDown:show()
					node.IconSpineUp:show()

					if itemInfo.extendData["uiType"] == 3 then	--主要回忆
						if node.mainCG == nil then
							node.mainCG = self.MainMemoryIconPrefab:clone():show()
							node.mainCG:setZOrder(eZorder.CG)
							node.mainCG:setPosition(ccp(0,0))
							node:addChild(node.mainCG)
							TFDirector:getChildByPath(node.mainCG,"HeadIcon"):setTexture(itemInfo.extendData.bgShow or "")
						end
						node.mainCG:show()
					end

				else
					if node.Icon then
						node.Icon:hide()
					end
					if node.IconSpineDown then
						node.IconSpineDown:hide()
						node.IconSpineDown:runAction(RemoveSelf:create())
						node.IconSpineDown = nil
					end
					if node.IconSpineUp then
						node.IconSpineUp:hide()
						node.IconSpineUp:runAction(RemoveSelf:create())
						node.IconSpineUp = nil
					end

					if node.Icon_Lock then
						node.Icon_Lock:hide()
					end

					if node.Icon_Bright == nil then
						if itemInfo.extendData["uiType"] == 1 then	--小型回忆								
							node.Icon_Bright = TFImage:create("ui/activity/2020SnowDay/memory/smallMemoryBright.png")
							self.unlockNum[self.curTab.uiIdx] = self.unlockNum[self.curTab.uiIdx] + 1
							
						elseif itemInfo.extendData["uiType"] == 2 then	--大型回忆
							node.Icon_Bright = TFImage:create("ui/activity/2020SnowDay/memory/largeMemoryBright.png")
							node.Icon_Bright:setPosition(ccp(0,-1))	
						else
							node.Icon_Bright = TFImage:create("ui/activity/2020SnowDay/memory/mainMemoryBright.png")
							node.Icon_Bright:setPosition(ccp(5,-8))	
						end
						
						node.Icon_Bright:setZOrder(eZorder.Bright)
						node:addChild(node.Icon_Bright)
					end	

					node.Icon_Bright:show()

					if node.link then
						--path = string.gsub(path,".png","_1.png")
						node.link:setTexture(path)
					end

					if itemInfo.extendData["uiType"] == 3 then	--主要回忆
						if node.mainCG == nil then
							node.mainCG = self.MainMemoryIconPrefab:clone():show()
							node.mainCG:setZOrder(eZorder.CG)
							node.mainCG:setPosition(ccp(0,0))
							node:addChild(node.mainCG)
							TFDirector:getChildByPath(node.mainCG,"HeadIcon"):setTexture(itemInfo.extendData.bgShow or "")
						end
						node.mainCG:show()
					end
				end	
			else
				if node.Icon_Bright then
					node.Icon_Bright:hide()
				end

				if node.Icon_Lock == nil then						
					if itemInfo.extendData["uiType"] == 1 then	--小型回忆								
						node.Icon_Lock = TFImage:create("ui/activity/2020SnowDay/memory/smallMemoryLock.png")
					elseif itemInfo.extendData["uiType"] == 2 then	--大型回忆
						node.Icon_Lock = TFImage:create("ui/activity/2020SnowDay/memory/largeMemoryLock.png")
					else
						node.Icon_Lock = TFImage:create("ui/activity/2020SnowDay/memory/mainMemoryLock.png")
					end
					node.Icon_Lock:setZOrder(eZorder.Lock)
					node.Icon_Lock:setPosition(ccp(0,0))
					node:addChild(node.Icon_Lock)												
				end

				if node.Icon == nil then						
					if itemInfo.extendData["uiType"] == 1 then	--小型回忆								
						node.Icon = TFImage:create("ui/activity/2020SnowDay/memory/smallMemory.png")
					elseif itemInfo.extendData["uiType"] == 2 then	--大型回忆
						node.Icon = TFImage:create("ui/activity/2020SnowDay/memory/largeMemory.png")
					else
						node.Icon = TFImage:create("ui/activity/2020SnowDay/memory/mainMemory.png")
					end
					node.Icon:setZOrder(eZorder.Icon)
					node.Icon:setPosition(ccp(0,0))
					node:addChild(node.Icon)												
				end
				node.Icon:show()


				if node.link then
					path = string.gsub(path,".png","_1.png")
					node.link:setTexture(path)
				end	

				if itemInfo.extendData["uiType"] == 3 then	--主要回忆
					if node.mainCG == nil then
						node.mainCG = self.MainMemoryIconPrefab:clone():show()
						node.mainCG:setZOrder(eZorder.CG)
						node.mainCG:setPosition(ccp(0,0))
						node:addChild(node.mainCG)
						TFDirector:getChildByPath(node.mainCG,"HeadIcon"):setTexture(itemInfo.extendData.bgShow or "")
					end
					node.mainCG:show()
				end			
			end
			if node.touch == nil then
				local size
				if node.Icon then
					size = node.Icon:getContentSize()
				end
				if node.Icon_Lock then
					size = node.Icon_Lock:getContentSize()
				end
				if node.Icon_Bright then
					size = node.Icon_Bright:getContentSize()
				end
				
				node.touch = TFPanel:create():show()
				node.touch:setColor(ccBLACK)
				node.touch:setContentSize(size)
				node.touch:setAnchorPoint(ccp(0.5,0.5))
				node.touch:setZOrder(999)
				node.touch:setTouchEnabled(true)
				node.touch:addMEListener(TFWIDGET_CLICK, function(widget)
					Utils:openView("activity.SnowDay.SnowDayMemoryDetail",self.activityId, node.cfg_Id)
				end)
				node:addChild(node.touch)
			end	
	
			if me.platform == "win32" then				
				local idText = TFLabel:create()
				idText:setFontSize(18)
				idText:setPosition(ccp(0, 0))
				idText:setAnchorPoint(ccp(0.5, 0.5))
				idText:setFontColor(ccc3(255, 255, 255))
				idText:enableStroke(ccc3(0, 0, 0), 1)
				idText:setZOrder(998)
				idText:setText(node.cfg_Id)
				node:addChild(idText)
			end		
		else
			
		end
	end

	self.levelArr[self.curTab.uiIdx].init = true

	for i=1,#self.tabArr do
		local tab = self.tabArr[i]
		local taskIds = tab.data.preTaskIds
		local meet = true
		for j=1,#taskIds do
--			local itemInfo = ActivityDataMgr2:getItemInfo(self.activityData.activityType, tonumber(taskIds[j]))
			local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityData.activityType, tonumber(taskIds[j]))
			if progressInfo.status ~= EC_TaskStatus.GETED then
				meet = false
				break;
			end
		end
		if meet then
			tab:show()
		else
			tab:hide()
		end
	end

	if self.curTab.uiIdx == 1 then
		self.Panel_Help:show()
		self.Label_Name:setTextById(13202305,  self.unlockNum[self.curTab.uiIdx] or 0, self.snowBuffInfo["snowFesMemoryNum"] or 0)
	else
		self.Panel_Help:hide()
	end
end

function SnowDayMemoryLevel:updateView()
	self:updateLevels()
end

function SnowDayMemoryLevel:onShow()
	self.super.onShow(self)
	self:runAction(Sequence:create({DelayTime:create(0.2), CallFunc:create(function()
		ActivityDataMgr2:sendSnowLevelFocus()
	end)}))
	
end

function SnowDayMemoryLevel:registerEvents()
	self.super.registerEvents(self)
	EventMgr:addEventListener(self, EV_ICE_SNOW_LEVEL_DETAIL, handler(self.updateView, self))
	EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ITEM_INFO, handler(self.updateView, self))
	EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.updateView, self))
	EventMgr:addEventListener(self, EV_ICE_SNOW_FOCUS_LOCATION, handler(self.showLevel, self))	
end

return SnowDayMemoryLevel