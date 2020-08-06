--local ResLoader = require("lua.logic.battle.ResLoader")

local function isInRect(avatar, point)
    local pos = avatar:getPosition()
    local size = avatar:getContentSize()
    local rect = ccr(pos.x, pos.y, size.width - 1, size.height - 1)
    return (point.x >= rect.origin.x) and (point.x <= rect.origin.x + rect.size.width) and
            (point.y >= rect.origin.y) and (point.y <= rect.origin.y + rect.size.height)
end

local function changeElementState(element, centerPoint, index, callback)
    if isInRect(element.avatar, centerPoint) then
        element.avatar:setVisible(false)
        element.animation:setVisible(true)
        if type(callback) == "function" then
            callback(index, element.id)
        end
    else
        element.avatar:setVisible(true)
        element.animation:setVisible(false)
    end
end

local function moveElements(self, offsetX, isClick)
    local elements, imageWidth, centerPoint, halfWidth = self.elements, self.elementWidth, self.centerPoint, self.elementWidth * 0.5
    local offset = math.abs(offsetX) > halfWidth and imageWidth or 0

    if offsetX > 0 then
        local count = #elements
        for i, element in ipairs(elements) do
            local x = element.avatar:getPositionX()
            if x + offset >= count * imageWidth + halfWidth then
                element.avatar:setPositionX(halfWidth)
            else
                element.avatar:setPositionX(x + offset)
            end
            if not isClick then
                changeElementState(element, centerPoint, i, self.onScrollWithElement)
            end
        end
    end

    if offsetX < 0 then
        local count = #elements
        for i, element in ipairs(elements) do
            local x = element.avatar:getPositionX()
            if x - offset <= -halfWidth then
                element.avatar:setPositionX(count * imageWidth - halfWidth)
            else
                element.avatar:setPositionX(x - offset)
            end
            if not isClick then
                changeElementState(element, centerPoint, i, self.onScrollWithElement)
            end
        end
    end
end

local function scrollElement(self, offsetX, isClick)
    local elements, imageWidth, centerPoint = self.elements, self.elementWidth, self.centerPoint
    local count = math.ceil(math.floor(math.abs(offsetX) / imageWidth + 0.5) * imageWidth / imageWidth)
    local offset = offsetX < 0 and -imageWidth or imageWidth
    local idx = 0
    local function animation(dt)
        idx = idx + 1
        moveElements(self, offset, isClick)
        if idx == count  and isClick then
            for i, element in ipairs(elements) do
                changeElementState(element, centerPoint, i, self.onClickWithElement)
            end
        end
    end

    TFDirector:addTimer(0, count, nil, animation)
end

local function jumpWithImage(self, sender, isClick)
    local x = sender:getPositionX()
    local offsetX = self.centerPoint.x - x
    scrollElement(self, offsetX, isClick)
end

local ScrollFlow = class("Scroll", function()
    return TFPanel:create()
end)

--[[
{
    angle = default value is -3.14
    elements = {
        {
            id = ""
            avatar = imageNode
            animation = animationNode
        },
        {
            id = "
            avatar = imageNode
            animation = animationNode
        }
    } no default value
    onScrollWithElement = function([index, id])
    onClickWithElement = function([index, id])
    contentWidth = 默认会根据图片长宽计算出接近此值，并能显示奇数个图片的长度，如果不填写，会用GameConfig.WS.width 计算
    contentHeight = default value is image:getTextureRect().size.height
    imageWidth = default value is image:getTextureRect().size.width or 100
    imageHeight = default value is image:getTextureRect().size.height or 100
    imageScale = default value is 1
}
--]]
function ScrollFlow:ctor(data)
    self.angle = data.angle
    self.elements = data.elements
    self.elementScale = data.imageScale or 1
    self.elementWidth = data.imageWidth or 100
    self.elementHeight = data.imageHeight or 100
    self.onClickWithElement = data.onClick
    self.onScrollWithElement = data.onScroll
    --self.contentWidth = nil
    --self.contentHeight = nil
    self:init()
end

function ScrollFlow:init()

    local beganPosition = {}
    local isMoving = false
    local onTouchBegan = function(sender)
        local pos = sender:getTouchStartPos()
        beganPosition.x = pos.x
        beganPosition.y = pos.y
        self.touchLayer:setSwallowTouch(isMoving)
    end

    local onTouchMoved = function(sender)
        local currentPosition = sender:getTouchMovePos()
        local offsetX = currentPosition.x - beganPosition.x
        if math.abs(offsetX) > self.elementWidth * 0.5 then
            isMoving = true
            self.touchLayer:setSwallowTouch(true)
            scrollElement(self, offsetX)
            beganPosition.x, beganPosition.y = currentPosition.x, currentPosition.y
        end
    end

    local onTouchEnded = function(sender)
        if isMoving then
            isMoving = false
        else
            self.touchLayer:setSwallowTouch(false)
        end
    end

    self.touchLayer = TFLayer:create()
    self.touchLayer:setTouchEnabled(true)
    self.touchLayer:setSize(GameConfig.WS)
    self.touchLayer:setContentSize(GameConfig.WS)
    self.touchLayer:addMEListener(TFWIDGET_TOUCHBEGAN, onTouchBegan)
    self.touchLayer:addMEListener(TFWIDGET_TOUCHMOVED, onTouchMoved)
    self.touchLayer:addMEListener(TFWIDGET_TOUCHENDED, onTouchEnded)
    self.touchLayer:setSwallowTouch(false)
    self:addChild(self.touchLayer, 1)

    self.contentLayer = TFClippingNode:create()
    self.contentLayer:setContentSize(GameConfig.WS)
    self:addChild(self.contentLayer)

    self.animationLayer = TFPanel:create()
    self.animationLayer:setContentSize(GameConfig.WS)
    self.animationLayer:setClippingEnabled(false)
    self:addChild(self.animationLayer)

    ---[[ for dbg
    --self.animationLayer:setBackGroundColorType(1)
    --self.animationLayer:setBackGroundColor(ccc3(0, 0, 128))
    --self.animationLayer:setBackGroundColorOpacity(60)
    --]]

    self.contentLayer:setRotation(self.angle or -3.14)
    self.touchLayer:setRotation(self.angle or -3.14)

    self:setupElements()
end

function ScrollFlow:setupElements()
    local elements = self.elements
    local imageWidth, imageHeight, imageScale = self.elementWidth, self.imageHeight, self.elementScale

    local animationPosition
    if type(elements) == "table" then
        for i, v in ipairs(elements) do
            local imageNode = v.avatar
            local animationNode = v.animation
            if not imageWidth or not imageHeight then
                local sz = imageNode:getTextureRect().size
                imageWidth, imageHeight = math.floor((sz.width or 100) * imageScale), math.floor((sz.height or 100) * imageScale)
            end
            if not self.centerPoint then
                local count = math.floor((self.contentWidth or GameConfig.WS.width) / imageWidth)
                count = count < #elements and count or #elements
                local contentWidth = math.floor(count % 2 == 0 and count - 1 or count) * imageWidth
                --data.contentWidth = math.floor((data.contentWidth or GameConfig.WS.width) / imageWidth) * imageWidth
                self.contentWidth = contentWidth > count * imageWidth and count * imageWidth or contentWidth
                local contentSize = ccs(self.contentWidth or GameConfig.WS.width, imageHeight or 100)
                self.contentLayer:setContentSize(contentSize)
                self.contentLayer:setPosition(ccp((GameConfig.WS.width - contentSize.width) / 2, 100))
                local stencil = TFLayer:create();
                stencil:setContentSize(contentSize)
                stencil:setBackGroundColorType(1)
                stencil:setBackGroundColorOpacity(90)
                self.contentLayer:setStencil(stencil);
                self.contentLayer:setInverted(false);
                self.touchLayer:setContentSize(contentSize)
                self.touchLayer:setPosition(ccp((GameConfig.WS.width - contentSize.width) / 2, 100))
                self.centerPoint = ccp(contentSize.width / 2, contentSize.height / 2)
                animationPosition = self.contentLayer:convertToWorldSpace(self.centerPoint)
                animationPosition.y = animationPosition.y/2
            end
            imageNode:setContentSize(ccs(imageWidth, imageHeight))
            imageNode:setPosition(ccp((i - 1) * imageWidth + imageWidth / 2, imageHeight / 2))
            self.contentLayer:addChild(imageNode)
            self.elementsCount = i
            self.animationLayer:addChild(animationNode)
            animationNode:setPosition(animationPosition)
            if isInRect(imageNode, self.centerPoint) then
                imageNode:setVisible(false)
                animationNode:setVisible(true)
            end
            imageNode:setTouchEnabled(true)
            imageNode:addMEListener(TFWIDGET_TOUCHENDED, function(sender)
                jumpWithImage(self, sender, true)
            end)
            self.elements[i] = { id = v.id, avatar = imageNode, animation = animationNode }
        end
    end

    self.elementWidth = imageWidth
    self.elementHeight = imageHeight
    self.animationPosition = animationPosition
end

function ScrollFlow:addScrollEvent(onScroll)
    if (type(onScroll) == "function" or type(onScroll) == "nil") then
        self.onScrollWithElement = onScroll
    end
end

function ScrollFlow:addClickEvent(onClick)
    if (type(onClick) == "function" or type(onClick) == "nil") then
        self.onClickWithElement = onClick
    end
end

function ScrollFlow:addElement(element)
    self.elements[#self.elements+1] = element
    self.contentLayer:addChild(element.avatar)
    element.avatar:setPosition(self.elementsCount * self.elementWidth + self.elementWidth / 2, self.elementHeight / 2)
    self.elementsCount = self.elementsCount + 1
    self.animationLayer:addChild(element.animation)
    element.animation:setPosition(self.animationPosition)
    element.animation:setVisible(false)
    if isInRect(element.avatar, self.centerPoint) then
        element.avatar:setVisible(false)
        element.animation:setVisible(true)
    end
    element.avatar:setTouchEnabled(true)
    element.avatar:addMEListener(TFWIDGET_TOUCHENDED, function(sender)
        jumpWithImage(self, sender, true)
    end)
end

function ScrollFlow:getElementById(id)
    for i, v in ipairs(self.elements) do
        if v.id == id then
            return v
        end
    end
    return nil
end

function ScrollFlow:getElementByIndex(index)
    return self.elements[index]
end

function ScrollFlow:setContentPosition(p)
    self.contentLayer:setPosition(p)
end

function ScrollFlow:setContentPositionX(x)
    self.contentLayer:setPositionX(x or 0)
end

function ScrollFlow:setContentPositionY(y)
    self.contentLayer:setPositionY(y or 0)
end

function ScrollFlow:setContentRotation(angle)
    self.contentLayer:setRotation(angle or 0)
end

function ScrollFlow:getElementsCount()
    return self.elementsCount
end

function ScrollFlow:jumpTo(index)
    local element = self.elements[index]
    if not element then
        return
    end
    local x = element.avatar:getPositionX()
    local offsetX = self.centerPoint.x - x
    scrollElement(self, offsetX, true)
end

return ScrollFlow