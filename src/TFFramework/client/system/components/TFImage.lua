--[[--
	图片控件:

	--By: yun.bo
	--2013/7/12
]]

local TFUIBase = TFUIBase
local TFImage = TFImage
local _create = TFImage.create
function TFImage:create(texturePath , ...)
	texturePath = TFGlobalUtils:transTexturePath(texturePath)
	local obj = _create(TFImage, texturePath , ...)
	if  not obj then return end
	TFUIBase:extends(obj)
	return obj
end

local function new(val, parent)
	local obj = TFImage:create()
	if parent then
		parent:addChild(obj) 
	end
	return obj
end

local function initControl(_, val, parent)
	local obj = new(val, parent)
	obj:initMEImage(val, parent)
	return true, obj
end
rawset(TFImage, "initControl", initControl)


--重写接口用于多语言资源载入 
local _setTexture_en = TFImage.setTexture
rawset(TFImage, "setTexture", function ( self ,texturePath, ... )
	if type(texturePath) == "userdata" then --如果是传入pTexture数据则直接调用原函数
		_setTexture_en(self, texturePath , ...)
		return
	end
	local code = TFLanguageMgr:getUsingLanguageCode("_")
	if code ~= "" and texturePath~= "" then
		if LanguageResMgr ~= nil then
			local pitctureData = LanguageResMgr:getData()
			if pitctureData[texturePath] then
				_setTexture_en(self,pitctureData[texturePath] , ...)
			else
				_setTexture_en(self, texturePath,...)
			end
		else
			local textureName = string.gsub(texturePath , "%." ,code..".")
			if TFFileUtil:existFile(textureName) then
				_setTexture_en(self, textureName , ...)
			else
				_setTexture_en(self, texturePath,...)
			end
		end
		
	else
		_setTexture_en(self, texturePath,...)
	end
end)

return TFImage