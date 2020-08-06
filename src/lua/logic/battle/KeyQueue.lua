
-- local KeyEvent = class("KeyEvent")
-- function KeyEvent:ctor(keyCode,eventType)
--     self.keyCode   = keyCode
--     self.eventType = eventType
-- end

-- function KeyEvent:getEventType()
--     return self.eventType
-- end

-- function KeyEvent:getKeyCode()
--     return self.keyCode
-- end
-- return KeyState
-------------------------------------------------
--按键队列
local KeyQueue = class("KeyQueue")

function KeyQueue:ctor(capacity)
    self.list     = {}
    self.nCapacity = capacity
end

function KeyQueue:popFront()
    if self:size() > 0 then
        local object = self.list[1]
        table.remove(self.list,1)
        return object
    end
end

function KeyQueue:removeFront(count)
    for index = 1, count do
        self:popFront()
    end
end

function KeyQueue:popBack()
    if self:size() > 0 then
        local object = self.list[self:size()]
        table.remove(self.list,self:size())
        return object
    end
end

function KeyQueue:pushBack(object)
    if self:isFull() then
        self:popFront()
    end
    table.insert(self.list,object)
    -- self:print()
end

--返回第一个的元素
function KeyQueue:front()
    return self.list[1]
end

--返回最后一个元素
function KeyQueue:back()
    return self.list[self:size()]
end

function KeyQueue:size()
    return #self.list
end

function KeyQueue:at(index)
    return self.list[index]
end


--容量
function KeyQueue:capacity()
    return self.nCapacity
end

function KeyQueue:isEempty()
    return self:size() < 1
end

function KeyQueue:isFull()
    return self:size() >= self:capacity()
end

function KeyQueue:clear()
    self.list = {}
end

function KeyQueue:print()
    print(string.format("KeyQueue size:%d capacity:%d",self:size(),self:capacity()))
    print(self.list)
end

return KeyQueue


