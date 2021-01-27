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
* -- 组队副本准备节目
]]

local OSDLevelReadyView = class("OSDLevelReadyView",BaseLayer)

function OSDLevelReadyView:ctor( data )
	self.super.ctor(self,data)
	self.selectIndex = 1
	self.levelCfg = TabDataMgr:getData("HighTeamDungeonLevel", data)
	self:init("lua.uiconfig.osd.LevelReady")
end

function OSDLevelReadyView:initUI( ui )
	self.super.initUI(self,ui)
	self.button_tip = TFDirector:getChildByPath(ui,"button_tip"):hide()
	self.Image_costIcon = TFDirector:getChildByPath(ui,"Image_costIcon")
	self.label_modle = TFDirector:getChildByPath(ui,"label_modle")
	self.label_level = TFDirector:getChildByPath(ui,"label_level")
	self.label_target = TFDirector:getChildByPath(ui,"label_target")
	self.label_count = TFDirector:getChildByPath(ui,"label_count")
	self.label_tip1 = TFDirector:getChildByPath(ui,"label_tip1")
	self.label_costNum = TFDirector:getChildByPath(ui,"label_costNum")
	self.panel_reward = TFDirector:getChildByPath(ui,"panel_reward")
	local ScrollView_reward = TFDirector:getChildByPath(ui,"ScrollView_reward")
	self.UIList_reward = UIListView:create(ScrollView_reward)
	self.UIList_reward:setItemsMargin(10)
	self.panel_level = TFDirector:getChildByPath(ui,"panel_level")
	self.btn_go = TFDirector:getChildByPath(ui,"btn_go")
	self.image_4 = TFDirector:getChildByPath(ui,"image_4")
	self.Chapter_bg = TFDirector:getChildByPath(ui,"Chapter_bg")
	self.label_modelDesc = TFDirector:getChildByPath(ui,"label_modelDesc")
	self.label_reward_title = TFDirector:getChildByPath(ui,"label_reward_title")

	self.Chapter_bg:setTexture(self.levelCfg.captshowPic)
	self.label_modelDesc:setTextById(self.levelCfg.dropString)
	self.label_modelDesc:setTextAreaSize(CCSize(600 , 0))
	self.label_modelDesc:setAnchorPoint(ccp(0 , 0.5))
	self:refreshView( )
end

function OSDLevelReadyView:refreshView( )
	self:flushLeft( )
	self:flushRight( )
end

function OSDLevelReadyView:flushLeft( ... )
	local preLevelPass = true
	for i = 1,#self.levelCfg.dungeonID do
		local levelItemNode = TFDirector:getChildByPath(self.panel_level,"panel_levelItem"..i)
		if levelItemNode then
			local _cfg = TabDataMgr:getData("HighTeamDungeon", self.levelCfg.dungeonID[i])
			local parent = TFDirector:getChildByPath(levelItemNode,"panel_lock"):hide()
			local parent1 = TFDirector:getChildByPath(levelItemNode,"panel_unlock"):hide()
			if preLevelPass then
				parent = parent1
				local icon = TFDirector:getChildByPath(parent,"icon")
				local _select = TFDirector:getChildByPath(parent,"selected")
				icon:setTexture(_cfg.bossicon)
				_select:setVisible(i == self.selectIndex)
				icon:setTouchEnabled(true)
				icon:onClick(function ( ... )
					self.selectIndex = i
					self:flushLeft()
					self:flushRight()
				end)
			end
			parent:show()
			preLevelPass = OSDDataMgr:checkDungeonIsPass(self.levelCfg.dungeonID[i])
			if i < #self.levelCfg.dungeonID then
				local lineNode = TFDirector:getChildByPath(self.panel_level,"panel_lineItem"..i)
				local line_light = TFDirector:getChildByPath(lineNode,"line_light")
				local line_darke = TFDirector:getChildByPath(lineNode,"line_darke")
				line_light:setVisible(preLevelPass)
				line_darke:setVisible(not preLevelPass)
			end
		end

	end
end

function OSDLevelReadyView:registerEvents()
	self.super.registerEvents(self)
	EventMgr:addEventListener(self,EV_OSD.EV_REFRESH_CHAPTERINFO,handler(self.refreshView, self))
	self.button_tip:onClick(function ( ... )
		local dungeonID = self.levelCfg.dungeonID[self.selectIndex]
		local _cfg = TabDataMgr:getData("HighTeamDungeon",dungeonID)
		Utils:openView("osd.TeamLevelHelpView",_cfg.type,_cfg.id)
	end)

	self.btn_go:onClick(function ( ... )
		local dungeonID = self.levelCfg.dungeonID[self.selectIndex]
		local _cfg = TabDataMgr:getData("HighTeamDungeon",dungeonID)
		local costId
		local costNum

		if #table.keys(_cfg.joinCost) > 0 then
			costId = table.keys(_cfg.joinCost)[1]
			costNum = _cfg.joinCost[costId]
		end

		if costId and GoodsDataMgr:getItemCount(costId) < costNum then
			Utils:showTips(14110285)
			return
		end

		local previewData = {levelCfg = clone(_cfg),costData = {id = self.costId, num = self.costNum , hasnum = GoodsDataMgr:getItemCount(self.costId)},levelStat = {buyCount = 0, isGetFirstReward = not OSDDataMgr:checkDungeonHasFirtReward(_cfg.id),remainCount = math.max(0,_cfg.rewardTime - OSDDataMgr:getDungeonFightCount(_cfg.id))}}
		local view = requireNew("lua.logic.teamFight.TeamLevelPreview"):new(previewData)
		AlertManager:addLayer(view)
 		AlertManager:show()
	end)
end

function OSDLevelReadyView:flushRight( ... )
	local _cfg = TabDataMgr:getData("HighTeamDungeon", self.levelCfg.dungeonID[self.selectIndex])
	self.label_modle:setTextById(_cfg.levelName)
	self.label_level:setTextById(_cfg.levelShow)
	self.label_target:setTextById(_cfg.levelTarget)
	self.image_4:hide()
	self.costId = 50004
	self.costNum = 0 
	if #table.keys(_cfg.joinCost) > 0  then
		self.image_4:show()
		local key = table.keys(_cfg.joinCost)[1]
		local value = _cfg.joinCost[key]
		self.Image_costIcon:setTexture(GoodsDataMgr:getItemCfg(key).icon)
		self.Image_costIcon:setTouchEnabled(true)
		self.Image_costIcon:onClick( function ( ... )
				Utils:showInfo(key)
			end)
		self.label_costNum:setText(value)
		self.costId = key
		self.costNum = value
		if value <= 0 then 
			self.image_4:hide() 
		end
	end

	if _cfg.rewardTime > 0 then
		self.label_count:show()
		self.label_tip1:show()
		self.label_count:setText(math.max(0,_cfg.rewardTime - OSDDataMgr:getDungeonFightCount(_cfg.id)).."/".._cfg.rewardTime)
	else
		self.label_tip1:hide()
		self.label_count:hide()
	end
	
	local isFirstPass = OSDDataMgr:checkDungeonHasFirtReward(_cfg.id)
	local rewardList = _cfg.showReward
	self.label_reward_title:setTextById(14110287)
	if isFirstPass then
		rewardList = _cfg.showFirstreward
		self.label_reward_title:setTextById(14110286)
	end
	self.UIList_reward:removeAllItems()
	for i = 1,#rewardList do
		local point = TFDirector:getChildByPath(self.panel_reward,"point1"):clone()
		point.goodItem = PrefabDataMgr:getPrefab("Panel_dropGoodsItem"):clone()
		point.goodItem:setPosition(ccp(0,0))
		point:addChild(point.goodItem)
		point:setPosition(ccp(0,0))
		self.UIList_reward:pushBackCustomItem(point)
		local reward = rewardList[i]
		local flag = 0
		if isFirstPass then
            flag = bit.bor(flag, EC_DropShowType.FIRST_PASS)
		end

		point:hide()
		if reward then
			point:show()
			PrefabDataMgr:setInfo(point.goodItem,{reward},flag)
		end
	end
end

return OSDLevelReadyView