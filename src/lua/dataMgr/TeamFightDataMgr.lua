local LockStep = require("lua.logic.battle.LockStep")
local enum   = require("lua.logic.battle.enum")
local eEvent = enum.eEvent
local BaseDataMgr = import(".BaseDataMgr")
local TeamFightDataMgr = class("TeamFightDataMgr", BaseDataMgr)


function TeamFightDataMgr:getTeamLevelCfg( nTeamType, dungeonId )
	print("-------------------------------------------nTeamType=" .. nTeamType)
    local battlecfg = TabDataMgr:getData("ChasmDungeon")[dungeonId]
    if nTeamType == 2 then
        battlecfg = TabDataMgr:getData("TrainDungeonLevel")[dungeonId]
        if not battlecfg then
            battlecfg = TabDataMgr:getData("ChasmDungeon")[dungeonId]
        end
    elseif nTeamType == 3 or nTeamType == 4  or nTeamType == 6 then
        battlecfg = TabDataMgr:getData("HighTeamDungeon")[dungeonId]
    elseif nTeamType == 5 then --追猎计划组队
        battlecfg = TabDataMgr:getData("HuntingLevel")[dungeonId]
    elseif nTeamType == 7 then --追猎计划组队
        battlecfg = TabDataMgr:getData("SnowDungeon")[dungeonId]
    end
    return battlecfg
end

function TeamFightDataMgr:init()
    TFDirector:addProto(s2c.TEAM_TEAM_INFO, self, self.onRecvTeamData)					                --队伍信息
    TFDirector:addProto(s2c.TEAM_RESP_CREATE_TEAM, self, self.onRecvCreateTeam)                         --创建队伍回发
    TFDirector:addProto(s2c.TEAM_RESP_TREAT_MEMBER, self, self.onRecvTreatMember)                       --任命队长回发
    TFDirector:addProto(s2c.TEAM_RESP_MATCH_TEAM, self, self.onRecvMatchTeam,false)                           --单人请求匹配回发
    TFDirector:addProto(s2c.TEAM_RESP_LEAVE_TEAM, self, self.onRecvLeaveTeam)                           --离开队伍回发
    TFDirector:addProto(s2c.TEAM_RESP_JOIN_TEAM, self, self.onRecvJoinTeam)                             --加入队伍回发
    TFDirector:addProto(s2c.TEAM_RESP_CANCEL_MATCH, self, self.onRecvMatchTeamQuit)                     --匹配退出回发
    TFDirector:addProto(s2c.TEAM_RESP_CHANGE_HERO, self, self.onRecvChangeHero)                         --更换英雄回发
    TFDirector:addProto(s2c.TEAM_RESP_CHANGE_MENBER_STATUS, self, self.onRecvSetTeamMenberStatus)       --请求设置队员状态回发
    TFDirector:addProto(s2c.TEAM_RESP_CHANGE_TEAM_STATUS, self, self.onRecvSetTeamStatus)               --设置队伍状态回发
    TFDirector:addProto(s2c.CHASM_RSEP_CHASM_START_FIGHT, self, self.onRecvStartFightInfo)              --请求开始战斗相关信息
    TFDirector:addProto(s2c.CHASM_RESQ_CHASM_FIGHT_REVIVE, self, self.onRecvFightRevive)                --请求复活
    -- TFDirector:addProto(s2c.CHASM_RESQ_CHASM_EXIT_FIGHT, self, self.onRecvExitFight)                    --请求离开战斗
    -- TFDirector:addProto(s2c.CHASM_RSEP_CHASM_OVER_FIGHT, self, self.onRecvOverFight)
	TFDirector:addProto(s2c.CHASM_RSEP_ENTER_CHASM, self, self.onRecvTeramFubenStat)                    --通知
    TFDirector:addProto(s2c.CHASM_RESP_BUY_CHASM_COUNT, self, self.onRecvTeamBuyCount)
    TFDirector:addProto(s2c.TEAM_RES_APPRECIATE, self, self.onRecvTumbledUpMsg)                  --点赞消息
    TFDirector:addProto(s2c.TEAM_RES_CHASM_REPORT, self, self.onRecvInformPlayer)   --举报发聩
    TFDirector:addProto(s2c.FIGHT_RESP_END_FIGHT_OTHER, self, self.onRecvHeroReward)

    TFDirector:addProto(s2c.TEAM_RESP_ALL_TEAM_INFO, self, self.onRecvRoomInfo)
    TFDirector:addProto(s2c.TEAM_RESP_SET_TEAM_SHOW_TYPE, self, self.onRecvShowInRoomState)

	TFDirector:addProto(s2c.TEAM_RESP_MATCH_RANK, self, self.onRecvMatchRank)
	

    self.inviteSendReport = {friend = {},public = {},club = {}}
    self.levelsGroup = TabDataMgr:getData("ChasmDungeonGroup")
    self.levelsCfg = TabDataMgr:getData("ChasmDungeon")
    self.maxPlayerLv = Utils:getKVP(9002,"pmaxlvl")
    self.groupListCfg = {}
    for k,v in pairs(self.levelsGroup) do
        self.groupListCfg[#self.groupListCfg +1] = v
    end
    table.sort( self.groupListCfg, function(a,b)
        return a.id < b.id
    end )

    self.teamRoom        = {}

    self:reset()
end


function TeamFightDataMgr:reset()
    self.strTeamId       = ""
    self.tTeamMemberInfo = {}
    self.nTeamStatus     = 0
    self.nLeaderId       = self.nLeaderId or 0
    self.nTreatType      = 0
    self.nBattleId       = self.nBattleId or 0
--当前复活次数
    self.nReviveCount    = self.nReviveCount or 0
    self.reviveCost      = self.reviveCost or {} --复活消耗
    self.roomTypeCfg = Utils:getKVP(28504,"room")
    self.showInRoom = true
    self.minLv           = 1
end

function TeamFightDataMgr:onLoginOut()
    self.teamRoom        = {}
end

function TeamFightDataMgr:onEnterMain()
    self:requestTeamLevelStat()
end

--记录复活次数
function TeamFightDataMgr:setReviveCount(ncount)
    self.nReviveCount = ncount
end

-- --剩余复活次数
function TeamFightDataMgr:hasReviveCount()
    return #self.reviveCost - self.nReviveCount
end

--最大复活次数
function TeamFightDataMgr:getMaxReviveCount()
    return #self.reviveCost
end
--计算复活消耗
function TeamFightDataMgr:getReviveConst()
    local index = self.nReviveCount + 1
    index = math.min(index,#self.reviveCost)
    return self.reviveCost[index] or {}
end

--显示复活对话框
function TeamFightDataMgr:getReviveData()
    --剩余复活次数
    local reviveData = {}
    if self.forbidRevive then return nil end -- 当前组队战斗不能复活
    local reviveCount = self:hasReviveCount()
    reviveData.reviveCount = reviveCount
    local reviveConst = self:getReviveConst()
    local params = clone(EC_TeamReviveParams)
    params.reviveCallback  = handler(self.requestRevive,self)
    params.cost_id    = 0 --消耗道具ID
    params.cost_count = 0 --消耗数量
    params.has_revive_times = reviveCount
    for k,v in pairs(reviveConst) do
        params.cost_id    = k
        params.cost_count = v
    end
    reviveData.params = params
    return reviveData
end

--退出组队战斗二次确认框
function TeamFightDataMgr:showExitTeamFightBox()
    local function onConfirm()
        self:requestExitFight()
        LockStep.closeUDP() --断开KCP 连接
        EventMgr:dispatchEvent(eEvent.EVENT_LEAVE)
    end
    local params = {
        ["msg"] = 2100089,
        ["title"] = 800011,
        ["confirm_title"] = 800010,
        ["comfirmCallback"] = onConfirm,
        ["cancel_title"] = 800029,
        ["cancelCallback"] = nil,
        ["showtype"] = EC_GameAlertType.comfirmAndCancel,
    }
    showGameAlert(params)
end




----------------------------------------------------------------------RECV
function TeamFightDataMgr:onRecvTeramFubenStat(event)
    self:handleTeamFubenStat(event.data)
    EventMgr:dispatchEvent(EV_TEAM_FIGHT_LEVEL_STAT_LIST)
end

function TeamFightDataMgr:onRecvTeamBuyCount(event)
    self:updateTeamFubenStat(event.data)
    EventMgr:dispatchEvent(EV_TEAM_BUY_CHANLENGE_COUNT)
    EventMgr:dispatchEvent(EV_TEAM_FIGHT_LEVEL_STAT_LIST)
end

function TeamFightDataMgr:onRecvTumbledUpMsg(event)
    if event.data then
        Utils:showTips(2100148,event.data.name)
    end
end

function TeamFightDataMgr:onRecvInformPlayer(event )
    if event.data then
        Utils:showTips(2100156,event.data.name)
        EventMgr:dispatchEvent(EV_REPORT_SUCCESS)
    end
end

function TeamFightDataMgr:onRecvTeamData(event)
    local data = event.data
    print("TeamFightDataMgr:onRecvTeamData ..",event.data)
    self:installTeamInfo(data)
end

function TeamFightDataMgr:onRecvCreateTeam(event)
	print("========================================TeamFightDataMgr:onRecvCreateTeam event.errorCode" .. event.errorCode)
    if event.errorCode == 0 then
        local data = event.data.team
        if data then
            self:installTeamInfo(data)
            self:openTeamView()
        else
            EventMgr:dispatchEvent(EV_TEAM_FIGHT_CREAT_TEAM)
        end
    end
end

function TeamFightDataMgr:onRecvLeaveTeam(event)
    if event.data.type == 1 then
        -- 主动退出成功 直接关闭
        self:reset()
        EventMgr:dispatchEvent(EV_TEAM_FIGHT_EXIT_TEAM)
    elseif event.data.type == 2 then
        --TOAST TIP be kicked out
        --CLOSE team ui
        self:reset()
        EventMgr:dispatchEvent(EV_TEAM_FIGHT_NOTIFY_KICK_OUT_TEAM)
    elseif event.data.type == 3 then
        self:reset()
        EventMgr:dispatchEvent(EV_TEAM_FIGHT_TEAMTIME_OUT_TEAM)
    end
end

function TeamFightDataMgr:onRecvMatchTeamQuit(event)
    self:reset()
    if event.data.type == 1 then
        EventMgr:dispatchEvent(EV_TEAM_FIGHT_CANCEL_MATCH)
    elseif event.data.type == 2 then
        EventMgr:dispatchEvent(EV_TEAM_FIGHT_MATCH_TIME_OUT)
    elseif event.data.type == 3 then
        EventMgr:dispatchEvent(EV_TEAM_FIGHT_MATCH_CANCEL_FAIL)
    end
end

function TeamFightDataMgr:onRecvSetTeamStatus(event)
    --TOAST TIP "start or close team matching"
    EventMgr:dispatchEvent(EV_TEAM_FIGHT_SET_TEAM_STATUS)
end

function TeamFightDataMgr:onRecvTreatMember(event)
    if self.nTreatType == 1 then
        --TOAST TIP "leader changed"
        EventMgr:dispatchEvent(EV_TEAM_FIGHT_APPONT_LEADER)
    elseif self.nTreatType == 2 then
        --TOAST TIP "kick out member success"
        EventMgr:dispatchEvent(EV_TEAM_FIGHT_KICK_OUT)
    end
end

function TeamFightDataMgr:onRecvMatchTeam(event)
    --OPEN matching view
    if self.strTeamId ~= "" then
        return
    end
    if event.errorCode == 0 then
        EventMgr:dispatchEvent(EV_TEAM_FIGHT_AUTO_JOIN)
    end
end

function TeamFightDataMgr:onRecvJoinTeam(event)
    --TOAST TIP "match team success"
    --OPEN teamview
    local data = event.data.team
	
	local matchType = self.roomTypeCfg[3][1]
	if self.nTeamType == matchType then	--符石类型使用服务器传过来的battleID,其他情况使用本地存的battleId(保持原来的逻辑不变)
		self.nBattleId	 = data.battleId	or 0
	end

    self:installTeamInfo(data)
    self:openTeamView()
end

function TeamFightDataMgr:onRecvChangeHero(event)
    --CLOSE change hero view
    --TOAST TIP "change hero success"
    EventMgr:dispatchEvent(EV_TEAM_FIGHT_CHANGE_HERO)
end

function TeamFightDataMgr:onRecvSetTeamMenberStatus(event)
    --TOAST TIP "ready or cancle ready"
    -- if self.nTempStatus == 1 TOAST TIP "cancle ready
    -- if self.nTempStatus == 2 TOAST TIP "ready
    EventMgr:dispatchEvent(EV_TEAM_FIGHT_SET_MEMBER_STATUS)
end

function TeamFightDataMgr:onRecvFightRevive(event)
    local data = event.data
    if data.isSuccess then
        self.nReviveCount = self.nReviveCount + 1
        LockStep.sendRelive()
    else
        self:reFreshreviveCostData()
    end
    EventMgr:dispatchEvent(EV_TEAM_FIGHT_FIGHT_REVIVE, data.isSuccess)
end

function TeamFightDataMgr:onRecvExitFight(event)
    --TOAST TIP "Exit Success"
    -- LockStep.closeUDP() --断开KCP 连接
    -- EventMgr:dispatchEvent(eEvent.EVENT_LEAVE)

end

function TeamFightDataMgr:onRecvStartFightInfo(event)

    local data      = event.data
    data.levelCid   = data.dungeonCid --测试关卡
    data.battleType = EC_BattleType.TEAM_FIGHT
    self:cleanCacheData()
    if self.nBattleId ~= tonumber(data.levelCid) then
        local message = "[nBattleId="..tostring(self.nBattleId).." levelCid="..tonumber(data.levelCid).."]"
        Bugly:ReportLuaException(TextDataMgr:getText(100000079)..message)
        return
    end
    self.nBattleId  = tonumber(data.levelCid)
    local tmlevelCfg  = self:getBattleCfg()
    self:reFreshreviveCostData() --复活消耗

    self.forbidRevive = tmlevelCfg.forbidRevive or false
    --设置战斗通讯方式(1KCP 2 tcp)
    LockStep.setConnectType(data.netType)
    -- Box("aa")
    --战斗开始倒计时UI
    EventMgr:dispatchEvent(EV_TEAM_RUN_BATTLE_SCENE)
    local layer = require("lua.logic.teamFight.TeamFightCountDown"):new(data)
    AlertManager:addLayer(layer,AlertManager.BLOCK)
    AlertManager:show()
    FubenDataMgr:cachePlayerInfo()
end

function TeamFightDataMgr:reFreshreviveCostData()
    self.reviveCost = clone(self:getBattleCfg().reviveCost)
     -- 适配以前的逻辑 加入周卡月卡特权免费复活次数
     local isHavePrivilege, cfg = RechargeDataMgr:getIsHavePrivilegeByType(107)
     if isHavePrivilege and self.reviveCost then
         for i = 1, cfg.privilege.chance do
             table.insert(self.reviveCost, 1, {[500002] = 0})
         end
     end
end

function TeamFightDataMgr:onRecvHeroReward(event)
    local data = event.data
    -- dump(data)
    print("_收到队友奖励消息")
    if not data then 
        return
    end
    if self.battleEndData then
        if self.battleEndData.results then 
            for i, v in ipairs(self.battleEndData.results) do
                if v.pid == data.pid then 
                    v.rewards = data.rewards or {}
                end
            end
        end
    end
    self.battleRewards = self.battleRewards or {}
    self.battleRewards[data.pid] = data
    EventMgr:dispatchEvent(EV_TEAM_FIGHT_HERO_REWARD,data)
    
end

function TeamFightDataMgr:onRecvOverFight(event)
    local data      = event.data
    dump(data)
    print("_收到战斗结束消息")
    if data.results then
        for i,v in ipairs(data.results) do
            if v.pid == MainPlayer:getPlayerId() then
                v.rewards = data.rewards or {}
            else
                if self.battleRewards and self.battleRewards[v.pid] then 
                    v.rewards = self.battleRewards[v.pid].rewards
                end
                v.rewards = v.rewards or {}
            end
        end
    end
   
    --组队战斗中退出游戏再进入不显示最对结算界面
    if self.nTeamId == "" then
        return
    end
    local battleData = BattleDataMgr:getBattleData()
    if not battleData or     battleData.battleType ~= EC_BattleType.TEAM_FIGHT then
        return
    end
    --追猎计划如果已经进行加结算不再处理结算消息
    if battleData.teamType == 5 then 
        if battleData.jjs then
            return
        end
    end
    -- EventMgr:dispatchEvent(eEvent.EVENT_LEAVE)
    --关闭所有弹框
    AlertManager:closeAll()
    LockStep.closeUDP() --断开KCP 连接
    self.battleEndData = data
    --若果战斗已经结束
    if battleController.isClearing then
        --延迟退出
       local timer
       timer = TFDirector:addTimer(1000, -1, nil, function ()
           TFDirector:removeTimer(timer)
            if data.win then
                local layer = require("lua.logic.battle.BattleResultView"):new()
                AlertManager:addLayer(layer,AlertManager.BLOCK)
                AlertManager:show()
            else
                EventMgr:dispatchEvent(eEvent.EVENT_LEAVE)
            end
       end)
    else
        --战斗还未结束强制结束
        --强制结束战斗
        battleController.forceEndBattle(data.win,function()
            if data.win then
                local layer = require("lua.logic.battle.BattleResultView"):new()
                AlertManager:addLayer(layer,AlertManager.BLOCK)
                AlertManager:show()
            else
                EventMgr:dispatchEvent(eEvent.EVENT_LEAVE)
            end
        end)
    end
end

function TeamFightDataMgr:getLimitLevel()
    return self.minLv or 1
end

function TeamFightDataMgr:getTeamRoomVisibleType()
    return self.visibleType or 0
end

-----------------------------------------------------------------REQUEST
function TeamFightDataMgr:requestTeamLevelStat()
    TFDirector:send(c2s.CHASM_REQ_ENTER_CHASM,{})
end

function TeamFightDataMgr:requestAddFightCount(id)
    TFDirector:send(c2s.CHASM_REQ_BUY_CHASM_COUNT,{id})
end

function TeamFightDataMgr:requestGiveThumbUp(pid,levelId)
    TFDirector:send(c2s.TEAM_REQ_APPRECIATE,{pid,levelId})
end

function TeamFightDataMgr:requestInformPlayer(info)
    TFDirector:send(c2s.TEAM_REQ_CHASM_REPORT,info)
end

---//请求创建队伍
function TeamFightDataMgr:requestCreateTeam( nTeamType,nBattleId,costItemId)      --@nTeamType 队伍类型 @nBattleId副本id
    -- body

    self:reset()
    nTeamType = nTeamType or 0
    nBattleId = nBattleId or 0
    local enterMsg = {
        nTeamType,
        nBattleId
    }
    self.nTeamType = nTeamType
    self.nBattleId = nBattleId
    print("=====================================send c2s.TEAM_REQ_CREATE_TEAM")
    TFDirector:send(c2s.TEAM_REQ_CREATE_TEAM, {enterMsg,costItemId})
end
--//请求变更队伍状态（是否开启自动匹配队员）
function TeamFightDataMgr:requestChangeTeamStatus( nTeamStatus )            --@nTeamStatus 是否开启队伍自动匹配 1:off 2:on
    -- body

    TFDirector:send(c2s.TEAM_REQ_CHANGE_TEAM_STATUS, {nTeamStatus})
end

--//请求任命队长
function TeamFightDataMgr:requestAppointLeader( nTargetPid )            --@nTargetPid 将任命队长id
    -- body
    self.nTreatType = 1
    TFDirector:send(c2s.TEAM_REQ_TREAT_MEMBER, {nTargetPid,1})
end

--//请求踢出队员
function TeamFightDataMgr:requestKickOutTeam( nTargetPid )              --@nTargetPid 将踢出队员id
    -- body
    self.nTreatType = 2
    TFDirector:send(c2s.TEAM_REQ_TREAT_MEMBER, {nTargetPid,2})
end

--//个人请求匹配队伍
function TeamFightDataMgr:requestMatchTeam( nTeamType,nBattleId )       --@nTeamType 队伍类型 @nBattleId副本id
    -- body

    self:reset()
    nTeamType = nTeamType or 0
    nBattleId = nBattleId or 0
    local enterMsg = {
        nTeamType,
        nBattleId
    }
    self.nTeamType = nTeamType
    self.nBattleId = nBattleId
    TFDirector:send(c2s.TEAM_REQ_MATCH_TEAM, {enterMsg})
end

--//请求取消个人匹配
function TeamFightDataMgr:requestCancelMatchTeam()                      --@nullptr
    -- body

    TFDirector:send(c2s.TEAM_REQ_CANCEL_MATCH, {})
end

--//请求加入队伍
function TeamFightDataMgr:requestJoinTeam( nTeamId,nBattleId,nTeamType,joinType)                    --@nTeamId 将队伍id

    if self.strTeamId == "" then
        self:reset()
        self.nTeamType = nTeamType
        if self.nTeamType == 5 then --不满足条件不能加入队伍
            if not LeagueDataMgr:canEnterHunter() then
                return
            end
        end
        --判断副本开启时间,等级，消耗是否符合
        local targetBattleCfg = self:getTeamLevelCfg(nTeamType,nBattleId)
        local myLv = MainPlayer:getPlayerLv()
        local openInfo = {}
        if nTeamType == 2 then
            local dungeonInfo = TeamPveDataMgr:getTrainDungeonInfo(nBattleId)
            if not dungeonInfo then
                openInfo.isOpening = false
            end
            openInfo.isOpening = dungeonInfo.isOpen
        elseif nTeamType == 3 or nTeamType == 4 or nTeamType == 5  or nTeamType == 6 then
            self.nTeamType = nTeamType
            self.nBattleId = nBattleId
            if nTeamId == nil or nTeamId == "" then
                Utils:showTips(202015)
                return
            end
            TFDirector:send(c2s.TEAM_REQ_JOIN_TEAM, {nTeamId,joinType})
            return
        elseif nTeamType == 7 then
            openInfo.isOpening = true
            targetBattleCfg.fightCost = targetBattleCfg.cost
        else
            local openInfo = self.teamLevelsStat[nBattleId]
            if openInfo then
                openInfo.isOpening = (openInfo.stat == 1)
            else
                openInfo = self:getLevelOpenTimeDate({days = targetBattleCfg.openWeeks,opentime = targetBattleCfg.openTimes,timelong = targetBattleCfg.continuedTime})
            end
        end

        local costinfo = {}
        for k,v in pairs(targetBattleCfg.fightCost) do
            costinfo.id = k
            costinfo.num = v
        end
        costinfo.hasnum = GoodsDataMgr:getItemCount(costinfo.id)
        local maxPlvCheckok = true
        if targetBattleCfg.lvlLimit[2] and targetBattleCfg.lvlLimit[2] < TabDataMgr:getData("DiscreteData")[9002].data.pmaxlvl then
            if myLv > targetBattleCfg.lvlLimit[2] then
                maxPlvCheckok = false
            end
        end

        if costinfo.hasnum < costinfo.num then
            Utils:showError(2100101)
        elseif myLv < targetBattleCfg.lvlLimit[1] then
            Utils:showError(2100100)
        elseif openInfo.isOpening == false then
            Utils:showError(2100098)
        elseif maxPlvCheckok == false then

        else
            local checkExtId = TFAssetsManager:getCheckInfo(3,EC_ActivityFubenType.TEAM)
            TFAssetsManager:downloadAssetsOfFunc(checkExtId,function()
                self.nBattleId = nBattleId
                if nTeamId == nil or nTeamId == "" then
                    Utils:showTips(202015)
                    return
                end
                TFDirector:send(c2s.TEAM_REQ_JOIN_TEAM, {nTeamId,joinType})
            end,true)
            return
        end
    else
        Utils:showTips(240006)
    end                
        
end

--//请求退出队伍
function TeamFightDataMgr:requestExitTeam( ... )                        --@nullptr
    -- body

    TFDirector:send(c2s.TEAM_REQ_LEAVE_TEAM, {})
end

--//请求更换英雄
function TeamFightDataMgr:requestChangeHero( nHeroCid ,nLimitCid)                 --@nHeroCid 将切换英雄id
    -- body

    TFDirector:send(c2s.TEAM_REQ_CHANGE_HERO, {nHeroCid, nLimitCid})
end

--//请求准备or取消准备
function TeamFightDataMgr:requestMemberReady( nStatus )                 --@nStatus 设置自己状态 1:空闲 2:准备中
    -- body

    self.nTempStatus = nStatus
    TFDirector:send(c2s.TEAM_REQ_CHANGE_MEMBER_STATUS, {nStatus})
end

--//请求战斗开始前的数据
function TeamFightDataMgr:requestStartFightInfo()                       --@nullptr
    TFDirector:send(c2s.CHASM_REQ_CHASM_START_FIGHT, {})
end

--//请求复活
function TeamFightDataMgr:requestRevive()                               --@nullptr
    -- body

    TFDirector:send(c2s.CHASM_REQ_CHASM_FIGHT_REVIVE, {})
end

--//请求离开战斗
function TeamFightDataMgr:requestExitFight(hurtValue)                            --@nullptr
    --发送到战斗服
    LockStep.sendExitFight(hurtValue)
end

--战斗结束通知
function TeamFightDataMgr:requestChasmFight(data)
    dump(data)
    print("发送组队战斗结束")
    -- TFDirector:send(c2s.CHASM_REQ_CHASM_OVER_FIGHT, data)
    LockStep.sendEndFight(data)
end



---------------------------------------------------------------------OPEN VIEW
function TeamFightDataMgr:openTeamView()
    local isLayerInQueue,layer = AlertManager:isLayerInQueue("TeamFightTeamView")
    if isLayerInQueue == false then
        local teamlayer = require("lua.logic.teamFight.TeamFightTeamView"):new()
        AlertManager:addLayer(teamlayer)
        AlertManager:show()
    else
        AlertManager:closeAllBeforLayer(layer)
    end
end

function TeamFightDataMgr:openChangeHeroView(heros)
    -- body
    local layer = require("lua.logic.teamFight.TeamFightChangeHeroView"):new(heros)
    AlertManager:addLayer(layer)
    AlertManager:show()
end

---------------------------------------------------------------------DATA OPERAT
function TeamFightDataMgr:handleTeamFubenStat(data)
    if self.teamLevelsStat == nil then
        self.teamLevelsStat = {}
    end
    if data.chashs then
        for k,v in pairs(data.chashs) do
            -- dump(v)
            self.teamLevelsStat[v.id] = {
                    stat = v.status,
                    fightCount = v.fightCount,
                    buyCount = v.buyCount,
                    remainCount = v.remainCount,
                    massStat = v.isSpecial,
                    massSTime = v.awardStartTime,
                    massETime = v.awardEndTime,
                    finishOnce = v.finishOnce,
                }
        end
        EventMgr:dispatchEvent(EV_CHAT_UPDATE_TEAM_INVITE)
    else
        print("组队副本状态数据不全")
        dump(data)
    end
end

function TeamFightDataMgr:getOpenLevels()
    local levels = {}
    for i,v in ipairs(self.groupListCfg) do
        local tmGroupStat =  self:getGroupStatus(v.id)
        if tmGroupStat.open then
            local groupInfo = self.levelsGroup[v.id]
            for i,v in ipairs(groupInfo.levelList) do
                table.insert(levels, v)
            end 
        end
    end
    return levels
end

function TeamFightDataMgr:checkLevelPassOver(levelId)
    if self.teamLevelsStat and self.teamLevelsStat[levelId] then
        return self.teamLevelsStat[levelId].finishOnce
    end
    return false
end

function TeamFightDataMgr:getGroupStatus(groupId)
    if self.teamLevelsStat == nil then
        return nil
    end
    local groupInfo = self.levelsGroup[groupId]
    local isGroupOpen = false
    local playerLvMatch = true
    local minLv = -1
    local maxLv = minLv
    local tmAllLevelStat = self:getTeamLevelStat()
    for i,v in ipairs(groupInfo.levelList) do
        if isGroupOpen == false then
            local tmlevelStat = tmAllLevelStat[v]
            if tmlevelStat and tmlevelStat.stat == 1 then
                isGroupOpen = true
            end
        end
        local tmlevelCfg = self.levelsCfg[v]
        local tmLvLimit = tmlevelCfg.lvlLimit
        if minLv < 0 then
            minLv = tmLvLimit[1]
        end
        minLv = math.min(minLv,tmLvLimit[1])
        if tmLvLimit[2] then
            maxLv = math.max(maxLv,tmLvLimit[2])
        end
    end
    local playerLv = MainPlayer:getPlayerLv()
    if playerLv > self.maxPlayerLv then
        playerLvMatch = false
    else
        if playerLv < minLv then
            playerLvMatch = false
        end
        if maxLv > 0 and playerLv > maxLv then
            playerLvMatch = false
        end
    end
    return {open = isGroupOpen,lvok = playerLvMatch}
end

function TeamFightDataMgr:getBattleEndData()
    return self.battleEndData
end

--清理缓存的奖励数据 和 组队战斗结算数据
function TeamFightDataMgr:cleanCacheData()
    self.battleEndData = nil
    self.battleRewards = nil
end

function TeamFightDataMgr:updateTeamFubenStat(data)
    if self.teamLevelsStat == nil then
        self.teamLevelsStat = {}
    end
    if data.chasmInfo then
        local chashsdata = data.chasmInfo
        self.teamLevelsStat[chashsdata.id] = {
            stat = chashsdata.status,
            fightCount = chashsdata.fightCount,
            buyCount = chashsdata.buyCount,
            remainCount = chashsdata.remainCount,
            massStat = chashsdata.isSpecial,
            massSTime = chashsdata.awardStartTime,
            massETime = chashsdata.awardEndTime,
            finishOnce = chashsdata.finishOnce,
        }
    end
end

function TeamFightDataMgr:getTeamLevelStat()
    if self.teamLevelsStat == nil then
        self:requestTeamLevelStat()
    end
    return self.teamLevelsStat
end

function TeamFightDataMgr:isTeamFubenOpenning()
    local isOpen = false
    if self.teamLevelsStat then
        for k,v in pairs(self.teamLevelsStat) do
            if v.stat == 1 then
                isOpen = true
                break
            end
        end
    else
        local teamFubenCfg = TabDataMgr:getData("ChasmDungeon")
        for k,v in pairs(teamFubenCfg) do
            local openStat = self:getLevelOpenTimeDate({days = v.openWeeks,opentime = v.openTimes,timelong = v.continuedTime})
            if openStat.isOpening == true then
                isOpen = true
                break
            end
        end
    end
    return isOpen
end

function TeamFightDataMgr:getLevelOpenTimeDate(dateCfg)
    local date = TFDate(ServerDataMgr:getServerTime()):tolocal()
    local curweekday = date:getweekday()
    local openWeekdays = dateCfg.days
    local opentimes = dateCfg.opentime
    local timelong = dateCfg.timelong
    local year, month, day = date:getdate()
    local hour,min = date:gettime()

    table.sort(openWeekdays)
    table.sort(opentimes)
    local activetimes = {}
    for i=1,#opentimes do
        local tmstime = {hour = math.floor(opentimes[i]/60),min = opentimes[i]%60}
        local tmetime = {hour = math.floor((opentimes[i] +timelong)/60),min = (opentimes[i] +timelong)%60}
        activetimes[#activetimes + 1] = {st = tmstime,et = tmetime}
    end
    local begintimedate = {year = year,month = month,day = day,hour = 0,min = 0}
    local endtimedate = {year = year,month = month,day = day,hour = 0,min = 0}
    local isOpenNow = false
    for i=1,#openWeekdays do
        if curweekday == openWeekdays[i] then
            local curvalue = hour * 60 + min
            for j = 1,#activetimes do
                local svalue = activetimes[j].st.hour * 60 + activetimes[j].st.min
                local evalue = activetimes[j].et.hour * 60 + activetimes[j].et.min
                if curvalue >= svalue and curvalue < evalue then
                    begintimedate.hour = activetimes[j].st.hour
                    begintimedate.min = activetimes[j].st.min
                    endtimedate.hour = activetimes[j].et.hour
                    endtimedate.min = activetimes[j].et.min
                    isOpenNow = true
                    break
                end
            end
        end
    end

    if isOpenNow == false then
        local curvalue = hour * 60 + min
        local iscurday = false
        for i = 1,#activetimes do
            local svalue = activetimes[i].st.hour * 60 + activetimes[i].st.min
            if svalue > curvalue then
                begintimedate.year = year
                begintimedate.month = month
                begintimedate.day = day
                begintimedate.hour = activetimes[i].st.hour
                begintimedate.min = activetimes[i].st.min
                endtimedate.year = year
                endtimedate.month = month
                endtimedate.day = day
                endtimedate.hour = activetimes[i].et.hour
                endtimedate.min = activetimes[i].et.min
                iscurday = true
                break
            end
        end
        if iscurday == false then
            local adddays = 0
            for i = 1,#openWeekdays do
                if openWeekdays[i] > curweekday then
                    adddays = openWeekdays[i] - curweekday
                end
            end
            if adddays == 0 then
                adddays = 7-(curweekday -openWeekdays[1])
            end
            local baseDate = TFDate(year, month, day):toutc()
            local nextbeginDate = baseDate:adddays(adddays)
            local nyear,nmonth,nday = nextbeginDate:getdate()
            begintimedate.year = nyear
            begintimedate.month = nmonth
            begintimedate.day = nday
            begintimedate.hour = activetimes[1].st.hour
            begintimedate.min = activetimes[1].st.min
            endtimedate.year = nyear
            endtimedate.month = nmonth
            endtimedate.day = nday
            endtimedate.hour = activetimes[1].et.hour
            endtimedate.min = activetimes[1].et.min
        end
    end

    return {isOpening = isOpenNow,startdate = begintimedate,enddate = endtimedate}
end

function TeamFightDataMgr:installTeamInfo( data )
    self.strTeamId       = data.teamId  	or ""
    self.nTeamStatus     = data.status      or 0

    self.visibleType     = data.show_type   or 0
    self.minLv           = data.level_limit or 1

    local defaultValue   = true

    self.showInRoom = data.open == nil and defaultValue or data.open
    if self.nLeaderId ~= nil and self.nLeaderId ~= 0 and self.nLeaderId ~= data.leaderPid then
        if MainPlayer:getPlayerId() == data.leaderPid then
            Utils:showTips(2100095)
        end
    end
    self.nLeaderId       = data.leaderPid   or 0
    self.tTeamMemberInfo = data.members 	or {}
    for i=1,5 do
        if self.tTeamMemberInfo[i] and self.tTeamMemberInfo[i].pid == self.nLeaderId and i ~= 1 then
            local temp = self.tTeamMemberInfo[i]
            self.tTeamMemberInfo[i] = self.tTeamMemberInfo[1]
            self.tTeamMemberInfo[1] = temp
        end
    end
    print("event.data=========>>>>>>>>>>>" , data)
    print("self.strTeamId=========>>>>>>>>>>>" .. self.strTeamId)
    EventMgr:dispatchEvent(EV_TEAM_FIGHT_TEAM_DATA)
end

function TeamFightDataMgr:isAutoMatching( ... )
	return self.nTeamStatus == 2
end

--是否显示队友特效
function TeamFightDataMgr:isShowMemberEffect()
    return self.nTeamShowStatus
end

function TeamFightDataMgr:setShowMemberEffect(visible)
    self.nTeamShowStatus = visible
end

function TeamFightDataMgr:getMyStatus()
    return self.nTempStatus
end
function TeamFightDataMgr:getLeaderId( ... )
	return self.nLeaderId
end

function TeamFightDataMgr:getTeamId( ... )
	return self.strTeamId
end

function TeamFightDataMgr:getTeamInfo( ... )
    return self.tTeamMemberInfo or {}
end

function TeamFightDataMgr:getFightPower(pid)
    if self.tTeamMemberInfo then 
        for k,v in pairs(self.tTeamMemberInfo) do
            if v.pid == pid then
                return v.fightPower
            end
        end
    end
    return 888
end

function TeamFightDataMgr:getMemberInfo( nIndex )
    return self.tTeamMemberInfo[nIndex]
end

function TeamFightDataMgr:getBattleCfg()
    local battlecfg = self:getTeamLevelCfg(self.nTeamType, self.nBattleId)
    return battlecfg
end

function TeamFightDataMgr:getMySelHeroCid()
    for k,v in pairs(self.tTeamMemberInfo) do
        if v.pid == MainPlayer:getPlayerId() then
            return v.heroCid
        end
    end
end

function TeamFightDataMgr:getMySelHeroInfo()
    for k,v in pairs(self.tTeamMemberInfo) do
        if v.pid == MainPlayer:getPlayerId() then
            return v
        end
    end
end

function TeamFightDataMgr:checkIsHeroRepeatWithOther(cid)
    if self.nTeamType == 7 then
        return false
    end

    for k,v in pairs(self.tTeamMemberInfo) do
        if v.pid ~= MainPlayer:getPlayerId() and v.status == 2 and HeroDataMgr:getHeroRoleId(v.heroCid) == HeroDataMgr:getHeroRoleId(cid) then
            return true
        end
    end
    return false
end

function TeamFightDataMgr:openTeamGroupSelView(chapterId)
    self:requestTeamLevelStat()
    if FunctionDataMgr:isOpenByServer(2) then
        Utils:openView("teamFight.TeamLevelGroupSelView",chapterId)
        return true
    else
        Utils:showTips(2100112);
        return false
    end
end
---社交方面接口
function TeamFightDataMgr:getLastFriendInviteTime(pid)
    return self.inviteSendReport.friend[pid]
end

function TeamFightDataMgr:getLastPublicInviteTime()
    return self.inviteSendReport.public
end

function TeamFightDataMgr:getLastClubInviteTime()
    return self.inviteSendReport.club
end
--邀请好友
function TeamFightDataMgr:inviteFriend(friendid)
    local battlecfg = self:getBattleCfg()
    local curtime = ServerDataMgr:getServerTime()
    local content = {affixID = battlecfg.affixID,teamid = self.strTeamId,battlename = TextDataMgr:getTextAttr(battlecfg.levelName).text,levellimit = battlecfg.lvlLimit[1],battleid = self.nBattleId,sendtime = curtime,nTeamType = self.nTeamType}
    local contentStr = json.encode(content)
    local msg = {
        2,
        2,
        contentStr,
        friendid
    }
    TFDirector:send(c2s.CHAT_CHAT,msg)
    self.inviteSendReport.friend[friendid] = {lastSendTime = ServerDataMgr:getServerTime()}
    Utils:showTips(2100093)
end
--向公共频道发组队邀请
function TeamFightDataMgr:invitePublic()

    if MainPlayer:getPlayerId() ~= self:getLeaderId() then
        Utils:showTips(2100096)
        return
    end
    local battlecfg = self:getBattleCfg()
    local curtime = ServerDataMgr:getServerTime()
    local content = {affixID = battlecfg.affixID, teamid = self.strTeamId,battlename = TextDataMgr:getTextAttr(battlecfg.levelName).text,levellimit = battlecfg.lvlLimit[1],battleid = self.nBattleId,sendtime = curtime,nTeamType = self.nTeamType}
    local contentStr = json.encode(content)
    local msg = {
        1,
        2,
        contentStr,
        0
    }
    TFDirector:send(c2s.CHAT_CHAT,msg)
    self.inviteSendReport.public.lastSendTime = ServerDataMgr:getServerTime()
    Utils:showTips(2100093)
end

--向工会频道发组队邀请
function TeamFightDataMgr:inviteClub()
    --[[
    [1] = {--ChatMsg
        [1] = 'int32':channel   [   聊天类型:1.公共 2.私聊;3.帮派 4.系统 5.队伍]
        [2] = 'int32':fun   [   功能类型:1.聊天 2.深渊组队邀请]
        [3] = 'string':content  [  内容;]
        [4] = 'int32':playerId  [  私聊玩家编号]
    }
--]]
    -- --暂无此功能
    -- Utils:showTips(900049)
    -- return false
    if LeagueDataMgr:checkSelfInUnion() == false then
        Utils:showTips(270401)
        return false
    end

    local battlecfg = self:getBattleCfg()
    local curtime = ServerDataMgr:getServerTime()
    local content = {affixID = battlecfg.affixID,teamid = self.strTeamId,battlename = TextDataMgr:getTextAttr(battlecfg.levelName).text,levellimit = battlecfg.lvlLimit[1],battleid = self.nBattleId,sendtime = curtime,nTeamType = self.nTeamType}
    local contentStr = json.encode(content)
    local msg = {
        3,
        2,
        contentStr,
        0,
    }
    TFDirector:send(c2s.CHAT_CHAT,msg)
    self.inviteSendReport.club.lastSendTime = ServerDataMgr:getServerTime()
    Utils:showTips(2100093)
end

function TeamFightDataMgr:openInviteFriend()
    if MainPlayer:getPlayerId() ~= self:getLeaderId() then
        Utils:showTips(2100096)
        return
    end
    local friendlist = FriendDataMgr:getFriend(EC_Friend.FRIEND)
    local onlineFriendslist = {}
    if #friendlist > 0 then
        for k,v in pairs(friendlist) do
            local friendInfo = FriendDataMgr:getFriendInfo(v)
            if friendInfo.online then
                local isInTeam = false
                for key,va in pairs(self.tTeamMemberInfo) do
                    if friendInfo.pid == va.pid then
                        isInTeam = true
                        break
                    end
                end
                if isInTeam == false then
                    onlineFriendslist[#onlineFriendslist + 1] = friendInfo
                end
            end
        end
        if #onlineFriendslist > 0 then
            local layer = require("lua.logic.teamFight.TeamInviteFriendView"):new(onlineFriendslist)
            AlertManager:addLayer(layer)
            AlertManager:show()
        else
            --提示没有好友在线
            Utils:showTips(2100091)
        end
    else
        Utils:showTips(2100092)
    end

end


--------外部调用----------------
function TeamFightDataMgr:checkInviteMsg(msg,timestamp)
    local msgInfo = json.decode(msg)
    local livetime
    if timestamp == nil then
        if msgInfo.sendtime then
            timestamp = msgInfo.sendtime
        end
    end
    if timestamp then
        local curtime = ServerDataMgr:getServerTime()
        local timediff = curtime - timestamp
        local timeCD = Utils:getKVP(61001,"timelong")
        timeCD = math.floor(timeCD/1000)
        if timediff > timeCD then
			print("----------1")
            return false
        end
        livetime = timestamp + timeCD - curtime
    end
    local nTeamType = tonumber(msgInfo.nTeamType)
    if nTeamType == 2 then
       local dungeonInfo = TeamPveDataMgr:getTrainDungeonInfo(tonumber(msgInfo.battleid))
        if not dungeonInfo then
			print("----------2")
            return false
        end

        if not dungeonInfo.isOpen then
			print("----------3")
            return false
        end
    elseif nTeamType == 3 or nTeamType == 4 or nTeamType == 5 or nTeamType == 6 or nTeamType == 7 then
    else
        local levelsStat = self:getTeamLevelStat()
        if levelsStat then
            local tmLevelStat = levelsStat[tonumber(msgInfo.battleid)]
            if tmLevelStat == nil then
				print("----------4")
                return false
            end
            if tmLevelStat.stat ~= 1 then
				print("----------5")
                return false
            end
        end
    end

    local curPlayerPLv = MainPlayer:getPlayerLv()
    local limitLevel = tonumber(msgInfo.levellimit) or 0
    if curPlayerPLv < limitLevel then
		print("----------6")
        return false
    end

    
    return true,livetime
end


--------组队房间---------

function TeamFightDataMgr:getRoomTypeCfg()
    return self.roomTypeCfg
end

function TeamFightDataMgr:getTeamInfoByType(teamType)
    return self.teamRoom[teamType]
end

function TeamFightDataMgr:isShowInRoomList()
    return self.showInRoom
end

function TeamFightDataMgr:setShowInlistState(state)
    self.showInRoom = state
end


function TeamFightDataMgr:Send_getTeamRoomInfo(teamType)
    TFDirector:send(c2s.TEAM_REQ_ALL_TEAM_INFO, {teamType,0})
end

function TeamFightDataMgr:Send_showRoomList(isOpen)
    self.serverIsOpen = isOpen
    TFDirector:send(c2s.TEAM_REQ_SET_TEAM_SHOW_TYPE, {isOpen})
end

function TeamFightDataMgr:onRecvRoomInfo(event)

    local data = event.data
    if not data then
        return
    end
    -- dump(data)
    local teamType = data.teamType
    local teamInfo = data.teamInfo or {}
    local nextTime = data.nextTime

    if not self.teamRoom[teamType] then
        self.teamRoom[teamType] = {}
    end
    self.teamRoom[teamType].teamInfo = teamInfo
    self.teamRoom[teamType].nextTime = nextTime
    EventMgr:dispatchEvent(EV_UPDATE_ROOMLIST,teamType)
end

function TeamFightDataMgr:onRecvShowInRoomState(event)
    local data = event.data
    if not data then
        return
    end
    EventMgr:dispatchEvent(EV_TEAM_IS_SHOWINROOM)
end

function TeamFightDataMgr:onRecvMatchRank(event)	
	local data = event.data
	dump(data)
    if not data then
        return
    end

    EventMgr:dispatchEvent(EV_TEAM_MATCH_RANK, data)
end

return TeamFightDataMgr:new()
