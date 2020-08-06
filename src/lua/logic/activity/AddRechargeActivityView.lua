local AddRechargeActivityView = class("AddRechargeActivityView", BaseLayer)

function AddRechargeActivityView:ctor(...)
    self.super.ctor(self)
    self:initData(...)

    if self.activityInfo_.extendData.activityShowType == 2 then
        self:init("lua.uiconfig.activity.addRechargeActivityView1")
    elseif self.activityInfo_.extendData.activityShowType == 3 then
        self:init("lua.uiconfig.activity.addRechargeActivityView3")
    elseif self.activityInfo_.extendData.activityShowType == 6 then
        self:init("lua.uiconfig.activity.addRechargeActivityView6")
    else
        self:init("lua.uiconfig.activity.addRechargeActivityView")
    end
end

function AddRechargeActivityView:registerEvents()
    self.Panel_root:onClick(function()
        -- self.Image_preview:hide()
    end)

    self.Button_recharge:onClick(function()
        FunctionDataMgr:enterByFuncId(1)
    end)
end

function AddRechargeActivityView:initData(activityId)
    self.activityId_ = activityId
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
end

function AddRechargeActivityView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_root:setSwallowTouch(false)
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
    self.Panel_taskItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_taskItem")

    self.Image_bg = TFDirector:getChildByPath(ui, "Image_bg")
    self.Label_tip1 = TFDirector:getChildByPath(ui, "Label_tip1")
    self.Label_tip2 = TFDirector:getChildByPath(ui, "Label_tip2")
    self.Button_recharge = TFDirector:getChildByPath(ui, "Button_recharge")
    self.Label_addRecharge_title = TFDirector:getChildByPath(ui, "Label_addRecharge_title")
    self.Label_recharge = TFDirector:getChildByPath(ui, "Label_recharge")
    self.Label_timing = TFDirector:getChildByPath(ui, "Label_timing")
    self.ListView_task = UIListView:create(TFDirector:getChildByPath(ui, "ScrollView_task"))
    self.ListView_task:setItemsMargin(0)

    -- self.Image_preview = Utils:previewReward()
    -- self.Image_preview:AddTo(self.Panel_root, 1000)
end

function AddRechargeActivityView:showRewardPreview(item, reward)
    -- self.Image_preview:AnchorPoint(ccp(0.5, 0))
    local format_reward = {}
    for k, v in pairs(reward) do
        local item = Utils:makeRewardItem(k, v)
        table.insert(format_reward, item)
    end

    local wp = item:convertToWorldSpaceAR(me.p(0, 0))
    local np = self.Panel_root:convertToNodeSpaceAR(wp)
    self.Image_preview = Utils:previewReward(self.Image_preview, format_reward, 0.6)
    -- self.Image_preview:Show():Pos(np)
end

function AddRechargeActivityView:updateCountDonw()
    if self.activityInfo_.extendData.activityShowType == 3 then
        local startDate = Utils:getLocalDate(self.activityInfo_.startTime)
        local startDateStr = startDate:fmt("%m.%d")
        local endDate = Utils:getLocalDate(self.activityInfo_.endTime)
        local endDateStr = endDate:fmt("%m.%d")
        self.Label_timing:setTextById(800041, startDateStr, endDateStr)
    else
        local isEnd = ActivityDataMgr2:isEnd(self.activityId_)
        local serverTime = ServerDataMgr:getServerTime()
        if isEnd then
            local remainTime = math.max(0, self.activityInfo_.showEndTime - serverTime)
            local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
            if day == "00" then
                self.Label_timing:setTextById("r41004", hour, min)
            else
                self.Label_timing:setTextById("r41003", day, hour)
            end
        else
            local remainTime = math.max(0, self.activityInfo_.endTime - serverTime)
            local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
            if day == "00" then
                self.Label_timing:setTextById("r41002", hour, min)
            else
                self.Label_timing:setTextById("r41001", day, hour)
            end
        end
    end
end

function AddRechargeActivityView:updateActivity()
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    local items = ActivityDataMgr2:getItems(self.activityId_)
    --dump(items, "items")
    local taskItems = self.ListView_task:getItems()
    local oldcount = #taskItems
    local newcount = #items
    if newcount >= oldcount then
        local addcount = newcount - oldcount
        for i = 1, addcount do
            local newitem = self.Panel_taskItem:clone():show()
            self.ListView_task:pushBackCustomItem(newitem)
        end
    else
        local removecount = oldcount - newcount
        for i = 1, removecount do
            self.ListView_task:removeLastItem()
        end
    end
    local curRecharge = 0
    for i, v in ipairs(items) do
        local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, v)
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, v)
        --dump(itemInfo, "itemInfo")
        if progressInfo.progress > curRecharge then
            curRecharge = progressInfo.progress
        end

        local item = self.ListView_task:getItem(i)
        local Panel_get = TFDirector:getChildByPath(item, "Panel_get"):hide()
        local Button_get = TFDirector:getChildByPath(Panel_get, "Button_get")
        local Spine_receive = TFDirector:getChildByPath(Panel_get, "Spine_receive")
        local Spine_receive1 = TFDirector:getChildByPath(Panel_get, "Spine_receive1")
        local Panel_notGet = TFDirector:getChildByPath(item, "Panel_notGet"):hide()
        local Image_notGet = TFDirector:getChildByPath(Panel_notGet, "Image_notGet")
        local Panel_geted = TFDirector:getChildByPath(item, "Panel_geted"):hide()
        local Image_geted = TFDirector:getChildByPath(Panel_geted, "Image_geted")
        if progressInfo.status == EC_TaskStatus.ING then
            Panel_notGet:show()
            Panel_notGet:getChild("Label_money"):setTextById(1890020, itemInfo.target)
        elseif progressInfo.status == EC_TaskStatus.GET then
            Panel_get:show()
            Spine_receive:play("animation", true)
            if Spine_receive1 then
                Spine_receive1:play("animation2", true)
            end
        elseif progressInfo.status ==  EC_TaskStatus.GETED then
            Panel_geted:show()
        end
        Button_get:onClick(function(sender)
            ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityInfo_.id, v)
        end)
        Image_notGet:onClick(function(sender)
            local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, v)
            self:showRewardPreview(sender, itemInfo.reward)
        end)
        Image_geted:onClick(function(sender)
            local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, v)
            self:showRewardPreview(sender, itemInfo.reward)
        end)
    end
    if self.Label_addRecharge_title then
        self.Label_addRecharge_title:setText("当前充值金额：")
        self.Label_recharge:setTextById(1890020, curRecharge)
    else
        self.Label_recharge:setTextById(1890020, curRecharge)
    end
    

    self:updateCountDonw()
    self.Image_bg:setTexture(self.activityInfo_.showIcon)
    self.Label_tip1:setText(self.activityInfo_.activityTitle)
    self.Label_tip2:setText(self.activityInfo_.extendData.subtitle)
end

function AddRechargeActivityView:onSubmitSuccessEvent(activitId, itemId, reward)
    Utils:showReward(reward)
    --self:updateActivity()
end

function AddRechargeActivityView:onUpdateProgressEvent()
    self:updateActivity()
end

function AddRechargeActivityView:onUpdateCountDownEvent()
    self:updateCountDonw()
end

return AddRechargeActivityView
