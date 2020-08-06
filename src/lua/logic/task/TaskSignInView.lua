
local TaskSignInView = class("TaskSignInView", BaseLayer)

function TaskSignInView:initData(index)
    index = index or 1
    self.defaultSelectIndex_ = index - 1
    self.signIntask_ = TaskDataMgr:getTask(EC_TaskType.SIGNIN)
    self.nextDayTask_ = TaskDataMgr:getTask(EC_TaskType.NEXTDAY)
    self.rewardItem_ = {}
    self.signInReward_ = {}
    self.signInGetRewardCount_ = 0

    self.signInCanGetList_ = {}
    for i, v in ipairs(self.signIntask_) do
        local taskInfo = TaskDataMgr:getTaskInfo(v)
        if taskInfo.status ==  EC_TaskStatus.GET then
            table.insert(self.signInCanGetList_, v)
        end
    end
end

function TaskSignInView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.task.taskSingInView")
end

function TaskSignInView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.PageView_task = TFDirector:getChildByPath(self.Panel_root, "PageView_task")

    self.Panel_signIn = TFDirector:getChildByPath(self.PageView_task, "Panel_signIn")
    self.Button_signInReceive = TFDirector:getChildByPath(self.Panel_signIn, "Button_signInReceive")
    self.Label_signInReceive = TFDirector:getChildByPath(self.Button_signInReceive, "Label_signInReceive")
    local ScrollView_reward = TFDirector:getChildByPath(self.Panel_signIn, "ScrollView_reward")
    self.ListView_reward = UIListView:create(ScrollView_reward)

    self.Panel_nextDay = TFDirector:getChildByPath(self.Panel_root, "Panel_nextDay")
    self.Button_nextDayReceive = TFDirector:getChildByPath(self.Panel_nextDay, "Button_nextDayReceive")
    self.Label_nextDayReceive = TFDirector:getChildByPath(self.Button_nextDayReceive, "Label_nextDayReceive")

    self.Button_left = TFDirector:getChildByPath(self.Panel_root, "Button_left")
    self.Button_right = TFDirector:getChildByPath(self.Panel_root, "Button_right")

    self.Panel_dot = {}
    for i = 1, 2 do
        local item = {}
        item.root = TFDirector:getChildByPath(self.Panel_root, "Panel_dot_" .. i)
        item.Image_normal = TFDirector:getChildByPath(item.root, "Image_normal")
        item.Image_select = TFDirector:getChildByPath(item.root, "Image_select")
        self.Panel_dot[i] = item
    end

    self.Panel_headItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_headItem")

    self:refreshView()
end

function TaskSignInView:refreshView()
    for i, v in ipairs(self.signIntask_) do
        local Panel_headItem = self:addRewardItem()
        self.ListView_reward:pushBackCustomItem(Panel_headItem)
        self:updateRewardItem(i)
    end
    self:updateReceiveInfo()
    self:updatePageStatus()

    dump(self.defaultSelectIndex_)
    self.PageView_task:scrollToPage(self.defaultSelectIndex_)
end

function TaskSignInView:updateReceiveInfo()
    local isCanGet = #self.signInCanGetList_ > 0
    self.Button_signInReceive:setGrayEnabled(not isCanGet)
    self.Button_signInReceive:setTouchEnabled(isCanGet)
    self.Label_signInReceive:setTextById(isCanGet and 1300008 or 1300015)

    local taskInfo = TaskDataMgr:getTaskInfo(self.nextDayTask_[1]) or {}
    local isCanGet = taskInfo.status == EC_TaskStatus.GET
    local isGeted = taskInfo.status == EC_TaskStatus.GETED
    self.Button_nextDayReceive:setVisible(isCanGet or isGeted)
    self.Button_nextDayReceive:setGrayEnabled(isGeted)
    self.Button_nextDayReceive:setTouchEnabled(isCanGet)
    self.Label_nextDayReceive:setTextById(isGeted and 1300015 or 1300008)
end

function TaskSignInView:updateRewardItem(index)
    local taskId = self.signIntask_[index]
    local taskCfg = TaskDataMgr:getTaskCfg(taskId)
    local taskInfo = TaskDataMgr:getTaskInfo(taskId)
    local Panel_headItem = self.ListView_reward:getItem(index)
    local item = self.rewardItem_[Panel_headItem]
    PrefabDataMgr:setInfo(item.Panel_goodsItem, taskCfg.reward[1][1], taskCfg.reward[1][2])
    item.Image_gou:setVisible(taskInfo.status == EC_TaskStatus.GETED)
    item.Panel_goodsItem:setGrayEnabled(taskInfo.status == EC_TaskStatus.GETED)
    item.Label_day:setTextById(taskCfg.name)
end

function TaskSignInView:addRewardItem()
    local Panel_headItem = self.Panel_headItem:clone()
    local item = {}
    item.root = Panel_headItem
    item.Label_day = TFDirector:getChildByPath(item.root, "Label_day")
    item.Image_gou = TFDirector:getChildByPath(item.root, "Image_gou")
    item.Panel_head = TFDirector:getChildByPath(item.root, "Panel_head")
    item.Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    item.Panel_goodsItem:Pos(0, 0):AddTo(item.Panel_head)
    self.rewardItem_[item.root] = item
    return Panel_headItem
end

function TaskSignInView:registerEvents()
    EventMgr:addEventListener(self, EV_TASK_UPDATE, handler(self.onTaskUpdateEvent, self))
    EventMgr:addEventListener(self, EV_TASK_RECEIVE, handler(self.onTaskReceiveEvent, self))

    self.Button_signInReceive:onClick(function()
            for i, v in ipairs(self.signInCanGetList_) do
                local taskInfo = TaskDataMgr:getTaskInfo(v)
                TaskDataMgr:send_TASK_SUBMIT_TASK(taskInfo.cid)
            end
    end)

    self.Button_nextDayReceive:onClick(function()
            local taskInfo = TaskDataMgr:getTaskInfo(self.nextDayTask_[1])
            TaskDataMgr:send_TASK_SUBMIT_TASK(taskInfo.cid)
    end)

    self.Button_left:onClick(function()
            local nextIndex = math.max(self.PageView_task:getCurPageIndex() - 1, 0)
            self.PageView_task:scrollToPage(nextIndex)
    end)

    self.Button_right:onClick(function()
            local nextIndex = math.max(self.PageView_task:getCurPageIndex() + 1, 0)
            self.PageView_task:scrollToPage(nextIndex)
    end)

    self.PageView_task:addMEListener(TFPAGEVIEW_CHANGED, function()
                                         self:updatePageStatus()
    end)
end

function TaskSignInView:updatePageStatus()
    local index = self.PageView_task:getCurPageIndex()
    local pageCount = self.PageView_task:getPageCount()
    self.Button_left:setVisible(index > 0)
    self.Button_right:setVisible(index < pageCount - 1)

    for i, v in ipairs(self.Panel_dot) do
        local index = self.PageView_task:getCurPageIndex()
        local isSelect = (index + 1 == i)
        v.Image_normal:setVisible(not isSelect)
        v.Image_select:setVisible(isSelect)
    end
end

function TaskSignInView:onTaskReceiveEvent(reward, taskCid)
    if table.indexOf(self.signInCanGetList_, taskCid) ~= -1 then
        self.signInGetRewardCount_ = self.signInGetRewardCount_ + 1
        table.insertTo(self.signInReward_, reward)

        if self.signInGetRewardCount_ == #self.signInCanGetList_ then
            self.signInCanGetList_ = {}
            Utils:showReward(self.signInReward_)
        end

        local index = table.indexOf(self.signIntask_, taskCid)
        if index ~= -1 then
            self:updateRewardItem(index)
            self:updateReceiveInfo()
        end
    else
        Utils:openView("summon.SummonGetHeroView", reward[1].id)
        self:updateReceiveInfo()
    end
end

return TaskSignInView
