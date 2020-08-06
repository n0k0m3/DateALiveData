
local ChronoCrossTaskView = class("ChronoCrossTaskView", BaseLayer)

function ChronoCrossTaskView:initData()
    local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.CHRONO_CROSS)
    self.activityId_ = activity[1]
    if self.activityId_ then
        self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    else
        Box("活动未开启")
        return
    end
end

function ChronoCrossTaskView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.chronoCross.chronoCrossTaskView")
end

function ChronoCrossTaskView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")

    self.Panel_taskItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_taskItem")

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")
    self.Label_name = TFDirector:getChildByPath(Image_content, "Label_name")
    local ScrollView_task = TFDirector:getChildByPath(Image_content, "ScrollView_task")

    self.TableView_task = Utils:scrollView2TableView(ScrollView_task)
    self.TableView_task:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.cellSizeForTable, self))
    self.TableView_task:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex, self))
    self.TableView_task:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCellsInTableView, self))
    self.TableView_task:addMEListener(TFTABLEVIEW_SCROLL, handler(self.tableScroll,self))
    self.TableView_task:setZOrder(100)
    self.TableView_task:setBounceable(true)

    self:refreshView()
end

function ChronoCrossTaskView:refreshView()
    self.Label_name:setTextById(13210008)

    self:updateAllTaskItem()
end

function ChronoCrossTaskView:cellSizeForTable()
    local size = self.Panel_taskItem:getSize()
    return size.height, size.width
end

function ChronoCrossTaskView:tableCellAtIndex(tab,idx)
    local cell = tab:dequeueCell()
    idx = idx + 1
    if not cell then
        cell = TFTableViewCell:create()
        local item = self.Panel_taskItem:clone():show()
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

function ChronoCrossTaskView:numberOfCellsInTableView()
    return #self.taskData
end

function ChronoCrossTaskView:tableScroll()

end

function ChronoCrossTaskView:registerEvents()
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onUpdateProgressEvent, self))

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

function ChronoCrossTaskView:updateAllTaskItem()

    self.taskData = {}
    local tab1,tab2,tab3 = {},{},{}
    local itemIds = ActivityDataMgr2:getItems(self.activityId_)
    for k,v in ipairs(itemIds) do
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, v)
        if itemInfo.extendData.type == EC_ChronoCrossTaskType.Single then
            local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, v)
            if progressInfo.status == EC_TaskStatus.GET then
                table.insert(tab1,v)
            end
            if progressInfo.status == EC_TaskStatus.ING then
               table.insert(tab2,v)
            end
            if progressInfo.status == EC_TaskStatus.GETED then
                table.insert(tab3,v)
            end
        end
    end

    for k,v in ipairs(tab1) do
        table.insert(self.taskData,v)
    end

    for k,v in ipairs(tab2) do
        table.insert(self.taskData,v)
    end

    for k,v in ipairs(tab3) do
        table.insert(self.taskData,v)
    end

    self.TableView_task:reloadData()
end

function ChronoCrossTaskView:updateTaskItem(taskItem,data)

    local Image_receive_bg = TFDirector:getChildByPath(taskItem, "Image_receive_bg")
    local Label_desc = TFDirector:getChildByPath(Image_receive_bg, "Label_desc")
    local Label_step = TFDirector:getChildByPath(Image_receive_bg, "Label_step")
    local Image_geted_bg = TFDirector:getChildByPath(taskItem, "Image_geted_bg")
    local Label_desc_complete = TFDirector:getChildByPath(Image_geted_bg, "Label_desc_complete")
    local Label_step_complete = TFDirector:getChildByPath(Image_geted_bg, "Label_step_complete")
    local Image_receive_tag = TFDirector:getChildByPath(taskItem, "Image_receive_tag")
    local Image_geted_tag = TFDirector:getChildByPath(taskItem, "Image_geted_tag")
    local Image_ing_tag = TFDirector:getChildByPath(taskItem, "Image_ing_tag")
    local Panel_reward = TFDirector:getChildByPath(taskItem, "Panel_reward")
    local Label_ing = TFDirector:getChildByPath(taskItem, "Label_ing")
    local Button_receive = TFDirector:getChildByPath(taskItem, "Button_receive")
    local Label_receive = TFDirector:getChildByPath(Button_receive, "Label_receive")
    local Label_geted = TFDirector:getChildByPath(taskItem, "Label_geted")

    local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, data)
    local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, data)

    Label_desc:setText(itemInfo.extendData.des2)
    Label_desc_complete:setText(itemInfo.extendData.des2)
    Label_step:setText(itemInfo.target)
    Label_step_complete:setText(itemInfo.target)
    local isReceive = progressInfo.status == EC_TaskStatus.GET
    local isGeted = progressInfo.status == EC_TaskStatus.GETED
    local isIng = progressInfo.status == EC_TaskStatus.ING
    Image_receive_bg:setVisible(not isGeted)
    Image_geted_bg:setVisible(isGeted)
    Image_receive_tag:setVisible(isReceive)
    Image_geted_tag:setVisible(isGeted)
    Image_ing_tag:setVisible(isIng)
    Label_ing:setVisible(isIng)
    Button_receive:setVisible(isReceive)
    Label_geted:setVisible(isGeted)

    local itemIndex = 0
    Panel_reward:removeAllChildren()
    for cid, num in pairs(itemInfo.reward) do
        itemIndex = itemIndex + 1
        local posX = 38 + (itemIndex-1)*110*0.7
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:Scale(0.7)
        Panel_goodsItem:setPosition(ccp(posX,0))
        Panel_reward:addChild(Panel_goodsItem)
        PrefabDataMgr:setInfo(Panel_goodsItem, cid, num)
    end

    Button_receive:onClick(function()
        ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId_,data)
    end)
end

function ChronoCrossTaskView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId_ ~= activitId then return end
    Utils:showReward(reward)
    self:updateAllTaskItem()
end

function ChronoCrossTaskView:onUpdateProgressEvent()
    self:updateAllTaskItem()
end

return ChronoCrossTaskView
