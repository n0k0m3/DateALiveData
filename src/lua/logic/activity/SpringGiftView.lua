--[[
    @desc：SpringGiftView
    @date: 2021-03-01 10:51:53
]]

local SpringGiftView = class("SpringGiftView",BaseLayer)

function SpringGiftView:initData(activityId)
    self.activityId = activityId
    self.activityInfo = ActivityDataMgr2:getActivityInfo(activityId)
    dump(self.activityInfo)

    self.selectLayerIdx = 1
    self.curSelect = nil
    self.layers = {}
    self.layerChooseBtns = {}

    self.layer2ChooseItemIdx = 1
    self.layer2CostItemIds = {}
    self.taskItems = {}
end

function SpringGiftView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.springGiftView")
end

function SpringGiftView:initUI(ui)
    self.super.initUI(self,ui)
    for i = 1, 3 do
        self.layers[i] = {layer = self._ui["panel_layer"..i], updateLayerFunc = nil}
        self.layerChooseBtns[i] = self._ui["btn_"..i]
    end 

    self.targetGridView = UIGridView:create(self._ui.ScrollView_target)
    self.targetGridView:setItemModel(self._ui.Panel_gridItem)
    self.targetGridView:setColumn(5)
    self.targetGridView:setRowMargin(-5)
    self.targetGridView:setColumnMargin(-5)

    self.costGridView = UIGridView:create(self._ui.ScrollView_costItem)
    self.costGridView:setItemModel(self._ui.Panel_gridItem)
    self.costGridView:setColumn(5)
    self.costGridView:setRowMargin(-5)
    self.costGridView:setColumnMargin(-5)

    self.taskView = UIListView:create(self._ui.ScrollView_task)
    self.taskView:setItemsMargin(5)

    self:chooseLayerByIdx(self.selectLayerIdx)

    local year, month, day = Utils:getDate(self.activityInfo.showStartTime or 0)
	self._ui.act_timeStart:setTextById(1410001,year, month, day)
	year, month, day = Utils:getDate(self.activityInfo.endTime or 0)
    self._ui.act_timeEnd:setTextById(1410001,year, month, day)
end

function SpringGiftView:registerEvents()
    self._ui.btn_rule:onClick(function()
        Utils:openView("common.HelpView", {4108})
    end)

    for i, btn in pairs(self.layerChooseBtns) do
        btn:onClick(function()
            self:chooseLayerByIdx(i)
        end)
    end

    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onUpdateProgressEvent, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onUpdateBagItem, self))
    EventMgr:addEventListener(self,EV_SPRING_GIFT_DATA,handler(self.onRecvGetSubAward, self))
end

function SpringGiftView:chooseLayerByIdx(idx)
    assert(idx <= 3, "超出选择范围！")
    if idx == self.curSelect then
        return 
    end

    if idx == 3 then  -- 任务页面特殊限制需求
        local sTime, eTime = self:getSpecialTaskTime()
        local curTime = ServerDataMgr:getServerTime() * 1000
        if curTime <= sTime or curTime >= eTime then
            Utils:showTips(15011344)
            return
        end
    end
    
    for i, btn in pairs(self.layerChooseBtns) do
        btn:getChildByName("img_select"):setVisible(idx == i) 
    end

    for i, panelData in pairs(self.layers) do
        panelData.layer:setVisible(idx == i)
    end

    if not self.layers[idx].updateLayerFunc then
        self.layers[idx].updateLayerFunc = handler(self[string.format("updateLayer%s", idx)], self)
        self.layers[idx].updateLayerFunc()
    end

    self._ui.act_time:setVisible(idx ~= 3)
    self.curSelect = idx
end

function SpringGiftView:updateLayer1()
    local taskIds = self.activityInfo.extendData.exchangeId
    for i, id in ipairs(taskIds) do
        local taskInfo = ActivityDataMgr2:getItemInfo(EC_ActivityType2.SPRING_GIFT, id)
        local status = ActivityDataMgr2:getProgressInfo(EC_ActivityType2.SPRING_GIFT, id).status
        local costCfg = {}
        for _id, _num in pairs(taskInfo.extendData.cost) do
            table.insert(costCfg, {costCfgId = tonumber(_id), costCfgNum = tonumber(_num)})
        end

        local imgItem = self._ui["img_itemChang"..i] 
        local panel_rewardsChange = imgItem:getChildByName("panel_rewardsChange")
        local img_hadChanged = imgItem:getChildByName("img_hadChanged")
        local btn_change = imgItem:getChildByName("btn_change")
        local btn_changeLab = btn_change:getChildByName("label")
        local btnTxtId = 15011347

        panel_rewardsChange:setVisible(status ~= EC_TaskStatus.GETED)
        img_hadChanged:setVisible(status == EC_TaskStatus.GETED)

        local isCanSubmit = true
        for j = 1, 4 do
            local rewardPos = panel_rewardsChange:getChildByName("reward_pos"..j)
            local reward_posMask = panel_rewardsChange:getChildByName("reward_posMask"..j)
            if status == EC_TaskStatus.ING then
                if costCfg[j] then
                    if not rewardPos.goods then
                        rewardPos.goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
                        rewardPos.goods:setScale(0.5)
                        rewardPos.goods:AddTo(rewardPos):Pos(ccp(0, 0))
                    end
                    PrefabDataMgr:setInfo(rewardPos.goods, costCfg[j].costCfgId, costCfg[j].costCfgNum)
                    rewardPos:show()
                else
                    rewardPos:hide()
                end
                local itemNumInBag = GoodsDataMgr:getItemCount(costCfg[j].costCfgId)
                reward_posMask:setVisible(itemNumInBag < 1)
                if itemNumInBag < costCfg[j].costCfgNum then
                    isCanSubmit = false
                end
            else
                rewardPos:hide()
                reward_posMask:hide()
            end
        end 
        if status == EC_TaskStatus.GET then
            btnTxtId = 15011345
        end
        btn_changeLab:setTextById(btnTxtId)
        btn_change:setGrayEnabled(not isCanSubmit and status ~= EC_TaskStatus.GET)
        btn_change:setTouchEnabled((status == EC_TaskStatus.ING and isCanSubmit) or status == EC_TaskStatus.GET)
        btn_change:onClick(function()
            ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, id, 1)
        end)

    end
end

function SpringGiftView:updateLayer2()
    local equipmentRewards = self.activityInfo.extendData.equipmentReward

    self._ui.btn_compound:setGrayEnabled(true)
    self._ui.btn_compound:setTouchEnabled(false)

    local targetGoods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    targetGoods:setScale(0.8)
    targetGoods:AddTo(self._ui.targetItemPos):Pos(ccp(0, 0))

    -- 合成物品(固定)
    self.targetGridView:removeAllItems()
    for i, id in ipairs(equipmentRewards) do
        self.targetGridView:pushBackDefaultItem()
    end

    for i, tarGetItem in ipairs(self.targetGridView:getItems()) do
        local id = equipmentRewards[i]
        local goodsPos = tarGetItem:getChildByName("goodsPos")
        if not tarGetItem.imgSelectGoods then
            tarGetItem.imgSelectGoods = tarGetItem:getChildByName("imgSelectGoods")
        end
        tarGetItem.imgSelectGoods:setVisible(self.layer2ChooseItemIdx == i)
        if self.layer2ChooseItemIdx == i then
            self.keepLayer2TarGetItem = tarGetItem
            PrefabDataMgr:setInfo(targetGoods, id)
        end
        if not tarGetItem.goods then
            tarGetItem.goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            tarGetItem.goods:setScale(0.6)
            tarGetItem.goods:AddTo(goodsPos):Pos(ccp(0, 0))
            tarGetItem.goods:setTouchEnabled(false)
        end
        local count = GoodsDataMgr:getItemCount(id)
        PrefabDataMgr:setInfo(tarGetItem.goods, id, count)

        tarGetItem:setTouchEnabled(true)
        tarGetItem:onClick(function(sender)
            if self.layer2ChooseItemIdx == i then
                return
            end
            self.layer2ChooseItemIdx = i
            self.keepLayer2TarGetItem.imgSelectGoods:setVisible(false)
            sender.imgSelectGoods:setVisible(true)
            self.keepLayer2TarGetItem = sender
            PrefabDataMgr:setInfo(targetGoods, id)
        end)
    end

    self._ui.panel_randBuyGift:setTouchEnabled(true)
    self._ui.panel_randBuyGift:onClick(function()
        local itemId = self.activityInfo.extendData.ItemRecoverId
        local itemCfg = GoodsDataMgr:getItemCfg(itemId)
        if StoreDataMgr:canContinueBuyItemRecover(itemCfg.buyItemRecover) then
            Utils:openView("common.BuyResourceView", itemId)
        else
            Utils:showTips(800021)
        end
    end)

    self:updataLayer2CostItems()
end

function SpringGiftView:updataLayer2CostItems()
    local function isExistIntabById(tab, idx)
        for i, _idx in ipairs(tab) do
            if idx == _idx then
                return true
            end
        end
        return false
    end
    local equipmentRewards = self.activityInfo.extendData.equipmentReward
     -- 合成消耗物品
    self.costItemData = {}
    for i, _id in ipairs(equipmentRewards) do
        local costItemNum = GoodsDataMgr:getItemCount(_id)
        if costItemNum > 0 then 
            for _uid, _ in pairs(GoodsDataMgr:getItem(_id)) do  -- 全部罗列出来
                table.insert(self.costItemData, {id = _id, num = 1 ,uid = _uid})
            end
        end
     end 

    local gap = #self.costGridView:getItems() - #self.costItemData
    for j = 1, math.abs(gap) do
        if gap > 0 then
            self.costGridView:removeItem(1)
        else
            self.costGridView:pushBackDefaultItem()
        end
    end

    local costItems = self.costGridView:getItems()
    self._ui.lab_noCostItem:setVisible(#costItems <= 0)
    self.costGridView:setVisible(#costItems > 0)
    for i, costItem in ipairs(costItems) do
        local costCfg = self.costItemData[i]
        
        costItem:getChildByName("imgSelectGoods"):hide()
        if not costItem.imgSelectGoods then
            costItem.imgSelectGoods = costItem:getChildByName("imgSelectGoods")
        end
        if not costItem.goods then
            local goodsPos = costItem:getChildByName("goodsPos")
            costItem.goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            costItem.goods:setScale(0.6)
            costItem.goods:AddTo(goodsPos):Pos(ccp(0, 0))
            costItem.goods:setTouchEnabled(false)
        end

        local costItemlastNum = costCfg.num
        if isExistIntabById(self.layer2CostItemIds, i) then
            costItem.imgSelectGoods:show()
            costItemlastNum = costItemlastNum - 1
        else
            costItem.imgSelectGoods:hide()
        end
        PrefabDataMgr:setInfo(costItem.goods, costCfg.id, costItemlastNum)

        local function refreshTabInSelect(tab, idx)
            local isInTab = false
            for i, _idx in ipairs(tab) do
                if idx == _idx then
                    isInTab = true
                    table.remove(tab, i)
                    break
                end
            end
            if not isInTab then
                if #tab >= 2 then
                    Utils:showTips(15011346)
                else
                    table.insert(tab, idx)
                end
            end
        end
        costItem:setTouchEnabled(true)
        costItem:onClick(function()
            refreshTabInSelect(self.layer2CostItemIds, i)
            self:updataLayer2CostItems()
            self:updateLayer2LeftCostShow()
        end)
    end

    -- 刷新合成物拥有数量
    for i, tarGetItem in ipairs(self.targetGridView:getItems()) do
        if tarGetItem.goods then
            local count = GoodsDataMgr:getItemCount(equipmentRewards[i])
            PrefabDataMgr:setInfo(tarGetItem.goods, equipmentRewards[i], count)
        end
    end
end

function SpringGiftView:updateLayer2LeftCostShow()
    for i = 1, 2 do
        local panelPos = self._ui["costItemPos"..i]
        local imgShow = self._ui["img_costLight"..i]
        local idx = self.layer2CostItemIds[i]
        local costId = nil
        if idx then
            costId = self.costItemData[idx].id
            if not panelPos.goods then
                panelPos.goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
                panelPos.goods:setScale(0.8)
                panelPos.goods:AddTo(panelPos):Pos(ccp(0, 0))
            end
            PrefabDataMgr:setInfo(panelPos.goods, costId, 1)
            panelPos.goods:show()
        else
            if panelPos.goods then
                panelPos.goods:hide()
            end
        end
        imgShow:setVisible(costId)
    end 

    local function getItemNameById(_id)
        local cfg = GoodsDataMgr:getItemCfg(tonumber(_id))
        return TabDataMgr:getData("String", cfg.nameTextId).text
    end
    self._ui.btn_compound:setGrayEnabled(#self.layer2CostItemIds < 2)
    self._ui.btn_compound:setTouchEnabled(#self.layer2CostItemIds >= 2)
    self._ui.btn_compound:onClick(function()
        local targetId = self.activityInfo.extendData.equipmentReward[self.layer2ChooseItemIdx]
        local _data = self.costItemData
        local costIds = {}
        for _, idx in ipairs(self.layer2CostItemIds) do
            table.insert(costIds, tostring(_data[idx].uid))
        end
        local args = {
            tittle = 2107025,
            showCancle = true,
            content = TextDataMgr:getText(15011350, getItemNameById(_data[self.layer2CostItemIds[1]].id), 
                                                    getItemNameById(_data[self.layer2CostItemIds[2]].id),
                                                    getItemNameById(targetId)
                                            ),
            confirmCall = function()
                ActivityDataMgr2:SEND_SUMMON_REQ_ACTIVITY_EXCHANGE(costIds, tonumber(targetId))
            end,
        }
        Utils:showReConfirm(args)
    end)
end

function SpringGiftView:getSpecialTasks()
    local taskIds = ActivityDataMgr2:getItems(self.activityId)
    for i, _id in ipairs(self.activityInfo.extendData.exchangeId) do
        for j, curId in ipairs(taskIds) do
            if curId == _id then
                table.remove(taskIds, j)
                break
            end
        end
    end
    return taskIds
end

function SpringGiftView:getSpecialTaskTime()
    local stime, etime = nil
    for i, taskId in ipairs(self:getSpecialTasks()) do
        local taskInfo = ActivityDataMgr2:getItemInfo(EC_ActivityType2.SPRING_GIFT, taskId)
        if taskInfo.extendData.stime and taskInfo.extendData.etime then
            if nil == stime or nil == etime then
                stime = taskInfo.extendData.stime
                etime = taskInfo.extendData.etime
            else
                stime = math.min(stime, taskInfo.extendData.stime)
                etime = math.max(etime, taskInfo.extendData.etime)
            end
        end
    end
    return stime, etime
end

function SpringGiftView:updateLayer3()
    local taskIds = self:getSpecialTasks()
    local taskCount = table.count(taskIds)
    local items = self.taskView:getItems()
    local gap = taskCount - #items
    for i = 1, math.abs(gap) do
        if gap > 0 then
            local taskItem = self:addTaskItem()
            self.taskView:pushBackCustomItem(taskItem)
        else
            self.taskView:removeItem(1)
        end
    end

    for i, v in ipairs(self.taskView:getItems()) do
        local item = self.taskItems[v]
        local taskInfo = ActivityDataMgr2:getItemInfo(EC_ActivityType2.SPRING_GIFT, taskIds[i])
        local ProgressInfo = ActivityDataMgr2:getProgressInfo(EC_ActivityType2.SPRING_GIFT, taskIds[i])
        item.lab_desc:setText(taskInfo.extendData.des2)
        item.lab_progress:setTextById(800005, ProgressInfo.progress, taskInfo.target)
        item.lab_ing:setVisible(ProgressInfo.status == EC_TaskStatus.ING and not taskInfo.extendData.jumpInterface)
        item.btn_goto:setVisible(ProgressInfo.status == EC_TaskStatus.ING and taskInfo.extendData.jumpInterface)
        item.btn_receive:setVisible(ProgressInfo.status == EC_TaskStatus.GET)
        item.lab_hadRecevied:setVisible(ProgressInfo.status == EC_TaskStatus.GETED)
        item.rewardsView:removeAllItems()
        for rewardId, num in pairs(taskInfo.reward) do
            local goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            goods:setScale(0.8)
            PrefabDataMgr:setInfo(goods, rewardId, num)
            item.rewardsView:pushBackCustomItem(goods)
        end 

        item.btn_goto:onClick(function()
            FunctionDataMgr:enterByFuncId(taskInfo.extendData.jumpInterface)
        end)
        item.btn_receive:onClick(function()
            ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, taskInfo.id)
        end)
    end

    local stime, etime = self:getSpecialTaskTime()
    local year, month, day = Utils:getDate(stime/1000)
	self._ui.actTaskTimeStart:setTextById(1410001,year, month, day)
	year, month, day = Utils:getDate(etime/1000)
	self._ui.actTaskTimeEnd:setTextById(1410001,year, month, day)
end

function SpringGiftView:addTaskItem()
    local Panel_taskItem = self._ui.Panel_taskItem:clone()
    local foo = {}
    foo.rewards = {}
    foo.root = Panel_taskItem
    foo.lab_desc = TFDirector:getChildByPath(foo.root, "lab_desc")
    foo.lab_progress = TFDirector:getChildByPath(foo.root, "lab_progress")
    foo.btn_goto = TFDirector:getChildByPath(foo.root, "btn_goto")
    foo.lab_ing = TFDirector:getChildByPath(foo.root, "lab_ing")
    foo.btn_receive = TFDirector:getChildByPath(foo.root, "btn_receive") 
    foo.lab_hadRecevied = TFDirector:getChildByPath(foo.root, "lab_hadRecevied")
    local rewardsView = UIListView:create(TFDirector:getChildByPath(foo.root, "ScrollView_taskRewards"))
    rewardsView:setItemsMargin(10)
    foo.rewardsView = rewardsView
    self.taskItems[Panel_taskItem] = foo
    return Panel_taskItem
end

function SpringGiftView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId == activitId then
    	Utils:showReward(reward)
    end
end

function SpringGiftView:onUpdateProgressEvent()
    if (self.curSelect == 1 or self.curSelect == 3) and self.layers[self.curSelect].updateLayerFunc then
        self.layers[self.curSelect].updateLayerFunc()
    end
end

function SpringGiftView:onUpdateBagItem()
    self:updateLayer1()
    self:updataLayer2CostItems()
end

function SpringGiftView:onRecvGetSubAward(data)
    if data.itemCid then
        Utils:showReward({{id = data.itemCid, num = 1}})
    end
    self.layer2CostItemIds = {}
    self:updataLayer2CostItems()
    self:updateLayer2LeftCostShow()
end

return SpringGiftView