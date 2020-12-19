
local RechargeActivityView = class("RechargeActivityView", BaseLayer)

function RechargeActivityView:initData(activityId)
    self.activityId_ = activityId
    self.goodsItems_ = {}
    self.topSplitItem_ = {}
    self.dayItem_ = {}
    self.rewardItem_ = {}
    self.selectItem_ = nil
end

function RechargeActivityView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.rechargeActivityView")
end

function RechargeActivityView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_rewardItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_rewardItem")
    self.Image_bottomSplitItem = TFDirector:getChildByPath(self.Panel_prefab, "Image_bottomSplitItem")
    self.Image_topSplitItem = TFDirector:getChildByPath(self.Panel_prefab, "Image_topSplitItem")
    self.Panel_dayItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_dayItem")

    self.Image_ad = TFDirector:getChildByPath(self.Panel_root, "Image_ad")
    self.Panel_full_reward = TFDirector:getChildByPath(self.Image_ad, "Panel_full_reward")
    self.Button_preview_pink = TFDirector:getChildByPath(self.Panel_full_reward, "Button_preview_pink")
    self.Button_preview_blue = TFDirector:getChildByPath(self.Panel_full_reward, "Button_preview_blue")
    self.Spine_receive = TFDirector:getChildByPath(self.Panel_full_reward, "Spine_receive"):hide()
    self.Image_no_reach = TFDirector:getChildByPath(self.Panel_full_reward, "Image_no_reach")
    self.Label_no_reach = TFDirector:getChildByPath(self.Image_no_reach, "Label_no_reach")
    self.Image_geted = TFDirector:getChildByPath(self.Panel_full_reward, "Image_geted")
    self.Label_geted = TFDirector:getChildByPath(self.Image_geted, "Label_geted")
    self.Image_tag = TFDirector:getChildByPath(self.Panel_full_reward, "Image_tag")
    self.Label_tag = TFDirector:getChildByPath(self.Image_tag, "Label_tag")
    self.Button_receive = TFDirector:getChildByPath(self.Panel_full_reward, "Button_receive")
    self.Label_receive = TFDirector:getChildByPath(self.Button_receive, "Label_receive")
    self.Image_progress = TFDirector:getChildByPath(self.Image_ad, "Image_progress")
    self.Panel_bottom_split = TFDirector:getChildByPath(self.Image_progress, "Panel_bottom_split")
    self.Image_top_progress = TFDirector:getChildByPath(self.Image_progress, "Image_top_progress")
    self.Panel_top_split = TFDirector:getChildByPath(self.Image_progress, "Panel_top_split")
    self.Label_tips = TFDirector:getChildByPath(self.Image_ad, "Image_tips.Label_tips")
    self.Label_timing = TFDirector:getChildByPath(self.Image_ad, "Label_timing")

    -- self.Image_preview = Utils:previewReward()
    -- self.Image_preview:AddTo(self.Panel_root):setZOrder(1)

    self:refreshView()
end

function RechargeActivityView:updateActivity()
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    local items = ActivityDataMgr2:getItems(self.activityId_)

    local taskIndex = {}
    local totalItems = {}
    local fullItem
    for i, v in ipairs(items) do
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, v)
        if itemInfo.extendData.rechargeMax == 1 then
            fullItem = v
        else
            if next(itemInfo.reward) then
                table.insert(taskIndex, i)
            end
            table.insert(totalItems, v)
        end
    end

    local curStage = 0
    for i, v in ipairs(totalItems) do
        local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, v)
        if progressInfo.status ~= EC_TaskStatus.ING then
            curStage = curStage + 1
        else
            break
        end
    end

    local count = #totalItems
    local bottomSize = self.Panel_bottom_split:getSize()
    local topSize = self.Panel_top_split:getSize()
    local bottomOffsetX = bottomSize.width * self.Panel_bottom_split:AnchorPoint().x
    local topOffsetX = topSize.width * self.Panel_top_split:AnchorPoint().x

    self.topSplitItem_ = {}
    self.Panel_bottom_split:removeAllChildren()
    self.Panel_top_split:removeAllChildren()
    for i = 2, count do
        local stage = i - 1
        local x = bottomSize.width / count * stage - bottomOffsetX
        local y = 0
        local Image_bottomSplitItem = self.Image_bottomSplitItem:clone()
        Image_bottomSplitItem:AddTo(self.Panel_bottom_split):Pos(x, y)
        local x = topSize.width / count * stage - topOffsetX
        local y = 0
        local Image_topSplitItem = self.Image_topSplitItem:clone()
        Image_topSplitItem:AddTo(self.Panel_top_split):Pos(x, y)
        self.topSplitItem_[stage] = Image_topSplitItem
    end

    self.dayItem_ = {}
    for stage = 1, count do
        local x =  topSize.width / count * (stage - 0.5) - topOffsetX
        local y = -30
        local Panel_dayItem = self.Panel_dayItem:clone()
        local foo = {}
        foo.root = Panel_dayItem
        foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select")
        foo.Label_day = TFDirector:getChildByPath(foo.root, "Label_day")
        foo.Label_day_noReach = TFDirector:getChildByPath(foo.root, "Label_day_noReach")
        foo.Label_day:setTextById(1890015, stage)
        foo.Label_day_noReach:setTextById(1890015, stage)
        Panel_dayItem:AddTo(self.Panel_top_split):Pos(x, y)
        self.dayItem_[stage] = foo
    end

    self.rewardItem_ = {}
    for _, stage in ipairs(taskIndex) do
        local itemId = totalItems[stage]
        local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, itemId)
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, itemId)
        local x = topSize.width / count * (stage - 0.5) - topOffsetX
        local y = 10
        local Panel_rewardItem = self.Panel_rewardItem:clone()
        Panel_rewardItem:AddTo(self.Panel_top_split):Pos(x, y)
        local foo = {}
        foo.root = Panel_rewardItem
        foo.Button_geted = TFDirector:getChildByPath(foo.root, "Button_geted")
        foo.Button_receive = TFDirector:getChildByPath(foo.root, "Button_receive")
        foo.Spine_receive = TFDirector:getChildByPath(foo.Button_receive, "Spine_receive")
        foo.Spine_receive:play("animation", true)
        foo.Button_noReach = TFDirector:getChildByPath(foo.root, "Button_noReach")
        foo.Button_noReach:setVisible(progressInfo.status == EC_TaskStatus.ING)
        foo.Button_receive:setVisible(progressInfo.status == EC_TaskStatus.GET)
        foo.Button_geted:setVisible(progressInfo.status ==  EC_TaskStatus.GETED)

        foo.Button_receive:onClick(function()
                ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityInfo_.id, itemId)
        end)
        foo.Button_noReach:onClick(function(sender)
                -- local visible = self.Image_preview:isVisible()
                -- self.Image_preview:setVisible(not visible or self.selectItem_ ~= sender)
                -- if self.Image_preview:isVisible() then
                    self.selectItem_ = sender
                --     self.Image_preview:AnchorPoint(ccp(0, -0.6))
                    self:showRewardPreview(foo.root, itemInfo.reward)
                -- end
        end)
        foo.Button_geted:onClick(function(sender)
                -- local visible = self.Image_preview:isVisible()
                -- self.Image_preview:setVisible(not visible or self.selectItem_ ~= sender)
                -- if self.Image_preview:isVisible() then
                    self.selectItem_ = sender
                --     self.Image_preview:AnchorPoint(ccp(0, -0.6))
                    self:showRewardPreview(foo.root, itemInfo.reward)
                -- end
        end)
        self.rewardItem_[stage] = foo
    end

    local scale = curStage / count
    self.Image_top_progress:ScaleX(scale)

    for stage, v in pairs(self.topSplitItem_) do
        v:setVisible(curStage >= stage)
    end
    for stage, v in pairs(self.dayItem_) do
        v.Image_select:setVisible(curStage == stage)
        v.Label_day:setVisible(curStage >= stage)
        v.Label_day_noReach:setVisible(curStage < stage)
    end

    local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, fullItem)
    local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, fullItem)
    self.Image_no_reach:setVisible(progressInfo.status == EC_TaskStatus.ING)
    self.Button_receive:setVisible(progressInfo.status == EC_TaskStatus.GET)
    self.Image_geted:setVisible(progressInfo.status == EC_TaskStatus.GETED)
    self.Image_tag:setVisible(progressInfo.status ~= EC_TaskStatus.GET)
    self.Spine_receive:setVisible(progressInfo.status == EC_TaskStatus.GET)
    self.Button_receive:onClick(function()
            ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityInfo_.id, fullItem)
    end)
    self.Button_preview_blue:setVisible(progressInfo.status ~= EC_TaskStatus.GET)
    self.Button_preview_pink:setVisible(progressInfo.status == EC_TaskStatus.GET)
    self.Button_preview_blue:onClick(function(sender)
            -- local visible = self.Image_preview:isVisible()
            -- self.Image_preview:setVisible(not visible or self.selectItem_ ~= sender)
            -- if self.Image_preview:isVisible() then
                self.selectItem_ = sender
                -- self.Image_preview:AnchorPoint(ccp(0, -0.3))
                self:showRewardPreview(self.Button_preview_blue, itemInfo.reward)
            -- end
    end)
    self.Button_preview_pink:onClick(function(sender)
            -- local visible = self.Image_preview:isVisible()
            -- self.Image_preview:setVisible(not visible or self.selectItem_ ~= sender)
            -- if self.Image_preview:isVisible() then
                self.selectItem_ = sender
                -- self.Image_preview:AnchorPoint(ccp(0, -0.3))
                self:showRewardPreview(self.Button_preview_pink, itemInfo.reward)
            -- end
    end)

    self.Label_tips:setText(Utils:MultiLanguageStringDeal(self.activityInfo_.activityTitle))
    self:updateCountDonw()
end

function RechargeActivityView:refreshView()
    self.Label_no_reach:setTextById(1890017)
    self.Label_geted:setTextById(1890018)
    self.Label_tag:setTextById(1890016)
    self.Label_receive:setTextById(1890019)
end

function RechargeActivityView:showRewardPreview(item, reward)
    local format_reward = {}
    for k, v in pairs(reward) do
        local item = Utils:makeRewardItem(k, v)
        table.insert(format_reward, item)
    end

    local wp = item:getParent():convertToWorldSpaceAR(item:Pos())
    -- local np = self.Image_preview:getParent():convertToNodeSpaceAR(wp)

    self.Image_preview = Utils:previewReward(self.Image_preview, format_reward, 0.6)
    -- self.Image_preview:Show():Pos(np)
end

function RechargeActivityView:updateCountDonw()

end

function RechargeActivityView:registerEvents()
    self.Panel_root:onClick(function()
            -- self.Image_preview:hide()
    end)
end

function RechargeActivityView:onSubmitSuccessEvent(activitId, itemId, reward)
    Utils:showReward(reward)
    self:updateActivity()
end

function RechargeActivityView:onUpdateProgressEvent()
    self:updateActivity()
end

function RechargeActivityView:onUpdateCountDownEvent()
    self:updateCountDonw()
end

function RechargeActivityView:updateCountDonw()
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

return RechargeActivityView
