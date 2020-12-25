local KabalaTreeMainView = class("KabalaTreeMainView", BaseLayer)

function KabalaTreeMainView:ctor()
	self.super.ctor(self)
	self:initData()
	self:init("lua.uiconfig.kabalaTree.kabalaTreeMainView")
end

function KabalaTreeMainView:initData()
	self.pointItem_ = {}
    self.KabalaWorldCfg = TabDataMgr:getData("KabalaWorld")
    self.pointIcon = {"7.png","4.png","5.png","3.png","6.png","1.png","0.png","9.png","8.png","2.png"}
    --0,20,45
    self.topLen = 21
    self.centerLen = 45
    self.deltaLen = self.centerLen-self.topLen
    self.topHight = 41

    self:calcLenth()
end

function KabalaTreeMainView:calcLenth()

    local topEdge = math.sqrt(self.topHight*self.topHight + self.deltaLen*self.deltaLen)
    topEdge = math.floor(topEdge)
    self.lenInfo = {} 
    self.lenInfo[1] = self.topLen
    self.lenInfo[2] = self.topLen + topEdge
    self.lenInfo[3] = self.topLen + topEdge + topEdge
    self.lenInfo[4] = self.topLen + topEdge + topEdge + self.topLen
    self.allLen = self.topLen*2 + topEdge* 2

end

function KabalaTreeMainView:getBarEffectPos(percent)

    percent = percent or 0
    local curLen = math.floor(self.allLen*percent)
    local stage = 1
    for i=1,4 do
        if curLen <= self.lenInfo[i] then
            stage = i
            break
        end
    end

    local posX,posY,posXLeft = 0,0,0
    if stage == 1 then
        posX = curLen
        posY = self.topHight
        posXLeft = -posX
    elseif stage == 2 then 
        local edgeLen = self.lenInfo[2] - curLen 
        posX = self.centerLen - math.cos(math.rad(60))*edgeLen + 1
        posY = math.sin(math.rad(60))*edgeLen
        posXLeft = -posX-2
    elseif stage == 3 then
        local edgeLen = curLen - self.lenInfo[2] - 2
        posX = self.centerLen - math.cos(math.rad(60))*edgeLen + 2
        posY = -math.sin(math.rad(60))*edgeLen
        posXLeft = -posX-2
    elseif stage == 4 then
        posX = self.topLen - (curLen - self.lenInfo[3] -2)
        posY = -self.topHight-2
        posXLeft = -posX
    end
 
    return ccp(posX,posY),ccp(posXLeft,posY)
end

function KabalaTreeMainView:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	self:showTopBar()

	self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_site = {}
    self.ScrollView_point = TFDirector:getChildByPath(self.Panel_root, "ScrollView_point")
    local Image_diban = TFDirector:getChildByPath(self.ScrollView_point, "Image_diban")
    for i=1, 10 do
    	self.Panel_site[i] = TFDirector:getChildByPath(Image_diban, "Panel_site_"..i)
    	self.Panel_site[i]:setBackGroundColorType(0)
    end

    --材料
    self.materialId = {500025,570101}
    local Panel_material = TFDirector:getChildByPath(self.Panel_root, "Panel_material")
    self.material = {}
    for i=1,2 do
        local Image_material = TFDirector:getChildByPath(Panel_material, "Image_material_"..i)
        local Image_material_icon = Image_material:getChildByName("Image_material_icon")
        local Label_material_count = Image_material:getChildByName("Label_material_count")
        self.material[i] = {}
        self.material[i].bg = Image_material 
        self.material[i].icon = Image_material_icon 
        self.material[i].count = Label_material_count
    end
        
    --按钮组
    self.Panel_func_btn = TFDirector:getChildByPath(self.Panel_root, "Panel_func_btn")
    self.Button_res_exchange = TFDirector:getChildByPath(self.Panel_func_btn, "Button_res_exchange")
    local Label_btn = TFDirector:getChildByPath(self.Button_res_exchange, "Label_btn")
    Label_btn:setTextById(3004004)

    self.Button_cleantask = TFDirector:getChildByPath(self.Panel_func_btn, "Button_cleantask")
    local Label_btn = TFDirector:getChildByPath(self.Button_cleantask, "Label_btn")
    Label_btn:setTextById(3004003)

    self.Button_playhelp = TFDirector:getChildByPath(self.Panel_func_btn, "Button_playhelp")
    local Label_btn = TFDirector:getChildByPath(self.Button_playhelp, "Label_btn")
    Label_btn:setTextById(3004002)

    --检查配置
    self.Button_check = TFDirector:getChildByPath(self.Panel_func_btn, "Button_check")
    self.Button_check:setVisible(CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)

    --新增版本
    self.Button_check_version = TFDirector:getChildByPath(self.Panel_func_btn, "Button_check_version")
    self.Button_check_version:setVisible(CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)

    --罗盘
    self.Panel_luopan_touch= TFDirector:getChildByPath(self.Panel_root, "Image_luopan_bg")
    self.Panel_luopan_touch:setVisible(false) --暂时屏蔽
    self.Image_luopan= TFDirector:getChildByPath(self.Panel_luopan_touch, "Image_luopan_bg")
    self.Panel_luopanItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_luopanItem")

    --质点
    self.Panel_pointItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_pointItem")
    TFDirector:send(c2s.QLIPHOTH_QLIPHOTH_TREE_INFO, {})

    self.Button_newPlayer = TFDirector:getChildByPath(self.Panel_root, "Button_newPlayer")
    local activitys = ActivityDataMgr2:getNewPlayerActivityInfo(true)
    if #activitys < 1 then
        self.Button_newPlayer:setVisible(false)
    else
        self.Button_newPlayer:setVisible(true)
        self.Button_newPlayer:setTouchEnabled(false)
        self.Label_newPlayerNumExp = TFDirector:getChildByPath(self.Panel_root, "Label_newPlayerNumExp")
        self.Label_newPlayerNumCoin = TFDirector:getChildByPath(self.Panel_root, "Label_newPlayerNumCoin")
        local newbleCfg = TabDataMgr:getData("NewbleAdd")
        local number = newbleCfg[201].number
        if number[1] then
            self.Label_newPlayerNumExp:setText(number[1] .. "%")
        end
        if number[2] then
            self.Label_newPlayerNumCoin:setText(number[2] .. "%")
        end
        self.Image_newPlayerEXP = TFDirector:getChildByPath(self.Panel_root, "Image_newPlayerEXP")
        self.Image_newPlayerCoin = TFDirector:getChildByPath(self.Panel_root, "Image_newPlayerCoin")

        self.Image_newPlayerEXP:setVisible(number[1])
        self.Image_newPlayerCoin:setVisible(number[2])
        self.Label_newPlayerNumExp:setVisible(number[1])
        self.Label_newPlayerNumCoin:setVisible(number[2])
    end

end

function KabalaTreeMainView:updateTreeInfo(openWorldId,missionCnt)

    --openWorldId 表示玩家所在di(或许以后会有两个同时开的情况需要修改)
    self.openWorldId = openWorldId
    self.missionCnt = missionCnt
    self.tickCnt = 0
    self:initScrollBtn()
    self:initTreeData()

    self:updateMaterial()

    local seqact = Sequence:create({
        DelayTime:create(1),
        CallFunc:create(function()
            self.tickCnt = self.tickCnt + 1
            self:updateTreeData()
        end)
    })
    self.Panel_root:runAction(CCRepeatForever:create(seqact))
end

function KabalaTreeMainView:updateTreeWorldInfo(openWorldId,missionCnt,state)
    if state then
        self:updateTreeInfo(openWorldId,missionCnt)
    end
end

function KabalaTreeMainView:updateMaterial()

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

function KabalaTreeMainView:getWorldInfo(pointId)

    for k,v in pairs(self.KabalaWorldCfg) do
        if pointId == v.worldPosition then
            return v
        end
    end
    return nil
end

function KabalaTreeMainView:initTreeData()


    local openItem
	for k, v in pairs(self.Panel_site) do
        local worldid = k
        local cfgInfo = self:getWorldInfo(k)
        if cfgInfo then
            worldid = cfgInfo.id
        end

        local Panel_pointItem = self:addPointItem(worldid)
        self:setPointItemData(worldid)
        Panel_pointItem:Pos(0, 0):AddTo(v)
        local state,time = KabalaTreeDataMgr:getWorldState(worldid)
        if state == Enum_WorldState.State_Opening then
            openItem = v
        end
    end

    if openItem then
        self:jumpToItem(openItem)
    end

end

function KabalaTreeMainView:jumpToItem(item)

    local innerContainer = self.ScrollView_point:getInnerContainer()
    local innerSize = innerContainer:getSize()
    local contentSize = self.ScrollView_point:getSize()
    local center = ccp(contentSize.width * 0.5, contentSize.height * 0.5)
    local y_offset = math.min(0,contentSize.height - innerSize.height)
    local w_offset = math.min(0,contentSize.width - innerSize.width)

    local position = item:getPosition()
    local wp = item:getParent():convertToWorldSpaceAR(position)
    local np = innerContainer:convertToNodeSpaceAR(wp)

    local dis = ccpSub(center , np)
    local percentX = 0
    if w_offset ~= 0 then
        percentX = dis.x * 100 / w_offset
    end
    local percentY = 0
    if y_offset ~= 0 then
        percentY = (100 - dis.y * 100 / y_offset)
    end
    percentX = math.max(0,percentX)
    percentX = math.min(100,percentX)
    percentY = math.max(0,percentY)
    percentY = math.min(100,percentY)
    self.ScrollView_point:scrollTo(TF_SCROLLVIEW_SCROLL_TO_PERCENT_BOTH, 0.2, true, percentX, percentY)
end

function KabalaTreeMainView:updateTreeData()

    for k, v in pairs(self.Panel_site) do
        local worldid = k
        local cfgInfo = self:getWorldInfo(k)
        if cfgInfo then
            worldid = cfgInfo.id
        end
        self:setPointItemData(worldid)
    end
end

function KabalaTreeMainView:addPointItem(worldid)
    local Panel_pointItem = self.Panel_pointItem:clone()
    local item = {}
    item.root = Panel_pointItem
    item.Image_open = TFDirector:getChildByPath(item.root, "Image_open")
    item.Image_normal = TFDirector:getChildByPath(item.root, "Image_normal")
    item.LoadingBar_effectLeft = TFDirector:getChildByPath(item.root, "LoadingBar_effectLeft")
    item.LoadingBar_effectRight = TFDirector:getChildByPath(item.root, "LoadingBar_effectRight")
    
    item.LoadingBar_task = TFDirector:getChildByPath(item.root, "LoadingBar_task")
    item.icon = TFDirector:getChildByPath(item.root, "icon")
    item.Label_state = TFDirector:getChildByPath(item.root, "Label_state")
    item.Label_time = TFDirector:getChildByPath(item.root, "Label_time")
    item.Label_name = TFDirector:getChildByPath(item.root, "Label_name")
    item.Image_ship = TFDirector:getChildByPath(item.root, "Image_ship")
    item.Image_textbg = TFDirector:getChildByPath(item.root, "Image_textbg")
    item.Panel_open = TFDirector:getChildByPath(item.root, "Panel_open")
    item.Panel_opening = TFDirector:getChildByPath(item.root, "Panel_opening")
    item.Spine_barRight = TFDirector:getChildByPath(item.root, "Spine_barRight")
    item.Spine_barRight:playByIndex(0, 1)
    item.Spine_barLeft = TFDirector:getChildByPath(item.root, "Spine_barLeft")
    item.Spine_barLeft:playByIndex(0, 1)

    self.pointItem_[worldid] = item
    return Panel_pointItem
end

function KabalaTreeMainView:setPointItemData(worldId)

    local item = self.pointItem_[worldId]
    local worldTimeInfo = KabalaTreeDataMgr:getTimeInfo(worldId)
    local cfgInfo = self.KabalaWorldCfg[worldId]
    if not cfgInfo or not worldTimeInfo then
        item.Panel_open:setVisible(false)
        item.Image_open:setVisible(false)
        item.icon:setTexture("icon/kabalatree/"..self.pointIcon[worldId])
        return
    end

    item.Panel_open:setVisible(true)
    item.Image_ship:setVisible(worldId == self.openWorldId)
    local totalTime = worldTimeInfo.beSoon*60
    local beInThisWorld = self.openWorldId == worldId
    local finishCnt = self.missionCnt
    local state,time = KabalaTreeDataMgr:getWorldState(worldId)
    local curTime = ServerDataMgr:getServerTime()
    
    item.Spine_barRight:setVisible(state == Enum_WorldState.State_willOpen)
    item.Spine_barLeft:setVisible(state == Enum_WorldState.State_willOpen)

    --稳定/关闭状态
    if state == Enum_WorldState.State_stabilize then
        item.Label_state:setTextById(3004007)
        item.Label_state:setColor(ccc3(135,145,218))
        item.Panel_opening:setVisible(false)
        item.Image_open:setVisible(false)
        item.Image_normal:setVisible(true)
    --侵蚀中(预开启)
    elseif state == Enum_WorldState.State_willOpen then
   
        item.Panel_opening:setVisible(true)
        item.Label_state:setTextById(3004005)
        item.Label_state:setColor(ccc3(135,145,218))
        item.LoadingBar_task:setPercent(0)

        local countdownTime = time - curTime
        if countdownTime > 0 then
            local formatTime = self:formateTime(countdownTime)
            item.Label_time:setText(formatTime)
            local percent = (1-countdownTime/totalTime)*100
            percent = percent*50/100
            item.LoadingBar_effectLeft:setPercent(percent)
            item.LoadingBar_effectRight:setPercent(percent)
            local pos,posLeft = self:getBarEffectPos((1-countdownTime/totalTime))
            item.Spine_barRight:setPosition(pos)
            item.Spine_barLeft:setPosition(posLeft)
        end

    --开放中(beInThisWorld:false 已被侵蚀, true: 净化中 or 净化完成)
    elseif state == Enum_WorldState.State_Opening then 

        local taskCnt = #cfgInfo.missionParam+1
        if beInThisWorld then
            if finishCnt >= taskCnt then
                item.Label_state:setTextById(3004008)
                item.Label_state:setColor(ccc3(135,145,218))
                item.LoadingBar_task:setPercent(100)
            else
                item.Label_state:setTextById(3004006)
                item.Label_state:setColor(ccc3(241,80,135))
                local percent = finishCnt/taskCnt*100
                item.LoadingBar_task:setPercent(percent)
            end
        else
          item.Label_state:setTextById(3004010)  
          item.Label_state:setColor(ccc3(241,80,135))
        end
        
        local countdownTime = time - curTime
        if countdownTime > 0 then
            local formatTime = self:formateTime(countdownTime)
            item.Label_time:setText(formatTime) 
        end

        if beInThisWorld and finishCnt >= taskCnt then
            item.Image_open:setVisible(false)
            item.Image_normal:setVisible(true)
            item.LoadingBar_effectLeft:setPercent(0)
            item.LoadingBar_effectRight:setPercent(0)
        else
            item.Image_open:setVisible(true)
            item.Image_normal:setVisible(false)
            item.LoadingBar_effectLeft:setPercent(50)
            item.LoadingBar_effectRight:setPercent(50)
            item.LoadingBar_task:setPercent(0)
        end

    end

    item.Label_name:setTextById(cfgInfo.worldName)
    item.icon:setTexture(cfgInfo.sephirothDocument)

    item.root:onClick(function()
        self:intoWorld(worldId,cfgInfo.worldName)
    end)
end

function KabalaTreeMainView:stringToTime(timeString)

    local times = string.split(timeString," ")
    local ymd = string.split(times[1],"-")
    local hmd = string.split(times[2],":")
    
    local Y,M,D = ymd[1],ymd[2],ymd[3]
    local h,m,s = hmd[1],hmd[2],hmd[3]

    return os.time({year=Y, month=M, day=D, hour=h,min=m,sec=s})
end

function KabalaTreeMainView:intoWorld(worldId,worldName)

    local state,time,beInThisWorld,maxCnt = KabalaTreeDataMgr:getWorldState(worldId)
    if state ~= Enum_WorldState.State_Opening then
        Utils:showTips(3005023)
        return
    end

    if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
        local version = KabalaTreeDataMgr:getKabalaVersion()
        local oldVersion = KabalaTreeDataMgr:getOldVersion()
        if version ~= oldVersion then
            Utils:showTips("版本号不匹配")
            return
        end
    end

    --[[取消打完BOSS不能进世界的限制
    if state == Enum_WorldState.State_Opening and finshCnt >= maxCnt then
        Utils:showTips(3005021)
        return
    end]]

    Utils:openView("kabalaTree.KabalaTreeExploreView",worldId)

end

function KabalaTreeMainView:initScrollBtn()
    --max:12 360/30
    self.btnInfo = {}
    local index = 1
    local finishCnt = self.missionCnt
    for k,v in pairs(self.KabalaWorldCfg) do
    --for i=1,8 do
        local angle = 15 + (index-1)*30
        local x = 200*math.cos(math.pi*angle/180)
        local y = 200*math.sin(math.pi*angle/180)

        local btn = self.Panel_luopanItem:clone()
        btn:setSwallowTouch(false)
        btn:setPosition(ccp(x,y))        
        self.Image_luopan:addChild(btn)

        local Image_icon = TFDirector:getChildByPath(btn, "Image_icon") 
        local LoadingBar_bar = TFDirector:getChildByPath(btn, "LoadingBar_bar")

        local worldId = v.id
        self.btnInfo[worldId] = {}
        self.btnInfo[worldId].btn = btn
        self.btnInfo[worldId].Image_icon = Image_icon
        self.btnInfo[worldId].LoadingBar_bar = LoadingBar_bar
        index = index + 1
        self:updateScrollBtn(worldId)
    end
end

function KabalaTreeMainView:updateScrollBtn(worldId)

    local scrollBtn = self.btnInfo[worldId]
    if not scrollBtn then
        return
    end

    local worldCfg = self.KabalaWorldCfg[worldId]
    if not worldCfg then
        return
    end

    
    scrollBtn.Image_icon:setTexture(worldCfg.sephirothDocument)

    local state,time = KabalaTreeDataMgr:getWorldState(worldId)
    if state == Enum_WorldState.State_Opening then 
        scrollBtn.btn:setTexture("ui/kabalatree/luopan_open.png")
        scrollBtn.LoadingBar_bar:setPercent(0)
    elseif state == Enum_WorldState.State_willOpen then
        scrollBtn.btn:setTexture("ui/kabalatree/luopan_stable.png")
    elseif state == Enum_WorldState.State_stabilize then
        scrollBtn.LoadingBar_bar:setPercent(0)
        scrollBtn.btn:setTexture("ui/kabalatree/luopan_stable.png")
    end
end

function KabalaTreeMainView:touchBegin(touch,touchPos)    
    self.touchBeginPos = touchPos
end


function KabalaTreeMainView:touchMoved(touch,touchPos)    
    self.touchEndPos = touchPos
    local deltaxtemp = self.touchBeginPos.x - self.touchEndPos.x
    local deltax = self.touchBeginPos.x - self.touchEndPos.x
    local deltay = self.touchBeginPos.y - self.touchEndPos.y
    local delta =  math.abs(deltax)
    local angle = delta/360+1
    if deltaxtemp > 0  then
        angle = -math.abs(angle)
    end
    local newAngle =  self.Image_luopan:getRotation()+angle
    if newAngle < 0 then
        return
    end
    if newAngle > (#self.btnInfo-3)*30 then
        return
    end
    for i=1,8 do
        self.btnInfo[i]:setRotation(self.btnInfo[i]:getRotation()-angle)
    end
    self.Image_luopan:setRotation(self.Image_luopan:getRotation()+angle)
end

function KabalaTreeMainView:formateTime(timeVal)

    if timeVal < 0 then
        timeVal = 0
    end
    local hour= math.floor(timeVal / 3600)
    local min = math.floor(timeVal % 86400 % 3600 / 60)
    local seconds = math.floor(timeVal % 86400 % 3600 % 60 / 1)
    return string.format("%02d:%02d:%02d", hour, min, seconds)

end

function KabalaTreeMainView:registerEvents()

    EventMgr:addEventListener(self,EV_UPDATE_RESOURCE,handler(self.updateMaterial, self))
    EventMgr:addEventListener(self,EV_GET_TREE_INFO,handler(self.updateTreeInfo, self))

    --卡巴拉商店
    self.Button_res_exchange:onClick(function ()        
        Utils:openView("store.StoreMainView", 140000)
    end)

    --净化任务
    self.Button_cleantask:onClick(function ()
        if self.openWorldId == 0 then
            Utils:showTips(3005024)
        else
            Utils:openView("kabalaTree.KabalaTreeCleanTask",self.openWorldId)
        end
    end)

    --玩法说明
    self.Button_playhelp:onClick(function ()        
        Utils:openView("kabalaTree.KabalaTreePlayGuide")
    end)

    self.Button_check:onClick(function ()
        self:checkCfg()
    end)

    self.Button_check_version:onClick(function ()
        KabalaTreeDataMgr:checkVersion()
    end)

    self.Panel_luopan_touch:setTouchEnabled(true)
    self.Panel_luopan_touch:setSwallowTouch(false)
    self.Panel_luopan_touch:addMEListener(TFWIDGET_TOUCHBEGAN, handler(self.touchBegin,self));
    self.Panel_luopan_touch:addMEListener(TFWIDGET_TOUCHMOVED, handler(self.touchMoved,self));
    self.Panel_luopan_touch:addMEListener(TFWIDGET_TOUCHENDED, handler(self.touchEnd,self));
end

--检查策划地图配置
function KabalaTreeMainView:checkCfg()

    local wrongInfo = {}
    local cfg = TabDataMgr:getData("KabalaServerData")
    for k,v in pairs(cfg) do
        local wrongTab = self:isWrongCfg(v.mapSize,v.firstJsonData,v.secondJsonData,v.thirdJsonData)
        if wrongTab and next(wrongTab) then
            wrongInfo[v.mapDocument] = wrongTab
        end
    end

    if not next(wrongInfo) then
        Box("Succes")
        return
    end

    for mapName,wrongPoints in pairs(wrongInfo) do
        for k,points in ipairs(wrongPoints) do
            Box(mapName.."("..points.x..","..points.y..")","Wrong map")
        end
    end

end

function KabalaTreeMainView:isWrongCfg(mapSize,first,second,third)

    local wrongTab = {}
    for id,gidId in ipairs(third) do
        --第三成是障碍，第一层地板为普通格子，第二层又没有阻挡
        --or 第二层有阻挡，第三层又不是阻挡
        if (gidId == 2 and first[id] == 202 and second[id] == 0) or
                (gidId ~= 2 and second[id] ~= 0) then
            table.insert(wrongTab,self:idToMapPos(id,mapSize))
        end
    end
    return wrongTab
end

function KabalaTreeMainView:idToMapPos(id,mapSize)
    print("id",id)
    id = id - 1
    local mapSizeW,mapSizeH = mapSize[1],mapSize[2]
    local posX = id%mapSizeW
    local posY = math.floor(id/mapSizeW)
    return ccp(posX,posY)
end

return KabalaTreeMainView