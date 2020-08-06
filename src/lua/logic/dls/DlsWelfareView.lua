
local DlsWelfareView = class("DlsWelfareView", BaseLayer)

function DlsWelfareView:initData()
    self.welfareItems_ = {}
    self.maxActive_ = 150
    self.activeItem_ = {}
    self.itemCid_ = EC_SItemType.WORKER_CARD
end

function DlsWelfareView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.dls.dlsWelfareView")
end

function DlsWelfareView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_activeItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_activeItem")
    self.Panel_welfareItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_welfareItem")

    local Image_welfareBar = TFDirector:getChildByPath(self.Panel_root, "Image_welfareBar")
    local Image_welfareScrollBar = TFDirector:getChildByPath(Image_welfareBar, "Image_welfareScrollBar")
    local scrollBar = UIScrollBar:create(Image_welfareBar, Image_welfareScrollBar)
    local ScrollView_welfare = TFDirector:getChildByPath(self.Panel_root, "ScrollView_welfare")
    self.ListView_welfare = UIListView:create(ScrollView_welfare)
    self.ListView_welfare:setScrollBar(scrollBar)

    local Panel_active = TFDirector:getChildByPath(self.Panel_root, "Panel_active")
    self.Image_active_progress = TFDirector:getChildByPath(Panel_active, "Image_active_progress")
    self.LoadingBar_activeProgress = TFDirector:getChildByPath(self.Image_active_progress, "LoadingBar_activeProgress")
    self.Label_have = TFDirector:getChildByPath(Panel_active, "Label_have")
    self.Image_activeIcon = TFDirector:getChildByPath(Panel_active, "Image_activeIcon")
    self.Label_activeValue = TFDirector:getChildByPath(Panel_active, "Image_activeValue.Label_activeValue")

    self:refreshView()
end

function DlsWelfareView:addWelfareTaskItem()
    local Panel_welfareItem = self.Panel_welfareItem:clone()
    local item = {}
    item.root = Panel_welfareItem
    item.Label_progress = TFDirector:getChildByPath(item.root, "Label_progress")
    item.Label_name = TFDirector:getChildByPath(item.root, "Label_name")
    item.Image_active = TFDirector:getChildByPath(item.Label_name, "Image_active"):hide()
    item.Image_active_icon = TFDirector:getChildByPath(item.Image_active, "Image_active_icon")
    item.Label_active_num = TFDirector:getChildByPath(item.Image_active, "Label_active_num")
    item.Label_desc = TFDirector:getChildByPath(item.root, "Label_desc")
    item.Panel_reward = {}
    for i = 1, 4 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(item.root, "Image_reward_" .. i)
        foo.Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        foo.Panel_goodsItem:Scale(0.75)
        foo.Panel_goodsItem:Pos(0, 0):AddTo(foo.root)
        item.Panel_reward[i] = foo
    end
    item.Button_goto = TFDirector:getChildByPath(item.root, "Button_goto")
    item.Label_goto = TFDirector:getChildByPath(item.Button_goto, "Label_goto")
    item.Button_receive = TFDirector:getChildByPath(item.root, "Button_receive")
    item.Label_receive = TFDirector:getChildByPath(item.Button_receive, "Label_receive")
    item.Label_reward = TFDirector:getChildByPath(item.root, "Label_reward")
    item.Label_reward:setTextById(1300018)
    item.Label_geted = TFDirector:getChildByPath(item.root, "Label_geted")
    item.Image_geted = TFDirector:getChildByPath(item.root, "Image_geted")
    item.Image_noGeted = TFDirector:getChildByPath(item.root, "Image_noGeted")
    self.welfareItems_[item.root] = item
    return Panel_welfareItem
end

function DlsWelfareView:initActiveTask()
    self.activeTask_ = TaskDataMgr:getTask(EC_TaskType.DLS_CARD)
    local size = self.Image_active_progress:Size()
    for i = #self.activeTask_, 1, -1 do
        local taskCfg = TaskDataMgr:getTaskCfg(self.activeTask_[i])
        local percent = taskCfg.progress / self.maxActive_
        local Panel_activeItem = self.Panel_activeItem:clone()
        local item = {}
        item.root = Panel_activeItem
        item.Button_geted = TFDirector:getChildByPath(item.root, "Button_geted")
        item.Button_canGet = TFDirector:getChildByPath(item.root, "Button_canGet")
        local spine_receive = TFDirector:getChildByPath(item.Button_canGet, "Spine_receive")
        spine_receive:playByIndex(0,-1,-1,1)
        item.Button_notGet = TFDirector:getChildByPath(item.root, "Button_notGet")
        item.Label_getValue = TFDirector:getChildByPath(item.root, "Label_getValue")
        item.Label_getValue:setText(taskCfg.progress)
        self.activeItem_[i] = item
        Panel_activeItem:Pos(size.width * percent, 0):AddTo(self.Image_active_progress,15)
    end
end

function DlsWelfareView:showTask()
    self.daiyTask_ = TaskDataMgr:getTask(EC_TaskType.DLS)
    self.activeTask_ = TaskDataMgr:getTask(EC_TaskType.DLS_CARD)

    local items = self.ListView_welfare:getItems()
    local gap = #self.daiyTask_ - #items
    if gap > 0 then
        for i = 1, math.abs(gap) do
            local Panel_welfareItem = self:addWelfareTaskItem()
            self.ListView_welfare:pushBackCustomItem(Panel_welfareItem)
        end
    else
        for i = 1, math.abs(gap) do
            self.ListView_welfare:removeItem(1)
        end
    end

    local items = self.ListView_welfare:getItems()
    for i, v in ipairs(items) do
        local item = self.welfareItems_[v]
        local taskCid = self.daiyTask_[i]
        local taskCfg = TaskDataMgr:getTaskCfg(taskCid)
        local taskInfo = TaskDataMgr:getTaskInfo(taskCid)
        local progress = math.min(taskInfo.progress, taskCfg.progress)
        item.Label_progress:setTextById(800005, progress, taskCfg.progress)
        local desc = TaskDataMgr:getTaskDesc(taskCid)
        item.Label_desc:setText(desc)
        item.Label_name:setTextById(taskCfg.name)

        local showReward = {}
        local activeReward
        for i, v in ipairs(taskCfg.reward) do
            if v[1] == EC_SItemType.ACTIVITY then
                activeReward = v
            else
                table.insert(showReward, v)
            end
        end
        item.Image_active:setVisible(tobool(activeReward))
        if activeReward then
            local itemCfg = GoodsDataMgr:getItemCfg(activeReward[1])
            item.Image_active_icon:setTexture(itemCfg.icon)
            item.Label_active_num:setTextById(800007, activeReward[2])
        end

        for j, Panel_reward in ipairs(item.Panel_reward) do
            local reward = showReward[j]
            if reward then
                Panel_reward.Panel_goodsItem:show()
                if isDoubleCardItem then
                    PrefabDataMgr:setInfo(Panel_reward.Panel_goodsItem, reward[1], reward[2])
                    local doubleCardId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.DOUBLE_CARD)
                    local activityInfo = ActivityDataMgr2:getActivityInfo(doubleCardId[1])
                    PrefabDataMgr:setInfo(Panel_reward.Panel_goodsItem, reward[1], reward[2] * activityInfo.extendData)
                else
                    PrefabDataMgr:setInfo(Panel_reward.Panel_goodsItem, reward[1], reward[2])
                end
            else
                Panel_reward.Panel_goodsItem:hide()
            end
        end

        item.Button_receive:setVisible(taskInfo.status == EC_TaskStatus.GET)
        item.Label_geted:setVisible(taskInfo.status == EC_TaskStatus.GETED)
        item.Image_geted:setVisible(taskInfo.status == EC_TaskStatus.GETED)
        item.root:setOpacity(taskInfo.status == EC_TaskStatus.GETED and 125 or 255)
        item.Image_noGeted:setVisible(taskInfo.status ~= EC_TaskStatus.GETED)
        item.Label_receive:setTextById(1300008)
        item.Button_goto:setVisible(taskInfo.status == EC_TaskStatus.ING and taskCfg.jumpInterface ~= 0)
        item.Label_goto:setTextById(1300009)

        item.Button_goto:onClick(function()
                if taskCfg.subType == EC_TaskSubType.LEVEL then
                    local levelId = taskCfg.finishParams["dunId"]
                    FunctionDataMgr:enterByFuncId(taskCfg.jumpInterface, levelId)
                else
                    FunctionDataMgr:enterByFuncId(taskCfg.jumpInterface)
                end
        end)

        item.Button_receive:onClick(function()
                TaskDataMgr:send_TASK_SUBMIT_TASK(taskInfo.cid)
        end)
    end
    self:updateActiveTask()
end

function DlsWelfareView:refreshView()
    local itemCfg = GoodsDataMgr:getItemCfg(self.itemCid_)
    self.Image_activeIcon:setTexture(itemCfg.icon)
    self.Label_have:setTextById(2101008)

    self:initActiveTask()
    self:showTask()
end

function DlsWelfareView:updateActiveTask()
    for i, v in ipairs(self.activeItem_) do
        local taskInfo = TaskDataMgr:getTaskInfo(self.activeTask_[i])
        v.Button_geted:setVisible(taskInfo.status == EC_TaskStatus.GETED)
        v.Button_canGet:setVisible(taskInfo.status == EC_TaskStatus.GET)
        v.Button_notGet:setVisible(taskInfo.status == EC_TaskStatus.ING)
    end

    local count = GoodsDataMgr:getItemCount(self.itemCid_)
    local percent = me.clampf(count / self.maxActive_, 0, 1)
    self.LoadingBar_activeProgress:setPercent(percent * 100)
    self.Label_activeValue:setText(count)
end

function DlsWelfareView:onUpdateActiveEvent()
    self:updateActiveTask()
end

function DlsWelfareView:registerEvents()
    EventMgr:addEventListener(self, EV_TASK_UPDATE, handler(self.onTaskUpdateEvent, self))
    EventMgr:addEventListener(self, EV_TASK_RECEIVE, handler(self.onTaskReceiveEvent, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onUpdateActiveEvent, self))

    for i, v in ipairs(self.activeItem_) do
        local taskInfo = TaskDataMgr:getTaskInfo(self.activeTask_[i])
        v.Button_geted:onClick(function()
                Utils:openView("dls.DlsWelfareRewardView", taskInfo.cid)
        end)
        v.Button_canGet:onClick(function()
                Utils:openView("dls.DlsWelfareRewardView", taskInfo.cid)
        end)
        v.Button_notGet:onClick(function()
                Utils:openView("dls.DlsWelfareRewardView", taskInfo.cid)
        end)
    end

    self.Image_activeIcon:onClick(function()
            dump(self.itemCid_)
            Utils:showInfo(self.itemCid_)
    end)
end

function DlsWelfareView:onTaskUpdateEvent(taskCid)
    self:showTask()
end

function DlsWelfareView:onTaskReceiveEvent(reward)
    Utils:showReward(reward)
end

return DlsWelfareView
