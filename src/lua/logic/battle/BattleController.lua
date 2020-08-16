if battleController then
    return battleController
end
GuideMgr = require("lua.logic.guide.GuideMgr")
require("lua.logic.battle.RandomGenerator")
local BattleConfig   = import(".BattleConfig")
local BattleUtils    = import(".BattleUtils")
local ResLoader      = import(".ResLoader")
local KeyStateMgr    = import(".KeyStateMgr")
local Team       = import(".Team")
local AwakeMgr   = import(".AwakeMgr")
local GameObject  = import(".GameObject")
local BattleMgr   = import(".BattleMgr")
local LockStep   = import(".LockStep")
local enum       = import(".enum")
local eCampType  = enum.eCampType
local eRoleType  = enum.eRoleType
local eEvent     = enum.eEvent
local eStateEvent= enum.eStateEvent
local ePlaceType = enum.ePlaceType
local eAttrType  = enum.eAttrType
local eGuideAction = enum.eGuideAction
local eVictoryType = enum.eVictoryType
local eBFState      = enum.eBFState
local eSkillType    = enum.eSkillType
local eMode         = enum.eMode
local eTeamType     = enum.eTeamType
local statistics    = import(".Statistics")
local victoryDecide = import(".VictoryDecide")
local brushMonster = import(".BrushMonster")
local musicMgr = import(".MusicMgr")  --MusicMgr.load(roleID)
local eMonsterType = enum.eMonsterType
local BattleTimerManager   = import(".BattleTimerManager")
local EventTrigger = import(".EventTrigger")
local levelParse   = import(".LevelParse")
local AIAgent      = import(".AIAgent")
local SkillEx       = import(".SkillEx")
local BattleGuide = import(".BattleGuide")
local SimpleHero = import(".SimpleHero")

local eBState =
{
    BS_NOT_INIT   = 0 ,
    BS_NOT_BEGIN  = 1 ,
    BS_RUN        = 2 ,
    BS_END        = 3
}
local _print = print
local print = BattleUtils.print
battleController =  {}

function TONUMBER(value)
    if not value then
        return 0
    end
    return tonumber(value)
end

local this = battleController

-- Box = function( ... )
--     -- body
-- end
function battleController.registerEvents()
    --设置变更
    EventMgr:addEventListener(this, EV_SETTING_CHANGE, this._onSettingChange)
    --角色被击杀
    EventMgr:addEventListener(this, eEvent.EVENT_HERO_DEAD, this._onSlain)
    EventMgr:addEventListener(this, eEvent.EVENT_ADD_COMBO, this._onComboEvnet)
    --统计相关
    EventMgr:addEventListener(this, eEvent.EVENT_NOTICE_HP, this._onNoticeHp)
    EventMgr:addEventListener(this, eEvent.EVENT_HP_CHANGE, this._onHpChange)
    EventMgr:addEventListener(this, eEvent.EVENT_GETHIT, this._onGetHit)
    EventMgr:addEventListener(this, eEvent.EVENT_HIT, this._onHit)
    EventMgr:addEventListener(this, eEvent.EVENT_PICKUP, this._onPickUp)
    EventMgr:addEventListener(this, eEvent.EVENT_FALL, this._onFall)
    EventMgr:addEventListener(this, eEvent.EVENT_SKILL_AWAKE, this._onSkillAwake)
    EventMgr:addEventListener(this, eEvent.EVENT_SKILL_DODGE, this._onSkillDodge)
    EventMgr:addEventListener(this, eEvent.EVENT_SKILL, this._onSkill)
    EventMgr:addEventListener(this, eEvent.EVENT_SKILL_ENTER_KILL, this._onSkillEnterKill)
    EventMgr:addEventListener(this, eEvent.EVENT_SKILL_AWAKE_KILL, this._onSkillAwakeKill)
    EventMgr:addEventListener(this, eEvent.EVENT_HERO_BATTLE, this._onHeroBattle)
    EventMgr:addEventListener(this, EV_BATTLE_END_TRIGGER_EVENT, this.endBattle)
    EventMgr:addEventListener(this, EV_PRACTICE_SET_SKIN, this.setSkin) --木桩试穿灵装
    EventMgr:addEventListener(this, eEvent.EVENT_TRIGGER_JUMP, this.onTriggerJump) --组队副本跳转
    -- EventMgr:addEventListener(this, eEvent.EVENT_CHANGE_GUNGEON, this.onChangeDungeon) --组队副本跳转


end

-- function battleController.getChildNode()
--     local route      = this.data.route
--     local dungeonCid = this.data.dungeonCid
--     for k, node in pairs(route) do
--         if node.dungeonId  == dungeonCid then 
--             return node
--         end
--     end
-- end

--是否是高级组队
function battleController.isLockStepEx()
    if this.isLockStep() then 
        return this.data.dungeonNodes ~= nil
    end
end

--创建跳转点
function battleController.createJumpPoint()
    if this.isLockStepEx() then
        local npcList = levelParse:getNpcList()
        local node    = this.data.dungeonNodes[this.data.dungeonIndex]
        dump(this.data.dungeonIndex)
        dump(this.data.dungeonNodes)
        for k, v in ipairs(npcList) do
            local index   = tonumber(v.CfgID)
            if node.next[index] ~= 0 then 
                local data    = {}
                data.res      = this.levelCfg_.gateEffect or "effects_gate_01"
                data.index    = index
                data.pos      = me.p(v.Position.X, v.Position.Y)
                local jumpPoint    = GameObject.createJumpPoint(data)
                if node.pass then --当前关卡已经通关激活所有 跳转点
                    jumpPoint:setState(1) 
                end
                jumpPoint:active()
                dump({"createJumpPoint:" ,tostring(data.index),data.pos})
            end
        end
    end
end

--切换关卡
function battleController.changeDungeon(index,resTime)
    index = index + 1 --TODO 和服务器保持一致
    dump("battleController.changeDungeon"..tostring(index))

    --进入下一个场景
    -- local timerHandle
    -- timerHandle = TFDirector:addTimer(3000, 1, nil, function ()
    --     TFDirector:removeTimer(timerHandle)
        this.reEnterTeamBattle(index,resTime)
    -- end) 


end

function battleController.onTriggerJump(posIndex)
    dump("onTriggerJump",posIndex)
    if this.bTriggerJump then 
        return 
    end
    this.bTriggerJump = true
    if this.isLeader() then
        local node  = this.data.dungeonNodes[this.data.dungeonIndex]
        local index = node.next[posIndex]
        --剩余时间
        local resTime = victoryDecide.nRemainingTime*0.001 --换算成秒
        resTime       = math.max(1,resTime) --最小为1秒
        LockStep.sendChangeDungeon(index-1,resTime)
        dump("sendChangeDungeon"..tostring(index))
        -- local dungeonCid = this.data.dungeonCid
        -- for k, node in pairs(this.data.route) do
        --     if node.dungeonId  == dungeonCid then 
        --         local index  = node.next[posIndex]
        --         --减一处理和服务器数据保持一致 

        --     end
        -- end
    end
end



--木桩试穿灵装
function battleController.setSkin(skinID)
    --检查当前灵装和 试穿的灵装试试否一致
    print("试用skinID："..tostring(skinID))
    local list = battleController.getBench()
    for i, hero in ipairs(list) do
        if hero:getData().skinCid == skinID then
            if this.getCaptain() ~= hero then 
                hero:setControl()
                if this.view then 
                   if this.view.practice_infinite_toggle then 
                        hero:setPracticeInfinite(true)
                    else
                        hero:setPracticeInfinite(false)
                    end
                end
            end
            return
        end
    end
    printError("试用skinID："..tostring(skinID).."不存在")
end

function battleController.removeEvents()
    EventMgr:removeEventListenerByTarget(this)
end

function battleController._onMonsterLoseHp(value)
    statistics.loseHPEvent_monster(value)
end

function battleController._onHeroCreate(hero)
    if hero:getCampType() == eCampType.Monster then
        statistics.addMonsterInfo(hero)
    end
end
--设置变更
function battleController._onSettingChange()
    BattleConfig.ROKER_FIX_POSTION = SettingDataMgr:getBattleRokeVal()
end

--被击倒
function battleController._onFall(hero)
    if hero:getCampType() == eCampType.Hero then
        if hero:getRoleType() ~= eRoleType.Assist then --助战队员不统计
            statistics.fallEvent()
        end
    end
end


--使用技能
function battleController._onSkill(hero,skill)
    if hero:getCampType() == eCampType.Hero then
        if hero:getRoleType() ~= eRoleType.Assist then --助战队员不统计
            statistics.skillCountEvent(skill)
        end
    end
end

function battleController._onSkillDodge(hero)
    if hero:getCampType() == eCampType.Hero then
        if hero:getRoleType() ~= eRoleType.Assist then --助战队员不统计
            statistics.skillDodgeEvent()
        end
    end
end

--使用觉醒技能
function battleController._onSkillAwake(hero)
    if hero:getCampType() == eCampType.Hero then
        if hero:getRoleType() ~= eRoleType.Assist then --助战队员不统计
            statistics.skillAwakeEvent()
        end
    end
end

--入场技击杀
function battleController._onSkillAwakeKill(hero)
    if hero:getCampType() == eCampType.Hero then
        if hero:getRoleType() ~= eRoleType.Assist then --助战队员不统计
            statistics.skillAwakeKillEvent()
        end
    end
end

--入场技能击杀
function battleController._onSkillEnterKill(hero)
    if hero:getCampType() == eCampType.Hero then
        if hero:getRoleType() ~= eRoleType.Assist then --助战队员不统计
            statistics.skillEnterKillEvent()
        end
    end
end
--血量变更
function battleController._onHpChange(hero,hp)
    if hp < 0 then 
        this._onLoseHp(hero,hp)
    end
    EventTrigger:_onChangeHp(hero)
end
--失血
function battleController._onLoseHp(hero,hp)
    local campType = hero:getCampType() 
    if campType == eCampType.Hero then
        if hero:getRoleType() ~= eRoleType.Assist then --助战队员不统计
            statistics.loseHPEvent(hp)
            --受到最大伤害播放音效
            musicMgr.playInjured(hp)
        end
    elseif campType == eCampType.Monster then
        statistics.doHurtValue(hp)
        this.fixHitValue()
    end
end
--总血量
function battleController._onNoticeHp(hero,hp)
    if hero:getCampType() == eCampType.Hero then
        if hero:getRoleType() ~= eRoleType.Assist then --助战队员不统计
            statistics.hpEvent(math.abs(hp))
        end
    end
end
--受击
function battleController._onGetHit(hero)
    if hero:getCampType() == eCampType.Hero then
        if hero:getRoleType() ~= eRoleType.Assist then --助战队员不统计
            statistics.hitEvent()
            victoryDecide.onHurt()
        end
    end
end

function battleController._onHit(hero,value)
    if hero:getCampType() == eCampType.Hero then
        statistics.doHitEvent(value)
        victoryDecide.onHit()
    end
end

function battleController._onHurtValue(hero,value)
    if hero:getCampType() == eCampType.Monster then
        statistics.doHurtValue(value)
        this.fixHitValue()
    end
end

--角色参战
function battleController._onHeroBattle(hero)
    if hero:getCampType() == eCampType.Hero then
        statistics.heroBattleEvent(hero)
    elseif hero:getCampType() == eCampType.Monster then
        --遭遇精英怪播放音效
        local  monsterType = hero:getMonsterType()
        if monsterType == eMonsterType.MT_ELITE or
            monsterType == eMonsterType.MT_BOSS then
            musicMgr.playEnemySpotted()
        end
        EventTrigger:_onNewHeroJoin()
    end
end

--拾取道具
function battleController._onPickUp(data)
    statistics.pickUpEvent(data.itemType)
end

--角色被击杀
function battleController._onSlain(hero)
    local campType = hero:getCampType()
    if campType == eCampType.Monster then
        statistics.doScoreEvent(hero) --积分统计
        --只统计怪物
        victoryDecide.doSlain(hero)
        brushMonster:doSlain(hero)
        statistics.doSlain(hero:isBoss())
        --播放击杀音效(组队情况下可能不是自己击杀的)
        musicMgr:playKill()
        EventTrigger:_onSlain(hero)
        this.eventCheck(hero)
    elseif campType == eCampType.Hero then
        --我方队员死亡统计
        if hero:getRoleType() ~= eRoleType.Assist then --助战队员不统计死亡
            statistics.deathEvent()
        end
        this.eventCheck(hero)
    elseif campType == eCampType.Call then

    elseif campType == eCampType.Other then
        EventTrigger:_onSlain(hero)
    end
end

--怪物进入扣分区域
function battleController._onPenalty(hero)
    

    return 0
end

--修正连击事假
function battleController.fixComboTime(time)
    statistics.fixComboTime(time)  
end
--连击事件
function battleController._onComboEvnet(num)
    num = num or 1
    statistics.comboEvent(num)
    --连击数显示到UI
    if statistics.combo > 1 then
        --TODO 大于一才触发连击
        EventMgr:dispatchEvent(eEvent.EVENT_SHOW_COMBO,statistics.combo,true)
        if this.isLockStep() then
            --TODO 连击数公用 组队模式下 全队事件通知连接数变更
            local heros = this.team:getMenbers(eCampType.Hero)
            for index , hero in ipairs(heros) do
                hero:onAttrTrigger(eAttrType.ATTR_COMBO ,statistics.combo)
            end
        else
            local hero = this.getCaptain()
            if hero then
                hero:onAttrTrigger(eAttrType.ATTR_COMBO ,statistics.combo)
            end
        end
    end
end

function battleController.getVictoryDecide()
    return victoryDecide
end

function battleController.getStatistics()
    return statistics
end

--关卡摄像机修正
function battleController.getGlobalFixZ()
    if this.data.cameraAmend then
        return this.data.cameraAmend
    end
    return 0
end

function battleController.getTime()
   return statistics.time
end

function battleController.fixTime(time)
    if time > statistics.time then
        statistics.time = time
        victoryDecide.fixRemainime(statistics.time)
    end
end


function battleController.getDungeonNode()
    return this.data.dungeonNodes[this.data.dungeonIndex]
end

--初始化战斗数据
function battleController.init(data)
    this.isChangeDungeon = false
    this.bTriggerJump = false
    this.cameraPos3D= me.Vertex3F(0, 0, 0)
    -- 关卡配置
    this.levelCfg_ = BattleDataMgr:getLevelCfg()
    --战斗速度缩放比
    this.timeScale  = 1
    this.data         = data
    this.team      = Team:new()
    this.nStopFrameTime  = 0
    this.nState     = eBState.BS_NOT_BEGIN
    this.bWin      = false
    this.bSlowMotion = false
    this.bSlowMotionTime = 0
    this.captain = nil --当前正在操作的角色
    KeyStateMgr.setEnable(true)
    --关卡胜利条件
    victoryDecide.init(this.data.victoryCfg, this)
--
    this.bTiming = false --关卡记时开关
    this.bAiEnabled = true --AI 开关
    statistics.init(this.data.starCfg, this)
    brushMonster:init()
    if this.isLockStepEx() then 
        local nodeData = this.getDungeonNode()
        if nodeData.pass then --通过的关卡关闭刷怪
            brushMonster:setEnabled(false)
        else
            brushMonster:setEnabled(true)
        end
    else
        brushMonster:setEnabled(true)
    end
    GuideMgr:reloadState()

    this.isClearing = false

    --组队模式下强制设置为相同的FPS
    if this.isLockStep() then
        SettingDataMgr:setFPS(LockStep.FPS)
    end
    --TODO 暂时不需要 计数增加
    -- this.comboTimmer = BattleTimerManager:addTimer(100,-1,nil,this.doComboEvent)
    -- this.showCombo    = 0
    -- this.showComboMax = 0

    --摄像机相关
    this.cameraMode   = eMode.FOLLOW
    --摄像机跟随的节点
    this.focusNode    = nil
    this.registerEvents()
    -- this.delayTest()
    AIAgent:setEnabled(true)
    AIAgent:reset()
    --读取关卡模型缩放
    ResLoader.setModalScale(this.levelCfg_.roleSize)
    this._onSettingChange()
    this.tmTimeDelayhandle = nil
    --是否需要校验伤害
    this.bNeedVerifyHurt = false
    local battleType = this.data.battleType
    if battleType == EC_BattleType.COMMON or
        battleType == EC_BattleType.ENDLESS then
        if this.levelCfg_.dungeonType ~= EC_FBLevelType.PRACTICE then
            this.bNeedVerifyHurt = true
        end
    end

    this.skillEx = nil
    this.simpleHeros = {}
end

--修正伤害值
function battleController.fixHitValue()
    if victoryDecide.nViewType == EC_LevelPassCond.SURVIVAL_HURT then 
        victoryDecide.doRefresh()
        if this.data.victoryCfg[1].victoryParam[2] then
            statistics.hitValue = math.min(statistics.hitValue,this.data.victoryCfg[1].victoryParam[2])
        end
    end
end

--是否是挑战关卡
function battleController.isDuelMode()
    return this.data.isDuelMod
end
--TODO 事件触发测试
function battleController.delayTest()
    local handle
    handle = BattleTimerManager:addTimer(20000,1,function ()
        --移动到指定位置
        -- this.cameraMoveTo(3,me.Vertex3F(300,300,600),3,3,function()
        --     -- this.setCameraMode(eMode.FOLLOW)
        --     Box("aas")
        --     end)

        -- 跟随指定目标测试
        this.setCameraMode(eMode.FOLLOW)
        this.setFocusNode(this.team:getHeros()[1]:getActor())
        BattleTimerManager:removeTimer(handle)
        Box("asdfasdf")
    end)
end

function battleController.getCameraMode()
    return this.cameraMode
end

function battleController.getFocusNode()
    if this.focusNode then
        return this.focusNode
    end
    local hero = this.getCaptain()
    if hero then
        return hero.actor
    end
end

function battleController.setFocusNode(focusNode)
    this.focusNode    = focusNode
end

function battleController.setCameraMode(mode)
    this.cameraMode    = mode
end

function battleController.getCameraPos3D()
    return this.cameraPos3D
end

function battleController.setCameraPos3D(pos)
    this.cameraPos3D = pos
end

function battleController.cameraMoveTo(moveTime,position,stayTime,backTime,callFunc)
    this.setCameraMode(eMode.MANUAL)
    EventMgr:dispatchEvent(eEvent.EVENT_CAMERA_EVENT,moveTime,position,stayTime,backTime,callFunc)
end


-- function battleController.doComboEvent()
--     -- _print("____doComboEvent____")
--     -- statistics.combo


--     if statistics.combo > this.showComboMax then
--         this.showComboMax = statistics.combo
--     end

--     if this.showCombo < this.showComboMax then
--         this.showCombo = this.showCombo + 1
--         if this.showCombo > 1 then
--             EventMgr:dispatchEvent(eEvent.EVENT_SHOW_COMBO,this.showCombo,true)
--         end
--     else
--         if this.showComboMax  > statistics.combo  then
--             this.showComboMax = statistics.combo
--             this.showCombo = 0
--         end
--     end
-- end
function battleController.getPlayer(pid)
    local hero = this.team:getHeroWithPID(pid)
    if not hero then 
        for i,v in ipairs(this.simpleHeros) do  
            if v:getData().pid == pid then 
                return v
            end
        end
    end

    return hero
end

--根据CID 查找角色(控制角色)
function battleController.getHeroWithCid(cid)
    local heros = this.team:getHeros()
    for i , hero in ipairs(heros) do
        if hero:getData().cid == cid then
            return hero
        end
    end
end

--根据pid查找角色(包含死亡角色)
function battleController.getHeroWithPid(pid)
    local heros = this.team:getHeros()
    for i , hero in ipairs(heros) do
        if hero:getPID() == pid then
            return hero
        end
    end
end

--组队模式下开启帧同步
function battleController.isLockStep()
    if this.data then
        return this.data.battleType == EC_BattleType.TEAM_FIGHT
    end
end

--组队模式下同步血量
function battleController.synchronHp(hero)
    if this.isLockStep() then
        LockStep.synchronHp(hero)
    end
end
function battleController.synchronHurtValue(hero)
    if this.isLockStep() then
        LockStep.syncHeroHurtValue(hero)
    end
end


function battleController.isTiming()
    if this.isRun() then
        if this.isLockStep() then
            return  true
        else
            if this.tmTimeDelayhandle then
                return false
            end
            return this.bTiming
        end
    end
    return false
end

--设置时间停止开始
function battleController.setTiming(bTime)
    this.bTiming = bTime
end

function battleController:getBattleData()
    return this.data
end

--创建道具
function battleController.createProp(data,pos)
    local prop = GameObject.createProp(data)
    prop:setPosition(pos)
    prop:active()
end

function battleController.getCaptain()
    return this.captain
end

--
-- function battleController.resetSyncBossState_hero_pid()
--     -- this.synBoss_pId = 
--     if this.isLockStep() then
--         local heros = this.getMenbers()
--         table.sort(heros,function ( a , b )
--             return a.data.priority > b.data.priority
--         end)
--         for i, hero in ipairs(heros) do
--             if hero:isAlive() then
--                 this.syncBossState_hero_pid =  hero.data.pid
--                 print_(" priority:"..hero.data.priority)
--                 return
--             end
--         end
--     end
-- end

-- function battleController.getSyncBossState_hero_pid()
--     return this.syncBossState_hero_pid
-- end


--當前玩家是否是隊長
function battleController.isLeader()
    return this.data.leader == MainPlayer:getPlayerId()
end

--队长PID (组队情况下才有)
function battleController.getLeaderPid()
    return this.data.leader
end
--队长ID
function battleController.setLeaderPid(leaderId)
    this.data.leader = leaderId
end
--我方队伍成员
function battleController.getMenbers()
    return this.team:getMenbers(eCampType.Hero)
end
--我方队员替补成员(包含已经死亡的)
function battleController.getBench()
    -- local heros = this.team:getHeros()
    -- local retHeros = {}
    -- for i, hero in ipairs(heros) do
    --     if hero:getRoleType() == eRoleType.Hero then
    --         -- if not hero:isActive() then
    --             retHeros[#retHeros + 1] = hero
    --         -- end
    --     end
    -- end
    return this.team:getHeros()
end


--我方队伍助战队员
function battleController.getAssist()
    return this.team:getAssist()
end

--敌方活着的成员
function battleController.getEnemyMember()
    return this.team:getMenbers(eCampType.Monster)
end

--
function battleController.getEnemyWithCID(cid)
    local enemys = this.getEnemyMember()
    for i, enemy in ipairs(enemys) do
        if enemy:getData().id == cid then
            return enemy
        end
    end
end

--根据maskID查找怪物
function battleController.getEnemyWithMaskID(maskID)
    local enemys = this.getEnemyMember()
    for i, enemy in ipairs(enemys) do
        if enemy:getData().markID == maskID then
            return enemy
        end
    end
end


--敌方成员包含整正在死亡的人
function battleController.getEnemyMember__()
    return this.team:getMenbers___(eCampType.Monster)
end

--设置队长
function battleController.setCaptain(hero)
    local oldCaptain = this.captain
    if this.captain ~= hero then
        if hero then
            musicMgr.load(hero:getData().id,hero)
            if oldCaptain then --处理队员列表
                local temp = oldCaptain.headShowIndex
                oldCaptain.headShowIndex = hero.headShowIndex
                hero.headShowIndex = temp
            end
        end
        --切换队长是重置蓄力条
        EventMgr:dispatchEvent(eEvent.EVENT_GATHER_BAR_UPDATE,3,hero)
    end
    this.captain = hero
    if oldCaptain ~= this.captain  then
        --必须在设置队长后调用
        musicMgr.playBorn()
    end
    if this.isLockStep() then --组队模式
        KeyStateMgr.setAgent(LockStep)
    else
        KeyStateMgr.setAgent(this.captain)
    end
    EventMgr:dispatchEvent(eEvent.EVENT_CAPTAIN_CHANGE)
end

function battleController.clear()
    this.timeScale    = 1
    this.data         = nil
    this.team         = nil
    this.nState     = eBState.BS_NOT_INIT
    this.bSlowMotion = false
    this.bSlowMotionTime = 0
    -- --统计相关
    statistics.clear()
    --关卡胜利条件
    victoryDecide.clear()
    this.bTiming = false --记时开关
    this.bAiEnabled = true --AI 开关
    --战斗开始(加载资源开始算)时设置为true
    this.bStart = nil

    -- 是否已经结算
    this.isClearing = false
    if this.tmTimeDelayhandle then
        BattleTimerManager:removeTimer(this.tmTimeDelayhandle)
        this.tmTimeDelayhandle = nil
    end
    this.removeEndBattleTimer()
    this.specifyMonsters = nil
    this.skillEx = nil
    -- --处理连击动画
    -- this.showCombo    = 0
    -- this.showComboMax = 0
    -- if this.comboTimmer then

    --     BattleTimerManager:removeTimer(this.comboTimmer)
    --     this.comboTimmer = nil
    -- end
end

function battleController:isRun()
    return (this.nState  == eBState.BS_RUN and not this.isClearing)
end

function battleController:needUpdate()
    return this.nState  > eBState.BS_NOT_BEGIN
end

function battleController.getMaxStage()
    local levelCfg = BattleDataMgr:getLevelCfg()
    return levelCfg.victoryParam[1][1]
end

function battleController.getHeroData()
    return this.data.heros
end

function battleController.getTeamHeroData()
    if this.data.teamType == eTeamType.ZLJH then
        local datas = {}
        for i, v in ipairs(this.data.heros) do
            if v.pid == MainPlayer:getPlayerId() then
                table.insert(datas,v)
            end
        end
        return datas
    else
        return this.data.heros 
    end
end

--查找战斗中的Boss(追猎计划使用)
function battleController.getBoss()
    local heros = this.team:getHerosEx()
    --Boss 是唯一只怪找到Boss
    local temps = {}
    for i, hero in ipairs(heros) do
        if hero:getRoleType() == eRoleType.Monster then 
            if hero:isBoss() then 
                return hero
            end
            table.insert(temps,hero)
        end
    end
    return temps[1]
end

--创建战斗结算虚拟数据(追猎计划) 
function battleController.createInventedResultData()
    local hero = this.getPlayer(MainPlayer:getPlayerId())
    local hurtValue  = hero:getData().hurtValue
    --TODO 根据伤害计算贡献值
    local data = 
    {
        invented     = true, --标识是虚拟
        fightTime    = 0,
        isSpecial    = false,
        huntingHonor = math.ceil(hurtValue*0.0001) ,
        results   = {
            [1] = {
                hurt = hurtValue,
                mvp  = false,
                pid  = MainPlayer:getPlayerId(),
                rewards = {}
            }
        }
        ,
        rewards = {
            -- [1] = {id  = 555001,num = 4},
            -- [2] = {id  = 500005,num = 10},
            -- [3] = {id  = 570029,num = 3},
            -- [4] = {id  = 500001,num = 1500},
        }
        ,
        win  = true
    }
    return data
end



function battleController.getSimpleHeros()
    return this.simpleHeros
end
function battleController.removeSimpleHero(hero)
    if this.simpleHeros then 
        table.removeItem(this.simpleHeros,hero)
        this.eventCheck(hero)
    end
end


function battleController.isTeamMemberAllDead()
    if this.isZLJH() then 
        -- Box("isTeamMemberAllDead:"..tostring(#this.simpleHeros))
        dump("isTeamMemberAllDead---------------------------:"..tostring(#this.simpleHeros))
        for i , hero in ipairs(this.simpleHeros) do
            if hero:getData().pid ~=  MainPlayer:getPlayerId() then
                print_(hero:getName()..":"..tostring(hero:isAlive()))
                if hero:isAlive() then 
                    return false  
                end
            end
        end
        dump({"isAllDead:"..tostring(this.team:isAllDead(eRoleType.Team))})
        return this.team:isAllDead(eRoleType.Team)
    else
        if this.team:isAllDead(eRoleType.Team) then
            return true 
        end
    end
end

--我方队员替补成员(包含已经死亡的)
function battleController.getTeamMembers()
    if this.data.teamType == eTeamType.ZLJH then
        return this.simpleHeros
    end
    return this.team:getHeros()
end
--是否是追猎计划
function battleController.isZLJH()
    if this.isLockStep() then
        if this.data.teamType == eTeamType.ZLJH then
            return true
        end
    end
end


function battleController.showCounDown(callFunc)
    if this.levelCfg_.countOpen then
        EventMgr:dispatchEvent(eEvent.EVENT_SHOW_COUNTDOWN, function ()
                if callFunc then
                    callFunc()
                end
            end)
    else
        if callFunc then
            callFunc()
        end
    end
end

function battleController.showWarning(callFunc)
    if not this.levelCfg_.warningTime then
        this.bTiming = false
        BattleUtils.playEffect(BattleConfig.BOSS_WARNING ,false,1)
        EventMgr:dispatchEvent(eEvent.EVENT_BOSS_WARNING, function ()
                if callFunc then
                    callFunc()
                end
                this.bTiming = true
            end)
    else
        EventMgr:dispatchEvent(eEvent.EVENT_BOSS_WARNING)
        if callFunc then
            callFunc()
        end
    end
end

--设置是否显示GOGO
function battleController.showGo(visible)
    EventMgr:dispatchEvent(eEvent.EVENT_SHOW_GO,visible)
end

function battleController.getTeam()
    return this.team
end

function battleController.start()
    --游戏速度
    this.setTimeScale( BattleConfig.DEFAULT_TIMESCALE )
    this.nState = eBState.BS_RUN
    this.bTiming = false
    this.startTimer()
    --初始化虚拟角色
    if this.data.teamType == eTeamType.ZLJH then --追猎计划
        if this.isLockStep() then 
            for i, v in ipairs(this.data.heros) do
                -- if v.pid ~= MainPlayer:getPlayerId() then --自己是否需要加入列表
                    local hero = SimpleHero:new(v)
                    table.insert(this.simpleHeros,hero)
                -- end
            end
        end
    end
    -- if not this.isLockStep() then
        EventTrigger:prevAct(handler(this.herosEnter,this))
    -- else
    --     this.herosEnter()
    -- end
end

function battleController.herosEnter()
    local data = BattleDataMgr:getBattleData()

    AIAgent:setEnabled(true)
    -- local data = this.getHeroData()
    local data = this.getTeamHeroData() --只创建出战成员
    this.team:addMember(data)
    EventMgr:dispatchEvent(eEvent.EVENT_PREWARTIP_SHOW)
    --创建
    this.team:createHeros(function()
        print_("this.team:createHeros")
        if this.nState > eBState.BS_NOT_INIT then
            this.setCameraMode(eMode.FOLLOW)
            if this.isLockStep() then
                this.setCaptain(this.team:getCaptain())
            else
                this.setCaptain(this.captain)
            end
            if this.levelCfg_.delayTime and this.levelCfg_.delayTime ~= 0 then
                this.tmTimeDelayhandle = BattleTimerManager:addTimer(this.levelCfg_.delayTime,1,function()
                    BattleTimerManager:removeTimer(this.tmTimeDelayhandle)
                    this.tmTimeDelayhandle = nil
                end,nil)
            end
            this.showCounDown(function()
                this.bTiming = true --开始计时
                EventTrigger:start()
                local levelCfg_ = BattleDataMgr:getLevelCfg()
                if levelCfg_ and levelCfg_.dungeonType == EC_FBLevelType.PRACTICE then
                    AIAgent:setEnabled(false)
                    EventMgr:dispatchEvent(EV_PRACTICE_BRUSH_MONSTER)
                end
            end)
            --队长初始化完成
            EventMgr:dispatchEvent(eEvent.EVENT_INITED_TEAM)
            this.checkAndCreateSkillEx()
        end
    end)

end

function battleController.endFight()
    this.setTimeScale(1.0)
    if this.team then
        this.team:clearAllBuff()
        this.team:realeaseHeros()
    end
    BattleMgr.clear()
    this.removeTimer()
end

--战斗的速度缩放
function battleController.setTimeScale(timeScale)
    this.timeScale = timeScale
end

function battleController.getTimeScale()
    return this.timeScale
end
--慢镜头
function battleController.setSlowMotion(slowMotion)
    this.bSlowMotion = slowMotion
    if this.bSlowMotion then
        this.setTimeScale(BattleConfig.MOTION_TIMESCALE)
        this.bSlowMotionTime = BattleConfig.MOTION_TIME
    else
        this.setTimeScale(BattleConfig.DEFAULT_TIMESCALE)
        this.bSlowMotionTime = 0
    end
    -- printError("setSlowMotion")
end

function battleController.isSlowMotion()
    return this.bSlowMotion
end

function battleController.handlSlowMotion(delta)
    if this.bSlowMotion then
        if this.bSlowMotionTime <= 0 then
            this.setSlowMotion(false)
            return
        end
        this.bSlowMotionTime = this.bSlowMotionTime - delta
    end
end


--战斗是否将要结束
function battleController.isWillEnd()
    return false
    -- return brushMonster:isWillEnd()
end


function battleController.resumeFight()
    this.team:startfight()
end


-- 1最大血量
-- 52当前血量 
-- {
        -- [3250]= --怪物ID
        -- {
        --     [1] = 20000, --属性ID  属性值
        --     [52] = 5000,
        -- }
-- }

--指定怪的属性
function battleController.setSpecifyMonster(data)
    this.specifyMonsters = data
end

--获取怪的
function battleController.getSpecifyMonsterInfo(cid)
    if this.specifyMonsters then 
        return this.specifyMonsters[cid]
    end
end

function battleController.requestFightStart(...)
    -- dump({...})
    local data = {...}
    FubenDataMgr:send_DUNGEON_FIGHT_START(...)
    this.specifyMonsters = nil
end

function battleController.stopSynchronizeTimer()
    if this.synchronizeTimerID then
        TFDirector:removeTimer(this.synchronizeTimerID)
        this.synchronizeTimerID  = nil
    end
end

function battleController.requestFightingOver()
    local isWin = this.bWin
    --非組隊
    local battleType = BattleDataMgr:getBattleType()
    local levelCfg = BattleDataMgr:getLevelCfg()
    if battleType == EC_BattleType.COMMON then
        local levelId = BattleDataMgr:getPointId()
        local reachStar = statistics.calReachStar()
        local pickUpTypeCount = statistics.pickUpTypeCount
        local pickUpCount     = statistics.pickUpCount
        local maxComboNum     = statistics.maxComboNum
        local killTargets = victoryDecide.getKillTargets()
        local hitValue = statistics.hitValue
        local rating   = victoryDecide.getRating()
        local skillEnemy = {}
        if statistics.skillEnterKill > 0 then
          table.insert(skillEnemy,{eSkillType.ENTER, statistics.skillEnterKill})
        end
        if statistics.skillAwakeKill > 0 then
          table.insert(skillEnemy,{eSkillType.AWAKE, statistics.skillAwakeKill})
        end
        if levelCfg.dungeonType == EC_FBLevelType.PRACTICE or
                levelCfg.dungeonType == EC_FBLevelType.NOOBSUMMON then
            
        else
            battleController.sendVerifyFightResult(isWin)
            local costTime = math.floor(this.getTime())
            FubenDataMgr:send_DUNGEON_FIGHT_OVER(levelId, isWin, reachStar,
                                                 maxComboNum, pickUpTypeCount,
                                                 pickUpCount, killTargets, costTime, hitValue,rating,skillEnemy)
        end
    elseif battleType == EC_BattleType.ENDLESS then
        local levelCid = BattleDataMgr:getPointId()
        local levelCfg = BattleDataMgr:getLevelCfg()
        local costTime = math.floor(this.getTime())
        local maxComboNum     = statistics.maxComboNum
        local hitValue = statistics.hitValue
        local hpPercent = {}
        for i, v in ipairs(this.team:getHeros()) do
            local hp = 10000
            if FubenDataMgr:isEndlessRacingMode(levelCid) then
                if costTime < levelCfg.time * 1000 then
                    hp = math.floor(v:getHpPercent())
                    if hp > 0 then
                        hp = math.min(hp + levelCfg.hpRecover, 10000)
                    end
                else
                    hp = FubenDataMgr:getEndlessHeroHpPercent(v.data.id)
                end
            end
            table.insert(hpPercent, {v.data.id, hp})
        end
        battleController.sendVerifyFightResult(isWin)
        FubenDataMgr:send_ENDLESS_CLOISTER_REQ_PASS_STAGE_ENDLESS(levelCid, costTime, hpPercent, isWin, maxComboNum, hitValue)
    elseif battleType == EC_BattleType.TEAM_FIGHT then --组队模式
        local memberData = {}
    --伤害统计
        for i, heroData in ipairs(this.data.heros) do
            table.insert(memberData,{heroData.pid,heroData.hurtValue})
        end
        local data = {
            this.data.randomSeed,
            isWin,
            memberData,
            statistics.time,
            statistics.getMaxComboNum(),
            statistics.killNum,   -- 击杀总人数
            statistics.killBossNum , --击杀Boss数量
        }
        dump(data)
        _print("发送组队战斗结束请求")
        --通知组队战斗结束
        TeamFightDataMgr:requestChasmFight(data)
    end
end
--创建战斗场景(进入战斗)
function battleController.enterBattle(data, ...)
    this.lastSceneName = "default"
    local scene = Public:currentScene()
    if scene  then 
        this.lastSceneName = scene.__cname 
    end
    -- 切换到战斗场景
    if this.bStart then
        this.exitBattle()
    end
    this.bStart = true
    this.nStartTime = BattleUtils.gettime() --战斗开始时间
    BattleDataMgr:setServerData(data, ...)
    local data = BattleDataMgr:getBattleData()
    ResLoader.loadAllRes(data , function()
        this.init(data)
        this.changeToBattleScene()
    end)
end

--
function battleController.changeToBattleScene()
    TFAudio.stopAllEffects()
    BattleUtils.playMusic(this.data.bgm, true)
    AlertManager:changeScene(SceneType.BATTLE)
end

--创建战斗场景(进入组队战斗)
function battleController.enterTeamBattle(sData, ...)
    this.lastSceneName = "default"
    local scene = Public:currentScene()
    if scene  then 
        this.lastSceneName = scene.__cname 
    end
    -- 切换到战斗场景
    if this.bStart then
        this.exitBattle()
    end
    this.bStart = true
    BattleDataMgr:setServerTeamData(sData, ...)
    local data = BattleDataMgr:getBattleData()
    this.init(data)
    --连接组队服务器
    LockStep.reset()
    LockStep.setUDPCfg(data.fightServerHost,data.fightServerPort)
    LockStep.connect()--创建KCP链接
    ResLoader.loadAllRes(data , function()
            -- TFAudio.stopAllEffects()
            -- BattleUtils.playMusic(data.bgm, true)
            -- AlertManager:changeScene(SceneType.BATTLE)
            -- LockStep.reset()
            -- LockStep.setUDPCfg(data.fightServerHost,data.fightServerPort)
                    -- this.changeToBattleScene()

    end)
end


--TODO重先进入战斗场景
function battleController.reEnterTeamBattle(index,resTime)
    this.isChangeDungeon = true
    --重先组织角色数据
    local node  = this.data.dungeonNodes[this.data.dungeonIndex]
    node.pass   = true --通关
    local sData = BattleDataMgr:getServerData()
    local data = BattleDataMgr:resetServerData(sData,this.data.dungeonNodes,index,this.data.leader)
    data.heros = {}
    local heros = this.team:getHeros()
    for i,hero in ipairs(heros) do
        local heroData = hero:getData()
        local hp = hero:getHp()
        if hp == 0 then
            heroData.__hp = nil
        else
            heroData.__hp = hp
        end
        table.insert(data.heros,heroData)
    end
    --清理当前战斗
    this.exitBattle()
    levelParse:clean()
    AlertManager:changeScene(SceneType.TRANSITION)
    --延迟切换到战斗场景
    local timerHandle
    timerHandle = TFDirector:addTimer(500, 1, nil, function ()
        TFDirector:removeTimer(timerHandle)
        local data = BattleDataMgr:getBattleData()
        local maxComboNum = statistics.maxComboNum
        local killNum     = statistics.killNum   -- 击杀总人数
        local killBossNum = statistics.killBossNum --击杀Boss数量
        local time        = statistics.time        
        this.init(data)
        statistics.maxComboNum = maxComboNum
        statistics.killNum     = killNum  -- 击杀总人数
        statistics.killBossNum = killBossNum --击杀Boss数量
        statistics.time        = time
        victoryDecide.setRemainime(resTime)
        LockStep.discardingUselessframes() --TODO 丢弃无用帧数据
        battleController.changeToBattleScene()
    end) 

end



function battleController._endBattle()
    --战斗结束音效
    musicMgr.playEndOfBattle(this.bWin)
    EventMgr:dispatchEvent(eEvent.EVENT_SHOW__STACE_CLEAR, function()
        this.requestFightingOver()
    end)
    HeroDataMgr:changeDataToSelf()
    --向服务发送战斗结束请求
    --this.requestFightingOver()
end

--移除
function battleController.removeEndBattleTimer()
    if this.endBattleTimer then
        BattleTimerManager:removeTimer(this.endBattleTimer)
        this.endBattleTimer = nil
    end
end

--结束战斗
function battleController.endBattle(bWin)
    --printError("endBattle")
    if this.isZLJH() then --追猎技术啊没有失败默认胜利
        bWin = true
    end
    if this.isClearing then return end
    if bWin then 
        if this.isLockStepEx() then 
            local nodeData = this.getDungeonNode()
            if not nodeData.last then
                --复活死亡角色(防止队长死亡无法带入下一个关卡)
                local playerId = MainPlayer:getPlayerId()
                local hero     = battleController.getPlayer(playerId)
                if hero:isDead() then 
                    LockStep.sendRelive()
                    EventMgr:dispatchEvent(EV_TEAM_FIGHT_FIGHT_REVIVE)
                end
                --激活跳轉點
                EventMgr:dispatchEvent(eEvent.EVENT_CHANGE_JUMPPOINT_STATE,1) 
                EventMgr:dispatchEvent(eEvent.EVENT_SHOW_CHANGE_DUNGEON)
                return 
            end 
        end
    end

    victoryDecide.doRefresh()
    victoryDecide.stopReduceTimer()
    this.isClearing = true
    this.bWin = bWin
    KeyStateMgr.setEnable(false)
    this.stopSynchronizeTimer()
    this.team:clearAllBuff()
    if this.bWin == false then
        this._endBattle()
        return false
    end
    local count = 1
    this.removeEndBattleTimer()
    this.endBattleTimer = BattleTimerManager:addTimer(500,-1,nil,function()
        if this.team:isPlayedEndAction(eCampType.Hero) or count > 4 then
            this.removeEndBattleTimer()
            this._endBattle()
        end
        count = count + 1
    end)
end

--TODO 组队战斗结束处理
function battleController.forceEndBattle(bWin,callFunc)
    _print("forceEndBattle")
    if this.isClearing then return end
    this.isClearing = true
    KeyStateMgr.setEnable(false)
    this.stopSynchronizeTimer()
    if bWin then
        --胜利音效
        musicMgr.playVertigo()
    else
        --失败音效
        musicMgr.playDefeat()
    end
    local battleType = BattleDataMgr:getBattleType()
    this.bWin = bWin
    EventMgr:dispatchEvent(eEvent.EVENT_SHOW__STACE_CLEAR, function ()
            if callFunc then
                callFunc()
            end
        end)
    HeroDataMgr:changeDataToSelf()
    this.team:clearAllBuff()
end

function battleController.startTimer()
    this.bStartTime = true
end

function battleController.removeTimer()
    this.bStartTime = false
end
--胜负判定
function battleController.isWin()
    return this.bWin
end

function battleController.pause()
    BattleMgr.pause()
    KeyStateMgr.setEnable(false)
    EventMgr:dispatchEvent(eEvent.EVENT_PAUSE,true)
end

function battleController.resume()
    BattleMgr.resume()
    KeyStateMgr.setEnable(true)
    EventMgr:dispatchEvent(eEvent.EVENT_RESUME)
end
function battleController.skillExUpdate(delta)
    if this.skillEx then 
        this.skillEx:update(delta)
    end
end
function battleController.update(delta)
    -- print("xxxxxxxxxxxbattleCtrl.updatexxxxxxxxx")
    -- delta = delta*1000
    if not this.bStartTime  then
        return
    end
    -- this.handlCombo(delta)
    this.team:update(delta)
    levelParse:update(delta)
    BattleTimerManager:update(delta*0.001)
    --道具更新
    BattleMgr.update(delta)
    this.handlSlowMotion(delta)
    this.skillExUpdate(delta)
    if this.isTiming() then
        --关卡挑战统计
        statistics.update(delta)
        --胜负判定
        victoryDecide.update(delta)
        --音效触发
        musicMgr.update(delta)
    end
    -- 刷怪
    brushMonster:update(delta)
    if BattleGuide:isGuideStart() then
        BattleGuide:update(dt)
    end
end
function battleController.handlStopFrame(delta)
    --定贞处理
    if this.nStopFrameTime > 0  then
        this.nStopFrameTime = this.nStopFrameTime - delta
        return true
    end
end

--攻击定贞处理
function battleController.setStopFrame(time)
    if this.isLockStep() then --TODO 组队不做定贞处理
        return
    end
    this.nStopFrameTime = time
end

function battleController.free()

end

--下一阶段
function battleController.nextState()
    victoryDecide.nextState()
end

--下一波次
function battleController.nextWave()
    victoryDecide.nextWave()
end

--设置波次
function battleController.setWave(wave)
    victoryDecide.setWave(wave)
end

function battleController.eventCheck(hero)
    if not this.isRun() then
        return
    end
    --队员死亡
    if this.isLockStep() then
        if this.isTeamMemberAllDead() then 
            this.endBattle(false)
        end
    else
        --木桩副本只要有角色死亡直接结束战斗
        if this.levelCfg_.dungeonType == EC_FBLevelType.PRACTICE then
            if hero:getCampType() == eCampType.Hero then
                this.endBattle(false)
            end
        else
            if this.team:isAllDestoryByRoleType(eRoleType.Hero,eRoleType.Team) then
                this.endBattle(false)
            end
        end
    end
end


function battleController.getAirwall()
    return levelParse:getCameraRect()
end

--TODO 可行走区域
function battleController.getMoveRect()
    return  levelParse:getMoveRect()
end

function battleController.getMaxCameraHeight()
    return levelParse:getSceneHeight()
end

--检查垂直方向的范围
--返回超出的值
--TODO 该函数用于折射处理
function battleController.checkVertical(posy)
    local rect = this.getMoveRect()
    local origin = rect.origin
    local size   = rect.size
    --垂直方向的检查
    if posy < origin.y then
        -- pos.y = origin.y
        return 1 , posy - origin.y
    elseif posy > origin.y + size.height then
        -- pos.y = origin.y + size.height
        return 2 , origin.y + size.height - posy
    end
    return 0 , 0
end

function battleController.isOverflowAirWall(pos)
    local rect = this.getMoveRect()
    local origin = rect.origin
    local size   = rect.size
    --垂直方向的检查
    local bottomVertical = pos.y <= origin.y
    local topVertical = pos.y >= origin.y + size.height
    -- 水平方向检查
    local leftHorizontal = pos.x <= origin.x + BattleConfig.SPACE_AIRWALL
    local rightHorizontal = pos.x >= origin.x + size.width - BattleConfig.SPACE_AIRWALL
    return leftHorizontal, rightHorizontal, bottomVertical, topVertical
end

function battleController.getMaxComboNum()
    return statistics.maxComboNum
end
--当前连击数
function battleController.getComboNum()
    return statistics.combo
end



function battleController.exitBattle()
    this.pause()
    this.endFight()
    this.clear()
    AwakeMgr.clean()
    ResLoader.clean()
    musicMgr.clean()
    -- BattleMgr:removeScheduleAndActionMgr( )
    if not this.isChangeDungeon then 
        LockStep.clean()
    end

    EventTrigger:clearTriggers()
    BattleTimerManager.model:reset()
    this.captain = nil
    this.stopSynchronizeTimer()
    this.removeEvents()
end

--检查当前是否有主动技能
function battleController.checkAndCreateSkillEx()
    local data = BattleDataMgr:getLevelCfg()
  --天梯
    if data.dungeonType == EC_FBLevelType.SKYLADDER then
        local usingCards = SkyLadderDataMgr:getUsingCards()
        for k,v in ipairs(usingCards) do
            local cardInfo = SkyLadderDataMgr:getOwnedCardByID(v)
            local cardCfg  = SkyLadderDataMgr:getRankMatchCardCfg(v)
            if cardCfg and cardInfo then
                if cardCfg.abilityType == 2 then --主动技能
                    local buffCid = cardCfg.skill[cardInfo.cardLv]
                    if buffCid then
                        local buffCfg = TabDataMgr:getData("RankMatchBuff", buffCid)
                        this.skillEx = SkillEx:new(cardCfg,clone(buffCfg.buffId))
                    end

                    return
                end
            end
        end
    end
end

--获取关卡加成buffer
function battleController.getPointBuffer(targetType)
    local bufferIds = {}
    local data = BattleDataMgr:getLevelCfg()
    for index , _targetType in ipairs(data.limitTargetType) do
        if _targetType == targetType then
            table.insert(bufferIds,data.limitAttributes[index])
        end
    end

    -- 无尽竞速模式buff
    local endlessBuff = BattleDataMgr:getRacingEndlessBuff()
    for i, v in ipairs(endlessBuff) do
        local buffCfg = TabDataMgr:getData("EndlessBuff", v)
        if buffCfg.limitTargetType == targetType then
            table.insertTo(bufferIds, buffCfg.buffId)
        end
    end

    --卡巴拉buff
    if data.dungeonType == EC_FBLevelType.KABALATREE then
        local kabalaBuffs = KabalaTreeDataMgr:getKabalaBuffs()
        for k,v in ipairs(kabalaBuffs) do
            local buffCfg = TabDataMgr:getData("Kabalabuff", v.buffCid)
            if buffCfg.limitTargetType == targetType then
                if buffCfg.timerType == 2 and buffCfg.timerTypeParam - v.useCount > 0 then
                    table.insertTo(bufferIds, buffCfg.buffID)
                elseif buffCfg.timerType == 1 then
                    table.insertTo(bufferIds, buffCfg.buffID)
                end
            end
        end
    end

    --天梯
    if data.dungeonType == EC_FBLevelType.SKYLADDER then
        local skyLadderbuff = SkyLadderDataMgr:getSkyLadderBuff()
        for k,v in ipairs(skyLadderbuff) do
            local buffCfg = TabDataMgr:getData("RankMatchBuff", v)
            if buffCfg.limitTargetType == targetType then
                table.insertTo(bufferIds, buffCfg.buffId)
            end
        end
    end

    local halloweenBuffs = ActivityDataMgr2:getHalloweenBuffIsActivity(data.id)
    for k,v in pairs(halloweenBuffs) do
        local buffCfg = TabDataMgr:getData("HalloweenBuff", v)
        if buffCfg.limitTargetType == targetType then
            table.insertTo(bufferIds, buffCfg.buffId)
        end
    end

    --追猎计划组队效果
    if this.isZLJH() then
        local menbers = #this.data.heros
        local buffers = LeagueDataMgr:getBuffers(menbers)
        for i, v in ipairs(buffers) do
            local buffCfg = TabDataMgr:getData("HuntingBuff", v)
            if buffCfg.limitTargetType == targetType then
                table.insertTo(bufferIds, buffCfg.buffId)
            end
        end
    end
    return bufferIds
end

function battleController.initEndless()
    statistics.resetEndless()
end
--气浪特效强度
function battleController.getBlastLevel()
    return SettingDataMgr:getBattleBlurVal()
end

--模糊特效强度
function battleController.getBlurLevel()
    return SettingDataMgr:getBattleBlurVal()
end

--设置切换角色全局CD
function battleController.setSwitchCaptainGlobalCD()
    local heros = this.team:getMenbers(eCampType.Hero) --不包括死亡的队员
    for k , hero in ipairs(heros) do
        if hero.countDown then
            hero.countDown:addGlobalCD(1500)
        end
    end
end

--寻路
function battleController.findPath(hero,postion)
    local start = hero:getPosition()
    -- _print("_findPath:",start ,postion)
    return levelParse:find(start, postion)
end

--检查区域是否可行走
function battleController.canMove(x,y)
    return levelParse:canMove(x,y)
end
--指定区域随机生成位置
function battleController.randomPos(rect)
    return levelParse:randomPos(rect)
end

--激活助战
function battleController.activateAssit()
    local captain = this.getCaptain()
    local hero = this.team:getAssist()
    if hero and hero:isAlive() and not hero:isBattle() then
        hero:addToBattle()
        local tarPos = captain:getPosition()
        hero:setPosition3D(tarPos.x,tarPos.y,tarPos.y)
        -- hero:setDir(dir)
        hero.actor:show()
        hero.actor:setOpacity(255)
        hero.actor.skeletonNode:show()
        hero:castByType(eSkillType.ENTER)
        --助战报幕
        EventMgr:dispatchEvent(eEvent.EVENT_SHOW_ASSIT,hero)
    end
end

local eSummonType =
{
    RandomPos   = "RandomPos",
    OrderPoint  = "OrderPoint",
    RandomPoint = "RandomPoint"
}
--创建障碍物
function battleController.onCreateObstacle(data,params)
    local points = {}
    local obstacleIds = {}
    if data.DestroiableID and #data.DestroiableID > 0 then
        obstacleIds = string.split(data.DestroiableID, ",")
    end
    local summonType  = data.SummonType

    dump(data)
    dump(params)
    dump(obstacleIds)

    if summonType == eSummonType.RandomPos then --随机位置
        points = {}
        for index = 1 , #obstacleIds do
            points[index] = levelParse:randomBonePos() --随机空气墙以内的位置
        end
    elseif summonType == eSummonType.OrderPoint then
        --啥也不需要干
        points = params[1]
    elseif summonType == eSummonType.RandomPoint then
        points = BattleUtils.shuffle(params[1])
    end
    for index , id in ipairs(obstacleIds) do
        -- local node = ResLoader.createEffect("fight_2011",0.5)  --Node:create()
        -- node:play("born", 1)
        -- node:setPosition(points[index])

        local data     = TabDataMgr:getData("MapBarrier",tonumber(id))
        if not data then
            Box("ASDFSD::"..tostring(id))
        end
        local obstacle = GameObject.createObstacle(data)
        obstacle:setPosition(points[index])
        obstacle:active()
    end
end


--是否需要校验伤害
function battleController.isNeedVerifyHurt( )
    return this.bNeedVerifyHurt
end

--伤害检查统计
function battleController.sendVerifyHurt(data) 
    -- dump(data)   
    TFDirector:send(c2s.DUNGEON_REQ_VERIFY_HURT, data)
end

function battleController.sendVerifyFightResult(isWin)
    if not isWin then
        return
    end
    if victoryDecide.nViewType ~= EC_LevelPassCond.SURVIVAL then
        local data = {}
        data[1] ={}
        for k,v in pairs(statistics.skillCountTab) do
            table.insert(data[1],{k,v})
        end
        data[2] = {}--怪物
        for k ,v in pairs(statistics.monsterInfos) do
            for level ,num in pairs(v) do
                table.insert(data[2],{k,level ,num})
            end
        end  
   
        if this.isDuelMode() then
            data[3] = (statistics.monsterLoseHp*2)   --怪物扣除总血量
            data[4] = statistics.hitIimes  --'int64':hurtCount [总伤害次数]
            data[5] = (statistics.hitValue*2) --'int64':hurt  [总伤害]
        else
            data[3] = statistics.monsterLoseHp   --怪物扣除总血量
            data[4] = statistics.hitIimes  --'int64':hurtCount [总伤害次数]
            data[5] = statistics.hitValue  --'int64':hurt  [总伤害]
        end
        -- dump(data)
        -- Box("发送战斗结果检查")
        TFDirector:send(c2s.DUNGEON_REQ_VERIFY_FIGHT_RESULT, data)
    end
end

function battleController.isShowAttackEffect(hero)
    if hero:getRoleType() == eRoleType.Team then 
        if battleController.getCaptain() ~= hero then
            return SettingDataMgr:getAttactEffectVal()
        end
    end
    return true
end

--队友是否创建特效
function battleController.isCreateEffect(hero)
    -- if hero:getRoleType() == eRoleType.Team then 
    --     if battleController.getCaptain() ~= hero then
    --         return SettingDataMgr:getAttactEffectVal()
    --     end
    -- end
    return true
end

function battleController.isShowFixHurt()
    if this.data and this.data.teamType ~= 5 then --排除追猎计划
        return not SettingDataMgr:getAttactEffectVal()
    end
end

--应用切换到后台时间派发
TFDirector:addMEGlobalListener("applicationDidEnterBackground", function()
    EventMgr:dispatchEvent("applicationDidEnterBackground")
end)
--注册事件
return battleController
