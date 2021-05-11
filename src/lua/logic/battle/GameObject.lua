local BattleMgr    = import(".BattleMgr")
local BattleUtils  = import(".BattleUtils")
local BattleConfig = import(".BattleConfig")
local ResLoader    = import(".ResLoader")
local Property     = import(".Property")
local enum         = import(".enum")
local levelParse   = import(".LevelParse")
local eEvent       = enum.eEvent
local eAttrType    = enum.eAttrType
-- local print       = BattleUtils.print
local propMgr     = BattleMgr.getPropMgr()
local obstacleMgr = BattleMgr.getObstacleMgr()
--资源类型
local eResType     =
{
    IMAGE    = 1 , --图片类型
    SKELETON = 2   --动画类型
}
local ELAPSE_FPS = 16
--障碍物
local GameObject = class("GameObject",function ()
    local node = CCNode:create()
    BattleMgr.bindActionMgr(node)
    return node
end)
function GameObject:ctor(data)
    self.data = data
    self.renderNode = nil
    self:addMEListener(TFWIDGET_EXIT,  handler(self._onExit,self))
    self:addMEListener(TFWIDGET_ENTER, handler(self._onEnter,self))
end

function GameObject:setScale(value)
    local setScale = rawget(CCNode, "setScale")
    setScale(self, value * (self.data.scale or 1))
end

function GameObject:getObjectID()
    return self.id
end

function GameObject:getResType()
    return self.data.resType
end

function GameObject:getRes()
    return self.data.resource
end

function GameObject:update(dt)

end

function GameObject:pause()
    self:pauseSchedulerAndActions()
    local childs = self:getChildrenList()
    for index = 0, childs:size()-1 do
        local node = childs:objectAtIndex(index)
        node:pauseSchedulerAndActions()
        -- if node.stop then
        --     node:stop()
        -- end
    end



end

function GameObject:resume()
    self:resumeSchedulerAndActions()
    local childs = self:getChildrenList()
    for index = 0, childs:size()-1 do
        local node = childs:objectAtIndex(index)
        node:resumeSchedulerAndActions()
        -- if node.resume then
        --     node:resume()
        -- end
    end
end
--缩放
function GameObject:getScale_()
    return 1
end

--是否镜像
function GameObject:isFlipX()
    return false
end

function GameObject:update(dt)

end


function GameObject:getData()
    return self.data
end
--创建渲染节点
function GameObject:createRenderNode()
    print(">>>>>",self:getResType() ,self:getRes())
    if self:getResType() == eResType.IMAGE then
        self.renderNode = TFImage:create()
        self.renderNode:setTexture(self:getRes())
        self.renderNode:setAnchorPoint(me.p(0.5,0))
        self.renderNode:setScale(self:getScale_())
        self:addChild(self.renderNode,1)

    elseif self:getResType() == eResType.SKELETON then
        self.renderNode = ResLoader.createRole(self:getRes(),self:getScale_())
        self:addChild(self.renderNode,1)
    end
    if self.renderNode then
        if self:isFlipX() then
            local scaleX = self.renderNode:getScaleX()
            self.renderNode:setScaleX(scaleX*-1)
        end
    end
    BattleMgr.bindActionMgr(self.renderNode)
end


function GameObject:playAnimation(name, loop, completeCallback)
    if self:getResType() == eResType.SKELETON then
        loop = loop and 1 or 0
        self.renderNode:play(name, loop)
        if completeCallback and loop == 0 then
            self.renderNode:addMEListener(TFARMATURE_COMPLETE,function(skeletonNode)
                    skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
                        completeCallback(skeletonNode)
                    end)
        else
            self.renderNode:removeMEListener(TFARMATURE_COMPLETE)
        end
    end
end

function GameObject:_onExit()

end

--
function GameObject:_onEnter()

end

function GameObject:active()
    EventMgr:dispatchEvent(eEvent.EVENT_EFFECT_ADD_TO_LAYER,self)
end

--排序
function GameObject:getSortY()
    return self:getPositionY()
end

-- --检查范围
-- function GameObject:getVPostionY()
--     return self:getPositionY()
-- end


function GameObject:getBodyArea()
    return {"bd_eff"}
end

--碰撞框
function GameObject:getBoundingBox()
    local pos  = self:getPosition()
    if self:getResType() == eResType.IMAGE then
        local size   = self.renderNode:getSize()
        local anchro = self.renderNode:getAnchorPoint()
        return me.rect(pos.x - anchro.x*size.width  ,  pos.y - anchro.y*size.height  ,size.width,size.height)
    else
        local rect = self.renderNode:getBoundingBox2("bd_eff")
        rect.origin = me.pAdd(pos, rect.origin)
        return rect
    end
end

function GameObject:getCollisionWithName(bdbox)
    local pos  = self:getPosition()
    if self:getResType() == eResType.IMAGE then
        local size   = self.renderNode:getSize()
        local anchro = self.renderNode:getAnchorPoint()
        return {
        me.p(pos.x - anchro.x*size.width  ,  pos.y - anchro.y*size.height ),
        me.p(pos.x - anchro.x*size.width  + size.width ,  pos.y - anchro.y*size.height ),
        me.p(pos.x - anchro.x*size.width  + size.width ,  pos.y - anchro.y*size.height  + size.height),
        me.p(pos.x - anchro.x*size.width  ,  pos.y - anchro.y*size.height  + size.height )
        }
        -- return me.rect(pos.x - anchro.x*size.width  ,  pos.y - anchro.y*size.height  ,size.width,size.height)
    else
        return self.renderNode:getCollisionWithName("bd_eff")
    end
end


---------------------障碍物----------------------
local Obstacle = class("Obstacle",GameObject)

function Obstacle:ctor(data)
    self.super.ctor(self,data)

    self.stageIndex = 1    -- 当前所处阶段
    self.hurtNum    = 0    -- 当前阶段的受击次数 
    self.bActive    = true -- 是否激活
    self:createRenderNode()
    self:playStand()

--TODO 测试用
    -- self.textName = TFLabel:create()
    -- self.textName:setText("HP:"..self.property:getHp())
    -- self.textName:setFontSize(18)
    -- self.textName:setPosition(ccp(0,0))
    -- self.textName:setAnchorPoint(me.p(0.5,0))
    -- self:addChild(self.textName)
    -- self:showGuide()

end

function Obstacle:getRes()
    return self.data.resource
end

function Obstacle:playStand()
    if self.renderNode then
        if self:getResType() == eResType.IMAGE then --图片类型不需要刷新
        elseif self:getResType() == eResType.SKELETON then --动画类型更新动画
            -- 切换动作
            local animation = self.data.stateAction[self.stageIndex]
            if animation then 
                self:playAnimation(animation,true)
            end
        end
    end
end

--默认资源类型
-- function Obstacle:playHitEffect()
    -- local stage   = self.stages[self.stageIndex]
    -- local resName = stage.behitEffect
    -- local actName = stage.behitAction
    -- print("playHitEffect:",resName,actName)
    -- if ResLoader.isValid(resName) and ResLoader.isValid(actName) then
    --     local effect = ResLoader.createEffect(resName)
    --     effect:play(actName, 0)
    --     effect:addMEListener(TFARMATURE_COMPLETE,function(skeletonNode)
    --                 skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
    --                 skeletonNode:removeFromParent()
    --             end)
    --     -- effect:setPosition(self:getPositionX(),self:getPositionY()-2)
    --     effect:setCameraMask(self:getCameraMask())
    --     self:addChild(effect,1)
    -- end
    -- --受击特效资源
-- end

--破碎(添加到地图上)
function Obstacle:playBreakEffect()
    local resName = self.data.breakResource
    local actName = self.data.breakAction
    print("playBreakEffect",resName)
    if ResLoader.isValid(resName) then
        local effect = ResLoader.createEffect(resName)
        effect:play(actName, 0)
        effect:addMEListener(TFARMATURE_COMPLETE,function(skeletonNode)
                    skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
                    if skeletonNode.resPath then
                        ResLoader.addCacheSpine(skeletonNode,skeletonNode.resPath)
                    end
                    skeletonNode:removeFromParent()
                end)
        effect:setPosition(self:getPositionX(),self:getPositionY()-2)
        EventMgr:dispatchEvent(eEvent.EVENT_EFFECT_ADD_TO_LAYER,effect,2)
    end
end

function Obstacle:_onExit()
    print("Obstacle",self.id ,"_onExit")
    obstacleMgr:remove(self)
    self:DeActivateBlock()
end

function Obstacle:_onEnter()
    print("Obstacle",self.id ,"_onEnter")
    obstacleMgr:add(self)
    self:ActivateBlock()
    self:debugDraw()
end

function Obstacle:canHurt()
    return self.bActive and self.data.isHit
end
--受击区域
function Obstacle:getBodyArea()
    return {self.data.crashBox}
end

--获取阻挡区域
function Obstacle:getBlockPoints()
    if self:getResType() == eResType.IMAGE then
        -- print("getCollisionWithName1:"..tostring(bdbox))
        local pos    = self:getPosition()
        local size   = self.renderNode:getSize()
        local anchro = self.renderNode:getAnchorPoint()
        size.width   = size.width * self:getScale_() 
        size.height  = size.height* 0.3 * self:getScale_()
        local pts = {
            me.p(pos.x - anchro.x*size.width  ,  pos.y - anchro.y*size.height ),
            me.p(pos.x - anchro.x*size.width  + size.width ,  pos.y - anchro.y*size.height ),
            me.p(pos.x - anchro.x*size.width  + size.width ,  pos.y - anchro.y*size.height  + size.height),
            me.p(pos.x - anchro.x*size.width  ,  pos.y - anchro.y*size.height  + size.height )
        }
        -- print(ptns)
        return  pts
    else
        return self.renderNode:getCollisionWithName(self.data.shadowBox)
    end
end

--碰撞框
function Obstacle:getBoundingBox(bdbox)
    bdbox = bdbox or "default"
    self._rects = self._rects or {} 
    -- self._rects = {}
    if not self._rects[bdbox] then 
        local pos  = self:getPosition()
        if self:getResType() == eResType.IMAGE then
            -- print("getBoundingBox1:"..tostring(bdbox))
            local size   = self.renderNode:getSize()
            size.width   = size.width * self:getScale_() 
            size.height  = size.height * self:getScale_()
            local anchro = self.renderNode:getAnchorPoint()
            self._rects[bdbox] =  me.rect(pos.x - anchro.x*size.width   ,  pos.y - anchro.y*size.height  ,size.width,size.height)
        else
            -- print("getBoundingBox2:"..tostring(bdbox))
            local rect = self.renderNode:getBoundingBox2(bdbox)
            rect.origin = me.pAdd(pos, rect.origin)
            self._rects[bdbox] = rect
        end
    end
    return  self._rects[bdbox]
end

--多边形碰撞
function Obstacle:getCollisionWithName(bdbox)
    bdbox      = bdbox or "default"
    self._ptss = self._ptss or {} 
    if not self._ptss[bdbox] then 
        local pos  = self:getPosition()
        if self:getResType() == eResType.IMAGE then
            local pos    = self:getPosition()
            local size   = self.renderNode:getSize()
            local anchro = self.renderNode:getAnchorPoint()
            size.width   = size.width  * self:getScale_() 
            size.height  = size.height * self:getScale_()
            local pts = {
                me.p(pos.x - anchro.x*size.width  ,  pos.y - anchro.y*size.height ),
                me.p(pos.x - anchro.x*size.width  + size.width ,  pos.y - anchro.y*size.height ),
                me.p(pos.x - anchro.x*size.width  + size.width ,  pos.y - anchro.y*size.height  + size.height),
                me.p(pos.x - anchro.x*size.width  ,  pos.y - anchro.y*size.height  + size.height )
            }
            self._ptss[bdbox] = pts
        else
            self._ptss[bdbox] = self.renderNode:getCollisionWithName(bdbox)
        end
    end
    return self._ptss[bdbox]
end

 function Obstacle:getRoller()
    local rect = self:getBoundingBox(self.data.shadowBox)
    if self:getResType() == eResType.IMAGE then
        return rect.origin.y , rect.origin.y + rect.size.height*0.3
    else
        return rect.origin.y , rect.origin.y + rect.size.height 
    end
end


--收到攻击
function Obstacle:doHurt(srcHero)
    -- print("Obstacle do hurt")
    if not self:canHurt() then 
        return 
    end
    self:flashRed()
    -- self:playHitEffect()
    --受击次数F
    self.hurtNum = self.hurtNum + 1
    local stateHurtNum = self.data.stateHitTimes[self.stageIndex] or 1
    if self.hurtNum >= stateHurtNum then
        if self.stageIndex < #self.data.stateHitTimes then
            self:nextStage()
        else
            --销毁
            self.bActive = false
            self.renderNode:hide()
            self:onDrop()
            self:playBreakEffect(function()end)
            self:removeFromParent()
        end
    end

end
local Debug = false --是否显示阻挡调试框
function Obstacle:debugDraw()
    if Debug then 
        if not self.drawNode then 
            self.drawNode = TFDrawNode:create()
            self:addChild(self.drawNode,9999)
            self.drawNode:setCameraMask(self:getCameraMask())
        end
        self.drawNode:clear()
        local pos = self:getPosition()
        self.drawNode:setPosition(ccp(-pos.x,-pos.y))
        if self.data.isHit then
            local pts = self:getCollisionWithName(self.data.crashBox)
            pts = clone(pts)
            pts[#pts+1] = pts[1]
            -- print(pts)
            for i = 1, #pts - 1 do
                self.drawNode:drawLine(pts[i], pts[i + 1], ccc4(0, 1 , 0, 0.5))
            end
            --rollerX 受击区域检查
            local rollerX, rollerY= self:getRoller()
            self.drawNode:drawLine(ccp(-100 + pos.x,rollerX),ccp(100 + pos.x,rollerX), ccc4(1, 0 , 1, 1))
            self.drawNode:drawLine(ccp(-100 + pos.x,rollerY),ccp(100 + pos.x,rollerY), ccc4(1, 0 , 1, 1))

        end
        if self.data.isStopRole then
            local pts = self:getBlockPoints(self.data.shadowBox)
            pts[#pts+1] = pts[1]
            -- print(pts)
            for i = 1, #pts - 1 do
                self.drawNode:drawLine(pts[i], pts[i + 1], ccc4(1, 1, 0, 1))
            end
        end
    end 
end



function Obstacle:nextStage()
    self._ptss = nil
    self._rects= nil
    self.stageIndex = self.stageIndex + 1
    self.hurtNum  = 0
    self:playStand()
end

function Obstacle:flashRed()
    if self.data.isShock then --是否抖动闪红
        --闪红
        self.renderNode:stopAllActions()
        self.renderNode:setColor(me.c3b(0xFF,0,0))
        self.renderNode:setPosition(me.p(0,0))
        local actions = {
            DelayTime:create(0.2),
            CallFunc:create(function()
                self.renderNode:setColor(me.c3b(0xFF,0xFF,0xFF))
            end)
        }
        self.renderNode:runAction(Sequence:create(actions))
        --抖动
        local shakeActions = {
            MoveBy:create(0.02,me.p(2,0)),
            MoveBy:create(0.04,me.p(-4,0)),
            MoveBy:create(0.04,me.p(4,0)),
            MoveBy:create(0.02,me.p(-2,0)),
        }
        self.renderNode:runAction(Sequence:create(shakeActions))
    end
end

--掉落处理
function Obstacle:onDrop()
    if #self.data.drop > 0 then
        local drop = self.data.drop[RandomGenerator.random(#self.data.drop)]
        local propData = TabDataMgr:getData("BattleDrop",drop)
        local prop     = GameObject.createProp(propData)
        local position = self:getPosition()
        prop:setPosition(position)
        if prop:getData().needJump then
            prop:runAction(JumpTo:create(0.5, position, 60, 1))
        end
        prop:active()
    end
end


--缩放
function Obstacle:getScale_()
    return self.data.scale
end

--是否镜像
function Obstacle:isFlipX()
    return self.data.flipX
end
local function rect2pts(col,row,blockSize)
    local pt1 = ccp(col*blockSize , row*blockSize)
    local pt2 = ccp(pt1.x, pt1.y + blockSize)
    local pt3 = ccp(pt1.x + blockSize, pt1.y + blockSize)
    local pt4 = ccp(pt1.x + blockSize, pt1.y)
    return {pt1,pt2,pt3,pt4}
end

--增加阻挡
function Obstacle:ActivateBlock()
    if self.data.isStopRole then
        if not self.blocks then
            local blockSize = levelParse:getBlockSize() 
            if self.renderNode then 
                self.renderNode:update(0.016)
            end
            local pts    = self:getBlockPoints()
            -- Box("aaa")
            -- print(pts)
            -- Box("pts")
            local rect   = BattleUtils.polygon2Rect(pts)
            local origin = rect.origin
            local size   = rect.size
            local x = math.floor(origin.x / blockSize)
            local y = math.floor(origin.y / blockSize)
            local w = math.ceil(size.width/blockSize)  + 1 
            local h = math.ceil(size.height/blockSize) + 1 
            local maxRow = levelParse:getRow() 
            local maxCol = levelParse:getCol() 
            self.blocks = {}
            for col = x, x + w do
                if col < maxCol then 
                    for row = y, y + h do
                        if row < maxRow then 
                            local _pts = rect2pts(col,row,blockSize)
                            -- print(_pts)
                            if BattleUtils.isPolygonInterSection(pts,_pts) then 
                                table.insert(self.blocks,ccp(col,row))
                            end
                        end
                    end
                end
            end
            levelParse:Activate(self.blocks)
        end
    end
end
--移除阻挡
function Obstacle:DeActivateBlock()
    if self.data.isStopRole then 
        if self.blocks then
            levelParse:DeActivate(self.blocks)
            self.blocks = nil
        end
    end
end
--是否阻挡放出型特效特效
function Obstacle:isBlockEmitEffect()
    return self.data.isStopEffect
end


function Obstacle:getSortY()
    if self.data.zorder < 0 then --最下层 
        return 0 
    elseif self.data.zorder > 0 then --最上层
        return 640
    else  --正常排序
        return self:getPositionY()
    end
end

---------------------触发性物品---------------
local BaseProp = class("BaseProp", GameObject)
function BaseProp:ctor(data)
    GameObject.ctor(self, data)
    self:createRenderNode()
    self.repeatEnable_ = true
    self.enterFlag_ = true
    self.renderNodePos = ccp(0,0)
end

function BaseProp:getScale_()
    return self.data.scale or 1
end

-- 设置是否允许重复进入
function BaseProp:setRepeatEnable(enable)
    self.repeatEnable_ = enable
end

function BaseProp:update()
    if self.repeatEnable_ or self.enterFlag_ then
        self:checkPickUp()
    end
end

function BaseProp:setTriggerCallback(callback)
    self.callback_ = callback
end

function BaseProp:onPickUp()
    self.enterFlag_ = false
    if self.callback_ then
        self.callback_(self)
    end
end

function BaseProp:setRepeatEnable(enable)
    self.repeatEnable_ = enable
end

function BaseProp:_onEnter()
    print("Prop",self.id ,"_onEnter")
    propMgr:add(self)
end

function BaseProp:_onExit()
    print("Prop",self.id ,"_onExit")
    propMgr:remove(self)
end

function BaseProp:getPickUpRect()
    local pos  = self:getPosition()
    local size = me.size(120,160)
    return me.rect(pos.x - size.width*0.5  ,  pos.y - size.height*0.5 +self.renderNodePos.y  ,size.width,size.height)
end

function BaseProp:checkRoller(hero)
    if hero.elide_ then return true end -- 忽略范围检查
    local pos     = self:getPosition()
    local heroPos = hero:getPosition()
    if heroPos.y > pos.y + 50 or heroPos.y < pos.y - 50 then 
        return false
    -- elseif heroPos.x > pos.x + 100 or heroPos.x < pos.x - 100 then 
        -- return false
    end
    return true
end

function BaseProp:checkPickUp()
    local heros = BattleMgr:getHeroMgr():getObjects()
    for _, hero in ipairs(heros) do
        local roleType = hero:getData().roleType
        if hero:isAlive() and (roleType == enum.eRoleType.Hero or roleType == enum.eRoleType.Team) then
            if self:checkRoller(hero) then  
                local rect = self:getPickUpRect()
                if hero:hitTestProp(rect) then
                    self:onPickUp(hero)
                    return true
                end
            end
        end
    end
end

---------------------道具---------------

--道具消失时倒计时
local countDownTime = 3
local Prop = class("Prop", BaseProp)
function Prop:ctor(data)
    self.super.ctor(self, data)
    self.nElapsed = 0
    self.nExistTime = self.data.existTime*1000 + countDownTime*3
    self.bTriggerTint = false

    self:playStand()
    self:playStandEffect()
    --道具支持粒子特效
    if ResLoader.isValid(data.particle) then
        self.particleNode = TFParticle:create(data.particle)
        if self.particleNode then --防止粒子特效创建失败
            self:addChild(self.particleNode,99)
            self.particleNode:show()
            self.particleNode:resetSystem()  
        end
    end
end

function Prop:setRenderNodePos(pos)
    self.renderNodePos = pos
    if self.renderNode then 
        self.renderNode:setPosition(self.renderNodePos) 
    end
    if self.standEffect then 
        self.standEffect:setPosition(self.renderNodePos) 
    end
    self:updateParticleNode()
end


function Prop:updateParticleNode()
    if self.particleNode then
        local resType = self:getResType()
        if resType == eResType.SKELETON then
            local pos   = self.renderNode:getBonePosition(self.data.mount)
            local scale = self.renderNode:getScaleX()
            pos.x = pos.x*scale
            pos.y = pos.y*math.abs(scale) + self.renderNodePos.y
            self.particleNode:setPosition(pos)
        else 
            local pos = self.renderNode:getPosition()
            self.particleNode:setPosition(pos)
        end
    end
end

function Prop:playStand()
    if self:getResType() == eResType.SKELETON then
        self:playAnimation(self.data.action , true)
    else
        local actions =
        {   MoveBy:create(1,me.p(0,15)),
            MoveBy:create(1,me.p(0,-15))
        }

        local action = CCRepeatForever:create(Sequence:create(actions))
        self.renderNode:runAction(action)
    end

end

--播放待机特效
function Prop:playStandEffect()
    local resName = self.data.standResource
    local actName = self.data.standAction
    if ResLoader.isValid(resName) then
        self.standEffect = ResLoader.createEffect(resName)
        self.standEffect:play(actName, 1)
        -- effect:setPosition(0,0)
        self.standEffect:setCameraMask(self:getCameraMask())
        self:addChild(self.standEffect,1)
    end
end

function Prop:isDone()
    return self.nElapsed >= self.nExistTime
end

function Prop:onTint()
    self.renderNode:runAction(Blink:create(countDownTime,countDownTime*3))
end

function Prop:onPickUp(hero)
    -- local args =
    -- {
    --     ScaleTo:create(0.5,0.1),
    --     CallFunc:create(function()
    --         hero:onPickUp(self)
    --         self:removeFromParent()
    --     end)
    -- }
    -- self:runAction(Sequence:create(args))
    hero:onPickUp(self)
end
--道具拾取区域
local DefaultSize = me.size(120,120)
function Prop:getPickUpRect()
    local pos  = self:getPosition()
    if self:getResType() == eResType.SKELETON then
        if ResLoader.isValid(self.data.mount) then 
            local _pos = self.renderNode:getBonePosition(self.data.mount)
            local scale = self.renderNode:getScaleX()
            _pos.x = _pos.x*scale
            _pos.y = _pos.y*math.abs(scale) + self.renderNodePos.y
            pos.x = pos.x + _pos.x
            pos.y = pos.y + _pos.y
            local size = DefaultSize
            return me.rect(pos.x -size.width*0.5, pos.y -size.height*0.5,size.width,size.height)
        else
            local size = DefaultSize
            pos.y = pos.y + self.renderNodePos.y
            return me.rect(pos.x -size.width*0.5, pos.y -size.height*0.5 ,size.width,size.height)
        end
    else
        local size = DefaultSize
        pos.y = pos.y + self.renderNodePos.y
        return me.rect(pos.x -size.width*0.5, pos.y ,size.width,size.height)
    end

end

function Prop:update(dt)
    self.nElapsed = self.nElapsed + dt
    -- print("self.nElapsed",self.nElapsed)
    if self:isDone() then
        self:removeFromParent()
        return
    end
    if self:checkPickUp() then
        -- propMgr:remove(self) --移除后停止更新
        self:removeFromParent()
        return
    end
    self:updateParticleNode()
    if not self.bTriggerTint then
        if self.nExistTime - self.nElapsed < countDownTime*1000 then
            self:onTint()
            self.bTriggerTint = true
        end
    end
    if self.data.orbit then
        local deltaTime = math.floor(dt)
        self.elapse = (self.elapse or 0) + deltaTime * math.abs(self.TimeScale or 1)

        while self.elapse >= ELAPSE_FPS do
            self.orbitIndex = (self.orbitIndex or 0) + 1
            local pos = self.data.orbit[self.orbitIndex]
            if pos then
                self:setPosition(pos)
            end
            self.elapse = self.elapse - ELAPSE_FPS
        end
    end
end
-----------------------------
--跳转点状态
local eJumpPointState = 
{

    not_active = 0, --未激活
    activation = 1, --激活
    Invalid    = 2, --失效
}

local JP_actions= 
{
    [1] =  {"L_0", "L_1" , "L_2"} ,
    [2] =  {"R_0", "R_1" , "R_2"} ,
    [3] =  {"U_0", "U_1" , "U_2"} ,
    [4] =  {"D_0", "D_1" , "D_2"}
}
--跳转点size
local JP_sizes =
{
    [1] =  me.size(200,120) ,
    [2] =  me.size(200,120) ,
    [3] =  me.size(120,200) ,
    [4] =  me.size(120,200) 
} 
--跳转点
--(未激活/激活/失效)
local JumpPoint = class("JumpPoint",function ()
    local node = CCNode:create()
    BattleMgr.bindActionMgr(node)
    return node
end)

function JumpPoint:ctor(data)
    self.data    = data
    self.nState  = eJumpPointState.not_active
    self:addMEListener(TFWIDGET_EXIT,  handler(self._onExit,self))
    self:addMEListener(TFWIDGET_ENTER, handler(self._onEnter,self))
    self.renderNode = ResLoader.createRole(self:getRes(),self:getScale_())
    self.renderNode:setToSetupPose()
    if self.data.index > 4 or self.data.index < 1 then
        Box("跳转点方位配置有误")
    end
    self.animations = JP_actions[self.data.index]
    self.renderNode:play(self.animations[1], 1)
    self:addChild(self.renderNode,1)
    --设置位置
    self:setPosition(self.data.pos)
    --初始化碰撞区域
    local pos  = self.data.pos
    local size = me.size(200,200)
    --初始化碰撞区域
    -- self.hitTect = me.rect(pos.x -size.width*0.5, pos.y - size.height*0.5 ,size.width,size.height)
    self.nDelayTime = 6000 
end

function JumpPoint:getObjectID()
    return self.id
end

function JumpPoint:pause()

end

function JumpPoint:resume()

end
function JumpPoint:getRes()
    return self.data.res
end

function JumpPoint:getScale_()
    return 1
end
function JumpPoint:setState(state)
    if state ~= self.nState then 
        if state == eJumpPointState.activation then
            if self.nDelayTime < 3000 then 
                self.nDelayTime = 3000
            end
            self.renderNode:play(self.animations[2], 0)
            self.renderNode:addMEListener(TFARMATURE_COMPLETE,function(skeletonNode)
                skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
                self.renderNode:play(self.animations[3], 1)
            end)
        end
    end
    self.nState = state
end

-- function JumpPoint:getRect()
--     local pos  = self:getPosition()
--     local size = me.size(200,120)
--     return me.rect(pos.x -size.width*0.5, pos.y - size.height*0.5 ,size.width,size.height)
-- end

--碰撞框
function JumpPoint:getBoundingBox()
    local pos   = self:getPosition()
    local rect  = self.renderNode:getBoundingBox2("box_gate")
    rect.origin = me.pAdd(pos, rect.origin)
    return rect
end


--检查和角色碰撞
function JumpPoint:update(dt)
    if self.nDelayTime > 0 then 
        self.nDelayTime = self.nDelayTime - dt
        self.nDelayTime = math.max(self.nDelayTime,0)
        -- print(self.nDelayTime ,dt)
        return
    end
    if self.nState == eJumpPointState.activation then
        local hero = battleController.getCaptain()
        if hero and hero:isLeader() then 
            local position = self:getPosition()
            local rect = self:getBoundingBox()
            if me.rectContainsPoint(rect,hero:getPosition3D()) then 
                self:setState(eJumpPointState.Invalid)
                EventMgr:dispatchEvent(eEvent.EVENT_TRIGGER_JUMP,self.data.index)
            end
        end
    end
end

function JumpPoint:onStateChange(state)
    self:setState(state)
end

function JumpPoint:_onEnter()
    print("JumpPoint",self.id ,"_onEnter")
    EventMgr:addEventListener(self,eEvent.EVENT_CHANGE_JUMPPOINT_STATE, handler(self.onStateChange, self))
    propMgr:add(self)
end

function JumpPoint:_onExit()
    print("JumpPoint",self.id ,"_onExit")
    EventMgr:removeEventListenerByTarget(self)
    propMgr:remove(self)
end

function JumpPoint:active()
    EventMgr:dispatchEvent(eEvent.EVENT_EFFECT_ADD_TO_LAYER,self)
end

--排序
function JumpPoint:getSortY()
    return self:getPositionY()
end

-- function JumpPoint:doTrigger()
--     local hero = battleController.getCaptain()
--     if hero and hero:isLeader() then 
--         if hero:hitTestProp(self.hitTect) then
--             self:setState(2)
--         end
--     end
-- end

-- --播放
-- function JumpPoint:playAnimation(name, loop, completeCallback)
--     loop = loop and 1 or 0
--     self.renderNode:play(name, loop)
--     if completeCallback and loop == 0 then
--         self.renderNode:addMEListener(TFARMATURE_COMPLETE,function(skeletonNode)
--                 skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
--                     completeCallback(skeletonNode)
--                 end)
--     else
--         self.renderNode:removeMEListener(TFARMATURE_COMPLETE)
--     end
-- end


----------------------------------

--创建障碍
function GameObject.createObstacle(data)
    print("GameObject.create")
    return Obstacle:new(data)
end

function GameObject.createProp(data)
    return Prop:new(data)
end

function GameObject.createBaseProp(data)
    return BaseProp:new(data)
end

function GameObject.createJumpPoint(data)
    return JumpPoint:new(data)
end
return GameObject
