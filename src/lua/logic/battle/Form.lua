local Skill= import(".Skill")
local AIAgent= import(".AIAgent")
local Form = class("Form")

function Form:ctor(data,hero)
	self.hero      = hero
	self.data      = clone(data)
	self.skillList = {}
	self.aiAgent   = AIAgent:new(self.hero,self.data.AI)
	-- 创建技能
	self.data.skills = hero:combatCustomSkills(self.data.skills)
    for k, id in ipairs(self.data.skills) do
        local data =  BattleDataMgr:getSkillData(id,self.hero:getAngleDatas())
        if not data then --TODO 怪物技能不存在
        	Box("技能不存在:"..tostring(id))
        end
        local skill = Skill:new(data,self.hero)
        
        skill._form = self
        table.insert(self.skillList,skill)
    end
    --根据技能释放的优先级排序(level 越大再前)
    table.sort(self.skillList,function(a,b)
        return a:getLevel() > b:getLevel()
    end)
    self.bActive = true
    self.nDurationTime = -1
    self.nInterval = 0
end

function Form:getData()
	return self.data
end

function Form:getDataId()
	return self.data.id
end

function Form:getActionIndex()
	return self.data.actionIndex
end
--怪物变换形态时使用
function Form:setActionIndex(actionIndex)
	self.data.actionIndex = actionIndex
end

function Form:getSkillList()
	return self.skillList
end

function Form:doCD(time)
	for key , skill in ipairs(self.skillList) do
        skill:update(time)
    end
end

function Form:getCID()
	return self.data.id
end

function Form:getAI()
	return self.data.AI
end

function Form:reset()
	self.bActive = true
	self.nDurationTime  = self.data.durationTime or -1
	-- Box("self.nDurationTime:"..tostring(self.nDurationTime ).."   "..tostring(self.data.durationTime))
	self.nInterval = 0 
	return self.nTime
end

--检查技能试否是变身技能
function Form:isExchange(id)
	local triggerTrans = self.data.triggerTrans
	if triggerTrans and #triggerTrans > 0 then
		return triggerTrans[1] == id
	end
	return false
end


function Form:check(id)
	if 	self.bActive then
		local triggerTrans = self.data.triggerTrans
		if triggerTrans and #triggerTrans > 0 then
			local skillId =  triggerTrans[1]
			local trans   =  triggerTrans[2]
			if skillId == id then

				self:doTrans(trans)
			end
		end
	end
end

function Form:doTrans(trans)
	self.bActive = false
	self.hero:changeSkin(trans)
end

function Form:isContain(skill)
	for i , v in ipairs(self.skillList) do
		if v == skill then
			return true
		end
	end
end

function Form:update(time)
	-- print("time::::::::::::::::::::::",time ,self.nDurationTime)
	if not self.bActive then return end
	if self.nDurationTime > 0 then
		self.nDurationTime = self.nDurationTime - time
		if self.nDurationTime <= 0 then
			self:doTrans(self.data.reductionTrans)
			return
		end
	end
	local expend = self.data.expend
	if expend and  #expend > 3 then
		local interval = expend[1]  --间隔
		local attrType = expend[2]  --属性
		local consume  = expend[3]  --消耗(配置的是正值)
		local minValue = expend[4]  --最小值
		self.nInterval = self.nInterval + time
			-- print("time::::::::::::::::::::::",self.nInterval ,interval)
		if self.nInterval >= interval then
			self.nInterval = 0
			self.hero:changeValue(attrType,-consume)
			if self.hero:getValue(attrType) <= minValue then
				self:doTrans(self.data.reductionTrans)
			end
		end
	end
end

function Form:getExpendData()
	if not self.bActive then
		return nil
	end
	local expend = self.data.expend
	if expend and  #expend > 4 then
		return expend
	end
end

return Form




