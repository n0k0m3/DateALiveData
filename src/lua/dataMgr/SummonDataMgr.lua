
local BaseDataMgr = import(".BaseDataMgr")
local SummonDataMgr = class("SummonDataMgr", BaseDataMgr)

function SummonDataMgr:init()
    TFDirector:addProto(s2c.SUMMON_SUMMON, self, self.onRecvSummon)
    TFDirector:addProto(s2c.SUMMON_COMPOSE_SUMMON, self, self.onRecvComposeSummon)
    TFDirector:addProto(s2c.SUMMON_COMPOSE_FINISH, self, self.onRecvComposeReceive)
    TFDirector:addProto(s2c.SUMMON_RES_SUMMON_COMPOSE_SPEED, self, self.onRecvSpeedCompose)
    TFDirector:addProto(s2c.SUMMON_GET_COMPOSE_INFO, self, self.onRecvComposeInfo)
    TFDirector:addProto(s2c.SUMMON_NOTICE_COMPOSE_FINISH, self, self.onRecvComposeFinish)
    TFDirector:addProto(s2c.SUMMON_RES_HISTORY_RECORD, self, self.onRecvSummonHistory)
    TFDirector:addProto(s2c.SUMMON_SUMMON_PANEL_INFO, self, self.onRecvSummonPanelInfo)
    TFDirector:addProto(s2c.SUMMON_SUMMON_VALUE, self, self.onRecvSummonValue)
    TFDirector:addProto(s2c.SUMMON_RES_EXCHANGE, self, self.onRecvSummonExchange)
    TFDirector:addProto(s2c.SUMMON_RES_SUMMON_COUNT, self, self.onRecvSummonCountInfo)
    TFDirector:addProto(s2c.SUMMON_RES_NOOB_AWARD, self, self.onRecvNoobAward)
    TFDirector:addProto(s2c.INDENTURE_RSP_INDENTURE_INFO, self, self.onRecvSummonContractInfo)
    TFDirector:addProto(s2c.INDENTURE_RSP_ACTIVE_INDENTURE, self, self.onRecvBuildContractSuccess)
    TFDirector:addProto(s2c.SUMMON_RES_HOT_SUMMON_INFO, self, self.onRecvHotSpotSummonInfo)

    TFDirector:addProto(s2c.SUMMON_UPDATE_CARD_NUM, self, self.onRecvCardNum)
    TFDirector:addProto(s2c.SUMMON_UPDATE_DAY_TIMES, self, self.onRecvVoteDayNum)

    ---大世界召唤
    TFDirector:addProto(s2c.SUMMON_RES_NWSUMMON_INFO, self, self.onRecvNwSummonInfo)
    TFDirector:addProto(s2c.SUMMON_RES_SUMMON_REWARD, self, self.onRecvNwReward)

    ---预览信息
    TFDirector:addProto(s2c.SUMMON_RES_SUMMON_PREVIEW, self, self.onRecvSummonPreView)

    ---GM命令
    TFDirector:addProto(s2c.SUMMON_RES_RESULT_STATISTICS, self, self.onRecvResultStatistics)

    -- 周卡月卡特权免费信息
    TFDirector:addProto(s2c.SUMMON_RESP_FREE_SUMMON, self, self.onRecvCardPrivilegeInfo)
    TFDirector:addProto(s2c.SUMMON_RESP_TIME_FREE_SUMMON, self, self.onRecvFreeTimeInfo)


    self.summonComposeInfo_ = {}
    self.summonPannelInfo = {}

    -- 召唤玩法
    self.allSummon_ = {}
    self.agoraSummon_ = {}
    self.dlsSummon_ = {}
    self.teamSummon_ = {}
    self.bingoSummon_ = {}
    self.celebrationSummon_ = {}
    self.summon_ = {}
    self.summonCount_ = {}
    self.celebrationCount = {}
    self.dayVoteCount = {}
    self.celebrationPrize = {}
    self.cardPrivilegeInfo = {}
    self.preciousDic = {}
    self.summonMap_ = TabDataMgr:getData("Summon")
    local summon = {}
    for k, v in pairs(self.summonMap_) do
        summon[v.groupId] = summon[v.groupId] or {}
        table.insert(summon[v.groupId], {id = v.id,isOpen = true})
    end

    for k, v in pairs(summon) do
        table.sort(v, function(a, b)
                       local infoA = self.summonMap_[a.id]
                       local infoB = self.summonMap_[b.id]
                       return infoA.cardCount < infoB.cardCount
        end)
        local info = self.summonMap_[v[1].id]
        if info then
            print(info.interfaceType)
            local summonType = info.summonType
            if info.interfaceType == EC_SummonShowPlaceType.Summon_View then
                if summonType == EC_SummonType.DIAMOND then
                    self.newGuySummon_ = v
                elseif summonType ~= EC_SummonType.HOT_ROLE and summonType ~= EC_SummonType.HOT_EQUIPMENT then
                    table.insert(self.summon_, v)
                end
            elseif info.interfaceType == EC_SummonShowPlaceType.Agora_Lottery then
                table.insert(self.agoraSummon_, v)
            elseif info.interfaceType == EC_SummonShowPlaceType.DLS then
                table.insert(self.dlsSummon_, v)
            elseif info.interfaceType == EC_SummonShowPlaceType.Team then
                table.insert(self.teamSummon_, v)
            elseif info.interfaceType == EC_SummonShowPlaceType.BingoGame then
                table.insert(self.bingoSummon_,v)
            elseif info.interfaceType == EC_SummonShowPlaceType.CELEBRATION then
                table.insert(self.celebrationSummon_,v)
            end

            if summonType ~= EC_SummonType.HOT_ROLE and summonType ~= EC_SummonType.HOT_EQUIPMENT then
                table.insert(self.allSummon_, v)
            end
        end
    end
    table.sort(self.summon_, function(a, b)
                   local infoA1 = self.summonMap_[a[1].id]
                   local infoB1 = self.summonMap_[b[1].id]
                   return infoA1.order < infoB1.order
    end)

    table.sort(self.agoraSummon_, function(a, b)
        local infoA1 = self.summonMap_[a[1].id]
        local infoB1 = self.summonMap_[b[1].id]
        return infoA1.order < infoB1.order
    end)

    table.sort(self.allSummon_, function(a, b)
        local infoA1 = self.summonMap_[a[1].id]
        local infoB1 = self.summonMap_[b[1].id]
        return infoA1.order < infoB1.order
    end)

    -- 召唤预览
    self.summonPreview_ = {}
    self.summonPreviewMap_ = TabDataMgr:getData("SummonPreview")
    --for k, v in pairs(self.summonPreviewMap_) do
    --    local summonPreview = self.summonPreview_[v.groupId] or {}
    --    if v.type == EC_SummonPreviewType.CP or v.type == EC_SummonPreviewType.DP or v.type == EC_SummonPreviewType.PROBABILITY1 then
    --        local probability = summonPreview[v.type] or {}
    --        table.insert(probability, v.id)
    --        summonPreview[v.type] = probability
    --    else
    --        summonPreview[v.type] = v.id
    --    end
    --    self.summonPreview_[v.groupId] = summonPreview
    --end
    --for k, v in pairs(self.summonPreview_) do
    --    local cp = v[EC_SummonPreviewType.CP]
    --    if cp then
    --        table.sort(cp, function(a, b)
    --                       local cfgA = self.summonPreviewMap_[a]
    --                       local cfgB = self.summonPreviewMap_[b]
    --                       return cfgA.order < cfgB.order
    --        end)
    --    end
    --    local dp = v[EC_SummonPreviewType.DP]
    --    if dp then
    --        table.sort(dp, function(a, b)
    --                       local cfgA = self.summonPreviewMap_[a]
    --                       local cfgB = self.summonPreviewMap_[b]
    --                       return cfgA.order < cfgB.order
    --        end)
    --    end
    --
    --    local probability1 = v[EC_SummonPreviewType.PROBABILITY1]
    --    if probability1 then
    --        table.sort(probability1, function(a, b)
    --                       local cfgA = self.summonPreviewMap_[a]
    --                       local cfgB = self.summonPreviewMap_[b]
    --                       return cfgA.order < cfgB.order
    --        end)
    --    end
    --end

    -- 合成
    self.summonCompose_ = {}
    self.summonComposeMap_ = TabDataMgr:getData("SummonCompose")
    for k, v in pairs(self.summonComposeMap_) do
        self.summonCompose_[v.zPointType] = v
    end

    self.summonPool_ = {}
    self.summonPoolMap_ = TabDataMgr:getData("SummonPool")
    for k,cfg in pairs(self.summonCompose_) do
        for p, v in pairs(self.summonPoolMap_) do
            if cfg.poolType == v.poolType and v.type == 2 then
                local equipCfgs = self.summonPool_[cfg.poolType] or {}
                for itemCid,num in pairs(v.itemMap) do
                    local cfg = GoodsDataMgr:getItemCfg(itemCid)
                    if cfg.suit then
                        table.insert(equipCfgs, cfg)
                    end
                    break
                end
                self.summonPool_[cfg.poolType] = equipCfgs
            end
        end
    end

    self.celebrationPool_ = {}
    for k,v in pairs(self.summonPoolMap_) do
        if v.poolType == 4500 then
            local items = self.celebrationPool_[v.quality] or {}
            for itemCid,num in pairs(v.itemMap) do

                table.insert(items, {id = itemCid,num = num})
            end
            self.celebrationPool_[v.quality] = items
        end
    end

    for k,v in pairs(self.summonPool_) do
        table.sort(v,function(a,b)
            if a.star == b.star then
                return a.id < b.id
            end
            return a.star > b.star
        end)
    end

    -- 合成预览
    self.composePreviewMap_ = TabDataMgr:getData("SummonComposePreview")
    self.composePreview_ = {}
    for k, v in pairs(self.composePreviewMap_) do
        local point = self.composePreview_[v.subType] or {}
        table.insert(point, v)
        self.composePreview_[v.subType] = point
    end
    
    for k, points in ipairs(self.composePreview_) do
        table.sort(points, function(a, b)
            return a.order < b.order
        end)
    end
    self.score_ = 0


    ---萌新召唤
    self.SummonGiftCfg = {}
    local SummonGiftMap_ = TabDataMgr:getData("SummonGift")
    for k,v in pairs(SummonGiftMap_) do
        table.insert(self.SummonGiftCfg,v)
    end
    table.sort(self.SummonGiftCfg,function(a,b)
        return a.showOrder < b.showOrder
    end)

    -- 热点召唤
    self.summonLoopMap_ = TabDataMgr:getData("SummonLoop")
    self.summonLoop_ = {}
    for k, v in pairs(self.summonLoopMap_) do
        local loopType = self.summonLoop_[v.loopType] or {}
        loopType[v.loopId] = k
        self.summonLoop_[v.loopType] = loopType
    end

    self.dayVoteMax = Utils:getKVP(90006)

    self.ItemCanConverDic = {}
    for i, v in pairs(TabDataMgr:getData("Item")) do
        if v.convertMax and table.count(v.convertMax) ~= 0 then
            self.ItemCanConverDic[v.id] = 0
        end
    end
end

function SummonDataMgr:reset()
    self.summonComposeInfo_ = {}
    self.summonPannelInfo = {}
    self.summonCount_ = {}
    self.celebrationCount = {}
    self.dayVoteCount = {}
    self.celebrationPrize = {}
    self.cardPrivilegeInfo = {}
    self.summonFreeTime = {}
end

function SummonDataMgr:onLogin()
    self.summonPannelInfo = {}
    TFDirector:send(c2s.SUMMON_GET_COMPOSE_INFO, {})
    TFDirector:send(c2s.SUMMON_REQ_SUMMON_PANEL_INFO, {})
    TFDirector:send(c2s.SUMMON_REQ_SUMMON_COUNT, {})
    TFDirector:send(c2s.SUMMON_REQ_NWSUMMON_INFO, {})
    TFDirector:send(c2s.INDENTURE_REQ_INDENTURE_INFO, {})
    TFDirector:send(c2s.SUMMON_REQ_HOT_SUMMON_INFO, {})
    TFDirector:send(c2s.SUMMON_REQ_SUMMON_PREVIEW, {})
    TFDirector:send(c2s.SUMMON_REQ_FREE_SUMMON, {})
    --TFDirector:send(c2s.SUMMON_REQ_FREE_SUMMON_TIME, {})

    return {s2c.SUMMON_GET_COMPOSE_INFO, s2c.SUMMON_SUMMON_PANEL_INFO,
            s2c.SUMMON_RES_SUMMON_COUNT, s2c.SUMMON_RES_NWSUMMON_INFO,
            s2c.SUMMON_RES_SUMMON_PREVIEW,}
end

function SummonDataMgr:onEnterMain()

end

function SummonDataMgr:isShowRedPointInMainView()
    local isShow = false
    for i, v in ipairs(self.summonCompose_) do
        local isCanReceive = self:isCanReceiveComposeReward(v)
        if isCanReceive then
            isShow = true
            break
        end
    end
end

function SummonDataMgr:isCanReceiveComposeReward(pointType)
    local composeInfo = self:getSummonComposeInfo(pointType)
    local isReceive = false
    if composeInfo then
        local serverTime = ServerDataMgr:getServerTime()
        isReceive = serverTime >= composeInfo.finishTime
    end
    return isReceive
end

-- 是否有未完成的祈愿
function SummonDataMgr:isHaveNotCommplete()
    local _bool = false
    for i, v in pairs(self.summonComposeInfo_) do
        if v.finishTime > ServerDataMgr:getServerTime() then
            _bool = true
            break
        end
    end
    return _bool
end

function SummonDataMgr:isCanCompose(pointType)
    local composeCfg = self:getSummonCompose(pointType)
    local costItem = composeCfg.cost
    local isAllEnough = true
    for i, v in ipairs(costItem) do
        local isEnough = GoodsDataMgr:currencyIsEnough(v[1], v[2])
        isAllEnough = isAllEnough and isEnough
    end
    return isAllEnough
end

function SummonDataMgr:isComposing(pointType)
    local composeInfo = self:getSummonComposeInfo(pointType)
    local isCompose = false
    if composeInfo then
        isCompose = true
    end
    return isCompose
end

function SummonDataMgr:getSummonCompose(pointType)
    if pointType then
        return self.summonCompose_[pointType]
    else
        return self.summonCompose_
    end
end

function SummonDataMgr:getSummonComposeCfg(cid)
    return self.summonComposeMap_[cid]
end

function SummonDataMgr:getSummonLoopCfg(loopType, loopId)
    local cid = self.summonLoop_[loopType][loopId]
    return self.summonLoopMap_[cid]
end

function SummonDataMgr:getHotSummonEndTime(loopType)
    local endTime = self.hotSpotInfo_.heroHotSummonTime
    if loopType == EC_SummonLoopType.EQUIPMENT then
        endTime = self.hotSpotInfo_.equipHotSummonTime
    end
    return endTime
end

function SummonDataMgr:getSummon()
    local summon = clone(self.summon_)

    -- 萌新召唤单独处理
    local isNewGuy = self:isOpenNoob()
    if isNewGuy then
        table.insert(summon, self.newGuySummon_)
    end

    -- 热点召唤列表单独处理
    if self.hotSpotInfo_.heroHotSummonOrder then
        local hotSummon = self:getHotSummon(EC_SummonLoopType.ROLE)
        table.insert(summon, hotSummon)
    end

    table.sort(summon, function(a, b)
                   local infoA1 = self.summonMap_[a[1].id]
                   local infoB1 = self.summonMap_[b[1].id]
                   return infoA1.order < infoB1.order
    end)

    return summon
end

function SummonDataMgr:getAllSummon()

    local summon = clone(self.allSummon_)

    -- 热点召唤列表单独处理
    if self.hotSpotInfo_.heroHotSummonOrder then
        local hotSummon = self:getHotSummon(EC_SummonLoopType.ROLE)
        table.insert(summon, hotSummon)
    end

    table.sort(summon, function(a, b)
        local infoA1 = self.summonMap_[a[1].id]
        local infoB1 = self.summonMap_[b[1].id]
        return infoA1.order < infoB1.order
    end)

    return summon
end

function SummonDataMgr:getNoticeHotSummon(loopType)
    local count = Utils:getKVP(14008, "Notice")
    local summonLoop = self.summonLoop_[loopType]
    local maxOrder = #summonLoop
    local curOrder = self.hotSpotInfo_.heroHotSummonOrder
    if loopType == EC_SummonLoopType.EQUIPMENT then
        curOrder = self.hotSpotInfo_.equipHotSummonOrder
    end
    local summon = {}
    local endTime = {}
    local timestamp = self:getHotSummonEndTime(loopType)
    while true do
        local nextOrder = curOrder + 1
        if nextOrder > maxOrder then
            nextOrder = 1
        end
        curOrder = nextOrder
        local loopCfg = self:getSummonLoopCfg(loopType, nextOrder)
        for i, v in ipairs(loopCfg.summonId) do
            table.insert(summon, v)
            break
        end
        local date = TFDate(timestamp):adddays(loopCfg.days)
        local originTimestamp = timestamp
        timestamp = TFDate.diff(date, TFDate.epoch()):spanseconds()
        table.insert(endTime, {originTimestamp, timestamp})

        if #summon == count then
            break
        end
    end

    return summon, endTime
end

function SummonDataMgr:getHotSummon(type_)
    local summon = {}
    local loopCfg
    if type_ == EC_SummonLoopType.ROLE then
        loopCfg = self:getSummonLoopCfg(type_, self.hotSpotInfo_.heroHotSummonOrder)
    else
        loopCfg = self:getSummonLoopCfg(type_, self.hotSpotInfo_.equipHotSummonOrder)
    end

    for i, v in ipairs(loopCfg.summonId) do
        local summonCfg = self:getSummonCfg(v)
        table.insert(summon, {id = summonCfg.id, isOpen = true})
    end
    return summon
end

function SummonDataMgr:getHotSpotInfo()
    return self.hotSpotInfo_
end

function SummonDataMgr:getDlsSummon()
    return self.dlsSummon_
end

function SummonDataMgr:getTeamSummon()
    return self.teamSummon_
end

function SummonDataMgr:getBingoSummon()
    return self.bingoSummon_
end

function SummonDataMgr:getAgoraSummon()
    return self.agoraSummon_
end

function SummonDataMgr:getCelebrationSummon()
    return self.celebrationSummon_
end

function SummonDataMgr:getSummonCfg(summonCid)
    return self.summonMap_[summonCid]
end

function SummonDataMgr:getSummonPoolCfgs(pointType)
    local cfg = self.summonCompose_[pointType]
    return self.summonPool_[cfg.poolType]
end

function SummonDataMgr:getCelebrationPool(poolQuality)
    if not poolQuality then
        return self.celebrationPool_
    end
    return self.celebrationPool_[poolQuality]
end

function SummonDataMgr:getCelebrationPoolQuality(itemId,itemNum)

    local poolQuality = 1
    for k,items in pairs(self.celebrationPool_) do
        for _,v in ipairs(items) do
            if v.id == itemId and v.num == itemNum then
                poolQuality = k
                break
            end

            if v.id ~= itemId and v.num == itemNum then
                local itemCfg = GoodsDataMgr:getItemCfg(v.id)
                if itemCfg then
                    local useProfit = itemCfg.useProfit
                    local roll = useProfit.roll
                    if roll and roll.items then
                        for _,info in ipairs(roll.items) do
                            if info.id == itemId then
                                poolQuality = k
                                break
                            end
                        end
                    end
                end
            end
        end
    end
    return poolQuality

end

function SummonDataMgr:isExistSummonPool(poolType)

    for k,v in pairs(self.summonPoolMap_) do
        if v.poolType == poolType then
            return true
        end
    end

    return false

end

function SummonDataMgr:getSummonPreview(summonType)
    local sortWeight = {
        [EC_SummonPreviewType.AD] = 1,
        [EC_SummonPreviewType.HERO] = 2,
        [EC_SummonPreviewType.EQUIPMENT] = 3,
        [EC_SummonPreviewType.CP] = 4,
        [EC_SummonPreviewType.DP] = 5,
        [EC_SummonPreviewType.PROBABILITY1] = 6,
    }
    local summonPreview = self.summonPreview_[summonType]
    local keys = table.keys(summonPreview or {})
    table.sort(keys, function(a, b)
                   return sortWeight[a] < sortWeight[b]
    end)
    local rets = {}
    for i, v in ipairs(keys) do
        table.insert(rets, {type_ = v, data = summonPreview[v]})
    end
    return rets
end

function SummonDataMgr:getSummonComposeInfo(pointType)
    return self.summonComposeInfo_[pointType]
end

function SummonDataMgr:getSummonPreviewCfg(cid)
    return self.summonPreviewMap_[cid]
end

function SummonDataMgr:resetAlreadyHaveHero()
    self.haveHero_ = {}
    local heros = HeroDataMgr:getHero()
    for k, v in pairs(heros) do
        if HeroDataMgr:getIsHave(k) then
            table.insert(self.haveHero_, k)
        end
    end
end

function SummonDataMgr:isHaveHero(id)
    local index = table.indexOf(self.haveHero_, id)
    return index ~= -1
end

function SummonDataMgr:resetAlreadyHaveItem()
    for id, value in pairs(self.ItemCanConverDic) do
        self.ItemCanConverDic[id] = GoodsDataMgr:getItemCount(id)
    end
end

function SummonDataMgr:getItemOldNum(id)
    return self.ItemCanConverDic[id] or 0
end

function SummonDataMgr:getWishProb()
    local score = self.score_ * 0.0001
    local baseProb = Utils:getKVP(14002, "rareProbability")
    local prob = 0.01 * math.pow(score, 2) * 0.01 + baseProb * 0.0001
    return prob
end

function SummonDataMgr:getComposePreviewCfg(cid)
    return self.composePreviewMap_[cid]
end

function SummonDataMgr:getComposePreview(type_)
    if type_ then
        return self.composePreview_[type_]
    else
        return self.composePreview_
    end
end

-- 对应id的召唤按钮是否免费 
function SummonDataMgr:isFreeBtnById(id)
    local _bool = false
    local isHavePrivilege, _ = RechargeDataMgr:getIsHavePrivilegeByType(105)
    local cfg = self.summonMap_[id]

    if isHavePrivilege and cfg then
        local lastTime = self:getFreeTimeById(id) - ServerDataMgr:getServerTime()
        -- 特殊（热点召唤角色和质点或运算）
        if cfg.summonType == EC_SummonType.HOT_ROLE or cfg.summonType == EC_SummonType.HOT_EQUIPMENT then -- ..
            if self.cardPrivilegeInfo[EC_SummonType.HOT_ROLE] or self.cardPrivilegeInfo[EC_SummonType.HOT_EQUIPMENT] then
                dump(lastTime)
                if lastTime <= 0 then
                    _bool = true
                end
            else
                _bool = true
            end
        end
    end
    return _bool
end

-- 获取对应id免费召唤剩余时间
function SummonDataMgr:getFreeTimeById(id)
    local time = 0
    local cfg = self.summonMap_[id]
    if cfg then
        if cfg.summonType == EC_SummonType.HOT_ROLE or cfg.summonType == EC_SummonType.HOT_EQUIPMENT then
            if self.cardPrivilegeInfo[EC_SummonType.HOT_ROLE] then
                time = self.cardPrivilegeInfo[EC_SummonType.HOT_ROLE].nextFreeTime
            elseif self.cardPrivilegeInfo[EC_SummonType.HOT_EQUIPMENT] then
                time = self.cardPrivilegeInfo[EC_SummonType.HOT_EQUIPMENT].nextFreeTime
            end
        else
            if self.cardPrivilegeInfo[cfg.summonType] then
                 time = self.cardPrivilegeInfo[cfg.summonType].nextFreeTime
            end
        end
    end

    return time
end

function SummonDataMgr:resertSummon()
    for i,data in ipairs(self.summon_) do
        local cfg =  self:getSummonCfg(data[1].id)
        if cfg then
            if cfg.summonType == EC_SummonType.APPOINT_EQUIPMENT or
                cfg.summonType == EC_SummonType.APPOINT_HERO or
                cfg.summonType == EC_SummonType.CLOTHESE then
                data[1].isOpen = self:isInShowStage(data[1].id)
            elseif cfg.summonType == EC_SummonType.ELF_CONTRACT then
                data[1].isOpen = false
                if self:getSummonContractInfo().summonInfo then
                    local remainTime = math.max(self.summonContract.summonInfo.endTime - ServerDataMgr:getServerTime())
                    data[1].isOpen = remainTime > 0
                end
            end
        end

        table.sort(data, function(a, b)
            local cfgA = self:getSummonCfg(a.id)
            local cfgB = self:getSummonCfg(b.id)
            return cfgA.summonType < cfgB.summonType
        end)
    end

    for i,data in ipairs(self.agoraSummon_) do
        local cfg =  self:getSummonCfg(data[1].id)
        if cfg then
            if cfg.summonType == EC_SummonType.APPOINT_EQUIPMENT or
                    cfg.summonType == EC_SummonType.APPOINT_HERO then
                data[1].isOpen = self:isInShowStage(data[1].id)
            end
        end
    end

    for i,data in ipairs(self.allSummon_) do
        local cfg =  self:getSummonCfg(data[1].id)
        if cfg then
            if next(cfg.showStartDate) and next(cfg.showStartDate) and next(cfg.showStartDate) and next(cfg.showStartDate) then
                for j=1,2 do
                    if data[j] then
                        data[j].isOpen = self:isInShowStage(data[j].id)
                    end
                end
            else
                if cfg.summonType == EC_SummonType.ELF_CONTRACT then
                    for j=1,2 do
                        if data[j] then
                            data[j].isOpen = false
                            if self:getSummonContractInfo().summonInfo then
                                local remainTime = math.max(self.summonContract.summonInfo.endTime - ServerDataMgr:getServerTime())
                                data[j].isOpen = remainTime > 0
                            end
                        end
                    end
                elseif cfg.summonType == EC_SummonType.DIAMOND then
                    for j=1,2 do
                        if data[j] then
                            data[j].isOpen =self:isOpenNoob()
                        end
                    end
                end
            end
        end
    end

end

--得到服务器召唤活动
function SummonDataMgr:getServerSummonInfo(summonId)

    if not self.summonPannelInfo[summonId] then
        return
    end
    return self.summonPannelInfo[summonId]
end

function SummonDataMgr:isInShowStage(summonId)

    local summonPannelInfo = self.summonPannelInfo[summonId]
    if not summonPannelInfo then
        return false
    end

    local serverTime = ServerDataMgr:getServerTime()
    if serverTime >= summonPannelInfo.startShow  and serverTime <= summonPannelInfo.endShow then
        return true
    end

    return false

end

function SummonDataMgr:isInOpenStage(summonId)

    local summonPannelInfo = self.summonPannelInfo[summonId]
    if not summonPannelInfo then
        return false
    end

    local serverTime = ServerDataMgr:getServerTime()
    if serverTime >= summonPannelInfo.summstart  and serverTime <= summonPannelInfo.summend then
        return true
    end

    return false
end

function SummonDataMgr:isNewReward(summonId)

    local summonInfo = self.summonPannelInfo[summonId]
    if not summonInfo then
        return false
    end

    if not summonInfo.summonShow then
        return false
    end

    local rewardRecord = {}
    local geted = summonInfo.getRewards or {}
    for k,v in ipairs(geted) do
        rewardRecord[v] = 1
    end

    local curScore = summonInfo.remainScore or 0
    for k,v in pairs(summonInfo.summonShow) do
        local barValue = v.count
        if curScore >= barValue and (not rewardRecord[barValue]) then
            return true
        end
    end

    return false
end

function SummonDataMgr:getSummonCount(summonCid)
    local count = self.summonCount_[summonCid] or 0
    return count
end

function SummonDataMgr:getCelebrationCnt(summonCid)
    local count = self.celebrationCount[summonCid] or 0
    return count
end

function SummonDataMgr:getCelebrationPrize(summonCid)
    return self.celebrationPrize[summonCid] or {}
end

function SummonDataMgr:getDayVoteCnt(summonGroupId)

    local dayMax = self.dayVoteMax[summonGroupId] or 0
    local count = self.dayVoteCount[summonGroupId] or 0
    return count,dayMax
end

---------------- 萌新召唤 -----------------

function SummonDataMgr:getSummonGiftCfg()
    return self.SummonGiftCfg
end

function SummonDataMgr:getNoobInfo()
    return self.noobInfo
end

function SummonDataMgr:isOpenNoob()

    local curTime = ServerDataMgr:getServerTime()
    if self.noobInfo and self.noobInfo.endTime > curTime then
        return true
    end
    return false
end

function SummonDataMgr:setNoobInfo(noobInfo)
    self.noobInfo = noobInfo
end

-- 是否可以免费一键加速免费
function SummonDataMgr:isCanFreeAllApeedUp()
    local isHavePrivilege, cfg = RechargeDataMgr:getIsHavePrivilegeByType(102)
    return (isHavePrivilege and self.freeNum < cfg.privilege.chance)
end
----------------------------------------------------------

function SummonDataMgr:send_SUMMON_SUMMON(cid, costIndex)
    costIndex = costIndex - 1
    TFDirector:send(c2s.SUMMON_SUMMON, {cid, costIndex})
end

function SummonDataMgr:send_SUMMON_COMPOSE_SUMMON(cid)
    TFDirector:send(c2s.SUMMON_COMPOSE_SUMMON, {cid})
end

function SummonDataMgr:send_SUMMON_COMPOSE_FINISH(pointType)
    TFDirector:send(c2s.SUMMON_COMPOSE_FINISH, {pointType})
end

function SummonDataMgr:send_SUMMON_REQ_HISTORY_RECORD(type_)

    TFDirector:send(c2s.SUMMON_REQ_HISTORY_RECORD, {type_})
end

function SummonDataMgr:send_SUMMON_REQ_VALUE_AWARD(msg)

    TFDirector:send(c2s.SUMMON_REQ_VALUE_AWARD, msg)
end

function SummonDataMgr:send_SUMMON_REQ_EXCHANGE(msg)

    TFDirector:send(c2s.SUMMON_REQ_EXCHANGE, msg)
end

function SummonDataMgr:send_SUMMON_COMPOSE_SPEED(summonId)
    TFDirector:send(c2s.SUMMON_REQ_SUMMON_COMPOSE_SPEED, {summonId})
end

---领取萌新召唤奖励
function SummonDataMgr:send_SUMMON_GET_NOOB_AEARD(msg)
    TFDirector:send(c2s.SUMMON_REQ_NOOB_AWARD, msg)
end

function SummonDataMgr:onRecvSummon(event)
    local data = event.data
    if not data.item then return end
    self:setNoobInfo(data.noobInfo)
    self:setActiveIds(data.activeId)
    self.hotHeroSummonScore = data.hotHeroSummonScore
    self.hotEquipSummonScore = data.hotEquipSummonScore
    if data.freeInfo then
        self.cardPrivilegeInfo[data.freeInfo.type] = data.freeInfo
    end

    if data.freeTime then
        self.summonFreeTime = self.summonFreeTime or {}
        self.summonFreeTime[data.freeTime.type] = data.freeTime
    end

    if data.preciousCount then
        local summonType = self:getSummonCfg(data.id).summonType
        self.preciousDic[summonType] = data.preciousCount
    end

    EventMgr:dispatchEvent(EV_SUMMON_RESULT, data.item ,data.fixItem,data.id)
end

function SummonDataMgr:getSummonFreeTime( summonCfg )
    -- body
    if not summonCfg then return nil end
    local summonType = summonCfg.summonType
    local freeFuncTime = Utils:getKVP(90026,"etime")[summonType]
    if self.summonFreeTime and self.summonFreeTime[summonType] then
        local data = clone(self.summonFreeTime[summonType])
        if ServerDataMgr:getServerTime() >= freeFuncTime or data.nextFreeTime >= freeFuncTime then data.nextFreeTime = nil end
        data.summonNums = summonCfg.immortalGetTimes - data.summonNums + 1
        return data
    else
        if freeFuncTime then 
            if ServerDataMgr:getServerTime() < freeFuncTime then
                return {nextFreeTime = 0,summonNums = summonCfg.immortalGetTimes}
            else
                return {summonNums = summonCfg.immortalGetTimes}
            end

        end
    end
    return nil
end

function SummonDataMgr:getHotSummonRemainCount(loopType)
    local remainCount = 0
    if loopType == EC_SummonLoopType.ROLE then
        local totalCount = Utils:getKVP(14008, "hotspotScoreHero")
        remainCount = totalCount - self.hotHeroSummonScore
    else
        local totalCount = Utils:getKVP(14008, "hotspotScoreEquip")
        remainCount = totalCount - self.hotEquipSummonScore
    end
    return math.max(0, remainCount)
end

function SummonDataMgr:onRecvComposeSummon(event)
    local data = event.data
    if not data.composeInfo then return end
    local cfg = self:getSummonComposeCfg(data.composeInfo.cid)
    self.summonComposeInfo_[cfg.zPointType] = data.composeInfo
    EventMgr:dispatchEvent(EV_SUMMON_COMPOSE_UPDATE, cfg.zPointType)
end

function SummonDataMgr:onRecvSpeedCompose(event)
    local data = event.data
    if not data.composeInfo then return end
    for i, v in ipairs(data.composeInfo) do
        local cfg = self:getSummonComposeCfg(v.cid)
        self.summonComposeInfo_[cfg.zPointType] = v
    end
    if data.freeNum then
        self.freeNum = data.freeNum
    end
    EventMgr:dispatchEvent(EV_SUMMON_COMPOSE_UPDATE)
end

function SummonDataMgr:onRecvComposeFinish(event)
    local data = event.data
    for i, v in ipairs(data.cid) do
        local cfg = self:getSummonComposeCfg(v)
        EventMgr:dispatchEvent(EV_SUMMON_COMPOSE_UPDATE, cfg.zPointType)
    end
end

function SummonDataMgr:onRecvComposeReceive(event)
    local data = event.data
    self.score_ = data.score
    local rewards = data.item;--clone(self.summonComposeInfo_[data.zPointType].items)
    for k,v in pairs(rewards) do
        local subType = EquipmentDataMgr:getEquipSubType(v.id)
        self.summonComposeInfo_[subType] = nil
    end
    EventMgr:dispatchEvent(EV_SUMMON_COMPOSE_RECEIVE, data.zPointType, rewards)
end

function SummonDataMgr:onRecvComposeInfo(event)
    local data = event.data
    if data.composeInfos then
        for i, v in ipairs(data.composeInfos) do
            local cfg = self:getSummonComposeCfg(v.cid)
            self.summonComposeInfo_[cfg.zPointType] = v
        end
    end
    self.score_ = data.score or 0
    if data.freeNum then
        self.freeNum = data.freeNum
    end
end

function SummonDataMgr:onRecvSummonHistory(event)
    --type    [ 1 钻石召唤 2 友情召唤 3 指定召唤 4 精准质点 5 精准精灵]
    local data = event.data
    local history = {}
    if not data.historyRecords then
        return
    end

    EventMgr:dispatchEvent(EV_SUMMON_HISTORY, data.historyRecords)
end

function SummonDataMgr:onRecvSummonPanelInfo(event)
    local data = event.data
    if not data then
        return
    end

    if data.summonInfo then
        for k,info in ipairs(data.summonInfo) do
            local summonId = info.summonId
            if not self.summonPannelInfo then
                self.summonPannelInfo = {}
            end
            self.summonPannelInfo[summonId] = info
            self.celebrationCount[summonId] = info.cardNum or 0
            self.celebrationPrize[summonId] = info.cardPrizes or {}
            local summonCfg = self.summonMap_[summonId]
            if summonCfg then
                self.dayVoteCount[summonCfg.groupId] = info.dayTimes
            end
            if info.preciousCount then
                local summonType = self:getSummonCfg(info.summonId).summonType
                self.preciousDic[summonType] = info.preciousCount
            end
        end
    end

    --萌新召唤信息
    self:setNoobInfo(data.noobInfo)

    self:resertSummon()
    EventMgr:dispatchEvent(EV_SUMMON_PANEL_INFO)

end

function SummonDataMgr:onRecvSummonValue(event)

    local data = event.data
    if not data then
        return
    end

    local filterId = data.cidList or {}
    for summonId,info in pairs(self.summonPannelInfo) do
        local cfg = self:getSummonCfg(summonId)
        if cfg and cfg.summonType == data.summonType and table.indexOf(filterId, summonId) ~= -1 then
            info.summonNums = data.summonNums
            info.getRewards = data.getRewards
            info.count = data.count
            info.remainScore = data.remainScore
        end
    end
    local reward = {}
    if data.awards then
        for k,v in ipairs(data.awards) do
            table.insert(reward,{id = v.itemId,num = v.itemNums})
        end

        Utils:showReward(reward);
    end
    EventMgr:dispatchEvent(EV_SUMMON_UPATE_HERO)

end

function SummonDataMgr:onRecvSummonExchange(event)
    local data = event.data
    if not data then
        return
    end
    local reward = {}
    table.insert(reward,{id = data.itemCid,num = 1})
    Utils:showReward(reward)
    EventMgr:dispatchEvent(EV_SUMMON_UPATE_EQUIP)
end

function SummonDataMgr:onRecvSummonCountInfo(event)
    local data = event.data
    if data.info then
        for i, v in ipairs(data.info) do
            self.summonCount_[v.cid] = v.count
        end

        EventMgr:dispatchEvent(EV_SUMMON_COUNT_UPDATE)
    end
end

function SummonDataMgr:onRecvCardNum(event)

    local data = event.data
    if not data then
        return
    end
    self.celebrationCount[data.cid] = data.cardNum
    self.celebrationPrize[data.cid] = data.cardPrizes
    EventMgr:dispatchEvent(EV_SUMMON_CELEBRATION_COUNT)
end

function SummonDataMgr:onRecvVoteDayNum(event)

    local data = event.data
    if not data then
        return
    end
    self.dayVoteCount[data.cid] = data.dayTimes
    EventMgr:dispatchEvent(EV_UPDATE_VOTE_DAYNUM)

end

function SummonDataMgr:onRecvNoobAward(event)
    local data = event.data
    if not data then
        return
    end
    self:setNoobInfo(data.info)
    EventMgr:dispatchEvent(EV_UPDATE_NOOBAWARD,data.item)

end

----大世界召唤
function SummonDataMgr:isCanTeamSummon()

    local canSummon = false
    local teamSummon = self:getTeamSummon()
    for k,v in ipairs(teamSummon) do
        for i,info in ipairs(v) do
            local summonCfg = self:getSummonCfg(info.id)
            if summonCfg then
                for j, cost in ipairs(summonCfg.cost) do
                    local costId, costNum
                    for id, num in pairs(cost) do
                        costId = id
                        costNum = num
                        break
                    end
                    local ownNum = GoodsDataMgr:getItemCount(costId)
                    if costNum <= ownNum then
                        canSummon = true
                        break
                    end
                end
            end
        end
    end

    return canSummon
end

function SummonDataMgr:setActiveIds(activeIds)
    activeIds = activeIds or {}
    self.activeIds = activeIds
end

function SummonDataMgr:getActiveIds()
    return self.activeIds
end

function SummonDataMgr:getTargetCombination()
    return self.combination or {}
end

function SummonDataMgr:send_GetNwTargetAward()

    TFDirector:send(c2s.SUMMON_REQ_NWSUMMON_REWARD, {})
end

function SummonDataMgr:onRecvSummonPreView(event)
    local data = event.data
    if not data then
        return
    end
	
	local HAS11003 = false
    self.summonPreview_ = {}
    self.summonPreviewMap_ = {}
    local summonPreview = data.summonPreview or {}
    for k,v in pairs(summonPreview) do
        for _,info in ipairs(v.previewItems) do
            local tab = {}
            tab.groupId = v.groupId
            tab.type = v.type
            tab.typeName = v.typeName
            tab.id = info.id
            tab.order = info.order
            tab.name = info.name
            tab.probability = info.probability
            tab.noobProbability = info.noobProbability
            tab.showUpTips = info.showUpTips
            self.summonPreviewMap_[info.id] = tab
			if tab.groupId == 11003 or info.id == 11003 then
				HAS11003 = true
			end
            --table.insert(self.summonPreviewMap_,tab)
        end
    end
	
	print("-----------------------------------------------------------------------HAS11003=" .. tostring(HAS11003))

    for k, v in pairs(self.summonPreviewMap_) do
        local summonPreview = self.summonPreview_[v.groupId] or {}
        if v.type == EC_SummonPreviewType.CP or v.type == EC_SummonPreviewType.DP or v.type == EC_SummonPreviewType.PROBABILITY1 then
            local probability = summonPreview[v.type] or {}
            table.insert(probability, v.id)
            summonPreview[v.type] = probability
        else
            summonPreview[v.type] = v.id
        end
        self.summonPreview_[v.groupId] = summonPreview
    end
    for k, v in pairs(self.summonPreview_) do
        local cp = v[EC_SummonPreviewType.CP]
        if cp then
            table.sort(cp, function(a, b)
                           local cfgA = self.summonPreviewMap_[a]
                           local cfgB = self.summonPreviewMap_[b]
                           return cfgA.order < cfgB.order
            end)
        end
        local dp = v[EC_SummonPreviewType.DP]
        if dp then
            table.sort(dp, function(a, b)
                           local cfgA = self.summonPreviewMap_[a]
                           local cfgB = self.summonPreviewMap_[b]
                           return cfgA.order < cfgB.order
            end)
        end

        local probability1 = v[EC_SummonPreviewType.PROBABILITY1]
        if probability1 then
            table.sort(probability1, function(a, b)
                           local cfgA = self.summonPreviewMap_[a]
                           local cfgB = self.summonPreviewMap_[b]
                           return cfgA.order < cfgB.order
            end)
        end
    end
end

function SummonDataMgr:onRecvNwSummonInfo(event)

    local data = event.data
    if not data then
        return
    end
    self.combination = data.combination or {}
    EventMgr:dispatchEvent(EV_BW_RANDOM_TARGET)
end

function SummonDataMgr:onRecvNwReward(event)

    local data = event.data
    if not data then
        return
    end
    Utils:showReward(data.item)
end


function SummonDataMgr:onRecvSummonContractInfo(event)
    local data = event.data
    if not data then
        return
    end
    self.summonContract = data
    self:resertSummon()
    EventMgr:dispatchEvent(EV_SUMMON_PANEL_INFO)
    EventMgr:dispatchEvent(EV_UPDATE_SUMMONCONTRACT,data.item)
end

function SummonDataMgr:onRecvBuildContractSuccess( event )
    local data = event.data
    Utils:showTips(1325315)
end

function SummonDataMgr:onRecvHotSpotSummonInfo(event)
    local data = event.data
    if not data then return end

    self.hotSpotInfo_ = data
    self.hotHeroSummonScore = data.hotHeroSummonScore
    self.hotEquipSummonScore = data.hotEquipSummonScore
    EventMgr:dispatchEvent(EV_SUMMON_HOTSPLOT_UPDATE)
end

function SummonDataMgr:getSummonContractInfo( )
    return self.summonContract or {}
end

function SummonDataMgr:getCanBuildContract( )
    local cfg = TabDataMgr:getData("ContractSpirit",self.summonContract.taskIndenture)
    local playerLv = MainPlayer:getPlayerLv()
    local canBuy = false
    local preCfgHasFinish = true
    while cfg do
        if cfg.DemandLevel[1] <= playerLv then
            if not self.summonContract.actIndentures or table.find(self.summonContract.actIndentures,cfg.id)  == -1 then
                if preCfgHasFinish then
                    canBuy = true
                end
                break
            elseif cfg.NextStage ~= 0 then
                for k,v in pairs(cfg.items) do
                    local taskInfo = TaskDataMgr:getTaskInfo(v)
                    if not taskInfo or taskInfo.status ~= EC_TaskStatus.GETED then
                        preCfgHasFinish = false
                        break
                    end
                end
                cfg = TabDataMgr:getData("ContractSpirit",cfg.NextStage)
            else
                break
            end
        else
            break
        end
    end
    return canBuy, cfg
end

function SummonDataMgr:getShowTaskItemList( )
    local _Cfg = TabDataMgr:getData("ContractSpirit",1)

    while _Cfg do
        local hasNoFinish = false
        for k,v in pairs(_Cfg.items) do
            local taskInfo = TaskDataMgr:getTaskInfo(v)
            if not taskInfo or taskInfo.status ~= EC_TaskStatus.GETED then
                hasNoFinish = true
                break
            end
        end
        if _Cfg.NextStage == 0 or hasNoFinish then break end
        _Cfg = TabDataMgr:getData("ContractSpirit",_Cfg.NextStage)
    end
    return _Cfg
end

function SummonDataMgr:getCanGetTask(  )
    local cfg = self:getShowTaskItemList()
    local canGet = false
     for k,v in pairs(cfg.items) do
        local taskInfo = TaskDataMgr:getTaskInfo(v)
        if taskInfo and taskInfo.status == EC_TaskStatus.GET and table.find(self.summonContract.actIndentures,cfg.id) ~= -1 then
            canGet = true
            break
        end
    end
    return canGet
end

function SummonDataMgr:getAllTaskGetted( )
    local _Cfg = TabDataMgr:getData("ContractSpirit",1)

    local hasNoFinish = false
    while _Cfg do
        for k,v in pairs(_Cfg.items) do
            local taskInfo = TaskDataMgr:getTaskInfo(v)
            if not taskInfo or taskInfo.status ~= EC_TaskStatus.GETED then
                hasNoFinish = true
                break
            end
        end
        if _Cfg.NextStage == 0 or hasNoFinish then break end
        _Cfg = TabDataMgr:getData("ContractSpirit",_Cfg.NextStage)
    end
    return not hasNoFinish
end


----GM命令
function SummonDataMgr:getGmSummonResult()
    return self.poolId,self.poolCount,self.startTime,self.endTime
end

function SummonDataMgr:getGmSummonStatistics()
    return self.gmStatistics
end

-- 高级保底次数(用了的)
function SummonDataMgr:getPreciousCount(type)
   return self.preciousDic[type] or 0
end

function SummonDataMgr:onRecvResultStatistics(event)

    local data = event.data
    if not data then
        return
    end

    self.poolId = data.cid
    self.poolCount = data.count
    self.startTime = data.startTime
    self.endTime = data.endTime

    self.gmStatistics = data.statistics or {}

    EventMgr:dispatchEvent(EV_GM_SUMMON_RESULT)

end

function SummonDataMgr:getSummonPoolMapCfgs( summonPoolId)
    local id = tonumber(summonPoolId)
    return self.summonPoolMap_[id]
end

function SummonDataMgr:onRecvCardPrivilegeInfo(event)
    local data = event.data
    if not data then
        return
    end
    for i, v in ipairs(data.freeInfo or {}) do
        self.cardPrivilegeInfo[v.type] = v
    end
end

function SummonDataMgr:onRecvFreeTimeInfo(event)
    local data = event.data
    if not data then
        return
    end
    self.summonFreeTime = self.summonFreeTime or {}
    for i, v in ipairs(data.freeTimeSummon or {}) do
        self.summonFreeTime[v.type] = v
    end
    EventMgr:dispatchEvent(EV_PRIVILEGE_UPDATE)
end

return SummonDataMgr:new()
