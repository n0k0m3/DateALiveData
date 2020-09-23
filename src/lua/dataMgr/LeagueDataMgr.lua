local BaseDataMgr = import(".BaseDataMgr")
local LeagueDataMgr = class("LeagueDataMgr", BaseDataMgr)

function LeagueDataMgr:ctor()
    self:init()
    self:reset()
end

function LeagueDataMgr:init()
    TFDirector:addProto(s2c.UNION_RESP_UNION, self, self.onRecvMyUnionData)
    TFDirector:addProto(s2c.UNION_CREATE_UNION, self, self.onRecvCreateUnion)
    TFDirector:addProto(s2c.UNION_QUERY_UNION_LIST, self, self.onRecvQueryUnionList)
    TFDirector:addProto(s2c.UNION_OPER_UNION_MEMBER, self, self.onRecvOprateUnionMember)
    TFDirector:addProto(s2c.UNION_UPDATE_DEGREE, self, self.onRecvUpdataDegree)
    TFDirector:addProto(s2c.UNION_UPDATE_UNION_INFO, self, self.onRecvUpdataUnionInfo)
    TFDirector:addProto(s2c.UNION_UNION_DONATE, self, self.onRecvUnionDonate)
    TFDirector:addProto(s2c.UNION_LEVEL_UP, self, self.onRecvUnionLevelUp)
    TFDirector:addProto(s2c.UNION_RECEIVE_SUPPLY, self, self.onRecvReceiveSupply)
    TFDirector:addProto(s2c.UNION_SEND_RED_PACKET_SUCC, self, self.onRecvSendRedPacket)
    TFDirector:addProto(s2c.UNION_OPEN_RED_PACKET, self, self.onRecvOpenRedPacket)
    TFDirector:addProto(s2c.UNION_RED_PACKET, self, self.onRecvCheckRedPacket)
    TFDirector:addProto(s2c.UNION_DELATE_UNION_LEADER, self, self.onRecvDelateLeader)
    TFDirector:addProto(s2c.UNION_SEARCH_UNION, self, self.onRecvSearchUnion)
    TFDirector:addProto(s2c.UNION_DESTROY_UNION, self, self.onRecvDestroyUnion)
    TFDirector:addProto(s2c.UNION_RESP_NOTIFY, self, self.onRecvReqNotify)
    TFDirector:addProto(s2c.UNION_RESP_UNION_MEMBER, self, self.onRecvUpdateMember)
    TFDirector:addProto(s2c.UNION_RESP_APPLY_INFO, self, self.onRecvApplyInfo)
    TFDirector:addProto(s2c.UNION_RESP_UNION_WEEK_ACTIVE_PRIZE, self, self.onRecvActivePrize)
    TFDirector:addProto(s2c.UNION_RESP_SUPPLY_RECORD, self, self.onRecvSupplyRecord)
    TFDirector:addProto(s2c.UNION_RESP_WEEK_UPDATE, self, self.onRecvWeekUpdate)
    TFDirector:addProto(s2c.UNION_RESP_IMPEACH_LIST, self, self.onRecvImpatchList)
    TFDirector:addProto(s2c.UNION_RESP_TRAIN_MAXTRI_INFO, self, self.onRecvTrainMaxtriInfo)
    TFDirector:addProto(s2c.UNION_RESP_TRAIN_MAXTRI_PRIZE, self, self.onRecvTrainActivePrize)
    TFDirector:addProto(s2c.UNION_RESP_SELF_TRAIN_MAXTRI_PRIZE, self, self.onRecvTrainSelfActivePrize)

    --追猎计划
    TFDirector:addProto(s2c.HUNTING_DUNGEON_RESP_HUNTING_DUNGEON_INFO, self, self.onRecvHuntingDungeonInfo)
    TFDirector:addProto(s2c.HUNTING_DUNGEON_RESP_HUNTING_RANK, self, self.onRecvHuntingRankList)
    TFDirector:addProto(s2c.HUNTING_DUNGEON_RESP_HUNTING_FDAWARD, self, self.onRecvGetHuntingFDAward)
    TFDirector:addProto(s2c.HUNTING_DUNGEON_RESP_HUNTING_PASS_AWARD, self, self.onRecvGetHuntingPassAward)
    TFDirector:addProto(s2c.HUNTING_DUNGEON_RESP_HUNTING_BOSS_AWARD, self, self.onRecvHuntingRewardList)

    TFDirector:addProto(s2c.HUNTING_DUNGEON_RESP_HUNTING_STEP_INFO, self, self.onRecvHuntingStepInfo)
    TFDirector:addProto(s2c.HUNTING_DUNGEON_RESP_HUNTING_BOSS_INFO, self, self.onRecvHuntingBossInfo)
    TFDirector:addProto(s2c.HUNTING_DUNGEON_RESP_HUNTING_WEAKNESS_INFO, self, self.onRecvHuntingWeaknessInfo)


    

    --特训矩阵
    TFDirector:addProto(s2c.UNION_RESP_APPLY_INFO, self, self.onRecvApplyInfo)
    

    self.clubBaesMap_ = TabDataMgr:getData("ClubBaes")
    self.clubCountry_ = TabDataMgr:getData("ClubCountry")

    self.myUnionData_ = nil
    self.unionSnapInfoList_ = {}
    self.notifys_ = {}
    self.impatchList_ = {}
    self.trainMatrixInfo = {} --特训矩阵信息
    self.searchOutUnion = nil
    self.joinUnionRed = false
    self.flagUnlockRed = false
    self.noticeChangeRed = false
    self.degreeNumMax = {1,2,10,999}
end

function LeagueDataMgr:reset()
    self.myUnionData_ = nil
    self.unionSnapInfoList_ = {}
    self.notifys_ = {}
    self.searchOutUnion = nil
    self.joinUnionRed = false
    self.flagUnlockRed = false
    self.trainMatrixInfo = {}

    self.trainMatrixRankData = {}--矩阵评价数据
    local trainRankTb = TabDataMgr:getData("TrainingRank")
    for k, v in pairs(trainRankTb) do
        local dt = {}
        dt.id = v.id
        dt.rangL = v.achievement[1]
        dt.rangR = v.achievement[2]
        dt.rankPic = v.trainingorder
        table.insert(self.trainMatrixRankData, dt)
    end
    table.sort(self.trainMatrixRankData, function(a, b)
        return a.id <= b.id
    end)
    self.hunterDungeonInfo = nil
    self.huntingRankList   = nil
    self.huntingRewardList = nil
end

function LeagueDataMgr:onLogin()
    TFDirector:send(c2s.UNION_REQ_UNION, {})
    return {s2c.UNION_RESP_UNION}
end

function LeagueDataMgr:onLoginOut()
    self:reset()
end

--创建社团
function LeagueDataMgr:createUnion(unionName , country)
    if Utils:isStringContainSpecialChars(unionName,"%s") ~= nil then
        return false
    end
    TFDirector:send(c2s.UNION_CREATE_UNION, {unionName ,country})
    return true
end

function LeagueDataMgr:reqMyUnionInfo()
   TFDirector:send(c2s.UNION_REQ_UNION, {})
end

--请求推荐社团列表
function LeagueDataMgr:queryUnionList()
    TFDirector:send(c2s.UNION_QUERY_UNION_LIST,{})
end

--社团成员操作
function LeagueDataMgr:operateUnionMember(operType, targets)
    TFDirector:send(c2s.UNION_OPER_UNION_MEMBER, {operType, targets})
end

--职位变更
function LeagueDataMgr:updateMembersDegree(degree, target)
    TFDirector:send(c2s.UNION_UPDATE_DEGREE, {degree, target})
end

--修改社团信息
function LeagueDataMgr:UpdateUnionInfo(etype, param)
    TFDirector:send(c2s.UNION_UPDATE_UNION_INFO, {etype, param})
end

--领取聚变器任务奖励
function LeagueDataMgr:ReqUnionWeekActivePrize(idx)
    TFDirector:send(c2s.UNION_REQ_UNION_WEEK_ACTIVE_PRIZE, {idx})
end

--捐献
function LeagueDataMgr:UnionDonate(itemId, donateVal)
    TFDirector:send(c2s.UNION_UNION_DONATE, {itemId, donateVal})
end

--社团升级
function LeagueDataMgr:UnionLevelUp(buildingId, targetLevel)
    TFDirector:send(c2s.UNION_LEVEL_UP, {buildingId, targetLevel})
end

--领取补给 id 补给id
function LeagueDataMgr:UnionReceiveSupply(id)
    TFDirector:send(c2s.UNION_RECEIVE_SUPPLY, {id})
end

--发红包
function LeagueDataMgr:SendRedPacket(id, blessing)
    TFDirector:send(c2s.UNION_SEND_RED_PACKET, {id, blessing})
end

--开红包
function LeagueDataMgr:OpenRedPacket(id, senderId, createTime)
    TFDirector:send(c2s.UNION_OPEN_RED_PACKET, {id, senderId, createTime})
end

--查看红包
function LeagueDataMgr:ReqRedPacket(id, senderId, createTime)
    TFDirector:send(c2s.UNION_REQ_RED_PACKET, {id, senderId, createTime})
end

--弹劾团长
function LeagueDataMgr:DelateUnionLeader()
    TFDirector:send(c2s.UNION_DELATE_UNION_LEADER, {})
end

--搜索社团
function LeagueDataMgr:SearchUnion(idText)
    local unionId = tonumber(idText)
    if unionId and unionId > 0 then
        TFDirector:send(c2s.UNION_SEARCH_UNION, {unionId})
        return true
    end
    return false
end

--解散社团
function LeagueDataMgr:DestroyUnion()
    TFDirector:send(c2s.UNION_DESTROY_UNION, {})
end

function LeagueDataMgr:ReqNotify()
    TFDirector:send(c2s.UNION_REQ_NOTIFY, {self.notifyVersion or 0})
end

function LeagueDataMgr:ReqSupplyRecord()
    TFDirector:send(c2s.UNION_REQ_SUPPLY_RECORD, {})
end

function LeagueDataMgr:ReqWeekUpdate()
    TFDirector:send(c2s.UNION_REQ_WEEK_UPDATE, {})
end

function LeagueDataMgr:ReqImpeachList()
    TFDirector:send(c2s.UNION_REQ_IMPEACH_LIST, {})
end

function LeagueDataMgr:reqTrainMatrixInfo()
    TFDirector:send(c2s.UNION_REQ_TRAIN_MAXTRI_INFO, {})
end

--领取特训矩阵阶段奖励
function LeagueDataMgr:ReqUnionTrainActivePrize(idx)
    TFDirector:send(c2s.UNION_REQ_TRAIN_MAXTRI_PRIZE, {idx})
end

--领取特训矩阵隔热你几分奖励
function LeagueDataMgr:ReqUnionTrainSelfActivePrize(idx)
    TFDirector:send(c2s.UNION_REQ_SELF_TRAIN_MAXTRI_PRIZE, {idx})
end

---------------追猎计划请求----------------

--请求追猎计划信息 TODO
function LeagueDataMgr:ReqHuntingDungeonInfo()
    --printError("请求追猎计划信息")
    -- Box("请求追猎计划信息")
    TFDirector:send(c2s.HUNTING_DUNGEON_REQ_HUNTING_DUNGEON_INFO, {})
end

--请求排行榜数据
function LeagueDataMgr:ReqHuntingRank()
    TFDirector:send(c2s.HUNTING_DUNGEON_REQ_HUNTING_RANK, {})
end

--[[
    [1] = {--ReqHuntingFDAward
        [1] = 'int32':dungeon   [领取的关卡]
    }
--]]

--请求首通奖励
function LeagueDataMgr:ReqHuntingFDAward(dungeon)
    TFDirector:send(c2s.HUNTING_DUNGEON_REQ_HUNTING_FDAWARD, {dungeon})
end

--[[
    [1] = {--ReqHuntingPassAward
        [1] = 'int32':dungeon   [领取的关卡]
    }
--]]
--请求击杀奖励
function LeagueDataMgr:ReqHuntingPassAward(dungeon)
    TFDirector:send(c2s.HUNTING_DUNGEON_REQ_HUNTING_PASS_AWARD, {dungeon})
end

--[[
    [1] = {--ReqHuntingPassAward
        [1] = 'int32':dungeon   [领取的关卡]
    }
--]]
--请求追猎boss奖励信息
function LeagueDataMgr:ReqHuntingBossAward(dungeon)
    TFDirector:send(c2s.HUNTING_DUNGEON_REQ_HUNTING_BOSS_AWARD, {})
end


--------------------------------------------------------------
--6669 特训矩阵主题信息
function LeagueDataMgr:getUnionTrainMatrixInfo()

end

--我的社团数据返回
function LeagueDataMgr:onRecvMyUnionData(event)
    local data = event.data
    if data.union then
        self.myUnionData_ = data.union
        self.myUnionData_.members = self.myUnionData_.members or {}
        self.myUnionData_.applyList = self.myUnionData_.applyList or {}
        self:ReqNotify()
        self:reqTrainMatrixInfo()
        self:ReqHuntingDungeonInfo() --TODO 是否需要请求
        EventMgr:dispatchEvent(EV_UNION_BASE_INFO_UPDATE)

    end
end

--创建社团成功
function LeagueDataMgr:onRecvCreateUnion(event)
    local data = event.data
    if data.succ and data.union then
        self.myUnionData_ = data.union
        self:reqTrainMatrixInfo()
        self:ReqHuntingDungeonInfo()  --TODO是否需要请求
        EventMgr:dispatchEvent(EV_UNION_CREATE_UNION_SUCCESS)
    end

end

--推荐列表返回
function LeagueDataMgr:onRecvQueryUnionList(event)
    local data = event.data
    if data.union then
        self.searchOutUnion = nil
        self.unionSnapInfoList_ = data.union or {}
        EventMgr:dispatchEvent(EV_UNION_QUERY_UNION_LIST, data)
    end
end

--成员操作返回
function LeagueDataMgr:onRecvOprateUnionMember(event)
    local data = event.data
    if data.operType then
        if data.operType == EC_UNIONType.APLY then
            if data.targets then
                local unionInfo 
                if self.searchOutUnion then
                    unionInfo = self.searchOutUnion
                end
                
                for i,v in ipairs(data.targets) do
                    if not unionInfo then
                        unionInfo = self:getQueryUnionInfoById(v)
                    end
                    unionInfo.apply = true
                    EventMgr:dispatchEvent(EV_UNION_APPLY_JOIN_UNION)
                end
            end
        elseif data.operType == EC_UNIONType.QUIT then
            self:reset()
            ChatDataMgr:clearUnionChatData()
            EventMgr:dispatchEvent(EV_UNION_QUIT_UNION)
        elseif data.operType == EC_UNIONType.ASSENT or data.operType == EC_UNIONType.DECLINE then
            EventMgr:dispatchEvent(EV_UNION_OPERAT_APLIES)
        elseif data.operType == EC_UNIONType.KICK then
            if data.targets and data.targets[1] then
                if self:checkSelfInUnion() then
                    local members = self.myUnionData_.members
                    for i, info in ipairs(members) do
                        if info.playerId == data.targets[1] then
                            table.remove(members, i)
                            break
                        end
                    end
                end
            end
            EventMgr:dispatchEvent(EV_UNION_KICK_MEMBER)
        elseif data.operType == EC_UNIONType.TRANSFER then
            EventMgr:dispatchEvent(EV_UNION_TRANSFER_LEADER)
        elseif data.operType == EC_UNIONType.FAST_JOIN then
            --EventMgr:dispatchEvent(EV_UNION_FAST_JOIN_UNION)
        elseif data.operType == EC_UNIONType.IMPEACH_LEADER then
            EventMgr:dispatchEvent(EV_UNION_IMPEACH_LEADER)
            self:ReqImpeachList()
            Utils:showTips(276008)
        end
    end
end

--职位变更返回
function LeagueDataMgr:onRecvUpdataDegree(event)
    local data = event.data
    if data.degree and data.target then
        Utils:showTips(270488)
        EventMgr:dispatchEvent(EV_UNION_DEGREE_CHANGE)
    end
end

--社团信息变更返回
function LeagueDataMgr:onRecvUpdataUnionInfo(event)
    local data = event.data
    if not self:checkSelfInUnion() then
        return 
    end
    if data.type and data.param then
        if data.type == EC_UNION_EDIT_Type.PROCLAMATION then
            if self.myUnionData_ then
                local lastNotice = clone(self.myUnionData_.notice)
                self.myUnionData_.notice = data.param or self.myUnionData_.notice
                if lastNotice ~= self.myUnionData_.notice then
                    self.noticeChangeRed = true
                end
            end
            EventMgr:dispatchEvent(EV_UNION_NOTICE_CHANGE)
        elseif data.type == EC_UNION_EDIT_Type.FLAG then
            if self.myUnionData_ then
                self.myUnionData_.icon = data.param or 0
            end
            EventMgr:dispatchEvent(EV_UNION_FLAG_CHANGE)
        elseif data.type == EC_UNION_EDIT_Type.OPEN_APLY then
            if data.param == "true" then
                self.myUnionData_.canApply = true
            else
                self.myUnionData_.canApply = false
            end
        elseif data.type == EC_UNION_EDIT_Type.OPEN_AUTO_JOIN then
            if data.param == "true" then
                self.myUnionData_.autoJoin = true
            else
                self.myUnionData_.autoJoin = false
            end
        elseif data.type == EC_UNION_EDIT_Type.OPEN_JOIN_LIMIT then
            local vecStr = string.split(data.param, ",")
            if vecStr[1] == "true" then
                self.myUnionData_.joinLimit = true
            else
                self.myUnionData_.joinLimit = false
            end
            if vecStr[2] then
                self.myUnionData_.limitLevel = tonumber(vecStr[2])
            end
        elseif data.type == EC_UNION_EDIT_Type.DELATE_LEADER then
            if self.myUnionData_ then
                self.myUnionData_.delateEndTime = tonumber(data.param) or -1
            end
            EventMgr:dispatchEvent(EV_UNION_DELATE_TIME_UPDATE)
        elseif data.type == EC_UNION_EDIT_Type.EXP_LEVEL_UPDATE then
            if self.myUnionData_ then
                local param = json.decode(data.param)
                if param[1] then
                    self.myUnionData_.exp = tonumber(param[1]) or self.myUnionData_.exp
                end
                if param[2] then
                    local lastLevel = self.myUnionData_.level
                    self.myUnionData_.level = tonumber(param[2]) or self.myUnionData_.level
                    if self.myUnionData_.level > lastLevel then
                        EventMgr:dispatchEvent(EV_UNION_LEVEL_CHANGE)
                        local degree = self:getSelfDegree()
                        if degree == EC_UNION_DEGREE_Type.HEAD then
                            local cfg = self:getUnionLevelBaseCfg(self.myUnionData_.level)
                            if cfg.clubemblem > 0 then
                                self:setUnionFlagUnlockRedPoint(true)
                            end
                        end
                    end
                end
            end
            EventMgr:dispatchEvent(EV_UNION_EXP_LEVEL_CHANGE)
        elseif data.type == EC_UNION_EDIT_Type.WEEK_EXP_UPDATE then
            self.myUnionData_.weekExp = tonumber(data.param) or self.myUnionData_.weekExp
            EventMgr:dispatchEvent(EV_UNION_WEEK_EXP_CHANGE)
        elseif data.type == EC_UNION_EDIT_Type.DAILY_RESET then
            self.myUnionData_.receiveTimes = 0
            self.myUnionData_.goldRedpacketTime = 0
            self.myUnionData_.rechargeRedpacketTime = 0
            EventMgr:dispatchEvent(EV_UNION_INFO_RESET)
        elseif data.type == EC_UNION_EDIT_Type.WEEK_RESET then
            self.myUnionData_.weekExpPrizeReceiveIndex = {}
            self:ReqWeekUpdate()
            self:resetMembersActive()
            self:resetTrainMatrix()
        elseif data.type == EC_UNION_EDIT_Type.RED_PACKET_COUNT then
            local param = json.decode(data.param)
            ChatDataMgr:updateUnionRedpacketStatus(param.senderId, param.time, param.count)
        elseif data.type == EC_UNION_EDIT_Type.TRAIN_THEME_ID then
            self.trainMatrixInfo.theme = self.trainMatrixInfo and tonumber(data.param) or self.trainMatrixInfo.theme
            EventMgr:dispatchEvent(EV_UNION_TRAIN_INFO_UPDATE)
        elseif data.type == EC_UNION_EDIT_Type.TRAIN_UNION_SCORE then
            self.trainMatrixInfo.score = self.trainMatrixInfo and tonumber(data.param) or self.trainMatrixInfo.score
            EventMgr:dispatchEvent(EV_UNION_TRAIN_INFO_UPDATE)
        elseif data.type == EC_UNION_EDIT_Type.TRAIN_REMAIN_TIMES then
            self.trainMatrixInfo.remainTimes = self.trainMatrixInfo and tonumber(data.param) or self.trainMatrixInfo.remainTimes
            EventMgr:dispatchEvent(EV_UNION_TRAIN_INFO_UPDATE)
        elseif data.type == EC_UNION_EDIT_Type.MODIFY_NAME then
            if self.myUnionData_ then
                self.myUnionData_.name = data.param
            end
            EventMgr:dispatchEvent(EV_UNION_MODIFY_NAME)
        elseif data.type == EC_UNION_EDIT_Type.CHANGE_COUNTRY then
            self.myUnionData_.country = data.param
            EventMgr:dispatchEvent(EV_UNION_CHANGE_COUNTRY)
        elseif data.type == EC_UNION_EDIT_Type.SHOW_COUNTRY then
            if data.param == "true" then
                self.myUnionData_.showCountry = true
            else
                self.myUnionData_.showCountry = false
            end
        end
    end
end

function LeagueDataMgr:onRecvWeekUpdate(event)
    local data = event.data
    if not self:checkSelfInUnion() then
        return
    end
    if data then
        if not data.lastWeekActive then
            self.resetTimer_ = TFDirector:addTimer(10*1000, 1, nil,function()
                if self.resetTimer_ then
                    TFDirector:removeTimer(self.resetTimer_)
                    self.resetTimer_ = nil
                end
                self:ReqWeekUpdate()
            end)
        else
            self.myUnionData_.weekExp = data.weekExp or self.myUnionData_.weekExp
            self.myUnionData_.lastWeekActive = data.lastWeekActive
            EventMgr:dispatchEvent(EV_UNION_INFO_RESET)
        end
    end
end

--捐赠返回
function LeagueDataMgr:onRecvUnionDonate(event)
    local data = event.data
    if data.itemId and data.donateVal then
        
    end
end

--建筑升级返回
function LeagueDataMgr:onRecvUnionLevelUp(event)
    local data = event.data
    if data.buildingId and data.targetLevel then
        
    end
end

--领取补给
function LeagueDataMgr:onRecvReceiveSupply(event)
    local data = event.data
    if not self:checkSelfInUnion() then
        return
    end
    if data then
        local maxTimes = self:getSupplyMaxTimes()
        self.myUnionData_.receiveTimes = self.myUnionData_.receiveTimes or 0
        self.myUnionData_.receiveTimes = math.min(self.myUnionData_.receiveTimes + 1, maxTimes)
        Utils:showReward(data.rewards)
        EventMgr:dispatchEvent(EV_UNION_GET_SUPPLY_SUCCESS)
    end
end

function LeagueDataMgr:onRecvSupplyRecord(event)
    local data = event.data
    if data then
        EventMgr:dispatchEvent(EV_UNION_GET_SUPPLY_RECORD, data)
    end 
end

--发红包
function LeagueDataMgr:onRecvSendRedPacket(event)
    local data = event.data
    if not self:checkSelfInUnion() then
        return
    end
    if data then
        local cfg = self:getPacketCfgById(data.id)
        if cfg.type == 1 then
            self.myUnionData_.goldRedpacketTime = self.myUnionData_.goldRedpacketTime or 0
            self.myUnionData_.goldRedpacketTime = math.min(self.myUnionData_.goldRedpacketTime + 1, cfg.packettimes)
        else
            self.myUnionData_.rechargeRedpacketTime = self.myUnionData_.rechargeRedpacketTime or 0
            self.myUnionData_.rechargeRedpacketTime = math.min(self.myUnionData_.rechargeRedpacketTime + 1, cfg.packettimes)
        end
        EventMgr:dispatchEvent(EV_UNION_SEND_PACKET_SUCCESS)
    end
end

--开红包
function LeagueDataMgr:onRecvOpenRedPacket(event)
    local data = event.data
    if data then
        
    end
end

--查看红包
function LeagueDataMgr:onRecvCheckRedPacket(event)
    local data = event.data
    if not self:checkSelfInUnion() then
        return
    end
    if data then
        ChatDataMgr:updateUnionRedpacketStatus(data.senderId, data.createTime)
        if data.status == 1 then
            Utils:openView("league.LeagueOpenRedPacketView", data)
        else
            Utils:openView("league.LeagueRedPacketDetailView", data)
        end
    end
end

--弹劾团长
function LeagueDataMgr:onRecvDelateLeader(event)
    local data = event.data
    if data then
        
    end
end

--搜索社团
function LeagueDataMgr:onRecvSearchUnion(event)
    local data = event.data
    if not data or not data.union then
        Utils:showTips(270489)
        return
    end
    if data.union then
        self.searchOutUnion = data.union
        EventMgr:dispatchEvent(EV_UNION_SEARCH_UNION, data)
    end
end

--解散社团
function LeagueDataMgr:onRecvDestroyUnion(event)
    local data = event.data
    self:reset()
    EventMgr:dispatchEvent(EV_UNION_DIABAND_UNION)
end

function LeagueDataMgr:onRecvReqNotify(event)
    local data = event.data
    if data and data.notify then
        self.notifyVersion = data.version
        for i, v in ipairs(data.notify) do
            table.insert(self.notifys_, v)
        end
        table.sort(self.notifys_, function(a, b)
            return a.creatTime < b.creatTime
        end)
        if #data.notify > 0 then
            EventMgr:dispatchEvent(EV_UNION_NOTIFY_UPDATE)
        end
    end
end

function LeagueDataMgr:getNotifyDataBySortDate()
    local sortData = {}
    local monthFlag = -1
    local dayFlag = 1
    for i,v in ipairs(self.notifys_) do
        local year, month, day = Utils:getDate(math.floor(v.creatTime / 1000), false)
        if monthFlag == month and dayFlag == day then
            table.insert(sortData, v)
        else
            monthFlag = month
            dayFlag = day
            local info = {}
            info.notifyType = -1
            info.prams = TextDataMgr:getText(600024,month, day)
            table.insert(sortData, info)
            table.insert(sortData, v)
        end
    end
    if #sortData > 100 then
        for i=1, #sortData - 100 do
            table.remove(sortData, i)
        end
    end
    return sortData
end



function LeagueDataMgr:onRecvUpdateMember(event)
    local data = event.data
    if not self.myUnionData_ then
        self:reqMyUnionInfo()
        self:setJoinUnionRedPoint(state)
        return
    end
    if data then
        local members = self.myUnionData_.members
        for i, info in ipairs(data.member) do
            if info.ct == EC_SChangeType.ADD or info.ct == EC_SChangeType.DEFAULT then
                table.insert(members, info)
            elseif info.ct == EC_SChangeType.UPDATE then
                local member = self:getMemberInfoByPlayerId(info.playerId) or {}
                table.merge(member,info)
            elseif info.ct == EC_SChangeType.DELETE then
                for j, v in ipairs(members) do
                    if info.playerId == v.playerId then
                        table.remove(members, j)
                        break
                    end
                end
                if info.playerId == MainPlayer:getPlayerId() then
                    self:reset()
                    ChatDataMgr:clearUnionChatData()
                    EventMgr:dispatchEvent(EV_UNION_QUIT_UNION)
                    return
                end
            end
            self.myUnionData_.memberCount = #members
        end
        EventMgr:dispatchEvent(EV_UNION_MEMBER_UPDATE)
    end
end

function LeagueDataMgr:onRecvApplyInfo(event)
    local data = event.data
    if not self.myUnionData_ then
        return
    end
    if data and data.applyInfo then
        local applyList = self.myUnionData_.applyList or {}
        for i, info in ipairs(data.applyInfo) do
            if info.ct == EC_SChangeType.ADD or info.ct == EC_SChangeType.DEFAULT then
                table.insert(applyList, info)
            elseif info.ct == EC_SChangeType.UPDATE then
                local applyInfo = self:getApplyInfoByPlayerId(info.playerId) or {}
                table.merge(applyInfo,info)
            elseif info.ct == EC_SChangeType.DELETE then
                for j, v in ipairs(applyList) do
                    if info.playerId == v.playerId then
                        table.remove(applyList, j)
                        break
                    end
                end
            end
        end
        if #data.applyInfo > 0 then
            EventMgr:dispatchEvent(EV_UNION_APPLY_UPDATE)
        end
    end
end

--聚变器阶段奖励
function LeagueDataMgr:onRecvActivePrize(event)
    local data = event.data
    if not self.myUnionData_ then
        return
    end
    if data and data.index then
        self.myUnionData_.weekExpPrizeReceiveIndex = self.myUnionData_.weekExpPrizeReceiveIndex or {}
        table.insert(self.myUnionData_.weekExpPrizeReceiveIndex, data.index)
        EventMgr:dispatchEvent(EV_UNION_GET_ACTIVE_REWARD, data)
    end
end

function LeagueDataMgr:onRecvImpatchList(event)
    local data = event.data
    if data and data.members then
        self.impatchList_ = clone(data.members)
        EventMgr:dispatchEvent(EV_UNION_IMPATCH_LIST, data)
    end
end

--矩阵主题 6669
function LeagueDataMgr:onRecvTrainMaxtriInfo(event)
    local data = event.data or {}
    self.trainMatrixInfo = self.trainMatrixInfo or {}
    self.trainMatrixInfo.theme = data.theme
    self.trainMatrixInfo.revertRemain = data.remain or 0
    self.trainMatrixInfo.remainTimes = data.remainTimes or 0
    self.trainMatrixInfo.receivePrizeIndex = data.receivePrizeIndex or {}
    self.trainMatrixInfo.score = data.score or 0
    self.trainMatrixInfo.selfTrainPrizeIndex = data.selfTrainPrizeIndex or {}
    local matrixTb = TabDataMgr:getData("TrainingMatrix")
    local unionlv = self:getUnionLevel()
    for k, v in pairs(matrixTb) do
        if data.theme == v.id then
            self.trainMatrixInfo.taskList = clone(v.mission)
            break
        end
    end
    EventMgr:dispatchEvent(EV_UNION_TRAINMATRIX_REVERT)
end

--特训矩阵阶段奖励
function LeagueDataMgr:onRecvTrainActivePrize(event)
    local data = event.data
    if not self.myUnionData_ or not self.trainMatrixInfo then
        return
    end
    if data and data.index then
        self.trainMatrixInfo.receivePrizeIndex = self.trainMatrixInfo.receivePrizeIndex or {}
        table.insert(self.trainMatrixInfo.receivePrizeIndex, data.index)
        EventMgr:dispatchEvent(EV_UNION_GET_TRAIN_ACTIVE_REWARD, data)
    end
end

--特训矩阵个人积分奖励
function LeagueDataMgr:onRecvTrainSelfActivePrize(event)
    local data = event.data
    if not self.myUnionData_ or not self.trainMatrixInfo then
        return
    end
    if data and data.index then
        self.trainMatrixInfo.selfTrainPrizeIndex = self.trainMatrixInfo.selfTrainPrizeIndex or {}
        table.insert(self.trainMatrixInfo.selfTrainPrizeIndex, data.index)
        EventMgr:dispatchEvent(EV_UNION_GET_TRAIN_SELF_ACTIVE_REWARD, data)
    end
end
-- required int32 step = 1;//当前阶段,0 功能未开放, 1 准备期开放, 2 准备期结算, 3 准备期结束, 11 正式挑战开放, 12 正式挑战结算, 13 正式挑战结束
-- required int32 nextTime = 2;//下阶段开始时间点
function LeagueDataMgr:onRecvHuntingDungeonInfo( event )
    local data = event.data
    dump(data)
    self.hunterDungeonInfo = data
    self:resetBufferList()
    self:ReqHuntingBossAward(self.hunterDungeonInfo.curBoss.curDungeon)
    EventMgr:dispatchEvent(EV_HUNTER_INFO_UPDATE)
end

function LeagueDataMgr:isHunterDungeonOpen()
    if FunctionDataMgr:isOpenByClient(98) then
        if self.hunterDungeonInfo and self.hunterDungeonInfo.step then 
            local _step = self.hunterDungeonInfo.step.step
            if _step ~= 0 and _step ~= 3 or _step ~= 13 then 
                if _step < EC_HunterStep.FORMAL_OPEN then --准备期
                    return self.hunterDungeonInfo.playerWeakness.leftCount > 0
                else 
                    return self.hunterDungeonInfo.curBoss.leftCount > 0
                end
            end
        end
    end
end
function LeagueDataMgr:resetBufferList()
    local bossInfo = self.hunterDungeonInfo.curBoss
    local bossCfg  = TabDataMgr:getData("HuntingLevel",bossInfo.curDungeon)
    local playerWeakness = self.hunterDungeonInfo.playerWeakness
    local function getCount( dungeonId )
        if playerWeakness and playerWeakness.weakness then
            for k,v in ipairs(playerWeakness.weakness) do

                print("v.dungeon == dungeonId ",v.dungeon , dungeonId )
                if v.dungeon == dungeonId then
                    return v.count
                end
            end
        end
        return 0 
    end
    --初始化 buffer list
    self.hunterDungeonInfo.buffList = {}
    local index = 1
    -- dump(bossCfg)
    for k, v in ipairs(bossCfg.weaknessLevel) do
        local buffCod = bossCfg.weaknessBuff[v]
        -- dump({v})
        -- dump(bossCfg.weaknessBuff)
        -- dump(buffCod)
        local count   = getCount(v) --关卡的挑战次数
        local deflevel  = 0
        local defBuffId = buffCod[1][2]
        for j, e in ipairs(buffCod) do
            if e[1] <= count then
                deflevel = j
                defBuffId = e[2]
            end
        end
        table.insert(self.hunterDungeonInfo.buffList,{buffId = defBuffId, level = deflevel, count = count,dungeon = v})
    end
    -- dump(self.hunterDungeonInfo)
end


function LeagueDataMgr:onRecvHuntingStepInfo(event)
    if not self.hunterDungeonInfo then 
        self:ReqHuntingDungeonInfo()
        return
    end
    dump(event.data)
    self.hunterDungeonInfo.step = event.data.step
    EventMgr:dispatchEvent(EV_HUNTER_INFO_UPDATE)
end

function LeagueDataMgr:onRecvHuntingBossInfo(event)
    if not self.hunterDungeonInfo then 
        self:ReqHuntingDungeonInfo()
        return
    end
    dump(event.data)
    self.hunterDungeonInfo.curBoss = event.data.boss
    self:resetBufferList()
    EventMgr:dispatchEvent(EV_HUNTER_INFO_UPDATE)
end

function LeagueDataMgr:onRecvHuntingWeaknessInfo(event)
    if not self.hunterDungeonInfo then 
        self:ReqHuntingDungeonInfo()
        return
    end
    dump(event.data)
    self.hunterDungeonInfo.playerWeakness = event.data.playerWeakness
    self:resetBufferList()
    EventMgr:dispatchEvent(EV_HUNTER_INFO_UPDATE)
end




function LeagueDataMgr:onRecvGetHuntingFDAward( event )
    local data = event.data
    if data then
        self.huntingRewardList.fdAward = data.fdAward
        self:sortRewardList(self.huntingRewardList.fdAward)
        EventMgr:dispatchEvent(EV_HUNTER_REWARDLIST_UPDATE)
    end

    if data.rewards then
        Utils:showReward(data.rewards)
    end
end

function LeagueDataMgr:onRecvGetHuntingPassAward( event )
    local data = event.data
    if data then
        self.huntingRewardList.passAward = data.passAward
        self:sortRewardList(self.huntingRewardList.passAward)
        EventMgr:dispatchEvent(EV_HUNTER_REWARDLIST_UPDATE)
    end

    if data.rewards then
        Utils:showReward(data.rewards)
    end
end
    -- repeated HuntingBossAward fdAward = 1;//首通奖励
    -- repeated HuntingBossAward passAward = 2;//击杀奖励



-- 1 未满足条件,2 可领取,3 已领取

local SortStausIndex = 
{
    [2] = 1,
    [1] = 2,
    [3] = 3,
    [0] = 4,
}
local function sort( list )
    table.sort(list,function(a ,b)
        local aa =  SortStausIndex[a.status]
        local bb =  SortStausIndex[b.status]
        if aa <  bb then 
            return true
        elseif aa ==  bb then  
            return a.bossLevel < b.bossLevel
        else
            return false 
        end
    end)
end

function LeagueDataMgr:sortRewardList(awards)  
    if awards then
        for i, award in ipairs(awards) do
            if not award.bossLevel then
                local cfg       = TabDataMgr:getData("HuntingLevel",award.dungeon) 
                award.bossLevel = cfg.bossLevel
            end
        end
        sort(awards)
    end
end
function LeagueDataMgr:onRecvHuntingRewardList( event )
    self.huntingRewardList = event.data
    self:sortRewardList(self.huntingRewardList.fdAward)
    self:sortRewardList(self.huntingRewardList.passAward)
    -- EventMgr:dispatchEvent(EV_HUNTER_REWARDLIST_GET)
end

function LeagueDataMgr:onRecvHuntingRankList( event )
    self.huntingRankList = event.data
    dump(self.huntingRankList)
    EventMgr:dispatchEvent(EV_HUNTER_RANKLIST_GET)
end

--获取奖励列表
function LeagueDataMgr:getHuntRewardList()
    return self.huntingRewardList or {}
end

--当前首通奖励是否已经领取(挑战期间)
function LeagueDataMgr:isReceivedFdReward()
    if self.huntingRewardList then 
        local fdAwards = self.huntingRewardList.fdAward
        if fdAwards and self.hunterDungeonInfo then 
            local curDungeon =  self.hunterDungeonInfo.curBoss.curDungeon
            for i, award in ipairs(fdAwards) do
                if award.dungeon == curDungeon then 
                    return award.status == 3 --已领取
                end
            end
        end
    end
    return false
end

--检查活动是否开启
function LeagueDataMgr:checkHunterOpen()
    if self.hunterDungeonInfo then 
        local step = self.hunterDungeonInfo.step.step
        return step ~= 0
    end
end
--能否进入追猎计划
function LeagueDataMgr:canEnterHunter()
    if self:checkSelfInUnion() then
        local menberInfo      = self:getMemberInfoByPlayerId(MainPlayer:getPlayerId())
        local joinTime        = menberInfo.joinTime
        local allContribution = menberInfo.allContribution
        local passTime        = ServerDataMgr:getServerTime()*1000 - joinTime
        local data = TabDataMgr:getData("DiscreteData",90002)
        local joinAllianceTime     = data.data.joinAllianceTime*60*1000
        local allianceContribution = data.data.allianceContribution
        -- dump({ServerDataMgr:getServerTime()*1000 , "joinTime="..joinTime ,"passTime="..passTime ,
        --     "joinAllianceTime="..joinAllianceTime ,"allContribution="..allContribution , "allContribution="..allianceContribution})
        if passTime < joinAllianceTime then 
            Utils:showTips(3300022)
            return false
        end
        if allContribution < allianceContribution then 
            Utils:showTips(3300021)
            return false
        end
        if not self:checkHunterOpen() then 
            return false
        end
        return true
    end
    return false
end

function LeagueDataMgr:checkAndOpenHunterView()
    if not self:canEnterHunter() then 
        return
    end
    --打开UI
    if self.hunterDungeonInfo then
        Utils:openView("league.LeagueHunterMainView")
    else
        --木有数据发请求吧
        self:ReqHuntingDungeonInfo()
    end
end
-- 获取buffer效果
function LeagueDataMgr:getBuffers(menberNum)
    local buffers = {}
    if self.hunterDungeonInfo then
        for i , v in ipairs(self.hunterDungeonInfo.buffList) do
            if v.level > 0 then
                table.insert(buffers,v.buffId)
            end         
        end 
        local dungeon = self.hunterDungeonInfo.curBoss.curDungeon
        local cfg     = TabDataMgr:getData("HuntingLevel",dungeon) 
        --根据人数确定增益buff
        local buffId = cfg.teamBuff[menberNum]
        if buffId then
            table.insert(buffers,buffId)
        end 
    end 
    return buffers
end
function LeagueDataMgr:getHuntingDungeonInfo()
    return self.hunterDungeonInfo --or {curBoss = {curDungeon = 101004, dungeonHp = 9801},step = {step = 1,nextTime = 13555555555554}}
end

function LeagueDataMgr:getMyUnionInfo()
    return self.myUnionData_
end

function LeagueDataMgr:getQueryUnionList()
    return self.unionSnapInfoList_
end

function LeagueDataMgr:getSearchOutUnion()
    return self.searchOutUnion
end

function LeagueDataMgr:getNotifysData()
    return self.notifys_
end

function LeagueDataMgr:checkSelfInUnion()
    if self.myUnionData_ and self.myUnionData_.id > 0 then
        return true
    end
    return false
end

function LeagueDataMgr:getSelfUnionId()
    if self:checkSelfInUnion() then
        return self.myUnionData_.id
    end
end

function LeagueDataMgr:getMemberInfoByPlayerId(playerId)
    if not self:checkSelfInUnion() then
        return
    end
    for i, info in ipairs(self.myUnionData_.members) do
        if info.playerId == playerId then
            return info
        end
    end
end

function LeagueDataMgr:getApplyInfoByPlayerId(playerId)
    if not self:checkSelfInUnion() then
        return
    end
    if self.myUnionData_ then
        for i, info in ipairs(self.myUnionData_.applyList) do
            if info.playerId == playerId then
                return info
            end
        end
    end
end

function LeagueDataMgr:getQueryUnionInfoById(unionId)
    local union
    for i,v in ipairs(self.unionSnapInfoList_) do
        if v.id == unionId then
            union = v
            break
        end
    end
    if not union then
        union = {}
        table.insert(self.unionSnapInfoList_, union)
    end
    return union
end

function LeagueDataMgr:checkPlayerIsMyUnionHead(playerId)
    local memberInfo = self:getMemberInfoByPlayerId(playerId)
    if memberInfo and memberInfo.degree == EC_UNION_DEGREE_Type.HEAD then
        return true
    end
    return false
end

function LeagueDataMgr:checkMemberReachMax()
    if not self:checkSelfInUnion() then
        return false
    end
    if #self.myUnionData_.members > 100 then
        return true
    end
    return false
end

function LeagueDataMgr:resetMembersActive()
    for k, v in pairs(self.myUnionData_.members) do
        v.weekContribution = 0
    end
end

function LeagueDataMgr:resetTrainMatrix()
    self.trainMatrixInfo = self.trainMatrixInfo or {}
    local baseCfg = self:getUnionLevelBaseCfg(self:getUnionLevel())
    self.trainMatrixInfo.remainTimes = baseCfg.trainingtimes
    self.trainMatrixInfo.receivePrizeIndex = {}
    self.trainMatrixInfo.score = 0
    self.trainMatrixInfo.selfTrainPrizeIndex = {}
    EventMgr:dispatchEvent(EV_UNION_TRAINMATRIX_REVERT)
end

function LeagueDataMgr:checkDegreeEnableChangeOthers(degree)
    local clubRights = TabDataMgr:getData("ClubRights")
    local rights = {}
    for k, info in pairs(clubRights) do
        if tonumber(k) == degree then
            for i,v in ipairs(info.rights) do
                if v == EC_UNION_PERMISSION_Type.CHANGE_DEGREE then
                    return true
                end

            end
        end
    end
    return false
end

function LeagueDataMgr:checkDegreeEnableKickMember(degree)
    local clubRights = TabDataMgr:getData("ClubRights")
    local rights = {}
    for k, info in pairs(clubRights) do
        if tonumber(k) == degree then
            for i,v in ipairs(info.rights) do
                if v == EC_UNION_PERMISSION_Type.KICK then
                    return true
                end
            end
        end
    end
    return false
end

function LeagueDataMgr:getEnableImpatchState()
    local suplsTime = self:getDelateSuplsTime()
    local leader = self:getUnionLeader()
    local data = TabDataMgr:getData("DiscreteData",51502).data
    local time1 = data.impeachLimitDay * 60
    local time2 = data.impeachLimitNewbee * 60
    local passTime = ServerDataMgr:getServerTime() - math.floor(leader.lastLoginTime / 1000)
    local degree = self:getSelfDegree()
    if degree == EC_UNION_DEGREE_Type.HEAD then
        return 1
    elseif suplsTime > 0 then
        return 3
    elseif degree == EC_UNION_DEGREE_Type.DEPUTY_HEAD then
        if passTime > time1 then
            return 2
        end
    else
        if passTime > time2 then
            return 2
        end
    end
    
    return 1
end

function LeagueDataMgr:getUnionLeaderName()
    if not self:checkSelfInUnion() then
        return ""
    end
    return self.myUnionData_.leaderName
end

function LeagueDataMgr:getUnionLeader()
    for k, v in pairs(self.myUnionData_.members or {}) do
        if v.degree == EC_UNION_DEGREE_Type.HEAD then
            return v
        end
    end
end

function LeagueDataMgr:getUnionLevel()
    if not self:checkSelfInUnion() then
        return 0
    end
    return self.myUnionData_.level
end

function LeagueDataMgr:getUnionExp()
    if not self:checkSelfInUnion() then
        return 0
    end
    return self.myUnionData_.exp
end

function LeagueDataMgr:getUnionWeekExp()
    if not self:checkSelfInUnion() then
        return 0
    end
    return self.myUnionData_.weekExp
end

function LeagueDataMgr:getUnionFusionTaskStageGetIndex()
    if not self:checkSelfInUnion() then
        return {}
    end
    return self.myUnionData_.weekExpPrizeReceiveIndex or {}
end

function LeagueDataMgr:getUnionActive()
    if not self:checkSelfInUnion() then
        return 0
    end
    return self.myUnionData_.lastWeekActive
end

function LeagueDataMgr:getUnionName()
    if not self:checkSelfInUnion() then
        return TextDataMgr:getText(100000083)
    end
    if self.myUnionData_.showCountry then
        local countryStr = ""
        if self.myUnionData_.showCountry then
            countryStr = " ("..self:getClubCountryDataById(self.myUnionData_.country).Countryabbreviations..")"
        end
        return self.myUnionData_.name..countryStr
    end
    return self.myUnionData_.name
end

function LeagueDataMgr:getUnionCountryName( ... )
    if not self:checkSelfInUnion() then
        return ""
    end
    return tonumber(self.myUnionData_.country or 0)
end

function LeagueDataMgr:getUnionMembers()
    if not self:checkSelfInUnion() then
        return {}
    end
    return self.myUnionData_.members
end

function LeagueDataMgr:getSortUnionMembers()
    if not self:checkSelfInUnion() then
        return {}
    end
    local sortMembers = {}
    for i,v in ipairs(self.myUnionData_.members) do
        table.insert(sortMembers, v)
    end 

    table.sort(sortMembers, function(a, b)
        local aState = a.online and 1 or 0
        local bState = b.online and 1 or 0
        if aState == bState then
            if a.degree == b.degree then
                return a.weekContribution > b.weekContribution
            end
            return a.degree < b.degree
        end
        return aState > bState
    end)
    return sortMembers
end

function LeagueDataMgr:getUnionApplyList()
    if not self:checkSelfInUnion() then
        return {}
    end
    return self.myUnionData_.applyList
end

function LeagueDataMgr:getUionEmblem()
    if not self:checkSelfInUnion() then
        return 101
    end
    return math.max(self.myUnionData_.icon, 101)
end

function LeagueDataMgr:getUnionMemberCount()
    local count = 0
    if not self:checkSelfInUnion() then
        return count
    end
    for i,v in ipairs(self.myUnionData_.members) do
        count = count + 1
    end
    return count
end

function LeagueDataMgr:getUnionMaxMemberCount()
    for k, v in pairs(self.clubBaesMap_) do
        if v.clublevel == self:getUnionLevel() then
            return v.maxmem
        end
    end
    return 1
end

function LeagueDataMgr:getUnionMemberOnlineCount()
    local count = 0
    if not self:checkSelfInUnion() then
        return count
    end
    for i,v in ipairs(self.myUnionData_.members) do
        if v.online then
            count = count + 1
        end
    end
    return count
end

function LeagueDataMgr:getSendRedPacketTimes()
    if not self:checkSelfInUnion() then
        return 0
    end
    return self.myUnionData_.sendTimes
end

function LeagueDataMgr:getUnionNotice()
    if not self:checkSelfInUnion() then
        return ""
    end
    if self.myUnionData_.notice then
        return self.myUnionData_.notice
    end
    return TextDataMgr:getText(270356)
end

function LeagueDataMgr:getCurSettingStateByType(cType)
    if not self:checkSelfInUnion() then
        return false
    end
    if cType == EC_UNION_SETTING_Type.OPEN_APPLY then
        return self.myUnionData_.canApply
    elseif cType == EC_UNION_SETTING_Type.LIMIT_JOIN then
        return self.myUnionData_.joinLimit
    elseif cType == EC_UNION_SETTING_Type.AUTO_JOIN then
        return self.myUnionData_.autoJoin
    elseif cType == EC_UNION_SETTING_Type.SHOW_COUNTRY then
        return self.myUnionData_.showCountry
    end
end

function LeagueDataMgr:getDelateEndTime()
    if not self:checkSelfInUnion() then
        return -1
    end
    return self.myUnionData_.delateEndTime or -1
end

function LeagueDataMgr:getDelateSuplsTime()
    if not self:checkSelfInUnion() then
        return -1
    end
    if self.myUnionData_.delateEndTime and self.myUnionData_.delateEndTime > 0 then
        return math.floor((self.myUnionData_.delateEndTime / 1000) - ServerDataMgr:getServerTime())
    end
    return -1
end

function LeagueDataMgr:getSupplyReceiveTimes()
    if not self:checkSelfInUnion() then
        return 0
    end
    return self.myUnionData_.receiveTimes or 0
end

function LeagueDataMgr:getSupplyMaxTimes()
    local maxTimes = 0
    if not self:checkSelfInUnion() then
        return maxTimes
    end
    for k, v in pairs(self.clubBaesMap_) do
        if v.clublevel == self.myUnionData_.level then
            maxTimes = v.supplytimes
            return maxTimes
        end
    end
    return maxTimes
end

function LeagueDataMgr:getCurLevelSupplyGroup()
    if not self:checkSelfInUnion() then
        return {}
    end
    local cfgData = {}
    local supplyDrop = TabDataMgr:getData("SupplyDrop")
    for k, v in pairs(supplyDrop) do
        if self.myUnionData_.level == v.jackpote then
            table.insert(cfgData, v)
        end
    end

    table.sort(cfgData, function(a,b)
        return a.extractorder < b.extractorder
    end)
    return cfgData
end

function LeagueDataMgr:getCurSupplyCfg()
    local cfgData = self:getCurLevelSupplyGroup()
    local curIndex = math.min(#cfgData, self:getSupplyReceiveTimes() + 1)
    for k, v in pairs(cfgData) do
        if v.extractorder == curIndex then
            return v
        end
    end
end

function LeagueDataMgr:getSupplyCfgById(id)
    local supplyDrop = TabDataMgr:getData("SupplyDrop")
    for k, v in pairs(supplyDrop) do
        if v.id == id then
            return v
        end
    end
end

function LeagueDataMgr:getJoinLimitLevel()
    if not self:checkSelfInUnion() then
        return 0
    end
    return self.myUnionData_.limitLevel or 0
end

function LeagueDataMgr:getJoinLimitPower()
    if not self:checkSelfInUnion() then
        return 0
    end
    return self.myUnionData_.limitPower
end

function LeagueDataMgr:getDegreeNumMax(degree)
    return self.degreeNumMax[degree] or 9999
end

function LeagueDataMgr:getCurDegreeNum(degree)
    local num = 0
    if not self:checkSelfInUnion() then
        return num
    end
    for i, info in ipairs(self.myUnionData_.members) do
        if info.degree == degree then
            num = num + 1
        end
    end
    return num
end

function LeagueDataMgr:checkDegreeNumReachMax(degree)
    local num = self:getCurDegreeNum(degree)
    local maxNum = self:getDegreeNumMax(degree)
    if num >= maxNum then
        return true
    end
    return false
end

function LeagueDataMgr:getSelfDegree()
    local memberInfo = self:getMemberInfoByPlayerId(MainPlayer:getPlayerId())
    if memberInfo then
        return memberInfo.degree
    end
    return EC_UNION_DEGREE_Type.MEMBER
end

function LeagueDataMgr:checkDegreeOwnPermission(degree, permissionType)
    local cfg = self:getDegreeCfgByDegree(degree)
    for k, v in pairs(cfg.rights) do
        if v == permissionType then
            return true
        end
    end
    return false
end

function LeagueDataMgr:getDegreeCfgByDegree(degree)
    return TabDataMgr:getData("ClubRights")[degree]
end

function LeagueDataMgr:getDegreePermissions()
    local clubRights = TabDataMgr:getData("ClubRights")
    local rights = {}
    for k, info in pairs(clubRights) do
        for i,v in ipairs(info.rights) do
            if table.indexOf(rights, v) == -1 then
                table.insert(rights, v)
            end
        end
    end
    table.sort(rights,function(a, b)
        return a < b
    end)
    local permissions = {}
    local names = {270426,270427,270428,270429,270430,270431,270432,270433,270434 , 190000181}
    for i, right in ipairs(rights) do
        local data = {}
        data.name =  TextDataMgr:getText(names[i])
        data.dgree = {}
        for k, info in pairs(clubRights) do
            if table.indexOf(info.rights, right) ~= -1 then
                data.dgree[info.id] = true
            end
        end
        permissions[right] = data
    end
    return permissions
end

function LeagueDataMgr:getFlagCfgArrayData()
    local emblemIds = self:getUnlockClubEmblem()
    local emblems = {}
    local using = {}
    local unlocks = {}
    local locks = {}
    local emblemMap = TabDataMgr:getData("ClubEmblem")
    for id,cfg in pairs(emblemMap) do
        if table.indexOf(emblemIds, cfg.id) ~= -1 then
            if cfg.id == self:getUionEmblem() then
                using[#using + 1] = cfg
            else
                unlocks[#unlocks + 1] = cfg
            end
        else
            locks[#locks + 1] = cfg
        end
    end
    function sortByOrder(a, b)
        return a.classifyOrder < b.classifyOrder
    end
    table.sort(using, sortByOrder)
    table.sort(unlocks, sortByOrder)
    table.sort(locks, sortByOrder)
    for i,v in ipairs(using) do
        table.insert(emblems, v)
    end
    for i,v in ipairs(unlocks) do
        table.insert(emblems, v)
    end
    for i,v in ipairs(locks) do
        table.insert(emblems, v)
    end
    
    return emblems
end

function LeagueDataMgr:getUnlockClubEmblem()
    local emblemIds = {}
    for k, v in pairs(self.clubBaesMap_) do
        if v.clublevel <= self:getUnionLevel() then
            table.insert(emblemIds, v.clubemblem)
        end
    end

    table.sort(emblemIds, function(a, b)
        return a < b
    end)
    return emblemIds
end

function LeagueDataMgr:getDefaultEmblemCfg()
    return self:getEmblemCfgById(101)
end

function LeagueDataMgr:getEmblemCfgById(id)
    local clubEmblem = TabDataMgr:getData("ClubEmblem")
    return clubEmblem[id] or clubEmblem[101]
end

function LeagueDataMgr:checkEmlemUnlock(id)
    local emblemIds = self:getUnlockClubEmblem()
    if table.indexOf(emblemIds, id) ~= -1 then
        return true
    end
    return false
end

function LeagueDataMgr:getUnionLevelBaseCfg(level)
    for k, v in pairs(self.clubBaesMap_) do
        if v.clublevel == level then
            return v
        end
    end
end

function LeagueDataMgr:getUnionFusionStageReward(level)
    if not self:checkSelfInUnion() then
        return {}
    end
    for k, v in pairs(self.clubBaesMap_) do
        if v.clublevel == level then
            return v.clubupdatereward
        end
    end
end

function LeagueDataMgr:getUnionFusionStageInfo(level)
    local stageReward = self:getUnionFusionStageReward(level)
    local data = {}
    for k, stageData in pairs(stageReward) do
        for j, rewards in pairs(stageData) do
            local info = {}
            info.stage = tonumber(j)
            info.reward = {}
            for m, n in pairs(rewards) do
                table.insert(info.reward, {id = m, num = n})
            end
            table.insert(data, info)
        end
    end
    table.sort(data, function(a, b)
        return a.stage < b.stage
    end)
    return data
end

function LeagueDataMgr:checkFusionStageIsCanReceive()
    local curWeekExp = self:getUnionWeekExp()
    local receiveIndex = self:getUnionFusionTaskStageGetIndex()
    local stageData = self:getUnionFusionStageInfo(self:getUnionLevel())
    for i,stageInfo in ipairs(stageData) do
        if curWeekExp >= stageInfo.stage and table.indexOf(receiveIndex, i - 1) == -1 then
            return true
        end
    end
    return false
end

function LeagueDataMgr:getUnionLevelUpExp(level)
    for k, v in pairs(self.clubBaesMap_) do
        if v.clublevel == level then
            return v.updateExp
        end
    end
    return 0
end

function LeagueDataMgr:getUnionLevelUpTotalExp(level)
    local exp = 0
    for k, v in pairs(self.clubBaesMap_) do
        if v.clublevel <= level then
            exp = exp + v.updateExp
        end
    end
    return exp
end

function LeagueDataMgr:getUnionFusionStageMaxActive(level)
    local rewards = self:getUnionFusionStageReward(level)
    local maxActive = 0
    for i,info in ipairs(rewards) do
        for k, v in pairs(info) do
            maxActive = math.max(maxActive, tonumber(k))
        end
    end
    return maxActive
end

function LeagueDataMgr:getUnionMaxLevel()
    local maxLevel = 0
    for k, v in pairs(self.clubBaesMap_) do
        maxLevel = math.max(maxLevel, v.clublevel)
    end
    return maxLevel
end

function LeagueDataMgr:getPacketCfgByType(pType)
    local cfgMap = TabDataMgr:getData("ClubPacket")
    for k, v in pairs(cfgMap) do
        if v.clublevel == self:getUnionLevel() and v.type == pType then
            return v
        end
    end
end

function LeagueDataMgr:getPacketCfgById(id)
    local cfgMap = TabDataMgr:getData("ClubPacket")
    for k, v in pairs(cfgMap) do
        if v.id == id then
            return v
        end
    end
end

function LeagueDataMgr:getSendPacketSurplsTimes(id)
    local cfg = self:getPacketCfgById(id)
    if not self:checkSelfInUnion() then
        return cfg.packettimes
    end
    if cfg.type == 1 then
        return cfg.packettimes - self.myUnionData_.goldRedpacketTime
    else
        return cfg.packettimes - self.myUnionData_.rechargeRedpacketTime
    end
end

function LeagueDataMgr:getDegreeName(degree)
    local clubRights = TabDataMgr:getData("ClubRights")
    for k, info in pairs(clubRights) do
       if info.id == degree then
            return TextDataMgr:getText(info.name)
       end
    end
    return ""
end

function LeagueDataMgr:getNotifyContent(notify)
    local content = ""
    local prams = notify.prams
    if notify.notifyType == EC_UNION_NOTIFY_Type.CREATE then
        content = TextDataMgr:getText(274001, notify.playerName)
    elseif notify.notifyType == EC_UNION_NOTIFY_Type.JOIN then
        content = TextDataMgr:getText(274002, notify.playerName)
    elseif notify.notifyType == EC_UNION_NOTIFY_Type.QUIT then
        content = TextDataMgr:getText(274003, notify.playerName)
    elseif notify.notifyType == EC_UNION_NOTIFY_Type.DEGREE then
        local name1 = LeagueDataMgr:getDegreeName(tonumber(notify.prams[1]))
        local name2 = LeagueDataMgr:getDegreeName(tonumber(notify.prams[3]))
        content = TextDataMgr:getText(274004, notify.playerName, name1, notify.prams[2], name2)
    elseif notify.notifyType == EC_UNION_NOTIFY_Type.CHANGE_LEADER then
        content = TextDataMgr:getText(274005, notify.playerName, prams[1] or "", prams[1] or "")
    elseif notify.notifyType == EC_UNION_NOTIFY_Type.LEADER_IMPEACH then
        content = TextDataMgr:getText(274006, notify.playerName)
    elseif notify.notifyType == EC_UNION_NOTIFY_Type.LEADER_DELATE_FAIL then
        content = TextDataMgr:getText(274007, notify.playerName)
    elseif notify.notifyType == EC_UNION_NOTIFY_Type.LEADER_IMPEACH_SUCC then
        content = TextDataMgr:getText(274008, notify.playerName, prams[1] or "")
    elseif notify.notifyType == EC_UNION_NOTIFY_Type.BUY_PACKAGE then
        local num = tonumber(prams[1])
        local nameArray = {270483, 270484, 270485}
        local name = ""
        if num < 2 then
            name = TextDataMgr:getText(nameArray[1])
        elseif num < 3 then
            name = TextDataMgr:getText(nameArray[2])
        else
            name = TextDataMgr:getText(nameArray[3])
        end
        content = TextDataMgr:getText(274009, notify.playerName, name)
    elseif notify.notifyType == EC_UNION_NOTIFY_Type.LEVEL_UP then
        content = TextDataMgr:getText(274010, prams[1] or 1)
    elseif notify.notifyType == EC_UNION_NOTIFY_Type.BUY_DONATE then
        content = TextDataMgr:getText(274011, notify.playerName, prams[1] or "", prams[2] or 0)
    end

    return content
end

---红点相关
function LeagueDataMgr:getApplyRedPointState()
    if not self:checkSelfInUnion() then
        return false
    end
    if self.myUnionData_.applyList then
        return #self.myUnionData_.applyList > 0
    else

    end
    return false
end

function LeagueDataMgr:getUnionTaskRedPointState()
    if not self:checkSelfInUnion() then
        return false
    end
    local isCanReceive = TaskDataMgr:isCanReceiveTask(EC_TaskType.FUSION_PERSONAL)
    if not isCanReceive then
        isCanReceive = TaskDataMgr:isCanReceiveTask(EC_TaskType.FUSION_UNION)
    end
    if not isCanReceive then
        isCanReceive = self:checkFusionStageIsCanReceive()
    end
    return isCanReceive
end

function LeagueDataMgr:getSupplyCenterRedPoint()
    if not self:checkSelfInUnion() then
        return false
    end
    return self:getSupplyReceiveTimes() < 1
end

function LeagueDataMgr:setJoinUnionRedPoint(state)
    self.joinUnionRed = state
end

function LeagueDataMgr:setNoticeChangeRedPoint(state)
    self.noticeChangeRed = state
end

function LeagueDataMgr:setUnionFlagUnlockRedPoint(state)
    self.flagUnlockRed = state
end

function LeagueDataMgr:getAllUnionRedPoint()
    if not self:checkSelfInUnion() then
        return false
    end
    local redState = self.joinUnionRed
    if not redState then
        redState = self.flagUnlockRed
    end
    if not redState then
        redState = self.noticeChangeRed
    end
    if not redState then
        redState = self:getApplyRedPointState()
    end
    if not redState then
        redState = self:getUnionTaskRedPointState()
    end
    if not redState then
        redState = self:getSupplyCenterRedPoint()
    end
    if not redState then
        redState = self:getTrainMatrixRedPoint()
    end
    --追猎计划是否开启
    if not redState then 
        redState = self:isHunterDungeonOpen() 
    end
    --追猎计划奖励领取
    if not redState then 
        redState = self:getHasHuntingFDAwardCanGet()
    end
    return redState
end

--[[--------特训矩阵相关接口----------]]
function LeagueDataMgr:getTrainMatrixInfo()
    return self.trainMatrixInfo
end

--当前特训矩阵主题id
function LeagueDataMgr:getTrainMatrixThemeId()
    return self.trainMatrixInfo and self.trainMatrixInfo.theme
end

--当前特训矩阵分组id
function LeagueDataMgr:getTrainMatrixGroupId()
    local matrixTb = TabDataMgr:getData("TrainingMatrix")
    for k, v in pairs(matrixTb) do
        if data.id == self.trainMatrixInfo.theme then
            return v.group
        end
    end
end

function LeagueDataMgr:getTrainMatrixRankPic(rank)
    local picArray = {
    "ui/league/texun/004.png",
    "ui/league/texun/003.png",
    "ui/league/texun/002.png",
    "ui/league/texun/001.png",
    "ui/league/texun/005.png",
    "ui/league/texun/006.png",
    "ui/league/texun/007.png"}
    return picArray[rank]
end

function LeagueDataMgr:getTrainMatrixThemeCfg(themeId)
    return TabDataMgr:getData("TrainingMatrix")[themeId]
end

--特训矩阵主题列表id
function LeagueDataMgr:getTrainMatrixThemeList()
    local themeList = {}
    local matrixTb = TabDataMgr:getData("TrainingMatrix")
    local cfg = self:getTrainMatrixThemeCfg(self.trainMatrixInfo.theme)
    if not cfg then
        return themeList
    end
    for k, v in pairs(matrixTb) do
        if v.level == cfg.level then
            table.insert(themeList, clone(v))
        end
    end
    table.sort(themeList, function(a, b)
        return a.id <= b.id
    end)
    return themeList
end

function LeagueDataMgr:getUnionTrainingStageReward(level)
    if not self:checkSelfInUnion() then
        return {}
    end
    for k, v in pairs(self.clubBaesMap_) do
        if v.clublevel == level then
            return v.trainingreward
        end
    end
end

--特训阶段奖励
function LeagueDataMgr:getUnionTrainingStageInfo(level)
    local stageReward = self:getUnionTrainingStageReward(level)
    local data = {}
    for k, stageData in pairs(stageReward) do
        for j, rewards in pairs(stageData) do
            local info = {}
            info.stage = tonumber(j)
            info.reward = {}
            for m, n in pairs(rewards) do
                table.insert(info.reward, {id = m, num = n})
            end
            table.insert(data, info)
        end
    end
    table.sort(data, function(a, b)
        return a.stage < b.stage
    end)
    return data
end

function LeagueDataMgr:checkTrainStageRedPoint()
    if not self.trainMatrixInfo then
        return false
    end
    local stageData = self:getUnionTrainingStageInfo(self:getUnionLevel())
    local receiveIndex = clone(self.trainMatrixInfo.receivePrizeIndex or {})
    for i, info in ipairs(stageData) do
        local idx = table.indexOf(receiveIndex, i - 1)
        if idx == -1 and self.trainMatrixInfo.score and self.trainMatrixInfo.score >= info.stage then
           return true
        end
    end
    return false
end

function LeagueDataMgr:checkTrainTaskRedPoint()
    local taskList = TaskDataMgr:getTask(EC_TaskType.UNION_TRAIN)
    for i, v in ipairs(taskList) do
        local taskCfg = TaskDataMgr:getTaskCfg(v)
        local taskInfo = TaskDataMgr:getTaskInfo(v)
        if taskinfo then
            if taskInfo.status == EC_TaskStatus.GET then
               return true
            end
        end
    end
    return false
end

function LeagueDataMgr:getTrainMatrixRedPoint()
    if not FunctionDataMgr:isOpenByClient(99) then
        return false
    end
    local flag = self.trainMatrixInfo.remainTimes and self.trainMatrixInfo.remainTimes > 0
    if not flag then
        flag = self:checkTrainStageRedPoint()
    end
    if not flag then
        flag = self:checkTrainTaskRedPoint()
    end
    return flag
end

--特训个人积分奖励
function LeagueDataMgr:getUnionTrainingActiveInfo()
    local taskData = TabDataMgr:getData("DiscreteData",51503).data.task
    local data = {}
    for i,v in ipairs(taskData) do
        local info = {}
        info.stage = tonumber(v.num)
        info.reward = {}
        for m, n in pairs(v.reward) do
            table.insert(info.reward, {id = m, num = n})
        end
        table.insert(data, info)
    end
    table.sort(data, function(a, b)
        return a.stage < b.stage
    end)
    return data
end

function LeagueDataMgr:getUnionTrainingMaxActiveStage()
    local taskData = TabDataMgr:getData("DiscreteData",51503).data.task
    local maxActive = 0
    for i,info in ipairs(taskData) do
        maxActive = math.max(maxActive, info.num)
    end
    return maxActive
end

function LeagueDataMgr:getHasHuntingFDAwardCanGet( )
    if self.huntingRewardList then  
        if self.huntingRewardList.fdAward then
            for k,v in pairs(self.huntingRewardList.fdAward) do
                if v.status == 2 then
                    return true
                end
            end
        end
        if self.huntingRewardList.passAward then 
            for k,v in pairs(self.huntingRewardList.passAward) do
                if v.status == 2 then
                    return true
                end
            end
        end
    end
    return false
end

function LeagueDataMgr:getClubCountryDataById( id )
    id = tonumber(id)
    return self.clubCountry_[id] or {}
end
--[[---------------------------------]]

return LeagueDataMgr:new()
