local NewYearTaskView = class("NewYearTaskView",BaseLayer)


function NewYearTaskView:initData()
    self.task_ = {}
    self.activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.NEWYEAR_FUBEN)[1]
    self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
    for i, v in pairs(self.activityInfo.extendData.sendDayAwardList) do
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, v)
        local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, v)
        if table.count(progressInfo) > 0 and not progressInfo.extend.rFlag then
            table.insert(self.task_, itemInfo)
        end
    end

   	table.sort( self.task_, function (a, b)
   		local progressInfo1 = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, a.id)
   		local progressInfo2 = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, b.id)
        if progressInfo1.status == progressInfo2.status then
            return a.id > b.id
        elseif progressInfo1.status == EC_TaskStatus.GETED then
            return false
        elseif progressInfo2.status == EC_TaskStatus.GETED then
            return true
        elseif progressInfo1.status == EC_TaskStatus.GET then
            return true
        elseif progressInfo2.status == EC_TaskStatus.GET then
            return false
        end
    end )
end

function NewYearTaskView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:setUsepreProcesUI()
    self:init("lua.uiconfig.activity.newYearTaskView")
end

function NewYearTaskView:initUI(ui)
    self.super.initUI(self, ui)

    self.taskView = UIListView:create(self._ui.taskView)
    self.taskView:setItemsMargin(5)

    self.taskItems = {}
    self:refreshView()
end

function NewYearTaskView:registerEvents()
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, function ()
        self:initData()
        self:refreshView()
    end)

    self._ui.btnClose:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

function NewYearTaskView:addTaskItem()
    local taskItem = self._ui.taskItem:clone()
    local tab = {}
    tab.rewardGoods = {}
    tab.root = taskItem
    tab.bg = taskItem:getChildByName("bg")
    tab.itemLabTip = taskItem:getChildByName("itemLabTip")
    tab.labProcesShow = tab.itemLabTip:getChildByName("labProcesShow")
    tab.rewards = taskItem:getChildByName("rewards")
    tab.btnComplete = taskItem:getChildByName("btnComplete")
    tab.btnGo = taskItem:getChildByName("btnGo")
    tab.btnGo:hide()
    tab.labNotComplete = taskItem:getChildByName("labNotComplete")
    tab.imgCompleteMask = taskItem:getChildByName("imgCompleteMask")
    for i = 1, 3 do
        local foo = {}
        foo.goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        foo.goodsItem:setScale(0.65)
        foo.goodsItem:AddTo(tab.rewards:getChildByName(string.format("pos%d",i))):Pos(0,0):ZO(1)
        tab.rewardGoods[i] = foo
    end
    self.taskItems[tab.root] = tab
    return taskItem
end

function NewYearTaskView:refreshView()
    local items = self.taskView:getItems()
    local gap = #self.task_ - #items
    if gap > 0 then
        for i = 1, math.abs(gap) do
            local taskItem = self:addTaskItem()
            taskItem:setName("taskItem"..i)
            self.taskView:pushBackCustomItem(taskItem)
        end
    else
        for i = 1, math.abs(gap) do
            self.taskView:removeItem(1)
        end
    end

    for i, v in ipairs(self.taskView:getItems()) do
        local data = self.task_[i]
        local item = self.taskItems[v]
        local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, data.id)
        item.itemLabTip:setText(data.extendData.des2)
        item.labProcesShow:setPositionX(item.itemLabTip:getContentSize().width)
        item.labProcesShow:setText("("..progressInfo.progress.."/"..data.target..")")
        
        if progressInfo then
            if progressInfo.status == EC_TaskStatus.ING then
                item.labNotComplete:show()
                item.btnComplete:hide()
                item.imgCompleteMask:hide()
            elseif progressInfo.status == EC_TaskStatus.GET then
                item.labNotComplete:hide()
                item.btnComplete:show()
                item.imgCompleteMask:hide()
                item.btnComplete:onClick(function()
                    ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, data.id)
                end)
            elseif progressInfo.status == EC_TaskStatus.GETED then
                item.labNotComplete:hide()
                item.btnComplete:hide()
                item.imgCompleteMask:show()
            end
        end
    
        local rewards = {}
        for _id,_value in pairs(data.reward) do
            table.insert(rewards, {id = _id,value = _value})
        end
        for j, award in ipairs(item.rewardGoods) do
            local cfg = rewards[j]
            if cfg then
                PrefabDataMgr:setInfo(award.goodsItem, cfg.id, cfg.value)
                award.goodsItem:show()
            else
                award.goodsItem:hide()
            end
        end 
    end

end

return NewYearTaskView