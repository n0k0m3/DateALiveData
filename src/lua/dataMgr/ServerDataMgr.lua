
local BaseDataMgr = import(".BaseDataMgr")
local ServerDataMgr = class("ServerDataMgr", BaseDataMgr)

function ServerDataMgr:init()
    self.serverTime_ = 0
    self.onlineTime_ = 0
    self.localTime_ = 0

    if GameConfig.Debug then
        self.server_ = {
            {
                id = 100001,
                group_id = 60,
                groupName = "内网_minlang_dev",
                serverGroup = "minlang_dev",
                groupType = GLOBAL_SERVER_LIST.SERVER_NIMILANGUAGE
            },
            {
                id = 100002,
                group_id = 20,
                groupName = "内网-eng_dev",
                serverGroup = "eng_dev",
                groupType = GLOBAL_SERVER_LIST.SERVER_ENGLISH
            },
            {
                id = 100003,
                group_id = 80,
                groupName = "韩台_dev",
                serverGroup = "hantai_dev",
                groupType = GLOBAL_SERVER_LIST.SERVER_KOREA_TW
            },
            {
                id = 100004,
                group_id = 65,
                groupName = "程序自用分组_minlang",
                serverGroup = "chengxu",
                list ={
                    {
                        serverId = 660,
                        serverName= "yuxie",
                    },
                    {
                        serverId = 651,
                        serverName= "liuwei",
                    },
                },
                groupType = GLOBAL_SERVER_LIST.SERVER_NIMILANGUAGE
            },
            {
                id = 100005,
                group_id = 25,
                groupName = "程序自用分组_en",
                serverGroup = "chengxu",
                list ={
                    {
                        serverId = 260,
                        serverName= "yuxie",
                    },
                    {
                        serverId = 251,
                        serverName= "liuwei",
                    },
                },
                groupType = GLOBAL_SERVER_LIST.SERVER_ENGLISH
            },
            {
                id = 100006,
                group_id = 85,
                groupName = "程序自用分组_韩台",
                serverGroup = "chengxu",
                list ={
                    {
                        serverId = 761,
                        serverName= "hujutao",
                    },
                    {
                        serverId = 760,
                        serverName= "yuxie",
                    },
                },
                groupType = GLOBAL_SERVER_LIST.SERVER_KOREA_TW
            },
            {   
                -- 小语种策划服
                id = 100007,
                group_id = 38,
                groupName = "策划_minlang",
                serverGroup = "cehua",
                list ={
                    {
                        url = {
                            [1] = "http://148.153.75.131:7070/account/login"
                        }
                    },
                },
                groupType = GLOBAL_SERVER_LIST.SERVER_NIMILANGUAGE
            },
            {
                -- 英文策划服(暂时用小语种)
                id = 100008,
                group_id = 888,
                groupName = "策划_eng",
                serverGroup = "cehua",
                list ={
                    {
                        url = {
                            [1] = "http://148.153.55.228:7070/account/login"
                        }
                    },
                },
                groupType = GLOBAL_SERVER_LIST.SERVER_ENGLISH
            },
        }
    else
        --TODO
        -- self.server_ = {
        --     {   
        --         -- 小语种策划服
        --         id = 200001,
        --         group_id = 888,
        --         groupName = "minlang_cehua",
        --         serverGroup = "cehua",
        --         list ={
        --             {
        --                 serverId = 888001,
        --                 serverName= ""
        --             },
        --         },
        --         groupType = GLOBAL_SERVER_LIST.SERVER_NIMILANGUAGE
        --     },
        --     {
        --         -- 英文策划服(暂时用小语种)
        --         id = 200002,
        --         group_id = 888,
        --         groupName = "eng_cehua",
        --         serverGroup = "cehua",
        --         list ={
        --             {
        --                 serverId = 888001,
        --                 serverName= ""
        --             },
        --         },
        --         groupType = GLOBAL_SERVER_LIST.SERVER_ENGLISH
        --     }
        -- }
        
        self.server_ = {
            {
                -- 英文正式服
                id = 200003,
                group_id = 28,
                groupName = "Server I",
                serverGroup = "eng",
                groupType = GLOBAL_SERVER_LIST.SERVER_ENGLISH
            },
            {   
                -- 小语种正式服
                id = 200004,
                group_id = 32,
                groupName = "Server II",
                serverGroup = "xyz_server",
                groupType = GLOBAL_SERVER_LIST.SERVER_NIMILANGUAGE
            },
            {   
                -- 小语种正式服
                id = 200005,
                group_id = 32,
                groupName = "Server III",
                serverGroup = "xyz_server",
                groupType = GLOBAL_SERVER_LIST.SERVER_KOREA_TW
            }
        }
        
    end

    self.gameSeverList = {}
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

--TODO CLOSE 英文版时间戳换算UTC-7 服务器下发UTC-7时间戳 则本地转换需要同步使用UTC-7计算
function ServerDataMgr:customUtcTimestap(timestamp, timeZone )
    timeZone = timeZone or GV_UTC_TIME_ZONE
    local serverTime = timestamp + (os.time() - self.localTime_)
    local timeInterval = os.time(os.date("!*t", serverTime)) + timeZone * 3600 + (os.date("*t", time).isdst and -1 or 0) * 3600  --isdst是否夏令时决定加一或者不加1小时
    return timeInterval
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

function ServerDataMgr:getGroupList( )
    if GameConfig.Debug then return self.server_ end
    local list = {}
    for i,_serverInfo in ipairs(self.server_) do
        if TFGlobalUtils:isGameServerOpen(_serverInfo.groupType) then
            table.insert(list, _serverInfo)
        end
    end
    table.sort(list, function( a,b )
        -- body
        return a.id < b.id
    end)
    return list
end

function ServerDataMgr:getGroupById( groupCfgId, group_id )
    for _, _server in ipairs(self.server_) do
        if _server.id == groupCfgId and _server.group_id == group_id then
            return _server
        end
    end
end

function ServerDataMgr:getGroupNameById( groupCfgId, group_id )
    for _, _server in ipairs(self.server_) do
        if groupCfgId == _server.id and  _server.group_id == group_id then
            return _server.groupName
        end
    end
    return ""
end

function ServerDataMgr:getServerNameById( groupCfgId, serverId )
    for _, _server in ipairs(self.server_) do
        if _server.id == groupCfgId then
            if _server.list then
                for _,_serverInfo in ipairs(_server.list) do
                    if _serverInfo.serverId == serverId then
                        return _serverInfo.serverName
                    end
                end
            end
        end
    end
    return nil
end

-- [[登录服结束]]--

-- [[游戏服开始]]--

function ServerDataMgr:setGameServerList(serverData)
    -- if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
    --     self.gameSeverList = {}
    --     serverData[2]= clone(serverData[1])
    --     serverData[2].groupName = serverData[1].groupName.."2"
    --     table.insert(self.gameSeverList,serverData[1]);
    --     table.insert(self.gameSeverList,serverData[2]);
    --     return
    -- end

    self.gameSeverList = serverData or {}
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

function ServerDataMgr:getServerGroupIdByIdx( serverIdx )
    for i,_info in ipairs(self.server_) do
        if serverIdx == _info.groupType then
            return _info.group_id
        end
    end
end

function ServerDataMgr:getServerCfgIdByIdx( serverIdx )
    for i,_info in ipairs(self.server_) do
        if serverIdx == _info.groupType then
            return _info.id
        end
    end
end

function ServerDataMgr:getServerGroupTypeById( id )
    for i,_info in ipairs(self.server_) do
        if _info.id == id then
            return _info.groupType
        end
    end
    return 0
end

function ServerDataMgr:getDefaultServerGroupCfgId( idx )
    for i,_info in ipairs(self.server_) do
        if _info.groupType == idx then
            return _info.id
        end
    end
end

function ServerDataMgr:getDefaultServerGroupId( idx )
    for i,_info in ipairs(self.server_) do
        if _info.groupType == idx then
            return _info.group_id
        end
    end
end

-- [[游戏服结束]]--

return ServerDataMgr:new()
