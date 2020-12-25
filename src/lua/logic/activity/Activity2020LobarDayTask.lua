--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local Activity2020LobarDayTask = class("Activity2020LobarDayTask",  BaseLayer)

function Activity2020LobarDayTask:ctor(...)
	self.super.ctor(self)
	self:initData()

	self:init("lua.uiconfig.activity.LobarDayTask")
	self:initTableView()

	self:clickTab(self.tabTask)
end

function Activity2020LobarDayTask:initData(...)
	self.data = {[1] = {1,2,3,4,5}, [2] = {1,2}}
	self.currentTab = nil
end

function Activity2020LobarDayTask:initUI(ui)
	self.super.initUI(self, ui)
	self.prefab = TFDirector:getChildByPath(self.ui, "Panel_taskItem")
	self.Button_close = TFDirector:getChildByPath(ui, "Button_close")

	self.tabRank = TFDirector:getChildByPath(ui, "tabRank")
	self.tabRank:setTextureNormal("ui/common/7.png")
	self.tabRank.labelSelect = TFDirector:getChildByPath(self.tabRank, "label_select")
	self.tabRank.labelSelect:setVisible(false)
	self.tabRank.labelUnSelect = TFDirector:getChildByPath(self.tabRank, "label_unselect")
	self.tabRank.labelUnSelect:setVisible(true)
	self.tabRank.task = self.data[1]

	self.tabTask = TFDirector:getChildByPath(ui, "tabTask")
	self.tabTask:setTextureNormal("ui/common/7.png")
	self.tabTask.labelSelect = TFDirector:getChildByPath(self.tabTask, "label_select")
	self.tabTask.labelSelect:setVisible(false)
	self.tabTask.labelUnSelect = TFDirector:getChildByPath(self.tabTask, "label_unselect")
	self.tabTask.labelUnSelect:setVisible(true)
	self.tabTask.task = self.data[2]
end

function Activity2020LobarDayTask:registerEvents()
	self.Button_close:onClick(function()
		AlertManager:closeLayer(self)
	end)
	self.tabRank:onClick(function(widget)
		self:clickTab(widget)
	end)
	self.tabTask:onClick(function(widget)
		self:clickTab(widget)
	end)
end

function Activity2020LobarDayTask:clickTab(widget)
	if widget == self.currentTab then
		return
	end

	if self.currentTab then
		self.currentTab.labelSelect:setVisible(false)
		self.currentTab.labelUnSelect:setVisible(true)
		self.currentTab:setTextureNormal("ui/common/7.png")
	end
	self.currentTab = widget
	self.currentTab:setTextureNormal("ui/common/6.png")
	self.currentTab.labelSelect:setVisible(true)
	self.currentTab.labelUnSelect:setVisible(false)
	
	self.tableView:reloadData()
end

function Activity2020LobarDayTask:refreshView()
	
end

function Activity2020LobarDayTask:initTableView()
	local ScrollView = TFDirector:getChildByPath(self.ui, "ScrollView")
	self.tableView = Utils:scrollView2TableView(ScrollView)
	self.tableView:setDirection(TFTableView.TFSCROLLVERTICAL)
	self.tableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.tableCellSize,self))
    self.tableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCells,self))
    self.tableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex,self))

end

function Activity2020LobarDayTask:tableCellSize(tableView, idx)
	local size = self.prefab:getSize()
    return size.height, size.width + 5
end

function Activity2020LobarDayTask:numberOfCells(tableView)
	local size = 0;
	if self.currentTab.task then
		size = #self.currentTab.task
	end
    return size
end

function Activity2020LobarDayTask:tableCellAtIndex(tableView,idx)
    local cell = tableView:dequeueCell()
    local item = nil
    if nil == cell then
        cell = TFTableViewCell:create()
        item = self.prefab:clone()
        item:show()
        item:setPosition(ccp(0,0))
        cell:addChild(item)
        cell.item = item	
	else
		item = cell.item
    end
	self:initCell(item, self.currentTab.task[idx + 1])
    return cell
end

function Activity2020LobarDayTask:initCell(cell, data)
	cell.task_des = TFDirector:getChildByPath(cell, "task_des")
	cell.task_des = TFDirector:getChildByPath(cell, "task_des")
end


return Activity2020LobarDayTask


--endregion
