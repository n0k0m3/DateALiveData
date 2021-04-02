local EventTrigger = EventTrigger or {}
local enum        = import(".enum")
local eMonsterType = enum.eMonsterType
local eCampType    = enum.eCampType
local eEvent = enum.eEvent
local eRoleType    = enum.eRoleType
local BattleTimerManager = import(".BattleTimerManager")
local StoryScriptParse = import(".StoryScriptParse")
local TriggerType = {
	DieCounterTrigger = "DieCounterTrigger",
	HPTrigger = "HPTrigger",
	RegionTrigger = "RegionTrigger",
	DamageTrigger = "DamageTrigger",
	AliveCounterTrigger = "AliveCounterTrigger",
	TimerTrigger = "TimerTrigger",
	MultConditionTrigger = "MultConditionTrigger",
	TeamAliveTimerTrigger = "TeamAliveTimerTrigger",
}

function EventTrigger:isCrossArea(areainfo,sp,ep)
	local areapos = areainfo.pos
	local areasize = areainfo.size
	local function checkPointIn(cp)
		if cp.x < areapos.x - areasize.width then
			return false
		end
		if cp.x > areapos.x + areasize.width then
			return false
		end
		if cp.y < areapos.y - areasize.height then
			return false
		end
		if cp.y > areapos.y + areasize.height then
			return false
		end
		return true
	end
	if checkPointIn(sp) == true then
		return true
	end
	if checkPointIn(ep) == true then
		return true
	end
	local function checkCross(apv,bpv,cpv)
		local x1 = apv.x - cpv.x
		local x2 = bpv.x - cpv.x
		local y1 = bpv.y - cpv.y
		local y2 = apv.y - cpv.y
		return (x1*y1) - (x2*y2)
	end

	local function checkColide(tspv,tepv,spv,epv)
		if math.max(tspv.x,tepv.x) < math.min(spv.x,epv.x) then
			return false
		end
		if math.max(tspv.y,tepv.y) < math.min(spv.y,epv.y) then
			return false
		end
		if math.max(spv.x,epv.x) < math.min(tspv.x,tepv.x) then
			return false
		end
		if math.max(spv.y,epv.y) < math.min(tspv.y,tepv.y) then
			return false
		end
		if checkCross(spv,tepv,tspv) * checkCross(tepv,epv,tspv) < 0.0001 then
			return false
		end
		if checkCross(tspv,epv,spv) * checkCross(epv,tepv,spv) < 0.0001 then
			return false
		end
		return true
	end
	local vertexArr = { me.p(areapos.x - areasize.width,areapos.y - areasize.height),
						me.p(areapos.x + areasize.width,areapos.y - areasize.height),
						me.p(areapos.x + areasize.width,areapos.y + areasize.height),
						me.p(areapos.x - areasize.width,areapos.y + areasize.height)
				}
	local sideCode = nil
	for i=1,#vertexArr do
		local tspv = vertexArr[i]
		local tepidx = i + 1 
		if i == #vertexArr then
			tepidx = 1
		end
		local tepv = vertexArr[tepidx]
		if checkColide(tspv,tepv,sp,ep) == true then
			return true
		end
	end
	return false
end
function EventTrigger:resetTriggers(params, controller)
	self:clearTriggers()
	self.mapInfo = params
	self.controller = controller
	self.mapInfo:registEvents()
    self:initTrigger()
end

function EventTrigger:clearTriggers()
	if self.triggerOrderList then
		for i,v in ipairs(self.triggerOrderList) do
			if v.timer then
				BattleTimerManager:removeTimer(v.timer)
				v.timer = nil
			end
		end
	end
	self.triggerList = {}
	self.triggerOrderList = {}
	self.groupList = {}
	self:clearSoundEffect()
	if self.mapInfo then
		self.mapInfo:unregistEvents()
	end
	self.isCanPlayPreVScript = false
	self.ScriptAnimRunning = false
	EventMgr:removeEventListener(self,EV_AI_MODIFY_LEVELEDITOR_EVENT,handler(self.onActiveObject, self))
	EventMgr:addEventListener(self,EV_AI_MODIFY_LEVELEDITOR_EVENT,handler(self.onActiveObject, self))
end

function EventTrigger:clearSoundEffect()
	if self.soundPlayList then
		for k,v in pairs(self.soundPlayList) do
			TFAudio.stopEffect(k)
		end
	end
	self.soundPlayList = {} -- handleId = lestloop
end

function EventTrigger:start()
    for k,v in ipairs(self.triggerOrderList) do
		if v.cfg.Active == true then
			v:checkFunc()
		end
	end
end

function EventTrigger:prevAct(callback)
	if self.mapInfo.data.BeginSummonEvent and type(self.mapInfo.data.BeginSummonEvent) == "table" then
		local levelCfg = BattleDataMgr:getLevelCfg()
		if levelCfg.fightingMode == 2 or levelCfg.fightingMode == 3 then
			if #self.mapInfo.data.BeginSummonEvent > 0 then
				local errorStr = string.format("飞行或撞击关卡%d配了提前刷怪",levelCfg.id)
				Bugly:ReportLuaException(errorStr)
				if DEBUG == 1 then
					Box(errorStr)
				end
			end
		end
		if levelCfg.fightingMode == 1 then
			for i,v in ipairs(self.mapInfo.data.BeginSummonEvent) do
				self:refreshMonster(v.Class,v)
			end
		end
	end
	if self.isCanPlayPreVScript == false then
		self.isCanPlayPreVScript = true
		if self.mapInfo.data.root.ScriptAnimID and self.mapInfo.data.root.ScriptAnimID ~= 0 then
			self.battleCallback = callback
			self:onPlayScriptAnim({ScriptAnimID = self.mapInfo.data.root.ScriptAnimID})
		else
			callback()
		end
	end
end

--场上人员（敌方）死亡
function EventTrigger:_onSlain(hero)
	for k,v in ipairs(self.triggerOrderList) do
		if v.cfg.type == "DieCounterTrigger" and v.cfg.Active == true then
			if v.cfg["CheckType"] == 0 then --指定怪物类型
				if v.cfg["CheckTypeParam"] == 0 then --普通怪
					if hero:getMonsterType() == eMonsterType.MT_NORMAL then
						v.count = v.count + 1
						v.checkFunc()
					end
				elseif v.cfg["CheckTypeParam"] == 1 then --精英怪
					if hero:getMonsterType() == eMonsterType.MT_ELITE then
						v.count = v.count + 1
						v.checkFunc()
					end
				elseif v.cfg["CheckTypeParam"] == 2 then --Boss
					if hero:getMonsterType() == eMonsterType.MT_BOSS then
						v.count = v.count + 1
						v.checkFunc()
					end
				else

				end
			elseif v.cfg["CheckType"] == 1 then --指定怪物ID
				if hero:getData().id == v.cfg["CheckTypeParam"] then
					v.count = v.count + 1
					v.checkFunc()
				end
			elseif v.cfg["CheckType"] == 2 then --不限制
				v.count = v.count + 1
				v.checkFunc()
			else

			end
		end
        if v.cfg.type == "AliveCounterTrigger" and v.cfg.Active == true then
            v.checkFunc()
        end
	end
end

function EventTrigger:_onNewHeroJoin()
    for k,v in ipairs(self.triggerOrderList) do
        if v.cfg.type == "AliveCounterTrigger" and v.cfg.Active == true then
            v.checkFunc()
        end
    end
end
--场上人员血量改变
function EventTrigger:_onChangeHp(hero)
	for k,v in ipairs(self.triggerOrderList) do
		if v.cfg.type == "HPTrigger" and v.cfg.Active == true then
			if v.cfg.TargetID == 0 or v.cfg.TargetID == -1 then
				if hero == self.controller.getCaptain() then
					v:checkFunc()
				end
			else
				if hero:getData().id == v.cfg.TargetID then
					v:checkFunc()
				end
			end
		end
	end
end

--场上人员位置变化
function EventTrigger:_onChangePos(hero)
	for k,v in ipairs(self.triggerOrderList) do
		if v.cfg.type == "RegionTrigger" and v.cfg.Active == true then
			if v.cfg.TargetID == 0 or v.cfg.TargetID == -1 then
				if hero == self.controller.getCaptain() then
					v:checkFunc(hero)
				end
			elseif v.cfg.TargetID == -2 then --任意一个我方角色到达位置后触发
				local roleType = hero:getRoleType()
				if roleType == eRoleType.Hero or roleType == eRoleType.Team then 
					v:checkFunc(hero)
				end
			else
				if v.cfg.AllEnemy and v.cfg.AllEnemy == true then
					v:checkFunc(hero)
				else
					if hero:getData().id == v.cfg.TargetID then
						v:checkFunc(hero)
					end
				end
			end
		end
	end
end

function EventTrigger:_onMakeDamage()
	for k,v in ipairs(self.triggerOrderList) do
		if v.cfg.type == "DamageTrigger" and v.cfg.Active == true then
			v:checkFunc()
		end
	end
end

function EventTrigger:initTrigger()
	for k,v in pairs(self.mapInfo.triggers) do
		if v.type == TriggerType.DieCounterTrigger then
			self:makeDieTrigger(v)
		elseif v.type == TriggerType.TimerTrigger then
			self:makeTimeTrigger(v)
		elseif v.type == TriggerType.HPTrigger then
			self:makeHPTrigger(v)
		elseif v.type == TriggerType.RegionTrigger then
			self:makeAreaTrigger(v)
		elseif v.type == TriggerType.AliveCounterTrigger then
			self:makeAliveTrigger(v)
		elseif v.type == TriggerType.MultConditionTrigger then
			self:makeMultTrigger(v)
		elseif v.type == TriggerType.TeamAliveTimerTrigger then
			-- self:makeTeamAliveTimerTrigger(v)
		elseif v.type == TriggerType.DamageTrigger then
			self:makeDamageTrigger(v)
		else
			if v.type == "GroupTrigger" then
				self.groupList[v.ID] = v.List
			end
		end
	end
	if #self.triggerOrderList >=2 then
		table.sort( self.triggerOrderList, function(a,b)
			return a.cfg.ID < b.cfg.ID
		end )
	end
end

function EventTrigger:makeTimeTrigger(cfg)
	local tmTrigger = {cfg = cfg}
	tmTrigger.checkFunc = function()
		if tmTrigger.cfg.Active == false then
            if tmTrigger.timer then
				BattleTimerManager:removeTimer(tmTrigger.timer)
				tmTrigger.timer = nil
			end
			return
		end
		if tmTrigger.timer == nil then
			tmTrigger.timer = BattleTimerManager:addTimer(tmTrigger.cfg.Duration,tmTrigger.cfg.Count,function()
				tmTrigger.cfg.Active = false
				if tmTrigger.timer then
					BattleTimerManager:removeTimer(tmTrigger.timer)
					tmTrigger.timer = nil
				end

			end,function()
					tmTrigger.cfg.Active = false
					if tmTrigger.eventFunc then
						for k,v in ipairs(tmTrigger.eventFunc) do
							v()
						end
					end
			end)
		end
	end
	self:bindCommonEventFunc(tmTrigger)
	self.triggerList[cfg.ID] = tmTrigger
	self.triggerOrderList[#self.triggerOrderList + 1] = tmTrigger
end

function EventTrigger:makeTeamAliveTimerTrigger(cfg)
	local tmTrigger = {cfg = cfg}
	tmTrigger.checkFunc = function()
		if tmTrigger.cfg.Active == false then
 			if tmTrigger.timer then
				BattleTimerManager:removeTimer(tmTrigger.timer)
				tmTrigger.timer = nil
			end
			return
		end
		if tmTrigger.timer == nil then
			tmTrigger.timer = BattleTimerManager:addTimer(tmTrigger.cfg.Duration,1,function()
				tmTrigger.cfg.Active = false
				if tmTrigger.timer then
					BattleTimerManager:removeTimer(tmTrigger.timer)
					tmTrigger.timer = nil
				end
				local isAllDied = self.controller.getTeam():isAllDestoryByCampTyp(eCampType.Hero)
				if isAllDied == true then
					self.controller.endBattle(false)
				else
					self.controller.endBattle(true)
				end

			end,nil)
		end
	end
	self.triggerList[cfg.ID] = tmTrigger
	self.triggerOrderList[#self.triggerOrderList + 1] = tmTrigger
end
function EventTrigger:makeHPTrigger(cfg)
	local tmTrigger = {cfg = cfg}
	tmTrigger.checkFunc = function()
		if tmTrigger.cfg.Active == false then
			if tmTrigger.timer then
				BattleTimerManager:removeTimer(tmTrigger.timer)
				tmTrigger.timer = nil
			end
			return
		end
		local herolist = {}
		if tmTrigger.cfg.TargetID == 0 or tmTrigger.cfg.TargetID == -1 then
			local hero = self.controller.getCaptain()
			herolist[#herolist + 1] = hero
		else
			local enemylist = self.controller.getEnemyMember()
			for k,v in pairs(enemylist) do
				if v:getData().id == tmTrigger.cfg.TargetID then
					herolist[#herolist + 1] = v
				end
			end
		end
		if #herolist <= 0 then
			return
		end
		for k,v in pairs(herolist) do
			local hpcent = v:getHpPercent()
			local isMatch = false
			if tmTrigger.cfg.CompareType == "<=" then
				if hpcent <= tmTrigger.cfg.HP then
					isMatch = true
				end
			elseif tmTrigger.cfg.CompareType == "<" then
				if hpcent < tmTrigger.cfg.HP then
					isMatch = true
				end
			elseif tmTrigger.cfg.CompareType == "==" then
				if hpcent == tmTrigger.cfg.HP then
					isMatch = true
				end
			elseif tmTrigger.cfg.CompareType == ">" then
				if hpcent > tmTrigger.cfg.HP then
					isMatch = true
				end
			elseif tmTrigger.cfg.CompareType == ">=" then
				if hpcent >= tmTrigger.cfg.HP then
					isMatch = true
				end
			else

			end
			if isMatch == true then
				tmTrigger.cfg.Active = false
				if tmTrigger.eventFunc and tmTrigger.timer == nil then
					if tmTrigger.cfg.Duration and tmTrigger.cfg.Duration > 0 then
						tmTrigger.timer = BattleTimerManager:addTimer(tmTrigger.cfg.Duration,1,function()
							if tmTrigger.timer then
								BattleTimerManager:removeTimer(tmTrigger.timer)
								tmTrigger.timer = nil
							end
							for s,t in ipairs(tmTrigger.eventFunc) do
								t()
							end
						end,nil)
                    else
                        for s,t in ipairs(tmTrigger.eventFunc) do
							t()
						end
					end
				end
				break
			end
		end

	end
	self:bindCommonEventFunc(tmTrigger)
	self.triggerList[cfg.ID] = tmTrigger
	self.triggerOrderList[#self.triggerOrderList + 1] = tmTrigger
end


function EventTrigger:makeDieTrigger(cfg)
	local tmTrigger = {cfg = cfg,count = 0}
	tmTrigger.checkFunc = function()
        if  tmTrigger.cfg.Active == false then
        	if tmTrigger.timer then
				BattleTimerManager:removeTimer(tmTrigger.timer)
				tmTrigger.timer = nil
			end
            return
        end
		if tmTrigger.count >= tmTrigger.cfg.Count then
			tmTrigger.cfg.Active = false
			if tmTrigger.eventFunc and tmTrigger.timer == nil then
				if tmTrigger.cfg.Duration and tmTrigger.cfg.Duration > 0 then
					tmTrigger.timer = BattleTimerManager:addTimer(tmTrigger.cfg.Duration,1,function()
						if tmTrigger.timer then
							BattleTimerManager:removeTimer(tmTrigger.timer)
							tmTrigger.timer = nil
						end
						for k,v in ipairs(tmTrigger.eventFunc) do
							v()
						end
					end,nil)
					
                else
                    for k,v in ipairs(tmTrigger.eventFunc) do
						v()
					end
				end
			end
		end
	end
	self:bindCommonEventFunc(tmTrigger)
	self.triggerList[cfg.ID] = tmTrigger
	self.triggerOrderList[#self.triggerOrderList + 1] = tmTrigger
end

function EventTrigger:makeDamageTrigger(cfg)
	local tmTrigger = {cfg = cfg}
	tmTrigger.checkFunc = function()
		if tmTrigger.cfg.Active == false then
			if tmTrigger.timer then
				BattleTimerManager:removeTimer(tmTrigger.timer)
				tmTrigger.timer = nil
			end
			return
		end
		if tmTrigger.cfg.Value <= 0 then
			return
		end
		local hitValue = self.controller.getHitValue()
		local isMatch = false
		if tmTrigger.cfg.CompareType == "==" then
			if hitValue == tmTrigger.cfg.Value then
				isMatch = true
			end
		elseif tmTrigger.cfg.CompareType == ">" then
			if hitValue > tmTrigger.cfg.Value then
				isMatch = true
			end
		elseif tmTrigger.cfg.CompareType == ">=" then
			if hitValue >= tmTrigger.cfg.Value then
				isMatch = true
			end
		end
		if isMatch == true then
			tmTrigger.cfg.Active = false
			if tmTrigger.eventFunc and tmTrigger.timer == nil then
				if tmTrigger.cfg.Duration and tmTrigger.cfg.Duration > 0 then
					tmTrigger.timer = BattleTimerManager:addTimer(tmTrigger.cfg.Duration,1,function()
						if tmTrigger.timer then
							BattleTimerManager:removeTimer(tmTrigger.timer)
							tmTrigger.timer = nil
						end
						for s,t in ipairs(tmTrigger.eventFunc) do
							t()
						end
					end,nil)
                else
                    for s,t in ipairs(tmTrigger.eventFunc) do
						t()
					end
				end
			end
		end

	end
	self:bindCommonEventFunc(tmTrigger)
	self.triggerList[cfg.ID] = tmTrigger
	self.triggerOrderList[#self.triggerOrderList + 1] = tmTrigger
end

function EventTrigger:makeMultTrigger(cfg)
	local tmTrigger = {cfg = cfg}
	tmTrigger.checkFunc = function()
		local isMultActive = true
		for i=1,5 do
			if tmTrigger.cfg["Param"..i] == false then
				isMultActive = false
				break
			end
		end
		if isMultActive == true then
			tmTrigger.cfg.Active = false
			for k,v in ipairs(tmTrigger.eventFunc) do
				v()
			end
		end
	end
	self:bindCommonEventFunc(tmTrigger)
	self.triggerList[cfg.ID] = tmTrigger
	self.triggerOrderList[#self.triggerOrderList + 1] = tmTrigger
end

function EventTrigger:makeAliveTrigger(cfg)

	local tmTrigger = {cfg = cfg}
	tmTrigger.checkFunc = function()
		if tmTrigger.cfg.Active == false then
            if tmTrigger.timer then
				BattleTimerManager:removeTimer(tmTrigger.timer)
				tmTrigger.timer = nil
			end
			return
		end
        local enemylist = self.controller.getEnemyMember__()
		tmTrigger.count = 0
		for k,v in pairs(enemylist) do
			if tmTrigger.cfg["CheckType"] == 0 then --指定怪物类型
				if tmTrigger.cfg["CheckTypeParam"] == 0 then --普通怪
					if v:getMonsterType() == eMonsterType.MT_NORMAL then
						tmTrigger.count = tmTrigger.count + 1
					end
				elseif tmTrigger.cfg["CheckTypeParam"] == 1 then --精英怪
					if v:getMonsterType() == eMonsterType.MT_ELITE then
						tmTrigger.count = tmTrigger.count + 1
					end
				elseif tmTrigger.cfg["CheckTypeParam"] == 2 then --Boss
					if v:getMonsterType() == eMonsterType.MT_BOSS then
						tmTrigger.count = tmTrigger.count + 1
					end
				else

				end
			elseif tmTrigger.cfg["CheckType"] == 1 then --指定怪物ID
				if v:getData().id == tmTrigger.cfg["CheckTypeParam"] then
					tmTrigger.count = tmTrigger.count + 1
				end
			elseif tmTrigger.cfg["CheckType"] == 2 then --不限制
				tmTrigger.count = tmTrigger.count + 1
			else

			end
		end
		local limitCount = tmTrigger.cfg.Count
		if tmTrigger.cfg.CampNumMax and table.count(tmTrigger.cfg.CampNumMax) > 0 then
			tmTrigger.count = 0
			limitCount = 0
			for camp,num in pairs(tmTrigger.cfg.CampNumMax) do
				local heros = self.controller.getTeam():getMenbers_(tonumber(camp),1)
				tmTrigger.count = tmTrigger.count + #heros
				limitCount = limitCount + num
			end
		end
		local isMatch = false
		if tmTrigger.cfg.CompareType == "<=" then
			if tmTrigger.count <= limitCount then
				isMatch = true
			end
		elseif tmTrigger.cfg.CompareType == "<" then
			if tmTrigger.count < limitCount then
				isMatch = true
			end
		elseif tmTrigger.cfg.CompareType == "==" then
			if tmTrigger.count == limitCount then
				isMatch = true
			end
		elseif tmTrigger.cfg.CompareType == ">" then
			if tmTrigger.count > limitCount then
				isMatch = true
			end
		elseif tmTrigger.cfg.CompareType == ">=" then
			if tmTrigger.count >= limitCount then
				isMatch = true
			end
		else

		end
		if isMatch == true then
			if tmTrigger.eventFunc and tmTrigger.timer == nil then
				if tmTrigger.cfg.Duration and tmTrigger.cfg.Duration > 0 then
					tmTrigger.timer = BattleTimerManager:addTimer(tmTrigger.cfg.Duration,1,function()
						if tmTrigger.timer then
							BattleTimerManager:removeTimer(tmTrigger.timer)
							tmTrigger.timer = nil
						end
						tmTrigger.cfg.Active = false
						for k,v in ipairs(tmTrigger.eventFunc) do
							v()
						end
					end,nil)
                else
                	tmTrigger.cfg.Active = false
                    for k,v in ipairs(tmTrigger.eventFunc) do
						v()
					end
				end
			end
		else
			if tmTrigger.cfg.Loop then
				if tmTrigger.cfg.Duration and tmTrigger.cfg.Duration > 0 then
					tmTrigger.timer = BattleTimerManager:addTimer(tmTrigger.cfg.Duration,1,function()
						if tmTrigger.timer then
							BattleTimerManager:removeTimer(tmTrigger.timer)
							tmTrigger.timer = nil
						end
						tmTrigger.cfg.Active = false
						for k,v in pairs(tmTrigger.cfg.Events) do
							if string.match(v.Class,"Activate") then
								self:On_OffObj(v.Class,v.TargetID)
							end
						end
					end,nil)
                else
                	tmTrigger.cfg.Active = false
                    for k,v in pairs(tmTrigger.cfg.Events) do
						if string.match(v.Class,"Activate") then
							self:On_OffObj(v.Class,v.TargetID)
						end
					end
				end
			end
		end
	end
	self:bindCommonEventFunc(tmTrigger)
	self.triggerList[cfg.ID] = tmTrigger
	self.triggerOrderList[#self.triggerOrderList + 1] = tmTrigger
end

function EventTrigger:makeAreaTrigger(cfg)
	local tmTrigger = {cfg = cfg}
	tmTrigger.checkFunc = function(obj,hero)
		if tmTrigger.cfg.Active == false then
			if tmTrigger.timer then
				BattleTimerManager:removeTimer(tmTrigger.timer)
				tmTrigger.timer = nil
			end
			return 
		end
		local herolist = {}
		if hero then
			herolist[#herolist + 1] = hero
		else
			if tmTrigger.cfg.TargetID == 0 or tmTrigger.cfg.TargetID == -1 then
				herolist[#herolist + 1] = self.controller.getCaptain()
			else
				local enemylist = self.controller.getEnemyMember()
				for k,v in pairs(enemylist) do
					if v:getData().id == tmTrigger.cfg.TargetID then
						herolist[#herolist + 1] = v
					end
				end
			end
		end
		
		if #herolist > 0 then
			for k,v in pairs(herolist) do
                if v.actor then
					local curpos = v:getPosition()
					local lastPos = v:getLastPosition()
					local areaInfo = {pos = me.p(tmTrigger.cfg.Position.X,tmTrigger.cfg.Position.Y),size = me.size(tmTrigger.cfg.Size.W/2*tmTrigger.cfg.Scale.X,tmTrigger.cfg.Size.H/2 *tmTrigger.cfg.Scale.Y)}
					if self:isCrossArea(areaInfo,lastPos,curpos) == true then
						tmTrigger.cfg.Active = false
						if tmTrigger.cfg["IsGo"] == true then
							self.controller.showGo(false)
						end
						if tmTrigger.eventFunc and tmTrigger.timer == nil then
							if tmTrigger.cfg.Duration and tmTrigger.cfg.Duration > 0 then
								tmTrigger.timer = BattleTimerManager:addTimer(tmTrigger.cfg.Duration,1,function()
									if tmTrigger.timer then
										BattleTimerManager:removeTimer(tmTrigger.timer)
										tmTrigger.timer = nil
									end
									for s,t in ipairs(tmTrigger.eventFunc) do
										t(v)
									end
								end,nil)
                            else
                                for s,t in ipairs(tmTrigger.eventFunc) do
									t(v)
								end
							end
						end
					end
					break
                end
			end
		end
	end
	self:bindCommonEventFunc(tmTrigger)
	self.triggerList[cfg.ID] = tmTrigger
	self.triggerOrderList[#self.triggerOrderList + 1] = tmTrigger
	if tmTrigger.cfg["IsGo"] == true then
		self.controller.showGo(tmTrigger.cfg.Active)
	end
end

function EventTrigger:bindCommonEventFunc(trigger)
	trigger.eventFunc = {}
	for k,v in ipairs(trigger.cfg.Events) do
		if string.match(v.Class,"Activate") then
			trigger.eventFunc[#trigger.eventFunc + 1] = function(obj,object)
				self:On_OffObj(v.Class,v.TargetID)
			end
		elseif string.match(v.Class,"Summon") then
			trigger.eventFunc[#trigger.eventFunc + 1] = function(obj,object)
				self:refreshMonster(v.Class,v,trigger)
			end
		elseif v.Class == "TriggerEventWin" or v.Class == "TriggerEventFail" then
			trigger.eventFunc[#trigger.eventFunc + 1] = function(obj,object)
				self:onBattleEnd(v.Class)
			end
		elseif v.Class == "TriggerEventModifyMultiConditionTrigger" then
			trigger.eventFunc[#trigger.eventFunc + 1] = function(obj,object)
				self:setMultTrigger(v)
			end
		elseif v.Class == "TriggerEventAreaTaskDone" then
			trigger.eventFunc[#trigger.eventFunc + 1] = function(obj,object)
				self:onAreaComplete(v.Class)
			end
		elseif v.Class == "TriggerEventPlaySoundEffect" then
			trigger.eventFunc[#trigger.eventFunc + 1] = function(obj,object)
				self:onPlaySound(v.Class,v)
			end
		elseif v.Class == "TriggerEventChangeBGMusic" then
			trigger.eventFunc[#trigger.eventFunc + 1] = function(obj,object)
				self:onPlayBGM(v.Class,v)
			end
		elseif v.Class == "TriggerEventPlayCG" then
			trigger.eventFunc[#trigger.eventFunc + 1] = function(obj,object)
				self:onPlayCG(v)
			end
		elseif v.Class == "TriggerEventPlayScriptAnim" then
			trigger.eventFunc[#trigger.eventFunc + 1] = function(obj,object)
				self:onPlayScriptAnim(v)
			end
		elseif v.Class == "TriggerEventHitPoint" then
			trigger.eventFunc[#trigger.eventFunc + 1] = function(obj,object)
				self:onStageDot(v)
			end
		elseif v.Class == "TriggerEventSupportFight" then
			trigger.eventFunc[#trigger.eventFunc + 1] = function(obj,object)
				self:onAssistant(v)
			end
		elseif v.Class == "TriggerEventObjectMove" then
			trigger.eventFunc[#trigger.eventFunc + 1] = function(obj,object)
				self:onObjectMove(v)
			end
		elseif v.Class == "TriggerEventMonsterWarning" then
			trigger.eventFunc[#trigger.eventFunc + 1] = function(obj,object)
				self:onMonsterWarning(v)
			end
		elseif v.Class == "TriggerEventPenalty" then
			trigger.eventFunc[#trigger.eventFunc + 1] = function(obj,object)
				self:onPenalty(v,object)
			end
		elseif v.Class == "TriggerEventShowTips" then
			trigger.eventFunc[#trigger.eventFunc + 1] = function(obj,object)
				self:onShowTip(v)
			end
		else

		end
	end
end

-----------------------EventCallFunc---------------------
--激活或终止对象
function EventTrigger:On_OffObj(event,objId)
	-- local tmactTimer = BattleTimerManager:addTimer(33,1,function()
	-- 	BattleTimerManager:removeTimer(tmactTimer)
		local isActive = false
		if event == "TriggerEventActivate" then
			isActive = true
		elseif event == "TriggerEventUnActivate" then
			isActive = false
		else

		end

		if self.triggerList[objId] then
			self.triggerList[objId].cfg.Active = isActive
			if self.triggerList[objId].cfg["type"] == "DieCounterTrigger" then
				self.triggerList[objId].count = 0 
			elseif self.triggerList[objId].cfg["type"] == "RegionTrigger" then
				if self.triggerList[objId].cfg["IsGo"] == true then
					self.controller.showGo(isActive)
				end
				self.triggerList[objId].checkFunc()
			elseif self.triggerList[objId].cfg["type"] == "TimerTrigger" then
				self.triggerList[objId].checkFunc()
	        elseif self.triggerList[objId].cfg["type"] == "AliveCounterTrigger" then
				self.triggerList[objId].checkFunc() 
			else
				
			end
		end
		if self.mapInfo.visualNodes[objId] then
			self.mapInfo.visualNodes[objId].Active = isActive
			self.mapInfo.visualNodes[objId]:doRefresh()
		end
	-- end,nil)

end

function EventTrigger:onActiveObject(objId,isActive)
	if isActive == true then
		self:On_OffObj("TriggerEventActivate",objId)
	else
		self:On_OffObj("TriggerEventUnActivate",objId)
	end
end

--怪物刷新(普通刷新/补充刷怪)--刷可破坏障碍物NPC
function EventTrigger:refreshMonster(event, refreshCfg, trigger)
	-- if trigger and refreshCfg.Count and refreshCfg.Count > self.controller.getWave() then
	-- 	trigger.cfg.Active = true
	-- 	return
	-- end
	local params = {}
	if refreshCfg.SummonType ~= "RandomPos" then
		local pointsIDs = self.groupList[refreshCfg.TargetID or refreshCfg.GroupID]
		local pointPosList = {}
		for i,v in ipairs(pointsIDs or {}) do
			local point = self.mapInfo.visualNodes[v]
			local pos = {x=point.Position.X,y = point.Position.Y}
			pointPosList[#pointPosList + 1] = pos
		end
		table.insert(params, pointPosList)
	end
	if event == "TriggerEventDestroiableSummon" then
		self.controller.onCreateObstacle(refreshCfg,params)
	else
		EventMgr:dispatchEvent(EV_BATTLE_BRUSH_MONSTER, refreshCfg, params)
	end
    
end

--设置多条件触发器参数
function EventTrigger:setMultTrigger(refreshCfg)
	local tmTrigger = self.triggerList[refreshCfg.TargetID]
	if tmTrigger then
		tmTrigger.cfg["Param"..refreshCfg.Number] = refreshCfg.Value
		tmTrigger.checkFunc()
	end
end

--关卡挑战成功或失败
function EventTrigger:onBattleEnd(event)
	local isWin = false
	if event == "TriggerEventWin" then
		isWin = true
	elseif event == "TriggerEventFail" then
		isWin = false
	else

	end
	EventMgr:dispatchEvent(EV_BATTLE_END_TRIGGER_EVENT, isWin)
	self:clearTriggers()
end

--区域事件完成
function EventTrigger:onAreaComplete(event)
	self.controller.nextState()
end
--播放音效
function EventTrigger:onPlaySound(event,soundCfg)
	local effectCfg = TabDataMgr:getData("DungeonLevelSound",soundCfg["SoundID"])
	local function playEffectSound(res,volume,loop)
		local handleId = TFAudio.playEffect(res,false,1,0,volume)
		self.soundPlayList[handleId] = loop
		TFAudio.setFinishCallback(handleId,function(audioid,filepath)
			if self.soundPlayList[handleId] then
				local lestloop = self.soundPlayList[handleId] - 1
				if lestloop > 0 then
					playEffectSound(res,volume,lestloop)
				end
				self.soundPlayList[handleId] = nil
			end
		end)
	end

	if soundCfg["Loop"] > 0 then
		playEffectSound(effectCfg.resource,effectCfg.volume,soundCfg["Loop"])
	else
		if soundCfg["Duration"] > 0 then
			local handleId = TFAudio.playEffect(effectCfg.resource,true,1,0,effectCfg.volume)
			local timmerid = BattleTimerManager:addTimer(1000,soundCfg["Duration"],function()
				BattleTimerManager:removeTimer(timmerid)
				if TFAudio.isEffectPlaying(handleId) then
					TFAudio.stopEffect(handleId)
				end
			end,nil)
		else
			TFAudio.playEffect(effectCfg.resource,false,1,0,effectCfg.volume)
		end
	end
end

--播放背景音乐
function EventTrigger:onPlayBGM(event,BGMCfg)
	local bgmCfg = TabDataMgr:getData("DungeonLevelSound",BGMCfg["MusicID"])
	if BGMCfg["Duration"] > 0 then
		if TFAudio.isMusicPlaying() then
			local tmvolume = TFAudio.getMusicVolume()
			if tmvolume > 0 then
				local step = tmvolume/(BGMCfg["Duration"]/100)
				local timmerid = BattleTimerManager:addTimer(100,BGMCfg["Duration"]/100,function()
					BattleTimerManager:removeTimer(timmerid)
					TFAudio.stopMusic()
					SafeAudioExchangePlay().stopAllBgm()
					TFAudio.playBmg(bgmCfg.resource,true)
				end,function()
					tmvolume = tmvolume - step
					TFAudio.setMusicVolume(tmvolume)
				end)
			else
				TFAudio.playBmg(bgmCfg.resource,true)
			end
			
		else
			TFAudio.playBmg(bgmCfg.resource,true)
		end
	else
		TFAudio.playBmg(bgmCfg.resource,true)
	end
end

function EventTrigger:onPlayCG(cfg)
	EventMgr:dispatchEvent(EV_BATTLE_PLAYCG_ANIM,{cgid = cfg.CGID})
end

function EventTrigger:onPlayScriptAnim(cfg)
	self.controller.setTiming(false)
	self.ScriptAnimRunning = true

	local danmuId = Utils:getDanmuId(EC_DanmuType.SCRIPT,cfg.ScriptAnimID)
	if danmuId then
		local param = {
	        id = danmuId,
	        offset = 60,
	        danmuHeight = 580,
	        autoRun = true,
	        rowNum = 8
	    }
	    self.danmuMark = Utils:createDanmuMark(param)
	    self.danmuMark:setZOrder(9000)
	    Public:currentScene():addChild(self.danmuMark)
	end
	StoryScriptParse:parse({scriptName = cfg.ScriptAnimID,triggerId = cfg.ActivateID,callback = handler(self.onScriptAnimComplete,self),battleCtrl = self.controller})
end

function EventTrigger:onScriptAnimComplete(params)
	self.mapInfo:removeVisualHeros()
	self.ScriptAnimRunning = false
	if self.mapInfo.data.root.ScriptAnimID == params.scriptId then
		self.battleCallback()
		return
	end
	self.controller.setTiming(true)
	if params.triggers then
		for i,v in ipairs(params.triggers) do
			self:On_OffObj(params.event or "TriggerEventActivate",tonumber(v))
		end
	end
	
	if self.danmuMark then
		self.danmuMark:removeEvents()
		self.danmuMark:removeFromParent()
		self.danmuMark = nil
	end
end

function EventTrigger:onStageDot(cfg)
	
end

function EventTrigger:onAssistant(cfg)
	self.controller.activateAssit()
end

function EventTrigger:onObjectMove(cfg)
	self.mapInfo:moveObject(cfg)
end

function EventTrigger:onMonsterWarning(cfg)
	EventMgr:dispatchEvent(eEvent.EVENT_MONSTER_WARNING,cfg.Duration)
end

function EventTrigger:onPenalty(cfg,hero)
	local curMakrs = self.controller._onPenalty(hero)
	if curMakrs <= 0 then
		EventMgr:dispatchEvent(EV_BATTLE_END_TRIGGER_EVENT, false)
		self:clearTriggers()
	end
end

function EventTrigger:onShowTip(cfg)
	EventMgr:dispatchEvent(eEvent.EVENT_BATTLE_TIPS,{duration = cfg.Duration,strid = cfg.ID})
end

function EventTrigger:isRunning()
	return self.ScriptAnimRunning
end



return EventTrigger
