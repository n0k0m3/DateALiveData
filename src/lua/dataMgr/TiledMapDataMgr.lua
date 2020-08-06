---
---
--- 通用tiledmap地图接口
--- 地板层统一名字：floor
---
local BaseDataMgr = import(".BaseDataMgr")
local TiledMapDataMgr = class("TiledMapDataMgr", BaseDataMgr)

function TiledMapDataMgr:init()

end

---设置tiledMap(tiledMap,地图带下，格子大小)
function TiledMapDataMgr:setTileMap(tiledMap,obstacleGidId)

    self.tiledMap = tiledMap
    self.mapSize = self.tiledMap:getMapSize()
    self.tileSize = self.tiledMap:getTileSize()
    self.winSize = me.Director:getVisibleSize()

    self.mapItem = {}                       --格子上的道具集合(主要用于寻路)
    self.obstacleGidId = obstacleGidId      --不同的地图在tileMap中事件层的阻挡Gid可能不同
end

function TiledMapDataMgr:getTileMap()
    return self.tiledMap
end

---得到tiledMap地图大小(10*10)
function TiledMapDataMgr:getTileXYCount()

    return self.mapSize.width,self.mapSize.height
end

---得到tiledMap单个格子大小
function TiledMapDataMgr:getTileSize()

    local width = self.tileSize.width
    local height = self.tileSize.height
    return width,height
end

---像素坐标装换为格子坐标
---(x,y)->(M,N) convertToNormalPos的逆过程
function TiledMapDataMgr:convertToMN(x,y)

    local tileXCount,tileYCount = self:getTileXYCount()
    local tileWidth,tileHeight  = self:getTileSize()

    local originalPosX = tileWidth * tileXCount/2
    local originalPosY = tileHeight * tileYCount

    local M = (x - originalPosX)/tileWidth + (y - 90 - originalPosY)/(-tileHeight)
    local N = (y - 90 - originalPosY)/(-tileHeight) - (x - originalPosX)/tileWidth

    M = math.floor(M)
    N = math.floor(N)

    return M,N
end

---格子坐标装换为像素坐标
----(M,N)->(x,y)
function TiledMapDataMgr:convertToPos(M,N)

    --tilePos(M,N) 原点坐标:tiled(M,N) = tiled(0,0) 的顶点坐标
    --x = 原点坐标X + M在像素坐标系X轴的偏移像素 * M + N在像素坐标系X轴的偏移像素 * N
    --  = originalPosX + tileWidth /2 * M + （-tileWidth/2） * N
    --x = originalPosX + (M – N) * tileWidth/2

    --y = 原点坐标Y + M在像素坐标系Y轴的偏移像素 * M + N在像素坐标系Y轴的偏移像素 * N
    --  = originalPosY + (-tileHeight / 2) * M + (-tileHeight / 2) * N
    --y = originalPosY + (M + N) * (-tileHeight / 2) + 90(块的三维高度)

    --so
    --M - N = (x - originalPosX)*2/tileWidth
    --M + N = (y - originalPosY)*2/(-tileHeight)

    local tileXCount,tileYCount = self:getTileXYCount()
    local tileWidth,tileHeight  = self:getTileSize()

    local originalPosX = tileWidth*tileXCount/2
    local originalPosY = tileHeight*tileYCount

    local x = originalPosX + (M - N) * tileWidth/2
    local y = originalPosY + (M + N) * (-tileHeight / 2) + 90
    return ccp(x,y)
end

----转化为地图坐标
function TiledMapDataMgr:convertToPosAR(x,y)

    local tileXCount,tileYCount = self:getTileXYCount()
    local tileWidth,tileHeight  = self:getTileSize()

    x = x - tileXCount*tileWidth/2
    y = y - tileYCount*tileHeight/2 - tileHeight/2
    return ccp(x,y)
end

----得到地图zorder
function TiledMapDataMgr:getTileZorder(x,y)

    local tileXCount,tileYCount = self:getTileXYCount()
    local zorder = x + tileYCount*y
    return zorder
end

----检测格子坐标是否在屏幕内
----return bool,像素坐标
function TiledMapDataMgr:checkInScreen(tiledPosMN)

    if not tiledPosMN or not self.tiledMap then
        return
    end

    local position = self:convertToPos(tiledPosMN.x,tiledPosMN.y)
    position = self.tiledMap:convertToWorldSpace(position)

    if position.x < 0 or position.x > GameConfig.WS.width then
        return false,position
    end

    if position.y < 0 or position.y > GameConfig.WS.height then
        return false,position
    end

    return true,position
end

----设置地图缩放大小
function TiledMapDataMgr:setMapScale(scale)

    if not self.tiledMap then
        return
    end

    self.scale = scale or 1
    self.tiledMap:setScale(self.scale)
end

----得到地图缩放大小
function TiledMapDataMgr:getMapScale()
    self.scale = self.scale or 1
    return self.scale
end

----设置地图拖动边界
function TiledMapDataMgr:setGridMapLimit()

    local scale = self:getMapScale()
    local tileXCount,tileYCount = self:getTileXYCount()
    local tileWidth,tileHeight  = self:getTileSize()

    self.limitLW = self.winSize.width/2 - tileWidth * tileXCount * scale /2
    if self.limitLW > 0 then
        self.limitLW = -self.limitLW
    end
    self.limitRW = -self.limitLW
    self.limitDH = self.winSize.height/2 - tileHeight * tileYCount * scale /2
    if self.limitDH > 0 then
        self.limitDH = -self.limitDH
    end
    self.limitUH = -self.limitDH
end

----检查边界
function TiledMapDataMgr:detectEdges(point)

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

function TiledMapDataMgr:getMapContaierPos(targetPosMN)

    local tileXCount,tileYCount = self:getTileXYCount()
    local tileWidth,tileHeight  = self:getTileSize()

    local mapPosX = (tileXCount*tileWidth/2 - targetPosMN.x)*self.scale
    local mapPosY = (tileYCount*tileHeight/2 - targetPosMN.y)*self.scale
    return mapPosX, mapPosY
end

----检查是不是在地图范围内
function TiledMapDataMgr:checkInMapRange(tiledPosMN)

    local tileXCount,tileYCount = self:getTileXYCount()
    local minX,maxX = 0,tileXCount -1
    local minY,maxY = 0,tileYCount -1
    if tiledPosMN.x < 0 or tiledPosMN.x > maxX or tiledPosMN.y < minY or tiledPosMN.y > maxY then
        return false
    end

    return true
end

----检查在地图范围内的格子是否存在格子
function TiledMapDataMgr:isExistTiled(tiledPosMN)

    if not self.tiledMap then
        return false
    end

    local inMapRange = self:checkInMapRange(tiledPosMN)
    if not inMapRange then
        return false
    end

    local layer = self.tiledMap:getLayer("floor")
    if layer then
        local gid = layer:getTileGIDAt(tiledPosMN)
        if gid == 0 then
            return false
        end
    end
    return true
end

----得到地块的透明度
function TiledMapDataMgr:getTileOpacity(tiledPosMN)

    if not self.tiledMap then
        return 0
    end

    local inMapRange = self:checkInMapRange(tiledPosMN)
    if not inMapRange then
        return 0
    end

    local layer = self.tiledMap:getLayer("floor")
    if layer then
        local layerImg = layer:getTileAt(tiledPosMN)
        if not layerImg then
            return 0
        end

        local opacity = layerImg:getOpacity()
        return opacity
    end
    return 0
end

--是否存在障碍物
function TiledMapDataMgr:isObstacle(tiledPosMN)

    if not self.tiledMap then
        return
    end

    local inMapRange = self:checkInMapRange(tiledPosMN)
    if not inMapRange then
        return true
    end

    local eventLayer = self.tiledMap:getLayer("event")
    if not eventLayer  then
        return false
    end

    local eventGidId = eventLayer:getTileGIDAt(tiledPosMN)
    if eventGidId == self.obstacleGidId then
        return true
    end

    return false
end

----得到周围地块的集合
----tiledPosMN:目标格子坐标 range：范围
function TiledMapDataMgr:getAroundTileds(tiledPosMN,range)

    if not self.tiledMap then
        return
    end

    local layer = self.tiledMap:getLayer("floor")
    if not layer then
        return
    end

    range = range or 1

    local x,y = tiledPosMN.x,tiledPosMN.y
    local around = {}
    for i = -range,range do
        for j = -range,range do
            if i ~= 0 or j ~= 0 then
                table.insert(around,ccp(x+i,y+j))
            end
        end
    end
    return around
end

----计算两个格子坐标的距离
function TiledMapDataMgr:calcValueDis(tilePosMN1,tilePosMN2)

    local distanceX = math.abs(tilePosMN1.x - tilePosMN2.x)
    local distanceY = math.abs(tilePosMN1.y - tilePosMN2.y)

    return distanceX + distanceY
end

----添加地图中的生成道具
function TiledMapDataMgr:addMapItem(tilePosStr,info)
    if not self.mapItem then
        self.mapItem = {}
    end
    self.mapItem[tilePosStr] = info
end

----得到地图中的生成道具
function TiledMapDataMgr:getMapItem(tilePosStr)

    if not tilePosStr then
        return self.mapItem
    end
    return self.mapItem[tilePosStr]

end

----删除地图中生成的道具
function TiledMapDataMgr:deleteMapItem(tilePosStr)
    self.mapItem[tilePosStr] = nil
end

return TiledMapDataMgr:new();
