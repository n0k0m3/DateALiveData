
local BaseDataMgr = import(".BaseDataMgr")
local CityDataMgr = class("CityDataMgr", BaseDataMgr)

function CityDataMgr:init()
    TFDirector:addProto(s2c.BUILDING_GET_BUILDING_INFO, self, self.onRecvBuildInfo)
    TFDirector:addProto(s2c.BUILDING_UNLOCK_BUILDING, self, self.onRecvUnlockBuild)
    TFDirector:addProto(s2c.BUILDING_BUILDING_UPGRADE, self, self.onRecvBeginUpgradeBuild)
    TFDirector:addProto(s2c.BUILDING_UPDATE_BUILDING_INFO, self, self.onRecvUpdateBuildInfo)
    TFDirector:addProto(s2c.BUILDING_WORK, self, self.onRecvUpdateBuildInfo)
    TFDirector:addProto(s2c.BUILDING_GET_WORK_REWARD, self, self.onRecvWorkingReward)
    TFDirector:addProto(s2c.BUILDING_TRIGGER_WORK_EVENT, self, self.onRecvWorkingEvent)
    TFDirector:addProto(s2c.BUILDING_RESP_UPGRADE_FUL, self, self.onRecvUpgradeConfirm)

    TFDirector:addProto(s2c.BUILDING_RESPGET_FOODBASE_INFO, self, self.onRecvGetFoodBaseInfo)
    TFDirector:addProto(s2c.BUILDING_RESP_COOK_FOODBASE, self, self.onRecvCookFood)
    TFDirector:addProto(s2c.BUILDING_RESP_UPLOAD_QTE_INTEGRAL, self, self.onRecvQte)
    TFDirector:addProto(s2c.BUILDING_RESP_GET_FOOD_BASE_AWARD, self, self.onRecvGetFoodBaseAward)

    self.workingRole_ = {}
    self.cityInfo_ = {}
    self.buildInfo_ = {}
    self.workingLog_ = {}
    
    -- 城市本地数据
    self.city_ = {}
    self.cityMap_ = TabDataMgr:getData("City")
    for k, v in pairs(self.cityMap_) do
        table.insert(self.city_, k)
    end

    -- 建筑本地数据
    self.buildMap_ = TabDataMgr:getData("Build")
    self.build_ = {}
    local cityBuild = {}
    local orderBuild = {}
    for _, v in pairs(self.buildMap_) do
        table.insert(orderBuild, v)
    end
    table.sort(orderBuild, function(a, b)
                   if a.order == b.order then
                       return a.level < b.level
                   end
                   return a.order > b.order
    end)
    for k, v in pairs(orderBuild) do
        cityBuild[v.cityId] = cityBuild[v.cityId] or {}
        local perCityBuild = cityBuild[v.cityId]
        perCityBuild[v.buildId] = perCityBuild[v.buildId] or {}
        local levelBuild = perCityBuild[v.buildId]
        table.insert(levelBuild, v.id)
    end
    for cityId, levelBuild in pairs(cityBuild) do
        local perLevelBuild = {}
        local keys = table.keys(levelBuild)
        table.sort(keys, function(a, b)
                       local buildCfgA = self.buildMap_[levelBuild[a][1]]
                       local buildCfgB = self.buildMap_[levelBuild[b][1]]
                       return buildCfgA.order > buildCfgB.order
        end)
        for i, build in ipairs(keys) do
            table.insert(perLevelBuild, levelBuild[build])
        end
        cityBuild[cityId] = perLevelBuild
    end
    self.build_ = cityBuild

end

function CityDataMgr:reset()
    self.cityInfo_ = {}
    self.buildInfo_ = {}
    self.workingLog_ = {}
    self.workingRole_ = {}
    dump("CityDataMgr:reset()")
end

function CityDataMgr:onLogin()
    --[[
    TFDirector:send(c2s.BUILDING_GET_ALL_UNLOCK_BUILDING, {})
    return {
        s2c.BUILDING_GET_BUILDING_INFO
    }]]
end

function CityDataMgr:onLoginOut()
    self:reset();
end

function CityDataMgr:onEnterMain()

end

function CityDataMgr:getCityCfg(cityId)
    if cityId then
        return self.cityMap_[cityId]
    else
        return self.cityMap_
    end
end

function CityDataMgr:getCity()
    return self.city_
end

function CityDataMgr:getCityBuild(cityId)
    return self.build_[cityId] or {}
end

function CityDataMgr:isCityUnlock(cityId)
    local unlock = false
    local cityBuild = self:getCityBuild(cityId)
    for _, builds in ipairs(cityBuild) do
        for _, build in ipairs(builds) do
            if self.buildInfo_[build] then
                unlock = true
                break
            end
        end
        if unlock then break end
    end
    return unlock
end

function CityDataMgr:isCityLocalUnlock(cityId)
    local unlock = false
    if self:isCityUnlock(cityId) then return end

    local buildId
    local cityBuild = self.build_[cityId]
    for _, builds in ipairs(cityBuild) do
        for _, build in ipairs(builds) do
            if self:isBuildLocalUnlock(build) then
                buildId = build
                unlock = true
                break
            end
        end
        if unlock then break end
    end

    return unlock, buildId
end

function CityDataMgr:isBuildUnlock(buildId)
    local unlock = not (not self.buildInfo_[buildId])
    return unlock
end

function CityDataMgr:isBuildLocalUnlock(buildId)
    local cfg = self.buildMap_[buildId]
    local unlock = true
    for k, v in pairs(cfg.openType) do
        local condType = v[1]
        local condValue = v[2]
        if condType == EC_BuildUnlockCond.LEVEL then
            unlock = unlock and MainPlayer:getPlayerLv() >= condValue
        elseif condType == EC_BuildUnlockCond.CHAPTER then
            unlock = unlock and FubenDataMgr:isPassPlotLevel(condValue)
        end
        if not unlock then break end
    end

    return unlock
end

function CityDataMgr:getBuildCanUpGradeByCond(buildId, index)
    local buildCfg = self:getBuildCfg(buildId)
    local upType = buildCfg.upType[index]
    local condType = upType[1]
    local condValue = upType[2]
    local condUnlock = true
    if condType == EC_BuildUpgradeCond.LEVEL then
        condUnlock = condUnlock and MainPlayer:getPlayerLv() >= condValue
    elseif condType == EC_BuildUpgradeCond.CHAPTER then
        condUnlock = condUnlock and FubenDataMgr:isPassPlotLevel(condValue)
    end
    return condUnlock
end

function CityDataMgr:getBuildCanUpGrade(buildId)
    local cfg = self.buildMap_[buildId]
    local condUnlock = true
    for i, v in ipairs(cfg.upType) do
        condUnlock = self:getBuildCanUpGradeByCond(buildId, i)
        if not condUnlock then break end
    end

    local costUnlock = true
    for i, v in ipairs(cfg.consume) do
        if not GoodsDataMgr:currencyIsEnough(v[1], v[2]) then
            costUnlock = false
            break
        end
    end

    return condUnlock, costUnlock
end

function CityDataMgr:getBuildCfg(buildId)
    if buildId then
        return self.buildMap_[buildId]
    else
        return self.buildMap_
    end
end

function CityDataMgr:getBuild(cityId)
    local cityBuild = {}
    local builds = self:getCityBuild(cityId)
    for i, v in ipairs(builds) do
        local buildId
        for _, id in ipairs(v) do
            if self:isBuildUnlock(id) then
                buildId = id
                break
            end
        end
        if not buildId then
            buildId = v[1]
        end
        table.insert(cityBuild, buildId)
    end
    return cityBuild
end

function CityDataMgr:getBuildInfo(buildId)
    if buildId then
        return self.buildInfo_[buildId]
    else
        return self.buildInfo_
    end
end

function CityDataMgr:getLevelBuild(buildId)
    local buildCfg = self:getBuildCfg(buildId)
    local cityId = buildCfg.cityId
    local build = self.build_[cityId]
    local levelBuild = {}
    for i, v in ipairs(build) do
        if table.indexOf(v, buildId) ~= -1 then
            levelBuild = v
            break
        end
    end
    return levelBuild
end

function CityDataMgr:getBuildByLevel(buildId, level)
    local levelBuild = self:getLevelBuild(buildId)
    return levelBuild[level]
end

function CityDataMgr:getBuildUnlockCondText(buildId)
    local buildCfg = self.buildMap_[buildId]

    local cond = buildCfg.openType
    local tips = buildCfg.openTips
    local text = ""

    for i = 1, math.min(#cond, #tips) do
        local condType = cond[i][1]
        local condValue = cond[i][2]
        local tip = tips[i]

        if #text > 0 then
            text = text .. "\n"
        end
        if condType == EC_BuildUnlockCond.LEVEL then
            local t = TextDataMgr:getText(tip, condValue)
            text = text .. t
        elseif condType == EC_BuildUnlockCond.CHAPTER then
            local chapterCfg = FubenDataMgr:getChapter(condValue)
            local t = TextDataMgr:getText(tip, TextDataMgr:getText(chapterCfg.orderName))
            text = text .. t
        end
    end

    return text
end

function CityDataMgr:remedyBuildInfo(buildId)
    -- local buildInfo = self.buildInfo_[buildId]
    -- if buildInfo.state == EC_BuildState.UPGRADE_FINISH or buildInfo.state == EC_BuildState.WORK_FINISH then
    --     buildInfo.state = EC_BuildState.FREE
    -- end
end

function CityDataMgr:isWorkCondUnlock(workingRole, condType, condValue)
    local unlock = false
    if condType == EC_BuildWorkCond.COND_1 then
        unlock = #workingRole >= condValue
    elseif condType == EC_BuildWorkCond.COND_2 then
        for i, roleSid in ipairs(workingRole) do
            local roleId = HeroDataMgr:getHeroIdByRoleId(roleSid)
            if roleId == condValue then
                unlock = true
                break
            end
        end
    elseif condType == EC_BuildWorkCond.COND_3 then
        if #workingRole > 0 then
            unlock = true
            for i, roleSid in ipairs(workingRole) do
                local roleId = RoleDataMgr:getRoleIdBySid(roleSid)
                local favor = RoleDataMgr:getFavor(roleId)
                if favor < condValue then
                    unlock = false
                    break
                end
            end
        end
    elseif condType == EC_BuildWorkCond.COND_4 then
        if #workingRole > 0 then
            unlock = true
            for i, roleSid in ipairs(workingRole) do
                local roleId = RoleDataMgr:getRoleIdBySid(roleSid)
                local mood = RoleDataMgr:getMood(roleId)
                if mood < condValue then
                    unlock = false
                    break
                end
            end
        end
    end

    return unlock
end

function CityDataMgr:getRoleIsWorking(roleSid)
    local isWorking = (table.indexOf(self.workingRole_, roleSid) ~= -1)
    return isWorking
end

function CityDataMgr:isShowRedPoint(cityId)
    local build = self:getBuild(cityId)
    local show = false
    for i, v in ipairs(build) do
        local buildInfo = self:getBuildInfo(v)
        if buildInfo and buildInfo.state == EC_BuildState.WORK_FINISH then
            show = true
            break
        end
    end
    return show
end

function CityDataMgr:isShowRedPointInMainView()
    local city = self:getCity(EC_CityEntranceType.NORMAL)
    local show = false
    for i, v in ipairs(city) do
        if self:isShowRedPoint(v) then
            show = true
            break
        end
    end
    return show
end

-----------------------------------------------------------

function CityDataMgr:sendUnlockBuild(buildId)
    TFDirector:send(c2s.BUILDING_UNLOCK_BUILDING, {buildId})
end

function CityDataMgr:sendUpgradeBuild(buildId)
    TFDirector:send(c2s.BUILDING_BUILDING_UPGRADE, {buildId})
end

function CityDataMgr:sendWorking(buildId, workingHero)
    local heroId = {}
    TFDirector:send(c2s.BUILDING_WORK, {buildId, workingHero})
end

function CityDataMgr:sendGetWorkingReward(buildId)
    TFDirector:send(c2s.BUILDING_GET_WORK_REWARD, {buildId})
end

function CityDataMgr:sendUpgradeConfirm(buildId)
    TFDirector:send(c2s.BUILDING_REQ_UPGRADE_FUL, {buildId})
end

function CityDataMgr:onRecvBuildInfo(event)
    local data = event.data
    self.buildInfo_ = {}
    if not data.buidingInfos then return end

    for i, v in ipairs(data.buidingInfos) do
        self:__updateBuildInfo(v)
    end
end

function CityDataMgr:onRecvUnlockBuild(event)
    local data = event.data
    local buildInfo = data.buildingInfos
    if not buildInfo then return end

    local unlockBuild = {}
    for i, v in ipairs(buildInfo) do
        self:__updateBuildInfo(v)
        table.insert(unlockBuild, v.cid)
    end

    EventMgr:dispatchEvent(EV_CITY_UNLOCKBUILD_SUCCESS, unlockBuild)
end

function CityDataMgr:onRecvBeginUpgradeBuild(event)
    local data = event.data
    local buildInfo = data.buildingInfo
    if not buildInfo then return end

    self:__updateBuildInfo(buildInfo)
    EventMgr:dispatchEvent(EV_CITY_BUILD_BEGIN_UPGRADE, buildInfo.cid)
end

function CityDataMgr:__updateWorkingRole()
    self.workingRole_ = {}
    for k, v in pairs(self.buildInfo_) do
        table.insertTo(self.workingRole_, v.roleIds)
    end
end

function CityDataMgr:__updateBuildInfo(buildInfo)
    self.buildInfo_[buildInfo.cid] = buildInfo
    buildInfo.logs = buildInfo.logs or {}
    buildInfo.roleIds = buildInfo.roleIds or {}
    self:__updateWorkingRole()
end

function CityDataMgr:onRecvUpdateBuildInfo(event)
    local data = event.data
    local buildInfo = data.buildingInfo
    if not buildInfo then return end

    self:__updateBuildInfo(buildInfo)

    if buildInfo.state == EC_BuildState.UPGRADE_FINISH then    -- 升级完成
        local buildCfg = self.buildMap_[buildInfo.cid]
        local preLevelBuildId = self:getBuildByLevel(buildInfo.cid, buildCfg.level - 1)
        self.buildInfo_[preLevelBuildId] = nil
        buildInfo = self:getBuildInfo(buildInfo.cid)
        buildInfo.state = EC_BuildState.FREE
        self:__updateWorkingRole()
        EventMgr:dispatchEvent(EV_CITY_BUILD_UPGRADEFINISH, buildInfo.cid)
    elseif buildInfo.state == EC_BuildState.WORK_FINISH then    -- 打工完成
        EventMgr:dispatchEvent(EV_CITY_WORKING_FINISH, buildInfo.cid)
    elseif buildInfo.state == EC_BuildState.WORK then
        EventMgr:dispatchEvent(EV_CITY_WORKING_BEGIN, buildInfo.cid)
    else
        EventMgr:dispatchEvent(EV_CITY_BUILD_UPDATE, buildInfo.cid)
    end
end

function CityDataMgr:onRecvWorkingReward(event)
    local data = event.data

    local buildInfo = data.buildingInfo
    if buildInfo then
        self:__updateBuildInfo(buildInfo)
    end

    local reward = data.rewards or {}
    EventMgr:dispatchEvent(EV_CITY_WORKING_GETREWARD, buildInfo.cid, reward)
end

function CityDataMgr:onRecvWorkingEvent(event)
    local data = event.data

    local buildInfo = self.buildInfo_[data.cid]
    table.insert(buildInfo.logs, data.log)

    EventMgr:dispatchEvent(EV_CITY_WORKING_EVENT, data.cid, data.log)
end

function CityDataMgr:onRecvUpgradeConfirm(event)
    local data = event.data
end
return CityDataMgr:new()
