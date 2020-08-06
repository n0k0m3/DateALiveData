local BattleUtils = import(".BattleUtils")
local levelParse = import(".LevelParse")
local BattleTimerManager = import(".BattleTimerManager")
local enum = import(".enum")
local eDir = enum.eDir
local eAttrType  = enum.eAttrType

local AIAgent

local BaseNode = class("BaseNode")

function BaseNode:ctor(id, agent)
    self.id_ = id
    self.agent_ = agent
    self.cfg_ = self.agent_:getNodeCfg(id)
    self.link_ = self.agent_:getLink(id)
    self.host_ = self.agent_:getHost()
    self.entryFlag_ = false
    self.extraArgs_ = {}
end

function BaseNode:init()
    self.linkNode_ = {}
    for i, v in ipairs(self.link_) do
        local node = self.agent_:getNode(v)
        self.linkNode_[i] = node
    end

    self:onEnter()
end

function BaseNode:onEnter()

end

function BaseNode:execute(...)
    self.entryFlag_ = true
    self:onExecute(...)
end

function BaseNode:onExecute()

end

function BaseNode:update(...)
    self:onUpdate(...)
end

function BaseNode:onUpdate()

end

function BaseNode:getLinkNode()
    return self.linkNode_
end

function BaseNode:getExtraArgs()
    local args = clone(self.extraArgs_)
    self.extraArgs_ = {}
    return args
end

--------------------------------------------------------------------------

local NodeFactory = {}

local function myClass(...)
    local c = class(...)
    NodeFactory[c.__cname] = c
    return c
end

--------------------------------------------------------------------------

-- 根节点
local RootNode = myClass("RootNode", BaseNode)

function RootNode:onEnter()
    table.sort(self.linkNode_, function(a, b)
                   return a.cfg_.Priority > b.cfg_.Priority
    end)
end

function RootNode:onExecute()
    for i, v in ipairs(self.linkNode_) do
        v:execute()
    end
end

function RootNode:onUpdate()
    if not self.entryFlag_ then return end
    local activeChiildNode = self.agent_:getActiveChildNode()
    if activeChiildNode then return end

    for i, v in ipairs(self.linkNode_) do
        if v:tryCond() then
            local bevNode = v:getBevNode()
            if bevNode then
                self.agent_:setAcitveChildNode(v)
                bevNode:execute()
                break
            end
        end
    end
end

-- 条件节点
local ChildNode = myClass("ChildNode", BaseNode)

function ChildNode:updateDuration()
    local interval = self.cfg_.DurationInterval or {0, 0}
    self.duration_ = self.cfg_.Duration + RandomGenerator.random(unpack(interval))
end

function ChildNode:onEnter()
    self.timing_ = 0
    self.isCd_ = true
    self.count_ = 0
    self:updateDuration()
end

function ChildNode:countPlusOne()
    self.count_ = self.count_ + 1
    if self.cfg_.Loop > 0 then
        if self.count_ >= self.cfg_.Loop then
            self.entryFlag_ = false
        end
    end
end

function ChildNode:tryCond()
    if self.isCd_ then return false end
    if not self.entryFlag_ then return false end

    local rets = {}
    for i, v in ipairs(self.linkNode_) do
        local r = v:execute()
        rets[i] = r
    end
    if self.cfg_.TriggerType == 0 then    -- 满足一个
        local index = table.indexOf(rets, true)
        return index ~= -1
    else    -- 满足所有
        local index = table.indexOf(rets, false)
        return index == -1
    end
end

function ChildNode:getBevNode()
    local bevNode
    for i, v in ipairs(self.linkNode_) do
        local linkNode = v:getLinkNode()
        bevNode = linkNode[1]
        break
    end
    return bevNode
end

function ChildNode:onUpdate(dt)
    if not self.entryFlag_ then return end
    if not self.isCd_ then return end

    self.timing_ = self.timing_ + dt
    if self.timing_ >= self.duration_ then
        self.isCd_ = false
        self:updateDuration()
    end
end

function ChildNode:reset()
    self.timing_ = 0
    self.isCd_ = true
end

-- 顺序行为节点
local OrderBevNode = myClass("OrderBevNode", BaseNode)

function OrderBevNode:onEnter()

end

function OrderBevNode:onExecute()
    self.agent_:setCurRate(self.link_[1])
end

-- 随机行为节点
local RandomBevNode = myClass("RandomBevNode", BaseNode)

function RandomBevNode:onEnter()
    self.weight_ = {}
    for i, v in ipairs(self.link_) do
        local cfg = self.agent_:getNodeCfg(v)
        table.insert(self.weight_, cfg.Weight)
    end
end

function RandomBevNode:onExecute()
    local index = BattleUtils.randomProbability(self.weight_)
    self.agent_:setCurRate(self.link_[index])
end

--------------------------------------------------------------------------

-- 进入战斗超过一定时间
local ConditionInFightTimeoutNode = myClass("ConditionInFightTimeoutNode", BaseNode)

function ConditionInFightTimeoutNode:execute()
    local showTiming = self.host_:getShowTiming()
    local rets = showTiming >= self.cfg_.Duration
    return rets
end

-- 自身血量低于
local ConditionSelfHPLessNode = myClass("ConditionSelfHPLessNode", BaseNode)

function ConditionSelfHPLessNode:execute()
    local hp = self.host_:getHpPercent()
    return hp <= self.cfg_.Percent * 100
end

-- 和其他目标距离
local ConditionTargetDistanceNode = myClass("ConditionTargetDistanceNode", BaseNode)

function ConditionTargetDistanceNode:execute()
    local rets = false
    local target = self.host_:findTarget()
    if target then
        local targetPos = target:getPosition()
        local hostPos = self.host_:getPosition()
        local offsetX = math.abs(targetPos.x - hostPos.x)
        local offsetY = math.abs(targetPos.y - hostPos.y)
        rets = offsetX >= self.cfg_.RangeX[1] and offsetX <= self.cfg_.RangeX[2]
        rets = rets and (offsetY >= self.cfg_.RangeY[1] and offsetY <= self.cfg_.RangeY[2])
    end
    return rets
end

-- 在当前范围内有敌人
local ConditionRangeHaveEnemyNode = myClass("ConditionRangeHaveEnemyNode", BaseNode)

function ConditionRangeHaveEnemyNode:execute()
    local rect = me.rect(self.cfg_.RangeOrigin.x, self.cfg_.RangeOrigin.y, self.cfg_.RangeSize.width, self.cfg_.RangeSize.height)
    local enemy = self.host_:getFixedScopeEnemy(rect)
    return #enemy > 0
end

-- 场上敌人多于特定数量
local ConditionEnemyAliveNode = myClass("ConditionEnemyAliveNode", BaseNode)

function ConditionEnemyAliveNode:execute()
    local enemys = self.host_:getFixedScopeEnemy()
    local rets = false
    if self.cfg_.Operator == 1 then
        rets = #enemys <= self.cfg_.EnemyNum
    else
        rets = #enemys >= self.cfg_.EnemyNum
    end
    return rets
end

-- 与玩家距离
local ConditionPlayerDistanceNode = myClass("ConditionPlayerDistanceNode", BaseNode)

function ConditionPlayerDistanceNode:execute()
    local captain = battleController.getCaptain()
    local rets = false
    if captain then
        local targetPos = captain:getPosition()
        local hostPos = self.host_:getPosition()
        local distanceX = math.abs(targetPos.x - hostPos.x)
        local distanceY = math.abs(targetPos.y - hostPos.y)
        if self.cfg_.OperatorX == 1 then
            rets = (distanceX <= self.cfg_.DistanceX - levelParse:getBlockSize())
            -- rets = (distanceX <= self.cfg_.DistanceX)
        else
            rets = (distanceX >= self.cfg_.DistanceX + levelParse:getBlockSize())
            -- rets = (distanceX >= self.cfg_.DistanceX)
        end
        if self.cfg_.OperatorY == 1 then
            rets = rets or (distanceY <= self.cfg_.DistanceY - levelParse:getBlockSize())
        else
            rets = rets or (distanceY >= self.cfg_.DistanceY + levelParse:getBlockSize())
        end
    end
    return rets
end

-- 是否处于某一形态
local ConditionModelIndex = myClass("ConditionModelIndex", BaseNode)

function ConditionModelIndex:execute()
    local modelIndex = self.host_:getActionIndex()
    local rets = modelIndex == self.cfg_.ModelIndex
    return rets
end

-- 属性是否满足特定条件
local ConditionPropertyNode= myClass("ConditionPropertyNode", BaseNode)

function ConditionPropertyNode:execute()
    local getFunc = {
        [eAttrType.ATTR_NOW_AGR] = self.host_.getAngerPercent,
        [eAttrType.ATTR_NOW_HP] = self.host_.getHpPercent,
        [eAttrType.ATTR_NOW_SLD] = self.host_.getShieldPercent,
        [eAttrType.ATTR_NOW_RST] = self.host_.getResistPercent_,
    }
    local rets = false
    if getFunc[self.cfg_.Property] then
        local value = getFunc[self.cfg_.Property](self.host_)
        if self.cfg_.Judge == 1 then
            rets = value < self.cfg_.Value
        elseif self.cfg_.Judge == 2 then
            rets = value == self.cfg_.Value
        elseif self.cfg_.Judge == 3 then
            rets = value > self.cfg_.Value
        end
    end
    return rets
end

-- 场上敌人数量是否已经满足
local ConditionEnemyNumNode= myClass("ConditionEnemyNumNode", BaseNode)

function ConditionEnemyNumNode:execute()
    local enemy = self.host_:getFixedScopeEnemy()
    local num = 0
    for i, v in ipairs(enemy) do
        local data = v:getData()
        if data.id == self.cfg_.EnemyID then
            num = num + 1
        end
    end

    if self.cfg_.Judge == 1 then
        return num < self.cfg_.EnemyNum
    elseif self.cfg_.Judge == 2 then
        return num == self.cfg_.EnemyNum
    elseif self.cfg_.Judge == 3 then
        return num > self.cfg_.EnemyNum
    end
end

-- 场上怪物多于特定数量
local ConditionMonsterAliveNode = myClass("ConditionMonsterAliveNode", BaseNode)

function ConditionMonsterAliveNode:execute()
    local enemys = battleController.getEnemyMember()
    local rets = false
    if self.cfg_.Operator == 1 then
        rets = #enemys <= self.cfg_.EnemyNum
    else
        rets = #enemys >= self.cfg_.EnemyNum
    end
    return rets
end

-- 当前位置是否处于行走面
local ConditionIsOnWalkingSurfaceNode = myClass("ConditionIsOnWalkingSurfaceNode", BaseNode)

function ConditionIsOnWalkingSurfaceNode:execute()
    local rets = self.host_:isOnWalkingSurface()
    if self.cfg_.Operator == 1 then
    elseif self.cfg_.Operator == 2 then
        rets = not rets
    end
    return rets
end

-- 全局变量条件判断
local ConditionAssociationNode = myClass("ConditionAssociationNode", BaseNode)

function ConditionAssociationNode:execute()
    local value = self.agent_:_getGlobalVariable(self.cfg_.Key)
    if self.cfg_.Judge == 1 then
        return value < self.cfg_.Value
    elseif self.cfg_.Judge == 2 then
        return value == self.cfg_.Value
    elseif self.cfg_.Judge == 3 then
        return value > self.cfg_.Value
    end
end

-- 全局变量条件判断（配置）
local ConfigAssociationConditionNode = myClass("ConfigAssociationConditionNode", BaseNode)

function ConfigAssociationConditionNode:execute()
    local data = self.host_:getCurForm():getData()
    local value = self.agent_:_getGlobalVariable(data.monsterType)
    return self.cfg_.Type == data.monsterType and value < data.atkNumberMax
end

--------------------------------------------------------------------------
-- 施放技能
local ReleaseSkillBevNode = myClass("ReleaseSkillBevNode", BaseNode)

function ReleaseSkillBevNode:onExecute()
    self.host_:act_useSkill(self.cfg_.ID)
end

-- 巡逻
local PatrolBevNode = myClass("PatrolBevNode", BaseNode)

function PatrolBevNode:onExecute()
    self.host_:act_patrol(self.cfg_.TriggerType, self.cfg_.WalkDistance, self.cfg_.WalkWeight, self.cfg_.RunWeight)
end

-- 寻路
local PathfindingBevNode = myClass("PathfindingBevNode", BaseNode)

function PathfindingBevNode:onExecute()
    local range = {
        self.cfg_.RangeOrigin.x,
        self.cfg_.RangeOrigin.y,
        self.cfg_.RangeSize.width,
        self.cfg_.RangeSize.height,
    }
    self.host_:act_pathFinding(range, self.cfg_.LimitArea, self.cfg_.WalkDistance, self.cfg_.WalkWeight, self.cfg_.RunWeight, self.cfg_.FixTarget)
end

-- 跟随
local FollowBevNode = myClass("FollowBevNode", BaseNode)

function FollowBevNode:onExecute()
    local target = battleController:getCaptain()
    self.host_:act_follow(target, self.cfg_.Distance)
end

-- 切换形态
local SwitchModelBevNode = myClass("SwitchModelBevNode", BaseNode)

function SwitchModelBevNode:onExecute()
    self.host_:act_switchModel(self.cfg_.ModelIndex)
end

-- 延时
local DelayBevNode = myClass("DelayBevNode", BaseNode)

function DelayBevNode:onExecute()
    self.host_:act_delay(self.cfg_.DelayTime)
end

-- 设置位置
local ChangeSelfPositionBevNode = myClass("ChangeSelfPositionBevNode", BaseNode)

function ChangeSelfPositionBevNode:onExecute()
    self.host_:act_setPosition(self.cfg_.Operation, self.cfg_.Position)
end

-- 修改血量
local ChangeSelfHPBevNode = myClass("ChangeSelfHPBevNode", BaseNode)

function ChangeSelfHPBevNode:onExecute()
    self.host_:act_setHpPercent(self.cfg_.Percent)
end

-- 自身销毁
local KillMySelfBevNode = myClass("KillMySelfBevNode", BaseNode)

function KillMySelfBevNode:onExecute()
    self.host_:act_killMySelf(self.cfg_.IsCount == 1)
end

-- 播放特效
local PlayEffectBevNode = myClass("PlayEffectBevNode", BaseNode)

function PlayEffectBevNode:onExecute()
    self.host_:act_playEffect(self.cfg_.Type,
                              self.cfg_.EffectName,
                              self.cfg_.AnimationName,
                              self.cfg_.Order,
                              self.cfg_.LoopTime,
                              self.cfg_.Scale)
end

-- 触发buffer
local TriggerBufferBevNode = myClass("TriggerBufferBevNode", BaseNode)

function TriggerBufferBevNode:onExecute()
    self.host_:act_triggetBuffer(self.cfg_.BufferID)
end

-- 设置朝向
local ChangeDirBevNode = myClass("ChangeDirBevNode", BaseNode)

function ChangeDirBevNode:onExecute()
    if self.cfg_.Dir == 1 then
        self.host_:act_setDir(eDir.LEFT)
    else
        self.host_:act_setDir(eDir.RIGHT)
    end
end

-- 设置关卡编辑器状态
local ModifyLevelEditorStateBevNode = myClass("ModifyLevelEditorStateBevNode", BaseNode)

function ModifyLevelEditorStateBevNode:onExecute()
    local toggle = self.cfg_.Toggle == 1
    EventMgr:dispatchEvent(EV_AI_MODIFY_LEVELEDITOR_EVENT, self.cfg_.ID, toggle)
    self.agent_:next()
end

-- 移动到某个位置
local MoveToBevNode = myClass("MoveToBevNode", BaseNode)

function MoveToBevNode:onExecute()
    local position = ccp(0, 0)
    if self.cfg_.MovePosWay == 1 then
        local nodeInfo = levelParse:getVisualNode(self.cfg_.MoveSite)
        position = ccp(nodeInfo.Position.X, nodeInfo.Position.Y)
    elseif self.cfg_.MovePosWay == 2 then
        position = self.cfg_.MovePos
    end
    self.host_:act_moveToPositon(position, self.cfg_.MoveSpeedScale / 100)
end

-- 设置全局变量增值
local AssociationBevNode = myClass("AssociationBevNode", BaseNode)

function AssociationBevNode:onExecute()
    self.agent_:_alterGlobalVariable(self.cfg_.Key, self.cfg_.AddValue)
    self.agent_:next()
    if self.cfg_.DelayTime > 0 then
        BattleTimerManager:addTimer(
            self.cfg_.DelayTime, 1,
            function()
                self.agent_:_alterGlobalVariable(self.cfg_.Key, -1 * self.cfg_.AddValue)
            end
        )
    end
end

-- 释放技能（配置）
local ConfigReleaseSkillBevNode = myClass("ConfigReleaseSkillBevNode", BaseNode)

function ConfigReleaseSkillBevNode:onExecute(skillCid)
    self.host_:act_useSkill(skillCid)
end

-- 巡逻(配置)
local ConfigPatrolBevNode = myClass("ConfigPatrolBevNode", BaseNode)

function ConfigPatrolBevNode:onExecute()
    self.host_:act_patrol(2, 0, 0, 0)
end

-- 寻路(配置)
local ConfigPathfindingBevNode = myClass("ConfigPathfindingBevNode", BaseNode)

function ConfigPathfindingBevNode:onExecute()
    local data = self.host_:getCurForm():getData()
    local index = BattleUtils.randomProbability(data.skillWeight)
    local skillCid = data.skills[index]
    self.extraArgs_ = {skillCid}
    local skillRoller = data["skillRoller" .. index]
    if skillRoller then
        local range = {select(2, unpack(skillRoller))}
        self.host_:act_pathFinding(range, skillRoller[1], 0, 0, 0, 0)
    else
        Box(string.format("技能范围配置错误(技能ID:%s", skillCid))
    end
end

--------------------------------------------------------------------------

AIAgent = class("AIAgent")
AIAgent.enabled = true
AIAgent.__global_variable = {}

function AIAgent:ctor(host,AI)
    self.enabledEx = false
    local heroData = host:getData()
    local monsterCid = heroData.id
    local aiPath = string.format("lua.ai.ai_%s", AI)
    local aiData
    local status, retval = pcall(function()
            return require(aiPath)
    end)
    if not status then
        Utils:showTips(2100120, monsterCid)
        return
    end
    self.host_ = host
    self.nodes_ = retval.nodes
    self.links_ = retval.links
    -- self:setCurRate(retval.root)
    self:createNode()
    self.root_ = self.nodeMap_[retval.root]
    self.root_:execute()
end

function AIAgent:createNode()
    self.nodeMap_ = {}
    for k, v in pairs(self.nodes_) do
        -- print(v.Class)
        local cfg = self:getNodeCfg(k)
        local node = NodeFactory[cfg.Class]:new(k, self)
        self.nodeMap_[k] = node
    end

    for k, v in pairs(self.nodeMap_) do
        v:init()
    end

    self.updateNode_ = {}
    for k, v in pairs(self.nodeMap_) do
        if v.class.__cname == "ChildNode" then
            self.updateNode_[v] = true
        end
    end
end

function AIAgent:getNodeCfg(id)
    return self.nodes_[id]
end

function AIAgent:getLink(id)
    return self.links_[id] or {}
end

function AIAgent:getNode(id)
    return self.nodeMap_[id]
end

function AIAgent:getHost()
    return self.host_
end

function AIAgent:setAcitveChildNode(node)
    if self.activeChiildNode_ then
        self.activeChiildNode_:reset()
    end

    self.activeChiildNode_ = node
    if self.activeChiildNode_ then
        self.activeChiildNode_:countPlusOne()
    end
end

function AIAgent:getActiveChildNode()
    return self.activeChiildNode_
end

function AIAgent:setCurRate(id)
    local args = {}
    if self.curRate_ then
        local node = self:getNode(self.curRate_)
        args = node:getExtraArgs()
    end

    self.curRate_ = id
    local node = self:getNode(id)
    node:execute(unpack(args))
end

function AIAgent:getCurRate()
    return self.curRate_
end

function AIAgent:setPreRate(id)
    self.preRate_ = id
end

function AIAgent:next()
    if not self.activeChiildNode_ then return end
    local link = self:getLink(self.curRate_)
    if link[1] then
        self:setCurRate(link[1])
    else
        self:endToActiveChildNode()
    end
end

function AIAgent:endToActiveChildNode()
    self:setAcitveChildNode(nil)
end

function AIAgent:update(...)
    if AIAgent.enabled or self.enabledEx then
        for node, enable in pairs(self.updateNode_) do
            if enable then
                node:update(...)
            end
        end

        if self.root_ then
            self.root_:update(...)
        end
    end
end

function AIAgent:setEnabled(value)
    AIAgent.enabled = value
end

function AIAgent:isEnabled()
    return AIAgent.enabled
end

function AIAgent:setEnabledEX(value)
    self.enabledEx = value
end

function AIAgent:reset()
    AIAgent.__global_variable = {}
end

function AIAgent:_alterGlobalVariable(key, addValue)
    local value = AIAgent.__global_variable[key] or 0
    value = value + addValue
    AIAgent.__global_variable[key] = value
end

function AIAgent:_getGlobalVariable(key)
    local value = AIAgent.__global_variable[key] or 0
    return value
end


return AIAgent
