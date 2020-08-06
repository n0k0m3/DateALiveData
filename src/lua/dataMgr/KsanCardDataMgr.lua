
local BaseDataMgr = import(".BaseDataMgr")
local KsanCardDataMgr = class("KsanCardDataMgr", BaseDataMgr)

function KsanCardDataMgr:ctor()

    self:initData()
    TFDirector:addProto(s2c.ACTIVITY_RESP_FLOP_GAME_INFO, self, self.onRecvCardInfo)
    TFDirector:addProto(s2c.ACTIVITY_RESP_RESET_FLOP_GAME, self, self.onRecvResetCard)
    TFDirector:addProto(s2c.ACTIVITY_RESP_FLOP_FLOP_GAME, self, self.onRecvOpenCard)

end

function KsanCardDataMgr:initData()
    self.cardCfg = TabDataMgr:getData("SpeedLinkType2")
    self.cardAwardMap_ = {}
    for k,v in pairs(self.cardCfg) do
        if not self.cardAwardMap_[v.cardPoolId] then
            self.cardAwardMap_[v.cardPoolId] = {}
        end

        if not self.cardAwardMap_[v.cardPoolId][v.itemShow] then
            self.cardAwardMap_[v.cardPoolId][v.itemShow] = {}
        end
        table.insert(self.cardAwardMap_[v.cardPoolId][v.itemShow],v)
    end
end

function KsanCardDataMgr:reset()

end


function KsanCardDataMgr:getCardInfo(pos)
    if pos then
        return self.cardInfo[pos]
    end
    return self.cardInfo
end

function KsanCardDataMgr:getRandomIds()
    return self.ids
end

function KsanCardDataMgr:finishMatchNum(id)
    if not self.finishIds[id] then
        return 0
    end
    return self.finishIds[id]
end

function KsanCardDataMgr:getCardCfg(cid)
    return self.cardCfg[cid]
end

function KsanCardDataMgr:getCardAwardMap(cardPoolId)
    return self.cardAwardMap_[cardPoolId]
end

function KsanCardDataMgr:Send_GetCardData( activityId )
    TFDirector:send(c2s.ACTIVITY_REQ_FLOP_GAME_INFO,{activityId})
end

function KsanCardDataMgr:Send_ResetCards( activityId )
    TFDirector:send(c2s.ACTIVITY_REQ_RESET_FLOP_GAME,{activityId})
end

function KsanCardDataMgr:Send_OpenCard( activityId, pos )
    TFDirector:send(c2s.ACTIVITY_REQ_FLOP_FLOP_GAME,{activityId,pos})
end


function KsanCardDataMgr:onRecvCardInfo( event )
    -- body
    self.cardInfo = {}
    self.finishIds = {}
    self.ids = {}
    local card = event.data.cardInfo or {}
    for k,v in ipairs(card) do
        self.cardInfo[v.pos] = v
        if v.id then
            if not self.finishIds[v.id] then
                self.finishIds[v.id] = 0
            end
            self.finishIds[v.id] = self.finishIds[v.id] + 1
        end
    end
    dump(self.cardInfo)
    self.ids = event.data.ids or {}
    EventMgr:dispatchEvent(EV_KSAN_CARDS)
end

function KsanCardDataMgr:onRecvResetCard( event )

end

function KsanCardDataMgr:onRecvOpenCard( event )
    -- body
    local data = event.data
    if not data then
        return
    end

    local card = data.cardInfo
    self.cardInfo[card.pos] = card
    if not self.finishIds[card.id] then
        self.finishIds[card.id] = 0
    end
    self.finishIds[card.id] = self.finishIds[card.id] + 1

    EventMgr:dispatchEvent(EV_KSAN_MATCH_CARDS,data)

end


return KsanCardDataMgr:new()