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
* 祈愿活动界面
* 
]]

local PrayView = class("PrayView", BaseLayer)

function PrayView:ctor(data)
    self.super.ctor(self,data)
    self:initData(data)
    self:init("lua.uiconfig.activity.PrayView")
end

function PrayView:initData(activityId)
    self.activityId = activityId
    self:updateData()
end

function PrayView:initUI(ui)
    self.super.initUI(self, ui)

    self.img_bg = TFDirector:getChildByPath(ui, "img_bg")
    self.btn_help = TFDirector:getChildByPath(ui, "btn_help")
    self.btn_share = TFDirector:getChildByPath(ui, "btn_share")
    self.btn_share:setTouchEnabled(true)
    self.img_bubble = TFDirector:getChildByPath(self.btn_share, "img_bubble")
    self.img_icon = TFDirector:getChildByPath(self.btn_share, "img_icon")
    self.txt_share_num = TFDirector:getChildByPath(self.btn_share, "txt_share_num")
    self.txt_get = TFDirector:getChildByPath(self.btn_share, "txt_get")

    self.btn_pray = TFDirector:getChildByPath(ui, "btn_pray"):show()
    self.img_finish = TFDirector:getChildByPath(ui, "img_finish"):hide()
    self.finsh_label = TFDirector:getChildByPath(self.img_finish, "btn_label")
    self.finsh_label:setTextById(270608)

    self.img_top = TFDirector:getChildByPath(ui, "img_top"):hide()

    self.panel_pray = TFDirector:getChildByPath(ui, "panel_pray"):hide()
    self.img_tip = TFDirector:getChildByPath(self.panel_pray, "img_tip")
    self.btn_close = TFDirector:getChildByPath(self.panel_pray, "btn_close")
    self.panel_task = TFDirector:getChildByPath(ui, "panel_task"):hide()

    self.txt_pray_num = TFDirector:getChildByPath(ui, "txt_pray_num")
    self.txt_time = TFDirector:getChildByPath(ui, "txt_time")

    self.img_top = TFDirector:getChildByPath(ui, "img_top"):hide()
    self.btn_box = TFDirector:getChildByPath(self.img_top, "btn_box")
    self.spine_get = TFDirector:getChildByPath(self.img_top, "spine_get"):hide()
    self.spine_get:play("animation", true)
    self.txt_top_pro = TFDirector:getChildByPath(self.img_top, "txt_pro")
    self.img_top_icon = TFDirector:getChildByPath(self.img_top, "img_icon")
    self.txt_top_num = TFDirector:getChildByPath(self.img_top, "txt_num")
    self.txt_top_get = TFDirector:getChildByPath(self.img_top, "txt_get")

    self.prayList = {}
    for i = 1, 3 do
        local prayNode = TFDirector:getChildByPath(self.panel_pray, "img_item" .. i)
        prayNode.initPos = prayNode:getPosition()
        prayNode.txt_name = TFDirector:getChildByPath(prayNode, "txt_name")
        prayNode.img_icon = TFDirector:getChildByPath(prayNode, "img_icon")
        prayNode.txt_num = TFDirector:getChildByPath(prayNode, "txt_num")
        prayNode.txt_desc = TFDirector:getChildByPath(prayNode, "txt_desc")
        prayNode.btn_choose = TFDirector:getChildByPath(prayNode, "btn_choose")
        prayNode.txt_get = TFDirector:getChildByPath(prayNode, "txt_get")
        self.prayList[i] = prayNode
    end

    self.taskList = {}
    for i = 1, 3 do
        local taskNode = TFDirector:getChildByPath(self.panel_task, "img_item" .. i)
        taskNode.txt_name = TFDirector:getChildByPath(taskNode, "txt_name")
        taskNode.txt_desc = TFDirector:getChildByPath(taskNode, "txt_desc")
        taskNode.btn_get = TFDirector:getChildByPath(taskNode, "btn_get")
        taskNode.btn_go = TFDirector:getChildByPath(taskNode, "btn_go")
        taskNode.txt_get = TFDirector:getChildByPath(taskNode, "txt_get")
        taskNode.items = {}
        for j = 1, 2 do
            local itemNode = TFDirector:getChildByPath(taskNode, "panel_item" .. j):hide()
            itemNode.img_icon = TFDirector:getChildByPath(itemNode, "img_icon")
            itemNode.txt_num = TFDirector:getChildByPath(itemNode, "txt_num")
            taskNode.items[j] = itemNode
        end
        self.taskList[i] = taskNode
    end

    self:updateUI()
end

function PrayView:updateData()
    self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
end

function PrayView:updateUI()
    if not self.activityInfo then
        return
    end

    local extendData = self.activityInfo.extendData
    if extendData.dateRstring then
        local dateStyle = extendData.dateStyle
        local startDateStr = Utils:getDateString(self.activityInfo.startTime, dateStyle)
        local endDateStr = Utils:getDateString(self.activityInfo.endTime, dateStyle)
        self.txt_time:setTextById(extendData.dateRstring, startDateStr, endDateStr)
    else
        self.txt_time:setText(Utils:getActivityDateString(self.activityInfo.startTime, self.activityInfo.endTime, extendData.dateStyle))
    end

    local prayTimes = extendData.prayTimes or 1
    local times = extendData.times or 0
    self.txt_pray_num:setTextById(270606, (prayTimes - times), prayTimes)
    self.txt_pray_num:show()
    if prayTimes == 1 then
        self.txt_pray_num:hide()
    end

    local prayStep = extendData.prayStep or 1
    if prayStep == 1 then
        --需要许愿
        self.btn_pray:show()
        self.img_finish:hide()
        self.img_top:hide()
        self.panel_task:hide()
        self:updatePrayList()
    elseif prayStep == 2 then
        --许愿任务中
        self.btn_pray:hide()
        self.img_finish:hide()
        self.img_top:show()
        self.panel_pray:hide()
        self.panel_task:show()
        self:updateScore()
        self:updateTaskList()
    else
        --所有许愿完成
        self.btn_pray:hide()
        self.img_finish:show()
        self.img_top:show()
        self.panel_pray:hide()
        self.panel_task:hide()
        self:updateScore()
    end

    self:updateShareBtn()
end

function PrayView:updateScore()
    if not self.activityInfo then
        return
    end

    local extendData = self.activityInfo.extendData
    local prayId = extendData.prayId
    local scoreItemId = extendData.itemId
    self.img_top:hide()
    if prayId and prayId ~= 0 then
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, prayId)
        local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, prayId)
        local curNum = GoodsDataMgr:getItemCount(scoreItemId)
        local itemCfg = GoodsDataMgr:getItemCfg(scoreItemId)
        local target = itemInfo.target or 100
        if target == 0 then
            target = 100
        end
        local progress = math.floor(progressInfo.progress*100/target)
        if progress > 100 then progress = 100 end
        self.img_top:show()
        self.txt_top_pro:setTextById(800017, progress)
        self.txt_top_num:setTextById(800005, curNum, itemInfo.target)
        self.img_top_icon:setTexture(itemCfg.icon)
        self.img_top_icon:setTouchEnabled(true)
        self.img_top_icon:onClick(function()
            Utils:showInfo(scoreItemId)
        end)

        self.txt_top_pro:setVisible(progressInfo.status ~= EC_TaskStatus.GETED)
        self.txt_top_get:setVisible(progressInfo.status == EC_TaskStatus.GETED)
        self.btn_box:setTouchEnabled(progressInfo.status ~= EC_TaskStatus.GETED)
        self.spine_get:setVisible(progressInfo.status == EC_TaskStatus.GET)

        if progressInfo.status == EC_TaskStatus.ING then
            self.btn_box:setTextureNormal("ui/activity/pray/box_1.png")
        elseif progressInfo.status == EC_TaskStatus.GET then
            self.btn_box:setTextureNormal("ui/activity/pray/box_2.png")
        else
            self.btn_box:setTextureNormal("ui/activity/pray/box_3.png")
        end
    end
end

function PrayView:updateShareBtn()
    local prayFixed = self.activityInfo.extendData.prayFixed
    self.btn_share:hide()
    if prayFixed and prayFixed[1] then
        local shareItem = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, prayFixed[1])
        if not shareItem then
            return
        end
        local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, prayFixed[1])
        local itemId = nil
        local itemNum = 0
        for k, v in pairs(shareItem.reward or {}) do
            itemId = k
            itemNum = v
            break
        end
        self.img_bubble:hide()
        if itemId then
            self.img_bubble:show()
            self:updateOneItem(self.img_icon, self.txt_share_num, itemId, itemNum)
            self.img_icon:setTouchEnabled(false)
            self.txt_get:setVisible(progressInfo.status == EC_TaskStatus.GET)
            self.img_bubble:setVisible(progressInfo.status ~= EC_TaskStatus.GETED)
            self.img_bubble:setTouchEnabled(true)
            self.img_bubble.itemId = itemId
        end
        self.btn_share:show()
    end
end

function PrayView:updatePrayList()
    local prayList = self.activityInfo.extendData.prayList
    for i = 1, 3 do
        local prayNode = self.prayList[i]
        prayNode:hide()
        if prayList[i] then
            local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, prayList[i])
            local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, prayList[i])
            if not itemInfo then
                Box("许愿条目找不到" .. tostring(prayList[i]))
                break
            end
            prayNode:show()
            prayNode.txt_name:setText(itemInfo.details)
            prayNode.txt_desc:setText(itemInfo.extendData.des2)
            prayNode.btn_choose:setVisible(progressInfo.status ~= EC_TaskStatus.GETED)
            prayNode.txt_get:setVisible(progressInfo.status == EC_TaskStatus.GETED)

            local itemId = nil
            local itemNum = 0
            for k, v in pairs(itemInfo.reward or {}) do
                itemId = k
                itemNum = v
                break
            end
            self:updateOneItem(prayNode.img_icon, prayNode.txt_num, itemId, itemNum)
            prayNode.btn_choose.itemId = prayList[i]
        end
    end
end

function PrayView:updateTaskList()
    local allItems = self.activityInfo.items
    local prayList = self.activityInfo.extendData.prayList or {}
    local prayFixed = self.activityInfo.extendData.prayFixed or {}
    local taskList = {}
    for k, v in ipairs(allItems or {}) do
        if table.indexOf(prayList, v) == -1 and table.indexOf(prayFixed, v) == -1 then
            table.insert(taskList, v)
        end
    end

    for i = 1, 3 do
        local taskNode = self.taskList[i]
        taskNode:hide()
        if taskList[i] then
            local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, taskList[i])
            local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, taskList[i])
            if not itemInfo then
                Box("许愿中任务条目找不到" .. tostring(taskList[i]))
                break
            end
            taskNode:show()
            taskNode.txt_name:setText(itemInfo.details)
            local desc = itemInfo.extendData.des2
            local progress = progressInfo.progress
            if progress >= itemInfo.target then
                progress = itemInfo.target
            end
            desc = desc .. TextDataMgr:getText(270609, progress, itemInfo.target)
            taskNode.txt_desc:setText(desc)
            taskNode.btn_get:setVisible(progressInfo.status == EC_TaskStatus.GET)
            taskNode.txt_get:setVisible(progressInfo.status == EC_TaskStatus.GETED)
            taskNode.btn_go:setVisible(progressInfo.status == EC_TaskStatus.ING)
            taskNode.btn_go:setGrayEnabled(not itemInfo.extendData.jumpInterface)
            taskNode.btn_go:setTouchEnabled(itemInfo.extendData.jumpInterface)

            local curIndex = 1
            for k, v in pairs(itemInfo.reward or {}) do
                if curIndex <= 2 then
                    local itemNode = taskNode.items[curIndex]
                    if progressInfo.status == EC_TaskStatus.GETED then
                        itemNode:hide()
                    else
                        itemNode:show()
                        self:updateOneItem(itemNode.img_icon, itemNode.txt_num, k, v)
                    end 
                end
                curIndex = curIndex + 1
            end

            taskNode.itemInfo = itemInfo
            taskNode.progressInfo = progressInfo
            taskNode.btn_get.itemInfo = itemInfo
            taskNode.btn_go.itemInfo = itemInfo
        end
    end
end

function PrayView:updateOneItem(img_icon, txt_num, itemId, itemNum)
    if not itemId then return end

    local itemCfg = GoodsDataMgr:getItemCfg(itemId)
    img_icon:setTexture(itemCfg.icon)
    txt_num:setText("x" .. itemNum)
    img_icon:setTouchEnabled(true)
    img_icon:onClick(function()
        Utils:showInfo(itemId)
    end)
end

function PrayView:onHelpBtnHandle()
	Utils:openView("common.HelpView", {3108})
end

function PrayView:onShareBtnHandle()
    Utils:openView("activity.PrayShareView", self.activityId)
end

function PrayView:onPrayBtnHandle()
    self:showPrayAnim()
end

function PrayView:showPrayAnim()
    self.panel_pray:show()
    self.btn_pray:hide()
    self.img_tip:hide()
    self.btn_close:hide()
    local showFunc = function()
        self.img_tip:show()
        self.btn_close:show()
    end
    for i = 1, 3 do
        local prayNode = self.prayList[i]
        prayNode:setScale(0)
        prayNode:setPosition(ccp(0, 0))
        if i == 3 then
            ViewAnimationHelper.doScaleAndMoveAction(prayNode, 1, prayNode.initPos, nil, showFunc)
        else
            ViewAnimationHelper.doScaleAndMoveAction(prayNode, 1, prayNode.initPos)
        end
    end
end

function PrayView:hidePrayAnim()
    self.btn_pray:show()
    self.img_tip:hide()
    self.btn_close:hide()
    local showFunc = function()
        self.panel_pray:hide()
    end
    for i = 1, 3 do
        local prayNode = self.prayList[i]
        prayNode:setScale(1)
        prayNode:setPosition(prayNode.initPos)
        if i == 3 then
            ViewAnimationHelper.doScaleAndMoveAction(prayNode, 0, ccp(0, 0), nil, showFunc)
        else
            ViewAnimationHelper.doScaleAndMoveAction(prayNode, 0, ccp(0, 0))
        end
    end
end

function PrayView:onClosePrayHandle()
	self:hidePrayAnim()
end

function PrayView:onChooseBtnHandle(sender)
    if not sender.itemId then return end
    ActivityDataMgr2:sendReqActivityPrayTask(self.activityId, sender.itemId)
end

function PrayView:onGoBtnHandle(sender)
    local itemInfo = sender.itemInfo
    if not itemInfo then return end
    local param = itemInfo.extendData.parameter or {}
    FunctionDataMgr:enterByFuncId(itemInfo.extendData.jumpInterface, unpack(param))
end

function PrayView:onGetBtnHandle(sender)
    local itemInfo = sender.itemInfo
    if not itemInfo then return end
    ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, itemInfo.id)
end

function PrayView:onBoxBtnHandle(sender)
    if not self.activityInfo then
        return
    end

    local extendData = self.activityInfo.extendData
    local prayId = extendData.prayId
    if prayId and prayId ~= 0 then
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, prayId)
        local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, prayId)
        if progressInfo.status == EC_TaskStatus.ING then
            local showReward = {}
            for i, v in pairs(itemInfo.reward) do
                table.insert(showReward, {i, v})
            end
            Utils:previewReward(nil, showReward)
        elseif progressInfo.status == EC_TaskStatus.GET then
            local submitFunc = function()
                ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, itemInfo.id)
            end
            if self:checkTaskAllGot() then
                submitFunc()
            else
                local content = TextDataMgr:getText(270607)
                Utils:openView("common.ReConfirmTipsView", {tittle = 1702395, content = content, reType = false, confirmCall = submitFunc, showCancle = true})
            end
        end
    end
end

function PrayView:checkTaskAllGot()
    for i = 1, 3 do
        local progressInfo = self.taskList[i].progressInfo
        if not progressInfo or progressInfo.status ~= EC_TaskStatus.GETED then
            return false
        end
    end
    return true
end

function PrayView:onBubbleHandle(sender)
    local prayFixed = self.activityInfo.extendData.prayFixed
    if prayFixed and prayFixed[1] then
        local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, prayFixed[1])
        if progressInfo.status == EC_TaskStatus.GET then
            ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, prayFixed[1])
        else
            if sender.itemId then
                Utils:showInfo(sender.itemId)
            end
        end
    end
end

function PrayView:updateUIByData()
    self:updateData()
    self:updateUI()
end

function PrayView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId ~= activitId then return end
    Utils:showReward(reward)
end

function PrayView:registerEvents()
	self.btn_help:onClick(handler(self.onHelpBtnHandle, self))
	self.btn_share:onClick(handler(self.onShareBtnHandle, self))
	self.btn_pray:onClick(handler(self.onPrayBtnHandle, self))
	self.btn_close:onClick(handler(self.onClosePrayHandle, self))
    self.btn_box:onClick(handler(self.onBoxBtnHandle, self))
    self.img_bubble:onClick(handler(self.onBubbleHandle, self))

    for i = 1, 3 do
        self.prayList[i].btn_choose:onClick(handler(self.onChooseBtnHandle, self))
        self.taskList[i].btn_go:onClick(handler(self.onGoBtnHandle, self))
        self.taskList[i].btn_get:onClick(handler(self.onGetBtnHandle, self))
    end

    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.updateScore, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.updateUIByData, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.updateUIByData, self))
end

return PrayView
