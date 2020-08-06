local KabalaTreeBigMiniMap = class("KabalaTreeBigMiniMap", BaseLayer)

function KabalaTreeBigMiniMap:ctor(mapId,playerMN)
    self.super.ctor(self)
    self:initData(mapId,playerMN)
    self:showPopAnim(true)
    self:init("lua.uiconfig.kabalaTree.kabalaTreeBigMiniMap")
end

function KabalaTreeBigMiniMap:initData(mapId,playerMN)

    self.mapId = mapId
    self.playerMN = playerMN

    self.mapScale = 0.1
    self.maxScale = 0.5
    self.minScale = 0.1
    self.aroundTile = {}
    
end

function KabalaTreeBigMiniMap:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui

    self.Panel_base = TFDirector:getChildByPath(self.ui, "Panel_base")
    self.Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab")
    self.Image_item = TFDirector:getChildByPath(self.Panel_prefab, "Image_item")
    self.Image_player = TFDirector:getChildByPath(self.Panel_prefab, "Image_player")
    self.Image_zone = TFDirector:getChildByPath(self.Panel_prefab, "Image_zone")

    self.Button_add = TFDirector:getChildByPath(self.ui, "Button_add")
    self.Button_del = TFDirector:getChildByPath(self.ui, "Button_del")

    if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
        self.Button_add:setVisible(true)
        self.Button_del:setVisible(true)
    else
        self.Button_add:setVisible(false)
        self.Button_del:setVisible(false)
    end

    self.contentSize = self.Panel_base:getContentSize()
    self.touchNode = CCNode:create():AddTo(self.Panel_base)
    self.touchNode:setAnchorPoint(ccp(0.5,0.5))
    self.touchNode:setTouchEnabled(true)
    self.touchNode:setSwallowTouch(false)
    self.touchNode:setSize(self.contentSize)
    TFDirector:setTouchSingled(false)

    local msg = {
        self.mapId
    }    
    TFDirector:send(c2s.QLIPHOTH_PARTICLE_WORLD_INFO, msg) 
end

function KabalaTreeBigMiniMap:onUpdateBigMiniMap()

    --避免地图多次创建
    if self.bigMiniMap then
        return
    end

    self.bigMiniMap = self:generateMap()
    if not self.bigMiniMap or not self.playerMN then
        return
    end

    self.Panel_base:addChild(self.bigMiniMap)
    self:setMapBaseInfo()
end

function KabalaTreeBigMiniMap:generateMap()

    local tileMapRes = KabalaTreeDataMgr:getTileMapRes(self.mapId)
    if not tileMapRes then
        return
    end
    print(tileMapRes)
    local tileMap = TMXTiledMap:create(tileMapRes)    
    if not tileMap then
        return
    end

    return tileMap
end

function KabalaTreeBigMiniMap:setMapBaseInfo()

    self.plainLayer = self.bigMiniMap:getLayer("Plain")
    self.obstacleLayer = self.bigMiniMap:getLayer("Landform")
    self.eventLayer = self.bigMiniMap:getLayer("Event")

    self.bigMiniMap:setScale(self.mapScale)
    self.bigMiniMap:setAnchorPoint(me.p(0.5,0.5))

    self:setPlayerPosition()
    self:initTiledData()
    self:setGridMapLimit()
    self:locationMiniMap(self.playerMN,true)
    self:initGirdItem()
    self:setDiscoverTaskSign()

    self.zoneTip = {}
    local coordinateInfo = KabalaTreeDataMgr:getTextCoordinate()
    for k,posInfo in pairs(coordinateInfo) do
        local tab = {}
        tab.nameId = k
        for x,y in pairs(posInfo) do
            tab.pos = ccp(x,y)
        end
        table.insert(self.zoneTip,tab)
    end
    self:setZoneInfo()
    --滑动
    self:initTouchEvents()
end

function KabalaTreeBigMiniMap:setZoneInfo()

    for k,v in ipairs(self.zoneTip) do
        local cloneItem = self.Image_zone:clone()
        local Label_name = TFDirector:getChildByPath(cloneItem, "Label_name")
        Label_name:setTextById(v.nameId)

        local tilePosMN = v.pos

        local position = KabalaTreeDataMgr:convertToPos(tilePosMN.x,tilePosMN.y)
        position =  KabalaTreeDataMgr:convertToPosAR(position.x,position.y)
        cloneItem:setPosition(position)
        cloneItem:setScale(5)
        self.bigMiniMap:addChild(cloneItem)
    end
end


function KabalaTreeBigMiniMap:initTouchEvents()

    self.isMulTouch = false
    self.touch1 = nil
    self.touch2 = nil
    self.lastDis = 0
    self.touchNode:OnBegan(function(sender, pos)
        self.touch1 = pos
        self:touchBegin(self.touch1,pos)
        if self.touchNode2  == nil then
            self.touchNode2 = CCNode:create()
            self.touchNode2:setSize(me.winSize)
            self.Panel_base:addChild(self.touchNode2)
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
                    local point = me.p(self.bigMiniMap:convertToNodeSpace(center))
                    local posM,posN = KabalaTreeDataMgr:convertToMN(point.x,point.y)
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

function KabalaTreeBigMiniMap:setMulSwallowTouch(flag)
    if flag then
        self.touchNode:setTouchEnabled(true)
        self.touchNode:setSwallowTouch(true)
    else
        self.touchNode:setTouchEnabled(true)
        self.touchNode:setSwallowTouch(false)
    end
end

function KabalaTreeBigMiniMap:touchBegin(touch,touchPos)

    if not self.bigMiniMap then
        return
    end
    self.mapTouchBeginPos = touchPos
end

function KabalaTreeBigMiniMap:touchMoved(touch,touchPos)

    if not self.bigMiniMap then
        return
    end

    self.mapContainerPrePos = self.mapContainerPos
    self.mapContainerPos = touchPos
    if self.mapContainerPos and self.mapContainerPrePos then
        self.mapContainerDiffPos = ccp(self.mapContainerPos.x - self.mapContainerPrePos.x, self.mapContainerPos.y - self.mapContainerPrePos.y)
        local targetPos = me.pAdd(ccp(self.bigMiniMap:getPositionX(),self.bigMiniMap:getPositionY()),self.mapContainerDiffPos)        
        self:detectEdges(targetPos)        
        self.bigMiniMap:setPosition(targetPos)
    end 
end

function KabalaTreeBigMiniMap:touchEnd(touch,touchPos)

    self.mapContainerPrePos = nil
    self.mapContainerPos = nil
    self.mapContainerDiffPos = nil
end

function KabalaTreeBigMiniMap:scaleMap(scale,center,centerMN)

    if not self.bigMiniMap then
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

    self.bigMiniMap:setScale(self.mapScale)
    self:setGridMapLimit()
    if not centerMN then
        centerMN = self.playerMN
    end
    self:locationMiniMap(centerMN,true)
    --[[local point = me.p(self.bigMiniMap:convertToNodeSpace(center))
    print("posM",posM,posN,center.x,center.y,point.x,point.y)
    local posM,posN = KabalaTreeDataMgr:convertToMN(point.x,point.y)
    self:locationMiniMap(ccp(posM,posN),true)]]

    --[[local lc = self.bigMiniMap:convertToNodeSpace(center)
    self.bigMiniMap:setScale(self.mapScale)
    local wc = self.bigMiniMap:convertToWorldSpace(lc)
    print("wc",wc.x,wc.y)
    local ps = self.Panel_base:convertToNodeSpace(wc)
    print("ps",ps.x,ps.y)

    local wseek = self.Panel_base:convertToNodeSpace(wc) - self.Panel_base:convertToNodeSpace(center)
    local seek = wc - center
    self.bigMiniMap:Pos(self.bigMiniMap:Pos() - wseek)
    --self:setGridMapLimit()]]

end

function KabalaTreeBigMiniMap:setPlayerPosition()

    if not self.playerMN then
        return
    end

    if not self.player then
        self.player = self.Image_player:clone()
    end
    self.player:setZOrder(2)
    self.bigMiniMap:addChild(self.player)
    local position = KabalaTreeDataMgr:convertToPos(self.playerMN.x,self.playerMN.y)
    position =  KabalaTreeDataMgr:convertToPosAR(position.x,position.y)
    self.player:setPosition(position)
end

function KabalaTreeBigMiniMap:setDiscoverTaskSign()

    local taskPos = KabalaTreeDataMgr:getDiscoverTaskPos()
    if not taskPos then
        return
    end

    self.skeletonNode = self.bigMiniMap:getChildByName("discoverItem")
    if not self.skeletonNode then
        self.skeletonNode = SkeletonAnimation:create("effect/effect_ui23/effect_ui23")
        self.skeletonNode:setAnchorPoint(ccp(0,0))
        self.skeletonNode:play("animation",1)
        self.skeletonNode:setZOrder(3)
        self.skeletonNode:setScale(6)
        self.bigMiniMap:addChild(self.skeletonNode)
    end

    local position = KabalaTreeDataMgr:convertToPos(taskPos.x,taskPos.y)
    position =  KabalaTreeDataMgr:convertToPosAR(position.x,position.y)
    self.skeletonNode:setPosition(position)

end


function KabalaTreeBigMiniMap:playerMove(posMN)

    if not posMN then
        return
    end
    self.playerMN = posMN
    local position = KabalaTreeDataMgr:convertToPos(posMN.x,posMN.y)
    position =  KabalaTreeDataMgr:convertToPosAR(position.x,position.y)
    self:locationMiniMap(posMN)
    self:Moving(position)
end

function KabalaTreeBigMiniMap:Moving(position)

    if not self.player then
        return
    end

    local action = Sequence:create({
        MoveTo:create(0.5,position),
        CallFunc:create(function()
            self.player:setPosition(position)
        end)
    })
    self.player:runAction(action)
end

function KabalaTreeBigMiniMap:initTiledData()

    local isStronghold = KabalaTreeDataMgr:checkIsStrongHold()
    if not isStronghold then
        KabalaTreeDataMgr:clearNewOpenTitled()
        KabalaTreeDataMgr:clearStronghold()
    end

    local tileXCount,tileYCount = KabalaTreeDataMgr:getTileXYCount()
    for i=0,tileXCount-1 do
        for j=0,tileYCount-1 do

            local isOpen = KabalaTreeDataMgr:isOpen(ccp(i,j))
            local opacity = isOpen and 255 or 0
            self:spawnNormalTile(ccp(i,j),opacity)

            --[[如果是占领后的据点的特殊处理
            local strnghold = KabalaTreeDataMgr:getStronghold()
            if strnghold and strnghold.x == i and strnghold.y == j then
                local tiledGid = KabalaTreeDataMgr:getGroundLayerGid(EC_EventLayerGid.Tile_Red)
                self.plainLayer:setTileGID(tiledGid,ccp(i,j))
            end]]

            --隐藏事件层(不能在地图编辑器中设置为不可见，否则会读取不到该层的信息)
            local tileSprite = self.eventLayer:getTileAt(ccp(i,j))
            if tileSprite then
                tileSprite:setVisible(false)
            end
        end
    end
end

--生成普通层格子
function KabalaTreeBigMiniMap:spawnNormalTile(tilePosMN,opacity,isAdd)

    if not self.plainLayer then
        return
    end

    local tileGid = self.plainLayer:getTileGIDAt(tilePosMN)
    if tileGid == 0 then
        return
    end

    local tiledGid = KabalaTreeDataMgr:getGroundLayerGid(EC_EventLayerGid.Tile_SmallNormal)
    if not self.obstacleLayer then
        return
    end

    local obstacleImg = self.obstacleLayer:getTileAt(tilePosMN)
    if obstacleImg then
        obstacleImg:setVisible(false)
    end
    
    local eventGid = self.eventLayer:getTileGIDAt(tilePosMN)
    if eventGid == 2 then
        tiledGid = KabalaTreeDataMgr:getGroundLayerGid(EC_EventLayerGid.Tile_SmallObstruct)
    end

    --[[取消事件格子
    local eventId,eventValid = KabalaTreeDataMgr:getEventId(tilePosMN)
    local isDelete = false
    if eventId then
        tiledGid,isDelete = KabalaTreeDataMgr:getTileGIdByEventId(eventId,eventValid)
    end]]


    --opacity = 255--(格子全部打开)
    if opacity == 255 then
        self.plainLayer:setTileGID(tiledGid,tilePosMN)
    else
        self.plainLayer:setTileGID(0,tilePosMN)
    end
end

function KabalaTreeBigMiniMap:initGirdItem()
    self.mapItem = {}
    self.KabalaTreeItemMap = KabalaTreeDataMgr:getKabalaTreeItemMap()
    for k,v in pairs(self.KabalaTreeItemMap) do   
        self:createItem(v.pos,v.smallRes,v.offset,v.scaleInMap) 
    end
end

--格子上的资源模型
function KabalaTreeBigMiniMap:spawnEventObject(tilePosMN)

    local eventId,eventValid = KabalaTreeDataMgr:getEventId(tilePosMN)
    if not eventId then
        return
    end

    local eventType,eventRes,smallRes,offset,scaleInMap = KabalaTreeDataMgr:getTileEventRes(eventId,eventValid)
    if not eventType or not eventRes or not offset or not scaleInMap or not smallRes then
        return
    end

    self:createItem(tilePosMN,smallRes,offset,scaleInMap)
end

function KabalaTreeBigMiniMap:createItem(tilePosMN,itemRes,offset,scaleInMap)

    for k,v in pairs(self.mapItem) do
        if v.pos.x == tilePosMN.x and tilePosMN.y == v.pos.y then
            return
        end
    end

    local position = KabalaTreeDataMgr:convertToPos(tilePosMN.x,tilePosMN.y)
    position =  KabalaTreeDataMgr:convertToPosAR(position.x,position.y)

    local Image_mapItem = self.Image_item:clone()
    local offsetX = 0
    local offsetY = -130
    Image_mapItem:setPosition(ccp(position.x+offsetX,position.y+offsetY))
    Image_mapItem:setZOrder(1)
    scaleInMap = 1
    Image_mapItem:setScale(scaleInMap)
    Image_mapItem:setOpacity(0)
    Image_mapItem:setTexture(itemRes)
    local seqact = Sequence:create({
        FadeIn:create(0.5),
        CallFunc:create(function ()
            local offsetY = 10
            local seqact = Sequence:create({
                MoveBy:create(0.5, ccp(0, offsetY)),
                MoveBy:create(0.5, ccp(0, -offsetY)),
            })
            Image_mapItem:runAction(RepeatForever:create(seqact))
        end)
    })
    Image_mapItem:runAction(seqact)
    self.bigMiniMap:addChild(Image_mapItem)

    table.insert(self.mapItem,{pos = tilePosMN,item = Image_mapItem})
end

function KabalaTreeBigMiniMap:cleanItem(tilePosMN)

    if not self.mapItem then
        return
    end
    local item,index 
    for k,v in pairs(self.mapItem) do
        if v.pos.x == tilePosMN.x and tilePosMN.y == v.pos.y then
            item = v.item
            index = k
        end
    end
    if not item or not self.bigMiniMap then
        return
    end

    local function acFun()
        item:removeFromParent()
        table.remove(self.mapItem,index)
    end

    local seqact = Sequence:create({
        FadeOut:create(0.5),
        CallFunc:create(acFun)
    })
    item:runAction(seqact)
end

function KabalaTreeBigMiniMap:locationMiniMap(posMN,isInit)

    if not self.bigMiniMap or not posMN then
        return
    end

    local targetPosition = KabalaTreeDataMgr:convertToPos(posMN.x,posMN.y)
    local mapPosX, mapPosY = self:getMapContaierPos(targetPosition)
    local position = self:detectEdges(ccp(mapPosX,mapPosY)) 
    if not isInit then
        self.bigMiniMap:runAction(MoveTo:create(0.5,position))
    else
        self.bigMiniMap:setPosition(position)
    end
end

function KabalaTreeBigMiniMap:getMapContaierPos(targetPos)

    local tileXCount,tileYCount = KabalaTreeDataMgr:getTileXYCount()
    local tileWidth,tileHeight  = KabalaTreeDataMgr:getTileSize()

    local mappos = self.bigMiniMap:getPosition() 
    local mapPosX = (tileXCount*tileWidth/2 - targetPos.x)*self.mapScale
    local mapPosY = (tileYCount*tileHeight/2 - targetPos.y)*self.mapScale
    return mapPosX, mapPosY
end

--设置地图拖动边界
function KabalaTreeBigMiniMap:setGridMapLimit()

    if not self.bigMiniMap then
        return
    end

    local winSize = me.Director:getVisibleSize()
    local point = self.bigMiniMap:getAnchorPoint()
    local tileXCount,tileYCount = KabalaTreeDataMgr:getTileXYCount()
    local tileWidth,tileHeight  = KabalaTreeDataMgr:getTileSize()
    print("self.mapScale",self.mapScale)
    self.limitLW = winSize.width/2 - tileWidth * tileXCount * self.mapScale /2
    print("self.limitLW:",self.limitLW)
    if self.limitLW > 0 then
        self.limitLW = -self.limitLW
    end
    self.limitRW = -self.limitLW
    self.limitDH = winSize.height/2 - tileHeight * tileYCount * self.mapScale /2
    print("self.limitDH:",self.limitDH)
    if self.limitDH > 0 then
        self.limitDH = -self.limitDH
    end
    self.limitUH = -self.limitDH
        
end

function KabalaTreeBigMiniMap:detectEdges(point)
    
    if point.x > self.limitRW then
        point.x = self.limitRW
    end
    if point.x < self.limitLW then
        point.x = self.limitLW
    end
    if point.y > self.limitUH  then
        point.y = self.limitUH
    end 
    if point.y < self.limitDH -180 then
        point.y = self.limitDH -180
    end

    return point
end

function KabalaTreeBigMiniMap:startSpawnTileByServer(targetPos,newTitled)
    if not newTitled then
        return
    end

    if not self.plainLayer then
        return
    end

    local newOpenTitled = {}
    local foundPoints = {}
    for k,v in pairs(newTitled) do
        local pos = v.x.."-"..v.y
        foundPoints[pos] = ccp(v.x,v.y)
    end

    local x,y = targetPos.x,targetPos.y
    local around = {}
    for i = -3,3 do
        for j = -3,3 do
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

--产生周围的格子
function KabalaTreeBigMiniMap:spawnAroundTile()

    local curTile = self.aroundTile[1]
    if not curTile then
        return
    end
    table.remove(self.aroundTile,1)
    local originalGid = KabalaTreeDataMgr:getOriginalGid(curTile)
    if originalGid then
        self.plainLayer:setTileGID(originalGid,curTile)
    end
    self:spawnNormalTile(curTile,255,true)
    self:spawnEventObject(curTile)

    local tileImg = self.plainLayer:getTileAt(curTile)
    local seq = Sequence:create({
        FadeIn:create(0.5),
        CallFunc:create(function ()                
            self:spawnAroundTile()
        end)
    })
    tileImg:runAction(seq)
end

--移动
function KabalaTreeBigMiniMap:onPlayerMoveTo(targetPos,newTitled)

    if not targetPos then
        return
    end

    self:startSpawnTileByServer(targetPos,newTitled)
    self:playerMove(targetPos)
end

function KabalaTreeBigMiniMap:onRecvTriggerEvent(eventId,tiledPosMN)

    if not eventId then
        return
    end

    local eventType,eventRes,smallRes,offset,scaleInMap,targetTab,targetText,oilCost,prePlot,isDelete = KabalaTreeDataMgr:getTileEventRes(eventId)
    if not eventType or not eventRes or not smallRes then
        return
    end

    if eventType == Enum_TriggerEventType.EventType_TaskStory and isDelete then
        self:cleanItem(tiledPosMN)
    end
end

function KabalaTreeBigMiniMap:onRecvClearTileItem(tiledPosMN,eventId)
    self:cleanItem(tiledPosMN)
end

function KabalaTreeBigMiniMap:onUpdateDiscoverTask(isAdd)
    if isAdd then
        self.skeletonNode = self.bigMiniMap:getChildByName("discoverItem")
        if self.skeletonNode then
            self.skeletonNode:removeFromParent()
            self.skeletonNode = nil
        end
    end
end

function KabalaTreeBigMiniMap:registerEvents()

    EventMgr:addEventListener(self,EV_GET_MINIMAP,handler(self.onUpdateBigMiniMap, self))
    EventMgr:addEventListener(self,EV_FUNC_MOVE,handler(self.onPlayerMoveTo, self))
    EventMgr:addEventListener(self,EV_TRIGGER_EVENT,handler(self.onRecvTriggerEvent, self))
    EventMgr:addEventListener(self,EV_CLEAR_TILEDITEM,handler(self.onRecvClearTileItem, self))
    EventMgr:addEventListener(self,EV_DISCOVER_TASK,handler(self.onUpdateDiscoverTask, self))

    self.Button_add:onClick(function ()
        self:scaleMap(0.02)
    end)

    self.Button_del:onClick(function ()
        self:scaleMap(-0.02)
    end)
end

return KabalaTreeBigMiniMap