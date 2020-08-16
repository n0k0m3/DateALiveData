--黑桃
local strCfg = require("lua.table.String" ..GAME_LANGUAGE_VAR)

function sdkCallback(result, msg)
    -- if result == 100 then
    --     CCDirector:sharedDirector():end()
    --     return
    -- end

    if not HeitaoSdk then 
        return
    end
    
    dump({result, msg})
    -- 登陆
    if result == HeitaoSdk.LOGIN_IN_SUC or result == HeitaoSdk.LOGIN_IN_FAIL then
        -- local msg = "登录失败"
        local msg = strCfg[800107].text
        if result == HeitaoSdk.LOGIN_IN_SUC then


            if not  TFPlugins.nTimerHeiTaoInit then
                local function initdata()

                    TFDirector:removeTimer(TFPlugins.nTimerHeiTaoInit)
                    TFPlugins.nTimerHeiTaoInit = nil

                    local userId            = HeitaoSdk.getuserid()
                    local platformUserId    = HeitaoSdk.getplatformUserId()
                    local platformid        = HeitaoSdk.getplatformId()
                    local token             = HeitaoSdk.gettoken()    
                    local sdkVersion        = HeitaoSdk.getSDKVersion()

                    print("______________ long in success ___________________")
                    print("userId           = ", userId)
                    print("platformUserId   = ", platformUserId)
                    print("platformid       = ", platformid)
                    print("token            = ", token)                
                    print("sdkVersion       = ", sdkVersion)
                    print("______________ long in end ___________________")

                    TFPlugins.setSdkVersion(sdkVersion)
                    TFPlugins.setSdkName(platformid)
                    TFPlugins.setUserID(userId)
                    TFPlugins.setToken(token)

                end

                TFPlugins.nTimerHeiTaoInit = TFDirector:addTimer(500, -1, nil, initdata)
            end



            -- msg = "登录成功"
            msg = strCfg[800108].text
        end

        if HeitaoSdk.logincallback then
            HeitaoSdk.logincallback(result, msg)
        end
        
    elseif result == HeitaoSdk.LOGIN_OUT_SUC or result == HeitaoSdk.LOGIN_OUT_FAIL then
        if HeitaoSdk.loginoutcallback then
            HeitaoSdk.loginoutcallback()
        end

    elseif result == HeitaoSdk.LOGIN_PAY_SUC or result == HeitaoSdk.LOGIN_PAY_FAIL then
        if HeitaoSdk.paycallback then
            HeitaoSdk.paycallback(result)
        end
        
    elseif result == HeitaoSdk.LOGIN_SHARE_SUCESS or result == HeitaoSdk.LOGIN_SHARE_FAIL then
        if HeitaoSdk.sharecallback then
            HeitaoSdk.sharecallback(result)
        end
    elseif result == HeitaoSdk.ANTI_ADDICATION or result == HeitaoSdk.ANTI_ADDICATION_FAIL then
        dump(msg)
        if HeitaoSdk.doAntiAddicationQueryCallback then
            HeitaoSdk.doAntiAddicationQueryCallback(msg)
        end
    elseif result >= HeitaoSdk.ACCELEROMETER_BEGIN and result <= HeitaoSdk.ACCELEROMETER_END then
        local temp = result - 200
        local high = math.floor(temp/100) - 10
        local width = temp%100 - 10
        local timer = TFDirector:addTimer(1,1,nil,function ()
            TFDirector:dispatchGlobalEventWith("HeitaoSdk.ACCELEROMETER_UPDATE",{x = width ,y = high})      
        end)

    elseif result == HeitaoSdk.GET_PHONENUM_SUCCESS then
        MainPlayer:setPhoneNum(msg);
    elseif result == HeitaoSdk.USER_DID_TAKE_SCREENSHOT then
        if HeitaoSdk then
            HeitaoSdk.takeScreenshot();
        end
    elseif result == HeitaoSdk.ON_WEBVIEW_OPEN then
        dump("result = HeitaoSdk.ON_WEBVIEW_OPEN")
        SettingDataMgr:setSoundMain(1)
    elseif result == HeitaoSdk.ON_WEBVIEW_CLOSE then
        dump("result = HeitaoSdk.ON_WEBVIEW_CLOSE")
        SettingDataMgr:setSoundMain(4)
        EventMgr:dispatchEvent(EV_WEBVIEW_CLOSE);
    elseif result == HeitaoSdk.CLIENT_TO_LUA then
        dump(msg);
        local ret = json.decode(msg);
        if ret.action == "TMGSpeechToTextSuccess" then
            EventMgr:dispatchEvent(EV_VOICE_SDK_BACK,ret.params.text);
        end
    elseif result == HeitaoSdk.KEYBOARD_UP then
        dump(msg)
        dump(GameConfig.WS);
        local height = tonumber(msg);
        local pDirector = CCDirector:sharedDirector();
        local designSize = pDirector:getOpenGLView():getDesignResolutionSize()
        local frameSize = pDirector:getOpenGLView():getFrameSize();
        height = designSize.height * height / frameSize.height;
        EventMgr:dispatchEvent(EV_KEYBOARD_UP,height);
        -- if height == 0 and imageView then
        --     imageView:runAction(CCMoveBy:create(0.2,ccp(0,-693)))
        --     TimeOut(function()
        --             imageView:removeFromParent();
        --             imageView=nil
        --         end,0.25)
        -- elseif height > 0 then
        --     imageView = TFImage:create()
        --     imageView:setTexture("ui/activity/assist/019.png")
        --     imageView:setAnchorPoint(me.p(0,0))
        --     dump(height,"height")
        --     local pDirector = CCDirector:sharedDirector();
        --     local designSize = pDirector:getOpenGLView():getDesignResolutionSize()
        --     local frameSize = pDirector:getOpenGLView():getFrameSize();
        --     height = designSize.height * height / frameSize.height;
        --     dump(height,"height")
        --     imageView:setPosition(ccp(0, 0))
        --     Public:currentScene():addChild(imageView,999)
        --     imageView:runAction(CCMoveBy:create(0.2,ccp(0,height)));
        -- end
    elseif result == HeitaoSdk.KEY_BACK then
        Utils:onKeyBack()
    elseif result == HeitaoSdk.QUERY_USER_DESTROY_STATE then        
        dump(msg); --屏蔽查看账户信息
        -- local ret = json.decode(msg);
        -- MainPlayer:setSdkAccountStatus(ret.sdkAccountStatus)
        -- MainPlayer:setSdkAccountTime(ret.sdkAccountTime)

        -- if ret.sdkAccountStatus == "1" then           
        --     MainPlayer:startCheckSdkAccountStatus()
        -- end       
    elseif result == HeitaoSdk.TRAIT_COLLECTIONDID_CHANGE then
        Utils:onTraitCollectionDidChange()
        EventMgr:dispatchEvent(EV_TRAIT_COLLECTIONDID_CHANGE)
    end
end




function isLogined()
    local ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "isLogined", nil, "()Z")
    
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        if ok and ret == 1 then
            return true;
        else
            return false;
        end
    end

    return HeitaoSdk.checkResult(ok,ret)
end

function enterGame()
    -- local args = {HeitaoSdk.servername, HeitaoSdk.serverid, roleid, rolename, level, isNewRole}

    local args = nil
    local ok  = false
    local ret = nil

    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        args = {
            roleId          = tostring(MainPlayer:getPlayerId()),
            roleName        = MainPlayer:getPlayerName(), 
            zoneId          = tostring(ServerDataMgr:getServerGroupID()),
            zoneName        = "1", 
            partyName       = strCfg[100000083].text,
            roleLevel       = tostring(MainPlayer:getPlayerLv()),
            roleVipLevel    = tostring(1),
            balance         = tostring(GoodsDataMgr:getDiamond()),
            isNewRole       = tostring(MainPlayer:getIsNewRoleFlag())
         }

        -- print("----HeitaoSdk.enterGame = ", args)
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "enterGame", args)

    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        args = {
            tostring(ServerDataMgr:getServerGroupID()),--serverid
            tostring(1),                                --servername
            tostring(MainPlayer:getPlayerId()),                                --roleid
            MainPlayer:getPlayerName(),                 --rolename
            tostring(MainPlayer:getPlayerLv()),         --rolelevel
            tostring(MainPlayer:getIsNewRoleFlag()),    --isNewRole
            tostring(strCfg[100000083].text),                             --partyName
            tostring(1),                                --vipLevel
            tostring(GoodsDataMgr:getDiamond()),        --balance
            }

        print("----HeitaoSdk.enterGame = ", args)
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "enterGame", args)
    end


    return HeitaoSdk.checkResult(ok,ret)
end

function roleNameChanged(newName)
    local ok,ret;
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "roleNameChanged", {roleName = newName});
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "roleNameChanged", {newName}, "(Ljava/lang/String;)V");
    end
    return HeitaoSdk.checkResult(ok,ret)
end

function login()
    local language = ""
    if GAME_LANGUAGE_VAR == "" then
        language = "CN"
    else
        language = "EN"
    end
    local ok,ret
     if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "login", {language = language});
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "login", {language}, "(Ljava/lang/String;)V")
    end
    

    return HeitaoSdk.checkResult(ok,ret)
end

-- 0:没有认证
-- 1：未成年
-- 2：已成年
local doAntiAddicationQueryCallback = nil;
function doAntiAddicationQuery()

    if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then

        if doAntiAddicationQueryCallback then
            doAntiAddicationQueryCallback(0)
        end

        return 
    end

    local ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "doAntiAddicationQuery", nil, "()V")

    return HeitaoSdk.checkResult(ok,ret)
end

function setAntiAddicationQueryCallback(callback)
    if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
        doAntiAddicationQueryCallback = callback;
        return;
    end
    if HeitaoSdk then
        HeitaoSdk.doAntiAddicationQueryCallback = callback;
    end
end

local __shareCallback = nil;
function setShareCallback(callback)
    if CC_PLATFORM_WIN32 == CC_TARGET_PLATFORM then
        __shareCallback = callback;
        return
    end

    if HeitaoSdk then
        HeitaoSdk.sharecallback = callback;
    end
end


function isFunctionSupported(funcName)
    local ok,ret;
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "isFunctionSupported", {funcName = funcName});
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "isFunctionSupported", {funcName}, "(Ljava/lang/String;)V");
    end

    return HeitaoSdk.checkResult(ok,ret)
end

function luaToClient(action,jsonStr)
    local ok,ret;
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "luaToClient", {action = action,jsonStr = jsonStr});
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "luaToClient", {action,jsonStr}, "(Ljava/lang/String;Ljava/lang/String;)V");
    end
    return HeitaoSdk.checkResult(ok,ret)
end

function checkResult(ok,ret)
    -- body
    if ok then return true end
    print("lua to java fail")
    return nil
end

function getAndroidVersion()
    local ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "getAndroidVersion", nil, "()I")
    
    return HeitaoSdk.checkResult(ok,ret)
end

function takeScreenshot()
    if true then
        Utils:showTips(221010)
        return
    end
    -- local filePath = me.FileUtils:getWritablePath() .. "screenshot.png"
    -- local _isSuccess
    -- CUtils.onCaptureScreen(function(isSuccess,fileName)
    --         _isSuccess = isSuccess;
    --     end,filePath,false)

    if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
        Box("分享成功")
        __shareCallback();
        return;
    end

    -- if TFDeviceInfo:getCurAppVersion() == "2.80" then
    --     return;
    -- end

    local ok,ret;
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        local args = {
            imagePath = filePath,
            title = "",
            desc = "",
            extend = "",
            to = 1
        }
        
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "screenshot");
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then

        local androidVer = HeitaoSdk.getAndroidVersion();
        local appverison = TFDeviceInfo:getCurAppVersion();
        if --[[tonumber(appverison) <= 3.43 or]] (androidVer and androidVer < 21) then
            local filePath = CCFileUtils:sharedFileUtils():getWritablePath().."shareTex.jpg"
            local _isSuccess
            CUtils.captureScreen(function(isSuccess,fileName)
                    _isSuccess = isSuccess;
                end,filePath,false)

            local args = {
                filePath,
                "",
                "",
                "",
                1
            }
            ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "share", args,"(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V");
        else
            local filePath = CCFileUtils:sharedFileUtils():getWritablePath()
            local args = {
                filePath,
            }
            ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "shootShare", args,"(Ljava/lang/String;)V");
        end
    end
    return checkResult(ok,ret)
end


if HeitaoSdk then
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        HeitaoSdk.classname         = "sdkManager"
    end

    HeitaoSdk.ANTI_ADDICATION = 9; --防沉迷查询成功
    HeitaoSdk.ANTI_ADDICATION_FAIL = 10;--防沉迷查询失败
    HeitaoSdk.GET_PHONENUM_SUCCESS = 13;--手机号
    HeitaoSdk.USER_DID_TAKE_SCREENSHOT = 14;--玩家截屏
    HeitaoSdk.ON_WEBVIEW_OPEN = 15;--webview打开
    HeitaoSdk.ON_WEBVIEW_CLOSE = 16;--webview关闭
    HeitaoSdk.CLIENT_TO_LUA = 22;
    HeitaoSdk.KEYBOARD_UP = 57;

    HeitaoSdk.callback = sdkCallback;
    HeitaoSdk.isLogined = isLogined;
    HeitaoSdk.enterGame = enterGame;
    HeitaoSdk.roleNameChanged = roleNameChanged;
    HeitaoSdk.login = login;
    HeitaoSdk.doAntiAddicationQuery = doAntiAddicationQuery;
    HeitaoSdk.setAntiAddicationQueryCallback = setAntiAddicationQueryCallback;
    HeitaoSdk.isFunctionSupported = isFunctionSupported;
    HeitaoSdk.takeScreenshot = takeScreenshot;
    HeitaoSdk.setShareCallback = setShareCallback;
    HeitaoSdk.luaToClient = luaToClient;
    HeitaoSdk.getAndroidVersion = getAndroidVersion;
end

if TFDeviceInfo then
    function TFDeviceInfo:getCurAppVersion()

        if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then 
            return "1.0.0"
        end

        if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
            local ok,ret = TFLuaOcJava.callStaticMethod("sdkManager", "getAppVersion",nil,"()Ljava/lang/String;")
            return TFDeviceInfo.checkResult(ok,ret)
        else
            local ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "getCurAppVersion",nil,"()Ljava/lang/String;")
            return TFDeviceInfo.checkResult(ok,ret)
        end
    end

    function TFDeviceInfo:getMachineOnlyID()
        local ok = nil
        local ret = nil
        if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
            ok,ret = TFLuaOcJava.callStaticMethod("sdkManager","getIDFA")
        else
            --不保证不变动
        ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME,"getMachineOnlyID",nil,"()Ljava/lang/String;")
        end
        return TFDeviceInfo.checkResult(ok,ret)
    end

    function TFDeviceInfo:getIDFV()
        local ok = nil
        local ret = nil
        if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
            ok,ret = TFLuaOcJava.callStaticMethod("sdkManager","getIDFV")
        end

        return TFDeviceInfo.checkResult(ok,ret)
    end

    function TFDeviceInfo:getIMEI()
        local ok = nil
        local ret = nil
        if CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
            --不保证不变动
            ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME,"getIMEI",nil,"()Ljava/lang/String;")
        end
        return TFDeviceInfo.checkResult(ok,ret)
    end

    function TFDeviceInfo:getDeviceModel()
        local ok = nil
        local ret = nil
        if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
            --不保证不变动
            ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME,"getCurrentDeviceModel")
        end
        return TFDeviceInfo.checkResult(ok,ret)
    end

    function TFDeviceInfo:getAndroidId()
        local ok = nil
        local ret = nil
        if CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
            --不保证不变动
            ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME,"getAndroidId",nil,"()Ljava/lang/String;")
        end
        return TFDeviceInfo.checkResult(ok,ret)
    end
end