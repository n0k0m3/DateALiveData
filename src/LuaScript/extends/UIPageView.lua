
local UIPageView = class("UIPageView")

UIPageView.EVENT = {
    TURNING = "TURNING",
    CONTAINER_MOVED = "CONTAINER_MOVED",
}

function UIPageView:ctor(scrollView, showNum)
    showNum = showNum or 3
    self.scrollView_ = scrollView
    self.contentSize_ = scrollView:getContentSize()
    self.innerContainer_ = scrollView:getInnerContainer()
    self.innerContentSize_ = self.contentSize_
    self.anchorPoint_ = scrollView:getAnchorPoint()
    self:setItemShowNum(showNum)

    self.items_ = {}
    self.mainIndex_ = 1
    self.doLayoutDirty_ = false
    self.moveTime_ = 0.2

    local eventNode = CCNode:create()
    eventNode:AddTo(self.scrollView_:getParent())
    eventNode:addMEListener(TFWIDGET_ENTERFRAME, handler(self.updateEvent, self))
    eventNode:addMEListener(TFWIDGET_EXIT, handler(self.onExit, self))

    self.scrollView_:addMEListener(TFWIDGET_COMPLETED, handler(self.onCompletedEvent, self))
    self.scrollView_:addMEListener(TFSCROLLVIEW_CHANGED, handler(self.onChangedEvent, self))
    self.scrollView_:addMEListener(TFWIDGET_CHECK_CHILDINFO, handler(self.onTouchEndEvent, self))
end

function UIPageView:setMainIndex(index)
    self.mainIndex_ = index
end

function UIPageView:onCompletedEvent()
    local event = {}
    event.target = self
    event.name = UIPageView.EVENT.TURNING
    if self.eventListner_ then
        self.eventListner_(event)
    end
end

function UIPageView:onChangedEvent()
    local event = {}
    event.target = self
    event.name = UIPageView.EVENT.CONTAINER_MOVED
    if self.eventListner_ then
        self.eventListner_(event)
    end
end

function UIPageView:onTouchEndEvent(target, state)
    if state == 2 or state == 3 then
        local position = self.scrollView_:getContentOffset()
        local x = math.abs(position.x)
        local dis = math.abs(position.x + self.contentSize_.width * self.anchorPoint_.x)
        local index = math.floor(dis / self.itemSize_.width + 0.5)
        index = index + 1
        self:scrollToIndex(index)
    end
end

function UIPageView:updateEvent(delta)
    self:doLayout()
end

function UIPageView:doLayout()
    if not self.doLayoutDirty_ then return end

    self:updateInnerContainerSize()
    self:updateAllItemPosition()

    self.doLayoutDirty_ = false

    if self.scrollIndex_ then
        self:scrollToIndex(self.scrollIndex_)
        self.scrollIndex_ = nil
    end

    if self.jumpIndex_ then
        self:jumpToIndex(self.jumpIndex_)
        self.jumpIndex_ = nil
    end
end

function UIPageView:updateInnerContainerSize()
    -- itemSize
    local size = clone(self.contentSize_)
    local width = self.itemSize_.width * #self.items_

    -- fill space
    width = width + self.itemSize_.width * (self.showNum_ - 1)

    if width > size.width then
        size.width = width
    end
    self.scrollView_:setInnerContainerSize(size)
    self.innerContentSize_ = size
end

function UIPageView:updateAllItemPosition()
    local totalWidth = 0
    for i,v in ipairs(self.items_) do
        local realSize = v:getContentSize()
        local anchorPoint = v:getAnchorPoint()

        local x = totalWidth + self.itemSize_.width * 0.5 + self.itemSize_.width * (self.mainIndex_ - 1)
        local y = self.contentSize_.height * 0.5
        totalWidth = totalWidth + self.itemSize_.width
        v:setPosition(ccp(x, y))
    end
end

function UIPageView:setItemShowNum(showNum)
    self.showNum_ = showNum
    local itemWidth = self.contentSize_.width / self.showNum_
    local itemHeight = self.contentSize_.height
    self.itemSize_ = ccs(itemWidth, itemHeight)
end

function UIPageView:addItem(item)
    -- item:setSwallowTouches(false)
    self.scrollView_:addChild(item)
    table.insert(self.items_, item)
    self.doLayoutDirty_ = true
end

function UIPageView:getCurrentItemIndex()
    local position = self.scrollView_:getContentOffset()
    local x = math.abs(position.x)
    local dis = math.abs(position.x + self.contentSize_.width * self.anchorPoint_.x)
    local index = math.floor(dis / self.itemSize_.width + 0.5)
    index = index + 1
    return index
end

function UIPageView:scrollToIndex(index)
    if index < 1 or index > #self.items_ then return end

    if self.doLayoutDirty_ then
        self.scrollIndex_ = index
        return
    end

    local offsetIndex = index - 1
    if offsetIndex == 0 then
        self.scrollView_:scrollToLeft(self.moveTime_, true)
    else
        local w =  self.innerContentSize_.width - self.contentSize_.width
        local dis = offsetIndex * self.itemSize_.width
        local percent = -dis / w * 100
        self.scrollView_:scrollTo(TF_SCROLLVIEW_SCROLL_TO_PERCENT_HORIZONTAL, self.moveTime_, false, percent, 0)
    end
end

function UIPageView:jumpToIndex(index)
    if index < 1 or index > #self.items_ then return end

    if self.doLayoutDirty_ then
        self.jumpIndex_ = index
        return
    end

    local offsetIndex = index - 1
    if offsetIndex == 0 then
        self.scrollView_:scrollToLeft(self.moveTime_, true)
    else
        local w =  self.innerContentSize_.width - self.contentSize_.width
        local dis = offsetIndex * self.itemSize_.width
        local percent = -dis / w * 100
        self.scrollView_:jumpTo(TF_SCROLLVIEW_SCROLL_TO_PERCENT_HORIZONTAL, percent, 0)
    end
end

function UIPageView:addEventListener(listener)
    self.eventListner_ = listener
end

function UIPageView:getItems()
    return self.items_
end

function UIPageView:getItem(index)
    return self.items_[index]
end

function UIPageView:getItemSize()
    return self.itemSize_
end

function UIPageView:getMainPosition()
    local x = self.itemSize_.width * (self.mainIndex_ - 0.5)
    local y = self.itemSize_.height * 0.5
    return ccp(x, y)
end

function UIPageView:getItemCenterPosition(index)
    local item = self.items_[index]
    local wp = item:getWorldPosition()
    local np = self.scrollView_:convertToNodeSpace(wp)
    local itemSize = item:getContentSize()
    local anchorPoint = item:getAnchorPoint()
    local x = np.x + self.itemSize_.width * (0.5 - anchorPoint.x)
    local y = np.y + self.itemSize_.height * (0.5 - anchorPoint.y)
    return ccp(x, y)
end

function UIPageView:getWidget()
    return self.scrollView_
end

return UIPageView
