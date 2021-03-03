Crashlytics = {
    cachedError = {}
}

if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
    Crashlytics.classname         = "org/cocos2dx/TerransForce/CrashlyticsLuaManager"
end

function Crashlytics:checkResult( ok, ret )
    -- body
    if ok then return ret end
    print("lua to java fail")
    return nil
end

function Crashlytics:crashlyticsSetCustomKey( crashlyticsKey, crashlyticsValue )
    if not self:enableCrashlytics() then return end
    crashlyticsKey = crashlyticsKey or  "default"
    crashlyticsValue = crashlyticsValue or "0"

    crashlyticsKey = tostring(crashlyticsKey)
    crashlyticsValue = tostring(crashlyticsValue)

    local args = nil
    local ok  = false
    local ret = nil
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        ok,ret = TFLuaOcJava.callStaticMethod(Crashlytics.classname, "setCustomKey", {crashlyticsKey, crashlyticsValue}, "(Ljava/lang/String;Ljava/lang/String;)V");
    end
    return self.checkResult(ok,ret)
end

function Crashlytics:crashlyticsSetUserId( id )
    if not self:enableCrashlytics() then return end

    id = id or "None"

    local args = nil
    local ok  = false
    local ret = nil

    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        ok,ret = TFLuaOcJava.callStaticMethod(Crashlytics.classname, "setUserId", {id}, "(Ljava/lang/String;)V");
    end
    return HeitaoSdk.checkResult(ok,ret)
end

function Crashlytics:crashlyticsRecordException( msg )
    if not self:enableCrashlytics() then return end
    msg = msg or "None"

    local args = nil
    local ok  = false
    local ret = nil

    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        ok,ret = TFLuaOcJava.callStaticMethod(Crashlytics.classname, "recordException", {msg}, "(Ljava/lang/String;)V");
    end
    return HeitaoSdk.checkResult(ok,ret)
end

--[[
    上报Lua异常
    msg : lua出错时的msg信息
]]
function Crashlytics:reportLuaException( msg )
    if not self:enableCrashlytics() then return end

    if self.cachedError[msg] then return end
    self.cachedError[msg] = true
    self:setCrashlyticsCustomKey()
    self:crashlyticsRecordException(msg)
end

function Crashlytics:setCrashlyticsCustomKey( )
    if not self:enableCrashlytics() then return end
    local platform = ""
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        platform = "IOS"
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        platform = "ANDROID"
    end
    self:crashlyticsSetCustomKey("platform", platform)

    local systemVersion = TFDeviceInfo:getSystemVersion() or 1
    self:crashlyticsSetCustomKey("systemVersion", systemVersion)

    local apkVersion = TFDeviceInfo:getCurAppVersion()
    apkVersion = apkVersion or "1.0.1"
    self:crashlyticsSetCustomKey("apkVersion", apkVersion)
    
    local updateVersion = ""
    require('TFFramework.net.TFClientUpdate')
    local newUpdateFun = TFClientResourceUpdate:GetClientResourceUpdate()
    if newUpdateFun and newUpdateFun.getCurVersion then
        updateVersion = newUpdateFun:getCurVersion()
    end
    updateVersion = updateVersion or ""
    self:crashlyticsSetCustomKey("updateVersion", updateVersion)
    
    local playerId = ""
    local playerName = ""
    local playerLv = ""
    if MainPlayer then
        playerId = MainPlayer:getPlayerId()
        playerId = playerId or ""
        playerName = MainPlayer:getPlayerName()
        playerName = playerName or ""
        playerLv = MainPlayer:getPlayerLv()
        playerLv = playerLv or ""
    end
    self:crashlyticsSetCustomKey("playerId", playerId)
    self:crashlyticsSetCustomKey("playerName", playerName)
    self:crashlyticsSetCustomKey("playerLv", playerLv)

    if HeitaoSdk then
        local platformId = HeitaoSdk.getplatformId()
        self:crashlyticsSetCustomKey("platformId", platformId)

        local accountId = HeitaoSdk.getuserid() or ""
        accountId = string.url_encode(accountId)
        self:crashlyticsSetCustomKey("accountId", accountId)
    end
end

function Crashlytics:enableCrashlytics(  )
    if (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32) then return false end
    local platformId = -1
    if HeitaoSdk then
        platformId = HeitaoSdk.getplatformId()
    end

    local apkVersion = TFDeviceInfo:getCurAppVersion()
    apkVersion = apkVersion or "1.0.1"
    if not(tonumber(platformId) >= 3 and tonumber(apkVersion) > 1.16) then return false end
    return true
end