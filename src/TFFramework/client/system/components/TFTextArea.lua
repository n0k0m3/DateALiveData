--[[--
	文本块控件:

	--By: yun.bo
	--2013/9/30
]]

TFTextArea = {}

local LabelImpl = TFLabel--Native

function TFTextArea:create(fontSize)
	local obj = LabelImpl:create(fontSize)
	return obj
end

local function new(val, parent)
	local obj
	obj = TFTextArea:create(val.fontSize)
	if parent then
		parent:addChild(obj) 
	end
	return obj
end

local function initControl(_, val, parent)
	local obj = new(val, parent)
	if TF_FONT_DEFAULT then val.fontName = TF_FONT_DEFAULT end
	obj:setFontName("phanta.ttf")
	obj:initMETextArea(val, parent)
	return true, obj
end
rawset(TFTextArea, "initControl", initControl)

return TFTextArea
