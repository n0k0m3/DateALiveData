
local FubenSquadView = class("FubenSquadView", BaseLayer)

function FubenSquadView:initFormationData()
    self.moveFlag_ = false
    self.formationData_ = {}
    self.isRequestLimitHero_ = false
    self.name = "FubenSquadView"

    if self.levelCfg_ then
        local type_ = self.levelCfg_.heroLimitType
        self.isLimitHero_ = (type_ == EC_LimitHeroType.LIMIT_NJ or type_ == EC_LimitHeroType.LIMIT_J)
        self.isDisableHero_ = (type_ == EC_LimitHeroType.DISABLE)
        --限定模拟试炼类型
        self.isLimitSimulationTrialHero_ = (type_ ==  EC_LimitHeroType.SIMULATION_TRIAL_LOCK or type_ ==  EC_LimitHeroType.SIMULATION_TRIAL)    -- 限定 试炼精灵
        --是否包含试炼精灵
        self.isContainSimulationTrial = tobool(self.levelCfg_.limitDungeon == 1)
    end

    if self.isLimitHero_ then
        local levelFormation = FubenDataMgr:getLevelFormation(self.levelCid_)
        if levelFormation then
            self.formationData_ = FubenDataMgr:getInitFormation(self.levelCid_)
        else
            FubenDataMgr:send_DUNGEON_LIMIT_HERO_DUNGEON(self.levelCid_)
            self.isRequestLimitFormation_ = true
        end
    elseif self.isLimitSimulationTrialHero_ then
        self.formationData_ = FubenDataMgr:getInitFormation(self.levelCid_)
        HeroDataMgr:changeDataByFuben(self.levelCid_, self.formationData_)
    else
        self.formationData_ = FubenDataMgr:getInitFormation(self.levelCid_)
    end

    if not self.isRequestLimitFormation_ then
        if self.isLimitHero_ or self.isDisableHero_ then
            HeroDataMgr:changeDataByFuben(self.levelCid_, self.formationData_)
        end
    end
end

function FubenSquadView:initAssistanData()
    self.assistantNum_ = 10
    self.assistantData_ = {}
    self.isRequestAssistant_ = false
    local hero = FubenDataMgr:getAssistHero()
    if hero then
        self:updateAssistantData()
    else
        self.isRequestAssistant_ = true
        FubenDataMgr:send_PLAYER_REQ_HELP_FIGHT_PLAYERS()
    end
    local isComplete = TFAssetsManager:checkChapterComplete(EC_FBType.PLOT,3)
    local isUnlockChatper = FubenDataMgr:checkPlotChapterEnabled(3, EC_FBDiff.SIMPLE)
    self.isUnlockAssistant_ = isComplete and isUnlockChatper
end

function FubenSquadView:initEndlessData()
    self.endlessInfo_ = FubenDataMgr:getEndlessInfo()
    local endlessCfg = FubenDataMgr:getEndlessCloisterLevelCfg(self.endlessInfo_.curStage)
    self.endlessCloisterLevel_ = FubenDataMgr:getEndlessCloisterLevel(endlessCfg.week)
    self.showEndlessLevel_  = {}

    local count = 3
    local index = clamp(self.endlessInfo_.todayBest + 1, 1, #self.endlessCloisterLevel_)
    local preIndex = index - 1
    local nextIndex = index + 1
    table.insert(self.showEndlessLevel_, index)
    while #self.showEndlessLevel_ < count do
        if preIndex > 0 then
            table.insert(self.showEndlessLevel_, preIndex)
            preIndex = preIndex - 1
        end
        if #self.showEndlessLevel_ == count then
            break
        end
        if nextIndex <= #self.endlessCloisterLevel_ then
            table.insert(self.showEndlessLevel_, nextIndex)
            nextIndex = nextIndex + 1
        end
        if #self.showEndlessLevel_ == count then
            break
        end
    end
    table.sort(self.showEndlessLevel_, function(a, b)
                   return a > b
    end)
    self.selectEndlessLevel_ = index

    local buffLevelCid = {}
    for i, v in ipairs(self.showEndlessLevel_) do
        local levelCid = self.endlessCloisterLevel_[v]
        if FubenDataMgr:isEndlessRacingMode(levelCid) then
            table.insert(buffLevelCid, levelCid)
        end
    end
    if #buffLevelCid > 0 then
        FubenDataMgr:send_ENDLESS_CLOISTER_REQ_ENDLESS_BUFF(buffLevelCid)
    end
end

function FubenSquadView:initSpriteChallengeData()
    self.spriteChallengeInfo_ = FubenDataMgr:getSpriteChallengeInfo()
    self.levelCid_ = FubenDataMgr:getCurSpriteLevelCid()
    self.levelCfg_ = FubenDataMgr:getLevelCfg(self.levelCid_)
    self.spriteChallengeDungenCfg_ = FubenDataMgr:getSpriteChallengeCfg(self.levelCid_)
    local victoryParam = self.levelCfg_.victoryParam
    if self.levelCfg_.victoryType[1] == 3 then
        self.monsterCid_ = victoryParam[1][1]
        self.monsterCfg_ = TabDataMgr:getData("Monster", self.monsterCid_)
    else
        Utils:showTips(2106070)
    end

    self.spriteBuffCount_ = Utils:getKVP(25001, "time")
    self.spriteBuffCost_ = Utils:getKVP(25001, "cost")
end

function FubenSquadView:initSpriteExtraData()
    self.levelCid_ = FubenDataMgr:getSpriteExtraSelLevel()
    self.levelCfg_ = FubenDataMgr:getLevelCfg(self.levelCid_)
--    local victoryParam = self.levelCfg_.victoryParam
--    if self.levelCfg_.victoryType[1] == 1 then
--        self.monsterCid_ = victoryParam[1][1]
--        self.monsterCfg_ = TabDataMgr:getData("Monster", self.monsterCid_)
--    else
--        Utils:showTips("模拟试练副本通关条件配置错误")
--    end
end

function FubenSquadView:initHalloweenData(levelCid, maxmyScore)
	self.maxmyScore = maxmyScore
    self.levelCid_ = levelCid
    self.levelCfg_ = FubenDataMgr:getLevelCfg(levelCid)
end

function FubenSquadView:initPlotAndDailyData(levelCid, isDuelMod, challengeCount)
    self.levelCid_ = levelCid
    self.levelCfg_ = FubenDataMgr:getLevelCfg(levelCid)
    self.isDuelMod_ = tobool(isDuelMod)
    self.challengeCount_ = challengeCount
    self.calChallengeCount_ = math.max(1, self.challengeCount_)

    self:initFormationData()
    self:initAssistanData()
end

function FubenSquadView:initActivityData(chapterCid, ...)
    self.chapterCid_ = chapterCid
    if chapterCid == EC_ActivityFubenType.ENDLESS then
        self:initEndlessData(...)
        self:initFormationData()
    elseif chapterCid == EC_ActivityFubenType.SPRITE then
        self:initSpriteChallengeData(...)
        self:initFormationData()
    elseif chapterCid == EC_ActivityFubenType.SPRITE_EXTRA then
        self:initSpriteExtraData(...)
        self:initFormationData()
    elseif chapterCid == EC_ActivityFubenType.SIMULATION_TRIAL 
    or chapterCid == EC_ActivityFubenType.SIMULATION_TRIAL_2
    or chapterCid == EC_ActivityFubenType.SIMULATION_TRIAL_4 
    or chapterCid == EC_ActivityFubenType.SIMULATION_TRIAL_5 
    or chapterCid == EC_ActivityFubenType.SIMULATION_TRIAL_3 then
        local prams = {...}
        self.levelCid_ = prams[1] --关卡ID
        self.levelCfg_ = FubenDataMgr:getLevelCfg(self.levelCid_)
        self:initFormationData()
    end
end

function FubenSquadView:initHolidayData(chapterCid, ...)
	--Box(tostring(chapterCid))
    self.chapterCid_ = chapterCid
    if chapterCid == EC_ActivityFubenType.HALLOWEEN then
        self:initHalloweenData(...)
        self:initFormationData()
	elseif self.chapterCid_ == EC_ActivityFubenType.HALLOWEEN2019 then
		--self:initHalloweenData(...)
        self:initFormationData()
    elseif chapterCid == EC_ActivityFubenType.CHRISTMAS then
        self:initChristmas(...)
    end
end

function FubenSquadView:initChristmas(levelCid, isDuelMod, challengeCount)

    self.levelCid_ = levelCid
    self.levelCfg_ = FubenDataMgr:getLevelCfg(levelCid)
    self.isDuelMod_ = tobool(isDuelMod)
    self.challengeCount_ = challengeCount
    self.calChallengeCount_ = math.max(1, self.challengeCount_)

    self:initFormationData()
    self:initAssistanData()
end

function FubenSquadView:initTheaterBossData(levelCid, challengeCount)
    self.levelCid_ = levelCid
    self.challengeCount_ = challengeCount
    self.levelCfg_ = FubenDataMgr:getLevelCfg(self.levelCid_)
    self.theaterBossInfo_ = FubenDataMgr:getTheaterBossInfo()
    self:initFormationData()
end

function FubenSquadView:initSkyLadderData(chapterCid,levelCid)
    self.chapterCid_ = chapterCid
    self.levelCid_ = levelCid
    self.levelCfg_ = FubenDataMgr:getLevelCfg(self.levelCid_)
    self:initFormationData()
end

function FubenSquadView:initLeagueHunterData(levelCid)
    self.levelCid_ = levelCid
    self.levelCfg_ = FubenDataMgr:getLevelCfg(self.levelCid_)
    self:initFormationData()
end

function FubenSquadView:initKsanLevelData(data)
    self.levelCid_ = data.dungeon
    self.levelCfg_ = FubenDataMgr:getLevelCfg(self.levelCid_)
    self.fightTime = data.fightTime
    self.score = data.score
    self.pass = data.dunPass

    local activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.KUANGSAN_FUBEN)[1]
    self.ksanFubenActivityInfo  = ActivityDataMgr2:getActivityInfo(activityId)

    self:initFormationData()
end

function FubenSquadView:initData(fubenType, ...)

    dump({fubenType, {...}})
    self.fubenType_ = fubenType
    self.isDuelMod_ = false
    self.calChallengeCount_ = 1
    self.isLimitHero_ = false
    self.isDisableHero_ = false
    self.isLimitSimulationTrialHero_ = false
    self.challengeCount_ = 0
    self.calChallengeCount_ = math.max(1, self.challengeCount_)

    if self.fubenType_ == EC_FBType.PLOT
            or self.fubenType_ == EC_FBType.DAILY
            or self.fubenType_ == EC_FBType.NIANBREAST_LEVEL
            or self.fubenType_ == EC_FBType.MEMORY then
        self:initPlotAndDailyData(...)
    elseif self.fubenType_ == EC_FBType.ACTIVITY then
        self:initActivityData(...)
    elseif self.fubenType_ == EC_FBType.HOLIDAY or self.fubenType_ == EC_FBType.HOLIDAY2 then
        self:initHolidayData(...)
    elseif self.fubenType_ == EC_FBType.THEATER or 
            self.fubenType_ == EC_FBType.LINKAGE then
        self:initPlotAndDailyData(...)
    elseif self.fubenType_ == EC_FBType.THEATER_BOSS then
        self:initTheaterBossData(...)
    elseif self.fubenType_ == EC_FBType.THEATER_HARD then
        self:initPlotAndDailyData(...)
    elseif self.fubenType_ == EC_FBType.SKYLADDER then
        self:initSkyLadderData(...)
    elseif self.fubenType_ == EC_FBType.HUNTER then
        self:initLeagueHunterData(...)
    elseif self.fubenType_ == EC_FBType.KSAN_FUBEN then
        self:initKsanLevelData(...)
    end
end

function FubenSquadView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
	--Box(self.chapterCid_)
	if self.chapterCid_ == EC_ActivityFubenType.HALLOWEEN then
		self.topBarFileName = "FubenSquadViewEx"
    elseif self.fubenType_ == EC_FBType.KSAN_FUBEN then
        self.topBarFileName = "FubenSquadViewKsan"
	end	
    self:init("lua.uiconfig.fuben.fubenSquadView")
end

function FubenSquadView:initUI(ui)
    self.super.initUI(self, ui)
    self:addLockLayer()

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Image_kSanFuben = TFDirector:getChildByPath(ui, "Image_kSanFuben")
    self.Panel_assistantItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_assistantItem")
    self.Panel_endlessItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_endlessItem")
    self.Panel_buffItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_buffItem")
    self.Panel_cardItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_cardItem")
    self.Panel_effect_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_effect_item")
    self.Image_card_cost = TFDirector:getChildByPath(self.Panel_prefab, "Image_card_cost")

    self.Panel_formation = TFDirector:getChildByPath(self.Panel_root, "Panel_formation"):hide()
    self.Image_kSanFuben:setVisible(self.fubenType_ == EC_FBType.KSAN_FUBEN)
    local Panel_formation1 = TFDirector:getChildByPath(self.Panel_root, "Panel_formation1"):hide()
    if self.fubenType_ == EC_FBType.KSAN_FUBEN then
        self.Panel_formation = Panel_formation1
    end
    self.Image_kSanFuben:setVisible(self.fubenType_ == EC_FBType.KSAN_FUBEN)

    self.Panel_assistant = TFDirector:getChildByPath(self.Panel_root, "Panel_assistant"):hide()
    self.Panel_endless = TFDirector:getChildByPath(self.Panel_root, "Panel_endless"):hide()
    self.Panel_sprite = TFDirector:getChildByPath(self.Panel_root, "Panel_sprite"):hide()
    self.Panel_experience = TFDirector:getChildByPath(self.Panel_root, "Panel_experience"):hide()
    self.Panel_halloween = TFDirector:getChildByPath(self.Panel_root, "Panel_halloween"):hide()
    self.Panel_theater = TFDirector:getChildByPath(self.Panel_root, "Panel_theater"):hide()
    self.Panel_League_Hunting = TFDirector:getChildByPath(self.Panel_root, "Panel_League_Hunting"):hide()
    self.Panel_halloween2019 = TFDirector:getChildByPath(self.Panel_root, "Panel_halloween2019"):hide()
    self.Panel_KuangSan = TFDirector:getChildByPath(self.Panel_root, "Panel_KuangSan"):hide()

    self.Panel_skyladder = TFDirector:getChildByPath(self.Panel_root, "Panel_skyladder"):hide()
    local ScrollView_zone_effect = TFDirector:getChildByPath(self.Panel_skyladder, "ScrollView_zone_effect")
    self.ListViewView_zone_effect = UIListView:create(ScrollView_zone_effect)
    local ScrollView_card_cost = TFDirector:getChildByPath(self.Panel_skyladder, "ScrollView_card_cost")
    self.ListViewView_card_cost = UIListView:create(ScrollView_card_cost)
    self.Button_ladder_tip = TFDirector:getChildByPath(self.Panel_skyladder,"Button_ladder_tip")
    self.Image_equip_tip = TFDirector:getChildByPath(self.Panel_skyladder,"Image_equip_tip"):hide()
    self.Button_optimize = TFDirector:getChildByPath(self.Panel_skyladder, "Button_optimize"):hide()
    self.Label_optimize = TFDirector:getChildByPath(self.Button_optimize, "Label_fighting")

    self.Panel_KuangSan = TFDirector:getChildByPath(self.Panel_root, "Panel_KuangSan"):hide()


    self.equipCardBtn = {}
    for i=1,3 do
        local tab = {}
        tab.btnNone = TFDirector:getChildByPath(self.Panel_skyladder, "Button_equip_card_"..i)
        tab.Panel_cardItem = TFDirector:getChildByPath(tab.btnNone, "Panel_cardItem")
        tab.Image_card_disabled = TFDirector:getChildByPath(tab.btnNone, "Image_card_disabled")
        tab.Button_card = TFDirector:getChildByPath(tab.Panel_cardItem, "Button_card")
        tab.Image_card_type = TFDirector:getChildByPath(tab.Button_card, "Image_card_type")
        tab.Label_card_lv = TFDirector:getChildByPath(tab.Button_card, "Label_card_lv")
        tab.Image_card = TFDirector:getChildByPath(tab.Button_card, "Image_card")
        tab.Label_ladder_cnt = TFDirector:getChildByPath(tab.Button_card, "Label_ladder_cnt")
        local ScrollView_cost = TFDirector:getChildByPath(tab.Button_card, "ScrollView_cost")
        tab.ListView_cost = UIListView:create(ScrollView_cost)
        tab.ListView_cost:setItemsMargin(-5)
        tab.Label_card_name = TFDirector:getChildByPath(tab.Button_card, "Label_card_name")
        tab.Image_effect_down = TFDirector:getChildByPath(tab.Button_card, "Image_effect_down")
        table.insert(self.equipCardBtn,tab)
    end

    self.Label_myTeam = TFDirector:getChildByPath(self.Panel_formation, "Label_myTeam")
    self.Label_myTeam2 = TFDirector:getChildByPath(self.Panel_formation, "Label_myTeam2")
    self.Label_captain = TFDirector:getChildByPath(self.Panel_formation, "Label_captain")

    if self.fubenType_ == EC_FBType.KSAN_FUBEN then
        self.Label_myTeam:setColor(ccc3(191,56,58))
        self.Label_myTeam2:setColor(ccc3(191,56,58))
        self.Label_captain:setColor(ccc3(191,56,58))
    end

    self.Panel_member = {}
    for i = 1, 3 do
        local item = {}
        item.root = TFDirector:getChildByPath(self.Panel_formation, "Panel_memeber_" .. i)
        item.Panel_role = TFDirector:getChildByPath(item.root, "Panel_role"):hide()
        item.Button_head = TFDirector:getChildByPath(item.root, "Button_head")
        item.Panel_model = TFDirector:getChildByPath(item.Panel_role, "Panel_model")
        item.Image_captain = TFDirector:getChildByPath(item.Panel_role, "Image_captain")
        item.Label_name = TFDirector:getChildByPath(item.Panel_role, "Label_name")
        item.Image_limit_type = TFDirector:getChildByPath(item.Panel_role, "Image_limit_type")
        item.Label_limit_type = TFDirector:getChildByPath(item.Image_limit_type, "Label_limit_type")
        item.Image_disable_type = TFDirector:getChildByPath(item.Panel_role, "Image_disable_type")
        item.Label_disable_type = TFDirector:getChildByPath(item.Image_disable_type, "Label_disable_type")
        item.Image_try_type = TFDirector:getChildByPath(item.root, "Image_try_type")
        item.Label_try_type = TFDirector:getChildByPath(item.Image_try_type, "Label_try_type")
        item.Panel_add = TFDirector:getChildByPath(item.root, "Panel_add"):hide()
        item.Button_add = TFDirector:getChildByPath(item.Panel_add, "Button_add")
        item.Label_empty = TFDirector:getChildByPath(item.Panel_add, "Label_empty")
        item.Panel_lock = TFDirector:getChildByPath(item.root, "Panel_lock"):hide()
        item.Button_lock = TFDirector:getChildByPath(item.Panel_lock, "Button_lock")
        item.Image_hp = TFDirector:getChildByPath(item.Panel_role, "Image_hp"):hide()
        item.Label_hp = TFDirector:getChildByPath(item.Image_hp, "Label_hp")
        item.LoadingBar_hp_progress = TFDirector:getChildByPath(item.Image_hp, "Image_hp_progress.LoadingBar_hp_progress")
        item.Label_hp_percent = TFDirector:getChildByPath(item.Image_hp, "Label_hp_percent")
        item.Image_endless_dead = TFDirector:getChildByPath(item.Panel_role, "Image_endless_dead"):hide()
        item.Label_endless_dead = TFDirector:getChildByPath(item.Image_endless_dead, "Label_endless_dead")
        item.Label_endless_dead:setTextById(310018)
        item.Image_skayladder = TFDirector:getChildByPath(item.Panel_role, "Image_skayladder"):hide()
        item.Label_remain_cnt = TFDirector:getChildByPath(item.Image_skayladder, "Label_remain_cnt")
        item.Button_check = TFDirector:getChildByPath(item.Image_skayladder, "Button_check")

        --创建克制icon
        local startPos = item.Label_name:getPosition() + ccp(150 , -100)
        item.panel_element = Utils:createElementPanel(item.Panel_role , 1 , startPos , nil , 0.5)

        --item.Panel_mojin_coin = TFDirector:getChildByPath(item.Panel_role, "Panel_mojin_coin"):hide()
	   item.Panel_ksan_coin = TFDirector:getChildByPath(item.Panel_role, "Panel_ksan_coin"):hide()
        if self.fubenType_ == EC_FBType.KSAN_FUBEN then
            item.Button_add:setTextureNormal("ui/activity/kuangsan_fuben/fightReady/006.png")
        end
        self.Panel_member[i] = item
    end

    self.Label_assistant = TFDirector:getChildByPath(self.Panel_assistant, "Label_assistant")
    self.Label_assistant2 = TFDirector:getChildByPath(self.Panel_assistant, "Label_assistant2")
    local Panel_assistantSite = TFDirector:getChildByPath(self.Panel_assistant, "Panel_assistantSite")
    self.Panel_role = TFDirector:getChildByPath(Panel_assistantSite, "Panel_role"):hide()
    self.Image_color = TFDirector:getChildByPath(Panel_assistantSite, "Image_color")
    self.Panel_model = TFDirector:getChildByPath(self.Panel_role, "Panel_model")
    self.Label_name = TFDirector:getChildByPath(self.Panel_role, "Label_name")
    self.Panel_add = TFDirector:getChildByPath(Panel_assistantSite, "Panel_add"):hide()
    self.Label_empty = TFDirector:getChildByPath(self.Panel_add, "Label_empty")
    self.Panel_lock = TFDirector:getChildByPath(Panel_assistantSite, "Panel_lock"):hide()
    self.Button_lock = TFDirector:getChildByPath(self.Panel_lock, "Button_lock")
    self.Panel_add:setVisible(self.isUnlockAssistant_)
    self.Panel_lock:setVisible(not self.isUnlockAssistant_)
    --创建克制icon
    local startPos = self.Label_name:getPosition() + ccp(160 , 0)
    self.panel_element = Utils:createElementPanel(self.Panel_role , 1 , startPos , nil , 0.5)


    self.Image_cost = TFDirector:getChildByPath(self.Panel_root, "Image_cost")
    self.Label_costNum = TFDirector:getChildByPath(self.Image_cost, "Label_costNum")
    self.Image_costIcon = TFDirector:getChildByPath(self.Image_cost, "Image_costIcon")
    self.Label_cost = TFDirector:getChildByPath(self.Image_cost, "Label_cost")
    self.Button_fighting = TFDirector:getChildByPath(self.Panel_root, "Button_fighting")

    self.Panel_assistantList = TFDirector:getChildByPath(self.Panel_root, "Panel_assistantList")
    local tableView = TFTableView:create()
    local tableViewSize = self.Panel_assistantList:getContentSize()
    tableView:setTableViewSize(CCSizeMake(tableViewSize.width, tableViewSize.height))
    tableView:setDirection(TFTableView.TFSCROLLVERTICAL)
    tableView:setPosition(self.Panel_assistantList:getPosition())
    tableView:setAnchorPoint(self.Panel_assistantList:getAnchorPoint())
    self.TableView_assistant = tableView
    self.Panel_assistantList:getParent():addChild(self.TableView_assistant, 1)
    self.TableView_assistant:addMEListener(TFTABLEVIEW_TOUCHED, handler(self.tableCellTouched, self))
    self.TableView_assistant:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.cellSizeForTable, self))
    self.TableView_assistant:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex, self))
    self.TableView_assistant:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCellsInTableView, self))
    self.TableView_assistant:addMEListener(TFTABLEVIEW_CELLISBEGIN, handler(self.cellBegin, self))
    self.TableView_assistant:addMEListener(TFTABLEVIEW_CELLISEND, handler(self.cellEnd, self))
    self.TableView_assistant:setVerticalFillOrder(0)

    self.Label_endlessName = TFDirector:getChildByPath(self.Panel_endless, "Label_endlessName")
    self.Label_endlessName_en = TFDirector:getChildByPath(self.Panel_endless, "Label_endlessName_en")
    local ScrollView_endless = TFDirector:getChildByPath(self.Panel_endless, "ScrollView_endless")
    self.ListView_endless = UIListView:create(ScrollView_endless)

    local Image_sprite_raiders = TFDirector:getChildByPath(self.Panel_sprite, "Image_sprite_raiders")
    self.Label_sprite_raiders = TFDirector:getChildByPath(Image_sprite_raiders, "Label_sprite_raiders")
    self.Label_sprite_cizhui = TFDirector:getChildByPath(Image_sprite_raiders, "Label_sprite_cizhui")
    self.Label_sprite_raiders_title = TFDirector:getChildByPath(Image_sprite_raiders, "Label_sprite_raiders_title")
    self.Label_sprite_raiders_titleEn = TFDirector:getChildByPath(Image_sprite_raiders, "Label_sprite_raiders_titleEn")

    local Image_sprite_buff = TFDirector:getChildByPath(self.Panel_sprite, "Image_sprite_buff")
    self.Image_gain_icon = TFDirector:getChildByPath(Image_sprite_buff, "Image_gain_icon")
    self.Spine_gain_effect = TFDirector:getChildByPath(self.Image_gain_icon, "Spine_gain_effect"):hide()
    self.Label_gain_attr = TFDirector:getChildByPath(Image_sprite_buff, "Label_gain_attr")
    self.Label_gain_title = TFDirector:getChildByPath(Image_sprite_buff, "Label_gain_title")

    local Image_sprite_cost = TFDirector:getChildByPath(self.Panel_sprite, "Image_sprite_cost")
    self.Label_sprite_costNum = TFDirector:getChildByPath(Image_sprite_cost, "Label_sprite_costNum")
    self.Image_sprite_costIcon = TFDirector:getChildByPath(self.Label_sprite_costNum, "Image_sprite_costIcon")
    self.Button_sprite_switch = TFDirector:getChildByPath(Image_sprite_cost, "Button_sprite_switch")
    self.Label_sprite_free = TFDirector:getChildByPath(Image_sprite_cost, "Label_sprite_free")
    self.Label_sprite_costTitle = TFDirector:getChildByPath(Image_sprite_cost, "Label_sprite_costTitle")

    self:refreshView()
end

function FubenSquadView:calMoveRect()
    self.moveRect_ = {}
    for i, v in ipairs(self.Panel_member) do
        local anchorPoint = v.root:getAnchorPoint()
        local size = v.root:getContentSize()
        local offset = ccp(size.width * anchorPoint.x, size.height * anchorPoint.y)
        local pos = v.root:getPosition()
        local origin = me.pSub(pos, offset)
        self.moveRect_[i] = me.rect(origin.x, origin.y, size.width, size.height)
    end
end

function FubenSquadView:showEndless()
    self.Label_endlessName:setTextById(2105001)

    for i, v in ipairs(self.showEndlessLevel_) do
        local endlessCfg = FubenDataMgr:getEndlessCloisterLevelCfg(self.endlessCloisterLevel_[v])
        local Panel_endlessItem = self.Panel_endlessItem:clone()
        local Image_icon = TFDirector:getChildByPath(Panel_endlessItem, "Image_icon")
        local Label_level = TFDirector:getChildByPath(Panel_endlessItem, "Label_level")
        local Image_select = TFDirector:getChildByPath(Panel_endlessItem, "Image_select")
        local ScrollView_reward = TFDirector:getChildByPath(Panel_endlessItem, "ScrollView_reward")
        local ListView_reward = UIListView:create(ScrollView_reward)
        local Image_pass = TFDirector:getChildByPath(Panel_endlessItem, "Image_pass")
        local Label_pass = TFDirector:getChildByPath(Image_pass, "Label_pass")
        local Image_other_diban = TFDirector:getChildByPath(Panel_endlessItem, "Image_other_diban")
        local Image_boss_diban = TFDirector:getChildByPath(Panel_endlessItem, "Image_boss_diban")
        local Image_buffInfo = TFDirector:getChildByPath(Panel_endlessItem, "Image_buffInfo"):hide()

        Image_other_diban:setVisible(endlessCfg.type ~= EC_EndlessLevelType.BOSS)
        Image_boss_diban:setVisible(endlessCfg.type == EC_EndlessLevelType.BOSS)
        Image_select:setVisible(v == self.selectEndlessLevel_)
        Image_pass:setVisible(v <= self.endlessInfo_.todayBest)
        Label_level:setTextById(2100016, v)
        Label_pass:setTextById(2105002)
        Image_icon:setVisible(#endlessCfg.floorIcon > 0)
        if Image_icon:isVisible() then
            Image_icon:setTexture(endlessCfg.floorIcon)
        end

        local multipleReward, extraReward = ActivityDataMgr2:getDropReward(endlessCfg.reward)
        -- 掉落活动额外掉落
        for i, v in ipairs(extraReward) do
            local Panel_dropGoodsItem = PrefabDataMgr:getPrefab("Panel_dropGoodsItem"):clone()
            Panel_dropGoodsItem:Scale(0.7)
            PrefabDataMgr:setInfo(Panel_dropGoodsItem, {v}, EC_DropShowType.ACTIVITY_EXTRA)
            ListView_reward:pushBackCustomItem(Panel_dropGoodsItem)
        end
        -- 基础掉落
        for _, itemCid in ipairs(endlessCfg.dropShow) do
            local Panel_dropGoodsItem = PrefabDataMgr:getPrefab("Panel_dropGoodsItem"):clone()
            Panel_dropGoodsItem:Scale(0.7)
            local multiple = multipleReward[itemCid]
            local flag = 0
            local arg = {}
            if multiple then
                flag = bit.bor(flag, EC_DropShowType.ACTIVITY_MULTIPLE)
                arg.multiple = multiple
            end
            PrefabDataMgr:setInfo(Panel_dropGoodsItem, {itemCid}, flag, arg)
            ListView_reward:pushBackCustomItem(Panel_dropGoodsItem)
        end

        self.ListView_endless:pushBackCustomItem(Panel_endlessItem)
    end
    Utils:setAliginCenterByListView(self.ListView_endless, false)
end


function FubenSquadView:showHalloween2019()

	self.levelPassState_ = {}
	self.levelprogressInfo_ = {}
	local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.HALLOWEEN)
	if #activity > 0 then
		self.activityId_ = activity[1]
        self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
		print("--------------------------------------------------------------------------------------------FubenHalloweenLevelView:initData")
		dump(self.activityInfo_)

		for i, v in ipairs(self.activityInfo_.items) do
			local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, v)
			if itemInfo.subType == EC_Activity_Assist_Subtype.LEVEL then
				local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, v)
				local levelCid = itemInfo.extendData.jumpInterface 
				print("levelCid=" .. levelCid)
				--self.maxCount_ = self.maxCount_ + 1
				--if progressInfo.status == 1 then
					--self.passCount_ = self.passCount_ + 1
				--end
				--table.insert(self.level_, levelCid)
				self.levelPassState_[levelCid] = (progressInfo.status == 1)
				self.levelprogressInfo_[levelCid] = progressInfo
			elseif itemInfo.subType == EC_Activity_Assist_Subtype.TASK then
				--table.insert(self.task_, v)
				print("TASK=" .. v)
			end
		end
		
    else
        Utils:showTips(219007)
        --return
    end
	
	--设置背景
	local Image_bg = TFDirector:getChildByPath(self.ui, "Image_bg")
	Image_bg:setTexture("ui/Halloween/Battle/BG.png")
	
	local halloweendungeon = TabDataMgr:getData("HalloweenDungeon", self.levelCid_)
	if not halloweendungeon then
		--Box("1=" .. self.levelCid_)
		return
	end
	
	print("self.levelCid_=" .. self.levelCid_)
	--设置关卡内容
	local Image_halloween_desc = TFDirector:getChildByPath(self.Panel_halloween2019, "Image_halloween_desc")
	local Image_halloween_desc_Label_fubenSquadView_1 = TFDirector:getChildByPath(Image_halloween_desc, "Label_fubenSquadView_1")
	local Image_halloween_desc_Label_fubenSquadView_2 = TFDirector:getChildByPath(Image_halloween_desc, "Label_fubenSquadView_2")
	Image_halloween_desc_Label_fubenSquadView_1:setTextById(3005037)
	--dump(self.levelCfg_)

	local victoryParam = self.levelCfg_.victoryParam
    if self.levelCfg_.victoryType[1] == 3 then
        monsterCid_ = victoryParam[1][1]
        monsterCfg_ = TabDataMgr:getData("Monster", monsterCid_)
		--dump(monsterCfg_)
		Image_halloween_desc_Label_fubenSquadView_2:setTextById(self.levelCfg_.victoryTypeDescribe[1], TextDataMgr:getText(monsterCfg_.name),victoryParam[1][2])
    else
		Image_halloween_desc_Label_fubenSquadView_2:setTextById(self.levelCfg_.victoryTypeDescribe[1])
	end
	
	--[[victoryParam
	 local text = ""
     for i,textId in ipairs(self.levelCfg_.victoryTypeDescribe) do
         if string.len(text) > 0 then 
             text = text .. "\n"
         end
         text = text ..TextDataMgr:getText(textId)
     end
	]]
	

	local Image_halloween_desc2 = TFDirector:getChildByPath(self.Panel_halloween2019, "Image_halloween_desc2")
	local Image_halloween_desc2_Label_fubenSquadView_1 = TFDirector:getChildByPath(Image_halloween_desc2, "Label_fubenSquadView_1")
	local Image_halloween_desc2_Label_fubenSquadView_2 = TFDirector:getChildByPath(Image_halloween_desc2, "Label_fubenSquadView_2")
	if halloweendungeon.type == 1 then
		Image_halloween_desc2:hide()
	else
		if halloweendungeon.type == 4 then
			if not self.maxmyScore or self.maxmyScore < 0 then
				Image_halloween_desc2:hide()
			else	
				dump(self.levelprogressInfo_[self.levelCid_])
				Image_halloween_desc2:show()
				Image_halloween_desc2_Label_fubenSquadView_1:setTextById(halloweendungeon.levelTitle)
				local d, hour, min, sec = Utils:getTimeDHMZ(self.maxmyScore * 0.001,true)
				
				--print(halloweendungeon.levelDetail)
				
				Image_halloween_desc2_Label_fubenSquadView_2:setTextById(halloweendungeon.levelDetail, min .. ":" .. sec)
			end
		else
			Image_halloween_desc2:show()
			Image_halloween_desc2_Label_fubenSquadView_1:setTextById(halloweendungeon.levelTitle)
			Image_halloween_desc2_Label_fubenSquadView_2:setTextById(halloweendungeon.levelDetail)
		end
		
	end
	
	local Image_halloween_desc3 = TFDirector:getChildByPath(self.Panel_halloween2019, "Image_halloween_desc3")
	local Image_halloween_desc3_Label_fubenSquadView_1 = TFDirector:getChildByPath(Image_halloween_desc3, "Label_fubenSquadView_1")
	local Image_halloween_desc3_ScrollView_fubenSquadView_1 = TFDirector:getChildByPath(Image_halloween_desc3, "ScrollView_fubenSquadView_1")
	
	local scrollView_Items = UIListView:create(Image_halloween_desc3_ScrollView_fubenSquadView_1)
	local items = self.levelCfg_.dropShow 
	Image_halloween_desc3_Label_fubenSquadView_1:setTextById(2101010)

	
	if not self.levelPassState_[self.levelCid_] and  self.levelCfg_.firstDropShow and #self.levelCfg_.firstDropShow > 0 then
		--Box("firstDropShow")
		Image_halloween_desc3_Label_fubenSquadView_1:setTextById(14110286)
		items = self.levelCfg_.firstDropShow
	end
	for i = 1, #items do
		local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:Scale(0.6)
        scrollView_Items:pushBackCustomItem(Panel_goodsItem)
        PrefabDataMgr:setInfo(Panel_goodsItem, items[i], nil)
	end
	
	
	
end

function FubenSquadView:showHalloween()
    local Image_halloween_desc = TFDirector:getChildByPath(self.Panel_halloween, "Image_halloween_desc")
    local Label_halloween_desc_title = TFDirector:getChildByPath(Image_halloween_desc, "Label_halloween_desc_title")
    local Label_halloween_desc = TFDirector:getChildByPath(Image_halloween_desc, "Label_halloween_desc")
    local Panel_halloween_target = TFDirector:getChildByPath(self.Panel_halloween, "Panel_halloween_target")
    local Label_halloween_target_title = TFDirector:getChildByPath(Panel_halloween_target, "Label_halloween_target_title")
    local Label_halloween_target = TFDirector:getChildByPath(Panel_halloween_target, "Label_halloween_target")

    Label_halloween_target_title:setTextById(2100049)
    local desc = FubenDataMgr:getPassCondDesc(self.levelCid_, 1)
    Label_halloween_target:setText(desc)
    local chineseNumber = Utils:getChineseNumber(self.levelCfg_.num)
    Label_halloween_desc:setTextById(self.levelCfg_.plotBrief)
end

function FubenSquadView:showKsanLevelData()
    dump(self.levelCfg_)

    local Image_Ksan_buff = TFDirector:getChildByPath(self.Panel_KuangSan, "Image_Ksan_buff"):hide()
    local Panel_grade = TFDirector:getChildByPath(self.Panel_KuangSan, "Panel_grade"):hide()
    local ScrollView_award = TFDirector:getChildByPath(self.Panel_KuangSan, "ScrollView_award")
    local cfg = FubenDataMgr:getKsanLevelInfo(self.levelCid_)
    if not cfg then
        Box(self.levelCid_ .. "在KurumiDungeonCity中找不到")
        return
    end
    local displayDetail = cfg.displayDetail

    Image_Ksan_buff:setVisible(displayDetail == 2)
    Panel_grade:setVisible(displayDetail == 3)

    if displayDetail == 2 then
        local ScrollView_buff = TFDirector:getChildByPath(Image_Ksan_buff, "ScrollView_buff")
        local listview_buff = UIListView:create(ScrollView_buff)
        local Label_Ksan_buff_desc = TFDirector:getChildByPath(Image_Ksan_buff, "Label_Ksan_buff_desc"):hide()
        for k,v in ipairs(cfg.buffDescribe) do
            local buffDesc = Label_Ksan_buff_desc:clone()
            buffDesc:show()
            buffDesc:setTextById(v)
            buffDesc:setDimensions(400,0)
            listview_buff:pushBackCustomItem(buffDesc)
        end
    end

    if displayDetail == 3 then
        local Image_boss_icon = TFDirector:getChildByPath(Panel_grade, "Image_boss_icon")
        Image_boss_icon:setTexture(cfg.devilIcon)


        local Label_time = TFDirector:getChildByPath(Panel_grade, "Label_time")
        if not self.fightTime then
            Label_time:setText("")
        else
            local day, hour, min, sec = Utils:getTimeDHMZ(self.fightTime/1000, true)
            Label_time:setText(min..":"..sec)
        end

        local Image_score_icon = TFDirector:getChildByPath(Panel_grade, "Image_score_icon")
        local Label_score = TFDirector:getChildByPath(Panel_grade, "Label_score")
        
        if not self.score then
            Label_score:setText("")
            Image_score_icon:setVisible(false)
        else
            Label_score:setText(self.score)
            Image_score_icon:setVisible(true)
            local posx = Label_score:getPositionX() - Label_score:getContentSize().width - 2
            Image_score_icon:setPositionX(posx)
        end
    end

    local Label_Ksan_level_desc = TFDirector:getChildByPath(self.Panel_KuangSan, "Label_Ksan_level_desc")
    local victoryParam = self.levelCfg_.victoryParam
    if self.levelCfg_.victoryType[1] == 3 then
        local monsterCid_ = victoryParam[1][1]
        local monsterCfg_ = TabDataMgr:getData("Monster", monsterCid_)
        local monserName = TextDataMgr:getText(monsterCfg_.name)
        Label_Ksan_level_desc:setTextById(self.levelCfg_.victoryTypeDescribe[1], monserName,victoryParam[1][2])
    else
        Label_Ksan_level_desc:setTextById(self.levelCfg_.victoryTypeDescribe[1])
    end

    ----显示奖励
    local listview_reward = UIListView:create(ScrollView_award)
    local isLevelPass = self.pass
    local dropCid, showReward, isFirstPass
    if isLevelPass then
        dropCid = self.levelCfg_.reward
        showReward = self.levelCfg_.dropShow
        isFirstPass = false
    else
        dropCid = self.levelCfg_.firstReward
        showReward = self.levelCfg_.firstDropShow
        isFirstPass = true
    end
    listview_reward:removeAllItems()
    local multipleReward, extraReward = ActivityDataMgr2:getDropReward(dropCid)
    -- 掉落活动额外掉落
    for i, v in ipairs(extraReward) do
        local Panel_dropGoodsItem = PrefabDataMgr:getPrefab("Panel_dropGoodsItem"):clone()
        Panel_dropGoodsItem:Scale(0.6)
        PrefabDataMgr:setInfo(Panel_dropGoodsItem, {v}, EC_DropShowType.ACTIVITY_EXTRA)
        listview_reward:pushBackCustomItem(Panel_dropGoodsItem)
    end
    -- 基础掉落
    for i, v in ipairs(showReward) do
        local Panel_dropGoodsItem = PrefabDataMgr:getPrefab("Panel_dropGoodsItem"):clone()
        Panel_dropGoodsItem:Scale(0.6)
        local flag = 0
        local arg = {}
        local multiple = multipleReward[v]
        if multiple then
            flag = bit.bor(flag, EC_DropShowType.ACTIVITY_MULTIPLE)
            arg.multiple = multiple
        end
        if isFirstPass then
            flag = bit.bor(flag, EC_DropShowType.FIRST_PASS)
        end
        PrefabDataMgr:setInfo(Panel_dropGoodsItem, {v}, flag, arg)
        listview_reward:pushBackCustomItem(Panel_dropGoodsItem)
    end
end

function FubenSquadView:refreshView()
	--Box("self.fubenType_=" .. self.fubenType_)
    if self.fubenType_ == EC_FBType.PLOT 
        or self.fubenType_ == EC_FBType.DAILY 
        or self.fubenType_ == EC_FBType.NIANBREAST_LEVEL
        or self.fubenType_ == EC_FBType.MEMORY then
        self.Panel_assistant:show()
        self.Panel_formation:show()
    elseif self.fubenType_ == EC_FBType.ACTIVITY then
        if self.chapterCid_ == EC_ActivityFubenType.ENDLESS then
            self.Panel_formation:show()
            self.Panel_endless:show()
        elseif self.chapterCid_ == EC_ActivityFubenType.SPRITE then
            self.Panel_sprite:show()
            self.Panel_formation:show()
        elseif self.chapterCid_ == EC_ActivityFubenType.SPRITE_EXTRA then
            --desc
            self.Panel_experience:show()
            self.Panel_formation:show()
        elseif self.chapterCid_ == EC_ActivityFubenType.SIMULATION_TRIAL 
            or self.chapterCid_ == EC_ActivityFubenType.SIMULATION_TRIAL_2
            or self.chapterCid_ == EC_ActivityFubenType.SIMULATION_TRIAL_4
            or self.chapterCid_ == EC_ActivityFubenType.SIMULATION_TRIAL_5
            or self.chapterCid_ == EC_ActivityFubenType.SIMULATION_TRIAL_3 then
            self.Panel_experience:show()
            self.Panel_formation:show()
        end
    elseif self.fubenType_ == EC_FBType.HOLIDAY or self.fubenType_ == EC_FBType.HOLIDAY2 then
        if self.chapterCid_ == EC_ActivityFubenType.HALLOWEEN then
            self.Panel_formation:show()
            --self.Panel_halloween:show()
			self.Panel_halloween2019:show()
		elseif self.chapterCid_ == EC_ActivityFubenType.HALLOWEEN2019 then
			self.Panel_formation:show()
            self.Panel_halloween2019:show()
        elseif self.chapterCid_ == EC_ActivityFubenType.CHRISTMAS then
            self.Panel_assistant:show()
            self.Panel_formation:show()
        end
    elseif self.fubenType_ == EC_FBType.THEATER or self.fubenType_ == EC_FBType.THEATER_HARD 
        or self.fubenType_ == EC_FBType.LINKAGE then
        self.Panel_assistant:show()
        self.Panel_formation:show()
    elseif self.fubenType_ == EC_FBType.THEATER_BOSS then
        self.Panel_formation:show()
        self.Panel_theater:show()
    elseif self.fubenType_ == EC_FBType.SKYLADDER then
        self.Panel_formation:show()
        self.Panel_skyladder:show()
    elseif self.fubenType_ == EC_FBType.HUNTER then -- 社团追猎计划战斗类型
        self.Panel_formation:show()
        self.Panel_League_Hunting:show()
    elseif self.fubenType_ == EC_FBType.KSAN_FUBEN then
        self.Panel_formation:show()
        self.Panel_KuangSan:show()
    end

    if self.levelCfg_ then
        local cost = self.levelCfg_.cost[1]
        if cost then
            self.Image_cost:show()
            local costItemCfg = GoodsDataMgr:getItemCfg(cost[1])
            self.Image_costIcon:setTexture(costItemCfg.icon)
            self.Label_costNum:setText(cost[2] * self.calChallengeCount_)
        else
            self.Image_cost:hide()
        end
        self.Label_cost:setTextById(300020)
    else
        self.Image_cost:hide()
    end

    if self.Panel_formation:isVisible() then
        self:calMoveRect()

        self.Label_myTeam:setTextById(300010)
        self.Label_empty:setTextById(300018)
        self.Label_assistant:setTextById(300019)

        if not self.isRequestLimitFormation_ then
            self:updateFormation()
        end
    end

    if self.Panel_assistant:isVisible() then
        if not self.isRequestAssistant_ then
            self.TableView_assistant:reloadData()
        end
        self:addCountDownTimer()
    end

    if self.Panel_endless:isVisible() then
        self:showEndless()
    end

    if self.Panel_sprite:isVisible() then
        self:showSprite()
    end

    if self.Panel_experience:isVisible() then
        self:showExperience()
    end

    if self.Panel_halloween:isVisible() then
        self:showHalloween()
    end
	
	if self.Panel_halloween2019:isVisible() then
        self:showHalloween2019()
    end

    if self.Panel_theater:isVisible() then
        self:showTheater()
    end

    if self.fubenType_ == EC_FBType.SKYLADDER then
        self:updateSkyLadderInfo()
    end

    if self.fubenType_ == EC_FBType.HUNTER then -- 社团追猎计划战斗类型 
        self:updateLeagueHuntingInfo()
    end

    if self.fubenType_ == EC_FBType.KSAN_FUBEN then
        self:showKsanLevelData()
    end
end

function FubenSquadView:showExperience()
    local desc_label = TFDirector:getChildByPath(self.Panel_experience, "Label_desc_desc")
    desc_label:setString(FubenDataMgr:getPassCondDesc(self.levelCid_, 1))
    local reward_scroll = TFDirector:getChildByPath(self.Panel_experience, "ScrollView_reward")
    local Panel_reward_prev = TFDirector:getChildByPath(self.Panel_experience, "Panel_reward_prev"):show()
    local listview_reward = UIListView:create(reward_scroll)
    local isLevelPass = FubenDataMgr:isSpriteExtraLevelPass(self.levelCid_)
    --新模拟试炼
    local isGetSimulationTrialFirstReward
    if self.chapterCid_ == EC_ActivityFubenType.SIMULATION_TRIAL
    or self.chapterCid_ == EC_ActivityFubenType.SIMULATION_TRIAL_2
    or self.chapterCid_ == EC_ActivityFubenType.SIMULATION_TRIAL_4
    or self.chapterCid_ == EC_ActivityFubenType.SIMULATION_TRIAL_5
    or self.chapterCid_ == EC_ActivityFubenType.SIMULATION_TRIAL_3 then 
        isLevelPass = FubenDataMgr:isPassPlotLevel(self.levelCid_)
        isGetSimulationTrialFirstReward = isLevelPass
    end
    local rewardList = {}
    local dropCid, showReward, isFirstPass
    if isLevelPass then
        dropCid = self.levelCfg_.reward
        showReward = self.levelCfg_.dropShow
        isFirstPass = false
    else
        dropCid = self.levelCfg_.firstReward
        showReward = self.levelCfg_.firstDropShow
        isFirstPass = true
    end
    listview_reward:removeAllItems()
    local multipleReward, extraReward = ActivityDataMgr2:getDropReward(dropCid)
    -- 掉落活动额外掉落
    for i, v in ipairs(extraReward) do
        local Panel_dropGoodsItem = PrefabDataMgr:getPrefab("Panel_dropGoodsItem"):clone()
        Panel_dropGoodsItem:Scale(0.9)
        PrefabDataMgr:setInfo(Panel_dropGoodsItem, {v}, EC_DropShowType.ACTIVITY_EXTRA)
        listview_reward:pushBackCustomItem(Panel_dropGoodsItem)
    end
    -- 基础掉落
    for i, v in ipairs(showReward) do
        local Panel_dropGoodsItem = PrefabDataMgr:getPrefab("Panel_dropGoodsItem"):clone()
        Panel_dropGoodsItem:Scale(0.9)
        local flag = 0
        local arg = {}
        local multiple = multipleReward[v]
        if multiple then
            flag = bit.bor(flag, EC_DropShowType.ACTIVITY_MULTIPLE)
            arg.multiple = multiple
        end
        if isFirstPass then
            flag = bit.bor(flag, EC_DropShowType.FIRST_PASS)
        end

        PrefabDataMgr:setInfo(Panel_dropGoodsItem, {v}, flag, arg)
        listview_reward:pushBackCustomItem(Panel_dropGoodsItem)
    end
    --新模拟试炼已领取的首通奖励,列表为空时显示
    if isGetSimulationTrialFirstReward then 
        if #listview_reward:getItems() == 0 then
            for i, v in ipairs(self.levelCfg_.firstDropShow) do
                local Panel_dropGoodsItem = PrefabDataMgr:getPrefab("Panel_dropGoodsItem"):clone()
                Panel_dropGoodsItem:Scale(0.9)
                local arg = {}
                local flag = bit.bor(EC_DropShowType.FIRST_PASS, EC_DropShowType.DATING_GETED)
                PrefabDataMgr:setInfo(Panel_dropGoodsItem, {v}, flag, arg)
                listview_reward:pushBackCustomItem(Panel_dropGoodsItem)
            end
        end
    end
end

function FubenSquadView:showSprite()
    self.Label_sprite_raiders_title:setTextById(2106007)
    self.Label_sprite_raiders:setTextById(self.spriteChallengeDungenCfg_.dungenDesc)
    self.Label_gain_title:setTextById(2106008)
    self.Label_sprite_free:setTextById(2106010)
    local heroCfg = TabDataMgr:getData("Hero", self.spriteChallengeDungenCfg_.heroID[1])

    local cizhuiName = {}
    for i, v in ipairs(self.monsterCfg_.monsterAffix) do
        local monsterAffixCfg = TabDataMgr:getData("MonsterAffix", v)
        local name = TextDataMgr:getText(monsterAffixCfg.affixName[1])
        local formatName = TextDataMgr:getText(800054, name)
        table.insert(cizhuiName, formatName)
    end
    local name = table.concat(cizhuiName, "  ")
    self.Label_sprite_cizhui:setText(name)

    self:updateSpriteBuffer()
end

function FubenSquadView:showTheater()
    local Image_theater_desc = TFDirector:getChildByPath(self.Panel_theater, "Image_theater_desc")
    local Label_theater_desc_title = TFDirector:getChildByPath(Image_theater_desc, "Label_theater_desc_title")
    local Label_theater_desc = TFDirector:getChildByPath(Image_theater_desc, "Label_theater_desc")
    local Panel_theater_contribution = TFDirector:getChildByPath(self.Panel_theater, "Panel_theater_contribution")
    local Label_theater_contribution = TFDirector:getChildByPath(Panel_theater_contribution, "Label_theater_contribution")
    local Label_theater_my_contribution_title = TFDirector:getChildByPath(Panel_theater_contribution, "Label_theater_my_contribution_title")
    local Label_theater_my_contribution = TFDirector:getChildByPath(Label_theater_my_contribution_title, "Label_theater_my_contribution")
    local Label_theater_global_contribution_title = TFDirector:getChildByPath(Panel_theater_contribution, "Label_theater_global_contribution_title")
    local Label_theater_global_contribution = TFDirector:getChildByPath(Label_theater_global_contribution_title, "Label_theater_global_contribution")
    local LoadingBar_theater_progress = TFDirector:getChildByPath(Label_theater_global_contribution_title, "Image_theater_global_progress.LoadingBar_theater_progress")

    self.Image_cost:hide()
    Label_theater_desc_title:setTextById(300986)
    Label_theater_desc:setTextById(12010133)
    Label_theater_contribution:setTextById(300987)
    Label_theater_my_contribution_title:setTextById(300988)
    Label_theater_global_contribution_title:setTextById(300974)
    local contribution = GoodsDataMgr:getItemCount(EC_SItemType.CONTRIBUTION)
    Label_theater_my_contribution:setText(contribution)
    local maxCfg = self.theaterBossInfo_.nodeStatus[#self.theaterBossInfo_.nodeStatus]
    local percent = math.min(1, self.theaterBossInfo_.serverContribution / maxCfg.contribution)
    LoadingBar_theater_progress:setPercent(percent * 100)
    Label_theater_global_contribution:setText(self.theaterBossInfo_.serverContribution)

    local contribution = Utils:format_number_w(self.theaterBossInfo_.serverContribution)
    Label_theater_global_contribution:setTextById("r301002", contribution, string.format("%0.2f", percent * 100))
end

function FubenSquadView:updateSpriteBuffer()
    local challengeBuffCfg = TabDataMgr:getData("ChallengeBuff", self.spriteChallengeInfo_.buffCid)
    self.Label_gain_attr:setTextById(challengeBuffCfg.buffDesc)

    if self.spriteBuffCount_ > 0 then
        -- self.Label_gain_switch:setTextById(2106009, self.spriteChallengeInfo_.buffCount, self.spriteBuffCount_)
        local remainCount = self.spriteBuffCount_ - self.spriteChallengeInfo_.buffCount
        self.Label_sprite_costNum:setVisible(remainCount > 0)
    else
        self.Label_sprite_costNum:show()
        -- self.Label_gain_switch:setTextById(2106059)
    end

    if self.Label_sprite_costNum:isVisible() then
        local cost = self.spriteBuffCost_[self.spriteChallengeInfo_.buffCount + 1]
        if not cost then
            cost = self.spriteBuffCost_[#self.spriteBuffCost_]
        end
        local costCid, costNum = next(cost)
        self.Label_sprite_costNum:hide()
        self.Label_sprite_free:hide()
        if costCid and costNum then
            local itemCfg = GoodsDataMgr:getItemCfg(costCid)
            self.Label_sprite_costNum:setText(costNum)
            self.Image_sprite_costIcon:setTexture(itemCfg.icon)
            self.Label_sprite_costNum:show()
        else
            self.Label_sprite_free:show()
        end
    end
end

function FubenSquadView:updateSkyLadderInfo()

    self:updateSkyLadderEffect()
    self:updateSkyLadderEquipCard()
end

function FubenSquadView:updateLeagueHuntingInfo()
    local Label_Hunting_desc = TFDirector:getChildByPath(self.Panel_League_Hunting,"Label_Hunting_desc")
    local Label_Hunting_contribute = TFDirector:getChildByPath(self.Panel_League_Hunting,"Label_Hunting_contribute")
    -- local text = ""
    -- for i,textId in ipairs(self.levelCfg_.victoryTypeDescribe) do
    --     if string.len(text) > 0 then 
    --         text = text .. "\n"
    --     end
    --     text = text ..TextDataMgr:getText(textId)
    -- end
    -- Label_Hunting_desc:setText(text)
    Label_Hunting_desc:setTextById(3300006)
    Label_Hunting_contribute:setTextById(self.levelCfg_.weaknessLevelDescribe)
end

function FubenSquadView:updateSkyLadderEffect()

    self.ListViewView_zone_effect:removeAllItems()
    local regionBuffs =  SkyLadderDataMgr:getRegionBuffs()
    if not regionBuffs then
        return
    end

    for k,v in pairs(regionBuffs) do
        local effectItem = self.Panel_effect_item:clone()
        local buffCfg = SkyLadderDataMgr:getRankMatchBuff(v)
        local buffState = SkyLadderDataMgr:getZoneBuffState(v)

        local Label_tip = TFDirector:getChildByPath(effectItem, "Label_tip")
        Label_tip:setTextById(buffCfg.buffDescribe)
        Label_tip:setDimensions(386, 0)
        local h = Label_tip:getContentSize().height
        effectItem:setContentSize(CCSizeMake(488,h))
        Label_tip:setColor(EC_SkyLadderCardEffectInfo[buffState].color)

        local Image_dot = TFDirector:getChildByPath(effectItem, "Image_dot")
        Image_dot:setTexture(EC_SkyLadderCardEffectInfo[buffState].dotRes)

        local Image_up = TFDirector:getChildByPath(effectItem, "Image_up")
        Image_up:setTexture(EC_SkyLadderCardEffectInfo[buffState].arrowRes)
        --Image_up:setVisible(buffState ~= EC_SkyLadderCardEffect.normal)
        self.ListViewView_zone_effect:pushBackCustomItem(effectItem)
    end
end

function FubenSquadView:updateSkyLadderEquipCard()


    local usingCardInfo = SkyLadderDataMgr:getUsingCards()
    for i=1,3 do
        local cardCid = usingCardInfo[i]
        self:updateCardItem(i,cardCid)
    end

    local equipCardCost = 0
    for k,v in ipairs(usingCardInfo) do
        local itemCfg = SkyLadderDataMgr:getRankMatchCardCfg(v)
        if itemCfg then
            equipCardCost = equipCardCost + itemCfg.cost
        end
    end

    local maxCost = SkyLadderDataMgr:getCardEquipMaxCost()
    self.ListViewView_card_cost:removeAllItems()
    for i=1,maxCost do
        local cardCostItem = self.Image_card_cost:clone()
        local Image_dot = TFDirector:getChildByPath(cardCostItem, "Image_dot")
        Image_dot:setVisible(i<= equipCardCost)
        self.ListViewView_card_cost:pushBackCustomItem(cardCostItem)
    end

    local isEquipBestCards = true
    local bestCards = SkyLadderDataMgr:getBestCards()
    if next(bestCards) then
        for k,v in ipairs(bestCards) do
            local isUsingCards = SkyLadderDataMgr:isUsingCards(v.cardId)
            if not isUsingCards then
                isEquipBestCards = false
                break
            end
        end
    else
        isEquipBestCards = false
    end

    local btnLabelId = isEquipBestCards and 3202052 or 3202051
    self.Label_optimize:setTextById(btnLabelId)

end

function FubenSquadView:updateCardItem(i,cardCid)

    local bar = self.equipCardBtn[i]
    if cardCid then
        bar.Panel_cardItem:setVisible(true)
        local cardInfo = SkyLadderDataMgr:getOwnedCardByID(cardCid)
        local level = cardInfo.cardLv
        local itemCfg = SkyLadderDataMgr:getRankMatchCardCfg(cardCid)
        if itemCfg then
            bar.Button_card:setTextureNormal(EC_SkyLadderCardFrame[itemCfg.quality])
            bar.Image_card_type:setTexture(EC_SkyLadderCardTypeIcon[itemCfg.abilityType])
            bar.Image_card:setTexture(itemCfg.icon)

            local isDownBuff = false
            for _,negativeId in ipairs(itemCfg.negative) do
                if SkyLadderDataMgr:getRegionBuffs(negativeId) then
                    isDownBuff = true
                    break
                end
            end

            bar.Image_effect_down:setVisible(isDownBuff)
            bar.Label_card_name:setTextById(itemCfg.nameTextId)
            local color = isDownBuff and ccc3(239, 95, 125) or ccc3(89, 85, 127)
            bar.Label_card_name:setColor(color)
            bar.ListView_cost:removeAllItems()
            if itemCfg.maxLevel == level then
                bar.Label_card_lv:setText("Max")
            else
                bar.Label_card_lv:setTextById(800006, level)
            end
            local fightCnt = SkyLadderDataMgr:getCardFightCnt(cardCid)
            bar.Label_ladder_cnt:setText(fightCnt)
            bar.Image_card_disabled:setVisible(fightCnt == 0)
            for k = 1, itemCfg.cost do
                local Image_costItem = self.Image_card_cost:clone()
                bar.ListView_cost:pushBackCustomItem(Image_costItem)
            end
            Utils:setAliginCenterByListView(bar.ListView_cost, true)
        end
    else
        bar.Panel_cardItem:setVisible(false)
    end

    bar.Button_card:onClick(function()
        Utils:openView("skyLadder.SkyLadderCardBagView", i)
    end)
    bar.btnNone:onClick(function()
        Utils:openView("skyLadder.SkyLadderCardBagView", i)
    end)
end


function FubenSquadView:onCountDownPer()
    self.TableView_assistant:reloadData()
end

function FubenSquadView:addCountDownTimer(storeId)
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.onCountDownPer, self))
    end
end

function FubenSquadView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
    end
end

function FubenSquadView:removeEvents()
    self:removeCountDownTimer()
    if self.levelCid_ then
        FubenDataMgr:resetLevelFormation(self.levelCid_)
    end
    EventMgr:removeEventListenerByTarget(self)
end

function FubenSquadView:onFightingClick()
    if self.levelCfg_ then
        local isCanFighting = true
        local cost = self.levelCfg_.cost[1]
        if cost then
            isCanFighting = GoodsDataMgr:currencyIsEnough(cost[1], cost[2] * self.calChallengeCount_)
        end
        if not isCanFighting then
            local goodsCfg = GoodsDataMgr:getItemCfg(cost[1])
            local name = TextDataMgr:getText(goodsCfg.nameTextId)
            Utils:showTips(2100034, name)
            return
        end

        local enabled = true
        if self.isDisableHero_ then
            for i, v in ipairs(self.formationData_) do
                if table.indexOf(self.levelCfg_.heroForbiddenID, v.data.cid) ~= -1 then
                    enabled = false
                    break
                end
            end
        end
        if not enabled then
            Utils:showTips(2100035)
        end
    end

    if #self.formationData_ == 0 then
        Utils:showTips(2100116)
        return
    end
    local heros = {}
    for i, v in ipairs(self.formationData_) do
        table.insert(heros, {v.type, v.id})
    end
    local assistantPlayerId = 0
    local assistantHeroCid = 0
    if self.selectAssistantIndex_ and self.isUnlockAssistant_ then
        assistantPlayerId = self.assistantData_[self.selectAssistantIndex_].pid
        assistantHeroCid = self.assistantData_[self.selectAssistantIndex_].helpHeroCid
    end

    local battleController = require("lua.logic.battle.BattleController")
    if self.fubenType_ == EC_FBType.PLOT 
        or self.fubenType_ == EC_FBType.DAILY 
        or self.fubenType_ == EC_FBType.THEATER_HARD
        or self.fubenType_ == EC_FBType.LINKAGE
        or self.fubenType_ == EC_FBType.NIANBREAST_LEVEL
        or self.fubenType_ == EC_FBType.MEMORY then
        if self.fubenType_ == EC_FBType.DAILY then
            local remainCount = FubenDataMgr:getDailyRemainFightCount(self.levelCfg_.levelGroupId)
            if remainCount < 1 then
                Utils:showTips(202006)
                return
            end
        end
        battleController.requestFightStart(self.levelCid_, assistantPlayerId, assistantHeroCid, heros, self.challengeCount_, self.isDuelMod_)
    elseif self.fubenType_ == EC_FBType.ACTIVITY then
        if self.chapterCid_ == EC_ActivityFubenType.ENDLESS then
            local enabled = true
            for i, v in ipairs(heros) do
                local percent = FubenDataMgr:getEndlessHeroHpPercent(v[2])
                if percent <= 0 then
                    enabled = false
                    break
                end
            end
            if enabled then
                FubenDataMgr:send_ENDLESS_CLOISTER_REQ_START_FIGHT_ENDLESS()
                battleController.initEndless()
            else
                Utils:showTips(310013)
            end
        elseif self.chapterCid_ == EC_ActivityFubenType.SPRITE then
            if FubenDataMgr:getSpriteChallengeIsOpen() then
                local remainCount = FubenDataMgr:getSpriteChallengeRemainCount()
                if remainCount > 0 then
                    battleController.requestFightStart(self.levelCid_, assistantPlayerId, assistantHeroCid, heros, self.challengeCount_, self.isDuelMod_)
                else
                    Utils:showTips(202006)
                end
            else
                Utils:showTips(2106013)
            end
        elseif self.chapterCid_ == EC_ActivityFubenType.SPRITE_EXTRA then
            if FubenDataMgr:getSpriteExtraIsOpen() then
                battleController.requestFightStart(self.levelCid_, assistantPlayerId, assistantHeroCid, heros, self.challengeCount_, self.isDuelMod_)
            else
                Utils:showTips(2106013)
            end
        elseif self.chapterCid_ == EC_ActivityFubenType.SIMULATION_TRIAL 
            or self.chapterCid_ == EC_ActivityFubenType.SIMULATION_TRIAL_2
            or self.chapterCid_ == EC_ActivityFubenType.SIMULATION_TRIAL_4
            or self.chapterCid_ == EC_ActivityFubenType.SIMULATION_TRIAL_5
            or self.chapterCid_ == EC_ActivityFubenType.SIMULATION_TRIAL_3  then
            -- dump({self.levelCid_, assistantPlayerId, assistantHeroCid, heros, self.challengeCount_, self.isDuelMod_})  
            battleController.requestFightStart(self.levelCid_, assistantPlayerId, assistantHeroCid, heros, self.challengeCount_, self.isDuelMod_)
        end
    elseif self.fubenType_ == EC_FBType.HOLIDAY or self.fubenType_ == EC_FBType.HOLIDAY2 then
        if self.chapterCid_ == EC_ActivityFubenType.HALLOWEEN then
            battleController.requestFightStart(self.levelCid_, assistantPlayerId, assistantHeroCid, heros, self.challengeCount_, self.isDuelMod_)
        elseif self.chapterCid_ == EC_ActivityFubenType.CHRISTMAS then
            battleController.requestFightStart(self.levelCid_, assistantPlayerId, assistantHeroCid, heros, self.challengeCount_, self.isDuelMod_)
		else 
			Box("not lua")
        end
    elseif self.fubenType_ == EC_FBType.THEATER then
        battleController.requestFightStart(self.levelCid_, assistantPlayerId, assistantHeroCid, heros, self.challengeCount_, self.isDuelMod_)
    elseif self.fubenType_ == EC_FBType.THEATER_BOSS then
        if self.theaterBossInfo_.status == EC_TheaterStatus.ING then
            local count = GoodsDataMgr:getItemCount(EC_SItemType.THEATER_COUNT)
            if count > 0 then
                battleController.requestFightStart(self.levelCid_, assistantPlayerId, assistantHeroCid, heros, self.challengeCount_, self.isDuelMod_)
            else
                Utils:showTips(300990)
            end
        else
            Utils:showTips(219007)
        end
    elseif self.fubenType_ == EC_FBType.SKYLADDER then
        local step = SkyLadderDataMgr:getStep()
        if SkyLadderDataMgr:isOpen() and  step == EC_SKYLADDER_STEP.PROCCED then
            if #self.formationData_ ~= 3 then
                Utils:showTips(3005006)
                return
            end

            local couldFight = true
            for k,v in ipairs(self.formationData_) do
                local heroFightCnt = SkyLadderDataMgr:getHeroFightCnt(v.id)
                heroFightCnt = heroFightCnt or 0
                couldFight = heroFightCnt ~= 0
                if not couldFight then
                    break
                end
            end

            if not couldFight then
                Utils:showTips(3203005)
                return
            end

            local passEquipCard = true
            local usingCards = SkyLadderDataMgr:getUsingCards()
            for k,v in ipairs(usingCards) do
                local remainCnt = SkyLadderDataMgr:getCardFightCnt(v)
                if remainCnt <= 0 then
                    passEquipCard = false
                    break
                end
            end

            if not passEquipCard then
                Utils:showTips(3203006)
                return
            end

            battleController.requestFightStart(self.levelCid_, assistantPlayerId, assistantHeroCid, heros, self.challengeCount_, self.isDuelMod_)
        else
            Utils:showTips(2106013)
        end
    elseif self.fubenType_ == EC_FBType.HUNTER then
        battleController.requestFightStart(self.levelCid_, 0, 0, heros, 0, false)
    elseif self.fubenType_ == EC_FBType.KSAN_FUBEN then
        battleController.requestFightStart(self.levelCid_, 0, 0, heros, 0, false)
    end
    GameGuide:checkGuideEnd(self.guideFuncId)
end

function FubenSquadView:registerEvents()
    EventMgr:addEventListener(self, EV_FORMATION_CHANGE, handler(self.onUpdateFormationEvent, self))
    EventMgr:addEventListener(self, EV_FUBEN_ASSISTANTUPDATE, handler(self.onUpdateAssistantEvent, self))
    EventMgr:addEventListener(self, EV_FUBEN_UPDATE_LIMITHERO, handler(self.onLimitHeroEvent, self))
    EventMgr:addEventListener(self, EV_FUBEN_SPRITE_UPDATE_BUFF, handler(self.onUpdateSpriteBufferEvent, self))
    EventMgr:addEventListener(self, EV_FUBEN_ENDLESS_BUFFER, handler(self.onUpdateEndlessBuffEvent, self))
    EventMgr:addEventListener(self, EV_FUBEN_THEATER_BOSS_INFO, handler(self.onTheaterBossInfoEvent, self))
    EventMgr:addEventListener(self, EV_UPDATE_CARD_FORMATION, handler(self.updateSkyLadderInfo, self))
    EventMgr:addEventListener(self, EV_UPDATE_CARD_LV, handler(self.updateSkyLadderInfo, self))
    self.Button_fighting:onClick(handler(self.onFightingClick, self))

    self:setBackBtnCallback(function()
            HeroDataMgr:changeDataToSelf()
            AlertManager:close()
    end)

    self.Spine_gain_effect:addMEListener(
        TFARMATURE_COMPLETE,
        function()
            self.Button_sprite_switch:setGrayEnabled(false)
            self.Button_sprite_switch:setTouchEnabled(true)
        end
    )

    self:setMainBtnCallback(function()
            HeroDataMgr:changeDataToSelf()
    end)

    self.Button_sprite_switch:onClick(function()
            if self.spriteBuffCount_ == 0 or self.spriteChallengeInfo_.buffCount < self.spriteBuffCount_ then
                local cost = self.spriteBuffCost_[self.spriteChallengeInfo_.buffCount + 1]
                if not cost then
                    cost = self.spriteBuffCost_[#self.spriteBuffCost_]
                end
                local costCid, costNum = next(cost)
                if costCid and costNum then
                    if GoodsDataMgr:currencyIsEnough(costCid, costNum) then
                        self.Button_sprite_switch:setGrayEnabled(true)
                        self.Button_sprite_switch:setTouchEnabled(false)
                        FubenDataMgr:send_HERO_CHALLENGE_REFRESH_BUFF()
                    else
                        Utils:showAccess(costCid)
                    end
                else
                    FubenDataMgr:send_HERO_CHALLENGE_REFRESH_BUFF()
                end
            else
                Utils:showTips(2106011)
            end
    end)

    self.Button_lock:onClick(function()
            Utils:showTips(300025)
    end)

    self.Button_ladder_tip:onClick(function()
        if self.isEndAction == nil then
            self.isEndAction = true
        end
        self:showLadderCostTip()
    end)

    self.Button_optimize:onClick(function ()
        --self:quickEquipCards()
    end)

end

function FubenSquadView:quickEquipCards()

    local bestCards = SkyLadderDataMgr:getBestCards()
    if not next(bestCards) then
        Utils:showTips("没有可用卡牌")
        return
    end

    local isEquipAllBest = true
    local usingCards = SkyLadderDataMgr:getUsingCards()
    for i=1,3 do
        local usingCardId = usingCards[i]
        local bestCardId = bestCards[i].cardId
        if usingCardId and usingCardId == bestCardId then
        else
            isEquipAllBest = false
            SkyLadderDataMgr:handleFormation(i,bestCardId)
        end
    end

    if isEquipAllBest then
        local usingCards = SkyLadderDataMgr:getUsingCards()
        for k,v in ipairs(usingCards) do
            SkyLadderDataMgr:handleFormation(k,v)
        end
    end
end

function FubenSquadView:showLadderCostTip()
    if not self.isEndAction then
        return
    end
    self.Image_equip_tip:setVisible(true)
    self.Image_equip_tip:stopAllActions()
    local seqAction = CCSequence:create({
        CCDelayTime:create(2),
        CCFadeOut:create(0.5),
        CCCallFunc:create(function()
            self.Image_equip_tip:stopAllActions()
            self.isEndAction = true
            self.Image_equip_tip:setOpacity(255)
            self.Image_equip_tip:setVisible(false)
        end)
    })
    self.Image_equip_tip:runAction(seqAction)
end

function FubenSquadView:updateFormation()
    for i, v in ipairs(self.Panel_member) do
        local formationData = self.formationData_[i]
        local isBattle = tobool(formationData)
        v.Panel_role:setVisible(isBattle)
        if not isBattle then
            if self.isLimitHero_ or self.isDisableHero_ then
                if self.levelCfg_.heroLimitType == EC_LimitHeroType.LIMIT_NJ then
                    v.Panel_lock:show()
                end
            end
            if self.isLimitSimulationTrialHero_ then 
                if self.levelCfg_.heroLimitType == EC_LimitHeroType.SIMULATION_TRIAL_LOCK then
                    v.Panel_lock:show()
                end
            end
        end
        v.Panel_add:setVisible(not v.Panel_lock:isVisible())
        v.Label_limit_type:setTextById(300016)
        v.Label_try_type:setTextById(300015)
        v.Label_disable_type:setTextById(300017)
        v.Label_empty:setTextById(300018)

        if isBattle then
            v.Image_limit_type:setVisible(self.isLimitHero_ or self.isLimitSimulationTrialHero_ )
            v.Image_disable_type:setVisible(self.isDisableHero_)
            v.Image_try_type:setVisible(formationData.data.heroStatus == 3)
            if self.isDisableHero_ then
                local index = table.indexOf(self.levelCfg_.heroForbiddenID, formationData.data.cid)
                v.Image_disable_type:setVisible(index ~= -1)
            elseif self.isLimitHero_ then
                v.Image_limit_type:setVisible(formationData.type == EC_BattleHeroType.LIMIT)
            elseif self.isLimitSimulationTrialHero_ then
                v.Image_limit_type:setVisible(formationData.type == EC_BattleHeroType.SIMULATION)
            end

            local heroData = formationData.data
            local skinData = TabDataMgr:getData("HeroSkin", heroData.skinCid)
            v.Label_name:setTextById(heroData.nameTextId)
            v.Button_head:setTextureNormal(skinData.backdrop)

            local model = Utils:createHeroModel(heroData.id, v.Panel_model, 0.45, heroData.skinCid)
            model:update(0.1)
            model:stop()

            if self.chapterCid_ == EC_ActivityFubenType.ENDLESS then
                if FubenDataMgr:isEndlessRacingMode(self.endlessInfo_.curStage) then
                    local percent = FubenDataMgr:getEndlessHeroHpPercent(heroData.id)
                    percent = math.floor(percent / 100)
                    v.LoadingBar_hp_progress:setPercent(percent)
                    v.Label_hp_percent:setTextById(800017, percent)
                    v.Image_hp:show()
                    v.Image_endless_dead:setVisible(percent <= 0)
                end
            elseif self.chapterCid_ == EC_ActivityFubenType.SKYLADDER then
                v.Image_skayladder:setVisible(true)
                local heroFightCnt = SkyLadderDataMgr:getHeroFightCnt(heroData.id)
                heroFightCnt = heroFightCnt or 0
                v.Label_remain_cnt:setText(heroFightCnt)
                v.Image_disable_type:setVisible(heroFightCnt == 0)
                v.Label_disable_type:setTextById(100000039)
            end
            --更新克制icon
            v.Panel_ksan_coin:hide()
            PrefabDataMgr:setInfo(v.panel_element , heroData.magicAttribute)

            -- v.Panel_mojin_coin:hide()
	    if self.fubenType_ == EC_FBType.KSAN_FUBEN then
                dump(self.ksanFubenActivityInfo.extendData.herobonus)
                local herobonus = self.ksanFubenActivityInfo.extendData.herobonus or {}
                for heroId,bonus in pairs(herobonus) do
                    if tonumber(heroId) == heroData.id then
                        v.Panel_ksan_coin:show()
                        for itemId,buff in pairs(bonus) do
                            local itemCfg = GoodsDataMgr:getItemCfg(tonumber(itemId))
                            TFDirector:getChildByPath(v.Panel_ksan_coin, "Image_coin"):setScale(0.4)
                            TFDirector:getChildByPath(v.Panel_ksan_coin, "Image_coin"):setTexture(itemCfg.icon)
                            TFDirector:getChildByPath(v.Panel_ksan_coin, "Label_coin_buff"):setTextById(buff <= 10 and 12033022 or 12033042)
                            break
                        end
                    end
                end
	    end
            -- if self.fubenType_ == EC_FBType.NEWYEAR_FUBEN then
            --     local herobonus = self.mojinActivityInfo.extendData.herobonus
            --     for heroId,bonus in pairs(herobonus) do
            --         if tonumber(heroId) == heroData.id then
            --             v.Panel_mojin_coin:show()
            --             for itemId,buff in pairs(bonus) do
            --                 local itemCfg = GoodsDataMgr:getItemCfg(tonumber(itemId))
            --                 TFDirector:getChildByPath(v.Panel_mojin_coin, "Image_coin"):setTexture(itemCfg.icon)
            --                 TFDirector:getChildByPath(v.Panel_mojin_coin, "Label_coin_buff"):setTextById(buff <= 10 and 12033022 or 12033021)
            --                 break
            --              end 
            --         end
            --     end
            -- end
        end

        v.Button_head:onTouch(function(event)
                if self.moveFlag_ then return end
                local target = event.target
                if event.name == "began" then
                    if not self.formationData_[i] then return end
                    local heroData = self.formationData_[i].data
                    self.Panel_cloneRole = v.Panel_role:clone():hide()
                    local Panel_model = TFDirector:getChildByPath(self.Panel_cloneRole, "Panel_role.Panel_model")
                    local model = Utils:createHeroModel(heroData.id, Panel_model, 0.45, heroData.skinCid)
                    model:update(0.1)
                    model:stop()
                    v.Panel_add:show()
                    for j, foo in ipairs(self.Panel_member) do
                        if j == i then
                            foo.root:ZO(2)
                        else
                            foo.root:ZO(1)
                        end
                    end
                    v.Panel_role:getParent():Add(self.Panel_cloneRole)
                    v.__movePos = target:getTouchStartPos()
                elseif event.name == "moved" then
                    if not self.Panel_cloneRole then return end
                    if not self.formationData_[i] then return end
                    local movePos = target:getTouchMovePos()
                    local offset = me.pSub(movePos, v.__movePos)
                    v.__movePos = movePos
                    local pos = self.Panel_cloneRole:getPosition()
                    self.Panel_cloneRole:Pos(me.pAdd(pos, offset)):show()
                    v.Panel_role:hide()
                elseif event.name == "ended" then
                    if not self.Panel_cloneRole then return end
                    if not self.formationData_[i] then return end
                    local endPos = target:getTouchEndPos()
                    local np = self.Panel_root:convertToNodeSpaceAR(endPos)
                    local index
                    for i, v in ipairs(self.moveRect_) do
                        if me.rectContainsPoint(v, np) then
                            index = i
                            break
                        end
                    end
                    if index and index ~= i and self.formationData_[index] then
                        local fromFormationData = self.formationData_[i]
                        local toFormationData = self.formationData_[index]
                        if fromFormationData.type == EC_BattleHeroType.LIMIT or toFormationData.type == EC_BattleHeroType.LIMIT 
                            or fromFormationData.type == 3 or toFormationData.type == 3 then
                            Utils:showTips(300024)
                        else
                            self:replaceFormation(i, index)
                        end
                    end
                    v.Panel_role:show()
                    v.Panel_add:hide()
                    self.Panel_cloneRole:removeFromParent()
                end
        end)
        v.Button_head:onClick(function()
                local heroTab = HeroDataMgr:getHero()
                if i < #heroTab then
                    Utils:showTips(300011)
                else
                    if self.isLimitHero_ or self.isDisableHero_ or self.isLimitSimulationTrialHero_ then
                        HeroDataMgr:changeFormation(i, false,false,false,self.isLimitSimulationTrialHero_,self.isContainSimulationTrial)
                    else
                        local isEndless = (self.fubenType_ == EC_FBType.ACTIVITY and self.chapterCid_ == EC_ActivityFubenType.ENDLESS)
                        local isSkyLadder = (self.fubenType_ == EC_FBType.SKYLADDER and self.chapterCid_ == EC_ActivityFubenType.SKYLADDER)
                        HeroDataMgr:changeFormation(i, true, isEndless,isSkyLadder,self.isLimitSimulationTrialHero_,self.isContainSimulationTrial)
                    end
                end
        end)
        v.Button_add:onClick(function()
                local heroTab = HeroDataMgr:getHero()
                if i < #heroTab then
                    Utils:showTips(300011)
                else
                    if self.isLimitHero_ or self.isDisableHero_ or self.isLimitSimulationTrialHero_ then
                        HeroDataMgr:changeFormation(i, false,false,false,self.isLimitSimulationTrialHero_,self.isContainSimulationTrial)
                    else
                        local isEndless = (self.fubenType_ == EC_FBType.ACTIVITY and self.chapterCid_ == EC_ActivityFubenType.ENDLESS)
                        local isSkyLadder = (self.fubenType_ == EC_FBType.SKYLADDER and self.chapterCid_ == EC_ActivityFubenType.SKYLADDER)
                        HeroDataMgr:changeFormation(i, true, isEndless,isSkyLadder,self.isLimitSimulationTrialHero_,self.isContainSimulationTrial)
                    end
                end
                GameGuide:checkGuideEnd(self.guideFuncId)
        end)
        v.Button_lock:onClick(function()
                Utils:showTips(300023)
        end)
        v.Button_check:onClick(function()
            local heroData = formationData.data
            HeroDataMgr.showid = heroData.id;
            Utils:openView("fairyNew.FairyDetailsLayer", {showid= heroData.id, friend=false, gotoWhichTab = 3,skyladder = true})
            SkyLadderDataMgr:setCheckHeroId(heroData.id)
        end)
    end
end

function FubenSquadView:replaceFormation(fromIndex, toIndex)
    if self.isLimitHero_ or self.isDisableHero_ or self.isLimitSimulationTrialHero_ then
        if self.isLimitHero_ then
            FubenDataMgr:moveLevelFormation(self.levelCid_, fromIndex, toIndex)
        end
        self.formationData_[fromIndex], self.formationData_[toIndex] = self.formationData_[toIndex], self.formationData_[fromIndex]
        self:updateFormation()
    else
        local fromId = HeroDataMgr:getHeroIdByFormationPos(fromIndex)
        local toId = HeroDataMgr:getHeroIdByFormationPos(toIndex)
        HeroDataMgr:heroOnBattle(fromId, toId)
    end
end

function FubenSquadView:updateAssistantData()
    self.assistantData_ = {}
    local assistHero = FubenDataMgr:getAssistHero()
    assert(assistHero, "can not be nil.")
    table.insert(self.assistantData_, assistHero)

    local friend = FriendDataMgr:getFriend(EC_Friend.FRIEND)
    local noCdFriend = {}
    local cdFriend = {}
    for i, v in ipairs(friend) do
        local friendInfo = FriendDataMgr:getFriendInfo(v)
        local data = {
            pid = friendInfo.pid,
            name = friendInfo.name,
            lvl = friendInfo.lvl,
            helpHeroCid = friendInfo.leaderCid,
            coldDownTime = friendInfo.helpCDtime,
            helpHeroFightPower = friendInfo.fightPower,
            portraitCid = friendInfo.portraitCid
        }
        if data.coldDownTime > 0 then
            table.insert(cdFriend, data)
        else
            table.insert(noCdFriend, data)
        end
    end
    table.sort(cdFriend, function(a, b)
                   return a.helpHeroFightPower > b.helpHeroFightPower
    end)
    table.sort(noCdFriend, function(a, b)
                   return a.helpHeroFightPower > b.helpHeroFightPower
    end)
    table.insertTo(self.assistantData_, noCdFriend)
    table.insertTo(self.assistantData_, cdFriend)
end

function FubenSquadView:updateAssistantItem(item, index)
    local Image_normal = TFDirector:getChildByPath(item, "Image_normal")
    local Image_select = TFDirector:getChildByPath(item, "Image_select")
    local Image_icon = TFDirector:getChildByPath(item, "Image_icon")
    local Image_friend = TFDirector:getChildByPath(item, "Image_friend")
    local Label_ship_normal = TFDirector:getChildByPath(item, "Label_ship_normal")
    local Label_ship_select = TFDirector:getChildByPath(item, "Label_ship_select")
    local Label_name = TFDirector:getChildByPath(item, "Label_name")
    local Image_cding = TFDirector:getChildByPath(item, "Image_cding"):hide()
    local Label_timing = TFDirector:getChildByPath(Image_cding, "Label_timing")
    local Label_cding = TFDirector:getChildByPath(Image_cding, "Label_cding")
    local Image_limit = TFDirector:getChildByPath(item, "Image_limit"):hide()
    local Label_limit = TFDirector:getChildByPath(Image_limit, "Label_limit")
    local Label_power_title = TFDirector:getChildByPath(item, "Label_power_title")
    local Label_power = TFDirector:getChildByPath(item, "Label_power")

    local data = self.assistantData_[index]
    local isFriend = FriendDataMgr:isFriend(data.pid)
    local heroCfg = TabDataMgr:getData("Hero", data.helpHeroCid)
    local skinData = TabDataMgr:getData("HeroSkin", heroCfg.defaultSkin)
    local panel_element = item.panel_element

    Image_friend:setVisible(isFriend)
    Label_name:setText(data.name)
    Image_icon:setTexture(skinData.heroIcon)
    -- local headIcon = data.portraitCid
    -- if headIcon == 0 then
    --     headIcon = 101
    -- end
    -- local icon = AvatarDataMgr:getAvatarIconPath(headIcon)
    -- Image_icon:setTexture(icon)
    Label_power_title:setTextById(350011)
    Label_power:setText(tostring(data.helpHeroFightPower))

    local isSelect = (self.selectAssistantIndex_ == index)
    Image_select:setVisible(isSelect)

    local isCd = data.coldDownTime > 0
    if isCd then
        Label_cding:setTextById(300613)
        local remainTime = math.max(0, data.coldDownTime - ServerDataMgr:getServerTime())
        local _, hour, min = Utils:getFuzzyDHMS(remainTime, true)
        print(Utils:getUTCDate(remainTime))
        local mins = hour * 60 + min
        Label_timing:setTextById(800030, string.format("%02d", mins))
        if mins == 0 then
            isCd = false
            data.coldDownTime = 0
            FriendDataMgr:setFriendHelpCDtime(data.pid, 0)
        end
    end
    Image_cding:setVisible(isCd)
    -- item:setTouchEnabled(not isCd)
    if isCd then
        Label_power_title:hide()
        Label_power:hide()
    else
        Label_power_title:show()
        Label_power:show()
    end 

    if self.isDisableHero_ then
        local index = table.indexOf(self.levelCfg_.heroForbiddenID, data.helpHeroCid)
        local disable = (index ~= -1)
        Image_limit:setVisible(disable)
        if disable then
            Image_cding:hide()
        end
    end

    local shipValue = 0
    if isFriend then
        shipValue = Utils:getKVP(6001, "friend")
    else
        shipValue = Utils:getKVP(6001, "passer")
    end
    Label_ship_normal:setVisible(not isSelect)
    Label_ship_select:setVisible(isSelect)
    Label_ship_normal:setText(shipValue)
    Label_ship_select:setText(shipValue)
    PrefabDataMgr:setInfo(panel_element , heroCfg.magicAttribute)
end

function FubenSquadView:tableCellTouched(tbl, cell)
    if not self.isUnlockAssistant_ then
        Utils:showTips(300025)
        return
    end
    local index = cell.idx
    local data = self.assistantData_[index]
    if data.coldDownTime > 0 then return end
    if self.isDisableHero_ then
        if table.indexOf(self.levelCfg_.heroForbiddenID, data.helpHeroCid) ~= -1 then
            return
        end
    end

    if self.selectAssistantIndex_ then
        if self.selectAssistantIndex_ == index then
            self.selectAssistantIndex_ = nil
        else
            self.selectAssistantIndex_ = index
        end
    else
        self.selectAssistantIndex_ = index
    end
    self.Panel_role:setVisible(tobool(self.selectAssistantIndex_))
    self.Panel_add:setVisible(tobool(not self.selectAssistantIndex_))
    if self.selectAssistantIndex_ then
        local data = self.assistantData_[self.selectAssistantIndex_]
        local heroCfg = TabDataMgr:getData("Hero", data.helpHeroCid)
        local skinData = TabDataMgr:getData("HeroSkin", heroCfg.defaultSkin)
        self.Image_color:setTexture(skinData.backdrop)
        local model = Utils:createHeroModel(data.helpHeroCid, self.Panel_model, 0.45, heroCfg.defaultSkin)
        model:update(0.1)
        model:stop()
        self.Label_name:setText(data.name)
        PrefabDataMgr:setInfo(self.panel_element , heroCfg.magicAttribute)
    end

    self.TableView_assistant:reloadData()
end

function FubenSquadView:cellSizeForTable()
    local size = self.Panel_assistantItem:getSize()
    return size.height, size.width
end

function FubenSquadView:tableCellAtIndex(tab, idx)
	local cell = tab:dequeueCell()
	idx = idx + 1
    if not cell then
		cell = TFTableViewCell:create()
		local item = self.Panel_assistantItem:clone():show()
		item:setAnchorPoint(ccp(0, 0))
		item:setPosition(ccp(0, 0))
		cell:addChild(item)
		cell.item = item

        --创建克制icon
        local startPos = item:getChildByName("Image_icon"):getPosition() + ccp(-20 , 30)
        item.panel_element = Utils:createElementPanel(item , 1 , startPos , nil , 0.4)
    end
    cell.idx = idx

	if cell.item then
		self:updateAssistantItem(cell.item, idx)
	end

    return cell
end

function FubenSquadView:numberOfCellsInTableView()
    return #self.assistantData_
end

function FubenSquadView:cellBegin(...)

end

function FubenSquadView:cellEnd(...)

end

function FubenSquadView:onUpdateAssistantEvent(assistantData)
    self:updateAssistantData()
    self.TableView_assistant:reloadData()
end

function FubenSquadView:onUpdateFormationEvent(heroCid, oldHeroCid)
    if self.isLimitHero_ or self.isDisableHero_ or self.isLimitSimulationTrialHero_  then
		--Box("1")
        local index
        if oldHeroCid then
            if self.isLimitHero_ then
                FubenDataMgr:casLevelFormation(self.levelCid_, heroCid, oldHeroCid)
            end
            for i, v in ipairs(self.formationData_) do
                if v.data.cid == oldHeroCid then
                    local heroData = HeroDataMgr:getHero(heroCid)
                    self.formationData_[i] = FubenDataMgr:makeFormationData(heroData, EC_BattleHeroType.OWN, heroCid)
                    if self.isLimitHero_ then
                        FubenDataMgr:casLevelFormation(self.levelCid_, oldHeroCid, heroCid)
                    end
                    break
                end
            end
        else
            for i, v in ipairs(self.formationData_) do
                if v.data.cid == heroCid then
                    index = i
                    break
                end
            end
            if index then
                table.remove(self.formationData_, index)
                if self.isLimitHero_ then
                    FubenDataMgr:removeLevelFormation(self.levelCid_, heroCid)
                end
            else
                local heroData = HeroDataMgr:getHero(heroCid)
                table.insert(self.formationData_, FubenDataMgr:makeFormationData(heroData, EC_BattleHeroType.OWN, heroCid))
                if self.isLimitHero_ then
                    FubenDataMgr:addLevelFormation(self.levelCid_, heroCid)
                end
            end
        end
    else
		--Box("2")
        self.formationData_ = {}
        for i = 1, 3 do
            local isOn = HeroDataMgr:getIsFormationOn(i)
            if isOn then
                local id = HeroDataMgr:getHeroIdByFormationPos(i)
                local heroData = HeroDataMgr:getHero(id)
                table.insert(self.formationData_, FubenDataMgr:makeFormationData(heroData, EC_BattleHeroType.OWN, heroData.cid))
            end
        end
    end
    self:updateFormation()
end

function FubenSquadView:onLimitHeroEvent()
	--box("3")
    self.formationData_ = FubenDataMgr:getInitFormation(self.levelCid_)
    if self.isLimitHero_ or self.isDisableHero_ then
        HeroDataMgr:changeDataByFuben(self.levelCid_, self.formationData_)
    end
    self:updateFormation()
end

function FubenSquadView:onShow()
    self.super.onShow(self)
    self:removeLockLayer()
    self:timeOut(function()
        GameGuide:checkGuide(self);
    end,0)
end

function FubenSquadView:onUpdateSpriteBufferEvent()
    Utils:showTips(2106012)
    -- self.Spine_gain_effect:show():play("animation", 0)
    self.Button_sprite_switch:setTouchEnabled(true)
    self.Button_sprite_switch:setGrayEnabled(false)
    self.spriteChallengeInfo_ = FubenDataMgr:getSpriteChallengeInfo()
    self:updateSpriteBuffer()
end

function FubenSquadView:onUpdateEndlessBuffEvent(levelBuff)
    local buffMap = {}
    for i, v in ipairs(levelBuff) do
        buffMap[v.levelCid] = v.buff
    end
    for i, v in ipairs(self.ListView_endless:getItems()) do
        local ScrollView_buff = TFDirector:getChildByPath(v, "ScrollView_buff")
        local ListView_buff = UIListView:create(ScrollView_buff)
        local order = self.showEndlessLevel_[i]
        local levelCid = self.endlessCloisterLevel_[order]
        local buff = buffMap[levelCid] or {}
        local Image_buffInfo = TFDirector:getChildByPath(v, "Image_buffInfo")
        local Label_buffDesc = TFDirector:getChildByPath(Image_buffInfo, "Label_buffDesc")
        for _, buffCid in ipairs(buff) do
            local buffCfg = TabDataMgr:getData("EndlessBuff", buffCid)
            local Panel_buffItem = self.Panel_buffItem:clone()
            local Image_icon = TFDirector:getChildByPath(Panel_buffItem, "Image_icon")
            Image_icon:setTexture(buffCfg.buffIcon)
            Panel_buffItem:onClick(function()
                    Label_buffDesc:setTextById(buffCfg.buffDescribe)
                    local seq = Sequence:create({
                            Show:create(),
                            FadeIn:create(0.2),
                            DelayTime:create(1.0),
                            FadeOut:create(0.2),
                            Hide:create(),
                    })
                    local wp = Panel_buffItem:getParent():convertToWorldSpace(Panel_buffItem:Pos())
                    local np = v:convertToNodeSpaceAR(wp)
                    Image_buffInfo:stopAllActions()
                    Image_buffInfo:setOpacity(100)
                    Image_buffInfo:runAction(seq)
                    Image_buffInfo:PosX(np.x)
            end)
            ListView_buff:pushBackCustomItem(Panel_buffItem)
        end
    end
end

function FubenSquadView:onTheaterBossInfoEvent()
    if self.Panel_theater:isVisible() then
        self:showTheater()
    end
end

---------------------------guide------------------------------

--引导点击第二个阵容
function FubenSquadView:excuteGuideFunc12002(guideFuncId)
    local targetNode = self.Panel_member[2].root
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode, ccp(0, -15))
end

--引导点击出击
function FubenSquadView:excuteGuideFunc12004(guideFuncId)
    local targetNode = self.Button_fighting
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

return FubenSquadView

