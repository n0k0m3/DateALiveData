local LogonHelper = class("LogonHelper")


local UserCenterHttpClient = TFClientNetHttp:GetInstance()

LOGIN_URL = {}
if  CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 or VERSION_DEBUG == true then
    LOGIN_URL[1] = "http://192.168.20.27:8980/account/login"
    GM_URL    = "http://192.168.20.181:8080/login/account/adminLogin"
else
    -- if RELEASE_TEST then
    --     LOGIN_URL = "http://49.233.184.62:8081/account/login"
    --     GM_URL    = "http://49.233.184.62:8081/account/login"
    -- elseif EXPERIENCE then
    --     LOGIN_URL = "http://uce.datealive.com:8081/account/login"
    --     GM_URL    = "http://uce.datealive.com:8081/account/login"
    -- elseif HeitaoSdk and math.floor(HeitaoSdk.getplatformId() / 10000) == 3 then
    --     LOGIN_URL = "http://uch.datealive.com:8081/account/login"
    --     GM_URL    = "http://uch.datealive.com:8081/account/adminLogin"
    -- else
    --     LOGIN_URL = "https://uc.datealive.com:8082/account/login"
    --     GM_URL    = "https://uc.datealive.com:8082/account/adminLogin"
    -- end

    if HeitaoSdk then
        if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
            LOGIN_URL[1] = "https://uc-en.datealive.com:8082/account/login"
            LOGIN_URL[2] = "https://uc-en2.datealive.com:8082/account/login"
            GM_URL    = "http://uch.datealive.com:8081/account/adminLogin"
        else
            LOGIN_URL[1] = "http://uc-en.datealive.com:8081/account/login"
            LOGIN_URL[2] = "http://uc-en2.datealive.com:8081/account/login"
            GM_URL    = "http://uch.datealive.com:8081/account/adminLogin"
        end
    else
        LOGIN_URL[1] = "http://uc-en.datealive.com:8081/account/login"
        LOGIN_URL[2] = "http://uc-en2.datealive.com:8081/account/login"
        GM_URL    = "https://uc.datealive.com:8082/account/adminLogin"
    end
    --ACTIVATE_URL = "http://120.131.3.158:8081/login/account/checkActivateCode"
end

function LogonHelper:ctor(data)
    self.urlIdx = 0
    self.path = ""
    self.connectedArray = TFArray:new()

    if GM_MODE then
        self.loginUrl_ = GM_URL
    else
        self.loginUrl_ = LOGIN_URL[1]
    end
    self.account_ = nil
    self.password_ = nil
    self.code_ = nil
    self.isAuto_ = false
    self.isLogined = false;

    self.serverName_ = self:getCacheServerName()
    self.serverGroup_ = self:getCacheGroupName()

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
    if not self.serverGroup_ then
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
        data = json.decode(data);
        dump(data);
        if not data then
            self.isLogined = false;
            self:LoginUcCenterFailHandler()
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
                self:LoginUcCenterFailHandler()
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

    local serverGroupConfig = ServerDataMgr:getServerList(self.serverGroup_)
    --local url = self.loginUrl_[1]
    if serverGroupConfig and serverGroupConfig.url then
        LOGIN_URL = serverGroupConfig.url
        dump(LOGIN_URL)
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

    if self.serverName_ then
        path = path.."&serverName="..self.serverName_;
    end
    if self.serverGroup_ then
        path = path.."&serverGroup=" .. self.serverGroup_;
    end
    path = path.."&channelAppId="..1;
    path = path.."&channelId=".."LOCAL_TEST";
    if code and code ~= "" then
        path = path.."&activateKey="..code;
    end

    self.path = string.gsub(path," ","");
    --print(path);
    self.path = path

    self:tryLoginUcCenter()

    --UserCenterHttpClient:addMERecvListener(self.loginCallback)
    --UserCenterHttpClient:httpRequest(TFHTTP_TYPE_GET,url)
end


function LogonHelper:GMLogin(pid)
    showLongLoading()

    self.account_ = account
    self.password_ = password
    self.code_ = code
    self.isAuto_ = isAuto

    self.loginCallback = function (type,ret,data)
        hideAllLoading();
        data = json.decode(data);
        dump(data);
        if not data then
            self.isLogined = false;
            -- toastMessageLink("连接登录服务器失败")
            toastMessageLink(TextDataMgr:getText(800114))
            return
        end
        if data.status ~= 0 then
            self.isLogined = false;
            Utils:showTips(data.status)
            SaveManager:saveIsActivat(false);
        else
            if not data.data then
                return
            end

            if data.data.openServerDate then
                local date = os.date("*t",data.data.openServerDate / 1000)
                -- toastMessageLink(string.format("本次测试服务器将于%d月%d日%d时开放，感谢您的关注！",date.month,date.day,date.hour));
                toastMessageLink(string.format(TextDataMgr:getText(800115),date.month,date.day,date.hour));
                return
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

    local url = self.loginUrl_
    url = url.."?pid="..pid;

    if FileCheckMgr then
        url = url.."&mimi="..FileCheckMgr:getIsSuccess();
    end
        
    url = string.gsub(url," ","");
    print(url);
    UserCenterHttpClient:addMERecvListener(self.loginCallback)
    UserCenterHttpClient:httpRequest(TFHTTP_TYPE_GET,url)
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
    --local url = self.loginUrl_
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
        path = path.."&serverGroup=".."cehua_ext";
        path = path.."&channelId=".."LOCAL_TEST";
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


function LogonHelper:switchLogin(groupName, serverName)
    self.serverGroup_ = groupName
    self.serverName_ = serverName
    self:setIsLogin(false);
    -- if self.account_ and self.password_ then
    --     self:loginTest(self.account_, self.password_, self.code_, self.isAuto_)
    -- end
end

local KEY_CACHE_GROUP_NAME = "key_cache_group_name"
local KEY_CACHE_SERVER_NAME = "key_cache_server_name"

function LogonHelper:getCacheServerName()
    local serverName = CCUserDefault:sharedUserDefault():getStringForKey(KEY_CACHE_SERVER_NAME)
    if #serverName > 0 then
        return serverName
    end
end

function LogonHelper:getCacheGroupName()
    local groupName = CCUserDefault:sharedUserDefault():getStringForKey(KEY_CACHE_GROUP_NAME)
    if #groupName > 0 then
        return groupName
    end
end

function LogonHelper:cacheLoginInfo()
    if self.serverGroup_ then
        CCUserDefault:sharedUserDefault():setStringForKey(KEY_CACHE_GROUP_NAME, self.serverGroup_)
    end
    if self.serverName_ then
        CCUserDefault:sharedUserDefault():setStringForKey(KEY_CACHE_SERVER_NAME, self.serverName_)
    else
        CCUserDefault:sharedUserDefault():setStringForKey(KEY_CACHE_SERVER_NAME, "")
    end
end

function LogonHelper:getServerName()
    return self.serverName_
end

function LogonHelper:getGroupName()
    return self.serverGroup_
end

function LogonHelper:LoginUcCenterFailHandler( )
    if self.connectedArray:length() >= 2*#LOGIN_URL then
        hideAllLoading()
        toastMessageLink(TextDataMgr:getText(800114))
        return
    end
    TimeOut(function()
        self:tryLoginUcCenter()
    end, 2)
end

function LogonHelper:tryLoginUcCenter( )
    self.urlIdx = self.urlIdx + 1
    if self.urlIdx > #LOGIN_URL then
        self.urlIdx = 1
    end

    self.connectedArray:push(LOGIN_URL[self.urlIdx])
    UserCenterHttpClient:addMERecvListener(self.loginCallback)
    UserCenterHttpClient:httpRequest(TFHTTP_TYPE_GET, LOGIN_URL[self.urlIdx] ..self.path)
    print(LOGIN_URL[self.urlIdx] ..self.path)

    local time = 0
    for url in self.connectedArray:iterator() do
        if url == LOGIN_URL[self.urlIdx] then
            time = time + 1
        end
    end

    if HeitaoSdk and time <= 1 then
        local url = require("TFFramework.net.TFUrl")
        local parsed_url = url.parse(LOGIN_URL[self.urlIdx])
        HeitaoSdk.reportNetworkData(parsed_url.host)
    end
end

return LogonHelper:new()
--[[强制更新66234]]