local BaseDataMgr = import(".BaseDataMgr")
local LinkageHwxDataMgr = class("LinkageHwxDataMgr", BaseDataMgr)

function LinkageHwxDataMgr:ctor()
    self:init()
end

function LinkageHwxDataMgr:registerMsgEvent()

    ---地图
    TFDirector:addProto(s2c.NEPTUNE2ND_HALF_RESP_NEPTUNE2ND_HALF_INFO, self, self.onRespHwxBaseInfo)
    TFDirector:addProto(s2c.NEPTUNE2ND_HALF_RESP_NEPTUNE2ND_HALF_RESOURCE, self, self.onRespHwxResource)
    TFDirector:addProto(s2c.NEPTUNE2ND_HALF_RESP_NEPTUNE2ND_HALF_CITY_REFRESH, self, self.onResUpdateHwxCityInfo)
    TFDirector:addProto(s2c.NEPTUNE2ND_HALF_RESP_NEPTUNE2ND_HALF_MAP, self, self.onFlyToSecondMap)

    ---爬塔
    TFDirector:addProto(s2c.NEPTUNE2ND_HALF_RESP_NEPTUNE2ND_HALF_BUFF_CHOSEN, self, self.onRespChooseBuff)
    TFDirector:addProto(s2c.NEPTUNE2ND_HALF_RESP_NEPTUNE2ND_HALF_LIFT_REFRESH, self, self.onRespUpdateTowerInfo)

    ---购买英雄战斗次数
    TFDirector:addProto(s2c.NEPTUNE2ND_HALF_RESP_NEPTUNE2ND_HALF_BUY_COUNT, self, self.onRespHeroBuyCnt)

end

function LinkageHwxDataMgr:init()
    self:reset()
    self:registerMsgEvent()

    self.dungeonCityDisplayCfg = TabDataMgr:getData("HwxDungeonDisplay")
    self.dungeonCityCfg = TabDataMgr:getData("HwxDungeonCity")
    self.hwxBuffManagerCfg = TabDataMgr:getData("HwxDungeonBuff")

end

function LinkageHwxDataMgr:reset()

    self.mapCitys_ = {}
    self.activeBuff_ = {}
    self.unactiveBuff_ = {}
    self.heroFightCnt_ = {}
    self.heroBuyCnt_ = {}
    self.initFightCnt = 0
end

function LinkageHwxDataMgr:getCityDisplayCfg(levelCid)
    return self.dungeonCityDisplayCfg[levelCid]
end

function LinkageHwxDataMgr:getCityCfg(levelCid)
    if not levelCid then
        return
    end
    return self.dungeonCityCfg[levelCid]
end

function LinkageHwxDataMgr:getHwxBuffManageCfg(cid)
    return self.hwxBuffManagerCfg[cid]
end

function LinkageHwxDataMgr:getMapStageInfo()
    return self.stageInfo
end

---获得爬塔数据
function LinkageHwxDataMgr:getTowerInfo()
    return self.hwxTowerInfo_
end

---获得buff信息
function LinkageHwxDataMgr:getActiveBuffInfo(floorId)
    if not floorId then
        return self.activeBuff_
    end
    return self.activeBuff_[floorId]
end

---获得未激活buff
function LinkageHwxDataMgr:getUnActiveBuffInfo(floorId)
    return self.unactiveBuff_[floorId] or {}
end

---获得地图城市数据
function LinkageHwxDataMgr:getMapCityInfo(cityId)
    if cityId then
        return self.mapCitys_[cityId]
    end
    return self.mapCitys_
end

---获得英雄购买次数
function LinkageHwxDataMgr:getHeroBuyCnt(heroId)
    return self.heroBuyCnt_[heroId] or 0
end

---获得英雄战斗次数
function LinkageHwxDataMgr:getHeroFightCnt(heroId)
    return self.heroFightCnt_[heroId] or 0
end

---获得初始战斗次数
function LinkageHwxDataMgr:getInitFightCnt()
    return self.initFightCnt
end

function LinkageHwxDataMgr:getTotalScore()
   return self.totalScore or 0
end

function LinkageHwxDataMgr:isInSecondMap()
    return self.isSecondMap
end

function LinkageHwxDataMgr:getFightFloorId(levelCid)

    if not self.hwxTowerInfo_  then
        return
    end

    local floorId
    local dungeon = self.hwxTowerInfo_.base.dungeonList or {}
    for k,v in pairs(dungeon) do
        if v.value == levelCid then
            floorId = v.key
            break
        end
    end

    if not floorId then
        return
    end

    local floorCfg = TabDataMgr:getData("HwxDungeonFloor")[floorId]
    if not floorCfg then
        return
    end
    return floorCfg.monsterLevel

end

function LinkageHwxDataMgr:Send_cityBaseInfo()
    TFDirector:send(c2s.NEPTUNE2ND_HALF_REQ_NEPTUNE2ND_HALF_INFO,{})
end

function LinkageHwxDataMgr:Send_getResource(dungeon, count, multiple)
    TFDirector:send(c2s.NEPTUNE2ND_HALF_REQ_NEPTUNE2ND_HALF_RESOURCE,{dungeon, count, multiple})
end

function LinkageHwxDataMgr:Send_buyFightTimes(heroId)
    TFDirector:send(c2s.NEPTUNE2ND_HALF_REQ_NEPTUNE2ND_HALF_BUY_COUNT,{heroId,1})
end

function LinkageHwxDataMgr:Send_getBuff(floorId,buffId)
    TFDirector:send(c2s.NEPTUNE2ND_HALF_REQ_NEPTUNE2ND_HALF_CHOSEN_BUFF,{floorId, buffId})
end

function LinkageHwxDataMgr:Send_changeMap()
    TFDirector:send(c2s.NEPTUNE2ND_HALF_REQ_NEPTUNE2ND_HALF_MAP,{1})
end

function LinkageHwxDataMgr:onFlyToSecondMap(event)

    local data = event.data
    if not data then return end

    self.isSecondMap = data.map ~= 0
    EventMgr:dispatchEvent(EV_FLYTO_SECONDMAP)
end

function LinkageHwxDataMgr:onRespHwxBaseInfo(event)

    local data = event.data
    if not data then return end
    dump(data)
    ---切换阶段服务器会推送
    self.stageInfo = {}
    self.stageInfo.stage = data.stage
    self.stageInfo.stageEnd = data.stageEnd

    self.totalScore = data.totalScore
    for k,v in ipairs(data.cities) do
        self.mapCitys_[v.id] = v
    end

    if data.liftInfo then
        self.hwxTowerInfo_ = data.liftInfo

        local dungeonBuff = self.hwxTowerInfo_.dungeonBuff or {}
        for k,v in ipairs(dungeonBuff) do
            self.activeBuff_[v.key] = v.value
        end

        if self.hwxTowerInfo_.chosenBuff then
            for k,v in ipairs(self.hwxTowerInfo_.chosenBuff) do
                self.unactiveBuff_[v.liftId] = v.buff
            end
        end

        ---英雄购买和战斗次数
        if self.hwxTowerInfo_.heroCount then
            for k,v in ipairs(self.hwxTowerInfo_.heroCount) do
                self.heroFightCnt_[v.key] = v.value
            end
        end

        if self.hwxTowerInfo_.buyCount then
            for k,v in ipairs(self.hwxTowerInfo_.buyCount) do
                self.heroBuyCnt_[v.key] = v.value
            end
        end
        self.initFightCnt = self.hwxTowerInfo_.battleCount

        self.totalScore = self.hwxTowerInfo_.base.totalScore
    end

    self.isSecondMap = data.map ~= 0

    EventMgr:dispatchEvent(EV_UPDATE_LINKAGEHWX)
end

--城市信息刷新(增量刷新)
function LinkageHwxDataMgr:onResUpdateHwxCityInfo(event)

    local data = event.data
    if not data then
        return
    end
    for k,v in ipairs(data.cities) do
        self.mapCitys_[v.id] = v
    end
    EventMgr:dispatchEvent(EV_UPDATE_LINKAGEHWX)

end

--领取资源返回
function LinkageHwxDataMgr:onRespHwxResource(event)
    local data = event.data
    if data.rewards then
        Utils:showReward(data.rewards)
    end
end

--刷新爬塔数据
function LinkageHwxDataMgr:onRespUpdateTowerInfo(event)

    local data = event.data
    if not data then
        return
    end
    self.hwxTowerInfo_ = data.liftInfo

    if data.liftInfo and data.liftInfo.base.totalScore ~= 0 then
        self.totalScore = data.liftInfo.base.totalScore
    end

    local dungeonBuff = self.hwxTowerInfo_.dungeonBuff
    if dungeonBuff then
        for k,v in ipairs(dungeonBuff) do
            self.activeBuff_[v.key] = v.value
        end
    else
        self.activeBuff_ = {}
    end
    if self.hwxTowerInfo_.chosenBuff then
        for k,v in ipairs(self.hwxTowerInfo_.chosenBuff) do
            self.unactiveBuff_[v.liftId] = v.buff
        end
    else
        self.unactiveBuff_ = {}
    end

    if self.hwxTowerInfo_.heroCount then
        for k,v in ipairs(self.hwxTowerInfo_.heroCount) do
            self.heroFightCnt_[v.key] = v.value
        end
    else
        self.heroFightCnt_ = {}
    end

    if self.hwxTowerInfo_.buyCount then
        for k,v in ipairs(self.hwxTowerInfo_.buyCount) do
            self.heroBuyCnt_[v.key] = v.value
        end
    else
        self.heroBuyCnt_ = {}
    end
    self.initFightCnt = self.hwxTowerInfo_.battleCount
    EventMgr:dispatchEvent(EV_UPDATE_HWX_TOWER)
end

--返回选择buff
function LinkageHwxDataMgr:onRespChooseBuff(event)

    local data = event.data
    if not data then
        return
    end

    local chosenBuff = data.chosenBuff or {}
    for k,v in ipairs(chosenBuff) do
        self.unactiveBuff_[v.liftId] = v.buff
    end

    local dungeonBuff = data.dungeonBuff or {}
    for k,v in ipairs(dungeonBuff) do
        self.activeBuff_[v.key] = v.value
    end

    EventMgr:dispatchEvent(EV_UPDATE_LINKAGEHWX_BUFF)
end

---英雄购买次数
function LinkageHwxDataMgr:onRespHeroBuyCnt(event)

    local data = event.data
    if not data then
        return
    end
    local buyCount = data.buyCount
    for k,v in ipairs(buyCount) do
        self.heroBuyCnt_[v.key] = v.value
    end
    Utils:showTips(12031197)
    EventMgr:dispatchEvent(EV_UPDATE_BUY_FIGHTCNT)
end

return LinkageHwxDataMgr:new();
