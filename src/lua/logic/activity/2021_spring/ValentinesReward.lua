--[[
version: creator 2.4.1
Author: 张鹏程
Date: 2021-01-18 11:13:44
--]]
local ValentinesReward = class("ValentinesReward",BaseLayer)
function ValentinesReward:ctor(...)
    self.super.ctor(self)
    self:showPopAnim(true)
    self:initData(...)
    self:init("lua.uiconfig.activity.valentineRewardView")
end

function ValentinesReward:initUI(ui)
    self.super.initUI(self,ui)

    self.tableView                      = Utils:scrollView2TableView( TFDirector:getChildByPath(ui,"ScrollView_task"))
    self.Panel_taskItem                 = TFDirector:getChildByPath(ui,"Panel_taskItem")

    self.totalProgress                  = TFDirector:getChildByPath(ui,"totalProgress")

    self.Panel_activeItem               = TFDirector:getChildByPath(ui,"Panel_activeItem")

    self.Panel_rewardlist               = TFDirector:getChildByPath(ui,"Panel_rewardlist")

    self.totalProgress                  = TFDirector:getChildByPath(ui,"totalProgress")
    

    self.progressBar                    = TFDirector:getChildByPath(ui,"progressBar")
    self.progressBar.size               = self.progressBar:getParent():getSize()

    self.Button_close                   = TFDirector:getChildByPath(ui,"Button_close")

    self:initRewardProgress()
    self:initTask()

    
end

function ValentinesReward:initData(activityId)
    self.activityId = activityId
    self.activityData = ActivityDataMgr2:getActivityInfo(activityId)
    dump(self.activityData)
    self.globalRewards = {}
    local rewards = self.activityData.extendData.rewards or {}
    for k,v in pairs( rewards) do
        local ids = {}
        for id, num in pairs(v) do
            table.insert(ids, {id=tonumber(id), num=tonumber(num)})
        end
        table.insert(self.globalRewards, {ids=ids, progress=tonumber(k)})
    end
    table.sort(self.globalRewards, function(A, B)
        return A.progress < B.progress
    end)

    self.tasks = ActivityDataMgr2:getItems(activityId)

    local lastReward = self.globalRewards[#self.globalRewards] or {}
    self.maxProgress = lastReward.progress

    self.progressReward = {}
end

function ValentinesReward:registerEvents()
    self.super.registerEvents(self)

    EventMgr:addEventListener(self, EV_VALENTINESDAY_RPOGRESS_REWARD, handler(self.recProgressReward, self))
    EventMgr:addEventListener(self, EV_VALENTINESDAY_MAIN_INFO, handler(self.refreshView, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.recTaskReward, self))

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    TFDirector:send(c2s.ACTIVITY2_REQ_VALENTINE_DATA,{})
end

function ValentinesReward:initTask()
    self:initTableView()
end

function ValentinesReward:initRewardProgress()
    for i=1, #self.globalRewards do
        local reward = self.globalRewards[i]
        local rewardItem = self.Panel_activeItem:clone()
        rewardItem.Panel_geted = TFDirector:getChildByPath(rewardItem,"Panel_geted"):hide()
        rewardItem.Panel_geted.Button_geted = TFDirector:getChildByPath(rewardItem.Panel_geted,"Button_geted")
        rewardItem.Panel_geted.Button_geted:onClick(function()
            Utils:previewReward(nil, reward.ids)
        end)
        rewardItem.Panel_canGet = TFDirector:getChildByPath(rewardItem,"Panel_canGet"):hide()
        rewardItem.Panel_canGet.Button_canGet = TFDirector:getChildByPath(rewardItem.Panel_canGet,"Button_canGet")
        rewardItem.Panel_canGet.Spine_receive = TFDirector:getChildByPath(rewardItem.Panel_canGet,"Spine_receive")
        rewardItem.Panel_canGet.Button_canGet:onClick(function()
            local ValentineData = ActivityDataMgr2:getValentinesDayData()    
            if tonumber(ValentineData.totalCount) > reward.progress then
                TFDirector:send(c2s.ACTIVITY2_REQ_TAKE_ROSE_REWARD, {tostring(reward.progress)})
            end     
        end)
        rewardItem.Panel_notGet = TFDirector:getChildByPath(rewardItem,"Panel_notGet"):show()
        rewardItem.Panel_notGet.Button_notGet = TFDirector:getChildByPath(rewardItem.Panel_notGet,"Button_notGet")
        rewardItem.Panel_notGet.Button_notGet:onClick(function()
            Utils:previewReward(nil, reward.ids)
        end)
        
        rewardItem.Label_getValue = TFDirector:getChildByPath(rewardItem,"Label_getValue")
        rewardItem.Label_getValue:setText(Utils:format_number_w(reward.progress) )
        rewardItem.Label_getValue:getParent():setContentSize(ccs(rewardItem.Label_getValue:getSize().width + 5, 30))
        rewardItem:setPosition(ccp(40 + (i-1) * 150 + 10, 0))
        self.Panel_rewardlist:addChild(rewardItem)
        table.insert(self.progressReward, {data=reward, rewardItem=rewardItem})


        local info = self.globalRewards[i]
        local progress = info.progress / self.maxProgress
        local x = (self.progressBar.size.width-12) * progress
        rewardItem:setPositionX(x - 8)
    end
    self:updateProgressReward()
end

function ValentinesReward:refreshView()
    self:sort()
    self:updateProgressReward()
    self.tableView:reloadData()
end

function ValentinesReward:onShow()
    self.super.onShow(self)
    self:refreshView()
end

function ValentinesReward:updateProgressReward()
    local ValentineData = ActivityDataMgr2:getValentinesDayData()

    local takelist = ActivityDataMgr2:getVantinesProgress() or {}

    if tonumber(ValentineData.totalCount) > 1000000 then
        self.totalProgress:setFontSize(22)
    end 
    self.totalProgress:setText(ValentineData.totalCount)
    for i=1, #self.progressReward do
        local rewardNode = self.progressReward[i]
        rewardNode.rewardItem.Panel_geted:hide()
        rewardNode.rewardItem.Panel_canGet:hide()
        rewardNode.rewardItem.Panel_canGet.Spine_receive:show():stopAllActions()
        rewardNode.rewardItem.Panel_notGet:hide()

        local index = table.indexOf(takelist, tostring(rewardNode.data.progress))
        if index ~= -1 then
            rewardNode.rewardItem.Panel_geted:show()
        else            
            if tonumber(ValentineData.totalCount or 0) > rewardNode.data.progress then
                rewardNode.rewardItem.Panel_canGet:show()
                rewardNode.rewardItem.Panel_canGet.Spine_receive:play("animation", true)
            else
                rewardNode.rewardItem.Panel_notGet:show()
            end
        end
    end
    self.progressBar:setPercent(tonumber(ValentineData.totalCount or 0) / self.maxProgress * 100)   
end

function ValentinesReward:initTableView()
	self.tableView:setDirection(TFTableView.TFSCROLLVERTICAL)
	self.tableView:setVerticalFillOrder(TFTableView.TFTabViewFILLTOPDOWN)
	self.tableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.tableCellSize,self))
    self.tableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCells,self))
    self.tableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex,self))

	self.tableView:reloadData()
end

function ValentinesReward:numberOfCells(tableView)
	return #self.tasks
end

function ValentinesReward:tableCellSize(tableView)
	local size = self.Panel_taskItem:getContentSize()
	return size.height, size.width
end

function ValentinesReward:tableCellAtIndex(tableView, idx)
	local cell = tableView:dequeueCell()
    local item = nil
	if nil == cell then

        cell = TFTableViewCell:create()
        item = self.Panel_taskItem:clone()
		item.idx = idx
        item:show()
        item:setPosition(ccp(0,0))
        cell:addChild(item)
        cell.item = item

		self:initCell(item, self.tasks[idx + 1])	
	else
		item = cell.item
    end
	self:updateCell(item, self.tasks[idx + 1])
	return cell
end

function ValentinesReward:initCell(item, data)
	item.Image_icon = TFDirector:getChildByPath(item, "Image_icon")
	item.Label_desc = TFDirector:getChildByPath(item, "Label_desc")
    item.Label_progress = TFDirector:getChildByPath(item, "Label_progress")
    item.Image_reward_1 = nil
    item.Image_reward_2 = nil
    item.Image_reward_3 = nil
    item.Button_receive = TFDirector:getChildByPath(item, "Button_receive")
    item.Label_geted = TFDirector:getChildByPath(item, "Label_geted")
    item.Button_unfinish = TFDirector:getChildByPath(item, "Button_unfinish")
    item.Image_lock = TFDirector:getChildByPath(item, "Image_lock")
end

function ValentinesReward:updateCell(item, taskId)
    for i=1,3 do
        local child = TFDirector:getChildByPath(item, "Image_reward_"..i)
        if child then
            child:removeAllChildren()
        end
    end

    local taskItemInfo = ActivityDataMgr2:getItemInfo(self.activityData.activityType, taskId)
    local taskProgress = ActivityDataMgr2:getProgress(self.activityData.activityType, taskId)
    local taskProgressInfo = ActivityDataMgr2:getProgressInfo(self.activityData.activityType, taskId)
    print(taskItemInfo, taskProgress,taskProgressInfo)

    --item.Image_icon:setTexture(taskItemInfo.extendData.icon)
    item.Label_desc:setText(taskItemInfo.extendData.des2)
    local max = taskItemInfo.target
    if taskProgress > max then
        taskProgress = max
    end
    item.Label_progress:setTextById(800005, taskProgress, max)
    local index = 1
    for k, v in pairs(taskItemInfo.reward) do
        local node = TFDirector:getChildByPath(item, "Image_reward_"..index)
        if node then
            local rewardItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            rewardItem:setPosition(ccp(0,0))
            rewardItem:setScale(0.7)
            PrefabDataMgr:setInfo(rewardItem, k, v)
            
            node:addChild(rewardItem)
            index = index + 1
        end
    end
    item.Button_receive:setVisible(taskProgressInfo.status == EC_TaskStatus.GET)
    item.Button_receive:onClick(function()
        if ServerDataMgr:getServerTime() >= self.activityData.endTime then
            Utils:showTips(1710021)
            return
        end
        ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityData.id, taskId)
    end)
    item.Label_geted:setVisible(taskProgressInfo.status == EC_TaskStatus.GETED)
    item.Button_unfinish:setVisible(taskProgressInfo.status == EC_TaskStatus.ING)
    item.Button_unfinish:onClick(function()
        -- if ServerDataMgr:getServerTime() >= self.activityData.endTime then
        --     Utils:showTips(1710021)
        --     return
        -- end

        -- local param = taskItemInfo.extendData.parameter or {}
        -- FunctionDataMgr:enterByFuncId(taskItemInfo.extendData.jumpInterface,unpack(param))
    end)
    item.Image_lock:setVisible()
end

function ValentinesReward:recProgressReward(reward)
    if table.count(reward) > 0 then
        Utils:showReward(reward)
    end
end

function ValentinesReward:recTaskReward(actId, entryID, reward)
    if actId == self.activityId then
        if table.count(reward) > 0 then
            Utils:showReward(reward)
        end
    end

    self:refreshView()
end

function ValentinesReward:sort()
    local newTasks = {}
    local tasks = clone(self.tasks)
    for k, v in ipairs(tasks) do
        local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityData.activityType, v)
        if progressInfo.status == EC_TaskStatus.GET then
            table.insert(newTasks, v)
        end
    end
    for k, v in ipairs(tasks) do
        local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityData.activityType, v)
        if progressInfo.status == EC_TaskStatus.ING then
            table.insert(newTasks, v)
        end
    end
    for k, v in ipairs(tasks) do
        local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityData.activityType, v)
        if progressInfo.status == EC_TaskStatus.GETED then
            table.insert(newTasks, v)
        end
    end

    self.tasks = newTasks
end




return ValentinesReward