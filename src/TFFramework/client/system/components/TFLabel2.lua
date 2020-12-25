--[[--
    文本控件:

    --By: yun.bo
    --2013/7/29
]]

local pairs = pairs
local setmetatable = setmetatable
local tolua = tolua
local CCNode = CCNode
local ccs = ccs
local ccc3 = ccc3
local ccp = ccp

MELABEL_UPDATE_CONTENT = 10001

local TFUIBase = TFUIBase

local anchor_middle = ccp(0.5, 0.5)

local isGulong = false
if TFFileUtil:existFile("msyh.ttf") then 
    isGulong = true
end

local __Label_setFontName = Label.setFontName

TFLabel = class("TFLabel", function (fontSize, fontName)
    if isGulong and fontName == "simhei" then 
        fontName = "msyh.ttf"
    end

    if fontName then 
        if not TFFileUtil:existFile(fontName) then 
            fontName = "phanta.ttf"
        end
    end

    local node = Label:create("", fontName or "phanta.ttf", fontSize or 18)
    node.ignore = true
    return node
end)

local TFLabel = TFLabel
TFLabel.LabelEffect = {
    NORMAL          = 0,
    OUTLINE         = 1,
    SHADOW          = 2,
    GLOW            = 3,
    ITALICS         = 4,
    BOLD            = 5,
    UNDERLINE       = 6,
    STRIKETHROUGH   = 7,
    ALL             = 8
};

function TFLabel:ctor(fontSize)
    -- self:setAnchorPoint(anchor_middle)
end

function TFLabel:getDescription()
    return "TFLabel"
end

function TFLabel:setText(text)
    -- if self.text__ == text then return end

    -- if text == "" then text = " " end
    text = text or ""
    self.text__ = tostring(text)
    self:setString(self.text__)
end

function TFLabel:getText(text)
    return self.text__
end

function TFLabel:getStringLength()
    return #self.text__
end

function TFLabel:setFontColor(color3)
    self:setTextColor(ccc4(color3.r, color3.g, color3.b, 255))
end

function TFLabel:getFontColor()
    local color = self:getTextColor()
    return ccc3(color.r, color.g, color.b)
end

-- 斜体
-- function TFLabel:enableItalics()
--     self:enableItalics()
-- end

-- 粗体
-- function TFLabel:enableBold()
--     self:enableBold()
-- end

-- 下划线
-- function TFLabel:enableUnderline()
--     self:enableUnderline()
-- end

function TFLabel:enableStroke(color3, size)
    if type(size) == 'table' then 
        size = size.width
    end
    self:enableOutline(ccc4(color3.r, color3.g, color3.b, 255), size)
end

function TFLabel:disableStroke()
    self:disableEffect(TFLabel.LabelEffect.OUTLINE)
end

function TFLabel:setTouchScaleChangeEnabled()
    
end

function TFLabel:setTouchScaleChangeEnabled()
    
end

function TFLabel:setTouchScaleChangeAble()
    
end

function TFLabel:isTouchScaleChangeEnabled()
    return false
end

function TFLabel:setTextAreaSize(size)
    self:setDimensions(size.width, size.height)

    self.areaSize = size
end

function TFLabel:setTextHorizontalAlignment(align)
    self:setHorizontalAlignment(align)
end


function TFLabel:getTextHorizontalAlignment()
    return self:getHorizontalAlignment()
end

function TFLabel:setTextVerticalAlignment(align)
    self:setVerticalAlignment(align)
end

function TFLabel:getTextVerticalAlignment()
    return self:getVerticalAlignment()
end

function TFLabel:setLabelShadow( ... )
    -- body
end

function TFLabel:enableShadow()

end

function TFLabel:disableShadow()

end

function TFLabel:isShadowEnabled()
    return false
end

function TFLabel:isShadowEnabled()
    return false
end

-- rawset(TFLabel, "setOutline", TFLabel.enableStroke)
-- BY CT : outlineSize 为为零时，取消描边效果
rawset(TFLabel, "setOutline", function (label, outlineColor, outlineSize )
    if  outlineSize > 0 then
        label:enableStroke(outlineColor, outlineSize)
    else
        label:disableStroke(false)
    end
end)

function TFLabel:ignoreContentAdaptWithSize(bIgnore)
    if self.ignore == bIgnore then return end
    self.ignore = bIgnore
    if self.ignore then
        self:setDimensions(0,0)
    end
end

function TFLabel:isIgnoreContentAdaptWithSize()
    return self.ignore
end

function TFLabel:setFontFillColor( color3 )
    self:setTextColor(ccc4(color3.r, color3.g, color3.b, 255))
end


local function TFLabel_setFontName(self, fontName)
    if isGulong and fontName == "simhei" then 
        fontName = "msyh.ttf"
    end
    
    if fontName then 
        if not TFFileUtil:existFile(fontName) then 
            fontName = "phanta.ttf"
        end
    end

    --添加多语言字体切换功能
	local code = TFLanguageMgr:getUsingLanguageCode("_")
    if code ~= "" then
        local fontFileNew = string.gsub(fontName , "%." ,code..".")
        if TFFileUtil:existFile(fontFileNew) then 
            fontName = fontFileNew
        end
    end
    __Label_setFontName(self, fontName or "phanta.ttf")
end
rawset(Label, "setFontName", TFLabel_setFontName)

for key, val in pairs(TFLabel) do 
    if not rawget(Label, key) and type(val) == 'function' then 
        rawset(Label, key, val)
    end
end

local _create = TFLabel.create
function TFLabel:create(...)
    local obj = _create(TFLabel, ...)
    if  not obj then return end
    TFUIBase:extends(obj)
    return obj
end

local function getHeight(obj)
    local perheight = obj:getCommonLineHeight()
    local lineNum   = obj:getStringNumLines() or 0
    return perheight * lineNum   
end
rawset(Label, "getHeight", getHeight)

local function new(val, parent)
    local obj
    obj = TFLabel:create(val.fontSize, val.fontName)
    if parent then
        parent:addChild(obj) 
    end
    return obj
end

local function initControl(_, val, parent)
    local obj = new(val, parent)
    obj.____createParams = val
    obj:initMELabel(val, parent)
    return true, obj
end
rawset(TFLabel, "initControl", initControl)

return TFLabel
