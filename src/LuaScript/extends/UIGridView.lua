
local UIGridView = class("UIGridView")

function UIGridView:initDefault()
    self.doLayoutDirty_ = false
    self.rowMargin_ = 0
    self.columnMargin_ = 0
    self.model_ = nil
    self.items_ = {}
    self.column_ = 2

    self:initParams()
end

function UIGridView:initParams()
    self.contentSize_ = self.scrollView_:getContentSize()
    self.innerContentSize_ = clone(self.contentSize_)
    self.scrollViewAp_ = self.scrollView_:getAnchorPoint()
end

function UIGridView:ctor(scrollView)
    self.scrollView_ = scrollView

    -- 刷新事件
    local eventNode = CCNode:create()
    eventNode:AddTo(self.scrollView_:getParent())
    eventNode:addMEListener(TFWIDGET_ENTERFRAME, handler(self.update, self))
    eventNode:addMEListener(TFWIDGET_EXIT, handler(self.onExit, self))

    self.scrollView_:addMEListener(TFSCROLLVIEW_SCROLLING, handler(self.onScrollingEvent, self))

    self:initDefault()
end

function UIGridView:onScrollingEvent()
    if self.scrollBar_ then
        local position = self.scrollView_:getContentOffset()
        local offsetY = self.contentSize_.height * self.scrollViewAp_.y
        local y = math.min(position.y + offsetY, 0)
        local ty = self.innerContentSize_.height - self.contentSize_.height
        local percent = me.clampf(math.abs(y) / ty, 0, 1)
        self.scrollBar_:setPercent(percent)
    end
end

function UIGridView:update()
    if self.doLayoutDirty_ then
        self.doLayoutDirty_ = false
        self:doLayout()
    end

end

function UIGridView:onExit()
    if self.model_ then
        self.model_:release()
    end
end

function UIGridView:doLayout()
    self:updateInnerContainerSize()
    self:remedyItem()
end

function UIGridView:setItemModel(model)
    if self.model_ and self.model_ ~= model then
        self.model_:release()
    end
    model:retain()

    self.model_ = model
    self.model_:setPositionType(0)

    local size = model:getContentSize()
    local scaleX = model:getScaleX()
    local scaleY = model:getScaleY()
    self.modelSize_ = CCSize(size.width *scaleX, size.height * scaleY)
end

function UIGridView:setColumnMargin(margin)
    if self.columnMargin_ == margin then return end
    self.columnMargin_ = margin
    self.doLayoutDirty_ = true
end

function UIGridView:setRowMargin(margin)
    if self.rowMargin_ == margin then return end
    self.rowMargin_ = margin
    self.doLayoutDirty_ = true
end

function UIGridView:getItems()
    return self.items_
end

function UIGridView:getItem(index)
    return self.items_[index]
end

function UIGridView:insertCustomItem(item, index)
    item:setPositionType(0)
    table.insert(self.items_, index, item)
    self.scrollView_:addChild(item)

    self:updateInnerContainerSize()
    self.doLayoutDirty_ = true

    return item
end

function UIGridView:pushBackCustomItem(item)
    return self:insertCustomItem(item, #self.items_ + 1)
end

function UIGridView:pushBackDefaultItem()
    if nullptr == self.model_ then return end
    return self:pushBackCustomItem(self.model_:clone())
end

function UIGridView:setColumn(column)
    self.column_ = column
end

function UIGridView:getColumn()
    return self.column_
end

function UIGridView:updateInnerContainerSize()
    local itemCount = #self.items_
    local row = math.ceil(itemCount / self.column_)
    local width = self.contentSize_.width
    local height = row * self.modelSize_.height + (row - 1 ) * self.rowMargin_
    height = math.max(height, self.contentSize_.height)

    self.innerContentSize_ = CCSize(width, height)
    self.scrollView_:setInnerContainerSize(self.innerContentSize_)

    self:updateScrollBar()
end

function UIGridView:remedyItem()
    local contentSize = self.contentSize
    for i, v in ipairs(self.items_) do
        local rowIndex = math.floor((i - 1) / self.column_)
        local colIndex = math.mod(i - 1, self.column_)

        local anchorPoint = v:getAnchorPoint()
        local x = (self.modelSize_.width + self.columnMargin_) * colIndex + self.modelSize_.width * anchorPoint.x
        local y = (self.modelSize_.height + self.rowMargin_) * rowIndex + self.modelSize_.height * (1.0 - anchorPoint.y)
        local pos = ccp(x, self.innerContentSize_.height - y)
        v:setPosition(pos)
    end
end

function UIGridView:removeItem(index)
    local item = self:getItem(index)
    if nullptr == item then return end
    table.remove(self.items_, index)
    self.scrollView_:removeChild(item)
    self.doLayoutDirty_ = true
end

function UIGridView:removeItems(index)
    local removeItems = {}
    for i, v in ipairs(index) do
        removeItems[i] = self:getItem(v)
    end
    for i, v in ipairs(removeItems) do
        local removeIndex = table.indexOf(self.items_, v)
        self:removeItem(removeIndex)
    end
end

function UIGridView:removeAllItems()
    for i = 1, #self.items_ do
        self:removeItem(1)
    end
    self:updateInnerContainerSize()
end

function UIGridView:removeLastItem()
    if #self.items_ > 0 then
        self:removeItem(#self.items_)
    end
end

function UIGridView:setVisible(visible)

    if self.asyncAction and not visible then
        self.scrollView_:stopAction(self.asyncAction)
        self.asyncAction = nil
    end

    self.scrollView_:setVisible(visible)
end

function UIGridView:setScrollBar(scrollBar)
    self.scrollBar_ = scrollBar
end

function UIGridView:updateScrollBar()
    if not self.scrollBar_ then return end
    local ratio = self.contentSize_.height / self.innerContentSize_.height
    self.scrollBar_:setRatio(ratio)
    self.scrollBar_:setPercent(1)
end

function UIGridView:s()
    return self.scrollView_
end

function UIGridView:fillListItem(asyncId)
    if asyncId ~= self.asyncId then
        return
    end
    local data = self.datas_[self.loadIndex_]
    if not data then return end

    local item = self:getItem(self.loadIndex_)
    if not item then
        if self.customAddItemFunc_ then
            item = self.customAddItemFunc_(data)
        else  
            item = self:pushBackDefaultItem()
        end
    end
    if item then
        if self.updateItemFunc_ then
            self.updateItemFunc_(item, data,self.loadIndex_)
        end
        self.loadIndex_ = self.loadIndex_ + 1
        local delayDuration = 0.02
        local seq = Sequence:create({
                DelayTime:create(delayDuration),
                CallFunc:create(function()
                        self:fillListItem(asyncId)
                end)
        })
        item:runAction(seq)
    end
end

function UIGridView:AsyncUpdateItem(datas, updateItemFunc,customAddItemFunc)
    self.asyncId = self.asyncId or 0
    self.asyncId = self.asyncId + 1
    self.datas_ = datas or {}
    self.updateItemFunc_ = updateItemFunc
    self.customAddItemFunc_ = customAddItemFunc
    self.loadIndex_ = 1
    local items = self:getItems()
    local gap = #datas - #items
    if gap < 0 then
        for i = 1, math.abs(gap) do
            self:removeItem(1)
        end
    end
    self:fillListItem(self.asyncId)
end

return UIGridView
