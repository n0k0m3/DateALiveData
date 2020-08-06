local KabalaTreeGridMap = class("KabalaTreeGridMap")
function KabalaTreeGridMap:ctor()
	
end

function KabalaTreeGridMap:generateMap(mapId,playerPos,scale)

    self.playerPos = playerPos
	local tileMapRes = KabalaTreeDataMgr:getTileMapRes(mapId)
    if not tileMapRes then
        return
    end
    print("tileMapRes",tileMapRes)
    self.tileMap = TMXTiledMap:create(tileMapRes)    
    if not self.tileMap then
        return
    end

    self.plainLayer = self.tileMap:getLayer("Plain")
    self.obstacleLayer = self.tileMap:getLayer("Landform")
    self.eventLayer = self.tileMap:getLayer("Event")

    scale = scale or 1
    self.tileMap:setAnchorPoint(me.p(0.5,0.5))
    KabalaTreeDataMgr:initTileMapData(self.tileMap)
    KabalaTreeDataMgr:setMapScale(scale)
    KabalaTreeDataMgr:setGridMapLimit()

    --记录下沉的格子,防止多次下沉
    self.recorldTiled = {}

    self:initTiled()
    return self.tileMap
end

--隐藏出生点之外的格子(打开的服务器会告知)
function KabalaTreeGridMap:initTiled()

    local isStronghold = KabalaTreeDataMgr:checkIsStrongHold()
    if not isStronghold then
        KabalaTreeDataMgr:clearNewOpenTitled()
        KabalaTreeDataMgr:clearStronghold()
    end

    local tileXCount,tileYCount = KabalaTreeDataMgr:getTileXYCount()
    for i=0,tileXCount-1 do
        for j=0,tileYCount-1 do

            local isOpen = KabalaTreeDataMgr:isOpen(ccp(i,j))
            --判断是否是新获取的格子(原则上只有战斗占领据点会有新开启的格子)
            local newTitled = KabalaTreeDataMgr:isNewOpenTitled(ccp(i,j))
            if newTitled then
                isOpen = false
            end
            local opacity = isOpen and 255 or 0
            self:spawnNormalTile(ccp(i,j),opacity)
            self:spawnObstacleTile(ccp(i,j),opacity)

            --如果是占领后的据点的特殊处理
            local strnghold = KabalaTreeDataMgr:getStronghold()
            if strnghold and strnghold.x == i and strnghold.y == j then
                local tiledGid = KabalaTreeDataMgr:getGroundLayerGid(EC_EventLayerGid.Tile_Red)
                self.plainLayer:setTileGID(tiledGid,ccp(i,j))
            end

            --隐藏事件层(不能在地图编辑器中设置为不可见，否则会读取不到该层的信息)
            local tileSprite = self.eventLayer:getTileAt(ccp(i,j))
            if tileSprite then
                tileSprite:setVisible(false)
            end
        end
    end
end

function KabalaTreeGridMap:updateTiled(tilePosMN,isOpen)
    local opacity = isOpen and 255 or 0
    self:spawnNormalTile(tilePosMN,opacity)
    self:spawnObstacleTile(tilePosMN,opacity)
end

--生成普通层格子
function KabalaTreeGridMap:spawnNormalTile(tilePosMN,opacity)

    local tileSprite = self.plainLayer:getTileAt(tilePosMN)
    if not tileSprite then
        return
    end

    local tiledGid = KabalaTreeDataMgr:getGroundLayerGid(EC_EventLayerGid.Tile_Normal)
    local eventId,eventValid = KabalaTreeDataMgr:getEventId(tilePosMN)
    local isDelete = false
    if eventId then
        tiledGid,isDelete = KabalaTreeDataMgr:getTileGIdByEventId(eventId,eventValid)
    end

    --是否已探索过
    local isExplored =  KabalaTreeDataMgr:isExploredPoint(tilePosMN)
    if isExplored then
         tiledGid = KabalaTreeDataMgr:getGroundLayerGid(EC_EventLayerGid.Tile_AllYellow)
    end

    --阻挡就用原生GID
    local eventGid = self.eventLayer:getTileGIDAt(tilePosMN)
    if eventGid == 2 then 
        tiledGid = self.plainLayer:getTileGIDAt(tilePosMN)
    end

    self.plainLayer:setTileGID(tiledGid,tilePosMN)
    --opacity = 255--(格子全部打开)

    tileSprite:setOpacity(opacity)
    if opacity == 0 then
        local posStr = tilePosMN.x.."-"..tilePosMN.y
        if not self.recorldTiled[posStr] then
            local posY = tileSprite:getPositionY()
            tileSprite:setPositionY(posY-80)
            self.recorldTiled[posStr] = 1
        end
    else
        if not eventId then
            Box("map data not match")
        end

        --地图可见部分生成道具   
        if eventId <= 0 then
            return
        end

        if (not eventValid) and isDelete then
            return
        end
            
        local eventType,eventRes,smallRes,offset,scaleInMap = KabalaTreeDataMgr:getTileEventRes(eventId,eventValid)
        if not eventType or not eventRes or not offset or not scaleInMap or not smallRes then
            return
        end

        if eventRes == "" then
            return
        end

        KabalaTreeDataMgr:addKabalaTreeItem({pos = tilePosMN,res = eventRes,smallRes = smallRes,offset = offset,scaleInMap = scaleInMap})
    end
end

--生成障碍物
function KabalaTreeGridMap:spawnObstacleTile(tilePosMN,opacity)

    if not self.obstacleLayer then
        return
    end

    local obstacleImg = self.obstacleLayer:getTileAt(tilePosMN)
    if obstacleImg then
        --opacity = 255--(格子全部打开)
        if opacity == 0 then
            obstacleImg:setOpacity(0)
        else
            local position = obstacleImg:getPosition()
            local offsetX,offsetY = KabalaTreeDataMgr:getObstacleOffset()
            obstacleImg:setPosition(position.x+offsetX,position.y+offsetY)
        end
    end

end

return KabalaTreeGridMap