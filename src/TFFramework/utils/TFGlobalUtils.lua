--用于海外多语言脚本资源处理相关
TFGlobalUtils = class('TFGlobalUtils')

GLOBAL_SERVER_LIST = {}
GLOBAL_SERVER_LIST.SERVER_UNKNOW = 0
GLOBAL_SERVER_LIST.SERVER_NIMILANGUAGE = 1  --小语种服连接标示
GLOBAL_SERVER_LIST.SERVER_ENGLISH = 2 --英文服连接标示

OPEN_NIMILANGUAGE_SERVER = true
if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
	OPEN_NIMILANGUAGE_SERVER = true
end

local KEY_CACHE_SERVER_KEY = "KEY_CACHE_SERVER_KEY"

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
		local primaryFullPath = string.gsub(fullPath , 'table' , 'table/primary')   
		primaryFullPath = "src/" ..primaryFullPath ..".lua"
		if TFFileUtil:existFile(primaryFullPath) then
			local primary = "table.primary"
			local luaPath = string.gsub(path , 'table' , primary)
			local file = require(luaPath)
			return file
		end
	end

	local code = TFLanguageMgr:getUsingLanguageCode()
	local secondary = "table.secondary." ..code
	local secondaryFullPath = string.gsub(fullPath , 'table' , 'table/secondary/' ..code)   
	secondaryFullPath = "src/" ..secondaryFullPath ..".lua" 
	if TFFileUtil:existFile(secondaryFullPath) then
		local luaPath = string.gsub(path , 'table' , secondary)
		local file = require(luaPath)
		return file
	end

	local secondary = "table.secondary"
	local secondaryFullPath = string.gsub(fullPath , 'table' , 'table/secondary')   
	secondaryFullPath = "src/" ..secondaryFullPath ..".lua" 
	if TFFileUtil:existFile(secondaryFullPath) then
		local file = require(string.gsub(path , 'table' , secondary)) 
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
		local primaryFullPath = string.gsub(fullPath , 'table' , 'table/primary/')   
		primaryFullPath = "src/" ..primaryFullPath ..".lua" 
		if TFFileUtil:existFile(primaryFullPath) then
			local primary = "table.primary."
			local luaPath = string.gsub(path , 'table' , primary)
			TFDirector:unRequire(luaPath)
			return
		end
	end

	local secondary = "table.secondary." ..code
	local secondaryFullPath = string.gsub(fullPath , 'table' , 'table/secondary/' ..code)   
	secondaryFullPath = "src/" ..secondaryFullPath ..".lua" 
	if TFFileUtil:existFile(secondaryFullPath) then
		local luaPath = string.gsub(path , 'table' , secondary)
		TFDirector:unRequire(luaPath)
		return
	end

	local secondary = "table.secondary."
	local secondaryFullPath = string.gsub(fullPath , 'table' , 'table/secondary/')   
	secondaryFullPath = "src/" ..secondaryFullPath ..".lua" 
	if TFFileUtil:existFile(secondaryFullPath) then
		TFDirector:unRequire(string.gsub(path , 'table' , secondary))
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

function TFGlobalUtils:getPlayerServerIdx( )
	local cacheServerId = self:getCacheServer()
	if OPEN_NIMILANGUAGE_SERVER and (cacheServerId == GLOBAL_SERVER_LIST.SERVER_NIMILANGUAGE) then
		return GLOBAL_SERVER_LIST.SERVER_NIMILANGUAGE
	end
	if cacheServerId == GLOBAL_SERVER_LIST.SERVER_ENGLISH then
		return GLOBAL_SERVER_LIST.SERVER_ENGLISH
	end
    
    if OPEN_NIMILANGUAGE_SERVER then  
    	return GLOBAL_SERVER_LIST.SERVER_NIMILANGUAGE
    end
    return GLOBAL_SERVER_LIST.SERVER_ENGLISH
end

function TFGlobalUtils:getServerUrlList( )
	if self:getPlayerServerIdx() == GLOBAL_SERVER_LIST.SERVER_NIMILANGUAGE then
		return URL_LOGIN_MINILANGUAGE
	end
	return URL_LOGIN_ENGLISH
end

function TFGlobalUtils:checkPlayerProvision( playerName )
	local replaceTxt,count = string.gsub(playerName, "40389ef1390e11eb9" ,"******")
	return replaceTxt,count
end

return TFGlobalUtils




