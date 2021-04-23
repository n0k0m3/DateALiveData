--[[
version: creator 2.4.1
Author: 张鹏程
Date: 2021-01-20 18:39:54
--]]
local FireworkStoreView = class("FireworkStoreView",BaseLayer)
function ValentinesReward:ctor(...)
    self.super.ctor(self)
    self:showPopAnim(true)
    self:initData(...)
    self:init("lua.uiconfig.activity.fireworkStoreView")
end

function FireworkStoreView:initUI(ui)
    self.super.initUI(self,ui)

    self.tableView                      = Utils:scrollView2TableView( TFDirector:getChildByPath(ui,"ScrollView"))
    self.Panel_item                     = TFDirector:getChildByPath(ui,"Panel_item")

    self.Label_diamondNum               = TFDirector:getChildByPath(ui,"Label_diamondNum")

    self.Image_coin_icon                = TFDirector:getChildByPath(ui,"Image_coin_icon")

    self.Button_close                   = TFDirector:getChildByPath(ui,"Button_close")

    self.totalProgress                  = TFDirector:getChildByPath(ui,"totalProgress")

    self:initRewardProgress()
    self:initTask()
end

function FireworkStoreView:initData(activityId)
    self.activityId = activityId
    self.activityData = ActivityDataMgr2:getActivityInfo(activityId)
   
end

function FireworkStoreView:registerEvents()
    self.super.registerEvents(self)

   
end

function FireworkStoreView:initTask()
    self:initTableView()
end

function FireworkStoreView:initTableView()
	self.tableView:setDirection(TFTableView.TFSCROLLVERTICAL)
	self.tableView:setVerticalFillOrder(TFTableView.TFTabViewFILLTOPDOWN)
	self.tableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.tableCellSize,self))
    self.tableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCells,self))
    self.tableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex,self))

	self.tableView:reloadData()
end

function FireworkStoreView:numberOfCells(tableView)
	return #self.tasks
end

function FireworkStoreView:tableCellSize(tableView)
	local size = self.Panel_taskItem:getContentSize()
	return size.height, size.width
end

function FireworkStoreView:tableCellAtIndex(tableView, idx)
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

function FireworkStoreView:initCell(item, data)
	item.Image_icon = TFDirector:getChildByPath(item, "Image_icon")
	item.Label_desc = TFDirector:getChildByPath(item, "Label_desc")
    
end

function FireworkStoreView:updateCell(item, taskId)
    
end

function FireworkStoreView:recProgressReward(reward)
    if table.count(reward) > 0 then
        Utils:showReward(reward)
    end

    self.tableView:reloadData()
end




return FireworkStoreView