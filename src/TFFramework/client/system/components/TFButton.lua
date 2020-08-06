--[[--
	按钮控件:

	--By: yun.bo
	--2013/7/12
]]
local TFUIBase = TFUIBase
local TFButton = TFButton
local _bcreate = TFButton.create


function TFButton:create(texture)
	local obj = _bcreate(TFButton)
	if  not obj then return end
	TFUIBase:extends(obj)
	if texture then 
		obj:setTextureNormal(texture)
	end
	return obj
end

local function new(val, parent)
	local obj
	obj 	= TFButton:create(val.texture)
	if parent then
		parent:addChild(obj) 
	end
	return obj
end

local function initControl(_, val, parent)
	local obj = new(val, parent)
	obj:initMEButton(val, parent)
	return true, obj
end
rawset(TFButton, "initControl", initControl)
-- BY CT : 重写接口兼容三国业务调用
local setFontStrokeEnabled_origin = TFButton.setFontStrokeEnabled
rawset(TFButton, "setFontStrokeEnabled", function ( b,c,s )
	if	s > 0 then
		setFontStrokeEnabled_origin(b, c, s)
	else
		b:setFontStrokeDisabled()
	end
end)

--重写接口用于多语言资源载入   设置常态按钮
local _setTextureNormal_en = TFButton.setTextureNormal
rawset(TFButton, "setTextureNormal", function ( self ,texturePath, ... )
	local language = GAME_LANGUAGE_VAR
	if language ~= "" and texturePath~= "" then
		if LanguageResMgr ~= nil then
			local pitctureData = LanguageResMgr:getData()
			if pitctureData[texturePath] then
				_setTextureNormal_en(self,pitctureData[texturePath] , ...)
			else
				_setTextureNormal_en(self, texturePath,...)
			end
		else
			local textureName = string.gsub(texturePath , "%." ,language..".")
			if TFFileUtil:existFile(textureName) then
				_setTextureNormal_en(self, textureName , ...)
			else
				_setTextureNormal_en(self, texturePath,...)
			end
		end
	else
		_setTextureNormal_en(self, texturePath,...)
	end
end)

--重写接口用于多语言资源载入   设置按下按钮
local _setTexturePressed_en = TFButton.setTexturePressed
rawset(TFButton, "setTexturePressed", function ( self ,texturePath, ... )
	local language = GAME_LANGUAGE_VAR
	if language ~= "" and texturePath~= "" then
		if LanguageResMgr ~= nil then
			local pitctureData = LanguageResMgr:getData()
			if pitctureData[texturePath] then
				_setTexturePressed_en(self,pitctureData[texturePath] , ...)
			else
				_setTexturePressed_en(self, texturePath,...)
			end
		else
			local textureName = string.gsub(texturePath , "%." ,language..".")
			if TFFileUtil:existFile(textureName) then
				_setTexturePressed_en(self, textureName , ...)
			else
				_setTexturePressed_en(self, texturePath,...)
			end
		end
	else
		_setTexturePressed_en(self, texturePath,...)
	end
end)


--重写接口用于多语言资源载入   设置取消按钮
local _setTextureDisabled_en = TFButton.setTextureDisabled
rawset(TFButton, "setTextureDisabled", function ( self ,texturePath, ... )
	local language = GAME_LANGUAGE_VAR
	if language ~= "" and texturePath~= "" then
		if LanguageResMgr ~= nil then
			local pitctureData = LanguageResMgr:getData()
			if pitctureData[texturePath] then
				_setTextureDisabled_en(self,pitctureData[texturePath] , ...)
			else
				_setTextureDisabled_en(self, texturePath,...)
			end
		else
			local textureName = string.gsub(texturePath , "%." ,language..".")
			if TFFileUtil:existFile(textureName) then
				_setTextureDisabled_en(self, textureName , ...)
			else
				_setTextureDisabled_en(self, texturePath,...)
			end
		end
	else
		_setTextureDisabled_en(self, texturePath,...)
	end
end)


return TFButton