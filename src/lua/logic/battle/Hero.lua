local BattleConfig = import(".BattleConfig")
local BattleUtils  = import(".BattleUtils")
local BattleMgr    = import(".BattleMgr")
local Buffer       = import(".Buffer")
local AwakeMgr     = import(".AwakeMgr")
local StateMgr    = import(".StateMgr")
local Operate     = import(".Operate")
local ActionMgr   = import(".ActionMgr")
local ResLoader   = import(".ResLoader")
local levelParse  = import(".LevelParse")
local enum        = import(".enum")
local eAnimation  = enum.eAnimation
local eSkillType  = enum.eSkillType
local eState      = enum.eState
local eStateEvent = enum.eStateEvent
local eEvent      = enum.eEvent
local eRoleType   = enum.eRoleType
local eDir        = enum.eDir
local eMonsterType = enum.eMonsterType
local eBuffStateType = enum.eBuffStateType
local eHurtType   = enum.eHurtType
local eAngerRule   = enum.eAngerRule
local eVKeyCode    = enum.eVKeyCode
local eKeyEventType = enum.eKeyEventType
local eArmtureEvent= enum.eArmtureEvent
local ePlaceType = enum.ePlaceType
local eAttrType  = enum.eAttrType
local eBFState   = enum.eBFState
local eAState    = enum.eAState
local eShowState = enum.eShowState
local eCampType  = enum.eCampType
local ePointTargetType = enum.ePointTargetType
local eBufferEffectIconEvent = enum.eBufferEffectIconEvent
local eColorType = enum.eColorType
local eBFEffectType = enum.eBFEffectType
local eBFSkillEvent = enum.eBFSkillEvent
local eFlag = enum.eFlag
local Form  = import(".Form")
local Skill = import(".Skill")
local Actor = import(".Actor")
local Property     = import(".PropertyEx")
local StateMachine = import(".StateMachine")
local AIAgent = import(".AIAgent")
local CountDown  = import(".CountDown")
local bufferMgr = BattleMgr.getBufferMgr()
local Debug = print
local __print = print
local _print = BattleUtils.print
local print  = BattleUtils.print
local heroMgr = BattleMgr.getHeroMgr()
local effectMgr = BattleMgr.getEffectMgr() --特效管理器
local Hero = class("Hero")
local EventTrigger = import(".EventTrigger")
local Energy = import(".Energy")
local SuperArmor = import(".SuperArmor")
local BattleTimerManager = import(".BattleTimerManager")
local GameObject = import(".GameObject")
local BattleGuide = import(".BattleGuide")
local Recorder = import(".Recorder")

local eMoveState = {
    Target = 0,  --目标位置
    Fallow = 1,  --跟随
    Patrol = 2,  -- 巡逻
    FixedMove = 3,    -- 助战跟随
}

local AIactionType = {
    act_useSkill = 1,
    act_patrol = 2,
    act_pathFinding = 3,
    act_follow = 4,
    act_switchModel = 5,
    act_delay = 6,
    act_setPosition = 7,
    act_setHpPercent = 8,
    act_killMySelf = 9,
    act_playEffect = 10,
    act_triggetBuffer = 11,
    act_setDir = 12,
    act_moveToPositon = 13,
}

local function __setSkeletonNodeDir( skeletonNode,dir )
    local scaleX = math.abs(skeletonNode:getScaleX())
    if dir == eDir.LEFT then
        skeletonNode:setScaleX(-scaleX)
    else
        skeletonNode:setScaleX(scaleX)
    end
end


local skill_type_disable = {}
skill_type_disable[eAState.E_SKILLTYPE_1_DISABLE] = eVKeyCode.SKILL_A
skill_type_disable[eAState.E_SKILLTYPE_2_DISABLE] = eVKeyCode.SKILL_C
skill_type_disable[eAState.E_SKILLTYPE_3_DISABLE] = eVKeyCode.SKILL_D
skill_type_disable[eAState.E_SKILLTYPE_4_DISABLE] = eVKeyCode.SKILL_E
skill_type_disable[eAState.E_SKILLTYPE_5_DISABLE] = eVKeyCode.SKILL_B
skill_type_disable[eAState.E_SKILLTYPE_6_DISABLE] = eVKeyCode.SKILL_F
skill_type_disable[eAState.E_SKILLTYPE_7_DISABLE] = eVKeyCode.SKILL_I
skill_type_disable[eAState.E_SKILLTYPE_8_DISABLE] = eVKeyCode.SKILL_H
skill_type_disable[eAState.E_SKILLTYPE_10_DISABLE] = eVKeyCode.SKILL_G

local skill_type_disable_cd = {}
skill_type_disable_cd[eAState.E_SKILLTYPE_1_DISABLE_CD] = eVKeyCode.SKILL_A 
skill_type_disable_cd[eAState.E_SKILLTYPE_2_DISABLE_CD] = eVKeyCode.SKILL_C 
skill_type_disable_cd[eAState.E_SKILLTYPE_3_DISABLE_CD] = eVKeyCode.SKILL_D 
skill_type_disable_cd[eAState.E_SKILLTYPE_4_DISABLE_CD] = eVKeyCode.SKILL_E 
skill_type_disable_cd[eAState.E_SKILLTYPE_5_DISABLE_CD] = eVKeyCode.SKILL_B 
skill_type_disable_cd[eAState.E_SKILLTYPE_6_DISABLE_CD] = eVKeyCode.SKILL_F 
skill_type_disable_cd[eAState.E_SKILLTYPE_7_DISABLE_CD] = eVKeyCode.SKILL_I 
skill_type_disable_cd[eAState.E_SKILLTYPE_8_DISABLE_CD] = eVKeyCode.SKILL_H
skill_type_disable_cd[eAState.E_SKILLTYPE_10_DISABLE_CD] = eVKeyCode.SKILL_G


function Hero:ctor(data,team,host)
    -- dump(data,"data")
    self.host = host
    if host then --如果有召唤宿主 保存召唤宿主ID
        self.nCallHostId = host:getObjectID()
        if host:getRoleType() == eRoleType.Hero then
            self.bCallFriend = true
        end
    end 
    self.timeScale = 1
    self.nUnlimitedHp  = 10000000
    self.headShowIndex = data.headShowIndex or 0
    self.position3D    = me.Vertex3F(0,0,0)
    self.lastPsition3D = me.Vertex3F(0,0,0)
    self.actionNames = {} --BattleDataMgr:getActionNames(data.model)
    --属性变更缓存
    self.attrTypeList = {}
    self.flags = {}
    --形态
    self.skinIndex = 1
    self.actionMgr = ActionMgr.createMgr()
    self.operate = Operate:new(self)
    --测试攻击范围
    self.atkRect  = me.rect(data.area[1],data.area[2],data.area[3],data.area[4])               --me.rect(-100,-20,200,50)

    self.data = data
    self.data = BattleDataMgr:getHeroDataByAngle(data,self:getAngleDatas())
    self.team = team
    self.camp = self.data.camp
    -- 技能参数
    self.limitArea = self.data.limitArea
    self.area = self.data.area

     self.bufferEffectMap = {}

    self.skillMap = {}  --key类型
    self.skillList = {}
    self.dynamicDatas = {}

    -- 速度缩放
    self.nSpeedScale = 1
    self.pathList  = {}
    --移动状态
    self.moveState = -1

    --浮空保护时间
    self.nFloatTime = 0
    --记录和动作相关的音效，动作切换时停止未播放完的音效
    self.soundEffects = {}

    -- 出生计时
    self.showTiming_ = 0

    --释放的技能
    self.skill    = nil
    -- 寻路计时
    self.pathTiming = 0

    -- 当前技能(AI)
    self.curSkill = nil

    self.bFight = false

    self.isAIEnable = true

    -- 是否暂停伤害统计
    self.isHurtValuePause = false

    --记录受击的技能ID
    self.nLastBloodSkillGroupId = 0

    --当前攻击的特效
    self.effetList = {}
    --Buffer 列表
    self.bufferList     = {}

    --检查是否有词缀
    self:checkMonsterAffixs()
    if team then
        --记录出生时间
        self.nBornTime    = BattleUtils.gettime()
        --基础属性
        self.property = Property.new()
        self.property:parseFrom(self.data,host)
        if self.data.unlimitedHp == 2 then --指定血量
            local _attrs = battleController.getSpecifyMonsterInfo(self.data.id)
            if _attrs then 
                for k ,v in pairs(_attrs) do
                    if k < 50 then 
                        self.property:setBaseValue(k,v)
                    else 
                        self.property:setValue(k,v)
                    end
                end
            end
        end

        if self.data.__hp then 
            self.property:setValue(eAttrType.ATTR_NOW_HP,self.data.__hp)
        end
        self.property:setListener(handler(self.onAttrTrigger,self))

        self:addExtraProperty()
        --附加状态
        self.stateMgr = StateMgr:new(self)
        self:createBufferList()

        --切换角色冷却管理器
        local roleType = self.data.roleType
        if roleType == eRoleType.Hero then
            if self.data.enterField > 0 then
                self.countDown = CountDown:create(self.data.enterField)
                self.countDown:setListener(handler(self.onCountDown,self))
            end
        end
            --附加状态 then return end
        --创建技能
        self:createSkills()
        --创建Actor
        self:createActor()

        self:createFSM()


        --敌方队伍不需要播放战斗结束动画
        if not self.data.isPlayVictorAction then
            self:setFlag(eFlag.EndOfBattle)
            self:setFlag(eFlag.PlayedEndAction)
        end

        --能量获取/消耗处理
        if self.data.heroPower and self.data.heroPower > 0 then
            self.energyData = BattleDataMgr:getEnergyData(self.data.heroPower,self:getAngleDatas())
            self.energyMgr = Energy:new(self.energyData,self)
        end
        if self.data.stiffness and self.data.stiffness > 0 then
            self.superArmorMgr = SuperArmor:new(self)
        end

        -- 寻路检测计时
        self.pathCheckTiming = 0
        -- 寻路检测间隔时间
        self.pathCeckInterval = 1000

        --AI操作数容器
        self.AIStepDatas = {}
        self.AIStepCD = 0
        self.aiUseSkillTime = 10000

        self.preCastSkillData = {}

        --互斥音效列表
        self.effectMutexList = {}
        self.recorder = Recorder:new()

        if BattleDataMgr:isMusicGameLevel() then
             self:setPracticeInfinite(true)
        end
        self.skillDamageFlag = 0  --AI技能是否造成伤害
    end
    self.eventData_ = {}

end
--锤子的范围
function Hero:getRoller()
    local value = self:getPositionY()
    return value , value
end


--是否是召唤怪
function Hero:getCallHostId()
    return self.nCallHostId 
end

--获取所有召唤的角色
function Hero:getCallHeros()
    local heros = self.team:getHerosEx()
    local result = {}
    for i, hero in ipairs(heros) do
        if hero:getCallHostId() == self:getObjectID() then
            table.insert(result,hero)
        end
    end
    table.sort(result,function ( a,b )
        return a.nBornTime < b.nBornTime
    end)
    return result
end

--获取出身的时间
function Hero:getBornTime()
    return self.nBornTime
end

function Hero:doDrop()
    local realDropID = self.data.realDropID
    if realDropID and  realDropID > 0 then
        local height   = self.data.zPos or 0
        local propData = TabDataMgr:getData("BattleDrop",realDropID)
        local prop     = GameObject.createProp(propData)
        local position = ccp(self.position3D.x,self.position3D.y)
        prop:setPosition(position)
        if height > 0 then 
            prop:setRenderNodePos(ccp(0,height))
        end
        if prop:getData().needJump then
            prop:runAction(JumpTo:create(0.5, position, 60, 1))
        end
        prop:active()
    end
end

--添加额外属性变更
function Hero:addExtraProperty()
    --社团士气值影响
    local attrs = LeagueDataMgr:getFightAttrChange(self:getRoleType())
    for k,value in pairs(attrs) do
        self.property:changeValue(tonumber(k), value)
    end

    --地错特定加成属性
    local levelCfg = BattleDataMgr:getLevelCfg()
    if levelCfg.useLinkAgeAttr then
        attrs = FubenDataMgr:getLinkAgeHeroAttrsByHeroId(self.data.id)
        for k,value in pairs(attrs) do
            self.property:changeValue(tonumber(k), value)
        end
    end
end

function Hero:recvExchangeAttr(srcHero,attrs)
    if srcHero and attrs then
        for k,v in pairs(attrs) do
            self.property:changeValue(tonumber(k), srcHero:getValue(tonumber(k)) * (v / 10000))
        end
    end
end

--检查添加怪物词缀
function Hero:checkMonsterAffixs()
    self.affixData = {}
    if self.data.affix and self.data.affix > 0 then
        local affixData = TabDataMgr:getData("MonsterAffix",self.data.affix)
        if affixData then
            affixData.strName = "【"..TextDataMgr:getText(affixData.affixName).."】"
            table.insert(self.affixData,affixData)
        end
    end

    local monsterType = self:getMonsterType()
    --社团额外词缀
    if monsterType == eMonsterType.MT_ELITE or monsterType == eMonsterType.MT_BOSS then
        local affixs = LeagueDataMgr:getCurBossBuffers()
        for k,affixId in pairs(affixs or {}) do
            local affixData = TabDataMgr:getData("MonsterAffix",affixId)
            if affixData then
                affixData.strName = "【"..TextDataMgr:getText(affixData.affixName).."】"
                table.insert(self.affixData,affixData)
            end
        end
    end

    local levelCfg = BattleDataMgr:getLevelCfg()
    if levelCfg.levelAffix and levelCfg.levelAffix.affixList then
        for i,affixId in ipairs(levelCfg.levelAffix.affixList) do
            for j,camp in ipairs(levelCfg.levelAffix.camp) do
                if self:getCamp() == camp then
                    local affixData = TabDataMgr:getData("MonsterAffix",affixId)
                    if affixData then
                        affixData.strName = "【"..TextDataMgr:getText(affixData.affixName).."】"
                        affixData.levelAffix = true
                        affixData.isShowOnHero = levelCfg.levelAffix.isShowOnHero
                        table.insert(self.affixData,affixData)
                    end
                end
            end
        end
    end

end

--怪物词缀
function Hero:getAffixData()
    return self.affixData
end

--是否有词缀
function Hero:hasAffixData()
    return self.affixData and #self.affixData > 0
end

--是否更新怪物血条面板
function Hero:enableUpdateBossPanel()
    if self:isBoss() then
        return true
    end
    if self:getCampType() == eCampType.Monster and self:hasAffixData() then
        return
    end
    return false
end

function Hero:getAffixDataIcons()
    local icons = {}
    if self.affixData then
        for i,v in ipairs(self.affixData) do
            if v.levelAffix then
                if v.isShowOnHero and v.isShowOnHero == 1 then
                    for index=1,5 do
                        local affixIcon = v["affixIcon"..index]
                        if ResLoader.isValid(affixIcon) then 
                            table.insert(icons, affixIcon)
                        end
                    end
                end
            else
                for index=1,5 do
                    local affixIcon = v["affixIcon"..index]
                    if ResLoader.isValid(affixIcon) then 
                        table.insert(icons, affixIcon)
                    end
                end
            end
        end
    end
    return icons
end

function Hero:getEnergyData()
    return self.energyData  --or {powerName="测试",powerUI =1}
end

--设置阵营为初始阵营
function Hero:resetCamp()
    self.camp = self.data.camp
end

--设置阵营(目前只为buff服务,只有普通怪和精英怪生效生效)
function Hero:setCamp(camp)
    self.camp = camp
    -- if self:getMonsterType() == eMonsterType.MT_NORMAL
    --     or self:getMonsterType() == eMonsterType.MT_ELITE then
    --     self.camp = camp
    -- end
end

--所属阵营
function Hero:getCamp()
    return self.camp
end

function Hero:getCampType()
    local camp = self:getCamp()
    if camp == 1 then
        return eCampType.Hero
    elseif (camp >= 2 and camp <= 5) or (camp >= 51 and camp <= 70)  then
        return eCampType.Monster
    elseif camp >= 6 and camp <= 10 then
        return eCampType.Other
    elseif camp >= 11 and camp <= 50 then
        return eCampType.Call
    else
        return eCampType.Other
    end
end

function Hero:getRoleType()
    return self.data.roleType
end

function Hero:addSoundEffect(handle)
    if handle and handle > 0 then
        self.soundEffects[#self.soundEffects + 1] = handle
    end
end
--切换动作时停止和动作相关音效
function Hero:stopSoundEffect()
    if #self.soundEffects > 0 then
        for i , handle in ipairs(self.soundEffects) do
            if TFAudio.isEffectPlaying(handle) then
                TFAudio.stopEffect(handle)
            end
        end
        self.soundEffects = {}
    end
end
--角色受击框名称列表
function Hero:getBodyArea()
    return self.data.bodyArea
end

--招架判定
function Hero:isTriggerParry(dir)
    if self.skill then
        return self.skill:isTriggerParry(dir)
    end
end

--清空敌路径
function Hero:cleanPath()
    self.pathList = {}
end
--寻路
function Hero:findPath(position)
    if not battleController.canMove(position.x,position.y) then
        self.pathList = {}
        return self.pathList
    end
    self.pathList = battleController.findPath(self,position)
    return self.pathList
end

--造成的伤害统计
function Hero:addHurtValue(value,hero)
    if self.aiAgent then
        self.skillDamageFlag = BattleUtils.gettime()
    end
    if battleController.isZLJH() then --组队追猎计划只统计 对boss的伤害 
        if hero and not hero:isBoss() then 
            return
        end
    end
    if not battleController.enableAddHurt(hero) then
        return
    end
    value = math.floor(value)
    if not self.data.hurtValue then
        self.data.hurtValue = 0
    end
    if battleController.isLockStep() then
        self.data.hurtValue = self.data.hurtValue + value
        battleController.synchronHurtValue(self)
        EventMgr:dispatchEvent(eEvent.EVENT_STATUS_HERO,self) 
    else
        self.data.hurtValue = self.data.hurtValue + value
    end
    --被召唤的角色伤害也要统计为宿主伤害
    if self.host and self.host:isAlive() then
        self.host:addHurtValue(value,hero)
    end
end

function Hero:checkskillDamageFlag(skillId)
    if self.lastSkillCid and self.lastSkillCid == skillId and (BattleUtils.gettime() -self.skillDamageFlag) < 3000 then
        self.skillDamageFlag = 0
        return true
    end
    return false
end

--造成的伤害统计
function Hero:addRevHurtValue(value)
    value = math.floor(value)
    if not self.data.revHurtValue then
        self.data.revHurtValue = 0
    end
    self.data.revHurtValue = self.data.revHurtValue + math.abs(value)
end
--收到的伤害统计
function Hero:getRevHurtValue()
    return self.data.revHurtValu or 0
end
--伤害修正 组队状态同步用
function Hero:fixHurtValue(value)
    if self.data.hurtValue then
        self.data.hurtValue = 0
    end
    if value > self.data.hurtValue then
        self.data.hurtValue = value
    end
    EventMgr:dispatchEvent(eEvent.EVENT_STATUS_HERO,self) 
end

function Hero:getHurtValue()
    return self.data.hurtValue or 0
end

--buffer 用变身
function Hero:changeSkinEx(formId,objectID)
    local changeInfo = self.changeInfo
    self.changeInfo =  {}
    self.changeInfo.new =  formId
    self.changeInfo.objectID = objectID
    if changeInfo then 
        self.changeInfo.old = changeInfo.old
    else
        if self.curForm then 
            self.changeInfo.old = self.curForm:getDataId()
        else
            self.changeInfo.old = self.data.beginForm
        end
    end
    self:changeSkin(formId,true)
end

function Hero:recoverySkin(objectID)
    if self.changeInfo and self.changeInfo.objectID == objectID then
        self:changeSkin(self.changeInfo.old,true)
        self.changeInfo = nil
    end
end

function Hero:combatCustomSkills(originSkills)
    local customSkills = battleController.getCustomSkills(originSkills, self)
    return customSkills
end

function Hero:changeSkin(formId,force)
    if self.curForm then 
        if self.curForm:getDataId() == formId then
            return
        end
    end
    -- print_("changeSkin"..tostring(formId))
    local _form
    for i,form in ipairs(self.forms) do
        if form:getDataId() == formId then
            _form = form 
        end
    end
    --找不到创建新的
    if not _form then 
        local data = TabDataMgr:getData("HeroForm",formId)
        _form = Form:new(data,self)
        table.insert(self.forms,_form)
    end
    self.curForm = _form
    self:resetActionNames() --更新动作列表
    --时间派发
    if self.curForm:getActionIndex() == 1 then
        self:onEventTrigger(eBFState.E_TRANS_1,self)
    elseif self.curForm:getActionIndex() == 2 then
        self:onEventTrigger(eBFState.E_TRANS_2,self)
    end

    self.curForm:reset()
    local roleType = self.data.roleType
    if roleType == eRoleType.Monster
    or roleType == eRoleType.Assist
    or roleType == eRoleType.Trap then
        self:endToAI() 
        -- if not self.curForm.aiAgent then
        --     self.curForm.aiAgent = AIAgent:new(self,self.curForm:getAI())
        -- end
        self.aiAgent = self.curForm.aiAgent
        if self.bCallFriend then
            self.aiAgent:setEnabledEX(true)
        end
    end
    EventMgr:dispatchEvent(eEvent.EVENT_CAPTAIN_CHANGE)
    --创建新模型
    self.actor:createSkeletonNode()
    --创建粒子
    local particleEffect = self.curForm.data.particleEffect
    if particleEffect and #particleEffect > 0 then 
        -- Box("self.curForm.data.particleEffect"..tostring(particleId))
        self.actor:createParticle(particleEffect)
    end
    if force then
        local state = self:getState()
        if state == eState.ST_DEPARTURE then --在离场
            self:doDepartureOver() --处理离场
        else
            self:doEvent(eStateEvent.BH_STAND)
        end
    end
end
--变身完成处理
function Hero:doDepartureOver()
    if battleController.isClearing then --战斗结束
        self:getActor():hide()
        if self.data.roleType == eRoleType.Assist then
            self:setFlag(eFlag.PlayedEndAction)
        end
    else
        self:print("离场完成")
        --角色离场后还原为第一形态
        self.skinIndex = 1
        --强制设置到地面上,防止切换待机的时候 释放下落技能
        -- self.actor:fixPosition()
        self:setPositionZ(self.position3D.y)
        self:cancelToStand()
        self:removeFrormBattle()
        local captain = battleController.getCaptain()
        battleController.setCaptain(captain)
    end
end

function Hero:isOnWalkingSurface()
    local position = self:getPosition3D()
    return levelParse:canMove(position.x, position.y)
end

--改变形态
-- function Hero:changeSkin(skinIndex)
--     if self.skinIndex == 1 then
--         if self:hasMultipleSkin() then --是否有第二形态
--             self.skinIndex = 2
--             EventMgr:dispatchEvent(eEvent.EVENT_CAPTAIN_CHANGE)
--             self:onEventTrigger(eBFState.E_TRANS_1,self)
--             _print("切换第二形态")
--         end
--     else
--         self.skinIndex = 1
--         --刷新技能按钮
--         EventMgr:dispatchEvent(eEvent.EVENT_CAPTAIN_CHANGE)
--         self:onEventTrigger(eBFState.E_TRANS_2,self)
--         _print("切换第一形态")
--     end
-- end

function Hero:resetActionNames()
    local model = self.curForm:getData().model
    self.actionNames = BattleDataMgr:getActionNames(model)
end

--是否配置动作名称
function Hero:isCustumActionName(action)
    if self.actionNames then
        if self.actionNames[self.skinIndex][action] then
            return true
        end
    end
end

--怪物AI变身(仅限怪物AI变身单一形态下使用) 1 - 2
function Hero:setActionIndex(actionIndex)
    if self.curForm then
        self.curForm:setActionIndex(actionIndex)
    end
end

function Hero:getActionIndex()
    if self.curForm then
        return self.curForm:getActionIndex()
    end
    return 1
end

--获取当前形态ID
function Hero:getFormId()
    if self.curForm then
        return self.curForm:getDataId()
    end
    return 0
end

--获取动作配置
function Hero:getRoleAction(action)
    if self.actionNames then
        return self.actionNames[self:getActionIndex()][action]
    end
end
--保存动作的数据
function Hero:setRoleAction(data)
    self.roleAction = data
end

function Hero:getActionName(action)
    local data = self:getRoleActionData(action)
    if data then
        return data.realAction
    end
    return action
end

function Hero:getOperate()
    return self.operate
end

function Hero:setRokeVector(vx,vy)
    self.operate:setRokeVector(vx,vy)
end

function Hero:getRokeVector()
    local vector = self.operate:getRokeVector()
    -- if vector.x < 0 then
    --     vector.x = -1
    -- elseif vector.x > 0 then
    --     vector.x = 1
    -- end
    --混乱角色移动方向相反
    if self:isAState(eAState.E_HUN_LUAN) then
        return ccp(vector.x*-1,vector.y*-1)
    else
        return vector
    end
end


function Hero:matchKeyEvent(...)
    return self.operate:matchKeyEvent(...)
end

function Hero:createAndPush(keyCode,eventType,skillSubId)
    if not self:isFlag(eFlag.FirstUpdate) then
        return
    end
    if self:isValidKey(keyCode) then
        self.operate:createAndPush(keyCode,eventType,skillSubId)
    end
end

--怪物類型
function Hero:getMonsterType()
    return self.data.type or 0
end

--生物类型
function Hero:getBodyType()
    -- print_(self:getName().." BodyType:"..self.data.subType)
    return self.data.subType or 0
end

local Monster_icon = 
{
    [0]={[1]=101,[2]=102,[3]=103},
    [1]={[1]=201,[2]=202,[3]=203},
    [2]={[1]=301,[2]=302,[3]=303},
    [3]={[1]=401,[2]=402,[3]=403},
}

--获取图标
function Hero:getMonsterIcon()
    local subType = self:getBodyType()
    local _type   = self:getMonsterType()
    if Monster_icon[subType] then 
        return Monster_icon[subType][_type]
    end
end

--切换角色冷却进度
function Hero:getProgress()
    if self.countDown then
        return self.countDown:getProgress()
    end
end
--切换角色冷却的剩余时间
function Hero:getRemainTime()
    if self.countDown then
        return math.ceil(self.countDown:getRemainTime()*0.001)
    end
    return 0
end

function Hero:onCountDown(progress)
    --TODO 通知UI刷新CD进度
    EventMgr:dispatchEvent(eEvent.EVENT_ENTER_BATTLE_CD ,self, progress)
end
function Hero:getName()
    return self.data.strName
end

function Hero:getPName()
    return self.data.pname or ""
end

function Hero:getObjectID()
    return self.id
end
--真实状态
-- E_DONG_JIE   = 18,   -- 18 冻结
-- E_XUAN_YUN   = 19,   -- 19 眩晕
-- E_FU_KONG    = 20,   -- 20 浮空
-- E_JING_ZHI   = 21,   -- 21 静止
-- E_DAO_DI     = 22,   -- 22 倒地
-- E_QIAN_YIN   = 23,   -- 23 牵引（强制位移）
---

function Hero:getAStateCount(state)
    return self.stateMgr:getStateCount(state)
end
--移除一个附加状态
function Hero:clearAState(state)
    self.stateMgr:clearState(state)
end

function Hero:forceClearAState_(state)
    self.stateMgr:forceClearState(state)
end

--是否生效一个附加状态
function Hero:isAState(state)
    if state == eAState.E_FMYX then
        for k , effect in ipairs(self.bufferEffectMap) do
            if effect:isNegative() then
                return true
            end
        end
        return false
    elseif state == eAState.E_FORM_1 then  --是否处于第一形态
        return self:getActionIndex() == 1
    elseif state == eAState.E_FORM_2 then   --是否处于第二形态
        return self:getActionIndex() == 2
    elseif state == eAState.E_FU_KONG then   --浮空状态
        --受击状态下才算浮空
        return self:getState() == eState.ST_FLOAT
    elseif state == eAState.E_DAO_DI then  --倒地状态
        return self:getState() == eState.ST_FALL
    elseif state == eAState.E_BA_TI or state == eAState.E_BA_TI_EX  then
        --抵抗值>0 也为霸体状体
        if self:getResist() > 0 then
            return true
        end
        if self:getState() == eState.ST_SKILL then
            if self.skill then
                if self.skill:isActionHard() > 0 then
                    return true
                end
            end
        end
    end
    return self.stateMgr:isState(state)
end
--增加一个附加状态
function Hero:addAState(state,objectID)
        _print("Hero:addAState",self:getName() , state)
    return self.stateMgr:addState(state,objectID)
end
--移除一个附加状态
function Hero:delAState( state ,objectID)
    self.stateMgr:delState(state,objectID)
end

function Hero:onAStateClear(state)
    --TODO 眩晕状态移除
    if state == eAState.E_XUAN_YUN then
        if self:getState() == eState.ST_VERTIGO then
            local animation
            if self.actor then
                animation = self.actor:getFixAnimation()
            end
            if animation == eAnimation.FLOOR then
                self:doEvent(eStateEvent.BH_STANDUP)
            else
                self:doEvent(eStateEvent.BH_STAND)
            end
        end
    elseif state == eAState.E_PARALYSIS then
        if self:getState() == eState.ST_PARALYSIS then --TODO 需要修改
            local animation
            if self.actor then
                animation = self.actor:getFixAnimation()
            end
            if animation == eAnimation.FLOOR then
                self:doEvent(eStateEvent.BH_STANDUP)
            else
                self:doEvent(eStateEvent.BH_STAND)
            end
        end
    elseif state == eAState.E_DONG_JIE then
        if self:getState() == eState.ST_FROZEN then
            -- self:doEvent(eStateEvent.BH_STAND)
            --冻结结束检查是否眩晕了
            if self:isAState(eAState.E_XUAN_YUN) then
                self:executeXuanYun()
            elseif self:isAState(eAState.E_PARALYSIS) then
                self:executeParalysis()
            else
                -- 冻结状态移除时 播放击飞动作
                local data = {}
                if self:getDir() == eDir.LEFT then
                    data.dir = 1
                    data.a   = 60
                    data.v   = 400
                else
                    data.dir = -1
                    data.a   = 180 - 60
                    data.v   = 400
                end
                self:doEvent(eStateEvent.BH_FLOAT,data)
            end
        end
    elseif state == eAState.E_STATE_84 then
        if self:doEvent(eStateEvent.BH_STAND) then
            self:endToAI()
        end
    end
end

--状态被删除通知
function Hero:onAStateDel(state,objectID)
    _print("Hero:onAStateDel",state,objectID)
    ---状态移除--
    --目前只处理冻结
    if stata == eAState.E_STOP_MOVE then
        local state = self:getState()
        if state == eState.ST_MOVEEX then 
            self.actor:playMove()
        end
    elseif state == eAState.E_IMPRINT then --印记
        self:onStateRemoveTrigger(state)    
    elseif state == eAState.E_DONG_JIE then --冻结
        self:onStateRemoveTrigger(state)
    elseif state == eAState.E_XUAN_YUN then --眩晕
        self:onStateRemoveTrigger(state)
    elseif state == eAState.E_PARALYSIS then --麻痹
        self:onStateRemoveTrigger(state)
    elseif state == eAState.E_JING_ZHI then --静止
        self:onStateRemoveTrigger(state)
    elseif state == eAState.E_STATE_84 then --静止
        self:onStateRemoveTrigger(state)
    elseif state == eAState.E_MEI_HUO then --魅惑
        self:onStateRemoveTrigger(state)
    elseif state == eAState.E_GAN_DIAN then --
        self:onStateRemoveTrigger(state)
    elseif state >= eAState.E_SKILLTYPE_1_DISABLE and state <= eAState.E_SKILLTYPE_7_DISABLE then
        local keyCode = skill_type_disable[state]
        local skill   = self:getSkill(keyCode)
        if skill then
            skill:forceUpdate()
        end
    elseif state >= eAState.E_SKILLTYPE_1_DISABLE_CD and state <= eAState.E_SKILLTYPE_7_DISABLE_CD then
        local keyCode = skill_type_disable_cd[state]
        local skill   = self:getSkill(keyCode)
        if skill then
            skill:forceUpdate()
        end
    end
end
--眩晕
function Hero:executeXuanYun()
    local _state  = self:getState()
    if _state ~= eState.ST_FLOAT then
        if self:isInAir() then
            local data = {}
            if self:getDir() == eDir.LEFT then
                data.dir = 1
                data.a   = 90
                data.v   = 10
            else
                data.dir = -1
                data.a   = 90 --180 - 60
                data.v   = 10
            end
            self:doEvent(eStateEvent.BH_FLOAT,data)
        else
            self:doEvent(eStateEvent.BH_VERTIGO)
        end
    end
end

--麻痹
function Hero:executeParalysis()
    local _state  = self:getState()
    if _state ~= eState.ST_FLOAT then
        if self:isInAir() then
            local data = {}
            if self:getDir() == eDir.LEFT then
                data.dir = 1
                data.a   = 90
                data.v   = 10
            else
                data.dir = -1
                data.a   = 90 --180 - 60
                data.v   = 10
            end
            self:doEvent(eStateEvent.BH_FLOAT,data)
        else
            self:doEvent(eStateEvent.BH_PARALYSIS)
        end
    end
end
--单个状态添加
function Hero:onAStateAdd(state,objectID)
    _print("Hero:onAStateAdd",state,objectID)
    -- Box("AAAAAAAA"..self:getName()..":"..state)
    if stata == eAState.E_STOP_MOVE then
        local state = self:getState()
        if state == eState.ST_MOVEEX then 
            self.actor:playMove()
        end
    elseif state == eAState.E_XUAN_YUN then
        -- 冰冻状态下优先处理冰冻
        if self:getState() ~= eState.ST_FROZEN then
            self:executeXuanYun()
        end
    elseif state == eAState.E_PARALYSIS then --麻痹
        if self:getState() ~= eState.ST_FROZEN and self:getState() ~= eAState.E_XUAN_YUN then
            self:executeParalysis()
        end
    elseif state == eAState.E_DONG_JIE then
        if self:getState() ~= eState.ST_FROZEN then
            self:doEvent(eStateEvent.BH_FROZEN)
        end
    elseif state == eAState.E_JING_ZHI then
        --移除所有特效
        -- local effectList = effectMgr:getObjects()
        -- for i = #effectList , 1 , -1 do
        --     local effect = effectList[i]
        --     if effect and effect.srcHero == self then
        --         effect:preRemove()
        --         -- effectMgr:remove(effect)
        --     end
        -- end
        self:removeAllEffect()
    elseif state == eAState.E_STATE_84 then
        --移除所有特效
        -- local effectList = effectMgr:getObjects()
        -- for i = #effectList , 1 , -1 do
        --     local effect = effectList[i]
        --     if effect and effect.srcHero == self then
        --         effect:preRemove()
        --         -- effectMgr:remove(effect)
        --     end
        -- end
        self.actor:stopAni()
        self:removeAllEffect()
        self:cleanPath()
    elseif state >= eAState.E_SKILLTYPE_1_DISABLE and state <= eAState.E_SKILLTYPE_7_DISABLE then
        -- for key,v in pairs(skill_type_disable) do
        --     if v == state then
        --         local skills = self:getSkillsByType(key)
        --         for i,skill in ipairs(skills) do
        --             skill:forceUpdate()
        --         end
        --         break
        --     end
        -- end
        local keyCode = skill_type_disable[state]
        local skill   = self:getSkill(keyCode)
        if skill then
            skill:forceUpdate()
        end
    elseif state >= eAState.E_SKILLTYPE_1_DISABLE_CD and state <= eAState.E_SKILLTYPE_7_DISABLE_CD then
        -- for key,v in pairs(skill_type_disable_cd) do
        --     if v == state then
        --         local skills = self:getSkillsByType(key)
        --         for i,skill in ipairs(skills) do
        --             skill:forceUpdate()
        --         end
        --         break
        --     end
        -- end
        local keyCode = skill_type_disable_cd[state]
        local skill   = self:getSkill(keyCode)
        if skill then
            skill:forceUpdate()
        end
    elseif state == eAState.E_MIANYI_DBUFF then 
        --清除负面debuff
        for k , effect in ipairs(self.bufferEffectMap) do
            if effect:isNegative() then
                effect:normalDestory()
            end
        end
    elseif state == eAState.E_MIANYI_ATTR_DEBUFF then 
        --清除负面debuff
        for k , effect in ipairs(self.bufferEffectMap) do
            if effect:isReduceAttr() then
                effect:normalDestory()
            end
        end
    end
    --TODO 是否要检查状态第一次添加触发
    self:onStateTrigger(state,self)
end



--是否是霸体
function Hero:isSuperarmor()
    if self:getState() == eState.ST_GRASP then --被抓取的状态 
        return true
    end
    return self:isAState(eAState.E_BA_TI) or self:isAState(eAState.E_BA_TI_EX) 
end

--是否伤免状态
function Hero:isImmune()
    return self:isAState(eAState.E_WU_DI)

end

function Hero:getShieldPercent()
    return self.property:getValue(eAttrType.ATTR_NOW_SLD)*10000 /self.property:getValue(eAttrType.ATTR_MAX_HP)
end
function Hero:getHpPercent()
    return self.property:getValue(eAttrType.ATTR_NOW_HP)*10000 /self.property:getValue(eAttrType.ATTR_MAX_HP)
end


function Hero:getHpPercentEx()
    local size     = math.max(self.data.healthBar,1)
    local value    = self.property:getValue(eAttrType.ATTR_NOW_HP)
    local maxValue = self.property:getValue(eAttrType.ATTR_MAX_HP)
    if size > 1 then
        local oneValue = maxValue/size           
        local index    = value/math.ceil(oneValue)
        if math.floor(index) < index then 
            index = math.ceil(index)
        end
        local percent  = (value%oneValue)*100/oneValue
        if index > 1 and percent == 0 then 
            percent = 100
        end
        return index , math.ceil(percent)
    else
        local percent  = value*100/maxValue
        return size , math.ceil(percent)
    end
end



function Hero:getAngerPercent()
    return self.property:getValue(eAttrType.ATTR_NOW_AGR)*10000 /self.property:getValue(eAttrType.ATTR_MAX_AGR)
end

-- function Hero:getHp()
--     return self.property:getValue(eAttrType.ATTR_NOW_HP)
-- end
-- function Hero:getAnger()
--     return self.property:getValue(eAttrType.ATTR_NOW_AGR)
-- end

--非强制消耗能量
function Hero:getEnergy()
    return self.property:getValue(eAttrType.ATTR_NOW_ENERGY)
end
function Hero:getMaxEnergy()
    return self.property:getValue(eAttrType.ATTR_MAX_ENERGY)
end

function Hero:getSuperEnergy()
    return self.property:getValue(eAttrType.ATTR_SUPER_ENERGY)
end
function Hero:getSuperEnergyLevel()
    return self.property:getValue(eAttrType.ATTR_SUPER_ENERGY_LEVEL)
end

function Hero:getEnergyPercent()
    return self.property:getValue(eAttrType.ATTR_NOW_ENERGY)*10000/self.property:getValue(eAttrType.ATTR_MAX_ENERGY)
end

function Hero:getMaxHp()
    return self.property:getValue(eAttrType.ATTR_MAX_HP)
end
function Hero:getMaxAnger()
    return self.property:getValue(eAttrType.ATTR_MAX_AGR)
end
function Hero:getShield()
    return self.property:getValue(eAttrType.ATTR_NOW_SLD)
end
--抵抗值
function Hero:getResist()
    return self.property:getValue(eAttrType.ATTR_NOW_RST)
end
function Hero:getMaxResist()
    return self.property:getValue(eAttrType.ATTR_MAX_RST)
end

function Hero:getResistPercent()
    if self:isRecoverRst() then
        return self:getRecoverResistPercent()
    else
        return self:getResistPercent_()
    end
end

function Hero:getResistPercent_()
    local maxValue = self.property:getValue(eAttrType.ATTR_MAX_RST)
    if maxValue <= 0  then
        return 0
    end
    return self.property:getValue(eAttrType.ATTR_NOW_RST)*10000 / maxValue
end

--攻击速度
function Hero:getAtkSpd()
    return self.property:getValue(eAttrType.ATTR_SPD)
end

--普通攻击攻速
function Hero:getAtkSpdNormal()
    local spd  = self:getAtkSpd()
    local spd1 = self.property:getValue(eAttrType.ATTR_SPD_NORMAL) 
    return spd + spd1 
end



--动画播放速度
-- function Hero:setAtkSpd()
--     if self.actor then
--         local atkSpd = self.property:getValue(eAttrType.ATTR_SPD)
--         print("atkSpd::::::::",atkSpd)
--         local scale  = atkSpd/100
--         self.actor:setTimeScale(scale)
--     end
-- end

--恢复默认攻击速度
function Hero:setActionTimeScale(timeScale)
    if self.actor then
        self.actor:setTimeScale(timeScale)
    end
end

function Hero:getActionTimeScale()
    if self.actor then
        return self.actor:getTimeScale()
    end
    return 1
end

function Hero:changeSelfTimeScale(timeScale)
    self.timeScale = self.timeScale + timeScale
end

function Hero:resetSelfTimeScale()
    self.timeScale = 1 
end

function Hero:getTimeScale()
    -- 队伍全局魔女时间
    -- 敌对阵营的魔女时间
    local selfTimeScale = self.timeScale
    if selfTimeScale < 0 then 
        selfTimeScale = 0
    end
    return battleController.getTeam():getTimeScale(self:getCamp())*selfTimeScale
end

function Hero:updatePauseState(isPause)
    for k , effect in ipairs(self.bufferEffectMap) do
        effect:updatePauseState(isPause)
    end
end

---buffer 效果
function Hero:getBFEffectAddTimes(id)
    local times = 0
    for k , effect in ipairs(self.bufferEffectMap) do
        if effect:getId() == id then
            times = times + effect:getAddTimes()
        end
    end
    return times
end

function Hero:getBFEffect(id)
    for k , effect in ipairs(self.bufferEffectMap) do
        if effect:getId() == id then
            return effect
        end
    end
end


function Hero:checkBFEffect(id)
    for k , effect in ipairs(self.bufferEffectMap) do
        if effect:getId() == id and effect.enableTakeEffect then
            return effect
        end
    end
end

function Hero:addBFEffect(bufferEffect)
    table.insert(self.bufferEffectMap,bufferEffect)
end
function Hero:removeBFEffect(bufferEffect)
    -- self.bufferEffectMap[bufferEffect:getObjectID()] = nil
    table.removeItem(self.bufferEffectMap,bufferEffect)
end

function Hero:getBFEffectIds()
    local ids = {}
    for k , effect in ipairs(self.bufferEffectMap) do
        table.insert(ids, effect:getId())
    end
    return ids
end

function Hero:getAngleFunctionIds()
    local ids = {}
    for k,datas in pairs(self:getAngleDatas()) do
        for dataId,data in pairs(datas) do
            for i,v in ipairs(data) do
                table.insert(ids, v.id)
            end
        end
    end
    return ids
end

function Hero:handlBufferEffect(dt)
    --TODO 测试貌似在update 里删除 effect 没毛病
    self:walkBufferEffectWalk(function(effect)
        effect:update(dt)
    end)
end

function Hero:checkEffectTake(target, isRemove)
    local tempEffects = {}
    for k , effect in ipairs(self.bufferEffectMap) do 
        if effect:getCoverId() == target:getCoverId() then
            table.insert(tempEffects, effect)
        end
    end
    table.sort(tempEffects, function (a,b)
        return a:getPriority() > b:getPriority()
    end)
    local takeFlag = false
    for i,effect in ipairs(tempEffects) do
        if isRemove then
            if not takeFlag then
                if effect:getPriority() > target:getPriority() then
                    if effect ~= target then
                        effect:setTakeEffect(true)
                        takeFlag = true
                    end
                else
                    effect:setTakeEffect(false)
                end
            else

            end
        else
            if effect:getPriority() ~= target:getPriority() then
                if effect ~= target then
                    effect:setTakeEffect(true)
                    takeFlag = true
                end
            end
        end
    end
    return not takeFlag
end

--获取buffer效果
function Hero:getBufferEffectMap()
    return self.bufferEffectMap
end

function Hero:getEffectingBufferEffect()
    local ret = {}
    for i,v in ipairs(self.bufferEffectMap) do
        if v.enableTakeEffect then
            table.insert(ret,v)
        end
    end
    return ret
end

function Hero:getCurForm()
    return self.curForm
end

function Hero:getBuffer(id)
    for i, buffer in ipairs(self.bufferList) do
        if buffer:getID() == id then
            return buffer
        end
    end
end

--计算关卡加成的buffer类型
function Hero:calcPointTargetTypes()
    local pointTargetTypes = {}
    if self:getCampType() == eCampType.Hero then
        if self:isAssist() then
            table.insert(pointTargetTypes,ePointTargetType.Hero_Assit)
        else
            table.insert(pointTargetTypes,ePointTargetType.Hero)
        end
    else
        --所有怪物
        table.insert(pointTargetTypes,ePointTargetType.Monster_All)
        if self:getMonsterType() == eMonsterType.MT_NORMAL then
            table.insert(pointTargetTypes,ePointTargetType.Monster_Noraml)
        elseif self:getMonsterType() == eMonsterType.MT_ELITE then
            table.insert(pointTargetTypes,ePointTargetType.Monster_Elite)
        elseif self:getMonsterType() == eMonsterType.MT_BOSS then --TODO特定BOSS目前无法配置无法指定
            table.insert(pointTargetTypes,ePointTargetType.Boss)
        end
    end
    return pointTargetTypes
end


function Hero:getBufferIds()
    --技能buff 相关
    local buffIds = {}
    ---关卡buffer 加成
    local pointTargetTypes = self:calcPointTargetTypes()
    for i, targetType in ipairs(pointTargetTypes) do
        local ids = battleController.getPointBuffer(targetType)
        for k, buffId in ipairs(ids) do
            buffIds[buffId] = buffId
        end
    end

    --额外buffer加成
    local ids = battleController.getExtBuffList(self)
    for k, buffId in ipairs(ids) do
        buffIds[buffId] = buffId
    end

    -- Box("ASDFASDF")
    ---技能

    --TODO 技能包含buffer
    -- for k, id in ipairs(self.data.skills) do
    --     local data = TabDataMgr:getData("Skill", id)
    --     for k, buffId in ipairs(data.coverBuff) do
    --         buffIds[buffId] = buffId
    --     end
    -- end
        -- dump(buffIds,"222")
--第二形态的技能附带buffer
    -- if self.data.skillsTwo then
    --     for k, id in ipairs(self.data.skillsTwo) do
    --         local data = TabDataMgr:getData("Skill", id)
    --         for k, buffId in ipairs(data.coverBuff) do
    --             buffIds[buffId] = buffId
    --         end
    --     end
    -- end
    -- dump(buffIds,"333")

    --TODO 值处理第一形态下的技能包含的Buffer
    for i , data in ipairs(self.data.formDatas) do
        if data.id == self.data.beginForm then
            for k, id in ipairs(data.skills) do
                local skillData = TabDataMgr:getData("Skill", id)
                for k, buffId in ipairs(skillData.coverBuff) do
                    buffIds[buffId] = buffId
                end
            end
        end
    end



    --被动技能包涵buff
    if self.data.passivitySkills then
        for i, skillID in ipairs(self.data.passivitySkills) do
            local skillData = TabDataMgr:getData("PassiveSkills",skillID)
            if not skillData then
                Box("can not found PassiveSkills :"..tostring(skillID))
            end
            local buffs = skillData.buffs[self.data.id] or skillData.buffs[0]
            if buffs then
                for i, buffId in pairs(buffs) do
                    buffIds[buffId] = buffId
                end
            end
        end
    end
    --天使附带buffer
    for i, buffId in ipairs(self.data.angleBuffer) do
        buffIds[buffId] = buffId
    end
    --词缀附带buffer
    local affixDatas = self:getAffixData()
    for k,affixData in pairs(affixDatas) do
        for i, buffId in ipairs(affixData.attributeBuffers) do
            buffIds[buffId] = buffId
        end
        for i, buffId in ipairs(affixData.effectBuffers) do
            buffIds[buffId] = buffId
        end
    end

    --特定模式下只使用特定条件buff
    if self:getCampType() == eCampType.Hero and battleController.useCustomAttrModle() then
        buffIds = {}
    end
    --特殊条件buff加成
    local ids = battleController.getAdditionBuff(self)
    for k, buffId in ipairs(ids) do
        buffIds[buffId] = buffId
    end

    buffIds = self:filteBuff(buffIds)
    local buffIdList = {}
    for i, id in pairs(buffIds) do
        table.insert(buffIdList,id)
    end
    table.sort(buffIdList)
    dump(buffIdList," "..self:getName())
    -- Box("xxx::"..tostring(self:getName()))
    return buffIdList
end
--302
function Hero:createBufferList()
    --技能buff 相关
    local buffIdList = self:getBufferIds()
    for i, id in ipairs(buffIdList) do
        local buffer = Buffer.create(id,self)
        buffer:addToMgr()
        table.insert(self.bufferList,buffer)
    end
    dump(buffIdList," "..self:getName())
    -- Box("xxx::"..tostring(self:getName()))
end
--buffer覆盖处理
function Hero:filteBuff(buffIds)
    local temp = {}
    local _buffIds = {}
    for i, id in pairs(buffIds) do
        local data = TabDataMgr:getData("Buffer",id)
        if not data then
            Box("Buffer "..tostring(id).." not found")
        end
        if data.coverId > 0 then
            local _data = temp[data.coverId]
            if not _data then
                temp[data.coverId] = data
            else
                if data.priority > _data.priority then
                    temp[data.coverId] = data
                end
            end
        else --0的不覆盖
            table.insert(_buffIds,data.id)
        end
    end
    buffIds = {}
    for i,v in ipairs(_buffIds) do
        buffIds[v]= v
    end

    for i,v in pairs(temp) do
        buffIds[v.id] = v.id
    end
    return buffIds
end

--获取受击的技能ID(skillgroup id)
function Hero:getLastBloodSkillId()
    return self.nLastBloodSkillGroupId
end
function Hero:setLastBloodSkillId(id)
    self.nLastBloodSkillGroupId = id
end

function Hero:getProperty()
    return self.property
end

function Hero:isFight()
    return self.bFight
end

function Hero:setFight(fight)
     self.bFight = fight
end
function Hero:startFight()
    self:setFight(true)
end

function Hero:stopFight()
    self:setFight(false)
    self:cancelToStand()
end

function Hero:getSkeletonNodeScale()
    if self.actor then 
        return self.actor:getSkeletonNodeScale()
    end
    return 1
end

--设置角色模型的偏移位置（父节点是的角色的特效位置未做修正）
function Hero:setSkeletonNodePosition(pos)
    if self.actor then 
        self.actor:setSkeletonNodePosition(pos)
    end
end

function Hero:setSkeletonNodeScale(scale)
    if self.actor then 
        self.actor:setSkeletonNodeScale(scale)
    end
end

function Hero:__setDir(dir)
    if  self.actor then
        self.actor:setDir(dir)
    end
end

--更新朝向
function Hero:setDir(dir)
    if self.data.fixedDir ~= 1 then --1标识固定朝向不能设置朝向
        self:__setDir(dir)
    end
end

function Hero:getDir()
    if self.actor then
        return self.actor:getDir()
    else
        return eDir.LEFT
    end
end

function Hero:release_()
    self:doDrop()
    --我方飞助战队员增加能量
    if self:getCampType() == eCampType.Monster then
        battleController._onHeroCreate(self)
        battleController._onMonsterLoseHp(self:getMaxHp())
        local dropEnergy = self.data.dropEnergy
        if dropEnergy and dropEnergy > 0 then
            local heros = battleController.getBench()
            for k , hero in ipairs(heros) do
                hero:changeAnger(dropEnergy)
            end
        end
    end

    self:setBattle(false)
    heroMgr:remove(self) --从管理器把自己移除
    self:removeAllBuff()
    if self.actor then
        self.actor:removeFromParent_(true)
        self.actor:release()
        self.actor = nil

    end
    self:stopMoveEffect()
end

function Hero:release()
    self.willRelease = true
end

function Hero:checkAndRelease()
    if self.willRelease then
        self:release_()
        self.willRelease = nil
    end
end

function Hero:getData()
    return self.data
end


local events =
{
    {name = eStateEvent.BH_BORN,        from = {eState.ST_STAND}, to = eState.ST_BORN},
    {name = eStateEvent.BH_STAND,       from = {StateMachine.WILDCARD}, to = eState.ST_STAND},
    {name = eStateEvent.BH_MOVE,        from = {eState.ST_BORN , eState.ST_STAND, eState.ST_MOVEEX,eState.ST_HIT, eState.ST_SKILL}, to = eState.ST_MOVE},
    {name = eStateEvent.BH_MOVEEX,      from = {eState.ST_STAND, eState.ST_MOVEEX}, to = eState.ST_MOVEEX},
    {name = eStateEvent.BH_SKILL,       from = {eState.ST_FLOAT, eState.ST_STANDUP, eState.ST_DEPARTURE,eState.ST_FALL,eState.ST_BORN , eState.ST_SKILL,eState.ST_STAND, eState.ST_MOVE, eState.ST_MOVEEX, eState.ST_HIT ,eState.ST_QUICKMOVE  }, to = eState.ST_SKILL},
    {name = eStateEvent.BH_HIT,         from = {eState.ST_STAND, eState.ST_STANDUP,eState.ST_MOVE,eState.ST_MOVEEX,  eState.ST_SKILL,eState.ST_HIT,eState.ST_FALL,eState.ST_FLOAT,eState.ST_VERTIGO,eState.ST_PARALYSIS,eState.ST_QUICKMOVE}, to = eState.ST_HIT},
    {name = eStateEvent.BH_FLOAT,       from = {eState.ST_GRASP, eState.ST_STAND, eState.ST_FROZEN,eState.ST_MOVE,eState.ST_MOVEEX,  eState.ST_HIT,eState.ST_SKILL , eState.ST_FLOAT ,eState.ST_FALL,eState.ST_VERTIGO,eState.ST_PARALYSIS,eState.ST_QUICKMOVE }, to = eState.ST_FLOAT},
    {name = eStateEvent.BH_FALL,        from = {eState.ST_STAND, eState.ST_MOVE,eState.ST_MOVEEX,  eState.ST_MOVE ,eState.ST_SKILL ,eState.ST_FLOAT,eState.ST_FALL,eState.ST_VERTIGO,eState.ST_PARALYSIS}, to = eState.ST_FALL},
    {name = eStateEvent.BH_STANDUP,     from = {eState.ST_FALL,  eState.ST_VERTIGO,eState.ST_PARALYSIS}, to = eState.ST_STANDUP},
    {name = eStateEvent.BH_QUICKMOVE,   from = {eState.ST_BORN , eState.ST_STAND, eState.ST_MOVE,eState.ST_MOVEEX }, to = eState.ST_QUICKMOVE},
    {name = eStateEvent.BH_DIE,         from = {eState.ST_STAND, eState.ST_MOVE , eState.ST_MOVEEX,eState.ST_HIT,eState.ST_SKILL,eState.ST_FALL,eState.ST_VERTIGO,eState.ST_PARALYSIS,eState.ST_STANDUP},  to = eState.ST_DIE},
    {name = eStateEvent.BH_VERTIGO,     from = {eState.ST_STAND, eState.ST_MOVEEX,eState.ST_HIT ,eState.ST_FLOAT,eState.ST_SKILL,eState.ST_FROZEN ,eState.ST_PARALYSIS},  to = eState.ST_VERTIGO},
    {name = eStateEvent.BH_PARALYSIS,   from = {eState.ST_STAND, eState.ST_MOVEEX,eState.ST_HIT ,eState.ST_FLOAT,eState.ST_SKILL,eState.ST_FROZEN ,eState.ST_VERTIGO,eState.ST_PARALYSIS},  to = eState.ST_PARALYSIS},
    {name = eStateEvent.BH_DEPARTURE,   from = {StateMachine.WILDCARD}, to = eState.ST_DEPARTURE},
    {name = eStateEvent.BH_RELIVE,      from = {eState.ST_DIE}, to = eState.ST_RELIVE},
    {name = eStateEvent.BH_FROZEN,      from = {StateMachine.WILDCARD}, to = eState.ST_FROZEN}, --冰冻状态
    {name = eStateEvent.BH_WIN,         from = {StateMachine.WILDCARD}, to = eState.ST_WIN},--获胜状态
    {name = eStateEvent.BH_GRASP,       from = {StateMachine.WILDCARD}, to = eState.ST_GRASP},--获胜状态
}

function Hero:createFSM()
    self.fsm_ = StateMachine:instace()
    local cfg = {}
    cfg.events    = events
    cfg.callbacks = {
        -- onenterstate = handler(self.onEnterState, self),
        onleavestate = handler(self.onLeaveState, self),

        onafterevent = handler(self.onEnterState, self),
        -- onafterevent = function ( event)
        --     print("onafterevent",event.name)
        -- end
    }
    cfg.initial = {
        event = eStateEvent.BH_STAND,
        state = eState.ST_STAND,
    }
    self.fsm_:setupState(cfg)
end

function Hero:getState()
    return self.fsm_:getState()
end

function Hero:_doEvent(eventName, ...)
    local canDo  = self.fsm_:canDoEvent(eventName)
    if canDo then
        self.fsm_:doEvent(eventName, ...)
    else
        _print("can not doEvent "..tostring(eventName).." in current state "..self:getState())
    end
    return canDo
end
function Hero:doEvent(eventName, ...)
    if eventName == eStateEvent.BH_DIE then
        _print(self:getName().."is die")
    end
    if eventName ==  eStateEvent.BH_STAND then
        if self:isInAir() then
            if not self:castByType(eSkillType.DOWN) then
                local posy       = self.position3D.y - self.position3D.z
                local time       = math.abs(posy/300)
                local offsetPos  = me.Vertex3F(0, 0, posy)
                local hurtAction = ActionMgr.createMoveAction()
                hurtAction:start(self,time,offsetPos,function ()
                        self:_doEvent(eStateEvent.BH_STAND)
                        self:endToAI()
                    end)
                return false
            end
            return false
        end
    end
    return self:_doEvent(eventName, ...)
end

function Hero:doEventForce(eventName, ...)
    self.fsm_:doEventForce(eventName, ...)
end

function Hero:canDoEvent(eventName)
    local canDo = self.fsm_:canDoEvent(eventName)
    return canDo
end

function Hero:onEnterState(event)
    -- print("event.to:",event.to)
    if not self:isBattle() then
        return
    end
    local args    = unpack(event.args)
    local fromState = event.from
    local toState = event.to
    --第二形态下状态变更时 还原到第一形态


    if toState == eState.ST_STAND then
        self:onStand(args)
        self:onEventTrigger(eBFState.E_STAND,self)
    elseif toState == eState.ST_MOVE then
        self:onMove(args)
    elseif toState == eState.ST_MOVEEX then
        self:onMoveEx(args)
        self:onEventTrigger(eBFState.E_MOVE,self)
    elseif toState== eState.ST_SKILL then
        self:onCastSkill(args)
    elseif toState == eState.ST_HIT then
        self:onHurt(args)
    elseif toState == eState.ST_DIE then
        self:onDie(args)
    elseif toState == eState.ST_FLOAT then
        self:onFloat(args)
        if fromState ~= toState then
            self.nFloatTime = 0
        end
    elseif toState == eState.ST_FALL then
        self:onFall(args)
    elseif toState == eState.ST_QUICKMOVE then
        self:onQuickMove(args)
    elseif toState == eState.ST_STANDUP then
        self:onStandUp(args)
    elseif toState == eState.ST_BORN then
        self:onBorn(args)
    elseif event.to == eState.ST_VERTIGO then
        self:onVertigo(args)
    elseif event.to == eState.ST_PARALYSIS then --麻痹
        self:onParalysis(args)    
    elseif event.to == eState.ST_DEPARTURE then
        self:onDeparture(args)
    elseif toState == eState.ST_RELIVE then
        self:onRelive(args)
    elseif toState == eState.ST_FROZEN then --冻结
        self:onFrozen(args)
    elseif toState == eState.ST_WIN then
        self:onWin(args)
    elseif toState == eState.ST_GRASP then --抓取
        self:onGrasp(args)
    else
        printError("暂时不支持此状态")
    end

end

function Hero:onLeaveState(event)
    -- print("onLeaveState",event)
    local from = event.from
    local to   = event.to
    -- if from == to then
    --     return
    -- end
    if from  == eState.ST_MOVE then
        self:getActor():stopAllActions()
    elseif from  == eState.ST_QUICKMOVE then
        self:getActor():stopAllActions()
    elseif from == eState.ST_FLOAT then
        self:getActor():stopAllActions()
        self.nFloatTime = 0
        self:getActor():setColor(nil,eColorType.FloatingProtection)

    elseif from == eState.ST_SKILL then
        self:getActor():stopAllActions()
        self:onLeaveSK(event)
    elseif from == eState.ST_MOVEEX then
        self:cleanPath()
        self:stopMoveEffect()
        if to ~= eState.ST_STAND then
            self:endToAI()
        end
    elseif from == eState.ST_FROZEN then
        self:getActor():stopAllActions()
        self:getActor():setColor(nil,eColorType.Frozen)
    elseif from == eState.ST_FALL then
        self:clearFlag(eFlag.FALL)
    elseif from == eState.ST_GRASP then 
        self:forceStopGrasp()
    end
    self:setActionTimeScale(1)
end

--冻结
function Hero:onFrozen()
    self:getActor():playFrozen()
    self:stopAllActions()
    if self:isInAir() then
        --处理下落
        local posy       = self.position3D.y - self.position3D.z
        local time       = math.abs(posy/300)
        local offsetPos  = me.Vertex3F(0, 0, posy)
        local hurtAction = ActionMgr.createMoveAction()
        hurtAction:start(self,time,offsetPos)
    end
end

--获胜
function Hero:onWin()
    self:getActor():playWin(function()
        self:setFlag(eFlag.PlayedEndAction)
    end)
end

function Hero:cleanGraspData(time)
    self.graspData = nil
end
-- 抓取倒计时处理
function Hero:graspUpdate(time)
    if self.graspData then
        if self.graspData.duration then 
            self.graspData.duration = self.graspData.duration - time
            if self.graspData.duration < 0 then 
                self.graspData = nil
                self:doGraspHurtAction()  --结束抓取跳转受击
            end
        end
    end
end


--抓取
function Hero:onGrasp(data)
    self.graspData = data
    self:stopAllActions()
    self:getActor():playGrasp(data.animation)
    self:getActor():setRotation(data.rotation)
end

--显示隐藏模型
function Hero:setVisible(visible)
    if self.actor then
        self.actor:setVisible(visible)
    end
end

--触发抓取
function Hero:doGrasp(heroID,host,animation,rotation,duration)
    if self.graspData then --触发新的抓取
        if not tolua.isnull(self.graspData.host) then
            self.graspData.host:removeGraspHero(self)
        end
        self.graspData = nil
    end

    local data = 
    {
        heroID    = heroID,
        animation = animation,
        rotation  = rotation ,
        host      = host ,
        duration  = duration
    }
    self:doEvent(eStateEvent.BH_GRASP,data)
end

function Hero:fixNearPosition(pos)
    -- dump(pos)
    local rect = levelParse:getMoveRect()
    if pos.x < rect.origin.x then 
        pos.x = rect.origin.x + BattleConfig.SPACE_AIRWALL + 1
    elseif pos.x > rect.origin.x + rect.size.width then
        pos.x = rect.origin.x + rect.size.width - BattleConfig.SPACE_AIRWALL - 1 
    end

    if pos.y < rect.origin.y then 
        pos.y = rect.origin.y + 10
    elseif pos.y > rect.origin.y + rect.size.height then
        pos.y = rect.origin.y + rect.size.height -10
    end
    -- dump(rect)
    -- dump(pos)
    -- print_("-----------------------fixNearPosition--------------------------")
end

--强制终止抓取
function Hero:forceStopGrasp()
    if self.graspData then --触发新的抓取
        if not tolua.isnull(self.graspData.host) then
            self.graspData.host:removeGraspHero(self)
        end
    end
    self.graspData = nil
    self:setRotation(0) 
    self:setVisible(true) --恢复模型是否显示
    self:_fixPosition_()
end

--角色修正到可以行走区域
function Hero:_fixPosition_()

    local _position3D = clone(self.position3D)
    _position3D.y = _position3D.z
    if not battleController.canMove(_position3D.x ,_position3D.y) then
        self:fixNearPosition(_position3D)
        if not battleController.canMove(_position3D.x ,_position3D.y) then --休整以再检查是否在一定区域
            local size = levelParse:getBlockSize()
            local index = 0
            while true do 
                index = index + 1
                                    -- print_("wo cao grasp fix position warning foreach index:"..tostring(index))
                if index > 50 then 
                    Box("wo cao grasp fix position warning foreach index:"..tostring(index))
                end
                if battleController.canMove(_position3D.x - index *size ,_position3D.y) then 
                    _position3D.x = _position3D.x - index *size
                    break
                elseif battleController.canMove(_position3D.x + index *size ,_position3D.y) then 
                    _position3D.x = _position3D.x + index *size
                    break
                elseif battleController.canMove(_position3D.x  ,_position3D.y + index *size) then
                    _position3D.y = _position3D.y + index *size
                    break
                elseif battleController.canMove(_position3D.x  ,_position3D.y - index *size) then
                    _position3D.y = _position3D.y - index *size
                    break
                elseif battleController.canMove(_position3D.x - index *size ,_position3D.y - index *size) then
                    _position3D.x = _position3D.x - index *size
                    _position3D.y = _position3D.y - index *size
                    break
                elseif battleController.canMove(_position3D.x + index *size ,_position3D.y - index *size) then
                    _position3D.x = _position3D.x + index *size
                    _position3D.y = _position3D.y - index *size
                    break

                elseif battleController.canMove(_position3D.x - index *size ,_position3D.y + index *size) then
                    _position3D.x = _position3D.x - index *size
                    _position3D.y = _position3D.y + index *size
                    break
                elseif battleController.canMove(_position3D.x + index *size ,_position3D.y + index *size) then
                    _position3D.x = _position3D.x + index *size
                    _position3D.y = _position3D.y + index *size
                    break
                end
            end
        end
    end
    _position3D.z = _position3D.y
    self:setPosition3D(_position3D.x,_position3D.y,_position3D.z)


end
--抓取结束播放手机动作
function Hero:doGraspHurtAction(dir)
    -- print_(self:getName().."抓取结束-----------------")
    if self:getState() ~= eState.ST_GRASP then --非抓取状态 不需要处理
        return
    end
    self:cleanGraspData()
    self:setRotation(0)   --恢复模型角度
    -- Box(tostring(self.position3D.y).."--"..tostring(self.position3D.z))
    -- local _position3D = clone(self.position3D)
    -- _position3D.y = _position3D.z
    -- if not battleController.canMove(_position3D.x ,_position3D.y) then
    --     self:fixNearPosition(_position3D)
    --     if not battleController.canMove(_position3D.x ,_position3D.y) then --休整以再检查是否在一定区域
    --         local size = levelParse:getBlockSize()
    --         local index = 0
    --         while true do 
    --             index = index + 1
    --                                 -- print_("wo cao grasp fix position warning foreach index:"..tostring(index))
    --             if index > 50 then 
    --                 Box("wo cao grasp fix position warning foreach index:"..tostring(index))
    --             end
    --             if battleController.canMove(_position3D.x - index *size ,_position3D.y) then 
    --                 _position3D.x = _position3D.x - index *size
    --                 break
    --             elseif battleController.canMove(_position3D.x + index *size ,_position3D.y) then 
    --                 _position3D.x = _position3D.x + index *size
    --                 break
    --             elseif battleController.canMove(_position3D.x  ,_position3D.y + index *size) then
    --                 _position3D.y = _position3D.y + index *size
    --                 break
    --             elseif battleController.canMove(_position3D.x  ,_position3D.y - index *size) then
    --                 _position3D.y = _position3D.y - index *size
    --                 break
    --             elseif battleController.canMove(_position3D.x - index *size ,_position3D.y - index *size) then
    --                 _position3D.x = _position3D.x - index *size
    --                 _position3D.y = _position3D.y - index *size
    --                 break
    --             elseif battleController.canMove(_position3D.x + index *size ,_position3D.y - index *size) then
    --                 _position3D.x = _position3D.x + index *size
    --                 _position3D.y = _position3D.y - index *size
    --                 break

    --             elseif battleController.canMove(_position3D.x - index *size ,_position3D.y + index *size) then
    --                 _position3D.x = _position3D.x - index *size
    --                 _position3D.y = _position3D.y + index *size
    --                 break
    --             elseif battleController.canMove(_position3D.x + index *size ,_position3D.y + index *size) then
    --                 _position3D.x = _position3D.x + index *size
    --                 _position3D.y = _position3D.y + index *size
    --                 break
    --             end
    --         end
    --     end
    -- end
    -- _position3D.z = _position3D.y
    -- self:setPosition3D(_position3D.x,_position3D.y,_position3D.z)
    self:_fixPosition_()

    self:setVisible(true) --恢复模型是否显示
    local data = {}
    if self:getDir() == eDir.LEFT then
        data.dir = 1
        data.a   = 90
        data.v   = 400
    else
        data.dir = -1
        data.a   = 180 - 90
        data.v   = 400
    end
    if self:getActor() then 
        self:doEvent(eStateEvent.BH_FLOAT,data)
        --已经死亡并销毁不做处理 
    end

end

function Hero:setRotation(rotation)
    if self.actor then
        self.actor:setRotation(rotation)
    end
end


function Hero:playAnimation(animation)
    if self.actor then 
        self.actor:playAni(animation, false, nil,true)
    end
end

--复活
function Hero:onRelive()
    self.isDeaded = false
    self:getActor():playRelive(function()
        --切换到待机
        --HP恢复50%
        local hp = self:getValue(eAttrType.ATTR_MAX_HP)/2
        self:setValue(eAttrType.ATTR_NOW_HP,hp,true)
        self:doEvent(eStateEvent.BH_STAND)
        if self.actor then
            self.actor:show()
            self.actor:setOpacity(255)
            self.actor.skeletonNode:show()
        end
        self:clearFlag(eFlag.Dead)
    end)
    --复活特效
    local skeletonNode
    local scale  = BattleConfig.MODAL_SCALE* self:getSkeletonNodeScale()
    skeletonNode = self.actor:playEffect("effects_qiehuan",scale,nil)
    skeletonNode:playByIndex(1, 0)

end

--离开
function Hero:onDeparture(args)
    self:onEventTrigger(eBFState.E_HERO_LEAVE,self)
    self:print("开始离场")
    self:stopAllActions()
    self:getActor():playDeparture(function()
            self:doDepartureOver()
        end)
end

function Hero:onLeaveSK(event)
    -- printError("onLeaveSkill....")
    -- self:setActionTimeScale(1) --还原默认动画播放速度
    if self.actor then 
        self.actor.fixZOrder = nil
    end
    self:cancel(true)
    if self:isManual() then
        self.operate:clearKeyQueue()
        if battleController.getCaptain() == self then 
            EventMgr:dispatchEvent(eEvent.EVENT_SHOW_KEYLIST,{})
        end
    end
    self:removeAllEffect()
    self:stopSoundEffect()
    --TODO 闪避技能迷糊shader还原
    --self.actor:setShaderDefault()
    if self:isInAir() then
        self:forceToFloor()
    end

    -- 技能被打断终止AI
    if event.to ~= eState.ST_STAND then
        self:endToAI()
    end
end
function Hero:cancel(isCd)
    if self.skill then
        EventMgr:dispatchEvent(eEvent.EVENT_FIX_CAMERA_Z,self.skill:getCID(),0,0)
        self.skill:cancel(isCd)
        self.skill = nil
    end
end

function Hero:setSkill(skill)
    self:cancel(self.skill~=skill)
    self.skill = skill
end


--眩晕动画
function Hero:onVertigo(animation)
    self:stopAllActions()
    self:getActor():playVertigo(animation)
end

function Hero:onParalysis()
    self:stopAllActions()
    self:getActor():playParalysis()
end


--击飞 浮空
function Hero:onFloat(arg)
    -- self:cancel()
    self:getActor():playFloat()
    local data = arg
    -- dump(data,"onFloat")
    -- print("-----------onFloat-----------")
    local hurtAction = ActionMgr.createHurtAction()
    local height  = self.position3D.z - self.position3D.y
    local pecent  = math.max(0.1, 1 - height*0.05*0.02)
    data.v = data.v * pecent
    -- print_("data.v:"..tostring(data.v))
    hurtAction:start(self,data.dir,data.a,data.v,function ()
        if self:isAState(eAState.E_XUAN_YUN) then
            self:doEvent(eStateEvent.BH_VERTIGO,eAnimation.FLOOR)
        elseif self:isAState(eAState.E_PARALYSIS) then 
            self:doEvent(eStateEvent.BH_PARALYSIS,eAnimation.FLOOR)
        else
            self:doEvent(eStateEvent.BH_FALL)
        end
    end)
end

--被攻击倒地
function Hero:onFall(arg)
    -- self:cancel()
    EventMgr:dispatchEvent(eEvent.EVENT_FALL, self)
    local delayTime = self.data.floorTime*0.001 --倒地时间
    if self:isDead() then
        delayTime   = 0
    end
    self:getActor():playFloor(function()
        -- print("xxxxxxonFall okxxxxxxxx")
            if self:isAlive() then
                -- self:doEvent(eStateEvent.BH_STANDUP)
                    -- 调用起身技能
                local standUpSkill = self:getSkillByType(eSkillType.STANDUP)
                if standUpSkill and self:enableUseStandUpSkill() then
                    self:castSK(standUpSkill)
                else
                    _print(self:getName() .. "没有起身攻击技能")
                    self:doEvent(eStateEvent.BH_STANDUP)
                end
            else
                self:doEvent(eStateEvent.BH_DIE)
            end
        end,delayTime)
end

function Hero:enableUseStandUpSkill()
    if BattleDataMgr:isMusicGameLevel() then
        return false
    end
    return true
end

--被攻击倒地
function Hero:onStandUp(arg)
    self:getActor():playStandUp(function()
            if self:isAlive() then
                self:doEvent(eStateEvent.BH_STAND)
                self:checkBornState()
            else
                self:doEvent(eStateEvent.BH_DIE)
            end
        end)
end

--快速移动
function Hero:onQuickMove( arg )
    -- dump(arg,"------------arg")
    -- print(">>>>>>>>>>>>>>>>>>>>>>>>onQuickMove")
    -- local stateEvent = arg.stateEvent or eStateEvent.BH_STAND
    -- self.actor:playQuickMove()
    -- self.actor:moveToTarget(arg.time,arg.pos,function()
    --     -- self:doEvent(stateEvent,arg)
    --     if arg.callback then
    --         arg.callback()
    --     else
    --         self:doEvent(stateEvent,arg)
    --     end
    -- end)
end

function Hero:onBorn(callback)
    --角色入场事件

    self.bornCallFunc = callback
    local function onFunc()
        self:onEventTrigger(eBFState.E_HERO_ENTER,self)
        self:doEvent(eStateEvent.BH_STAND)
        if self.bornCallFunc then
            self.bornCallFunc()
            self.bornCallFunc = nil
        end
        self:setFight(true)
    end
    self.actor:show()
    --0 特效 1只播动作   2 特效和动作同时播
    local bornType = self.data.bornEffect
    if bornType == 0 then
        self.actor:playStand()
        self.actor.skeletonNode:show()
        local bornEffect = self.data.currencybornEffect
        local bornAction = self.data.currencybornAction
        if bornEffect ~= "" then
            local scale        = BattleConfig.MODAL_SCALE* self:getSkeletonNodeScale()
            local skeletonNode = self.actor:playEffect(bornEffect,scale,bornAction,onFunc)
            __setSkeletonNodeDir(skeletonNode,self:getDir())
        else
            onFunc()
        end
    elseif bornType == 1 then
        self.actor.skeletonNode:show()
        self.actor:playBorn(onFunc)
    elseif bornType == 2 then --
        self.actor.skeletonNode:show()
        self.actor:playBorn(onFunc)
        local bornEffect = self.data.currencybornEffect
        local bornAction = self.data.currencybornAction
        --_print("bornEffect"..tostring(bornEffect).." bornAction"..tostring(bornAction))
        local scale        = BattleConfig.MODAL_SCALE* self:getSkeletonNodeScale()
        local skeletonNode = self.actor:playEffect(bornEffect,scale,bornAction)
        __setSkeletonNodeDir(skeletonNode,self:getDir())
    else
        --_print("无出场动画和出场特效")
        self.actor.skeletonNode:show()
        onFunc()
    end
end

function Hero:onStand()
    if self.actor then
        self.actor:playStand()
    end
    if self.aiAgent then
        self.skillDamageFlag = 0
    end
end


function Hero:onMove(arg)
    local stateEvent = arg.stateEvent or eStateEvent.BH_STAND
    self.actor:playMove()
    -- self.actor:moveToTarget(arg.time,arg.pos,function()
    --     self:doEvent(stateEvent)
    --     if arg.callback then
    --         arg.callback()
    --     end
    -- end)
    Box("call 废弃函数 onMove")
    local action = ActionMgr.createMoveAction()
    action:start(self,arg.time,arg.pos,function()
        self:doEvent(stateEvent)
        if arg.callback then
            arg.callback()
        end
    end)


end

function Hero:onMoveEx(arg)
    self.moveState = arg
    self.actor:playMove()
    self:playMoveEffect()
end
function Hero:onCastSkill(actionData)
    self:stopSoundEffect()
    self.curSkill = self.skill
    self.actor.fixZOrder = actionData.fixZOrder
    self.actor:stopAllActions()
    local function onAcitonOver ()
        if not self:onSKAcitonOver() then
            -- 技能正常结束继续执行下一个行为
            if self.aiAgent and self.skill == self.curSkill then
                self.curSkill = nil
                self.willUseSkill = nil
                self.skillDamageFlag = 0
                self:doEvent(eStateEvent.BH_STAND)
                self.aiAgent:next()
            else
                self:doEvent(eStateEvent.BH_STAND)
            end
            self:checkBornState()
        end
    end
    self.actor:playSkill(self.skill,actionData,onAcitonOver)
    if self == battleController.getCaptain() then
        if BattleGuide:isGuideStart() == true then
            BattleGuide:onCtrlKeyClicked(self.skill.data.keyName)
        end
    end
end
--技能动作播放完成
function Hero:onSKAcitonOver()
    if self.skill then
        if self.curForm:isContain(self.skill) then --检查当前技能的动作是否属于当前形态的技能
            return self.skill:onAcitonOver()
        end
    end
end

function Hero:cancelToStand(force)
    self:cancel(true)
    self:doEvent(eStateEvent.BH_STAND)
end

--被击
function Hero:onHurt(arg)
        -- dump(arg,"---ds------onHurt--arg")
    -- self:cancel()
    self.actor:playHurt(function()
        if self:isAlive() then
            if self:isAState(eAState.E_XUAN_YUN) then
                self:doEvent(eStateEvent.BH_VERTIGO)
            elseif self:isAState(eAState.E_PARALYSIS) then
                self:doEvent(eStateEvent.BH_PARALYSIS)
            else
                self:doEvent(eStateEvent.BH_STAND)
                self:checkBornState()
            end
        else
            self:doEvent(eStateEvent.BH_DIE)
        end
    end)

-----地面击退(X方向位移)
    if arg then
        -- self:getActor():jump(arg.time,arg.endPos,arg.high ,function ()
        --     self:getActor():clearJumpInfo()
        -- end,0)
        local hurtAction = ActionMgr.createMoveAction()
        hurtAction:start(self,arg.time,arg.delta)

    end

end

function Hero:onDie(arg)
    --死亡事件检查
    
    self:onEventTrigger(eBFState.E_DEAD,self)
    if not self:isAState(eAState.E_RELIVE) then
        self:setFlag(eFlag.DEAD_Statistics)
        if self.isDeaded then
            
        else
            self.isDeaded = true
            EventMgr:dispatchEvent(eEvent.EVENT_HERO_DEAD, self)
        end
    end
    local function _fadeOut( )
        self.actor:fadeOut(function()
            local roleType = self:getData().roleType
            if roleType == eRoleType.Team then  --组队
                --有复活buffer执行复活操作
                if self:isAState(eAState.E_RELIVE) then
                    self:clearAState(eAState.E_RELIVE)
                    self:relive()
                else
                    -- EventMgr:dispatchEvent(eEvent.EVENT_HERO_DEAD, self)
                    -- battleController.resetSyncBossState_hero_pid()
                end
            elseif roleType == eRoleType.Hero then --我们队员(包涵)
                if battleController.getCaptain() == self then
                    if self:isAState(eAState.E_RELIVE) then
                        self:clearAState(eAState.E_RELIVE)
                        self:relive()
                    else
                        local captain = self.team:nextCaptain()
                        if captain then
                            captain:setControl()
                        end
                        self.team:remove(self)
                        self:release()
                        -- EventMgr:dispatchEvent(eEvent.EVENT_HERO_DEAD, self)
                    end
                else
                    --self:print("死亡2")
                   if self:isAState(eAState.E_RELIVE) then
                        self:clearAState(eAState.E_RELIVE)
                        local hp = self:getValue(eAttrType.ATTR_MAX_HP)/2
                        self:changeHp(hp)
                        self:doEvent(eStateEvent.BH_STAND)
                        self:removeFrormBattle()
                    else
                        self.team:remove(self)
                        self:release()
                        -- EventMgr:dispatchEvent(eEvent.EVENT_HERO_DEAD, self)
                    end
                end
            elseif roleType == eRoleType.Monster then --怪
                if self:isAState(eAState.E_RELIVE) then
                    self:clearAState(eAState.E_RELIVE)
                    self:relive()
                else
                    self.team:remove(self)
                    self:release()
                    -- EventMgr:dispatchEvent(eEvent.EVENT_HERO_DEAD, self)
                end
            end
        end)
    end
--受伤状态播放die1死亡动画否则直接淡出
    self.actor:playDie(_fadeOut)




end

--复活
function Hero:relive(targetPos)
    self.isDeaded = false
    if self:isDead() then
        self:forceToFloor()
        self:doEvent(eStateEvent.BH_RELIVE)
    else
        --_print("非死亡状态不需要复活")
    end
end

--强制直接回血
function Hero:forceRelive()
    self.isDeaded = false
    self:forceToFloor()
    local hp = self:getValue(eAttrType.ATTR_MAX_HP)/2
    self:setValue(eAttrType.ATTR_NOW_HP,hp,true)
    self:doEvent(eStateEvent.BH_STAND)
    if self.actor then
        self.actor:show()
        self.actor:setOpacity(255)
        self.actor.skeletonNode:show()
    end
    self:clearFlag(eFlag.Dead)
end

--组队角色行为
local eHeroAction =
{
    LEAVE  = 1 , --离开队伍
    RELIVE = 2 , --复活
}

function Hero:excuteAction(action )
    if action == eHeroAction.LEAVE then --离开队伍
        --从战斗场景删除
        if self:getState() == eState.ST_BORN then
           if self.bornCallFunc then
                self.bornCallFunc()
                self.bornCallFunc = nil
           end
        end
        self:setValue(eAttrType.ATTR_NOW_HP,0)
        EventMgr:dispatchEvent(eEvent.EVENT_HERO_DEAD, self)
        self.team:remove(self,true)
        self:release()
        if self:getPID() == MainPlayer:getPlayerId() then
            EventMgr:dispatchEvent(eEvent.EVENT_LEAVE)
            Utils:showTips(tostring(self.data.pname).."离开了队伍")
        end
    elseif action == eHeroAction.RELIVE then --复活
        self.isDeaded = false
        self.actor:show()
        local hp = self:getValue(eAttrType.ATTR_MAX_HP)
        self:setValue(eAttrType.ATTR_NOW_HP,hp,true)
        self.actor:refresh()
        self:forceToFloor()
        self:doEvent(eStateEvent.BH_STAND)
        self:castByType(eSkillType.ENTER)
        --自己复活成功 关闭复活UI
        if self.data.pid == MainPlayer:getPlayerId() then
            EventMgr:dispatchEvent(EV_TEAM_FIGHT_FIGHT_REVIVE)
        end
    end
    -- battleController.resetSyncBossState_hero_pid()
end
--角色强制设置到地面
function Hero:forceToFloor()
    self.position3D.z = self.position3D.y
    self.actor:setPosition(self.position3D.x,self.position3D.z)
end

local function getTragetX(px ,targetX1, targetX2)
    if math.abs(targetX1 - px) < math.abs(targetX2 - px) then
        return targetX1
    end
    return targetX2
end

function Hero:updateDirWithTarget(target)
    local targetX = target.position3D.x
    local posX    = self.position3D.x
    if posX > targetX then
        self:setDir(eDir.LEFT)
    else
        self:setDir(eDir.RIGHT)
    end
end


-- local eKeyNameMapped = {}
-- eKeyNameMapped["A"] = eVKeyCode.SKILL_A
-- eKeyNameMapped["B"] = eVKeyCode.SKILL_B
-- eKeyNameMapped["C"] = eVKeyCode.SKILL_C
-- eKeyNameMapped["D"] = eVKeyCode.SKILL_D
-- eKeyNameMapped["E"] = eVKeyCode.SKILL_E


function Hero:getAngleDatas()
    if self.host then
        return self.host:getAngleDatas()
    end
    return self.data.angleDatas
end
--
function Hero:getSkillList()
    return self.curForm:getSkillList()
end


function Hero:createSkills()
    --所有形态
    self.forms = {}

    --动态创建技能
    -- for i, data in ipairs(self.data.formDatas) do
    --     local form = Form:new(data,self)
    --     table.insert(self.forms,form)
    -- end

end

function Hero:calculatePoistion()
    if self:getRoleType() == eRoleType.Hero  then
                return levelParse:getBornPos(1)
    elseif self:getRoleType() == eRoleType.Team then
        return levelParse:getBornPos(self.data.bornIndex)
    else
        if self.data.position then
            return self.data.position
        else
            --怪物随机出生点
            if self.data.nearByHero then
                local offset = 600
                local captain = battleController.getCaptain()
                local pos = captain:getPosition()
                local rect = CCRectMake(pos.x - offset, pos.y - offset, offset * 2, offset * 2)
                return levelParse:randomPos(rect)
            else
                return levelParse:randomBonePos()
            end
        end

    end
end

function Hero:getTeam()
    return self.team
end


--创建角色模型并添加到战斗场景
function Hero:createActor(position,hide)
    hide = hide or false
    self.actor   =  Actor:new(self)
    self.actor:hide()
    local bornPos  =  self:calculatePoistion()
    self:setPosition3D(bornPos.x,bornPos.y,bornPos.y)
    self:setLastPosition(bornPos.x,bornPos.y,bornPos.y)
    self.bornPos_ = bornPos


    -- self.actor:setPosition(bornPos)
    -- self.actor:playStand()
    self.actor:refresh()
    self.actor:setVisible(not hide)

    --做retain 防止被释放了(销毁时要调用release!!!!)
    self.actor:retain()
    --加入在角色管理器
    heroMgr:add(self)

    --初始默认形态
    self:changeSkin(self.data.beginForm)

    --设置初始朝向
    local dir = self.data.dir or eDir.LEFT
    self:__setDir(dir)

    local roleType = self.data.roleType
    if roleType == eRoleType.Team then
        self:addToBattle()
    elseif roleType == eRoleType.Monster then
        self:addToBattle()
    elseif roleType == eRoleType.Hero then
        if self.data.job == 1 then --默认队长
            self:addToBattle()
            battleController.setCaptain(self)
        end
    elseif roleType == eRoleType.Assist then --助战队员
        -- self:addToBattle()
    elseif roleType == eRoleType.Trap then --陷阱
        self:addToBattle()
    end

end

function Hero:checkBornState()
    if not BattleDataMgr:isMusicGameLevel() then
        return
    end
    if #self.preCastSkillData > 0 then
        return
    end
    if self.mixSkills then
        if #self.mixSkills < 1 then
            EventMgr:dispatchEvent(eEvent.EVENT_SKILL_OVER)
            self.mixSkills = nil
        else
            return
        end
    end
    if math.abs(self.bornPos_.x - self.position3D.x) > 10 or math.abs(self.bornPos_.y - self.position3D.y) > 10 then
        self:moveToPos(self.bornPos_, function()
            self:moveToStand()
            local dir = self.data.dir or eDir.LEFT
            self:__setDir(dir)
        end)
    end
end

function Hero:castMixSkills()
    if self.mixSkills and #self.mixSkills > 0 then
        if self.skill then
            local skill = self:getSkillByCid(self.mixSkills[1])
            if self.skill == skill and skill:getSKillType() == eSkillType.GENERAL then
                self:createAndPush(skill:getKeyCode(),eKeyEventType.DOWN)
                table.remove(self.mixSkills, 1)
            end
        else
            if self:_checkState(eState.ST_STAND) then
                local skill = self:getSkillByCid(self.mixSkills[1])
                self:castSK(skill,true)
                table.remove(self.mixSkills, 1)
            end
        end
    end
end

function Hero:checkPreCastSkill()
    if self.mixSkills then
        return
    end
    if BattleDataMgr:isMusicGameLevel() then
        if self:_checkState(eState.ST_STAND) then
            local data = table.remove(self.preCastSkillData,1)
            if data then
                self.mixSkills = data.skills
                local movePos
                if data.dictance > 0 then
                    local target = self:findTarget()
                    local bornPos = target.bornPos_
                    movePos = clone(self.bornPos_)
                    if bornPos.x > movePos.x then
                        movePos.x = movePos.x + data.dictance
                    else
                        movePos.x = movePos.x - data.dictance
                    end
                else
                    movePos = self.bornPos_
                end
                if math.abs(self.position3D.x - movePos.x) > 20 or math.abs(self.position3D.y - movePos.y) > 20 then
                    self:moveToPos(movePos, function()
                        self:moveToStand()
                    end)
                end
            end
        end
    end 
end

function Hero:preCastSkill(moveDistance,skillIds)
    table.insert(self.preCastSkillData,{dictance = moveDistance, skills = skillIds})
end


function Hero:AiEnableEx(enable)
    if self.aiAgent then
        self.aiAgent:setEnabledEX(enable)
    end
end

function Hero:getActor()
    return self.actor
end

function Hero:pause()
    if self.actor then
        self.actor:pause()
    end
end

function Hero:resume()
    if self.actor then
        self.actor:resume()
    end
end

--处理能量获取
function Hero:handleEnergyMgr(time)
    if self.energyMgr then
        self.energyMgr:update(time)
    end
    --霸体值获取处理
    if self.superArmorMgr then
        self.superArmorMgr:update(time)
    end
end

function Hero:getSkillType()
    if self.skill then
        return self.skill:getSKillType()
    end
    return 0
end

function Hero:handlSkill(time)
    --检查当前技能的连级
    if self.curForm then
        self.curForm:update(time)
    end
    if self.skill then
        self.skill:checkNext()
    end
end
--影子处理
function Hero:actorUpdata(time)
    if self.actor then
        self.actor:update(time)
    end
end

--助战队员
function Hero:isAssist()
    return self.data.roleType == eRoleType.Assist
end


function Hero:doFirstTrigger(time)
    if not self:isFlag(eFlag.FirstUpdate) then
        self:setFlag(eFlag.FirstUpdate)
        --统计我方成员血量
        EventMgr:dispatchEvent(eEvent.EVENT_NOTICE_HP, self,self:getMaxHp())
        EventMgr:dispatchEvent(eEvent.EVENT_HERO_BATTLE, self)
        if self:enableUpdateBossPanel() then
            EventMgr:dispatchEvent(eEvent.EVENT_BOSS_CHANGE, self)
        end
        --天赋buff触发
        self:onTalentTrigger()
        self.property:dispatchChange()
        if self:getCampType() == 1 then
            battleController.checkLimitHeroAttrExchange()
        end
    end
end

--
function Hero:doCountDown(time)
    --队员切换冷却
    if self.countDown then
        self.countDown:update(time)
    end
    --技能更新(冷却)
    -- for key , skill in ipairs(self:getSkillList()) do
    --     skill:update(time)
    -- end
    -- if self.curForm then
    --     self.curForm:doCD(time)
    -- end
    for i,form in ipairs(self.forms) do
        form:doCD(time)
    end

end


function Hero:isFlag(flagType)
    return self.flags[flagType]
end

function Hero:setFlag(flagType)
    self.flags[flagType] = true
end

function Hero:clearFlag(flagType)
    self.flags[flagType] = nil
end

function Hero:toFlashBack(sec)
    if not self.recorder then
        return
    end
    local data  = self.recorder:getData(sec)
    if data then 
        -- self:forceToFloor()
        self.position3D.x = data.position.x
        self.position3D.y = data.position.y
        self.position3D.z = data.position.y
        self.actor:setPosition(self.position3D.x,self.position3D.z)
        self:setValue(eAttrType.ATTR_NOW_HP,data.hp,true)
        self:doEvent(eStateEvent.BH_STAND)
    else
        printError("回溯信息不存在"..tostring(sec))
    end
end

function Hero:update(time)
    if self.position3D.x ~= self.lastPsition3D.x or self.position3D.y ~= self.lastPsition3D.y then
        EventTrigger:_onChangePos(self)
        self:setLastPosition(self.position3D.x,self.position3D.y,self.position3D.z)
    end
    if self.recorder then
        self.recorder:update(time,self)
    end
    local originTime = time
    time = time * self:getTimeScale()
    self.showTiming_ = self.showTiming_ + time
    self:doFirstTrigger()
    self:doAttrTrigger()
    self:doCountDown(time)
    --未出战不做处理
    if not self:isBattle() then
        self:clearFlag(eFlag.HITED)
        if self:isDead() then
            self:onEventTrigger(eBFState.E_DEAD,self)
            if self:isAState(eAState.E_RELIVE) then
                self:clearAState(eAState.E_RELIVE)
                local hp = self:getValue(eAttrType.ATTR_MAX_HP)/2
                self:setValue(eAttrType.ATTR_NOW_HP,hp,true)
                -- self:removeFrormBattle()
            else
                self:setFlag(eFlag.DEAD_Statistics)
                if self.isDeaded then
                    
                else
                    self.isDeaded = true
                    EventMgr:dispatchEvent(eEvent.EVENT_HERO_DEAD, self)
                end
                self:release()
                self:checkAndRelease()
            end
        end    
        return   
    end
    self:checkAndPlayEndAction()

    local state = self:getState()
    --抓取处理
    if state == eState.ST_GRASP then
        -- print_(">>>>>>>>抓取>>>>>>>>>")
        self:simulateMove(time)  --actionMgr  update
        self:actorUpdata(time)   --hero spine update
        self:handlSkill(time)
        self:handleEnergyMgr(time)
        self:handlBufferEffect(originTime)
        self:graspUpdate(time)--抓取倒计时处理

        return
    end
    --死亡
    if self:isDead() then
        if not self:isFlag(eFlag.Dead) then
            self:setFlag(eFlag.Dead)
            --清理负面状态
            self:clearAState(eAState.E_DONG_JIE)
            self:clearAState(eAState.E_JING_ZHI)
            self:clearAState(eAState.E_STATE_84)
            self:clearAState(eAState.E_XUAN_YUN)
            self:clearAState(eAState.E_PARALYSIS)
        end
        if state == eState.ST_STAND then
            self:doEvent(eStateEvent.BH_DIE)
            self:checkAndRelease()
            self:clearFlag(eFlag.HITED)
            return
        elseif state == eState.ST_MOVEEX then
            self:doEvent(eStateEvent.BH_DIE)
            self:checkAndRelease()
            self:clearFlag(eFlag.HITED)
            return
        end
    end

    if not (self:isAState(eAState.E_JING_ZHI) or self:isAState(eAState.E_STATE_84)) then
        if state == eState.ST_FLOAT then
            --浮空时间计算
            self:doFloatingProtection(time)
        elseif state == eState.ST_STAND then
            if self:isAState(eAState.E_DONG_JIE) then
                self:doEvent(eStateEvent.BH_FROZEN)
                self:checkAndRelease()
                self:clearFlag(eFlag.HITED)
                return
            elseif self:isAState(eAState.E_XUAN_YUN) then --切换到眩晕状态
                self:doEvent(eStateEvent.BH_VERTIGO)
                self:checkAndRelease()
                self:clearFlag(eFlag.HITED)
            elseif self:isAState(eAState.E_PARALYSIS) then --切换到麻痹
                self:doEvent(eStateEvent.BH_PARALYSIS)
                self:checkAndRelease()
                self:clearFlag(eFlag.HITED)    
                return
            end
        elseif state == eState.ST_MOVEEX then

            if self:isAState(eAState.E_DONG_JIE) then
                self:doEvent(eStateEvent.BH_FROZEN)
                self:checkAndRelease()
                self:clearFlag(eFlag.HITED)
                return
            elseif self:isAState(eAState.E_XUAN_YUN) then
                self:doEvent(eStateEvent.BH_VERTIGO)  
                self:checkAndRelease()
                self:clearFlag(eFlag.HITED)
                return
            elseif self:isAState(eAState.E_PARALYSIS) then
                self:doEvent(eStateEvent.BH_PARALYSIS)  
                self:checkAndRelease()
                self:clearFlag(eFlag.HITED)
                return    
            end 
            if not self:isManual() then
                if battleController.isLockStep() then
                    if LockStep.JumpFrame then
                        if not self.autoMoveOnframe then
                            self.autoMoveOnframe = true
                            self:autoMove(time)
                        end
                    else
                        self.autoMoveOnframe = false
                        self:autoMove(time)
                    end
                else
                    self:autoMove(time)
                end
               -- _print("_____________autoMove_______________")
            end
        end
        self:simulateMove(time)  --actionMgr  update
        self:actorUpdata(time)   --hero spine update
        self:handlSkill(time)
        self:handleEnergyMgr(time)
        self:handlBufferEffect(originTime)
        if self:isManual() then
            self:handlMove(time)
        else
            if battleController.isLockStep() then
                if LockStep.JumpFrame then
                    if not self.runAiOnframe then
                        self.runAiOnframe = true
                        self:ai(time)
                    end
                else
                    self.runAiOnframe = false
                    self:ai(time)
                end
            else
                self:ai(time)
            end
            -- _print("_____________ai_______________")
        end
    else
        self:handlBufferEffect(originTime)
    end
    if self:isFlag(eFlag.HITED) then
        if self.skill then
            self.skill:checkNext_hitAction()
        end
        self:clearFlag(eFlag.HITED)
    end

    self:checkPreCastSkill()
    self:castMixSkills()
    self:checkAndRelease()

end

function Hero:doFloatingProtection(time)
    --浮空时间计算
    self.nFloatTime = self.nFloatTime + time
    if self.nFloatTime > 8000 then
        local value = self.nFloatTime - 8000
        value = math.min(value,7000)
        value = value / 7000
        local g = math.abs(210 + (255-210) * value)
        local b = math.abs(value * 255)
        self:getActor():setColor(me.c3b( 0xBB , g , b ),eColorType.FloatingProtection)
    end
end
--找离自己最近的人
function Hero:findTarget()
    local objs = self.team:getEnemys(self:getCamp())
    local heros = self:checkEnableTarget(objs)
    if #heros == 0 then
        return nil
    end
    local pos1    = self:getPosition()
    local tmpDis  = 999999
    local idx  = 1
    for index ,hero in ipairs(heros) do
        local pos2     = ccp(hero:getPosition())
        local dis = math.abs(pos2.x - pos1.x)
        if dis < tmpDis then
            tmpDis = dis
            idx    = index
        end
    end
    return heros[idx]
end

--所有敌人
function Hero:findTargets()
    return self.team:getEnemys(self:getCamp())
end

--找到指定区域里的敌人
function Hero:findScopeTargert(rect)
    local heros    = self.team:getEnemys(self:getCamp())
    local retHeros = {}
    if #heros > 0 then
        for index ,hero in ipairs(heros) do
            local pos = hero:getPosition3D()
            if me.rectContainsPoint(rect, pos) then
                table.insert(retHeros, hero)
            end
        end
    end
    return retHeros
end





function Hero:getAreaEnemys(length,num)
    if num == nil or num == -1 then
        num = 100
    end
    local temp = {}
    local heroList = battleController.getTeam():getEnemys(self:getCamp())
    for i, hero in ipairs(heroList) do
        if #temp < num then
            if length > 0 then
                if self:distance(hero) < length then
                    table.insert(temp,hero)
                end
            else
                table.insert(temp,hero)
            end
        end
    end
    return temp
end
--一定范围里的好友[包涵未出战的队员]
function Hero:getAreaFrineds(length,num,containMe)
    if num == nil or num == -1 then
        num = 10
    end
    local temp = {}
    local heroList = battleController.getTeam():getFriends(self:getCamp())
    for i, hero in ipairs(heroList) do
        if #temp < num then
            if hero ~= self or containMe then
                if length > 0 then
                    if self:distance(hero) < length then
                        table.insert(temp,hero)
                    end
                else
                    table.insert(temp,hero)
                end
            end
        end
    end
    return temp
end

--精灵召唤物
function Hero:getCalls(length,num,camp)
    if num == nil or num == -1 then
        num = 10
    end
    local temp = {}
    local heroList = battleController.getTeam():getMenbers(eCampType.Call)
    for i, hero in ipairs(heroList) do
        if #temp < num then
            if camp then
                local host = hero:getHost()
                if host then
                    if BattleUtils.campState(host:getCamp(),self:getCamp()) == camp then
                        if length > 0 then
                            if self:distance(hero) < length then
                                table.insert(temp,hero)
                            end
                        else
                            table.insert(temp,hero)
                        end
                    end
                end
            else
                if length > 0 then
                    if self:distance(hero) < length then
                        table.insert(temp,hero)
                    end
                else
                    table.insert(temp,hero)
                end
            end
        end
    end
    return temp
end

function Hero:getFriends()
    return self.team:getFriends(self:getCamp())
end

function Hero:getHost()
    return self.host
end

local function symbol(value)
    return value < 0 and -1 or 1
end


function Hero:distance(hero)
    local posx1 = self:getPosition3D()
    local posx2 = hero:getPosition3D()
    -- return posx2-posx1
    return me.pGetDistance(posx1,posx2)
end


--怒气
function Hero:getAnger()
    return self.property:getValue(eAttrType.ATTR_NOW_AGR)
end

function Hero:changeAnger(value)
    if not self:isFlag(eFlag.SUPER_SKILL) then
        self.property:changeValue(eAttrType.ATTR_NOW_AGR, value)
    end
end

function Hero:changeSpecialEnergy(value)
    if not self:isFlag(eFlag.SUPER_SKILL) then
        self.property:changeValue(eAttrType.ATTR_DESPAIR, value)
    end
end

--绝望点
function Hero:getSpecialEnergy()
    return self.property:getValue(eAttrType.ATTR_DESPAIR)
end

function Hero:getSpecialEnergyPercent()
    local maxValue = self.property:getValue(eAttrType.ATTR_MAX_DESPAIR)
    if maxValue == 0 then 
        return 0
    end
    return self.property:getValue(eAttrType.ATTR_DESPAIR)*10000 /self.property:getValue(eAttrType.ATTR_MAX_DESPAIR)
end

--非强制消耗的能量
function Hero:changeEnergy(value)
    if not self:isFlag(eFlag.SUPER_SKILL) then
        -- self.property:changeValue(eAttrType.ATTR_NOW_ENERGY, value)
        self:changeValue(eAttrType.ATTR_NOW_ENERGY,value)
    end
end

function Hero:getBaseValue(attrType)
    return self.property:getBaseValue(attrType)
end
--获取临时属性
-- function Hero:getTempValue(attrType)
--     return self.property:getTempValue(attrType)
-- end
function Hero:changeTempValue(attrType,value)
    return self.property:changeTempValue(attrType,value)
end

--设置临时属性
function Hero:setTempValue(attrType,value)
    return self.property:setTempValue(attrType,value)
end
--清理临时属性
function Hero:cleanTempProperty()
    return self.property:cleanTemp()
end

function Hero:getValue(attrType)
    if attrType == eAttrType.ATTR_COMBO then
        return battleController.getComboNum()
    elseif attrType == eAttrType.ATTR_ENEMY_NUMS then
        local heros = self.team:getEnemys(self:getCamp())
        return #heros
    elseif attrType == eAttrType.ATTR_IMPRINT_NUMS then
        local heros = self.team:getEnemys(self:getCamp())
        local ret   = 0
        for i, hero in ipairs(heros) do
            if hero:isAState(eAState.E_IMPRINT) then
                ret = ret + 1
            end
        end
        return ret
    end
    return self.property:getValue(attrType)
end

function Hero:setValue(attrType,value,event)
    self.property:setValue(attrType,value)
    if event then
        self.property:doChange(attrType,0)
    end
end
function Hero:changeValue(attrType,value)
    if attrType == eAttrType.ATTR_SPD then
        if value < 0 then
            if self:isAState(eAState.E_JIANSU_MY) then
                return
            end
        end
    elseif attrType == eAttrType.ATTR_MOVE_SPEED then
        if value < 0 then
            if self:isAState(eAState.E_MOVE_SPEED_MY) then
                return
            end
        end
    elseif attrType == eAttrType.ATTR_NOW_ENERGY then
        if value < 0 then
            if self:isFlag(eFlag.SUPER_SKILL) then
                return
            end
        end
        if self.energyMgr then
            self.energyMgr:energyExchange(value)
        end
    elseif attrType == eAttrType.ATTR_NOW_AGR then
        if value < 0 then
            if self:isFlag(eFlag.SUPER_SKILL) then
                return
            end
        end
    end
    --当前能量变更存储变更值
    if attrType == eAttrType.ATTR_NOW_ENERGY then
        local _value = self.property:getValue(attrType)
        self.property:changeValue(attrType,value)
        local _newValue = self.property:getValue(attrType)
        value = _newValue - _value
        if value > 0 then 
            self:setValue(eAttrType.ATTR_ADD_AGR,value,true)
        elseif value < 0 then 
            self:setValue(eAttrType.ATTR_RED_AGR,math.abs(value),true)
        end
    else
        self.property:changeValue(attrType,value)
    end

    if attrType == eAttrType.ATTR_NOW_HP then
        self:showDamage(value)
    end
    --血条
    if self:getActor() then
        self:getActor():refresh()
    end
end

--吸收处理
function Hero:absorb(value)
    if value >= 0  then
        return value
    end
    --护盾完全吸收
    local sldValue  = self:getValue(eAttrType.ATTR_NOW_SLD)
    -- _print("sldValue value:",sldValue)
    if sldValue > 0 then
        self:showState(eShowState.XiShou) --吸收
        local _value = sldValue + value
        if _value >= 0 then --可以完全吸收
            self:changeValue(eAttrType.ATTR_NOW_SLD,value)
            return 0
        else--只够吸收部分
            self:changeValue(eAttrType.ATTR_NOW_SLD,-sldValue)
            value = _value
        end
    end
    --[[
    --抵抗百分比
    local rstValue  = self:getValue(eAttrType.ATTR_NOW_RST)
    --抵抗减伤比
    local percent = self:getValue(eAttrType.ATTR_RSTDMSUB_RATIO)*0.0001
    percent =  math.min(percent,1)
    percent =  math.max(percent,0)
    local absorbValue = value * percent
    local fixedValue  = value * (1 - percent) --固定值
    if rstValue > 0 and absorbValue < 0 then
        local _value = rstValue + absorbValue
        if _value > 0 then  --完全吸收
            self:changeValue(eAttrType.ATTR_NOW_RST,absorbValue)
            return fixedValue
        else --部分吸收
            self:changeValue(eAttrType.ATTR_NOW_RST,-rstValue)
            return (_value + fixedValue )
        end
    end
    --]]
    --抵抗值不吸收伤害,实际减多少血就减多少抵抗值
    if value < 0 then
        -- 1、霸体值存在时，角色减伤50%
        -- 2、霸体值存在时，受到伤害时。霸体值按照受伤200%来扣除
        if self:getResist() > 0 then
            self:changeValue(eAttrType.ATTR_NOW_RST,value*2)
        end
    end
    return value
end

function Hero:checkMaxValue(value)
    local maxValue = self:getValue(eAttrType.ATTR_REDUCE_MAX_HP)
    if maxValue > 0 and value < 0 then
        if math.abs(value) > maxValue then
            return - maxValue
        end
    end
    return value
end


--受护盾影响
function Hero:changeHp(value,hurtType,target,bAbsorb,point,hideDamage)
    if value < 0 then 
        if self:isAState(eAState.E_MIANYI_LOSH_HP) then 
            self:onEventTrigger(eBFState.E_LOSE_HP_IMMUNE,target)
            self:showState(eShowState.MianYi) --伤害免疫
            return 0
        end
    end
    hurtType = hurtType or eHurtType.PUGONG
    if bAbsorb == nil then
        bAbsorb = true
    end
    if hurtType == eHurtType.DODGE then
        if self:getCampType() == eCampType.Hero then
           hurtType = eHurtType.DODGE1
        end
    end
    local showValue
    -- 护盾吸收处理
    if bAbsorb then
        value = self:absorb(value)
    end
    -- _print("change hp value:",value)
    if value ~= 0 then
        --濒死状态判断
        if value < 0 then
            --无敌状态不减血
            if self:isImmune() then
                return

            end
            --检查最大减血量
            value = self:checkMaxValue(value)
            local hp = self:getHp()
            if value + hp <= 0 then
                -- Box("濒死状态触发")
                self:onEventTrigger(eBFState.E_DYING,target)
                if self:isImmune() then

                    return
                end
            end
            --检查锁血
            local lockhp = self:getLockHp()
            if lockhp > 0 then
                -- if hp > lockhp and ( hp + value  < lockhp) then 
                --     value = lockhp - hp
                -- else
                --     return
                -- end
                local _value = lockhp - hp
                if _value >= 0 then 
                    return 
                elseif _value > value then 
                    value = _value 
                end
            end

            local limitHp = self:getLimitHp()
            if limitHp > 0 then
                if hp < limitHp then
                    self:setValue(eAttrType.ATTR_NOW_HP,limitHp)
                    value = 0
                elseif value + hp < limitHp then
                    showValue = value
                    value = limitHp - hp
                end
            end
        elseif value > 0 then --加血
            --触发被治疗事件
            self:onEventTrigger(eBFState.E_TREATE)
        end

        local bDead = self:isDead()
        if self:isRealChangeHp() then
            if not self:isUnlimitedHp() then 
                value = self.property:changeValue(eAttrType.ATTR_NOW_HP,value)
            else
                print_("value:"..tostring(value))
                self:changeUnlimitedHp(value)
            end
        else --非真实加血也做加成计算 避免显示不同步的问题
            if value > 0 then
                value = value*(1 + self.property:getValue(eAttrType.ATTR_TREATMENT_RATE)*0.0001)
            end
        end
        self:refresh()
        --检查是否死亡
        if not bDead and self:isDead() then
            self:checkBattleEnd(bDead)
        end
    end
    if not hideDamage then
        showValue = showValue or value
        self:showDamage(showValue,hurtType,point)
    end
    if self.actor then
        self.actor:refresh()
    end

    if value < 0 then
        local curTime = BattleUtils.gettime()
        self.hurtTypeInfos = self.hurtTypeInfos or {}
        self.hurtTypeInfos[hurtType] = self.hurtTypeInfos[hurtType] or {}
        local frontInfo = self.hurtTypeInfos[hurtType][1]
        if frontInfo and (curTime - frontInfo.time) > 3000 then
            table.remove(self.hurtTypeInfos[hurtType],1)
        end
        table.insert(self.hurtTypeInfos[hurtType],{time = curTime, hurt = -value})
    end

    if value ~= 0 then
        --我方队伍失血统计
        if value < 0 then
            self:addRevHurtValue(value)
        end
        EventMgr:dispatchEvent(eEvent.EVENT_HP_CHANGE, self,value)
        if battleController.useCustomAttrModle() then
            if value > 0 or self:getRoleType() == eRoleType.Team then
                battleController.synchronHp(self)
            end
        else
            battleController.synchronHp(self)
        end
    end
    return value
end

function Hero:checkInHurtVaild(hurtValue,time,hType)
    if self.hurtTypeInfos then
        local nTime = time or 200
        hurtValue = hurtValue or 100
        local curTime = BattleUtils.gettime()
        local totalValue = 0
        if hType then
            for hurtType,infos in pairs(self.hurtTypeInfos) do
                if hType == 1 and tonumber(hurtType) == eHurtType.PUGONG then
                    for i,v in ipairs(infos) do
                        if (curTime - v.time) < nTime then
                            totalValue = totalValue + v.hurt
                        end
                    end
                elseif hType == 2 and tonumber(hurtType) ~= eHurtType.PUGONG then
                    for i,v in ipairs(infos) do
                        if (curTime - v.time) < nTime then
                            totalValue = totalValue + v.hurt
                        end
                    end
                end
            end
        else
            for hurtType,infos in pairs(self.hurtTypeInfos) do
                for i,v in ipairs(infos) do
                    if (curTime - v.time) < nTime then
                        totalValue = totalValue + v.hurt
                    end
                end
            end
        end
        return totalValue > 0 and totalValue > hurtValue
    end
    return false
end

--是否真实减血
function Hero:isRealChangeHp()
    if battleController.isLockStep() then
        local roleType = self:getRoleType() 
        if roleType == eRoleType.Team then
            if battleController.getCaptain() == self then
                return true
            else
                return false
            end
        end
    end
    return true
end

--是否是队长
function Hero:isLeader()
    if battleController.isLockStep() then
        return self.data.pid == battleController.getLeaderPid()
    end
end
--组队模式当前角色是否是自己
function Hero:isMe()
    if battleController.isLockStep() then
        return self.data.pid == MainPlayer:getPlayerId()
    end
end

--检查战斗结束
function Hero:refresh()
    --血条
    if self:getActor() then
        self:getActor():refresh()
    end
end
--检查战斗结束
function Hero:checkBattleEnd()
    if battleController.isWillEnd() then
        battleController.bTiming = false --停止计时
        if not AwakeMgr.isPlay() then
            battleController.setSlowMotion(true)
        end
    end
end


--是否可以收到攻击
function Hero:canHit(isHurtFloor)
    if not self:isBattle() then
        return
    end
    if not battleController.isRun() then
        return false
    end
    if self:isRealDead() then
        return false
    end
    if self.skill then
        if self.skill:isActionHard() == 2 then --假无敌(不能被攻击)
            return false
        end
    end
    local state = self.fsm_:getState()
    if state == eState.ST_STANDUP
        or state == eState.ST_QUICKMOVE
        or state == eState.ST_BORN
        or state == eState.ST_DEPARTURE then
        return false
    elseif state == eState.ST_FALL then
        if not isHurtFloor then --不能攻击倒地
            if self:isFlag(eFlag.FALL) then
                return false
            end
        end
    end

    return true
end
function Hero:print(msg)
    -- _print("TS",self:getName(),":",self:getState()," ",msg)
end
function Hero:canCast(skill)
    if not skill:isEnable() then
        return false
    end
    if not battleController:isRun() then
        if skill:getSKillType() ~= eSkillType.DOWN then
            return false
        end
    end
    --触发觉醒技能时候不能 再放技能
    if AwakeMgr.isPlay() then
        return false
    end
    if self:isAState(eAState.E_JING_ZHI) then
        return false
    end
    if self:isAState(eAState.E_STATE_84) then
        return false
    end
    if self:isAState(eAState.E_DONG_JIE) then
        return false
    end
    if self:isAState(eAState.E_XUAN_YUN) then
        return false
    end
    if self:isAState(eAState.E_PARALYSIS) then
        return false
    end
    if skill:getSKillType() ~= eSkillType.DOWN then
        if self:isDead() then
            return false
        end
    end
    if not skill:isEnoughAnger() then
        return false
    end
    if not skill:isEnoughEnergy() then
        return false
    end
    --特殊技能大于100级别
    if skill:getLevel() > 100 then 
        return true
    end

    --检查能量消耗
    if self:getState() == eState.ST_STAND or
        self:getState() == eState.ST_MOVEEX or
        self:getState() == eState.ST_SKILL then
        return true
    elseif self:getState() == eState.ST_FALL then
        --只释放起身技能
        if skill:getKeyCode() == eVKeyCode.SKILL_G then
            return true
        end
    end
    return false
end


function Hero:canChangeSkin()
    if self:isAState(eAState.E_CHANGE_SKIN_MY) or self:isAState(eAState.E_WU_DI) then
        return false
    end
    return true
end


--检查能否被抓取
function Hero:canCrasp(objectID)
    if self:isAState(eAState.E_GRAB_MY) or self:isAState(eAState.E_WU_DI) then
        return false
    end
    if self:getState() == eState.ST_GRASP then 
        if self.graspData then --已经被抓取的 只有被同一个角色 持续抓取
            if  self.graspData.heroID ~= objectID then 
                return false
            end
        end
    end
    return true
end

function Hero:setHpPercent(percent)
    local maxHp = self:getMaxHp()
    local hp = maxHp * percent / 10000
    self.property:setValue(eAttrType.ATTR_NOW_HP, hp)
end

function Hero:isAlive()
    if not self.actor then
        return false
    end
    return self.property:getValue(eAttrType.ATTR_NOW_HP)> 0
end


function Hero:isInRect(rect)
    local pos = self:getPosition3D()
    return me.rectContainsPoint(rect,pos)
end

--计算伤害
function Hero:showDamage(damage,hurtType,point)
    damage = math.ceil(damage)
    hurtType =  hurtType or eHurtType.PUGONG
    if self:isBattle() and self:getActor() then
        if not point then
            point  = self:getActor():getBonePosition("body")
            point.x = point.x + RandomGenerator.random(-10,10)
            point.y = point.y + 75 + RandomGenerator.random(-10,10)
        end
        EventMgr:dispatchEvent(eEvent.EVENT_TIP,damage,point,hurtType)
    end
end


function Hero:hitTest(targetHero,isHurtFloor,bdbox_eff,bdbox)
    if self:isDead() or not targetHero:canHit(isHurtFloor) then
        return false
    end
    bdbox_eff  = bdbox_eff or "bdbox_eff"
    bdbox      = bdbox or "bdbox"
    local hitrect = targetHero.actor:getBoundingBox(bdbox)
    local rect   = self.actor:getBoundingBox(bdbox_eff)

    -- dump(hitPos,"hitPos")
    -- dump(rect,"rect")
    -- print(self:getData().name  ,"attack",  targetHero:getData().name,me.rectContainsPoint(rect,hitPos))
    return me.rectIntersectsRect(rect,hitrect)
end

function Hero:hitTestProp(rect)
    local bdboxs = self:getBodyArea()
    for k,bdbox in ipairs(bdboxs) do
        local hitrect = self:getBoundingBox(bdbox)
        if me.rectIntersectsRect(rect,hitrect) then 
            return true
        end
    end
end

function Hero:getHp()
    return self.property:getValue(eAttrType.ATTR_NOW_HP)
end


function Hero:isDead()
    return not self:isAlive()
end

--死亡并消失，主要用于鞭尸
function Hero:isRealDead()
    if self:getState() == eState.ST_DIE then
        return true
    end
    return self:isDead() and self.actor == nil
end

function Hero:isInAir()
    local pos = self.position3D
    return  math.ceil(pos.z -  pos.y) > 1
end

function me.pGetDistanceY(p1,p2)
    return math.abs(p2.y-p1.y)
end
function me.pGetDistanceX(p1,p2)
    return math.abs(p2.x-p1.x)
end

function Hero:doHurtAction(data)
    if self:isAState(eAState.E_DONG_JIE) or self:isAState(eAState.E_JING_ZHI) or self:isAState(eAState.E_STATE_84) then
        return
    end
    -- self:getActor():fixPosition()
    self:stopAllActions()
    if data.floatType == 1 then  --击飞
        --击飞衰减
        local time = self.nFloatTime or 0
        if time > 8000 then
            data.v = math.max(0, 1 - math.floor(time*0.001)/20)*data.v
            -- Box("time"..time.." "..data.v)
        end
        self:doEvent(eStateEvent.BH_FLOAT,data)
    elseif data.floatType == 2 then  --平移
        if self:isInAir()
            or (self:getState() == eState.ST_FALL and not self:isFlag(eFlag.FALL)) then
            if data.dir == 1 then
                data.a = 80
            else
                data.a = 100
            end
            data.v = 300
            self:doEvent(eStateEvent.BH_FLOAT,data)
        else
            local pram = {time = data.t ,delta = me.p(data.d,0)}
            self:doEvent(eStateEvent.BH_HIT,pram)
        end
    else
        if self:isInAir()
            or (self:getState() == eState.ST_FALL and not self:isFlag(eFlag.FALL)) then
            if data.dir == 1 then
                data.a = 25
            else
                data.a = 165
            end
            if data.v == 0 then
                data.v = 300
            end
            self:doEvent(eStateEvent.BH_FLOAT,data)
        else
            self:doEvent(eStateEvent.BH_HIT)
        end
    end
end

function Hero:isFall()
    if self:getState() == eState.ST_FALL then
        return self:isFlag(eFlag.FALL)
    end
    return false
end
function Hero:getRelativeBonePosition(boneName)
    if self.actor then
        return self.actor:getRelativeBonePosition(boneName)
    end
    return ccp(0,0)
end

function Hero:getBonePosition(boneName)
    if self.actor then
        return self.actor:getBonePosition(boneName)
    end
    return self:getPosition()
end

function Hero:getHitPosition()
    if self.actor then
        return self.actor:getBonePosition("hitpoint")
    else
        local pos = self.position3D
        return me.p(pos.x,pos.z + 80)
    end
end

--弱点攻击判定类型
local eWeaknessType =
{
    DIR       = 1,--方向判定
    ATTR_TYPE = 2,--怪物属性类型判定
    HIT_BOX   = 3,--指定受击框
    STATE     = 4,--状态判定

    --攻击者
    SRC_PROBABILITY = 5,--攻击者概率判定 （通过角色的一个属性来做判定概率判定10000)
    SRC_STATE       = 6,--攻击者状态判定

}


--获取爆点
--减血数字的位置
function Hero:calcuHitPoint(bdbox)
    if bdbox then
        return bdbox.point
    else
        local pos = self.position3D
        return me.p(pos.x,pos.z + 80)
    end
end

--弱点攻击判定(作为受击者)
function Hero:isWeakness(srcHero, bdboxs , hurtAttrType)
    local function _point(bdbox)
        if bdbox then
            return bdbox.point
        else
            return self:getHitPosition()
        end
    end

    local weaknessList = self.data.weakness
    if weaknessList then
        for k, weakness in pairs(weaknessList) do
            local pram1 = weakness[1]  --类型
            local pram2 = weakness[2]
            if pram1  == eWeaknessType.DIR then
                local px  = srcHero:getPosition().x - self:getPosition().x
                local dir = self:getDir()
                if dir == eDir.LEFT and px > 0 then
                    return true , _point(bdboxs[1])
                elseif dir == eDir.RIGHT and px < 0 then
                    return true , _point(bdboxs[1])
                end
            elseif pram1  == eWeaknessType.ATTR_TYPE then
                if tonumber(pram2) == hurtAttrType then
                    return true , _point(bdboxs[1])
                end
            elseif pram1  == eWeaknessType.HIT_BOX then
                for i, bdbox in ipairs(bdboxs) do
                    if tostring(pram2) == bdbox.name then
                        return true , bdbox.point
                    end
                end
            elseif pram1  == eWeaknessType.STATE then
                if self:isAState(tonumber(pram2)) then
                    return true , _point(bdboxs[1])
                end
            elseif pram1  == eWeaknessType.SRC_PROBABILITY then
                local probability = srcHero:getValue(tonumber(pram2))
                if BattleUtils.triggerTest10000(probability) then
                    return true , _point(bdboxs[1])
                end
            elseif pram1  == eWeaknessType.SRC_STATE then
                if srcHero:isAState(tonumber(pram2)) then
                    return true , _point(bdboxs[1])
                end
            end
        end
    end
    return false , _point(bdboxs[1])
end

--清除所有buff状态
function Hero:removeAllBuff()
    for key , buffer in ipairs(self.bufferList) do
        buffer:clear()
    end
    self.bufferList = {}
    --强制移除所有效果
    for index = #self.bufferEffectMap , 1 ,-1 do
        local effect = self.bufferEffectMap[index]
        if effect then
           effect:forceDestory()
        end
    end
    self.bufferEffectMap = {}
end


function Hero:printInfo(arg)
    print(string.format("name = %s %s",self.data.name,arg))
end

function Hero:showState(stateType)
    --TODO 目前只支持免疫
    local pos  = self:getActor():getBonePosition("root")
    pos.x = pos.x + RandomGenerator.random(-10,10)
    pos.y = pos.y + 150 + RandomGenerator.random(-10,10)
    EventMgr:dispatchEvent(eEvent.EVENT_SHOW_STATE,stateType,pos)
end



------------------------
-- function Hero:doAngerRule(ruleId)
--     -- print("doAngerRule",self.data.name,ruleId)
--     -- self.angerObtain:doTrigger(ruleId)

-- end


-- function Hero:onAngerObtain(value)
--     -- print("onAngerObtain",self.data.name,value)
--     -- self:changeAnger(value)
-- end

--是否是手动控制状态
-- function Hero:isManual()
--     return battleController.getCaptain() == self
-- end

function Hero:getPID()
    return self.data.pid
end

--是否是boss
function Hero:isBoss()
    return self.data.type == eMonsterType.MT_BOSS
end

--是否是手动控制状态
function Hero:isManual(flag)
    if self:isFlag(eFlag.PlotMode) then
        return false
    end
    if self:isAssist() then
        return false
    end
    if flag then  -- 必须是当前控制的队员
        return battleController.getCaptain() == self
    else
        if battleController.isLockStep() then
            if self:getCampType() == eCampType.Hero then
                return true
            end
        else
            return battleController.getCaptain() == self
        end
    end

end

--手动操作移动
function Hero:canMove()
    if self:isAState(eAState.E_DONG_JIE) or
        self:isAState(eAState.E_JING_ZHI) or
        self:isAState(eAState.E_STATE_84) or
        self:isAState(eAState.E_PARALYSIS) or
        self:isAState(eAState.E_XUAN_YUN) then
        return false
    end
    if self:isManual() then
        local state = self:getState()
        -- print("state::",state)
        if state == eState.ST_MOVEEX or state == eState.ST_STAND then
            return true
        elseif state == eState.ST_SKILL then --是否技能的时候 检查技能是否可以移动
            if self.skill then
                return self.skill:canMove()
            end
        end
    end
end

function Hero:move(xv,yv,fix)
    if self.actor then

        local pos = self.position3D
        local nx  = pos.x + xv
        local ny  = pos.y + yv
        -- _print("xv=",xv,"yv=",yv)
        if battleController.canMove(nx ,ny) then
            pos.x = nx
            pos.y = ny
        elseif battleController.canMove(nx , pos.y) and xv ~= 0 then
            pos.x = nx
        elseif battleController.canMove(pos.x , ny) and yv ~= 0 then
            pos.y = ny
        else
            if fix then
                if xv ~= 0 and yv == 0 then
                    local mvU = battleController.canMove(pos.x , pos.y + levelParse:getBlockSize())  --and battleController.canMove(pos.x , pos.y +40)
                    local mvD = battleController.canMove(pos.x , pos.y - levelParse:getBlockSize())  --and battleController.canMove(pos.x , pos.y -40)
                    if mvD and mvU then
                        return
                    elseif mvD then
                        pos.y = pos.y - math.abs(xv)
                    elseif mvU then
                        pos.y = pos.y + math.abs(xv)
                    else
                        return
                    end
                else
                    return
                end
            else
                return
            end
        end
        pos.z = pos.y --逻辑位置和渲染位置相同
        self.actor:setPosition(pos.x,pos.z)
        -- if moveSpeed >= 0 then
        --     if xv < 0 then
        --         self:setDir(eDir.LEFT)
        --     elseif xv > 0 then
        --         self:setDir(eDir.RIGHT)
        --     end
        -- else
        --     if xv < 0 then
        --         self:setDir(eDir.RIGHT)
        --     elseif xv > 0 then
        --         self:setDir(eDir.LEFT)
        --     end
        -- end
        -- self:actor:playMove()
        -- EventTrigger:_onChangePos(self)
    end
end
--是否可以被牵引
function Hero:canTraction()
    if self:isAState(eAState.E_QIANYIN_MY) then
        return false
    end
    return not self.data.immunePull
end
--牵引处理 (碰撞处理)
function Hero:traction(xv,yv)
    if not self:canTraction() then
        return
    end
    local pos  = self.position3D
    local nx   = pos.x + xv
    local ny   = pos.y + yv
    local nz   = pos.z + yv
    if battleController.canMove(nx ,ny) then
        pos.x  = nx
        pos.y  = ny
        pos.z  = nz
    elseif battleController.canMove(nx,pos.y) then
        pos.x = nx

    elseif battleController.canMove(pos.x , ny) then
        pos.y = ny
        pos.z = nz
    end
    pos.z = math.max(pos.z,pos.y)
    if self.actor then
        self.actor:setPosition(pos.x,pos.z)
    end
end


--手动移动切换到站立状态
function Hero:moveToStand()
    -- print("moveToStand self:getState() ",self:getState() )
    if self:getState() == eState.ST_MOVEEX then
        self:doEvent(eStateEvent.BH_STAND)
    end
end

--设置移动数据
function Hero:setSpeedScale(speedScale)
    local rets = false
    if self.nSpeedScale ~= speedScale then
        self.nSpeedScale = speedScale
        rets = true
    end
    local state = self:getState()
    if state == eState.ST_MOVEEX and rets then
        self.actor:playMove()
    end
end

function Hero:getUnsignedMoveSpeed()
    return math.abs(self:getMoveSpeed())
end

function Hero:getMoveSpeed()
    if self:isAState(eAState.E_STOP_MOVE) then
        return 0
    end
    return self.property:getValue(eAttrType.ATTR_MOVE_SPEED) * self.nSpeedScale
end

function Hero:getRealMoveSpeed()

    return self.property:getValue(eAttrType.ATTR_MOVE_SPEED)
end

--动作位移速度
function Hero:getActionMoveSpeed(time)
    if self.skill then
        return self.skill:getMoveSpeed()
    end
    return 0
end
--手动控制下移动处理
function Hero:handlMove(time)
    if self:canMove() then
        local state     = self:getState()
        local moveSpeed = 0
        if state == eState.ST_SKILL then
            moveSpeed = self:getActionMoveSpeed()
        else
            moveSpeed = self:getUnsignedMoveSpeed()
        end
        moveSpeed  = moveSpeed*time/1000
        local vector = self:getRokeVector()
        local xv = moveSpeed * vector.x
        local yv = moveSpeed * vector.y *  BattleConfig.YV_ATTENUATION_RATIO

        if vector.x ~= 0 or vector.y ~= 0 then
            if xv~=0 or yv ~=0 then
                self:move(xv,yv,true)
            end
            
            local flag = xv* self:getMoveSpeed()
            if self.skill then
                local skillCfg = self.skill.skillCfg
                local skillActionCfg = BattleDataMgr:getActionData(skillCfg.first, self:getAngleDatas())
                if skillActionCfg.moveType and skillActionCfg.moveType == 5 then
                    
                else
                    if  flag > 0 then 
                        self:setDir(eDir.RIGHT)
                    elseif flag < 0 then
                        self:setDir(eDir.LEFT)
                    end 
                end
            else
                if  flag > 0 then 
                    self:setDir(eDir.RIGHT)
                elseif flag < 0 then
                    self:setDir(eDir.LEFT)
                end 
            end

            if state ~= eState.ST_SKILL and state ~= eState.ST_MOVEEX then
                self:doEvent(eStateEvent.BH_MOVEEX)
            end
        else
            if state ~= eState.ST_SKILL then
                self:moveToStand()
            end
        end
    end
end

function Hero:getCollisionWithName(bdbox)
    if self.actor then
        return self.actor:getCollisionWithName(bdbox)
    end
    return {}
end

function Hero:getBoundingBox(bdbox)
    if self.actor then
        return self.actor:getBoundingBox(bdbox)
    end
    return me.rect(0,0,0,0)
end

--
--

function Hero:setPosition3D(x , y , z)
    if x then
        self.position3D.x = x
    end
    if y then
        self.position3D.y = y
    end
    if z then
        self.position3D.z = z
    end
    --刷新模型位置
    if self.actor then
        self.actor:setPosition(self.position3D.x,self.position3D.z)
    end
end

function Hero:setPositionX(x)
    self.position3D.x = x
    if self.actor then
        self.actor:setPosition(self.position3D.x,self.position3D.z)
    end
end

function Hero:setPositionY(y)
    self.position3D.y = y
    if self.actor then
        self.actor:setPosition(self.position3D.x,self.position3D.z)
    end
end

function Hero:setPositionZ(z)
    self.position3D.z = z
    if self.actor then
        self.actor:setPosition(self.position3D.x,self.position3D.z)
    end
end

function Hero:getPosition3D()
    return self.position3D
end

function Hero:getPositionX()
    return self.position3D.x
end

function Hero:getPositionY()
    return self.position3D.y
end

function Hero:getPositionZ()
    return self.position3D.z
end


function Hero:getPosition()
    return self.position3D
end

function Hero:getWorldPosition3D()
    return self.position3D
end

--获取上一帧的位置
function Hero:getLastPosition()
    return self.lastPsition3D
end

function Hero:setLastPosition(x,y,z)
    self.lastPsition3D.x = x
    self.lastPsition3D.y = y
    self.lastPsition3D.z = z
end

function Hero:addEffect(effectNode,zorder)
    if self.actor then
        self.actor:addEffect(effectNode,zorder)
        -- effectNode:setDir(self:getDir())
    end
end

function Hero:addEffectToList(effectNode)
    table.insert(self.effetList, effectNode)
end

function Hero:removeAllEffect()
    for key , effectNode in ipairs(self.effetList) do
        if not tolua.isnull(effectNode) then
            effectNode:preRemove(true)
            --effectNode:removeFromParent()
        else
            printError("remove not exsit skilleffect")
        end
    end
    self.effetList = {}
end

function Hero:removeEffect(effectNode)
    table.removeItem(self.effetList,effectNode)
end

--动画帧事件
function Hero:onArmtureEvent(event)
    -- print(event)
    if event.name == eArmtureEvent.MUSIC then  --音效触发
        self:handleMusicEvent(event.pramN)
        return
    elseif event.name == eArmtureEvent.EFFECT then  --特效触发
        self:handleEffectEvent(event.pramN)
    elseif event.name == eArmtureEvent.STIFF then
        self:handleStiffEvent(event.pramN)
        return
    end
    if self.skill then
        self.skill:onEvent(event)
    end
end
function Hero:handleStiffEvent(pramN)
    local hurtStiff = self:getValue(eAttrType.ATTR_NOW_HURT_STIFF)
    if pramN == 1 then --触发僵直
        if hurtStiff ~= 0 then
            --hurtStiff 是万分比需要乘以0.0001
            local timeScale = self:getActionTimeScale()
            timeScale = timeScale *(1 + hurtStiff*0.0001)
            self:setActionTimeScale(timeScale)
        end
    elseif pramN == 2 then --僵直恢复
        self:setActionTimeScale(1)
    end
end


function Hero:handleEffectEvent(pramN)
    -- printError("AAAAAA")
    -- _print("xxxx",self:getName(),self:getActor().animation,"handlEffectEvent:",pramN ,self.roleAction)
    if self.roleAction then
        if self.roleAction.triggerEvent == "effect"..pramN then
            local effectPoint = self.roleAction.effectPoint
            local resourceUp  = self.roleAction.resourceUp
            local motionUp    = self.roleAction.motionUp
            local resourceDown= self.roleAction.resourceDown
            local motionDown  = self.roleAction.motionDown
            local effectScaleUp = self.roleAction.effectScaleUp*self:getSkeletonNodeScale()
            local effectScaleDown = self.roleAction.effectScaleDown*self:getSkeletonNodeScale()

            local pos = self:getRelativeBonePosition(effectPoint)
            for index , resource in ipairs(resourceUp) do
                local animation    = motionUp[index]
                local skeletonNode = self.actor:playEffect(resource , nil , animation)
                skeletonNode:setScale(effectScaleUp)
                __setSkeletonNodeDir(skeletonNode,self:getDir())
                skeletonNode:setPosition(pos)
                skeletonNode:setZOrder(3)


            end
            for index , resource in ipairs(resourceDown) do
                local animation    = motionDown[index]
                local skeletonNode = self.actor:playEffect(resource , nil , animation)
                skeletonNode:setScale(effectScaleDown)
                __setSkeletonNodeDir(skeletonNode,self:getDir())
                skeletonNode:setPosition(pos)
                skeletonNode:setZOrder(-1)
            end

        end
    end
                -- Box("B欧方阿斯蒂芬")
end
--1语音类型 2事件类型 互相排斥
function Hero:checkMusicMutex(mutexType)
   for k , _mutexType in pairs(self.effectMutexList) do
        -- if _mutexType == mutexType then
            return true
        -- end
   end
end

function Hero:clearMusicMutex()
    self.effectMutexList = {}
end

function Hero:setMusicMutex(handle,value)
    if handle and handle > 0 then 
        self.effectMutexList[handle] = value
    end
end

function Hero:handleMusicEvent(pramN)
    local eventName  = eArmtureEvent.MUSIC..pramN
    local resource   = self.data.model
    if self.curForm then 
        resource   = self.curForm:getData().model  
    end 
    local action     = self.actor:getFixAnimation()
    local musicDatas = BattleDataMgr:getActorMusicDatas(resource,action,eventName)
    if musicDatas then
        for i, musicData in ipairs(musicDatas) do
            if musicData.musicType == 1 then
                if not self:checkMusicMutex(2) then
                    local handle = BattleUtils.playEffect(musicData.resource,false,musicData.volume*0.01)
                    if handle then
                        self:setMusicMutex(handle,1)  --语音类型标识
                        TFAudio.setFinishCallback(handle, function(...)
                            self:setMusicMutex(handle,nil)
                        end)
                        if musicData.stopJudge == 1 then
                            self:addSoundEffect(handle)
                        end
                    end
                end
            else
                --音效直接播放
                local handle = BattleUtils.playEffect(musicData.resource,false,musicData.volume*0.01)
                if musicData.stopJudge == 1 then
                    self:addSoundEffect(handle)
                end
            end
        end
    end
end

function Hero:getSkill(keyCode)
    local skillList = self:getSkillList()
    for i, skill in ipairs(skillList) do
        if skill:getKeyCode() == keyCode and skill:isVisiable() then
            return skill
        end
    end
end

function Hero:getGatherValue()
    if self.skill then
        return self.skill:getGatherValue()
    end
    return 0
end

--根据技能类型查找技能(可能有多个相同类型的技能优先查找 keyEvent==auto )
function Hero:getSkillByType(skillType)
    local tempSkill
    local skillList = self:getSkillList()
    for i, skill in ipairs(skillList) do
        if skill.data.skillType == skillType then
            if skill.data.keyEvent == "auto" then
                return skill
            end
            tempSkill = skill
        end
    end
    if tempSkill then
        return tempSkill
    end
end
--根据技能类型获取所有技能
function Hero:getSkillsByType(skillType)
    local skills = {}
    local skillList = self:getSkillList()
    for i, skill in ipairs(skillList) do
        if skill.data.skillType == skillType or skillType == 0 then
            table.insert(skills,skill)
        end
    end
    return skills
end



function Hero:getSkillByCid(cid)
    local skill
    local skillList = self:getSkillList()
    for i, v in ipairs(skillList) do
        if v.data.id == cid then
            skill = v
            break
        end
    end
    return skill
end

function Hero:castById(id)
    local skill = self:getSkillByCid(id)
    self:castSK(skill,true)
end

function Hero:castSK(skill,force,skillSubId)
    if self:canCast(skill) then
        skill:tryCast(force,skillSubId)
        return true
    else
        self.willUseSkill = self.skill
       -- _print(self:getName().."技能无法释放")
        return false
    end
end

function Hero:cast(keyCode,skillSubId)
    local skill = self:getSkill(keyCode)
    if skill and skill:isEnable() and skill ~= self.skill then
        -- print("cast keyCode:",keyCode)
        return self:castSK(skill,false,skillSubId)
    end
    if not skill then
        --_print(""..self:getName().."没有skill "..tostring(keyCode))
    end
    return false
end

function Hero:castByType(skillType)
    local skill = self:getSkillByType(skillType)
    if skill and skill:isEnable() and skill ~= self.skill then
        -- print("cast keyCode:",keyCode)
        return self:castSK(skill,true)
    end
    if not skill then
        --_print(""..self:getName().."没有skill "..tostring(keyCode))
    end
    return false
end

--有按键输入
function Hero:onKeyEvent(keyCode,skillSubId)
    --TODO 处理的不科学
    if battleController.isClearing then --战斗结束 不再处理案件响应
        return
    end
    local skill = self:getSkill(keyCode)
    if skill then
        if self.skill then
            if self.skill:getKeyCode() ~= keyCode and skill:checkLevel(self.skill:getLevel())  then
                return self:cast(keyCode,skillSubId)
            end
        else
            return self:cast(keyCode,skillSubId)
        end
    end
end

--检查是否是有效输入
function Hero:isValidKey(keyCode)
    for k , v in pairs(skill_type_disable_cd) do
        if v == keyCode then
            if self:isAState(k) then
                return false
            end 
        end
    end

    for k , v in pairs(skill_type_disable) do
        if v == keyCode then
            if self:isAState(k) then
                return false
            end 
        end
    end
    return true
end
--每次状态切换时检查输入状态更新朝向
function Hero:checkManualDir()
    if self:isManual() then
        local vector = self:getRokeVector()
        if vector.x  > 0 then
            self:setDir(eDir.RIGHT)
        elseif vector.x < 0 then
            self:setDir(eDir.LEFT)
        end
    end
end

--检查是否进入攻击范围
function Hero:isAtkRange(target)
    local targetPos  = target:getPosition3D()
    local pos        = self:getPosition3D()
    if math.abs(targetPos.x - pos.x) > self.limitArea then  --TODO 暂时屏蔽最短距离限制
        local origin = self.atkRect.origin
        local size   = self.atkRect.size
        local rect   = me.rect(origin.x,origin.y,size.width,size.height)  ---self.atkRect
        rect.origin = me.pAdd(pos,rect.origin)
        return me.rectContainsPoint(rect,targetPos)
    end
    return false
end


function Hero:caluTarget(targetPos,pos)
    -- local targetY = tragetPos.y
    -- local targetX = tragetPos.x
    -- local minY = pos.y + self.atkRect.origin.y
    -- local maxY = minY + self.atkRect.size.height
    -- targetY = math.min(targetY,maxY)
    -- targetY = math.max(targetY,minY)
    -- --朝右
    -- local minX = pos.x + self.atkRect.origin.x
    -- local maxX = minX  + self.atkRect.size.width
    -- --朝右
    -- targetX = math.min(targetX,maxX)
    -- targetX = math.max(targetX,minX)
    -- return me.p(targetX,targetY)
    local rect = battleController.getAirwall()
    local tmpPosX = targetPos.x
    if tmpPosX < pos.x then
        targetPos.x = tmpPosX + self.limitArea + 2
        if targetPos.x > rect.origin.x + rect.size.width - BattleConfig.SPACE_AIRWALL then
            targetPos.x = tmpPosX - self.limitArea - 2
        end
    else
        targetPos.x = tmpPosX - self.limitArea - 2
        if targetPos.x < rect.origin.x + BattleConfig.SPACE_AIRWALL then
            targetPos.x = tmpPosX + self.limitArea + 2
        end
    end
    return targetPos
end
--TODO 自动寻敌 还需要优化
local function fixValue(value)
    if math.abs(value) < 0.001 then
        return 0
    end
    return value
end

local function __fixPoint(point)
    -- point.x = math.floor(point.x*1000)*0.001
    -- point.y = math.floor(point.y*1000)*0.001
    return point
end

--根据寻路路径移动
function Hero:pathMove(time)
    local speed = self:getUnsignedMoveSpeed()
    local targetPos = self.pathList[1]
    local pos       = self:getPosition3D()
    local distance  = me.pGetDistance(targetPos,pos)
    local sub       = __fixPoint(me.pSub(targetPos,pos))
    local _time     = distance/speed
    if _time ~= 0 then
        local xv    = sub.x/_time*time*0.001
        local yv    = sub.y/_time*time*0.001
        -- _print("xv:",xv ,"yv:",yv,"sub.x:",sub.x,"sub.y:",sub.y ,"_time",_time)
        if math.abs(sub.x) < math.abs(xv) then
            xv = sub.x
        end
        if math.abs(sub.y) < math.abs(yv) then

            yv = sub.y
        end
        if xv ~= 0 or yv ~= 0 then 
            self:move(xv,yv)
        end

        local flag = xv* self:getMoveSpeed()
        if self.skill then
            local skillCfg = self.skill.skillCfg
            local skillActionCfg = BattleDataMgr:getActionData(skillCfg.first, self:getAngleDatas())
            if skillActionCfg.moveType and skillActionCfg.moveType == 5 then
            else
                if  flag > 0 then 
                    self:setDir(eDir.RIGHT)
                elseif flag < 0 then
                    self:setDir(eDir.LEFT)
                end 
            end
        else
            if  flag > 0 then 
                self:setDir(eDir.RIGHT)
            elseif flag < 0 then
                self:setDir(eDir.LEFT)
            end 
        end
       

        pos       = self:getPosition3D()
        distance  = me.pGetDistance(targetPos,pos)
        if distance < 1 then
            table.remove(self.pathList,1)
            self:setPosition3D(targetPos.x,targetPos.y)
        end
    else
        table.remove(self.pathList,1)
        self:setPosition3D(targetPos.x,targetPos.y)
    end
end
function Hero:autoMove(time)
    if self:isAState(eAState.E_STOP_MOVE) or self:isAState(eAState.E_STATE_84) then
        self.pathList= {}
    end

    if self.moveState == eMoveState.Target or self.moveState == eMoveState.Patrol then
        if #self.pathList > 0 then
            self:pathMove(time)
        else
            if self:isFlag(eFlag.PlotMode) then
                self:moveToStand()
                --剧情模式移动完成回调
                if self.plotMoveEndCallFunc then
                    self.plotMoveEndCallFunc()
                    self.plotMoveEndCallFunc = nil
                end
                self:clearFlag(eFlag.PlotMode)
            else
                self:moveToStand()
                if self.moveState == eMoveState.Patrol then
                    self.aiAgent:next()
                    local captain = battleController.getCaptain()
                        if captain then 
                        local captainPos = captain:getPosition3D()
                        local selfPos = self:getPosition3D()
                        local x = selfPos.x - captainPos.x
                        local dir = eDir.RIGHT
                        if x > 0 then
                            dir = eDir.LEFT
                        end
                        if dir ~= self:getDir() then
                            self:setDir(dir)
                        end
                    end
                end
            end
        end
    elseif self.moveState == eMoveState.Fallow then
        self.pathCheckTiming = self.pathCheckTiming + time
        local target
        if self.fixTarget then
            target = self.fixTarget
        else
            target = self.nearTarget
        end
        if target and target:isAlive() then
            if self:isAtkRange(target)  then
                -- 寻路结束 -> 使用技能
                self.pathTiming = 0
                self.nearTarget = nil
                self.fixTarget = nil
                self.pathList = {}
                -- print("move ok")
                self:moveToStand()
                self.aiAgent:next()
            else
                if self.pathCheckTiming >= self.pathCeckInterval then
                    self.pathCheckTiming = 0
                    self.pathList = {}
                end
                -- _print("#self.pathList size",#self.pathList)
                if #self.pathList > 0 then
                    self:pathMove(time)
                else
                    local blockSize = levelParse:getBlockSize()
                    local targetPos = target:getPosition3D()
                    local myPos = self:getPosition3D()
                    local moveRect = battleController.getMoveRect()
                    local moveRecvMaxY = moveRect.origin.y + moveRect.size.height
                    local minY = math.max(targetPos.y - self.atkRect.size.height, moveRect.origin.y) + blockSize
                    local maxY = math.min(targetPos.y + self.atkRect.size.height, moveRecvMaxY) - blockSize
                    local findPos = ccp(targetPos.x, targetPos.y)
                    -- findPos.y = RandomGenerator.random(minY, maxY)
                    local rightX = targetPos.x - self.limitArea - blockSize
                    local leftX = targetPos.x + self.limitArea + blockSize
                    if targetPos.x - myPos.x > 0 then
                        findPos.x = rightX
                        if not levelParse:canMove(findPos.x, findPos.y) then
                            findPos.x = leftX
                        end
                    else
                        findPos.x = leftX
                        if not levelParse:canMove(findPos.x, findPos.y) then
                            findPos.x = rightX
                        end
                    end
                    if levelParse:canMove(findPos.x, findPos.y) then
                        self:findPath(findPos)
                    end
                end
            end
        else
            self.nearTarget = nil
            self.fixTarget = nil
            self:endToAI()
        end
    elseif self.moveState == eMoveState.FixedMove then
        if #self.pathList > 0 then
            self:pathMove(time)
        else
            self:moveToStand()
            self.aiAgent:next()
        end
    end
end

--数据道具
function Hero:onPickUp(prop)
    local data = prop:getData()
    --拾取道具
    EventMgr:dispatchEvent(eEvent.EVENT_PICKUP, data)
    self:onEventTrigger(eBFState.E_PICKUP_ITEM)
    local scale = BattleConfig.MODAL_SCALE*self:getSkeletonNodeScale()
    self.actor:playEffect(data.getResource,scale,data.getAction)
-- 1：调用buff
-- 2：增加角色百分比生命(最大生命的)
-- 3：增加角色能量值
    for index , _type in ipairs(data.type) do
        local param = data.typeData[index]
        if _type == 1 then --buff 类型
            local buffer = Buffer.create(param,self)
            buffer:onTalentTrigger(self) --天赋触发
        elseif _type == 2 then
            local value = self.property:getValue(eAttrType.ATTR_MAX_HP)*param*0.0001
            self:changeHp(value)
        elseif _type == 3 then
            self:changeAnger(param)
        end
    end

end

function Hero:calOffsetPosition(offsetX, offsetY)
    local pos = self:getPosition3D()
    local dir = self:getDir()
    if dir == eDir.LEFT then
        pos.x = pos.x - offsetX
    else
        pos.x = pos.x + offsetX
    end
    pos.y = pos.y + offsetY
    return pos
end

--播放受击音效
function Hero:playHitMusic(id)
    if id ~= 0 then
        local corporeity = self.data.corporeity or 1
        if corporeity ~= 0 then
            local data   = TabDataMgr:getData("HitMusic",id)
            if not data then
                Box(string.format("HitMusic id =%s not found",id))
            end
            local volume   = data["volume"..corporeity]
            local resource = data["resource"..corporeity]
            -- Box("id:"..id.." corporeity:"..corporeity.." volume:"..tostring(volume).." resource:"..tostring(resource))
            BattleUtils.playEffect(resource,false,volume*0.01)
        end
    end
end

-- 练习模式无尽能量
function Hero:setPracticeInfinite(enabled)
    if enabled then
        --所有能量恢复满
        self:setValue(eAttrType.ATTR_NOW_ENERGY,self:getValue(eAttrType.ATTR_MAX_ENERGY))
        self:setValue(eAttrType.ATTR_NOW_AGR,self:getValue(eAttrType.ATTR_MAX_AGR))
        self:setValue(eAttrType.ATTR_DESPAIR,self:getValue(eAttrType.ATTR_MAX_DESPAIR))
        self:onAttrTrigger(eAttrType.ATTR_NOW_ENERGY,0)
        self:onAttrTrigger(eAttrType.ATTR_NOW_AGR,0)
        self:onAttrTrigger(eAttrType.ATTR_DESPAIR,0)
        self:setFlag(eFlag.SUPER_SKILL)
        --强制清理当前CD
        local skillList = self:getSkillList()
        for i, v in ipairs(skillList) do
            v:clearCD()
        end
        EventMgr:dispatchEvent(eEvent.EVENT_HERO_ATTR_CHANGE,self)
    else
        self:clearFlag(eFlag.SUPER_SKILL)
    end

end

-------------行为树-----------

function Hero:setAIEnable(isEnable)
    self.isAIEnable = isAIEnable
    if not self.isAIEnable then --禁用AI时 如果在寻路状态切换到待机
        if self:getState() == eState.ST_MOVEEX then
            self.pathList = {}
            self:moveToStand()
        end
    end
end

function Hero:ai(dt)
    self.aiUseSkillTime = self.aiUseSkillTime + dt
    if self:getState() == eState.ST_BORN then 
        return
    end
    if self:isAState(eAState.E_JING_ZHI) or self:isAState(eAState.E_DONG_JIE) or self:isAState(eAState.E_STATE_84) then
        return
    end
    if EventTrigger:isRunning() then
        return
    end

    if self.isAIEnable == false then
        return
    end

    self.AIStepCD = self.AIStepCD + dt
    if self.AIStepCD > 0.1 then
        self.AIStepCD = 0
        local data = table.remove(self.AIStepDatas,1)
        if data then
            self.AIStepParams = data[3]
            self.aiAgent:executeAIStepData(data)
        end
    end

    if self.bFight and self.aiAgent then
        self.aiAgent:update(dt, self)
    end
end

function Hero:_checkState(...)
    local states = {...}
    local state = self:getState()
    for i, v in ipairs(states) do
        if v == state then
            return true
        end
    end
    return false
end

--能否连击
function Hero:canNextAttack()
    return BattleUtils.triggerTest10000(self.data.attackData)
end

function Hero:checkAIDir()
    local hero = self:findTarget()
    if hero then
        self:updateDirWithTarget(hero)
    end
end



local VaildSites = {{1,2,4},{2,1,3},{3,2,4},{4,1,3}}

-- 随机巡逻位置（方式1）
function Hero:randomPos(site)
    local xxx = {{-1,-1},{-1,1},{1,1},{1,-1}}
    local max = self.data.patrolFar
    local min = self.data.patrolNear
    return me.p(xxx[site][1]*RandomGenerator.random(min,max) ,xxx[site][2]*RandomGenerator.random(min,max))
end

-- 获取巡逻区域（方式2）
function Hero:getPatrolRect(targetPos, myPos)
    local tpos = clone(targetPos)
    local mpos = clone(myPos)
    local moveRect = battleController:getMoveRect()
    local moveRectMaxX = moveRect.origin.x + moveRect.size.width
    local moveRectMaxY = moveRect.origin.y + moveRect.size.height
    tpos.x = math.min(tpos.x, moveRectMaxX)
    mpos.x = math.min(mpos.x, moveRectMaxX)
    tpos.y = math.min(tpos.y,moveRectMaxY)
    tpos.y = math.max(tpos.y,0)
    mpos.y = math.min(mpos.y,moveRectMaxY)
    mpos.y = math.max(mpos.y,0)
    local site = self:checksite(tpos, mpos)
    local min = self.data.patrolNear
    local max = self.data.patrolFar
    local x = RandomGenerator.random(min, max)
    local y = RandomGenerator.random(min, max)
    
    if site == 1 or site == 2 then
        if math.abs(tpos.x - moveRect.origin.x) <= x / 2 then
            site = 3
        end
    else
        
        if math.abs(moveRectMaxX - tpos.x) <= x / 2 then
            site = 1
        end
    end

    local rect = {}
    if site == 1 or site == 2 then
        rect = me.rect(tpos.x - x, tpos.y - y, x, y * 2)
    else
        rect = me.rect(tpos.x, tpos.y - y, x, y * 2)
    end
    return rect
end

function Hero:checksite(pos1,pos2 )
    local sub = me.pSub(pos2,pos1)
    if sub.x <= 0 then
        if sub.y <= 0 then
            return 1
        else
            return 2
        end
    else
        if sub.y <= 0 then
            return 4
        else
            return 3
        end
    end
end


--最近一次造成伤害的值
function Hero:setHurtValue(value)
    value = math.abs(value)
    -- print("setHurtValue ",value)
    self.property:setValue(eAttrType.ATTR_HURT,value)
    EventMgr:dispatchEvent(eEvent.EVENT_HIT, self,value)
end
--最近一次被造成伤害的值
function Hero:setRevHurtValue(value)
    value = math.abs(value)
    -- print("setRevHurtValue ",value)
    self.property:setValue(eAttrType.ATTR_REV_HURT,value)
    EventMgr:dispatchEvent(eEvent.EVENT_GETHIT, self)
end

--buffer 触发条件检测
function Hero:onTalentTrigger()
    bufferMgr:walk(function(buffer)
        buffer:onTalentTrigger(self)
    end)

end

--状态触发
function Hero:onStateTrigger(state)
    bufferMgr:walk(function(buffer)
        buffer:onStateTrigger(self , state)
    end)
end

--
function Hero:onEventTrigger(event,target,param)
    if not event then
        printError("hero onEventTrigger event is nil")
        Box("hero onEventTrigger event is nil")
    end
    -- print(string.format("onEventTrigger(%s,%s,%s)",self.data.name , event,param))
    -- 这段代码为战斗数据统计服务
    if event == eBFState.E_JI_SHA then
        --检查是不是使用入场技能击杀
        if self.skill then
            if self.skill:getSKillType() == eSkillType.ENTER then
                EventMgr:dispatchEvent(eEvent.EVENT_SKILL_ENTER_KILL,self)
            elseif self.skill:getSKillType() == eSkillType.AWAKE then 
                EventMgr:dispatchEvent(eEvent.EVENT_SKILL_AWAKE_KILL,self)
            end
        end
    elseif event == eBFState.E_HITED then
        -- print_("-------------命中--------------")
        --记录命中
        self:setFlag(eFlag.HITED)
    end
    
    if self.skill then
        self.skill:onEventTrigger(self,event,target,param)
    end

    self:doBuffEvent(event,target,param)
end

function Hero:doBuffEvent(event,target,param)
    bufferMgr:walk(function(buffer)
        buffer:onEventTrigger(self,event,target,param)
    end)
    self:walkBufferEffectWalk(function (effect)
        effect:onEventTrigger(self,event,target,param)
    end)

    --能量获取和消耗
    if self.energyMgr then
        self.energyMgr:onEvent(event)
    end
    if self.superArmorMgr then
        self.superArmorMgr:onEvent(event)
    end


    --todo  添加技能检测事件触发机制
    

end
-- 属性变更
function Hero:onAttrTrigger(attrType,value, event)
    if attrType == eAttrType.ATTR_NOW_HP then
        --自动恢复
        if self:isFlag(eFlag.HP_AUTO_RECOVERY) then
            if self:getHp() < 1 then
                self.property:setValue(eAttrType.ATTR_NOW_HP,self:getMaxHp())
            end
        end
    end
    if event and event > 0 then
        self:onEventTrigger(event,self)
    end


    if not self.attrTypeList then
        printError("aaa")
        Box("self.attrTypeList is nil")
    end


    if not attrType then
        Box("attrType is nil")
    end

    table.uniqueAdd(self.attrTypeList, attrType)

end
-- 属性变更
function Hero:doAttrTrigger()
    -- TFTime:b()
    local _attrTypeList = self.attrTypeList
    self.attrTypeList = {}
    if #_attrTypeList > 0 then
        bufferMgr:walk(function(buffer)
            for i, attrType in ipairs(_attrTypeList) do
                buffer:onAttrTrigger(self,attrType,0)
            end
        end)
        self:walkBufferEffectWalk(function(effect)
            for i, attrType in ipairs(_attrTypeList) do
                effect:onAttrTrigger(self,attrType,0)
            end
        end)
        for i, attrType in ipairs(_attrTypeList) do
            if attrType == eAttrType.ATTR_NOW_HP
            or attrType == eAttrType.ATTR_NOW_AGR
            or attrType == eAttrType.ATTR_NOW_SLD
            or attrType == eAttrType.ATTR_NOW_RST
            or attrType == eAttrType.ATTR_DESPAIR
            or attrType == eAttrType.ATTR_NOW_ENERGY
            or attrType == eAttrType.ATTR_SUPER_ENERGY 
            or attrType == eAttrType.ATTR_SUPER_ENERGY_LEVEL then
                EventMgr:dispatchEvent(eEvent.EVENT_HERO_ATTR_CHANGE,self)
                if self.superArmorMgr then
                    self.superArmorMgr:onAttrChange(attrType)
                end
                break
            end
        end
    end
    -- TFTime:e(self:getName().."[doAttrTrigger]")
end

function Hero:onSkillTrigger(event,buffId,target)
    print(string.format("onSkillTrigger(%s,%s)",event,buffId))
    bufferMgr:walk(function(buffer)
        buffer:onSkillTrigger(self,event,buffId,target)
    end)
end

--使用卡牌
function Hero:useCard(buffIds)
    for i,buffId in ipairs(buffIds) do
        print_(string.format("useCard(%s)",buffId))
    end
    bufferMgr:walk(function(buffer)
        for i,buffId in ipairs(buffIds) do
             buffer:onUseCardTrigger(self,buffId)
        end
    end)
end

--状态被移除时触发(目前只支持冻结)
function Hero:onStateRemoveTrigger(state)
    if not self:isAState(state) then -- 保证全部被移除的情况下才触发
        self:walkBufferEffectWalk(function( effect )
                effect:onStateRemoveTrigger(self,state)
            end)
    end
end

--技能特效删除
function Hero:onSkillEffectRemove(effectNode)
    self:walkBufferEffectWalk(function( effect )
        effect:onSkillEffectRemove(effectNode)
    end)
end

function Hero:walkBufferEffectWalk(callfunc)
    for index = #self.bufferEffectMap , 1 ,-1 do
        local effect = self.bufferEffectMap[index]
        if effect then
            callfunc(effect)
        end
    end
end
--------------------队长切换和队友助战--------------------------
--加入到战斗
function Hero:addToBattle()
    --添加到战斗场景
    --这个要确定位置
    if self.actor then
        self.actor:reset()
    end
    self:clearMusicMutex()
    EventMgr:dispatchEvent(eEvent.EVENT_ACTOR_ADD_TO_LAYER,self)
    self:setBattle(true)--设置为出战状态
end

--从战斗里移除
function Hero:removeFrormBattle()
    if self.actor then
        self.actor:removeFromParent_()
    end
    --设置为非出战状态
    self:setBattle(false)
end

--设置队员是否出战
function Hero:setBattle(battleState)
    self.bBattle = battleState
end

--活着并且出战
function Hero:isActive()
    return self.bBattle and self:isAlive()
end

--是否出战
function Hero:isBattle()
    return self.bBattle
end

--设置为控制角色
function Hero:setControl(tarPos)
    if battleController.isClearing then
        --战斗结束,拒绝换人操作
        return
    end
    local hero  = battleController.getCaptain()
    local vPosition
    local dir
    local vector
    if hero then
        hero:forceClearAState_(eAState.E_DONG_JIE)
        hero:forceClearAState_(eAState.E_XUAN_YUN)
        hero:forceClearAState_(eAState.E_PARALYSIS)
        hero:forceClearAState_(eAState.E_JING_ZHI)
        hero:forceClearAState_(eAState.E_STATE_84)
        hero:forceClearAState_(eAState.E_STOP_MOVE)
        local state = hero:getState()  --原角色处于进场和离场状态 不切换
        if state == eState.ST_DEPARTURE then
            return
        end
        hero:clearMusicMutex()
        vPosition = hero:getPosition3D()
        dir = hero:getDir()
        vector = hero:getRokeVector()
        if hero:isDead() then
            if hero:getState() == eState.ST_RELIVE then --正在复活
                hero:forceRelive()
                --强制回血
                hero.countDown:start()
                battleController.setSwitchCaptainGlobalCD()
                hero:doEvent(eStateEvent.BH_DEPARTURE)
            elseif  hero:isAState(eAState.E_RELIVE) then
                self:clearAState(eAState.E_RELIVE)
                hero:forceRelive()
                --强制回血
                hero.countDown:start()
                battleController.setSwitchCaptainGlobalCD()
                hero:doEvent(eStateEvent.BH_DEPARTURE)
            end
        else
            -- hero:cancelToStand()
            -- hero:removeFrormBattle()
            hero.countDown:start()
            battleController.setSwitchCaptainGlobalCD()
            hero:doEvent(eStateEvent.BH_DEPARTURE)
            -- hero:setBattle(false)

        end

    end
    self:addToBattle()
    if not tarPos then
        tarPos = vPosition
    end
    --目标位置置地面
    if tarPos then
        self:setPosition3D(tarPos.x,tarPos.y,tarPos.y)
    end


    self.operate:clear()
    if vector then
        self:setRokeVector(vector.x,vector.y)
    end
    if dir then
        self:setDir(dir)
    end

    self.actor:show()
    self.actor:setOpacity(255)
    self.actor.skeletonNode:show()
    self:skillReset()
    battleController.setCaptain(self)
    --直接
    self:castByType(eSkillType.ENTER)
    --出场技入场
    self:onEventTrigger(eBFState.E_HERO_ENTER,self)


    --通知Buffer图标重置 (自己刚切换为队长 自己必然为队长)
    EventMgr:dispatchEvent(eEvent.EVENT_BUFFER_EFFECT_ICON,self,eBufferEffectIconEvent.RELOAD)
end

--检查播放胜利动作
function Hero:checkAndPlayEndAction()
    --战斗结束了
    if battleController.isClearing then
        if not self:isFlag(eFlag.EndOfBattle) then
            if self:getCampType() == eCampType.Hero then
                if self:isAlive() then
                    local state    = self:getState()
                    local roleType = self:getData().roleType
                    if roleType == eRoleType.Hero or roleType == eRoleType.Team then
                        if battleController.isWin() then
                            if state ~= eState.ST_DEPARTURE then --离场动画
                                if not self:isInAir() then --获胜动作
                                    self:stopAllActions()
                                    self:doEvent(eStateEvent.BH_WIN)
                                    self:setFlag(eFlag.EndOfBattle)
                                end
                            else
                                self:setFlag(eFlag.EndOfBattle)
                            end
                        end
                    elseif roleType == eRoleType.Assist then
                        if state ~= eState.ST_DEPARTURE then --离场动画
                            self:doEvent(eStateEvent.BH_DEPARTURE)
                        end
                        self:setFlag(eFlag.EndOfBattle)
                    end
                end
            end
        end
    end
end

--是否播放完结束动作
function Hero:isPlayedEndAction()
    --怪和死亡的队伍直接返回 True
    if self:getCampType() == eCampType.Monster then
        return true
    end
    if self:isDead() then
        return true
    end
    if not self:isBattle() then
        return true
    end
    return self:isFlag(eFlag.PlayedEndAction)
end

function Hero:playMoveEffect()
    if self:isManual(true) then
        if not self.isPlayMoveEffect then
            if self.curForm then
                local moveType = self.curForm.data.moveType
                if moveType == 0 then
                    self.isPlayMoveEffect = BattleUtils.playEffect(BattleConfig.MOVE_EFFECT , true)
                elseif moveType == 1 then
                    self.isPlayMoveEffect = BattleUtils.playEffect(BattleConfig.FLY_EFFECT , true)
                end
            end
        end
    end
end
function Hero:stopMoveEffect()
    if self.isPlayMoveEffect  then
        TFAudio.stopEffect(self.isPlayMoveEffect )
        self.isPlayMoveEffect = nil
    end
end

function Hero:renderMove(xv,yv,zv)
    zv = zv or 0
    -- _print("xv,yv,zv",xv,yv,zv)
    -- if zv then
    --     if zv > 100000 or zv < -100000 then
    --         Box("asdfsadfsa")
    --         return
    --     end
    -- end

    if xv ~= 0 or yv ~= 0 or zv ~= 0 then
        if self.actor then
            local pos              = self.position3D
            local nx = pos.x       + xv
            local ny = pos.y       + yv --逻辑位置
            local nz = pos.z       + zv --渲染位置Y
            if battleController.canMove(nx , ny) then
                pos.x  = nx
                pos.y  = ny
                pos.z  = nz
            elseif xv ~= 0 and battleController.canMove(nx , pos.y) then
                pos.x = nx
            elseif yv ~= 0 and battleController.canMove(pos.x , ny) then
                pos.y = ny
                pos.z = nz
            elseif zv ~= 0 and yv == 0 then
                pos.z = nz
            end
            local maxZ = battleController.getMaxCameraHeight() - 50
            if pos.z > maxZ then
                pos.z = maxZ
            end
            pos.z = math.max(pos.z,pos.y)
            self.actor:setPosition(pos.x,pos.z)
        end
    end
end

--模拟重力加速度
function Hero:simulateMove(dt)
    self.actionMgr:update(dt*0.001)
end

function Hero:stopAllActions(actionType)
    self.actionMgr:stop(actionType)
end

--一次技能攻击完成
function Hero:onSkillEnd(skill)
    --觉醒技能释放完成后变身
    -- if skill:getKeyCode() == eVKeyCode.SKILL_D then
        -- self:changeSkin()
    -- end

    --检查技能完成
    if self.curForm then
        self.curForm:check(skill:getCID())
    end
    --若果是第二形态 怒气为0时 还原到第一形态
end

--检查技能是否是变身技能
function Hero:isExchangeSkill(cid)
    if self.curForm then
        return self.curForm:isExchange(cid)
    end
end

--是否无限血量
function Hero:isUnlimitedHp()
    return self.data.unlimitedHp == 1
end

--自增血量
function Hero:getUnlimitedHp()
    return self.nUnlimitedHp
end
-- 
function Hero:changeUnlimitedHp(value)
    self.nUnlimitedHp = self.nUnlimitedHp + value
    if self.nUnlimitedHp < 500000 then 
        self.nUnlimitedHp = self.nUnlimitedHp + 1000000
    end
end


function Hero:killMySelf()
    self.team:remove(self)
    self:release()
end

--AI 触发buffer
function Hero:act_triggetBuffer(id,buffId)
    if self:enableSyncAIstep() then
        self.aiAgent:syncAIStepData(id,{AIactionType.act_triggetBuffer})
    else
        if battleController.isLockStep() then
            if self:checkAIStep(AIactionType.act_triggetBuffer) then
                self:updateStateInfo()
                self.AIStepParams = nil
            end
        end
    end
    self:onSkillTrigger(eBFSkillEvent.SE_HURT,buffId,self)
end

function Hero:act_useSkill(id,skillCid)
    local realCid = skillCid 
    if battleController.isLockStep() and self.AIStepParams and self.AIStepParams[1] == 1 then
        realCid = self.AIStepParams[2]
    end
    local skill = self:getSkillByCid(realCid)
	if not skill then 
		return
	end
    if self.lastSkillCid and realCid == self.lastSkillCid then
        if self.aiUseSkillTime < 1000 then
            self:endToAI()
            return false
        end
        self.aiUseSkillTime = 0
    end
    self.lastSkillCid = realCid
    self.willUseSkill = skill

    local rets = false
    local isNext = 0
    if self:_checkState(eState.ST_STAND,eState.ST_MOVEEX,eState.ST_SKILL) then
        if self:isValidKey(skill:getKeyCode()) then
            if self.skill ~= skill then
                if self:canCast(skill) then
                    self:castSK(skill)
                    rets = true
                end
            else
                skill:setNext(true)  --触发连击
                isNext = 1
                rets = true
            end
        end
    end
    
    if self:enableSyncAIstep() then
        if rets then
            self.aiAgent:syncAIStepData(id,{AIactionType.act_useSkill, realCid, isNext})
        end
    else
        if battleController.isLockStep() then
            if self:checkAIStep(AIactionType.act_useSkill) then
                self:updateStateInfo()
                if isNext == 1 and (self.AIStepParams[3] and self.AIStepParams[3] == 0) then
                    self.skill = nil
                    skill:clearCD()
                    self:doEvent(eStateEvent.BH_STAND)
                    if self:isValidKey(skill:getKeyCode()) then
                        if self:canCast(skill) then
                            self:castSK(skill)
                            rets = true
                        end
                    end
                elseif not rets then
                    skill:clearCD()
                    self:doEvent(eStateEvent.BH_STAND)
                    if self:isValidKey(skill:getKeyCode()) then
                        if self:canCast(skill) then
                            self:castSK(skill)
                            rets = true
                        end
                    end
                end
                self.AIStepParams = nil
            end
        end
    end
    if not rets then
        self:endToAI()
    end
    return rets
end

function Hero:act_switchModel(id,modelIndex)
    if self:enableSyncAIstep() then
        self.aiAgent:syncAIStepData(id,{AIactionType.act_switchModel})
    else
        if battleController.isLockStep() then
            if self:checkAIStep(AIactionType.act_switchModel) then
                self:updateStateInfo()
                self.AIStepParams = nil
            end
        end
    end
    self:setActionIndex(modelIndex)
    self.aiAgent:next()
end

function Hero:act_killMySelf(id,isCount)
    if self:enableSyncAIstep() then
        self.aiAgent:syncAIStepData(id,{AIactionType.act_killMySelf})
    else
        if battleController.isLockStep() then
            if self:checkAIStep(AIactionType.act_killMySelf) then
                self:updateStateInfo()
                self.AIStepParams = nil
            end
        end
    end
    self:setAIEnable(false)
    self.team:remove(self)
    if isCount then
        if self.isDeaded then
            
        else
            self.isDeaded = true
            EventMgr:dispatchEvent(eEvent.EVENT_HERO_DEAD, self)
        end
    else
        EventMgr:dispatchEvent(eEvent.EVENT_HERO_REMOVE, self)
    end
    self:release()
end

function Hero:act_moveToPositon(id,position, speedScale)
    if self:enableSyncAIstep() then
        self.aiAgent:syncAIStepData(id,{AIactionType.act_moveToPositon})
    else
        if battleController.isLockStep() then
            if self:checkAIStep(AIactionType.act_moveToPositon) then
                self:updateStateInfo()
                self.AIStepParams = nil
            end
        end
    end
    if levelParse:canMove(position) then
        self.nSpeedScale = speedScale
        self:findPath(position)
        local ret = self:doEvent(eStateEvent.BH_MOVEEX,eMoveState.Patrol)
        if not ret then
            self:endToAI()
        end
    else
        dump({position})
        self.aiAgent:next()
    end
end

function Hero:act_playEffect(id,type_, effectName, animationName, order, loopTime, scale)
    if self:enableSyncAIstep() then
        self.aiAgent:syncAIStepData(id,{AIactionType.act_playEffect})
    else
        if battleController.isLockStep() then
            if self:checkAIStep(AIactionType.act_playEffect) then
                self:updateStateInfo()
                self.AIStepParams = nil
            end
        end
    end
    local effect = ResLoader.createEffect(effectName, scale)
    if type_ == 1 then    -- 时间
        BattleTimerManager:addTimer(loopTime, 1, function()
                                        if effect.resPath then
                                            ResLoader.addCacheSpine(effect,effect.resPath)
                                        end
                                        effect:removeFromParent()
        end)
        effect:play(animationName, true)
    else    -- 次数
        local count = 0
        effect:addMEListener(
            TFARMATURE_COMPLETE,
            function()
                count = count + 1
                if count >= loopTime then
                    if effect.resPath then
                        ResLoader.addCacheSpine(effect,effect.resPath)
                    end
                    effect:removeFromParent()
                else
                    effect:play(animationName)
                end
            end
        )
        effect:play(animationName, false)
    end
    EventMgr:dispatchEvent(eEvent.EVENT_EFFECT_ADD_TO_LAYER, effect, order)
end

function Hero:act_setHpPercent(id,percent)
    if self:enableSyncAIstep() then
        self.aiAgent:syncAIStepData(id,{AIactionType.act_setHpPercent})
    else
        if battleController.isLockStep() then
            if self:checkAIStep(AIactionType.act_setHpPercent) then
                self:updateStateInfo()
                self.AIStepParams = nil
            end
        end
    end
    self:setHpPercent(percent)
    if self.actor then
        self.actor:refresh()
    end
    EventMgr:dispatchEvent(eEvent.EVENT_HERO_ATTR_CHANGE,self)
    self.aiAgent:next()
end

function Hero:getFixedScopeEnemy(rect)
    local team = self.team
    if rect then
        local absoluteRect = clone(rect)
        local pos = self:getPosition3D()
        absoluteRect.origin = me.pAdd(pos, absoluteRect.origin)
        return self:findScopeTargert(absoluteRect)
    else
        return self:findTargets()
    end
end

function Hero:getShowTiming()
    return self.showTiming_
end

function Hero:act_pathFinding(id,range, limitArea, walkDistance, walkWeight, runWeight, fixTargetCid)
    -- if self:isAState(eAState.E_STOP_MOVE) then
    --     self.aiAgent:next()
    --     return
    -- end
    self.pathCheckTiming = 0
    self.walkDistance = walkDistance
    self.limitArea = limitArea
    self.atkRect = me.rect(range[1], range[2], range[3], range[4])
    fixTargetCid = fixTargetCid or 0
    if fixTargetCid then
        if fixTargetCid < 0 then 
            local heroIndex = math.abs(fixTargetCid)
            local heros =  battleController.getMenbers() --不包括死亡的队员
            for i = heroIndex, 1, -1 do
                if heros[i] then 
                   self.fixTarget =  heros[i]
                   break
                end
            end
        elseif  fixTargetCid > 0 then
            local team = battleController:getTeam()
            self.fixTarget = team:getHeroWithID(fixTargetCid)
        else
            self.nearTarget = self:findTarget()
        end
    end
    local index = BattleUtils.randomProbability({walkWeight, runWeight})
    self.isWalkInNear = (index == 1)
    if self:enableSyncAIstep() then
        local cid1 = self.fixTarget and self.fixTarget:getData().id or nil
        local cid2 = self.nearTarget and self.nearTarget:getData().id or nil
        self.aiAgent:syncAIStepData(id,{AIactionType.act_pathFinding, cid1, cid2})
        if self.fixTarget or (self.nearTarget  and self.nearTarget:isAlive()) then
            if self:canDoEvent(eStateEvent.BH_MOVEEX) then
                self:doEvent(eStateEvent.BH_MOVEEX, eMoveState.Fallow)
            else
                self:endToAI()
            end
        else
            self:endToAI()
        end
    end
    if not self:enableSyncAIstep() then
        if battleController.isLockStep() then
            if self:checkAIStep(AIactionType.act_pathFinding) then
                self:updateStateInfo()
                if fixTargetCid < 0 then 
                    local heros =  battleController.getMenbers() --不包括死亡的队员
                    for i,v in ipairs(heros) do
                        if v.id == self.AIStepParams[2] then
                            self.fixTarget =  heros[i]
                            break
                        end
                    end
                elseif  fixTargetCid > 0 then
                    local team = battleController:getTeam()
                    self.fixTarget = team:getHeroWithID(self.AIStepParams[2])
                else
                    self.nearTarget = self:findTarget()
                end
                if self.fixTarget or (self.nearTarget  and self.nearTarget:isAlive()) then
                    if self:canDoEvent(eStateEvent.BH_MOVEEX) then
                        self:doEvent(eStateEvent.BH_MOVEEX, eMoveState.Fallow)
                    else
                        self:endToAI()
                    end
                else
                    self:endToAI()
                end
                self.AIStepParams = nil
                return               
            end
        end
        if self.fixTarget or (self.nearTarget  and self.nearTarget:isAlive()) then
            if self:canDoEvent(eStateEvent.BH_MOVEEX) then
                self:doEvent(eStateEvent.BH_MOVEEX, eMoveState.Fallow)
            else
                self:endToAI()
            end
        else
            self:endToAI()
        end
    end
end

function Hero:act_directUseSkill(callback, skillCid)
    self.callback = callback
    self.willUseSkill = self:getSkillByCid(skillCid)
    self:ai_useSkill()
end

function Hero:act_delay(id,delayTime)
    if self:enableSyncAIstep() then
        self.aiAgent:syncAIStepData(id,{AIactionType.act_delay})
    else
        if battleController.isLockStep() then
            if self:checkAIStep(AIactionType.act_delay) then
                self:updateStateInfo()
                self.AIStepParams = nil
            end
        end
    end
    BattleTimerManager:addTimer(
        delayTime, 1,
        function()
            self.aiAgent:next()
        end
    )
end

function Hero:act_setPosition(id,type_, position)
    if self:enableSyncAIstep() then
        self.aiAgent:syncAIStepData(id,{AIactionType.act_setPosition})
    else
        if battleController.isLockStep() then
            if self:checkAIStep(AIactionType.act_setPosition) then
                self:updateStateInfo()
                self.AIStepParams = nil
            end
        end
    end
    if type_ == 1 then    -- 相对坐标
        local pos = self:getPosition3D()
        local x = pos.x + position.x
        local y = pos.y + position.y
        self:setPosition3D(x, y)
    else    -- 世界坐标
        self:setPosition3D(position.x, position.y,position.y)
    end
    self.aiAgent:next()
end

function Hero:act_run(callback, x, y)
    self.callback = callback
    local target = self:findTarget()
    local targetPos = target:getPosition3D()
    local selfPos = self:getPosition3D()
    local airWall = battleController.getAirwall()
    local targetDir = target:getDir()
    local pos
    -- if targetDir == eDir.LEFT then
    --     pos = me.pSub(targetPos, ccp(x, y))
    --     local leftHorizontal, rightHorizontal, bottomVertical, topVertical = battleController.isOverflowAirWall(pos)
    --     if leftHorizontal or rightHorizontal then
    --         pos.x = targetPos.x + x
    --     end
    --     if bottomVertical or topVertical then
    --         pos.y = targetPos.y + y
    --     end
    -- else
    --     pos = me.pAdd(targetPos, ccp(x, y))
    --     local leftHorizontal, rightHorizontal, bottomVertical, topVertical = battleController.isOverflowAirWall(pos)
    --     if leftHorizontal or rightHorizontal then
    --         pos.x = targetPos.x - x
    --     end
    --     if bottomVertical or topVertical then
    --         pos.y = targetPos.y - y
    --     end
    -- end

    local rets = false
    if self:_checkState(eState.ST_STAND,eState.ST_MOVEEX) then
        --TODO 临时处理从可行走区域随机执行寻路
        pos = levelParse:randomPos(levelParse:getMoveRect())  --随机可行走区域
        self:findPath(pos)
        self:doEvent(eStateEvent.BH_MOVEEX, eMoveState.Target)
        rets = true
    end
    if not rets then
        self:reset_patrol()
    end
end

function Hero:checkEnableTarget(targets)
    local realTargets = {}
    for k,v in pairs(targets) do
        if v:isAState(eAState.E_STATE_60) then
        else
            table.insert(realTargets,v)
        end
    end
    return realTargets
end

function Hero:act_patrol(id,type_, walkDistance, walkWeight, runWeight)
    -- if self:isAState(eAState.E_STOP_MOVE) then
    --     self.aiAgent:next()
    --     return
    -- end
    self.walkDistance = walkDistance
    local index = BattleUtils.randomProbability({walkWeight, runWeight})
    self.isWalkInNear = (index == 1)
    local rets = false
    local maxLoopCount = 100
    if self:_checkState(eState.ST_STAND,eState.ST_MOVEEX) then
        local objs = self:findTargets()
        local targets = self:checkEnableTarget(objs)
        if #targets > 0 then
            local pos
            local target = targets[RandomGenerator.random(#targets)]
            local targetPos = target:getPosition3D()  --目标位置
            local myPos = self:getPosition3D()
            local moveRect = levelParse:getMoveRect()
            if type_ == 1 then
                local site = self:checksite(targetPos, myPos)
                local siteList = VaildSites[site]
                while true do
                    maxLoopCount =  maxLoopCount - 1
                    site = siteList[RandomGenerator.random(#siteList)]
                    local subPos = self:randomPos(site)
                    pos = me.pAdd(targetPos , subPos)
                    if me.rectContainsPoint(moveRect, pos) then
                        if levelParse:canMove(pos.x, pos.y) then
                            break
                        end
                    end
                    if maxLoopCount  < 1 then
                        Box("act_patrol 死循环了1:" .. self.data.id)
                        break
                    end
                end
            elseif type_ == 2 then
                while true do
                    maxLoopCount =  maxLoopCount - 1
                    local rect = self:getPatrolRect(targetPos, myPos)
                    pos = levelParse:randomPos(rect)  --随机可行走区域
                    if levelParse:canMove(pos.x, pos.y) then
                        break
                    end
                    if maxLoopCount  < 1 then
                        Box("act_patrol 死循环了2:" .. self.data.id)
                        break
                    end
                end
            end
            if pos then
                if self:enableSyncAIstep() then
                    self.aiAgent:syncAIStepData(id,{AIactionType.act_patrol, pos.x, pos.y})
                    self:findPath(pos)
                    rets = self:doEvent(eStateEvent.BH_MOVEEX,eMoveState.Patrol)
                elseif battleController.isLockStep() then
                    if not self.AIStepParams then
                        self:findPath(pos)
                        rets = self:doEvent(eStateEvent.BH_MOVEEX,eMoveState.Patrol)
                    end
                else
                    self:findPath(pos)
                    rets = self:doEvent(eStateEvent.BH_MOVEEX,eMoveState.Patrol)
                end
            end
        end
    end
    if not self:enableSyncAIstep() then
        if battleController.isLockStep() then
            if self:checkAIStep(AIactionType.act_patrol) then
                self:updateStateInfo()
                local state = self:getState()
                if state ~= eState.BH_STAND then
                    self:doEvent(eStateEvent.BH_STAND)
                end
                self:findPath(ccp(self.AIStepParams[2], self.AIStepParams[3]))
                rets = self:doEvent(eStateEvent.BH_MOVEEX,eMoveState.Patrol)
                self.AIStepParams = nil
            end
        end
    end
    if not rets then
        self:endToAI()
    end
end

function Hero:act_setDir(id,dir)
    if self:enableSyncAIstep() then
        self.aiAgent:syncAIStepData(id,{AIactionType.act_setDir})
    else
        if battleController.isLockStep() then
            if self:checkAIStep(AIactionType.act_setDir) then
                self:updateStateInfo()
                self.AIStepParams = nil
            end
        end
    end
    self:setDir(dir)
    self.aiAgent:next()
end

function Hero:act_follow(id,target, distance)
    -- if self:isAState(eAState.E_STOP_MOVE) then
    --     self.aiAgent:next()
    --     return
    -- end
    local function fixedPos(type_, rawPos)
        local func = {
            [1] = function(pos)
                pos.x = pos.x - distance
                if levelParse:canMove(pos) then
                    return pos
                end
            end,
            [2] = function(pos)
                pos.x = pos.x + distance
                if levelParse:canMove(pos) then
                    return pos
                end
            end,
            [3] = function(pos)
                pos.y = pos.y - distance
                if levelParse:canMove(pos) then
                    return pos
                end
            end,
            [4] = function(pos)
                pos.y = pos.y + distance
                if levelParse:canMove(pos) then
                    return pos
                end
            end,
        }
        local orderFunc = {type_}
        for i = 1, #func do
            if i ~= type_ then
                table.insert(orderFunc, i)
            end
        end
        local pos
        for i, v in ipairs(orderFunc) do
            pos = func[v](clone(rawPos))
            if pos then
                break
            end
        end
        return pos
    end

    local rets = false
    if target then
        local targetPos = target:getPosition()
        local selfPos = self:getPosition()
        local offset = me.pSub(targetPos, selfPos)
        local movePos
        if math.abs(offset.x) > distance then
            if offset.x > 0 then
                movePos = fixedPos(1, targetPos)
            else
                movePos = fixedPos(2, targetPos)
            end
        else
            movePos = clone(selfPos)
            movePos.y = targetPos.y
        end

        if movePos then
            if self:enableSyncAIstep() then
                self.aiAgent:syncAIStepData(id,{AIactionType.act_follow, movePos.x, movePos.y})
                self:findPath(movePos)
                rets = self:doEvent(eStateEvent.BH_MOVEEX, eMoveState.FixedMove)
            elseif battleController.isLockStep() then
                if not self.AIStepParams then
                    self:findPath(movePos)
                    rets = self:doEvent(eStateEvent.BH_MOVEEX, eMoveState.FixedMove)
                end
            else
                self:findPath(movePos)
                rets = self:doEvent(eStateEvent.BH_MOVEEX, eMoveState.FixedMove)
            end
        end
    end
    if not self:enableSyncAIstep() then
        if battleController.isLockStep() then
            if self:checkAIStep(AIactionType.act_follow) then
                self:updateStateInfo()
                self:findPath(ccp(self.AIStepParams[2], self.AIStepParams[3]))
                rets = self:doEvent(eStateEvent.BH_MOVEEX,eMoveState.FixedMove)
                self.AIStepParams = nil
            end
        end
    end
    if not rets then
        self:endToAI()
    end
end

function Hero:act_def(callback, skillCid)
    local skillCfg = TabDataMgr:getData("Skill", skillCid)
    local skillActionCfg = TabDataMgr:getData("SkillAction", skillCfg.first)
    self.willUseSkill = self:getSkillByCid(skillCid)
    self.callback = callback
    if self:isValidKey(self.willUseSkill:getKeyCode()) then
        if self:canCast(self.willUseSkill) then
            local target = self:findTarget()
            local pos = self:calOffsetPosition(skillActionCfg.actionMoveX, skillActionCfg.actionMoveY)
            local leftHorizontal, rightHorizontal = battleController.isOverflowAirWall(pos)
            if leftHorizontal or rightHorizontal then
                if leftHorizontal then
                    self:setDir(eDir.RIGHT)
                else
                    self:setDir(eDir.LEFT)
                end
            else
                if target:getDir() == eDir.LEFT then
                    self:setDir(eDir.RIGHT)
                    local pos = self:calOffsetPosition(skillActionCfg.actionMoveX, skillActionCfg.actionMoveY)
                    local leftHorizontal, rightHorizontal, bottomVertical, topVertical = battleController.isOverflowAirWall(pos)
                    if leftHorizontal or rightHorizontal then
                        self:setDir(eDir.LEFT)
                    end
                else
                    self:setDir(eDir.LEFT)
                    local pos = self:calOffsetPosition(skillActionCfg.actionMoveX, skillActionCfg.actionMoveY)
                    local leftHorizontal, rightHorizontal, bottomVertical, topVertical = battleController.isOverflowAirWall(pos)
                    if leftHorizontal or rightHorizontal then
                        self:setDir(eDir.RIGHT)
                    end
                end
            end
            self:castSK(self.willUseSkill)
        else
            self:reset_useSkill()
        end
    else
        self:reset_useSkill()
    end
end

function Hero:endToAI()
    if self.aiAgent then
        self:moveToStand()
        self.aiAgent:endToActiveChildNode()
    end
end

function Hero:reset_patrol()
    if self.aiAgent then
        self.aiAgent:endToActiveChildNode()
    end
end

--角色移动到指定位置(剧情)
function Hero:moveToPos(pos,callfunc)
    --设置为剧情模式
    self:setFlag(eFlag.PlotMode)
    --移动完成的回调
    self.plotMoveEndCallFunc = callfunc
    --寻路
    self:findPath(pos)
    --切换到位移状态
    local ret = self:doEvent(eStateEvent.BH_MOVEEX, eMoveState.Target)
    if not ret then
        Box("剧情模式下无法切换到移动状态")
    end
end

function Hero:playAnimation(animation,callfunc)

end


--分摊伤害处理
function Hero:doShareHurt(hurtValue)
    local shareRatio = self:getValue(eAttrType.ATTR_HURT_SHARE_RATIO)
    if shareRatio > 0 then
        for i,effect in ipairs(self.bufferEffectMap) do
            if effect:getEffectType() == eBFEffectType.ET_SHARE_HURT then
                local state  = effect:getEffectState()
                local heros  = battleController.getTeam():getHerosEx()
                local _heros = {}
                for i, hero in ipairs(heros) do
                    if self ~= hero and hero:isAState(state) then
                        table.insert(_heros,hero)
                    end
                end
                local heroSize = #_heros
                if heroSize > 0 then
                    local shareHurtValue = math.ceil(hurtValue*shareRatio*0.0001/heroSize)
                    hurtValue = math.ceil(hurtValue*(1 - shareRatio*0.0001))
                    hurtValue = hurtValue >= 0 and -1 or  hurtValue
                    --分摊角色减血
                    for i, hero in ipairs(_heros) do
                        hero:changeHp(shareHurtValue,nil,self,true)
                    end
                end
                break
            end
        end
    end

    -- TODO 分摊测试
    -- local shareRatio = 5000
    -- local heros  = battleController.getTeam():getHerosEx()
    -- local _heros = {}
    -- for i, hero in ipairs(heros) do
    --     if self ~= hero then
    --         table.insert(_heros,hero)
    --     end
    -- end
    -- local heroSize = #_heros
    -- if heroSize > 0 then
    --     local shareHurtValue = math.ceil(hurtValue*shareRatio*0.0001/heroSize)
    --     hurtValue = math.ceil(hurtValue*(1 - shareRatio*0.0001))
    --     hurtValue = hurtValue >= 0 and -1 or  hurtValue
    --     --分摊角色减血
    --     for i, hero in ipairs(_heros) do
    --         hero:changeHp(shareHurtValue,nil,self,true)
    --     end
    -- end

    return hurtValue
end

function Hero:isRecoverRst()
    if self.superArmorMgr then
        return self.superArmorMgr:isRecoverIng()
    end
    return false
end

function Hero:getRecoverResistPercent()
    if self.superArmorMgr then
        return self.superArmorMgr:getRecoverPercent()
    end
    return 0
end



function Hero:skillReset()
    local skills = self:getSkillList()
    for i , skill in ipairs(skills) do
        skill:reset()
    end
end

--检查技能是否可用
function Hero:checkSkill(skill)
    local keyCode = skill:getKeyCode()
    for k , v in pairs(skill_type_disable) do
        if v == keyCode then
            if self:isAState(k) then
                return false
            end 
        end
    end

    return true
end
--检查技能是否可用和CD
function Hero:checkSkill_CD(skill)
    local keyCode = skill:getKeyCode()
    for k , v in pairs(skill_type_disable_cd) do
        if v == keyCode then
            if self:isAState(k) then
                return false
            end 
        end
    end
    return true
end

--角色状态修正
function Hero:fix( posX , posY , dir , hp, state)
    if posX and posY then
        local pos3D = self.position3D
        pos3D.x = posX
        local offset = posY - pos3D.y
        pos3D.y = posY
        pos3D.z = pos3D.z + offset
        self:setPosition3D(posX , pos3D.y , pos3D.z)
    end
    if dir then
        self:setDir(dir)
    end
    if hp then
        if battleController.isShowFixHurt() then
            local lose = hp - self:getHp()
            if lose < 0 then 
                self:showDamage(lose)                --显示掉血
            end 
        end
        self:setValue(eAttrType.ATTR_NOW_HP,hp,true)
    end
    if state == eAState.E_RELIVE then 
        self:addAState(eAState.E_RELIVE)
    end
end


function Hero:fix_boss(heroId, posX , posY , dir , hp , sp)
    if sp then --强制同步霸体值
        -- if sp < self:getResist() then 
            self:setValue(eAttrType.ATTR_NOW_RST,sp,true)
        -- end
    end

    local curHp = self:getHp()
    if curHp > 0 and hp then
        local lose = hp - curHp
        if  lose < 0 then
            self:setValue(eAttrType.ATTR_NOW_HP,hp,true)
            if battleController.isShowFixHurt() then
                self:showDamage(lose) --显示掉血
            end
            if hp <= 0 then
                local target = battleController.getPlayer(heroId)
                if target then
                    self:onEventTrigger(eBFState.E_DYING,target)
                end
            end
        end
    end
    if battleController.isZLJH() then 
        return
    end
    if not AIAgent:isEnabled() then --AI 关闭的情况下不同步位置
        return
    end
    if posX and posY then
        local pos3D = self.position3D
        pos3D.x = posX
        local offset = posY - pos3D.y
        pos3D.y = posY
        pos3D.z = pos3D.z + offset
        self:setPosition3D(posX , pos3D.y , pos3D.z)
    end
    if dir then
        self:setDir(dir)
    end
end

function Hero:updateStateInfo()
    if self.stateInfoData then
        self:fix_boss(self.stateInfoData.operate, self.stateInfoData.posX,self.stateInfoData.posY,self.stateInfoData.dir,self.stateInfoData.hp)
    end
    self.stateInfoData = nil
end

function Hero:revStateInfoData(data)
    self.stateInfoData = data
end

function Hero:revAIStepData(lastIdx, cruIdx, params)
    if not AIAgent:isEnabled() then
        return
    end
    table.insert(self.AIStepDatas, {lastIdx, cruIdx, params})
end

function Hero:getAIStepParams()
    return self.AIStepParams
end

function Hero:resetAIStepDatas()
    self.AIStepDatas = {}
end

function Hero:checkAIStep(funcID)
    if self.AIStepParams and self.AIStepParams[1] == funcID then
        return true
    end
    return false
end

function Hero:getLockHp()
    for i = 10, 1,-1 do
        if self:isAState(200 + i) then
            return self:getMaxHp()* i * 0.1
        end
    end
    return 0
end

function Hero:getLimitHp()
    for i = 9, 1,-1 do
        if self:isAState(300 + i) then
            return i * 10
        end
    end
    for i = 5, 1,-1 do
        if self:isAState(310 + i) then
            return i * i * 100
        end
    end
    return 0
end

function Hero:enableSyncAIstep()
    if battleController.isLockStep() and battleController.checkAISyncHost() then
        return true
    end
    return false
end

function Hero:interruptAIStep()
    local state = self:getState()
    if state == eState.ST_SKILL then
        if self.actor then 
            self.actor.fixZOrder = nil
        end
        self:cancel(true)
        self:removeAllEffect()
        self:stopSoundEffect()
        self:stopAllActions()
    elseif state == eState.ST_MOVEEX or state == eState.ST_FALL then
        self:cleanPath()
        self:stopMoveEffect()
    end
    if self:isInAir() then
        self:forceToFloor()
    end
    self:getActor():stopAllActions()
    self:doEvent(eStateEvent.BH_STAND)
end

function Hero:moveToPosAction(pos)
    self:setPosition3D(pos.x)
    local function onFunc()
        self:endToAI()
    end
    local scale        = BattleConfig.MODAL_SCALE* self:getSkeletonNodeScale()
    local skeletonNode = self.actor:playEffect("effects_11201_quickmove",scale,"diceng",onFunc)
    __setSkeletonNodeDir(skeletonNode,self:getDir())
end


return Hero
