
local CoffeeTaskView = class("CoffeeTaskView", BaseLayer)

function CoffeeTaskView:initData()
    self.taskItems_ = {}
end

function CoffeeTaskView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.coffee.coffeeTaskView")
end

function CoffeeTaskView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_taskItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_taskItem")

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")
    self.Label_name = TFDirector:getChildByPath(Image_content, "Label_name")
    local ScrollView_task = TFDirector:getChildByPath(Image_content, "ScrollView_task")
    self.ListView_task = UIListView:create(ScrollView_task)

    self:refreshView()
end

function CoffeeTaskView:refreshView()
    self.Label_name:setTextById(13210008)

    self:updateAllTaskItem()
end

function CoffeeTaskView:registerEvents()
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onUpdateProgressEvent, self))

    self.Button_close:onClick(function()
            AlertManager:closeLayer(self)
    end)
end

function CoffeeTaskView:addTaskItem()
    local foo = {}
    foo.root = self.Panel_taskItem:clone()
    foo.Image_receive_bg = TFDirector:getChildByPath(foo.root, "Image_receive_bg")
    foo.Label_desc = TFDirector:getChildByPath(foo.Image_receive_bg, "Label_desc")
    foo.Label_step = TFDirector:getChildByPath(foo.Image_receive_bg, "Label_step")
    foo.Image_geted_bg = TFDirector:getChildByPath(foo.root, "Image_geted_bg")
    foo.Label_desc_complete = TFDirector:getChildByPath(foo.Image_geted_bg, "Label_desc_complete")
    foo.Label_step_complete = TFDirector:getChildByPath(foo.Image_geted_bg, "Label_step_complete")
    foo.Image_receive_tag = TFDirector:getChildByPath(foo.root, "Image_receive_tag")
    foo.Image_geted_tag = TFDirector:getChildByPath(foo.root, "Image_geted_tag")
    foo.Image_ing_tag = TFDirector:getChildByPath(foo.root, "Image_ing_tag")
    local ScrollView_reward = TFDirector:getChildByPath(foo.root, "ScrollView_reward")
    foo.ListView_reward = UIListView:create(ScrollView_reward)
    foo.Label_ing = TFDirector:getChildByPath(foo.root, "Label_ing")
    foo.Button_receive = TFDirector:getChildByPath(foo.root, "Button_receive")
    foo.Label_receive = TFDirector:getChildByPath(foo.Button_receive, "Label_receive")
    foo.Label_geted = TFDirector:getChildByPath(foo.root, "Label_geted")

    self.taskItems_[foo.root] = foo
    self.ListView_task:pushBackCustomItem(foo.root)
end

function CoffeeTaskView:updateAllTaskItem()
    local items, activityId = CoffeeDataMgr:getItems(1)
    self.activityId_ = activityId
    local activityInfo = ActivityDataMgr2:getActivityInfo(activityId)
    local taskData = {}
    local getData = {}
    local ingData = {}
    local getedData = {}
    for i, v in ipairs(items) do
        local progressInfo = ActivityDataMgr2:getProgressInfo(activityInfo.activityType, v)
        if progressInfo.status == EC_TaskStatus.GET then
            table.insert(getData, v)
        elseif progressInfo.status == EC_TaskStatus.GETED then
            table.insert(getedData, v)
        elseif progressInfo.status == EC_TaskStatus.ING then
            table.insert(ingData, v)
        end
    end
    table.insertTo(taskData, getData)
    table.insertTo(taskData, ingData)
    table.insertTo(taskData, getedData)

    local items = self.ListView_task:getItems()
    local gap = #taskData - #items
    for i = 1, math.abs(gap) do
        if gap > 0 then
            self:addTaskItem()
        else
            local item = self.ListView_task:getItem(1)
            foo.taskItems_[item] = nil
            self.ListView_task:removeItem(1)
        end
    end

    items = self.ListView_task:getItems()
    for i, v in ipairs(items) do
        local taskId = taskData[i]
        local foo = self.taskItems_[v]
        local progressInfo = ActivityDataMgr2:getProgressInfo(activityInfo.activityType, taskId)
        local itemInfo = ActivityDataMgr2:getItemInfo(activityInfo.activityType, taskId)
        foo.Label_desc:setText(itemInfo.extendData.des2)
        foo.Label_desc_complete:setText(itemInfo.extendData.des2)
        foo.Label_step:setText(itemInfo.target)
        foo.Label_step_complete:setText(itemInfo.target)
        local isReceive = progressInfo.status == EC_TaskStatus.GET
        local isGeted = progressInfo.status == EC_TaskStatus.GETED
        local isIng = progressInfo.status == EC_TaskStatus.ING
        foo.Image_receive_bg:setVisible(not isGeted)
        foo.Image_geted_bg:setVisible(isGeted)
        foo.Image_receive_tag:setVisible(isReceive)
        foo.Image_geted_tag:setVisible(isGeted)
        foo.Image_ing_tag:setVisible(isIng)
        foo.Label_ing:setVisible(isIng)
        foo.Button_receive:setVisible(isReceive)
        foo.Label_geted:setVisible(isGeted)

        local items = foo.ListView_reward:getItems()
        if #items ~= table.count(itemInfo.reward) then
            foo.ListView_reward:removeAllItems()
            for cid, num in pairs(itemInfo.reward) do
                local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
                Panel_goodsItem:Scale(0.7)
                foo.ListView_reward:pushBackCustomItem(Panel_goodsItem)
            end
        end
        local index = 1
        for cid, num in pairs(itemInfo.reward) do
            local Panel_goodsItem = foo.ListView_reward:getItem(index)
            PrefabDataMgr:setInfo(Panel_goodsItem, cid, num)
            index = index + 1
        end

        foo.Button_receive:onClick(function()
                ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(activityId, taskId)
        end)
    end
end

function CoffeeTaskView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId_ ~= activitId then return end
    Utils:showReward(reward)
    self:updateAllTaskItem()
end

function CoffeeTaskView:onUpdateProgressEvent()
    self:updateAllTaskItem()
end

return CoffeeTaskView
