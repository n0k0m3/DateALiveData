local GenerateNpc = class("GenerateNpc")
function GenerateNpc:ctor()

    self.isMoving = false
    self.isStopMove = false

    self.multiDir = {
        rtop = 1,
        rdown = 2,
        ltop = 3,
        ldown = 4
    }
end

--初始化player
function GenerateNpc:initPlayerInfo(Spine_hero,mn_position,scale)

    self.Spine_hero = Spine_hero
    self:setPositiontMN(mn_position)
    self:setDirection(self.multiDir.ldown)
    self:setPalyerState("stand")
end

function GenerateNpc:getPostion()
    return self.position
end

function GenerateNpc:setPositiontMN(mn_position)

    if not mn_position then
        return
    end
    DalMapDataMgr:setPlayerPosMN(mn_position)
    self.mn_position = mn_position
    local position = TiledMapDataMgr:convertToPos(mn_position.x,mn_position.y)
    position =  TiledMapDataMgr:convertToPosAR(position.x,position.y)
    position = ccp(position.x,position.y)
    self.position = position
    self.Spine_hero:setPosition(position)
    local zorder = TiledMapDataMgr:getTileZorder(mn_position.x,mn_position.y)
    self.Spine_hero:setZOrder(zorder)
end

function GenerateNpc:getPositiontMN()
    return self.mn_position
end


function GenerateNpc:setDirection(multiDir)

    local dir = 1
    if multiDir == self.multiDir.ldown then
        dir = 1
    elseif multiDir == self.multiDir.ltop then
        dir = 1
    elseif multiDir == self.multiDir.rdown then
        dir = -1
    elseif multiDir == self.multiDir.rtop then
        dir = -1
    end
    self.direction = dir
    self.multiDirection = multiDir
    self.Spine_hero:setScaleX(self.direction)

end

function GenerateNpc:setPalyerState(playerState)

    self.playerState = playerState
    self:playAnimation()
end

function GenerateNpc:getPlayerState()
    return self.playerState
end

function GenerateNpc:playAnimation()

    if self.playerState == "stand" then
        if self.multiDirection == self.multiDir.ldown or
                self.multiDirection == self.multiDir.rdown then
            self:playAni("stand")
        else
            self:playAni("stand_2")
        end
    else
        if self.multiDirection == self.multiDir.ldown or
                self.multiDirection == self.multiDir.rdown then
            self:playAni("move")
        else
            self:playAni("move_2")
        end
    end
end

function GenerateNpc:playAni(action)

    if self.animation ~= action then
        self.Spine_hero:play(action,true)
        self.animation = action
    end
end

function GenerateNpc:startMove(path,callback,finishStepCallBack)

    if not path then
        return
    end

    self.isStopMove = false
    self.finishMoveCallBack = callback
    self.finishStepCallBack = finishStepCallBack --走完一个返回
    self.path = path
    self.pathId = 2					--从第2个格子开始，第一个格子是当前位置
    self:sendMove(self.pathId)
end

function GenerateNpc:sendMove(pathId)

    local desTiledPos = self.path[pathId]
    if not desTiledPos then
        self:finishMove()
        return
    end

    if self.isStopMove then
        self:finishMove()
        if self.stopCallBack then
            self.stopCallBack()
        end
        return
    end

    --计算方向
    local multiDir = self:getMultiDirection(desTiledPos)
    self:setDirection(multiDir)
    self:setPalyerState("moving")

    local msg = {
        desTiledPos.x,
        desTiledPos.y
    }
    TFDirector:send(c2s.OFFICE_EXPLORE_OFFICE_WORLD_MOVE, msg)
    --self:MoveTo(desTiledPos)
    hideLoading()
end

function GenerateNpc:MoveTo(desTiledPos)

    if not desTiledPos then
        return
    end

    local position = TiledMapDataMgr:convertToPos(desTiledPos.x,desTiledPos.y)
    position =  TiledMapDataMgr:convertToPosAR(position.x,position.y)
    position = ccp(position.x,position.y)

    --设置方向
    local curPositon = self:getPostion()
    if not curPositon then
        return
    end

    local curTiledPos = self:getPositiontMN()
    local curzorder = TiledMapDataMgr:getTileZorder(curTiledPos.x,curTiledPos.y)
    local deszorder = TiledMapDataMgr:getTileZorder(desTiledPos.x,desTiledPos.y)
    local zorder = deszorder > curzorder and deszorder or curzorder
    self.Spine_hero:setZOrder(zorder)

    --移动
    self:moveing(position)

    return true
end

--得到4方向系的方向(人物支持4方向可用)
function GenerateNpc:getMultiDirection(desTiledPos)

    local curTiledPos = self:getPositiontMN()
    if curTiledPos.x == desTiledPos.x then
        if desTiledPos.y < curTiledPos.y then
            return self.multiDir.rtop
        else
            return self.multiDir.ldown
        end
    end

    if curTiledPos.y == desTiledPos.y then

        if desTiledPos.x < curTiledPos.x then
            return self.multiDir.ltop
        else
            return self.multiDir.rdown
        end
    end

    return self.multiDir.ldown
end

function GenerateNpc:moveing(position)


    local action = Sequence:create({
        MoveTo:create(0.5,position),
        CallFunc:create(function()
            if not self.path then
                self:finishMove()
                return
            end
            local curPath = self.path[self.pathId]
            self:setPositiontMN(curPath)
            self.position = position
            self.pathId = self.pathId+1
            if self.finishStepCallBack then
                self.finishStepCallBack()
            end

            self:sendMove(self.pathId)
        end)
    })
    self.Spine_hero:runAction(action)
end

function GenerateNpc:finishMove()

    self:setDirection(self.multiDirection)
    self:setPalyerState("stand")
    if self.finishMoveCallBack then
        self.finishMoveCallBack()
    end
end

function GenerateNpc:stopMove(stopCallBack)
    self.isStopMove = true
    self.stopCallBack = stopCallBack
end

function GenerateNpc:transfor(targetPosMN,callBack)

    self.Spine_hero:setOpacity(0)
    self:setPositiontMN(targetPosMN)
    local act = Sequence:create({
        FadeIn:create(0.5),
        CallFunc:create(function ()
            if callBack then
                callBack()
            end
        end)
    })
    self.Spine_hero:runAction(act)
end

return GenerateNpc