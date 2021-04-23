--[[--
	--By:zhangliguo
]]
TFLanguageMgr = class('TFLanguageMgr')
--多语言处理
-------------------------------------------------------
cc = {}
cc.ENGLISH = ENGLISH
cc.SIMPLIFIED_CHINESE = SIMPLIFIED_CHINESE
cc.TRADITIONAL_CHINESE = TRADITIONAL_CHINESE
cc.FRENCH = FRENCH
cc.ITALIAN = ITALIAN
cc.GERMAN = GERMAN
cc.SPANISH = SPANISH
cc.DUTCH = DUTCH
cc.RUSSIAN = RUSSIAN
cc.KOREAN = KOREAN
cc.JAPANESE = JAPANESE
cc.HUNGARIAN = HUNGARIAN
cc.PORTUGUESE = PORTUGUESE
cc.ARABIC = ARABIC
cc.NORWEGIAN = NORWEGIAN
cc.POLISH = POLISH
cc.TURKISH = TURKISH
cc.UKRAINIAN = UKRAINIAN
cc.ROMANIAN = ROMANIAN
cc.BULGARIAN = BULGARIAN
cc.BELARUSIAN = BELARUSIAN
cc.THAI = THAI
cc.INDONESIAN = INDONESIAN
cc.MALAYSIA = MALAYSIA

--[[
	获得全部的语言枚举
]]
function TFLanguageMgr:getLanguages( )
	--英语(en)，法语(fr)，德语(de)，西班牙语(es)，泰语(th)，印尼语(id)，韩语(ko)，简体中文(zn)，繁体中文(zh)
	if TFGlobalUtils:isConnectEnServer() then
		return {cc.ENGLISH, cc.SIMPLIFIED_CHINESE}
	end
	if TFGlobalUtils:isConnectKoreaTwServer() then
		return {cc.TRADITIONAL_CHINESE, cc.KOREAN}
	end
	return {cc.ENGLISH, cc.FRENCH, cc.GERMAN, cc.SPANISH, cc.THAI, cc.INDONESIAN, cc.KOREAN, cc.TRADITIONAL_CHINESE, cc.SIMPLIFIED_CHINESE} 
end

function TFLanguageMgr:getLanguageTextId( language )
	local textList = {190012001,190012002,190012003,190012004,190012005,190012006,190012007,190012008,190012009}
	if TFGlobalUtils:isConnectEnServer() then
		textList = {190012001, 190012009}
	elseif TFGlobalUtils:isConnectKoreaTwServer() then
		textList = {190012008, 190012007}
	end
	
	local list = self:getLanguages()
	local idx = table.find(list, language)
	if idx ~= -1 then
		return textList[idx]
	end
	return textList[1]
end

--当前使用语言是否可用
function TFLanguageMgr:languageEnable( language )
	local list = self:getLanguages()
	local idx = table.find(list, language)
	if idx ~= -1 then
		return true, language
	end
	if TFGlobalUtils:isConnectKoreaTwServer() then
		return false, cc.KOREAN
	end
	return false, cc.ENGLISH
end

function TFLanguageMgr:getCurrentLanguage( )
	return TFLanguageManager:shareLanguageManager():getCurrentLanguage()
end

function TFLanguageMgr:getCurrentLanguageCode( )
	return TFLanguageManager:shareLanguageManager():getCurrentLanguageCode()
end

function TFLanguageMgr:getCurrentCountryCode( )
	return TFLanguageManager:shareLanguageManager():getCurrentCountryCode()
end

function TFLanguageMgr:getCodeByLanguage( language )
	return TFLanguageManager:shareLanguageManager():getCodeByLanguage(language)
end

--获得当前语言对应的后缀
function TFLanguageMgr:getUsingLanguageCode( suffix )
	local str = suffix or ""
	return str ..self:getCodeByLanguage(self:getUsingLanguage())
end

--获得当前的语言
function TFLanguageMgr:getUsingLanguage()
	local language = TFLanguageManager:shareLanguageManager():getAppUsingLanguage()
	local _,_language = self:languageEnable(language)
	return _language
end

--设置当前的语言
function TFLanguageMgr:setUsingLanguage( language )
	if not (type(language) == "number") then return end
	local _,_language = self:languageEnable(language)
	TFLanguageManager:shareLanguageManager():setAppUsingLanguage(_language)
end


--返回sdk需要的映射语言值
function TFLanguageMgr:getSdkUsingLanguage()
	local languageCodeMap = {}
    languageCodeMap[cc.FRENCH] = "fr"
    languageCodeMap[cc.GERMAN] = "de"
    languageCodeMap[cc.SPANISH] = "es"
    languageCodeMap[cc.THAI] = "th"
    languageCodeMap[cc.INDONESIAN] = "id"
    languageCodeMap[cc.KOREAN] = "ko"
    languageCodeMap[cc.TRADITIONAL_CHINESE] = "zh-Hant"
    languageCodeMap[cc.ENGLISH] = "en"
    languageCodeMap[cc.SIMPLIFIED_CHINESE] = "cn"

    local language = "en"
    if languageCodeMap[TFLanguageMgr:getUsingLanguage()] then
        language = languageCodeMap[TFLanguageMgr:getUsingLanguage()]
    end
    return language
end

return TFLanguageMgr




