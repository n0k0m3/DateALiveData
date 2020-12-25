
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
    TFDirector:addProto(s2c.MAID_ACTIVITY_RESP_REFRESH_EVENT_LIST, self, self.onRecvEventUpdate) -- 日志事件更新
    TFDirector:addProto(s2c.MAID_ACTIVITY_RESP_GET_MAID_EVENT_AWARD, self, self.onRecvreward)
    TFDirector:addProto(s2c.MAID_ACTIVITY_RESP_CHANGE_ROLE_ID, self, self.updateKanbanRole) -- 更换看板精灵
    
    self.maidMap_ = TabDataMgr:getData("Maid")
    self.maid_ = {}
    for k, v in pairs(self.maidMap_) do
        table.insert(self.maid_, k)
    end

    self.maidBuffMap_ = TabDataMgr:getData("MaidBuff")
    self.maidKanbanMap = TabDataMgr:getData("MaidKanban")

    self.workingMaid_ = {}
    self.maidInfo_ = {}
    self.haveMaid_ = {}
    self.newMaid_ = {}
    self.eventMapData_ = {} -- 日志事件
    self.curRoleId = nil -- 当前精灵看板id
    self.curRoleListMap = {} -- 当前可使用精灵看板列表
end

function CoffeeDataMgr:reset()
    self.workingMaid_ = {}
    self.maidInfo_ = {}
    self.haveMaid_ = {}
    self.newMaid_ = {}
    self.eventMapData_ = {}
    self.curRoleId = nil 
    self.curRoleListMap = {} 
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

function CoffeeDataMgr:getMaidCfg1(id)
    return self.maidMap_[cid]
end

function CoffeeDataMgr:getMaidInfo(id)
    return self.maidInfo_[id]
end

function CoffeeDataMgr:getMaidBuffCfg(cid)
    return self.maidBuffMap_[cid]
end

function CoffeeDataMgr:isBuffActive(fettersCid)
    local _bool = true
    for i, v in ipairs(self:getMaidBuffCfg(fettersCid).role) do
        
        if _bool ~= self:isHaveSameMaid(v) then -- 解锁判断
            _bool = false
            break
        else                                    -- 上阵判断
            _bool = false
            for i, maidId in ipairs(self.workingMaid_) do
                local maidInfo = self:getMaidInfo(maidId)
                if maidInfo.cid == v then
                    _bool = true
                    break
                end
            end
        end
    end
    return _bool
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

function CoffeeDataMgr:send_MAID_ACTIVITY_REQ_GET_MAID_EVENT_AWARD(eventId)
    TFDirector:send(c2s.MAID_ACTIVITY_REQ_GET_MAID_EVENT_AWARD, {eventId})
end

function CoffeeDataMgr:send_MAID_ACTIVITY_REQ_CHANGE_ROLE_ID(roleId)
    TFDirector:send(c2s.MAID_ACTIVITY_REQ_CHANGE_ROLE_ID, {roleId})
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
    
    if data.eventList then
        for i, v in ipairs(data.eventList) do
            if v.ct ~= EC_SChangeType.DELETE then
                self.eventMapData_[v.id] = v
            end
        end
    end
    if data.maidRole then
        self.curRoleId = data.maidRole.roleId
        for j, v in ipairs(data.maidRole.roleList) do
            self.curRoleListMap[v] = v
        end
    end

    EventMgr:dispatchEvent(EV_COFFEE_MAIDINFO_UPDATE, data.enterType)
end

function CoffeeDataMgr:onRecvRecruitMaid(event)
    local data = event.data
    self.recruitInfo_ = data.recruitInfo
    local newId = __encodeMaidId(data.addRecruitId)
    self.newMaid_[newId] = true
    if data.roleId and not self.curRoleListMap[data.roleId] then
        self.curRoleListMap[data.roleId] = data.roleId
        EventMgr:dispatchEvent(EV_COFFEE_ISLOCK_ROLE)
    end
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

function CoffeeDataMgr:onRecvEventUpdate(event)
    local data = event.data 
    for i, v in ipairs(data.eventList or {}) do
        if v.ct == EC_SChangeType.DELETE then
            self.eventMapData_[v.id] = nil
        else
            self.eventMapData_[v.id] = v
        end
    end
    EventMgr:dispatchEvent(EV_COFFEE_UPDATE_LOG)
end

function CoffeeDataMgr:onRecvreward(event)
    local data = event.data
    if data.rewards and #data.rewards > 0 then
        Utils:showReward(data.rewards)
    end
end

function CoffeeDataMgr:updateKanbanRole(event)
    local data = event.data
    if data.roleId then
        self.curRoleId = data.roleId
        EventMgr:dispatchEvent(EV_COFFEE_UPDATE_ROLE)
    end
end

function CoffeeDataMgr:isKanBanLock(roleId)
    if nil == self.curRoleListMap[roleId] then
        return true
    end
    return false
end

function CoffeeDataMgr:getKanBanConfig(roleId)
    if roleId then
        return self.maidKanbanMap[roleId]
    end

    local tmp = {}
    for i, v in pairs(self.maidKanbanMap) do
        table.insert(tmp, v)
    end
    table.sort(tmp,function(a, b)
        if a.id == CoffeeDataMgr:getCurSelectId() then
            return true
        end
        return false
    end)
    return tmp
end

function CoffeeDataMgr:getCurSelectId()
    return self.curRoleId or 1014
end

function CoffeeDataMgr:getEventData()
    local tmp = {}
    for i, v in pairs(self.eventMapData_) do
        local tag = os.date("%Y%m%d",v.creatAt)
        if not tmp[tag] then
            tmp[tag] = {}
        end
        table.insert(tmp[tag], v)
    end

    for j, v in pairs(tmp) do
        table.sort(v, function(a, b)
            return a.creatAt < b.creatAt
        end)
    end
    return tmp
end

function CoffeeDataMgr:getWeekConfigByDay(i)
    local id = Utils:getKVP(46034, "week")[i]
    return  Utils:getKVP(id)
end

-- 是否获取了所有日志奖励
function CoffeeDataMgr:isGetAllLogReward()
    for i, v in pairs(self.eventMapData_) do
        if not v.reward then
            return false
        end
    end
    return true
end

-- 获取最新的日志显示
function CoffeeDataMgr:getNewLogStr()
    local tmp = {}
    for i, v in pairs(self.eventMapData_) do
        table.insert(tmp, v)
    end
    if table.count(tmp) == 0 then
        return nil
    end

    table.sort(tmp, function(a, b)
        return a.creatAt > b.creatAt
    end)
    local eventConfig = TabDataMgr:getData("MaidEvent")[tmp[1].cfgId]
    local descTxt = TextDataMgr:getText(eventConfig.describe)
    local timeTxt = os.date("%H:%M", tmp[1].creatAt)
    return timeTxt.." "..descTxt
end

return CoffeeDataMgr:new()
