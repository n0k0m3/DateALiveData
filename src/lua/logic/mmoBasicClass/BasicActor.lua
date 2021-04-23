
--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
* 同屏基础角色类
* 
]]
local StateMachine = require("lua.logic.battle.StateMachine")
local MapUtils = import("lua.logic.osd.MapUtils")
local BattleConfig = require("lua.logic.battle.BattleConfig")
local enum = require("lua.logic.battle.enum")
local eDir = enum.eDir

local BasicActor = class("BasicActor", function()
	local node = CCNode:create()
	return node
end)

function BasicActor:ctor(data ,events,initial)
	self.fsmCfg = {}
	self.fsmCfg.events = events
	self.fsmCfg.callbacks = {
		onleavestate = handler(self.onLeaveState, self),
		onafterevent = handler(self.onAfterState, self),
		onbeforeevent = handler(self.onBeforeState, self),
		onenterstate = handler(self.onEnterState, self),
	}
	self.fsmCfg.initial = initial
	self.beforeEventCallBackMap = {}
	self.enterEventCallBackMap = {}
	self.afterEventCallBackMap = {}
	self.leaveEventCallBackMap = {}
	self:createFSM()

	self.areaRect   = data.areaRect or me.rect(0,0,300, 80)
	--点击响应区域]
	self.touchRect  = me.rect(0,0,150, 220)
	self.position3D = me.Vertex3F(0, 0, 0)
	--寻路路径
	self.autoPathList = {}
	--摇杆向量
	self.rokeVector = ccp(0, 0)

	self.speedScale = 1
	--移动状[态
	self.moveState = -1

	self.autoMove = false
	self.isCameraScale = true

	self.data = clone(data)
	self.moveSpeed = WorldRoomDataMgr:getCurControl():getBaseMoveSpeed()
	self:setDir(self.data.dir)
    self:addMEListener(TFWIDGET_CLEANUP,  handler(self._onExit,self))
    self.inWorldRoomDt = 0

end

function BasicActor:getDir()
	return self.dir
end

function BasicActor:setDir(dir)
	if dir == eDir.LEFT then
		self:setFlipX(true)
	elseif dir == eDir.RIGHT then
		self:setFlipX(false)
	end
	self.dir = dir
end

function BasicActor:_onExit(  )
	-- body
end

function BasicActor:getBonePosition(boneName)
	local pos = self:getRelativeBonePosition(boneName)
	return me.pAdd(self:getPosition(), pos)
end

function BasicActor:getRelativeBonePosition(boneName)
	if self.skeletonNode then 
		local pos = self.skeletonNode:getBonePosition(boneName)
		local scaleX = self.skeletonNode:getScaleX()
		local scaleY = self.skeletonNode:getScaleY()
		return ccp(pos.x * scaleX, pos.y * scaleY)
	end
	return ccp(0,60)
end

function BasicActor:getPid()
	return self.data.pid
end

function BasicActor:needUpdate(  )
	-- body
	return true
end

function BasicActor:getMoveSpeed()
	return self.moveSpeed * self.speedScale
end

function BasicActor:getUnsignedMoveSpeed()
	return math.abs(self.moveSpeed * self.speedScale)
end

function BasicActor:setRokeVector(vx, vy)
	self:setAutoMove(false)
	self.rokeVector.x = vx
	self.rokeVector.y = vy
end

function BasicActor:getRokeVector()
	return self.rokeVector
end

function BasicActor:ready()
	if not self.bRead then 
		-- self:createFocusEffect()
		self.bRead = true
	end
end

function BasicActor:playTalk( content )
	-- body
end

function BasicActor:update(dt,actorData)
	self.inWorldRoomDt = self.inWorldRoomDt + dt
	self:ready()
	if actorData then
		self:checkDataHasChange(dt, actorData)
	end

	if #self.autoPathList > 0 then
		self:pathMove(dt)
	end

	if not self.autoMove then
	-- 	--手动控制的角色
		self:handleMove(dt)
	end
end

function BasicActor:updateShowNode(actorData)

end

function BasicActor:removeActor()
	-- if self.groundNode then
	-- 	self.groundNode:removeFromParent()
	-- 	self.groundNode = nil
	-- end

	-- -- if self.infoNode then
	-- -- 	self.infoNode:removeFromParent()
	-- -- 	self.infoNode = nil
	-- -- end

	-- if self.touchPanel then
	-- 	self.touchPanel:removeFromParent()
	-- 	self.touchPanel = nil
	-- end

	self:removeFromParent()
end

function BasicActor:changeSkin(actorData)
	-- for k,v in pairs(actorData) do
	-- 	self.data[k] = v
	-- end 
	self:updateShowNode(actorData)
	self:setDir(self.dir or eDir.RIGHT)
	self:doEventForce("STAND")
end


function BasicActor:checkDataHasChange( dt, actorData )
	-- body
	local function checkTableIsNotEqual( tb1, tb2)
		if not tb2 then return false end
		for k,v in pairs(tb1) do
			if type(v) == "table" then
				return checkTableIsNotEqual(v, tb2[k])
			else
				if v ~= tb2[k] and k ~= "dt" then
					return true
				end
			end
		end
		return false
	end

	for k,v in pairs(actorData) do
		if k == "skinCid" or k == "effectId" or k == "pos" then -- 目前只处理这三种数据变化
			if type(v) ~= "table" then
				if self.data[k] ~= v then
					self.data[k] = v
					if k == "skinCid" or k == "effectId" then
						self:changeSkin(actorData)
					end
				end
			else
				local isNotEqual = checkTableIsNotEqual(v, self.data[k])
				if isNotEqual then
					v.dt = v.dt or 0
					if self.inWorldRoomDt < v.dt/1000 then
						self.inWorldRoomDt = v.dt/1000
						self:setPosition3D(v.x,v.y,v.y)
					end
					if k ~= "pos" or self.inWorldRoomDt > v.dt/1000 + 0.08 then -- 添加帧数等待
						self.data[k] = clone(v)
						if k == "pos" then
							if self:checkMoveState() then
								local lastPosition = self:getPosition()
								self:setPosition3D(v.x,v.y,v.y)
								self:handleMove(0.09)
								if me.pGetDistance(lastPosition,self:getPosition()) <= 30 or self:isMainHero() then -- 行走流畅度修改
									self:setPosition3D(lastPosition.x,lastPosition.y,lastPosition.y)
								end
								self._rokerVector = MapUtils:getVecByAngel(v.dir)
							end
							-- self:moveTo(ccp(v.x,v.y))
						end
					end
				end
			end
		end
	end
	
end

function BasicActor:getIsCameraScale()
	return self.isCameraScale
end

function BasicActor:isMainHero( )
	-- body
	return MainPlayer:getPlayerId() == self.data.pid
end

function BasicActor:hideSelf( show )
	-- body
	self:setVisible(show)
end

--创建状态机
function BasicActor:createFSM()
	self.stateMachine = StateMachine:instace()
	self.stateMachine:setupState(self.fsmCfg)
end

function BasicActor:addFSMBeforeEvents( eventType, callBack)
	-- body
	self.beforeEventCallBackMap[eventType] = callBack
end

function BasicActor:addFSMEnterEvents( eventType, callBack)
	-- body
	self.enterEventCallBackMap[eventType] = callBack
end

function BasicActor:addFSMAfterEvents( eventType, callBack)
	-- body
	self.afterEventCallBackMap[eventType] = callBack
end

function BasicActor:addFSMLeaveEvents( eventType, callBack)
	-- body
	self.leaveEventCallBackMap[eventType] = callBack
end

function BasicActor:removeFSMBeforeEvents( eventType )
	-- body
	self.beforeEventCallBackMap[eventType] = nil
end

function BasicActor:removeFSMEnterEvents( eventType )
	-- body
	self.enterEventCallBackMap[eventType] = nil
end

function BasicActor:removeFSMAfterEvents( eventType )
	-- body
	self.afterEventCallBackMap[eventType] = nil
end

function BasicActor:removeFSMLeaveEvents( eventType )
	-- body
	self.leaveEventCallBackMap[eventType] = nil
end

function BasicActor:onEnterState(event)
	local args = unpack(event.args)
	local fromState = event.from
	local toState = event.to

	if self.enterEventCallBackMap[toState] then
		return self.enterEventCallBackMap[toState](self, args)
	end
end

function BasicActor:onAfterState(event)
	local args = unpack(event.args)
	local fromState = event.from
	local toState = event.to

	if self.afterEventCallBackMap[toState] then
		return self.afterEventCallBackMap[toState](self, args)
	end
end

function BasicActor:onBeforeState(event)
	local args = unpack(event.args)
	local fromState = event.from
	local toState = event.to

	if self.beforeEventCallBackMap[toState] then
		return self.beforeEventCallBackMap[toState](self, args)
	end
end

function BasicActor:onLeaveState(event)
	local from = event.from
	local toState = event.to
	if self.leaveEventCallBackMap[from] then
		return self.leaveEventCallBackMap[from](self, args)
	end
end

function BasicActor:doEvent(eventName, ...)
	local canDo = self.stateMachine:canDoEvent(eventName)
	if canDo then
		self.stateMachine:doEvent(eventName, ...)
	else
		-- print("can not doEvent ".. tostring(eventName) .. " in current state " .. self:getState())
	end
	return canDo
end

function BasicActor:doEventForce(eventName, ...)
	self.stateMachine:doEventForce(eventName, ...)
end

function BasicActor:canDoEvent(eventName)
	local canDo = self.stateMachine:canDoEvent(eventName)
	return canDo
end

function BasicActor:getState()
	return self.stateMachine:getState()
end

function BasicActor:addEvent(event)
	return self.stateMachine:addEvent_(event)
end

function BasicActor:addTo(panel)
	-- Box("ADDTO MAP")
	MapUtils:addChild(panel, self, 2)             --中层
end

function BasicActor:move(xv, yv, fix)
	local moveSpeed = self:getMoveSpeed()
	if moveSpeed == 0 then return end
	
	local pos = self.position3D
	local nx = pos.x + xv
	local ny = pos.y + yv
	-- _print("xv=",xv,"yv=",yv)
	if self:canMove(nx, ny) then
		pos.x = nx
		pos.y = ny
	elseif self:canMove(nx, pos.y) and xv ~= 0 then
		pos.x = nx
	elseif self:canMove(pos.x, ny) and yv ~= 0 then
		pos.y = ny
	else
		if fix then
			if xv ~= 0 and yv == 0 then
				local mvU = self:canMove(pos.x , pos.y + MapUtils:getMapParse():getBlockSize())
				local mvD = self:canMove(pos.x , pos.y - MapUtils:getMapParse():getBlockSize())
				if mvD and mvU then
					return false
				elseif mvD then
					pos.y = pos.y - math.abs(xv)
				elseif mvU then
					pos.y = pos.y + math.abs(xv)
				else
					return false
				end
			else
				return false
			end
		else
			return false
		end
	end

	pos.z = pos.y --逻辑位置和渲染位置相同
	self:setPosition3D(pos.x, pos.z, pos.z)
	local flag = moveSpeed * xv
	if flag < 0 then
		self:setDir(eDir.LEFT)
	elseif flag > 0 then
		self:setDir(eDir.RIGHT)
	end
	return true
end

function BasicActor:moveTo(pos, callback)
	if self.targetPos and self.targetPos.x == pos.x and self.targetPos.y == pos.y then return end
	self:setAutoMove(true)
	self.moveCallBack = callback
	self:findPath(pos)
	if #self.autoPathList > 0 then
		self.targetPos = pos
		self:doEvent("MOVE")
	else
		return false
	end
	return true
end

function BasicActor:setAutoMove(value)
	self.autoMove = value
	if self.autoMove == false then
		self:cleanAutoPath()
		self.targetPos = nil
	end

end

--寻路
function BasicActor:findPath(pos)
	if not self:canMove(pos.x, pos.y) then
		return self.autoPathList or {}
	end
	local heroPos = self:getPosition()
	self.autoPathList = MapUtils:getMapParse():find(heroPos, pos)
	return self.autoPathList
end

--根据寻路路径移动，放在update
function BasicActor:pathMove(dt)
	local speed = self:getUnsignedMoveSpeed()
	if speed == 0 then return end
	local targetPos = self.autoPathList[1]
	local pos  = self:getPosition3D()
	local distance  = me.pGetDistance(targetPos,pos)
	local sub = me.pSub(targetPos, pos)
	local _time = distance / speed
	if _time ~= 0 then
		local xv = sub.x / _time * dt
		local yv = sub.y / _time * dt
		-- _print("xv:",xv ,"yv:",yv,"sub.x:",sub.x,"sub.y:",sub.y ,"_time",_time)
		if math.abs(sub.x) < math.abs(xv) then
			xv = sub.x
		end
		if math.abs(sub.y) < math.abs(yv) then
			yv = sub.y
		end
		self:move(xv, yv)
		pos = self:getPosition3D()
		distance = me.pGetDistance(targetPos, pos)
		if distance < 1 then
			table.remove(self.autoPathList, 1)
			self:setPosition3D(targetPos.x, targetPos.y)
		end
	else
		table.remove(self.autoPathList, 1)
		self:setPosition3D(targetPos.x, targetPos.y)
	end

	if #self.autoPathList <= 0 then
		self:moveToStand()
		if self.moveCallBack then
			self.moveCallBack()
			self.moveCallBack = nil
		end
	end
end

--清空自动寻路列表
function BasicActor:cleanAutoPath()
	self.autoPathList = {}
end

--手动控制下移动处理
function BasicActor:handleMove(dt)
	if not self:checkMoveState() then return end
	local state = self:getState()
	local moveSpeed = self:getUnsignedMoveSpeed()
	if moveSpeed == 0 then return end
	moveSpeed = moveSpeed * dt
	local  vector = self._rokerVector or ccp(0,0)
	if self.isSingeActor then -- 单机玩家
		vector = self:getRokeVector()
	end
	local xv = moveSpeed * vector.x
	local yv = moveSpeed * vector.y * BattleConfig.YV_ATTENUATION_RATIO
	if xv ~= 0 or yv ~= 0 then
		if self:move(xv, yv, true) then
			self:doEvent("MOVE")
		-- else
		-- 	self:moveToStand()
		end
	else
		self:moveToStand()
	end
end

--手动移动切换到站立状态
function BasicActor:moveToStand()
	self:setAutoMove(false)
	self:doEvent("STAND")
end

function BasicActor:setFlipX(flipX)
	local node = self.skeletonNode or self.imageNode
	if node then  
		local scaleX = node:getScaleX()
		if flipX then
			scaleX = -math.abs(scaleX)
		else
			scaleX = math.abs(scaleX)
		end
		node:setScaleX(scaleX)
	end
end

function BasicActor:getFlipX() 
	if self.skeletonNode then 
		return self.skeletonNode:getScaleX() < 0
	end
	if self.imageNode then 
		return self.imageNode:getScaleX() < 0
	end
end

function BasicActor:setPosition3D(x, y, z)
	if x then
		self.position3D.x = x
	end
	if y then
		self.position3D.y = y
	end
	if z then
		self.position3D.z = z
	end

	--刷新模型位置
	self:setPosition(self.position3D.x, self.position3D.z)
end

function BasicActor:getPosition3D()
	return self.position3D
end

--npc的功能触发区域
function BasicActor:getNpcRect()
	local origin = self.areaRect.origin
	local size   = self.areaRect.size
	origin.x     = self.position3D.x - size.width/2
	origin.y     = self.position3D.y - size.height/2
	return self.areaRect
end

--手动移动的状态判断
function BasicActor:checkMoveState()
	return true
end

function BasicActor:canMove(x, y)
	return MapUtils:getMapParse():canMoveXY(x, y)
end

function BasicActor:getActorData( ... )
	-- body
	return WorldRoomDataMgr:getCurControl():getActorDataByPid(self:getPid())
end

function BasicActor:setToBornPos( index )
	-- body
	WorldRoomDataMgr:getCurControl():getBaseMap():resetToBornPos(self,index)
end

function BasicActor:serverToMove( pos )
	
end

return BasicActor

