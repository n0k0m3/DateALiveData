local GenerateItem = class("GenerateItem")
function GenerateItem:ctor()

end

--进入地图初始化元素
function GenerateItem:initItem(Image_mapItem,Panel_npcItem)

    local tileMap = TiledMapDataMgr:getTileMap()
    if not tileMap then
        return
    end
    self.tileMap = tileMap

    self.Image_mapItem = Image_mapItem
    self.Panel_npcItem = Panel_npcItem
    self.mapItem = {}
    local dressGidMap = DalMapDataMgr:getDressGidId()
    if dressGidMap then
        for k,v in pairs(dressGidMap) do
            self:spawnDressItem(v.pos,v.gid)
        end
    end

    local mapItems = TiledMapDataMgr:getMapItem()
    for k,v in pairs(mapItems) do
        self:spawnItem(v.pos,v.res,v.smallRes,v.offset,v.scaleInMap,v.spineRes,v.npcName)
    end


end

function GenerateItem:spawnDressItem(tilePosMN,dressSelfGid)

    if dressSelfGid and dressSelfGid ~= 0 then

        local mapCid = DalMapDataMgr:getMapCid()
        local serverDataCfg = DalMapDataMgr:getServerDataCfg(mapCid)
        if not serverDataCfg then
            return
        end
        local mapType = serverDataCfg.mapType
        local dressResInfo = DalMapDataMgr:getDressCfgRes(mapType,dressSelfGid)
        local tilePosStr = tilePosMN.x.."-"..tilePosMN.y

        local painted = DalMapDataMgr:getPaintedDressItem(tilePosStr)
        if painted then
            return
        end

        local resourceTileds = {}

        if dressResInfo.tileType == 1 then
            table.insert(resourceTileds,tilePosMN)
        elseif dressResInfo.tileType == 2 then
            for i = -1,1 do
                local newPosY = tilePosMN.y + i
                local tileInfo = DalMapDataMgr:getDressGidId(tilePosMN.x.."-"..newPosY)
                if tileInfo and dressSelfGid == tileInfo.gid then
                    table.insert(resourceTileds,ccp(tilePosMN.x,newPosY))
                end
            end
        elseif dressResInfo.tileType == 3 then
            for i = -1,1 do
                local newPosX = tilePosMN.x + i
                local tileInfo = DalMapDataMgr:getDressGidId(newPosX.."-"..tilePosMN.y)
                if tileInfo and dressSelfGid == tileInfo.gid then
                    table.insert(resourceTileds,ccp(newPosX,tilePosMN.y))
                end
            end
        elseif dressResInfo.tileType == 4 then
            table.insert(resourceTileds,tilePosMN)
            local range = DalMapDataMgr:getTileAppearing()
            local roundTileds = TiledMapDataMgr:getAroundTileds(tilePosMN,range)
            for k,v in ipairs(roundTileds) do
                local tileInfo = DalMapDataMgr:getDressGidId(v.x.."-"..v.y)
                if tileInfo and dressSelfGid == tileInfo.gid then
                    table.insert(resourceTileds,v)
                end
            end
        end

        if #resourceTileds == 1  then

            local open = DalMapDataMgr:isOpen(tilePosMN)
            if not open then
                return
            end
            local position = TiledMapDataMgr:convertToPos(tilePosMN.x,tilePosMN.y)
            position =  TiledMapDataMgr:convertToPosAR(position.x,position.y)
            local zorder = TiledMapDataMgr:getTileZorder(tilePosMN.x,tilePosMN.y)

            local Image_mapItem = self:createItem(position,dressResInfo.dressIcon,dressResInfo.offset,zorder,1,false)
            if Image_mapItem then
                --DalMapDataMgr:addMapItemObj(tilePosStr,Image_mapItem)
                DalMapDataMgr:setPaintedDressItem(tilePosStr)
            end
            --self:createNpc(position,zorder)
        else

            local couldPaint = true
            for k,v in ipairs(resourceTileds) do
                local painted = DalMapDataMgr:getPaintedDressItem(v.x.."-"..v.y)
                if painted  then
                    couldPaint = false
                    break
                end
            end

            if not couldPaint then
                return
            end

            local isOpen = true
            local positionTab = {}
            for k,v in ipairs(resourceTileds) do
                local open = DalMapDataMgr:isOpen(v)
                isOpen = isOpen and open
                local zorder = TiledMapDataMgr:getTileZorder(v.x,v.y)
                local position = TiledMapDataMgr:convertToPos(v.x,v.y)
                position =  TiledMapDataMgr:convertToPosAR(position.x,position.y)
                table.insert(positionTab,{position = position,zorder = zorder})
            end

            table.sort(positionTab,function(a,b)
                return a.zorder < b.zorder
            end)

            if not isOpen then
                return
            end

            local zorder = positionTab[1].zorder
            local centerPosX,centerPosY
            if #positionTab == 2 then
                centerPosX = (positionTab[1].position.x + positionTab[2].position.x)/2
                centerPosY = (positionTab[1].position.y + positionTab[2].position.y)/2
            elseif #positionTab == 4 then
                centerPosX = (positionTab[1].position.x + positionTab[4].position.x)/2
                centerPosY = (positionTab[1].position.y + positionTab[4].position.y)/2
            end

            if not centerPosX or not centerPosY then
                return
            end

            local Image_mapItem = self:createItem(ccp(centerPosX,centerPosY),dressResInfo.dressIcon,dressResInfo.offset,zorder,1,false)
            if Image_mapItem then
                --DalMapDataMgr:addMapItemObj(tilePosStr,Image_mapItem)
                DalMapDataMgr:setPaintedDressItem(tilePosStr)
            end
        end
    end
end

function GenerateItem:spawnNewDressItem(tilePosMN)
    local dressInfo = DalMapDataMgr:getDressGidId(tilePosMN.x.."-"..tilePosMN.y)
    if dressInfo then
        self:spawnDressItem(tilePosMN,dressInfo.gid)
    end
end

--开地图新产生item
function GenerateItem:spawnNewItem(tilePosMN,itemRes,smallRes,offset,scaleInMap,spineRes,npcName)

    if not tilePosMN or not itemRes or not offset or not scaleInMap or not npcName then
        return
    end
    local tilePosStr = tilePosMN.x.."-"..tilePosMN.y
    local exist = TiledMapDataMgr:getMapItem(tilePosStr)
    if not exist then
        self:spawnItem(tilePosMN,itemRes,smallRes,offset,scaleInMap,spineRes,npcName)
    end
end

function GenerateItem:spawnItem(tilePosMN,itemRes,smallRes,offset,scaleInMap,spineRes,npcName)

    if not tilePosMN or not itemRes or not offset or not scaleInMap or not spineRes or not npcName then
        return
    end
    local tilePosStr = tilePosMN.x.."-"..tilePosMN.y
    local position = TiledMapDataMgr:convertToPos(tilePosMN.x,tilePosMN.y)
    position =  TiledMapDataMgr:convertToPosAR(position.x,position.y)
    local zorder = TiledMapDataMgr:getTileZorder(tilePosMN.x,tilePosMN.y)

    local mapItem
    if spineRes and spineRes ~= "" then
        mapItem = self:createNpc(spineRes,npcName,position,zorder)
    else
        mapItem = self:createItem(position,itemRes,offset,zorder,scaleInMap,true)
    end
    if mapItem then
        TiledMapDataMgr:addMapItem(tilePosStr,{pos = tilePosMN,res = itemRes,smallRes = smallRes,spineRes = spineRes,offset = offset,scaleInMap = scaleInMap})
        DalMapDataMgr:addMapItemObj(tilePosStr,mapItem)
    end
end

function GenerateItem:createItem(position,itemRes,offset,zorder,scaleInMap,playAni)

    if not self.tileMap or not offset then
        return
    end

    scaleInMap = scaleInMap or 1
    local Image_mapItem = self.Image_mapItem:clone()
    Image_mapItem:setPosition(ccp(position.x+offset.x,position.y+offset.y))
    Image_mapItem:setZOrder(zorder)
    Image_mapItem:setOpacity(0)
    Image_mapItem:setScale(scaleInMap)
    Image_mapItem:setTexture(itemRes)
    local seqact = Sequence:create({
        FadeIn:create(0.8),
        CallFunc:create(function ()
            if playAni then
                local offsetY = 10
                local seqact = Sequence:create({
                    MoveBy:create(0.8, ccp(0, offsetY)),
                    MoveBy:create(0.8, ccp(0, -offsetY)),
                })
                Image_mapItem:runAction(RepeatForever:create(seqact))
            end
        end)
    })
    Image_mapItem:runAction(seqact)
    self.tileMap:addChild(Image_mapItem)

    return Image_mapItem

end

function GenerateItem:createNpc(spineRes,npcName,position,zorder)

    if not spineRes or spineRes == "" then
        return
    end

    local Panel_npcItem = self.Panel_npcItem:clone()
    local skeletonNode = SkeletonAnimation:create(spineRes)
    skeletonNode:setPosition(ccp(0,0))
    skeletonNode:play("stand",1)
    skeletonNode:setZOrder(0)
    Panel_npcItem:addChild(skeletonNode)
    Panel_npcItem:setPosition(ccp(position.x,position.y))
    Panel_npcItem:setZOrder(zorder)
    Panel_npcItem:setScale(1)
    local Label_npc = TFDirector:getChildByPath(Panel_npcItem, 'Label_npc')
    Label_npc:setText(npcName)
    self.tileMap:addChild(Panel_npcItem)

    return Panel_npcItem
end

function GenerateItem:cleanItem(tilePosMN)

    local tilePosStr = tilePosMN.x.."-"..tilePosMN.y
    local item = DalMapDataMgr:getMapItemObj(tilePosStr)
    if not item or not self.tileMap then
        return
    end

    local function acFun()
        item:removeFromParent()
        DalMapDataMgr:cleanMapItemObj(tilePosStr)
        TiledMapDataMgr:deleteMapItem(tilePosStr)
    end

    local seqact = Sequence:create({
        FadeOut:create(0.5),
        CallFunc:create(acFun)
    })
    item:runAction(seqact)

    --[[恢复地块
    local layer = self.tileMap:getLayer("floor")
    local sprite = layer:getTileAt(tilePosMN)
    if not sprite then
        return
    end
    local normalGid =  KabalaTreeDataMgr:getGroundLayerGid(EC_EventLayerGid.Tile_Normal)
    local action = Sequence:create({
        FadeOut:create(0.5),
        CallFunc:create(function()
            layer:setTileGID(normalGid,tilePosMN)
            sprite:runAction(FadeIn:create(0.5))
        end)
    })
    sprite:runAction(action)]]
end


return GenerateItem