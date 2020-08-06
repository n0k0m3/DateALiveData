local DalMapMainView = class("DalMapMainView", BaseLayer)
local GenerateDalMap = import(".GenerateDalMap")
local GenerateItem = import(".GenerateItem")
local GenerateNpc = import(".GenerateNpc")
local DalminiMap = import(".DalminiMap")
local TiledMapAStarPath = require("lua.logic.tiledMap.TiledMapAStarPath")
function DalMapMainView:ctor(worldCid)
    self.super.ctor(self)
    self:init("lua.uiconfig.dls.dalMapMainView")
    self:initData(worldCid)
end

function DalMapMainView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui
    self:showTopBar()

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_touch = TFDirector:getChildByPath(self.Panel_root, 'Panel_touch')
    self.contentSize = self.Panel_touch:getContentSize()
    self.touchNode = CCNode:create():AddTo(self.Panel_touch)
    self.touchNode:setAnchorPoint(ccp(0.5,0.5))
    self.touchNode:setTouchEnabled(true)
    self.touchNode:setSwallowTouch(false)
    self.touchNode:setSize(self.contentSize)
    TFDirector:setTouchSingled(false)

    self.Panel_UI = TFDirector:getChildByPath(self.Panel_root, 'Panel_UI')
    self.Button_maphelp = TFDirector:getChildByPath(self.Panel_UI, 'Button_maphelp'):hide()
    self.maphelpBtnTx = TFDirector:getChildByPath(self.Button_maphelp, 'Label_btn')
    self.Button_statistics = TFDirector:getChildByPath(self.Panel_UI, 'Button_statistics')
    self.statisticsBtnTx = TFDirector:getChildByPath(self.Button_statistics, 'Label_btn')
    self.Button_chat = TFDirector:getChildByPath(self.Panel_UI, 'Button_chat')

    self.Panel_miniMap = TFDirector:getChildByPath(self.Panel_UI, 'Panel_miniMap')
    self.Label_mapname = TFDirector:getChildByPath(self.Panel_UI, 'Label_mapname')
    self.Label_event_percent = TFDirector:getChildByPath(self.Panel_UI, 'Label_event_percent')

    self.Image_task_bg = TFDirector:getChildByPath(self.Panel_UI, 'Image_task_bg')
    self.Image_task_bg:setVisible(true)
    self.Label_title = TFDirector:getChildByPath(self.Image_task_bg, 'Label_title')
    self.Label_title:setTextById(3004015)
    self.Label_task = TFDirector:getChildByPath(self.Image_task_bg, 'Label_task')

    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
    self.Image_dress = TFDirector:getChildByPath(self.Panel_prefab, "Image_dress")
    self.Panel_npc = TFDirector:getChildByPath(self.Panel_prefab, "Panel_npc")
    self.Spine_heroItem = TFDirector:getChildByPath(self.Panel_prefab, "Spine_heroItem")
    self.Spine_clickPrefab = TFDirector:getChildByPath(self.Panel_prefab, 'Spine_click')
    self.MiniPlayer = TFDirector:getChildByPath(self.Panel_prefab, 'Image_miniPlayer')

end

function DalMapMainView:initData(worldCid)

    self.minTouchMoveDis = 50                   --用于判断地图是否是拖动
    self.mapContainerPrePos = nil
    self.mapContainerPos = nil
    self.mapContainerDiffPos = nil
    self.mapTouchBeginPos = nil
    self.playerModeScale = 1

    self.mapScale = 0.5
    self.minScale = 0.3
    self.maxScale = 1

    self.aroundTile = {}
    self.worldCid = worldCid
    self.GenerateDalMap = GenerateDalMap:new()
    self.GenerateItem = GenerateItem:new()
    self.TiledMapAStarPath = TiledMapAStarPath:new()
    self.GenerateNpc = GenerateNpc:new()
    self.DalminiMap = DalminiMap:new()
    DalMapDataMgr:Send_enterWorld(worldCid)
    self.Panel_UI:setVisible(false)

    self.locationEnd = true

    AudioExchangePlay.stopAllBgm()
    local worldCfg = DalMapDataMgr:getDlsWorldCfg(self.worldCid)
    if worldCfg and worldCfg.music ~= ""  then
        self.voiceHandle = TFAudio.playMusic(worldCfg.music,true)
    end

    local seqact = Sequence:create({
        DelayTime:create(1),
        CallFunc:create(function()
            self:checkOpenTime()
        end)
    })
    self.Panel_root:runAction(CCRepeatForever:create(seqact))
end

function DalMapMainView:checkOpenTime()
    if not DlsDataMgr:isOpenTime() then
        AlertManager:closeLayer(self)
    end
end

function DalMapMainView:onClose()
    TFDirector:setTouchSingled(true)
    if self.voiceHandle then
        TFAudio.stopEffect(self.voiceHandle)
    end
end

function DalMapMainView:onShow()
    --self.super.onShow(self)
end

function DalMapMainView:enterMap()

    DalMapDataMgr:setInWorldFage(true)
    self.Panel_UI:setVisible(true)
    DalMapDataMgr:initMapData()
    self:generateTiledMap()
    self:createMiniMap()
    self:uiLogic()

    self.preMovie = true
    self:timeOut(function()
        self:playFirstCg()
    end,1.0)
end

function DalMapMainView:playFirstCg()

    local firstEnter = DalMapDataMgr:isFirstEnter()
    if firstEnter then
        local curWorldId =  DalMapDataMgr:getCurWorld()
        local cfg = DalMapDataMgr:getDlsWorldCfg(curWorldId)
        if cfg and cfg.startPlot > 0 then
            local function callback()
                KabalaTreeDataMgr:playStory(1,cfg.startPlot,function ()
                    self:checkOverFight()
                    EventMgr:dispatchEvent(EV_CG_END)
                end)
            end
            KabalaTreeDataMgr:openCgView("kabalaTree.KabalaTreeCg",callback)
        else
            self:onRecvEventClear()
        end
    else
        self:checkOverFight()
    end
end

function DalMapMainView:checkOverFight()

    local winFight = DalMapDataMgr:getFightResult()
    if not winFight then
        local failedPlotId = DalMapDataMgr:getFailedPlotId()
        if failedPlotId and failedPlotId > 0 then
            local function callback()
                KabalaTreeDataMgr:playStory(1,failedPlotId,function ()
                    DalMapDataMgr:overDalFight(true)
                    EventMgr:dispatchEvent(EV_CG_END)
                    self:onRecvEventClear()
                end)
            end
            KabalaTreeDataMgr:openCgView("kabalaTree.KabalaTreeCg",callback)
        else
            self:onRecvEventClear()
        end
    else
        local isComplete =  DalMapDataMgr:isFinishStageTask()
        if isComplete then
            DalMapDataMgr:setFinishStageTask()
            local stepPlot = DalMapDataMgr:getStepPlot()
            if stepPlot and stepPlot > 0 then
                self:timeOut(function()
                    local function callback()
                        KabalaTreeDataMgr:playStory(1,stepPlot,function ()
                            DalMapDataMgr:setStepPlot()
                            DalMapDataMgr:showTaskAward()
                            self:onRecvEventClear()
                            EventMgr:dispatchEvent(EV_CG_END)
                        end)
                    end
                    KabalaTreeDataMgr:openCgView("kabalaTree.KabalaTreeCg",callback)
                end,1.5)
            else
                self:onRecvEventClear()
                DalMapDataMgr:showTaskAward()
            end
        else
            local isFinishBossTask = DalMapDataMgr:isFinishBossTask()
            local finalPlot = DalMapDataMgr:getFinalPlot()
            if isFinishBossTask then
                if finalPlot ~= 0 then
                    self:timeOut(function()
                        local function callback()
                            KabalaTreeDataMgr:playStory(1,finalPlot,function ()
                                DalMapDataMgr:setBosstaskState(false)
                                EventMgr:dispatchEvent(EV_CG_END,function()
                                    self.Image_task_bg:setVisible(false)
                                    self.preMovie = false
                                    DalMapDataMgr:showTaskAward(true)
                                end)
                            end)
                        end
                        KabalaTreeDataMgr:openCgView("kabalaTree.KabalaTreeCg",callback)
                    end,1)
                else
                    DalMapDataMgr:setBosstaskState(false)
                    self.Image_task_bg:setVisible(false)
                    self.preMovie = false
                    DalMapDataMgr:showTaskAward(true)
                end
            else
                self:onRecvEventClear()
                DalMapDataMgr:showTaskAward()
            end
        end
    end
end

function DalMapMainView:generateTiledMap()

    local mapCid = DalMapDataMgr:getMapCid()
    if not mapCid then
        return
    end
    self.GenerateDalMap:generateMap(mapCid)
    local tileMap = TiledMapDataMgr:getTileMap()
    if not tileMap then
        return
    end

    self.tileMap = tileMap
    TiledMapDataMgr:setMapScale(self.mapScale)
    TiledMapDataMgr:setGridMapLimit()
    self.tileMap:setName("map")
    self.Panel_root:addChild(self.tileMap)
    self:createNpc()
    self:initMapPrefab()
    self.GenerateItem:initItem(self.Image_dress,self.Panel_npc)
    self:locationPlayer(true)
end

--创建迷你地图
function DalMapMainView:createMiniMap()

    self.DalminiMap:initData(self.Panel_miniMap,self.MiniPlayer:clone(),self.Image_dress)
    local mapCid = DalMapDataMgr:getMapCid()
    if not mapCid then
        return
    end
    self.DalminiMap:createMiniMap(mapCid)

    if self.playerPos then
        self.DalminiMap:locationMiniMap(self.playerPos,true)
        self.DalminiMap:setPlayerPosition(self.playerPos)
    end

end

--创建npc
function DalMapMainView:createNpc()

    if not self.tileMap then
        return
    end

    self.playerPos = DalMapDataMgr:getBirthPos()
    self.Spine_hero = self.Spine_heroItem:clone()
    self.tileMap:addChild(self.Spine_hero)
    self.GenerateNpc:initPlayerInfo(self.Spine_hero,self.playerPos,self.playerModeScale)
    return true
end

function DalMapMainView:uiLogic()

    local curWorld = DalMapDataMgr:getCurWorld()
    local cfg = DalMapDataMgr:getDlsWorldCfg(curWorld)
    if not cfg then
        return
    end
    self.Label_mapname:setTextById(cfg.worldName)
    self.maphelpBtnTx:setText("地图")
    self.statisticsBtnTx:setText("统计")

    self:initTouchEvents()
    self:onUpdateTaskInfo()
    self:onUpdateEventStatistics()
end

function DalMapMainView:initMapPrefab()
    self.Spine_click = self.Spine_clickPrefab:clone()
    self.Spine_click:play("ALL",true)
    self.tileMap:addChild(self.Spine_click)
end

function DalMapMainView:initTouchEvents()

    self.isMulTouch = false
    self.centerPosMN = nil
    self.touch1 = nil
    self.touch2 = nil
    self.lastDis = 0
    self.touchNode:OnBegan(function(sender, pos)
        self.touch1 = pos
        self:touchBegin(self.touch1,pos)
        if self.touchNode2  == nil then
            self.touchNode2 = CCNode:create()
            self.touchNode2:setSize(me.winSize)
            self.Panel_touch:addChild(self.touchNode2)
            self.touchNode2:setAnchorPoint(ccp(0.5,0.5))
            self.touchNode2:OnBegan(function(sender, pos)
                if self.touch1 == nil then
                    return
                end
                self.touch2 = pos
                self.lastDis = math.sqrt(math.pow((pos.x - self.touch1.x),2) + math.pow((pos.y - self.touch1.y),2))
                self.isMulTouch = true
                self:setMulSwallowTouch(true)
            end)
            self.touchNode2:OnMoved(function(sender, pos)
                if self.touch1 == nil then
                    return
                end
                self.touch2 = pos
                if self.isMulTouch  and self.touch1 ~= nil then
                    local curDis = math.sqrt(math.pow((pos.x - self.touch1.x),2) + math.pow((pos.y - self.touch1.y),2))
                    local scale = (curDis - self.lastDis) / 70
                    self.lastDis = curDis
                    local center = ccp((pos.x + self.touch1.x) / 2, (pos.y + self.touch1.y) / 2)
                    --放大缩小
                    local point = me.p(self.tileMap:convertToNodeSpace(center))
                    local posM,posN = TiledMapDataMgr:convertToMN(point.x,point.y)
                    if not self.centerPosMN then
                        self.centerPosMN = ccp(posM,posN)
                    end
                    self:scaleMap(scale,center,self.centerPosMN)
                end
            end)
            self.touchNode2:OnEnded(function(sender, pos)
                self.touch2 = nil
                self.centerPosMN = nil
                self.isMulTouch = false
            end)
        end
    end)
    self.touchNode:OnMoved(function(sender, pos)
        if not self.isMulTouch and self.touch1 ~= nil then
            --滑动
            self:touchMoved(self.touch1,pos)
        end
        self.touch1 = pos
    end)

    self.touchNode:OnEnded(function(sender, pos)
        self.touch1 = nil
        self.isMulTouch = false
        if self.touchNode2 then
            self.touchNode2:removeFromParent(true)
            self.touchNode2 = nil
        end
        self:touchEnd(self.touch1,pos)
        self:setMulSwallowTouch(false)
    end)

    self.touchNode:OnExit(function(sender)
        if not tolua.isnull(self.touchNode2)  then
            self.touchNode2:removeFromParent(true)
            self.isMulTouch = false
        end
    end)

end

function DalMapMainView:setMulSwallowTouch(flag)
    if flag then
        self.touchNode:setTouchEnabled(true)
        self.touchNode:setSwallowTouch(true)
    else
        self.touchNode:setTouchEnabled(true)
        self.touchNode:setSwallowTouch(false)
    end
end

function DalMapMainView:touchBegin(touch,touchPos)

    if not self.tileMap then
        return
    end
    self.mapTouchBeginPos = touchPos
end

function DalMapMainView:touchMoved(touch,touchPos)

    if not self.tileMap then
        return
    end

    self.mapContainerPrePos = self.mapContainerPos
    self.mapContainerPos = touchPos
    if self.mapContainerPos and self.mapContainerPrePos then

        --[[local palyerState = self.GenerateNpc:getPlayerState()
        if palyerState == "moving" then
            return
        end]]

        self.mapContainerDiffPos = ccp(self.mapContainerPos.x - self.mapContainerPrePos.x, self.mapContainerPos.y - self.mapContainerPrePos.y)
        local targetPos = me.pAdd(ccp(self.tileMap:getPositionX(),self.tileMap:getPositionY()),self.mapContainerDiffPos)
        TiledMapDataMgr:detectEdges(targetPos)
        self.tileMap:setPosition(targetPos)
    end
end

function DalMapMainView:touchEnd(touch,touchPos)

    self.mapContainerPrePos = nil
    self.mapContainerPos = nil
    self.mapContainerDiffPos = nil

    if not self.tileMap or not self.mapTouchBeginPos then
        return
    end

    local touchEndPos = touchPos
    local dis = me.pGetDistance(self.mapTouchBeginPos,touchEndPos)
    if dis < self.minTouchMoveDis then
        Utils:playSound(2001)
        self:clickTiled(touchPos)
    end
end

function DalMapMainView:scaleMap(scale,center,centerMN)

    if not self.tileMap then
        return
    end

    if scale >0 and self.mapScale >= self.maxScale then
        return
    end

    if scale <0 and self.mapScale <= self.minScale then
        return
    end

    scale = scale or 0
    self.mapScale = self.mapScale + scale
    self.mapScale = clamp(self.mapScale, self.minScale, self.maxScale)

    TiledMapDataMgr:setMapScale(self.mapScale)
    TiledMapDataMgr:setGridMapLimit()
    if not centerMN then
        centerMN = self.GenerateNpc:getPositiontMN()
    end

    local targetPosition = TiledMapDataMgr:convertToPos(centerMN.x,centerMN.y)
    local mapPosX, mapPosY = TiledMapDataMgr:getMapContaierPos(targetPosition)
    local position = TiledMapDataMgr:detectEdges(ccp(mapPosX,mapPosY))
    self.tileMap:setPosition(position)
end

function DalMapMainView:clickTiled(touchPos)

    if self.preMovie then
        return
    end

    local point = me.p(self.tileMap:convertToNodeSpace(touchPos))
    local posM,posN = TiledMapDataMgr:convertToMN(point.x,point.y)
    local curPosMN = self.GenerateNpc:getPositiontMN()
    if not curPosMN then
        return
    end

    local existTiled = TiledMapDataMgr:isExistTiled(ccp(posM,posN))
    if not existTiled then
        return
    end

    local opacity = TiledMapDataMgr:getTileOpacity(ccp(posM,posN))
    if opacity == 0 then
        return
    end
    print("click:",posM,posN)
    if curPosMN.x == posM and curPosMN.y == posN then
        return
    end

    if not self.locationEnd then
        return
    end
    
    local palyerState = self.GenerateNpc:getPlayerState()
    if palyerState ~= "moving" then

        local inScreen = TiledMapDataMgr:checkInScreen(curPosMN)
        if not inScreen then
            self.locationEnd = false
            self:locationPlayer(false,function()
                self.locationEnd = true
                self:findPath(curPosMN,ccp(posM,posN))
            end)
        else
            self:findPath(curPosMN,ccp(posM,posN))
        end
    else
        self.GenerateNpc:stopMove(function()
            local curPosMN = self.GenerateNpc:getPositiontMN()
            if not curPosMN then
                return
            end
            self:findPath(curPosMN,ccp(posM,posN))
        end)
        --
    end
end

function DalMapMainView:findPath(srcPos,desPos)

    --走完一格
    local function finishStep()
        self:playerFinishStep()
    end

    --到达目的地
    local function finishMove()
        self:playerFinishMove()
    end

    self.TiledMapAStarPath:initData(srcPos,desPos)
    local result = self.TiledMapAStarPath:findAStarPath()
    if result then
        local path = self.TiledMapAStarPath:getPath()
        --self:paintPathDot(path)
        self.GenerateNpc:startMove(path,finishMove,finishStep)
        self:paintDesSpine(desPos)
    else
        --Utils:showTips(3005022);
    end
end

function DalMapMainView:playerFinishStep()
    --self:followPlayer()
end

function DalMapMainView:followPlayer()

    local posMN = self.GenerateNpc:getPositiontMN()
    local targetPosition = TiledMapDataMgr:convertToPos(posMN.x,posMN.y)
    local mapPosX, mapPosY = TiledMapDataMgr:getMapContaierPos(targetPosition)
    local position = TiledMapDataMgr:detectEdges(ccp(mapPosX,mapPosY))
    self.tileMap:runAction(MoveTo:create(0.5,position))
end

--移动到目的地
function DalMapMainView:playerFinishMove()
    self:clearPathDot()
end

--清除路径点
function DalMapMainView:clearPathDot()

    if self.Spine_click then
        self.Spine_click:setVisible(false)
    end

end

--显示目标点箭头N
function DalMapMainView:paintDesSpine(desPos)

    local mapItem = TiledMapDataMgr:getMapItem(desPos.x.."-"..desPos.y)
    if mapItem then
        return
    end

    local position = TiledMapDataMgr:convertToPos(desPos.x,desPos.y)
    position =  TiledMapDataMgr:convertToPosAR(position.x,position.y)
    self.Spine_click:setVisible(true)
    self.Spine_click:setPosition(ccp(position.x-10,position.y-8))
    local zorder = TiledMapDataMgr:getTileZorder(desPos.x,desPos.y)
    self.Spine_click:setZOrder(zorder)
end

function DalMapMainView:startSpawnTileByServer(targetPos,newTitled)
    if not newTitled then
        return
    end

    local foundPoints = {}
    for k,v in pairs(newTitled) do
        local pos = v.x.."-"..v.y
        foundPoints[pos] = ccp(v.x,v.y)
    end

    local tileAppearing = DalMapDataMgr:getTileAppearing()
    local x,y = targetPos.x,targetPos.y
    for i = -tileAppearing,tileAppearing do
        for j = -tileAppearing,tileAppearing do
            if i ~= 0 or j ~= 0 then
                local posX,posY = x+i,y+j
                local pos = posX.."-"..posY
                if foundPoints[pos] then
                    table.insert(self.aroundTile,ccp(posX,posY))
                end
            end
        end
    end

    self:spawnAroundTile()
end

function DalMapMainView:spawnAroundTile()

    if not self.tileMap then
        return
    end

    self.spawningTile = true
    local curTile = self.aroundTile[#self.aroundTile]
    if not curTile then
        self.spawningTile = false
        return
    end
    table.remove(self.aroundTile,#self.aroundTile)

    local spawnTime = 0.5
    local floorGidId = DalMapDataMgr:getFloorGidId(curTile.x.."-"..curTile.y)
    if not floorGidId then
        self:spawnAroundTile(0.5,callback)
        return
    end

    local offsetY = 80
    local floorLayer = self.tileMap:getLayer("floor")
    local curGidId = floorLayer:getTileGIDAt(curTile)
    if curGidId == 0 then

        floorLayer:setTileGID(floorGidId,curTile)
        self.DalminiMap:spawnNewTile(curTile)
        EventMgr:dispatchEvent(EV_DAL_MAP.MiniMapSpwanTiled,curTile)

        local tileImg = floorLayer:getTileAt(curTile)
        if not tileImg then
            self:spawnAroundTile()
            return
        end
        tileImg:setOpacity(0)
        local position = tileImg:getPosition()
        tileImg:setPosition(ccp(position.x,position.y-offsetY))
        local spawnAction = Spawn:create({
            FadeIn:create(spawnTime),
            MoveTo:create(spawnTime,ccp(position.x,position.y))
        })
        local seq = Sequence:create({
            spawnAction,
            CallFunc:create(function ()
                self:insertDressTile(curTile)
                self:spawnAroundTile()
                self.GenerateItem:spawnNewDressItem(curTile)
                self:spawnEventObject(curTile)
            end)
        })
        tileImg:runAction(seq)
    else
        self:spawnAroundTile()
    end
end

--检测是否是装饰格子
function DalMapMainView:insertDressTile(tilePosMN)

    local tilePosStr = tilePosMN.x.."-"..tilePosMN.y
    local dressInfo = DalMapDataMgr:getDressGidId(tilePosStr)
    if not dressInfo then
        return
    end

    DalMapDataMgr:setDressTiledOpen(tilePosStr)

    local dressSelfGid = dressInfo.gid

    local mapCid = DalMapDataMgr:getMapCid()
    local serverDataCfg = DalMapDataMgr:getServerDataCfg(mapCid)
    if not serverDataCfg then
        return
    end
    local mapType = serverDataCfg.mapType
    local dressResInfo = DalMapDataMgr:getDressCfgRes(mapType,dressSelfGid)
    local painted = DalMapDataMgr:getPaintedDressItem(tilePosStr)
    if painted then
        return
    end

    if dressResInfo.tileType == 2 then
        for i = -1,1 do
            local newPosY = tilePosMN.y + i
            if newPosY ~= tilePosMN.y then
                local tileInfo = DalMapDataMgr:getDressGidId(tilePosMN.x.."-"..newPosY)
                if tileInfo and dressSelfGid == tileInfo.gid then
                    table.insert(self.aroundTile,ccp(tilePosMN.x,newPosY))
                end
            end
        end
    elseif dressResInfo.tileType == 3 then
        for i = -1,1 do
            local newPosX = tilePosMN.x + i
            if newPosX ~= tilePosMN.x then
                local tileInfo = DalMapDataMgr:getDressGidId(newPosX.."-"..tilePosMN.y)
                if tileInfo and dressSelfGid == tileInfo.gid then
                    table.insert(self.aroundTile,ccp(newPosX,tilePosMN.y))
                end
            end
        end
    elseif dressResInfo.tileType == 4 then
        local range = DalMapDataMgr:getTileAppearing()
        local roundTileds = TiledMapDataMgr:getAroundTileds(tilePosMN,range)
        for k,v in ipairs(roundTileds) do
            local tileInfo = DalMapDataMgr:getDressGidId(v.x.."-"..v.y)
            if tileInfo and dressSelfGid == tileInfo.gid then
                table.insert(self.aroundTile,v)
            end
        end
    end
end

--格子上的资源模型
function DalMapMainView:spawnEventObject(tilePosMN)

    local tilePosStr = tilePosMN.x.."-"..tilePosMN.y
    local mapTileInfo = DalMapDataMgr:getMapTileInfo(tilePosStr)
    if not mapTileInfo then
        return
    end

    local eventRes,smallRes,offset,scaleInMap,isDelete,spineRes,npcName = DalMapDataMgr:getTileEventRes(mapTileInfo.event)
    if not eventRes or not offset or not scaleInMap or not smallRes or not spineRes or not npcName then
        return
    end

    self.GenerateItem:spawnNewItem(tilePosMN,eventRes,smallRes,offset,scaleInMap,spineRes,npcName)
    self.DalminiMap:spawnNewItem(tilePosMN,smallRes,offset,scaleInMap)
    EventMgr:dispatchEvent(EV_DAL_MAP.MiniMapSpwanItem,tilePosMN,smallRes,offset,scaleInMap)
end

function DalMapMainView:locationPlayer(isInit,callback)

    if not self.tileMap then
        return
    end

    self.tileMap:setOpacity(0)
    local posMN = self.GenerateNpc:getPositiontMN()
    if not posMN then
        return
    end

    local targetPosition = TiledMapDataMgr:convertToPos(posMN.x,posMN.y)
    local mapPosX, mapPosY = TiledMapDataMgr:getMapContaierPos(targetPosition)
    local position = TiledMapDataMgr:detectEdges(ccp(mapPosX,mapPosY))

    local sact
    if isInit then
        self.tileMap:setPosition(position)
        sact = FadeIn:create(0.5)
    else
        sact =  Spawn:create({
            FadeIn:create(0.5),
            MoveTo:create(0.5,position)
        })
    end
    local sequence = Sequence:create({
        sact,
        CallFunc:create(function ()
            if callback then
                callback()
            end
        end)
    })
    self.tileMap:runAction(sequence)
end

---------------------------------------------------------------------------------------------
---请求地图信息反馈
function DalMapMainView:onRecvGetMap()
    self:enterMap()
end

----移动反馈
function DalMapMainView:onPlayerMoveTo(targetPos,newTitled)

    if not targetPos then
        return
    end

    local curPos =  self.GenerateNpc:getPositiontMN()
    if curPos and targetPos.x == curPos.x and targetPos.y == curPos.y then
        self:clearPathDot()
        self.GenerateNpc:setPalyerState("stand")
        return
    end

    local res = self.GenerateNpc:MoveTo(targetPos)
    if not res then
        self:clearPathDot()
        self.GenerateNpc:setPalyerState("stand")
        return
    end

    self:startSpawnTileByServer(targetPos,newTitled)
    self.DalminiMap:playerMove(targetPos)
    EventMgr:dispatchEvent(EV_DAL_MAP.MiniMapPlayerMove,targetPos)
end

---触发事件
function DalMapMainView:onRecvTriggerEvent(eventId,tiledPosMN)

    self:clearPathDot()
    self.GenerateNpc:stopMove()

    if not eventId then
        return
    end
    print(eventId)
    local dlsEventCfg = DalMapDataMgr:getDlsEventCfg(eventId)
    if not dlsEventCfg then
        return
    end

    local eventType = dlsEventCfg.eventType
    local eventParam = dlsEventCfg.eventParam
    local eventText = dlsEventCfg.eventText

    if eventType == Enum_TriggerEventType.EventType_Fight  then
        local ambushId = eventParam[1]
        Utils:openView("dalMap.DalMapFight",ambushId)
    elseif eventType == Enum_TriggerEventType.EventType_TaskStory then
        self.preMovie = true
        local plotId = eventParam[1]
        if plotId and plotId > 0 then
            local function callback()
                KabalaTreeDataMgr:playStory(1,plotId,function()
                    local msg = {
                        tiledPosMN.x,
                        tiledPosMN.y,
                        eventId
                    }
                    TFDirector:send(c2s.OFFICE_EXPLORE_OFFICE_PERFORM_EVENT, msg)
                    if dlsEventCfg.isDelete then
                        self.GenerateItem:cleanItem(tiledPosMN)
                        self.DalminiMap:cleanItem(tiledPosMN)
                        EventMgr:dispatchEvent(EV_DAL_MAP.MiniMapCleanItem,tiledPosMN)
                        DalMapDataMgr:updateStatisticsData(eventId)
                    end
                    self.preMovie = false
                    EventMgr:dispatchEvent(EV_CG_END)
                end)
            end
            KabalaTreeDataMgr:openCgView("kabalaTree.KabalaTreeCg",callback)
        end
    elseif eventType == Enum_TriggerEventType.EventType_Transport then
        if #eventParam ~= 0 then
            self:timeOut(function()
                Utils:openView("dalMap.DalMapTransport",eventParam,eventText)
            end,0.6)
        end
    end
end

---删除格子道具
function DalMapMainView:onRecvCleanItem(tiledPosMN,originalEventId)

    Utils:playSound(2002)
    self.GenerateItem:cleanItem(tiledPosMN)
    self.DalminiMap:cleanItem(tiledPosMN)
    EventMgr:dispatchEvent(EV_DAL_MAP.MiniMapCleanItem,tiledPosMN)
    if originalEventId >0 then
        DalMapDataMgr:updateStatisticsData(originalEventId)
    end
    self:onUpdateEventStatistics()
end

---传送
function DalMapMainView:onRecvTransfer(targetPosMN,newTitled)

    if not self.tileMap then
        return
    end

    local floorGidId = DalMapDataMgr:getFloorGidId(targetPosMN.x.."-"..targetPosMN.y)
    if not floorGidId then
        Box("Wrong targetPos:"..targetPosMN.x.."-"..targetPosMN.y)
        return
    end

    local floorLayer = self.tileMap:getLayer("floor")
    local curGidId = floorLayer:getTileGIDAt(targetPosMN)
    if curGidId == 0 then
        floorLayer:setTileGID(floorGidId,targetPosMN)
        self.DalminiMap:spawnNewTile(targetPosMN)
    end

    local inScreen = TiledMapDataMgr:checkInScreen(targetPosMN)
    self.GenerateNpc:transfor(targetPosMN,function()
        if not inScreen then
            self:locationPlayer(false,function()
                self.DalminiMap:locationMiniMap(targetPosMN,true)
                self.DalminiMap:setPlayerPosition(targetPosMN)
            end)
        else
            self.DalminiMap:locationMiniMap(targetPosMN,true)
            self.DalminiMap:setPlayerPosition(targetPosMN)
        end
        EventMgr:dispatchEvent(EV_DAL_MAP.MiniMapTransfer,targetPosMN)
        self:startSpawnTileByServer(targetPosMN,newTitled)
    end)

end

---刷新地图数据(完成任务之后)
function DalMapMainView:onUpdateMapInfo(updateMapData)

    if not updateMapData then
        return
    end

    for k,v in pairs(updateMapData) do
        local tilePosX,tilePosY = v.x,v.y
        local isOpen = DalMapDataMgr:isOpen(ccp(tilePosX,tilePosY))
        if isOpen then
            if v.event > 0 then
                self:spawnEventObject(ccp(tilePosX,tilePosY))
            else
                self.GenerateItem:cleanItem(ccp(tilePosX,tilePosY))
                self.DalminiMap:cleanItem(ccp(tilePosX,tilePosY))
                EventMgr:dispatchEvent(EV_DAL_MAP.MiniMapCleanItem,ccp(tilePosX,tilePosY))
            end
            --self.GenerateDalMap:updateTiled(ccp(tilePosX,tilePosY),isOpen)
        end
    end
    self:onUpdateEventStatistics()
end

---播放剧情的小游戏特殊判断
function DalMapMainView:isGameTask(missionId)

    local missionCfg = DalMapDataMgr:getDlsMissionCfg(missionId)
    if not missionCfg then
        return
    end

    if missionCfg.missionType ~= 1007 then
        return
    end

    local eventID = missionCfg.eventID
    local eventCfg = DalMapDataMgr:getDlsEventCfg(eventID)
    if not eventCfg then
        return
    end

    if eventCfg.eventType ~= 15 then
        return
    end

    local gameId = eventCfg.eventParam[1]
    local gameCfg = DalMapDataMgr:getDlsgameCfg(gameId)
    if not gameCfg then
        return
    end

    if gameCfg.gameType ~= 1006 then
        return
    end

    return true
end

---刷新任务
function DalMapMainView:onUpdateTaskInfo(isCompete,plotId)

    self.Image_task_bg:setVisible(true)
    local missions = DalMapDataMgr:getMapMission()
    if not next(missions) then
        self.Image_task_bg:setVisible(false)
        return
    end

    --完成阶段任务
    if isCompete then
        local isFinishBossTask = DalMapDataMgr:isFinishBossTask()
        if isFinishBossTask then
            local gameTask = self:isGameTask(missions[1].missionId)
            if not gameTask then

                local finalPlot = DalMapDataMgr:getFinalPlot()
                if finalPlot ~= 0 then
                    self:timeOut(function()
                        local function callback()
                            KabalaTreeDataMgr:playStory(1,finalPlot,function ()
                                DalMapDataMgr:setBosstaskState(false)
                                EventMgr:dispatchEvent(EV_CG_END,function()
                                    self.Image_task_bg:setVisible(false)
                                    self:onRecvEventClear()
                                    DalMapDataMgr:showTaskAward(true)
                                end)
                            end)
                        end
                        KabalaTreeDataMgr:openCgView("kabalaTree.KabalaTreeCg",callback)
                    end,1)
                else
                    --self:timeOut(function()
                        --DalMapDataMgr:setBosstaskState(false)
                        self.Image_task_bg:setVisible(false)
                        --self:onRecvEventClear()
                        --DalMapDataMgr:showTaskAward(true)
                    --end,1)
                end
            else
                self.Image_task_bg:setVisible(false)
            end
            return
        end

        DalMapDataMgr:setFinishStageTask()
        if plotId and plotId > 0 then
            self.preMovie = true
            self:timeOut(function()
                local function callback()
                    KabalaTreeDataMgr:playStory(1,plotId,function()
                        DalMapDataMgr:setStepPlot()
                        local kabalaTreeAwardInst = DalMapDataMgr:getAwardInst()
                        if kabalaTreeAwardInst then
                            DalMapDataMgr:setAwardInst(nil)
                            AlertManager:closeLayer(kabalaTreeAwardInst)
                        end
                        self.preMovie = false
                        EventMgr:dispatchEvent(EV_CG_END)
                    end)
                end
                KabalaTreeDataMgr:openCgView("kabalaTree.KabalaTreeCg",callback)
            end,1.5)
        else
            DalMapDataMgr:setStepPlot()
            local kabalaTreeAwardInst = DalMapDataMgr:getAwardInst()
            if kabalaTreeAwardInst then
                DalMapDataMgr:setAwardInst(nil)
                AlertManager:closeLayer(kabalaTreeAwardInst)
            end
        end
    end

    local taskStageDesc
    local isFinalTask,finalTaskDesc = DalMapDataMgr:isBossTask(missions[1].missionId)
    if isFinalTask then
        taskStageDesc = finalTaskDesc
    else
        local taskStageId = DalMapDataMgr:getMissionStage(missions[1].missionId)
        if not taskStageId then
            return
        end
        taskStageDesc = DalMapDataMgr:getTaskStageDesc(taskStageId)
    end

    if not taskStageDesc then
        return
    end

    local taskDescId,taskDescType = taskStageDesc[1],taskStageDesc[2]
    if not taskDescId or not taskDescType then
        return
    end

    local taskType = DalMapDataMgr:getDlsMissionCfg(missions[1].missionId).missionType

    local finishCnt = 0
    local taskCnt = 0
    local monsterFinshCnt = {}
    local monsterTaskCnt = {}
    local monsterNameId = {}
    local monsteCnt = 0
    self.searchTask = {}

    for k,v in ipairs(missions) do
        --显示方式找策划对
        self.nameTextId,targetNum,isSearchTask = DalMapDataMgr:getTaskTargetInfo(v.missionId)
        if taskType == 1001 or taskType == 1004 then
            finishCnt = finishCnt + v.progress
            taskCnt = taskCnt + targetNum
        elseif taskType == 1003 then
            local taskInfo = DalMapDataMgr:getDlsMissionCfg(v.missionId)
            if taskInfo then
                local monsterId = taskInfo.checkParam[2]
                if not monsterFinshCnt[monsterId] then
                    monsterFinshCnt[monsterId] = 0
                    monsteCnt = monsteCnt + 1
                end
                monsterFinshCnt[monsterId] =  monsterFinshCnt[monsterId] + v.progress

                if not monsterTaskCnt[monsterId] then
                    monsterTaskCnt[monsterId] = 0
                end
                monsterTaskCnt[monsterId] =  monsterTaskCnt[monsterId] + targetNum
                monsterNameId[monsterId] = self.nameTextId
            end
        else
            finishCnt = v.progress
            taskCnt = targetNum
        end

        if isSearchTask == true and  v.progress == 0 then
            table.insert(self.searchTask,v.missionId)
        end
    end

    if isFinalTask then
        self.Image_task_bg:setVisible(not (finishCnt == taskCnt))
    end

    local taskStr = TextDataMgr:getTextAttr(taskDescId).text
    if taskDescType == 1 then
        if taskType == 1003 then
            local str = "\n"
            local index = 1
            for k,v in pairs(monsterTaskCnt) do

                local nameStr = TextDataMgr:getText(monsterNameId[k])
                if monsteCnt == index then
                    str = str..nameStr.."("..monsterFinshCnt[k].."/"..monsterTaskCnt[k]..")"
                    break
                else
                    str = str..nameStr.."("..monsterFinshCnt[k].."/"..monsterTaskCnt[k]..")\n"
                end
                index = index + 1
            end
            taskStr = string.format(taskStr,str)
        else
            local nameStr = TextDataMgr:getText(self.nameTextId)
            taskStr = string.format(taskStr,nameStr).."("..finishCnt.."/"..taskCnt..")"
        end
    end

    self.Label_task:setText(taskStr)
end

---事件统计百分比
function DalMapMainView:onUpdateEventStatistics()

    local statisticsData = DalMapDataMgr:getStatisticsData()
    if not statisticsData then
        self.Label_event_percent:setText("")
        return
    end

    local finishCnt,totalCnt = 0,0
    for k,v in pairs(statisticsData) do
        finishCnt = finishCnt + (v.count - v.remainCount)
        totalCnt = totalCnt + v.count
    end
    print(finishCnt,totalCnt)
    if totalCnt ~= 0 then
        local percent = math.floor(finishCnt/totalCnt*100)
        self.Label_event_percent:setText(percent.."%")
    else
        self.Label_event_percent:setText("")
    end
end

---事件完成
function DalMapMainView:onRecvEventClear()

    self.preMovie = true
    local finishWorld = DalMapDataMgr:getEventClearWorldCid()
    local curWorldCid = DalMapDataMgr:getCurWorld()
    print(curWorldCid,finishWorld)
    dump("onRecvEventClear")
    if curWorldCid ~= finishWorld then
        self.preMovie = false
        return
    end
    Utils:playSound(204)
    local skeletonNode = SkeletonAnimation:create("effect/effect_discover_01/effect_discover_01")
    skeletonNode:play("animation",0)
    skeletonNode:setAnchorPoint(ccp(0,0))
    self.Panel_UI:addChild(skeletonNode, 1)
    skeletonNode:addMEListener(TFARMATURE_COMPLETE,function(_skeletonNode)
        _skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
        _skeletonNode:removeFromParent()
        DalMapDataMgr:setEventClearWorldCid()
        self.preMovie = false
    end)
end

function DalMapMainView:onCloseDal()
    self:timeOut(function()
        AlertManager:closeLayer(self)
    end,0.1)
end
function DalMapMainView:registerEvents()

    EventMgr:addEventListener(self,EV_DAL_MAP.GetMap,handler(self.onRecvGetMap, self))
    EventMgr:addEventListener(self,EV_DAL_MAP.Move,handler(self.onPlayerMoveTo, self))
    EventMgr:addEventListener(self,EV_DAL_MAP.TriggerEvent,handler(self.onRecvTriggerEvent, self))
    EventMgr:addEventListener(self,EV_DAL_MAP.CleanItem,handler(self.onRecvCleanItem, self))
    EventMgr:addEventListener(self,EV_DAL_MAP.EventClear,handler(self.onRecvEventClear, self))
    EventMgr:addEventListener(self,EV_DAL_MAP.Transfer,handler(self.onRecvTransfer, self))
    EventMgr:addEventListener(self,EV_DAL_MAP.UpdateMap,handler(self.onUpdateMapInfo, self))
    EventMgr:addEventListener(self,EV_DAL_MAP.Task,handler(self.onUpdateTaskInfo, self))
    EventMgr:addEventListener(self,EV_DAL_MAP.CloseDal,handler(self.onCloseDal, self))

    self.Button_maphelp:onClick(function ()
        Utils:openView("kabalaTree.KabalaTreeMapInfo",2)
    end)

    self.Button_statistics:onClick(function ()
        Utils:openView("kabalaTree.KabalaTreeStatistics",2)
    end)

    self.Button_chat:onClick(function ()
        local ChatView = require("lua.logic.chat.ChatView")
        ChatView.show(function ( )
        end,false)
    end)

    self.Panel_miniMap:onClick(function ()

        local curPosMN = self.GenerateNpc:getPositiontMN()
        if not curPosMN then
            return
        end
        DalMapDataMgr:setPlayerPosMN(curPosMN)
        Utils:openView("dalMap.DalBigMiniMap",curPosMN)
    end)
end

return DalMapMainView