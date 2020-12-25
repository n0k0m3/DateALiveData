
local LinkageHwxMainView = class("LinkageHwxMainView",BaseLayer)

function LinkageHwxMainView:ctor( data )
    -- body
    self.super.ctor(self,data)

    self.timingNode = {}
    self.cityCfgs = TabDataMgr:getData("HwxDungeonCity")
    self.displayCfgs = TabDataMgr:getData("HwxDungeonDisplay")
    FubenDataMgr:cacheSelectFubenType(EC_FBType.HWX_FUBEN)

    self.mapNode = {}
    for k,v in pairs(self.cityCfgs) do
        if v.map == 1 or v.map == 2 then
            self.mapNode[v.city] = v
        end
    end

    self.activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.HWX_FUBEN)[1]
    self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)

    self.maxTurnNum = 0
    if  self.activityInfo and self.activityInfo.extendData then
        self.maxTurnNum = #self.activityInfo.extendData.roundduration
        self.battleendtime = self.activityInfo.extendData.activityduration.battleendtime
    end

    self.lastCityIdInMapOne = 1

    self.firstMap = requireNew("lua.logic.newyearFuben.NewYearMapFirst"):new()
    self:init("lua.uiconfig.linkageHwx.linkageHwxMainView")

end

function LinkageHwxMainView:initUI( ui )
    -- body
    self.super.initUI(self,ui)

    self.map_scrollView = TFDirector:getChildByPath(ui,"ScrollView_map")
    self.map_scrollView:setContentSize(GameConfig.WS)
    self.map_scrollView:setPositionX(-GameConfig.WS.width/2)
    self.Panel_firstMap = TFDirector:getChildByPath(ui,"Panel_firstMap"):hide()
    self.Panel_ui = TFDirector:getChildByPath(ui,"Panel_ui")
    self.Button_task = TFDirector:getChildByPath(ui,"Button_task")
    self.Label_star_num = TFDirector:getChildByPath(ui,"Label_star_num")
    self.Label_star_max = TFDirector:getChildByPath(ui,"Label_star_max")
    self.RedTips = TFDirector:getChildByPath(self.Button_task,"RedTips")

    self.redPoint_task = TFDirector:getChildByPath(self.Button_task,"RedTips")
    self.Button_reward = TFDirector:getChildByPath(ui,"Button_reward")
    self.Button_shop = TFDirector:getChildByPath(ui,"Button_shop")
    self.Image_stage_bg = TFDirector:getChildByPath(ui,"Image_stage_bg")

    self.Panel_event_status = TFDirector:getChildByPath(ui,"Panel_event_status")
    self.bossItem = TFDirector:getChildByPath(ui,"bossItem")
    self.Panel_effect = TFDirector:getChildByPath(ui,"Panel_effect")

    self.Image_stage = TFDirector:getChildByPath(self.Image_stage_bg,"Image_stage")
    self.Label_stage = TFDirector:getChildByPath(self.Image_stage_bg,"Label_stage")
    self.Label_timing = TFDirector:getChildByPath(self.Image_stage_bg,"Label_timing")
    self.Image_stage_icon = TFDirector:getChildByPath(self.Image_stage_bg,"Image_stage_icon")

    self.resourceInfo_ = {}
    for i=1,2 do
        local Image_res_icon = TFDirector:getChildByPath(ui,"Image_res_icon"..i)
        local Label_res_num = TFDirector:getChildByPath(ui,"Label_res_num"..i)
        table.insert(self.resourceInfo_,{icon = Image_res_icon, num = Label_res_num})
    end


    self.Panel_resource = TFDirector:getChildByPath(ui,"Panel_resource")
    self.resource = {}
    for i = 1,3 do
        self.resource[i] = TFDirector:getChildByPath(ui,"resource_"..i)
    end

    self.Panel_stage1 = TFDirector:getChildByPath(ui,"Panel_stage1")
    self.Label_unlock_value = TFDirector:getChildByPath(self.Panel_stage1,"Label_unlock_value")

    self.Panel_stage2 = TFDirector:getChildByPath(ui,"Panel_stage2")
    local Label_turn_tip = TFDirector:getChildByPath(self.Panel_stage2,"Label_turn_tip")
    Label_turn_tip:setSkewX(15)
    self.Label_turn_num = TFDirector:getChildByPath(self.Panel_stage2,"Label_turn_num")
    self.Label_turn_num:setSkewX(15)
    self.Label_score_num = TFDirector:getChildByPath(self.Panel_stage2,"Label_score_num")
    self.Label_score_num:setSkewX(15)
    self.Label_total_score = TFDirector:getChildByPath(self.Panel_stage2,"Label_total_score")
    self.Label_total_score:setSkewX(15)

    self.panel_point = TFDirector:getChildByPath(ui,"panel_point")

    self.Spine_changeScene = TFDirector:getChildByPath(ui,"Spine_changeScene"):hide()

    self:initUILogic()

end

function LinkageHwxMainView:initUILogic()

    self:updateMapStage()
    self:updateMapInfo()
    self:updateRes()
    self:updateStarNum()
end

function LinkageHwxMainView:onUpdateCityInfo()
    self:updateMapStage()
    self:updateMapInfo()
    self:updateStarNum()
end

function LinkageHwxMainView:updateStarNum()

    local chapter = FubenDataMgr:getChapter(EC_FBType.HWX_FUBEN)
    local chapterCid = chapter[1]
    local totalFightStarNum, totalDatingStarNum = FubenDataMgr:getChapterTotalStarNum(chapterCid, 1)
    local fightStarNum, datingStarNum = FubenDataMgr:getChapterStarNum(chapterCid, 1)
    self.Label_star_max:setText("/"..totalFightStarNum)
    self.Label_star_num:setText(fightStarNum)

    local isCanReceive, isReceiveAll = FubenDataMgr:checkChapterStarRewardCanReceive(chapterCid, 1)
    self.RedTips:setVisible(isCanReceive)
end

---刷新stage
function LinkageHwxMainView:updateMapStage()

    self:updateStage2plInfo()

    local stageInfo = LinkageHwxDataMgr:getMapStageInfo()
    if not stageInfo then
        return
    end

    self.Panel_stage1:setVisible(stageInfo.stage == 1)
    self.Panel_stage2:setVisible(stageInfo.stage == 2)

    local res = stageInfo.stage == 1 and "ui/hwx/map/007.png" or "ui/hwx/map/008.png"
    self.Image_stage_icon:setTexture(res)

    local stageId = 12032015 + stageInfo.stage - 1
    self.Label_stage:setTextById(stageId)


    self.Label_timing.timingFunc = function ( ... )
        local stageEnd = stageInfo.stageEnd
        local remandTime = math.max(0, stageEnd - ServerDataMgr:getServerTime())
        local day,hour, min, sec = Utils:getFuzzyDHMS(remandTime,true)
        if day == "00" then
            self.Label_timing:setTextById(1260001, hour, min)
        else
            self.Label_timing:setTextById(800069, day, hour)
        end

    end

    self.Label_timing.timingFunc()

    if table.find(self.timingNode,self.Label_timing) == -1 then
        table.insert(self.timingNode,self.Label_timing)
    end

end


function LinkageHwxMainView:updateMapInfo()

    self.cityNodes = self.cityNodes or {}
    if not self.cityMap then
        self.cityMap = createUIByLuaNew("lua.uiconfig.linkageHwx.linkageHwxMap")
        self.map_scrollView:addChild(self.cityMap)
        self.map_scrollView:setInnerContainerSize(CCSizeMake(self.cityMap:getSize()))
        self.Panel_tower = TFDirector:getChildByPath(self.cityMap,"Panel_tower")
        self.Button_fly_back = TFDirector:getChildByPath(self.cityMap,"Button_fly_back")
        self.Image_fly_name = TFDirector:getChildByPath(self.Button_fly_back,"Image_name")
        self.Label_fly_name = TFDirector:getChildByPath(self.Button_fly_back,"Label_name")
    end

    ---加载分图
    local firstMap = self.Panel_firstMap:getChildByName("firstMap")
    if not firstMap then
        self.firstMap:setName("firstMap")
        self.Panel_firstMap:addChild(self.firstMap)
    end

    local cityInfo = LinkageHwxDataMgr:getMapCityInfo()
    if not cityInfo then
        return
    end

    local focusCityId = 1
    local unlockNum = 0
    local isPassAllOne = false

    for k,v in ipairs(self.mapNode) do

        local cityId = v.city

        if v.lastOne == 1 then
            self.lastCityIdInMapOne = cityId
        end

        self:addPoint(v.map,cityId,ccp(v.pos.x,v.pos.y))
        local cityPoint = self.cityNodes[cityId]
        if not cityPoint then
            return
        end

        cityPoint:hide()
        cityPoint:setTouchEnabled(false)

        local isUnlock = false
        ---cityData可能为空，因为有时间控制关卡，没到时间开放的，服务器不下发
        local cityData = cityInfo[cityId]
        if cityData then

            if v.map == 1 and v.lastOne == 1 and cityData.pass then
                isPassAllOne = true
            end

            if v.cityUnlock == 0 then
                isUnlock = true
            else
                local frontInfo = cityInfo[v.cityUnlock]
                if frontInfo and frontInfo.pass then
                    isUnlock = true
                    focusCityId = v.city
                end
            end
        end

        self:updateMapPoint(cityId,v,cityData,isUnlock)

        if isUnlock then
            unlockNum = unlockNum + 1
        end
    end

    local isSecondMap = LinkageHwxDataMgr:isInSecondMap()
    self.Panel_firstMap:setVisible(not (isPassAllOne and isSecondMap))
    self.Label_unlock_value:setText(unlockNum.."/"..#self.mapNode)

    local info = self.mapNode[focusCityId]
    if not info then
        return
    end

    if info.cityUnlock == self.lastCityIdInMapOne then
        if not isSecondMap then
            focusCityId = info.cityUnlock
        end
    end

    if self.lastFocusCityId ~= focusCityId then
        self:focusMap(focusCityId, true)
        self.lastFocusCityId = focusCityId
    end

end

function LinkageHwxMainView:updateRes()
    if not self.activityInfo then
        return
    end
    local resource = self.activityInfo.extendData.resource
    for k,v in ipairs(resource) do
        local itemCfg = GoodsDataMgr:getItemCfg(v)
        local itemCnt = GoodsDataMgr:getItemCount(v)
        if itemCfg and itemCnt then
            self.resourceInfo_[k].icon:setTexture(itemCfg.icon)
            self.resourceInfo_[k].num:setText(itemCnt)
        end
    end
end

function LinkageHwxMainView:addPoint(mapId,cityId,pos)
    if not self.cityNodes[cityId] then
        local point = self.panel_point:clone()
        point:setPosition(pos)
        if mapId == 1 then
            self.firstMap:createMapItem(point)
        else
            self.cityMap:addChild(point)
        end
        point.Image_event_icon = TFDirector:getChildByPath(point,"Image_event_icon")
        point.Label_name = TFDirector:getChildByPath(point,"Label_name")
        point.Image_lock = TFDirector:getChildByPath(point,"Image_lock")
        point.Image_name = TFDirector:getChildByPath(point,"Image_name")
        point.Label_res_time = TFDirector:getChildByPath(point,"Label_res_time")
        point.LoadingBar_progress = TFDirector:getChildByPath(point,"LoadingBar_progress")
        point.barBg = TFDirector:getChildByPath(point,"Image_progress_bg")
        point.Panel_star = TFDirector:getChildByPath(point,"Panel_star")
        point.Button_fly = TFDirector:getChildByPath(point,"Button_fly")
        point.star = {}
        for i=1,3 do
            local star = TFDirector:getChildByPath(point,"Image_start"..i)
            table.insert(point.star,star)
        end
        self.cityNodes[cityId] = point
    end
end

function LinkageHwxMainView:updateMapPoint(cityId,cityCfg,data,isUnlock)

    local cityPoint = self.cityNodes[cityId]
    if not cityPoint then
        return
    end

    local levelCid = cityCfg.id

    local cfgDisplay = self.displayCfgs[levelCid]
    if not cfgDisplay then
        return
    end

    ---显示名字
    cityPoint.Label_name:setTextById(cityCfg.name)

    ---图2飞机场名字显示
    if cityCfg.lastOne == 1 then
        self.Label_fly_name:setTextById(cityCfg.name)
        local w = self.Label_fly_name:getContentSize().width
        self.Image_fly_name:setContentSize(CCSizeMake(w+42,36))

        if self.firstMap then
            self.firstMap:setFlyBtnInfo(cityCfg.name)
        end
    end

    ---是不是挂机
    local isCollectRes = data and data.resOpen

    ---显示图标
    local res = isCollectRes and "ui/hwx/map/015.png" or cfgDisplay.levelicon
    cityPoint.Image_event_icon:setTexture(res)

    ---设置底框大小
    local w = cityPoint.Label_name:getContentSize().width
    local h = isCollectRes and 60 or 36
    cityPoint.Image_name:setContentSize(CCSizeMake(w+42,h))
    cityPoint.Image_lock:setPosition(ccp(-(w+42)/2 ,-h/2))
    cityPoint.Image_lock:setVisible(not isUnlock)
    cityPoint:setVisible(isUnlock)

    ---显示星星
    local starNum = FubenDataMgr:getStarNum(levelCid)
    cityPoint.Panel_star:setVisible((cityCfg.functionType ~= 1) and cfgDisplay.displayDetail ~= 0)
    for i=1,3 do
        local starRes = i <= starNum and "ui/hwx/map/023.png" or "ui/hwx/map/022.png"
        cityPoint.star[i]:setTexture(starRes)
    end

    ---显示飞机
    if cityCfg.lastOne == 1 and data and data.pass then
        if self.firstMap then
            self.firstMap:showFlyBtn()
        end
    end

    local frontInfo = LinkageHwxDataMgr:getMapCityInfo(cityCfg.cityUnlock)
    if frontInfo and frontInfo.pass then
        cityPoint:setVisible(true)
    end


    cityPoint.barBg:setVisible(isCollectRes)
    cityPoint.Label_res_time:setVisible(isCollectRes)

    cityPoint:setTouchEnabled(true)
    cityPoint:onClick(function ( ... )

        if cityCfg.cityUnlock ~= 0  then
            local frontInfo = LinkageHwxDataMgr:getMapCityInfo(cityCfg.cityUnlock)
            if not frontInfo then
                return
            end
            if not frontInfo.pass then
                return
            end

            if cityCfg.sTime and cityCfg.sTime ~= "" then
                local time = Utils:string2time(cityCfg.sTime)
                if ServerDataMgr:getServerTime() < time then
                    cityPoint.Image_lock:show()
                    Utils:showTips(cityCfg.openTips)
                end
            end
        end

        local battleEnd = (self.battleendtime - ServerDataMgr:getServerTime()) <= 0
        if battleEnd then
            Utils:showTips(12033026)
            return
        end
        self:focusMap(cityId)

        if not data then
            return
        end

        if data.resOpen then
            Utils:openView("linkageHwx.LinkageHwxCollectView",data,cityCfg)
            return
        end

        local levelCfg = FubenDataMgr:getLevelCfg(data.dungeon)
        local levelGroupCfg_ = FubenDataMgr:getLevelGroupCfg(levelCfg.levelGroupId)
        local chapterCfg_ = FubenDataMgr:getChapterCfg(levelGroupCfg_.dungeonChapterId)

        if levelCfg.dungeonType == EC_FBLevelType.NEWYEAR_DATING then -- 约会类型直接开始约会
            FubenDataMgr:send_DUNGEON_FIGHT_START(data.dungeon)
        else
            local isCanFighting = true
            local cost = levelCfg.cost[1]
            if cost then
                local challengeCount = 1
                isCanFighting = GoodsDataMgr:currencyIsEnough(cost[1], cost[2] * challengeCount)
            end

            if not isCanFighting then
                local goodsCfg = GoodsDataMgr:getItemCfg(cost[1])
                local name = TextDataMgr:getText(goodsCfg.nameTextId)
                Utils:showTips(2100034, name)
                return
            end
            Utils:openView("fuben.FubenReadyView", data.dungeon,data)
        end
    end)

    if not isCollectRes then
        return
    end

    cityPoint.Label_res_time.timingFunc = function ( ... )
        local time = data.resUpTime or 0
        local remandTime = math.max(0, time - ServerDataMgr:getServerTime())
        local day,hour, min, sec = Utils:getTimeDHMZ(remandTime, true)
        cityPoint.Label_res_time:setTextById(800026,hour, min, sec)

        local time1 = data.resStartTime or 0
        local allTime = math.max(1, time - time1)
        cityPoint.LoadingBar_progress:setPercent(100 - remandTime*100/allTime)
        if data.resCount == self.activityInfo.extendData.collectCountLimit then
            cityPoint.Label_res_time:setTextById(12032018)
        end
    end

    if table.find(self.timingNode,cityPoint.Label_res_time) == -1 then
        table.insert(self.timingNode,cityPoint.Label_res_time)
    end
    cityPoint.Label_res_time.timingFunc()
end

function LinkageHwxMainView:changeMap()

    self.Spine_changeScene:show()
    self.Spine_changeScene:play("animation",0)
    self.Spine_changeScene:addMEListener(TFARMATURE_COMPLETE,function()
        self.Spine_changeScene:removeMEListener(TFARMATURE_COMPLETE)
        local act = CCSequence:create({
            CCCallFunc:create(function()
                self:focusMap(self.lastFocusCityId)
            end),
            CCDelayTime:create(0.2),
            CCCallFunc:create(function()
                self.Panel_firstMap:hide()
                self.Spine_changeScene:play("animation2",0)
                self.Spine_changeScene:addMEListener(TFARMATURE_COMPLETE,function()
                    self.Spine_changeScene:removeMEListener(TFARMATURE_COMPLETE)
                    self.Spine_changeScene:hide()
                end)
            end)
        })
        self.Panel_firstMap:runAction(act)
    end)
end

function LinkageHwxMainView:flyBackToFirstMap()
    self.Spine_changeScene:show()
    self.Spine_changeScene:play("animation",0)
    self.Spine_changeScene:addMEListener(TFARMATURE_COMPLETE,function()
        self.Spine_changeScene:removeMEListener(TFARMATURE_COMPLETE)
        local act = CCSequence:create({
            CCCallFunc:create(function()
                local cityNode = self.cityNodes[self.lastCityIdInMapOne]
                if cityNode then
                    local position = cityNode:Pos()
                    if self.firstMap then
                        self.firstMap:focusMap(position)
                    end
                end
            end),
            CCDelayTime:create(0.2),
            CCCallFunc:create(function()
                self.Panel_firstMap:show()
                self.Spine_changeScene:play("animation2",0)
                self.Spine_changeScene:addMEListener(TFARMATURE_COMPLETE,function()
                    self.Spine_changeScene:removeMEListener(TFARMATURE_COMPLETE)
                    self.Spine_changeScene:hide()
                end)
            end)
        })
        self.Panel_firstMap:runAction(act)
    end)
end

function LinkageHwxMainView:playChangeMapDialog()

    for k,v in pairs(self.cityNodes) do
        if v.map == 1 then
            v:setVisible(false)
        end
    end

    local dialogId = 9330
    if dialogId and dialogId > 0 then
        local function callback()
            KabalaTreeDataMgr:playStory(1,dialogId,function ()
                EventMgr:dispatchEvent(EV_CG_END)
                self:changeMap()
            end)
        end
        KabalaTreeDataMgr:openCgView("kabalaTree.KabalaTreeCg",callback)
    else
        self:changeMap()
    end
end

function LinkageHwxMainView:updateStage2plInfo()

    local totalScore = LinkageHwxDataMgr:getTotalScore()
    local towerInfo = LinkageHwxDataMgr:getTowerInfo()
    if towerInfo then
        ---轮次 ,0则未开启
        local turnNo = towerInfo.base.round
        self.Label_turn_num:setText(turnNo.."/"..self.maxTurnNum)

        ---轮次得分
        local roundScore = towerInfo.base.roundScore
        self.Label_score_num:setText(roundScore)

        ---总得分
        --local totalScore = towerInfo.base.totalScore

    else
        self.Label_turn_num:setText("")
        self.Label_score_num:setText("")
    end
    self.Label_total_score:setText(totalScore)

end

function LinkageHwxMainView:getCityInfo(cityId)
    for i,v in ipairs(self.baseInfo.cities) do
        if tonumber(i) == cityId then
            return v
        end
    end
end

function LinkageHwxMainView:onSubmitSuccessEvent(activitId, itemId, reward)
    if activitId == self.activityId then
        Utils:showReward(reward)
    end
end

function LinkageHwxMainView:onShow()
    self.super.onShow(self)
end

function LinkageHwxMainView:onHide()
    self.super.onHide(self)
    local offset = self.map_scrollView:getContentOffset()
    local offsetStr = offset.x.."|"..offset.y
    CCUserDefault:sharedUserDefault():setStringForKey(MainPlayer:getPlayerId().."hwxmapoffset",offsetStr)
end

function LinkageHwxMainView:onExit()
    self.super.onExit(self)
end

function LinkageHwxMainView:focusMap(cityId, isDelay)

    local cityNode = self.cityNodes[cityId]
    local position = cityNode:Pos()

    if cityId <= self.lastCityIdInMapOne and self.firstMap then
        self.firstMap:focusMap(position,isDelay)
        return
    end

    local innerContainer = self.map_scrollView:getInnerContainer()
    innerContainer:stopAllActions()
    local innerSize = innerContainer:getSize()
    local offset = self.map_scrollView:getContentOffset()
    local posX = -(position.x - 1136 / 2)
    local posY = -(position.y - 640 / 2)
    local maxX = 0
    local maxY = 0
    local minX = 1136 - innerSize.width
    local minY = 640 - innerSize.height
    posX = posX > maxX and maxX or posX
    posX = posX < minX and minX or posX
    posY = posY > maxY and maxY or posY
    posY = posY < minY and minY or posY
    local distancX = math.abs(posX - offset.x)
    local distancY = math.abs(posY - offset.y)
    local distance = math.max(distancX, distancY)
    local time = distance / 1000

    if isDelay then
        local offsetStr = CCUserDefault:sharedUserDefault():getStringForKey(MainPlayer:getPlayerId().."hwxmapoffset")
        if offsetStr and offsetStr ~= "" then
            local vector = string.split(offsetStr,"|")
            self.map_scrollView:setContentOffset(ccp(vector[1],vector[2]))
        end
        local stageInfo = LinkageHwxDataMgr:getMapStageInfo()
        if stageInfo and stageInfo.stage and stageInfo.stage == 1 then
            self.map_scrollView:setContentOffset(ccp(posX,posY), time)
        end
    else
        self.map_scrollView:setContentOffset(ccp(posX,posY), time)
    end
end

function LinkageHwxMainView:removeEvents( ... )
    self.super.removeEvents(self)
    self:removeCountDownTimer()
end

function LinkageHwxMainView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, -1, nil, handler(self.onCountDownPer, self))
    end
end

function LinkageHwxMainView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
    end
end

function LinkageHwxMainView:onCountDownPer()
    for k,v in pairs(self.timingNode) do
        v.timingFunc()
    end
end

function LinkageHwxMainView:checkRedPoint()

end

function LinkageHwxMainView:onReconnect()
    LinkageHwxDataMgr:Send_cityBaseInfo()
end

function LinkageHwxMainView:registerEvents(  )
    self.super.registerEvents(self)

    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.onUpdateCityInfo, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.checkRedPoint, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.updateRes, self))

    EventMgr:addEventListener(self, EV_UPDATE_LINKAGEHWX, handler(self.onUpdateCityInfo, self))
    EventMgr:addEventListener(self, EV_FLYTO_SECONDMAP, handler(self.playChangeMapDialog, self))

    EventMgr:addEventListener(self, EV_FUBEN_LEVELGROUPREWARD, handler(self.updateStarNum, self))

    EventMgr:addEventListener(self,EV_RECONECT_EVENT, handler(self.onReconnect,self))

    self.Button_task:onClick(function ()
        local chapter = FubenDataMgr:getChapter(EC_FBType.HWX_FUBEN)
        local chapterCid = chapter[1]
        local levelGroup_ = FubenDataMgr:getLevelGroup(chapterCid)
        if not levelGroup_ then
            return
        end
        --local stageInfo = LinkageHwxDataMgr:getMapStageInfo()
        --if not stageInfo then
        --    return
        --end
        --local stageId = stageInfo.stage
        local levelGroupCid = levelGroup_[1]
        Utils:openView("linkageHwx.LinkageHwxStarTaskView",levelGroupCid)
    end)

    self.Button_reward:onClick(function ()
        Utils:openView("linkageHwx.LinkageHwxRewardView")
    end)

    self.Button_shop:onClick(function ()
        FunctionDataMgr:enterByFuncId(self.activityInfo.extendData.jumpInterface, unpack(self.activityInfo.extendData.jumpParamters or {}))
    end)

    self:addCountDownTimer()

    self.Panel_tower:onClick(function ()

        local battleEnd = (self.battleendtime - ServerDataMgr:getServerTime()) <= 0
        if battleEnd then
            Utils:showTips(12033026)
            return
        end

        local stageInfo = LinkageHwxDataMgr:getMapStageInfo()
        if not stageInfo then
            return
        end
        if stageInfo.stage == 1 then
            Utils:showTips(12031186)
            return
        end
        Utils:openView("linkageHwx.LinkageHwxTowerView")
    end)

    self.Button_fly_back:onClick(function()
        self:flyBackToFirstMap()

    end)
end

return LinkageHwxMainView