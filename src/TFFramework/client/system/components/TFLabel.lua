--[[--
	文本控件:

	--By: yun.bo
	--2013/7/29
]]

local TFUIBase = TFUIBase
TFLabelNative = TFLabel

-- local function setOutLine(obj)

-- end
rawset(TFLabelNative, "setOutline", CCLabelTTF.enableStroke)


local _create = TFLabelNative.create
function TFLabelNative:create()
	local obj = _create(TFLabelNative)
	if  not obj then return end
	TFUIBase:extends(obj)
	-- add by daxiong 设置字体颜色，在手机上不能用顶点色设置
	if CC_TARGET_PLATFORM ~= CC_PLATFORM_WIN32 then
		obj.setColor = function( self, color )
			self:setFontFillColor(color);
		end
	end
	return obj
end

local function new(val, parent)
	local obj
	obj = TFLabelNative:create()
	if parent then
		parent:addChild(obj) 
	end
	return obj
end

local function initControl(_, val, parent)
	local obj = new(val, parent)
	if TF_FONT_DEFAULT then val.fontName = TF_FONT_DEFAULT end
	obj:initMELabel(val, parent)
	return true, obj
end
rawset(TFLabelNative, "initControl", initControl)

return TFLabelNative
