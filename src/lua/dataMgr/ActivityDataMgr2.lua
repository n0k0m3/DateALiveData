
local json = require("LuaScript.extends.json")
local BaseDataMgr = import(".BaseDataMgr")
local ActivityDataMgr = class("ActivityDataMgr", BaseDataMgr)


ActivityDataMgr.extendUI = {
    ["NewCityMainLayer"] = { path = "lua.logic.activity.NewYearActivityExtendUI", activityType = EC_ActivityType2.NEWYEARDATING },
    ["NewCityRoomView"] = { path = "lua.logic.activity.NewYearActivityExtendUI", activityType = EC_ActivityType2.NEWYEARDATING, param = true},
    ["NewCityMainLayer"] = { path = "lua.logic.activity.YanhuaActivityExtendUI", activityType = EC_ActivityType2.YANHUA_COMPOSE},
}

ActivityDataMgr.checkRedPointFunc = {
    [113] = function ( ... )
        return FubenDataMgr:isVisiableSimulationTrialRedPoint( ... )
    end,
    [300] = function ( roomType )
        if roomType == WorldRoomType.ZNQ_WORLD then
            return ActivityDataMgr2:isBalloonTip() or TurnTabletMgr:isTurnTabletRedShow() or ActivityDataMgr2:isShowRedPointInMainView(7)
        end
    end,
}

function ActivityDataMgr:init()
    TFDirector:addProto(s2c.ACTIVITY_NEW_RESP_ACTIVITYS, self, self.onRecvActivitys)
    TFDirector:addProto(s2c.ACTIVITY_NEW_RESP_ACTIVITY_ITEMS, self, self.onRecvItems)
    TFDirector:addProto(s2c.ACTIVITY_NEW_RESP_ACTIVITY_PROGRESS, self, self.onRecvProgress)
    TFDirector:addProto(s2c.ACTIVITY_NEW_RESULT_SUBMIT_ACTIVITY, self, self.onRecvSubmitActivity)
    TFDirector:addProto(s2c.ACTIVITY_NEW_PUSH_ACTIVITYS, self, self.onRecvPushActivity)
    TFDirector:addProto(s2c.ACTIVITY_RESP_SUPPORT_ACTIVITY_SERVER_PROGRESS, self, self.onRecvAssistProgress)
    TFDirector:addProto(s2c.ACTIVITY_RESP_RANK, self, self.onRecvAssistRanking)
    TFDirector:addProto(s2c.ACTIVITY_RESP_RANK_ACTIVITY, self, self.onRecvActivityLessRank)
    TFDirector:addProto(s2c.ACTIVITY_RESP_ACTIVITY_RANK, self, self.onRecvActivityMoreRank)
    TFDirector:addProto(s2c.ACTIVITY_RESP_REFRESH_ENTRUST_ACTIVITY_TASK, self, self.onRecvRefreshEnrust)
    TFDirector:addProto(s2c.SPRING_FESTIVAL_RES_ARREST_NIAN_BEAST, self, self.onArrestNianBeastRsp) -- 抓捕年兽响应
    TFDirector:addProto(s2c.SPRING_FESTIVAL_RES_REFRESH_NIAN_BEAST, self, self.onRefreshNianBeastRsp) -- 刷新年兽响应
    TFDirector:addProto(s2c.SPRING_FESTIVAL_RES_USE_FIREWORKS, self, self.onUseFireWorkRsp) -- 使用烟花
    TFDirector:addProto(s2c.SPRING_FESTIVAL_RES_COMPOSE_FIRECRACKER, self, self.onComposeFireCrackerRsp) -- 合成爆竹
    TFDirector:addProto(s2c.SPRING_FESTIVAL_RES_SFCHANGE_STAGE, self, self.onActivityStageChange) -- 活动阶段变化
    TFDirector:addProto(s2c.SPRING_FESTIVAL_RES_SFREFRESH_COUNT, self, self.onSpringFestivalRefreshCount) -- 刷新次数变化
    TFDirector:addProto(s2c.SPRING_FESTIVAL_RES_SFCHANGE_SCORE, self, self.onSpringFestivalRefreshScore) --任务积分刷新
    TFDirector:addProto(s2c.SPRING_FESTIVAL_RES_REFRESH_SPRING_FESTIVAL_TASK, self, self.onSpringFestivalRefreshTask) --任务刷新返回    
    TFDirector:addProto(s2c.ACTIVITY_RESP_GET_WAR_ORDER_AWARD, self, self.onGetWarOrderAward)
    TFDirector:addProto(s2c.ACTIVITY_RESP_GET_WAR_ORDER_INFO, self, self.onGetWarOrderInfo)
    TFDirector:addProto(s2c.ACTIVITY_RESP_UWAR_ORDER_LEVEL, self, self.onUpWarOrderLevel)

    TFDirector:addProto(s2c.ACTIVITY_NEW_RESP_YEAR_ACTIVITY_CONFIG, self, self.onResqYearActivityCfg) --周年庆配置刷新
    TFDirector:addProto(s2c.ACTIVITY_NEW_RESQ_YEAR_ACTIVITY_MONTH_PROGRESS, self, self.onRecvProgress) --周年庆条目进度刷新
    TFDirector:addProto(s2c.ACTIVITY_NEW_RESQ_YEAR_ACTIVITY_MONTH_ITEMS, self, self.onRecvItems) --周年庆条目刷新
    TFDirector:addProto(s2c.ACTIVITY_RESP_COMPLETED_EVENT, self, self.onRecvSubmitActivity) --周年庆领取返回刷新
    TFDirector:addProto(s2c.ACTIVITY_RESP_ACTIVITY_INNER_DATA, self, self.onRecvActivityInnerData) --周年庆领取返回刷新
    TFDirector:addProto(s2c.ACTIVITY_RESP_CORSS_RANK_ACTIVITY, self, self.onRecvAssistRanking)
    TFDirector:addProto(s2c.ACTIVITY_RESP_UPDATE_SUPPORT_ADDRESS, self, self.onRecvChangeAddress)
    TFDirector:addProto(s2c.ACTIVITY_RESP_SUPPORT_ADDRESS, self, self.onRecvAssistAddressInfo)
    TFDirector:addProto(s2c.ACTIVITY_RESP_ALL_ACTIVITY_ITEM, self, self.onRecvOverServerScore)
    TFDirector:addProto(s2c.ACTIVITY_RESP_KURUMI_HISTORY_INFO, self, self.onRecvKuangsanHistoryInfo)
    TFDirector:addProto(s2c.ACTIVITY_RESP_KURUMI_HISTORY_RANK, self, self.onRecvKuangsanHistoryRank)
    TFDirector:addProto(s2c.ACTIVITY_RESP_KURUMI_CITY_RESOURCE, self, self.onRecvKuangsanCityResource)
    TFDirector:addProto(s2c.ACTIVITY_RESP_KURUMI_CITY_REFRESH, self, self.onRecvKuangsanCityRefresh)
    TFDirector:addProto(s2c.ACTIVITY_RESP_KURUMI_CAMP, self, self.onRecvKuangsanCampRsp)

    TFDirector:addProto(s2c.CHRISTMAS_RESP2019_CHRISTMAS_DUNGEON, self, self.onRecvChristmasDungeonInfo)
    TFDirector:addProto(s2c.CHRISTMAS_RESP2019_CHRISTMAS_FACTORY, self, self.onRecvChristmasFactoryInfo)
    TFDirector:addProto(s2c.CHRISTMAS_RESP2019_CHRISTMAS_TALENT, self, self.onRecvChristmasTalentRsp)
    TFDirector:addProto(s2c.CHRISTMAS_RESP2019_CHRISTMAS_REFRESH, self, self.onRecvChristmasRefreshRsp)
    TFDirector:addProto(s2c.CHRISTMAS_RESP2019_CHRISTMAS_PRODUCT, self, self.onRecvChristmasProductRsp)

    TFDirector:addProto(s2c.ACTIVITY_RESP_GET_HANG_UP_INFO, self, self.onRecvHangUpInfo)
    TFDirector:addProto(s2c.ACTIVITY_RESP_UP_HANG_UP_ROLE_LEVEL, self, self.onRecvHangUpRoleLevelUpRsp)
    TFDirector:addProto(s2c.ACTIVITY_RESP_GET_HANG_UP_AWARD, self, self.onRecvGetHangUpRewardRsp)
    TFDirector:addProto(s2c.ACTIVITY_RESP_GET_HANG_UP_SEVENT_AWARD, self, self.onRecvGetHangUpSEventAwardRsp)
    TFDirector:addProto(s2c.ACTIVITY_RESP_SEND_EVENT_INFO, self, self.onRecvSendEventInfo)
    TFDirector:addProto(s2c.ACTIVITY_RESP_SEND_SPECIAL_EVENT_AWARD, self, self.onRecvSendSpecialEventAward)
    TFDirector:addProto(s2c.ACTIVITY_RESP_SEND_HANG_UP_ROLE_INFO, self, self.onRecvSendHangUpRoleInfo)
    TFDirector:addProto(s2c.ACTIVITY_RESP_UP_OR_DOWN_HANG_UP_ROLE, self, self.onRecvUpOrDownHangUpRoleRsp)
    TFDirector:addProto(s2c.SPRING_FESTIVAL_RESP_FESTIVAL2020_INFO, self, self.onRespFestival2020Info)
    TFDirector:addProto(s2c.SPRING_FESTIVAL_RESP_FESTIVAL2020_RESOURCE, self, self.onRespFestival2020Resource)
    TFDirector:addProto(s2c.SPRING_FESTIVAL_RESP_FESTIVAL2020_CITY_REFRESH, self, self.onRespFestival2020CityRefresh)
    TFDirector:addProto(s2c.SPRING_FESTIVAL_RESP_FESTIVAL2020_FINISH, self, self.onRespFestival2020Finish)
    TFDirector:addProto(s2c.SPRING_FESTIVAL_RESP_FESTIVAL2020_GAME_INIT, self, self.onRespFestival2020GameInit)

    TFDirector:addProto(s2c.ACTIVITY_RESP_GET_BE_CALL_INFO, self, self.onRespCallBackInfo)
    TFDirector:addProto(s2c.ACTIVITY_RES_DRAW_COMPASS, self, self.onRecvDrawComPass)
    TFDirector:addProto(s2c.ACTIVITY_RESP_SHARE_COMPLETE, self, self.onRespShareComplete)
    TFDirector:addProto(s2c.ACTIVITY_RESP_WRITE_BE_CALL_PLAYER_ID, self, self.onRespSubmitUid)
    TFDirector:addProto(s2c.ACTIVITY_RESP_ACTIVITY_ITEM_REFRESH,self,self.onActivityItemRefreshRsp)


	--团购礼包
	TFDirector:addProto(s2c.RECHARGE_RES_GROUP_TEAM_INFO,self,self.onCreateGroupPurchase)
	TFDirector:addProto(s2c.RECHARGE_RES_JOIN_GROUP_TEAM,self,self.onJoinGroupPurchase)
	TFDirector:addProto(s2c.RECHARGE_RES_REFRESH_GROUP_TEAM_LIST,self,self.onRefreshGroupPurchase)
	TFDirector:addProto(s2c.RECHARGE_RES_RECEIVE_GROUP_GIFT,self,self.onRecieveGroupPurchase)
	TFDirector:addProto(s2c.RECHARGE_RES_EXIT_GROUP_TEAM,self,self.onCancelGroupPurchase)
	TFDirector:addProto(s2c.RECHARGE_RES_MY_GROUP_TEAM,self,self.onGetMyGroupPurchaseData)
	TFDirector:addProto(s2c.RECHARGE_RES_GROUP_GIFT_INFO,self,self.onQueryGiftStatus)
	TFDirector:addProto(s2c.RECHARGE_RES_REFRESH_GROUP_TEAM,self,self.onOtherJoin)
	TFDirector:addProto(s2c.RECHARGE_RES_DISSOLVE_GROUP_TEAM,self,self.onDissolution)
	TFDirector:addProto(s2c.RECHARGE_RES_SHOW_GROUP_TEAM,self,self.onShowGroupInHall)

	--劳动节活动
	TFDirector:addProto(s2c.ACTIVITY_RESP_UNION_LABOUR_SCORE,self,self.onLobarDayScore)
	TFDirector:addProto(s2c.ACTIVITY_RESP_UNION_LABOUR_RANK,self,self.onLobarDayRank)
	TFDirector:addProto(s2c.ACTIVITY_RESP_UNION_LABOUR_CONVERT,self,self.onPhyscalConvert)

	--时之契约
	TFDirector:addProto(s2c.ACTIVITY_RESP_TIME_CONTRACT,self,self.onSZQYData)
	TFDirector:addProto(s2c.ACTIVITY_RESP_DICE_CONTRACT,self,self.onSZQYStep)
	TFDirector:addProto(s2c.ACTIVITY_RESP_REFRESH_CONTRACT,self,self.onResetSZQY)

	--花嫁活动
	TFDirector:addProto(s2c.ACTIVITY_RESP_VOTE_ACTIVITY,self,self.onDressVoteSucess)
	TFDirector:addProto(s2c.ACTIVITY_RESP_VOTE_ACTIVITY_INFO,self,self.onDressVoteInfo)

    TFDirector:addProto(s2c.ANNIVERSARY2ND_RES_ANNIV_DRESS,self,self.onRecvAnnivDress)
    TFDirector:addProto(s2c.ANNIVERSARY2ND_RES_REFRESH_ANNIV_DRESS,self,self.onRecvFreshAnnivDress)

    --周年庆放飞气球活动
    TFDirector:addProto(s2c.ACTIVITY_FLY_BALLOON_SUCC, self, self.onFlyBalloonSucc)
    TFDirector:addProto(s2c.ACTIVITY_RES_EXCHANGE_APPLY, self, self.onResExchangeApply)
    TFDirector:addProto(s2c.ACTIVITY_EXCHANGE_BALLOON_NOTIFY, self, self.onExchangeBalloonNotify)
    TFDirector:addProto(s2c.ACTIVITY_RES_DEAL_FRIEND_EXCHANGE_APPLY, self, self.onResDealFriendExchangeApply)
    TFDirector:addProto(s2c.ACTIVITY_OPEN_EXCHANGE_PANEL, self, self.onOpenExchangePanel)
    TFDirector:addProto(s2c.ACTIVITY_UPDATE_SELECT_BALLOON_ID, self, self.onUpdateSelectBalloonId)
    TFDirector:addProto(s2c.ACTIVITY_CONFIRM_TRADE, self, self.onConfirmTrade)
    TFDirector:addProto(s2c.ACTIVITY_BALLOON_EXCHANGE_RESULT, self, self.onBalloonExchangeResult)

    TFDirector:addProto(s2c.ACTIVITY_RESP_HALLOWEEN_PASS, self, self.onHalloweenPassRsp)

    ---万圣节小鬼
    TFDirector:addProto(s2c.PLAYER_RESP_PHANTOM_INFO,self,self.onRespGhostInfo)
    TFDirector:addProto(s2c.PLAYER_RESP_PHANTOM_GIFT,self,self.onRespGift)
    TFDirector:addProto(s2c.ACTIVITY_RES_DONATE_ACTIVITY,self,self.OnResDonateActivity)

    --英文版白王应援社团排行
    TFDirector:addProto(s2c.ACTIVITY_RES_UNION_RANK_ACT_SCORE,self,self.OnActivityUnionRankActScore)
    TFDirector:addProto(s2c.ACTIVITY_RES_ACTIVITY_UNION_ITEM,self,self.OnActivityUnionItem)



    self.activityInfo_ = {}
    self.activityInfoMap_ = {}
    self.itemInfoMap_ = {}
    self.progressInfoMap_ = {}
    self.activityCfgDataMap_ = {}
    self.assistActivitys_ = {9990, 9991, 9992, 9993, 9994, 9995}
    self.warOrderInfo_ = nil
    self.cdTime = 60
    self.nextTime = 0
	self:initGPVariable()
end

function ActivityDataMgr:reset()
    self.activityInfo_ = {}
    self.activityInfoMap_ = {}
    self.itemInfoMap_ = {}
    self.progressInfoMap_ = {}
    self.warOrderInfo_ = nil
    self.activityCfgDataMap_ = {}
    self.saveStr = nil
    self.newYearFubenInfo = nil
    self.callbackInfo = nil
    self.halloweenPass = nil
end

function ActivityDataMgr:onLogin()
    self:reset();
    TFDirector:send(c2s.ACTIVITY_NEW_REQ_ACTIVITYS, {})
    TFDirector:send(c2s.ACTIVITY_NEW_REQ_ACTIVITY_ITEMS, {})
    TFDirector:send(c2s.ACTIVITY_NEW_REQ_ACTIVITY_PROGRESS, {})
    TFDirector:send(c2s.ACTIVITY_REQ_GET_WAR_ORDER_INFO, {})
    TFDirector:send(c2s.ACTIVITY_NEW_REQ_YEAR_ACTIVITY_CONFIG, {})

    self:Send_getGhostInfo()
    -- TFDirector:send(c2s.ACTIVITY_NEW_REQ_YEAR_ACTIVITY_CONFIG, {})
    return {s2c.ACTIVITY_NEW_RESP_ACTIVITYS, s2c.ACTIVITY_NEW_RESP_ACTIVITY_ITEMS, s2c.ACTIVITY_NEW_RESP_ACTIVITY_PROGRESS}
end

function ActivityDataMgr:onLoginOut()
end

function ActivityDataMgr:onEnterMain()
    self.fiilInfo = {}
end

function ActivityDataMgr:updateActivtyOrder()
    table.sort(self.activityInfo_, function(a, b)
                   return a.rank < b.rank
    end)
    for i, v in ipairs(self.activityInfo_) do
        self.activityInfoMap_[v.id] = i
    end
end

function ActivityDataMgr:getTimeString( id )
    -- body
    local activityInfo = self:getActivityInfo(id)
    local startDate = Utils:getLocalDate(activityInfo.startTime)
    local startDateStr = startDate:fmt("%Y.%m.%d")
    local endDate = Utils:getLocalDate(activityInfo.endTime)
    local endDateStr = endDate:fmt("%Y.%m.%d")
    local timeString = TextDataMgr:getText(800041, startDateStr, endDateStr)

    if activityInfo.activityType == EC_ActivityType2.ZNQ_HG then
        startDateStr = startDate:fmt("%m.%d")
        endDateStr = endDate:fmt("%m.%d")
        timeString = string.format("%s - %s",startDateStr,endDateStr)
    end

    return timeString
end

function ActivityDataMgr:getActivityInfo(id, activityShowType)
    if id then
        local index = self.activityInfoMap_[id]
        return self.activityInfo_[index]
    else
        local excludeType = {
            --EC_ActivityType2.ASSIST,
            --EC_ActivityType2.HALLOWEEN,
            EC_ActivityType2.NEWPLAYER,
            EC_ActivityType2.DOUBLE_CARD,
            EC_ActivityType2.BACKPLAYER,
            EC_ActivityType2.BACKACTIVITY,
            EC_ActivityType2.CHRISTMAS,
            EC_ActivityType2.CHRISTMAS_SIGN,
            EC_ActivityType2.DUANWU_2,
            EC_ActivityType2.TRAINING,
            --EC_ActivityType2.ONLINE_SCORE_REWARD,   --在线积分活动
            EC_ActivityType2.NEWGIFT_PACK_EN,   --新手礼包不显示在活动界面
        }
        local activitys = {}
        for i, v in ipairs(self.activityInfo_) do
            if not v.extendData or (type(v.extendData) == "table" and not v.extendData.isHide) then
                local index = table.indexOf(self.assistActivitys_, v.id)
                
                local excludeIndex = table.indexOf(excludeType, v.activityType)
                if excludeIndex == -1 and index == -1 then
                    if v.extendData.activityShowType == activityShowType then -- 必须判断活动显示类型
                        table.insert(activitys, v)
                    end
                end
            end
        end

        table.sort(activitys, function(a,b)
            return a.rank < b.rank
        end)
        return activitys
    end
end

function ActivityDataMgr:getBackPlayerActivityInfo(id)
    if id then
        local index = self.activityInfoMap_[id]
        return self.activityInfo_[index]
    else
        local excludeType = {
            EC_ActivityType2.BACKPLAYER,
            EC_ActivityType2.BACKACTIVITY,
        }
        local activitys = {}
        for i, v in ipairs(self.activityInfo_) do
            local excludeIndex = table.indexOf(excludeType, v.activityType)
            if excludeIndex ~= -1 then
                table.insert(activitys, v)
            end
        end
        return activitys
    end
end



function ActivityDataMgr:getActivityInfoByType(activityType)
    local activityInfo = {}
    for i, v in ipairs(self.activityInfo_) do
        if v.activityType == activityType then
            table.insert(activityInfo, v.id)
        end
    end
    return activityInfo
end

function ActivityDataMgr:getProgressInfo(type_, id)
    local defaultProcess = {status = EC_TaskStatus.ING, progress = 0,extend = {}}
    if self.progressInfoMap_ and self.progressInfoMap_[type_] then
        return self.progressInfoMap_[type_][id] or defaultProcess
    end
    return defaultProcess
end

function ActivityDataMgr:getItems(id)
    local index = self.activityInfoMap_[id]
    local activityInfo = self.activityInfo_[index]
    local items = {}
    
    if activityInfo then
		activityInfo.items = activityInfo.items or {}
		
        local haveItems = {}
        for i, v in ipairs(activityInfo.items) do
            local info = self:getItemInfo(activityInfo.activityType, v)
            if info then
                table.insert(haveItems, v)
            end
        end

        table.sort(haveItems, function(a, b)
                       local infoA = self:getItemInfo(activityInfo.activityType, a)
                       local infoB = self:getItemInfo(activityInfo.activityType, b)

                       local rankA = 0
                       if infoA then
                            rankA = infoA.rank or 0
                       end

                       local rankB = 0
                       if infoB then
                            rankB = infoB.rank or 0
                       end

                       return rankA < rankB
        end)

        if activityInfo.activityType ==EC_ActivityType2.TASK or
            activityInfo.activityType ==EC_ActivityType2.BACKPLAYER or
            activityInfo.activityType ==EC_ActivityType2.BACKACTIVITY or
            activityInfo.activityType ==EC_ActivityType2.CHRISTMAS or
            activityInfo.activityType ==EC_ActivityType2.DAFUWENG or
            activityInfo.activityType ==EC_ActivityType2.DFW_SUMMER or
            activityInfo.activityType ==EC_ActivityType2.VALENTINE or
            activityInfo.activityType ==EC_ActivityType2.VALENTINE or
            activityInfo.activityType ==EC_ActivityType2.FUND or
            activityInfo.activityType ==EC_ActivityType2.TRAINING or
            activityInfo.activityType ==EC_ActivityType2.NEW_BACKACTIVITY 
             then
            local getData = {}
            local ingData = {}
            local getedData = {}
            for i, v in ipairs(haveItems) do
                local progressInfo = self:getProgressInfo(activityInfo.activityType, v)
                if progressInfo.status == EC_TaskStatus.GET then
                    table.insert(getData, v)
                elseif progressInfo.status == EC_TaskStatus.GETED then
                    table.insert(getedData, v)
                elseif progressInfo.status == EC_TaskStatus.ING then
                    table.insert(ingData, v)
                end
            end
            table.insertTo(items, getData)
            table.insertTo(items, ingData)
            table.insertTo(items, getedData)
        else
            items = haveItems
        end
    end
    return items
end

function ActivityDataMgr:getAgoraTaskActivityInfo()
    local activitys = {}
    for i,v in ipairs(self.activityInfo_) do
        if v.activityType == EC_ActivityType2.CHRISTMAS then
            table.insert(activitys, v)
        end
    end
    return activitys
end

function ActivityDataMgr:getAssistActivityInfo()
    local activitys = {}
    for i,v in ipairs(self.activityInfo_) do
        local index = table.indexOf(self.assistActivitys_, v.id)
        if v.activityType == EC_ActivityType2.ASSIST or index ~= -1 then
            table.insert(activitys, v)
        end
    end
    return activitys
end

function ActivityDataMgr:getNewPlayerActivityInfo(newOrBack)
    local playerType
    if newOrBack then
        playerType = EC_ActivityType2.NEWPLAYER
    else
        playerType = EC_ActivityType2.BACKACTIVITY
    end

    local activitys = {}
    for i,v in ipairs(self.activityInfo_) do
        if v.activityType == playerType then
            table.insert(activitys, v)
        end
    end
    return activitys
end



function ActivityDataMgr:getAssistItemInfos(id, subType)
    local index = self.activityInfoMap_[id]
    local activityInfo = self.activityInfo_[index]
    local itemInfos = {}
    local items = {}
    for i, v in ipairs(activityInfo.items) do
        local info = self:getItemInfo(activityInfo.activityType, v)
        if info and info.extendData.subType == subType then
            table.insert(itemInfos, info)
        end
    end
    if subType == EC_Activity_Assist_Subtype.CG_UNLOCK then
        items = clone(itemInfos)
    else
        local getData = {}
        local ingData = {}
        local getedData = {}
        for i, v in ipairs(itemInfos) do
            local progressInfo = self:getProgressInfo(activityInfo.activityType, v.id)
            if progressInfo.status == EC_TaskStatus.GET then
                table.insert(getData, v)
            elseif progressInfo.status == EC_TaskStatus.GETED then
                table.insert(getedData, v)
            elseif progressInfo.status == EC_TaskStatus.ING then
                table.insert(ingData, v)
            end
        end
        table.insertTo(items, getData)
        table.insertTo(items, ingData)
        table.insertTo(items, getedData)
    end

    return items
end

function ActivityDataMgr:getAssistCgUnlockNum(id, subType)
    local itemInfos = self:getAssistItemInfos(id, subType)
    local index = self.activityInfoMap_[id]
    local activityInfo = self.activityInfo_[index]
    local num = 0
    for k,v in pairs(itemInfos) do
        local progressInfo = ActivityDataMgr2:getProgressInfo(activityInfo.activityType, v.id)
        if progressInfo.status ~= EC_Assist_Item_Status.ING then
            num = num + 1
        end
    end
    return num
end

function ActivityDataMgr:getCgRankIndex(id, target)
    local rank = 1
    local itemInfos = self:getAssistItemInfos(id, EC_Activity_Assist_Subtype.CG_LIST)
    for k,v in pairs(itemInfos) do
        if v.target == target then
            rank = v.rank
            return rank
        end
    end
    return rank
end

function ActivityDataMgr:getAssistProgressData()
    return self.assistProgressData_
end

function ActivityDataMgr:getItemInfo(type_, id)
    if not self.itemInfoMap_[type_] then
        return nil
    end
    return self.itemInfoMap_[type_][id]
end

function ActivityDataMgr:getProgress(type_, id)
    local progress = 0
    local progressInfo = self:getProgressInfo(type_, id)
    if progressInfo then
        progress = progressInfo.progress or 0
    end
    return progress
end

function ActivityDataMgr:getRemainBuyCount(type_, id)
    local itemInfo = self:getItemInfo(type_, id)
    local extendData = itemInfo.extendData
    local progressInfo = self:getProgressInfo(type_, id)
    local limitType = extendData.limitType
    local limitVal = extendData.limitVal
    local serverLimitVal = extendData.serLimit
    if limitType == EC_ActivityStoreType.DAY then
        local nowBuyCount = self:getProgress(type_, id)
        local remainCount = math.max(0, limitVal - nowBuyCount)
        local isCanBuy = remainCount > 0
        return isCanBuy, remainCount
    elseif limitType == EC_ActivityStoreType.TOTAL then
        local nowBuyCount = self:getProgress(type_, id)
        local remainCount = math.max(0, limitVal - nowBuyCount)
        local isCanBuy = remainCount > 0
        return isCanBuy, remainCount
    elseif limitType == EC_ActivityStoreType.WHOLESERVER_DAY then
        local nowBuyCount = self:getProgress(type_, id)
        local wholeServerBuyCount = progressInfo.extend.productNum or 0
        local wholeServerRemainCount = math.max(0, serverLimitVal - wholeServerBuyCount)
        local remainCount = math.max(0, limitVal - nowBuyCount)
        local isCanBuy = remainCount > 0 and wholeServerRemainCount > 0
        return isCanBuy, wholeServerRemainCount
    elseif limitType == EC_ActivityStoreType.WHOLESERVER then
        local nowBuyCount = self:getProgress(type_, id)
        local wholeServerBuyCount = progressInfo.extend.productNum or 0
        local wholeServerRemainCount = math.max(0, serverLimitVal - wholeServerBuyCount)
        local remainCount = math.max(0, limitVal - nowBuyCount)
        local isCanBuy = remainCount > 0 and wholeServerRemainCount > 0
        return isCanBuy, wholeServerRemainCount
    else
        return true
    end
end

function ActivityDataMgr:getMaxBuyCount(type_, itemId)
    local itemInfo = self:getItemInfo(type_, itemId)
    local buyCount = INT_MAXVALUE
    for k, v in pairs(itemInfo.target) do
        local haveNum = GoodsDataMgr:getItemCount(k)
        local count = math.floor(haveNum / v)
        if buyCount then
            buyCount = math.min(buyCount, count)
        else
            buyCount = count
        end
    end
    return buyCount
end

function ActivityDataMgr:currencyIsEnough(type_, itemId, count)
    count = count or 1
    local itemInfo = self:getItemInfo(type_, itemId)
    local isEnough = true
    for k, v in pairs(itemInfo.target) do
        if not GoodsDataMgr:currencyIsEnough(k, v * count) then
            isEnough = false
            break
        end
    end
    return isEnough

end

-- 是否开始指定活动类型
function ActivityDataMgr:isOpen(activityType)
    local isOpen = false
    for i, v in ipairs(self.activityInfo_) do
        if v.activityType == activityType then
            local isEnd = self:isEnd(v.id)
            isOpen = not isEnd
            break
        end
    end
    return isOpen
end

function ActivityDataMgr:isEnd(activitId)
    local activityInfo = self:getActivityInfo(activitId)
    local isEnd = true
    if activityInfo then
        local serverTime = ServerDataMgr:getServerTime()
        isEnd = serverTime > activityInfo.endTime
    end
    return isEnd
end

function ActivityDataMgr:isShowEnd(activitId)
    local activityInfo = self:getActivityInfo(activitId)
    local isShowEnd = true
    if activityInfo then
        local serverTime = ServerDataMgr:getServerTime()
        isShowEnd = serverTime > activityInfo.showEndTime
    end
    return isShowEnd
end

function ActivityDataMgr:isInShowTime(activitId)
    local activityInfo = self:getActivityInfo(activitId)
    local serverTime = ServerDataMgr:getServerTime()
    local rets = false
    if activityInfo and activityInfo.showStartTime and serverTime < activityInfo.showEndTime then
        rets = serverTime >= activityInfo.showStartTime and serverTime < activityInfo.showEndTime
    end
    return rets
end

function ActivityDataMgr:isInOpenTime(activitId)
    local activityInfo = self:getActivityInfo(activitId)
    local serverTime = ServerDataMgr:getServerTime()
    local rets = false
    if activityInfo and activityInfo.startTime and serverTime < activityInfo.endTime then
        rets = serverTime >= activityInfo.startTime and serverTime < activityInfo.endTime
    end
    return rets
end

function ActivityDataMgr:isInOpenTimeByType(activityType)

    local isOpen = false
    for i, v in ipairs(self.activityInfo_) do
        if v.activityType == activityType then
            isOpen = self:isInOpenTime(v.id)
            break
        end
    end
    return isOpen
end

function ActivityDataMgr:isShowRoleHeadRedPoint(activitId,roleId)
    local activityInfo = self:getActivityInfo(activitId)
    local isShow = false
    if activityInfo.extendData.taskMap then
        local v = activityInfo.extendData.taskMap[tostring(roleId)]
        for _k,_v in pairs(v) do
            local progressInfo = self:getProgressInfo(activityInfo.activityType, _v)
            if progressInfo and progressInfo.status == EC_TaskStatus.GET then
                isShow = true
                break
            end
        end
    end
    return isShow
end

function ActivityDataMgr:isShowScoreRedPoint(activitId)
    local activityInfo = self:getActivityInfo(activitId)
    local isShow = false
    if activityInfo.extendData.scoreTaskList then
        local scoreList = activityInfo.scoreList or json.decode(activityInfo.extendData.scoreTaskList)
        for _k,_v in pairs(scoreList) do
            local progressInfo = self:getProgressInfo(activityInfo.activityType, _v.id)
            if progressInfo and progressInfo.status == EC_TaskStatus.GET then
                isShow = true
                break
            end
        end
    end
    return isShow
end

function ActivityDataMgr:isCanGet(activityId)
    local activityInfo = self:getActivityInfo(activityId)
    local items = self:getItems(activityId)
    local isShow = false
    for _, itemId in ipairs(items) do
        local progressInfo = self:getProgressInfo(activityInfo.activityType, itemId)
        local itemInfo = self:getItemInfo(activityInfo.activityType, itemId)
        if itemInfo.subType == 1010 and not next(itemInfo.reward) then  --TODO CLOSE 英文版特定活动条目不做红点判断
        else
            if progressInfo and progressInfo.status == EC_TaskStatus.GET then
                isShow = true
                break
            end
        end


        
    end
    return isShow
end

function ActivityDataMgr:isShowRedPoint(activityId)
    local isOpen = FunctionDataMgr:isOpen(6)
    local activityInfo = self:getActivityInfo(activityId)
    if not activityInfo then
        return false
    end
    local isShow = false
    if isOpen then
        if activityInfo.activityType == EC_ActivityType2.NEWYEARDATING then
            for k,v in pairs(activityInfo.extendData.taskMap) do
                isShow = self:isShowRoleHeadRedPoint(activityInfo.id,k)
                if isShow then break end
            end

            if not isShow then
                isShow = self:isShowScoreRedPoint(activityInfo.id)
            end

            if not isShow then
                if activityInfo.extendData.taskRefreshTime <= ServerDataMgr:getServerTime() then
                    isShow = true
                end
            end
        elseif activityInfo.activityType == EC_ActivityType2.DUANWU_1 then
            isShow = self:isCanGet(activityId)

            local activity = self:getActivityInfoByType(EC_ActivityType2.DUANWU_2)
            if #activity > 0 then
                isShow = isShow or self:isCanGet(activity[1])
            end
        elseif activityInfo.activityType == EC_ActivityType2.BINGOGAME then
            isShow = self:isCanGet(activityId)

            local activity = self:getActivityInfoByType(EC_ActivityType2.BINGOGAME)
            if #activity > 0 then
                isShow = isShow or self:isCanGet(activity[1])
            end
        elseif activityInfo.activityType == EC_ActivityType2.FUND then
            isShow = self:isCanGet(activityId)
            local activity = self:getActivityInfoByType(EC_ActivityType2.FUND)
            if #activity > 0 then
                isShow = isShow or self:isCanGet(activity[1])
            end
		elseif activityInfo.activityType == EC_ActivityType2.LOBARDAY_2020 then
			local items = activityInfo.items or {}
			for k,v in pairs (items) do
				local progress = self:getProgressInfo(activityInfo.activityType, v)
				if progress.status == EC_TaskStatus.GET then
					isShow = true
					break;
				end
			end
        elseif activityInfo.activityType == EC_ActivityType2.CHRONO_CROSS then
            isShow = self:isCanGet(activityId)
            local activity = self:getActivityInfoByType(EC_ActivityType2.CHRONO_CROSS)
            if #activity > 0 then
                isShow = isShow or self:isCanGet(activity[1])
            end
        elseif activityInfo.activityType == EC_ActivityType2.WELFARE_JUMP then
            if activityInfo.extendData.jumpInterface then
                local arg = activityInfo.extendData.jumpParamters or {}
                return self:getRedPointStatus(activityInfo.extendData.jumpInterface, unpack(arg))
            end
        elseif activityInfo.activityType == EC_ActivityType2.ONEYEAR_CELEBRATION then
            isShow = OneYearDataMgr:isCelebrationRedShow()
        elseif activityInfo.activityType == EC_ActivityType2.WELFARE_TASK then
            for k,v in pairs(activityInfo.extendData.content) do
                local taskList_ = v.task
                local activeTask_ = v.huoyue
                    
                for k,v in pairs(taskList_) do
                    for _k,_v in ipairs(v) do
                        local progressInfo= self:getProgressInfo(activityInfo.activityType, _v)
                        if progressInfo.status == EC_TaskStatus.GET then
                            return true
                        elseif progressInfo.status == EC_TaskStatus.ING then -- 同一组任务前面有未完成任务直接判定这组所有任务都未完成
                             break;
                        end
                    end
                end

                for k,v in pairs(activeTask_) do
                    local progressInfo= self:getProgressInfo(activityInfo.activityType, v)
                    if progressInfo.status == EC_TaskStatus.GET then
                        return true
                    end
                end
            end
        elseif activityInfo.activityType == EC_ActivityType2.HALLOWEEN then
            return false
        elseif activityInfo.activityType == EC_ActivityType2.CHRISTMAS_PRE then
            local sellTime = activityInfo.extendData.sellTime/1000
            local curTime = ServerDataMgr:getServerTime()
            if curTime >= sellTime then
                local preGiftId = activityInfo.extendData.giftID[1]
                local giftData = RechargeDataMgr:getOneRechargeCfg(preGiftId)
                local isBuyPreGift = false
                if giftData.buyCount ~= 0 and giftData.buyCount - RechargeDataMgr:getBuyCount(giftData.rechargeCfg.id) <= 0 then
                    isBuyPreGift = true
                end

                if not isBuyPreGift then
                    return false
                else
                    local timeFormate = Utils:getLocalDate(curTime)
                    local formatStr = timeFormate:fmt("%Y-%m-%d")
                    local pid = MainPlayer:getPlayerId()
                    local key = "christmasPreRedPoint"..pid
                    if not self.saveStr then
                        self.saveStr = CCUserDefault:sharedUserDefault():getStringForKey(key)
                    end
                    if formatStr ~= self.saveStr then

                        local discountId = activityInfo.extendData.discountId
                        local discountData = RechargeDataMgr:getOneRechargeCfg(discountId)
                        local isBuyGift = false
                        if discountData.buyCount ~= 0 and discountData.buyCount - RechargeDataMgr:getBuyCount(discountData.rechargeCfg.id) <= 0 then
                            isBuyGift = true
                        end
                        local originalId = activityInfo.extendData.originalId
                        local originalData = RechargeDataMgr:getOneRechargeCfg(originalId)
                        if originalData.buyCount ~= 0 and originalData.buyCount - RechargeDataMgr:getBuyCount(originalData.rechargeCfg.id) <= 0 then
                            isBuyGift = true
                        end
                        return (not isBuyGift)
                    else
                        return false
                    end
                end
            else
                return false
            end
        elseif activityInfo.activityType == EC_ActivityType2.CHRISTMAS_FIGHT then
            if not activityInfo.dungeonInfo then return false end

            local hasDungeonNotPass = false
            for k,v in pairs(activityInfo.dungeonInfo.levels) do
                if not v.pass then
                  hasDungeonNotPass= true
                  break
                end
            end
             
            return hasDungeonNotPass or (activityInfo.factoryInfo and activityInfo.factoryInfo.count > 0)
        elseif activityInfo.activityType == EC_ActivityType2.CRAZY_DIAMOND then
            return CrazyDiamondDataMgr:getCrazyDiamondRedPoint(activityId)
        elseif activityInfo.activityType == EC_ActivityType2.FRIEND_BLESS then
            return FriendDataMgr:isBlessWordNoRead()
        elseif activityInfo.activityType == EC_ActivityType2.HALLOWEEN_GHOST then
            local haveGhost
            local info = self:GetGhostInfo()
            for k,v in ipairs(info) do
                if v ~= 0 then
                    haveGhost = true
                    break
                end
            end
            return haveGhost
        elseif activityInfo.activityType == EC_ActivityType2.WSJ_2020 then

        elseif activityInfo.activityType == EC_ActivityType2.ONLINE_SCORE_REWARD then   --这里subtype是2014
            local taskData = self:getActivityItemsInfoBySubType(activityInfo.id, 2014)
            for k, v in pairs(taskData) do
                local progressInfo = ActivityDataMgr2:getProgressInfo(activityInfo.activityType, v.id)
                if progressInfo.status == EC_TaskStatus.GET then
                    isShow = true
                    break
                end
            end
        elseif activityInfo.activityType == EC_ActivityType2.LEAGUE_SCORE_ASSIT then  --社团助理积分使用在线活动id
            local needActivityId = self:getActivityInfoByType(EC_ActivityType2.ONLINE_SCORE_REWARD)[1]
            local needActivityInfo = self:getActivityInfo(needActivityId)
            local taskData = self:getActivityItemsInfoBySubType(needActivityId, 2040)
            for k, v in pairs(taskData) do
                local progressInfo = ActivityDataMgr2:getProgressInfo(needActivityInfo.activityType, v.id)
                if progressInfo.status == EC_TaskStatus.GET then
                    isShow = true
                    break
                end
            end
        else
            local items = self:getItems(activityInfo.id)
            for _, itemId in ipairs(items) do
                local progressInfo = self:getProgressInfo(activityInfo.activityType, itemId)
                local itemInfo = self:getItemInfo(activityInfo.activityType, itemId)
                if progressInfo and progressInfo.status == EC_TaskStatus.GET then
                    isShow = true
                    ---特权任务的锁定状态判断
                    if activityInfo.activityType == EC_ActivityType2.TASK then
                        if itemInfo.extendData and itemInfo.extendData.treeLevel then
                            isShow = PrivilegeDataMgr:getWishTreeLv() >= itemInfo.extendData.treeLevel
                        end
                    end

                    break
                end

                if activityInfo.activityType == EC_ActivityType2.ENTRUST and progressInfo.progress == itemInfo.target and progressInfo.status ~= EC_TaskStatus.GETED then
                    isShow = true
                    break
                end
            end
            if activityInfo.activityType == EC_ActivityType2.ENTRUST then
                activityInfo.extendData.refreshTime = activityInfo.extendData.refreshTime or 0
                local remainTime = math.max(0, math.ceil(activityInfo.extendData.refreshTime/1000) - ServerDataMgr:getServerTime())
                if remainTime == 0 then
                     isShow = true
                end
            end
        end


		if not isShow and activityInfo.activityType == EC_ActivityType2.BLACK_WHITE then
			local cfg = BlackAndWhiteDataMgr:getCfg()
			for k, v in ipairs(cfg) do
				local cfg = TabDataMgr:getData("HighTeamDungeon", v)
				if #table.keys(cfg.joinCost) > 0  then
					local key = table.keys(cfg.joinCost)[1]
					local value = cfg.joinCost[key]
					--costItemId = key
					--costNum = value
					--self._item:setTexture(GoodsDataMgr:getItemCfg(key).icon)
					--self._cost:setText("消耗" .. value .. "/" .. GoodsDataMgr:getItemCount(key, false))
					--self._uis[index][6]:setScale(0.3)
					--self._uis[index][7]:setText(value)
					--self._uis[index][6]:onClick(function()
					--		Utils:showInfo(key, nil, true)
					--end)
					if GoodsDataMgr:getItemCount(key, false) >= value then
						isShow = true
						break
					end
				end
				--break
			end
		end

		if isShow and activityInfo.activityType == EC_ActivityType2.BLACK_WHITE then
			local serverTime = ServerDataMgr:getServerTime()
			if serverTime > activityInfo.endTime then
				isShow = false
			end
		end

        --兼容许愿活动完成状态，直接不显示红点
        if isShow and activityInfo.activityType == EC_ActivityType2.PRAY_ACTIVITY then
            if activityInfo.extendData.prayStep == 3 then
                isShow = false
            end
        end
    end
    return isShow
end

function ActivityDataMgr:setChristmasPreSaveStr(saveStr)
    self.saveStr = saveStr
end

function ActivityDataMgr:getChristmasPreSaveStr()
    return self.saveStr
end

function ActivityDataMgr:isShowAgoraTaskRedPoint()
    local flag = false
    for i, v in ipairs(self:getAgoraTaskActivityInfo()) do
        if v.activityType == EC_ActivityType2.CHRISTMAS then
            local items = self:getItems(v.id)
            for _, itemId in ipairs(items) do
                local progressInfo = self:getProgressInfo(v.activityType, itemId)
                if progressInfo and progressInfo.status == EC_TaskStatus.GET then
                    flag = true
                    break
                end
            end
        end
        if flag then
            break
        end
    end
    return flag
end

function ActivityDataMgr:isShowRedPointInMainView(showType)
    local isOpen = FunctionDataMgr:isOpen(6)
    local isShow = false
    if isOpen then
        for i, v in ipairs(self:getActivityInfo(nil,showType)) do
            isShow = self:isShowRedPoint(v.id)
            if isShow then
                break
            end
        end
    end
    return isShow
end

function ActivityDataMgr:isAssistRedPoint()
    local flag = false
    for i, v in ipairs(self:getAssistActivityInfo()) do
        if v.activityType == EC_ActivityType2.ASSIST then
            local items = self:getItems(v.id)
            for _, itemId in ipairs(items) do
                local progressInfo = self:getProgressInfo(v.activityType, itemId)
                if progressInfo and progressInfo.status == EC_TaskStatus.GET then
                    flag = true
                    break
                end
            end
            if flag then
                break
            end
        else
            flag = self:isShowRedPoint(v.id)
            if flag then
                break
            end
        end
    end
    return flag
end

function ActivityDataMgr:isBackPlayerRedPoint(actType)
    local flag = false
    for i, v in ipairs(self:getBackPlayerActivityInfo()) do
        if actType then
            if v.activityType == actType then
                local items = self:getItems(v.id)
                for _, itemId in ipairs(items) do
                    local progressInfo = self:getProgressInfo(v.activityType, itemId)
                    if progressInfo and progressInfo.status == EC_TaskStatus.GET then
                        flag = true
                        break
                    end
                end
                if flag then
                    break
                end
            end
        else
            flag = self:isShowRedPoint(v.id)
            if flag then
                break
            end
        end
    end
    return flag
end

function ActivityDataMgr:canSubmit(activitId)
    local showGetList = {
        EC_ActivityType2.ASSIST,
        EC_ActivityType2.HALLOWEEN,
        EC_ActivityType2.BACKPLAYER,
        EC_ActivityType2.BACKACTIVITY,
    }

    local isEnd = true
    local activityInfo = self:getActivityInfo(activitId)
    if activityInfo then
        local index = table.indexOf(showGetList, activityInfo.activityType)
        if index == -1 then
            isEnd = self:isEnd(activitId)
        else
            isEnd = self:isShowEnd(activitId)
        end
    end
    return not isEnd
end

function ActivityDataMgr:dropInspect(dropCid)
    local activity = self:getActivityInfoByType(EC_ActivityType2.DROP)
    activity = activity or {}
    local isOpen = self:isOpen(EC_ActivityType2.ONEYEAR_DROP)
    if isOpen then
        local oneYearActivity = self:getActivityInfoByType(EC_ActivityType2.ONEYEAR_DROP)
        for i, v in ipairs(oneYearActivity) do
            table.insert(activity,v)
        end
    end

    isOpen = self:isOpen(EC_ActivityType2.DUNGEON_DROP)
    if isOpen then
        local dungeonActivity = self:getActivityInfoByType(EC_ActivityType2.DUNGEON_DROP)
        for i, v in ipairs(dungeonActivity) do
            table.insert(activity, v)
        end
    end

    local activityIndex = {}
    if dropCid and dropCid ~= 0 then
        for i, v in ipairs(activity) do
            local activityInfo = self:getActivityInfo(v)
            local itemId = activityInfo.items[1]
            for j, itemId in ipairs(activityInfo.items) do
                local itemInfo = self:getItemInfo(activityInfo.activityType, itemId)
                local extendData = itemInfo.extendData
                if extendData.inspectType == EC_ActivityDropInspectType.DROP_ID or extendData.inspectType == EC_ActivityDropInspectType.DUNGEON_DROP_ID then
                    local index = table.indexOf(extendData.dropIdCondition, dropCid)
                    if index ~= -1 then
                        activityIndex[v] = activityIndex[v] or {}
                        table.insert(activityIndex[v], j)
                    end
                elseif extendData.inspectType == EC_ActivityDropInspectType.CHAPTER_TYPE then
                    local dropCfg = TabDataMgr:getData("Drop", dropCid)
                    local index = table.indexOf(extendData.chapterTypeCondition, dropCfg.chapterType)
                    if index ~= -1 then
                        activityIndex[v] = activityIndex[v] or {}
                        table.insert(activityIndex[v], j)
                    end
                end
            end
        end
    end
    return activityIndex
end

function ActivityDataMgr:getDropReward(dropCid)
    local multipleReward = {}
    local extraReward = {}
    local activity = self:dropInspect(dropCid)
    local serverTime = ServerDataMgr:getServerTime()
    --是否全部翻倍(倍数)
    local allMultiple = 0
    for k, v in pairs(activity) do
        local activityInfo = self:getActivityInfo(k)
        for _, index in ipairs(v) do
            local itemId = activityInfo.items[index]
            if itemId then
                local itemInfo = self:getItemInfo(activityInfo.activityType, itemId)
                local extendData = itemInfo.extendData
                if serverTime >= extendData.stime and serverTime <= extendData.etime then
                    if extendData.changeType == EC_ActivityDropChangeType.MULTIPLE then
                        if extendData.allMultiple then
                            allMultiple = extendData.allMultiple
                        end
                        table.merge(multipleReward, extendData.multiple)
                    elseif extendData.changeType == EC_ActivityDropChangeType.EXTRA then
                        if activityInfo.activityType == EC_ActivityType2.DROP then
                            for _, item in ipairs(extendData.activityProfit.roll.items) do
                                table.insert(extraReward, item.id)
                            end
                        elseif activityInfo.activityType == EC_ActivityType2.ONEYEAR_DROP then
                            local filtType = dropCid
                            if extendData.inspectType == EC_ActivityDropInspectType.CHAPTER_TYPE then
                                local dropCfg = TabDataMgr:getData("Drop", dropCid)
                                filtType = dropCfg.chapterType
                            end
                            local info = extendData.activityProfit[tostring(filtType)]
                            if info and info.roll and info.roll.items then
                                for _,item in ipairs(info.roll.items) do
                                    table.insert(extraReward, item.id)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    multipleReward = table.unique(multipleReward)
    extraReward = table.unique(extraReward)
    return multipleReward, extraReward, allMultiple
end

---------------------------------------------------------------------

function ActivityDataMgr:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(activitId, activitEntryId, extendData)
    if self:canSubmit(activitId) then
        TFDirector:send(c2s.ACTIVITY_NEW_SUBMIT_ACTIVITY, {activitId, activitEntryId, tostring(extendData)})
    else
        Utils:showTips(1890001)
    end
end

function ActivityDataMgr:send_ACTIVITY_REQ_RANK_ACTIVITY(activitId)
    TFDirector:send(c2s.ACTIVITY_REQ_RANK_ACTIVITY, {activitId})
end

function ActivityDataMgr:send_ACTIVITY_REQ_ACTIVITY_RANK(activitId)
    TFDirector:send(c2s.ACTIVITY_REQ_ACTIVITY_RANK, {activitId})
end

function ActivityDataMgr:send_ACTIVITY_REQ_CROSS_RANK_ACTIVITY(activitId)
    TFDirector:send(c2s.ACTIVITY_REQ_CROSS_RANK_ACTIVITY, {activitId})
end

function ActivityDataMgr:send_ACTIVITY_REQ_KURUMI_HISTORY_INFO()
    local activityId = self:getActivityInfoByType(EC_ActivityType2.KUANGSAN_FUBEN)[1]
    local activityInfo = self:getActivityInfo(activityId)
    if activityInfo and not activityInfo.historyInfo then
        TFDirector:send(c2s.ACTIVITY_REQ_KURUMI_HISTORY_INFO, {})
    end
end

function ActivityDataMgr:send_ACTIVITY_REQ_KURUMI_HISTORY_RANK()
    local activityId = self:getActivityInfoByType(EC_ActivityType2.KUANGSAN_FUBEN)[1]
    local activityInfo = self:getActivityInfo(activityId)
    if activityInfo then
        TFDirector:send(c2s.ACTIVITY_REQ_KURUMI_HISTORY_RANK, {})
    end
end

function ActivityDataMgr:send_ACTIVITY_REQ_KURUMI_CITY_RESOURCE(cityId,count,multiple)
    TFDirector:send(c2s.ACTIVITY_REQ_KURUMI_CITY_RESOURCE, {cityId,count,multiple})
end

function ActivityDataMgr:send_ACTIVITY_REQ_KURUMI_CAMP(camp)
    TFDirector:send(c2s.ACTIVITY_REQ_KURUMI_CAMP, {camp})
end

----发送地址更改信息
function ActivityDataMgr:Send_submitAddress(jsonData)
    if not jsonData then
        return
    end
    self:setNextTime()
    TFDirector:send(c2s.ACTIVITY_REQ_UPDATE_SUPPORT_ADDRESS, {jsonData})
end

function ActivityDataMgr:onRecvChangeAddress(event)

    local data = event.data
    if not data then
        return
    end
    EventMgr:dispatchEvent(EV_UPDATE_CHANGE_ASSIST_ADDRESS)
end

function ActivityDataMgr:onRecvAssistAddressInfo(event)
    local data = event.data
    if data.address then
        self.fiilInfo = json.decode(data.address)
    end
    EventMgr:dispatchEvent(EV_GET_ASSIST_ADDRESS)
end

function ActivityDataMgr:setFillInfo(fiilInfo)
    self.fiilInfo = fiilInfo
end

function ActivityDataMgr:getFillInfo()
    return self.fiilInfo
end

function ActivityDataMgr:setNextTime()
    self.nextTime = ServerDataMgr:getServerTime() + self.cdTime
end

function ActivityDataMgr:getNextTime()
    return self.nextTime
end

function ActivityDataMgr:__parserActivity(activityInfo)
    if activityInfo.extendData and activityInfo.extendData ~= "" then
        activityInfo.extendData = json.decode(activityInfo.extendData)
    else
        activityInfo.extendData = {}
    end
    return activityInfo
end

function ActivityDataMgr:__handleActivity(activitys)
	-- print("--------------------------------------------------------ActivityDataMgr:__handleActivity=" .. #activitys)
    for i, v in ipairs(activitys) do
        local activityInfo = self:__parserActivity(v)

        --dump(activityInfo)
        --英文版新增DFW_AUTUMN 掉落活动筛选
        if v.activityType == EC_ActivityType2.DUANWU_1 or v.activityType == EC_ActivityType2.DFW_AUTUMN then
            self.duanwuType = tonumber(v.extendData.displayType) or 0
        end

        if activityInfo.ct == EC_SChangeType.DEFAULT or activityInfo.ct == EC_SChangeType.ADD then
            local index = self.activityInfoMap_[activityInfo.id]
            if index then
                self.activityInfo_[index] = self.activityInfo_[index] or {}
                for k,v in pairs(activityInfo) do
                    self.activityInfo_[index][k] = v
                end
            else
				print("---------------------------------------->table.insert")
                table.insert(self.activityInfo_, activityInfo)
            end
        elseif activityInfo.ct == EC_SChangeType.DELETE then
            local index = self.activityInfoMap_[activityInfo.id]
            if index then
                table.remove(self.activityInfo_, index)
                self.activityInfoMap_[activityInfo.id] = nil
            end
            EventMgr:dispatchEvent(EV_ACTIVITY_DELETED, activityInfo.id,activityInfo.extendData)
        elseif activityInfo.ct == EC_SChangeType.UPDATE then
            local index = self.activityInfoMap_[activityInfo.id]
            if index then
                self.activityInfo_[index] = self.activityInfo_[index] or {}
                for k,v in pairs(activityInfo) do
                    self.activityInfo_[index][k] = v
                end
            end
        end
        if not self.itemInfoMap_[activityInfo.activityType] then
            self.itemInfoMap_[activityInfo.activityType] = {}
        end
    end

    self:updateActivtyOrder()
    EventMgr:dispatchEvent(EV_ACTIVITY_UPDATE_ACTIVITY)
end

function ActivityDataMgr:onRecvActivitys(event)
    local data = event.data
    if not data or not data.activitys then return end
    self:__handleActivity(data.activitys)
    self:actionActivtyPush(data.activitys)
end

function ActivityDataMgr:__parserItem(itemInfo)
    local type_ = itemInfo.type
    if type_ == EC_ActivityType2.STORE then
        itemInfo.target = json.decode(itemInfo.target)
        itemInfo.reward = json.decode(itemInfo.reward)
    elseif type_ == EC_ActivityType2.TASK then
        itemInfo.target = tonumber(itemInfo.target)
        itemInfo.reward = json.decode(itemInfo.reward)
    elseif type_ == EC_ActivityType2.ASSIST then
        itemInfo.target = tonumber(itemInfo.target)
        itemInfo.reward = json.decode(itemInfo.reward)
    elseif type_ == EC_ActivityType2.HALLOWEEN then
        itemInfo.reward = json.decode(itemInfo.reward)
    elseif type_ == EC_ActivityType2.BACKPLAYER then
        itemInfo.reward = json.decode(itemInfo.reward)
    elseif type_ == EC_ActivityType2.BACKACTIVITY then
        itemInfo.reward = json.decode(itemInfo.reward)
    elseif type_ == EC_ActivityType2.ENTRUST then
        if itemInfo.reward then
            itemInfo.reward = json.decode(itemInfo.reward)
        else
            itemInfo.reward = {}
        end
    elseif type_ == EC_ActivityType2.CHRISTMAS then
        itemInfo.reward = json.decode(itemInfo.reward)
    elseif type_ == EC_ActivityType2.CHRISTMAS_SIGN then
        itemInfo.reward = json.decode(itemInfo.reward)
    elseif type_ == EC_ActivityType2.RECHARGE then
        itemInfo.reward = json.decode(itemInfo.reward)
    elseif type_ == EC_ActivityType2.ADD_RECHARGE then
        itemInfo.reward = json.decode(itemInfo.reward)
    elseif type_ == EC_ActivityType2.VALENTINE then
        itemInfo.reward = json.decode(itemInfo.reward)
    elseif type_ == EC_ActivityType2.WHITEVALENTINE then
        itemInfo.target = json.decode(itemInfo.target)
        itemInfo.reward = json.decode(itemInfo.reward)
    elseif type_ == EC_ActivityType2.DAFUWENG then
        itemInfo.target = tonumber(itemInfo.target)
        itemInfo.reward = json.decode(itemInfo.reward)
    elseif type_ == EC_ActivityType2.DFW_SUMMER then
        itemInfo.target = tonumber(itemInfo.target)
        itemInfo.reward = json.decode(itemInfo.reward)
    elseif type_ == EC_ActivityType2.SX_BIRTHDAY then
        itemInfo.target = tonumber(itemInfo.target)
        itemInfo.reward = json.decode(itemInfo.reward)
    elseif type_ == EC_ActivityType2.MAID_COFFEE then
        itemInfo.target = tonumber(itemInfo.target)
        itemInfo.reward = json.decode(itemInfo.reward)
    elseif type_ == EC_ActivityType2.CGCOLLECTED then
        if itemInfo.reward then
            itemInfo.reward = json.decode(itemInfo.reward)
        else
            itemInfo.reward = {}
        end
    elseif type_ == EC_ActivityType2.DUANWU_1 then
        itemInfo.target = tonumber(itemInfo.target)
        itemInfo.reward = json.decode(itemInfo.reward)
    elseif type_ == EC_ActivityType2.DUANWU_2 then
        itemInfo.target = tonumber(itemInfo.target)
        itemInfo.reward = json.decode(itemInfo.reward)
    elseif type_ == EC_ActivityType2.BINGOGAME then
        itemInfo.target = tonumber(itemInfo.target)
        itemInfo.reward = json.decode(itemInfo.reward)
    elseif type_ == EC_ActivityType2.CHRONO_CROSS then
        itemInfo.target = tonumber(itemInfo.target)
        itemInfo.reward = json.decode(itemInfo.reward)
    else
        if itemInfo.target then
            itemInfo.target = tonumber(itemInfo.target)
        end
        if itemInfo.reward then
            itemInfo.reward = json.decode(itemInfo.reward)
        end
    end

    if itemInfo.extendData then
        itemInfo.extendData = json.decode(itemInfo.extendData)
    else
        itemInfo.extendData = {}
    end
    return itemInfo
end

function ActivityDataMgr:onRecvItems(event)
    -- dump(event)
	if not event.data then
		print("not data")
	else
		if not event.data.items then
			print("not data.items")
		end
	end
	
    local data = event.data
    if not data or not data.items then return end

    for i, v in ipairs(data.items) do
        local itemInfo = self:__parserItem(v)
        self.itemInfoMap_[v.type] = self.itemInfoMap_[v.type] or {}
        self.itemInfoMap_[v.type][v.id] = itemInfo
        -- print("================================================onRecvItems=type=" .. v.type .. "id=" .. v.id)
    end
end

function ActivityDataMgr:onRecvProgress(event)
    local data = event.data
    if not data or not data.items then return end

    for i, v in ipairs(data.items) do
        local activityInfo = self:getActivityInfo(v.id)
        if v.extend and #v.extend > 0 then
            v.extend = json.decode(v.extend)
        else
            v.extend = {}
        end
        if activityInfo and activityInfo.activityType then
            self.progressInfoMap_[activityInfo.activityType] = self.progressInfoMap_[activityInfo.activityType] or {}
            self.progressInfoMap_[activityInfo.activityType][v.itemId] = v
        end
    end
    EventMgr:dispatchEvent(EV_ACTIVITY_UPDATE_PROGRESS)
end

function ActivityDataMgr:onRecvSubmitActivity(event)
    local data = event.data
    EventMgr:dispatchEvent(EV_ACTIVITY_SUBMIT_SUCCESS, data.activityid, data.activitEntryId, data.rewards or {})
end

function ActivityDataMgr:onRecvPushActivity(event)
    local data = event.data
    if not data.activitys then end
    self:__handleActivity(data.activitys)
    self:actionActivtyPush(data.activitys)
end

function ActivityDataMgr:actionActivtyPush( activitys )
    -- body
    for k,v in ipairs(activitys) do
        if v.ct == EC_SChangeType.ADD or v.ct == EC_SChangeType.DEFAULT then
            if v.activityType == EC_ActivityType2.DUANWU_HANGUP then
                DuanwuHangUpDataMgr:sendHANGUP_ACT_REQ_ACT_INFO()
            elseif v.activityType == EC_ActivityType2.DETECTIVE_CHAPTER then
                DetectiveDataMgr:getServerInitData()
            end
        end
    end
end

function ActivityDataMgr:requestAssistProgress(activityId)
    TFDirector:send(c2s.ACTIVITY_SUPPORT_ACTIVITY_PROGRESS, {activityId})
end

function ActivityDataMgr:requestAssistRanking(activityId)
    TFDirector:send(c2s.ACTIVITY_REQ_RANK, {activityId})
end

function ActivityDataMgr:onRecvAssistProgress(event)
    local data = event.data
    if data then
        self.assistProgressData_ = data
    end
    EventMgr:dispatchEvent(EV_ACTIVITY_ASSIST_PROGRESS, data)
end

function ActivityDataMgr:onRecvAssistRanking(event)
    local data = event.data

    EventMgr:dispatchEvent(EV_ACTIVITY_ASSIST_RANKING, data)
end

function ActivityDataMgr:onRecvActivityLessRank(event)
    local data = event.data
    EventMgr:dispatchEvent(EV_ACTIVITY_LESS_RANK, data.activityId, data.ranks or {})
end

function ActivityDataMgr:onRecvActivityMoreRank(event)
    local data = event.data
    if not data then return end
    EventMgr:dispatchEvent(EV_ACTIVITY_MORE_RANK, data)
end

function ActivityDataMgr:onRecvRefreshEnrust(event)
    local data = event.data
    EventMgr:dispatchEvent(EV_ACTIVITY_REFRESH_ENTRUST, data)
end

function ActivityDataMgr:createExtendUI(parentLayer) -- layer 对象
    if not parentLayer then return end
    local _layerName = parentLayer.__cname
    local uiPath = ActivityDataMgr.extendUI[_layerName]
    if not uiPath then return end

    if #self:getActivityInfoByType(uiPath.activityType) == 0 then return end

    local extendUI = require(uiPath.path):new(uiPath.param)
    parentLayer:addChild(extendUI)
    return extendUI
end

--=======================新年约会活动===============================

function ActivityDataMgr:getNianShouEscapeTime( )
    local actionInfos = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.NEWYEARDATING)
    local remainTime = 0
    for k,v in pairs(actionInfos) do
        v = self:getActivityInfo(v)
        if v.extendData.nianBeastId and v.extendData.nianBeastId > 0 then
            if v.extendData.nianBeastEscapeTime ~= -1 then
                if v.extendData.nianBeastEscapeTime > ServerDataMgr:getServerTime() then
                    remainTime = math.ceil(v.extendData.nianBeastEscapeTime - ServerDataMgr:getServerTime())
                    break
                end
            end
        end
    end
    return remainTime
end

function ActivityDataMgr:getNianShouData( )
    local actionInfos = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.NEWYEARDATING)
    local data = {}
    for k,v in pairs(actionInfos) do
        v = self:getActivityInfo(v)
        if v.extendData.nianBeastId and v.extendData.nianBeastId ~= 0 then
            data.id = v.extendData.nianBeastId
            data.bid = v.extendData.buildingId
            break
        end
    end
    return data
end

function ActivityDataMgr:getNianShouState( )
    local actionInfos = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.NEWYEARDATING)
    local hasNianBeast = false
    local unArrest = false
    for k,v in pairs(actionInfos) do
        v = self:getActivityInfo(v)
        if v.extendData.nianBeastId and v.extendData.nianBeastId ~= 0 then
            hasNianBeast = true
            if v.extendData.nianBeastEscapeTime == -1 then
                unArrest = false
            elseif v.extendData.nianBeastEscapeTime > ServerDataMgr:getServerTime() then
                unArrest = true
            else
                hasNianBeast = false
            end
        end
    end
    return hasNianBeast,unArrest
end

function ActivityDataMgr:getNewYearActivityItems( activityId, month )
    TFDirector:send(c2s.ACTIVITY_NEW_REQ_YEAR_ACTIVITY_MONTH_ITEMS,{activityId,tostring(month)})
end

function ActivityDataMgr:finishNewYearActivityItems( activityId, itemId, extend )
    TFDirector:send(c2s.ACTIVITY_REQ_COMPLETED_EVENT,{activityId,itemId, tostring(extend)})
end

function ActivityDataMgr:pushNewYearActivityToNextMonth( activityId )
    TFDirector:send(c2s.ACTIVITY_REQ_PUSH_NEXT_STAGE,{activityId})
end

function ActivityDataMgr:getCfgDataByType( activityType )
    if not activityType then return end
    return self.activityCfgDataMap_[activityType]
end

function ActivityDataMgr:getYearActivityItemsByMonth( activityId , month )
    local itemInfos = {}
    local activityInfo = self:getActivityInfo(activityId)
    if activityInfo then
        local cfgData = self:getCfgDataByType(activityInfo.activityType)
        local eventGroup = cfgData[month].eventGroup
        for k,v in pairs(eventGroup) do
            for j,l in pairs(v) do
                local itemInfo = self:getActivityInfo(activityInfo.activityType,l)
                table.insert(itemInfos,itemInfo)
            end
        end
    end
    return itemInfos
end

function ActivityDataMgr:checkYearActivityCurDayStatus( activityId , month ,day)
    -- body
    local activityInfo = self:getActivityInfo(activityId)
    if activityInfo then
        local cfgData = self:getCfgDataByType(activityInfo.activityType)
        local eventGroup = cfgData[month].eventGroup
        local list = eventGroup[day]
        if not list then return true end
        for j, itemId in pairs(list) do
            local progressInfo = self:getProgressInfo(activityInfo.activityType, itemId)
            if progressInfo.status ~= EC_TaskStatus.GETED then
                return false
            end
        end
        return true
    end
end

function ActivityDataMgr:checkYearActivityCurMonthStatus( activityId , month)
    -- body
    local curDay = 1
    local activityInfo = self:getActivityInfo(activityId)
    if activityInfo then
        local cfgData = self:getCfgDataByType(activityInfo.activityType)
        local eventGroup = cfgData[month].eventGroup
        local keys = table.keys(eventGroup)
        table.sort( keys,function ( a ,b )
            return  a < b
        end )
        for k,v in ipairs(keys) do
            local list = eventGroup[v]
            for j, itemId in pairs(list) do
                local progressInfo = self:getProgressInfo(activityInfo.activityType, itemId)
                if progressInfo.status ~= EC_TaskStatus.GETED then
                    return false, v
                end
            end
        end
        return true, keys[#keys]
    end
    return nil,nil
end

function ActivityDataMgr:onArrestNianBeastRsp( event )
    local activityId = self:getActivityInfoByType(EC_ActivityType2.NEWYEARDATING)[1]

    local activityInfo = self:getActivityInfo(activityId)
    local data = event.data
    activityInfo.extendData.jumpParamters = data
    if data.type == 2 then -- 开启关卡战斗
        local levelCfg = FubenDataMgr:getLevelCfg(data.param)
        Utils:openView("fuben.FubenSquadView", levelCfg.dungeonType, data.param, false,1)
    elseif data.type == 3 then -- 开启下一场约会
    elseif data.type == 1 then
        activityInfo.extendData.jumpParamters = nil
        if data.rewards then
            Utils:showReward(data.rewards)
        end
        Utils:showTips(13100068)
    elseif data.type == 0 then
        activityInfo.extendData.jumpParamters = nil
        Utils:showTips(13100069)
        EventMgr:dispatchEvent(EV_NEW_CITY.cityUpdate)
    end

end

function ActivityDataMgr:onRefreshNianBeastRsp( event )
    local data = event.data
    local activityId = self:getActivityInfoByType(EC_ActivityType2.NEWYEARDATING)[1]
    if not activityId then return end
    local activityInfo = self:getActivityInfo(activityId)
    activityInfo.extendData.nianBeastId = data.nianBeastId
    activityInfo.extendData.buildingId = data.builingId
    activityInfo.extendData.nianBeastEscapeTime = data.deadline
    activityInfo.extendData.randomSeed = data.randomSeed
    activityInfo.extendData.datingId = data.datingId
    if data.nianBeastId ~=  0 and data.deadline ~= -1 then
        EventMgr:dispatchEvent(EV_ACTIVITY_REFRESH_NIANBREAST)
    end
    EventMgr:dispatchEvent(EV_NEW_CITY.cityUpdate)
end
function ActivityDataMgr:onUseFireWorkRsp( event )
    local data = event.data
    EventMgr:dispatchEvent(EV_ACTIVITY_USE_FIREWORK,{id = data.fireworkId,randSeed = data.randomSeed})
    if data.rewards then
        Utils:showReward(data.rewards)
    end
end

function ActivityDataMgr:onComposeFireCrackerRsp( event )
    local data = event.data
    EventMgr:dispatchEvent(EV_ACTIVITY_COMPOSE_SUC)
end

function ActivityDataMgr:onActivityStageChange( event )
    local data = event.data
    local activityInfo = self:getActivityInfo(data.activityId)
    if activityInfo then
        activityInfo.extendData.stage = data.stage
    end
end

function ActivityDataMgr:onSpringFestivalRefreshCount( event )
    local data = event.data
    local activityInfo = self:getActivityInfo(data.activityId)
    if activityInfo then
        activityInfo.extendData.refreshCount = data.refreshCount
    end
end

function ActivityDataMgr:onSpringFestivalRefreshTask( event )
    EventMgr:dispatchEvent(EV_ACTIVITY_UPDATE_NEWYEAR_TASK)
end

function ActivityDataMgr:onSpringFestivalRefreshScore( event )
    local data = event.data
    local activityInfo = self:getActivityInfo(data.activityId)
    if activityInfo then
        activityInfo.extendData.totalScore = data.score
    end
end

function ActivityDataMgr:onResqYearActivityCfg( event )
    local data = event.data
    if not data then return end
    for j,l in pairs(data.configList) do
        l.eventGroup = json.decode(l.eventGroup)
        local temp = {}
        for k,v in pairs(l.eventGroup) do
            temp[tonumber(k)] = v
        end
        l.eventGroup = temp
    end
    self.activityCfgDataMap_[EC_ActivityType2.ZNQ_HG] = data.configList
end

function ActivityDataMgr:onRecvActivityInnerData(  event  )
    local data = event.data
    if not data then return end
    local activityInfo = self:getActivityInfo(data.actId)
    if activityInfo then
        for k,v in pairs(json.decode(data.jsonData)) do
            activityInfo.extendData[k] = v
        end
        EventMgr:dispatchEvent(EV_ACTIVITY_UPDATE_ACTIVITY)
    end
end


function ActivityDataMgr:onRecvKuangsanHistoryInfo( event )
    local data = event.data
    if not data then return end
    local activityId = self:getActivityInfoByType(EC_ActivityType2.KUANGSAN_FUBEN)[1]
    local activityInfo = self:getActivityInfo(activityId)
    activityInfo.historyInfo = data
    EventMgr:dispatchEvent(EV_ACTIVITY_UPDATE_ACTIVITY)
end

function ActivityDataMgr:onRecvKuangsanHistoryRank( event )
    local data = event.data
    if not data then return end
    local activityId = self:getActivityInfoByType(EC_ActivityType2.KUANGSAN_FUBEN)[1]
    local activityInfo = self:getActivityInfo(activityId)
    activityInfo.historyRank = data.campRank
    EventMgr:dispatchEvent(EV_KUANGSAN_FUBEN_RANKS)
end

function ActivityDataMgr:onRecvKuangsanCityResource( event )
    local data = event.data
    if not data or not data.rewards then return end
    local activityId = self:getActivityInfoByType(EC_ActivityType2.KUANGSAN_FUBEN)[1]
    local activityInfo = self:getActivityInfo(activityId)
    EventMgr:dispatchEvent(EV_ACTIVITY_SUBMIT_SUCCESS, activityId, nil, data.rewards or {})
end

function ActivityDataMgr:onRecvKuangsanCityRefresh( event )
    local data = event.data
    if not data or not data.cities  then return end
    local activityId = self:getActivityInfoByType(EC_ActivityType2.KUANGSAN_FUBEN)[1]
    local activityInfo = self:getActivityInfo(activityId)

    if not activityInfo or not activityInfo.historyInfo then
        return
    end

    for _k,_v in pairs(data.cities) do
        local isNew = true
        for k,v in pairs(activityInfo.historyInfo.cities) do
            if v.id == _v.id then
                activityInfo.historyInfo.cities[k] = _v
                isNew = false
            end
        end

        if isNew then
            table.insert(activityInfo.historyInfo.cities,_v)
        end
    end

    EventMgr:dispatchEvent(EV_KUANGSAN_FUBEN_CITYRSP)
end

function ActivityDataMgr:onRecvKuangsanCampRsp( event )
    local data = event.data
    if not data then return end
    local activityId = self:getActivityInfoByType(EC_ActivityType2.KUANGSAN_FUBEN)[1]
    local activityInfo = self:getActivityInfo(activityId)
    if data.camp and activityInfo.historyInfo then
        activityInfo.historyInfo.camp = data.camp
    end
    Utils:showTips(12032043)
end

function ActivityDataMgr:getRedPointStatus( functionid , ... )
    if ActivityDataMgr.checkRedPointFunc[functionid] then
        return ActivityDataMgr.checkRedPointFunc[functionid](...)
    end
    return false
end

---战令活动和任务

--领取奖励
function ActivityDataMgr:reqGetWarOrderAward(activityId, propId)
    TFDirector:send(c2s.ACTIVITY_REQ_GET_WAR_ORDER_AWARD, {activityId, propId})
end

--获取战令信息
function ActivityDataMgr:reqGetWarOrderInfo()
    TFDirector:send(c2s.ACTIVITY_REQ_GET_WAR_ORDER_INFO, {})
end

--购买战令等级
function ActivityDataMgr:reqUWarOrderLevel(level)
    TFDirector:send(c2s.ACTIVITY_REQ_UWAR_ORDER_LEVEL, {level})
end

function ActivityDataMgr:onGetWarOrderAward(event)
    local data = event.data
    local activityid = data.activityid
    local propId = data.propId
    local rewards = data.rewards or {}
    Utils:showReward(rewards)
    EventMgr:dispatchEvent(EV_ACTIVITY_WAR_ORDER_GET_REWARD)
end

function ActivityDataMgr:onGetWarOrderInfo(event)
    local data = event.data
    local level = data.level
    local exp = data.exp
    local propList = data.propList
    self.warOrderInfo_ = data
    self.warOrderInfo_.propList = self.warOrderInfo_.propList or {}
    EventMgr:dispatchEvent(EV_ACTIVITY_WAR_ORDER_UPDATE_INFO)
end

function ActivityDataMgr:onUpWarOrderLevel(event)
    local data = event.data
    EventMgr:dispatchEvent(EV_ACTIVITY_WAR_ORDER_UPGRADE_LEVEL)
end

function ActivityDataMgr:isWarOrderActivityOpen()
    local activityInfo = self:getWarOrderAcrivityInfo()
    if activityInfo then
        return true
    end
    return false
end

function ActivityDataMgr:getWarOrderAcrivityInfo()
    for i, v in ipairs(self.activityInfo_) do
        if v.activityType == EC_ActivityType2.TRAINING then
            return v
        end
    end
end

function ActivityDataMgr:getWarOrderLevel()
    return self.warOrderInfo_ and self.warOrderInfo_.level or 0
end

function ActivityDataMgr:getWarOrderMaxLevel()
    return self:getWarOrderAcrivityInfo().extendData.maxLevel
end

function ActivityDataMgr:getWarOrderUpLevelCost()
    return self:getWarOrderAcrivityInfo().extendData.levelCost
end

function ActivityDataMgr:getWarOrderExp()
    return self.warOrderInfo_ and self.warOrderInfo_.exp or 0
end

function ActivityDataMgr:checkWarOrderItemState(propId)
    if self.warOrderInfo_ then
        for i,v in ipairs(self.warOrderInfo_.propList) do
            if propId == v then
                return 2
            end
        end
    end
    return 1
end

function ActivityDataMgr:checkWarOrderTaskRedPoint()
    local activityInfo = self:getWarOrderAcrivityInfo()
    local taskData = self:getItems(activityInfo.id)
    for i, info in ipairs(taskData) do
        if not activityInfo.extendData.daytask or tonumber(activityInfo.extendData.daytask) ~= info then
            local progressInfo = ActivityDataMgr2:getProgressInfo(activityInfo.activityType, info)
            if progressInfo.status == EC_TaskStatus.GET then
                return true
            end
        end
    end
    return false
end

function ActivityDataMgr:getWarOrderChargeList()
    local activityInfo = self:getWarOrderAcrivityInfo()
    local rechargeList = activityInfo.extendData.rechargeList or {}
    return rechargeList
end

function ActivityDataMgr:getWarOrderChargeState()
    local activityInfo = self:getWarOrderAcrivityInfo()
    local rechargeList = activityInfo.extendData.rechargeList
    if RechargeDataMgr:getBuyCount(rechargeList[2]) > 0 then
        return 2
    elseif RechargeDataMgr:getBuyCount(rechargeList[3]) > 0 then
        return 3
    elseif RechargeDataMgr:getBuyCount(rechargeList[1]) > 0 then
        return 1
    end
    return 0
end

--  端午,中秋 == 1,元宵 == 2 UI类型选择(相同功能逻辑)
function ActivityDataMgr:getActivityUIType()
    return self.duanwuType or 0
end

function ActivityDataMgr:checkHalloweenBuffIsActivity( buffCid ,dungeonId )
    -- body
    local buffActivity = true
    local halloweenBuffCfg = TabDataMgr:getData("HalloweenBuff",buffCid)
    if halloweenBuffCfg.unlockDungeon then
        local progressInfo = self:getProgressInfo(EC_ActivityType2.HALLOWEEN,halloweenBuffCfg.unlockDungeon)

        buffActivity = table.count(progressInfo) > 0 and progressInfo.status ~= EC_TaskStatus.ING 
    end

    if buffActivity and dungeonId then
        buffActivity = table.find(halloweenBuffCfg.limitTargetDungeon,dungeonId) ~= -1
    end
    return buffActivity
end

function ActivityDataMgr:getHalloweenBuffIsActivity( dungeonId )
    -- body
    local halloweenBuffCfgs = TabDataMgr:getData("HalloweenBuff")
    local buffIds = {}
    for k,v in pairs(halloweenBuffCfgs) do
        if self:checkHalloweenBuffIsActivity(v.id, dungeonId) then
            table.insert(buffIds,v.id)
        end
    end
    return buffIds
end


--查询全服积分
function ActivityDataMgr:request_ACTIVITY_REQ_ALL_ACTIVITY_ITEM(activityId)
    TFDirector:send(c2s.ACTIVITY_REQ_ALL_ACTIVITY_ITEM, {activityId})
end
--查询全服积分返回
function ActivityDataMgr:onRecvOverServerScore(event)
    local data = event.data
    print("查询全服积分返回",data)
    EventMgr:dispatchEvent(EV_ACTIVITY_OVER_SERVER_SCORE,  data)
end

--全服社团排行请求
function ActivityDataMgr:request_ACTIVITY_REQ_UNION_RANK_ACT_SCORE(activityId)
    TFDirector:send(c2s.ACTIVITY_REQ_UNION_RANK_ACT_SCORE, {activityId})
end

--社团助理积分请求
function ActivityDataMgr:request_ACTIVITY_REQ_ACTIVITY_UNION_ITEM(activityId)
    TFDirector:send(c2s.ACTIVITY_REQ_ACTIVITY_UNION_ITEM, {activityId})
end

---------------圣诞节开始---------------------

function ActivityDataMgr:onRecvChristmasDungeonInfo( event )
    -- body 
    local data = event.data
    if not data then return end
    local activityId = self:getActivityInfoByType(EC_ActivityType2.CHRISTMAS_FIGHT)[1]
    if activityId then 
        local activityInfo = self:getActivityInfo(activityId)
        activityInfo.dungeonInfo = data
        EventMgr:dispatchEvent(EV_ACTIVITY_UPDATE_PROGRESS)
    else  --英文版全服助力新增
        EventMgr:dispatchEvent(EV_ACTIVITY_UPDATE_PROGRESS , data)
    end

end

function ActivityDataMgr:onRecvChristmasFactoryInfo( event )
    -- body 
    local data = event.data
    if not data then return end
    local activityId = self:getActivityInfoByType(EC_ActivityType2.CHRISTMAS_FIGHT)[1]
    if activityId then 
        local activityInfo = self:getActivityInfo(activityId)
        activityInfo.factoryInfo = data
        EventMgr:dispatchEvent(EV_ACTIVITY_UPDATE_PROGRESS)
    end
end

function ActivityDataMgr:onRecvChristmasRefreshRsp( event )
    -- body
end

function ActivityDataMgr:onRecvChristmasTalentRsp( event )
    -- body
    Utils:showTips(2130503) -- 已激活
end

function ActivityDataMgr:onRecvChristmasProductRsp( event )
    -- body
    local data = event.data
    if not data then return end

    if data.rewards then
        Utils:showReward(data.rewards)
    end

end

function ActivityDataMgr:onRecvDrawComPass(event )
    local data = event.data
    if not data then return end
    EventMgr:dispatchEvent(EV_ACTIVITY_RES_DRAW_COMPASS , data)
end

function ActivityDataMgr:request_CHRISTMAS_REQ2019_CHRISTMAS_DUNGEON()
    -- body
    TFDirector:send(c2s.CHRISTMAS_REQ2019_CHRISTMAS_DUNGEON,{})
end

function ActivityDataMgr:request_CHRISTMAS_REQ2019_CHRISTMAS_FACTORY()
    -- body
    TFDirector:send(c2s.CHRISTMAS_REQ2019_CHRISTMAS_FACTORY,{})
end

function ActivityDataMgr:request_CHRISTMAS_REQ2019_CHRISTMAS_TALENT(talentId)
    -- body
    TFDirector:send(c2s.CHRISTMAS_REQ2019_CHRISTMAS_TALENT,{talentId})
end

function ActivityDataMgr:request_CHRISTMAS_REQ2019_CHRISTMAS_REFRESH()
    -- body
    TFDirector:send(c2s.CHRISTMAS_REQ2019_CHRISTMAS_REFRESH,{})
end

function ActivityDataMgr:request_CHRISTMAS_REQ2019_CHRISTMAS_PRODUCT()
    -- body
    TFDirector:send(c2s.CHRISTMAS_REQ2019_CHRISTMAS_PRODUCT,{})
end

---------------圣诞节结束---------------------
---------------春节挂机活动开始---------------------

function ActivityDataMgr:onRecvHangUpInfo( event )
    -- body
    local data = event.data
    if not data then return end
    data.eventList = data.eventList or {}
    data.hangUpRoleInfo = data.hangUpRoleInfo or {}
    data.specialAward = data.specialAward or {}
    local activityInfo = self:getActivityInfo(data.activityId)
    activityInfo.data = data

    EventMgr:dispatchEvent(EV_ACTIVITY_UPDATE_PROGRESS)
end

function ActivityDataMgr:onRecvHangUpRoleLevelUpRsp( event )
    -- body
    EventMgr:dispatchEvent(EV_ACTIVITY_HANGUP_ROLE_LEVELUP)
end

function ActivityDataMgr:onRecvGetHangUpSEventAwardRsp( event )
    -- body
    local data = event.data
    if not data then return end

    Utils:showReward(data.rewards)
end

function ActivityDataMgr:onRecvGetHangUpRewardRsp( event )
    local data = event.data
    if not data then return end

    Utils:showReward(data.rewards)
end

function ActivityDataMgr:onRecvUpOrDownHangUpRoleRsp( event )
    -- body 
    local data = event.data
    if not data then return end
    if data.up then
        Utils:showTips(14300211)
    else
        Utils:showTips(14300212)
    end
end

function ActivityDataMgr:onRecvSendEventInfo( event )
    -- body
    local data = event.data
    if not data then return end

    local activityInfo = self:getActivityInfo(data.activityId)

    if (not activityInfo) or (not activityInfo.data) then return end

    for k,v in pairs(data.eventList or {}) do
        local has 
        for _k,_v in pairs(activityInfo.data.eventList) do
            if _v.eventId == v.eventId then
                has = true
                if v.ct == EC_SChangeType.DELETE then
                    table.remove(activityInfo.data.eventList,_k)
                else
                    activityInfo.data.eventList[_k] = clone(v)
                end
                break;
            end
        end
        
        if not has then
            table.insert(activityInfo.data.eventList,v)
        end
    end
    EventMgr:dispatchEvent(EV_ACTIVITY_UPDATE_HANGUP_EVENTLIST)
end

function ActivityDataMgr:onRecvSendSpecialEventAward( event )
    -- body
    local data = event.data
    if not data then return end

    local activityInfo = self:getActivityInfo(data.activityId)
    if (not activityInfo) or (not activityInfo.data) then return end
    activityInfo.data.specialAward = activityInfo.data.specialAward or {}
    for k,v in pairs(data.specialAward or {}) do
        local has 
        for _k,_v in pairs(activityInfo.data.specialAward) do
            if _v.id == v.id then
                has = true
                if v.ct == EC_SChangeType.DELETE then
                    table.remove(activityInfo.data.specialAward,_k)
                else
                    activityInfo.data.specialAward[_k] = clone(v)
                end
                break;
            end
        end

        if not has then
            table.insert(activityInfo.data.specialAward,v)
        end
    end
    EventMgr:dispatchEvent(EV_ACTIVITY_UPDATE_HANGUP_SPECIALAWARD)
end

function ActivityDataMgr:onRecvSendHangUpRoleInfo( event )
    -- body
    local data = event.data
    if not data then return end

    local activityInfo = self:getActivityInfo(data.activityId)
    if (not activityInfo) or (not activityInfo.data) then return end

    for k,v in pairs(data.hangUpRoleInfo or {}) do
        local has 
        for _k,_v in pairs(activityInfo.data.hangUpRoleInfo) do
            if _v.roleId == v.roleId then
                has = true
                if v.ct == EC_SChangeType.DELETE then
                    table.remove(activityInfo.data.hangUpRoleInfo,_k)
                else
                    activityInfo.data.hangUpRoleInfo[_k] = clone(v)
                end
                break;
            end
        end

        if not has then
            table.insert(activityInfo.data.hangUpRoleInfo,v)
        end
    end
    EventMgr:dispatchEvent(EV_ACTIVITY_UPDATE_HANGUP_ROLEINFO)
end

function ActivityDataMgr:send_ACTIVITY_REQ_GET_HANG_UP_INFO( ... )
    -- body
    TFDirector:send(c2s.ACTIVITY_REQ_GET_HANG_UP_INFO,{ ... })
end

function ActivityDataMgr:send_ACTIVITY_REQ_UP_HANG_UP_ROLE_LEVEL( ... )
    -- body
    TFDirector:send(c2s.ACTIVITY_REQ_UP_HANG_UP_ROLE_LEVEL,{...})
end

function ActivityDataMgr:send_ACTIVITY_REQ_GET_HANG_UP_AWARD( ... )
    -- body
    TFDirector:send(c2s.ACTIVITY_REQ_GET_HANG_UP_AWARD,{ ... })
end

function ActivityDataMgr:send_ACTIVITY_REQ_GET_HANG_UP_SEVENT_AWARD( ... )
    -- body
    TFDirector:send(c2s.ACTIVITY_REQ_GET_HANG_UP_SEVENT_AWARD,{ ... })
end

function ActivityDataMgr:send_ACTIVITY_REQ_GET_HANG_UP_INFO( ... )
    -- body
    TFDirector:send(c2s.ACTIVITY_REQ_GET_HANG_UP_INFO,{ ... })
end

function ActivityDataMgr:send_ACTIVITY_REQ_UP_OR_DOWN_HANG_UP_ROLE( ... )
    -- body
    TFDirector:send(c2s.ACTIVITY_REQ_UP_OR_DOWN_HANG_UP_ROLE,{ ... })
end

function ActivityDataMgr:send_ACTIVITY_REQ_ACTIVITY_ITEM_REFRESH( ... )
    -- body
    TFDirector:send(c2s.ACTIVITY_REQ_ACTIVITY_ITEM_REFRESH,{...})
end

---------------春节挂机活动结束---------------------

-------------新年副本活动-----------------------
--副本数据信息
function ActivityDataMgr:Req2020FestivalInfo()
    TFDirector:send(c2s.SPRING_FESTIVAL_REQ2020_FESTIVAL_INFO,{})
end

--领取资源
function ActivityDataMgr:Req2020FestivalResource(dungeon, count, multiple)
    TFDirector:send(c2s.SPRING_FESTIVAL_REQ2020_FESTIVAL_RESOURCE,{dungeon, count, multiple})
end

--请求小游戏
function ActivityDataMgr:Req2020FestivalGameInit(city, area)
    self.gameCity,self.gameArea = city, area
    TFDirector:send(c2s.SPRING_FESTIVAL_REQ2020_FESTIVAL_GAME_INIT,{city, area})
end

--完成小游戏
function ActivityDataMgr:Req2020FestivalGameFinish(group, param)
    print(self.gameCity, self.gameArea,group)
    dump(param)
    if not self.gameCity or not self.gameArea then
        return
    end
    TFDirector:send(c2s.SPRING_FESTIVAL_REQ2020_FESTIVAL_GAME_FINISH,{self.gameCity, self.gameArea, group, param})
end

--活动副本信息
function ActivityDataMgr:onRespFestival2020Info(event)
    local data = event.data
    if not data then return end
    self.newYearFubenInfo = {}
    self.newYearFubenInfo.stage = data.stage
    self.newYearFubenInfo.stageEnd = data.stageEnd
    self.newYearFubenInfo.totalScore = data.totalScore
    self.newYearFubenInfo.round = data.round
    self.newYearFubenInfo.roundScore = data.roundScore
    self.newYearFubenInfo.cities = {}
    for i, city in ipairs(data.cities) do
        self.newYearFubenInfo.cities[city.id] = {}
        for j, areaInfo in ipairs(city.areas) do
            self.newYearFubenInfo.cities[city.id][areaInfo.area] = areaInfo
        end
    end
    EventMgr:dispatchEvent(EV_NEW_YEAR_FUBEN_INFO_UPDATE)
end

--城市信息刷新
function ActivityDataMgr:onRespFestival2020CityRefresh(event)
    if not self.newYearFubenInfo then
        self.newYearFubenInfo = {}
        self.newYearFubenInfo.cities = {}
    end
    local data = event.data
    if not data then return end
    for i, city in ipairs(data.cities) do
        self.newYearFubenInfo.cities[city.id] = self.newYearFubenInfo.cities[city.id] or {}
        if city.areas then
            for j, areaInfo in ipairs(city.areas) do
                self.newYearFubenInfo.cities[city.id][areaInfo.area] = areaInfo
            end
        end
    end
    EventMgr:dispatchEvent(EV_NEW_YEAR_FUBEN_INFO_UPDATE)
end

function ActivityDataMgr:getNewYearFubenInfo()
    return self.newYearFubenInfo
end


--获取城市节点数据
function ActivityDataMgr:getNewYearCityPointInfo(cityId)
    for k,v in pairs(self.newYearFubenInfo.cities) do
        if tonumber(k) == cityId then
            return v
        end
    end
end

--获取城市子节点数据
function ActivityDataMgr:getNewYearCitySubPointInfo(cityId,area)
    local cityInfo = self:getNewYearCityInfo(cityId)
    if cityInfo[area] then
        return cityInfo[area]
    end
end

function ActivityDataMgr:getNewYearCitySubPointInfoByDungeon(dungeon)
    for k,city in pairs(self.newYearFubenInfo.cities) do
        for p, area in pairs(city) do
            if area.dungeon == dungeon then
                return area
            end
        end
    end
end

--领取资源返回
function ActivityDataMgr:onRespFestival2020Resource(event)
    local data = event.data
    if data.rewards then
        Utils:showReward(data.rewards)
    end
end

--完成小游戏
function ActivityDataMgr:onRespFestival2020Finish(event)
    local data = event.data
    if not data then
        return
    end

    --data
        --status = 1;//游戏选项是否正确
        --game = 2;//游戏类型
        --cases = 3;//或许需要例子说明，备用字段
        --rewards = 4; //获得奖励
    EventMgr:dispatchEvent(EV_NEW_YEAR_GAME_FINISH,data)

end

function ActivityDataMgr:enterGame(data)

    local gameType = data.game
    if EC_NewYearGameType.Fish == gameType then
        Utils:openView("newYear.FishGame",data)
    elseif EC_NewYearGameType.Divine == gameType then
        Utils:openView("newYear.CardGame",data)
	elseif EC_NewYearGameType.Light == gameType then
		Utils:openView("activity.LightRiddles",data)
	elseif EC_NewYearGameType.Puzzle == gameType then
		Utils:openView("activity.JointPicture",data)
	elseif EC_NewYearGameType.Drink == gameType then
		Utils:openView("activity.ConcoctDrinks",data)
    end

end

--初始化小游戏
function ActivityDataMgr:onRespFestival2020GameInit(event)
    local data = event.data
    if not data then
        return
    end
        --game = 1;//游戏类型
        --group = 2;//组合id
        --result = 3;//答案
        --pool = 4;//选项池
    self:enterGame(data)
    --EventMgr:dispatchEvent(EV_NEW_YEAR_GAME_INIT,data)
end

function ActivityDataMgr:showGameResult(data)
    Utils:showReward(data.rewards,nil,nil,2460048)
end

----召回活动
function ActivityDataMgr:setCallBackInfo(info)
    self.callbackInfo = info
end

function ActivityDataMgr:getCallBackInfo()
    return self.callbackInfo
end

function ActivityDataMgr:ReqGetBeCallInfo(activityId)
    TFDirector:send(c2s.ACTIVITY_REQ_GET_BE_CALL_INFO,{activityId})
end

function ActivityDataMgr:ReqShareComplete(activityId)
    TFDirector:send(c2s.ACTIVITY_REQ_SHARE_COMPLETE,{activityId})
end

function ActivityDataMgr:ReqWriteBeCallPlayerId(activityId,uid)
    TFDirector:send(c2s.ACTIVITY_REQ_WRITE_BE_CALL_PLAYER_ID,{activityId,uid})
end

function ActivityDataMgr:sendReqActivityPrayTask(activityId, taskItemId)
    TFDirector:send(c2s.ACTIVITY_REQ_ACTIVITY_PRAY_TASK, {activityId, taskItemId})
end

function ActivityDataMgr:onRespCallBackInfo(event)

    local data = event.data
    if not data then
        return
    end
    self:setCallBackInfo(data)
    EventMgr:dispatchEvent(EV_ACTIVITY_CALL_BACK_INFO)
end

function ActivityDataMgr:onRespShareComplete(data)

end

function ActivityDataMgr:onRespSubmitUid(event)
    local data = event.data
    if not data then
        return
    end

    dump(data)
    ----0表示成功  其他去读string.csv里面的id
    local successCode = data.successCode
    if successCode == 0 then
        Utils:showTips(100000145)
        EventMgr:dispatchEvent(EV_ACTIVITY_CALL_BACK_BIND,true)
    else
        Utils:showTips(successCode)
    end
end

function ActivityDataMgr:onActivityItemRefreshRsp(data)

end

--------团购-------------
function ActivityDataMgr:initGPVariable()
	self.myGroupTeamInfo = nil
	self.groupPurchaseHallInfo = nil
	self.nextinvitServer = 10
	self.cdInternal = {}
	self.GPNeedUpate =  {}
end

function ActivityDataMgr:setNextinvitServer(cd)
	self.nextinvitServer = ServerDataMgr:getServerTime() + cd
end

function ActivityDataMgr:setGPUpdateVarible(tag, giftID)
	self.GPNeedUpate[giftID] = tag
end

function ActivityDataMgr:getGPUpdateVarible(giftID)
	return self.GPNeedUpate[giftID] or  true
end

function ActivityDataMgr:getNextinvitServer()
	return self.nextinvitServer
end



------收到创建团购----------
function ActivityDataMgr:onCreateGroupPurchase(evt)
	local data = {teamInfo = evt.data}
	dump(data)
	self:saveMyGroupPurchaseInfo(data)
	EventMgr:dispatchEvent(EV_GROUP_PURCHASE_CREATE)
end

--收到加入团购
function ActivityDataMgr:onJoinGroupPurchase(evt)
	self:saveMyGroupPurchaseInfo({teamInfo = evt.data})
	EventMgr:dispatchEvent(EV_GROUP_PURCHASE_JOIN, evt.data)
end

--其他人加入
function ActivityDataMgr:onOtherJoin(evt)
	print("其他人加入")
	dump(evt.data)
	self:saveMyGroupPurchaseInfo({teamInfo = evt.data})
	EventMgr:dispatchEvent(EV_GROUP_PURCHASE_OTHER_JOIN, evt.data)
end

function ActivityDataMgr:saveMyGroupPurchaseInfo(tab)
	if table.count(tab)== 0 then
		return;
	end
	local teamInfo = tab.teamInfo
	self.myGroupTeamInfo = self.myGroupTeamInfo or {}
	for k,v in pairs(teamInfo) do
		self.myGroupTeamInfo[v.teamId] = v
		self.myGroupTeamInfo[v.teamId].creator = {}
		self.myGroupTeamInfo[v.teamId].partner = {}
		for s,q in pairs(v.members) do
			if q.isCreator then
				table.insert(self.myGroupTeamInfo[v.teamId].creator, q)
			else
				table.insert(self.myGroupTeamInfo[v.teamId].partner, q)
			end
		end
	end
end

function ActivityDataMgr:getMyGroupPurchaseInfo(giftID)

	if giftID == nil then
		return self.myGroupTeamInfo
	end

	for k, v in pairs(self.myGroupTeamInfo or {}) do
		if v.giftId == giftID then
			return v
		end
	end

	return nil
end


function ActivityDataMgr:resetHallListData()
	self.groupPurchaseHallInfo = nil
end
--收到刷新列表消息
function ActivityDataMgr:onRefreshGroupPurchase(evt)
	--self.groupPurchaseHallInfo = evt.data
	self.groupPurchaseHallInfo = self.groupPurchaseHallInfo or {}
	self.groupPurchaseHallInfo[evt.data.giftId] = evt.data

	print("收到刷新列表消息")
	dump(self.groupPurchaseHallInfo)
	EventMgr:dispatchEvent(EV_GROUP_PURCHASE_REFRESH, self.groupPurchaseHallInfo)
end

function ActivityDataMgr:getGroupPurchaseHallInfo()
	return self.groupPurchaseHallInfo
end

function ActivityDataMgr:getGPHallInfo(type_, giftId)
	if self.groupPurchaseHallInfo == nil or self.groupPurchaseHallInfo[giftId] == nil then
		return;
	end
	local data = self.groupPurchaseHallInfo[giftId]
	local teamInfo;
	if type_ == EC_GroupType.ALL then
		teamInfo = data.allTeamInfos
	elseif type_ == EC_GroupType.Friend then
		teamInfo = data.friendTeamInfos
	end

	local ret = {}
	for i=1, #(teamInfo or {}) do 
		local team = teamInfo[i]
		if  team.isShow then
			table.insert(ret,  team)
		end
	end

	local playerId = MainPlayer:getPlayerId()
	--按合伙人数多少排序
	for key, val in pairs(ret) do 
		val.partnerNum = 0
		val.creator = {}
		val.partner = {}
		val.isMySelf = false
		for k,v in pairs(val.members) do
			if v.isCreator then
				table.insert(val.creator, v)
			else
				val.partnerNum = val.partnerNum + 1
				table.insert(val.partner, v)
			end

			if v.playerId == playerId then
				val.isMySelf = true
			end
		end
	end
	table.sort(ret, function(a, b)
		return a.partnerNum > b.partnerNum
	end)

	return ret
end

--收到领取团购
function ActivityDataMgr:onRecieveGroupPurchase(evt)
	EventMgr:dispatchEvent(EV_GROUP_PURCHASE_GET, evt.data)
end

function ActivityDataMgr:sendQueryGiftStatus()
	TFDirector:send(c2s.RECHARGE_REQ_GROUP_GIFT_INFO, {})
end

--收到取消团购
function ActivityDataMgr:onCancelGroupPurchase(evt)
	local teamId = evt.data["teamId"]
	self.myGroupTeamInfo[teamId] = nil
	EventMgr:dispatchEvent(EV_GROUP_PURCHASE_CANCEL, evt.data)
end

function ActivityDataMgr:onGetMyGroupPurchaseData(evt)  
	print("ActivityDataMgr:onGetMyGroupPurchaseData")
	dump(evt.data)
	self.myGroupTeamInfo = {}

	self:saveMyGroupPurchaseInfo(evt.data)

	EventMgr:dispatchEvent(EV_GROUP_PURCHASE_SELF, evt.data)
end

function ActivityDataMgr:onQueryGiftStatus(evt)
	self.giftStatus = {}

	for k, v in pairs(evt.data.giftInfos) do
		self.giftStatus[v.giftId] = v
	end

	EventMgr:dispatchEvent(EV_GROUP_PURCHASE_QUERY_GIFT)
end
function ActivityDataMgr:onDissolution(evt)
	local teamId = evt.data["teamId"]
	self.myGroupTeamInfo[teamId] = nil
	EventMgr:dispatchEvent(EV_GROUP_PURCHASE_DISSLUTION)
end

function ActivityDataMgr:onShowGroupInHall()
	EventMgr:dispatchEvent(EV_GROUP_PURCHASE_SHOW_HALL)
end


function ActivityDataMgr:getGiftStatus(giftId)
	if giftId then
		return self.giftStatus[giftId]
	end
	return self.giftStatus
end

function ActivityDataMgr:setGPActivityInfo(activityInfo)
	self.GPActivityInfo = activityInfo
end

function ActivityDataMgr:setTeamShowStatus(giftId, show)
	for k, v in pairs(self.myGroupTeamInfo) do
		if v.giftId == giftId then
			v.isShow = show
			break;
		end
	end
end

function ActivityDataMgr:getGPActivityInfo()
	return self.GPActivityInfo
end

function ActivityDataMgr:getGPTeamIdByGiftId(giftId)
	for k, v in pairs(self.myGroupTeamInfo) do
		if v.giftId == giftId then
			return v.teamId
		end
	end
	return nil
end


--劳动节活动
function ActivityDataMgr:requestLobarDayScore()
	TFDirector:send(c2s.ACTIVITY_REQ_UNION_LABOUR_SCORE, {})
end
function ActivityDataMgr:requestLobarConvert()
	TFDirector:send(c2s.ACTIVITY_REQ_UNION_LABOUR_CONVERT, {})
end

function ActivityDataMgr:requestLobarDayRank()
	TFDirector:send(c2s.ACTIVITY_REQ_UNION_LABOUR_RANK, {})
end

function ActivityDataMgr:onLobarDayScore(event)
	print("onLobarDayScore")
	dump(event.data)
	self.lobarDayTotalScore = event.data.totalScore or 0
	EventMgr:dispatchEvent(EV_LOBAR_DAY_SCORE_RECEIVE)
end

function ActivityDataMgr:onLobarDayRank(event)
	self.lobarDayRankData = event.data
	EventMgr:dispatchEvent(EV_LOBAR_DAY_RANK_RECEIVE)
end

function ActivityDataMgr:getLobarRank()
	return self.lobarDayRankData
end

function ActivityDataMgr:getLobarScore()
	return self.lobarDayTotalScore
end

function ActivityDataMgr:setCacheTaskSelect(index)
	self.lobarDayTaskSelect =index
end
function ActivityDataMgr:getCacheTaskSelect()
	local idx = self.lobarDayTaskSelect
	self.lobarDayTaskSelect = nil
	return idx
end

function ActivityDataMgr:onPhyscalConvert(event)
	self.LobarConvertData = event.data
	dump(event.data)
	EventMgr:dispatchEvent(EV_LOBAR_DAY_CONVERT_PROGRESS, self.LobarConvertData)
end

function ActivityDataMgr:getLobarConvertData()
	return self.LobarConvertData
end

function ActivityDataMgr:sendReqClickAdActivity(activityId, itemId, type)
    TFDirector:send(c2s.ACTIVITY_REQ_CLICK_AD_ACTIVITY, {activityId, itemId, type})
end

function ActivityDataMgr:isAdActivityOpen()
    local activity = self:getActivityInfoByType(EC_ActivityType2.AD_ACTIVITY)
    if #activity > 0 then
        local activityInfo = self:getActivityInfo(activity[1])
        for k, v in ipairs(activityInfo.items or {}) do
            local itemInfo = self:getItemInfo(activityInfo.activityType, v)
            local endTime = 0
            if itemInfo and itemInfo.extendData.endTime then
                endTime = itemInfo.extendData.endTime
            end
            if ServerDataMgr:getServerTime() <= endTime then
                return true
            end
        end
    end
    return false
end

--时之契约
function ActivityDataMgr:requestSZQYData(actId)
	TFDirector:send(c2s.ACTIVITY_REQ_TIME_CONTRACT, {actId})
end

function ActivityDataMgr:requestSZQYStep(actId)
	TFDirector:send(c2s.ACTIVITY_REQ_DICE_CONTRACT, {actId})
end

function ActivityDataMgr:requestResetSZQY(actId)
	TFDirector:send(c2s.ACTIVITY_REQ_REFRESH_CONTRACT, {actId})
end

function ActivityDataMgr:onSZQYData(evt)
	self.dataSZQY = evt.data
	self.dataSZQY.awardList = self.dataSZQY.awardList or {} 

	EventMgr:dispatchEvent(EV_SZQY_RESP_MAIN_DATA)
end

function ActivityDataMgr:onSZQYStep(evt)
	self.dataSZQYStep = evt.data
	EventMgr:dispatchEvent(EV_SZQY_RESP_STEP, evt.data)
end

function ActivityDataMgr:onResetSZQY(evt)	
	EventMgr:dispatchEvent(EV_SZQY_RESP_RESET)
end

function ActivityDataMgr:getSZQYRewards()
	return self.dataSZQY.awardList or {}
end

function ActivityDataMgr:getSZQYData()
	return self.dataSZQY or {}
end

function ActivityDataMgr:getCurrentRewards()
	local got = true	
	if self.dataSZQYStep then
		local locations = self.dataSZQYStep.locations
		if table.indexOf(self.dataSZQY.awardList, locations[#locations]) == -1 then
			table.insert(self.dataSZQY.awardList, locations[#locations])
			got = false
		end
	end
	return got
end

function ActivityDataMgr:checkReward(location)
	return table.indexOf(self.dataSZQY.awardList, location) == -1
end

--花嫁活动
function ActivityDataMgr:sendDressVoteComfirm(itemId, voteNum)
	TFDirector:send(c2s.ACTIVITY_REQ_VOTE_ACTIVITY, {itemId, voteNum})
end

function ActivityDataMgr:sendDressVoteUpdate()
	TFDirector:send(c2s.ACTIVITY_REQ_VOTE_ACTIVITY_INFO, {})
end

function ActivityDataMgr:sendDressVoteChange(itemId)
	if itemId == nil then
		return;
	end	
	TFDirector:send(c2s.ACTIVITY_REQ_CHANGE_VOTE_INFO, {itemId})
end

function ActivityDataMgr:onDressVoteSucess(evt)
	local data = evt.data

	self.dressVoteData[data.itemId].total = self.dressVoteData[data.itemId].total + data.addNum or 0

	local temp = {}
	for k, v in pairs(self.dressVoteData) do
		table.insert(temp,v)
	end
	self.dressVoteData = self:cfgDressVoteData(temp)
	EventMgr:dispatchEvent(EV_VOTE_DRESS_SUCESS, data)
end

function ActivityDataMgr:onDressVoteInfo(evt)
	local data = evt.data
	if data == nil then
		return
	end

	if data.voteInfo == nil or (data.voteInfo and #data.voteInfo == 0) then
		return
	end
	self.dressVoteData = self:cfgDressVoteData(data.voteInfo)
	EventMgr:dispatchEvent(EV_VOTE_DRESS_UPDATE, self.dressVoteData)
end


function ActivityDataMgr:cfgDressVoteData(info)
	local ret = {}
	for i = 1, #info do
		local newTotal = info[i].total or 0;
		local curTotal = 0
		if self.dressVoteData and self.dressVoteData[info[i].itemId] then
			curTotal = self.dressVoteData[info[i].itemId].total
		end
		if newTotal <= curTotal then
			newTotal = curTotal
		end
		ret[info[i].itemId] = {itemId = info[i].itemId, total = newTotal}
	end

	local temp = {}
	for k, v in pairs(ret) do
		table.insert(temp,v)
	end
	table.sort(temp,function(a, b)
		return a.total > b.total
	end)

	local index = 1
	for i = 1, #temp do
		ret[temp[i].itemId].sort = index
		index = index + 1
	end

	return ret
end

function ActivityDataMgr:getDressVoteData(itemId)
	return self.dressVoteData
end

function ActivityDataMgr:setDressVoteData(info)
	if not self.dressVoteFirstEnter then
		self.dressVoteData = self:cfgDressVoteData(info)
		self.dressVoteFirstEnter = true
	end
end

function ActivityDataMgr:onRecvAnnivDress(event)
    local data = event.data
    if not data then
        return
    end

    EventMgr:dispatchEvent(EV_UPDATE_TWOYEAR_FASHION, data)
end

function ActivityDataMgr:onRecvFreshAnnivDress(event)

end

--周年庆放飞气球相关逻辑
function ActivityDataMgr:sendReqFlyBalloon(items)
    TFDirector:send(c2s.ACTIVITY_REQ_FLY_BALLOON, {items})
end

--请求/取消好友交换气球
--operType操作类型 1 请求 2 取消
function ActivityDataMgr:sendReqExchangeApply(friendId, operType)
    TFDirector:send(c2s.ACTIVITY_REQ_EXCHANGE_APPLY, {friendId, operType})
end

--接受/拒绝好友交换气球邀请
--accept是否接受 true 接受 false 拒绝
--otherOption = 3;//其他选项 二进制或运算 1(1)不再接受对方 2(10)不再接受好友 3(11) 全部不接受
function ActivityDataMgr:sendReqDealFriendExchangeApply(friendId, accept, otherOption)
    TFDirector:send(c2s.ACTIVITY_REQ_DEAL_FRIEND_EXCHANGE_APPLY, {friendId, accept, otherOption})
end

--交易中主动取消交易
function ActivityDataMgr:sendReqCancelBalloonTrade(friendId)
    TFDirector:send(c2s.ACTIVITY_REQ_CANCEL_BALLOON_TRADE, {friendId})
end

--选中的气球id
--itemIds我选中的气球id
--confirm确认状态 true已确认 false 未确认
function ActivityDataMgr:sendReqSelectBalloonId(friendId, itemIds, confirm)
    TFDirector:send(c2s.ACTIVITY_REQ_SELECT_BALLOON_ID, {friendId, itemIds, confirm})
end

--确认交易
function ActivityDataMgr:sendReqConfirmTrade(friendId)
    TFDirector:send(c2s.ACTIVITY_REQ_CONFIRM_TRADE, {friendId})
end

--放飞气球成功返回
function ActivityDataMgr:onFlyBalloonSucc(event)
    local data = event.data

    local rewardLevel = data.rewardLevel or 1
    local stringId = 13317044 + rewardLevel - 1
    local rewards = data.rewards or {}
    Utils:showReward(rewards, nil, nil, stringId)
    EventMgr:dispatchEvent(EV_BALLOON_FLY_SUCC)
end

--返回好友交换气球请求
function ActivityDataMgr:onResExchangeApply(event)
    local data = event.data
    if data.operType == 2 then
        --交易前主动取消
        EventMgr:dispatchEvent(EV_BALLOON_EXCHANGE_CANCEL)
    else
        --请求发送成功
        Utils:openView("balloon.BalloonReqView", data)
    end
end

--对方收到交易的提示
function ActivityDataMgr:onExchangeBalloonNotify(event)
    local data = event.data
    if data.timeout > 0 then
        --收到交易的提示
        self:showBalloonNotifyLayer(data)
    else
        --对方交易前主动取消
        if self:isCanExchange() then
            Utils:showTips(13317049)
        end
        EventMgr:dispatchEvent(EV_BALLOON_EXCHANGE_CANCEL)
    end
end

function ActivityDataMgr:isCanExchange()
    local currentScene = Public:currentScene()
    if currentScene.__cname == "BattleScene" or DatingDataMgr:getIsDating() then 
        return false
    end

    return true
end

function ActivityDataMgr:showBalloonNotifyLayer(data)
    if not self:isCanExchange() or not data then return end
    local currentScene = Public:currentScene()
    local layer = requireNew("lua.logic.balloon.BalloonNotifyLayer"):new(data)
    layer:setName("BalloonNotifyLayer")
    currentScene:addChild(layer)
end

--接受/拒绝好友交换气球邀请
function ActivityDataMgr:onResDealFriendExchangeApply(event)
    EventMgr:dispatchEvent(EV_BALLOON_EXCHANGE_REPLY)
end

--通知对方弹交换面板
function ActivityDataMgr:onOpenExchangePanel(event)
    local data = event.data
    --true弹交易面板 false交易取消
    if data.result then
        Utils:openView("balloon.BalloonDealView", data.friendId)
    else
        --交易取消
        if self:isCanExchange() then
            Utils:showTips(13317050)
        end
    end
    EventMgr:dispatchEvent(EV_BALLOON_EXCHANGE_NOTIFY)
end

--更新选中的气球id
function ActivityDataMgr:onUpdateSelectBalloonId(event)
    local data = event.data

    EventMgr:dispatchEvent(EV_BALLOON_CHOOSE_UPDATE, data)
end

--确认交易结果
function ActivityDataMgr:onConfirmTrade(event)

end

--交换气球结果
function ActivityDataMgr:onBalloonExchangeResult(event)
    local data = event.data

    --result交换结果 1成功 2取消
    EventMgr:dispatchEvent(EV_BALLOON_EXCHANGE_RESULT, data)
end

--判断气球活动是否有可领取
function ActivityDataMgr:isBalloonTip()
    local activityIdList = self:getActivityInfoByType(EC_ActivityType2.BALLOON_ACTIVITY)
    if #activityIdList <= 0 then return false end
    return self:isCanGet(activityIdList[1])
end

function ActivityDataMgr:reqHalloweenPass( ... )
    -- body
    TFDirector:send(c2s.ACTIVITY_REQ_HALLOWEEN_PASS,{})
end

function ActivityDataMgr:onHalloweenPassRsp( event )
    -- body
    local data = event.data
    if not data then return end

    self.halloweenPass = data.passInfo
    EventMgr:dispatchEvent(EV_ACTIVITY_HALLOWEEN_PASS_RSP)
end

function ActivityDataMgr:getDungeonPassCount( dungeonId )
    -- body
    if not self.halloweenPass then return 0 end

    for k,v in ipairs(self.halloweenPass) do
        if v.dunId == dungeonId then 
            return v.passCount
        end
    end

    return 0
end

function ActivityDataMgr:getHalloweenUnableSuperBuffIds()
    local buffId = {}
    if not self.halloweenPass then return buffId end
    local ghostChatper = TabDataMgr:getData("GhostChapter")
    for k,cfg in pairs(ghostChatper) do
        local curPorgress = self:getDungeonPassCount(cfg.progressLevel)
        if curPorgress >= cfg.progressAmount then
            table.insert(buffId,cfg.unableBuff)
        end
    end
    return buffId
end


function ActivityDataMgr:Send_getGhostInfo()
    TFDirector:send(c2s.PLAYER_REQ_PHANTOM_INFO, {})
end

function ActivityDataMgr:Send_giveGift(ghostid,ghostPos,giftIndex)
    self.giftIndex = giftIndex
    TFDirector:send(c2s.PLAYER_REQ_PHANTOM_GIFT, {ghostid,giftIndex,ghostPos})
end

function ActivityDataMgr:GetGhostInfo()
    return self.ghostInfo or {}
end


function ActivityDataMgr:onRespGhostInfo(event)

    local data = event.data
    if not data then
        return
    end
    dump(data)

    ---data.phantomInfo :服务器默认是3个元素，没有鬼的话，phantomId = 0
    self.ghostInfo = {}
    for k,v in ipairs(data.phantomInfo or {}) do
        self.ghostInfo[v.pos] = v.phantomId
    end

    EventMgr:dispatchEvent(EV_ACTIVITY_UPDATE_PROGRESS)
    EventMgr:dispatchEvent(EV_PRE_HALLOWEEN_GHOST,data.type == 2)
end

function ActivityDataMgr:onRespGift(event)

    local data = event.data
    EventMgr:dispatchEvent(EV_PRE_HALLOWEEN_GIFT,data.rewardInfo or {},self.giftIndex)
end

function ActivityDataMgr:getActivityItemsInfoBySubType( id , subType )
    local index = self.activityInfoMap_[id]
    local activityInfo = self.activityInfo_[index]
    if not activityInfo then
        return {}
    end
    local itemInfos = {}
    local items = {}
    for i, v in ipairs(activityInfo.items) do
        local info = self:getItemInfo(activityInfo.activityType, v)
        if info and info.subType == subType then
            table.insert(itemInfos, info)
        end
    end
    return itemInfos
end


function ActivityDataMgr:send_ACTIVITY_REQ_DONATE_ACTIVITY(itemList )
    TFDirector:send(c2s.ACTIVITY_REQ_DONATE_ACTIVITY ,itemList)
end


function ActivityDataMgr:OnResDonateActivity( event)
    local data = event.data
    local index = self.activityInfoMap_[data.activityId]

    self.activityInfo_[index].extendData.donateRecord = self.activityInfo_[index].extendData.donateRecord or {}
    for datakey , dataValue in pairs(data.donateNum) do
        self.activityInfo_[index].extendData.donateRecord[tostring(dataValue.key)] = dataValue.value
    end


    EventMgr:dispatchEvent(EV_ACTIVITY_RES_DONATE_ACTIVITY , data)
end


function ActivityDataMgr:OnActivityUnionRankActScore( event )
    local data = event.data

    EventMgr:dispatchEvent(EV_ACTIVITY_RES_UNION_RANK_ACT_SCORE , data)
    
end

function ActivityDataMgr:OnActivityUnionItem(event)
    local data = event.data

    EventMgr:dispatchEvent(EV_ACTIVITY_RES_ACTIVITY_UNION_ITEM , data)
end


return ActivityDataMgr:new()
