local KabalaTreeExploreView = class("KabalaTreeExploreView", BaseLayer)
local KabalaTreeNpc = import(".KabalaTreeNpc")
local KabalaTreeGridMap = import(".KabalaTreeGridMap")
local KabalaAStarPath = import(".KabalaAStarPath")
local KabalaTreeItem = import(".KabalaTreeItem")
local KabalaTreeMiniMap = import(".KabalaTreeMiniMap")

function KabalaTreeExploreView:ctor(mapId)
	self.super.ctor(self)

	self:initData(mapId)
    AudioExchangePlay.stopAllBgm()
	self:init("lua.uiconfig.kabalaTree.kabalaTreeExploreView")
end

function KabalaTreeExploreView:getClosingStateParams()
    return {KabalaTreeDataMgr:getCurWorldId()}
end

function KabalaTreeExploreView:onShow()
    self.super.onShow(self)
    KabalaTreeDataMgr:setFightViewFlag(false)
end

function KabalaTreeExploreView:onHide()
    self.super.onHide(self)
end

function KabalaTreeExploreView:onClose()
    self.KabalaTreeNpc:removeEvents()
    KabalaTreeDataMgr:clearNewOpenTitled()
    KabalaTreeDataMgr:clearStronghold()
    TFDirector:setTouchSingled(true)
    KabalaTreeDataMgr:setInWorldFage(false)
end

function KabalaTreeExploreView:initData(mapId)

    self.mapId = mapId
    self.minTouchMoveDis = 50                   --用于判断地图是否是拖动
    self.playerModeScale = 1.5
    self.playerPos = ccp(3,3)
    self.mapScale = KabalaTreeDataMgr:getMapScale()
    self.minScale = 0.3
    self.maxScale = 1

    self.mapContainerPrePos = nil
    self.mapContainerPos = nil
    self.mapContainerDiffPos = nil
    self.mapTouchBeginPos = nil
    self.index =  0
    self.KabalaTreeGridMap = KabalaTreeGridMap.new()
    self.KabalaAStarPath = KabalaAStarPath.new()
    self.KabalaTreeNpc = KabalaTreeNpc:new()
    self.KabalaTreeItem = KabalaTreeItem:new()
    self.KabalaTreeMiniMap = KabalaTreeMiniMap:new()

    self.timer = 0
    self.spreadSpeed = 2
    self.radarDelayTime = 0.3
    self.radarUpdateTime = 3
    self.maxRadarNum = 1
    self.playRadarSound = false

    self.pathDot = {}
    self.locationEnd = true
    self.aroundTile = {}
    local discreteData = Utils:getKVP(19002, "radarDis")
    self.discreteData = {}
    for k,info in pairs(discreteData) do
        local data = {}
        data.dis = k
        for cnt,delayTime in pairs(info) do
            data.max = cnt
            data.updateTime = delayTime
        end
        table.insert(self.discreteData,data)
    end

    table.sort(self.discreteData, function(a, b)
           return a.dis > b.dis
    end)

    self.normalMax = self.discreteData[1].max
    self.normalUpdateTime = self.discreteData[1].updateTime
    self:setRadarParam(self.normalMax,self.normalUpdateTime)
end


function KabalaTreeExploreView:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	self:showTopBar()

    --设置标题
    self.TextArea_title = TFDirector:getChildByPath(self.topLayer, 'TextArea_title')

	self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui,"Panel_prefab")
    self.Panel_treeExploreMap = TFDirector:getChildByPath(self.Panel_root, 'Panel_treeExploreMap')
    self.Panel_treeExploreMap:setTouchEnabled(false)
    self.contentSize = self.Panel_treeExploreMap:getContentSize()
    
    self.touchNode = CCNode:create():AddTo(self.Panel_treeExploreMap)
    self.touchNode:setAnchorPoint(ccp(0.5,0.5))
    self.touchNode:setTouchEnabled(true)
    self.touchNode:setSwallowTouch(false)
    self.touchNode:setSize(self.contentSize)
    TFDirector:setTouchSingled(false)

    --prefab
    self.Panel_ship = TFDirector:getChildByPath(self.Panel_prefab, 'Panel_player') 
    self.Image_random = TFDirector:getChildByPath(self.Panel_prefab, 'Image_random')
    self.Image_pathdot = TFDirector:getChildByPath(self.Panel_prefab, 'Image_pathdot')
    self.Spine_clickPrefab = TFDirector:getChildByPath(self.Panel_prefab, 'Spine_click')
    self.Spine_occupyPrefab = TFDirector:getChildByPath(self.Panel_prefab, 'Spine_occupy')

    --UI
    self.Panel_UI = TFDirector:getChildByPath(self.Panel_root, 'Panel_UI')
    self.Button_maphelp = TFDirector:getChildByPath(self.Panel_UI, 'Button_maphelp')  
    local Label_btn = TFDirector:getChildByPath(self.Button_maphelp, 'Label_btn')
    Label_btn:setTextById(3004012)

    self.Button_itembag = TFDirector:getChildByPath(self.Panel_UI, 'Button_itembag')
    local Label_btn = TFDirector:getChildByPath(self.Button_itembag, 'Label_btn')
    Label_btn:setTextById(3004013)

    self.Button_statistics = TFDirector:getChildByPath(self.Panel_UI, 'Button_statistics')
    local Label_btn = TFDirector:getChildByPath(self.Button_statistics, 'Label_btn')
    Label_btn:setTextById(3003018)
    
    self.Button_statelist = TFDirector:getChildByPath(self.Panel_UI, 'Button_statelist')
    local Label_btn = TFDirector:getChildByPath(self.Button_statelist, 'Label_btn')
    Label_btn:setTextById(3004014)

    self.Button_chat = TFDirector:getChildByPath(self.Panel_UI, 'Button_chat')
    self.Button_location = TFDirector:getChildByPath(self.Panel_UI, 'Button_location')

    self.Image_task_bg = TFDirector:getChildByPath(self.Panel_UI, 'Image_task_bg')
    self.Image_task_bg:setVisible(true)
    self.Label_title = TFDirector:getChildByPath(self.Image_task_bg, 'Label_title')
    self.Label_title:setTextById(3004015)
    self.Label_task = TFDirector:getChildByPath(self.Image_task_bg, 'Label_task')

    local Panel_random = TFDirector:getChildByPath(self.Panel_UI, 'Panel_random')
    self.skipRandomBtn = TFDirector:getChildByPath(Panel_random, 'Button_skip')
    
    self.Image_direction = TFDirector:getChildByPath(self.Panel_UI, 'Image_direction')
    self.Panel_pointDirection = TFDirector:getChildByPath(self.Panel_UI, 'Panel_pointDirection'):hide()

    self.Spine_discoverTask = TFDirector:getChildByPath(self.Panel_UI, 'Spine_discoverTask')
    self.Panel_miniMap = TFDirector:getChildByPath(self.Panel_UI, 'Panel_miniMap')
    self.MiniPlayer = TFDirector:getChildByPath(self.Panel_prefab, 'Image_miniPlayer')

    self.materialId = {500025,570101}
    self.Panel_resource_bg = TFDirector:getChildByPath(self.Panel_UI, 'Panel_resource_bg')
    self.material = {}
    for i=1,2 do
        local Image_material = TFDirector:getChildByPath(self.Panel_resource_bg, "Image_material_"..i)
        local Image_material_icon = Image_material:getChildByName("Image_material_icon")
        local Label_material_count = Image_material:getChildByName("Label_material_count")
        self.material[i] = {}
        self.material[i].bg = Image_material 
        self.material[i].icon = Image_material_icon 
        self.material[i].count = Label_material_count
    end

    --team
    self.Image_team_bg = TFDirector:getChildByPath(self.Panel_UI, 'Image_team_bg')
    self.teamInfo = {}
    for i=1,3 do
       local teamImage =  TFDirector:getChildByPath(self.Image_team_bg, 'Image_team'..i)
       local memberflag = TFDirector:getChildByPath(teamImage, 'Image_member_flag')
       local Image_team_head = TFDirector:getChildByPath(teamImage, 'Image_team_head')
       local Label_state_tx = TFDirector:getChildByPath(teamImage, 'Label_state_tx')
       local Image_state = TFDirector:getChildByPath(teamImage, 'Image_state')
       local effectBar = TFDirector:getChildByPath(teamImage, 'LoadingBar_bar')
       local Image_add = TFDirector:getChildByPath(teamImage, 'Image_add')
       local Image_teambar_bg = TFDirector:getChildByPath(teamImage, 'Image_teambar_bg')
       local Image_headbg = TFDirector:getChildByPath(teamImage, 'Image_headbg')
       Label_state_tx:setTextById(3004016)
       self.teamInfo[i] = {teamImage = teamImage,memberflag = memberflag,headImg = Image_team_head,stateTx = Label_state_tx,
                           stateImage = Image_state,effectbar = effectBar,Image_add = Image_add,barbg = Image_teambar_bg,headbg =Image_headbg}
    end

    --radar
    self.Image_radar = TFDirector:getChildByPath(self.Panel_UI, 'Image_radar')
    self.radarCircle = TFDirector:getChildByPath(self.Panel_prefab, 'Image_radar_circle')
    self.radarCircle:setScale(0)
    self.radarFlash = TFDirector:getChildByPath(self.Image_radar, 'Image_radar_flash')
    self.radarFlash:setVisible(false)
    self.radarDot = {}
    for i=1,10 do
        self.radarDot[i] = TFDirector:getChildByPath(self.Image_radar, 'Image_radar_dot'..i)
        self.radarDot[i]:setOpacity(0)
    end
    self.Button_radar = TFDirector:getChildByPath(self.Image_radar, 'Button_radar')

    --buff
    self.buffInfo = {}
    self.Panel_buff = TFDirector:getChildByPath(self.Panel_UI, 'Panel_buff')
    for i=1,3 do
        local Panel_buff = TFDirector:getChildByPath(self.Panel_UI, 'Panel_buff_'..i)
        local buffBtn = TFDirector:getChildByPath(Panel_buff, 'Button_buff')
        buffBtn:setScale(0.6)
        local buffIcon = TFDirector:getChildByPath(buffBtn, 'Image_buff')
        local Label_buffnum = TFDirector:getChildByPath(Panel_buff, 'Label_buffnum')
        self.buffInfo[i] = {Panel_buff = Panel_buff,buffBtn = buffBtn,buffIcon = buffIcon,buffNum = Label_buffnum}
    end
    self.Panel_buff_tip = TFDirector:getChildByPath(self.Panel_UI, 'Panel_buff_tip'):hide()
    self.Label_buff_name = TFDirector:getChildByPath(self.Panel_buff_tip, 'Label_buff_name')
    self.Label_buff_desc = TFDirector:getChildByPath(self.Panel_buff_tip, 'Label_buff_desc')
    self.Label_buff_cnt = TFDirector:getChildByPath(self.Panel_buff_tip, 'Label_buff_cnt')

    --hiddenBoss
    self.Image_hiddenBoss = TFDirector:getChildByPath(self.Panel_UI, 'Image_hiddenBoss')
    self.Label_boss_name = TFDirector:getChildByPath(self.Panel_UI, 'Label_boss_name')
    self.Label_blood_tip = TFDirector:getChildByPath(self.Panel_UI, 'Label_blood_tip')
    self.Label_blood_tip:setText("剩余血量")
    self.Label_blood = TFDirector:getChildByPath(self.Panel_UI, 'Label_blood')
    self.LoadingBar_boss_blood = TFDirector:getChildByPath(self.Panel_UI, 'LoadingBar_boss_blood')
    self.Image_head = TFDirector:getChildByPath(self.Panel_UI, 'Image_head')

    --hiddenTip
    self.Image_hiddenTip = TFDirector:getChildByPath(self.Panel_UI, 'Image_hiddenTip'):hide()
    self.Label_hiddenTip = TFDirector:getChildByPath(self.Image_hiddenTip, 'Label_hiddenTip')

    local msg = {
        self.mapId
    }    
    TFDirector:send(c2s.QLIPHOTH_PARTICLE_WORLD_INFO, msg) 
    self.Panel_UI:setVisible(false)
end

function KabalaTreeExploreView:playFirstCg()

    local firstPlot = KabalaTreeDataMgr:getFirstPlot()
    if firstPlot and firstPlot > 0 then
        local function callback()
            KabalaTreeDataMgr:playStory(1,firstPlot,function ()
                KabalaTreeDataMgr:setFirstPlot()
                self:checkOverFight()
                EventMgr:dispatchEvent(EV_CG_END)
            end)
        end
        KabalaTreeDataMgr:openCgView("kabalaTree.KabalaTreeCg",callback) 
    else
        self:checkOverFight()
    end

end

function KabalaTreeExploreView:checkOverFight()

    local winFight = KabalaTreeDataMgr:getFightResult()
    if not winFight then

        local failedPlotId = KabalaTreeDataMgr:getFailedPlotId()
        if failedPlotId and failedPlotId > 0 then
            local function callback()
                KabalaTreeDataMgr:playStory(1,failedPlotId,function ()
                    KabalaTreeDataMgr:overKabalaFight(true)
                    EventMgr:dispatchEvent(EV_CG_END)
                    self.preMovie = false
                end)
            end
            KabalaTreeDataMgr:openCgView("kabalaTree.KabalaTreeCg",callback) 
        end
    else
        local isComplete =  KabalaTreeDataMgr:isFinishStageTask()
        if isComplete then
            Utils:showTips(3005020)
            Utils:playSound(2003)
            KabalaTreeDataMgr:setFinishStageTask()
            local stepPlot = KabalaTreeDataMgr:getStepPlot()
            if stepPlot and stepPlot > 0 then
                self:timeOut(function()
                    local function callback()
                        KabalaTreeDataMgr:playStory(1,stepPlot,function ()
                            KabalaTreeDataMgr:setStepPlot()
                            KabalaTreeDataMgr:showTaskAward()
                            EventMgr:dispatchEvent(EV_CG_END)
                            self:checkNewTiled()
                        end)
                    end
                    KabalaTreeDataMgr:openCgView("kabalaTree.KabalaTreeCg",callback) 
                end,1.5)
            else
                KabalaTreeDataMgr:showTaskAward()
                self:checkNewTiled()
            end
        else
            local isFinishBossTask = KabalaTreeDataMgr:isFinishBossTask()
            local finalPlot = KabalaTreeDataMgr:getFinalPlot()
            if isFinishBossTask and finalPlot ~= 0 then
                Utils:playSound(2003)
                self:timeOut(function()

                    --[[local kabalaTreeAwardInst = KabalaTreeDataMgr:getKabalaTreeAwardInst()
                    if kabalaTreeAwardInst then
                        KabalaTreeDataMgr:setKabalaTreeAwardInst(nil)
                        AlertManager:closeLayer(kabalaTreeAwardInst)
                    end]]
                    local function callback()
                        KabalaTreeDataMgr:playStory(1,finalPlot,function ()
                            KabalaTreeDataMgr:setBosstaskState(false)
                            self:checkNewTiled()
                            EventMgr:dispatchEvent(EV_CG_END,function()
                                self.Image_task_bg:setVisible(false)
                                self.Image_radar:setVisible(false)
                                KabalaTreeDataMgr:showTaskAward()
                            end)
                        end)
                    end
                    KabalaTreeDataMgr:openCgView("kabalaTree.KabalaTreeCg",callback)
                end,1)
            else
                KabalaTreeDataMgr:showTaskAward()
                self:checkNewTiled()
            end
        end
    end
end

--判断是否有新格子(原则上只有占领据点后重入场景会触发)
function KabalaTreeExploreView:checkNewTiled()
    
    local newOpenTitled = KabalaTreeDataMgr:getNewOpenTitled()
    if not newOpenTitled then
        self.preMovie = false
        return
    end
    
    local strongholdPosMN = KabalaTreeDataMgr:getStronghold()
    if strongholdPosMN then
        local itemRes = "ui/kabalatree/event/floor_spot_2.png"
        self.KabalaTreeItem:updateItem(strongholdPosMN,EC_EventLayerGid.Tile_Blue,itemRes)

        --播放格子动画
        local position = KabalaTreeDataMgr:convertToPos(strongholdPosMN.x,strongholdPosMN.y)
        position =  KabalaTreeDataMgr:convertToPosAR(position.x,position.y)
        self.Spine_occupy:play("animation",false)
        self.Spine_occupy:setScale(1.3)
        self.Spine_occupy:setPosition(ccp(position.x,position.y-8))
    end
    KabalaTreeDataMgr:clearStronghold()

    self.aroundTile = newOpenTitled
    self.aroundIndex = 1
    self:spawnAroundTile(0.5,function ()
        self.preMovie = false
    end)

end

function KabalaTreeExploreView:generateTiledMap()
    
    KabalaTreeDataMgr:setRandomFightFlag(flag)
    
    self.tileMap = self.KabalaTreeGridMap:generateMap(self.mapId,self.playerPos,self.mapScale)
    if self.tileMap then
        self.tileMap:setName("map")        
        self.Panel_root:addChild(self.tileMap)
    end
end

--初始地图道具(进入地图显示)
function KabalaTreeExploreView:initMapItem()

    local itemTab = {}
    self.KabalaTreeItem:initItem(self.Image_random,itemTab)
end

--创建npc
function KabalaTreeExploreView:createNpc()

    if not self.tileMap then
        return
    end
    
    self.playerPos = KabalaTreeDataMgr:getBirthPostion()
    self.Panel_player = self.Panel_ship:clone()
    KabalaTreeDataMgr:setKabalaTreeNpc(self.KabalaTreeNpc)
    self.tileMap:addChild(self.Panel_player)
    self.KabalaTreeNpc:initPlayerInfo(self.Panel_player,self.playerPos,self.playerModeScale)
    
    return true

end

--创建迷你地图
function KabalaTreeExploreView:createMiniMap()
    self.KabalaTreeMiniMap:initData(self.Panel_miniMap,self.MiniPlayer:clone(),self.Image_random)
    self.KabalaTreeMiniMap:createMiniMap(self.mapId)

    if self.playerPos then
        self.KabalaTreeMiniMap:locationMiniMap(self.playerPos,true)
        self.KabalaTreeMiniMap:setPlayerPosition(self.playerPos)
    end
end

--刷新迷你地图
function KabalaTreeExploreView:updateMiniMap()

end

function KabalaTreeExploreView:initMapPrefab()

    self.Spine_click = self.Spine_clickPrefab:clone()
    self.Spine_click:play("ALL",true)
    self.Spine_click:setZOrder(3)
    self.tileMap:addChild(self.Spine_click)

    self.Spine_occupy = self.Spine_occupyPrefab:clone()
    self.Spine_occupy:setZOrder(0)
    self.tileMap:addChild(self.Spine_occupy)

end

function KabalaTreeExploreView:touchBegin(touch,touchPos)

    if not self.tileMap then
        return
    end
    self.mapTouchBeginPos = touchPos
end

function KabalaTreeExploreView:touchMoved(touch,touchPos)

    if not self.tileMap then
        return
    end

    self.mapContainerPrePos = self.mapContainerPos
    self.mapContainerPos = touchPos
    if self.mapContainerPos and self.mapContainerPrePos then

        local palyerState = self.KabalaTreeNpc:getPlayerState()
        if palyerState == "moving" then
            return
        end

        self.mapContainerDiffPos = ccp(self.mapContainerPos.x - self.mapContainerPrePos.x, self.mapContainerPos.y - self.mapContainerPrePos.y)
        local targetPos = me.pAdd(ccp(self.tileMap:getPositionX(),self.tileMap:getPositionY()),self.mapContainerDiffPos)        
        KabalaTreeDataMgr:detectEdges(targetPos)        
        self.tileMap:setPosition(targetPos)

        self:pointPlayerLocation()
    end 
end

function KabalaTreeExploreView:touchEnd(touch,touchPos)

    self.mapContainerPrePos = nil
    self.mapContainerPos = nil
    self.mapContainerDiffPos = nil

    if not self.tileMap or not self.mapTouchBeginPos then
        return
    end

    local touchEndPos = touchPos
    local dis = me.pGetDistance(self.mapTouchBeginPos,touchEndPos)
    if dis < self.minTouchMoveDis then
        Utils:playSound(2001)
        self:clickTiled(touchPos)
    end
end

--指出飞船位置
function KabalaTreeExploreView:pointPlayerLocation()

    local posMN = self.KabalaTreeNpc:getPositiontMN()
    if not posMN then
        self.Panel_pointDirection:setVisible(false)
        return
    end

    local inScreen,shipWorldPos = KabalaTreeDataMgr:checkInScreen(posMN)
    self.Panel_pointDirection:setVisible(not inScreen)
    if inScreen then
        return
    end
    --local shipWorldPos = KabalaTreeDataMgr:getWorldPostion(posMN)
    dump(shipWorldPos)
    local directionImgPos = self.Image_direction:getPosition()
    local imgWorldPos = self.Panel_pointDirection:convertToWorldSpaceAR(directionImgPos)
    local rotationVaule = 0
    if shipWorldPos.y-imgWorldPos.y > 0  then
        local tanValue = (shipWorldPos.x - imgWorldPos.x)/(shipWorldPos.y-imgWorldPos.y)
        rotationVaule = math.deg(math.atan(tanValue))
    elseif shipWorldPos.y-imgWorldPos.y < 0  then
        local tanValue = (shipWorldPos.x - imgWorldPos.x)/(shipWorldPos.y-imgWorldPos.y)
        rotationVaule = math.deg(math.atan(tanValue))
        rotationVaule = rotationVaule + 180
    end
    self.Image_direction:setRotation(rotationVaule+225)
end

--[[function KabalaTreeExploreView:scaleMap(scale)

    if scale >0 and self.mapScale >= self.maxScale then
        return
    end

    if scale <0 and self.mapScale <= self.minScale then
        return
    end

    scale = scale or 0
    self.mapScale = self.mapScale + scale
    self.mapScale = clamp(self.mapScale, self.minScale, self.maxScale)
    KabalaTreeDataMgr:setMapScale(self.mapScale)
    KabalaTreeDataMgr:setGridMapLimit()
    
    --定位
    local posMN = self.KabalaTreeNpc:getPositiontMN()
    local targetPosition = KabalaTreeDataMgr:convertToPos(posMN.x,posMN.y)
    print("targetPosition",targetPosition.x,targetPosition.y)
    local mapPosX, mapPosY = self:getMapContaierPos(targetPosition)
    local position = KabalaTreeDataMgr:detectEdges(ccp(mapPosX,mapPosY)) 
    self.tileMap:setPosition(position)
end]]

function KabalaTreeExploreView:scaleMap(scale,center,centerMN)

    if scale >0 and self.mapScale >= self.maxScale then
        return
    end

    if scale <0 and self.mapScale <= self.minScale then
        return
    end

    scale = scale or 0
    self.mapScale = self.mapScale + scale
    self.mapScale = clamp(self.mapScale, self.minScale, self.maxScale)

    KabalaTreeDataMgr:setMapScale(self.mapScale)
    KabalaTreeDataMgr:setGridMapLimit()
    if not centerMN then
        centerMN = self.KabalaTreeNpc:getPositiontMN()
    end

    local targetPosition = KabalaTreeDataMgr:convertToPos(centerMN.x,centerMN.y)
    local mapPosX, mapPosY = self:getMapContaierPos(targetPosition)
    local position = KabalaTreeDataMgr:detectEdges(ccp(mapPosX,mapPosY))
    self.tileMap:setPosition(position)
end

function KabalaTreeExploreView:clickTiled(touchPos)

    if self.preMovie then
        return
    end

    local flag = self.KabalaTreeNpc:getClickSearchFlage()
    if flag then
        return
    end

    local point = me.p(self.tileMap:convertToNodeSpace(touchPos))
    local posM,posN = KabalaTreeDataMgr:convertToMN(point.x,point.y)
    local curPosMN = self.KabalaTreeNpc:getPositiontMN()
    if not curPosMN then
        return
    end

    local isExist = KabalaTreeDataMgr:existInMap(ccp(posM,posN))
    if not isExist then
        return
    end

    local layer = self.tileMap:getLayer("Plain")
    local gid = layer:getTileGIDAt(ccp(posM,posN))    
    local isNil = KabalaTreeDataMgr:isNilTiled(ccp(posM,posN))
    if isNil then
        return
    end

    local opacity = KabalaTreeDataMgr:getOpacity(ccp(posM,posN))
    if opacity == 0 then
        return
    end

    if curPosMN.x == posM and curPosMN.y == posN then
        return
    end

    local fallRandomFight = KabalaTreeDataMgr:getRandomFightFlag()
    if fallRandomFight then
        return
    end

    --[[取消打完BOSS不能进世界的限制
    local isFinishBossTask = KabalaTreeDataMgr:isFinishBossTask()
    if isFinishBossTask then
       Utils:showTips(3005021)
        return
    end]]

    if not self.locationEnd then
        return
    end
    print("clickMN",posM,posN)
    --有一些判断(是否存在怪物,建筑,道具,是否是障碍物)   
    local palyerState = self.KabalaTreeNpc:getPlayerState()
    if palyerState ~= "moving" then

        local inScreen = KabalaTreeDataMgr:checkInScreen(curPosMN)
        if not inScreen then
            self.locationEnd = false
            self:locationPlayer(false,function()
                self.locationEnd = true
                self:findPath(curPosMN,ccp(posM,posN))
            end)
        else
            self:findPath(curPosMN,ccp(posM,posN))
        end
    else
        self.KabalaTreeNpc:stopMove(function()
            local curPosMN = self.KabalaTreeNpc:getPositiontMN()
            if not curPosMN then
                return
            end
            self:findPath(curPosMN,ccp(posM,posN))
        end)
        --
    end
end

function KabalaTreeExploreView:findPath(srcPos,desPos)

    --走完一格
    local function finishStep()
        self:playerFinishStep()
    end

    --到达目的地
    local function finishMove()
        self:playerFinishMove() 
    end

    self.KabalaAStarPath:initData(srcPos,desPos)
    local result = self.KabalaAStarPath:findAStarPath()
    if result then

        local path = self.KabalaAStarPath:getPath()
        self:paintPathDot(path)
        self.KabalaTreeNpc:startMove(path,finishMove,finishStep)

        self:paintDesSpine(desPos)
        
    else
        Utils:showTips(3005022);
    end  
end

--function KabalaTreeExploreView:

function KabalaTreeExploreView:getPathDotRes(thisPath,nextPath)

    if thisPath.x > nextPath.x then
        return "ui/kabalatree/left_up.png"
    elseif thisPath.x < nextPath.x then
        return "ui/kabalatree/right_down.png"
    elseif thisPath.y < nextPath.y then
        return "ui/kabalatree/left_down.png"
    elseif thisPath.y > nextPath.y then
        return "ui/kabalatree/right_up.png"
    end

end

--显示目标点箭头
function KabalaTreeExploreView:paintDesSpine(desPos)

    local kabalaItem = KabalaTreeDataMgr:getKabalaTreeItem(desPos)
    if kabalaItem then
        return
    end

    local position = KabalaTreeDataMgr:convertToPos(desPos.x,desPos.y)
    position =  KabalaTreeDataMgr:convertToPosAR(position.x,position.y)
    self.Spine_click:setVisible(true)
    self.Spine_click:setPosition(ccp(position.x-10,position.y-8))
    
end

--绘制路径点
function KabalaTreeExploreView:paintPathDot(path)    

    for i=1,#path do
        self.pathDot[i] = self.Image_pathdot:clone()
        local thisPathDot = path[i]
        local nextPathDot = path[i+1]
        if nextPathDot then
          self.pathRes = self:getPathDotRes(thisPathDot,nextPathDot)
          self.pathDot[i]:setTexture(self.pathRes)
        else
            --终点表现
            self.pathDot[i]:setTexture(self.pathRes)
        end
        local position = KabalaTreeDataMgr:convertToPos(thisPathDot.x,thisPathDot.y)
        position =  KabalaTreeDataMgr:convertToPosAR(position.x,position.y)
        self.pathDot[i]:setPosition(ccp(position.x-15,position.y-50))
        self.pathDot[i]:setZOrder(0)
        self.tileMap:addChild(self.pathDot[i])
    end
end

function KabalaTreeExploreView:playerFinishStep()
    self:checkRadar()
    self:followPlayer()
end

function KabalaTreeExploreView:followPlayer()

    local posMN = self.KabalaTreeNpc:getPositiontMN()
    local targetPosition = KabalaTreeDataMgr:convertToPos(posMN.x,posMN.y)
    local mapPosX, mapPosY = self:getMapContaierPos(targetPosition)
    local position = KabalaTreeDataMgr:detectEdges(ccp(mapPosX,mapPosY)) 
    self.tileMap:runAction(MoveTo:create(0.5,position))
end

function KabalaTreeExploreView:checkRadar()

    self.playRadarSound = false
    if not self.searchTask then
        self:setRadarParam(self.normalMax,self.normalUpdateTime)
        return
    end

    if not next(self.searchTask) then
        self:setRadarParam(self.normalMax,self.normalUpdateTime)
        return
    end

    --检测到搜索区域的距离
    local searchZone = {}
    for k,taskId in pairs(self.searchTask) do
        local taskInfo = KabalaTreeDataMgr:getTaskInfo(taskId)
        if taskInfo then
           local zone = KabalaTreeDataMgr:getSearchZone(taskInfo.eventID) 
           if zone then
                for i,pos in ipairs(zone) do
                    table.insert(searchZone,pos)
                end
           end
        end
    end
    
    if not next(searchZone) then
        self:setRadarParam(self.normalMax,self.normalUpdateTime)
        return
    end

    self.playRadarSound = true
    local minDis = math.huge
    local posMN = self.KabalaTreeNpc:getPositiontMN()
    for k,v in pairs(searchZone) do
        local dis = KabalaTreeDataMgr:calcValueDis(v,posMN)
        if dis < minDis then
            minDis = dis
        end
    end

    local maxCnt,updateTime = self.normalMax,self.normalUpdateTime
    for i=#self.discreteData,1,-1 do
        if minDis <= self.discreteData[i].dis then
            maxCnt = self.discreteData[i].max
            updateTime = self.discreteData[i].updateTime
            break
        end
    end

    local min = self.discreteData[#self.discreteData].dis
    if minDis <= min then
        self.KabalaTreeNpc:setRadarFlagVisible(true)
    else
        --self.Hz = 6
        self.KabalaTreeNpc:setRadarFlagVisible(false)
    end
    self:setRadarParam(maxCnt,updateTime)
end

--移动到目的地
function KabalaTreeExploreView:playerFinishMove()

    --到达目的地产生格子
    local posMN = self.KabalaTreeNpc:getPositiontMN()
    self:clearPathDot()
end

--清除路径点
function KabalaTreeExploreView:clearPathDot()

    for k,v in pairs(self.pathDot) do
        v:runAction(Sequence:create({
            FadeOut:create(0.5),
            CallFunc:create(function ()
                v:removeFromParent()
            end)
        }))
    end
    self.pathDot = {}
    if self.Spine_click then
        self.Spine_click:setVisible(false)
    end

end

--格子上的资源模型
function KabalaTreeExploreView:spawnEventObject(tilePosMN)

    local eventId,eventValid = KabalaTreeDataMgr:getEventId(tilePosMN)
    if not eventId then
        return
    end

    local eventType,eventRes,smallRes,offset,scaleInMap = KabalaTreeDataMgr:getTileEventRes(eventId,eventValid)
    if not eventType or not eventRes or not offset or not scaleInMap or not smallRes then
        return
    end

    self.KabalaTreeItem:spawnNewItem(tilePosMN,eventRes,smallRes,offset,scaleInMap)
    self.KabalaTreeMiniMap:spawnNewItem(tilePosMN,smallRes,offset,scaleInMap)
end

function KabalaTreeExploreView:startSpawnTileByServer(targetPos,newTitled)
    if not newTitled then
        return
    end

    local newOpenTitled = {}
    local foundPoints = {}
    for k,v in pairs(newTitled) do
        local pos = v.x.."-"..v.y
        foundPoints[pos] = ccp(v.x,v.y)
    end

    local x,y = targetPos.x,targetPos.y
    local around = {}
    for i = -3,3 do
        for j = -3,3 do
            if i ~= 0 or j ~= 0 then
                local posX,posY = x+i,y+j
                local pos = posX.."-"..posY
                if foundPoints[pos] then
                    table.insert(self.aroundTile,ccp(posX,posY))
                end
            end
        end
    end

    self:spawnAroundTile()
end

--产生格子
function KabalaTreeExploreView:startSpawnTile(posM,posN)

    if not self.tileMap then--or self.spawningTile then
        return
    end

    --判断是否够能量
    local curEnergy = KabalaTreeDataMgr:getEnergy()
    local spawnCost = KabalaTreeDataMgr:getTileCost()
    if curEnergy < spawnCost then
        return
    end

    self.aroundTile = KabalaTreeDataMgr:getSpawnTiledAround(ccp(posM,posN))    
    self.aroundIndex = 1
    self:spawnAroundTile()
end

--产生周围的格子
function KabalaTreeExploreView:spawnAroundTile(spawnTime,callback)
    if not self.tileMap then
        return
    end
    self.spawningTile = true
    local curTile = self.aroundTile[1]
    if not curTile then
        self.spawningTile = false
        if callback then
            callback()
        end
        return
    end
    table.remove(self.aroundTile,1)
    local offsetY = 0
    local layer = self.tileMap:getLayer("Plain")
    local eventLayer = self.tileMap:getLayer("Event")
    local tiledGid = KabalaTreeDataMgr:getGroundLayerGid(EC_EventLayerGid.Tile_Normal)
    local eventId,eventValid = KabalaTreeDataMgr:getEventId(curTile)
    if eventId then
        tiledGid,isDelete = KabalaTreeDataMgr:getTileGIdByEventId(eventId,eventValid)
    end

    local eventGid = eventLayer:getTileGIDAt(ccp(curTile.x,curTile.y))
    if eventGid == 2 then
        tiledGid = layer:getTileGIDAt(ccp(curTile.x,curTile.y))
    end

    layer:setTileGID(tiledGid,curTile)

    self.KabalaTreeMiniMap:spawnNewTile(curTile)

    local tileImg = layer:getTileAt(ccp(curTile.x,curTile.y))
    local opacity = tileImg:getOpacity()
    if opacity == 0 then
        offsetY = 80
    end
    spawnTime = spawnTime or 0.5
    local position = tileImg:getPosition()
    local spawnAction = Spawn:create({
        FadeIn:create(spawnTime),
        MoveTo:create(spawnTime,ccp(position.x,position.y+offsetY))
    })
    local seq = Sequence:create({
        spawnAction,
        CallFunc:create(function ()                
            self:spawnAroundTile(spawnTime,callback)
            if obstacleImg then
                obstacleImg:runAction(FadeIn:create(1))
            end
            self:spawnEventObject(curTile)
        end)
    })
    tileImg:runAction(seq)

    --障碍
    local obstacleLayer = self.tileMap:getLayer("Landform")
    if not obstacleLayer then
        return
    end
    
    if opacity ~= 0 then
        return
    end

    local obstacleImg = obstacleLayer:getTileAt(ccp(curTile.x,curTile.y))
    if obstacleImg then
        local offsetX,offsetY = KabalaTreeDataMgr:getObstacleOffset()
        local position = obstacleImg:getPosition()
        local spawnAction = Spawn:create({
            FadeIn:create(0.5),
            MoveTo:create(0.5,ccp(position.x+offsetX,position.y+offsetY))
        })
        obstacleImg:runAction(spawnAction)
    end

end

--定位
function KabalaTreeExploreView:locationPlayer(isInit,callback)

    if not self.tileMap then
        return
    end

    self.tileMap:setOpacity(0)
    local posMN = self.KabalaTreeNpc:getPositiontMN()
    if not posMN then
        return
    end

    local targetPosition = KabalaTreeDataMgr:convertToPos(posMN.x,posMN.y)
    local mapPosX, mapPosY = self:getMapContaierPos(targetPosition)
    local position = KabalaTreeDataMgr:detectEdges(ccp(mapPosX,mapPosY)) 

    local sact
    if isInit then
        self.tileMap:setPosition(position)
        sact = FadeIn:create(0.5)
    else
        sact =  Spawn:create({
            FadeIn:create(0.5),
            MoveTo:create(0.5,position)
        })
    end
    local sequence = Sequence:create({
        sact,
        CallFunc:create(function ()
            local inScreen = KabalaTreeDataMgr:checkInScreen(posMN)
            self.Panel_pointDirection:setVisible(not inScreen)
            if callback then
                callback()
            end
        end)
    })
    self.tileMap:runAction(sequence)        
end

function KabalaTreeExploreView:getMapContaierPos(playerPos)

    local tileXCount,tileYCount = KabalaTreeDataMgr:getTileXYCount()
    local tileWidth,tileHeight  = KabalaTreeDataMgr:getTileSize()

    local mappos = self.tileMap:getPosition() 
    local mapPosX = (tileXCount*tileWidth/2 - playerPos.x)*self.mapScale
    local mapPosY = (tileYCount*tileHeight/2 - playerPos.y)*self.mapScale
    return mapPosX, mapPosY
end

--**********************************UI***************************************

function KabalaTreeExploreView:stopSchedule()
    if self._scheduleId then
        TFDirector:removeTimer(self._scheduleId)
        self._scheduleId = nil
    end
end

function KabalaTreeExploreView:removeEvents()
    self:stopSchedule()
end

function KabalaTreeExploreView:onCountDownPer()

    if not self.timer then
        return
    end

    self.timer = self.timer + 1
    if self.timer >= self.radarUpdateTime then
        self.Panel_UI:stopAllActions()
        self:spwanRadarCircle()
        self.timer = 0
    end
end

function KabalaTreeExploreView:setRadarParam(maxCnt,updateTimes)

    if updateTimes then
        updateTimes = updateTimes/1000
    end
    self.radarUpdateTime = updateTimes or self.radarUpdateTime
    self.maxRadarNum = maxCnt or self.maxRadarNum

end

function KabalaTreeExploreView:spwanRadarCircle()

    self.cirleNum = 0
    local sequence = Sequence:create({
        CCDelayTime:create(self.radarDelayTime),
        CallFunc:create(function ()
            self.cirleNum = self.cirleNum + 1
            if self.cirleNum <= self.maxRadarNum then
                self:updateRadarCircle()
                if self.cirleNum == 1 then
                    self:updateRadarDot()
                    local flag = KabalaTreeDataMgr:getFightViewFlag()
                    if not flag and self.playRadarSound then
                        Utils:playSound(2004)
                    end
                end
            end
        end)
    })
    local action = CCRepeatForever:create(sequence)
    self.Panel_UI:runAction(action)
end

function KabalaTreeExploreView:updateRadarCircle()

    local radarCircle = self.radarCircle:clone()
    self.Image_radar:addChild(radarCircle)
    local sequence = Sequence:create({
        Spawn:create({
            ScaleTo:create(self.spreadSpeed,1.1),
            FadeOut:create(self.spreadSpeed+0.5),
        }),
        CallFunc:create(function ()
            radarCircle:removeFromParent()
        end)
    })
    radarCircle:runAction(sequence)
end

function KabalaTreeExploreView:updateRadarDot()

    local maxDot = self.maxRadarNum*2
    if maxDot > 10 then
        maxDot = 10
    end
    self.actionDot = {}
    for i=1,10 do
        if i <= maxDot then
            local dotId = math.random(1, 10)
            if (not self.actionDot[dotId]) and self.radarDot[dotId] then
                self.radarDot[dotId]:stopAllActions()
                self.radarDot[dotId]:setOpacity(255)
                self.actionDot[dotId] = true
                local sequence = Sequence:create({
                    Blink:create(self.spreadSpeed,2),
                    FadeOut:create(0.5),
                    CallFunc:create(function ()
                        self.actionDot[dotId] = false
                    end)
                    })
                self.radarDot[dotId]:runAction(sequence)
            end
        end  
    end
end

function KabalaTreeExploreView:uiLogic()


    self:onUpdateTeamInfo()
    self:onUpdateTaskInfo()
    self:onUpdateResourceInfo()
    self:onUpdateBuffInfo()
    self:showHiddenEventInfo()

    --得到规避遇敌的状态
    local value = KabalaTreeDataMgr:getSkipRandomMonsterFlag()
    self:updateSkipRandom(value)

    --雷达
    self:spwanRadarCircle()
    self._scheduleId   = TFDirector:addTimer(1000, -1, nil, handler(self.onCountDownPer, self))

    --滑动
    self:initTouchEvents()

    --发现任务标识
    local taskPos = KabalaTreeDataMgr:getDiscoverTaskPos()
    if taskPos then
        self.Spine_discoverTask:setVisible(true)
    else
        self.Spine_discoverTask:setVisible(false)
    end
end

function KabalaTreeExploreView:initTouchEvents()

    self.isMulTouch = false
    self.centerPosMN = nil
    self.touch1 = nil
    self.touch2 = nil
    self.lastDis = 0
    self.touchNode:OnBegan(function(sender, pos)
        self.touch1 = pos
        self:touchBegin(self.touch1,pos)
        if self.touchNode2  == nil then
            self.touchNode2 = CCNode:create()
            self.touchNode2:setSize(me.winSize)
            self.Panel_treeExploreMap:addChild(self.touchNode2)
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
                    local point = me.p(self.tileMap:convertToNodeSpace(center))
                    local posM,posN = KabalaTreeDataMgr:convertToMN(point.x,point.y)
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

function KabalaTreeExploreView:setMulSwallowTouch(flag)
    if flag then
        self.touchNode:setTouchEnabled(true)
        self.touchNode:setSwallowTouch(true)
    else
        self.touchNode:setTouchEnabled(true)
        self.touchNode:setSwallowTouch(false)
    end
end

--刷新规避遇敌状态
function KabalaTreeExploreView:updateSkipRandom(id)
    
    
    if id == 1 then
        self.skipRandomBtn:setTextureNormal("ui/kabalatree/skip1.png")
    else
        self.skipRandomBtn:setTextureNormal("ui/kabalatree/skip2.png")
    end

    KabalaTreeDataMgr:setSkipRandomMonsterFlag(id)
end

--阵容界面
function KabalaTreeExploreView:onUpdateTeamInfo()
    
    local formation = KabalaTreeDataMgr:getFormation()
    local leaderId = HeroDataMgr:getTeamLeaderId()
    for i = 1, 3 do
        local heroId = formation[i]
        if heroId then
            local headIconRes = HeroDataMgr:getIconPathById(heroId)
            self.teamInfo[i].headbg:setVisible(true)
            self.teamInfo[i].headImg:setVisible(true)
            self.teamInfo[i].headImg:setTexture(headIconRes)             
            local isCapitan = i == 1
            self.teamInfo[i].memberflag:setVisible(isCapitan)
            self.teamInfo[i].Image_add:setVisible(false)
            local isEffectHero = KabalaTreeDataMgr:isEffectHero(heroId)
            self.teamInfo[i].stateTx:setVisible(false)
            self.teamInfo[i].stateImage:setVisible(isEffectHero)
            self.teamInfo[i].barbg:setVisible(true)

            local infectionValue,maxValue = KabalaTreeDataMgr:getInfectionsByHeroId(heroId)
            local percent = (infectionValue/maxValue)*100
            self.teamInfo[i].effectbar:setPercent(percent)
        else
            self.teamInfo[i].headbg:setVisible(false)
            self.teamInfo[i].headImg:setVisible(false)
            self.teamInfo[i].memberflag:setVisible(false)
            self.teamInfo[i].Image_add:setVisible(true)
            self.teamInfo[i].stateTx:setVisible(false)
            self.teamInfo[i].stateImage:setVisible(false)
            self.teamInfo[i].barbg:setVisible(false)
        end
    end
end

--任务列表
function KabalaTreeExploreView:onUpdateTaskInfo(isCompete,plotId)

    self.Image_task_bg:setVisible(true)
    self.Image_radar:setVisible(true)
    local missions = KabalaTreeDataMgr:getMapMission()
    if not next(missions) then
        self.Image_task_bg:setVisible(false)
        self.Image_radar:setVisible(false)
        return
    end

    --完成阶段任务
    if isCompete then
        Utils:showTips(3005020)
        Utils:playSound(2003)
        KabalaTreeDataMgr:setFinishStageTask()
        if plotId and plotId > 0 then
            self.preMovie = true
            self:timeOut(function()
                local function callback()
                    KabalaTreeDataMgr:playStory(1,plotId,function()
                        KabalaTreeDataMgr:setStepPlot()
                        local kabalaTreeAwardInst = KabalaTreeDataMgr:getKabalaTreeAwardInst()
                        if kabalaTreeAwardInst then
                            KabalaTreeDataMgr:setKabalaTreeAwardInst(nil)
                            AlertManager:closeLayer(kabalaTreeAwardInst)
                        else
                            local eventPoints = KabalaTreeDataMgr:getHiddenEventPoints()
                            if eventPoints then
                                EventMgr:dispatchEvent(EV_PLAY_HIDDENEVENT_EFFECT)
                            end
                        end
                        self.preMovie = false
                        EventMgr:dispatchEvent(EV_CG_END)
                    end)
                end
                KabalaTreeDataMgr:openCgView("kabalaTree.KabalaTreeCg",callback) 
            end,1.5)
        else
            KabalaTreeDataMgr:setStepPlot()
            local kabalaTreeAwardInst = KabalaTreeDataMgr:getKabalaTreeAwardInst()
            if kabalaTreeAwardInst then
                KabalaTreeDataMgr:setKabalaTreeAwardInst(nil)
                AlertManager:closeLayer(kabalaTreeAwardInst)
            else
                local eventPoints = KabalaTreeDataMgr:getHiddenEventPoints()
                if eventPoints then
                    EventMgr:dispatchEvent(EV_PLAY_HIDDENEVENT_EFFECT)
                end
            end
        end
    end

    local isBoss = KabalaTreeDataMgr:isBossTask(missions[1].missionId)
    if isBoss and missions[1].progress == 1 then
        self.Image_task_bg:setVisible(false)
        self.Image_radar:setVisible(false)
    end

    local finalTaskDesc = KabalaTreeDataMgr:getFinalTaskDesc(missions[1].missionId)
    if finalTaskDesc then
        self.Label_task:setTextById(finalTaskDesc)
        return
    end
    if not isCompete then
        local eventPoints = KabalaTreeDataMgr:getHiddenEventPoints()
        if eventPoints then
            EventMgr:dispatchEvent(EV_PLAY_HIDDENEVENT_EFFECT)
        end
    end

    local taskStageId,taskType = KabalaTreeDataMgr:getMissionStage(missions[1].missionId)
    if not taskStageId or not taskType then
        return
    end

    local taskStageDesc = KabalaTreeDataMgr:getTaskStageDesc(taskStageId)
    if not taskStageDesc then
        return
    end

    local taskDescId,taskDescType = taskStageDesc[1],taskStageDesc[2]
    if not taskDescId or not taskDescType then
        return
    end

    local finishCnt = 0
    local taskCnt = 0
    local monsterFinshCnt = {}
    local monsterTaskCnt = {}
    local monsterNameId = {}
    local monsteCnt = 0
    self.searchTask = {}

    for k,v in ipairs(missions) do
        --显示方式找策划对
        self.nameTextId,targetNum,isSearchTask = KabalaTreeDataMgr:getTaskTargetInfo(v.missionId) 
        if taskType == 1001 or taskType == 1004 then
            finishCnt = finishCnt + v.progress
            taskCnt = taskCnt + targetNum
        elseif taskType == 1003 then
            local taskInfo = KabalaTreeDataMgr:getTaskInfo(v.missionId)
            if taskInfo then
                local monsterId = taskInfo.checkParam[2]
                if not monsterFinshCnt[monsterId] then
                    monsterFinshCnt[monsterId] = 0
                    monsteCnt = monsteCnt + 1
                end
                monsterFinshCnt[monsterId] =  monsterFinshCnt[monsterId] + v.progress

                if not monsterTaskCnt[monsterId] then
                    monsterTaskCnt[monsterId] = 0
                end
                monsterTaskCnt[monsterId] =  monsterTaskCnt[monsterId] + targetNum
                monsterNameId[monsterId] = self.nameTextId
            end
        else
            finishCnt = v.progress
            taskCnt = targetNum
        end
        
        if isSearchTask == true and  v.progress == 0 then
            table.insert(self.searchTask,v.missionId)
        end
    end

    local taskStr = TextDataMgr:getTextAttr(taskDescId).text
    if taskDescType == 1 then
        if taskType == 1003 then
            local str = "\n"
            local index = 1
            for k,v in pairs(monsterTaskCnt) do

                local nameStr = TextDataMgr:getText(monsterNameId[k])
                if monsteCnt == index then 
                    str = str..nameStr.."("..monsterFinshCnt[k].."/"..monsterTaskCnt[k]..")"
                    break
                else
                    str = str..nameStr.."("..monsterFinshCnt[k].."/"..monsterTaskCnt[k]..")\n"
                end 
                index = index + 1
            end
            taskStr = string.format(taskStr,str)
        else
            local nameStr = TextDataMgr:getText(self.nameTextId)
            taskStr = string.format(taskStr,nameStr).."("..finishCnt.."/"..taskCnt..")"
        end
    end
    self.Label_task:setText(taskStr)

    self:checkRadar()
end

function KabalaTreeExploreView:onUpdateResourceInfo()
    
    local energyValue = KabalaTreeDataMgr:getEnergy()
    local kabalaCoin =  KabalaTreeDataMgr:getKabalaCoin()
    for i=1,2 do
        local id =  self.materialId[i]
        local itemCfg = GoodsDataMgr:getItemCfg(id)
        if not itemCfg then
           self.material[i].bg:setVisible(false) 
        else

            local value = i == 1 and energyValue or kabalaCoin
            self.material[i].bg:setVisible(true)
            self.material[i].icon:setTexture(itemCfg.icon)
            self.material[i].count:setText(value)
        end
    end
end

function KabalaTreeExploreView:showHiddenEventInfo()

    self.Image_hiddenBoss:setVisible(false)
    local LevelId,bossPercent,maxBossBlood

    local initHiddentEvent = KabalaTreeDataMgr:getInitHiddenEvent()
    for eventId,percent in pairs(initHiddentEvent) do
        local eventType,eventRes,smallRes,offset,scaleInMap,targetTab = KabalaTreeDataMgr:getTileEventRes(eventId)
        if eventType == Enum_TriggerEventType.EventType_ConcealBoss then
            maxBossBlood = 100
            bossPercent = 0
            LevelId = targetTab[1]
            break
        end
    end

    local hideEvents = KabalaTreeDataMgr:getHiddenEventInfo()
    dump(hideEvents)
    for eventId,percent in pairs(hideEvents) do
        local eventType,eventRes,smallRes,offset,scaleInMap,targetTab = KabalaTreeDataMgr:getTileEventRes(eventId)
        if eventType == Enum_TriggerEventType.EventType_ConcealBoss then
            bossPercent = percent[1] or 0
            maxBossBlood = percent[2] or 100
            LevelId = targetTab[1]
            break
        end
    end

    if not LevelId or not bossPercent then
        return
    end

    local curBossBlood = maxBossBlood -bossPercent
    if curBossBlood <= 0 then
        return
    end
    self.Image_hiddenBoss:setVisible(true)

    local dungeonLevelCfg = TabDataMgr:getData("DungeonLevel")[LevelId]
    if not dungeonLevelCfg then
        return
    end

    local bossGroupId = dungeonLevelCfg.monsterGroupId
    if not bossGroupId then
        return
    end

    local monsterId = bossGroupId[1]
    if not monsterId then
        return
    end

    local monsterSectionCfg = TabDataMgr:getData("MonsterSection", monsterId)
    if monsterSectionCfg then
        local fixedMonster =  monsterSectionCfg.fixedMonster
        if fixedMonster[1] then
            monsterId = fixedMonster[1]
        end
    end

    local monserCfg = TabDataMgr:getData("Monster")[monsterId]
    if not monserCfg then
        return
    end

    self.Image_head:setTexture(monserCfg.fightIcon)
    self.Label_boss_name:setTextById(monserCfg.name)
    local pentcentOne = maxBossBlood/100
    if curBossBlood < pentcentOne then
        self.Label_blood:setText("1%")
        self.LoadingBar_boss_blood:setPercent(1)
    else
        local percent = math.floor(curBossBlood / maxBossBlood * 100)
        self.LoadingBar_boss_blood:setPercent(percent)
        self.Label_blood:setText(percent.."%")
    end
end

--buff
function KabalaTreeExploreView:onUpdateBuffInfo()

    local timesBuff = KabalaTreeDataMgr:getTimeBuffs()
    for i=1,3 do
        local buffInfo = timesBuff[i]
        if not buffInfo then
            self.buffInfo[i].Panel_buff:setVisible(false)
        else
            --kabalabuff表的id和item表的id必须一致
            local itemCfg = GoodsDataMgr:getItemCfg(buffInfo.itemId)
            if itemCfg then
                self.buffInfo[i].Panel_buff:setVisible(true)
                local frameImg = Enum_KabalaItemFrame[itemCfg.quality]
                if not frameImg then
                    frameImg = Enum_KabalaItemFrame[Enum_KabalaItemQuality.blue]
                end
                self.buffInfo[i].buffBtn:setTextureNormal(frameImg)
                self.buffInfo[i].buffIcon:setTexture(itemCfg.icon)
                self.buffInfo[i].buffNum:setText(buffInfo.itemNum)
            end
        end
    end
end

function KabalaTreeExploreView:showBuffTip(posIndex)

    if self.posIndex and self.posIndex == posIndex then
        self.Panel_buff_tip:setVisible(false)
        self.posIndex = nil
        return
    end

    local timesBuff = KabalaTreeDataMgr:getTimeBuffs()
    if not timesBuff then
        Box("no timesbuff")
        self.Panel_buff_tip:setVisible(false)
        self.posIndex = nil
        return
    end

    local buffInfo = timesBuff[posIndex]
    if not buffInfo then
        Box("no timesbuff posIndex: "..tostring(posIndex))
        self.Panel_buff_tip:setVisible(false)
        self.posIndex = nil
        return
    end

    local itemCfg = GoodsDataMgr:getItemCfg(buffInfo.itemId)
    if not itemCfg then
        Box("no buffCid " ..buffInfo.itemId .. " in itemCfg")
        self.Panel_buff_tip:setVisible(false)
        self.posIndex = nil
        return
    end

    self.posIndex = posIndex
    self.Panel_buff_tip:setVisible(true)
    local posX = self.buffInfo[posIndex].Panel_buff:getPositionX() + 123
    self.Panel_buff_tip:setPositionX(posX)

    self.Label_buff_name:setTextById(itemCfg.nameTextId)
    self.Label_buff_desc:setTextById(itemCfg.desTextId)
    local str = TextDataMgr:getText(3004043,buffInfo.itemNum)
    self.Label_buff_cnt:setText(str)

end

function KabalaTreeExploreView:onUpdateDiscoverTask(isAdd)

    if isAdd then
        local curPosMN = self.KabalaTreeNpc:getPositiontMN()
        if not curPosMN then
            return
        end
        Utils:openView("kabalaTree.KabalaTreeBigMiniMap",self.mapId,curPosMN)
    end
    self.Spine_discoverTask:setVisible(isAdd)
end

function KabalaTreeExploreView:onUpdateHiddenEvent()

    local hiddenEvent = KabalaTreeDataMgr:getHiddenEventInfo()
    if not hiddenEvent then
        return
    end

end

function KabalaTreeExploreView:onSpawnHiddenEvent()

    self:turnToHiddenTarget(1)
end

function KabalaTreeExploreView:turnToHiddenTarget(tagetId)

    local hiddenInfo = KabalaTreeDataMgr:getHiddenEventPointsByIndex(tagetId)
    if not hiddenInfo then
        KabalaTreeDataMgr:clearHiddenEventPoints()
        return
    end


    local eventCfg = KabalaTreeDataMgr:getEventCfg(hiddenInfo.event)
    if not eventCfg then
        return
    end

    local function callback()
        self:pointPlayerLocation()
        self:timeOut(function()
            self:turnToHiddenTarget(tagetId+1)
        end)
    end

    self.Image_hiddenTip:setVisible(true)
    self.Label_hiddenTip:setTextById(eventCfg.showText)

    if eventCfg.eventType == Enum_TriggerEventType.EventType_ConcealBoss then

        local skeletonNode = SkeletonAnimation:create("effect/battle_enemy/battle_enemy")
        local size =  me.EGLView:getDesignResolutionSize()
        if size.width > 1136 then
            skeletonNode:play("1386",0)
        else
            skeletonNode:play("1136",0)
        end
        skeletonNode:setAnchorPoint(ccp(0,0))
        self.Panel_treeExploreMap:addChild(skeletonNode, 1)
        skeletonNode:addMEListener(TFARMATURE_COMPLETE,function(_skeletonNode)
            _skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
            _skeletonNode:removeFromParent()
            local act = CCSequence:create({
                CCDelayTime:create(2),
                CCCallFunc:create(function()
                    self.Image_hiddenTip:setVisible(false)
                end)
            })
            self.Image_hiddenTip:runAction(act)
            self:followTarget(ccp(hiddenInfo.x,hiddenInfo.y),callback)
        end)
    else
        local act = CCSequence:create({
            CCDelayTime:create(2),
            CCCallFunc:create(function()
                self.Image_hiddenTip:setVisible(false)
            end)
        })
        self.Image_hiddenTip:runAction(act)
        self:followTarget(ccp(hiddenInfo.x,hiddenInfo.y),callback)
    end

end

function KabalaTreeExploreView:followTarget(target,callback)


    if not target then
        return
    end
    local targetPosition = KabalaTreeDataMgr:convertToPos(target.x,target.y)
    local mapPosX, mapPosY = self:getMapContaierPos(targetPosition)
    local position = KabalaTreeDataMgr:detectEdges(ccp(mapPosX,mapPosY))
    local act = Sequence:create({
        MoveTo:create(0.5,position),
        CallFunc:create(function ()
            if callback then
                callback()
            end
        end)
    })
    self.tileMap:runAction(act)
end

function KabalaTreeExploreView:onTriggerMiniGame(data)

    if not data then
        return
    end

    Utils:openView("kabalaTree.KabalaTreeGame",data)
end


function KabalaTreeExploreView:onOpenKabalaStore(newItem,nextTime )
    Utils:openView("kabalaTree.KabalaTreeStore" ,{newItem = newItem , nextTime = nextTime})
end

-------------------------------消息反馈----------------------------
function KabalaTreeExploreView:onGetWorldInfo(worldNameID)

    KabalaTreeDataMgr:setInWorldFage(true)
    self.Panel_UI:setVisible(true)
    self:generateTiledMap()
    self:createNpc()
    self:locationPlayer(true)
    self:initMapItem()
    self:initMapPrefab()
    self:createMiniMap()
    self:uiLogic()
    self.TextArea_title:setTextById(worldNameID)

    self.preMovie = true
    self:timeOut(function()
        self:playFirstCg()
    end,1.0)
end

--移动
function KabalaTreeExploreView:onPlayerMoveTo(targetPos,newTitled)

    if not targetPos then
        return
    end
    dump(targetPos)
    local curPos =  self.KabalaTreeNpc:getPositiontMN()
    if curPos and targetPos.x == curPos.x and targetPos.y == curPos.y then
        --避免随机传送被拉回(发送传送消息后接着是移动消息)
        self:clearPathDot()
        self.KabalaTreeNpc:setPalyerState("stand")
        return
    end

    local res = self.KabalaTreeNpc:MoveTo(targetPos)
    if not res then
        self:clearPathDot()
        self.KabalaTreeNpc:setPalyerState("stand")
        return
    end

    self:startSpawnTileByServer(targetPos,newTitled)
    self.KabalaTreeMiniMap:playerMove(targetPos)
end

--触发事件
function KabalaTreeExploreView:onRecvTriggerEvent(eventId,tiledPosMN)

    if not eventId then
        return
    end

    self:clearPathDot()
    local eventType,eventRes,smallRes,offset,scaleInMap,targetTab,targetText,oilCost,prePlot,isDelete = KabalaTreeDataMgr:getTileEventRes(eventId)
    if not eventType or not eventRes or not smallRes then
        return
    end

    
    --1-直接战斗，2-收集任务道具，3-占领据点，4-任务剧情，5-探索区域，6-拾取随机奖励，7-传送事件，8-商店事件
    if eventType == Enum_TriggerEventType.EventType_Fight  then

        KabalaTreeDataMgr:clearNewOpenTitled()
        KabalaTreeDataMgr:clearStronghold()
        local ambushId = targetTab[1]
        Utils:openView("kabalaTree.KabalaTreeFight",ambushId,oilCost)
        
    elseif eventType == Enum_TriggerEventType.EventType_CollectItem or eventType == Enum_TriggerEventType.EventType_RandomItem then
    elseif eventType == Enum_TriggerEventType.EventType_OccupyDot then
        local ambushId = targetTab[1]        
        Utils:openView("kabalaTree.KabalaTreeStrongPoint",ambushId,oilCost,eventRes)
    elseif eventType == Enum_TriggerEventType.EventType_TaskStory then
        self.preMovie = true
        local plotId = targetTab[1]
        if plotId and plotId > 0 then
            local function callback()
                KabalaTreeDataMgr:playStory(1,plotId,function()
                    local msg = {
                        tiledPosMN.x,
                        tiledPosMN.y,
                        eventId
                    }    
                    TFDirector:send(c2s.QLIPHOTH_PERFORM_EVENT, msg)
                    if isDelete then
                        self.KabalaTreeItem:cleanItem(tiledPosMN)
                        self.KabalaTreeMiniMap:cleanItem(tiledPosMN)
                        KabalaTreeDataMgr:updateStatisticsData(eventId)
                    end
                    self.preMovie = false
                    EventMgr:dispatchEvent(EV_CG_END)
                end)
            end
            KabalaTreeDataMgr:openCgView("kabalaTree.KabalaTreeCg",callback) 
        end
    elseif eventType == Enum_TriggerEventType.EventType_Search then  


    elseif eventType == Enum_TriggerEventType.EventType_Transport then   
        if #targetTab ~= 0 then
            self:timeOut(function()
                Utils:openView("kabalaTree.KabalaTreeTransport",targetTab,targetText)
            end,0.6)
        end
    elseif eventType == Enum_TriggerEventType.EventType_Store then        
        TFDirector:send(c2s.QLIPHOTH_SHOP_INFO, {})
    elseif eventType == Enum_TriggerEventType.EventType_ConcealBoss then
        dump(targetTab)
        Utils:openView("kabalaTree.KabalaTreeConcealBoss",eventId,oilCost,targetTab)
    end
end

--伏击事件
function KabalaTreeExploreView:onRecvRandomAttack(ambushId,costEnergy)

    Utils:playSound(402)
    KabalaTreeDataMgr:clearNewOpenTitled()
    KabalaTreeDataMgr:clearStronghold()
    self.KabalaTreeNpc:stopMove()
    local skeletonNode = SkeletonAnimation:create("effect/battle_enemy2/battle_enemy2")
    local size =  me.EGLView:getDesignResolutionSize()
    if size.width > 1136 then
        skeletonNode:play("1386",0)
    else
        skeletonNode:play("1136",0)
    end
    skeletonNode:setAnchorPoint(ccp(0,0))
    self.Panel_UI:addChild(skeletonNode, 1)
    skeletonNode:addMEListener(TFARMATURE_COMPLETE,function(_skeletonNode)
        _skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
        _skeletonNode:removeFromParent()
        Utils:openView("kabalaTree.KabalaTreeFightConfirm",1,ambushId,costEnergy) 
    end)
end

--传送
function KabalaTreeExploreView:onRecvTransport(targetPosMN,newTitled)
    dump(targetPosMN)
    local layer = self.tileMap:getLayer("Plain")
    local tileImg = layer:getTileAt(targetPosMN)
    local opacity = tileImg:getOpacity()
    if opacity == 0 then
        local position = tileImg:getPosition()
        tileImg:setPositionY(position.y+80)
        tileImg:runAction(FadeIn:create(0.5))
        self.KabalaTreeMiniMap:spawnNewTile(targetPosMN)
    end

    local inScreen = KabalaTreeDataMgr:checkInScreen(targetPosMN)
    self.KabalaTreeNpc:transfor(targetPosMN,function()        
        local afterPos = self:getKabalaTreeMapPos(targetPosMN)
        if not inScreen then
            self:locationPlayer(false,function()
                self.KabalaTreeMiniMap:locationMiniMap(targetPosMN,true)
                self.KabalaTreeMiniMap:setPlayerPosition(targetPosMN)
            end)
        else
            self.KabalaTreeMiniMap:locationMiniMap(targetPosMN,true)
            self.KabalaTreeMiniMap:setPlayerPosition(targetPosMN)
        end
        self:startSpawnTileByServer(targetPosMN,newTitled)
    end)
end

--刷新地图数据
function KabalaTreeExploreView:onUpdateMapInfo(updateMapData)

    if not updateMapData then
        return
    end

    for k,v in pairs(updateMapData) do        
        local tilePosX,tilePosY = v.x,v.y
        local isOpen = KabalaTreeDataMgr:isOpen(ccp(tilePosX,tilePosY))
        if isOpen then
            if v.event > 0 then
                self:spawnEventObject(ccp(tilePosX,tilePosY))
            else
                self.KabalaTreeItem:cleanItem(ccp(tilePosX,tilePosY))
                self.KabalaTreeMiniMap:cleanItem(ccp(tilePosX,tilePosY))
            end
            self.KabalaTreeGridMap:updateTiled(ccp(tilePosX,tilePosY),isOpen)
        end
    end
end

function KabalaTreeExploreView:onUpdateRadarFlash()

    self.radarFlash:setVisible(true)
    local Act = Sequence:create{
        RotateBy:create(5,360),
        CallFunc:create(function()
            self.radarFlash:setVisible(false)
        end)
    }
    self.radarFlash:runAction(Act)
end

function KabalaTreeExploreView:getKabalaTreeMapPos(tiledPosMN)

    local targetPosition = KabalaTreeDataMgr:convertToPos(tiledPosMN.x,tiledPosMN.y)
    local mapPosX, mapPosY = self:getMapContaierPos(targetPosition)
    local position = KabalaTreeDataMgr:detectEdges(ccp(mapPosX,mapPosY)) 

    return position
end

--消除格子道具
function KabalaTreeExploreView:onRecvClearTileItem(tiledPosMN,eventId)

    Utils:playSound(2002)
    self.KabalaTreeItem:cleanItem(tiledPosMN)
    self.KabalaTreeMiniMap:cleanItem(tiledPosMN)
    if eventId >0 then
        KabalaTreeDataMgr:updateStatisticsData(eventId)
    end
end

function KabalaTreeExploreView:onRecvSearchTarget(result)

    if result then
        self:setRadarParam(self.normalMax,self.normalUpdateTime)

        local curPosMN = self.KabalaTreeNpc:getPositiontMN()
        if not curPosMN then
            return
        end
        self.KabalaTreeGridMap:updateTiled(curPosMN,true)
    end
    self.KabalaTreeNpc:setClickSearchFlage(false)
    self.KabalaTreeNpc:setSearchResult(result)
end

function KabalaTreeExploreView:onUpdateWorldState(openWorldCid,missionComplete,openStatus)

    local curWorldId = KabalaTreeDataMgr:getCurWorld()
    if openWorldCid == curWorldId and (not openStatus) then
        Utils:showTips(3005036)
        self:timeOut(function()
            AlertManager:closeLayer(self)
        end,1.0)
    end
end


function KabalaTreeExploreView:registerEvents()

    EventMgr:addEventListener(self,EV_FUNC_MOVE,handler(self.onPlayerMoveTo, self))
    EventMgr:addEventListener(self,EV_TRIGGER_EVENT,handler(self.onRecvTriggerEvent, self))
    EventMgr:addEventListener(self,EV_UPDATE_FORMATION,handler(self.onUpdateTeamInfo, self))
    EventMgr:addEventListener(self,EV_UPDATE_KABALATASK,handler(self.onUpdateTaskInfo, self))
    EventMgr:addEventListener(self,EV_UPDATE_HERO_INFECTION,handler(self.onUpdateTeamInfo, self))
    EventMgr:addEventListener(self,EV_TRIGGER_RANDOM_ATTACK,handler(self.onRecvRandomAttack, self))
    EventMgr:addEventListener(self,EV_TRIGGER_TRANSPORT,handler(self.onRecvTransport, self))
    EventMgr:addEventListener(self,EV_CLEAR_TILEDITEM,handler(self.onRecvClearTileItem, self))
    EventMgr:addEventListener(self,EV_UPDATE_RESOURCE,handler(self.onUpdateResourceInfo, self))
    EventMgr:addEventListener(self,EV_SEARCH_RESULT,handler(self.onRecvSearchTarget, self))
    EventMgr:addEventListener(self,EV_UPDATE_KABALABAG,handler(self.onUpdateTeamInfo, self))
    EventMgr:addEventListener(self,EV_GET_WORLD_INFO,handler(self.onGetWorldInfo, self))
    EventMgr:addEventListener(self,EV_UPDATE_STORE,handler(self.onUpdateResourceInfo, self))
    EventMgr:addEventListener(self,EV_UPDATE_WORLD_INFO,handler(self.onUpdateMapInfo, self))
    EventMgr:addEventListener(self,EV_FLASH_RADAR,handler(self.onUpdateRadarFlash, self))
    EventMgr:addEventListener(self,EV_UPDATE_TREE_INFO,handler(self.onUpdateWorldState, self))
    EventMgr:addEventListener(self,EV_UPDATE_KABALABUFF,handler(self.onUpdateBuffInfo, self))
    EventMgr:addEventListener(self,EV_DISCOVER_TASK,handler(self.onUpdateDiscoverTask, self))
    EventMgr:addEventListener(self,EV_UPDATE_HIDDENEVENT,handler(self.onUpdateHiddenEvent, self))
    EventMgr:addEventListener(self,EV_PLAY_HIDDENEVENT_EFFECT,handler(self.onSpawnHiddenEvent, self))
    EventMgr:addEventListener(self,EV_TRRIGGER_MINIGAME,handler(self.onTriggerMiniGame, self))
    EventMgr:addEventListener(self,EV_QLIPHOTH_SHOP_INFO,handler(self.onOpenKabalaStore, self))



    self:setMainBtnCallback(function()
        AlertManager:changeScene(SceneType.MainScene)
    end)

    self.Button_maphelp:onClick(function ()
        Utils:openView("kabalaTree.KabalaTreeMapInfo",1)
    end)

    self.Button_itembag:onClick(function ()
        Utils:openView("kabalaTree.KabalaTreeBag")
    end)

    self.Button_statistics:onClick(function ()
        Utils:openView("kabalaTree.KabalaTreeStatistics",1)
    end)

    self.Button_statelist:onClick(function ()
        Utils:openView("kabalaTree.KabalaTreeState")
    end)

    self.Button_location:onClick(function ()
        local curPosMN = self.KabalaTreeNpc:getPositiontMN()
        if not curPosMN then
            return
        end
        local inScreen = KabalaTreeDataMgr:checkInScreen(curPosMN)
        if not inScreen then
            self:locationPlayer(false)
        end
    end)

    self.Button_chat:onClick(function ()
        local ChatView = require("lua.logic.chat.ChatView")
        ChatView.show(function ( )
        end,false)
    end)

    for i=1,3 do
        self.teamInfo[i].teamImage:onClick(function ()
            Utils:openView("kabalaTree.KabalaTreeFormation",i)
        end)
    end

    self.skipRandomBtn:onClick(function ()
        local value = KabalaTreeDataMgr:getSkipRandomMonsterFlag()
        local id = value == 1 and 2 or 1
        local tipsStrId = id == 1 and 3005028 or 3005027
        Utils:showTips(tipsStrId)
        self:updateSkipRandom(id)
    end)

    self.Panel_pointDirection:onClick(function ()
        local curPosMN = self.KabalaTreeNpc:getPositiontMN()
        if not curPosMN then
            return
        end
        local inScreen = KabalaTreeDataMgr:checkInScreen(curPosMN)
        if not inScreen then
            self:locationPlayer(false)
        end
    end)

    self.Panel_miniMap:onClick(function ()

        local curPosMN = self.KabalaTreeNpc:getPositiontMN()
        if not curPosMN then
            return
        end
        Utils:openView("kabalaTree.KabalaTreeBigMiniMap",self.mapId,curPosMN) 
    end)

    for i=1,3 do
        self.buffInfo[i].buffBtn:onClick(function ()
            self:showBuffTip(i)
        end)
    end

    self.Button_radar:onClick(function()
        local discoverPos = KabalaTreeDataMgr:getDiscoverTaskPos()
        if discoverPos then
            Utils:showTips(3004046)
            return
        end
        Utils:openView("kabalaTree.KabalaTreeRadarView")
    end)

end

return KabalaTreeExploreView