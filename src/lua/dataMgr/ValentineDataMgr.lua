
local BaseDataMgr = import(".BaseDataMgr")
local ValentineDataMgr = class("ValentineDataMgr", BaseDataMgr)

function ValentineDataMgr:init()
    TFDirector:addProto(s2c.VALENTINE_VALENTINE_RANK, self, self.onRecvValentineRank)
    TFDirector:addProto(s2c.VALENTINE_VALENTINE_COMPOSE, self, self.onRecvValentineCompose)
    TFDirector:addProto(s2c.VALENTINE_VALENTINE_PRESENT, self, self.onRecvValentineGift)
    TFDirector:addProto(s2c.VALENTINE_VALENTINE_INFO, self, self.onRecvValentineInfo)
    TFDirector:addProto(s2c.VALENTINE_VALENTINE_NEW_DATING, self, self.onRecvValentineNewDating)

    self.valentineRoleMap_ = TabDataMgr:getData("ValentineRole")
    self.valentineRole_ = {}
    for k, v in pairs(self.valentineRoleMap_) do
        table.insert(self.valentineRole_, k)
    end
    table.sort(self.valentineRole_, function(a, b)
                   local cfgA = self.valentineRoleMap_[a]
                   local cfgB = self.valentineRoleMap_[b]
                   return cfgA.order < cfgB.order
    end)

    self.completedDatings_ = {}
    self.tacitInfo_ = {}
end

function ValentineDataMgr:reset()
    self.completedDatings_ = {}
    self.tacitInfo_ = {}
end

function ValentineDataMgr:onLogin()
    TFDirector:send(c2s.VALENTINE_VALENTINE_INFO, {})
    return {s2c.VALENTINE_VALENTINE_INFO}
end

function ValentineDataMgr:onEnterMain()

end

function ValentineDataMgr:getValentineRoleCfg(roleCid)
    return self.valentineRoleMap_[roleCid]
end

function ValentineDataMgr:getValentineRole()
    return self.valentineRole_
end

function ValentineDataMgr:getValentineRoleRank()
    local valentineRole
    valentineRole = clone(self.valentineRole_)
    table.sort(valentineRole, function(a, b)
                    local tacitA = self:getFullServerTacit(a)
                    local tacitB = self:getFullServerTacit(b)
                    if tacitA == tacitB then
                        local cfgA = self:getValentineRoleCfg(a)
                        local cfgB = self:getValentineRoleCfg(b)
                        return cfgA.order < cfgB.order
                    end
                    return tacitA > tacitB
    end)
    return valentineRole
end

function ValentineDataMgr:getActivityInfo()
    local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.VALENTINE)
    local activityInfo
    if #activity > 0 then
        activityInfo = ActivityDataMgr2:getActivityInfo(activity[1])
    end
    return activityInfo
end

function ValentineDataMgr:getFullServerTacit(roleCid)
    local tacit = self.tacitInfo_[roleCid] or 0
    return tacit
end

-- 以服务器活动排行数据为准（弃用）
-- function ValentineDataMgr:getMyTacit(roleCid)
--     local activityInfo = self:getActivityInfo()
--     local itemCid = activityInfo.extendData.privity[roleCid]
--     local count = GoodsDataMgr:getItemCount(itemCid)
--     return count
-- end

function ValentineDataMgr:getDatingIsComplete(datingCid)
    local isComplete = tobool(self.completedDatings_[datingCid])
    return isComplete
end

function ValentineDataMgr:getTask(roleCid)
    local activityInfo = self:getActivityInfo()
    local items = ActivityDataMgr2:getItems(activityInfo.id)
    local roleCfg = self:getValentineRoleCfg(roleCid)
    local taskMap = {}
    for i, v in ipairs(roleCfg.task) do
        taskMap[v] = true
    end

    local taskData = {}
    for i, v in ipairs(items) do
        if taskMap[v] then
            table.insert(taskData, v)
        end
    end
    return taskData
end

----------------------------------------------------------

function ValentineDataMgr:send_VALENTINE_VALENTINE_RANK()
    TFDirector:send(c2s.VALENTINE_VALENTINE_RANK, {})
end

function ValentineDataMgr:send_VALENTINE_VALENTINE_COMPOSE(gift)
    TFDirector:send(c2s.VALENTINE_VALENTINE_COMPOSE, {gift})
end

function ValentineDataMgr:send_VALENTINE_VALENTINE_PRESENT(roleId, gifts)
    TFDirector:send(c2s.VALENTINE_VALENTINE_PRESENT, {roleId, gifts})
end

function ValentineDataMgr:onRecvValentineRank(event)
    local data = event.data
    local circleMinu = data.circleMinu
    local rankData = data.rankInfo
    if data.rankInfo then
        self.valentineRankRole_ = {}
        for i, v in ipairs(rankData) do
            self.tacitInfo_[v.roleid] = v.privity
            self.valentineRankRole_[i] = v.roleid
        end
    end
    EventMgr:dispatchEvent(EV_VALENTINE_RANK_UPDATE)
end

function ValentineDataMgr:onRecvValentineCompose(event)
    local data = event.data
    if not data.rewards then return end
    EventMgr:dispatchEvent(EV_VALENTINE_COMPOSE, data.rewards)
end

function ValentineDataMgr:onRecvValentineGift(event)
    local data = event.data
    EventMgr:dispatchEvent(EV_VALENTINE_GIFT)
end

function ValentineDataMgr:onRecvValentineInfo(event)
    local data = event.data
    if not data.datingCids then return end
    for i, v in ipairs(data.datingCids) do
        self.completedDatings_[v] = true
    end
end

function ValentineDataMgr:onRecvValentineNewDating(event)
    local data = event.data
    if not data.datingCid then return end
    self.completedDatings_[data.datingCid] = true
    EventMgr:dispatchEvent(EV_VALENTINE_COMPLETE_DATING)
end

return ValentineDataMgr:new()
