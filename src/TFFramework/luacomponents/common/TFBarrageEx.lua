

local ELASE_FPS = 20
local ELASE_FPS_FLOAT = ELASE_FPS * 0.001
local MinLerpAngle = 1 / 180 * math.pi

local _insert = table.insert

local COLLISION_DEBUG = false

local function drawDebugNode(bullet)
    if COLLISION_DEBUG and bullet.debugNode then
        bullet.debugNode:clear()
        local points = bullet:getCollisionWithName("bdbox")
        points[#points+1] = points[1]
        for i = 1, #points - 1 do
            bullet.debugNode:drawLine(points[i], points[i + 1], ccc4(1, 1, 0, 1))
        end
    end
end

-- 力场
ForceField = class("ForceField", function()
    local node = CCNode:create()
    if Editor and Editor.TimelineView then 
        node = TFImage:create("editor/force.png"):Size(25, 25)
    end
    return node
end)

function ForceField:ctor(info)
    info = info or {}
    self.Type       = info.Type or 0
    self.Frame      = info.Frame or { x = 0, y = 200 }
    self.Length     = info.Length or 100
    self.Acc        = info.Acc or 5
    self.Angle      = info.Angle or 0
    self.VelAcc     = me.pForAngle(self.Angle / 180 * math.pi) * self.Acc

    local hl        = self.Length / 2
    self.Rect       = ccr(-hl, -hl, self.Length, self.Length)
    self.ZeroAcc    = ccp(0, 0)

    self.CurFrame = -1

    self:Rotate(-self.Angle)
    
    BulletCache:AddForceField(self)

    self:OnExit(function()
        BulletCache:RemoveForceField(self)
    end)
end

-- 属性改变后必须重置
function ForceField:Reset()
    self.CurFrame   = -1
    
    self.VelAcc     = me.pForAngle(self.Angle / 180 * math.pi) * self.Acc
    local hl        = self.Length / 2
    self.Rect       = ccr(-hl, -hl, self.Length, self.Length)
    self:Rotate     (-self.Angle)
end

function ForceField:Update(dt)
    self.CurFrame = self.CurFrame + 1
end

function ForceField:GetAcc()
    if self.CurFrame >= self.Frame.x and self.CurFrame <= self.Frame.y then 
        return self.VelAcc
    end
    return self.ZeroAcc
end

-- 应用力场加速度
function ForceField:ApplyBulleft(bullet, acc)
    if self.CurFrame < self.Frame.x or self.CurFrame > self.Frame.y then 
        return acc
    end

    local bpos      = bullet.position
    local fpos      = self:getPosition()
    local seekpos   = bpos - fpos
    
    if self.Type == 0 then 
        if seekpos:length() <= self.Length then 
            acc = acc + self.VelAcc
        end
    else 
        if self.Rect:containsPoint(seekpos) then 
            acc = acc + self.VelAcc
        end
    end   
    
    return acc
end

function ForceField:SetTime(frame)
    self.CurFrame = frame or 0
end

-- 反弹板
ReboundPlate = class("ReboundPlate", function()
    local node = CCNode:create()
    return node
end)

function ReboundPlate:ctor(info)
    info = info or {}
    self.Frame      = info.Frame or { x = 0, y = 200 }
    self.Length     = info.Length or 100
    self.Angle      = 0 - (info.Rotation or 0)
    self.Times      = 0
    self.Count      = 0
    self.isPosChange=true

    self.CurFrame   = -1
    self.bulletCollide = setmetatable({}, { __mode="k" })

    -- self:Rotate     (-self.Angle)
    self.line       = { self:Pos(), self:Pos() }
    self:Size(ccs(self.Length, 20))
    
    BulletCache:AddReboundPlate(self)

    self:OnExit(function()
        BulletCache:RemoveReboundPlate(self)
    end)

    local __ReboundPlate_setPosition = self.setPosition
	local function __setPosition(self, x, y)
	    if not y then 
	        __ReboundPlate_setPosition(self, x.x, x.y)
	    else 
	        __ReboundPlate_setPosition(self, x, y)
        end
        self.isPosChange=true
	    return self
    end
    self.setPosition = __setPosition
end

function ReboundPlate:calcLine()
    self.isPosChange = false

    local pos       = self:Pos()
    local Vel       = me.pForAngle(self.Angle / 180 * math.pi) * self.Length

    self.line       = { pos, pos + Vel, pos + Vel * 0.5 }
end

-- 属性改变后必须重置
function ReboundPlate:Reset()
    self.CurFrame   = -1
    self.Count      = 0
    
    -- self:Rotate     (-self.Angle)
    self:Size(ccs(self.Length, 20))
end

function ReboundPlate:Update(dt)
    self.CurFrame   = self.CurFrame + 1

    local lastAngle = self.Angle
    self.Angle      = 0 - self:Rotate()

    if math.abs(lastAngle - self.Angle) > 1e-3 or self.isPosChange then 
        self:calcLine()
    end
end

-- 应用力场加速度
function ReboundPlate:ApplyBulleft(bullet)
    if self.CurFrame < self.Frame.x or self.CurFrame > self.Frame.y then
        return nil
    end
    local bcollide = bullet.collide
    if bcollide and self.Times > 0 and (self.bulletCollide[bcollide] or 0) >= self.Times then 
        return nil
    end
    
    local bpos      = bullet.position
    local lpos      = bullet.lastPos
    local A         = bpos - lpos

    if (self.line[3] - bullet.position):length() > self.Length * 0.5 then 
        return nil
    end

    local isTriger, s, t = me.pIsSegmentIntersect(self.line[1], self.line[2], lpos, bpos)

    if isTriger then 
        local B     = self.line[2] - self.line[1]
        -- local O     = A * s

        local BN    = me.pNormalize(me.pPerp(B))
        local angle = me.pGetAngle(A, BN)
        if angle < math.pi * 0.5 then 
            BN      = me.pNormalize(me.pRPerp(B))
            angle   = me.pGetAngle(A, BN)
        end
        local R     = A - BN * me.pDot(A, BN) * 2

        local vel   = R:normalize() * bullet.vel:length()
        bullet.vel  = vel
        bullet.position = bullet.lastPos + (A + R)

        bullet      :Pos(bullet.position)
        bullet      .collide = bullet.collide or {}


        local bcollide = bullet.collide
        self.bulletCollide[bcollide] = self.bulletCollide[bcollide] or 0
        self.bulletCollide[bcollide] = self.bulletCollide[bcollide] + 1
        return 0 - me.pToAngleSelf(R) / math.pi * 180
    end
    return nil
end

function ReboundPlate:SetTime(frame)
    self.CurFrame = frame or 0
end

-----------------------------------------------------------------------------

OrbitConfig = class("OrbitConfig")
function OrbitConfig:ctor()
    self.FlyType = 0
    self.Frame = { x = 0, y = 200 }

    self.Line = {
        Vel = 100,
        Angle = 0,
        Acc = 0,
        AccAngle = 0,
        isExtends = false,
    }

    self.Circle = {
        Radius = 100,
        Start = 0,
        Vel = 100, 
        Acc = 0,
    }

    self.Sin = {
        Height = 100,
        Width = 1,
        Scale = 10,
        Vel = 100,
        Acc = 0,
        Angle = 0,
    }

    self.points = {}
    self.polyDirty = true

    self.CurVel = 0
    self.Configs = { [0] = self.Line, [1] = self.Circle, [2] = self.sin }
end

function OrbitConfig:rebuildLinePoints(lastVel)
    local extendsVel
    if self.Line.isExtends and lastVel then 
        extendsVel = lastVel
    end

    local vel   = extendsVel or me.pForAngle(self.Line.Angle / 180 * math.pi) * (self.Line.Vel or 0)
    local acc   = me.pForAngle(self.Line.AccAngle / 180 * math.pi) * (self.Line.Acc or 0)
    self.points = { ccp(0, 0) }

    local pos = self.points[1]
    local dt = ELASE_FPS_FLOAT
    for i = self.Frame.x, self.Frame.y do 
        pos = pos + vel * dt
        vel = vel + acc * dt
        _insert(self.points, pos)
    end
    self.CurVel = vel
end

function OrbitConfig:rebuildCirclePoints(lastPos)
    local wvel = self.Circle.Vel / self.Circle.Radius

    local angle = self.Circle.Start / 180 * math.pi
    local angleSpeed = self.Circle.Acc / 180 * math.pi
    
    local startPos = me.pForAngle(angle) * self.Circle.Radius
    local offset = startPos * -1

    self.points = { ccp(0, 0) }

    local pos = self.points[1]
    local dt = ELASE_FPS_FLOAT
    for i = self.Frame.x, self.Frame.y do 
        wvel = wvel + angleSpeed * dt
        angle = angle + wvel * dt

        local pos = me.pForAngle(angle) * self.Circle.Radius + offset
        _insert(self.points, pos)
    end
    self.CurVel = wvel * self.Circle.Radius
end

function OrbitConfig:rebuildSinPoints()
    if self.Sin.Width == 0 or self.Sin.Height == 0 or self.Sin.Scale == 0 then 
        self.points = { ccp(0, 0) }
        return 
    end

    local dir = me.pForAngle(self.Sin.Angle / 180 * math.pi)

    local vel   = self.Sin.Vel or 0
    local acc   = self.Sin.Acc or 0

    self.points = { ccp(0, 0) }
    local pos = self.points[1]
    local dt = ELASE_FPS_FLOAT
    local s1, s2 = 0, 0
    local elapse = 0
    local lastPos = self.points[1]
    for i = self.Frame.x, self.Frame.y do 
        elapse = elapse + dt

        vel = vel + acc * dt
        s1 = s1 + vel * dt
        
        local x = self.Sin.Width * self.Sin.Scale * elapse
        local y = self.Sin.Height * math.sin(self.Sin.Width * elapse)
        pos = ccp(x, y)

        s2 = s2 + (pos - lastPos):length()

        while s1 > s2 do 
            elapse = elapse + dt
            local x = self.Sin.Width * self.Sin.Scale * elapse
            local y = self.Sin.Height * math.sin(self.Sin.Width * elapse)

            lastPos = pos
            pos = ccp(x, y)
            s2 = s2 + (pos - lastPos):length()
        end

        lastPos = pos
        _insert(self.points, pos)
    end
    -- self.CurVel = vel
end

function OrbitConfig:rebuild(lastVel, lastPos)
    if self.FlyType == 0 then 
        self:rebuildLinePoints(lastVel)
    elseif self.FlyType == 1 then 
        self:rebuildCirclePoints(lastPos)
    elseif self.FlyType == 2 then 
        self:rebuildSinPoints()
    end
end

function OrbitConfig:OnSave(info)
    info = info or {}
    info.FlyType    = self.FlyType
    info.Frame      = { x = self.Frame.x, y = self.Frame.y }
    if self.FlyType == 0 then 
        info.Line = table.clone(self.Line)
    elseif self.FlyType == 1 then 
        info.Circle = table.clone(self.Circle)
    elseif self.FlyType == 2 then 
        info.Sin = table.clone(self.Sin)
    end
    return info
end

function OrbitConfig:OnLoad(info)
    info = info or { Frame = { x = 0, y = 200 }, Line = {}, Circle = {}, Sin = {} }
    self.FlyType    = info.FlyType or 0
    self.Frame      = { x = info.Frame.x or 0, y = info.Frame.y or 200 }
    if self.FlyType == 0 then 
        self.Line = {
            Vel = info.Line.Vel or 100,
            Angle = info.Line.Angle or 0,
            Acc = info.Line.Acc or 0,
            AccAngle = info.Line.AccAngle or 0,
            isExtends = info.Line.isExtends or false,
        }
    elseif self.FlyType == 1 then 
        self.Circle = {
            Radius = info.Circle.Radius or 100,
            Start = info.Circle.Start or 0,
            Vel = info.Circle.Vel or 100, 
            Acc = info.Circle.Acc or 0,
        }
    elseif self.FlyType == 2 then 
        self.Sin = {
            Height = info.Sin.Height or 100,
            Width = info.Sin.Width or 1,
            Scale = info.Sin.Scale or 1,
            Vel = info.Sin.Vel or 100,
            Acc = info.Sin.Acc or 0,
            Angle = info.Sin.Angle or 0,
        }
    end
    return self
end

TFOrbit = class("TFOrbit")

function TFOrbit:ctor(name)
    self.FileName = name or "flyorbit"

    self.Configs = {
        
    }

    self.points = {}
    BulletCache:AddOrbit(self)
end

function TFOrbit:LoadFromName(name)
    if not name or name == "" then return end

    if not BulletCache:GetOrbit(name) then 
        local filename
        if BulletCache._onOrbitName then 
            filename = BulletCache._onOrbitName(name)
        else 
            local path = (Configs and Configs.SaveOrbitPath or "") or ""
            filename = string.format("%s/%s.json", path, name)
        end

        TFOrbit:LoadFromFile(filename)
    end
    return BulletCache:GetOrbit(name)
end

function TFOrbit:LoadFromFile(filename)
    if TFFileUtil:existFile(filename) then 
        local content = io.readfile(filename) or "{}"
        local info = json.decode(content) or {}

        if BulletCache:GetOrbit(info.FileName) then 
            print("已存在同名轨迹!!!")
        else 
            local item = TFOrbit:create(info.FileName)
            item:OnLoad(info)
        end
    end
end

function TFOrbit:OnLoad(info)
    self.Configs = {}
    for idx, config in ipairs(info.Configs or {}) do 
        local cfg = OrbitConfig:create()
        table.insert(self.Configs, cfg:OnLoad(config))
    end
    self:buildPoints()
end

function TFOrbit:Remove()
    BulletCache:RemoveOrbit(self)
end

function TFOrbit:buildPoints()   
    local lastPos
    local dirty = false
    local lastConfig
    for idx, config in ipairs(self.Configs) do 
        if config.polyDirty or dirty then 
            config:rebuild(lastConfig and lastConfig.CurVel or nil, lastConfig and lastConfig.points[#lastConfig.points] or nil)
            config.polyDirty = false
            dirty = true
        end
        lastConfig = config
    end
    
    if dirty then 
        local beg = ccp(0, 0)
        self.points = { [0] = ccp(0, 0) }
        for idx, config in ipairs(self.Configs) do 
            lastPos = config.points[1]            
            if lastPos.x == 0 and lastPos.y == 0 then 
                beg = self.points[#self.points]
            end
            for idx, point in ipairs(config.points) do 
                if idx > 2 then 
                    table.insert(self.points, point + beg)-- - lastPos)
                    lastPos = point
                end
            end
            if lastPos.x ~= 0 and lastPos.y ~= 0 then 
                beg = lastPos
            end
        end
    end
end

function TFOrbit:GetPointAt(index)  
    index = index or 0
    return self.points[index]
end

BulletCache = {
    list = {},
    unCached = {},
    toRemoveBullet = {},
    orbitCache = {},
    orbitCacheWithName = {},
    forces = {},
    rebounds = {},
    TID = -1,
    TimeScale = 1,
    isStop = false,
    _onBltPos = nil,
    _onBrgPos = nil,
    _onOrbitName = nil,
}

function BulletCache:PreCache(path, count)
    count = count or 100
    local list = {}
    for i = 1, count do 
        local bullet = BulletCache:Get(path)
        table.insert(list, bullet)
    end
    for i = 1, count do 
        local bullet = list[i]
        BulletCache:RecycleImpl(bullet)
    end
end

function BulletCache:Get(path)
    if not path then path = "" end

    --path = "res/fly/effects_20301_skillA1"
    self.list[path] = self.list[path] or {}
    local cache = self.list[path]
    local count = #cache
    local bullet
    if count == 0 or count == 1 then 
        if count == 0 then 
            bullet = SkeletonAnimation:create(path)
            bullet:retain()
            table.insert(cache, bullet)
            -- BulletCache:PreCache(path, 100)
        end
        bullet = cache[1]:clone()
        bullet:retain()

        bullet.__Path = path
        if COLLISION_DEBUG then
            bullet.debugNode = TFDrawNode:create()
            bullet.debugNode:retain()
        end
    else 
        bullet = cache[count]
        bullet:Pos(0, 0)
        table.remove(cache, count)
    end

    if self.isStop then         
        bullet:stop()
    else      
        bullet:resume()
    end

    self.unCached[bullet] = true
    return bullet
end

function BulletCache:RecycleImpl(bullet)
    local path      = bullet.__Path or ""
    bullet.owner    = nil
    bullet.collide  = nil
    bullet.extInfo  = nil
    bullet.padding  = nil
    if bullet:getParent() then 
        bullet:removeFromParent(false)
    end

    -- bullet:stop()
    if COLLISION_DEBUG and bullet.debugNode and bullet.debugNode:getParent() then
        bullet.debugNode:removeFromParent()
	    -- bullet.debugNode = nil
    end
    self.list[path] = self.list[path] or {}

    table.insert(self.list[path], bullet)
    self.unCached[bullet] = nil
end

function BulletCache:Recycle(bullet)
    if not bullet then return end
    self.toRemoveBullet[bullet] = true
    if COLLISION_DEBUG and bullet.debugNode then
        bullet.debugNode:clear()
    end
end

function BulletCache:RecycleByOwner(owner)
    if not owner then return end
    local count = 0
    for bullet in pairs(self.unCached) do 
        if bullet.owner == owner then 
            count = count + 1
            BulletCache:Recycle(bullet)
        end
    end 
    return count 
end

function BulletCache:AddForceField(force)
    self.forces[force] = true
end

function BulletCache:RemoveForceField(force)
    self.forces[force] = false
end

function BulletCache:AddReboundPlate(rebound)
    self.rebounds[rebound] = true
end

function BulletCache:RemoveReboundPlate(rebound)
    self.rebounds[rebound] = false
end

function BulletCache:SetBulletPositionChangeHandle(handle)
    self._onBltPos = handle
end

function BulletCache:SetBarragePositionChangeHandle(handle)
    self._onBrgPos = handle
end

function BulletCache:SetOnEmitHandle(handle)
    self._onEmit = handle
end

function BulletCache:AddOrbit(orbit)
    self.orbitCache[orbit] = true
    self.orbitCacheWithName[orbit.FileName] = orbit
end

function BulletCache:RemoveOrbit(orbit)
    self.orbitCache[orbit] = nil
    self.orbitCacheWithName[orbit.FileName] = nil
end

function BulletCache:RemoveOrbitWithName(name)
    local orbit = self:GetOrbit(name)
    if orbit then 
        self.orbitCache[orbit] = nil
        self.orbitCacheWithName[name] = nil
    end
end

function BulletCache:GetOrbit(name)
    return self.orbitCacheWithName[name]
end

function BulletCache:GetBulletCount(owner)
    local count = 0
    for bullet in pairs(self.unCached) do 
        if bullet.owner == owner then 
            count = count + 1
        end
    end 
    return count 
end

function BulletCache:ChangeOrbitName(orbit, name)
    local curName = orbit.FileName

    if curName == name then return end
    if self.orbitCacheWithName[name] then 
        if ImGui then 
            ImGui.Toast("命名重复!!!", bgcolor, fcolor)
        end
        return
    end

    self.orbitCacheWithName[curName] = nil
    self.orbitCacheWithName[name] = orbit
    orbit.FileName = name
end

local PADDING = 200
function BulletCache:SetPadding(pad)
    PADDING = pad or 10
end

function BulletCache:Update(dt)
    local winSize = me.EGLView:getFrameSize()
    local winWidth = winSize.width
    local winHeight = winSize.height
    
    for rebound, valid in pairs(self.rebounds) do 
        if valid then 
            rebound:Update(dt)
        end
    end 
    for force, valid in pairs(self.forces) do 
        if valid then 
            force:Update(dt)
        end
    end 

    for bullet in pairs(self.unCached) do 
        local orbit = bullet.orbit
        if orbit then 
            bullet.elapse = bullet.elapse + 1
            local elapse = bullet.elapse

            local lpos = orbit:GetPointAt(elapse - 1)
            local pos = orbit:GetPointAt(elapse)
            if pos and lpos then 
                local seekPos = pos - lpos 
                seekPos = ccp(seekPos.x, 0 - seekPos.y)
                local CurAngle = seekPos:toAngle() / math.pi * 180

                bullet:Rotate(-CurAngle)
                bullet.vel = seekPos * 60         
                local position = bullet.position + seekPos
                bullet.position = position
                bullet:Pos(bullet.position)

                -- bullet.lastPos  = ccp(bullet.position)

            elseif bullet.elapse > #orbit.points then 
                bullet.orbit = nil
            end
        else  
            local rot
            for rebound, valid in pairs(self.rebounds) do 
                if valid then 
                    rot = rebound:ApplyBulleft(bullet)
                    if rot then break end
                end
            end 

            local acc = bullet.acc
            for force, valid in pairs(self.forces) do 
                if valid then 
                    acc = force:ApplyBulleft(bullet, acc)
                end
            end   
            bullet.vel = bullet.vel + acc * ELASE_FPS_FLOAT
            bullet.lastPos  = bullet.position
            local position  = bullet.position + bullet.vel * ELASE_FPS_FLOAT
            bullet.position = position
            bullet:Pos(bullet.position)    
            if rot then
                bullet:Rotate(rot)
            else                 
                local bpos  = bullet.position
                local lpos  = bullet.lastPos                
                local A     = bpos - lpos

                local rot   = 0 - me.pToAngleSelf(A) / math.pi * 180
                bullet:Rotate(rot)
            end
        end

        local isOut = false
        if bullet:isVisiting() then 
            local wpos = bullet:getWorldPosition()

            local p = bullet.padding
            local w = winWidth + p
            local h = winHeight + p

            if wpos.x > w or wpos.x < -p or wpos.y > h or wpos.y < -p then 
                BulletCache:Recycle(bullet)
                isOut = true
            end
        end
        if not isOut and self._onBltPos then
            drawDebugNode(bullet)
            self._onBltPos(bullet)
        end
    end

    for bullet in pairs(self.toRemoveBullet) do 
        BulletCache:RecycleImpl(bullet)
    end
    self.toRemoveBullet = {}
    
    local toRemoveForces = {}
    for force, valid in pairs(self.forces) do 
        if not valid then 
            toRemoveForces[force] = true
        end
    end
    for force, valid in pairs(toRemoveForces) do 
        self.forces[force] = nil
    end
    
    local toRemoveRebounds = {}
    for rebound, valid in pairs(self.rebounds) do 
        if not valid then 
            toRemoveRebounds[rebound] = true
        end
    end
    for rebound, valid in pairs(toRemoveRebounds) do 
        self.rebounds[rebound] = nil
    end
end

function BulletCache:Clear(imt)
    local outBullet = {}
    for bullet in pairs(self.unCached) do 
        table.insert(outBullet, bullet)
    end
    for k, bullet in ipairs(outBullet) do 
        BulletCache:Recycle(bullet)
    end

    if imt then 
        for bullet in pairs(self.toRemoveBullet) do 
            BulletCache:RecycleImpl(bullet)
        end
        self.toRemoveBullet = {}
    end
    -- print("BulletCache:Dispose => Recycle:", #outBullet)
end

function BulletCache:Dispose(clean)
    self.TimeScale = 1
    BulletCache:Clear()

    if clean then         
        for bullet in pairs(self.toRemoveBullet) do 
            BulletCache:RecycleImpl(bullet)
        end

        for bullet in pairs(self.unCached) do 
            bullet:release()
            if COLLISION_DEBUG and bullet.debugNode then
                bullet.debugNode:release()
            end
        end
        self.unCached = {}
        self.toRemoveBullet = {}
    end
end

local Director_runWithScene = me.Director.runWithScene
me.Director.runWithScene = function(...)
    BulletCache:Dispose()
    Director_runWithScene(...)
end

local Director_replaceScene = me.Director.replaceScene
me.Director.replaceScene = function(...)
    BulletCache:Dispose()
    Director_replaceScene(...)
end

function BulletCache:SetTimeScale(scale)
    scale = scale or 1
    self.TimeScale = scale
end

function BulletCache:Stop(isEditor)
    self.isStop = true
    self.isEditor = isEditor
    
    for bullet in pairs(self.unCached) do 
        bullet:stop()
    end
end

function BulletCache:Resume(isEditor)
    self.isStop = false
    self.isEditor = isEditor

    for bullet in pairs(self.unCached) do 
        bullet:resume()
    end
end

function BulletCache:AimAtPos(bullet, pos)
    local bpos      = bullet.position 
    local tarDir    = pos - bpos
    
    local ndir      = tarDir:normalize()
    bullet.vel      = ndir * bullet.vel:length()
    bullet.acc      = ndir * bullet.acc:length()
    
    -- local a2 = me.pNormalize(bullet.vel)
    -- local b2 = me.pNormalize(tarDir)
    -- local angle = math.atan2(me.pCross(a2, b2), me.pDot(a2, b2))

    -- if math.abs(angle) < MinLerpAngle then 
    --     local ndir  = tarDir:normalize()
    --     bullet.vel  = ndir * bullet.vel:length()
    --     bullet.acc  = ndir * bullet.acc:length()
    --     return
    -- end    

    -- angle           = angle * dt
    -- if math.abs(angle) < MinLerpAngle then angle = MinLerpAngle end

    -- local x         = bullet.vel.x
    -- local y         = bullet.vel.y
    -- local ca        = math.cos(angle)
    -- local sa        = math.sin(angle)
    -- local nx        = x * ca - y * sa  
    -- local ny        = x * sa + y * ca
    
    -- local ndir      = ccp(nx, ny):normalize()
    -- bullet.vel      = ndir * bullet.vel:length()
    -- bullet.acc      = ndir * bullet.acc:length()

    -- local disDir    = (tarDir - bullet.vel) * dt
    -- local ndir      = bullet.vel + disDir

    -- ndir            = ndir:normalize()
    -- bullet.vel      = ndir * bullet.vel:length()
    -- bullet.acc      = ndir * bullet.acc:length()
end

function BulletCache:init()
    TFDirector:removeEnterFrameEvent(self.TID)

    local elapse = 0
    self.TID = function(dt)
        if self.isStop or self.isEditor then return end
        dt = math.min(dt, 0.1)    
        elapse = elapse + dt * 1000 * math.abs(self.TimeScale)

        while elapse >= ELASE_FPS do 
            self:Update(ELASE_FPS)
            elapse = elapse - ELASE_FPS
        end
    end 
    TFDirector:addEnterFrameEvent(self.TID)
end
BulletCache:init()

local RoundTick = class("RoundTick")
function RoundTick:ctor(config)
    self.config     = config
    self.TickFrame  = (config.Bullet.Interval or 1)
    self.MinFrame   = config.Config.Frame.x
    self.MaxFrame   = config.Config.Frame.y
    self.CurFrame   = 0
    self.Frame      = -1
end

function RoundTick:Update(time)
    local frame = time
    if frame == 0 and not self.config.Config.ZeroShot then return false end
    if math.mod(frame, self.TickFrame) == 0 then 
        return true
    end
    return false
end

local function EmptyRotFunc() return 0 end
local EmitTick = class("EmitTick")
function EmitTick:ctor(config, Direction, Vec, rotFunc, velFunc, CurPos, owner)
    self.config     = config
    self.owner      = owner or {}
    self.Number     = 0
    self.Radius     = config.Radius or 0
    self.rotFunc    = rotFunc or EmptyRotFunc
    self.velFunc    = velFunc

    self.Acc        = config.Acc or 0 
    self.Scale      = config.Scale or 1
    self.Direction  = (Direction or 0)
    self.Vec        = Vec or ccp(0, 0)
    self.Pos        = CurPos or ccp(0, 0)
end

function EmitTick:doEmit()
    local bullet = BulletCache:Get(self.config.Path)
    bullet:playByIndex(0, 1)
    
    bullet:setRotation(-self.Direction)
    bullet.orbit    = BulletCache:GetOrbit(self.config.Style)
    bullet.elapse   = 0
    bullet.vel      = self.velFunc and self.velFunc(self.Direction) or self.Vec
    local nvel      = bullet.vel:normalize()
    bullet.acc      = nvel * self.Acc
    bullet.position = self.Pos + nvel * self.Radius
    bullet.lastPos  = ccp(bullet.position)
    bullet.owner    = self.owner
    bullet.extInfo  = {}
    bullet.CanPenet = self.config.CanPenet
    bullet.isFindOnce      = self.config.isFindOnce or false
    bullet.isFindAlways    = self.config.isFindAlways or false
    bullet.ChooseTarget    = self.config.ChooseTarget or 0
    bullet.padding         = self.config.Padding or 10
    bullet          : Scale(self.Scale)

    self.Direction  = self.Direction + self.rotFunc()
    return bullet
end

function EmitTick:Update(dt)
    if self.Number >= self.config.Number then 
        return false
    end
    self.Number = self.Number + 1
    return true
end

function EmitTick:Tick(dt)
    return self.Number < self.config.Number
end

local BaseEmiter = class("BaseEmiter")
function BaseEmiter:ctor(config, container, pos, owner)
    self.config             = config
    self.container          = container
    self.owner              = owner or {}
    self.bullets            = {}
    self.emiters            = {}
    self.delEmiters         = {}
    
    self.pos                = pos or ccp(0, 0)
    self.angle              = config.Config.Angle or 0

    self.TimeElapse         = -1
    self.SilenceTime        = config.Config.Frame.x
    self.Duration           = config.Config.Frame.y - config.Config.Frame.x + 1
    self.TotalTime          = self.SilenceTime + self.Duration 
    self.CurAngle           = self.angle
    self.AngleRotateSpeed   = config.Config.AngleRotateSpeed * 6
    self.MoveAngle          = -config.Config.MoveAngle or 0
    self.MoveVel            = me.pForAngle(self.MoveAngle / 180 * math.pi) * (config.Config.MoveVel or 0)
    self.CurPos             = ccp(self.pos)

    self.BulletVel          = config.Bullet.Vel or 1
    self.BulletAngle        = config.Bullet.Angle or 0

    self.RoundTick          = RoundTick:new(config)
    self.Number             = config.Bullet.Count
    self.Radius             = config.Bullet.Radius or 0
end

function BaseEmiter:Reset(config)
    self.config             = config or self.config
    config                  = self.config
    self.angle              = config.Config.Angle or 0
    
    self.emiters            = {}
    self.delEmiters         = {}
    self.IsDone             = false

    self.TimeElapse         = -1
    self.SilenceTime        = config.Config.Frame.x
    self.Duration           = config.Config.Frame.y - config.Config.Frame.x + 1
    self.TotalTime          = self.SilenceTime + self.Duration 
    self.CurAngle           = self.angle
    self.AngleRotateSpeed   = config.Config.AngleRotateSpeed * 6
    self.MoveAngle          = -config.Config.MoveAngle or 0
    self.MoveVel            = me.pForAngle(self.MoveAngle / 180 * math.pi) * (config.Config.MoveVel or 0)
    self.CurPos             = ccp(self.pos)
    
    self.RoundTick          = RoundTick:new(config)
    self.Number             = config.Bullet.Count
    self.Radius             = config.Bullet.Radius or 0
end

function BaseEmiter:doRound()
    
end

function BaseEmiter:UpdatePos(pos)
    self.pos = pos
end

function BaseEmiter:UpdateEmiterConfig(time)
    local orbit = TFOrbit:LoadFromName(self.config.Config.MoveStyle)
    if orbit then 
        if time == 0 then 
            self.CurPos = ccp(self.pos)
            self.CurAngle = self.angle
        else 
            local lpos = orbit:GetPointAt(time - 1)
            local pos = orbit:GetPointAt(time)
            if pos and lpos then 
                local seekPos = pos - lpos 
                pos = ccp(pos.x, 0 - pos.y)
                self.CurAngle = seekPos:toAngle() / math.pi * 180
                self.CurPos = self.pos + pos
            end
        end
        if not self.config.Config.IsUseStyleAngle then 
            self.CurAngle = self.angle
        end
    else 
        self.CurPos = self.pos + self.MoveVel * time * ELASE_FPS_FLOAT
        self.CurAngle = self.angle + self.AngleRotateSpeed * time * ELASE_FPS_FLOAT
    end
    
    if BulletCache._onBrgPos then 
        BulletCache._onBrgPos(self.owner, self.CurPos, self.CurAngle)
    end
end

function BaseEmiter:UpdateEmiters(time)
    if #self.emiters == 0 then return end
    local hasDel = false
    for i = 1, #self.emiters do 
        local emiter = self.emiters[i]        
        if emiter:Tick(time) then 
            local list = {}
            while emiter:Update(time) do 
                local bullet = emiter:doEmit()
                if bullet then 
                    bullet:Pos(bullet.position)

                    local container = self.container[bullet.__Path]
                    if not container then 
                        container = CCNode:create()
                        self.container:addChild(container)
                        self.container[bullet.__Path] = container
                    end

                    container:addChild(bullet)
                    if COLLISION_DEBUG and bullet.debugNode then
                        self.container:addChild(bullet.debugNode, 999)
                    end

                    table.insert(list, bullet)
                end
            end
            
            if self.owner._onEmit then 
                self.owner._onEmit(self.owner, self.config, 1, list)
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

function BaseEmiter:ApplyTime()
    local time = self.TimeElapse - self.SilenceTime

    -- time = math.mod(time, self.Duration)
    if time < 0 then-- or time > self.Duration then 
        return false
    end

    self:UpdateEmiterConfig(time)
    if not BulletCache.isStop and self.RoundTick:Update(time) then 
        if self.owner._onEmit then 
            self.owner._onEmit(self.owner, self.config, 0, nil)
        end
        self:doRound(self.CurPos, self.CurAngle) 
    end
    self:UpdateEmiters(time)
    return true
end

function BaseEmiter:Update(dt)
    if self.isStop then return end
    local sig = 1
    if dt < 0 then sig = -1 end

    self.TimeElapse = self.TimeElapse + sig
    local isOK = true
    if self.TimeElapse > self.TotalTime then 
        if self.config.Config.isLoop then 
            self.TimeElapse = math.mod(self.TimeElapse, self.TotalTime + 1)
        else 
            self.TimeElapse = self.TotalTime
            isOK = false
            if self.owner._onEmitComplete then 
                self.owner._onEmitComplete(self.owner)
            end
            -- self.owner:Stop()
            self.isStop = true
        end
    end

    if self.TimeElapse < 0 then self.TimeElapse = self.TimeElapse + self.TotalTime end
    -- return self:ApplyTime(self.TimeElapse)
    return self:SetTime(self.TimeElapse), isOK
end

function BaseEmiter:SetTime(time, isEditor, isOut)
    self.TimeElapse = time or 0  
    if isOut then return false end
    if isEditor and self.TimeElapse > self.TotalTime then self.TimeElapse = self.TotalTime end
    if self:ApplyTime() then
        return true
    else 
        time = self.TimeElapse - self.SilenceTime
        if time < 0 then 
            self.CurPos = ccp(self.pos)
            self.CurAngle = self.angle
        else 
            self.CurPos = self.pos + self.MoveVel * self.Duration * 0.001 * ELASE_FPS
            self.CurAngle = self.angle + self.AngleRotateSpeed * self.Duration * 0.001 * ELASE_FPS
        end
        return false
    end
end

function BaseEmiter:Dispose()
    local count = #self.bullets
    for i = 1, count do 
        local bullet = self.bullets[i]
        BulletCache:Recycle(bullet)
    end
    self.bullets = {}

    -- print("Dispose:", count)
end

local FanEmiter = class("FanEmiter", BaseEmiter)
function FanEmiter:ctor(config, container, emitPos, owner)
    FanEmiter.super.ctor(self, config, container, emitPos, owner)
end

function FanEmiter:doRound(CurPos, CurAngle)
    local dir = -CurAngle or 0
    local vecX = self.BulletVel
    local vec = me.pForAngle(dir / 180 * math.pi) * vecX

    local rotFunc = nil
    if self.Number > 1 then 
        local angle = self.BulletAngle
        local rot = angle / 2
        local rotSeek = - angle / (self.Number - 1)
        dir = dir + rot

        rotFunc = function()
            return rotSeek
        end
    end

    local velFunc = function(rot)
        return me.pForAngle(rot / 180 * math.pi) * vecX
    end
    table.insert(self.emiters, EmitTick:create({ 
        Number  = self.Number, 
        Radius  = self.Radius,
        Path    = self.config.Bullet.Path, 
        Style   = self.config.Bullet.Style,
        Scale   = self.config.Bullet.Scale or 1,
        Acc     = self.config.Bullet.Acc or 0,
        CanPenet= self.config.Bullet.CanPenet or false,
        Padding = self.config.Bullet.Padding or 200,
        
        isFindOnce      = self.config.Bullet.isFindOnce or false,
        isFindAlways    = self.config.Bullet.isFindAlways or false,
        ChooseTarget    = self.config.Bullet.ChooseTarget or 0,
    }, dir, vec, rotFunc, velFunc, CurPos, self.owner))
end


TFBarrageEx = class("TFBarrageEx", function()
    local node = CCNode:create()
    if Editor and Editor.TimelineView then 
        node = TFImage:create("editor/barrage.png"):Size(25, 25)
    end
    return node
end)

function TFBarrageEx:ctor(bulletContainer, bcfg, notUpdate)
    local path = "res/fly/effects_20301_skillA1"
    bcfg = bcfg or {
        Config = {
            Point = "",                 -- 发射器绑定的发射者的点
            Frame = { x = 0, y = 200 }, -- 发射器开始产生弹幕的时间段，单位帧
            Angle = 180,                -- 发射器的初始朝向，正右为0，顺时针增长，单位 °
            AngleRotateSpeed = 6,       -- 在发射过程中发射器的自转，顺时针为正，单位圈/分钟
            MoveVel = 100,              -- 发射器在生效期间的移动速度，单位像素/秒
            MoveAngle = 30,             -- 发射器移动的方向，单位 °
            MoveStyle = "",             -- 轨迹方案
            IsUseStyleAngle = false,    -- 是否使用轨迹朝向
            AngleRotate = 0,
            AngleRotateFrame = 0,
            CanFollow = false,
            isLoop = true,
            Path = "",
            EffectOffset = { x = 0, y = 0 },
        },
        Bullet = {
            CanPenet = false,
            Count = 13,                  -- 发射器一共发射几条单链
            Angle = 360,                 -- 以发射器的正方向做扇形区间，之后将单链均分在扇形区间中
            Interval = 10,               -- 发射器每条单链发射一次子弹的间隔时间，单位帧
            Radius = 0,                  -- 子弹在距离发射器多远的地方开始生成，单位像素
            Vel = 400,                   -- 子弹飞行速度，单位像素/秒
            Acc = 0,
            Style = "",
            Path = path,
            Scale = 1,
            isFindOnce = false,
            isFindAlways = false,
            ChooseTarget = 0,
            Padding = 10,
        }
    }

    self.config = { bcfg }
    
    self._onEmit = nil
    self._onEmitComplete = nil

    self.owner = nil
    self.isStop = false
    self.elapse = 0
    self.bulletContainer = bulletContainer or me.Director:getRunningScene()
    -- self.bulletContainer:addChild(self)

    self.effect = nil
    self:ChangeEffect(bcfg.Config.Path)
    self:ChangeEffectPos(bcfg.Config.EffectOffset)

    self.emiters = {}

    self:init(notUpdate)
end

function TFBarrageEx:ChangeEffect(path)
    -- print("ChangeEffect:", path)
    if not path or path == "" then return end 
    if not self.effect then 
        self.effect = SkeletonAnimation:create(path)
        self:addChild(self.effect)
        self.effect:playByIndex(0, 1)
        
        if #self.config > 0 then 
            self:ChangeEffectPos(self.config[1].Config.EffectOffset)
        end
    else 
        self.effect:setFile(path)
        self.effect:playByIndex(0, 1)
    end
end

function TFBarrageEx:ChangeEffectPos(pos)
    if not pos then return end 
    if self.effect then 
        self.effect:Pos(pos)
    end
end

function TFBarrageEx:SetOnEmitHandle(handle)
    self._onEmit = handle
end

function TFBarrageEx:SetOnEmitCompleteHandle(handle)
    self._onEmitComplete = handle
end

function TFBarrageEx:SetOwner(owner)
    self.owner = owner
end

function TFBarrageEx:GetFirePos(point)
    return self:Pos()
end

function TFBarrageEx:UpdateEmitPos(pos)
    for i, v in ipairs(self.emiters) do
        v:UpdatePos(pos)
    end
end

function TFBarrageEx:init(notUpdate)
    if notUpdate then return end

    self:OnFrame(function(sender, dt)
        if self.isStop then return end

        dt = math.min(dt, 0.1) * BulletCache.TimeScale       
        self.elapse = self.elapse + dt*1000

        local valid = true
        local sig = math.abs(self.elapse) / self.elapse
        while math.abs(self.elapse) >= ELASE_FPS and valid do 
            valid = self:Update(ELASE_FPS * sig)
            self.elapse = self.elapse - ELASE_FPS * sig
        end

        -- if not valid then 
        --     self:removeFromParent(true)
        -- end
    end)  
end

function TFBarrageEx:Reset(config)
    config = config or self.config or {}

    self:Emit(config)

    for idx, emiter in ipairs(self.emiters) do 
        emiter:Reset(config[1])

        self:Rotate(emiter.CurAngle)
        self:Pos(emiter.CurPos)
    end
end

function TFBarrageEx:Stop()
    self.isStop = true
end

function TFBarrageEx:Resume()
    self.isStop = false
end

function TFBarrageEx:SetTime(time, isEditor, isOut)
    time = time or 0
    for idx, emiter in ipairs(self.emiters) do 
        emiter:SetTime(time, isEditor, isOut)
        self:Rotate(emiter.CurAngle)
        self:Pos(emiter.CurPos)
    end
end

function TFBarrageEx:Update(dt)
    local valid = false
    for idx, emiter in ipairs(self.emiters) do 
        local activate, ok = emiter:Update(dt)
        valid = valid or ok
        self:Rotate(emiter.CurAngle)
        self:Pos(emiter.CurPos)
    end
    return valid
end

function TFBarrageEx:Emit(config)
    self.config = config or self.config
    self.emiters = {}
    self:Resume()
    if #self.config > 0 then 
        for i = 1, #self.config do 
            local emiter = self:FanEmit(self.config[i]) 
            self:ChangeEffect(self.config[i].Config.Path)
            
            self:Rotate(emiter.CurAngle)
            self:Pos(emiter.CurPos)
        end
    end
end

function TFBarrageEx:ResetPos()
    if #self.emiters > 0 then 
        for i = 1, #self.emiters do 
            local emiter = self.emiters[i]
            
            self:Rotate(emiter.angle)
            self:Pos(emiter.pos)
        end
    end
end

-- 2:扇形
function TFBarrageEx:FanEmit(config)
    local emiter = FanEmiter:create(config, self.bulletContainer, self:GetFirePos(config.Bullet.Point), self)
    table.insert(self.emiters, emiter)
    return emiter
end

return TFBarrageEx