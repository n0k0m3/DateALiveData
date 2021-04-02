
--按键管理
local KeyQueue  = import(".KeyQueue")
local enum      = import(".enum")
local eVKeyCode = enum.eVKeyCode
local eEvent    = enum.eEvent

local eKeyEventType = enum.eKeyEventType

local Operate = class("Operate")

--创建以一条指令
local function createKeyEvent(keyCode,eventType)
    return {keyCode = keyCode , eventType= eventType}
end

function Operate:ctor(hero)
    self.hero     = hero
    --按键堆栈
    self.keyQueue = KeyQueue:new(3)
    --摇杆向量
    self.rokeVector = ccp(0,0)
end

--当前队列里的键值
-- function Operate:getKeyCode()
--     if self.keyQueue:size() > 0 then
--         return self.keyQueue:at(1).keyCode
--     end
--     return -1
-- end

function Operate:setRokeVector(vx,vy)
    self.rokeVector.x = vx
    self.rokeVector.y = vy
end

function Operate:getRokeVector()
    return self.rokeVector
end


function Operate:clear()
    self.rokeVector.x = 0
    self.rokeVector.y = 0
    self.keyQueue:clear()
end

--支持多按键匹配
function Operate:matchKeyEvent(eventData)
    local keyEvent
    -- print("---------------------")
    -- dump(eventData)
    -- print(self.keyQueue.list)
    for index = 1 , self.keyQueue:size() do
        keyEvent = self.keyQueue:at(index)
        -- print(keyEvent.keyCode ,keyEvent.eventType)
        local keyCodeData = eventData[keyEvent.keyCode]
        if keyCodeData then 
            if keyCodeData[keyEvent.eventType] then
                self.keyQueue:removeFront(index)
                return keyCodeData[keyEvent.eventType]
            end
        end
    end
    return nil
end

function Operate:onKeyEvent(keyCode,skillSubId)
    if self.hero:onKeyEvent(keyCode,skillSubId) then --技能释放成功清理队列
        self.keyQueue:clear()
    end
end

function Operate:createAndPush(keyCode,eventType,skillSubId)
    -- 按键不相同的情况下不再清理队列
    --doing 吃掉前一个down
    if eventType == eKeyEventType.DOING then
        local keyEvent = self.keyQueue:back()
        if keyEvent then
            if keyEvent.keyCode == keyCode and keyEvent.eventType == eKeyEventType.DOWN then
                self.keyQueue:popBack()
            end
        end
    end
    self.keyQueue:pushBack(createKeyEvent(keyCode,eventType))
    -- print_("------------------------------------------------------createAndPush:"..tostring(keyCode).." "..tostring(eventType))
    --点击按键(通知有新按键输入)
    if eventType == eKeyEventType.DOWN then
        self:onKeyEvent(keyCode,skillSubId)
        -- dump(self.keyQueue.list)
    end
end

function Operate:clearKeyQueue()
    self.keyQueue:clear()
end

-- function Operate:isValidKey( ... )

-- end


return Operate



