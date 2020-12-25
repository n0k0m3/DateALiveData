
local DuanwuMainView = class("DuanwuMainView", BaseLayer)

function DuanwuMainView:initData()
    local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.DUANWU_1)
    if #activity > 0 then
        self.submitActivityId_ = activity[1]
        self.submitActivityInfo_ = ActivityDataMgr2:getActivityInfo(self.submitActivityId_)
    else
        Utils:showTips("未配置活动类型为%s的活动", EC_ActivityType2.DUANWU_1)
    end

    local datingAward = json.decode(self.submitActivityInfo_.extendData.datingAward)
    local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.DUANWU_2)
    if #activity > 0 then
        self.taskActivityId_ = activity[1]
        self.taskActivityInfo_ = ActivityDataMgr2:getActivityInfo(self.taskActivityId_)
    else
        Utils:showTips("未配置活动类型为%s的活动", EC_ActivityType2.DUANWU_2)
    end
    
    -- local id = self.submitActivityInfo_.extendData.interDating
    -- if id then
    --     local value = Utils:getLocalSettingValue("ActivityTpye_DUANWU_1"..id)
    --     if value == "" then
    --         FunctionDataMgr:jStartDating(id)
    --         Utils:setLocalSettingValue("ActivityTpye_DUANWU_1"..id,"true")
    --     end
	-- end
end

function DuanwuMainView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    if ActivityDataMgr2:getActivityUIType() == 1 then
        self.__cname = "MidAutumnMainView"
        self:init("lua.uiconfig.activity.midAutumnMainView")
    elseif ActivityDataMgr2:getActivityUIType() == 2 then
        self.__cname = "LanternFestivalMainView"
        self:init("lua.uiconfig.activity.lanternFestivalMainView")
    else
        self:init("lua.uiconfig.activity.duanwuMainView")
    end
end

function DuanwuMainView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_task = {}
    for i = 1, 3 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(self.Panel_root, "Panel_task_" .. i)
        foo.Label_name = TFDirector:getChildByPath(foo.root, "Label_name")
        foo.Image_reward = TFDirector:getChildByPath(foo.root, "Image_reward")
        foo.Label_desc = TFDirector:getChildByPath(foo.root, "Label_desc")
        foo.Button_receive = TFDirector:getChildByPath(foo.root, "Button_receive")
        local Label_receive = TFDirector:getChildByPath(foo.Button_receive, "Label_receive")
        foo.Button_goto = TFDirector:getChildByPath(foo.root, "Button_goto")
        foo.Label_goto = TFDirector:getChildByPath(foo.Button_goto, "Label_goto")
        foo.Button_geted = TFDirector:getChildByPath(foo.root, "Button_geted")
        foo.Label_geted = TFDirector:getChildByPath(foo.Button_geted, "Label_geted")
        foo.Spine_get = TFDirector:getChildByPath(foo.root, "Spine_get"):hide()
        foo.Image_diban = TFDirector:getChildByPath(foo.root, "Image_diban")
        foo.lab_last = TFDirector:getChildByPath(foo.root, "lab_last")
        self.Panel_task[i] = foo
    end
    local Image_refresh = TFDirector:getChildByPath(self.Panel_root, "Image_refresh")
    local Label_refresh = TFDirector:getChildByPath(Image_refresh, "Label_refresh")
    -- Label_refresh:setTextById(100000131)
    self.Button_refresh = TFDirector:getChildByPath(Image_refresh, "Button_refresh")
    self.Image_free_refresh = TFDirector:getChildByPath(self.Button_refresh, "Image_free_refresh")
    self.Label_cost_refresh = TFDirector:getChildByPath(self.Button_refresh, "Label_cost_refresh")
    self.Image_cost_refresh = TFDirector:getChildByPath(self.Label_cost_refresh, "Image_cost_refresh")
    self.Image_refresh_tips = TFDirector:getChildByPath(self.Button_refresh, "Image_refresh_tips")
    self.Label_refresh_timing = TFDirector:getChildByPath(Image_refresh, "Label_refresh_timing")

    self.Image_submit = {}
    for i = 1, 3 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(self.Panel_root, "Image_submit_" .. i)
        foo.Label_progress = TFDirector:getChildByPath(foo.root, "Label_progress")
        foo.Image_reward = TFDirector:getChildByPath(foo.root, "Image_reward")
        self.Image_submit[i] = foo
    end
    if ActivityDataMgr2:getActivityUIType() == 2 then
        self.Button_submit = TFDirector:getChildByPath(self.Panel_root, "Button_submit")
    else
        self.Button_submit = TFDirector:getChildByPath(self.Panel_root, "Image_submit.Button_submit")
    end
    self.Image_submit_tips = TFDirector:getChildByPath(self.Button_submit, "Image_submit_tips")
    local Label_submit = TFDirector:getChildByPath(self.Button_submit, "Label_submit")
    Label_submit:setTextById(100000130)

    self.Button_achievement = TFDirector:getChildByPath(self.Panel_root, "Button_achievement")
    self.Image_achievement_tips = TFDirector:getChildByPath(self.Button_achievement, "Image_achievement_tips")
    local Label_achievement = TFDirector:getChildByPath(self.Button_achievement, "Label_achievement")
    Label_achievement:setTextById(100000132)
    self.Button_shop = TFDirector:getChildByPath(self.Panel_root, "Button_shop")
    local Label_shop = TFDirector:getChildByPath(self.Button_shop, "Label_shop")
    Label_shop:setTextById(100000133)
    self.Button_make = TFDirector:getChildByPath(self.Panel_root, "Button_make")
    local Label_make = TFDirector:getChildByPath(self.Button_make, "Label_make")
    Label_make:setTextById(100000134)

    self:refreshView()
end

function DuanwuMainView:refreshView()
    self:updateInfo()
    self:addCountDownTimer()
end

function DuanwuMainView:updateInfo()
    self:updateTask()
    self:updateSubmit()
    self:updateRefreshStatus()
end

function DuanwuMainView:updateTask()
    if not self.taskActivityId_ then return end

    local taskData = ActivityDataMgr2:getItems(self.taskActivityId_)
    for i, v in ipairs(self.Panel_task) do
        local itemId = taskData[i]
        v.root:setVisible(tobool(itemId))
        if itemId then
            local itemInfo = ActivityDataMgr2:getItemInfo(EC_ActivityType2.DUANWU_2, itemId)
            local progressInfo = ActivityDataMgr2:getProgressInfo(EC_ActivityType2.DUANWU_2, itemId)
            v.Label_name:setText(itemInfo.extendData.des)
            v.Label_desc:setText(itemInfo.extendData.des2)
            v.Button_receive:setVisible(progressInfo.status == EC_TaskStatus.GET)
            v.Button_goto:setVisible(progressInfo.status == EC_TaskStatus.ING and itemInfo.extendData.jumpInterface)
            v.Button_geted:setVisible(progressInfo.status == EC_TaskStatus.GETED)
            v.Spine_get:setVisible(progressInfo.status == EC_TaskStatus.GET)
            local rewardId, rewardNum = next(itemInfo.reward)
            local rewardCfg = GoodsDataMgr:getItemCfg(rewardId)
            v.Image_reward:setTexture(rewardCfg.icon)
            v.Image_reward:onClick(function()
                    Utils:showInfo(rewardId)
            end)
            v.Button_goto:onClick(function()
                    FunctionDataMgr:enterByFuncId(itemInfo.extendData.jumpInterface)
            end)
            v.Button_receive:onClick(function()
                    ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.taskActivityId_, itemId)
            end)

            if ActivityDataMgr2:getActivityUIType() == 2 then
                if v.Button_goto:isVisible() then
                    v.Image_diban:setTexture("ui/activity/lanternFestival/main/012.png")
                    v.Label_name:setFontColor(ccc3(255,255,255))
                    v.Label_desc:setFontColor(ccc3(224,191,115))
                end
                if v.Button_geted:isVisible() then
                    v.Image_diban:setTexture("ui/activity/lanternFestival/main/014.png")
                    v.Label_name:setFontColor(ccc3(246,201,134))
                    v.Label_desc:setFontColor(ccc3(246,201,134))
                end
                if v.Button_receive:isVisible() then
                    v.Image_diban:setTexture("ui/activity/lanternFestival/main/016.png")
                    v.Label_name:setFontColor(ccc3(190,16,35))
                    v.Label_desc:setFontColor(ccc3(190,16,35))
                end
                v.lab_last:setText(rewardNum)
            end
        end
    end
end

function DuanwuMainView:updateSubmit()
    local data = ActivityDataMgr2:getItems(self.submitActivityId_)
    local submitData = {}
    for i, v in ipairs(data) do
        local itemInfo = ActivityDataMgr2:getItemInfo(self.submitActivityInfo_.activityType, v)
        if itemInfo.extendData.specialTask then
            table.insert(submitData, v)
        end
    end

    for i, v in ipairs(self.Image_submit) do
        local itemId = submitData[i]
        v.root:setVisible(tobool(itemId))
        if itemId then
            local itemInfo = ActivityDataMgr2:getItemInfo(self.submitActivityInfo_.activityType, itemId)
            local progressInfo = ActivityDataMgr2:getProgressInfo(self.submitActivityInfo_.activityType, itemId)
            local rewardCid, rewardNum = next(itemInfo.reward)
            local rewardCfg = GoodsDataMgr:getItemCfg(rewardCid)
            v.Image_reward:setTexture(rewardCfg.icon)
            if progressInfo.status == EC_TaskStatus.ING then
                v.Label_progress:setTextById(800005, progressInfo.progress, itemInfo.target)
            elseif progressInfo.status == EC_TaskStatus.GET then

            elseif progressInfo.status == EC_TaskStatus.GETED then
                v.Label_progress:setTextById(1300006)
            end
        end
    end
end

function DuanwuMainView:updateRefreshStatus()
    local taskActivityInfo = ActivityDataMgr2:getActivityInfo(self.taskActivityId_)
    local extendData = taskActivityInfo.extendData
    local itemCfg = GoodsDataMgr:getItemCfg(extendData.refreshItemId)
   	local itemRecoverCfg = StoreDataMgr:getItemRecoverCfg(itemCfg.buyItemRecover)
    local usedCount = extendData.refreshCount or 0
    local cost = StoreDataMgr:getBuyItemRecoverFromInfo(itemCfg.buyItemRecover, math.min(usedCount + 1, #itemRecoverCfg.price))
    local costCid, costNum = next(cost)
    local costCfg = GoodsDataMgr:getItemCfg(costCid)

   	local remainCount = math.max(0, #itemRecoverCfg.price - usedCount)
    local remainTime = math.max(0, extendData.refreshTime / 1000 - ServerDataMgr:getServerTime())
    local isFree = nil

    if remainTime <= 0 or costNum == 0 then
        isFree = true
    else
        isFree = false
    end

    self.Image_refresh_tips:setVisible(isFree)
    self.Image_free_refresh:setVisible(isFree)
    self.Label_cost_refresh:setVisible(not isFree)

    self.Image_cost_refresh:setTexture(GoodsDataMgr:getItemCfg(costCid).icon)
    self.Label_cost_refresh:setText(costNum)

    local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
    self.Label_refresh_timing:setTextById(100000141, hour, min)

    local enabled = isFree or remainCount > 0
    self.Button_refresh:setGrayEnabled(not enabled)

    local  function refreshRsp ()
        local refreshTime = extendData.refreshTime or 0
        local remainTime = math.max(0, math.ceil(refreshTime / 1000) - ServerDataMgr:getServerTime())
        if remainTime > 0 then
            if remainCount > 0 then
                TFDirector:send(c2s.ACTIVITY_REQ_REFRESH_ENTRUST_ACTIVITY_TASK, {self.taskActivityId_ ,2})
            else
                Utils:showTips(100000144)
            end
        else
            TFDirector:send(c2s.ACTIVITY_REQ_REFRESH_ENTRUST_ACTIVITY_TASK, {self.taskActivityId_ ,1})
        end
    end

    self.Button_refresh:onClick(function()

        local function refreshCalFunc()
            if isFree then
                refreshRsp()
            elseif remainCount > 0 then
                if MainPlayer:getOneLoginStatus(EC_OneLoginStatusType.ReConfirm_DuanwuTaskRefresh) then
                    refreshRsp()
                else
                    local args = {
                        tittle = 100000142,
                        content = TextDataMgr:getText(100000143, costNum, costCfg.icon, remainCount),
                        reType = EC_OneLoginStatusType.ReConfirm_DuanwuTaskRefresh,
                        confirmCall = function()
                            refreshRsp()
                        end,
                    }
                    Utils:showReConfirm(args)
                end
            else
                Utils:showTips(100000144)
            end
        end

        if not ActivityDataMgr2:getActivityUIType() == 1 then
            refreshCalFunc()
            return
        end

        local isFinish = true
        for i, v in ipairs(self.Panel_task) do
            if not v.Button_geted:isVisible() then
                isFinish = false
                break
            end
        end

        if isFinish then
            refreshCalFunc()
        else
            Utils:openView("chronoCross.ChronoTaskConfirmView",{titleStrId = 13310469, tipStrId = 13310470,},refreshCalFunc)
        end
        
    end)
end

function DuanwuMainView:registerEvents()
  	EventMgr:addEventListener(self, EV_ACTIVITY_REFRESH_ENTRUST, handler(self.onRefreshEntrustEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onUpdateProgressEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.onUpdateActivityEvent, self))

    self.Button_achievement:onClick(function()
            Utils:openView("activity.DuanwuTaskView")
    end)

    self.Button_shop:onClick(function()
        if ActivityDataMgr2:getActivityUIType() == 1 then
            FunctionDataMgr:jStore(311000)
        elseif ActivityDataMgr2:getActivityUIType() == 2 then
            FunctionDataMgr:jStore(310000)
        else
            FunctionDataMgr:jStore(305000)
        end
    end)

    self.Button_make:onClick(function()
            Utils:openView("activity.DuanwuMakeView", self.submitActivityInfo_.extendData.makeDating)
    end)

    self.Button_submit:onClick(function()
            Utils:openView("activity.DuanwuSubmitView")
    end)
end

function DuanwuMainView:updateCountDown()
    local taskActivityInfo = ActivityDataMgr2:getActivityInfo(self.taskActivityId_)

end

function DuanwuMainView:removeEvents()
    self:removeCountDownTimer()
end

function DuanwuMainView:onCountDownPer(index)
    self:updateRefreshStatus()
end

function DuanwuMainView:onShow()
    self.super.onShow(self)

    local data = ActivityDataMgr2:getItems(self.submitActivityId_)
    local achievementData = {}
    local submitData = {}
    for i, v in ipairs(data) do
        local itemInfo = ActivityDataMgr2:getItemInfo(self.submitActivityInfo_.activityType, v)
        if itemInfo.extendData.specialTask then
            table.insert(submitData, v)
        else
            table.insert(achievementData, v)
        end
    end

    local function canGet(taskData)
        local isCanGet = false
        for i, v in ipairs(taskData) do
            local progressInfo = ActivityDataMgr2:getProgressInfo(self.submitActivityInfo_.activityType, v)
            if progressInfo.status == EC_TaskStatus.GET then
                isCanGet = true
                break
            end
        end
        return isCanGet
    end

    self.Image_achievement_tips:setVisible(canGet(achievementData))
    self.Image_submit_tips:hide()
end

function DuanwuMainView:addCountDownTimer(storeId)
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, -1, nil, handler(self.onCountDownPer, self))
    end
end

function DuanwuMainView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
    end
end

function DuanwuMainView:onRefreshEntrustEvent()
    self:updateInfo()
    Utils:showTips(12100079)
end

function DuanwuMainView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.taskActivityId_ == activitId then
        Utils:showReward(reward)
    end

    self:updateInfo()
end

function DuanwuMainView:onUpdateProgressEvent()
    self:updateInfo()
end

function DuanwuMainView:onUpdateActivityEvent()
    self:updateInfo()
end

return DuanwuMainView
