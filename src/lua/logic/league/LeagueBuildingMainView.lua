
local LeagueBuildingMainView = class("LeagueBuildingMainView", BaseLayer)

function LeagueBuildingMainView:initData(buildingType)
    self.tabData_ = {
        {
            type_ = EC_BuidingType.FUSION,
            icon = "ui/league/ui_42.png",
            text = 270457,
        },
    }

    self.defaultSelectIndex_ = 1
    if buildingType then
        for i, v in ipairs(self.tabData_) do
            if v.type_ == buildingType then
                self.defaultSelectIndex_ = i
                break
            end
        end
    end

    self.tabItem_ = {}
    self.taskItem_ = {}
    self.activeItem_ = {}
    self.selectIndex_ = nil
    self.maxStage_ = LeagueDataMgr:getUnionFusionStageMaxActive(LeagueDataMgr:getUnionLevel())
end

function LeagueBuildingMainView:getClosingStateParams()
    for i, v in ipairs(self.tabData_) do
        if self.selectIndex_ == i then
            return {v.type_}
        end
    end
end

function LeagueBuildingMainView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.league.leagueBuildingMainView")
end

function LeagueBuildingMainView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_tabItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_tabItem")
    self.Panel_task_Item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_task_Item")
    self.Panel_activeItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_activeItem")

    local ScrollView_tab = TFDirector:getChildByPath(self.Panel_root, "ScrollView_tab")
    self.ListView_tab = UIListView:create(ScrollView_tab)

    self.Panel_fusion = TFDirector:getChildByPath(self.Panel_root, "Panel_fusion")
    self.Panel_fusion_info = TFDirector:getChildByPath(self.Panel_fusion, "Panel_fusion_info")
    self.Label_fusion_name = TFDirector:getChildByPath(self.Panel_fusion_info, "Label_fusion_name")
    self.Image_fusion_icon = TFDirector:getChildByPath(self.Panel_fusion_info, "Image_fusion_icon")
    self.Label_level_num = TFDirector:getChildByPath(self.Panel_fusion_info, "Label_level_num")
    self.LoadingBar_exp = TFDirector:getChildByPath(self.Panel_fusion_info, "LoadingBar_exp")
    self.Label_exp_percent = TFDirector:getChildByPath(self.Panel_fusion_info, "Label_exp_percent")
    self.Label_fusion_desc = TFDirector:getChildByPath(self.Panel_fusion_info, "Label_desc")

    local Panel_active = TFDirector:getChildByPath(self.Panel_fusion, "Panel_active")
    self.Image_active_progress = TFDirector:getChildByPath(self.Panel_fusion, "Image_active_progress")
    self.LoadingBar_activeProgress = TFDirector:getChildByPath(self.Image_active_progress, "LoadingBar_activeProgress")
    self.Image_activeIcon = TFDirector:getChildByPath(Panel_active, "Image_activeIcon")
    self.Label_activeTitle = TFDirector:getChildByPath(Panel_active, "Label_activeTitle")
    self.Label_activeValue = TFDirector:getChildByPath(Panel_active, "Label_activeValue")
    self.Label_fusion_tips = TFDirector:getChildByPath(self.Panel_fusion, "Label_tips")
    local Image_taskBar = TFDirector:getChildByPath(self.Panel_fusion, "Image_taskBar")
    local Image_taskScrollBar = TFDirector:getChildByPath(Image_taskBar, "Image_taskScrollBar")
    local scrollBar = UIScrollBar:create(Image_taskBar, Image_taskScrollBar)
    local ScrollView_task = TFDirector:getChildByPath(self.Panel_fusion, "ScrollView_task")
    self.ListView_task = UIListView:create(ScrollView_task)
    self.ListView_task:setScrollBar(scrollBar)
    self.Panel_touch = TFDirector:getChildByPath(self.Panel_fusion, "Panel_touch")

    self.Label_fusion_desc:setTextById(270357)
    self.Label_fusion_tips:setTextById(270354)
    -- self.Image_preview = Utils:previewReward()
    -- self.Image_preview:setAnchorPoint(ccp(0.5, 1))
    -- self.Image_preview:AddTo(self.Panel_root):setZOrder(1)

    self:refreshView()
end

function LeagueBuildingMainView:refreshView()
    self:initTabBtn()
    self:initTaskActive()
    self:selectTab(self.defaultSelectIndex_)

end

function LeagueBuildingMainView:initTaskActive()
    self.stageData_ = LeagueDataMgr:getUnionFusionStageInfo(LeagueDataMgr:getUnionLevel())
    local size = self.Image_active_progress:Size()
    for i = #self.stageData_, 1, -1 do
        local stageInfo = self.stageData_[i]
        local percent = stageInfo.stage / self.maxStage_
        local Panel_activeItem = self.Panel_activeItem:clone()
        local item = {}
        item.root = Panel_activeItem
        item.Panel_geted = TFDirector:getChildByPath(item.root, "Panel_geted")
        item.Panel_notGet = TFDirector:getChildByPath(item.root, "Panel_notGet")
        item.Panel_canGet = TFDirector:getChildByPath(item.root, "Panel_canGet")
        item.Button_geted = TFDirector:getChildByPath(item.root, "Button_geted")
        item.Button_canGet = TFDirector:getChildByPath(item.root, "Button_canGet")
        local spine_receive = TFDirector:getChildByPath(item.root, "Spine_receive")
        spine_receive:playByIndex(0,-1,-1,1)
        item.Button_notGet = TFDirector:getChildByPath(item.root, "Button_notGet")
        item.Label_getValue = TFDirector:getChildByPath(item.root, "Label_getValue")
        item.Label_getValue:setText(stageInfo.stage)
        self.activeItem_[i] = item
        Panel_activeItem:Pos(size.width * percent, -6):AddTo(self.Image_active_progress,15)
    end
end

function LeagueBuildingMainView:initTabBtn()
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

function LeagueBuildingMainView:selectTab(index)
    if self.selectIndex_ == index then return end
    -- self.Image_preview:hide()
    self.selectIndex_ = index
    for i, v in ipairs(self.ListView_tab:getItems()) do
        local item = self.tabItem_[v]
        item.Image_select:setVisible(index == i)
    end

    self:showBuildingView()
end

function LeagueBuildingMainView:showBuildingView()
    self.Panel_fusion:hide()
    local tabData = self.tabData_[self.selectIndex_]
    if tabData.type_ == EC_BuidingType.FUSION then
        self.Panel_fusion:show()
        self:showFusionTask()
    end
end

function LeagueBuildingMainView:showPreview(index)
    local stageInfo = self.stageData_[index]
    local item = self.activeItem_[index]
    local wp = item.root:getParent():convertToWorldSpace(item.root:Pos())
    -- local np = self.Image_preview:getParent():convertToNodeSpaceAR(wp)

    self.Image_preview = Utils:previewReward(self.Image_preview, stageInfo.reward)

    -- self.Image_preview:Pos(np)
end


function LeagueBuildingMainView:addFusionTaskItem()
    local Panel_task_Item = self.Panel_task_Item:clone()
    local item = {}
    item.root = Panel_task_Item
    item.Label_progress = TFDirector:getChildByPath(item.root, "Label_progress")
    item.Image_icon = TFDirector:getChildByPath(item.root, "Image_icon")
    item.Image_active = TFDirector:getChildByPath(item.root, "Image_active"):hide()
    item.Image_active_icon = TFDirector:getChildByPath(item.Image_active, "Image_active_icon")
    item.Label_active_num = TFDirector:getChildByPath(item.Image_active, "Label_active_num")
    item.Label_title = TFDirector:getChildByPath(item.root, "Label_title")
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
    item.Label_title = TFDirector:getChildByPath(item.root, "Label_title")
    item.Label_type = TFDirector:getChildByPath(item.root, "Label_type")
    item.Label_geted = TFDirector:getChildByPath(item.root, "Label_geted")
    self.taskItem_[item.root] = item
    return Panel_task_Item
end

function LeagueBuildingMainView:showFusionTask()
    self.Label_fusion_name:setTextById(270355)
    local curLevel = LeagueDataMgr:getUnionLevel()
    local maxLevel = LeagueDataMgr:getUnionMaxLevel()
    self.Label_level_num:setText(curLevel.."/"..maxLevel)
    local curExp = LeagueDataMgr:getUnionExp()
    local maxExp = LeagueDataMgr:getUnionLevelUpExp(LeagueDataMgr:getUnionLevel())
    local percent = curExp / maxExp * 100
    if curLevel == maxLevel then
        self.Label_exp_percent:setText("Max")
        self.LoadingBar_exp:setPercent(100)
    else
        self.Label_exp_percent:setText(curExp.."/"..maxExp)
        self.LoadingBar_exp:setPercent(percent)
    end
    
    self.fusionTask_ = TaskDataMgr:getUnionFusionTask()
    self.maxStage_ = LeagueDataMgr:getUnionFusionStageMaxActive(LeagueDataMgr:getUnionLevel())
    self.stageData_ = LeagueDataMgr:getUnionFusionStageInfo(LeagueDataMgr:getUnionLevel())

    local items = self.ListView_task:getItems()
    local gap = #self.fusionTask_ - #items
    if gap > 0 then
        for i = 1, math.abs(gap) do
            local Panel_task_Item = self:addFusionTaskItem()
            self.ListView_task:pushBackCustomItem(Panel_task_Item)
        end
    else
        for i = 1, math.abs(gap) do
            self.ListView_task:removeItem(1)
        end
    end

    local items = self.ListView_task:getItems()
    for i, v in ipairs(items) do
        local item = self.taskItem_[v]
        local taskCid = self.fusionTask_[i]
        local taskCfg = TaskDataMgr:getTaskCfg(taskCid)
        local taskInfo = TaskDataMgr:getTaskInfo(taskCid)
        local progress = math.min(taskInfo.progress, taskCfg.progress)
        item.Label_progress:setTextById(800005, progress, taskCfg.progress)
        item.Image_icon:setTexture(taskCfg.icon)
        local desc = TaskDataMgr:getTaskDesc(taskCid)
        item.Label_desc:setText(desc)
        if taskCfg.type == EC_TaskType.FUSION_PERSONAL then
            item.Label_type:setTextById(270458)
        else
            item.Label_type:setTextById(270459)
        end
        item.Label_title:setVisible(taskCfg.effectiveTime > 0)
        if taskCfg.effectiveTime == 1 then
            item.Label_title:setTextById(270494)
        elseif taskCfg.effectiveTime == 7 then
            item.Label_title:setTextById(270495)
        end
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

    local curWeekExp = LeagueDataMgr:getUnionWeekExp()
    local receiveIndex = LeagueDataMgr:getUnionFusionTaskStageGetIndex()
    for i, v in ipairs(self.activeItem_) do
        local idx = table.indexOf(receiveIndex, i - 1)
        v.Panel_geted:setVisible(idx ~= -1)
        local stageInfo = self.stageData_[i]
        if stageInfo then
            v.Panel_canGet:setVisible(curWeekExp >= stageInfo.stage and idx == -1)
            v.Panel_notGet:setVisible(curWeekExp < stageInfo.stage)
        end
    end

    local percent = me.clampf(curWeekExp / self.maxStage_, 0, 1)
    self.LoadingBar_activeProgress:setPercent(percent * 100)
    self.Label_activeValue:setText(tostring(LeagueDataMgr:getUnionWeekExp()))

    self:updateRedPointStatus()
end

function LeagueBuildingMainView:updateRedPointStatus()
    for i, v in ipairs(self.ListView_tab:getItems()) do
        local item = self.tabItem_[v]
        local tabData = self.tabData_[i]
        if tabData.type_ == EC_BuidingType.FUSION then
            local isCanReceive = TaskDataMgr:isCanReceiveTask(EC_TaskType.FUSION_PERSONAL)
            if not isCanReceive then
                isCanReceive = TaskDataMgr:isCanReceiveTask(EC_TaskType.FUSION_UNION)
            end
            if not isCanReceive then
                isCanReceive = LeagueDataMgr:checkFusionStageIsCanReceive()
            end
            item.Image_tips:setVisible(isCanReceive)
        else
            item.Image_tips:setVisible(false)
        end
    end
end

function LeagueBuildingMainView:onQuitUnionBack()
    AlertManager:closeAll()
    AlertManager:changeScene(SceneType.MainScene)
end

function LeagueBuildingMainView:registerEvents()
    EventMgr:addEventListener(self, EV_UNION_QUIT_UNION, handler(self.onQuitUnionBack, self))
    EventMgr:addEventListener(self, EV_TASK_UPDATE, handler(self.onUnionInfoUpdateEvent, self))
    EventMgr:addEventListener(self, EV_TASK_RECEIVE, handler(self.onTaskReceiveEvent, self))
    EventMgr:addEventListener(self, EV_UNION_GET_ACTIVE_REWARD, handler(self.onTaskActiveUpdateEvent, self))
    EventMgr:addEventListener(self, EV_UNION_WEEK_EXP_CHANGE, handler(self.onUnionInfoUpdateEvent, self))
    EventMgr:addEventListener(self, EV_UNION_EXP_LEVEL_CHANGE, handler(self.onUnionInfoUpdateEvent, self))
    EventMgr:addEventListener(self, EV_UNION_INFO_RESET, handler(self.onUnionInfoUpdateEvent, self))

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
            local stageInfo = self.stageData_[i]
            LeagueDataMgr:ReqUnionWeekActivePrize(i - 1)
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

    self.Panel_touch:setSwallowTouch(false)
    self.Panel_touch:setSize(GameConfig.WS)
    self.Panel_touch:onTouch(function()
            -- self.Image_preview:hide()
    end)
end

function LeagueBuildingMainView:onUnionInfoUpdateEvent()
    self:showBuildingView()
end

function LeagueBuildingMainView:onTaskActiveUpdateEvent(data)
    if data.rewards then
        Utils:showReward(data.rewards)
    end
    self:showBuildingView()
end

function LeagueBuildingMainView:onTaskReceiveEvent(reward)
    if reward then
        Utils:showReward(reward)
    end
    self:showBuildingView()
end

function LeagueBuildingMainView:onCountDownPer()
    
end

function LeagueBuildingMainView:addCountDownTimer(storeId)
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.onCountDownPer, self))
    end
end

function LeagueBuildingMainView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
    end
end

function LeagueBuildingMainView:removeEvents()
    self:removeCountDownTimer()
end

return LeagueBuildingMainView
