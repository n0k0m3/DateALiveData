
local BaseDataMgr = import(".BaseDataMgr")
local BingoDataMgr = class("BingoDataMgr", BaseDataMgr)
local UserDefalt = CCUserDefault:sharedUserDefault()

function BingoDataMgr:registerMsgEvent()

    TFDirector:addProto(s2c.ACTIVITY_RESP_GET_PARADISE, self, self.onRecvUpdateActivity)
    TFDirector:addProto(s2c.ACTIVITY_RESP_START_GAME, self, self.onRecvUpdateGameResult)

end

function BingoDataMgr:onLogin()

    self:initBingoRuleId()
end

function BingoDataMgr:init()
    self:initData()
    self:registerMsgEvent()
end

function BingoDataMgr:initData()

    self:reset()

    ---解锁约会
    self.datingTab = {}
    self.evtDateCfgMap_ = {}
    self.evtDatingCfg = TabDataMgr:getData("EvtCarnivalDating")
    for k,v in ipairs(self.evtDatingCfg) do
        if v.unlockType == 1 then
            local gameId = v.condition.gameId
            if not self.datingTab[gameId] then
                self.datingTab[gameId] = {}
            end
            table.insert(self.datingTab[gameId],{ruleId = v.ruleId,resultType = v.condition.type})
        end
        self.evtDateCfgMap_[v.ruleId] = v
    end

    ---开牌配置
    self.luckyCardId = 1
    self.evtMinigaCardCfg = TabDataMgr:getData("EvtMinigaCard")
    for k,v in ipairs(self.evtMinigaCardCfg) do
        if v.isWin then
            self.luckyCardId = v.id
            break
        end
    end

    ---骰子配置
    self.diceOdds = {}
    self.evtMinigaDiceCfg = TabDataMgr:getData("EvtMinigaDice")
    for k,v in ipairs(self.evtMinigaDiceCfg) do
        if v.largeOdds ~= 0 then
            self.diceOdds[EC_DiceVoteType.Big] = v.largeOdds
        end
        if v.luckyOdds ~= 0 then
            self.diceOdds[EC_DiceVoteType.Baozi] = v.luckyOdds
        end
        if v.smallOdds ~= 0 then
            self.diceOdds[EC_DiceVoteType.Small] = v.smallOdds
        end
    end

    ---转盘配置
    self.wheelGroup = {}
    self.evtMinigaWheelCfg = TabDataMgr:getData("EvtMinigaWheel")
    for k,v in ipairs(self.evtMinigaWheelCfg) do
        if not self.wheelGroup[v.group] then
            self.wheelGroup[v.group] = v
        end
    end

    self.roleModelMotionCfg = TabDataMgr:getData("RoleModelMotion")

    self.evtMinigaCfg = {}
    self.oddsCoinInfo = {}
    self.topCoinInfo = {}
    local cfg = TabDataMgr:getData("EvtMiniga")
    for k,v in pairs(cfg) do
        self.evtMinigaCfg[v.id] = v

        if v.id == EC_BingoGameType.Main then
            self.oddsCoinInfo = v.gameParam.oddsCoin
            self.topCoinInfo = v.gameParam.topCoin
        end
    end

    ---召唤卡池显示
    local summonPool = TabDataMgr:getData("EvtMinigaAwardType")
    self.bingoSummonType = {}
    self.bingoSummonPool = {}
    for k,v in ipairs(summonPool) do
        local poolType = v.poolType
        local floor = v.itemTowerType
        if not self.bingoSummonPool[poolType] then
            self.bingoSummonPool[poolType] = {}
            table.insert(self.bingoSummonType,poolType)
        end

        if not self.bingoSummonPool[poolType][floor] then
            self.bingoSummonPool[poolType][floor] = {}
        end
        local tab = {}
        tab.itemId = v.itemId
        tab.id = v.id
        tab.state = false
        tab.count = v.count
        tab.showAction = v.showAction
        table.insert(self.bingoSummonPool[poolType][floor],tab)
    end

    self.chipItemId = Utils:getKVP(46036, "showItem")

    self.iconRes = {
        "icon/item/goods/".."500066.png",
        "icon/item/goods/".."500066_1.png",
        "icon/item/goods/".."500066_2.png",
    }

    -- 顶部结果页面是否打开
    self.isResultViewOpen = false
end


function BingoDataMgr:reset()

    self.chipNum = 0

    ---开放的卡池类型
    self.openPoolType = {}

    ---游戏结果记录
    self.voteResultInfo = {}

    ---转盘记录
    self.luckyWheelRecord = {}
end

function BingoDataMgr:getMiniGameCfg(gameType)
    return self.evtMinigaCfg[gameType]
end

function BingoDataMgr:getChipItemId(gameType)
    if not self.evtMinigaCfg[gameType] then
        return
    end
    return self.evtMinigaCfg[gameType].price
end

function BingoDataMgr:getOddIcon(num)

    local index = 1
    for i=#self.oddsCoinInfo,1,-1 do
        if num >= self.oddsCoinInfo[i] then
            index = i
            break
        end
    end
    return self.iconRes[index]
end

function BingoDataMgr:getTopIcon(num)
    local index = 1
    for i=#self.topCoinInfo,1,-1 do
        if num >= self.topCoinInfo[i] then
            index = i
            break
        end
    end
    return self.iconRes[index]
end

function BingoDataMgr:getBingoWheelCfg(cid)

    if cid then
        return self.evtMinigaWheelCfg[cid]
    end

    return self.evtMinigaWheelCfg
end

function BingoDataMgr:getWheelGroupInfo(groupId)
    return self.wheelGroup[groupId]
end

function BingoDataMgr:getDiceCfg(cid)
    return self.evtMinigaDiceCfg[cid]
end

function BingoDataMgr:getDiceOddsByType(diceType)
    return self.diceOdds[diceType]
end

function BingoDataMgr:getBingoLuckyCardId()
    return self.luckyCardId
end

function BingoDataMgr:getBingoCardCfg(id)
    if id then
        return self.evtMinigaCardCfg[id]
    end
    return self.evtMinigaCardCfg
end

function BingoDataMgr:getEvtDatingCfg(cid)
    if cid then
        return self.evtDatingCfg[cid]
    end
    return self.evtDatingCfg
end

function BingoDataMgr:getRoleModelMotionCfg(cid)
    return self.roleModelMotionCfg[cid]
end


function BingoDataMgr:getEvtDatingCfgByRuleId(ruleId)
    return self.evtDateCfgMap_[ruleId]
end

function BingoDataMgr:getBingoSummonPoolType()
    return self.bingoSummonType
end

function BingoDataMgr:getBingoSummonPool(poolType,floor)

    if not self.bingoSummonPool[poolType] then
        return
    end
    if not self.bingoSummonPool[poolType][floor] then
        return
    end
    return self.bingoSummonPool[poolType][floor]
end

function BingoDataMgr:getVoteResultInfo(gameType)

    if not self.voteResultInfo[gameType] then
        return
    end
    return self.voteResultInfo[gameType]
end

function BingoDataMgr:isSummonAll(poolType,floorId)

    if not floorId then
        for i=1,4 do
            local items = self:getBingoSummonPool(poolType,i)
            for k,v in ipairs(items) do
                if not v.state  then
                    return false
                end
            end
        end
    else
        local items = self:getBingoSummonPool(poolType,floorId)
        for k,v in ipairs(items) do
            if not v.state  then
                return false
            end
        end
    end

    return true
end

---得到道具的所属奖池层ID
function BingoDataMgr:getSummonFloorId(poolType,itemId)

    for i=1,4 do
        local items = self:getBingoSummonPool(poolType,i)
        for k,v in ipairs(items) do
            if v.itemId == itemId then
                return i
            end
        end
    end

end

function BingoDataMgr:getLuckyId(poolType,itemId)

    for k,v in pairs(self.bingoSummonPool) do
        if poolType == k then
            for floor,items in pairs(v) do
                for _,item in ipairs(items) do
                    if not item.state  and itemId == item.itemId then
                        return item.id
                    end
                end
            end
        end
    end
end

---更新卡池数据
function BingoDataMgr:updateSummonItemState(poolType,itemId)

    for k,v in pairs(self.bingoSummonPool) do
        if poolType == k then
            for floor,items in pairs(v) do
                for _,item in ipairs(items) do
                    if not item.state  and itemId == item.itemId then
                        item.state = true
                        return item.id
                    end
                end
            end
        end
    end
end

---判断奖池道具是否抽中
function BingoDataMgr:summonItemIsWin(poolType,floorId,id)

    local items = self:getBingoSummonPool(poolType,floorId)
    if not items then
        return
    end
    for k,v in ipairs(items) do
        if v.state and v.id == id then
            return true
        end
    end
    return false
end

function BingoDataMgr:getChipNum()
    return self.chipNum or 0
end

function BingoDataMgr:setChipNum(chipNum)
    self.chipNum = chipNum
end

function BingoDataMgr:getChipItemNum()
    self.chipNum = GoodsDataMgr:getItemCount(self.chipItemId)
    return self.chipNum
end

----刷新召唤记录
function BingoDataMgr:onRecvBingoSummonResult()

end


function BingoDataMgr:getDateRuleIdsByGameId(gameId)
    return self.datingTab[gameId]
end

function BingoDataMgr:playDatingCfg(gameId,resultType)

    local datingRuleIds = self:getDateRuleIdsByGameId(gameId)
    for k,v in ipairs(datingRuleIds) do
        if v.resultType == resultType then
            local isUnlock = self:isUnLockDating(v.ruleId)
            if isUnlock then
                self:playCg(v.ruleId)
                break
            end
        end
    end

end

---是否解锁约会
function BingoDataMgr:isUnLockDating(ruleId,resultType)

    local cfg = self:getEvtDatingCfgByRuleId(ruleId)
    if not cfg then
        return
    end

    if cfg.unlockType == 0 then
        return true
    end

    local condition = cfg.condition
    local resultInfo =  self:getVoteResultInfo(condition.gameId)
    if not resultInfo then
        return
    end

    local finishCnt = condition.type == EC_UnlockType.win and resultInfo.winNum or resultInfo.loseNum
    return finishCnt >= condition.times

end

function BingoDataMgr:playCg(ruleId)
    --9101001
    --做记录
    if self.saveInfo[ruleId] then
        return
    end
    self:saveBingoRuleId(ruleId)
    DatingDataMgr:startDating(ruleId)
end

function BingoDataMgr:saveBingoRuleId(ruleId)

    if self.saveInfo[ruleId] then
        return
    end
    self.saveInfo[ruleId] = 1
    local pid = MainPlayer:getPlayerId()
    local saveStr = UserDefalt:getStringForKey("BingoDating"..pid)
    saveStr = saveStr.."|"..ruleId
    UserDefalt:setStringForKey("BingoDating"..pid,saveStr)
    UserDefalt:flush()
end

function BingoDataMgr:initBingoRuleId()
    self.saveInfo = {}
    local pid = MainPlayer:getPlayerId()
    local saveStr = UserDefalt:getStringForKey("BingoDating"..pid)
    if saveStr == "" then
        return
    end
    local saveInfo = string.split(saveStr,"|")
    for k,v in ipairs(saveInfo) do
        if v ~= "" then
            self.saveInfo[tonumber(v)] = 1
        end
    end
end

function BingoDataMgr:isOpenPool(poolType)
    return self.openPoolType[poolType]
end

---发送消息
function BingoDataMgr:Send_enterBingGame()
    TFDirector:send(c2s.ACTIVITY_REQ_GET_PARADISE, {})
end

function BingoDataMgr:Send_openBingoGame(gametype,param)
    TFDirector:send(c2s.ACTIVITY_REQ_START_GAME, {gametype,param})
end

function BingoDataMgr:getOpenRewards()
    return self.rewards
end

function BingoDataMgr:getOpenInfomation()
    return self.infomation
end

function BingoDataMgr:getWinType()
    return self.winType
end


function BingoDataMgr:openResult(isPositive,victoryAppearId,callback)
    self.ResultView = require("lua.logic.bingo.BingoResultView")
    self.ResultView = self.ResultView:new(isPositive,victoryAppearId,callback)
    AlertManager:addLayer(self.ResultView,AlertManager.NONE)
    AlertManager:show()
    self:refreshResultViewState()
end

function BingoDataMgr:refreshResultViewState()
    self.isResultViewOpen = not self.isResultViewOpen
end

function BingoDataMgr:checkResultViewState()
    if self.ResultView and self.isResultViewOpen then
        AlertManager:closeLayer(self.ResultView)
        self:refreshResultViewState()
    end
end

---刷新活动信息
function BingoDataMgr:onRecvUpdateActivity(event)

    local data = event.data
    if not data then
        return
    end

    local ct = data.ct

    ---开放的卡池类型
    local drawId = data.drawId or {}
    for k,v in ipairs(drawId) do
        self.openPoolType[v] = 1
    end

    ---约会记录
    local dating = data.dating or {}
    for k,v in ipairs(dating) do
        if not self.voteResultInfo[v.type] then
            self.voteResultInfo[v.type] = {}
        end
        self.voteResultInfo[v.type].winNum = v.winNum or 0
        self.voteResultInfo[v.type].loseNum = v.loseNum or 0
    end

    ---转盘记录
    local luckyPoolType,luckyItemId
    local drawRecord = data.drawRecord or {}
    local luckyId
    for k,v in ipairs(drawRecord) do
        for k,item in ipairs(v.drawRecord) do
            for i=1,item.num do
                if ct == EC_SChangeType.DEFAULT then
                    self:updateSummonItemState(v.drawId,item.itemId)
                elseif ct == EC_SChangeType.ADD then
                    luckyId = self:getLuckyId(v.drawId,item.itemId)
                    luckyPoolType = v.drawId
                    luckyItemId = item.itemId
                end
            end
        end
    end
    dump(data)
    if ct == EC_SChangeType.ADD then
        EventMgr:dispatchEvent(EV_BINGOGAME_SUMMON,luckyPoolType,luckyItemId,luckyId)
    end

end

function BingoDataMgr:setTestParam(id)
    local item = {}
    table.insert(item,{itemId = id,num = 1})
    local luckyId = self:getLuckyId(32,id)
    print(luckyId)
    EventMgr:dispatchEvent(EV_BINGOGAME_SUMMON,32,id,luckyId)
end

function BingoDataMgr:setTestParamX()
    self.voteResultInfo[EC_BingoGameType.Dice].winNum = 5
end

function BingoDataMgr:setTestParamy()
    self.voteResultInfo[EC_BingoGameType.Dice].loseNum = 5
end

function BingoDataMgr:setTypeTest()
    self.openPoolType[33] = 1
    EventMgr:dispatchEvent(EV_BINGOGAME_SUMMON,luckyPoolType,luckyItemId,luckyId)
end

---游戏抽奖结果
function BingoDataMgr:onRecvUpdateGameResult(event)

    local data = event.data
    if not data then
        return
    end

    if not self.voteResultInfo[data.type] then
        self.voteResultInfo[data.type] = {}
    end
    self.voteResultInfo[data.type].winNum = data.winNum or 0
    self.voteResultInfo[data.type].loseNum = data.loseNum or 0

    self.rewards = data.rewards or {}
    self.infomation = data.infomation or {}
    self.winType = data.winType or {}

    dump(data)

    EventMgr:dispatchEvent(EV_BINGOGAME_RESULT)

end

function BingoDataMgr:getChipGoodsId()
    return self.chipItemId
end

return BingoDataMgr:new()
