--[[模拟召唤数据管理]]
local BaseDataMgr = import(".BaseDataMgr")
local SimulationSummonDataMgr = class("SimulationSummonDataMgr", BaseDataMgr)

--[[初始化]]
function SimulationSummonDataMgr:init()
	--[[响应模拟召唤]]
	TFDirector:addProto(s2c.SUMMON_RES_SIMULATE_SUMMON_INFO, self, self.onRecvSimulationSummonInfo)
	TFDirector:addProto(s2c.SUMMON_RES_SIMULATE_SUMMON, self, self.onRecvSimulationSummon)
	TFDirector:addProto(s2c.SUMMON_RES_SIMULATE_SUMMON_REPLACE, self, self.onRecvSimulationSummonReplace)
	TFDirector:addProto(s2c.SUMMON_RES_SIMULATE_SUMMON_EXCHANGE, self, self.onRecvSimulationSummonExchange)
	
	--EventMgr:addEventListener(self, EV_SUMMON_RES_SIMULATE_SUMMON_INFO, handler(self.onRecvSimulationSummonReplace, self))
	--所有卡池的数据
	self.simulationSummonInfos_ = {}	
	self.writeOpen = false			
	
end

--[[检查指定的卡池是否开启]]
function SimulationSummonDataMgr:checkIsOpenById(cid)
	return self.simulationSummonInfos_[cid] ~= nil
end

--[[获取指定卡池]]
function SimulationSummonDataMgr:getSimulationSummon(cid)
	--dump(self.simulationSummonInfos_)
	return self.simulationSummonInfos_[cid]
end

--[[获取指定卡池的指定order]]
function SimulationSummonDataMgr:getRecord(cid, order)
	local simulationSummon = self:getSimulationSummon(cid)
	if nil ~= simulationSummon then
		for i, record in ipairs(simulationSummon.records) do
			print("record.order = " .. record.order)
			if record.order == order then
				return record
			end
		end
	else
		print("simulationSummon is nil")
	end
	
	return nil
end


--[[接收模拟召唤的所有数据]]
function SimulationSummonDataMgr:onRecvSimulationSummonInfo(event)
	--dump(event)
	print("----------------------------------------------------onRecvSimulationSummonInfo")
	dump(event.data)
	self.simulationSummonInfos_ = {}
	if nil ~= event.data.simulateSummons then
		for i, v in ipairs(event.data.simulateSummons) do
			self.simulationSummonInfos_[v.cid] = v
		end
	else
		--self.simulationSummonInfos_ = {}
	end	
	
	--self.lastResult_ = event.data.lastResult
	
	--事件抛出
	EventMgr:dispatchEvent(EV_SUMMON_RES_SIMULATE_SUMMON_INFO, event.data)
	if self.writeOpen then
		self.writeOpen = false
		
		--if event.data.lastCid ~= nil and event.data.lastResult ~= nil then
		--	showMessageBox("上一次招募未完成", EC_MessageBoxType.ok, function()
		--		AlertManager:close()
		--		Utils:openView("summon.SimulationSummonView",event.data)
		--		Utils:openView("summon.SimulationSummonResultView",event.data.lastCid, event.data.lastResult)
		--	end)
		--	
		--else	
			--TODO暂时屏蔽模拟召唤  2020 11 23
			Utils:showTips(TextDataMgr:getText(2100109))
			--Utils:openView("summon.SimulationSummonView",event.data)
		--end
	end
end

--[[接收模拟召唤结果]]
function SimulationSummonDataMgr:onRecvSimulationSummon(event)
	dump(event)
	self.simulationSummonInfos_[event.data.simulateSummon.cid] = event.data.simulateSummon
	
	--事件抛出
	EventMgr:dispatchEvent(EV_SUMMON_RES_SIMULATE_SUMMON, event.data)
end

--[[接收是否保留操作后]]
function SimulationSummonDataMgr:onRecvSimulationSummonReplace(event)
	dump(event)
	self.simulationSummonInfos_[event.data.simulateSummon.cid] = event.data.simulateSummon
	
	--事件抛出
	EventMgr:dispatchEvent(EV_SUMMON_RES_SIMULATE_SUMMON_REPLACE, event.data)
end

--[[接收兑换结果]]
function SimulationSummonDataMgr:onRecvSimulationSummonExchange(event)
	dump(event)
	self.simulationSummonInfos_[event.data.simulateSummon.cid] = event.data.simulateSummon
	--事件抛出
	EventMgr:dispatchEvent(EV_SUMMON_RES_SIMULATE_SUMMON_EXCHANGE, event.data)
end


--[[向服务器请求模拟召唤数据]]
function SimulationSummonDataMgr:reqSimulateSummonInfo()
	print("-------------------------------------reqSimulateSummonInfo")
	self.writeOpen = true
	TFDirector:send(c2s.SUMMON_REQ_SIMULATE_SUMMON_INFO, {})
end

--[[向服务器请求一次模拟召唤]]
function SimulationSummonDataMgr:reqSimulateSummon(cid)
	--self.simulationSummonInfos_ = {}	
	TFDirector:send(c2s.SUMMON_REQ_SIMULATE_SUMMON, {cid})
end

--[[向服务器请求是否保留]]
function SimulationSummonDataMgr:reqSimulateSummonReplace(isReplace, order)
	--print("reqSimulateSummonReplace:" .. tostring(isReplace).. order)
	TFDirector:send(c2s.SUMMON_REQ_SIMULATE_SUMMON_REPLACE, {isReplace, order})
end

--[[向服务器请求兑换]]
function SimulationSummonDataMgr:reqSimulateSummonExchange(cid, order)
	print("-----------------------reqSimulateSummonExchange cid=" .. cid .. "	 order=" .. order)
	TFDirector:send(c2s.SUMMON_REQ_SIMULATE_SUMMON_EXCHANGE, {cid, order})
end


--[[重置已经拥有的hero]]

function SimulationSummonDataMgr:resetAlreadyHaveHero()
    self.haveHero_ = {}
    local heros = HeroDataMgr:getHero()
    for k, v in pairs(heros) do
        if HeroDataMgr:getIsHave(k) then
            table.insert(self.haveHero_, k)
        end
    end
end

--[[是否已经拥有]]
function SimulationSummonDataMgr:isHaveHero(id)
    local index = table.indexOf(self.haveHero_, id)
    return index ~= -1
end


return SimulationSummonDataMgr:new()