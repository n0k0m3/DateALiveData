local AgoraContributionView = class("AgoraContributionView", BaseLayer)

function AgoraContributionView:ctor()
    self.super.ctor(self)
    self:initData()
    self:showPopAnim(true)
    self:init("lua.uiconfig.agora.agoraContributionView")
end

function AgoraContributionView:registerEvents()
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_all:onClick(function(sender)
        self:contributeTabSwitch(sender, 1)
    end)

    self.Button_self:onClick(function(sender)
        self:contributeTabSwitch(sender,2)
    end)
end

function AgoraContributionView:initData()
    self.selectTab = nil
    self.selectListView = nil
    self.ListView_rewards = {}
    self.taskItems_ = {}
end

function AgoraContributionView:initUI(ui)
    self.super.initUI(self, ui)

    local Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
    self.Panel_taskItem = Panel_prefab:getChild("Panel_taskItem")

    self.Button_close = TFDirector:getChildByPath(ui, "Button_close")

    local Image_rewardBg = TFDirector:getChildByPath(ui, "Image_rewardbg")
    local ScrollView_reward = Image_rewardBg:getChild("ScrollView_reward")

    --1 全服贡献， 2 个人贡献
    for i = 1, 2 do
        local scrollview = ScrollView_reward:clone():show()
        Image_rewardBg:addChild(scrollview)
        self.ListView_rewards[i] = UIListView:create(scrollview)
        self.ListView_rewards[i]:setVisible(false)
        self.ListView_rewards[i].count = 0
        --self.ListView_rewards[i]:setItemModel(self.bagItem)
        self.ListView_rewards[i]:setItemsMargin(5)
    end

    self.Button_all = TFDirector:getChildByPath(ui, "Button_all")
    self.Button_self = TFDirector:getChildByPath(ui, "Button_self")

    --self:createContributeItem()
    self:contributeTabSwitch(self.Button_all, 1)
end

function AgoraContributionView:contributeTabSwitch(tab, contributeType)
    if self.selectTab then
        self.selectTab:setTextureNormal("ui/common/edge_normal.png")
        self.selectTab:Touchable(true)
    end
    self.selectTab = tab
    self.selectTab:setTextureNormal("ui/common/edge_select.png")
    self.selectTab:setSize(me.size(50, 120))
    self.selectTab:Touchable(false)

    for i=1,2 do
        self.ListView_rewards[i]:setVisible(i==contributeType)
    end


    self:updateContribution(contributeType)
end


function AgoraContributionView:updateContribution(contributeType)

    self.activityId_ = contributeType==1 and EC_Activity_AgoraTask_Subtype.CONTRIBUTION_ALL or EC_Activity_AgoraTask_Subtype.CONTRIBUTION_SIGLE
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    self.taskData_ = ActivityDataMgr2:getItems(self.activityId_)

    self.ListView_task = self.ListView_rewards[contributeType]
    local items = self.ListView_task:getItems()
    local gap = #items - #self.taskData_

    for i = 1, math.abs(gap) do
        if gap > 0 then
            local item = self.ListView_task:getItem(1)
            self.taskItems_[item] = nil
            self.ListView_task:removeItem(1)
        else
            local item = self:addTaskItem()
            self.ListView_task:pushBackCustomItem(item)
        end
    end

    for i, v in ipairs(self.ListView_task:getItems()) do
        self:updateTaskItem(i)
    end

end

function AgoraContributionView:addTaskItem()
    local Panel_taskItem = self.Panel_taskItem:clone()
    local foo = {}
    foo.root = Panel_taskItem
    foo.Image_icon = TFDirector:getChildByPath(foo.root, "Image_icon")
    foo.Label_desc = TFDirector:getChildByPath(foo.root, "Label_desc")
    foo.Label_progress_title = TFDirector:getChildByPath(foo.root, "Label_progress_title")
    foo.Label_progress_title:setTextById(1890002)
    if self.isBackPlayer then
        foo.Label_progress_title:setText("已连续登录")
    end
    foo.Label_progress = TFDirector:getChildByPath(foo.root, "Label_progress")
    foo.Image_reward = {}
    for i = 1, 3 do
        local bar = {}
        bar.root = TFDirector:getChildByPath(foo.root, "Image_reward_" .. i)
        bar.Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        bar.Panel_goodsItem:AddTo(bar.root):Pos(0, 0):Scale(0.75)
        foo.Image_reward[i] = bar
    end
    foo.Button_receive = TFDirector:getChildByPath(foo.root, "Button_receive")
    foo.Label_receive = TFDirector:getChildByPath(foo.root, "Label_receive")
    foo.Label_receive:setTextById(1300008)
    foo.Button_goto = TFDirector:getChildByPath(foo.root, "Button_goto")
    foo.Label_goto = TFDirector:getChildByPath(foo.Button_goto, "Label_goto")
    foo.Label_goto:setTextById(1300009)
    foo.Label_geted = TFDirector:getChildByPath(foo.root, "Label_geted")
    foo.Label_geted:setTextById(1300015)
    foo.Label_reward = TFDirector:getChildByPath(foo.root, "Label_reward")
    foo.Label_reward:setTextById(1890003)
    foo.Image_reset = TFDirector:getChildByPath(foo.root, "Image_reset"):hide()

    self.taskItems_[foo.root] = foo

    return Panel_taskItem
end

function AgoraContributionView:updateTaskItem(index)
    local activityInfo = self.activityInfo_
    local itemId = self.taskData_[index]

    local itemInfo = ActivityDataMgr2:getItemInfo(activityInfo.activityType, itemId)
    local progress = ActivityDataMgr2:getProgress(activityInfo.activityType, itemId)
    local progressInfo = ActivityDataMgr2:getProgressInfo(activityInfo.activityType, itemId)

    local item = self.ListView_task:getItem(index)
    local foo = self.taskItems_[item]

    foo.Image_icon:setTexture(itemInfo.extendData.icon)
    foo.Label_desc:setText(itemInfo.extendData.des2)
    foo.Label_progress:setTextById(800005, progress, itemInfo.target)
    if progress > tonumber(itemInfo.target)  then
        foo.Label_progress:setTextById(800005, itemInfo.target, itemInfo.target)
    end

    local goodsId, goodsNum
    for i, v in ipairs(foo.Image_reward) do
        local id, num = next(itemInfo.reward, goodsId)
        if id then
            goodsId = id
            goodsNum = num
        end
        v.Panel_goodsItem:setVisible(tobool(id))
        if v.Panel_goodsItem:isVisible() then
            PrefabDataMgr:setInfo(v.Panel_goodsItem, goodsId, goodsNum)
        end
    end

    foo.Button_receive:setVisible(progressInfo.status == EC_TaskStatus.GET)
    foo.Label_geted:setVisible(progressInfo.status == EC_TaskStatus.GETED)
    foo.Button_goto:setVisible(progressInfo.status == EC_TaskStatus.ING and itemInfo.extendData.jumpInterface)
    foo.Image_reset:setVisible(itemInfo.extendData.resetType == 2)

    foo.Button_receive:onClick(function()
        ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(activityInfo.id, itemId)
    end)
    foo.Button_goto:onClick(function()
        FunctionDataMgr:enterByFuncId(itemInfo.extendData.jumpInterface)
    end)

end

function AgoraContributionView:updateReward(ListView_rewards,rewards)

    ListView_rewards:removeAllItems()
    if not rewards then
        return
    end

    for k,awardId in ipairs(rewards) do
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:setScale(0.7)
        PrefabDataMgr:setInfo(Panel_goodsItem, awardId)
        ListView_rewards:pushBackCustomItem(Panel_goodsItem)
    end
end

function AgoraContributionView:createContributeItem()
    for i = 1, 15 do
        local taskItem = self.Panel_item:clone()
        local Label_desc = taskItem:getChildByName("Label_desc")
        Label_desc:setText("任务名字"..i)

        local ScrollView_reward = taskItem:getChildByName("ScrollView_reward")
        local ListView_rewards = UIListView:create(ScrollView_reward)
        local rewards = {500001,500001,500002}
        self:updateReward(ListView_rewards,rewards)

        local finishCnt = 10
        local totalCnt = 10
        local Label_progress = taskItem:getChildByName("Label_progress")
        Label_progress:setText(finishCnt.."/"..totalCnt)
        local isFinish = finishCnt >= totalCnt
        local Button_receive = taskItem:getChildByName("Button_receive")
        local Label_receive = Button_receive:getChildByName("Label_receive")
        local btnStr = isFinish and "领取奖励" or "未完成"
        Label_receive:setText(btnStr)

        Button_receive:setGrayEnabled(not isFinish)
        Button_receive:setTouchEnabled(isFinish)

        Button_receive:onClick(function()
            Utils:showTips("任务Id:"..i)
        end)
        if i % 2 == 0 then
            self.ListView_rewards[self.rewardTabType["Agora"]]:pushBackCustomItem(taskItem)
        else
            self.ListView_rewards[self.rewardTabType["Self"]]:pushBackCustomItem(taskItem)
        end
    end
end

return AgoraContributionView