local BattleTimerManager = import(".BattleTimerManager")
local BattleUtils = import(".BattleUtils")
local EventTrigger = import(".EventTrigger")
local enum        = import(".enum")
local eEvent = enum.eEvent
local eCampType    = enum.eCampType
local statistics   = import(".Statistics")
local VictoryDecide = {}

local this = VictoryDecide
function VictoryDecide.init(data, agent)
    -- dump(data)
    -- Box("asdfsdf")
    this.agent = agent
    this.data = data--配置
    print(this.data,"-VictoryDecide-")
    this.nViewType       = 0   --状态展示类型
    this.nStage          = 0   --通过的阶段
    this.nRemainingTime  = 0   --剩余时间
    this.nKillNum        = 0   --击杀总数量
    this.killTargets     = {}  --击杀具体怪物 id   - num
    this.killTypes       = {}  --击杀具体类型 type - num
    this.nSecondTime     = 0   --计时秒
    this.nTime           = 0   --总时间
    this.nWave           = 1   --当前怪物波次
    this.score           = 0   --击杀获得分数
    this.nScoreTime = 0
    if this.reduceTimer then  
        BattleTimerManager:removeTimer(this.reduceTimer)
        this.reduceTimer = nil
    end
    --计算显示类型(UI布局类型)
    local len = #this.data
    if len < 1 then
        return
    end
    local cfg = this.data[1]
    this.nViewType  = cfg.victoryType
    --计算剩余时间
    if this.nViewType == EC_LevelPassCond.DESTORY 
    or this.nViewType == EC_LevelPassCond.SPECIFICID
    or this.nViewType == EC_LevelPassCond.SPECIFICTYPE
    or this.nViewType == EC_LevelPassCond.SPECIFICCOUNT
    or this.nViewType == EC_LevelPassCond.WAVE  --波次
    or this.nViewType == EC_LevelPassCond.SURVIVAL
    or this.nViewType == EC_LevelPassCond.LIMIT_TIME_KILL    -- 限时杀怪
    or this.nViewType == EC_LevelPassCond.COMBO_COUNT    -- 连击数
    or this.nViewType == EC_LevelPassCond.SURVIVAL_HURT 
    or this.nViewType == EC_LevelPassCond.SCORE
    or this.nViewType == EC_LevelPassCond.SCORE2
    or this.nViewType == EC_LevelPassCond.SCORE3
    or this.nViewType == EC_LevelPassCond.LIMIT_TIME_KILL2 -- 日常副本(限时杀怪)
    or this.nViewType == EC_LevelPassCond.TIMING  -- 日常副本计时
    or this.nViewType == EC_LevelPassCond.HALLOWEEN_DESTORY
    or this.nViewType == EC_LevelPassCond.GUARDMODE_3
    or this.nViewType == EC_LevelPassCond.KILL_ALL_OR_LIMIT  then
        -- this.nSecondTime    = cfg.victoryParam[1]
        -- this.nRemainingTime = cfg.victoryParam[1]*1000
        this.nSecondTime    = BattleDataMgr:getLevelCfg().time   --this.data.time 
        this.nTime = this.nSecondTime*1000
        this.nRemainingTime = this.nTime
    end
    this.nStartTime = BattleUtils.gettime()
end
-- EC_LevelPassCond = {
--     DESTORY = 1,    -- 歼灭
--     SURVIVAL = 2,    -- 生存
--     SPECIFICID = 3,    -- 指定怪物id
--     SPECIFICTYPE = 4,    -- 指定怪物类型
--     SPECIFICCOUNT = 5,    -- 指定怪物数量
--     GUARDMODE = 6,    -- 守护模式
-- }
-- function VictoryDecide.setStartTime(time)
--     this.nStartTime = time or BattleUtils.gettime()
-- end

-- function VictoryDecide.deltaTime()
--     return BattleUtils.gettime() - this.nStartTime  
-- end

--设置剩余时间(高级组队用)
function VictoryDecide.setRemainime(time)
    this.nSecondTime    = time 
    this.nTime          = this.nSecondTime*1000
    this.nRemainingTime = this.nTime  --总时间
end

--修正剩余时间
function VictoryDecide.fixRemainime(passTime)
    this.countDown(0)
end

--计算剩余时间
function VictoryDecide.calcRemainime(dt)
    return math.max(0,this.nRemainingTime - dt)  
end

    -- DESTORY = 1,    -- 歼灭
    -- SURVIVAL = 2,    -- 生存
    -- SPECIFICID = 3,    -- 指定怪物id
    -- SPECIFICTYPE = 4,    -- 指定怪物类型
    -- SPECIFICCOUNT = 5,    -- 指定怪物数量
    -- GUARDMODE = 6,    -- 守护模式

local type_ = {
    EC_LevelPassCond.SPECIFICID,
    EC_LevelPassCond.SPECIFICCOUNT,
    EC_LevelPassCond.SPECIFICTYPE,
    EC_LevelPassCond.SCORE
}
--怪物被击杀
function VictoryDecide.doSlain(hero)
    local id      = hero:getData().id
    local objType = hero:getData().type or 1 --怪物类型
    this.killTargets[id] = this.killTargets[id] or 0
    this.killTargets[id] = this.killTargets[id] + 1
    this.killTypes[objType] = this.killTypes[objType] or 0
    this.killTypes[objType] = this.killTypes[objType] + 1
    local data = hero:getData()
    if data.score then
        this.changeScore(data.score)
    end
    --统计刷怪数量
    this.nKillNum = this.nKillNum + 1
    if this.nViewType == EC_LevelPassCond.TIMING then --殺怪增加時間
        if this.agent:isRun() then --游戏结束停止增加事件
            if data.killTime then --增加時間(秒)
                this.nTime = this.nTime + data.killTime*1000
                this.countDown(0)
            end
        end
    end
    --通知UI刷新
    this.doRefresh()
    --检查是否获胜(怪物击杀检测)
    if table.indexOf(type_, this.nViewType) ~= -1 then
        this.checkResult()
    end
end

function VictoryDecide.nextWave()
    this.nWave = this.nWave + 1
    this.doRefresh()
end

function VictoryDecide.setWave(wave)
    this.nWave = wave
    this.doRefresh()
end

function VictoryDecide.getWave()
    return this.nWave
end


function VictoryDecide.nextState()
    this.nStage = this.nStage + 1
    this.doRefresh()
end

function VictoryDecide.setStage(stage)
    this.nStage = stage
    this.doRefresh()
end

--
function VictoryDecide.getKillNum()
    return this.nKillNum
end

--指定ID的数量
function VictoryDecide.getKillTargetNum(id)
    return this.killTargets[id] or 0
end

--指定怪物类型怪的数量
function VictoryDecide.getKillTypeNum(objType)
    return this.killTypes[objType] or 0
end

--UI刷新
function VictoryDecide.doRefresh()
    EventMgr:dispatchEvent(eEvent.EVENT_REFRESH_VICTORY_STATE)
end

function VictoryDecide.getKillTargets()
    local killedTargets = {}
    for k,v in pairs(this.killTargets) do
        table.insert(killedTargets,{k,v})
    end
    return killedTargets
end

function VictoryDecide.getScore()
    return this.score  
end

-- 1命中增加积分 2受击减少积分， 3扣分倒计时，4扣分间隔，5扣分值
--命中
function VictoryDecide.onHit()
    if this.nViewType == EC_LevelPassCond.SCORE2 then
        local scorePrams = this.data[1].victoryParam2
        this.changeScore(scorePrams[1])
    end
end

--受击
function VictoryDecide.onHurt()
    if this.nViewType == EC_LevelPassCond.SCORE2 then
        local scorePrams = this.data[1].victoryParam2
        this.changeScore(-scorePrams[2])
    end
end


function VictoryDecide.changeScore(score)
    if score > 0 then --加分行为
        this.onAddScore() 
        this.score = this.score + score
    elseif score < 0 then
        local rating   = this.getRating()
        local minScore = this.data[1].victoryParam[rating]
        this.score = this.score + score
        this.score = math.max(this.score,minScore)
    end
    this.doRefresh()
end

--积分增加
function VictoryDecide.onAddScore()
    if this.nViewType == EC_LevelPassCond.SCORE2 then
        this.nScoreTime = 0
        if this.reduceTimer then 
            BattleTimerManager:removeTimer(this.reduceTimer)
            this.reduceTimer = nil
        end
    end
end

function VictoryDecide.scoreUpdate(dt)
    if this.nViewType == EC_LevelPassCond.SCORE2 then
        -- dump(this.data)
        -- Box("asd")
        -- 峰哥 配置参数  1 攻击得分 2受击减分  3-7 各个评级减分CD  8-12 各个评级减分间隔  13-17 各个评级减分值 
        local rating = this.getRating()
        local scorePrams = this.data[1].victoryParam2
        local pramIndex = 2 + rating
        if this.nScoreTime < scorePrams[pramIndex] then 
            this.nScoreTime =  this.nScoreTime + dt
            if this.nScoreTime >= scorePrams[pramIndex] then 
                if not this.reduceTimer then
                    this.reduceTimer = BattleTimerManager:addTimer(scorePrams[ 7 + rating ],-1,nil,function ()
                        this.changeScore(-scorePrams[ 12 + rating ])  
                    end)
                end
            end 
        end
    elseif this.nViewType == EC_LevelPassCond.SCORE3 then
        
    end
end

--停止减分定时器
function VictoryDecide.stopReduceTimer()
    if this.reduceTimer then 
        BattleTimerManager:removeTimer(this.reduceTimer)
        this.reduceTimer = nil
    end
end

--获取评级
function VictoryDecide.getRating()
    if this.nViewType == EC_LevelPassCond.SCORE2 then --积分模式二才有评级
        local params = this.data[1].victoryParam
        local score  = this.score
        local rating = 1
        if score > 0 then
            for idx , v in ipairs(params) do
                if score >= v then 
                    rating = idx
                end 
            end
        end
        return math.min(rating,5)
    end
    return 1
end

------------------通关条件-----------------
-- 关卡胜利条件
-- EC_LevelPassCond = {
--     DESTORY = 1,    -- 歼灭
--     SURVIVAL = 2,    -- 生存
--     TIMELIMIT = 3,    -- 限时
--     SPECIFICID = 4,    -- 指定怪物id
--     SPECIFICTYPE = 5,    -- 指定怪物类型
--     SPECIFICCOUNT = 6,    -- 指定怪物数量
--     WAVE      = 7,    --波次  
-- }

function VictoryDecide.getData()
    return this.data
end
--获取胜利通关类型
-- 1歼灭，
-- 2生存，
-- 3限时，
-- 4目标击杀-具体怪物，5目标击杀-怪物类型，6目标击杀-怪物数量
function VictoryDecide.clear()
    this.nTime           = 0   --总时间
    this.nStartTime      = 0   --开始计时的真实时间
    this.nSecondTime     = 0   --计时秒
    this.nViewType       = 0   --状态展示类型
    this.nRemainingTime  = 0   --剩余时间
    this.nKillNum        = 0   --击杀总数量
    this.nWave           = 0   --波次
    this.killTargets     = {}  --击杀具体怪物 id   - num
    this.killTypes       = {}  --击杀具体类型 type - num
    this.agent = nil
    this.score = 0
    this.nScoreTime = 0 
    if this.reduceTimer then 
        BattleTimerManager:removeTimer(this.reduceTimer)
    end
end

function VictoryDecide.countDown(dt)
    if this.nRemainingTime > 0 then
        this.nRemainingTime = this.nTime - this.agent.getTime()
        this.nRemainingTime = math.max(this.nRemainingTime,0)
        local second = math.floor(this.nRemainingTime/1000)
        if second ~= this.nSecondTime then
            this.nSecondTime = second
            this.doRefresh()
        end
    end
end

function VictoryDecide.update(dt)
    if this.nViewType == EC_LevelPassCond.DESTORY 
    or this.nViewType == EC_LevelPassCond.SPECIFICID 
    or this.nViewType == EC_LevelPassCond.SPECIFICTYPE
    or this.nViewType == EC_LevelPassCond.SPECIFICCOUNT
    or this.nViewType == EC_LevelPassCond.WAVE 
    or this.nViewType == EC_LevelPassCond.SURVIVAL 
    or this.nViewType == EC_LevelPassCond.LIMIT_TIME_KILL    -- 限时杀怪
    or this.nViewType == EC_LevelPassCond.COMBO_COUNT    -- 连击数
    or this.nViewType == EC_LevelPassCond.SURVIVAL_HURT 
    or this.nViewType == EC_LevelPassCond.GUARDMODE_3
    or this.nViewType == EC_LevelPassCond.SCORE2
    or this.nViewType == EC_LevelPassCond.SCORE3
    or this.nViewType == EC_LevelPassCond.LIMIT_TIME_KILL2 -- 日常副本(限时杀怪)
    or this.nViewType == EC_LevelPassCond.TIMING  -- 日常副本计时
    or this.nViewType == EC_LevelPassCond.HALLOWEEN_DESTORY 
    or this.nViewType == EC_LevelPassCond.SCORE 
    or this.nViewType == EC_LevelPassCond.KILL_ALL_OR_LIMIT then
    -- or this.nViewType == EC_LevelPassCond.GUARDMODE then  --守护模式没有时间限制 @周浩然
        this.scoreUpdate(dt)
        this.countDown(dt)
        this.checkResult()
    end
end

-- 生存检测
function VictoryDecide:check_SURVIVAL()

end

-- 3在限定时间内击杀一定数量怪物，4目标击杀-具体怪物，5目标击杀-怪物类型，6目标击杀-怪物数量
function VictoryDecide.getData()
    return this.data
end

function VictoryDecide.checkLastResult(isWin)
    if this.nViewType == EC_LevelPassCond.KILL_ALL_OR_LIMIT then    -- 限时杀怪
        return statistics.killNum >= this.data[1].victoryParam[2]
    end
    return isWin
end

--检查获胜条件
function VictoryDecide.checkResult()
    if not this.agent then
        return
    end
    if not this.agent:isRun() then
        return
    end
    --只倒计时判定
    if this.nViewType == EC_LevelPassCond.DESTORY 
    or this.nViewType == EC_LevelPassCond.SPECIFICID 
    or this.nViewType == EC_LevelPassCond.SPECIFICTYPE
    or this.nViewType == EC_LevelPassCond.SPECIFICCOUNT
    -- or this.nViewType == EC_LevelPassCond.SCORE2 
    or this.nViewType == EC_LevelPassCond.GUARDMODE_3
    or this.nViewType == EC_LevelPassCond.HALLOWEEN_DESTORY
    or this.nViewType == EC_LevelPassCond.WAVE then
    -- or this.nViewType == EC_LevelPassCond.GUARDMODE then --守护模式没有时间限制 @周浩然
    -- or this.nViewType == EC_LevelPassCond.SURVIVAL then --生存模式时间到了不做胜利判定,胜利判定交由触发器完成
        if this.nRemainingTime <= 0 then
            this.agent.endBattle(false)
        end
    elseif this.nViewType == EC_LevelPassCond.SURVIVAL then
        if this.nRemainingTime <= 0 then
            if not EventTrigger.controller.flightMode then
                local isAllDied = EventTrigger.controller.getTeam():isAllDestoryByCampTyp(eCampType.Hero)
                if isAllDied == true then
                    EventTrigger.controller.endBattle(false)
                else
                    EventTrigger.controller.endBattle(true)
                end
            end
        end
    elseif this.nViewType == EC_LevelPassCond.SURVIVAL_HURT then 
        if this.nRemainingTime <= 0 then
            if this.data[1].victoryParam[3] then
                if this.data[1].victoryParam[3] == 1 then
                    EventTrigger.controller.endBattle(false)
                end
            else
                if not EventTrigger.controller.flightMode then
                    local isAllDied = EventTrigger.controller.getTeam():isAllDestoryByCampTyp(eCampType.Hero)
                    if isAllDied == true then
                        EventTrigger.controller.endBattle(false)
                    else
                        EventTrigger.controller.endBattle(true)
                    end
                end
            end
        else
            if this.data[1].victoryParam[2] then  
                if statistics.hitValue >= this.data[1].victoryParam[2] then 
                    EventTrigger.controller.endBattle(true)
                end 
            end
        end

    elseif this.nViewType == EC_LevelPassCond.SCORE then --积分模式 
        if this.score >= this.data[1].victoryParam[1] then 
            EventTrigger.controller.endBattle(true)
            return
        end
        if this.nRemainingTime <= 0 then
            this.agent.endBattle(false)
        end
    elseif this.nViewType == EC_LevelPassCond.SCORE3 then
        if statistics.score >= this.data[1].victoryParam[2] then 
             this.agent.endBattle(true)
             return
        end
        if this.nRemainingTime <= 0 then
            this.agent.endBattle(true)
        end
    elseif this.nViewType == EC_LevelPassCond.LIMIT_TIME_KILL then    -- 限时杀怪
        if statistics.killNum >= this.data[1].victoryParam[2] then 
             this.agent.endBattle(true)
             return
        end
       if this.nRemainingTime <= 0 then
            this.agent.endBattle(true)
        end
    elseif this.nViewType == EC_LevelPassCond.COMBO_COUNT then   -- 连击数  
        if statistics.maxComboNum >= this.data[1].victoryParam[2] then 
             this.agent.endBattle(true)
             return
        end
        if this.nRemainingTime <= 0 then
            this.agent.endBattle(true)
        end
    elseif this.nViewType == EC_LevelPassCond.LIMIT_TIME_KILL2 then     
        if this.nRemainingTime <= 0 then
            this.agent.endBattle(true)
        end
    elseif this.nViewType == EC_LevelPassCond.TIMING then
        if statistics.killNum >= this.data[1].victoryParam[2] then 
             this.agent.endBattle(true)
             return
        end 
        if this.nRemainingTime <= 0 then
            this.agent.endBattle(true)
        end
    elseif this.nViewType == EC_LevelPassCond.KILL_ALL_OR_LIMIT then    -- 限时杀怪
        local members =  this.agent.getEnemyMember__()
        if statistics.killNum >= this.data[1].victoryParam[1] and #members < 1 then 
             this.agent.endBattle(true)
             return
        end
        if this.nRemainingTime <= 0 then
            if statistics.killNum >= this.data[1].victoryParam[2] then 
                this.agent.endBattle(true)
            else
                this.agent.endBattle(false)
            end
        end
    else

    end
end

return VictoryDecide
