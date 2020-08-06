local TeamWaitingTimer = class("TeamWaitingTimer",BaseLayer)

function TeamWaitingTimer:ctor(param)
	self.super.ctor(self)
	if param then
		self.maxtime = param.maxtime
		self.callback = param.callback
	end
    self:init("lua.uiconfig.teamFight.matchTimerView")
    self.time_val = 1
    self:refreshTime()
end

function TeamWaitingTimer:initUI(ui)
	self.super.initUI(self, ui)
    self.panel_root        = TFDirector:getChildByPath(ui, "Panel_root")
    self.timeLabel = self.panel_root:getChildByName("Label_time")
    self:runWaitTimer()
end

function TeamWaitingTimer:runWaitTimer()
	local actArr = {DelayTime:create(1),CallFunc:create(function()
		self.time_val = self.time_val + 1
		self:refreshTime()
	end)}
	self:runAction(RepeatForever:create(Sequence:create(actArr)))
end

function TeamWaitingTimer:refreshTime()
	self.timeLabel:setString(string.format("%ds",self.time_val))
	if self.maxtime then
		if self.time_val >= self.maxtime then
			self.callback()
		end
	end
end

function TeamWaitingTimer:onExit()
	self.super.onExit(self)
	self:stopAllActions()
end

return TeamWaitingTimer