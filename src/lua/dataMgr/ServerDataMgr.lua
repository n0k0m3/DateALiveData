
local BaseDataMgr = import(".BaseDataMgr")
local ServerDataMgr = class("ServerDataMgr", BaseDataMgr)

function ServerDataMgr:init()
    self.serverTime_ = 0
    self.onlineTime_ = 0
    self.localTime_ = 0
    self.server_ = {
        ["chengxu"] = {
            sort = 1,
            name = "内网-程序",
            list = {
                "yuxie",
                "liuwei",
                "ouyangcheng",
            }
        },
        ["eng_dev"] = {
            sort = 2,
            name = "内网-eng_dev",
        },

        ["android_check"] = {
            sort = 3,
            url = {[1] = "http://uc-en.datealive.com:8081/account/login"}
        },

        ["ios_check"] = {
            sort = 4,
            url = {[1] = "https://uc-en.datealive.com:8082/account/login"} 
        },   

        ["cehua"] = {
            sort = 5,
            name = "外网-策划",
            url = {[1] = "http://148.153.55.228:7070/account/login"}
        }, 
        ["eng"] = {
            sort = 6,
            name = "外网-正式服",
            url = {[1] = "http://uc-en.datealive.com:8081/account/login"}
        }
    }

    TFDirector:addProto(s2c.LOGIN_RESP_SERVER_TIME, self, self.onRecvServerTime)
end
-- [[登录服开始]]--
function ServerDataMgr:reset()

end

function ServerDataMgr:onLoginOut()

end

function ServerDataMgr:onLogin()
    self:timerOnlineFunc()
end

function ServerDataMgr:initServerTime(time)
    self.serverTime_ = time
    self.localTime_ = os.time()
end

function ServerDataMgr:getServerTime()
    local serverTime = self.serverTime_ + (os.time() - self.localTime_)
    return serverTime
end

--转换自定义UTC时区 UTC+8 传入8 UTC-8传入-8 
function ServerDataMgr:customUtcTimeForServer()
    local timeInterval = self:customUtcTimeForServerTimestap(GV_UTC_TIME_ZONE)
    local timeTable = os.date("*t", timeInterval)
    return timeTable.hour , timeTable.min , timeTable.sec
end
function ServerDataMgr:customUtcTimeForServerTimestap( timeZone )
    timeZone = timeZone or GV_UTC_TIME_ZONE
    local serverTime = self.serverTime_ + (os.time() - self.localTime_)
    local timeInterval = os.time(os.date("!*t", serverTime)) + timeZone * 3600 + (os.date("*t", time).isdst and -1 or 0) * 3600  --isdst是否夏令时决定加一或者不加1小时
    return timeInterval
end
function ServerDataMgr:customUtcTimeForServerDate( )
    local timeInterval = self:customUtcTimeForServerTimestap(GV_UTC_TIME_ZONE)
    local timeTable = os.date("*t", timeInterval)
    return timeTable
end

function ServerDataMgr:getOnlineTime()
    return self.onlineTime_
end
    
function ServerDataMgr:timerOnlineFunc()
    if not self.timer_ then
        self.timer_ = TFDirector:addTimer(1000, -1, nil, function()
            self.onlineTime_ = self.onlineTime_ + 1
        end)
    end
end

function ServerDataMgr:onRecvServerTime(event)
    local data = event.data
    self:initServerTime(data.serverTime)
end

function ServerDataMgr:getServerList(serverGroup)
    if serverGroup then
        return self.server_[serverGroup]
    else
        return self.server_
    end
end
-- [[登录服结束]]--

-- [[游戏服开始]]--

function ServerDataMgr:setGameServerList(serverData)
    if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
        self.gameSeverList = {}
        serverData[2]= clone(serverData[1])
        serverData[2].groupName = serverData[1].groupName.."2"
        table.insert(self.gameSeverList,serverData[1]);
        table.insert(self.gameSeverList,serverData[2]);
        return
    end

    self.gameSeverList = serverData;
end

function ServerDataMgr:getGameServerList()
    return self.gameSeverList;
end

function ServerDataMgr:setCurrentServerIndex(index)
    self.currentServerIndex = index;
    local serverData = self.gameSeverList[index]
    CCUserDefault:sharedUserDefault():setIntegerForKey((TFDeviceInfo:getMachineOnlyID() or "serverKey"),index);

    local account,password = nil,nil;
    if CC_PLATFORM_WIN32 == CC_TARGET_PLATFORM then
        account,password = SaveManager:getUserInfoDemo();
    end

    SaveManager:saveUserInfoDemo(account,password,serverData.token,serverData.gameServerIp,serverData.gameServerPort);
end

function ServerDataMgr:getCurrentServerIndex()
    self.currentServerIndex = CCUserDefault:sharedUserDefault():getIntegerForKey((TFDeviceInfo:getMachineOnlyID() or "serverKey"));
    if self.currentServerIndex <= 0 then
        self.currentServerIndex = 1
    end

    return self.currentServerIndex or 1;
end

function ServerDataMgr:getCurrentServerName()
    local serverIndex = self:getCurrentServerIndex();
    if serverIndex > #self.gameSeverList then
        serverIndex = #self.gameSeverList;
    end
    return self.gameSeverList[serverIndex].groupName;
end

function ServerDataMgr:getCurrentServerInfo()
    local serverIndex = self:getCurrentServerIndex();
    if serverIndex > #self.gameSeverList then
        serverIndex = #self.gameSeverList;
    end
    return self.gameSeverList[serverIndex];
end

function ServerDataMgr:getCurrentServerID()
    local serverIndex = self:getCurrentServerIndex();
    if serverIndex > #self.gameSeverList then
        serverIndex = #self.gameSeverList;
    end
    return self.gameSeverList[serverIndex].serverId;
end

function ServerDataMgr:getServerGroupID(index)
    local serverIndex = index or self:getCurrentServerIndex();
    if serverIndex > #self.gameSeverList then
        serverIndex = #self.gameSeverList;
    end
    return self.gameSeverList[serverIndex].group_id or 0;
end

function ServerDataMgr:getCurrentServerHasRole(index)
    local serverIndex = index or self:getCurrentServerIndex();
    if serverIndex > #self.gameSeverList then
        serverIndex = #self.gameSeverList;
    end
    return self.gameSeverList[serverIndex].hasRole;
end

function ServerDataMgr:getLocalTime( ... )
    return self.localTime_
end
-- [[游戏服结束]]--

return ServerDataMgr:new()
