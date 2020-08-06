local NpcBehave = class("NpcBehave")

function NpcBehave:ctor(param)
	self.tarNode = param.tarNode
	self.objId = param.objId
	self.AIEnable = false
	self.controller = param.controller
	self:initData()
end

function NpcBehave:initData()
	self.timerhandleList = {}
	self.talkGroup = self.tarNode.aiword.normal
end

function NpcBehave:setAIEnabled(isEnable)
	
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

function NpcBehave:getSpecialEmoj()
	local specialEmojList = {"special1","special2"}
	return specialEmojList
end


function NpcBehave:getTalk()
	local idx = math.floor(math.random(1,#self.talkGroup))
	local talklist = self.talkGroup[idx]
	return talklist
end

function NpcBehave:removeAI()
	self.timerhandleList = {}
	self.tarNode:playAnim("idle",-1)
end

function NpcBehave:runAI()
	print("Run NPC AI")
	self:addAITimer(math.random(5000,8000),function()
		self:runRandomBehave()
	end)
end
function NpcBehave:getBehaveList()
	--临时行为列表
	local behaveList = {
		"freemove",
		"freetalk",
		"idle",
		"randomEmoj",
	}
	return behaveList
end
function NpcBehave:reportBornPos(pos)
	self.bornPos = pos
end
function NpcBehave:getMapInfo()
	self.mapInfo = self.controller:getMapInfo(self.tarNode.bid)
end

function NpcBehave:runRandomBehave()
	local behavelist = self:getBehaveList()
	local idx = math.random(1,#behavelist)
	local mbehave = behavelist[idx]
	print(mbehave)
	if mbehave == "freemove" then
		self:moveToPos()
	elseif mbehave == "freetalk" then
		self:showTalk()
	elseif mbehave == "idle" then
		self.tarNode:playAnim("idle", -1)
		self:addAITimer(math.random(5000,8000),function()
			self:onBehaveComplete()
		end)
	elseif mbehave == "randomEmoj" then
		self:randomEmoj()
	else

	end 
end

function NpcBehave:randomEmoj()
	local emojlist = self:getSpecialEmoj()
	local emojidx = math.random(1,#emojlist)
	local emoj = emojlist[emojidx]
	self.tarNode.shapeAnim:addMEListener(TFARMATURE_COMPLETE,function(sklete)
		self.tarNode.shapeAnim:removeMEListener(TFARMATURE_COMPLETE)
		self:onBehaveComplete()
	end)
	self.tarNode:playAnim(emoj,0)
end

function NpcBehave:moveToPos(tarpos,callback,endDir)
	
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

function NpcBehave:onMoveComplete()
	self.tarNode:playAnim("idle", -1)
	self:addAITimer(500,function()
		self:onBehaveComplete()
	end)
end

function NpcBehave:onBehaveComplete()
	print("Next NPC AI")
	self:removeAI()
	if self.AIEnable == true then
		self:runAI()
	end
end

function NpcBehave:showTalk()
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

function NpcBehave:addAITimer(timelong,callback)
	local timerid = 10000
	while self.timerhandleList[timerid] do
		timerid = timerid + 1
	end
	local tmtimer = {needtime = timelong,callback = callback,curtime = 0}
	self.timerhandleList[timerid] = tmtimer
end

function NpcBehave:onRoleClicked()
	
end

function NpcBehave:update(dt)
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
return NpcBehave