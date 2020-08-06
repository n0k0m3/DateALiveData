local CourageMainView = class("CourageMainView", BaseLayer)

function CourageMainView:initData()

    self.mapItem_ = {}
    self.mapScale = 0.2
    self.triggerDating = false
    self.pathItem_ = {}

    self.actBtnImg = {"ui/activity/courage/main/new/007.png","ui/activity/courage/main/new/008.png"}
    self.actBtnText = {"行动","行动中"}

    self.itemtipFly = false
    self.itemImgFly = false

    self.arrowAni = {}
    self.arrowAni[1] = CCSequence:create({ CCMoveTo:create(1,ccp(0,214)), CCMoveTo:create(1,ccp(0,228))})
    self.arrowAni[2] = CCSequence:create({ CCMoveTo:create(1,ccp(174,145)), CCMoveTo:create(1,ccp(198,161))})
    self.arrowAni[3] = CCSequence:create({ CCMoveTo:create(1,ccp(226,0)), CCMoveTo:create(1,ccp(245,0))})
    self.arrowAni[4] = CCSequence:create({ CCMoveTo:create(1,ccp(174,-145)), CCMoveTo:create(1,ccp(198,-161))})
    self.arrowAni[5] = CCSequence:create({ CCMoveTo:create(1,ccp(0,-214)), CCMoveTo:create(1,ccp(0,-228))})
    self.arrowAni[6] = CCSequence:create({ CCMoveTo:create(1,ccp(-174,-145)), CCMoveTo:create(1,ccp(-198,-161))})
    self.arrowAni[7] = CCSequence:create({ CCMoveTo:create(1,ccp(-226,0)), CCMoveTo:create(1,ccp(-245,0))})
    self.arrowAni[8] = CCSequence:create({ CCMoveTo:create(1,ccp(-174,145)), CCMoveTo:create(1,ccp(-198,161))})
end

function CourageMainView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.courage.courageMainView")
end

function CourageMainView:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Image_front = TFDirector:getChildByPath(self.Panel_root, "Image_front")
    self.Image_back = TFDirector:getChildByPath(self.Panel_root, "Image_back")
    self.Image_back:setOpacity(255)
    self.Panel_scene = TFDirector:getChildByPath(self.Panel_root, "Panel_scene")
    self.Panel_ui = TFDirector:getChildByPath(self.Panel_root, "Panel_ui")

    self.Button_exit = TFDirector:getChildByPath(self.Panel_root, "Button_exit")

    self.Spine_door = TFDirector:getChildByPath(self.Panel_root, "Spine_door"):hide()
    self.Spine_light = TFDirector:getChildByPath(self.Panel_root, "Spine_light"):hide()

    self.Panel_touch = TFDirector:getChildByPath(self.Panel_root, "Panel_touch")
    self.Panel_touch:setSize(GameConfig.WS)
    self.Image_guide = TFDirector:getChildByPath(self.Panel_touch, "Image_guide")

    self.Panel_mask = TFDirector:getChildByPath(self.Panel_root, "Panel_mask"):hide()
    self.Panel_mask:setSize(GameConfig.WS)

    self.Panel_disable_btns = TFDirector:getChildByPath(self.Panel_root, "Panel_disable_btns"):hide()
    self.Panel_disable_btns:setSize(GameConfig.WS)

    self.Image_task_bg = TFDirector:getChildByPath(self.Panel_root, "Image_task_bg")
    self.Button_check = TFDirector:getChildByPath(self.Image_task_bg, "Button_check")
    local ScrollView_task = TFDirector:getChildByPath(self.Image_task_bg, "ScrollView_task")
    self.ListView_task = UIListView:create(ScrollView_task)
    self.Panel_task = TFDirector:getChildByPath(self.Image_task_bg, "Panel_task")
    self.Image_task_bg:setPositionX(GameConfig.WS.width/2 - 65)

    ---提示信息
    self.Panel_tip_message =  TFDirector:getChildByPath(self.Panel_root, "Panel_tip_message")
    local ScrollView_message = TFDirector:getChildByPath(self.Panel_root, "ScrollView_message")
    self.ListView_message = UIListView:create(ScrollView_message)
    self.messageItem = TFDirector:getChildByPath(self.Panel_tip_message, "Panel_message_item"):hide()
    self.Panel_tip_message:setPositionX(-GameConfig.WS.width/2)

    self.Button_chat =  TFDirector:getChildByPath(self.Panel_root, "Button_chat")
    self.Button_chat:setPositionX(-GameConfig.WS.width/2+20)

    ---探索结果
    self.Panel_result_item = TFDirector:getChildByPath(self.Panel_root, "Panel_result_item"):hide()
    self.Panel_result_item:setSize(GameConfig.WS)
    self.Image_result_item = TFDirector:getChildByPath(self.Panel_result_item, "Image_result_item"):hide()
    self.resultItemPos = self.Image_result_item:getPosition()
    self.Label_item_tip = TFDirector:getChildByPath(self.Panel_result_item, "Label_item_tip"):hide()

    self.Label_word = TFDirector:getChildByPath(self.Panel_result_item, "Label_word"):hide()

    ---发现疑点
    self.Panel_hide_item = TFDirector:getChildByPath(self.Panel_root, "Panel_hide_item"):hide()
    self.Panel_items = TFDirector:getChildByPath(self.Panel_hide_item, "Panel_items")

    ---发现新方向
    self.Panel_new_direction = TFDirector:getChildByPath(self.Panel_root, "Panel_new_direction"):hide()
    self.Panel_dir_mask = TFDirector:getChildByPath(self.Panel_root, "Panel_dir_mask"):hide()
    self.Panel_dir_mask:setSize(GameConfig.WS)

    self.dirItem_ = {}
    for i=1,8 do
        local dir = TFDirector:getChildByPath(self.Panel_new_direction, "Panel_dir_item_"..i)
        self.dirItem_[i] = dir
        dir:runAction(CCRepeatForever:create(self.arrowAni[i]))
    end

    ---事件记录
    self.Panel_event_record  = TFDirector:getChildByPath(self.Panel_root, "Panel_event_record")
    local ScrollView_record = TFDirector:getChildByPath(self.Panel_event_record, "ScrollView_record")
    self.List_record = UIListView:create(ScrollView_record)
    self.List_record:setItemsMargin(5)
    self.recordViewSize = self.List_record:getContentSize()
    self.Button_detail = TFDirector:getChildByPath(self.Panel_event_record, "Button_detail")

    ---ap
    self.Panel_ap = TFDirector:getChildByPath(self.Panel_root, "Panel_ap")
    self.LoadingBar_ap = TFDirector:getChildByPath(self.Panel_ap, "LoadingBar_ap")
    self.Label_ap_value = TFDirector:getChildByPath(self.Panel_ap, "Label_ap_value")
    self.Spine_ap = TFDirector:getChildByPath(self.Panel_ap, "Spine_ap")

    self.Panel_ap:setPositionX(-GameConfig.WS.width/2)

    self.Button_compose = TFDirector:getChildByPath(self.Panel_ui, "Button_compose")
    self.Button_bag = TFDirector:getChildByPath(self.Panel_ui, "Button_bag")
    self.Button_jump = TFDirector:getChildByPath(self.Panel_ui, "Button_jump")
    self.Button_jump:setTextureNormal(self.actBtnImg[1])
    self.Label_jumpbtn = TFDirector:getChildByPath(self.Button_jump, "Label_btn")
    self.Label_jumpbtn:setText(self.actBtnText[1])
    ---地图
    self.Image_minimap = TFDirector:getChildByPath(self.Panel_ui, "Image_minimap")
    self.Panel_miniMap = TFDirector:getChildByPath(self.Panel_ui, "Panel_miniMap")
    self.Image_map = TFDirector:getChildByPath(self.Panel_miniMap, "Image_map")
    self.Panel_touchMiniMap = TFDirector:getChildByPath(self.Panel_ui, "Panel_touchMiniMap")
    local Panel_level = TFDirector:getChildByPath(self.Panel_miniMap, "Panel_level")
    self.levelItem_ = {}
    for i, v in ipairs(Panel_level:getChildren()) do
        v:setBackGroundColorType(0)
        local name = v:getName()
        local prefix, id = string.match(name, "(.*)_(.*)")
        self.levelItem_[tonumber(id)] = v
    end

    self.Image_minimap:setPositionX(GameConfig.WS.width/2)

    self.Panel_corner_btns = TFDirector:getChildByPath(self.Panel_ui, "Panel_corner_btns")
    self.Panel_corner_btns:setPositionX(GameConfig.WS.width/2)

    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
    self.Label_record = TFDirector:getChildByPath(self.Panel_prefab, "Label_record")
    self.Image_hidden_item = TFDirector:getChildByPath(self.Panel_prefab, "Image_hidden_item")
    self.Panel_hidden_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_hidden_item")
    self.Image_dir_item = TFDirector:getChildByPath(self.Panel_prefab, "Image_dir_item")
    self.Button_mapItem = TFDirector:getChildByPath(self.Panel_prefab, "Button_mapItem")
    self.Panel_taskItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_taskItem")

    self.Image_path = TFDirector:getChildByPath(self.Panel_prefab, "Image_path")
    local Panel_path = TFDirector:getChildByPath(self.Panel_root, "Panel_path")
    self.pathItem_ = {}
    for i, v in ipairs(Panel_path:getChildren()) do
        v:setBackGroundColorType(0)
        local name = v:getName()
        local prefix, id = string.match(name, "(.*)_(.*)")
        local pathItem = self.Image_path:clone()
        pathItem:hide()
        pathItem:setName("pathItem")
        pathItem:setScale(0.7)
        pathItem:setPosition(ccp(0,0))
        v:addChild(pathItem)
        self.pathItem_[tonumber(id)] = v
    end

    self:initUILogic()
end

function CourageMainView:onShow()
    self.super.onShow(self)
    self.Panel_corner_btns:show()
    self.Button_chat:show()
    if self.bgm then
        AudioExchangePlay.playBGM(self,true,self.bgm)
    end


    local isNewChapter = CourageDataMgr:isNewOpenChapter()
    local chapterId,areaId = CourageDataMgr:getCurLocation()
    local cfg = CourageDataMgr:getMazeDMgrCfg(chapterId)
    if isNewChapter and chapterId and cfg and cfg.startDating ~= 0 then
        return
    end

    self:timeOut(function()
        GameGuide:checkGuide(self);
    end,0.1)
end

function CourageMainView:onClose()
    self.super.onHide(self)
    if self.voiceHandle then
        TFAudio.stopEffect(self.voiceHandle)
    end
end

function CourageMainView:initUILogic()

    self:updateBg()
    self:updateRecord()
    self:updateApInfo()
    self:updateMap()
    self:updateTask()

    self:checkStartInfo()

    --local isNewChapter = CourageDataMgr:isNewOpenChapter()
    --if isNewChapter then
    --    local chapterId,areaId = CourageDataMgr:getCurLocation()
    --    local cfg = CourageDataMgr:getMazeDMgrCfg(chapterId)
    --    if chapterId and cfg then
    --        self:timeOut(function()
    --            self:playDating(cfg.startDating)
    --        end,0.1)
    --    else
    --        CourageDataMgr:setNewChapterFlage(false)
    --        self:checkStartInfo()
    --    end
    --else
    --    CourageDataMgr:setNewChapterFlage(false)
    --    self:checkStartInfo()
    --end
end

function CourageMainView:checkStartInfo()

    local apInfo = CourageDataMgr:getApInfo()
    if apInfo and apInfo.value and apInfo.value <= 0 then
        ---是否是结局
        local chapterId,areaId = CourageDataMgr:getCurLocation()
        local mgrCfg = CourageDataMgr:getMazeDMgrCfg(chapterId)
        if mgrCfg then
            self:playDating(mgrCfg.endDating)
        end
    else
        ---是否有未完成事件
        local curEvrntId = CourageDataMgr:getCurEventId()
        local eventCfg = CourageDataMgr:getEventCfg(curEvrntId)
        if eventCfg then
            ---是否有约会
            local datingRuleId = eventCfg.datingRuleId
            if datingRuleId == 0 then
                self:showEvent(eventCfg)
            else
                self.triggerDating = true
                self:playDating(datingRuleId)
            end
        else
            if curEvrntId and curEvrntId > 0 then
                Box("在MazeDScriptMgr中找不到事件ID："..tostring(curEvrntId))
            end
        end
    end
end

function CourageMainView:updateTask(update,mainLog,logId)
    self.ListView_task:removeAllItems()

    self:updateMainLog()
    self:updateBranchLog()
    self.ListView_task:jumpToBottom()

    if not update or not mainLog or not logId then
        return
    end

    local cfg = CourageDataMgr:getLogCfgData(mainLog.logId)
    if not cfg then
        return
    end
    if cfg.showMap ~= 0 and (not mainLog.finished) then
        CourageDataMgr:Send_GetMapInfo()
        Utils:openView("courage.CourageBigMap",true)
    end

end

----主线
function CourageMainView:updateMainLog()
    local mainLogInfo = CourageDataMgr:getMainLogInfo()

    table.sort(mainLogInfo,function(a,b)
        local cfgA = CourageDataMgr:getLogCfgData(a.logId)
        local cfgB = CourageDataMgr:getLogCfgData(b.logId)
        return cfgA.priority > cfgB.priority
    end)

    local curLogIngo
    for k,v in ipairs(mainLogInfo) do
        if not v.finished then
            curLogIngo = v
            break
        end
    end

    if not curLogIngo then
        return
    end

    local taskItem = self.Panel_taskItem:clone()
    local Label_main = taskItem:getChildByName("Label_main")
    local Label_task = taskItem:getChildByName("Label_task")
    local Image_titlebg = taskItem:getChildByName("Image_titlebg")
    Image_titlebg:setTexture("ui/activity/courage/main/new/009.png")
    local cfg = CourageDataMgr:getLogCfgData(curLogIngo.logId)
    if not cfg then
        return
    end

    Label_main:setText(cfg.logBase)
    local subLogInfos = CourageDataMgr:getSubLogCfgByMainCid(curLogIngo.logId)
    local subLogInfo = subLogInfos[#subLogInfos]
    if subLogInfo then
        self:setNewText(Label_task,subLogInfo.logBase,42,"...")
    else
        Label_task:setText("")
    end

    self.ListView_task:pushBackCustomItem(taskItem)
end

function CourageMainView:setNewText(labelObj,labelStr,limitHeight,otherStr)


    local function getStrMap(str)
        local strTab = {}
        for uchar in string.gmatch(str, "[%z\1-\127\194-\244][\128-\191]*") do
            strTab[#strTab+1] = uchar
        end
        return strTab
    end

    local strMap = getStrMap(labelStr)

    labelObj:setDimensions(160,0)
    labelObj:setText(labelStr)

    if labelObj:getContentSize().height <= limitHeight then
        return
    end

    local setStr = ""
    local tempStr2 = ""
    for k,v in ipairs(strMap) do
        local tempStr = tempStr2..v
        labelObj:setString(tempStr..otherStr)
        if labelObj:getContentSize().height > limitHeight then
            break
        else
            tempStr2 = tempStr
        end
    end
    setStr = setStr .. tempStr2 .. otherStr
    labelObj:setString(setStr)

end

function CourageMainView:updateBranchLog()

    local branchLogInfo = CourageDataMgr:getBranchLogInfo()
    table.sort(branchLogInfo,function(a,b)
        local stateA = a.finished and  1 or 0
        local stateB = b.finished and  1 or 0
        if stateA == stateB then
            if a.time == b.time then
                return a.logId > b.logId
            else
                return a.time > b.time
            end
        else
            return stateA < stateB
        end
    end)

    local curLogIngo = branchLogInfo[1]
    if not curLogIngo then
        return
    end

    if curLogIngo.finished then
        return
    end

    local cfg = CourageDataMgr:getLogCfgData(curLogIngo.logId)
    if not cfg then
        return
    end

    local taskItem = self.Panel_taskItem:clone()
    local Image_titlebg = taskItem:getChildByName("Image_titlebg")
    Image_titlebg:setTexture("ui/activity/courage/main/new/010.png")
    local Label_main = taskItem:getChildByName("Label_main")
    local Label_task = taskItem:getChildByName("Label_task")
    Label_main:setText(cfg.logBase)

    local subLogInfos = CourageDataMgr:getSubLogCfgByMainCid(curLogIngo.logId)
    local subLogInfo = subLogInfos[#subLogInfos]
    if subLogInfo then
        self:setNewText(Label_task,subLogInfo.logBase,42,"...")
    else
        Label_task:setText("")
    end

    self.ListView_task:pushBackCustomItem(taskItem)
end

function CourageMainView:updateBg()
    local chapterId,areaId = CourageDataMgr:getCurLocation()
    if not chapterId or not areaId then
        return
    end
    local mapCfg = CourageDataMgr:getMapCfgInfo(chapterId,areaId)
    if not mapCfg then
        return
    end
    local scale = mapCfg.scale or 1
    self.Image_back:setTexture("scene/bg/"..mapCfg.bgres..".png")
    self.Image_front:setTexture("scene/bg/"..mapCfg.bgres..".png")
    self.Image_back:setScale(scale)
    self.Image_front:setScale(scale)

    if mapCfg.bgm ~= "" and self.bgm ~= mapCfg.bgm then
        AudioExchangePlay.playBGM(self,true,mapCfg.bgm)
        self.bgm = mapCfg.bgm
    end

end

function CourageMainView:updatePath()
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

function CourageMainView:updateMap()

    self.Image_map:setScale(self.mapScale)
    self:setGridMapLimit()

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
            self.mapItem_[v.id] = {root = contentItem,item = mapItem,data = v}
            self:updateMapItem(v)
        end
    end
    local curmazeDId,areaId = CourageDataMgr:getCurLocation()
    self:moveToLevel(areaId,true)

    self:updatePath()
end

function CourageMainView:getMapContaierPos(position)
    local mapPosX = (0 - position.x)*self.mapScale
    local mapPosY = (0 - position.y)*self.mapScale
    return ccp(mapPosX, mapPosY)
end

function CourageMainView:moveToLevel(mapId,isInit,callback)

    if not self.mapItem_[mapId] then
        return
    end
    local position = self.mapItem_[mapId].root:getPosition()

    position = self:getMapContaierPos(position)
    position = self:detectEdges(position)
    dump(position)
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

function CourageMainView:updateMapItem(data)

    local mapItem = self.mapItem_[data.id]
    if not mapItem then
        return
    end

    local Image_item = mapItem.root:getChildByName("Image_item")

    mapItem.data = data
    local Label_btn = mapItem.item:getChildByName("Label_btn")
    --Label_btn:setText(data.areaName)
    Label_btn:setText("")
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

function CourageMainView:setGridMapLimit()

    local winSize = self.Panel_miniMap:getContentSize()
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

function CourageMainView:detectEdges(point)

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


----刷新事件记录
function CourageMainView:updateRecord(isInit)
    local recordItem = self.Label_record:clone()
    recordItem:setTextById(63601)
    recordItem:setDimensions(self.recordViewSize.width, 0)
    self.List_record:pushBackCustomItem(recordItem)
    if isInit then
        self.List_record:scrollToBottom(0.5)
    else
        self.List_record:jumpToBottom()
    end
end

----刷新ap值
function CourageMainView:updateApInfo()

    ----ap动画
    self:updateApValue()
end

function CourageMainView:updateApValue()

    local apInfo = CourageDataMgr:getApInfo()
    if not apInfo then
        return
    end
    local cur,max = apInfo.value or 0 ,apInfo.limit or 0
    cur = cur >= 0 and cur or 0
    max = max == 0 and 1 or max
    local percent = math.floor(cur/max*100)
    self.LoadingBar_ap:setPercent(percent)
    self.Label_ap_value:setText(cur.."/"..max)

    local spineName = "xinzang_fense_jiangkang"
    local soundId = 5036
    if cur <= math.floor(max*0.6) and cur > math.floor(max*0.3) then
        spineName = "xinzang_huangse_xuruo"
        soundId = 5034
    elseif cur <= math.floor(max*0.3) then
        spineName = "xinzang_heise_binsi"
        soundId = 5035
    end
    if self.playApSpineName ~= spineName then
        self.playApSpineName = spineName
        self.Spine_ap:play(spineName,true)
        Utils:playSound(soundId)
    end

end

function CourageMainView:flyItem(itemList)

    self.itemList = itemList or {}
    if not next(self.itemList) then
        return
    end

    local itemId,itemNum = self.itemList[1].id,self.itemList[1].num
    local cfg = GoodsDataMgr:getItemCfg(itemId)
    if not cfg then
        return
    end

    self.Panel_result_item:setVisible(true)

    self:flyItemIcon(1)
    self:flyItemTip(1)
end

function CourageMainView:flyItemTip(index)

    local curItem = self.itemList[index]
    if not curItem then
        return
    end
    local itemId,itemNum = curItem.id,curItem.num
    local cfg = GoodsDataMgr:getItemCfg(itemId)
    if not cfg then
        return
    end

    self.itemtipFly = true
    local itemTipClone = self.Label_item_tip:clone()
    itemTipClone:setVisible(true)
    itemTipClone:setOpacity(0)
    itemTipClone:setPosition(ccp(-100,-40))
    self.Panel_result_item:addChild(itemTipClone)
    local Label_item_name = itemTipClone:getChildByName("Label_item_name")
    local Label_item_num = itemTipClone:getChildByName("Label_item_num")
    Label_item_name:setTextById(cfg.nameTextId)
    local w = Label_item_name:getContentSize().width
    Label_item_num:setText("*"..itemNum)
    Label_item_num:setPositionX(71 + w + 1)
    local act = CCSequence:create({
        CCDelayTime:create(0.5),
        CCFadeIn:create(0.3),
        CCDelayTime:create(0.5),
        CCSpawn:create({
            CCMoveTo:create(1,ccp(-100,10)),
            CCFadeOut:create(1)
        }),
        CCCallFunc:create(function()
            itemTipClone:removeFromParent()
            local nextIndex = index + 1
            if nextIndex <= #self.itemList then
                self:flyItemTip(nextIndex)
            else
                self.itemtipFly = false
                if not self.itemImgFly then
                    self.Panel_result_item:hide()
                end
            end
        end)
    })
    itemTipClone:runAction(act)
end

function CourageMainView:flyItemIcon(index)

    local curItem = self.itemList[index]
    if not curItem then
        return
    end
    local itemId,itemNum = curItem.id,curItem.num
    local cfg = GoodsDataMgr:getItemCfg(itemId)
    if not cfg then
        return
    end
    self.itemImgFly = true
    local Image_item = self.Image_result_item:clone()
    Image_item:setScale(1.5)
    Image_item:setOpacity(0)
    self.Panel_result_item:addChild(Image_item)
    local bagBtnPos = self.Button_bag:getPosition()
    bagBtnPos = self.Button_bag:getParent():convertToWorldSpaceAR(bagBtnPos)
    local pos = self.Panel_result_item:convertToNodeSpaceAR(bagBtnPos)

    Image_item:setTexture(cfg.icon)
    Image_item:setVisible(true)

    local act1 = EaseSineIn:create(CCMoveTo:create(1,pos))
    local act2 = CCScaleTo:create(1,0.4)
    local act3 = CCSpawn:create({act1,act2});
    local act4 = CCSequence:create({CCDelayTime:create(0.5),CCFadeIn:create(0.3),CCDelayTime:create(0.5),act3,CCCallFunc:create(function()
        Image_item:stopAllActions()
        Image_item:setVisible(false)
        Image_item:setPosition(self.resultItemPos)
        Image_item:setScale(1.5)
        self:doFlashAndScaleAction(self.Button_bag,0.5,1.2)
        Image_item:removeFromParent()

        local nextIndex = index + 1
        if nextIndex <= #self.itemList then
            self:flyItemIcon(nextIndex)
        else
            self.itemImgFly = false
            if not self.itemtipFly then
                self.Panel_result_item:hide()
            end
        end
    end)})
    Image_item:runAction(act4)
end

function CourageMainView:doFlashAndScaleAction(node, duration, scale)
    if node == nil then return end
    local act1 =  CCScaleBy:create(duration, scale)
    local act2 = act1:reverse()
    local temp1 = CCSequence:create({EaseSineIn:create(act1), EaseSineOut:create(act2)})

    local act3 = CCFadeTo:create(duration, 0)
    local act4 = CCFadeTo:create(duration, 255)
    local temp2 = CCSequence:create({EaseSineIn:create(act3), EaseSineOut:create(act4)})
    local spawn = CCSpawn:create({temp1, temp2})

    node:runAction(spawn)
end

function CourageMainView:onRecvNewCourageItem(itemList)

    itemList = itemList or {}
    if not next(itemList) then
        return
    end
    self:flyItem(itemList)

end

function CourageMainView:startSearch()

    self.Panel_mask:setVisible(true)
    self.Panel_disable_btns:setVisible(true)
    local hiddenPL = self.Panel_hide_item:isVisible()
    if hiddenPL then
        self.Panel_hide_item:setVisible(false)
        self.Panel_hide_item:removeAllChildren()
    end

    Utils:playSound(5024)

    local scale = self.Image_front:getScale()
    self.Spine_light:setVisible(true)

    self.Image_front:setOpacity(255)
    local act1 = CCMoveBy:create(0.5,ccp(0,-20))
    local act2 =  CCScaleBy:create(0.5, 1.1)
    local act3 = act1:reverse()
    local act4 = CCSpawn:create({act1,act2})
    local act5 = CCSpawn:create({act3,act2})
    local act6 = CCSpawn:create({act1,act2,CCFadeOut:create(0.8)})
    local act7 = CCSequence:create({act4,act5,act6,CCCallFunc:create(function()
        self.Image_front:stopAllActions()
        self.Image_front:setPosition(ccp(0,0))
        self.Image_front:setScale(scale)
        self.Spine_light:setVisible(false)
        self.Panel_disable_btns:setVisible(false)
        self:triggerEvent()
    end)})
    self.Image_front:runAction(CCRepeatForever:create(act7))

end

function CourageMainView:triggerEvent()

    local triggerId = CourageDataMgr:getEventID()
    local eventCfg = CourageDataMgr:getEventCfg(triggerId)
    if not eventCfg then
        if triggerId then
            Box("在MazeDScriptMgr中找不到事件ID："..tostring(triggerId))
        end
        return
    end

    ---是否有约会
    local datingRuleId = eventCfg.datingRuleId
    if datingRuleId == 0 then
        self:showEvent(eventCfg)
    else
        self.triggerDating = true
        self:playDating(datingRuleId)
    end

end

---展示事件表现
function CourageMainView:showEvent(eventCfg)

    if not eventCfg then
        return
    end
    dump("Send_finishEventSend_finishEventSend_finishEvent:"..tostring(eventCfg.id))
    GameGuide:checkGuide(self)
    CourageDataMgr:Send_finishEvent(eventCfg.id)
    if eventCfg.message ~= 0 then
        local str = TextDataMgr:getText(eventCfg.message)
        self:insertMessage(str)
    end

    local time = 0.5
    ---apearType: 99-移动事件 12-提示事件 13-发现疑点 11 什么也没发生
    local apearType = eventCfg.apearType
    if apearType == 99 then
        self:findNewDirection(eventCfg.id,eventCfg.moveEventParam)
    elseif apearType == 12 then
    elseif apearType == 13 then
        Utils:playSound(5025)
        self:findHiddenPoint(eventCfg.doubtParam)
        time = 2
    elseif apearType == 11 then
        --self.Panel_tip_message:setVisible(true)
        --self.Label_tip:setText("什么也没发生")
    end

    self:timeOut(function()
        self.Panel_mask:setVisible(false)
    end ,time)

end

function CourageMainView:removeTipMessage()
    local item = self.ListView_message:getItem(1)
    if item then
        item:runAction(CCSequence:create({
            CCDelayTime:create(4),
            CCDelayTime:create(4),
            CCFadeOut:create(0.2),
            CCCallFunc:create(function()
                self.ListView_message:removeItem(1)
                self:removeTipMessage()
            end)
        }))
    end
end

function CourageMainView:insertMessage(message)
    local messageItem = self.messageItem:clone()
    messageItem:show()
    local Image_head_bord =  TFDirector:getChildByPath(messageItem, "Image_head_bord")
    local Label_tip = TFDirector:getChildByPath(messageItem, "Label_tip")
    local Spine_tishi = TFDirector:getChildByPath(messageItem, "Spine_tishi")
    Image_head_bord:setScale(0.2)
    Label_tip:setOpacity(0)
    Label_tip:setText(message)
    local w = Label_tip:getContentSize().width
    Label_tip:setPositionX(-w+5)

    local action = CCSpawn:create({
        CCFadeIn:create(0.2),
        CCMoveTo:create(0.2,ccp(13,0))
    })
    Label_tip:runAction(action)

    Spine_tishi:setVisible(true)
    Spine_tishi:play("nangua_tishikuang",false)
    Spine_tishi:addMEListener(TFARMATURE_COMPLETE,function()
        Spine_tishi:removeMEListener(TFARMATURE_COMPLETE)
    end)

    --local act1 = CCScaleTo:create(0.2,1)
    --local act2 = CCRotateTo:create(0.1,10)
    --local act3 = CCRotateTo:create(0.1,-10)
    --local act4 = CCRepeat:create(CCSequence:create({act2,act3}),3)
    --local act5 = CCCallFunc:create(function()
    --    Spine_tishi:setVisible(true)
    --    Spine_tishi:play("nangua_tishikuang",false)
    --    Spine_tishi:addMEListener(TFARMATURE_COMPLETE,function()
    --        Spine_tishi:removeMEListener(TFARMATURE_COMPLETE)
    --        local action = CCSpawn:create({
    --            CCFadeIn:create(0.2),
    --            CCMoveTo:create(0.2,ccp(13,0))
    --        })
    --        Label_tip:runAction(action)
    --    end)
    --end)
    --Image_head_bord:runAction(CCSequence:create({act1,act4,act5}))

    self.ListView_message:pushBackCustomItem(messageItem)
    self.ListView_message:scrollToBottom(0.5)
    self:removeTipMessage()
end


---发现疑点
function CourageMainView:findHiddenPoint(doubtParam)

    local hiddenInfo = {}
    for k,v in pairs(doubtParam) do
        table.insert(hiddenInfo,{target = k,pos = ccp(v.x,v.y),pic = v.pic})
    end

    self.Panel_hide_item:setVisible(true)
    for k,v in ipairs(hiddenInfo) do
        local hiddenItem = self.Panel_hidden_item:clone()
        hiddenItem:setPosition(v.pos)
        --local Spine_star = hiddenItem:getChildByName("Spine_star")
        --Spine_star:play("tansuo_yidian",true)
        local spine = SkeletonAnimation:create("effect/xingxing_UI/xingxing_UI")
        spine:setPosition(ccp(0,0))
        spine:play("tansuo_yidian",true)
        spine:setScale(3)
        hiddenItem:addChild(spine)
        self.Panel_hide_item:addChild(hiddenItem)
        hiddenItem:onClick(function()
            self.triggerDating = true
            self:playDating(v.target)
            hiddenItem:removeFromParent()
        end)
    end
end

---发现新方向
function CourageMainView:findNewDirection(eventId,moveEventParam)
    self.Panel_new_direction:setVisible(true)
    self.Button_jump:setTextureNormal(self.actBtnImg[2])
    self.Label_jumpbtn:setText(self.actBtnText[2])
    self.Panel_dir_mask:stopAllActions()
    self.Panel_dir_mask:show()
    local act = CCSequence:create({
        CCDelayTime:create(1),
        CCCallFunc:create(function()
            self.Panel_dir_mask:stopAllActions()
            self.Panel_dir_mask:hide()
        end)
    })
    self.Panel_dir_mask:runAction(act)

    local dirInfo = {}
    for k,v in pairs(moveEventParam) do
        dirInfo[v.type] = {target = k,pos = ccp(v.x,v.y),eventId = eventId, type = v.type}
    end

    for k,dirItem in ipairs(self.dirItem_) do
        local dirData = dirInfo[k]
        if not dirData then
           dirItem:setVisible(false)
        else
           dirItem:setVisible(true)
            local btn = TFDirector:getChildByPath(dirItem, "Button_item")
            local Label_name = TFDirector:getChildByPath(dirItem, "Label_name")
            local cfg = CourageDataMgr:getMapCfgByCid(dirData.target)
            Label_name:setText(cfg.areaName)
            btn:onClick(function()

                local chapterId,areaId = CourageDataMgr:getCurLocation()
                if not chapterId or not areaId then
                    return
                end

                local curAreaInfo = CourageDataMgr:getAreaInfo(areaId)
                if not curAreaInfo then
                    return
                end

                ---检测目标区域
                local targetAreaInfo = CourageDataMgr:getAreaInfo(dirData.target)
                if not targetAreaInfo then
                    return
                end

                if targetAreaInfo.isDevil then
                    Utils:showTips(13311707)
                    return
                end

                ---检查路径
                local couldPass = true
                for _,info in ipairs(curAreaInfo.roadInfoList) do
                    if areaId == info.startAreaId and dirData.target == info.endAreaId then
                        couldPass = info.unlocked
                        break
                    end
                end

                if not couldPass then
                    Utils:showTips(13311708)
                    return
                end

                CourageDataMgr:Send_moveOtherArea(dirData.target,eventId)
                self.Panel_new_direction:setVisible(false)
                self.Button_jump:setTextureNormal(self.actBtnImg[1])
                self.Label_jumpbtn:setText(self.actBtnText[1])
            end)
        end
    end
end

function CourageMainView:playEndDating()
    local apInfo = CourageDataMgr:getApInfo()
    if not apInfo then
        return
    end
    local cur,max = apInfo.value or 0,apInfo.limit or 0
    if cur <= 0 then
        local chapterId,areaId = CourageDataMgr:getCurLocation()
        local mgrCfg = CourageDataMgr:getMazeDMgrCfg(chapterId)
        if mgrCfg then
            self:playDating(mgrCfg.endDating)
        end
    end
end

function CourageMainView:onRecvAfterAskMove()
    self:startSearch()
end

function CourageMainView:onCompleteStartDating()
    GameGuide:checkGuide(self)
    self:checkStartInfo()
end

function CourageMainView:onDatingCompleted(id)

    if not self.triggerDating then
        return
    end

    local sMsg = DatingDataMgr:getDatingSettlementMsg()
    if sMsg.rewards and #sMsg.rewards > 0 then
        self:flyItem(sMsg.rewards)
    end

    local triggerId = CourageDataMgr:getEventID()
    local eventCfg = CourageDataMgr:getEventCfg(triggerId)
    if not eventCfg then
        if triggerId then
            Box("在MazeDScriptMgr中找不到事件ID："..tostring(triggerId))
        end
        return
    end
    self:showEvent(eventCfg)

    --local gameParam = eventCfg.gameParam
    --if not next(gameParam) then
    --
    --else
    --    self:goMiniGame(eventCfg)
    --end
end

function CourageMainView:onRecvFinishEvent()

    self:updateApInfo()
    self:playEndDating()

end

function CourageMainView:onRecvUpdateMap(isAfterOtherArea)
    self:updateBg()
    self:updateMap()

    if isAfterOtherArea then
        local chapterId,areaId = CourageDataMgr:getCurLocation()
        local mapCfg = CourageDataMgr:getMapCfgByCid(areaId)
        if mapCfg and mapCfg.areaEffect and mapCfg.areaEffect ~= "" then
            Utils:playSound(mapCfg.changeSound)

            local layerName = {"CourageBigMap","CourageBagView","CourageComposeView"}
            for k,v in ipairs(layerName) do
                local isLayerInQueue,layer = AlertManager:isLayerInQueue(v)
                if isLayerInQueue then
                    AlertManager:closeLayer(layer)
                end
            end

            self:aferMoveToOther(mapCfg.areaEffect,mapCfg.Coordinate)
        end
    end
end

function CourageMainView:goMiniGame(eventCfg)

    if not eventCfg then
        return
    end
    local uiName = "courage."..eventCfg.gameParam.game
    if uiName == "courage.CourageDirGame" then
        local layer = require("lua.logic.courage.CourageDirGame"):new(eventCfg)
        AlertManager:addLayer(layer, AlertManager.BLOCK)
        AlertManager:show()
    else
        Utils:openView(uiName,eventCfg)
    end
end

function CourageMainView:miniGameShowResult(result)
    self:insertMessage(result)
end

function CourageMainView:miniGameMove(callBack)

    self.Image_front:setOpacity(255)
    local scale = self.Image_front:getScale()
    local act1 = CCMoveBy:create(0.8,ccp(0,-20))
    local act2 =  CCScaleBy:create(0.8, 1.1)
    local act3 = act1:reverse()
    local act4 = CCSpawn:create({act1,act2})
    local act5 = CCSpawn:create({act3,act2})
    local act6 = CCSpawn:create({act1,act2,CCFadeOut:create(1)})
    local act7 = CCSequence:create({act4,act5,act6,CCCallFunc:create(function()
        self.Image_front:stopAllActions()
        self.Image_front:setPosition(ccp(0,0))
        self.Image_front:setScale(scale)
        if callBack then
            callBack()
        end

    end)})
    self.Image_front:runAction(CCRepeatForever:create(act7))
end

--function CourageMainView:aferMoveToOther()
--    self:hideTopBar()
--    self.Spine_door:setVisible(true)
--    self.Spine_door:play("animation",false)
--    self.Spine_door:addMEListener(TFARMATURE_COMPLETE,function()
--        self.Spine_door:removeMEListener(TFARMATURE_COMPLETE)
--        self:showTopBar()
--        self.Spine_door:setVisible(false)
--    end)
--end

function CourageMainView:aferMoveToOther(spineName,pos)

    self.Panel_mask:setVisible(true)
    self.Spine_change = SkeletonAnimation:create(spineName)
    self.Spine_change:play("animation",false)
    self.Spine_change:setPosition(ccp(pos.x,pos.y))
    self.Spine_change:setAnchorPoint(ccp(0,0))
    self.Panel_root:addChild(self.Spine_change,1)
    self.Spine_change:addMEListener(TFARMATURE_COMPLETE,function()
        self.Spine_change:removeMEListener(TFARMATURE_COMPLETE)
        self.Spine_change:removeFromParent()
        self.Panel_mask:setVisible(false)
        self:playEndDating()
    end)
end

function CourageMainView:playDating(datingRuleId)
    if datingRuleId == 0 then
        return
    end
    FunctionDataMgr:jStartDating(datingRuleId)
    self.Panel_corner_btns:hide()
    self.Button_chat:hide()
end

function CourageMainView:onRecvCourageEnd()
    CourageDataMgr:Send_GetBaseInfo()
    AlertManager:closeLayer(self)
end

------新手引导------
---移动
function CourageMainView:excuteGuideFunc30001(guideFuncId)
    local targetNode = self.Panel_touch
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

---合成
function CourageMainView:excuteGuideFunc30002(guideFuncId)
    local targetNode = self.Button_compose
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

---背包
function CourageMainView:excuteGuideFunc30006(guideFuncId)
    local targetNode = self.Button_bag
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

---事件
function CourageMainView:excuteGuideFunc30010(guideFuncId)
    local targetNode = self.Button_check
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

---地图
function CourageMainView:excuteGuideFunc30012(guideFuncId)
    local targetNode = self.Panel_touchMiniMap
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

function CourageMainView:excuteGuideFunc30014(guideFuncId)
    local targetNode = self.Button_jump
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

function CourageMainView:showDirection()
    local visible = self.Panel_new_direction:isVisible()
    self.Panel_new_direction:setVisible(not visible)
    local img = visible and self.actBtnImg[1] or self.actBtnImg[2]
    self.Button_jump:setTextureNormal(img)
    local text = visible and self.actBtnText[1] or self.actBtnText[2]
    self.Label_jumpbtn:setText(text)
    local chapterId,areaId = CourageDataMgr:getCurLocation()
    if not chapterId or not areaId then
        return
    end

    local mapCfg = CourageDataMgr:getMapCfgInfo(chapterId,areaId)
    if not mapCfg then
        return
    end
    local moveEventParam = mapCfg.moveEventParam
    local dirInfo = {}

    for k,v in pairs(moveEventParam) do
        dirInfo[v.type] = {target = k,type = v.type}
    end

    local nextCost = mapCfg.areaNext

    for k,dirItem in ipairs(self.dirItem_) do
        local dirData = dirInfo[k]
        if not dirData then
            dirItem:setVisible(false)
        else
            dirItem:setVisible(true)
            local btn = TFDirector:getChildByPath(dirItem, "Button_item")
            local Label_name = TFDirector:getChildByPath(dirItem, "Label_name")
            local cfg = CourageDataMgr:getMapCfgByCid(dirData.target)
            Label_name:setText(cfg.areaName)
            btn:onClick(function()

                local cost = nextCost[dirData.target]
                if not cost then
                    return
                end

                local apInfo = CourageDataMgr:getApInfo()
                if not apInfo then
                    return
                end
                local cur,max = apInfo.value or 0,apInfo.limit or 0
                if cur <= cost then
                    Utils:showTips(13311178)
                    return
                end

                local chapterId,areaId = CourageDataMgr:getCurLocation()
                if not chapterId or not areaId then
                    return
                end

                local curAreaInfo = CourageDataMgr:getAreaInfo(areaId)
                if not curAreaInfo then
                    return
                end

                ---检测目标区域
                local targetAreaInfo = CourageDataMgr:getAreaInfo(dirData.target)
                if not targetAreaInfo then
                    return
                end

                if targetAreaInfo.isDevil then
                    Utils:showTips(13311707)
                    return
                end

                ---检查路径
                local couldPass = true
                for _,info in ipairs(curAreaInfo.roadInfoList) do
                    if areaId == info.startAreaId and dirData.target == info.endAreaId then
                        couldPass = info.unlocked
                        break
                    end
                end

                if not couldPass then

                    local startCfg = CourageDataMgr:getMapCfgByCid(areaId)
                    local endCfg = CourageDataMgr:getMapCfgByCid(dirData.target)
                    if not startCfg or not endCfg then
                        return
                    end
                    local pathKey = startCfg.uiMapId.."-"..endCfg.uiMapId
                    local pathId = CourageDataMgr:getPathInfo(pathKey)
                    local roadCfg = CourageDataMgr:getRoadCfg(pathId)
                    if not roadCfg then
                        return
                    end
                    Utils:showTips(roadCfg.lockNotice)
                    return
                end

                CourageDataMgr:Send_moveOtherArea(dirData.target,0)
                self.Panel_new_direction:setVisible(false)
                self.Button_jump:setTextureNormal(self.actBtnImg[1])
                self.Label_jumpbtn:setText(self.actBtnText[1])

                self.Panel_hide_item:setVisible(false)
                self.Panel_hide_item:removeAllChildren()
            end)
        end
    end

end

function CourageMainView:onRecvRescueHero()

end

function CourageMainView:exitGameConfirm()

    local function confirmCall()
        local chapterId,areaId = CourageDataMgr:getCurLocation()
        local mgrCfg = CourageDataMgr:getMazeDMgrCfg(chapterId)
        if mgrCfg then
            self:playDating(mgrCfg.breakDating)
        end
    end

    local rstr = TextDataMgr:getTextAttr(13311185)
    local formatStr = rstr and rstr.text or ""
    local showData = {}
    showData.tittle = 13311184
    showData.content = formatStr
    showData.confirmCall = confirmCall
    showData.showCancle = true
    showData.showClose = false
    showData.showPopAnim = false
    Utils:openView("common.ReConfirmTipsView", showData)
end

function CourageMainView:exitGame()

    local function confirmCall()
        AlertManager:closeLayer(self)
    end
    local function cancleCall()
        self:exitGameConfirm()
    end
    local rstr = TextDataMgr:getTextAttr(13311180)
    local formatStr = rstr and rstr.text or ""
    local showData = {}
    showData.tittle = 13311179
    showData.content = formatStr
    showData.confirmCall = confirmCall
    showData.cancleCall = cancleCall
    showData.cancleId = 13311182
    showData.confirmId = 13311183
    showData.showClose = true
    showData.showCancle = true
    showData.showPopAnim = false
    Utils:openView("common.ReConfirmTipsView", showData)

end

function CourageMainView:registerEvents()

    EventMgr:addEventListener(self, EV_COURAGE.EV_UPDATE_EVENT_LOG, handler(self.updateTask, self))
    EventMgr:addEventListener(self, EV_COURAGE.EV_UPDATA_MAP, handler(self.onRecvUpdateMap, self))
    EventMgr:addEventListener(self, EV_COURAGE.EV_UPDATE_FINISH, handler(self.onRecvFinishEvent, self))
    EventMgr:addEventListener(self, EV_GET_NEW_COURAGE_ITEM, handler(self.onRecvNewCourageItem, self))
    EventMgr:addEventListener(self, EV_COURAGE.EV_ASK_MOVE, handler(self.onRecvAfterAskMove, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.datingcompleted, handler(self.onDatingCompleted, self))
    EventMgr:addEventListener(self, EV_FUBEN_PHASECOMPLETE, handler(self.onCompleteStartDating, self))
    EventMgr:addEventListener(self, EV_COURAGE.EV_UPDATE_AP, handler(self.updateApInfo, self))

    EventMgr:addEventListener(self, EV_COURAGE.EV_MINIGAME_MOVE, handler(self.miniGameMove, self))
    EventMgr:addEventListener(self, EV_COURAGE.EV_MINIGAME_RESULT, handler(self.miniGameShowResult, self))

    EventMgr:addEventListener(self, EV_COURAGE.EV_COURAGE_END, handler(self.onRecvCourageEnd, self))
    EventMgr:addEventListener(self, EV_COURAGE.EV_RESCUR_HERO, handler(self.onRecvRescueHero, self))

    self.Button_compose:onClick(function()
        GameGuide:checkGuideEnd(self.guideFuncId)
        Utils:openView("courage.CourageComposeView")
    end)

    self.Button_bag:onClick(function()
        GameGuide:checkGuideEnd(self.guideFuncId)
        Utils:openView("courage.CourageBagView")
    end)

    self.Panel_touch:onClick(function()
        GameGuide:checkGuideEnd(self.guideFuncId)
        self.Panel_hide_item:setVisible(false)
        self.Panel_hide_item:removeAllChildren()

        self.Panel_new_direction:setVisible(false)
        self.Button_jump:setTextureNormal(self.actBtnImg[1])
        self.Label_jumpbtn:setText(self.actBtnText[1])

        local apInfo = CourageDataMgr:getApInfo()
        local cur,max = apInfo.value or 0,apInfo.limit or 0
        if cur <= 0 then
            Utils:showTips("ap值不足，不能继续探索")
            return
        end

        if not self.isSearch then
            CourageDataMgr:Send_AskMove()
        end
    end)

    self.Panel_result_item:onClick(function()
    end)

    self.Button_detail:onClick(function()
        Utils:openView("courage.CourageEventRecordView",1)
    end)

    self.Button_check:onClick(function()
        GameGuide:checkGuideEnd(self.guideFuncId)
        Utils:openView("courage.CourageEventRecordView",2)
    end)

    self.Panel_touchMiniMap:onClick(function()
        GameGuide:checkGuideEnd(self.guideFuncId)
        CourageDataMgr:Send_GetMapInfo()
        Utils:openView("courage.CourageBigMap")
        --local eventCfg = {}
        --eventCfg.gameRes = "courageWireGame1"
        --Utils:openView("courage.CourageLightGame",eventCfg)
        --Utils:openView("courage.CourageSwitchGame",eventCfg)
        --Utils:openView("courage.CourageDirGame")
        --Utils:openView("courage.CourageWireGame",eventCfg)
        --local layer = require("lua.logic.courage.CourageDirGame"):new()
        --AlertManager:addLayer(layer, AlertManager.BLOCK)
        --AlertManager:show()
        --Utils:openView("courage.CourageEndView")
        --local ani_ = {"effect/danmen/danmen","effect/shuangmen/shuangmen","effect/tuilamen/tuilamen","effect/miwu/miwu"}
        --local index = math.random(1,4)
        --self:aferMoveToOther(ani_[index])
        --FunctionDataMgr:jStartDating(116)
        --local item = {}
        --table.insert(item,{id = 555015, num = 1})
        --table.insert(item,{id = 555015, num = 1})
        --self:flyItem(item)
        --FunctionDataMgr:jStartDating(498)
    end)

    self.Button_jump:onClick(function()
        GameGuide:checkGuideEnd(self.guideFuncId)
        self:showDirection()
    end)

    self.Button_exit:onClick(function()
        self:exitGame()
    end)

    self.Panel_task:onClick(function()
        Utils:openView("courage.CourageEventRecordView",2)
    end)

    self.Button_chat:onClick(function ()
        local ChatView = require("lua.logic.chat.ChatView")
        ChatView.show(function ( )
        end,false,false,false,4)
    end)
end


return CourageMainView
