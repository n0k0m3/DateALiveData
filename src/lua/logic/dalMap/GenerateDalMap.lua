local GenerateDalMap = class("GenerateDalMap")
function GenerateDalMap:ctor()

end

function GenerateDalMap:generateMap(mapCid)

    local serverDataCfg = DalMapDataMgr:getServerDataCfg(mapCid)
    if not serverDataCfg then
        Box("Wrong mapCid："..mapCid)
        return
    end
    local tileMapRes = serverDataCfg.mapDocument
    self.mapType = serverDataCfg.mapType
    local tileMap = TMXTiledMap:create(tileMapRes)
    if not tileMap then
        Box("wrong map path:"..tileMapRes)
        return
    end
    print(tileMapRes)
    TiledMapDataMgr:setTileMap(tileMap,2)
    self.tileMap = tileMap
    self.tileMap:setAnchorPoint(me.p(0.5,0.5))

    self:initTiled()

end

--隐藏出生点之外的格子(打开的服务器会告知)
function GenerateDalMap:initTiled()

    self.dressLayer = self.tileMap:getLayer("dress")
    self.floorLayer = self.tileMap:getLayer("floor")
    self.eventLayer = self.tileMap:getLayer("event")
    local cfgEventGid = DalMapDataMgr:getCfgEventGid()
    local tileXCount,tileYCount = TiledMapDataMgr:getTileXYCount()
    for i=0,tileXCount-1 do
        for j=0,tileYCount-1 do
            local isOpen = DalMapDataMgr:isOpen(ccp(i,j))
            local opacity = isOpen and 255 or 0
            self:spawnNormalTile(ccp(i,j),opacity)

            --整理事件层的格子ID
            if cfgEventGid then
                local gid = self.eventLayer:getTileGIDAt(ccp(i,j))
                for k,v in ipairs(cfgEventGid) do
                    local gidType = v.gidType
                    if gid <= v.gid then
                        local tileInfo = {pos = ccp(i,j), gid = gid}
                        DalMapDataMgr:insertEventTiled(gidType,tileInfo)
                        break
                    end
                end
            end
        end
    end

end


---刷新格子资源
function GenerateDalMap:updateTiled(tilePosMN,isOpen)
    local opacity = isOpen and 255 or 0
end

function GenerateDalMap:spawnNormalTile(tilePosMN,opacity)

    local tileGid = self.floorLayer:getTileGIDAt(tilePosMN)
    if tileGid == 0 then
        return
    end

    local tilePosStr = tilePosMN.x.."-"..tilePosMN.y
    DalMapDataMgr:setFloorGidId(tilePosStr,tileGid)

    local mapTileInfo = DalMapDataMgr:getMapTileInfo(tilePosStr)
    if not mapTileInfo then
        Box("wrong pos "..tilePosStr.." in server")
        return
    end

    ---记录装饰层的事件
    local dressSelfGid = self.dressLayer:getTileGIDAt(tilePosMN)
    if dressSelfGid and dressSelfGid ~= 0 then
        DalMapDataMgr:setDressGidId(tilePosStr,{pos = tilePosMN,gid = dressSelfGid})
    end

    if opacity == 0 then
        self.floorLayer:setTileGID(0,tilePosMN)
        return
    end
    self.floorLayer:setTileGID(tileGid,tilePosMN)
    self:spawnDressTile(tilePosMN,tileGid)

    if opacity ~= 0 then
        self:insertMapItem(tilePosMN,mapTileInfo.event,mapTileInfo.eventValid)
    end
end

function GenerateDalMap:insertMapItem(tilePosMN,eventId,eventValid)

    --地图可见部分生成道具
    if eventId <= 0 then
        return
    end

    local eventRes,smallRes,offset,scaleInMap,isDelete,spineRes,npcName = DalMapDataMgr:getTileEventRes(eventId)
    if not eventRes or not offset or not scaleInMap or not smallRes or not spineRes or not npcName then
        return
    end

    --地图保留无效但不需要删除的事件
    if (not eventValid) and isDelete then
        return
    end

    if eventRes == "" then
        return
    end
    local tilePosStr = tilePosMN.x.."-"..tilePosMN.y

    TiledMapDataMgr:addMapItem(tilePosStr,{pos = tilePosMN,res = eventRes,smallRes = smallRes,spineRes = spineRes,npcName = npcName,offset = offset,scaleInMap = scaleInMap})
end

---判断周围是否装饰格子
function GenerateDalMap:spawnDressTile(tilePosMN,tileGid)

    local dressInfo = DalMapDataMgr:getDressGidId(tilePosMN.x.."-"..tilePosMN.y)
    if dressInfo then
        local dressResInfo = DalMapDataMgr:getDressCfgRes(self.mapType,dressInfo.gid)
        local resourceTileds = {}
        if dressResInfo.tileType == 2 then
            for i = -1,1 do
                local newPosY = tilePosMN.y + i
                if newPosY ~= tilePosMN.y then
                    local tileInfo = DalMapDataMgr:getDressGidId(tilePosMN.x.."-"..newPosY)
                    if tileInfo and dressInfo.gid == tileInfo.gid then
                        table.insert(resourceTileds,ccp(tilePosMN.x,newPosY))
                    end
                end
            end
        elseif dressResInfo.tileType == 3 then
            for i = -1,1 do
                local newPosX = tilePosMN.x + i
                if newPosX ~= tilePosMN.x then
                    local tileInfo = DalMapDataMgr:getDressGidId(newPosX.."-"..tilePosMN.y)
                    if tileInfo and dressInfo.gid == tileInfo.gid then
                        table.insert(resourceTileds,ccp(newPosX,tilePosMN.y))
                    end
                end
            end
        elseif dressResInfo.tileType == 4 then
            local range = DalMapDataMgr:getTileAppearing()
            local roundTileds = TiledMapDataMgr:getAroundTileds(tilePosMN,range)
            for k,v in ipairs(roundTileds) do
                local tileInfo = DalMapDataMgr:getDressGidId(v.x.."-"..v.y)
                if tileInfo and dressInfo.gid == tileInfo.gid then
                    table.insert(resourceTileds,v)
                end
            end
        end

        for k,v in ipairs(resourceTileds) do
            self.floorLayer:setTileGID(tileGid,v)
            DalMapDataMgr:setDressTiledOpen(v.x.."-"..v.y)
        end
    end
end

return GenerateDalMap