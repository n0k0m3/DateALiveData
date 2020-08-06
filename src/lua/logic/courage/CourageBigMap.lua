local CourageBigMap = class("CourageBigMap", BaseLayer)

function CourageBigMap:initData(triggrtHero)
    self.mapItem_ = {}
    self.minTouchMoveDis = 50
    self.mapScale = 1
    self.maxScale = 1
    local winSize = me.Director:getWinSize()
    local imgSize = CCSizeMake(2772,1418)
    local scaleX = winSize.width/imgSize.width
    local scaleY = winSize.height/imgSize.height
    self.minScale = math.max(scaleX,scaleY)
    self.maxScale = math.max(scaleX,scaleY)
    self.mapScale = math.max(scaleX,scaleY)
    self.triggrtHero = triggrtHero
end

function CourageBigMap:ctor(triggrtHero)
    self.super.ctor(self)
    self:initData(triggrtHero)
    self:init("lua.uiconfig.courage.courageBigMap")
end

function CourageBigMap:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
    self.Button_mapItem = TFDirector:getChildByPath(self.Panel_prefab, "Button_mapItem")
    self.Image_path = TFDirector:getChildByPath(self.Panel_prefab, "Image_path")

    self.Button_add = TFDirector:getChildByPath(self.Panel_root, "Button_add")
    self.Button_del = TFDirector:getChildByPath(self.Panel_root, "Button_del")
    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")

    self.Button_add:setVisible(false)
    self.Button_del:setVisible(false)

    self.Image_map = TFDirector:getChildByPath(self.Panel_root, "Image_map")
    self.Panel_Map = TFDirector:getChildByPath(self.Panel_root, "Panel_Map")
    local Panel_level = TFDirector:getChildByPath(self.Panel_root, "Panel_level")
    self.levelItem_ = {}
    for i, v in ipairs(Panel_level:getChildren()) do
        v:setBackGroundColorType(0)
        local name = v:getName()
        local prefix, id = string.match(name, "(.*)_(.*)")
        self.levelItem_[tonumber(id)] = v
    end

    local Panel_path = TFDirector:getChildByPath(self.Panel_root, "Panel_path")
    self.pathItem_ = {}
    for i, v in ipairs(Panel_path:getChildren()) do
        v:setBackGroundColorType(0)
        local name = v:getName()
        local prefix, id = string.match(name, "(.*)_(.*)")
        local pathItem = self.Image_path:clone()
        pathItem:hide()
        pathItem:setName("pathItem")
        pathItem:setScale(0.5)
        pathItem:setPosition(ccp(0,0))
        v:addChild(pathItem)
        self.pathItem_[tonumber(id)] = v
    end

    local contentSize = self.Image_map:getContentSize()
    self.touchNode = CCNode:create():AddTo(self.Panel_Map)
    self.touchNode:setAnchorPoint(ccp(0.5,0.5))
    self.touchNode:setTouchEnabled(true)
    self.touchNode:setSwallowTouch(false)
    self.touchNode:setSize(contentSize)

    self:initUILogic()

end

function CourageBigMap:onShow()
    self.super.onShow(self)
    self:timeOut(function()
        GameGuide:checkGuide(self);
    end,0.1)
end

function CourageBigMap:initTouchEvents()
    self.touchNode:OnBegan(function(sender, pos)
        self.touch1 = pos
        self:touchBegin(self.touch1,pos)
    end)

    self.touchNode:OnMoved(function(sender, pos)
        if self.touch1 ~= nil then
            self:touchMoved(self.touch1,pos)
        end
        self.touch1 = pos
    end)

    self.touchNode:OnEnded(function(sender, pos)
        self.touch1 = nil
        self:touchEnd(self.touch1,pos)
        self:setMulSwallowTouch(false)
    end)
end

function CourageBigMap:touchBegin(touch,touchPos)
    self.mapTouchBeginPos = touchPos
end

function CourageBigMap:touchMoved(touch,touchPos)

    self.mapContainerPrePos = self.mapContainerPos
    self.mapContainerPos = touchPos
    if self.mapContainerPos and self.mapContainerPrePos then
        self.mapContainerDiffPos = ccp(self.mapContainerPos.x - self.mapContainerPrePos.x, self.mapContainerPos.y - self.mapContainerPrePos.y)
        local targetPos = me.pAdd(ccp(self.Image_map:getPositionX(),self.Image_map:getPositionY()),self.mapContainerDiffPos)
        self:detectEdges(targetPos)
        self.Image_map:setPosition(targetPos)
    end
end

function CourageBigMap:touchEnd(touch,touchPos)

    self.mapContainerPrePos = nil
    self.mapContainerPos = nil
    self.mapContainerDiffPos = nil

    if not self.mapTouchBeginPos then
        return
    end

    local touchEndPos = touchPos
    local dis = me.pGetDistance(self.mapTouchBeginPos,touchEndPos)
    if dis < self.minTouchMoveDis then
        Utils:playSound(2001)
    end
end

function CourageBigMap:setMulSwallowTouch(flag)
    if flag then
        self.touchNode:setTouchEnabled(true)
        self.touchNode:setSwallowTouch(true)
    else
        self.touchNode:setTouchEnabled(true)
        self.touchNode:setSwallowTouch(false)
    end
end

function CourageBigMap:setGridMapLimit()

    local winSize = me.Director:getVisibleSize()
    local mapContentSize = self.Image_map:getContentSize()
    self.limitLW = winSize.width/2 - mapContentSize.width * self.mapScale /2
    if self.limitLW > 0 then
        self.limitLW = -self.limitLW
    end
    self.limitRW = -self.limitLW
    self.limitDH = winSize.height/2 - mapContentSize.height * self.mapScale /2
    if self.limitDH > 0 then
        self.limitDH = -self.limitDH
    end
    self.limitUH = -self.limitDH
end

function CourageBigMap:detectEdges(point)

    if point.x > self.limitRW then
        point.x = self.limitRW
    end
    if point.x < self.limitLW then
        point.x = self.limitLW
    end
    if point.y > self.limitUH  then
        point.y = self.limitUH
    end
    if point.y < self.limitDH then
        point.y = self.limitDH
    end
    return point
end

function CourageBigMap:initUILogic()

    self.Image_map:setScale(self.mapScale)
    self:setGridMapLimit()
    self:initTouchEvents()
    self:updatePath()
    local chapterId,areaId = CourageDataMgr:getCurLocation()
    if not chapterId or not areaId then
        return
    end

    local mapCfg = CourageDataMgr:getMapCfgByType(chapterId)
    if not mapCfg then
        return
    end

    self.mapItem_ = {}
    for k,v in pairs(mapCfg) do
        local contentItem = self.levelItem_[v.uiMapId]
        if contentItem then
            local mapItem = contentItem:getChildByName("mapItem")
            if not mapItem then
                mapItem = self.Button_mapItem:clone()
                mapItem:setPosition(ccp(0,0))
                mapItem:setName("mapItem")
                contentItem:addChild(mapItem)
            end
            self.mapItem_[v.id] = {root = contentItem,item = mapItem,data = v,uiMapId = v.uiMapId}
            self:updateMapItem(v)
        end
    end

    self:moveToLevel(areaId,true)
    self:updateKidNapHero()
end

function CourageBigMap:updateMapItem(data)

    local mapItem = self.mapItem_[data.id]
    if not mapItem then
        return
    end

    local Image_item = mapItem.root:getChildByName("Image_item")

    mapItem.data = data
    local Label_btn = mapItem.item:getChildByName("Label_btn")
    Label_btn:setText(data.areaName)
    local Label_notOpen = mapItem.item:getChildByName("Label_notOpen")
    Label_notOpen:setVisible(false)
    local posX = Label_btn:getPositionX() + Label_btn:getContentSize().width

    local curmazeDId,areaId = CourageDataMgr:getCurLocation()
    local Image_mine = mapItem.item:getChildByName("Image_mine")
    Image_mine:setPositionX(posX-48)
    Image_mine:setVisible(curmazeDId == data.mazeDId and areaId == data.id)

    local Image_monster = mapItem.item:getChildByName("Image_monster"):hide()
    local areaInfo = CourageDataMgr:getAreaInfo(data.id)
    if not areaInfo then
        return
    end

    Image_monster:setPositionX(posX -68)
    Image_monster:setVisible(areaInfo.isDevil)

    ---是否是未开发区域
    local mapCfg = CourageDataMgr:getMapCfgByCid(data.id)
    if not mapCfg then
        return
    end

    if not mapCfg.isOpen then
        for k,v in ipairs(mapCfg.passId) do
            if self.pathItem_[v] then
                self.pathItem_[v]:setVisible(false)
            end
        end
    end

    Image_item:setVisible(mapCfg.isOpen)
    mapItem.item:setVisible(mapCfg.isOpen)
    Label_notOpen:setVisible(false)
    Label_btn:setVisible(mapCfg.isOpen)
end

function CourageBigMap:getMapContaierPos(position)
    local mapPosX = (0 - position.x)*self.mapScale
    local mapPosY = (0 - position.y)*self.mapScale
    return ccp(mapPosX, mapPosY)
end

function CourageBigMap:scaleMap(scale,center,centerMN)

    if scale >0 and self.mapScale >= self.maxScale then
        return
    end

    if scale <0 and self.mapScale <= self.minScale then
        return
    end

    scale = scale or 0
    self.mapScale = self.mapScale + scale
    self.mapScale = clamp(self.mapScale, self.minScale, self.maxScale)
    self.Image_map:setScale(self.mapScale)
    self:setGridMapLimit()

    local centerPos = ccp(me.winSize.width/2,me.winSize.height/2)
    local targetPosition = self.Image_map:convertToNodeSpaceAR(centerPos)
    local mapPosX, mapPosY = self:getMapContaierPos(targetPosition)
    local position = self:detectEdges(ccp(mapPosX,mapPosY))
    self.Image_map:setPosition(position)

end

function CourageBigMap:moveToLevel(mapId,isInit,callback)

    if not self.mapItem_[mapId] then
        return
    end
    local position = self.mapItem_[mapId].root:getPosition()
    position = self:getMapContaierPos(position)
    position = self:detectEdges(position)

    if isInit then
        self.Image_map:setPosition(position)
        return
    end
    local sequence = Sequence:create({
        CCMoveTo:create(0.5,position),
        CallFunc:create(function ()
            if callback then
                callback()
            end
        end)
    })
    self.Image_map:runAction(sequence)
end

function CourageBigMap:updatePath()
    local areaInfo = CourageDataMgr:getAreaInfo()
    for k,v in pairs(areaInfo) do
        if v.roadInfoList then
            for _,info in ipairs(v.roadInfoList) do
                local startCfg = CourageDataMgr:getMapCfgByCid(info.startAreaId)
                local endCfg = CourageDataMgr:getMapCfgByCid(info.endAreaId)
                if startCfg and endCfg then
                    local pathKey = startCfg.uiMapId.."-"..endCfg.uiMapId
                    local pathId = CourageDataMgr:getPathInfo(pathKey)
                    if self.pathItem_[pathId] then
                        local pathItem = self.pathItem_[pathId]:getChildByName("pathItem")
                        pathItem:setVisible(not info.unlocked)
                    end
                end
            end
        end
    end
end

function CourageBigMap:updateKidNapHero()
    if not self.mapItem_ then
        return
    end
    local mainLogInfo = CourageDataMgr:getMainLogInfo()
    table.sort(mainLogInfo,function(a,b)
        local stateA = a.finished and  1 or 0
        local stateB = b.finished and  1 or 0
        return stateA < stateB
    end)
    local curLogIngo = mainLogInfo[#mainLogInfo]
    if not curLogIngo then
        return
    end

    local cfg = CourageDataMgr:getLogCfgData(curLogIngo.logId)
    if not cfg then
        return
    end
    for k,v in pairs(self.mapItem_) do
        if v.item then
            local Image_hero = v.item:getChildByName("Image_hero")
            Image_hero:setVisible(v.uiMapId == cfg.showMap)
            if v.uiMapId == cfg.showMap then
                Image_hero:setTexture(cfg.showRole)
                if self.triggrtHero then
                    Image_hero:setScale(3)
                    Image_hero:runAction(CCScaleTo:create(0.3,1))
                end
            end
        end
    end
end

function CourageBigMap:onClose()
    self.super.onClose(self)
end

function CourageBigMap:excuteGuideFunc30013(guideFuncId)
    local targetNode = self.Button_close
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

function CourageBigMap:registerEvents()
    EventMgr:addEventListener(self, EV_COURAGE.EV_UPDATE_EVENT_LOG, handler(self.updateKidNapHero, self))
    for k,v in pairs(self.mapItem_) do
        v.item:onClick(function()
            self:moveToLevel(v.data.id)
        end)
    end

    self.Button_add:onClick(function()
        self:scaleMap(0.1)
    end)

    self.Button_del:onClick(function()
        self:scaleMap(-0.1)
    end)

    self.Button_close:onClick(function()
        GameGuide:checkGuideEnd(self.guideFuncId)
        AlertManager:closeLayer(self)
    end)
end


return CourageBigMap
