
local enum = import(".enum")
local eEvent = enum.eEvent

local SkillEx = class("SkillEx")

function SkillEx:ctor(data,buffIds)
    self.data      = data
    self.nUseTimes = self.data.skillTimes
    self.nCDTime   = 0
    self.buffIds     = buffIds 
end

function SkillEx:getBuffId()
    return self.buffIds
end

function SkillEx:getIcon()
    return self.data.icon
end

function SkillEx:startCD()
    self.nCDTime = self.data.skillCd
end

--
function SkillEx:isEnabled()
    return self.nUseTimes > 0
end

function SkillEx:isCD()
    return self.nCDTime > 0
end

--技能CD时间
function SkillEx:getCDTime()
    return self.nCDTime
end


--当前使用次数
function SkillEx:getUseTimes()
    return self.nUseTimes
end

--最大使用次数
function SkillEx:getMaxUseTimes()
    return self.data.skillTimes
end
--使用技能
function SkillEx:doUse()
    if self:isEnabled() then
        if not self:isCD() then 
            self.nUseTimes = self.nUseTimes -1
            self:startCD()
        end
    end
end

function SkillEx:update(time)
    if self.nCDTime > 0 then 
        local t = self.nCDTime  - time
        self.nCDTime = math.max(t,0)
        local sTime  = math.ceil(self.nCDTime*0.001)
        if self.nSTime ~= sTime then 
            self:doRefresh()
        end
    end
end

--组件刷新处理
function SkillEx:doRefresh()
    EventMgr:dispatchEvent(eEvent.EVENT_SKILLEX_REFRESH,self)
end

return SkillEx
