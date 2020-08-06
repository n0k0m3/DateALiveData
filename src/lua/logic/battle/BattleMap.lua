local BattleMgr    = import(".BattleMgr")
local enum         = import(".enum")
local eCameraFlag  = enum.eCameraFlag
local heroMgr      = BattleMgr.getHeroMgr()

local levelParse   = import(".LevelParse")
local EventTrigger = import(".EventTrigger")
local LayerType    = levelParse.LayerType
local winSize      = me.EGLView:getFrameSize()
local BattleGuide = import(".BattleGuide")
local BattleMap = class("BattleMap", function(...)
    return CCNode:create()
end)

function BattleMap:clean( )
    -- body
    for k,_gameObject in pairs(self.sortChilds) do
        if _gameObject.standEffect then
            _gameObject.standEffect:removeFromParent(true)
        end
    end
end

function BattleMap:ctor(controller)
    self.controller = controller
    self.zeye = me.Director:getZEye()
    self.winSize  = me.size(me.EGLView:getDesignResolutionSize())
    self.nCount = 0
    --所有添加到地图上的元素
    self.sortChilds = {}
    self.nMaskFlag  = 0
    self.nSortCount = 0

    --解析地图
    self:parse(controller)
    BattleGuide:registBattleMap(self)
end

function BattleMap:parse(controller)
    local data      = BattleDataMgr:getBattleData()
    --TODO 再没有预加载的情况会加载关卡json
    levelParse:loadJson(data.map,data.exMap)
    levelParse:parse(controller)
    BattleGuide:registController(controller)
    local mapNode   = levelParse:getMapNode()
    self:addChild(mapNode)
    mapNode:setCameraMask(eCameraFlag.CF_MAP)
    self.mapScroll = self:parseMapScroll(data)

    --角色上层
    self.Panel_role = levelParse:getMapLayer(LayerType.Role)
    self.Panel_boss = levelParse:getMapLayer(LayerType.Boss)
    --特效合适蒙层
    self.layerMask = TFPanel:create()
    self.layerMask:setSize(me.size(2048,1024)) --TODO 根据地图的大小调整宽度
    self.layerMask:setBackGroundColorType(TF_LAYOUT_COLOR_SOLID)
    self.layerMask:setOpacity(0)
    self.layerMask:setBackGroundColorOpacity(150)
    self.layerMask:setBackGroundColor(me.c3b(0,0,0))
    self.layerMask:setAnchorPoint(ccp(0.5,0.5))
    -- self.layerMask:setCameraMask(eCameraFlag.CF_UI)
    --创建三层
    self.layer1 = CCNode:create()
    self.layer2 = CCNode:create()
    self.layer3 = CCNode:create()
    self.Panel_role:addChild(self.layerMask)
    self.Panel_role:addChild(self.layer1)
    self.Panel_role:addChild(self.layer2)
    self.Panel_role:addChild(self.layer3)

    --遮挡节点绑定动作管理器
    for index, node in ipairs(levelParse.occlusionNodes) do
        BattleMgr.bindActionMgr(node)
        local pos  = node:getPosition()
        local size = node:getSize()
        --初始计算好检测区域
        node.rect  = me.rect(pos.x - size.width/2 , pos.y - size.height/2,size.width,size.height)
    end


    EventTrigger:resetTriggers(levelParse, controller)
end

function BattleMap:parseMapScroll(data)
    local result = {}
    local levelCfg = BattleDataMgr:getLevelCfg()
    if levelCfg.fightingMode == 2 or levelCfg.fightingMode == 3 then
        local dungeonSTGLevelCfg = clone(TabDataMgr:getData("DungeonSTGLevel"))
        local function findNextStep(id)
            if id == nil or id == 0 then return nil end
            local row = dungeonSTGLevelCfg[id]
            if nil == row then return nil end
            local node = levelParse:getRenderNode(row.mapID)
            node:setVisible(row.isFirst)
            local next
            if row.stopTime <= 0 then
                next = node:clone()
                node:getParent():addChild(next)
                local nodeCfg    = levelParse:getVisualNode(row.mapID)
                if row.mapMoveType == 1 then
                    next:setPositionX(node:getPositionX() + nodeCfg.Size.W)
                elseif row.mapMoveType == 2 then
                    next:setPositionX(node:getPositionX() - nodeCfg.Size.W)
                elseif row.mapMoveType == 3 then
                    next:setPositionY(node:getPositionY() + nodeCfg.Size.H)
                elseif row.mapMoveType == 4 then
                    next:setPositionY(node:getPositionY() - nodeCfg.Size.H)
                end
                next:setVisible(row.isFirst)
            end
            local step = {
                nodes     = {
                    [1] = node,
                },
                row       = row,
                index     = 1,
                loop      = 1,
                breakTime = 0,
            }
            if next then
                step.nodes[2] = next
            else
                step.firstPosition = node:getPosition()
                step.paused = false
            end

            if #row.Cspeed > 0 then
                step.isUseTimeAcceleration = true
                table.sort(row.Cspeed, function (a, b)
                    return a.Ctime < b.Ctime
                end)
                local firstSpeed = step.row.moveSpeed
                for _, value in ipairs(step.row.Cspeed) do
                    value.acceleration = (value.Nspeed - firstSpeed) / value.Ntime
                    value.firstSpeed   = firstSpeed
                    firstSpeed          = value.Nspeed
                end
            else
                if row.moveSpeed == 0 and row.time ~= 0 then
                    row.acceleration = (row.Espeed - row.Fspeed)/row.time
                end
            end
            return row.id, step
        end
        for i, v in ipairs(dungeonSTGLevelCfg) do
            if v.levelId == data.map and v.isFirst then
                local id, step = findNextStep(i)
                if id and step then
                    local sheet = {
                        next = id,
                        steps  = {}
                    }
                    sheet.steps[id] = step
                    while true do
                        if step.row.nextStepID == 0 or sheet.steps[step.row.nextStepID] then
                            break
                        end
                        id, step = findNextStep(step.row.nextStepID)
                        if not step then
                            break
                        end
                        sheet.steps[id] = step
                    end
                    result[#result+1] = sheet
                end
            end
        end
    end
    self.deltaSpeed = 0
    return result
end


function BattleMap:addObject(child,index)
    index = index or 2
    if index < 1 then --地表层下面
        self:addObject0(child)
    elseif index == 1 then
        self:addObject1(child)
    elseif index == 2 then
        self:addObject2(child)
    elseif index == 3 then
        self:addObject3(child)
    end
end


function BattleMap:addObject0(child)
    child:setCameraMask(self.Panel_boss:getCameraMask())
    self.Panel_boss:addChild(child)
end

function BattleMap:addObject1(child)
    child:setCameraMask(self.layer1:getCameraMask())
    self.layer1:addChild(child)
end

function BattleMap:addObject2(child)
    self.layer2:addChild(child)
    child:setCameraMask(self.layer2:getCameraMask())
    --添加到管理器
    if not child.getSortY then
        child.getSortY = child.getPositionY
    end
    self.nSortCount = self.nSortCount + 1
    child._sortIndex = self.nSortCount
    table.insert(self.sortChilds,child)
    child:addMEListener(TFWIDGET_CLEANUP, function (...)
        table.removeItem(self.sortChilds,child)
    end)
end

function BattleMap:addObject3(child)
    child:setCameraMask(self.layer3:getCameraMask())
    self.layer3:addChild(child)
end

function BattleMap:update(camera)
    --TODO 遮挡处理
    if self.nCount < 10 then
        self.nCount = self.nCount + 1
    else
        self.nCount = 0
        self:handlOcclusion()
    end
    --先排序再设置zOrder
    -- table.sort(self.sortChilds,function(a , b)
    --     if a:getSortY() == b:getSortY() then
    --         return a._sortIndex > b._sortIndex
    --     end
    --     return a:getSortY() > b:getSortY()
    -- end)
    -- for index , child in ipairs(self.sortChilds) do
    --     child:setZOrder(index*2)
    -- end
    --根据Y设置Zorder
    -- for index , child in ipairs(self.sortChilds) do
    --     child:setZOrder(9999 - child:getSortY())
    -- end
    --TODO增加透视效果
    local rect   = levelParse:getMoveRect()
    local height = rect.size.height
    local posY   = rect.origin.y
    for index , child in ipairs(self.sortChilds) do
        local sortY  = child:getSortY()
        if sortY ~= child._sortY then --在位置没有改变的情况下避免每贞去更新zOrder 和 scale
            child._sortY = sortY
            if sortY == 0 then   -- 0 和 640 特殊处理分别在嘴上层和最下层
                child:setZOrder(math.floor(height)+1)
                -- child:setScale(1)
            elseif sortY == 640 then
                child:setZOrder(-1)
                -- child:setScale(0.9)
            else
                local offset = sortY - posY
                local zorder = math.floor(height - offset)
                -- local scale  = 1 - offset/height*0.1
                child:setZOrder(zorder)
                -- child:setScale(scale)
            end
            -- print("zorder:",offset , zorder,"scale:",scale)
        end
    end
    
    if self.layerMask:getOpacity() > 0 then
        local pos3D = self.controller.getCameraPos3D()
        if pos3D then
            self.layerMask:setPosition(ccp(pos3D.x,pos3D.y))
        end
    end
end

function BattleMap:setSpeed(value)
    self.deltaSpeed = value
end

function BattleMap:updateMap(time)
    local dtSecond = time * 0.001
    for _, sheet in ipairs(self.mapScroll) do
        local step = sheet.steps[sheet.next]
        if step then
            local speed = self.deltaSpeed
            if step.paused then
                if step.row.stopTime > 0 then
                    step.breakTime = (step.breakTime or 0) + dtSecond
                end
            else
                if step.isUseTimeAcceleration then
                    step.row.currentSpeed = step.row.currentSpeed or step.row.moveSpeed
                    local timing = math.floor(self.controller:getTime())
                    local currentChangeSpeed = step.row.Cspeed[1]
                    if currentChangeSpeed and timing >= currentChangeSpeed.Ctime then
                        step.totalAccelerationTime = (step.totalAccelerationTime or 0) + dtSecond
                        local currentSpeed         = (currentChangeSpeed.firstSpeed + currentChangeSpeed.acceleration * step.totalAccelerationTime)
                        if step.totalAccelerationTime >= currentChangeSpeed.Ntime then
                            step.totalAccelerationTime = 0
                            table.remove(step.row.Cspeed, 1)
                            currentSpeed = currentChangeSpeed.Nspeed
                        end
                        step.row.currentSpeed = currentSpeed
                        speed                 = currentSpeed * dtSecond + speed
                        --if step.row.id == 17 then
                        --    print(string.format("FUCK:timing:%s, speed:(%s), ooxx:(%s), FSpeed:(%s), acc:(%s), totalTime(%s)", tostring(timing), tostring(speed), tostring(currentSpeed),
                        --            tostring(currentChangeSpeed.firstSpeed), tostring(currentChangeSpeed.acceleration), tostring(step.totalAccelerationTime)))
                        --end
                    else
                        speed = step.row.currentSpeed * dtSecond + speed
                        --if step.row.id == 17 then
                        --    print("FUCK", timing, speed)
                        --end
                    end
                else
                    if step.row.moveSpeed ~= 0 then
                        speed = step.row.moveSpeed * dtSecond + speed
                    elseif step.row.acceleration then
                        step.totalAccelerationTime = (step.totalAccelerationTime or 0) + dtSecond
                        speed                      = (step.row.Fspeed + step.row.acceleration * step.totalAccelerationTime) * dtSecond + speed
                    end
                end
                local mapCfg = levelParse:getVisualNode(step.row.mapID)
                for _, node in ipairs(step.nodes) do
                    node:setVisible(true)
                    if step.row.mapMoveType == 1 then
                        node:setPositionX(node:getPositionX() - speed)
                        if node:getPositionX() + mapCfg.Size.W <= 0 then
                            step.loop = step.loop + 1
                            if step.row.stopTime <= 0 then
                                step.index = step.index + 1
                                if step.index > #step.nodes then
                                    step.index = 1
                                end
                                node:setPositionX(step.nodes[step.index]:getPositionX() + mapCfg.Size.W - speed)
                            else
                                step.paused = true
                            end
                        end
                    elseif step.row.mapMoveType == 2 then
                        node:setPositionX(node:getPositionX() + speed)
                        if node:getPositionX() - mapCfg.Size.W >= self.winSize.width then
                            step.loop = step.loop + 1
                            if step.row.stopTime <= 0 then
                                step.index = step.index + 1
                                if step.index > #step.nodes then
                                    step.index = 1
                                end
                                node:setPositionX(step.nodes[step.index]:getPositionX() - mapCfg.Size.W + speed)
                            else
                                step.paused = true
                            end
                        end
                    elseif step.row.mapMoveType == 3 then
                        node:setPositionY(node:getPositionY() - speed)
                        if node:getPositionY() + mapCfg.Size.H <= 0 then
                            step.loop = step.loop + 1
                            if step.row.stopTime <= 0 then
                                step.index = step.index + 1
                                if step.index > #step.nodes then
                                    step.index = 1
                                end
                                node:setPositionY(step.nodes[step.index]:getPositionY() + mapCfg.Size.H - speed)
                            else
                                step.paused = true
                            end
                        end
                    elseif step.row.mapMoveType == 4 then
                        node:setPositionY(node:getPositionY() + speed)
                        if node:getPositionY() >= self.winSize.height then
                            step.loop = step.loop + 1
                            if step.row.stopTime <= 0 then
                                step.index = step.index + 1
                                if step.index > #step.nodes then
                                    step.index = 1
                                end
                                node:setPositionY(step.nodes[step.index]:getPositionY() - mapCfg.Size.H + speed)
                            else
                                step.paused = true
                            end
                        end
                    end
                end
            end
            if step.row.stopTime > 0 then
                if step.paused then
                    for _, node in ipairs(step.nodes) do
                        node:setVisible(true)
                        node:setPosition(step.firstPosition)
                    end
                end
                if step.breakTime >= step.row.stopTime then
                    step.paused    = false
                    step.breakTime = 0
                    if step.row.cycleTimes > 0 then
                        if step.loop >= step.row.cycleTimes then
                            step.loop  = 1
                            sheet.next = step.row.nextStepID
                        end
                    else
                        step.loop = 1
                    end
                end
            else
                if step.loop >= step.row.cycleTimes and step.row.cycleTimes > 0 then
                    step.breakTime = 0
                    step.loop      = 1
                    sheet.next     = step.row.nextStepID
                    for _, node in ipairs(step.nodes) do
                        node:setVisible(false)
                    end
                end
            end
        end
    end
end

local function fadeOut(node)
    if node:numberOfRunningActions() > 0 and node.state == "fadeOut" then
        return
    end

    if node:getOpacity() > 0 then
        node:stopAllActions()
        node:fadeTo(0.2,100)
        node.state = "fadeOut"
    end
end

local function fadeIn(node)
    if node:numberOfRunningActions() > 0 and node.state == "fadeIn" then
        return
    end

    if node:getOpacity() < 255 then
        node:stopAllActions()
        node:fadeTo(0.2,255)
        node.state = "fadeIn"
    end

end


function BattleMap:handlOcclusion()
    local heros  = heroMgr:getObjects()
    local isInsert = false
    for index, node in ipairs(levelParse.occlusionNodes) do
        isInsert = false
        for k , hero in ipairs(heros) do
            if hero.actor and hero:isActive() then
                if hero.actor:isInsertRect(node.rect) then
                    isInsert = true
                    break
                end
            end
        end
        if isInsert then
            fadeOut(node)
        else
            fadeIn(node)
        end
    end
end

function BattleMap:showMask(pos3D)
    self.nMaskFlag = self.nMaskFlag + 1
    if self.layerMask then
        if self.nMaskFlag > 0 then
            self.layerMask:fadeIn(0.3)
        end
    end
end

function BattleMap:hideMask()
    self.nMaskFlag = self.nMaskFlag - 1
    if self.layerMask then
        if self.nMaskFlag < 1 then
            self.layerMask:fadeOut(0.3)
        end
    end
end
return BattleMap

--[[

a.地图上会放置障碍物(阻挡/击毁[HP])
b.地图的 边界
c.空气墙
d.刷怪点

----
障碍物2中类型
一种是是不会导致上下偏移的(如空气墙)
一种是需要进行伤害偏移的(如地上的垃圾桶)
--]]