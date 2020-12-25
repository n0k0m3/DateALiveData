--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
* 特殊邮件查看界面
* 
]]

local SpecialMail = class("SpecialMail", BaseLayer)

function SpecialMail:ctor(data)
    self.super.ctor(self,data)
    self:showPopAnim(true)
    self:initData(data)
    self:init("lua.uiconfig.mail.SpecialMail")
end

function SpecialMail:initData(data)
    self.id = data
    self.index = MailDataMgr:getMailShowIndex(data)
    self.mailInfo = clone(MailDataMgr:getOneMail(self.index))

    local rewards = self.mailInfo.rewards or {}
	for i = #rewards, 1, -1 do
		local item = self.mailInfo.rewards[i]
		local itemCfg = GoodsDataMgr:getItemCfg(item.id)
		if itemCfg and itemCfg.isHide then
			table.remove(self.mailInfo.rewards, i)
		end
	end
end

function SpecialMail:initUI(ui)
    self.super.initUI(self, ui)

    self.btn_close = TFDirector:getChildByPath(ui, "btn_close")
    self.scroll_content = TFDirector:getChildByPath(ui, "scroll_content")
    self.txt_content = TFDirector:getChildByPath(ui, "txt_content")
    self.txt_time = TFDirector:getChildByPath(ui, "txt_time")
    self.panel_reward = TFDirector:getChildByPath(ui, "panel_reward")
    self.panel_list = TFDirector:getChildByPath(ui, "panel_list")
    self.btn_get = TFDirector:getChildByPath(ui, "btn_get")

    self.panel_item = TFDirector:getChildByPath(ui, "panel_item"):hide()

    self:initTableView()

    self:updateUI()
end

function SpecialMail:initTableView()
	self.tableView = TFTableView:create()
    self.tableView:setTableViewSize(self.panel_list:getContentSize())
    self.tableView:setDirection(TFTableView.TFSCROLLHORIZONTAL)
    self.tableView:setVerticalFillOrder(TFTableView.TFTabViewFILLTOPDOWN)

    self.tableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, self.cellSizeForTable)
    self.tableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, self.tableCellAtIndex)
    self.tableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, self.numberOfCellsInTableView)

    self.tableView.logic = self
    self.panel_list:addChild(self.tableView)
end

function SpecialMail.cellSizeForTable(table, idx)
	local self = table.logic
	local itemCellSize = self.panel_item:getContentSize()
	return itemCellSize.height, itemCellSize.width
end

function SpecialMail.tableCellAtIndex(table, idx)
    local cell = table:dequeueCell()
    local self = table.logic

    if nil == cell then
        cell = TFTableViewCell:create()
    	local itemCell = self.panel_item:clone()
    	itemCell:setVisible(true)
    	itemCell:setPosition(ccp(0, 0))
    	cell.itemCell = itemCell
    	cell:addChild(itemCell)
    end

    self:updateItem(cell.itemCell, idx + 1)

    return cell
end

function SpecialMail:updateItem(item, idx)
	local mail_item = TFDirector:getChildByPath(item, "mail_item")
	local img_icon = TFDirector:getChildByPath(item, "img_icon")
	local txt_num = TFDirector:getChildByPath(item, "txt_num")
	local info = self.mailInfo.rewards[idx]
	local itemCfg = GoodsDataMgr:getItemCfg(info.id)
	img_icon:setTexture(itemCfg.icon)
	txt_num:setText(info.num)

	mail_item:setTouchEnabled(true)
	mail_item:onClick(function()
        Utils:showInfo(info.id)
    end)
end

function SpecialMail.numberOfCellsInTableView(table)
	local self = table.logic
	return #(self.mailInfo.rewards)
end

function SpecialMail:updateUI()
	self.index = MailDataMgr:getMailShowIndex(self.id)
	self.mailInfo = MailDataMgr:getOneMail(self.index)

	local exchangeStr = string.gsub(self.mailInfo.body, "\\n", "\n")
	self.txt_content:setString(exchangeStr)

	local scrollSize = self.scroll_content:getContentSize()
	local txtSize = self.txt_content:getSize()
	local realHeight = scrollSize.height
	if txtSize.height > scrollSize.height then
		realHeight = txtSize.height
		self.scroll_content:setInnerContainerSize(CCSize(scrollSize.width, txtSize.height))
	end
	self.txt_content:setPosition(ccp(0, realHeight))

	local timeData = Utils:getTimeData(self.mailInfo.createTime)
	self.txt_time:setTextById(600024, timeData.Month, timeData.Day)

	self.panel_reward:setVisible(self.mailInfo.rewards and table.count(self.mailInfo.rewards) ~= 0)

	if self.mailInfo.rewards and table.count(self.mailInfo.rewards) ~= 0 then
		self.tableView:reloadData()
		if self.mailInfo.status == 2 then
			Utils:setNodeGray(self.btn_get, true)
			self.btn_get:setTouchEnabled(false)
		end
	end
end

function SpecialMail:registerEvents()
	self.btn_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.btn_get:onClick(function()
		if self.mailInfo.rewards and table.count(self.mailInfo.rewards) ~= 0 then
			MailDataMgr:operationMail(self.index, 2, false)
			AlertManager:closeLayer(self)
			return
		end
		AlertManager:closeLayer(self)
	end)
end

function SpecialMail:removeUI()
	self.super.removeUI(self)
end

return SpecialMail
