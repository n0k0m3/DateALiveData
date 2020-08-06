
local BirthdayView = class("BirthdayView", BaseLayer)

function BirthdayView:initData(selectIndex)
    self.defaultSelectIndex_ = selectIndex or 1
    self.selectIndex_ = nil

    self.taskItem_ = {}
    self.commodityItem_ = {}
end

function BirthdayView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.birthdayView")
end

function BirthdayView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_taskItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_taskItem")
    self.Panel_commodityItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_commodityItem")
    self.Panel_assetItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_assetItem")

    self.Label_date = TFDirector:getChildByPath(self.Panel_root, "Label_date")
    self.Label_enter = TFDirector:getChildByPath(self.Panel_root, "Label_enter")
    self.Panel_role = TFDirector:getChildByPath(self.Panel_root, "Panel_role")
    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Button_task = TFDirector:getChildByPath(Image_content, "Button_task")
    self.Label_normal_task = TFDirector:getChildByPath()
    self.Button_func = {}
    for i = 1, 2 do
        local item = {}
        item.root = TFDirector:getChildByPath(Image_content, "Button_func_" .. i)
        item.Label_normalName = TFDirector:getChildByPath(item.root, "Label_normalName")
        item.Label_selectName = TFDirector:getChildByPath(item.root, "Label_selectName")
        self.Button_func[i] = item
    end
    local ScrollView_task = TFDirector:getChildByPath(Image_content, "ScrollView_task"):hide()
    self.ListView_task = UIListView:create(ScrollView_task)
    local ScrollView_shop = TFDirector:getChildByPath(Image_content, "ScrollView_shop"):hide()
    self.ListView_shop = UIListView:create(ScrollView_shop)
    local ScrollView_assets = TFDirector:getChildByPath(Image_content, "ScrollView_assets")
    self.ListView_assets = UIListView:create(ScrollView_assets)
    self.Panel_enter = TFDirector:getChildByPath(self.Panel_root, "Panel_enter")

    self:refreshView()
end

function BirthdayView:selectTab(selectIndex)
    if self.selectIndex_ == selectIndex then return end
    self.selectIndex_ = selectIndex

    self.ListView_task:s():setVisible(selectIndex == 1)
    self.ListView_shop:s():setVisible(selectIndex == 2)
    self.ListView_assets:s():setVisible(selectIndex == 2)

    if selectIndex == 1 then
        self:showTask()
    elseif selectIndex == 2 then
        self:showShop()
    end

    for i, v in ipairs(self.Button_func) do
        local isSelected = (i == selectIndex)
        v.root:setTouchEnabled(not isSelected)
        v.root:setBright(not isSelected)
        v.Label_normalName:setVisible(not isSelected)
        v.Label_selectName:setVisible(isSelected)
    end
end

function BirthdayView:showShop()
    self.shopData_ = {}
    local data = ActivityDataMgr2:getActivityInfo(1)
    self.shopItems_ = ActivityDataMgr2:getItems(1)

    -- local store = StoreDataMgr:getStore(EC_StoreType.BIRTHDAY)

    -- local storeCid = store[1]
    -- dump(storeCid)
    -- if storeCid then
    --     self.commodityData_ = StoreDataMgr:getCommodity(storeCid)
    --     local storeCfg = StoreDataMgr:getStoreCfg(storeCid)
    --     self.ListView_assets:removeAllItems()
    --     dump(storeCfg.showCurrency)
    --     for i, v in ipairs(storeCfg.showCurrency) do
    --         local item = self.Panel_assetItem:clone()
    --         local Image_icon = TFDirector:getChildByPath(item, "Image_icon")
    --         local Label_count = TFDirector:getChildByPath(item, "Label_count")
    --         local itemCfg = GoodsDataMgr:getItemCfg(v)
    --         Image_icon:setTexture(itemCfg.icon)
    --         Label_count:setText(GoodsDataMgr:getItemCount(v))
    --         self.ListView_assets:pushBackCustomItem(item)
    --         Image_icon:onClick(function()
    --                 Utils:showInfo(v, nil, true)
    --         end)
    --     end
    --     self.ListView_assets:scrollToRight()
    --     self.ListView_assets:setInertiaScrollEnabled(false)
    -- else
    --     self.commodityData_ = {}
    -- end
    local items = self.ListView_shop:getItems()
    local gap = #items - #self.shopItems_
    for i = 1, math.abs(gap) do
        if gap > 0 then
            self.ListView_shop:removeItem(1)
        else
            self:addCommodityItem()
        end
    end

    for i, v in ipairs(self.ListView_shop:getItems()) do
        self:updateCommodityItem(i)
    end

end

function BirthdayView:showTask()
    self.taskData_ = TaskDataMgr:getTask(EC_TaskType.BIRTHDAY)
    local items = self.ListView_task:getItems()
    local gap = #items - #self.taskData_
    for i = 1, math.abs(gap) do
        if gap > 0 then
            self.ListView_task:removeItem(1)
        else
            self:addTaskItem()
        end
    end

    for i, v in ipairs(self.ListView_task:getItems()) do
        self:updateTaskItem(i)
    end
end

function BirthdayView:addCommodityItem()
    local item = self.Panel_commodityItem:clone()
    local foo = {}
    foo.root = item
    foo.Panel_goods = TFDirector:getChildByPath(foo.root, "Panel_goods")
    foo.Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    foo.Panel_goodsItem:AddTo(foo.Panel_goods):Pos(0, 0):ZO(1)
    foo.Label_remainCount = TFDirector:getChildByPath(foo.root, "Label_remainCount")
    foo.Panel_cost = {}
    for i = 1, 3 do
        local bar = {}
        bar.root = TFDirector:getChildByPath(foo.root, "Panel_cost_" .. i)
        bar.Image_icon = TFDirector:getChildByPath(bar.root, "Image_icon")
        bar.Label_num = TFDirector:getChildByPath(bar.root, "Label_num")
        bar.Label_num2 = TFDirector:getChildByPath(bar.root, "Label_num2"):hide()
        foo.Panel_cost[i] = bar
    end
    foo.Button_buy = TFDirector:getChildByPath(foo.root, "Button_buy")
    foo.Label_buy = TFDirector:getChildByPath(foo.Button_buy, "Label_buy")

    self.ListView_shop:pushBackCustomItem(item)
    self.commodityItem_[foo.root] = foo
end

function BirthdayView:updateAllTaskItem()
    for i, v in ipairs(self.ListView_task:getItems()) do
        self:updateTaskItem(i)
    end
end

function BirthdayView:updateAllCommodityItem()
    for i, v in ipairs(self.ListView_shop:getItems()) do
        self:updateCommodityItem(i)
    end
end

function BirthdayView:updateCommodityItem(index)
    local itemId = self.shopItems_[index]
    local itemInfo = ActivityDataMgr2:getItemInfo(itemId)

    local item = self.ListView_shop:getItem(index)
    local foo = self.commodityItem_[item]

    local goodsId, goodsCount
    for k, v in pairs(itemInfo.reward) do
        goodsId = k
        goodsCount = v
        break
    end
    local goodsCfg = GoodsDataMgr:getItemCfg(goodsId)
    PrefabDataMgr:setInfo(foo.Panel_goodsItem, goodsId, goodsCount)

    local costId = {}
    for k, v in pairs(itemInfo.target) do
        table.insert(costId, k)
    end
    table.sort(costId, function(a, b)
                   return a < b
    end)

    for i, v in ipairs(foo.Panel_cost) do
        local id = costId[i]
        local num = itemInfo.target[id]
        if id and num then
            local costCfg = GoodsDataMgr:getItemCfg(id)
            v.Image_icon:setTexture(costCfg.icon)
            v.Label_num:setText(num)
            v.Label_num2:setText(num)
            local isEnough = GoodsDataMgr:currencyIsEnough(id, num)
            v.Label_num:setVisible(isEnough)
            v.Label_num2:setVisible(not isEnough)
            v.root:show()
            Utils:adaptSize(v.root, false, true)
        else
            v.root:hide()
        end
    end

    -- 限购
    local isCanBuy, remainCount, strId = ActivityDataMgr2:getRemainBuyCount(itemId)
    if strId then
        foo.Label_remainCount:setTextById(strId, remainCount)
    else
        foo.Label_remainCount:hide()
    end
    foo.Button_buy:setGrayEnabled(not isCanBuy)
    foo.Button_buy:setTouchEnabled(isCanBuy)

    foo.Button_buy:onClick(function()
            local isEnough = ActivityDataMgr2:currencyIsEnough(itemId)
            if isEnough then
                Utils:openView("activity.ActivityBuyConfirmView", 1, itemId)
            else
                Utils:showTips(302200)
            end
    end)
end

function BirthdayView:updateTaskItem(index)
    local taskCid = self.taskData_[index]
    local taskCfg = TaskDataMgr:getTaskCfg(taskCid)
    local taskInfo = TaskDataMgr:getTaskInfo(taskCid)

    local item = self.ListView_task:getItem(index)
    local foo = self.taskItem_[item]
    foo.Image_icon:setTexture(taskCfg.icon)
    foo.Label_desc:setTextById(taskCfg.des)
    foo.Label_progress:setTextById(800005, taskInfo.progress, taskCfg.progress)

    for i, v in ipairs(foo.Panel_reward) do
        local reward = taskCfg.reward[i]
        v.Panel_goodsItem:setVisible(tobool(reward))
        if reward then
            PrefabDataMgr:setInfo(v.Panel_goodsItem, reward[1], reward[2])
        end
    end

    foo.Label_state:setTextById(taskInfo.status ~= EC_TaskStatus.ING  and 1300006 or 1300007)
    foo.Label_receive:setTextById(taskInfo.status == EC_TaskStatus.GET and 1300008 or 1300015)
    foo.Image_reach:setVisible(taskInfo.status ~= EC_TaskStatus.ING)
    foo.Button_receive:setVisible(taskInfo.status ~= EC_TaskStatus.ING)
    foo.Button_receive:setGrayEnabled(taskInfo.status == EC_TaskStatus.GETED)
    foo.Button_receive:setTouchEnabled(taskInfo.status == EC_TaskStatus.GET)

    foo.Button_receive:onClick(function()
            TaskDataMgr:send_TASK_SUBMIT_TASK(taskInfo.cid)
    end)
end

function BirthdayView:addTaskItem()
    local item = self.Panel_taskItem:clone()
    local foo = {}
    foo.root = item
    foo.Image_reach = TFDirector:getChildByPath(foo.root, "Image_reach")
    foo.Label_state = TFDirector:getChildByPath(foo.root, "Label_state")
    foo.Image_icon = TFDirector:getChildByPath(foo.root, "Image_icon")
    foo.Label_desc = TFDirector:getChildByPath(foo.root, "Label_desc")
    foo.Label_progress = TFDirector:getChildByPath(foo.root, "Image_progress.Label_progress")
    foo.Panel_reward = {}
    for i = 1, 3 do
        local bar = {}
        bar.root = TFDirector:getChildByPath(foo.root, "Panel_reward_" .. i)
        bar.Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        bar.Panel_goodsItem:AddTo(bar.root):Pos(0, 0):ZO(1)
        foo.Panel_reward[i] = bar
    end
    foo.Button_receive = TFDirector:getChildByPath(foo.root, "Button_receive")
    foo.Label_receive = TFDirector:getChildByPath(foo.Button_receive, "Label_receive")

    self.ListView_task:pushBackCustomItem(item)
    self.taskItem_[foo.root] = foo
end

function BirthdayView:refreshView()
    local skinInfo = TabDataMgr:getData("HeroSkin", 1101013)
    local modelInfo = TabDataMgr:getData("HeroModle", skinInfo.paint)
    local model = SkeletonAnimation:create(modelInfo.paint)
    model:setAnimationFps(GameConfig.ANIM_FPS)
    model:playByIndex(0, -1, -1, 1)
    model:AddTo(self.Panel_role):Scale(0.9)
    model:update(0.1)
    model:stop()

    self.Label_date:setText("2018.4.30 - 2018.5.30")

    self:selectTab(self.defaultSelectIndex_)
end

function BirthdayView:registerEvents()
    EventMgr:addEventListener(self, EV_STORE_BUYINFO_UPDATE, handler(self.onBuyInfoUpdateEvent, self))
    EventMgr:addEventListener(self, EV_TASK_UPDATE, handler(self.onTaskUpdateEvent, self))
    EventMgr:addEventListener(self, EV_TASK_RECEIVE, handler(self.onTaskReceiveEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))

    for i, v in ipairs(self.Button_func) do
        v.root:onClick(function()
                self:selectTab(i)
        end)
    end

    self.Panel_enter:onClick(function()
            -- Utils:openView("dating.DatingTypeView", 101)
    end)
end

function BirthdayView:onBuyInfoUpdateEvent()
    self:showShop()
end

function BirthdayView:onTaskUpdateEvent(taskCid)
    self:showTask()
end

function BirthdayView:onTaskReceiveEvent(reward)
    Utils:showReward(reward)
end

function BirthdayView:onSubmitSuccessEvent(_, itemId)
    self:updateAllCommodityItem()
end

return BirthdayView
