--[[
version: creator 2.4.1
Author: 张鹏程
Date: 2021-01-20 18:39:54
--]]
local NewyearTaskView = class("NewyearTaskView",BaseLayer)
function NewyearTaskView:ctor(...)
    self.super.ctor(self)
    self.block = AlertManager.BLOCK_CLOSE
    self:showPopAnim(true)
    self:initData(...)
    self:init("lua.uiconfig.activity.newspringTaskView")
end

function NewyearTaskView:initUI(ui)
    self.super.initUI(self,ui)

    self.tableView                      = Utils:scrollView2TableView( TFDirector:getChildByPath(ui,"ScrollView"))
    self.Panel_item                     = TFDirector:getChildByPath(ui,"Panel_item")

    self.Button_close                   = TFDirector:getChildByPath(ui,"Button_close")

    self.Label_bagName                  = TFDirector:getChildByPath(ui,"Label_bagName")

    self.Label_act_time                 = TFDirector:getChildByPath(ui,"Label_act_time")

    self.Panel_tab                      = TFDirector:getChildByPath(ui,"Panel_tab")


    local st_year, st_month, st_day = Utils:getDate(self.activityData.startTime)
    local en_year, en_month, en_day = Utils:getDate(self.activityData.showEndTime)
    self.Label_act_time:setTextById(63887, st_month, st_day, en_month, en_day)

    self:initTableView()
    self:initTask()
end

function NewyearTaskView:initData()
    self.activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.SNOW_FESTIVAL_TASK)[1]
    self.activityData = ActivityDataMgr2:getActivityInfo(self.activityId)
    --dump(ActivityDataMgr2:getActivityInfo())
    dump(self.activityData)
    self.originTasks = {{},{}}

    local day = self.activityData.extendData.day or {}
    for i, v in ipairs(day) do
        table.insert(self.originTasks[1], v)
    end

    local once = self.activityData.extendData.once or {}
    for i, v in ipairs(once) do
        table.insert(self.originTasks[2], v)
    end

    self.tasks = {}

    self.curTabIdx = nil
    self.tabs = nil
end

function NewyearTaskView:registerEvents()
    self.super.registerEvents(self)

    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.recProgressReward, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.closeSriptView, handler(self.onDatingClose, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_DELETED, function ( activityId, extendData )
        -- body
        if self.activityId == activityId then
            AlertManager:closeLayer(self)
        end
    end)

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

function NewyearTaskView:onShow()
    self.super.onShow(self)
    DatingDataMgr:triggerDating(self.__cname, "onShow")
    self:updateTableView()
end


function NewyearTaskView:initTask()
    self.tabs = self.Panel_tab:getChildren()
    for i=1,#self.tabs do
        local tab = self.tabs[i]
        tab.Image_Select    = TFDirector:getChildByPath(tab,"Image_Select")
        tab.Image_Unselet   = TFDirector:getChildByPath(tab,"Image_Unselet")
        tab.touch           = TFDirector:getChildByPath(tab,"touch")
        tab.touch:setTouchEnabled(true)
        tab.touch:setSwallowTouch(true)
        tab.touch:addMEListener(TFWIDGET_CLICK, function()
            self:selectTab(i)
        end)
    end

    self:selectTab(1)
end

function NewyearTaskView:selectTab(idx)
    if self.curTabIdx ==  idx then
        return
    end

    if self.curTabIdx then
        self.tabs[self.curTabIdx].Image_Select:hide()
        self.tabs[self.curTabIdx].Image_Unselet:show()
    end

    self.tabs[idx].Image_Select:show()
    self.tabs[idx].Image_Unselet:hide()

    self.Label_bagName:setText(self.tabs[idx].Image_Select:getChildren()[1]:getString())

    self.curTabIdx = idx

    self:updateTableView()
end

function NewyearTaskView:initTableView()
	self.tableView:setDirection(TFTableView.TFSCROLLVERTICAL)
	self.tableView:setVerticalFillOrder(TFTableView.TFTabViewFILLTOPDOWN)
	self.tableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.tableCellSize,self))
    self.tableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCells,self))
    self.tableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex,self))
end

function NewyearTaskView:numberOfCells(tableView)
	return #self.tasks[self.curTabIdx]
end

function NewyearTaskView:tableCellSize(tableView)
	local size = self.Panel_item:getContentSize()
	return size.height, size.width
end

function NewyearTaskView:tableCellAtIndex(tableView, idx)
	local cell = tableView:dequeueCell()
    local item = nil
	if nil == cell then
        cell = TFTableViewCell:create()
        item = self.Panel_item:clone()
		item.idx = idx
        item:show()
        item:setPosition(ccp(0,0))
        cell:addChild(item)
        cell.item = item

		self:initCell(item, self.tasks[self.curTabIdx][idx + 1])	
	else
		item = cell.item
    end
	self:updateCell(item, self.tasks[self.curTabIdx][idx + 1],idx + 1)
	return cell
end

function NewyearTaskView:initCell(item, taskId)
    item.Label_des = TFDirector:getChildByPath(item, "Label_des")
    item.Label_progress = TFDirector:getChildByPath(item, "Label_progress")
    item.Button_goto = TFDirector:getChildByPath(item, "Button_goto")

    item.Button_get = TFDirector:getChildByPath(item, "Button_get")

    item.Label_finish = TFDirector:getChildByPath(item, "Label_finish")
    item.pos_1 = TFDirector:getChildByPath(item, "pos_1"):getPosition()
    item.pos_2 = TFDirector:getChildByPath(item, "pos_2"):getPosition()
    item.pos_3 = TFDirector:getChildByPath(item, "pos_3"):getPosition()
end

function NewyearTaskView:updateCell(item, taskId, idx)
    local itemInfo = ActivityDataMgr2:getItemInfo(self.activityData.activityType, taskId)
    if itemInfo == nil then
        print("没有条目数据",taskId)
        return 
    end
    dump(itemInfo)
    for i=1,3 do
        local child = TFDirector:getChildByPath(item, "Image_reward_"..i):hide()
        if child then
            child:removeAllChildren()
        end
    end
 
    local progress = ActivityDataMgr2:getProgress(self.activityData.activityType, taskId)
    local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityData.activityType, taskId)

    local rewards = itemInfo.reward
    local rewardCnt = table.count(rewards)
    local i = 1
    for k,v in pairs(rewards) do
        item["Image_reward_"..i] = TFDirector:getChildByPath(item, "Image_reward_"..i)
        if item["Image_reward_"..i] then
            item["Image_reward_"..i]:show()
            item["Image_reward_"..i]:removeAllChildren()
            local rewardItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            rewardItem:setPosition(ccp(0,0))
            rewardItem:setScale(0.7)
            PrefabDataMgr:setInfo(rewardItem, tonumber(k), v)
            item["Image_reward_"..i]:addChild(rewardItem)            
            
            if rewardCnt < 3 then
                item["Image_reward_"..i]:setPosition(item["pos_"..(i - 1 + rewardCnt)])
            end

            i = i + 1
        end
    end

    item.Label_des:setText(itemInfo.extendData.des2)

    item.Label_progress:setTextById(800005, progress, itemInfo.target)

    item.Button_goto:setVisible(progressInfo.status == EC_TaskStatus.ING)
    item.Button_goto:onClick(function()
        if ServerDataMgr:getServerTime() >= self.activityData.endTime then
            Utils:showTips(1710021)
            return
        end
        local jumpInterface = itemInfo.extendData.jumpInterface
        if jumpInterface and jumpInterface ~=0 then
            local param = itemInfo.extendData.parameter or {}
            FunctionDataMgr:enterByFuncId(jumpInterface, unpack(param))
        else
            Utils:showTips(63886)
        end
    end)

    item.Button_get:setVisible(progressInfo.status == EC_TaskStatus.GET)
    item.Button_get:onClick(function()
        ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityData.id, taskId)
    end)

    item.Label_finish:setVisible(progressInfo.status == EC_TaskStatus.GETED)
end

function NewyearTaskView:selectTask(tasks)
    local taskData = {}
    for k, taskId in pairs(tasks or {}) do  
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityData.activityType, taskId)
        if itemInfo.extendData.extendsTaskId then          
            local PreInfo = ActivityDataMgr2:getItemInfo(self.activityData.activityType, itemInfo.extendData.extendsTaskId)
            local preProgressInfo = ActivityDataMgr2:getProgressInfo(self.activityData.activityType, itemInfo.extendData.extendsTaskId)           
            if PreInfo and preProgressInfo.status ~= EC_TaskStatus.ING or PreInfo==nil then
                local order0 = 0     
                local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityData.activityType, taskId)
                if progressInfo then
                    if progressInfo.status == EC_TaskStatus.ING then
                        order0 = 1
                    elseif progressInfo.status == EC_TaskStatus.GET then
                        order0 = 0
                    elseif progressInfo.status == EC_TaskStatus.GETED then
                        order0 = 2
                    end
                    table.insert(taskData, {id=taskId, order0=order0, status=progressInfo.status})
                end
            end
        else
            local order0 = 0     
            local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityData.activityType, taskId)
            if progressInfo then
                if progressInfo.status == EC_TaskStatus.ING then
                    order0 = 1
                elseif progressInfo.status == EC_TaskStatus.GET then
                    order0 = 0
                elseif progressInfo.status == EC_TaskStatus.GETED then
                    order0 = 2
                end
                table.insert(taskData, {id=taskId, order0=order0, status=progressInfo.status})
            end
        end
    end

    table.sort(taskData, function(A,B)
        return A.order0 < B.order0 
    end)

   local ret = {}
   for i, val in ipairs(taskData) do
        table.insert(ret, val.id)
   end

    return ret
end

function NewyearTaskView:updateTableView()
    self.tasks[self.curTabIdx] = self:selectTask(clone(self.originTasks[self.curTabIdx]))

    self.tableView:reloadData()
end

function NewyearTaskView:recProgressReward(actId, entryID, reward)
    print("收到奖励",actId, entryID, reward)
    if actId == self.activityId then
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityData.activityType, entryID)
        if itemInfo.extendData.datingRuleId then
            self.recReward = reward
            DatingDataMgr:startDating(itemInfo.extendData.datingRuleId)
        else
            if table.count(reward) > 0 then
                Utils:showReward(reward,nil, function()
                    self.recReward = nil
                end)
            end
        end

        self:updateTableView()
    end
end

function NewyearTaskView:onDatingClose()
    if self.recReward and table.count(self.recReward) > 0 then
        Utils:showReward(self.recReward,nil, function()
            self.recReward = nil
        end)
    end
end




return NewyearTaskView