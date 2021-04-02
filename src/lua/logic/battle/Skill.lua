local SkillEffect = import(".SkillEffect")
local AwakeMgr    = import(".AwakeMgr")
local selectTarget= import(".selectTarget")
local BattleUtils = import(".BattleUtils")
local BattleConfig= import(".BattleConfig")
local BattleMgr   = import(".BattleMgr")
local ActionMgr   = import(".ActionMgr")
local ResLoader   = import(".ResLoader")
local enum = import(".enum")
local eSkillType = enum.eSkillType
local eVKeyCode    = enum.eVKeyCode
local eStateEvent = enum.eStateEvent
local eArmtureEvent = enum.eArmtureEvent
local eEvent  = enum.eEvent
local eSelectType = enum.eSelectType
local eBFState    = enum.eBFState
local eDir        = enum.eDir
local eGuideAction = enum.eGuideAction
local eAState      = enum.eAState  
local eWitchTimeTriggerType = enum.eWitchTimeTriggerType
local eWitchTimeContinuedType = enum.eWitchTimeContinuedType
local eWithstandDir = enum.eWithstandDir
local eAttrType = enum.eAttrType
local eFlag     = enum.eFlag
local __print = print
-- local print = function( ... )
--     -- body
-- end

--位移方式
local eMoveType  = 
{
    Position = 0, --固定位置位移
    Free     = 1, --摇杆自由位移
    Target   = 2, --目标位移
    Target_Shadow   = 3, --目标影子位移
    Map_Center  = 4,  --地图中央位移
}



local Skill = class("Skill")

function Skill:ctor(data,hero)
    self.data = data
    -- self.data.costAnger = 0
    if not self.data.revealSkill or self.data.revealSkill == 0 then
        self.bVisiable =  true
    else
        self.bVisiable =  false
    end
    self.hero = hero
    self.actionData = nil
    self.eventData  = nil
    self.nCDTime    = self.data.openCd
    self.extraCdTime = 0  --临时cd上限使用
    self.bActive    = false
    self.nPercent   = 0  --0 表示冷却完成
    self.next       = false
    self.solecd = 0 --自定义cd上限
    self.fixedCd = false  --是否使用固定cd
--冷却缓存次数
    self.nCacheTimes = 0
    self.bCDing = false
    --有开场CD
    if self.nCDTime > 0 then
        self.nCacheTimes = 0
        self.bCDing = true
    else
        self.nCacheTimes = self.data.useTimes
    end
    --动作完成回调
    self.actionOverFunc = nil

    --动作是否可以移动
    self.bActionMove = false
    -- --TODO 消耗怒气 设置为0 
    -- self.data.costAnger = 0
    -- self.data.costEnergy= 0
    -- self.data.cd = 0
    --技能的蓄力值
 
    local gatherPower = self.data.gatherPower
    self.timeList = {} --蓄力每段的时间
    local time = 0 
    for i, actionID in ipairs(gatherPower) do
        local actionData = BattleDataMgr:getActionData(actionID,self.hero:getAngleDatas())
        time = time + actionData.loopTime
        table.insert(self.timeList,time)
    end
    --蓄力每段的时间转化为百分比
    for index, _time in ipairs(self.timeList) do
        self.timeList[index] = _time*100/time
    end

    --蓄力速度
    self.gatherVelocity = 0
    if time > 0 then
        self.gatherVelocity = 100/time
    end
    self.gatherTime  = 0
    self.gatherValue = 0 
    self.bGather    = false
end

--是否是蓄力技能
function Skill:isGatherSkill()
    return #self.timeList > 0
end

function Skill:eventGatherBarUpdate(state)
    if self.hero == battleController.getCaptain() then
        EventMgr:dispatchEvent(eEvent.EVENT_GATHER_BAR_UPDATE,state,self)
    end
end

function Skill:handleGather(time)
    if self.bGather then
        self.gatherTime  = self.gatherTime  + time
        self.gatherValue = self.gatherVelocity*self.gatherTime
        self.gatherValue = math.min(100,math.floor(self.gatherValue))
        -- print("time::::",time,self.gatherValue)
        self:eventGatherBarUpdate(2)
    end
end

function Skill:getGatherValue()
    return self.gatherValue
end

function Skill:setActionOverFunc(callFunc)
    self.actionOverFunc = callFunc
end


function Skill:getData()
    return self.data
end

function Skill:hasAnimation()
    return ResLoader.isValid(self.data.useWarn)
end

--当前技能是否可以显示
function Skill:isVisiable()
    return self.bVisiable
end
function Skill:setVisiable(visiable)
    self.bVisiable = visiable
    self:forceUpdate(true)
end
--切换角色重置技能显示
function Skill:reset()
    if not self.data.revealSkill or self.data.revealSkill == 0 then
        self:setVisiable(true)
    else
        self:setVisiable(false)
    end
end

function Skill:checkIncludeskill()
    local skills = self.data.includeskill
    for k,v in pairs(skills) do
        local skill  = self.hero:getSkillByCid(v)
        if skill:isVisiable() then
            skill:checkShiftSkill()
            break
        end
    end
end

--buff 检查切换
function Skill:checkShiftSkill()
    local id = self.data.shiftSkill 
    if id and id > 0 then 
        local skill  = self.hero:getSkillByCid(id)
        self:setVisiable(false)
        skill:setVisiable(true)
    end
    local otherSkills = self.data.othershiftSkill
    if table.count(otherSkills) > 0 then
        local skillId = 0
        local weight_ = {}
        for k,v in pairs(otherSkills) do
            table.insert(weight_,v)
        end
        local rMax = 0
        table.walk(weight_, function(v, k)
            rMax = rMax + v
        end)
        local rand = RandomGenerator.random(1, rMax)
        for k,v in pairs(otherSkills) do
            if rand <= v then
                id = tonumber(k)
                break
            end
            rand = rand - v
        end
        if id and id > 0  then
            local skill  = self.hero:getSkillByCid(id)
            self:setVisiable(false)
            skill:setVisiable(true)
        end
    end
end

function Skill:startCD()
    if self.data.id == 0 then
        return
    end
    self.nCacheTimes = self.nCacheTimes - 1
    self.nCacheTimes = math.max(self.nCacheTimes,0)
    --if self:isManual() then
        self:handlCD(0)
    --end
end

function Skill:startCDTime()
    if self.hero:isFlag(eFlag.SUPER_SKILL) then
        self.nCDTime = 0
    else
        self.nCDTime = self:getDataCD()
    end
end

function Skill:getDataCD()
    local cdRatio = self.hero:getValue(eAttrType.ATTR_CD_RATIO)*0.0001
    if self.solecd > 0 then
        if self.fixedCd then
            return self.solecd
        else
            return math.abs(self.solecd * (1 - cdRatio))
        end
    end
    return math.abs(self.data.cd * (1 - cdRatio))
end


function Skill:isManual(flag)
    if self.hero:isManual(flag) then
        return self._form == self.hero.curForm
    end
end
--处理冷却
function Skill:handlCD(time)
    if self.hero:checkSkill_CD(self) then
        if self.nCacheTimes < self.data.useTimes then
            if not self.bCDing then
                self.bCDing = true
                self:startCDTime()
            end
    --
            if self.nCDTime > 0 then
                self.nCDTime  = self.nCDTime - time
                self.nCDTime  = math.max(self.nCDTime,0)
                local percent = self:calcuCDPercent()
                self:setCDPercent(percent)
            end
            --cd完成一次
            if  self.nCDTime <= 0 then
                self.bCDing = false
                self.extraCdTime = 0
                self.nCacheTimes = self.nCacheTimes + 1
                if self:isManual(true) then
                    EventMgr:dispatchEvent(eEvent.EVENT_VKSTATE_CHANGE,self)
                end
            end
        end
    end
end

--减少CD时间
function Skill:reduceCDTime(time)
    if time < 0 then
        local orgCd = self:getDataCD()
        self.nCDTime  = self.nCDTime - time
        if math.abs(time) > orgCd then
            self.extraCdTime = math.abs(time)
            self.nCDTime = math.min(self.nCDTime,self.extraCdTime)
        else
            self.nCDTime = math.min(self.nCDTime,orgCd)
        end
        self.nCDTime  = math.max(self.nCDTime,0)
        if self.nCDTime > 0 and not self.bCDing then
            self.bCDing = true
            self.nCacheTimes = self.nCacheTimes - 1
            self.nCacheTimes = math.max(self.nCacheTimes,0)
        end
        local percent = self:calcuCDPercent()
        self:setCDPercent(percent)
    else
        if self.nCDTime > 0 then
            self.nCDTime  = self.nCDTime - time
            self.nCDTime  = math.max(self.nCDTime,0)
            local percent = self:calcuCDPercent()
            self:setCDPercent(percent)
        end
    end
end

--减少CD时间
function Skill:setCDControl(solecd, fixed, renovate)
    if solecd > 0 then
        self.solecd = solecd
        self.fixedCd = fixed
        if renovate then
            self.nCDTime = math.min(self.nCDTime,0.01)
        end
    else
        self.solecd = 0
        self.fixedCd = false
    end
end

--技能CD时间
function Skill:getCDTime()
    return self.nCDTime
end

function Skill:setCDPercent(percent)
    if self.nPercent ~= percent then
         self.nPercent = percent
        if self:isManual(true) then
            EventMgr:dispatchEvent(eEvent.EVENT_VKSTATE_CHANGE,self)
        end
    end
end

function Skill:getCDPercent()
    return self.nPercent
end
--冷却进度
function Skill:calcuCDPercent()
    local cdTime = self:getDataCD()
    if self.nCDTime > 0 and self.extraCdTime > 0 then
        return math.floor(self.nCDTime*100/self.extraCdTime)
    end
    if self.nCDTime > 0 and cdTime > 0 then
        return math.floor(self.nCDTime*100/cdTime)
    end
    return 0
end

--消耗处理(强制消耗)
function Skill:costForce()
    local costAnger = self:getCostAnger()
    if costAnger > 0 then
        self.hero:changeAnger(-costAnger) --self.data.costAnger)
    end
    local costEnergy = self:getCostEnergy()
    if costEnergy > 0 then
        self.hero:changeEnergy(-costEnergy) --self.data.costEnergy)
    end
    local constSpecialEnergy = self:getCostSpecialEnergy()
    if constSpecialEnergy > 0 then 
        self.hero:changeSpecialEnergy(-constSpecialEnergy)
    end
end
--消耗能量(非强制消耗)
function Skill:costExtra()
    self.hero:changeEnergy(-self:getExtraEnergy())--self.data.extraEnergy)
    local constSpecialEnergy = self:getCostSpecialEnergy()
    if constSpecialEnergy > 0 then 
        self.hero:changeSpecialEnergy(-constSpecialEnergy)
    end
end

--是否有足够的非强制消耗怒气
function Skill:isEnoughExtraAnger()
    if self.data.extraFirst > 0  then
        return self.hero:getEnergy() >= self:getExtraEnergy() --self.data.extraEnergy
    end
end

function Skill:getExtraEnergy()
    return self.data.extraEnergy
end

--是否有足够的觉醒能量
function Skill:isEnoughAnger()
    return self.hero:getAnger() >= self:getCostAnger() --self.data.costAnger 

end

--是否有足够的觉醒能量
function Skill:_isEnoughAnger()
    if self.hero.skill ~= self then
        return self:isEnoughAnger()
    end
    return true
end

function Skill:_isEnoughEnergy()
    if self.hero.skill ~= self then
        return self:isEnoughEnergy()
    end
    return true
end

--是否有足够的觉醒能量
function Skill:_isEnoughSpecialEnergy()
    if self.hero.skill ~= self then
        return self:isEnoughSpecialEnergy()
    end
    return true
end

--是否有足够的专属能量
function Skill:isEnoughEnergy()
    local costLow = self.data.costLow or 0
    local energy = self.hero:getEnergy()
    if costLow > 0 then
        return energy >= costLow
    end
    return energy >= self:getCostEnergy()
end


--消耗的怒气 TODO 有毛病
function Skill:getCostAnger()
    return self.data.costAnger
end
--消耗的专属能量(专属)
function Skill:getCostEnergy()
    return self.data.costEnergy
end

function Skill:getGainEnergy()
    return self.data.gainEnergy
end

--消耗的专属能量(专属) 显示
function Skill:getCostEnergyShow()
    if self.data.costEnergyShow  == -1 then -- -1时显示的击㐊实际消耗 
        return self.data.costEnergy
    end
    return self.data.costEnergyShow
end

--消耗的绝望点
function Skill:getCostSpecialEnergy()
    return self.data.specialEnergy  
end
--是否有足够的绝望点
function Skill:isEnoughSpecialEnergy()
    return self.hero:getSpecialEnergy() >= self:getCostSpecialEnergy()
end


--获得专属能量
function Skill:doGainEnergy()
    local gainEnergy = self:getGainEnergy()
    if gainEnergy > 0 then
        self.hero:changeEnergy(gainEnergy)
    end
end

function Skill:isExchange()
    return self.hero:isExchangeSkill(self:getCID())
end



function Skill:getMaxCacheTimes()
    return self.data.useTimes
end
function Skill:getCacheTimes()
    return self.nCacheTimes
end
function Skill:isEnable()
    -- if self.nCDTime > 0 then
    --     return false
    -- end

    if not self.hero:checkSkill_CD(self) then
        return false
    end

    if not self.hero:checkSkill(self) then
        return false
    end
    
    if self.nCacheTimes < 1 then
        return false
    end
    -- if self.hero:getAnger() < self.data.costAnger then
    --     return false
    -- end
    if not self:isEnoughAnger() then
        return false
    end
    if not self:isEnoughSpecialEnergy() then 
        return false
    end  
    return true
end

function Skill:cancel(isCd)
    -- printError(">>>>>>Skill:cancel>>>>>>>")
    self.actionData = nil
    self.eventData  = nil
    self.bActive    = false
    self.next       = false
    self.bActionMove = false
    self.actionCallFunc = nil
    if isCd then
        self:startCD()
    end
    -- print(" "..self.data.keyName .." cast over~" .. self:getKeyCode())
    -- 技能攻击完成
    self.hero:onSkillEnd(self)
    --取消魔女时间
    self:cancelWitchTime()

    if self:isGatherSkill() then
        if isCd then
            self.gatherTime  = 0
            self.gatherValue = 0
            self:eventGatherBarUpdate(3)
        end
    end
    --清理动作特效
    self.hero:getActor():clearActionParticle()
end

function Skill:tryCast(force,skillSubId)
    if force or skillSubId then 
        self:playActionF(skillSubId)
        return true
    end
    if self:isManual() then
        if self.data.keyEvent == "auto" then
            self:playActionF()
            return true
        elseif self.data.keyEvent == "down" then
            local eventdata ={} 
            eventdata[self.data.keyCode] ={}
            eventdata[self.data.keyCode][self.data.keyEvent] = self.data.first
            -- dump(eventdata)
            -- print_("-------------------------------Skill:tryCast")
            if self.hero:matchKeyEvent(eventdata) then
                            -- print_("-------------------------------Skill:tryCast  ok")
                self:playActionF()
                return true
            end
        end
    else
        self:playActionF()
        return true
    end
end


--技能键值与事件绑定
local skillType_event = {}
skillType_event[eSkillType.GENERAL] = eBFState.E_PT_ACTION --普攻
skillType_event[eSkillType.Skill_1] = eBFState.E_SKILL1_ACTION --普攻
skillType_event[eSkillType.Skill_2] = eBFState.E_SKILL2_ACTION --普攻
skillType_event[eSkillType.CRI]     = eBFState.E_DZ_ACITON --必杀
skillType_event[eSkillType.DODGE]   = eBFState.E_SB_ACTION --闪避
skillType_event[eSkillType.AWAKE]   = eBFState.E_JX_ACTION --觉醒
skillType_event[eSkillType.ENTER]   = eBFState.E_CCJ_ACTION --普攻
skillType_event[eSkillType.EXTRA_SKILL_1]   =eBFState.E_EXTRA_SKILL_1   
skillType_event[eSkillType.EXTRA_SKILL_2]   =eBFState.E_EXTRA_SKILL_2   
skillType_event[eSkillType.EXTRA_SKILL_3]   =eBFState.E_EXTRA_SKILL_3   
skillType_event[eSkillType.EXTRA_SKILL_4]   =eBFState.E_EXTRA_SKILL_4   
skillType_event[eSkillType.EXTRA_SKILL_5]   =eBFState.E_EXTRA_SKILL_5   
-- dump(skillType_event,"skillType_event")
-- Box("aaa")

--包含通用技能事件
local skillType_eventXXX = {}
skillType_eventXXX[eSkillType.Skill_1]         = eBFState.E_SKILL1_ACTION 
skillType_eventXXX[eSkillType.Skill_2]         = eBFState.E_SKILL2_ACTION
skillType_eventXXX[eSkillType.CRI]             = eBFState.E_DZ_ACITON 
skillType_eventXXX[eSkillType.AWAKE]           = eBFState.E_JX_ACTION
skillType_eventXXX[eSkillType.EXTRA_SKILL_1]   =eBFState.E_EXTRA_SKILL_1 


--使用技能派发事件
function Skill:triggerEvent()
    --触发
    local skillType = self.data.skillType
    --技能首动作事件触发
    local event = skillType_event[skillType]
    if event then
        self.hero:onEventTrigger(event)
        if event ~= eBFState.E_SB_ACTION then
            self.hero:onEventTrigger(eBFState.E_ATTACK)
        end
        --通用技能事件
        if skillType_eventXXX[skillType] then
            self.hero:onEventTrigger(eBFState.E_ATTACK_SKILL)
        end
    end
    --统计技能使用次数
    if self.data.statistics then
        EventMgr:dispatchEvent(eEvent.EVENT_SKILL, self.hero,self) --使用技能
    end

    if skillType == eSkillType.AWAKE then       
        EventMgr:dispatchEvent(eEvent.EVENT_SKILL_AWAKE, self.hero) --使用觉醒技能
    elseif skillType == eSkillType.DODGE then   
        EventMgr:dispatchEvent(eEvent.EVENT_SKILL_DODGE, self.hero) --使用觉醒技能
    end
end

function Skill:playActionF(skillSubId)
    --非强制消耗
    if self:isEnoughExtraAnger() then
        self:costExtra() --费强制的消耗处理
        local actionID = self.data.extraFirst
        if skillSubId and skillSubId > 0 then
            if skillSubId > 0 then
                actionID = self.data.subclassesFirst[skillSubId]
            end
        end
        self:playAction(actionID)
        self:triggerEvent()
        self:doGainEnergy()
    else
        self:costForce() 
        local actionID = self.data.first
        if skillSubId and skillSubId > 0 then
            if skillSubId > 0 then
                actionID = self.data.subclassesFirst[skillSubId]
            end
        end
        self:playAction(actionID)
        self:triggerEvent()
        self:doGainEnergy()
    end
-- self:startCD()
    self:triggerWitchTime()
    --首动作清理扩展觉醒伤害加成
    self.hero:getProperty():setExpandValue(eAttrType.ATTR_DMADD_JX,0)
    --首动作
    if self:isGatherSkill() then
        self.gatherTime  = 0
        self.gatherValue = 0
    end
    --檢查節能功能切換
    self:checkShiftSkill()
    self:checkIncludeskill()
end

function Skill:cancelWitchTime()
    if self.witchTime then 
        self.witchTime:cancel(eWitchTimeContinuedType.SKILL_TIME)
        self.witchTime = nil
    end
end

--魔女时间触发处理
function Skill:triggerWitchTime()
    local id = self.data.witchTimeId 
    local witchTimeType = self.data.witchTimeType
    -- print("witchTimeType:::::",witchTimeType)
    if witchTimeType == eWitchTimeTriggerType.SKILL then
        local data = TabDataMgr:getData("WitchTime", id)
        if not data then
            Box(string.format("not found WitchTime id = %s",id))
        end
        self.witchTime = self.hero:getTeam():triggerWitchTime(self.hero:getCamp(),data)
        -- print("aaaaa11")
    elseif witchTimeType == eWitchTimeTriggerType.LIMIT_DODGE then
        if self.hero:isAState(eAState.E_LIMIT_DODGE) then
            self.hero:clearAState(eAState.E_LIMIT_DODGE)
            local data = TabDataMgr:getData("WitchTime", id)
            self.witchTime = self.hero:getTeam():triggerWitchTime(self.hero:getCamp(),data)
        end
        -- print("aaaaa22")
    end
end

--播放技能动画
function Skill:playAction(actionID)
    self.bActive        = true
    self.bActionMove    = false
    self.actionCallFunc = nil
    if actionID  == 0 then  --只用来触发buffer 没有实际动作 
        return
    end
    self.hero:removeAllEffect()
    local actionData = BattleDataMgr:getActionData(actionID,self.hero:getAngleDatas())
    if not actionData then
        Box("not found SkillAction id:"..tostring(actionID))
    end 
    self.hero:setSkill(self)
    self.actionData = actionData
    self.eventData  = nil
    self.eventSkillData = nil
    self.hero:doEvent(eStateEvent.BH_SKILL,actionData)
  


    --print("修正摄像机位置")
    self.hero:handleMusicEvent(0)
    self:handlMoveEvent(0)
    self:handlCameraEvent(1)
    self:handlEffectEvent(0)
    --修正连击时间
    if self.actionData.amendCountTime ~= 0 then
        if self:isManual(true) then
            battleController.fixComboTime(self.actionData.amendCountTime)
        end
    end

    if self:isGatherSkill() then
        local index = table.indexOf(self.data.gatherPower,self.actionData.id)
        if index > 0 then
            self.bGather = true
            self:eventGatherBarUpdate(1)
        else
            self.gatherTime  = 0
            self.gatherValue = 0 
            self.bGather     = false
            self:eventGatherBarUpdate(3)
        end
    end
    if self:isManual(true) then
        EventMgr:dispatchEvent(eEvent.EVENT_SHOW_KEYLIST,self.actionData)
    end


    local particleEffect = self.actionData.particleEffect
    --粒子播放
    if particleEffect and #particleEffect then 
        self.hero:getActor():createActionParticle(particleEffect)
    end
end

--是否触发招架
function Skill:isTriggerParry(dir)
    if self.actionData then
        local withstandDirection = self.actionData.withstandDirection
        if withstandDirection == eWithstandDir.AROUND or withstandDirection == dir then
            if self.actionData.withstandSkill ~= 0 then
                --TODO 触发技能
                self.hero.willUseSkill = self.hero:getSkillByCid(self.actionData.withstandSkill)
                self.hero:castById(self.actionData.withstandSkill)
            end 
            return true
        end
    end
end

function Skill:getKeyCode()
    return self.data.keyCode
end
--帧事件
function Skill:onEvent(event)
    local eventType = event.name
    local pramN     = event.pramN
    -- print("eventType:"..eventType,pramN)
    if eventType == eArmtureEvent.NEXT then   --连击
        self:handlNextEvent(pramN)
    elseif eventType == eArmtureEvent.EFFECT then --特效触发
        self:handlEffectEvent(pramN)
    elseif eventType == eArmtureEvent.MUSIC then  --音效触发
        -- self:handlMusicEvent(pramN) --上层处理了
    elseif eventType == eArmtureEvent.SHOW then   --觉醒特效
        self:handlShowEvent(pramN)
    elseif eventType == eArmtureEvent.MOVE then   --角色位移
        self:handlMoveEvent(pramN)
    elseif eventType == eArmtureEvent.CAMERA then --摄像机事件
        self:handlCameraEvent(pramN + 1)
    else
        print("not support event:",eventName)
    end
end

function Skill:handlCameraEvent(pramN)
    if self.hero:isManual(true) or self.hero:isBoss() then
        local actionData = self.actionData
        if actionData then
            local fixParam = actionData.fixCamerZ[pramN]
            if fixParam and #fixParam == 2 then
                local time = fixParam[1]
                local fixZ = fixParam[2]
            -- print("修正摄像机位置")
                if time ~= 0 and  fixZ ~= 0 then
                    EventMgr:dispatchEvent(eEvent.EVENT_FIX_CAMERA_Z,self:getCID(),time,fixZ)
                end
            end
        end
    end
end

function Skill:handlMoveEvent(pramN)
    -- printError("触发move事件")
    local actionData = self.actionData
    if not actionData then
        return
    end 
    if self:getSKillType() ~= eSkillType.DOWN then
        if self.hero:isAState(eAState.E_STOP_MOVE) then
            local loop        = actionData.loop
            local loopTime    = actionData.loopTime
            local loopEndType = actionData.loopEndType  --循环结束时间判定（0根据动作循环时间，1位移结束）
            if loop and loopEndType == 1 then
                local delay = ActionMgr.createDelayAction()
                delay:start(self.hero,0.1,self.actionOverFunc)
            end
            return 
        end
    end
    local moveType   = actionData.moveType
    local size = #actionData.moveEvents
    if (size == 0 and  pramN == 0) or (size > 0 and pramN > 0) then
        self.bActionMove = true
        if moveType == eMoveType.Position then --固定位移
            local pos         = self.hero:getPosition3D()
            local checkDrop   = actionData.checkDrop     
            local actionMove  = actionData.actionMoveX
            local moveSpeed   = actionData.moveSpeed 
            local fallSpeed   = actionData.fallSpeed
            local actionMoveType = actionData.actionMoveType
            local loop        = actionData.loop
            local loopTime    = actionData.loopTime
            local loopEndType = actionData.loopEndType  --循环结束时间判定（0根据动作循环时间，1位移结束）
            local moveX       = 0
            local moveY       = 0
            local moveZ       = actionData.actionMoveY
            if self.hero:isInAir() then
                moveSpeed = fallSpeed
            end
            moveSpeed = moveSpeed == 0 and 100 or  moveSpeed
            local vector = self.hero:getRokeVector()
            if vector.x ~= 0 or vector.y ~= 0  then

                if actionMoveType == 0 then
                    --fix 组队模式下角色方向和角色移动方向不一致的问题
                    moveX = actionMove * vector.x
                    moveY = actionMove * vector.y * BattleConfig.YV_ATTENUATION_RATIO
                elseif actionMoveType == 1 then --只有X方向位移
                    if self.hero:getDir() == eDir.LEFT then
                        moveX = -actionMove
                    else
                        moveX = actionMove
                    end
                    moveY = 0
                elseif actionMoveType == 2 then --只有Y方向位移
                    moveX = 0
                    moveY = _symbol(moveX)*actionMove * BattleConfig.YV_ATTENUATION_RATIO

                elseif actionMoveType == 3 then 
                    moveX = actionMove * vector.x
                    moveZ = actionMove * vector.y 
                    checkDrop = false
                    if moveZ < 0 then
                        moveZ = math.max(pos.y -pos.z ,moveZ)  
                        if moveX == 0 and moveZ == 0 then
                            if self.hero:getDir() == eDir.LEFT then
                                moveX = -actionMove
                            else
                                moveX = actionMove
                            end
                        end
                    end
                end  
            else
                if self.hero:getDir() == eDir.LEFT then
                    moveX = -actionMove
                    moveY = 0
                else
                    moveX = actionMove
                    moveY = 0
                end
            end

            --是否要检查下落
            if checkDrop then
                moveZ = pos.y + moveY - pos.z
            end
            -- print("xxxx" ,vector.x ,vector.y ,actionMove,actionMoveType ,moveX,moveY,moveZ ,moveSpeed)
            if moveX ~= 0 or moveY ~= 0 or moveZ ~= 0 then
                local delta     = me.Vertex3F(moveX, moveY, moveZ )
                local duration  = math.sqrt(delta.x*delta.x + delta.y*delta.y + delta.z*delta.z)/moveSpeed
                local moveAction = ActionMgr:createMoveAction()
                if loop and loopEndType == 1 then  --TODO 可能这个判断多余
                    moveAction:start(self.hero , duration , delta, self.actionOverFunc) 
                else
                    moveAction:start(self.hero , duration , delta) 
                end
            else
                if loop and loopEndType == 1 then 
                    local delay = ActionMgr.createDelayAction()
                    delay:start(self.hero,0.1,self.actionOverFunc)
                end
            end
           
        elseif moveType == eMoveType.Free then --摇杆控制位移

        elseif moveType == eMoveType.Target then --目标位置位移
            local target = self:selectTarget()
            if target then
                local moveSpeed   = actionData.moveSpeed
                local fallSpeed   = actionData.fallSpeed 
                local pos3D       = self.hero:getPosition3D()
                local tarPos3D    = target:getPosition3D()
                local loop        = actionData.loop
                local loopTime    = actionData.loopTime
                local loopEndType = actionData.loopEndType  --循环结束时间判定（0根据动作循环时间，1位移结束）
                local moveX       = tarPos3D.x - pos3D.x
                local moveY       = tarPos3D.y - pos3D.y
                local moveZ       = tarPos3D.z - pos3D.z
                local fixTargetX  = actionData.fixTarget 
                if fixTargetX ~= 0 then
                    -- if math.abs(moveX) > math.abs(fixTargetX) then
                        if moveX >= 0 then
                            moveX = moveX + fixTargetX
                        else
                            moveX = moveX - fixTargetX
                        end
                    -- end
                end
                if moveX ~= 0 or moveY ~= 0 or moveZ ~= 0 then
                    if self.hero:isInAir() then
                        moveSpeed = fallSpeed
                    end
                    if fixTargetX ~= 0 then 
                        if pos3D.x + moveX > tarPos3D.x then 
                            self.hero:setDir(eDir.LEFT)
                        else
                            self.hero:setDir(eDir.RIGHT)
                        end
                    else
                        if moveX > 0 then
                            self.hero:setDir(eDir.RIGHT)
                        elseif moveX < 0 then
                            self.hero:setDir(eDir.LEFT)
                        end
                    end
                    local delta     = me.Vertex3F(moveX, moveY, moveZ )
                    local duration  = math.sqrt(delta.x*delta.x + delta.y*delta.y + delta.z*delta.z)/moveSpeed
                    local moveAction = ActionMgr:createMoveAction()
                    if loop and loopEndType == 1 then  --TODO 可能这个判断多余
                        moveAction:start(self.hero , duration , delta, self.actionOverFunc) 
                    else
                        moveAction:start(self.hero , duration , delta) 
                    end
                else
                    if loop and loopEndType == 1 then
                        local delay = ActionMgr.createDelayAction()
                        delay:start(self.hero,0.1,self.actionOverFunc)
                    end
                end
            end
        elseif moveType == eMoveType.Target_Shadow then
            local target = self:selectTarget()
            if target then
                local moveSpeed   = actionData.moveSpeed 
                local fallSpeed   = actionData.fallSpeed
                local pos3D       = self.hero:getPosition3D()
                local tarPos3D    = target:getPosition3D()
                local loop        = actionData.loop
                local loopTime    = actionData.loopTime
                local loopEndType = actionData.loopEndType  --循环结束时间判定（0根据动作循环时间，1位移结束）                
                local moveX       = tarPos3D.x - pos3D.x
                local moveY       = tarPos3D.y - pos3D.y
                local moveZ       = tarPos3D.y - pos3D.z
                local fixTargetX  = actionData.fixTarget 
                if fixTargetX ~= 0 then
                    -- if math.abs(moveX) > math.abs(fixTargetX) then //TODO 峰哥让屏蔽这个条件
                        if moveX >= 0 then
                            moveX = moveX + fixTargetX
                        else
                            moveX = moveX - fixTargetX
                        end
                    -- end
                end

                if moveX ~= 0 or moveY ~= 0 or moveZ ~= 0 then
                    if self.hero:isInAir() then
                        moveSpeed = fallSpeed
                    end
    --[[                if moveX > 0 then
                        self.hero:setDir(eDir.RIGHT)
                    elseif moveX < 0 then
                        self.hero:setDir(eDir.LEFT)
                    end--]]
                    if fixTargetX ~= 0 then 
                        if pos3D.x + moveX > tarPos3D.x then 
                            self.hero:setDir(eDir.LEFT)
                        else
                            self.hero:setDir(eDir.RIGHT)
                        end
                    else
                        if moveX > 0 then
                            self.hero:setDir(eDir.RIGHT)
                        elseif moveX < 0 then
                            self.hero:setDir(eDir.LEFT)
                        end
                    end


                    local delta     = me.Vertex3F(moveX, moveY, moveZ )
                    local duration  = math.sqrt(delta.x*delta.x + delta.y*delta.y + delta.z*delta.z)/moveSpeed
                    local moveAction = ActionMgr:createMoveAction()
                    if loop and loopEndType == 1 then  --TODO 可能这个判断多余
                        moveAction:start(self.hero , duration , delta, self.actionOverFunc) 
                    else
                        moveAction:start(self.hero , duration , delta) 
                    end
                else
                    if loop and loopEndType == 1 then
                        local delay = ActionMgr.createDelayAction()
                        delay:start(self.hero,0.1,self.actionOverFunc)
                    end
                end
            end
        elseif moveType == eMoveType.Map_Center then
            local rect = battleController.getMoveRect()
            local moveSpeed   = actionData.moveSpeed
            local fallSpeed   = actionData.fallSpeed 
            local pos3D       = self.hero:getPosition3D()
            local tarPos3D    = me.Vertex3F(rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height / 2, 0)
            local loop        = actionData.loop
            local loopTime    = actionData.loopTime
            local loopEndType = actionData.loopEndType  --循环结束时间判定（0根据动作循环时间，1位移结束）
            local moveX       = tarPos3D.x - pos3D.x
            local moveY       = tarPos3D.y - pos3D.y
            local moveZ       = moveY
            local fixTargetX  = actionData.fixTarget 
            if fixTargetX ~= 0 then
                -- if math.abs(moveX) > math.abs(fixTargetX) then
                    if moveX >= 0 then
                        moveX = moveX + fixTargetX
                    else
                        moveX = moveX - fixTargetX
                    end
                -- end
            end
            if moveX ~= 0 or moveY ~= 0 or moveZ ~= 0 then
                if self.hero:isInAir() then
                    moveSpeed = fallSpeed
                end
                if fixTargetX ~= 0 then 
                    if pos3D.x + moveX > tarPos3D.x then 
                        self.hero:setDir(eDir.LEFT)
                    else
                        self.hero:setDir(eDir.RIGHT)
                    end
                else
                    if moveX > 0 then
                        self.hero:setDir(eDir.RIGHT)
                    elseif moveX < 0 then
                        self.hero:setDir(eDir.LEFT)
                    end
                end
                local delta     = me.Vertex3F(moveX, moveY, moveZ )
                local duration  = math.sqrt(delta.x*delta.x + delta.y*delta.y + delta.z*delta.z)/moveSpeed
                local moveAction = ActionMgr:createMoveAction()
                if loop and loopEndType == 1 then  --TODO 可能这个判断多余
                    moveAction:start(self.hero , duration , delta, self.actionOverFunc) 
                else
                    moveAction:start(self.hero , duration , delta) 
                end
            else
                if loop and loopEndType == 1 then
                    local delay = ActionMgr.createDelayAction()
                    delay:start(self.hero,0.1,self.actionOverFunc)
                end
            end
        end
    end
end
function Skill:handlShowEvent(pramN)
    local eventName = eArmtureEvent.SHOW..pramN
    local actionID   = self.actionData.id
    local showData = BattleDataMgr:getShowData(actionID)
    if showData then
        if table.find(showData.triggerEvents , eventName) ~= -1 then
            local flipX = false
            if self.hero:getDir() == eDir.LEFT then
                flipX = true
            end
            --组队模式下不显示觉醒特写
            if not battleController.isLockStep() and SettingDataMgr:getAwakeEffect() == 1 then
                AwakeMgr.play(showData,flipX,self.hero)
            end
        end
    end
end
function Skill:handlNextEvent(pramN)
    local eventName = "next"..pramN
    -- print(">>>>>>>Skill:onEvent>>>>",eventName)
    self.eventData  = self.actionData.frameEvents[eventName]
    self.eventSkillData  = self.actionData.eventsSkill[eventName]

    -- print("self.eventData",self.eventData)
    self:checkNext(true)
end

function Skill:handlEffectEvent(pramN)
    if not self.actionData then  --TODO 正常情况下不会为NULL
        return
    end
    local eventName  = "effect"..pramN
    local effectIds = self.actionData.includeEffect
    for i,id in ipairs(effectIds) do
        local effectData = BattleDataMgr:getEffectData(id,self.hero:getAngleDatas())
        if effectData then
            if table.find(effectData.triggerEvents, eventName)  ~= -1 then
                SkillEffect.create(effectData,self.hero)
            end
        end
    end
end

        -- frameEvents = {
        --     next1 = {
        --         [32] = {
        --             down = 7009,
        --             up = 1,
        --         },
        --     },
        -- },
--随机动作/随机技能
local function RANDOM_EVENT( eventData )
    local keyCodes = table.keys(eventData)
    if #keyCodes > 0 then
        local keyEvent_map  = eventData[keyCodes[RandomGenerator.random(#keyCodes)]]
        local keyEvents     = table.keys(keyEvent_map)
        return keyEvent_map[keyEvents[RandomGenerator.random(#keyEvents)]]
    end
end


--连击检查
function Skill:checkNext(force)
    if self.eventSkillData then
        if self:isManual() then
            -- dump(self.eventSkillData)
            local skillId = self.hero:matchKeyEvent(self.eventSkillData)
            if skillId then
                print_("checkNext cast skill"..tostring(skillId))
                local list = self.hero:getSkillList()
                for i, skill in ipairs(list) do
                    if skill:getData().id == skillId then
                        if self.hero:castSK(skill) then
                            self.eventSkillData = nil
                            -- Box("><><><>>trigget next skill1 >>>>>>>>>>>")
                            return
                        end
                    end
                end
            end
        else
            -- if self.hero:canNextAttack() then
            --     local skillId = RANDOM_EVENT(self.eventSkillData)
            --     if skillId then
            --         local list = self.hero:getSkillList()
            --         for i, skill in ipairs(list) do
            --             if skill:getData().id == skillId then
            --                 if self.hero:castSK(skill) then
            --                     -- Box("><><><>>trigget next skill2 >>>>>>>>>>>")
            --                     self.eventSkillData = nil
            --                     return
            --                 end
            --             end
            --         end
            --     end
            -- else
                self.eventSkillData = nil
            -- end
        end
    end
    if self.eventData then
        if self:isManual() then
            -- dump(self.eventData)
            for k,keyCodeData in pairs(self.eventData) do
                if keyCodeData["auto"] then
                    autoActionID = keyCodeData["auto"]
                    self:playAction(autoActionID)
                    self.eventData = nil
                    return
                end
            end
            local actionID = self.hero:matchKeyEvent(self.eventData)
            if actionID then
                self:playAction(actionID)
                self.eventData = nil
            end
        else
            --AI状态下只检查一次
            if self.hero:canNextAttack() then
                local actionID = RANDOM_EVENT(self.eventData)
                if actionID then
                    self:playAction(actionID)
                    self.eventData = nil
                    print("><><><>>trigget next >>>>>>>>>>>")
                end
            else
                self.eventData = nil
            end
        end
    end
end

--击中连接处理(峰哥)
function Skill:checkNext_hitAction()
    if self.actionData then
        local hitAction = self.actionData.hitAction
        if hitAction > 0 then
            self:playAction(hitAction)
        end
    end
end

function Skill:autoMove(time)
    if self.bActionMove  then 
        if self.actionData then
            if self.actionData.moveType == eMoveType.Free then
                local moveSpeed = self.actionData.moveSpeed
                if moveSpeed ~= 0 then
                    local vector = self.hero:getRokeVector() 
                    print(vector)
                    if vector.x == 0 and vector.y == 0 then 
                        local xv = moveSpeed*time*0.001
                        local dir = self.hero:getDir()
                        if dir == eDir.LEFT then
                            xv = -xv
                        end
                        self.hero:renderMove(xv,0,0)
                    end
                end
            end
        end
    end
end
function Skill:update(time)
    if battleController.isTiming() then
        self:handlCD(time)
    end
    self:autoMove(time)
    self:handleGather(time)
    --更新按钮
    if self:isManual(true) then
        if self.data.keyName == "F" then
            local enoughAnger = self:_isEnoughAnger() and self:_isEnoughSpecialEnergy()
            local anger       = self.hero:getAnger()
            if self.tmpEnoughAnger ~= enoughAnger or self.tmpAnger ~= anger  then
                EventMgr:dispatchEvent(eEvent.EVENT_VKSTATE_CHANGE,self)
                self.tmpEnoughAnger = enoughAnger
                self.tmpAnger       = anger
            end
        else
            local enoughEnergy = self:_isEnoughEnergy() and self:_isEnoughSpecialEnergy()
            if self.bEnoughEnergy~= enoughEnergy then
                EventMgr:dispatchEvent(eEvent.EVENT_VKSTATE_CHANGE,self)
                self.bEnoughEnergy = enoughEnergy
            end
        end

    end
end
--闪避技能(固定距离固定速度 暂时)

--技能释放优先级
function Skill:getLevel()
    return self.data.level
end

function Skill:checkLevel(level)
    if self.data.levelType > 0 then
        return self:getLevel() > level
    end
    return self:getLevel() >= level
end

--技能的一个动作播放完成
function Skill:onAcitonOver()
    --清理动作绑定的粒子
    self.hero:getActor():clearActionParticle()
    if self.actionData then
        if self.actionData.connectAction > 0 then
            self:playAction(self.actionData.connectAction)
            return true
        end
    end

end

--以目标为几点的位移暂时不考虑
--实现起来有问题

function Skill:getAcitonData()
    return self.actionData
end

---动作寻敌(目前只支持动作寻敌)
function Skill:selectTarget()
    if self.actionData then
        local actionData = self.actionData
        local targets = selectTarget.selectTarget(self.hero, actionData.target , actionData.area , 1 , actionData.cond)
        return targets[1]
    end
end

--是否进攻技能
function Skill:isAttack()
    local skillType = self.data.skillType
    return skillType ~= eSkillType.DODGE and skillType ~= eSkillType.DOWN
end

--连击
function Skill:setNext(next)
    self.next = next
end

--是否是霸体
function Skill:isActionHard()
    if self.actionData then
        return self.actionData.actionHard
    end
end

function Skill:canMove()
    if self.actionData then
        if self.bActionMove then 
            return self.actionData.rockerChange ~= 0 
        end
    end
end
--动作的位移速度
function Skill:getMoveSpeed()
    if self.actionData then
        return self.actionData.rockerChange
    end
    return 0
end

function Skill:getCID()
    return self.data.id
end
--技能冷却
--a.技能播放完成开始冷却
--b.技能释放完成的标准是啥

function Skill:getSKillType()
    return self.data.skillType
end

-- 练习模式cd时间
function Skill:clearCD()
    self.nCDTime = 0
    self:update(0)
end

function Skill:getSilence()
    if not self.hero:checkSkill_CD(self) then
        return 2
    end
    if not self.hero:checkSkill(self) then
        return 1
    end
    return 0
end

--强制更新
function Skill:forceUpdate(flag)--强制更新
    if self:isVisiable() then
        if self:isManual(true) then
            EventMgr:dispatchEvent(eEvent.EVENT_VKSTATE_CHANGE, self , flag)
        end
    end
end

function Skill:setShowSubSkill(show)
    self.showingSubSkill = show
end

function Skill:getSubSkillShowState()
    return self.subSkillState
end

function Skill:setSubSkillShowState(state)
    self.subSkillState = state
end

function Skill:showOrHideSubSkills()
    EventMgr:dispatchEvent(eEvent.EVENT_SUB_SKILL_SHOW, self)
end

return Skill
