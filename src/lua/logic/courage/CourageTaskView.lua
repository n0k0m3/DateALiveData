local CourageTaskView = class("CourageTaskView", BaseLayer)

function CourageTaskView:initData()
    self.randomType = 99
end

function CourageTaskView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.courage.courageTaskView")
end

function CourageTaskView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.Button_tab = TFDirector:getChildByPath(self.Panel_root, "Button_tab")
    self.Panel_role_head = TFDirector:getChildByPath(self.Panel_root, "Panel_role_head")
    self.Panel_courageTaskItem = TFDirector:getChildByPath(self.Panel_root, "Panel_courageTaskItem")

    local ScrollView_tab = TFDirector:getChildByPath(self.Panel_root, "ScrollView_tab")
    self.ListView_tab = UIListView:create(ScrollView_tab)
    self.ListView_tab:setItemsMargin(5)

    self.Image_head_task_ = {}
    for i=1,4 do
        local imageBg = TFDirector:getChildByPath(self.Panel_root, "Image_head_"..i)
        local Image_head = TFDirector:getChildByPath(imageBg, "Image_head")
        local Image_finish = TFDirector:getChildByPath(imageBg, "Image_finish")
        table.insert(self.Image_head_task_,{imageBg = imageBg,headImg = Image_head,finishIcon = Image_finish})
    end

    self.Label_time = TFDirector:getChildByPath(self.Panel_root, "Label_time")

    local ScrollView_head = TFDirector:getChildByPath(self.Panel_root, "ScrollView_head")
    self.ListView_head = UIListView:create(ScrollView_head)

    local ScrollView_task = TFDirector:getChildByPath(self.Panel_root, "ScrollView_task")
    self.ListView_task = UIListView:create(ScrollView_task)

    self:initUILogic()
end

function CourageTaskView:initUILogic()
    local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.COURAGE_TASK)
    self.activityId_ = activity[1]
    local activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId_)
    self.turnData = {}
    dump(activityInfo.extendData.turn)
    for k,v in pairs(activityInfo.extendData.turn) do
        table.insert(self.turnData,{data = v,type = tonumber(k)})
    end
    table.sort(self.turnData,function(a,b)
        return a.type < b.type
    end)
    self:loadTab()
end

function CourageTaskView:loadTab()

    self.ListView_tab:removeAllItems()
    self.tab = {}
    for k,v in ipairs(self.turnData) do
        local btnTab = self.Button_tab:clone()
        local Label_tab = btnTab:getChildByName("Label_tab")
        Label_tab:setText(v.data.des)
        local select = btnTab:getChildByName("Image_select")
        local Image_new = btnTab:getChildByName("Image_new")
        self.ListView_tab:pushBackCustomItem(btnTab)
        table.insert(self.tab,{btn = btnTab, select = select,Image_new = Image_new})
    end
    self:selectTab(1)
end

function CourageTaskView:selectTab(id)

    local tempData = self.turnData[id].data
    if not tempData then
        return
    end

    local startTime,endTime = tempData.stime/1000,tempData.etime/1000
    local curTime = ServerDataMgr:getServerTime()
    if curTime < startTime or curTime >= endTime then
        Utils:showTips("该周目未开启")
        return
    end

    for k,v in ipairs(self.tab) do
        v.select:setVisible(k == id)
    end

    self.selectId = id
    if self.oldSelect then
        self.oldSelect:setVisible(false)
    end
    self.oldSelect = self.tab[id].select
    self.oldSelect:setVisible(true)

    self.selectTurnData = tempData
    self.selectType = self.turnData[id].type

    local startDate = Utils:getLocalDate(self.selectTurnData.stime/1000)
    local startDateStr = startDate:fmt("%Y.%m.%d")
    local endDate = Utils:getLocalDate(self.selectTurnData.etime/1000)
    local endDateStr = endDate:fmt("%m.%d")
    self.Label_time:setTextById(800041, startDateStr, endDateStr)

    self:updateTask()
end

function CourageTaskView:updateSelectRedPoint()
    for k,v in ipairs(self.tab) do
        local tempData = self.turnData[k].data
        local isShowRedPoint = false
        for _,taskId in ipairs(tempData.itemList) do
            local progressInfo = ActivityDataMgr2:getProgressInfo(EC_ActivityType2.COURAGE_TASK, taskId)
            if progressInfo.status == EC_TaskStatus.GET then
                isShowRedPoint = true
                break
            end
        end
        v.Image_new:setVisible(isShowRedPoint)
    end
end

function CourageTaskView:updateTask()
    self:updateHeadTask()
    self:updateMainTask()
    self:updateSelectRedPoint()
end

function CourageTaskView:updateHeadTask()

    for k,v in ipairs(self.Image_head_task_) do
        if not self.selectTurnData then
            v.imageBg:setVisible(false)
        else
            local roleTaskId = self.selectTurnData.role[k]
            if not roleTaskId then
                v.imageBg:setVisible(false)
            else
                v.imageBg:setVisible(true)
                local itemInfo = ActivityDataMgr2:getItemInfo(EC_ActivityType2.COURAGE_TASK, roleTaskId)
                v.headImg:setTexture(itemInfo.extendData.icon)
                local progressInfo = ActivityDataMgr2:getProgressInfo(EC_ActivityType2.COURAGE_TASK, roleTaskId)
                v.finishIcon:setVisible(progressInfo.status == EC_TaskStatus.GETED)
            end
        end
    end
end

function CourageTaskView:updateMainTask()
    self.ListView_task:removeAllItems()
    if not self.selectTurnData then
        return
    end
    local curType = self.selectType
    dump(self.selectTurnData)
    local curTime = ServerDataMgr:getServerTime()

    local items,getData,getedData,ingData = {},{},{},{}
    for k,v in ipairs(self.selectTurnData.itemList) do
        local progressInfo = ActivityDataMgr2:getProgressInfo(EC_ActivityType2.COURAGE_TASK, v)
        if progressInfo.status == EC_TaskStatus.GET then
            table.insert(getData, v)
        elseif progressInfo.status == EC_TaskStatus.GETED then
            table.insert(getedData, v)
        elseif progressInfo.status == EC_TaskStatus.ING then
            table.insert(ingData, v)
        end
    end

    table.insertTo(items, getData)
    table.insertTo(items, ingData)
    table.insertTo(items, getedData)

    for k,v in ipairs(items) do
        if curType ~= self.randomType then
            local taskItem = self.Panel_courageTaskItem:clone()
            self:updateMainTaskItem(taskItem,v)
            self.ListView_task:pushBackCustomItem(taskItem)
        else
            local itemInfo = ActivityDataMgr2:getItemInfo(EC_ActivityType2.COURAGE_TASK, v)
            if itemInfo and itemInfo.extendData then
                local stime = itemInfo.extendData.stime
                local etime = itemInfo.extendData.etime
                if stime and etime and curTime >= stime and curTime <= etime then
                    local taskItem = self.Panel_courageTaskItem:clone()
                    self:updateMainTaskItem(taskItem,v)
                    self.ListView_task:pushBackCustomItem(taskItem)
                end
            end
        end
    end
end

function CourageTaskView:updateMainTaskItem(taskItem,taskId)

    local Image_canget = TFDirector:getChildByPath(taskItem, "Image_canget")
    local Image_geted = TFDirector:getChildByPath(taskItem, "Image_geted")
    local Label_state = TFDirector:getChildByPath(taskItem, "Label_state")
    local Label_pro_value = TFDirector:getChildByPath(taskItem, "Label_pro_value")
    local Label_desc = TFDirector:getChildByPath(taskItem, "Label_desc")
    local ScrollView_reward = TFDirector:getChildByPath(taskItem, "ScrollView_reward")
    local ListView_reward = UIListView:create(ScrollView_reward)
    local Button_get = TFDirector:getChildByPath(taskItem, "Button_get")
    local Label_random_time = TFDirector:getChildByPath(taskItem, "Label_random_time")

    local itemInfo = ActivityDataMgr2:getItemInfo(EC_ActivityType2.COURAGE_TASK, taskId)
    local progressInfo = ActivityDataMgr2:getProgressInfo(EC_ActivityType2.COURAGE_TASK, taskId)

    Image_canget:setVisible(progressInfo.status == EC_TaskStatus.GET)
    Image_geted:setVisible(progressInfo.status == EC_TaskStatus.GETED)
    Label_state:setTextById(270491)
    Label_state:setVisible(progressInfo.status == EC_TaskStatus.GETED)

    Label_random_time:setVisible(progressInfo.status == EC_TaskStatus.ING)
    if itemInfo and itemInfo.extendData then
        local stime = itemInfo.extendData.stime
        local etime = itemInfo.extendData.etime
        if stime and etime then
            local endTime = Utils:getTimeData(etime)
            Label_random_time:setText(endTime.Month.."月"..endTime.Day.."日结束")
        else
            Label_random_time:setText("")
        end
    end

    local prorogress = progressInfo.progress or 0
    Label_pro_value:setText(prorogress.."/"..itemInfo.target)

    Label_desc:setText(itemInfo.extendData.des2)

    ListView_reward:removeAllItems()
    for k,v in pairs(itemInfo.reward) do
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        PrefabDataMgr:setInfo(Panel_goodsItem, k, v)
        ListView_reward:pushBackCustomItem(Panel_goodsItem)
    end

    Button_get:onClick(function()
        ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId_, taskId)
    end)
end

function CourageTaskView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId_ ~= activitId then return end
    Utils:showReward(reward)
    self:updateTask()
end

function CourageTaskView:onUpdateProgressEvent()
    self:updateTask()
end

function CourageTaskView:registerEvents()

    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onUpdateProgressEvent, self))

    for k,v in ipairs(self.tab) do
        v.btn:onClick(function()
            self:selectTab(k)
        end)
    end
end


return CourageTaskView
