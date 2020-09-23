local CommonManager = class("CommonManager")

CommonManager.TRY_RECONNECT_NET        = "CommonManager.TRY_RECONNECT_NET"    --网络重连
CommonManager.tipData  = nil
function CommonManager:ctor()
    self.engineWillRestart = function(event)
        MainPlayer:reset()
        AlertManager:clearAllCache()
        TFAudio.stopAllEffects();
        TFAudio.stopMusic();
        MainPlayer.firstLoginMark = true
        LogonHelper:setIsLogin(false);
        TFDirector:closeSocket()
        connection_status = 0
        hideAllLoading();
    end
    self.TryReLoginFailTimes = 0
    self.ipArray = TFArray:new()
    self.connectedArray = TFArray:new()
    TFAssetsManager:init(1)

    TFDirector:addMEGlobalListener("Engine_Will_Restart", self.engineWillRestart)
    TFDirector:addProto(s2c.LOGIN_ENTER_SUC, self, self.loginHandle)
    TFDirector:addProto(s2c.PLAYER_RES_TIP_INFO, self, self.onTipInfoHandle) --服务器作弊信息提示

    EventMgr:addEventListener(self, EV_RECONECT_EVENT, function()
            self.TryReLoginFailTimes = 0
        end)
end

function CommonManager:onTipInfoHandle(event)
    local data   = event.data
    local status = data.status
    dump(data)
    if status == 0 then
        Utils:showTips(data.content)
    else
        if data.status == 2 or data.status == 3 then 
            CommonManager.tipData = data
        end
        local EC_GameAlertParams           = clone(EC_GameAlertParams)
        EC_GameAlertParams.msg             = data.content
        EC_GameAlertParams.showtype        = 1
        EC_GameAlertParams.outsideClose    = false
        EC_GameAlertParams.comfirmCallback = function ()
            CommonManager.tipData  = nil
            if data.status == 1 then   --关闭弹框
            elseif data.status == 2 then --返回登录
                NetWork:ForceLogout()--被踢下线
            elseif data.status == 3 then --退出游戏
                me.Director:endToLua()
            end
        end
        showGameAlert(EC_GameAlertParams)
    end
end


function CommonManager.checkTipEvent()
    if CommonManager.tipData then
        local data = CommonManager.tipData
        local EC_GameAlertParams           = clone(EC_GameAlertParams)
        EC_GameAlertParams.msg             = data.content
        EC_GameAlertParams.showtype        = 1
        EC_GameAlertParams.outsideClose    = false
        EC_GameAlertParams.comfirmCallback = function ()
            CommonManager.tipData  = nil
            if data.status == 1 then   --关闭弹框
            elseif data.status == 2 then --返回登录
                NetWork:ForceLogout()--被踢下线
            elseif data.status == 3 then --退出游戏
                me.Director:endToLua()
            end
        end
        showGameAlert(EC_GameAlertParams)
    end
end

function CommonManager:restart()

end


--add by david.dai
--是否掉线自动重连
local autoConnect = true
--连接状态，0：无连接；1：连接活动中
local connection_status = 0

function CommonManager:closeConnection()
    dump("closeConnection")
    --self:setAutoConnect(false)
    Utils:setScreenOrientation(SCREEN_ORIENTATION_LANDSCAPE)
    NetWork:reset();
    MainPlayer.firstLoginMark = true
    MainPlayer:reset()
    LogonHelper:setIsLogin(false);
    TFDirector:closeSocket()
    MainPlayer:stopHeartBeat()
    connection_status = 0
    hideAllLoading();
    TFAudio.stopAllEffects();
    TFAudio.stopMusic();
    AlertManager:clearAllCache()
    restartLuaEngine("CompleteUpdate")
    if TFIMManager then
        TFIMManager:Logout()
    end
end

function CommonManager:closeConnection2()
    --self:setAutoConnect(false)
    dump("closeConnection2")
    Utils:setScreenOrientation(SCREEN_ORIENTATION_LANDSCAPE)
    self:setChristmasBagFlage(false)
    NetWork:reset();
    MainPlayer.firstLoginMark = true
    MainPlayer:reset()
    LogonHelper:setIsLogin(false);
    TFDirector:closeSocket()
    MainPlayer:stopHeartBeat()
    connection_status = 0
    hideAllLoading();
    --restartLuaEngine("CompleteUpdate")
    local currentScene = Public:currentScene();
    if currentScene.__cname ~= "LoginScene" then
        TFAudio.stopAllEffects();
        TFAudio.stopMusic();
        AlertManager:clearAllCache()
        EventMgr:reset()
        AlertManager:changeScene(SceneType.LOGIN,true);
    end

    if TFIMManager then
        TFIMManager:Logout()
    end
end

function CommonManager:closeConnection3()
    --self:setAutoConnect(false)
    dump("closeConnection3")
    Utils:setScreenOrientation(SCREEN_ORIENTATION_LANDSCAPE)
    NetWork:reset();
    MainPlayer.firstLoginMark = true
    MainPlayer:reset()
    LogonHelper:setIsLogin(false);
    connection_status = 0
    hideAllLoading();
    EventMgr:reset()
    --restartLuaEngine("CompleteUpdate")
    local currentScene = Public:currentScene();
    if currentScene.__cname ~= "LoginScene" then
        TFAudio.stopAllEffects();
        TFAudio.stopMusic();
        EventMgr:reset();
        AlertManager:clearAllCache()
        AlertManager:changeScene(SceneType.LOGIN,true);
    end

    if TFIMManager then
        TFIMManager:Logout()
    end
end

function CommonManager:setAutoConnect(enabled)
    autoConnect = enabled
end

function CommonManager:loginServer(re)
    dump(connection_status,"============loginServer connection_status ")
    dump(autoConnect,"============loginServer autoConnect ")
    dump(MainPlayer.firstLoginMark,"============loginServer MainPlayer.firstLoginMark ")
    local function __loginServer()
        if connection_status == 0 then
            if autoConnect then
                self:connectServer(true)
            end
        else
            self:sendLogin(re)
        end
    end

    __loginServer()
end

--连接服务器
function CommonManager:connectServer(requestLogin)
    if connection_status ~= 0 then
        return
    end

    local serverInfo = SaveManager:getServerInfoDemo()
    local serverInfo = SaveManager:getServerInfoDemo();
    if serverInfo == nil then
        --toastMessage("请选择服务器")
        toastMessageLink(localizable.CommonManager_choose_server)
        return
    end

    showLongLoading()

    -- local addressTable = string.split(serverInfo.address,":")
    -- local ip = addressTable[1]
    -- local port = addressTable[2]
    local serverInfo = ServerDataMgr:getCurrentServerInfo();
    local ip = serverInfo.gameServerIp;
    local port = serverInfo.gameServerPort;
    dump({ip = ip,port = port})

    self.ipArray:clear()
    local ipList = string.split(ip, ",")
    for _,_ip in ipairs(ipList) do
        self.ipArray:push(_ip)
    end
    local connectIp = ""
    if self.connectedArray:length() <= 0 then
        connectIp = self.ipArray:front()
    else
        local connectedIp = self.connectedArray:back()
        local connectedIpIdx = self.ipArray:indexOf(connectedIp)
        connectIp = self.ipArray:getObjectAt((((connectedIpIdx + 1) - 1)%self.ipArray:length()) + 1)
    end
    self.connectedArray:push(connectIp)
    TFDirector:connect(connectIp, port,
    function (nResult)
        self:connectHandle(nResult,requestLogin)
    end,
    nil,
    function (nResult)
        self:connectionClosedCallback(nResult)
    end)
    local time = 0
    for _ip in self.connectedArray:iterator() do
        if _ip == connectIp then
            time = time + 1
        end
    end
    if HeitaoSdk and time <= 1 then
        HeitaoSdk.reportNetworkData(connectIp)
    end
end

--连接打开的回调方法，当连接创建成功后会由系统调用此方法
function CommonManager:connectHandle(nResult,requestLogin)

    dump(nResult,"-- CommonManager:connectHandle nResult = ")
    dump(requestLogin,"-- CommonManager:connectHandle requestLogin")
    TFDirector:setEncodeKeys({0xac, 0x12, 0x19, 0xcd, 0x95, 0x34, 0xcb, 0xf1})
    --
    if nResult then
        if nResult == 1 then
            connection_status = 1
            if requestLogin then
                local currentScene = Public:currentScene();
                if currentScene ~= nil then
                    if currentScene.__cname == "LoginScene" then
                        self:sendLogin();
                        self.TryReLoginFailTimes = 0
                    else
                        self:sendLogin(true);
                        --self.TryReLoginFailTimes = 0
                    end
                end
            end
        -- 连接失败
        elseif nResult == -2 or nResult == -1 then
            dump(TextDataMgr:getText(800121))
            local currentScene = Public:currentScene()
            --dump(currentScene:getTopLayer().__cname," connectHandle __cname ")
            if currentScene ~= nil and currentScene.getTopLayer then
                -- 登陆界面
                if currentScene.__cname == "LoginScene" then
                    hideAllLoading();
                    toastMessageLink(TextDataMgr:getText(800121))
                    EventMgr:dispatchEvent(EV_EXT_ASSET_DOWNLOAD_VIEW_CLOSE)
                    TFAssetsManager:init(1)
                else
                    self:reConnectServer(true);
                end
            else
                self:reConnectServer();
            end
        end
    else
        self:reConnectServer();
    end
end

function CommonManager:reConnectServer(re)
    local currentScene = Public:currentScene()
    if currentScene ~= nil and currentScene.getTopLayer and currentScene.__cname == "LoginScene" then
        hideAllLoading()
        toastMessageLink(TextDataMgr:getText(800121));
        EventMgr:dispatchEvent(EV_EXT_ASSET_DOWNLOAD_VIEW_CLOSE)
        TFAssetsManager:init(1)
        return;
    end

    local function __reConnectServer(times,re)
        local __times = times or self.TryReLoginFailTimes;
        if __times <= 3 then
            self:loginServer(re);
        else
            -- toastMessageLink("与服务器断开");
            toastMessageLink(TextDataMgr:getText(800122));
            EventMgr:dispatchEvent(EV_EXT_ASSET_DOWNLOAD_VIEW_CLOSE)
            TFAssetsManager:init(1)
            self:closeConnection3();
            return;
        end
        
        toastMessageLink(string.format(TextDataMgr:getText(800123,__times)));
    end

    self.TryReLoginFailTimes = self.TryReLoginFailTimes + 1;
    dump(self.TryReLoginFailTimes,"times");
    showLongLoading()

    if CC_PLATFORM_ANDROID == CC_TARGET_PLATFORM then
        if self.TryReLoginFailTimes > 3 then
            return;
        end

        local times = self.TryReLoginFailTimes;
        local delay = 5*(times - 1);
        TimeOut(function()
                __reConnectServer(times,re);
            end,delay);
    else
        __reConnectServer(nil,re);
    end
end


--发送登录服务器请求
function CommonManager:sendLogin(re)

    dump("CommonManager:sendLogin()==================")
    
    showLongLoading()

    --游戏服连接成功 开始心跳
    MainPlayer:startHeartBeat();

    local token = SaveManager:getCurrentToken();
    if not token or token:len() < 1 then
        token = "NULL"
    end

    local loginMsg =
    {
        token,
        MainPlayer:getAntiAddcationStatus(),
    }
    
    local nResult = 0;
    if re then
        dump(loginMsg,"send relogin : ")
        nResult = TFDirector:send(c2s.LOGIN_REQ_RECONNECT, loginMsg)    --重连不加密c2s.LOGIN_REQ_RECONNECT
    else
        dump(loginMsg,"send login : ")
        nResult = TFDirector:send(c2s.LOGIN_ENTER_GAME, loginMsg)    --不加密
    end
    dump(nResult,"nResult")
    TFDirector:setEncodeKeys({1,2,3,4,5,6,7,8})
    if nResult and nResult < 0 then
        self:reConnectServer();
        return
    end
    if re == nil then
        TFAssetsManager:runManager()
    end
end

function CommonManager:loginHandle(event)
    if event.data then
        dump(event.data.queue);        
        if event.data.queue and event.data.queue > 0 then
            LoginWatingDataMgr:updateLoginWaiting(event.data.queue,event.data.queueTime)
            return
        end

		LoginWatingDataMgr:closeLoginWaiting()    
        MainPlayer:initPlayerInfo(event.data.playerinfo);
        ServerDataMgr:initServerTime(event.data.serverTime)
        MainPlayer:onLogin(event)
    else
		hideAllLoading()
        EventMgr:dispatchEvent(EV_EXT_ASSET_DOWNLOAD_VIEW_CLOSE)
        TFAssetsManager:init(1)
        -- toastMessageLink("登录游戏服失败")
		toastMessageLink(TextDataMgr:getText(800124))
    end
end

--获取当前的连接状态，true为连接 false为掉线
function CommonManager:getConnectionStatus()
    return connection_status ~= 0;
end


--连接关闭的回调方法，当连接关闭后会由系统调用此方法
function CommonManager:connectionClosedCallback(nResult)

    dump(nResult,"-- CommonManager:connectionClosedCallback nResult ")
    connection_status = 0
    hideAllLoading()

    local scene = Public:currentScene();
    if scene.__cname ~= "LoginScene" then --断线派发事件
        EventMgr:dispatchEvent(EV_OFFLINE_EVENT)
    end

    MainPlayer:stopHeartBeat()
    
    local currentScene = Public:currentScene()
    --dump(currentScene:getTopLayer().__cname," connectHandle __cname ")
    if currentScene ~= nil and currentScene.getTopLayer then
        -- 登陆界面
        if currentScene.__cname == "LoginScene" then
            -- toastMessageLink("登录游戏服失败");
            toastMessageLink(TextDataMgr:getText(800124))
            EventMgr:dispatchEvent(EV_EXT_ASSET_DOWNLOAD_VIEW_CLOSE)
            TFAssetsManager:init(1)
            return
        end
    end

    if self.TryReLoginFailTimes > 3 then
        return
    end

    if  autoConnect then
        dump("autoConnect is ture")
    end

    if MainPlayer.firstLoginMark  then
        dump("MainPlayer.firstLoginMark  is ture")
    end

    dump("connection_status = ", connection_status)

    self:reConnectServer(true);
end


function CommonManager:setLoginCompleteState( state )
    self.loginCompleteState = state
end

function CommonManager:checkLoginCompleteState()
    if self.loginCompleteState then
        return true
    end
    return false
end

function CommonManager:heartBeatcloseConnection()
    self:setAutoConnect(true)
    MainPlayer.firstLoginMark = false
    TFDirector:closeSocket()
    connection_status = 0
    self.TryReLoginFailTimes = 0;
end

function CommonManager:autoFixRes()
    local sdPath        = ""
    local sPackName     = ""
    local updatePath    = ""
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        updatePath = CCFileUtils:sharedFileUtils():getWritablePath()
        updatePath = updatePath .. '../Library/'
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        sdPath      = TFDeviceInfo.getSDPath()  
        sPackName   = TFDeviceInfo.getPackageName()
        updatePath  = sdPath .."playmore/" .. sPackName .. "/"
    else
        updatePath = updatePath .. "../Library/"
    end

    NetWork:reset();
    MainPlayer.firstLoginMark = true
    MainPlayer:reset()
    LogonHelper:setIsLogin(false);
    TFDirector:closeSocket()
    connection_status = 0
    hideAllLoading();

    TFAudio.stopAllEffects();
    TFAudio.stopMusic();

    CCFileUtils:sharedFileUtils():removeDirectory(updatePath)
    CCFileUtils:sharedFileUtils():purgeCachedEntries()

    local oldVersion = "1.0.01"
    local content = io.readfile("src/TFFramework/net/TFClientUpdate.lua") or 'newUpdateFun:SetUpdateDefaultVersion("1.0.01")'
    string.gsub(content, 'SetUpdateDefaultVersion%("(.-)"%)', function(version)
        oldVersion = version
    end)
    local TFClientUpdateNew =  TFClientResourceUpdate:GetClientResourceUpdate()
    TFClientUpdateNew:SetUpdateDefaultVersion(oldVersion)
    TFClientUpdateNew:ResetVersionAndDownloadNewResource()
    AlertManager:clearAllCache();
    self:closeConnection2();

    if CC_PLATFORM_IOS == CC_TARGET_PLATFORM then
        TFDirector:send(1539,{})
    end

    TFFileUtil:createDir(updatePath)
    restartLuaEngine("")
end

--记录5星评价
function CommonManager:setStarEvaluateFlage(evaluateFlage)
    self.evaluateFlage = evaluateFlage
end

function CommonManager:getStarEvaluateFlage()
    return self.evaluateFlage
end

--记录是否打开过萌新礼包
function CommonManager:saveNewGuyGifyBagFlage()
    
    local playerId = MainPlayer:getPlayerId()
    CCUserDefault:sharedUserDefault():setBoolForKey(playerId.."NewGuyGify",true)
    CCUserDefault:sharedUserDefault():flush() 
end

function CommonManager:getNewGuyGifyBagFlage()

    local playerId = MainPlayer:getPlayerId()
    local flag = CCUserDefault:sharedUserDefault():getBoolForKey(playerId.."NewGuyGify")
    return flag
end

function CommonManager:getNewGuyGiftBagIsCanJumpSecond( ... )
    local playerId = MainPlayer:getPlayerId()
    local serverTime =  ServerDataMgr:customUtcTimeForServerTimestap()
    local saveTime = CCUserDefault:sharedUserDefault():getIntegerForKey(playerId.."NewGuyGifySecond")
    local isJumpSecond = CCUserDefault:sharedUserDefault():getBoolForKey(playerId.."NewGuyGifySecondJump")
    if not isJumpSecond and ( (saveTime > 0 and serverTime - saveTime > 24 * 3600 ) or saveTime <= 0 )  then
        CCUserDefault:sharedUserDefault():setBoolForKey(playerId.."NewGuyGifySecondJump" , true)
        return true
    end
    return false
end

--记录萌新礼包二次弹出时间点
function CommonManager:saveNewGuyGiftBagIsCanJumpSecond( ... )
    local playerId = MainPlayer:getPlayerId()
    local saveTime = CCUserDefault:sharedUserDefault():getIntegerForKey(playerId.."NewGuyGifySecond")
    if saveTime > 0 then
        return
    end
    local serverTime =  ServerDataMgr:customUtcTimeForServerTimestap()
    CCUserDefault:sharedUserDefault():setIntegerForKey(playerId.."NewGuyGifySecond" ,serverTime)
end

function CommonManager:setChristmasBagFlage(christmasBagOpen)
    self.christmasBagOpen = christmasBagOpen
end

function CommonManager:getChristmasBagFlage()
    return self.christmasBagOpen
end

function CommonManager:setFirstLoginIn(state)
    self.firstLogin = state
end

function CommonManager:getFirstLoginIn()

    return self.firstLogin
end

return CommonManager:new();
