
local UIScrollBar = class("UIScrollBar")

function UIScrollBar:ctor(scrollBar, scrollBarInner)
    self.scrollBar_ = scrollBar
    self.scrollBarInner_ = scrollBarInner

    self.scrollBarContentSize_ = scrollBar:getContentSize()
    self.scrollBarInnerContentSize_ = scrollBarInner:getContentSize()
    self.scrollBarAp_ = scrollBar:getAnchorPoint()
    self.scrollBarInnerAp_ = scrollBarInner:getAnchorPoint()

    self.ratio_ = ratio
end

function UIScrollBar:bindScrollView(scrollView)
    self.scrollView_ = scrollView
end

function UIScrollBar:jumpToBottom()

end

function UIScrollBar:jumpToTop()

end

function UIScrollBar:setPercent(percent)
    if not self.realHeight_ then return end

    local rPercent = 1.0 - percent
    local y = self.realHeight_ * percent
    y = y + self.scrollBarInnerContentSize_.height * self.scrollBarInnerAp_.y - self.scrollBarContentSize_.height * self.scrollBarAp_.y

    self.scrollBarInner_:setPositionY(y)
end

function UIScrollBar:setRatio(ratio)
    if self.ratio_ == ratio then return end
    self.ratio_ = ratio

    local width = self.scrollBarContentSize_.width
    local height = self.scrollBarContentSize_.height * ratio
    local size = CCSize(width, height)
    self.scrollBarInnerContentSize_ = size
    self.scrollBarInner_:setContentSize(size)

    self.realHeight_ = self.scrollBarContentSize_.height - self.scrollBarInnerContentSize_.height
end

function UIScrollBar:setVisible(visible)
    self.scrollBar_:setVisible(visible)
end

return UIScrollBar
