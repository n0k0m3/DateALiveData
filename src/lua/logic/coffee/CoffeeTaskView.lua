
local CoffeeTaskView = class("CoffeeTaskView", BaseLayer)

function CoffeeTaskView:initData()
    self.taskItems_ = {}
    self.pages      = {}
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
    self.Pannel_dayItem = TFDirector:getChildByPath(self.Panel_prefab, "Pannel_dayItem")
    self.Pannel_hourItem = TFDirector:getChildByPath(self.Panel_prefab, "Pannel_hourItem")

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")
    self.Label_name = TFDirector:getChildByPath(Image_content, "Label_name")
    local ScrollView_task = TFDirector:getChildByPath(Image_content, "ScrollView_task")
    self.ListView_task = UIListView:create(ScrollView_task)
    self.pannel_log = TFDirector:getChildByPath(Image_content, "pannel_log")
    local scrollView_log = TFDirector:getChildByPath(self.pannel_log, "ScrollView_log")
    self.ListView_log = UIListView:create(scrollView_log)
    self.pannel_noEvent = TFDirector:getChildByPath(self.pannel_log, "pannel_noEvent")
    self.panelTapBtns = TFDirector:getChildByPath(Image_content, "panelTapBtns")
    self.btn_getAllLog = TFDirector:getChildByPath(self.pannel_log, "btn_getAllLog")
    self:chooseViewByIdx(1)
    -- self:refreshView()
end

-- function CoffeeTaskView:refreshView()
--     -- self.Label_name:setTextById(13210008)

--     self:updateAllTaskItem()
-- end

function CoffeeTaskView:registerEvents()
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onUpdateProgressEvent, self))
    EventMgr:addEventListener(self, EV_COFFEE_UPDATE_LOG, handler(self.updateAllLogItem, self))

    for i, btn in ipairs(self.panelTapBtns:getChildren()) do
        btn:onClick(function()
            self:chooseViewByIdx(i)
        end)
    end

    self.Button_close:onClick(function()
            AlertManager:closeLayer(self)
    end)

    self.btn_getAllLog:onClick(function()
        if not CoffeeDataMgr:isGetAllLogReward() then
            CoffeeDataMgr:send_MAID_ACTIVITY_REQ_GET_MAID_EVENT_AWARD(0)
        else
            Utils:showTips(219038)
        end
    end)
end

function CoffeeTaskView:chooseViewByIdx(idx)
    for i, btn in ipairs(self.panelTapBtns:getChildren()) do
        local imgSelect = btn:getChildByName("imgSelect")
        imgSelect:setVisible(idx == i)
    end

    if not self.pages[idx] then
        if idx == 1 then
            self:updateAllTaskItem()
            self.pages[idx] = self.ListView_task
        elseif idx == 2 then
            self:updateAllLogItem()
            self.pages[idx] = self.pannel_log
        end
    end
    for k, v in pairs(self.pages) do
        v:setVisible(k == idx)
    end 
    
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

function CoffeeTaskView:_formatImgUrl(str)
    return "ui/activity/coffee/pop/"..str..".png"
end

function CoffeeTaskView:updateAllLogItem()
    self.ListView_log:removeAllItems()
    local data = CoffeeDataMgr:getEventData()
    
    local count = table.count(data)
    self.pannel_noEvent:setVisible(count == 0)
    if count == 0 then
        return
    end

    for i, v in pairs(data) do
        local dayItem = self.Pannel_dayItem:clone()
        local data_tmp = v[1]

        local weekDay = os.date("%w",data_tmp.creatAt) -- 星期几
        weekDay = tonumber(weekDay)
        local weekConfig = CoffeeDataMgr:getWeekConfigByDay(weekDay == 0 and 7 or weekDay)

        local img_week = TFDirector:getChildByPath(dayItem,"img_week")
        local lab_time = TFDirector:getChildByPath(dayItem,"lab_time")
        local img_weather = TFDirector:getChildByPath(dayItem,"img_weather")
        img_week:setTexture(self:_formatImgUrl(weekConfig.picture[2]))
        lab_time:setText(Utils:getDateString(data_tmp.creatAt))
        lab_time:setColor(ccc3(weekConfig.colour[1], weekConfig.colour[2], weekConfig.colour[2]))
        
        img_weather:setTexture(self:_formatImgUrl(data_tmp.weather))
        self.ListView_log:pushBackCustomItem(dayItem)

        for j, _data in ipairs(v) do
            local eventConfig = TabDataMgr:getData("MaidEvent")[_data.cfgId]
            local timeTxt = os.date("%H:%M",_data.creatAt)

            local hourItem = self.Pannel_hourItem:clone()
            local img_scalerY = TFDirector:getChildByPath(hourItem,"img_scalerY")
            local img_tag = TFDirector:getChildByPath(hourItem,"img_tag")
            local lab_time = TFDirector:getChildByPath(img_tag,"lab_time")
            local lab_tipShow = TFDirector:getChildByPath(img_tag,"lab_tipShow")
            local lab_desc = TFDirector:getChildByPath(hourItem,"lab_desc")
            local img_reward = TFDirector:getChildByPath(hourItem,"img_reward")
            local pos = TFDirector:getChildByPath(img_reward,"pos")
            local img_hadGetted = TFDirector:getChildByPath(img_reward,"img_hadGetted")
            local pannel_touch = TFDirector:getChildByPath(img_reward,"pannel_touch")
            img_scalerY:setTexture(self:_formatImgUrl(weekConfig.picture[3]))
            img_tag:setTexture(self:_formatImgUrl(weekConfig.picture[1]))
            lab_time:setText(timeTxt)
            lab_tipShow:setVisible(not _data.reward)
            img_hadGetted:setVisible(_data.reward)
            if img_hadGetted:isVisible() then
                img_reward:setTexture(self:_formatImgUrl("036"))
            end
            img_reward:setVisible(false)
            if _data.rewards and table.count(_data.rewards) ~= 0 then
                local goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
                PrefabDataMgr:setInfo(goodsItem, _data.rewards[1].id, _data.rewards[1].num)
                goodsItem:setScale(0.55)
                goodsItem:AddTo(pos,1):Pos(0,0)

                -- type为3也有可能奖励为空 
                img_reward:setVisible(eventConfig.eventType == 3)
                if eventConfig.eventType == 3 then
                    lab_desc:setDimensions(550,0)
                end

                pannel_touch:setTouchEnabled(true)
                if not _data.reward then
                    pannel_touch:onClick(function()
                        CoffeeDataMgr:send_MAID_ACTIVITY_REQ_GET_MAID_EVENT_AWARD(_data.id)
                    end)
                end
            end
            lab_desc:setTextById(eventConfig.describe)

            self.ListView_log:pushBackCustomItem(hourItem)
        end
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
