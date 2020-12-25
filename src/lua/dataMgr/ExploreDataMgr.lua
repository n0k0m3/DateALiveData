local BaseDataMgr = import(".BaseDataMgr")
local ExploreDataMgr = class("ExploreDataMgr", BaseDataMgr)

function ExploreDataMgr:ctor()
    self:init()

end

function ExploreDataMgr:registerMsgEvent()

    TFDirector:addProto(s2c.FIGHT_RESP_EXPLORE_SYS_FIGHT, self, self.onExploreFightData)

    ---探索部分
    TFDirector:addProto(s2c.EXPLORE_EXPLORE_GET_INFOS, self, self.onRecvAllExploreInfo)
    TFDirector:addProto(s2c.EXPLORE_CABIN, self, self.onRecvOneCabinInfo)
    TFDirector:addProto(s2c.EXPLORE_AFK_ACTIVITY, self, self.onRecvExploreInfo)
    TFDirector:addProto(s2c.EXPLORE_EXPLORE_EVENT_GET_AWARD, self, self.onRecvGetEventAward)
    TFDirector:addProto(s2c.EXPLORE_EXPLORE_EVENT_ADD_TIMES, self, self.onRecvAddEventProgress)
    TFDirector:addProto(s2c.EXPLORE_EXPLORE_EVENT_START_BATTLE, self, self.onRecvBossFight)
    TFDirector:addProto(s2c.EXPLORE_EXPLORE_GET_AWARD, self, self.onRecvGetExploreAward)
    TFDirector:addProto(s2c.EXPLORE_AFK_NATION, self, self.onRecvExploreNation)
    TFDirector:addProto(s2c.EXPLORE_AFK_CITY, self, self.onRecvExploreCity)
    TFDirector:addProto(s2c.EXPLORE_RES_REFRESH_AFK_AWARD, self, self.onRecvReachExploreDot)
    TFDirector:addProto(s2c.EXPLORE_CHANGE_NATION_OR_CITY, self, self.onRecvSwichNationOrCity)
    TFDirector:addProto(s2c.EXPLORE_QUICK_EXPLORATION, self, self.onRecvQuickExplore)
    TFDirector:addProto(s2c.EXPLORE_RES_ATTR_INFO, self, self.onRecvShipAttrsInfo)
    TFDirector:addProto(s2c.ACTIVITY_RESP_EXPLORE_ACTIVITY_RANK, self, self.onRecvExploreActivityRank)
    TFDirector:addProto(s2c.EXPLORE_EXPLORE_UPDATE_SKIN, self,self.onRevSkinChange)

    -------------------------------舱室培养协议--------------------------------------------

    TFDirector:addProto(s2c.EXPLORE_EXPLORE_INFO, self, self.onRecvExploreCabins)
    TFDirector:addProto(s2c.EXPLORE_CABIN_UPGRADE, self, self.onRecvExploreCabinUpgrade)
    TFDirector:addProto(s2c.EXPLORE_EQUIP, self, self.onRecvExploreEquipUpgrade)
    TFDirector:addProto(s2c.EXPLORE_EXPLORE_TASK_GET_AWARD, self, self.onRecvExploreTaskGetReward)
    TFDirector:addProto(s2c.EXPLORE_AFK_TASK, self, self.onRecvExploreTaskRefresh)
    TFDirector:addProto(s2c.EXPLORE_EXPLORE_TECH_INFOS, self, self.onRecvExploreTechInfos)
    TFDirector:addProto(s2c.EXPLORE_EXPLORE_TECH_UPGRADE, self, self.onRecvExploreTechUpgrade)
    TFDirector:addProto(s2c.EXPLORE_EXPLORE_TREASURE_COMPOSE, self, self.onRecvExploreTreasureCompose)
    TFDirector:addProto(s2c.EXPLORE_EXPLORE_TREASURE_STAR_UP, self, self.onRecvExploreTreasureStarUp)
    TFDirector:addProto(s2c.EXPLORE_EXPLORE_TREASURE_EQUIP, self, self.onRecvExploreTreasureEquip)
    TFDirector:addProto(s2c.EXPLORE_RES_SET_SHAPE, self, self.onResSetShapeMsg)
    TFDirector:addProto(s2c.EXPLORE_SHIP_ATTR, self, self.onResShipAttr)
    TFDirector:addProto(s2c.EXPLORE_EXPLORE_TREASURE_SKILL, self, self.onResTresureSkills)

    TFDirector:addProto(s2c.EXPLORE_RES_EXPLORE_TASK_PLAN, self, self.onResExploreTaskPlan) -- 一键派遣任务缓存
    TFDirector:addProto(s2c.EXPLORE_RES_GET_ALL_AFK_TASK_AWARD, self, self.onResAllAfkTaskAward) -- 一键领取

end

function ExploreDataMgr:init()

    self:reset()
    self:registerMsgEvent()

    self.AfkActivity = TabDataMgr:getData("AfkActivity")

    self.afkNationChapter = {}
    self.afkNationMap_ = TabDataMgr:getData("AfkNationChapter")

    self.AfkCityCfg = TabDataMgr:getData("AfkCity")
    self.AfkCityGroup_ = {}
    for k,v in pairs(self.AfkCityCfg) do
        if not self.AfkCityGroup_[v.nationID] then
            self.AfkCityGroup_[v.nationID] = {}
        end
        table.insert(self.AfkCityGroup_[v.nationID],v)
    end

    self.AfkMonster = TabDataMgr:getData("AfkMonster")

    self.AfkEvent = TabDataMgr:getData("AfkEvent")

    self.afkCountCfg = {}
    local countCfg = TabDataMgr:getData("AfkCount")
    for k,v in pairs(countCfg) do
        if not self.afkCountCfg[v.chapterID] then
            self.afkCountCfg[v.chapterID] = {}
        end

        if not self.afkCountCfg[v.chapterID][v.itemType] then
            self.afkCountCfg[v.chapterID][v.itemType] = {}
        end

        table.insert(self.afkCountCfg[v.chapterID][v.itemType],v)
    end


    self.AfkKnowledgeCfg = TabDataMgr:getData("AfkKnowledge")
    self.nationKnowLedge = {}
    for k,v in pairs(self.AfkKnowledgeCfg) do
        if v.type == 0 then
            if not self.nationKnowLedge[v.chapterID] then
                self.nationKnowLedge[v.chapterID] = {}
            end
            if not self.nationKnowLedge[v.chapterID][v.position] then
                self.nationKnowLedge[v.chapterID][v.position] = {}
            end
            self.nationKnowLedge[v.chapterID][v.position][v.level] = v
        end
    end
end

function ExploreDataMgr:reset()

    self.allInfo = {}

    self.openNation = {}

    self.cityData = {}
    self.allFoundEvent = {}
    self.knowledgeMap_ = {}
    self.firstPlay = false
    self.exploreAward = {}
    self.totalRewardCount = 0
    self.fishEvent = {}
    self.tresureSkills = {}
    -- self.cabinsData = {}
    -- self.shipInfo = nil
end

function ExploreDataMgr:onLogin()

    self:SEND_EXPLORE_REQ_EXPLORE_INFO()
    self:Send_ExploreTechInfos()
    self:Send_GetAllExploreInfo()
    return {s2c.EXPLORE_EXPLORE_INFO,s2c.EXPLORE_EXPLORE_TECH_INFOS,s2c.EXPLORE_EXPLORE_GET_INFOS}
end

function ExploreDataMgr:getKnowledgeList( type )
    -- body
    local list = {}
    for k,v in pairs(self.AfkKnowledgeCfg) do
        if v.type == type then
            table.insert(list, v)
        end
    end

    table.sort(list,function ( v1, v2 )
        -- body
        return v1.id < v2.id
    end)
    return list
end

function ExploreDataMgr:getNationKnowledge(nationCid,position)
    if not position then
        return self.nationKnowLedge[nationCid]
    end

    return self.nationKnowLedge[nationCid][position]
end

function ExploreDataMgr:getKnowledgeCfg(knowledgeCid)
    return self.AfkKnowledgeCfg[knowledgeCid]
end

function ExploreDataMgr:getAfkNationList(activityId)
    if not activityId then
        return
    end
    return self.AfkActivity[activityId].countryList
end

function ExploreDataMgr:getAfkNationCfg(nationCid)
    return self.afkNationMap_[nationCid]
end

function ExploreDataMgr:getAfkCityCfg(cityCid)
    return  self.AfkCityCfg[cityCid]
end

function ExploreDataMgr:getAfkCityGroup(nationCid)
    return self.AfkCityGroup_[nationCid]
end

function ExploreDataMgr:getAfkMonsterCfg(monsterCid)
    return self.AfkMonster[monsterCid]
end

function ExploreDataMgr:getAfkEventCfg(eventCid)
    return self.AfkEvent[eventCid]
end

function ExploreDataMgr:getAfkCountCfg(nationCid,itemType)
    if not self.afkCountCfg[nationCid] then
        return
    end
    if not itemType then
        return self.afkCountCfg[nationCid]
    end
    return self.afkCountCfg[nationCid][itemType]
end

function ExploreDataMgr:isopenNation(nationCid)
    local index = table.indexOf(self.openNation,nationCid)
    return index ~= -1
end

function ExploreDataMgr:getCityEventData(cityCid)
    return self.cityData[cityCid]
end

function ExploreDataMgr:getFoundEventData(eventCid)
    return self.allFoundEvent[eventCid]
end

function ExploreDataMgr:isFinishEvent(eventCid)
    return self.fishEvent[eventCid]
end

function ExploreDataMgr:getKnowledgeState(techType,techId)
    if not self.knowledgeMap_[techType] then
        return
    end
    if not techId then
        return self.knowledgeMap_[techType]
    end
    return self.knowledgeMap_[techType][techId]
end

function ExploreDataMgr:test()
    return self.knowledgeMap_
end

function ExploreDataMgr:getCurExploreCity()
    return self.localCity
end

function ExploreDataMgr:getCurNation()
    return self.localNation
end

function ExploreDataMgr:isFirstPlay()
    return self.firstPlay
end

function ExploreDataMgr:getCityExploreProgress()
    return self.startTime,self.cityAwardTimes,self.exploreSpeed,self.lastPassTime
end

function ExploreDataMgr:getMaxCapacity()
    return self.capacity
end

function ExploreDataMgr:getCurProgress(nationCid,itemType,itemParamTab)

    local curProgress = 0
    for k,v in ipairs(itemParamTab) do
        curProgress = curProgress + self:getSingleProgress(nationCid,itemType,v)
    end
    return curProgress
end

function ExploreDataMgr:getSingleProgress(nationCid,itemType,itemParam)
    if itemType == 1 then
        local state = self:isFinishEvent(itemParam)
        local count = state and 1 or 0
        return count
    elseif itemType == 2 then
        local lv = 0
        local knowledgeTab = self:getNationKnowledge(nationCid,itemParam) or {}
        for k,v in ipairs(knowledgeTab) do
            local state = self:getKnowledgeState(v.type,v.id)
            if state == 1 then
                lv = v.level
            end
        end
        return lv
    elseif itemType == 3 then
        return GoodsDataMgr:getItemCount(itemParam)
    end
end

---是否完成探索统计
function ExploreDataMgr:isFinishExploreCount(nationCid,cfg)
    local count = self:getCurProgress(nationCid,cfg.itemType,cfg.itemParam)
    return count >= cfg.count and 1 or 0
end

function ExploreDataMgr:getExploreAward()
    return self.exploreAward,self.totalRewardCount
end

function ExploreDataMgr:getExploreExAward()
    return self.exploreExAward
end

function ExploreDataMgr:getQuickExploreTimes()
    return self.quickTimes or 0
end

function ExploreDataMgr:getCurActivityId()
    return self.localActivity
end

function ExploreDataMgr:getCurActivityInfoById(activityId)
    return self.allInfo[activityId]
end

function ExploreDataMgr:onExploreFightData(event)
    local data = event.data
    EventMgr:dispatchEvent("explore_battle_test", data)
end

function ExploreDataMgr:Send_GetAllExploreInfo()
    TFDirector:send(c2s.EXPLORE_EXPLORE_GET_INFOS, {})
end

----请求探索信息
function ExploreDataMgr:Send_GetExploreInfo(activityId)
    self.exploreAward = {}
    TFDirector:send(c2s.EXPLORE_EXPLORE_ACTIVITY_INFO, {activityId})
end

---增加进度事件的进度
function ExploreDataMgr:Send_AddEventProgress(activityId,nationId,cityId,eventId)
    TFDirector:send(c2s.EXPLORE_EXPLORE_EVENT_ADD_TIMES, {activityId,nationId,cityId,eventId})
end

---领取事件奖励
function ExploreDataMgr:Send_GetEventReward(activityId,nationId,cityId,eventId,treasureId)
    TFDirector:send(c2s.EXPLORE_EXPLORE_EVENT_GET_AWARD, {activityId,nationId,cityId,eventId,treasureId})
end

---开始战斗
function ExploreDataMgr:Send_StartBossFight(activityId,nationId,cityId,eventId)
    print(activityId,nationId,cityId,eventId)
    TFDirector:send(c2s.EXPLORE_EXPLORE_EVENT_START_BATTLE, {activityId,nationId,cityId,eventId})
end

function ExploreDataMgr:Send_GetExploreReward(activityId)
    TFDirector:send(c2s.EXPLORE_EXPLORE_GET_AWARD, {activityId})
end

function ExploreDataMgr:Send_ExploreNation(activityId,nationCid)
    TFDirector:send(c2s.EXPLORE_EXPLORE_NATION_INFO, {activityId,nationCid})
end

function ExploreDataMgr:Send_ExploreCity(activityId,nationCid,cityCid)
    TFDirector:send(c2s.EXPLORE_EXPLORE_CITY_INFO, {activityId,nationCid,cityCid})
end

---达到探索结点发请求
function ExploreDataMgr:Send_reachExploreDot(activityId)
    TFDirector:send(c2s.EXPLORE_REQ_REFRESH_AFK_AWARD, {activityId})
end

---switchType:0 切换城市 , 1 切换国家
function ExploreDataMgr:Send_switchNationOrCity(switchType,nationId,cityId,activityId)
    TFDirector:send(c2s.EXPLORE_REQ_CHANGE_NATION, {switchType,nationId,cityId,activityId})
end

function ExploreDataMgr:Send_QuickExplore(activityId)
    TFDirector:send(c2s.EXPLORE_REQ_QUICK_EXPLORATION, {activityId})
end

function ExploreDataMgr:Send_GetShipAttrsInfo(activityId, nationId,cityId)
    TFDirector:send(c2s.EXPLORE_REQ_ATTR_INFO, {activityId, nationId,cityId})
end

function ExploreDataMgr:Send_GetActivityRank()
    TFDirector:send(c2s.ACTIVITY_REQ_EXPLORE_ACTIVITY_RANK, {})
end

-- 皮肤更换
function ExploreDataMgr:Send_EXPLORE_REQ_EXPLORE_UPDATE_SKIN(skinId)
    TFDirector:send(c2s.EXPLORE_REQ_EXPLORE_UPDATE_SKIN, {skinId})
end

-- 获取一键派遣
function ExploreDataMgr:Send_EXPLORE_REQ_EXPLORE_TASK_PLAN()
    TFDirector:send(c2s.EXPLORE_REQ_EXPLORE_TASK_PLAN, {})
end

-- 一键领取
function ExploreDataMgr:Send_EXPLORE_REQ_GET_ALL_AFK_TASK_AWARD()
    TFDirector:send(c2s.EXPLORE_REQ_GET_ALL_AFK_TASK_AWARD, {})
end

-- 确认上阵
function ExploreDataMgr:Send_EXPLORE_REQ_AFK_TASKS_DEAL(msg)
    TFDirector:setSendSerializeEnable(true)
    TFDirector:send(c2s.EXPLORE_REQ_AFK_TASKS_DEAL, {deal = msg})
    TFDirector:setSendSerializeEnable(false)
end


function ExploreDataMgr:getNewCity()
    return self.newCity or {}
end

function ExploreDataMgr:getNewNation()
    return self.newNation or {}
end

function ExploreDataMgr:getCacheTaskPlan()
    return self.cacheTaskPlan or {}
end

function ExploreDataMgr:SetExploreInfo(data)

    local isPush = data.isPush or false
    ---解锁的国家信息
    local nation = data.nation or {}
    for k,v in ipairs(nation) do

        ---设置新国家
        if isPush then
            if not self.newNation then
                self.newNation = {}
            end
            local index = table.indexOf(self.openNation,v.id)
            if index == -1 then
                table.insert(self.newNation,v.id)
            end
        end

        table.insert(self.openNation,v.id)

        local city = v.city or {}
        for _,cityInfo in ipairs(city) do
            local event = cityInfo.event or {}

            ---设置新城市
            if isPush then
                if not self.newCity then
                    self.newCity = {}
                end

                if not self.cityData[cityInfo.id] then
                    table.insert(self.newCity,cityInfo.id)
                end
            end

            self.cityData[cityInfo.id] = event
            for _,eventInfo in ipairs(event) do
                self.allFoundEvent[eventInfo.id] = eventInfo
            end

            local finishTab = cityInfo.completeEvent or {}
            for _,eventId in ipairs(finishTab) do
                self.fishEvent[eventId] = 1
            end
        end
    end

    ---当前探索的城市
    self.localCity = data.localCity

    ---当前探索的国家
    self.localNation = data.localNation

    ---开始探索的时间
    self.startTime = data.startTime or 0

    ---奖励点次数
    self.cityAwardTimes = data.cityAwardTimes or 0

    ---速度
    self.exploreSpeed = data.speed or 0

    ---背包容量
    self.capacity = data.capacity or 0

    self.lastPassTime = data.lastAwardPointTime ---当前时间到最近奖励点的时间

    ----总的奖励次数
    self.totalRewardCount = data.totalRewardCount or 0

    self.firstPlay = data.first

    ---总的奖励
    self.exploreAward = data.totalRewards or {}

	---额外奖励
    self.exploreExAward = data.actRewards or {}

end

function ExploreDataMgr:onRecvAllExploreInfo(event)
    local data = event.data
    if not data then
        return
    end

    local activity = data.activity or {}
    for k,v in ipairs(activity) do
        self.allInfo[v.id] = v
    end

    self.quickTimes = data.quickTimes or 0
    self.shipInfo = data.ship or {}
    self.shipInfo.shipId = self.shipInfo.shipId or 1001

    EventMgr:dispatchEvent(EV_EXPLORE_SHIP_REFRESH)
end

function ExploreDataMgr:getCurShipSkinId( ... )
    -- body
    if not self.shipSkinId then return 1602000 end
    return self.shipSkinId
end

-- 飞船外观信息
function ExploreDataMgr:getShipCfg(shipSkinId)
    -- body
    shipSkinId = shipSkinId or self:getCurShipSkinId()
    local roleId = TabDataMgr:getData("ShipSkin",shipSkinId).roleId
    return TabDataMgr:getData("AfkRole",roleId)
end

function ExploreDataMgr:isHadUnlock(shipSkinId)
    if shipSkinId == 1602000 then  -- 默认的皮肤（容错）
        return true
    end
    return GoodsDataMgr:currencyIsEnough(shipSkinId, 1)
end

----获得探索信息
function ExploreDataMgr:onRecvExploreInfo(event)

    local data = event.data
    if not data then
        return
    end

    self:SetExploreInfo(data)
    EventMgr:dispatchEvent(EV_EXPLORE_ACTIVITY)
end

function ExploreDataMgr:onRecvGetEventAward(event)

    local data = event.data
    if not data then
        return
    end
    local activityId = data.data
    local nationId = data.nationId
    local cityId = data.cityId
    local eventId = data.eventId

    local eventInfo = self.cityData[cityId]
    for i=#eventInfo,1,-1 do
        if eventId == eventInfo[i].id then
            table.remove(eventInfo,i)
            break
        end
    end
    self.allFoundEvent[eventId] = nil
    self.fishEvent[eventId] = 1
    local rewards = data.rewards or {}
    EventMgr:dispatchEvent(EV_EXPLORE_REMOVE_EVENT,cityId,eventId,rewards)
end

function ExploreDataMgr:onRecvAddEventProgress(event)

    local data = event.data
    if not data then
        return
    end

    local activityId = data.data
    local nationId = data.nationId
    local cityId = data.cityId
    local eventInfo = data.event

    if not self.cityData[cityId] then
        self.cityData[cityId] = {}
    end

    local index
    local cityEventInfo = self.cityData[cityId]
    for k,v in ipairs(cityEventInfo) do
        if v.id == eventInfo.id then
            index = k
            break
        end
    end
    if not index then
        table.insert(self.cityData[cityId],eventInfo)
    else
        self.cityData[cityId][index] = eventInfo
    end
    self.allFoundEvent[eventInfo.id] = eventInfo

    EventMgr:dispatchEvent(EV_EXPLORE_UPDATE_EVENT)
end

function ExploreDataMgr:onRecvBossFight(event)
    local data = event.data
    if not data then
        return
    end
    EventMgr:dispatchEvent(EV_EXPLORE_FIGHTBOSS,data)
end

function ExploreDataMgr:onRecvGetExploreAward(event)
    local data = event.data
    if not data then
        return
    end
    self.exploreAward = {}
    local activityInfo = data.activity

    self:SetExploreInfo(activityInfo)
    local rewards = data.rewards or {}
    if #rewards > 0 then
        Utils:showReward(rewards)
    end
    EventMgr:dispatchEvent(EC_GET_EXPLORE_AWARD)
end

function ExploreDataMgr:onRecvExploreNation(event)
    local data = event.data
    if not data then
        return
    end
end

function ExploreDataMgr:onRecvExploreCity(event)
    local data = event.data
    if not data then
        return
    end
end

function ExploreDataMgr:onExploreFightData(event)
    local data = event.data
    EventMgr:dispatchEvent("explore_battle_test",data)
end

function ExploreDataMgr:onRecvReachExploreDot(event)
    local data = event.data
    if not data then
        return
    end

    local activity = data.activity

    local newAward = activity.rewards
    local oldLocalCity = self.localCity
    self:SetExploreInfo(activity)
    if oldLocalCity ~= activity.localCity then
        EventMgr:dispatchEvent("EV_EXPLORE_JUMPCITY",0,activity.localNation,activity.localCity)
    end

    EventMgr:dispatchEvent("EV_FINISH_EXPLORE_DOT",newAward)
end

function ExploreDataMgr:onRecvSwichNationOrCity(event)

    local data = event.data
    if not data then
        return
    end

    self:SetExploreInfo(data.activity)
    EventMgr:dispatchEvent("EV_EXPLORE_JUMPCITY",data.type,data.nationId,data.cityId)

end

function ExploreDataMgr:onRecvQuickExplore(event)

    local data = event.data
    if not data then
        return
    end
    self.quickTimes = data.useTime
    local rewards = data.rewards or {}
    if #rewards > 0 then
        Utils:showReward(rewards)
    end
    EventMgr:dispatchEvent("EC_EXPLORE_QUICK")
end

function ExploreDataMgr:onRecvShipAttrsInfo(event)
    local data = event.data
    if not data then
        return
    end
    self.shipAttrsInfo = data
    EventMgr:dispatchEvent("EV_EXPLORE_SHIPATTR")
end

function ExploreDataMgr:getShipAttrsInfo()
    return self.shipAttrsInfo
end

function ExploreDataMgr:onRecvExploreActivityRank(event)

    local data = event.data
    if not data then
        return
    end
    Utils:openView("explore.ExploreRankView",data.rankList,data.selfRank)
end

function ExploreDataMgr:onRevSkinChange(event)
    local data = event.data
    if not data then
        return
    end
    self.shipSkinId = data.skinId
    EventMgr:dispatchEvent("EV_EXPLORE_SKINCHANGE")
end

----------------------------舱室培养协议数据------------------------------------

---获取天赋树
function ExploreDataMgr:Send_ExploreTechInfos()
    TFDirector:send(c2s.EXPLORE_REQ_EXPLORE_TECH_INFOS, {})
end

---升级天赋树
function ExploreDataMgr:Send_ExploreTechUpgrade(type,nationCid,knowledgeCid)
    TFDirector:send(c2s.EXPLORE_EXPLORE_TECH_UPGRADE, {type,nationCid,knowledgeCid})
end

function ExploreDataMgr:onRecvExploreCabins(event)
    -- body
    local data = event.data
    self.cabinsData = data.exploreCabin or {}
    self.shipSkinId = data.skinId
    EventMgr:dispatchEvent(EV_EXPLORE_CABIN_REFRESH)
end

function ExploreDataMgr:onRecvOneCabinInfo(event)
    local data = event.data
    local hasCabins = false
    if not self.cabinsData then return end
    for k,v in pairs(self.cabinsData) do
        if v.id == data.id then
            self.cabinsData[k] = data
            hasCabins = true
            break
        end
    end
    if not hasCabins then
        table.insert(self.cabinsData, data)
    end
    EventMgr:dispatchEvent(EV_EXPLORE_CABIN_REFRESH)
end

function ExploreDataMgr:onRecvExploreCabinUpgrade(event)
    -- body
    local data = event.data
    if not data then return end
    local hasCabins = false

    if data.rewards then
        Utils:showReward(data.rewards)
    end

    for k,v in pairs(self.cabinsData) do
        if v.id == data.exploreCabin.id then
            self.cabinsData[k] = data.exploreCabin
            hasCabins = true
            break
        end
    end

    if not hasCabins then
        table.insert(self.cabinsData,data.exploreCabin)
    end

    EventMgr:dispatchEvent(EV_EXPLORE_CABIN_REFRESH)
end

function ExploreDataMgr:onRecvExploreEquipUpgrade(event)
    -- body
    local data = event.data
    if not data then return end
    local cabinData = self:getCabinData(data.cabinId)
    if cabinData then
        cabinData.equip = cabinData.equip or {}
        local hasEquip = false
        for k,v in pairs(cabinData.equip) do
            if v.id == data.id then
                cabinData.equip[k] = data
                hasEquip = true
                break;
            end
        end

        if not hasEquip then
            table.insert(cabinData.equip,data)
        end
        EventMgr:dispatchEvent(EV_EXPLORE_CABIN_EQUIP_REFRESH)
    end
end

function ExploreDataMgr:onRecvExploreTaskRefresh(event)
    -- body
    local data = event.data
    if not data then return end
    local cabinData = self:getCabinData(data.cabinId)
    if cabinData then
        cabinData.task = cabinData.task or {}
        local hasTask = false
        for k,v in pairs(cabinData.task) do
            if v.id == data.id then
                cabinData.task[k] = data
                hasTask = true
                break;
            end
        end

        if not hasTask then
            table.insert(cabinData.task,data)
        end
        EventMgr:dispatchEvent(EV_EXPLORE_CABIN_TASK_REFRESH)
    end
end

function ExploreDataMgr:onRecvExploreTaskGetReward(event)
    -- body
    local data = event.data
    if data.rewards and #data.rewards > 0 then
        Utils:showReward(data.rewards, data.extRewards)
    end
end

function ExploreDataMgr:onRecvExploreTechUpgrade(event)

    local data = event.data
    if not data then
        return
    end
    local techTreeInfo = data.techTree
    if not self.knowledgeMap_[techTreeInfo.techType] then
        self.knowledgeMap_[techTreeInfo.techType] = {}
    end
    for _,info in ipairs(techTreeInfo.tech) do
        self.knowledgeMap_[techTreeInfo.techType][info.techId] = info.state
    end

    local rewards = data.rewards or {}
    if #rewards > 0 then
        Utils:showReward(rewards)
    end

    EventMgr:dispatchEvent(EV_EXPLORE_UPGRADE_KNOWLEDGE)

end

function ExploreDataMgr:onRecvExploreTechInfos(event)

    local data = event.data
    if not data then
        return
    end

    local techTree = data.techTree or {}
    for k,techInfo in ipairs(techTree) do
        if not self.knowledgeMap_[techInfo.techType] then
            self.knowledgeMap_[techInfo.techType] = {}
        end
        techInfo.tech = techInfo.tech or {}
        for _,info in ipairs(techInfo.tech) do
            self.knowledgeMap_[techInfo.techType][info.techId] = info.state
        end
    end
end

function ExploreDataMgr:onResSetShapeMsg(event)
    local data = event.data
    self.shipInfo = data.ship

    EventMgr:dispatchEvent(EV_EXPLORE_SHIP_REFRESH)
end

function ExploreDataMgr:onResShipAttr(event)
    local data = event.data
    if not self.shipInfo then
        self.shipInfo = {}
    end
    self.shipInfo.shape = data.shape
    self.shipInfo.attr = data.attr
    EventMgr:dispatchEvent(EV_EXPLORE_SHIP_REFRESH)
end

function ExploreDataMgr:onResTresureSkills(event)
    local data = event.data
    if not data then
        return
    end
    self.tresureSkills = data.skillId
end

function ExploreDataMgr:onResExploreTaskPlan(event)
    local data = event.data
    if not data then
        return
    end
    self.cacheTaskPlan = data.taskPlan
    EventMgr:dispatchEvent(EV_EXPLORE_TASK_RED_POINT)
end

function ExploreDataMgr:onResAllAfkTaskAward(event)
    local data = event.data
    if not data then
        return
    end
    if data.rewards then
        Utils:showReward(data.rewards)
    end
end

function ExploreDataMgr:getTresureSkills()
    return self.tresureSkills
end

function ExploreDataMgr:onRecvExploreTreasureEquip(event)
    -- body
end

function ExploreDataMgr:onRecvExploreTreasureCompose(event)
    -- body
end

function ExploreDataMgr:onRecvExploreTreasureStarUp(event)
    -- body
end

function ExploreDataMgr:getWeaponTalent( )
    -- body
    local roomCfg = self:getCabinCfg(ShipRoomType.WEAPON)
    local talentIds = {}
    if self.cabinsData then
        for k,v in pairs(roomCfg.equipId) do
            if GoodsDataMgr:getItem(v) then
                local _,equipData = next(GoodsDataMgr:getItem(v))
                local equipCfg = self:getEquipLevelCfg(equipData.cid,equipData.level)
                for p,talent in pairs(equipCfg.talent) do
                    table.insert(talentIds,talent)
                end
            end
        end
    end
    return talentIds
end

function ExploreDataMgr:getShipSkills(talents)
    local skills = {}
    for k,tanlentId in pairs(talents) do
        local effect = TabDataMgr:getData("AfkEffect", tanlentId)
        if effect and effect.ability.skill then
            for p,skillId in pairs(effect.ability.skill) do
                if table.indexOf(skills, skillId) == -1 then
                    table.insert(skills, skillId)
                end
            end
        end
    end
    return skills
end

function ExploreDataMgr:getCabinData( id )
    -- body
    if not self.cabinsData then return nil end
    for k,v in pairs(self.cabinsData) do
        if v.id == id then
            return v
        end
    end
    return nil
end

function ExploreDataMgr:getCabinCfg( id )
    -- body
    local cabinData =  self:getCabinData(id)
    local roomCfg =  TabDataMgr:getData("ExploreCabinUi",id)
    local roomDetailCfg = TabDataMgr:getData("ExploreCabin",cabinData.cid)
    local stageCfgs = TabDataMgr:getData("ExploreStage")
    local stageCfg = nil
    for k,v in ipairs(stageCfgs) do
        if v.style == id and v.power <= cabinData.fightPower then
            stageCfg = v
        end
    end

    return roomCfg,roomDetailCfg,stageCfg
end

function ExploreDataMgr:getCabinLevelCfg( roomType, level )
    -- body
    local cabinCfgs = TabDataMgr:getData("ExploreCabin")

    for k,v in pairs(cabinCfgs) do
        if v.type == roomType and v.level == level then
            return v
        end
    end
    return nil 
end

function ExploreDataMgr:getCabinAllCfg( id )
    -- body
    local cabinCfgs = TabDataMgr:getData("ExploreStage")
    local allLevelCabin = {}

    for k,v in pairs(cabinCfgs) do
        if v.style == id then
            table.insert(allLevelCabin,v)
        end
    end

    table.sort(allLevelCabin, function(a, b)
        return a.stageLevel < b.stageLevel
    end)

    return allLevelCabin
end

function ExploreDataMgr:getRoleIsInTask( roleId )
    -- body
    for k,v in pairs(self.cabinsData) do
        v.task = v.task or {}
        for _k,_v in pairs(v.task) do
            if _v.heroId and _v.state ~= 3 and table.find(_v.heroId,roleId) ~= -1 then
                return true
            end
        end
    end
    return false
end

function ExploreDataMgr:getRoleIsInCabinIndex( roomType, roleId )
    -- body
    local v = self:getCabinData(roomType)
    if not v then return end
    v.driver = v.driver or {}
    for _k,_v in pairs(v.driver) do
        if _v.heroId == roleId then
            return _v.index
        end
    end
end

function ExploreDataMgr:getRoleIsInCabin( roleId )
    -- body
    -- print("===============",self)
    for k,v in pairs(self.cabinsData) do
        v.driver = v.driver or {}
        for _k,_v in pairs(v.driver) do
            if _v.heroId == roleId then
                return v.cid
            end
        end
    end
end

function ExploreDataMgr:getPageIndex( roomType, fileName )
    local uiCfg = TabDataMgr:getData("ExploreCabinUi",roomType)
    for k,v in pairs(uiCfg.pageUi) do
        if v.fileName == fileName then
            return v.pageIndex or k
        end
    end
    return 1
end

function ExploreDataMgr:getEquipLevelCfg( equipId, level )
    local levelCfg = TabDataMgr:getData("ExploreEquipLevel")
    for k,v in pairs(levelCfg) do
        if v.equipId == equipId and v.level == level then
            return v
        end
    end
    return nil
end

function ExploreDataMgr:setCurFightBoss(monsterId)
    self.curFightBossId = monsterId
end

function ExploreDataMgr:getCurFightBoss()
    return self.curFightBossId
end

function ExploreDataMgr:getEquipedTreasuresSkillId()
    local skillIds = {}
    local gemList = GoodsDataMgr:getItemsBySuperTyper(EC_ResourceType.EXPLORE_TREASURE,1)
    local roomData = self:getCabinData(ShipRoomType.EXHIBITION)
    if not roomData then return skillIds end
    local treasures = {}
    for i,gem in ipairs(gemList) do
        for k,treasure in pairs(roomData.treasure or {}) do
            if gem.id == treasure.uuid then
                table.insert(treasures, gem)
            end
        end
    end
    for i,v in ipairs(treasures) do
        local cfg = TabDataMgr:getData("ExploreTreasure", tonumber(v.cid))
        local skillId = cfg.specialSkill[v.star]
        table.insert(skillIds, skillId)
    end
    return skillIds
end

function ExploreDataMgr:getDirversFightPower(roomType)

    local roomData = self:getCabinData(roomType)
    if not roomData then
        return 0
    end
    local fightPowerTotal = 0
    local drivers = roomData.driver or {}
    for k,v in pairs(drivers) do
        print(v.heroId,HeroDataMgr:getHeroPower(v.heroId))
        fightPowerTotal = fightPowerTotal + HeroDataMgr:getHeroPower(v.heroId)
    end
    return fightPowerTotal
end

function ExploreDataMgr:getRoomStageLevel(roomType)

    local roomData = self:getCabinData(roomType)
    if not roomData then
        return 0
    end
    local stageLevel = 0
    local fightPowerTotal = self:getDirversFightPower(roomType)
    local values = self:getCabinAllCfg(roomType)
    for k,v in ipairs(values) do
        if fightPowerTotal >= v.power then
            stageLevel = v.stageLevel
        end
    end

    return stageLevel
end


-------------------------探索培养请求-------------------------------

function ExploreDataMgr:SEND_EXPLORE_REQ_EXPLORE_INFO( ... )
    -- body
    TFDirector:send(c2s.EXPLORE_REQ_EXPLORE_INFO,{})
end

function ExploreDataMgr:SEND_EXPLORE_CABIN_UPGRADE( cabinId )
    -- body
    TFDirector:send(c2s.EXPLORE_CABIN_UPGRADE,{ cabinId })
end

function ExploreDataMgr:SEND_EXPLORE_CABIN_ADD_HERO( cabinId, heroId, index )
    -- body
    TFDirector:send(c2s.EXPLORE_CABIN_ADD_HERO,{ cabinId,heroId,index })
end

function ExploreDataMgr:SEND_EXPLORE_CABIN_REMOVE_HERO( cabinId, index )
    -- body
    TFDirector:send(c2s.EXPLORE_CABIN_REMOVE_HERO,{ cabinId, index })
end

function ExploreDataMgr:SEND_EXPLORE_EXPLORE_EQUIP_UPGRADE( equipId, cabinId )
    TFDirector:send(c2s.EXPLORE_EXPLORE_EQUIP_UPGRADE,{ equipId, cabinId })
end

function ExploreDataMgr:SEND_EXPLORE_EXPLORE_EQUIP_PUT_ON( equipId, cabinId, index )
    -- body
    TFDirector:send(c2s.EXPLORE_EXPLORE_EQUIP_PUT_ON,{ equipId, cabinId, index })
end

function ExploreDataMgr:SEND_EXPLORE_EXPLORE_EQUIP_PUT_DOWN( cabinId, index )
    -- body
    TFDirector:send(c2s.EXPLORE_EXPLORE_EQUIP_PUT_DOWN,{ cabinId, index })
end

function ExploreDataMgr:SEND_EXPLORE_EXPLORE_TASK_ACCELERATION( taskId )
    -- body
    TFDirector:send(c2s.EXPLORE_EXPLORE_TASK_ACCELERATION, { taskId })
end

function ExploreDataMgr:SEND_EXPLORE_EXPLORE_TASK_DEAL( taskId, heroIds )
    -- body
    TFDirector:send(c2s.EXPLORE_EXPLORE_TASK_DEAL,{ taskId, heroIds })
end

function ExploreDataMgr:SEND_EXPLORE_EXPLORE_TASK_GET_AWARD( taskId)
    -- body
    TFDirector:send(c2s.EXPLORE_EXPLORE_TASK_GET_AWARD,{ taskId })
end

function ExploreDataMgr:SEND_EXPLORE_EXPLORE_TASK_REFRESH( ... )
    -- body
    TFDirector:send(c2s.EXPLORE_EXPLORE_TASK_REFRESH, {})
end

function ExploreDataMgr:SEND_EXPLORE_EXPLORE_TREASURE_COMPOSE( gemId )
    -- body
    TFDirector:send(c2s.EXPLORE_EXPLORE_TREASURE_COMPOSE, { gemId })
end

function ExploreDataMgr:SEND_EXPLORE_EXPLORE_TREASURE_STAR_UP( gemId, pieces )
    -- body
    TFDirector:send(c2s.EXPLORE_EXPLORE_TREASURE_STAR_UP,{ gemId, pieces })
end

function ExploreDataMgr:SEND_EXPLORE_EXPLORE_TREASURE_EQUIP( gemId, index )
    -- body
    TFDirector:send(c2s.EXPLORE_EXPLORE_TREASURE_EQUIP, { gemId, index })
end

function ExploreDataMgr:SEND_EXPLORE_REQ_EXPLORE_TREASURE_GRID( ... )
    -- body
    TFDirector:send(c2s.EXPLORE_REQ_EXPLORE_TREASURE_GRID, {})
end

function ExploreDataMgr:SEND_EXPLORE_REQ_SET_SHAPE( type )
    -- body
    TFDirector:send(c2s.EXPLORE_REQ_SET_SHAPE, {type})
end

--- 舱室升级支援消耗

function ExploreDataMgr:checkCabinUpgradeCostsEnough( roomType )
    -- body
    local _,roomDetailCfg = self:getCabinCfg(roomType)
    local nextLevel = roomDetailCfg.level + 1
    local nextCabinCfg = self:getCabinLevelCfg( roomDetailCfg.type ,nextLevel)

    if not nextCabinCfg then return false end
    local costs = nextCabinCfg.cost

    local enough = true
    for k,v in pairs(costs) do
        if GoodsDataMgr:getItemCount(k) < v then
            enough = false
        end
    end
    return enough
end

function ExploreDataMgr:checkCabinUpgradePreCondition( roomType )
    -- body
    local _,roomDetailCfg = self:getCabinCfg(roomType)
    local nextLevel = roomDetailCfg.level + 1
    local nextCabinCfg = self:getCabinLevelCfg(roomDetailCfg.type ,nextLevel)
    if nextCabinCfg and nextCabinCfg.condition then
        for k,v in pairs(nextCabinCfg.condition) do
            if k == "buildingLevel" then
                for _k,_v in pairs(v) do
                    local cabinCfg,cabinDetailCfg,stageCfg = self:getCabinCfg(_k)
                    if _v > cabinDetailCfg.level then
                        return false
                    end
                end
            end
        end
    end
    return true
end

function ExploreDataMgr:checkRoleCanPullUp( roomType )
    -- body
    local roomData = self:getCabinData(roomType)
    local roomCfg, roomDetailCfg, stageCfg = self:getCabinCfg(roomType)

    local roleList = HeroDataMgr:getShowList(true)
    local count = HeroDataMgr:getShowCount()

    local roleListId = {}
    for i = 1,count do
        local heroId = HeroDataMgr:getSelectedHeroId(i)
        local cabinCid = self:getRoleIsInCabin(heroId)
        if not cabinCid then
            return true
        end 
    end
    return false
end

function ExploreDataMgr:checkCommonRoomRedPoint( roomType, pageIndex )
    local roomData = self:getCabinData(roomType)
    local roomCfg, roomDetailCfg, stageCfg = self:getCabinCfg(roomType)

    if pageIndex == 1 then -- 升级红点判断
        if self:checkCabinUpgradePreCondition(roomType) and self:checkCabinUpgradeCostsEnough(roomType) then
            return true
        end
    elseif pageIndex == 2 then -- 上阵红点判断
        if roomData.driver then
            return roomDetailCfg.heroSize > table.count(roomData.driver) and self:checkRoleCanPullUp(roomType)
        else
            return self:checkRoleCanPullUp(roomType)
        end
    end
    return false
end

function ExploreDataMgr:getWeaponNextUpLevelCfg(weaponId)
    -- body
    local equipLevels = TabDataMgr:getData("ExploreEquipLevel")

    local id = nil
    local equipData = nil

    if GoodsDataMgr:getItem(weaponId) then
        id,equipData = next(GoodsDataMgr:getItem(weaponId))
    end
    local nextLevel = 1
    if equipData then
        nextLevel = equipData.level + 1
    end

    local equipLevelCfg = ExploreDataMgr:getEquipLevelCfg(weaponId, nextLevel)
    return equipLevelCfg
end

function ExploreDataMgr:checkWeaponUpgradeCostsEnough( weaponId )
    -- body
    local nextCfg = self:getWeaponNextUpLevelCfg(weaponId)
    if not nextCfg or not GoodsDataMgr:getItem(weaponId) then return false end
    local costs = nextCfg.cost

    local enough = true
    for k,v in pairs(costs) do
        if GoodsDataMgr:getItemCount(k) < v then
            enough = false
        end
    end
    return enough
end

function ExploreDataMgr:checkWeaponRoomRedPoint( roomType )
    local roomCfg, roomDetailCfg, stageCfg = self:getCabinCfg(roomType)

    for k,v in ipairs(roomCfg.equipId) do
        if self:checkWeaponUpgradeCostsEnough(v) then
            return true
        end
    end
    return false
end

function ExploreDataMgr:checkAccessoriesRoomRedPoint( roomType )
    -- body
    local roomData = self:getCabinData(roomType)
    local roomCfg, roomDetailCfg, stageCfg = self:getCabinCfg(roomType)

    local equipList = GoodsDataMgr:getItemsBySuperTyper(EC_ResourceType.EXPLORE_ACCESSORIES,3)
    local hasNoWorkingAccessories = false
    local workingSize = 0
    for i = #equipList,1,-1 do
        roomData.equip = roomData.equip or {}
        local isWorking = false
        for k,v in pairs(roomData.equip) do
            if v.id == equipList[i].id and v.index ~= 0 then
                isWorking = true
                workingSize = workingSize + 1
            end
        end

        if not isWorking then
            hasNoWorkingAccessories = true
        end
    end

    if roomDetailCfg.holeSize > workingSize and hasNoWorkingAccessories then return true end
    return false
end


function ExploreDataMgr:checkExhibitionRoomRedPoint( roomType )
    -- body
    local roomData = self:getCabinData(roomType)
    local roomCfg, roomDetailCfg, stageCfg = self:getCabinCfg(roomType)

    local equipList = GoodsDataMgr:getItemsBySuperTyper(EC_ResourceType.EXPLORE_TREASURE,1)
    local hasNoWorkingAccessories = false
    local workingSize = 0
    for i = #equipList,1,-1 do
        roomData.treasure = roomData.treasure or {}
        local isWorking = false
        for k,v in pairs(roomData.treasure) do
            if v.uuid == equipList[i].id then
                isWorking = true
                workingSize = workingSize + 1
            end
        end

        if not isWorking then
            hasNoWorkingAccessories = true
        end
    end

    if roomDetailCfg.holeSize > workingSize and hasNoWorkingAccessories then return true end
    return false
end

function ExploreDataMgr:getPieceListAllNum( quality ,ingoreItem )
    -- body
    local allPiece = GoodsDataMgr:getItemsBySuperTyper(EC_ResourceType.EXPLORE_TREASUREPIECE)
    local showLists = {}
    for k,v in pairs(allPiece) do
        local itemCfg = GoodsDataMgr:getItemCfg(v.cid)
        if itemCfg.quality == quality and table.find(ingoreItem, v.cid) == -1 then
            table.insert(showLists, v)
        end
    end
    local allNum = 0

    for k,v in pairs(showLists) do
        allNum = allNum + v.num 
    end
    return allNum
end

function ExploreDataMgr:checkTreasureStarUpRedPoint( treasureCfg )
    -- body
    if not GoodsDataMgr:getItem (treasureCfg.id) then return  false end
    local _,treasureData = next(GoodsDataMgr:getItem (treasureCfg.id))
    local costs = treasureCfg.levelCost[treasureData.star]
    local enough = true
    if not costs then  
        enough = false 
        costs = {}
    end

    local ingoreIds = {}
    for k,v in pairs(costs) do
        if v.type == 1 then
            table.insert(ingoreIds,v.id)
        end
    end
    for k,v in pairs(costs) do
        if v.type == 1 then
            if v.num > GoodsDataMgr:getItemCount(v.id)  then
                enough = false
            end
        elseif v.type == 2 then
            local piecesNum = self:getPieceListAllNum(v.quality,ingoreIds)
            if v.num > piecesNum then
                enough = false
            end
        end
    end
    if enough then return true end
end

function ExploreDataMgr:checkGemComposeRedPoint( roomType )
    -- body
    local allCfgs = TabDataMgr:getData("ExploreTreasure")

    for k,v in pairs(allCfgs) do
        if v.subType == 1 then
            if not GoodsDataMgr:getItem (v.id) then
                local costs = v.syntheticCost
                local enough = true
                for k,v in pairs(costs) do
                    if v > GoodsDataMgr:getItemCount(k) then
                        enough = false
                    end
                end
                if enough then return true end
            else
                if self:checkTreasureStarUpRedPoint(v) then
                    return true
                end
            end
        end
    end

    return false
end

function ExploreDataMgr:checkRedPoint( roomType, fileName, pageIndex )
    -- body
    if fileName == "CommonRoomView" then
        return self:checkCommonRoomRedPoint(roomType,pageIndex)
    elseif fileName == "WeaponRoomView" then
        return self:checkWeaponRoomRedPoint(roomType)
    elseif fileName == "AccessoriesRoomView" then
        return self:checkAccessoriesRoomRedPoint(roomType)
    elseif fileName == "ExhibitionRoomView" then
        return self:checkExhibitionRoomRedPoint(roomType)
    elseif fileName == "GemComposeView" then
        return self:checkGemComposeRedPoint(roomType)
    elseif fileName == "CommandTaskView" then
        return self:checkCommandTaskRedPoint(roomType)
    elseif fileName == "CommandSkillView" then
        return self:checkCommandSkillRedPoint(roomType)
    end
    return false
end

function ExploreDataMgr:checkKnowledgeRedPoint( skillInfo )
    -- body
    local preActivite = true
    for k, v in pairs(skillInfo.preAbility) do
        local state = self:getKnowledgeState(skillInfo.type, v)
        if not state or state == 0 then
            preActivite = false
        end
    end

    if not preActivite then return false end
    local curState = self:getKnowledgeState(skillInfo.type, skillInfo.id)
    if curState and curState == 1 then return false end

    for k,v in pairs(skillInfo.cost) do
        if v > GoodsDataMgr:getItemCount(k) then
            return false
        end
    end

    return true

end

function ExploreDataMgr:checkCommandSkillRedPoint( roomType )
    -- body
    local knowledgeList = TabDataMgr:getData("AfkKnowledge")
    for k, v in pairs(knowledgeList) do
        if v.showType then
            if self:checkKnowledgeRedPoint(v) then
                return true
            end
        end
    end
    return false
end

function ExploreDataMgr:checkCommandTaskRedPoint( roomType )
    -- body
    local roomData = self:getCabinData(roomType)

    local taskLists = clone(roomData.task) or {}
    for k,v in pairs(taskLists) do
        if self:checkTaskRedPoint(v) then
            return true
        end
    end

    if self.cacheTaskPlan and #self.cacheTaskPlan > 0 then
        return true
    end

    return false
end

function ExploreDataMgr:checkTaskRedPoint( taskData )
    -- body
    local taskCfg = TabDataMgr:getData("ExploreTask",taskData.id)
    if taskData.state == 2 or (taskData.state == 1 and taskData.startTime + taskCfg.costTime <= ServerDataMgr:getServerTime()) then
        return true
    end
    return false
end

return ExploreDataMgr:new();
