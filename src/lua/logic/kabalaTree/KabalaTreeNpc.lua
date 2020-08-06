local KabalaTreeNpc = class("KabalaTreeNpc")

function KabalaTreeNpc:ctor()

	self.isMoving = false
	self.isStopMove = false
end

--初始化player
function KabalaTreeNpc:initPlayerInfo(Panel_player,mn_position,scale)

	self.Panel_player = Panel_player
	self.playermode =  TFDirector:getChildByPath(self.Panel_player, 'Image_airship')
	self.radarFlag = TFDirector:getChildByPath(self.Panel_player, 'Image_sradar')
	self.Label_time = TFDirector:getChildByPath(self.radarFlag, 'Label_time')
	self.Label_time:setText("")
	self.LoadingBar_cooldown = TFDirector:getChildByPath(self.radarFlag, 'LoadingBar_cooldown')
	self.LoadingBar_cooldown:setPercent(0)
	self.Image_normal = TFDirector:getChildByPath(self.radarFlag, 'Image_normal')
	self.Image_normal:setVisible(true)

    self:setScale(scale)
    self:setDirection(-1)
    self.playermode:setTexture("ui/kabalatree/ship1.png")
    self:setPositiontMN(mn_position)
    self:setRadarFlagVisible(false)
    self:setPalyerState("stand")

    self.radarFlag:addMEListener(TFWIDGET_TOUCHBEGAN,handler(self.beginClickSearch,self))
    self.radarFlag:addMEListener(TFWIDGET_TOUCHENDED,handler(self.endClickSearch,self))
end

function KabalaTreeNpc:setPosition(position)

	self.position = position
	self.Panel_player:setPosition(position)
	self.Panel_player:setZOrder(2)
end

function KabalaTreeNpc:getPostion()
	return self.position
end

function KabalaTreeNpc:setPositiontMN(mn_position)

	if not mn_position then
		return
	end
	
	self.mn_position = mn_position
	local position = KabalaTreeDataMgr:convertToPos(mn_position.x,mn_position.y)
    position =  KabalaTreeDataMgr:convertToPosAR(position.x,position.y)
    position = ccp(position.x-10,position.y-20)
    self:setPosition(position)
end

function KabalaTreeNpc:getPositiontMN()
	return self.mn_position
end

function KabalaTreeNpc:setScale(scale)

	self.scale = scale
	self.playermode:setScale(scale)
end

function KabalaTreeNpc:setDirection(dir)

	self.direction = dir
	local posX = self.direction == 1 and -33 or 0
	self.playermode:setPositionX(posX)
	self.playermode:setScaleX(self.direction*self.scale)
end

function KabalaTreeNpc:setPalyerState(playerState)

	self.playerState = playerState

	self:play(playerState)
end

function KabalaTreeNpc:getPlayerState()
	
	return self.playerState
end

function KabalaTreeNpc:play(action)

	if action == "stand" then
		local offsetY = 10
	    local seqact = Sequence:create({
	        MoveBy:create(0.5, ccp(0, offsetY)),
	        MoveBy:create(0.5, ccp(0, -offsetY)),
	    })
	    self.Panel_player:runAction(RepeatForever:create(seqact))
	else
		self.Panel_player:stopAllActions()
	end
end

function KabalaTreeNpc:startMove(path,callback,finishStepCallBack)

	if not path then
		return
	end

	self:setPalyerState("moving")
	self.isStopMove = false
	self.finishMoveCallBack = callback
	self.finishStepCallBack = finishStepCallBack --走完一个返回
	self.path = path
	self.pathId = 2					--从第2个格子开始，第一个格子是当前位置
	self:sendMove(self.pathId)
end

function KabalaTreeNpc:sendMove(pathId)
	
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

	local msg = {
		desTiledPos.x,
		desTiledPos.y
	}
	TFDirector:send(c2s.QLIPHOTH_WORLD_MOVE, msg)

	hideLoading()
end

function KabalaTreeNpc:MoveTo(desTiledPos)

	if not desTiledPos then
		return
	end

	local position = KabalaTreeDataMgr:convertToPos(desTiledPos.x,desTiledPos.y)
   	position =  KabalaTreeDataMgr:convertToPosAR(position.x,position.y)
   	position = ccp(position.x-10,position.y-20)

    --设置方向
    local curPositon = self:getPostion()
	if not curPositon then
		return
	end
    local direction = position.x < curPositon.x and -1 or 1

    --计算方向
    local shipRes,dir = self:getMultiDirection(desTiledPos)
    self.playermode:setTexture(shipRes)
    self:setDirection(dir)

    --移动
    self:moveing(position)

	return true
end

--得到4方向系的方向(人物支持4方向可用)
function KabalaTreeNpc:getMultiDirection(desTiledPos)

	local curTiledPos = self:getPositiontMN()
    if curTiledPos.x == desTiledPos.x then
    	if desTiledPos.y < curTiledPos.y then
    		return "ui/kabalatree/ship1.png",-1
    	else
    		return "ui/kabalatree/ship.png",1
    	end
    end

    if curTiledPos.y == desTiledPos.y then

    	if desTiledPos.x < curTiledPos.x then
    		return "ui/kabalatree/ship1.png",1
    	else
    		return "ui/kabalatree/ship.png",-1
    	end
    end

    return "ui/kabalatree/ship1.png",-1
end

function KabalaTreeNpc:moveing(position)


	local action = Sequence:create({
        MoveTo:create(0.5,position),
        CallFunc:create(function()
        	local curPath = self.path[self.pathId]
        	self:setPositiontMN(curPath)
        	print("moving:",self.pathId)
        	--print(curPath.x,curPath.y)
        	self.position = position
            self.pathId = self.pathId+1           
            if self.finishStepCallBack then
            	self.finishStepCallBack()
            end

            self:sendMove(self.pathId)
        end)
    })
	self.Panel_player:runAction(action)
end

function KabalaTreeNpc:finishMove()
	
	self:setPalyerState("stand")

	if self.finishMoveCallBack then
		self.finishMoveCallBack()
	end
end

function KabalaTreeNpc:stopMove(stopCallBack)
	self.isStopMove = true
	self.stopCallBack = stopCallBack
end

function KabalaTreeNpc:transfor(targetPosMN,callBack)
	
	self.Panel_player:setOpacity(0)
	dump(targetPosMN)
	self:setPositiontMN(targetPosMN)
	local act = Sequence:create({
		FadeIn:create(0.5),
		CallFunc:create(function ()
			if callBack then
				callBack()
			end
		end)
	})
	self.Panel_player:runAction(act)
end

function KabalaTreeNpc:setRadarFlagVisible(visible)
	self.radarFlag:setVisible(visible)
end

function KabalaTreeNpc:getClickSearchFlage()
	return self.searchFlage
end

function KabalaTreeNpc:setClickSearchFlage(searchFlage)
	self.searchFlage = searchFlage
end

function KabalaTreeNpc:setSearchResult(result)

	if result then
		Utils:showTips(3005010)
		self:setRadarFlagVisible(false)
	else
		Utils:showTips(3005011)
	end
end

function KabalaTreeNpc:beginClickSearch()

	local scanCost = KabalaTreeDataMgr:getScanCost()
	local energyValue = KabalaTreeDataMgr:getEnergy()

	self.searchFlage = true
	if  energyValue < scanCost[1] then
		Utils:showTips(3005003)
		return
	end

	if not self._scheduleId then
		self._scheduleId   = TFDirector:addTimer(1000, -1, nil, handler(self.onCountDownPer, self))
		self.totaltime = 5
		self.Image_normal:setVisible(false)
		self.LoadingBar_cooldown:setPercent(100)
		self.Label_time:setText(self.totaltime)
		EventMgr:dispatchEvent(EV_FLASH_RADAR)
	end
end

function KabalaTreeNpc:onCountDownPer()
    
    self.totaltime = self.totaltime - 1
    if self.totaltime <= 0 then
    	self.Label_time:setText("")
    	self.LoadingBar_cooldown:setPercent(0)
    	self.Image_normal:setVisible(true)
    	self:stopSchedule()
    	TFDirector:send(c2s.QLIPHOTH_WORLD_POINT_EXPLORELO, {});
    else
    	local percent = self.totaltime/5*100
    	self.LoadingBar_cooldown:setPercent(percent)
    	self.Label_time:setText(self.totaltime)
    end
end

function KabalaTreeNpc:stopSchedule()
    if self._scheduleId then
        TFDirector:removeTimer(self._scheduleId)
        self._scheduleId = nil
    end
end

function KabalaTreeNpc:removeEvents()
    self:stopSchedule()
end

function KabalaTreeNpc:endClickSearch()
	
end

return KabalaTreeNpc