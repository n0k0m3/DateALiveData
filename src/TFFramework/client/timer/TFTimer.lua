--[[--
	定时器:

	--By: yun.bo
	--2013/7/8
]]
local TFFunction 			= TFFunction
local unpack 				= unpack

local TFTimer = class('TFTimer')

--[[--
	nType          			类型方便删除
	nTimerId       			定时器ID
	nDelay         			定时器触发的事件间隔
	nCurrentCount  			当前触发次数
	nRepeatCount   			总触发次数, -1表示无限制
	nExecuteTime    		当前执行的时间缀
	bIsStop        			是否被停止
	timerCompleteFunc	 	定时器完成回调函数
	timerFunc     			定时器每执行一次回调函数
]]
function TFTimer:ctor(tProperties)
	self.nType          		= tProperties.nType          			or 0
	self.nTimerId       		= tProperties.nTimerId 					or 0
	self.nLastCallTime 			= nil
	self.nDelay         		= tProperties.nDelay 					or 0
	self.nCurrentCount  		= tProperties.nCurrentCount  			or 1
	self.nRepeatCount   		= tProperties.nRepeatCount				or -1
	self.nExecuteTime    		= tProperties.nExecuteTime    			or 0
	self.bIsStop        		= tProperties.bIsStop        			or false
	self.timerCompleteFunc	 	= tProperties.timerCompleteFunc 		and SafeHandle(tProperties.timerCompleteFunc)
	self.timerFunc     			= tProperties.timerFunc 				and SafeHandle(tProperties.timerFunc)
	self.nLastExcuteTime         = tProperties.nLastExcuteTime 			or 0
	self.tParam 				= {}
end

--[[--
	执行定时器，返回false表示可以移除

]]
function TFTimer:execute()
	self.nExecuteTime = 0
	if self.bIsStop then
		return true
	end
	local nNowTime = TFTimeUtils:clock() 
	local runTime = nNowTime
	self.nLastCallTime = self.nLastCallTime or nNowTime
	local tParam = self.tParam
	tParam[#tParam] = nNowTime - self.nLastCallTime
	self.nLastCallTime = nNowTime
	local ret = true
	if self.nRepeatCount < 0 or self.nCurrentCount < self.nRepeatCount then
		if self.timerFunc then 
			ret = self.timerFunc(tParam)
		end
		if DEBUG and DEBUG > 0 then 
			runTime = TFTimeUtils:clock()
		end
	else
		TFFunction.call(self.timerFunc, tParam)
		TFFunction.call(self.timerCompleteFunc, tParam)
		self.bIsStop = true
		if DEBUG and DEBUG > 0 then 
			runTime = TFTimeUtils:clock()
		end
		self.nLastExcuteTime = runTime - nNowTime
		return false
	end
	self.nCurrentCount = self.nCurrentCount + 1
	self.nLastExcuteTime = runTime - nNowTime
	return ret
end

function TFTimer:start()
	self.bIsStop = false
end

function TFTimer:stop()
	self.bIsStop = true
end

function TFTimer:reset()
	self.nCurrentCount = 1
	self.nExecuteTime = 0
	self.nLastExcuteTime = 0
	self.nLastCallTime = nil
	self:start()
end

function TFTimer:dispose()
	self.timerCompleteFunc 	= nil
	self.timerFunc     		= nil
end

return TFTimer