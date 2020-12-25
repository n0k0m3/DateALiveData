--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local CollectRewardView = class("CollectRewardView",BaseLayer)

local ITEM_TYPE_SHOW = {
	ITEM = 1,
	LINE = 2,
	NONE = 3
}

function CollectRewardView:ctor()
	self.super.ctor(self)
	self:showPopAnim(true)
	self:initData()
	self:init("lua.uiconfig.collect.collectRewardView")
end

function CollectRewardView:initData()
	local CfgList = TabDataMgr:getData("NewPokedexTask")
	self.data = {}
	for k, v in pairs(CfgList) do
		table.insert(self.data, v)
	end
	table.sort(self.data, function(a, b)
		return a.order < b.order
	end)

	dump(self.data)

	self.frameCount = 0
end

function CollectRewardView:registerEvents()
	self.super.registerEvents(self)
	EventMgr:addEventListener(self, EV_TASK_RECEIVE, handler(self.onTaskReceiveEvent, self))
	EventMgr:addEventListener(self, EV_TASK_RECEIVE_LIST, handler(self.onTaskReceiveEvent, self))

	self.Button_Allget:onClick(function()
		local taskTab = {}		
		for i=1, #self.data do
			if self.data[i].type == ITEM_TYPE_SHOW.ITEM then
				local taskInfo = TaskDataMgr:getTaskInfo(self.data[i].id)
				if taskInfo and taskInfo.status == EC_TaskStatus.GET then
					table.insert(taskTab, self.data[i].id)
				end
			end
		end
		if #taskTab == 0 then
			Utils:showTips(800057)
			return
		end
		TaskDataMgr:send_TASK_SUBMIT_TASK_LIST(taskTab)
	end)
end

function CollectRewardView:initUI(ui)
	self.super.initUI(self, ui)
	
	self.Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab")

	self.progressBar = TFDirector:getChildByPath(self.ui, "progressBar")
	self.progressBar:setPercent(0)
	self.cupNumber = TFDirector:getChildByPath(self.ui, "cupNumber")
	self.cupNumber:setText(0)

	self.lvl_Icon = TFDirector:getChildByPath(self.ui, "lvl_Icon")
	self.Label_collect_title = TFDirector:getChildByPath(self.ui, "Label_collect_title")
	self.Label_rank_desc = TFDirector:getChildByPath(self.ui, "Label_rank_desc")
	
	self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")
	self.Button_close:onClick(function()AlertManager:closeLayer(self) end)

	self.Button_Allget = TFDirector:getChildByPath(self.ui, "Button_Allget")

	self:initTableView()
	self:updateProgress()

	self.tableView:reloadData()
	self:updatePreviewItems()

	self:scrollToItem()
end

function CollectRewardView:initTableView()
	local list = TFDirector:getChildByPath(self.ui, "List")
	self.tableView = Utils:scrollView2TableView(list)
	self.tableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.tableCellSize,self))
    self.tableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCells,self))
    self.tableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex,self))
	self.tableView:addMEListener(TFTABLEVIEW_SCROLL, handler(self.TableViewScroll,self))
end

function CollectRewardView:tableCellSize(tableView, idx)
	local size = self.Panel_prefab:getSize()

	local data = self.data[idx + 1]
	if data.type == ITEM_TYPE_SHOW.NONE then

	elseif data.type == ITEM_TYPE_SHOW.LINE then
		--size.height = size.height * 0.3
	elseif data.type == ITEM_TYPE_SHOW.ITEM then
		
	end
    return size.height, size.width
end

function CollectRewardView:numberOfCells(tableView)
	local size = 0;
	if self.data then
		size = #self.data
	end
    return size
end

function CollectRewardView:TableViewScroll(tableView)
	self.frameCount = self.frameCount + 1
	local size = tableView:getSize()
	local currPosY = tableView:getContentOffset().y
	local prefabSize = self.Panel_prefab:getContentSize()
	local index = math.max(#self.data - math.ceil(math.abs(size.height - currPosY)/prefabSize.height),0)
	if self.index ~= index then
		self:updatePreviewItems(index)
		self.index = index
	end

	self.frameCount = 0
end

function CollectRewardView:tableCellAtIndex(tableView,idx)
	
    local cell = tableView:dequeueCell()
    local item = nil
    if nil == cell then
        cell = TFTableViewCell:create()
        item = self.Panel_prefab:clone()
        item:show()
        item:setPosition(ccp(0,0))
        cell:addChild(item)
        cell.item = item	
	else
		item = cell.item
    end
	
	self:initCell(item, self.data[idx + 1])
    return cell
end


function CollectRewardView:initCell(cell, data)
	cell:show()
	local node_detail = TFDirector:getChildByPath(cell, "node_detail"):show()
	local Image_line = TFDirector:getChildByPath(cell, "Image_line"):show()
	if data.type == ITEM_TYPE_SHOW.NONE then
		cell:Hide()
	elseif data.type == ITEM_TYPE_SHOW.LINE then
		node_detail:hide()
		local title = TFDirector:getChildByPath(Image_line, "lvl_title"):show()
		title:setTextById(data.lineTitle)
	elseif data.type == ITEM_TYPE_SHOW.ITEM then
		Image_line:hide()
		
		local taskCfg = TaskDataMgr:getTaskCfg(data.id)
		taskCfg.reward[1] = taskCfg.reward[1] or {}
		local panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
		panel_goodsItem:setPosition(ccp(0,0))
		PrefabDataMgr:setInfo(panel_goodsItem, taskCfg.reward[1][1], taskCfg.reward[1][2])
		panel_goodsItem:onClick(function()
            Utils:showInfo(taskCfg.reward[1][1], nil, false)
        end)

		local nodeReward = TFDirector:getChildByPath(cell, "nodeReward")
		nodeReward:addChild(panel_goodsItem)


		local bg_get = TFDirector:getChildByPath(cell, "bg_get"):hide()
			  bg_get.desc = TFDirector:getChildByPath(bg_get, "desc")
			  bg_get.desc:setTextById(tonumber(taskCfg.des))
			  bg_get.Button_get = TFDirector:getChildByPath(bg_get, "Button_get")
			  bg_get.Button_get:onClick(function()
					TaskDataMgr:send_TASK_SUBMIT_TASK(data.id)
			  end)
			  bg_get.Label_name = TFDirector:getChildByPath(bg_get, "Label_name")
			  bg_get.Label_name:setTextById(tonumber(taskCfg.name))

		local bg_got = TFDirector:getChildByPath(cell, "bg_got"):hide()
			  bg_got.desc = TFDirector:getChildByPath(bg_got, "desc")
			  bg_got.desc:setTextById(tonumber(taskCfg.des))
			  bg_got.Label_name = TFDirector:getChildByPath(bg_got, "Label_name")
			  bg_got.Label_name:setTextById(tonumber(taskCfg.name))

		local bg_noreach = TFDirector:getChildByPath(cell, "bg_noreach"):hide()
			  bg_noreach.desc = TFDirector:getChildByPath(bg_noreach, "desc")
			  bg_noreach.desc:setTextById(tonumber(taskCfg.des))
			  bg_noreach.Label_name = TFDirector:getChildByPath(bg_noreach, "Label_name")
			  bg_noreach.Label_name:setTextById(tonumber(taskCfg.name))
		
		local taskInfo = TaskDataMgr:getTaskInfo(data.id)
		if taskInfo and taskInfo.status == EC_TaskStatus.GET then
			bg_get:show()
		elseif taskInfo and taskInfo.status == EC_TaskStatus.GETED then
			bg_got:show()
		elseif taskInfo and taskInfo.status == EC_TaskStatus.ING then
			bg_noreach:show()
		end
	end
end

function CollectRewardView:updatePreviewItems(index)
	index = index or 0
	local data = self.data[index + 1]
	if self.curTitleRank ==  data.titleRank then
		return
	end

	local cfg = TabDataMgr:getData("NewPokedexTitle", data.titleRank)
	self.lvl_Icon:stopAllActions()
	self.lvl_Icon:runAction(Sequence:create({FadeOut:create(0.1), 
								CallFunc:create(function()
									self.lvl_Icon:setTexture(cfg.icon)
								end),
								FadeIn:create(0.5)}))
	
	self.Label_collect_title:setTextById(cfg.name)

	self.Label_rank_desc:setTextById(cfg.describe)

	self.curTitleRank =  data.titleRank
end

function CollectRewardView:updateProgress()
	local rankInfo = CollectDataMgr:getRankInfo()

	local cfg = TabDataMgr:getData("DiscreteData",46038)
	self.progressBar:setPercent(rankInfo.trophy / cfg.data.upLimit * 100)
	self.cupNumber:setTextById(1710530, rankInfo.trophy)
end

function CollectRewardView:onTaskReceiveEvent(rewards, taskID)
	if #rewards > 0 then
		Utils:showReward(rewards)
	end
	self:updateProgress()
	self.tableView:reloadData()
	self:scrollToItem()
end

function CollectRewardView:tableViewScrollToCell(idx)
	local container = self.tableView:getContainer()
	local containerSize = container:getSize()
	local viewSize = self.tableView:getSize()
	local cellSize = self.Panel_prefab:getSize()
	local offset = self.tableView:getContentOffset()
	local minY = viewSize.height - containerSize.height
	local y = -cellSize.height * ( math.max(#self.data - idx, 0)) + viewSize.height - cellSize.height
	y = math.max(minY, y)
	y = math.min(0, y)
	self.tableView:setContentOffsetInDuration(ccp(offset.x, y),0.3)
end

function CollectRewardView:scrollToItem(idx)
	if idx then
		self:tableViewScrollToCell(idx)	
	else
		local cellIdx;
		for i=1, #self.data do
			local data = self["data"][i]
			if data.type == ITEM_TYPE_SHOW.ITEM then
				local taskInfo = TaskDataMgr:getTaskInfo(data.id)
				if taskInfo and  taskInfo.status == EC_TaskStatus.GET then
					cellIdx = i
					break;
				end
			end
		end
		if cellIdx then
			self:tableViewScrollToCell(cellIdx)	
		else
			for i=1, #self.data do
				local data = self["data"][i]
				if data.type == ITEM_TYPE_SHOW.ITEM then
					local taskInfo = TaskDataMgr:getTaskInfo(data.id)
					if taskInfo and  taskInfo.status == EC_TaskStatus.ING then
						cellIdx = i
						break;
					end
				end
			end
			self:tableViewScrollToCell(cellIdx or 1)	
		end
	end

end

return CollectRewardView

--endregion
