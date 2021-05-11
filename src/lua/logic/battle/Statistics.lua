local BattleConfig = import(".BattleConfig")
local AwakeMgr = import(".AwakeMgr")
local enum   = import(".enum")
local eEvent = enum.eEvent
local eSkillType =  enum.eSkillType

local Statistics = {}
local this = Statistics
function Statistics.init(starCfg)
    this.levelCfg = BattleDataMgr:getLevelCfg()
    this.starCfg     = starCfg
    this.flagList = {}
    this.allTime  = this.levelCfg.time*1000 --总时间
    ----战斗数据统计----
    this.time     = 0  --通关时间
    this.testTime = 0
    this.hp       = 0  --总血量
    this.loseHp   = 0  --失血
    this.dead     = 0  --死亡
    this.getHit   = 0  --受击次数
    this.pickUpTypes = {}
    this.pickUpTypeCount = 0  --道具种类个数
    this.pickUpCount     = 0  --道具个数
    this.fall            = 0  --击倒次数
    this.skillAwake      = 0  --使用觉醒技次数
    this.skillEnterKill  = 0  --使用出场技击杀
    this.skillAwakeKill  = 0  --使用出场技击杀
    this.assist          = 0  --使用好友助战
    this.heroIds         = {}  --出战角色IDs

    this.combo           = 0  --当前连击数
    this.maxComboNum     = 0  --最大连击数
    this.comboTime       = 0  --计时
    this.skillCount      = 0 --使用技能次数
    this.skillDodgeCount = 0 --使用闪避技能次数
    this.limtTimeCfg     = 0 --限时(在xx秒里击杀1个敌人)
    this.limtTime        = 0 --计时(在xx秒里击杀1个敌人)
    this.limtTimeKill    = false --限时击杀结果

    this.score = 0    -- 击杀积分
    this.killNum = 0    -- 击杀总人数
    this.killBossNum  = 0 --击杀Boss数量
    this.eatMonsterCount = 0  --吃到怪物道具数
    this.conEatMonsterCount = 0  --连续吃到怪物道具数
    this.maxEatCount = 0
    

    this.controller = BattleDataMgr:getController()

--在xx秒里击杀1个敌人
    for i, starInfo in pairs(this.starCfg) do
        if starInfo.starType == EC_FBStarRule.LIMIT_KILL then
            this.limtTimeCfg = starInfo.starParam*1000
            this.limtTimeKill  = true --限时击杀结果
        end
    end

    this.battleType_ = BattleDataMgr:getBattleType()
    --技能使用次数统计
    this.skillCountTab = {}
    --刷怪统计
    this.monsterInfos  = {}
    --怪物失血
    this.monsterLoseHp = 0
    -- 产生伤害次数
    this.hitIimes = 0
    -- 产生总伤害
    this.hitValue = 0

    this.practiceTimePause = false    -- 木桩副本暂停伤害统计
    this.practiceTime = 0    -- 木桩副本计时
end


function Statistics.clear( ... )
    --统计相关
    this.time     = 0  --通关时间
    this.testTime = 0
    this.hp       = 0  --总血量
    this.loseHp   = 0  --失血
    this.dead     = 0  --死亡
    this.getHit   = 0  --受击次数
    this.pickUpTypes     = {}
    this.pickUpTypeCount = 0  --道具种类个数
    this.pickUpCount     = 0  --道具个数
    this.fall            = 0  --击倒次数
    this.skillAwake      = 0  --使用觉醒技次数
    this.skillEnterKill  = 0  --使用出场技击杀
    this.skillAwakeKill  = 0  --使用觉醒技击杀
    this.assist          = 0  --使用好友助战
    this.heroIds         = {} --使用指定角色出战

    this.combo           = 0  --当前连击数
    this.maxComboNum     = 0  --最大连击数

    this.comboTime       = 0  --计时
    this.skillCount      = 0 --使用技能次数
    this.skillDodgeCount = 0 --使用闪避技能次数
    this.limtTimeCfg     = 0 --限时(在xx秒里击杀1个敌人)
    this.limtTime        = 0 --计时(在xx秒里击杀1个敌人)
    this.limtTimeKill    = false --限时击杀结果
    this.score           = 0
    this.skillCountTab   = {}
    this.createMonsters  = {}
    this.monsterLoseHp   = 0
    -- 产生伤害次数
    this.hitIimes = 0
    -- 产生总伤害
    this.hitValue = 0
    this.eatMonsterCount = 0
    this.conEatMonsterCount = 0
    this.maxEatCount = 0
end

-- 重置无尽模式数据
function Statistics.resetEndless()
    this.endlessTime = 0    -- 无尽模式时间
    this.endlessReward = {}    -- 无极模式奖励
    this.endlessPassLevel = {}    -- 通过的层数记录
end

--真实操作时间（暂停 剧情中断时间除外）
function Statistics.getControlPassTime()
    return this.controller.getControlPassTime()
end


--计算星数
function Statistics.calReachStar()
    local reachStar = {}
    for i, v in ipairs(this.starCfg) do
        local isReach = this.getStarIsReach(i)
        if isReach then
            table.insert(reachStar, v.pos)
        end
    end
    return reachStar
end

function Statistics.getScoreRate()
    local rate = 1
    if this.controller and this.controller.getCaptain() then
        local percent = this.controller.getCaptain():getHpPercent() / 10000
        local range = Utils:getKVP(21001, "hpRange")

        for i = #range, 1 , -1 do
            local min, max, r = string.match(range[i], "(.*)%-(.*):(.*)")
            if percent > tonumber(min) and percent <= tonumber(max) then
                rate = tonumber(r)
                break
            end
        end
    end
    return rate
end

function Statistics.getStarRuleValue(starType,starParam)
    if starType == EC_FBStarRule.COMBO then
        return this.maxComboNum
    elseif starType == EC_FBStarRule.TIME then
        return math.floor(this.time/1000)
    elseif starType == EC_FBStarRule.MORE_REMAINING_TIME then
        local remainingTime = math.max(0,this.allTime - this.time)
        return math.floor(remainingTime*0.001) 
    elseif starType == EC_FBStarRule.HP then
        return math.floor(this.loseHp*100/this.hp)
    elseif starType == EC_FBStarRule.DEATH then
        return this.dead
    elseif starType == EC_FBStarRule.HIT then
        return this.getHit
    elseif starType == EC_FBStarRule.FALL then --
        return this.fall
    elseif starType == EC_FBStarRule.SKILL_AWAKE then --
        return this.skillAwake
    elseif starType == EC_FBStarRule.SKILL_ENTER_KILL then --
        return this.skillEnterKill
    elseif starType == EC_FBStarRule.SKILL_AWAKE_KILL then --
        return this.skillAwakeKill    
    elseif starType == EC_FBStarRule.ASSIST then --
        return this.assist
    elseif starType == EC_FBStarRule.NOT_ASSIST then
        if this.assist == 1 then
            return 0
        else
            return 1
        end
    elseif starType == EC_FBStarRule.HERO_BATTLE then --
        if this.heroIds[starParam] then
            return 1
        else
            return 0
        end
    elseif starType == EC_FBStarRule.LIMIT_KILL then  --X 秒必须杀死一个敌人
        if this.limtTimeKill then
            return 1
        else
            return 0
        end
    elseif starType == EC_FBStarRule.SKILL_COUNT then  --使用技能次数不超过
        -- Box("this.skillCount:"..tostring(this.skillCount))
        return this.skillCount
    elseif starType == EC_FBStarRule.TEAM_DEATH then  --队伍中不能角色死亡
        return this.dead
    elseif starType == EC_FBStarRule.KILL_COUNT then
        return this.killNum
    elseif starType == EC_FBStarRule.SCORE then
        return this.getScore()
    elseif starType == EC_FBStarRule.SCORE3 then
        return this.getScore3()
    elseif starType == EC_FBStarRule.SKILL_DODGE then --使用闪避技能次数
        return this.skillDodgeCount
    elseif starType == EC_FBStarRule.NOT_USE_DODGE then --不使用闪避技能
        return this.skillDodgeCount
    elseif starType == EC_FBStarRule.GET_MONSTER_ITEM then
        return this.eatMonsterCount
    elseif starType == EC_FBStarRule.GET_MONSTER_ITEM_COM then
        return this.maxEatCount
    elseif starType == EC_FBStarRule.PASS_LEVEL_NO_ITEM then
        return 0
    end
end

-- 挑战时间进行一半时，提示显示一次  1
-- 挑战时间剩余30秒时，显示一次      2
-- 挑战时间剩余10秒时，显示一次      3
function Statistics.update(dt)
    if this.battleType_ == EC_BattleType.ENDLESS then
        this.endlessTime = this.endlessTime + dt
    end
    if this.levelCfg.dungeonType == EC_FBLevelType.PRACTICE then
        if not this.practiceTimePause then
            this.practiceTime = this.practiceTime + dt
        end
    end
    this.testTime = this.testTime + dt
    this.time = this.time + dt
    --this.controller.getControlPassTime()
    this.handlCombo(dt)--连击计时
    this.percent20Tip(EC_FBStarRule.TIME)
    this.percent20Tip(EC_FBStarRule.MORE_REMAINING_TIME)
    --XX秒里时判断
    if this.limtTimeCfg > 0 and this.limtTimeKill then
        this.limtTime = this.limtTime + dt
        if this.limtTimeKill then
            if this.limtTime > this.limtTimeCfg then
                this.limtTimeKill = false
                --TODO 提示失败
                Statistics.percent20Tip(EC_FBStarRule.LIMIT_KILL)
            end
        end
    end
end

--刷一只怪
function Statistics.addMonsterInfo(hero)
    local data = hero:getData()
    local monster = {data.id , data.level,1}
    if not data.level or data.level < 1 then
        data.level = 1
    end
    -- table.insert(this.monsterInfos,monster)
    this.monsterInfos[data.id] = this.monsterInfos[data.id] or {}
    if this.monsterInfos[data.id][data.level] then
        this.monsterInfos[data.id][data.level] = this.monsterInfos[data.id][data.level] + 1
    else
        this.monsterInfos[data.id][data.level] = 1
    end
    -- dump(this.monsterInfos)
end

--失血提示
function Statistics.loseHPEvent_monster(hp)
    --处理关卡进度提示
    this.monsterLoseHp = this.monsterLoseHp + math.abs(hp)
    -- dump({"this.monsterLoseHp ",this.monsterLoseHp })
end



--击杀
function Statistics.doSlain(isBoss)
    this.limtTime = 0 --时间清零
    this.killNum = this.killNum + 1
    if isBoss then
        this.killBossNum = this.killBossNum + 1
    end
    this.percent20Tip(EC_FBStarRule.KILL_COUNT)
end

--总血量
function Statistics.hpEvent(hp)
    this.hp = this.hp + math.abs(hp)
end

--统计捡取道具的各种类型的数量
function Statistics.pickUpEvent(itemType)
    this.pickUpCount = this.pickUpCount + 1
    --类型数量
    this.pickUpTypes[itemType] = true
    this.pickUpTypeCount = table.count(this.pickUpTypes)
end

--角色参战统计
function Statistics.heroBattleEvent(hero)
    if "function" == type(hero.isAssist) then
        if hero:isAssist() then
            this.assist = 1
        else
            this.heroIds[hero:getData().id] = true
        end
    else
        this.heroIds[hero:getData().id] = true
    end
end

function Statistics.scoreEvent(score)
    this.score = this.score + score
    this.percent20Tip(EC_FBStarRule.SCORE)
end

--怪才击杀统计积分
function Statistics.doScoreEvent(hero)
    local data = hero:getData()
    if data.score then
        this.score = this.score + data.score
        this.percent20Tip(EC_FBStarRule.SCORE3)
    end
end


-------------------------------------

--使用技能次数(大招和觉醒)
function Statistics.skillCountEvent(skill)
    this.skillCount = this.skillCount + 1
    this.percent20Tip(EC_FBStarRule.SKILL_COUNT)
    local skillType = skill:getSKillType()
    if skillType == eSkillType.Skill_1
        or skillType == eSkillType.Skill_2
        or skillType == eSkillType.CRI then
        local skillId = skill:getData().id
        if this.skillCountTab[skillId] then
            this.skillCountTab[skillId] = this.skillCountTab[skillId] + 1
        else
            this.skillCountTab[skillId] = 1
        end
        -- dump(this.skillCountTab)
        -- Box("ss")
    end
end

--失血提示
function Statistics.loseHPEvent(hp)
    --处理关卡进度提示
    this.loseHp = this.loseHp + math.abs(hp)
    this.percent20Tip(EC_FBStarRule.HP)
end


function Statistics.deathEvent()
    this.dead = this.dead + 1
    this.percent20Tip(EC_FBStarRule.DEATH)
    this.percent20Tip(EC_FBStarRule.TEAM_DEATH)
end

function Statistics.hitEvent()
    this.getHit = this.getHit + 1
    this.percent20Tip(EC_FBStarRule.HIT)
end

--角色产生伤害的次数
function Statistics.doHitEvent(value)
    -- 产生伤害次数
    this.hitIimes = this.hitIimes + 1

end
--统计怪物的失血(角色总伤害)
function Statistics.doHurtValue(value)
    -- 产生总伤害
    if not this.practiceTimePause then
        this.hitValue = this.hitValue + math.abs(value)
    end
    -- dump({this.hitIimes ,this.hitValue},"doHitEvent" )
end
--被击倒
function Statistics.fallEvent()
    this.fall = this.fall + 1
    this.percent20Tip(EC_FBStarRule.FALL)
end

--使用觉醒技能
function Statistics.skillAwakeEvent()
    this.skillAwake = this.skillAwake + 1
    this.percent20Tip(EC_FBStarRule.SKILL_AWAKE)
end
--使用闪避技能
function Statistics.skillDodgeEvent()
    this.skillDodgeCount = this.skillDodgeCount + 1
    this.percent20Tip(EC_FBStarRule.SKILL_AWAKE)
end

--入场技能击杀
function Statistics.skillEnterKillEvent()
    this.skillEnterKill = this.skillEnterKill + 1
    this.percent20Tip(EC_FBStarRule.SKILL_ENTER_KILL)
end

--入场技能击杀
function Statistics.skillAwakeKillEvent()
    this.skillAwakeKill = this.skillAwakeKill + 1
    this.percent20Tip(EC_FBStarRule.SKILL_AWAKE_KILL)
end

function Statistics.endlessPassEvent(levelCid, dropReward)
    table.insert(this.endlessPassLevel, levelCid)
    table.insertTo(this.endlessReward, dropReward)
    this.endlessReward = Utils:mergeReward(this.endlessReward)
end

function Statistics.eatMonsterItem(hero,monster)
    if hero:getCampType() == 1 then
        this.eatMonsterCount = this.eatMonsterCount + 1
        this.conEatMonsterCount = this.conEatMonsterCount + 1
        this.maxEatCount = math.max(this.conEatMonsterCount,this.maxEatCount)
    else
        this.conEatMonsterCount = 0
    end
end

--每20%进入提示一次
function Statistics.percent20Tip(starType)
    local starInfo, index
    for i, v in ipairs(this.starCfg) do
        local curValue = this.getStarRuleValue(starType)
        if v.starType == starType then
            this.flagList[i] = this.flagList[i] or {}
            local flags = this.flagList[i]
            local curValue = this.getStarRuleValue(starType)
            if not flags["last"] then
                starInfo = v
                index = i
                break
            end
        end
    end

    if starInfo and index then
        local flags = this.flagList[index]
        local curValue = this.getStarRuleValue(starType)
        if starType == EC_FBStarRule.TEAM_DEATH or
           starType == EC_FBStarRule.LIMIT_KILL then
            if not flags["last"] then
                flags["last"]= true
                EventMgr:dispatchEvent(eEvent.EVENT_SHOW_CHALLENGE_PROGRESS, index)
            end

        elseif starInfo.starType == EC_FBStarRule.SKILL_COUNT then
            if curValue <= starInfo.starParam then
                local percent = curValue*100/starInfo.starParam
                local part   = math.floor(percent/20)
                if part > 0 then
                    if not flags[part] then
                        flags[part] = true
                        EventMgr:dispatchEvent(eEvent.EVENT_SHOW_CHALLENGE_PROGRESS, index)
                    end
                end
            else
                if not flags["last"] then
                    flags["last"]= true
                    EventMgr:dispatchEvent(eEvent.EVENT_SHOW_CHALLENGE_PROGRESS, index)
                end
            end
        else
            if curValue < starInfo.starParam then
                local percent = curValue*100/starInfo.starParam

                local part = math.floor(percent/20)
                if part > 0 then
                    if not flags[part] then
                        flags[part] = true
                        EventMgr:dispatchEvent(eEvent.EVENT_SHOW_CHALLENGE_PROGRESS, index)
                    end
                end
            else
                if not flags["last"] then
                    flags["last"]= true
                    EventMgr:dispatchEvent(eEvent.EVENT_SHOW_CHALLENGE_PROGRESS, index)
                end
            end
        end
    end
end

------------------------------------

--修正连击时间
function Statistics.fixComboTime(time)
    this.comboTime = this.comboTime - time
end

--连击计时处理
function Statistics.handlCombo(dt)
    if this.comboTime > BattleConfig.COMBO_TIME then
        this.combo     = 0
        this.comboTime = 0
    else
        if not AwakeMgr.isPlay() then
            this.comboTime = this.comboTime + dt
        end
    end
end

--连击事件
function Statistics.comboEvent(num)
    this.combo         = this.combo + num
    this.maxComboNum   = math.max(this.maxComboNum, this.combo)
    this.comboTime     = 0
    --连击进度提示
    this.percent20Tip(EC_FBStarRule.COMBO)
end

function Statistics.getStarIsReach(index)
    local levelCfg = BattleDataMgr:getLevelCfg()
    local isReach = false
    local starInfo = this.starCfg[index]
    local starType = starInfo.starType
    local starParam = starInfo.starParam

    if starType == EC_FBStarRule.COMBO then
        isReach = tobool(this.maxComboNum >= starParam)
    elseif starType == EC_FBStarRule.TIME then
        local ms = starParam * 1000
        isReach = tobool(this.time < ms)
    elseif starType == EC_FBStarRule.MORE_REMAINING_TIME then
        local ms = starParam * 1000
        local remainingTime = math.max(0,this.allTime - this.time) 
        isReach = tobool(remainingTime > ms)
    elseif starType == EC_FBStarRule.HP then
        local percent = math.floor(this.loseHp / this.hp * 100)
        isReach = tobool(percent < starParam)
    elseif starType == EC_FBStarRule.DEATH then
        isReach = tobool(this.dead < starParam)
    elseif starType == EC_FBStarRule.HIT then
        isReach = tobool(this.getHit < starParam)
    elseif starType == EC_FBStarRule.FALL then
        isReach = tobool(this.fall < starParam)
    elseif starType == EC_FBStarRule.SKILL_AWAKE then
        isReach = tobool(this.skillAwake >= starParam)
    elseif starType == EC_FBStarRule.SKILL_ENTER_KILL then
        isReach = tobool(this.skillEnterKill >= starParam)
    elseif starType == EC_FBStarRule.SKILL_AWAKE_KILL then
        isReach = tobool(this.skillAwakeKill >= starParam)    
    elseif starType == EC_FBStarRule.ASSIST then
        isReach = tobool(this.assist == 1)
    elseif starType == EC_FBStarRule.NOT_ASSIST then
        isReach = tobool(this.assist == 0)
    elseif starType == EC_FBStarRule.HERO_BATTLE then
        isReach = tobool(this.heroIds[starParam])
    elseif starType == EC_FBStarRule.LIMIT_KILL then  --X 秒必须杀死一个敌人
        isReach = tobool(this.limtTimeKill)
    elseif starType == EC_FBStarRule.SKILL_COUNT then  --使用技能次数小于
        isReach = tobool(this.skillCount <= starParam)
    elseif starType == EC_FBStarRule.TEAM_DEATH then  --队伍中不能角色死亡
        isReach = tobool(this.dead < 1)
    elseif starType == EC_FBStarRule.KILL_COUNT then
        isReach = tobool(this.killNum >= starParam)
    elseif starType == EC_FBStarRule.SCORE then
        local score =  this.getScore()
        isReach = tobool(score >= starParam)
        this.endScore = score
    elseif starType == EC_FBStarRule.SCORE3 then
        local score =  this.getScore3()
        isReach = tobool(score >= starParam)
        this.endScore = score
    elseif starType == EC_FBStarRule.SKILL_DODGE then  --使用闪避技能不超过X次
        isReach = tobool(this.skillDodgeCount <= starParam)
    elseif starType == EC_FBStarRule.NOT_USE_DODGE then --不使用闪避技能
        isReach = tobool(this.skillDodgeCount < 1)
    elseif starType == EC_FBStarRule.GET_MONSTER_ITEM then
        isReach = tobool(this.eatMonsterCount >= starParam)
    elseif starType == EC_FBStarRule.GET_MONSTER_ITEM_COM then
        isReach = tobool(this.maxEatCount >= starParam)
    elseif starType == EC_FBStarRule.PASS_LEVEL_NO_ITEM then
        isReach = tobool(this.eatMonsterCount < 1)
    end
    return isReach
end

function Statistics.getMaxComboNum()
    return this.maxComboNum
end
--当前连击数
function Statistics.getComboNum()
    return this.combo
end

function Statistics.getScore()
    local rate = this.getScoreRate()
    return math.ceil(this.score * (1.0 + rate))
end
function Statistics.getScore3()
    return this.score
end
function Statistics.getStarCfg()
    return this.starCfg
end

function Statistics.getAllCondStarType()
    -- 条件满足显示进度，不满足失败
    local condRule1 = {
        EC_FBStarRule.TIME,
        EC_FBStarRule.MORE_REMAINING_TIME,
        EC_FBStarRule.HP,
        EC_FBStarRule.DEATH,
        EC_FBStarRule.HIT,
        EC_FBStarRule.FALL,
        EC_FBStarRule.TEAM_DEATH,
        EC_FBStarRule.SKILL_COUNT,
        EC_FBStarRule.SKILL_DODGE,
        EC_FBStarRule.PASS_LEVEL_NO_ITEM,
    }
    -- 条件满足达成，不满足进行中
    local condRule2 = {
        EC_FBStarRule.PASS,
    }
    -- 条件满足达成，不满足显示进度
    local condRule3 = {
        EC_FBStarRule.COMBO,
        EC_FBStarRule.SKILL_AWAKE,
        EC_FBStarRule.SKILL_ENTER_KILL,
        EC_FBStarRule.SCORE,
        EC_FBStarRule.SCORE3,
        EC_FBStarRule.KILL_COUNT,
        EC_FBStarRule.GET_MONSTER_ITEM,
        EC_FBStarRule.GET_MONSTER_ITEM_COM,
    }
    -- 条件满足达成，不满足失败
    local condRule4 = {
        EC_FBStarRule.HERO_BATTLE,
        EC_FBStarRule.ASSIST,
        EC_FBStarRule.NOT_ASSIST,
    }
    -- 条件满足进行中，不满足失败
    local condRule5 = {
        EC_FBStarRule.LIMIT_KILL,
        EC_FBStarRule.NOT_USE_DODGE,
    }

    return condRule1, condRule2, condRule3, condRule4, condRule5
end

return Statistics
