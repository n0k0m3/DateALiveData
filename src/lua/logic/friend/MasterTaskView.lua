--[[
    @师徒任务界面
]]

local MasterTaskView = class("MasterTaskView", BaseLayer)

function MasterTaskView:initData()
    self.allCfgs = nil -- 所有阶段配置
    self.data = nil  -- 当前阶段包含数据
    self.activeItems = {}
    self:refreshData()
end

function MasterTaskView:refreshData()
    local isMasterExist, isApprenticeExist = FriendDataMgr:isHaveMasterApprentice()
    if isApprenticeExist then
        self.allCfgs = FriendDataMgr:getDrillmasterTaskCfg(1)
    elseif isMasterExist then
        self.allCfgs = FriendDataMgr:getDrillmasterTaskCfg(2)
    end

    self.isMaster = isApprenticeExist
    table.sort(self.allCfgs, function(a, b)
        return a.taskStage < b.taskStage
    end)
    for i, v in ipairs(self.allCfgs) do
        local isInTheTask = false
        for j, taskCid in pairs(v.finishParams) do
            local taskInfo = TaskDataMgr:getTaskInfo(taskCid)
            if taskInfo and taskInfo.status == EC_TaskStatus.ING then
                isInTheTask = true
                break
            end
        end
        if isInTheTask then
            self.data = v
            break
        end
    end

    if nil == self.data then
        self.data = self.allCfgs[#self.allCfgs]
    end
end

function MasterTaskView:ctor(...)
    self.super.ctor(self)
    self:showPopAnim(true)
    self:initData(...)
    self:init("lua.uiconfig.friend.masterTaskView")
end

function MasterTaskView:initUI(ui)
    self.super.initUI(self, ui)

    self._ui.lab_TopTxt:setTextById(1340025)

    self.ScrollView_content = UIListView:create(self._ui.ScrollView_content)
    local scrollBar = UIScrollBar:create(self._ui.Image_shieldingScrollBar, self._ui.Image_scrollBarInner)
    self.ScrollView_content:setScrollBar(scrollBar)
    self._ui.Panel_content:retain()
    self._ui.Panel_content:removeFromParent()
    self.ScrollView_content:pushBackCustomItem(self._ui.Panel_content)
    self._ui.Panel_content:release()

    self.taskView = UIListView:create(self._ui.ScrollView_task)
    self._ui.Panel_activeItem:hide()

    self._ui.btn_outMaster:setVisible(not FriendDataMgr:isApprenticeFinished())
    TFDirector:getChildByPath(self._ui.btn_outMaster, "txt"):setTextById(1340070)
    self._ui.lab_hadOutMaster:setTextById(1340072)
    self._ui.lab_hadOutMaster:setVisible(not self._ui.btn_outMaster:isVisible())

    self:initGiftItems()
    self:refreshAllView()
end

function MasterTaskView:refreshAllView()
    self:refreshLittleTask()
    self:refreshGifts()
    self:refreshAwards()
end

function MasterTaskView:registerEvents()
    self._ui.btn_close:onClick(function()
        AlertManager:close(self)
    end)

    self._ui.btn_outMaster:onClick(function()
        local isFinishAllTask = true -- 是否完成了所有小任务
        
        for i, v in ipairs(self.allCfgs) do
            local isInTheTask = false
            for j, taskCid in pairs(v.finishParams) do
                local taskInfo = TaskDataMgr:getTaskInfo(taskCid)
                if taskInfo and taskInfo.status == EC_TaskStatus.ING then
                    isInTheTask = true
                    break
                end
            end
            if isInTheTask then
                isFinishAllTask = false
                break
            end
        end

        if isFinishAllTask then
            for i, v in ipairs(self.allCfgs) do
                if not FriendDataMgr:getTaskBoolByStage(v.taskStage) then
                    Utils:showTips(1340016)
                    return
                end
            end

           local state_1, state_2 = FriendDataMgr:isHaveMasterApprentice()
           local id_1, id_2       = FriendDataMgr:getBothId()
           local type, id
           if state_1 then
                type = 10
                id   =  id_1
            end
            if state_2 then
                type = 9
                id   = id_2
            end
            FriendDataMgr:send_APPRENTICE_REQ_HANDLE_APPRENTICE(type, id)  
        else
            Utils:showTips(1340017)
        end
    end)
    
    EventMgr:addEventListener(self,EV_FRIEND_MASTERGETREWARD_UPDATE, function()
        self:refreshData()
        self:refreshAllView()
    end)
    EventMgr:addEventListener(self,EV_FRIEND_OUTMASTER_UPDATE,function()
        self._ui.btn_outMaster:setVisible(false)
        self._ui.lab_hadOutMaster:setVisible(true)
    end)
    EventMgr:addEventListener(self, EV_TASK_UPDATE,  function()
        self:refreshData()
        self:refreshAllView()
    end)
end

function MasterTaskView:initGiftItems()
    local size = self._ui.Image_active_progress:Size()
    for i, v in ipairs(self.allCfgs) do
        local Panel_activeItem = self._ui.Panel_activeItem:clone()
        Panel_activeItem:show()
        local item = {}
        item.root = Panel_activeItem
        item.Panel_geted = TFDirector:getChildByPath(item.root, "Panel_geted")
        item.Button_geted = TFDirector:getChildByPath(item.Panel_geted, "Button_geted")
        item.Panel_canGet = TFDirector:getChildByPath(item.root, "Panel_canGet")
        item.Spine_receive = TFDirector:getChildByPath(item.Panel_canGet, "Spine_receive")
        item.Button_canGet = TFDirector:getChildByPath(item.Panel_canGet, "Button_canGet")
        item.Panel_notGet = TFDirector:getChildByPath(item.root, "Panel_notGet")
        item.Button_notGet = TFDirector:getChildByPath(item.Panel_notGet, "Button_notGet")
        item.lab_itemDesc = TFDirector:getChildByPath(item.root, "lab_itemDesc")
        item.lab_itemDesc:setText(v.taskStage)
        self.activeItems[i] = item
        Panel_activeItem:Pos(size.width / #self.allCfgs * i - 5, 3):AddTo(self._ui.Image_active_progress)

        item.Button_notGet:onClick(function()
            local rewards = {}
            for i, goods in ipairs(v.reward) do
                table.insert(rewards ,{id = goods[1] , num = goods[2]})
            end
            Utils:previewReward(nil, rewards)
        end)

        item.Button_canGet:onClick(function()
            FriendDataMgr:send_APPRENTICE_REQ_TASK_REWARD(v.id)
        end)
    end
end

function MasterTaskView:refreshGifts()
    local sumLittleTaskNum = 0
    -- local curHadFinshedNum = 0 -- 已经完成的小任务以大阶段为节点
    for i, v in ipairs(self.allCfgs) do
        local item = self.activeItems[i]
        local isHadGet = FriendDataMgr:getTaskBoolByStage(v.taskStage)
        local isFinishAllLittleTask = true
        for j, taskCid in pairs(v.finishParams) do
            local taskInfo = TaskDataMgr:getTaskInfo(taskCid)
            if taskInfo then
                if taskInfo.status == EC_TaskStatus.ING then
                    isFinishAllLittleTask = false
                    break
                end
            else
                isFinishAllLittleTask = false
                break
            end
            -- if self.data.taskStage >= v.taskStage then
            --     curHadFinshedNum = curHadFinshedNum + 1
            -- end
        end 
        sumLittleTaskNum = sumLittleTaskNum +  table.count(v.finishParams)
        item.Panel_geted:setVisible(isHadGet)
        item.Panel_canGet:setVisible(not isHadGet and isFinishAllLittleTask)
        item.Panel_notGet:setVisible(not isHadGet and not isFinishAllLittleTask)
    end 
    local percent = self:getCurHadFinshedTaskNum() / sumLittleTaskNum
    self._ui.LoadingBar_activeProgress:setPercent(percent*100)
    self._ui.lab_taskDesc:setTextById(self.data.des)
    self._ui.lab_taskTitle:setTextById(self.data.des3)
end

function MasterTaskView:getCurHadFinshedTaskNum()
    local num = 0
    for i, v in ipairs(self.allCfgs) do
        for j, taskCid in pairs(v.finishParams) do
            local taskInfo = TaskDataMgr:getTaskInfo(taskCid)
            if taskInfo then
                if taskInfo.status ~= EC_TaskStatus.ING then
                    num = num + 1
                end
            end
        end
    end
    return num
end

function MasterTaskView:refreshLittleTask()
    self.taskView:removeAllItems()
    for i, taskId in pairs(self.data.finishParams) do
        local taskInfo = TaskDataMgr:getTaskInfo(taskId)
        local taskCfg  = TaskDataMgr:getTaskCfg(taskId)
        local item = self._ui.PanelTaskItem:clone()
        local lab_itemDesc = TFDirector:getChildByPath(item, "lab_itemDesc")
        local btn_go       = TFDirector:getChildByPath(item, "btn_go")
        local lab_complete = TFDirector:getChildByPath(item, "lab_complete")
        local lab_progress = TFDirector:getChildByPath(item, "lab_progress")

        if taskInfo then
            lab_itemDesc:setTextById(taskCfg.des)
            btn_go:setVisible(taskInfo.status == EC_TaskStatus.ING and not self.isMaster)
            lab_complete:setVisible(taskInfo.status ~= EC_TaskStatus.ING)
            lab_progress:setText(math.min(taskInfo.progress,taskCfg.progress).."/"..taskCfg.progress)
            btn_go:onClick(function()
                FunctionDataMgr:enterByFuncId(taskCfg.jumpInterface)
            end)
            item:show()
            self.taskView:pushBackCustomItem(item)
        end
    end
end

function MasterTaskView:refreshAwards()
    if not self.rewardsItem then
        self.rewardsItem = {}
        for i, v in ipairs(self._ui.Panel_awards:getChildren()) do
            local goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            goods:setScale(0.7)
            goods:AddTo(v):Pos(0,0):ZO(1)
            table.insert(self.rewardsItem, goods)
        end
    end
    
    for i, item in ipairs(self.rewardsItem) do
        local cfg = self.data.reward[i]
        if cfg then
            PrefabDataMgr:setInfo(item, cfg[1], cfg[2])
        end
        item:setVisible(nil ~= cfg)
    end
end

return MasterTaskView