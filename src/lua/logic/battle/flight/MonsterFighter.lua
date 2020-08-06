local BattleUtils    = import("..BattleUtils")
local enum           = import("..enum")
local FighterBase    = import(".FighterBase")

local eFlightAnimation = enum.eFlightAnimation

---@class MonsterFighter : FighterBase
local MonsterFighter = class("MonsterFighter", FighterBase)

function MonsterFighter:ctor(captain)
    self.super.ctor(self, captain)
    --self.infoNode = CCNode:create()
    --self.infoNode:setPosition(ccp(0, 145))
    --self:addChild(self.infoNode)
    ----HP
    --local width  = 88
    --self.imageHp = TFImage:create()
    --self.imageHp:setTexture("ui/battle/n035.png")
    --self.imageHp:setScale9Enabled(true)
    --self.imageHp:setImageSizeType(TF_SIZE_SCALE9)
    --self.imageHp:setSize(me.size(width, 10))
    --self.imageHp:setCapInsets(me.rect(25, 10, 12, 0))
    --
    --
    --
    ---- self.imageHp:setPosition(ccp(0,145))
    --self.loadingBarHp = TFLoadingBar:create("ui/battle/n034.png")
    --self.loadingBarHp:setDirection(TFLOADINGBAR_LEFT)
    --self.loadingBarHp:setPercent(100)
    --
    --
    ----护盾条
    --self.loadingBarShield = TFLoadingBar:create("ui/battle/n091.png")
    --self.loadingBarShield:setDirection(TFLOADINGBAR_LEFT)
    --self.loadingBarShield:setPercent(100)
    ----TODO 等新资源替换临时设置黄色
    ---- self.loadingBarShield:setOpacity(180)
    ---- self.loadingBarShield:setColor(me.c3b(0xFF,0xFF,0))
    --
    ----抵抗值
    --width           = 82
    --self.imageRstBg = TFImage:create()
    --self.imageRstBg:setTexture("ui/battle/n037.png")
    --self.imageHp:setScale9Enabled(true)
    --self.imageRstBg:setImageSizeType(TF_SIZE_SCALE9)
    --self.imageRstBg:setSize(me.size(width, 4))
    --self.imageRstBg:setCapInsets(me.rect(20, 4, 10, 0))
    --self.imageRstBg:setPosition(ccp(-2, -8))
    --
    --self.loadingBarRst = TFLoadingBar:create("ui/battle/n036.png")
    --self.loadingBarRst:setDirection(TFLOADINGBAR_LEFT)
    --self.loadingBarRst:setPercent(50)
    ---- self.loadingBarRst:hide()
    ----护盾条黄色
    --self.imageRstBg:addChild(self.loadingBarRst)
    --
    --self.imageHp:addChild(self.loadingBarHp)
    --self.imageHp:addChild(self.loadingBarShield)
    --self.infoNode:addChild(self.imageHp)
    --self.infoNode:addChild(self.imageRstBg)
    --self.infoNode:hide()

    if self.captain.data.shadow == 1 then --1显示影子 2不显示影子
        --创建影子
        self.shadow = TFImage:create("ui/battle/shadow.png")
        self.shadow:setOpacity(0)
        self:addChild(self.shadow)
    end

    --if captain.data.type == enum.eMonsterType.MT_BOSS then
    --    local boss_logo = TFImage:create()
    --    boss_logo:setTexture("ui/battle/n095.png")
    --    boss_logo:setPosition(ccp(-55, 0))
    --    self.imageHp:addChild(boss_logo)
    --end
    local model           = self.captain.data.model
    local scale           = self.captain.data.modelSize
    self:init(model, scale)
end

function MonsterFighter:destroy()
    --if self.infoNode then
    --    self.infoNode:removeFromParent()
    --    self.infoNode = nil
    --end
    if self.shadow then
        self.shadow:removeFromParent()
        self.shadow = nil
    end
    self.super.destroy(self)
end

function MonsterFighter:reset()
    self.skeletonNode:setPosition(me.p(0,0))
    self.skeletonNode:setAnimationFps(GameConfig.ANIM_FPS)
    self.skeletonNode:setColor(me.WHITE)
    self.skeletonNode:setRotation(0)
    self.skeletonNode:setToSetupPose()
    self.skeletonNode:clearTracks()
    if self.shadow then
        self.shadow:show()
    end
end

function MonsterFighter:recycle()
    --if self.infoNode:getParent() then
    --    self.infoNode:retain()
    --    self.infoNode:removeFromParent()
    --    self:addChild(self.infoNode)
    --    self.infoNode:release()
    --    self.infoNode:hide()
    --end
    if self.shadow then
        self.shadow:hide()
    end
    self.super.recycle(self)
end

function MonsterFighter:update(dt)
    self.super.update(self, dt)
    --if self.infoNode then
    --    if self.captain.data.roleType == 3 then
    --        local pos = self:getBonePosition("body")
    --        --HP条
    --        self.infoNode:setPosition(pos.x,pos.y + 60)
    --        self.infoNode:setVisible(true)
    --    else
    --        self.infoNode:setVisible(false)
    --    end
    --end
    if self.shadow then
        local position3D = self.captain.position3D
        local pos = self:getBonePosition("body")
        local high    = pos.y - position3D.y
        local scale   = math.min(0.8,math.max(0,high)*0.001)
        local opacity = 255 - scale*200
        self.shadow:setScale(1 + scale)
        self.shadow:setOpacity(opacity)
        self.shadow:setPosition(ccp(pos.x - position3D.x, 0))
    end
end

function MonsterFighter:addTo(panel)
    self.super.addTo(self, panel)
    --if self.infoNode:getParent() then
    --    self.infoNode:retain()
    --    self.infoNode:removeFromParent()
    --    panel:addObject(self.infoNode, 3)
    --    self.infoNode:release()
    --else
    --    panel:addObject(self.infoNode, 3)
    --end
end

function MonsterFighter:setPosition(x, y)
    self.super.setPosition(self, x, y)
    local pos =  self:getPosition()
    for k, barrage in pairs(self.captain.barrages) do
        local effect = k.cfg.fireEffect
        if effect then
            pos = effect.launchPointName and self:getBonePosition(effect.launchPointName) or pos
            pos = effect.offset and pos + effect.offset or pos
        end
        barrage:setPosition(pos)
        barrage:UpdateEmitPos(pos)
    end
end

--function MonsterFighter:playBorn(callback)
--    self:playAni(eFlightAnimation.STAND, false, callback)
--end

function MonsterFighter:playDebut(actionName, callback)
    self:playAni(actionName or eFlightAnimation.DEBUT,not callback, callback )
end

function MonsterFighter:playStand()
    self:playAni(eFlightAnimation.STAND, true)
end

function MonsterFighter:playMove()
    self:playAni(eFlightAnimation.MOVE, true)
end

function MonsterFighter:playDead(name, callback)
    self.super.playDead(self)
    --if self.infoNode then
    --    self.infoNode:hide()
    --    --self.infoNode:removeFromParent()
    --    --self.infoNode = nil
    --end
    local effect = self.captain.data.deadEffect
    if effect and effect.effectName and effect.effectName ~= "" then
        self.skeletonNode:hide()
        local count = #effect.actionName
        local pos = effect.offset and effect.offset or ccp(0, 0)
        if count > 0 then
            for i, name in ipairs(effect.actionName) do
                if i == count then
                    self:playEffect(effect.effectName, effect.scale or 1, name ~= "" and name or nil, pos, false, callback)
                else
                    self:playEffect(effect.effectName, effect.scale or 1, name ~= "" and name or nil, pos)
                end
            end
        else
            self:playEffect(effect.effectName, effect.scale or 1, nil, pos, false, callback)
        end
    else
        self:playAni(name or eFlightAnimation.DIE, false, callback)
    end
end

local function __percent(value)
    if value > 0 then
        return math.max(value,5)
    else
        return 0
    end
end
function MonsterFighter:updateInfo()
    --self.loadingBarHp:setPercent(__percent(self.captain:getHpPercent()*0.01))
    --local shieldValue = self.captain:getShieldPercent()*0.01
    --if shieldValue > 0 then
    --    self.loadingBarShield:setPercent(__percent(shieldValue))
    --    self.loadingBarShield:show()
    --else
    --    self.loadingBarShield:hide()
    --end
    ----抵抗值
    --self.imageRstBg:hide()
    --if self.captain:getMaxResist() > 0 then
    --    self.loadingBarRst:setPercent(__percent(self.captain:getResistPercent()*0.01))
    --    self.imageRstBg:show()
    --else
    --    self.imageRstBg:hide()
    --end
end

return MonsterFighter