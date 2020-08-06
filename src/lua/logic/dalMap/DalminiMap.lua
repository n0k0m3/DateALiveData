local DalminiMap = class("DalminiMap")
function DalminiMap:ctor()

end

function DalminiMap:initData(Panel_map,miniPlayer,Image_mapItem)
    self.Panel_map = Panel_map
    self.MiniPlayer = miniPlayer
    self.Image_mapItem = Image_mapItem
end

function DalminiMap:createMiniMap(mapCid)

    local serverDataCfg = DalMapDataMgr:getServerDataCfg(mapCid)
    if not serverDataCfg then
        Box("Wrong mapCid："..mapCid)
        return
    end
    local tileMapRes = serverDataCfg.mapDocument
    local tileMap = TMXTiledMap:create(tileMapRes)
    if not tileMap then
        Box("wrong map path:"..tileMapRes)
        return
    end

    self.tileMap = tileMap
    self.MiniPlayer:setZOrder(2)
    self.tileMap:addChild(self.MiniPlayer)
    self:setBaseInfo()
    self.Panel_map:addChild(self.tileMap)
end

function DalminiMap:setBaseInfo()

    self.plainLayer = self.tileMap:getLayer("floor")
    self.eventLayer = self.tileMap:getLayer("event")
    self:setScale(0.16)
    self.tileMap:setAnchorPoint(me.p(0.5,0.5))
    self:initTiledData()
    self:setGridMapLimit()

    self:initGirdItem()
end

function DalminiMap:setScale(scale)

    self.scale = scale or 0.2
    self.tileMap:setScale(self.scale)
end

function DalminiMap:locationMiniMap(posMN,isInit)

    if not self.tileMap or not posMN then
        return
    end

    local targetPosition = TiledMapDataMgr:convertToPos(posMN.x,posMN.y)
    local mapPosX, mapPosY = self:getMapContaierPos(targetPosition)
    local position = self:detectEdges(ccp(mapPosX,mapPosY))
    if not isInit then
        self.tileMap:runAction(MoveTo:create(0.5,position))
    else
        self.tileMap:setPosition(position)
    end
end

function DalminiMap:setPlayerPosition(posMN)
    if not posMN then
        return
    end
    local position = TiledMapDataMgr:convertToPos(posMN.x,posMN.y)
    position =  TiledMapDataMgr:convertToPosAR(position.x,position.y)
    local zorder = TiledMapDataMgr:getTileZorder(posMN.x,posMN.y)
    self.MiniPlayer:setZOrder(zorder)
    self.MiniPlayer:setPosition(position)
end

function DalminiMap:playerMove(posMN)

    if not posMN then
        return
    end
    local position = TiledMapDataMgr:convertToPos(posMN.x,posMN.y)
    position =  TiledMapDataMgr:convertToPosAR(position.x,position.y)
    self:locationMiniMap(posMN)
    self:Moving(position)
end

function DalminiMap:Moving(position)

    local action = Sequence:create({
        MoveTo:create(0.5,position),
        CallFunc:create(function()
            self.MiniPlayer:setPosition(position)
        end)
    })
    self.MiniPlayer:runAction(action)
end

function DalminiMap:spawnNewTile(newPosMN)

    if not newPosMN then
        return
    end

    local floorGidId = 157
    self.plainLayer:setTileGID(floorGidId,newPosMN)
    self:spawnNormalTile(newPosMN,255,true)
end

function DalminiMap:initGirdItem()
    self.mapItem = {}
    local mapItems = TiledMapDataMgr:getMapItem()
    for k,v in pairs(mapItems) do
        self:spawnNewItem(v.pos,v.smallRes,v.offset,v.scaleInMap)
    end
end

--开地图新产生item
function DalminiMap:spawnNewItem(tilePosMN,itemRes,offset,scaleInMap)

    if not tilePosMN or not itemRes or not offset or not scaleInMap then
        return
    end
    self:createItem(tilePosMN,itemRes,offset,scaleInMap)
end

function DalminiMap:createItem(tilePosMN,itemRes,offset,scaleInMap)

    if not self.mapItem then
        self.mapItem = {}
    end
    for k,v in pairs(self.mapItem) do
        if v.pos.x == tilePosMN.x and tilePosMN.y == v.pos.y then
            return
        end
    end

    local position = TiledMapDataMgr:convertToPos(tilePosMN.x,tilePosMN.y)
    position =  TiledMapDataMgr:convertToPosAR(position.x,position.y)

    local Image_mapItem = self.Image_mapItem:clone()
    local offsetX = 0
    local offsetY = -130
    Image_mapItem:setPosition(ccp(position.x+offsetX,position.y+offsetY))
    local zorder = TiledMapDataMgr:getTileZorder(tilePosMN.x,tilePosMN.y)
    Image_mapItem:setZOrder(zorder)
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
    self.tileMap:addChild(Image_mapItem)

    table.insert(self.mapItem,{pos = tilePosMN,item = Image_mapItem})
end

function DalminiMap:cleanItem(tilePosMN)

    local item,index
    for k,v in pairs(self.mapItem) do
        if v.pos.x == tilePosMN.x and tilePosMN.y == v.pos.y then
            item = v.item
            index = k
        end
    end
    if not item or not self.tileMap then
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

--设置地图拖动边界
function DalminiMap:setGridMapLimit()

    if not self.tileMap then
        return
    end

    local winSize = me.size(300,170)
    local tileXCount,tileYCount = TiledMapDataMgr:getTileXYCount()
    local tileWidth,tileHeight  = TiledMapDataMgr:getTileSize()

    self.limitLW = winSize.width/2 - tileWidth * tileXCount * self.scale /2
    if self.limitLW > 0 then
        self.limitLW = -self.limitLW
    end
    self.limitRW = -self.limitLW
    self.limitDH = winSize.height/2 - tileHeight * tileYCount * self.scale /2
    if self.limitDH > 0 then
        self.limitDH = -self.limitDH
    end
    self.limitUH = -self.limitDH

end

function DalminiMap:getMapContaierPos(playerPos)

    local tileXCount,tileYCount = TiledMapDataMgr:getTileXYCount()
    local tileWidth,tileHeight  = TiledMapDataMgr:getTileSize()

    local mapPosX = (tileXCount*tileWidth/2 - playerPos.x)*self.scale
    local mapPosY = (tileYCount*tileHeight/2 - playerPos.y)*self.scale
    return mapPosX, mapPosY
end

function DalminiMap:initTiledData()

    local tileXCount,tileYCount = TiledMapDataMgr:getTileXYCount()
    for i=0,tileXCount-1 do
        for j=0,tileYCount-1 do

            local isOpen = DalMapDataMgr:isOpen(ccp(i,j))
            local opacity = isOpen and 255 or 0
            self:spawnNormalTile(ccp(i,j),opacity)
        end
    end
end

--生成普通层格子
function DalminiMap:spawnNormalTile(tilePosMN,opacity,isAdd)

    local tileGid = self.plainLayer:getTileGIDAt(tilePosMN)
    if tileGid == 0 then
        return
    end

    local tiledGid = 157
    if not self.eventLayer then
        return
    end

    local eventGid = self.eventLayer:getTileGIDAt(tilePosMN)
    if eventGid == 2 then
        tiledGid = 156
    end

    if opacity == 255 then
        self.plainLayer:setTileGID(tiledGid,tilePosMN)
        if isAdd then
            local tilemg = self.plainLayer:getTileAt(tilePosMN)
            if tilemg then
                tilemg:setOpacity(0)
                tilemg:runAction(CCFadeIn:create(1))
            end
        end
    else
        self.plainLayer:setTileGID(0,tilePosMN)
    end

end

function DalminiMap:detectEdges(point)

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

return DalminiMap