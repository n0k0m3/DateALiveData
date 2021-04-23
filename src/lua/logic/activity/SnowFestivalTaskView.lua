local SnowFestivalTaskView = class("SnowFestivalTaskView", BaseLayer)

function SnowFestivalTaskView:initData()

    self.activityType = EC_ActivityType2.SNOW_FESTIVAL_TASK

end

function SnowFestivalTaskView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.activity.snowFestivalTaskView")
end

function SnowFestivalTaskView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.Panel_TaskItem = TFDirector:getChildByPath(self.Panel_root, "Panel_TaskItem")

    local ScrollView_task = TFDirector:getChildByPath(self.Panel_root, "ScrollView_task")
    self.TableView_task = Utils:scrollView2TableView(ScrollView_task)
    self.TableView_task:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.cellSizeForTable, self))
    self.TableView_task:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex, self))
    self.TableView_task:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCellsInTableView, self))

    self.Label_time_tip = TFDirector:getChildByPath(self.Panel_root, "Label_time_tip")
    self.Label_time_begin = TFDirector:getChildByPath(self.Panel_root, "Label_time_begin")
    self.Label_time_end = TFDirector:getChildByPath(self.Panel_root, "Label_time_end")
    self.Label_time_begin:setSkewX(10)
    self.Label_time_end:setSkewX(10)
    self.Label_time_tip:setSkewX(10)

    self.typeBtn_ = {}
    for i=1,2 do
        local btn = TFDirector:getChildByPath(self.Panel_root, "Panel_snowBtn_"..i)
        local select = TFDirector:getChildByPath(btn, "select")
        table.insert(self.typeBtn_,{btn = btn,select = select})
    end

    self:initUILogic()
end

function SnowFestivalTaskView:initUILogic()
    local activity = ActivityDataMgr2:getActivityInfoByType(self.activityType)
    self.activityId_ = activity[1]
    local activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId_)
    if not activityInfo then
        return
    end

    local ext = activityInfo.extendData
    if not ext then
        return
    end

    local startDate = Utils:getLocalDate(activityInfo.startTime)
    local startDateStr = startDate:fmt("%Y.%m.%d")
    local endDate = Utils:getLocalDate(activityInfo.endTime)
    local endDateStr = endDate:fmt("%Y.%m.%d")
    self.Label_time_begin:setText(startDateStr)
    self.Label_time_end:setText(endDateStr)

    self.extDayTask = ext.day or {}
    self.extAchieveTask = ext.once or {}

    self:selectTaskType(1)
end

function SnowFestivalTaskView:selectTaskType(index)

    for k,v in ipairs(self.typeBtn_) do
        v.select:setVisible(k == index)
    end
    self.chooseIndex = index
    self:updateTask()
end

function SnowFestivalTaskView:cellSizeForTable()
    local size = self.Panel_TaskItem:getSize()
    return size.height, size.width
end

function SnowFestivalTaskView:numberOfCellsInTableView()
    return #self.taskData
end

function SnowFestivalTaskView:tableCellAtIndex(tab, idx)
    local cell = tab:dequeueCell()
    idx = idx + 1
    if not cell then
        cell = TFTableViewCell:create()
        local item = self.Panel_TaskItem:clone()
        item:setAnchorPoint(ccp(0, 0))
        item:setPosition(ccp(0, 0))
        cell:addChild(item)
        cell.item = item
    end
    cell.idx = idx

    if cell.item then
        self:updateTaskItem(cell.item, self.taskData[idx])
    end

    return cell
end

function SnowFestivalTaskView:updateTaskItem(item,itemId)

    local progress = ActivityDataMgr2:getProgress(self.activityType, itemId)
    local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityType, itemId)
    local itemInfo = ActivityDataMgr2:getItemInfo(self.activityType, itemId)

    local Label_desc = TFDirector:getChildByPath(item, "Label_desc")
    Label_desc:setText(itemInfo.extendData.des2)

    local Label_pro_value = TFDirector:getChildByPath(item, "Label_pro_value")
    Label_pro_value:setTextById(800005, progress, itemInfo.target)
    if progress > tonumber(itemInfo.target)  then
        Label_pro_value:setTextById(800005, itemInfo.target, itemInfo.target)
    end

    local Image_lock = TFDirector:getChildByPath(item, "Image_lock")
    local Label_lock = TFDirector:getChildByPath(Image_lock, "Label_lock")
    local isUnlock = true
    dump(itemInfo)
    if itemInfo.extendData and itemInfo.extendData.level then
        isUnlock = ActivityDataMgr2:getCurUnLockLevelByType(itemInfo.extendData.lockType) >= itemInfo.extendData.level
        local lockText = itemInfo.extendData.lockText or 15010119
        Label_lock:setTextById(lockText,itemInfo.extendData.level)
    end
    Image_lock:setVisible(not isUnlock)
    Label_lock:setVisible(not isUnlock)

    --local ScrollView_reward = TFDirector:getChildByPath(item, "ScrollView_reward")
    --if not item.listView_reward then
    --    item.listView_reward = UIListView:create(ScrollView_reward)
    --end
    --
    --item.listView_reward:removeAllItems()
    --for k,v in ipairs(levelCfg.icon) do
    --    local bossItem = self.Panel_bossItem:clone()
    --    local image = TFDirector:getChildByPath(bossItem, "Image_boss")
    --    image:setTexture(v)
    --    item.listView_reward:pushBackCustomItem(bossItem)
    --end

    local goodsId
    for i=1,3 do

        local Panel_item = TFDirector:getChildByPath(item, "Panel_item_"..i):hide()
        local id, num = next(itemInfo.reward, goodsId)
        if id and num then
            goodsId = id
            Panel_item:show()
            local Panel_goodsItem = Panel_item:getChildByName("Panel_goodsItem")
            if not Panel_goodsItem then
                Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
                Panel_goodsItem:Pos(0, 0):AddTo(Panel_item)
                Panel_goodsItem:setName("Panel_goodsItem")
                Panel_goodsItem:setScale(0.7)
            end
            PrefabDataMgr:setInfo(Panel_goodsItem, id, num)
        end
    end

    local Button_get = TFDirector:getChildByPath(item, "Button_get")
    Button_get:setVisible(progressInfo.status ~= EC_TaskStatus.ING and isUnlock)
    Button_get:setTouchEnabled(progressInfo.status == EC_TaskStatus.GET)
    Button_get:setGrayEnabled(progressInfo.status == EC_TaskStatus.GETED)
    Button_get:onClick(function()
        ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId_, itemId)
    end)

    local Button_goto = TFDirector:getChildByPath(item, "Button_goto")
    Button_goto:setVisible(progressInfo.status == EC_TaskStatus.ING and itemInfo.extendData.jumpInterface and isUnlock)
    Button_goto:onClick(function()
        local activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId_)
        if ServerDataMgr:getServerTime() >= activityInfo.endTime then
            Utils:showTips(1710021)
            return
        end

        local param = itemInfo.extendData.parameter or {}
        FunctionDataMgr:enterByFuncId(itemInfo.extendData.jumpInterface,unpack(param))
    end)
end

function SnowFestivalTaskView:updateTask()

    local tempData = {}
    local haveItems = self.chooseIndex == 1 and self.extDayTask or self.extAchieveTask
    local items = ActivityDataMgr2:getItems(self.activityId_)
    for k,v in ipairs(items) do

        local index = table.indexOf(haveItems,v)
        if index ~= -1 then
            table.insert(tempData,v)
        end
    end

    self.taskData = {}
    local unLockData = {}
    local lockData = {}
    for k,v in ipairs(tempData) do
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityType, v)
        local isUnlock = true
        if itemInfo.extendData and itemInfo.extendData.level then
            isUnlock = ActivityDataMgr2:getCurUnLockLevelByType(itemInfo.extendData.lockType) >= itemInfo.extendData.level
        end

        if isUnlock then
            table.insert(unLockData,v)
        else
            table.insert(lockData,v)
        end
    end

    table.insertTo(self.taskData,unLockData)
    table.insertTo(self.taskData,lockData)
    self.TableView_task:reloadData()

end

function SnowFestivalTaskView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId_ ~= activitId then return end
    Utils:showReward(reward)
    self:updateTask()
end

function SnowFestivalTaskView:onUpdateProgressEvent()
    self:updateTask()
end

function SnowFestivalTaskView:registerEvents()

    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onUpdateProgressEvent, self))
    EventMgr:addEventListener(self, EV_ICE_SNOW_UPGRADE, handler(self.updateTask, self))
    EventMgr:addEventListener(self, EV_ICE_SNOW_BOOK_DATA, handler(self.updateTask, self))

    for k,v in ipairs(self.typeBtn_) do
        v.btn:onClick(function()
            self:selectTaskType(k)
        end)
    end

end


return SnowFestivalTaskView
