
local Action = class("Action")

Action.TYPE_MOVE = 1 --移动
Action.TYPE_HURT = 2 --受击
Action.TYPE_JUMP = 3 --跳跃
Action.TYPE_DELAY = 4 --延迟

local FLT_EPSILON = 0.00000001

function Action:ctor(_type)
    self._delta    = me.Vertex3F(0,0,0)
    self._elapsed  = 0
    self._duration = 0
    self._positionDelta = me.Vertex3F(0,0,0)
    self._type     = _type
end

function Action:start(host,duration,callFunc)
    self._host      = host
    self._duration = duration
    self._callFunc = callFunc
    self._host.actionMgr:insert(self)
end

function Action:stop()
    self._host = nil
end

function Action:isDone()
    return not self._host
end

function Action:step(dt)
    if not self._host then return end
    self._elapsed = self._elapsed + dt
    self:update(dt,self._elapsed)
    self:checkDone()
end

function Action:doDone()
    if self._callFunc then
        self._callFunc()
    end
end

function Action:checkDone()
    if self._elapsed >= self._duration then
        self:stop()
        self:doDone()
    end
end

function Action:update(dt,t)

end

function Action:getType()
    return self._type
end


local MoveBy = class("MoveBy",Action)

function MoveBy:ctor()
    self.super.ctor(self,Action.TYPE_MOVE)
end

function MoveBy:update(dt,t)
    t = math.max (0,math.min(1, t/math.max(self._duration, FLT_EPSILON)))
    local px = self._positionDelta.x * t
    local py = self._positionDelta.y * t
    local pz = self._positionDelta.z * t
    local xv = px - self._delta.x
    local yv = py - self._delta.y
    local zv = pz - self._delta.z
    self._delta.x = px
    self._delta.y = py
    self._delta.z = pz
    self._host:renderMove(xv,yv,zv)
end

function MoveBy:start(host,duration,positionDelta,callFunc)
    self.super.start(self,host,duration,callFunc)
    self._positionDelta.x  = positionDelta.x
    self._positionDelta.y  = positionDelta.y
    if positionDelta.z then
        self._positionDelta.z = positionDelta.z
    else
        self._positionDelta.z = 0
    end
end

local HurtAction = class("HurtAction",Action)

function HurtAction:ctor()
    self.super.ctor(self,Action.TYPE_HURT)
end

--60
--500

function HurtAction:start(host,dir,a,v,callFunc)
    self.super.start(self,host,-1,callFunc)
    self.dir  = dir > 0 and 1 or -1
    self.v    = v  --初始速度
    self.a    = a  --初始角度
end

function HurtAction:calculateX(t)
    local b = math.abs(self.dir) / self.dir * 20   --X轴加速度
    return self.v * math.cos(self.a * math.pi / 180) * t - 0.5 * b * t * t
end

function HurtAction:calculateY(t)
    local g = 1500 --Y轴加速度
    return self.v * math.sin(self.a * math.pi / 180) * t - 0.5 * g * t * t
end

function HurtAction:update(dt,t)
    local minX = dt * 50
    local px = self:calculateX(t)
    local py = self:calculateY(t)
    if self.dir  > 0 then
        if px < self._delta.x + minX then
            px = self._delta.x + minX
        end
    else
        if px > self._delta.x - minX then
            px = self._delta.x - minX
        end
    end
    local xv = px - self._delta.x
    local yv = py - self._delta.y
    self._delta.x = px
    self._delta.y = py
    self._host:renderMove(xv,0,yv)
end



function HurtAction:checkDone()
    if not self._host:isInAir() then
        self:stop()
        self:doDone()
    end
end

---------------------------
local Jump = class("Jump",Action)

function Jump:ctor()
    self.super.ctor(self,Action.TYPE_JUMP)
end

-- float duration, const Vec2& position, float height, int jumps
function Jump:start(host,duration,positionDelta,height,jumps,callFunc)
    self.super.start(self,host,duration,callFunc)
    self._positionDelta.x  = positionDelta.x
    self._positionDelta.y  = positionDelta.y
    self._positionDelta.z = 0
    self._jumps  = jumps
    self._height = height
end


function Jump:update(dt,t)
    t = math.max (0,math.min(1, t/math.max(self._duration, FLT_EPSILON)))
    local frac = math.fmod( t * self._jumps, 1.0 )
    local  y   = self._height * 4 * frac * (1 - frac)
    y = y + self._positionDelta.y * t
    local  x = self._positionDelta.x * t
    local xv = x - self._delta.x
    local yv = y - self._delta.y
    self._delta.x = x
    self._delta.y = y
    self._host:renderMove(xv,yv)
end
------------------
local Delay = class("Delay",Action)
function Delay:ctor()
    self.super.ctor(self,Action.TYPE_DELAY)
end

----------------------

local ActionMgr = class("ActionMgr")

function ActionMgr:ctor()
    self.actions = {}
end

function ActionMgr:insert(action)
    self.actions[#self.actions + 1] = action
end

function ActionMgr:remove(action)
    table.removeItem(self.actions,action)
end

function ActionMgr:update(dt)
    local len = #self.actions
    for index = len , 1 , -1 do
        local action = self.actions[index]
        action:step(dt)
        if action:isDone() then
            table.remove(self.actions,index)
        end
    end
end

function ActionMgr:stop(actionType)
    local len = #self.actions
    local action
    for index = len , 1 , -1 do
        action = self.actions[index]
        if not actionType or action:getType() == actionType then
            action:stop()
        end
    end
end

function Action.createDelayAction()
    return Delay:new()
end

function Action.createJumpAction()
    return Jump:new()
end

function Action.createHurtAction()
    return HurtAction:new()
end

function Action.createMoveAction()
    return MoveBy:new()
end

function Action.createMgr()
    return ActionMgr:new()
end

return Action