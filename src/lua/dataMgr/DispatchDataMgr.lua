
local BaseDataMgr = import(".BaseDataMgr")
local DispatchDataMgr = class("DispatchDataMgr", BaseDataMgr)

function DispatchDataMgr:init()
    TFDirector:addProto(s2c.HERO_DISPATCH_RESP_HERO_DISPATCH_INFO, self, self.onRecvHeroDispatchInfo)
    TFDirector:addProto(s2c.HERO_DISPATCH_RESP_ADD_HERO_DISPATCH, self, self.onRecvDispatchBack)
    TFDirector:addProto(s2c.HERO_DISPATCH_RESP_CANCEL_HERO_DISPATCH, self, self.onRecvCancelDispatch)
    TFDirector:addProto(s2c.HERO_DISPATCH_RESP_FINISH_HERO_DISPATCH, self, self.onRecvGetDispatchReward)
    TFDirector:addProto(s2c.HERO_DISPATCH_RESP_DISPATCH_EXHAUSTIONS, self, self.onRefreshHeroExhaustions)
    TFDirector:addProto(s2c.HERO_DISPATCH_RESP_DISPATCH_HERO_STAR, self, self.onRefreshHeroStars)
    TFDirector:addProto(s2c.HERO_DISPATCH_RESP_HERO_DISPATCHES, self, self.onRefreshDispatchInfo)
    TFDirector:addProto(s2c.HERO_DISPATCH_RESP_RESET_DISPATCH_HERO, self, self.onRefreshTypeInfos)
    TFDirector:addProto(s2c.HERO_DISPATCH_RESP_EXPEDITE_DISPATCH, self, self.onSpeedupOver)

    
    --本地数据
    self.hangupLevelMap = {}
    self.hangup_ = TabDataMgr:getData("Hangup")
    self.hangupSystem_ = TabDataMgr:getData("HangupSystem")
    self.heroDispatch_ = TabDataMgr:getData("HeroDispatch")
    self.theaterBossCids = {}
    for k,v in pairs(self.hangupSystem_) do
        self.hangupLevelMap[v.relatedDungeonLevel] = v
        if v.functionType == EC_DISPATCHType.THEATER then
            table.insert(self.theaterBossCids, v.relatedDungeonLevel)
        end
    end

    self.heroDispatchData = {}
    self.heroExhaustion = {}
    self.dispatchTypeHero = {}
    self.heroStars = {}
    self.rewardBuff = {}
end

function DispatchDataMgr:reset()
    
end

function DispatchDataMgr:onLogin()
    TFDirector:send(c2s.HERO_DISPATCH_REQ_HERO_DISPATCH_INFO, {})
    TFDirector:send(c2s.HERO_DISPATCH_REQ_DISPATCH_HERO_STAR, {})
    return {s2c.HERO_DISPATCH_RESP_HERO_DISPATCH_INFO, s2c.HERO_DISPATCH_RESP_DISPATCH_HERO_STAR}
end

function DispatchDataMgr:onLoginOut()
    self:reset()
end

--请求派遣挂机
function DispatchDataMgr:reqAddHeroDispatch(dungeonType, dungeonCids, times)
    local dungeonData = {}
    for i, v in ipairs(dungeonCids) do
        table.insert(dungeonData,{v,times[i] or 0})
    end
    local msg = {dungeonType, dungeonData}
    TFDirector:send(c2s.HERO_DISPATCH_REQ_ADD_HERO_DISPATCH , msg)
end

--取消挂机
function DispatchDataMgr:reqCancelHeroDispatch(dungeonType)
    TFDirector:send(c2s.HERO_DISPATCH_REQ_CANCEL_HERO_DISPATCH , {dungeonType})
end

function DispatchDataMgr:ReqResetDispatchHero(dungeonType, heros)
    TFDirector:send(c2s.HERO_DISPATCH_REQ_RESET_DISPATCH_HERO, {dungeonType, heros})
end

--领取挂机奖励
function DispatchDataMgr:reqFinishHeroDispatch()
    self.rewardBuff = {}
    for k, v in pairs(self.heroDispatchData) do
        for i, info in ipairs(v.dungeonInfo) do
            if info.awardCount > 0 then
                local heros = self:getDispathedHeros(v.dungeonType)
                local buff = self:getHeroAddBuff(info.dungeonCid, heros)
                self.rewardBuff[v.dungeonType] = buff
            end
        end
    end
    TFDirector:send(c2s.HERO_DISPATCH_REQ_FINISH_HERO_DISPATCH, {})
end

function DispatchDataMgr:reqSpeedUpDispatchInfo(dungeonType, dungeonCid)
    TFDirector:send(c2s.HERO_DISPATCH_REQ_EXPEDITE_DISPATCH, {dungeonType,dungeonCid})
end

function DispatchDataMgr:reqHeroDispatchInfo()
    TFDirector:send(c2s.HERO_DISPATCH_REQ_HERO_DISPATCH_INFO, {})
end

function DispatchDataMgr:reqHeroStars()
    TFDirector:send(c2s.HERO_DISPATCH_REQ_DISPATCH_HERO_STAR, {})
end

--挂机数据
function DispatchDataMgr:onRecvHeroDispatchInfo(event)
    local data = event.data
    self.heroDispatchData = {}
    self.heroExhaustion = {}
    self.dispatchTypeHero = {}
    if data.dispatches then
        for i,info in ipairs(data.dispatches) do
            self.heroDispatchData[info.dungeonType] = info
        end
    end
    if data.exhaustions then
        for i,info in ipairs(data.exhaustions) do
            self.heroExhaustion[info.hero] = info
        end
    end
    if data.heroes then
        for i,info in ipairs(data.heroes) do
            self.dispatchTypeHero[info.type] = info
        end
    end
end

function DispatchDataMgr:onRecvDispatchBack(event)
    local data = event.data
    EventMgr:dispatchEvent(EV_FUBEN_ADD_DISPATCH_DANGUP, data)
end

function DispatchDataMgr:onRecvCancelDispatch(event)
    local data = event.data
    if data.rewards then

    end
    EventMgr:dispatchEvent(EV_FUBEN_CANCEL_DISPATCH_DANGUP, data)
end

function DispatchDataMgr:onRecvGetDispatchReward(event)
    local data = event.data
    if data.rewards then
        Utils:openView("dispatch.DispatchRewardShowLayer",data, clone(self.rewardBuff)) 
    end
    EventMgr:dispatchEvent(EV_FUBEN_GET_DISPATCH_DANGUP_REWARD, data)
end

function DispatchDataMgr:onRefreshHeroExhaustions(event)
    local data = event.data
    self.heroExhaustion = {}
    if data.exhaustions then
        for i,info in ipairs(data.exhaustions) do
            self.heroExhaustion[info.hero] = info
        end
    end
end

function DispatchDataMgr:onRefreshHeroStars(event)
    local data = event.data
    self.heroStars = {}
    if data.stars then
        for i,info in ipairs(data.stars) do
            self.heroStars[info.hero] = info
        end
    end
end

function DispatchDataMgr:onRefreshDispatchInfo(event)
    local data = event.data
    self.heroDispatchData = {}
    if data.dispatches then
        for i,info in ipairs(data.dispatches) do
            self.heroDispatchData[info.dungeonType] = info
        end
    end
end

function DispatchDataMgr:onRefreshTypeInfos(event)
    local data = event.data
    self.dispatchTypeHero = {}
    if data.heroes then
        for i, info in ipairs(data.heroes) do
            self.dispatchTypeHero[info.type] = info
        end
    end
    EventMgr:dispatchEvent(EV_FUBEN_ADD_DISPATCH_HEROS)
end

function DispatchDataMgr:onSpeedupOver(event)
    local data = event.data
    if data.rewards then
        Utils:showReward(data.rewards)
    end
    EventMgr:dispatchEvent(EV_FUBEN_SPEEDUP_DISPATCH)
end

function DispatchDataMgr:getDispatchs(dungeonType)
    if dungeonType then
        return self.heroDispatchData[dungeonType]
    else
        return self.heroDispatchData
    end
end

function DispatchDataMgr:getDispatchingDungeonInfo(dungeonType)
    local dispatchs = self.heroDispatchData[dungeonType]
    if dispatchs then
        for i,v in ipairs(dispatchs.dungeonInfo) do
            if v.eTime > ServerDataMgr:getServerTime() then
                return v
            end
        end
    end
end

function DispatchDataMgr:getDispatchsDungeonInfo(dungeonType, dungeonCid)
    local dispatchs = self.heroDispatchData[dungeonType]
    if dispatchs then
        for i,v in ipairs(dispatchs.dungeonInfo) do
            if v.dungeonCid == dungeonCid then
                return v
            end
        end
    end
end

function DispatchDataMgr:getDispatchHangUpCfgs(dungeonType)
    local levelCids = FubenDataMgr:getDispatchLevel(dungeonType)
    local cfgs = {}
    if dungeonType == EC_DISPATCHType.SPRITE and self:getDispatchs(dungeonType) then 
        local dispatchs = self:getDispatchs(dungeonType)
        for i,info in ipairs(dispatchs.dungeonInfo) do
            for k, v in pairs(self.hangupSystem_) do
                if v.id == info.dungeonCid then
                    table.insert(cfgs,v)
                end
            end
        end
    else
        for i,v in ipairs(levelCids) do
            if self.hangupLevelMap[v] then
                table.insert(cfgs, self.hangupLevelMap[v])
            end
        end
    end
    
    if dungeonType == EC_DISPATCHType.DATING then
        for k, v in pairs(self.hangupSystem_) do
            if v.functionType == EC_DISPATCHType.DATING then
                table.insert(cfgs,v)
            end
        end
    end
    return cfgs
end

function DispatchDataMgr:getDispathedHeros(dungeonType)
    local heros = {}
    local info = self.dispatchTypeHero[dungeonType]
    if info then
        heros = clone(info.heroes)
        return heros
    end

    return heros
end

function DispatchDataMgr:getHeroDispatchType(heroId)
    for k, info in pairs(self.dispatchTypeHero) do
        for i, v in ipairs(info.heroes) do
            if v == heroId then
                return tonumber(k)
            end
        end
    end
end

function DispatchDataMgr:getHeroExhaustion(heroId)
    for k, v in pairs(self.heroExhaustion) do
        if heroId == v.hero then
            return v.exhaustion
        end
    end
    return self.heroDispatch_[heroId].restorationCap
end

function DispatchDataMgr:getHeroFetterList(heroId)
    return self.heroDispatch_[heroId].fetterList
end

function DispatchDataMgr:getHeroStars(heroId)
    for k, v in pairs(self.heroStars) do
        if heroId == v.hero then
            return v.star or 0
        end
    end
    return 0
end

function DispatchDataMgr:getHangUpCfg(cid)
    return self.hangupSystem_[cid]
end

function DispatchDataMgr:getEffectSuitIds(dungeonType)
    local effectIds = {}
    local heroIds = self:getDispathedHeros(dungeonType)
    for i,v in ipairs(heroIds) do
        local cfg = self.heroDispatch_[v]
        local fetterList = cfg.fetterList
        for j, buffId in ipairs(cfg.fetterList) do
            local state = false
            local buffCfg = TabDataMgr:getData("HangupBuff",buffId)
            if #buffCfg.fetterIcon > 0 then
                for m, typeId in ipairs(buffCfg.fetterIcon) do
                    if typeId == dungeonType then
                        state = true
                        break
                    end
                end
            else
                state = true
            end
            if state then
                for k, star in pairs(buffCfg.role) do
                    local heroId = tonumber(k)
                    local haveHero = false
                    for idx,id in ipairs(heroIds) do
                        if id == heroId then
                            haveHero = true
                            break
                        end
                    end
                    if not haveHero or self:getHeroStars(heroId) < star then
                        state = false
                    end
                end
            end
            if state then
                effectIds[buffId] = 1
            end
        end
    end
    local sortIds = {}
    for k, v in pairs(effectIds) do
        table.insert(sortIds,tonumber(k))
    end
    return sortIds
end

function DispatchDataMgr:checkHaustionsEnough(dungeonType, dungeonCids)
    local dispatchHeros = self:getDispathedHeros(dungeonType)
    local cost = 0
    for i, v in ipairs(dungeonCids) do
        local cfg = self.hangupSystem_[v]
        cost = cost + cfg.consumptionFatigue
    end
    for i, heroId in ipairs(dispatchHeros) do
        local exhaustion = self:getHeroExhaustion(heroId)
        if exhaustion < cost then
            return false
        end
    end
    return true
end

function DispatchDataMgr:getEnableDisPatchTimes(dungeonType, levelIds)
    local dispatchHeros = self:getDispathedHeros(dungeonType)
    local times = {}
    local totalExhaustion = 0
    local totalCostNum = 0
    for i, levelId in ipairs(levelIds) do
        local hangUpCfg = self.hangupLevelMap[levelId]
        local levelCfg = FubenDataMgr:getLevelCfg(levelId)
        local remainCount = 0
        local costId = 0
        local costNum = 0
        if dungeonType == EC_DISPATCHType.DAILY then
            remainCount = FubenDataMgr:getDailyRemainFightCount(levelCfg.levelGroupId)
            costId = levelCfg.cost[1][1]
            costNum = levelCfg.cost[1][2]
        elseif dungeonType == EC_DISPATCHType.SPRITE then
            remainCount = FubenDataMgr:getSpriteChallengeRemainCount()
            costId = levelCfg.cost[1][1]
            costNum = levelCfg.cost[1][2]
        elseif dungeonType == EC_DISPATCHType.THEATER then
            remainCount = GoodsDataMgr:getItemCount(EC_SItemType.THEATER_COUNT)
        elseif dungeonType == EC_DISPATCHType.TEAM then
            local teamLevelStat = TeamFightDataMgr:getTeamLevelStat()
            levelCfg = TeamFightDataMgr:getTeamLevelCfg(0, levelId)
            for k,v in pairs(levelCfg.fightCost) do
                costId = tonumber(k)
                costNum = v
            end
            if teamLevelStat[levelId].stat ~= 1 then
                remainCount = 0
            else
                remainCount = teamLevelStat[levelId].remainCount
            end
        elseif dungeonType == EC_DISPATCHType.DATING then
            remainCount = DatingDataMgr:getDayDatingTimes()
            costId = 500024
            costNum = 20
        end
        if remainCount > 0 then
            exhaustionCost = hangUpCfg.consumptionFatigue
            local effecSuitIds = self:getEffectSuitIds(dungeonType)
            for i,buffId in ipairs(effecSuitIds) do
                local buffCfg = TabDataMgr:getData("HangupBuff",buffId)
                for j,effectId in ipairs(buffCfg.fetterEffect) do
                    local effectCfg = TabDataMgr:getData("HangupResult",effectId)
                    if effectCfg.valid == 1 and effectCfg.typesFetters == 2 then
                        exhaustionCost = (1 - effectCfg.fetterParameter * 0.0001) * exhaustionCost
                        break
                    end
                end
                
            end
            local exhaustionTimes = #dispatchHeros > 0 and 9999 or 0
            for j, heroId in ipairs(dispatchHeros) do
                local exhaustion = self:getHeroExhaustion(heroId)
                local subexhaustion = (exhaustion - totalExhaustion)
                if subexhaustion > 0 then
                    exhaustionTimes = math.min(exhaustionTimes, math.floor(subexhaustion/ exhaustionCost))
                else
                    exhaustionTimes = 0
                end
                if exhaustionTimes <= 0 then
                    break
                end
            end
            remainCount = math.min(remainCount, exhaustionTimes)
            
            if costId > 0 then
                local hasNum = GoodsDataMgr:getItemCount(costId)
                local subCost = hasNum - totalCostNum
                if subCost > 0 then
                    local num = math.floor(subCost / costNum)
                    remainCount = math.min(remainCount, num)
                else
                    remainCount = 0
                end
            end
            totalExhaustion = totalExhaustion + (remainCount * exhaustionCost)
            totalCostNum = totalCostNum + (remainCount * costNum)
            times[levelId] = remainCount
        else
            times[levelId] = 0
        end
    end

    return times
end

function DispatchDataMgr:checkHeroInHangUp(heroId)
    for k, info in pairs(self.dispatchTypeHero) do
        for i,v in ipairs(info.heroes) do
            if v == heroId then
                return true
            end
        end
    end
    return false
end

function DispatchDataMgr:checkEnableGetDispatchRewards(dungeonType)
    local dispatchs = self.heroDispatchData[dungeonType]
    if dispatchs then
        for i,info in ipairs(dispatchs.dungeonInfo) do
            if info.awardCount > 0 then
                return true
            end
        end
    end
    return false
end

function DispatchDataMgr:checkHasRewards()
    for k, dispatchs in pairs(self.heroDispatchData) do
        for i,info in ipairs(dispatchs.dungeonInfo) do
            if info.awardCount > 0 then
                return true
            end
        end
    end
    return false
end

function DispatchDataMgr:checkIsDispatching(dungeonType, levelGroupCid)
    if self.heroDispatchData[dungeonType] then
        if levelGroupCid and dungeonType == EC_DISPATCHType.DAILY then
            local dispatchs = self.heroDispatchData[dungeonType]
            for i, v in ipairs(dispatchs.dungeonInfo) do
                local levelId = self.hangupSystem_[v.dungeonCid].relatedDungeonLevel
                local groupId = FubenDataMgr:getLevelCfg(levelId).levelGroupId
                if groupId == levelGroupCid then
                    Utils:showTips(213505)
                    return true
                end
            end
        else
            Utils:showTips(213505)
            return true
        end
    end
    return false
end

function DispatchDataMgr:getHeroAddBuff(dungeonCid, heroIds)
    local fightingCapacity = self.hangupSystem_[dungeonCid].fightingCapacity
    local star = 0
    for i, v in ipairs(heroIds) do
        star = star + self:getHeroStars(v)
    end
    if star > 0 and star <= 9 then
        return fightingCapacity[star] / 100
    end
    return 0
end

function DispatchDataMgr:checkDiapatchEnable(dungeonType)
    local hangUpCfgs = self:getDispatchHangUpCfgs(dungeonType)
    local enable = true
    if #hangUpCfgs > 0 then
        for k, v in pairs(hangUpCfgs) do
            if not self:checkEnableDiapatch(dungeonType, v.relatedDungeonLevel) then
                enable = false
                break
            end
        end
    else
        enable = false
    end
    return enable
end

function DispatchDataMgr:checkEnableDiapatch(dungeonType, levelId)
    local state = true
    local levelCfg = FubenDataMgr:getLevelCfg(levelId)
    if dungeonType == EC_DISPATCHType.DAILY then
        local remainCount = FubenDataMgr:getDailyRemainFightCount(levelCfg.levelGroupId)
        if remainCount < 1 then
            state = false
        end
    elseif dungeonType == EC_DISPATCHType.SPRITE then
        local remainCount = FubenDataMgr:getSpriteChallengeRemainCount()
        if remainCount <= 0 then
            state = false
        end
    elseif dungeonType == EC_DISPATCHType.THEATER then
        local count = GoodsDataMgr:getItemCount(EC_SItemType.THEATER_COUNT)
        if count <= 0 then
            state = false
        end
    elseif dungeonType == EC_DISPATCHType.TEAM then
        local teamLevelStat = TeamFightDataMgr:getTeamLevelStat()
        local levelCfg = TeamFightDataMgr:getTeamLevelCfg(0, levelId)
        local costId = 0
        local costNum = 0
        local lestRefreshTimes = levelCfg.fightCount - teamLevelStat[levelId].fightCount
        for k,v in pairs(levelCfg.fightCost) do
            costId = k
            costNum = v
        end
        local hasNum = GoodsDataMgr:getItemCount(costId)
        if teamLevelStat[levelId].stat ~= 1 then
            state = false
        elseif hasNum < costNum then
            state = false
        elseif teamLevelStat[levelId].remainCount < 1 then
            state = false
        end
    elseif dungeonType == EC_DISPATCHType.DATING then
        if DatingDataMgr:getDayDatingTimes() == 0 then
            state = false
        end
    end

    return state
end

function DispatchDataMgr:checkHeroInDispatching(heroId)
    for k, info in pairs(self.dispatchTypeHero) do
        for i, id in ipairs(info.heroes) do
            if heroId == id and self:getDispatchingDungeonInfo(k) then
                return true
            end
        end
    end
end

function DispatchDataMgr:getAllHeroSortIds(starSort, exhaustionSort)
    local heroIds = {}
    HeroDataMgr:resetShowList(true,false);
    local count = HeroDataMgr:getShowCount()
    for i=1,count do
        local heroId = HeroDataMgr:getSelectedHeroId(i)
        table.insert(heroIds, heroId)
    end
    local unuse = {}
    local noStars = {}
    local useing = {}
    local unlock = {}
    for i,v in ipairs(heroIds) do
        if not HeroDataMgr:getIsHave(v) then
            table.insert(unlock, v)
        else
            if self:checkHeroInHangUp(v) then
                table.insert(useing, v)
            else
                if self:getHeroStars(v) < 1 then
                    table.insert(noStars, v)
                else
                    table.insert(unuse, v)
                end
            end
        end
    end
    if starSort then
        local function starSort(a,b)
            local cfga = HeroDataMgr:getHero(a)
            local cfgb = HeroDataMgr:getHero(b)
            local astar = self:getHeroStars(a)
            local bstar = self:getHeroStars(b)
            if astar == bstar then
                return cfga.site < cfgb.site
            end
            return astar > bstar
        end
        table.sort(unuse,starSort)
        table.sort(noStars,starSort)
        table.sort(useing,starSort)
        table.sort(unlock,starSort)
    elseif exhaustionSort then
        local function exhaustSort(a,b)
            local exhaustiona = self:getHeroExhaustion(a)
            local exhaustionb = self:getHeroExhaustion(b)
            if exhaustiona == exhaustionb then
                local cfga = HeroDataMgr:getHero(a)
                local cfgb = HeroDataMgr:getHero(b)
                return cfga.site < cfgb.site
            end
            return exhaustiona > exhaustionb
        end
        table.sort(unuse,exhaustSort)
        table.sort(noStars,exhaustSort)
        table.sort(useing,exhaustSort)
        table.sort(unlock,exhaustSort)
    else
        local function siteSort(a,b)
            local cfga = HeroDataMgr:getHero(a)
            local cfgb = HeroDataMgr:getHero(b)
            return cfga.site < cfgb.site
        end
        table.sort(unuse,siteSort)
        table.sort(noStars,siteSort)
        table.sort(useing,siteSort)
        table.sort(unlock,siteSort)
    end
    heroIds = {}
    for i,v in ipairs(unuse) do
        table.insert(heroIds, {v,0})
    end
    for i,v in ipairs(useing) do
        table.insert(heroIds, {v,1})
    end
    for i,v in ipairs(noStars) do
        table.insert(heroIds, {v,0})
    end
    for i,v in ipairs(unlock) do
        table.insert(heroIds, {v,2})
    end
    return heroIds
end

return DispatchDataMgr:new()
