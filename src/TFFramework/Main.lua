require('TFFramework.base.class')

__G_ERROR_CALLBACK__ = nil

function __G__TRACKBACK__(msg)
    print("----------------------------------------\n", msg, "\n", debug.traceback())

    local msg = "LUA ERROR: " .. tostring(msg) .. "\n"
    msg = msg .. debug.traceback()

    if ErrorCodeManager then
        ErrorCodeManager:reportErrorMsg(msg)
    end

    if VERSION_DEBUG == true then
        TFLOGERROR(msg)
    else
        -- if CommonManager then
        --     CommonManager:openWarningLayer()
        -- end

        Bugly:ReportLuaException(msg)
    end
end

function gotoGameStart()
    collectgarbage("stop")
    require('TFFramework.init')
    collectgarbage("collect")

    -- set image encrypt key
    if EncryptCode_SetKey then 
        EncryptCode_SetKey(57)
    end

     --暂时加判断 默认显示语言为英文 2020-03-11
    local isPlay = CCUserDefault:sharedUserDefault():getBoolForKey("isPlayOpenVideoNew");
    local isPlayOnYearVedio = CCUserDefault:sharedUserDefault():getBoolForKey("isPlayOpenOneYearVideoNew")
     if not isPlay and not isPlayOnYearVedio then
        if HeitaoSdk then
            if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
                local deviceLanguage = HeitaoSdk.getDeviceLanguage()
                --简体中文/繁体中文/繁体中文香港/繁体中文台湾/繁体中文澳门
                if (deviceLanguage == "zh-Hans-CN") or 
                    (deviceLanguage == "zh-Hant-CN") or
                    (deviceLanguage == "zh-Hant-HK") or
                    (deviceLanguage == "zh-Hant-TW") or
                    (deviceLanguage == "zh-Hant-MO") then
                    CCUserDefault:sharedUserDefault():setStringForKey("language" , "")
                    GAME_LANGUAGE_VAR = ""
                else
                    CCUserDefault:sharedUserDefault():setStringForKey("language" , "_en")
                    GAME_LANGUAGE_VAR = "_en"
                end
            else
                --zh-CN简中 zh-TW繁中 en-US英语
                local deviceLanguage = HeitaoSdk.getDeviceLanguage()
                if deviceLanguage == "zh-CN" or deviceLanguage == "zh-TW" then  --如果等于简中或者繁中则显默认中文
                    CCUserDefault:sharedUserDefault():setStringForKey("language" , "")
                    GAME_LANGUAGE_VAR = ""
                else
                    CCUserDefault:sharedUserDefault():setStringForKey("language" , "_en")
                    GAME_LANGUAGE_VAR = "_en"
                end
            end
            
        else
            CCUserDefault:sharedUserDefault():setStringForKey("language" , "_en")
            GAME_LANGUAGE_VAR = "_en"
        end
    end

	-- TFDirector:startRemoteDebug()
    TFDirector:start()
    me.Director:setDisplayStats(false)

    if TFFileUtil:existFile('LuaScript/TFGameStartup.lua') then
	    local gameStartup = require('LuaScript.TFGameStartup'):new()
	    TFLogManager:sharedLogManager():TFFtpSetUpload(false)
	    gameStartup:run(TFFramework_RestartContent)
	else
        if TFFileUtil:existFile('TFGameStartup.lua') then
            local gameStartup = require('TFGameStartup'):new()
            TFLogManager:sharedLogManager():TFFtpSetUpload(false)
            gameStartup:run(TFFramework_RestartContent)
        else
            TFLOGERROR("Can't find TFGameStartup.lua")
        end
    end
end

function main()
    -- if CC_TARGET_PLATFORM ~= CC_PLATFORM_WIN32 then
    --     local updateScene = require("TFFramework.update.updateScene")
    --     updateScene:run(gotoGameStart)
    -- else
    --     DEBUG = 1
    --     gotoGameStart()
    -- end

    DEBUG = 0
    if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
        DEBUG = 1
    end
    gotoGameStart()

end
xpcall(main, __G__TRACKBACK__);
