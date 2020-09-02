-- 新大富翁任务视图
local DfwNewTaskView = class("DfwNewTaskView", BaseLayer)
local json = require("LuaScript.extends.json")

local TASK_FINISH_ID = 11040
--[[
    刷新任务
]]
local function onRefreshTaskView(self)
    local taskCfgs = {}
    local activityInfo = ActivityDataMgr2:getActivityInfo(self.activityID)
    if (activityInfo) then
        for i = 1, #activityInfo.items do
            local itemID = activityInfo.items[i]

            local itemCfg = TabDataMgr:getData("DfwTask", itemID)  
            if (itemCfg.finishCondId ~= TASK_FINISH_ID) then
                table.insert(taskCfgs, itemCfg)
            end
        end
    end

    self._taskCfgs = taskCfgs

    self:updateTaskView()
end

--[[
    前往完成任务
]]
local function onJumpFinishTask(self, taskCfg)
    FunctionDataMgr:enterByFuncId(taskCfg.jumpInterface, {})
end

--[[
    构造函数
]]
function DfwNewTaskView:ctor(activityID)
    DfwNewTaskView.super.ctor(self)

    self:initData(activityID)
    self:init("lua.uiconfig.dafuwong.dfwNewTaskView")
end

--[[
    初始化数据
]]
function DfwNewTaskView:initData(activityID)
    self.activityID = activityID

    local taskCfgs = {}
    local activityInfo = ActivityDataMgr2:getActivityInfo(self.activityID)
    if (activityInfo) then
        for i = 1, #activityInfo.items do
            local itemID = activityInfo.items[i]

            local itemCfg = TabDataMgr:getData("DfwTask", itemID)  
            if (itemCfg.finishCondId ~= TASK_FINISH_ID) then
                table.insert(taskCfgs, itemCfg)
            end
        end
    end

    self._taskCfgs = taskCfgs
    self._taskViews = {}
end

--[[
    初始化视图
]]
function DfwNewTaskView:initUI(ui)
    DfwNewTaskView.super.initUI(self, ui)

    local Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.Button_close = TFDirector:getChildByPath(Panel_root, "Button_close")

    self.ScrollView_tasks = TFDirector:getChildByPath(Panel_root, "ScrollView_tasks")
    self.Button_refresh = TFDirector:getChildByPath(Panel_root, "Button_refresh")
    self.Image_cost_icon = TFDirector:getChildByPath(Panel_root, "Image_cost_icon")
    self.Label_cost_num = TFDirector:getChildByPath(Panel_root, "Label_cost_num")

    self.Label_refreshTime = TFDirector:getChildByPath(Panel_root, "Label_refreshTime")

    local Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
    self.Panel_taskItem = TFDirector:getChildByPath(Panel_prefab, "Panel_task1")

    self.Image_reward_frame = TFDirector:getChildByPath(Panel_prefab, "Image_reward_frame")

    self:updateTaskView()
end

--[[
    初始化任务视图
]]
function DfwNewTaskView:createTaskView()
    local Panel_taskItem = self.Panel_taskItem:clone()

    local view = {}
    local Label_task_name = TFDirector:getChildByPath(Panel_taskItem, "Label_task_name")
    local Label_task_des = TFDirector:getChildByPath(Panel_taskItem, "Label_task_des")
    local Label_progress_value = TFDirector:getChildByPath(Panel_taskItem, "Label_progress_value")
    local Label_time = TFDirector:getChildByPath(Panel_taskItem, "Label_time")
    local Loading_bar = TFDirector:getChildByPath(Panel_taskItem, "LoadingBar")
    local Button_recv = TFDirector:getChildByPath(Panel_taskItem, "Button_rev")
    local Label_recv = TFDirector:getChildByPath(Panel_taskItem, "Label_recv")
    local Panel_award = TFDirector:getChildByPath(Panel_taskItem, "Panel_award")
    local Button_goto = TFDirector:getChildByPath(Panel_taskItem, "Button_goto")
    local scrollView = TFDirector:getChildByPath(Panel_award, "ScrollView_reward")

    view.root = Panel_taskItem
    view.Label_task_name = Label_task_name
    view.Label_task_des = Label_task_des
    view.Label_progress_value = Label_progress_value
    view.Label_time = Label_time
    view.Loading_bar = Loading_bar
    view.Button_recv = Button_recv
    view.Label_recv = Label_recv
    view.Button_goto = Button_goto
    view.ScrollView_reward = scrollView

    return view
end

--[[
    更新任务视图
]]
function DfwNewTaskView:updateTaskView()
    local innerWidth = 0
    local innerHeight = 0

    local oldInnerSize = self.ScrollView_tasks:getInnerContainerSize()

    for i = 1, #self._taskCfgs do
        local taskView = self._taskViews[i]
        if (not taskView) then taskView = self:createTaskView() end

        local taskCfg = self._taskCfgs[i]

        taskView.Label_task_name:setTextById(taskCfg.des1)
        taskView.Label_task_des:setTextById(taskCfg.des2)

        local progressInfo = ActivityDataMgr2:getProgressInfo(EC_ActivityType2.DFW_NEW, taskCfg.id)
        taskView.Label_progress_value:setString(progressInfo.progress.."/"..taskCfg.progress)

        local percent = math.min(progressInfo.progress/taskCfg.progress, 1)
        taskView.Loading_bar:setPercent(percent * 100)

        taskView.Button_recv:setTouchEnabled(true)
        taskView.Button_recv:setGrayEnabled(false)
        taskView.Label_recv:setVisible(false)

        taskView.Button_goto:setVisible(false)

        -- 未完成
        if (progressInfo.status == EC_TaskStatus.ING) then
            taskView.Button_recv:setVisible(false)

            taskView.Button_goto:setVisible(true)
        -- 可领取
        elseif (progressInfo.status == EC_TaskStatus.GET) then
            taskView.Button_recv:setVisible(true)
            taskView.Label_recv:setVisible(true)
            taskView.Label_recv:setTextById(1820002)
        -- 已领取
        elseif (progressInfo.status == EC_TaskStatus.GETED) then
            taskView.Button_recv:setTouchEnabled(false)
            taskView.Button_recv:setGrayEnabled(true)
            taskView.Label_recv:setVisible(true)
            taskView.Label_recv:setTextById(14220068)
            taskView.Label_recv:setFontColor(ccc3(185, 185, 185))
        end

        taskView.ScrollView_reward:removeAllChildren()

        local totalCount = 0
        for _, _ in pairs(taskCfg.reward) do
            totalCount = totalCount + 1
        end

        local count = 1
        local width = 0
        local oldSize = taskView.ScrollView_reward:getInnerContainerSize()
        local px = 135 - (totalCount - 1) * 45
        for id, num in pairs(taskCfg.reward) do
            px = px + (count - 1) * 90

            local panel = self.Image_reward_frame:clone()
            panel:setVisible(true)
            panel:setPosition(ccp(px, oldSize.height/2))
            taskView.ScrollView_reward:addChild(panel)

            local rewardView = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            PrefabDataMgr:setInfo(rewardView, id, num)
            rewardView:setPosition(0, 0)
            rewardView:setScale(0.7)
            panel:addChild(rewardView)

            count = count + 1
            width = width + 90
        end
        width = width > oldSize.width and width or oldSize.width
        taskView.ScrollView_reward:setInnerContainerSize(CCSize(width, oldSize.height))

        taskView.root:setPosition(ccp((i - 1) * 334, 0))

        if (not taskView.root:getParent()) then
            self.ScrollView_tasks:addChild(taskView.root)
        end

        innerWidth = innerWidth + 334
        table.insert(self._taskViews, taskView)
    end
    innerWidth = innerWidth - 55
    innerWidth = innerWidth > oldInnerSize.width and innerWidth or oldInnerSize.width
    innerHeight = oldInnerSize.height

    self.ScrollView_tasks:setInnerContainerSize(CCSize(innerWidth, innerHeight))

    local activityInfo = ActivityDataMgr2:getActivityInfo(self.activityID)
    if (activityInfo) then
        local refreshCostMap = activityInfo.extendData.refreshCost
        if (refreshCostMap) then
            dump(refreshCostMap)
            for itemID, num in pairs(refreshCostMap) do
                local itemCfg = TabDataMgr:getData("Item", tonumber(itemID))
                self.Image_cost_icon:setTexture(itemCfg.icon)
                self.Label_cost_num:setString(num)

                break
            end
        end
    end

    -- 定时刷新时间
    local onScheduleTimer = function()
        local serverTime = ServerDataMgr:getServerTime()
        local hour = 23 - tonumber(os.date("%H", serverTime))
        local minute = 60 - tonumber(os.date("%M", serverTime))
    
        local str1 = TextDataMgr:getText(302202)
        local str2 = TextDataMgr:getText(1260001, hour, minute)
        self.Label_refreshTime:setString(str1..str2)
    end
    onScheduleTimer()
    if (not self.timer) then
        self.timer = TFDirector:addTimer(1000, -1, nil, onScheduleTimer)
    end
end

--[[
    注册响应事件
]]
function DfwNewTaskView:registerEvents()
    EventMgr:addEventListener(self, EV_TASK_RECEIVE, handler(onRecviceReward, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(onRefreshTaskView, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(onRefreshTaskView, self))

    self.Button_refresh:onClick(function()
        DfwDataMgr:send_ZILLIONAIRE_REQ_REFRESH_TASK()
    end)

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    for i = 1, #self._taskViews do
        local view = self._taskViews[i]

        view.Button_recv:onClick(function()
            local cfg = self._taskCfgs[i]
            local progressInfo = ActivityDataMgr2:getProgressInfo(EC_ActivityType2.DFW_NEW, cfg.id)

            -- 任务奖励可领取
            if (progressInfo.status == EC_TaskStatus.GET) then
                ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityID, cfg.id)
            else
                print(string.format("DfwNewTaskView: the task id %s, status %s cant get", cfg.id, progressInfo.status))
            end
        end)

        view.Button_goto:onClick(function()
            local cfg = self._taskCfgs[i]

            onJumpFinishTask(self, cfg)
        end)
    end
end

--[[
    关闭的回调
]]
function DfwNewTaskView:onClose()
    if (self.timer) then TFDirector:removeTimer(self.timer) end

    DfwNewTaskView.super.onClose(self)
end

--[[
    显示任务奖励
]]
function DfwNewTaskView:onRecviceReward(rewards, taskCid)
    Utils:showReward(rewards)
end

return DfwNewTaskView