TFBarrage = class("TFBarrage", function()
    local node = CCNode:create()
    return node
end)

local ELASE_FPS = 0.016

local BulletCache = {
    list = {},
    unCached = {},
}
function BulletCache:Get(path)
    self.list[path] = self.list[path] or {}
    local cache = self.list[path]
    local count = #cache
    local bullet
    if count == 0 then 
        bullet = SkeletonAnimation:create(path)
        bullet:retain()
        bullet.__Path = path
    else 
        bullet = cache[count]
        bullet:Pos(0, 0)
        bullet:visit()
        table.remove(cache, count)
    end
    bullet.Valid = false
    self.unCached[bullet] = true
    return bullet
end
function BulletCache:Recycle(bullet)
    local path = bullet.__Path or ""
    bullet:removeFromParent(false)
    self.list[path] = self.list[path] or {}

    table.insert(self.list[path], bullet)
    self.unCached[bullet] = nil
end

function BulletCache:Update(dt)
    for bullet in pairs(self.unCached) do 
        bullet.Valid = true
    end
end

local RoundTick = class("RoundTick")
function RoundTick:ctor(config)
    self.config = config
    self.Elapse = 0
    self.Round = 0
end

function RoundTick:Update(dt)
    if self.Round >= self.config.Round then 
        return false
    end

    local interval = 0
    if type(self.config.Interval) == 'number' then 
        interval = self.config.Interval
    else 
        interval = self.config.Interval[self.Round + 1] or self.config.Interval[1] or 0
    end
    if self.Elapse >= interval then 
        self.Elapse = self.Elapse - interval
        self.Round = self.Round + 1
        return true
    end
    return false
end

function RoundTick:Tick(dt)
    self.Elapse = self.Elapse + dt * 1000
    return self.Round >= self.config.Round
end

local function EmptyRotFunc() return 0 end
local EmitTick = class("EmitTick")
function EmitTick:ctor(config, Direction, Vec, rotFunc, vecFunc)
    self.config = config
    self.Elapse = 0
    self.Number = 0
    self.rotFunc = rotFunc or EmptyRotFunc
    self.vecFunc = vecFunc

    self.Direction = (Direction or 0)
    self.Vec = Vec or ccp(0, 0)
end

function EmitTick:doEmit()
    local bullet = BulletCache:Get(self.config.Path)
    bullet:playByIndex(0, 1)

    
    bullet:setRotation(-self.Direction)
    bullet.position = ccp(0, 0)
    bullet.vec = self.vecFunc and self.vecFunc(self.Direction) or self.Vec

    self.Direction = self.Direction + self.rotFunc()
    return bullet
end

function EmitTick:Update(dt)
    if self.Number >= self.config.Number then 
        return false
    end

    local interval = 0
    if type(self.config.IntervalInside) == 'number' then 
        interval = self.config.IntervalInside
    else 
        interval = self.config.IntervalInside[self.Number + 1] or self.config.IntervalInside[1] or 0
    end
    if self.Elapse >= interval then 
        self.Elapse = self.Elapse - interval
        self.Number = self.Number + 1
        return true
    end
    return false
end

function EmitTick:Tick(dt)
    self.Elapse = self.Elapse + dt * 1000
    return self.Number < self.config.Number
end

local BaseEmiter = class("BaseEmiter")
function BaseEmiter:ctor(config, container, emitPos)
    self.config = config
    self.emitPos = emitPos or ccp(0, 0)
    self.container = container
    self.bullets = {}
    self.emiters = {}
    self.delEmiters = {}
    self.TimeElapse = 0

    self.RoundTick = RoundTick:new(config)
    self.Number = 0
end

function BaseEmiter:doRound(dt)
    local dir = self.config.Direction[self.RoundTick.Round] or self.config.Direction[1] or 0
    local vecX = (self.config.FlyRate[self.RoundTick.Round] or self.config.FlyRate[1] or 1) * 1000.0
    local vec = me.pForAngle(dir / 180 * math.pi) * vecX

    table.insert(self.emiters, EmitTick:create(self.config, dir, vec))
end

function BaseEmiter:UpdateEmiters(dt)
    if #self.emiters == 0 then return end
    local hasDel = false
    for i = 1, #self.emiters do 
        local emiter = self.emiters[i]        
        if emiter:Tick(dt) then 
            while emiter:Update(dt) do 
                local bullet = emiter:doEmit()
                if bullet then 
                    bullet.position = bullet.position + self.emitPos
                    bullet:Pos(bullet.position)
                    self.container:addChild(bullet)
                    table.insert(self.bullets, bullet)
                end
            end
        else 
            self.delEmiters[emiter] = true
            hasDel = true
        end
    end
    if hasDel then 
        for tmp in pairs(self.delEmiters) do 
            for idx, emiter in ipairs(self.emiters) do 
                if tmp == emiter then 
                    table.remove(self.emiters, idx)
                end
            end
        end
         self.delEmiters = {}
    end
end

function BaseEmiter:Update(dt)
    self.TimeElapse = self.TimeElapse + dt
    self.RoundTick:Tick(dt)
    while self.RoundTick:Update(dt) do 
        self:doRound(dt)
    end
    self:UpdateEmiters(dt)

    local count = #self.bullets
    if count == 0 then return false end

    local PADDING = 200
    local winSize = me.EGLView:getFrameSize()
    local winWidth = winSize.width + PADDING
    local winHeight = winSize.height + PADDING
    local outBullet = {}
    for i = 1, count do 
        local bullet = self.bullets[i]
        local position = bullet.position + bullet.vec * dt
        bullet.position = position
        bullet:Pos(bullet.position)

        if bullet.Valid then 
            local wpos = bullet:getWorldPosition()
            if wpos.x > winWidth or wpos.x < -PADDING or wpos.y > winHeight or wpos.y < -PADDING then 
                table.insert(outBullet, bullet)
            end
        end
    end

    local delCount = #outBullet
    if delCount > 0 then 
        for k, tmp in pairs(outBullet) do 
            for idx, bullet in ipairs(self.bullets) do 
                if tmp == bullet then 
                    BulletCache:Recycle(bullet)
                    table.remove(self.bullets, idx)
                end
            end
        end
    end

    return true
end

function BaseEmiter:Dispose()
    local count = #self.bullets
    for i = 1, count do 
        local bullet = self.bullets[i]
        BulletCache:Recycle(bullet)
    end
    self.bullets = {}

    print("Dispose:", count)
end

local LineEmiter = class("LineEmiter", BaseEmiter)

local FanEmiter = class("FanEmiter", BaseEmiter)
function FanEmiter:ctor(config, container, emitPos)
    FanEmiter.super.ctor(self, config, container, emitPos)
end

function FanEmiter:doRound(dt)
    local dir = self.config.Direction[self.RoundTick.Round] or self.config.Direction[1] or 0
    local vecX = (self.config.FlyRate[self.RoundTick.Round] or self.config.FlyRate[1] or 1) * 1000.0
    local vec = me.pForAngle(dir / 180 * math.pi) * vecX

    local rotFunc = nil
    if self.config.Number > 1 then 
        local angle = self.config.Angle
        local rot = angle / 2
        local rotSeek = - angle / (self.config.Number - 1)
        dir = dir + rot

        rotFunc = function()
            return rotSeek
        end
    end

    local vecFunc = function(rot)
        return me.pForAngle(rot / 180 * math.pi) * vecX
    end

    table.insert(self.emiters, EmitTick:create(self.config, dir, vec, rotFunc, vecFunc))
end

local AnnularEmiter = class("AnnularEmiter", BaseEmiter)
function AnnularEmiter:ctor(config, container, emitPos)
    AnnularEmiter.super.ctor(self, config, container, emitPos)
end

function AnnularEmiter:doRound(dt)
    local dir = self.config.Direction[1] or 0 + self.config.Angle
    local vecX = (self.config.FlyRate[self.RoundTick.Round] or self.config.FlyRate[1] or 1) * 1000.0
    local vec = me.pForAngle(dir / 180 * math.pi) * vecX
    local rotRate = self.config.AngleChangeRate[1] / (self.config.AngleChangeRate[2] * 0.001)
    local rotDir = self.config.AngleChangeDirection == 1 and -1 or 1

    local rotFunc = function()
        return self.TimeElapse * rotRate * rotDir
    end

    local vecFunc = function(rot)
        return me.pForAngle(rot / 180 * math.pi) * vecX
    end

    table.insert(self.emiters, EmitTick:create(self.config, dir + rotFunc(), vec, nil, vecFunc))
end

function TFBarrage:ctor(path)
    self.path = path or "res/fly/effects_20301_skillA1"

    self.config = {
        {
            StartPoint = "", -- 发射点位, 填战斗模型上设置的多个点位ID或Name
            LauncherType = 3, -- 1:直线  2:扇形  3:环形  4:钟摆
            Angle = 120, -- 基准角度 0-360
            Round = 100, -- 弹幕波数 1-N
            Direction = {0},--{ 0, 30, 60, 90, 120, 150, 180, 210, 240, 270, 300, 330, 360 }, -- 弹幕朝向 0-360, 0-水平向右  90-垂直向上  180-水平向左  270-垂直向下
            AngleChangeRate = { 45, 200 }, -- 角度朝向变化速率: x/y毫秒
            AngleChangeDirection = 1, -- 1-顺时针  2-逆时针
            Interval = { 50 }, -- 每波弹幕间隔时间 单位毫秒 0-N
            IntervalInside = { 50 }, -- 每波弹幕内间隔时间 单位毫秒 0-N
            Number = 20, -- 1-N
            FlyRate = { 1.62 }, -- 飞行速度, xx像素/毫秒
            Path = self.path,
        },
    }

    self.elapse = 0

    self.emiters = {}

    self:init()
end

function TFBarrage:init()
    self:OnFrame(function(sender, dt)
        dt = math.min(dt, 0.1)

        BulletCache:Update(dt)

        self.elapse = self.elapse + dt
        while self.elapse >= ELASE_FPS do 
            self:Update(ELASE_FPS)
            self.elapse = self.elapse - ELASE_FPS
        end
    end)  
    
    self:OnExit(function()
        for idx, emiter in ipairs(self.emiters) do 
            emiter:Dispose()
        end
        self.emiters = {}
    end)
end

function TFBarrage:Update(dt)
    for idx, emiter in ipairs(self.emiters) do 
        emiter:Update(dt)
    end
end

function TFBarrage:Emit(config, pos)
    pos = pos or ccp(0, 0)
    self.config = config or self.config
    self.emiters = {}

    if #self.config > 0 then 
        for i = 1, #self.config do 
            local cfg = self.config[i]
            if cfg.LauncherType == 1 then 
                self:LineEmit(cfg, pos) 
            elseif cfg.LauncherType == 2 then 
                self:FanEmit(cfg, pos) 
            elseif cfg.LauncherType == 3 then 
                self:AnnularEmit(cfg, pos) 
            elseif cfg.LauncherType == 4 then 
                self:ClockEmit(cfg, pos) 
            end
        end
    end

end

-- 1:直线  
function TFBarrage:LineEmit(config, pos)
    local emiter = LineEmiter:create(config, self, pos)
    table.insert(self.emiters, emiter)
end

-- 2:扇形
function TFBarrage:FanEmit(config, pos)
    local emiter = FanEmiter:create(config, self, pos)
    table.insert(self.emiters, emiter)
end

-- 3:环形
function TFBarrage:AnnularEmit(config, pos)
    local emiter = AnnularEmiter:create(config, self, pos)
    table.insert(self.emiters, emiter)
end

-- 4:钟摆
function TFBarrage:ClockEmit(config, pos)
    local emiter = ClockEmiter:create(config, self, pos)
    table.insert(self.emiters, emiter)
end

return TFBarrage