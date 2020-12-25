--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local FubenMonsterTrialDetailView = class("FubenMonsterTrialDetailView", BaseLayer)

function FubenMonsterTrialDetailView:ctor(...)
	self.super.ctor(self)
	self:initData(...)

	self:init("lua.uiconfig.fuben.fubenMonsterTrialDetailView")
end

function FubenMonsterTrialDetailView:initData(chapterCid, dungeonLevelId,highBossId)
	self.chapterCid_ = chapterCid or 421
	self.dungeonLevelId = dungeonLevelId
    self.chapterCfg_ = FubenDataMgr:getChapterCfg(self.chapterCid_)

	self.MainInfo = FubenDataMgr:getMonsterTrialInfo()
	
	self.highBossId = highBossId

	self.bufflist = FubenDataMgr:getMonsterLvlBufflist(highBossId) or {}

	self.LvlInfo = FubenDataMgr:getMonsterTrialInfoByHighBoss(highBossId)
end

function FubenMonsterTrialDetailView:initUI(ui)
	self.super.initUI(self, ui)

	self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
	self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")

	self.Button_ready = TFDirector:getChildByPath(self.Panel_root, "Button_ready")
    self.Label_ready = TFDirector:getChildByPath(self.Button_ready, "Label_ready")

	self.Image_Role = TFDirector:getChildByPath(self.Panel_root, "Image_Role")

	self.Prefab_buff = TFDirector:getChildByPath(self.Panel_root, "Prefab_buff")

	self.Panel_right = TFDirector:getChildByPath(self.Panel_root, "Panel_right")

	self.Model_bg = TFDirector:getChildByPath(self.Panel_root, "map")

	self.Panel_level_feature = TFDirector:getChildByPath(self.Panel_right, "Panel_level_feature")
	self.Panel_level_feature.label = TFDirector:getChildByPath(self.Panel_level_feature, "label_feature")
	self.Panel_level_feature.Label_up = TFDirector:getChildByPath(self.Panel_level_feature, "Label_up"):Hide()

	self.Panel_level_suffix = TFDirector:getChildByPath(self.Panel_right, "Panel_level_suffix")
	self.Panel_level_suffix.label = TFDirector:getChildByPath(self.Panel_level_suffix, "label_suffix")
	self.Panel_level_suffix.Label_cn = TFDirector:getChildByPath(self.Panel_level_suffix, "Label_cn")

	self.Panel_level_buff = TFDirector:getChildByPath(self.Panel_right, "Panel_level_buff")
	self.Panel_level_buff.list = TFDirector:getChildByPath(self.Panel_level_buff, "list")
	self.Panel_level_buff.Label_cn = TFDirector:getChildByPath(self.Panel_level_buff, "Label_cn")

	self.Panel_score = TFDirector:getChildByPath(self.Panel_root, "Panel_score")
	self.Label_score_lvl = TFDirector:getChildByPath(self.Panel_score, "Label_score_lvl")
	self.Label_score_cur = TFDirector:getChildByPath(self.Panel_score, "Label_score_cur")

	self.Label_time_title = TFDirector:getChildByPath(self.Panel_root, "Label_time_title")
    self.Label_time = TFDirector:getChildByPath(self.Panel_root, "Label_time")

	self:initLeftPanel()
	self:initRightPanel()
end

function FubenMonsterTrialDetailView:registerEvents()
	self.Button_ready:onClick(function()
		if not FubenDataMgr:isMonsterTrialOpen() then
			Utils:showTips(2106013)
			return;
		end
		Utils:openView("fuben.FubenSquadView", self.chapterCfg_.type, self.chapterCid_, self.dungeonLevelId)
	end)
end

function FubenMonsterTrialDetailView:initLeftPanel()
	self.Label_score_lvl:setTextById(15010011,	FubenDataMgr:getMonsterTrialLvTotalScore())
	self.Label_score_cur:setTextById(15010010,	self.LvlInfo.score)
	self.Label_time_title:setTextById(2106004)

	local weekDay = {
		"一",
		"二",
		"三",
		"四",
		"五",
		"六",
		"日"
	}
	local closeday = TabDataMgr:getData("DiscreteData", 90021).data.settlement
	local start = closeday + 1
	if start > 7 then
		start = 1
	end
	local end_ = closeday - 1
	if end_ < 1 then
		end_ = 7
	end	
    self.Label_time:setTextById(15010014, weekDay[start], weekDay[end_])

	self:initMonsterModel()
end

function FubenMonsterTrialDetailView:initMonsterModel()

	local equipmentId = self.LvlInfo.configHighBoss.equipmentId
	local paintPath = EquipmentDataMgr:getEquipPaint(equipmentId);
    self.Image_Role:setTexture(paintPath);
    local pos = EquipmentDataMgr:getEquipPaintPosition(equipmentId);
    local scale = EquipmentDataMgr:getEquipPaintScale(equipmentId);
	local exScale = self.LvlInfo.configHighBoss.size or 1
    self.Image_Role:setScale(scale * exScale);
end

function FubenMonsterTrialDetailView:initRightPanel()	
	self.Panel_level_feature.label:setTextById(self.LvlInfo.configHighBoss.common)
	self.Panel_level_suffix.Label_cn:setTextById(15010032)
	self.Panel_level_buff.Label_cn:setTextById(15010033)

	local suffixCfg = TabDataMgr:getData("HighBoss", self.highBossId)	

	self.Panel_level_suffix.label:setText(suffixCfg.stringId)
	local BuffIcon = TFDirector:getChildByPath(self.Panel_level_suffix, "BuffIcon")
	BuffIcon:setTexture(suffixCfg.icon)

	if self.LvlInfo.up then
		local upBilinear = TabDataMgr:getData("DiscreteData", 90021).data.upBilinear
		self.Panel_level_feature.Label_up:setTextById(15010012)
		self.Panel_level_feature.Label_up:show()
	end
	self:initBuffList()
end

function FubenMonsterTrialDetailView:initBuffList()
	self:initTableView()
	self.tableView:reloadData()
end

function FubenMonsterTrialDetailView:initTableView()
	self.tableView = Utils:scrollView2TableView(self.Panel_level_buff.list)
	self.tableView:setDirection(TFTableView.TFSCROLLVERTICAL)
	self.tableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.tableCellSize,self))
    self.tableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCells,self))
    self.tableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex,self))
end

function FubenMonsterTrialDetailView:tableCellSize(tableView, idx)
	local size = self.Prefab_buff:getSize()
    return size.height, size.width + 2
end

function FubenMonsterTrialDetailView:numberOfCells(tableView)
    return #self.bufflist
end

function FubenMonsterTrialDetailView:tableCellAtIndex(tableView,idx)
    local cell = tableView:dequeueCell()
    local item = nil
    if nil == cell then
        cell = TFTableViewCell:create()
        item = self.Prefab_buff:clone()
        item:show()
        item:setPosition(ccp(0,0))
        cell:addChild(item)
        cell.item = item	
	else
		item = cell.item
    end

	self:initCell(item, self.bufflist[idx + 1])
    return cell
end

function FubenMonsterTrialDetailView:initCell(cell, data)
	local buffCfg = data.Config
	local buffIcon = TFDirector:getChildByPath(cell, "BuffIcon")
	local label_buff = TFDirector:getChildByPath(cell, "label_buff")

	buffIcon:setTexture(buffCfg.icon)
	label_buff:setText(buffCfg.stringId)
end


return FubenMonsterTrialDetailView
--endregion
