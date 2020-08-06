--滚动条
local ScrollBar = class("ScrollBar", function ()
    local layer = TFPanel:create()
    layer:setName("ScrollBar")
    return layer
end)

local function swapSize(size)
    return me.size(size.height,size.width)
end
--滚动条的方向
ScrollBar.Direction =
{
    Vertical   = 1,  --垂直
    horizontal = 2   --水平
}
local Direction = ScrollBar.Direction
function ScrollBar:ctor(direction)
    self.direction     = direction
    self.scrollLength  = 0
    self.percent       = 0
    local size
    local barSize
    if self.direction  == Direction.Vertical then
        size    = me.size(14,200)
        barSize = me.size(size.width,50)
    else
        size    = me.size(200,14)
        barSize = me.size(50,size.height)
    end
    self.slideBar   = TFPanel:create()
    self.slideBar:setAnchorPoint(me.p(0.5,0.5))
    self.slideBar:setBackGroundColorType(TF_LAYOUT_COLOR_SOLID)
    self.slideBar:setBackGroundColor(me.c3b(0xFF,0x20,0x60))
    self.slideBar:setSize(barSize)
    self:addChild(self.slideBar)
    ----
    self:setAnchorPoint(me.p(0.5,0.5))
    self:setBackGroundColor(me.c3b(0x00,0x00,0x00))
    self:setBackGroundColorType(TF_LAYOUT_COLOR_SOLID)
    self:setSize(size)
    self:_doLayout()
    self:setBarLengthPercent(5)
    self:setPercent(0)
end

function ScrollBar:setDirection(direction)
    if self.direction ~= direction then
        local barSize  = self.slideBar:getSize()
        barSize = swapSize(barSize)
        self.slideBar:setSize(barSize)
        local size = self:getSize()
        self:setContentSize(size)
    end
     self.direction = direction
end

function ScrollBar:setContentSize(size)
    self:setSize(size)
    local barSize  = self.slideBar:getSize()
    if self.direction == Direction.Vertical then
        barSize.width  = size.width
    else
        barSize.height = size.height
    end
    self.slideBar:setSize(barSize)
    self:_doLayout()
end

function ScrollBar:setBarTexture(textureName)
    self.slideBar:setBackGroundImage(textureName)
end

function ScrollBar:setBarImageScale9Enabled(enabled)
    self.slideBar:setBackGroundImageScale9Enabled(enabled)
end

function ScrollBar:setBarImageCapInsets(x, y, w, h)
    self.slideBar:setBackGroundImageCapInsets(me.rect(x, y, w, h))
end

function ScrollBar:setBarLengthPercent(percent)
    percent = math.floor(percent)
    percent = math.max(percent,5)
    percent = math.min(percent,100)
    local slideBarSize  = self.slideBar:getSize()
    local size  = self:getSize()
    if self.direction   == Direction.Vertical then
        slideBarSize.height = size.height * percent *0.01
    else
        slideBarSize.width  = size.width * percent *0.01
    end
    self.slideBar:setSize(slideBarSize)
    self:_doLayout()
    self:_updateBarPosition()
    if percent == 100 then
        self:hide()
    else
        self:show()
    end
end

function ScrollBar:_fadeOut()
    self:stopAllActions()
    local actions = {
        DelayTime:create(2),
        FadeOut:create(1)
    }
    self:runAction(Sequence:create(actions))
end

function ScrollBar:_doLayout()
    local size  = self:getSize()
    local slideBarSize  = self.slideBar:getSize()
    if self.direction   == Direction.Vertical then
        self.scrollLength = size.height - slideBarSize.height
    else
        self.scrollLength = size.width - slideBarSize.width
    end
end

function ScrollBar:_updateBarPosition()
    local pos = self.scrollLength*self.percent*0.01  - self.scrollLength/2
    if self.direction   == Direction.Vertical then
        self.slideBar:setPositionY(pos)
    else
        self.slideBar:setPositionX(pos)
    end
    self:setOpacity(0xff)
    self:_fadeOut()
end

function ScrollBar:setPercent(percent)
    percent = math.max(percent,0)
    percent = math.min(percent,100)
    self.percent = percent
    self:_updateBarPosition()
end



return ScrollBar
