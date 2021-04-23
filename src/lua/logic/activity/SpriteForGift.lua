--[[
    @desc：SpriteForGift
    @date: 2021-01-08 14:10:32
]]

local SpriteForGift = class("SpriteForGift",BaseLayer)

function SpriteForGift:initData(activityId)
    self.activityId = activityId
    self.activityInfo = ActivityDataMgr2:getActivityInfo(activityId)
    self.taskItems = self.activityInfo.items
    dump(self.activityInfo)
end

function SpriteForGift:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.spriteForGift")
end

function SpriteForGift:initUI(ui)
    self.super.initUI(self,ui)

    self._ui.img_main:show()
    self._ui.img_1:hide()
    self._ui.img_2:hide()

    local year, month, day = Utils:getDate(self.activityInfo.showStartTime or 0)
	self._ui.act_timeStart:setTextById(1410001,year, month, day)
	year, month, day = Utils:getDate(self.activityInfo.endTime or 0)
    self._ui.act_timeEnd:setTextById(1410001,year, month, day)

    self:updateViewUI()
end

function SpriteForGift:registerEvents()
    local summonId = self.activityInfo.extendData.summon
    for i = 1, 2 do
        self._ui["btn_go"..i]:onClick(function()
            FunctionDataMgr:jSummon(nil, summonId[i])
        end)
    end
    
    self._ui.Button_rule:onClick(function()
        Utils:openView("common.TxtRuleContentShowView", {63881})
    end)
end

function SpriteForGift:updateViewUI()
    local imgMainShow = true
    local statusAll = {}
    for i, id in ipairs(self.taskItems) do
        local status = ActivityDataMgr2:getProgressInfo(EC_ActivityType2.SPRITE_FOR_GIFT, id).status
        dump(status)
        if status ~= EC_TaskStatus.ING then
            imgMainShow = false
        end
        statusAll[i] = status
    end
    if not imgMainShow then
        for idx, status in ipairs(statusAll) do
            local img = self._ui["img_"..idx]
            local btn = img:getChildByName("btn_getReward")
            local img_getted = img:getChildByName("img_getted")
            img:setVisible(status == EC_TaskStatus.ING)
            if img:isVisible() then
                local curStatusIdx = idx == 1 and 2 or 1
                btn:setVisible(statusAll[curStatusIdx] == EC_TaskStatus.GET)
                img_getted:setVisible(statusAll[curStatusIdx] == EC_TaskStatus.GETED)
                btn:onClick(function()
                    ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, self.taskItems[curStatusIdx])
                end)
            end
        end 
    end
    self._ui.img_main:setVisible(imgMainShow)
end

function SpriteForGift:onUpdateProgressEvent()
    self:updateViewUI()
end

function SpriteForGift:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId ~= activitId then return end
    Utils:showReward(reward)
    self:updateViewUI()
end

return SpriteForGift