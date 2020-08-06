local BaseDataMgr = import(".BaseDataMgr")
local ShareDataMgr = class("ShareDataMgr", BaseDataMgr)
local UserDefalt = CCUserDefault:sharedUserDefault()
function ShareDataMgr:ctor()
    self:init()
    self.shareInfo = {}
end

--"2019/07/31 00:00:00"
local function _getTimeByDate(r)
    local a = string.split(r, " ")
    local b = string.split(a[1], "/")
    local c = string.split(a[2], ":")
    local t = os.time({year=b[1],month=b[2],day=b[3], hour=c[1], min=c[2], sec=c[3]})
    return t
end

function ShareDataMgr:init()
	TFDirector:addProto(s2c.SHARE_RESP_SHARE_INFOS, self, self.onRecvShareInfo)
    TFDirector:addProto(s2c.SHARE_RESULT_SUBMIT_SHARE, self, self.onRecvShareAward)
    TFDirector:addProto(s2c.SHARE_RESULT_SHARE, self, self.onRecvShare)
    TFDirector:addProto(s2c.PLAYER_RESP_YEAR_RESUME_INFO, self, self.onRecvPlayerResumeInfo)

end

function ShareDataMgr:initOpenTipFlag()
    local pid = MainPlayer:getPlayerId()
    local tip = UserDefalt:getStringForKey("OneYearShare"..pid)
    self.openTip = tonumber(tip) or 0
end

function ShareDataMgr:setOpenTipFlag()
    self.openTip = 1
    local pid = MainPlayer:getPlayerId()
    UserDefalt:setStringForKey("OneYearShare"..pid,self.openTip)
end

function ShareDataMgr:getOpenTipFlag()
    return self.openTip
end

function ShareDataMgr:getActivityShareData()
    if not self.activityShareData then 
        local data = TabDataMgr:getData("Share",2)
        self.activityShareData = clone(data)
        self.activityShareData.titleIcon     =  self.activityShareData.icon
        self.activityShareData.activityType  =  EC_ActivityType2.ANNIVERSARY_PREHEAT
        self.activityShareData.id            =  101
        self.activityShareData.rank          =  self.activityShareData.activityType
        -- self.activityShareData.extendData    =  {}
        self.activityShareData.startTime     =  _getTimeByDate(self.activityShareData.startDate)
        self.activityShareData.endTime       =  _getTimeByDate(self.activityShareData.endDate)
        self.activityShareData.showStartTime =  self.activityShareData.startTime
        self.activityShareData.showEndTime   =  self.activityShareData.endTime
        self.activityShareData.ct            = 0  
    end
    return self.activityShareData
end


function ShareDataMgr:onLogin()
    self.playerResumeTab = nil
    self:initOpenTipFlag()
    TFDirector:send(c2s.SHARE_REQ_SHARE_INFOS, {})
    return {s2c.SHARE_RESP_SHARE_INFOS}
end

function ShareDataMgr:getShareInfo()
    return self.shareInfo
end

function ShareDataMgr:getShareInfoById(id)
    if id then 
        return self.shareInfo[id]
    end
    for k,v in pairs(self.shareInfo) do
        return v
    end
end

function ShareDataMgr:setShareOpenFlag(id)
    if not self.shareInfo[id] then
        return
    end
    self.shareInfo[id].show = false
end

--分享次数
function ShareDataMgr:getShareNum()
    local data = MainPlayer:getGuideStep()
    if data then 
        return  data.shareNum
    end
    return 0
end

function ShareDataMgr:Send_GetResumeInfo()
    TFDirector:send(c2s.PLAYER_REQ_YEAR_RESUME_INFO, {})
end

---获取履历信息
function ShareDataMgr:getResumeTab()
    return self.playerResumeTab
end

function ShareDataMgr:onRecvShareInfo(event)
	local data = event.data
    if not data then 
    	return 
    end

    if not data.shareInfos then
        return
    end

    for k,v in ipairs(data.shareInfos) do
        self.shareInfo[v.id] = v
    end

    --TODO 分享数据在活动显示
    local activityData = self:getActivityShareData()
    activityData.extendData = nil
    local serverTime = ServerDataMgr:getServerTime()
    if serverTime > activityData.startTime and serverTime < activityData.endTime then 
        ActivityDataMgr2:__handleActivity({activityData})
    end
    EventMgr:dispatchEvent(EV_SHOW_SHARE);
end

function ShareDataMgr:onRecvShare(event)
    local data = event.data
    if not data then 
        return 
    end
end

function ShareDataMgr:onRecvShareAward(event)

    local data = event.data
    if not data then 
        return 
    end
    EventMgr:dispatchEvent(EV_SHOW_AWARD,data.id,data.rewards);
end

function ShareDataMgr:onRecvPlayerResumeInfo(event)

    local data = event.data
    if not data then
        return
    end

    self.playerResumeTab = {}
    local playerResumeJson = data.record or ""
    local json = json.decode(playerResumeJson)
    for k,v in pairs(json) do
        local id = tonumber(k)
        if id == EC_PlayerResume.NAME or id == EC_PlayerResume.FIRST_FRIEND_NAME then
            v = string.htmlspecialchars(v)
        end
        self.playerResumeTab[k] = v
    end
    EventMgr:dispatchEvent(EV_UPDATE_RESUME);
end

return ShareDataMgr:new();
