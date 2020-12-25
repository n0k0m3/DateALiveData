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
* -- 新年副本
]]

local NewYearBossPreview = class("NewYearBossPreview",BaseLayer)

function NewYearBossPreview:ctor(data)
	self.super.ctor(self,data)
	self.bossData = data
	local displayMap = TabDataMgr:getData("MojinDungeonDisplay")
	self.displayCfgs = {}
	for k, v in pairs(displayMap) do
		self.displayCfgs[v.dungeon] = v
	end
	self.newYearFubenInfo = ActivityDataMgr2:getNewYearFubenInfo()
	self.activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.NEWYEAR_FUBEN)[1]
    self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	self:init("lua.uiconfig.activity.newYearBossPreview")
end

function NewYearBossPreview:initUI(ui)
	self.super.initUI(self,ui)

	self.Label_open_time = TFDirector:getChildByPath(ui,"Label_open_time")
	self.Button_battle = TFDirector:getChildByPath(ui,"Button_battle")
	self.Image_hero = TFDirector:getChildByPath(ui,"Image_hero")
	self.Panel_buff = TFDirector:getChildByPath(ui,"Panel_buff")
	local Panel_boss_info = TFDirector:getChildByPath(ui,"Panel_boss_info")
	self.Label_boss_name = TFDirector:getChildByPath(Panel_boss_info,"Label_boss_name")
	self.label_curLv = TFDirector:getChildByPath(Panel_boss_info,"label_curLv")
	self.LoadingBar_boss_stage = TFDirector:getChildByPath(Panel_boss_info,"LoadingBar_boss_stage")
	self.Image_stage_bg = TFDirector:getChildByPath(Panel_boss_info,"Image_stage_bg")
	self.Label_stage_value = TFDirector:getChildByPath(Panel_boss_info,"Label_stage_value")
	self.Label_wave_value = TFDirector:getChildByPath(Panel_boss_info,"Label_wave_value")
	self.Label_damege_value = TFDirector:getChildByPath(Panel_boss_info,"Label_damege_value")
	self.Label_score_value = TFDirector:getChildByPath(Panel_boss_info,"Label_score_value")
	self.Label_total_score_value = TFDirector:getChildByPath(Panel_boss_info,"Label_total_score_value")

	self.buff_panels = {}
	for i = 1, 4 do
		local Panel_buff = TFDirector:getChildByPath(ui,"Panel_buff"..i)
		Panel_buff.label_buff_name = TFDirector:getChildByPath(Panel_buff,"label_buff_name")
		self.buff_panels[i] = Panel_buff
	end

	self:initUIView()
end

function NewYearBossPreview:initUIView()
	local act1 =  CCMoveTo:create(2, ccp(375, 327))
    local act2 = CCMoveTo:create(2, ccp(375,297))
    self.Image_hero:runAction(RepeatForever:create(CCSequence:create({act1, act2})))

	local remandTime = math.max(0, self.bossData.replaceEnd - ServerDataMgr:getServerTime())
	local day,hour, min, sec = Utils:getTimeDHMZ(remandTime, true)
	local timeStr = TextDataMgr:getText(12033023)
	if day == "00" then
		timeStr = timeStr..TextDataMgr:getText(800027,hour,min)
	else
		timeStr = timeStr..TextDataMgr:getText(800069,day,hour)
	end
	self.Label_open_time:setText(timeStr)

	local cfg = self.displayCfgs[self.bossData.dungeon]
	if #cfg.buffDescribe > 0 then
		self.Panel_buff:show()
		for i, v in ipairs(self.buff_panels) do
			if cfg.buffDescribe[i] then
				v:show()
				v.label_buff_name:setTextById(cfg.buffDescribe[i])
			else
				v:hide()
			end
		end
	else
		self.Panel_buff:hide()
	end

	self.LoadingBar_boss_stage:setPercent(self.newYearFubenInfo.round / 9 * 100)
	self.Label_stage_value:setText(self.newYearFubenInfo.round)
	self.Image_stage_bg:setPositionX(self.newYearFubenInfo.round / 9 * 356 - 178)
	self.label_curLv:setText("Lv."..self.newYearFubenInfo.round)
	self.Label_wave_value:setText("["..self.newYearFubenInfo.round.."/".."9".."]")
	self.Label_damege_value:setText(self.bossData.damage or "0")
	local maxScore = self.activityInfo.extendData.battlePointsReward[1] or 0
	local roundMax = self.activityInfo.extendData.battlePoints[1][2] or 0
	self.Label_score_value:setText(self.newYearFubenInfo.roundScore.."/"..roundMax)
	self.Label_total_score_value:setText(self.newYearFubenInfo.totalScore.."/"..maxScore)
end

function NewYearBossPreview:registerEvents()
	self.super.registerEvents(self)

	self.Button_battle:onClick(function ()
		local levelCfg = FubenDataMgr:getLevelCfg(self.bossData.dungeon)
    	local levelGroupCfg_ = FubenDataMgr:getLevelGroupCfg(levelCfg.levelGroupId)
		local chapterCfg_ = FubenDataMgr:getChapterCfg(levelGroupCfg_.dungeonChapterId)
		Utils:openView("fuben.FubenSquadView", chapterCfg_.type, self.bossData)
		AlertManager:closeLayer(self)
	end)
end


return NewYearBossPreview