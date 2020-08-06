local BaseDataMgr = import(".BaseDataMgr")
local AgoraDataMgr = class("AgoraDataMgr", BaseDataMgr)
local UserDefalt = CCUserDefault:sharedUserDefault()
function AgoraDataMgr:ctor()
    self:init()
end

function AgoraDataMgr:reset()
    self.maxPlayerStationInfos = 30 --情报站消息最大数
    self.agoraMainData = {}--集会所主数据
    self.agoraComposeData = {}--集会所合成数据
end

function AgoraDataMgr:init()

    self.ChristmasDungenCfg = TabDataMgr:getData("ChristmasDungen")
    self.ChristmasMapCfg = TabDataMgr:getData("ChristmasMap")
    self.ChristmasMapgiftCfg = TabDataMgr:getData("ChristmasMapgift")
    self.ChristmasInvadeCfg = TabDataMgr:getData("ChristmasInvade")

    -- self.contributionConf = {donateMap={}}--贡献度配置
    -- local DonateCfg = TabDataMgr:getData("ChristmasDonate")
    -- local maxDonate = 0
    -- for k, v in pairs(DonateCfg) do
    --     if v.donateNum > maxDonate then
    --         maxDonate = v.donateNum
    --     end
    --     self.contributionConf.donateMap[v.baseLevel] = v.donateNum
    -- end
    -- self.contributionConf.maxDonate = maxDonate

    self.rollInfos = {}--跑马灯滚动消息
    --self.topStationInfos = {}--情报站置顶消息
    self.stationInfos = {}--情报站消息

    self:registerMsgEvent()

    self:reset()
end

function AgoraDataMgr:registerMsgEvent()

    TFDirector:addProto(s2c.CHRISTMAS_OPEN_PANEL, self, self.onRespAgoraMain)
    -------情报站
    TFDirector:addProto(s2c.CHRISTMAS_NOTIFY_WORLD_NOTICE, self, self.onRespAddStationInfo)
    -------合成
    TFDirector:addProto(s2c.CHRISTMAS_OPEN_COMPOSE_PANEL, self, self.onRespAgoraComposeMain)
    TFDirector:addProto(s2c.CHRISTMAS_UPDATE_COMPOSE_INFO, self, self.onRespAgoraStartCompose)
    TFDirector:addProto(s2c.CHRISTMAS_GET_COMPOSE_PRIZE, self, self.onRespGetAgoraCompseReward)
    -------贡献度
    -- TFDirector:addProto(s2c.CHRISTMAS_UPDATE_CONTRIBUTION, self, self.onRespUpdateContribution)

    -------战斗关卡信息
    TFDirector:addProto(s2c.CHRISTMAS_RESP_CHRISTMAS_DUNGEONS, self, self.onRespDungeonsInfo)
    TFDirector:addProto(s2c.CHRISTMAS_RESP_CHRISTMAS_MAP_BOX, self, self.onRespGetMapBox)
    TFDirector:addProto(s2c.CHRISTMAS_CHRISTMAS_INVADE_REFRESH, self, self.onRespRefreshInvade)
    TFDirector:addProto(s2c.CHRISTMAS_CHRISTMAS_LEVEL_REFRESH, self, self.onRespRefreshLevels)

    --抽奖记录
    TFDirector:addProto(s2c.CHRISTMAS_RESP_SUMMON, self, self.onRespChrismasRecord)
    TFDirector:addProto(s2c.CHRISTMAS_ADD_SUMMON_RECORD, self, self.onRespUpdateChrismasRecord)
end

function AgoraDataMgr:onLogin()

    self:initLocalSaveLevel()
    self:initLocalPlayedPlot()

    return {}
end

-----------------------------------------
--6601
function AgoraDataMgr:sendGetAgoraMain()
    TFDirector:send(c2s.CHRISTMAS_OPEN_PANEL, {})
end

--合成 6602
function AgoraDataMgr:sendStartAgoraCompose(id, count)
    local msg = {
        id,
        count
    }
    TFDirector:send(c2s.CHRISTMAS_REQ_COMPOSE, msg)
end

--6603
function AgoraDataMgr:sendGetAgoraComposeReward(id)
    local msg = {
        id
    }
    TFDirector:send(c2s.CHRISTMAS_GET_COMPOSE_PRIZE, msg)
end

--6607
function AgoraDataMgr:sendGetAgoraComposeData()
    TFDirector:send(c2s.CHRISTMAS_OPEN_COMPOSE_PANEL, {})
end
-----------------------------------------

-----------------------------------------
--6601
function AgoraDataMgr:onRespAgoraMain(event)
    local data = event.data
    -- dump(data, "6601")
    -- self:updateAgoraMain({level=data.level or 1, contribution=data.contribution or 0})
     Utils:openView("agora.AgoraMainView")

     local isFirstOpen = self:isFirstOpenAgora()
     if isFirstOpen then
         self:saveHaveOpenAgora()
         DatingDataMgr:startDating(9101005)
     end
end

--6604
-- function AgoraDataMgr:onRespUpdateContribution(event)
--     local data = event.data
--     dump(data, "6604")
--     self:updateAgoraMain({level=data.level or 1, contribution=data.contribution or 0})
--     EventMgr:dispatchEvent(EV_AGORA.ContributionUpdate)
-- end

--6605
function AgoraDataMgr:onRespAddStationInfo(event)
    local data = event.data
    dump(data, "6605")
    local infos = {type = data.type, pname = data.playerName or "", param = data.param or 0, reward=data.composePrizes or {}}
    if data.type == EC_AgoraStationInfoType.LotteryLucky then
        infos.type = EC_AgoraStationInfoType.LotteryLuckyTop
        table.insert(self.rollInfos, infos)
        EventMgr:dispatchEvent(EV_AGORA.ShowRollInfo)
    end
    table.insert(self.stationInfos, infos)
    if #self.stationInfos > self.maxPlayerStationInfos then
        table.remove(self.stationInfos, 1)
    end
    EventMgr:dispatchEvent(EV_AGORA.UpdateStationPlayerInfos)
end

--合成
--6607 合成主数据
function AgoraDataMgr:onRespAgoraComposeMain(event)
    local data = event.data
    dump(data, "6607")
    local compose = data.composeInfo or {}
    local agoraComposeTb = TabDataMgr:getData("ChristmasCompose")
    self.agoraComposeData = {}
    for k, v1 in pairs(agoraComposeTb) do
        local dt = {needItem=clone(v1.needItem), targetItem=v1.compoesItem, status=EC_AgoraComposeStatus.CantCompose, id=tonumber(k), count=1, countDown=0}
        local find = false
        for i, v2 in ipairs(compose) do
            if v2.id == k then
                find = true
                dt.count = v2.composeTimes
                dt.countDown = v2.countDown
                if v2.countDown > 0 then
                    dt.status = EC_AgoraComposeStatus.CountDown
                else
                    dt.status = EC_AgoraComposeStatus.CanGet
                end
                break
            end
        end
        if not find then
            local count1 = GoodsDataMgr:getItemCount(dt.needItem[1][1])
            local count2 = GoodsDataMgr:getItemCount(dt.needItem[2][1])
            if count1 >= dt.needItem[1][2] and count2 >= dt.needItem[2][2] then
                dt.status = EC_AgoraComposeStatus.CanCompose
                dt.count = 1
            end
        end
        table.insert(self.agoraComposeData, dt)
    end
    -- self:sortAgoraComposeData()
    EventMgr:dispatchEvent(EV_AGORA.ComposeStatusUpdate)
end

--6602 开始合成
function AgoraDataMgr:onRespAgoraStartCompose(event)
    local data = event.data
    dump(data, "6602")
    local compose = data.composeInfo
    for i, v in ipairs(self.agoraComposeData) do
        if v.id == compose.id then
            v.count = compose.composeTimes
            v.countDown = compose.countDown
            if compose.countDown > 0 then
                v.status = EC_AgoraComposeStatus.CountDown
            else
                v.status = EC_AgoraComposeStatus.CanGet
            end
            -- self:sortAgoraComposeData()
            EventMgr:dispatchEvent(EV_AGORA.ComposeStatusUpdate)
            break
        end
    end
end

--6603 领取合成
function AgoraDataMgr:onRespGetAgoraCompseReward(event)
    local data = event.data
    dump(data, "6603")
    local id = data.id
    for i, v in ipairs(self.agoraComposeData) do
        if v.id == id then
            v.count = 1
            local count1 = GoodsDataMgr:getItemCount(v.needItem[1][1])
            local count2 = GoodsDataMgr:getItemCount(v.needItem[2][1])
            if count1 >= v.needItem[1][2] and count2 >= v.needItem[2][2] then
                v.status = EC_AgoraComposeStatus.CanCompose
            else
                v.status = EC_AgoraComposeStatus.CantCompose
            end
            -- self:sortAgoraComposeData()
            EventMgr:dispatchEvent(EV_AGORA.ComposeStatusUpdate)
            break
        end
    end
    local rewards = data.rewards or {}
    local extrewards = data.extRewards or {}
    if #extrewards > 0 then
        local view = requireNew("lua.logic.agora.AgoraComposeGetItems"):new(rewards, extrewards)
        AlertManager:addLayer(view,AlertManager.BLOCK_AND_GRAY_CLOSE)
        AlertManager:show()
    else
        Utils:showReward(rewards)
    end    
end

-----------------------------------------

function AgoraDataMgr:openAgoraMain()
     self:sendGetAgoraMain()
     self:sendGetAgoraComposeData()
    -- Utils:openView("agora.AgoraMainView")
end

function AgoraDataMgr:updateAgoraMain(param)
    self.agoraMainData.level = param.level or self.agoraMainData.level
    self.agoraMainData.allContribution = param.contribution or self.agoraMainData.allContribution
    self.agoraMainData.selfContribution = GoodsDataMgr:getItemCount(EC_SItemType.AGORA_DONATE)
end

function AgoraDataMgr:setComposeCountDown(id, coutdown)
    for i, v in ipairs(self.agoraComposeData) do
        if v.id == id then
            v.countDown = coutdown
        end
    end
end

function AgoraDataMgr:sortAgoraComposeData()
    table.sort(self.agoraComposeData, function(a, b)
        if a.status == b.status then
            if a.status == EC_AgoraComposeStatus.CountDown then
                return a.countDown < b.countDown
            end
            return a.id < b.id
        end
        return a.status > b.status
    end)
end

--情报站指定消息更新检测，客户端本地检测
function AgoraDataMgr:agoraTopNoticeUpdateCheck()
    local serverTime = ServerDataMgr:getServerTime()
    local year, month, day = Utils:getDate(serverTime)
    local hour, min, sec = Utils:getTime(serverTime)
    local daysec = hour*3600 + min*60 + sec
    --self.topStationInfos = {}
    local topNotices = {}
    local infotb = TabDataMgr:getData("ChristmasInfo")
    for k, v in pairs(infotb) do
        local startDate = string.split(v.beginDate, "/")
        local endDate = string.split(v.endDate, "/")
        local beginY, beginM, beginD = tonumber(startDate[1]), tonumber(startDate[2]), tonumber(startDate[3])
        local endY, endM, endD = tonumber(endDate[1]), tonumber(endDate[2]), tonumber(endDate[3])
        -- if self:getAgoraLv() == v.baseLevel then
            if (beginY <= year and endY >= year) and (beginM <= month and endM >= month) and (beginD <= day and endD >= day) then
                if daysec >= v.beginSec and daysec <= v.endSec then
                    table.insert(topNotices, {id = v.id, stringid = v.infoId})
                end
            end
        -- end
    end
    table.sort(topNotices, function(a, b)
        return a.id < b.id
    end)
    EventMgr:dispatchEvent(EV_AGORA.UpdateStationTopInfos, topNotices)
end

--集会所情报站消息最大个数
function AgoraDataMgr:getMaxPlayerStationInfosCount()
   return self.maxPlayerStationInfos
end

--function AgoraDataMgr:getTopStationInfos()
--    return self.topStationInfos
--end

function AgoraDataMgr:getFrontRollInfo()
    if #self.rollInfos > 0 then
        return self.rollInfos[1]
    end
    return nil
end

function AgoraDataMgr:removeFrontRollInfo()
    table.remove(self.rollInfos, 1)
end

function AgoraDataMgr:getStationInfo()
    return self.stationInfos
end

function AgoraDataMgr:getStationInfoByIdx(idx)
    local info = self.stationInfos[idx]
    return info
end

function AgoraDataMgr:getComposeData()
    return self.agoraComposeData
end

function AgoraDataMgr:getComposeCost(id)
    for i, v in ipairs(self.agoraComposeData) do
        if v.id == id then
            return v.needItem[1][2], v.needItem[2][2]
        end
    end
    return 0, 0
end

-- --获取集会所等级
-- function AgoraDataMgr:getAgoraLv()
--     return self.agoraMainData.level or 0
-- end

-- function AgoraDataMgr:getAgoraContribution()
--     return self.agoraMainData.allContribution or 0
-- end

-- function AgoraDataMgr:getAgoraSelfContribution()
--     return self.agoraMainData.selfContribution or 0
-- end

-- --获取贡献度最大值
-- function AgoraDataMgr:getAgoraMaxContribution()
--     return self.contributionConf.maxDonate
-- end

-- function AgoraDataMgr:getAgoraContributionByLevel(level)
--     return self.contributionConf.donateMap[level]
-- end

-- --获取对应等级所需贡献度范围
-- function AgoraDataMgr:getAgoraCurLevelContributionRage(curlv)
--     local nextlv = curlv + 1
--     local curDonate = 0
--     if curlv > 0 then
--         curDonate= self.contributionConf.donateMap[curlv]
--     end
--     local nextDonate = 0
--     if not self.contributionConf.donateMap[nextlv] then
--         nextDonate = self.contributionConf.maxDonate
--     else
--         nextDonate = self.contributionConf.donateMap[nextlv]
--     end
--     return curDonate, nextDonate
-- end

--是否有可领取合成奖励
function AgoraDataMgr:isHaveComposeCanGet()
    for i, v in ipairs(self.agoraComposeData) do
        local canget = tobool(v.status == EC_AgoraComposeStatus.CanGet)
        if canget then
            return true
        end
    end
    return false
end

--
function AgoraDataMgr:isFirstOpenAgora()
    local playerId = MainPlayer:getPlayerId()
    local isFirstOpen = UserDefalt:getStringForKey("isFirstOpenAgora"..playerId)
    if isFirstOpen == "" then
        return true
    end
    return false
end

function AgoraDataMgr:saveHaveOpenAgora()
    local playerId = MainPlayer:getPlayerId()
    UserDefalt:setStringForKey("isFirstOpenAgora"..playerId, 1)
    UserDefalt:flush()
end

-----------------------------------------战斗分割线-----------------------------------

function AgoraDataMgr:setChooseMode(mode)
    self.fightMode = mode
end

function AgoraDataMgr:getChooseMode()
    return self.fightMode
end

function AgoraDataMgr:setCurChapterId(chapterId)
    self.curChapterId = chapterId
end

function AgoraDataMgr:getCurChapterId()
    return self.curChapterId
end

function AgoraDataMgr:isAfterFight()
    return self.isFinishFight
end

function AgoraDataMgr:setAfterFightFlag(flag)
    self.isFinishFight = flag
end

function AgoraDataMgr:chapterIsOpen(chapterId)

    local openTime
    local openTimes = self:getLevelOpenTime()
    for k,v in ipairs(openTimes) do
        if v.id == chapterId and (not v.isEnemy) then
            openTime = v.time
        end
    end

    if not openTime then
        return
    end

    local serverTime = ServerDataMgr:getServerTime()
    return serverTime >= openTime,openTime
end

function AgoraDataMgr:getFightLevelInfoById(levelId)
    --return FubenDataMgr:getLevelInfo(levelId)
    if not self.levelInfos then
        return
    end
    return self.levelInfos[levelId]
end

function AgoraDataMgr:getDungeonInfo()
    return self.dungeonInfos
end

function AgoraDataMgr:getInvadeInfo()
    return self.enemy
end

--获取战斗章节基础信息
function AgoraDataMgr:getChapterCfgInfo(charpterId)

    if not charpterId then
        return self.ChristmasDungenCfg
    end
    return self.ChristmasDungenCfg[charpterId]
end

function AgoraDataMgr:getInvadeCfgInfo(invadeId)

    if not invadeId then
        return self.ChristmasInvadeCfg
    end
    return self.ChristmasInvadeCfg[invadeId]
end

function AgoraDataMgr:getBoxPosition(locationId)

    local boxInfo = self.ChristmasMapCfg[locationId]
    if not boxInfo then
        return
    end

    local pos = ccp(boxInfo.pos[1],boxInfo.pos[2])
    return pos
end

function AgoraDataMgr:getEventInfo(eventId)

    local eventInfo = self.ChristmasMapgiftCfg[eventId]
    if not eventInfo then
        return
    end

    return eventInfo.pic
end


--判断章节是否被入侵
function AgoraDataMgr:isInvadeChapter(charpterId)

    local chapterInfo = self.ChristmasDungenCfg[charpterId]
    if not chapterInfo then
        return
    end

    local isInvaded = false
    for k,v in ipairs(chapterInfo.storydungenID) do
        local isInvadedLevel = self:isInvadedLevel(v)
        if isInvadedLevel then
            isInvaded = true
            break
        end
    end

    return isInvaded
end

--是否是被入侵(是返回对应的入侵关卡ID)
function AgoraDataMgr:isInvadedLevel(levelId)

    if not self.enemyOccupyInfo then
        return
    end

    local enabled, preIsOpen, levelIsOpen = self:checkLevelEnabled(levelId)
    if not enabled then
        return
    end

    local invadeLevelId = self.enemyOccupyInfo[levelId]
    if not invadeLevelId then
        return
    end

    local remainCnt = self:getRemainCount(invadeLevelId)
    if remainCnt <= 0 then
        return
    end

    return invadeLevelId
end

function AgoraDataMgr:getRemainCount(levelCid)

    local levelCfg = FubenDataMgr:getLevelCfg(levelCid)
    if not levelCfg then
        return
    end

    local remainCount = levelCfg.fightCount
    local levelInfo = self.levelInfos[levelCid]
    if levelInfo and levelInfo.fightCount then
        local buyCount = levelInfo.buyCount or 0
        remainCount = math.max(0, levelCfg.fightCount + buyCount - levelInfo.fightCount)
    end
    return remainCount

end

function AgoraDataMgr:isPassPlotLevel(levelCid)

    if not self.levelInfos then
        return
    end

    local levelInfo = self.levelInfos[levelCid]
    local isPass = tobool(levelInfo and levelInfo.win)
    return isPass
end

function AgoraDataMgr:isPassAllStoryLevel(chapterId)

    local chapterInfo = self:getChapterCfgInfo(chapterId)
    if not chapterInfo then
        return
    end

    local isPassAll = true
    for k,levelCid in ipairs(chapterInfo.storydungenID) do
        local isPass = self:isPassPlotLevel(levelCid)
        if not isPass then
            isPassAll = false
            break
        end
    end

    return isPassAll
end

function AgoraDataMgr:checkLevelEnabled(levelId)
    local enabled = false
    local levelIsOpen = false
    local preIsOpen = false
    if self:isPassPlotLevel(levelId) then
        enabled = true
        levelIsOpen = true
        preIsOpen = true
    else
        local levelCfg = FubenDataMgr:getLevelCfg(levelId)
        preIsOpen = true
        local preLevelId = levelCfg.preLevelId
        for i, v in ipairs(preLevelId) do
            preIsOpen = preIsOpen and self:isPassPlotLevel(v)
            if not preIsOpen then
                break
            end
        end
        levelIsOpen = MainPlayer:getPlayerLv() >= levelCfg.playerLv
        enabled = preIsOpen and levelIsOpen
    end
    return enabled, preIsOpen, levelIsOpen
end

--记录播放剧情
function AgoraDataMgr:savePlotDialogue(saveId,playTime)
    --timeString 2018|00|00

    if self.playedPlot[saveId] and self.playedPlot[saveId] == playTime then
        return
    end

    if not self.playedPlot[saveId] then
        self.playedPlot[saveId] = playTime
    end

    if self.playedPlot[saveId] ~= playTime then
        self.playedPlot[saveId] = playTime
    end

    local str = "|"
    for k,v in pairs(self.playedPlot) do
        str = str..k.."-"..playTime.."|"
    end

    local playerId = MainPlayer:getPlayerId()
    UserDefalt:setStringForKey("agoraPlot"..playerId,str)
    UserDefalt:flush()
end

function AgoraDataMgr:initLocalPlayedPlot()

    self.playedPlot = {}
    local playerId = MainPlayer:getPlayerId()
    local agoraPlotStr = UserDefalt:getStringForKey("agoraPlot"..playerId)
    if agoraPlotStr ~= "" then
        local agoraPlot = string.split(agoraPlotStr,"|")
        for k,info in ipairs(agoraPlot) do
            local saveInfo =  string.split(info,"-")
            local saveId,playTime = saveInfo[1],saveInfo[2]
            self.playedPlot[saveId] = playTime
        end
    end
end

function AgoraDataMgr:isPlayedPlot(saveId)

    if not self.playedPlot then
        return
    end
    return self.playedPlot[saveId]
end


--记录选项
function AgoraDataMgr:initLocalSaveLevel()

    self.lastChallengeLevel = {}
    local playerId = MainPlayer:getPlayerId()
    local agoraLevelStr = UserDefalt:getStringForKey("agoraLevel"..playerId)
    if agoraLevelStr ~= "" then
        local levelInfos = string.split(agoraLevelStr,"|")
        for k,info in ipairs(levelInfos) do
            local saveInfo =  string.split(info,"-")
            local chapterId,levelId = tonumber(saveInfo[1]),tonumber(saveInfo[2])
            if chapterId and levelId then
                self.lastChallengeLevel[chapterId] = levelId
            end
        end
    end

end

function AgoraDataMgr:saveChallengeChoose(chapterId,levelId)

    if self.lastChallengeLevel[chapterId] and
            self.lastChallengeLevel[chapterId] == levelId then
        return
    end

    if not self.lastChallengeLevel[chapterId] then
        self.lastChallengeLevel[chapterId] = levelId
    end

    if self.lastChallengeLevel[chapterId] ~= levelId then
        self.lastChallengeLevel[chapterId] = levelId
    end

    local str = "|"
    for k,v in pairs(self.lastChallengeLevel) do
        str = str..chapterId.."-"..levelId.."|"
    end

    local playerId = MainPlayer:getPlayerId()
    UserDefalt:setStringForKey("agoraLevel"..playerId,str)
    UserDefalt:flush()

end

function AgoraDataMgr:getLastChooseLevelId(chapterId)

    return self.lastChallengeLevel[chapterId]
end

function AgoraDataMgr:getMapBox()
    return self.mapBoxes
end

--获取章节开放时间(包括入侵的)
function AgoraDataMgr:getLevelOpenTime()
    return self.openTime
end

function AgoraDataMgr:isSummoned(itemId)

    return self.summonRecord[itemId]
end

----战斗关卡信息
function AgoraDataMgr:onRespDungeonsInfo(event)

    local data = event.data
    if not data then
        return
    end

    dump(data)

    ----所有关卡信息
    self.levelInfos = {}
    if data.levelInfos then
        for k,v in ipairs(data.levelInfos) do
            local levelId = v.cid
            self.levelInfos[levelId] = v
        end
    end

    ----章节配置信息
    self.openTime = {}
    self.dungeonInfos = data.dungeonInfos

    if self.dungeonInfos then
        for k,v in ipairs(self.dungeonInfos) do
            table.insert(self.openTime,{id = v.dungeonId,isEnemy = false,time = v.time})
        end
    end

    ----被入侵的关卡信息
    self.enemy = data.enemy
    self.enemyOccupyInfo = {}
    if self.enemy then
        if self.enemy.invadeId > 0 then
            table.insert(self.openTime,{id = self.enemy.invadeId,isEnemy = true,time = self.enemy.time})
            if self.ChristmasInvadeCfg[self.enemy.invadeId] then
                local invadedungenInfo = self.ChristmasInvadeCfg[self.enemy.invadeId].invadedungenID
                for originalCid,invadeId in pairs(invadedungenInfo) do
                    self.enemyOccupyInfo[originalCid] =invadeId
                end
            end
        end
    end

    dump(self.enemyOccupyInfo)
    ----地图宝箱信息
    self.mapBoxes = data.mapBoxes

    Utils:openView("agora.AgoraFightZone")
end

----领取宝箱
function AgoraDataMgr:onRespGetMapBox(event)

    local data = event.data
    if not data then
        return
    end

    self.mapBoxes = data.mapBoxes
    local rewards = data.rewards
    Utils:showReward(rewards)
    EventMgr:dispatchEvent(EV_AGORA.MapBoxUpdate)
end

----入侵关卡刷新
function AgoraDataMgr:onRespRefreshInvade(event)

    local data = event.data
    if not data then
        return
    end

    if not self.openTime then
        self.openTime = {}
    end

    dump(data)
    if self.openTime then
        for i=#self.openTime,1,-1 do
            local info = self.openTime[i]
            if info.isEnemy then
                table.remove(self.openTime, i)
            end
        end
    end

    self.enemy = data.enemy
    self.enemyOccupyInfo = {}
    if self.enemy then
        if self.enemy.invadeId > 0 then
            table.insert(self.openTime,{id = self.enemy.invadeId,isEnemy = true,time = self.enemy.time})
            if self.ChristmasInvadeCfg[self.enemy.invadeId] then
                local invadedungenInfo = self.ChristmasInvadeCfg[self.enemy.invadeId].invadedungenID
                for originalCid,invadeId in pairs(invadedungenInfo) do
                    self.enemyOccupyInfo[originalCid] =invadeId
                end
            end
        end
    end

    EventMgr:dispatchEvent(EV_AGORA.UpdateLevelInfo)

end

----战斗完成之后刷新
function AgoraDataMgr:onRespRefreshLevels(event)

    local data = event.data
    if not data then
        return
    end

    local curLevelCid = data.curLevel.cid
    self.levelInfos[data.curLevel.cid] = data.curLevel

    self:setAfterFightFlag(true)

    local fightMode = self:getChooseMode()
    if fightMode and fightMode == 2 then

        local curChapterId = self:getCurChapterId()
        local chapterInfo = self:getChapterCfgInfo(curChapterId)
        if chapterInfo and chapterInfo.challangedungenID then
            local curLevelIndex
            local challengelevels = chapterInfo.challangedungenID
            for k,v in ipairs(challengelevels) do
                if curLevelCid and curLevelCid == v then
                    curLevelIndex = k
                    break
                end
            end
            local nextLevelCid = challengelevels[curLevelIndex+1]
            if nextLevelCid then
                local enabled, preIsOpen, levelIsOpen = self:checkLevelEnabled(nextLevelCid)
                if enabled then
                    self:saveChallengeChoose(curChapterId,nextLevelCid)
                end
            end
        end
    end

end

function AgoraDataMgr:onRespChrismasRecord(event)

    local data = event.data
    if not data then
        return
    end
    dump(data.records)
    self.summonRecord = {}
    if data.records then
        for k,v in ipairs(data.records) do
            self.summonRecord[v] = 1
        end
    end
    EventMgr:dispatchEvent(EV_CHRISMAS_SUMMON_RECORD)
end

function AgoraDataMgr:onRespUpdateChrismasRecord(event)

    local data = event.data
    if not data then
        return
    end
    dump(data.records)
    self.summonRecord = self.summonRecord or {}
    if data.records then
        for k,v in ipairs(data.records) do
            self.summonRecord[v] = 1
        end
    end
    EventMgr:dispatchEvent(EV_CHRISMAS_SUMMON_RECORD)

end

return AgoraDataMgr:new()