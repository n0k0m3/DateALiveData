--[[
    @desc:糖葫芦奖励view
]]
local TanghuluRewardView = class("TanghuluRewardView", BaseLayer)

function TanghuluRewardView:initData(data)
    self.data = data
end

function TanghuluRewardView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.tanghuluRewardsView")
end

function TanghuluRewardView:initUI(ui)
    self.super.initUI(self, ui)
    self.view = Utils:scrollView2TableView(self._ui.rewardsView)
    self.view:setZOrder(99)
end

function TanghuluRewardView:registerEvents()
    self._ui.btnClose:onClick(function()
        AlertManager:close(self)
    end)

    self.view:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.rankCellSize,self))
    self.view:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCells,self))
    self.view:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex,self))
    self.view:reloadData()
end

function TanghuluRewardView:rankCellSize(tableView, idx)
    local size = self._ui.rewardItem:getSize()
    return size.height, size.width
end

function TanghuluRewardView:numberOfCells(tableView)
    return #self.data[1] or 0 
end

function TanghuluRewardView:tableCellAtIndex(tableView,idx)
    local cell = tableView:dequeueCell()
    local index = idx + 1
    local item = nil

    if nil == cell then
        cell = TFTableViewCell:create()
        item = self._ui.rewardItem:clone()

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

function TanghuluRewardView:refreshCellItem(item, idx)
    local cellData = {}
    for i = 1 , #self.data do
        table.insert( cellData, self.data[i][idx])
    end

    local lab_desc = TFDirector:getChildByPath(item, "img_desc.lab_desc")
    local rewards  = TFDirector:getChildByPath(item, "rewards")

    if not rewards.keep then
        rewards.keep = {}
        -- 后期改成固定只显示一个奖励了
        for j = 1 ,#rewards:getChildren() do
            local rewardPos = rewards:getChildren()
            rewards.keep[j] = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            rewards.keep[j]:setScale(0.65)
            rewards.keep[j]:AddTo(rewardPos[j]:getParent()):Pos(rewardPos[j]:Pos())
            rewards.keep[j].imgCompleteMask = rewardPos[j]:getChildByName("imgCompleteMask")
        end
    end

    for k, v in ipairs(rewards.keep) do
        local rewardCfgs = {}
        for id, key in pairs(cellData[k].reward) do
            table.insert(rewardCfgs,{id, key})
        end
        if table.count(rewardCfgs) > 0 then
            if v.ListView_star then
                v.ListView_star:removeAllItems()
            end
            v.ListView_star   = nil
            PrefabDataMgr:setInfo(v, rewardCfgs[1][1], rewardCfgs[1][2])
            v:setVisible(true)
        else
            v:setVisible(false)
        end

        local state = ActivityDataMgr2:getProgressInfo(EC_ActivityType2.TANGHULU, cellData[k].id).status
        if v.imgCompleteMask then
            v.imgCompleteMask:setVisible(state == EC_Assist_Item_Status.GETED)
        end
    end
    -- 取第一串的描述
    lab_desc:setText(cellData[1].extendData.des2)
end

return TanghuluRewardView