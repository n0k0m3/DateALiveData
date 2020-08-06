local BaseDataMgr = import(".BaseDataMgr")
local ManualMakeDataMgr = class("ManualMakeDataMgr", BaseDataMgr)
local UserDefalt = CCUserDefault:sharedUserDefault()
function ManualMakeDataMgr:ctor()
    self:init()
end

function ManualMakeDataMgr:init()
    TFDirector:addProto(s2c.NEW_BUILDING_RESP_GET_HAND_WORK_INFO, self, self.onRecvGetHandWorkInfo)
    TFDirector:addProto(s2c.NEW_BUILDING_RESP_DO_HAND_WORK, self, self.onRecvMakeManual)
    TFDirector:addProto(s2c.NEW_BUILDING_RESP_UPLOAD_HAND_INTEGRAL, self, self.onRecvUpdateScore)
    TFDirector:addProto(s2c.NEW_BUILDING_RESP_GET_HAND_WORK_AWARD, self, self.onRecvGetHandWorkAward)

    self.handworkbaseMap = TabDataMgr:getData("Handworkbase")
    local manualList = {}
    for _,v in pairs(self.handworkbaseMap) do
        table.insert(manualList, v)
    end
    table.sort(manualList, function(a, b)
        if a.handworkType == b.handworkType then
           return a.order < b.order
       end
       return a.handworkType < b.handworkType
    end)

    self.manualList_ = {}
    for k ,v in pairs(manualList) do
        self.manualList_[v.handworkType] = self.manualList_[v.handworkType] or {}
        table.insert(self.manualList_[v.handworkType],v)
    end
end

function ManualMakeDataMgr:onLogin()
    -- TFDirector:send(c2s.NEW_BUILDING_REQ_GET_HAND_WORK_INFO, {})
    -- return {s2c.NEW_BUILDING_RESP_GET_HAND_WORK_INFO}
end

function ManualMakeDataMgr:saveRecordCnt()

    local pid = MainPlayer:getPlayerId()
    local recordCnt = UserDefalt:getStringForKey("ManualMake"..pid)
    recordCnt = tonumber(recordCnt)
    if not recordCnt then
        recordCnt = 0
    end
    recordCnt = recordCnt + 1
    UserDefalt:setStringForKey("ManualMake"..pid,recordCnt)
    UserDefalt:flush()
end

function ManualMakeDataMgr:getRecordCnt()

    local pid = MainPlayer:getPlayerId()
    local recordCnt = UserDefalt:getStringForKey("ManualMake"..pid)
    recordCnt = tonumber(recordCnt) and tonumber(recordCnt) or 0
    return recordCnt
end

function ManualMakeDataMgr:getManualListByType(handworkType, datingId)
    if datingId then
        local manualList = {}
        for k, v in pairs(self.handworkbaseMap) do
            if v.datingId == datingId then
                -- local materials = v.materials
                -- local flag = true
                -- for k, itemInfo in pairs(materials) do
                --     local count = GoodsDataMgr:getItemCount(itemInfo[1])
                --     if count < itemInfo[2] then
                --         flag = false
                --     end
                -- end
                -- if flag then
                --     table.insert(manualList, v)
                -- end
                table.insert(manualList, v)
            end
        end
        table.sort(manualList, function(a, b)
           return a.order < b.order
        end)
        return manualList
    end
    return self.manualList_[handworkType]
end

function ManualMakeDataMgr:getManualInfoById(manualId)
    for type,info in ipairs(self.manualList_) do
        for k,v in ipairs(info) do
            if v.id == manualId then
                return v
            end
        end
    end
    return nil
end

function ManualMakeDataMgr:getManualListIndex(manualId, datingId)
    if datingId then
        local manualList = self:getManualListByType(nil, datingId)
        for k,v in ipairs(manualList) do
            if v.id == manualId then
                return k
            end
        end
    end
    for type,info in ipairs(self.manualList_) do
        for k,v in ipairs(info) do
            if v.id == manualId then
                return k
            end
        end
    end
    return nil
end

function ManualMakeDataMgr:getNextDatingId()
    local manualInfo = self:getManualInfoById(self.manualMakingInfo.manualId)
    local jump = manualInfo.jump
    local integral = self.manualMakingInfo.integral
    local nextDatingId = 0
    local maxScore = 0
    for k, v in pairs(jump) do
        local score = tonumber(k)
        if score > maxScore and integral >= score then
            nextDatingId = v
            maxScore = score
        end
    end
    self.manualMakingInfo = nil
    return nextDatingId
end

function ManualMakeDataMgr:getManualMakingInfo()
   return self.manualMakingInfo
end

function ManualMakeDataMgr:resetManualInfo()
    self.manualMakingInfo = nil
end

function ManualMakeDataMgr:sendReqMakeManual(manualId,makeTimes)
    TFDirector:send(c2s.NEW_BUILDING_REQ_DO_HAND_WORK, {manualId,makeTimes})
end

function ManualMakeDataMgr:sendUpdateScore(manualId, score, startTime, endTime)
    TFDirector:send(c2s.NEW_BUILDING_REQ_UPLOAD_HAND_INTEGRAL, {manualId, score, startTime, endTime})
end

function ManualMakeDataMgr:sendReqHandWorkReward(manualId, datingId)
    local msg = {}
    if datingId then
        local mainId = NewCityDataMgr:getDatingLineData().datingValue
        local roleId = RoleDataMgr:getCurId()
        msg = {manualId, mainId, roleId}
    else
        msg = {manualId}
    end
    TFDirector:send(c2s.NEW_BUILDING_REQ_GET_HAND_WORK_AWARD, msg)
end

--获得手工制作信息
function ManualMakeDataMgr:onRecvGetHandWorkInfo(event)
    local data = event.data
    local manualMakingInfo = data.handWorkInfo
    self.manualMakingInfo = manualMakingInfo
    EventMgr:dispatchEvent(EV_FUNC_MANUAL_MAKING_INFO, data)
end

function ManualMakeDataMgr:updateManualMakingScore(score)
    if self.manualMakingInfo then
        self.manualMakingInfo.integral = score
    end
end

--开始手工制作
function ManualMakeDataMgr:onRecvMakeManual(event)
    local data = event.data
    self.manualMakingInfo = {}
    self.manualMakingInfo.manualId = data.manualId
    self.manualMakingInfo.endTime = data.endTime
    self.manualMakingInfo.integral = 0
    EventMgr:dispatchEvent(EV_FUNC_START_MAKE_MANUAL, data)
end

--积分变动
function ManualMakeDataMgr:onRecvUpdateScore(event)
    local data = event.data
    EventMgr:dispatchEvent(EV_FUNC_UPDATE_MANUAL_SCORE, data)
end

--领取奖励
function ManualMakeDataMgr:onRecvGetHandWorkAward(event)
    local data = event.data
    EventMgr:dispatchEvent(EV_FUNC_GET_MANUAL_REWARD, data)
end

function ManualMakeDataMgr:checkRedPoint()
    local flag = false
    for type,list in ipairs(self.manualList_) do
        local flag = self:checkRedPointByType(type)
        if flag then
            return flag
        end
    end
    return flag
end

function ManualMakeDataMgr:checkRedPointByType(handworkType)
    local list = self.manualList_[handworkType]
    local flag = false
    for i,cfg in ipairs(list) do
        flag = self:checkRedPointByCfg(cfg)
        if flag then
            return flag
        end
    end
    return flag
end

function ManualMakeDataMgr:checkRedPointByCfg(cfg)
    local flag = false
    local flag1 = true
    local flag2 = true
    
    if table.count(cfg.materials) < 1 then
        flag1 = false
    else
        for k,v in pairs(cfg.materials) do
            local count = GoodsDataMgr:getItemCount(v[1])
            if count < v[2] then
                flag1 = false
                break
            end
        end
    end
    if table.count(cfg.ability) < 1 then
        flag2 = false
    else
        for k,v in pairs(cfg.ability) do
            local count = GoodsDataMgr:getItemCount(v[1])
            if count < v[2] then
                flag2 = false
                break
            end
        end
    end
    if flag1 and flag2 then
        flag = true
    end
    return flag
end

return ManualMakeDataMgr:new()
