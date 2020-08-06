
local KuangsanTaskView = class("KuangsanTaskView",BaseLayer)

function KuangsanTaskView:ctor( data )
    self.super.ctor(self,data)
    self.activityId_ = data
    KsanCardDataMgr:Send_GetCardData( self.activityId_ )
    self:initData()
    self:init("lua.uiconfig.activity.kuangsanTaskView")
end

function KuangsanTaskView:initData()

end

function KuangsanTaskView:initUI( ui )
    -- body
    self.super.initUI(self,ui)

    self.Button_award = TFDirector:getChildByPath(ui, "Button_award")
    self.Button_refreshTask = TFDirector:getChildByPath(ui, "Button_refreshTask")
    self.Image_cost_icon = TFDirector:getChildByPath(self.Button_refreshTask, "Image_cost_icon")
    self.Label_cost = TFDirector:getChildByPath(self.Button_refreshTask, "Label_cost_num")
    self.Label_free = TFDirector:getChildByPath(self.Button_refreshTask, "Label_free"):hide()
    self.Panel_notFree = TFDirector:getChildByPath(self.Button_refreshTask, "Panel_notFree"):hide()

    self.Label_time = TFDirector:getChildByPath(ui, "Label_time")
    self.Label_end_time = TFDirector:getChildByPath(ui, "Label_end_time")

    self.Panel_cost = TFDirector:getChildByPath(ui, "Panel_cost")
    self.Label_refreshTime = TFDirector:getChildByPath(self.Panel_cost, "Label_refreshTime")
    self.Label_task_progress = TFDirector:getChildByPath(ui, "Label_task_progress")
    self.Label_task_progress:setText("")

    self.Panel_task_item = {}
    for k=1,3 do
        local item = TFDirector:getChildByPath(ui, "Panel_task_item_"..k)
        local Image_geted = TFDirector:getChildByPath(item, "Image_geted"):hide()
        local Label_name = TFDirector:getChildByPath(item, "Label_name")
        local Label_desc = TFDirector:getChildByPath(item, "Label_desc")
        local Button_normal = TFDirector:getChildByPath(item, "Button_normal")
        local Button_get = TFDirector:getChildByPath(item, "Button_get")
        local Image_item_icon = TFDirector:getChildByPath(item, "Image_item_icon")
        Image_item_icon:setTouchEnabled(true)
        table.insert(self.Panel_task_item,{item = item,getedBg = Image_geted,name = Label_name,desc = Label_desc,
                                           btnNoraml = Button_normal, btnGet = Button_get, icon = Image_item_icon})
    end

    self:initUILogic()

end

function KuangsanTaskView:initUILogic()

    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    local startDate = Utils:getLocalDate(self.activityInfo_.startTime)
    local startDateStr = startDate:fmt("%Y.%m.%d")
    local endDate = Utils:getLocalDate(self.activityInfo_.endTime)
    local endDateStr = endDate:fmt("%Y.%m.%d")
    self.Label_time:setText("")
    self.Label_end_time:setText("")

    self.Label_task_progress:setText("活动开放时间："..startDateStr.."-"..endDateStr)
    self:refreshTime()
    self:updateTask()
end

function KuangsanTaskView:updateProgress()

    --local cardInfo = KsanCardDataMgr:getCardInfo()
    --local finishCnt = 0
    --for k,v in ipairs(cardInfo) do
    --    if v.id then
    --        finishCnt = finishCnt + 1
    --    end
    --end
    --local totalCnt = #cardInfo
    --local str = TextDataMgr:getText(13312004)
    --self.Label_task_progress:setText(str.." "..(totalCnt - finishCnt).."/"..totalCnt)
end

function KuangsanTaskView:refreshTime()

    local act = CCSequence:create({
        CCCallFunc:create(function ()
            local nextTime = self.activityInfo_.extendData.refreshTime or 0
            local curTime = ServerDataMgr:getServerTime()
            local remainTime = math.max(0, math.ceil(nextTime/1000) - curTime)

            local day, hour, min, sec = Utils:getDHMS(remainTime, true)
            self.Label_refreshTime:setText(string.format("%02d:%02d:%02d", hour, min, sec))

            self.Label_free:setVisible(remainTime <= 0)
            self.Panel_notFree:setVisible(remainTime > 0)

        end),
        CCDelayTime:create(1)
    })
    self.Label_refreshTime:runAction(CCRepeatForever:create(act))
end

function KuangsanTaskView:updateCost()

    self.itemCfg_ = GoodsDataMgr:getItemCfg(self.activityInfo_.extendData.refreshItemId)
    self.itemRecoverCfg = TabDataMgr:getData("ItemRecover",self.itemCfg_.buyItemRecover)
    local usedCount = self.activityInfo_.extendData.refreshCount or 0
    usedCount = math.min(#self.itemRecoverCfg.price-1 ,usedCount)
    local cost = self.itemRecoverCfg.price[usedCount + 1][1][1]
    self.Image_cost_icon:setTexture(GoodsDataMgr:getItemCfg(cost.id).icon)
    self.Image_cost_icon:setScale(0.6)
    self.Label_cost:setText(cost.num)
end

function KuangsanTaskView:updateTask()

    local items = self.activityInfo_.items
    for i=1,3 do
        local itemId = items[i]
        if not itemId then
            self.Panel_task_item[i].item:setVisible(false)
        else
            self.Panel_task_item[i].item:setVisible(true)
            self:updateTaskItem(i,itemId)
        end
    end

    self:updateCost()
end

function KuangsanTaskView:updateTaskItem(index,id)

    local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, id)
    if not itemInfo then
        return
    end

    local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, id)
    local state = progressInfo.status
    local descColor = state == EC_TaskStatus.GETED and ccc3(101,44,56) or ccc3(166,87,113)
    local nameColor = state == EC_TaskStatus.GETED and ccc3(178,99,125) or ccc3(232,56,89)

    local itemId
    local reward = itemInfo.reward
    for k,v in pairs(reward) do
        itemId = k
        break
    end

    if itemId then
        local itemCfg = GoodsDataMgr:getItemCfg(itemId)
        self.Panel_task_item[index].icon:setTexture(itemCfg.icon)

        self.Panel_task_item[index].icon:onClick(function()
            Utils:showInfo(itemId,nil,true)
        end)
    end

    self.Panel_task_item[index].name:setText(itemInfo.extendData.des)
    self.Panel_task_item[index].name:setColor(nameColor)
    self.Panel_task_item[index].desc:setText(itemInfo.extendData.des2)
    self.Panel_task_item[index].desc:setColor(descColor)

    self.Panel_task_item[index].getedBg:setVisible(state == EC_TaskStatus.GETED)
    self.Panel_task_item[index].btnNoraml:setVisible(state == EC_TaskStatus.ING)
    self.Panel_task_item[index].btnGet:setVisible(state == EC_TaskStatus.GET)

end

function KuangsanTaskView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId_ ~= activitId then return end
    Utils:showReward(reward)
    self:updateTask()
end

function KuangsanTaskView:onUpdateTask()
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    self:refreshTime()
    self:updateTask()
end

function KuangsanTaskView:jumpTo(index)
    local taskItemId = self.activityInfo_.items[index]
    if not taskItemId then
        return
    end
    local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, taskItemId)
    FunctionDataMgr:enterByFuncId(itemInfo.extendData.jumpInterface)
end

function KuangsanTaskView:submitTask(index)
    local taskId = self.activityInfo_.items[index]
    if not taskId then
        return
    end
    ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId_, taskId)
end

function KuangsanTaskView:hasCanGetTask()
    local items = ActivityDataMgr2:getItems(self.activityId_)
    for k,v in pairs(items) do
        local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType,v)
        if progressInfo.status == EC_TaskStatus.GET then
            return true
        end
    end
    return false
end

function KuangsanTaskView:refreshTask()

    if self:hasCanGetTask() then
        local args = {
            tittle = 2107025,
            reType = nil,
            content = TextDataMgr:getText(12100089),
            confirmCall = function ( ... )
                -- body
            end,
        }
        Utils:showReConfirm(args)
        return
    end

    self.activityInfo_.extendData.refreshTime = self.activityInfo_.extendData.refreshTime or 0
    local remainTime = math.max(0, math.ceil(self.activityInfo_.extendData.refreshTime/1000) - ServerDataMgr:getServerTime())
    if remainTime > 0 then
        Utils:openView("activity.EntrustGemFlushView", self.activityInfo_)
    else
        TFDirector:send(c2s.ACTIVITY_REQ_REFRESH_ENTRUST_ACTIVITY_TASK,{self.activityId_ ,1})
    end
end

function KuangsanTaskView:onRefreshEntrustEvent()
    Utils:showTips(12100079)
end

function KuangsanTaskView:registerEvents()


    --EventMgr:addEventListener(self, EV_KSAN_CARDS, handler(self.updateProgress, self))
    --EventMgr:addEventListener(self, EV_KSAN_MATCH_CARDS, handler(self.updateProgress, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_REFRESH_ENTRUST, handler(self.onRefreshEntrustEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.onUpdateTask, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onUpdateTask, self))

    self.Button_refreshTask:onClick(function()
        self:refreshTask()
    end)

    self.Button_award:onClick(function()
        Utils:openView("activity.KuangsanTaskCardView",self.activityId_)
    end)

    for k,v in ipairs(self.Panel_task_item) do
        v.btnNoraml:onClick(function()
            self:jumpTo(k)
        end)
        v.btnGet:onClick(function()
            ---检测是否有item
            self:submitTask(k)
        end)
    end

end


return KuangsanTaskView