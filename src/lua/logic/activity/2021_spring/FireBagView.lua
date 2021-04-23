--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

local FireBagView = class("FireBagView", BaseLayer)

function FireBagView:ctor(...)
	self.super.ctor(self)
	self:showPopAnim(true)
	self.initData(self, ...)
	self:init("lua.uiconfig.activity.fireBagView")
end

function FireBagView:initData(activityId)
	self.originData = {
	}
	self.activityId = activityId
	self.activityData = ActivityDataMgr2:getActivityInfo(activityId)
	dump(self.activityData)

	self.items = ActivityDataMgr2:getItems(self.activityId)
	for i=1, #self.items do
		local itemInfo = ActivityDataMgr2:getItemInfo(self.activityData.activityType, self.items[i])
		dump(itemInfo)
		local id =  next(itemInfo.reward)
		table.insert(self.originData, id)
	end
end

function FireBagView:setupData()
	self.data = {}
	local tab = nil
	local originIndex = 1
	for k, v in ipairs(self.originData) do		
		if originIndex % 5 == 1 then
			tab = {}
			table.insert(self.data, tab)
		end
		table.insert(tab, v)
		originIndex = originIndex + 1
	end
end

function FireBagView:initUI(ui)
	self.super.initUI(self, ui)	

	self.Panel_prefab				= TFDirector:getChildByPath(ui,"Panel_prefab")
	self.Panel_fireItem				= TFDirector:getChildByPath(ui,"Panel_fireItem")

	self.Button_close				= TFDirector:getChildByPath(ui,"Button_close")
	self.Button_close:onClick(function()
		AlertManager:closeLayer(self)
	end)

	self:refreshView()
end

function FireBagView:refreshView()
	self:initTableView()
end

function FireBagView:onShow()
	self.super.onShow(self)
	self:setupData()
	self.tableView:reloadData()	
end

function FireBagView:initTableView()
	self.tableView					= Utils:scrollView2TableView( TFDirector:getChildByPath(self.ui,"ScrollView"))
	self.tableView:setDirection(TFTableView.TFSCROLLVERTICAL)
	self.tableView:setVerticalFillOrder(TFTableView.TFTabViewFILLTOPDOWN)
	self.tableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.tableCellSize,self))
    self.tableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCells,self))
    self.tableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex,self))
end

function FireBagView:numberOfCells(tableView)

	return #self.data
end

function FireBagView:tableCellSize(tableView)

	local size = self.Panel_prefab:getContentSize()
	return size.height, size.width
end

function FireBagView:tableCellAtIndex(tableView, idx)

	local cell = tableView:dequeueCell()
    local item = nil
	if nil == cell then

        cell = TFTableViewCell:create()
        item = self.Panel_prefab:clone()
		item.idx = idx
        item:show()
        item:setPosition(ccp(0,0))
        cell:addChild(item)
        cell.item = item

		self:initCell(item, self.data[idx + 1])	
	else
		item = cell.item
    end
	self:updateCell(item, self.data[idx + 1])
    return cell
end

function FireBagView:initCell(item, data)
	for i=1, 5 do
		if data[i] then
			local itemPrefab = self.Panel_fireItem:clone()
			itemPrefab.Label_ItemCount = TFDirector:getChildByPath(itemPrefab, "Label_ItemCount")
			itemPrefab.Label_ItemCount:setText(GoodsDataMgr:getItemCount(data[i]))
			itemPrefab.Image_ItemBg = TFDirector:getChildByPath(itemPrefab, "Image_ItemBg"):hide()			
			local reward = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
			reward:setPosition(itemPrefab.Image_ItemBg:getPosition())	
			PrefabDataMgr:setInfo(reward, data[i], nil, nil, true)
			itemPrefab:addChild(reward)	
				
			item:addChild(itemPrefab)			
			item.reward = itemPrefab
			itemPrefab:setPosition(ccp(92 + (i -1) * 130, 10))
		end
	end
end

function FireBagView:updateCell(item, data)
	for i=1, 5 do
		if data[i] then
			PrefabDataMgr:setInfo(item.reward, data[i], GoodsDataMgr:getItemCount(data[i]))	
		end
	end
end

function FireBagView:registerEvents()
	self.super.registerEvents(self)
end


return FireBagView

--endregion
