--[[
	时钟倒计时UI
]]--

local ClockCounter = class("ClockCounter", BaseLayer)

function ClockCounter:ctor(initialTime,internal, cnt, compleleFunc, countFunc)
	self.super.ctor(self);

	self.initialTime = initialTime
	self.internal = internal
	self.cnt = cnt
	self.compleleFunc = compleleFunc
	self.countFunc = countFunc

	self.time = self.initialTime - ServerDataMgr:getServerTime()
	
	self:init("lua.uiconfig.activity.clockCounter")	
end


function ClockCounter:initUI(ui)
	self.super.initUI(self, ui)

	self.timeText = ui:getChildByName("time")
	self.timeText:setText(Utils:getTimeCountDownString(self.initialTime, 2))
end

function ClockCounter:startTimer()
	local function __countUpdate()
		if not self.countDownTimer_ then
			return 
		end
		self.time = self.time - 1
		if self.time < 10 and self.time >= 0 then
			self:shakeClock()
		end
		
		self.timeText:setText(Utils:getTimeCountDownString(self.initialTime, 2))
		if self.countFunc then
			self.countFunc(self.time)		
		end		
	end

	local function __completeUpdate()
		if self.countDownTimer_ == nil then
			return
		end
		self:stopTimer()
		if self.compleleFunc then
			self.compleleFunc()	
		end
	end

	if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(self.internal, self.cnt, __completeUpdate, __countUpdate)
    end
end

function ClockCounter:shakeClock()
	self.timeText:setColor(ccRED)
	local angle1, angle2,angle3 = 10,5,3
	self:runAction(Sequence:create({CCRotateTo:create(0.05, angle1), CCRotateTo:create(0.05, -angle1), 
									CCRotateTo:create(0.05, angle2), CCRotateTo:create(0.05, -angle2),
									CCRotateTo:create(0.05, angle3), CCRotateTo:create(0.05, -angle3), 
									CCRotateTo:create(0.02, 0)}))
end

function ClockCounter:stopTimer()
	self:removeCountDownTimer()
end

function ClockCounter:clear()
	AlertManager:closeLayer(self)
end

function ClockCounter:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
		self.countDownTimer_ = nil
    end
end

function ClockCounter:removeUI()
	self.super.removeUI(self)
	self:removeCountDownTimer()
end

return ClockCounter

--endregion
