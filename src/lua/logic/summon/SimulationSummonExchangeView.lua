local SimulationSummonExchangeView = class("SimulationSummonExchangeView", BaseLayer)


Open_Type_Exchange       		=				1			--兑换
Open_Type_Replace       		=				2			--替换
Open_Type_ExchangeAndShow   	=				3			--展示并且兑换

function SimulationSummonExchangeView:ctor(...)
    self.super.ctor(self)
	
	dump(...)
    self:initData(...)
    self:init("lua.uiconfig.summon.SimulationSummonExchangeView")
end

function SimulationSummonExchangeView:initUI(ui)
    self.super.initUI(self, ui)
	
	self.button_back = TFDirector:getChildByPath(ui, "Button_back")
	self.button_ok = TFDirector:getChildByPath(ui, "Button_ok")
	self.button_ok_text = TFDirector:getChildByPath(self.button_ok, "Label_text")
	self.Image_costIcon = TFDirector:getChildByPath(self.button_ok, "Image_costIcon"):hide()
	self.Label_costNum = TFDirector:getChildByPath(self.button_ok, "Label_costNum"):hide()
	self.Image_unlock_bg = TFDirector:getChildByPath(self.button_ok, "Image_unlock_bg"):hide()

	self.panel_SimulationSummons_ = {}
	for i = 1, 3 do
		local _root = TFDirector:getChildByPath(ui, "Panel_SimulationSummon" .. i)
		local _foo = {}
		_foo.root = _root
		_foo.items = TFDirector:getChildByPath(_root, "Panel_items")
		_foo.select = TFDirector:getChildByPath(_root, "Image_Select"):hide()
		_foo.isReceive = TFDirector:getChildByPath(_root, "Label_isReceive"):hide()
		print("----insert .." .. i)
		--table.insert(self.panel_SimulationSummons_, _foo)
		self.panel_SimulationSummons_[i] = _foo
	end
	self.isAniOver_ = true
	
	self:refreshView()
end

function SimulationSummonExchangeView:onRecvSimulationSummonExchange(data)
	self.receiveReward_ = {}
	table.insertTo(self.receiveReward_, data.rewards)
	Utils:showReward(self.receiveReward_)
	self.selectIndex_ = 0
	self:refreshView()
end


function SimulationSummonExchangeView:onRecvSimulationSummonReplace(data)
	print("-------------------------------------------------------------------SimulationSummonExchangeView:onRecvSimulationSummonReplace")
	self.openType_ = Open_Type_Exchange
	self.selectIndex_ = 0
	self:refreshView()
	--AlertManager:closeLayer(self)
end

--[[注册事件]]
function SimulationSummonExchangeView:registerEvents()
	EventMgr:addEventListener(self, EV_SUMMON_RES_SIMULATE_SUMMON_REPLACE, handler(self.onRecvSimulationSummonReplace, self))
	EventMgr:addEventListener(self, EV_SUMMON_RES_SIMULATE_SUMMON_EXCHANGE, handler(self.onRecvSimulationSummonExchange, self))
	
	self.button_back:onClick(function()
		AlertManager:closeLayer(self)
	end)
	
	self.button_ok:onClick(function()
		local _foo = self.panel_SimulationSummons_[self.selectIndex_]
		if _foo ==nil then
			Utils:showError("未选择合适的条目")
			return
		end
		
		if self.openType_ == Open_Type_Exchange then
			SimulationSummonDataMgr:reqSimulateSummonExchange(self.cid_, _foo.record.order)
		elseif self.openType_ == Open_Type_Replace then
			Utils:openView("summon.SimulationSummonExchangeTipsView",self.cid_, _foo.record.order, self.replaceDatas_)
		end
	end)

	self.Image_unlock_bg:onClick(function()
		if self.cid_ then
			local itemId
			local cfg = TabDataMgr:getData("SimulatedCall", self.cid_)
			if cfg then
				for k, v in pairs(cfg.exchangeConsump) do
					itemId = k
					break
				end
			end
			if itemId then
				Utils:showInfo(itemId)
			end

		end
	end)
end


--[[数据初始化]]
function SimulationSummonExchangeView:initData(cid, openType, replaceDatas)
	self.openType_ = openType or Open_Type_Exchange  
	self.replaceDatas_ = replaceDatas or {}
	self.cid_ = cid
	
	self.selectIndex_ = 0
	
end


function SimulationSummonExchangeView:removeEvents()
        if self.timerId then
        TFDirector:removeTimer(self.timerId)
    end
end

--[[刷新界面显示]]
function SimulationSummonExchangeView:refreshView()
	--print("openType_=" .. self.openType_)
	if self.openType_ == Open_Type_Exchange or self.openType_ == Open_Type_ExchangeAndShow then
		--print("-----------button_ok_text1")
		self.button_ok_text:setText("兑换")
		self.Image_costIcon:show()
		self.Label_costNum:show()
		self.Image_unlock_bg:show()
			--设置数据
		local cfg = TabDataMgr:getData("SimulatedCall", self.cid_)
		if nil ~= cfg then
			for k, v in pairs(cfg.exchangeConsump) do
				print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk=" ..k)
				local _cfg = GoodsDataMgr:getItemCfg(k)
				self.Image_costIcon:setTexture(_cfg.icon)
				self.Label_costNum:setText(GoodsDataMgr:getItemCount(k, false) .. "/" ..v )
				--self.dhName:setText("当前拥有" .. TextDataMgr:getTextAttr(_cfg.nameTextId).text .. "道具")
				break
			end
		end
	elseif self.openType_ == Open_Type_Replace then
		--print("-----------button_ok_text2")
		self.button_ok_text:setText("替换")
		self.Image_costIcon:hide()
		self.Label_costNum:hide()
		self.Image_unlock_bg:hide()
	end
	
	
	if self.openType_ == Open_Type_ExchangeAndShow then
		self.isAniOver_ = false
		local simulationSummonInfo = SimulationSummonDataMgr:getSimulationSummon(self.cid_)
		local _index = simulationSummonInfo.simulateSummonCount + simulationSummonInfo.sysSimulateSummonCount
		if simulationSummonInfo then
			for i = 1, #simulationSummonInfo.records do
				if i == _index then
					
				else
					self:updateSimulationSummon(i, simulationSummonInfo.records[i])
				end
				
			end	
		end
		
		--定时刷新数据
		self.currentRecord_ = simulationSummonInfo.records[_index]
		self.currentFoo_ = self.panel_SimulationSummons_[_index]
		self.currentFoo_.items:removeAllChildren()
		self.currentFoo_.record = self.currentRecord_
		
		self.currentFoo_.isReceive:setVisible(self.currentRecord_.isReceive)
		self.currentFoo_.select:hide()
		--print("add event")
		self.currentFoo_.root:onClick(function()
			--print("--_foo.root:onClick")
			if self.currentRecord_.isReceive then
				Utils:showTips(63610)
				--Utils:showError("已经兑换过了不能选择");
			elseif self.openType_ == Open_Type_Exchange and nil == self.currentRecord_.items  then
				Utils:showTips(63611)
			else
				self:selectSummon(_index)
			end
			
		end)
		
		self.currentIndex_ = 1
		self.timerId =  TFDirector:addTimer(150, #self.replaceDatas_, nil, handler(self.onUpdateSimulationSummon, self))
	else
		local simulationSummonInfo = SimulationSummonDataMgr:getSimulationSummon(self.cid_)
		if simulationSummonInfo then
			for i = 1, #simulationSummonInfo.records do
				self:updateSimulationSummon(i, simulationSummonInfo.records[i])
			end	
		end
	end	
end

function SimulationSummonExchangeView:onUpdateSimulationSummon()
	local posX = -445 + (self.currentIndex_-1)*105*0.8
	local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
	Panel_goodsItem:Scale(0.7)
	Panel_goodsItem:setPosition(ccp(posX,-20))
	self.currentFoo_.items:addChild(Panel_goodsItem)
	
	PrefabDataMgr:setInfo(Panel_goodsItem, self.currentRecord_.items[self.currentIndex_].id, self.currentRecord_.items[self.currentIndex_].num)
	
	self.currentIndex_ = self.currentIndex_ + 1
	if self.currentIndex_ > #self.replaceDatas_ then
		self.openType_ = Open_Type_Exchange
		Utils:showTips(63614)
		self.isAniOver_ = true
	end
end

--[[刷新指定Index的召唤结果]]
function SimulationSummonExchangeView:updateSimulationSummon(index,record)
	local _foo = self.panel_SimulationSummons_[index]
	--dump(record)
	if nil ~= _foo then
		_foo.record = record
		
		_foo.items:removeAllChildren()
		if nil ~= record.items then
			local itemIndex = 0
			for i = 1, #record.items do
				itemIndex = itemIndex + 1
				local posX = -445 + (itemIndex-1)*105*0.8
				local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
				Panel_goodsItem:Scale(0.7)
				Panel_goodsItem:setPosition(ccp(posX,-20))
				_foo.items:addChild(Panel_goodsItem)
				
				PrefabDataMgr:setInfo(Panel_goodsItem, record.items[i].id, record.items[i].num)
			end
		end
		
		_foo.isReceive:setVisible(record.isReceive)
		_foo.select:hide()
		--print("add event")
		_foo.root:onClick(function()
			--print("--_foo.root:onClick")
			if record.isReceive then
				Utils:showTips(63610)
				--Utils:showError("已经兑换过了不能选择");
			elseif self.openType_ == Open_Type_Exchange and nil == record.items  then
				Utils:showTips(63611)
			else
				self:selectSummon(index)
			end
			
		end)
	else 
		print("_foo = nil")
	end
end

function SimulationSummonExchangeView:selectSummon(index)

    if self.selectIndex_ == index then return end
	if not self.isAniOver_ then return end
    self.selectIndex_ = index

    for i, foo in pairs(self.panel_SimulationSummons_) do
        foo.select:setVisible(i == index)
    end
	
	

end


return SimulationSummonExchangeView