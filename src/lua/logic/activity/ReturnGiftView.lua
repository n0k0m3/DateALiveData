--[[
    @desc：ReturnGiftView           
    @date: 2021-03-31 15:01:24
]]

local ReturnGiftView = class("ReturnGiftView",BaseLayer)
-- 全服领取奖励默认间隔像素
local DisAwardsPixel = 80
-- 奖励展示坐标位置
local posList = {}
posList[1] = {{0, 0, 1.0}}
posList[2] = {{-50, 0, 0.85}, {50, 0, 0.85}}
posList[3] = {{-50, 50, 0.85}, {50, 50, 0.85}, {0, -50, 0.85}}
posList[4] = {{-50, 50, 0.85}, {50, 50, 0.85}, {-50, -50, 0.85}, {50, -50, 0.85}}

function ReturnGiftView:initData(activityId)
    self.activityId = activityId
    self.activityInfo = ActivityDataMgr2:getActivityInfo(activityId)
    dump(self.activityId)
    dump(self.activityInfo)

    self.expendDataDic = self.activityInfo.extendData.extName
    self.expendData = {}
    for key, value in pairs(self.expendDataDic) do
        table.insert(self.expendData, tonumber(key))
    end
    table.sort(self.expendData, function(a, b)
        return a < b
    end)

    self.listNeedRefreshItems = {}
    self.isFirshIn = true
end

function ReturnGiftView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.returnGiftView")
end

function ReturnGiftView:initUI(ui)
    self.super.initUI(self,ui)

    local year1, month1, day1 = Utils:getDate(self.activityInfo.showStartTime or 0)
    local year2, month2, day2 = Utils:getDate(self.activityInfo.endTime or 0)
    self._ui.act_time:setTextById(63917, year1, month1, day1, year2, month2, day2)

    self.listView = UIListView:create(self._ui.listView)
    self.listView:setItemsMargin(10)
    ActivityDataMgr2:SEND_ACTIVITY2_REQ_GET_ASSEMBLY_INFO()
end

function ReturnGiftView:registerEvents()
    EventMgr:addEventListener(self, EV_RETURN_GIFT_DATA, handler(self.refreshRequestPersonNum, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self,EV_RECHARGE_UPDATE,handler(self.updateGifts, self))

    self._ui.btn_rule:onClick(function()
        Utils:openView("common.HelpView", {4109})
    end)

    if not self.timer then
        self.timer = TFDirector:addTimer(10000, -1, nil, function()
            ActivityDataMgr2:SEND_ACTIVITY2_REQ_GET_ASSEMBLY_INFO()
        end)
    end
end

function ReturnGiftView:initListView()
    self.listView:removeAllItems()
    for i = 1,  #self.expendData do
        local itemKeyId = self.expendData[i]
        local item = self._ui.panel_item:clone()
        local foo = {}
        foo.progressItems = {}
        foo.awards = {}
        foo.root = item
        foo.Label_name = item:getChildByName("Label_name")
        foo.lab_sumCurGettedNum = item:getChildByName("lab_sumCurGettedNum")
        foo.lab_sumCurGettedNum:hide()
        foo.panel_gifts = item:getChildByName("panel_gifts")
        foo.btn_buy = item:getChildByName("btn_buy")
        foo.Image_icon = item:getChildByName("Image_icon")
        foo.Label_count = item:getChildByName("Label_count")
        foo.btn_getReward = item:getChildByName("btn_getReward")
        foo.img_hadGetted = item:getChildByName("img_hadGetted")
        foo.lab_hadGetted = foo.img_hadGetted:getChildByName("lab_hadGetted")

        local scrollView = item:getChildByName("scrollView")
        local scrollViewPanel = self._ui.scrollViewPanel:clone()
        scrollViewPanel:setPosition(ccp(0, 0))
        local img_progressBg = scrollViewPanel:getChildByName("img_progressBg")
        local bar_progress = scrollViewPanel:getChildByName("bar_progress")
        foo.bar_progress = bar_progress
        local progressBgDisLX = img_progressBg:getPositionX()
        local progressBgDisRX = self._ui.panel_progressItem:getContentSize().width / 2

        local progressItemNum = table.count(self.expendDataDic[tostring(itemKeyId)])
        local scrollViewSize = scrollView:getContentSize()
        local _width = progressItemNum * DisAwardsPixel + progressBgDisLX * 2
        _width = _width <= scrollViewSize.width and scrollViewSize.width or _width
        scrollViewPanel:setSize(ccs(_width - 5, scrollViewPanel:getContentSize().height))
        scrollView:setInnerContainerSize(scrollViewPanel:getContentSize())
        img_progressBg:setSize(ccs(_width - progressBgDisLX - progressBgDisRX, img_progressBg:getContentSize().height))
        bar_progress:setSize(ccs(_width - progressBgDisLX - progressBgDisRX, bar_progress:getContentSize().height))
        bar_progress:setPositionX(img_progressBg:getContentSize().width / 2 + 1)

        local _, maxTargetNum = self:getCurAndMaxNum(itemKeyId)
        for j = 1, progressItemNum do
            foo.progressItems[j] = {}
            local progressItem = self._ui.panel_progressItem:clone()
            foo.progressItems[j].root = progressItem
            foo.progressItems[j].img_getted = progressItem:getChildByName("img_getted")
            foo.progressItems[j].img_canGet = progressItem:getChildByName("img_canGet")
            foo.progressItems[j].img_ing = progressItem:getChildByName("img_ing")
            foo.progressItems[j].lab_needNum = progressItem:getChildByName("lab_needNum")
            scrollViewPanel:addChild(progressItem)
             -- 默认等宽度显示
            local _x = j * DisAwardsPixel + progressBgDisLX
            local _y = img_progressBg:getPositionY()

            local _itemId = self.expendDataDic[tostring(itemKeyId)][j]
            local _itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, _itemId)
            if _itemInfo.target then
                _x = (_itemInfo.target/maxTargetNum) * img_progressBg:getContentSize().width
            end
            progressItem:setPosition(ccp(_x, _y))
        end

        scrollView:removeAllChildren()
        scrollView:addChild(scrollViewPanel)
        self.listNeedRefreshItems[i] = foo
        self.listView:pushBackCustomItem(item)
    end
end

function ReturnGiftView:getCurAndMaxNum(itemKeyId)
    local curPersonNum = self.assemblysNumDic[itemKeyId]
    local maxTargetNum = 0
    for i, _itemId in ipairs(self.expendDataDic[tostring(itemKeyId)]) do
        local _itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, _itemId)
        if _itemInfo.target then
            maxTargetNum = math.max(maxTargetNum, tonumber(_itemInfo.target))
        end
    end
    return curPersonNum, maxTargetNum
end

function ReturnGiftView:refreshListView()
    self:updateGifts()
    self:updateProgressItems()
end

function ReturnGiftView:updateGifts()
    for i, item in ipairs(self.listNeedRefreshItems) do
        local itemId = self.expendData[i]
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, itemId)
        local assemblyGiftId = itemInfo.extendData.assemblyGift
        local isTaskItem = assemblyGiftId == nil
        local status = nil
        local rechargeCfg = nil
        local isHadBought = false
        if isTaskItem then
            status = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, itemId).status
            item.lab_hadGetted:setTextById(700033)
        else
            item.lab_hadGetted:setTextById(277003)
            rechargeCfg = RechargeDataMgr:getOneRechargeCfg(assemblyGiftId)
            local costCfg = GoodsDataMgr:getItemCfg(rechargeCfg.exchangeCost[1].id)
            item.Label_count:setText(rechargeCfg.exchangeCost[1].num)
            item.Image_icon:setTexture(costCfg.icon)
            isHadBought = rechargeCfg.buyCount ~= 0 and (rechargeCfg.buyCount - RechargeDataMgr:getBuyCount(assemblyGiftId)) <= 0
        end
        local isTaskGetted = isTaskItem and status and status == EC_TaskStatus.GETED
        item.Label_name:setText(itemInfo.details)
        item.btn_buy:setVisible(not isTaskItem and not isHadBought)
        item.btn_getReward:setVisible(isTaskItem and status and status == EC_TaskStatus.GET)
        item.img_hadGetted:setVisible(isTaskGetted or isHadBought)
        item.btn_getReward:onClick(function()
            ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, itemId)
        end)

        item.btn_buy:onClick(function()
            if rechargeCfg then
                RechargeDataMgr:getOrderNO(assemblyGiftId)
            end
        end)
        
        local awardDatas = {}
        if isTaskItem then
            for _id, _num in pairs(itemInfo.reward) do
                table.insert(awardDatas, {id = _id, num = _num})
            end
        else
            awardDatas = rechargeCfg.item
        end
        for j = 1, 4 do
            local awardData = awardDatas[j]
            local awardNum = #awardDatas > 4 and 4 or #awardDatas
            local awardGoods = item.awards[j]
            if awardData then
                local posData = posList[awardNum][j]
                if not awardGoods then
                    item.awards[j] = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
                    item.awards[j]:Scale(posData[3])
                    item.awards[j]:Pos(posData[1], posData[2]):AddTo(item.panel_gifts)
                end
                PrefabDataMgr:setInfo(item.awards[j], awardData.id, awardData.num)
                item.awards[j]:show()
            else
                if awardGoods then
                    awardGoods:hide()
                end
            end
        end 
    end
end

function ReturnGiftView:updateProgressItems()
    for i, item in ipairs(self.listNeedRefreshItems) do
        local itemKeyId = self.expendData[i]
        local isHadBoughtEver = false
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, itemKeyId)
        local isTaskItem = itemInfo.extendData.assemblyGift == nil

        if isTaskItem then -- 任务的话可以直接领取
            isHadBoughtEver = true
        else               -- 充值的话要先购买
            isHadBoughtEver = itemInfo.extendData.assemblyFlag ~= nil
        end

        local curPersonNum, maxTargetNum = self:getCurAndMaxNum(itemKeyId)
        item.bar_progress:setPercent(curPersonNum / maxTargetNum * 100)

        local progressItems = item.progressItems
        for j, progressItem in ipairs(progressItems) do
            local itemId = self.expendDataDic[tostring(itemKeyId)][j]
            local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, itemId)
            local status = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, itemId).status

            progressItem.img_getted:setVisible(status == EC_TaskStatus.GETED)
            progressItem.img_canGet:setVisible(status == EC_TaskStatus.GET)
            progressItem.img_ing:setVisible(status == EC_TaskStatus.ING)
            local targetNum = itemInfo.target
            targetNum = targetNum >= 10000 and (targetNum / 10000).."w" or targetNum
            progressItem.lab_needNum:setText(targetNum)

            progressItem.root:setTouchEnabled(true)
            progressItem.root:onClick(function()
                if status == EC_TaskStatus.GET then
                    if isHadBoughtEver then
                        ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, itemId)
                    else
                        Utils:showTips(63921)
                    end
                else
                    local awards = {}
                    for _id, _num in pairs(itemInfo.reward) do
                        table.insert(awards, {id = _id, num = _num})
                    end
                    Utils:previewReward(nil, awards, 0.6)
                end
            end)
        end

    end
end

function ReturnGiftView:refreshRequestPersonNum(data)
    if not self.assemblysNumDic then
        self.assemblysNumDic = {}
    end
    for i, v in ipairs(data.assemblys) do
        if not self.assemblysNumDic[v.itemId] then
            self.assemblysNumDic[v.itemId] = v.num
        else
            self.assemblysNumDic[v.itemId] = math.max(self.assemblysNumDic[v.itemId], v.num)
        end
    end
    if self.isFirshIn then
        self.isFirshIn = false
        self:initListView()
        self:refreshListView()
    end
    for i, item in ipairs(self.listNeedRefreshItems) do
        local _id = self.expendData[i]
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, _id)
        if itemInfo then
            local assemblyGiftId = itemInfo.extendData.assemblyGift
            local isTaskItem = assemblyGiftId == nil
            local _txtId = 63918
            if not isTaskItem then
                _txtId = 63919
            end
            item.lab_sumCurGettedNum:setTextById(_txtId, self.assemblysNumDic[_id])
            item.lab_sumCurGettedNum:show()
        end
    end
end

function ReturnGiftView:onSubmitSuccessEvent(activitId, itemId, reward)
    Utils:showReward(reward)
end

function ReturnGiftView:onUpdateProgressEvent()
    self:updateGifts()
    self:updateProgressItems()
end

function ReturnGiftView:removeEvents()
	self.super.removeEvents(self)
    if self.timer then
        TFDirector:stopTimer(self.timer)
		TFDirector:removeTimer(self.timer)
		self.timer = nil
    end
end

return ReturnGiftView