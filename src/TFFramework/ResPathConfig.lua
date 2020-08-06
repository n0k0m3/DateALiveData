function __G__TRACKBACK__2(msg)
    print("----------------------------------------");
    local msg = "LUA ERROR: " .. tostring(msg) .. "/n"
    msg = msg .. debug.traceback()
    print(msg)
    TFLOGERROR(msg)
    print("----------------------------------------");
end

require('TFFramework.base.me.mango.TFLuaOcJava')
require('TFFramework.utils.TFDeviceInfo')
local TF_PLATFORM_IOS		= 1
local TF_PLATFORM_ANROID	= 2
local TF_PLATFORM_WIN32		= 3

local updatePath = CCFileUtils:sharedFileUtils():getWritablePath()

local tblResPath = {}
if CC_TARGET_PLATFORM == TF_PLATFORM_IOS then
    updatePath = updatePath .. '../Library/'
    tblResPath =
    {
    	updatePath .. "packageUncompress/",
    	updatePath .. "TFDebug/",
    }
elseif CC_TARGET_PLATFORM == TF_PLATFORM_ANROID then
	local sdPath = TFDeviceInfo.getSDPath()
    if sdPath and #sdPath >1 then	
        local  sPackName = TFDeviceInfo.getPackageName()
        updatePath = sdPath .."playmore/" .. sPackName .. "/"
    end
    tblResPath =
    {
    	updatePath,
    	updatePath     .. "packageUncompress/",
    	updatePath     .. "TFDebug/",
    }
else
    tblResPath =
    {   
    	updatePath .. "../Library/packageUncompress/", 
		updatePath .. "../../Resource/",
		updatePath .. "../../Resource/smallPic",
		updatePath .. "../Library/TFDebug/",
		--"E:/svn/share_taopeng/JHXKL_HD/Resource",
		--"E:/svn/engine_ios64/TerransForce/TF150409_Beta1/Resource",
		-- "/Users/richard/Documents/svn/ForDevelop/Resource",
    }
end

local function ResPathConfig()
	print("getWritablePath = ", CCFileUtils:sharedFileUtils():getWritablePath())
	for i = #tblResPath, 1, -1  do
		TFFileUtil:addPathToSearchAtFront(tblResPath[i])
		print("add path: ", tblResPath[i])
	end
	if(TFFileUtil:existFile("LuaScript/TFPathConfig.lua")) then
		local tPath = require("LuaScript.TFPathConfig")
		local tUpdate
        local tPackage
		if tPath.Update == nil and tPath.Package == nil then
			tUpdate = tPath
			tPackage = tPath
		else
            tUpdate = tPath.Update
            tPackage = tPath.Package
        end
        
		for i , k in pairs(tUpdate) do
			CCFileUtils:sharedFileUtils():addSearchPath(updatePath..k)
		end
		for i , k in pairs(tPackage) do
			CCFileUtils:sharedFileUtils():addSearchPath(k)
		end
		package.loaded["LuaScript.TFPathConfig"] = nil
	-- else
	-- 	for i = #tblResPath, 1, -1  do
	-- 		CCFileUtils:sharedFileUtils():addSearchPath(tblResPath[i])
	-- 		print("2222222add path: ", tblResPath[i])
	-- 	end
	end

	if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
    	CCFileUtils:sharedFileUtils():addSearchPath(updatePath .. "../Library/TFDebug/")
	end
	
	package.loaded['TFFramework.base.me.mango.TFLuaOcJava'] = nil
	package.loaded['TFFramework.utils.TFDeviceInfo'] = nil

	require('TFFramework.base.me.mango.TFLuaOcJava')
	require('TFFramework.utils.TFDeviceInfo')
end

xpcall(ResPathConfig, __G__TRACKBACK__2);
