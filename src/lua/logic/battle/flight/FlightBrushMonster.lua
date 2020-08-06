local enum               = import("..enum")
local MonsterCaptain     = import(".MonsterCaptain")
local BattleTimerManager = import("..BattleTimerManager")
local ObjectPool         = import(".ObjectPool")
local eRoleType          = enum.eRoleType
local eFlightStateEvent  = enum.eFlightStateEvent

local BRUSH_RATE         = 100 -- ms
local BRUSH_WARNING      = 1300 -- ms

---@class ObjectPool
local monsterPool        = ObjectPool.new("FLIGHT_MONSTER", 32, "release")

local FlightBrushMonster = {}

local function dumpOrbit(name)
    local orbit   = TFOrbit:LoadFromName(name)
    local content = ""
    for i, point in ipairs(orbit.points) do
        content = content .. string.format("Frame %d: {x=%f, y=%f}\n", i, point.x, point.y)
    end
    io.writefile("d:/1.txt", content, "wb")
end

function FlightBrushMonster.init()
    if FlightBrushMonster.monstersWithTiming then return end
    BulletCache._onOrbitName = function (name)
        return string.format("res/basic/barrage/orbit/%s.json", name)
    end
    local winSize            = me.EGLView:getFrameSize()
    local scaleX             = 1
    local fixedX             = 0
    if winSize.width >= GameConfig.DESIGN_SIZE.width then
        if GameConfig.WS.width == GameConfig.DESIGN_SIZE.width then
            fixedX = 200
        end
    else
        --scaleX = winSize.width/GameConfig.DESIGN_SIZE.width
    end
    local levelCfg_          = BattleDataMgr:getLevelCfg()
    local levelMonsterCfg    = {}
    levelMonsterCfg          = TabDataMgr:getData("FlyModeLevel")
    local monstersWithTiming = {}
    for _, value in pairs(levelMonsterCfg) do
        if value.levelID == levelCfg_.id then
            local cfg = monstersWithTiming[value.timing] or {}
            if not TFOrbit:LoadFromName(value.orbit) then
                Box(string.format("monster id %d no orbit %s", value.fixedMonster, value.orbit))
            end
            monstersWithTiming[value.timing] = cfg
            local tmpValue                   = clone(value)
            tmpValue.id                      = value.fixedMonster
            tmpValue.position                = ccp(value.createCoordinate.x * (scaleX)+fixedX, value.createCoordinate.y)
            local monster                    = BattleDataMgr:transData(eRoleType.Monster, tmpValue)
            monster.shadow                   = levelCfg_.fightingMode == 3 and monster.shadow or 2
            --{
            --    id             = value.fixedMonster,
            --    level          = value.level,
            --    bullet         = value.bullet,
            --    position       = ccp(value.createCoordinate.x*(scaleX), value.createCoordinate.y), --value.createCoordinate + offset,
            --    bornTime       = value.bornTime,
            --    bornActionName = value.bornActionName,
            --    turnBack       = value.turnBack,
            --    orbit          = value.orbit,
            --    angerRecovery  = value.angerRecovery,
            --    itemDrop       = value.itemDrop,
            --    itemAward      = value.ItemAward,
            --    orbitLoop      = value.isLoop,
            --    AI             = value.AI,
            --    deadEffect     = value.deadEffect,
            --    points         = value.points
            --}
            local itemDrop                   = {}
            for id, weight in pairs(monster.itemDrop) do
                itemDrop[id] = { weight = weight, data = clone(TabDataMgr:getData("FlyLevelItem", id)) }
            end
            monster.itemDrop = itemDrop
            cfg[#cfg + 1]    = monster
        end
    end
    FlightBrushMonster.monstersWithTiming = monstersWithTiming
end

function FlightBrushMonster.getMonsters()
    if not FlightBrushMonster.monstersWithTiming then
        FlightBrushMonster.init()
    end
    return FlightBrushMonster.monstersWithTiming
end

function FlightBrushMonster.pause()
    FlightBrushMonster.paused = true
end

function FlightBrushMonster.resume()
    FlightBrushMonster.paused = false
end

function FlightBrushMonster.start()
    local index              = 1
    FlightBrushMonster.timer = BattleTimerManager:addTimer(BRUSH_RATE, -1, nil, function()
        if FlightBrushMonster.paused then
            return
        end
        local monsters = FlightBrushMonster.monstersWithTiming[index * BRUSH_RATE]
        if monsters then
            for i, cfg in ipairs(monsters) do
                ---@type MonsterCaptain
                local monster = monsterPool:pop(cfg.model)
                if monster then
                    monster:reset(cfg)
                else
                    monster = MonsterCaptain:new(cfg)
                end
                monster:doEvent(eFlightStateEvent.BH_BORN, 1)
            end
        end
        local warnings = FlightBrushMonster.monstersWithTiming[index*BRUSH_RATE + BRUSH_WARNING]
        if warnings then
            for _, cfg in ipairs(warnings) do
                if cfg.warningEffect and "string" == type(cfg.warningEffect.effectName) and cfg.warningEffect.effectName ~= "" then
                    EventMgr:dispatchEvent(enum.eEvent.EVENT_BOSS_WARNING, cfg.warningEffect.effectName, cfg.warningEffect.actionName, cfg.position)
                end
            end
        end
        index = index + 1
    end)
end

function FlightBrushMonster.stop()
    if FlightBrushMonster.timer then
        BattleTimerManager:removeTimer(FlightBrushMonster.timer)
        FlightBrushMonster.timer = nil
    end
    ---@param object CaptainBase
    monsterPool:removeAll()
    FlightBrushMonster.monstersWithTiming = nil
end

return FlightBrushMonster