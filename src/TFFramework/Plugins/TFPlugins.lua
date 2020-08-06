--[[
SDK代理类


]]

if TFFileUtil:existFile("LuaScript/Plugins/TFPlugins.lua") then
	return require("LuaScript.Plugins.TFPlugins")
end

TFPlugins = {}

if CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
    TFPlugins = require("TFFramework.Plugins.TFPluginsBase")
elseif CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
    TFPlugins = require("TFFramework.Plugins.TFPluginsBase")
else
    TFPlugins = require('TFFramework.Plugins.win32.TFPluginsWin32')
end

TFPlugins.isUseObbDown = false

-- 如果手机 为母包则使用空的sdk
if CC_TARGET_PLATFORM ~= CC_PLATFORM_WIN32 then
    if TFPlugins.isPluginExist() == false then
        TFPlugins = require('TFFramework.Plugins.win32.TFPluginsWin32')
    end
end

-- local serverList_url = "http://192.168.10.100:9000/server/list.do"
-- 黑桃URL
local serverList_url = "http://120.92.15.251:9001/server/list.do"

-- win为测试环境
if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
    serverList_url = "http://120.92.15.251:9001/server/list.do"
    serverList_url = "http://192.168.10.115:9001/server/list.do"
end


-- win为测试环境
if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
    -- serverList_url = "http://120.92.15.251:9000/server/list.do"
    serverList_url = "http://192.168.10.115:9000/server/list.do"
elseif CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
    serverList_url = "http://ss.jhhd.heitao2014.com:9001/server/list.do"
end


if TFPlugins.isPluginExist() then
    serverList_url = serverList_url .. "?channel=" .. TFPlugins.getChannelId()
end

print("--- TFPlugins init ----- serverList_url = ", serverList_url)

-- 用户中心地址
TFPlugins.serverList_url = serverList_url

-- appstore 资源更新地址
TFPlugins.versionPath = "http://c.jhhd.heitao2014.com/jhhd/test/"
TFPlugins.filePath    = "http://c.jhhd.heitao2014.com/jhhd/test/source/"
TFPlugins.zipCheckPath= "http://c.jhhd.heitao2014.com/jhhd/test/"

if CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
    -- 江湖侠客令 安卓更新地址
    TFPlugins.versionPath = "http://c.jhhd.heitao2014.com/jhhd/andorid_zjhhd/"
    TFPlugins.filePath    = "http://c.jhhd.heitao2014.com/jhhd/andorid_zjhhd/source/"
    TFPlugins.zipCheckPath= "http://c.jhhd.heitao2014.com/jhhd/andorid_zjhhd/"
    
elseif CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
    -- 江湖侠客令 ios更新地址
    TFPlugins.versionPath = "http://c.jhhd.heitao2014.com/jhhd/ios_zjhhd/"
    TFPlugins.filePath    = "http://c.jhhd.heitao2014.com/jhhd/ios_zjhhd/source/"
    TFPlugins.zipCheckPath= "http://c.jhhd.heitao2014.com/jhhd/ios_zjhhd/"
end
---------测试外网
-- win为测试环境
if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
    TFPlugins.versionPath = "192.168.10.115:8081/mhqx/"
    TFPlugins.filePath    = "192.168.10.115:8081/mhqx/source/"
    TFPlugins.zipCheckPath= "192.168.10.115:8081/mhqx/"
end

--PackageManager:init("http://192.168.10.140:8080/twcs/package/")
PackageManager:init("http://cdn.pic.jyqxz2015.com/mhqx/HD/")
TFPlugins.isCompletePack = true   --是否是完整包

return TFPlugins
  