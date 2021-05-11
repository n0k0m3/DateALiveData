local LeagueLevelUp = class("LeagueLevelUp", BaseLayer)


function LeagueLevelUp:ctor(data)
    self.super.ctor(self,data)

    self.heroid = data;
    self.curidx = 1;
    self.selectNum = 1;
	self.iconScale_ = 1
	self:showPopAnim(true)
    self:init("lua.uiconfig.fairyNew.fairyLevelUp")
end

function LeagueLevelUp:initData(data)
	self.speedTiming = 0
	self.timing = 0
	self.needTime = 0
	self.entryFalg = false
	self.isAddOp = false
	self.startUpdate = false
end

function LeagueLevelUp:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	LeagueLevelUp.ui = ui
	self:addLockLayer()

	self.panel_list 	= TFDirector:getChildByPath(ui,"Panel_scroll");
	self.Label_num		= TFDirector:getChildByPath(ui,"Label_num");
	self.Label_exp		= TFDirector:getChildByPath(ui,"Label_exp");
	self.Label_lv_old	= TFDirector:getChildByPath(ui,"Label_lv_old");
	self.Label_lv_cur	= TFDirector:getChildByPath(ui,"Label_lv_cur");
	self.LoadingBar_nextcur = TFDirector:getChildByPath(ui,"LoadingBar_nextcur")
	self.LoadingBar_curexp = TFDirector:getChildByPath(ui,"LoadingBar_curexp")

	--self.Button_close	= TFDirector:getChildByPath(ui,"Button_close");
	self.Button_cancel	= TFDirector:getChildByPath(ui,"Button_cancel");
	self.Button_ok		= TFDirector:getChildByPath(ui,"Button_ok");
	self.panel_item		= TFDirector:getChildByPath(ui,"Panel_item");
	self.Button_down	= TFDirector:getChildByPath(ui,"Button_down");
	self.Button_up		= TFDirector:getChildByPath(ui,"Button_up");
	--

    self.Panel_goodsItem =TFDirector:getChildByPath(ui,"Panel_goodsItem");

	local need = {562061 , 562062 , 562063 , 562064 ,562065}   --社团经验卡id配置写死  策划要求
	self.items = {}
	for k,v in pairs(need) do
		print("id = "..v)
		if GoodsDataMgr:getItemCount(v) > 0 then
			table.insert(self.items,{itemId = v,num = GoodsDataMgr:getItemCount(v)});
		end
	end

	self:initTableView();
	self.tableView:reloadData();

	self:updateUI(0);
end

function LeagueLevelUp:updateUI(num)
	if self.nextLv and self.nextLv >= LeagueDataMgr:getUnionMaxLevel() and num > 0 and self.selectNum < self.items[self.curidx].num then
		Utils:showTips(800074)
		self:stopTimer()
		return
	end

	if num > 0 then
		self.selectNum = math.min(self.selectNum + 1, self.items[self.curidx].num)
	elseif num < 0 then
		self.selectNum = math.max(self.selectNum - 1, 1)
	end

	self.Label_num:setString(self.selectNum);

	local exp = TabDataMgr:getData("Item",self.items[self.curidx].itemId).useProfit.val
	exp = exp * self.selectNum;

	self.Label_exp:setString(exp);
	local curLv = LeagueDataMgr:getUnionLevel()
	self.Label_lv_old:setString("Lv"..curLv);

	self.nextLv = LeagueDataMgr:calcLevelUp(exp);
	self.Label_lv_cur:setString("Lv"..self.nextLv);

	--
	local curExp = LeagueDataMgr:getUnionExp()
    local needexp = TabDataMgr:getData("ClubBaes",curLv).updateExp
    self.Label_exp:setString((curExp+exp).."/"..needexp)

    local curPerCent = curExp/needexp*100
	self.LoadingBar_curexp:setPercent(curPerCent)

	local nextPerCent = (curExp+exp)/needexp*100
	self.LoadingBar_nextcur:setPercent(nextPerCent)
	--

	if self.selectNum <= 1 or self.selectNum >= self.items[self.curidx].num then
		self:stopTimer()
		return
	end
end

function LeagueLevelUp:stopTimer()
	self.startUpdate = false
end

function LeagueLevelUp:resetUI()
	self.selectNum = 1;
	self:updateUI(0);
end

function LeagueLevelUp:registerEvents()
	-- self.Button_close:onClick(function ()
	-- 		print("close");
 --            AlertManager:close();
 --    	end)

    self.Button_cancel:onClick(function()
    		AlertManager:closeLayer(self)
    	end)

    self.Button_ok:onClick(function()
    		LeagueDataMgr:sendUseLeagueExpCard(self.items[self.curidx].itemId, self.selectNum)
    		
    		GameGuide:checkGuideEnd(self.guideFuncId)
    	end)

	self.Button_up:onTouch(function(event)
		if event.name == "began" then
			TFAudio.playSound(Utils:getKVP(1001,"ui_clickSound"))
			self:holdDownAction(true)
			self:onTouchButtonUp()
		elseif event.name == "ended" then
			self:stopTimer()
		end
	end)

	self.Button_down:onTouch(function(event)
		if event.name == "began" then
			TFAudio.playSound(Utils:getKVP(1001,"ui_clickSound"))
			self:holdDownAction(false)
			self:onTouchButtonDown()
		elseif event.name == "ended" then
			self:stopTimer()
		end
	end)

	
	self:addMEListener(TFWIDGET_ENTERFRAME,handler(self.update,self))
	EventMgr:addEventListener(self ,EV_ITEM_RESP_USE_ITEM_MOVE_UNION_EXP,handler(self.onRecvUseUpgradeCard,self))
end

function LeagueLevelUp:removeEvents()
    self:removeMEListener(TFWIDGET_ENTERFRAME)
end

function LeagueLevelUp:holdDownAction(isAddOp)
	self.speedTiming = 0
	self.timing = 0
	self.needTime = 0
	self.entryFalg = false
	self.isAddOp = isAddOp
	self.startUpdate = true
    
end

function LeagueLevelUp:update(target , dt)
	if self.startUpdate ~= true then
		return
	end
	self.timing = self.timing + dt
    self.speedTiming = self.speedTiming + dt
    if self.speedTiming >= 3.0 then
        self.entryFalg = true
        self.needTime = 0.01
    elseif self.speedTiming > 0.5 then
        self.entryFalg = true
        self.needTime = 0.05
    end
    if self.onTouchButtonUp and self.onTouchButtonDown then
		if self.entryFalg and self.timing >= self.needTime then
			if self.isAddOp then
				self:onTouchButtonUp()
			else
				self:onTouchButtonDown()
			end
            self.timing = 0
        end
	end
end

function LeagueLevelUp:onRecvUseUpgradeCard()
	local need = {562061 , 562062 , 562063 , 562064 ,562065}   --社团经验卡id配置写死  策划要求
	        self.items = {}
	        local isShowButton = false
	        for k,v in pairs(need) do
	            if GoodsDataMgr:getItemCount(v) > 0 then
	                isShowButton = true
	                break
	            end
	        end
	        if isShowButton == false then
	           
	        end
	        AlertManager:closeLayer(self)
end

function LeagueLevelUp:onTouchButtonDown()
	print("onTouchButtonDown")
	self:updateUI(-1)
end

function LeagueLevelUp:onTouchButtonUp()
	print("onTouchButtonUp")
	self:updateUI(1)
end

function LeagueLevelUp:initTableView()
    local  tableView =  TFTableView:create()
    tableView:setName("btnTableView")
    local tableViewSize = self.panel_list:getContentSize()
    tableView:setTableViewSize(CCSizeMake(tableViewSize.width, tableViewSize.height))
    tableView:setDirection(TFTableView.TFSCROLLHORIZONTAL)
    tableView:setPosition(self.panel_list:getPosition())
    tableView:setAnchorPoint(self.panel_list:getAnchorPoint());
    self.tableView = tableView

    self.tableView.logic = self

    tableView:addMEListener(TFTABLEVIEW_TOUCHED, LeagueLevelUp.tableCellTouched)
    tableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, LeagueLevelUp.cellSizeForTable)
    tableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, LeagueLevelUp.tableCellAtIndex)
    tableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, LeagueLevelUp.numberOfCellsInTableView)


    tableView:addMEListener(TFTABLEVIEW_CELLISBEGIN, LeagueLevelUp.cellBegin)
    tableView:addMEListener(TFTABLEVIEW_CELLISEND, LeagueLevelUp.cellEnd)


    self.panel_list:getParent():addChild(self.tableView,10)
end

function LeagueLevelUp.tableCellTouched(table,cell)
	local self = cell.logic;
	self.curidx = cell.idx;
	self:resetUI();
	if self.tableView then
		self.tableView:reloadData();
	end
end

function LeagueLevelUp.tableCellAtIndex(tab, idx)
	local self = tab.logic
	local cell = tab:dequeueCell();
	idx = idx +1
	if cell == nil then
		tab.cells = tab.cells or {}
		cell = TFTableViewCell:create();
		local item = self.Panel_goodsItem:clone()
        item:setScale(self.iconScale_)
		item:setAnchorPoint(CCPointMake(0,0))
		item:setPosition(CCPointMake(0, 0))
		cell:addChild(item);
		cell.item = item;
	end

    local item = cell.item
	if item then
        local Image_diban = TFDirector:getChildByPath(item, "Image_frame")
        local Image_icon = TFDirector:getChildByPath(item, "Image_icon")
        local Label_count = TFDirector:getChildByPath(item, "Label_count")
        local Image_select = TFDirector:getChildByPath(item, "Image_select")
        Image_select:setVisible(self.curidx == idx)

		local id 	= self.items[idx].itemId;
		local num 	= self.items[idx].num;

        local itemCfg = GoodsDataMgr:getItemCfg(id)
        Image_icon:setTexture(itemCfg.icon)
        Image_icon:setContentSize(CCSizeMake(90,90))        
        Image_diban:setTexture(EC_ItemIcon[itemCfg.quality])
        Image_diban:setContentSize(CCSizeMake(90,90));
        Label_count:setText(num)

        -- ListView_star:removeAllItems()

        for i=1,5 do
        	if itemCfg.star < i then
        		TFDirector:getChildByPath(item, "Image_star_"..i):hide();
        	end
        end

		-- local iconpath 	= TabDataMgr:getData("item",id).icon
		-- local icon 	 = TFDirector:getChildByPath(cell.item,"Image_icon");
		-- local numLab = TFDirector:getChildByPath(cell.item,"Label_num");
		-- icon:setTexture(iconpath);
		-- numLab:setString(num);

		-- local back = TFDirector:getChildByPath(cell.item,"Image_bg");
		-- if self.curidx == idx then
		-- 	back:setTexture("ui/fairy/034.png");
		-- else
		-- 	back:setTexture("ui/fairy/033.png");
		-- end
	end

	cell.idx = idx
	cell.logic = self;
	return cell;
end

function LeagueLevelUp.numberOfCellsInTableView(table)
	local self = table.logic
	return #self.items;
end

function LeagueLevelUp.cellBegin(table)
	local self = table.logic
end

function LeagueLevelUp.cellEnd(table)
	local self = table.logic
end

function LeagueLevelUp.cellSizeForTable(table,idx)
	self = table.logic
	-- return self.panel_item:getSize().width,self.panel_item:getSize().height
    local size = self.Panel_goodsItem:getContentSize()
    local width = size.width * self.iconScale_
    local height = size.height * self.iconScale_
    return width, height
end

function LeagueLevelUp:onHide()
	self:stopTimer()
	self.super.onHide(self)
end

function LeagueLevelUp:removeUI()
	self.super.removeUI(self)
end

function LeagueLevelUp:onShow()
	self.super.onShow(self)
	self:removeLockLayer()
    self:timeOut(function()
        if GameGuide:checkGuide(self) then
            if self.blockUI then
                self.blockUI:setBackGroundColorOpacity(50)
            end
        end
    end, 0)
end

function LeagueLevelUp:onClose()
	self:stopTimer()
	self.super.onClose(self)
end


return LeagueLevelUp;
