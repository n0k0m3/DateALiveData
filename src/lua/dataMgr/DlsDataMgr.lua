
local UserDefault = CCUserDefault:sharedUserDefault()
local BaseDataMgr = import(".BaseDataMgr")
local DlsDataMgr = class("DlsDataMgr", BaseDataMgr)

function DlsDataMgr:init()
    TFDirector:addProto(s2c.OFFICE_EXPLORE_OFFICE_EXPLORE_TIME, self, self.onRecvOpenTime)
    TFDirector:addProto(s2c.OFFICE_EXPLORE_AREA_OUTLINE, self, self.onRecvAreaInfo)
    TFDirector:addProto(s2c.OFFICE_EXPLORE_AREA_MOVE, self, self.onRecvAreaMove)
    TFDirector:addProto(s2c.OFFICE_EXPLORE_TASKS_COMPLETE, self, self.onRecvCompleteTask)
    TFDirector:addProto(s2c.OFFICE_EXPLORE_OFFICE_COMPLTE_EVENTS, self, self.onRecvCompleteEvent)

    local dlsMapPathMap = TabDataMgr:getData("DlsMapPath")
    self.dlsMapPath_ = {}
    for k, v in pairs(dlsMapPathMap) do
        if v.judgespot then
            if self.beginSite_ then
                Box("表DlsMapPath不能出现多个初始点位!!!")
            else
                self.beginSite_ = k
            end
        end
        for _, site in ipairs(v.path) do
            self.dlsMapPath_[site] = k
        end
    end
    if not self.beginSite_ then
        Box("表DlsMapPath未配置初始点位!!!")
    end

    self.dlsDungenMap_ = TabDataMgr:getData("Dlsdungen")
    self.dlsDungen_ = {}
    for k, v in pairs(self.dlsDungenMap_) do
        self.dlsDungen_[v.site] = k
    end

    self.dlsQuestionMap_ = TabDataMgr:getData("Dlsquestion")
    self.dlsQuestion_ = {}
    for k, v in pairs(self.dlsQuestionMap_) do
        table.insert(self.dlsQuestion_, k)
    end
    self.questionCount_ = 10

    self.openAreas_ = {}
    self.complateTask_ = {}
    self.completeEvent_ = {}
    self.isFirstEnter_ = nil
end

function DlsDataMgr:reset()
    self.openAreas_ = {}
    self.complateTask_ = {}
    self.completeEvent_ = {}
    self.isFirstEnter_ = nil
end

function DlsDataMgr:onLogin()
    TFDirector:send(c2s.OFFICE_EXPLORE_OFFICE_EXPLORE_TIME, {})
    TFDirector:send(c2s.OFFICE_EXPLORE_AREA_OUTLINE, {})
    return {s2c.OFFICE_EXPLORE_OFFICE_EXPLORE_TIME, s2c.OFFICE_EXPLORE_AREA_OUTLINE}
end

function DlsDataMgr:onEnterMain()
    local pid = MainPlayer:getPlayerId()
    self.KEY_DLS_QUESTION_INFO = string.format("key_%s_dls_question_info", pid)
    self.KEY_DLS_FIRST_ENTER = string.format("key_%s_dls_first_enter", pid)

    self:getCacheQuestion()
end

function DlsDataMgr:generateQuestion()
    self.questionInfo_ = {}
    local questionInfo = {}
    local question = Utils:shuffle(clone(self.dlsQuestion_))
    local countInfo = {}
    local count = 0
    for i, cid in ipairs(question) do
        local questionCfg = self.dlsQuestionMap_[cid]
        local remainCount = self.questionCount_ - count
        if i < #question then
            local c = math.random(questionCfg.randomNum[1], questionCfg.randomNum[2])
            c = math.min(c, remainCount)
            if c == 0 then
                break
            end
            countInfo[cid] = c
            count = count + c
        else
            countInfo[cid] = math.max(0, remainCount)
        end
    end

    for cid, v in pairs(countInfo) do
        local questionCfg = self.dlsQuestionMap_[cid]
        local descId = Utils:shuffle(clone(questionCfg.descId))
        for i = 1, v do
            local index = table.indexOf(questionCfg.descId, descId[i])
            if index == -1 then
                index = 1
            end
            table.insert(questionInfo, {id = cid, index = index, open = false})
        end
    end
    Utils:shuffle(questionInfo)
    self:cacheQuestion(questionInfo)
    self.questionInfo_ = questionInfo
    return questionInfo
end

function DlsDataMgr:cacheQuestion(questionInfo)
    local content = json.encode(questionInfo)
    UserDefault:setStringForKey(self.KEY_DLS_QUESTION_INFO, content)
end

function DlsDataMgr:setQuestionOpenState(index, open)
    local question = self.questionInfo_[index]
    question.open = tobool(open)
    self:cacheQuestion(self.questionInfo_)
end

function DlsDataMgr:isFirstEnter()
    if self.isFirstEnter_ == nil then
        local content = UserDefault:getStringForKey(self.KEY_DLS_FIRST_ENTER)
        dump(content)
        if content == "false" then
            self.isFirstEnter_ = false
        else
            self.isFirstEnter_ = true
        end
    end
    return self.isFirstEnter_
end

function DlsDataMgr:setFirstEnter(isFirstEnter)
    if self.isFirstEnter_ == isFirstEnter then return end
    self.isFirstEnter_ = tobool(isFirstEnter)
    local content = self.isFirstEnter_ and "true" or "false"
    UserDefault:setStringForKey(self.KEY_DLS_FIRST_ENTER, content)
end

function DlsDataMgr:getCacheQuestion()
    if not self.questionInfo_ then
        local content = UserDefault:getStringForKey(self.KEY_DLS_QUESTION_INFO)
        local questionInfo = json.decode(content)
        if not questionInfo then
            questionInfo = self:generateQuestion()
        end
        self.questionInfo_ = questionInfo
    end
    return self.questionInfo_
end

function DlsDataMgr:getPathList(fromSite, toSite)
    local fromPath = {}
    local preSite = self.dlsMapPath_[fromSite]
    while preSite do
        table.insert(fromPath, preSite)
        preSite = self.dlsMapPath_[preSite]
    end
    table.insert(fromPath, 1, fromSite)

    local toPath = {}
    local preSite = self.dlsMapPath_[toSite]
    while preSite do
        table.insert(toPath, 1, preSite)
        preSite = self.dlsMapPath_[preSite]
    end
    table.insert(toPath, toSite)

    local crossIndex
    local path = {}
    for i, v in ipairs(fromPath) do
        local index =  table.indexOf(toPath, v)
        if index ~= -1 then
            crossIndex = index
            break
        else
            table.insert(path, v)
        end
    end
    for i = crossIndex, #toPath do
        table.insert(path, toPath[i])
    end

    return path
end

function DlsDataMgr:getDungenCfg(dungenCid)
    return self.dlsDungenMap_[dungenCid]
end

function DlsDataMgr:getDungen()
    return self.dlsDungen_
end

function DlsDataMgr:getQuestionCfg(cid)
    return self.dlsQuestionMap_[cid]
end

function DlsDataMgr:isUnlockLevel(levelCid)
    local isUnlock = tobool(self.openAreas_[levelCid])
    return isUnlock
end

function DlsDataMgr:isPassLevel(levelCid)
    local levelCfg = self:getDungenCfg(levelCid)
    local worldCfg = TabDataMgr:getData("DlsWorld", levelCfg.worldId)
    local isPass = false
    for i, v in ipairs(worldCfg.finalMission) do
        if self.complateTask_[v] then
            isPass = true
            break
        end
    end
    return isPass
end

function DlsDataMgr:checkLevelEnabeld(levelCid)
    local levelCfg = self:getDungenCfg(levelCid)
    local preLevelCid = levelCfg.lastDungen
    local enabled = true
    if preLevelCid and preLevelCid ~= 0 then
        local isPass = self:isPassLevel(preLevelCid)
        local isUnlock = self:isUnlockLevel(preLevelCid)
        enabled = isPass and isUnlock
    end
    return enabled
end

function DlsDataMgr:getBeginSite()
    return self.beginSite_
end

function DlsDataMgr:getCurSite()
    local curSite
    if self.curAreaCid_ ~= 0 then
        for k, v in pairs(self.dlsDungen_) do
            if v == self.curAreaCid_ then
                curSite = k
                break
            end
        end
    end
    curSite = curSite or self.beginSite_
    return curSite
end

function DlsDataMgr:isOpenTime()
    local serverTime = ServerDataMgr:getServerTime()
    local rets = serverTime >= self.activityTime_.startTime and serverTime < self.activityTime_.endTime
    return rets
end

function DlsDataMgr:isShowTime()
    local serverTime = ServerDataMgr:getServerTime()
    local rets = serverTime >= self.activityTime_.startTime and serverTime < self.activityTime_.showTime
    return rets
end

function DlsDataMgr:getActivityTime()
    return self.activityTime_
end

function DlsDataMgr:isCompleteAllEvent(levelCid)
    local levelCfg = self:getDungenCfg(levelCid)
    local worldCfg = TabDataMgr:getData("DlsWorld", levelCfg.worldId)
    local isComplete = true
    for i, v in ipairs(worldCfg.mapSchedule) do
        local cid = v[1]
        local num = v[2]
        local curNum = 0
        if self.completeEvent_[levelCid] then
            curNum = self.completeEvent_[levelCid][cid] or 0
        end
        if curNum < num then
            isComplete = false
            break
        end
    end
    return isComplete
end

----------------------------------------------------------

function DlsDataMgr:send_OFFICE_EXPLORE_AREA_MOVE(cid)
    TFDirector:send(c2s.OFFICE_EXPLORE_AREA_MOVE, {cid})
end

function DlsDataMgr:onRecvOpenTime(event)
    local data = event.data
    self.activityTime_ = data
end

function DlsDataMgr:onRecvAreaInfo(event)
    local data = event.data
    dump(data)
    self.curAreaCid_ = data.curAreaCid
    for i, v in ipairs(data.openAreas or {}) do
        self.openAreas_[v] = true
    end
    for i, v in ipairs(data.finTasks or {}) do
        self.complateTask_[v] = true
    end
    for i, v in ipairs(data.complteEvents or {}) do
        local events = self.completeEvent_[v.areaCid] or {}
        for _, event in ipairs(v.events) do
            events[event.cid] = event.num
        end
        self.completeEvent_[v.areaCid] = events
    end

    dump(self.completeEvent_)
end

function DlsDataMgr:onRecvAreaMove(event)
    local data = event.data
    if data.areaCid then
        self.openAreas_[data.areaCid] = true
        self.curAreaCid_ = data.areaCid
    end

    EventMgr:dispatchEvent(EV_DLS_LEVEL_UNLOCK, data.areaCid)
end

function DlsDataMgr:onRecvCompleteTask(event)
    local data = event.data
    if not data.finTasks then return end

    for i, v in ipairs(data.finTasks) do
        self.complateTask_[v] = true
    end

    EventMgr:dispatchEvent(EV_DLS_TASK_COMPLETE)
end

function DlsDataMgr:onRecvCompleteEvent(event)
    local data = event.data
    if not data.complteEvents then return end

    local events = self.completeEvent_[data.complteEvents.areaCid] or {}
    for _, event in ipairs(data.complteEvents.events) do
        events[event.cid] = event.num
    end
    self.completeEvent_[data.complteEvents.areaCid] = events

    dump(self.completeEvent_)
    EventMgr:dispatchEvent(EV_DLS_EVENT_COMPLETE)
end

return DlsDataMgr:new()
