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

function onNodeScaleToCenter(self, scale, center)
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

function setMinScale(self, scale )
    -- body
    self.minScale = scale
end

rawset(ScrollAndZoomView, "setMinScale", setMinScale)

function setMaxScale(self, scale )
    -- body
    self.maxScale = scale
end

rawset(ScrollAndZoomView, "setMaxScale", setMaxScale)

function onNodeMoved(self, seek, cpos, lpos)
    local wseek = self:convertToNodeSpace(cpos) - self:convertToNodeSpace(lpos)
    self.node:Pos(self.node:Pos() + wseek)
    self:checkBoundBySeekPos(wseek)
end

rawset(ScrollAndZoomView, "onNodeMoved", onNodeMoved)

function checkBoundBySeekPos(self, wseek )
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

function setNodeScale(self, scale )
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

function focus(self, pos)
    -- body
    local focusPos = pos*self.node:getScale()
    local _changePos = ccp(self.size.width/2,self.size.height/2) - focusPos
    self.node:setPosition(_changePos)
    self:checkBoundBySeekPos()
end

rawset(ScrollAndZoomView, "focus", focus)

return ScrollAndZoomView