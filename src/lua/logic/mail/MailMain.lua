local MailMain = class("MailMain", BaseLayer)



local showStyle ={
	[1] = {
		tabIcon = "ui/mail/mail_05.png",
		tipIcon = "ui/mail/mail_11.png",
		tabNameStringId = 600003,
		tipStringId = 63656,
		maxEmail = TabDataMgr:getData("DiscreteData", 16001).data.maxEmail,
	},
	[2] = {
		tabIcon = "ui/mail/mail_26.png",
		tipIcon = "ui/mail/mail_27.png",
		tabNameStringId = 63654,
		tipStringId = 63655,
		maxEmail = TabDataMgr:getData("DiscreteData", 90009).data.mailUpperLimit,
	}
}

function MailMain:ctor(data)
    self.super.ctor(self,data)
    self.mailType = 1
    MailDataMgr:initShowList(self.mailType)
    self:init("lua.uiconfig.mail.mailMain")
end

function MailMain:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	MailMain.ui = ui

	self.Button_system	= TFDirector:getChildByPath(ui,"Button_system"):hide()
	self.Button_oneKey	= TFDirector:getChildByPath(ui,"Button_oneKey")
	local Panel_bottom = TFDirector:getChildByPath(ui,"Panel_bottom")
	self.Button_remove_all	= TFDirector:getChildByPath(Panel_bottom,"Button_remove_all"):hide()
	self.panel_list = TFDirector:getChildByPath(ui,"ScrollView_mailMain_1");
	local panel_tab_list = TFDirector:getChildByPath(ui,"ScrollView_mailMain_2");
	self.uiList_tab = UIListView:create(panel_tab_list)
	self.panel_item = TFDirector:getChildByPath(ui,"Panel_item");
	self.Label_tips = TFDirector:getChildByPath(ui,"Label_tips")
	self.Label_count = TFDirector:getChildByPath(ui,"Label_count")
	self.Image_bottom_icon = TFDirector:getChildByPath(ui,"Image_bottom_icon")


	self:initTableView();
	self:updateUI()
end

function MailMain:updateUI()
	self:updateTabList()
	self.Label_tips:setTextById(showStyle[self.mailType].tipStringId)
	self.Image_bottom_icon:setTexture(showStyle[self.mailType].tipIcon)
	MailDataMgr:initShowList(self.mailType);
	self.tableView:reloadData();
	self:updateUnReceiveCount()
end

function MailMain:updateUnReceiveCount()

	local totalCount = MailDataMgr:getMailCount(self.mailType)
	local count = MailDataMgr:getMailUnReceiveCount(self.mailType)
	self.Label_count:setText("("..totalCount.."/"..showStyle[self.mailType].maxEmail..")")
	if totalCount < 1 then
		self.Button_remove_all:hide()
	else
		self.Button_remove_all:hide()
	end
end

function MailMain:registerEvents()
	EventMgr:addEventListener(self,EV_OPERATION_MAIL,handler(self.updateUI, self));
	
    self.Button_oneKey:onClick(function()
    		MailDataMgr:onKeyGet(self.mailType)
    	end)
    self.Button_remove_all:onClick(function()
    		if MailDataMgr:getMailCount(self.mailType) < 1 then
    			return
    		end
	    	local function realRemoveAll()
				MailDataMgr:removeAllReceivedMail(self.mailType)
			end
			if MainPlayer:getOneLoginStatus(EC_OneLoginStatusType.ReConfirm_MailDelete) then
				realRemoveAll()
			else
				Utils:openView("common.ReConfirmTipsView", {tittle = 600013, content = TextDataMgr:getText(600012), reType = EC_OneLoginStatusType.ReConfirm_MailDelete, confirmCall = realRemoveAll})
			end
    	end)
end

function MailMain:onConnectFail()
	MailDataMgr:onLoginOut();
end

function MailMain:initTableView()
    local  tableView =  TFTableView:create()
    tableView:setName("btnTableView")
    local tableViewSize = self.panel_list:getContentSize()
    tableView:setTableViewSize(CCSizeMake(tableViewSize.width, tableViewSize.height))
    tableView:setDirection(TFTableView.TFSCROLLVERTICAL)
    tableView:setPosition(self.panel_list:getPosition())
    tableView:setAnchorPoint(self.panel_list:getAnchorPoint());

    self.tableView = tableView

    self.tableView.logic = self

    tableView:addMEListener(TFTABLEVIEW_TOUCHED, MailMain.tableCellTouched)
    tableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, MailMain.cellSizeForTable)
    tableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, MailMain.tableCellAtIndex)
    tableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, MailMain.numberOfCellsInTableView)


    tableView:addMEListener(TFTABLEVIEW_CELLISBEGIN, MailMain.cellBegin)
    tableView:addMEListener(TFTABLEVIEW_CELLISEND, MailMain.cellEnd)

    self.panel_list:getParent():addChild(self.tableView,10)
end

function MailMain:updateTabList(  )
	-- body
	local typeList = MailDataMgr:getMailTyps()
	table.sort(typeList,function ( a,b )
		return a < b
	end)
	if table.find(typeList,self.mailType) == -1 then
		self.mailType = 1
	end

	self.uiList_tab:removeAllItems()
	for k,v in pairs(typeList) do
		local tabItem = self.Button_system:clone()
		tabItem:show()
		tabItem:setPosition(ccp(0,0))
		local Image_system = TFDirector:getChildByPath(tabItem,"Image_icon")
		local Label_system = TFDirector:getChildByPath(tabItem,"Label_name")
		local Image_select = TFDirector:getChildByPath(tabItem,"Image_select")
		local redPoint = TFDirector:getChildByPath(tabItem,"redPoint")
		Image_system:setTexture(showStyle[v].tabIcon)
		Label_system:setTextById(showStyle[v].tabNameStringId)
		Image_select:setVisible(v == self.mailType)
		self.uiList_tab:pushBackCustomItem(tabItem)

		local showRedPoint = MailDataMgr:checkRedPointByMailType(v)
		redPoint:setVisible(showRedPoint)
		tabItem:onClick(function ( ... )
			if self.mailType == v then return end
			self.mailType = v
			self:updateUI()
		end)
	end
end

function MailMain.tableCellTouched(table,cell)
	local self = cell.logic;
end

function MailMain.tableCellAtIndex(tab, idx)
	local self = tab.logic
	local cell = tab:dequeueCell();
	idx = idx +1
	if cell == nil then
		tab.cells = tab.cells or {}
		cell = TFTableViewCell:create();
		local item = self.panel_item:clone()
		item:setAnchorPoint(CCPointMake(0,0))
		item:setPosition(CCPointMake(0,-10))
		cell:addChild(item);
		cell.item = item;
	end

    local item = cell.item
	if item then
     	self:updateOneMail(item,idx);
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

function MailMain:updateOneMail(item,idx)
	local mailInfo = MailDataMgr:getOneMail(idx);
	local Image_icon = TFDirector:getChildByPath(item,"Image_icon");
	Image_icon:setTexture(statusIconPath[mailInfo.status]);
	Image_icon:setScale(0.8)

	local haveReward = MailDataMgr:getMailHaveRewards(idx)
	if haveReward and mailInfo.status ~= 2 then
		local info = mailInfo.rewards[1];
		local id = info.id;
		local num = info.num;

		local config = GoodsDataMgr:getItemCfg(id);
		if config then
			Image_icon:setTexture(config.icon);
		end
		-- Image_icon:setSize(CCSizeMake(64,64));
	end

	local Label_title = TFDirector:getChildByPath(item,"Label_title");
	local Image_new	  = TFDirector:getChildByPath(item,"Image_new");
	if mailInfo.isStrId then
		Label_title:setString(mailInfo.title);
	else
		Label_title:setTextById(mailInfo.title);
	end
	Image_new:setVisible(mailInfo.status == 0)

	local Label_yidu	  = TFDirector:getChildByPath(item,"Label_yidu");
	Label_yidu:setVisible(mailInfo.status == 2)

	local Label_concent = TFDirector:getChildByPath(item,"Label_concent");
	
	local strBody = ""
	if mailInfo.isStrId then
		strBody = mailInfo.body
	else
		strBody = TextDataMgr:getText( mailInfo.body)
	end
	local exchangeStr	= string.gsub(strBody, "\\n", "\n")
	Label_concent:setString(exchangeStr);

	local Label_time  	= TFDirector:getChildByPath(item,"Label_time");
	Label_time:setString(Utils:howManyTimeAgo(mailInfo.createTime));

	local btnRemove		= TFDirector:getChildByPath(item,"Button_remove");
	btnRemove:onClick(function()
		local function reaRemove()
			MailDataMgr:operationMail(idx,3)
		end
		if MainPlayer:getOneLoginStatus(EC_OneLoginStatusType.ReConfirm_MailDelete) then
			reaRemove()
		else
			Utils:openView("common.ReConfirmTipsView", {tittle = 600013, content = TextDataMgr:getText(600012), reType = EC_OneLoginStatusType.ReConfirm_MailDelete, confirmCall = reaRemove})
		end

	end);

	btnRemove:setVisible(not (haveReward and mailInfo.status ~= 2))
	btnRemove:hide()

	local btnSee		= TFDirector:getChildByPath(item,"Button_see");
	btnSee:onClick(function()
			mailInfo = MailDataMgr:getOneMail(idx);
            if mailInfo.status == 0 then
				MailDataMgr:operationMail(idx,1);
			else
				Utils:openView("mail.ShowMail",MailDataMgr:getMailId(idx))
			end
		end)

	local Button_get 	= TFDirector:getChildByPath(item,"Button_get");
	Button_get:onClick(function()
			MailDataMgr:operationMail(idx,2);
		end)

	Button_get:setVisible(haveReward and mailInfo.status ~= 2)

	local Image_fujian 	= TFDirector:getChildByPath(item,"Image_fujian");
	--Image_fujian:setVisible(haveReward and mailInfo.status ~= 2)
	--附件标签全部屏蔽
	Image_fujian:hide()
end

function MailMain.numberOfCellsInTableView(table)
	local self = table.logic
	return MailDataMgr:getMailCount(self.mailType);
end

function MailMain.cellBegin(table)
	local self = table.logic
end

function MailMain.cellEnd(table)
	local self = table.logic
end

function MailMain.cellSizeForTable(table,idx)
	self = table.logic
	-- return self.panel_item:getSize().width,self.panel_item:getSize().height
    local size = self.panel_item:getContentSize()
    local width = size.width
    local height = size.height
    return height,width
end

function MailMain:onHide()
	self.super.onHide(self)
end

function MailMain:removeUI()
	self.super.removeUI(self)
end

return MailMain;
