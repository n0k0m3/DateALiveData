local TeamLevelSelView = class("TeamLevelSelView", BaseLayer)

function TeamLevelSelView:initData(groupid)
	self.teamLevelStat = TeamFightDataMgr:getTeamLevelStat()
	self.levelsGroup = TabDataMgr:getData("ChasmDungeonGroup")
	self.levelsCfg = TabDataMgr:getData("ChasmDungeon")
	self.maxPlayerLv = Utils:getKVP(9002,"pmaxlvl")
	
	self.curSelLevel = {idx = 1}
	self.curCostStat = {id = 0,num = 0,hasnum = 0}
	self.curGroupCfg = self.levelsGroup[groupid]
	self.groupid = groupid
	-- FubenDataMgr:cacheSelectChapter(chapterId)
 --    FubenDataMgr:cacheSelectFubenType(EC_FBType.ACTIVITY)
end

function TeamLevelSelView:getClosingStateParams()
    return {self.groupid}
end

function TeamLevelSelView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.teamFight.teamLevelSelView")
end

function TeamLevelSelView:initUI(ui)
    self.super.initUI(self, ui)
    local root_panel= TFDirector:getChildByPath(ui,"Panel_root")
    self.levelSelPanel = TFDirector:getChildByPath(root_panel, "Panel_level_sel")
    self.levelSelPanel:onClick(function()
    	self.mass_desc_panel:stopAllActions()
    	self.mass_desc_panel:setVisible(false)
    end)
    self.levelSelPanel:setVisible(false)
    local group_title_bg = self.levelSelPanel:getChildByName("Image_open_time")
    group_title_bg:setTexture("ui/onlineteam/"..self.curGroupCfg.titleBg)
    local group_title = group_title_bg:getChildByName("Label_title")
    group_title:setTextById(self.curGroupCfg.title)
    local group_open_desc = group_title_bg:getChildByName("Label_open_time")
    group_open_desc:setTextById(self.curGroupCfg.TimeDesc)
    self:handleLevelSelUI()
    self:refreshView()
end

function TeamLevelSelView:refreshMassRewardUI()
	local massPanel = self.levelSelPanel:getChildByName("Panel_mass")
	local btn_mass = massPanel:getChildByName("Image_mass_touch")
	open_panel = massPanel:getChildByName("Panel_open_info")
	self.mass_desc_panel = massPanel:getChildByName("Panel_mass_tip")
	self.mass_desc_panel:getChildByName("TextArea_tip_desc"):setTextById(2100153)
	local levelCfg = self.levelsCfg[self.curGroupCfg.levelList[self.curSelLevel.idx]]
	local levelStatInfo = self.teamLevelStat[levelCfg.id]
	open_panel:getChildByName("Label_open_stat"):setTextById(2100151)
	btn_mass:onClick(function()
		self.mass_desc_panel:stopAllActions()
		self.mass_desc_panel:setVisible(true)
		local actionArr = {
				DelayTime:create(5),
				CallFunc:create(function()
					self.mass_desc_panel:setVisible(false)
				end),
			}
		self.mass_desc_panel:runAction(Sequence:create(actionArr))
	end)
	btn_mass:setGrayEnabled(not levelStatInfo.massStat)
	-- btn_mass:setTouchEnabled(levelStatInfo.massStat)
	open_panel:setVisible(levelStatInfo.massStat)
	if levelStatInfo.massStat then
		local startdate = Utils:getTimeData(levelStatInfo.massSTime)
		local enddate = Utils:getTimeData(levelStatInfo.massETime)
		local timeStr = string.format("%s:%s-%s:%s",
			string.format("%.2d",startdate.Hour),
			string.format("%.2d",startdate.Minute),
			string.format("%.2d",enddate.Hour),
			string.format("%.2d",enddate.Minute))
		open_panel:getChildByName("Label_open_time"):setString(timeStr)
	end
end

----------------------------------------------选择副本关卡部分------------------------------------
function TeamLevelSelView:handleLevelSelUI()
	self.levelListNodes = {}
	local levelsPanel = self.levelSelPanel:getChildByName("Panel_levels")
	self.levelListNodes["levels"] = levelsPanel
	levelsPanel:getChildByName("Image_map"):setTexture("ui/onlineteam/"..self.curGroupCfg.mapPic)
	levelsPanel.levelItemlist = {}
	local levelItem = levelsPanel:getChildByName("Panel_level_model")
	levelItem:setVisible(false)
	local posList = self.curGroupCfg.levelPosList
	for i = 1,#self.curGroupCfg.levelList do
		levelsPanel.levelItemlist[i] = levelItem:clone()
		levelsPanel:addChild(levelsPanel.levelItemlist[i],2)
		levelsPanel.levelItemlist[i].idx = i
		local levelCfg = self.levelsCfg[self.curGroupCfg.levelList[i]]
		levelsPanel.levelItemlist[i].levelCfg = levelCfg
		levelsPanel.levelItemlist[i]:setPosition(me.p(posList[i][1],posList[i][2]))
		levelsPanel.levelItemlist[i]:getChildByName("Image_boss"):setTexture(levelCfg.bossicon)
		levelsPanel.levelItemlist[i]:onClick(function()
			if self.curSelLevel.idx == i then
				return
			end
			self.curSelLevel = {idx = i}
			self:refreshView()
		end)
	end
	--信息展示
	local level_info_panel = self.levelSelPanel:getChildByName("Panel_level_info")
	local img_residue = level_info_panel:getChildByName("Image_residue")
	img_residue:getChildByName("Label_times_txt"):setTextById(2100046)
	self.levelListNodes["times_value"] = img_residue:getChildByName("Label_times_value")
	img_residue:getChildByName("Button_add_count"):onClick(function()
		local levelCfg = self.levelsCfg[self.curGroupCfg.levelList[self.curSelLevel.idx]]
		local buyCfg = levelCfg.buyCost
		local maxBuyCount = levelCfg.buyTime
		local boughtCount = self.teamLevelStat[levelCfg.id].buyCount
		local canBuyCount = math.max(maxBuyCount - boughtCount,0)
		if canBuyCount <= 0 then
			-- Utils:showError("今日购买次数已达上限")
			Utils:showError(TextDataMgr:getText(240013))
			return
		end
		local limitCount = levelCfg.rewardTime +self.teamLevelStat[levelCfg.id].buyCount
		local hasCount =  self.teamLevelStat[levelCfg.id].remainCount
		local costcfg = buyCfg[#buyCfg]
		if #buyCfg >= boughtCount + 1 then
			costcfg = buyCfg[boughtCount + 1]
		end
		Utils:openView("teamFight.TeamBuyChanceView",{levelid = levelCfg.id,limitCount = limitCount,hasCount = hasCount,canBuyCount = canBuyCount,cost = costcfg})
	end)

	self.levelListNodes["enter_btn"] = level_info_panel:getChildByName("Button_enter")
	self.levelListNodes["enter_btn"]:getChildByName("Label_title"):setTextById(2100047)
	self.levelListNodes["enter_btn"]:onClick(function()
		local levelCfg = self.levelsCfg[self.curGroupCfg.levelList[self.curSelLevel.idx]]
		local lestRefreshTimes = 1
		if levelCfg.fightCount > 0 then
			lestRefreshTimes = levelCfg.fightCount - self.teamLevelStat[levelCfg.id].fightCount
		end
		local playerLv = MainPlayer:getPlayerLv()
		local maxPlvCheckok = true
		if levelCfg.lvlLimit[2] and levelCfg.lvlLimit[2] < self.maxPlayerLv then
			if playerLv > levelCfg.lvlLimit[2] then
				maxPlvCheckok = false
			end
		end
		if self.teamLevelStat[levelCfg.id].stat ~= 1 then
			Utils:showError(2100098)
		elseif self.curCostStat.hasnum < self.curCostStat.num then
			Utils:showError(2100101)
		elseif playerLv < levelCfg.lvlLimit[1] then
			Utils:showError(2100100)
		elseif lestRefreshTimes <= 0 then
			Utils:showError(2100099)
		elseif maxPlvCheckok == false then

		else

			--弹出预览
			local curSelLevelCfg = self.levelsCfg[self.curGroupCfg.levelList[self.curSelLevel.idx]]
			local previewData = {levelCfg = clone(curSelLevelCfg),costData = clone(self.curCostStat),levelStat = clone(self.teamLevelStat[levelCfg.id])}
			local view = requireNew("lua.logic.teamFight.TeamLevelPreview"):new(previewData)
    		AlertManager:addLayer(view)
     		AlertManager:show()
		end
	end)
	self.levelListNodes["Panel_cost"] = level_info_panel:getChildByName("Panel_cost")
    self.levelListNodes["level_name"] = level_info_panel:getChildByName("Label_level_name")
    self.levelListNodes["boss_img"] = level_info_panel:getChildByName("Image_boss_pic")
    self.levelListNodes["desc"] = level_info_panel:getChildByName("TextArea_desc")
    self.levelListNodes["open_limit"] = level_info_panel:getChildByName("Image_open_lv"):getChildByName("Label_open_limit")
end

function TeamLevelSelView:refreshLevelSelView()
	local levelcell = self.levelListNodes["levels"]
	for s,levelitem in pairs(levelcell.levelItemlist) do
		local levelCfg = levelitem.levelCfg
		local statCfg = self.teamLevelStat[levelCfg.id]
		if levelitem.gidx == self.curSelLevel.gidx and levelitem.idx == self.curSelLevel.idx then
			levelitem:getChildByName("Image_sel"):setVisible(true)
			levelitem:getChildByName("Image_bottom_sel"):setVisible(true)
			levelitem:getChildByName("Image_bottom_s"):setVisible(true)
			self:runSelAction(levelitem:getChildByName("Image_bottom_s"))
			--信息
			self.levelListNodes["level_name"]:setTextById(300826,TextDataMgr:getText(levelCfg.levelName))
		    self.levelListNodes["boss_img"]:setTexture("ui/onlineteam/"..levelCfg.bosspic)
		    self.levelListNodes["desc"]:setTextById(levelCfg.LevelDesc)
		    self.levelListNodes["open_limit"]:setString(string.format("Lv.%d",levelCfg.lvlLimit[1]))
		    local lestRefreshTimes = self.teamLevelStat[levelCfg.id].remainCount
			self.levelListNodes["times_value"]:setString(tostring(lestRefreshTimes))

			--刷新花费
			for k,v in pairs(levelCfg.fightCost) do
			 	self.curCostStat.id = k
			 	self.curCostStat.num = v
			end
			--TODO 临时处理后续删除 20190523
			if  levelCfg.type == 1 then 
				local serverTime = ServerDataMgr:getServerTime()
				local date = os.date("*t",serverTime)
				if date.year == 2019 and date.day == 23 and date.month == 5 then
					self.curCostStat.num = 6
				end
			end
			self.curCostStat.hasnum = GoodsDataMgr:getItemCount(self.curCostStat.id)
			local costitemCfg = GoodsDataMgr:getItemCfg(self.curCostStat.id)
			self.levelListNodes["Panel_cost"]:getChildByName("Image_item_icon"):setTexture(costitemCfg.icon)
			self.levelListNodes["Panel_cost"]:getChildByName("Image_item_icon"):setSize(me.size(30,30))
			self.levelListNodes["Panel_cost"]:getChildByName("Label_cost_value"):setString(tostring(self.curCostStat.num))
			self.levelListNodes["Panel_cost"]:setVisible(self.curCostStat.num > 0)
			-- self.levelListNodes["Panel_cost"]:getChildByName("Label_cost_value"):setGrayEnabled(self.curCostStat.num > self.curCostStat.hasnum)
			local playerLv =  MainPlayer:getPlayerLv()
			local maxPlvCheckok = true
			if levelCfg.lvlLimit[2] and levelCfg.lvlLimit[2] < self.maxPlayerLv then
				if playerLv > levelCfg.lvlLimit[2] then
					maxPlvCheckok = false
				end
			end
			-- self.levelListNodes["enter_btn"]:setGrayEnabled(statCfg.stat ~= 1 or levelCfg.lvlLimit[1] > playerLv or (not maxPlvCheckok) or self.curCostStat.num > self.curCostStat.hasnum)
		else
			levelitem:getChildByName("Image_bottom_s"):stopAllActions()
			levelitem:getChildByName("Image_bottom_s"):setVisible(false)
			levelitem:getChildByName("Image_sel"):setVisible(false)
			levelitem:getChildByName("Image_bottom_sel"):setVisible(false)
		end
		if statCfg and statCfg.stat == 1 then
			levelitem:getChildByName("Image_lock"):setVisible(false)
			levelitem:getChildByName("Image_line"):setTexture("ui/onlineteam/unlocked_line.png")
			levelitem:getChildByName("Image_bottom"):setTexture("ui/onlineteam/b_unlocked.png")
		else
			levelitem:getChildByName("Image_lock"):setVisible(true)
			levelitem:getChildByName("Image_line"):setTexture("ui/onlineteam/locked_line.png")
			levelitem:getChildByName("Image_bottom"):setTexture("ui/onlineteam/b_locked.png")
		end
		levelitem:setVisible(true)
	end
end

function TeamLevelSelView:runSelAction(tarnode)
	local actArr = {CallFunc:create(function()
		tarnode:setScale(1)
		tarnode:setVisible(true)
		tarnode:setOpacity(255)
	end),ScaleTo:create(1,1.3),FadeOut:create(0.5),DelayTime:create(1)}
	tarnode:stopAllActions()
	tarnode:runAction(RepeatForever:create(Sequence:create(actArr)))
end

--------------------------------------------关卡预览部分--------------------------------------------



---------------------------------------
function TeamLevelSelView:onShow()
	self.super.onShow(self)
	self:refreshView()
end
function TeamLevelSelView:refreshView()
	if self.teamLevelStat ~= nil then
		self:refreshMassRewardUI()
		self:refreshLevelSelView()
		self.levelSelPanel:setVisible(true)
	end
end
function TeamLevelSelView:registerEvents()
	EventMgr:addEventListener(self, EV_TEAM_FIGHT_LEVEL_STAT_LIST, handler(self.onUpdateLevelStat, self))
end

function TeamLevelSelView:onUpdateLevelStat()
	self.teamLevelStat = TeamFightDataMgr:getTeamLevelStat()
	self:refreshView()
end

return TeamLevelSelView