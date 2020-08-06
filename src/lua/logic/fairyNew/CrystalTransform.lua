local CrystalTransform = class("CrystalTransform", BaseLayer)

local ShowType = {
	ALL = 1,
	ONE = 2,
	TWO = 3,
	THREE = 4,
	FOUR  = 5,
	FIVE  = 6
}

local ShowTypeText = {
	[ShowType.ALL] = 494002,
	[ShowType.ONE] = 494003,
	[ShowType.TWO] = 494004,
	[ShowType.THREE] = 494005,
	[ShowType.FOUR] = 494006,
	[ShowType.FIVE] = 494007,
}
function CrystalTransform:ctor(data)
	self.super.ctor(self,data)
	self.selectedIcon = nil;
	self.selectedCrystal = nil;
	self.selectNum = 0;
	self.showType = ShowType.ALL
	self.isOpen = false;
	self:initData();
	self:setUsepreProcesUI()
    self:init("lua.uiconfig.fairyNew.crystalTransform")
end

function CrystalTransform:initData()
	self.exchangeTab = TabDataMgr:getData("EvolutionMaterial");
	self.crystals = {};
	local items = GoodsDataMgr:getItem();
	self.items = items;
	for k,v in pairs(self.exchangeTab) do
		if items[k] then
			for k2,v2 in pairs(items[k]) do
				table.insert(self.crystals,v2);
			end
		end
	end
	self.selectList = {};
	self:initLeftShowList();
	dump(self.crystals)
end

function CrystalTransform:sortList(list)
	table.sort(list,function(a,b)
			return a.cid > b.cid;
		end)
end

function CrystalTransform:initLeftShowList()
	self.showList = {};
	if self.showType == ShowType.ALL then
		self.showList = clone(self.crystals);
	else
		for k,v in pairs(self.crystals) do
			local cfg 	= TabDataMgr:getData("Item",v.cid)
			local star 	= cfg.star;
			if star == self.showType - 1 then
				local t = clone(v)
				for i,v2 in ipairs(self.selectList) do
					if v2.cid == t.cid then
						t.num = v.num - v2.num
						break;
					end
				end

				if t.num > 0 then
					table.insert(self.showList,t);
				end
			end
		end
	end

	self:sortList(self.showList);
end

function CrystalTransform:initUI(ui)
	self.super.initUI(self,ui)
	CrystalTransform.ui = ui

	print("99999999999999999999999999999",table.count(self._ui))
	self.HavelistView = UIListView:create(self._ui.ScrollView_crystal);
	self.selectListView = UIListView:create(self._ui.ScrollView_select);
	self.selectNumLab = self._ui.Panel_batch:getChildByName("Label_num");
	self.selectNumLab:setText(0);

	self._ui.Panel_buttons:hide();
	self.Image_buttons = TFDirector:getChildByPath(ui,"Image_buttons")

	self:updateButtonState();

	self:updateLeft();
	self:updateGetUI();
end


function CrystalTransform:onTouchButtonOpen()
    if self.isOpen then
        self.isOpen = false
        self.Image_buttons:runAction(CCMoveTo:create(0.1,ccp(60,373)))
    else
        self.isOpen = true
        self.Image_buttons:runAction(CCMoveTo:create(0.1,ccp(60,150)))
    end
end


function CrystalTransform:updateLeft()
	local cell = math.ceil(#self.showList / 4 )
	local items = self.HavelistView:getItems();
	if #items > cell then
		for i=1,#items - cell do
			self.HavelistView:removeLastItem();
		end
	else
		for i=1,cell do
			local item = self.HavelistView:getItem(i);
			if not item then
				local item = self._ui.Panel_item:clone();
				self.HavelistView:pushBackCustomItem(item);
			end
		end
	end

	local index = 0;
	for i=1,cell do
		local item = self.HavelistView:getItem(i)
		for i=1,4 do
			local subItem = item:getChildByName("item"..i):show();
			index = index + 1;
			if self.showList[index] then
				self:updateOneItem(subItem,self.showList[index]);
			else
				subItem:hide();
			end
		end
	end
end

function CrystalTransform:updateRight()
	local cell = math.ceil(#self.selectList / 4 )

	local items = self.selectListView:getItems();
	if #items > cell then
		for i=1,#items - cell do
			self.selectListView:removeLastItem();
		end
	else
		for i=1,cell do
			local item = self.selectListView:getItem(i);
			if not item then
				local item = self._ui.Panel_item:clone();
				self.selectListView:pushBackCustomItem(item);
			end
		end
	end

	local index = 0;
	for i=1,cell do
		local item = self.selectListView:getItem(i);
		for i=1,4 do
			local subItem = item:getChildByName("item"..i):show();
			index = index + 1;
			if self.selectList[index] then
				self:updateOneItem(subItem,self.selectList[index]);
			else
				subItem:hide();
			end
		end
	end
end

function CrystalTransform:updateGetUI()
	local cfg = TabDataMgr:getData("Item",510241);
	local Label_num = self._ui.item_get:getChildByName("Label_num");
	Label_num:setText(self:calcGetNum());

	local Image_select = self._ui.item_get:getChildByName("Image_select"):hide();
	local Image_crystal = self._ui.item_get:getChildByName("Image_crystal");
	Image_crystal:setTexture(cfg.icon);
	local Image_back 	= self._ui.item_get:getChildByName("Image_back");
	Image_back:setTexture(EC_ItemIcon[cfg.quality])
end

function CrystalTransform:updateOneItem(item,data)
	local cfg 	= TabDataMgr:getData("Item",data.cid)
	local star 	= cfg.star;
	for i=1,5 do
	 	if i > star then
	 		item:getChildByName("Image_star"..i):hide();
	 	else
	 		item:getChildByName("Image_star"..i):show();
	 	end
	end

	local Label_num = item:getChildByName("Label_num");
	Label_num:setText(data.num);

	local Image_select = item:getChildByName("Image_select"):hide();
	local Image_crystal = item:getChildByName("Image_crystal");
	Image_crystal:setTexture(cfg.icon);
	local Image_back 	= item:getChildByName("Image_back");
	Image_back:setTexture(EC_ItemIcon[cfg.quality])
	if self.selectedCrystal == data.cid then
		self.selectedIcon = Image_select:show();
	end

	item:setTouchEnabled(true);
	item:onClick(function()
			if self.selectedCrystal ~= data.cid then
				self.selectedCrystal = data.cid;
				self.selectNum = self:getSelectNum();
				self.selectNumLab:setText(self.selectNum);
				self:updateUI();
			end
		end)
end

function CrystalTransform:getSelectNum()
	if not self.selectedCrystal then
		return 0;
	end

	for k,v in pairs(self.selectList) do
		if v.cid == self.selectedCrystal then
			return v.num;
		end
	end

	return 0;
end

function CrystalTransform:getMaxCnt()
	if self.selectedCrystal then
		for k,v in pairs(self.crystals) do
			if v.cid == self.selectedCrystal then
				return v.num;
			end
		end
	end
	return 0;
end

function CrystalTransform:calcShowList()
	local isFindLeft = false;
	for k,v in pairs(self.showList) do
		if v.cid == self.selectedCrystal then
			isFindLeft = true;
			v.num = self.items[v.cid][v.id].num - self.selectNum;
			if v.num <= 0 then
				table.remove(self.showList,k);
			end
			break;
		end
	end

	if not isFindLeft then
		local t = clone(self.items[self.selectedCrystal])
		for k,v in pairs(t) do
			t = clone(v);
		end
		if t.num - self.selectNum >= 1 and (t.star == self.showType - 1 or self.showType == ShowType.ALL) then
			t.num = t.num - self.selectNum;
			table.insert(self.showList,t);
		end
	end

	self:sortList(self.showList);
end

function CrystalTransform:calcSelectList()
	local isFindRight = false;
	for k,v in pairs(self.selectList) do
		if v.cid == self.selectedCrystal then
			isFindRight = true;
			v.num = self.selectNum;
			if v.num <= 0 then
				table.remove(self.selectList,k);
			end
			break;
		end
	end

	if not isFindRight and self.selectNum > 0 then
		local t = clone(self.items[self.selectedCrystal])
		for k,v in pairs(t) do
			t = clone(v);
		end
		t.num = self.selectNum;
		table.insert(self.selectList,t);
	end

	self:sortList(self.selectList);
end

function CrystalTransform:calcGetNum()
	local ret = 0;
	for k,v in pairs(self.selectList) do
		local exchangeData = self.exchangeTab[v.cid];
		for k2,v2 in pairs(exchangeData.decompose) do
		 	ret = ret + v2 * v.num 
		end 
	end

	return ret;
end

function CrystalTransform:updateUI()
	if not self.selectedCrystal then
		return;
	end
	self:calcShowList();
	self:calcSelectList();
	self:updateLeft();
	self:updateRight();
	self:updateGetUI();
end

function CrystalTransform:updateBatchPanel(num)

    self.selectNum = self.selectNum + num;
    if self.selectNum <= 0 then
        self.selectNum = 0;
    end

    local maxCnt = self:getMaxCnt()
    if self.selectNum >= maxCnt then
        self.selectNum = maxCnt
    end

    self.selectNumLab:setString(self.selectNum);

    self:updateUI()
end

function CrystalTransform:onTouchButtonDown()
    self:updateBatchPanel(-1)
end

function CrystalTransform:onTouchButtonUp()
    self:updateBatchPanel(1)
end

function CrystalTransform:holdDownAction(isAddOp)
    local speedTiming = 0
    local timing = 0
    local needTime = 0
    local entryFalg = false

    local function action(dt)
        timing = timing + dt
        speedTiming = speedTiming + dt
        if speedTiming >= 3.0 then
            entryFalg = true
            needTime = 0.01
        elseif speedTiming > 0.5 then
            entryFalg = true
            needTime = 0.05
        end
        if entryFalg and timing >= needTime then
            if isAddOp then
                self:onTouchButtonUp()
            else
                self:onTouchButtonDown()
            end
            timing = 0
        end
    end

    self.timer = TFDirector:addTimer(0, -1, nil, action)
end

function CrystalTransform:registerEvents()
	self._ui.Button_up:onTouch(function(event)
        if event.name == "ended" then
            TFDirector:removeTimer(self.timer)
            self.timer = nil;
            if not self.selectedCrystal then
				Utils:showTips(494008);
				return;
			end
        end
        if event.name == "began" then
            TFAudio.playSound(Utils:getKVP(1001,"ui_clickSound"))
            self:onTouchButtonUp();
            self:holdDownAction(true)
        end
    end)

    self._ui.Button_down:onTouch(function(event)
        if event.name == "ended" then
            TFDirector:removeTimer(self.timer)
            self.timer = nil;
            if not self.selectedCrystal then
				Utils:showTips(494008);
				return;
			end
        end
        if event.name == "began" then
            TFAudio.playSound(Utils:getKVP(1001,"ui_clickSound"))
            self:onTouchButtonDown()
            self:holdDownAction(false);
        end
    end)

    self._ui.Button_max:onClick(function()
		if not self.selectedCrystal then
			Utils:showTips(494008);
			return;
		end
        
        local maxCnt = self:getMaxCnt()
        self.selectTab = {}
        self.selectExp = 0
        self.selectNum = 1
        self:updateBatchPanel(maxCnt)
    end)

    self._ui.Button_ok:onClick(function()
    		if #self.selectList == 0 then
    			Utils:showTips(494008);
    			return;
    		end

    		local msg = {}
    		for k,v in pairs(self.selectList) do
    			table.insert(msg,{v.cid,v.num})
    		end

    		HeroDataMgr:HERO_REQ_DECOMPOSE_MATERIALS({msg})
    	end)

    self._ui.Button_open:onClick(function()
    		self:onTouchButtonOpen();
    	end)

    for i=1,6 do
    	local btn = self._ui["Button_fenlei"..i]
    	btn:onClick(function()
    			self.showType = i;
    			self:initLeftShowList();
    			self:updateButtonState();
    			self:onTouchButtonOpen();
    			self:updateLeft();
    		end)
    end

    self._ui.item_get:setTouchEnabled(true)
    self._ui.item_get:onClick(function()
    		Utils:showInfo(510241)
    	end)

    EventMgr:addEventListener(self,EV_HERO_RES_DECOMPOSE_MATERIALS,handler(self.EV_HERO_RES_DECOMPOSE_MATERIALS, self));
end

function CrystalTransform:updateButtonState()
	for j=1,6 do
		btn = self._ui["Button_fenlei"..j];

		if self.showType == j then
			btn:getChildByName("Label_"):setFontColor(ccc3(252,225,64));
		else
			btn:getChildByName("Label_"):setFontColor(ccc3(255,255,255));
		end
	end
	self._ui.Label_title:setTextById(ShowTypeText[self.showType]);
end

function CrystalTransform:onHide()
	self.super.onHide(self)
end

function CrystalTransform:removeUI()
	self.super.removeUI(self)
end

function CrystalTransform:onShow()
	self.super.onShow(self)
end

function CrystalTransform:EV_HERO_RES_DECOMPOSE_MATERIALS()
	self:initData();
	self.selectedCrystal = nil;
	self.selectNum = 0;
	self.selectList = {};
	self.selectNumLab:setString(0);
	self.selectListView:removeAllItems();
	self:updateLeft();
	self:updateGetUI();
end

return CrystalTransform;