local KabalaTreeConcealBoss = class("KabalaTreeConcealBoss", BaseLayer)

function KabalaTreeConcealBoss:ctor(eventId,oilCost,param)
    self.super.ctor(self)
    self:initData(eventId,oilCost,param)
    self:showPopAnim(true)
    self:init("lua.uiconfig.kabalaTree.kabalaTreeConcealBoss")
end

function KabalaTreeConcealBoss:initData(eventId,oilCost,param)

    --self.levelCid = 102105
    self.costEnergy = oilCost
    self.levelCid = param[1]
    self.eventId = eventId
    self.DungeonLevelCfg = TabDataMgr:getData("DungeonLevel")[self.levelCid]
    if not self.DungeonLevelCfg then
        Box("self.ambushId:"..self.levelCid.." is Wrong")
        return
    end
    self.isDisableHero_ = (self.DungeonLevelCfg.heroLimitType == EC_LimitHeroType.DISABLE)
end

function KabalaTreeConcealBoss:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui

    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")
    self.Label_title = TFDirector:getChildByPath(self.ui, "Label_title")
    self.Button_leave = TFDirector:getChildByPath(self.ui, "Button_leave")
    self.Button_fight = TFDirector:getChildByPath(self.ui, "Button_fight")

    self.Image_leftbg = TFDirector:getChildByPath(self.ui, "Image_leftbg")
    self.Image_head = TFDirector:getChildByPath(self.Image_leftbg, "Image_head")
    self.Label_bossdesc = TFDirector:getChildByPath(self.Image_leftbg, "Label_bossdesc")

    self.Panel_right = TFDirector:getChildByPath(self.ui, "Panel_right")
    self.Image_title_1 = TFDirector:getChildByPath(self.Panel_right, "Image_title_1")
    self.Label_title1 = TFDirector:getChildByPath(self.Image_title_1, "Label_title")
    self.Image_title_2 = TFDirector:getChildByPath(self.Panel_right, "Image_title_2")
    self.Label_title2 = TFDirector:getChildByPath(self.Image_title_2, "Label_title")
    self.Label_time_title = TFDirector:getChildByPath(self.Panel_right, "Label_time_title")
    self.Image_bar = TFDirector:getChildByPath(self.Panel_right, "Image_bar")
    self.LoadingBar_blood = TFDirector:getChildByPath(self.Panel_right, "LoadingBar_blood")
    self.Label_leftBlood = TFDirector:getChildByPath(self.Panel_right, "Label_leftBlood")
    self.Label_time = TFDirector:getChildByPath(self.Panel_right, "Label_time")
    self.Image_gb = TFDirector:getChildByPath(self.Panel_right, "Image_gb")

    self.Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab")
    self.Panel_bagItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_bagItem")

    local ScrollView_reward = TFDirector:getChildByPath(self.ui, "ScrollView_reward")
    self.ListView_reward = UIListView:create(ScrollView_reward)
    self.ListView_reward:setItemsMargin(5)

    self:initUILogic()
end

function KabalaTreeConcealBoss:initUILogic()

    self.Label_title:setTextById(3003019)
    self.Label_title1:setTextById(300620)
    self.Label_title2:setTextById(300620)
    self.Label_time_title:setTextById(3004048)

    self:updateBossInfo()
    self:updateChallengeTime()
    self:updateBossBlood()
end

function KabalaTreeConcealBoss:updateBossInfo()

    if not self.DungeonLevelCfg then
        return
    end

    local bossGroupId = self.DungeonLevelCfg.monsterGroupId
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
    if monserCfg then
        dump(monserCfg.fightIcon)
        self.Image_head:setTexture(monserCfg.fightIcon)
    end

    local curWorld = KabalaTreeDataMgr:getCurWorld()
    local worldCfg = KabalaTreeDataMgr:getWorldCfg(curWorld)
    if worldCfg then
        self.Label_bossdesc:setTextById(worldCfg.extraMissionDescription)
        local showReward = worldCfg.extraItemShow
        for k,v in pairs(showReward) do
            local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            Panel_goodsItem:setScale(0.8)
            PrefabDataMgr:setInfo(Panel_goodsItem, v)
            self.ListView_reward:pushBackCustomItem(Panel_goodsItem)
        end
    end
end

function KabalaTreeConcealBoss:updateChallengeTime()

    local curWorld = KabalaTreeDataMgr:getCurWorld()
    local state,time = KabalaTreeDataMgr:getWorldState(curWorld)
    local leftTime = time - ServerDataMgr:getServerTime()
    if leftTime >= 0 then
        local timeStr = KabalaTreeDataMgr:formateTime(leftTime)
        self.Label_time:setText(timeStr)
    else
        self.Label_time:setText("")
    end
    local seqact = Sequence:create({
        DelayTime:create(1),
        CallFunc:create(function()
            local leftTime = time - ServerDataMgr:getServerTime()
            local timeStr = KabalaTreeDataMgr:formateTime(leftTime)
            self.Label_time:setText(timeStr)
            if leftTime <= 0 then
                self.Label_time:stopAllActions()
            end
        end)
    })
    self.Label_time:runAction(CCRepeatForever:create(seqact))
end

function KabalaTreeConcealBoss:updateBossBlood()

    local bossPercent,maxBossBlood
    local initHiddentEvent = KabalaTreeDataMgr:getInitHiddenEvent()
    for eventId,percent in pairs(initHiddentEvent) do
        local eventType = KabalaTreeDataMgr:getTileEventRes(self.eventId)
        if eventType == Enum_TriggerEventType.EventType_ConcealBoss then
            maxBossBlood = 100
            bossPercent = 0
            break
        end
    end

    local hideEvent = KabalaTreeDataMgr:getHiddenEventInfo()
    if hideEvent[self.eventId] then
        bossPercent = hideEvent[self.eventId][1] or 0
        maxBossBlood = hideEvent[self.eventId][2] or 100
    end

    if not maxBossBlood or not bossPercent then
        return
    end

    local curBossBlood = maxBossBlood - bossPercent
    local percent = math.floor(curBossBlood / maxBossBlood * 100)
    local pentcentOne = maxBossBlood/100
    if curBossBlood < pentcentOne then
        percent = 1
    end

    self.LoadingBar_blood:setPercent(percent)

    local bloodText = TextDataMgr:getText(3004047,percent)
    self.Label_leftBlood:setText(bloodText.."%")
    if percent <= 12 then
        self.Label_leftBlood:AnchorPoint(me.p(0, 0.5))
        self.Label_leftBlood:setPositionX(-12)
    elseif percent >= 88 then
        self.Label_leftBlood:AnchorPoint(me.p(1, 0.5))
        self.Label_leftBlood:setPositionX(12)
    else
        self.Label_leftBlood:AnchorPoint(me.p(0.5, 0.5))
        self.Label_leftBlood:setPositionX(0)
    end
    local width = self.Image_bar:getContentSize().width
    local posX = width * percent/100 + (-width/2)
    self.Image_gb:setPositionX(posX)
end

function KabalaTreeConcealBoss:registerEvents()

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_leave:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_fight:onClick(function()
        if self.levelCid == 0 then
            Utils:showTips(3005003)
        else
            Utils:openView("kabalaTree.KabalaTreeFight",self.levelCid,self.costEnergy,true)
            AlertManager:closeLayer(self)
        end
    end)
end

return KabalaTreeConcealBoss