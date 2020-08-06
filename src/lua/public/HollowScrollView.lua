local UNDO_MODULUS = 1 -- threeQuarters

local function rollBackAction(self, originalLocation)
    for i, v in ipairs(self.elements) do
        v.avatar:runAction(CCMoveTo:create(0.05, originalLocation[i]))
    end
end

local function jumpAction(self, index, isClick)
    local elementWidth = self.elementWidth
    local elementHalfWidth = elementWidth * .5
    local leftEndX = self.leftEndX
    local rightStartX = self.rightStartX
    local hollowRect = self.hollowRect
    local suitable = index
    local j = 0
    for i = suitable - 1, 1, -1 do
        local v = self.elements[i]
        v.avatar:setPositionX(leftEndX - elementWidth * j - elementHalfWidth)
        if v.animation then
            v.animation:setVisible(false)
        end
        v.avatar:setVisible(true)
        j = j + 1
    end

    j = 0
    for i = suitable + 1, #self.elements do
        local v = self.elements[i]
        v.avatar:setPositionX(rightStartX + elementWidth * j + elementHalfWidth)
        v.avatar:setVisible(true)
        if v.animation then
            v.animation:setVisible(false)
        end
        j = j + 1
    end
    local centerElement = self.elements[suitable]
    centerElement.avatar:setPositionX(hollowRect.origin.x)
    if centerElement.animation then
        centerElement.animation:setVisible(true)
    end
    centerElement.avatar:setVisible(false)
    if isClick then
        if type(self.onClickWithElement) == "function" then
            self.onClickWithElement(index, centerElement.id)
        end
    else
        if type(self.onScrollWithElement) == "function" then
            self.onScrollWithElement(index, centerElement.id)
        end
    end
end

local function moveAction(self, offsetX, isClick)
    local elementWidth = self.elementWidth
    local hollowRect = self.hollowRect
    local suitable = 0
    local nearest = #self.elements * elementWidth
    for i, v in ipairs(self.elements) do
        local currentX = v.avatar:getPositionX()
        local dest = math.abs(currentX - hollowRect.origin.x)
        if dest < nearest then
            nearest = dest
            suitable = i
        end
    end

    if suitable ~= 0 then
        jumpAction(self, suitable, isClick)
    else
        print("error")
    end
end

local function scrollAction(self, offsetX, isClick)
    local isMove = math.abs(offsetX) > self.elementWidth * UNDO_MODULUS
    if isMove then
        moveAction(self, offsetX, isClick or false)
    else
        local elementWidth = self.elementWidth
        local x
        if offsetX < 0 then
            local firstX
            for i, v in ipairs(self.elements) do
                x = v.avatar:getPositionX()
                if i == 1 then
                    firstX = x + offsetX
                    x = firstX
                else
                    x = firstX + (i - 1) * elementWidth
                end
                v.avatar:setPositionX(x)
            end
        end
        if offsetX > 0 then
            local lastX
            local j = 0
            for i = #self.elements, 1, -1 do
                local v = self.elements[i]
                x = v.avatar:getPositionX()
                if i == #self.elements then
                    lastX = x + offsetX
                    x = lastX
                else
                    x = lastX - j * elementWidth
                end
                j = j + 1
                v.avatar:setPositionX(x)
            end
        end
    end
end


local function jumpWithElement(self, sender)
    local index
    for i, v in ipairs(self.elements) do
        if v.avatar == sender then
            index = i
            break
        end
    end
    if index then
        jumpAction(self, index, true)
    end
end

local function needRollback(self, offsetX, originalLocation)
    if (math.abs(offsetX) < self.elementWidth * UNDO_MODULUS) or #self.elements <= 1 then
        return true
    end
    local firstPosition = originalLocation[1]
    local lastPosition = originalLocation[#originalLocation]
    if offsetX < 0 then
        if lastPosition.x < self.rightStartX then
            return true
        end
    end
    if offsetX > 0 then
        if firstPosition.x > self.leftEndX then
            return true
        end
        --if lastPosition.x < self.rightStartX then
        --    return true
        --end
    end
    return false
end

local HollowScrollView = class("HollowScrollView", function()
    return TFLayer:create()
end)

--[[
{
    angle = default value is -3.14
    onScroll = function(index, id), default value is nil
    onClick  = function(index, id), default value is nil
    contentWidth = default value is 1136
    contentHeight = default value is 128
    elementScale = default value is 1
    hollowSize = default value is ccs(300, contentHeight)
}
--]]

function HollowScrollView:ctor(data)
    data  =  data or {}
    self.elements = {}
    self.angle = data.angle or -3.14
    self.onScrollWithElement = data.onScrollWithElement
    self.onClickWithElement = data.onClickWithElement
    self.onClickWithAnimation = data.onClickWithAnimation
    self.contentWidth = data.contentWidth or 1136
    self.contentHeight = data.contentHeight or 128
    self.elementScale = data.elementScale or 1
    local hollowSize =  data.hollowSize or ccs(500, self.contentHeight)
    self.hollowRect = ccr(self.contentWidth / 2, self.contentHeight / 2, hollowSize.width, hollowSize.height)
    self.rightStartX = self.hollowRect.origin.x + self.hollowRect.size.width / 2
    self.leftEndX = self.hollowRect.origin.x - self.hollowRect.size.width / 2
    self.animationPosition = ccp(0, 0)
    self.elementWidth = data.elementWidth -- or nil
    self.elementHeight = data.elementHeight -- or nil

    self:init()
end

function HollowScrollView:init()
    local outset, beganPosition
    local isMoving = false
    local originalLocation = {}
    local onTouchBegan = function(sender)
        outset = sender:getTouchStartPos()
        beganPosition = outset
        for i, v in ipairs(self.elements) do
            originalLocation[i] = v.avatar:getPosition()
        end
        self.touchLayer:setSwallowTouch(isMoving)
    end

    local onTouchMoved = function(sender)
        local currentPosition = sender:getTouchMovePos()
        local offsetX = currentPosition.x - beganPosition.x
        if math.abs(offsetX) > self.elementWidth * 0.5 then
            isMoving = true
            self.touchLayer:setSwallowTouch(true)
            scrollAction(self, offsetX)
            beganPosition = currentPosition
        end
    end

    local onTouchEnded = function(sender)
        local dest = sender:getTouchEndPos()
        if isMoving then
            local offsetX = dest.x - outset.x
            if needRollback(self, offsetX, originalLocation) then
                rollBackAction(self, originalLocation)
            else
                moveAction(self, offsetX, false)
            end
            isMoving = false
        else
            self.touchLayer:setSwallowTouch(false)
        end
    end

    --local contentSize =  ccs(self.contentWidth, self.elementHeight)
    self.touchLayer = TFLayer:create()
    self.touchLayer:setTouchEnabled(true)
    self.touchLayer:addMEListener(TFWIDGET_TOUCHBEGAN, onTouchBegan)
    self.touchLayer:addMEListener(TFWIDGET_TOUCHMOVED, onTouchMoved)
    self.touchLayer:addMEListener(TFWIDGET_TOUCHENDED, onTouchEnded)
    self.touchLayer:setSwallowTouch(false)
    self:addChild(self.touchLayer, 1)

    self.contentLayer = TFClippingNode:create()
    self:addChild(self.contentLayer)

    self.animationLayer = TFPanel:create()
    self.animationLayer:setContentSize(GameConfig.WS)
    self.animationLayer:setClippingEnabled(false)
    self.animationLayer:setBackGroundColorType(1)
    self.animationLayer:setBackGroundColor(ccc3(0, 0, 128))
    self.animationLayer:setBackGroundColorOpacity(60)
    self:addChild(self.animationLayer)

    --[[ for debug
    self.hollowLayer = TFPanel:create()
    self.hollowLayer:setContentSize(self.hollowRect.size)
    self.hollowLayer:setClippingEnabled(false)
    self.hollowLayer:setBackGroundColorType(1)
    self.hollowLayer:setBackGroundColor(ccc3(255, 0, 0))
    self.hollowLayer:setBackGroundColorOpacity(60)
    self.contentLayer:addChild(self.hollowLayer, 1)
    --]]

    self.contentLayer:setRotation(self.angle)
    self.touchLayer:setRotation(self.angle)
end

function HollowScrollView:addElement(element)
    self.elements[#self.elements + 1] = element
    self.contentLayer:addChild(element.avatar)
    self.animationLayer:addChild(element.animation)
    local count = #self.elements
    if not self.elementWidth or not self.elementHeight then
        local sz = element.avatar:getTextureRect().size
        self.elementWidth, self.elementHeight = math.floor((sz.width or 100) * self.elementScale), math.floor((sz.height or 100) * self.elementScale)
        local contentSize = ccs(self.contentWidth, self.elementHeight)
        self.touchLayer:setContentSize(contentSize)
        self.touchLayer:setPosition(ccp((GameConfig.WS.width - contentSize.width) / 2, 100))
        self.contentLayer:setPosition(ccp((GameConfig.WS.width - contentSize.width) / 2, 100))
        --[[ for debug
        self.hollowLayer:setPosition(ccp((contentSize.width - self.hollowRect.size.width) / 2, 0))
        print(self.hollowLayer:getHitRect())
        ]]
        print(self.hollowRect)

        local stencil = TFLayer:create();
        stencil:setContentSize(contentSize)
        stencil:setBackGroundColorType(1)
        stencil:setBackGroundColor(ccc3(255, 0, 0))
        stencil:setBackGroundColorOpacity(90)
        self.contentLayer:setStencil(stencil)
        self.contentLayer:setInverted(false)
        self.contentLayer:setContentSize(contentSize)
        print(ccp(contentSize.width / 2, contentSize.height / 2))
        self.animationPosition = self.contentLayer:convertToWorldSpace(self.hollowRect.origin)
        self.animationPosition.y = self.animationPosition.y/2
    end
    if 1 == count then
        element.avatar:setPosition(ccp(self.hollowRect.origin.x, self.elementHeight / 2))
        element.avatar:setVisible(false)
    else
        element.avatar:setPosition(ccp((count-2) * self.elementWidth + self.elementWidth * 0.5 + self.rightStartX, self.elementHeight / 2))
        element.avatar:setVisible(true)
    end
    if element.animation then
        element.animation:setPosition(self.animationPosition)
        element.animation:setVisible( 1 == count )
        element.animation:setTouchEnabled(true)
        element.animation:addMEListener(TFWIDGET_TOUCHENDED, function(sender)
            if type(self.onClickWithAnimation) == "function" then
                self.onClickWithAnimation(count, element.id)
            end
        end)
    end
    element.avatar:setContentSize(ccs(self.elementWidth, self.elementHeight))
    element.avatar:setTouchEnabled(true)
    element.avatar:addMEListener(TFWIDGET_TOUCHENDED, function(sender)
        jumpWithElement(self, sender)
    end)
end

function HollowScrollView:addAnimation(animation, index, showed)
    local element = self.elements[index]
    if element and animation then
        self.animationLayer:addChild(animation)
        animation:setPosition(self.animationPosition)
        animation:setVisible( showed )
        animation:setTouchEnabled(true)
        animation:addMEListener(TFWIDGET_TOUCHENDED, function(sender)
            if type(self.onClickWithAnimation) == "function" then
                self.onClickWithAnimation(index, element.id)
            end
        end)
        element.animation = animation
    end
end

function HollowScrollView:existAnimation(index)
    local element =  self.elements[index]
    if element then
        return element.animation and true or false
    end
    return false
end

function HollowScrollView:addScrollEvent(onScroll)
    if (type(onScroll) == "function" or type(onScroll) == "nil") then
        self.onScrollWithElement = onScroll
    end
end

function HollowScrollView:addClickElement(onClick)
    if (type(onClick) == "function" or type(onClick) == "nil") then
        self.onClickWithElement = onClick
    end
end

function HollowScrollView:addClickAnimation(onClick)
    if (type(onClick) == "function" or type(onClick) == "nil") then
        self.onClickWithAnimation = onClick
    end
end


function HollowScrollView:jumpTo(index)
    local element = self.elements[index]
    if not element then
        return
    end
    jumpAction(self, index, true)
end

return HollowScrollView