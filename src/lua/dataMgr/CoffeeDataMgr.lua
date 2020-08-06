
local BaseDataMgr = import(".BaseDataMgr")
local CoffeeDataMgr = class("CoffeeDataMgr", BaseDataMgr)

local function __decodeMaidId(id)
    local ret = string.match(id, "m(%d+)")
    return tonumber(ret)
end

local function __encodeMaidId(id)
    local ret = string.format("m%s", id)
    return ret
end

function CoffeeDataMgr:init()
    TFDirector:addProto(s2c.MAID_ACTIVITY_RESP_GET_MAID_INFO, self, self.onRecvCoffInfo)
    TFDirector:addProto(s2c.MAID_ACTIVITY_RESP_RECRUIT_MAID, self, self.onRecvRecruitMaid)
    TFDirector:addProto(s2c.MAID_ACTIVITY_RESP_REFRESH_RECRUIT, self, self.onRecvRefreshRecruit)
    TFDirector:addProto(s2c.MAID_ACTIVITY_RESP_REFRESH_MAID, self, self.onRecvUpdateMaidInfo)
    TFDirector:addProto(s2c.MAID_ACTIVITY_RESP_FEED_MAID, self, self.onRecvMaidFeed)
    TFDirector:addProto(s2c.MAID_ACTIVITY_RESP_CHANGE_MAID_WORK, self, self.onRecvMaidChange)

    self.maidMap_ = TabDataMgr:getData("Maid")
    self.maid_ = {}
    for k, v in pairs(self.maidMap_) do
        table.insert(self.maid_, k)
    end

    self.maidBuffMap_ = TabDataMgr:getData("MaidBuff")

    self.workingMaid_ = {}
    self.maidInfo_ = {}
    self.haveMaid_ = {}
    self.newMaid_ = {}
end

function CoffeeDataMgr:reset()
    self.workingMaid_ = {}
    self.maidInfo_ = {}
    self.haveMaid_ = {}
    self.newMaid_ = {}
end

function CoffeeDataMgr:onLogin()
    return {}
end

function CoffeeDataMgr:onEnterMain()

end

function CoffeeDataMgr:getMaidCfg(id)
    local cid = id
    if self:isHaveMaid(id) then
        local maidInfo = self:getMaidInfo(id)
        cid = maidInfo.cid
    end
    return self.maidMap_[cid]
end

function CoffeeDataMgr:getMaidInfo(id)
    return self.maidInfo_[id]
end

function CoffeeDataMgr:getMaidBuffCfg(cid)
    return self.maidBuffMap_[cid]
end

function CoffeeDataMgr:getMaid()
    return slef.maid_
end

function CoffeeDataMgr:getWorkingMaid()
    return self.workingMaid_
end

function CoffeeDataMgr:isWorkingMaid(id)
    if self:isHaveMaid(id) then
        local index = table.indexOf(self.workingMaid_, id)
        return index ~= -1
    end
    return false
end

function CoffeeDataMgr:isNoWorkingMaid(id)
    if self:isHaveMaid(id) then
        local isWorkingMaid = self:isWorkingMaid(id)
        return not isWorkingMaid
    end
    return false
end

function CoffeeDataMgr:isNotHaveMaid(id)
    local isHave = self:isHaveMaid(id)
    return not isHave
end

function CoffeeDataMgr:getHaveMaid()
    local haveMaid = {}
    for k, v in pairs(self.maidInfo_) do
        table.insert(haveMaid, k)
    end
    table.sort(haveMaid, function(a, b)
                   local infoA = self:getMaidInfo(a)
                   local infoB = self:getMaidInfo(b)
                   if infoA.strength == infoB.strength then
                       if infoA.cid == infoB.cid then
                           local idA = __decodeMaidId(a)
                           local idB = __decodeMaidId(b)
                           return idA > idB
                       end
                       return infoA.cid > infoB.cid
                   end
                   return infoA.strength > infoB.strength
    end)

    return haveMaid
end

function CoffeeDataMgr:getNoWorkingMaid()
    local noWorkingMaid = {}
    local workingMaidMap = {}
    for i, v in ipairs(self.workingMaid_) do
        workingMaidMap[v] = true
    end
    for k, v in pairs(self.maidInfo_) do
        if not workingMaidMap[k] then
            table.insert(noWorkingMaid, k)
        end
    end
    return noWorkingMaid
end

function CoffeeDataMgr:isHaveMaid(id)
    if type(id) == "string" then
        return true
    end
    return false
end

function CoffeeDataMgr:isHaveSameMaid(id)
    local isHave = tobool(self.haveMaid_[id])
    return isHave
end

function CoffeeDataMgr:getNotHaveMaid()
    local notHaveMaid = {}

    for i ,v in ipairs(self.maid_) do
        if not self.haveMaid_[v] then
            table.insert(notHaveMaid, v)
        end
    end

    table.sort(notHaveMaid, function(a, b)
                   return a < b
    end)

    return notHaveMaid
end

function CoffeeDataMgr:converPower(power)
    return math.ceil(power / 1000)
end

function CoffeeDataMgr:getMaidFetters(maidList)
    local fettersList = {}
    local activeFettersList = {}
    local maidCidList = {}
    for i, v in ipairs(maidList) do
        local maidInfo = self:getMaidInfo(v)
        local maidCfg = self:getMaidCfg(maidInfo.cid)
        table.insert(maidCidList, maidCfg.id)
        table.insertTo(fettersList, maidCfg.fetterList )
    end
    fettersList = table.unique(fettersList)
    for i, v in ipairs(fettersList) do
        local maidBuffCfg = self:getMaidBuffCfg(v)
        local isActive = true
        for _, maid in ipairs(maidBuffCfg.role) do
            local index = table.indexOf(maidCidList, maid)
            if index == -1 then
                isActive = false
                break
            end
        end
        if isActive then
            table.insert(activeFettersList, v)
        end
    end

    table.sort(activeFettersList, function(a, b)
                   return a < b
    end)

    return activeFettersList
end

function CoffeeDataMgr:getItems(type_)
    local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.MAID_COFFEE)
    local activityId = activity[1]
    if not activityId then
        Box("女仆咖啡厅活动未开启")
        return
    end
    local rets = {}
    local activityInfo = ActivityDataMgr2:getActivityInfo(activityId)
    local items = ActivityDataMgr2:getItems(activityId)
    for i, v in ipairs(items) do
        local itemInfo = ActivityDataMgr2:getItemInfo(activityInfo.activityType, v)
        if itemInfo.extendData.type == type_ then
            table.insert(rets, v)
        end
    end
    return rets, activityId
end

function CoffeeDataMgr:isShowRedPoint(type_)
    local items, activityId = self:getItems(type_)
    local activityInfo = ActivityDataMgr2:getActivityInfo(activityId)
    local isShow = false
    for i, v in ipairs(items) do
        local progressInfo = ActivityDataMgr2:getProgressInfo(activityInfo.activityType, v)
        if progressInfo and progressInfo.status == EC_TaskStatus.GET then
            isShow = true
            break
        end
    end
    return isShow
end

function CoffeeDataMgr:getExtraMaidInfo()
    return self.extraMaidInfo_
end

function CoffeeDataMgr:getRecruitInfo()
    return self.recruitInfo_
end

function CoffeeDataMgr:isCanFreeRefresh()
    local serverTime = ServerDataMgr:getServerTime()
    local isFree = serverTime > self.recruitInfo_.nextTime
    return isFree
end

function CoffeeDataMgr:isNewMaid(id)
    local isNew = tobool(self.newMaid_[id])
    return isNew
end

function CoffeeDataMgr:haveNewMaid()
    for k, v in pairs(self.newMaid_) do
        if v then
            return true
        end
    end
    return false
end

function CoffeeDataMgr:clearNewMaid()
    self.newMaid_ = {}
end

-------------------------------------------------------------------------

function CoffeeDataMgr:send_MAID_ACTIVITY_REQ_GET_MAID_INFO(enterType)
    TFDirector:send(c2s.MAID_ACTIVITY_REQ_GET_MAID_INFO, {enterType})
end

function CoffeeDataMgr:send_MAID_ACTIVITY_REQ_RECRUIT_MAID(location)
    TFDirector:send(c2s.MAID_ACTIVITY_REQ_RECRUIT_MAID, {location})
end

function CoffeeDataMgr:send_MAID_ACTIVITY_REQ_REFRESH_RECRUIT(type_)
    TFDirector:send(c2s.MAID_ACTIVITY_REQ_REFRESH_RECRUIT, {type_})
end

function CoffeeDataMgr:send_MAID_ACTIVITY_REQ_FEED_MAID(maidId, itemId, num)
    maidId = __decodeMaidId(maidId)
    TFDirector:send(c2s.MAID_ACTIVITY_REQ_FEED_MAID, {maidId, itemId, num})
end

function CoffeeDataMgr:send_MAID_ACTIVITY_REQ_CHANGE_MAID_WORK(changeId, originalId)
    changeId = __decodeMaidId(changeId)
    originalId = __decodeMaidId(originalId)
    TFDirector:send(c2s.MAID_ACTIVITY_REQ_CHANGE_MAID_WORK, {changeId, originalId})
end

function CoffeeDataMgr:onRecvCoffInfo(event)
    local data = event.data

    self.workingMaid_ = {}
    self.maidInfo_ = {}
    self.haveMaid_ = {}
    for i, v in ipairs(data.workLists) do
        self.workingMaid_[i] = __encodeMaidId(v)
    end
    for k, v in ipairs(data.maidObjects) do
        self.maidInfo_[__encodeMaidId(v.onlyId)] = v
        self.haveMaid_[v.cid] = true
    end

    self.extraMaidInfo_ = data.maidInfo
    self.recruitInfo_ = data.recruitInfo

    EventMgr:dispatchEvent(EV_COFFEE_MAIDINFO_UPDATE, data.enterType)
end

function CoffeeDataMgr:onRecvRecruitMaid(event)
    local data = event.data
    self.recruitInfo_ = data.recruitInfo
    local newId = __encodeMaidId(data.addRecruitId)
    self.newMaid_[newId] = true
    EventMgr:dispatchEvent(EV_COFFEE_RECRUIT_MAID)
end

function CoffeeDataMgr:onRecvRefreshRecruit(event)
    local data = event.data
    self.recruitInfo_ = data.recruitInfo
    EventMgr:dispatchEvent(EV_COFFEE_REFRESH_RECRUIT)
end

function CoffeeDataMgr:onRecvUpdateMaidInfo(event)
    local data = event.data
    for k, v in ipairs(data.maidObject) do
        self.maidInfo_[__encodeMaidId(v.onlyId)] = v
        self.haveMaid_[v.cid] = true
    end
end

function CoffeeDataMgr:onRecvMaidFeed(event)
    local data = event.data
    self.maidInfo_[__encodeMaidId(data.maidObject.onlyId)] = data.maidObject
    EventMgr:dispatchEvent(EV_COFFEE_MAID_FEED)
end

function CoffeeDataMgr:onRecvMaidChange(event)
    local data = event.data

    if data.workLists then
        self.workingMaid_ = {}
        for i, v in ipairs(data.workLists) do
            self.workingMaid_[i] = __encodeMaidId(v)
        end
        EventMgr:dispatchEvent(EV_COFFEE_MAID_CHANGE)
    end
end

return CoffeeDataMgr:new()
