
local BaseDataMgr = import(".BaseDataMgr")
local SxBirthdayDataMgr = class("SxBirthdayDataMgr", BaseDataMgr)

function SxBirthdayDataMgr:init()
    TFDirector:addProto(s2c.BIRTH_DAY_RESP_TEN_BIRTH_DAY_INFO, self, self.onRecvBirthdayInfo)
    TFDirector:addProto(s2c.BIRTH_DAY_RESP_EXPLORE, self, self.onRecvBirthdayExplore)
    TFDirector:addProto(s2c.BIRTH_DAY_RESP_GET_EXPLORE_AWARD, self, self.onRecvGetReward)
    self.activityCityMap_ = TabDataMgr:getData("ActivityCity")
    self.activityCity_ = {}
    for k, v in pairs(self.activityCityMap_) do
        table.insert(self.activityCity_, k)
    end
    self.tohkaDatingMap_ = TabDataMgr:getData("TohkaDating")
    self.tohkaEventMap_ = TabDataMgr:getData("TohkaEvent")

    self.cityInfo_ = {}
    self.cityOrder_ = {}
end

function SxBirthdayDataMgr:reset()
    self.cityInfo_ = {}
    self.cityOrder_ = {}
end

function SxBirthdayDataMgr:onLogin()

end

function SxBirthdayDataMgr:onEnterMain()

end

function SxBirthdayDataMgr:getActivityCity()
    return self.activityCity_
end

function SxBirthdayDataMgr:getActivityCityCfg(cid)
    return self.activityCityMap_[cid]
end

function SxBirthdayDataMgr:getTohkaDatingCfg(cid)
    return self.tohkaDatingMap_[cid]
end

function SxBirthdayDataMgr:getTohkaEventCfg(cid)
    return self.tohkaEventMap_[cid]
end

function SxBirthdayDataMgr:getCityInfo(cid)
    return self.cityInfo_[cid]
end

function SxBirthdayDataMgr:isUnlockCity(cid)
    local info = self:getCityInfo(cid)
    local isUnlock = tobool(info)
    return isUnlock
end

function SxBirthdayDataMgr:getCityOrder(cid)
    local order = 0
    for i, v in ipairs(self.cityOrder_) do
        if v == cid then
            order = i
            break
        end
    end
    return order
end

------------------------------------------------------------

function SxBirthdayDataMgr:send_BIRTH_DAY_REQ_TEN_BIRTH_DAY_INFO()
    TFDirector:send(c2s.BIRTH_DAY_REQ_TEN_BIRTH_DAY_INFO, {})
end

function SxBirthdayDataMgr:send_BIRTH_DAY_REQ_EXPLORE(cityId)
    TFDirector:send(c2s.BIRTH_DAY_REQ_EXPLORE, {cityId})
end

function SxBirthdayDataMgr:send_BIRTH_DAY_REQ_GET_EXPLORE_AWARD(cityId)
    TFDirector:send(c2s.BIRTH_DAY_REQ_GET_EXPLORE_AWARD, {cityId})
end

function SxBirthdayDataMgr:onRecvBirthdayInfo(event)
    local data = event.data
    if not data then return end

    if data.cityInfo then
        for i, v in ipairs(data.cityInfo) do
            if v.changeType == EC_SChangeType.ADD or v.changeType == EC_SChangeType.DEFAULT then
                table.insert(self.cityOrder_, v.cityId)
            end
            self.cityInfo_[v.cityId] = v
        end

        EventMgr:dispatchEvent(EV_SXBIRTHDAY_CITYINFO_UPDATE)
    end
end

function SxBirthdayDataMgr:onRecvBirthdayExplore(event)
    local data = event.data
    if not data then return end
    if data.eventInfo then
        EventMgr:dispatchEvent(EV_SXBIRTHDAY_EXPLORE, data.eventInfo.eventId, data.eventInfo.rewards)
    end
end

function SxBirthdayDataMgr:onRecvGetReward(event)
    local data = event.data
    if not data then return end
    if data.eventInfo then
        EventMgr:dispatchEvent(EV_SXBIRTHDAY_GET_REWARD, data.eventInfo.eventId, data.eventInfo.rewards)
    end
end

return SxBirthdayDataMgr:new()
