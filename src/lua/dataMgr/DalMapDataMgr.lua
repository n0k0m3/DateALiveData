---
---
--- 大凉山探秘地图数据
---
---
local BaseDataMgr = import(".BaseDataMgr")
local DalMapDataMgr = class("DalMapDataMgr", BaseDataMgr)

function DalMapDataMgr:init()
    self:initData()
end

function DalMapDataMgr:initData()

    self.dalMapDressCfg = {}
    local mapDressCfg = TabDataMgr:getData("DalMapDress")
    for k,v in ipairs(mapDressCfg) do
        local mapType = v.mapType
        if not self.dalMapDressCfg[mapType] then
            self.dalMapDressCfg[mapType] = {}
        end
        self.dalMapDressCfg[mapType][v.dressGridId] = v
    end

    self.DlsWorldCfg = TabDataMgr:getData("DlsWorld")
    self.DlsMissionCfg = TabDataMgr:getData("DlsMission")
    self.DlsEventCfg = TabDataMgr:getData("DlsEvent")
    self.DlsformCfg = TabDataMgr:getData("Dlsform")
    self.DlsgameCfg = TabDataMgr:getData("Dlsgame")
    self.DlsServerDataCfg = TabDataMgr:getData("DlsServerData")
    self.DlsGridTypeCfg = TabDataMgr:getData("DlsGridType")

    self.isWin = true

    --统计数据处理
    self.tatisticsData = {}
    self.statistics = {}
    self.mergeType = {}
    local eventCountCfg = TabDataMgr:getData("DlsEventCount")
    for _,data in ipairs(eventCountCfg) do
        if not self.statistics[data.worldID] then
            self.statistics[data.worldID] = {}
        end
        table.insert(self.statistics[data.worldID],data)
    end

    self.floorGid = {}
    self.eventGid = {}
    for k,v in pairs(self.DlsGridTypeCfg) do
        if v.gridType == 1 then
            table.insert(self.eventGid,{gidType = v.id, gid = v.gridId})
        else
            self.floorGid[v.id] = v.gridId
        end
    end
    table.sort(self.eventGid,function(a,b)
        return a.gid < b.gid
    end)

    self:registerMsgEvent()
end

---生成地图初始化
function DalMapDataMgr:initMapData()

    self.floorGidId = {}
    self.dressGidId = {}
    self.paintedDressItem = {}

    --存储地图上物件(道具加上装饰)
    self.mapItemObj = {}

    --事件层的格子集合
    self.eventTiled = {}
end

-------------------------------地 图 数 据--------------------------

function DalMapDataMgr:addMapItemObj(tilePosStr,obj)
    if not self.mapItemObj then
        self.mapItemObj = {}
    end
    self.mapItemObj[tilePosStr] = obj
end

function DalMapDataMgr:getMapItemObj(tilePosStr)
    return self.mapItemObj[tilePosStr]
end

function DalMapDataMgr:cleanMapItemObj(tilePosStr)
    self.mapItemObj[tilePosStr] = nil
end

function DalMapDataMgr:setFloorGidId(tilePosStr,dressGidId)
    if not self.floorGidId then
        self.floorGidId = {}
    end
    self.floorGidId[tilePosStr] = dressGidId
end

function DalMapDataMgr:getFloorGidId(tilePosStr)
   return self.floorGidId[tilePosStr]
end

---记录装饰层的gidId
function DalMapDataMgr:setDressGidId(tilePosStr,tileInfo)
    if not self.dressGidId then
        self.dressGidId = {}
    end
    self.dressGidId[tilePosStr] = tileInfo
end

function DalMapDataMgr:getDressGidId(tilePosStr)

    if not tilePosStr then
        return self.dressGidId
    end

    return self.dressGidId[tilePosStr]
end

---记录已绘制的装置物件
function DalMapDataMgr:setPaintedDressItem(tilePosStr)
    if not self.paintedDressItem then
        self.paintedDressItem = {}
    end
    self.paintedDressItem[tilePosStr] = 1
end

function DalMapDataMgr:getPaintedDressItem(tilePosStr)
    return self.paintedDressItem[tilePosStr]
end

---得到gridType中的gridId集合(事件层)
function DalMapDataMgr:getCfgEventGid()
    return self.eventGid
end

function DalMapDataMgr:insertEventTiled(gidType,tileInfo)

    if not self.eventTiled[gidType] then
        self.eventTiled[gidType] = {}
    end
    table.insert(self.eventTiled[gidType],tileInfo)
end


function DalMapDataMgr:getTilePosByGid(tileType,gid)

    local tilesTab = self.eventTiled[tileType]
    if not tilesTab then
        return
    end

    local pos
    for k,v in ipairs(tilesTab) do
        if v.gid == gid then
            pos = v.pos
            break
        end
    end
    return pos
end

-------------------------------配 置 数 据--------------------------

function DalMapDataMgr:getDressCfgRes(mapType,dressGidId)
    if not self.dalMapDressCfg[mapType] then
        return
    end
    return self.dalMapDressCfg[mapType][dressGidId]
end

function DalMapDataMgr:getDlsWorldCfg(cid)
    return self.DlsWorldCfg[cid]
end

function DalMapDataMgr:getDlsMissionCfg(cid)
    return self.DlsMissionCfg[cid]
end

function DalMapDataMgr:getDlsEventCfg(cid)
    return self.DlsEventCfg[cid]
end

function DalMapDataMgr:getDlsgameCfg(cid)
    return self.DlsgameCfg[cid]
end

function DalMapDataMgr:getServerDataCfg(cid)
    return self.DlsServerDataCfg[cid]
end

function DalMapDataMgr:getTileAppearing()

    if not self.curWorldId or not self.DlsWorldCfg[self.curWorldId] then
        return 1
    end

    return self.DlsWorldCfg[self.curWorldId].tileAppearing
end

function DalMapDataMgr:getTileEventRes(eventId)

    if not self.DlsEventCfg[eventId] then
        return
    end

    local formID = self.DlsEventCfg[eventId].formID
    local showRes = self.DlsEventCfg[eventId].showRes
    local isDelete = self.DlsEventCfg[eventId].isDelete
    local offset
    local scaleInMap = 1
    local smallRes = self.DlsEventCfg[eventId].showRes
    local spineRes = self.DlsEventCfg[eventId].showSpine
    local npcName = self.DlsEventCfg[eventId].npcName or ""
    if self.DlsformCfg[formID] then
        showRes = self.DlsformCfg[formID].mapActorIcon
        offset = self.DlsformCfg[formID].offset
        scaleInMap = self.DlsformCfg[formID].scaleMap
        smallRes = self.DlsformCfg[formID].miniMapIcon
    end

    return showRes,smallRes,offset,scaleInMap,isDelete,spineRes,npcName
end

function DalMapDataMgr:isBossTask(missionId)
    if not self.DlsWorldCfg[self.curWorldId] then
        return
    end

    local isFinalTask = false
    local finalMission = self.DlsWorldCfg[self.curWorldId].finalMission
    for k,v in ipairs(finalMission) do
        if missionId == v then
            isFinalTask = true
        end
    end

    return isFinalTask,self.DlsWorldCfg[self.curWorldId].finalTaskDesc

end

function DalMapDataMgr:getMissionStage(missionId)

    if not self.DlsWorldCfg[self.curWorldId] then
        return
    end

    local missionParam = self.DlsWorldCfg[self.curWorldId].missionParam
    for stage,stageMissions in ipairs(missionParam) do
        for k,taskid in ipairs(stageMissions) do
            if missionId == taskid then
                return stage
            end
        end
    end
end

function DalMapDataMgr:getTaskStageDesc(taskStageId)

    if not self.DlsWorldCfg[self.curWorldId] then
        return
    end

    local desc = self.DlsWorldCfg[self.curWorldId].taskDesc[taskStageId]
    return desc
end

function DalMapDataMgr:getTaskTargetInfo(taskId)

    local nameTextId
    local taskType = self.DlsMissionCfg[taskId].missionType
    local param1,param2,param3 = self.DlsMissionCfg[taskId].checkParam[1],self.DlsMissionCfg[taskId].checkParam[2],self.DlsMissionCfg[taskId].checkParam[3]
    local targetNum = param2 or 1
    local isSearchTask = taskType == 1004
    if taskType == 1003 then
        local monster = TabDataMgr:getData("Monster")[param2]
        nameTextId = monster.name
        targetNum = param3
    elseif taskType == 1002 then
        local item = TabDataMgr:getData("Item")[param1]
        nameTextId = item.nameTextId
    end

    return nameTextId,targetNum,isSearchTask
end

function DalMapDataMgr:getFailedPlotId()

    local failedPlot = self.DlsWorldCfg[self.curWorldId].failedPlot
    if not failedPlot then
        return
    end
    return failedPlot
end

function DalMapDataMgr:getFinalPlot()
    if not self.curWorldId or not self.DlsWorldCfg[self.curWorldId] then
        return 0
    end
    return self.DlsWorldCfg[self.curWorldId].finalPlot
end

function DalMapDataMgr:getFightResult()
    return self.isWin
end

function DalMapDataMgr:overDalFight(isWin_)

    self.isWin = isWin_
end
-------------------------------服 务 器 数 据--------------------------

function DalMapDataMgr:isOpen(tilePosMN)
    local pos = tilePosMN.x .."-"..tilePosMN.y
    if not self.mapInfo[pos] then
        return false
    end
    return self.mapInfo[pos].visual
end

function DalMapDataMgr:getBirthPos()
    return self.birthPos
end

function DalMapDataMgr:setMapInfo(mapInfo)

    self.mapInfo = {}
    self.existEvent = {}
    for k,v in pairs(mapInfo) do
        local pos = v.x .."-"..v.y
        self.mapInfo[pos] = v
        --self.mapInfo[pos].visual = true
        if v.event > 0 then
            if not self.existEvent[v.event] then
                self.existEvent[v.event] = 0
            end
            self.existEvent[v.event] = self.existEvent[v.event] + 1
        end
    end
    dump(self.existEvent)
end

--刷新地图信息
function DalMapDataMgr:updateMapInfo(mapInfo)

    if not self.mapInfo then
        self.mapInfo = {}
    end

    if not mapInfo then
        return
    end

    for k,v in pairs(mapInfo) do
        local pos = v.x .."-"..v.y
        self.mapInfo[pos] = v
    end

    for k,v in pairs(self.mapInfo) do
        if v.event > 0 then
            if not self.existEvent[v.event] then
                self.existEvent[v.event] = 0
            end
            self.existEvent[v.event] = self.existEvent[v.event] + 1
        end
    end
end

function DalMapDataMgr:getMapTileInfo(tilePosStr)
    return self.mapInfo[tilePosStr]
end

---单独打开装饰格子
function DalMapDataMgr:setDressTiledOpen(tilePosStr)
    if self.mapInfo[tilePosStr] then
        self.mapInfo[tilePosStr].visual = true
    end
end

--事件统计
function DalMapDataMgr:setStatisticsData()

    self.statisticsData = {}
    
    local curMapStatisticData = self.statistics[self.curWorldId]
    if not curMapStatisticData then
        return
    end

    for k,v in ipairs(curMapStatisticData) do
        local showRes = self.DlsEventCfg[v.eventID].showRes
        if not self.statisticsData[v.eventID] then
            self.statisticsData[v.eventID] = {cfgData = v,count = v.count,res = showRes,remainCount = v.count,isCount = true}
        end
    end
end

function DalMapDataMgr:updateStatisticsData(eventId)

    if not self.existEvent[eventId] then
        return
    end
    self.existEvent[eventId] = self.existEvent[eventId] - 1
    if self.existEvent[eventId] < 0 then
        self.existEvent[eventId] = 0
    end
end

function DalMapDataMgr:getExistEventCnt(eventId)
    if not self.existEvent then
        return 0
    end

    if not self.existEvent[eventId] then
        return 0
    end

    return self.existEvent[eventId]
end

function DalMapDataMgr:getStatisticsData()

    for k,v in pairs(self.statisticsData) do
        v.remainCount = self:getExistEventCnt(k)
    end

    return self.statisticsData
end

function DalMapDataMgr:getMapMission()
    return self.missions or {}
end

function DalMapDataMgr:getEventRefreshTime()
    return self.eventRefresh
end

function DalMapDataMgr:getCurWorld()
    return self.curWorldId
end

function DalMapDataMgr:getMapCid()
    return self.mapCid
end

function DalMapDataMgr:getFormation()
    return self.formation or {}
end

function DalMapDataMgr:beInFormation(heroId)

    local selectRoleid = HeroDataMgr:getHeroRoleId(heroId);
    local index = 0
    local formation = self:getFormation()
    for k,v in pairs(formation) do
        local roleId = HeroDataMgr:getHeroRoleId(v);
        if roleId == selectRoleid then
            index =  k
            break
        end
    end
    return index
end

function DalMapDataMgr:isFirstEnter()
    return self.firstEnter
end

function DalMapDataMgr:isInWorld()
    return self.inWorldFlag
end

function DalMapDataMgr:setInWorldFage(inWorldFlag)
    self.inWorldFlag = inWorldFlag
end

function DalMapDataMgr:getAwardInst()
    return self.AwardInst
end

function DalMapDataMgr:setAwardInst(awardInst)
    self.AwardInst = awardInst
end

function DalMapDataMgr:showTaskAward(isFinalTask)

    if self.taskAwardList and next(self.taskAwardList) then
        self.AwardInst = Utils:openView("kabalaTree.KabalaTreeAward",self.taskAwardList,2,isFinalTask)
    end
    self.taskAwardList = nil
end

---设置是否完成阶段任务
function DalMapDataMgr:isFinishStageTask()
    return self.isCompleteStage
end

function DalMapDataMgr:setFinishStageTask()
    self.isCompleteStage = false
end

function DalMapDataMgr:getStepPlot()
    return self.stepPlot
end

function DalMapDataMgr:setStepPlot()
    self.stepPlot = nil
end

--设置终极任务完成与否
function DalMapDataMgr:setBosstaskState(isFinish)
    self.finishBossTask = isFinish
end

function DalMapDataMgr:isFinishBossTask()
    return self.finishBossTask
end

function DalMapDataMgr:getEventClearWorldCid()
    return self.finishWorldCid
end

function DalMapDataMgr:setEventClearWorldCid(worldCid)
    self.finishWorldCid = worldCid
end

function DalMapDataMgr:getPlayerPosMN()
    return self.playerPosMN
end

function DalMapDataMgr:setPlayerPosMN(tilePosMN)
    self.playerPosMN = tilePosMN
end

-------------------------------消 息 反 馈--------------------------
--发送请求进入世界信息
function DalMapDataMgr:Send_enterWorld(worldCid)
    TFDirector:send(c2s.OFFICE_EXPLORE_OFFICE_WORLD_INFO, {worldCid})
end

--7202
----进入地图反馈的数据
function DalMapDataMgr:onRecvWorldInfo(event)

    local data = event.data
    if not data then
        return
    end

    self.existEvent = {}
    self.curWorldId =  data.worldCid 											--世界Id
    self.birthPos = ccp(data.currentX,data.currentY) 							--当前坐标
    self:setMapInfo(data.points) 												--地图信息
    self.missions = data.missions 												--任务列表
    self.eventRefresh = data.eventRefresh 										--随机事件刷新时间点
    self.firstEnter = data.firstUse                                             --(周期内)第一次进图
    self.mapCid = data.mapCid 													--地图ID
    self.formation = data.formation

    self:setStatisticsData()

    EventMgr:dispatchEvent(EV_DAL_MAP.GetMap)
end

--7203
----触发事件
function DalMapDataMgr:onRecvTriggerEvent(event)

    local data = event.data
    if not data then
        return
    end

    EventMgr:dispatchEvent(EV_DAL_MAP.TriggerEvent,data.eventInfo.eventId,ccp(data.eventInfo.x,data.eventInfo.y))
end

--7205
----移动消息(同步当前格子和周围格子数据)
function DalMapDataMgr:onRecvPlayerMove(event)

    local data = event.data
    if not data then
        return
    end
    local mapPoint = data.mapPoint
    if not mapPoint then
        return
    end
    if mapPoint.event == 0 then
        local exist = TiledMapDataMgr:getMapItem(mapPoint.x.."-"..mapPoint.y)
        if exist then
            local originalEventId = 0
            if  self.mapInfo[mapPoint.x.."-"..mapPoint.y] then
                originalEventId = self.mapInfo[mapPoint.x.."-"..mapPoint.y].event
                self.mapInfo[mapPoint.x.."-"..mapPoint.y].event = 0
            end
            EventMgr:dispatchEvent(EV_DAL_MAP.CleanItem,ccp(mapPoint.x,mapPoint.y),originalEventId)
        end
    end

    if mapPoint.foundPoints then
        for k,v in ipairs(mapPoint.foundPoints) do
            self.mapInfo[v.x.."-"..v.y].visual = true
        end
    end
    EventMgr:dispatchEvent(EV_DAL_MAP.Move,ccp(mapPoint.x,mapPoint.y),mapPoint.foundPoints)

end

--7211
----传送消息(同步当前格子和周围格子数据)
function DalMapDataMgr:onRecvPlayerTransfer(event)

    local data = event.data
    if not data then
        return
    end
    if data.currentPoint.foundPoints then
        for k,v in ipairs(data.currentPoint.foundPoints) do
            self.mapInfo[v.x.."-"..v.y].visual = true
        end
    end
    EventMgr:dispatchEvent(EV_DAL_MAP.Transfer,ccp(data.currentPoint.x,data.currentPoint.y),data.currentPoint.foundPoints)

end

--7207
----任务信息
function DalMapDataMgr:onRecvMissionInfo(event)

    local data = event.data
    if not data then
        return
    end

    self.missions = data.missions
    if not self.missions[1] then
        return
    end
    local id = self.missions[1].missionId

    if not data.completed then
        EventMgr:dispatchEvent(EV_DAL_MAP.Task,false)
        return
    end

    -----以下全是完成任务阶段逻辑
    if not self.DlsWorldCfg[self.curWorldId] then
        EventMgr:dispatchEvent(EV_DAL_MAP.Task,false)
        return
    end

    --检测是否是终极任务
    if self:isBossTask(id) then
        local finalPlot = self.DlsWorldCfg[self.curWorldId].finalPlot
        self:setBosstaskState(true)
        if self:isInWorld() then
            EventMgr:dispatchEvent(EV_DAL_MAP.Task,true,finalPlot)
        end
        return
    end

    local stage = self:getMissionStage(id)
    if not stage then
        EventMgr:dispatchEvent(EV_DAL_MAP.Task,false)
        return
    end

    local stepPlot = self.DlsWorldCfg[self.curWorldId].stepPlot[stage]
    if not stepPlot then
        EventMgr:dispatchEvent(EV_DAL_MAP.Task,false)
        return
    end

    self.isCompleteStage = true
    self.stepPlot = stepPlot
    if self:isInWorld() then
        EventMgr:dispatchEvent(EV_DAL_MAP.Task,true,self.stepPlot)
    end
end

--7219
----完成任务刷新地图数据
function DalMapDataMgr:onRecvUpdateMap(event)

    local data = event.data
    if not data then
        return
    end

    --只刷新改变的地图数据
    self.existEvent = {}
    self:updateMapInfo(data.points)

    EventMgr:dispatchEvent(EV_DAL_MAP.UpdateMap,data.points)

end

--7223
----刷新随机事件
function DalMapDataMgr:onRecvRandomEvents(event)

    local data = event.data
    if not data then
        return
    end

    local eventsInfo = data.eventsInfo
    if not eventsInfo then
        return
    end
    self.eventRefresh = eventsInfo.eventRefresh
    self.existEvent = {}
    self:updateMapInfo(eventsInfo.points)
    EventMgr:dispatchEvent(EV_UPDATE_RANDOMEVENT)
    EventMgr:dispatchEvent(EV_DAL_MAP.UpdateMap,eventsInfo.points)
end

--7228
----小游戏
function DalMapDataMgr:onTriggerGameEvent(event)

    local data = event.data
    if not data then return end
    local gameInfo = data.gameInfo
    if not gameInfo then
        return
    end
    local cfg = self:getDlsgameCfg(gameInfo.gameCid)
    if not cfg then
        return
    end

    if cfg.gameType == 1006 then
        Utils:openView("dalMap.DalGame",gameInfo)
    end
end

--7215
----拾取道具
function DalMapDataMgr:onRecvEventItem(event)

    local data = event.data
    if not data then
        return
    end

    local allitems = data.eventItems.items
    if not allitems then
        return
    end

    -- 道具
    local awardList = {}
    if allitems.items then
        for k, v in pairs(allitems.items) do
            table.insert(awardList,{id = v.cid,num = v.num})
        end
    end

    if allitems.equipments then
        for k, v in pairs(allitems.equipments) do
            table.insert(awardList,{id = v.cid,num = v.num})
        end
    end

    if allitems.dresss then
        for k, v in pairs(allitems.dresss) do
            table.insert(awardList,{id = v.cid,num = v.num})
        end
    end

    self.AwardInst = Utils:openView("kabalaTree.KabalaTreeAward",awardList,2)
end

--7216
----完成任务活动奖励
function DalMapDataMgr:onRecvFinishTask(event)

    local data = event.data
    if not data then
        return
    end

    local allitems = data.items
    if not allitems then
        return
    end

    local awardList = {}
    if allitems.items then
        for k, v in pairs(allitems.items) do
            table.insert(awardList,{id = v.cid,num = v.num})
        end
    end

    if allitems.equipments then
        for k, v in pairs(allitems.equipments) do
            table.insert(awardList,{id = v.cid,num = v.num})
        end
    end

    if allitems.dresss then
        for k, v in pairs(allitems.dresss) do
            table.insert(awardList,{id = v.cid,num = v.num})
        end
    end

    self.taskAwardList = awardList
    if self:isInWorld() and (not self.finishBossTask) then
        self.AwardInst = Utils:openView("kabalaTree.KabalaTreeAward",awardList,2)
    end
end

--7204
----换阵
function DalMapDataMgr:onRecvFormationInfo(event)

    local data = event.data
    if not data then
        return
    end

    self.formation = data.formation
    EventMgr:dispatchEvent(EV_DAL_MAP.Formation)
end

--7220
----交互事件
function DalMapDataMgr:onRecvPerformEvent(event)

end

--7229
----小游戏返回
function  DalMapDataMgr:onRecvMiniGameReply(event)

    local data = event.data
    if not data then
        return
    end

    local gameInfo = data.gameInfo
    if not gameInfo then
        return
    end
    local awardList = {}
    local allitems = gameInfo.items
    if allitems then
        if allitems.items then
            for k, v in pairs(allitems.items) do
                table.insert(awardList,{id = v.cid,num = v.num})
            end
        end

        if allitems.equipments then
            for k, v in pairs(allitems.equipments) do
                table.insert(awardList,{id = v.cid,num = v.num})
            end
        end

        if allitems.dresss then
            for k, v in pairs(allitems.dresss) do
                table.insert(awardList,{id = v.cid,num = v.num})
            end
        end
    end
    EventMgr:dispatchEvent(EV_DAL_MAP.MiniGameReply,gameInfo.gameCid,awardList,gameInfo.options)
end

--7105
----任务事件完成信息
function DalMapDataMgr:onRecvEventClear(event)

    local data = event.data
    if not data then
        return
    end
    dump(data)
    --Box("11111111111")
    self.finishWorldCid = data.worldCid
end

--注册服务器消息事件
function DalMapDataMgr:registerMsgEvent()

    TFDirector:addProto(s2c.OFFICE_EXPLORE_OFFICE_WORLD_INFO, self, self.onRecvWorldInfo)
    TFDirector:addProto(s2c.OFFICE_EXPLORE_OFFICE_AREA_EVENT, self, self.onRecvTriggerEvent)
    TFDirector:addProto(s2c.OFFICE_EXPLORE_OFFICE_AREA_MAP_POINT, self, self.onRecvPlayerMove)
    TFDirector:addProto(s2c.OFFICE_EXPLORE_OFFICE_TRANSFORM, self, self.onRecvPlayerTransfer)
    TFDirector:addProto(s2c.OFFICE_EXPLORE_OFFICE_MISSIONS, self, self.onRecvMissionInfo)
    TFDirector:addProto(s2c.OFFICE_EXPLORE_OFFICE_POINTS_REFRESH, self, self.onRecvUpdateMap)
    TFDirector:addProto(s2c.OFFICE_EXPLORE_OFFICE_RANDOM_EVENTS, self, self.onRecvRandomEvents)
    TFDirector:addProto(s2c.OFFICE_EXPLORE_OFFICE_GAME_EVENT, self, self.onTriggerGameEvent)
    TFDirector:addProto(s2c.OFFICE_EXPLORE_OFFICE_ITEMS_EVENT, self, self.onRecvEventItem)
    TFDirector:addProto(s2c.OFFICE_EXPLORE_OFFICE_TASK_REWARD, self, self.onRecvFinishTask)
    TFDirector:addProto(s2c.OFFICE_EXPLORE_OFFICE_FORMATION, self, self.onRecvFormationInfo)
    TFDirector:addProto(s2c.OFFICE_EXPLORE_OFFICE_PERFORM_EVENT, self, self.onRecvPerformEvent)
    TFDirector:addProto(s2c.OFFICE_EXPLORE_OFFICE_REPLY_GAME, self, self.onRecvMiniGameReply)
    TFDirector:addProto(s2c.OFFICE_EXPLORE_EVENTS_CLEAR, self, self.onRecvEventClear)

end
return DalMapDataMgr:new();
---