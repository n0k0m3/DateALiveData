local DalBigMiniMap = class("DalBigMiniMap", BaseLayer)

function DalBigMiniMap:ctor(playerMN)
    self.super.ctor(self)
    self:initData(playerMN)
    self:showPopAnim(true)
    self:init("lua.uiconfig.dls.dalBigMiniMap")
end

function DalBigMiniMap:initData(playerMN)

    self.playerMN = playerMN

    self.mapScale = 0.1
    self.maxScale = 0.5
    self.minScale = 0.1
    self.aroundTile = {}

end

function DalBigMiniMap:initUI(ui)
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

    self:createMiniMap()
end

function DalBigMiniMap:onShow()
    self.super.onShow(self)
end

function DalBigMiniMap:createMiniMap()

    local mapCid = DalMapDataMgr:getMapCid()
    if not mapCid then
        return
    end

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

    self.bigMiniMap = tileMap
    self.player = self.Image_player:clone()
    self.bigMiniMap:addChild(self.player)
    self.Panel_base:addChild(self.bigMiniMap)

    self:setMapBaseInfo()
end

function DalBigMiniMap:setMapBaseInfo()

    self.plainLayer = self.bigMiniMap:getLayer("floor")
    self.eventLayer = self.bigMiniMap:getLayer("event")
    self.bigMiniMap:setAnchorPoint(me.p(0.5,0.5))
    self.bigMiniMap:setScale(self.mapScale)

    local posMN = DalMapDataMgr:getPlayerPosMN()
    self:setPlayerPosition(posMN)
    self:initTiledData()
    self:setGridMapLimit()
    self:locationMiniMap(self.playerMN,true)
    self:initGirdItem()

    self.zoneTip = {}
    self:setZoneInfo()
    --滑动
    self:initTouchEvents()
end

function DalBigMiniMap:setZoneInfo()
    for k,v in ipairs(self.zoneTip) do
        local cloneItem = self.Image_zone:clone()
        local Label_name = TFDirector:getChildByPath(cloneItem, "Label_name")
        Label_name:setTextById(v.nameId)

        local tilePosMN = v.pos

        local position = TiledMapDataMgr:convertToPos(tilePosMN.x,tilePosMN.y)
        position =  TiledMapDataMgr:convertToPosAR(position.x,position.y)
        cloneItem:setPosition(position)
        cloneItem:setScale(5)
        self.bigMiniMap:addChild(cloneItem)
    end
end

function DalBigMiniMap:setPlayerPosition(posMN)
    if not posMN then
        return
    end
    self.playerMN = posMN
    local position = TiledMapDataMgr:convertToPos(posMN.x,posMN.y)
    position =  TiledMapDataMgr:convertToPosAR(position.x,position.y)
    local zorder = TiledMapDataMgr:getTileZorder(posMN.x,posMN.y)
    self.player:setZOrder(zorder)
    self.player:setPosition(position)
end

function DalBigMiniMap:initTiledData()

    local tileXCount,tileYCount = TiledMapDataMgr:getTileXYCount()
    for i=0,tileXCount-1 do
        for j=0,tileYCount-1 do

            local isOpen = DalMapDataMgr:isOpen(ccp(i,j))
            local opacity = isOpen and 255 or 0
            self:spawnNormalTile(ccp(i,j),opacity)
        end
    end
end

function DalBigMiniMap:spawnNewTile(newPosMN)

    if not newPosMN then
        return
    end

    local floorGidId = 157
    if not self.eventLayer then
        return
    end

    local eventGid = self.eventLayer:getTileGIDAt(newPosMN)
    if eventGid == 2 then
        floorGidId = 156
    end

    self.plainLayer:setTileGID(floorGidId,newPosMN)
    --self:spawnNormalTile(newPosMN,255,true)
end

--生成普通层格子
function DalBigMiniMap:spawnNormalTile(tilePosMN,opacity,isAdd)

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

function DalBigMiniMap:locationMiniMap(posMN,isInit)

    if not self.bigMiniMap or not posMN then
        return
    end

    local targetPosition = TiledMapDataMgr:convertToPos(posMN.x,posMN.y)
    local mapPosX, mapPosY = self:getMapContaierPos(targetPosition)
    local position = self:detectEdges(ccp(mapPosX,mapPosY))
    if not isInit then
        self.bigMiniMap:runAction(MoveTo:create(0.5,position))
    else
        self.bigMiniMap:setPosition(position)
    end
end


function DalBigMiniMap:initTouchEvents()

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

function DalBigMiniMap:setMulSwallowTouch(flag)
    if flag then
        self.touchNode:setTouchEnabled(true)
        self.touchNode:setSwallowTouch(true)
    else
        self.touchNode:setTouchEnabled(true)
        self.touchNode:setSwallowTouch(false)
    end
end

function DalBigMiniMap:touchBegin(touch,touchPos)

    if not self.bigMiniMap then
        return
    end
    self.mapTouchBeginPos = touchPos
end

function DalBigMiniMap:touchMoved(touch,touchPos)

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

function DalBigMiniMap:touchEnd(touch,touchPos)

    self.mapContainerPrePos = nil
    self.mapContainerPos = nil
    self.mapContainerDiffPos = nil
end

function DalBigMiniMap:scaleMap(scale,center,centerMN)

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
end

function DalBigMiniMap:playerMove(posMN)

    if not posMN then
        return
    end

    --self:setPlayerPosition(posMN)
    local position = TiledMapDataMgr:convertToPos(posMN.x,posMN.y)
    position =  TiledMapDataMgr:convertToPosAR(position.x,position.y)
    self:locationMiniMap(posMN)
    self:Moving(position)
end

function DalBigMiniMap:Moving(position)

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

function DalBigMiniMap:initGirdItem()
    self.mapItem = {}
    local mapItems = TiledMapDataMgr:getMapItem()
    for k,v in pairs(mapItems) do
        self:spawnNewItem(v.pos,v.smallRes,v.offset,v.scaleInMap)
    end
end

function DalBigMiniMap:spawnNewItem(tilePosMN,itemRes,offset,scaleInMap)

    if not tilePosMN or not itemRes or not offset or not scaleInMap then
        return
    end
    self:createItem(tilePosMN,itemRes,offset,scaleInMap)
end

function DalBigMiniMap:createItem(tilePosMN,itemRes,offset,scaleInMap)

    for k,v in pairs(self.mapItem) do
        if v.pos.x == tilePosMN.x and tilePosMN.y == v.pos.y then
            return
        end
    end

    local position = TiledMapDataMgr:convertToPos(tilePosMN.x,tilePosMN.y)
    position =  TiledMapDataMgr:convertToPosAR(position.x,position.y)

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

function DalBigMiniMap:cleanItem(tilePosMN)

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

function DalBigMiniMap:getMapContaierPos(targetPos)

    local tileXCount,tileYCount = TiledMapDataMgr:getTileXYCount()
    local tileWidth,tileHeight  = TiledMapDataMgr:getTileSize()

    local mapPosX = (tileXCount*tileWidth/2 - targetPos.x)*self.mapScale
    local mapPosY = (tileYCount*tileHeight/2 - targetPos.y)*self.mapScale
    return mapPosX, mapPosY
end

--设置地图拖动边界
function DalBigMiniMap:setGridMapLimit()

    if not self.bigMiniMap then
        return
    end

    local winSize = me.Director:getVisibleSize()
    local tileXCount,tileYCount = TiledMapDataMgr:getTileXYCount()
    local tileWidth,tileHeight  = TiledMapDataMgr:getTileSize()
    self.limitLW = winSize.width/2 - tileWidth * tileXCount * self.mapScale /2
    if self.limitLW > 0 then
        self.limitLW = -self.limitLW
    end
    self.limitRW = -self.limitLW
    self.limitDH = winSize.height/2 - tileHeight * tileYCount * self.mapScale /2
    if self.limitDH > 0 then
        self.limitDH = -self.limitDH
    end
    self.limitUH = -self.limitDH
end

function DalBigMiniMap:detectEdges(point)

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

function DalBigMiniMap:onRecvTransfer(targetPosMN)

    if not self.bigMiniMap then
        return
    end

    self:locationMiniMap(targetPosMN)
    self:setPlayerPosition(targetPosMN)

end

function DalBigMiniMap:registerEvents()

    EventMgr:addEventListener(self,EV_DAL_MAP.MiniMapSpwanTiled,handler(self.spawnNewTile, self))
    EventMgr:addEventListener(self,EV_DAL_MAP.MiniMapSpwanItem,handler(self.spawnNewItem, self))
    EventMgr:addEventListener(self,EV_DAL_MAP.MiniMapPlayerMove,handler(self.playerMove, self))
    EventMgr:addEventListener(self,EV_DAL_MAP.MiniMapCleanItem,handler(self.cleanItem, self))
    EventMgr:addEventListener(self,EV_DAL_MAP.MiniMapTransfer,handler(self.onRecvTransfer, self))

    self.Button_add:onClick(function ()
        self:scaleMap(0.02)
    end)

    self.Button_del:onClick(function ()
        self:scaleMap(-0.02)
    end)
end

return DalBigMiniMap