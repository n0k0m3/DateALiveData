local ShowMail = class("ShowMail", BaseLayer)


function ShowMail:ctor(data)
    self.super.ctor(self,data)
    self.id = data
    self.index = MailDataMgr:getMailShowIndex(data);
    self.mailInfo		= MailDataMgr:getOneMail(self.index);
    self:showPopAnim(true)
    self:init("lua.uiconfig.mail.showMail")
end

function ShowMail:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	ShowMail.ui = ui

	self.Button_cancel	= TFDirector:getChildByPath(ui,"Button_cancel");
	self.Button_ok		= TFDirector:getChildByPath(ui,"Button_ok");
	self.panel_list 	= TFDirector:getChildByPath(ui,"ScrollView_list");
	self.panel_item 	= TFDirector:getChildByPath(ui,"Image_item");
	self.Panel_fujian 	= TFDirector:getChildByPath(ui,"Panel_fujian");
	self.Label_title	= TFDirector:getChildByPath(ui,"Label_title"); 
	self.Label_time		= TFDirector:getChildByPath(ui,"Label_time");
	self.Label_content	= TFDirector:getChildByPath(ui,"tips2");
	self.Label_button 	= TFDirector:getChildByPath(ui,"Label_button");
	self.contentPanel	= TFDirector:getChildByPath(ui,"contentPanel");
	self.Button_copy		= TFDirector:getChildByPath(ui,"Button_copy"):hide()
	--self.mailInfo		= MailDataMgr:getOneMail(self.index);


	self:initTableView();
	if self.mailInfo.status > 0 or self.mailInfo.mailType == 2 then
		self:updateUI();
	end
	--self.tableView:reloadData();
end

function ShowMail:updateUI()
	self.index 			= MailDataMgr:getMailShowIndex(self.id);
	self.mailInfo		= MailDataMgr:getOneMail(self.index);

	if self.mailInfo.isStrId then
		self.Label_title:setString(self.mailInfo.title);
	else
		self.Label_title:setTextById(self.mailInfo.title);
	end
	-- if self.mailInfo.title == "应援集结 豪礼" then
	if self.mailInfo.title == TextDataMgr:getText(213006) or self.mailInfo.title == TextDataMgr:getText(213216) then
		self.Button_copy:show()
		self.Button_copy:onClick(function()
		    -- local param1, param2 = string.find(self.mailInfo.body, "码为")
		    local param1, param2 = string.find(self.mailInfo.body, TextDataMgr:getText(600023))
		    local code;
		    if self.mailInfo.title == TextDataMgr:getText(213006) then
		    	code = string.sub(self.mailInfo.body, param2 + 1, param2 + 9)
		    elseif self.mailInfo.title == TextDataMgr:getText(213216) then
		    	code = string.sub(self.mailInfo.body, param2 + 1, param2 + 10)
		    end
	        TFDeviceInfo:copyToPasteBord(code)
	        Utils:showTips(600010)
    	end)
	end

	local Label_content = TFLabel:create();
	Label_content:setFontName(self.Label_content:getFontName());
	Label_content:setFontSize(self.Label_content:getFontSize());
	Label_content:setAnchorPoint(ccp(0,1));
	Label_content:setDimensions(335, 0)
	Label_content:setTextHorizontalAlignment(0)

	local strBody = ""
	if self.mailInfo.isStrId then
		strBody = self.mailInfo.body
	else
		strBody = TextDataMgr:getText( self.mailInfo.body)
	end
	local exchangeStr	= string.gsub(strBody, "\\n", "\n")
	Label_content:setString(exchangeStr);
	self.Label_content:hide();
	local inner = self.contentPanel:getInnerContainer();
	local innerSize = inner:getSize();
	local LabelSize = Label_content:getSize();
	inner:addChild(Label_content);

	if LabelSize.height > innerSize.height then
		inner:setSize(LabelSize);
	end

	Label_content:setPosition(ccp(0,inner:getSize().height));
	self.contentPanel:jumpToTop();


	local timeData = Utils:getTimeData( self.mailInfo.createTime )
	self.Label_time:setTextById(600024,timeData.Month,timeData.Day)

	self.Panel_fujian:setVisible(self.mailInfo.rewards and table.count(self.mailInfo.rewards) ~= 0);

	if self.mailInfo.rewards and table.count(self.mailInfo.rewards) ~= 0 then
		self.tableView:reloadData();
		if self.mailInfo.status == 2 then
			self.Label_button:setTextById(600025);
			Utils:setNodeGray(self.Button_ok,true);
			self.Button_ok:setTouchEnabled(false);
		end
	else
		self.Label_button:setTextById(600026);
	end
end

function ShowMail:registerEvents()
	
    self.Button_cancel:onClick(function ()
            AlertManager:close();
    end)

    self.Button_ok:onClick(function()
    		--AlertManager:changeScene(SceneType.MainScene);
    		if self.mailInfo.rewards and table.count(self.mailInfo.rewards) ~= 0 then
    			MailDataMgr:operationMail(self.index,2,false);
    			AlertManager:close();
    			return
    		end
    		AlertManager:close();
    	end)
end

function ShowMail:initTableView()
    local  tableView =  TFTableView:create()
    tableView:setName("btnTableView")
    local tableViewSize = self.panel_list:getContentSize()
    tableView:setTableViewSize(CCSizeMake(tableViewSize.width, tableViewSize.height))
    tableView:setDirection(TFTableView.TFSCROLLHORIZONTAL)
    tableView:setPosition(self.panel_list:getPosition())
    tableView:setAnchorPoint(self.panel_list:getAnchorPoint());
    self.tableView = tableView

    self.tableView.logic = self

    tableView:addMEListener(TFTABLEVIEW_TOUCHED, ShowMail.tableCellTouched)
    tableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, ShowMail.cellSizeForTable)
    tableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, ShowMail.tableCellAtIndex)
    tableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, ShowMail.numberOfCellsInTableView)


    tableView:addMEListener(TFTABLEVIEW_CELLISBEGIN, ShowMail.cellBegin)
    tableView:addMEListener(TFTABLEVIEW_CELLISEND, ShowMail.cellEnd)


    self.panel_list:getParent():addChild(self.tableView,10)
end

function ShowMail.tableCellTouched(table,cell)
	local self = cell.logic;
	-- if self.tableView then
	-- 	self.tableView:reloadData();
	-- end
end

function ShowMail.tableCellAtIndex(tab, idx)
	local self = tab.logic
	local cell = tab:dequeueCell();
	idx = idx +1
	if cell == nil then
		tab.cells = tab.cells or {}
		cell = TFTableViewCell:create();
		local item = self.panel_item:clone()
		item:setAnchorPoint(CCPointMake(0,0))
		item:setPosition(CCPointMake(0, 0))
		cell:addChild(item);
		cell.item = item;
	end

    local item = cell.item
	if item then
     	self:updateOneReward(item,idx)
	end

	cell.idx = idx
	cell.logic = self;
	return cell;
end

local statusIconPath = {
	[0] = "icon/system/051.png",
	[1] = "icon/system/052.png",
	[2] = "icon/system/052.png",
	[3] = "icon/system/052.png",
}

function ShowMail:updateOneReward(item,idx)
	item:removeAllChildren()
	local info = self.mailInfo.rewards[idx];
	local id = info.id;
	local num = info.num;

	local Panel_goodsItem= PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
	PrefabDataMgr:setInfo(Panel_goodsItem, id,num)
	Panel_goodsItem:setPosition(ccp(41,41))
	Panel_goodsItem:setScale(0.8)
	Panel_goodsItem:setAnchorPoint(me.p(0.5,0.5))
	item:addChild(Panel_goodsItem)
	item:setSize(CCSizeMake(82,82))
	--[[local config = GoodsDataMgr:getItemCfg(id);

	local Image_icon = TFDirector:getChildByPath(item,"Image_icon");
	Image_icon:setTexture(config.icon);
	Image_icon:setSize(CCSizeMake(64,64));

	local Label_num = TFDirector:getChildByPath(item,"Label_num");
	Label_num:setString("x"..num);

	item:setTexture(EC_ItemIcon[config.quality]);
	item:setSize(CCSizeMake(82,82));]]
end

function ShowMail.numberOfCellsInTableView(table)
	local self = table.logic
	return #(self.mailInfo.rewards);
end

function ShowMail.cellBegin(table)
	local self = table.logic
end

function ShowMail.cellEnd(table)
	local self = table.logic
end

function ShowMail.cellSizeForTable(table,idx)
	self = table.logic
	-- return self.panel_item:getSize().width,self.panel_item:getSize().height
    local size = self.panel_item:getContentSize()
    local width = size.width
    local height = size.height
    return width,height
end

function ShowMail:onHide()
	self.super.onHide(self)
end

function ShowMail:removeUI()
	self.super.removeUI(self)
end

return ShowMail;
