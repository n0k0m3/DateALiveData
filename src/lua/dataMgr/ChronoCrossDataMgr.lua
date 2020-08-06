
local BaseDataMgr = import(".BaseDataMgr")
local ChronoCrossDataMgr = class("ChronoCrossDataMgr", BaseDataMgr)
local UserDefalt = CCUserDefault:sharedUserDefault()
function ChronoCrossDataMgr:init()

    TFDirector:addProto(s2c.ACTIVITY_RESP_GET_ZZALL_RANK, self, self.onRecvRank)
    TFDirector:addProto(s2c.ACTIVITY_RESP_GET_ZZALL_SERVER, self, self.onRecvSevrverPoint)
    TFDirector:addProto(s2c.ACTIVITY_RESP_ACTIVITY_NOTICE, self, self.onRecvNotice)
    TFDirector:addProto(s2c.ACTIVITY_RESP_RECOVER_TIME, self, self.onRecvRecoverTime)

    self:reset()
end

function ChronoCrossDataMgr:reset()

    self.rankInfo = {}
    self.serverContribution = 0
    self.report = {}
    self.dialogState = false
end

function ChronoCrossDataMgr:onLogin()
    self:initChronoDialogId()
end

function ChronoCrossDataMgr:initChronoDialogId()
    self.saveInfo = {}
    local pid = MainPlayer:getPlayerId()
    local saveStr = UserDefalt:getStringForKey("ChronoDialogId"..pid)
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

function ChronoCrossDataMgr:setDialogPlayState(dialogState)
    self.dialogState = dialogState
end

function ChronoCrossDataMgr:getDialogPlayState()
    return self.dialogState
end

function ChronoCrossDataMgr:isPlayed(dialogId)
    return self.saveInfo[dialogId]
end

function ChronoCrossDataMgr:saveDialogId(dialogId)

    if self.saveInfo[dialogId] then
        return
    end
    self.saveInfo[dialogId] = 1
    local pid = MainPlayer:getPlayerId()
    local saveStr = UserDefalt:getStringForKey("ChronoDialogId"..pid)
    saveStr = saveStr.."|"..dialogId
    UserDefalt:setStringForKey("ChronoDialogId"..pid,saveStr)
    UserDefalt:flush()
end

function ChronoCrossDataMgr:playCg(dialogId,callback)

    if self.saveInfo[dialogId] then
        return
    end
    self:saveDialogId(dialogId)
    local function screenCallback()
        KabalaTreeDataMgr:playStory(1,dialogId,function ()
            EventMgr:dispatchEvent(EV_CG_END,function()
                if callback then
                    callback()
                end
            end)

        end)
    end
    KabalaTreeDataMgr:openCgView("kabalaTree.KabalaTreeCg",screenCallback)
end

function ChronoCrossDataMgr:getRankData()
    return self.rankInfo
end

function ChronoCrossDataMgr:getServerPoint()
    return self.serverContribution
end

function ChronoCrossDataMgr:getReportList()
    return self.report
end

function ChronoCrossDataMgr:getLastRefreshTime()
    return self.recoverTime
end

function ChronoCrossDataMgr:onRecvRank(event)
    local data = event.data
    if not data then
        return
    end
    self.rankInfo = data.rank or {}
    EventMgr:dispatchEvent(EV_UPDATE_CHRONOCROSS_RANK)
end

function ChronoCrossDataMgr:onRecvSevrverPoint(event)
    local data = event.data
    if not data then
        return
    end
    self.serverContribution = data.serverContribution or 0
    EventMgr:dispatchEvent(EV_UPDATE_SERVERPOINT)
end

function ChronoCrossDataMgr:onRecvNotice(event)
    local data = event.data
    if not data then
        return
    end
    local name = data.name
    local contribution = data.contribution
    if name and contribution then
        table.insert(self.report,{name = name,value = contribution})
        EventMgr:dispatchEvent(EV_UPDATE_NOTICE)
    end

end

function ChronoCrossDataMgr:onRecvRecoverTime(event)
    local data = event.data
    if not data then
        return
    end
    local recoverTime = data.recoverTime
    if recoverTime then
        self.recoverTime = recoverTime
        EventMgr:dispatchEvent(EV_UPDATE_LASTTIME,recoverTime)
    end
end

return ChronoCrossDataMgr:new()
