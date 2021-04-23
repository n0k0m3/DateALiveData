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
* 
]]
local MapUtils = import("lua.logic.osd.MapUtils")
local SingleAIBehave = class("SingleAIBehave")

function SingleAIBehave:ctor(param)
	self.tarNode = param.tarNode
	self.AIEnable = false
	self.life = param.life or -1
	self.life = self.life == 0 and -1 or self.life
	self.aiCfg = TabDataMgr:getData("WorldObjectAIscript", param.cfgId)
	self:initData()
end

function SingleAIBehave:initData()
	self.timerhandleList = {}
	self.talkGroup = {}
end

function SingleAIBehave:setAIEnabled(isEnable)
	
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

function SingleAIBehave:getTalk()
	local idx = math.floor(math.random(1,#self.talkGroup))
	local talklist = self.talkGroup[idx]
	return talklist
end

function SingleAIBehave:removeAI()
	self.timerhandleList = {}
	if not self.aiCfg.notInterfereAni then
		if self.tarNode then
			self.tarNode:playStand()
		end
	end
end

function SingleAIBehave:runAI()
	
	if self.tarNode then
		self.tarNode:aiAction()
	end

	if self.willDelete then
		self:removeAI()
		self:deleteAI()
		return
	end
	self:runRandomBehave()
end

function SingleAIBehave:reportBornPos(pos)
	self.bornPos = pos
end

function SingleAIBehave:getMapInfo()
	self.mapInfo = MapUtils:getMapParse()
end

function SingleAIBehave:runRandomBehave()
	local behavelist = self.aiCfg.behaviorWeight
	local weight = math.random(1,10000)

	local mbehave = ""
	local weightTab = {}
	local curWeight = 0

	for k,v in pairs(behavelist) do
		curWeight = curWeight + v
		weightTab[k] = curWeight
	end

	local tmpWeight = 10001
	for k,v in pairs(weightTab) do
		if weight <= v and tmpWeight > v then
			tmpWeight = v
			mbehave = k
		end
	end

	if mbehave == "freemove" then
		self:moveToPos()
	elseif mbehave == "freetalk" then
		self:showTalk()
	elseif mbehave == "idle" then
		self.tarNode:playStand()
		self:addAITimer(math.random(1000,3000),function()
			self:onBehaveComplete()
		end)
	elseif mbehave == "checkActionList" then
		self:checkActionList()
	elseif mbehave == "randomEmoj" then
		self:randomEmoj()
	else
		self:addAITimer(math.random(1000,3000),function()
			self:onBehaveComplete()
		end)
	end 
end

function SingleAIBehave:checkActionList( ... )
	-- body
	local actionMap = self.aiCfg.checkAction or {}
	local success = false
	for k,v in ipairs(actionMap) do
		local actorPid = self.tarNode:getPid()
		if WorldRoomDataMgr:getCurControl():checkCondition(v.cond, actorPid) then
			local actionId = 0
			if v.actionList then
				self.curActionIndex = self.curActionIndex or 1
				self.curActionIndex = self.curActionIndex%(#v.actionList + 1)
				if self.curActionIndex == 0 then
					self.curActionIndex = 1
				end
				actionId = v.actionList[self.curActionIndex]
				self.curActionIndex = self.curActionIndex + 1
			elseif v.actionRandom then
				actionId = v.actionRandom[math.random(1,#v.actionRandom)]
			end
			success = true
			self:addAITimer(math.random(v.pretime[1],v.pretime[2]), function ( ... )
				-- body
				self.tarNode:actionByCfgId(actionId,nil,function ( ... )
						self:addAITimer(math.random(v.delaytime[1],v.delaytime[2]),function () 
								self:onBehaveComplete()
							end)
					end)
			end)
			break;
		end
	end

	if not success then
		self:addAITimer(math.random(10,10),function () 
			self:onBehaveComplete()
		end)
	end
end

function SingleAIBehave:randomEmoj()
	if not self.tarNode.skeletonNode then return end
	local emojlist = self.aiCfg.emojList
	local emojidx = math.random(1,#emojlist)
	local emoj = emojlist[emojidx]
	self.tarNode.skeletonNode:addMEListener(TFARMATURE_COMPLETE,function(sklete)
		self.tarNode.skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
		self:onBehaveComplete()
	end)
	self.tarNode:playAni(emoj,false)
end

function SingleAIBehave:moveToPos(tarpos,callback,endDir)
	
	local curpos = self.tarNode:getPosition()
	if tarpos == nil then
    	tarpos = curpos + ccp(math.random(-200,200),math.random(-200,200))
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
	if callback then
		if not self.tarNode:moveTo(tarpos,callback) then
			callback()
		end
	else
		if not self.tarNode:moveTo(tarpos,handler(self.onMoveComplete,self)) then
			self:onMoveComplete()
		end
	end
	
end

function SingleAIBehave:onMoveComplete()
	self:addAITimer(500,function()
		self:onBehaveComplete()
	end)
end

function SingleAIBehave:onBehaveComplete()
	self:removeAI()
	if self.AIEnable == true then
		self:runAI()
	end
end

function SingleAIBehave:showTalk()
	local talklist = self:getTalk()
	if self.tarNode.isTalking or not talklist then
		self:onBehaveComplete()
		do return end
	end
	local talknum = 1
	local function popTalk(talkId)
		local talknode = self.tarNode:aiTalk(talkId)
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
			talknode:hide()
	    end)}
		talknode:runAction(Sequence:create(actionArr))
	end
	popTalk(talklist[talknum])
end

function SingleAIBehave:addAITimer(timelong,callback)
	local timerid = 10000
	while self.timerhandleList[timerid] do
		timerid = timerid + 1
	end
	local tmtimer = {needtime = timelong,callback = callback,curtime = 0}
	self.timerhandleList[timerid] = tmtimer
end

function SingleAIBehave:onRoleClicked()
	
end

function SingleAIBehave:deleteAI( ... )
	-- body
	if self.tarNode and self.tarNode.aiDeleteCallBack then
		self.tarNode:aiDeleteCallBack()
		return
	end
end

function SingleAIBehave:update(dt)
	self.enableLife = self.enableLife or 0
	self.enableLife = self.enableLife + (dt)

	if self.life ~= -1 and self.life <= self.enableLife then
		self.willDelete = true -- ai生命周期结束预留足够时间等待其他动作完成
		self.enableLife = self.enableLife + 10
		self:addAITimer(10000,function() 
			self:runAI()
		end)
	end

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
return SingleAIBehave