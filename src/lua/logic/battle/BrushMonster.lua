
local BattleUtils = import(".BattleUtils")
local enum = import(".enum")
local eRoleType = enum.eRoleType
local eCampType = enum.eCampType
local eBrushMonsterType = enum.eBrushMonsterType
local eBrushPauseRule = enum.eBrushPauseRule
local eEvent      = enum.eEvent
local eFlag       = enum.eFlag
local victoryDecide = import(".VictoryDecide")
local levelParse = import(".LevelParse")

local TimingNode = class("TimingNode")

function TimingNode:ctor(duration, data, callback)
    self.duration_ = duration
    self.timing_ = 0
    self.data_ = data
    self.index_ = 1
    self.callback_ = callback
end

function TimingNode:update(delta)
    local isTrigger = false
    self.timing_ = self.timing_ + delta
    if self.timing_ >= self.duration_[self.index_] then
        self.timing_ = 0
        isTrigger =  true
        self.index_ = math.min(#self.duration_, self.index_ + 1)
    end
    return isTrigger
end

function TimingNode:trigger()
    local data = table.remove(self.data_, 1)
    local isEmpty = (#self.data_ == 0)
    return data, isEmpty
end

function TimingNode:getData()

end

function TimingNode:complete()
    if self.callback then
        self.callback()
    end
end

local BrushMonster = {}

function BrushMonster:init()
    EventMgr:removeEventListenerByTarget(self)
    EventMgr:addEventListener(self, EV_BATTLE_BRUSH_MONSTER, handler(self.onBurshEvent, self))
    EventMgr:addEventListener(self, EV_SKILL_BRUSH_MONSTER, handler(self.onSkillBrushEvent, self))
    EventMgr:addEventListener(self, EV_PRACTICE_BRUSH_MONSTER, handler(self.onPracticeBrushEvent, self))

    self.levelCfg_ = BattleDataMgr:getLevelCfg()
    self.levelType_ = self.levelCfg_.dungeonType
    self.battleType_ = BattleDataMgr:getBattleType()
    self.team = battleController.getTeam()
    self.monsterSection_ = self.levelCfg_.monsterGroupId
    self.timeNode_ = {}

    self.affixNumber_ = self.levelCfg_.affixNumber
    self.affixIndex_ = {}
    if self.affixNumber_ > 0 then
        local affixSection = self.levelCfg_.affixSection
        local index = {}
        for i = affixSection[1], affixSection[2] do
            table.insert(index, i)
        end
        index = BattleUtils.shuffle(index)
        for i, v in ipairs(index) do
            if i <= self.affixNumber_ then
                table.insert(self.affixIndex_, v)
            end
        end
    end
    self.count_ = 0
    self.brushId_ = 1
    self.waveMonsterId_ = {}
    self.enabled = true --刷怪器开关
    self.checkTiming = 0
    self.preBrushData = {}  --缓存抢波次刷怪的配置指令
end
--刷怪是否开启
function BrushMonster:isEnabled()
    return self.enabled
end
--设置是否开启刷怪
function BrushMonster:setEnabled(enable)
    self.enabled = enable
end
function BrushMonster:initPracticeSite()
    if not self.practiceSite_ then
        self.practiceSite_ = {}
        for k, v in pairs(levelParse.visualNodes) do
            if v.type == "PointLayer" then
                if string.match(v.Mark, "monsterpoint") then
                    table.insert(self.practiceSite_, v)
                end
            end
        end
        table.sort(self.practiceSite_, function(a, b)
                       return a.Mark < b.Mark
        end)
    end
    if not self.practiceBossSite_ then
        self.practiceBossSite_ = {}
        for k, v in pairs(levelParse.visualNodes) do
            if v.type == "PointLayer" then
                if string.match(v.Mark, "bosspoint") then
                    table.insert(self.practiceBossSite_, v)
                end
            end
        end
        table.sort(self.practiceBossSite_, function(a, b)
                       return a.Mark < b.Mark
        end)
    end
end

function BrushMonster:doSlain(hero)
    if not self:isEnabled() then 
        return 
    end
    if self.levelType_ == EC_FBLevelType.PRACTICE or self.levelType_ == EC_FBLevelType.MUSIC_GAME then
        local data = hero:getData()
        self:brushPracticeMonster(data.practiceSite)
    else
        local data = hero:getData()
        local brushId = data.__brushId
        local waveIndex = data.__waveIndex
        if waveIndex then
            local waveMonsterId = self.waveMonsterId_[waveIndex]
            waveMonsterId[brushId] = nil
            if not next(waveMonsterId) then
                battleController.nextWave()
            end
        end
    end
end

function BrushMonster:update(delta)
    if not self:isEnabled() then 
        return 
    end
    for i = #self.timeNode_, 1, -1 do
        local node = self.timeNode_[i]
        if node:update(delta) then
            local monster, isEmpty = node:trigger()

            self.count_ = self.count_ + 1
            -- 词缀怪
            local index = table.indexOf(self.affixIndex_, self.count_)
            if monster.fixedAffix or index ~= -1 then
                local randIndex = RandomGenerator.random(#monster.monsterAffix)
                monster.affix = monster.monsterAffix[randIndex]
            end

            self.team:addMember({monster})
            self.team:createHeros(function()
                self.team:startfight()
            end)
            if isEmpty then
                node:complete()
                table.remove(self.timeNode_, i)
            end
        end
    end
    self:checkNextWaveData(delta)
end

function BrushMonster:checkNextWaveData(delta)
    self.checkTiming = self.checkTiming + delta
    if self.checkTiming > 1000 then
        self.checkTiming = 0
        local wave = battleController.getWave()
        for k,v in pairs(self.preBrushData) do
            if v.cfg.Count == wave then
                self:onBurshEvent(v.cfg, v.param, v.call)
                self.preBrushData[k] = nil
                break
            end
        end
    end
end

-- 关卡编辑器触发刷怪
function BrushMonster:onBurshEvent(brushCfg, params, callback)
    if not self:isEnabled() then 
        return 
    end

    local newDunStepType = TabDataMgr:getData("DiscreteData",61007).data.newDunStepType or {}
    if table.indexOf(newDunStepType,self.levelCfg_.dungeonType) ~= -1 then
        local wave = battleController.getWave()
        if brushCfg.Count > wave then
            self.preBrushData[brushCfg.Count] = {cfg = brushCfg,param = params,call = callback}
            return
        end
    end

    -- dump(brushCfg)
    -- dump(params)
    local type_ = brushCfg.Class
    local duration = brushCfg.Duration
    if type(duration) == "number" then
        duration = {duration}
    end
    local monster = {}
    local monsterSectionCid = self.monsterSection_[brushCfg.Count]
    local monsterSectionCfg = TabDataMgr:getData("MonsterSection", monsterSectionCid)
    local dir = monsterSectionCfg.finalDir
    local function getPointIdx(pointsList,index)
        if #pointsList <= 1 then
            return 1
        end
        local idx = index%(#pointsList)
        if idx == 0 then
            idx = #pointsList
        end
        return idx
    end
    if type_ == "TriggerEventSummon" then    -- 普通刷怪
        monster = self:getWaveMonster(monsterSectionCid)
        if brushCfg.SummonType == "RandomPos" then
            for i, v in ipairs(monster) do
                if brushCfg.NearbyHero == 1 then
                    v.nearByHero = true
                end
                v.position = nil
            end
        elseif brushCfg.SummonType == "OrderPoint" then
            local positionList = params[1]
            for i, v in ipairs(monster) do
                v.position = positionList[getPointIdx(positionList,i)]
            end
        elseif brushCfg.SummonType == "RandomPoint" then
            local positionList = BattleUtils.shuffle(params[1])
            for i, v in ipairs(monster) do
                v.position = positionList[getPointIdx(positionList,i)]
            end
        end
    elseif type_ == "TriggerEventSummonAdd" then    -- 补充刷怪
        monster = self:complementMonster(monsterSectionCid)
        if brushCfg.SummonType == "RandomPos" then
            for i, v in ipairs(monster) do
                if brushCfg.NearbyHero == 1 then
                    v.nearByHero = true
                end
                v.position = nil
            end
        elseif brushCfg.SummonType == "OrderPoint" then
            local positionList = params[1]
            for i, v in ipairs(monster) do
                v.position = positionList[getPointIdx(positionList,i)]
            end
        elseif brushCfg.SummonType == "RandomPoint" then
            local positionList = BattleUtils.shuffle(params[1])
            for i, v in ipairs(monster) do
                v.position = positionList[getPointIdx(positionList,i)]
            end
        end
    end
    --monster 为空的时候上报异常
    if not monster or #monster == 0 then
        if brushCfg.Class ~= "TriggerEventSummonAdd" then   --补充刷怪可能存在不需要补充的情况
            local errMsg = string.format("BrushMonster:onBurshEvent ERROR : brushCfg.Class= %s levelCfg.id =%s monsterSectionCid=%s monster is {} !",
                tostring(brushCfg.Class),tostring(self.levelCfg_.id),tostring(monsterSectionCid))
            Bugly:ReportLuaException(errMsg)
            Box(errMsg)
        end
        return
    end
    if not self:resetMonsterPosition(monster, monsterSectionCfg) then
        return
    end
    local waveMonsterId = self.waveMonsterId_[brushCfg.Count] or {}
    for i, v in ipairs(monster) do
        v.dir = dir[i] or dir[1]
        v.__brushId = self.brushId_
        v.__waveIndex = brushCfg.Count
        waveMonsterId[v.__brushId] = true
        self.brushId_ = self.brushId_ + 1
    end
    self.waveMonsterId_[brushCfg.Count] = waveMonsterId
    local function bootstrap()
        local node = TimingNode:create(duration, monster, callback)
        table.insert(self.timeNode_, node)

        if monsterSectionCfg.helpPerson then
            battleController.activateAssit()
        end
    end

    -- warining
    if monsterSectionCfg.warning then
        battleController.showWarning(bootstrap)
    else
        bootstrap()
    end

end

function BrushMonster:resetMonsterPosition(monsters, monsterSectionCfg)
    if table.count(monsterSectionCfg.BrushMode) > 0 then
        local mode = monsterSectionCfg.BrushMode[1]
        local pType = mode[1]
        local posCount = #monsterSectionCfg.positions
        local prePosition
        if pType == 1 then
            if mode[2] == 1 then
                local id = monsterSectionCfg.positions[math.random(1,posCount)]
                local point = levelParse:getVisualNode(id)
                if point then
                    prePosition = {x = point.Position.X, y = point.Position.Y}
                end
            end
            for i,v in ipairs(monsters) do
                if prePosition then
                    v.position = prePosition
                else
                    local id = monsterSectionCfg.positions[math.random(1,posCount)]
                    local point = levelParse:getVisualNode(id)
                    if point then
                        v.position = {x = point.Position.X, y = point.Position.Y}
                    end
                end
            end
        elseif pType == 4 then
            for i,v in ipairs(monsters) do
                local id = monsterSectionCfg.positions[(i > posCount and i - posCount or i)]
                local point = levelParse:getVisualNode(id)
                if point then
                    v.position = {x = point.Position.X, y = point.Position.Y}
                end
            end
        elseif pType == 2 then
            local hero = battleController.getMenbers()[1]
            if not hero then
                return false
            end
            local pos = hero:getPosition()
            local rect = CCRectMake(pos.x - mode[3], pos.y - mode[3], mode[3] * 2, mode[3] * 2)
            if mode[2] == 1 then
                prePosition = levelParse:randomPos(rect)
            end
            for i,v in ipairs(monsters) do
                if prePosition then
                    v.position = prePosition
                else
                    v.position = levelParse:randomPos(rect)
                end
            end
        elseif pType == 3 then
            local hero = battleController.getTeam():getHeroWithID(mode[4])
            if not hero then
                return false
            end
            local pos = hero:getPosition()
            local rect = CCRectMake(pos.x - mode[3], pos.y - mode[3], mode[3] * 2, mode[3] * 2)
            if mode[2] == 1 then
                prePosition = levelParse:randomPos(rect)
            end
            for i,v in ipairs(monsters) do
                if prePosition then
                    v.position = prePosition
                else
                    v.position = levelParse:randomPos(rect)
                end
            end
        elseif pType == 5 then
            local temp = clone(monsterSectionCfg.positions)
            local points = {}
            local function func() 
                local len = #temp 
                return len > 0
            end
            while func() do
                local randomIdx = math.random(1, #temp)
                table.insert(points, temp[randomIdx])
                table.remove(temp, randomIdx)
            end
            for i,v in ipairs(monsters) do
                local id = points[i] or points[1]
                local point = levelParse:getVisualNode(id)
                if point then
                    v.position = {x = point.Position.X, y = point.Position.Y}
                end
            end
        end
    end

    return true
end

-- 技能触发刷怪
function BrushMonster:onSkillBrushEvent(hero, monsterSectionCid, position, level,dir)
    if not self:isEnabled() then 
        return 
    end
    local monsterSectionCfg = TabDataMgr:getData("MonsterSection", monsterSectionCid)
    local waveMonster = self:getWaveMonster(monsterSectionCid)
    local dir = monsterSectionCfg.finalDir
    if #waveMonster > 1 then
        for i, v in ipairs(waveMonster) do
            v.position = nil
            v.level = level
            v.dir = hero:getDir()
        end
    else
        local _, monster = next(waveMonster)
        if monster then
            monster.position = position
            monster.level = level
            monster.dir = hero:getDir()
        end
    end
    if not self:resetMonsterPosition(waveMonster, monsterSectionCfg) then
        return
    end
    local team = hero:getTeam()
    team:addMember(waveMonster)
    team:createHeros(nil,hero)
end

function BrushMonster:brushPracticeMonster(site)
    if not self:isEnabled() then 
        return 
    end
    BrushMonster:initPracticeSite()
    local practiceData = BattleDataMgr:getPracticeData()
    if self.levelCfg_.dungeonType == EC_FBLevelType.MUSIC_GAME then
        practiceData = BattleDataMgr:getMusicGameCustomData()
    end
    local battleData = battleController.getBattleData()

    local waveMonster = {}
    if self.practiceMode_ == 1 then
        local monsterSectionCid = self.levelCfg_.monsterGroupId[practiceData.diffIndex]
        local monsterSectionCfg = TabDataMgr:getData("MonsterSection", monsterSectionCid)
        waveMonster = self:getWaveMonster(monsterSectionCid)
        waveMonster = {waveMonster[practiceData.categoryIndex]}
        if not self.practiceSite_[site] then
            site = #self.practiceSite_
        end
        battleData.cameraAmend = monsterSectionCfg.dungencamera
    else
        local monsterSectionCid = self.levelCfg_.heroForbiddenID[practiceData.specialCategoryIndex]
        local monsterSectionCfg = TabDataMgr:getData("MonsterSection", monsterSectionCid)
        waveMonster = self:getWaveMonster(monsterSectionCid)
        waveMonster = {waveMonster[1]}
        site = practiceData.specialCategoryIndex
        if not self.practiceBossSite_[site] then
            site = #self.practiceBossSite_
        end
        battleData.cameraAmend = monsterSectionCfg.dungencamera
    end

    local position = self.practiceMode_ == 1 and self.practiceSite_[site].Position or self.practiceBossSite_[site].Position
    local levelIndex = self.practiceMode_ == 1 and practiceData.levelIndex or practiceData.specialLevelIndex
    local level = self.practiceMode_ == 1 and practiceData.level or practiceData.specialLevel
    local superIndex = self.practiceMode_ == 1 and practiceData.superIndex or nil
    local hpIndex = self.practiceMode_ == 1 and practiceData.hpIndex or practiceData.specialHpIndex

    for i, v in ipairs(waveMonster) do
        if levelIndex == 1 then
            v.level = level
        else
            v.level = MainPlayer:getPlayerLv()
        end
        v.position = ccp(position.X, position.Y)
        v.practiceSite = site
        if superIndex == 2 then
            v.stiffness = nil
        end
    end

    self.team:addMember(waveMonster)
    self.team:createHeros(function()
        self.team:startfight()
    end)

    if hpIndex ~= 1 then
        local heros = battleController.getEnemyMember()
        for i, v in ipairs(heros) do
            v:setFlag(eFlag.HP_AUTO_RECOVERY)
        end
    end
end

-- 木桩刷怪
function BrushMonster:onPracticeBrushEvent(mode)
    if not self:isEnabled() then 
        return 
    end
    self.practiceMode_ = mode or 1
    local heros = battleController.getEnemyMember()
    for i, v in ipairs(heros) do
        EventMgr:dispatchEvent(eEvent.EVENT_BOSS_CHANGE, nil)
        v:killMySelf()
    end

    local number = 1
    if self.practiceMode_ == 1 then
        local practiceData = BattleDataMgr:getPracticeData()
        number = practiceData.number
    end
    if self.levelCfg_.dungeonType == EC_FBLevelType.MUSIC_GAME then
        number = 1
    end
    for i = 1, number do
        self:brushPracticeMonster(i)
    end
end

function BrushMonster:isRandomPool(monsterSectionCid)
    local monsterSectionCfg = TabDataMgr:getData("MonsterSection", monsterSectionCid)
    local isRandomPool = (#monsterSectionCfg.fixedMonster == 0)
    return isRandomPool
end

function BrushMonster:complementMonster(monsterSectionCid)
    local monsterSectionCfg = TabDataMgr:getData("MonsterSection", monsterSectionCid)
    local aliveHeros = self.team:getMenbers(eCampType.Monster)
    local isRandomPool = self:isRandomPool(monsterSectionCid)
    local monster = {}
    if isRandomPool then
    else
        local herodMap = {}
        for i, v in ipairs(aliveHeros) do
            local data = v:getData()
            local count = herodMap[data.id] or 0
            herodMap[data.id] = count + 1
        end
        for i, v in ipairs(monsterSectionCfg.fixedMonster) do
            if not herodMap[v] then
                herodMap[v] = 0
            end
            if herodMap[v] then
                if herodMap[v] > 0 then
                    herodMap[v] = herodMap[v] - 1
                else
                    table.insert(monster, v)
                end
            end
        end
    end

    local waveMonster = self:transData(monsterSectionCid, monster)

    for i, v in ipairs(waveMonster) do
        local random = RandomGenerator.random(100)
        if random <= v.drop then
            local randomIndex = RandomGenerator.random(#v.dropID)
            local dropID = v.dropID[randomIndex]
            v.realDropID = dropID
        end
    end

    return waveMonster
end

function BrushMonster:getWaveMonster(monsterSectionCid)
    local monster = {}
    local monsterSectionCfg = TabDataMgr:getData("MonsterSection", monsterSectionCid)
    local isRandomPool = self:isRandomPool(monsterSectionCid)
    if isRandomPool then
        for _, v in ipairs(monsterSectionCfg.randomMonster) do
            local poolCid = v[1]
            local count = v[2]
            local m = self:randomMonster(poolCid, count)
            table.insertTo(monster, m)
        end
    else
        table.insertTo(monster, monsterSectionCfg.fixedMonster)
    end

    local waveMonster = self:transData(monsterSectionCid, monster)

    for i, v in ipairs(waveMonster) do
        -- 掉落
        local random = RandomGenerator.random(100)
        if random <= v.drop then
            local randomIndex = RandomGenerator.random(#v.dropID)
            local dropID = v.dropID[randomIndex]
            v.realDropID = dropID
        end
        -- 怪物mask
        if monsterSectionCfg.MonsterMark then
            if monsterSectionCfg.MonsterMark[i] then 
                v.markID = monsterSectionCfg.MonsterMark[i]
            end
        end
    end

    return waveMonster
end

function BrushMonster:randomMonster(poolCid, count)
    local monster = {}
    local monsterPoolCfg = TabDataMgr:getData("MonsterPool", poolCid)
    local data = monsterPoolCfg.data
    local poolType = monsterPoolCfg.poolType
    local pool = {}

    if poolType == 1 then
        pool = data
    elseif poolType == 2 then
        local type_ = data[1]
        local subType = data[2]
        local orgnazitionType = data[3]
        local monsterTypeMap = BattleDataMgr:getMonsterByType(type_)
        for i, v in ipairs(monsterTypeMap) do
            local monsterCfg = self:getMonsterCfg(v)
            if monsterCfg.subType == subType and monsterCfg.orgnazitionType == orgnazitionType then
                table.insert(pool, v)
            end
        end
    end
    for i = 1, count do
        local index = RandomGenerator.random(#pool)
        table.insert(monster, pool[index])
    end

    return monster
end

function BrushMonster:transData(monsterSectionCid, monster)
    local monsterSectionCfg = TabDataMgr:getData("MonsterSection", monsterSectionCid)
    local waveMonster = {}
    local monsterAttr = self.levelCfg_.monsterAttr

    for i, v in ipairs(monster) do
        local rawData = {}
        rawData.id = v
        if self.battleType_ == EC_BattleType.ENDLESS then
            rawData.level = self.levelCfg_.dungeonLevel
        else
            if self.levelCfg_.dungeonType == EC_FBLevelType.SPRITE then
                local offsetLevel = Utils:getKVP(24001, "number")
                local level = MainPlayer:getPlayerLv() + offsetLevel
                rawData.level = level
            elseif self.levelCfg_.dungeonType == EC_FBLevelType.HWX_TOWER then
                local level = LinkageHwxDataMgr:getFightFloorId(self.levelCfg_.id)
                if level then
                    rawData.level = level
                else
                    if monsterAttr.levelType == 1 then
                        rawData.level = MainPlayer:getPlayerLv()
                        if monsterAttr.offsetLevel then
                            rawData.level = rawData.level + monsterAttr.offsetLevel
                        end
                    else
                        rawData.level = monsterSectionCfg.level[1]
                    end
                end
            elseif self.levelCfg_.dungeonType == EC_FBLevelType.KABALATREE then
                local offsetLevel = Utils:getKVP(28001, "number")
                local level = MainPlayer:getPlayerLv() + offsetLevel
                rawData.level = level
            else
                if monsterAttr.levelType == 1 then
                    rawData.level = MainPlayer:getPlayerLv()
                    if monsterAttr.offsetLevel then
                        rawData.level = rawData.level + monsterAttr.offsetLevel
                    end
                else
                    rawData.level = monsterSectionCfg.level[1]
                end
            end
        end
        if rawData.level then
            rawData.level = math.max(1, rawData.level)
        end
        local data = BattleDataMgr:transData(eRoleType.Monster, rawData)
        table.insert(waveMonster, data)
    end
    return waveMonster
end

function BrushMonster:getStage()
    return 1
end

return BrushMonster
