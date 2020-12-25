local KabalaTreeFight = class("KabalaTreeFight", BaseLayer)

function KabalaTreeFight:ctor(ambushId,oilCost,isHiddenBoss)
    self.super.ctor(self)
    self:initData(ambushId,oilCost,isHiddenBoss)
    self:init("lua.uiconfig.kabalaTree.kabalaTreeFight")
end

function KabalaTreeFight:initData(ambushId,oilCost,isHiddenBoss)
    self.name = "FubenSquadView"
    self.ambushId = ambushId--102105
    self.oilCost = oilCost or 0
    self.isHiddenBoss = isHiddenBoss
    print("self.ambushId",self.ambushId,self.oilCost)
    self.DungeonLevelCfg = TabDataMgr:getData("DungeonLevel")[self.ambushId]
    if not self.DungeonLevelCfg then
        Box("self.ambushId:"..self.ambushId.." is Wrong")
        return
    end
    self.isDisableHero_ = (self.DungeonLevelCfg.heroLimitType == EC_LimitHeroType.DISABLE)
end

function KabalaTreeFight:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui
    self:showTopBar()

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Button_ok = TFDirector:getChildByPath(self.ui, "Button_ok")
    self.okBtnTx = TFDirector:getChildByPath(self.Button_ok, "Label_btn")
    --队伍
    self.Label_teamName = TFDirector:getChildByPath(self.ui, "Label_teamName")
    self.teamInfo = {}
    for i = 1, 3 do
        local item = {}
        item.root = TFDirector:getChildByPath(self.ui, "Panel_team_member" .. i)
        item.Panel_role = TFDirector:getChildByPath(item.root, "Panel_role")
        item.Button_head = TFDirector:getChildByPath(item.root, "Button_head")
        item.Panel_model = TFDirector:getChildByPath(item.Panel_role, "Panel_model")
        item.Image_captain = TFDirector:getChildByPath(item.Panel_role, "Image_captain")
        item.Label_name = TFDirector:getChildByPath(item.Panel_role, "Label_name")
        item.Image_disable_type = TFDirector:getChildByPath(item.Panel_role, "Image_disable_type")
        item.Label_disable_type = TFDirector:getChildByPath(item.Image_disable_type, "Label_disable_type")
        item.Panel_add = TFDirector:getChildByPath(item.root, "Panel_add")
        item.Button_add = TFDirector:getChildByPath(item.Panel_add, "Button_add")
        item.Label_empty = TFDirector:getChildByPath(item.Panel_add, "Label_empty")
        item.effectBg = TFDirector:getChildByPath(item.root,"Image_effect")
        item.barBg = TFDirector:getChildByPath(item.effectBg,"Image_effect_barbg")
        item.bar = TFDirector:getChildByPath(item.barBg,"LoadingBar_effect")
        item.barnum = TFDirector:getChildByPath(item.effectBg,"Label_num")
        item.effectName = TFDirector:getChildByPath(item.effectBg,"Label_effect_name")
        item.effectName:setTextById(3004053)
        item.effectName:setSkewX(15)
        self.teamInfo[i] = item
    end

    --通关
    self.killHead = {}
    self.Label_passName = TFDirector:getChildByPath(self.ui, "Label_passName")
    self.Label_condition_tx = TFDirector:getChildByPath(self.ui, "Label_condition_tx")
    self.Image_head_bg = TFDirector:getChildByPath(self.ui, "Image_head_bg")
    for i=1,4 do
       local tab = {}
       tab.headbg = TFDirector:getChildByPath(self.Image_head_bg, "Image_head_"..i)
       tab.head = TFDirector:getChildByPath(tab.headbg, "Image_head")
       tab.num = TFDirector:getChildByPath(tab.headbg, "Label_num")
       self.killHead[i] = tab
    end


    --掉落
    self.Label_dropName = TFDirector:getChildByPath(self.ui, "Label_dropName")
    self.Panel_drop = TFDirector:getChildByPath(self.ui, "Panel_drop")

    self.Label_costtip = TFDirector:getChildByPath(self.ui, "Label_costtip")
    self.Label_num = TFDirector:getChildByPath(self.ui, "Label_num")
    self.Image_icon = TFDirector:getChildByPath(self.ui, "Image_icon")

    local ScrollView_reward = TFDirector:getChildByPath(self.Panel_drop, "ScrollView_reward")
    self.ListView_reward = UIListView:create(ScrollView_reward)

    KabalaTreeDataMgr:setFightViewFlag(true)

    --若过通过聊天打开了查看阵容界面，会改变自己的阵容

    local isLayerInQueue,layer = AlertManager:isLayerInQueue("FairyDetailsLayer")
    if isLayerInQueue then
        AlertManager:closeLayer(layer)
    end

    local isLayerInQueue,layer = AlertManager:isLayerInQueue("FairyMainLayer")
    if isLayerInQueue then
        AlertManager:closeLayer(layer)
    end

    local isLayerInQueue,layer = AlertManager:isLayerInQueue("PlayerInfoView")
    if isLayerInQueue then
        AlertManager:closeLayer(layer)
    end

    HeroDataMgr:changeDataToSelf()

    self:initUiInfo()
end

function KabalaTreeFight:initUiInfo()

    self.Label_teamName:setTextById(100000063)
    self.Label_passName:setTextById(100000111)
    self.Label_dropName:setTextById(300129)
    self.Label_costtip:setTextById(300020)
    self.okBtnTx:setTextById(100000114)
    self.Label_num:setText(self.oilCost)
    local itemCfg = GoodsDataMgr:getItemCfg(500025)
    if itemCfg then
        self.Image_icon:setTexture(itemCfg.icon)
    end

    local _type = self.DungeonLevelCfg.victoryType[1]
    if _type == 3 then
        self.Label_condition_tx:setTextById(3005039)
        self.Image_head_bg:setVisible(true)

        for i=1,4 do
            local param = self.DungeonLevelCfg.victoryParam[i]
            if param then
                self.killHead[i].headbg:setVisible(true)
                local monsterCfg = TabDataMgr:getData("Monster", param[1])
                self.killHead[i].head:setTexture(monsterCfg.fightIcon)
                self.killHead[i].num:setText("X"..param[2])
            else
                self.killHead[i].headbg:setVisible(false)
            end
        end

    else
        local desc = FubenDataMgr:getPassCondDesc(self.ambushId, 1)
        self.Label_condition_tx:setText(desc)
        self.Image_head_bg:setVisible(false)
    end

    self:calMoveRect()
    self:onUpdateTeamInfo()
    self:updateDrop()
end

function KabalaTreeFight:calMoveRect()
    self.moveRect_ = {}
    for i, v in ipairs(self.teamInfo) do
        local anchorPoint = v.root:getAnchorPoint()
        local size = v.root:getContentSize()
        local offset = ccp(size.width * anchorPoint.x, size.height * anchorPoint.y)
        local pos = v.root:getPosition()
        local origin = me.pSub(pos, offset)
        self.moveRect_[i] = me.rect(origin.x, origin.y, size.width, size.height)
    end
end

function KabalaTreeFight:onUpdateTeamInfo()

    self.formationData_ = {}
    self.forbidHero = {}
    self.formation = KabalaTreeDataMgr:getFormation()
    local leaderId = HeroDataMgr:getTeamLeaderId()
    for i = 1, 3 do
        local heroId = self.formation[i]
        local isNotEmpty = heroId and true or false

        self.teamInfo[i].Panel_add:setVisible(not isNotEmpty)
        self.teamInfo[i].Panel_role:setVisible(isNotEmpty)
        self.teamInfo[i].effectBg:setVisible(isNotEmpty)
        if heroId then
            table.insert(self.formationData_,{type = EC_BattleHeroType.OWN, id = heroId})
            local nameId = HeroDataMgr:getNameStrId(heroId)
            local nameStr = TextDataMgr:getText(nameId)
            self.teamInfo[i].Label_name:setText("「" .. nameStr .. "」")

            self.teamInfo[i].Image_captain:setVisible(i==1)

            local skinid = HeroDataMgr:getCurSkin(heroId)
            local skinData = TabDataMgr:getData("HeroSkin", skinid)
            self.teamInfo[i].Button_head:setTextureNormal(skinData.backdrop)

            local model = Utils:createHeroModel(heroId, self.teamInfo[i].Panel_model, 0.45, skinid)
            model:update(0.1)
            model:stop()

            --设置感染度
            local infectionValue,maxValue,fightMax = KabalaTreeDataMgr:getInfectionsByHeroId(heroId)
            local percent = (infectionValue/maxValue)*100
            self.teamInfo[i].barnum:setText(percent.."%")
            self.teamInfo[i].bar:setPercent(percent)
            if infectionValue >= fightMax then
                table.insert(self.forbidHero,nameStr)
            end
            self.teamInfo[i].Image_disable_type:setVisible(infectionValue >= fightMax)
            self.teamInfo[i].Label_disable_type:setTextById(3005014)
        end

    end

end

function KabalaTreeFight:updateDrop()
    local multipleReward, extraReward, allMultiple = ActivityDataMgr2:getDropReward(self.DungeonLevelCfg.reward)
    -- 掉落活动额外掉落
    for i, v in ipairs(extraReward) do
        local Panel_dropGoodsItem = PrefabDataMgr:getPrefab("Panel_dropGoodsItem"):clone()
        Panel_dropGoodsItem:Scale(0.8)
        PrefabDataMgr:setInfo(Panel_dropGoodsItem, {v}, EC_DropShowType.ACTIVITY_EXTRA)
        self.ListView_reward:pushBackCustomItem(Panel_dropGoodsItem)
    end
    -- 基础掉落
    for k, v in pairs(self.DungeonLevelCfg.dropShow) do
        local Panel_dropGoodsItem = PrefabDataMgr:getPrefab("Panel_dropGoodsItem"):clone()
        Panel_dropGoodsItem:Scale(0.8)
        local flag = 0
        local arg = {}
        local multiple = multipleReward[v]
        if multiple then
            flag = bit.bor(flag, EC_DropShowType.ACTIVITY_MULTIPLE)
            arg.multiple = multiple
        end
        if allMultiple > 0 then
            flag = bit.bor(flag, EC_DropShowType.ACTIVITY_MULTIPLE)
            arg.multiple = allMultiple
        end
        if isFirstPass then
            flag = bit.bor(flag, EC_DropShowType.FIRST_PASS)
        end
        PrefabDataMgr:setInfo(Panel_dropGoodsItem, {v}, flag, arg)
        self.ListView_reward:pushBackCustomItem(Panel_dropGoodsItem)
    end
end

function KabalaTreeFight:fight()

    if #self.formationData_ ~= 3 then
        Utils:showTips(3005006)
        return
    end

    --能源点数
    local energy = KabalaTreeDataMgr:getEnergy()
    if energy < self.oilCost then
        Utils:showTips(3005003)
        return
    end


    if #self.forbidHero > 0 then
        local heroName = self.forbidHero[1]
        Utils:showTips(100000064)
        return
    end

    local levelGroupCfg = FubenDataMgr:getLevelGroupCfg(self.DungeonLevelCfg.levelGroupId)
    if levelGroupCfg then
        FubenDataMgr:cacheSelectFubenType(EC_FBType.ACTIVITY)
        FubenDataMgr:cacheSelectLevelGroup(self.DungeonLevelCfg.levelGroupId)
        FubenDataMgr:cacheSelectChapter(levelGroupCfg.dungeonChapterId)
    end

    local battleController = require("lua.logic.battle.BattleController")
    local heros = {}
    for i, v in ipairs(self.formationData_) do
        table.insert(heros, {v.type, v.id})
    end
    local assistantPlayerId = 0
    local assistantHeroCid = 0

    local enabled = true
    if self.isDisableHero_ then
        for i, v in ipairs(self.formationData_) do
            if table.indexOf(self.levelCfg_.heroForbiddenID, v.data.cid) ~= -1 then
                enabled = false
                break
            end
        end
    end
    if enabled then
        battleController.requestFightStart(self.ambushId, 0, 0, heros)
        if self.isHiddenBoss then
            local data = self:getBossBloodInfo()
            dump(data)
            battleController.setSpecifyMonster(data)
        end
  
        KabalaTreeDataMgr:setInWorldFage(false)
    else
        Utils:showTips(2100035)
    end
end

function KabalaTreeFight:getBossBloodInfo()

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
    if not monserCfg then
        Box("wrong monsterId:"..monsterId)
        return
    end

    local monsterLevelCfg = TabDataMgr:getData("MonsterLevel")[monserCfg.monsterType]
    if not monsterLevelCfg then
        return
    end

    local playerLv = MainPlayer:getPlayerLv()
    local maxBossBlood = monsterLevelCfg.baseAttr[1] + monsterLevelCfg.upAttr[1]*math.pow(playerLv+2,1.5)*0.5
    maxBossBlood = math.floor(maxBossBlood * 0.01)
    print("maxBossBlood",maxBossBlood)
    local woundedBlood = 0
    local hideEvents = KabalaTreeDataMgr:getHiddenEventInfo()
    for eventId,percent in pairs(hideEvents) do
        local eventType,eventRes,smallRes,offset,scaleInMap,targetTab = KabalaTreeDataMgr:getTileEventRes(eventId)
        if eventType == Enum_TriggerEventType.EventType_ConcealBoss then
            woundedBlood = percent[1] or 0
            maxBossBlood = percent[2] or maxBossBlood
            break
        end
    end

    local curBlood = maxBossBlood-woundedBlood
    local data = {}
    data[monsterId] = {
        [1] = maxBossBlood,
        [52] = curBlood
    }

    return data

end

function KabalaTreeFight:registerEvents()

    EventMgr:addEventListener(self,EV_UPDATE_FORMATION,handler(self.onUpdateTeamInfo, self))

    self.Button_ok:onClick(function()
        self:fight()
    end)

    for i=1,3 do
        self.teamInfo[i].Button_add:onClick(function()
            Utils:openView("kabalaTree.KabalaTreeFormation",i)
        end)
    end

    for i=1,3 do
        self.teamInfo[i].Button_head:onClick(function()
            Utils:openView("kabalaTree.KabalaTreeFormation",i)
        end)

        self.teamInfo[i].Button_head:onTouch(function(event)
                local target = event.target
                if event.name == "began" then
                    if not self.formationData_[i] then return end
                    local heroId = self.formationData_[i].id
                    local skinid = HeroDataMgr:getCurSkin(heroId)
                    local skinData = TabDataMgr:getData("HeroSkin", skinid)
                    self.Panel_cloneRole = self.teamInfo[i].Panel_role:clone():hide()
                    local Panel_model = TFDirector:getChildByPath(self.Panel_cloneRole, "Panel_role.Panel_model")
                    local model = Utils:createHeroModel(heroId, Panel_model, 0.45, skinid)
                    model:update(0.1)
                    model:stop()
                    self.teamInfo[i].Panel_add:show()
                    for j, foo in ipairs(self.teamInfo) do
                        if j == i then
                            foo.root:ZO(2)
                        else
                            foo.root:ZO(1)
                        end
                    end
                    self.teamInfo[i].Panel_role:getParent():Add(self.Panel_cloneRole)
                    self.teamInfo[i].__movePos = target:getTouchStartPos()
                elseif event.name == "moved" then
                    if not self.Panel_cloneRole then return end
                    if not self.formationData_[i] then return end
                    local movePos = target:getTouchMovePos()
                    local offset = me.pSub(movePos, self.teamInfo[i].__movePos)
                    self.teamInfo[i].__movePos = movePos
                    local pos = self.Panel_cloneRole:getPosition()
                    self.Panel_cloneRole:Pos(me.pAdd(pos, offset)):show()
                    self.teamInfo[i].Panel_role:hide()

                elseif event.name == "ended" then
                    if not self.Panel_cloneRole then return end
                    if not self.formationData_[i] then return end
                    local endPos = target:getTouchEndPos()
                    local np = self.Panel_root:convertToNodeSpaceAR(endPos)
                    local index
                    for i, v in ipairs(self.moveRect_) do
                        if me.rectContainsPoint(v, np) then
                            index = i
                            break
                        end
                    end
                    if index and index ~= i and self.formationData_[index] then
                        local fromFormationData = self.formationData_[i]
                        local toFormationData = self.formationData_[index]
                        self:replaceFormation(fromFormationData.id, toFormationData.id)
                    end
                    self.teamInfo[i].Panel_role:show()
                    self.teamInfo[i].Panel_add:hide()
                    self.Panel_cloneRole:removeFromParent()
                end
        end)
    end
end

function KabalaTreeFight:replaceFormation(fromHeroId, toHeroId)

    if not fromHeroId or not toHeroId then
        return
    end

    local msg = {
        fromHeroId,
        toHeroId
    }
    TFDirector:send(c2s.QLIPHOTH_OPERATE_FORMATION, msg)

end

return KabalaTreeFight