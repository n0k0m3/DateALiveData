
local BaseDataMgr = import(".BaseDataMgr")
local FubenDataMgr = class("FubenDataMgr", BaseDataMgr)

local maxStarLimit = 3
local UserDefault = CCUserDefault:sharedUserDefault()

function FubenDataMgr:init()
    TFDirector:addProto(s2c.DUNGEON_GET_LEVEL_INFO, self, self.onRecvLevelInfo)
    TFDirector:addProto(s2c.DUNGEON_UPADTE_LEVEL_INFO, self, self.onRecvAllLevelInfo)
    TFDirector:addProto(s2c.DUNGEON_FIGHT_START, self, self.onRecvFightStart)
    TFDirector:addProto(s2c.DUNGEON_FIGHT_OVER, self, self.onRecvFightOver)
    TFDirector:addProto(s2c.PLAYER_REPS_HELP_FIGHT_PLAYERS, self, self.onRecvFightAsstiant)
    TFDirector:addProto(s2c.DUNGEON_GET_LEVEL_GROUP_REWARD, self, self.onRecvLevelGroupReward)
    TFDirector:addProto(s2c.DUNGEON_UPDATE_LEVEL_GROUP_INFO, self, self.onRecvUpdateLevelGroupInfo)
    TFDirector:addProto(s2c.DUNGEON_REFRESH_DUNGEON_LEVEL_GROUP_LIST, self, self.onRecvUpdateGroupListInfo)
    TFDirector:addProto(s2c.DUNGEON_LEVEL_INFOS, self, self.onRecvUpdateLevelInfo)
    TFDirector:addProto(s2c.DUNGEON_BUY_FIGHT_COUNT, self, self.onRecvBuyFightCount)
    TFDirector:addProto(s2c.ENDLESS_CLOISTER_RSP_ENDLESS_CLOISTER_INFO, self, self.onRecvEndlessInfo)
    TFDirector:addProto(s2c.ENDLESS_CLOISTER_RSP_START_FIGHT_ENDLESS, self, self.onRecvStartFightEndless)
    TFDirector:addProto(s2c.ENDLESS_CLOISTER_RSP_PASS_STAGE_ENDLESS, self, self.onRecvPassEndless)
    TFDirector:addProto(s2c.DUNGEON_LIMIT_HERO_DUNGEON, self, self.onRecvLimitHeros)
    TFDirector:addProto(s2c.DUNGEON_GROUP_MULTIPLE_REWARD, self, self.onRecvGroupMultipleReward)
    TFDirector:addProto(s2c.DUNGEON_BUY_LEVEL_COUNT, self, self.onRecvLevelBuyCount)
    TFDirector:addProto(s2c.HERO_CHALLENGE_CHALLENGE_INFO, self, self.onRecvSpriteChallengeInfo)
    TFDirector:addProto(s2c.HERO_CHALLENGE_REFRESH_BUFF, self, self.onRecvSpriteRefreshBuffer)
    TFDirector:addProto(s2c.HERO_CHALLENGE_CHALLENGE_AWARD, self, self.onRecvGetSpriteReward)
    TFDirector:addProto(s2c.HERO_PRACTICE_PRACTICE_INFO, self, self.onRecvSpriteExtraLevelsInfo)
    TFDirector:addProto(s2c.HERO_PRACTICE_PRACTICE_LEVEL_INFO, self, self.onRecvSpriteExtraLevelUpdateInfo)
    TFDirector:addProto(s2c.ENDLESS_CLOISTER_RSP_ENDLESS_RANK_LIST, self, self.onRecvEndlessRank)
    TFDirector:addProto(s2c.ENDLESS_CLOISTER_RSP_ENDLESS_BUFF, self, self.onRecvEndlessLevelBuff)
    TFDirector:addProto(s2c.ENDLESS_CLOISTER_RSP_START_STAGE, self, self.onRecvEndlessJumpLevel)
    TFDirector:addProto(s2c.ODEUM_OPEN_PANEL, self, self.onRecvOpenTheaterBossInfo)
    TFDirector:addProto(s2c.ODEUM_RESQ_RANK, self, self.onRecvTheaterRank)
    TFDirector:addProto(s2c.ODEUM_RESP_NODE_PRIZE, self, self.onRecvTheaterNodeReward)
    TFDirector:addProto(s2c.ODEUM_UPDATE_BOSS_DUNGEON, self, self.onRecvTheaterLevelCid)
    TFDirector:addProto(s2c.ODEUM_UPDATE_LINGBO, self, self.onRecvTheaterLingbo)
    TFDirector:addProto(s2c.ODEUM_UPDATE_BOSS_STATUS, self, self.onRecvTheaterStatus)
    TFDirector:addProto(s2c.ODEUM_RESP_NODE_PRIZE, self, self.onRecvTheaterReceiveReward)
    TFDirector:addProto(s2c.ODEUM_RESQ_ODEUM_LEVEL_INFO, self, self.onRecvTheaterLevelInfo)
    TFDirector:addProto(s2c.ODEUM_LEVEL_SPECIAL_CONDITIONS, self, self.onRecvUpdateTheaterOptionInfo)
    TFDirector:addProto(s2c.ODEUM_LEVEL_RECORD, self, self.onRecvUpdateTheaterLevelOrder)
    TFDirector:addProto(s2c.ODEUM_UPDATE_CONTRIBUTION, self, self.onRecvUpdateTheaterContribution)
    TFDirector:addProto(s2c.ODEUM_RESP_NOTICE, self, self.onRecvUpdateTheaterNotice)
    TFDirector:addProto(s2c.ODEUM_RESP_SELF_CONTRI_PRIZE, self, self.onRecvTheaterReward)
    TFDirector:addProto(s2c.ODEUM_RESP_UPDATE_FINISH_PROCESS, self, self.onRecvUpdataTheaterContorProcess)
    TFDirector:addProto(s2c.ODEUM_RESP_FINISH_PROCESS, self, self.onRecvTheaterContorProcess)
    TFDirector:addProto(s2c.HERO_RES_SIMULATE_TRAIN_INFO, self, self.onRevSimulationTrialInfo)
    TFDirector:addProto(s2c.HERO_RES_COMPLETE_STTASK, self, self.onRevCompleteSTTask)
    TFDirector:addProto(s2c.HERO_RES_STTASK_CHANGE, self, self.onRevSTTaskChange)
    --海王星联动
    TFDirector:addProto(s2c.DUNGEON_RESP_TIME_LINKAGE_INFO, self, self.onRevLinkageInfo)
    TFDirector:addProto(s2c.DUNGEON_RESP_TIME_LINKAGE_CG, self, self.onRevLinkageCG)
	
	--魔王试炼2020/5/13
	TFDirector:addProto(s2c.DUNGEON_RESP_GET_EXPERIMENT, self, self.onRecvMonsterTrialInfo)
	TFDirector:addProto(s2c.DUNGEON_RESP_SETTLE_EXPERIMENT, self, self.onRecvMonsterTrialSettlement)

    TFDirector:addProto(s2c.DUNGEON_RESP_GET_LINK_AGE, self, self.onRecvLinkAgeData)
    TFDirector:addProto(s2c.DUNGEON_RESP_SET_LINK_AGE_HERO, self, self.onSetLinkAgeHeroRsp)
    TFDirector:addProto(s2c.DUNGEON_RESP_CHANGE_LINK_AGE_DESIRE, self, self.onChangeLinkAgeDesireRsp)
    TFDirector:addProto(s2c.DUNGEON_RESP_ATTR_CHANGE, self, self.onAttrUpRsp)

    -- 章节
    self.chapterMap_ = TabDataMgr:getData("DungeonChapter")
    self.chapter_ = {}
    for k, v in pairs(self.chapterMap_) do
        self.chapter_[v.type] = self.chapter_[v.type] or {}
        table.insert(self.chapter_[v.type], v.id)
    end
    for k, v in pairs(self.chapter_) do
        table.sort(v, function(a, b)
                       local cfgA = self.chapterMap_[a]
                       local cfgB = self.chapterMap_[b]
                       return cfgA.order < cfgB.order
        end)
    end

    -- 关卡组
    self.levelGroupMap_ = TabDataMgr:getData("DungeonLevelGroup")
    self.levelGroup_ = {}
    for k, v in pairs(self.levelGroupMap_) do
        self.levelGroup_[v.dungeonChapterId] = self.levelGroup_[v.dungeonChapterId] or {}
        table.insert(self.levelGroup_[v.dungeonChapterId], v.id)
    end
    for k, v in pairs(self.levelGroup_) do
        table.sort(v, function(a, b)
                       local cfgA = self.levelGroupMap_[a]
                       local cfgB = self.levelGroupMap_[b]
                       return cfgA.order < cfgB.order
        end)
    end

    -- 关卡
    self.levelMap_ = TabDataMgr:getData("DungeonLevel")
    self.level_ = {}
    for k, v in pairs(self.levelMap_) do
        self.level_[v.levelGroupId] = self.level_[v.levelGroupId] or {}
        table.insert(self.level_[v.levelGroupId], v.id)
    end
    for k, v in pairs(self.level_) do
        table.sort(v, function(a, b)
                       local cfgA = self.levelMap_[a]
                       local cfgB = self.levelMap_[b]
                       return cfgA.num < cfgB.num
        end)
    end

    -- 精灵副本
    self.challengeDungenMap_ = TabDataMgr:getData("ChallengeDungen")
    self.challengeDungen_ = {}
    for k, v in pairs(self.challengeDungenMap_) do
        self.challengeDungen_[v.dungenLevel] = v
    end

    -- 万由里
    self.storyDungeonLevelMap_ = TabDataMgr:getData("StoryDungeonLevel")
    self.storyDungeonLevel_ = {}
    for k, v in pairs(self.storyDungeonLevelMap_) do
        local levels = self.storyDungeonLevel_[v.chapter] or {}
        table.insert(levels, k)
        self.storyDungeonLevel_[v.chapter] = levels
    end
    self.storyGroupDungeonLevel_ = {}
    for chapterCid, v in pairs(self.storyDungeonLevel_) do
        local groupLevels = self.storyGroupDungeonLevel_[chapterCid] or {}
        for _, levelCid in ipairs(v) do
            local levelCfg = self.storyDungeonLevelMap_[levelCid]
            local levels = groupLevels[levelCfg.group] or {}
            table.insert(levels, levelCid)
            groupLevels[levelCfg.group] = levels
        end
        self.storyGroupDungeonLevel_[chapterCid] = groupLevels
    end
    for _, groupLevels in pairs(self.storyGroupDungeonLevel_) do
        for _, levels in pairs(groupLevels) do
            table.sort(levels, function(a, b)
                           local levelCfgA = self.storyDungeonLevelMap_[a]
                           local levelCfgB = self.storyDungeonLevelMap_[b]
                           return levelCfgA.groupCenter > levelCfgB.groupCenter
            end)
        end
    end

    -- 剧情副本关卡名字
    self.levelName_ = {}
    local plotChapter = self.chapter_[EC_FBType.PLOT]
    for i, chapterId in ipairs(plotChapter) do
        local levelIndex = {}
        local freeLevelIndex = {}
        local chapterCfg = self.chapterMap_[chapterId]
        local levelGroup = self.levelGroup_[chapterId]
        for _, levelGroupId in ipairs(levelGroup) do
            local levelGroupCfg = self.levelGroupMap_[levelGroupId]
            for _, diff in pairs(EC_FBDiff) do
                local level = self:getLevel(levelGroupId, diff)
                for _, levelId in ipairs(level) do
                    local levelCfg = self.levelMap_[levelId]
                    if levelCfg.isFree then
                        local index = freeLevelIndex[diff] or 0
                        freeLevelIndex[diff] = index + 1
                        self.levelName_[levelId] = TextDataMgr:getText(300307, chapterCfg.orderName, freeLevelIndex[diff])
                    else
                        local index = levelIndex[diff] or 0
                        levelIndex[diff] = index + 1
                        self.levelName_[levelId] = TextDataMgr:getText(300306, chapterCfg.orderName, levelIndex[diff])
                    end
                end
            end
        end
    end

    ---狂三副本
    self.ksDungeonCityCfgMap = {}
    self.ksDungeonCityCfg = TabDataMgr:getData("KurumiDungeonCity")
    for k,v in ipairs(self.ksDungeonCityCfg) do
        self.ksDungeonCityCfgMap[v.dungeon] = v
    end

    ---魔禁副本
    self.mojinCityDisplayCfgMap = {}
    local MojinDungeonDisplay = TabDataMgr:getData("MojinDungeonDisplay")
    for k,v in pairs(MojinDungeonDisplay) do
        self.mojinCityDisplayCfgMap[v.dungeon] = v
    end

    -- 无尽副本
    self.endlessCloisterLevel_ = {}
    self.endlessCloisterLevelMap_ = TabDataMgr:getData("EndlessCloisterLevel")
    for k, v in pairs(self.endlessCloisterLevelMap_) do
        local week = self.endlessCloisterLevel_[v.week] or {}
        self.endlessCloisterLevel_[v.week] = week
        table.insert(week, k)

    end
    for k, v in pairs(self.endlessCloisterLevel_) do
        table.sort(v, function(a, b)
                       local cfgA = self.endlessCloisterLevelMap_[a]
                       local cfgB = self.endlessCloisterLevelMap_[b]
                       return cfgA.order < cfgB.order
        end)
    end

    ---模拟试炼配置
    self.simulationTrialChapterInfo_ = {}
    self.simulationTrialGroupInfo_ = {}
    self.simulationRewardIds_ = {}
    self.simulationTrialHighCfg = TabDataMgr:getData("SimulationTrialHigh")
    for k,v in pairs(self.simulationTrialHighCfg) do
        table.insert(self.simulationTrialChapterInfo_,v.main.chapterId)
        table.insert(self.simulationTrialGroupInfo_,v.chapter.groupIds)
        table.insertTo(self.simulationRewardIds_,v.dropIds)
    end

    --boss挑战
    self.NewBossChallenge_ = {}
    local cfgs = TabDataMgr:getData("NewBossChallenge")
    for k,v in pairs(cfgs) do
        table.insert(self.NewBossChallenge_,v)
    end
    table.sort(self.NewBossChallenge_, function(a, b)
        return a.round < b.round
    end )

    -- 所有关卡信息
    self.levelInfo_ = {}

    -- 所有关卡组信息
    self.levelGroupInfo_ = {}

    -- 无尽回廊信息
    self.endlessInfo_ = {}

    -- 解锁下一章节的当前章节ID
    self.unlockNextChapterCid_ = nil

    -- 助战列表
    self.assistantData_=  {}

    -- 限定英雄信息
    self.limitHeros_ = {}
    self.originLevelFormation_ = {}
    self.levelFormation_ = {}

    -- 当前关卡
    self.curLevelCid_ = nil

    -- 日常副本多倍奖励信息
    self.dailyMultipleInfo_ = {}

    -- 精灵副本信息
    self.spriteChallengeInfo_ = {}

    --精灵外传副本数据
    self.spriteExtraInfo_ = {}

    -- 万由里关卡顺序
    self.theaterLevelOrder_ = {}
    -- 万由里关卡顺序权重
    self.theaterLevelWeight_ = {}
    -- 万由里章节动画播放，每次登陆重置
    self.theaterLevelAni_ = {}
    -- 万由里约会选项信息
    self.theaterDatingOptionInfo_ = {}
    -- 万由里boss挑战信息
    self.theaterNotice_ = {}
    self.theaterControlProcess = {}
    -- 模拟试炼数据
    self.simulationTrialInfo_ = {}

    --检查是否需要检测所关卡全部完成
    self.isNeedCheckAllPassWin = false
    self.isEntry = false
end

function FubenDataMgr:reset()
    self.levelInfo_ = {}
    self.levelGroupInfo_ = {}
    self.selectLevelGroup_ = nil
    self.selectChapter_ = nil
    self.selectFubenType_ = nil
    self.selectLevelGroup_ = nil
    self.dailyMultipleInfo_ = {}
    self.theaterDatingOptionInfo_ = {}
    self.theaterLevelOrder_ = {}
    self.theaterLevelWeight_ = {}
    self.theaterLevelAni_ = {}
    self.theaterNotice_ = {}
    self.dailyMultipleInfo_ = {}
    self.spriteChallengeInfo_ = {}
    self.spriteExtraInfo_ = {}
    self.theaterControlProcess = {}
    self.simulationTrialInfo_ = {}
    self.lastCycleList =  {}
    self.presentRankList = {}
    self.simulationTrialReward = nil
    self.linkageInfo = nil

    ---阵容排序默认排序ID
    self.formationSortRuleId = 5

    self.attrUpData = nil
    self.linkAgeHeros = nil
    self.jiBanHero = nil
    self.limitHeros_ = {}
    self.originLevelFormation_ = {}
    self.levelFormation_ = {}
    self.isEntry = false
    self.entryFirstLevelTimes = 0

    ---阵容排序默认排序ID
    self.formationSortRuleId = 5
    self.enterNianshouChanllenge = nil -- 特殊标记重置
end

function FubenDataMgr:setFormationSortRuleId(ruleId)
    self.formationSortRuleId = ruleId or self.formationSortRuleId
end

function FubenDataMgr:getFormationSortRuleId()
    return self.formationSortRuleId
end

function FubenDataMgr:onLoginOut()
    self:reset()
end

function FubenDataMgr:onLogin()
    local waitList = {
        s2c.DUNGEON_GET_LEVEL_INFO,
        s2c.ENDLESS_CLOISTER_RSP_ENDLESS_CLOISTER_INFO,
        s2c.DUNGEON_GROUP_MULTIPLE_REWARD,
        s2c.HERO_CHALLENGE_CHALLENGE_INFO,
        s2c.HERO_PRACTICE_PRACTICE_INFO,
        s2c.ODEUM_OPEN_PANEL,
        s2c.ODEUM_RESQ_ODEUM_LEVEL_INFO,
        s2c.HERO_REQ_SIMULATE_TRAIN_INFO,
        s2c.DUNGEON_RESP_TIME_LINKAGE_INFO,
    }

    TFDirector:send(c2s.DUNGEON_GET_LEVEL_INFO, {})
    TFDirector:send(c2s.ENDLESS_CLOISTER_REQ_ENDLESS_CLOISTER_INFO, {})
    TFDirector:send(c2s.DUNGEON_GROUP_MULTIPLE_REWARD, {})
    TFDirector:send(c2s.HERO_CHALLENGE_CHALLENGE_INFO, {})
    TFDirector:send(c2s.HERO_PRACTICE_PRACTICE_LEVEL_INFO, {})
    TFDirector:send(c2s.ODEUM_OPEN_PANEL, {})
    TFDirector:send(c2s.ODEUM_REQ_ODEUM_LEVEL_INFO, {})
    TFDirector:send(c2s.HERO_REQ_SIMULATE_TRAIN_INFO, {}) --模拟试炼信息
    TFDirector:send(c2s.DUNGEON_REQ_TIME_LINKAGE_INFO,{})


    return waitList
end

function FubenDataMgr:onEnterMain()
    -- UserDefault键值
    local pid = MainPlayer:getPlayerId()
    self.KEY_FUBEN_SELECT_CHAPTER = string.format("key_%s_fuben_select_chapter", pid)
    self.KEY_FUBEN_SELECT_DIFF = string.format("key_%s_fuben_select_diff", pid)
    self.KEY_FUBEN_SELECT_LEVELGROUP = string.format("key_%s_fuben_select_levelgroup", pid)
    self.KEY_FUBEN_SELECT_FUBENTYPE = string.format("key_%s_fuben_select_fubentype", pid)
end

function FubenDataMgr:getSimulationTrialCfg(cid)
    return self.simulationTrialHighCfg[cid]
end

function FubenDataMgr:isSimulationChapter(chapterCid)
    local index = table.indexOf(self.simulationTrialChapterInfo_,chapterCid)
    return index ~= -1
end

function FubenDataMgr:isSimulationGroup(index,groupCid)

    local isSimulationGroup = false
    for k,v in ipairs(self.simulationTrialGroupInfo_) do
        if not index then
            for _,groupId in ipairs(v) do
                if groupId == groupCid then
                    isSimulationGroup = true
                    break
                end
            end
        else
            if v[index] == groupCid then
                isSimulationGroup = true
                break
            end
        end
    end
    return isSimulationGroup

end

function FubenDataMgr:isSimulationReward(rewardId)
    local index = table.indexOf(self.simulationRewardIds_,rewardId)
    return index ~= -1
end


function FubenDataMgr:getChapterCfg(chapterId)
    if chapterId then
        return self.chapterMap_[chapterId]
    else
        return self.chapterMap_
    end
end

function FubenDataMgr:getActivityChapterIsOpen(chapterCid)
    local isOpen = false
    if chapterCid == EC_ActivityFubenType.TEAM then
        isOpen = true
    elseif chapterCid == EC_ActivityFubenType.ENDLESS then
        local endlessInfo = self:getEndlessInfo()
        isOpen = endlessInfo.step == EC_EndlessState.ING
    elseif chapterCid == EC_ActivityFubenType.KABALA then
        isOpen = KabalaTreeDataMgr:isFunctionOpen()
    elseif chapterCid == EC_ActivityFubenType.SPRITE then
        local funcIsOpen = FunctionDataMgr:isOpen(58)
        isOpen = self:getSpriteChallengeIsOpen() and funcIsOpen
    elseif chapterCid == EC_ActivityFubenType.SPRITE_EXTRA then
        local funcIsOpen = FunctionDataMgr:isOpen(59)
        isOpen = self:getSpriteExtraIsOpen() and funcIsOpen
    elseif chapterCid == EC_ActivityFubenType.TEAM_PVE then
        isOpen = TeamPveDataMgr:specialIsOpen()
    elseif chapterCid == EC_ActivityFubenType.BIG_WORLD then
        isOpen = true
    elseif chapterCid == EC_ActivityFubenType.SKYLADDER then
        isOpen = SkyLadderDataMgr:isOpen()
    elseif self:isSimulationChapter(chapterCid) then --模拟试炼
        local funcIsOpen = FunctionDataMgr:isOpen(113)
        isOpen = self:getSimulationTrialIsOpen() and funcIsOpen
    end

    return isOpen
end

function FubenDataMgr:getChapter(fubenType, notSort)
    if fubenType then
        local data = {}
        local chapter = self.chapter_[fubenType]
        if fubenType == EC_FBType.DAILY then
            data = clone(self:getLevelGroup(chapter[1]))
            if not notSort then
                table.sort(data, function(a, b)
                       if self:getDailyIsOpen(a) == self:getDailyIsOpen(b) then
                           local cfgA = self.levelGroupMap_[a]
                           local cfgB = self.levelGroupMap_[b]
                           return cfgA.order < cfgB.order
                       end
                       return self:getDailyIsOpen(a)
                end)
            end
        elseif fubenType == EC_FBType.ACTIVITY then
            -- 指定活动副本 但不需要展示在作战活动里面
            for i, v in ipairs(chapter) do
                if v == EC_ActivityFubenType.SNOW_FESVITAL then
                    table.remove(chapter, i)
                end
            end 

            local openList = {}
            for i, v in ipairs(chapter) do
                if self:getActivityChapterIsOpen(v) then
                    openList[v] = 1
                else
                    openList[v] = 0
                end
            end
            data = clone(chapter)
            if not notSort then
                table.sort(data, function(a, b)
                               if openList[a] == openList[b] then
                                   local cfgA = self.chapterMap_[a]
                                   local cfgB = self.chapterMap_[b]
                                   return cfgA.order < cfgB.order
                               end
                               return openList[a] > openList[b]
                end)
            end
        else
            data = chapter
        end
        data = data or {}
        return data
    else
        return self.chapter_
    end
end

function FubenDataMgr:getDispatchLevel(dispatchType)
    local data = {}
    local chapter = {}
    if dispatchType == EC_DISPATCHType.DAILY then
        chapter = self.chapter_[EC_FBType.DAILY]
        local dailyData = clone(self:getLevelGroup(chapter[1]))
        for k,levelGroupId in pairs(dailyData) do
            if self:getDailyIsOpen(levelGroupId) then
                local levels = self:getLevel(levelGroupId)
                local topLevel = self:getDailyTopStarLevel(levelGroupId)
                if topLevel then
                    for i=#levels,1,-1 do
                        local levelCid = levels[i]
                        if topLevel == levelCid then
                            table.insert(data,levelCid)
                        end 
                    end
                end
            end
        end
    elseif dispatchType == EC_DISPATCHType.SPRITE then
        chapter = self.chapter_[EC_FBType.ACTIVITY]
        for i, v in ipairs(chapter) do
            if v == EC_ActivityFubenType.SPRITE then
                if self.spriteChallengeInfo_ and self.spriteChallengeInfo_.finishAny then
                    local levelCid = self:getCurSpriteLevelCid()
                    table.insert(data,levelCid)
                end
            end
        end
    elseif dispatchType == EC_DISPATCHType.THEATER then
        if self.theaterBossInfo_ and self.theaterBossInfo_.status ~= EC_TheaterStatus.CLOSING then
            if self.theaterBossInfo_.fightState then
                table.insert(data, self.theaterBossInfo_.bossDungeonId)
            end
        end
    elseif dispatchType == EC_DISPATCHType.TEAM then
        chapter = self.chapter_[EC_FBType.ACTIVITY]
        local levels = TeamFightDataMgr:getOpenLevels()
        for i,v in ipairs(levels) do
            if TeamFightDataMgr:checkLevelPassOver(v) then
                table.insert(data,v)
            end
        end
    end
    data = data or {}
    return data
end

function FubenDataMgr:getDailyTopStarLevel(levelGroupCid)
    local info = self.dailyMultipleInfo_[levelGroupCid]
    if info then
        return info.topStarsLevel
    end
end

function FubenDataMgr:getTheaterChapter( exChapterId )
    local exChapterId_ = exChapterId or TabDataMgr:getData("DiscreteData",46013).data.defaultSelect
    local theaterCfg = TabDataMgr:getData("ExtraChapter",exChapterId_)
    return theaterCfg.chapters, exChapterId_ 
end

function FubenDataMgr:getTheaterHardChapter( exChapterId )
    local exChapterId_ = exChapterId or TabDataMgr:getData("DiscreteData",46013).data.defaultSelect
    local theaterCfg = TabDataMgr:getData("ExtraChapter",exChapterId_)
    return theaterCfg.hardChapters , exChapterId_
end

function FubenDataMgr:getTheaterExtraChapter(chapterCid)
    local extraChapterMap = TabDataMgr:getData("ExtraChapter")
    local extraChapterCid
    for k, v in pairs(extraChapterMap) do
        local index = table.indexOf(v.chapters, chapterCid)
        if index ~= -1 then
            extraChapterCid = v.id
            break
        end
    end
    return extraChapterCid
end

function FubenDataMgr:getLevelCidBySite(levelGroupCid, diff, site)
    local level = self:getLevel(levelGroupCid, diff)
    local levelCid
    for i, v in ipairs(level) do
        local levelCfg = self:getLevelCfg(v)
        if levelCfg.positionOrder[1] == site then
            levelCid = v
            break
        end
    end
    return levelCid
end

function FubenDataMgr:getLevelGroup(chapterId)
    if chapterId then
        return self.levelGroup_[chapterId]
    else
        return self.levelGroup_
    end
end

function FubenDataMgr:getChapterOrderName(chapterCid)
    local chapterCfg = self:getChapterCfg(chapterCid)
    local chineseNumber = Utils:getChineseNumber(chapterCfg.orderName)
    local name = TextDataMgr:getText(300200, chineseNumber)
    return name
end

function FubenDataMgr:getChapterName(chapterCid)
    local chapterCfg = self:getChapterCfg(chapterCid)
    local name = TextDataMgr:getText(chapterCfg.name)
    local enName = TextDataMgr:getText(chapterCfg.nameEn)
    return name .. "-"..enName
end

function FubenDataMgr:getChapterFullName(chapterCid)
    local orderName = self:getChapterOrderName(chapterCid)
    local name = self:getChapterName(chapterCid)
    local fullName = TextDataMgr:getText(300231, orderName, name)
    return fullName
end

function FubenDataMgr:getLevelGroupCfg(levelGroupId)
    if levelGroupId then
        return self.levelGroupMap_[levelGroupId]
    else
        return self.levelGroupMap_
    end
end

function FubenDataMgr:getLevelGroupInfo(levelGroupId)
    return self.levelGroupInfo_[levelGroupId]
end

function FubenDataMgr:getLevel(levelGroupId, diff)
    local level = {}
    local levels = self.level_[levelGroupId]
    if levels then
        for i, v in ipairs(levels) do
            local levelCfg = self.levelMap_[v]
            if diff then
                if levelCfg.difficulty == diff then
                    table.insert(level, v)
                end
            else
                table.insert(level, v)
            end
        end
    end
    return level
end

function FubenDataMgr:getLevelName(levelCid)
    local levelCfg = self:getLevelCfg(levelCid)
    if levelCfg.dungeonType == EC_FBLevelType.NOOBSUMMON then
        return ""
    end
    if levelCfg.dungeonType == EC_FBLevelType.TXJZ then
        return TextDataMgr:getText(levelCfg.name)
    elseif levelCfg.dungeonType == EC_FBLevelType.HUNTER then
        return TextDataMgr:getText(levelCfg.name)
    elseif levelCfg.dungeonType == EC_FBLevelType.MUSIC_GAME then
        return TextDataMgr:getText(levelCfg.name)
    end
    local levelGroupCfg = self:getLevelGroupCfg(levelCfg.levelGroupId)
    local chapterCfg = self:getChapterCfg(levelGroupCfg.dungeonChapterId)
    local name = ""
    if chapterCfg.type == EC_FBType.THEATER or chapterCfg.type == EC_FBType.THEATER_HARD then
        local theaterLevelCfg = self:getTheaterDungeonLevelCfg(levelCid)
        name = TextDataMgr:getText(theaterLevelCfg.storydungeonName)
    elseif chapterCfg.type == EC_FBType.HOLIDAY then
        if levelCfg.name ~= 0 then
            name = TextDataMgr:getText(levelCfg.name)
        end
    elseif chapterCfg.type == EC_FBType.PLOT then
        name = self.levelName_[levelCid]
    else
        if levelCfg.name ~= 0 then
            name = TextDataMgr:getText(levelCfg.name)
        end
    end
    return name
end

function FubenDataMgr:getAllLevelName(levelName)
    return self.levelName_
end

function FubenDataMgr:getLevelCfg(levelId)
    return self.levelMap_[levelId]
end

function FubenDataMgr:getLevelInfo(levelId)
    return self.levelInfo_[levelId]
end

function FubenDataMgr:getMainScenario(scriptId)
    if scriptId then
        return self.mainScenario_[scriptId]
    else
        return self.mainScenario_
    end
end

function FubenDataMgr:getMainScenarioCfg(mainScenarioId)
    if mainScenarioId then
        return self.mainScenarioMap_[mainScenarioId]
    else
        return self.mainScenarioMap_
    end
end

function FubenDataMgr:getFightCount(levelCid)
    local fightCount = 0
    local levelInfo = self:getLevelInfo(levelCid)
    if levelInfo then
        fightCount = levelInfo.fightCount
    end
    return fightCount
end

function FubenDataMgr:isPassPlotChapter(chapterId)
    local isPass = true
    local levelGroup = self:getLevelGroup(chapterId)
    for i, v in ipairs(levelGroup) do
        isPass = self:isPassPlotLevelGroup(v, EC_FBDiff.SIMPLE)
        if not isPass then
            break
        end
    end
    return isPass
end

function FubenDataMgr:isPassPlotLevel(levelCid)
    local levelInfo = self.levelInfo_[levelCid]
    local isPass = tobool(levelInfo and levelInfo.win)
    return isPass
end

function FubenDataMgr:isPreFramePassPlotLevel(levelCid) -- 上一帧是否通关
    local levelInfo = self.tmpLevelInfo and  self.tmpLevelInfo[levelCid] or self.levelInfo_[levelCid]
    local isPass = tobool(levelInfo and levelInfo.win)
    return isPass
end

function FubenDataMgr:isPassPlotLevelGroup(levelGroupId, diff)
    local levelGroupCfg = self.levelGroupMap_[levelGroupId]
    local isPass = true
    if levelGroupCfg.dungeonType == EC_FBLevelGroupType.NORMAL 
    or levelGroupCfg.dungeonType == EC_FBLevelGroupType.LINKAGE
    or levelGroupCfg.dungeonType == EC_FBLevelGroupType.LINKAGEHWX then
        local level = self:getLevel(levelGroupId, diff)
        for i, v in ipairs(level) do
            local levelCfg = self:getLevelCfg(v)
            if not levelCfg.isFree then
                isPass = self:isPassPlotLevel(v)
            end
            if not isPass then
                break
            end
        end
    end

    return isPass
end

function FubenDataMgr:getChapterFirstLevel(chapterCid, diff)
    local levelGroup = self:getLevelGroup(chapterCid)
    local levelCid
    if levelGroup[1] then
        local level = self:getLevel(levelGroup[1], diff)
        levelCid = level[1]
    end
    return levelCid
end

function FubenDataMgr:checkPlotChapterEnabled(chapterCid, diff)
    local enabled = false
    local firstLevelCid = self:getChapterFirstLevel(chapterCid, diff)
    if firstLevelCid then
        enabled = self:checkPlotLevelEnabled(firstLevelCid)
    end
    return enabled
end

function FubenDataMgr:checkGroupEnabled(groupId, diff)
    local enabled = false
    local firstLevelCid = self:getLevel(groupId, diff)[1]
    if firstLevelCid then
        enabled = self:checkPlotLevelEnabled(firstLevelCid)
    end
    return enabled
end

function FubenDataMgr:checkPreFrameGroupEnabled(groupId, diff)
    local enabled = false
    local firstLevelCid = self:getLevel(groupId, diff)[1]
    if firstLevelCid then
        enabled = self:checkPreFramePlotLevelEnabled(firstLevelCid)
    end
    return enabled
end


function FubenDataMgr:getNextPlotChapterCid(chapterCid)
    local chapterCfg = self:getChapterCfg(chapterCid)
    local chapter = self:getChapter(EC_FBType.PLOT)
    local index = table.indexOf(chapter, chapterCid)
    local nextChapterCid = nil
    if index ~= -1 and chapter[index + 1] then
        nextChapterCid = chapter[index + 1]
    end
    return nextChapterCid
end

function FubenDataMgr:getPrePlotChapterCid(chapterCid)
    local chapterCfg = self:getChapterCfg(chapterCid)
    local chapter = self:getChapter(EC_FBType.PLOT)
    local index = table.indexOf(chapter, chapterCid)
    local preChapterCid = nil
    if index ~= -1 and chapter[index - 1] then
        preChapterCid = chapter[index - 1]
    end
    return preChapterCid
end

function FubenDataMgr:checkNextPlotChapterEnabled(chapterCid)
    local chapterCfg = self:getChapterCfg(chapterCid)
    local enabled = false
    if chapterCfg.type == EC_FBType.PLOT then
        local nextChapterCid = self:getNextPlotChapterCid(chapterCid)
        if nextChapterCid then
            enabled = self:checkPlotChapterEnabled(nextChapterCid)
        end
    end
    return enabled
end

function FubenDataMgr:checkPlotLevelGroupEnabled(levelGroupId)
    local levelGroupCfg = self.levelGroupMap_[levelGroupId]
    local enabled = true
    local preLevelGroupId = levelGroupCfg.preDungeonId
    if preLevelGroupId ~= 0 then
        if levelGroupCfg.preType == 1 then
            enabled = self:isPassPlotLevelGroup(preLevelGroupId, EC_FBDiff.SIMPLE)
        elseif levelGroupCfg.preType == 2 then
            enabled = self:isPassPlotLevel(preLevelGroupId)
        end
    end
    return enabled
end

function FubenDataMgr:checkPlotLevelEnabled(levelId)
    local enabled = false
    local levelIsOpen = false
    local preIsOpen = false
    local isTimeOpen = true
    if self:isPassPlotLevel(levelId) then
        enabled = true
        levelIsOpen = true
        preIsOpen = true
    else
        local levelCfg = self:getLevelCfg(levelId)
        preIsOpen = true
        local preLevelId = levelCfg.preLevelId
        for i, v in ipairs(preLevelId) do
            preIsOpen = preIsOpen and self:isPassPlotLevel(v)
            if not preIsOpen then
                break
            end
        end

        local otherPreCond = levelCfg.otherPreCond
        local curTime = ServerDataMgr:getServerTime()
        if otherPreCond and preIsOpen then
            for k,v in pairs(otherPreCond) do
                if k == "time" then
                    if curTime < v[1] or curTime > v[2] then
                        isTimeOpen = false
                        break
                    end
                end
            end
        end
        
        levelIsOpen = MainPlayer:getPlayerLv() >= levelCfg.playerLv
        enabled = preIsOpen and levelIsOpen and isTimeOpen
    end
    return enabled, preIsOpen, levelIsOpen, isTimeOpen
end

function FubenDataMgr:checkPreFramePlotLevelEnabled(levelId)
    local enabled = false
    local levelIsOpen = false
    local preIsOpen = false
    if self:isPreFramePassPlotLevel(levelId) then
        enabled = true
        levelIsOpen = true
        preIsOpen = true
    else
        local levelCfg = self:getLevelCfg(levelId)
        preIsOpen = true
        local preLevelId = levelCfg.preLevelId
        for i, v in ipairs(preLevelId) do
            preIsOpen = preIsOpen and self:isPreFramePassPlotLevel(v)
            if not preIsOpen then
                break
            end
        end

        local otherPreCond = levelCfg.otherPreCond
        local curTime = ServerDataMgr:getServerTime()
        if otherPreCond and preIsOpen then
            for k,v in pairs(otherPreCond) do
                if k == "time" then
                    if curTime < v[1] or curTime > v[2] then
                        preIsOpen = false
                        break
                    end
                end
            end
        end
        
        levelIsOpen = MainPlayer:getPlayerLv() >= levelCfg.playerLv
        enabled = preIsOpen and levelIsOpen
    end
    return enabled, preIsOpen, levelIsOpen
end

function FubenDataMgr:checkPlotDiffEnabled(diff)
    local chapter = self:getChapter(EC_FBType.PLOT)
    local levelGroup = self:getLevelGroup(chapter[1])
    local plotLevelGroupId
    for i, v in ipairs(levelGroup) do
        local levelGroupCfg = self:getLevelGroupCfg(v)
        if levelGroupCfg.dungeonType == EC_FBLevelType.NORMAL then
            plotLevelGroupId = v
            break
        end
    end

    local level = self:getLevel(plotLevelGroupId, diff)
    local enabled = false
    for i, v in ipairs(level) do
        if self:checkPlotLevelEnabled(v) then
            enabled = true
            break
        end
    end
    return enabled
end

function FubenDataMgr:getStarRuleDesc(levelId, pos)
    local levelCfg = self.levelMap_[levelId]
    local desc = ""
    if levelCfg.dungeonType == EC_FBLevelType.FIGHTING or levelCfg.dungeonType == EC_FBLevelType.THEATER_FIGHTING
        or levelCfg.dungeonType == EC_FBLevelType.KUANGSAN_FIGHTING or levelCfg.dungeonType == EC_FBLevelType.HWX or levelCfg.dungeonType == EC_FBLevelType.KUANGSAN_DATING or levelCfg.dungeonType == EC_FBLevelType.DICUO_MAINFIGHT then
        local starParam = levelCfg.starParam
        local starRule = levelCfg.starType
        local rule = starRule[pos]
        local starDesc = EC_FBStarRuleStr[rule]
        if rule == EC_FBStarRule.PASS then
            desc = TextDataMgr:getText(starDesc)
        elseif rule == EC_FBStarRule.HERO_BATTLE then
            local heroCfg = TabDataMgr:getData("Hero", starParam[pos])
            local name = TextDataMgr:getText(heroCfg.name)
            desc = TextDataMgr:getText(starDesc, name)
        else
            desc = TextDataMgr:getText(starDesc, starParam[pos])
        end
        return desc
    elseif levelCfg.dungeonType == EC_FBLevelType.DATING or levelCfg.dungeonType == EC_FBLevelType.THEATER_DATING or levelCfg.dungeonType == EC_FBLevelType.KUANGSAN_DATING or levelCfg.dungeonType == EC_FBLevelType.DICUO_MAINDATING then
        pos = 1
        local datingID = levelCfg.datingID[#levelCfg.datingID]
        if datingID then
            local datingRuleCfg = TabDataMgr:getData("DatingRule", datingID)
            desc = TextDataMgr:getText(datingRuleCfg.dungeonDateDes[pos])
        end
    elseif levelCfg.dungeonType == EC_FBLevelType.CITYDATING then
        local starDesc = levelCfg.starDescribe
        desc = TextDataMgr:getText(starDesc[1])
    end
    return desc
end

function FubenDataMgr:getPassCondDesc(levelId, pos)
    local levelCfg = self.levelMap_[levelId]
    local type_ = levelCfg.victoryType[pos]
    local param = levelCfg.victoryParam[pos]
    local descId = levelCfg.victoryTypeDescribe[pos]
    local desc = ""
    if type_ == EC_LevelPassCond.DESTORY then
        desc = TextDataMgr:getText(descId)
    elseif type_ == EC_LevelPassCond.SURVIVAL
        or type_ == EC_LevelPassCond.SURVIVAL_HURT then
        desc = TextDataMgr:getText(descId, param[1])
    elseif type_ == EC_LevelPassCond.SPECIFICID then
        local monsterCfg = TabDataMgr:getData("Monster", param[1])
        local monsterName = TextDataMgr:getText(monsterCfg.name)
        if param[2] > 1 then
            desc = TextDataMgr:getText(descId, param[2], monsterName)
        else
            descId = 300807
            desc = TextDataMgr:getText(descId, monsterName)
        end
    elseif type_ == EC_LevelPassCond.SPECIFICTYPE then
        local monsterTypeName = TextDataMgr:getText(EC_MonsterTypeName[param[1]])
        desc = TextDataMgr:getText(descId, param[2], monsterTypeName)
    elseif type_ == EC_LevelPassCond.SPECIFICCOUNT then
        desc = TextDataMgr:getText(descId, param[1])
    elseif type_ == EC_LevelPassCond.LIMIT_TIME_KILL then -- 限时杀怪
        desc = TextDataMgr:getText(descId, param[1])
    elseif type_ == EC_LevelPassCond.COMBO_COUNT then -- 连击数
        desc = TextDataMgr:getText(descId, param[1])
    else
        desc = TextDataMgr:getText(descId)
    end
    --TODO 特殊关卡显示描述处理
    if levelId ~= 710006 and levelCfg.time > 0 and type_ ~= EC_LevelPassCond.SURVIVAL then
        local timeStr = TextDataMgr:getText(300825, levelCfg.time)

        local code = TFLanguageMgr:getUsingLanguage()
        if (code == cc.SIMPLIFIED_CHINESE) or (code == cc.TRADITIONAL_CHINESE) then
            desc = timeStr .. desc
        else
            desc = timeStr .." ".. desc
        end
    end
    return desc
end

function FubenDataMgr:judgeStarIsActive(levelCid, pos, isReal)
    local levelInfo = self:getLevelInfo(levelCid)
    local levelCfg = self:getLevelCfg(levelCid)
    local isDaily = false
    for k, v in pairs(EC_DailyType) do
        if v == levelCfg.levelGroupId then
            isDaily = true
            break
        end
    end
    local isReach = false
    if levelInfo and (not isDaily or isReal) then
        local goals = levelInfo.goals or {}
        local index = table.indexOf(goals, pos)
        isReach = (index ~= -1)
    end
    return isReach
end

function FubenDataMgr:cacheSelectChapter(chapterCid)
    UserDefault:setStringForKey(self.KEY_FUBEN_SELECT_CHAPTER, tostring(chapterCid))
    self.selectChapter_ = chapterCid
end

function FubenDataMgr:getCacheSelectChapter()
    if not self.selectChapter_ then
        local selectChapter = UserDefault:getStringForKey(self.KEY_FUBEN_SELECT_CHAPTER)
        if selectChapter and #selectChapter > 0 then
            self.selectChapter_ = tonumber(selectChapter)
        end
    end
    return self.selectChapter_
end

function FubenDataMgr:cacheSelectLevel(levelCid)
    self.selectLevel_ = levelCid
end

function FubenDataMgr:getCacheSelectLevel()
    return self.selectLevel_
end

function FubenDataMgr:cacheSelectDiff(diff)
    UserDefault:setStringForKey(self.KEY_FUBEN_SELECT_DIFF, tostring(diff))
end

function FubenDataMgr:getCacheSelectDiff()
    local diff = UserDefault:getStringForKey(self.KEY_FUBEN_SELECT_DIFF)
    if diff and #diff > 0 then
        diff = tonumber(diff)
    else
        diff = nil
    end
    return diff
end

function FubenDataMgr:cacheSelectLevelGroup(levelGroupCid)
    UserDefault:setStringForKey(self.KEY_FUBEN_SELECT_LEVELGROUP, tostring(levelGroupCid))
    self.selectLevelGroup_ = levelGroupCid
end

function FubenDataMgr:getCacheSelectLevelGroup()
    if not self.selectLevelGroup_ then
        local selectLevelGroup = UserDefault:getStringForKey(self.KEY_FUBEN_SELECT_LEVELGROUP)
        if selectLevelGroup and #selectLevelGroup > 0 then
            self.selectLevelGroup_ = tonumber(selectLevelGroup)
        end
    end
    return self.selectLevelGroup_
end

function FubenDataMgr:cacheSelectFubenType(fubenType)
    UserDefault:setStringForKey(self.KEY_FUBEN_SELECT_FUBENTYPE, tostring(fubenType))
    self.selectFubenType_ = fubenType
end

function FubenDataMgr:getCacheSelectFubenType()
    if not self.selectFubenType_ then
        local selectFubenType = UserDefault:getStringForKey(self.KEY_FUBEN_SELECT_FUBENTYPE)
        if selectFubenType and #selectFubenType > 0 then
            self.selectFubenType_ = tonumber(selectFubenType)
        end
    end
    return self.selectFubenType_
end

function FubenDataMgr:getLevelGroupStarNum(levelGroupId, diff)
    local fightStarNum = 0
    local datingStarNum = 0
    local levelGroupCfg = self:getLevelGroupCfg(levelGroupId)
    for k, v in pairs(self.levelInfo_) do
        local levelCfg = self:getLevelCfg(k)
        if levelCfg and levelCfg.difficulty == diff and levelCfg.levelGroupId == levelGroupId and v.win and v.goals then
            if levelCfg.dungeonType == EC_FBLevelType.FIGHTING or levelCfg.dungeonType == EC_FBLevelType.THEATER_FIGHTING
                    or levelCfg.dungeonType == EC_FBLevelType.KUANGSAN_FIGHTING or levelCfg.dungeonType == EC_FBLevelType.HWX then
                fightStarNum = fightStarNum + self:getStarNum(k)
            else
                datingStarNum = datingStarNum + self:getStarNum(k)
            end
        end
    end
    return fightStarNum, datingStarNum
end

function FubenDataMgr:getLevelGroupTotalStarNum(levelGroupCid, diff)
    local level = self:getLevel(levelGroupCid, diff)
    local fightStarNum = 0
    local datingStarNum = 0
    for i, v in ipairs(level) do
        local levelCfg = self:getLevelCfg(v)
        if levelCfg.dungeonType == EC_FBLevelType.FIGHTING or levelCfg.dungeonType == EC_FBLevelType.THEATER_FIGHTING
                or levelCfg.dungeonType == EC_FBLevelType.KUANGSAN_FIGHTING or levelCfg.dungeonType == EC_FBLevelType.HWX then
            fightStarNum = fightStarNum + math.min(maxStarLimit,#levelCfg.starType)
        else
            -- local datingRuleCid = levelCfg.datingID[#levelCfg.datingID]
            -- if datingRuleCid then
            --     local datingRuleCfg = TabDataMgr:getData("DatingRule", datingRuleCid)
            --     datingStarNum = datingStarNum + #datingRuleCfg.dungeonDateHeart
            -- end
        end
    end
    return fightStarNum, datingStarNum
end

function FubenDataMgr:getChapterTotalStarNum(chapterCid, diff)
    local levelGroup = self:getLevelGroup(chapterCid)
    local fightStarNum = 0
    local datingStarNum = 0
    for i, v in ipairs(levelGroup) do
        local foo, bar = self:getLevelGroupTotalStarNum(v, diff)
        fightStarNum = fightStarNum + foo
        datingStarNum = datingStarNum + bar
    end
    return fightStarNum, datingStarNum
end

function FubenDataMgr:getChapterStarNum(chapterCid, diff)
    local levelGroup = self:getLevelGroup(chapterCid)
    local fightStarNum = 0
    local datingStarNum = 0
    for i, v in ipairs(levelGroup) do
        local foo, bar = self:getLevelGroupStarNum(v, diff)
        fightStarNum = fightStarNum + foo
        datingStarNum = datingStarNum + bar
    end
    return fightStarNum, datingStarNum
end

function FubenDataMgr:getChapterGroupLevelPassNum(levelGroupId, diff)
    local passNum = 0
    local totalNum = 0
    local levelGroupCfg = self:getLevelGroupCfg(levelGroupId)
    local allLevel = self:getLevel(levelGroupId, diff)
    for k, v in pairs(self.levelInfo_) do
        local levelCfg = self:getLevelCfg(k)
        if levelCfg and levelCfg.difficulty == diff and levelCfg.levelGroupId == levelGroupId then
            if v.win and v.goals then
                passNum = passNum + 1
            end
        end
    end
    totalNum = #allLevel
    return passNum, totalNum
end

function FubenDataMgr:getChapterPassLevelNum(chapterCid, diff)
    local levelGroup = self:getLevelGroup(chapterCid)
    local passNum = 0
    local totalNum = 0
    for i, v in ipairs(levelGroup) do
        local foo, bar = self:getChapterGroupLevelPassNum(v, diff)
        passNum = passNum + foo
        totalNum = totalNum + bar
    end
    return passNum, totalNum
end

function FubenDataMgr:canGetLevelGroupStarReward(levelGroupId, diff, id)
    local levelGroupCfg = self:getLevelGroupCfg(levelGroupId)
    local cond = levelGroupCfg.reward[diff][id].cond
    local fightStarNum, datingStarNum = self:getChapterStarNum(levelGroupCfg.dungeonChapterId, diff)
    return fightStarNum >= cond[1] and datingStarNum >= cond[2]
end

function FubenDataMgr:checkChapterStarRewardCanReceive(chapterCid, diff)
    local levelGroup = self:getLevelGroup(chapterCid)
    local levelGroupCid = levelGroup[1]
    local levelGroupCfg = self:getLevelGroupCfg(levelGroupCid)
    local diffReward = levelGroupCfg.reward[diff] or {}
    local stars = table.keys(diffReward)
    local canReceive = false
    local isReceiveAll = true
    for i, v in ipairs(stars) do
        local isGet = self:checkLevelGroupStarRewardIsGet(levelGroupCid, diff, v)
        local isReach = self:canGetLevelGroupStarReward(levelGroupCid, diff, v)
        if not isGet then
            if isReach then
                canReceive = true
            else
                isReceiveAll = false
            end
        end
    end
    return canReceive, isReceiveAll
end

function FubenDataMgr:checkLevelGroupStarRewardIsGet(levelGroupId, diff, id)
    local levelGroupInfo = self:getLevelGroupInfo(levelGroupId)
    local isGet = false
    if levelGroupInfo and levelGroupInfo.rewardInfo then
        local rewardInfo = levelGroupInfo.rewardInfo[diff]
        if rewardInfo then
            local index = table.indexOf(rewardInfo, id)
            isGet = (index ~= -1)
        end
    end
    return isGet
end

function FubenDataMgr:getDailyIsOpen(levelGroupCid)
    local addhours = Utils:getKVP(15001, "time")
    local levelCfg = self:getLevelGroupCfg(levelGroupCid)
    local date = os.date("*t" , ServerDataMgr:customUtcTimeForServerTimestap() - addhours * 3600 )
    local weekday = date.wday
    local index = table.indexOf(levelCfg.timeFrame, weekday)
    isOpen = index ~= -1
    return isOpen
end

function FubenDataMgr:getSpriteChallengeIsOpen()
    local isOpen = false
    if self.spriteChallengeInfo_ and self.spriteChallengeInfo_.levels then
        isOpen = (#self.spriteChallengeInfo_.levels > 0)
    end
    return isOpen
end

function FubenDataMgr:getDailyOpenTime(levelGroupCid)
    local addhours = Utils:getKVP(15001, "time")
    local levelGroupCfg = self:getLevelGroupCfg(levelGroupCid)
    local date = os.date("*t" , ServerDataMgr:customUtcTimeForServerTimestap()  - addhours * 3600 )
    local weekday = date.wday
    local openWeekday = clone(levelGroupCfg.timeFrame) or {}
    table.sort(openWeekday)
    local year, month, day = date.year , date.month , date.day
    local index = table.indexOf(openWeekday, weekday)
    local endDate
    if index == -1 then
        local addDays = 1
        local day = weekday
        local i = 1
        while true do
            day = day + 1
            if day > 7 then
                day = 1
            end
            if table.indexOf(openWeekday, day) == -1 then
                addDays = addDays + 1
            else
                break
            end
        end
        endDate = 24*addDays * 3600 - date.hour * 3600 - date.min * 60 - date.sec
    else
        endDate = 24* 3600 - date.hour * 3600 - date.min * 60 - date.sec
    end
    local timestamp = endDate
    return timestamp
end

function FubenDataMgr:getDailyExpirationTime(levelGroupCid)
    local addhours = Utils:getKVP(15001, "time")
    local levelGroupCfg = self:getLevelGroupCfg(levelGroupCid)
    local date = os.date("*t" , ServerDataMgr:customUtcTimeForServerTimestap()  - addhours * 3600 )
    local weekday = date.wday
    local openWeekday = clone(levelGroupCfg.timeFrame) or {}
    table.sort(openWeekday)
    local index = table.indexOf(openWeekday, weekday)
    local endDate
     if index ~= -1 then
        local addDays = 1
        local day = weekday
        local i = index
        while true do
            day = day + 1
            i = i + 1
            if day > 7 then
                day = 1
                i = 1
            end
            if day == openWeekday[i] then
                addDays = addDays + 1
            else
                break
            end
        end
        endDate = 24*addDays * 3600 - date.hour * 3600 - date.min * 60 - date.sec
    else
        endDate = 24* 3600 - date.hour * 3600 - date.min * 60 - date.sec
    end
    local timestamp = endDate
    return timestamp
end

function FubenDataMgr:getPlotLevelRemainFightCount(levelCid)
    local levelCfg = self:getLevelCfg(levelCid) 
    local levelInfo = self:getLevelInfo(levelCid)
    local remainCount = levelCfg.fightCount 
    if levelInfo and levelInfo.fightCount then
        local freeHadFightNum = levelInfo.freeCount or 0
        local buyCount = levelInfo.buyCount or 0
        remainCount = levelCfg.fightCount + buyCount - levelInfo.fightCount - freeHadFightNum 
    end
    remainCount = remainCount + self:getFreePrivilegeNumById(levelCid)
    remainCount = math.max(0, remainCount)
    return remainCount
end

function FubenDataMgr:getDailyRemainFightCount(levelGroupId)
    local levelGroupInfo = self:getLevelGroupInfo(levelGroupId)
    local levelGroupCfg = self:getLevelGroupCfg(levelGroupId)
    local remainCount = levelGroupCfg.countLimit
    if levelGroupInfo and levelGroupInfo.fightCount then
        local buyCount = levelGroupInfo.buyCount or 0
        remainCount = math.max(0, levelGroupCfg.countLimit + buyCount - levelGroupInfo.fightCount)
    end
    return remainCount
end

function FubenDataMgr:getDailyRemainBuyCount(levelGroupId)
    local levelGroupInfo = self:getLevelGroupInfo(levelGroupId)
    local levelGroupCfg = self:getLevelGroupCfg(levelGroupId)
    local remainCount = levelGroupCfg.buyCountLimit
    if levelGroupInfo and levelGroupInfo.buyCount then
        remainCount = math.max(0, levelGroupCfg.buyCountLimit - levelGroupInfo.buyCount)
    end
    return remainCount
end

function FubenDataMgr:getPlotLevelRemainBuyCount(levelCid)
    local levelCfg = self:getLevelCfg(levelCid)
    local levelInfo = self:getLevelInfo(levelCid)
    local remainCount = levelCfg.buyLimit
    if levelInfo and levelInfo.buyCount then
        remainCount = math.max(0, levelCfg.buyLimit - levelInfo.buyCount)
    end
    return remainCount
end

function FubenDataMgr:getActivityState(chapterCid)
    local state, stateStrCid
    if chapterCid == 401 then
        local endlessInfo = self:getEndlessInfo()
        state = endlessInfo.step
        stateStrCid = EC_EndlessStateStr[state]
    elseif chapterCid == 402 then
        state = true
        isopen = TeamFightDataMgr:isTeamFubenOpenning()
        if isopen == true then
            stateStrCid = 2100020
        else
            stateStrCid = 2100019
        end
    end
    return state, stateStrCid
end

function FubenDataMgr:openChapter(chapterCid)
    if not chapterCid then return end

    local chapterCfg = self:getChapterCfg(chapterCid)
    if chapterCfg.unlockLevel <= MainPlayer:getPlayerLv() then
        if chapterCid == 401 then
            Utils:openView("fuben.FubenActivityView", chapterCid)
        elseif chapterCid == 402 then
            if TeamFightDataMgr:openTeamGroupSelView(chapterCid) == false then
                local view = AlertManager:getLayer(-1)
                if view and view.__cname == "FubenChapterView" then
                else
                    Utils:openView("fuben.FubenChapterView")
                end
            end
        else
            Utils:openView("fuben.FubenLevelView", chapterCid)
        end
    else
        Utils:showTips(202016, chapterCfg.unlockLevel)
    end
end

function FubenDataMgr:openFuben()
    AlertManager:closeAll()
    Utils:openView("fuben.FubenChapterView")
    if self.selectFubenType_ then
        if self.selectFubenType_ == EC_FBType.PLOT then
            if self.selectChapter_ and self.selectLevel_ then
                Utils:openView("fuben.FubenLevelView", self.selectChapter_, self.selectLevel_)
            end
        elseif self.selectFubenType_ == EC_FBType.ACTIVITY then
            if self.selectChapter_ == EC_ActivityFubenType.ENDLESS then
                local endlessInfo = self:getEndlessInfo()
                if endlessInfo.step == EC_EndlessState.ING then
                    Utils:openView("fuben.FubenEndlessView", self.selectChapter_)
                elseif endlessInfo.step == EC_EndlessState.CLEARING then
                    Utils:showTips(300877)
                end
            elseif self.selectChapter_ == EC_ActivityFubenType.TEAM then
                TeamFightDataMgr:openTeamGroupSelView(self.selectChapter_)
            elseif self.selectChapter_ == EC_ActivityFubenType.SPRITE then
                if self:getSpriteChallengeIsOpen() then
                    Utils:openView("fuben.FubenSpriteView", self.selectChapter_)
                end
            elseif self.selectChapter_ == EC_ActivityFubenType.KABALA then
                Utils:openView("kabalaTree.KabalaTreeMainView")
                local curWorldId = KabalaTreeDataMgr:getCurWorldId()
                if curWorldId then
                    Utils:openView("kabalaTree.KabalaTreeExploreView",curWorldId)
                end
            elseif self.selectChapter_ == EC_ActivityFubenType.SPRITE_EXTRA then
                local funcIsOpen = FunctionDataMgr:checkFuncOpen(59)
                if funcIsOpen then
                    if self:getSpriteExtraIsOpen() then
                        --精灵模拟试练
                        Utils:openView("fuben.FubenSpriteExtraView", self.selectChapter_)
                    end
                end
            end
        elseif self.selectFubenType_ == EC_FBType.DAILY then
            Utils:openView("fuben.FubenDailyView", self.selectLevelGroup_)
        elseif self.selectFubenType_ == EC_FBType.HOLIDAY then
            if self.selectChapter_ == EC_ActivityFubenType.HALLOWEEN then
                Utils:openView("fuben.FubenHalloweenView", self.selectChapter_)
            elseif self.selectChapter_ == EC_ActivityFubenType.CHRISTMAS then
                AgoraDataMgr:openAgoraMain()
            end
        elseif self.selectFubenType_ == EC_FBType.THEATER then
            Utils:openView("fuben.FubenTheaterLevelView", self.selectChapter_, self.selectLevel_,self.extraChapterId_)
        elseif self.selectFubenType_ == EC_FBType.LINKAGE then
            Utils:openView("linkage.LinkageView",self.selectChapter_) 
        end
    end
end

function FubenDataMgr:getUnlockNextChapterCid()
    return self.unlockNextChapterCid_
end

function FubenDataMgr:setUnlockNextChapterCid(chapterCid)
    self.unlockNextChapterCid_ = chapterCid
end

function FubenDataMgr:getEndlessInfo()
    return self.endlessInfo_
end

function FubenDataMgr:getEndlessHeroHpPercent(heroCid)
    local percent = 10000
    local heroHealth = self.endlessInfo_.heroHealth
    if heroHealth and heroHealth.heroHealth then
        for i, v in ipairs(heroHealth.heroHealth) do
            if v.heroCid == heroCid then
                percent = v.health
                break
            end
        end
    end
    return percent
end

function FubenDataMgr:getEndlessCloisterLevel(weekNum)
    return self.endlessCloisterLevel_[weekNum]
end

function FubenDataMgr:getEndlessCloisterLevelCfg(cid)
    return self.endlessCloisterLevelMap_[cid]
end

function FubenDataMgr:getEndlessMaxLevel()
    local maxLevel = Utils:getKVP(11002, "maxLevel")
    return maxLevel
end

function FubenDataMgr:getEndlessNormalMaxLevel()
    local normalMaxLevel = Utils:getKVP(11002, "normalLevel")
    return normalMaxLevel
end

function FubenDataMgr:isEndlessRacingMode(levelCid)
    local endlessCfg = self:getEndlessCloisterLevelCfg(levelCid)
    local normalMaxLevel = self:getEndlessNormalMaxLevel()
    return endlessCfg.order > normalMaxLevel
end

function FubenDataMgr:isEndlessSkipLevel(levelCid)
    local endlessCfg = self:getEndlessCloisterLevelCfg(levelCid)
    local skipLevelInfo = Utils:getKVP(11002, "skipLevel")

    if not skipLevelInfo or not endlessCfg then
        return false
    end

    if not endlessCfg.order then
        return false
    end

    return endlessCfg.order >= skipLevelInfo[1] and endlessCfg.order <= skipLevelInfo[2]
end

function FubenDataMgr:getStarNum(levelCid)
    local starNum = 0
    local levelInfo = self:getLevelInfo(levelCid)
    if levelInfo then
        for i = 1,maxStarLimit do
            levelInfo.goals = levelInfo.goals or {}
            if table.indexOf(levelInfo.goals,i) ~= -1 then
                starNum = starNum + 1
            end
        end
    end
    return starNum
end

function FubenDataMgr:getLevelFormation(levelCid)
    return self.levelFormation_[levelCid]
end

function FubenDataMgr:resetLevelFormation(levelCid)
    self.levelFormation_[levelCid] = clone(self.originLevelFormation_[levelCid])
end

function FubenDataMgr:addLevelFormation(levelCid, pid)
    local stance = self.levelFormation_[levelCid].stance
    table.insert(stance, tostring(pid))
end

function FubenDataMgr:removeLevelFormation(levelCid, pid)
    local stance = self.levelFormation_[levelCid].stance
    for i, v in ipairs(stance) do
        if v == tostring(pid) then
            table.remove(stance, i)
            break
        end
    end
end

function FubenDataMgr:casLevelFormation(levelCid, oldPid, newPid)
    local stance = self.levelFormation_[levelCid].stance
    for i, v in ipairs(stance) do
        if v == tostring(oldPid) then
            stance[i] = tostring(newPid)
            break
        end
    end
end

function FubenDataMgr:moveLevelFormation(levelCid, formIndex, toIndex)
    local stance = self.levelFormation_[levelCid].stance
    stance[formIndex], stance[toIndex] = stance[toIndex], stance[formIndex]
end

function FubenDataMgr:getLimitHero(limitHeroCid)
    return self.limitHeros_[limitHeroCid]
end

function FubenDataMgr:getAssistHero()
    local hero
    for i = #self.assistantData_, 1, -1 do
        hero = self.assistantData_[i]
        if FriendDataMgr:isFriend(hero.pid) then
            table.remove(self.assistantData_, i)
            hero = nil
        else
            break
        end
    end
    return hero
end

function FubenDataMgr:popAssistHero(pid)
    for i = #self.assistantData_, 1, -1 do
        local hero = self.assistantData_[i]
        if hero.pid == pid then
            table.remove(self.assistantData_, i)
            break
        end
    end
end

function FubenDataMgr:getCurLevelCid()
    return self.curLevelCid_
end

function FubenDataMgr:setFormation(formation)
    self.formation_ = formation
end

function FubenDataMgr:cachePlayerInfo()
    self.playerInfo_ = {
        level = MainPlayer:getPlayerLv(),
        exp = MainPlayer:getPlayerExp(),
        percent = MainPlayer:getExpProgress(),
    }
end

function FubenDataMgr:cacheExtraChapterId( extraChapterId )
    self.extraChapterId_ = extraChapterId
end

function FubenDataMgr:getCachePlayerInfo()
    return self.playerInfo_
end

function FubenDataMgr:getFormation()
    return self.formation_
end

function FubenDataMgr:getFubenType(levelCid)
    local levelCfg = self:getLevelCfg(levelCid)
    local levelGroupCfg = self:getLevelGroupCfg(levelCfg.levelGroupId)
    local chapterCfg = self:getChapterCfg(levelGroupCfg.dungeonChapterId)
    return chapterCfg.type
end

function FubenDataMgr:getEndlessJumpLevel(sec)
    local jumpLevelCfg = Utils:getKVP(11001, "skipLevels")
    local jumpLevel = 0
    for i, v in ipairs(jumpLevelCfg) do
        if sec >= v.min and sec <= v.max then
            jumpLevel = v.level
            break
        end
    end
    return jumpLevel
end

function FubenDataMgr:getLevelGroupServerId(levelGroupCid, diff)
    local level = self:getLevel(levelGroupCid, diff)
    local levelGroupServerID
    for i, v in ipairs(level) do
        local levelCfg = self:getLevelCfg(v)
        levelGroupServerID = levelCfg.levelGroupServerID
        if levelGroupServerID then
            break
        end
    end
    return levelGroupServerID
end

function FubenDataMgr:getDailyMultiple(levelGroupCid)
    local info = self.dailyMultipleInfo_[levelGroupCid]
    local multiple = 1
    if info then
        multiple = tonumber(info.multiple)
    end
    return multiple
end

function FubenDataMgr:makeFormationData(heroData, type_, id)
    return {
        data = clone(heroData),
        type = type_,
        id = id,
    }
end

function FubenDataMgr:enterFirstPlotLevel()
    local chapter = self:getChapter(EC_FBType.PLOT)
    local firstLevelCid = self:getChapterFirstLevel(chapter[1], EC_FBDiff.SIMPLE)
    firstLevelCid = 101101
    if not self:isPassPlotLevel(firstLevelCid) then
        if self:getLimitHero(1000) and not self.isEntry then
            self.isEntry = true
            local levelCfg = self:getLevelCfg(firstLevelCid)
            local levelGroupCfg = self:getLevelGroupCfg(levelCfg.levelGroupId)
            local chapterCfg = self:getChapterCfg(levelGroupCfg.dungeonChapterId)
            self:cacheSelectFubenType(chapterCfg.type)
            self:cacheSelectChapter(levelGroupCfg.dungeonChapterId)
            self:cacheSelectLevel(firstLevelCid)
            local formationData = self:getInitFormation(firstLevelCid)
            HeroDataMgr:changeDataByFuben(firstLevelCid, formationData)
            local heros = {}
            for i, v in ipairs(formationData) do
                table.insert(heros, {v.type, v.id})
            end
            local battleController = require("lua.logic.battle.BattleController")
            battleController.requestFightStart(firstLevelCid, 0, 0, heros, 0, false)
        else
            TFDirector:send(c2s.DUNGEON_LIMIT_HERO_DUNGEON, {firstLevelCid})
        end
        return true
    end
    return false
end

--返回角色额外的skinIDs[灵装试用功能]
local function availableSkinIDS(heroCid)
    local _cfgs = TabDataMgr:getData("TrialHeroSkin")
    local skinIds = {}
    for k,v in pairs(_cfgs) do
        if v.fitting and v.matchHero == heroCid then
            table.insert(skinIds,v.id)
        end
    end
    return skinIds
end
--转换SkinCid
local function tansSkinCid( skinCid )
    local _cfgs = TabDataMgr:getData("TrialHeroSkin")
    for k,v in pairs(_cfgs) do
        if v.matchSkin == skinCid or v.id == skinCid then
            return v.id
        end
    end
    Box("not exist TrialHeroSkin skinCid:" ..tostring(skinCid))
end
function FubenDataMgr:enterPracticeLevel(heroCid,skinCid)
    local checkExtId = TFAssetsManager:getCheckInfo(5,nil)
    if checkExtId then
        TFAssetsManager:downloadAssetsOfFunc(checkExtId,function()
            local formationData = self:getFormationByHero(heroCid)
            local heros = {}
            for i, v in ipairs(formationData) do
                skinCid = skinCid or v.data.skinCid
                skinCid = tansSkinCid(skinCid)
                local skinIds = availableSkinIDS(v.data.cid)
                for i, skinId in ipairs(skinIds) do
                    if skinId == skinCid then 
                        table.insert(heros, 1 ,{limitType = v.type, limitCid = v.id, skinCid = skinId})
                    else
                        table.insert(heros, {limitType = v.type, limitCid = v.id, skinCid = skinId})
                    end
                end
            end
            self:setFormation(formationData)
            local battleController = require("lua.logic.battle.BattleController")
            battleController.enterBattle(
                {
                    levelCid = 102,
                    limitHeros = heros,
                    isDuelMod = false,
                },
                EC_BattleType.COMMON
            )
        end,true)
    end  
end


--data 参数 id,eventid,levelCid
function FubenDataMgr:enterMusicGameLevel(data)
    if data then
        if self.requestLimitInfo then
            return
        end
        self.musicLevelData = data
        self.requestLimitInfo = true
        self:send_DUNGEON_LIMIT_HERO_DUNGEON(data.levelCid)
    else
        self.requestLimitInfo = false
        local checkExtId = TFAssetsManager:getCheckInfo(5,nil)
        if checkExtId then
            TFAssetsManager:downloadAssetsOfFunc(checkExtId,function()
                local formationData = self:getInitFormation(self.musicLevelData.levelCid)
                HeroDataMgr:changeDataByFuben(self.musicLevelData.levelCid, formationData)
                local heros = {}
                for i, v in ipairs(formationData) do
                    table.insert(heros, {limitType = v.type, limitCid = v.id, skinCid = v.data.skinCid})
                end
                self:setFormation(formationData)
                self:cachePlayerInfo()
                local battleController = require("lua.logic.battle.BattleController")
                battleController.enterBattle(
                    {
                        levelCid = self.musicLevelData.levelCid,
                        limitHeros = heros,
                        isDuelMod = false,
                    },
                    EC_BattleType.COMMON
                )
            end,true)
        end  
    end
end

function FubenDataMgr:getMusicGameLevelData()
    return self.musicLevelData
end

function FubenDataMgr:getInitFormation(levelCid)

    local isLimitHero = false
    local isDisableHero = false
    local isLimitSimulationTrialHero = false
    local isContainSimulationTrial = false
    if levelCid then
        local levelCfg = self:getLevelCfg(levelCid)
        local type_ = levelCfg.heroLimitType
        isLimitHero = (type_ == EC_LimitHeroType.LIMIT_NJ or type_ == EC_LimitHeroType.LIMIT_J)
        isDisableHero = (type_ == EC_LimitHeroType.DISABLE)
        isLimitSimulationTrialHero = (type_ ==  EC_LimitHeroType.SIMULATION_TRIAL_LOCK or type_ ==  EC_LimitHeroType.SIMULATION_TRIAL)    -- 限定 试炼精灵
        --是否包含试炼精灵
        isContainSimulationTrial = tobool(levelCfg.limitDungeon == 1)
    end
    local formationData = {}
    if isLimitHero then
        local levelCfg = self:getLevelCfg(levelCid)
        for i, v in ipairs(levelCfg.heroLimitID) do
            local heroData = self:getLimitHero(v)
            table.insert(formationData, self:makeFormationData(heroData, EC_BattleHeroType.LIMIT, v))
        end
    elseif isLimitSimulationTrialHero then
        local levelCfg = self:getLevelCfg(levelCid)
        for i, v in ipairs(levelCfg.heroLimitID) do
            local heroData = HeroDataMgr:getHero(v)
            heroData.isLimitHero = true
            table.insert(formationData, self:makeFormationData(heroData, EC_BattleHeroType.SIMULATION, v))
        end
    else
        for i = 1, 3 do
            local isOn = HeroDataMgr:getIsFormationOn(i)
            if isOn then
                local id = HeroDataMgr:getHeroIdByFormationPos(i)
                local heroData = HeroDataMgr:getHero(id)
                if isDisableHero then
                    local levelCfg = self:getLevelCfg(levelCid)
                    if table.indexOf(levelCfg.heroForbiddenID, heroData.cid) == -1 then
                        table.insert(formationData, self:makeFormationData(heroData, EC_BattleHeroType.OWN, heroData.cid))
                    end
                else
                    if isContainSimulationTrial or heroData.heroStatus ~= 3 then 
                        table.insert(formationData, self:makeFormationData(heroData, EC_BattleHeroType.OWN, heroData.cid))
                    else
                        HeroDataMgr:heroOnBattle(heroData.id) --不能包含试炼精灵的战斗把试炼精灵下阵处理
                    end
                end
            end
        end
    end
    return formationData
end

function FubenDataMgr:getFormationByHero(heroCid)
    local formationData = {}
    local heroData = clone(HeroDataMgr:getHero(heroCid))
    table.insert(formationData, self:makeFormationData(heroData, EC_BattleHeroType.OWN, heroData.cid))
    return formationData
end

function FubenDataMgr:getSpriteChallengeInfo()
    return self.spriteChallengeInfo_
end

function FubenDataMgr:getCurSpriteLevelCid()
    local levelCid
    local index
    if self.spriteChallengeInfo_ and self.spriteChallengeInfo_.levels then
        for i, v in ipairs(self.spriteChallengeInfo_.levels) do
            if v.status == 0 then    -- 未通过
                levelCid = v.levelCid
                index = i
                break
            end
            if i == #self.spriteChallengeInfo_.levels and not levelCid then
                levelCid = v.levelCid
                index = i
            end
        end
    end
    local index = math.mod(index, 3)
    index = (index == 0) and 3 or index

    return levelCid, index
end

function FubenDataMgr:getCurSpritePassIndex()
    local index = 1
    if self.spriteChallengeInfo_ and self.spriteChallengeInfo_.levels then
        for i, v in ipairs(self.spriteChallengeInfo_.levels) do
            if v.status == 1 then
                index = math.max(index, i)
            end
        end
    end
    index = math.min(index, 3)
    return index
end

function FubenDataMgr:getSpriteChallengeCfg(levelCid)
    return self.challengeDungen_[levelCid]
end

function FubenDataMgr:getSpriteChallengeRemainCount()
    local count = self:getSpriteChallengeTotalCount()
    if count and self.spriteChallengeInfo_.count then
        return count - self.spriteChallengeInfo_.count
    end
    return 0
end

function FubenDataMgr:getSpriteChallengeTotalCount()
    local count = Utils:getKVP(24001, "time")
    return count
end

function FubenDataMgr:getSpriteReward(playerLevel)
    playerLevel = playerLevel or MainPlayer:getPlayerLv()
    local challengeRandomMap = TabDataMgr:getData("ChallengeRandom")
    local reward = {}
    local realDropCid = nil
    for i = #challengeRandomMap, 1, -1 do
        local challengeRandom = challengeRandomMap[i]
        local level = challengeRandom.level
        if playerLevel >= level[1] and playerLevel <= level[2] then
            reward = challengeRandom.dropShow
            realDropCid = challengeRandom.reaward
            break
        end
    end
    return reward, realDropCid
end

function FubenDataMgr:setCurLevelCid(levelCid)
    self.curLevelCid_ = levelCid
end
-------------------------新模拟试炼-----------------------------
--请求模拟试炼的信息
-- function FubenDataMgr:reqSimulationTrialInfo()
--     TFDirector:send(c2s.HERO_REQ_SIMULATE_TRAIN_INFO,{}) 
-- end


-- 请求第一章任务
function FubenDataMgr:send_HERO_REQ_COMPLETE_STTASK(id)
    TFDirector:send(c2s.HERO_REQ_COMPLETE_STTASK,{id}) 
end

--检查关卡的开启状态（模拟试炼第二章用）
function FubenDataMgr:checkPlotLevelEnabled_SimulationTrial(levelCid,heroId)
    local enabled, preIsOpen, levelIsOpen = FubenDataMgr:checkPlotLevelEnabled(levelCid)
    local openDeungeons = self:getSimulationTrialHeroInfo(heroId).dungeonId or {}
    local timeOpen = false
    for i , v in ipairs(openDeungeons) do
        if v == timeOpen then 
            timeOpen = true
        end
    end 
    return enabled, preIsOpen, levelIsOpen ,timeOpen
end
function FubenDataMgr:onRevSTTaskChange(event)
    local data = event.data
    dump(event.data)
    if data.tasks then 
        for i, n_task in ipairs(data.tasks) do
            if self.simulationTrialInfo_.info then
                for i, heroInfo in ipairs(self.simulationTrialInfo_.info) do
                    for i, task in ipairs(heroInfo.tasks) do  --tasks_ 会同步更新
                        if task.id == n_task.id then 
                            task.status = n_task.status
                        end
                    end
                end
            end
        end
    end
    EventMgr:dispatchEvent(EV_SIMULATION_TRIAL_TASK_REWARD,data)
end
function FubenDataMgr:onRevCompleteSTTask(event)
    dump(event.data)
    local data = event.data
    if data.tasks then 
        for i, n_task in ipairs(data.tasks) do
            if self.simulationTrialInfo_.info then
                for i, heroInfo in ipairs(self.simulationTrialInfo_.info) do
                    for i, task in ipairs(heroInfo.tasks) do  --tasks_ 会同步更新
                        if task.id == n_task.id then 
                            task.status = n_task.status
                        end
                    end
                end
            end
        end
    end
    EventMgr:dispatchEvent(EV_SIMULATION_TRIAL_TASK_REWARD,data)

            -- {{true,{'rewards','id', 'num', }},{true,{'tasks','id', 'status',}},}

--[[
    [1] = {--ResCompleteSTTask
        [1] = {--repeated RewardsMsg
            [1] = 'int32':id
            [2] = 'int32':num
        },
        [2] = {--repeated SimulateTrainTask
            [1] = 'int32':id    [ 任务id]
            [2] = {--STTaskStaus(enum)
                'v4':STTaskStaus
            },
        },
    }
--]]
end


function FubenDataMgr:onRevSimulationTrialInfo(event)
    local data = event.data
    if not data then return end
    self.simulationTrialInfo_       = data
    self.simulationTrialInfo_.info  = self.simulationTrialInfo_.info or {}
    self.simulationTrialInfo_.info_ = {}
    for i, heroInfo in ipairs(self.simulationTrialInfo_.info) do
        self.simulationTrialInfo_.info_[heroInfo.heroId] = heroInfo
        --任务预处理分类
        heroInfo.tasks = heroInfo.tasks or {} 
        local tasks  = {}
        for i,task in ipairs(heroInfo.tasks) do
            local missionType  = TabDataMgr:getData("HerotestMission",task.id).missionType 
            tasks[missionType] = tasks[missionType] or {}
            table.insert(tasks[missionType],task) 
        end
        heroInfo.tasks_ = tasks
    end
    -- dump(self.simulationTrialInfo_)
    --活动关闭移除缓存的界面
    if not self.simulationTrialInfo_.isOpen then
        AlertManager:removeMainSceneLayerParamsCache("SimulationTrialMainView")
        AlertManager:removeMainSceneLayerParamsCache("SimulationTrialLevelView")
        AlertManager:removeMainSceneLayerParamsCache("SimulationTrialRewardPreview")
        AlertManager:removeMainSceneLayerParamsCache("SimulationTrialReward")
    end
    --数据更新
    EventMgr:dispatchEvent(EV_SIMULATION_TRIAL_UPDATE)
end


function FubenDataMgr:checkSimulationTrialLevelEnabled(levelCid,heroId)
    local enabled, preIsOpen, levelIsOpen = self:checkPlotLevelEnabled(levelCid)
    local heroInfo = self:getSimulationTrialHeroInfo(heroId)
    
    local timeOpen = false
    if heroInfo then
        local openDungeons = heroInfo.dungeonId
        if openDungeons then 
            for i,v in ipairs(openDungeons) do
                if levelCid == v then
                    timeOpen = true
                end
            end
        end
    else
        printError("找不到配置:%s", heroId)
    end
    enabled = enabled and timeOpen
    return enabled, preIsOpen, levelIsOpen ,timeOpen
end


--模拟试炼功能是否显示小红点
function FubenDataMgr:isVisiableSimulationTrialRedPoint(heroId)
    --有奖可以领
    --有关卡可打    
    if self.simulationTrialInfo_.isOpen then
        --第一章奖励
        local tasks = self.simulationTrialInfo_.tasks
        if tasks then 
            for i,v in ipairs(tasks) do
                if v.status == 2 then 
                    return true
                end
            end
        end
        --第二章奖励
        local isCanReceive, isReceiveAll = self:checkChapterStarRewardCanReceive(411, 1)
        if isCanReceive then 
            return true
        end

        local heroTestCfg = TabDataMgr:getData("HeroTest",heroId)
        -- 有关卡可以打
        for k,groupId in pairs(heroTestCfg.groupID) do
            local levels = self:getLevel(groupId)
            for i,v in ipairs(levels) do
                local enabled = self:checkSimulationTrialLevelEnabled(v,heroId)
                local pass    = self:isPassPlotLevel(v)
                if enabled and not pass then 
                    return true
                end
            end
        end
    end
end

function FubenDataMgr:getSimulationTrialIsOpen()
    return self.simulationTrialInfo_.isOpen
end

function FubenDataMgr:getSimulationTrialInfo()
    return self.simulationTrialInfo_
end
function FubenDataMgr:getSimulationTrialHeroInfo(heroId)
    if self.simulationTrialInfo_.info_[heroId] then
        return self.simulationTrialInfo_.info_[heroId]
    end
end
--成长奖励
function FubenDataMgr:getSimulationTrialReward()
    return self.simulationTrialReward
end

function FubenDataMgr:cleanSimulationTrialReward()
    self.simulationTrialReward = nil
end
--是否获得反折
function FubenDataMgr:hasFAN_ZHE(heroId)
    heroId = heroId or self:getSelectSimulationHeroId()
    local realHeroId = self:getSimulationTrialCfg(heroId).realHeroId
    return HeroDataMgr:getIsHave(realHeroId)
end

function FubenDataMgr:setSelectSimulationHeroId(heroId)
    self.simulationHeroId = heroId
end

function FubenDataMgr:getSelectSimulationHeroId()
    return self.simulationHeroId
end
--开启时间
function FubenDataMgr:getSimulationTrialActiveTime()
    if self.simulationTrialInfo_.startTime and self.simulationTrialInfo_.endTime then
        return self.simulationTrialInfo_.startTime , self.simulationTrialInfo_.endTime
    end
    local data = TabDataMgr:getData("DiscreteData",29002).data
    local startTime = Utils:getTimeByDate(data.startTime)
    local endTime   = Utils:getTimeByDate(data.endTime)
    return  startTime , startTime
end

-------------------------精灵模拟试练----------------------------
function FubenDataMgr:getSpriteExtraIsOpen()
    local isOpen = false
    if self.spriteExtraInfo_ then
        isOpen = self.spriteExtraInfo_.alwaysOpen or self.spriteExtraInfo_.status
    end
    return isOpen
end

function FubenDataMgr:getSpriteExtraInfo()
    return self.spriteExtraInfo_
end

function FubenDataMgr:getSpriteExtraLevelInfo(levelCid)
    return self.spriteExtraInfo_.levelInfos[levelCid] or {}
end

function FubenDataMgr:isSpriteExtraLevelPass(levelCid)
    local isPass = false
    local levelInfo = self.spriteExtraInfo_.levelInfos[levelCid]
    if levelInfo then
        isPass = levelInfo.win
    end
    return isPass
end

function FubenDataMgr:getSpriteExtraActiveTime()
    local starttime = self.spriteExtraInfo_.startTime
    local endtime = self.spriteExtraInfo_.endTime
    return starttime,endtime
end

function FubenDataMgr:getSpriteExtraActiveGroups()
    local groupInfo = {}
    for k,v in pairs(self.spriteExtraInfo_.levelsCfg) do
        if groupInfo[v.groupID] ==nil then
            groupInfo[v.groupID] = {unlock = false,levels = {}}
        end
        table.insert(groupInfo[v.groupID].levels,v)
        if v.opentype == 1 then
            groupInfo[v.groupID].unlock = true
        end
    end
    local groupList = {orderedkey = {},groupData = {}}
    for k,v in pairs(groupInfo) do
        if #v.levels >= 2 then
            table.sort( v.levels, function(ta,tb)
                return ta.order < tb.order
            end )
        end
        if v.unlock == true then
            table.insert(groupList.orderedkey,k)
        end
    end
    if #groupList.orderedkey >= 2 then
        table.sort(groupList.orderedkey, function(a,b)
            return a < b
        end )
    end
    for k,v in pairs(groupList.orderedkey) do
        groupList.groupData[v] = groupInfo[v]
    end
    return groupList
end

function FubenDataMgr:setSpriteExtraSelLevel(levelCid)
   self.spritExtraSelLevelCid = levelCid
end

function FubenDataMgr:getSpriteExtraSelLevel()
    return self.spritExtraSelLevelCid
end

function FubenDataMgr:getTheaterDungeonLevel(chapterCid)
    local levels = {}
    levels = self.storyDungeonLevel_[chapterCid]
    return levels
end

function FubenDataMgr:getTheaterDungeonLevelCfg(levelCid)
    return self.storyDungeonLevelMap_[levelCid]
end

function FubenDataMgr:getTheaterBossInfo()
    return self.theaterBossInfo_
end

function FubenDataMgr:checkTheaterBossOpened()
    if self.theaterBossInfo_ and self.theaterBossInfo_.status ~= EC_TheaterStatus.CLOSING then
        return true
    end
    return false
end

function FubenDataMgr:getTheaterDungeonLevelInfo(levelCid)
    local levelCfg = self:getTheaterDungeonLevelCfg(levelCid)
    local levelInfo
    if levelCfg.storydungeonType == EC_TheaterLevelType.OPTION then
        levelInfo = self.theaterDatingOptionInfo_[levelCid]
    else
        levelInfo = self:getLevelInfo(levelCid)
    end
    return levelInfo
end

function FubenDataMgr:judgeTheaterCondIsEstablish(levelCid, index, lock)
    local levelCfg = self:getTheaterDungeonLevelCfg(levelCid)
    local cond = levelCfg.unlock[index]

    if lock then
        cond = levelCfg.lock[index]
    end

    local isEstablish = self:condIsActivity(cond)
    if not cond and not lock then -- 锁定判断 默认为不成立
        isEstablish = true
    end
    return isEstablish
end

function FubenDataMgr:condIsActivity( cond )
    local isEstablish = false
    if cond then
        local predungeonIsUnlock = true
        if cond.predungeon then
            for i, v in ipairs(cond.predungeon) do
                if not self:isPassTheaterLevel(v) then
                    predungeonIsUnlock = false
                    break
                end
            end
        end

        local predatingIsUnlock = true
        if cond.predating then
            for i, v in ipairs(cond.predating) do
                if not self:isPassTheaterLevel(v) then
                    predatingIsUnlock = false
                    break
                end
            end
        end

        local predungeonIsNotPass = true
        if cond.notPass then
            for i, v in ipairs(cond.notPass) do
                if self:isPassTheaterLevel(v) then
                    predungeonIsNotPass = false
                    break
                end
            end
        end

        local predungeonResultPass = true
        if cond.predungeonResult then
            for i, v in ipairs(cond.predungeonResult) do
                if not self:judgeStarIsActive(v.id,v.star) then
                    predungeonResultPass = false
                    break
                end
            end
        end
        
        isEstablish = predungeonIsUnlock and predatingIsUnlock and predungeonIsNotPass and predungeonResultPass
    end
    return isEstablish
end

function FubenDataMgr:checkTheaterLevelEnabled(levelCid)
    local levelCfg = self:getTheaterDungeonLevelCfg(levelCid)
    local enabled = true
    for i, v in ipairs(levelCfg.unlock) do
        if self:judgeTheaterCondIsEstablish(levelCid, i) then
            enabled = true
            break
        else
            enabled = false
        end
    end
    return enabled
end

function FubenDataMgr:checkTheaterLevelLocked( levelCid )
    local levelCfg = self:getTheaterDungeonLevelCfg(levelCid)
    local lock = false
    for i, v in ipairs(levelCfg.lock) do
        if self:judgeTheaterCondIsEstablish(levelCid, i, true) then
            lock = true
            break
        else
            lock = false
        end
    end
    return lock
end

function FubenDataMgr:checkTheaterChapterEnabled(chapterCid)
    local levels = self:getTheaterDungeonLevel(chapterCid)
    local chapterCfg = self:getChapterCfg(chapterCid)
    local condEnabled = false
    for i, v in ipairs(levels or {}) do
        if self:checkTheaterLevelEnabled(v) then
            condEnabled = true
            break
        end
    end

    local serverTime = ServerDataMgr:getServerTime()
    local timeEnabled = serverTime >= chapterCfg.openTime2 / 1000
    if self.theaterBossInfo_.nodeStatus and serverTime >= chapterCfg.openTime / 1000 then
        local maxCfg = self.theaterBossInfo_.nodeStatus[#self.theaterBossInfo_.nodeStatus]
        local contributionEnabled = self.theaterBossInfo_.serverContribution >= maxCfg.contribution
        timeEnabled = timeEnabled or contributionEnabled
    end
    local levelEnabeld = MainPlayer:getPlayerLv() >= chapterCfg.unlockLevel
    local enabled = condEnabled and timeEnabled and levelEnabeld
    return enabled, condEnabled, timeEnabled, levelEnabeld
end

function FubenDataMgr:isPassTheaterLevel(levelCid)
    local levelCfg = self:getTheaterDungeonLevelCfg(levelCid)
    local isPass = false
    if levelCfg.storydungeonType == EC_TheaterLevelType.OPTION then
        local levelInfo = self:getTheaterDungeonLevelInfo(levelCid)
        isPass = tobool(levelInfo)
    elseif levelCfg.storydungeonType == EC_TheaterLevelType.CONDITION then
        local cond = levelCfg.unlock[1]
        if cond then
            isPass = self.theaterBossInfo_.lingbo >= cond.spirit
        else
            isPass = true
        end
    else
        isPass = self:isPassPlotLevel(levelCid)
    end
    return isPass
end

function FubenDataMgr:getTheaterGroupLevels(chapterCid)
    local groupLevels = self.storyGroupDungeonLevel_[chapterCid]
    return groupLevels
end

function FubenDataMgr:getTheaterDungeonLevelWeight(levelCid)
    local weight = self.theaterLevelWeight_[levelCid]
    return weight or 99999
end

function FubenDataMgr:setTheaterLevelAni(theaterId,index)
    self.theaterLevelAni_[theaterId.."-"..index] = true
end

function FubenDataMgr:getTheaterLevelAni(theaterId,index)
    if theaterId and index then
        return tobool(self.theaterLevelAni_[theaterId.."-"..index])
    else
        return self.theaterLevelAni_
    end
end

function FubenDataMgr:getTheaterChallengeInfo()
    return self.theaterNotice_
end

------------------------------------------------------------

function FubenDataMgr:send_PLAYER_REQ_HELP_FIGHT_PLAYERS()
    TFDirector:send(c2s.PLAYER_REQ_HELP_FIGHT_PLAYERS, {})
end

function FubenDataMgr:send_DUNGEON_GET_LEVEL_GROUP_REWARD(levelGroupId, diff, starNum)
    TFDirector:send(c2s.DUNGEON_GET_LEVEL_GROUP_REWARD, {levelGroupId, diff, starNum})
end

function FubenDataMgr:send_DUNGEON_BUY_FIGHT_COUNT(levelGroupId)
    TFDirector:send(c2s.DUNGEON_BUY_FIGHT_COUNT, {levelGroupId})
end

function FubenDataMgr:send_DUNGEON_FIGHT_START(levelId, assistantPlayerId, assistantHeroCid, limitHeros, quickCount, isDuelMod)
    TFDirector:send(c2s.DUNGEON_FIGHT_START, {levelId, assistantPlayerId, assistantHeroCid, limitHeros, quickCount, isDuelMod})
end

function FubenDataMgr:saveCurFightParam(...)
    self.saveFightParam = {...}
end

function FubenDataMgr:clearCurFightParam()
    self.saveFightParam = nil
end

function FubenDataMgr:getCurFightParam()
    return self.saveFightParam
end


function FubenDataMgr:send_DUNGEON_FIGHT_OVER(levelId, isWin, reachStar, maxComboNum, pickUpTypeCount, pickUpCount, killTargets, costTime, damage,rating ,skillEnemy)
    maxComboNum = maxComboNum or 0
    pickUpTypeCount = pickUpTypeCount or 0
    pickUpCount = pickUpCount or 0
    killTargets = killTargets or {}
    costTime = costTime or 0
    damage =damage or 0
    rating = rating or 0
    skillEnemy = skillEnemy or {}
    dump({levelId, isWin, reachStar, maxComboNum, pickUpTypeCount, pickUpCount, killTargets, costTime, damage,rating,skillEnemy})
    TFDirector:send(c2s.DUNGEON_FIGHT_OVER, {levelId, isWin, reachStar, maxComboNum, pickUpTypeCount, pickUpCount, killTargets, costTime, damage,rating,skillEnemy})
end

function FubenDataMgr:send_ENDLESS_CLOISTER_REQ_START_FIGHT_ENDLESS()
    TFDirector:send(c2s.ENDLESS_CLOISTER_REQ_START_FIGHT_ENDLESS, {})
end

function FubenDataMgr:send_ENDLESS_CLOISTER_REQ_PASS_STAGE_ENDLESS(stageId, costTime, health, isPass, maxComboNum, damage)
    TFDirector:send(c2s.ENDLESS_CLOISTER_REQ_PASS_STAGE_ENDLESS, {stageId, costTime, health, isPass, maxComboNum, damage})
end

function FubenDataMgr:send_DUNGEON_LIMIT_HERO_DUNGEON(levelCid)
    dump({"請求限定",levelCid})
    TFDirector:send(c2s.DUNGEON_LIMIT_HERO_DUNGEON, {levelCid})
end

function FubenDataMgr:send_DUNGEON_BUY_LEVEL_COUNT(levelCid)
    TFDirector:send(c2s.DUNGEON_BUY_LEVEL_COUNT, {levelCid})
end

function FubenDataMgr:send_HERO_CHALLENGE_REFRESH_BUFF()
    TFDirector:send(c2s.HERO_CHALLENGE_REFRESH_BUFF, {})
end

function FubenDataMgr:send_HERO_CHALLENGE_CHALLENGE_AWARD()
    TFDirector:send(c2s.HERO_CHALLENGE_CHALLENGE_AWARD, {})
end

function FubenDataMgr:send_ENDLESS_CLOISTER_REQ_ENDLESS_RANK_LIST()
    TFDirector:send(c2s.ENDLESS_CLOISTER_REQ_ENDLESS_RANK_LIST, {})
end

function FubenDataMgr:send_ENDLESS_CLOISTER_REQ_ENDLESS_BUFF(levelCid)
    TFDirector:send(c2s.ENDLESS_CLOISTER_REQ_ENDLESS_BUFF, {levelCid})
end

function FubenDataMgr:send_ENDLESS_CLOISTER_REQ_START_STAGE(isJump)
    TFDirector:send(c2s.ENDLESS_CLOISTER_REQ_START_STAGE, {isJump})
end

function FubenDataMgr:send_ODEUM_REQ_RANK(rankType)
    TFDirector:send(c2s.ODEUM_REQ_RANK, {rankType})
end

function FubenDataMgr:send_ODEUM_REQ_NODE_PRIZE()
    TFDirector:send(c2s.ODEUM_REQ_NODE_PRIZE, {})
end

function FubenDataMgr:send_ODEUM_UPDATE_CONTRIBUTION()
    TFDirector:send(c2s.ODEUM_UPDATE_CONTRIBUTION, {})
end

function FubenDataMgr:send_ODEUM_REQ_NOTICE()
    TFDirector:send(c2s.ODEUM_REQ_NOTICE, {})
end

function FubenDataMgr:send_ODEUM_OPEN_PANEL()
    TFDirector:send(c2s.ODEUM_OPEN_PANEL, {})
end

function FubenDataMgr:send_ODEUM_REQ_SELF_CONTRI_PRIZE(id)
    TFDirector:send(c2s.ODEUM_REQ_SELF_CONTRI_PRIZE, {id})
end

function FubenDataMgr:onRecvAllLevelInfo(event)
    self.levelInfo_      = {}
    self.levelGroupInfo_ = {}
    self:onRecvLevelInfo(event)
end

function FubenDataMgr:onRecvLevelInfo(event)
    self.tmpLevelInfo = clone(self.levelInfo_)
    self.tmpLevelGroupInfo = clone(self.levelGroupInfo_)
	print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~FubenDataMgr:onRecvLevelInfo=");
    local data = event.data
    if data.levelInfos then
        local levelInfo = data.levelInfos.levelInfos
        if levelInfo then
            for _, info in ipairs(levelInfo) do
                self.levelInfo_[info.cid] = info
            end
        end
    end
    if data.groups then
        local levelGroupInfo = data.groups.group
        if levelGroupInfo then
            for _, info in ipairs(levelGroupInfo) do
                if info.rewardInfo then
                    local rewardInfo = {}
                    for _, rInfo in ipairs(info.rewardInfo) do
                        rewardInfo[rInfo.key] = rInfo.list
                    end
                    info.rewardInfo = rewardInfo
                end
                self.levelGroupInfo_[info.cid] = info
            end
        end
    end
    EventMgr:dispatchEvent(EV_FUBEN_LEVELINFOUPDATE)
    self:dasyncLevelInfo()
end

function FubenDataMgr:getPassLevelNum()
    local num = 0
    for k,v in pairs(self.levelInfo_) do
        if v.win then
            num = num + 1
        end
    end
    return num
end

function FubenDataMgr:dasyncLevelInfo( ... )
    -- body
    self.tmpLevelInfo = clone(self.levelInfo_)
    self.tmpLevelGroupInfo = clone(self.levelGroupInfo_)
end

function FubenDataMgr:onRecvFightStart(event)
    AlertManager:closeLayerByName("EnhuiSquadView")
    AlertManager:closeLayerByName("FubenSquadView")
    AlertManager:closeLayerByName("KabalaTreeFight")
    local data = event.data
    if data.helpPid ~= 0 then
        if FriendDataMgr:isFriend(data.helpPid) then
            local cd = Utils:getKVP(6001, "cd")
            local sec = ServerDataMgr:getServerTime() + cd * 60
            FriendDataMgr:setFriendHelpCDtime(data.helpPid, sec)
        else
            self:popAssistHero(data.helpPid)
        end
    end
    self.curLevelCid_ = data.levelCid
    local levelCfg = self:getLevelCfg(data.levelCid)

    local battleController = require("lua.logic.battle.BattleController")
    if levelCfg.dungeonType == EC_FBLevelType.FIGHTING or levelCfg.dungeonType == EC_FBLevelType.THEATER_FIGHTING or levelCfg.dungeonType == EC_FBLevelType.KUANGSAN_FIGHTING then
        if levelCfg.fightingMode == 2 or levelCfg.fightingMode == 3 then
            local flightController = require("lua.logic.battle.flight.FlightController")
            flightController.enterBattle(data, EC_BattleType.COMMON)
        else
            battleController.enterBattle(data, EC_BattleType.COMMON)
        end
        EventMgr:dispatchEvent(EV_BATTLE_FIGHTSTART)
    elseif levelCfg.dungeonType == EC_FBLevelType.DATING or levelCfg.dungeonType == EC_FBLevelType.THEATER_DATING or levelCfg.dungeonType == EC_FBLevelType.KUANGSAN_DATING  or levelCfg.dungeonType == EC_FBLevelType.DICUO_MAINDATING then
        DatingDataMgr:sendGetSciptMsg(EC_DatingScriptType.FUBEN_SCRIPT,nil,nil, levelCfg.datingID[1])
    elseif levelCfg.dungeonType == EC_FBLevelType.CITYDATING then
        NewCityDataMgr:sendGetCitySetpData(EC_NewCityType.NewCity_FuBen, levelCfg.datingID[1], RoleDataMgr:getCurId())
    elseif levelCfg.dungeonType == EC_FBLevelType.SPRITE then
        battleController.enterBattle(data, EC_BattleType.COMMON)
    elseif levelCfg.dungeonType == EC_FBLevelType.KABALATREE then
        KabalaTreeDataMgr:setInWorldFage(false)
        battleController.enterBattle(data, EC_BattleType.COMMON)
        EventMgr:dispatchEvent(EV_BATTLE_FIGHTSTART)
    elseif levelCfg.dungeonType == EC_FBLevelType.SPRITE_EXTRA then
        battleController.enterBattle(data, EC_BattleType.COMMON)
    elseif levelCfg.dungeonType == EC_FBLevelType.HALLOWEEN then
        battleController.enterBattle(data, EC_BattleType.COMMON)
    elseif levelCfg.dungeonType == EC_FBLevelType.THEATER_BOSS then
        battleController.enterBattle(data, EC_BattleType.COMMON)
    elseif levelCfg.dungeonType == EC_FBLevelType.CHRISTMAS then
        battleController.enterBattle(data, EC_BattleType.COMMON)
    elseif levelCfg.dungeonType == EC_FBLevelType.NIANBREAST then
        battleController.enterBattle(data, EC_BattleType.COMMON)
    elseif levelCfg.dungeonType == EC_FBLevelType.DALMAP then
        DalMapDataMgr:setInWorldFage(false)
        battleController.enterBattle(data, EC_BattleType.COMMON)
        EventMgr:dispatchEvent(EV_BATTLE_FIGHTSTART)
    elseif levelCfg.dungeonType == EC_FBLevelType.TXJZ then
        battleController.enterBattle(data, EC_BattleType.COMMON)
    elseif levelCfg.dungeonType == EC_FBLevelType.SKYLADDER then
        SkyLadderDataMgr:setSkyLadderMainViewState(true)
        battleController.enterBattle(data, EC_BattleType.COMMON)
    elseif levelCfg.dungeonType == EC_FBLevelType.HUNTER then
        battleController.enterBattle(data, EC_BattleType.COMMON)
    elseif levelCfg.dungeonType == EC_FBLevelType.HWX_TOWER or levelCfg.dungeonType == EC_FBLevelType.HWX then
        battleController.enterBattle(data, EC_BattleType.COMMON)
	elseif levelCfg.dungeonType == EC_FBLevelType.MONSTER_TRIAL then
        battleController.enterBattle(data, EC_BattleType.COMMON)
    elseif levelCfg.dungeonType == EC_FBLevelType.WORLD_BOSS then
        battleController.enterBattle(data, EC_BattleType.COMMON)

    elseif levelCfg.dungeonType == EC_FBLevelType.DICUO_MAINFIGHT
            or levelCfg.dungeonType == EC_FBLevelType.DICUO_ENHUI
            or levelCfg.dungeonType == EC_FBLevelType.DICUO_HUALUN
            or levelCfg.dungeonType == EC_FBLevelType.DICUO_JIBAN 
            or levelCfg.dungeonType == EC_FBLevelType.SNOW_FESTIVAL then
                battleController.enterBattle(data, EC_BattleType.COMMON)
    elseif levelCfg.dungeonType == EC_FBLevelType.ENDLESS_PLUSS then
        battleController.enterBattle(data, EC_BattleType.COMMON)
    end
    self:cachePlayerInfo()
end

function FubenDataMgr:onRecvFightOver(event)
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~FubenDataMgr:onRecvFightOver=" );

    local data = event.data
    BattleDataMgr:setBattleResutlOrgData(data)

    local levelInfo = data.levelInfo
    local dropReward = data.rewards or {}
    local isWin = data.win
    self.simulationTrialReward = nil
    local levelCfg = self:getLevelCfg(levelInfo.cid)
    if levelInfo then
        if levelInfo.win then
	        local levelGroupCfg = self:getLevelGroupCfg(levelCfg.levelGroupId)
	        local rawUnlock = self:isPassPlotLevel(levelInfo.cid)

	        if levelGroupCfg.dungeonChapterId == 1 then  --英文版检测第一章是否全通关
	            local dataDisCreateLevel = TabDataMgr:getData("DiscreteData" , 1100008).data
	            for k ,v in pairs(dataDisCreateLevel.levelId) do
	                if not self.levelInfo_[v] then
	                    self.isNeedCheckAllPassWin = true
	                end
	            end
	        end

            if not self.levelInfo_[101101] and levelCfg.id == 101101 then  --首次通关第一关要上报
                Utils:sendHttpLog("numerical_fight_over")
            end

            self.levelInfo_[data.levelInfo.cid] = levelInfo
            if not rawUnlock then
                if levelCfg.lastOne then
                    self:setUnlockNextChapterCid(levelGroupCfg.dungeonChapterId)
                    --记录5星好评价
                    if levelGroupCfg.dungeonChapterId == 2 then
                        CommonManager:setStarEvaluateFlage(true)
                    end
                end
            end
            FunctionDataMgr:updateOpenFuncList()
            --试炼第一章 奖励
            if self:isSimulationGroup(1,levelGroupCfg.id) then
                self.simulationTrialReward = {}

                for i,v in ipairs(dropReward) do
                    if self:isSimulationReward(v.id) then
                        table.insert(self.simulationTrialReward,v)
                    end
                end
            end
            EventMgr:dispatchEvent(EV_FUBEN_LEVELINFOUPDATE)
        else
            -- 世界Boss失败也算入战斗次数
            if levelCfg.dungeonType == EC_FBLevelType.WORLD_BOSS then
                self.levelInfo_[data.levelInfo.cid] = levelInfo
                LeagueDataMgr:clearFightWorldBossType()
            end
        end
    end

    if levelCfg.dungeonType == EC_FBLevelType.FIGHTING then
        BattleDataMgr:setBattleResutlData(dropReward)
        EventMgr:dispatchEvent(EV_BATTLE_FIGHTOVER, dropReward, isWin)
    elseif levelCfg.dungeonType == EC_FBLevelType.DATING or levelCfg.dungeonType == EC_FBLevelType.THEATER_DATING or levelCfg.dungeonType == EC_FBLevelType.KUANGSAN_DATING then
        DatingDataMgr:setIsDating(false)
        if levelCfg.ifReturn then
            EventMgr:dispatchEvent(EV_BATTLE_FIGHTOVER, dropReward, isWin)
            AlertManager:showLevelUpPopView()
            return 
        end

        if levelCfg.isbirthType ~= 1 and levelCfg.dungeonType ~= EC_FBLevelType.KUANGSAN_DATING then
            self:openFuben()
            AlertManager:showLevelUpPopView()
        elseif levelCfg.dungeonType == EC_FBLevelType.KUANGSAN_DATING then
            FunctionDataMgr:jKsanFuben()
        end
    elseif levelCfg.dungeonType == EC_FBLevelType.CITYDATING then
        AlertManager:setOpenFubenCom(true)
        AlertManager:changeScene(SceneType.MainScene)
    elseif levelCfg.dungeonType == EC_FBLevelType.SPRITE then
        BattleDataMgr:setBattleResutlData(dropReward)
        EventMgr:dispatchEvent(EV_BATTLE_FIGHTOVER, dropReward, isWin)
    elseif levelCfg.dungeonType == EC_FBLevelType.KABALATREE then
        BattleDataMgr:setBattleResutlData(dropReward)
        KabalaTreeDataMgr:overKabalaFight(isWin)
        EventMgr:dispatchEvent(EV_BATTLE_FIGHTOVER, dropReward, isWin)
    elseif levelCfg.dungeonType == EC_FBLevelType.SPRITE_EXTRA then
        BattleDataMgr:setBattleResutlData(dropReward)
        EventMgr:dispatchEvent(EV_BATTLE_FIGHTOVER, dropReward, isWin)
    elseif levelCfg.dungeonType == EC_FBLevelType.DALMAP then
        BattleDataMgr:setBattleResutlData(dropReward)
        DalMapDataMgr:overDalFight(isWin)
        EventMgr:dispatchEvent(EV_BATTLE_FIGHTOVER, dropReward, isWin)
    else
        BattleDataMgr:setBattleResutlData(dropReward)
        EventMgr:dispatchEvent(EV_BATTLE_FIGHTOVER, dropReward, isWin)
    end
end

function FubenDataMgr:onRecvFightAsstiant(event)
    local data = event.data
    if data.players then
        self.assistantData_ = data.players
        EventMgr:dispatchEvent(EV_FUBEN_ASSISTANTUPDATE)
    end
end

function FubenDataMgr:onRecvLevelGroupReward(event)
    local data = event.data
    local rewardInfo = {}
    for i, v in ipairs(data.rewardInfo) do
        rewardInfo[v.key] = v.list
    end
    local levelGroupInfo = self:getLevelGroupInfo(data.cid)
    if levelGroupInfo then
        levelGroupInfo.rewardInfo = rewardInfo
    end
    EventMgr:dispatchEvent(EV_FUBEN_LEVELGROUPREWARD, data.difficulty, data.starNum)
end

function FubenDataMgr:onRecvUpdateLevelGroupInfo(event)
    local data = event.data
    if not data then return end
    local levelGroupInfo = data.group
    if levelGroupInfo then
        self.levelGroupInfo_[levelGroupInfo.cid] = levelGroupInfo
    end
end

function FubenDataMgr:onRecvUpdateGroupListInfo(event)
    local data = event.data
    if not data then return end

    self.levelGroupInfo_ = self.levelGroupInfo_ or {}
    for k, v in ipairs(data.group or {}) do
        self.levelGroupInfo_[v.cid] = v
    end

    EventMgr:dispatchEvent(EV_FUBEN_DAILYBUYCOUNT)
end

function FubenDataMgr:onRecvUpdateLevelInfo(event)
	print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~FubenDataMgr:onRecvUpdateLevelInfo=");
    local data = event.data
    if not data.levelInfos then return end
    for _, info in ipairs(data.levelInfos) do
        self.levelInfo_[info.cid] = info
    end
end

function FubenDataMgr:onRecvBuyFightCount(event)
    local data = event.data
    EventMgr:dispatchEvent(EV_FUBEN_DAILYBUYCOUNT, data.cid)
end

function FubenDataMgr:onRecvEndlessInfo(event)
    local data = event.data
    if not data.info then return end
    self.endlessInfo_ = data.info
    EventMgr:dispatchEvent(EV_FUBEN_UPDATEENDLESSINFO)
end

function FubenDataMgr:onRecvStartFightEndless(event)
    AlertManager:closeLayerByName("FubenSquadView")
    local data = event.data
    self.curLevelCid_ = data.levelCid
    local battleController = require("lua.logic.battle.BattleController")
    battleController.enterBattle(data, EC_BattleType.ENDLESS)
    EventMgr:dispatchEvent(EV_FUBEN_ENDLESSFIGHTSTART)
    self:cachePlayerInfo()
end

function FubenDataMgr:onRecvPassEndless(event)
    local data = event.data
    if data.nextLevelCid ~= 0 then
        self.endlessInfo_.curStage = data.nextLevelCid
    end
    EventMgr:dispatchEvent(EV_FUBEN_ENDLESSFIGHTVICTORY, data.rewards)
end

function FubenDataMgr:onRecvLimitHeros(event)
    local function changesid(hero)
        local sid = hero.id
        local id  = hero.cid;
        hero.sid  = tostring(sid);
        hero.id   = id;
    end

    local data = event.data
    -- print("==============",data)
    if not data.heros or #data.heros < 1 then 
        local errMsg = string.format("recv no limitheroinfos: levelCid=%s",tostring(data.leveId))
        Bugly:ReportLuaException(errMsg)
        return
    end
    for i, v in ipairs(data.heros) do
        local newAttr = {}
        for _, attr in pairs(v.heros.attr) do
            newAttr[attr.type] = attr.val
        end
        v.heros.attr = newAttr
        v.heros.isLimitHero = true
        local heroCfg = TabDataMgr:getData("Hero", v.heros.cid)
        local hero = {}
        hero = table.merge(hero, heroCfg)
        hero = table.merge(hero, v.heros)
        changesid(hero)
        self.limitHeros_[v.limitId] = hero
    end
    self.levelFormation_[data.leveId] = clone(data.limitFormation)
    self.originLevelFormation_[data.leveId] = data.limitFormation
    EventMgr:dispatchEvent(EV_FUBEN_UPDATE_LIMITHERO)
    if self.requestLimitInfo then
        self:enterMusicGameLevel()
    end

    if data.leveId == 101101 then
        self.entryFirstLevelTimes = self.entryFirstLevelTimes or 0
        if self.entryFirstLevelTimes > 10 then
            
        else
            if not self:isPassPlotLevel(101101) then
                self.entryFirstLevelTimes = self.entryFirstLevelTimes + 1
                self:enterFirstPlotLevel()
            end
        end
    end

end

function FubenDataMgr:onRecvGroupMultipleReward(event)
    local data = event.data
    if not data.multipleInfo then return end

    self.dailyMultipleInfo_ = {}
    for i, v in ipairs(data.multipleInfo) do
        self.dailyMultipleInfo_[v.groupId] = v
    end
end

function FubenDataMgr:onRecvLevelBuyCount(event)
	print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~FubenDataMgr:onRecvLevelBuyCount=");
    local data = event.data
    if not data.levelInfo then return end
    self.levelInfo_[data.levelInfo.cid] = data.levelInfo
    EventMgr:dispatchEvent(EV_FUBEN_PLOTLEVEL_BUY_COUNT)
end

function FubenDataMgr:onRecvSpriteChallengeInfo(event)
    local data = event.data
    if not data then return end
    self.spriteChallengeInfo_ = data
    EventMgr:dispatchEvent(EV_FUBEN_SPRITE_UPDATE_INFO)
end

function FubenDataMgr:onRecvSpriteRefreshBuffer(event)
    local data = event.data
    if not data.buffCid then return end
    self.spriteChallengeInfo_.buffCid = data.buffCid
    self.spriteChallengeInfo_.buffCount = data.buffCount
    EventMgr:dispatchEvent(EV_FUBEN_SPRITE_UPDATE_BUFF)
end

function FubenDataMgr:onRecvGetSpriteReward(event)
    local data = event.data
    local rewards = data.rewards or {}
    EventMgr:dispatchEvent(EV_FUBEN_SPRITE_GET_REWARD, rewards)
end

--精灵外传收到服务端消息
function FubenDataMgr:onRecvSpriteExtraLevelsInfo(event)
    local data = event.data
    if data == nil then
        return
    end
    self.spriteExtraInfo_["levelInfos"] = {}
    for k,v in pairs(data) do
        if k == "levelInfos" then
            for s,t in pairs(v) do
                self.spriteExtraInfo_["levelInfos"][t.cid] = t
            end
        else
            self.spriteExtraInfo_[k] = v
        end
    end
    self.spriteExtraInfo_["levelsCfg"] = TabDataMgr:getData("Herodemo")
    EventMgr:dispatchEvent(EV_FUBEN_SPRITE_EXTRA_UPDATE_INFO)
end

function FubenDataMgr:onRecvSpriteExtraLevelUpdateInfo(event)
    local data = event.data
    if data == nil then
        return
    end
    if self.spriteExtraInfo_.levelInfos == nil then
        self.spriteExtraInfo_.levelInfos = {}
    end
    self.spriteExtraInfo_.levelInfos[data.cid] = data
    EventMgr:dispatchEvent(EV_FUBEN_SPRITE_EXTRA_UPDATE_INFO)
end

function FubenDataMgr:getLastEndlessRankInfo()
    return self.lastCycleList,self.selflastCycleRank
end

function FubenDataMgr:getCurEndlessRankInfo()
    return self.presentRankList,self.selfpresentRank
end

function FubenDataMgr:onRecvEndlessRank(event)
    local data = event.data
    if not data then return end

    self.lastCycleList = data.lastCycleList or {}
    self.selflastCycleRank = data.lastCycleRank

    self.presentRankList = data.presentRankList or {}
    self.selfpresentRank = data.presentRank

    --self.lastCycleList = data.rankList or {}
    --self.selflastCycleRank = data.rank
    --
    --self.presentRankList = data.rankList or {}
    --self.selfpresentRank = data.rank

    EventMgr:dispatchEvent(EV_FUBEN_ENDLESS_UPDATERANK, data.rankList, data.rank, data.refreshMinu)
end

function FubenDataMgr:onRecvEndlessLevelBuff(event)
    local data = event.data
    if not data then return end
    EventMgr:dispatchEvent(EV_FUBEN_ENDLESS_BUFFER, data.levelBuffs)
end

function FubenDataMgr:onRecvEndlessJumpLevel(event)
    local data = event.data
    if not data then return end
    EventMgr:dispatchEvent(EV_FUBEN_ENDLESS_JUMPLEVEL, data.nonstop, data.rewards)
end

function FubenDataMgr:onRecvOpenTheaterBossInfo(event)
    local data = event.data
    if not data then return end
    self.theaterBossInfo_ = data
    self.theaterBossInfo_.selfContriPrizeStatus = self.theaterBossInfo_.selfContriPrizeStatus or {}
    EventMgr:dispatchEvent(EV_FUBEN_THEATER_BOSS_INFO)
end

function FubenDataMgr:onRecvTheaterRank(event)
    local data = event.data
    if not data then return end
    EventMgr:dispatchEvent(EV_FUBEN_THEATER_RANK, data.rankType, data.ranks or {}, data.myRank, data.myScore)
end

function FubenDataMgr:onRecvTheaterLevelCid(event)
    local data = event.data
    if not data then return end

    if data.bossDungeonId and self.theaterBossInfo_ then
        self.theaterBossInfo_.bossDungeonId = data.bossDungeonId
        EventMgr:dispatchEvent(EV_FUBEN_THEATER_BOSS_INFO)
    end
end

function FubenDataMgr:onRecvTheaterLingbo(event)
    local data = event.data
    if not data then return end

    if data.lingbo and self.theaterBossInfo_ then
        self.theaterBossInfo_.lingbo = data.lingbo
        EventMgr:dispatchEvent(EV_FUBEN_THEATER_BOSS_INFO)
    end
end

function FubenDataMgr:onRecvTheaterStatus(event)
    local data = event.data
    if not data then return end

    if data.status and self.theaterBossInfo_ then
        self.theaterBossInfo_.status = data.status
        EventMgr:dispatchEvent(EV_FUBEN_THEATER_BOSS_INFO)
    end
end

function FubenDataMgr:onRecvUpdateTheaterContribution(event)
    local data = event.data
    if not data then return end

    if data.serverContribution and self.theaterBossInfo_ then
        if data.serverContribution ~= -1 then
            self.theaterBossInfo_.serverContribution = data.serverContribution
            EventMgr:dispatchEvent(EV_FUBEN_THEATER_BOSS_INFO)
        end
    end
end

function FubenDataMgr:onRecvTheaterLevelInfo(event)
    local data = event.data
    if not data then return end
    if data.conditons then
        if data.conditons.datingNodes then
            for i, v in ipairs(data.conditons.datingNodes) do
                self.theaterDatingOptionInfo_[v] = true
            end
        end
    end

    if data.levels then
        self.theaterLevelOrder_ = data.levels
        for i, v in ipairs(self.theaterLevelOrder_) do
            self.theaterLevelWeight_[v] = i
        end
    end
end

function FubenDataMgr:onRecvTheaterReceiveReward(event)
    local data = event.data
    if not data then return end
    self.theaterBossInfo_.receiveStatus = EC_TheaterReceiveStatus.GETED
    EventMgr:dispatchEvent(EV_FUBEN_THEATER_NODE_REWARD, data.rewards or {})
end

function FubenDataMgr:onRecvUpdateTheaterOptionInfo(event)
    local data = event.data
    if not data then return end

    if data.datingNodes then
        for i, v in ipairs(data.datingNodes) do
            self.theaterDatingOptionInfo_[v] = true
        end
    end
end

function FubenDataMgr:onRecvUpdateTheaterLevelOrder(event)
    local data = event.data
    if not data then return end

    if data.level then
        for i, v in ipairs(data.level) do
            table.insert(self.theaterLevelOrder_, v)
            self.theaterLevelWeight_[v] = #self.theaterLevelOrder_
        end
    end
end

function FubenDataMgr:onRecvUpdateTheaterNotice(event)
    local data = event.data
    if not data then return end

    if data.name and data.contribution then
        local item = {
            name = data.name,
            contribution = data.contribution,
        }
        table.insert(self.theaterNotice_, item)
        local gap = #self.theaterNotice_ - 10
        for i = 1, gap do
            table.remove(self.theaterNotice_, 1)
        end
        EventMgr:dispatchEvent(EV_FUBEN_THEATER_UPDATE_NOTICE)
    end
end

function FubenDataMgr:onRecvTheaterReward(event)
    local data = event.data
    self.theaterBossInfo_.selfContriPrizeStatus = self.theaterBossInfo_.selfContriPrizeStatus or {}
    table.insert(self.theaterBossInfo_.selfContriPrizeStatus, data.prizeIndex)
    EventMgr:dispatchEvent(EV_FUBEN_THEATER_RECEIVE_REWARD, data.prizeIndex, data.selfContriRewards)
end

function FubenDataMgr:onRecvTheaterContorProcess( event )
    local data = event.data
    if not data then return end
    self.theaterControlProcess[data.chapterId] = data.id
    EventMgr:dispatchEvent(EV_FUBEN_THEATER_CONTRO_PROCESS)
end

function FubenDataMgr:onRecvUpdataTheaterContorProcess( event )
    local data = event.data
    if not data then return end
    self.theaterControlProcess[data.chapterId] = data.id
end

function FubenDataMgr:getTheaterContorProcess( chapterId )
    if not self.theaterControlProcess[chapterId] then
        TFDirector:send(c2s.ODEUM_REQ_FINISH_PROCESS,{chapterId})
        return -10
    end
    return self.theaterControlProcess[chapterId]
end

function FubenDataMgr:saveTheaterContorProcess( chapterId , stepId)
    if stepId and chapterId then
    self.theaterControlProcess[chapterId] = stepId
        TFDirector:send(c2s.ODEUM_REQ_UPDATE_FINISH_PROCESS,{stepId,chapterId})
    end
end

--海王星联动

function FubenDataMgr:sendLinkageCG(id)
    TFDirector:send(c2s.DUNGEON_REQ_TIME_LINKAGE_CG,{id})
end

function FubenDataMgr:getLinkageInfo()
    return self.linkageInfo
end

function FubenDataMgr:getLinkageChapterInfo(chapterCid)
    if self.linkageInfo and self.linkageInfo.dungeons then
        for i,v in ipairs(self.linkageInfo.dungeons) do
            if v.chapterCid == chapterCid then 
                return v
            end
        end
    end
    Box("未找到 "..tostring(chapterCid).." 联动作战数据")
    return  { ["begin"] = 1569168000 , ["chapterCid"] = 3001 ,["end"] = 1570463940}  --坑爹使用了lua 关键字end
end

function FubenDataMgr:onRevLinkageInfo(event)
    self.linkageInfo = event.data
    -- dump(self.linkageInfo)
end

function FubenDataMgr:onRevLinkageCG(event)
    dump(event.data)
    if self.linkageInfo then 
        self.linkageInfo.CGCids = event.data.cids
    end 
end

---狂三副本
function FubenDataMgr:getKsanLevelInfo(dungenLevel)
    return self.ksDungeonCityCfgMap[dungenLevel]
end

---魔禁副本
function FubenDataMgr:getMojinLevelInfo(dungenLevel)
    return self.mojinCityDisplayCfgMap[dungenLevel]
end

function FubenDataMgr:checkIsAllChapterPassWin()
    if not self.isNeedCheckAllPassWin then  return end
    local data = TabDataMgr:getData("DiscreteData",1100008).data
    for k , v in pairs(data.levelId) do
        if not self:isPassPlotLevel(v) then
            return false
        end
    end
    self.isNeedCheckAllPassWin = false
    return true
end

---魔禁副本
function FubenDataMgr:getMojinLevelInfo(dungenLevel)
    return self.mojinCityDisplayCfgMap[dungenLevel]
end

-- 周卡月卡特权日常或剧场增加次数 108、109、110
function FubenDataMgr:getFreePrivilegeNumById(levelCid)
    local num = 0
    local levelCfg = self:getLevelCfg(levelCid)
    local levelGroup = self.levelGroupMap_[levelCfg.levelGroupId]
    local isHavePrivilege1, cfg1 = RechargeDataMgr:getIsHavePrivilegeByType(108)

    -- 小语种剧场屏蔽
    local isHavePrivilege2, cfg2 = nil, nil
    if(GlobalFuncDataMgr:isOpen(3)) then
        isHavePrivilege2, cfg2 = RechargeDataMgr:getIsHavePrivilegeByType(109)
    end
    local isHavePrivilege3, cfg3 = RechargeDataMgr:getIsHavePrivilegeByType(110)
    -- 日常困难地狱模式(周卡)
    if isHavePrivilege1 then 
        for type, v in pairs(cfg1.privilege.dungeonType) do
            if type == levelGroup.dungeonType and v[levelCfg.dungeonType] then
                for i, diffculty in ipairs(v[levelCfg.dungeonType]) do
                    if levelCfg.difficulty == diffculty then
                        num = num + cfg1.privilege.chance
                        break
                    end
                end
            end
        end
    end
    -- 日常困难地狱模式(月卡)
    if isHavePrivilege3 then 
        for type, v in pairs(cfg3.privilege.dungeonType) do
            if type == levelGroup.dungeonType and v[levelCfg.dungeonType] then
                for i, diffculty in ipairs(v[levelCfg.dungeonType]) do
                    if levelCfg.difficulty == diffculty then
                        num = num + cfg3.privilege.chance
                        break
                    end
                end
            end
        end
    end

    -- 剧场困难模式
    if isHavePrivilege2 then
        for type, v in pairs(cfg2.privilege.dungeonType) do
            if type == levelGroup.dungeonType and v[levelCfg.dungeonType] and v[levelCfg.dungeonType][1] == levelCfg.difficulty then
                num = num + cfg2.privilege.chance
                break
            end
        end 
    end
    return num
end

--魔王试炼
function FubenDataMgr:requestMonsterTrialInfo()
	TFDirector:send(c2s.DUNGEON_REQ_GET_EXPERIMENT,{})
end

function FubenDataMgr:onRecvMonsterTrialInfo(evt)
	if evt.data == nil then
		return
	end
	dump(evt.data)
	self.MonsterTrialInfo = nil
	self.MonsterTrialInfo = clone(evt.data)
	self.MonsterTrialInfo["experiment"] = self.MonsterTrialInfo["experiment"] or {}
	self.MonsterTrialInfo["attackOrder"] = self.MonsterTrialInfo["attackOrder"] or {}
	self.MonsterTrialInfo["heroBuff"] = self.MonsterTrialInfo["heroBuff"] or {}
	self.MonsterTrialInfo["taskList"] = self.MonsterTrialInfo["taskList"] or {}

	local exp = self.MonsterTrialInfo["experiment"]
	for i = 1, #exp do
		local config = TabDataMgr:getData("HighBoss", exp[i].id)
		exp[i].position = config.position
		exp[i].configHighBoss = config
		exp[i].configDungeonLevel = TabDataMgr:getData("DungeonLevel", config.dungeonLevelId)
	end
	table.sort(exp, function(a,b)
		return a.position < b.position
	end)

	self:initMonsterBuffList()

	--dump(self.MonsterTrialInfo)

	EventMgr:dispatchEvent(EV_RECV_MONSTER_TRIAL_INFO)
end

function FubenDataMgr:initMonsterBuffList()
	self.MonsterLvlBufflist = {}

	local attackOrder = self.MonsterTrialInfo["attackOrder"] or {}
	
	for i = 1, #attackOrder do
		local temp = {
			HighBossId = attackOrder[i],
			Config = TabDataMgr:getData("HighBoss", attackOrder[i])
		}			
		table.insert(self.MonsterLvlBufflist, temp)
	end
end

function FubenDataMgr:onRecvMonsterTrialSettlement(evt)
	self.MonsterTrialSettlementData = evt.data
	dump( evt.data)
	local exp = self.MonsterTrialInfo["experiment"] or {}
	for i = 1, #exp do
		if exp[i].id == evt.data.id then
			exp[i].score = evt.data.history
			self:saveNewBuff(exp[i].id)
			break;
		end
	end
	EventMgr:dispatchEvent(EV_RECV_MONSTER_TRIAL_SETTLEMENT)
end

function FubenDataMgr:getMonsterTrialInfo()
	return self.MonsterTrialInfo;
end

function FubenDataMgr:getMonsterTrialBuffListByLvId(Lv)
	local highBossCfg = self:getMonsterTrialInfoByLvl(Lv)
	local buffCfgList = self:getMonsterLvlBufflist(highBossCfg.id) or {}
	local ret = {}
	for k, v in pairs(buffCfgList) do
		table.insert(ret, v.Config)
	end
	return ret
end

function FubenDataMgr:getMonsterTrialInfoByLvl(levelID)
	local ret;
	if levelID then
		for k,v in pairs(self.MonsterTrialInfo["experiment"]) do
			if levelID == v.configHighBoss.dungeonLevelId then
				ret = v
				break;
			end
		end
	end
	return ret
end

function FubenDataMgr:getMonsterTrialInfoByHighBoss(HighBossId)
	local ret;
	if HighBossId then
		for k,v in pairs(self.MonsterTrialInfo["experiment"]) do
			if HighBossId == v.id then
				ret = v
				break;
			end
		end
	end
	return ret
end

function FubenDataMgr:getMonsterTrialLvTotalScore()
	local scroe = 0
	for k,v in pairs(self.MonsterTrialInfo["experiment"] or {}) do		
		scroe = scroe + v.score	
	end
	return scroe
end

function FubenDataMgr:getMonsterLvlBufflist(HighBossId)
	local ret = {}
	local exsit = false
	for k, v in ipairs(self.MonsterLvlBufflist) do		
		if HighBossId == v.HighBossId then
			exsit = true
			break;
		end
		table.insert(ret, v)
	end
	if not exsit and #ret == 0 then
		ret = unpack(self.MonsterLvlBufflist)
	end
	return ret
end

function FubenDataMgr:saveNewBuff(highBossId)
	if table.indexOf(self.MonsterTrialInfo["attackOrder"], highBossId) == -1 then
		table.insert(self.MonsterTrialInfo["attackOrder"], highBossId)
	end
	self:initMonsterBuffList()
end

function FubenDataMgr:getMonsterTrialSettlementData()
	self.MonsterTrialSettlementData = self.MonsterTrialSettlementData or {}
	local lvlIDd = self.MonsterTrialSettlementData.id
	local levelInfo = self:getMonsterTrialInfoByHighBoss(lvlIDd)	
	local upParam = 0.0
	if levelInfo.up then
		local discreteCfg = TabDataMgr:getData("DiscreteData", 90021)
		upParam = discreteCfg.data.upBilinear / 10000
	end
	self.MonsterTrialSettlementData.maxScore = levelInfo.configHighBoss.max * (1 + upParam) or 0
	return self.MonsterTrialSettlementData
end

function FubenDataMgr:isMonsterTrialOpen()
	local open = true
	local date = TFDate(ServerDataMgr:getServerTime()):tolocal()
	local discreteCfg = TabDataMgr:getData("DiscreteData", 90021)	
	local today = date:getweekday() - 1
	if today <= 0 then
		today = today + 7
	end
	if today == discreteCfg.data.settlement then
		open = false
	end
	return open
end

function FubenDataMgr:caculationMonsterScore(lvlId, costTime)
	costTime = math.floor(costTime / 1000)

	local discrete = TabDataMgr:getData("DiscreteData", 90021)
	local LvlConfig = TabDataMgr:getData("DungeonLevel", lvlId)

	local LvlInfo = self:getMonsterTrialInfoByLvl(lvlId)
	local baseScore = LvlInfo.configHighBoss.max
	local up = 0.0
	if LvlInfo.up then		
		up = discrete.data.upBilinear / 10000
	end

	local A = discrete.data.paramA
	local B = discrete.data.paramB
	local X = discrete.data.paramX
	local Y = discrete.data.paramY
	
	if costTime > A then
		baseScore = X + math.max(LvlConfig.time - costTime, 0) / Y
	end
	local total = baseScore * (1 + up)
	dump({
		lvlId= lvlId,
		up= LvlInfo.up,
		costTime= costTime,
		A= A,
		B= B,
		X= X,
		Y= Y,
		time=LvlConfig.time,
		total = total
	})
	print("caculationMonsterScore")
	return total
end

function FubenDataMgr:getMonsterFullScoreRemainTime(costTime)
	local discrete = TabDataMgr:getData("DiscreteData", 90021)
	return math.max( math.floor(discrete.data.paramA -  costTime / 1000), 0)
end

function FubenDataMgr:getMonsterBuffByHeroId(heroId)
	local ret;
	for k,v in pairs(self.MonsterTrialInfo["heroBuff"] or {}) do		
		if 	heroId == v.heroId then
			ret = v.buffId
			break;
		end
	end
	return ret
end

function FubenDataMgr:getMonsterTrialCloseTime()
    local closeday = Utils:getKVP(90021, "settlement")
    local date = Utils:getUTCDate(ServerDataMgr:getServerTime() ,GV_UTC_TIME_ZONE)
    local weekday = date:getweekday()
    local baseDate = TFDate(date:getyear() , date:getmonth() , date:getday(),- GV_UTC_TIME_ZONE)--TFdate会将UTC-7化得时间再次变为UTC-0时间所以需要补上时区时差
    local endDate
    if weekday ~= closeday then
        local addDays = 1
        local day = weekday
        local i = 1
        while true do
            day = day + 1
            if day > 7 then
                day = 1
            end
            if day ~= closeday then
                addDays = addDays + 1
            else
                break
            end
        end
        addDays = addDays + 1
        endDate = baseDate:adddays(addDays)
    else
        endDate = baseDate:adddays(1)
    end
    local offsetDate = endDate - TFDate.epoch()
    local timestamp = offsetDate:spanseconds()
    return timestamp
end

function FubenDataMgr:getMonsterTrialOpenTime()
    local closeday = Utils:getKVP(90021, "settlement")
    local date = Utils:getUTCDate(ServerDataMgr:getServerTime() ,GV_UTC_TIME_ZONE)
    local weekday = date:getweekday()
    local baseDate = TFDate(date:getyear() , date:getmonth() , date:getday() , - GV_UTC_TIME_ZONE)  --TFdate会将UTC-7化得时间再次变为UTC-0时间所以需要补上时区时差
    local endDate
    if closeday == weekday then
        local addDays = 1
        local day = weekday
        while true do
            day = day + 1
            if day > 7 then
                day = 1
            end
            if day == closeday then
                addDays = addDays + 1
            else
                break
            end
        end
        addDays = addDays + 1
        endDate = baseDate:adddays(addDays)
    else
        endDate = baseDate:adddays(1)
    end
    local offsetDate = endDate - TFDate.epoch()
    local timestamp = offsetDate:spanseconds()
    return timestamp
end
local __print = print
function FubenDataMgr:getBossChallengeTimes()
    local openTime = 0
    local closeTime = 0
    local readyTime = 0
    local endTime = 0
    local tempTime = 0
    local curRound = 0
    local maxRound = #self.NewBossChallenge_
    local firstCfg = self.NewBossChallenge_[1]
    local lastCfg = self.NewBossChallenge_[#self.NewBossChallenge_]
    if firstCfg then
        openTime = Utils:getTimeByDate(firstCfg.sTime)
        tempTime = Utils:getTimeByDate(firstCfg.eTime)
    end
    if lastCfg then
        closeTime = Utils:getTimeByDate(lastCfg.eTime)
    end
    local serverTime = ServerDataMgr:getServerTime()
    if serverTime < openTime then
        readyTime = openTime
        curRound = 1
    elseif serverTime > openTime and serverTime < closeTime then
        for i,v in ipairs(self.NewBossChallenge_) do
            local sTime = Utils:getTimeByDate(v.sTime)
            local eTime = Utils:getTimeByDate(v.eTime)
            if serverTime > tempTime and serverTime < sTime then
                readyTime = sTime
                curRound = v.round
            end
            if serverTime > sTime and serverTime < eTime then
                endTime = eTime
                curRound = v.round
                break
            else
                tempTime = eTime
            end
        end
    end
    return openTime,closeTime,readyTime,endTime,curRound,maxRound
end

function FubenDataMgr:getBossChallengeCurLevel()
    local openTime,closeTime,readyTime,endTime,curRound,maxRound = self:getBossChallengeTimes()
    for i,v in ipairs(self.NewBossChallenge_) do
        if v.round == curRound then
            return v
        end
    end
end

function FubenDataMgr:onRecvLinkAgeData( event )
    -- body
    local data = event.data
    if not data then return end
    self.linkAgeHeros = data.linkHero or {}
    self.jiBanHero = data.additionHero or {}
end

function FubenDataMgr:onSetLinkAgeHeroRsp( event )
    -- body
    local data = event.data
    if not data then return end
    local hasChange = false
    for k,v in ipairs(self.linkAgeHeros) do
        if v.index == data.linkHero.index then
            self.linkAgeHeros[k] = data.linkHero
            hasChange = true
            break
        end
    end

    if not hasChange then
        table.insert(self.linkAgeHeros,data.linkHero)
    end
    EventMgr:dispatchEvent(EV_LINKAGE_HERO_UPDATE)
end

function FubenDataMgr:onChangeLinkAgeDesireRsp( event )
    -- body
    local data = event.data
    if not data then return end
    for k,v in ipairs(self.linkAgeHeros) do
        if v.heroId == data.heroId then
            v.desire = data.attributeId
            break
        end
    end
    EventMgr:dispatchEvent(EV_LINKAGE_HERO_UPDATE)
end

function FubenDataMgr:onAttrUpRsp( event )
    -- body
    local data = event.data
    if not data then return end
    self.attrUpData = data
    EventMgr:dispatchEvent(EV_LINKAGE_ATTR_LEVELUP)
end

function FubenDataMgr:getLinkAgeHeros( ... )
    -- body
    return self.linkAgeHeros or {}
end

function FubenDataMgr:getJiBanHero( ... )
    -- body
    return self.jiBanHero or {}
end

function FubenDataMgr:getShowAttrUpData(  )
    -- body
    return self.attrUpData
end

function FubenDataMgr:clearAttrUpData(  )
    -- body
    self.attrUpData = nil
end

function FubenDataMgr:getGraceMaxExp( level )
    -- body
    local graceCfg = TabDataMgr:getData("Grace",level)

    return graceCfg.expToNextLevel == 0 and 1 or graceCfg.expToNextLevel
    
end

function FubenDataMgr:getGraceBaseAttr( level )
    -- body
    local graceCfg = TabDataMgr:getData("Grace",level)

    return graceCfg.updateAttrType
    
end

function FubenDataMgr:getLinkAgeHeroAttrs( heroData )
    local attrs = {}
    local attrCfg = clone(FubenDataMgr:getGraceBaseAttr(heroData.level))
    
    for k,v in ipairs(heroData.attrs or {}) do
        attrCfg[v.attributeId] = attrCfg[v.attributeId] + v.value
    end
    for _k,_v in pairs(attrCfg) do
        table.insert(attrs,{attributeId = _k, value = _v})
    end

    return attrs
end

function FubenDataMgr:getLinkAgeHeroLevel( heroId )
    -- body
    for k,v in pairs(self.linkAgeHeros) do
        if v.heroId == heroId then
            return v.level - 1, v.exp, self:getGraceMaxExp(v.level)
        end
    end
    return 0, 0, self:getGraceMaxExp(1)
end


function FubenDataMgr:isUnlockGraceLevel( level )
    -- body
    local graceCfg = TabDataMgr:getData("Grace",level)

    if graceCfg.expToNextLevel == 0 then return false end
    for k,v in ipairs(graceCfg.levelUnlockCond or {}) do
        if k == 1 and not self:isPassPlotLevel(v) then
            return false
        end
    end
    return true
end

function FubenDataMgr:checkSitIsLock( groupId, index )
    -- body
    local groupCfg = self:getLevelGroupCfg(groupId)
    local ext = groupCfg.ext
    local cond = ext.unlock[index]
    for k,v in pairs(cond) do
        if k == "dungeonid" and not self:isPassPlotLevel(v) then
            return true
        elseif k == "heroid" and not HeroDataMgr:getIsHave(v) then
            return true
        end
    end
    return false
end

function FubenDataMgr:getLinkAgeHeroAttrsByHeroId( heroId )
    local heroData = nil
     -- body
    for k,v in pairs(self.linkAgeHeros) do
        if v.heroId == heroId then
            heroData = v
        end
    end

    if not heroData then return {} end

    local attrs = {}
    local attrCfg = clone(FubenDataMgr:getGraceBaseAttr(heroData.level))
    
    for k,v in ipairs(heroData.attrs or {}) do
        attrCfg[v.attributeId] = attrCfg[v.attributeId] + v.value
    end
   
    return attrCfg
end


function FubenDataMgr:SEND_DUNGEON_REQ_GET_LINK_AGE(  )
    -- body
    TFDirector:send(c2s.DUNGEON_REQ_GET_LINK_AGE,{})
end

function FubenDataMgr:SEND_DUNGEON_REQ_SET_LINK_AGE_HERO( ... )
    -- body
    TFDirector:send(c2s.DUNGEON_REQ_SET_LINK_AGE_HERO,{...})
end

function FubenDataMgr:SEND_DUNGEON_REQ_CHANGE_LINK_AGE_DESIRE( ... )
    -- body
    TFDirector:send(c2s.DUNGEON_REQ_CHANGE_LINK_AGE_DESIRE,{...})
end
function FubenDataMgr:setReopenFlag(flag)
    self.reOpen = flag
end

function FubenDataMgr:getReopenFlag()
    return self.reOpen
end

return FubenDataMgr:new()
