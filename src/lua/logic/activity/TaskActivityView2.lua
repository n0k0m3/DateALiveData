
local TaskActivityView = class("TaskActivityView2", BaseLayer)
local TaskTable = TabDataMgr:getData("Task")

function TaskActivityView:initData(activityId)
    self.activityId_ = activityId
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    self.taskItems_ = {}
    self.useNormalTime = false
end

function TaskActivityView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    local uiName = self.activityInfo_.extendData.uiName or "taskActivityView"
    self:init("lua.uiconfig.activity."..uiName)
end

function TaskActivityView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_taskItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_taskItem")

    self.Image_ad = TFDirector:getChildByPath(self.Panel_root, "Image_ad")
    self.Label_date = TFDirector:getChildByPath(self.Image_ad, "Label_date")
    self.Label_timing = TFDirector:getChildByPath(self.Image_ad, "Label_timing")

    self.Label_time_tip = TFDirector:getChildByPath(self.Image_ad, "Label_time_tip")
    self.Label_time_begin = TFDirector:getChildByPath(self.Image_ad, "Label_time_begin")
    self.Label_time_end = TFDirector:getChildByPath(self.Image_ad, "Label_time_end")
    self.Label_time_begin:setSkewX(10)
    self.Label_time_end:setSkewX(10)
    self.Label_time_tip:setSkewX(10)


    local ScrollView_task = TFDirector:getChildByPath(self.Panel_root, "ScrollView_task")
    self.ListView_task = UIListView:create(ScrollView_task)

    self.Panel_refresh = TFDirector:getChildByPath(ui,"Panel_refresh")

    if self.Panel_refresh then 
        self.cost_icon = TFDirector:getChildByPath(self.Panel_refresh,"cost_icon")
        self.cost_num = TFDirector:getChildByPath(self.Panel_refresh,"cost_num")
        self.Button_refresh = TFDirector:getChildByPath(self.Panel_refresh,"Button_refresh")
        self.Label_reset = TFDirector:getChildByPath(self.Panel_refresh,"Label_reset")
    end

    self.Panel_progress = TFDirector:getChildByPath(self.Panel_root,"Panel_progress")

    if self.Panel_progress then
        self:initPanelProgress()
    end

    self:refreshView()
end

function TaskActivityView:initPanelProgress( ... )
    -- body
    self.Label_value1 = TFDirector:getChildByPath(self.Panel_progress,"Label_value1")
    self.Label_value2 = TFDirector:getChildByPath(self.Panel_progress,"Label_value2")
    self.Button_rank = TFDirector:getChildByPath(self.Panel_progress,"Button_rank")
    self.Button_help = TFDirector:getChildByPath(self.Panel_progress,"Button_help")
    self.ScrollView_progress = TFDirector:getChildByPath(self.Panel_progress,"ScrollView_progress")

    self.ScrollView_progress:setContentOffset(ccp(-50,0))
    self.Image_active_progress = TFDirector:getChildByPath(self.Panel_progress,"Image_progress_di")
    self.LoadingBar_progress = TFDirector:getChildByPath(self.Panel_progress,"LoadingBar_progress")

    self.Panel_activeItem = TFDirector:getChildByPath(self.Panel_prefab,"Panel_activeItem")
    self.activeItem_ = {}
    --self:initProgressTask()

    if self.Button_rank then
        self.Button_rank:onClick(function ( ... )
            -- body
            Utils:openView("activity.TaskRankView",self.activityId_)
        end)
    end

    if self.Button_help then
        self.Button_help:setVisible(self.activityInfo_.extendData.helpInterface)
        self.Button_help:onClick(function ( ... )
            -- body
            Utils:openView("common.HelpView",self.activityInfo_.extendData.helpInterface)
        end)
    end
    self.requsetCrossData = true
end

function TaskActivityView:updatePanelProgress( ... )
    -- body
    self:updateProgressTask()
end

function TaskActivityView:updateActivity()
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    local taskType = self.activityInfo_.extendData.taskType
    print("任务类型",taskType)
    local taskData = {}
    for k, item in pairs(TaskTable or {}) do
        if item.type == taskType then                
            local taskPreInfo = TaskDataMgr:getTaskInfo(item.extendsTaskId)
            if taskPreInfo and taskPreInfo.status ~= EC_TaskStatus.ING or taskPreInfo==nil then
                local order0 = 0     
                local taskInfo = TaskDataMgr:getTaskInfo(item.id)
                if taskInfo then
                    if taskInfo.status == EC_TaskStatus.ING then
                        order0 = 1
                    elseif taskInfo.status == EC_TaskStatus.GET then
                        order0 = 0
                    elseif taskInfo.status == EC_TaskStatus.GETED then
                        order0 = 2
                    end
                    table.insert(taskData, {id=item.id, order0=order0, order=item.order, status=taskInfo.status})
                end
            end
        end 
    end

    table.sort(taskData, function(A,B)
        if A.status ~= B.status then
            return A.order0 < B.order0 
        elseif A.status == B.status then
            return A.order < B.order      
        end
    end)
    --dump(taskData)

    self.taskData_ = {}
    for k,v in ipairs(taskData) do
        table.insert(self.taskData_,v.id)
    end

    

    self.ListView_task:AsyncUpdateItem(self.taskData_,function ( ... )
        return self:addTaskItem()
    end, function (v, data)
        self:updateTaskItem(v, data)
    end)  

    self:updatePanelProgress()

    -- @desc:谷丰让改的
    self.Label_date:setText(Utils:getActivityDateString(self.activityInfo_.startTime, self.activityInfo_.endTime, self.activityInfo_.extendData.dateStyle, true))

    self.Image_ad:setTexture(self.activityInfo_.showIcon)

    if self.Panel_refresh then
        if not self.activityInfo_.extendData.manualRefreshList then 
            self.Panel_refresh:hide()
            return 
        end
        self.Panel_refresh:show()

        local hasRefreshNum = self.activityInfo_.extendData.manualRefresh or 0
        local maxRefreshNum = #self.activityInfo_.extendData.manualRefreshList

        local id = self.activityInfo_.extendData.manualRefreshList[math.min(maxRefreshNum,hasRefreshNum + 1)][1]
        local num = self.activityInfo_.extendData.manualRefreshList[math.min(maxRefreshNum,hasRefreshNum + 1)][2] 
        self.cost_num:setText(num)
        self.cost_icon:setTexture(GoodsDataMgr:getItemCfg(id).icon)

        self.Label_reset:setText(hasRefreshNum.."/"..maxRefreshNum)
        self.cost_icon:setTouchEnabled(true)
        self.cost_icon:onClick(function ()
                Utils:showInfo(id)
            end)
    end
end


function TaskActivityView:addTaskItem()
    local Panel_taskItem = self.Panel_taskItem:clone()
    local foo = {}
    foo.root = Panel_taskItem
    foo.Image_icon = TFDirector:getChildByPath(foo.root, "Image_icon")
    foo.Label_desc = TFDirector:getChildByPath(foo.root, "Label_desc")
    foo.Label_progress_title = TFDirector:getChildByPath(foo.root, "Label_progress_title")
    foo.Label_progress_title:setTextById(1890002)
    if self.isBackPlayer then
        foo.Label_progress_title:setTextById(100000002)
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
    foo.Label_geted_bg = TFDirector:getChildByPath(foo.root, "Label_geted_bg")
    foo.Label_geted = TFDirector:getChildByPath(foo.root, "Label_geted")
    foo.Label_geted:setTextById(1300015)
    foo.Label_reward = TFDirector:getChildByPath(foo.root, "Label_reward")
    foo.Label_reward:setTextById(1890003)
    foo.Image_reset = TFDirector:getChildByPath(foo.root, "Image_reset"):hide()
    foo.Image_get = TFDirector:getChildByPath(foo.root, "Image_get")
    foo.Image_getted = TFDirector:getChildByPath(foo.root, "Image_getted")
    foo.Image_getted_mask = TFDirector:getChildByPath(foo.root, "Image_getted_mask")
    foo.Image_lock = TFDirector:getChildByPath(foo.root, "Image_lock"):hide()
    foo.Label_lock = TFDirector:getChildByPath(foo.root, "Label_lock")
    self.taskItems_[foo.root] = foo

    return Panel_taskItem
end

function TaskActivityView:updateTaskItem(item,itemId)
    local activityInfo = self.activityInfo_
    local taskInfo = TaskDataMgr:getTaskInfo(itemId)
 
    local taskCfg = TaskTable[itemId]
    local progressInfo = ActivityDataMgr2:getProgressInfo(activityInfo.activityType, itemId)

    local foo = self.taskItems_[item]
    foo.Image_lock:setVisible(false)

    foo.Image_icon:setTexture(taskCfg.icon)
    foo.Label_desc:setTextById(taskCfg.des)
    foo.Label_progress:setTextById(800005, taskInfo.progress, taskCfg.progress)
    -- if taskInfo.progress > tonumber(taskCfg.target)  then
    --     foo.Label_progress:setTextById(800005, taskCfg.target, taskCfg.target)
    -- end
    local goodsId, goodsNum
    for i, v in ipairs(foo.Image_reward) do
        local reward = taskCfg.reward[i]
        if reward then
            v.Panel_goodsItem:show()
            local id = reward[1]
            local num = reward[2]
            if id then
                goodsId = id
                goodsNum = num
            end
            v.Panel_goodsItem:setVisible(tobool(id))
            if v.Panel_goodsItem:isVisible() then
                PrefabDataMgr:setInfo(v.Panel_goodsItem, goodsId, goodsNum)
            end
        else
            v.Panel_goodsItem:hide()
        end
    end

    foo.Button_receive:setVisible(taskInfo.status == EC_TaskStatus.GET)
    foo.Label_geted:setVisible(taskInfo.status == EC_TaskStatus.GETED)
    if foo.Label_geted_bg then 
        foo.Label_geted_bg:setVisible(taskInfo.status == EC_TaskStatus.GETED)
    end
    foo.Button_goto:setVisible(taskInfo.status == EC_TaskStatus.ING and taskCfg.jumpInterface)
    foo.Image_reset:setVisible(taskCfg.resetType == 2)
    if foo.Image_get then
        foo.Image_get:setVisible(taskInfo.status == EC_TaskStatus.GET)
    end
    if foo.Image_get then
        foo.Image_getted:setVisible(taskInfo.status == EC_TaskStatus.GETED)
    end
    if foo.Image_getted_mask then 
        foo.Image_getted_mask:setVisible(taskInfo.status == EC_TaskStatus.GETED)
    end
    foo.Button_receive:onClick(function()
        if ServerDataMgr:getServerTime() >= self.activityInfo_.endTime then
            Utils:showTips(1710021)
            return
        end
        TaskDataMgr:send_TASK_SUBMIT_TASK(itemId)
    end)
    foo.Button_goto:onClick(function()
            if ServerDataMgr:getServerTime() >= self.activityInfo_.endTime then
                Utils:showTips(1710021)
                return
            end

            local param = taskCfg.ext.parameter or {}
            FunctionDataMgr:enterByFuncId(taskCfg.jumpInterface,unpack(param))
    end)

    self:updateCountDonw()
end

function TaskActivityView:refreshView()

    if self.activityInfo_ and self.useNormalTime then
        local startDate = Utils:getLocalDate(self.activityInfo_.startTime)
        local startDateStr = startDate:fmt("%Y.%m.%d")
        local endDate = Utils:getLocalDate(self.activityInfo_.endTime)
        local endDateStr = endDate:fmt("%Y.%m.%d")
        self.Label_time_begin:setText(startDateStr)
        self.Label_time_end:setText(endDateStr)
    end

end

function TaskActivityView:updateCountDonw()
    local isEnd = ActivityDataMgr2:isEnd(self.activityId_)
    local serverTime = ServerDataMgr:getServerTime()
    if isEnd then
        local remainTime = math.max(0, self.activityInfo_.showEndTime - serverTime)
        local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
        if day == "00" then
            self.Label_timing:setTextById("r42006", hour, min)
        else
            self.Label_timing:setTextById("r42005", day, hour)
        end
    else
        local remainTime = math.max(0, self.activityInfo_.endTime - serverTime)
        local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
        if day == "00" then
            self.Label_timing:setTextById("r42008", hour, min)
        else
            self.Label_timing:setTextById("r42007", day, hour)
        end
    end

    if self.requsetCrossData and (not self.lastRequsetTime or math.abs(self.lastRequsetTime - serverTime) >= 300) then
        self.lastRequsetTime = serverTime
        ActivityDataMgr2:SEND_ACTIVITY_REQ_CROSS_SUPPORT_INFO()
    end
end

function TaskActivityView:onTaskReceiveEvent(reward)
    if table.count(reward) > 0 then
        Utils:showReward(reward)
    end
    self:updateActivity()
end

function TaskActivityView:registerEvents()

    self.super.registerEvents(self)
    EventMgr:addEventListener(self, EV_TASK_RECEIVE, handler(self.onTaskReceiveEvent, self))
    EventMgr:addEventListener(self, EV_CROSS_SUPPORT_INFO, handler(self.onCrossSupportInfoRsp, self))
    if self.Button_refresh then
        self.Button_refresh:onClick(function ( ... )

            local hasRefreshNum = self.activityInfo_.extendData.manualRefresh or 0
            local maxRefreshNum = #self.activityInfo_.extendData.manualRefreshList

            local id = self.activityInfo_.extendData.manualRefreshList[math.min(maxRefreshNum,hasRefreshNum + 1)][1]
            local num = self.activityInfo_.extendData.manualRefreshList[math.min(maxRefreshNum,hasRefreshNum + 1)][2] 

            if hasRefreshNum >= maxRefreshNum then 
                Utils:showTips(2460126) 
                return
            end

            if GoodsDataMgr:getItemCount(id) < num  then
                Utils:showTips(2460127)
                return
            end

            local args = {
                tittle = 2107025,
                reType = "taskActivityRefresh",
                content = TextDataMgr:getText(2460128),
                confirmCall = function ( ... )
                    self:reFreshItem()
                end,
            }
            Utils:showReConfirm(args)

        end)
    end
end

function TaskActivityView:onShow()
    self.super.onShow(self)
    self:updateActivity()
end

function TaskActivityView:onCrossSupportInfoRsp( data )
    -- body
    if data.isFirst and data.myScore > 0 then
        Utils:openView("activity.AssistPopView",data.myScore,data.onlineTime)
    end

    if  self.Label_value1 then
        self.Label_value1:setText(data.myScore)
    end

    if  self.Label_value2 then
        self.Label_value2:setText(data.score)
    end
end

function TaskActivityView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId_ ~= activitId then return end
    Utils:showReward(reward)
end

function TaskActivityView:onUpdateProgressEvent()
    self:updateActivity()
end

function TaskActivityView:setBackPlayer()
    self.isBackPlayer = true
end

function TaskActivityView:onUpdateCountDownEvent()
    self:updateCountDonw()
end

function TaskActivityView:reFreshItem()
    -- body
    ActivityDataMgr2:send_ACTIVITY_REQ_ACTIVITY_ITEM_REFRESH(self.activityId_)
end

function TaskActivityView:initProgressTask()
    self.activeTask_ = self.activityInfo_.extendData.activeItemid
    if self.activeTask_ == nil then
        return
    end

    local size = self.Image_active_progress:Size()
    for i = #self.activeTask_, 1, -1 do
        local taskCfg = TaskDataMgr:getTaskInfo(self.activeTask_[i])

        if not self.maxActive_ then
            self.maxActive_ = taskCfg.target
        end

        local percent = taskCfg.target / self.maxActive_
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
        item.Label_getValue:setText(Utils:format_number_w(taskCfg.target))
        self.activeItem_[i] = item
        Panel_activeItem:Pos(size.width * percent, 0):AddTo(self.Image_active_progress,15)

        item.Button_canGet:onClick(function ( ... )
            -- body
            
            if ServerDataMgr:getServerTime() >= self.activityInfo_.endTime then
                Utils:showTips(1710021)
                return
            end
            ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId_,self.activeTask_[i])
        end)  

        item.Button_geted:onClick(function ( ... )
            -- body
            self:showPreview(i)
        end) 

        item.Button_notGet:onClick(function ( ... )
            -- body
            self:showPreview(i)
        end)
    end
end

function TaskActivityView:updateProgressTask(  )
    -- body
     for i, v in ipairs(self.activeItem_ or {}) do
        local taskInfo = TaskDataMgr:getTaskInfo(self.activeTask_[i])
        v.Panel_geted:setVisible(taskInfo.status == EC_TaskStatus.GETED)
        v.Panel_canGet:setVisible(taskInfo.status == EC_TaskStatus.GET)
        v.Panel_notGet:setVisible(taskInfo.status == EC_TaskStatus.ING)

        if i == #self.activeItem_ then
            self.LoadingBar_progress:setPercent(taskInfo.progress*100/self.maxActive_)
        end
    end
end

function TaskActivityView:showPreview(index)
    local item = self.activeItem_[index]
    local wp = item.root:getParent():convertToWorldSpace(item.root:Pos())
    -- local np = self.Image_preview:getParent():convertToNodeSpaceAR(wp)

    local taskCfg = TaskTable[self.activeTask_[index]]
    local reward = {}
    for k,v in pairs(taskCfg.reward) do
        table.insert(reward,{id = v[1], num = v[2]})
    end
    Utils:previewReward(self.Image_preview, reward)

    -- self.Image_preview:Pos(np)
end

return TaskActivityView
