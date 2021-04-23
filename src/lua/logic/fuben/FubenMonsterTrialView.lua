--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local FubenMonsterTrialView = class("FubenMonsterTrialView", BaseLayer)

function FubenMonsterTrialView:ctor(...)
	self.super.ctor(self)
	self:initData(...)

	self:init("lua.uiconfig.fuben.fubenMonsterTrialView")

	FubenDataMgr:requestMonsterTrialInfo()
end

function FubenMonsterTrialView:initData(chapterCid)
	self.chapterCid_ = chapterCid or 421
    self.chapterCfg_ = FubenDataMgr:getChapterCfg(self.chapterCid_)

	self.tabLvlIcon = {}
end

function FubenMonsterTrialView:initUI(ui)
	self.super.initUI(self, ui)

	self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root") 
    self.Prefab_sprite = TFDirector:getChildByPath(ui, "Prefab_sprite"):hide()

	self.Button_ready = TFDirector:getChildByPath(self.Panel_root, "Button_ready")
	self.Button_ready.redPoint = TFDirector:getChildByPath(self.Button_ready, "redPoint"):Hide()

	local Image_title = TFDirector:getChildByPath(self.Panel_root, "Image_title")
    self.Label_time_title = TFDirector:getChildByPath(Image_title, "Label_time_title")
    self.Label_time = TFDirector:getChildByPath(Image_title, "Label_time")

	self.beatNum = TFDirector:getChildByPath(self.Panel_root, "beatNum")
	self.beatNum = TFDirector:getChildByPath(self.beatNum, "num")

	self.Panel_score = TFDirector:getChildByPath(self.Panel_root, "Panel_score")
	self.Panel_score.score = TFDirector:getChildByPath(self.Panel_score, "Label_score_total")

	self.Button_store = TFDirector:getChildByPath(self.Panel_root, "Button_store")

	self.Prefab_sprite = TFDirector:getChildByPath(self.Panel_root, "Prefab_sprite"):Hide()

	self.Level_list = TFDirector:getChildByPath(self.Panel_root, "Level_list")

	self.Panel_title = TFDirector:getChildByPath(self.Panel_root, "Panel_title")
	self.Panel_title.LvlGroup = TFDirector:getChildByPath(self.Panel_title, "Label_lvl_group")
	self.Panel_title.LvlScope = TFDirector:getChildByPath(self.Panel_title, "Label_lvl_scope")

	self.level_bg = TFDirector:getChildByPath(self.Level_list, "level_bg")

	local list = TFDirector:getChildByPath(self.ui, "SpriteList")
	self.tableView = Utils:scrollView2TableView(list)
	self.tableView:setDirection(TFTableView.TFSCROLLVERTICAL)
	self.tableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.tableCellSize,self))
	self.tableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCells,self))
	self.tableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex,self))

	for i = 1, 10 do
		local lvl = TFDirector:getChildByPath(self.level_bg, "level"..i)
		lvl.bg					= TFDirector:getChildByPath(lvl, "bg")
		lvl.level_icon			= TFDirector:getChildByPath(lvl, "level_icon")
		lvl.unstart				= TFDirector:getChildByPath(lvl, "unstart")
		lvl.finishTag			= TFDirector:getChildByPath(lvl, "finishTag")
		lvl.levelname			= TFDirector:getChildByPath(lvl, "levelname")
		lvl.levelNameBg			= TFDirector:getChildByPath(lvl, "levelNameBg")
		lvl.up					= TFDirector:getChildByPath(lvl, "up")
		lvl.unStartMask			= TFDirector:getChildByPath(lvl, "unStartMask")
		lvl.touch				= TFDirector:getChildByPath(lvl, "touch")

		lvl.buff				= TFDirector:getChildByPath(lvl, "buff")	
		lvl.buff.unactive		= TFDirector:getChildByPath(lvl.buff, "unactive")	
		lvl.buff.unactiveIcon	= TFDirector:getChildByPath(lvl.buff.unactive, "buffIcon")	
		lvl.buff.active			= TFDirector:getChildByPath(lvl.buff, "active")
		lvl.buff.activeIcon		= TFDirector:getChildByPath(lvl.buff.active, "buffIcon")
		lvl.buff.lock			= TFDirector:getChildByPath(lvl.buff, "lock")
		lvl.buff.touch			= TFDirector:getChildByPath(lvl.buff, "touch")

		lvl.bg:Hide()
		lvl.finishTag:Hide()
		lvl.levelNameBg:Hide()
		lvl.unstart:Show()
		lvl.up:Hide()	
		lvl.unStartMask:Show()

		lvl.buff.unactive:Hide()
		lvl.buff.active:Hide()
		lvl.buff.lock:Show()

		lvl.touch:setTouchEnabled(true)
		lvl.touch:addMEListener(TFWIDGET_CLICK, handler(self.selectLvl, self))

		lvl._lock = true		
		
		table.insert(self.tabLvlIcon, lvl)
	end	
end

function FubenMonsterTrialView:registerEvents()
	self.super.registerEvents(self)
	EventMgr:addEventListener(self, EV_RECV_MONSTER_TRIAL_INFO, handler(self.onMainInfo, self))
	EventMgr:addEventListener(self, EV_TASK_RECEIVE, handler(self.onTaskReceiveEvent, self))
	--重连
    EventMgr:addEventListener(self,EV_RECONECT_EVENT, handler(self.onReconnect,self))

	self.Button_ready:onClick(function()
		Utils:openView("fuben.FubenMonsterReward")
	end)
	self.Button_store:onClick(function()
		FunctionDataMgr:jMonStore()
	end)
end

function FubenMonsterTrialView:selectLvl(widget)
	local LvlNode = widget:getParent()
	if LvlNode._lock then
		Utils:showTips(202005)
		return
	end

	Utils:openView("fuben.FubenMonsterTrialDetailView", self.chapterCid_, LvlNode.configHighBoss.dungeonLevelId, LvlNode.configHighBoss.id)
end

function FubenMonsterTrialView:setLvlScrope()
	local tab = {
		[1] = {
			Lv1 = 30,
			Lv2 = 50,
			Name = 15010007
		},
		[2] = {
			Lv1 = 51,
			Lv2 = 60,
			Name = 15010008
		},
		[3] = {
			Lv1 = 61,
			Lv2 = 80,
			Name = 15010009
		}
	}
	if #self.MainInfo.experiment > 0 then
		local levelScope = self.MainInfo.experiment[1].configHighBoss.level
		local ret;
		for k,v in ipairs(tab) do 
			if levelScope[1] >= v.Lv1 and  levelScope[2] <= v.Lv2 then
				ret = v
				break;
			end
		end

		self.Panel_title.LvlGroup:setTextById(ret.Name)
		self.Panel_title.LvlScope:setTextById(15010013, levelScope[1], levelScope[2])
	end
end

function FubenMonsterTrialView:refreshView()
	local experiment = self.MainInfo.experiment or {}
	local attackOrder = self.MainInfo.attackOrder or {}	
	self.beatNum:setText(#attackOrder .."/".. #experiment)
	self.Panel_score.score:setTextById(15010011, FubenDataMgr:getMonsterTrialLvTotalScore())

	self:refreshRewardRedPoint()	
	self:setLvlScrope()
	self:refreshLevelInfo()
	self:refreshSpriteBuff()	
end

function FubenMonsterTrialView:refreshRewardRedPoint()	
	local monsterTrialTaskConfig = FubenDataMgr:getMonsterTrialInfo()
	local taskIDs = monsterTrialTaskConfig["taskList"]
	local has = false
	for k, v in pairs(taskIDs) do
		local taskInfo = TaskDataMgr:getTaskInfo(v)
		if taskInfo and taskInfo.status == EC_TaskStatus.GET then
			has = true
			break;
		end
	end
	self.Button_ready.redPoint:setVisible(has)
end

function FubenMonsterTrialView:refreshLevelInfo()
	local lvlData = self.MainInfo["experiment"]
	if 0 == #lvlData then
		return
	end
	local upBilinear = TabDataMgr:getData("DiscreteData", 90021).data.upBilinear
	local attackOrder = self.MainInfo.attackOrder or {}

	--update level status
	for i = 1, #lvlData do		
		local lvlIcon = self.tabLvlIcon[lvlData[i].configHighBoss.position]
		lvlIcon.configHighBoss = lvlData[i].configHighBoss
		lvlIcon.configDungeonLevel = lvlData[i].configDungeonLevel

		lvlIcon.data = lvlData[i]
		lvlIcon._lock = false

		local finish = false;
		if table.indexOf(attackOrder, lvlData[i].id) ~= -1 then
			finish = true
		end
		lvlIcon:show()
		lvlIcon.unstart:Hide()
		lvlIcon.levelNameBg:show()
		lvlIcon.bg:show()
		lvlIcon.finishTag:setVisible(finish)
		lvlIcon.up:setVisible(lvlData[i].up)
		lvlIcon.unStartMask:Hide()
		lvlIcon.levelname:setText(lvlData[i].configHighBoss.dungeonName)
	
		if finish then
			--是否完美
			if (lvlData[i].up ==true  and lvlData[i].score >= lvlData[i].configHighBoss.max *  (1 + upBilinear/10000)) 
			or (lvlData[i].up ==false and (lvlData[i].score >= lvlData[i].configHighBoss.max)) then
				lvlIcon.bg:setTexture("ui/fuben/monsterTrial/perfectbg.png")
				lvlIcon.finishTag:setTexture("ui/fuben/monsterTrial/perfectLabel.png")
			end
		end
		
		lvlIcon.buff.active:setVisible(finish)
		lvlIcon.buff.activeIcon:setTexture(lvlData[i].configHighBoss.icon)
		lvlIcon.buff.unactive:setVisible(not finish)
		lvlIcon.buff.unactiveIcon:setTexture(lvlData[i].configHighBoss.icon)
		lvlIcon.buff.unactiveIcon:setShaderProgram("GrayShader", true)
		lvlIcon.buff.lock:Hide()

		lvlIcon.buff.touch:setTouchEnabled(true)
		lvlIcon.buff.touch:addMEListener(TFWIDGET_CLICK,function()
			Utils:openView("fuben.FubenMonsterTrialBuffDetail", lvlIcon.configHighBoss)
		end)	
	end
	local lastLvIdx = 1
	if #attackOrder > 0 then
		local cfg = FubenDataMgr:getMonsterTrialInfoByHighBoss(attackOrder[#attackOrder])
		lastLvIdx = cfg.position
	end
	local const = 50
	local lastLvIcon = self.tabLvlIcon[lastLvIdx]
	local pos_w = lastLvIcon:convertToWorldSpace(ccp(lastLvIcon:getSize().width / 2, lastLvIcon:getSize().height / 2))
	local pos_n = self.Level_list:getInnerContainer():convertToWorldSpace(pos_w)
	local percent = ( math.abs(pos_n.y + self.tabLvlIcon[1]:getPositionY()) + lastLvIdx * const) / (self.Level_list:getInnerContainerSize().height)
	local time = 0.05 + 0.02 * lastLvIdx
	self.Level_list:scrollTo(TF_SCROLLVIEW_SCROLL_TO_PERCENT_VERTICAL, time, true, 0, percent * 100)
end

function FubenMonsterTrialView:refreshSpriteBuff()

	self.tableView:reloadData()
end

function FubenMonsterTrialView:onMainInfo()
	self.MainInfo = FubenDataMgr:getMonsterTrialInfo()

	self:refreshView()
end

function FubenMonsterTrialView:removeEvents()
	self.super.removeEvents(self)	
end

function FubenMonsterTrialView:initTableView()

end

function FubenMonsterTrialView:tableCellSize(tableView, idx)
	local size = self.Prefab_sprite:getSize()
    return size.height * 0.9, size.width + 5
end

function FubenMonsterTrialView:numberOfCells(tableView)
	local size = 0;
	if self.MainInfo and self.MainInfo["heroBuff"] then
		size = #self.MainInfo["heroBuff"]
	end
    return size
end

function FubenMonsterTrialView:tableCellAtIndex(tableView,idx)
    local cell = tableView:dequeueCell()
    local item = nil
    if nil == cell then
        cell = TFTableViewCell:create()
        item = self.Prefab_sprite:clone()
        item:show()
        item:setPosition(ccp(0,0))
        cell:addChild(item)
        cell.item = item	
	else
		item = cell.item
    end

	self:initCell(item, self.MainInfo["heroBuff"][idx + 1])
    return cell
end

function FubenMonsterTrialView:initCell(cell, cellData)
	local buffer = TabDataMgr:getData("Buffer", cellData.buffId)	
	cell:getChildByName("head"):setTexture(HeroDataMgr:getIconPathById(cellData.heroId))
	cell:getChildByName("label_buff"):setText(buffer.des)
	cell:getChildByName("buff_name"):setText(HeroDataMgr:getName(cellData.heroId))	
end

function FubenMonsterTrialView:onReconnect()
	FubenDataMgr:requestMonsterTrialInfo()
end

function FubenMonsterTrialView:onTaskReceiveEvent()
	self:refreshRewardRedPoint()	
end

return FubenMonsterTrialView
--endregion
