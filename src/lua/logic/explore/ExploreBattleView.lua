local ResLoader    = import("lua.logic.battle.ResLoader")
local ExploreBattleView = class("ExploreBattleView", BaseLayer)


local EventTypeEnum = {
    ROUND = 101,
    SKILL = 203,
    DAMAGE = 209,
    EFFECT_ON = 212,
    EFFECT_OFF = 214,
    EFFECT = 213,
    DIE = 210,
    END = 99,
}

local enumTipsType =
{
    YinRan    = 1,
    PuTong    = 2,
    FangYu     = 3,
}

function ExploreBattleView:initData(callBackCity,clickShipCallBack)
    self.tipsShowTime = 0.2
    self.nationChapter = 10101
    self.bezierMove = {}
    self.isBattling = false
    self.buffIcons = {}
    self.buffEffects = {}
    self.tipsArray = {}
    self.battleBgNodesMap = {}
    self.tipsDelayTime = 0
    self.skeletonOrder = 20
    self.skeletonUpOrder = 30
    self.skeletonDownOrder = 10
    self.callBackCity = callBackCity
    self.clickShipCallBack = clickShipCallBack
    --动作
    local afkAction = TabDataMgr:getData("AfkAction")
    self.actions_ = {}
    for k,v in pairs(afkAction) do
        self.actions_[v.modelResource] = self.actions_[v.modelResource] or {}
        self.actions_[v.modelResource][v.action] = v.modelAction
    end

    --音效
    self.musicDatas = {}
    self.musicDatas[1] = {}
    self.musicDatas[2] = {}
    self.musicDatas[3] = {}
    local datas = TabDataMgr:getData("SkillMusic")
    for _, data in pairs(datas) do
        self.musicDatas[data.cartoonType]                                   =
        self.musicDatas[data.cartoonType] or {}
        self.musicDatas[data.cartoonType][data.cartoonResource]             =
        self.musicDatas[data.cartoonType][data.cartoonResource] or {}
        self.musicDatas[data.cartoonType][data.cartoonResource][data.action] =
        self.musicDatas[data.cartoonType][data.cartoonResource][data.action] or {}
        for _, triggerEvent in ipairs(data.triggerEvents) do
            self.musicDatas[data.cartoonType][data.cartoonResource][data.action][triggerEvent] =
                self.musicDatas[data.cartoonType][data.cartoonResource][data.action][triggerEvent]  or {}
            table.insert(self.musicDatas[data.cartoonType][data.cartoonResource][data.action][triggerEvent],
                {resource = data.resource , volume = data.volume ,musicType = data.musicType  ,stopJudge = data.stopJudge })
        end
    end
    self.attributeCfgs = {}
    local shipAttribute = TabDataMgr:getData("ShipAttribute")
    for k,v in pairs(shipAttribute) do
        self.attributeCfgs[v.attributeId] = v
    end
    
end

function ExploreBattleView:ctor(callBackCity,clickShipCallBack)
    self.super.ctor(self)
    self:initData(callBackCity,clickShipCallBack)
    self:init("lua.uiconfig.explore.exploreBattleView")
end

function ExploreBattleView:initUI(ui)
    self.super.initUI(self, ui)
    self:showTopBar()
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
    self.Panel_attr = TFDirector:getChildByPath(self.Panel_prefab, "Panel_attr")

    self.Panel_normal_bg = TFDirector:getChildByPath(self.Panel_root, "Panel_normal_bg")
    self.Panel_battle_bg = TFDirector:getChildByPath(self.Panel_root, "Panel_battle_bg"):hide()
    self.Panel_content = TFDirector:getChildByPath(self.Panel_root, "Panel_content")
    self.Panel_effect = TFDirector:getChildByPath(self.Panel_root, "Panel_effect")
    self.Panel_animation = TFDirector:getChildByPath(self.Panel_root, "Panel_animation")
    self.Panel_role1 = TFDirector:getChildByPath(self.Panel_content, "Panel_role1")
    self.Panel_role2 = TFDirector:getChildByPath(self.Panel_content, "Panel_role2")
    self.Panel_clickShip = TFDirector:getChildByPath(self.Panel_role1, "Panel_clickShip")
    self.Panel_attrs = TFDirector:getChildByPath(self.Panel_content, "Panel_attrs"):hide()
    self.ListView_attrs = UIListView:create(TFDirector:getChildByPath(self.Panel_attrs, "ScrollView_attrs"))


    self.Spine_progress = SkeletonAnimation:create("effect/effects_feiji_qieping/effects_feiji_qieping")
    self.Panel_battle_bg:addChild(self.Spine_progress,10)
    self.Spine_progress:setPosition(ccp(0, 0))
    self.Spine_progress:play("animation", true)


    self.Spine_start = SkeletonAnimation:create("effect/effects_feiji_kaishi/effects_feiji_kaishi")
    self.Panel_animation:addChild(self.Spine_start)
    self.Spine_start:setPosition(ccp(0, 50))

    self.Image_hp1 = TFDirector:getChildByPath(self.Panel_content, "Image_hp1"):hide()
    self.LoadingBar_hp1 = TFDirector:getChildByPath(self.Panel_content, "LoadingBar_hp1")
    self.Image_hp2 = TFDirector:getChildByPath(self.Panel_content, "Image_hp2"):hide()
    self.LoadingBar_hp2 = TFDirector:getChildByPath(self.Panel_content, "LoadingBar_hp2")
    self.Label_hp1 = TFDirector:getChildByPath(self.Panel_content, "Label_hp1")
    self.Label_hp2 = TFDirector:getChildByPath(self.Panel_content, "Label_hp2")
    self.Image_round_bg = TFDirector:getChildByPath(self.Panel_content, "Image_round_bg"):hide()
    self.Label_round = TFDirector:getChildByPath(self.Panel_content, "Label_round")


    self.prefabNums = {}
    self.prefabNums[enumTipsType.YinRan]  = TFDirector:getChildByPath(self.Panel_prefab, "Node_yinran")
    self.prefabNums[enumTipsType.FangYu]    = TFDirector:getChildByPath(self.Panel_prefab, "Node_fangyu")
    self.prefabNums[enumTipsType.PuTong] = TFDirector:getChildByPath(self.Panel_prefab, "Node_putong")

    self:refreshBgUI()
    self:initSkeletonNode()
end

function ExploreBattleView:addAIBattleTimer( ... )
    -- body
    local baseTime = Utils:getKVP(90036,"baseTime")
    local randomValue = Utils:getKVP(90036,"randomTime")
    local randomTime = math.random(randomValue[1],randomValue[2])

    if self.aiTimer then
        TFDirector:stopTimer(self.aiTimer)
        TFDirector:removeTimer(self.aiTimer)
        self.aiTimer = nil
    end

    self.aiTimer = TFDirector:addTimer(baseTime+randomTime,1,nil,function ( ... )
        -- body
        local keys = table.keys(TabDataMgr:getData("AfkDrop"))
        local dropId = keys[math.random(1,#keys)]
        self:startNormalBattle({dropId = dropId},true)
        self:addAIBattleTimer()
    end)
end



function ExploreBattleView:startNormalBattle(data, isFalse)
    if self.bossBattle or (not self.isFalse and self.isBattling) then
        return
    end
    self.isFalse = isFalse
    self.normalBattle = true
    self.normalData = {}
    self.normalData.rewards = data.rewards or {}
    self.battleData = {}
    self.eventData = {}
    self.battleData.winner = 1
    self.player1Id = 1
    self.player1Hp = 1000
    self.player2Id = 2
    self.player2Hp = 1000
    self.maxHp1 = 1000
    self.maxHp2 = 1000
    self.enemyRoleScale = 1.0
    self.killSkillIdx = 0
    self.damageHurtIdx = 0
    self.dieIdx = 0
    local modleName = "ship1001"

    local AfkDropCfg = TabDataMgr:getData("AfkDrop", tonumber(data.dropId))
    local monsterCfg = TabDataMgr:getData("AfkMonster", AfkDropCfg.monster)
    modleName = monsterCfg.model
    self.enemyRoleScale = monsterCfg.modelSize
    local skills = ExploreDataMgr:getShipSkills(ExploreDataMgr:getWeaponTalent())
    local selfSkills = {}
    local enemySkills = {}
    for i,skillId in ipairs(skills) do
        local cfg = TabDataMgr:getData("AfkSkill", skillId)
        if cfg.skillType < 4 then
            table.insert(selfSkills, skillId)
        end
    end

    skills = ExploreDataMgr:getShipSkills(monsterCfg.talent)
    for i,skillId in ipairs(skills) do
        local cfg = TabDataMgr:getData("AfkSkill", skillId)
        if cfg.skillType < 4 then
            table.insert(enemySkills, skillId)
        end
    end
    print("selfSkills---enemySkills", selfSkills, enemySkills)
    local round = math.random(1,6)
    if round > 5 then
        round = 3
    elseif round > 1 then
        round = 2
    end
    for i=1,round do
        local skillId = selfSkills[math.random(1, #selfSkills)]
        local skillEvent = {event = EventTypeEnum.SKILL, intParams = {1,2,skillId}}
        table.insert(self.eventData, skillEvent)
        local hurtNumbers =  TabDataMgr:getData("AfkSkill", skillId).hurtNumbers or 1
        for j=1,hurtNumbers do
            local damageEvent = {event = EventTypeEnum.DAMAGE, intParams = {1,2,skillId}}
            table.insert(self.eventData, damageEvent)
        end
        if i < round then
            local skillId1 = enemySkills[math.random(1, #enemySkills)]
            local skillEvent1 = {event = EventTypeEnum.SKILL, intParams = {2,1,skillId1}}
            table.insert(self.eventData, skillEvent1)
            hurtNumbers =  TabDataMgr:getData("AfkSkill", skillId1).hurtNumbers or 1
            for k=1,hurtNumbers do
                local damageEvent = {event = EventTypeEnum.DAMAGE, intParams = {2,1,skillId1}}
                table.insert(self.eventData, damageEvent)
            end
        end
    end
    local dieEvent = {event = EventTypeEnum.DIE, intParams = {2}}
    local endEvent = {event = EventTypeEnum.END, intParams = {}}
    table.insert(self.eventData, dieEvent)
    table.insert(self.eventData, endEvent)
    
    self:createSkeletonNode(2, modleName)
    self:doRoleEnter(2, function ()
        self:doNormalBattle()
    end)
end

function ExploreBattleView:startBossBattle(data)
    if not data then
        return
    end
    self:refreshScene()
    self.Panel_effect:hide()
    self:clearBuffEffects()
    self.callBackCity(true)
    self.bossBattle = true
    self.battleData = data
    self.eventData = data.data
    self.roundIdx = 0
    for i,v in ipairs(self.battleData.fighters) do
        if v.type == 0 then
            self.player1Id = v.id
            self.player1Hp = v.hp
            self.maxHp1 = v.hp
        else
            self.player2Id = v.id
            self.player2Hp = v.hp
            self.maxHp2 = v.hp
        end
    end
    self:updateRound()
    self:updateRoleHp()
    self.killSkillIdx = 0
    self.damageHurtIdx = 0
    self.dieIdx = 0
    for idx = #self.eventData,1,-1 do
        local eventData = self.eventData[idx]
        if eventData.event == EventTypeEnum.DIE then
            self.dieIdx = idx
        end
        if self.dieIdx > 0 then
            if self.damageHurtIdx < 1 then
                if eventData.event == EventTypeEnum.DAMAGE then
                    self.damageHurtIdx = idx
                else
                    if eventData.event == EventTypeEnum.EFFECT then
                        local effectCfg = TabDataMgr:getData("AfkBuffEffect", eventData.intParams[2])
                        if effectCfg.atrId == 231 and  eventData.intParams[3] > 0 then
                            self.damageHurtIdx = idx
                        end
                    end
                end
            end            
        end
        if self.dieIdx > 0 and eventData.event == EventTypeEnum.SKILL then
            self.killSkillIdx = idx
            break
        end
    end
    self.timescale = false
    local monsterCfg = TabDataMgr:getData("AfkMonster", ExploreDataMgr:getCurFightBoss() or 1001)
    local modleName = monsterCfg.model
    self.enemyRoleScale = monsterCfg.modelSize

    self:createSkeletonNode(2, modleName)
    self:doBattleBgEnter()
end

function ExploreBattleView:setNationChapter(chapter)
    self.nationChapter = chapter
    self:refreshBgUI()
end

function ExploreBattleView:refreshBgUI()
    self.Panel_normal_bg:removeAllChildren()
    self.bgImagesMap = {}
    local bgIds = TabDataMgr:getData("AfkNationChapter", self.nationChapter).exploreBG1
    for k,id in pairs(bgIds) do
        local cfg = TabDataMgr:getData("AfkBgMove", id)
        local image1 = TFImage:create(cfg.picture)
        self.Panel_normal_bg:addChild(image1, cfg.picOrder)
        if cfg.moveSpeed <= 0 then
            image1:setAnchorPoint(ccp(0.5,0.5))
            image1:setPosition(ccp(0,0))
            self.bgImagesMap[id] = {image1 = image1, speed = cfg.moveSpeed}
        else
            image1:setAnchorPoint(ccp(0, 0.5))
            image1:setPosition(ccp(-self.Panel_normal_bg:getSize().width / 2, 0))
            local image2 = image1:clone()
            self.Panel_normal_bg:addChild(image2, cfg.picOrder)
            image2:setPosition(ccp(image1:getPositionX() + image1:getSize().width, 0))
            self.bgImagesMap[id] = {image1 = image1, image2 = image2, speed = cfg.moveSpeed}
        end
    end
end

function ExploreBattleView:setBgColor(color)
    if not color then
        return
    end

    for k,v in pairs(self.bgImagesMap) do
        if v.image1 then
            v.image1:setColor(color)
        end
        if v.image2 then
            v.image2:setColor(color)
        end
    end
end

function ExploreBattleView:initSkeletonNode()
    self.selfRoleScale = 1.0
    local afkRoleCfg = ExploreDataMgr:getShipCfg()
    local modleName = afkRoleCfg.fightResource
    self.selfRoleScale = afkRoleCfg.fightSize
    self:createSkeletonNode(1, modleName, afkRoleCfg.id)
    self.Panel_role2:hide()

    self.Panel_content:show()
end

function ExploreBattleView:createSkeletonNode(dir,modleName,id)
    local resPath
    if dir == 1 then
        resPath = string.format("effect/exploreSkinEffects/%s/%s", id, modleName)
    else
        resPath = string.format("effect/%s/%s", modleName, modleName)
    end 
    local skeletonNode = SkeletonAnimation:create(resPath)
    skeletonNode:setAnimationFps(GameConfig.ANIM_FPS)
    skeletonNode:setScheduleUpdateWhenEnter(true)
    skeletonNode:show()
    skeletonNode:setPosition(ccp(0,0))
    if dir == 1 then
        if self.skeletonNode1 then
            self.skeletonNode1:removeMEListener(TFARMATURE_EVENT)
            self.skeletonNode1:removeMEListener(TFARMATURE_COMPLETE)
            self.skeletonNode1:removeFromParent()
            self.skeletonNode1 = nil
        end
        self.skeletonNode1 = skeletonNode
        skeletonNode:setScale(self.selfRoleScale)
        skeletonNode:setScaleX(self.selfRoleScale)
        self.Panel_role1:addChild(skeletonNode,self.skeletonOrder)
        self.selfModleName = modleName
        skeletonNode:addMEListener(TFARMATURE_EVENT,handler(self.onArmtureEvent1,self))
        self.skeletonNode1:setTouchEnabled(true)
        self.skeletonNode1:onClick(function()
            --self:updateAttrsPanel()
            if self.clickShipCallBack then
                self.clickShipCallBack()
            end
        end)
    else
        if self.skeletonNode2 then
            self.skeletonNode2:removeMEListener(TFARMATURE_EVENT)
            self.skeletonNode2:removeMEListener(TFARMATURE_COMPLETE)
            self.skeletonNode2:removeFromParent()
            self.skeletonNode2 = nil
        end
        self.skeletonNode2 = skeletonNode
        skeletonNode:setScale(self.enemyRoleScale)
        skeletonNode:setScaleX(-self.enemyRoleScale)
        self.Panel_role2:addChild(skeletonNode,self.skeletonOrder)
        self.enemyModleName = modleName
        skeletonNode:addMEListener(TFARMATURE_EVENT,handler(self.onArmtureEvent2,self))
    end
    self:playAni(dir, self.actions_[modleName]["stand"], true)
end

function ExploreBattleView:updateAttrsPanel()
    if self.Panel_attrs:isVisible() then
        self.Panel_attrs:hide()
    else
        self.Panel_attrs:show()
        self.ListView_attrs:removeAllItems()
        local attrsInfo = ExploreDataMgr:getShipAttrsInfo() or {}
        local attrs = attrsInfo.attr or {}
        table.sort(attrs,function(a, b)
            local cfga = self.attributeCfgs[a.attrId]
            local cfgb = self.attributeCfgs[b.attrId]
            return cfga.order < cfgb.order
        end)
        for k,v in pairs(attrs) do
            local attConfig = self.attributeCfgs[v.attrId]
            if attConfig.isShow then
                local panel_attr = self.Panel_attr:clone()
                panel_attr:show()
                local Label_attr_name = TFDirector:getChildByPath(panel_attr, "Label_attr_name")
                local Label_attr_value = TFDirector:getChildByPath(panel_attr, "Label_attr_value")
                local attValue = v.baseValue / attConfig.division
                attValue = string.format("%."..attConfig.decimal.."f",attValue)
                attValue = string.format(attConfig.displayFormat,attValue)
                Label_attr_name:setTextById(tonumber(attConfig.name))
                Label_attr_value:setText(attValue)
                self.ListView_attrs:pushBackCustomItem(panel_attr)
            end
        end
    end
end

function ExploreBattleView:onArmtureEvent1()
    
end

function ExploreBattleView:onArmtureEvent2()
    
end

function ExploreBattleView:doNormalBattle()
    if not self.normalBattle then
        return
    end
    self.eventIndex = 0
    self.isBattling = true
    self.Panel_effect:show()
    self:doNextEvent()
end

function ExploreBattleView:doNormalRewardsShow()
    for i,v in ipairs(self.normalData.rewards) do
        local itemCfg = GoodsDataMgr:getItemCfg(v.id)
        local image = TFImage:create(itemCfg.icon)
        image:setPosition(ccp(300 + (i - 1) * math.random(50,80), math.random(-70, 130)))
        image:setScale(0.8)
        self.Panel_effect:addChild(image)
        image:setOpacity(0)
        local fadein  = FadeIn:create(0.2)
        local moveTo  = EaseSineIn:create(MoveTo:create(0.5, ccp(-300, 30)))
        local scale   = CCScaleTo:create(0.5,0.2)
        local move    = CCSpawn:create({moveTo,scale})
        local fadeout   = FadeOut:create(0.05)
        local callFunc = CallFunc:create(function()
                image:removeFromParent()
        end)
        local args=
        {
            fadein,
            move,
            fadeout,
            callFunc
        }
        image:runAction(Sequence:create(args))
    end
end

function ExploreBattleView:resetDatas()
    self.battleData = nil
    self.eventData = nil
    self.eventIndex = 9999
    self.isBattling = false
    self.bossBattle = false
    self.normalBattle = false
    self.killSkillIdx = 0
    self.damageHurtIdx = 0
    self.dieIdx = 0
end

function ExploreBattleView:refreshScene()
    self:resetDatas()
    self.Panel_battle_bg:hide()
    self.Panel_role2:hide()
    self.Image_hp1:hide()
    self.Image_hp2:hide()
    self.Image_round_bg:hide()
    if self.timescale then
        self.timescale = false
        if self.skeletonNode1 then
            self.skeletonNode1:setTimeScale(1.0)
        end
        if self.skeletonNode2 then
            self.skeletonNode2:setTimeScale(1.0)
        end
    end
    if not self.skeletonNode1:isVisible() then
        self.skeletonNode1:play(self.actions_[self.selfModleName]["stand"], true)
        self:doRoleEnter(1)
    else
        self.skeletonNode1:play(self.actions_[self.selfModleName]["stand"], true)
    end
end

function ExploreBattleView:doBattleBgEnter()
    self.battleBgNodesMap = {}
    local bgIds = TabDataMgr:getData("AfkNationChapter", self.nationChapter).exploreBG2
    for k,id in pairs(bgIds) do

        local cfg = TabDataMgr:getData("AfkBgMove", id)
        local image1 = TFImage:create(cfg.picture)
        self.Panel_battle_bg:addChild(image1, cfg.picOrder)
        if cfg.moveSpeed <= 0 then
            image1:setAnchorPoint(ccp(0,0.5))
            image1:setPosition(ccp(-self.Panel_battle_bg:getSize().width / 2, 0))
            image1:setOpacity(1)
            self.battleBgNodesMap[id] = {image1 = image1, speed = cfg.moveSpeed}
        else
            image1:setAnchorPoint(ccp(0, 0.5))
            image1:setPosition(ccp(-self.Panel_battle_bg:getSize().width / 2, 0))
            image1:setOpacity(1)
            local image2 = image1:clone()
            self.Panel_battle_bg:addChild(image2, cfg.picOrder)
            image2:setPosition(ccp(image1:getPositionX() + image1:getSize().width, 0))
            image2:setOpacity(1)
            self.battleBgNodesMap[id] = {image1 = image1, image2 = image2, speed = cfg.moveSpeed}
        end
    end
    self.Spine_progress:show()
    self.Spine_progress:setPositionX(-self.Panel_battle_bg:getSize().width / 2)
    self.Spine_start:hide()
    self.Panel_battle_bg:show()
    self.bgDurationTime = 1.2
    self.bgProgressTime = 1.2
    self.battleBgEnter = true
end

function ExploreBattleView:doBattleBgExit()
    self.Spine_progress:show()
    self.Spine_progress:setPositionX(self.Panel_battle_bg:getSize().width / 2)
    self.Spine_start:hide()
    self.Panel_battle_bg:show()
    self.bgDurationTime = 1.2
    self.bgProgressTime = 1.2
    self.battleBgExit = true
end

function ExploreBattleView:doBattleStart()
    self.Image_hp1:show()
    self.Image_hp2:show()
    self.Image_round_bg:show()
    self.Spine_start:show()
    self.Spine_start:play("animation", false)
    self.Spine_start:addMEListener(TFARMATURE_COMPLETE,function(skeletonNode)
        self.Spine_start:removeMEListener(TFARMATURE_COMPLETE)
        self.Spine_start:hide()
        self:startBattleShow()
    end)
end

local leftBezierPoints = {
    {ccp(-710,30),ccp(-610,180),ccp(-410,40),ccp(-210,30)},
    {ccp(-710,30),ccp(-610,30),ccp(-410,30),ccp(-210,30)},
    {ccp(-710,30),ccp(-610,-120),ccp(-410,20),ccp(-210,30)},
}

local rightBezierPoints = {
    {ccp(710,30),ccp(610,180),ccp(410,40),ccp(210,30)},
    {ccp(710,30),ccp(610,30),ccp(410,30),ccp(210,30)},
    {ccp(710,30),ccp(610,-120),ccp(410,20),ccp(210,30)},
}

function ExploreBattleView:doRoleEnter(dir, callBack)
    local randomIdx = math.random(1,3)
    local delayTime = DelayTime:create(1.2)
    local callFunc = CallFunc:create(function()
            if callBack then
                callBack()
            end
    end)
    local args=
    {
        delayTime,
        callFunc
    }
    if dir == 1 then
        local points = leftBezierPoints[randomIdx] or leftBezierPoints[1]
        self.Panel_role1:setPosition(points[1])
        self.Panel_role1:show()
        self.skeletonNode1:show()
        self.skeletonNode1:setScaleX(self.selfRoleScale)
        self.skeletonNode1:setPosition(ccp(0,0))
        table.insert(self.bezierMove,{node = self.Panel_role1, duration = 0.8, passTime = 0.0, points = points})
        self.Panel_role1:runAction(Sequence:create(args))
    else
        local points = rightBezierPoints[randomIdx] or rightBezierPoints[1]
        self.Panel_role2:setPosition(points[1])
        self.Panel_role2:show()
        self.skeletonNode2:show()
        self.skeletonNode2:setScaleX(-self.enemyRoleScale)
        self.skeletonNode2:setPosition(ccp(0,0))
        table.insert(self.bezierMove,{node = self.Panel_role2, duration = 0.8, passTime = 0.0, points = points})
        self.Panel_role2:runAction(Sequence:create(args))
    end
end

function ExploreBattleView:doRoleExit(dir, callBack)
    if dir == 1 then
        self.Panel_role1:show()
        self.skeletonNode1:show()
        self.Panel_role1:setPosition(ccp(-300,30))
        self.skeletonNode1:setScaleX(-self.selfRoleScale)
        local moveTo = MoveTo:create(1.0, ccp(-800, 30))
        local callFunc = CallFunc:create(function()
                self.Panel_role1:hide()
                self.skeletonNode1:hide()
                if callBack then
                    callBack()
                end
        end)
        local args=
        {
            moveTo,
            callFunc
        }
        self.Panel_role1:runAction(Sequence:create(args))
    else
        self.Panel_role2:show()
        self.skeletonNode2:show()
        local moveTo = MoveTo:create(1.5, ccp(-800, 30))
        local callFunc = CallFunc:create(function()
                self.Panel_role2:hide()
                self.skeletonNode2:hide()
                if callBack then
                    callBack()
                end
        end)
        local args=
        {
            moveTo,
            callFunc
        }
        self.Panel_role2:runAction(Sequence:create(args))
    end
end

function ExploreBattleView:getModelRealActionName(dir, action)
    if dir == 1 then
        return self.actions_[self.selfModleName][action] or self.actions_[self.selfModleName]["stand"]
    end
    return self.actions_[self.enemyModleName][action] or self.actions_[self.enemyModleName]["stand"]
end

function ExploreBattleView:doSkillEvent(eventIdx)
    local index = eventIdx or self.eventIndex
    local data = self.eventData[index]
    if data.event ~= EventTypeEnum.SKILL then
        return
    end
    local skillCfg = TabDataMgr:getData("AfkSkill", data.intParams[3])
    if skillCfg.skillType == 4 or skillCfg.skillType == 5 then
        return
    end
    self.curSkillIdx = index
    local atkId = data.intParams[1]
    local dir = atkId == self.player1Id and 1 or 2
    self:playAni(dir, self:getModelRealActionName(dir, skillCfg.action), false, function()
        
    end)
    local resPath = string.format("effect/%s/%s", skillCfg.effectResource, skillCfg.effectResource)
    local effect = SkeletonAnimation:create(resPath)
    effect:setScale(1.0)
    effect:show()
    self.Panel_effect:addChild(effect)
    self.curSkillEffect = effect
    effect:play(skillCfg.effectAction, false)
    if self.curSkillIdx == self.killSkillIdx then
        self.curSkillEffect:setTimeScale(0.4)
        self.skeletonNode1:setTimeScale(0.4)
        self.skeletonNode2:setTimeScale(0.4)
    end
    effect:addMEListener(TFARMATURE_EVENT,function( ... )
        local event = {...}
        if event[3] then
            if event[3] == "hurt" then
                self:doNextEvent(true, data.intParams[3])
            elseif event[3] == "music" then
                local musicDatas = self:getEffectMusicData(skillCfg.effectResource, skillCfg.effectAction, "music0")
                for i, musicData in ipairs(musicDatas) do
                    local volume = musicData.volume*0.01
                    local EffectVolume = TFAudio.getEffectsVolume()
                    if EffectVolume > 0 and volume > 0 then
                        TFAudio.playEffect(musicData.resource,false,1,0,volume)
                    end
                end
            end
        end
    end)

    effect:addMEListener(TFARMATURE_COMPLETE,function( ... )
        effect:removeMEListener(TFARMATURE_COMPLETE)
        effect:removeMEListener(TFARMATURE_EVENT)
        if self.curSkillIdx ~= self.killSkillIdx then
            effect:removeFromParent()
            self.curSkillEffect = nil
        end
    end)

    if atkId == self.player1Id then
        effect:setPosition(ccp(-220,30))
        effect:setScaleX(effect:getScaleX())
    else
        effect:setPosition(ccp(220,30))
        effect:setScaleX(-effect:getScaleX())
    end
end

function ExploreBattleView:doDamageEvent(eventIdx)
    local index = eventIdx or self.eventIndex
    local data = self.eventData[index]
    if data.event ~= EventTypeEnum.DAMAGE then
        return
    end
    if self.bossBattle then
        self:showDamageTip(data.intParams)
    else
        local dir = data.intParams[2] == self.player1Id and 1 or 2
        self:playAni(dir,self:getModelRealActionName(2, "hit"), false)
    end
end

function ExploreBattleView:doEffectOnEvent(eventIdx)
    local index = eventIdx or self.eventIndex
    local data = self.eventData[index]
    if data.event ~= EventTypeEnum.EFFECT_ON then
        return
    end
    local bindId = data.intParams[1]
    local dir = bindId == self.player1Id and 1 or 2

    local effectCfg = TabDataMgr:getData("AfkBuffEffect", data.intParams[2])
    if effectCfg.icon > 0 then
        self:refreshBuffIcon(dir, effectCfg, true)
    end
    if string.len(effectCfg.resource1) > 1 then
        self:refreshBuffEffect(dir, effectCfg, true)
    end
    self:showEffectOnOffTip(dir, effectCfg, callBack)
end

function ExploreBattleView:refreshBuffIcon(dir, effectCfg, isAdd)
    if not effectCfg then
        return
    end
    self.buffIcons[dir] = self.buffIcons[dir] or {}
    local num = table.count(self.buffIcons[dir])
    if isAdd then
        if num >= 5 or self.buffIcons[dir][effectCfg.id] then
            return
        end
        local image = TFImage:create(effectCfg.iconResource)
        self.Panel_effect:addChild(image)
        self.buffIcons[dir][effectCfg.id] = image
        num = num + 1
    else
        if self.buffIcons[dir][effectCfg.id] then
            self.buffIcons[dir][effectCfg.id]:removeFromParent()
            self.buffIcons[dir][effectCfg.id] = nil
            num = num - 1
        end
    end
    local idx = 1
    local baseX = dir == 1 and -400 or 200
    for k,node in pairs(self.buffIcons[dir]) do
        node:setPosition(ccp((baseX + (5 - num) * 15 + idx * 30),-20))
        idx = idx + 1
    end
end

function ExploreBattleView:getBonePosition(skeletonNode, boneName)
    local  pos    = skeletonNode:getBonePosition(boneName)
    local scaleX  = skeletonNode:getScaleX()
    local scaleY  = skeletonNode:getScaleY()
    pos.x = pos.x*scaleX
    pos.y = pos.y*scaleY

    return me.pAdd(skeletonNode:getPosition() , pos)
end

function ExploreBattleView:refreshBuffEffect(dir, effectCfg, isAdd)
    if not effectCfg then
        return
    end
    self.buffEffects[dir] = self.buffEffects[dir] or {}
    local num = table.count(self.buffEffects[dir])
    if isAdd then
        if num >= 5 or self.buffEffects[dir][effectCfg.id] then
            return
        end
        local resPath = string.format("effect/%s/%s", effectCfg.resource1, effectCfg.resource1)
        local effect = SkeletonAnimation:create(resPath)
        effect:show()
        local zorder = effectCfg.zorder1 > 1 and self.skeletonUpOrder or self.skeletonDownOrder
        if dir ==1 then
            self.Panel_role1:addChild(effect, zorder)
        else
            self.Panel_role2:addChild(effect, zorder)
            effect:setScaleX(-1)
        end
        effect:play(effectCfg.action1, true)
        self.buffEffects[dir][effectCfg.id] = effect
        local pos = self:getBonePosition(dir ==1 and self.skeletonNode1 or self.skeletonNode2, effectCfg.place1)
        effect:setPosition(pos)
    else
        if self.buffEffects[dir][effectCfg.id] then
            self.buffEffects[dir][effectCfg.id]:removeFromParent()
            self.buffEffects[dir][effectCfg.id] = nil
        end
    end
end

function ExploreBattleView:doEffectOffEvent(eventIdx)
    local index = eventIdx or self.eventIndex
    local data = self.eventData[index]
    if data.event ~= EventTypeEnum.EFFECT_OFF then
        return
    end
    local bindId = data.intParams[1]
    local dir = bindId == self.player1Id and 1 or 2
    local effectCfg = TabDataMgr:getData("AfkBuffEffect", data.intParams[2])
    if effectCfg.icon > 0 then
        self:refreshBuffIcon(dir, effectCfg, false)
        self:refreshBuffEffect(dir, effectCfg, false)
    end
end


function ExploreBattleView:doEffectEvent(eventIdx)
    local index = eventIdx or self.eventIndex
    local data = self.eventData[index]
    if data.event ~= EventTypeEnum.EFFECT then
        return
    end
    local bindId = data.intParams[1]
    local effectCfg = TabDataMgr:getData("AfkBuffEffect", data.intParams[2])
    if bindId == self.player1Id then
        self:showEffectTip(1, effectCfg, data.intParams, callBack)
    else
        self:showEffectTip(2, effectCfg, data.intParams, callBack)
    end
end

function ExploreBattleView:doDieEvent(eventIdx)
    local index = eventIdx or self.eventIndex
    local data = self.eventData[index]
    if data.event ~= EventTypeEnum.DIE then
        return
    end
    local atkId = data.intParams[1]
    local dir = atkId == self.player1Id and 1 or 2
    self:playAni(dir, self:getModelRealActionName(dir, "die"), false, function()
        if atkId == self.player1Id then
            self.Image_hp1:hide()
        else
            self.Image_hp2:hide()
        end
        self:doNextEvent()
    end)
end

function ExploreBattleView:doEndEvent(eventIdx)
    local index = eventIdx or self.eventIndex
    local data = self.eventData[index]
    if data.event ~= EventTypeEnum.END then
        return
    end
    self.Image_hp1:hide()
    self.Image_hp2:hide()

    if not self.bossBattle and self.normalBattle then
        self:doNormalRewardsShow()
        self:refreshScene()
        if self.callBackCity then
            self.callBackCity(false)
        end
    else
        self:showResult()
    end
    self:clearBuffEffects()
end

function ExploreBattleView:showResult()
    if self.battleData.winner == self.player1Id then
        local Spine_result = SkeletonAnimation:create("effect/effects_feiji_chenggong/effects_feiji_chenggong")
        self.Panel_animation:addChild(Spine_result,10)
        Spine_result:setPosition(ccp(0, 50))
        Spine_result:play("animation", false)

        Spine_result:addMEListener(TFARMATURE_COMPLETE,function()
            Spine_result:removeMEListener(TFARMATURE_COMPLETE)
            Spine_result:removeFromParent()
        end)
        self:doBattleBgExit()
    else
        local Spine_result = SkeletonAnimation:create("effect/effects_feiji_shibai/effects_feiji_shibai")
        self.Panel_animation:addChild(Spine_result,10)
        Spine_result:setPosition(ccp(0, 50))
        Spine_result:play("animation", false)

        Spine_result:addMEListener(TFARMATURE_COMPLETE,function()
            Spine_result:removeMEListener(TFARMATURE_COMPLETE)
            Spine_result:removeFromParent()
        end)
        self:doRoleExit(2, function ()
            self:doBattleBgExit()
        end)
    end
end

function ExploreBattleView:clearBuffEffects()
    for k,icons in pairs(self.buffIcons) do
        for i,node in pairs(icons) do
            node:removeFromParent()
        end
    end
    self.buffIcons = {}
    for k,effects in pairs(self.buffEffects) do
        for i,node in pairs(effects) do
            node:removeFromParent()
        end
    end
    self.buffIcons = {}
    self.buffEffects = {}
end

function ExploreBattleView:startBattleShow()
    self.eventIndex = 0
    self.isBattling = true
    self.Panel_effect:show()
    self:doNextEvent()
end

function ExploreBattleView:updateRoleHp()
    self.Label_hp1:setText("HP: "..self.player1Hp.."/"..self.maxHp1)
    self.Label_hp2:setText(self.player2Hp.."/"..self.maxHp2.." :HP")
    self.LoadingBar_hp1:setPercent(self.player1Hp / self.maxHp1 * 100)
    self.LoadingBar_hp2:setPercent(self.player2Hp / self.maxHp2 * 100)
end

function ExploreBattleView:doNextEvent(hurt, skillId)
    if not self.isBattling then
        return
    end
    local data = self.eventData[self.eventIndex + 1]
    if not data then
        return
    end
    if hurt then
        if data.event == EventTypeEnum.DAMAGE and skillId == data.intParams[3] then
            self.eventIndex = self.eventIndex + 1
            if self.killSkillIdx > 0 and self.damageHurtIdx == self.eventIndex then
                self.timescale = true
            end
            self:doDamageEvent()
            self:doNextEvent()
        end
        return
    else
        if data.event == EventTypeEnum.DAMAGE then
            return
        end
    end
    self.eventIndex = self.eventIndex + 1
    if data.event == EventTypeEnum.ROUND then
        self.roundIdx = self.roundIdx + 1
        self:updateRound()
    elseif data.event == EventTypeEnum.SKILL then
        self:doSkillEvent()
    elseif data.event == EventTypeEnum.EFFECT_ON then
        self:doEffectOnEvent()
    elseif data.event == EventTypeEnum.EFFECT_OFF then
        self:doEffectOffEvent()
    elseif data.event == EventTypeEnum.EFFECT then
        self:doEffectEvent()
    elseif data.event == EventTypeEnum.DIE then
        if not self.timescale then
            self:doDieEvent()
        end
        return
    elseif data.event == EventTypeEnum.END then
        if not self.timescale then
            self:doEndEvent()
        end
        return
    end
    self:doNextEvent()
end
function ExploreBattleView:updateRound()
    self.Label_round:setText("Round "..self.roundIdx)
end

function ExploreBattleView:showEffectOnOffTip(dir, cfg, callback)
    local text = cfg.triggerDes or ""
    if string.len(text) < 1 then
        return
    end
    table.insert(self.tipsArray, {dir = dir,values = {text}, tipsType = enumTipsType.PuTong,colorType = 1})
end

function ExploreBattleView:showEffectTip(dir, cfg, data, callback)
    if cfg.atrId ~= 231 and string.len(cfg.executeDes) < 1 then
        return
    end
    local text = cfg.executeDes or ""
    if data[3] then
        text = text..data[3]
        if cfg.atrId == 231 then
            local damage = data[3]
            if cfg.scale > 0 or cfg.transformScale > 0 then
                damage = -data[3]
            end
            if dir == 1 then
                self.player1Hp = math.max(self.player1Hp - damage, 0)
            else
                self.player2Hp = math.max(self.player2Hp - damage, 0)
            end
        end
    else
        text = ""
    end
    
    if data[4] and data[4] > 0 then
        text = text.."吸收"..data[4]
    end
    table.insert(self.tipsArray, {dir = dir,values = {text}, tipsType = enumTipsType.PuTong,colorType = 1})

    self:updateRoleHp()
end

function ExploreBattleView:showDamageTip(damageData, callback)
    local values = {}
    local colorType = 1
    if damageData[7] and damageData[7] > 0 then
        colorType = 5
        values[1] = "-"..damageData[4]
        values[2] = "偏斜吸收"..damageData[7]
    elseif damageData[6] and damageData[6] > 0 then
        colorType = 4
        values[1] = "-"..damageData[4]
        values[2] = "吸收"..damageData[6]
    elseif damageData[5] and damageData[5] == 1 then
        colorType = 3
        values[1] = "-"..damageData[4]
        values[2] = "穿透！"
    else
        colorType = 1
        values[1] = "-"..damageData[4]
    end
    
    local posx = math.random(300,380)
    local posy = math.random(40,100)
    local node = self:createNumNode(enumTipsType.PuTong, values, colorType)
    node:setOpacity(0)
    
    self.Panel_effect:addChild(node)
    if damageData[2] == self.player1Id then
        self.player1Hp = math.max(self.player1Hp - damageData[4], 0)
        node:setPosition(ccp(-posx, 70))
        self:playAni(1,self:getModelRealActionName(1, "hit"), false)
    else
        self.player2Hp = math.max(self.player2Hp - damageData[4], 0)
        node:setPosition(ccp(posx, 70))
        self:playAni(2,self:getModelRealActionName(2, "hit"), false)
    end
    self:updateRoleHp()
    local delayTime = 0.02
    local fadeInTime = 0.02
    if self.timescale then
        delayTime = 0.1
        fadeInTime = 0.3
    end
    local delay1  = DelayTime:create(delayTime)
    local fadein = FadeIn:create(fadeInTime)
    local scale1  = ScaleTo:create(0.06, 2)
    local scale2  = ScaleTo:create(0.04, 1)
    local delay2   = DelayTime:create(self.tipsShowTime)
    local spawn = Spawn:create({FadeOut:create(self.tipsShowTime), CCMoveBy:create(self.tipsShowTime,ccp(0,40))})
    local callFunc = CallFunc:create(function()
            node:removeFromParent()
            if self.timescale then
                self.timescale = false
                if self.curSkillEffect then
                    self.curSkillEffect:hide()
                    self.curSkillEffect:removeFromParent()
                    self.curSkillEffect = nil
                end
                self.skeletonNode1:setTimeScale(1.0)
                self.skeletonNode2:setTimeScale(1.0)
                self.eventIndex = self.dieIdx - 1
                self:doNextEvent()
            end
    end)
    local args=
    {
        delay1,
        fadein,
        scale1,
        scale2,
        delay2,
        spawn,
        callFunc
    }
    node:runAction(Sequence:create(args))
end

local colors = {
    {color = ccc3(255,255,255),outLine = ccc4(31,55,99,255)},
    {color = ccc3(255,235,106),outLine = ccc4(195,126,58,255)},
    {color = ccc3(255,80,80),outLine = ccc4(31,39,99,255)},
    {color = ccc3(164,253,69),outLine = ccc4(89,100,187,255)},
    {color = ccc3(92,205,253),outLine = ccc4(31,39,99,255)},
}

function ExploreBattleView:createNumNode(tipsType,values, colorType)

    local node      = self.prefabNums[tipsType]:clone()
    local Label_big    = node:getChildByName("Label_big")
    local Label_small    = node:getChildByName("Label_small")
    local imageSign = node:getChildByName("Image_sign")
    local color = colors[colorType]
    Label_big:setSkewX(15)
    Label_big:setText(tostring(values[1] or ""))
    Label_big:setColor(color.color)
    Label_big:enableOutline(color.outLine,1)
    if Label_small and values[2] then
        Label_small:setSkewX(15)
        Label_small:setText(tostring(values[2] or ""))
        Label_small:setColor(color.color)
        Label_small:enableOutline(color.outLine,1)
        Label_big:setAnchorPoint(ccp(1, 0.5))
        Label_big:setPosition(0,0)
        Label_small:setAnchorPoint(ccp(0, 0.5))
        Label_small:setPosition(0,0)
    end

    if imageSign then
        local size = bmFont:getSize()
        bmFont:setPositionX(10)
        imageSign:setPositionX(-size.width/2 - 10)
    end
    return node
end

function ExploreBattleView:playAni(dir, action, loop, completeCallback)
    local skeletonNode = (dir == 1) and self.skeletonNode1 or self.skeletonNode2
    if not skeletonNode then return end
    loop = not (not loop)
    local l = loop and 1 or 0
    skeletonNode:play(action, l)
    if l == 0 then
        skeletonNode:addMEListener(TFARMATURE_COMPLETE,function(skeletonNode)
            if action == "die" then
                skeletonNode:hide()
            else
                if (dir == 1 and self.player1Hp <= 0) or (dir == 2 and self.player2Hp <= 0) then

                else
                    skeletonNode:play(self:getModelRealActionName(dir, "stand"), true)
                end
            end 
            skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
            if completeCallback then
                completeCallback(skeletonNode)
            end
        end)
    else
        skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
    end
end

local powf = math.pow
local atan = math.atan2
local abs = math.abs
local function bezierat(  a,  b,  c,  d,  t )
    return (powf(1-t,3) * a +
            3*t*(powf(1-t,2))*b +
            3*powf(t,2)*(1-t)*c +
            powf(t,3)*d )
end

local function pGetAngle(point1,point2)
    local a2 = me.pNormalize(point1)
    local b2 = me.pNormalize(point2)
    local angle = atan(me.pCross(a2, b2), me.pDot(a2, b2) )
    if abs(angle) < 1.192092896e-7 then
        return 0.0
    end
    return angle
end

function ExploreBattleView:update(target , deltaTime)
    for k,v in pairs(self.bgImagesMap) do
        if v.speed > 0 and v.image2 then
            local pos1X = v.image1:getPositionX() - (deltaTime / 1 * v.speed)
            if (pos1X + v.image1:getSize().width) < (-self.Panel_normal_bg:getSize().width / 2 - 20) then
                v.image2:setPositionX(pos1X + v.image1:getSize().width)
                v.image1:setPositionX(v.image2:getPositionX() + v.image2:getSize().width)
                local temp = v.image2
                v.image2 = v.image1
                v.image1 = temp
            else
                v.image1:setPositionX(pos1X)
                v.image2:setPositionX(pos1X + v.image1:getSize().width)
            end
        end
    end

    for k,v in pairs(self.battleBgNodesMap) do
        if v.speed > 0 and v.image2 then
            local pos1X = v.image1:getPositionX() - (deltaTime / 1 * v.speed)
            if (pos1X + v.image1:getSize().width) < (-self.Panel_battle_bg:getSize().width / 2 - 20) then
                v.image2:setPositionX(pos1X + v.image1:getSize().width)
                v.image1:setPositionX(v.image2:getPositionX() + v.image2:getSize().width)
                local temp = v.image2
                v.image2 = v.image1
                v.image1 = temp
            else
                v.image1:setPositionX(pos1X)
                v.image2:setPositionX(pos1X + v.image1:getSize().width)
            end
        end
    end

    for i,v in ipairs(self.bezierMove) do
        if v.passTime <= v.duration then
            v.passTime = v.passTime + deltaTime
            local time = math.min(1,v.passTime/v.duration)
            local px = bezierat(v.points[1].x, v.points[2].x, v.points[3].x, v.points[4].x, time)
            local py = bezierat(v.points[1].y, v.points[2].y, v.points[3].y, v.points[4].y, time)
            local pos = v.node:getPosition()
            local subPos = ccp(px - pos.x,py - pos.y)
            local angel      = pGetAngle(me.p(0,0),me.p(subPos.x,subPos.y)) 
            local rotation   = math.deg(angel)
            v.node:setPosition(ccp(px, py))
            if subPos.x <= 0 then
                v.node:setRotation(-rotation + 180)
            else
                v.node:setRotation(-rotation)
            end
        else
            v.node:setPosition(v.points[4])
            v.node:setRotation(0)
            table.remove(self.bezierMove,i)
            break
        end
    end

    if self.battleBgEnter then
        self.bgProgressTime = self.bgProgressTime - deltaTime
        if self.bgProgressTime < 0 then
            self.battleBgEnter = false
            self.Spine_progress:hide()
            for k,v in pairs(self.battleBgNodesMap) do
                if v.image1 then
                    v.image1:setOpacity(255)
                end
                if v.image2 then
                    v.image2:setOpacity(255)
                end
            end
            self:doRoleEnter(2, function ()
                self:doBattleStart()
            end)
        else
            local percent = 1 - self.bgProgressTime / self.bgDurationTime
            for k,v in pairs(self.battleBgNodesMap) do
                if v.image1 then
                    v.image1:setOpacity(255*percent)
                end
                if v.image2 then
                    v.image2:setOpacity(255*percent)
                end
            end
            self.Spine_progress:setPositionX(-self.Panel_battle_bg:getSize().width / 2 + (1 - self.bgProgressTime / self.bgDurationTime) * (self.Panel_battle_bg:getSize().width + 50))
        end
    elseif self.battleBgExit then
        self.bgProgressTime = self.bgProgressTime - deltaTime
        if self.bgProgressTime < 0 then
            self.battleBgExit = false
            self.Spine_progress:hide()
            for k,v in pairs(self.battleBgNodesMap) do
                if v.image1 then
                    v.image1:removeFromParent()
                end
                if v.image2 then
                    v.image2:removeFromParent()
                end
            end
            self.battleBgNodesMap = {}
            self:refreshScene()
            if self.callBackCity then
                self.callBackCity(false)
            end
        else
            local percent = self.bgProgressTime / self.bgDurationTime
            for k,v in pairs(self.battleBgNodesMap) do
                if v.image1 then
                    v.image1:setOpacity(255*percent)
                end
                if v.image2 then
                    v.image2:setOpacity(255*percent)
                end
            end
            self.Spine_progress:setPositionX(self.Panel_battle_bg:getSize().width / 2 + 50 - (1 - self.bgProgressTime / self.bgDurationTime) * (self.Panel_battle_bg:getSize().width + 50))
        end
    end

    if self.tipsDelayTime > 0.15 then
        self.tipsDelayTime = 0
        if #self.tipsArray > 0 then
            local info = table.remove(self.tipsArray,1)
            local node = self:createNumNode(info.tipsType, info.values, info.colorType)
            local posy = math.random(80,100)
            if info.dir == 1 then
                node:setPosition(ccp(-300, posy))
            else
                node:setPosition(ccp(300, posy))
            end
            self.Panel_effect:addChild(node)
            local fadein   = FadeIn:create(0.1)
            local scale1  = ScaleTo:create(0.06, 2)
            local scale2  = ScaleTo:create(0.04, 1)
            local delay   = DelayTime:create(self.tipsShowTime)
            local spawn = Spawn:create({FadeOut:create(self.tipsShowTime), CCMoveBy:create(self.tipsShowTime,ccp(0,40))})
            local callFunc = CallFunc:create(function()
                    node:removeFromParent()
            end)
            local args=
            {
                fadein,
                scale1,
                scale2,
                delay,
                spawn,
                callFunc
            }
            node:runAction(Sequence:create(args))
        end
    else
        self.tipsDelayTime = self.tipsDelayTime + deltaTime
    end
end

local function check(musicData,prams)
    local len = #prams
    for index, pram in ipairs(prams) do
        musicData = musicData[pram]
        if index < len then
            if not musicData then
                return {}
            end
        else
            if musicData then
                return musicData
            else
                return {}
            end
        end
    end
end

--角色音效事件触发
function ExploreBattleView:getActorMusicDatas(resource,action,event)
    local prams = {resource,action,event}
    return check(self.musicDatas[1],prams)
end
--特效音效事件触发
function ExploreBattleView:getEffectMusicData(resource,action,event)
    local prams = {resource,action,event}
    return check(self.musicDatas[2],prams)
end
--剧情音效事件
function ExploreBattleView:getScriptSoundData(resource,action,event)
    local prams = {resource,action,event}
    return check(self.musicDatas[3],prams)
end

function ExploreBattleView:onShow()
    self.super.onShow(self)
end

function ExploreBattleView:registerEvents()
    self:addMEListener(TFWIDGET_ENTERFRAME, handler(self.update, self))

    self.Panel_clickShip:onClick(function()

    end)
    self:addAIBattleTimer()
end

function ExploreBattleView:removeEvents()
    self:removeMEListener(TFWIDGET_ENTERFRAME)
    if self.aiTimer then
        TFDirector:stopTimer(self.aiTimer)
        TFDirector:removeTimer(self.aiTimer)
        self.aiTimer = nil
    end
end

return ExploreBattleView

