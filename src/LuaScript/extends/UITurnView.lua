
local UITurnView = class("UITurnView")

function UITurnView:ctor(scrollView)
    self.scrollView_ = scrollView

    self.ap_ = self.scrollView_:getAnchorPoint()
    self.contentSize_ = self.scrollView_:getContentSize()
    self.middlePosition_ = ccp(self.contentSize_.width * 0.5, self.contentSize_.height * 0.5)
    self.doLayoutDirty_ = false
    self.items_ = {}
    self.itemOffset_ = {}
    self.customRateOffset_ = 300
    self.selectIndex_ = 1

    -- 刷新事件
    local eventNode = CCNode:create()
    eventNode:AddTo(self.scrollView_:getParent())
    eventNode:addMEListener(TFWIDGET_ENTERFRAME, handler(self.onUpdate, self))
    eventNode:addMEListener(TFWIDGET_EXIT, handler(self.onExit, self))
    self.scrollView_:addMEListener(TFWIDGET_COMPLETED, handler(self.onCompletedEvent, self))
    self.scrollView_:addMEListener(TFSCROLLVIEW_CHANGED, handler(self.onChangedEvent, self))
    self.scrollView_:addMEListener(TFWIDGET_CHECK_CHILDINFO, handler(self.onTouchEndEvent, self))
end

function UITurnView:removeAllItems()
    for i = #self.items_, 1, -1 do
        local item = self.items_[i]
        table.removeItem(self.items_,item)
        item:RemoveSelf()
    end
    self.items_ = {}
    local size = clone(self.contentSize_ )
    self:setInnerContainerSize(size)
end

function UITurnView:setItemModel(model)
    if self.model_ then return end
    model:retain()
    self.model_ = model
    self.modelSize_ = model:getSize()
end

function UITurnView:getItem(index)
    if index then
        return self.items_[index]
    else
        return self.items_
    end
end

function UITurnView:pushBackItem()
    local model = self.model_:clone()
    table.insert(self.items_, model)
    self.scrollView_:addChild(model)
    self.doLayoutDirty_ = true
    return model
end

function UITurnView:onUpdate()
    if self.doLayoutDirty_ then
        self.doLayoutDirty_ = false
        self:doLayout()
    end
end

function UITurnView:registerScrollCallback(callback)
    self.scrollCallback_ = callback
end

function UITurnView:registerSelectCallback(callback)
    self.selectCallback_ = callback
end

function UITurnView:setItemPosition(item, position)
    item:setPosition(position)
end

function UITurnView:setInnerContainerSize(size)
    self.innerContentSize_ = size
    self.scrollView_:setInnerContainerSize(size)
end

function UITurnView:scrollToItem(index)
    self.selectIndex_ = index
    if not self.doLayoutDirty_ then
        local w = self.contentSize_.width - self.innerContentSize_.width
        if w ~= 0 then
            local containerOffset = self.scrollView_:getContentOffset()
            local _percent = -containerOffset.x*100 / w
            local percent = (index - 1) * self.modelSize_.width * 100 / w
            if math.abs(math.abs(percent) - math.abs(_percent)) >= 0 then
                self.scrollView_:scrollToPercentHorizontal(percent, 0.5, true)
            end
        end
        if self.selectCallback_ then
            self.selectCallback_(self, index)
        end
    end
end

function UITurnView:jumpToItem(index)
    self.selectIndex_ = index
    if not self.doLayoutDirty_ then
        local w = self.contentSize_.width - self.innerContentSize_.width
        if w ~= 0 then
            local percent = (index - 1) * self.modelSize_.width * 100 / w
            self.scrollView_:scrollToPercentHorizontal(percent, 0, false)
        end
        if self.selectCallback_ then
            self.selectCallback_(self, index)
        end
    end
end

function UITurnView:getSelectIndex()
    return self.selectIndex_
end

function UITurnView:doLayout()
    local size = clone(self.contentSize_ )
    local count = #self.items_
    local width = self.contentSize_.width + self.modelSize_.width * (count - 1)
    size.width = math.max(size.width, width)
    self:setInnerContainerSize(size)


    local containerOffset = self.scrollView_:getContentOffset()
    for i, v in ipairs(self.items_) do
        local x = self.contentSize_.width * 0.5 + (i - 1) * self.modelSize_.width
        local y = self.contentSize_.height * 0.5
        local pos = ccp(x, y)
        self:setItemPosition(v, pos)

        self.itemOffset_[i] = ccpSub(pos, containerOffset)
    end

    self:onChangedEvent()
    self:scrollToItem(self.selectIndex_)
end

function UITurnView:onExit()
    if self.model_ then
        self.model_:release()
    end
end

function UITurnView:onChangedEvent()
    local containerOffset = self.scrollView_:getContentOffset()

    local offsetRate = {}
    local customOffsetRate = {}
	local minIndex, minOffsetX
    for i, v in ipairs(self.itemOffset_) do
        local pos = ccpAdd(v, containerOffset)
        local offsetX =  self.middlePosition_.x - pos.x
        local maxlOffset = math.max(self.modelSize_.width * (#self.items_ - 1), self.contentSize_.width)
        local rate1 = math.abs(offsetX / maxlOffset)
        local rate2 = math.abs(offsetX) / self.customRateOffset_
        offsetRate[i] = rate1
        customOffsetRate[i] = rate2

        if minIndex then
            if math.abs(offsetX) < math.abs(minOffsetX) then
                minOffsetX = offsetX
                minIndex = i
            end
        else
            minIndex = i
            minOffsetX = offsetX
        end
    end
    if self.scrollCallback_ then
        self.scrollCallback_(self, offsetRate, customOffsetRate,minIndex)
    end
end

function UITurnView:onCompletedEvent()
    local minIndex, minOffsetX
    local containerOffset = self.scrollView_:getContentOffset()
    for i, v in ipairs(self.itemOffset_) do
        local pos = ccpAdd(v, containerOffset)
        local offsetX =  self.middlePosition_.x - pos.x
        if minIndex then
            if math.abs(offsetX) < math.abs(minOffsetX) then
                minOffsetX = offsetX
                minIndex = i
            end
        else
            minIndex = i
            minOffsetX = offsetX
        end
    end

    self:scrollToItem(minIndex)
end

function UITurnView:onTouchEndEvent(target, state)
    if state == 2 or state == 3 then
        target:timeOut(function()
                local isScroll = false
                if target.isAutoScrolling then
                    isScroll = target:isAutoScrolling()
                end
                if not isScroll then
                    self:onCompletedEvent()
                end
        end)
    end
end

return UITurnView
