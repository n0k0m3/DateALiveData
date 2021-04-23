local NianshowTaskView = class("NianshowTaskView",BaseLayer)


function NianshowTaskView:initData()
    
end

function NianshowTaskView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:setUsepreProcesUI()
    self:init("lua.uiconfig.activity.nianshowTaskView")
end

function NianshowTaskView:initUI(ui)
    self.super.initUI(self, ui)

    self.taskView = UIListView:create(self._ui.taskView)
    self.taskView:setItemsMargin(5)

    self.taskItems = {}
    self:refreshView()
end

function NianshowTaskView:registerEvents()
    EventMgr:addEventListener(self, EV_TASK_RECEIVE, handler(self.onTaskGetRewardBack, self))

    self._ui.btnClose:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

function NianshowTaskView:onTaskGetRewardBack(reward)
    if reward then
        Utils:showReward(reward)
    end
    self:refreshView()
end

function NianshowTaskView:addTaskItem()
    local taskItem = self._ui.taskItem:clone()
    local tab = {}
    tab.root = taskItem
    tab.bg = taskItem:getChildByName("bg")
    tab.itemLabTip = taskItem:getChildByName("itemLabTip")
    tab.labProcesShow = tab.itemLabTip:getChildByName("labProcesShow")
    tab.rewards = taskItem:getChildByName("rewards")
    tab.btnComplete = taskItem:getChildByName("btnComplete")
    tab.Image_not_complete = taskItem:getChildByName("Image_not_complete")
    tab.Image_not_complete:hide()
    tab.label_geted = taskItem:getChildByName("label_geted")
    tab.label_geted:hide()
    self.taskItems[tab.root] = tab
    return taskItem
end

function NianshowTaskView:refreshView()
    self.task_ = TaskDataMgr:getTask(EC_TaskType.NIANSHOU)

    local items = self.taskView:getItems()
    local gap = #self.task_ - #items
    if gap > 0 then
        for i = 1, math.abs(gap) do
            local taskItem = self:addTaskItem()
            taskItem:setName("taskItem"..i)
            self.taskView:pushBackCustomItem(taskItem)
        end
    else
        for i = 1, math.abs(gap) do
            self.taskView:removeItem(1)
        end
    end

    for i, v in ipairs(self.taskView:getItems()) do
        local tab = self.taskItems[v]
        local taskCid = self.task_[i]
        local taskCfg = TaskDataMgr:getTaskCfg(taskCid)
        local taskInfo = TaskDataMgr:getTaskInfo(taskCid)
        local progress = math.min(taskInfo.progress, taskCfg.progress)
        tab.itemLabTip:setTextById(taskCfg.name)
        tab.labProcesShow:setPositionX(tab.itemLabTip:getContentSize().width)
        tab.labProcesShow:setText("("..progress.."/"..taskCfg.progress..")")
        for j,reward in ipairs(taskCfg.reward) do
            local goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            goodsItem:Scale(0.75)
            goodsItem:Pos(40 + (j - 1) * 85, 45):AddTo(tab.rewards)
            PrefabDataMgr:setInfo(goodsItem, reward[1], reward[2])
        end
        tab.btnComplete:setVisible(taskInfo.status == EC_TaskStatus.GET)
        tab.label_geted:setVisible(taskInfo.status == EC_TaskStatus.GETED)
        tab.Image_not_complete:setVisible(taskInfo.status == EC_TaskStatus.ING)
        tab.btnComplete:onClick(function()
            TaskDataMgr:send_TASK_SUBMIT_TASK(taskInfo.cid)
        end)
    end

end

return NianshowTaskView