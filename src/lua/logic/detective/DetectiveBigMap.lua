local DetectiveBigMap = class("DetectiveBigMap", BaseLayer)

function DetectiveBigMap:initData(triggrtHero)
    self.mapItem_ = {}
    self.minTouchMoveDis = 30
    self.mapScale = 1
    self.maxScale = 1
    local winSize = me.Director:getWinSize()
    local imgSize = CCSizeMake(1386,640)
    local scaleX = winSize.width/imgSize.width
    local scaleY = winSize.height/imgSize.height
    self.minScale = math.max(scaleX,scaleY)
    self.maxScale = math.max(scaleX*1.8,scaleY*1.8)
    self.mapScale = math.max(scaleX,scaleY)
    self.triggrtHero = triggrtHero
end

function DetectiveBigMap:ctor(triggrtHero)
    self.super.ctor(self)
    self:initData(triggrtHero)
    self:init("lua.uiconfig.activity.detectiveBigMap")
end

function DetectiveBigMap:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
    self.Panel_map_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_map_item")

    self.Button_add = TFDirector:getChildByPath(self.Panel_root, "Button_add")
    self.Button_del = TFDirector:getChildByPath(self.Panel_root, "Button_del")
    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")

    -- self.Button_add:setVisible(false)
    -- self.Button_del:setVisible(false)

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

    local contentSize = self.Image_map:getContentSize()
    self.touchNode = CCNode:create():AddTo(self.Panel_Map)
    self.touchNode:setZOrder(5)
    self.touchNode:setAnchorPoint(ccp(0.5,0.5))
    self.touchNode:setTouchEnabled(true)
    self.touchNode:setSwallowTouch(false)
    self.touchNode:setSize(contentSize)

    self:initUILogic()

end

function DetectiveBigMap:onShow()
    self.super.onShow(self)
end

function DetectiveBigMap:initTouchEvents()
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

function DetectiveBigMap:touchBegin(touch,touchPos)
    self.mapTouchBeginPos = touchPos
    self.touchOverArea = false
end

function DetectiveBigMap:touchMoved(touch,touchPos)

    self.mapContainerPrePos = self.mapContainerPos
    self.mapContainerPos = touchPos
    if self.mapContainerPos and self.mapContainerPrePos then
        self.mapContainerDiffPos = ccp(self.mapContainerPos.x - self.mapContainerPrePos.x, self.mapContainerPos.y - self.mapContainerPrePos.y)
        local targetPos = me.pAdd(ccp(self.Image_map:getPositionX(),self.Image_map:getPositionY()),self.mapContainerDiffPos)
        self:detectEdges(targetPos)
        self.Image_map:setPosition(targetPos)
    end

end

function DetectiveBigMap:touchEnd(touch,touchPos)

    self.mapContainerPrePos = nil
    self.mapContainerPos = nil
    self.mapContainerDiffPos = nil

    if not self.mapTouchBeginPos then
        return
    end

    local touchEndPos = touchPos
    local dis = me.pGetDistance(self.mapTouchBeginPos,touchEndPos)
    if dis > self.minTouchMoveDis then
        self.touchOverArea = true
    end
end

function DetectiveBigMap:setMulSwallowTouch(flag)
    if flag then
        self.touchNode:setTouchEnabled(true)
        self.touchNode:setSwallowTouch(true)
    else
        self.touchNode:setTouchEnabled(true)
        self.touchNode:setSwallowTouch(false)
    end
end

function DetectiveBigMap:setGridMapLimit()

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

function DetectiveBigMap:detectEdges(point)

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

function DetectiveBigMap:initUILogic()
    self.Image_map:setScale(self.mapScale)
    self:setGridMapLimit()
    self:initTouchEvents()
    local chapterId,areaId = DetectiveDataMgr:getCurLocation()
    if not chapterId or not areaId then
        return
    end

    local mapData = DetectiveDataMgr:getMapData(chapterId)

    self.mapItem_ = {}
    for k,v in pairs(mapData) do
        local contentItem = self.levelItem_[v.uiMapId]
        if contentItem then
            local mapItem = contentItem:getChildByName("mapItem")
            if not mapItem then
                mapItem = self.Panel_map_item:clone()
                mapItem:setPosition(ccp(0,0))
                mapItem:setName("mapItem")
                contentItem:addChild(mapItem)
            end
            local image = contentItem:getChildByName("Image_item")
            self.mapItem_[v.id] = {root = contentItem,item = mapItem,image = image,data = v,uiMapId = v.uiMapId}
            self:updateMapItem(v)
        end
    end

    self:moveToLevel(areaId,true)
    self:updateKidNapHero()
end

function DetectiveBigMap:updateMapItem(data)
    local mapItem = self.mapItem_[data.id]
    if not mapItem then
        return
    end

    mapItem.data = data
    local Label_area_name = mapItem.root:getChildByName("Label_name")
    Label_area_name:setText(data.areaName)
    local chapter,areaId = DetectiveDataMgr:getCurLocation()
    local Image_mine = mapItem.item:getChildByName("Image_mine")
    Image_mine:setVisible(areaId == data.id)
    Image_mine:setScale(0.3)
    if areaId == data.id then
        mapItem.root:getChildByName("Image_item"):setTexture(self:getItemTouchImage(data.uiMapId,true))
    end

    if chapter < data.condition then
        local image = TFImage:create("ui/activity/detective/map/suo.png")
        mapItem.item:addChild(image)
    end

end

function DetectiveBigMap:getMapContaierPos(position)
    local mapPosX = (0 - position.x)*self.mapScale
    local mapPosY = (0 - position.y)*self.mapScale
    return ccp(mapPosX, mapPosY)
end

function DetectiveBigMap:scaleMap(scale,center,centerMN)

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

function DetectiveBigMap:moveToLevel(areaId,isInit)

    if not self.mapItem_[areaId] then
        return
    end

    local position = self.mapItem_[areaId].root:getPosition()
    position = self:getMapContaierPos(position)
    position = self:detectEdges(position)

    if isInit then
        self.Image_map:setPosition(position)
        return
    end
    local sequence = Sequence:create({
        CCMoveTo:create(0.3,position),
        CallFunc:create(function ()
            if DetectiveDataMgr:getAreaID() == areaId then
                AlertManager:closeLayer(self)
            else
                DetectiveDataMgr:Req_DetectiveChooseArea(areaId)
            end
        end)
    })
    self.Image_map:runAction(sequence)
end

function DetectiveBigMap:updateKidNapHero()
    if not self.mapItem_ then
        return
    end
    local mainLogInfo = DetectiveDataMgr:getMainLogInfo()
    table.sort(mainLogInfo,function(a,b)
        local stateA = a.finished and  0 or 1
        local stateB = b.finished and  0 or 1
        return stateA < stateB
    end)
    local curLogIngo = mainLogInfo[#mainLogInfo]
    if not curLogIngo then
        return
    end

    local cfg = DetectiveDataMgr:getLogCfgData(curLogIngo.logId)
    if not cfg then
        return
    end
    local hero_pos = {{-40,40},{0,40},{40,40},{40,0},{40,-40},{0,-40},{-40,-40},{-40,0},{0,0}}
    for k,v in pairs(self.mapItem_) do
        local panel_hero = v.item:getChildByName("Panel_hero_show")
        panel_hero:removeAllChildren()
        if cfg.showMap[k] then
            for pos,imgpath in pairs(cfg.showMap[k]) do
                local image = TFImage:create("ui/activity/detective/map/"..imgpath)
                panel_hero:addChild(image)
                local position = hero_pos[tonumber(pos)]
                image:setPosition(ccp(position[1], position[2]))
                if self.triggrtHero then
                    image:setScale(2)
                    image:runAction(CCScaleTo:create(0.3,0.6))
                end
            end
        end
    end
end

function DetectiveBigMap:onChooseAreaOver()
    AlertManager:closeLayer(self)
end

function DetectiveBigMap:onClose()
    self.super.onClose(self)
end

local touch_image = {"diban_2.png","dating_2.png","zoulang_2.png","chuanghu2_2.png","chuanghu1_2.png","shulin2_2.png","shulin1_2.png"}
local touch_end_image = {"diban.png","dating.png","zoulang.png","chuanghu2.png","chuanghu1.png","shulin2.png","shulin1.png"}
function DetectiveBigMap:getItemTouchImage(pos, touch)
    if touch then
        return "ui/activity/detective/map/" ..touch_image[pos]
    else
        return "ui/activity/detective/map/" ..touch_end_image[pos]
    end
end

function DetectiveBigMap:registerEvents()
    EventMgr:addEventListener(self, EV_DETECTIVE.DETECTIVE_UPDATE_EVENT_LOG, handler(self.updateKidNapHero, self))
    EventMgr:addEventListener(self, EV_DETECTIVE.DETECTIVE_CHOOSE_AREA, handler(self.onChooseAreaOver, self))
    for k,v in pairs(self.mapItem_) do
        v.root:setTouchEnabled(true)
        v.root:OnBegan(function(sender, pos)
            local chapter = DetectiveDataMgr:getCurLocation()
            if chapter < v.data.condition then
                return
            end
            sender:getChildByName("Image_item"):setTexture(self:getItemTouchImage(v.data.uiMapId,true))
        end)
        v.root:OnEnded(function(sender, pos)
            local chapter,areaId = DetectiveDataMgr:getCurLocation()
            if areaId == v.data.id then
                sender:getChildByName("Image_item"):setTexture(self:getItemTouchImage(v.data.uiMapId,true))
            else
                sender:getChildByName("Image_item"):setTexture(self:getItemTouchImage(v.data.uiMapId))
            end
            if not self.touchOverArea then
                
                if chapter < v.data.condition then
                    Utils:showTips(13316014)
                    return
                end
                self:moveToLevel(v.data.id)
            end
        end)
    end

    self.Button_add:onClick(function()
        self:scaleMap(0.1)
    end)

    self.Button_del:onClick(function()
        self:scaleMap(-0.1)
    end)

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end


return DetectiveBigMap
