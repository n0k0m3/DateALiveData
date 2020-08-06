local NewCityMainLayer = class("NewCityMainLayer", BaseLayer)
local zEye = me.Director:getZEye()
local E_CameraMoveType = {
    E_EnterRoom = 1,
    E_QuitRoom = 2,
    E_ChangeToFore = 3,
    E_ChangeToBack = 4,
}
--摄像机推进距离
E_CameraForwardDis = {
    E_ToBack = zEye - 200,
    E_ToEnterRoom = zEye - 250,
    E_ToFore = zEye + 50,
}

local fireWorkEffect = {
        {effect = "animation",voice = "sound/dating_sound/dating_284.mp3"},
        {effect = "animation2",voice = "sound/dating_sound/dating_284.mp3"},
        {effect = "animation3",voice = "sound/dating_sound/dating_284.mp3"},
        {effect = "animation4",voice = "sound/dating_sound/dating_285.mp3"},
        {effect = "animation5",voice = "sound/dating_sound/dating_285.mp3"},
        {effect = "animation6",voice = "sound/dating_sound/dating_286.mp3"},
    }

local ResLoader = require("lua.logic.newCity.NewCityResLoader")
--dump(ResLoader, "ResLoader Res")

function NewCityMainLayer:ctor()
    self.super.ctor(self) 
    self:initData()
    self:init("lua.uiconfig.newCity.newCityMainLayer")
end

function NewCityMainLayer:excludeLogic( )
    return true
end

function NewCityMainLayer:registerEvents()
    if NewCityDataMgr.curCityType == EC_NewCityType.NewCity_Normal or NewCityDataMgr.curCityType == EC_NewCityType.NewCity_Update then
        EventMgr:addEventListener(self, EV_NEW_CITY.cityUpdate, handler(self.onCityUpdate, self))
        EventMgr:addEventListener(self, EV_ELVES_EVENT.state, handler(self.onFairStateUpdate, self))
        EventMgr:addEventListener(self,EV_DATING_EVENT.getMainReward, handler(self.onFairStateUpdate, self))
        EventMgr:addEventListener(self, EV_DATING_EVENT.refreshRole, handler(self.onFairStateUpdate, self))
        EventMgr:addEventListener(self, EV_TASK_RECEIVE, handler(self.onFairStateUpdate, self))
        EventMgr:addEventListener(self,EV_ACTIVITY_USE_FIREWORK,function ( event )
            self:playSpecialSpineEffect(event.id,event.randSeed)
        end)

        EventMgr:addEventListener(self, EV_RECV_CHATINFO, handler(self.onRecvMessage, self))
        EventMgr:addEventListener(self, EV_ACTIVITY_REFRESH_NIANBREAST, function ( ... )
            Utils:openView("activity.NianShouCallSuccessTip",ActivityDataMgr2:getNianShouData( ))
        end)

        --EventMgr:addEventListener(self, EV_DATING_EVENT.cityDatingTips, handler(self.onCityDatingTips, self))
        EventMgr:addEventListener(self, EV_DATING_EVENT.refreshRedTips, handler(self.refreshBuildRedPoint, self))
    elseif NewCityDataMgr.curCityType == EC_NewCityType.NewCity_MainLine or
            NewCityDataMgr.curCityType == EC_NewCityType.NewCity_Outside or
            NewCityDataMgr.curCityType == EC_NewCityType.NewCity_FuBen then
        EventMgr:addEventListener(self, EV_NEWCITY_DATING_EVENT.refreshNewCityEvent, handler(self.onRefreshCityEvent, self))
    end
    self:addMEListener(TFWIDGET_ENTERFRAME, handler(self.update, self))
end

function NewCityMainLayer:onRecvMessage(chatInfo)
    if not chatInfo then
        return;
    end

    local chatType = chatInfo.chatType
    if chatInfo.fun == EC_ChatState.MARQUEE then
        if self.extendUI and self.extendUI:isVisible() then
           Utils:showNoticeNode(self,chatInfo.content)
       end
    end
end

function NewCityMainLayer:onEnter()
    self.super.onEnter(self)
end

function NewCityMainLayer:onExit()
    self.super.onExit(self)

    if self.enterVoiceHandle then
        TFAudio.stopEffect(self.enterVoiceHandle)
        self.enterVoiceHandle = nil
    end

    if self.cityCameraMoveTimer then
        TFDirector:removeTimer(self.cityCameraMoveTimer)
        self.cityCameraMoveTimer = nil
    end
    if cityController then
        cityController:exitCity()
    end

    if self.extendUI then
        self.extendUI:dispose()
    end

    self.fireWorkTimers = self.fireWorkTimers or {}

    for k,v in pairs(self.fireWorkTimers) do
        TFDirector:stopTimer(v)
        TFDirector:removeTimer(v)
        self.fireWorkTimers[k] = nil
    end
end

function NewCityMainLayer:onShow()
    self.super.onShow(self)
    --if not TFAudio.isMusicPlaying() then
        --if NewCityDataMgr.curCityType == EC_NewCityType.NewCity_MainLine then
        --    SafeAudioExchangePlay().playBGM(self, true, "sound/bgm/date_001.mp3")
        --else
            SafeAudioExchangePlay().playBGM(self, true)
        --end
    --end

    self.isHide = false
end

function NewCityMainLayer:onHide()
    self.super.onHide(self)
    self.isHide = true
end

function NewCityMainLayer:initData()
    cityController:clean()
    cityController:startTimer()

    self.curCityLevel = EC_NewCityLevel.NewCity_Fore
    self.designScreenSize = me.size(me.EGLView:getDesignResolutionSize())
    self.isCityCameraMove = false
    self.isInRoom = false
    self.isNeedUpdate = false

    self.openedRoom = {}

    self.baseBuildIcon = {}
    self.buildIconList = {}
    self.fairStateIcons = {}
    self.eventIcons = {}

    NewCityDataMgr.checkUpdateTimer = 0
    self.cityCameraMoveTimer = nil

    self.enterVoiceHandle = nil
end

function NewCityMainLayer:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui
    --ui层
    self.Panel_ui = TFDirector:getChildByPath(self.ui, "Panel_ui")

    --城市层
    self.Panel_city = TFDirector:getChildByPath(self.ui, "Panel_city")
    self.ScrollView_city = TFDirector:getChildByPath(self.ui, "ScrollView_city")
    self.ScrollView_city.isScrolling = false
    self.Panel_touch = TFDirector:getChildByPath(self.Panel_city, "Panel_touch")

    local Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab"):hide()
    self.Image_event = Panel_prefab:getChild("Image_event")
    self.Image_state = Panel_prefab:getChild("Image_state")
    self.Image_status = Panel_prefab:getChild("Image_status")
    self.Image_buildIcon = Panel_prefab:getChild("Image_buildIcon")
    self.Image_buildIconRed = Panel_prefab:getChild("Image_buildIconRed")
    self.Panel_iconList = Panel_prefab:getChild("Panel_iconList")
    self.Image_buildTittle = Panel_prefab:getChild("Image_buildTittle")

    self:setBackBtnCallback(function()
        self.topLayer.Button_back:Touchable(false)
        if cityController then
            cityController:exitCity()
        end
        AlertManager:changeScene(SceneType.MainScene)
    end)

    self.cityData = clone(NewCityDataMgr:getCitydata())
    self:initMap()
    self:initCityCamera()
    self:initTouchPanel()

    NewCityDataMgr:clearBuildExtraFunc()
    if NewCityDataMgr.curCityType == EC_NewCityType.NewCity_Normal or NewCityDataMgr.curCityType == EC_NewCityType.NewCity_Update then
        self:onFairStateUpdate()
        self.infoView = requireNew("lua.logic.newCity.NewCityInfoView"):new(true)
        self.fairView = requireNew("lua.logic.newCity.NewCityFairListView"):new(function(roleid)
            if self.ScrollView_city.isScrolling then
                self.ScrollView_city:stopAllActions()
                self.ScrollView_city.isScrolling = false
                return
            end
            for k, buildingv in pairs(self.cityData.roleData) do
                for i, v in ipairs(buildingv) do
                    if v.roleId == roleid then
                        local roomtb = self:getRoomTbById(k)
                        if roomtb then
                            self:openRoom(roomtb.bg, roomtb)
                        end
                        return
                    end
                end
            end
        end)
        self:addLayerToNode(self.fairView, self.Panel_ui, EC_NewCityZOrder.FairListView)
        self.enterVoiceHandle = VoiceDataMgr:playVoice("button_dating",RoleDataMgr:getUseId())
        self.extendUI = ActivityDataMgr2:createExtendUI(self)
        if self.extendUI then
            self.extendUI:setZOrder(1)
        end
    elseif NewCityDataMgr.curCityType == EC_NewCityType.NewCity_MainLine then
        self.topLayer:hide()
        self.infoView = requireNew("lua.logic.newCity.NewCityInfoView"):new(false)
        self:addEventIcon(NewCityDataMgr:getMainLineData())
    elseif NewCityDataMgr.curCityType == EC_NewCityType.NewCity_Outside then
        self.topLayer:hide()
        self.infoView = requireNew("lua.logic.newCity.NewCityInfoView"):new(false)
        self:addEventIcon(NewCityDataMgr:getOutsideData())
    elseif NewCityDataMgr.curCityType == EC_NewCityType.NewCity_FuBen then
        self.topLayer:hide()
        self.infoView = requireNew("lua.logic.newCity.NewCityInfoView"):new(false)
        --local firstentrance = self:addEventIcon(NewCityDataMgr:getFubenLineData())
        --if firstentrance then
        --    local conf = NewCityDataMgr:getEntranceConf(firstentrance)
        --    local roomtb = self:getRoomTbById(conf.bindBuild)
        --    if roomtb then
        --        self:openRoom(roomtb.bg, roomtb)
        --    end
        --end
        local fubendata = NewCityDataMgr:getFubenLineData()
        self:addEventIcon(fubendata)
    end
    self:addLayerToNode(self.infoView, self.Panel_ui, EC_NewCityZOrder.InfoView)

    self.guideMask = TFPanel:create():Size(GameConfig.WS)
    self.guideMask:Touchable(true)
    self.guideMask:setSwallowTouch(true)
    self:addChild(self.guideMask, 10000)
    self:timeOut(function()
        if self.guideMask then
            self.guideMask:removeFromParent()
            self.guideMask = nil
        end
        if self:checkGuide() then
            return
        end
        if NewCityDataMgr.curCityType == EC_NewCityType.NewCity_Normal or NewCityDataMgr.curCityType == EC_NewCityType.NewCity_Update then
            self:checkOutsideOpen()
            self:checkRemindEvents()
        end
        self:checkPreOpenView()
    end, 0)

end

---检测是否有要打开的预定页面
function NewCityMainLayer:checkPreOpenView()
    self:timeOut(function()
        local param = NewCityDataMgr:getPreOpenParam()
        if param then
            local openType = param[1]
            local heroId = param[2]
            local heroCfg = HeroDataMgr:getHero(heroId)
            RoleDataMgr:setCurId(heroCfg.role)
            if openType == 1 then  --主线约会页面
                Utils:openView("dating.DatingLetterViewNew")
            elseif openType == 2 then  --日常约会页面
                Utils:openView("dating.NewDatingDayView")
            end
            NewCityDataMgr:setPreOpenParam(nil)
        end
    end, 0.05)
end

function NewCityMainLayer:initShape()
    for k, buildingv in pairs(self.cityData.roleData) do
        for i, v in ipairs(buildingv) do
            local shape = ResLoader.getCachedShapeNode(v.dressId)
            if not tolua.isnull(shape) and not shape:getParent() then
                shape:setCameraMask(2)
                local pos = me.p(0, 0)
                if v.buildingId == 2 then--前景
                    --pos = cityController:getForePointPos()
                    pos = cityController:getBaseMapPointPos()
                    shape:setCityScale()
                    shape:setShapeBornPos(pos, v.buildingId)
                    --shape:setShapeLevel(EC_NewCityLevel.NewCity_Fore)
                    self.foreMap.road:addChild(shape)
                    cityController:addModel(EC_NewCityLevel.NewCity_Fore, shape)
                    --elseif v.buildingId == 3 then--后景
                    --pos = cityController:getBackPointPos()
                    --    shape:setShapeBornPos(pos, v.buildingId)
                    --    shape:setShapeLevel(EC_NewCityLevel.NewCity_Back)
                    --    self.backMap.road:addChild(shape)
                    --    cityController:addModel(EC_NewCityLevel.NewCity_Back, shape)
                end
            end
            --elseif v.buildingId >= 100 and v.buildingId < 200 then--前景房间
            --    pos = cityController:getRoomPointPosById(v.buildingId)
            --    shape:setShapeBornPos(pos, v.buildingId)
            --    shape:setShapeLevel(EC_NewCityLevel.NewCity_Fore)
            --    self.foreMap.build[v.buildingId].room:addChild(shape)
            --    cityController:addModelToRoom(v.buildingId, shape)
            --elseif v.buildingId >= 200 and v.buildingId < 300 then--后景房间
            --    pos = cityController:getRoomPointPosById(v.buildingId)
            --    shape:setShapeBornPos(pos, v.buildingId)
            --    shape:setShapeLevel(EC_NewCityLevel.NewCity_Back)
            --    self.backMap.build[v.buildingId].room:addChild(shape)
            --    cityController:addModelToRoom(v.buildingId, shape)
            --end
        end
    end
    cityController:reorderISOItem(2)
end

function NewCityMainLayer:initMap()
    --self.cityMapNode, self.foreMap, self.backMap = cityController:parseCityMap(NewCityDataMgr:getCityDay())
    self.cityMapNode, self.foreMap = cityController:parseCityMap(NewCityDataMgr:getCityDay())
    local layer = TFPanel:create()
    layer:addChild(self.cityMapNode)
    layer:setSize(cityController.mapSize)
    --layer:setAnchorPoint(me.p(0.5, 0.5))
    --layer:setPosition(me.p(layer:getSize().width*0.5, layer:getSize().height*0.5))
    self.ScrollView_city:setSize(GameConfig.WS)
    self.ScrollView_city:setInnerContainerSize(cityController.mapSize)
    self.ScrollView_city:addChild(layer)
    self:scrollCityTo()

    --self.ScrollView_city:setScale(1.2)
    --self.ScrollView_city:runAction(CCScaleTo:create(0.2, 1.0))

    self:initShape()

    for k, v in pairs(self.foreMap.build) do
        local node = v.bg
        node:setTouchEnabled(true)
        node:setHitType(TFTYPE_POINT)
        node:onTouch(function(event)
            if event.name == "began" then
                self:setBuildHighLight(k, true)
            elseif event.name == "ended" then
                self:setBuildHighLight(k, false)
            end
        end)
        node:onClick(function()
            self:openRoom(node, v)
        end)
    end
    --for k, v in pairs(self.backMap.build) do
    --    local node = v.bg
    --    node:setTouchEnabled(true)
    --    node:setHitType(TFTYPE_POINT)
    --    node:onClick(function()
    --        self:openRoom(node, v)
    --    end)
    --end

    for k, v in pairs(self.cityData.buildData) do
        local buildconf = TabDataMgr:getData("NewBuild", k)
        local iconpoint = buildconf.iconPoint
        if not self.baseBuildIcon[iconpoint] then
            local tittley = 0
            if buildconf.buildEffectType and (NewCityDataMgr.curCityType == EC_NewCityType.NewCity_Normal or NewCityDataMgr.curCityType == EC_NewCityType.NewCity_Update) then
                self.baseBuildIcon[iconpoint] = self.Image_buildIconRed:clone():show()
                tittley = -47
            else
                self.baseBuildIcon[iconpoint] = self.Image_buildIcon:clone():show()
                tittley = -32
            end
            local baseicon = self.baseBuildIcon[iconpoint]
            baseicon.isEffctBuild = buildconf.buildEffectType
            baseicon.arrow = baseicon:getChild("Image_arrow")
            local buildtittle = self.Image_buildTittle:clone():show()
            buildtittle:setPosition(me.p(0, tittley))
            buildtittle:getChild("Label_tittle"):setTextById(buildconf.buildName)
            baseicon.tittle = buildtittle
            baseicon:addChild(buildtittle)

            baseicon.orgsize = me.size(buildconf.headNum*self.Panel_iconList:getSize().width, baseicon:getSize().height)
            baseicon:setSize(baseicon.orgsize)
            local showpos = cityController:getBuildIconPoint(iconpoint)
            baseicon:setPosition(me.p(showpos.x, showpos.y + baseicon.orgsize.height*0.5))
            self.foreMap.buildIcon:addChild(baseicon)
        end
    end
    self:refreshBuildRedPoint()
    --cityController:switchToFore()
end

function NewCityMainLayer:initCityCamera()
    --城市相机
    self.center = me.Vertex3F(self.designScreenSize.width * 0.5, self.designScreenSize.height * 0.5 + 30, 0)
    local up     = me.Vertex3F(0, 1.0, 0)
    local pos = me.Vertex3F(self.center.x, self.center.y, E_CameraForwardDis.E_ToFore)
    self.cityCamera = Camera:createPerspective(60, self.designScreenSize.width / self.designScreenSize.height, 10, zEye + self.designScreenSize.height)
    self.cityCamera:setCameraFlag(2)
    self.cityCamera:lookAt(self.center, up)
    self.cityCamera:setPosition3D(pos)
    self.cityCamera.p3d = pos
    self.ui:addChild(self.cityCamera)
    self.Panel_city:setCameraMask(2)
end

function NewCityMainLayer:initTouchPanel()
    --城市手势切换
    local beganpos = me.p(0, 0)
    local endpos = me.p(0, 0)
    self.Panel_handSwitch = TFPanel:create()
    self.Panel_handSwitch:setSize(self.designScreenSize)
    self.Panel_touch:addChild(self.Panel_handSwitch)
    self:handSwitchEnable(true)
    self.Panel_handSwitch:onTouch(function(event)
        if event.name == "began" then
            self.ScrollView_city:stopAllActions()
            self.ScrollView_city.isScrolling = false
            --beganpos = event.target:getTouchStartPos()
        --elseif event.name == "ended" then
        --    endpos = event.target:getTouchEndPos()
        --    local dis = math.abs(endpos.y - beganpos.y)
        --    if endpos.y > beganpos.y and dis > self.designScreenSize.height*0.25 and not self.isCityCameraMove and not self.isInRoom then
        --        self:switchToFore()
        --    elseif endpos.y < beganpos.y and dis > self.designScreenSize.height*0.25 and not self.isCityCameraMove and not self.isInRoom then
        --        self:switchToBack()
        --    end
        end
    end)
end

function NewCityMainLayer:checkGuide(entrances)
    --do return end
    NewCityDataMgr.guideData = nil
    if NewCityDataMgr.curCityType == EC_NewCityType.NewCity_FuBen then
        local entrances = NewCityDataMgr:getFubenLineData().entrances or {}
        --dump(entrances, "entrances")
        for i, v in ipairs(entrances) do
            if v.guide then
                local conf = NewCityDataMgr:getEntranceConf(v.entranceId)
                NewCityDataMgr.guideData = clone(conf)
                local roomtb = self:getRoomTbById(conf.bindBuild)
                if roomtb then
                    local function guidefun()
                        local view = requireNew("lua.logic.newCity.NewCityGuideView"):new({node=roomtb.bg, convertp=me.p(roomtb.bg:getSize().width*0.5,roomtb.bg:getSize().height*0.5)},
                                nil,
                                function()
                                    if conf.isSkipBuild and conf.scriptId > 0 then
                                        NewCityDataMgr:startEntrance(conf, EC_DatingChoiceType.ChoiceScript)
                                    else
                                        self:openRoom(roomtb.bg, roomtb)
                                    end
                                end
                        )
                        AlertManager:addLayer(view, AlertManager.BLOCK)
                        AlertManager:show()
                    end
                    if #NewCityDataMgr.guideData.guideId1 > 0 then
                        self:scrollCityTo(roomtb.bg:getPosition(), true, function()
                            Utils:openView("common.FunctionTipsView", NewCityDataMgr.guideData.guideId1, guidefun)
                        end)
                    else
                        self:scrollCityTo(roomtb.bg:getPosition(), true, guidefun)
                    end
                    return true
                end
            end
        end
    end
    return false
end

function NewCityMainLayer:checkOutsideOpen()
    local bhave = false
    if bhave then

    end
end

function NewCityMainLayer:checkRemindEvents()
    local bhave = NewCityDataMgr:isHaveRemindEvents()
    if bhave then
        local layer = requireNew("lua.logic.newCity.NewCityRemindView"):new()
        AlertManager:addLayer(layer, AlertManager.BLOCK)
        AlertManager:show()
    end
end

function NewCityMainLayer:setBuildHighLight(bid, blight)
    local buildconf = TabDataMgr:getData("NewBuild", bid)
    if bid == 112 or bid == 207 then
        local roomtb = self:getRoomTbById(bid)
        if blight then
            local lightbg = ""
            local daytype = NewCityDataMgr:getCityDay()
            local picname = "citymap/"..EC_NewCityDayRoomMapRoot[daytype].."build/"..tostring(bid).."_1.png"
            lightbg = TFImage:create(picname)
            lightbg:setAnchorPoint(me.p(0.5, 0.5))
            lightbg:setName("lightbg")
            lightbg:setCameraMask(roomtb.bg:getCameraMask())
            roomtb.bg:addChild(lightbg)
        else
            local lightbg = roomtb.bg:getChild("lightbg")
            if lightbg then
                lightbg:removeFromParent()
            end
        end
    else
        if #buildconf.openBoth > 0 then
            for i, v in ipairs(buildconf.openBoth) do
                local roomtb = self:getRoomTbById(v)
                roomtb.bg:setHighLightEnabled(blight, true)
            end
        else
            local roomtb = self:getRoomTbById(bid)
            roomtb.bg:setHighLightEnabled(blight, true)
        end
    end
end

--增加精灵状态icon
function NewCityMainLayer:addFairStatusIcon()
    for k, buildingv in pairs(self.cityData.roleData) do
        for i, v in ipairs(buildingv) do
            if v.roleType == EC_NewCityModelType.NewCity_Fair 
                or v.roleType == EC_NewCityModelType.NewCity_NianShou then
                --EC_ElvesState = {
                --    datingMain = 1, -- 主线约会
                --    datingReserveRequest = 2, -- 预定约会邀请
                --    datingReserve = 3, -- 预定约会
                --    datingOut = 4, -- 出游约会
                --    datingDayNoFinish = 5, -- 日常约会（未完成)
                --    hunger = 6, -- 饥饿
                --    angry = 7, -- 生气
                --    bored = 8, -- 无聊
                --}
                local state = nil
                if v.roleType == EC_NewCityModelType.NewCity_NianShou then
                    local activityInfo = ActivityDataMgr2:getActivityInfo(v.activityId)
                    if activityInfo.extendData.nianBeastEscapeTime ~= -1 then -- 年兽未找到，不显示
                        return 
                    end
                else
                    state = RoleDataMgr:getElvesShowState(v.roleId)
                end
                local roomtb = self:getRoomTbById(v.buildingId)
                if roomtb and v.buildingId >= 100 then
                    local buildconf = TabDataMgr:getData("NewBuild", v.buildingId)
                    local iconpoint = buildconf.iconPoint
                    if not self.fairStateIcons[iconpoint] then
                        self.fairStateIcons[iconpoint] = self.Panel_iconList:clone():show()
                        self.fairStateIcons[iconpoint].iconcount = buildconf.headNum
                        self.fairStateIcons[iconpoint]:setCameraMask(2)
                        self.buildIconList[iconpoint] = self.fairStateIcons[iconpoint]
                        --self.buildIconList[iconpoint] = self.buildIconList[iconpoint] or {}
                        --table.insert(self.buildIconList[iconpoint], self.fairStateIcons[iconpoint])
                        self.baseBuildIcon[iconpoint]:addChild(self.fairStateIcons[iconpoint])
                    end
                    local sicon = self.Image_state:clone():show()
                    sicon:setCameraMask(2)
                    sicon:getChild("Image_di"):setTexture(v.modeHead)
                    local iconstate = sicon:getChild("Image_stateicon")
                    if not state or state == 0 then
                        iconstate:hide()
                    else
                        iconstate:show()
                        iconstate:setTexture(EC_FairStateIcon[state])
                    end
                    self.fairStateIcons[iconpoint]:addChild(sicon)
                    sicon:Touchable(true)
                    sicon:onClick(function()
                        EventMgr:dispatchEvent(EV_CITY_OPEN_ROOM)
                        if not  v.roleType == EC_NewCityModelType.NewCity_NianShou then
                            RoleDataMgr:sendUpdateMainActivation(v.roleId)
                        end
                        self:openRoom(roomtb.bg, roomtb)
                    end)
                end

                if state and state > 0 then
                    local ricon = self.Image_status:clone():show()
                    ricon:setTexture(EC_FairStateIcon[state])
                    local shape = ResLoader.getCachedShapeNode(v.dressId)
                    if not tolua.isnull(shape) then
                        shape:addIcon(ricon)
                    end
                end
            end
        end
    end
    self:setBuildIconPos()
end

--增减事件icon
function NewCityMainLayer:addEventIcon(datingdata)
    self:removeAllBuildIcon()
    NewCityDataMgr:clearBuildExtraFunc()

    local function createEvent(eventpic, clickcall)
        local event = self.Image_event:clone():show()
        local eventicon = event:getChild("Image_eventicon")
        local epic = eventpic.event
        local rpic = eventpic.role
        local imagedi = event:getChild("Image_di")
        if not rpic then
            eventicon:hide()
            imagedi:setTexture(epic)
        else
            imagedi:setScale(0.45)
            imagedi:setPosition(me.p(imagedi:getPosition().x, imagedi:getPosition().y + 3))
            imagedi:setTexture(rpic)
            eventicon:setTexture(epic)
        end
        event:setCameraMask(2)
        event:setPosition(me.p(0, 0))
        if clickcall then
            event:Touchable(true)
            event:onClick(clickcall)
        end
        return event
    end
    local function addEvent(parent, bid, event)
        local buildconf = TabDataMgr:getData("NewBuild", bid)
        local iconpoint = buildconf.iconPoint
        if not self.eventIcons[iconpoint] then
            self.eventIcons[iconpoint] = self.Panel_iconList:clone():show()
            self.eventIcons[iconpoint].iconcount = buildconf.headNum
            self.eventIcons[iconpoint]:setCameraMask(2)
            self.buildIconList[iconpoint] = self.eventIcons[iconpoint]
            --self.buildIconList[iconpoint] = self.buildIconList[iconpoint] or {}
            --table.insert(self.buildIconList[iconpoint], self.eventIcons[iconpoint])
            self.baseBuildIcon[iconpoint]:addChild(self.eventIcons[iconpoint])
        end
        self.eventIcons[iconpoint]:addChild(event)
    end
    local data = datingdata or {}
    for i, v in ipairs(data.entrances) do
        local conf = NewCityDataMgr:getEntranceConf(v.entranceId)
        if conf.eventType == 0 then--地点事件
            if conf.bindBuild >= 100 then
                local roomtb = self:getRoomTbById(conf.bindBuild)
                NewCityDataMgr:addBuildExtraFunc(conf.bindBuild, tostring(v.entranceId), function()
                    NewCityDataMgr:startEntrance(conf, EC_DatingChoiceType.ChoiceScript)
                end)
                local event = createEvent({event=conf.scriptIcon1}, function()
                    if conf.isSkipBuild then
                        NewCityDataMgr:startEntrance(conf, EC_DatingChoiceType.ChoiceScript)
                    else
                        self:openRoom(roomtb.bg, roomtb)
                    end
                end)
                addEvent(roomtb.bg, conf.bindBuild, event)
            end
        elseif conf.eventType == 1 then--人物事件
            if conf.bindBuild >= 100 then
                local roomtb = self:getRoomTbById(conf.bindBuild)
                local event = createEvent({role=self:getRoleDataById(conf.bindRole).modeHead, event=conf.scriptIcon2}, function()
                    if conf.isSkipBuild then
                        NewCityDataMgr:startEntrance(conf, EC_DatingChoiceType.ChoiceScript)
                    else
                        self:openRoom(roomtb.bg, roomtb)
                    end
                end)
                addEvent(roomtb.bg, conf.bindBuild, event)
            end
            local shape = ResLoader.getCachedShapeNode(conf.bindRole)
            if not tolua.isnull(shape) then
                local event = createEvent({event=conf.scriptIcon2})
                event:setScale(1.0)
                shape:setClickFunc(function()
                    NewCityDataMgr:startEntrance(conf, EC_DatingChoiceType.ChoiceScript)
                end)
                shape:addIcon(event)
            end
        elseif conf.eventType == 2 then--信息事件
            if conf.bindBuild >= 100 then
                local roomtb = self:getRoomTbById(conf.bindBuild)
                local event = createEvent({event=conf.scriptIcon1}, function()
                    NewCityDataMgr:startEntrance(conf, EC_DatingChoiceType.ChoiceMessage)
                end)
                addEvent(roomtb.bg, conf.bindBuild, event)
            end
        elseif conf.eventType == 3 then--功能事件

        end
    end
    self:setBuildIconPos()
    --return data.entrances[1]
end

function NewCityMainLayer:handSwitchEnable(benable)
    if benable then
        self.Panel_handSwitch.isEnable = true
        self.Panel_handSwitch:setTouchEnabled(true)
        self.Panel_handSwitch:setSwallowTouch(false)
    else
        self.Panel_handSwitch.isEnable = false
        self.Panel_handSwitch:setTouchEnabled(false)
    end
end

function NewCityMainLayer:cityCameraMove(movetype, offx, offy, endz, callback)
    if self.cityCameraMoveTimer then
        TFDirector:removeTimer(self.cityCameraMoveTimer)
        self.cityCameraMoveTimer = nil
    end
    local movecount = 25
    offx = offx or 0
    offy = offy or 0
    local stpos = self.cityCamera.p3d
    local endx = stpos.x + offx
    local endy = stpos.y + offy
    local offz = 0
    if endz then
        offz = stpos.z - endz
    else
        offz = 0
    end
    local xper = offx / movecount
    local yper = offy / movecount
    local zper = offz / movecount
    local opper = math.floor(255 / movecount)
    local count = 0
    self.isCityCameraMove = true
    self.cityCameraMoveTimer = TFDirector:addTimer(0, -1, nil, function()
        if count > movecount then
            TFDirector:removeTimer(self.cityCameraMoveTimer)
            self.cityCameraMoveTimer = nil
            self.isCityCameraMove = false
            if callback then
                callback()
            end
            return
        end

        --if movetype == E_CameraMoveType.E_ChangeToBack then
        --    local newop = self.foreMap.root:getOpacity() - opper
        --    if newop < 0 then
        --        newop = 0
        --        self:hideFore()
        --    end
        --    self:setForeOpacity(newop)
        --elseif movetype == E_CameraMoveType.E_ChangeToFore then
        --    local newop = self.foreMap.root:getOpacity() + opper
        --    if newop > 255 then
        --        newop = 255
        --    end
        --    self:setForeOpacity(newop)
        --elseif movetype == E_CameraMoveType.E_EnterRoom then
        --    for i, v in ipairs(self.openedRoom) do
        --        local newop = v.bg:getOpacity() - opper
        --        if newop < 0 then
        --            newop = 0
        --            self.isInRoom = true
        --            v.bg:hide()
        --            v.room:show()
        --            if i == 1 then
        --                self:openRoomView()
        --            end
        --        end
        --        v.bg:setOpacity(newop)
        --    end
        --elseif movetype == E_CameraMoveType.E_QuitRoom then
        --    for i, v in ipairs(self.openedRoom) do
        --        if not v.bg:isVisible() then v.bg:show() end
        --        if v.room:isVisible() then
        --            v.room:hide()
        --            if v.roomfunc then
        --                v.roomfunc:closeSelf()
        --                v.roomfunc = nil
        --            end
        --        end
        --        if not v.bg:isVisible() then v.bg:show() end
        --        local newop = v.bg:getOpacity() + opper
        --        if newop > 255 then
        --            newop = 255
        --        end
        --        v.bg:setOpacity(newop)
        --    end
        --end
        local pos = self.cityCamera.p3d
        if xper > 0 then
            pos.x = me.clampf(pos.x + xper, stpos.x, endx)
        else
            pos.x = me.clampf(pos.x + xper, endx, stpos.x)
        end
        if yper > 0 then
            pos.y = me.clampf(pos.y + yper, stpos.y, endy)
        else
            pos.y = me.clampf(pos.y + yper, endy, stpos.y)
        end
        if zper > 0 then
            pos.z = me.clampf(pos.z - zper, stpos.z, endz)
        else
            pos.z = me.clampf(pos.z - zper, endz, stpos.z)
        end
        self.cityCamera.p3d = pos
        self.cityCamera:setPosition3D(pos)
        count = count + 1
    end)
end

function NewCityMainLayer:scrollCityTo(pos, immediate, callback)
    callback = callback or function() end
    immediate = immediate or false
    local percent = 0
    local speed = 2000
    local time = 0
    if pos then
        local x = pos.x
        local scw = self.designScreenSize.width
        local halfw = scw*0.5
        local scrollw = self.ScrollView_city:getContentSize().width
        local innerw = self.ScrollView_city:getInnerContainerSize().width
        local curx = self.ScrollView_city:getInnerContainer():getPosition().x + halfw
        percent = (x - halfw) / (innerw - scrollw)
        if not immediate then
            time = math.abs((innerw - scrollw) * percent - math.abs(curx)) / speed
        end
        self.ScrollView_city:scrollTo(TF_SCROLLVIEW_SCROLL_TO_PERCENT_HORIZONTAL, time, nil, -percent*100)
    else
        self.ScrollView_city:scrollTo(TF_SCROLLVIEW_SCROLL_TO_PERCENT_HORIZONTAL, time, nil, -50)
    end
    self.ScrollView_city.isScrolling = true

    self.ScrollView_city:timeOut(function()
        self.ScrollView_city.isScrolling = false
        callback()
    end, time)
end

function NewCityMainLayer:showFore()
    self.foreMap.root:show()
    self.foreMap.road:show()
    self.foreMap.frontDecorate:show()
    self.foreMap.backDecorate:show()
end

function NewCityMainLayer:hideFore()
    self.foreMap.root:hide()
    self.foreMap.road:hide()
    self.foreMap.frontDecorate:hide()
    self.foreMap.backDecorate:hide()
end

function NewCityMainLayer:setForeOpacity(op)
    self.foreMap.root:setOpacity(op)
    self.foreMap.road:setOpacity(op)
    self.foreMap.frontDecorate:setOpacity(op)
    self.foreMap.backDecorate:setOpacity(op)
end

function NewCityMainLayer:switchToFore()
    self:showFore()
    cityController:switchToFore()
    self:cityCameraMove(E_CameraMoveType.E_ChangeToFore, nil, nil, E_CameraForwardDis.E_ToFore, function()
        self.curCityLevel = EC_NewCityLevel.NewCity_Fore
    end)
end

function NewCityMainLayer:switchToBack()
    cityController:switchToBack()
    self:cityCameraMove(E_CameraMoveType.E_ChangeToBack, nil, nil, E_CameraForwardDis.E_ToBack, function()
        self.curCityLevel = EC_NewCityLevel.NewCity_Back
    end)
end

function NewCityMainLayer:openRoom(roomnode, roomtb, callback)
    if self.isCityCameraMove or self.isInRoom then return end
    local openCallBack = function()
        local roomview = self:openRoomView(roomtb.bid)
        roomview:setShowCallBack(callback)
    end
    local function enterRoom()
        self:scrollCityTo(roomnode:getPosition(), false, function()
            local offx = roomnode:getPosition().x + self.ScrollView_city:getInnerContainer():getPosition().x - self.cityCamera.p3d.x + GameConfig.WS.width*0.5
            local offy = roomnode:getPosition().y + self.ScrollView_city:getInnerContainer():getPosition().y - self.cityCamera.p3d.y + GameConfig.WS.height*0.5
            openCallBack()
            self:cityCameraMove(E_CameraMoveType.E_EnterRoom, offx, offy, E_CameraForwardDis.E_ToEnterRoom)
        end)
    end
    --if roomtb.bid >= 200 and roomtb.bid < 300 and self.curCityLevel == EC_NewCityLevel.NewCity_Fore then
    --    cityController:switchToBack()
    --    self:cityCameraMove(E_CameraMoveType.E_ChangeToBack, nil, nil, E_CameraForwardDis.E_ToBack, function()
    --        self.curCityLevel = EC_NewCityLevel.NewCity_Back
    --        enterRoom()
    --    end)
    --else
    --    enterRoom()
    --end
    enterRoom()
end

function NewCityMainLayer:quitRoom(callback)
    if self.isCityCameraMove then
        return
    end
    local z = E_CameraForwardDis.E_ToFore
    --if self.curCityLevel == EC_NewCityLevel.NewCity_Back then
    --    z = E_CameraForwardDis.E_ToBack
    --end

    --self.openedRoom = {}
    --self.isInRoom = false
    cityController:removeRoomShape()
    self:cityCameraMove(E_CameraMoveType.E_QuitRoom, self.center.x - self.cityCamera.p3d.x, self.center.y - self.cityCamera.p3d.y, z, function()
        --self.openedRoom = {}
        self.isInRoom = false
        if callback then
            callback()
        end
    end)
end

function NewCityMainLayer:getRoomTbById(bid)
    --if self.foreMap.build[bid] then
    --    return self.foreMap.build[bid]
    --end
    --if self.backMap.build[bid] then
    --    return self.backMap.build[bid]
    --end
    if self.foreMap.build[bid] then
        return self.foreMap.build[bid]
    end
    return nil
end

function NewCityMainLayer:getRoleDataById(dressid)
    for k, bv in pairs(self.cityData.roleData) do
        for i, v in ipairs(bv) do
            if v.dressId == dressid then
                return v
            end
        end
    end
    return {}
end

function NewCityMainLayer:onCityUpdate()
    if NewCityDataMgr.curCityType == EC_NewCityType.NewCity_Normal or NewCityDataMgr.curCityType == EC_NewCityType.NewCity_Update then
        self.isNeedUpdate = true
    end
end

function NewCityMainLayer:removeAllBuildIcon()
    for k, v in pairs(self.fairStateIcons) do
        v:removeFromParent()
    end
    self.fairStateIcons = {}
    for k, bv in pairs(self.eventIcons) do
        bv:removeFromParent()
    end
    self.eventIcons = {}
    self.buildIconList = {}
end

function NewCityMainLayer:setBuildIconPos()
    for k, v in pairs(self.baseBuildIcon) do
        local buildIcon = v
        if self.buildIconList[k] then
            local bv = self.buildIconList[k]
            local Image_iconList = bv:getChild("Image_iconList")
            local children = bv:getChildren() or {}
            local childcount = #children - 1
            if childcount > 0 then
                local col = bv.iconcount
                local basew = self.Panel_iconList:getSize().width
                local baseh = self.Panel_iconList:getSize().height
                --bv:setAnchorPoint(me.p(0, 1))
                local allw = 0
                if childcount > col then
                    allw = col * basew
                else
                    allw = childcount * basew
                end
                local height = 0
                local lastx = 0
                local idx = 1
                for i, v in ipairs(children) do
                    if v:getName() ~= "Image_iconList" then
                        local curcol= ((idx-1) % col) + 1
                        local currow = math.floor((idx-1) / col)
                        local rowidx = (idx - 1) % col + 1
                        local offidx = math.floor(rowidx / 2)
                        v:setPosition(me.p(lastx + basew*0.5, -baseh*0.5 - currow*baseh))
                        height = (currow + 1)*baseh
                        lastx = v:getPosition().x
                        if curcol >= col then
                            lastx = 0
                        else
                            lastx = lastx + basew*0.5
                        end
                        idx = idx + 1
                    end
                end
                if buildIcon.isEffctBuild and (NewCityDataMgr.curCityType == EC_NewCityType.NewCity_Normal or NewCityDataMgr.curCityType == EC_NewCityType.NewCity_Update) then
                    buildIcon:setTexture("ui/newCity/city/45.png")
                    Image_iconList:setTexture("ui/newCity/city/46.png")
                    buildIcon.arrow:setPosition(me.p(buildIcon.arrow:getPosition().x, -45 - height))
                    --buildIcon.tittle:setPosition(me.p(0, -47))
                    buildIcon:setSize(me.size(buildIcon.orgsize.width, 46))
                    bv:setSize(me.size(allw, height))
                    bv:setPosition(me.p(-bv:getSize().width*0.5, -46))
                else
                    buildIcon:setTexture("ui/newCity/city/42.png")
                    Image_iconList:setTexture("ui/newCity/city/43.png")
                    buildIcon.arrow:setPosition(me.p(buildIcon.arrow:getPosition().x, -36 - height))
                    buildIcon:setSize(me.size(buildIcon.orgsize.width, buildIcon.orgsize.height))
                    bv:setSize(me.size(allw, height))
                    bv:setPosition(me.p(-bv:getSize().width*0.5, -buildIcon.orgsize.height))
                end
                Image_iconList:setSize(me.size(buildIcon.orgsize.width, height))
            end
        else
            if buildIcon.isEffctBuild and (NewCityDataMgr.curCityType == EC_NewCityType.NewCity_Normal or NewCityDataMgr.curCityType == EC_NewCityType.NewCity_Update) then
                buildIcon:setTexture("ui/newCity/city/44.png")
                buildIcon.arrow:setPosition(me.p(buildIcon.arrow:getPosition().x, -57))
                --buildIcon.tittle:setPosition(me.p(0, -47))
                buildIcon:setSize(me.size(buildIcon.orgsize.width, 60))
            else
                buildIcon:setTexture("ui/newCity/city/25.png")
                buildIcon.arrow:setPosition(me.p(buildIcon.arrow:getPosition().x, -36))
                buildIcon:setSize(buildIcon.orgsize)
            end
        end
    end
end

function NewCityMainLayer:onFairStateUpdate(roleId)
    self:removeAllBuildIcon()
    cityController:removeShapeState()
    self:addFairStatusIcon()
end

function NewCityMainLayer:onRefreshCityEvent()
    self.cityData = nil
    self.cityData = clone(NewCityDataMgr:getCitydata())
    cityController:resetAllPoint()
    local roomview = self.Panel_ui:getChildByName("RoomView")
    if roomview then
        self:showTopLayer()
        self:removeLayerFromNode(roomview, self.Panel_ui)
    end
    cityController:removeAllShape()
    self:addEventIcon(NewCityDataMgr:getDatingLineData())
    self:quitRoom(function()
        self:initShape()
        self:checkGuide()
    end)
end

function NewCityMainLayer:onCityDatingTips()
    local info = DatingDataMgr:getReserveScriptTime()
    if info then
        self.infoView:datingTipsUpdate(info)
    else
        self.infoView:hideDatingTips()
    end
end

function NewCityMainLayer:update(target, dt)
    if NewCityDataMgr.curCityType == EC_NewCityType.NewCity_Normal or NewCityDataMgr.curCityType == EC_NewCityType.NewCity_Update then
        NewCityDataMgr.checkUpdateTimer = NewCityDataMgr.checkUpdateTimer + dt
        if NewCityDataMgr.checkUpdateTimer > 1.0 then
            NewCityDataMgr.checkUpdateTimer = 0
            if self.isNeedUpdate and AlertManager.layerQueue:length() <= 0 then
                self.isNeedUpdate = false
                if cityController then
                    cityController:exitCity()
                end
                NewCityDataMgr:enterNewCity(EC_NewCityType.NewCity_Update)
                return
            end
        end
    end
end

function NewCityMainLayer:showTopLayer()
    if NewCityDataMgr.curCityType == EC_NewCityType.NewCity_Normal or NewCityDataMgr.curCityType == EC_NewCityType.NewCity_Update then
        self.topLayer:show()
        if self.extendUI then
            self.extendUI:show()
        end
    end
end

function NewCityMainLayer:refreshBuildRedPoint()
    for k,builldIcon in pairs(self.baseBuildIcon) do
        local redPoint = builldIcon:getChild("Image_red_point")
        if redPoint then
            redPoint:hide()
        end
    end
    if CityJobDataMgr:checkJobEventDown() then
        local jobEvent = CityJobDataMgr:getWorkingJobInfo()
        local buildconf = TabDataMgr:getData("NewBuild", jobEvent.buildingId)
        local iconpoint = buildconf.iconPoint
        if self.baseBuildIcon[iconpoint] then
            local builldIcon = self.baseBuildIcon[iconpoint]
            local redPoint = builldIcon:getChild("Image_red_point")
            if redPoint then
                redPoint:show()
            end
        end
    end
end

function NewCityMainLayer:openRoomView(bid)
    local buildconf = TabDataMgr:getData("NewBuild", bid)
    local openroom = {}
    if #buildconf.openBoth <= 0 then
        table.insert(openroom, bid)
    end
    for i, v in ipairs(buildconf.openBoth) do
        table.insert(openroom, v)
    end
    local roomshape = {}
    for i, v in ipairs(openroom) do
        if self.cityData.roleData[v] then
            roomshape[v] = clone(self.cityData.roleData[v]) or {}
        end
    end
    local roomfunc = {}
    for i, v in ipairs(openroom) do
        if self.cityData.buildData[v] then
            roomfunc[v] = clone(self.cityData.buildData[v].buildingFuns) or {}
        end
    end

    local view = requireNew("lua.logic.newCity.NewCityRoomView"):new(bid, openroom, roomshape, roomfunc, function(layer)
        self:showTopLayer()
        self:removeLayerFromNode(layer, self.Panel_ui)
        self:quitRoom()
    end)
    view:setName("RoomView")
    self.topLayer:hide()
    if self.extendUI then
        self.extendUI:hide()

        if self:getChildByName("NoticeLayer") then
            self:getChildByName("NoticeLayer"):removeFromParent(true)
        end
    end
    self:addLayerToNode(view, self.Panel_ui, EC_NewCityZOrder.Room)
    self.curOpenRoomView = view
    return view
end

function NewCityMainLayer:playSpecialSpineEffect( fireWorkId ,randomSeed)
    local currentScene = Public:currentScene()
    if currentScene and currentScene:getTopLayer() and currentScene:getTopLayer() ~= self then
        return
    end
    local room = self.Panel_ui:getChildByName("RoomView")
    if room or self.isHide then return end
    local startRandomSeed = randomSeed
    self.fireWorkTimers = self.fireWorkTimers or {}
    local delayTime = 0
    for i = 1,8 do
        math.randomseed(startRandomSeed + i*10)
        local config = fireWorkEffect[math.random(1,#fireWorkEffect)]
        delayTime = delayTime + math.random(500,800)
        local timerHandler = TFDirector:addTimer(delayTime,1,nil,function ( ... )
            local posAndKey = cityController:getBaseMapSpecialEffectPointPos(startRandomSeed)
            if posAndKey and self.foreMap.specialEffectParent then
                local effect = SkeletonAnimation:create("effect/newyear/eff_yanhua")
                effect:setAnimationFps(GameConfig.ANIM_FPS)
                effect:setPosition(posAndKey.pos)
                self.foreMap.specialEffectParent:addChild(effect)
                effect:setVisible(false)
                effect:setCameraMask(2)
                TFDirector:removeTimer(timerHandler)
                timerHandler = nil
                effect:setVisible(true)
                effect:play(config.effect,false)
                effect:addMEListener(TFARMATURE_COMPLETE,function ( ... )
                    effect:removeFromParent(true)
                    cityController:visibleBaseMapSpecialEffectPoint(posAndKey.key)
                end)
                local handle = TFAudio.playEffect(config.voice);          
            end
        end)
        table.insert(self.fireWorkTimers,timerHandler)  
    end
end

function NewCityMainLayer:onKeyBack()
    local topLayer = AlertManager:getTopLayer()
    if topLayer then
        AlertManager:closeTopLayer()
    else
        if self.curOpenRoomView then
            if not self.isCityCameraMove then
                self:showTopLayer()
                self:removeLayerFromNode(self.curOpenRoomView, self.Panel_ui)
                self:quitRoom()
                self.curOpenRoomView = nil
            end
        else
            self.topLayer.Button_back:Touchable(false)
            if cityController then
                cityController:exitCity()
            end
            AlertManager:changeScene(SceneType.MainScene)
        end
    end
end

return NewCityMainLayer