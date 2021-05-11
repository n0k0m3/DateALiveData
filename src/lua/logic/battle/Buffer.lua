local BattleMgr   = import(".BattleMgr")
local BattleUtils = import(".BattleUtils")
local BFEffect    = import(".BFEffect")
local enum      = import(".enum")
local eAttrType = enum.eAttrType
local eBFState         = enum.eBFState
local eBFTriggerType   = enum.eBFTriggerType
local eBFTriggerObject = enum.eBFTriggerObject
local eBFTargetType    = enum.eBFTargetType
local eBFETakeType     = enum.eBFETakeType
local eBFETakeCondition = enum.eBFETakeCondition
local eBFAddType       = enum.eBFAddType
local eRoleType        = enum.eRoleType
local eAState          = enum.eAState
local __print = print
local print = BattleUtils.print
local bufferMgr = BattleMgr.getBufferMgr()

local Buffer = class("Buffer")
function Buffer:ctor(data,host)
    self.data    = data
    self.host    = host  --buff持有者
    self.probability = self.data.probability
    self.nTime     = 0  --CD
    self.nInterval = self.data.interval  --间隔触发
    --buff触发对象(不同触发对象如何处理)
    self.triggerObj = nil
    --事件对应方
    self.receiveObj = nil
    --特效节点
    self.effectNode = nil
end

--修改buffer的触发概率
function Buffer:changeProbability(value)
    self.probability = self.probability + value
    -- print("changeProbability",self.data.id, self.probability)
end

function Buffer:getID()
    return self.data.id
end
function Buffer:getObjectID()
    return self.id
end
function Buffer:pause()
end
function Buffer:resume()
end
function Buffer:update(dt)
    if self.host:isAlive() then
        if battleController.isTiming() then
            self:handleCD(dt)
            self:handlInterval(dt)
        end
    end
end
function Buffer:clear()

end

--添加到管理器
function Buffer:addToMgr()
    bufferMgr:add(self)
end
--從管理器刪除
function Buffer:removeFromMgr()
    bufferMgr:remove(self)
end

function Buffer:handleCD(dt)
    if self.nTime > 0 then
        self.nTime = self.nTime - dt
    end
end
function Buffer:handlInterval(dt)
    if self.data.triggerType == eBFTriggerType.TT_INTERVAL then
        self.nInterval  = self.nInterval  + dt
        if self.nInterval > self.data.interval then
            self.nInterval = 0
            self:onIntervalTrigger()
        end
    end
end


function Buffer:isEnable()
    if battleController.isRun() then
        return self.nTime <= 0
    end
end

--是否是合法的触发对象
function Buffer:isVaildTriggerTarget(target)
    local triggerTarget = self.data.triggerTarget
    if triggerTarget == eBFTriggerObject.TO_ME then
        -- print("isVaildTriggerTarget target",self.host.data.name ,target.data.name)
        return self.host == target
    elseif triggerTarget == eBFTriggerObject.TO_RAN_FRIEND then --任一队友
            return BattleUtils.campState(self.host:getCamp(),target:getCamp()) == 1
    elseif triggerTarget == eBFTriggerObject.TO_RAN_ENEMY then  --任一敌人
            return BattleUtils.campState(self.host:getCamp(),target:getCamp()) == 2
    elseif triggerTarget == eBFTriggerObject.TO_APPOINT_FRIEND then --指定队友
        --检查队友类是否包含
        if self.data.targetID == 0 then
            return true
        end
        local heros = self.host:getFriends()
        for i,v in ipairs(heros) do
            if v:getData().id == self.data.targetID then 
                return true
            end
        end
        return false
    elseif triggerTarget == eBFTriggerObject.TO_RAN_FRIEND_HERO then --任一队友 角色
        local roleType = target:getRoleType() 
        if roleType == eRoleType.Hero 
        or roleType == eRoleType.Team
        or roleType == eRoleType.Assist then 
            return BattleUtils.campState(self.host:getCamp(),target:getCamp()) == 1
        end
    elseif triggerTarget == eBFTriggerObject.TO_RAN_FRIEND_MONSTER then --任一队友 怪
        local roleType = target:getRoleType() 
        if roleType == eRoleType.Monster then 
            return BattleUtils.campState(self.host:getCamp(),target:getCamp()) == 1
        end
    end
end

--出战状态检查
function Buffer:isCanTrigger()
    --false 上场才可以触发 true 上下场都可以触发
    --天赋触发类不受限制
    if self.data.triggerType == eBFTriggerType.TT_TALENT then
        return true
    end
    if self.data.triggerPosition then 
        return true
    else
        --只有出战才能触发
        return self.host:isBattle()
    end
    -- 12021/12081  
    return true
end

function Buffer:isTriggerType(triggerType)
    return self.data.triggerType == triggerType
end
function Buffer:isVaildTrigger(target,triggerType)
    --是否在冷却
    -- print("aaaa")
    if self:isEnable() then
        if self:isCanTrigger() then
            -- print("bbbb")
            --触发对象检查
            if self:isVaildTriggerTarget(target) then
                -- print("cccc")
                --触发类型检查
                return self:isTriggerType(triggerType)
            end
        end
    end
end

-- triggerTarget   event   attributeId stateId
-- attributeTarget attributeNum    attributeContrast   targetState probability

--技能触发
--技能事件定义[hurt]
function Buffer:onSkillTrigger( source ,event,buffId ,target,effectNode)
    if self:isVaildTrigger(source,eBFTriggerType.TT_SKILL) then
        if buffId == self.data.id then
            if self:checkTriggerCondition(source) then  --检查次要状态
                self.triggerObj = source
                self.receiveObj = target
                self.effectNode = effectNode
                self:triggerTest()
            end
        end
    end
end

--使用卡牌触发
function Buffer:onUseCardTrigger(source,buffId)
    if self:isVaildTrigger(source,eBFTriggerType.TT_USE_CARD) then
        if buffId == self.data.id then
            -- if self:checkTriggerCondition(source) then  --检查次要状态
                self.triggerObj = source
                self.receiveObj = source
                self:triggerTest()
            -- end
        end
    end
end

--间隔自动触发
function Buffer:onIntervalTrigger()
    -- print("Buffer 间隔触发")
    if self:isVaildTrigger(self.host,eBFTriggerType.TT_INTERVAL) then
        if self:checkTriggerCondition(self.host) then  --检查次要状态
            self.triggerObj    = self.host
            self:triggerTest()
        end
    end
end

--天赋初始触发
function Buffer:onTalentTrigger(target)
    if self:isVaildTrigger(target,eBFTriggerType.TT_TALENT) then
        -- if self:checkEvent1(target) then  --检查次要状态
        -- if self.data.id == 4006 then
        --     Box("xxxTalentTriggerxx"..self.data.id)
        -- end
            self.triggerObj    = target
            self:triggerTest()
        -- end
    end
end

--检查作用目标的附加状态和属性
function Buffer:checkTargetState(target)
    -- print("checkTargetState",
    --     self.data.id,
    --     self.data.targetState,
    --     self.data.targetAttributeId)
    if target then
        --对象生物类型判断
        local targetMonsterType = self.data.targetMonsterType
        if targetMonsterType and targetMonsterType ~= -1 then 
            if targetMonsterType ~= target:getBodyType() then
                return false
            end
        end

        local targetMonsterType2 = self.data.targetMonsterType2
        if targetMonsterType2 and targetMonsterType2 ~= -1 then
            if targetMonsterType2 ~= target:getMonsterType() then 
                return false
            end 
        end

        local targetState = self.data.targetState
        if targetState > 0 then  --
            -- print("checkState" ,target:isAState(targetState) )
            if not target:isAState(targetState) then
                return false
            end
        end
        local _attrType     = self.data.targetAttributeId
        if _attrType > 0 then
            local _attrValue  = self.data.targetAttributeNum
            local _attrContrast  = self.data.targetAttributeContrast
            if _attrContrast == 1 then --高于
                if target:getValue(_attrType) <=  _attrValue then
                    return false
                end
            elseif _attrContrast == 2 then --低于
                if target:getValue(_attrType) >=  _attrValue then
                    return false
                end
            else
                return false
            end
        end
        return true
    end
    return true
end

--状态触发
function Buffer:onStateTrigger(source,state)
    if not state then
        printError("onStateTrigger state is nil")
        Box("onStateTrigger state is nil")
    end
    if self:isVaildTrigger(source,eBFTriggerType.TT_STATE) then
        if self.data.stateId == state then
            local target = source
            if self:checkTriggerCondition(source) then  --检查次要状态 target-> source ???
                if self:checkTargetState(target) then
                    self.triggerObj = source
                    self.receiveObj = target
                    self:triggerTest()
                end
            end
        end
    end
end
--事件触发
function Buffer:onEventTrigger(source,event,target,param)
    if not event then
        printError("onEventTrigger event is nil")
        Box("onEventTrigger event is nil")
    end

    if self.data.eventId ~= event then return end
    
    if self:isVaildTrigger(source,eBFTriggerType.TT_EVENT) then
        -- print(string.format("onEventTrigger(%s,%s)",self.data.stateId , state))
        if self.data.eventId == event then
            -- print(">>>>>>>>>>>>>>>>>>>>>>>")
            -- print("Buffer:onEventTrigger3333",self.data.eventId , event ,param)
            if self:checkTriggerCondition(source) then  --检查次要状态 target-> source ???
                if self:checkTargetState(target) then
                    self.triggerObj = source
                    self.receiveObj = target
                    self:triggerTest()
                end
            end
        end
    end
end
function Buffer:matchAttrType(attrType)
    local attrTypes = self.data.attributeId
    for i, _attrType in ipairs(attrTypes) do
        if attrType == _attrType then
            return true
        elseif attrType == eAttrType.ATTR_NOW_HP
            or attrType == eAttrType.ATTR_MAX_HP  then
            if _attrType == eAttrType.ATTR_LOASS_HP               -- 当前失血量
            or _attrType == eAttrType.ATTR_NOW_HP_PERCENT               -- 当前血量百分比
            or _attrType == eAttrType.ATTR_LOASS_HP_PERCENT then         -- 当前血量损失的百分比
                return true
            end
        end
    end
    return false
end

--属性变更触发
function Buffer:onAttrTrigger(target,attrType,value)
    -- print(string.format("onAttrTrigger(%s,%s)",attrType,value))
    if self:isVaildTrigger(target,eBFTriggerType.TT_ATTR) then
        if self:matchAttrType(attrType) then
            self.triggerObj    = target
            -- print(string.format("attr(%s,%s)",attrType ,value))
            local bTrigger = self:checkTargetAttr(target)
            if bTrigger then
                if self:checkTriggerCondition(target) then  --检查次要状态
                    self:triggerTest()
                end
            end
        end
    end
end

--概率触发
function Buffer:triggerTest()
    --特定目标检测生效与否
    if self.data.effective and table.count(self.data.effective) > 0 then
        if self.data.effective[1] then
            local flag = false
            for k,targetId in pairs(self.data.effective[1]) do
                if self.host:getData().id == targetId then
                    flag = true
                end
            end
            if not flag then
                return
            end
        elseif self.data.effective[2] then
            local flag = false
            for k,targetId in pairs(self.data.effective[2]) do
                if self.host:getData().id == targetId then
                    flag = true
                end
            end
            if flag then
                return
            end
        end
    end
    print("triggerTest buffer id",self.data.id , self.probability)
    --TODO 概率触发暂时屏蔽
    if BattleUtils.triggerTest10000(self.probability) then
        self.nTime = self.data.cd -- 开始CD
        self:trigger()
    end
end


function Buffer:trigger()
    print("buffer triggered ...",self.data.id)
    --固定buffer effect
    for k, effectId in ipairs(self.data.effects) do
        local takeObjs = self:getTakeTarget(effectId)
        local data   = TabDataMgr:getData("BufferEffect",effectId)
        for k, takeObj in ipairs(takeObjs) do
            self:triggerOnce(takeObj,data)
        end
    end
    --随机buffer effect
    if self.data.randomEffects then
        local length = #self.data.randomEffects
        if length > 0 then
            local effects = self.data.randomEffects[RandomGenerator.random(length)]
            for k, effectId in ipairs(effects) do 
                local takeObjs = self:getTakeTarget(effectId)
                local data   = TabDataMgr:getData("BufferEffect",effectId)
                for k, takeObj in ipairs(takeObjs) do
                    self:triggerOnce(takeObj,data)
                end
            end
        end
    end
end
function Buffer:triggerOnce(takeObj,data)
        --免疫负面效果
        if takeObj:isAState(eAState.E_MIANYI_DBUFF) then
            if data.benefitType >= 2 then
                return
            end
        end
        --免疫减少属性的效果
        if takeObj:isAState(eAState.E_MIANYI_ATTR_DEBUFF) then
            if data.attrDebuff then
                return
            end
        end

        --受目标状态影响
        if not self:checkAttrChangeState(takeObj,data) then
            return
        end

        if not self:checkEffectCondition(takeObj,data) then
            return
        end
        -- Box("self.probability:"..tostring(self.probability))
        --找到生效对象
        local effectId = data.id
        print("triggerOnce effect "..effectId)
        -- print(">>>>>>>>>>>>aaa>>>>>>>>>>>>>>",data.superpositionType)
        if data.superpositionType == eBFAddType.AT_ADD1 then --完全叠加 各自生效
            --检查是都达到最大叠加层数
            local times  = takeObj:getBFEffectAddTimes(effectId)
            print("完全叠加各自生效",data.id , "已经叠加", times)
            if times < data.maxSuperposition or data.maxSuperposition == -1 then
                local effect = BFEffect:new(data)
                effect:bind(takeObj,self.host,self.triggerObj,self.receiveObj,self.data.id)
                effect:setEffectNode(self.effectNode)
                effect:addTest()
            else
                print("已达到最大叠加层数")
            end
        elseif data.superpositionType == eBFAddType.AT_NONE then --不能叠加
            print("不能叠加的效果",data.id)
            local effect = takeObj:getBFEffect(effectId)
            if not effect then
                effect = BFEffect:new(data)
                effect:bind(takeObj,self.host,self.triggerObj,self.receiveObj,self.data.id)
                effect:setEffectNode(self.effectNode)
                effect:addTest()
            end
        elseif data.superpositionType == eBFAddType.AT_REPLACE then --替换
            print("替换型效果",data.id)
            local effect = takeObj:getBFEffect(effectId)
            if not effect then
                effect = BFEffect:new(data)
                effect:bind(takeObj,self.host,self.triggerObj,self.receiveObj,self.data.id)
                effect:setEffectNode(self.effectNode)
                effect:addTest()
            else --效果替换处理
                effect:bind(takeObj,self.host,self.triggerObj,self.receiveObj,self.data.id)
                effect:setEffectNode(self.effectNode)
                effect:replace()
            end
        elseif data.superpositionType == eBFAddType.AT_ADD2 then --效果叠加 时间公用
            print("效果叠加效过",data.id)
            --叠加和生效效果处理
            local effect = takeObj:getBFEffect(effectId)
            if effect then
                effect:bind(takeObj,self.host,self.triggerObj,self.receiveObj,self.data.id)
                effect:setEffectNode(self.effectNode)
                --处理叠加
                effect:addTest()
            else
                --还未有生效的buf
                effect = BFEffect:new(data)
                effect:bind(takeObj,self.host,self.triggerObj,self.receiveObj,self.data.id)
                effect:setEffectNode(self.effectNode)
                effect:addTest()
            end
        elseif data.superpositionType == eBFAddType.AT_ADD3 then --效果不叠 时间累加
            print("效果不叠加时间累加效果",data.id)
            --叠加和生效效果处理
            local effect = takeObj:getBFEffect(effectId)
            if effect then
                effect:bind(takeObj,self.host,self.triggerObj,self.receiveObj,self.data.id)
                effect:setEffectNode(self.effectNode)
                --处理叠加
                effect:addTestTime() --时间叠加
            else
                --还未有生效的buf
                effect = BFEffect:new(data)
                effect:bind(takeObj,self.host,self.triggerObj,self.receiveObj,self.data.id)
                effect:setEffectNode(self.effectNode)
                effect:addTest()
            end
        end
    -- end
    self.effectNode = nil
end

function Buffer:checkAttrChangeState(takeObj,data)
    if data.attributeGrow and data.attributeGrow > 0 and (data.effectNum < 0 or data.ratio < 0) then
        if data.statestrike and #data.statestrike > 0 then
            for i,state in ipairs(data.statestrike) do
                if takeObj:isAState(state) then
                    return false
                end
            end
        end
    end
    return true
end

function Buffer:checkEffectCondition(takeObj,data)
    local condition = data.effectCondition
    if condition and condition > 0 then
        local targets = {}
        if condition == eBFETakeCondition.TC_TARGET_FRIEND then
            table.insertTo(targets,self:getHost():getAreaFrineds(-1,nil,true))
            table.insertTo(targets,self:getHost():getCalls(-1,100,1))
        elseif condition == eBFETakeCondition.TC_TARGET_ENEMY then
            table.insertTo(targets,self:getHost():getAreaEnemys(-1))
            table.insertTo(targets,self:getHost():getCalls(-1,100,2))
        elseif condition == eBFETakeCondition.TC_TARGET_ALL then
            table.insertTo(targets,battleController.getTeam():getHerosEx())
        elseif condition == eBFETakeCondition.TC_TARGET_FRIEND_CALL then
            table.insertTo(targets,self:getHost():getCalls(-1,100,1))
        elseif condition == eBFETakeCondition.TC_TARGET_ENEMY_CALL then
            table.insertTo(targets,self:getHost():getCalls(-1,100,2))
        elseif condition == eBFETakeCondition.TC_TARGET_CALL then
            table.insertTo(targets,self:getHost():getCalls(-1,100))
        end
        if data.bodyCount > 0 then
            local realTargets = {}
            if data.bodyType >= 0 then
                for i,v in ipairs(targets) do
                    if v:isActive() and v:getBodyType() == data.bodyType then
                        table.insert(realTargets, v)
                    end
                end
                return #realTargets >= data.bodyCount
            else
                for i,v in ipairs(targets) do
                    if v:isActive() then
                        table.insert(realTargets, v)
                    end
                end
                return #realTargets >= data.bodyCount
            end
        end
    end
    return true
end

--BUFF持有者
function Buffer:getHost()
    return self.host
end
--BUFF触发对象
function Buffer:getTriggerTar()
    return self.triggerObj
end

--事件作用对象
function Buffer:getEventTar()
    return self.receiveObj
end

function Buffer.create(id,host)
    local data = TabDataMgr:getData("Buffer",id)
    if not data then
        Box("buffer id "..tostring(id).." not find")
    end
    return Buffer:new(data,host)
end


-------------------

--1.以触发对象为中心
--2.状态提供方
--3.状态对应方
--4.以固定点为中心

local eCenterPointType =
{
    CPT_TRIGGER   = 1, --触发
    CPT_EVENT_SRC = 2, --状态来源方
    CPT_EVENT_TAR = 3, --状态来源方
    CPT_POINT     = 4, --固定中心点
}
--效果的范围中心点
function Buffer:getCenterTarget(effectId)
    local data = TabDataMgr:getData("BufferEffect",effectId)
    local centerPoint = data.centerPoint
    if centerPoint == eCenterPointType.CPT_TRIGGER then
        return self:getTriggerTar()
    elseif centerPoint == eCenterPointType.CPT_EVENT_TAR then
        return self:getEventTar()
    elseif centerPoint == eCenterPointType.CPT_POINT then
        --TODO 未完成
        printError("固定中心点未实现")
    end
end


--效果的生效对象
function Buffer:getTakeTarget(effectId)
    local data = TabDataMgr:getData("BufferEffect",effectId)
    if not data then
        Box("BufferEffect id "..tostring(effectId).." not find")
    end
    local effectTarget = data.effectTarget
    if data.objectType == 1 then  --作用予单位
        if effectTarget == eBFTargetType.TT_ME then --自己（buff提供者）
            return {self:getHost()}
        elseif effectTarget == eBFTargetType.TT_TRIGGER then --buff触发对象
            return {self:getTriggerTar()}
        elseif effectTarget == eBFTargetType.TT_EVENT_SRC then --状态来源方
            return {self:getTriggerTar()}
        elseif effectTarget == eBFTargetType.TT_EVENT_TAR  then --状态对应方(状态目标)
            return {self:getEventTar()}
        elseif effectTarget == eBFTargetType.TT_FRIENT  then --队友
            local targerts = self:getHost():getAreaFrineds(-1)
            if data.targetID == 0 then
                return targerts
            end
            for i,v in ipairs(targerts) do
                if v:getData().id == data.targetID then 
                    return {v}
                end
            end
            return {}
        elseif effectTarget == eBFTargetType.TT_ENEMY  then --敌人
            local targerts = self:getHost():getAreaEnemys(-1)
            if data.targetID == 0 then
                return targerts
            end
            for i,v in ipairs(targerts) do
                if v:getData().id == data.targetID then 
                    return {v}
                end
            end
            return {}
        elseif effectTarget == eBFTargetType.TT_ENEMY_RANDOM then --随机敌人
            local result = self:getHost():getAreaEnemys(-1)
            local unitNum   = data.unitNum
            while #result > unitNum do 
                table.remove(result,RandomGenerator.random(#result))
            end
            return result
        elseif effectTarget == eBFTargetType.TT_FRIENT_RANDOM then  --随机队友(包含自己)
            local result =  self:getHost():getAreaFrineds(-1,nil,true)
            local unitNum   = data.unitNum
            while #result > unitNum do 
                table.remove(result,RandomGenerator.random(#result))
            end
            return result
        elseif effectTarget == eBFTargetType.TT_FRIENT_TEAM  then --队友包涵自己
            return self:getHost():getAreaFrineds(-1,nil,true)
        elseif effectTarget == eBFTargetType.TT_FRIENT_HERO then --友方 角色 
            local heros = self:getHost():getAreaFrineds(-1,nil,true)
            local result = {}
            for i,hero in ipairs(heros) do
                local roleType = hero:getRoleType() 
                if roleType == eRoleType.Hero 
                or roleType == eRoleType.Assist
                or roleType == eRoleType.Team then 
                    table.insert(result,hero)
                end
            end
            return result
        elseif effectTarget == eBFTargetType.TT_FRIENT_MONSTER then --友方 怪
            local heros = self:getHost():getCalls(-1,nil,1)
            local result = {}
            for i,hero in ipairs(heros) do
                table.insert(result,hero)
            end
            return result
        end
    else --作用于范围
        local unitNum     = data.unitNum
        local effectRange = data.effectRange
        local target = self:getCenterTarget(effectId)
        if effectTarget == eBFTargetType.TT_FRIENT  then --队友
            return target:getAreaFrineds(effectRange,unitNum)
        elseif effectTarget == eBFTargetType.TT_ENEMY  then --敌人
            return target:getAreaEnemys(effectRange,unitNum)
        elseif effectTarget == eBFTargetType.TT_FRIENT_TEAM  then --队友包涵自己
            return target:getAreaFrineds(effectRange,unitNum,true)
        elseif effectTarget == eBFTargetType.TT_FRIENT_HERO then --友方 角色 
            local heros = target:getAreaFrineds(effectRange,unitNum,true)
            local result = {}
            for i,hero in ipairs(heros) do
                local roleType = hero:getRoleType() 
                if roleType == eRoleType.Hero 
                or roleType == eRoleType.Assist
                or roleType == eRoleType.Team then 
                    table.insert(result,hero)
                end
            end
            return result
        elseif effectTarget == eBFTargetType.TT_FRIENT_MONSTER then --友方 怪
            local heros = target:getCalls(effectRange,unitNum,1)
            local result = {}
            for i,hero in ipairs(heros) do
                table.insert(result,hero)
            end
            return result
        else
            printError("作用于范围的生效对象类型错误"..tostring("data.objectType"))
        end
    end
end



--检查次要条件触发
function Buffer:checkTriggerCondition(target)
    local triggerType      = self.data.triggerType
    local triggerConditions = self.data.triggerCondition
    for i,triggerCondition in ipairs(triggerConditions) do
        if triggerType ~= triggerCondition then -- 主要事件类型和次要事件类型相同 认为检查通过
            if triggerCondition == eBFTriggerType.TT_ATTR then -- 属性变化
                if not self:checkTargetAttr(target) then
                    return false
                end
            elseif triggerCondition == eBFTriggerType.TT_STATE then  -- 状态类
                if not target:isAState(self.data.stateId) then
                    return false
                end
            else
                printError("not support triggerCondition id:"..self.data.id.." triggerType :"..tostring(triggerType)..
                    " triggerCondition"..string.format(triggerCondition))
            end
        end
    end
    return true
end

--检查目标状态
-- function Buffer:checkTargetState(target)
--     return target:isAState(self.data.stateId)
-- end

--检查目标属性是否满足
function Buffer:checkTargetAttr(target)
    local _attrTypes     = self.data.attributeId
    local _attrValues    = self.data.attributeNum
    local _attrContrasts = self.data.attributeContrast
    for index , _attrType in ipairs(_attrTypes) do
        _attrValue     = _attrValues[index]
        _attrContrast  = _attrContrasts[index]
        if _attrContrast == 1 then --高于
            if target:getValue(_attrType) <=  _attrValue then
                return false
            end
        elseif _attrContrast == 2 then --低于
            if target:getValue(_attrType) >=  _attrValue then
                return false
            end
        elseif _attrContrast == 3 then --等于
            if target:getValue(_attrType) ~=  _attrValue then
                return false
            end
        else
            return false
        end
    end
    return true
end



return Buffer


