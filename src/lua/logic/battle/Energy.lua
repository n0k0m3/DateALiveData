local enum     = import(".enum")
local eBFState = enum.eBFState
local eState   = enum.eState
local eAttrType= enum.eAttrType
local eBFSkillEvent = enum.eBFSkillEvent
local eSkillType  = enum.eSkillType
local Energy = class("Energy")

local eConsumeType = 
{
	CAST_SKILL            = 1 , -- 1定值时，任意技能，会激活buff
	HURT                  = 2 , -- 2受击消耗
    NO_HITED              = 3 , -- 3超过x秒未命中敌人时自动消耗
    NO_HURT_AND_NO_ATTACT = 4 , -- 4未受击、攻击X秒自动消耗
}

local eGetType =
{
	HURT = 1 , --1受到伤害
    AUTO = 2 , --2非攻击、闪避动作时，自动恢复
    AUTO_EX = 3 , --3无条件自动恢复，自动恢复
}

function Energy:ctor(data,hero) 
	self.data = data
	self.hero = hero	
	self.nTime = 0  --获取计时器

	self.nConsumeTime = 0 --消耗计时器

	self.bAutoFlag = false
end

function Energy:update(time) 
	local getType = self.data.getType
	local getPrams= self.data.getPrams
	if getType == eGetType.HURT  then
		self.nTime = self.nTime + time
	elseif getType == eGetType.AUTO  then 
		if self.hero:getState() ~= eState.ST_SKILL then
			self.nTime = self.nTime + time
			if self.nTime >= getPrams[1] then
				self.nTime = 0 
				self.hero:changeValue(eAttrType.ATTR_NOW_ENERGY,getPrams[2])
			end
		else
			self.nTime = 0 
		end
	elseif getType == eGetType.AUTO_EX  then --无条自动恢复
			self.nTime = self.nTime + time
			if self.nTime >= getPrams[1] then
				self.nTime = 0 
				self.hero:changeValue(eAttrType.ATTR_NOW_ENERGY,getPrams[2])
			end
	end


	--消耗处理
	local consumeType = self.data.consumeType
	local consumePrams =  self.data.consumePrams
	if consumeType == eConsumeType.HURT then
	self.nConsumeTime = self.nConsumeTime  + time
	elseif consumeType == eConsumeType.NO_HITED  then             -- 3超过x秒未命中敌人时自动消耗
    	self.nConsumeTime = self.nConsumeTime  + time
    	if not self.bAutoFlag then
    		 if self.nConsumeTime >= consumePrams[1] then
    			self.nConsumeTime = 0
    			self.bAutoFlag = true
    		end
    	else
    		if self.nConsumeTime >= consumePrams[2] then
    			self.nConsumeTime = 0
    			self.hero:changeValue(eAttrType.ATTR_NOW_ENERGY,-consumePrams[3])
    		end
    		if self.hero:getValue(eAttrType.ATTR_NOW_ENERGY) <= 0 then
    			self.nConsumeTime = 0
    			self.bAutoFlag = false
    		end
    	end


    elseif consumeType == eConsumeType.NO_HURT_AND_NO_ATTACT then -- 4未受击、攻击X秒自动消耗
		self.nConsumeTime = self.nConsumeTime  + time
		if not self.bAutoFlag then
    		 if self.nConsumeTime >= consumePrams[1] then
    			self.nConsumeTime = 0
    			self.bAutoFlag = true
    		end
    	else
    		if self.nConsumeTime >= consumePrams[2] then
    			self.nConsumeTime = 0
    			self.hero:changeValue(eAttrType.ATTR_NOW_ENERGY,-consumePrams[3])
    		end
    		if self.hero:getValue(eAttrType.ATTR_NOW_ENERGY) <= 0 then
    			self.nConsumeTime = 0
    			self.bAutoFlag = false
    		end
    	end
	end
end

function Energy:doTriggerBuff()
	local triggerBuffs = self.data.triggerBuff
	for i,triggerBuff in ipairs(triggerBuffs) do
		self.hero:onSkillTrigger(eBFSkillEvent.SE_HURT,triggerBuff,self.hero)
	end
end

--事件
function Energy:onEvent(eventType) 	
		local consumeType = self.data.consumeType
		local consumePrams= self.data.consumePrams
		local getType = self.data.getType
		local getPrams= self.data.getPrams
		local triggerBuff = self.data.triggerBuff
		if eventType == eBFState.E_HITED then --命中
			if consumeType == eConsumeType.NO_HITED then
				self.bAutoFlag = false
				self.nConsumeTime =  0
			elseif consumeType == eConsumeType.NO_HURT_AND_NO_ATTACT then
				self.bAutoFlag = false
				self.nConsumeTime =  0
			end
		elseif eventType == eBFState.E_REV_HIT then --受击
			if getType == eGetType.HURT  then
				if self.nTime >= getPrams[1] then
					self.nTime = 0 
					self.hero:changeValue(eAttrType.ATTR_NOW_ENERGY,getPrams[2])
				end
			end
			--消耗
			if consumeType == eConsumeType.HURT then
				if self.nConsumeTime >= consumePrams[1] then
					self.hero:changeValue(eAttrType.ATTR_NOW_ENERGY,-consumePrams[2])
					self.nConsumeTime = 0
					self:doTriggerBuff()
				end
			end
		-- elseif eventType == eBFState.E_ACTION  then 
		-- 	--消耗
		-- 	if consumeType == eConsumeType.CAST_SKILL then
		-- 		local value  = self.hero:getValue(eAttrType.ATTR_NOW_ENERGY) 
		-- 		local maxValue  = self.hero:getValue(eAttrType.ATTR_MAX_ENERGY) 
		-- 		if value >= maxValue*consumePrams[1]*0.0001 then
		-- 			self.hero:changeValue(eAttrType.ATTR_NOW_ENERGY, -maxValue*consumePrams[2]*0.0001)
		-- 			if triggerBuff and triggerBuff > 0 then
		-- 				--TODO 触发buffer
		-- 				self.hero:onSkillTrigger(eBFSkillEvent.SE_HURT,triggerBuff,self.hero)
		-- 			end
		-- 		end
		-- 	end
		elseif eventType == eBFState.E_ATTACK then 	
			--消耗
			if consumeType == eConsumeType.CAST_SKILL then
				local skillType = self.hero:getSkillType()
				if skillType == eSkillType.Skill_1 
					or skillType == eSkillType.Skill_2 
					or skillType == eSkillType.CRI then
					local value  = self.hero:getValue(eAttrType.ATTR_NOW_ENERGY) 
					local maxValue  = self.hero:getValue(eAttrType.ATTR_MAX_ENERGY) 
					if value >= maxValue*consumePrams[1]*0.0001 then
						self.hero:changeValue(eAttrType.ATTR_NOW_ENERGY, -maxValue*consumePrams[2]*0.0001)
						self:doTriggerBuff()
					end
				end
			elseif consumeType == eConsumeType.NO_HURT_AND_NO_ATTACT then
				self.bAutoFlag    = false
				self.nConsumeTime =  0
			end

		end

end

function Energy:energyExchange(value)
	if value >= 0 then
		return
	end
	local energyExchange = self.data.energyExchange or {}
	local rate = energyExchange[1]
	if rate then
		self.hero:changeValue(energyExchange[2],math.abs(value) * rate * 0.0001)
	end
end

return Energy
