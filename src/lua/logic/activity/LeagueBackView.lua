--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
*  社团召回活动
* 
]]

local LeagueBackView = class("LeagueBackView", BaseLayer)

function LeagueBackView:ctor(data, parentNode)
    self.super.ctor(self,data)
    self:initData(data)
    self.parentNode = parentNode
    self:init("lua.uiconfig.activity.LeagueBackView")
end

function LeagueBackView:initData(activityId)
    self.activityId = activityId
    self:updateData()
end

function LeagueBackView:initUI(ui)
    self.super.initUI(self, ui)

    self.time_time = TFDirector:getChildByPath(ui, "time_time")
    self.time_time_end = TFDirector:getChildByPath(ui, "time_time_end")
    self.txt_desc = TFDirector:getChildByPath(ui, "txt_desc")
    self.btn_help = TFDirector:getChildByPath(ui, "btn_help")

    self.panel_input = TFDirector:getChildByPath(ui, "panel_input")
    self.textfield_input = TFDirector:getChildByPath(ui, "textfield_input")
    self.label_input = TFDirector:getChildByPath(ui, "label_input")
    self.img_state = TFDirector:getChildByPath(ui, "img_state"):hide()
    self.btn_commit = TFDirector:getChildByPath(ui, "btn_commit")

    self.panel_reward = TFDirector:getChildByPath(ui, "panel_reward")
    self.panel_get = TFDirector:getChildByPath(self.panel_reward, "panel_get"):hide()
    self.panel_get:setTouchEnabled(true)
    self.rewardList = {}
    for i = 1, 4 do
    	local item = TFDirector:getChildByPath(self.panel_reward, "panel_item" .. i)
        item.img_get = TFDirector:getChildByPath(item, "img_get"):hide()
        item.img_got = TFDirector:getChildByPath(item, "img_got"):hide()
    	item.Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        item.Panel_goodsItem:Scale(1)
        item.Panel_goodsItem:Pos(0, 0):AddTo(item)
        self.rewardList[i] = item
    end

    local params = {
        _type = EC_InputLayerType.SEND,
        closeCallback = function()
            self:onCloseInputLayer()
        end
    }
    self.inputLayer = require("lua.logic.common.InputLayer"):new(params)
    self.parentNode = self.parentNode or self
    local anchorPos = self.parentNode:getAnchorPoint()
    self.inputLayer:setAnchorPoint(anchorPos)
    self.parentNode:addChild(self.inputLayer, 1000)

    self:updateUI()
end

function LeagueBackView:onCloseInputLayer()
    if not self.inputStr or self.inputStr == "" then
        self.label_input:show()
    end
end

function LeagueBackView:updateData()
    self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
end

function LeagueBackView:updateUI()
    if not self.activityInfo then
        return
    end

    local startStr =  Utils:getDateString(self.activityInfo.startTime)
    local endStr =  Utils:getDateString(self.activityInfo.endTime)
    self.time_time:setText(startStr)
    self.time_time_end:setText(endStr)

    local score = self.activityInfo.extendData.score or 0
    self.txt_desc:setTextById(63809, score)

    local items = ActivityDataMgr2:getItems(self.activityId)
    if items[1] then
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, items[1])
        local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, items[1])
    	local rewardInfo = itemInfo.reward or {}
    	local id, num = next(rewardInfo)
    	for i = 1, 4 do
    		local item = self.rewardList[i]:hide()
    		if i <= table.count(itemInfo.reward) then
    			item:show()
    			PrefabDataMgr:setInfo(item.Panel_goodsItem, id, num)
        		id, num = next(rewardInfo, id)
                item.img_get:setVisible(progressInfo.status == EC_TaskStatus.GET)
                item.img_got:setVisible(progressInfo.status == EC_TaskStatus.GETED)
    		end
    	end
        self.panel_get:setVisible(progressInfo.status == EC_TaskStatus.GET)
    end

    self.label_input:show()
    self.textfield_input:show()
    if self.activityInfo.extendData.writeUnionId then
    	self.label_input:setText(self.activityInfo.extendData.writeUnionId)
    	self.textfield_input:setTouchEnabled(false)
        self.textfield_input:hide()
    	self.img_state:show()
    	self.btn_commit:hide()
   	else
   		self.label_input:setTextById(63810)
   		self.textfield_input:setTouchEnabled(true)
   		self.img_state:hide()
    	self.btn_commit:show()
   	end
end

function LeagueBackView:updateUIByData()
    self:updateData()
    self:updateUI()
end

function LeagueBackView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId ~= activitId then return end
    Utils:showReward(reward)
end

function LeagueBackView:registerEvents()
    self.btn_help:onClick(function()
        Utils:openView("common.TxtRuleContentShowView", {63811})
    end)

    self.btn_commit:onClick(function()
        if not self.inputStr or self.inputStr == "" then
            return
        end
        local unionId = tonumber(self.inputStr)
        if unionId then
            LeagueDataMgr:sendReqWirteUnionReCall(unionId)
        else
            Utils:showTips(63813)
        end
    end)

    self.panel_get:onClick(function()
        local items = ActivityDataMgr2:getItems(self.activityId)
        if not items[1] then return end

        local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, items[1])
        if progressInfo.status == EC_TaskStatus.GET then
            ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, items[1])
        end
    end)

    local function onTextFieldChangedHandleAcc(input)
        self.inputStr = input:getText()
        self.inputLayer:listener(input:getText())
    end

    local function onTextFieldAttachAcc(input)
        self.inputLayer:show()
        self.inputStr = input:getText()
        self.inputLayer:listener(input:getText())
        self.label_input:hide()
    end

    self.textfield_input:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleAcc)
    self.textfield_input:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
    self.textfield_input:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)

    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.updateUIByData, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.updateUIByData, self))
end

return LeagueBackView
