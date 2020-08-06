local BaseDataMgr = import(".BaseDataMgr")
local CourageDataMgr = class("CourageDataMgr", BaseDataMgr)

function CourageDataMgr:ctor()
    self:init()
end

function CourageDataMgr:registerMsgEvent()

    TFDirector:addProto(s2c.SUMMER_COURAGE_RES_SUMMER_COURAGE_EXPLORE, self, self.onRecvAfterAskMove)
    TFDirector:addProto(s2c.SUMMER_COURAGE_RES_EVT_FINISH, self, self.onRecvEventFinish)
    TFDirector:addProto(s2c.SUMMER_COURAGE_RES_CHOOSE_AREA, self, self.onRecvChooseArea)
    TFDirector:addProto(s2c.SUMMER_COURAGE_RES_CHAPTER_MAP, self, self.onRecvMapData)
    TFDirector:addProto(s2c.SUMMER_COURAGE_RES_EQUIP, self, self.onRecvAfterEquip)
    TFDirector:addProto(s2c.SUMMER_COURAGE_RES_DISCHARGE, self, self.onRecvAfterDisEquip)
    TFDirector:addProto(s2c.SUMMER_COURAGE_RES_GAME_START, self, self.onRecvGameStart)
    TFDirector:addProto(s2c.SUMMER_COURAGE_RES_GAME_FINISH, self, self.onRecvGameFinish)
    TFDirector:addProto(s2c.SUMMER_COURAGE_RES_SUMMER_COURAGE_ENTER, self, self.onRecvCourageEnter)
    TFDirector:addProto(s2c.SUMMER_COURAGE_RES_SUMMER_COURAGE_RESTART, self, self.onRecvReStart)
    TFDirector:addProto(s2c.SUMMER_COURAGE_SUMMER_LOG_NOTICE, self, self.onRecvLogNotice)
    TFDirector:addProto(s2c.SUMMER_COURAGE_SETTLEMENT_NOTICE, self, self.onRecvSettleMent)
    TFDirector:addProto(s2c.SUMMER_COURAGE_AP_INFO_NOTICE, self, self.onRecvUpdateAp)
    TFDirector:addProto(s2c.SUMMER_COURAGE_RES_REAL_ENTER, self, self.onRecvEnterGame)
    TFDirector:addProto(s2c.SUMMER_COURAGE_RESCUE_HERO_NOTICE, self, self.onRecvRescueHero)

    TFDirector:addProto(s2c.SUMMER_COURAGE_RES_NEWBIE_STEP_INFO, self, self.recvTriggerGuideGroup)
    TFDirector:addProto(s2c.SUMMER_COURAGE_RES_RECORD_NEWBIE_STEP, self, self.recvTriggerGuideStep)
    TFDirector:addProto(s2c.SUMMER_COURAGE_RES_SWITCH_NEWBIE, self, self.recvNewGuideState)

end

function CourageDataMgr:init()
    self:initData()
    self:registerMsgEvent()
end

function CourageDataMgr:initData()

    ---地图
    self.mapData_ = {}
    self.mapcfg = TabDataMgr:getData("MazeDMap")
    for k,v in pairs(self.mapcfg) do
        if not self.mapData_[v.mazeDId] then
            self.mapData_[v.mazeDId] = {}
        end
        self.mapData_[v.mazeDId][v.id] = v
    end

    ---日志
    self.subLogCfg = {}
    self.MazeDLog = TabDataMgr:getData("MazeDLog")
    for k,v in pairs(self.MazeDLog) do
        if v.logType == 2 then
            if not self.subLogCfg[v.logGroup] then
                self.subLogCfg[v.logGroup] = {}
            end
            table.insert(self.subLogCfg[v.logGroup],v)
        end
    end

    ---事件
    self.eventCfg = TabDataMgr:getData("MazeDScriptMgr")

    ---小游戏
    self.MazeDGamesCfg = TabDataMgr:getData("MazeDGames")

    ---路径
    self.pathCfg = {}
    self.MazeDRoad = TabDataMgr:getData("MazeDRoad")
    for k,v in ipairs(self.MazeDRoad) do
        local path = v.areaA.."-"..v.areaB
        self.pathCfg[path] = v.pathAtoB
        local path2 = v.areaB.."-"..v.areaA
        self.pathCfg[path2] = v.pathBtoA
    end

    ---
    self.MazeDMgrCfg = TabDataMgr:getData("MazeDMgr")
end


function CourageDataMgr:onLogin()

    --TFDirector:send(c2s.SUMMER_COURAGE_REQ_NEWBIE_STEP_INFO, {})
    --return {s2c.SUMMER_COURAGE_RES_NEWBIE_STEP_INFO}
end

function CourageDataMgr:onEnterMain()
    self.areaInfoList = {}
    self.minorInfoIds = {}
    self.mainLogInfo = {}
    self.branchLogInfo = {}

    self.mainLogIds = {}
    self.branchLogIds = {}


    self.equipInfoList = {}
    self.eventId = nil
    self.triggerGuideGroup = {}
    self.currentEvtId = 0
end

function CourageDataMgr:getGameCfg(cid)
    if not cid then
        return self.MazeDGamesCfg
    end
    return self.MazeDGamesCfg[cid]
end

function CourageDataMgr:getMapCfgByType(mazeDId)
    if not mazeDId then
        return self.mapData_
    end
    return self.mapData_[mazeDId]
end

function CourageDataMgr:getMapCfgInfo(mazeDId,mapId)
    return self.mapData_[mazeDId][mapId]
end

function CourageDataMgr:getMapCfgByCid(cid)
    return self.mapcfg[cid]
end

function CourageDataMgr:getEventCfg(cid)
    return self.eventCfg[cid]
end

function CourageDataMgr:getPathInfo(path)
    return self.pathCfg[path]
end

function CourageDataMgr:getRoadCfg(pathCid)
    return self.MazeDRoad[pathCid]
end

--mainCid:主条目ID
function CourageDataMgr:getSubLogCfgByMainCid(mainCid)
    local allSubLog = {}
    if not self.subLogCfg[mainCid] then
        return {}
    end
    for k,v in ipairs(self.subLogCfg[mainCid]) do
        local subLogData = self:getSubLogInfo(v.id)
        if subLogData then
            table.insert(allSubLog,v)
        end
    end

    table.sort(allSubLog,function(a,b)
        local infoA = self:getSubLogInfo(a.id)
        local infoB = self:getSubLogInfo(b.id)
        if infoA.time == infoB.time then
            return a.id < b.id
        else
            return infoA.time < infoB.time
        end
    end)

    return allSubLog
end

--mainCid:主条目ID
function CourageDataMgr:getNewSubLogCfg(mainCid)

    if not self.subLogCfg[mainCid] then
        return
    end
    local newTime = 0
    local newSubLog
    for k,v in ipairs(self.subLogCfg[mainCid]) do
        local subLogData = self:getSubLogInfo(v.id)
        if subLogData and subLogData.time > newTime then
            newSubLog = v
            newTime = subLogData.time
        end
    end
    return newSubLog

end

function CourageDataMgr:getLogCfgData(cid)
    return self.MazeDLog[cid]
end

function CourageDataMgr:getMazeDMgrCfg(cid)

    if not cid then
        return self.MazeDMgrCfg
    end

    return self.MazeDMgrCfg[cid]
end

function CourageDataMgr:setEventID(eventId)
    self.eventId = eventId
end

function CourageDataMgr:getEventID()
    return self.eventId
end

function CourageDataMgr:getApInfo()
    return self.apInfo
end

function CourageDataMgr:getAreaInfo(areaId)
    if not areaId then
        return self.areaInfoList
    end
    return self.areaInfoList[areaId]
end

function CourageDataMgr:getEquipInfo()
    return self.equipInfoList
end

function CourageDataMgr:isEquiped(cid)
    local isEquiped = false
    for k,v in ipairs(self.equipInfoList) do
        if v.equipId == cid then
            isEquiped = true
            break
        end
    end
    return isEquiped
end

function CourageDataMgr:getCurLocation()
    return self.currentChapterId,self.currentAreaId
end

function CourageDataMgr:setNewChapterFlage(flag)
    self.isNewChapter = flag
end

function CourageDataMgr:isNewOpenChapter()
    return self.isNewChapter
end

function CourageDataMgr:getCurEventId()
    return self.currentEvtId
end

function CourageDataMgr:getUnlockChapter()
    return self.unlockChapterInfo
end

function CourageDataMgr:getMainLogInfo()
    return self.mainLogInfo
end

function CourageDataMgr:getBranchLogInfo()
    return self.branchLogInfo
end

function CourageDataMgr:getSubLogInfo(id)
    return self.minorInfoIds[id]
end

function CourageDataMgr:setMinGameResult(result)
    self.miniGameResult = result
end

function CourageDataMgr:getMiniGameResult()
    return self.miniGameResult
end

function CourageDataMgr:getEndInfo()
    return self.script,self.rewardInfo,self.apItemInfo
end


function CourageDataMgr:getGuideState()
    return self.newGuideState
end

function CourageDataMgr:setGuideState(state)
    self.newGuideState = state  or false
end

function CourageDataMgr:getEnterNum()
    return self.enterNum or 0
end

function CourageDataMgr:getTriggerGuideGroupIds()
    return self.triggerGuideGroup
end

function CourageDataMgr:addTriggerGuideGroupId(id)
    table.insert(self.triggerGuideGroup,id)
    TFDirector:send(c2s.SUMMER_COURAGE_REQ_RECORD_NEWBIE_STEP, {id})
end

function CourageDataMgr:Send_guideState()
    TFDirector:send(c2s.SUMMER_COURAGE_REQ_SWITCH_NEWBIE, {})
end

function CourageDataMgr:Send_GetBaseInfo()
    TFDirector:send(c2s.SUMMER_COURAGE_REQ_SUMMER_COURAGE_ENTER, {})
end

function CourageDataMgr:Send_AskMove()
    TFDirector:send(c2s.SUMMER_COURAGE_REQ_SUMMER_COURAGE_EXPLORE, {self.currentChapterId,self.currentAreaId})
end

function CourageDataMgr:Send_finishEvent(eventId)
    TFDirector:send(c2s.SUMMER_COURAGE_REQ_EVT_FINISH, {self.currentChapterId,self.currentAreaId,eventId})
end

function CourageDataMgr:Send_moveOtherArea(nextAreaId,evtId)
    TFDirector:send(c2s.SUMMER_COURAGE_REQ_CHOOSE_AREA, {self.currentChapterId,self.currentAreaId,nextAreaId,evtId})
end

function CourageDataMgr:Send_GetMapInfo()
   TFDirector:send(c2s.SUMMER_COURAGE_REQ_CHAPTER_MAP, {self.currentChapterId})
end

function CourageDataMgr:Send_HandleEquip(isEquip,equipId)
    if isEquip then
        TFDirector:send(c2s.SUMMER_COURAGE_REQ_EQUIP, {equipId})
    else
        TFDirector:send(c2s.SUMMER_COURAGE_REQ_DISCHARGE, {equipId})
    end
end

function CourageDataMgr:Send_StartGame(gameType)
    TFDirector:send(c2s.SUMMER_COURAGE_REQ_GAME_START, {gameType})
end

function CourageDataMgr:Send_GameResult(gameType,orderList)
   TFDirector:send(c2s.SUMMER_COURAGE_REQ_GAME_FINISH, {gameType,orderList})
end

function CourageDataMgr:Send_Restart(type_)
    TFDirector:send(c2s.SUMMER_COURAGE_REQ_SUMMER_COURAGE_RESTART, {type_})
end

function CourageDataMgr:Send_EnterGame()
    TFDirector:send(c2s.SUMMER_COURAGE_REQ_REAL_ENTER, {})
end
--

function CourageDataMgr:onRecvReStart(event)
    local data = event.data
    if not data then
        return
    end
    dump(data)
end

function CourageDataMgr:onRecvAfterAskMove(event)

    local data = event.data
    if not data then
        return
    end
    dump(data)
    local eventId = data.evtId
    self:setEventID(eventId)
    EventMgr:dispatchEvent(EV_COURAGE.EV_ASK_MOVE)
end

function CourageDataMgr:onRecvEventFinish(event)

    local data = event.data
    if not data then
        return
    end
    dump(data)
    self:setEventID()
    self.apInfo = data.ap
    EventMgr:dispatchEvent(EV_COURAGE.EV_UPDATE_FINISH)
end

function CourageDataMgr:onRecvChooseArea(event)

    local data = event.data
    if not data then
        return
    end

    local areaData = data.areaInfoList or {}
    for k,v in ipairs(areaData) do
        self.areaInfoList[v.areaId] = v
    end

    self.currentAreaId = data.currentAreaId
    dump(data)
    EventMgr:dispatchEvent(EV_COURAGE.EV_UPDATA_MAP,true)
end

function CourageDataMgr:onRecvMapData(event)

    local data = event.data
    if not data then
        return
    end

    local areaData = data.areaInfoList or {}
    for k,v in ipairs(areaData) do
        self.areaInfoList[v.areaId] = v
    end

    self.currentAreaId = data.currentAreaId

    EventMgr:dispatchEvent(EV_COURAGE.EV_UPDATA_MAP)
end

function CourageDataMgr:onRecvAfterEquip(event)

    local data = event.data
    if not data then
        return
    end
    dump(data)
    self.equipInfoList = data.equipInfoList or {}
    EventMgr:dispatchEvent(EV_COURAGE.EV_HANDLE_EQUIP)
end

function CourageDataMgr:onRecvAfterDisEquip(event)

    local data = event.data
    if not data then
        return
    end
    dump(data)
    self.equipInfoList = data.equipInfoList or {}
    EventMgr:dispatchEvent(EV_COURAGE.EV_HANDLE_EQUIP)
end

function CourageDataMgr:onRecvGameStart(event)

    local data = event.data
    if not data then
        return
    end
    dump(data)
    EventMgr:dispatchEvent(EV_COURAGE.EV_MINIGAME_START,data.orderList)

end

function CourageDataMgr:onRecvGameFinish(event)

    local data = event.data
    if not data then
        return
    end
    EventMgr:dispatchEvent(EV_COURAGE.EV_MINIGAME_FINISH,data)
end

function CourageDataMgr:onRecvCourageEnter(event)

    local data = event.data
    if not data then
        return
    end

    self.apInfo = data.ap or {}
    local areaData = data.areaInfoList or {}
    for k,v in ipairs(areaData) do
        self.areaInfoList[v.areaId] = v
    end
    --dump(data)
    self.equipInfoList = data.equipInfoList or {}
    self.currentAreaId = data.currentAreaId
    self.currentChapterId = data.currentChapterId
    self.currentEvtId = data.currentEvtId
    self.unlockChapterInfo = data.unlockChapterInfo or {}
    self:setEventID(data.currentEvtId)
    self:setNewChapterFlage(data.isNewChapter)
    EventMgr:dispatchEvent(EV_COURAGE.EV_UPDATA_MAP)
    EventMgr:dispatchEvent(EV_COURAGE.EV_NEWGUIDE_BASEINFO)

end

function CourageDataMgr:onRecvLogNotice(event)

    local data = event.data
    if not data then
        return
    end


    local type = data.type
    if type == 1 then
        self.branchLogInfo = {}
        self.mainLogInfo = {}
        self.minorInfoIds = {}

        self.mainLogIds = {}
        self.branchLogIds = {}
    end

    local mainLog =  data.mainLogInfo or {}
    local minorInfo = data.minorInfo or {}
    for k,v in ipairs(minorInfo) do
        self.minorInfoIds[v.logId] = v
    end

    ---初始信息
    if type == 1 then
        for k,v in ipairs(mainLog) do
            local logCfg = self:getLogCfgData(v.logId)
            if logCfg then
                if logCfg.mainLogType == 1 then
                    table.insert(self.mainLogInfo,v)
                    self.mainLogIds[v.logId] = v
                else
                    table.insert(self.branchLogInfo,v)
                    self.branchLogIds[v.logId] = v
                end
            end
        end
    end

    ---更新信息
    if type == 2 then
        for k,v in ipairs(mainLog) do
            local logCfg = self:getLogCfgData(v.logId)
            if logCfg then
                if logCfg.mainLogType == 1 then
                    if not self.mainLogIds[v.logId] then
                        table.insert(self.mainLogInfo,v)
                        self.mainLogIds[v.logId] = v
                    else
                        for mainId,mainInfo in ipairs(self.mainLogInfo) do
                            if mainInfo.logId == v.logId then
                                self.mainLogInfo[mainId] = v
                                break
                            end
                        end
                    end
                else
                    if not self.branchLogIds[v.logId] then
                        table.insert(self.branchLogInfo,v)
                        self.branchLogIds[v.logId] = v
                    else
                        for bId,branchInfo in ipairs(self.branchLogInfo) do
                            if branchInfo.logId == v.logId then
                                self.branchLogInfo[bId] = v
                            end
                        end
                    end
                end
            end
        end
    end

    dump(data)
    if type == 2 then
        EventMgr:dispatchEvent(EV_COURAGE.EV_UPDATE_EVENT_LOG,true,mainLog,minorInfo)
    end
end

---结算
function CourageDataMgr:onRecvSettleMent(event)
    local data = event.data
    if not data then
        return
    end
    dump(data.ap)
    dump(data.script)
    dump(data.rewardInfo)
    dump(data.apItemInfo)

    self.apInfo = data.ap or {}
    self.script = data.script or {}
    self.rewardInfo = data.rewardInfo or {}
    self.apItemInfo = data.apItemInfo or {}
    Utils:openView("courage.CourageEndView")
end

function CourageDataMgr:onRecvUpdateAp(event)
    local data = event.data
    if not data then
        return
    end
    self.apInfo = data.apInfo or {}
    EventMgr:dispatchEvent(EV_COURAGE.EV_UPDATE_AP)

end

function CourageDataMgr:recvTriggerGuideGroup(event)
    local data = event.data
    if not data then
        return
    end
    self.triggerGuideGroup = {}
    self.triggerGuideGroup = data.stepInfo or {}
    dump(self.triggerGuideGroup)
    self:setGuideState(data.open)
end

function CourageDataMgr:recvNewGuideState(event)
    local data = event.data
    if not data then
        return
    end
    self:setGuideState(data.open)
    EventMgr:dispatchEvent(EV_COURAGE.EV_NEWGUIDE_STATE)
end

function CourageDataMgr:recvTriggerGuideStep()

end

function CourageDataMgr:onRecvEnterGame()
    Utils:openView("courage.CourageMainView")
    local layer = requireNew("lua.logic.courage.CourageSbView"):new()
    AlertManager:addLayer(layer, AlertManager.BLOCK)
    AlertManager:show()
end

function CourageDataMgr:onRecvRescueHero(event)
    local data = event.data
    if not data then
        return
    end
    EventMgr:dispatchEvent(EV_COURAGE.EV_RESCUR_HERO,data.scriptId)

end

return CourageDataMgr:new();
