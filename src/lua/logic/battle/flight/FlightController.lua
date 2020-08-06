local BattleUtils        = import("..BattleUtils")
local statistics         = import("..Statistics")
local musicMgr           = import("..MusicMgr")
local ResLoader          = import("..ResLoader")
local KeyStateMgr        = import("..KeyStateMgr")
local victoryDecide      = import("..VictoryDecide")
local BattleMgr          = import("..BattleMgr")
local BattleTimerManager = import("..BattleTimerManager")
local EventTrigger       = import("..EventTrigger")
local enum               = import("..enum")
local levelParse         = import("..LevelParse")
local AIAgent            = import("..AIAgent")
local FlightBrushMonster = import(".FlightBrushMonster")
local PlayerCaptain      = import(".PlayerCaptain")
local ObjectPool         = import(".ObjectPool")

local heroMgr            = BattleMgr.getHeroMgr()
local eGuideAction       = enum.eGuideAction
local eEvent             = enum.eEvent

local flightController          = {}

local function onSlain(hero)
    if hero:getData().roleType == 1 then
        statistics.deathEvent()
        flightController.endBattle(false)
    else
        statistics.doSlain()
    end
end

local function onNoticeHp(hp)
    statistics.hpEvent(math.abs(hp))
end

local function onLoseHp(hp)
    statistics.loseHPEvent(hp)
    musicMgr.playInjured(hp)
end

local function onPickUp(data)
    statistics.pickUpEvent(data.type)
end

local function onBeaten()
    statistics.hitEvent()
end

local function onScore(score)
    statistics.scoreEvent(score)
end

local function hitTest(bullet)
    ---@type CaptainBase
    local player       = flightController.player
    ---@type CaptainBase
    local attacker     = bullet.owner.owner
    local colliderName = bullet.owner.cfg.cfg.colliderName
    local bulletBox    = bullet:getBoundingBox2(colliderName)
    local hitEffect    = bullet.owner.cfg.cfg.hitEffect
    local recycle      = false
    --if #bulletBox == 0 then Box(bullet.owner.cfg.cfg.bullet) end
    if attacker == player then
        local heroes  = heroMgr:getObjects()
        for _, role in ipairs(heroes) do
            if attacker ~= role then
                local roleBox = role:getBoundingBox("bdbox")
                if role:isDebuted() and not role:isOffStage() and me.rectIntersectsRect(roleBox, bulletBox) then
                    if not tolua.isnull(bullet.owner) then
                        --local pos  = BattleUtils.rectCenterPoint(roleBox)
                        local position3D = role:getPosition()
                        local pos = ccp(position3D.x, position3D.y)
                        local args = { hurt       = -attacker:getAtkHurt(bullet.owner.cfg),
                                       attacker   = attacker,
                                       effectName = hitEffect and hitEffect.effectName,
                                       scale      = hitEffect and hitEffect.scale or 1,
                                       actionName = hitEffect and hitEffect.actionName,
                                       pos        = (hitEffect and hitEffect.offset) and pos + hitEffect.offset or pos
                        }
                        role:doEvent(enum.eFlightStateEvent.BH_HIT, args)
                    else
                        Box("HIT TEST", "Attacker is player")
                    end
                    if not bullet.CanPenet then
                        bullet.extInfo = {}
                        BulletCache:Recycle(bullet) -- 子弹是否穿透
                        recycle = true
                    end
                end
            end
        end
    else
        local playerBox = player:getBoundingBox("bdbox")
        if player:isDebuted() and not player:isOffStage() and me.rectIntersectsRect(playerBox, bulletBox) then
            if not tolua.isnull(bullet.owner) then
                --local pos = BattleUtils.rectCenterPoint(playerBox)
                local position3D = player:getPosition()
                local pos = ccp(position3D.x, position3D.y)
                local args = { hurt       = -attacker:getAtkHurt(bullet.owner.cfg),
                               attacker   = attacker,
                               effectName = hitEffect and hitEffect.effectName,
                               scale      = hitEffect and hitEffect.scale or 1,
                               actionName = hitEffect and hitEffect.actionName,
                               pos        = (hitEffect and hitEffect.offset) and pos + hitEffect.offset or pos
                }
                player:doEvent(enum.eFlightStateEvent.BH_HIT, args)
            else
                Box("HIT TEST", "Attack is monster")
            end
            if not bullet.CanPenet then
                bullet.extInfo = {}
                BulletCache:Recycle(bullet) -- 子弹是否穿透
                recycle = true
            end
        end
    end

    if not recycle then
        local enemy
        if bullet.isFindAlways then
            local target = bullet.extInfo.target
            if not target or target:isOffStage() or target:isDead() then
                if bullet.ChooseTarget == 0 then
                    enemy = attacker:findNearestEnemy()
                elseif bullet.ChooseTarget == 1 then
                    enemy = attacker:findRandomEnemy()
                end
            else
                enemy = target
            end
            bullet.extInfo.target = enemy
            if enemy then
                BulletCache:AimAtPos(bullet, enemy:getCenterPoint())
            else
                bullet.extInfo = {}
            end
        end
    end
end

local function onOffStage(captain)
    flightController.offStages[#flightController.offStages+1] = captain
    flightController.startOffStageTimer()
end

function flightController.registerEvents()
    EventMgr:addEventListener(flightController, eEvent.EVENT_HERO_DEAD, onSlain)
    --统计相关
    EventMgr:addEventListener(flightController, eEvent.EVENT_NOTICE_HP, onNoticeHp)
    EventMgr:addEventListener(flightController, eEvent.EVENT_LOSE_HP, onLoseHp)
    EventMgr:addEventListener(flightController, eEvent.EVENT_GETHIT, onBeaten)
    EventMgr:addEventListener(flightController, eEvent.EVENT_PICKUP, onPickUp)
    EventMgr:addEventListener(flightController, eEvent.EVENT_CAPTAIN_OFFSTAGE, onOffStage)
    EventMgr:addEventListener(flightController, eEvent.EVENT_KILL_SCORE, onScore)
    --EventMgr:addEventListener(this, eEvent.EVENT_SKILL_ENTER_KILL, this._onSkillEnterKill)
    --EventMgr:addEventListener(this, eEvent.EVENT_HERO_BATTLE, this._onHeroBattle)
    EventMgr:addEventListener(flightController, EV_BATTLE_END_TRIGGER_EVENT, flightController.endBattle)
    EventMgr:addEventListener(flightController, eEvent.EVENT_PAUSE, function (value)
    end)

    EventMgr:addEventListener(flightController, eEvent.EVENT_MAP_SCROLL_SWITCH, function (value)
        flightController.mapScroll = value
    end)

    BulletCache:SetBulletPositionChangeHandle(hitTest)
end

function flightController.removeEvents()
    EventMgr:removeEventListenerByTarget(flightController)
    BulletCache:SetBulletPositionChangeHandle(nil)
end

function flightController.init(data)
    flightController.flightMode = true
    flightController.fixZEye = me.Director:getZEye() * 0.15
    flightController.data      = data
    --flightController.timeLine  = 0
    flightController.timeScale = 1.0
    flightController.offStages = {}

    flightController.started   = false
    flightController.paused    = false
    flightController.bTiming   = false -- 计时器开关
    flightController.mapScroll = false
    flightController.cameraPos3D = me.Vertex3F(0, 0, 0)
    KeyStateMgr.setEnable(true)
    statistics.init(data.starCfg, flightController)
    victoryDecide.init(data.victoryCfg, flightController)
    flightController.registerEvents()
    FlightBrushMonster.init()
    flightController.cameraMode = enum.eMode.FOLLOW
    BulletCache:Resume()
    AIAgent:setEnabled(true)
end

function flightController:isRun()
    return flightController.started and not flightController.paused
end

function flightController.isLockStep()
    return false
end


--设置时间停止开始
function flightController.setTiming(bTime)
    flightController.bTiming = bTime
    if not bTime then
        FlightBrushMonster.pause()
        flightController.mapScroll = false
        if flightController.player then
            flightController.player:ceasefire()
        end
    else
        FlightBrushMonster.resume()
        flightController.mapScroll = true
        if flightController.player then
            flightController.player:fire()
        end
    end
end
function flightController.getGlobalFixZ()
    return flightController.fixZEye --flightController.data.cameraAmend or 0
end

function flightController.getAirwall()
    return levelParse:getCameraRect()
end

function flightController.getCameraMode()
    return flightController.cameraMode
end

function flightController.setCameraMode(mode)
    flightController.cameraMode = mode
end

function flightController.getMoveRect()
    return  levelParse:getMoveRect()
end

function flightController.getMaxCameraHeight()
    return levelParse:getSceneHeight()
end

function flightController.getTime()
    --return flightController.timeLine
    return statistics.time
end

function flightController.setTimeScale(timeScale)
    flightController.timeScale = timeScale
end

function flightController.getTimeScale()
    return flightController.timeScale
end

function flightController.getCaptain()
    return flightController.player
end

function flightController.getEnemyMember()
    local result = {}
    local heroes = heroMgr:getObjects()
    for _, hero in ipairs(heroes) do
        if hero:getData().roleType ~= enum.eRoleType.Hero then
            result[#result+1] = hero
        end
    end
    return result
end

--兼容处理
flightController.getEnemyMember__= flightController.getEnemyMember

function flightController.setFocusNode(node)
    flightController.focusNode = node
end

function flightController.getFocusNode()
    if flightController.focusNode then
        return flightController.focusNode
    else
        ---@type CaptainBase
        local hero = flightController.getCaptain()
        if hero then
            return hero.fighter
        end
    end
end

function flightController.getCameraPos3D()
    return flightController.cameraPos3D
end

function flightController.setCameraPos3D(pos)
    flightController.cameraPos3D = pos
end

function flightController.cameraMoveTo(moveTime,position,stayTime,backTime,callFunc)
    flightController.setCameraMode(enum.eMode.MANUAL)
    EventMgr:dispatchEvent(eEvent.EVENT_CAMERA_EVENT,moveTime,position,stayTime,backTime,callFunc)
end

function flightController.update(delta)
    if not flightController.started then
        return
    end
    BattleTimerManager:update(delta*0.001)
    if flightController.paused then
        return
    end
    BattleMgr.update(delta)

    if flightController.bTiming then
        --flightController.timeLine = flightController.timeLine + delta
        statistics.update(delta)
        victoryDecide.update(delta)
    end
    ---@type PlayerCaptain
    local player = flightController.player
    if player and BattleDataMgr:getLevelCfg().fightingMode == 3 then --TODO FIX
        local playerBox = player:getCollisionWithName("bdbox")
        local yRoller =  player:getYRoller()
        local playerY = player:getPosition().y
        for _, role in ipairs(heroMgr:getObjects()) do
            local roleBox = role:getCollisionWithName("bdbox")
            local targetY = role:getPosition().y
            if playerY+(yRoller[1] or 0) >= targetY and playerY-(yRoller[2] or 0 ) <= targetY and player ~= role and role:isDebuted() and not role:isOffStage() and role:isAlive() and BattleUtils.isPolygonInterSection(roleBox, playerBox)  then
                local pos = BattleUtils.polygonCenterPoint(roleBox)
                local bumpEffect = player:getBumpEffect()
                local args  = {
                    hurt       = -player:getAtkHurt(),
                    attacker   = player,
                    deadAction = enum.eFlightAnimation.DIE,
                    effectName = bumpEffect and bumpEffect.effectName,
                    scale      = bumpEffect and bumpEffect.scale or 1,
                    actionName = bumpEffect and bumpEffect.actionName,

                    pos        = (bumpEffect and bumpEffect.offset) and pos + bumpEffect.offset or pos,
                    delayed    = true
                }
                role:doEvent(enum.eFlightStateEvent.BH_HIT, args)
            end
        end
    end
end

function flightController.pause()
    flightController.paused = true
    BattleMgr.pause()
    BulletCache:Stop()
    KeyStateMgr.setEnable(false)
end

function flightController.resume()
    flightController.paused = false
    BattleMgr.resume()
    BulletCache:Resume()
    KeyStateMgr.setEnable(true)
end

function flightController.getAssist()
    return nil
end

function flightController.start()
    flightController.started = true
    flightController.bTiming = false
    flightController.startSynchronizeTimer()
    EventTrigger:prevAct(function()
        EventMgr:dispatchEvent(eEvent.EVENT_PREWARTIP_SHOW)
        AIAgent:setEnabled(true) --TODO --FIX
        local levelCfg = BattleDataMgr:getLevelCfg()
        for i, v in ipairs(flightController.data.heros) do
            v.debutDistance = levelCfg.debutDistance
            v.debutDir = levelCfg.debutDir
            v.leaveDir = levelCfg.leaveDir
            flightController.player = PlayerCaptain:new(v)
            statistics.heroBattleEvent(flightController.player)
            flightController.player:doEvent(enum.eFlightStateEvent.BH_BORN)
            EventMgr:dispatchEvent(eEvent.EVENT_INITED_TEAM)
            break
        end
        flightController.setTiming(true)
        flightController.mapScroll = false --地图依然不能立马滚动
        EventTrigger:start()
        FlightBrushMonster.start()
        GuideMgr = require("lua.logic.guide.GuideMgr")
    end)
end

function flightController.enterBattle(data, ...)
    -- 切换到战斗场景
    if flightController.bStart then
        flightController.exitBattle()
    end
    flightController.bStart = true
    BattleDataMgr:setServerData(data, ...)
    data = BattleDataMgr:getBattleData()
    data.preloadMonster = FlightBrushMonster.getMonsters()
    ResLoader.loadAllResWithFlight(data, function()
        BattleUtils.playMusic(data.bgm, true)
        AlertManager:changeScene(SceneType.BATTLE)
    end)
end

function flightController.forceCleanStage()
    local heroes = heroMgr:getObjects()
    for _, hero in ipairs(heroes) do
        hero:ceasefire()
    end
    if flightController.offStageTimer then
        BattleTimerManager:removeTimer(flightController.offStageTimer)
        flightController.offStageTimer = nil
    end
    if flightController.offStages then
        for i = #flightController.offStages, 1, -1 do
            --- @type CaptainBase
            local captain = flightController.offStages[i]
            captain:doEvent(enum.eFlightStateEvent.BH_DIE, {recycled=false})
            table.remove(flightController.offStages, i)
        end
    end
    flightController.offStages = {}
end

--- @param result boolean
function flightController.endBattle(result)
    if flightController.player:isDead() and result then
        result = false
    end
    flightController.focusNode = nil
    flightController.bTiming = false
    victoryDecide.clear()
    KeyStateMgr.setEnable(false)
    FlightBrushMonster.stop()
    flightController.player:removeAllBuff()
    flightController.player:ceasefire()
    flightController.removeEvents()
    flightController.forceCleanStage()
    flightController.stopSynchronizeTimer()
    BulletCache:Stop()
    BulletCache:Dispose(true)
    ObjectPool.eraseAll()
    local timer
    timer = BattleTimerManager:addTimer(20, -1, nil, function()
        BattleTimerManager:removeTimer(timer)
        EventMgr:dispatchEvent(eEvent.EVENT_SHOW__STACE_CLEAR, result, function()
            flightController.mapScroll = false
            if result then
                flightController.cameraMode = enum.eMode.MANUAL
                flightController.player:doEvent(enum.eFlightStateEvent.BH_WIN, function()
                    flightController.pause()
                    flightController.requestFightingOver(result)
                    flightController.player = nil
                end)
            else
                flightController.pause()
                flightController.requestFightingOver(result)
                flightController.player:release()
                flightController.player = nil
            end

        end)
        HeroDataMgr:changeDataToSelf()
    end)
end

function flightController.exitBattle()
    flightController.stopSynchronizeTimer()
    victoryDecide.clear()
    KeyStateMgr.setEnable(false)
    flightController.started = false
    flightController.focusNode = nil
    flightController.bTiming = false
    BulletCache:Stop()
    BulletCache:Dispose(true)
    flightController.forceCleanStage()
    if flightController.player then
        flightController.player:release()
        flightController.player = nil
    end
    flightController.removeEvents()
    flightController.pause()
    flightController.clear()

    FlightBrushMonster.stop()
    BattleMgr.clear()
    ResLoader.clean()
    musicMgr.clean()
    statistics.clear()
    EventTrigger:clearTriggers()
    BattleTimerManager.model:reset()
end

function flightController.startOffStageTimer()
    if not flightController.offStageTimer then
        flightController.offStageTimer = BattleTimerManager:addTimer(100, -1, nil, function()
            for i = #flightController.offStages, 1, -1 do
                --- @type CaptainBase
                local captain = flightController.offStages[i]
                if not captain:hasAliveBullet() then
                    captain:doEvent(enum.eFlightStateEvent.BH_DIE, {recycled=true})
                    table.remove(flightController.offStages, i)
                end
            end
        end)
    end
end

function flightController.clear()
    flightController.bStart = nil
    ObjectPool.eraseAll()
end

function flightController.stopSynchronizeTimer()
    if flightController.synchronizeTimerID then
        TFDirector:removeTimer(flightController.synchronizeTimerID)
        flightController.synchronizeTimerID  = nil
    end
end

function flightController.startSynchronizeTimer()
    flightController.stopSynchronizeTimer()
    local data = TabDataMgr:getData("DiscreteData",22001)
    local time = 10*1000
    if data then
        time = data.data.heartbeat * 1000
    end
    flightController.beginTime = BattleUtils.gettime()
    flightController.synchronizeTimerID = TFDirector:addTimer(time, -1,nil, function ()
        flightController.synchronizeSpendTime()
    end)
end


--同步战斗消耗时间
function flightController.synchronizeSpendTime()
    flightController.beginTime = flightController.beginTime or BattleUtils.gettime()
    local spendTime = BattleUtils.gettime() - flightController.beginTime
    spendTime = math.floor(spendTime*0.001) --换算成秒
    dump({"战斗消耗:"..spendTime})
    TFDirector:send(c2s.DUNGEON_SCENE_SYNCHRONIZE, {spendTime})
end

function flightController.requestFightStart(...)
    dump({ ... })
    FubenDataMgr:send_DUNGEON_FIGHT_START(...)
end

function flightController.requestFightingOver(result)
    local levelId         = BattleDataMgr:getPointId()
    local reachStar       = statistics.calReachStar()
    local pickUpTypeCount = statistics.pickUpTypeCount
    local pickUpCount     = statistics.pickUpCount
    local maxComboNum     = statistics.maxComboNum
    FubenDataMgr:send_DUNGEON_FIGHT_OVER(levelId, result, reachStar,
            maxComboNum, pickUpTypeCount, pickUpCount)
end

function flightController.getStatistics()
    return statistics
end

function flightController.onCreateObstacle(refreshCfg,params)

end

return flightController
