local RoleBehave = class("RoleBehave")

function RoleBehave:ctor(param)
	self.tarNode = param.tarNode
	self.objId = param.objId
	self.AIEnable = false
	self.controller = param.controller
	self:initData()
end

function RoleBehave:initData()
	self.timerhandleList = {}
	self.talkGroup = self.tarNode.aiword.normal
	math.randomseed(tonumber(tostring(os.time()):reverse():sub(1, 7)))
end

function RoleBehave:getMoodEmoj()
	self.moodEmojList = {
		[6] = "hungry",
		[7] = "angry",
		[8] = "boring",
	}
	self.state = self.tarNode.state
	local emoj = self.moodEmojList[self.state]
	return emoj
end

function RoleBehave:getSpecialEmoj()
	local specialEmojList = {
	"special1",
	"special2",
	"special3"
}
	return specialEmojList
end

function RoleBehave:getBehaveList()
	--临时行为列表
	local behaveList = {
		"freemove",
		"freetalk",
		"idle",
		"randomEmoj",
	}
	if self.tarNode.bid >= 100 then
		table.insert(behaveList, "interact")
	end
	return behaveList
end

function RoleBehave:reportBornPos(pos)
	self.bornPos = pos
	self:getMapInfo()
end

function RoleBehave:getMapInfo()
	self.mapInfo = self.controller:getMapInfo(self.tarNode.bid)
end

function RoleBehave:setAIEnabled(isEnable)
	if self.AIEnable ~= isEnable then
		self.AIEnable = isEnable
		if isEnable == true then
			self:getMapInfo()
			self:runAI()
		else
			self:removeAI()
		end
	end
	
end

function RoleBehave:getTalk()
	local idx = math.floor(math.random(1,#self.talkGroup))
	local talklist = self.talkGroup[idx]
	return talklist
end

function RoleBehave:removeAI()
	self.timerhandleList = {}
    self.tarNode.shapeAnim:setPosition(me.p(0,0))
    self.tarNode:playAnim("idle",-1)
end

function RoleBehave:runAI()
	print("Run role AI")
	local emoj = self:getMoodEmoj()
	if emoj then
		self.tarNode:playAnim(emoj, -1)
		return false
	end

	self:addAITimer(math.random(5000,8000),function()
		self:runRandomBehave()
	end)
end

function RoleBehave:runRandomBehave()
	local behavelist = self:getBehaveList()
	local idx = math.random(1,#behavelist)
	local mbehave = behavelist[idx]
	print("Role Act:",mbehave)
	if mbehave == "freemove" then
		self:moveToPos()
	elseif mbehave == "freetalk" then
		self:showTalk()
	elseif mbehave == "idle" then
		self.tarNode:playAnim("idle", -1)
		self:addAITimer(math.random(2000,5000),function()
			self:onBehaveComplete()
		end)
	elseif mbehave == "interact" then
		self:randomInterAct()
	elseif mbehave == "randomEmoj" then
		self:randomEmoj()
	else

	end 
end

function RoleBehave:randomEmoj()
	local emojlist = self:getSpecialEmoj()
	local emojidx = math.random(1,#emojlist)
	local emoj = emojlist[emojidx]
	self.tarNode.shapeAnim:addMEListener(TFARMATURE_COMPLETE,function(sklete)
		self.tarNode.shapeAnim:removeMEListener(TFARMATURE_COMPLETE)
		self.tarNode:playAnim("idle", -1)
		self:onBehaveComplete()
	end)
	self.tarNode:playAnim(emoj,0)
	if emoj == "special2" then
		self.tarNode:playEmojExtAnim()
	end
end

function RoleBehave:randomInterAct()
	local interActPoint = self.controller:getRandomInterActPoints(self.tarNode.bid)
	if interActPoint == nil then
		self:addAITimer(2000,function()
			self:onBehaveComplete()
		end)
		return
	end
	self.lockedPointId = interActPoint.id
	local point = self.mapInfo:getVisualNode(interActPoint.id)
	local tarpos = me.p(point.Position.X,point.Position.Y)
	local mbehave = clone(interActPoint.behave)
	self.controller:lockInterActPoint(self.tarNode.bid,interActPoint.id)
	if mbehave.act == "sit" then
		self:moveToPos(tarpos,handler(self.sitDown,self),mbehave)
		return
	end
	if mbehave.act == "rest" then
		self:moveToPos(tarpos,handler(self.goToSleep,self),mbehave)
		return
	end
	
	


end

function RoleBehave:moveToPos(tarpos,callback,endDir)
	
	local curpos = self.tarNode:getPosition()
	if tarpos == nil then
    	tarpos = self.mapInfo:getRandomDP(curpos,100,50)
    end
    if tarpos == nil then
        print("没有目的地")
        if callback then
        	callback()
        else
        	self:addAITimer(2000,function()
        		self:onBehaveComplete()
        	end)
        end
        return nil
    end
	local path = self.controller:findPath(curpos, tarpos, self.tarNode.bid)
	if callback then
		self.tarNode:move(path,callback,endDir)
	else
		self.tarNode:move(path,handler(self.onMoveComplete,self))
	end
	
end

function RoleBehave:onMoveComplete()
	self.tarNode:playAnim("idle", -1)
	self:addAITimer(500,function()
		self:onBehaveComplete()
	end)
end

function RoleBehave:onBehaveComplete()
    print("Next role AI")
    self:removeAI()
	if self.AIEnable == true then
		self:runAI()
	end
end

function RoleBehave:showTalk()
	local talklist = self:getTalk()
	if self.tarNode.isTalking or not talklist then
		self:onBehaveComplete()
		do return end
	end
	local talknum = 1
	local function popTalk(talkId)
		local talknode = self.tarNode:playTalk(talkId)
		talknode:setOpacity(0)
	    local actionArr = {FadeIn:create(0.5),DelayTime:create(5),FadeOut:create(0.5),CallFunc:create(function()
	    	self:addAITimer(500,function()
	    		talknum = talknum + 1
	    		if talklist[talknum] then
	    			popTalk(talklist[talknum])
	    		else
					self.tarNode.isTalking = false
					self:onBehaveComplete()
				end
			end)
			talknode:removeFromParent()
	    end)}
		talknode:runAction(Sequence:create(actionArr))
	end
	popTalk(talklist[talknum])
end

function RoleBehave:sitDown(mbehave)
	self.tarNode.shapeAnim:addMEListener(TFARMATURE_COMPLETE,function(sklete)
		self.tarNode.shapeAnim:removeMEListener(TFARMATURE_COMPLETE)
		self.tarNode:playAnim("sit", -1)
		local holdtime = math.random(20000,30000)
		self:addAITimer(holdtime,function()
			self.controller:unlockInterActPoint(self.tarNode.bid,self.lockedPointId)
			self:addAITimer(1000,function( ... )
				self:onBehaveComplete()
			end)	
		end)
	end)
	self.tarNode:setDirect(mbehave.dir)
	if mbehave.dh then
		local actArr = {MoveTo:create(0.1,me.p(0,mbehave.dh)),CallFunc:create(function( ... )
			self.tarNode:playAnim("xianjie", 0)
		end)}
		self.tarNode.shapeAnim:runAction(Sequence:create(actArr))
	else
		self.tarNode:playAnim("xianjie", 0)
	end
end

function RoleBehave:goToSleep(mbehave)
	self.tarNode.shapeAnim:addMEListener(TFARMATURE_COMPLETE,function(sklete)
		self.tarNode.shapeAnim:removeMEListener(TFARMATURE_COMPLETE)
		self.tarNode:playAnim("rest", -1)
		local holdtime = math.random(20000,30000)
		self:addAITimer(holdtime,function()
			self.controller:unlockInterActPoint(self.tarNode.bid,self.lockedPointId)
			self:addAITimer(1000,function( ... )
				self:onBehaveComplete()
			end)
		end)
	end)
	self.tarNode:setDirect(mbehave.dir)
	if mbehave.dh then
		local actArr = {MoveTo:create(0.1,me.p(0,mbehave.dh)),CallFunc:create(function( ... )
			self.tarNode:playAnim("xianjie", 0)
		end)}
		self.tarNode.shapeAnim:runAction(Sequence:create(actArr))
	else
		self.tarNode:playAnim("xianjie", 0)
	end
	
end

function RoleBehave:onRoleClicked()
	if self:getMoodEmoj() == nil then
		self.tarNode:stopAllActions()
		self:onBehaveComplete()
	end
end

function RoleBehave:addAITimer(timelong,callback)
	local timerid = 10000
	while self.timerhandleList[timerid] do
		timerid = timerid + 1
	end
	local tmtimer = {needtime = timelong,callback = callback,curtime = 0}
	self.timerhandleList[timerid] = tmtimer
end

function RoleBehave:update(dt)
	for k,v in pairs(self.timerhandleList) do
		v.curtime = v.curtime + (dt*1000)
		if v.curtime >= v.needtime then
			if v.callback then
				local tmtimer = clone(v)
				self.timerhandleList[k] = nil
				tmtimer.callback()
			end
		end
	end
end
return RoleBehave