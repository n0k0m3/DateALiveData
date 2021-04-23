
local BaseDataMgr = import(".BaseDataMgr")
local FubenEndlessPlusDataMgr = class("FubenEndlessPlusDataMgr", BaseDataMgr)

function FubenEndlessPlusDataMgr:init()

    self.FloorDungeonCfg = {}
    local FloorDungeon = TabDataMgr:getData("FloorDungeon")
    for k,v in ipairs(FloorDungeon) do
        if not self.FloorDungeonCfg[v.team] then
            self.FloorDungeonCfg[v.team] = {}
        end
        self.FloorDungeonCfg[v.team][v.floor] = v
    end

    self.FloorDungeonLevelCfg = TabDataMgr:getData("FloorDungeonLevel")
    self.kvpData = Utils:getKVP(90043)
    self:registerMsgEvent()
end

--注册服务器消息事件
function FubenEndlessPlusDataMgr:registerMsgEvent()

    TFDirector:addProto(s2c.DUNGEON_RESP_CANCEL_CHALLENGE, self, self.onRecvExitChallenge)
    TFDirector:addProto(s2c.DUNGEON_RESP_CHALLENGE_INFO, self, self.onRecvAllInfo)
    TFDirector:addProto(s2c.DUNGEON_RESP_SET_CHALLENGE_HERO, self, self.onRecvSetFormation)
    TFDirector:addProto(s2c.DUNGEON_PUSH_CHALLENGE_PROGRESS, self, self.onUpdateCostTime)

end

function FubenEndlessPlusDataMgr:reset()
    self.heroFormation = {}
    self.formationSortRuleId = 5
    self.curFloorCid = 0
    self.formation = {}
    self.rankDataInfo = {}
    self.passRecord = {}
    self.floorCostTime = {}
end

function FubenEndlessPlusDataMgr:onLogin()

end

function FubenEndlessPlusDataMgr:onEnterMain()
end

function FubenEndlessPlusDataMgr:setFormationSortRuleId(ruleId)
    self.formationSortRuleId = ruleId or self.formationSortRuleId
end

function FubenEndlessPlusDataMgr:getFormationSortRuleId()
    return self.formationSortRuleId
end

function FubenEndlessPlusDataMgr:getFloorDungeonCfg(floorCid)

    local stage = self:getStage()
    if not floorCid then
        return self.FloorDungeonCfg[stage]
    end

    return self.FloorDungeonCfg[stage][floorCid]
end

function FubenEndlessPlusDataMgr:getFloorDungeonLevelCfg(cid)
    return self.FloorDungeonLevelCfg[cid]
end

function FubenEndlessPlusDataMgr:getHeroFormation(floorCid,levelCid,pos)

    if not self.heroFormation[floorCid] then
        return
    end

    if not levelCid then
        return self.heroFormation[floorCid]
    end

    if not pos then
        return self.heroFormation[floorCid][levelCid] or {}
    end

    if not self.heroFormation[floorCid][levelCid] then
        return
    end

    return self.heroFormation[floorCid][levelCid][pos]
end

function FubenEndlessPlusDataMgr:getHeroFormationLevelCid(floorCid,heroCid)
    if not self.heroFormation[floorCid] then
        return
    end

    local inLevelCid
    for k,v in pairs(self.heroFormation[floorCid]) do
        for pos =1,3 do
            if v[pos] == heroCid then
                inLevelCid = k
                break
            end
        end
    end

    return inLevelCid
end

function FubenEndlessPlusDataMgr:upHeroFormation(floorCid,levelCid,heroCid)

    if not self.heroFormation[floorCid] then
        self.heroFormation[floorCid] = {}
    end

    if not self.heroFormation[floorCid][levelCid] then
        self.heroFormation[floorCid][levelCid] = {}
    end

    local posId
    for pos =1,3 do
        if not self.heroFormation[floorCid][levelCid][pos] then
            posId = pos
            break
        end
    end

    if not posId then
        return
    end

    ---这里接入上阵协议
    ---self.heroFormation[floorCid][levelCid][posId] = heroCid
    self:groupFormationData(floorCid,levelCid,posId,heroCid)
end

function FubenEndlessPlusDataMgr:downHeroFormation(floorCid,levelCid,heroCid)

    if not self.heroFormation[floorCid] then
        return
    end

    if not self.heroFormation[floorCid][levelCid] then
        return
    end

    local posId
    for pos =1,3 do
        if self.heroFormation[floorCid][levelCid][pos] == heroCid then
            posId = pos
            break
        end
    end

    if not posId then
        return
    end

    self:groupFormationData(floorCid,levelCid,posId,0)
end

function FubenEndlessPlusDataMgr:groupFormationData(floorCid,levelCid,pos,heroCid)

    local curFormation = {}
    table.insert(curFormation,{ pos, heroCid})

    local formationData = {}
    table.insert(formationData,{levelCid,curFormation})

    self:Send_SetFormation(floorCid,formationData)
end


function FubenEndlessPlusDataMgr:Send_ExitChallenge()
    TFDirector:send(c2s.DUNGEON_REQ_CANCEL_CHALLENGE, {})
end

function FubenEndlessPlusDataMgr:Send_GetAllInfo()
    TFDirector:send(c2s.DUNGEON_REQ_CHALLENGE_INFO, {})
end

function FubenEndlessPlusDataMgr:Send_SetFormation(floor,formation)
    TFDirector:send(c2s.DUNGEON_REQ_SET_CHALLENGE_HERO, {floor,formation})
end

function FubenEndlessPlusDataMgr:getCurFloorCid()
    return self.curFloorCid
end

function FubenEndlessPlusDataMgr:setFormationData(floorCid,formation)
    ---
    if not self.heroFormation[floorCid] then
        self.heroFormation[floorCid] = {}
    end

    for _,v in ipairs(formation or {}) do
        local levelCid = v.round
        if not self.heroFormation[floorCid][levelCid] then
            self.heroFormation[floorCid][levelCid] = {}
        end

        local heroes = v.heroes or {}
        for k,heroData in ipairs(heroes) do
            print(heroData.hero,type(heroData.hero))
            if  heroData.hero == 0 then
                self.heroFormation[floorCid][levelCid][heroData.index] = nil
            else
                self.heroFormation[floorCid][levelCid][heroData.index] = heroData.hero
            end
        end
    end
end

function FubenEndlessPlusDataMgr:getRankInfoByFloor(floorCid)
    return self.rankDataInfo[floorCid]
end

function FubenEndlessPlusDataMgr:getPassRecordByFloor(floorCid)
    return self.passRecord[floorCid]
end

function FubenEndlessPlusDataMgr:getFloorCostTiem(floorid)

    return  self.floorCostTime[floorid] or 0

end

function FubenEndlessPlusDataMgr:onRecvAllInfo(event)

    local data = event.data
    if not data then
        return
    end

    ---阵容
    dump(data.roundFormation,"roundFormation")
    for k,v in ipairs(data.floorFormation or {}) do
        self:setFormationData(v.floor,v.formation)
    end

    dump(self.heroFormation,"heroFormation")

    ---排行榜
    self.rankDataInfo = {}
    local rankInfo = data.rankInfo or {}
    for k,v in ipairs(rankInfo) do
        self.rankDataInfo[v.floor] = v
    end

    ---自己的通关时间记录
    self.passRecord = {}
    local passFloor = data.passFloor or {}
    for k,v in ipairs(passFloor) do
        self.passRecord[v.floorId] = v.score
        self.curFloorCid = math.max(self.curFloorCid,v.floorId)
    end

    dump(data)

    EventMgr:dispatchEvent(EV_UPDATE_ENDLESSPLUS_ALLINFO)
end

---下一版用于清空精灵临时数据
function FubenEndlessPlusDataMgr:onRecvExitChallenge(event)

    local data = event.data
    if not data then
        return
    end

end


function FubenEndlessPlusDataMgr:onRecvSetFormation(event)

    local data = event.data
    if not data then
        return
    end
    dump(data.roundFormation,"roundFormation2")
    self:setFormationData(data.floor, data.roundFormation)
    dump(self.heroFormation,"heroFormation2")
    EventMgr:dispatchEvent(EV_UPDATE_ENDLESSPLUS_FORMATION)
end

function FubenEndlessPlusDataMgr:onUpdateCostTime(event)

    local data = event.data
    if not data then
        return
    end
    dump(data)
    --Box("x")
    self.floorCostTime[data.floor] = data.costTime
end

function FubenEndlessPlusDataMgr:getBuff(levelCid)

    local cfg = self.FloorDungeonLevelCfg[levelCid]
    if not cfg then
        return {}
    end

    local floorCfg = self:getFloorDungeonCfg(cfg.floorId)
    if not floorCfg then
        return
    end

    return floorCfg.buffId or {}
end

function FubenEndlessPlusDataMgr:getSelectBuffCid()
    return self.selectBuffCid
end

function FubenEndlessPlusDataMgr:setSelectBuffCid(selectBuffCid)
    self.selectBuffCid = selectBuffCid
end

function FubenEndlessPlusDataMgr:getStage()
    local stage = 1
    local serverTime = ServerDataMgr:getServerTime()
    for k,v in ipairs(self.kvpData) do
        if serverTime >= v.stime then
            stage = v.team
        end
    end
    return stage
end

function FubenEndlessPlusDataMgr:getKvpCfg(index)
    return self.kvpData[index]
end

function FubenEndlessPlusDataMgr:inStageTime()
    local inStage = false
    local serverTime = ServerDataMgr:getServerTime()
    for k,v in ipairs(self.kvpData) do
        if serverTime >= v.stime and serverTime < v.etime then
            inStage = true
            break
        end
    end
    return inStage
end

return FubenEndlessPlusDataMgr:new()
