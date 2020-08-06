
local BaseDataMgr = import(".BaseDataMgr")
local SkyLadderDataMgr = class("SkyLadderDataMgr", BaseDataMgr)
local UserDefalt = CCUserDefault:sharedUserDefault()

function SkyLadderDataMgr:init()
    self:initData()
    self:registerMsgEvent()
end

function SkyLadderDataMgr:initData()

    self.rankMatchCfg = TabDataMgr:getData("RankMatch")

    self.maxFloor = {}
    self.rankMatchLevelByFloor = {}
    self.RankMatchLevelCfg = TabDataMgr:getData("RankMatchLevel")
    for k,v in pairs(self.RankMatchLevelCfg) do
        if not self.rankMatchLevelByFloor[v.rankID] then
            self.rankMatchLevelByFloor[v.rankID] = {}
            self.maxFloor[v.rankID] = 0
        end

        if not self.rankMatchLevelByFloor[v.rankID][v.floors] then
            self.rankMatchLevelByFloor[v.rankID][v.floors] = {}
            self.maxFloor[v.rankID] = self.maxFloor[v.rankID] + 1
        end
        table.insert(self.rankMatchLevelByFloor[v.rankID][v.floors],v)
    end

    self.DungeonLevelCfg = TabDataMgr:getData("DungeonLevel")

    self.rankName = {
        {cn = 3202001,en = "Bronze"},
        {cn = 3202002,en = "Silver"},
        {cn = 3202003,en = "Gold"},
        {cn = 3202004,en = "Platinum"},
        {cn = 3202005,en = "Diamond"},
        {cn = 3202006,en = "Honour"},
    }

    ---六边形顺时针顺序，中心点下标为7
    self.rankMatchLevelPos = {
        ccp(62,296),
        ccp(164,475),
        ccp(380,475),
        ccp(478,296),
        ccp(380,117),
        ccp(164,117),
        ccp(272,296),
    }

    self.rankMatchBuffCfg = TabDataMgr:getData("RankMatchBuff")

    self.rankMatchCardCfg = TabDataMgr:getData("RankMatchCard")

    self.rankCardConvertMap = {}
    for k,v in pairs(self.rankMatchCardCfg) do
        for convertId,_ in pairs(v.convertMax) do
            self.rankCardConvertMap[convertId] = k
        end
    end

    self.kvpData  = Utils:getKVP(61005)
    --self.curSeasonNum = Utils:getKVP(61004).season.numberClient
    self:reset()
end

function SkyLadderDataMgr:registerMsgEvent()

    TFDirector:addProto(s2c.LADDER_RSP_LADDER_INFO, self, self.onRecvLadderInfo)
    TFDirector:addProto(s2c.LADDER_RSP_LADDER_RANK_LIST, self, self.onRecvLadderRankList)
    TFDirector:addProto(s2c.LADDER_RSP_LADDER_HERO_LIST, self, self.onRecvLadderHeroList)
    TFDirector:addProto(s2c.LADDER_RSP_LADDER_LAST_DATA, self, self.onRecvLastCircleData)
    TFDirector:addProto(s2c.LADDER_RSP_TAKE_OFF_LADDER_EQUIP, self, self.recvHandleEquip)
    TFDirector:addProto(s2c.LADDER_RSP_LADDER_EQUIP, self, self.recvHandleEquip)
    TFDirector:addProto(s2c.LADDER_RSP_LADDER_NEW_EQUIP, self, self.recvHandleNewEquip)
    TFDirector:addProto(s2c.LADDER_RSP_LADDER_BOUND_STUFFS, self, self.onRecvUpdateBindingStuffs)
    TFDirector:addProto(s2c.LADDER_RSP_REFRESH_LADDER_CARDS, self, self.onRecvUpdateCards)
    TFDirector:addProto(s2c.LADDER_RSP_UPGRADE_LADDER_CARD, self, self.onRecvUpgradeCards)
    TFDirector:addProto(s2c.LADDER_RSP_PLANT_LADDER_CARD, self, self.onRecvCardFormation)
    TFDirector:addProto(s2c.LADDER_RSP_REFRESH_LADDER_HERO_COUNT, self, self.onRecvUpdateHeroCount)
    TFDirector:addProto(s2c.LADDER_RSP_REFRESH_LADDER_CARD_COUNT, self, self.onRecvUpdateCardCount)
    TFDirector:addProto(s2c.LADDER_RSP_LADDER_DUNGEON_LEVEL, self, self.onRecvUpdateLevelInfo)

end

function SkyLadderDataMgr:onLogin()

    TFDirector:send(c2s.LADDER_REQ_LADDER_INFO, {})
    return {s2c.LADDER_RSP_LADDER_INFO}
end

function SkyLadderDataMgr:reset()

    self.proceedTime = 0
    self.nextStepTime = 0
    self.raceEndTime = 0
    self.regionBuffs = {}
    self.battleScore = 0

    self.skyLadderRankList = {}
    self.skyLadderHero = {}

    self.boundEquips = {}
    self.keepSake = {}

    self.passLevel = {}
    self.passFloor = {}

    self.heroFightCnt = {}
    self.cardFightCnt = {}

    self.usingCards = {}

    self.ownedCards_ = {}
    self.ownCardsMap_ = {}

    self.showMainView = false

    self.curHundred ={}
    self.lastHundred = {}

end

function SkyLadderDataMgr:getSkyLadderBuff()

    local skyLadderBuff = {}
    --区域buff
    local buffs = self:getRegionBuffs()
    for k,v in pairs(buffs) do
        table.insert(skyLadderBuff,v)
    end

    --卡牌效果
    local usingCards = self:getUsingCards()
    for k,v in ipairs(usingCards) do
        local cardInfo = self:getOwnedCardByID(v)
        local cardCfg = self:getRankMatchCardCfg(v)
        if cardCfg and cardInfo then
            local buffCid = cardCfg.skill[cardInfo.cardLv]
            if buffCid then
                table.insert(skyLadderBuff,buffCid)
            end
        end
    end

    --boss效果
    local bossBuffs = self:getBossBuffs()
    if bossBuffs then
        table.insert(skyLadderBuff,bossBuffs)
    end

    --流血效果
    local curCircleInfo = self:getCurCircleInfo()
    if curCircleInfo then
        local rankMatchCfg = self:getRankMatchCfg(curCircleInfo.segment)
        if rankMatchCfg and rankMatchCfg.bleedBuff >0 then
            table.insert(skyLadderBuff,rankMatchCfg.bleedBuff)
        end
    end

    return skyLadderBuff
end

function SkyLadderDataMgr:getDungeonLevelCfg(levelCid)
    return self.DungeonLevelCfg[levelCid]
end

function SkyLadderDataMgr:getRankMatchLevelCfg(levelCid)
    return self.RankMatchLevelCfg[levelCid]
end

function SkyLadderDataMgr:getRankMatchCfg(cid)

    if not cid then
        return self.rankMatchCfg
    end

    return self.rankMatchCfg[cid]
end

function SkyLadderDataMgr:getRankMatchBuff(cid)

    return self.rankMatchBuffCfg[cid]
end

function SkyLadderDataMgr:getMaxLevelFloor(rankId)
    return self.maxFloor[rankId]
end

function SkyLadderDataMgr:getRankLevelByFloor(subRankId,floor)
    return self.rankMatchLevelByFloor[subRankId][floor]
end

function SkyLadderDataMgr:getRankName(rankType)
    return self.rankName[rankType]
end

function SkyLadderDataMgr:getLevelItemPos(positionOrder)
    return self.rankMatchLevelPos[positionOrder]
end

function SkyLadderDataMgr:getCurSeasonNum()
    return self.curSeasonNum or 1
end

function SkyLadderDataMgr:getCardEquipMaxCost()

    --[[local maxCost = self.kvpData.originalCost
    local curSubRankId = self:getCurSubRankId()
    local rankMatchCfg = self:getRankMatchCfg(curSubRankId)
    local rankId = rankMatchCfg.rankID
    local maxFloor = self:getMaxLevelFloor(curSubRankId)
    for floorId=1,maxFloor do
       local isPass = self:isPassFloor(curSubRankId,floorId)
        if isPass then
            maxCost = maxCost + self.kvpData.addCost
        end
    end]]
    return self.maxCardPoint
end

function SkyLadderDataMgr:getCovertOrigalId(covertId)
    return self.rankCardConvertMap[covertId]
end

function SkyLadderDataMgr:getBattleScore()
    return self.battleScore
end

function SkyLadderDataMgr:getCurCircleInfo()
    return self.curCircleInfo
end

function SkyLadderDataMgr:getCurSubRankId()
    return self.curCircleInfo.segment
end

function SkyLadderDataMgr:getProceedTime()

    local curTime = ServerDataMgr:getServerTime()
    self.proceedTime = self.nextStepTime - curTime

    return self.proceedTime
end

function SkyLadderDataMgr:getRaceEndTime()
    return self.raceEndTime
end

function SkyLadderDataMgr:getSkyLadderHeroInfo()
    return self.skyLadderHero
end

function SkyLadderDataMgr:getLastSelectLevelCid()
    return self.lastSelectCid
end

function SkyLadderDataMgr:setLastSelectLevelCid(selectCid)
    self.lastSelectCid = selectCid
end

function SkyLadderDataMgr:getRegionBuffs(buffid)
    if not buffid then
        return self.regionBuffs
    end
    return self.regionBuffs[buffid]
end

function SkyLadderDataMgr:setBossBuffs(boosBuff)
    self.boosBuff = boosBuff
end

function SkyLadderDataMgr:getBossBuffs()
    return self.boosBuff
end

function SkyLadderDataMgr:addNewHero(heroInfo)
    heroInfo.ct = EC_SChangeType.DEFAULT
    self.skyLadderHero[heroInfo.cid] = heroInfo
end

function SkyLadderDataMgr:getSkyHeroEquipBind(equipId)
    if not equipId then
        return self.boundEquips
    end
    return self.boundEquips[tostring(equipId)]
end

function SkyLadderDataMgr:getSkyHeroNewEquipBind(equipId)

    if not equipId then
        return self.keepSake
    end
    return self.keepSake[tostring(equipId)]
end

function SkyLadderDataMgr:getSaveUseItemId()
    return self.useItemCid
end

function SkyLadderDataMgr:saveUseItemId(items)
    self.useItemCid = nil
    if not next(items) then
        return
    end
    local itemId,itemNum = items[1][1],items[1][2]
    local itemInfo = GoodsDataMgr:getSingleItem(itemId)
    if not itemInfo then
        return
    end

    self.useItemCid = itemInfo.cid
end

function SkyLadderDataMgr:setHeroFightCnt(heroCountTab)
    self.heroFightCnt = {}
    local heroFightMaxCnt = self.kvpData.herotime
    heroCountTab = heroCountTab or {}
    for k,v in ipairs(heroCountTab) do
        local remainCnt = heroFightMaxCnt - v.count
        remainCnt = remainCnt > 0 and remainCnt or 0
        self.heroFightCnt[v.itemCid] = remainCnt
    end
end

function SkyLadderDataMgr:getHeroFightCnt(heroCid)
    if not heroCid then
        return self.heroFightCnt
    end

    if not self.heroFightCnt[heroCid] then
        return self.kvpData.herotime
    end
    return self.heroFightCnt[heroCid]
end

function SkyLadderDataMgr:setCardFightCnt(cardCountTab)
    self.cardFightCnt = {}
    local cardFightMaxCnt = self.kvpData.cardtime
    cardCountTab = cardCountTab or {}
    for k,v in ipairs(cardCountTab) do
        local remainCnt = cardFightMaxCnt - v.count
        remainCnt = remainCnt > 0 and remainCnt or 0
        self.cardFightCnt[v.itemCid] = remainCnt
    end
end

function SkyLadderDataMgr:getCardFightCnt(cardCid)
    if not cardCid then
        return self.cardFightCnt
    end

    if not self.cardFightCnt[cardCid] then
        return self.kvpData.cardtime
    end
    return self.cardFightCnt[cardCid]
end

---得到活动阶段(0-准备期；1-进行期；2-结算期)
function SkyLadderDataMgr:getStep()
    return self.step
end

function SkyLadderDataMgr:getCurFloor()
    local curFloor = 1
    for k,v in pairs(self.passLevel) do
        curFloor = math.max(curFloor,self.RankMatchLevelCfg[k].floors)
    end
    return curFloor
end

function SkyLadderDataMgr:isPasslevel(levelCid)

    return self.passLevel[levelCid]
end

function SkyLadderDataMgr:isPassFloor(subRankId,floors)
    if not self.passFloor[subRankId] then
        return false
    end
    return self.passFloor[subRankId][floors]
end

function SkyLadderDataMgr:getRefreshTime()
    return self.refreshMinu
end

function SkyLadderDataMgr:getSkyLadderRankList()
    return self.skyLadderRankList
end

function SkyLadderDataMgr:getMyRankInfo()
    return self.myRankInfo
end

function SkyLadderDataMgr:getCurHundredList()
    return self.curHundred
end

function SkyLadderDataMgr:getSelfInHundred()
    return self.selfInHundred
end

function SkyLadderDataMgr:getLastHundredList()
    return self.lastHundred
end

function SkyLadderDataMgr:getSelfInLastHundred()
    return self.selfInLastHundred
end

function SkyLadderDataMgr:isOpen()
    local curTime = ServerDataMgr:getServerTime()
    return self.raceEndTime > curTime
end

function SkyLadderDataMgr:getRankMatchCardCfg(cid)
    return self.rankMatchCardCfg[cid]
end

function SkyLadderDataMgr:getOwnedCard()
    return self.ownedCards_
end

function SkyLadderDataMgr:setOwnedCardMap(updateCardInfo)

    if not updateCardInfo then
        self.ownCardsMap_ = {}
        for k,v in ipairs(self.ownedCards_) do
            self.ownCardsMap_[v.cardId] = v
        end
    else
        self.ownCardsMap_[updateCardInfo.cardId] = updateCardInfo
    end
end

function SkyLadderDataMgr:getOwnedCardByID(cid)
    return self.ownCardsMap_[cid]
end

function SkyLadderDataMgr:getNotOwnedCard()
    local ownedCardsMap = {}
    for i, v in ipairs(self.ownedCards_) do
        ownedCardsMap[v.cardId] = true
    end

    local notOwnedCards = {}
    for k, v in pairs(self.rankMatchCardCfg) do
        if v.isShow then
            if not ownedCardsMap[k] then
                table.insert(notOwnedCards, {cardId = k,cardLv = 1})
            end
        end
    end

    return notOwnedCards
end

function SkyLadderDataMgr:getUsingCards()
    return self.usingCards
end

function SkyLadderDataMgr:isUsingCards(cardId)

    local isUsingCards = false
    for k,v in ipairs(self.usingCards) do
        if v == cardId then
            isUsingCards = true
            break
        end
    end
    return isUsingCards
end

function SkyLadderDataMgr:getBestCards()

    local filtCards = {}
    for k,v in ipairs(self.ownedCards_) do
        local cardScore = 0
        local cardCfg = self:getRankMatchCardCfg(v.cardId)
        for _,negativeId in ipairs(cardCfg.negative) do
            if self.regionBuffs[negativeId] then
                cardScore = cardScore -1
            end
        end
        for _,positive in ipairs(cardCfg.positive) do
            if self.regionBuffs[positive] then
                cardScore = cardScore + 1
            end
        end
        table.insert(filtCards,{data = v,cardScore = cardScore})
    end

    table.sort(filtCards,function(a,b)
        local cardACfg = self:getRankMatchCardCfg(a.data.cardId)
        local cardBCfg = self:getRankMatchCardCfg(b.data.cardId)
        if a.cardScore == b.cardScore then
            if cardACfg.cost == cardBCfg.cost then
                if cardACfg.quality == cardBCfg.quality then
                    if a.data.cardLv == b.data.cardLv then
                        return cardACfg.order < cardBCfg.order
                    end
                    return a.data.cardLv > b.data.cardLv
                else
                    return cardACfg.quality > cardBCfg.quality
                end
            else
                return cardACfg.cost < cardBCfg.cost
            end
        else
            return a.cardScore > b.cardScore
        end
    end)

    local besetCards = {}
    local totalPoint = self.maxCardPoint
    local equipCost = 0
    local haveActiveSkillCard = false
    for k,v in ipairs(filtCards) do
        local remainCnt = self:getCardFightCnt(v.data.cardId)
        if remainCnt > 0 then
            local cfg = self:getRankMatchCardCfg(v.data.cardId)
            local preCost = equipCost + cfg.cost
            if preCost <= totalPoint then
                if cfg.abilityType == 2 then
                    if not haveActiveSkillCard then
                        table.insert(besetCards,v.data)
                        equipCost = equipCost + cfg.cost
                        haveActiveSkillCard = true
                    end
                else
                    table.insert(besetCards,v.data)
                    equipCost = equipCost + cfg.cost
                end
            end
        end
    end

    return besetCards

end

---装备卡牌是否减益区域效果
function SkyLadderDataMgr:getZoneBuffState(zoneBuffCid)

    local effectTab = {}
    for k,v in ipairs(self.usingCards) do
        local cardCfg = self:getRankMatchCardCfg(v)
        local effect = EC_SkyLadderCardEffect.normal
        for _,negativeId in ipairs(cardCfg.negative) do
            if negativeId == zoneBuffCid then
                effect= EC_SkyLadderCardEffect.down
                break
            end
        end

        for _,positive in ipairs(cardCfg.positive) do
            if positive == zoneBuffCid then
                effect= EC_SkyLadderCardEffect.up
                break
            end
        end

        table.insert(effectTab,effect)
    end

    ---排序优先显示down
    table.sort(effectTab,function(a,b)
        return a > b
    end)

    local state = effectTab[1] or EC_SkyLadderCardEffect.normal

    return state
end

function SkyLadderDataMgr:setCurCycleInfo(curCycle)

    self.curCircleInfo = curCycle
    self.usingCards = curCycle.usingCards or {}

    self.regionBuffs = {}
    local regionBuffs = curCycle.regionBuffs or {}
    for k,v in ipairs(regionBuffs) do
        self.regionBuffs[v] = v
    end

    self.battleScore = curCycle.battleScore or 0
    self.maxCardPoint = curCycle.cardPoint or self.kvpData.originalCost

    ---精灵挑战次数
    self:setHeroFightCnt(curCycle.heroCount)

    ---卡牌挑战次数
    self:setCardFightCnt(curCycle.cardCount)

    self.passLevel = {}
    self.passFloor = {}

    local levelInfos = curCycle.levelInfos or {}
    for k,v in ipairs(levelInfos) do
        self.passLevel[v.levelInfo.cid] = v.levelInfo.win
    end

    local baseHero = GoodsDataMgr:getBaseHeroData() or {}
    for k,v in ipairs(baseHero) do
        self.skyLadderHero[v.cid] = v
    end

    local heros = curCycle.heros or {}
    for k,v in ipairs(heros) do
        self.skyLadderHero[v.cid] = v
    end

    local bundEquip = curCycle.boundEquips or {}
    for k,v in ipairs(bundEquip) do
        self.boundEquips[tostring(v.itemId)] = tonumber(v.heroCid)
    end

    local boundNewEquips = curCycle.boundNewEquips or {}
    for k,v in ipairs(boundNewEquips) do
        self.keepSake[tostring(v.itemId)] = tonumber(v.heroCid)
    end

    self:setPassLevelInfo()
end

function SkyLadderDataMgr:setPassLevelInfo()

    for k,v in pairs(self.RankMatchLevelCfg) do
        if v.isBoss then
            local isPass = self.passLevel[v.id]
            if not self.passFloor[v.rankID] then
                self.passFloor[v.rankID] = {}
            end
            self.passFloor[v.rankID][v.floors] = tobool(isPass)
        end
    end

end

function SkyLadderDataMgr:updatePassFloor(levelCid)

    local rankMatchCfg = self:getRankMatchLevelCfg(levelCid)
    if not rankMatchCfg then
        return
    end

    if not rankMatchCfg.isBoss then
        return
    end

    local isPass = self.passLevel[levelCid]
    if not self.passFloor[rankMatchCfg.rankID] then
        self.passFloor[rankMatchCfg.rankID] = {}
    end
    self.passFloor[rankMatchCfg.rankID][rankMatchCfg.floors] = tobool(isPass)
end

function SkyLadderDataMgr:clearLastCircleRankList()
    self.lastRankList = nil
    self.showTips = false
end

function SkyLadderDataMgr:getLastCircleRankList()
    return self.lastRankList
end

function SkyLadderDataMgr:getLastSeasonData()
    return self.lastSeasonData
end

function SkyLadderDataMgr:setCheckHeroId(heroId)
    self.checkHeroId = heroId
end

function SkyLadderDataMgr:getCheckHeroId()
    return self.checkHeroId
end

function SkyLadderDataMgr:getHandleButtonState(cardPos,preEquipCardId)

    --1:移除 2:更换 3：加入 4：已装备
    local isHavePlayer = false
    local formation = self:getUsingCards()
    if formation[cardPos] then
        isHavePlayer = true
    end

    local formationSlotId = 0
    for k,cardId in ipairs(formation) do
        if cardId == preEquipCardId then
            formationSlotId = k
            break
        end
    end

    --所选卡牌没有装备
    if formationSlotId == 0 then
        if isHavePlayer then
            return 2
        else
            return 3
        end
        --所选卡牌装备中
    elseif formationSlotId ~= 0 then

        if formationSlotId == cardPos then
            if preEquipCardId == formation[cardPos] then
                return 1
            else
                return 4
            end
        else
            return 4
        end
    end
end

function SkyLadderDataMgr:handleFormation(cardPos,preEquipCardId)

    local srcHeroId = 0
    local formation = self:getUsingCards()
    if formation[cardPos] then
        srcHeroId = formation[cardPos]
    end

    local param1,param2
    local state =self:getHandleButtonState(cardPos,preEquipCardId)
    --1:移除 2:更换 3：加入 4：已装备
    if state == 1 then
        param1 =preEquipCardId
        param2 = 0
    elseif state == 3 then
        param1 = preEquipCardId
        param2 = srcHeroId
    elseif state == 2 then
        param1 = srcHeroId
        param2 = preEquipCardId
    end

    local fightCnt = self:getCardFightCnt(preEquipCardId)
    if fightCnt == 0 and state == 3 then
        return
    end

    if not param1 or not param2 then
        return
    end

    self:Send_EquipCard(param1,param2)

end

function SkyLadderDataMgr:Send_GetLastCircleData()
    TFDirector:send(c2s.LADDER_REQ_LADDER_LAST_DATA, {})
end

function SkyLadderDataMgr:Send_GetRankListData()
    TFDirector:send(c2s.LADDER_REQ_LADDER_RANK_LIST, {})
end

function SkyLadderDataMgr:Send_GetHeroNewData(dirtyHero)
    local datas = {}
    for i, v in ipairs(dirtyHero) do
        local hero = HeroDataMgr:getHero(v)
        if hero and hero.heroStatus == 3 then
        else
            table.insert(datas,v)
        end
    end
    if #datas > 0 then
        TFDirector:send(c2s.LADDER_REQ_LADDER_HERO_LIST, {datas})
    end
end

function SkyLadderDataMgr:takeOffSkyLadderEquipment(heroId,equipmentId,pos)
    local msg = {
        HeroDataMgr:getHeroSid(heroId),
        equipmentId,
        pos,
    }
    TFDirector:send(c2s.LADDER_REQ_TAKE_OFF_LADDER_EQUIP,msg);
end

function SkyLadderDataMgr:useSkyLadderEquipment(heroId,pos,equipId)
    local msg = {
        HeroDataMgr:getHeroSid(heroId),
        equipId,
        pos,
    }

    TFDirector:send(c2s.LADDER_REQ_LADDER_EQUIP,msg);
end

function SkyLadderDataMgr:sendReqEquipDressOrDrop(sType, heroId, equipId, pos)

    local msg = {
        sType,
        tostring(heroId),
        tostring(equipId),
        pos
    }

    TFDirector:send(c2s.LADDER_REQ_LADDER_NEW_EQUIP, msg)
end

function SkyLadderDataMgr:Send_UpgradeCard(cardCid)
    if not cardCid then
        return
    end
    TFDirector:send(c2s.LADDER_REQ_UPGRADE_LADDER_CARD,{cardCid});
end

function SkyLadderDataMgr:isNewTurn()
    return self.showTips
end

function SkyLadderDataMgr:Send_EquipCard(sourceCardIc,targetCardId)

    if not sourceCardIc or not targetCardId then
        return
    end

    local msg = {
        sourceCardIc,
        targetCardId
    }
    TFDirector:send(c2s.LADDER_REQ_PLANT_LADDER_CARD,msg);
end

---改变精灵质点
function SkyLadderDataMgr:recvHandleEquip(event)

    local data = event.data
    if not data then
        return
    end

    local changeHeros = data.heros
    if not changeHeros then
        return
    end

    for k,v in ipairs(changeHeros) do
        self.skyLadderHero[v.cid] = nil
        self.skyLadderHero[v.cid] = v
    end

    HeroDataMgr:changeDataToSkyLadder()

    EventMgr:dispatchEvent(EV_SKYLADDER_EQUIP);

end

---改变精灵羁绊
function SkyLadderDataMgr:recvHandleNewEquip(event)
    local data = event.data
    if not data then
        return
    end

    local changeHeros = data.heros
    if not changeHeros then
        return
    end

    for k,v in ipairs(changeHeros) do
        self.skyLadderHero[v.cid] = nil
        self.skyLadderHero[v.cid] = v
    end

    HeroDataMgr:changeDataToSkyLadder()

    EventMgr:dispatchEvent(EQUIPMENT_DRESS_NEW_EQUIP);
    EventMgr:dispatchEvent(EV_HERO_PROPERTYCHANGE);

end

----卡牌装备信息
function SkyLadderDataMgr:onRecvCardFormation(event)

    local data = event.data
    if not data then
        return
    end
    self.usingCards = data.usingCards or {}
    EventMgr:dispatchEvent(EV_UPDATE_CARD_FORMATION)
end

----初始消息
function SkyLadderDataMgr:onRecvLadderInfo(event)

    local data = event.data
    if not data then
        return
    end

    local info = data.info
    self.step = info.step

    self.historyBest = info.historyBest             ---历史最佳段位
    self.todayBest = info.todayBest                 ---赛季最佳段位

    self.nextStepTime = info.nextStepTime
    self.raceEndTime = info.seasonBalance
    self.ownedCards_ =  info.cardInfos or {}
    self.showTips = info.showTips
    self.curSeasonNum = info.clientSeason

    self:setOwnedCardMap()

    ---当前周期数据
    self:setCurCycleInfo(info.curCycle)
    self:setLastSelectLevelCid()
    EventMgr:dispatchEvent(EV_SKYLADDER_CURCIRCLE)

end

---天梯排行榜
function SkyLadderDataMgr:onRecvLadderRankList(event)

    local data = event.data
    if not data then
        return
    end

    self.refreshMinu = data.refreshMinu
    self.skyLadderRankList = data.rankList or {}
    self.myRankInfo = data.rank

    --self.curHundred = data.rankList or {}
    --self.selfInHundred = data.rank
    --
    --self.lastHundred = data.rankList or {}
    --self.selfInLastHundred = data.rank
    -----当前赛季百强
    self.curHundred = data.curSeason or {}
    self.selfInHundred = data.curRank
    --
    -----上赛季百强
    self.lastHundred = data.lastSeason or {}
    self.selfInLastHundred = data.lastRank

    EventMgr:dispatchEvent(EV_SKYLADDER_RANK)
end

----获取上期天梯数据
function SkyLadderDataMgr:onRecvLastCircleData(event)

    local data = event.data
    if not data then
        return
    end

    self.lastRankList = data.rankList
    self.lastSeasonData = data.seasonData


    --[[self.lastSeasonData = {}
    self.lastSeasonData.clientSeason = 1
    self.lastSeasonData.laderScore = 0
    self.lastSeasonData.segment = 1001
    self.lastSeasonData.rewards = {}
    table.insert(self.lastSeasonData.rewards,{id = 500001, num = 140})
    table.insert(self.lastSeasonData.rewards,{id = 500005, num = 12})

    self.lastRankList = {}
    local rankList = {}
    table.insert(rankList,clone(self.myRankInfo))
    table.insert(rankList,clone(self.myRankInfo))
    table.insert(rankList,clone(self.myRankInfo))
    table.insert(rankList,clone(self.myRankInfo))
    self.lastRankList.rankList = rankList
    self.lastRankList.rank = clone(self.myRankInfo)]]

    EventMgr:dispatchEvent(EV_SKYLADDER_LASTCIRCLE)

end


----重置精灵数据
function SkyLadderDataMgr:onRecvLadderHeroList(event)

    local data = event.data
    if not data then
        return
    end

    local resetHero = data.heros or {}
    for k,v in ipairs(resetHero) do
        self.skyLadderHero[v.cid] = v
    end

    local checkHeroId = self:getCheckHeroId()
    if checkHeroId then
        HeroDataMgr:changeDataToSkyLadder()
        EventMgr:dispatchEvent(EV_HERO_PROPERTYCHANGE)
    end
end

----刷新绑定关系
function SkyLadderDataMgr:onRecvUpdateBindingStuffs(event)

    local data = event.data
    if not data then
        return
    end

    self.boundEquips = {}
    local bundEquip = data.boundEquips or {}
    for k,v in ipairs(bundEquip) do
        self.boundEquips[tostring(v.itemId)] = tonumber(v.heroCid)
    end

    self.keepSake = {}
    local boundNewEquips = data.boundNewEquips or {}
    for k,v in ipairs(boundNewEquips) do
        self.keepSake[tostring(v.itemId)] = tonumber(v.heroCid)
    end
end

----卡牌
function SkyLadderDataMgr:onRecvUpdateCards(event)

    local data = event.data
    if not data then
        return
    end
    self.ownedCards_ =  data.card or {}
    self:setOwnedCardMap()

    EventMgr:dispatchEvent(EV_ADD_CARDS)
end

----升级卡牌
function SkyLadderDataMgr:onRecvUpgradeCards(event)

    local data = event.data
    if not data then
        return
    end

    local cardInfo = data.card
    for k,v in ipairs(self.ownedCards_) do
        if v.cardId == cardInfo.cardId then
            v.cardLv = cardInfo.cardLv
        end
    end
    self:setOwnedCardMap(cardInfo)
    EventMgr:dispatchEvent(EV_UPDATE_CARD_LV)

end

function SkyLadderDataMgr:onRecvUpdateHeroCount(event)

    local data = event.data
    if not data then
        return
    end
    local heroCount = data.heroCount
    self:setHeroFightCnt(heroCount)
end

function SkyLadderDataMgr:onRecvUpdateCardCount(event)

    local data = event.data
    if not data then
        return
    end
    local cardCount = data.cardCount
    self:setCardFightCnt(cardCount)
end

---战斗以后刷新关卡信息
function SkyLadderDataMgr:onRecvUpdateLevelInfo(event)

    local data = event.data
    if not data then
        return
    end

    if data.battleScore then
        self.battleScore = data.battleScore
    end
    self.maxCardPoint = data.cardPoint or self.kvpData.originalCost

    local levelInfos = data.levelInfos
    if not levelInfos then
        return
    end

    self.passLevel[levelInfos.levelInfo.cid] = levelInfos.levelInfo.win
    self:updatePassFloor(levelInfos.levelInfo.cid)
end

function SkyLadderDataMgr:setSkyLadderMainViewState(state)
    self.showMainView = state
end

function SkyLadderDataMgr:openMainView()

    if self.showMainView then
        self.showMainView = false
        if not FunctionDataMgr:checkFuncOpen(111) then return end
        local isOpen = self:isOpen()
        if isOpen then
            Utils:openView("skyLadder.SkyLadderMainView")
            local step = self:getStep()
            if step == EC_SKYLADDER_STEP.PROCCED then
                Utils:openView("skyLadder.SkyLadderZonesView")
            end
        end
    end
end

---存卡包的排序
function SkyLadderDataMgr:setCardSortParam(paramTab)

    if not paramTab then
        return
    end

    local pid = MainPlayer:getPlayerId()
    local saveStr = paramTab.ruleIndex.."|"..paramTab.orderIndex
    UserDefalt:setStringForKey("cardSortParam"..pid..paramTab.type,saveStr)
    UserDefalt:flush()
end

function SkyLadderDataMgr:getCardSortParam(paramType)

    if not paramType then
        return
    end
    local pid = MainPlayer:getPlayerId()
    local cardSortparam = UserDefalt:getStringForKey("cardSortParam"..pid..paramType)
    if cardSortparam == "" then
        return
    end
    local saveInfo = string.split(cardSortparam,"|")
    local ruleIndex,orderIndex = saveInfo[1],saveInfo[2]
    if not ruleIndex or not orderIndex then
        return
    end
    return tonumber(ruleIndex),tonumber(orderIndex)
end

return SkyLadderDataMgr:new()
