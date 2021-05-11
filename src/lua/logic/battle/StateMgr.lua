local enum = import(".enum")
local BattleUtils = import(".BattleUtils")
local eAState = enum.eAState
local Debug   = BattleUtils.print

local buffState = TabDataMgr:getData("BuffState")
--状态转换成列表（遍历的时候保证顺序)
-- local StateList = {}
-- for i, state in pairs(eAState) do
--     StateList[#StateList + 1] =  state
-- end
-- table.sort(StateList,function(a , b)
--     return a < b
-- end)
local StateMgr = class("StateMgr")
function StateMgr:ctor(hero)
    self.host  = hero
    self.stateSign = {}
end
function StateMgr:addState(state,objectId)
    --检查状态时候可以被添加
    if not self:isCanAdd(state) then
        local actor = self.host:getActor()
        if actor then
            local data = buffState[state]
            if data and data.name then
                actor:showBufferEffectName(1 , data.name..TextDataMgr:getText(10038))
            end
        end
        return false
    end
    --互斥处理
    self:mutex(state)
    --状态添加
    objectId = objectId or 1
    self.stateSign[state] = self.stateSign[state] or {}
    self.stateSign[state][objectId] = true
    --通知状态被添加
    self.host:onAStateAdd(state,objectId)
    Debug("状态添加["..self.host:getName()..","..state..","..objectId.."]")
    return true

end
function StateMgr:delState(state,objectId)
    objectId = objectId or 1
    if self.stateSign[state] then
        if self.stateSign[state][objectId] then
            self.stateSign[state][objectId] = nil
            --通知状态删除
            self.host:onAStateDel(state,objectId)
        end
        --状态彻底删除
        if table.count(self.stateSign[state]) < 1 then
            self.host:onAStateClear(state)
        end
    end

    Debug("状态删除["..self.host:getName()..","..state..","..objectId.."]")
end

function StateMgr:isState(state)
    if self.stateSign[state] then
        return table.count(self.stateSign[state]) > 0
    end
end

function StateMgr:clearState(state)
    if self.stateSign[state] then
        local keys = table.keys(self.stateSign[state])
        self.stateSign[state] = {}
        for i, objectId in ipairs(keys) do
            self.host:onAStateDel(state,objectId)
        end
        self.host:onAStateClear(state)
    end
    Debug("删除ALL状态:"..tostring(self.host:getName()).." "..tostring(state))
end

--强制清楚状态 没有事件通知
function StateMgr:forceClearState(state)
    if self.stateSign[state] then
        self.host:onAStateClear(state)
        self.stateSign[state] = {}
    end
end
--状态的叠加层数
function StateMgr:getStateCount(state)
    if self.stateSign[state] then
        -- Debug("状态叠加数量:"..tostring(self.host:getName()).." "..tostring(table.count(self.stateSign[state])))
        return table.count(self.stateSign[state])
    end
    return 0
end

--状态互斥处理
function StateMgr:mutex(state)
    local data  = buffState[state]
    if data then
        for i , _state in ipairs(data.resetId) do
            self:clearState(_state)
        end
    end
end

--检查一个状态能不能添加
function StateMgr:isCanAdd(state)
    local data = buffState[state]
    if data then
        for i , _state in ipairs(data.clashId) do
            if self:isState(_state) then
                return false
            end 
        end
    end
    return true
end

return StateMgr