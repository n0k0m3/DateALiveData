
local BaseDataMgr = import(".BaseDataMgr")
local TaskDataMgr = class("TaskDataMgr", BaseDataMgr)

function TaskDataMgr:init()
    TFDirector:addProto(s2c.TASK_RESP_TASKS, self, self.onRecvTask)
    TFDirector:addProto(s2c.TASK_RESULT_SUBMIT_TASK, self, self.onRecvSubmitTask)
	TFDirector:addProto(s2c.TASK_RESP_SUBMIT_TASK_LIST, self, self.onRecvSubmitTaskList)

    self.taskMap_ = TabDataMgr:getData("Task")
    self.BattlePass = TabDataMgr:getData("BattlePass")
    self.BattlePassLevel = TabDataMgr:getData("BattlePassLevel")
    self.taskInfo_ = {}
    self.tempValue_ = true
    self.tempValue2_ = true
end

function TaskDataMgr:reset()
    self.taskInfo_ = {}
    self.tempValue_ = true
    self.tempValue2_ = true
end

function TaskDataMgr:setTempValue(value)
    self.tempValue_ = value
end

function TaskDataMgr:getTempValue()
    return self.tempValue_
end

function TaskDataMgr:setTempValue2(value)
    self.tempValue2_ = value
end

function TaskDataMgr:getTempValue2()
    return self.tempValue2_
end

function TaskDataMgr:onLogin()
    TFDirector:send(c2s.TASK_REQ_TASKS, {})
    return {s2c.TASK_RESP_TASKS}
end

function TaskDataMgr:onEnterMain()

end

function TaskDataMgr:existTask(taskType)
    for k, v in pairs(self.taskInfo_) do
        local taskCfg = self:getTaskCfg(v.cid)
        if taskCfg and taskCfg.type == taskType then
            return true
        end
    end
end
function TaskDataMgr:getTask(taskType)
    local task = {}
    local rets = {}
    for k, v in pairs(self.taskInfo_) do
        if v.cid ~= 50001 then
            local taskCfg = self:getTaskCfg(v.cid)
            if not taskCfg then
                printError("taskCfg "..tostring(v.cid).." not found!")
            end
            if taskCfg and taskCfg.type == taskType then
                if v.status ~= EC_TaskStatus.GETED or taskCfg.completeResult ~= 1 then
                    table.insert(task, v)
                end
            end
        end
    end
    table.sort(task, function(a, b)
                   local cfgA = self:getTaskCfg(a.cid)
                   local cfgB = self:getTaskCfg(b.cid)
                   return cfgA.order < cfgB.order
    end)
    if taskType == EC_TaskType.ACTIVE or taskType == EC_TaskType.SIGNIN or taskType == EC_TaskType.DLS_CARD then
        for i, v in ipairs(task) do
            table.insert(rets, v.cid)
        end
    else
        local ing = {}
        local get = {}
        local geted = {}
        for i, v in ipairs(task) do
            if v.status == EC_TaskStatus.ING then
                table.insert(ing, v.cid)
            elseif v.status == EC_TaskStatus.GET then
                table.insert(get, v.cid)
            elseif v.status == EC_TaskStatus.GETED then
                table.insert(geted, v.cid)
            end
        end
        table.insertTo(rets, get)
        table.insertTo(rets, ing)
        table.insertTo(rets, geted)
    end
    return rets
end

function TaskDataMgr:getUnionFusionTask()
    local task = {}
    local rets = {}
    for k, v in pairs(self.taskInfo_) do
        if v.cid ~= 50001 then
            local taskCfg = self:getTaskCfg(v.cid)
            if not taskCfg then
                printError("taskCfg "..tostring(v.cid).." not found!")
            end
            if taskCfg and (taskCfg.type == EC_TaskType.FUSION_PERSONAL or taskCfg.type == EC_TaskType.FUSION_UNION) then
                if v.status ~= EC_TaskStatus.GETED or taskCfg.completeResult ~= 1 then
                    table.insert(task, v)
                end
            end
        end
    end
    table.sort(task, function(a, b)
                   local cfgA = self:getTaskCfg(a.cid)
                   local cfgB = self:getTaskCfg(b.cid)
                   return cfgA.order < cfgB.order
    end)
    local ing = {}
    local get = {}
    local geted = {}
    for i, v in ipairs(task) do
        if v.status == EC_TaskStatus.ING then
            table.insert(ing, v.cid)
        elseif v.status == EC_TaskStatus.GET then
            table.insert(get, v.cid)
        elseif v.status == EC_TaskStatus.GETED then
            table.insert(geted, v.cid)
        end
    end
    table.insertTo(rets, get)
    table.insertTo(rets, ing)
    table.insertTo(rets, geted)
    return rets
end

function TaskDataMgr:getTaskAllTypeCount(taskType)
    local ingCount, getCount, getedCount = 0, 0, 0
    local taskData = self:getTask(taskType)
    for i, v in ipairs(taskData) do
        local taskInfo = self:getTaskInfo(v)
        if taskInfo.status == EC_TaskStatus.ING then
            ingCount = ingCount + 1
        elseif taskInfo.status == EC_TaskStatus.GET then
            getCount = getCount + 1
        elseif taskInfo.status == EC_TaskStatus.GETED then
            getedCount = getedCount + 1
        end
    end
    return ingCount, getCount, getedCount
end

function TaskDataMgr:getTaskCountByCids(cidlist)
    local ingCount, getCount, getedCount = 0, 0, 0
    cidlist = cidlist or {}
    for i, v in ipairs(cidlist) do
        local taskInfo = self:getTaskInfo(v)
        if taskInfo then
            if taskInfo.status == EC_TaskStatus.ING then
                ingCount = ingCount + 1
            elseif taskInfo.status == EC_TaskStatus.GET then
                getCount = getCount + 1
            elseif taskInfo.status == EC_TaskStatus.GETED then
                getedCount = getedCount + 1
            end
        end
    end
    return ingCount, getCount, getedCount
end

function TaskDataMgr:isCanReceiveTask(taskType)
    local isCanReceive = false
    local taskData = self:getTask(taskType)
    for i, v in ipairs(taskData) do
        local taskInfo = self:getTaskInfo(v)
        --剔除百日登陆活动红点
        if taskInfo.status == EC_TaskStatus.GET and v~= 799000 then
            isCanReceive = true
            break
        end
    end
    return isCanReceive
end

function TaskDataMgr:isShowRedPointInOSDView()
    local isOpen = FunctionDataMgr:isOpen(23)
    local isShow = false
    if isOpen then
        local taskType = {
            EC_TaskType.EVERY_DAY ,    -- 每日任务
            EC_TaskType.EVERY_WEEK     -- 每周任务
        }
        for i, v in ipairs(taskType) do
            if self:isCanReceiveTask(v) then
                isShow = true
                break
            end
        end
    end
    return isShow
end

function TaskDataMgr:isShowRedPointInMainView()
    local isOpen = FunctionDataMgr:isOpen(23)
    local isShow = false
    if isOpen then
        local taskType = {
            EC_TaskType.MAIN,
            EC_TaskType.DAILY,
            EC_TaskType.HONOR,
            EC_TaskType.ACTIVITY,
            EC_TaskType.ACTIVE,
        }
        for i, v in ipairs(taskType) do
            if self:isCanReceiveTask(v) then
                isShow = true
                break
            end
        end
    end
    return isShow
end

function TaskDataMgr:getMaxActive()
    local activeTask = self:getTask(EC_TaskType.ACTIVE)
    local taskCfg = self:getTaskCfg(activeTask[#activeTask])
    return taskCfg.progress
end

function TaskDataMgr:getTaskInfo(cid)
    return self.taskInfo_[cid]
end

function TaskDataMgr:getTaskCfgByType(taskType)
    local ret = {}
    for k,v in pairs(self.taskMap_) do
        if v.type == taskType then
            table.insert(ret,v)
        end
    end
    return ret
end

function TaskDataMgr:getTaskCfg(cid)
    return self.taskMap_[cid]
end

function TaskDataMgr:getTaskDesc(cid)
    local taskCfg = self:getTaskCfg(cid)
    local desc = ""
    if taskCfg.subType == EC_TaskSubType.LEVEL then
        local levelId = taskCfg.finishParams["dunId"]
        local levelCfg = FubenDataMgr:getLevelCfg(levelId)
        local levelGroupCfg = FubenDataMgr:getLevelGroupCfg(levelCfg.levelGroupId)
        local chapterName = FubenDataMgr:getChapterOrderName(levelGroupCfg.dungeonChapterId)
        local diffName = TextDataMgr:getText(EC_FBDiffName[levelCfg.difficulty])
        local levelName = FubenDataMgr:getLevelName(levelId)
        desc = TextDataMgr:getText(taskCfg.des, chapterName, diffName, levelName)
    else
        desc = TextDataMgr:getText(taskCfg.des)
    end
    return desc
end

function TaskDataMgr:send_TASK_SUBMIT_TASK(taskCid)
    TFDirector:send(c2s.TASK_SUBMIT_TASK, {taskCid})
end

function TaskDataMgr:send_TASK_SUBMIT_TASK_LIST(taskTab)
    TFDirector:send(c2s.TASK_SUBMIT_TASK_LIST, {taskTab})
end


function TaskDataMgr:onRecvTask(event)
    local data = event.data
    if not data.taks then return end
    for i, v in ipairs(data.taks) do
        local taskCfg = self:getTaskCfg(v.cid)
        if v.ct == EC_SChangeType.DEFAULT then
            self.taskInfo_[v.cid] = v
        else
            if v.ct == EC_SChangeType.ADD then
                self.taskInfo_[v.cid] = v
            elseif v.ct == EC_SChangeType.UPDATE then
                self.taskInfo_[v.cid] = v
            elseif v.ct == EC_SChangeType.DELETE then
                self.taskInfo_[v.cid] = nil
            end
            EventMgr:dispatchEvent(EV_TASK_UPDATE, v.cid)
        end
    end
end

function TaskDataMgr:onRecvSubmitTask(event)
    local data = event.data
    EventMgr:dispatchEvent(EV_TASK_RECEIVE, data.rewards, data.taskCid)
end

function TaskDataMgr:onRecvSubmitTaskList(event)
	local data = event.data
    EventMgr:dispatchEvent(EV_TASK_RECEIVE_LIST, data.rewards, data.result)
end

function TaskDataMgr:getTraningCfgs(group)
    local cfgs = {}
    local tempCfgs = {}
    for k,v in pairs(self.BattlePass) do
        if group then
            local conditionCfg = cfgs[v.condition] or {}
            table.insert(conditionCfg,v)
            cfgs[v.condition] = conditionCfg
        else
            table.insert(cfgs,v)
        end
    end
    return cfgs
end

function TaskDataMgr:getTraningSpecialRewards(ptype)
    local rewards = {}
    for k,v in pairs(self.BattlePass) do
        if v.type == ptype and v.special == 1 then
            local data = v.reward
            for i, info in ipairs(data) do
                rewards[info[1]] = rewards[info[1]] or 0
                rewards[info[1]] = rewards[info[1]] + info[2]
            end
        end
    end
    local sortData = {}
    for k, v in pairs(rewards) do
        table.insert(sortData, {tonumber(k), v})
    end
    table.sort(sortData, function(a, b)
        return a[1] < b[1]
    end)
    return sortData
end

function TaskDataMgr:getTrainingLevelExpMax(level)
    for k,v in pairs(self.BattlePassLevel) do
        if v.level == level then
            return v.exp
        end
    end
    return 10
end

function TaskDataMgr:getTrainingUpLevelCost(endLevel)
    local curLevel = ActivityDataMgr2:getWarOrderLevel()
    local addExp = 0
    for i=curLevel, endLevel - 1 do
        local needExp = self:getTrainingLevelExpMax(i)
        addExp = addExp + needExp
    end
    addExp = addExp - ActivityDataMgr2:getWarOrderExp()
    local levelCost = ActivityDataMgr2:getWarOrderUpLevelCost()
    local cost = math.floor(levelCost * addExp / 10)
    return cost,addExp
end

function TaskDataMgr:getLevelRangeRewards(startLevel, endLevel)
    local chargeState = ActivityDataMgr2:getWarOrderChargeState()
    local rewards = {}
    for k,v in pairs(self.BattlePass) do
        if v.condition >= startLevel and v.condition <= endLevel then
            if v.type == 1 or (v.type == 2 and chargeState ~= 0) then
                local data = v.reward
                for i, info in ipairs(data) do
                    rewards[info[1]] = rewards[info[1]] or 0
                    rewards[info[1]] = rewards[info[1]] + info[2]
                end
            end
        end
    end
    local sortData = {}
    for k, v in pairs(rewards) do
        table.insert(sortData, {tonumber(k), v})
    end
    table.sort(sortData, function(a, b)
        return a[1] < b[1]
    end)
    return sortData
end

function TaskDataMgr:getSpecialRewards(idx)
    local specialInfo = {rewards = {}}
    local subLevel1 = 1000
    local subLevel2 = 1000
    for k,v in pairs(self.BattlePass) do
        if v.type == 1 then
            if v.special == 1 and (v.condition - idx) > 0 then
                if v.condition - idx < subLevel1 then
                    subLevel1 = v.condition - idx
                    if #v.reward > 0 then
                        specialInfo.level = v.condition
                        specialInfo.rewards[1] = v.reward[1]
                    end
                end
            end
        else
            if v.special == 1 and (v.condition - idx) > 0 then
                if v.condition - idx < subLevel2 then
                    subLevel2 = v.condition - idx
                    if #v.reward > 0 then
                        specialInfo.level = v.condition
                        specialInfo.rewards[2] = v.reward[1]
                    end
                end
            end
        end
        
    end
    return specialInfo
end

function TaskDataMgr:getTrainingCanGetRewards(ptype)
    local rewards = {}
    local trainingLevel = ActivityDataMgr2:getWarOrderLevel()
    for k, v in pairs(self.BattlePass) do
        if v.type == ptype and trainingLevel >= v.condition then
            if ActivityDataMgr2:checkWarOrderItemState(v.id) ~= 2 then
                local data = v.reward
                for i, info in ipairs(data) do
                    rewards[info[1]] = rewards[info[1]] or 0
                    rewards[info[1]] = rewards[info[1]] + info[2]
                end
            end
        end
    end
    local sortData = {}
    for k, v in pairs(rewards) do
        table.insert(sortData, {tonumber(k), v})
    end
    table.sort(sortData, function(a, b)
        return a[1] < b[1]
    end)
    return sortData
end

function TaskDataMgr:checkWarOrderRedPoint()
    local curLevel = ActivityDataMgr2:getWarOrderLevel()
    local state = ActivityDataMgr2:getWarOrderChargeState()
    for k,v in pairs(self.BattlePass) do
        if curLevel >= v.condition and v.reward[1] then
            if v.type == 1 or (v.type == 2 and state ~= 0) then
                local state = ActivityDataMgr2:checkWarOrderItemState(v.id)
                if state == 1 then
                    return true
                end
            end
        end
    end
    return false
end

function TaskDataMgr:getTrainingShopTipsState()
    local state = false
    if not ActivityDataMgr2:isWarOrderActivityOpen() then
        return state
    end
    local warOrderActivity = ActivityDataMgr2:getWarOrderAcrivityInfo()
    local pid = MainPlayer:getPlayerId()
    pid = pid or ""
    local trainingShopTips = CCUserDefault:sharedUserDefault():getStringForKey("training_shop_tips_" ..pid)
    if trainingShopTips ~= "geted" then
        state = true
    end
    local trainingTaskData = ActivityDataMgr2:getItems(warOrderActivity.id)
    local itemInfo
    local progressInfo
    for i,v in ipairs(trainingTaskData) do
        if tonumber(warOrderActivity.extendData.daytask) == v then
            itemInfo = ActivityDataMgr2:getItemInfo(warOrderActivity.activityType, v)
            break
        end
    end
    if itemInfo then
        progressInfo = ActivityDataMgr2:getProgressInfo(warOrderActivity.activityType, itemInfo.id)
        if progressInfo.status == EC_TaskStatus.GET then
            state = true
        end
    end
    return state
end

return TaskDataMgr:new()
