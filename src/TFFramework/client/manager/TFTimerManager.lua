--[[--
	定时器管理器:

	--By: yun.bo
	--2013/7/8
]]
local TFFunction 			= TFFunction

local TFBaseManager 		= require('TFFramework.client.manager.TFBaseManager')
local TFTimer 				= require('TFFramework.client.timer.TFTimer')
local TFTimerQueue 			= require('TFFramework.client.timer.TFTimerQueue')

local TFTimerManager 		= class('TFTimerManager', TFBaseManager)
local TFTimerManagerModel 	= {addCache = {}, errorTimerList = {}}
TFTimerManager.model = TFTimerManagerModel


function TFTimerManagerModel:reset()
	TFTimerManagerModel.nTimerCount 	= 0
	TFTimerManagerModel.tTimers 		= {}
	TFTimerManagerModel.tTimerQueue 	= {} -- TFTimerQueue:new()
	TFTimerManagerModel.tTimerQueueBuf 	= {} -- TFTimerQueue:new()

	TFTimerManagerModel.TimerCount      = 0
	TFTimerManagerModel.TimerLastRunTime      = 0

	TFTimerManagerModel.beforTimerCallBackFunc = nil
	TFTimerManagerModel.errorTimerList = {}
end

function TFTimerManager:ctor()
	self.model:reset()
end

function TFTimerManager:registerBeforTimerCallbackFunc(btFunc)
	TFTimerManagerModel.beforTimerCallBackFunc = btFunc
end

function TFTimerManager:unRegisterBeforTimerCallbackFunc()
	TFTimerManagerModel.beforTimerCallBackFunc = nil
end

function TFTimerManager:getTimerCount()
	return TFTimerManagerModel.TimerCount
end

function TFTimerManager:getTimerRunTime()
	return TFTimerManagerModel.TimerLastRunTime
end

function TFTimerManager:getTimers()
	return TFTimerManagerModel.tTimers
end
		
function TFTimerManager:update(nElapse)
	for id, tTimer in pairs(TFTimerManagerModel.addCache) do
		TFTimerManagerModel.tTimers[id] = tTimer
	end
	TFTimerManagerModel.addCache = {}
	TFTimerManagerModel.TimerCount = 0
	TFTimerManagerModel.TimerLastRunTime = 0

	for _,timerId in pairs(TFTimerManagerModel.errorTimerList) do
		TFTimerManagerModel.tTimers[timerId] = nil
	end
	TFTimerManagerModel.errorTimerList = {}

    for id, tTimer in pairs(TFTimerManagerModel.tTimers) do     	
        if tTimer then
			if not tTimer.bIsStop then
				tTimer.nExecuteTime = tTimer.nExecuteTime + nElapse * 1000
				if tTimer.nExecuteTime >= tTimer.nDelay then
					--TFFunction.call(TFTimerManagerModel.beforTimerCallBackFunc)
					if tTimer:execute() == false then
						table.insert(TFTimerManagerModel.errorTimerList, id)
					end
					TFTimerManagerModel.TimerLastRunTime = TFTimerManagerModel.TimerLastRunTime + tTimer.nLastExcuteTime
				end
			end

			TFTimerManagerModel.TimerCount = TFTimerManagerModel.TimerCount + 1
		end
    end

--[[
	local tTimerQueue 		= TFTimerManagerModel.tTimerQueue
	local tTimerQueueBuf 	= TFTimerManagerModel.tTimerQueueBuf

	local tTimer = tTimerQueue:popFront()
	local bIsUpdate = false
	while tTimer do
		if tTimer then
			if not tTimer.bIsStop and TFTimerManagerModel.tTimers[tTimer.nTimerId] then
				tTimer.nExecuteTime = tTimer.nExecuteTime + nElapse * 1000
				if tTimer.nExecuteTime >= tTimer.nDelay then
					--TFFunction.call(TFTimerManagerModel.beforTimerCallBackFunc)
					tTimer:execute()
				end
			end
			if TFTimerManagerModel.tTimers[tTimer.nTimerId] then
				tTimerQueueBuf:push(tTimer)
				bIsUpdate = true
			end
		end
		tTimer = tTimerQueue:popFront()
	end
	if bIsUpdate then
		TFTimerManagerModel.tTimerQueue = tTimerQueueBuf
		TFTimerManagerModel.tTimerQueueBuf = tTimerQueue
    	tTimerQueue:clear()
	end
    ]]
end

function TFTimerManager:insertQueue(tTimer)
	--[[local tTimerQueue = TFTimerManagerModel.tTimerQueue
	local nLen = tTimerQueue:length()
	if nLen == 0 then tTimerQueue:push(tTimer) return end
	for i = 1, nLen do
		if tTimerQueue:getTimerAt(i).nExecuteTime >= tTimer.nExecuteTime then
			tTimerQueue:insertAt(i, tTimer)
			return
		end
	end]]
end

--[[--
	添加定时器
	@param nDelay:定的时间间隔( 毫秒)
	@param nRepeatCount:执行的次数, -1表示无限制
	@param timerCompleteFunc:定时器完成执行的回调函数
	@param timerFunc:定时器每执行一次所执行的回调函数
	@return 定时器的id
]]	
function TFTimerManager:addTimer(nDelay, nRepeatCount, timerCompleteFunc, timerFunc, ...)
	nDelay = nDelay or 0
	nRepeatCount = nRepeatCount or -1
	TFTimerManagerModel.nTimerCount = TFTimerManagerModel.nTimerCount + 1
	local properties = {
		nDelay 					= nDelay,
		nRepeatCount 			= nRepeatCount,
		nTimerId 				= TFTimerManagerModel.nTimerCount,          	 	
		timerCompleteFunc 		= timerCompleteFunc,
		timerFunc     			= timerFunc
	}
	local tTimer = TFTimer:new(properties)
	tTimer.tParam = {...}
	tTimer.tParam[#tTimer.tParam + 1] = 0
	
	if DEBUG then 
		tTimer.debuginfo = debug.traceback()
	end

	TFTimerManagerModel.addCache[tTimer.nTimerId] = tTimer
	return tTimer.nTimerId
end

--[[--
	移除指定定时器
	@param nTimerId:定时器id
	@return nil
]]	
function TFTimerManager:removeTimer(nTimerId)
	if not nTimerId then return end
	TFTimerManagerModel.addCache[nTimerId] = nil
	table.insert(TFTimerManagerModel.errorTimerList, nTimerId)

	-- if TFTimerManagerModel.tTimers[nTimerId] ~= nil then
	-- 	TFTimerManagerModel.tTimers[nTimerId] = nil
	-- end
end

--[[--
	开始指定定时器
	@param nTimerId:定时器id
	@return nil
]]	
function TFTimerManager:startTimer(nTimerId)
	local tTimer = TFTimerManagerModel.tTimers[nTimerId] or TFTimerManagerModel.addCache[nTimerId]
	if not tTimer then return end
	tTimer:start()
end

--[[--
	停止指定定时器
	@param nTimerId:定时器id
	@return nil
]]	
function TFTimerManager:stopTimer(nTimerId)
	local tTimer = TFTimerManagerModel.tTimers[nTimerId] or TFTimerManagerModel.addCache[nTimerId]
	if not tTimer then return end
	tTimer:stop()
end

--[[--
	重置指定定时器
	@param nTimerId:定时器id
	@return nil
]]	
function TFTimerManager:resetTimer(nTimerId)
	local tTimer = TFTimerManagerModel.tTimers[nTimerId] or TFTimerManagerModel.addCache[nTimerId]
	if not tTimer then return end
	tTimer:reset()
end

--[[--
	获取指定定时器当前执行的次数
	@param nTimerId:定时器id
	@return 定时器当前执行的次数
]]	
function TFTimerManager:getTimerCurrCount(nTimerId)
	local tTimer = TFTimerManagerModel.tTimers[nTimerId] or TFTimerManagerModel.addCache[nTimerId]
	if tTimer then
		return tTimer.nCurrentCount
	end
	return -1
end

return TFTimerManager:new()