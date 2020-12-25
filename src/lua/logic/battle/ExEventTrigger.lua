local ExEventTrigger = ExEventTrigger or {}
local TriggerType = {
	DieCounterTrigger = "DieCounterTrigger",
	HPTrigger = "HPTrigger",
	RegionTrigger = "RegionTrigger",
	AliveCounterTrigger = "AliveCounterTrigger",
	DamageTrigger = "DamageTrigger",
	TimerTrigger = "TimerTrigger",
	MultConditionTrigger = "MultConditionTrigger",
	TeamAliveTimerTrigger = "TeamAliveTimerTrigger",
}
local TriggerCfgModel = {
	["DieCounterTrigger"] = {
			["Count"] = 1, 
	        ["CheckTypeParam"] = 0, 
	        ["CheckType"] = 2, 
	        ["ID"] = 0, 
	        ["Active"] = false, 
	        ["Duration"] = 0, 
	        ["type"] = "DieCounterTrigger",
	        ["Events"] = {},
		},
	["AliveCounterTrigger"] = {
			["Count"] = 0, 
            ["CheckTypeParam"] = 0, 
            ["CheckType"] = 2, 
            ["ID"] = 0, 
            ["Active"] = false, 
            ["CompareType"] = "<=",
            ["Duration"] = 0,  
            ["type"] = "AliveCounterTrigger", 
            ["Events"] = {},
		},
	["TimerTrigger"] = {
			["Count"] = 1, 
            ["ID"] = 0, 
            ["Active"] = false, 
            ["Duration"] = 1000,  
            ["type"] = "TimerTrigger", 
            ["Events"] = {},
		},
	["DamageTrigger"] = {
			["Value"] = 0, 
            ["ID"] = 0, 
            ["Active"] = false, 
            ["Duration"] = 0,
            ["CompareType"] = ">=",  
            ["type"] = "DamageTrigger", 
            ["Events"] = {},
		},
	["RegionTrigger"] = {
			["ID"] = 0, 
            ["Active"] = false, 
            ["Duration"] = 0,  
            ["type"] = "RegionTrigger",
            ["TargetID"] = -1,
            ["AllEnemy"] = false,
            ["IsGo"] = false,  
            ["Position"] = {
                        ["Y"] = 200, 
                        ["X"] = 0,
                    },
            ["Size"] = {
                        ["H"] = 400, 
                        ["W"] = 200,
                    },
            ["Scale"] = {
                        ["Y"] = 1, 
                        ["X"] = 1,
                    },
            ["Events"] = {},
		},
	["TeamAliveTimerTrigger"] = {
            ["ID"] = 0, 
            ["Active"] = false, 
            ["Duration"] = 0,  
            ["type"] = "TeamAliveTimerTrigger", 
            ["Events"] = {},
		},
	["MultConditionTrigger"] = {
			["ID"] = 0, 
            ["Active"] = false, 
           	["Param1"] = true,
            ["Param2"] = true,
            ["Param3"] = true,
            ["Param4"] = true,
            ["Param5"] = true,
            ["type"] = "MultConditionTrigger", 
            ["Events"] = {},
		},
}
local SummonTypeEnum = { 'RandomPos', 'OrderPoint', 'RandomPoint'}
local EventCfgModel = {
	["TriggerEventActivate"] = {
			["TargetID"] = 1063, 
            ["Class"] = "TriggerEventActivate",
		},
	["TriggerEventUnActivate"] = {
			["TargetID"] = 1063, 
            ["Class"] = "TriggerEventUnActivate",
		},
	["TriggerEventAreaTaskDone"] = {
            ["Class"] = "TriggerEventAreaTaskDone",
		},
	["TriggerEventWin"] = { 
            ["Class"] = "TriggerEventWin",
		},
	["TriggerEventFail"] = { 
	        ["Class"] = "TriggerEventFail",
		},
	["TriggerEventSummon"] = {
			["Count"] = 2,
			["Duration"] = 0,
            ["SummonType"] = "RandomPos",
            ["NearbyHero"] = 0,
            ["Class"] = "TriggerEventSummon",
            ["TargetID"] = 0,
		},
	["TriggerEventSummonAdd"] = {
            ["Count"] = 1, 
            ["SummonType"] = "RandomPos", 
            ["TargetID"] = 0,
            ["Duration"] = 0, 
            ["NearbyHero"] = 0,
            ["Class"] = "TriggerEventSummonAdd",
            ["TargetID"] = 0,
        },
	["TriggerEventModifyMultiConditionTrigger"] = {
			["TargetID"] = 0, 
            ["Number"] = 1, 
            ["Value"] = true, 
            ["Class"] = "TriggerEventModifyMultiConditionTrigger",
		},
	["TriggerEventAreaTaskDone"] = {
            ["Class"] = "TriggerEventAreaTaskDone",
        },
    ["TriggerEventPlayScriptAnim"] = {
            ["Class"] = "TriggerEventPlayScriptAnim",
            ["ScriptAnimID"] = "0",
            ["ActivateID"] = "",
        },
    ["TriggerEventMonsterWarning"] = {
            ["Class"] = "TriggerEventMonsterWarning",
            ["Duration"] = 0,
        },
    ["TriggerEventPenalty"] = {
    		["Class"] = "TriggerEventPenalty",
		},

}

local AirPointModel = {
            ["Color"] = {
                ["A"] = 0.5, 
                ["R"] = 0, 
                ["B"] = 0, 
                ["G"] = 1
            }, 
            ["Mark"] = "0", 
            ["Radius"] = 15, 
            ["Position"] = {
                ["Y"]= 0, 
                ["X"]= 0
            }, 
            ["Active"] = false, 
            ["Alpha"] = 255, 
            ["Z"] = 5, 
            ["type"] = "PointLayer", 
            ["ID"] = 0
}
function ExEventTrigger:clear()
	self.tiggerCfg = {}
	self.BeginTimmerTrigger = nil
	self.triggerIdSeed = 5000
	ExEventTrigger.exCfg = TabDataMgr:getData("DungeonLevelStep")
	ExEventTrigger.extStepCfg = TabDataMgr:getData("DungeonLevelStepExt")

end
function ExEventTrigger:getNewTriggerId()
	local triggerId = self.triggerIdSeed
	self.triggerIdSeed = self.triggerIdSeed + 1
	return triggerId
end

function ExEventTrigger:getMonsterWarningDelay(monsterIdx)
	local monsterSectionCid = self.monsterSection_[monsterIdx]
	local monsterSectionCfg = TabDataMgr:getData("MonsterSection", monsterSectionCid)
	local warningDelayTime = 0
	if monsterSectionCfg.warning then
		warningDelayTime = 4000
	end
	return warningDelayTime
end

function ExEventTrigger:getBrushMonsterCount(monsterIdx)
	local monsterSectionCid = self.monsterSection_[monsterIdx]
	local monsterSectionCfg = TabDataMgr:getData("MonsterSection", monsterSectionCid)
	local monsterCount = 0
	monsterCount = monsterCount + table.count(monsterSectionCfg.fixedMonster)
	for k,v in pairs(monsterSectionCfg.randomMonster) do
		monsterCount = monsterCount + v[2]
	end
	return monsterCount
end
function ExEventTrigger:getExTriggerCfg(id)
	self:clear()
	self.levelCfg_ = BattleDataMgr:getLevelCfg()
	self.monsterSection_ = self.levelCfg_.monsterGroupId
	local tmcfg = ExEventTrigger.exCfg[id]
	if tmcfg.op and tmcfg.op ~= "" then
		self.BeginTimmerTrigger = clone(TriggerCfgModel.TimerTrigger)
		self.BeginTimmerTrigger.ID = 4999
		self.BeginTimmerTrigger.Duration = 0
		self.BeginTimmerTrigger.Active = true
		local BeginScriptEvt = clone(EventCfgModel.TriggerEventPlayScriptAnim)
		BeginScriptEvt.ScriptAnimID = tonumber(tmcfg.op)
		self.BeginTimmerTrigger.Events[#self.BeginTimmerTrigger.Events + 1] = BeginScriptEvt
	end
	local exTriggerDict = {}
	if tmcfg.extCfgID ~= 0 then
		local tmExtCfg = self.extStepCfg[tmcfg.extCfgID]
		if tmExtCfg then
			if tmExtCfg.victoryType == 1 then
				exTriggerDict = self:makeDefenderModel(tmExtCfg)
			elseif tmExtCfg.victoryType == 2 then
				exTriggerDict = self:makeTowerDefenceModel(tmExtCfg)
			elseif tmExtCfg.victoryType == 3 then

			else

			end
		end

	end
	if tmcfg.extCfgID == nil or tmcfg.extCfgID == 0 then
		if #tmcfg["MonsterN1"] > 0 then
			exTriggerDict = self:monsterNMode(tmcfg)
		elseif #tmcfg["MonsterE"] > 0 then
			exTriggerDict = self:monsterEMode(tmcfg)
		elseif #tmcfg["MonsterT"] > 0 then
			exTriggerDict = self:monsterTMode(tmcfg)
		elseif tmcfg["MonsterL"] > 0 then
			exTriggerDict = self:monsterLMode(tmcfg)
		else

		end
	end
	return exTriggerDict
end

function ExEventTrigger:triggerWithWinOrFail(cfg)
	local tmtriggerList = {}
	
	if cfg["victoryType"] == 1 then
		local tmtrigger = clone(TriggerCfgModel.AliveCounterTrigger)
		tmtrigger.CheckType = 2
		tmtrigger.CompareType = "<="
		tmtrigger.Count = 0
		tmtrigger.ID = self:getNewTriggerId()
		
		-- tmtrigger.Events[#tmtrigger.Events + 1] = tmEndEvent
		tmtriggerList[#tmtriggerList + 1] = tmtrigger
	elseif cfg["victoryType"] == 2 then
		-- local tmtrigger = clone(TriggerCfgModel.TeamAliveTimerTrigger)
		-- tmtrigger.Duration = cfg.victoryParam[1][1]
		-- tmtrigger.ID = self:getNewTriggerId()
		-- if self.BeginTimmerTrigger == nil then
		-- 	tmtrigger.Active = true
		-- else
		-- 	local m_activeIds = self.BeginTimmerTrigger.Events[#self.BeginTimmerTrigger.Events].ActivateID
		-- 	if m_activeIds ~= "" then
		-- 		m_activeIds = m_activeIds..","..tmtrigger.ID
		-- 	else
		-- 		m_activeIds = tostring(tmtrigger.ID)
		-- 	end
		-- 	self.BeginTimmerTrigger.Events[#self.BeginTimmerTrigger.Events].ActivateID = m_activeIds
		-- end
		-- -- tmtrigger.Events[#tmtrigger.Events + 1] = tmEndEvent
		-- tmtriggerList[#tmtriggerList + 1] = tmtrigger
	elseif cfg["victoryType"] == 3 or cfg["victoryType"] == 4 or cfg["victoryType"] == 5 then
		local tmMultableTrigger = clone(TriggerCfgModel.MultConditionTrigger)
		tmMultableTrigger.ID = self:getNewTriggerId()
		-- tmMultableTrigger.Events[#tmMultableTrigger.Events + 1] = tmEndEvent
		tmtriggerList[#tmtriggerList + 1] = tmMultableTrigger
		local idNum = #cfg.victoryParam
		for i=1,idNum do
			tmMultableTrigger["Param"..i] = false
			local tmDieCfg = cfg.victoryParam[i]
			local tmDieTrigger = clone(TriggerCfgModel.DieCounterTrigger)
			tmDieTrigger.ID = self:getNewTriggerId()
			local ctype = {[3] = 1,[4] = 0,[5] = 2}
			tmDieTrigger.CheckType = ctype[cfg["victoryType"]]
			if cfg["victoryType"] == 4 then
				tmDieTrigger.CheckTypeParam = tmDieCfg[1] - 1
			else
				tmDieTrigger.CheckTypeParam = tmDieCfg[1]
			end
			if tmDieTrigger.CheckType == 2 then
				tmDieTrigger.Count = tmDieCfg[1]
			else
				tmDieTrigger.Count = tmDieCfg[2]
			end
			
			local tmDieEvent = clone(EventCfgModel.TriggerEventModifyMultiConditionTrigger)
			tmDieEvent.TargetID = tmMultableTrigger.ID
			tmDieEvent.Number = i
			tmDieEvent.Value = true
			tmDieTrigger.Events[#tmDieTrigger.Events + 1] = tmDieEvent
			tmDieTrigger.Active = true
			tmtriggerList[#tmtriggerList + 1] = tmDieTrigger
		end
		if self.BeginTimmerTrigger == nil then
			tmMultableTrigger.Active = true
		else
			local m_activeIds = self.BeginTimmerTrigger.Events[#self.BeginTimmerTrigger.Events].ActivateID
			if m_activeIds ~= "" then
				m_activeIds = m_activeIds..","..tmMultableTrigger.ID
			else
				m_activeIds = tostring(tmMultableTrigger.ID)
			end
			self.BeginTimmerTrigger.Events[#self.BeginTimmerTrigger.Events].ActivateID = m_activeIds
		end
	elseif cfg["victoryType"] == 10 then
		local tmtrigger = clone(TriggerCfgModel.DamageTrigger)
		local params = cfg.victoryParam[1]
		tmtrigger.ID = self:getNewTriggerId()
		tmtrigger.CompareType = ">="
		tmtrigger.Value = params[2] or 0
		tmtrigger.Active = true

		tmtriggerList[#tmtriggerList + 1] = tmtrigger
	else

	end
	if #tmtriggerList > 0 then
		local tmEndEvent = clone(EventCfgModel.TriggerEventWin)
		if cfg.endScript and cfg.endScript ~= "" then
			local tmWinEvent = clone(EventCfgModel.TriggerEventWin)
			local endTimerTrigger = clone(TriggerCfgModel.TimerTrigger)
			endTimerTrigger.Duration = 0
			endTimerTrigger.ID = self:getNewTriggerId()
			endTimerTrigger.Count = 1
			endTimerTrigger.Active = false
			endTimerTrigger.Events[#endTimerTrigger.Events + 1] = tmWinEvent
			tmtriggerList[#tmtriggerList + 1] = endTimerTrigger
			tmEndEvent = clone(EventCfgModel.TriggerEventPlayScriptAnim)
			tmEndEvent.ScriptAnimID = tonumber(cfg.endScript)
			tmEndEvent.ActivateID = endTimerTrigger.ID
		end

		tmtriggerList[1].Events[#tmtriggerList[1].Events + 1] = tmEndEvent
	end
	return tmtriggerList
end

function ExEventTrigger:monsterNMode(cfg)
	local tmtriggers = self:triggerWithWinOrFail(cfg)
	--空气墙部分
	local airWall = {}
	local areaTriggers = {}
	for i=1,4 do
		if #cfg["LengthN"..i] == 2 then
			airWall[i] = {}
			local walkLen = 0
			local wallidA = self:getNewTriggerId()
			local wallidB = self:getNewTriggerId()
			local leftWall = clone(AirPointModel)
			local rightWall = clone(AirPointModel)
			leftWall.ID = wallidA
			rightWall.ID = wallidB
	        if i == 1 then
	            leftWall.Active = true
	            rightWall.Active = true
	        end
			airWall[i][1] = leftWall
			airWall[i][2] = rightWall
			leftWall.Position.X = cfg["LengthN"..i][1]
			rightWall.Position.X = cfg["LengthN"..i][2]
			if i > 1 then
				local tmAreaTrigger = clone(TriggerCfgModel.RegionTrigger)
				tmAreaTrigger.Position.X = (leftWall.Position.X + rightWall.Position.X)/2
				tmAreaTrigger.Size.W = (rightWall.Position.X - leftWall.Position.X)/2
				tmAreaTrigger.ID = self:getNewTriggerId()
				tmAreaTrigger.IsGo = true
				areaTriggers[#areaTriggers + 1] = tmAreaTrigger
			end
		end
	end



	--刷怪部分
	local addTriggers = {}
	local plusTriggers = {}
	local plusTimeTriggers = {}
	for i=1,4 do
		if #cfg["MonsterN"..i] > 0 then
			addTriggers[i] = {}
			for j = 1,#cfg["MonsterN"..i] do			
				local tmtrigger = clone(TriggerCfgModel.AliveCounterTrigger)
				tmtrigger.ID = self:getNewTriggerId()
				tmtrigger.Active = false
				if i == 1 and j == 1 then
					if self.BeginTimmerTrigger == nil then
						tmtrigger.Active = true
					else
						local m_activeIds = self.BeginTimmerTrigger.Events[#self.BeginTimmerTrigger.Events].ActivateID
						if m_activeIds ~= "" then
							m_activeIds = m_activeIds..","..tmtrigger.ID
						else
							m_activeIds = tostring(tmtrigger.ID)
						end
						self.BeginTimmerTrigger.Events[#self.BeginTimmerTrigger.Events].ActivateID = m_activeIds
					end
					tmtrigger.Duration = 2000
				else
					tmtrigger.Duration = 100
				end
				
				tmtrigger.CompareType = "<="
				tmtrigger.Count = cfg["MonsterN"..i][j][2]
				
				local tmEvent = clone(EventCfgModel.TriggerEventSummon)
				tmEvent.Count = cfg["MonsterN"..i][j][1]
				tmEvent.Duration = cfg["MonsterN"..i][j][3]
				tmEvent.NearbyHero = cfg.monsterBornLimit or 0
				tmtrigger.Events[#tmtrigger.Events + 1] = tmEvent
				if j == #cfg["MonsterN"..i] then
					if airWall[i + 1] then
						local plusDieTigger = clone(TriggerCfgModel.AliveCounterTrigger)
						plusDieTigger.ID = self:getNewTriggerId()
                        if airWall[i][2] then
                            local tmEventPlus = clone(EventCfgModel.TriggerEventUnActivate)
							tmEventPlus.TargetID = airWall[i][2].ID
							plusDieTigger.Events[#plusDieTigger.Events + 1] = tmEventPlus
                        end
              
                        if airWall[i + 1][2] then
                            local tmEventPlus = clone(EventCfgModel.TriggerEventActivate)
							tmEventPlus.TargetID = airWall[i + 1][2].ID
							plusDieTigger.Events[#plusDieTigger.Events + 1] = tmEventPlus
                        end
						
						if areaTriggers[i] then
							local tmEventPlus = clone(EventCfgModel.TriggerEventActivate)
							tmEventPlus.TargetID = areaTriggers[i].ID
							plusDieTigger.Events[#plusDieTigger.Events + 1] = tmEventPlus
							local areaEvent = clone(EventCfgModel.TriggerEventAreaTaskDone)
							plusDieTigger.Events[#plusDieTigger.Events + 1] = areaEvent
						end
						plusTriggers[#plusTriggers +1] = plusDieTigger
						local tmDelayCheck = clone(TriggerCfgModel.TimerTrigger)
						tmDelayCheck.ID = self:getNewTriggerId()
						--强敌来袭显示检测
				    	local warningDelayTime = self:getMonsterWarningDelay(cfg["MonsterN"..i][j][1])
				    	local brushTime = self:getBrushMonsterCount(cfg["MonsterN"..i][j][1]) * cfg["MonsterN"..i][j][3]
						tmDelayCheck.Duration = 1000 + brushTime + warningDelayTime
						tmDelayCheck.Active = false
						tmDelayCheck.Count = 1
						plusTimeTriggers[#plusTimeTriggers + 1] = tmDelayCheck

						local tmEventDD = clone(EventCfgModel.TriggerEventActivate)
						tmEventDD.TargetID = plusDieTigger.ID
						tmDelayCheck.Events[#tmDelayCheck.Events + 1] = tmEventDD

						local tmEventP = clone(EventCfgModel.TriggerEventActivate)
						tmEventP.TargetID = tmDelayCheck.ID
						tmtrigger.Events[#tmtrigger.Events + 1] = tmEventP
					end
				end
				
				addTriggers[i][#addTriggers[i] + 1] = tmtrigger
				
			end
		end
	end

	
	for i=1,#addTriggers do
		for j=1,#addTriggers[i] do
			if j ~= #addTriggers[i] then
				local tmtrigger = addTriggers[i][j]
				

				local tmDelayDo = clone(TriggerCfgModel.TimerTrigger)
				tmDelayDo.ID = self:getNewTriggerId()
				tmDelayDo.Duration = 2000
				tmDelayDo.Active = false
				tmDelayDo.Count = 1
				plusTimeTriggers[#plusTimeTriggers + 1] = tmDelayDo

				local tmEvent = clone(EventCfgModel.TriggerEventActivate)
				tmEvent.TargetID = addTriggers[i][j + 1].ID
				tmDelayDo.Events[#tmDelayDo.Events + 1] = tmEvent

				local tmActDelayEvent = clone(EventCfgModel.TriggerEventActivate)
				tmActDelayEvent.TargetID = tmDelayDo.ID
				tmtrigger.Events[#tmtrigger.Events + 1] = tmActDelayEvent
			else
				if areaTriggers[i] then
					if addTriggers[i + 1] then
						local tmtrigger = addTriggers[i + 1][1]
						local tmAreaTrigger = areaTriggers[i]

						local tmplusTimeTrigger = clone(TriggerCfgModel.TimerTrigger)
						tmplusTimeTrigger.Duration = 2000
						tmplusTimeTrigger.ID = self:getNewTriggerId()
						plusTimeTriggers[#plusTimeTriggers + 1] = tmplusTimeTrigger

						local tmEvent = clone(EventCfgModel.TriggerEventActivate)
						tmEvent.TargetID = tmtrigger.ID
						tmplusTimeTrigger.Events[#tmAreaTrigger.Events + 1] = tmEvent

						local tmEventBM = clone(EventCfgModel.TriggerEventActivate)
						tmEventBM.TargetID = tmplusTimeTrigger.ID
						tmAreaTrigger.Events[#tmAreaTrigger.Events + 1] = tmEventBM

                        if airWall[i][1] then
                            local tmEventPlus = clone(EventCfgModel.TriggerEventUnActivate)
						    tmEventPlus.TargetID = airWall[i][1].ID
						    tmAreaTrigger.Events[#tmAreaTrigger.Events + 1] = tmEventPlus
                        end
              
                        if airWall[i + 1][1] then
                            local tmEventPlus = clone(EventCfgModel.TriggerEventActivate)
						    tmEventPlus.TargetID = airWall[i + 1][1].ID
						    tmAreaTrigger.Events[#tmAreaTrigger.Events + 1] = tmEventPlus
                        end
					end
                    
				else
					if cfg["victoryType"] == 1 then
						local tmtrigger = addTriggers[i][j]
						local winOrFail = tmtriggers[1]
						if winOrFail then

							local tmplusTimeTrigger = clone(TriggerCfgModel.TimerTrigger)
							local warningDelayTime = self:getMonsterWarningDelay(cfg["MonsterN"..i][j][1])
				    		local brushTime = self:getBrushMonsterCount(cfg["MonsterN"..i][j][1]) * cfg["MonsterN"..i][j][3]
							tmplusTimeTrigger.Duration = 1000 + brushTime + warningDelayTime
							tmplusTimeTrigger.ID = self:getNewTriggerId()
							plusTimeTriggers[#plusTimeTriggers + 1] = tmplusTimeTrigger

							local tmActEvt = clone(EventCfgModel.TriggerEventActivate)
							tmActEvt.TargetID = winOrFail.ID
							tmplusTimeTrigger.Events[#tmplusTimeTrigger.Events + 1] = tmActEvt

							local tmEvent = clone(EventCfgModel.TriggerEventActivate)
							tmEvent.TargetID = tmplusTimeTrigger.ID
							tmtrigger.Events[#tmtrigger.Events + 1] = tmEvent
							local areaEvent = clone(EventCfgModel.TriggerEventAreaTaskDone)
							winOrFail.Events[#winOrFail.Events + 1] = areaEvent
						end
					end
				end
			end
		end
	end
	local jsonData = {}
	jsonData["visualNode"] = {}
	for k,v in pairs(airWall) do
		for s,t in pairs(v) do
			jsonData["visualNode"][#jsonData["visualNode"] + 1] = t
		end
	end
	jsonData["triggers"] = {}
	if self.BeginTimmerTrigger then
		jsonData["triggers"][#jsonData["triggers"] + 1] = self.BeginTimmerTrigger
	end
	for i,v in ipairs(tmtriggers) do
		jsonData["triggers"][#jsonData["triggers"] + 1] = v
	end
	for i,v in ipairs(areaTriggers) do
		jsonData["triggers"][#jsonData["triggers"] + 1] = v
	end
	for i,v in ipairs(addTriggers) do
		for s,t in ipairs(v) do
			jsonData["triggers"][#jsonData["triggers"] + 1] = t
		end
	end
	for i,v in ipairs(plusTriggers) do
		jsonData["triggers"][#jsonData["triggers"] + 1] = v
	end
	for i,v in ipairs(plusTimeTriggers) do
		jsonData["triggers"][#jsonData["triggers"] + 1] = v
	end
	
	return jsonData
end

function ExEventTrigger:monsterEMode(cfg)
	local tmtriggers = self:triggerWithWinOrFail(cfg)
	--空气墙部分
	local airWall = {}
	local wallidA = self:getNewTriggerId()
	local wallidB = self:getNewTriggerId()
	local leftWall = clone(AirPointModel)
	local rightWall = clone(AirPointModel)
	leftWall.Active =true
	rightWall.Active = true
	leftWall.ID = wallidA
	rightWall.ID = wallidB
	leftWall.Position.X = cfg.LengthE[1]
	rightWall.Position.X = cfg.LengthE[2]
	airWall[#airWall + 1] = leftWall
	airWall[#airWall + 1] = rightWall
	--刷怪部分
	local addTriggers = {}
	for i = 1,#cfg.MonsterE do
		local tmtrigger = clone(TriggerCfgModel.AliveCounterTrigger)
		tmtrigger.ID = self:getNewTriggerId()
		tmtrigger.Active = false
		if i == 1 then
			if self.BeginTimmerTrigger == nil then
				tmtrigger.Active = true
			else
				local m_activeIds = self.BeginTimmerTrigger.Events[#self.BeginTimmerTrigger.Events].ActivateID
				if m_activeIds ~= "" then
					m_activeIds = m_activeIds..","..tmtrigger.ID
				else
					m_activeIds = tostring(tmtrigger.ID)
				end
				self.BeginTimmerTrigger.Events[#self.BeginTimmerTrigger.Events].ActivateID = m_activeIds
			end
		end
		
		tmtrigger.Count = cfg["MonsterE"][i][2]
        tmtrigger.Duration = 100
		local tmEvent = clone(EventCfgModel.TriggerEventSummon)
		tmEvent.Count = cfg["MonsterE"][i][1]
		tmEvent.Duration = cfg["MonsterE"][i][3]
		tmEvent.NearbyHero = cfg.monsterBornLimit or 0
		tmtrigger.Events[#tmtrigger.Events + 1] = tmEvent
		addTriggers[#addTriggers + 1] = tmtrigger
	end
	for i = 1,#addTriggers do
		local tmEvent = clone(EventCfgModel.TriggerEventActivate)
		if i == #addTriggers then
			tmEvent.TargetID = addTriggers[1].ID
		else
			tmEvent.TargetID = addTriggers[i + 1].ID
		end

		local tmDelayCheck = clone(TriggerCfgModel.TimerTrigger)
		tmDelayCheck.ID = self:getNewTriggerId()
		--强敌来袭显示检测
    	local warningDelayTime = self:getMonsterWarningDelay(cfg["MonsterE"][i][1])
		tmDelayCheck.Duration = 2000 + warningDelayTime
		tmDelayCheck.Active = false
		tmDelayCheck.Count = 1
		plusTimeTriggers[#plusTimeTriggers + 1] = tmDelayCheck

		tmDelayCheck.Events[#tmDelayCheck.Events + 1] = tmEvent

		local tmEventP = clone(EventCfgModel.TriggerEventActivate)
		tmEventP.TargetID = tmDelayCheck.ID

		addTriggers[i].Events[#addTriggers[i].Events + 1] = tmEventP
	end
	local jsonData = {}
	jsonData["visualNode"] = airWall
	jsonData["triggers"] = {}
	if self.BeginTimmerTrigger then
		jsonData["triggers"][#jsonData["triggers"] + 1] = self.BeginTimmerTrigger
	end
	for i,v in ipairs(tmtriggers) do
		jsonData["triggers"][#jsonData["triggers"] + 1] = v
	end
	for i,v in ipairs(addTriggers) do
		jsonData["triggers"][#jsonData["triggers"] + 1] = v
	end
	return jsonData

end

function ExEventTrigger:monsterTMode(cfg)
	local tmtriggers = self:triggerWithWinOrFail(cfg)
	--空气墙部分
	local airWall = {}
	local wallidA = self:getNewTriggerId()
	local wallidB = self:getNewTriggerId()
	local leftWall = clone(AirPointModel)
	local rightWall = clone(AirPointModel)
	leftWall.Active =true
	rightWall.Active = true
	leftWall.ID = wallidA
	rightWall.ID = wallidB
	leftWall.Position.X = cfg.LengthT[1]
	rightWall.Position.X = cfg.LengthT[2]
	airWall[#airWall + 1] = leftWall
	airWall[#airWall + 1] = rightWall
	--刷怪部分
	local addTriggers = {}
	for i = 1,#cfg.MonsterT do
		local tmtrigger = clone(TriggerCfgModel.TimerTrigger)
		tmtrigger.Active = false
		tmtrigger.ID = self:getNewTriggerId()
		tmtrigger.Count = 1
		if i == 1 then
			if self.BeginTimmerTrigger == nil then
				tmtrigger.Active = true
			else
				local m_activeIds = self.BeginTimmerTrigger.Events[#self.BeginTimmerTrigger.Events].ActivateID
					if m_activeIds ~= "" then
					m_activeIds = m_activeIds..","..tmtrigger.ID
				else
					m_activeIds = tostring(tmtrigger.ID)
				end
				self.BeginTimmerTrigger.Events[#self.BeginTimmerTrigger.Events].ActivateID = m_activeIds
			end
		end

		--强敌来袭显示检测
    	local warningDelayTime = self:getMonsterWarningDelay(cfg["MonsterT"][i][1])
		tmtrigger.Duration = cfg["MonsterT"][i][2] + warningDelayTime
		addTriggers[#addTriggers + 1] = tmtrigger
	end
	local plusTriggers = {}
	for i = 1,#addTriggers do
        local tmEventT = clone(EventCfgModel.TriggerEventSummon)
		tmEventT.Count = cfg["MonsterT"][i][1]
		tmEventT.Duration = cfg["MonsterT"][i][3]
		tmEventT.NearbyHero = cfg.monsterBornLimit or 0
		local tmAliveTrigger = clone(TriggerCfgModel.AliveCounterTrigger)
		tmAliveTrigger.ID = self:getNewTriggerId()
		tmAliveTrigger.Active = false
		tmAliveTrigger.Count = cfg.NumMaxT or 10
		tmAliveTrigger.CompareType = "<"
		tmAliveTrigger.Duration = 2000
		tmAliveTrigger.CampNumMax = cfg.CampNumMax or {}
		if tmAliveTrigger.CampNumMax and table.count(tmAliveTrigger.CampNumMax) > 0 then
			tmAliveTrigger.Loop = true
		end
		tmAliveTrigger.Events[#tmAliveTrigger.Events + 1] = tmEventT
		plusTriggers[#plusTriggers + 1] = tmAliveTrigger

		local tmEvent = clone(EventCfgModel.TriggerEventActivate)
		if i == #addTriggers then
			tmEvent.TargetID = addTriggers[1].ID
		else
			tmEvent.TargetID = addTriggers[i + 1].ID
		end
		tmAliveTrigger.Events[#tmAliveTrigger.Events + 1] = tmEvent

		local tmActAliveEvent = clone(EventCfgModel.TriggerEventActivate)
		tmActAliveEvent.TargetID = tmAliveTrigger.ID
		local tmtrigger = addTriggers[i]
		tmtrigger.Events[#tmtrigger.Events + 1] = tmActAliveEvent

	end
	local jsonData = {}
	jsonData["visualNode"] = airWall
	jsonData["triggers"] = {}
	if self.BeginTimmerTrigger then
		jsonData["triggers"][#jsonData["triggers"] + 1] = self.BeginTimmerTrigger
	end
	for i,v in ipairs(tmtriggers) do
		jsonData["triggers"][#jsonData["triggers"] + 1] = v
	end
	for i,v in ipairs(addTriggers) do
		jsonData["triggers"][#jsonData["triggers"] + 1] = v
	end
	for i,v in ipairs(plusTriggers) do
		jsonData["triggers"][#jsonData["triggers"] + 1] = v
	end
	return jsonData
end

function ExEventTrigger:monsterLMode(cfg)
	local tmtriggers = self:triggerWithWinOrFail(cfg)
	--空气墙部分
	local airWall = {}
	local wallidA = self:getNewTriggerId()
	local wallidB = self:getNewTriggerId()
	local leftWall = clone(AirPointModel)
	local rightWall = clone(AirPointModel)
	leftWall.Active =true
	rightWall.Active = true
	leftWall.ID = wallidA
	rightWall.ID = wallidB
	leftWall.Position.X = cfg.LengthL[1]
	rightWall.Position.X = cfg.LengthL[2]
	airWall[#airWall + 1] = leftWall
	airWall[#airWall + 1] = rightWall
	local tmAliveTrigger = clone(TriggerCfgModel.AliveCounterTrigger)
	tmAliveTrigger.CompareType = "<="
	tmAliveTrigger.Count = 0
	tmAliveTrigger.ID = self:getNewTriggerId()
	if self.BeginTimmerTrigger == nil then
		tmAliveTrigger.Active = true
	else
		local m_activeIds = self.BeginTimmerTrigger.Events[#self.BeginTimmerTrigger.Events].ActivateID
		if m_activeIds ~= "" then
			m_activeIds = m_activeIds..","..tmAliveTrigger.ID
		else
			m_activeIds = tostring(tmAliveTrigger.ID)
		end
		self.BeginTimmerTrigger.Events[#self.BeginTimmerTrigger.Events].ActivateID = m_activeIds
	end
	local tmEventK = clone(EventCfgModel.TriggerEventSummonAdd)
	tmEventK.Count = cfg.MonsterL[1]
	tmEventK.Duration = cfg.MonsterL[2]
	tmEventK.NearbyHero = cfg.monsterBornLimit or 0
	tmAliveTrigger.Events[#tmAliveTrigger.Events + 1] = tmEventK

	local tmTimetrigger = clone(TriggerCfgModel.TimerTrigger)
	tmTimetrigger.ID = self:getNewTriggerId()
	--强敌来袭显示检测
	local warningDelayTime = self:getMonsterWarningDelay(cfg.MonsterL[1])
	tmTimetrigger.Duration = cfg.TimeL + warningDelayTime
	tmTimetrigger.Count = 1
	local tmEvent = clone(EventCfgModel.TriggerEventSummonAdd)
	tmEvent.Count = cfg.MonsterL[1]
	tmEvent.Duration = cfg.MonsterL[2]
	tmEvent.NearbyHero = cfg.monsterBornLimit or 0
	tmTimetrigger.Events[#tmTimetrigger.Events + 1] = tmEvent
	local tmDieTrigger = clone(TriggerCfgModel.DieCounterTrigger)
	tmDieTrigger.ID = self:getNewTriggerId()
	tmDieTrigger.Count = 1
	if self.BeginTimmerTrigger == nil then
		tmDieTrigger.Active = true
	else
		local m_activeIds = self.BeginTimmerTrigger.Events[#self.BeginTimmerTrigger.Events].ActivateID
		if m_activeIds ~= "" then
			m_activeIds = m_activeIds..","..tmDieTrigger.ID
		else
			m_activeIds = tostring(tmDieTrigger.ID)
		end
		self.BeginTimmerTrigger.Events[#self.BeginTimmerTrigger.Events].ActivateID = m_activeIds
	end
	
	local tmEventC = clone(EventCfgModel.TriggerEventActivate)
	tmEventC.TargetID = tmDieTrigger.ID
	tmDieTrigger.Events[#tmDieTrigger.Events + 1] = tmEventC

	local tmEventB = clone(EventCfgModel.TriggerEventActivate)
	tmEventB.TargetID = tmTimetrigger.ID
	tmDieTrigger.Events[#tmDieTrigger.Events + 1] = tmEventB
	local tmEventN = clone(EventCfgModel.TriggerEventActivate)
	tmEventN.TargetID = tmDieTrigger.ID
	tmAliveTrigger.Events[#tmAliveTrigger.Events + 1] = tmEventN
	
	if cfg["victoryType"] == 1 then
		local winOrFail = tmtriggers[1]
		if winOrFail then
			local tmWinEvent = clone(EventCfgModel.TriggerEventActivate)
			tmWinEvent.TargetID = winOrFail.ID
			tmAliveTrigger.Events[#tmAliveTrigger.Events + 1] = tmWinEvent
		end
	end

	local jsonData = {}
	jsonData["visualNode"] = airWall
	jsonData["triggers"] = {}
	if self.BeginTimmerTrigger then
		jsonData["triggers"][#jsonData["triggers"] + 1] = self.BeginTimmerTrigger
	end
	for i,v in ipairs(tmtriggers) do
		jsonData["triggers"][#jsonData["triggers"] + 1] = v
	end
	jsonData["triggers"][#jsonData["triggers"] + 1] = tmAliveTrigger
	jsonData["triggers"][#jsonData["triggers"] + 1] = tmTimetrigger
	jsonData["triggers"][#jsonData["triggers"] + 1] = tmDieTrigger
	return jsonData
end

function ExEventTrigger:makeDefenderModel(cfg)
	local tmtriggerList = {}
	--空气墙部分
	local airWall = {}
	local wallidA = self:getNewTriggerId()
	local wallidB = self:getNewTriggerId()
	local leftWall = clone(AirPointModel)
	local rightWall = clone(AirPointModel)
	leftWall.Active =true
	rightWall.Active = true
	leftWall.ID = wallidA
	rightWall.ID = wallidB
	leftWall.Position.X = cfg.LengthN[1]
	rightWall.Position.X = cfg.LengthN[2]
	airWall[#airWall + 1] = leftWall
	airWall[#airWall + 1] = rightWall
	--胜负判定
	local tmWinTrigger = clone(TriggerCfgModel.AliveCounterTrigger)
	tmWinTrigger.CompareType = "<="
	tmWinTrigger.Count = 0
	tmWinTrigger.Active = false
	tmWinTrigger.ID = self:getNewTriggerId()
	tmtriggerList[#tmtriggerList + 1] = tmWinTrigger
	local tmWinEndEvent = clone(EventCfgModel.TriggerEventWin)
	if cfg.endScript and cfg.endScript ~= "" then
		local tmWinEvent = clone(EventCfgModel.TriggerEventWin)
		local endTimerTrigger = clone(TriggerCfgModel.TimerTrigger)
		endTimerTrigger.Duration = 0
		endTimerTrigger.ID = self:getNewTriggerId()
		endTimerTrigger.Count = 1
		endTimerTrigger.Active = false
		endTimerTrigger.Events[#endTimerTrigger.Events + 1] = tmWinEvent
		tmtriggerList[#tmtriggerList + 1] = endTimerTrigger
		tmWinEndEvent = clone(EventCfgModel.TriggerEventPlayScriptAnim)
		tmWinEndEvent.ScriptAnimID = tonumber(cfg.endScript)
		tmWinEndEvent.ActivateID = endTimerTrigger.ID
	end
	tmWinTrigger.Events[#tmWinTrigger.Events + 1] = tmWinEndEvent

	local tmFailTrigger = clone(TriggerCfgModel.DieCounterTrigger)
	tmFailTrigger.CompareType = ">="
	tmFailTrigger.Count = 1
	tmFailTrigger.CheckType = 1
	tmFailTrigger.CheckTypeParam = cfg.loseParam
	tmFailTrigger.Active = false
	tmFailTrigger.ID = self:getNewTriggerId()
	local tmFailEndEvent = clone(EventCfgModel.TriggerEventFail)
	tmFailTrigger.Events[#tmFailTrigger.Events + 1] = tmFailEndEvent
	tmtriggerList[#tmtriggerList + 1] = tmFailTrigger
	--刷怪
	local brushCheckerIDList = {}
	local brushTimerList = {}
	for k,v in ipairs(cfg.monsterWellen) do
		local tmBrushTimer = clone(TriggerCfgModel.TimerTrigger)
		tmBrushTimer.Duration = v[5] or 0
		tmBrushTimer.Count = 1
		tmBrushTimer.ID = self:getNewTriggerId()
		tmtriggerList[#tmtriggerList + 1] = tmBrushTimer
		brushTimerList[#brushTimerList + 1] = tmBrushTimer
		local tmBrushEvent = clone(EventCfgModel.TriggerEventSummon)
		tmBrushEvent.Duration = v[3]
		tmBrushEvent.Count = v[1]
		tmBrushEvent.SummonType = SummonTypeEnum[2]
		if v[4] ~= 0 then
			tmBrushEvent.TargetID = v[4]
			tmBrushEvent.NearbyHero = 0
		else
			tmBrushEvent.TargetID = 0
			tmBrushEvent.NearbyHero = 1
		end
		tmBrushTimer.Events[#tmBrushTimer.Events + 1] = tmBrushEvent

		--刷怪条件检测
		local tmBrushCheck = clone(TriggerCfgModel.AliveCounterTrigger)
		tmBrushCheck.CompareType = "<="
		tmBrushCheck.Count = v[2]
		tmBrushCheck.CheckType = 2
		tmBrushCheck.Active = (k == 1)
		tmBrushCheck.Duration = 0
		tmBrushCheck.ID = self:getNewTriggerId()
		tmtriggerList[#tmtriggerList + 1] = tmBrushCheck
		brushCheckerIDList[#brushCheckerIDList + 1] = tmBrushCheck.ID
		
		local tmActiveBrushTimerEvent = clone(EventCfgModel.TriggerEventActivate)
		tmActiveBrushTimerEvent.TargetID = tmBrushTimer.ID
		tmBrushCheck.Events[#tmBrushCheck.Events + 1] = tmActiveBrushTimerEvent
		--怪物预警
		if v[5] and v[5] > 0 then
			local tmMonsterWarningEvent = clone(EventCfgModel.TriggerEventMonsterWarning)
			tmMonsterWarningEvent.Duration = v[5]
			tmBrushCheck.Events[#tmBrushCheck.Events + 1] = tmMonsterWarningEvent
		end
	end

	for i = 1,#brushTimerList do
		local tmBrushTimer = brushTimerList[i]
    	local warningDelayTime = self:getMonsterWarningDelay(cfg.monsterWellen[i][1])
		if i == 1 then
			local tmActiveFailTimer = clone(TriggerCfgModel.TimerTrigger)
			tmActiveFailTimer.Duration = 2000
			tmActiveFailTimer.ID = self:getNewTriggerId()
			tmActiveFailTimer.Count = 1
			tmtriggerList[#tmtriggerList + 1] = tmActiveFailTimer
			local tmActiveFailEvent = clone(EventCfgModel.TriggerEventActivate)
			tmActiveFailEvent.TargetID = tmFailTrigger.ID
			tmBrushTimer.Events[#tmBrushTimer.Events + 1] = tmActiveFailEvent
		end
		if i ~= #brushTimerList then
			local tmActiveCheckTimer = clone(TriggerCfgModel.TimerTrigger)

			tmActiveCheckTimer.Duration = 2000 + warningDelayTime
			tmActiveCheckTimer.ID = self:getNewTriggerId()
			tmActiveCheckTimer.Count = 1
			tmtriggerList[#tmtriggerList + 1] = tmActiveCheckTimer
			local tmActiveCheckEvent = clone(EventCfgModel.TriggerEventActivate)
			tmActiveCheckEvent.TargetID = brushCheckerIDList[i + 1]
			tmActiveCheckTimer.Events[#tmActiveCheckTimer.Events + 1] = tmActiveCheckEvent
			local tmActiveNextTimerEvent = clone(EventCfgModel.TriggerEventActivate)
			tmActiveNextTimerEvent.TargetID = tmActiveCheckTimer.ID
			tmBrushTimer.Events[#tmBrushTimer.Events + 1] = tmActiveNextTimerEvent
		end	
		if i == #brushTimerList then
			local tmActiveWinTimer = clone(TriggerCfgModel.TimerTrigger)
			-- local delaytime = cfg.monsterWellen[i][5] or 0
			tmActiveWinTimer.Duration = 2000 + warningDelayTime
			tmActiveWinTimer.ID = self:getNewTriggerId()
			tmActiveWinTimer.Count = 1
			tmtriggerList[#tmtriggerList + 1] = tmActiveWinTimer
			local tmActiveWinTimerEvent = clone(EventCfgModel.TriggerEventActivate)
			tmActiveWinTimerEvent.TargetID = tmWinTrigger.ID
			tmActiveWinTimer.Events[#tmActiveWinTimer.Events + 1] = tmActiveWinTimerEvent
			local tmActiveWinEvent = clone(EventCfgModel.TriggerEventActivate)
			tmActiveWinEvent.TargetID = tmActiveWinTimer.ID
			tmBrushTimer.Events[#tmBrushTimer.Events + 1] = tmActiveWinEvent
		end
	end
	local jsonData = {}
	jsonData["visualNode"] = airWall
	jsonData["triggers"] = {}
	for i,v in ipairs(tmtriggerList) do
		jsonData["triggers"][#jsonData["triggers"] + 1] = v
	end
	return jsonData
end

function ExEventTrigger:makeTowerDefenceModel(cfg)
	local tmtriggerList = {}
	--空气墙部分
	local airWall = {}
	local wallidA = self:getNewTriggerId()
	local wallidB = self:getNewTriggerId()
	local leftWall = clone(AirPointModel)
	local rightWall = clone(AirPointModel)
	leftWall.Active =true
	rightWall.Active = true
	leftWall.ID = wallidA
	rightWall.ID = wallidB
	leftWall.Position.X = cfg.LengthN[1]
	rightWall.Position.X = cfg.LengthN[2]
	airWall[#airWall + 1] = leftWall
	airWall[#airWall + 1] = rightWall

	local tmBaseAreaTrigger = clone(TriggerCfgModel.RegionTrigger)
	tmBaseAreaTrigger.AllEnemy = true
	tmBaseAreaTrigger.ID = self:getNewTriggerId()
	tmBaseAreaTrigger.Active = true
	tmBaseAreaTrigger.Position.X = cfg.deadZoom[1]
	tmBaseAreaTrigger.Position.Y = cfg.deadZoom[2]
	tmBaseAreaTrigger.Size.W = cfg.deadZoom[3]
	tmBaseAreaTrigger.Size.H = cfg.deadZoom[4]
	--扣分事件
	local tmPenaltyEvent = clone(EventCfgModel.TriggerEventPenalty)
	tmBaseAreaTrigger.Events[#tmBaseAreaTrigger.Events + 1] = tmPenaltyEvent

	local tmActiveAreaEvent = clone(EventCfgModel.TriggerEventActivate)
	tmActiveAreaEvent.TargetID = tmBaseAreaTrigger.ID
	tmBaseAreaTrigger.Events[#tmBaseAreaTrigger.Events + 1] = tmActiveAreaEvent
	tmtriggerList[#tmtriggerList + 1] = tmBaseAreaTrigger

	--刷怪
	local brushCheckerIDList = {}
	local brushTimerList = {}
	for k,v in ipairs(cfg.monsterWellen) do
		local tmBrushTimer = clone(TriggerCfgModel.TimerTrigger)
		tmBrushTimer.Duration = v[5] or 0
		tmBrushTimer.Count = 1
		tmBrushTimer.ID = self:getNewTriggerId()
		tmtriggerList[#tmtriggerList + 1] = tmBrushTimer
		brushTimerList[#brushTimerList + 1] = tmBrushTimer
		local tmBrushEvent = clone(EventCfgModel.TriggerEventSummon)
		tmBrushEvent.Duration = v[3]
		tmBrushEvent.Count = v[1]
		tmBrushEvent.SummonType = SummonTypeEnum[2]
		if v[4] ~= 0 then
			tmBrushEvent.TargetID = v[4]
			tmBrushEvent.NearbyHero = 0
		else
			tmBrushEvent.TargetID = 0
			tmBrushEvent.NearbyHero = 1
		end
		tmBrushTimer.Events[#tmBrushTimer.Events + 1] = tmBrushEvent

		--刷怪条件检测
		local tmBrushCheck = clone(TriggerCfgModel.AliveCounterTrigger)
		tmBrushCheck.CompareType = "<="
		tmBrushCheck.Count = v[2]
		tmBrushCheck.CheckType = 2
		tmBrushCheck.Active = (k == 1)
		tmBrushCheck.Duration = 0
		tmBrushCheck.ID = self:getNewTriggerId()
		tmtriggerList[#tmtriggerList + 1] = tmBrushCheck
		brushCheckerIDList[#brushCheckerIDList + 1] = tmBrushCheck.ID
		
		local tmActiveBrushTimerEvent = clone(EventCfgModel.TriggerEventActivate)
		tmActiveBrushTimerEvent.TargetID = tmBrushTimer.ID
		tmBrushCheck.Events[#tmBrushCheck.Events + 1] = tmActiveBrushTimerEvent
		--怪物预警
		if v[5] and v[5] > 0 then
			local tmMonsterWarningEvent = clone(EventCfgModel.TriggerEventMonsterWarning)
			tmMonsterWarningEvent.Duration = v[5]
			tmBrushCheck.Events[#tmBrushCheck.Events + 1] = tmMonsterWarningEvent
		end
	end

	for i = 1,#brushTimerList do
		local tmBrushTimer = brushTimerList[i]
    	local warningDelayTime = self:getMonsterWarningDelay(cfg.monsterWellen[i][1])
		if i ~= #brushTimerList then
			local tmActiveCheckTimer = clone(TriggerCfgModel.TimerTrigger)
			tmActiveCheckTimer.Duration = 2000
			tmActiveCheckTimer.ID = self:getNewTriggerId()
			tmActiveCheckTimer.Count = 1
			tmtriggerList[#tmtriggerList + 1] = tmActiveCheckTimer
			local tmActiveCheckEvent = clone(EventCfgModel.TriggerEventActivate)
			tmActiveCheckEvent.TargetID = brushCheckerIDList[i + 1]
			tmActiveCheckTimer.Events[#tmActiveCheckTimer.Events + 1] = tmActiveCheckEvent
			local tmActiveNextTimerEvent = clone(EventCfgModel.TriggerEventActivate)
			tmActiveNextTimerEvent.TargetID = tmActiveCheckTimer.ID
			tmBrushTimer.Events[#tmBrushTimer.Events + 1] = tmActiveNextTimerEvent
		end	
		if i == #brushTimerList then
			local tmActiveWinTrigger = clone(TriggerCfgModel.AliveCounterTrigger)
			tmActiveWinTrigger.Duration = 2000 + warningDelayTime
			tmActiveWinTrigger.CompareType = "<="
			tmActiveWinTrigger.Count = 0
			tmActiveWinTrigger.CheckType = 2
			tmActiveWinTrigger.Active = false
			tmActiveWinTrigger.ID = self:getNewTriggerId()
			tmtriggerList[#tmtriggerList + 1] = tmActiveWinTrigger
			local tmWinEvent = clone(EventCfgModel.TriggerEventWin)
			tmActiveWinTrigger.Events[#tmBrushTimer.Events + 1] = tmWinEvent
			local tmActiveWinCheckEvent = clone(EventCfgModel.TriggerEventActivate)
			tmActiveWinCheckEvent.TargetID = tmActiveWinTrigger.ID
			tmBrushTimer.Events[#tmBrushTimer.Events + 1] = tmActiveWinCheckEvent

		end
	end
	local jsonData = {}
	jsonData["visualNode"] = airWall
	jsonData["triggers"] = {}
	for i,v in ipairs(tmtriggerList) do
		jsonData["triggers"][#jsonData["triggers"] + 1] = v
	end
	return jsonData
end

return ExEventTrigger
