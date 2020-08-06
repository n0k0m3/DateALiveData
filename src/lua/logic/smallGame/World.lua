-- local UILogicManager = require("common.UILogicManager")
-- local Building = require("LuaScript.scene.entry.layer.box2d.DDTXFightBuilding")

local PTM = 100

local World = class("World", function(...)
    local layer = TFPanel:create()
    return layer
end)


local groupID = 0
local function getGroupID()
    groupID = groupID + 1
    return groupID
end

velocityIterations = 8
positionIterations = 8
a = nil
function World:updateWorld(world, dt)
    world:Step(dt, velocityIterations, positionIterations)
    world:DrawDebugData()

    local body = world:GetBodyList()
    local pos, target
    --while body and not a do
        --target = body:GetUserData()
        --print(target)
        --if target then
        --  --pos = target:getPosition()
        --end
        --body = body:GetNext()
    --end
    --if not a then
        --for v in BuildingManager.buildings:iterator() do
        --  if v.target and v.target.body then
        --      pos = v.target:getPosition()--v.position
        --      --print('==> ', pos.x, pos.y)
        --      pos = v.target:convertToWorldSpace(pos)
        --      --print('\t==> ', pos.x, pos.y)
        --  end
        --end
    --end
    a = 1
end

local function b2Vec2MulNumber(v, n)
    local x = v.x * n
    local y = v.y * n
    return b2Vec2(x, y)
end

local function b2Vec2Mulb2Vec2(v1, v2)
    local x = v1.x * v2.x
    local y = v1.y * v2.y
    return b2Vec2(x, y)
end

local function b2Vec2Addb2Vec2(v1, v2)
    local x = v1.x + v2.x
    local y = v1.y + v2.y
    return b2Vec2(x, y)
end

function World:getTrajectoryPoint(startingPosition, startingVelocity, n)
    local t = 1 / 60.0
    local stepVelocity = b2Vec2MulNumber(startingVelocity, t)
    local stepGravity = b2Vec2MulNumber(self.world:GetGravity(), t * t)
    local sg = b2Vec2MulNumber(stepGravity, 0.5 * (n*n+n))
    local sv = b2Vec2MulNumber(stepVelocity, n)
    local s = b2Vec2Addb2Vec2(sg, sv)
    return b2Vec2Addb2Vec2(s, startingPosition);
end

function World:drawLines(startingPosition, startingVelocity, gid)
    local world = self.world
    if self.dBody then
        world:DestroyBody(self.dBody)
    end
    self.bf = b2BodyDef()

    local body = world:CreateBody(self.bf)
    self.dBody = body

    local raycastCallback = MERayCastCallback()
    local function rayHandle(fixture, point, normal, fraction)
        local body = fixture:GetBody()
        local userData = body:GetUserData()
        raycastCallback.m_hit = true
        raycastCallback.m_point = point
        raycastCallback.m_normal = normal
        return fraction
    end
    raycastCallback:registerScriptHandle(rayHandle)

    local lastTP = startingPosition
    local inc = 1
    local i = 1
    while inc < 35 do
        local pos = self:getTrajectoryPoint(startingPosition, startingVelocity, i)

        world:RayCast(raycastCallback, lastTP, pos);
        if raycastCallback.m_hit then
            break
        end
        lastTP = pos


        local shape = b2CircleShape()
        shape.m_radius = 9 * ((inc) / 15) / PTM
        shape.m_p:Set(pos.x, pos.y - 0 / PTM)
        local fixDef = b2FixtureDef()
        fixDef.shape = shape
        fixDef.filter.groupIndex    = gid
        fixDef.filter.categoryBits = 0x1001
        fixDef.filter.maskBits = 0x1001

        body:CreateFixture(fixDef)
        i = i + inc
        inc = inc + 1
    end
end

function World:onTouchBegan(pos)
    self.prePose = pos
end

function World:onTouchMoved(pos)
    local curVec = ccpSub(pos, self.prePose)
    local len = ccpLength(curVec)
    curVec.x = curVec.x / len * 100
    curVec.y = curVec.y / len * 100
    self:drawLines(b2Vec2(200 /PTM, 100 /PTM), b2Vec2(curVec.x * 10/PTM, curVec.y * 10/PTM), 7)
end

function World:onTouchEnded(pos)

end

function World:initWidget()
    self.panel          = MEPanel:create()
    self:addChild(self.panel)

    local info = {templateID=14, gridX=5, gridY=5}
    info.world = self.world
    local building = Building:new(info)
    self.panel:addChild(building)


    local info = {templateID=14, gridX=6, gridY=5}
    info.world = self.world
    local building = Building:new(info)
    self.panel:addChild(building)


    local info = {templateID=14, gridX=7, gridY=5}
    info.world = self.world
    local building = Building:new(info)
    self.panel:addChild(building)


    local info = {templateID=4, gridX=6, gridY=10}
    info.world = self.world
    local building = Building:new(info)
    self.panel:addChild(building)


end

function World:initBodies()
    self:setPosition(ccp(650 * (PTM - 1), 390 * (PTM - 1)))
    self:setScale(PTM)
    local world = self.world

    local position = b2Vec2()
    local bf = b2BodyDef()
    local body = world:CreateBody(bf)

    position:Set(650 / PTM, 50 / PTM)
    local shape = b2PolygonShape()
    shape:SetAsBox(500 / PTM, 10 / PTM, position, 0)--30 / 180 * 3.1415926)
    local fixDef = b2FixtureDef()
    fixDef.shape = shape
    fixDef.density = 1
    fixDef.restitution = 0
    --fixDef.friction = 1
    fixDef.filter.groupIndex    = getGroupID()
    fixDef.filter.categoryBits = 0x1001
    fixDef.filter.maskBits = 0x1001

    body:CreateFixture(fixDef)

    position:Set(650 / PTM, 650 / PTM)
    local shape = b2PolygonShape()
    shape:SetAsBox(500 / PTM, 10 / PTM, position , 0)
    local fixDef = b2FixtureDef()
    fixDef.shape = shape
    fixDef.density = 1.0
    --fixDef.friction = 1
    fixDef.filter.groupIndex    = getGroupID()
    fixDef.filter.categoryBits = 0x1001
    fixDef.filter.maskBits = 0x1001

    body:CreateFixture(fixDef)

    position:Set(140 / PTM, 350 / PTM)
    local shape = b2PolygonShape()
    shape:SetAsBox(10 / PTM, 300 / PTM, position , 0)
    local fixDef = b2FixtureDef()
    fixDef.shape = shape
    fixDef.density = 1.0
    --fixDef.friction = 1
    fixDef.filter.groupIndex    = getGroupID()
    fixDef.filter.categoryBits = 0x1001
    fixDef.filter.maskBits = 0x1001

    body:CreateFixture(fixDef)

    position:Set(1150 / PTM, 350 / PTM)
    local shape = b2PolygonShape()
    shape:SetAsBox(10 / PTM, 300 / PTM, position , 0)
    local fixDef = b2FixtureDef()
    fixDef.shape = shape
    fixDef.density = 1.0
    --fixDef.friction = 1
    fixDef.filter.groupIndex    = getGroupID()
    fixDef.filter.categoryBits = 0x1001
    fixDef.filter.maskBits = 0x1001

    body:CreateFixture(fixDef)


    local bf = b2BodyDef()
    bf.position:Set(200 /PTM, 100 /PTM)
    bf.linearVelocity:Set(500/PTM, 800/PTM)
    --bf.type = b2_dynamicBody
    --bf.angularVelocity = -1000/PTM
    local body = world:CreateBody(bf)

    local shape = b2CircleShape()
    shape.m_radius = 10 / PTM

    local fixDef = b2FixtureDef()
    fixDef.shape = shape
    fixDef.density = 1.0
    --fixDef.friction = 1
    fixDef.restitution = 1.0
    local gid = getGroupID()
    fixDef.filter.groupIndex    = 7
    fixDef.filter.categoryBits = 0x1001
    fixDef.filter.maskBits = 0x1001

    body:CreateFixture(fixDef)

    self:drawLines(b2Vec2(200 /PTM, 100 /PTM), b2Vec2(500/PTM, 800/PTM), gid)
end

function World:ctor(...)
    local grt = b2Vec2(0, -9.8)

    self.world          = b2World(grt)
    self.world          : SetAllowSleeping(true)
    self.world          : SetContinuousPhysics(true)

    MEBox2DHelper       : initWorld(self.world)

    self                : setB2World(self.world)

    self:initBodies()

    --self:initWidget()
    MEDirector          : addEnterFrameEvent(World.updateWorld, self, self.world)
end

return World