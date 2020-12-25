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
local CommandSkillView = class("CommandSkillView",BaseLayer)

function CommandSkillView:ctor( data )
	self.super.ctor(self,data)
	self:initData()
	self.roomType = ShipRoomType.COMMAND
	self.pageIndex = ExploreDataMgr:getPageIndex(self.roomType, "CommandSkillView")
	self:addTopBar()
	self:init("lua.uiconfig.explore.commandSkill")
end

function CommandSkillView:initData()
	local knowledgeList = TabDataMgr:getData("AfkKnowledge")
	self.styleTypes = {}
	for k, v in pairs(knowledgeList) do
		if v.showType then
			if table.indexOf(self.styleTypes, v.type) == -1 then
				table.insert(self.styleTypes, v.type)
			end
		end
	end

	table.sort(self.styleTypes, function(v1, v2)
		return v1 < v2
	end)

	self.selectType = self.styleTypes[1]
	for k,v in ipairs(self.styleTypes) do
		local isActivite = self:isCurSelectActive(v)
		if isActivite then
			self.selectType = v
		end
	end

	---用于判断哪个天赋是新解锁的
	self.record_ = {}
end

function CommandSkillView.checkStyleRedPoint( style )
	-- body
	local knowledgeList = TabDataMgr:getData("AfkKnowledge")
	for k, v in pairs(knowledgeList) do
		if v.type == style then
			if CommandSkillView.checkKnowledgeRedPoint(v) then
				return true
			end
		end
	end
	return false
end

function CommandSkillView.checkKnowledgeRedPoint( skillInfo )
	-- body
	return ExploreDataMgr:checkKnowledgeRedPoint(skillInfo)

end

function CommandSkillView:addTopBar()
	self.topBar = requireNew("lua.logic.explore.CommonTopBar"):new(self.roomType, self.pageIndex)
	self:addChild(self.topBar,100)
end

function CommandSkillView:initUI(ui)
	self.super.initUI(self,ui)

	self.Button_active = TFDirector:getChildByPath(ui,"Button_active")
	self.working = TFDirector:getChildByPath(ui,"working")
	self.notWorking = TFDirector:getChildByPath(ui,"notWorking")
	self.Label_process = TFDirector:getChildByPath(ui,"Label_process")
	self.Label_name = TFDirector:getChildByPath(ui,"Label_name")
	local ScrollView_style = TFDirector:getChildByPath(ui,"ScrollView_style")
	self.uiList_style = UIListView:create(ScrollView_style)
	self.uiList_style:setItemsMargin(15)

	self.Panel_skillMap = TFDirector:getChildByPath(ui,"Panel_skillMap")
	self.Panel_show = TFDirector:getChildByPath(ui,"Panel_show")
	self.Spine_effect = TFDirector:getChildByPath(ui,"Spine_effect"):hide()
	self.Spine_effect1 = TFDirector:getChildByPath(ui,"Spine_effect1"):hide()

	self.Panel_styleItem = TFDirector:getChildByPath(ui,"Panel_styleItem")
	self.Panel_skillMap1 = TFDirector:getChildByPath(ui,"Panel_skillMap1")
	self.Panel_skillMap2 = TFDirector:getChildByPath(ui,"Panel_skillMap2")
	self.Panel_skillMap3 = TFDirector:getChildByPath(ui,"Panel_skillMap3")
	self.Panel_skillItem = TFDirector:getChildByPath(ui,"Panel_skillItem")

	self.mapView = require("lua.public.ScrollAndZoomView"):new(self.Panel_skillMap:getContentSize(),self.Panel_skillMap1:getContentSize())
	self.Panel_skillMap:addChild(self.mapView)
    me.Director:setSingleEnabled(false)
	
	self:refreshView()
end

function CommandSkillView:onShow( ... )
	-- body
	self.super.onShow(self)
	if not self.hasPlayEffect then
		self.Panel_show:hide()
		self.topBar:hide()
		self.hasPlayEffect = true
		self.ui:timeOut(function ( ... )
			-- body
			self:playEffect( ... )
		end)
	end
	GameGuide:checkGuide(self)
end

function CommandSkillView:playEffect( ... )
	-- body
	self.Spine_effect:show()
	self.Spine_effect1:show()
	self.Spine_effect:addMEListener(TFARMATURE_EVENT,
            function()
            		self.Panel_show:show()
            		self.topBar:show()
					ViewAnimationHelper.doMoveFadeInAction(self.Panel_show, {direction = 1, distance = 0, ease = 2, delay = 0.1, time = 0.2})
               		self.topBar:showAnim()
               	end)



	self.Spine_effect:addMEListener(TFARMATURE_COMPLETE,
	            function()
						self.Spine_effect:removeMEListener(TFARMATURE_COMPLETE)
					end)
	self.Spine_effect:play("pingmu_xia",false)
	Utils:playSound(5053)

	self.Spine_effect1:addMEListener(TFARMATURE_COMPLETE,
	            function()
						self.Spine_effect1:removeMEListener(TFARMATURE_COMPLETE)
						self.Spine_effect1:hide()
					end)
	self.Spine_effect1:play("pingmu_shang",false)
end


function CommandSkillView:registerEvents(ui)
	self.super.registerEvents(self,ui)

	self.Button_active:onClick(function()
		ExploreDataMgr:SEND_EXPLORE_REQ_SET_SHAPE(self.selectType)
	end)

	EventMgr:addEventListener(self, EV_EXPLORE_UPGRADE_KNOWLEDGE, handler(self.updateGrade, self))
	EventMgr:addEventListener(self, EV_EXPLORE_SHIP_REFRESH, function ( ... )
		-- body
		self:updateStyleList()
		self:updateStyleState()
	end)
end

function CommandSkillView:refreshView(update)
	self:updateSkillMap(update)
	self:updateStyleList()
	self:updateStyleState()
end

function CommandSkillView:updateGrade()
	self:refreshView(true)
end

function CommandSkillView:updateStyleList()


	for i = 1, #self.styleTypes do
		local item = self.uiList_style:getItem(i)
		if not item then
			item = self.Panel_styleItem:clone()
			self.uiList_style:pushBackCustomItem(item)
			local Spine_effect = TFDirector:getChildByPath(item,"Spine_effect")
			Spine_effect:play("animation",true)
		end
		self:updateStyleItem(item, self.styleTypes[i])
	end
	self.uiList_style:setCenterArrange()

end

function CommandSkillView:updateStyleItem(item, type)
	local Image_select = TFDirector:getChildByPath(item,"Image_select")
	local Image_normal = TFDirector:getChildByPath(item,"Image_normal")
	local Image_flag = TFDirector:getChildByPath(item,"Image_flag")
	local Spine_effect = TFDirector:getChildByPath(item,"Spine_effect")
	local Image_redTip = TFDirector:getChildByPath(item,"Image_redTip")

	Image_select:setTexture("ui/explore/growup/command/skill/style_select_".. type ..".png")
	Image_normal:setTexture("ui/explore/growup/command/skill/style_normal_".. type ..".png")
	Image_flag:setTexture("ui/explore/growup/command/skill/style_flag_".. type ..".png")
	local isSelected = type == self.selectType
	Image_select:setVisible(isSelected)
	Image_normal:setVisible(not isSelected)
	local isActivite = self:isCurSelectActive(type)
	Image_flag:setVisible(isActivite)
	Spine_effect:setVisible(isSelected)

	Image_redTip:setVisible(CommandSkillView.checkStyleRedPoint(type))
	item:setTouchEnabled(true)
	item:onClick(function ( ... )
		if self.selectType == type then return end
		self.selectType = type
		self:refreshView()
	end)
end

function CommandSkillView:updateSkillMap(update)
	self.mapView:removeAllChildren()
	local model = self["Panel_skillMap"..self.selectType]
	self.mapView:SetInnerSize(self.Panel_skillMap1:getContentSize())
	self.curSkillMap = self.Panel_skillMap1:clone()

	self.curSkillMap:setPosition(ccp(0,0))
	self.mapView:addChild(self.curSkillMap)

	self:updateSkillMapContent(update)
	self:focusToCurSkill()
end

function CommandSkillView:focusToCurSkill( ... )
	-- body
	self.curSkillPos = self.curSkillPos or ccp(0,0)
	self.mapView:focus(self.curSkillPos)
end

function CommandSkillView:updateSkillMapContent(update)
	local skillLists = ExploreDataMgr:getKnowledgeList(self.selectType)
	local points = TFDirector:getChildByPath(self.curSkillMap,"Panel_points")
	local pointsList = points:getChildren()
	for k,v in pairs(pointsList) do
		if not v.item then
			local item = self.Panel_skillItem:clone()
			v:addChild(item)
			item:setPosition(ccp(0,0))
			v.item = item
		end
		local skillInfo = skillLists[k]
		local pointline = TFDirector:getChildByPath(self.curSkillMap, "Panel_line"..k - 1 )
		v.item.line = pointline

		if not update then
			if not self.record_[self.selectType] then
				self.record_[self.selectType] = {}
			end
			local curState = ExploreDataMgr:getKnowledgeState(self.selectType, skillInfo.id)
			if curState and curState ~= 0 then
				table.insert(self.record_[self.selectType],skillInfo.id)
			end
		end

		self:updateSkillItem(v.item, skillInfo)
	end
end

function CommandSkillView:updateSkillItem(item, data)
	local Image_light = TFDirector:getChildByPath(item,"Image_light")
	local Image_dark = TFDirector:getChildByPath(item,"Image_dark")
	local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
	local Image_flag = TFDirector:getChildByPath(item,"Image_flag"):hide()
	local Image_redTip = TFDirector:getChildByPath(item,"Image_redTip")
	local Spine_item = TFDirector:getChildByPath(item,"Spine_item"):hide()

	local preActivite = true
	for k, v in pairs(data.preAbility) do
		local state = ExploreDataMgr:getKnowledgeState(self.selectType, v) 
		if not state or state == 0 then
			preActivite = false
		end
	end

	if item.line then
		local line_light = TFDirector:getChildByPath(item.line, "Panel_light")
		local line_dark = TFDirector:getChildByPath(item.line, "Panel_dark")
		line_light:setVisible(preActivite)
		line_dark:setVisible(not preActivite)
	end

	local curState = ExploreDataMgr:getKnowledgeState(self.selectType, data.id)
	Image_icon:setTexture(data.icon)
	if not curState then
		item:setOpacity(125)
		Image_light:hide()
		Image_dark:show()
	else
		if not self.record_[self.selectType] then
			self.record_[self.selectType] = {}
		end
		item:setOpacity(255)
		if curState == 0 then
			Image_flag:show()
			Image_light:hide()
			Image_dark:show()
		else
			local index = table.indexOf(self.record_[self.selectType],data.id)
			if index == -1 then
				self:timeOut(function()
					Spine_item:show()
					Spine_item:play("animation",false)
					Spine_item:addMEListener(TFARMATURE_EVENT,function(skeletonNode)
						Image_light:show()
						Image_dark:hide()
						table.insert(self.record_[self.selectType],data.id)
					end)
				end)
			else
				Image_light:show()
				Image_dark:hide()
			end

		end
		self.curSkillPos = item:getParent():getPosition()
	end

	Image_redTip:setVisible(CommandSkillView.checkKnowledgeRedPoint(data))

	if curState ~= 1 then
		Image_icon:setTexture(string.sub(data.icon,0,-5).."_1.png")
	end
	Image_icon:setTouchEnabled(true)
	Image_icon:onClick(function ( ... )
		Utils:openView("explore.KnowledgeInfoView", data.id)
		--ExploreDataMgr:Send_ExploreTechUpgrade(data.type,0,data.id)
	end)
end

function CommandSkillView:updateStyleState()
	local isWorking = self:isCurSelectActive(self.selectType)
	self.working:setVisible(isWorking)
	self.notWorking:setVisible(not isWorking)
	self.Button_active:setVisible(not isWorking)
	self.Label_name:setTextById(13311310 + self.selectType)

	local totalList = ExploreDataMgr:getKnowledgeList(self.selectType)
	local list = ExploreDataMgr:getKnowledgeState(self.selectType)

	if not list then
		self.Label_process:setTextById(800005, 0, #totalList)
	else
		local activeNum = 0
		for k,v in pairs(list) do
			if v ~= 0 then
				activeNum = activeNum + 1
			end
		end
		self.Label_process:setTextById(800005, activeNum, #totalList)
	end
end

function CommandSkillView:isCurSelectActive(styleType)
	if not ExploreDataMgr.shipInfo then
		return false
	end

	return styleType == ExploreDataMgr.shipInfo.shape
end

function CommandSkillView:removeEvents()
	self.super.removeEvents(self)
    me.Director:setSingleEnabled(true)
end

return CommandSkillView