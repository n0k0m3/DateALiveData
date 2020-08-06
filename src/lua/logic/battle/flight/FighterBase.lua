local BattleUtils      = import("..BattleUtils")
local BattleConfig     = import("..BattleConfig")
local ResLoader        = import("..ResLoader")
local BattleMgr        = import("..BattleMgr")
local enum             = import("..enum")

local eFlightAnimation = enum.eFlightAnimation

local function _addChild(parent, child, index)
    if child:getParent() then
        child:retain()
        child:removeFromParent()
        parent:addObject(child, index)
        child:release()
    else
        parent:addObject(child, index)
    end
end

---@class FighterBase
local FighterBase    = class("FighterBase", function()
    local node = CCNode:create()
    BattleMgr.bindActionMgr(node)
    return node
end)

function FighterBase:ctor(captain)
    ---@type CaptainBase
    self.captain             = captain

    self.effectList          = {}
    self.skeletonEventsIndex = {}

    --是否显示外发光
    self.bShine              = false
end

function FighterBase:init(model, scale)
    scale             = scale or BattleConfig.FLIGHT_MODEL_SCALE
    --local path = string.format("effect/%s/%s",model,model)
    --self.skeletonNode = ResLoader.createSkeletonAnimation(path, scale)
    self.skeletonNode = ResLoader.createRole(model, scale)

    self.skeletonNode:setScheduleUpdateWhenEnter(false)
    self.skeletonNode:hide()

    self:addChild(self.skeletonNode)
    self.skeletonNode:addMEListener(TFARMATURE_EVENT, handler(self.onArmatureEvent, self))
end

function FighterBase:destroy()
    if self.skeletonNode then
        self.skeletonNode:removeMEListener(TFARMATURE_EVENT)
        self.skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
        self.skeletonNode:removeFromParent()
        self.skeletonNode = nil
    end
    self:destroyDebugNode()
    self:removeFromParent(true)
end

function FighterBase:recycle()
    self.skeletonNode:setColor(me.WHITE)
    self.skeletonNode:stopAllActions()
    self:removeFromParent()
end

function FighterBase:setFlipX(flipX)
    local scaleX = self.skeletonNode:getScaleX()
    if flipX then
        scaleX= -math.abs(scaleX)
    else
        scaleX= math.abs(scaleX)
    end
    self.skeletonNode:setScaleX(scaleX)
end

function FighterBase:setDir(dir)
    if dir == enum.eDir.LEFT then
        self:setFlipX(true)
    elseif dir == enum.eDir.RIGHT then
        self:setFlipX(false)
    end
end

function FighterBase:getDir()
    return self.captain:getDir()
end

--调试节点
function FighterBase:createDebugNode(panel)
    if BattleConfig.SHOW_ATK_RECT then
        local drawNode = TFDrawNode:create()
        --角色位置标识
        drawNode:setCameraMask(self:getCameraMask())
        drawNode:drawSolidCircle(me.p(0, 0), 5, 360, 36, ccc4(1, 1, 0, 1))
        self:addChild(drawNode, 999)
        if self.captain.getYRoller then
            local yRoller = self.captain:getYRoller()
            if #yRoller > 1 then
                drawNode:drawSolidCircle(me.p(0, yRoller[1] or 0), 5, 360, 26, ccc4(1, 0, 0, 1))
                drawNode:drawSolidCircle(me.p(0, -yRoller[2] or 0), 5, 360, 26, ccc4(0, 1, 0, 1))
            end
        end

        self.collisionNode = TFDrawNode:create()
        self.collisionNode:setCameraMask(self:getCameraMask())
        panel:addObject(self.collisionNode, 3)
        self:drawCollisionBox()
    end
end

function FighterBase:drawCollisionBox(points)
    if self.collisionNode then
        self.collisionNode:clear()
        if points then
            for i = 1, #points - 1 do
                self.collisionNode:drawLine(points[i], points[i + 1], ccc4(1, 0, 0, 1))
            end
        else
            local pts = self:getCollisionWithName("bdbox")
            pts[#pts+1] = pts[1]
            for i = 1, #pts - 1 do
                self.collisionNode:drawLine(pts[i], pts[i + 1], ccc4(1, 0, 0, 1))
            end
        end
    end
end

function FighterBase:destroyDebugNode()
    if self.collisionNode then
        self.collisionNode:removeFromParent()
        self.collisionNode = nil
    end
end

function FighterBase:update(dt)
    if self.bShine then
        local size = me.size(800, 1600)
        if not self.texture then
            self.texture = CCRenderTexture:create(size.width, size.height)
            self.texture:setCameraMask(self:getCameraMask())
            self.texture:setShaderProgram("GlowEX_NoFragColor", true)
            -- self.texture:setShaderProgram("GlowEX", true)
            local glState = self.texture:getGLProgramState()
            glState:setUniformVec3("GlowColor", Vec3(1, 0, 0))
            glState:setUniformVec2("TextureSize", ccp(1 / size.width, 1 / size.height))
            glState:setUniformFloat("GlowRange", 5)
            glState:setUniformFloat("GlowExpand", 1.5)
            self:addChild(self.texture)
        end
        local scalex = self.skeletonNode:getScaleX()
        local scaley = self.skeletonNode:getScaleY()
        self.texture:beginWithClear(0, 0, 0, 0)
        self.texture:setScale(1, 1)
        self.skeletonNode:show()

        self.skeletonNode:setPosition(size.width / 2, size.height / 2)
        self.skeletonNode:update(dt*0.001)
        self.skeletonNode:setScaleX(scalex / math.abs(scalex))
        self.skeletonNode:setScaleY(1)
        self.skeletonNode:visit()
        self.texture:endToLua()
        --还原数据
        self.skeletonNode:setPosition(0, 0)
        self.skeletonNode:hide()
        self.skeletonNode:setScaleX(scalex)
        self.skeletonNode:setScaleY(scaley)
        self.texture:setScale(math.abs(scalex))
    else--if not self.captain:isOffStage() then
        self.skeletonNode:update(dt*0.001)
    end
end

function FighterBase:addTo(panel)
    _addChild(panel, self, 2)--中间层
    self:createDebugNode(panel)
end

function FighterBase:setPosition(x, y)
    local setPosition = rawget(CCNode, "setPosition")
    if not y and "table" == type(x) then
        y = x.y or 0
        x = x.x or 0
    end
    setPosition(self, x, y)
    self:drawCollisionBox()
end

function FighterBase:show()
    local show = rawget(CCNode, "show")
    show(self)
    self.skeletonNode:show()
end

function FighterBase:hide()
    local hide = rawget(CCNode, "hide")
    hide(self)
    self.skeletonNode:hide()
end

function FighterBase:pause()
    self.skeletonNode:stop()
    self:pauseSchedulerAndActions()
end

function FighterBase:resume()
    self.skeletonNode:resume()
    self:resumeSchedulerAndActions()
end

function FighterBase:getSortY()
    return self.captain.sortY or self.captain.position3D.y
end

function FighterBase:getBonePosition(name)
    local pos = self:getRelativeBonePosition(name)
    return me.pAdd(self:getPosition(), pos)
end

function FighterBase:getRelativeBonePosition(name)
    local pos    = self.skeletonNode:getBonePosition(name)
    local scaleX = self.skeletonNode:getScaleX()
    local scaleY = self.skeletonNode:getScaleY()
    return ccp(pos.x * scaleX, pos.y * scaleY)
end

--模糊
function FighterBase:setShaderVague()
    self.skeletonNode:setShaderProgram("DalFWhite", true)
    local glState = self.skeletonNode:getGLProgramState()
    glState:setUniformFloat("speed", 1)
    glState:setUniformVec3("u_color", Vec3(1, 0, 1))
end

function FighterBase:getBoundingBox(boneName)
    local rect = self.skeletonNode:getBoundingBox2(boneName)
    if math.abs(rect.origin.x) > 8192
            or math.abs(rect.origin.y) > 8192
            or rect.size.width > 8192
            or rect.size.height > 8192 then
        --非法碰撞框
        rect.size.width = 0
        rect.size.width = 0
        rect.origin.x   = 0
        rect.origin.y   = 0
    end
    local pos     = ccp(self:getPosition())
    rect.origin.x = rect.origin.x + pos.x
    rect.origin.y = rect.origin.y + pos.y
    return rect
end

function FighterBase:getCollisionWithName(boneName)
    return self.skeletonNode:getCollisionWithName(boneName)
end

function FighterBase:flashRed()
    self.skeletonNode:setColor(me.RED)
    self.skeletonNode:stopAllActions()
    local actions = {
        DelayTime:create(0.2),
        CallFunc:create(function()
            self.skeletonNode:setColor(me.WHITE)
        end)
    }
    self.skeletonNode:runAction(Sequence:create(actions))
end

function FighterBase:fadeOut(callFunc)
    local fade     = FadeOut:create(0.3)
    local callback = CallFunc:create(function()
        self:setOpacity(0xff)
        self:hide()
        if callFunc then
            callFunc()
        end
    end)
    local seq = Sequence:createWithTwoActions(fade, callback)
    self:runAction(seq)
end

function FighterBase:playAni(action, loop, completeCallback, realAction)
    if not self.skeletonNode then
        return
    end
    self.animation = action --记录程序定义动作名称
    self.captain:setRoleAction(nil)
    if not realAction then
        local data = self.captain:getRoleAction(action)
        if data then
            action = data.realAction
            --save current roleAction
            self.captain:setRoleAction(data)
        end
    end
    --self:fixPosition()
    loop    = not (not loop)
    local l = loop and 1 or 0
    self.skeletonNode:play(action, l)
    if completeCallback and l == 0 then
        self.skeletonNode:addMEListener(TFARMATURE_COMPLETE, function(skeletonNode)
            --self:fixPosition()
            skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
            completeCallback(skeletonNode)
        end, self.captain)
    else
        self.skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
    end
    --切换动画 清零
    self.skeletonEventsIndex = {}
    --self.bFix = false
    --处理其实动作起始特效触发
    self.captain:doEffectEvent(0)
end

---@param name string
---@param callback function
function FighterBase:playDead(name, callback)
    self:destroyDebugNode()
end

function FighterBase:playFall(callback)
    self:playAni(eFlightAnimation.FALL, false, callback)
end

function FighterBase:getFixAnimation()
    return self.animation or "NONE"
end

function FighterBase:isInsertRect(rect)
    local pos   = self:getPosition()
    local mRect = me.rect(pos.x - 50, pos.y, 100, 120)
    return me.rectIntersectsRect(rect, mRect)
end

---@param name string
---@param scale number
---@param actionName string
---@param position ccp
---@param flipX boolean
---@param handle function
---@param zOrder number
function FighterBase:playEffect(name, scale, actionName, position, flipX, handle, zOrder)
    local effectNode = ResLoader.createEffect(name, scale)
    if actionName then
        effectNode:play(actionName, 0)
    else
        effectNode:playByIndex(0, 0)
    end
    effectNode:addMEListener(TFARMATURE_COMPLETE, function(node)
        node:removeMEListener(TFARMATURE_COMPLETE)
        node:removeFromParent()
        if type(handle) == "function" then
            handle()
        end
    end, self.captain)
    effectNode:setCameraMask(self:getCameraMask())
    effectNode:setPosition(position or ccp(0, 0))
    if flipX then
        effectNode:setScaleX(-math.abs(effectNode:getScaleX()))
    end
    self:addChild(effectNode, zOrder or 2)
    return effectNode
end

--function FighterBase:playHitEffect(name, scale,actionName, position, handle, angle, zOrder)
--    local skeletonNode = self:playEffect(name, scale, actionName, position, handle, zOrder)
--    if angle then
--        skeletonNode:setRotation(angle)
--    end
--end

function FighterBase:playEmit(barrage, config)
end

function FighterBase:playSkill(actionName, callback)
end

function FighterBase:clearEffect()
    for k, effect in ipairs(self.effectList) do
        effect:removeMEListener(TFARMATURE_COMPLETE)
        effect:removeFromParent()
    end
    self.effectList = {}
end

function FighterBase:onArmatureEvent(...)
    if self.captain then
        local event                          = BattleUtils.translateArmtureEventData(...)
        self.skeletonEventsIndex[event.name] = (self.skeletonEventsIndex[event.name] or 0) + 1
        event.pramN                          = self.skeletonEventsIndex[event.name]
        self.captain:onArmatureEvent(event)
    end
end

return FighterBase