--[[
    @desc：用作2020周年庆翻牌管理器
]]

local BaseDataMgr = import(".BaseDataMgr")
local TurnTabletMgr = class("TurnTabletMgr", BaseDataMgr)

function TurnTabletMgr:ctor()
    self:init()
end

function TurnTabletMgr:onLogin()
    
end

function TurnTabletMgr:onEnterMain()
    if ActivityDataMgr2:isOpen(EC_ActivityType2.TURNTABLET2) then
        self:send_ANNIVERSARY_FLOP_REQ_ANNIV_INFO()
    end
end

function TurnTabletMgr:init()
    self:initData()
    self:registerMsgEvent()
end

function TurnTabletMgr:initData()
    self.turnTabletData = nil
    self.gameTuranTabletCfg = TabDataMgr:getData("CardGame")
end

function TurnTabletMgr:reset()
    
end

function TurnTabletMgr:registerMsgEvent()
    TFDirector:addProto(s2c.ANNIVERSARY2ND_RES_ANNIV_FLOP, self, self.onRecvGetAward)
    TFDirector:addProto(s2c.ANNIVERSARY2ND_RES_ANNIV_INFO, self, self.onRecvTurnTabletData)
    TFDirector:addProto(s2c.ANNIVERSARY2ND_RES_ANNIV_MOVE_NEXT, self, self.onRecvGoNextFloor)
    TFDirector:addProto(s2c.ANNIVERSARY2ND_RES_ANNIV_PASS_REWARD, self, self.onRecvChoosePassAward)
    TFDirector:addProto(s2c.ANNIVERSARY2ND_RES_ANNIV_START, self, self.onRecvClickTurnTablet)
end

function TurnTabletMgr:onRecvGetAward(event)
    local data = event.data
    EventMgr:dispatchEvent(EV_TURNTABLET2_TURNTABLETRESULT, data)
end

function TurnTabletMgr:onRecvTurnTabletData(event)
    local data = event.data
    self.turnTabletData = data
    EventMgr:dispatchEvent(EV_TURNTABLET2_DATAUPDATE)
end

function TurnTabletMgr:onRecvGoNextFloor(event)
    EventMgr:dispatchEvent(EV_TURNTABLET2_GONEXTFLOOR, true)
end

function TurnTabletMgr:onRecvChoosePassAward(event)
    EventMgr:dispatchEvent(EV_TURNTABLET2_CHOOSEPASSAWARD)
end

function TurnTabletMgr:onRecvClickTurnTablet(event)
    EventMgr:dispatchEvent(EV_TURNTABLET2_BEGINTURNTABLET)
end

function TurnTabletMgr:getTurnTabletData()
    return self.turnTabletData
end

function TurnTabletMgr:getTurnTabletCfgById(id)
    if id then
        return self.gameTuranTabletCfg[id]
    else
        return self.gameTuranTabletCfg
    end
end

function TurnTabletMgr:isTurnTabletRedShow()
    local _bool = false
    local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.TURNTABLET2)

    if self.turnTabletData and #activity > 0 then
        local activityInfo_ = ActivityDataMgr2:getActivityInfo(activity[1])
        local costGoodsId = activityInfo_.extendData.costItem
        if self.turnTabletData.freeCount > 0 or GoodsDataMgr:getItemCount(costGoodsId) > 0 then
            _bool = true
        end
    end

    return _bool
end

-- 9201
function TurnTabletMgr:send_ANNIVERSARY_FLOP_REQ_ANNIV_FLOP(idx)
    TFDirector:send(c2s.ANNIVERSARY2ND_REQ_ANNIV_FLOP, {idx})
end

-- 9202
function TurnTabletMgr:send_ANNIVERSARY_FLOP_REQ_ANNIV_INFO()
    TFDirector:send(c2s.ANNIVERSARY2ND_REQ_ANNIV_INFO, {})
end

-- 9203
function TurnTabletMgr:send_ANNIVERSARY_FLOP_REQ_ANNIV_MOVE_NEXT()
    TFDirector:send(c2s.ANNIVERSARY2ND_REQ_ANNIV_MOVE_NEXT, {})
end

-- 9204
function TurnTabletMgr:send_ANNIVERSARY_FLOP_REQ_ANNIV_PASS_REWARD(id)
    TFDirector:send(c2s.ANNIVERSARY2ND_REQ_ANNIV_PASS_REWARD, {id})
end

-- 9205
function TurnTabletMgr:send_ANNIVERSARY_FLOP_REQ_ANNIV_START()
    TFDirector:send(c2s.ANNIVERSARY2ND_REQ_ANNIV_START, {})
end

return TurnTabletMgr:new()