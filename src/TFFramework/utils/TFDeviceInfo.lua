TFDeviceInfo={}
TFDeviceInfo.CLASS_NAME = nil
TFDeviceInfo.totalMemery = nil
if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
    TFDeviceInfo.CLASS_NAME = "TFDeviceInfo"
elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
    TFDeviceInfo.CLASS_NAME = "org/cocos2dx/lib/TFDeviceInfo"
end

local TG3_GRAVITY_EARTH = 9.80665
function __G_OnAccelerate(x, y, z, t)
    if x ~= 0 and y ~= 0 then 
        TFDirector:dispatchGlobalEventWith("HeitaoSdk.ACCELEROMETER_UPDATE", {x = x * TG3_GRAVITY_EARTH, y = y * TG3_GRAVITY_EARTH})      
    end
end

function TFDeviceInfo:NativeCallHandle(type, result)
    TFDirector:dispatchGlobalEventWith("TFDeviceInfo.NativeCall", { type = type, result = result })    
end

function TFDeviceInfo.checkResult(ok, ret)
    -- body
    if ok then return ret end
    return nil
end

function TFDeviceInfo:acquirePowerLock()
    local ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "acquire",nil,"()V")
    return TFDeviceInfo.checkResult(ok,ret)
end

function TFDeviceInfo:releasePowerLock()
    local ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "release",nil,"()V")
    return TFDeviceInfo.checkResult(ok,ret)
end

function TFDeviceInfo:getSystemName()
    local ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "getSystemName",nil,"()Ljava/lang/String;")
    return TFDeviceInfo.checkResult(ok,ret)
end

function TFDeviceInfo:getSystemVersion()
    local ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "getSystemVersion",nil,"()Ljava/lang/String;")
    return TFDeviceInfo.checkResult(ok,ret)
end

function TFDeviceInfo:getMachineName()
    local ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "getMachineName",nil,"()Ljava/lang/String;")
    return TFDeviceInfo.checkResult(ok,ret)
end

function TFDeviceInfo:getCurAppName()
    local ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "getCurAppName",nil,"()Ljava/lang/String;")
    return TFDeviceInfo.checkResult(ok,ret)
end

function TFDeviceInfo:getCurAppVersion()

    if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then 
        return "1.0.0"
    end

    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        local ok,ret = TFLuaOcJava.callStaticMethod("HeitaoManager", "getAppVersion",nil,"()Ljava/lang/String;")
        return TFDeviceInfo.checkResult(ok,ret)
    else
        local ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "getCurAppVersion",nil,"()Ljava/lang/String;")
        return TFDeviceInfo.checkResult(ok,ret)
    end
end

function TFDeviceInfo:getAppVersionCode()
    if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 or CC_TARGET_PLATFORM == CC_PLATFORM_IOS then 
        return "0"
    else
        local ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "getAppVersionCode",nil,"()I")
        return TFDeviceInfo.checkResult(ok,ret)
    end
end


function TFDeviceInfo:getPhoneNumber()
    local ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "getPhoneNumber",nil,"()Ljava/lang/String;")
    return TFDeviceInfo.checkResult(ok,ret)
end

function TFDeviceInfo:getTotalMem()
    if TFDeviceInfo.totalMemery then
        return TFDeviceInfo.totalMemery
    end
    if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then 
        TFDeviceInfo.totalMemery = math.ceil(TFProcessHelper:getAllMemory() / 1024)
        return TFDeviceInfo.totalMemery
    end
    local ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "getTotalMem",nil,"()Ljava/lang/String;")
    TFDeviceInfo.totalMemery = TFDeviceInfo.checkResult(ok,ret)
    return TFDeviceInfo.totalMemery
end

function TFDeviceInfo:getFreeMem()
    if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then 
        return math.ceil(TFProcessHelper:getFreeMemory() / 1024)
    end
    local ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "getFreeMem",nil,"()Ljava/lang/String;")
    return TFDeviceInfo.checkResult(ok,ret)
end

function TFDeviceInfo:getIsJailBreak()
    local ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "getIsJailBreak",nil,"()Ljava/lang/String;")
    return TFDeviceInfo.checkResult(ok,ret)
end

function TFDeviceInfo:getAddreddBook()
    local ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "getAddreddBook",nil,"()Ljava/lang/String;")
    return TFDeviceInfo.checkResult(ok,ret)
end

--will return "2G,3G,4G,5G,WIFI,NO"
function TFDeviceInfo:getNetWorkType()
    -- local ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "getNetWorkType",nil,"()Ljava/lang/String;")
    -- return TFDeviceInfo.checkResult(ok,ret)
    if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
        return "WIFI"
    end

    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        local ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "getNetWorkType",nil,"()Ljava/lang/String;")
        return TFDeviceInfo.checkResult(ok,ret)
    else
        local ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "getNetWorkType",nil,"()Ljava/lang/String;")
        return TFDeviceInfo.checkResult(ok,ret)
    end
end

function TFDeviceInfo:copyToPasteBord(content)
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "copyToPasteBord",{szContent = content})
    else
        TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "copyToPasteBord",{content})
    end
end

function TFDeviceInfo:getClipBoardText()
    local ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "getClipBoardText",nil,"()Ljava/lang/String;")
    return TFDeviceInfo.checkResult(ok,ret)
end

function TFDeviceInfo:getDeviceToken()
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        return CCApplication:sharedApplication():getDeviceTokenID()
     else
        print("android not support")
        return nil
    end
end

function TFDeviceInfo:getCarrierOperator()
    local ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "getCarrierOperator",nil,"()Ljava/lang/String;")
    return TFDeviceInfo.checkResult(ok,ret)
end

function TFDeviceInfo:getSDPath()
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        print("ios not support")
        return nil
    else
        local ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "getSDPath",nil,"()Ljava/lang/String;")
        if ok and #ret >1 then
            return ret
        else
            return nil
        end
    end
end

function TFDeviceInfo:getPackageName()
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        print("ios not support")
        return nil
    else
        local ok,ret = TFLuaOcJava.callStaticMethod("org/cocos2dx/lib/Cocos2dxHelper", "getCocos2dxPackageName",nil,"()Ljava/lang/String;")
        if ok and #ret >1 then
            return ret
        else
            return nil
        end
    end
end

-- 退出游戏
function TFDeviceInfo:terminateApp()
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        endToLua()
    else
    	TFLuaOcJava.callStaticMethod("org/cocos2dx/lib/Cocos2dxHelper", "terminateProcess")
    end
end

function TFDeviceInfo:getResolution()
    -- body
    return me.frameSize.width .. 'x' .. me.frameSize.height
end

local deviceModelMap = {
    ["iPhone1,1"] = "iPhone 2G (A1203)",
    ["iPhone1,2"] = "iPhone 3G (A1241/A1324)",
    ["iPhone2,1"] = "iPhone 3GS (A1303/A1325)",
    ["iPhone3,1"] = "iPhone 4 (A1332)",
    ["iPhone3,2"] = "iPhone 4 (A1332)",
    ["iPhone3,3"] = "iPhone 4 (A1349)",
    ["iPhone4,1"] = "iPhone 4S (A1387/A1431)",
    ["iPhone5,1"] = "iPhone 5 (A1428)",
    ["iPhone5,2"] = "iPhone 5 (A1429/A1442)",
    ["iPhone5,3"] = "iPhone 5c (A1456/A1532)",
    ["iPhone5,4"] = "iPhone 5c (A1507/A1516/A1526/A1529)",
    ["iPhone6,1"] = "iPhone 5s (A1453/A1533)",
    ["iPhone6,2"] = "iPhone 5s (A1457/A1518/A1528/A1530)",
    ["iPhone7,1"] = "iPhone 6 Plus (A1522/A1524)",
    ["iPhone7,2"] = "iPhone 6 (A1549/A1586)",
    ["iPhone8,1"] = "iPhone 6s (A1633/A1688/A1691/A1700)",
    ["iPhone8,2"] = "iPhone 6S Plus (A1634/A1687/A1690/A1699)",
    ["iPhone8,3"] = "iPhone SE",
    ["iPhone8,4"] = "iPhone SE",
    ["iPhone9,1"] = "iPhone 7",
    ["iPhone9,2"] = "iPhone 7 Plus",
    ["iPhone9,4"] = "iPhone 7 Plus",
    ["iPhone10,1"] = "iPhone 8",
    ["iPhone10,4"] = "iPhone 8",
    ["iPhone10,2"] = "iPhone 8 Plus",
    ["iPhone10,5"] = "iPhone 8 Plus",
    ["iPhone10,3"] = "iPhone X",
    ["iPhone10,6"] = "iPhone X",
    ["iPhone11,8"] = "iPhone XR",
    ["iPhone11,2"] = "iPhone XS",
    ["iPhone11,4"] = "iPhone XS Max",
    ["iPhone11,6"] = "iPhone XS Max",

    ["iPod1,1"]   = "iPod Touch 1G (A1213)",
    ["iPod2,1"]   = "iPod Touch 2G (A1288/A1319)",
    ["iPod3,1"]   = "iPod Touch 3G (A1318)",
    ["iPod4,1"]   = "iPod Touch 4G (A1367)",
    ["iPod5,1"]   = "iPod Touch 5G (A1421/A1509)",
    ["iPod7,1"]   = "iPod touch 6G (A1574)",
    
    ["iPad1,1"]   = "iPad 1G (A1219/A1337)",    
    ["iPad2,1"]   = "iPad 2 (A1395)",
    ["iPad2,2"]   = "iPad 2 (A1396)",
    ["iPad2,3"]   = "iPad 2 (A1397)",
    ["iPad2,4"]   = "iPad 2 (A1395+New Chip)",
    ["iPad2,5"]   = "iPad Mini 1G (A1432)",
    ["iPad2,6"]   = "iPad Mini 1G (A1454)",
    ["iPad2,7"]   = "iPad Mini 1G (A1455)",
    
    ["iPad3,1"]   = "iPad 3 (A1416)",
    ["iPad3,2"]   = "iPad 3 (A1403)",
    ["iPad3,3"]   = "iPad 3 (A1430)",
    ["iPad3,4"]   = "iPad 4 (A1458)",
    ["iPad3,5"]   = "iPad 4 (A1459)",
    ["iPad3,6"]   = "iPad 4 (A1460)",
    
    ["iPad4,1"]   = "iPad Air (A1474)",
    ["iPad4,2"]   = "iPad Air (A1475)",
    ["iPad4,3"]   = "iPad Air (A1476)",
    ["iPad4,4"]   = "iPad Mini 2G (A1489)",
    ["iPad4,5"]   = "iPad Mini 2G (A1490)",
    ["iPad4,6"]   = "iPad Mini 2G (A1491)",

    ["iPad4,7"]   = "iPad Mini 3 (A1599)",
    ["iPad4,8"]   = "iPad Mini 3 (A1600)",
    ["iPad4,9"]   = "iPad Mini 3 (A1601)",

    ["iPad5,1"]   = "iPad Mini 4 (A1538)",
    ["iPad5,2"]   = "iPad Mini 4 (A1550)",

    ["iPad5,3"]   = "iPad Air 2 (A1566)",
    ["iPad5,4"]   = "iPad Air 2 (A1567)",

    ["iPad6,3"]   = "iPad Pro",
    ["iPad6,4"]   = "iPad Pro",
    ["iPad6,7"]   = "iPad Pro (A1584)",
    ["iPad6,8"]   = "iPad Pro (A1652)",
    ["iPad6,11"]   = "iPad 5",
    ["iPad6,12"]   = "iPad 5",

    ["iPad7,1"]   = "iPad Pro 12.9-inch 2",
    ["iPad7,2"]   = "iPad Pro 12.9-inch 2",
    ["iPad7,3"]   = "iPad Pro 10.5-inch",
    ["iPad7,4"]   = "iPad Pro 10.5-inch",
    
    ["i386"]      = "iPhone Simulator",
    ["x86_64"]    = "iPhone Simulator",    
}


function TFDeviceInfo:getCurrentDeviceModel()  
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then  
        local ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "getCurrentDeviceModel", nil, "()Ljava/lang/String;")
        return TFDeviceInfo.checkResult(ok,ret) or "iOS"
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        return "android"
    else
        return "win32"
    end
end

function TFDeviceInfo:isLowDevice()  
    if TFDeviceInfo.bLowDevice == nil then
        local model = TFDeviceInfo:getCurrentDeviceModel()
        if string.find(model, "iPhone1") then 
            TFDeviceInfo.bLowDevice = true
        elseif string.find(model, "iPhone2") then 
            TFDeviceInfo.bLowDevice = true
        elseif string.find(model, "iPhone3") then 
            TFDeviceInfo.bLowDevice = true
        elseif string.find(model, "iPhone4") then 
            TFDeviceInfo.bLowDevice = true
        elseif string.find(model, "iPhone5") then 
            TFDeviceInfo.bLowDevice = true
        elseif string.find(model, "iPhone6") then 
            TFDeviceInfo.bLowDevice = true
        elseif string.find(model, "iPhone7") then 
            TFDeviceInfo.bLowDevice = true
        elseif string.find(model, "iPod1") then 
            TFDeviceInfo.bLowDevice = true
        elseif string.find(model, "iPod2") then 
            TFDeviceInfo.bLowDevice = true
        elseif string.find(model, "iPod3") then 
            TFDeviceInfo.bLowDevice = true
        elseif string.find(model, "iPod4") then 
            TFDeviceInfo.bLowDevice = true
        elseif string.find(model, "iPad1") then 
            TFDeviceInfo.bLowDevice = true
        elseif string.find(model, "iPad2") then 
            TFDeviceInfo.bLowDevice = true
        else
            TFDeviceInfo.bLowDevice = false
        end
    end
    return TFDeviceInfo.bLowDevice
end

function TFDeviceInfo:getMacAddress()
    local ok = nil
    local ret = nil
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME,"getMacAddress")
    else
        print("only support ios")
    end
    return TFDeviceInfo.checkResult(ok,ret)
end

function TFDeviceInfo:getMachineOnlyID()
    local ok = nil
    local ret = nil
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        ok,ret = TFLuaOcJava.callStaticMethod("HeitaoManager","getIDFA")
    else
    	--不保证不变动
	ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME,"getMachineOnlyID",nil,"()Ljava/lang/String;")
    end
    return TFDeviceInfo.checkResult(ok,ret)
end

-- 获取设备剩余内存
function TFDeviceInfo:getMachineFreeSpace()
    local ok = false
    local value = nil
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        ok,value = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME,"getDeviceFreeSpace")
    else
        ok1,valueInternal = TFLuaOcJava.callStaticMethod("org/cocos2dx/lib/Cocos2dxHelper","getInternalMemLeftSize",nil,"()I")
        ok2,valueExt = TFLuaOcJava.callStaticMethod("org/cocos2dx/lib/Cocos2dxHelper","getExternalTotalMemSize",nil,"()I")
        ok = ok1 and ok2 
        if ok then 
            value = valueInternal > valueExt and valueInternal or valueExt
        else 
            if ok1 then value = valueInternal end
            if ok2 then value = valueExt end
            if value then ok = true end
        end
    end
    return TFDeviceInfo.checkResult(ok,value)
end

-- 生成UUID
function TFDeviceInfo:getUUID()
    if CC_TARGET_PLATFORM ~= CC_PLATFORM_ANDROID then 
        return TFProcessHelper:getUUID()
    end
    local ok, ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "getUUID",nil,"()Ljava/lang/String;")
    return TFDeviceInfo.checkResult(ok, ret) 
end

-- 设置重力感应时间间隔
function TFDeviceInfo:setAccelerometerInterval(interval)
    interval = interval or 0.02
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "setAccelerometerInterval", {interval = interval})
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "setAccelerometerInterval", {interval})
    end
end

--打开重力感应
function TFDeviceInfo:setOpenAccelerometer(isOpenAccelerometer)
	if isOpenAccelerometer == nil then isOpenAccelerometer = true end
    local ok  = false
    local ret = nil
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "setOpenAccelerometer", {isOpenAccelerometer = isOpenAccelerometer})
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "setOpenAccelerometer", {isOpenAccelerometer})
    end
    return ok
end

function TFDeviceInfo:setCloseAccelerometer()
    TFDeviceInfo:setOpenAccelerometer(false)
end

-- 是否打开系统浏览器
function TFDeviceInfo:openUrl(url)
    local ok  = false
    local ret = nil
    if HeitaoSdk then
        if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
            ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "openUrl", {url = url})
        elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
            ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "openUrl", {url})
        end
    end

    return ok
end

--打开黑桃sdk的内嵌网页
function TFDeviceInfo:openHeitaoWebUrl(url)
    local ok  = false
    local ret = nil

    if HeitaoSdk then
        if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
            ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "openHeitaoWebUrl", {url = url})
        elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
            ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "openHeitaoWebUrl", {url})
        end
    end
    return ok
end

--获取手机电量
function TFDeviceInfo:getBatteryLevel()
    if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then 
        return 100
    end
    local ok, ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "getBatteryLevel", nil, "()I")
    if ok then
        if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then 
            ret = ret * 100
        end
        ret = math.floor(ret)
        return ret
    end
    return 0
end

-- 震动, ios 无法指定时间
function TFDeviceInfo:Vibrator(value)
    local ok,ret
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then 
        ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "Vibrator")
    else    
        ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "Vibrator", {value}, "(I)V")
    end
    return TFDeviceInfo.checkResult(ok, ret)
end

-- 取消震动, ios 无效
function TFDeviceInfo:cancelVibrator()
    local ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "cancelVibrate")
    return TFDeviceInfo.checkResult(ok, ret)
end

-- 是否保持屏幕常亮
function TFDeviceInfo:setKeepScreenOn(isOn)
    if isOn == nil then isOn = true end
    local ok,ret
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then 
        ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "setKeepScreenOn", { isOn = isOn })
    else 
        ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "setKeepScreenOn", { isOn })
    end
    return TFDeviceInfo.checkResult(ok, ret)
end

-- 设置音效播放速率
function TFDeviceInfo:setSoundEffectRate(rate)
    rate = rate or 1
    local ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "setEffectSpeedRate", { rate })
    return TFDeviceInfo.checkResult(ok, ret)
end

-- 获取音效播放速率
function TFDeviceInfo:getSoundEffectRate()
    local ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "getEffectSpeedRate", nil, "()F")
    return TFDeviceInfo.checkResult(ok, ret)
end

-- 获取android应用pss总量
function TFDeviceInfo:getPSS()
    print("get PSS 1", me.platform, me.platform ~= "android")
    if me.platform ~= "android" then return 0 end
    local ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "getPSS", nil, "()I")
    return TFDeviceInfo.checkResult(ok, ret)
end

-- 获取android应用Mem总量
function TFDeviceInfo:getAppMem()
    if me.platform ~= "android" then return 0 end
    local ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "getAppMem", nil, "()I")
    return TFDeviceInfo.checkResult(ok, ret)
end

function TFDeviceInfo:isGoogleObbExist()
    if me.platform ~= "android" then return 0 end
    local ok,ret = TFLuaOcJava.callStaticMethod(TFDeviceInfo.CLASS_NAME, "isGoogleObbExist", nil, "()Z")
    return TFDeviceInfo.checkResult(ok, ret)
end

function TFDeviceInfo:requestStoreReview()
    if me.platform ~= "ios" then return 0 end
    local ok,ret = TFLuaOcJava.callStaticMethod("PhantaSDK", "requestStoreReview", nil, "()V")
    return TFDeviceInfo.checkResult(ok, ret)
end

return TFDeviceInfo
  