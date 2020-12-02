local DetectiveMainView = class("DetectiveMainView", BaseLayer)

function DetectiveMainView:initData(chapterId)
    self.mapItem_ = {}
    self.mapScale = 0.4
    self.triggerDating = false
    self.isShowingHidden = false
    self.showStartAnimTip = false
    self.hiddenInfos = {}

    DetectiveDataMgr:setCurrentChapter(chapterId)
    if DetectiveDataMgr.currentChapterInfo.status ~= 3 then
        self.showStartAnimTip = true
        DetectiveDataMgr:Req_DetectiveEnter(chapterId)
    end
end

function DetectiveMainView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.detectiveMainView")
end

function DetectiveMainView:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Image_front = TFDirector:getChildByPath(self.Panel_root, "Image_front")
    self.Image_back = TFDirector:getChildByPath(self.Panel_root, "Image_back")
    self.Image_back:setOpacity(255)
    self.Panel_scene = TFDirector:getChildByPath(self.Panel_root, "Panel_scene")
    self.Panel_ui = TFDirector:getChildByPath(self.Panel_root, "Panel_ui"):show()

    self.Button_exit = TFDirector:getChildByPath(self.Panel_root, "Button_exit")

    self.Spine_door = TFDirector:getChildByPath(self.Panel_root, "Spine_door"):hide()
    self.Panel_start = TFDirector:getChildByPath(self.Panel_root, "Panel_start"):hide()
    self.Image_tips_bg = TFDirector:getChildByPath(self.Panel_root, "Image_tips_bg")

    self.Spine_light = SkeletonAnimation:create("effect/ZT_youdeng/ZT_youdeng")
    self.Panel_scene:addChild(self.Spine_light,10)
    self.Spine_light:playByIndex(0,-1,-1,1)
    self.Spine_light:setPosition(ccp(0,0))
    self.Spine_light:hide()

    self.Panel_mask = TFDirector:getChildByPath(self.Panel_root, "Panel_mask"):hide()
    self.Panel_mask:setSize(GameConfig.WS)
    self.Panel_mask:setVisible(false)

    self.Image_task_bg = TFDirector:getChildByPath(self.Panel_root, "Image_task_bg")
    self.Button_check = TFDirector:getChildByPath(self.Image_task_bg, "Button_check")
    local ScrollView_task = TFDirector:getChildByPath(self.Image_task_bg, "ScrollView_task")
    self.ListView_task = UIListView:create(ScrollView_task)
    self.Panel_task = TFDirector:getChildByPath(self.Image_task_bg, "Panel_task")
    self.Image_task_bg:setPositionX(GameConfig.WS.width/2 - 5)

    ---提示信息
    self.Panel_tip_message =  TFDirector:getChildByPath(self.Panel_root, "Panel_tip_message")
    local ScrollView_message = TFDirector:getChildByPath(self.Panel_root, "ScrollView_message")
    self.ListView_message = UIListView:create(ScrollView_message)
    self.Panel_tip_message:setPositionX(-GameConfig.WS.width/2)

    self.Button_chat =  TFDirector:getChildByPath(self.Panel_root, "Button_chat")
    self.Button_chat:setPositionX(-GameConfig.WS.width/2+20)

    ---发现疑点
    self.Panel_hide_item = TFDirector:getChildByPath(self.Panel_root, "Panel_hide_item")

    self.Button_search = TFDirector:getChildByPath(self.Panel_root, "Button_search")
    self.Button_show_hide = TFDirector:getChildByPath(self.Panel_root, "Button_show_hide")
    self.Image_event_tips_bg = TFDirector:getChildByPath(self.Button_show_hide, "Image_event_tips_bg"):hide()
    self.Label_event_tips = TFDirector:getChildByPath(self.Image_event_tips_bg, "Label_event_tips")
    self.Button_picture = TFDirector:getChildByPath(self.Panel_root, "Button_picture")
    self.Button_move = TFDirector:getChildByPath(self.Panel_root, "Button_move")

    ---事件记录
    self.Panel_event_record  = TFDirector:getChildByPath(self.Panel_root, "Panel_event_record")
    local ScrollView_record = TFDirector:getChildByPath(self.Panel_event_record, "ScrollView_record")
    self.List_record = UIListView:create(ScrollView_record)
    self.List_record:setItemsMargin(5)
    self.recordViewSize = self.List_record:getContentSize()
    self.Button_detail = TFDirector:getChildByPath(self.Panel_event_record, "Button_detail")

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


    self.Panel_corner_btns = TFDirector:getChildByPath(self.Panel_ui, "Panel_corner_btns")
    self.Panel_corner_btns:setPositionX(GameConfig.WS.width/2)

    self.Panel_percent = TFDirector:getChildByPath(self.Panel_root, "Panel_percent")
    self.Image_percent_bg = TFDirector:getChildByPath(self.Panel_percent, "Image_percent_bg")
    self.Label_percent_value = TFDirector:getChildByPath(self.Panel_percent, "Label_percent_value")

    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
    self.Label_record = TFDirector:getChildByPath(self.Panel_prefab, "Label_record")
    self.Panel_hidden_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_hidden_item")
    self.Panel_map_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_map_item")
    self.Panel_taskItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_taskItem")
    self.messageItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_message_item")
    
    self:initUILogic()
end

function DetectiveMainView:onShow()
    self:hideOrShowButtons(true)
    self:updateTouchState()
    if self.bgm then
        AudioExchangePlay.playBGM(self,true,self.bgm)
    end


    local isNewChapter = DetectiveDataMgr:isNewOpenChapter()
    local chapterId,areaId = DetectiveDataMgr:getCurLocation()
    local cfg = DetectiveDataMgr:getDetectiveMgrCfg(chapterId)
    if isNewChapter and chapterId and cfg and cfg.startDating ~= 0 then
        return
    end
end

function DetectiveMainView:onClose()
    self.super.onHide(self)
    if self.voiceHandle then
        TFAudio.stopEffect(self.voiceHandle)
    end
end

function DetectiveMainView:initUILogic()
    self:updateBg()
    self:updateMap()
    self:updateTask()
    self:updateSearchPercent()
    self:refreshHiddenEvents(true)
    if self.showStartAnimTip then
        self:showStartAnimation()
    else
        self:checkStartInfo()
    end
end

function DetectiveMainView:showStartAnimation()
    self.Panel_ui:hide()
    self.Panel_start:show()
    local chapter = DetectiveDataMgr:getCurLocation()
    local cfg = DetectiveDataMgr:getDetectiveMgrCfg(chapter)
    TFDirector:getChildByPath(self.Image_tips_bg, "Label_start_tips"):setText(cfg.name)
    local startEffect = SkeletonAnimation:create("effect/ZT_kaichang/ZT_kaichang")
    self.Panel_start:addChild(startEffect,1)
    startEffect:playByIndex(0,-1,-1,0)
    startEffect:addMEListener(TFARMATURE_COMPLETE,function()
        startEffect:removeMEListener(TFARMATURE_COMPLETE)
        startEffect:removeFromParent()
        self.showStartAnimTip = false
        self.Panel_ui:show()
        self.Panel_start:hide()
        self:checkStartInfo()
    end)
    self.Image_tips_bg:setOpacity(0)
    self.Image_tips_bg:runAction(CCSequence:create({CCDelayTime:create(4.5),FadeIn:create(1),CCDelayTime:create(1),FadeOut:create(1)}))
end

function DetectiveMainView:updateSearchPercent()
    self.Image_percent_bg:removeAllChildren()
    local chapter = DetectiveDataMgr:getCurLocation()
    local cfg = DetectiveDataMgr:getDetectiveMgrCfg(chapter)
    local itemCfg = GoodsDataMgr:getItemCfg(cfg.progressItem)
    local count = GoodsDataMgr:getItemCount(cfg.progressItem)
    local percent = count*100/itemCfg.totalMax
    self.Label_percent_value:setText(percent.."%")
    local percentNum = percent / 10
    for i=1,percentNum do
        local image = TFImage:create("ui/activity/detective/main/12.png")
        self.Image_percent_bg:addChild(image)
        image:setPosition(ccp(8 +(i - 1) * 10,0))
    end
end

function DetectiveMainView:updateTouchState()
    local curEvrntId = DetectiveDataMgr:getEventID()
    self.Button_search:show()
end

function DetectiveMainView:checkStartInfo()

    local curEvrntId = DetectiveDataMgr:getEventID()
    local eventCfg = DetectiveDataMgr:getEventCfg(curEvrntId)
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

function DetectiveMainView:updateTask(update)
    self.ListView_task:removeAllItems()
    self:updateMainLog()
end

----主线
function DetectiveMainView:updateMainLog()
    local mainLogInfo = DetectiveDataMgr:getMainLogInfo()

    table.sort(mainLogInfo,function(a,b)
        local cfgA = DetectiveDataMgr:getLogCfgData(a.logId)
        local cfgB = DetectiveDataMgr:getLogCfgData(b.logId)
        return cfgA.priority > cfgB.priority
    end)

    local curLogInfo
    for k,v in ipairs(mainLogInfo) do
        if not v.finished then
            curLogInfo = v
            break
        end
    end

    if curLogInfo then
        local cfg = DetectiveDataMgr:getLogCfgData(curLogInfo.logId)
        local taskItem = self.Panel_taskItem:clone()
        local Label_main = taskItem:getChildByName("Label_main")
        local Label_task = taskItem:getChildByName("Label_task")    

        Label_main:setTextById(1300005)
        self:setNewText(Label_task,cfg.logBase,42,"...")

        self.ListView_task:pushBackCustomItem(taskItem)
    end
    self:updateHistoryLog(mainLogInfo)
end

function DetectiveMainView:updateHistoryLog(logInfos)
    for i,v in ipairs(logInfos) do
        if v.finished then
            local cfg = DetectiveDataMgr:getLogCfgData(v.logId)
            local taskItem = self.Panel_taskItem:clone()
            local Label_main = taskItem:getChildByName("Label_main")
            local Label_task = taskItem:getChildByName("Label_task")
            Label_main:setTextById(190000373)
            local Label_task = TFDirector:getChildByPath(taskItem, "Label_task")
            self:setNewText(Label_task,TextDataMgr:getText(cfg.finishLog),42,"...")
            self.ListView_task:pushBackCustomItem(taskItem)
        end
    end
end

function DetectiveMainView:setNewText(labelObj,labelStr,limitHeight,otherStr)


    local function getStrMap(str)
        local strTab = {}
        for uchar in string.gmatch(str, "[%z\1-\127\194-\244][\128-\191]*") do
            strTab[#strTab+1] = uchar
        end
        return strTab
    end

    local strMap = getStrMap(labelStr)

    labelObj:setDimensions(180,0)
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

function DetectiveMainView:updateBg()
    local chapterId,areaId = DetectiveDataMgr:getCurLocation()
    if not chapterId or not areaId then
        return
    end
    local mapCfg = DetectiveDataMgr:getMapCfgInfo(chapterId,areaId)
    if not mapCfg then
        return
    end
    local scale = mapCfg.scale or 1
    self.Image_back:setTexture("scene/bg/"..mapCfg.bgres..".png")
    self.Image_front:setTexture("scene/bg/"..mapCfg.bgres..".png")
    self.Image_back:setScale(scale)
    self.Image_front:setScale(scale)

    if string.len(mapCfg.weatherEffect) > 2 then
        if not self.spin_leiyu then
            self.spin_leiyu = SkeletonAnimation:create(mapCfg.weatherEffect)
            self.Panel_scene:addChild(self.spin_leiyu,3)
            self.spin_leiyu:playByIndex(0,-1,-1,1)
            self.spin_leiyu:setPosition(ccp(0,0))
        end
        self.spin_leiyu:show()
    else
        if self.spin_leiyu then
            self.spin_leiyu:hide()
        end
    end

    if mapCfg.bgm ~= "" and self.bgm ~= mapCfg.bgm then
        AudioExchangePlay.playBGM(self,true,mapCfg.bgm)
        self.bgm = mapCfg.bgm
    end
end

function DetectiveMainView:updatePath()
    
end

function DetectiveMainView:updateMap()
    self.Image_map:setScale(self.mapScale)
    self:setGridMapLimit()
    local chapterId,areaId = DetectiveDataMgr:getCurLocation()
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
            self.mapItem_[v.id] = {root = contentItem,item = mapItem,data = v}
            self:updateMapItem(v)
        end
    end
    
    self:moveToLevel(areaId,true)
end

function DetectiveMainView:getMapContaierPos(position)
    local mapPosX = (0 - position.x)*self.mapScale
    local mapPosY = (0 - position.y)*self.mapScale
    return ccp(mapPosX, mapPosY)
end

function DetectiveMainView:moveToLevel(mapId,isInit,callback)

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

function DetectiveMainView:updateMapItem(data)

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

    if chapter < data.condition then
        local image = TFImage:create("ui/activity/detective/map/suo.png")
        mapItem.item:addChild(image)
    end
end

function DetectiveMainView:setGridMapLimit()

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

function DetectiveMainView:detectEdges(point)

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
function DetectiveMainView:updateRecord(isInit)
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

function DetectiveMainView:doFlashAndScaleAction(node, duration, scale)
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

function DetectiveMainView:startSearch()
    self.Panel_mask:setVisible(true)
    self:changeUIViewState()
    self.Button_show_hide:hide()
    Utils:playSound(5024)

    local scale = self.Image_front:getScale()
    self.Spine_light:setVisible(true)
    local act1 = CCMoveBy:create(0.5,ccp(0,-20))
    local act2 =  CCScaleBy:create(0.5, 1.1)
    local act3 = act1:reverse()
    local act4 = CCSpawn:create({act1,act2})
    local act5 = CCSpawn:create({act3,act2})
    local act6 = CCSpawn:create({act1,act2})
    local act7 = CCSpawn:create({CCMoveTo:create(0.1,ccp(0,0)),CCScaleTo:create(0.1, scale)})
    local act8 = CCSequence:create({act4,act5,act6,act7,CCCallFunc:create(function()
        self:changeUIViewState()
        self.Button_show_hide:show()
        self.Image_front:stopAllActions()
        self.Image_front:setPosition(ccp(0,0))
        self.Image_front:setScale(scale)
        self.Spine_light:setVisible(false)
        self:triggerEvent()
    end)})
    self.Image_front:runAction(CCRepeatForever:create(act8))

end

function DetectiveMainView:triggerEvent()
    self:updateTouchState()
    local eventID = DetectiveDataMgr:getEventID()
    local eventCfg = DetectiveDataMgr:getEventCfg(eventID)
    if not eventCfg then
        self.Panel_mask:setVisible(false)
        if eventID then
            Box("找不到事件ID："..tostring(eventID))
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
function DetectiveMainView:showEvent(eventCfg)
    if not eventCfg then
        return
    end
    if eventCfg.eventType ~= 6 then
        DetectiveDataMgr:Req_DetectiveEvtFinish(eventCfg.id)
    end
    if eventCfg.message ~= 0 then
        local str = TextDataMgr:getText(eventCfg.message)
        self:insertMessage(str)
    end

    local time = 0.4
    ---apearType:12-提示事件 13-发现疑点 11 什么也没发生
    local apearType = eventCfg.apearType

    self:timeOut(function()
        self.Panel_mask:setVisible(false)
    end ,time)

end

function DetectiveMainView:removeTipMessage()
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

function DetectiveMainView:insertMessage(message)
    local messageItem = self.messageItem:clone()
    messageItem:show()
    local Image_head_bord =  TFDirector:getChildByPath(messageItem, "Image_head_bord")
    local Label_tip = TFDirector:getChildByPath(messageItem, "Label_tip")
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

    self.ListView_message:pushBackCustomItem(messageItem)
    self.ListView_message:scrollToBottom(0.5)
    self:removeTipMessage()
end


function DetectiveMainView:refreshHiddenEvents(force)
    self.Panel_hide_item:show()
    if force then
        self.Panel_hide_item:removeAllChildren()
        self.hiddenInfos = {}
        self.Image_event_tips_bg:stopAllActions()
        self.Image_event_tips_bg:hide()
    end
    local chapterId,areaId = DetectiveDataMgr:getCurLocation()
    local events = DetectiveDataMgr:getSaveEvents()
    for i,eventId in ipairs(events) do
        local eventCfg = DetectiveDataMgr:getEventCfg(eventId)
        if eventCfg.area == areaId and not self.hiddenInfos[eventId] then
            Utils:playSound(5025)
            for k,v in pairs(eventCfg.doubtParam) do
                local info = {datingId = k,normalPos = ccp(v.x,v.y),cfg = eventCfg}
                self.hiddenInfos[eventId] = info
                local hiddenItem = self.Panel_hidden_item:clone()
                hiddenItem:show()
                hiddenItem:setPosition(info.normalPos)
                local image = TFImage:create(info.cfg.doubtPicture)
                hiddenItem:addChild(image)
                hiddenItem.pic = image
                hiddenItem.eventId = eventId
                self.Panel_hide_item:addChild(hiddenItem)
                local rule = eventCfg.showRule
                if rule.twinkleTime then
                    hiddenItem:setOpacity(255)
                    local act1 = FadeTo:create(rule.twinkleTime,10)
                    local act2 =  FadeTo:create(rule.twinkleTime, 255)
                    local act3 = CCSequence:create({act1,act2})
                    if rule.twinkle > 0 then
                        hiddenItem:runAction(CCRepeat:create(act3,rule.twinkle))
                    else
                        hiddenItem:runAction(CCRepeatForever:create(act3)) 
                    end
                else
                    hiddenItem:setOpacity(0)
                    hiddenItem:runAction(FadeIn:create(0.5))
                end
                if rule.tips then
                    self.Image_event_tips_bg:show()
                    self.Image_event_tips_bg:setOpacity(0)
                    self.Label_event_tips:setTextById(rule.tips)
                    local act1 = DelayTime:create(1)
                    local act2 = FadeTo:create(0.4,255)
                    local act3 = DelayTime:create(3)
                    local act4 =  FadeTo:create(0.4, 0)
                    local act5 = CCSequence:create({act1,act2,act3,act4})
                    self.Image_event_tips_bg:runAction(CCRepeatForever:create(act5)) 
                end
                hiddenItem:addMEListener(TFWIDGET_CLICK, handler(self.onHiddenClick,self))
                break
            end
        end
    end
end

function DetectiveMainView:onHiddenClick(sender)
    if self.isShowingHidden then
        return
    end
    self.isShowingHidden = true
    self.Button_search:hide()
    self:hideOrShowButtons(false)
    sender:setTouchEnabled(false)
    sender:stopAllActions()
    sender:setOpacity(255)
    self.Image_event_tips_bg:stopAllActions()
    self.Image_event_tips_bg:hide()
    DetectiveDataMgr:Req_DetectiveEvtFinish(sender.eventId)
    local info = self.hiddenInfos[sender.eventId]
    local rule = info.cfg.showRule
    Utils:playSound(tonumber(rule.sound))
    local scaleAct1 = ScaleTo:create(rule.time,rule.zoom)
    local scaleAct2 = ScaleTo:create(rule.time,1.0)
    local action = CCRepeat:create(CCSequence:create({scaleAct1, scaleAct2}),rule.frequency)
    sender:runAction(CCSequence:create({
        action,
        CCCallFunc:create(function()
            self.isShowingHidden = false
            self.Button_search:show()
            if table.count(info.cfg.replaceParam) > 0 then
                sender:setPosition(ccp(info.cfg.replaceParam.x,info.cfg.replaceParam.y))
            end
            if string.len(info.cfg.replacePicture) > 2 then
                sender.pic:setTexture(info.cfg.replacePicture)
            else
                self.hiddenInfos[sender.eventId] = nil
                sender:removeFromParent()
            end
            self:playDating(info.datingId)
        end)
    }))
end


function DetectiveMainView:playEndDating()
    
end

function DetectiveMainView:onRecvAfterAskMove()
    if self.showStartAnimTip then
        return
    end
    self:updateTouchState()
    self:startSearch()
end

function DetectiveMainView:onCompleteStartDating()
    self:checkStartInfo()
end

function DetectiveMainView:onDatingCompleted(id)
    if not self.triggerDating then
        return
    end
    self.triggerDating = false
    local triggerId = DetectiveDataMgr:getEventID()
    local eventCfg = DetectiveDataMgr:getEventCfg(triggerId)
    if not eventCfg then
        return
    end
    self:showEvent(eventCfg)
end

function DetectiveMainView:onRecvFinishEvent()
    self:playEndDating()
end

function DetectiveMainView:onRecvUpdateMap(isAfterOtherArea)
    self:updateBg()
    self:updateMap()
    self:refreshHiddenEvents(true)
    if isAfterOtherArea then
        local chapterId,areaId = DetectiveDataMgr:getCurLocation()
        local mapCfg = DetectiveDataMgr:getMapCfgInfo(chapterId,areaId)
        if mapCfg and mapCfg.areaEffect and mapCfg.areaEffect ~= "" then

            Utils:playSound(mapCfg.changeSound)
            local isLayerInQueue,layer = AlertManager:isLayerInQueue("CourageBigMap")
            if isLayerInQueue then
                AlertManager:closeLayer(layer)
            end

            self:aferMoveToOther(mapCfg.areaEffect,mapCfg.Coordinate)
        end
    end
end

function DetectiveMainView:aferMoveToOther(spineName,pos)
    self.Panel_mask:setVisible(true)
    local Spine_change = SkeletonAnimation:create(spineName)
    Spine_change:play("animation",false)
    Spine_change:setPosition(ccp(pos.x,pos.y))
    Spine_change:setAnchorPoint(ccp(0,0))
    self.Panel_root:addChild(Spine_change,1)
    Spine_change:addMEListener(TFARMATURE_COMPLETE,function()
        Spine_change:removeMEListener(TFARMATURE_COMPLETE)
        Spine_change:removeFromParent()
        self.Panel_mask:setVisible(false)
        self:playEndDating()
    end)
end

function DetectiveMainView:playDating(datingRuleId)
    if datingRuleId == 0 then
        return
    end
    self:hideOrShowButtons(false)
    FunctionDataMgr:jStartDating(datingRuleId)
end

function DetectiveMainView:hideOrShowButtons(isShow)
    if isShow then
        self.Panel_corner_btns:show()
        self.Button_chat:show()
        self.Button_exit:show()
    else
        self.Panel_corner_btns:hide()
        self.Button_chat:hide()
        self.Button_exit:hide()
    end
end

function DetectiveMainView:showEndAnimation()
    self.Panel_ui:hide()
    self.Panel_start:show()
    TFDirector:getChildByPath(self.Image_tips_bg, "Label_start_tips"):setTextById(13316332)
    local endEffect = SkeletonAnimation:create("effect/ZT_kaichang/ZT_kaichang")
    self.Panel_start:addChild(endEffect,1)

    endEffect:play("ZT_kaichang_xunhuan",true)
    local func = CallFunc:create(function ()
        local endEffect1 = SkeletonAnimation:create("effect/ZT_kaichang/ZT_kaichang")
        self.Panel_start:addChild(endEffect1,10)
        endEffect1:play("ZT_kaichang_jieshu",false)
        endEffect1:addMEListener(TFARMATURE_COMPLETE,function()
            endEffect1:removeMEListener(TFARMATURE_COMPLETE)
            endEffect1:removeFromParent()
            self.Panel_start:hide()
            AlertManager:closeLayer(self)
        end)
    end)
    self.Image_tips_bg:setOpacity(0)
    self.Image_tips_bg:runAction(CCSequence:create({FadeIn:create(2),CCDelayTime:create(0.5),func,FadeOut:create(2)}))
end

function DetectiveMainView:onRecvCourageEnd()
    local chapter = DetectiveDataMgr:getCurLocation()
    if chapter == 7 then
        AlertManager:closeLayer(self)
    else
        self:showEndAnimation()
    end
end

function DetectiveMainView:showDirection(areaId)
    DetectiveDataMgr:Req_DetectiveChooseArea(areaId)
end

function DetectiveMainView:onRecvRescueHero()

end

function DetectiveMainView:onRecvSignUpdate(firstTag)
    local unlockSign = DetectiveDataMgr:getUnlockSign()
    if firstTag and #unlockSign == 1 then
        Utils:openView("detective.DetectivePictureGame",{group = 1, firstGet = true})
    end
end

function DetectiveMainView:exitGameConfirm()

    local function confirmCall()
        AlertManager:closeLayer(self)
        -- local chapterId,areaId = DetectiveDataMgr:getCurLocation()
        -- local mgrCfg = DetectiveDataMgr:getDetectiveMgrCfg(chapterId)
        -- if mgrCfg then
        --     self:playDating(mgrCfg.breakDating)
        -- end
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

function DetectiveMainView:exitGame()

    local function confirmCall()
        FunctionDataMgr:jActivity3()
        AlertManager:closeLayer(self)
    end
    local function cancleCall()
        DetectiveDataMgr:Req_ExitGame()
    end
    local rstr = TextDataMgr:getTextAttr(13316013)
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

function DetectiveMainView:onChapterDataUpdate()
    self:refreshHiddenEvents()
end

function DetectiveMainView:changeUIViewState()
    local state = self.Panel_ui:isVisible()
    self.Panel_ui:setVisible(not state)
    self.Button_show_hide:setTextureNormal(state and "ui/activity/detective/main/007.png" or "ui/activity/detective/main/006.png")
end

function DetectiveMainView:registerEvents()
    EventMgr:addEventListener(self, EV_DETECTIVE.DETECTIVE_CHAPTER_UPDATE, handler(self.onChapterDataUpdate, self))
    EventMgr:addEventListener(self, EV_DETECTIVE.DETECTIVE_UPDATE_EVENT_LOG, handler(self.updateTask, self))
    EventMgr:addEventListener(self, EV_DETECTIVE.DETECTIVE_CHOOSE_AREA, handler(self.onRecvUpdateMap, self))
    EventMgr:addEventListener(self, EV_DETECTIVE.DETECTIVE_UPDATE_FINISH, handler(self.onRecvFinishEvent, self))
    EventMgr:addEventListener(self, EV_DETECTIVE.DETECTIVE_ASK_MOVE, handler(self.onRecvAfterAskMove, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.datingcompleted, handler(self.onDatingCompleted, self))
    EventMgr:addEventListener(self, EV_FUBEN_PHASECOMPLETE, handler(self.onCompleteStartDating, self))
    EventMgr:addEventListener(self, EV_DETECTIVE.DETECTIVE_SETTLEMENT, handler(self.onRecvCourageEnd, self))
    EventMgr:addEventListener(self, EV_DETECTIVE.DETECTIVE_SIGN_UPDATE, handler(self.onRecvSignUpdate, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, function ( ... )
        self:updateSearchPercent()
    end)


    self.Button_show_hide:onClick(function()
        self:changeUIViewState()
    end)

    self.Button_detail:onClick(function()
        Utils:openView("detective.DetectiveRecordView",1)
    end)

    self.Button_check:onClick(function()
        Utils:openView("detective.DetectiveRecordView",1)
    end)

    self.Panel_touchMiniMap:onClick(function()
        Utils:openView("detective.DetectiveBigMap", true)
    end)

    self.Button_move:onClick(function()
        Utils:openView("detective.DetectiveBigMap", true)
    end)

    self.Button_picture:onClick(function()
        Utils:openView("detective.DetectivePictureGame",{group = 1})
    end)

    self.Button_search:onClick(function()
        DetectiveDataMgr:Req_DetectiveExplore()
    end)

    self.Button_exit:onClick(function()
        self:exitGame()
    end)

    self.Panel_task:onClick(function()
        Utils:openView("detective.DetectiveRecordView",1)
    end)

    self.Button_chat:onClick(function ()
        local ChatView = require("lua.logic.chat.ChatView")
        ChatView.show(function ( )
        end,false,false,false,EC_ChatType.VOTE)
    end)
end


return DetectiveMainView
