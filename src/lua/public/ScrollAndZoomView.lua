--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
* -- 可滑动和缩放的界面
]]


local ScrollAndZoomView = requireNew('TFFramework.luacomponents.common.TFMultiTouchPanel')
ScrollAndZoomView__cname = "ScrollAndZoomView"

local function onNodeScaleToCenter(self, scale, center)
    scale = clamp(scale, self.minScale, self.maxScale)
    local curScale = self.node:getScale()

    center = self:convertToNodeSpace(center)

    local _dealScale = scale 


    local curPos = self.node:getPosition() -- 当前坐标相对于当前缩放的坐标
    local lc = (center - curPos )/curScale  -- 计算当前参考点在node上的坐标
    
    local wseek = lc*(_dealScale - curScale)
    -- self:checkBoundBySeekPos(_dealScale,wseek)
    self.node:setScale(_dealScale)
    self.node:Pos(self.node:Pos() - wseek)
    self:checkBoundBySeekPos(wseek)
end

rawset(ScrollAndZoomView, "onNodeScaleToCenter", onNodeScaleToCenter)

local function setMinScale(self, scale )
    -- body
    self.minScale = scale
end

rawset(ScrollAndZoomView, "setMinScale", setMinScale)

local function setMaxScale(self, scale )
    -- body
    self.maxScale = scale
end

rawset(ScrollAndZoomView, "setMaxScale", setMaxScale)

local function onNodeMoved(self, seek, cpos, lpos)
    local wseek = self:convertToNodeSpace(cpos) - self:convertToNodeSpace(lpos)
    self.node:Pos(self.node:Pos() + wseek)
    self:checkBoundBySeekPos(wseek)
end

rawset(ScrollAndZoomView, "onNodeMoved", onNodeMoved)

local function checkBoundBySeekPos(self, wseek )
    -- body
    local showWidth = self.innerSize.width * self.node:getScale()
    local showHeight = self.innerSize.height * self.node:getScale()

    local limitX = self.size.width - showWidth
    local limitY = self.size.height - showHeight
    local curPos = self.node:getPosition()

    local dealX = math.min(0,curPos.x)
    dealX = math.max(limitX, dealX)

    local dealY = math.min(0,curPos.y)
    dealY = math.max(limitY, dealY)

    self.node:setPosition(ccp(dealX,dealY))
end
rawset(ScrollAndZoomView, "checkBoundBySeekPos", checkBoundBySeekPos)

local function setNodeScale(self, scale )
    -- body
    local _scale = math.max(self.minScale,scale)
    _scale = math.min(self.maxScale,scale)

    local curScale = self.node:getScale()

    local changePos = self:getPosition()/curScale*(_scale - curScale)*_scale/2
    self.node:setPosition(changePos + self:getPosition())
    self.node:setScale(_scale)
    self:checkBoundBySeekPos()
end

rawset(ScrollAndZoomView, "setNodeScale", setNodeScale)

local function focus(self, pos)
    -- body
    local focusPos = pos*self.node:getScale()
    local _changePos = ccp(self.size.width/2,self.size.height/2) - focusPos
    self.node:setPosition(_changePos)
    self:checkBoundBySeekPos()
end

rawset(ScrollAndZoomView, "focus", focus)

local function checkBoundByPosAndScale(self, pos, _scale )
    -- body
    local scale = _scale or self.node:getScale()

    local showWidth = self.innerSize.width * scale
    local showHeight = self.innerSize.height * scale

    local limitX = self.size.width - showWidth
    local limitY = self.size.height - showHeight
    local curPos = ccp(self.size.width/2,self.size.height/2) - pos*scale

    local dealX = math.min(0,curPos.x)
    dealX = math.max(limitX, dealX)

    local dealY = math.min(0,curPos.y)
    dealY = math.max(limitY, dealY)

    return ccp(self.size.width/2,self.size.height/2) - ccp(dealX,dealY)
end

local function focusAndScaleByTime( self, time, pos, scale)
    -- body
    if pos then
        self._moveToPos = checkBoundByPosAndScale(self,pos,scale)
    end

    if scale then
        self._actionScale = scale
    end
    self._actionTime = time
    self._curActionTime = 0

    if not time or time == 0 then
        if pos then
            self:focus(pos)
        end

        if scale then
            self:setNodeScale(scale)
        end
        return
    end

    if self.scaleActionTimer then
        TFDirector:stopTimer(self.scaleActionTimer)
        TFDirector:removeTimer(self.scaleActionTimer)
        self.scaleActionTimer = nil
    end

    if not self.lastTouchEnabled then
        self.lastTouchEnabled = self:isTouchEnabled()
    end

    self:setTouchEnabled(false)

    self._moveToPos = self._moveToPos or self.node:getPosition()
    self._actionScale = self._actionScale or self.node:getScale()
    local focusPos = ccp(self.size.width/2,self.size.height/2) - self._moveToPos

    self._offsetPos = (focusPos - self.node:getPosition())/time

    self._offsetScale = (self._actionScale - self.node:getScale())/time

    self.scaleActionTimer = TFDirector:addTimer(10,-1,nil,function ( dt )
        -- body
        self._actionTime = self._actionTime - dt
        local scale = self.node:getScale() + self._offsetScale*dt
        self.node:setScale(scale)

        local nodePostion = self.node:getPosition()
        nodePostion = nodePostion + self._offsetPos*dt
        self.node:setPosition(nodePostion)
        self:checkBoundBySeekPos()

        if self._actionTime <= 0 then
            self:setTouchEnabled(self.lastTouchEnabled)
            self.lastTouchEnabled = nil
            TFDirector:stopTimer(self.scaleActionTimer)
            TFDirector:removeTimer(self.scaleActionTimer)
            self.scaleActionTimer = nil
        end
    end)

end
rawset(ScrollAndZoomView, "focusAndScaleByTime", focusAndScaleByTime)

local function removeEvents( self )
    if self.scaleActionTimer then
        TFDirector:stopTimer(self.scaleActionTimer)
        TFDirector:removeTimer(self.scaleActionTimer)
        self.scaleActionTimer = nil
    end
end
rawset(ScrollAndZoomView, "removeEvents", removeEvents)

local function setTouchEnabled( self, state ) -- 设置点击和做滑动动作同时调用时 只有先设置点击禁用才有效
    self.touchNode:setTouchEnabled(state)
    self.touchNode:setSwallowTouch(false)
end
rawset(ScrollAndZoomView, "setTouchEnabled", setTouchEnabled)

local function isTouchEnabled( self )
    return self.touchNode:isTouchEnabled()
end
rawset(ScrollAndZoomView, "isTouchEnabled", isTouchEnabled)

return ScrollAndZoomView