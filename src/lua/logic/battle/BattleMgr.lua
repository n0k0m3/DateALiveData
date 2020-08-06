local BattleMgr ={}

local schedule  = nil
local actionMgr = nil

function BattleMgr.loop(dt)
    if actionMgr then
        actionMgr:update(dt)
    end
    if schedule then
        schedule:update(dt)
    end
end

---------
local component  =  {}

function component:getName()
    return self.name
end
function component:getObjects()
    return self.list
end
function component:add(object)
    table.insert( self.list, object )
end
function component:remove(object)
    table.removeItem( self.list, object )
end
function component:update(dt)
    for i = #self.list , 1 , -1 do
        if self.list[i] then
            self.list[i]:update(dt)
        else
            printError(string.format("mgr[%s] size=%d index=%d is nil !",self:getName(), #self.list , i ))
        end
    end
end
function component:clear()

    if self.name == "hero" then
        local tmpList = self.list
        self.list = {}
        for i = #tmpList , 1 , -1 do
            if tmpList[i] then
                tmpList[i]:release()
            end
        end
    else
        self.list = {}
    end
    self.bPause = false
end

function component:pause()
    self.bPause = true
    for i = #self.list , 1 , -1 do
        if self.list[i] then
            self.list[i]:pause()
        end
    end
end

function component:resume()
    self.bPause = false
    for i = #self.list , 1 , -1 do
        if self.list[i] then
            self.list[i]:resume()
        end
    end
end

function component:getObject(objectId)
    for i = #self.list , 1 , -1 do
        if self.list[i]:getObjectID() == objectId then
            return self.list[i]
        end
    end
end

function component:walk(func)
    for i = #self.list , 1 , -1 do
        func(self.list[i])
    end
end

function component:isPause()
    return self.bPause
end
-----------------------------------------------------------
--所有的管理器
local mgrs = {}
local mgrList = {}


local function createMrg(mgrName)
    local mgr = {}
    mgr.list  = {}
    mgr.name  = mgrName
    mgr.bPause= false
    for name, func in pairs(component) do
        if type(func) == 'function' then
            rawset(mgr, name, func)
        end
    end
    return mgr
end



-- BattleMgr.propMgr     = createMrg("propMgr")
-- BattleMgr.obstacleMgr = createMrg("obstacleMgr")
-- BattleMgr.effectMgr   = createMrg("effectMgr")

function BattleMgr.update(dt)
    -- BattleMgr.loop(dt*0.001)
    -- local time    = 0
    for k,mgr in ipairs(mgrList) do
        -- time    = socket.gettime()*1000
        mgr:update(dt)
        -- time  = socket.gettime()*1000-time
        -- if time > 16 then
        --     print("PassTime:"..string.format("%f0.1",time).." "..mgr.name)
        -- end
    end
end

function BattleMgr.clear()
    for k,mgr in ipairs(mgrList) do
        mgr:clear()
    end
    BattleMgr.cleanScheduleAndActionMgr()
end


function BattleMgr.pause()
    for k,mgr in ipairs(mgrList) do
        mgr:pause()
    end
end

function BattleMgr.resume()
    for k,mgr in ipairs(mgrList) do
        mgr:resume()
    end
end


function BattleMgr.getMgr(mgrName)
    if not mgrs[mgrName] then
        mgrs[mgrName] = createMrg(mgrName)
        table.insert(mgrList,mgrs[mgrName])
    end
    return mgrs[mgrName]
end


function BattleMgr.getPropMgr()
    return BattleMgr.getMgr("propMgr")
end

function BattleMgr.getObstacleMgr()
    return BattleMgr.getMgr("obstacleMgr")
end

function BattleMgr.getEffectMgr()
    return BattleMgr.getMgr("effectMgr")
end

function BattleMgr.getBufferMgr()
    return BattleMgr.getMgr("bufferMgr")
end

function BattleMgr.getHeroMgr()
    return BattleMgr.getMgr("hero")
end


function BattleMgr.getSchedule()
    if not schedule then
        schedule=CCScheduler:new()
        schedule:retain();
    end
    return schedule
end

function BattleMgr.getActionMgr()
    -- body
    if not actionMgr then
        actionMgr=ActionManager:new();
        actionMgr:retain();
    end
    return actionMgr;
end


function BattleMgr.removeScheduleAndActionMgr( )
    if actionMgr then
        actionMgr:release();
        actionMgr=nil;
    end

    if schedule then
        schedule:release();
        schedule=nil;
    end
end

function BattleMgr.cleanScheduleAndActionMgr( )
    if actionMgr then
        actionMgr:removeAllActions()
    end

    if schedule then
        -- schedule:unscheduleAll()
    end
end

BattleMgr.getActionMgr()
BattleMgr.getSchedule()

function BattleMgr.bindActionMgr(node)
    if not node then return end
    local acitonMgr = BattleMgr.getActionMgr()
    node:setActionManager(acitonMgr)
end

function BattleMgr.bindSchedule(node)
    if not node then return end
    local schedule = BattleMgr.getSchedule()
    node:setScheduler(schedule)
end


return BattleMgr




