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

        --Bugly:ReportLuaException(msg)
        Crashlytics:reportLuaException(msg)
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
