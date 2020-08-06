--魔女时间
local enum = import(".enum")
local eWitchTimeContinuedType = enum.eWitchTimeContinuedType
local WitchTime = class("WitchTime")

function WitchTime:ctor(team , data)
    self.data = data
    self.team = team
    self.nDuration = self.data.continueData
    self.bActive = true
end

function WitchTime:getID()
	return self.data.id
end
--取值10000
function WitchTime:getTimeScale()
    return (1 - self.data.slowScale*0.0001)
end

function WitchTime:cancel(continueType)
	local _continueType = self.data.continueType 
	-- Box("cancelWitchTime"..tostring(continueType)..":"..tostring(_continueType))
	if _continueType == continueType then
		self.team:cancelWitchTime(self)
	end
end
function WitchTime:update(dt)
	   -- print(" continueType:" ,self.data.continueType, self.nDuration ,dt)
    if self.data.continueType == eWitchTimeContinuedType.FIEXED_TIME then  --0技能持续时间/1固定时间
    	self.nDuration = self.nDuration - dt

    	if self.nDuration <= 0 then  --时间到
    		self.team:cancelWitchTime(self)
    	end
    end
end

return WitchTime
