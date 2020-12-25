local BaseDataMgr = import(".BaseDataMgr")
local DetectiveDataMgr = class("DetectiveDataMgr", BaseDataMgr)

function DetectiveDataMgr:ctor()
    self:init()
end

function DetectiveDataMgr:registerMsgEvent()
	TFDirector:addProto(s2c.DETECTIVE_RES_DETECTIVE_CHAPTER, self, self.onRecvDetectiveChapter)
	TFDirector:addProto(s2c.DETECTIVE_RES_DETECTIVE_ENTER, self, self.onRecvDetectiveEnter)
	TFDirector:addProto(s2c.DETECTIVE_RES_DETECTIVE_EXPLORE, self, self.onRecvExploreOver)
	TFDirector:addProto(s2c.DETECTIVE_RES_DETECTIVE_EVT_FINISH, self, self.onRecvEventFinish)
	TFDirector:addProto(s2c.DETECTIVE_DETECTIVE_LOG_NOTICE, self, self.onRecvLogNotice)
	TFDirector:addProto(s2c.DETECTIVE_RES_DETECTIVE_CHOOSE_AREA, self, self.onRecvChooseArea)
	TFDirector:addProto(s2c.DETECTIVE_RES_DETECTIVE_GAME_FINISH, self, self.onRecvGameFinish)
    TFDirector:addProto(s2c.DETECTIVE_RES_SUSPECT_VOTE, self, self.onRecvSuspectVoteRsp)
    TFDirector:addProto(s2c.DETECTIVE_RES_VOTE_RESULT, self, self.onRecvVoteResult)
    TFDirector:addProto(s2c.DETECTIVE_RES_DETECTIVE_VOTE_STATUS, self, self.onRecvSelfVoteRecord)
    TFDirector:addProto(s2c.DETECTIVE_RES_DETECTIVE_SIGN, self, self.onRecvDetectiveSign)
    
end

function DetectiveDataMgr:init()
    self:initData()
    self:registerMsgEvent()
end

function DetectiveDataMgr:initData()
	self.chapterInfos_ = {}
    self.pictureGameSign = {}
	self.unluckSign_ = {}
	self.mainLogInfo = {}
    self.minorInfoIds = {}
    self.detectiveJigSign_ = {}

	---地图
    self.mapData_ = {}
    local mapcfg = TabDataMgr:getData("DetectiveMap")
    for k,v in pairs(mapcfg) do
        if not self.mapData_[v.chapterId] then
            self.mapData_[v.chapterId] = {}
        end
        self.mapData_[v.chapterId][v.id] = v
    end

    ---日志
    self.subLogCfg = {}
    self.DetectiveLog_ = TabDataMgr:getData("DetectiveLog")
    for k,v in pairs(self.DetectiveLog_) do
        if v.logType == 2 then
            if not self.subLogCfg[v.logGroup] then
                self.subLogCfg[v.logGroup] = {}
            end
            table.insert(self.subLogCfg[v.logGroup],v)
        end
    end

    ---事件
    self.eventCfg = TabDataMgr:getData("DetectiveScriptMgr")

    --周目
    self.DetectiveMgrCfg = TabDataMgr:getData("DetectiveMgr")

    local detectiveJigsaw = TabDataMgr:getData("DetectiveJigsaw")
    for k,v in pairs(detectiveJigsaw) do
        for i,sign in ipairs(v.condition) do
            table.insert(self.detectiveJigSign_,sign)
        end
    end
    
end


function DetectiveDataMgr:onLogin()
end

function DetectiveDataMgr:reset()
    self.chapterInfos_ = {}
    self.pictureGameSign = {}
    self.unluckSign_ = {}
    self.mainLogInfo = {}
    self.minorInfoIds = {}
end

function DetectiveDataMgr:onLoginOut()
    self:reset()
end

function DetectiveDataMgr:getServerInitData( ... )
    -- body
    TFDirector:send(c2s.DETECTIVE_REQ_DETECTIVE_CHAPTER, {})
    TFDirector:send(c2s.DETECTIVE_REQ_DETECTIVE_SIGN, {})
    self:Req_DetectiveVoteResult()
    self:Req_DetectiveSelfVoteRecord()
end

function DetectiveDataMgr:getDetectiveMgrCfg(cid)

    if not cid then
        return self.DetectiveMgrCfg
    end

    return self.DetectiveMgrCfg[cid]
end

function DetectiveDataMgr:getMapCfgInfo(chapterId ,areaId)
    return self.mapData_[chapterId][areaId]
end

function DetectiveDataMgr:getMapData(chapterId)
    if chapterId then
        return self.mapData_[chapterId]
    else
	   return self.mapData_
    end
end

function DetectiveDataMgr:getEventCfg(cid)
    return self.eventCfg[cid]
end

function DetectiveDataMgr:getLogCfgData(cid)
    return self.DetectiveLog_[cid]
end

function DetectiveDataMgr:getMainLogInfo()
    return self.mainLogInfo
end

function DetectiveDataMgr:getMinorInfo(id)
    return self.minorInfoIds[id]
end

function DetectiveDataMgr:getUnlockSign()
	return self.unluckSign_
end

function DetectiveDataMgr:getPictureGameSign()
    return self.pictureGameSign
end

function DetectiveDataMgr:getSubLogCfgByMainCid(mainCid)
    local allSubLog = {}
    if not self.subLogCfg[mainCid] then
        return {}
    end
    for k,v in ipairs(self.subLogCfg[mainCid]) do
        local subLogData = self:getMinorInfo(v.id)
        if subLogData then
            table.insert(allSubLog,v)
        end
    end

    table.sort(allSubLog,function(a,b)
        local infoA = self:getMinorInfo(a.id)
        local infoB = self:getMinorInfo(b.id)
        if infoA.time == infoB.time then
            return a.id < b.id
        else
            return infoA.time < infoB.time
        end
    end)

    return allSubLog
end

function DetectiveDataMgr:getNewSubLogCfg(mainCid)

    if not self.subLogCfg[mainCid] then
        return
    end
    local newTime = 0
    local newSubLog
    for k,v in ipairs(self.subLogCfg[mainCid]) do
        local subLogData = self:getMinorInfo(v.id)
        if subLogData and subLogData.time > newTime then
            newSubLog = v
            newTime = subLogData.time
        end
    end
    return newSubLog

end

function DetectiveDataMgr:setAreaID(areaId)
    self.currentChapterInfo.currentAreaId = areaId
end

function DetectiveDataMgr:getAreaID()
    return self.currentChapterInfo.currentAreaId
end

function DetectiveDataMgr:setEventID(eventId)
    self.currentChapterInfo.currentEvtId = eventId
end

function DetectiveDataMgr:getEventID()
    return self.currentChapterInfo.currentEvtId
end

function DetectiveDataMgr:setNewChapterFlage(flag)
    self.currentChapterInfo.isNewChapter = flag
end

function DetectiveDataMgr:isNewOpenChapter()
    return self.currentChapterInfo.isNewChapter
end

function DetectiveDataMgr:getCurLocation()
    return self.currentChapterInfo.chapterId,self.currentChapterInfo.currentAreaId
end

function DetectiveDataMgr:getCurentChapterInfo()
    return self.currentChapterInfo
end

function DetectiveDataMgr:getVoteRecord( id , isClue )
    -- body
    if not self.voteRecord then return nil end
    for k,v in ipairs(self.voteRecord) do
        if v.day == id then
            local record = isClue and v.clueVote or v.suspectVote
            if record == 0 then return nil end
            
            return record
        end
    end
    return nil
end

function DetectiveDataMgr:getVoteResult( voteId )
    -- body
    if not self.voteResult then return {} end
    for k,v in ipairs(self.voteResult) do
        if v.day == voteId then
            return v.detectiveStat or {}
        end
    end
    return {}
end

function DetectiveDataMgr:changeVoteResult(voteId, resultData)
    local hasResult = false
    self.voteResult = self.voteResult or {}
    for k,v in ipairs(self.voteResult) do
        if v.day == voteId then
            v.detectiveStat =  resultData
            return
        end
    end
    table.insert(self.voteResult,{day = voteId, detectiveStat = resultData})
end

function DetectiveDataMgr:getPoll( voteId , roleId )
    -- body
    local polls = self:getVoteResult(voteId)
    for k,v in ipairs(polls) do
        if v.id == roleId then
            return v.count
        end
    end
    return 0 
end

function DetectiveDataMgr:getMaxPoll( voteId )
    -- body
    local polls = self:getVoteResult(voteId)
    local maxPoll = 1
    for k,v in ipairs(polls) do
        maxPoll = math.max(maxPoll, v.count)
    end
    return maxPoll 
end

function DetectiveDataMgr:getSaveEvents()
    if self.currentChapterInfo then
        return self.currentChapterInfo.saveEvtId or {}
    end
    return {}
end

function DetectiveDataMgr:onRecvDetectiveChapter(event)
	local data = event.data
    if not data then
        return
    end
    if data.chapterInfo then
        for i,v in ipairs(data.chapterInfo) do
            self.chapterInfos_[v.chapterId] = v
            if not self.currentChapterInfo and v.status == 3 then
                self.currentChapterInfo = v
            end
        end
        if self.currentChapterInfo then
            self.currentChapterInfo = self.chapterInfos_[self.currentChapterInfo.chapterId]
            EventMgr:dispatchEvent(EV_DETECTIVE.DETECTIVE_CHAPTER_UPDATE)
        end
        if self.currentChapterInfo and self.currentChapterInfo.status ~= 3 then
            EventMgr:dispatchEvent(EV_DETECTIVE.DETECTIVE_SETTLEMENT)
        end
    end
    
    if data.rewardGame then
        self.pictureGameSign = data.rewardGame
    end
end

function DetectiveDataMgr:setCurrentChapter(chapterId)
    self:setCurrentCharpterInfo(self:getChapterInfo(chapterId))
end

function DetectiveDataMgr:onRecvDetectiveEnter(event)
	local data = event.data
    if not data then
        return
    end
end

function DetectiveDataMgr:getChapterInfo( chapterId )
    -- body
    if not self.chapterInfos_ then return nil end
    for k,v in ipairs(self.chapterInfos_) do
        if v.chapterId == chapterId then
            return v
        end
    end
    return nil
end

function DetectiveDataMgr:setCurrentCharpterInfo(chapterInfo)
	self.currentChapterInfo = chapterInfo
end

function DetectiveDataMgr:onRecvExploreOver(event)
    local data = event.data
    if not data then
        return
    end
    local eventId = data.evtId
    self:setEventID(eventId)
    EventMgr:dispatchEvent(EV_DETECTIVE.DETECTIVE_ASK_MOVE)
end

function DetectiveDataMgr:onRecvEventFinish(event)
    local data = event.data
    if not data then
        return
    end
    self:setEventID()
    EventMgr:dispatchEvent(EV_DETECTIVE.DETECTIVE_UPDATE_FINISH)
end

function DetectiveDataMgr:onRecvChooseArea(event)
    local data = event.data
    if not data then
        return
    end
    self:setAreaID(data.currentAreaId)
    EventMgr:dispatchEvent(EV_DETECTIVE.DETECTIVE_CHOOSE_AREA,true)
end

function DetectiveDataMgr:onRecvGameFinish(event)
	local data = event.data
    if not data then
        return
    end
    if data.finished then

    end
    if data.rewardInfo then
    	Utils:showReward(data.rewardInfo)
    end
    EventMgr:dispatchEvent(EV_DETECTIVE.DETECTIVE_PICTURE_GAME_FILISH)
end

function DetectiveDataMgr:onRecvLogNotice(event)
    local data = event.data
    if not data then
        return
    end
    local mainLog =  data.mainLogInfo or {}
    local minorInfo = data.minorInfo or {}
    if data.type == 1 or not data.mainLogInfo then
        self.mainLogInfo = {}
        self.minorInfoIds = {}
        for k,v in ipairs(mainLog) do
            local logCfg = self:getLogCfgData(v.logId)
            if logCfg then
                table.insert(self.mainLogInfo,v)
            end
        end
    else
    	for k,v in ipairs(mainLog) do
            local logCfg = self:getLogCfgData(v.logId)
            if logCfg then
            	local flag = false
            	for i,mainInfo in ipairs(self.mainLogInfo) do
                    if mainInfo.logId == v.logId then
                        self.mainLogInfo[i] = v
                        flag = true
                        break
                    end
                end
                if not flag then
                	table.insert(self.mainLogInfo,v)
                end
            end
        end
    end

    for k,v in ipairs(minorInfo) do
        self.minorInfoIds[v.logId] = v
    end
    EventMgr:dispatchEvent(EV_DETECTIVE.DETECTIVE_UPDATE_EVENT_LOG,true)
end

function DetectiveDataMgr:onRecvDetectiveSign(event)
    local data = event.data
    if not data then
        return
    end

    local firstTag = #self.unluckSign_ < 1
    self.unluckSign_ = {}
    for i,v in ipairs(data.sign or {}) do
        if table.indexOf(self.detectiveJigSign_,v) ~= -1 then
            table.insert(self.unluckSign_, v)
        end
    end
    EventMgr:dispatchEvent(EV_DETECTIVE.DETECTIVE_SIGN_UPDATE,firstTag)
end

function DetectiveDataMgr:onRecvSuspectVoteRsp(event)

    local data = event.data
    if not data then
        return
    end

    local voteResult = self:getVoteResult(data.id)

    local hasRole = false
    for k,v in ipairs(voteResult) do
        if v.id == data.voteId then
            v.count = v.count + 1
            hasRole = true
            break
        end
    end

    if not hasRole then
        table.insert(voteResult,{id = data.voteId,count = 1})
    end

    self:changeVoteResult(data.id, voteResult)

    if data.rewardInfo then
        Utils:showReward(data.rewardInfo)
    end

    EventMgr:dispatchEvent(EV_DETECTIVE.DETECTIVE_VOTE_RESULT)
end

function DetectiveDataMgr:onRecvVoteResult(event)
    local data = event.data
    if not data then
        return
    end
    self.voteResult = data.voteInfo
    EventMgr:dispatchEvent(EV_DETECTIVE.DETECTIVE_VOTE_RESULT)
end

function DetectiveDataMgr:onRecvSelfVoteRecord(event)
    local data = event.data
    if not data then
        return
    end
    self.voteRecord = data.voteInfo
    EventMgr:dispatchEvent(EV_DETECTIVE.DETECTIVE_VOTE_RECORD)
end

function DetectiveDataMgr:Req_DetectiveVoteClue( ... )
    TFDirector:send(c2s.DETECTIVE_REQ_CLUE_VOTE, {...})
end

function DetectiveDataMgr:Req_DetectiveSuspectVote( ... )
    TFDirector:send(c2s.DETECTIVE_REQ_SUSPECT_VOTE, {...})
end

function DetectiveDataMgr:Req_DetectiveVoteResult()
    TFDirector:send(c2s.DETECTIVE_REQ_VOTE_RESULT, {})
end

function DetectiveDataMgr:Req_DetectiveSelfVoteRecord()
    TFDirector:send(c2s.DETECTIVE_REQ_DETECTIVE_VOTE_STATUS, {})
end

function DetectiveDataMgr:Req_DetectiveChapter()
    TFDirector:send(c2s.DETECTIVE_REQ_DETECTIVE_CHAPTER, {})
end

function DetectiveDataMgr:Req_DetectiveEnter(chapterId)
    TFDirector:send(c2s.DETECTIVE_REQ_DETECTIVE_ENTER, {chapterId})
end

function DetectiveDataMgr:Req_DetectiveEvtFinish(eventId)
    local saveEvents = self:getSaveEvents()
    for i,v in ipairs(saveEvents) do
        if v == eventId then
            table.remove(saveEvents,i)
            break
        end
    end
    TFDirector:send(c2s.DETECTIVE_REQ_DETECTIVE_EVT_FINISH, {self.currentChapterInfo.chapterId,self.currentChapterInfo.currentAreaId,eventId})
end

function DetectiveDataMgr:Req_DetectiveExplore()
    TFDirector:send(c2s.DETECTIVE_REQ_DETECTIVE_EXPLORE, {self.currentChapterInfo.chapterId,self.currentChapterInfo.currentAreaId})
end

function DetectiveDataMgr:Req_DetectiveChooseArea(nextAreaId)
    TFDirector:send(c2s.DETECTIVE_REQ_DETECTIVE_CHOOSE_AREA, {self.currentChapterInfo.chapterId,self.currentChapterInfo.currentAreaId,nextAreaId})
end


function DetectiveDataMgr:Req_DetectiveGameFinish(orderIds, group)
    TFDirector:send(c2s.DETECTIVE_REQ_DETECTIVE_GAME_FINISH, {orderIds,group})
end

function DetectiveDataMgr:Req_DetectiveSign()
    TFDirector:send(c2s.DETECTIVE_REQ_DETECTIVE_SIGN, {})
end

function DetectiveDataMgr:Req_ExitGame()
    TFDirector:send(c2s.DETECTIVE_REQ_RESET_QUIT, {self.currentChapterInfo.chapterId})
end


return DetectiveDataMgr:new()
