local HeitaoSdk = {}

if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
HeitaoSdk.classname         = "HeitaoManager"
elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
HeitaoSdk.classname         = "org/cocos2dx/TerransForce/HeitaoSdkManager"
end



HeitaoSdk.initcallback 		= nil
HeitaoSdk.logincallback 	= nil
HeitaoSdk.loginoutcallback 	= nil
HeitaoSdk.leavecallback 	= nil
HeitaoSdk.paycallback       = nil
HeitaoSdk.sharecallback 	= nil

HeitaoSdk.LOGIN_IN_SUC      = 1
HeitaoSdk.LOGIN_IN_FAIL     = 2
HeitaoSdk.LOGIN_OUT_SUC     = 3
HeitaoSdk.LOGIN_OUT_FAIL    = 4
HeitaoSdk.LOGIN_PAY_SUC     = 5
HeitaoSdk.LOGIN_PAY_FAIL    = 6
HeitaoSdk.LOGIN_SHARE_SUCESS= 7
HeitaoSdk.LOGIN_SHARE_FAIL  = 8
HeitaoSdk.KEY_BACK          = 99
HeitaoSdk.QUERY_USER_DESTROY_STATE = 101
HeitaoSdk.TRAIT_COLLECTIONDID_CHANGE = 102
HeitaoSdk.ACCELEROMETER_BEGIN  = 200
HeitaoSdk.ACCELEROMETER_END  = 2220

HeitaoSdk.bInit             = false
HeitaoSdk.bFirstLogin       = false

HeitaoSdk.servername        = nil
HeitaoSdk.serverid          = nil


HeitaoSdk.Share_WeiXinGroup = 1     --朋友圈
HeitaoSdk.Share_QQGroup     = 2     --QQ空间
HeitaoSdk.Share_WeiBo       = 3     --新浪微博
HeitaoSdk.Share_WeiXin      = 4     --微信朋友
HeitaoSdk.Share_QQ          = 5     --qq好友
-- 母包的channelid = 999999

function HeitaoSDKCallBack(result, msg)
    -- print("HeitaoSDKCallBack result = ", result)
    -- print("msg    = ", msg)
    if HeitaoSdk then
        HeitaoSdk.callback(tonumber(result), msg)
    end

    -- print("HeitaoSDKCallBack end")
end

function HeitaoSdk.init()

end

function HeitaoSdk.callback(result, msg)
    -- if result == 100 then
    --     CCDirector:sharedDirector():end()
    --     return
    -- end


    -- 登陆
    if result == HeitaoSdk.LOGIN_IN_SUC or result == HeitaoSdk.LOGIN_IN_FAIL then
        local msg = TextDataMgr:getText(800107)
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



            msg = "登录成功"
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
    elseif result >= HeitaoSdk.ACCELEROMETER_BEGIN and result <= HeitaoSdk.ACCELEROMETER_END then
        local temp = result - 200
        local high = math.floor(temp/100) - 10
        local width = temp%100 - 10
        local timer = TFDirector:addTimer(1,1,nil,function ()
            TFDirector:dispatchGlobalEventWith("HeitaoSdk.ACCELEROMETER_UPDATE",{x = width ,y = high})      
        end)
     end
end

function HeitaoSdk.isLogined(doLoginWhenNotLogin)
    local ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "isLogined", doLoginWhenNotLogin, "(Z)Z")
    return HeitaoSdk.checkResult(ok,ret)
end

function HeitaoSdk.login()

    if HeitaoSdk.bFirstLogin == true then
        return
    end

    HeitaoSdk.bFirstLogin = true
    local ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "login", nil, "()V")
    
    return HeitaoSdk.checkResult(ok,ret)
end

function HeitaoSdk.loginOut()

    local ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "loginOut", nil, "()V")
    
    return HeitaoSdk.checkResult(ok,ret)
end

function HeitaoSdk.loginExit()

    local ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "loginExit", nil, "()V")
    
    return HeitaoSdk.checkResult(ok,ret)
end

function HeitaoSdk.roleNameChanged(roleName)

    local ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "roleNameChanged", {roleName = roleName}, "(Ljava/lang/String;)V")
    
    return HeitaoSdk.checkResult(ok,ret)
end

function HeitaoSdk.getuserid()

    local ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "getuserid", nil, "()Ljava/lang/String;")
    
    return HeitaoSdk.checkResult(ok,ret)
end

function HeitaoSdk.getplatformUserId()

    local ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "getplatformUserId", nil, "()Ljava/lang/String;")
    
    return HeitaoSdk.checkResult(ok,ret)
end

function HeitaoSdk.getplatformId()

    local ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "getplatformId", nil, "()Ljava/lang/String;")
    
    return HeitaoSdk.checkResult(ok,ret)
end

function HeitaoSdk.gettoken()

    local ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "gettoken", nil, "()Ljava/lang/String;")
    
    return HeitaoSdk.checkResult(ok,ret)
end

function HeitaoSdk.getcustom()

    local ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "getcustom", nil, "()Ljava/lang/String;")
    
    return HeitaoSdk.checkResult(ok,ret)
end

function HeitaoSdk.setIsOldPlayer()
    local ok  = false
    local ret = nil
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "setIsOldPlayer")
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
    end
    
    return HeitaoSdk.checkResult(ok,ret)
end

function HeitaoSdk.checkResult(ok,ret)
    -- body
    if ok then return ret end
    print("lua to java fail")
    return nil
end

-- int price; //单价(元)
-- int rate; //兑换比例
-- int count; //个数
-- int fixedMoney; //是否定额
-- String unitName; //货币单位
-- String productId; //产品 ID
-- String serverId; //服务器 ID（传 null）
-- String name; //商品名称
-- String callbackUrl; //回调地址（传 null）
-- String description; //商品描述
-- String cpExtendInfo; //CP 扩展信息
-- String custom; //自定义信息
function HeitaoSdk.pay(price, rate, count, fixedMoney, unitName, productId, serverId, name, callbackUrl, description, cpExtendInfo, sycee, level, viplevel, month, party)

    local args = nil
    local ok  = false
    local ret = nil

    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then

--     float price         = [[param objectForKey:@"price"] floatValue];                       //单价
--     int rate            = [[param objectForKey:@"rate"] intValue];                          //兑换比例
--     int count           = [[param objectForKey:@"count"] intValue];                     //个数
-- //    BOOL fixedMoney = = [[param objectForKey:@"count"] intValue];;                    //是否定额
--     NSString *unitName  = [param objectForKey:@"unitName"];     //货币单位
--     NSString *productId = [param objectForKey:@"productId"];        //产品ID
--     NSString *serverId  = [param objectForKey:@"serverId"];     //服务器ID
--     NSString *name      = [param objectForKey:@"name"];         //商品名称
--     NSString *callbackUrl = [param objectForKey:@"callbackUrl"];        //回调地址
--     NSString *description = [param objectForKey:@"description"];    //商品描述
--     NSString *cpExtendInfo= [param objectForKey:@"cpExtendInfo"];   //商品描述  //CP扩展信息

        args = {
            price       = string.format("%d", price),
            rate        = string.format("%d", rate), 
            count       = string.format("%d", count),
            fixedMoney  = fixedMoney, 
            unitName    = unitName,
            productId   = productId,
            serverId    = string.format("%d", serverId),
            callbackUrl = callbackUrl,
            description = description,
            cpExtendInfo= cpExtendInfo,
            sycee       = sycee,
            level       = level,
            viplevel    = viplevel,
            month       = month,
            party       = party,
            name        = name
            -- sycee, level, viplevel, month, party      = custom
        }

        print("HeitaoSdk.pay" , args)

        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "pay", args)
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then

        local itemName = unitName
        if month == 1 then
            itemName = "月卡"
        elseif month == 5 then
            itemName = "终身卡"
        end
        
        args = {
            price,
            rate, 
            count,
            1, 
            unitName,
            productId,
            string.format("%d", serverId),
            cpExtendInfo,
            string.format("%d", sycee),
            string.format("%d", level),
            string.format("%d", viplevel),
            string.format("%d", month),
            party,
            name,
            name        
        }

        print("HeitaoSdk.pay" , args)
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "pay", args, "(IIIILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V")
        -- ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "pay", {bShow})        
        -- return HeitaoSdk.checkResult(ok,ret)
    end
end

-- 是否显示悬浮菜单按钮
function HeitaoSdk.ShowFunctionMenu(bShow)
    local ok  = false
    local ret = nil
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "ShowFunctionMenu", {enable = bShow})
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "ShowFunctionMenu", {bShow})
        
        return HeitaoSdk.checkResult(ok,ret)
    end
end

-- 开始游戏
function  HeitaoSdk.startGame()
    -- HTGameProxy.onStartGame();
    local ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "startGame", nil, "()Z")
    
    if ok then 
        if ret == 1 then
            return true
        end 
    end

    return HeitaoSdk.checkResult(ok,ret)
end

-- 3.8.进入游戏
-- HTGameProxy.onEnterGame(Map<String, String> customMap);
-- 参数备注：customMap：参数集
-- 返回值：无
-- 调用级别：必选
-- 描述：在正确游戏进入后调用
-- 必须传入以下参数：
-- Map<String, String> parsMap = new HashMap<String, String>();
-- parsMap.put(HTKeys.KEY_CP_SERVER_ID, "服务器 ID"); //必须整形（某些渠道要求）
-- parsMap.put(HTKeys.KEY_CP_SERVER_NAME, "服务器名称");
-- parsMap.put(HTKeys.KEY_ROLE_ID, "玩家角色 ID");
-- parsMap.put(HTKeys.KEY_ROLE_NAME, "玩家角色名");
-- parsMap.put(HTKeys.KEY_ROLE_LEVEL, "玩家角色等级");
-- parsMap.put(HTKeys.KEY_IS_NEW_ROLE, "是否为新角色");//1:新角色 0:旧角色
-- function HeitaoSdk.enterGame(serverid, servername, roleid, rolename, level, isNewRole)
function HeitaoSdk.enterGame(roleid, rolename, level, isNewRole)
    -- local args = {HeitaoSdk.servername, HeitaoSdk.serverid, roleid, rolename, level, isNewRole}

    local args = nil
    local ok  = false
    local ret = nil

    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        args = {
            serverid    = string.format("%d", HeitaoSdk.serverid),
            servername  = HeitaoSdk.servername, 
            roleid      = string.format("%d", roleid),
            rolename    = rolename, 
            level       = string.format("%d", level),
            isNewRole   = string.format("%d", isNewRole)
        }

        print("----HeitaoSdk.enterGame = ", args)
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "enterGame", args)

    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        args = {
            tostring(HeitaoSdk.serverid),
            tostring(HeitaoSdk.servername), 
            tostring(roleid),
            tostring(rolename), 
            tostring(level),
            tostring(isNewRole)
            }
            
        print("----HeitaoSdk.enterGame = ", args)
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "enterGame", args)
    end


    return HeitaoSdk.checkResult(ok,ret)
end


-- 玩家等级发生变化
function  HeitaoSdk.GameLevelChanged(newLevel)
    local ok  = false
    local ret = nil
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "GameLevelChanged", {level = newLevel})
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "GameLevelChanged", {newLevel}, "(I)V")
        
        return HeitaoSdk.checkResult(ok,ret)
    end
end

-- 设置 APP 更新监听
function  HeitaoSdk.setAppUpdateListener(listener)
    -- HTGameProxy.setAppUpdateListener(listener)调用级别：必选
    -- 描述：发行商服务器端可以配置把更新权给 SDK 或者 CP，如果服务器端把更新权配置给
    -- CP，但是客户端未设置更新监听，该情况会默认走 SDK 的更新。
    -- HTAppUpdateInfo 参数说明：
    -- versionName // 版本名称
    -- versionCode // 版本代码
    -- content // 更新内容
    -- apkURL // APK 下载地址
    -- isForce // 是否强制更新（通常为 TRUE）
end

-- 4.1.获取 SDK 版本号
-- 描述：获取黑桃代理 SDK 版本号
function  HeitaoSdk.getSDKVersion()
    local ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "getSDKVersion", nil)
    
    return HeitaoSdk.checkResult(ok,ret)
end

-- 4.2.获取渠道 SDK 版本号
-- HTGameProxy.getChannelSDKVersion();
-- 描述：获取渠道 SDK 版本号
function  HeitaoSdk.getChannelSDKVersion()
    local ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "getChannelSDKVersion", nil)
    
    return HeitaoSdk.checkResult(ok,ret)
end

-- 4.3.Debug 模式设置
-- HTGameProxy.setDebugEnable(boolean enable);
-- 参数备注：TRUE：开启 FALSE：关闭
-- 描述：设置 Debug 模式，默认关闭。Debug 默认开启时，支付金额会默认为 1 元，关闭则为实际金额。
function  HeitaoSdk.setDebugEnable(enable)

    local ok  = false
    local ret = nil
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "setDebugEnable", {enable = bShow})
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "setDebugEnable", {bShow})
        
        return HeitaoSdk.checkResult(ok,ret)
    end
end

-- 4.4.设置打印日志
-- HTGameProxy.setLogEnable(boolean enable);
function  HeitaoSdk.setLogEnable(enable)

    local ok  = false
    local ret = nil
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "setLogEnable", {enable = bShow})
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "setLogEnable", {bShow})
        
        return HeitaoSdk.checkResult(ok,ret)
    end
end

-- 4.4.打开QQ
function  HeitaoSdk.openQQClient(qqid)
    local ok  = false
    local ret = nil
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "openQQ", {qq = qqid})
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "openQQ", {qqid})
        
        return HeitaoSdk.checkResult(ok,ret)
    end
end

function  HeitaoSdk.onUseGiftCode(giftCode)
    local ok  = false
    local ret = nil
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "onUseGiftCode", {code = giftCode})
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "onUseGiftCode", {giftCode})
        
        return HeitaoSdk.checkResult(ok,ret)
    end
end


function  HeitaoSdk.setLoginOutCallBack(callback)
    if callback then 
        if type(callback) == 'function' then
            HeitaoSdk.loginoutcallback  = callback
        else
            print("=====init===loginoutcallback=error",callback)
            return
        end
    end
end

function  HeitaoSdk.setLogincallback(callback)
    if callback then 
        if type(callback) == 'function' then
            HeitaoSdk.logincallback  = callback
        else
            print("=====init===logincallback=error",callback)
            return
        end
    end
end


function  HeitaoSdk.setPayCallBack(callback)
    if callback then 
        if type(callback) == 'function' then
            HeitaoSdk.paycallback  = callback
        else
            print("=====init===setPayCallBack=error",callback)
            return
        end
    end
end

function  HeitaoSdk.setSharecallback(callback)
    if callback then 
        if type(callback) == 'function' then
            HeitaoSdk.sharecallback  = callback
        else
            print("=====init===setSharecallback=error",callback)
            return
        end
    end
end



function  HeitaoSdk.setServerInfo(serverid, servername)
    HeitaoSdk.servername = servername
    HeitaoSdk.serverid   = serverid
end

function HeitaoSdk.ShareText(HTShareTitle,HTShareText,HTShareDescription,HTShareUrl,HTShareExtend,HTShareImageLocal,platformStr)
        args = {
            HTShareTitle,
            HTShareText, 
            HTShareDescription,
            HTShareUrl,
            HTShareExtend,
            HTShareImageLocal,
            platformStr
        }
    local ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "ShareText", args, "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V")
    return HeitaoSdk.checkResult(ok,ret)
end


function  HeitaoSdk.shareGameInfo(sharetype,text)
    local ok  = false
    local ret = nil
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "shareGameInfo", {type = sharetype,shareText = text})
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        -- ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "openQQ", {qqid})
        -- return HeitaoSdk.checkResult(ok,ret)
    end
    return ok
end

function  HeitaoSdk.disableDeviceSleep(isDisable)
   
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "disableDeviceSleep", {notSleep = isDisable})
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        TFLuaOcJava.callStaticMethod("org/cocos2dx/TerransForce/TerransForce", "disableDeviceSleep", {isDisable})
    end
    return ok
end

function  HeitaoSdk.shareWxText(type_id, strTitle, strDesc, linkURL, imagePath)
   --[[* 注：
     * 1. 微信分享不支持同时分享链接和图片，此处图片和链接同时都传的话，只能分享链接，若要只分享图片，不要传链接。
     * 2. 微信分享图片支持本地路径、Bitmap和图片链接地址三种格式，只需传其中一种即可，图片大小须大于100*100。QQ和微博分享图片只支持本地路径格式。
     * 3. 分享链接的时候缩略图务必要传
     */]]
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        args = {
            type_id = type_id,
            strTitle = strTitle, 
            strDesc = strDesc,
            linkURL = linkURL,
            imagePath = imagePath        
            }
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "shareGameInfo", args)
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        args = {
            tostring(type_id),
            strTitle, 
            strDesc,
            linkURL,
            imagePath        
            }
        TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "pushShare",args)
    end
    return ok
end

function  HeitaoSdk.checkEnableShare()
    local appverison = TFDeviceInfo.getCurAppVersion() or "1.00"
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        if appverison > "2.51" then
            return true
        else
            return false
        end
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        if appverison > "2.25" then
            return true
        else
            return false
        end
    end
end

function  HeitaoSdk.saveImageToGallery(imagePath)
   
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        -- ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "disableDeviceSleep", {notSleep = isDisable})
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "saveImageToGallery",{imagePath})
    end
    return ok
end

function HeitaoSdk.getAccountStatus( )
    local ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "getAccountStatus", nil, "()Ljava/lang/String;") 
    return HeitaoSdk.checkResult(ok,ret)
end

function HeitaoSdk.getAccountTime( )
    local ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "getAccountTime", nil, "()Ljava/lang/String;")
    return HeitaoSdk.checkResult(ok,ret)
end

function  HeitaoSdk.renderAR()
    local ok  = false
    local ret = nil
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "renderCameraView", nil, "()V")
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "renderCameraView",{})
    end
    return ok
end

function  HeitaoSdk.openAR()
    local ok  = false
    local ret = nil
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "openAR", nil, "()V")
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "openAR",{})
    end
    return ok
end

function  HeitaoSdk.closeAR()
    local ok  = false
    local ret = nil
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "closeAR", nil, "()V")
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "closeAR",{})
    end
    return ok
end

function  HeitaoSdk.initializeAR()
    local ok  = false
    local ret = nil
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "initializeAR", nil, "()V")
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "initializeAR",{})
    end
    return ok
end

function  HeitaoSdk.releaseAR()
    local ok  = false
    local ret = nil
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "releaseAR", nil, "()V")
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "releaseAR",{})
    end
    return ok
end

function  HeitaoSdk.changeAR()
    local ok  = false
    local ret = nil
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "changeCamera", nil, "()V")
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "changeCamera",{})
    end
    return ok
end

function HeitaoSdk.getDeviceLanguage()

    local ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "getDeviceLanguage", nil, "()Ljava/lang/String;")
    
    return HeitaoSdk.checkResult(ok,ret)
end

function HeitaoSdk.getUIUserInterfaceStyleDark( )
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        local ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "getUIUserInterfaceStyleDark", nil, "()Ljava/lang/String;")
        return HeitaoSdk.checkResult(ok,ret)
    end
    return "-1"
end

return HeitaoSdk
