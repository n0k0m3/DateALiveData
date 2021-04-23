
local CallBackMainView = class("CallBackMainView", BaseLayer)

function CallBackMainView:initData(activityId)
    self.activityId = activityId
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId)
    dump(self.activityInfo_)
    if not self.activityInfo_ then
        return
    end
    self.scoreItemId = self.activityInfo_.extendData.itemId
    self.scoreTask = self.activityInfo_.extendData.task
    self.dressTaskId = self.activityInfo_.extendData.fashion
    self.shareTaskId = self.activityInfo_.extendData.share
end

function CallBackMainView:ctor(data, parentNode)
    dump(data)
    self.super.ctor(self,data)
    self:initData(data)
    self.parentNode = parentNode
    self:init("lua.uiconfig.activity.callbackMainView")
end

function CallBackMainView:initUI(ui)
    self.super.initUI(self, ui)

    if not self.inputLayer then

        local params = {
            _type = EC_InputLayerType.SEND,
            --buttonCallback = function()
            --    self:onTouchSendBtn()
            --end,
            closeCallback = function()
                self:onCloseInputLayer()
            end
        }
        self.inputLayer = require("lua.logic.common.InputLayer"):new(params);
        self.parentNode = self.parentNode or self
        local anchorPos = self.parentNode:getAnchorPoint()
        self.inputLayer:setAnchorPoint(anchorPos)
        self.parentNode:addChild(self.inputLayer,1000);
    end

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_base")
    self.Image_callback_award = TFDirector:getChildByPath(self.ui, "Image_callback_award"):hide()
    self.Button_share = TFDirector:getChildByPath(self.Panel_root, "Button_share")
    self.Button_share_get = TFDirector:getChildByPath(self.Panel_root, "Button_share_get")
    self.Button_share_geted = TFDirector:getChildByPath(self.Panel_root, "Button_share_geted")
    self.Panel_award = TFDirector:getChildByPath(self.Panel_root, "Panel_award")

    self.Panel_call = TFDirector:getChildByPath(self.Panel_root, "Panel_call"):hide()
    self.label_back_num = TFDirector:getChildByPath(self.Panel_call, "label_back_num")
    self.label_invite_uid = TFDirector:getChildByPath(self.Panel_call, "label_invite_uid")
    self.label_task_num = TFDirector:getChildByPath(self.Panel_call, "label_task_num")
    self.label_back_tip = TFDirector:getChildByPath(self.Panel_call, "label_back_tip")
    self.label_back_tip:setTextById(63695)
    self.label_task_tip = TFDirector:getChildByPath(self.Panel_call, "label_task_tip")
    self.label_task_tip:setTextById(63696)


    self.Panel_response = TFDirector:getChildByPath(self.Panel_root, "Panel_response"):hide()
    self.Button_submit = TFDirector:getChildByPath(self.Panel_response, "Button_submit")
    self.TextField_receive = TFDirector:getChildByPath(self.Panel_response, "TextField_receive")
    self.Label_input_tip = TFDirector:getChildByPath(self.Panel_response, "Label_input_tip")

    self.dressCondition_ = {}
    for i=1,4 do
        local mask = TFDirector:getChildByPath(self.Panel_root, "Image_mask"..i)
        local labelCondition = TFDirector:getChildByPath(mask, "Label_condition")
        table.insert(self.dressCondition_,{mask = mask, con = labelCondition})
    end
    self.Button_rule = TFDirector:getChildByPath(self.Panel_root, "Button_rule")
    self.Button_get_dress = TFDirector:getChildByPath(self.Panel_root, "Button_get_dress")
    self.Image_dress_geted = TFDirector:getChildByPath(self.Panel_root, "Image_dress_geted")
    self.label_score = TFDirector:getChildByPath(self.Panel_root, "label_score")
    self.label_time = TFDirector:getChildByPath(self.Panel_root, "label_time")
    self.label_dress_tip = TFDirector:getChildByPath(self.Panel_root, "label_dress_tip")
    self.label_dress_name = TFDirector:getChildByPath(self.Panel_root, "label_dress_name")
    self.label_score_tip = TFDirector:getChildByPath(self.Panel_root, "label_score_tip")
    self.label_score_tip:setTextById(63698)
    dump(self.activityInfo_)

    ActivityDataMgr2:ReqGetBeCallInfo(self.activityId)

    self:refreshView()

end

function CallBackMainView:refreshView()

    if not self.activityInfo_ then
        return
    end

    local _startyear, _startmonth, _startday = Utils:getDate(self.activityInfo_.showStartTime, true)
    local _endyear, _endmonth, _endday = Utils:getDate(self.activityInfo_.showEndTime, true)
    self.label_time:setText(_startmonth .. "." .. _startday .. "-" .. _endmonth .. "." .. _endday)

    self:onUpdateCallBackInfo()
    self:refreshDressTask()
    self:updateScore()
end

function CallBackMainView:refreshDressTask()

    if not self.activityInfo_ then
        return
    end

    local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, self.dressTaskId)
    local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, self.dressTaskId)
    dump(itemInfo)
    self.Button_get_dress:setVisible(progressInfo.status == EC_TaskStatus.GET)
    self.Image_dress_geted:setVisible(progressInfo.status == EC_TaskStatus.GETED)
    local itemId
    for k,v in pairs(itemInfo.reward) do
        itemId = k
        break
    end

    if not itemId then
        return
    end
    local dressItemCfg = GoodsDataMgr:getItemCfg(itemId)
    if dressItemCfg then
        self.label_dress_name:setTextById(dressItemCfg.nameTextId)
    end
end

function CallBackMainView:refreshShareTask()

    if not self.activityInfo_ then
        return
    end

    if not self.callbackData then
        return
    end

    local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, self.shareTaskId)
    local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, self.shareTaskId)
    --self.Button_share:setVisible(progressInfo.status == EC_TaskStatus.ING)
    self.Button_share_get:setVisible(progressInfo.status == EC_TaskStatus.GET)
    self.Button_share_geted:setVisible(progressInfo.status == EC_TaskStatus.GETED)

    local tab = {}
    for k, v in pairs(itemInfo.reward) do
        table.insert(tab,{id = k, num = v})
    end
    table.sort(tab,function(a,b)
        return a.id < b.id
    end)
    for k,v in ipairs(tab) do
        local itemBg = self.Panel_award:getChildByName("itemBg"..k)
        if not itemBg then
            itemBg = self.Image_callback_award:clone()
            itemBg:show()
            local itemContentSize = itemBg:getContentSize()
            local posX = -itemContentSize.width / 2 -  (k-1)*(itemContentSize.width + 5)
            itemBg:setPosition(ccp(posX, itemContentSize.height / 2))
            itemBg:setName("itemBg"..k)
            self.Panel_award:addChild(itemBg)
        end
        local Image_item = itemBg:getChildByName("Image_item")
        local Panel_goodsItem = Image_item:getChildByName("Panel_goodsItem")
        if not Panel_goodsItem then
            Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            Panel_goodsItem:setName("Panel_goodsItem")
            --Panel_goodsItem:setAnchorPoint(ccp(0.5,1))
            Panel_goodsItem:setPosition(ccp(0,0))
            Panel_goodsItem:setScale(0.8)
            Image_item:addChild(Panel_goodsItem)
        end
        PrefabDataMgr:setInfo(Panel_goodsItem, v.id, v.num)


        local effect = itemBg:getChildByName("Spine_effect")
        if effect then
            effect:play("animation",true)
            effect:setVisible(progressInfo.status == EC_TaskStatus.GET)
        end

        Panel_goodsItem:setTouchEnabled(false)
        itemBg:setTouchEnabled(true)
        itemBg:onClick(function()
            if progressInfo.status ~= EC_TaskStatus.GET then
                Utils:showInfo(v.id)
            else
                ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, self.shareTaskId)
            end
        end)
    end

    self.label_invite_uid:setText("UID:"..self.callbackData.codeInfo)
    self.label_back_num:setText(self.callbackData.beCallNum)
    self.label_task_num:setText(self.callbackData.taskSize)

end

function CallBackMainView:onUpdateCallBackInfo()
    self.callbackData = ActivityDataMgr2:getCallBackInfo()
    if not self.callbackData then
        return
    end

    local isReturnPerson = self.callbackData.isReturn
    dump(self.callbackData)
    if isReturnPerson then
        self:responseView()
    else
        self:callPersonView()
    end
    self:refreshShareTask()
end

function CallBackMainView:callPersonView()
    self.Panel_call:setVisible(true)
end

function CallBackMainView:responseView(update)
    self.Panel_response:setVisible(true)
    local isBind = self.callbackData.isBind
    local strId = isBind and 63681 or 63680
    self.Label_input_tip:setTextById(strId)
    self.Button_submit:setGrayEnabled(isBind)
    self.Button_submit:setTouchEnabled(not isBind)
    self.TextField_receive:setTouchEnabled(not isBind)
    if update then
        self.Label_input_tip:setVisible(true)
        self.TextField_receive:setVisible(false)
    end

end

function CallBackMainView:onUpdateTask()
    self:refreshDressTask()
    self:refreshShareTask()
end

function CallBackMainView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId ~= activitId then
        return
    end
    Utils:showReward(reward)
    self:refreshDressTask()
    self:refreshShareTask()
end

function CallBackMainView:updateScore()
    local num = GoodsDataMgr:getItemCount(self.scoreItemId)
    self.label_score:setText(num)
    for i=1,4 do
        local conditionScore = self.scoreTask[i]
        if conditionScore then
            self.dressCondition_[i].mask:setVisible(num < conditionScore)
            self.dressCondition_[i].con:setTextById(63682,conditionScore)
        else
            self.dressCondition_[i].mask:setVisible(false)
        end
    end
end

function CallBackMainView:onCloseInputLayer()
    if not self.inputStr or self.inputStr == "" then
        self.Label_input_tip:show()
    end
end

function CallBackMainView:registerEvents()

    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.updateScore, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_CALL_BACK_INFO, handler(self.onUpdateCallBackInfo, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onUpdateTask, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_CALL_BACK_BIND, handler(self.responseView, self))

    local function onTextFieldChangedHandleAcc(input)
        self.inputStr = input:getText()
        self.inputLayer:listener(input:getText());
    end

    local function onTextFieldAttachAcc(input)
        self.inputTextField = input
        self.inputLayer:show();
        self.inputStr = input:getText()
        self.inputLayer:listener(input:getText());
        self.Label_input_tip:hide()
    end

    self.TextField_receive:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleAcc)
    self.TextField_receive:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
    self.TextField_receive:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)

    local shareClick = false
    self.Button_share:onClick(function()
        if not shareClick then
            self:timeOut(function()
                Utils:openView("activity.CallBackShareView",self.activityId)
                shareClick = false
            end, 0.2)
        end
    end)

    self.Button_share_get:onClick(function()
        ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, self.shareTaskId)
    end)

    self.Button_submit:onClick(function()
        if not self.inputStr or self.inputStr == "" then
            return
        end
        ActivityDataMgr2:ReqWriteBeCallPlayerId(self.activityId,self.inputStr)
    end)

    self.Button_get_dress:onClick(function()
        ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, self.dressTaskId)
    end)

    self.Button_rule:onClick(function()
        Utils:openView("common.NormalHelpView",63684,63683)
    end)
end

return CallBackMainView
