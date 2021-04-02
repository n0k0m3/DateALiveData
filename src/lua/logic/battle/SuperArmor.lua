local enum     = import(".enum")
local eBFState = enum.eBFState
local eState   = enum.eState
local eAttrType= enum.eAttrType
local eEvent   = enum.eEvent
local eBFSkillEvent = enum.eBFSkillEvent
local SuperArmor = class("SuperArmor")

--恢复时间
local RECOVER_TIME = 2000
local FlagType = 
{
	AUTO  = 1, --自动恢复
	BREAK = 2,
	BREAK_RECOVER = 3
}
function SuperArmor:ctor(hero) 
	self.hero = hero	
	self.nTime        = 0  --获取计时器
	self.nNotHurtTime = 0  --获取计时器
	self.nAutoFlag    = FlagType.AUTO
	local data        = self.hero:getData()
	local maxValue    = self.hero:getMaxHp()  --self.hero:getMaxResist()
	self.touchBuff    = data.touchBuff
	self.recoverBuff  = data.recoverBuff
	--霸体值恢复的最大值
	self.nMaxValue    = math.floor(data.stiffness * maxValue * 0.0001)
	self.hero:changeValue(eAttrType.ATTR_MAX_RST,self.nMaxValue) --最大值
	self.hero:changeValue(eAttrType.ATTR_NOW_RST,self.nMaxValue) --当前值
	--间隔恢复
	if #data.recover1 > 0 then 
		self.nNotHurtInterval = data.recover1[1]  --未未受击持续时间
		self.nInterval        = data.recover1[2]  --自动恢复时间间隔
		local percent         = data.recover1[3]  --恢复比例
		--间隔恢复值
		self.nRecoverValue = self.nMaxValue * percent * 0.0001
	end

	--击破持续时间
	self.nDuration     = data.recover2
	self.nRecoverValue = 0
end
--间隔恢复
function SuperArmor:autoRecover(time) 
	self.nNotHurtTime = self.nNotHurtTime  + time
	if self.nNotHurtTime > self.nNotHurtInterval then
		if self.hero:getResist() < self.nMaxValue then  --达到最大恢复值停止恢复
			if self.nTime >= self.nInterval then
				self.nTime = 0
				self.hero:changeValue(eAttrType.ATTR_NOW_RST,self.nRecoverValue)
				-- print("间隔恢复",self.nRecoverValue)
			end
		end
	end
end
--击破恢复
function SuperArmor:breakRecover() 
	if self.nTime > self.nDuration then
		self.nAutoFlag    = FlagType.BREAK_RECOVER
		self.nTime        = 0
		self.nNotHurtTime = 0
		-- self.hero:changeValue(eAttrType.ATTR_NOW_RST,self.nMaxValue)
		-- self:doTriggerRecoverBuff()
		-- print("切换为自动恢复",self.nMaxValue)
	end
end

function SuperArmor:update(time) 
	self.nTime = self.nTime + time
	if self.nAutoFlag == FlagType.AUTO then --自动恢复
		if self:isAutoRecover() then
			self:autoRecover(time)
		end
	elseif self.nAutoFlag == FlagType.BREAK then
		if self:isBreakRecover() then
			self:breakRecover()
		end
	elseif self.nAutoFlag == FlagType.BREAK_RECOVER then --2秒恢复满
		if self.nTime > RECOVER_TIME then 
			self.nTime  = 0
			self.nAutoFlag = FlagType.AUTO
			self.hero:changeValue(eAttrType.ATTR_NOW_RST,self.nMaxValue)
			self:doTriggerRecoverBuff()
			return 
		else
			local percent =  self.nTime / RECOVER_TIME * 10000 
			if percent ~= self.nRecoverValue then 
				self.nRecoverValue =  percent
				if self.hero:getActor() then
					self.hero:getActor():refresh()
				end
		        --UI Boss 血条更新
		        if self.hero:enableUpdateBossPanel() then
		            EventMgr:dispatchEvent(eEvent.EVENT_BOSS_CHANGE, self.hero)
				end
			end

		end
		
	end
end

function SuperArmor:getRecoverPercent()
	return self.nRecoverValue
end

function SuperArmor:isRecoverIng()
	return self.nAutoFlag == FlagType.BREAK_RECOVER 
end

--是否击破恢复
function SuperArmor:isBreakRecover()
	return self.nDuration >= 0
end
--是否自动恢复
function SuperArmor:isAutoRecover()
	return self.nInterval ~= nil
end

--事件
function SuperArmor:onEvent(eventType) 		
	if eventType == eBFState.E_REV_HIT then --受击
		self.nNotHurtTime = 0 --受击时间计数器清零
	end
end

function SuperArmor:onAttrChange(attrType)
	if attrType == eAttrType.ATTR_NOW_RST then
		if self:isBreakRecover() then
			if self.nAutoFlag == FlagType.AUTO then --自动恢复时被击破
				if self.hero:getResist() <= 0 then
					-- print("击破自动恢复")
					self.nAutoFlag    = FlagType.BREAK
					-- Box("xxxx")
					self.nTime        = 0
					--击破buff触发
					self:doTriggerBuff()
				end
			end
		end
	end
end


function SuperArmor:doTriggerBuff()
	if self.touchBuff then
		for i,triggerBuff in ipairs(self.touchBuff) do
			self.hero:onSkillTrigger(eBFSkillEvent.SE_HURT,triggerBuff,self.hero)
		end
	end
end
--击破霸体值恢复时 触发buffer
function SuperArmor:doTriggerRecoverBuff()
	if self.recoverBuff  then
		for i,triggerBuff in ipairs(self.recoverBuff) do
			self.hero:onSkillTrigger(eBFSkillEvent.SE_HURT,triggerBuff,self.hero)
		end
	end
end


return SuperArmor




