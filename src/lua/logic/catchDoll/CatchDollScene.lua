local CatchDollScene = class("CatchDollScene", BaseScene)

-- 整个娃娃机状态
local status = {
    left = 1, --娃娃机向左移动
    right = 2, --娃娃机向右移动
    catch = 3, -- 抓娃娃

    wait = 4, -- 等待抓到的玩具下落

    idle = 5, -- 空闲
}

-- 爪子的状态
local clampsStatus = {
    open = 1, --张开
    close = 2, -- 闭合
    idle = 3, --空闲
}

-- 娃娃机运动状态
local headStatus = {
    up = 1, --向上
    down = 2, --向下

    slowDown = 3, -- 减速抓取
    left = 4, -- 向左放下抓到的玩具

    idle = 5, -- 静止
}

-- 用来描述娃娃机固定的几个点位
local headPos = {
    left = nil, -- 抓娃娃时最左边的坐标
    right = nil, --  抓娃娃时最右边的坐标

    up = nil, -- 娃娃机可到达最高坐标
    down = nil, -- 娃娃机可到达最低坐标

    maxLeft = nil, -- 娃娃机起始位置最左边
}

-- 墙壁坐标
local wallPos = {
    left = nil, -- 最左边的墙壁
    middle = nil, -- 左边挡板
    right = nil, -- 右边墙壁
}

-- 玩具类型
local toyTypeEnum = {
    blue = 700001,
    red = 700002,
    green = 700003,
    type1 = 700004,
    type2 = 700005,
    type3 = 700006,
}

-- 刚体类型
local rigidType = {
    toy = 1,
    clamps = 2,
}

-- 爪子移动速度
local clampsSpeed = 120

-- 爪子张开单边最大长度
local openDistance = 90

function CatchDollScene:ctor(...)
    self.super.ctor(self, ...)
    self:init()
    self:initEvents()
    self:initBg()
    self:initRoom()
    self:initToyLayer()
    self:initClamps()
    -- self:initTouchLayer()
    self:initButton()
    self:initUpdate()
    self:initContactEvent()
    self:initResultNode()
    self:initCoinNum()
    self:initTimer()
    
    self:initCollectNum()
    self:initTarget()

    self:generateToys()
    self:setIdleStats()
end

function CatchDollScene:onEnter()
    self.super.onEnter(self)
end

function CatchDollScene:init()
    me.TextureCache:removeUnusedTextures()

    local world = self:getPhysicsWorld()
    world:setFixedUpdateRate(60)
    world:setGravity(ccp(0, -1000))

    -- 物理场景初始化
    local nodeRoot  = createUIBySceneConfig("lua.physics.catchDoll_scene")
    self.baseLayer:addChild(nodeRoot)

    -- UI初始化
    local CatchDollUIView  = require("lua.logic.catchDoll.CatchDollUIView")
    local catchDollUIView = CatchDollUIView:new(self)
    self:addLayer(catchDollUIView)

    -- world:setDebugDrawMask(7)

    --是否已经确认过最新的抓取结果
    self.isCheckedNewCatchResult = false
    --是否投币
    self.isPutCoinIn = false

    self.needCountDown = false

    self.canRequestStart = true
end

function CatchDollScene:initBg()
    local bg = TFDirector:getChildByPath(self, "bg")
    bg:setAnchorPoint(ccp(0, 0))
    local size = bg:getSize()
    local pos = ccp((GameConfig.WS.width-size.width)/2, (GameConfig.WS.height-size.height)/2)

    bg:setPosition(pos)
end

function CatchDollScene:initEvents()
    EventMgr:addEventListener(self,EV_CATCHDOLL_START,handler(self.start, self))
    EventMgr:addEventListener(self,EV_CATCHDOLL_REFRESH,handler(self.refresh, self))
end

function CatchDollScene:initCollectNum()
    self.collectNum =  0
end

function CatchDollScene:updatePercent()
    if not CatchDollDataMgr:isCollectMode() then
        return
    end

    local target = CatchDollDataMgr:getTarget()
    local Label_percent = TFDirector:getChildByPath(self, "Label_percent")

    Label_percent:setText(self.collectNum.."/"..target.num)
end

function CatchDollScene:initTarget()
    local Image_target = TFDirector:getChildByPath(self, "Image_target")

    if not CatchDollDataMgr:isCollectMode() then
        Image_target:hide()
        return
    else
        Image_target:show()
    end

    local target = CatchDollDataMgr:getTarget()
	local tmtargetCfg = CatchDollDataMgr:getToyConfig()[target.template]
	Image_target:setTexture(tmtargetCfg.icon)
    Image_target:setScale(tmtargetCfg.scale)
--    if target.template == toyTypeEnum.red then
--        Image_target:setTexture("CatchDoll/06.png")
--        Image_target:setScale(1)
--    elseif target.template == toyTypeEnum.blue then
--        Image_target:setTexture("CatchDoll/07.png")
--        Image_target:setScale(0.9)
--    elseif target.template == toyTypeEnum.green then
--        Image_target:setTexture("CatchDoll/08.png")
--        Image_target:setScale(1.1)
--    elseif target.template == toyTypeEnum.type1 then
--        Image_target:setTexture("CatchDoll/08.png")
--        Image_target:setScale(0.9)
--    elseif target.template == toyTypeEnum.type2 then
--        Image_target:setTexture("CatchDoll/07.png")
--        Image_target:setScale(0.9)
--    elseif target.template == toyTypeEnum.type3 then
--        Image_target:setTexture("CatchDoll/06.png")
--        Image_target:setScale(0.9)
--    end
    
    self:updatePercent()
end

function CatchDollScene:initCoinNum()
    local Label_coin = TFDirector:getChildByPath(self, "Label_coin")
    Label_coin:setText("X "..CatchDollDataMgr:getCoin())
end

function CatchDollScene:updateCoin()
    local Label_coin = TFDirector:getChildByPath(self, "Label_coin")
    Label_coin:setText("X ".. CatchDollDataMgr:getCoin())

    local Label_start = TFDirector:getChildByPath(self, "Label_start")
    Label_start:setTextById(100000017)
    TFDirector:getChildByPath(self, "Image_start_title"):setTexture("CatchDoll/catch.png")
    self.canRequestStart = false
end

function CatchDollScene:setIdleStats()
    if self.status ~= status.idle then
        self.status = status.idle
        local Label_start = TFDirector:getChildByPath(self, "Label_start")
        Label_start:setTextById(100000018)
        TFDirector:getChildByPath(self, "Image_start_title"):setTexture("CatchDoll/put_coin.png")

        local Label_count = TFDirector:getChildByPath(self, "LabelBMFont_count")
        Label_count:setText("00:00")

        if CatchDollDataMgr:isCollectMode() then
            local target = CatchDollDataMgr:getTarget()
            if CatchDollDataMgr:getCoin() <= 0 then
                if self.collectNum < target.num then
                    self:setGameWin(false)
                end
            end

            if self.collectNum >= target.num then
                self:setGameWin(true)
            end
        end
        self.canRequestStart = true
    end
end

function CatchDollScene:setWaitStats()
    self.status = status.wait
end

function CatchDollScene:initUpdate()
    self:addMEListener(TFWIDGET_ENTERFRAME, handler(self.update, self))
end

-- 爪子和玩具有接触的时候触发抓取动作
function CatchDollScene:initContactEvent()
    local contactListener = EventListenerPhysicsContact:create()
    contactListener:setContactBeginHandle(function (contact)
        local a = contact:getShapeA():getBody()
        local b = contact:getShapeB():getBody()

        if a:getNode():getTag() ~= b:getNode():getTag()then
            if not self.contacted then
                self.contacted = true
                 self.clampsStatus = clampsStatus.idle
                 self.headStatus = headStatus.slowDown
            end
        end

        return true
    end)

    local eventDispatcher = me.Director:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(contactListener, self);
end

function CatchDollScene:initResultNode()
    local Image_result = TFDirector:getChildByPath(self, "Image_result")
    Image_result:setVisible(false)
end

function CatchDollScene:setGameWin(isGameWin)
    local Image_result = TFDirector:getChildByPath(self, "Image_result")
    Image_result:setVisible(true)
    if isGameWin then
        Image_result:setTexture("CatchDoll/03.png")
    else
        Image_result:setTexture("CatchDoll/02.png")
    end

    CatchDollDataMgr:setGameWin(isGameWin)

    self:timeOut(function ()
        CatchDollDataMgr:endGame()
    end, 2)
end

function CatchDollScene:makeToy(params)
    local toyType = params.toyInfo.template or toyTypeEnum.red

    local toy
    if toyType == toyTypeEnum.red then
        local nodeRoot = createUIBySceneConfig("lua.physics.toy1_scene")
        toy  = TFDirector:getChildByPath(nodeRoot, "toy")
--        toy:setScale(1)
    elseif toyType == toyTypeEnum.blue then
        local nodeRoot = createUIBySceneConfig("lua.physics.toy2_scene")
        toy  = TFDirector:getChildByPath(nodeRoot, "toy")
--        toy:setScale(0.9)
    elseif toyType == toyTypeEnum.green then
        local nodeRoot = createUIBySceneConfig("lua.physics.toy3_scene")
        toy  = TFDirector:getChildByPath(nodeRoot, "toy")
--        toy:setScale(1.1)
    elseif toyType == toyTypeEnum.type1 then
        local nodeRoot = createUIBySceneConfig("lua.physics.toy3_scene")
        toy  = TFDirector:getChildByPath(nodeRoot, "toy")
--        toy:setScale(0.9)
    elseif toyType == toyTypeEnum.type2 then
        local nodeRoot = createUIBySceneConfig("lua.physics.toy2_scene")
        toy  = TFDirector:getChildByPath(nodeRoot, "toy")
--        toy:setScale(0.9)
    elseif toyType == toyTypeEnum.type3 then
        local nodeRoot = createUIBySceneConfig("lua.physics.toy1_scene")
        toy  = TFDirector:getChildByPath(nodeRoot, "toy")
--        toy:setScale(0.9)
    end

    toy:removeFromParent()
    local tmtoyCfg = CatchDollDataMgr:getToyConfig()[toyType]
	toy:setTexture(tmtoyCfg.icon)
	toy:setScale(tmtoyCfg.scale)
    local body = toy:getPhysicsBody()

    if self.toyLayer and not tolua.isnull(self.toyLayer) then
        self.toyLayer:addChild(toy)
    end

    toy:setTag(rigidType.toy)
    toy:setPosition(params.pos or ccp(0, 0))

    body:setDynamic(true)
    body:setContactTestBitmask(0xFF)
    body:setLinearDamping(0.5)
    body:setAngularDamping(0.8)
    body:setVelocityLimit(clampsSpeed*5)
    body:setMass(CatchDollDataMgr:getToyMassFactor(toyType) * body:getMass())

    toy.toyInfo = params.toyInfo

    return toy
end

-- 获取生成玩具的6个坐标
function CatchDollScene:getBornNodes()
    if not self.bornNodes_ then 
        self.bornNodes_ = {}

        for i = 1, 6 do
            local bornNode = TFDirector:getChildByPath(self, "bornNode"..i)
            local worldPos = bornNode:convertToWorldSpaceAR(ccp(0, 0))
            local nodePos = self.toyLayer:convertToNodeSpace(worldPos)

            table.insert(self.bornNodes_, nodePos)
        end
    end

    return self.bornNodes_
end

function CatchDollScene:clearPreToys()
    if not self.toys then 
        return
    end

    for _, toy in ipairs(self.toys) do
        toy:removeFromParent()
    end

    self.toys = {}
end

function CatchDollScene:checkPosValid(toypool, toyPos)
    if not toyPos then
        return false
    end

    local sum1 = 0
    for i, line in ipairs(toypool) do
        for index, toyInfo in ipairs(line) do
            sum1 = sum1 + 1
        end
    end

    local sum2 = 0
    for _, toy in pairs(toyPos) do
        sum2 = sum2 + 1
        if toy.pos.y <= 0 then
            return false
        end
    end

    if sum1 ~= sum2 then
        return false
    end

    for i, line in ipairs(toypool) do
        for index, toyInfo in ipairs(line) do
            if not toyPos[toyInfo.id] then
                return false
            end
        end
    end

    return true
end

function CatchDollScene:loadSavedPos(toypool)
    local toyPos = CatchDollDataMgr:loadToyPos()

    if not self:checkPosValid(toypool, toyPos) then
        return
    end

    for i, line in ipairs(toypool) do
        for index, toyInfo in ipairs(line) do
            toyInfo.pos = toyPos[toyInfo.id].pos 
        end
    end
end

function CatchDollScene:generateToys()
    self:clearPreToys()

    local toypool = CatchDollDataMgr:getToyPool()
    local bornPos = self:getBornNodes()

    self:loadSavedPos(toypool)

    self.toys = {}
    local lineskey = {}
    for i, line in ipairs(toypool) do
        lineskey[#lineskey + 1] = i
    end
    table.sort(lineskey,function(a,b)
            return a < b
        end)
    for i=1,#lineskey do
        local line = toypool[lineskey[i]]
        for index, toyInfo in ipairs(line) do
            local pos = toyInfo.pos or bornPos[index]
            local toy = self:makeToy({pos = pos, toyInfo = toyInfo})
            table.insert(self.toys, toy)
        end
    end

    self:saveToyPos()
end

function CatchDollScene:getCatchedToy()
    self.toyCatched = self.toyCatched or {}
    local newCatched = {}

    local total = 0
    for _, toy in ipairs(self.toys or {}) do
        local pos = toy:convertToWorldSpaceAR(ccp(0, 0))
        if pos.x >= wallPos.left and pos.x < wallPos.middle then
            total = total + 1

            if not self.toyCatched[toy] then
                self.toyCatched[toy] = true
                table.insert(newCatched, toy)
            end
        end
    end

    self.newCatched = newCatched
    self.isCheckedNewCatchResult = true
end

-- 初始化墙壁位置，初始化娃娃机几个点位
function CatchDollScene:initRoom()
    local nodeRoom = TFDirector:getChildByPath(self, "nodeRoom")

    local bottomWallShap = nodeRoom:getPhysicsBody():getShape(0)
    local leftWallShap = nodeRoom:getPhysicsBody():getShape(1)
    local middleWallShap = nodeRoom:getPhysicsBody():getShape(2)
    local rightWallShap = nodeRoom:getPhysicsBody():getShape(3)
    local topWallShap = nodeRoom:getPhysicsBody():getShape(4)


    bottomWallShap:setFriction(0.5)
    leftWallShap:setFriction(0.5)
    middleWallShap:setFriction(0.5)
    rightWallShap:setFriction(0.5)
    topWallShap:setFriction(0.5) 

    local bottomA = nodeRoom:convertToWorldSpaceAR(bottomWallShap:getPointA())
    local leftA = nodeRoom:convertToWorldSpaceAR(leftWallShap:getPointA())
    local middleA = nodeRoom:convertToWorldSpaceAR(middleWallShap:getPointA())
    local rightA = nodeRoom:convertToWorldSpaceAR(rightWallShap:getPointA())
    local topA = nodeRoom:convertToWorldSpaceAR(topWallShap:getPointA())

    headPos.down = bottomA.y + 120
    headPos.maxLeft = (leftA + middleA).x / 2
    headPos.left = middleA.x + (openDistance+5)
    headPos.right = rightA.x - (openDistance+5)
    headPos.up = topA.y - 30

    wallPos.left = leftA.x
    wallPos.middle = middleA.x
    wallPos.right = rightA.x
end

-- 初始化玩具层panel，所有生成玩具的父节点
-- 主要是设置裁剪，实现玩具落到洞里的效果
function CatchDollScene:initToyLayer()
    local bg = TFDirector:getChildByPath(self, "bg")

    local toyLayer =  TFLayer:create()
    toyLayer:setSize(GameConfig.WS)

    local nodeRoom = TFDirector:getChildByPath(self, "nodeRoom")
    local bottomWallShap = nodeRoom:getPhysicsBody():getShape(0)
    local leftWallShap = nodeRoom:getPhysicsBody():getShape(1)
    local rightWallShap = nodeRoom:getPhysicsBody():getShape(3)
    local topWallShap = nodeRoom:getPhysicsBody():getShape(4)

    local bottomA = nodeRoom:convertToWorldSpaceAR(bottomWallShap:getPointA())
    local leftA = nodeRoom:convertToWorldSpaceAR(leftWallShap:getPointA())
    local rightA = nodeRoom:convertToWorldSpaceAR(rightWallShap:getPointA())
    local topA = nodeRoom:convertToWorldSpaceAR(topWallShap:getPointA())

    bottomA = bg:convertToNodeSpace(bottomA)
    leftA = bg:convertToNodeSpace(leftA)
    rightA = bg:convertToNodeSpace(rightA)
    topA = bg:convertToNodeSpace(topA)

    toyLayer:setPosition(ccp(leftA.x, bottomA.y))
    toyLayer:setSize(GameConfig.WS)

    toyLayer:setClippingEnabled(true)

    bg:addChild(toyLayer, 10000)

    self.toyLayer = toyLayer
end

-- 初始化爪子
function CatchDollScene:initClamps()
    local world = self:getPhysicsWorld()

    local head = TFDirector:getChildByPath(self, "head")
    local clampsLeft = TFDirector:getChildByPath(self, "clampsLeft")
    local clampsRight = TFDirector:getChildByPath(self, "clampsRight")

    local origPos = head:getPosition()
    local newPos = ccp(headPos.maxLeft, headPos.up)
    head:setPosition(newPos)

    local dPos = newPos - origPos
    clampsLeft:setPosition(clampsLeft:getPosition()+dPos)
    clampsRight:setPosition(clampsRight:getPosition()+dPos)

    clampsLeft.nodeLeft = TFDirector:getChildByPath(clampsLeft, "nodeLeft")
    clampsLeft:getPhysicsBody():setContactTestBitmask(0xFF)
    clampsLeft.nodeRight = TFDirector:getChildByPath(clampsLeft, "nodeRight")
    clampsLeft:setTag(rigidType.clamps)

    clampsRight.nodeLeft = TFDirector:getChildByPath(clampsRight, "nodeLeft")
    clampsRight.nodeRight = TFDirector:getChildByPath(clampsRight, "nodeRight")
    clampsRight:getPhysicsBody():setContactTestBitmask(0xFF)
    clampsRight:setTag(rigidType.clamps)

    local nodePoint = TFDirector:getChildByPath(self, "nodePoint")
    local offset = nodePoint:convertToWorldSpaceAR(ccp(0, 0))

    local joint = PhysicsJointPin:construct(head:getPhysicsBody(), clampsLeft:getPhysicsBody(), offset)
    world:addJoint(joint)
    clampsLeft:getPhysicsBody():setLinearDamping(0.5)

    local joint = PhysicsJointPin:construct(head:getPhysicsBody(), clampsRight:getPhysicsBody(), offset)
    world:addJoint(joint)
    clampsRight:getPhysicsBody():setLinearDamping(0.5)

    clampsLeft:getPhysicsBody():setDynamic(true)
    clampsRight:getPhysicsBody():setDynamic(true)

    clampsLeft:getPhysicsBody():setVelocityLimit(clampsSpeed*2)
    clampsRight:getPhysicsBody():setVelocityLimit(clampsSpeed*2)

    self.head = head
    self.clampsLeft = clampsLeft
    self.clampsRight = clampsRight
end

function CatchDollScene:moveRight()
    if self.status ~= status.left and self.status ~= status.right then 
        return 
    end

    self.status = status.right
end

function CatchDollScene:moveLeft()
    if self.status ~= status.left and self.status ~= status.right then 
        return 
    end

    local head = TFDirector:getChildByPath(self, "head")
    local pos = head:getPosition()
    if pos.x + 5 < headPos.left then
        return 
    end

    self.status = status.left
end

function CatchDollScene:catch()
    if self.status ~= status.left and self.status ~= status.right then 
        return 
    end

    local head = TFDirector:getChildByPath(self, "head")
    local pos = head:getPosition()
    if pos.x + 5 < headPos.left then
        return 
    end

    self.status = status.catch

    self.contacted = false

    self.clampsStatus =  clampsStatus.open
    self.headStatus =  headStatus.down 
    self.needCountDown = false
end

function CatchDollScene:initButton()
    local clampsLeft = TFDirector:getChildByPath(self, "clampsLeft")
    local Button_Left = TFDirector:getChildByPath(self, "Button_Left")
    Button_Left:setTouchEnabled(true)
    Button_Left:onClick(function ()
        -- self:moveLeft()
    end)
    Button_Left:hide()

    local Button_Right = TFDirector:getChildByPath(self, "Button_Right")
    Button_Right:setTouchEnabled(true)
    Button_Right:onClick(function ()
        self:moveRight()
    end)
    Button_Right:hide()

    local Button_start = TFDirector:getChildByPath(self, "Button_start")
    Button_start:setTouchEnabled(true)
    Button_start:onClick(function ()
        if self.status == status.idle then
            if CatchDollDataMgr:isCollectMode() then
                self:play()
            else
                if self.canRequestStart == true then
                    CatchDollDataMgr:reqGashaponStart()
                    self.canRequestStart = false
                    print("ask:reqGashaponStart----------------")
                    self.isPutCoinIn = false
                    local delaytime = CCDelayTime:create(4)
                    local enableRequst = CCCallFunc:create(function()
                        self.canRequestStart = true
                    end)
                    Button_start:runAction(CCSequence:create({delaytime,enableRequst}))
                end
            end
        else
            self:catch()
        end

    end)

    local Button_Refresh = TFDirector:getChildByPath(self, "Button_Refresh")
    Button_Refresh:setTouchEnabled(true)
    Button_Refresh:onClick(function ()
        if self:ableToFresh() then
            CatchDollDataMgr:reqGashaponRefresh()
        else

        end
    end)

    if CatchDollDataMgr:isCollectMode() then
        Button_Refresh:hide()
    end
end

function CatchDollScene:ableToFresh()
    return self.status == status.idle and CatchDollDataMgr:ableToFresh()
end

function CatchDollScene:play()
    if CatchDollDataMgr:getCoin() > 0 then
        if self.isPutCoinIn == false then
            CatchDollDataMgr:setCoin(CatchDollDataMgr:getCoin()-1)
            self.isPutCoinIn = true
            CatchDollDataMgr:resetCountDownNumber()
            self:start()
        end
        
    else

    end
end

function CatchDollScene:start()
    self.status = status.right
    self:moveRight()
    self.needCountDown = true
    self.canRequestStart = false
    self:updateCoin()
end

function CatchDollScene:refresh()
    self:generateToys()
end

-- 增加鼠标点击玩具移动的触摸层，方便调试
function CatchDollScene:initTouchLayer()
    local function onTouchBegan(touch, location)
        local arr = self:getPhysicsWorld():getShapes(location)
        
        local body
        for _, obj in ipairs(arr) do
            body = obj:getBody();
            break;
        end
        
        if body then
            local mouse = CCNode:create();
            mouse:setPhysicsBody(PhysicsBody:create(10, 10));
            mouse:getPhysicsBody():setDynamic(false);
            mouse:setPosition(location);
            self:addChild(mouse);
            local joint = PhysicsJointPin:construct(mouse:getPhysicsBody(), body, location);
            joint:setMaxForce(5000.0 * body:getMass());
            self:getPhysicsWorld():addJoint(joint);
            touch.mouse = mouse
            
            return true;
        end
        
        return false;
    end

    local function onTouchMoved(touch, location)
        if touch.mouse then
            touch.mouse:setPosition(location);
        end
    end

    local function onTouchUp(touch, location)
        if touch.mouse then
            self:removeChild(touch.mouse)
            touch.mouse = nil
        end
    end

    local touchLayer =  TFLayer:create()
    touchLayer:setTouchEnabled(true)
    touchLayer:setSize(GameConfig.WS)
    touchLayer:addMEListener(TFWIDGET_TOUCHBEGAN, onTouchBegan);
    touchLayer:addMEListener(TFWIDGET_TOUCHMOVED, onTouchMoved);
    touchLayer:addMEListener(TFWIDGET_TOUCHENDED, onTouchUp);
    touchLayer:setSwallowTouch(false)
    self:addChild(touchLayer, 1)
end


function CatchDollScene:runLeft()
    local head = TFDirector:getChildByPath(self, "head")
    local body = head:getPhysicsBody()
    local pos = head:getPosition()

    if pos.x > headPos.left then
        body:setVelocity(ccp(-clampsSpeed, 0))
    else
        self:moveRight()
    end
end

function CatchDollScene:runRight()
    local head = TFDirector:getChildByPath(self, "head")
    local body = head:getPhysicsBody()
    local pos = head:getPosition()

    if pos.x < headPos.right then
        body:setVelocity(ccp(clampsSpeed, 0))
    else
        self:moveLeft()
    end
end

-- 张开爪子，两个爪子到一定角度即判断为张开
function CatchDollScene:openClamps(distance, callBack)
    distance = distance or openDistance

    local clampsLeft = TFDirector:getChildByPath(self, "clampsLeft")
    local clampsRight = TFDirector:getChildByPath(self, "clampsRight")
    local nodePoint = TFDirector:getChildByPath(self, "nodePoint")

    local head = TFDirector:getChildByPath(self, "head")
    local headVelocity = head:getPhysicsBody():getVelocity()

    local posLeft = clampsLeft.nodeLeft:convertToWorldSpaceAR(ccp(0, 0))
    local posRight = clampsLeft.nodeRight:convertToWorldSpaceAR(ccp(0, 0))
    local posPoint = nodePoint:convertToWorldSpaceAR(ccp(0, 0))
    local dLeft = (posPoint-posRight).x

    if dLeft >= distance then
        clampsLeft:getPhysicsBody():setVelocity(headVelocity)
    else
        local v = posLeft - posRight
        clampsLeft:getPhysicsBody():applyForce(v * 100000)
    end

    local posLeft = clampsRight.nodeLeft:convertToWorldSpaceAR(ccp(0, 0))
    local posRight = clampsRight.nodeRight:convertToWorldSpaceAR(ccp(0, 0))
    local posPoint = nodePoint:convertToWorldSpaceAR(ccp(0, 0))
    local dRight = (posRight-posPoint).x

    if dRight >= distance then
        clampsRight:getPhysicsBody():setVelocity(headVelocity)
    else
        local v = posLeft - posRight
        clampsRight:getPhysicsBody():applyForce(v * 100000)
    end

    if dLeft >= distance and dRight >= distance then
        if callBack then
            callBack()
        end
    end
end

-- 闭合爪子
function CatchDollScene:closeClamps()
    local clampsLeft = TFDirector:getChildByPath(self, "clampsLeft")
    local clampsRight = TFDirector:getChildByPath(self, "clampsRight")

    local head = TFDirector:getChildByPath(self, "head")
    local headVelocity = head:getPhysicsBody():getVelocity()

    local power = CatchDollDataMgr:getClampsPower()

    if clampsLeft:getRotation() <= 0 then
        clampsLeft:getPhysicsBody():setVelocity(headVelocity)
    else
        local posLeft = clampsLeft.nodeLeft:convertToWorldSpaceAR(ccp(0, 0))
        local posRight = clampsLeft.nodeRight:convertToWorldSpaceAR(ccp(0, 0))
        local v = posRight - posLeft
        -- clampsLeft:getPhysicsBody():setVelocity(v+headVelocity)
        clampsLeft:getPhysicsBody():applyForce(v * 10000 * power)
    end

    if clampsRight:getRotation() >= 0 then
        clampsRight:getPhysicsBody():setVelocity(headVelocity)
    else
        local posLeft = clampsRight.nodeLeft:convertToWorldSpaceAR(ccp(0, 0))
        local posRight = clampsRight.nodeRight:convertToWorldSpaceAR(ccp(0, 0))
        local v = posRight - posLeft

        -- clampsRight:getPhysicsBody():setVelocity(v+headVelocity)
        clampsRight:getPhysicsBody():applyForce(v * 10000 * power)
    end
end


function CatchDollScene:detectToyCanCatch()
    local nodes = { self.head, self.clampsLeft, self.clampsRight}

    for _, node in ipairs(nodes) do
        local nodeCatchPoint = TFDirector:getChildByPath(node, "nodeCatchPoint")
        local location = nodeCatchPoint:convertToWorldSpaceAR(ccp(0, 0))

        local shapes = self:getPhysicsWorld():getShapes(location)
        for _, shape in ipairs(shapes) do
            local body = shape:getBody()
            if body then
                local node = body:getNode()
                if node:getTag() == rigidType.toy then
                    return true
                end
            end
        end
    end
end

function CatchDollScene:idleClamps(func, time)
    self.headStatus = headStatus.idle

    local head = TFDirector:getChildByPath(self, "head")
    local body = head:getPhysicsBody()
    body:setVelocity(ccp(0, 0))

    time = time or 10

    self:timeOut(function ( ... )
        if func then
            func()
        end
    end, time)
end

function CatchDollScene:downClamps()
    local head = TFDirector:getChildByPath(self, "head")
    local body = head:getPhysicsBody()
    local pos = head:getPosition()

    if pos.y > headPos.down then
        body:setVelocity(ccp(0, -clampsSpeed))
    else
        -- 已经到达爪子最低坐标，抓取并向上移动
        self.headStatus = headStatus.up
        self.clampsStatus = clampsStatus.close
        self.needCountDown = false
        return
    end

    local clampsLeft = TFDirector:getChildByPath(self, "clampsLeft")
    local clampsRight = TFDirector:getChildByPath(self, "clampsRight")
    local angularVelocityLeft = clampsLeft:getPhysicsBody():getAngularVelocity()
    local angularVelocityRight = clampsRight:getPhysicsBody():getAngularVelocity()

    -- 如果受到力太大就关闭爪子，同时向上
    if math.abs(angularVelocityLeft) > 8 or math.abs(angularVelocityRight) > 8 then
        self.headStatus = headStatus.up
        self.clampsStatus = clampsStatus.close
        return
    end

    if self:detectToyCanCatch() then
        self:idleClamps(function ( )
            self.headStatus = headStatus.up
        end, 0.3)
        self.clampsStatus = clampsStatus.close
    end
end

-- 爪子减速下降
function CatchDollScene:slowDownClamps()
    local head = TFDirector:getChildByPath(self, "head")
    local body = head:getPhysicsBody()
    local pos = head:getPosition()

    local v = body:getVelocity()

    v.y = v.y + 2

    if v.y >= 0 then
        self.headStatus = headStatus.up
        return
    end

    if pos.y <= headPos.down then
        self.headStatus = headStatus.up
        return
    end

    local clampsLeft = TFDirector:getChildByPath(self, "clampsLeft")
    local clampsRight = TFDirector:getChildByPath(self, "clampsRight")
    local angularVelocityLeft = clampsLeft:getPhysicsBody():getAngularVelocity()
    local angularVelocityRight = clampsRight:getPhysicsBody():getAngularVelocity()

    if math.abs(angularVelocityLeft) > 8 or math.abs(angularVelocityRight) > 8 then
        self.headStatus = headStatus.up
        return
    end

    body:setVelocity(v)

end

function CatchDollScene:upClamps()
    local head = TFDirector:getChildByPath(self, "head")
    local body = head:getPhysicsBody()
    local pos = head:getPosition()

    if pos.y < headPos.up then
        body:setVelocity(ccp(0, clampsSpeed))
    else
        body:setVelocity(ccp(0, 0))
        self.headStatus = headStatus.left
    end
end

function CatchDollScene:leftClamps()
    local head = TFDirector:getChildByPath(self, "head")
    local body = head:getPhysicsBody()
    local pos = head:getPosition()

    if pos.x > headPos.maxLeft  then
        body:setVelocity(ccp(-clampsSpeed, 0))
    else
        body:setVelocity(ccp(0, 0))
        self.clampsStatus = clampsStatus.idle
        if self.isCheckedNewCatchResult == false then
            self:getCatchedToy() 
        end
        self:openClamps(openDistance,function()
            self:setWaitStats()
        end)
    end
end

function CatchDollScene:runWait()
    if #self.newCatched > 0 then

        local needReport = true
        -- for _, toy in ipairs(self.newCatched) do
        --     if toy:getPosition().y >= 0 then
        --         needReport = false
        --         break
        --     end
        -- end

        -- if needReport then
            if CatchDollDataMgr:isCollectMode() then
                local target = CatchDollDataMgr:getTarget()
                for _, toy in ipairs(self.newCatched) do
                    if target.template == toy.toyInfo.template then
                        self.collectNum = self.collectNum + 1
                        self:updatePercent()
                    end
                end
            else
                local cids = {}
                for _, toy in ipairs(self.newCatched) do
                    table.insert(cids, toy.toyInfo.id)
                end

                if #cids > 0 then
                    CatchDollDataMgr:reqGashaponCheck(cids)
                end
            end

            self.newCatched = {}
        -- end
    else
        self:setIdleStats()
        self:saveToyPos()
    end
    self.isCheckedNewCatchResult = false
end

function CatchDollScene:saveToyPos()
    if CatchDollDataMgr:isCollectMode() then
        return
    end

    local infos = {}

    for i, toy in ipairs(self.toys) do
        local pos = toy:convertToWorldSpaceAR(ccp(0, 0))
        if pos.x >= wallPos.middle and pos.x <= wallPos.right then
            local info = {}
            info.template = toy.toyInfo.template
            info.pos = {x = toy:getPosition().x, y = toy:getPosition().y}
            infos[toy.toyInfo.id] = info
        end
    end

    CatchDollDataMgr:saveToyPos(infos)
end

function CatchDollScene:runCatch()
    if self.clampsStatus == clampsStatus.open then
        self:openClamps()
    elseif self.clampsStatus == clampsStatus.close then
        self:closeClamps()
    end

    if self.headStatus == headStatus.down then
        self:downClamps()
    elseif self.headStatus == headStatus.up then
        self:upClamps()
    elseif self.headStatus == headStatus.slowDown then
        self:slowDownClamps()
    elseif self.headStatus == headStatus.left then
        self:leftClamps()
    end
end

function CatchDollScene:update()
    if self.status == status.left then
        self:runLeft()
    elseif self.status == status.right then
        self:runRight()
    elseif self.status == status.catch then
        self:runCatch()
    elseif self.status == status.wait then
        self:runWait()
    end

    self:setToyVelocity()
    self:limitClampsRotation()
end

function CatchDollScene:setToyVelocity()
    for _, toy in ipairs(self.toys or {}) do
        local body = toy:getPhysicsBody()
        local v = body:getVelocity()

        if v.y > 0 then
            body:setVelocityLimit(clampsSpeed*1)
        else
            body:setVelocityLimit(clampsSpeed*5)
        end            
    end
end

function CatchDollScene:limitClampsRotation()
    if self.status ~= status.left and self.status ~= status.right then 
        return 
    end

    local clampsLeft = TFDirector:getChildByPath(self, "clampsLeft")
    local clampsRight = TFDirector:getChildByPath(self, "clampsRight")

    if clampsLeft:getRotation() < -60 then
        if not clampsLeft.limitMax then
            clampsLeft.limitMax = true

            local v = clampsLeft:getPhysicsBody():getVelocity()
            clampsLeft:getPhysicsBody():setVelocity(v*-1)

        end
    else
        clampsLeft.limitMax = false
    end

    if clampsRight:getRotation() > 60 then
        if not clampsRight.limitMax then
            clampsRight.limitMax = true

            local v = clampsRight:getPhysicsBody():getVelocity()
            clampsRight:getPhysicsBody():setVelocity(v*-1)
        end
    else
        clampsRight.limitMax = false
    end
end

function CatchDollScene:countDownCatch()
    if self.needCountDown then
        self.countDownNumber = CatchDollDataMgr:getCatchTimeCountDown()

        local Label_count = TFDirector:getChildByPath(self, "LabelBMFont_count")
        local function getTimeStr(timenum)
            local timeStr = tostring(timenum)
            if timenum < 10 then
                timeStr = "0"..timeStr
            end
            return timeStr
        end
        Label_count:setText(string.format("%s:%s",getTimeStr(math.floor(self.countDownNumber/60)),getTimeStr(self.countDownNumber%60)))

        if self.countDownNumber <= 0 then
            self.needCountDown = false

            self:catch()
        end
    end
end

function CatchDollScene:countDownRefresh()
    local Label_time = TFDirector:getChildByPath(self, "Label_time")
    Label_time:setText(CatchDollDataMgr:getRefreshTimeDesc())
end

function CatchDollScene:timerFunc()
    if not CatchDollDataMgr:isCollectMode() then
        self:countDownRefresh()
    end
    self:countDownCatch()
end

function CatchDollScene:onExit()
    self:removeCountDownTimer()
    EventMgr:removeEventListenerByTarget(self)
end

function CatchDollScene:initTimer()
    if self.countDownTimer_ then return end
    self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.timerFunc, self))
end

function CatchDollScene:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
        self.countDownTimer_ = nil
    end
end

return CatchDollScene