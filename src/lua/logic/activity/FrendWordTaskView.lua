--[[
    @desc:好友寄语任务view
]]
local FrendWordTaskView = class("FrendWordTaskView", BaseLayer)

function FrendWordTaskView:initData()
    self.data          = {}
    local activityId   = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.FRIEND_BLESS)[1]
    local activityInfo = ActivityDataMgr2:getActivityInfo(activityId)
    local data         = activityInfo.extendData.reward

    local servertime = ServerDataMgr:getServerTime()
    if activityInfo.endTime < servertime then
        -- 是否是结算展示时间
        self.isTheDisTime = true
    else
        self.isTheDisTime = false
    end 

    self.sumReceve    = FriendDataMgr:getFriendWishWordData().totalReceiveCount

    for i, v in pairs(data) do
        table.insert(self.data, v)
    end
    table.sort(self.data,function(a, b)
        return a.start < b.start
    end)

    if self.isTheDisTime and not FriendDataMgr:isHadGetLastReward() then
        table.sort(self.data,function(a, b)
            if a.start <= self.sumReceve and self.sumReceve <= a["end"] then
                return true
            end
            return false
        end)
    end
end

function FrendWordTaskView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.friendWordTaskView")
end

function FrendWordTaskView:initUI(ui)
    self.super.initUI(self, ui)
    self.view = Utils:scrollView2TableView(self._ui.rewardsView)
    self.view:setZOrder(99)
end

function FrendWordTaskView:registerEvents()
    
    self._ui.btnClose:onClick(function()
        AlertManager:close(self)
    end)

    self._ui.pannel_root:onClick(function()
        AlertManager:close(self)
    end)

    EventMgr:addEventListener(self, EV_FRIEND_WISHWORD_UPDATE, handler(self.refreshView,self))

    self.view:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.rankCellSize,self))
    self.view:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCells,self))
    self.view:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex,self))

    self.view:reloadData()
end

function FrendWordTaskView:rankCellSize(tableView, idx)
    local size = self._ui.taskItem:getSize()
    return size.height + 10, size.width
end

function FrendWordTaskView:numberOfCells(tableView)
    return #self.data or 0 
end

function FrendWordTaskView:tableCellAtIndex(tableView,idx)
    local cell = tableView:dequeueCell()
    local index = idx + 1
    local item = nil

    if nil == cell then
        cell = TFTableViewCell:create()
        item = self._ui.taskItem:clone()

        if item == nil then
            return
        end
        item:setPosition(ccp(0,0))
        cell:addChild(item)
        cell.item = item
    else
        item = cell.item
    end

    self:refreshCellItem(item,index)
    return cell
end

function FrendWordTaskView:refreshCellItem(item, idx)
    local data = self.data[idx]
    local lab_desc = item:getChildByName("lab_desc")
    local imgCompleteMask = item:getChildByName("imgCompleteMask")
    local rewards = item:getChildByName("rewards")
    local labNotComplete = item:getChildByName("labNotComplete")
    local btnComplete = item:getChildByName("btnComplete")

    if not rewards.keep then
        rewards.keep = {}
        local rewardPos = rewards:getChildren()
        for i = 1 , #rewardPos do
            rewards.keep[i] = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            rewards.keep[i]:setScale(0.6)
            rewards.keep[i]:AddTo(rewardPos[i]:getParent()):Pos(rewardPos[i]:Pos())
        end
    end

    local rewardData = {}
    for id, num in pairs(data.item) do
        table.insert(rewardData, {tonumber(id), num} )
    end
    
    for i, v in ipairs(rewards.keep) do 
        if i <= #rewardData then
            if v.ListView_star then
                v.ListView_star:removeAllItems()
            end
            v.ListView_star   = nil
            PrefabDataMgr:setInfo(v, rewardData[i][1], rewardData[i][2])
            v:setVisible(true)
        else
            v:setVisible(false)
        end
    end
    lab_desc:setTextById(data.stringId)

    -- 到领取时间且没有被领取过
    btnComplete:setVisible(false)
    if self.isTheDisTime and not FriendDataMgr:isHadGetLastReward() then
        if data.start <= self.sumReceve  and self.sumReceve <= data["end"] then -- 待领取
            btnComplete:setVisible(true)
            btnComplete:onClick(function()
                FriendDataMgr:send_SPRING_WISH_REQ_GET_REWARD()
            end)
        end
    end
    
    imgCompleteMask:setVisible(false)
    labNotComplete:setVisible(false)
end

function FrendWordTaskView:refreshView()
    self:initData()
    self.view:reloadData()
end

return FrendWordTaskView