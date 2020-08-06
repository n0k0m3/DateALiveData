local KabalaTreeMiniMap = class("KabalaTreeMiniMap")
function KabalaTreeMiniMap:ctor()

end

function KabalaTreeMiniMap:initData(Panel_map,miniPlayer,Image_mapItem)
	self.Panel_map = Panel_map
	self.MiniPlayer = miniPlayer
    self.Image_mapItem = Image_mapItem
end

function KabalaTreeMiniMap:createMiniMap(mapId)

	self.tileMap = self:generateMap(mapId)
	if not self.tileMap then
		return
	end
    self.MiniPlayer:setZOrder(2)
	self.tileMap:addChild(self.MiniPlayer)
	self:setBaseInfo()
	self.Panel_map:addChild(self.tileMap)
end

function KabalaTreeMiniMap:generateMap(mapId)

	local tileMapRes = KabalaTreeDataMgr:getTileMapRes(mapId)
    if not tileMapRes then
        return
    end
    
    local tileMap = TMXTiledMap:create(tileMapRes)    
    if not tileMap then
        return
    end

    return tileMap
end

function KabalaTreeMiniMap:setBaseInfo()

	self.plainLayer = self.tileMap:getLayer("Plain")
    self.obstacleLayer = self.tileMap:getLayer("Landform")
    self.eventLayer = self.tileMap:getLayer("Event")
    self:setScale(0.16)
    self.tileMap:setAnchorPoint(me.p(0.5,0.5))
    self:initTiledData()
    self:setGridMapLimit()

    self:initGirdItem()
end

function KabalaTreeMiniMap:setScale(scale)

	self.scale = scale or 0.2
	self.tileMap:setScale(self.scale)
end

function KabalaTreeMiniMap:locationMiniMap(posMN,isInit)

	if not self.tileMap or not posMN then
        return
    end

    local targetPosition = KabalaTreeDataMgr:convertToPos(posMN.x,posMN.y)
    local mapPosX, mapPosY = self:getMapContaierPos(targetPosition)
    local position = self:detectEdges(ccp(mapPosX,mapPosY)) 
    if not isInit then
    	self.tileMap:runAction(MoveTo:create(0.5,position))
    else
    	self.tileMap:setPosition(position)
    end
end

function KabalaTreeMiniMap:setPlayerPosition(posMN)
	if not posMN then
		return
	end
	local position = KabalaTreeDataMgr:convertToPos(posMN.x,posMN.y)
    position =  KabalaTreeDataMgr:convertToPosAR(position.x,position.y)
    self.MiniPlayer:setPosition(position)
end

function KabalaTreeMiniMap:playerMove(posMN)

	if not posMN then
		return
	end
	local position = KabalaTreeDataMgr:convertToPos(posMN.x,posMN.y)
    position =  KabalaTreeDataMgr:convertToPosAR(position.x,position.y)
    self:locationMiniMap(posMN)
    self:Moving(position)
end

function KabalaTreeMiniMap:Moving(position)

	local action = Sequence:create({
        MoveTo:create(0.5,position),
        CallFunc:create(function()
        	self.MiniPlayer:setPosition(position)
        end)
    })
	self.MiniPlayer:runAction(action)
end

function KabalaTreeMiniMap:spawnNewTile(newPosMN)

	if not newPosMN then
		return
	end
    local originalGid = KabalaTreeDataMgr:getOriginalGid(newPosMN)
    if originalGid then
        self.plainLayer:setTileGID(originalGid,newPosMN)
    end
	self:spawnNormalTile(newPosMN,255,true)
end

function KabalaTreeMiniMap:initGirdItem()
    self.mapItem = {}
    self.KabalaTreeItemMap = KabalaTreeDataMgr:getKabalaTreeItemMap()
    for k,v in pairs(self.KabalaTreeItemMap) do   
        self:createItem(v.pos,v.smallRes,v.offset,v.scaleInMap) 
    end
end

--开地图新产生item
function KabalaTreeMiniMap:spawnNewItem(tilePosMN,itemRes,offset,scaleInMap)

    if not tilePosMN or not itemRes or not offset or not scaleInMap then
        return
    end
    self:createItem(tilePosMN,itemRes,offset,scaleInMap)
end

function KabalaTreeMiniMap:createItem(tilePosMN,itemRes,offset,scaleInMap)

    if not self.mapItem then
        self.mapItem = {}
    end
    for k,v in pairs(self.mapItem) do
        if v.pos.x == tilePosMN.x and tilePosMN.y == v.pos.y then
            return
        end
    end

    local position = KabalaTreeDataMgr:convertToPos(tilePosMN.x,tilePosMN.y)
    position =  KabalaTreeDataMgr:convertToPosAR(position.x,position.y)

    local Image_mapItem = self.Image_mapItem:clone()
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
    self.tileMap:addChild(Image_mapItem)

    table.insert(self.mapItem,{pos = tilePosMN,item = Image_mapItem})
end

function KabalaTreeMiniMap:cleanItem(tilePosMN)

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
function KabalaTreeMiniMap:setGridMapLimit()

	if not self.tileMap then
		return
	end

    local winSize = me.size(300,170)
    local point = self.tileMap:getAnchorPoint()
    local tileXCount,tileYCount = KabalaTreeDataMgr:getTileXYCount()
    local tileWidth,tileHeight  = KabalaTreeDataMgr:getTileSize()

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

function KabalaTreeMiniMap:getMapContaierPos(playerPos)

    local tileXCount,tileYCount = KabalaTreeDataMgr:getTileXYCount()
    local tileWidth,tileHeight  = KabalaTreeDataMgr:getTileSize()

    local mappos = self.tileMap:getPosition() 
    local mapPosX = (tileXCount*tileWidth/2 - playerPos.x)*self.scale
    local mapPosY = (tileYCount*tileHeight/2 - playerPos.y)*self.scale
    return mapPosX, mapPosY
end

function KabalaTreeMiniMap:initTiledData()

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
function KabalaTreeMiniMap:spawnNormalTile(tilePosMN,opacity,isAdd)

    local tileGid = self.plainLayer:getTileGIDAt(tilePosMN)
    if tileGid == 0 then
        return
    end

    local tiledGid = KabalaTreeDataMgr:getGroundLayerGid(EC_EventLayerGid.Tile_SmallNormal)
    if not self.eventLayer then
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

function KabalaTreeMiniMap:detectEdges(point)
	
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

return KabalaTreeMiniMap