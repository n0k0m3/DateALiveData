require "lua.public.ScrollMenu"
local TaskLayer = class("TaskLayer", BaseLayer)

function TaskLayer:ctor(params)
    self.super.ctor(self)
    self:showPopAnim(true)
    self:init("lua.uiconfig.osd.TaskLayer")


end


function TaskLayer:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    local panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
    panel_prefab:hide()
    self.prefabs = {}
    self.prefabs[1]  = TFDirector:getChildByPath(panel_prefab, "Panel_task1")
    self.prefabs[2]  = TFDirector:getChildByPath(panel_prefab, "Panel_task2")
    self.panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    --关闭按钮
    self.btn_close = TFDirector:getChildByPath(self.panel_root, "Button_close")
    local label_title    = TFDirector:getChildByPath(self.panel_root, "Label_title")
    local label_title_en = TFDirector:getChildByPath(self.panel_root, "Label_title_en")
    self.label_tip       = TFDirector:getChildByPath(self.panel_root, "Label_tip")
    self.label_complete  = TFDirector:getChildByPath(self.panel_root, "Label_complete")
    self.label_complete:hide()
    self.tabs  = {}
    self.taskListViews = {}
    for index = 1 , 2 do
        self.tabs[index]  = TFDirector:getChildByPath(self.panel_root, "Button_task"..tostring(index))
        self.taskListViews[index] = UIListView:create(TFDirector:getChildByPath(self.panel_root, "ScrollView_Task"..tostring(index)))
        self.taskListViews[index]:setItemsMargin(5)
    end

    self:setSelect(1)

end


local Task_Types =
{
    EC_TaskType.EVERY_DAY ,    -- 每日任务
    EC_TaskType.EVERY_WEEK     -- 每周任务
}





function TaskLayer:showTaskList(index)
    local taskType = Task_Types[index]
    local listView = self.taskListViews[index]
    local taskIDs  = TaskDataMgr:getTask(taskType)
    local items    = listView:getItems()
    local gap = #taskIDs - #items
    if gap > 0 then
        for i = 1, math.abs(gap) do
            local node = self:createItem(index)
            listView:pushBackCustomItem(node)
        end
    else
        for i = 1, math.abs(gap) do
            listView:removeItem(1)
        end
    end
    local items = listView:getItems()
    for i , item in ipairs(items) do
        local taskCid  = taskIDs[i]
        local taskCfg  = TaskDataMgr:getTaskCfg(taskCid)
        local taskInfo = TaskDataMgr:getTaskInfo(taskCid)
        local progress = math.min(taskInfo.progress, taskCfg.progress)
        item.label_progress_value:setTextById(800005, progress, taskCfg.progress)
        local percent  = math.floor(progress*100/taskCfg.progress)
        item.loadingBar:setPercent(percent)
        local desc = TaskDataMgr:getTaskDesc(taskCid)
        item.label_task_des:setText(desc)
        item.label_task_name:setTextById(taskCfg.name)

        for j, rewardNode in ipairs(item.rewards) do
            local reward = taskCfg.reward[j]
            if reward then
                rewardNode:show()
                PrefabDataMgr:setInfo(rewardNode.goodsNode, reward[1], reward[2])
            else
                rewardNode:hide()
            end
        end
        if taskInfo.status == EC_TaskStatus.ING then
            item.label_state:setVisible(true)
            item.label_state:setTextById(2100020)
        elseif taskInfo.status == EC_TaskStatus.GET then
            item.label_state:setVisible(false)
        elseif taskInfo.status == EC_TaskStatus.GETED then
            item.label_state:setVisible(true)
            item.label_state:setTextById(270491)      
        end
        item.btn_rev:setVisible(taskInfo.status == EC_TaskStatus.GET)
        item.btn_rev:setTouchEnabled(taskInfo.status == EC_TaskStatus.GET)
        item.btn_rev:onClick(function()
            TaskDataMgr:send_TASK_SUBMIT_TASK(taskInfo.cid)
        end)
    end
    self.label_complete:setVisible(not (#items > 0))
    if taskType == EC_TaskType.EVERY_WEEK then 
        if TaskDataMgr:existTask(taskType) then 
            self.label_complete:setTextById(111000118)
        else
            self.label_complete:setTextById(111000119)
        end
    else
        self.label_complete:setTextById(111000118)
    end
end



--两种类型任务的 提示ID
local Tips_String_ids = 
{ 
    14110008, --每日任务的提示
    14110009  --每周任务的提示
}


-- index 1 每日任务 2 每周任务
function TaskLayer:setSelect(index)
    if self.selectIndex ~= index then
        self.selectIndex = index
        self.label_tip:setTextById(Tips_String_ids[index])
        for k , tab in ipairs(self.tabs) do
            if k == index then
                tab:setTextureNormal("ui/setting/uires/002.png")
                tab:setTouchEnabled(false)
            else
                tab:setTextureNormal("")
                tab:setTouchEnabled(true)
            end
        end
        for k , node in ipairs(self.taskListViews) do
            node:setVisible(k == index)
        end
        self:showTaskList(index)
    end
end

function TaskLayer:createItem(index)
    local node = self.prefabs[index]:clone()
    node.btn_rev = TFDirector:getChildByPath(node, "Button_rev")
    node.label_state = TFDirector:getChildByPath(node, "Label_state")
    node.rewards = {}
    for index = 1,3 do
        local rawardNode = TFDirector:getChildByPath(node, "Image_reward_"..tostring(index))
        rawardNode.goodsNode = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        rawardNode.goodsNode:setScale(0.75)
        rawardNode.goodsNode:Pos(0, 0):AddTo(rawardNode)
        node.rewards[index] = rawardNode
    end
    node.loadingBar = TFDirector:getChildByPath(node, "LoadingBar")
    node.label_progress_value = TFDirector:getChildByPath(node, "Label_progress_value")
    node.label_task_des = TFDirector:getChildByPath(node, "Label_task_des")   
    node.label_task_name = TFDirector:getChildByPath(node, "Label_task_name")
    return node
end

function TaskLayer:registerEvents()
    EventMgr:addEventListener(self, EV_TASK_UPDATE, handler(self.onTaskUpdateEvent, self))
    EventMgr:addEventListener(self, EV_TASK_RECEIVE, handler(self.onTaskReceiveEvent, self))

    self.tabs[1]:onClick(function()
        self:setSelect(1)
    end)
    self.tabs[2]:onClick(function()
        self:setSelect(2)
    end)

    self.btn_close:onClick(function()
        AlertManager:closeLayer(self)
        end)
 
end

--任务刷新
function TaskLayer:onTaskUpdateEvent()
    self:showTaskList(self.selectIndex)
end

--获得奖励物品展示
function TaskLayer:onTaskReceiveEvent(reward)
        Utils:showReward(reward)
end

function TaskLayer:onHide()
    self.super.onHide(self)
end

function TaskLayer:removeUI()
    self.super.removeUI(self)
    -- --测试移除 lua
    -- local TFUILoadManager       = require('TFFramework.client.manager.TFUILoadManager')
    -- TFUILoadManager:unLoadModule("lua.logic.osd.TaskLayer")
end



function TaskLayer:onShow()
    self.super.onShow(self)
end

return TaskLayer
