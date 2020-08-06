
local BaseDataMgr = import(".BaseDataMgr")
local AssistanceDataMgr = class("AssistanceDataMgr", BaseDataMgr)

function AssistanceDataMgr:init()
    self.inviteTaskCfg = TabDataMgr:getData("InviteTask")
    self.maxFriendScore = self:initFriendMaxScore()
    self.taskScoreItemId = self:initTaskScoreItemId()

    self.inviteCode = ""
    self.friendHelpInfo = {}
    self.youciRankData = {}
    self.youciGameInfo = {}

    TFDirector:addProto(s2c.FRIEND_RES_FRIEND_HELP_INFO, self, self.onResFriendHelpInfo)
    TFDirector:addProto(s2c.FRIEND_RES_QUICK_RECEIVE_FRIEND_HELP_TASK, self, self.onResQuickReceiveFriendHelpTask)
    TFDirector:addProto(s2c.FRIEND_RES_RECEIVE_FRIEND_HELP_TASK, self, self.onResReceiveFriendHelpTask)
    TFDirector:addProto(s2c.FRIEND_RES_REFRESH_FRIEND_HELP_TASK, self, self.onResRefreshFriendHelpTask)
    TFDirector:addProto(s2c.ACTIVITY_RES_FRIEND_HELP_ACTIVITY_PRE, self, self.onResFriendHelpActivityPre)
    TFDirector:addProto(s2c.ACTIVITY_RES_FRIEND_HELP_REWARD_ADDRESS, self, self.onResFriendHelpRewardAddress)    


    TFDirector:addProto(s2c.YOUCI_RSP_YOUCI, self, self.onRecvYouciGameInfo)    
    TFDirector:addProto(s2c.YOUCI_RSP_ROLL_YOUCI, self, self.onRecvRollYouCi)
    TFDirector:addProto(s2c.YOUCI_RSP_MAN_REFRESH_YOUCI, self, self.onRevRefreshYouCiAward)  
    TFDirector:addProto(s2c.YOUCI_RSP_YOUCI_RANK, self, self.onRevYouCiRankInfo)  
end

function AssistanceDataMgr:reset()
    self.inviteCode = ""
    self.friendHelpInfo = {}
end

--暂时屏蔽好友助力
function AssistanceDataMgr:onLogin()
    -- self:sendReqFriendHelpInfo()
    -- return {s2c.FRIEND_RES_FRIEND_HELP_INFO}
end

function AssistanceDataMgr:onLoginOut()
    self:reset()
end

--积分任务排序
function AssistanceDataMgr:sortTasks( taskList )
    table.sort(taskList, function(a, b)
        if a.order < b.order then return true end
        if a.order > b.order then return false end
        return a.id < b.id
    end)
    return taskList
end

--获取对应类型的积分任务
function AssistanceDataMgr:getInviteTasksByType( taskType )
    local taskList = {}
    for _,_task in pairs(self.inviteTaskCfg) do
        if _task.type == taskType then
            table.insert(taskList, _task)
        end
    end
    taskList = self:sortTasks(taskList)
    return taskList
end

--获取对应类型的开放的积分任务
function AssistanceDataMgr:getInviteOpenTasksByType( taskType )
    local taskList = {}
    for _,_task in ipairs(self:getInviteTasksByType(taskType)) do 
        if _task.open then
            table.insert(taskList, _task)
        end
    end
    return taskList
end

function AssistanceDataMgr:getInviteCfgById( id )
    return self.inviteTaskCfg[id]
end

--助力好友列表
function AssistanceDataMgr:getFriendHelpInfo( )
    local list = clone(self.friendHelpInfo)

    local list1 = {}
    local list2 = {}
    for _,_info in ipairs(list) do   
        if self:getFriendScore(_info.playerId) >= self:getFriendMaxScore() then
            table.insert(list1, _info)
        else
            table.insert(list2, _info)
        end
    end 
    list1 = self:sortFriendHelpInfo(list1)
    list2 = self:sortFriendHelpInfo(list2)

    for _,_info in ipairs(list1) do  
        table.insert(list2, _info)
    end
    return list2
end

--按积分贡献大小依次排列
function AssistanceDataMgr:sortFriendHelpInfo( list )
    table.sort(list, function(a, b)
        local redPointA = self:checkAllTaskRedPoint(a.playerId)
        local redPointB = self:checkAllTaskRedPoint(b.playerId)
        local tmpA = redPointA and 1 or 0
        local tmpB = redPointB and 1 or 0
        local scoreA = self:getFriendScore(a.playerId)
        local scoreB = self:getFriendScore(b.playerId)
        if tmpA == tmpB then
            if scoreA > scoreB then return true end
            if scoreA < scoreB then return false end
            if scoreA == scoreB then
                if a.level > b.level then return true end
                if a.level < b.level then return false end
                if a.level == b.level then return a.playerId > b.playerId end
            end
        else
            return tmpA > tmpB
        end
    end)
    return list
end

--玩家已经贡献的积分
function AssistanceDataMgr:getFriendScore( playerId )
    local score = 0
    local taskInfos = self:getFriendHelpTaskInfo(playerId)
    for _,_taskInfo in ipairs(taskInfos) do
        if _taskInfo.status == EC_FRIENDHELPTASKSTATUS.RECEIVED then
            local inviteTaskCfg = self:getInviteCfgById(_taskInfo.taskId)
            score = score + inviteTaskCfg.reward[1][2]
        end       
    end
    return score
end

function AssistanceDataMgr:initFriendMaxScore( )
    local score = 0
    for _,_taskType in pairs(EC_INVITE_TASK) do  
        local taskList = self:getInviteOpenTasksByType(_taskType)
        for _,_task in ipairs(taskList) do       
            score = score + _task.reward[1][2]
        end       
    end
    return score
end

function AssistanceDataMgr:getFriendMaxScore( )
    return self.maxFriendScore
end

function AssistanceDataMgr:getFriendHelpInfoById( playerId )
    for _,_friendHelpInfo in ipairs(self.friendHelpInfo) do
        if _friendHelpInfo.playerId == playerId then
            return _friendHelpInfo
        end
    end
    return nil
end

function AssistanceDataMgr:getFriendHelpTaskInfo( playerId )
    local friendHelpInfo = self:getFriendHelpInfoById(playerId) 
    if friendHelpInfo == nil then return {} end
    return friendHelpInfo.taskInfos or {}
end

--单个任务红点
function AssistanceDataMgr:checkTaskRedPoint( playerId, taskId )
    local taskInfos = self:getFriendHelpTaskInfo(playerId)
    for _,_taskInfo in ipairs(taskInfos) do
        if self:getTaskStatus(playerId, taskId) == EC_FRIENDHELPTASKSTATUS.FINISHED then
            return true
        end       
    end
    return false
end

--邀请码界面单个好友红点
function AssistanceDataMgr:checkAllTaskRedPoint( playerId )
    local taskInfos = self:getFriendHelpTaskInfo(playerId)
    for _,_taskInfo in ipairs(taskInfos) do
        if self:checkTaskRedPoint(playerId, _taskInfo.taskId) then
            return true
        end       
    end
    return false
end

--主界面红点
function AssistanceDataMgr:checkPlayersTaskRedPoint( )
    for _,_friendHelpInfo in ipairs(self.friendHelpInfo) do
        if self:checkAllTaskRedPoint(_friendHelpInfo.playerId) then
            return true
        end
    end
    return false
end

function AssistanceDataMgr:getTaskStatus( playerId, taskId )
    local taskInfos = self:getFriendHelpTaskInfo(playerId)
    for _,_taskInfo in ipairs(taskInfos) do
        if _taskInfo.taskId == taskId then
            return _taskInfo.status
        end       
    end
    return EC_FRIENDHELPTASKSTATUS.UNFINISHED
end

--好友助力信息
function AssistanceDataMgr:sendReqFriendHelpInfo( )
    TFDirector:send(c2s.FRIEND_REQ_FRIEND_HELP_INFO, {})
end

function AssistanceDataMgr:onResFriendHelpInfo( event )
    local data = event.data
    print("好友助力信息：", data)
    self.inviteCode = data.inviteCode
    self.friendHelpInfo = {}
    if data.friendHelpInfos then
        self.friendHelpInfo = data.friendHelpInfos
    end
    EventMgr:dispatchEvent(EV_ASSISTANCE_FRIENDHELPINFOS)
end

function AssistanceDataMgr:initTaskScoreItemId( )
    for _,_task in pairs(self.inviteTaskCfg) do
        return _task.reward[1][1]
    end
    return 0
end

function AssistanceDataMgr:getInviteCode( )
    return self.inviteCode
end

function AssistanceDataMgr:getTaskScoreItemId( )
    return self.taskScoreItemId
end

function AssistanceDataMgr:sendReqQuickReceiveFriendHelpTask( )
    TFDirector:send(c2s.FRIEND_REQ_QUICK_RECEIVE_FRIEND_HELP_TASK, {})
end

function AssistanceDataMgr:updateFriendHelpInfo( friendInfo )
    local isExist = false   
    for _,_friendInfo in ipairs(self.friendHelpInfo) do      
        if _friendInfo.playerId == friendInfo.playerId then
            isExist = true
            _friendInfo.playerId = friendInfo.playerId
            _friendInfo.playerName = friendInfo.playerName
            _friendInfo.portraitCid = friendInfo.portraitCid
            _friendInfo.portraitFrameCid = friendInfo.portraitFrameCid
            _friendInfo.level = friendInfo.level
            _friendInfo.taskInfos = friendInfo.taskInfos
            break
        end
    end

    if not isExist then
        table.insert(self.friendHelpInfo, friendInfo)
    end              
end

function AssistanceDataMgr:onResQuickReceiveFriendHelpTask( event )
    local data = event.data
    print("一键领取好友助力：", data)
    if data.friendHelpInfos then
        for _,_updateFriendInfo in ipairs(data.friendHelpInfos) do                                              
            self:updateFriendHelpInfo(_updateFriendInfo)                  
        end       
    end
    if data.rewardItems and #data.rewardItems > 0 then
        Utils:showReward(data.rewardItems)
    end
    EventMgr:dispatchEvent(EV_RESQUICKRECEIVEFRIENDHELPTASK) 
end

function AssistanceDataMgr:sendReqReceiveFriendHelpTask( inviteeId, taskId)
    TFDirector:send(c2s.FRIEND_REQ_RECEIVE_FRIEND_HELP_TASK, {inviteeId, taskId})
end

function AssistanceDataMgr:onResReceiveFriendHelpTask( event )
    local data = event.data
    print("领取好友助力任务返回：", data)
    if data.friendHelpInfo then
        self:updateFriendHelpInfo(data.friendHelpInfo)       
    end
    if data.rewardItems and #data.rewardItems > 0 then
        Utils:showReward(data.rewardItems)
    end
    EventMgr:dispatchEvent(EV_RESRECEIVEFRIENDHELPTASK, data) 
end

function AssistanceDataMgr:onResRefreshFriendHelpTask( event )
    local data = event.data
    print("推送好友助力：", data)
    if data.friendHelpInfo then
        self:updateFriendHelpInfo(data.friendHelpInfo)   
    end
    EventMgr:dispatchEvent(EV_RESREFRESHFRIENDHELPTASK, data)   
end

--地址拉取
function AssistanceDataMgr:sendReqFriendHelpActivityPre( )
    TFDirector:send(c2s.ACTIVITY_REQ_FRIEND_HELP_ACTIVITY_PRE, {})
end

function AssistanceDataMgr:onResFriendHelpActivityPre( event )
    local data = event.data
    EventMgr:dispatchEvent(EV_RESFRIENDHELPACTIVITYPRE, data)   
end

function AssistanceDataMgr:sendReqFriendHelpRewardAddress( entityId )
    TFDirector:send(c2s.ACTIVITY_REQ_FRIEND_HELP_REWARD_ADDRESS, {entityId})
end

function AssistanceDataMgr:onResFriendHelpRewardAddress( event )
    EventMgr:dispatchEvent(EV_RESFRIENDHELPREWARDADDRESS, event.data)   
end

function AssistanceDataMgr:getActivityStoreInfo( )
    local activitys = ActivityDataMgr2:getActivityInfo(nil, 3)
    activityInfo = activitys[1]
    return activityInfo
end

function AssistanceDataMgr:onRecvYouciGameInfo(event)
    self.youciGameInfo = event.data
    self.youciGameInfo.records = self.youciGameInfo.records or {}
    self.youciGameInfo.posRewarded = self.youciGameInfo.posRewarded or {}
    table.sort(self.youciGameInfo.records , function(a , b)
            return a.time>b.time
    end)
    EventMgr:dispatchEvent(EV_YOUCI_RSP_YOUCI , {})
end

function AssistanceDataMgr:onRecvRollYouCi( event )
    local data = event.data
    for k ,v in pairs(data.records) do
        table.insert(self.youciGameInfo.records , v)
    end
    table.sort(self.youciGameInfo.records , function(a , b)
            return a.time>b.time
    end)
    self.youciGameInfo.rounds = data.rounds
    EventMgr:dispatchEvent(EV_YOUCI_RSP_ROLL_YOUCI , data)
end

function AssistanceDataMgr:getYouCiInfo( ... )
    return self.youciGameInfo
end

function AssistanceDataMgr:onRevRefreshYouCiAward( event )
    local data = event.data
    self:getYouCiInfo().rewardId = data.rewardId
    EventMgr:dispatchEvent(EV_YOUCI_RSP_MAN_REFRESH_YOUCI , data)
end

function AssistanceDataMgr:onRevYouCiRankInfo(event)
    local data = event.data
    self.youciRankData = data or {}
    EventMgr:dispatchEvent(EV_YOUCI_RSP_YOUCI_RANK , data)
end

function AssistanceDataMgr:getYouCiRankData( ... )
    return self.youciRankData
end

--获取尤茨信息
function AssistanceDataMgr:sendYouCiInfoReq( ... )
    TFDirector:send(c2s.YOUCI_REQ_YOUCI, {})
end

--发送扔尤茨请求
function AssistanceDataMgr:sendStarYouCiGameReq( ... )
    TFDirector:send(c2s.YOUCI_REQ_ROLL_YOUCI, {})
end

--发送尤茨刷新奖池
function AssistanceDataMgr:sendRefreshAwardReq( )
    TFDirector:send(c2s.YOUCI_REQ_MAN_REFRESH_YOUCI, {})
end

--请求尤茨排行
function AssistanceDataMgr:sendYouCiRankReq( )
    -- body
    TFDirector:send(c2s.YOUCI_REQ_YOUCI_RANK, {})
end

return AssistanceDataMgr:new()
