
local TaskMainView = class("TaskMainView", BaseLayer)

function TaskMainView:initData(taskType)
    self.tabData_ = {
        {
            type_ = EC_TaskPage.MAIN,
            icon = "ui/task/tab_1.png",
            text = 1300001,
        },
        {
            type_ = EC_TaskPage.DAILY,
            icon = "ui/task/tab_2.png",
            text = 1300002,
        },
        {
            type_ = EC_TaskPage.HONOR,
            icon = "ui/task/tab_3.png",
            text = 1300003,
        },
        -- {
        --     type_ = EC_TaskPage.ACTIVITY,
        --     icon = "ui/task/tab_4.png",
        --     text = 1300004,
        -- },
    }


    if ActivityDataMgr2:isWarOrderActivityOpen() then
        table.insert(self.tabData_,3,{type_ = EC_TaskPage.TRAININIG,icon = "ui/task/tab_5.png",text = 14220070})
        table.insert(self.tabData_,4,{type_ = EC_TaskPage.TRAININIG_TASK,icon = "ui/task/tab_6.png",text = 14220071})
        self.warOrderActivity = ActivityDataMgr2:getWarOrderAcrivityInfo()
    end

    self.defaultSelectIndex_ = 1
    if taskType then
        for i, v in ipairs(self.tabData_) do
            if v.type_ == taskType then
                self.defaultSelectIndex_ = i
                break
            end
        end
    end

    self.tabItem_ = {}
    self.mainItem_ = {}
    self.dailyItem_ = {}
    self.honorItem_ = {}
    self.activityItem_ = {}
    self.activeItem_ = {}
    self.trainingTaskItem_ = {}
    self.selectIndex_ = nil
    self.timerAdd = 0
    ----------------------龚颖的特殊需求，默认最大150----------------------
    self.maxActive_ = 150--TaskDataMgr:getMaxActive()
    ---------------------------------------------------------------------
end

function TaskMainView:getClosingStateParams()
    for i, v in ipairs(self.tabData_) do
        if self.selectIndex_ == i then
            return {v.type_}
        end
    end
end

function TaskMainView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.task.taskMainView")
end

function TaskMainView:initUI(ui)
    self.super.initUI(self, ui)
    self:addLockLayer()

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_tabItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_tabItem")
    self.Panel_activeItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_activeItem")
    self.Panel_dailyItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_dailyItem")
    self.Panel_mainItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_mainItem")
    self.Panel_honorItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_honorItem")
    self.Panel_training_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_training_item")
    self.Panel_training_task_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_training_task_item")

    local ScrollView_tab = TFDirector:getChildByPath(self.Panel_root, "ScrollView_tab")
    self.ListView_tab = UIListView:create(ScrollView_tab)

    self.Panel_daily = TFDirector:getChildByPath(self.Panel_root, "Panel_daily")
    local Panel_active = TFDirector:getChildByPath(self.Panel_root, "Panel_active")
    self.Image_active_progress = TFDirector:getChildByPath(self.Panel_daily, "Image_active_progress")
    self.LoadingBar_activeProgress = TFDirector:getChildByPath(self.Image_active_progress, "LoadingBar_activeProgress")
    self.Label_activeTitle = TFDirector:getChildByPath(Panel_active, "Label_activeTitle")
    self.Label_activeValue = TFDirector:getChildByPath(Panel_active, "Label_activeValue")
    local Image_dailyBar = TFDirector:getChildByPath(self.Panel_daily, "Image_dailyBar")
    local Image_dailyScrollBar = TFDirector:getChildByPath(Image_dailyBar, "Image_dailyScrollBar")
    local scrollBar = UIScrollBar:create(Image_dailyBar, Image_dailyScrollBar)
    local ScrollView_daily = TFDirector:getChildByPath(self.Panel_daily, "ScrollView_daily")
    self.ListView_daily = UIListView:create(ScrollView_daily)
    self.ListView_daily:setScrollBar(scrollBar)
    self.Panel_touch = TFDirector:getChildByPath(self.Panel_daily, "Panel_touch")

    self.Panel_main = TFDirector:getChildByPath(self.Panel_root, "Panel_main")
    local Image_mainBar = TFDirector:getChildByPath(self.Panel_main, "Image_mainBar")
    local Image_mainScrollBar = TFDirector:getChildByPath(Image_mainBar, "Image_mainScrollBar")
    local scrollBar = UIScrollBar:create(Image_mainBar, Image_mainScrollBar)
    local ScrollView_main = TFDirector:getChildByPath(self.Panel_main, "ScrollView_main")
    self.ListView_main = UIListView:create(ScrollView_main)
    self.ListView_main:setScrollBar(scrollBar)

    self.Panel_honor = TFDirector:getChildByPath(self.Panel_root, "Panel_honor")
    local Image_honorProgress = TFDirector:getChildByPath(self.Panel_honor, "Image_honorProgress")
    self.Label_honorProgressTitle = TFDirector:getChildByPath(Image_honorProgress, "Label_honorProgressTitle")
    self.Label_honorProgress = TFDirector:getChildByPath(Image_honorProgress, "Label_honorProgress")
    local Image_honorBar = TFDirector:getChildByPath(self.Panel_honor, "Image_honorBar")
    local Image_honorScrollBar = TFDirector:getChildByPath(Image_honorBar, "Image_honorScrollBar")
    self.Image_honorScrollBar = UIScrollBar:create(Image_honorBar, Image_honorScrollBar)
    local ScrollView_honor = TFDirector:getChildByPath(self.Panel_honor, "ScrollView_honor")
    self.TableView_honor = Utils:scrollView2TableView(ScrollView_honor)

    self.TableView_honor:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.cellSizeForTable, self))
    self.TableView_honor:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex, self))
    self.TableView_honor:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCellsInTableView, self))
    self.TableView_honor:addMEListener(TFTABLEVIEW_SCROLL, handler(self.tableScroll,self))

    self.Panel_activity = TFDirector:getChildByPath(self.Panel_root, "Panel_activity")
    local Image_activityBar = TFDirector:getChildByPath(self.Panel_activity, "Image_activityBar")
    local Image_activityScrollBar = TFDirector:getChildByPath(Image_activityBar, "Image_activityScrollBar")
    local scrollBar = UIScrollBar:create(Image_activityBar, Image_activityScrollBar)
    local ScrollView_activity = TFDirector:getChildByPath(self.Panel_activity, "ScrollView_activity")
    self.ListView_activity = UIListView:create(ScrollView_activity)
    self.ListView_activity:setScrollBar(scrollBar)

    self.Panel_training = TFDirector:getChildByPath(self.Panel_root, "Panel_training")
    self.Panel_reward = TFDirector:getChildByPath(self.Panel_training, "Panel_reward")
    self.LoadingBar_levelProgress = TFDirector:getChildByPath(self.Panel_training, "LoadingBar_levelProgress")
    self.Label_cur_train_level = TFDirector:getChildByPath(self.Panel_training, "Label_cur_train_level")
    self.Label_training_time = TFDirector:getChildByPath(self.Panel_training, "Label_training_time")
    self.Label_level_exp = TFDirector:getChildByPath(self.Panel_training, "Label_level_exp")
    self.Button_buy_level = TFDirector:getChildByPath(self.Panel_training, "Button_buy_level")
    self.Button_upgrade = TFDirector:getChildByPath(self.Panel_training, "Button_upgrade")
    self.Button_unlock_reward = TFDirector:getChildByPath(self.Panel_training, "Button_unlock_reward")
    self.Label_unlock_reward = TFDirector:getChildByPath(self.Button_unlock_reward, "Label_unlock_reward")
    self.Button_shop = TFDirector:getChildByPath(self.Panel_training, "Button_shop")
    self.Image_training_shop_tips = TFDirector:getChildByPath(self.Button_shop, "Image_training_shop_tips")
    self.Button_get_all = TFDirector:getChildByPath(self.Panel_training, "Button_get_all")
    self.Label_preview_level = TFDirector:getChildByPath(self.Panel_training, "Label_preview_level")
    self.Panel_lock_cover = TFDirector:getChildByPath(self.Panel_training, "Panel_lock_cover")
    self.previewItems = {}
    for i=1,2 do
        local item = TFDirector:getChildByPath(self.Panel_training, "Panel_item"..i)
        self.previewItems[i] = item
    end

    self.Panel_training_task = TFDirector:getChildByPath(self.Panel_root, "Panel_training_task")
    self.ScrollView_training_task = TFDirector:getChildByPath(self.Panel_training_task, "ScrollView_training_task")
    self.ListView_training_task = UIListView:create(self.ScrollView_training_task)
    -- self.Image_preview = Utils:previewReward()
    -- self.Image_preview:setAnchorPoint(ccp(0.5, 1))
    -- self.Image_preview:AddTo(self.Panel_root):setZOrder(1)
    self:refreshView()
end

function TaskMainView:refreshView()
    self.Label_activeTitle:setTextById(1300010)

    self:initTabBtn()
    self:initDailyTask()
    self:selectTab(self.defaultSelectIndex_)

end

function TaskMainView:initDailyTask()
    self.activeTask_ = TaskDataMgr:getTask(EC_TaskType.ACTIVE)
    local size = self.Image_active_progress:Size()
    for i = #self.activeTask_, 1, -1 do
        local taskCfg = TaskDataMgr:getTaskCfg(self.activeTask_[i])
        local percent = taskCfg.progress / self.maxActive_
        local Panel_activeItem = self.Panel_activeItem:clone()
        local item = {}
        item.root = Panel_activeItem
        item.Panel_geted = TFDirector:getChildByPath(item.root, "Panel_geted")
        item.Button_geted = TFDirector:getChildByPath(item.Panel_geted, "Button_geted")
        item.Button_geted:setOpacity(255 * 0.3)
        item.Panel_canGet = TFDirector:getChildByPath(item.root, "Panel_canGet")
        item.Spine_receive = TFDirector:getChildByPath(item.Panel_canGet, "Spine_receive")
        item.Spine_receive:play("animation", true)
        item.Button_canGet = TFDirector:getChildByPath(item.Panel_canGet, "Button_canGet")
        item.Button_canGet:setOpacity(255 * 0.3)
        item.Panel_notGet = TFDirector:getChildByPath(item.root, "Panel_notGet")
        item.Button_notGet = TFDirector:getChildByPath(item.Panel_notGet, "Button_notGet")
        item.Button_notGet:setOpacity(255 * 0.3)
        item.Label_getValue = TFDirector:getChildByPath(item.root, "Label_getValue")
        item.Label_getValue:setText(taskCfg.progress)
        self.activeItem_[i] = item
        Panel_activeItem:Pos(size.width * percent, 0):AddTo(self.Image_active_progress,15)
    end
end

function TaskMainView:initTabBtn()
    for i, v in ipairs(self.tabData_) do
        local Panel_tabItem = self.Panel_tabItem:clone()
        local item = {}
        item.root = Panel_tabItem
        item.Image_select = TFDirector:getChildByPath(item.root, "Image_select")
        item.Label_name = TFDirector:getChildByPath(item.root, "Label_name")
        item.Image_icon = TFDirector:getChildByPath(item.root, "Image_icon")
        item.Image_touch = TFDirector:getChildByPath(item.root, "Image_touch")
        item.Image_tips = TFDirector:getChildByPath(item.root, "Image_tips")
        item.Label_name:setTextById(v.text)
        item.Image_icon:setTexture(v.icon)
        self.tabItem_[item.root] = item
        self.ListView_tab:pushBackCustomItem(Panel_tabItem)
    end
end

function TaskMainView:selectTab(index)
    if self.selectIndex_ == index then return end
    -- self.Image_preview:hide()
    self.selectIndex_ = index
    for i, v in ipairs(self.ListView_tab:getItems()) do
        local item = self.tabItem_[v]
        item.Image_select:setVisible(index == i)
    end

    self:showTask()
end

function TaskMainView:showTask()
    self.Panel_main:hide()
    self.Panel_daily:hide()
    self.Panel_honor:hide()
    self.Panel_activity:hide()
    self.Panel_training:hide()
    self.Panel_reward:hide()
    self.Panel_training_task:hide()
    local tabData = self.tabData_[self.selectIndex_]
    if tabData.type_ == EC_TaskPage.MAIN then
        self.Panel_main:show()
        self:showMainTask()
    elseif tabData.type_ == EC_TaskPage.DAILY then
        self.Panel_daily:show()
        self:showDailyTask()
    elseif tabData.type_ == EC_TaskPage.HONOR then
        self.Panel_honor:show()
        self:showHonorTask()
    elseif tabData.type_ == EC_TaskPage.ACTIVITY then
        self.Panel_activity:show()
        self:showActivityTask()
    elseif tabData.type_ == EC_TaskPage.TRAININIG then
        self.Panel_training:show()
        self.Panel_reward:show()
        self:showTrainingView()
    elseif tabData.type_ == EC_TaskPage.TRAININIG_TASK then
        self.Panel_training:show()
        self.Panel_reward:hide()
        self.Panel_training_task:show()
        self:showTrainingTask()
    end
end

function TaskMainView:showPreview(index)
    local dailyTaskCid = self.activeTask_[index]
    local item = self.activeItem_[index]
    local wp = item.root:getParent():convertToWorldSpace(item.root:Pos())
    -- local np = self.Image_preview:getParent():convertToNodeSpaceAR(wp)

    local taskCfg = TaskDataMgr:getTaskCfg(dailyTaskCid)
    Utils:previewReward(self.Image_preview, taskCfg.reward)

    -- self.Image_preview:Pos(np)
end

function TaskMainView:showMainTask()
    self.mainTask_ = TaskDataMgr:getTask(EC_TaskType.MAIN)

    local items = self.ListView_main:getItems()
    local gap = #self.mainTask_ - #items
    if gap > 0 then
        for i = 1, math.abs(gap) do
            local Panel_mainItem = self:addMainTaskItem(i)
            Panel_mainItem:setName("Panel_mainItem"..i);
            self.ListView_main:pushBackCustomItem(Panel_mainItem)
        end
    else
        for i = 1, math.abs(gap) do
            self.ListView_main:removeItem(1)
        end
    end

    local items = self.ListView_main:getItems()
    for i, v in ipairs(items) do
        local item = self.mainItem_[v]
        local taskCid = self.mainTask_[i]
        local taskCfg = TaskDataMgr:getTaskCfg(taskCid)
        local taskInfo = TaskDataMgr:getTaskInfo(taskCid)
        local progress = math.min(taskInfo.progress, taskCfg.progress)
        item.Label_progress:setTextById(800005, progress, taskCfg.progress)
        item.Image_icon:setTexture(taskCfg.icon)
        local desc = TaskDataMgr:getTaskDesc(taskCid)
        item.Label_desc:setText(desc)
        item.Label_name:setTextById(taskCfg.name)
        item.Image_type:setVisible(#taskCfg.typeDes > 0)
        item.Label_type:setVisible(#taskCfg.typeDes > 0)
        if item.Label_type:isVisible() then
            item.Label_type:setTextById(taskCfg.typeDes)
        end
        local size=  item.Label_name:Size()
        item.Image_active:PosX(size.width + 10)

        for j, Panel_reward in ipairs(item.Panel_reward) do
            local reward = taskCfg.reward[j]
            if reward then
                Panel_reward.Panel_goodsItem:show()
                PrefabDataMgr:setInfo(Panel_reward.Panel_goodsItem, reward[1], reward[2])
            else
                Panel_reward.Panel_goodsItem:hide()
            end
        end

        item.Button_receive:setVisible(taskInfo.status == EC_TaskStatus.GET)
        item.Label_geted:setVisible(taskInfo.status == EC_TaskStatus.GETED)
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
                GameGuide:checkGuideEnd(self.guideFuncId)
        end)
    end

    self:updateRedPointStatus()
end

function TaskMainView:addDailyTaskItem()
    local Panel_dailyItem = self.Panel_dailyItem:clone()
    local item = {}
    item.root = Panel_dailyItem
    item.Label_progress = TFDirector:getChildByPath(item.root, "Label_progress")
    item.Image_icon = TFDirector:getChildByPath(item.root, "Image_icon")
    local Image_title = TFDirector:getChildByPath(item.root, "Image_title")
    item.Label_name = TFDirector:getChildByPath(Image_title, "Label_name")
    item.Label_active_num = TFDirector:getChildByPath(Image_title, "Label_active_num")
    item.Image_active_icon = TFDirector:getChildByPath(item.Label_active_num, "Image_active_icon")
    item.Label_desc = TFDirector:getChildByPath(item.root, "Label_desc")
    item.Panel_reward = {}
    for i = 1, 3 do
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
    item.Image_type = TFDirector:getChildByPath(item.root, "Image_type")
    item.Label_type = TFDirector:getChildByPath(item.root, "Label_type")
    item.Label_geted = TFDirector:getChildByPath(item.root, "Label_geted")
    item.Image_tips = TFDirector:getChildByPath(item.root, "Image_tips"):hide()
    item.Label_countdown = TFDirector:getChildByPath(item.Image_tips, "Label_countdown")
    self.dailyItem_[item.root] = item
    return Panel_dailyItem
end

function TaskMainView:updateDoubleCardCountdown()
    local items = self.ListView_daily:getItems()
    for i, v in ipairs(items) do
        local item = self.dailyItem_[v]
        local taskCid = self.daiyTask_[i]
        local taskCfg = TaskDataMgr:getTaskCfg(taskCid)
        local isOpenDoubleCard = ActivityDataMgr2:isOpen(EC_ActivityType2.DOUBLE_CARD)
        local isDoubleCardItem = taskCid == 200001 and isOpenDoubleCard
        if isDoubleCardItem then
            local doubleCardId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.DOUBLE_CARD)
            local activityInfo = ActivityDataMgr2:getActivityInfo(doubleCardId[1])
            local serverTime = ServerDataMgr:getServerTime()
            local remainTime = math.max(0, activityInfo.endTime - serverTime)
            local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
            if day == "00" then
                item.Label_countdown:setTextById("r41002", hour, min)
            else
                item.Label_countdown:setTextById("r41001", day, hour)
            end
            if remainTime == 0 then
                item.Image_tips:hide()
                local showReward = {}

                local activeReward
                for i, v in ipairs(taskCfg.reward) do
                    if v[1] == EC_SItemType.ACTIVITY then
                        activeReward = v
                    else
                        table.insert(showReward, v)
                    end
                end
                for j, Panel_reward in ipairs(item.Panel_reward) do
                    local reward = showReward[j]
                    if reward then
                        Panel_reward.Panel_goodsItem:show()
                        PrefabDataMgr:setInfo(Panel_reward.Panel_goodsItem, reward[1], reward[2])
                    end
                end
            end
        end
    end
end

function TaskMainView:addHonorItem()
    local Panel_honorItem = self.Panel_honorItem:clone()
    local item = {}
    item.root = Panel_honorItem
    item.Label_progress = TFDirector:getChildByPath(item.root, "Label_progress")
    item.Image_icon = TFDirector:getChildByPath(item.root, "Image_icon")
    item.Label_name = TFDirector:getChildByPath(item.root, "Label_name")
    item.Image_active = TFDirector:getChildByPath(item.Label_name, "Image_active"):hide()
    item.Image_active_icon = TFDirector:getChildByPath(item.Image_active, "Image_active_icon")
    item.Label_active_num = TFDirector:getChildByPath(item.Image_active, "Label_active_num")
    item.Label_desc = TFDirector:getChildByPath(item.root, "Label_desc")
    item.Panel_reward = {}
    for i = 1, 3 do
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
    item.Image_type = TFDirector:getChildByPath(item.root, "Image_type")
    item.Label_type = TFDirector:getChildByPath(item.root, "Label_type")
    item.Label_geted = TFDirector:getChildByPath(item.root, "Label_geted")
    self.honorItem_[item.root] = item
    return Panel_honorItem
end


function TaskMainView:addMainTaskItem(idx)
    local Panel_mainItem = self.Panel_mainItem:clone()
    local item = {}
    item.root = Panel_mainItem
    item.Label_progress = TFDirector:getChildByPath(item.root, "Label_progress")
    item.Image_icon = TFDirector:getChildByPath(item.root, "Image_icon")
    item.Label_name = TFDirector:getChildByPath(item.root, "Label_name")
    item.Image_active = TFDirector:getChildByPath(item.Label_name, "Image_active"):hide()
    item.Image_active_icon = TFDirector:getChildByPath(item.Image_active, "Image_active_icon")
    item.Label_active_num = TFDirector:getChildByPath(item.Image_active, "Label_active_num")
    item.Label_desc = TFDirector:getChildByPath(item.root, "Label_desc")
    item.Panel_reward = {}
    for i = 1, 3 do
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
    item.Image_type = TFDirector:getChildByPath(item.root, "Image_type")
    item.Label_type = TFDirector:getChildByPath(item.root, "Label_type")
    item.Label_geted = TFDirector:getChildByPath(item.root, "Label_geted")

    self.mainItem_[item.root] = item
    return Panel_mainItem
end

function TaskMainView:addActivityItem()
    local Panel_mainItem = self.Panel_mainItem:clone()
    local item = {}
    item.root = Panel_mainItem
    item.Label_progress = TFDirector:getChildByPath(item.root, "Image_progress.Label_progress")
    item.Image_icon = TFDirector:getChildByPath(item.root, "Image_icon")
    item.Label_name = TFDirector:getChildByPath(item.root, "Label_name")
    item.Image_active = TFDirector:getChildByPath(item.Label_name, "Image_active"):hide()
    item.Image_active_icon = TFDirector:getChildByPath(item.Image_active, "Image_active_icon")
    item.Label_active_num = TFDirector:getChildByPath(item.Image_active, "Label_active_num")
    item.Label_desc = TFDirector:getChildByPath(item.root, "Label_desc")
    item.Panel_reward = {}
    for i = 1, 2 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(item.root, "Image_reward_" .. i)
        foo.Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        foo.Panel_goodsItem:Pos(0, 0):AddTo(foo.root)
        item.Panel_reward[i] = foo
    end
    item.Button_goto = TFDirector:getChildByPath(item.root, "Button_goto")
    item.Label_goto = TFDirector:getChildByPath(item.Button_goto, "Label_goto")
    item.Button_receive = TFDirector:getChildByPath(item.root, "Button_receive")
    item.Label_receive = TFDirector:getChildByPath(item.Button_receive, "Label_receive")
    item.Label_reward = TFDirector:getChildByPath(item.root, "Label_reward")
    item.Label_reward:setTextById(1300018)
    item.Image_type = TFDirector:getChildByPath(item.root, "Image_type")
    item.Label_type = TFDirector:getChildByPath(item.root, "Label_type")
    item.Label_geted = TFDirector:getChildByPath(item.root, "Label_geted")
    self.activityItem_[item.root] = item
    return Panel_mainItem
end

function TaskMainView:showDailyTask()
    self.daiyTask_ = TaskDataMgr:getTask(EC_TaskType.DAILY)
    self.activeTask_ = TaskDataMgr:getTask(EC_TaskType.ACTIVE)

    local items = self.ListView_daily:getItems()
    local gap = #self.daiyTask_ - #items
    if gap > 0 then
        for i = 1, math.abs(gap) do
            local Panel_dailyItem = self:addDailyTaskItem()
            self.ListView_daily:pushBackCustomItem(Panel_dailyItem)
        end
    else
        for i = 1, math.abs(gap) do
            self.ListView_daily:removeItem(1)
        end
    end

    local items = self.ListView_daily:getItems()
    for i, v in ipairs(items) do
        local item = self.dailyItem_[v]
        local taskCid = self.daiyTask_[i]
        local taskCfg = TaskDataMgr:getTaskCfg(taskCid)
        local taskInfo = TaskDataMgr:getTaskInfo(taskCid)
        local progress = math.min(taskInfo.progress, taskCfg.progress)
        item.Label_progress:setTextById(800005, progress, taskCfg.progress)
        item.Image_icon:setTexture(taskCfg.icon)
        local desc = TaskDataMgr:getTaskDesc(taskCid)
        item.Label_desc:setText(desc)
        item.Label_name:setTextById(taskCfg.name)
        item.Image_type:setVisible(#taskCfg.typeDes > 0)
        item.Label_type:setVisible(#taskCfg.typeDes > 0)
        local isOpenDoubleCard = ActivityDataMgr2:isOpen(EC_ActivityType2.DOUBLE_CARD)
        local isDoubleCardItem = taskCid == 200001 and isOpenDoubleCard
        item.Image_tips:setVisible(isDoubleCardItem)
        if item.Label_type:isVisible() then
            self:addCountDownTimer()
            item.Label_type:setTextById(taskCfg.typeDes)
        end
        -- local size=  item.Label_name:Size()
        -- item.Image_active:PosX(size.width + 10)

        local showReward = {}
        local activeReward
        for i, v in ipairs(taskCfg.reward) do
            if v[1] == EC_SItemType.ACTIVITY then
                activeReward = v
            else
                table.insert(showReward, v)
            end
        end
        item.Label_active_num:setVisible(tobool(activeReward))
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
    self:updateDoubleCardCountdown()

    for i, v in ipairs(self.activeItem_) do
        local taskInfo = TaskDataMgr:getTaskInfo(self.activeTask_[i])
        v.Panel_geted:setVisible(taskInfo.status == EC_TaskStatus.GETED)
        v.Panel_canGet:setVisible(taskInfo.status == EC_TaskStatus.GET)
        v.Panel_notGet:setVisible(taskInfo.status == EC_TaskStatus.ING)
    end


    local count = GoodsDataMgr:getItemCount(EC_SItemType.ACTIVITY)
    local percent = me.clampf(count / self.maxActive_, 0, 1)
    self.LoadingBar_activeProgress:setPercent(percent * 100)
    self.Label_activeValue:setText(count)

    self:updateRedPointStatus()
end

function TaskMainView:cellSizeForTable()
    local size = self.Panel_honorItem:getSize()
    return size.height, size.width
end

function TaskMainView:tableScroll(tableView)
    local contentOffset = tableView:getContentOffset()
    local contentSize   = tableView:getContentSize()
    local size          = tableView:getSize()
    local length        = contentSize.height - size.height
    local percent = clamp(-contentOffset.y / length, 0, 1)
    self.Image_honorScrollBar:setPercent(percent)
end

function TaskMainView:tableCellAtIndex(tab, idx)
    local cell = tab:dequeueCell()
    idx = idx + 1
    if not cell then
        cell = TFTableViewCell:create()
        local item = self.Panel_honorItem:clone():show()
        item:setAnchorPoint(ccp(0, 0))
        item:setPosition(ccp(0, 0))
        cell:addChild(item)
        cell.item = item
    end
    cell.idx = idx

    if cell.item then
        self:updateHonorTaskItem(cell, idx)
    end

    return cell
end

function TaskMainView:numberOfCellsInTableView()
    return #self.honorTask_
end

function TaskMainView:updateHonorTaskItem(item, index)
    local Label_progress = TFDirector:getChildByPath(item, "Label_progress")
    local Image_icon = TFDirector:getChildByPath(item, "Image_icon")
    local Label_name = TFDirector:getChildByPath(item, "Label_name")
    local Image_active = TFDirector:getChildByPath(Label_name, "Image_active"):hide()
    local Image_active_icon = TFDirector:getChildByPath(Image_active, "Image_active_icon")
    local Label_active_num = TFDirector:getChildByPath(Image_active, "Label_active_num")
    local Label_desc = TFDirector:getChildByPath(item, "Label_desc")
    local Panel_reward = {}
    for i = 1, 3 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(item, "Image_reward_" .. i)
        foo.Panel_goodsItem = TFDirector:getChildByPath(foo.root, "Panel_goodsItem")
        if not foo.Panel_goodsItem then
            foo.Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            foo.Panel_goodsItem:Scale(0.75)
            foo.Panel_goodsItem:Pos(0, 0):AddTo(foo.root)
        end
        Panel_reward[i] = foo
    end
    local Button_goto = TFDirector:getChildByPath(item, "Button_goto")
    local Label_goto = TFDirector:getChildByPath(Button_goto, "Label_goto")
    local Button_receive = TFDirector:getChildByPath(item, "Button_receive")
    local Label_receive = TFDirector:getChildByPath(Button_receive, "Label_receive")
    local Label_reward = TFDirector:getChildByPath(item, "Label_reward")
    Label_reward:setTextById(1300018)
    local Image_type = TFDirector:getChildByPath(item, "Image_type")
    local Label_type = TFDirector:getChildByPath(item, "Label_type")
    local Label_geted = TFDirector:getChildByPath(item, "Label_geted")

    local taskCid = self.honorTask_[index]
    local taskCfg = TaskDataMgr:getTaskCfg(taskCid)
    local taskInfo = TaskDataMgr:getTaskInfo(taskCid)
    local progress = math.min(taskInfo.progress, taskCfg.progress)
    Label_progress:setTextById(800005, progress, taskCfg.progress)
    Image_icon:setTexture(taskCfg.icon)
    local desc = TaskDataMgr:getTaskDesc(taskCid)
    Label_desc:setText(desc)
    Label_name:setTextById(taskCfg.name)
    Label_type:setVisible(#taskCfg.typeDes > 0)
    Image_type:setVisible(#taskCfg.typeDes > 0)
    if Label_type:isVisible() then
        Label_type:setTextById(taskCfg.typeDes)
    end
    local size=  Label_name:Size()
    Image_active:PosX(size.width + 10)

    for j, Panel_reward in ipairs(Panel_reward) do
        local reward = taskCfg.reward[j]
        if reward then
            Panel_reward.Panel_goodsItem:show()
            PrefabDataMgr:setInfo(Panel_reward.Panel_goodsItem, reward[1], reward[2])
        else
            Panel_reward.Panel_goodsItem:hide()
        end
    end

    Button_receive:setVisible(taskInfo.status == EC_TaskStatus.GET)
    Label_geted:setVisible(taskInfo.status == EC_TaskStatus.GETED)
    Label_receive:setTextById(1300008)
    Button_goto:setVisible(taskInfo.status == EC_TaskStatus.ING and taskCfg.jumpInterface ~= 0)
    Label_goto:setTextById(1300009)

    Button_goto:onClick(function()
            if taskCfg.subType == EC_TaskSubType.LEVEL then
                local levelId = taskCfg.finishParams["dunId"]
                FunctionDataMgr:enterByFuncId(taskCfg.jumpInterface, levelId)
            else
                FunctionDataMgr:enterByFuncId(taskCfg.jumpInterface)
            end
    end)

    Button_receive:onClick(function()
            TaskDataMgr:send_TASK_SUBMIT_TASK(taskInfo.cid)
    end)
end

function TaskMainView:showHonorTask()
    self.honorTask_ = TaskDataMgr:getTask(EC_TaskType.HONOR)
    self.TableView_honor:reloadData()

    local contentOffset = self.TableView_honor:getContentOffset()
    local contentSize   = self.TableView_honor:getContentSize()
    local size          = self.TableView_honor:getSize()
    local length        = contentSize.height - size.height

    local ratio = size.height / contentSize.height
    self.Image_honorScrollBar:setRatio(ratio)
    self.Image_honorScrollBar:setPercent(1)

    local percent = clamp(-contentOffset.y / length, 0, 1)
    self.Image_honorScrollBar:setPercent(percent)

    self:updateRedPointStatus()
end

function TaskMainView:showActivityTask()
    self.activityTask_ = TaskDataMgr:getTask(EC_TaskType.ACTIVITY)

    local items = self.ListView_activity:getItems()

    for k,v in pairs(self.activityTask_) do
        if v == 50001 then
            table.removeItem(self.activityTask_,v);
            break;
        end
    end

    local gap = #self.activityTask_ - #items
    if gap > 0 then
        for i = 1, math.abs(gap) do
            local taskCid = self.activityTask_[i]
            local Panel_mainItem = self:addActivityItem()
            Panel_mainItem:setName("Panel_mainItem"..i);
            self.ListView_activity:pushBackCustomItem(Panel_mainItem)
        end
    else
        for i = 1, math.abs(gap) do
            self.ListView_activity:removeItem(1)
        end
    end

    local items = self.ListView_activity:getItems()
    for i, v in ipairs(items) do
        local item = self.activityItem_[v]
        local taskCid = self.activityTask_[i]
        local taskCfg = TaskDataMgr:getTaskCfg(taskCid)
        local taskInfo = TaskDataMgr:getTaskInfo(taskCid)
        local progress = math.min(taskInfo.progress, taskCfg.progress)
        item.Label_progress:setTextById(800005, progress, taskCfg.progress)
        item.Image_icon:setTexture(taskCfg.icon)
        item.Label_name:setTextById(taskCfg.name)
        item.Image_type:setVisible(#taskCfg.typeDes > 0)
        item.Label_type:setVisible(#taskCfg.typeDes > 0)
        if item.Label_type:isVisible() then
            item.Label_type:setTextById(taskCfg.typeDes)
        end
        item.Label_type:setTextById(taskCfg.typeDes)
        local desc = TaskDataMgr:getTaskDesc(taskCid)
        item.Label_desc:setText(desc)
        local size = item.Label_name:Size()
        item.Image_active:PosX(size.width + 10)

        for j, Panel_reward in ipairs(item.Panel_reward) do
            local reward = taskCfg.reward[j]
            if reward then
                Panel_reward.Panel_goodsItem:show()
                PrefabDataMgr:setInfo(Panel_reward.Panel_goodsItem, reward[1], reward[2])
            else
                Panel_reward.Panel_goodsItem:hide()
            end
        end

        item.Button_receive:setVisible(taskInfo.status == EC_TaskStatus.GET)
        item.Label_geted:setVisible(taskInfo.status == EC_TaskStatus.GETED)
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

    self:updateRedPointStatus()
end

function TaskMainView:showTrainingView()
    if not self.trainingTableView then
        self:initTrainingTableView()
    end
    self:updateTrainingItems()
    local trainingLevel = ActivityDataMgr2:getWarOrderLevel()
    local posX = 740 - ((trainingLevel + (trainingLevel > 140 and 0 or 6)) * 108)
    self.trainingTableView:setContentOffset(ccp(math.min(posX, 0),0), 0.3)
    self:updateTrainingInfo()
    self.Button_upgrade:show()
    self.Button_get_all:show()
    self.Button_shop:show()
    self:updateRedPointStatus()
    local trainingShopTips = CCUserDefault:sharedUserDefault():getStringForKey("training_shop_tips")
    self.Image_training_shop_tips:setVisible(trainingShopTips ~= "geted")
    self:timeOut(function()
        self:updatePreviewItems()
    end,0.3)
end

function TaskMainView:initTrainingTableView()
    self.trainingTableView =  TFTableView:create()
    self.trainingTableView:setName("trainingTableView")
    self.Panel_training_reward = TFDirector:getChildByPath(self.Panel_training, "Panel_training_reward")
    local tableViewSize = self.Panel_training_reward:getContentSize()
    self.trainingTableView:setTableViewSize(CCSizeMake(tableViewSize.width, tableViewSize.height))
    self.trainingTableView:setDirection(TFTableView.TFSCROLLHORIZONTAL)
    self.trainingTableView:setPosition(self.Panel_training_reward:getPosition())
    self.trainingTableView:setAnchorPoint(self.Panel_training_reward:getAnchorPoint())
    self.trainingTableView.logic = self

    self.trainingTableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.trainingTableCellSize,self))
    self.trainingTableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.trainingNumberOfCells,self))
    self.trainingTableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.trainingTableCellAtIndex,self))
    self.trainingTableView:addMEListener(TFTABLEVIEW_SCROLL, handler(self.trainingTableScroll,self))
    self.Panel_training_reward:getParent():addChild(self.trainingTableView,10)
end


function TaskMainView:trainingTableCellSize(tableView,idx)
    local size = self.Panel_training_item:getContentSize()
    return size.height, size.width
end

function TaskMainView:trainingNumberOfCells(tableView)
    self.trainingCfgs = TaskDataMgr:getTraningCfgs(true)
    local count = table.count(self.trainingCfgs)
    return count
end

function TaskMainView:trainingTableCellAtIndex(tableView, idx)
    local cell = tableView:dequeueCell()
    idx = idx +1
    if cell == nil then
        tableView.cells = tableView.cells or {}
        cell = TFTableViewCell:create()
        local item = self.Panel_training_item:clone()
        item:setAnchorPoint(CCPointMake(0,0))
        item:setPosition(CCPointMake(0, 0))
        cell:addChild(item)
        cell.item = item
    end

    local item = cell.item
    local Label_level = TFDirector:getChildByPath(item, "Label_level")
    local Image_free_item_frame = TFDirector:getChildByPath(item, "Image_free_item_frame")
    local Image_free_item_icon = TFDirector:getChildByPath(item, "Image_free_item_icon")
    local Label_free_item_count = TFDirector:getChildByPath(item, "Label_free_item_count")
    local Image_free_can_get = TFDirector:getChildByPath(item, "Image_free_can_get"):hide()
    local Image_free_geted = TFDirector:getChildByPath(item, "Image_free_geted")
    local Image_charge_item_frame = TFDirector:getChildByPath(item, "Image_charge_item_frame")
    local Image_charge_item_icon = TFDirector:getChildByPath(item, "Image_charge_item_icon")
    local Label_charge_item_count = TFDirector:getChildByPath(item, "Label_charge_item_count")
    local Image_charge_can_get = TFDirector:getChildByPath(item, "Image_charge_can_get"):hide()
    local Image_charge_geted = TFDirector:getChildByPath(item, "Image_charge_geted")
    local Image_lock = TFDirector:getChildByPath(item, "Image_lock"):hide()

    local cfgGroup = self.trainingCfgs[idx]
    local trainingLevel = ActivityDataMgr2:getWarOrderLevel()
    local chargeState = ActivityDataMgr2:getWarOrderChargeState()
    for j,cfg in ipairs(cfgGroup) do
        Label_level:setText("Lv"..cfg.condition)
        local reward = cfg.reward[1]
        
        local getState = reward and ActivityDataMgr2:checkWarOrderItemState(cfg.id) or 2
        if cfg.type == 1 then
            if reward then
                Image_free_item_frame:setVisible(true)
                Image_free_item_icon:setVisible(true)
                Label_free_item_count:setVisible(true)
                local itemCfg = GoodsDataMgr:getItemCfg(reward[1])
                Image_free_item_frame:setTexture(EC_ItemIcon[itemCfg.quality])
                Image_free_item_icon:setTexture(itemCfg.icon)
                Label_free_item_count:setText(reward[2])
                Image_free_item_icon:onClick(function ()
                    Utils:showInfo(reward[1], nil, true)
                end)
                Image_free_item_icon:setScale(0.8)
                if itemCfg.superType == EC_ResourceType.SPIRIT or itemCfg.superType == EC_ResourceType.DRESS then
                    Image_free_item_icon:setScale(0.72)
                end

                Image_free_can_get:setVisible(trainingLevel >= cfg.condition and  getState~= 2)
                Image_free_geted:setVisible(getState == 2)
                Image_free_item_icon:setTouchEnabled(true)
                Image_free_can_get:setTouchEnabled(true)
                Image_free_can_get:onClick(function ()
                    ActivityDataMgr2:reqGetWarOrderAward(cfg.returnnewbleId,cfg.id)
                end)
            else
                Image_free_item_frame:setVisible(false)
                Image_free_item_icon:setVisible(false)
                Label_free_item_count:setVisible(false)
                Image_free_geted:setVisible(false)
            end
        else
            if reward then
                Image_charge_item_frame:setVisible(true)
                Image_charge_item_icon:setVisible(true)
                Label_charge_item_count:setVisible(true)
                local itemCfg = GoodsDataMgr:getItemCfg(reward[1])
                Image_charge_item_frame:setTexture(EC_ItemIcon[itemCfg.quality])
                Image_charge_item_icon:setTexture(itemCfg.icon)
                Label_charge_item_count:setText(reward[2])
                Image_charge_can_get:setVisible(chargeState ~= 0 and trainingLevel >= cfg.condition and  getState~= 2)
                Image_lock:setVisible(chargeState == 0)
                Image_charge_geted:setVisible(getState == 2)
                Image_charge_item_icon:setTouchEnabled(true)
                Image_charge_item_icon:onClick(function ()
                    Utils:showInfo(reward[1], nil, true)
                end)
                Image_charge_item_icon:setScale(0.8)
                if itemCfg.superType == EC_ResourceType.SPIRIT or itemCfg.superType == EC_ResourceType.DRESS then
                    Image_charge_item_icon:setScale(0.72)
                end

                Image_charge_can_get:setTouchEnabled(true)
                Image_charge_can_get:onClick(function ()
                    ActivityDataMgr2:reqGetWarOrderAward(cfg.returnnewbleId,cfg.id)
                end)
            else
                Image_charge_item_frame:setVisible(false)
                Image_charge_item_icon:setVisible(false)
                Label_charge_item_count:setVisible(false)
                Image_charge_geted:setVisible(false)
            end
        end
    end
    self.curPreviewIdx = math.max(1, math.floor(idx - 1))
    return cell
end

function TaskMainView:trainingTableScroll(tableView)
    self.timerAdd = self.timerAdd + 1
    if self.timerAdd % 100 == 0 then
        self:updatePreviewItems()
    end
end

function TaskMainView:updatePreviewItems()
    local specialInfo = TaskDataMgr:getSpecialRewards(self.curPreviewIdx or 1)
    if specialInfo.level then
        local rewards = specialInfo.rewards
        self.Label_preview_level:setText("Lv"..specialInfo.level) 
        for i, item in ipairs(self.previewItems) do
            local reward = rewards[i]
            local goodsItem = item:getChildByTag(88)
            if reward then
                if not goodsItem then
                    goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
                    goodsItem:Scale(0.8)
                    goodsItem:setPosition(ccp(0,0))
                    item:addChild(goodsItem,1,88)
                end
                goodsItem:show()
                PrefabDataMgr:setInfo(goodsItem, reward[1], reward[2])
            else
                if goodsItem then
                    goodsItem:hide()
                end
            end
        end
    end
end

function TaskMainView:showTrainingTask()
    self:updateTrainingInfo()
    self:updateTrainingTask()
    self.Button_upgrade:hide()
    self.Button_get_all:hide()
    self.Button_shop:hide()
end

function TaskMainView:updateTrainingInfo()
    local trainingLevel = ActivityDataMgr2:getWarOrderLevel()
    self.Label_cur_train_level:setText("Lv."..trainingLevel)
    local levelExp = ActivityDataMgr2:getWarOrderExp()
    local levelMaxExp = TaskDataMgr:getTrainingLevelExpMax(trainingLevel)
    if trainingLevel >= ActivityDataMgr2:getWarOrderMaxLevel() then
        self.Label_level_exp:setText(TextDataMgr:getText(14220069).."："..levelMaxExp.."/"..levelMaxExp)
        self.LoadingBar_levelProgress:setPercent(100)
        self.Button_buy_level:setTouchEnabled(false)
        self.Button_buy_level:setGrayEnabled(true)
    else
        self.Label_level_exp:setText(TextDataMgr:getText(14220069).."："..levelExp.."/"..levelMaxExp)
        self.LoadingBar_levelProgress:setPercent(levelExp / levelMaxExp * 100)
    end
    self.Label_unlock_reward:setText("解锁资格")
    if ActivityDataMgr2:getWarOrderChargeState() == 1 then
        self.Label_unlock_reward:setText("升级资格")
    end
    self:addCountDownTimer()
    self:updateTrainingTime()
end

function TaskMainView:updateTrainingTime()
    local serverTime = ServerDataMgr:getServerTime()
    local activityInfo = ActivityDataMgr2:getWarOrderAcrivityInfo()
    local isEnd = serverTime > activityInfo.endTime
    local remainTime
    if isEnd then
        remainTime = math.max(0, activityInfo.showEndTime - serverTime)
    else
        remainTime = math.max(0, activityInfo.endTime - serverTime) 
    end
    local day, hour, min, sec = Utils:getTimeDHMZ(remainTime, true)
    if day == "00" then
        self.Label_training_time:setText("倒计时："..hour.."时"..min.."分"..sec.."秒")
    else
        self.Label_training_time:setText("倒计时："..day.."天"..hour.."时"..min.."分")
    end
end


function TaskMainView:updateTrainingItems()
    if self.trainingTableView then
        self.trainingTableView:reloadData()
    end
    self:updatePreviewItems()
    local canGet = TaskDataMgr:checkWarOrderRedPoint()
    self.Button_get_all:setTouchEnabled(canGet)
    self.Button_get_all:setGrayEnabled(not canGet)
    self.Panel_lock_cover:setVisible(ActivityDataMgr2:getWarOrderChargeState() == 0)
end

function TaskMainView:addTrainingTaskItem(idx)
    local training_taskItem = self.Panel_training_task_item:clone()
    local item = {}
    item.root = training_taskItem
    item.Image_diban = TFDirector:getChildByPath(item.root, "Image_diban")
    item.Label_progress = TFDirector:getChildByPath(item.root, "Label_progress")
    item.Label_name = TFDirector:getChildByPath(item.root, "Label_name")
    item.Label_desc = TFDirector:getChildByPath(item.root, "Label_desc")
    item.Image_reward = TFDirector:getChildByPath(item.root, "Image_reward")
    item.Label_state = TFDirector:getChildByPath(item.root, "Label_state")
    item.Button_get = TFDirector:getChildByPath(item.root, "Button_get")
    item.Button_goto = TFDirector:getChildByPath(item.root, "Button_goto")
    item.LabeButton_goto = TFDirector:getChildByPath(item.root, "LabeButton_goto")
    item.Label_reset_tips = TFDirector:getChildByPath(item.root, "Label_reset_tips")
    local ScrollView_reward = TFDirector:getChildByPath(item.root, "ScrollView_reward")
    item.Label_hero_exp = TFDirector:getChildByPath(item.root, "Label_hero_exp")
    item.Label_gongzhu_exp = TFDirector:getChildByPath(item.root, "Label_gongzhu_exp")
    item.LoadingBar_progress = TFDirector:getChildByPath(item.root, "LoadingBar_progress")
    item.ListView_reward = UIListView:create(ScrollView_reward)
    item.ListView_reward:setItemsMargin(20)

    self.trainingTaskItem_[item.root] = item
    return training_taskItem
end

function TaskMainView:updateTrainingTask()
    self.trainingTaskData = ActivityDataMgr2:getItems(self.warOrderActivity.id)
    local items = self.ListView_training_task:getItems()

    local items = self.ListView_training_task:getItems()
    local gap = #self.trainingTaskData - #items
    if gap > 0 then
        for i = 1, math.abs(gap) do
            local Panel_mainItem = self:addTrainingTaskItem(i)
            Panel_mainItem:setName("Panel_mainItem"..i);
            self.ListView_training_task:pushBackCustomItem(Panel_mainItem)
        end
    else
        for i = 1, math.abs(gap) do
            self.ListView_training_task:removeItem(1)
        end
    end

    local loadIndex = 1
    local items = self.ListView_training_task:getItems()
    local function updateTaskItem()
        local item = items[loadIndex]
        if not item then
            return
        end

        local foo = self.trainingTaskItem_[item]
        foo.idx = loadIndex
        local progressInfo = ActivityDataMgr2:getProgressInfo(self.warOrderActivity.activityType, self.trainingTaskData[foo.idx])
        local itemInfo = ActivityDataMgr2:getItemInfo(self.warOrderActivity.activityType, self.trainingTaskData[foo.idx])
        foo.Image_diban:setTexture("ui/task/training/ui_019.png")
        foo.Label_reset_tips:setText("")
        foo.Label_name:setColor(ccc3(48,61,153))
        local isReceive = progressInfo.status == EC_TaskStatus.GET
        local isGeted = progressInfo.status == EC_TaskStatus.GETED
        local isIng = progressInfo.status == EC_TaskStatus.ING
        foo.Label_reset_tips:setVisible(not isGeted)
        if itemInfo.extendData.resetType == 2 then
            foo.Label_reset_tips:setTextById(14220067)
            foo.Image_diban:setTexture("ui/task/training/ui_016.png")
        elseif itemInfo.extendData.resetType == 3 then
            foo.Label_reset_tips:setTextById(111000114)
            foo.Label_name:setColor(ccc3(195,132,76))
            foo.Image_diban:setTexture("ui/task/training/ui_018.png")
        end
        foo.Label_name:setTextById(tonumber(itemInfo.details))
        foo.Label_desc:setText(itemInfo.extendData.des2 or "")
        foo.Label_progress:setText(progressInfo.progress .. "/" .. itemInfo.target)
        foo.LoadingBar_progress:setPercent(progressInfo.progress / itemInfo.target * 100)
        foo.Label_state:setVisible(isGeted)
        foo.Label_state:setTextById(14220068)

        foo.ListView_reward:removeAllItems()
        for cid, num in pairs(itemInfo.reward) do
            if cid == 500005 then
                foo.Label_hero_exp:setText("x"..num)
            elseif cid == 500074 then
                foo.Label_gongzhu_exp:setText("x"..num)
            else
                local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
                PrefabDataMgr:setInfo(Panel_goodsItem, cid, num)
                Panel_goodsItem:Scale(0.8)
                foo.ListView_reward:pushBackCustomItem(Panel_goodsItem)
            end
        end

        foo.Button_get:setVisible(isReceive)
        foo.Button_get:onClick(function()
            ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.warOrderActivity.id, self.trainingTaskData[foo.idx])
        end)

        foo.Button_goto:setVisible(isIng and itemInfo.extendData.jumpInterface and itemInfo.extendData.jumpInterface ~= 0)
        foo.Button_goto:onClick(function()
           FunctionDataMgr:enterByFuncId(itemInfo.extendData.jumpInterface)
        end)

        local fadeInDuration = 0.2
        local delayDuration = 0.05
        item:fadeIn(fadeInDuration)
        local seq = Sequence:create({
                DelayTime:create(delayDuration),
                CallFunc:create(function()
                        loadIndex = loadIndex + 1
                        updateTaskItem()
                end)
        })
        item:runAction(seq)
    end
    updateTaskItem()
    self:updateRedPointStatus()
end


function TaskMainView:onUpdateTrainingUI()
    if not ActivityDataMgr2:isWarOrderActivityOpen() then
        return
    end
    self:updateTrainingItems()
    self:updateTrainingInfo()
end

function TaskMainView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.warOrderActivity.id == activitId then
        Utils:showReward(reward)
        self:timeOut(function()
            self:updateTrainingTask()
        end, 0.5)
    end
end

function TaskMainView:updateRedPointStatus()
    for i, v in ipairs(self.ListView_tab:getItems()) do
        local item = self.tabItem_[v]
        local tabData = self.tabData_[i]
        local isCanReceive = false
        if tabData.type_ == EC_TaskPage.MAIN then
            isCanReceive = TaskDataMgr:isCanReceiveTask(EC_TaskType.MAIN)
        elseif tabData.type_ == EC_TaskPage.DAILY then
            isCanReceive = TaskDataMgr:isCanReceiveTask(EC_TaskType.DAILY)
        elseif tabData.type_ == EC_TaskPage.HONOR then
            isCanReceive = TaskDataMgr:isCanReceiveTask(EC_TaskType.HONOR)
        elseif tabData.type_ == EC_TaskPage.ACTIVITY then
            isCanReceive = TaskDataMgr:isCanReceiveTask(EC_TaskType.ACTIVE)
        elseif tabData.type_ == EC_TaskPage.TRAININIG then
            isCanReceive = TaskDataMgr:checkWarOrderRedPoint()
        elseif tabData.type_ == EC_TaskPage.TRAININIG_TASK then
            isCanReceive = ActivityDataMgr2:checkWarOrderTaskRedPoint()
        end
        item.Image_tips:setVisible(isCanReceive)
    end
end

function TaskMainView:registerEvents()
    EventMgr:addEventListener(self, EV_TASK_UPDATE, handler(self.onTaskUpdateEvent, self))
    EventMgr:addEventListener(self, EV_TASK_RECEIVE, handler(self.onTaskReceiveEvent, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onUpdateActiveEvent, self))

    EventMgr:addEventListener(self, EV_ACTIVITY_WAR_ORDER_GET_REWARD, handler(self.onUpdateTrainingUI, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_WAR_ORDER_UPDATE_INFO, handler(self.onUpdateTrainingUI, self))
    EventMgr:addEventListener(self, EV_RECHARGE_UPDATE, handler(self.onUpdateTrainingUI, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))

    for i, v in ipairs(self.ListView_tab:getItems()) do
        local item = self.tabItem_[v]
        item.root:onClick(function()
                self:selectTab(i)
        end)
    end

    local selectIndex = nil
    for i, v in ipairs(self.activeItem_) do
        v.Button_geted:onClick(function()
                -- local visible = self.Image_preview:isVisible()
                -- self.Image_preview:setVisible(not visible or selectIndex ~= i)
                -- if self.Image_preview:isVisible() then
                --     selectIndex = i
                -- end
                self:showPreview(i)
        end)
        v.Button_canGet:onClick(function()
                local taskInfo = TaskDataMgr:getTaskInfo(self.activeTask_[i])
                TaskDataMgr:send_TASK_SUBMIT_TASK(taskInfo.cid)
        end)
        v.Button_notGet:onClick(function()
                -- local visible = self.Image_preview:isVisible()
                -- self.Image_preview:setVisible(not visible or selectIndex ~= i)
                -- if self.Image_preview:isVisible() then
                --     selectIndex = i
                -- end
                self:showPreview(i)
        end)
    end

    self.Button_buy_level:onClick(function()
        if ActivityDataMgr2:getWarOrderLevel() >= ActivityDataMgr2:getWarOrderMaxLevel() then

        else
            Utils:openView("task.TaskTrainingBuyLevelView")
        end
    end)

    self.Button_upgrade:onClick(function()
        self:selectTab(4)
    end)
    self.Button_unlock_reward:onClick(function()
        FunctionDataMgr:jWarOrderBuy()
    end)

    self.Button_get_all:onClick(function()
        local state = ActivityDataMgr2:getWarOrderChargeState()
        if state ~= 0 then
            ActivityDataMgr2:reqGetWarOrderAward(self.warOrderActivity.id,0)
        else
            Utils:openView("task.TaskTrainingFastRewardView")
        end
    end)

    self.Button_shop:onClick(function()
        CCUserDefault:sharedUserDefault():setStringForKey("training_shop_tips","geted")
        self.Image_training_shop_tips:hide()
        Utils:openView("store.WarOrderView")
    end)

    self.Panel_touch:setSwallowTouch(false)
    self.Panel_touch:setSize(GameConfig.WS)
    self.Panel_touch:onTouch(function()
            --self.Image_preview:hide()
    end)
end

function TaskMainView:onTaskUpdateEvent(taskCid)
    self:showTask()
end

function TaskMainView:onTaskReceiveEvent(reward)
    Utils:showReward(reward)
end

function TaskMainView:onUpdateActiveEvent(oldItem, newItem)
    local itemCid
    if oldItem then
        itemCid = oldItem.cid
    else
        itemCid = newItem.cid
    end
    if itemCid == EC_SItemType.ACTIVITY then
        self:showTask()
    end
end

function TaskMainView:onShow()
    self.super.onShow(self)
    self:timeOut(function()
        self:removeLockLayer()
        GameGuide:checkGuide(self)
    end,0.1)
end

function TaskMainView:onCountDownPer()
    local tabData = self.tabData_[self.selectIndex_]
    if tabData.type_ == EC_TaskPage.DAILY then
        self:updateDoubleCardCountdown()
    elseif tabData.type_ == EC_TaskPage.TRAINING or tabData.type_ == EC_TaskPage.TRAININIG_TASK then
        self:updateTrainingTime()
    end
end

function TaskMainView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.onCountDownPer, self))
    end
end

function TaskMainView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
    end
end

function TaskMainView:removeEvents()
    self:removeCountDownTimer()
end

---------------------------guide------------------------------

--引导领取奖励
function TaskMainView:excuteGuideFunc6001(guideFuncId)
    local items = self.ListView_main:getItems()
    local targetNode
    for i, v in ipairs(items) do
        targetNode = TFDirector:getChildByPath(v, "Button_receive")
        break
    end

    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

return TaskMainView
