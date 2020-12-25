math.randomseed(os.time())
math.random()
math.random()
math.random()
math.random()

__FRAMEWORK_VERSION__   	= require("TFFramework.TFVersion").__ENGINE_VERSION__
__FRAMEWORK_GLOBALS__     	= __FRAMEWORK_GLOBALS__ or {}
__FRAMEWORK_ENVIRONMENT__ 	= "WIN7"

-- close jit compile
-- some android machine will cause unfortunately error
if jit and type(jit.off) == 'function' then jit.off() end

--[[
	调试等级
	nil/0 	: 关闭所有调试信息
	1   	: 打开所有调试信息
]]
DEBUG 			  			= DEBUG or 0 
if DEBUG == 0 then DEBUG = nil end

--[[--
	To control wheather or not to send msg to svn http server
	0: off
	1: on
]]
ENABLE_DEBUG_HTTPMSG 		= ENABLE_DEBUG_HTTPMSG or 0
ENABLE_ADAPTOR				= ENABLE_ADAPTOR or false

ENABLE_LUA_DEBUG 			= ENABLE_LUA_DEBUG or "false"

--是否开启自动化测试
ENABLE_DEBUG_FOR_AUTO_TEST  = false
AUTO_TEST_IP 				= "192.168.10.45"
AUTO_TEST_PORT 				= 6666

require('TFFramework.SkeletonAnimationEx')
--[[--
	Load Base Tools
]]
require('TFFramework.base.macros')
require('TFFramework.base.class')
require('TFFramework.base.functions')
require('TFFramework.base.bit')
require('TFFramework.base.bit_64')

--[[--
	Load Utils
]]
require('TFFramework.utils.TFTableUtils')
require('TFFramework.utils.TFFunctionUtils')
require('TFFramework.utils.TFStringUtils')
require('TFFramework.utils.TFIOUtils')
require('TFFramework.utils.Bugly')


--[[
	Load TF module
--]]
require('TFFramework.base.me.initME')

require('TFFramework.utils.TFVisibleUtils')
require('TFFramework.utils.TFLanguageUtils')
require('TFFramework.utils.TFGlobalUtils')
--[[--
	Load Algorithm
]]
require('TFFramework.algorithm.TFArray')
require('TFFramework.algorithm.Polygon')
require('TFFramework.algorithm.Triangulate')
require('TFFramework.algorithm.PathFinder')

--[[--
	Load Net
]]
require('TFFramework.net.TFClientNet')

--[[--
	Load Managers
]]
require('TFFramework.client.entity.TFEaseType')
require('TFFramework.client.manager.TFBaseManager')
require('TFFramework.client.manager.TFLogManager')
require('TFFramework.client.manager.TFEventManager')
require('TFFramework.client.manager.TFEnterFrameManager')
require('TFFramework.client.manager.TFTimerManager')
require('TFFramework.client.manager.TFTweenManager')
require('TFFramework.client.manager.TFSceneManager')
require('TFFramework.client.manager.TFProtocolManager')
require('TFFramework.client.manager.TFShaderManager')
require('TFFramework.client.director.TFDirector')

--[[--
	Load UI
]]
require('TFFramework.client.system.components.initComponents')
require('TFFramework.luacomponents.initLuaComponents')

require('TFFramework.base.me.TF_Adaptor')
--[[
	Load ClientUpdate
]]
-- require('TFFramework.net.TFClientUpdate')

--[[
	load TFPackageManager
]]
require('TFFramework.net.TFPackageManager')

-- require('TFFramework.SDK.TFSdk')

if TFFileUtil:existFile("LuaScript/Plugins/anysdkConst.lua") then
	require("LuaScript.Plugins.anysdkConst")
else 
	require("TFFramework.Plugins.anysdkConst")
end

if TFFileUtil:existFile("LuaScript/Plugins/TFPlugins.lua") then
	require("LuaScript.Plugins.TFPlugins")
else 
	require("TFFramework.Plugins.TFPlugins")
end

require("TFFramework.HeitaoSdk.HeitaoSdk")

--推送
require("TFFramework.push.TFPush")
--IMSDK
--require("TFFramework.IMSDK.TFIMManager")

-- avoid memory leak
collectgarbage("setpause", 130)
collectgarbage("setstepmul", 5000)

if TFFileUtil:existFile("LuaScript/adapt.lua") then
	require("LuaScript.adapt")
end 

------------------------------------------------------info
SetConcoleTextColor(ConsoleColor.forg.lavender, ConsoleColor.forg.lavender, ConsoleColor.forg.lavender)
print()
print('=======================TFFramework Infos===============')
print("MangoEngine Version:          " .. __FRAMEWORK_VERSION__)
print("me.platform:                  " .. me.platform)
print(string.format("me.winSize:                   width(%d)  height(%d)", me.winSize.width, me.winSize.height))
print(string.format("me.frameSize:                 width(%d)  height(%d)", me.frameSize.width, me.frameSize.height))
print("DEBUG Level:                  " .. tostring(DEBUG))
print("Adaptor enabled:              " .. tostring(ENABLE_ADAPTOR))
print("ENABLE_LUA_DEBUG:             " .. ENABLE_LUA_DEBUG)
print("Jit Version:                  " .. (jit or {version = "None"}).version)
print("Lua collect pause:            130")
print("Lua collect stepmul:          5000")
print('=======================================================')
print()
SetConcoleTextColor()

---------------------------------------------------------------------------------------------

function meStartDebug(debugHost)
	if ENABLE_LUA_DEBUG == "true" or os.getenv('ENABLE_LUA_DEBUG') == "true"
		then
		debugHost = debugHost or '127.0.0.1'
		require('TFFramework.mobdebug').start('127.0.0.1')
	else
		print('Remote debug not enabled or not supported...')
	end
end
