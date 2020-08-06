
local UIListView = class("UIListView")

UIListView.Gravity = {
    LEFT = 0,
    RIGHT = 1,
    CENTER_HORIZONTAL = 2,
    TOP = 3,
    BOTTOM = 4,
    CENTER_VERTICAL = 5,
}

function UIListView:initDefault()
    self.doLayoutDirty_ = false
    self.itemsMargin_ = 0
    self.model_ = nil
    self.items_ = {}

    self.ap_ = self.scrollView_:getAnchorPoint()
    self.contentSize_ = self.scrollView_:getContentSize()
    self.innerContentSize_ = clone(self.contentSize_)
    self.direction_ = self.scrollView_:getDirection()
    self.gravity_ = self.direction_ == SCROLLVIEW_DIR_VERTICAL and UIListView.Gravity.CENTER_VERTICAL or UIListView.Gravity.CENTER_HORIZONTAL
    self:setDirection(self.direction_)
    self.scrollViewAp_ = self.scrollView_:getAnchorPoint()
end

function UIListView:ctor(scrollView)
    self.scrollView_ = scrollView

    -- 刷新事件
    local eventNode = CCNode:create()
    eventNode:AddTo(self.scrollView_:getParent())
    eventNode:addMEListener(TFWIDGET_ENTERFRAME, handler(self.update, self))
    eventNode:addMEListener(TFWIDGET_EXIT, handler(self.onExit, self))
    self.scrollView_:addMEListener(TFSCROLLVIEW_SCROLLING, handler(self.onScrollingEvent, self))

    self:initDefault()
end

function UIListView:onScrollingEvent()
    if self.scrollBar_ then
        local position = self.scrollView_:getContentOffset()
        local offsetY = self.contentSize_.height * self.scrollViewAp_.y
        local y = math.min(position.y + offsetY, 0)
        local ty = self.innerContentSize_.height - self.contentSize_.height
        local percent = me.clampf(math.abs(y) / ty, 0, 1)
        self.scrollBar_:setPercent(percent)
    end
end

function UIListView:setItemModel(model)
    if self.model_ and self.model_ ~= model then
        self.model_:release()
    end
    model:retain()
    self.model_ = model
end

function UIListView:insertCustomItem(item, index)
    item:setPositionType(0)
    table.insert(self.items_, index, item)
    self.scrollView_:addChild(item)

    self:updateInnerContainerSize()
    self.doLayoutDirty_ = true

end

function UIListView:pushBackCustomItem(item)
    self:insertCustomItem(item, #self.items_ + 1)
end

function UIListView:pushBackDefaultItem()
    if nullptr == self.model_ then return end
    local item = self.model_:clone()
    self:pushBackCustomItem(item)
    return item
end

function UIListView:insertDefaultItem(index)
    if nullptr == self.model_ then return end
    self:insertCustomItem(self.model_:clone(), index)
end

function UIListView:removeItem(index)
    local item = self:getItem(index)
    if nullptr == item then return end
    table.remove(self.items_, index)
    self.scrollView_:removeChild(item)
    self.doLayoutDirty_ = true
end

function UIListView:removeItems(index)
    local removeItems = {}
    for i, v in ipairs(index) do
        removeItems[i] = self:getItem(v)
    end
    for i, v in ipairs(removeItems) do
        local removeIndex = table.indexOf(self.items_, v)
        self:removeItem(removeIndex)
    end
end

function UIListView:removeLastItem()
    self:removeItem(#self.items_)
end

function UIListView:removeAllItems()
    for i = 1, #self.items_ do
        self:removeItem(1)
    end
    self:updateInnerContainerSize()
end

function UIListView:getItems()
    return self.items_
end

function UIListView:getItem(index)
    if index > 0 and index <= #self.items_ then
        return self.items_[index]
    end
    return nil
end

function UIListView:setDirection(dir)
    if dir ~= SCROLLVIEW_DIR_HORIZONTAL then
        dir = SCROLLVIEW_DIR_VERTICAL
    end
    if self.direction_ == dir then return end
    self.direction_ = dir
    self.scrollView_:setDirection(dir)
    self.doLayoutDirty_ = true
end

function UIListView:getDirection()
    return self.direction_
end

function UIListView:setGravity(gravity)
    if self.gravity_ == gravity then return end
    self.gravity_ = gravity
    self.doLayoutDirty_ = true
end

function UIListView:setItemsMargin(margin)
    if self.itemsMargin_ == margin then return end
    self.itemsMargin_ = margin
    self.doLayoutDirty_ = true
end

function UIListView:getItemsMargin()
    return self.itemsMargin_
end

function UIListView:updateInnerContainerSize()
    local distance = 0
    for i, v in ipairs(self.items_) do
        local size = v:getContentSize()
        size.width = size.width * v:getScaleX()
        size.height = size.height * v:getScaleY()
        if self.direction_ == SCROLLVIEW_DIR_VERTICAL then
            distance = distance + size.height
        else
            distance = distance + size.width
        end
    end

    local width = self.contentSize_.width
    local height = self.contentSize_.height
    if self.direction_ == SCROLLVIEW_DIR_VERTICAL then
        distance = distance + self.itemsMargin_ * (math.max(1, #self.items_) - 1)
        height = math.max(height, distance)
    else
        distance = distance + self.itemsMargin_ * (math.max(1, #self.items_) - 1)
        width = math.max(width, distance)
    end

    self.innerContentSize_ = CCSize(width, height)
    self.scrollView_:setInnerContainerSize(self.innerContentSize_)

    self:updateScrollBar()
end

function UIListView:update()
    if self.doLayoutDirty_ then
        self.doLayoutDirty_ = false
        self:doLayout()
    end
end

function UIListView:onExit()
    if self.model_ then
        self.model_:release()
    end
end

function UIListView:doLayout()
    self:updateInnerContainerSize()
    self:remedyItem()
end

function UIListView:remedyItem()
    local contentSize = self.contentSize_
    local totalHeight = 0
    local totalWidth = 0
    for i, v in ipairs(self.items_) do
        local size = v:getContentSize()
        size.width = size.width * v:getScaleX()
        size.height = size.height * v:getScaleY()
        local ap = v:getAnchorPoint()
        local x, y = 0, 0
        if self.direction_ == SCROLLVIEW_DIR_VERTICAL then
            if self.gravity_ == UIListView.Gravity.CENTER_VERTICAL then
                x = contentSize.width * 0.5 + size.width * (ap.x - 0.5)
            elseif self.gravity_ == UIListView.Gravity.RIGHT then
                x = contentSize.width + size.width * (ap.x - 1.0)
            else
                x = size.width * ap.x
            end
            y = totalHeight + size.height * (1.0 - ap.y)
            y = self.innerContentSize_.height - y

            totalHeight = totalHeight + size.height
            if i < #self.items_ then
                totalHeight = totalHeight + self.itemsMargin_
            end
        else
            if self.gravity_ == UIListView.Gravity.CENTER_HORIZONTAL then
                y = contentSize.height * 0.5 + size.height * (ap.y - 0.5)
            elseif self.gravity_ == UIListView.Gravity.TOP then
                y = contentSize.height + size.height * (ap.y - 1.0)
            else
                y = size.height * ap.y
            end
            x = totalWidth + size.width * ap.x

            totalWidth = totalWidth + size.width
            if i < #self.items_ then
                totalWidth = totalWidth + self.itemsMargin_
            end
        end
        v:setPosition(x, y)
    end
end

function UIListView:jumpToBottom()
    self.scrollView_:jumpToBottom()
end

function UIListView:jumpToTop()
    self.scrollView_:jumpToTop()
end

function UIListView:jumpToLeft()
    self.scrollView_:jumpToLeft()
end

function UIListView:jumpToRight()
    self.scrollView_:jumpToRight()
end

function UIListView:jumpTo(offset)
    if not offset then return end
    if self.direction_ == SCROLLVIEW_DIR_VERTICAL then
        local h = self.contentSize_.height - self.innerContentSize_.height
        if h ~= 0 then
            local percent = offset * 100 / h
            self.scrollView_:jumpTo(TF_SCROLLVIEW_SCROLL_TO_PERCENT_VERTICAL, 0, percent)
        end
    else
        local w = self.contentSize_.width - self.innerContentSize_.width
        local percent = 0
        if w ~= 0 then
            percent = clampf(offset * 100 / w, 0, -100)
        end
        self.scrollView_:jumpTo(TF_SCROLLVIEW_SCROLL_TO_PERCENT_HORIZONTAL, percent, 0)
    end
end

function UIListView:jumpToItem(index)
    if self.direction_ == SCROLLVIEW_DIR_VERTICAL then
        local offsetY = 0
        for i = 1, index - 1 do
            local item = self.items_[i]
            local size = item:getSize()
            offsetY = offsetY + size.height + self.itemsMargin_
        end
        offsetY = self.contentSize_.height * self.ap_.y - offsetY
        self:jumpTo(offsetY)
    else
        local offsetX = 0
        for i = 1, index - 1 do
            local item = self.items_[i]
            local size = item:getSize()
            offsetX = offsetX + size.width + self.itemsMargin_
        end
        self:jumpTo(offsetX)
    end
end

function UIListView:scrollToItem(index, time)
    if self.direction_ == SCROLLVIEW_DIR_VERTICAL then
        local offsetY = 0
        for i = 1, index - 1 do
            local item = self.items_[i]
            local size = item:getSize()
            offsetY = offsetY + size.height + self.itemsMargin_
        end
        offsetY = self.contentSize_.height * self.ap_.y - offsetY
        self:scrollTo(offsetY, time)
    else
        local offsetX = 0
        for i = 1, index - 1 do
            local item = self.items_[i]
            local size = item:getSize()
            offsetX = offsetX + size.width + self.itemsMargin_
        end
        self:scrollTo(offsetX, time)
    end
end

function UIListView:scrollToBottom(time, attenuated)
    time = time or 0.5
    if attenuated == nil then attenuated = true end
    attenuated = not (not attenuated)
    self.scrollView_:scrollToBottom(time, attenuated)
end

function UIListView:scrollToTop(time, attenuated)
    time = time or 0.5
    if attenuated == nil then attenuated = true end
    attenuated = not (not attenuated)
    self.scrollView_:scrollToTop(time)
end

function UIListView:scrollToLeft(time, attenuated)
    time = time or 0.5
    if attenuated == nil then attenuated = true end
    attenuated = not (not attenuated)
    self.scrollView_:scrollToLeft(time)
end

function UIListView:scrollToRight(time, attenuated)
    time = time or 0.5
    if attenuated == nil then attenuated = true end
    attenuated = not (not attenuated)
    self.scrollView_:scrollToRight(time)
end

function UIListView:scrollTo(offset, time, attenuated)
    if not offset then return end
    time = time or 0.5
    local attenuated = (time ~= 0)
    if self.direction_ == SCROLLVIEW_DIR_VERTICAL then
        local h = self.contentSize_.height - self.innerContentSize_.height
        if h ~= 0 then
            local percent = offset * 100 / h
            self.scrollView_:scrollTo(TF_SCROLLVIEW_SCROLL_TO_PERCENT_VERTICAL, time, attenuated, 0, percent)
        end
    else
        local w = self.contentSize_.width - self.innerContentSize_.width
        local percent = 0
        if w ~= 0 then
            percent = clampf(offset * 100 / w, 0, -100)
        end
        self.scrollView_:scrollTo(TF_SCROLLVIEW_SCROLL_TO_PERCENT_HORIZONTAL, time, attenuated, percent, 0)
    end
end

function UIListView:setCenterArrange() --滚动框中间对齐  在内容初始化完成后调用
    -- body
    local distance = 0
    for i, v in ipairs(self.items_) do
        local size = v:getContentSize()
        size.width = size.width * v:getScaleX()
        size.height = size.height * v:getScaleY()
        if self.direction_ == SCROLLVIEW_DIR_VERTICAL then
            distance = distance + size.height
        else
            distance = distance + size.width
        end
    end

    local width = self.contentSize_.width
    local height = self.contentSize_.height
    local offset = 0
    if self.direction_ == SCROLLVIEW_DIR_VERTICAL then
        distance = distance + self.itemsMargin_ * (math.max(1, #self.items_) - 1)
        offset = math.max(0, height - distance)
    else
        distance = distance + self.itemsMargin_ * (math.max(1, #self.items_) - 1)
        offset = math.max(0, width - distance)
    end
    self.defaultPos = self.defaultPos or self:s():getPosition()
    if self.direction_ == SCROLLVIEW_DIR_VERTICAL then
        self:s():setPositionY(self.defaultPos.y + offset*(0.5 - self:s():getAnchorPoint().y))
        self:setContentSize(CCSizeMake(width,height - offset))
    else
        self:s():setPositionX(self.defaultPos.x + offset*(0.5 - self:s():getAnchorPoint().x))
        self:setContentSize(CCSizeMake(width - offset,height ))
    end
    self:update()
    self.contentSize_ = CCSizeMake(width ,height )
end

function UIListView:getInnerContainerSize()
    return self.innerContentSize_
end

function UIListView:setContentSize(size)
    self.contentSize_ = size
    self:updateInnerContainerSize()
    return self.scrollView_:setContentSize(size)
end

function UIListView:setVisible(visible)
    self.scrollView_:setVisible(visible)
end

function UIListView:getContentSize()
    return self.scrollView_:getContentSize()
end

function UIListView:setBounceEnabled(enabled)
    self.scrollView_:setBounceEnabled(enabled)
end

function UIListView:setInertiaScrollEnabled(enabled)
    self.scrollView_:setInertiaScrollEnabled(enabled)
end

function UIListView:setTouchEnabled(enabled)
    self.scrollView_:setTouchEnabled(enabled)
end

function UIListView:setScrollBar(scrollBar)
    self.scrollBar_ = scrollBar
end

function UIListView:updateScrollBar()
    if not self.scrollBar_ then return end
    local ratio = self.contentSize_.height / self.innerContentSize_.height
    self.scrollBar_:setRatio(ratio)
    self.scrollBar_:setPercent(1)
end

function UIListView:s()
    return self.scrollView_
end

return UIListView
