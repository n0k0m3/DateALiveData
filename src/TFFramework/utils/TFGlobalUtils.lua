--测试包
DEBUG_PACKAGE = (HeitaoSdk and (HeitaoSdk.isTestPackage()))
RELEASE_TEST = DEBUG_PACKAGE

NEW_APP_VERSION = (HeitaoSdk and (HeitaoSdk.isNewVersionApp()))
if (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32) then
    NEW_APP_VERSION = true
end

--用于海外多语言脚本资源处理相关
TFGlobalUtils = class('TFGlobalUtils')

--供SDK影射地址使用使用
MIGRATION_SERVER_LIST = {}
MIGRATION_SERVER_LIST.UNKNOW = 0
MIGRATION_SERVER_LIST.Other = 2
MIGRATION_SERVER_LIST.Taiwan = 3
MIGRATION_SERVER_LIST.Korea = 4

GLOBAL_SERVER_LIST = {}
GLOBAL_SERVER_LIST.SERVER_UNKNOW = 0
GLOBAL_SERVER_LIST.SERVER_NIMILANGUAGE = 1  --小语种服连接标示
GLOBAL_SERVER_LIST.SERVER_ENGLISH = 2 --英文服连接标示
GLOBAL_SERVER_LIST.SERVER_KOREA_TW = 3 --韩台服连接标示

OPEN_SERVER_LIST = {}
if (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32) then
	table.insert(OPEN_SERVER_LIST,GLOBAL_SERVER_LIST.SERVER_ENGLISH)
	table.insert(OPEN_SERVER_LIST,GLOBAL_SERVER_LIST.SERVER_NIMILANGUAGE)
	table.insert(OPEN_SERVER_LIST,GLOBAL_SERVER_LIST.SERVER_KOREA_TW)
elseif (CC_TARGET_PLATFORM == CC_PLATFORM_IOS) then
	table.insert(OPEN_SERVER_LIST,GLOBAL_SERVER_LIST.SERVER_ENGLISH)
	table.insert(OPEN_SERVER_LIST,GLOBAL_SERVER_LIST.SERVER_NIMILANGUAGE)
	if NEW_APP_VERSION then
		table.insert(OPEN_SERVER_LIST,GLOBAL_SERVER_LIST.SERVER_KOREA_TW)
	end
else
	table.insert(OPEN_SERVER_LIST,GLOBAL_SERVER_LIST.SERVER_ENGLISH)
	table.insert(OPEN_SERVER_LIST,GLOBAL_SERVER_LIST.SERVER_NIMILANGUAGE)
	if NEW_APP_VERSION then
		table.insert(OPEN_SERVER_LIST,GLOBAL_SERVER_LIST.SERVER_KOREA_TW)
	end
end

local KEY_CACHE_SERVER_KEY = "KEY_CACHE_SERVER_KEY"
local KEY_CACHE_MIGRATION_SERVER_KEY = "KEY_CACHE_MIGRATION_SERVER_KEY"

--多语言ui
function TFGlobalUtils:loadUIConfigFilePath( uiPath )
	local code = TFLanguageMgr:getUsingLanguageCode()
	local fullPath = string.gsub(uiPath , '%.' , '/')
	if self:getPlayerServerIdx() == GLOBAL_SERVER_LIST.SERVER_NIMILANGUAGE then
		local primaryFullPath = string.gsub(fullPath , 'uiconfig' , 'uiconfig/primary/uiconfig_' ..code)
		primaryFullPath = "src/" ..primaryFullPath ..".lua"
		if TFFileUtil:existFile(primaryFullPath) then
			local primary = "uiconfig.primary.uiconfig_" ..code
			return string.gsub(uiPath , 'uiconfig' , primary)
		end
	end

	local secondaryFullPath = string.gsub(fullPath , 'uiconfig' , 'uiconfig/secondary/uiconfig_' ..code)
	secondaryFullPath = "src/" ..secondaryFullPath ..".lua"
	if TFFileUtil:existFile(secondaryFullPath) then
		local secondary = "uiconfig.secondary.uiconfig_" ..code
		return string.gsub(uiPath , 'uiconfig' , secondary)
	end
	return ""
end

--多语言表
function TFGlobalUtils:requireGlobalFile( path )
	local fullPath = string.gsub(path , '%.' , '/')
	if self:getPlayerServerIdx() == GLOBAL_SERVER_LIST.SERVER_NIMILANGUAGE then
		local primaryFullPath = string.gsub(fullPath , '/table' , '/table/primary')   
		primaryFullPath = "src/" ..primaryFullPath ..".lua"
		if TFFileUtil:existFile(primaryFullPath) then
			local primary = ".table.primary"
			local luaPath = string.gsub(path , '%.table' , primary)
			local file = require(luaPath)
			return file
		end
	elseif self:getPlayerServerIdx() == GLOBAL_SERVER_LIST.SERVER_KOREA_TW then
		local primaryFullPath = string.gsub(fullPath , '/table' , '/table/primaryht')   
		primaryFullPath = "src/" ..primaryFullPath ..".lua"
		if TFFileUtil:existFile(primaryFullPath) then
			local primary = ".table.primaryht"
			local luaPath = string.gsub(path , '%.table' , primary)
			local file = require(luaPath)
			return file
		end
	end

	local code = TFLanguageMgr:getUsingLanguageCode()
	local secondary = ".table.secondary." ..code
	local secondaryFullPath = string.gsub(fullPath , '/table' , '/table/secondary/' ..code)   
	secondaryFullPath = "src/" ..secondaryFullPath ..".lua" 
	if TFFileUtil:existFile(secondaryFullPath) then
		local luaPath = string.gsub(path , '%.table' , secondary)
		local file = require(luaPath)
		return file
	end

	local secondary = ".table.secondary"
	local secondaryFullPath = string.gsub(fullPath , '/table' , '/table/secondary') 
	secondaryFullPath = "src/" ..secondaryFullPath ..".lua" 
	if TFFileUtil:existFile(secondaryFullPath) then
		local file = require(string.gsub(path , '%.table' , secondary)) 
		return file
	end

	if TFFileUtil:existFile("src/" ..fullPath ..".lua") then
		local file = require(path) 
		return file
	end

	return {}
end

function TFGlobalUtils:unRequireGlobalFile( path )
	local code = TFLanguageMgr:getUsingLanguageCode()
	local fullPath = string.gsub(path , '%.' , '/')
	if self:getPlayerServerIdx() == GLOBAL_SERVER_LIST.SERVER_NIMILANGUAGE then
		local primaryFullPath = string.gsub(fullPath , '/table' , '/table/primary/')   
		primaryFullPath = "src/" ..primaryFullPath ..".lua" 
		if TFFileUtil:existFile(primaryFullPath) then
			local primary = ".table.primary."
			local luaPath = string.gsub(path , '%.table' , primary)
			TFDirector:unRequire(luaPath)
			return
		end
	elseif self:getPlayerServerIdx() == GLOBAL_SERVER_LIST.SERVER_KOREA_TW then
		local primaryFullPath = string.gsub(fullPath , '/table' , '/table/primaryht/')   
		primaryFullPath = "src/" ..primaryFullPath ..".lua" 
		if TFFileUtil:existFile(primaryFullPath) then
			local primary = ".table.primaryht."
			local luaPath = string.gsub(path , '%.table' , primary)
			TFDirector:unRequire(luaPath)
			return
		end
	end

	local secondary = ".table.secondary." ..code
	local secondaryFullPath = string.gsub(fullPath , '/table' , '/table/secondary/' ..code)   
	secondaryFullPath = "src/" ..secondaryFullPath ..".lua" 
	if TFFileUtil:existFile(secondaryFullPath) then
		local luaPath = string.gsub(path , '%.table' , secondary)
		TFDirector:unRequire(luaPath)
		return
	end

	local secondary = ".table.secondary."
	local secondaryFullPath = string.gsub(fullPath , '/table' , '/table/secondary/')   
	secondaryFullPath = "src/" ..secondaryFullPath ..".lua" 
	if TFFileUtil:existFile(secondaryFullPath) then
		TFDirector:unRequire(string.gsub(path , '%.table' , secondary))
		return
	end
end

--多语言动画
function TFGlobalUtils:transAniNameByLanguage( spine, name )
	if not spine:getSkeleton() then
		return name
	end
	print(spine:getName()  .." origin play animation: " ..name)
	local aniName = spine:transToLanguageAniName(name, TFLanguageMgr:getUsingLanguage())
	print(spine:getName()  .." new play animation: " ..aniName)
	return aniName
end

-- 战令区分1服和2服
function TFGlobalUtils:replaceTexturePath(texturePath)
	if(texturePath and texturePath ~= "") then
		if TFGlobalUtils:isConnectMiniServer() then
			texturePath = string.gsub(texturePath, "ui/task/01/", "ui/task/02/")
		end
	end
	return texturePath
end

--多语言图片
function TFGlobalUtils:transTexturePath( texturePath )
	local code = TFLanguageMgr:getUsingLanguageCode("_")
	if code ~= "" and texturePath and texturePath ~= "" then
		if type(texturePath) ~= "userdata" then --如果是传入pTexture数据则直接调用原函数

			texturePath = self:replaceTexturePath(texturePath)

			if LanguageResMgr ~= nil then
				local pitctureData = LanguageResMgr:getData()
				if pitctureData[texturePath] then
					texturePath = pitctureData[texturePath]
				end
			else
				local textureName = string.gsub(texturePath , "%." ,code..".")
				if TFFileUtil:existFile(textureName) then
					texturePath = textureName
				end
			end
		end
	end
	return texturePath
end

function TFGlobalUtils:getCacheServer( )
	local idx = CCUserDefault:sharedUserDefault():getIntegerForKey(KEY_CACHE_SERVER_KEY, GLOBAL_SERVER_LIST.SERVER_UNKNOW)
	return idx
end

function TFGlobalUtils:setCacheServer( value )
	if value == nil then return  end
	CCUserDefault:sharedUserDefault():setIntegerForKey(KEY_CACHE_SERVER_KEY, value)
	CCUserDefault:sharedUserDefault():flush()
end

function TFGlobalUtils:isConnectMiniServer( )
	return (self:getPlayerServerIdx() == GLOBAL_SERVER_LIST.SERVER_NIMILANGUAGE)
end

function TFGlobalUtils:isConnectEnServer( )
	return (self:getPlayerServerIdx() == GLOBAL_SERVER_LIST.SERVER_ENGLISH)
end

function TFGlobalUtils:isConnectKoreaTwServer( )
	return (self:getPlayerServerIdx() == GLOBAL_SERVER_LIST.SERVER_KOREA_TW)
end

function TFGlobalUtils:getPlayerServerIdx( )
	--1.已连接的服务器
	local cacheServerId = self:getCacheServer()
	if self:isGameServerOpen(cacheServerId) then
		return cacheServerId
	end

	--2.转号选择的服务器
	if NEW_APP_VERSION then
		local _,sdkServerId = TFGlobalUtils:getMigrationServerToGameServer(false)
		if self:isGameServerOpen(sdkServerId) then 
	    	return sdkServerId
	    end
	end

	--默认优先2服
    if self:isGameServerOpen(GLOBAL_SERVER_LIST.SERVER_NIMILANGUAGE) then  
    	return GLOBAL_SERVER_LIST.SERVER_NIMILANGUAGE
    end
    return GLOBAL_SERVER_LIST.SERVER_ENGLISH
end

function TFGlobalUtils:isGameServerOpen( serverId )
	if serverId then
		if table.find(OPEN_SERVER_LIST, serverId) ~= -1 then
			return true
		end
	end
	return false
end

function TFGlobalUtils:getServerUrlList( )
	local serverIdx = self:getPlayerServerIdx()
	if (serverIdx == GLOBAL_SERVER_LIST.SERVER_NIMILANGUAGE) then
		return URL_LOGIN_MINILANGUAGE
	end
	if (serverIdx == GLOBAL_SERVER_LIST.SERVER_ENGLISH) then
		return URL_LOGIN_ENGLISH
	end
	if (serverIdx == GLOBAL_SERVER_LIST.SERVER_KOREA_TW) then
		return URL_LOGIN_KOREA_TW
	end
	return URL_LOGIN_ENGLISH
end

function TFGlobalUtils:checkPlayerProvision( playerName )
	local replaceTxt,count = string.gsub(playerName, "40389ef1390e11eb9" ,"******")
	return replaceTxt,count
end

function TFGlobalUtils:setMigrationServerId( value )
	-- body
	if value then
        CCUserDefault:sharedUserDefault():setIntegerForKey(KEY_CACHE_MIGRATION_SERVER_KEY, value)
    end
end

function TFGlobalUtils:getMigrationServerId( isCache )
	local value = CCUserDefault:sharedUserDefault():getIntegerForKey(KEY_CACHE_MIGRATION_SERVER_KEY, MIGRATION_SERVER_LIST.UNKNOW)
	if (value > MIGRATION_SERVER_LIST.UNKNOW) and isCache then
		return true, value
	end
	local defaultValue = MIGRATION_SERVER_LIST.Other
	if NEW_APP_VERSION then
		if TFLanguageMgr:getCurrentLanguage() == cc.KOREAN then
			defaultValue = MIGRATION_SERVER_LIST.Korea
		elseif TFLanguageMgr:getCurrentLanguage() == cc.TRADITIONAL_CHINESE then
			defaultValue = MIGRATION_SERVER_LIST.Taiwan
		end
	end
	return false, defaultValue
end

function TFGlobalUtils:getMigrationServerToGameServer( isCache )
	local _exitCacheValue, sdkServer = self:getMigrationServerId( isCache )
	if (sdkServer == MIGRATION_SERVER_LIST.Korea) or (sdkServer == MIGRATION_SERVER_LIST.Taiwan) then
		return _exitCacheValue, GLOBAL_SERVER_LIST.SERVER_KOREA_TW
	end

	if sdkServer == MIGRATION_SERVER_LIST.Other then
		return _exitCacheValue, GLOBAL_SERVER_LIST.SERVER_NIMILANGUAGE
	end

	return _exitCacheValue, GLOBAL_SERVER_LIST.SERVER_NIMILANGUAGE
end

function TFGlobalUtils:getMigrationServerTextById( migrationServerId )
	-- body
	if migrationServerId == nil then return "" end
	local textIdList = {}
	textIdList[MIGRATION_SERVER_LIST.Other] = 190000819
	textIdList[MIGRATION_SERVER_LIST.Taiwan] = 190000818
	textIdList[MIGRATION_SERVER_LIST.Korea] = 190000817

	if textIdList[migrationServerId] then return textIdList[migrationServerId] end
	return ""
end

function TFGlobalUtils:canMigrationServerEnterGameServer( )
	-- body
	if not NEW_APP_VERSION then return true end
	local _,migrationserver = self:getMigrationServerToGameServer(true)
	local gameServer = TFGlobalUtils:getPlayerServerIdx()
	if migrationserver == gameServer then  return  true end
	if (migrationserver == GLOBAL_SERVER_LIST.SERVER_NIMILANGUAGE) and (gameServer == GLOBAL_SERVER_LIST.SERVER_ENGLISH) then
		return true
	end
	return false
end

return TFGlobalUtils




