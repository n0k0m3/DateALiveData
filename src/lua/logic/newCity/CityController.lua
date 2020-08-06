local CityController = class("CityController")
local CityResLoader = require("lua.logic.newCity.NewCityResLoader")
local ISOMap = import("lua.logic.newCity.ISOMap")
local Avatar = import("lua.logic.newCity.Avatar")
function CityController:ctor()
    self.funcs = {
        [1] = self._jumpFunc1,
        [2] = self._jumpFunc2,
        [3] = self._jumpFunc3,
        [4] = self._jumpFunc4,
    }
    self:clean()
end

function CityController:clean()
    self.isRoomScrolling = false
    self.foreModel = {}
    self.backModel = {}
    self.roomModel = {}
    self.curRoomId = nil
    self.roomMapNode = {}
    self.roomMapConf = {}
    self.ISOMAPCache = {}
    if self.cityTimer then
        TFDirector:removeTimer(self.cityTimer)
    end
    self.cityTimer = nil
end

function CityController:startTimer()
    self.cityTimer = TFDirector:addTimer(0, -1, nil, handler(self.update, self))
end

-----------------------------------------地图-----------------------------------------
function CityController:parseRoomMap(bid)
    if self.ISOMAPCache[bid] == nil then
        self.ISOMAPCache[bid] = ISOMap:new()
    end
    self.ISOMAPCache[bid]:clearMap()
    local buildconf = TabDataMgr:getData("NewBuild", bid)

    local daytype = NewCityDataMgr:getCityDay()
    local mapname = EC_NewCityDayRoomMapRoot[daytype]..buildconf.mapName
    local roomMap = requireNew("lua.logic.newCity.MapParse"):new(mapname)

    self.roomMapNode[bid] = roomMap
    self.roomMapConf[bid] = self.roomMapConf[bid] or {}
    local roomconf = self.roomMapConf[bid]
    --点
    roomconf.orgpoints = clone(roomMap.visualNodes[5000].children)
    roomconf.points = clone(roomconf.orgpoints)
    roomconf.points_p = {}
    for i, v in ipairs(roomconf.points) do
        roomconf.points_p[v.ID] = me.p(v.Position.X, v.Position.Y)
    end

    --房间特殊点
    if roomMap.visualNodes[9000] then
        roomconf.specialorgpoints = clone(roomMap.visualNodes[9000].children)
        if roomconf.specialorgpoints then
            roomconf.specialpoints = clone(roomconf.specialorgpoints)
            roomconf.specialpoints_p = {}
            for i, v in ipairs(roomconf.specialpoints) do
                roomconf.specialpoints_p[v.ID] = me.p(v.Position.X, v.Position.Y)
            end
        end
    end
    --阻挡
    roomconf.blocks = {}
    for k, v in pairs(buildconf.blockInfo) do
        table.insert(roomconf.blocks, {nodeid = k, blockid = v})
        local block = roomMap:getVisualNode(v)
        local blockitem = roomMap:getRenderNode(k)
        local tmpoints = {}
        local blockPos = me.p(block.Position.X,block.Position.Y)
        for s,t in ipairs(block.ControlPoint) do
            tmpoints[#tmpoints + 1] = me.pAdd(me.p(t.X,t.Y),blockPos)
        end
        local tmavatar = Avatar:new(blockitem,tmpoints)
        self.ISOMAPCache[bid]:addObj(tmavatar)
    end
    --交互信息
    roomconf.interactions = {}
    for k,v in pairs(buildconf.interaction) do
        local mbehave = {}
        for s,t in pairs(v) do
            mbehave = {act = s}
            if type(t) == "number" then
                mbehave.dir = t+1
            elseif type(t) == "table" then
                mbehave.dir = t[1]+1
                mbehave.dh = t[2]
            else

            end
        end
        local mpoint = {id = k,behave = mbehave,lock = 0}
        roomconf.interactions[#roomconf.interactions + 1] = mpoint
    end
    local roomnode = roomMap.renderNodes[2000] --room节点
    roomnode.specialParent = roomMap.renderNodes[9000]
    return roomMap:getMapNode(), roomnode, roomMap.rect.size
end

function CityController:getRandomInterActPoints(bid)
    local freePoints = {}
    for k,v in pairs(self.roomMapConf[bid].interactions) do
        if v.lock == 0 then
            freePoints[#freePoints + 1] = v
        end
    end
    if #freePoints == 0 then
        return nil
    end
    local idx = math.random(1,#freePoints)
    return freePoints[idx]
end

function CityController:lockInterActPoint(bid,pid)
    for k,v in pairs(self.roomMapConf[bid].interactions) do
        if v.id == pid and v.lock ==0 then
            v.lock = 1
            break
        end
    end
end

function CityController:unlockInterActPoint(bid,pid)
    for k,v in pairs(self.roomMapConf[bid].interactions) do
        if v.id == pid and v.lock ~=0 then
            v.lock = 0
            break
        end
    end
end

function CityController:parseCityMap(daytype)
    daytype = daytype or EC_NewCityDayType.Day_Light
    self.cityMap = requireNew("lua.logic.newCity.MapParse"):new(EC_NewCityMainMapRoot[daytype])
    if self.ISOMAPCache[2] == nil then
        self.ISOMAPCache[2] = ISOMap:new()
    end
    self.ISOMAPCache[2]:clearMap()
    self.mapSize = self.cityMap.rect.size

    local restructPointData = function(tb)
        local ptb = {}
        local children = tb.children or {}
        for i, v in ipairs(children) do
            ptb[v.ID] = me.p(v.Position.X, v.Position.Y)
        end
        return ptb
    end
    self.basePointInfo = restructPointData(self.cityMap.visualNodes[3000])
    self.basePoint = clone(self.cityMap.visualNodes[3000].children) or {}
    self.buildIconPoint = restructPointData(self.cityMap.visualNodes[6000])

    if self.cityMap.visualNodes[10000] then
        self.specialPointInfo = restructPointData(self.cityMap.visualNodes[10000])
        self.specialPoint = clone(self.cityMap.visualNodes[10000].children) or {}
    end

    local mapinfo = {}
    mapinfo.road = self:getMapRenderNode(4000)
    mapinfo.buildIcon = self:getMapRenderNode(6000)
    mapinfo.specialEffectParent = self:getMapRenderNode(10000)
    mapinfo.build = {}
    local newbuild = TabDataMgr:getData("NewBuild")
    for k, v in pairs(newbuild) do
        local buildbg = self:getMapRenderNode(k)
        local bid = k
        mapinfo.build[k] = {bg = buildbg, bid = bid}
    end
    return self.cityMap:getMapNode(), mapinfo

    --local restructCityData = function(tb)
    --    tb.build = {}
    --    for i, v in ipairs(tb.root:getChildren()) do
    --        local id = tonumber(v:getName())
    --        local buildbg = v:getChildByName("bg"):show()
    --        local roomnode = v:getChildByName("room"):hide()
    --        tb.build[id] = {root = v, bg = buildbg, room = roomnode, bid = id}
    --    end
    --    return tb
    --end
    --local bgRoot = self:getMapRenderNode(1)
    --local fore = {}
    --fore.root = bgRoot:getChildByName("fore")
    --fore.road = bgRoot:getChildByName("foreroad")
    --fore.frontDecorate = bgRoot:getChildByName("forefrontdecorate")
    --fore.backDecorate = bgRoot:getChildByName("forebackdecorate")
    --fore = restructCityData(fore)
    --local back = {}
    --back.root = bgRoot:getChildByName("back")
    --back.road = bgRoot:getChildByName("backroad")
    --back.frontDecorate = bgRoot:getChildByName("backfrontdecorate")
    --back.backDecorate = bgRoot:getChildByName("backbackdecorate")
    --back = restructCityData(back)
    --
    --local restructPointData = function(tb)
    --    local ptb = {}
    --    local children = tb.children or {}
    --    for i, v in ipairs(children) do
    --        ptb[v.ID] = me.p(v.Position.X, v.Position.Y)
    --    end
    --    return ptb
    --end
    --self.forePointInfo = restructPointData(self.cityMap.visualNodes[10])
    --self.backPointInfo = restructPointData(self.cityMap.visualNodes[11])
    --self.roomAllPointInfo = {}
    --self.forePoint = clone(self.cityMap.visualNodes[10].children) or {}
    --self.backPoint = clone(self.cityMap.visualNodes[11].children) or {}
    --
    --return self.cityMap:getMapNode(), fore, back
end

function CityController:getMapInfo(bid)
    if bid >= 100 then
        return self.roomMapNode[bid]
    else
        return self.cityMap
    end
    return nil
end

function CityController:getForePointPos()
    local leftcount = #self.forePoint
    local randidx = math.random(1, leftcount)
    if leftcount > 0 and self.forePoint[randidx] then
        local randomp = self.forePoint[randidx]
        local pos = self.forePointInfo[randomp.ID]
        if not pos then
            --Box("前景路面生成点错误, 点id"..randomp.ID)
        end
        table.remove(self.forePoint, randidx)
        return pos
    end
    return me.p(0, 0)
end

function CityController:getBackPointPos()
    local leftcount = #self.backPoint
    local randidx = math.random(1, leftcount)
    if leftcount > 0 and self.backPoint[randidx] then
        local randomp = self.backPoint[randidx]
        local pos = self.backPointInfo[randomp.ID]
        if not pos then
            --Box("后景路面生成点错误, 点id"..randomp.ID)
        end
        table.remove(self.backPoint, randidx)
        return pos
    end
    return me.p(0, 0)
end

function CityController:getBaseMapPointPos(rand)
    local leftcount = #self.basePoint
    local randidx = math.random(1, leftcount)
    if leftcount > 0 and self.basePoint[randidx] then
        local randomp = self.basePoint[randidx]
        local pos = self.basePointInfo[randomp.ID]
        if not pos then
            --Box("路面生成点错误, 点id"..randomp.ID)
        end
        table.remove(self.basePoint, randidx)
        return pos
    end
    return me.p(0, 0)
end

function CityController:getBaseMapSpecialEffectPointPos(randSeed)
    local leftcount = #self.specialPoint
    self.specialPointVisible = self.specialPointVisible or {}
    local allVisible = {}
    if leftcount == 0 then return nil end
    for i = 1,leftcount do
        if not self.specialPointVisible[i] then
            table.insert( allVisible, i )
        end
    end
    if #allVisible == 0 then return nil end
    leftcount = #allVisible
    math.randomseed(randSeed)
    local randidx = math.random(1, leftcount)
    math.randomseed(os.time())
    local k = allVisible[randidx]
    local randomp = self.specialPoint[k]
    local pos = self.specialPointInfo[randomp.ID]
    if not pos then
        --Box("路面生成点错误, 点id"..randomp.ID)
    else
        self.specialPointVisible[k] = true
        return {pos = pos, key = k}
    end
    return nil
end

function CityController:visibleBaseMapSpecialEffectPoint( key )
    self.specialPointVisible = self.specialPointVisible or {}
    self.specialPointVisible[key] = false
end

function CityController:allVisibleBaseMapSpecialEffectPoint(  )
    dump("allVisibleBaseMapSpecialEffectPoint")
    self.specialPointVisible = {};---self.specialPointVisible or {}
end

function CityController:getRoomPointPosById(bid)
    local mapconf = self.roomMapConf[bid]
    local leftcount = #mapconf.points
    local randidx = math.random(1, leftcount)
    if leftcount > 0 and mapconf.points[randidx] then
        local randomid = mapconf.points[randidx].ID
        local pos = mapconf.points_p[randomid]
        if not pos then
            --Box("建筑生成点错误, 建筑号："..bid.."， 点id："..randomid)
        end
        table.remove(mapconf.points, randidx)
        return pos
    end
    return me.p(0, 0)
end

function CityController:getSpecialPointPosById(bid,randSeed)
    local mapconf = self.roomMapConf[bid]
    if not mapconf.specialpoints then return  me.p(0, 0) end
    local leftcount = #mapconf.specialpoints
    math.randomseed(randSeed)
    local randidx = math.random(1, leftcount)
    math.randomseed(os.time())
    if leftcount > 0 and mapconf.specialpoints[randidx] then
        local randomid = mapconf.specialpoints[randidx].ID
        local pos = mapconf.specialpoints_p[randomid]
        if not pos then
            --Box("建筑生成点错误, 建筑号："..bid.."， 点id："..randomid)
        end
        table.remove(mapconf.points, randidx)
        return pos
    end
    return me.p(0, 0)
end

function CityController:getBuildIconPoint(pointid)
    local pos = self.buildIconPoint[pointid]
    if pos then
        return pos
    end
    return me.p(0, 0)
end

function CityController:getMapVisualNode(id)
    id = tonumber(id)
    return self.cityMap.visualNodes[id]
end

function CityController:getMapRenderNode(id)
    id = tonumber(id)
    return self.cityMap.renderNodes[id]
end

function CityController:findPath(st, ed, bid)
    local path = {}
    if bid >= 100 then
        path = self.roomMapNode[bid]:find(st, ed)
    else
        path = self.cityMap:find(st, ed)
    end
    return path
end
-----------------------------------------地图-----------------------------------------

function CityController:resetAllPoint()
    --self.forePoint = nil
    --self.backPoint = nil
    self.basePoint = nil
    self.basePoint = clone(self.cityMap.visualNodes[3000].children) or {}
    --self.forePoint = clone(self.cityMap.visualNodes[10].children) or {}
    --self.backPoint = clone(self.cityMap.visualNodes[11].children) or {}
    for k, v in pairs(self.roomMapConf) do
        v.points = clone(v.orgpoints)
    end
end

function CityController:exitCity()
    self:allVisibleBaseMapSpecialEffectPoint()
    self:removeAllShape()
    CityResLoader.clean()
    self:clean()
end

function CityController:removeShapeState()
    for k, v in pairs(CityResLoader.cachedCityShapeNode) do
        v:removeState()
        v:updateState()
    end
    --for k, v in pairs(self.foreModel) do
    --    v:removeState()
    --end
    --for k, v in pairs(self.backModel) do
    --    v:removeState()
    --end
    --for k, v in pairs(self.roomModel) do
    --    for rk, rv in pairs(v) do
    --        rv:removeState()
    --    end
    --end
    --self.foreModel = {}
    --self.backModel = {}
    --self.roomModel = {}
end

function CityController:removeAllShape()
    --for k, v in pairs(self.foreModel) do
    --    v:removeSelf(true)
    --end
    --for k, v in pairs(self.backModel) do
    --    v:removeSelf(true)
    --end
    self.foreModel = {}
    self.roomModel = {}
    self.roomMapNode = {}
    --self.backModel = {}
    --self:removeRoomShape(true)
    for k, v in pairs(self.ISOMAPCache) do
        v:clearMap()
    end
    for k, v in pairs(CityResLoader.cachedCityShapeNode) do
        v:sleep()
        v:removeSelf(true)
    end
end

function CityController:removeRoomShape(breset)
    for k, v in pairs(self.roomModel) do
        for rk, rv in pairs(v) do
            rv:sleep()
            rv:removeSelf(breset)
        end
        self.ISOMAPCache[k]:clearMap()
    end
    self.roomModel = {}
    self.roomMapNode = {}
end

function CityController:showRoomShape(bid, selfid)
    local roomshapes = self.roomModel[bid] or {}
    for k, v in pairs(roomshapes) do
        if k ~= selfid then
            --v:show()
            v:runAction(CCFadeTo:create(0.2, 255))
        end
    end
end

function CityController:hideRoomShape(bid, selfid)
    local roomshapes = self.roomModel[bid] or {}
    for k, v in pairs(roomshapes) do
        if k ~= selfid then
            --v:hide()
            v:runAction(CCFadeTo:create(0.2, 0))
        end
    end
end

function CityController:addModel(citylevel, model)
    model:setIconPos()
    if citylevel == EC_NewCityLevel.NewCity_Fore then
        self.foreModel[model.mid] = model
    elseif citylevel == EC_NewCityLevel.NewCity_Back then
        self.backModel[model.mid] = model
    end
    local tmavatar = Avatar:new(model,{model:getPosition()})
    self.ISOMAPCache[2]:addObj(tmavatar)
    tmavatar:registPosUpdate()
    model:awake()
end

function CityController:addModelToRoom(roomid, model)
    model:setIconPos()
    self.roomModel[roomid] = self.roomModel[roomid] or {}
    self.roomModel[roomid][model.mid] = model
    if roomid >= 100 then
        local tmavatar = Avatar:new(model,{model:getPosition()})
        self.ISOMAPCache[roomid]:addObj(tmavatar)
        tmavatar:registPosUpdate()
    end
    model:awake()
end

function CityController:reorderISOItem(bid)
    self.ISOMAPCache[bid]:reorderObjs()
end

function CityController:switchToFore()
    self:awakeFore()
    self:sleepBack()
end

function CityController:switchToBack()
    self:awakeBack()
    self:sleepFore()
end

function CityController:awakeFore()
    for k, v in pairs(self.foreModel) do
        v:awake()
    end
end

function CityController:awakeBack()
    for k, v in pairs(self.backModel) do
        v:show()
        v:awake()
    end
end

function CityController:awakeRoom(bid, isguide)
    local roomshapes = self.roomModel[bid] or {}
    for k, v in pairs(roomshapes) do
        v:awake(isguide)
    end
end

function CityController:sleepFore()
    for k, v in pairs(self.foreModel) do
        v:sleep()
    end
end

function CityController:sleepBack()
    for k, v in pairs(self.backModel) do
        v:hide()
        v:sleep()
    end
end

function CityController:sleepRoom(bid, isguide)
    local roomshapes = self.roomModel[bid] or {}
    for k, v in pairs(roomshapes) do
        v:sleep(isguide)
    end
end

function CityController:update(dt)
    for k, v in pairs(self.foreModel) do
       v:update(dt)
    end
    for k, v in pairs(self.backModel) do
       v:update(dt)
    end
    for k, v in pairs(self.roomModel) do
       for rk, rv in pairs(v) do
           rv:update(dt)
       end
    end
end

function CityController:checkEnableShowRedPointByFuncId(funcId)
    if funcId == 1 then
        if CityJobDataMgr:checkJobEventDown() then
            return true
        end
    end
    return false
end

function CityController:checkRedPointByBuindingId(buildId)
    if CityJobDataMgr:buildingJobDown(buildId) then
        return true
    end
    return false
end

--------------------------------------城建跳转功能--------------------------------------
function CityController:jumpToFun(funid, params)
    params = params or {}
    local func = self.funcs[funid]
    if func then
        func(self, params)
    end
end

function CityController:_jumpFunc1(params)
    local layer = Utils:openView("city.CityJobView",params)
end

function CityController:_jumpFunc2(params)

end

function CityController:_jumpFunc3(params)
    Utils:openView("newCity.ManualMakeView",params)
end

function CityController:_jumpFunc4(params)
    --料理制作占坑    
    MakeFoodDataMgr:openMakeFoodView(params)
end
---------------------------------------------------------------------------------------

return CityController