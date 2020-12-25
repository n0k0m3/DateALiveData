local LeagueMainLayer = class("LeagueMainLayer", BaseLayer)

function LeagueMainLayer:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.league.leagueMainLayer")
end

function LeagueMainLayer:onQuitUnionBack()
    AlertManager:closeAll()
    AlertManager:changeScene(SceneType.MainScene)
end

function LeagueMainLayer:registerEvents()
    EventMgr:addEventListener(self, EV_UNION_QUIT_UNION, handler(self.onQuitUnionBack, self))
    EventMgr:addEventListener(self, EV_UNION_DELATE_TIME_UPDATE, handler(self.onUpdateImpeachTime, self))
    EventMgr:addEventListener(self, EV_UNION_APPLY_UPDATE, handler(self.updateRedPoints, self))
    EventMgr:addEventListener(self, EV_UNION_LEVEL_CHANGE, handler(self.updateBuilds, self))
    --追猎计划数据
    EventMgr:addEventListener(self, EV_HUNTER_INFO_UPDATE, handler(self.updateBuildingNameItems, self))
    EventMgr:addEventListener(self, EV_HUNTER_REWARDLIST_UPDATE, handler(self.updateRedPoints, self))

    self.Button_impatch:onClick(function()
        Utils:openView("league.LeagueDelateInfoView")
    end)
    self:addCountDownTimer()
end

function LeagueMainLayer:onEnter()
    self.super.onEnter(self)
end

function LeagueMainLayer:onExit()
    self.super.onExit(self)
end

function LeagueMainLayer:onShow()
    self.super.onShow(self)
    self:updateRedPoints()
end

function LeagueMainLayer:initData()
    self.buildingMap = TabDataMgr:getData("ClubBuild")
    self.buildItems_ = {}
end

function LeagueMainLayer:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Panel_back = TFDirector:getChildByPath(self.ui, "Panel_back")
    self.Panel_content = TFDirector:getChildByPath(self.ui, "Panel_content")
    self.ScrollView_content = TFDirector:getChildByPath(self.ui, "ScrollView_content")
    self.UI_content = TFDirector:getChildByPath(self.ui, "UI_content")
    self.Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab")

    self.Panel_impatch = TFDirector:getChildByPath(self.UI_content, "Panel_impatch")
    self.Label_impeach_time = TFDirector:getChildByPath(self.Panel_impatch, "Label_impeach_time")
    self.Button_impatch = TFDirector:getChildByPath(self.Panel_impatch, "Button_impatch")
    
    self.Panel_build = TFDirector:getChildByPath(self.Panel_prefab, "Panel_build")
    self.Panel_buld_name = TFDirector:getChildByPath(self.Panel_prefab, "Panel_buld_name")
    self.Panel_npc = TFDirector:getChildByPath(self.Panel_prefab, "Panel_npc")

    self:initContent()
end

function LeagueMainLayer:initContent()
    self:initBuilds()
    self:onUpdateImpeachTime()
end

function LeagueMainLayer:initBuilds()
    --self.ScrollView_content:setSize(GameConfig.WS)
    local maxWidth = GameConfig.WS.width
    self.nameItems = {}
    for k,cfg in pairs(self.buildingMap) do
        local buildItem = self.Panel_build:clone()
        local buildWidth = self:updateBuildingItem(buildItem, cfg)
        self.UI_content:addChild(buildItem, cfg.pictier)
        self.buildItems_[cfg.id] = buildItem

        local nameItem = self.Panel_buld_name:clone()
        self:updateBuildingNameItem(nameItem, cfg)

        self.UI_content:addChild(nameItem, 91)
        self.nameItems[cfg.id] = nameItem
    end
    --self.ScrollView_content:setInnerContainerSize(CCSizeMake(maxWidth, 640))
    --self.ScrollView_content:setBounceEnabled(true)
end

function LeagueMainLayer:updateBuilds()
    for id, buildItem in pairs(self.buildItems_) do
        self:updateBuildingItem(buildItem, self.buildingMap[id])
    end
    for id, nameItem in pairs(self.nameItems) do
        self:updateBuildingNameItem(nameItem, self.buildingMap[id])
    end
end

function LeagueMainLayer:updateBuildingNameItems()
    for id, nameItem in pairs(self.nameItems) do
        self:updateBuildingNameItem(nameItem, self.buildingMap[id])
    end
    self:updateRedPoints()
end


function LeagueMainLayer:updateBuildingNameItem(nameItem, cfg)
    local Image_name_bg = TFDirector:getChildByPath(nameItem, "Image_name_bg")
    local Image_lock = TFDirector:getChildByPath(nameItem, "Image_lock")
    local Label_build_name = TFDirector:getChildByPath(nameItem, "Label_build_name")
    Label_build_name:setTextById(tonumber(cfg.name))
    local open
    if cfg.id == 6 then  -- 次元入侵双重判定
        open = FunctionDataMgr:isOpen(cfg.open)
    else
        open = FunctionDataMgr:isOpenByClient(cfg.open)
    end
    
    Image_lock:setVisible(not open)
    local buildPos = cfg.location
    local namePos = cfg.excursion
    nameItem:setPosition(ccp(buildPos[1] + namePos[1],buildPos[2] + namePos[2]))
    -------------
    if cfg.id == 5 and TFLanguageMgr:getUsingLanguage() == cc.SPANISH then
        nameItem:setPosition(ccp(buildPos[1] + namePos[1] - 50,buildPos[2] + namePos[2] ))
    end
    if cfg.id == 7 and TFLanguageMgr:getUsingLanguage() == cc.SPANISH then
        nameItem:setPosition(ccp(buildPos[1] + namePos[1],buildPos[2] + namePos[2] + 50))
    end
    if cfg.id == 8 and TFLanguageMgr:getUsingLanguage() == cc.SPANISH then
        nameItem:setPosition(ccp(buildPos[1] + namePos[1] + 100,buildPos[2] + namePos[2] + 50))
    end
    
    local Image_time = TFDirector:getChildByPath(nameItem, "Image_time")

    if cfg.id  == 7 then --追猎计划特殊处理
        if open then 
            local huntingDungeonInfo = LeagueDataMgr:getHuntingDungeonInfo()
            if huntingDungeonInfo then 
                local step = huntingDungeonInfo.step
                local _step = step.step
                Image_time:show()
                local remainTime = math.max(0,step.nextTime - ServerDataMgr:getServerTime())
                local day, hour, min, sec = Utils:getTimeDHMZ(remainTime,true)
                local Label_time = TFDirector:getChildByPath(Image_time, "Label_time")
                if _step == 0 or _step == 3 or _step == 13 then 
                    if tonumber(day) > 0 then 
                        Label_time:setTextById("r304004", day, hour)  --开启倒计时
                    else
                        Label_time:setTextById("r304005", hour, min)  --开启倒计时
                    end 
                else
                    Label_time:setTextById("r304003", day, hour) --关闭倒计时
                end
            else
                Image_time:hide()
            end
        else
            Image_time:hide()
        end
    elseif cfg.id == 6 then -- 次元入侵特殊处理
        if open then
            local openTime = Utils:getKVP(51101,"timeOpen")
            local serverTime = ServerDataMgr:getServerTime()
            local remainTime = openTime/1000 - serverTime
            if remainTime > 0 then
                local day, hour, min, sec = Utils:getTimeDHMZ(remainTime)
                local Label_time = TFDirector:getChildByPath(Image_time, "Label_time")
                if tonumber(day) > 0 then 
                    Label_time:setTextById("r304004", day, hour)  --开启倒计时
                else
                    Label_time:setTextById("r304005", hour, min)  --开启倒计时
                end 
                Image_time:show()
            else
                Image_time:hide()
            end
        else
            Image_time:hide()
        end
    else
        Image_time:hide()
    end
end

function LeagueMainLayer:updateBuildingItem(buildItem, cfg)
    local Panel_build_touch = TFDirector:getChildByPath(buildItem, "Panel_build_touch")
    local Panel_building_effect = TFDirector:getChildByPath(buildItem, "Panel_building_effect")
    Panel_building_effect:removeChildByTag(99999, true) --移除原有特效
    local Spine_effect = SkeletonAnimation:create("effect/club/"..cfg.effect)
    Spine_effect:setTag(99999)
    Spine_effect:setPosition(ccp(cfg.effectlocation[1],cfg.effectlocation[2]))
    Panel_building_effect:addChild(Spine_effect)
    Spine_effect:play("animation",true)

    local buildPos = cfg.location
    buildItem:setPosition(ccp(buildPos[1],buildPos[2]))

    Panel_build_touch:setContentSize(CCSizeMake(cfg.clickable[1], cfg.clickable[2]))
    Panel_build_touch:setTouchEnabled(true)
    Panel_build_touch:onClick(function()
        self:buildingClick(cfg)
    end)
    return Spine_effect:getContentSize().width
end

function LeagueMainLayer:updateRedPoints()
    for k,item in pairs(self.nameItems) do
        local Image_red_tips = TFDirector:getChildByPath(item, "Image_red_tips")
        Image_red_tips:setVisible(false)
        local buildingId = tonumber(k)
        local redFlag = false
        if buildingId == 1 then
            Image_red_tips:setVisible(LeagueDataMgr.flagUnlockRed or LeagueDataMgr.noticeChangeRed)
        elseif buildingId == 2 then
            Image_red_tips:setVisible(LeagueDataMgr:getApplyRedPointState())
        elseif buildingId == 3 then
            Image_red_tips:setVisible(LeagueDataMgr:getSupplyCenterRedPoint())
        elseif buildingId == 4 then
            Image_red_tips:setVisible(LeagueDataMgr:getUnionTaskRedPointState())
        elseif buildingId == 6 then
            local _bool = LeagueDataMgr:getIsRewardsAndMaxNum() or LeagueDataMgr:isWorldBossOpenRedShow()
            Image_red_tips:setVisible(_bool)
        elseif buildingId == 7 then
            local visible = LeagueDataMgr:getHasHuntingFDAwardCanGet() or LeagueDataMgr:isHunterDungeonOpen()
            Image_red_tips:setVisible(visible)
        elseif buildingId == 8 then
            Image_red_tips:setVisible(LeagueDataMgr:getTrainMatrixRedPoint())
        end
    end
    LeagueDataMgr:setJoinUnionRedPoint(false)
end

function LeagueMainLayer:buildingClick(buildCfg)
    local func = self["onBuildingClick"..buildCfg.id]
    if func then
        func(buildCfg)
    end
end

function LeagueMainLayer:onUpdateImpeachTime()
    local suplsTime = LeagueDataMgr:getDelateSuplsTime()
    self.Panel_impatch:setVisible(suplsTime > 0)
    if suplsTime > 0 then
        local day, hour, min, sec = Utils:getFuzzyDHMS(suplsTime, false)
        self.Label_impeach_time:setTextById(270353, day, hour, min)
        self.Button_impatch:setPositionX(self.Label_impeach_time:getContentSize().width / 2 + 25)
        if not self.updateTimer_ then
            self.updateTimer_ = TFDirector:addTimer(1000, -1, nil, handler(self.onUpdatePer, self))
        end
    else
        self:removeUpdateTimer()
    end
end

function LeagueMainLayer:onUpdatePer()
    if self.onUpdateImpeachTime then
        self:onUpdateImpeachTime()
    else
        self:removeUpdateTimer()
    end
end

function LeagueMainLayer:removeEvents()
    print("LeagueMainLayer:removeEvents__")
    self:removeUpdateTimer()
    self:removeCountDownTimer()
end

function LeagueMainLayer:removeUpdateTimer()
    if self.updateTimer_ then
        TFDirector:removeTimer(self.updateTimer_)
        self.updateTimer_ = nil
    end
end

--社团大厅
function LeagueMainLayer:onBuildingClick1()
    FunctionDataMgr:jUnionHall()
end

--成员列表
function LeagueMainLayer:onBuildingClick2()
    FunctionDataMgr:jUnionMember()
end

--空投补给
function LeagueMainLayer:onBuildingClick3()
    FunctionDataMgr:jUnionSupply()
end

--研发中心
function LeagueMainLayer:onBuildingClick4()
    FunctionDataMgr:jUnionBuilding()
end

--社团商店
function LeagueMainLayer:onBuildingClick5()
    FunctionDataMgr:jUnionStor()
end

--次元入侵
function LeagueMainLayer:onBuildingClick6()
    FunctionDataMgr:jUnionInvade()
end

--追猎计划
function LeagueMainLayer:onBuildingClick7()
    FunctionDataMgr:jUnionHunt()
end

--特训矩阵
function LeagueMainLayer:onBuildingClick8()
    FunctionDataMgr:jUnionMatrix()
end


function LeagueMainLayer:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(3000, -1, nil, handler(self.updateBuildingNameItems, self))
    end
end
function LeagueMainLayer:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:stopTimer(self.countDownTimer_)
        TFDirector:removeTimer(self.countDownTimer_)
        self.countDownTimer_ = nil
    end
end
-- --
return LeagueMainLayer