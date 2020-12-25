
local FISH_STATE = {
    STAND = 1,
    MOVE_BACK = 2,
    MOVE_UPORDOWN = 3,
    MOVE_FORWARD = 4
}


local Fish = class("Fish")
function Fish:ctor(Panel_fish,Panel_pool,param,fishInfo)
    self.Panel_fish = Panel_fish
    self.Panel_pool = Panel_pool
    self.param = param
    self.fishInfo = fishInfo
    self.maxDistance = self.param.maxDistance
    self.poolFloor = self.param.poolFloor
    self.initPosX = self.param.initPosX
    self.fishInfoTab = {}

end


function Fish:initData()
    self.isUpOrDown = false
    self.Probability = {5,10,20}   ---1-5 stop, 6-10 back, 11-20 upOrDown
end

function Fish:create()

    self:initData()

    local fishObj = self.Panel_fish:clone()
    self.Panel_pool:addChild(fishObj)

    self.fishObj = fishObj
    self.timer = TFDirector:getChildByPath(self.fishObj, "timer")

    local fishBaseInfo = self.fishInfo.fishBaseInfo
    self.fishObj:setContentSize(CCSizeMake(fishBaseInfo.box[1],fishBaseInfo.box[2]))
    self.spine = SkeletonAnimation:create(fishBaseInfo.spineRes)
    self.spine:play("animation",true)
    self.spine:setPosition(ccp(fishBaseInfo.offset[1],fishBaseInfo.offset[2]))
    self.fishObj:addChild(self.spine)

    local lightSpine = SkeletonAnimation:create("effect/MJ_diaoyuzhedang/MJ_diaoyuzhedang")
    lightSpine:play("animation",true)
    lightSpine:setScale(fishBaseInfo.lightScale)
    --lightSpine:setOpacity(fishBaseInfo.lightOpacity)
    lightSpine:setPosition(ccp(fishBaseInfo.lightPos[1],fishBaseInfo.lightPos[2]))
    self.fishObj:addChild(lightSpine)

    --local Image_icon = TFDirector:getChildByPath(self.fishObj, "Image_icon")
    --Image_icon:setTexture(self.fishInfo.res)

    self.moveSpeed = self.fishInfo.speed/10

    self.floorId = math.random(1,5)
    local posxId = math.random(1,#self.initPosX)
    local posX = self.initPosX[posxId]

    self.pos = ccp(posX,self.poolFloor[self.floorId])
    fishObj:setPosition(self.pos)

    local dir = math.random(0,1) == 0 and 1 or -1
    self:setDircetion(dir)

    self:startAction()
end

function Fish:setDircetion(dir)
    if not self.fishObj then
        return
    end
    self.dir = dir
    self.fishObj:setScaleX(dir)
end

function Fish:getPosition()
    if not self.fishObj then
        return
    end
    return self.fishObj:getPosition()
end

function Fish:setPosition(pos)
    if not self.fishObj then
        return
    end
    self.fishObj:setPosition(pos)
end

function Fish:getObj()
    return self.fishObj
end

function Fish:getRes()
    return self.fishInfo.res
end

function Fish:getCid()
    return self.fishInfo.id
end

function Fish:getScore()
    local num = 0
    for k,v in pairs(self.fishInfo.score) do
        num = v
        break
    end
    return num
end

function Fish:getBoxSize()
    if not self.fishObj then
        return
    end
    return self.fishObj:getContentSize()
end

function Fish:startAction()

    if not self.timer then
        return
    end

    local act = CCSequence:create({
        CCCallFunc:create(function()
            self:chooseState()
        end),
        CCDelayTime:create(1),
    })
    self.timer:runAction(CCRepeatForever:create(act))
end

function Fish:chooseState()
    if self.isUpOrDown then
        return
    end
    local randomValue = math.random(1,100)
    self.state = self:getStateByValue(randomValue)
    if self.state == FISH_STATE.MOVE_FORWARD then
        self:moveForward()
    elseif self.state == FISH_STATE.MOVE_BACK then
        self:moveBack()
    elseif self.state == FISH_STATE.MOVE_UPORDOWN then
        local random = math.random(0,1) == 0 and 1 or -1
        if self.floorId == 1 then
            random = 1
        elseif self.floorId == #self.poolFloor then
            random = -1
        end
        self:moveUpOrDown(random)
    elseif self.param == FISH_STATE.STAND then
        self:stand()
    end
end

function Fish:getStateByValue(value)

    local state = FISH_STATE.MOVE_FORWARD
    for k,v in ipairs(self.Probability) do
        if value <= v then
            state = k
            break
        end
    end

    return state
end

function Fish:moveUpOrDown(step)

    if not self.fishObj then
        return
    end

    if self.isUpOrDown then
        return
    end
    self.fishObj:stopAllActions()
    self.isMoveForward = false
    self.floorId = self.floorId + step
    if self.floorId <= 1 then
        self.floorId = 1
    end

    if self.floorId >= #self.poolFloor then
        self.floorId = #self.poolFloor
    end

    local posY = self.poolFloor[self.floorId]
    local posX = self.fishObj:getPositionX()

    local act = CCSequence:create({
        CCMoveTo:create(self.moveSpeed + 0.5,ccp(posX,posY)),
        CCCallFunc:create(function()
            self.isUpOrDown = false
        end)
    })
    self.isUpOrDown = true
    self.fishObj:runAction(act)
end

function Fish:moveBack()

    if not self.fishObj then
        return
    end

    self.fishObj:stopAllActions()
    self.isMoveForward = false
    local newdir = -self.dir
    self:setDircetion(newdir)
    self:moveForward()
end

function Fish:moveForward()

    if not self.fishObj then
        return
    end

    if self.isMoveForward then
        return
    end

    self.isMoveForward = true
    local dis = -self.dir * 20
    local act = CCSequence:create({
        CCMoveBy:create(self.moveSpeed,ccp(dis,0)),
        CCCallFunc:create(function()
            local isBorder = self:isTouchBorder()
            if isBorder then
                self:moveBack()
                return
            end
            if self.state ~=  FISH_STATE.MOVE_FORWARD then
                self.fishObj:stopAllActions()
                self.isMoveForward = false
            end
        end)
    })
    self.fishObj:runAction(CCRepeatForever:create(act))
end

function Fish:stand()
    if not self.fishObj then
        return
    end
    self.fishObj:stopAllActions()
end

function Fish:isTouchBorder()
    if not self.fishObj then
        return
    end

    local boxSize = self:getBoxSize()

    local posX = self.fishObj:getPositionX()
    local w = boxSize.width/2
    if self.dir == -1 then
        return posX >= self.param.maxDistance - w
    else
        return posX <= -self.param.maxDistance + w
    end
end

function Fish:destroy()

    if not self.fishObj then
        return
    end
    self.timer:stopAllActions()
    self.fishObj:stopAllActions()
    self.fishObj:removeFromParent()
    self.fishObj = nil
    self.timer = nil
end

function Fish:stop()
    self:stand()
    if not self.timer then
        return
    end
    self.timer:stopAllActions()
end

return Fish