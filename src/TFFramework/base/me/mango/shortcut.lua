--
-- Author: MiYu
-- Date: 2014-02-20 14:40:50
--

----------------------------------------
-- TFUIBase
----------------------------------------
TFUIBase = TFUIBase or {}
local TFUIBase = TFUIBase

--[[
    base shortcut
]]
-- behaviour

local _nodeTmp = CCNode:create()
local _retain = _nodeTmp.retain
local _release = _nodeTmp.release
function TFUIBase:retain()
    TFDirector:addRetainObj(self, true)
    return _retain(self)
end
rawset(CCNode, "retain", TFUIBase.retain)

function TFUIBase:release()
    TFDirector:removeRetainObj(self, true)
    if tolua.isnull(self) then return self end
    return _release(self)
end
rawset(CCNode, "release", TFUIBase.release)

function TFUIBase:Add(...)
    self:addChild(...)
    return self
end
rawset(CCNode, "Add", TFUIBase.Add)

function TFUIBase:Text(text)
    if not text then return self:getText() end
    if self.setText then
        self:setText(text)
    end
    return self
end
rawset(CCNode, "Text", TFUIBase.Text)

function TFUIBase:FontColor(color)
    if not color then return self:getFontColor() end
    if self.setFontColor then
        self:setFontColor(color)
    end
    return self
end
rawset(CCNode, "FontColor", TFUIBase.FontColor)

function TFUIBase:Stroke(...)
    self:enableStroke(...)
    return self
end
rawset(CCNode, "Stroke", TFUIBase.Stroke)

function TFUIBase:Name(name)
    if not name then return self:getName() end
    self:setName(name)
    return self
end
rawset(CCNode, "Name", TFUIBase.Name)

function TFUIBase:RemoveSelf(cleanup)
    if not tolua.isnull(self) then
        if cleanup ~= false then cleanup = true end
        self:removeFromParentAndCleanup(cleanup)
    end
end
rawset(CCNode, "RemoveSelf", TFUIBase.RemoveSelf)

function TFUIBase:AddTo(target, zorder, tag)
    target:addChild(self, zorder or 0, tag or 0)
    return self
end
rawset(CCNode, "AddTo", TFUIBase.AddTo)

function TFUIBase:Show()
    self:setVisible(true)
    return self
end
rawset(CCNode, "Show", TFUIBase.Show)
rawset(CCNode, "show", TFUIBase.Show)

function TFUIBase:Hide()
    self:setVisible(false)
    return self
end
rawset(CCNode, "Hide", TFUIBase.Hide)
rawset(CCNode, "hide", TFUIBase.Hide)

function TFUIBase:Alpha(val)
    if not val then return self:getOpacity() end
    self:setOpacity(val * 255)
    return self
end
rawset(CCNode, "Alpha", TFUIBase.Alpha)

function TFUIBase:ZO(order)
    if not order then return self:getZOrder() end
    self:setZOrder(order)
    return self
end
rawset(CCNode, "ZO", TFUIBase.ZO)

function TFUIBase:Tag(tag)
    if not tag then return self:getTag() end
    self:setTag(tag)
    return self
end
rawset(CCNode, "Tag", TFUIBase.Tag)

function TFUIBase:Rotate(rot)
    if not rot then return self:getRotation() end
    self:setRotation(rot)
    return self
end
rawset(CCNode, "Rotate", TFUIBase.Rotate)

function TFUIBase:Scale(val)
    if not val then return self:getScale() end
    self:setScale(val)
    return self
end
rawset(CCNode, "Scale", TFUIBase.Scale)

function TFUIBase:ScaleX(val)
    if not val then return self:getScaleX() end
    self:setScaleX(val)
    return self
end
rawset(CCNode, "ScaleX", TFUIBase.ScaleX)

function TFUIBase:ScaleY(val)
    if not val then return self:getScaleY() end
    self:setScaleY(val)
    return self
end
rawset(CCNode, "ScaleY", TFUIBase.ScaleY)

function TFUIBase:Center()
    self:setPosition(ccp(me.cx, me.cy))
    return self
end
rawset(CCNode, "Center", TFUIBase.Center)

if CCNode.setPositionEx then 
	local __CCNode_setPosition = CCNode.setPositionEx
	local function __setPosition(self, x, y)
	    if not y then 
	        __CCNode_setPosition(self, x.x, x.y)
	    else 
	        __CCNode_setPosition(self, x, y)
	    end
	    return self
	end
	rawset(CCNode, "setPosition", __setPosition)
else 
    local __CCNode_setPosition = CCNode.setPosition
    local function __setPosition(self, x, y)
        if not y then 
            __CCNode_setPosition(self, x)
        else 
            __CCNode_setPosition(self, ccp(x, y))
        end
        return self
    end
    rawset(CCNode, "setPosition", __setPosition)
end

function TFUIBase:Pos(x, y)
    if not x then return self:getPosition() end
    if not y then 
        self:setPosition(x.x, x.y)
    else 
        self:setPosition(x, y)
    end
    return self
end
rawset(CCNode, "Pos", TFUIBase.Pos)

function TFUIBase:PosX(x)
    if not x then return self:getPositionX() end
    self:setPositionX(x)
    return self
end
rawset(CCNode, "PosX", TFUIBase.PosX)

function TFUIBase:PosY(y)
    if not y then return self:getPositionY() end
    self:setPositionY(y)
    return self
end
rawset(CCNode, "PosY", TFUIBase.PosY)

function TFUIBase:AnchorPoint(x, y)
    if not x then return self:getAnchorPoint() end
    if not y then 
        self:setAnchorPoint(x)
    else 
        self:setAnchorPoint(ccp(x, y))
    end
    return self
end
rawset(CCNode, "AnchorPoint", TFUIBase.AnchorPoint)

function TFUIBase:Size(x, y)
    if not x then return self:getSize() end

    if not y then 
        self:setSize(x)
    else 
        self:setSize(ccs(x, y))
    end
    return self
end
rawset(CCNode, "Size", TFUIBase.Size)

function TFUIBase:Width(width)
    if not width then return self:getSize().width end
    local size = self:getSize()
    size.width = width
    self:setSize(size)
    return self
end
rawset(CCNode, "Width", TFUIBase.Width)

function TFUIBase:Height(height)
    if not height then return self:getSize().height end
    local size = self:getSize()
    size.height = height
    self:setSize(size)
    return self
end
rawset(CCNode, "Height", TFUIBase.Height)

function TFUIBase:Color(color)
    if not color then return self:getColor() end

    self:setColor(color)
    return self
end
rawset(CCNode, "Color", TFUIBase.Color)

function TFUIBase:Tween(tween)
    tween.target = self
    TFDirector:toTween(tween)
    return self
end
rawset(CCNode, "Tween", TFUIBase.Tween)

function TFUIBase:Touchable(able)
    self:setTouchEnabled(able)
    return self
end
rawset(CCNode, "Touchable", TFUIBase.Touchable)

function TFUIBase:Click(callback)
    if callback then 
        self:setTouchEnabled(true)
        self:addMEListener(TFWIDGET_CLICK, callback)
    else 
        self:removeMEListener(TFWIDGET_CLICK)
    end
    return self
end
rawset(CCNode, "Click", TFUIBase.Click)
rawset(CCNode, "OnClick", TFUIBase.Click)

function TFUIBase:OnBegan(callback)
    if callback then 
        self:setTouchEnabled(true)
        self:addMEListener(TFWIDGET_TOUCHBEGAN, callback)
    else 
        self:removeMEListener(TFWIDGET_TOUCHBEGAN)
    end
    return self
end
rawset(CCNode, "OnBegan", TFUIBase.OnBegan)

function TFUIBase:OnMoved(callback)
    if callback then 
        self:setTouchEnabled(true)
        self:addMEListener(TFWIDGET_TOUCHMOVED, callback)
    else 
        self:removeMEListener(TFWIDGET_TOUCHMOVED)
    end
    return self
end
rawset(CCNode, "OnMoved", TFUIBase.OnMoved)

function TFUIBase:OnEnded(callback)
    if callback then 
        self:setTouchEnabled(true)
        self:addMEListener(TFWIDGET_TOUCHENDED, callback)
        self:addMEListener(TFWIDGET_TOUCHCANCELLED, callback)
    else 
        self:removeMEListener(TFWIDGET_TOUCHENDED)
        self:removeMEListener(TFWIDGET_TOUCHCANCELLED)
    end
    return self
end
rawset(CCNode, "OnEnded", TFUIBase.OnEnded)

function TFUIBase:DButton(func, ...)
    local params = {...}
    self:setDoubleClickEnabled(true)
    self:addMEListener(TFWIDGET_DOUBLECLICK, function(sender)
        if func then 
            func(sender, unpack(params))
        end
    end)
    return self
end
rawset(CCNode, "DButton", TFUIBase.DButton)

function TFUIBase:OnExit(callback)
    if callback then 
        self:addMEListener(TFWIDGET_EXIT, callback)
    else 
        self:removeMEListener(TFWIDGET_EXIT)
    end
    return self
end
rawset(CCNode, "OnExit", TFUIBase.OnExit)

function TFUIBase:OnEnter(callback)
    if callback then 
        self:addMEListener(TFWIDGET_ENTER, callback)
    else 
        self:removeMEListener(TFWIDGET_ENTER)
    end
    return self
end
rawset(CCNode, "OnEnter", TFUIBase.OnEnter)

function TFUIBase:OnFrame(callback)
    if callback then 
        self:addMEListener(TFWIDGET_ENTERFRAME, callback)
    else 
        self:removeMEListener(TFWIDGET_ENTERFRAME)
    end
    return self
end
rawset(CCNode, "OnFrame", TFUIBase.OnFrame)
-- actions

function TFUIBase:timeOut(callback, delay, ...)
    local tParam = {...}
    delay = delay or 0
    action = Sequence:createWithTwoActions(DelayTime:create(delay), CallFunc:create(function() callback(self, unpack(tParam)) end))
    return self:runAction(action)
end
rawset(CCNode, "timeOut", TFUIBase.timeOut)

-- this action only one valid
function TFUIBase:timeOutU(callback, delay, id, ...)
    local tParam = {...}
    delay = delay or 0
    self.__timeOutU_Act = self.__timeOutU_Act or {}

    if id then 
        local act = self.__timeOutU_Act[id]
        if not tolua.isnull(act) then 
            self:stopAction(act)
        end
        self.__timeOutU_Act[id] = nil
    end

    action = Sequence:createWithTwoActions(DelayTime:create(delay), CallFunc:create(function() callback(self, unpack(tParam)) end))

    if id then 
        self.__timeOutU_Act[id] = action
    end

    return self:runAction(action)
end
rawset(CCNode, "timeOutU", TFUIBase.timeOutU)

function TFUIBase:fadeIn(time)
    self:runAction(FadeIn:create(time))
    return self
end
rawset(CCNode, "fadeIn", TFUIBase.fadeIn)

function TFUIBase:fadeOut(time)
    self:runAction(FadeOut:create(time))
    return self
end
rawset(CCNode, "fadeOut", TFUIBase.fadeOut)

function TFUIBase:fadeTo(time, opacity)
    self:runAction(FadeTo:create(time, opacity))
    return self
end
rawset(CCNode, "fadeTo", TFUIBase.fadeTo)

function TFUIBase:moveTo(time, x, y)
    self:runAction(MoveTo:create(time, ccp(x or self:getPositionX(), y or self:getPositionY())))
    return self
end
rawset(CCNode, "moveTo", TFUIBase.moveTo)

function TFUIBase:moveBy(time, x, y)
    self:runAction(MoveBy:create(time, ccp(x or 0, y or 0)))
    return self
end
rawset(CCNode, "moveBy", TFUIBase.moveBy)

function TFUIBase:rotateTo(time, rotation)
    self:runAction(RotateTo:create(time, rotation))
    return self
end
rawset(CCNode, "rotateTo", TFUIBase.rotateTo)

function TFUIBase:rotateXTo(time, rotation)
    self:runAction(RotateTo:create(time, rotation, 0))
    return self
end
rawset(CCNode, "rotateXTo", TFUIBase.rotateXTo)

function TFUIBase:rotateYTo(time, rotation)
    self:runAction(RotateTo:create(time, 0, rotation))
    return self
end
rawset(CCNode, "rotateYTo", TFUIBase.rotateYTo)

function TFUIBase:rotateBy(time, rotation)
    self:runAction(RotateBy:create(time, rotation))
    return self
end
rawset(CCNode, "rotateBy", TFUIBase.rotateBy)

function TFUIBase:rotateXBy(time, rotation)
    self:runAction(RotateBy:create(time, rotation, 0))
    return self
end
rawset(CCNode, "rotateXBy", TFUIBase.rotateXBy)

function TFUIBase:rotateYBy(time, rotation)
    self:runAction(RotateBy:create(time, 0, rotation))
    return self
end
rawset(CCNode, "rotateYBy", TFUIBase.rotateYBy)

function TFUIBase:scaleTo(time, scale)
    self:runAction(ScaleTo:create(time, scale))
    return self
end
rawset(CCNode, "scaleTo", TFUIBase.scaleTo)

function TFUIBase:scaleBy(time, scale)
    self:runAction(ScaleBy:create(time, scale))
    return self
end
rawset(CCNode, "scaleBy", TFUIBase.scaleBy)

function TFUIBase:skewTo(time, sx, sy)
    self:runAction(SkewTo:create(time, sx or self:getSkewX(), sy or self:getSkewY()))
end
rawset(CCNode, "skewTo", TFUIBase.skewTo)

function TFUIBase:skewBy(time, sx, sy)
    self:runAction(SkewBy:create(time, sx or 0, sy or 0))
end
rawset(CCNode, "skewBy", TFUIBase.skewBy)

function TFUIBase:tintTo(time, r, g, b)
    self:runAction(TintTo:create(time, r or 0, g or 0, b or 0))
    return self
end
rawset(CCNode, "tintTo", TFUIBase.tintTo)

function TFUIBase:tintBy(time, r, g, b)
    self:runAction(TintBy:create(time, r or 0, g or 0, b or 0))
    return self
end
rawset(CCNode, "tintBy", TFUIBase.tintBy)

--[[
3*t*(powf(1-t,2))*b + 
            3*powf(t,2)*(1-t)*c +
            powf(t,3)*d );
]]
function TFUIBase:bezierBy(time, p0, p1, p2, callback)
    local __node = nil 
    local elapse = 0       
    local curPos = self:Pos()
    __node = CCNode:create():OnFrame(function(sender, dt)
        elapse = elapse + dt
        local t = elapse / time
        if t > 1 then t = 1 end

        local pos = p0*(3*t*(1-t)^2) + p1*(3*t^2*(1-t)) + p2*t^3

        self:Pos(pos + curPos)

        if t == 1 then 
            __node:removeFromParent()
            if callback then callback() end
        end
    end):AddTo(self)

    return __node
end
