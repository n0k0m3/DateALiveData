local LogonHelper = class("LogonHelper")


local UserCenterHttpClient = TFClientNetHttp:GetInstance()

function LogonHelper:ctor(data)
    self.urlIdx = 0
    self.path = ""
    self.connectedArray = TFArray:new()

    self.account_ = nil
    self.password_ = nil
    self.code_ = nil
    self.isAuto_ = false
    self.isLogined = false;

    self.serverId_ = self:getCacheServerId()
    self.group_id = self:getCacheGroupId()
    self.groupCfgId = self:getCacheGroupCfgId()

    if HeitaoSdk then
        HeitaoSdk.setLoginOutCallBack(function()
                self:HeitaoSdkLoginOutCallBack()
            end)

        HeitaoSdk.setLogincallback(function(code, msg)
                self:HeitaoSdkLoginCallback(code, msg)
            end)
    end
end

function LogonHelper:HeitaoSdkLoginCallback(code, msg)
    if not HeitaoSdk then return end
    --处理回调函数
    dump(msg)
    -- if msg == "登录失败" then
    if msg == TextDataMgr:getText(800107) then
    -- elseif msg == "登录成功" then
    elseif msg == TextDataMgr:getText(800108) then
        --self:loginVerification();
        dump("EventMgr:dispatchEvent(LoginLayer.LoginSuccess)")
        Utils:sendHttpLog("sdk_login")
        EventMgr:dispatchEvent("LoginLayer.LoginSuccess")
    end
end

function LogonHelper:HeitaoSdkLoginOutCallBack()
    CommonManager:closeConnection2()
end

function LogonHelper:restart()
end

function LogonHelper:restartGame(tips)
    local function callback()
        restartLuaEngine("")
    end
    showMessageBox(tips , EC_MessageBoxType.okAndCancel,callback,callback)
end

local TFClientUpdate =  TFClientResourceUpdate:GetClientResourceUpdate()
function LogonHelper:loginTest(account,password,code,isAuto)
    if (self.groupCfgId == nil) or self.groupCfgId <= 0 then
        Utils:showTips(800090)
        return
    end

    showLongLoading()

    self.account_ = account
    self.password_ = password
    self.code_ = code
    self.isAuto_ = isAuto
    self.path = ""

    self.loginCallback = function (type,ret,data)
        TFGlobalUtils:setCacheServer(TFGlobalUtils:getPlayerServerIdx())
        data = json.decode(data);
        dump(data);
        if not data then
            self.isLogined = false;
            self:LoginUcCenterFailHandler(self.localLoginUrl)
            -- toastMessageLink("连接登录服务器失败")
            --toastMessageLink(TextDataMgr:getText(800114))
            return
        end

        --游戏资源需要更新
        if data.status and data.status == 100017 then
            hideAllLoading();
            self:restartGame(data.msg);
            return;
        end

        if data.status ~= 0 then
            hideAllLoading();
            self.isLogined = false;
            local text = TextDataMgr:getText(data.status);
            if data.status == 100036 then
                if (data.msg) then
                    text = data.msg
                end
            end
            Utils:showTips(text)
            SaveManager:saveIsActivat(false);
        else
            if not data.data then
                self:LoginUcCenterFailHandler(self.localLoginUrl)
                return
            end

            -- if data.data.openServerDate then
            --     local date = os.date("*t",data.data.openServerDate / 1000)
            --     toastMessageLink(string.format("本次测试服务器将于%d月%d日%d时开放，感谢您的关注！",date.month,date.day,date.hour));
            --     return
            -- end
            hideAllLoading();
            ServerDataMgr:setGameServerList(data.data)

            if GameConfig.Debug then
                self:cacheLoginInfo()
            end

            self.isLogined = true;
            SaveManager:saveIsActivat(true);

            if table.count(data.data) == 1 then
                SaveManager:saveUserInfoDemo(account,password,data.data[1].token,data.data[1].gameServerIp,data.data[1].gameServerPort);
            else
                local selectIdx = ServerDataMgr:getCurrentServerIndex();
                SaveManager:saveUserInfoDemo(account,password,data.data[selectIdx].token,data.data[selectIdx].gameServerIp,data.data[selectIdx].gameServerPort);
            end

            EventMgr:dispatchEvent(EV_LOGIN_UPDATESERVERNAME)

            if isAuto then
                return;
            end

            --TFDirector:dispatchGlobalEventWith("LoginLayer.LoginSuccess", {})
            EventMgr:dispatchEvent("LoginLayer.LoginSuccess")
        end
    end

    local osname = "WINDOWS"
    local token = "NULL"
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        osname = "IOS"
        token = TFDeviceInfo:getDeviceToken();
   elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        osname = "ANDROID"
    end

    local localLoginUrl = nil
    local serverGroupConfig = ServerDataMgr:getGroupById(self.groupCfgId, self.group_id)
    if serverGroupConfig and serverGroupConfig.list then
        for i = 1, #serverGroupConfig.list do
            local cfg = serverGroupConfig.list[i]
            if (cfg.url) then localLoginUrl = cfg.url end
        end
    end

    local path = ""
    path = path.."?accountId="..string.url_encode(account);
    path = path.."&password="..password;
    path = path.."&token="..token;
    path = path.."&deviceid="..((TFDeviceInfo:getMachineOnlyID()) or 1);
    path = path.."&deviceName="..((TFDeviceInfo:getSystemName()) or 1);
    path = path.."&osVersion="..((TFDeviceInfo:getSystemVersion()) or 1);
    path = path.."&osName="..osname;
    path = path.."&version="..TFClientUpdate:getCurVersion();
    path = path.."&sdkVersion=".."";
    path = path.."&sdk=".."";

    if FileCheckMgr then
        path = path.."&mimi="..FileCheckMgr:getIsSuccess();
    end

    if self.serverId_ and self.serverId_ > 0 then
        local serverName = ServerDataMgr:getServerNameById(self.groupCfgId, self.serverId_);
        serverName = serverName or ""
        path = path.."&serverName="..serverName
    end
    if serverGroupConfig and serverGroupConfig.serverGroup then
        path = path.."&serverGroup=" .. serverGroupConfig.serverGroup;
    end
    path = path.."&channelAppId="..1;
    path = path.."&channelId=".."LOCAL_TEST";
    if code and code ~= "" then
        path = path.."&activateKey="..code;
    end

    self.path = string.gsub(path," ","");
    --print(path);
    self.path = path

    self.localLoginUrl = localLoginUrl
    self:tryLoginUcCenter(localLoginUrl)

    --UserCenterHttpClient:addMERecvListener(self.loginCallback)
    --UserCenterHttpClient:httpRequest(TFHTTP_TYPE_GET,url)
end

function LogonHelper:loginVerification()
    if not HeitaoSdk then return end
    showLongLoading()

    self.account_ = account
    self.password_ = password
    self.code_ = code
    self.isAuto_ = isAuto
    self.path = ""

    self.loginCallback = function (type,ret,data)
        TFGlobalUtils:setCacheServer(TFGlobalUtils:getPlayerServerIdx())
        data = json.decode(data);
        if not data then
            self.isLogined = false;
            self:setVerification(false)
            self:LoginUcCenterFailHandler()
            -- toastMessageLink("连接登录服务器失败")
            -----toastMessageLink(TextDataMgr:getText(800114))
            return
        end
        dump(data);

        --游戏资源需要更新
        if data.status and data.status == 100017 then
            hideAllLoading();
            self:restartGame(data.msg);
            self.connectedArray:clear()
            return;
        end        

        if data.status ~= 0 then
            hideAllLoading();
            self:setVerification(false)
            local text = TextDataMgr:getText(data.status);
            if data.status == 100036 then
                text = text.."  "..data.msg
            end
            Utils:showTips(text)
            self.connectedArray:clear()
        else
            if not data.data then
                self:LoginUcCenterFailHandler()
                return
            end

            hideAllLoading();
            self.connectedArray:clear()

            if data.data.openServerDate then
                local date = os.date("*t",data.data.openServerDate / 1000)
                -- toastMessageLink(string.format("本次测试服务器将于%d月%d日%d时开放，感谢您的关注！",date.month,date.day,date.hour));
                toastMessageLink(string.format(TextDataMgr:getText(800115),date.month,date.day,date.hour));
                return
            end

            if GameConfig.Debug then
                self:cacheLoginInfo()
            end

            if data.data and data.data.needActivate and data.data.needActivate == "1" then
                self:setVerification(true)
                SaveManager:saveIsActivat(false);
                return
            end

            self:setVerification(true)
            SaveManager:saveIsActivat(true);

            ServerDataMgr:setGameServerList(data.data)
            
            if table.count(data.data) == 1 then
                SaveManager:saveUserInfoDemo(account,password,data.data[1].token,data.data[1].gameServerIp,data.data[1].gameServerPort);
            else
                local selectIdx = ServerDataMgr:getCurrentServerIndex();
                SaveManager:saveUserInfoDemo(account,password,data.data[selectIdx].token,data.data[selectIdx].gameServerIp,data.data[selectIdx].gameServerPort);
            end

            EventMgr:dispatchEvent(EV_LOGIN_UPDATESERVERNAME)
        end  
    end

    local osname = "WINDOWS"
    local token = HeitaoSdk.gettoken();
    dump(token)
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        osname = "IOS"
        --token = TFDeviceInfo:getDeviceToken();
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        osname = "ANDROID"
    end

    local imei = "000000000000000"
    if HeitaoSdk then
        local custom = HeitaoSdk.getcustom()
        if custom ~= "" then
            local jsonData = json.decode(custom)
            if jsonData ~= nil and jsonData.imei ~= nil and jsonData.imei ~= "" then
                imei = jsonData.imei
            end
        end
    end

    local size = CCDirector:sharedDirector():getOpenGLView():getFrameSize();

    local path = ""
    path = path.."?token="..string.url_encode(token);
    path = path.."&accountId="..string.url_encode(HeitaoSdk.getuserid());
    path = path.."&deviceid="..string.url_encode(((TFDeviceInfo:getMachineOnlyID()) or 1));
    path = path.."&osVersion="..string.url_encode(((TFDeviceInfo:getSystemVersion()) or 1));
    path = path.."&osName="..string.url_encode(osname);
    path = path.."&networkType="..string.url_encode((TFDeviceInfo:getNetWorkType()));
    path = path.."&networkCarrier="..string.url_encode((TFDeviceInfo:getCarrierOperator()));
    path = path.."&screenWidth="..string.url_encode((size.width));
    path = path.."&screenHeight="..string.url_encode((size.height));
    path = path.."&appVersion="..string.url_encode((TFDeviceInfo:getCurAppVersion()));
    path = path.."&version="..string.url_encode(TFClientUpdate:getCurVersion());
    path = path.."&sdkVersion=".."";
    path = path.."&sdk=".."";
    path = path.."&channelAppId="..string.url_encode(HeitaoSdk.getplatformId() % 10000);
    local myVersion = md5.sumhexa("@#156qazxswedc7*$%#@!*&2dduebvgrelas"..token..TFDeviceInfo:getMachineOnlyID()..TFClientUpdate:GetUpdateDefaultVersion())
    path = path.."&myVersion="..string.url_encode(myVersion);

    if FileCheckMgr then
        path = path.."&mimi="..FileCheckMgr:getIsSuccess();
    end    
    
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        path = path.."&deviceName="..string.url_encode(((TFDeviceInfo:getDeviceModel()) or 1));
        path = path.."&devicebrand="..string.url_encode("Apple");
        path = path.."&idfa="..string.url_encode(((TFDeviceInfo:getMachineOnlyID()) or 1));
        path = path.."&idfv="..string.url_encode(((TFDeviceInfo:getIDFV()) or 1));
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        path = path.."&deviceName="..string.url_encode(((TFDeviceInfo:getSystemName()) or 1));
        path = path.."&devicebrand="..string.url_encode(TFDeviceInfo:getMachineName());
        path = path.."&imei="..string.url_encode(imei);
        path = path.."&androidid="..string.url_encode(((TFDeviceInfo:getAndroidId()) or 1));
    end
    if RELEASE_TEST then
        path = path.."&serverGroup=".."cehua";
        path = path.."&channelId=".."HEI_TAO";
    else
        path = path.."&serverGroup=".."ios_check";
        path = path.."&channelId=".."HEI_TAO";
    end
    
    if code and code ~= "" then
        path = path.."&activateKey="..code;
    end

    path = string.gsub(path," ","");
    --print(path);
    self.path = path
    self:tryLoginUcCenter()
end

function LogonHelper:activat(code)
    showLongLoading()
    local function activateCallback(type,ret,data)
        hideAllLoading();
        data = json.decode(data);
        if not data then
            -- toastMessageLink("验证失败")
            toastMessageLink(TextDataMgr:getText(800116))
            return
        end
        dump(data)
        if data.status ~= 0 then
            SaveManager:saveIsActivat(false);
            Utils:showTips(data.status)
        else
            if not data.data then
                return
            end
            SaveManager:saveIsActivat(true);
            AlertManager:close();
            SaveManager:saveUserInfoDemo(account,password,data.data.token,data.data.gameServerIp,data.data.gameServerPort);
            TFDirector:dispatchGlobalEventWith("LoginLayer.LoginSuccess", {})
        end
    end
    local url = ACTIVATE_URL
    url = url.."?accountId="..HeitaoSdk.getuserid();
    url = url.."&channelAppId="..1;
    url = url.."&channelId=".."HEI_TAO";
    url = url.."&activateKey="..code;

    url = string.gsub(url," ","");
    --print(url);
    UserCenterHttpClient:addMERecvListener(activateCallback)
    UserCenterHttpClient:httpRequest(TFHTTP_TYPE_GET,url)
end

function LogonHelper:getIsLogin()
    return self.isLogined;
end

function LogonHelper:setIsLogin(islogin)
    self.isLogined = islogin;
    if not islogin then
        self._isVerification = false;
    end
end

function LogonHelper:isVerification()
    return self._isVerification;
end

function LogonHelper:setVerification(Verification)
    self._isVerification = Verification;
end


function LogonHelper:switchLogin(group_id, serverId, id)
    self.groupCfgId = id
    self.group_id = group_id
    self.serverId_ = serverId
    self:setIsLogin(false);
    -- if self.account_ and self.password_ then
    --     self:loginTest(self.account_, self.password_, self.code_, self.isAuto_)
    -- end
end

local KEY_CACHE_GROUPCFG_ID = "key_cache_groupCfg_id"
local KEY_CACHE_GROUP_ID = "key_cache_group_id"
local KEY_CACHE_SERVER_ID = "key_cache_server_id"

function LogonHelper:getCacheGroupCfgId()
    local groupCfgId = CCUserDefault:sharedUserDefault():getIntegerForKey(KEY_CACHE_GROUPCFG_ID, ServerDataMgr:getDefaultServerGroupCfgId(TFGlobalUtils:getPlayerServerIdx()))
    return groupCfgId
end

function LogonHelper:getCacheServerId()
    return CCUserDefault:sharedUserDefault():getIntegerForKey(KEY_CACHE_SERVER_ID)
end

function LogonHelper:getCacheGroupId()
    local groupId = CCUserDefault:sharedUserDefault():getIntegerForKey(KEY_CACHE_GROUP_ID, ServerDataMgr:getDefaultServerGroupId(TFGlobalUtils:getPlayerServerIdx()))
    return groupId
end

function LogonHelper:setCacheGroupCfgId( groupCfgId )
    groupCfgId = groupCfgId or self.groupCfgId
    if groupCfgId then
        CCUserDefault:sharedUserDefault():setIntegerForKey(KEY_CACHE_GROUPCFG_ID, groupCfgId)
    end
end

function LogonHelper:setCacheServerId( serverId )
    serverId = serverId or self.serverId_
    if serverId then
        CCUserDefault:sharedUserDefault():setIntegerForKey(KEY_CACHE_SERVER_ID, serverId)
    end
end

function LogonHelper:setCacheGroupId( group_id )
    group_id = group_id or self.group_id
    if group_id then
        CCUserDefault:sharedUserDefault():setIntegerForKey(KEY_CACHE_GROUP_ID, group_id)
    end
end

function LogonHelper:cacheLoginInfo()
    self:setCacheGroupCfgId()
    self:setCacheServerId()
    self:setCacheGroupId()
end

function LogonHelper:getGroupCfgId()
    return self.groupCfgId
end

function LogonHelper:getGroupId()
    return self.group_id
end

function LogonHelper:getServerId()
    return self.serverId_
end

function LogonHelper:LoginUcCenterFailHandler( localUrl )
    local urlList = self:getServerUrlList()
    if localUrl then
        urlList = localUrl
    end

    if self.connectedArray:length() >= 2*#urlList then
        hideAllLoading()
        toastMessageLink(TextDataMgr:getText(800114))
        return
    end
    TimeOut(function()
        self:tryLoginUcCenter()
    end, 2)
end

function LogonHelper:tryLoginUcCenter( localUrl )
    local urlList = self:getServerUrlList()
    if localUrl then
        urlList = localUrl
    end

    self.urlIdx = self.urlIdx + 1
    if self.urlIdx > #urlList then
        self.urlIdx = 1
    end

    self.connectedArray:push(urlList[self.urlIdx])
    UserCenterHttpClient:addMERecvListener(self.loginCallback)
    UserCenterHttpClient:httpRequest(TFHTTP_TYPE_GET, urlList[self.urlIdx] ..self.path)
    print(urlList[self.urlIdx] ..self.path)

    -- local time = 0
    -- for url in self.connectedArray:iterator() do
    --     if url == urlList[self.urlIdx] then
    --         time = time + 1
    --     end
    -- end

    -- if HeitaoSdk and time <= 1 then
    --     local url = require("TFFramework.net.TFUrl")
    --     if url then
    --         local parsed_url = url.parse(urlList[self.urlIdx])
    --         HeitaoSdk.reportNetworkData(parsed_url.host)
    --     end
    -- end
end

function LogonHelper:getServerUrlList( )
    return TFGlobalUtils:getServerUrlList()
end

return LogonHelper:new()
--[[强制更新66234]]