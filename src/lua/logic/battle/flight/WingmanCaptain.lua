local enum         = import("..enum")
local Wingman      = import(".Wingman")


local ELAPSE_TIME = 16*8
local RELATIVE_X = 45
local RELATIVE_Y = 150

local function emitterTurn(cfg)
    for _, emit in ipairs(cfg.emitter) do
        if emit.Config.Angle <= 0 then
            emit.Config.Angle = -180 - emit.Config.Angle
        else
            emit.Config.Angle = 180 - emit.Config.Angle
        end
    end
    return cfg
end

---@class WingmanCaptain
local WingmanCaptain = class("WingmanCaptain")

function WingmanCaptain:ctor(captain, mainFighter)
    ---@type PlayerCaptain
    self.captain       = captain
    --local parent = mainFighter:getParent()
    ---@type Wingman
    self.fighter       = Wingman:new(self)
    self.fighter:setCameraMask(mainFighter:getCameraMask())
    self.fighter:retain()
    self.positionQueue = {}
    self.elapse        = 0
    self.bullet        = { index = 1, level = {} }
    for i, _ in ipairs(self.captain.data.wingman.flySkills) do
        self.bullet.level[i] = 1
    end
    EventMgr:dispatchEvent(enum.eEvent.EVENT_ACTOR_ADD_TO_LAYER, self.fighter)
end

function WingmanCaptain:setDir(dir)
    if self.barrage then
        local barrages = self.captain.data.wingman.flySkills
        local index, level = self.bullet.index, self.bullet.level
        local cfg = barrages[index][level[index]]
        self:setBarrage(emitterTurn(cfg))
    end
    if self.fighter then
        self.fighter:setDir(dir)
    end
end

function WingmanCaptain:show()
    if self.fighter then
        self.fighter:show()
    end
    self:fire()
end

function WingmanCaptain:hide()
    if self.fighter then
        self.fighter:hide()
    end
    self:ceasefire()
end

function WingmanCaptain:move(x, y)
    local pos
    local offsetX = enum.eDir.RIGHT == self.captain:getDir() and -RELATIVE_X or RELATIVE_X
    if not y and "table" == type(x) then
        pos = ccp(x.x+offsetX, x.y+RELATIVE_Y)
    else
        pos = ccp(x+offsetX, y+RELATIVE_Y)
    end
    if not self.startTick then
        if self.fighter then
            self.fighter:setPosition(pos)
        end
        if self.barrage then
            self.barrage:UpdateEmitPos(pos)
        end
    else
        self.positionQueue[#self.positionQueue + 1] = pos
    end
    self.startTick = true
end

function WingmanCaptain:upgrade(form)
    local barrages = self.captain.data.wingman.flySkills
    local index, level = self.bullet.index, self.bullet.level
    if self.bullet.index == form then
        if level[index] < #barrages[index] then
            self.barrage:Stop()
            level[index] = level[index] + 1
            local cfg = barrages[index][level[index]]
            if self.dir == enum.eDir.LEFT then
                cfg = emitterTurn(cfg)
            end
            self:setBarrage(cfg)
        end
    else
        self.bullet.index = form
        self:ready()
    end
end

function WingmanCaptain:ready()
    local barrages = self.captain.data.wingman.flySkills
    local index, level = self.bullet.index, self.bullet.level
    if #barrages > 0 and level[index] and #barrages[index] >= level[index] and barrages[index][level[index]] then
        local barrage = barrages[index][level[index]]
        if barrage then
            self:setBarrage(barrage)
        end
    end
end

function WingmanCaptain:setBarrage(cfg)
    if not self.barrage then
        local parent = self.fighter:getParent()
        self.barrage = TFBarrageEx:new(parent)
        self.barrage.owner = self.captain
        self.barrage:SetOnEmitHandle(handler(self.onEmit, self))
        self.barrage:Stop()
        self.barrage:setCameraMask(self.fighter:getCameraMask())
        parent:addChild(self.barrage, 3)
    end
    self.barrage:Emit(cfg.emitter)
    self.barrage.cfg = cfg
    local damagePercent = self.captain.data.wingman.damagePercent
    self.barrage.cfg.damagePercent = damagePercent == 0 and 1 or damagePercent*0.01
    if cfg.cfg.isLoop then
        self.barrage:Resume()
    else
        self.barrage:Stop()
    end
end

function WingmanCaptain:pause()
    if self.fighter then
        self.fighter:pause()
    end
    if self.barrage then
        self.barrage:Stop()
    end
end

function WingmanCaptain:resume()
    if self.fighter then
        self.fighter:resume()
    end
    if self.barrage then
        self.barrage:Resume()
    end
end

function WingmanCaptain:fire()
    if self.barrage then
        self.barrage:Resume()
    end
end

function WingmanCaptain:ceasefire()
    if self.barrage then
        self.barrage:Stop()
    end
end

function WingmanCaptain:hasAliveBullet()
    return BulletCache:GetBulletCount(self.barrage) > 0
end

function WingmanCaptain:hasAliveBarrage()
    return not not self.barrage
end

function WingmanCaptain:clearBullet()
    BulletCache:RecycleByOwner(self.barrage)
end

function WingmanCaptain:destroy()
    if self.barrage then
        self.barrage:Stop()
        if self.barrage.cfg and self.barrage.cfg.cfg and self.barrage.cfg.cfg.isDelete then
            self:clearBullet()
        end
        self.barrage:removeFromParent()
        self.barrage = nil
    end
    if self.fighter then
        self.fighter:destroy()
        self.fighter:release()
        self.fighter = nil
    end
end

function WingmanCaptain:update(dt)
    if self.fighter then
        self.fighter:update(dt)
    end
    if self.startTick then
        self.elapse = self.elapse + dt
        if self.elapse > ELAPSE_TIME then
            local pos = self.positionQueue[1]
            if pos then
                table.remove(self.positionQueue, 1)
                self.position = pos
                if self.fighter then
                    self.fighter:setPosition(pos)
                end
                --me.pSub(pos, self.position)
                if self.barrage then
                    self.barrage:setPosition(pos)
                    self.barrage:UpdateEmitPos(pos)
                end
            else
                self.startTick = false
                self.elapse    = 0
            end
        end
    end
end

function WingmanCaptain:onEmit(barrage, config, state, bullets)
    if state == 0 then
        if self.fighter then
            self.fighter:playEmit(barrage, config)
        end
    elseif state == 1 then
        if bullets and #bullets > 0 then
            local attacker
            local enemy
            for _, bullet in ipairs(bullets) do
                bullet:setCameraMask(self.fighter:getCameraMask())
                attacker = bullet.owner.owner
                if bullet.isFindOnce and (not attacker or not enemy) then
                    if bullet.ChooseTarget == 0 then
                        enemy = attacker:findNearestEnemy()
                    elseif bullet.ChooseTarget == 1 then
                        enemy = attacker:findRandomEnemy()
                    end
                end
                if enemy then
                    BulletCache:AimAtPos(bullet, enemy:getCenterPoint())
                end
            end
        end
    end
end

return WingmanCaptain