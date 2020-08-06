local NewCityRoomView = class("NewCityRoomView", BaseLayer)
local NewCityResLoader = require("lua.logic.newCity.NewCityResLoader")

function NewCityRoomView:ctor(bid, roomlist, roomshapelist, roomfunclist, closefunc)
    self.super.ctor(self)
    self:initData(bid, roomlist, roomshapelist, roomfunclist, closefunc)
    self:init("lua.uiconfig.newCity.newCityRoomView")
end

function NewCityRoomView:registerEvents()
    EventMgr:addEventListener(self, EV_ELVES_EVENT.showUI, handler(self.onShowUI, self))
    EventMgr:addEventListener(self, EV_ELVES_EVENT.closeUI, handler(self.onCloseUI, self))

    self:addMEListener(TFWIDGET_ENTERFRAME, handler(self.update, self))
end

function NewCityRoomView:initData(bid, roomlist, roomshapelist, roomfunclist, closefunc)
    self.defaultBid = bid
    self.roomList = roomlist or {}
    self.roomShapeList = roomshapelist
    self.roomFuncList = roomfunclist
    self.closeFunc = closefunc

    self.bPagePosCheck = false
    self.roomPages = {}
    self.pageButtons = {}
    self.roomCount = #self.roomList
    self.curPageIndex = 0
    self.funcItems_ = {}

    self.showCallBack = nil
end

function NewCityRoomView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.topLayer:setAnchorPoint(me.p(0.5, 0.5))
    self.topLayer:setPosition(me.p(1136*0.5, GameConfig.WS.height*0.5))
    if NewCityDataMgr.curCityType == EC_NewCityType.NewCity_MainLine then
        self.topLayer:hideResource()
    end

    self:setBackBtnCallback(function()
        if self.closeFunc then
            self.closeFunc(self)
        end
    end)

    self.ScrollView_room = TFDirector:getChildByPath(ui, "ScrollView_room")
    --self.ScrollView_room:setSwallowTouch(false)
    self.PageView_room = TFDirector:getChildByPath(ui, "PageView_room")
    self.PageView_room:setDirection(0)
    self.PageView_room:addMEListener(TFPAGEVIEW_SCROLLENDED, function()
        self:pageScrollEnd()
    end)
    local beganpos, endpos = me.p(0, 0), me.p(0, 0)
    self.PageView_room:onTouch(function(event)
        if event.name == "began" then
            beganpos = event.target:getTouchStartPos()
        elseif event.name == "moved" then
            --self.Panel_func:hide()
        elseif event.name == "ended" then
            endpos = event.target:getTouchEndPos()
            local range = math.abs(endpos.y - beganpos.y)
            if range > 100 and endpos.y < beganpos.y then
                self:scrollRoomToPage(self.curPageIndex - 1)
            elseif range > 100 and endpos.y > beganpos.y then
                self:scrollRoomToPage(self.curPageIndex + 1)
            end
        end
    end)

    local Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
    self.Button_func = TFDirector:getChildByPath(Panel_prefab, "Button_func")
    self.Button_event = TFDirector:getChildByPath(Panel_prefab, "Button_event")
    self.Button_place = TFDirector:getChildByPath(Panel_prefab, "Button_place")
    self.Panel_func = TFDirector:getChildByPath(ui, "Panel_func")
    self.Panel_event = TFDirector:getChildByPath(ui, "Panel_event")
    self.Panel_pageButton = TFDirector:getChildByPath(ui, "Panel_pageButton")

    --self.Image_load = TFDirector:getChildByPath(ui, "Image_load"):show()
    --local orgpos = self.Image_load:getPosition()
    --self.Image_load:setPosition(me.p(orgpos.x - self.Image_load:getSize().width*0.5 - GameConfig.WS.width*0.5, orgpos.y))
    --self.topLayer:hide()
    --self.Image_load:runAction(CCSequence:create({
    --    CCMoveTo:create(0.5, orgpos),
    --    CCCallFunc:create(function()
    --        self:createRoomMap()
    --    end),
    --    CCMoveTo:create(0.5, me.p(orgpos.x + self.Image_load:getSize().width*0.5 + GameConfig.WS.width*0.5, orgpos.y)),
    --    CCCallFunc:create(function()
    --        self.topLayer:show()
    --        self.Image_load:removeFromParent()
    --
    --        if self.showCallBack then
    --            self.showCallBack()
    --        end
    --        self:checkGuide()
    --    end)
    --}
    --))

    self.Panel_anim = TFDirector:getChildByPath(ui, "Panel_anim")
    self.topLayer:hide()
    self:createRoomMap()
    self:hideRoom()

    self.guideMask = TFPanel:create():Size(GameConfig.WS)
    self.guideMask:Touchable(true)
    self.guideMask:setSwallowTouch(true)
    self:addChild(self.guideMask, 10000)

    self:timeOut(function()
        local frameEvent = function(...)
            local data = {...}
            local event =  {
                skeleton  = data[1], --动画节点
                animation = data[2], --动作名称
                name      = data[3], --事件名称
                paramN     = data[4], --整型参数
                paramF     = data[5], --浮点型参数
                paramS     = data[6]       --字符串参数
            }
            if event.name == "show" then
                self:showRoom()
            end
        end
        local anim = self.Panel_anim:getChild("Spine_gc")
        anim:playByIndex(0, 1)
        anim:addEventListener(TFARMATURE_EVENT, frameEvent)
        anim:addMEListener(TFARMATURE_COMPLETE,function(skeletonNode)
            self.topLayer:show()
            if self.showCallBack then
                self.showCallBack()
            end
            self:checkGuide()
            anim:removeFromParent()

            if self.guideMask then
                self.guideMask:removeFromParent()
                self.guideMask = nil
            end
        end)
    end, 0)
    if NewCityDataMgr.curCityType == EC_NewCityType.NewCity_Normal or NewCityDataMgr.curCityType == EC_NewCityType.NewCity_Update then   
        self.extendUI = ActivityDataMgr2:createExtendUI(self)
        if self.extendUI then
            self.extendUI:setZOrder(10)

            self.extendUI:setAnchorPoint(me.p(0.5, 0.5))
            self.extendUI:setPosition(me.p(1136*0.5, GameConfig.WS.height*0.5))
        end
    end
end

function NewCityRoomView:setShowCallBack(callback)
    self.showCallBack = callback
end

function NewCityRoomView:checkGuide()
    --do return end
    local guidedata = NewCityDataMgr.guideData
    if guidedata then
        local function guidefun()
            local bindrole = guidedata.bindRole
            local eventtype = guidedata.eventType
            if eventtype == 1 and bindrole > 0 then
                local shape = NewCityResLoader.getCachedShapeNode(bindrole)
                if not tolua.isnull(shape) then
                    local pos = shape:getNodePos(self)
                    if pos.x < GameConfig.WS.width / 2 then
                        self.ScrollView_room:jumpTo(TF_SCROLLVIEW_SCROLL_TO_PERCENT_HORIZONTAL, 0, 0)
                    else
                        self.ScrollView_room:jumpTo(TF_SCROLLVIEW_SCROLL_TO_PERCENT_HORIZONTAL, -100, 0)
                    end
                    local view = requireNew("lua.logic.newCity.NewCityGuideView"):new({node=shape,convertp=me.p(0, 250*0.5)}, me.size(220, 250), function()
                        cityController:awakeRoom(guidedata.bindBuild, true)
                        local func = shape:getClickFunc()
                        if func then
                            func()
                        end
                    end)
                    AlertManager:addLayer(view, AlertManager.BLOCK)
                    AlertManager:show()
                end
            elseif eventtype == 0 then
                local funcitem = self.Panel_event:getChildByName(tostring(guidedata.id))
                if funcitem then
                    local view = requireNew("lua.logic.newCity.NewCityGuideView"):new({node=funcitem}, nil, function()
                        cityController:awakeRoom(guidedata.bindBuild, true)
                        if funcitem.clickCallBack then
                            funcitem.clickCallBack()
                        end
                    end)
                    AlertManager:addLayer(view, AlertManager.BLOCK)
                    AlertManager:show()
                end
            end
        end
        cityController:sleepRoom(guidedata.bindBuild, true)
        if #guidedata.guideId2 > 0 then
            Utils:openView("common.FunctionTipsView", guidedata.guideId2, guidefun)
        else
            guidefun()
        end
    end
end

function NewCityRoomView:dispose()
    if self.extendUI then
        self.extendUI:dispose()
    end
    -- body
end

function NewCityRoomView:createRoomMap()
    if cityController then
        local w, h = 0, 0
        self.ScrollView_room:setSize(GameConfig.WS)
        for i = self.roomCount, 1, -1 do
            local bid = self.roomList[i]
            local pageidx = self.roomCount - i + 1
            if bid == self.defaultBid then
                self.curPageIndex = pageidx
            end
            local root, roomnode, mapsize = cityController:parseRoomMap(bid)

            local roomshape = self.roomShapeList[bid] or {}
            for i, shapev in ipairs(roomshape) do
                local shape = NewCityResLoader.getCachedShapeNode(shapev.dressId)
                if not tolua.isnull(shape) and not shape:getParent() then
                    shape:setCameraMask(1)
                    shape:setRoomScale()
                    local pos = cityController:getRoomPointPosById(shapev.buildingId)
                    local parentNode = roomnode
                    if shapev.roleType == EC_NewCityModelType.NewCity_NianShou then -- 年兽添加到特殊地图层级上，使用特殊坐标点
                        pos = cityController:getSpecialPointPosById(shapev.buildingId,shapev.randomSeed)
                        parentNode = roomnode.specialParent
                        shape:setClickFunc(function (  )
                            -- body
                            self:specialAIAction(shape,shapev)
                        end)
                        shape.shapeAnim:play("r_sleep1", true)
                        shape.shapeAnim:setupPoseWhenPlay(false)
                    end
                    shape:setShapeBornPos(pos, shapev.buildingId)
                    if parentNode then
                        parentNode:addChild(shape)
                        if shapev.roleType ~= EC_NewCityModelType.NewCity_NianShou then
                            cityController:addModelToRoom(bid, shape)
                        end
                    end
                end
            end
            cityController:reorderISOItem(bid)

            local layer = TFPanel:create()
            layer:addChild(root)
            layer:setSize(mapsize)
            w = mapsize.width
            h = h + mapsize.height
            self.ScrollView_room:setInnerContainerSize(mapsize)
            self.PageView_room:setSize(mapsize)
            self.PageView_room:addPage(layer)
            table.insert(self.roomPages, layer)

            if self.roomCount > 1 then
                local pagebt = self.Button_place:clone():show()
                local imagepoint = pagebt:getChild("Image_point")
                local buildconf = TabDataMgr:getData("NewBuild", bid)
                imagepoint:setVisible(NewCityDataMgr:checkBuildRedPoint(bid))
                pagebt:getChild("Label_place"):setTextById(buildconf.nameId)
                pagebt:getChild("Image_place"):setTexture(buildconf.houseIcon)
                pagebt:onClick(function()
                    self:scrollRoomToPage(pageidx)
                end)
                pagebt:setPosition(me.p(0, (i - 1)*(pagebt:getSize().height + 15)))
                self.Panel_pageButton:addChild(pagebt)
                table.insert(self.pageButtons, pagebt)
            end
        end
        self:scrollRoomToPage(self.curPageIndex, 0)
    end
    self.bPagePosCheck = true
    self.ScrollView_room:jumpTo(TF_SCROLLVIEW_SCROLL_TO_PERCENT_HORIZONTAL, -50, 0)
end

function NewCityRoomView:specialAIAction(shape, shapeCfg )
    -- body
    shape.shapeAnim:play("r_sleep2",false)
    shape.shapeAnim:addMEListener(TFARMATURE_COMPLETE,function ( ... )
        NewCityDataMgr.checkUpdateTimer = 0
        shape.shapeAnim:play("r_idle",true)
        shape.shapeAnim:removeMEListener(TFARMATURE_COMPLETE)
        TFDirector:send(c2s.SPRING_FESTIVAL_REQ_SEEK_NIAN_BEAST,{})
        local activityInfo = ActivityDataMgr2:getActivityInfo(shapeCfg.activityId)
        shapeCfg.jumpParamters = activityInfo.extendData.jumpParamters
        if shapeCfg.jumpParamters and shapeCfg.jumpParamters.type then
            if shapeCfg.jumpParamters.type == 2 then -- 开启关卡战斗
                local levelCfg = FubenDataMgr:getLevelCfg(shapeCfg.jumpParamters.param) 
                Utils:openView("fuben.FubenSquadView", levelCfg.dungeonType, shapeCfg.jumpParamters.param, false,1)
            elseif shapeCfg.jumpParamters.type == 3 then -- 开启下一场约会
                FunctionDataMgr:jStartDating(shapeCfg.jumpParamters.param)
            end
            return
        end
        FunctionDataMgr:jStartDating(shapeCfg.datingRuleId)
    end)
end

function NewCityRoomView:createRoomFunc(roomidx)
    self.Panel_func:removeAllChildren()
    local bid = self.roomList[roomidx]
    local funclist = self.roomFuncList[bid]
    local funcx, funcy = 0, 0
    self.funcItems_ = {}
    for i, v in ipairs(funclist) do
        local effectconf = TabDataMgr:getData("CityEffect", v)
        local funcitem = self.Button_func:clone():show()
        funcitem:setPosition(me.p(funcx, funcy))
        local labeltittle = funcitem:getChild("Label_func")
        labeltittle:setTextById(effectconf.name)
        self.Panel_func:addChild(funcitem)
        self.funcItems_[v] = funcitem
        funcitem:onClick(function()
            if cityController then
                cityController:jumpToFun(v, {bid=bid})
            end
        end)
        funcx = funcx - funcitem:getSize().width - 10
    end

    self.Panel_event:removeAllChildren()
    local extrafunc = NewCityDataMgr:getBuildExtraFunc(bid)
    local eventx, eventy = 0, 0
    for i, v in ipairs(extrafunc) do
        local eventitem = self.Button_event:clone():show()
        eventitem:setPosition(me.p(eventx, eventx))
        self.Panel_event:addChild(eventitem)
        eventitem:onClick(v.callback)
        eventitem.clickCallBack = v.callback
        eventitem:setName(v.name)
        eventy = eventy - eventitem:getSize().height - 10
    end
    self:refreshFuncItemRedPoint()
end

function NewCityRoomView:refreshFuncItemRedPoint()
    -- for k,btn in pairs(self.pageButtons) do
    --     local imageRed = btn:getChild("Image_red_point")
    --     imageRed:setVisible(false)
    --     local roomIdx = self.roomCount - k + 1
    --     local bid = self.roomList[roomIdx]
    --     if cityController:checkRedPointByBuindingId(bid) then
    --         imageRed:setVisible(true)
    --     end
    -- end
    for funcId,funcitem in pairs(self.funcItems_) do
        local imageRed = funcitem:getChild("Image_red_point")
        imageRed:setVisible(false)
        if funcId and cityController:checkEnableShowRedPointByFuncId(funcId) then
            imageRed:setVisible(true)
        end
    end
end

function NewCityRoomView:scrollRoomToPage(pageindex, time)
    time = time or 0.4
    pageindex = pageindex - 1
    if pageindex > self.roomCount or pageindex < 0 then
        return
    end
    self.PageView_room:scrollToPage(pageindex, time)
    cityController.isRoomScrolling = true
end

function NewCityRoomView:pageScrollEnd()
    --self.Panel_func:show()
    self.curPageIndex = self.PageView_room:getCurPageIndex() + 1
    local idx = self.roomCount - self.curPageIndex + 1
    self:createRoomFunc(idx)
    if self.extendUI then
        local nianshouData = ActivityDataMgr2:getNianShouData( )
        local bid = self.roomList[idx]
        self.extendUI:setInBuildVisible(nianshouData.bid == bid)
    end
    self.topLayer:setCustomTittle(TabDataMgr:getData("NewBuild", self.roomList[idx]).nameId)
    for i, v in ipairs(self.pageButtons) do
        local bt = self.pageButtons[i]
        if self.curPageIndex == i then
            bt:setTextureNormal("ui/common/button_big_n.png")
            bt:getChild("Label_place"):setColor(ccc3(255, 255, 255))
        else
            bt:setTextureNormal("ui/common/button_big_ns.png")
            bt:getChild("Label_place"):setColor(ccc3(48, 53, 74))
        end
    end
    cityController.isRoomScrolling = false
end

function NewCityRoomView:onShowUI()
    self.Panel_pageButton:hide()
    self.Panel_func:hide()
    cityController:reorderISOItem(self.roomList[self.curPageIndex])
end

function NewCityRoomView:onCloseUI()
    self.Panel_pageButton:show()
    self.Panel_func:show()
end

function NewCityRoomView:bottomPagePosCheck()
    local page = self.PageView_room:getPage(#self.roomPages - 1)
    local pos = page:getPosition()
    if pos.y > 0 then
        local offy = math.abs(pos.y - 0)
        for i, v in ipairs(self.roomPages) do
            v:setPosition(me.p(v:getPosition().x, v:getPosition().y - offy))
        end
        return true
    end
    return false
    --print("pageview y = "..pos.y)
end

function NewCityRoomView:topPagePosCheck()
    local page = self.PageView_room:getPage(0)
    local pos = page:getPosition()
    if pos.y < 0 then
        local offy = math.abs(pos.y - 0)
        for i, v in ipairs(self.roomPages) do
            v:setPosition(me.p(v:getPosition().x, v:getPosition().y + offy))
        end
    end
    --print("pageview y = "..pos.y)
end

function NewCityRoomView:hideRoom()
    self.PageView_room:hide()
    self.Panel_func:hide()
    self.Panel_event:hide()
    self.Panel_pageButton:hide()
end

function NewCityRoomView:showRoom()
    self.PageView_room:show()
    self.Panel_func:show()
    self.Panel_event:show()
    self.Panel_pageButton:show()
end

function NewCityRoomView:update(dt)
    if self.bPagePosCheck then
        if not self:bottomPagePosCheck() then
            self:topPagePosCheck()
        end
    end
end

return NewCityRoomView