local SimulationSummonExchangeTipsView = class("SimulationSummonExchangeTipsView", BaseLayer)

function SimulationSummonExchangeTipsView:ctor(...)
    self.super.ctor(self)
	
	dump(...)
    self:initData(...)
    self:init("lua.uiconfig.summon.SimulationSummonExchangeTipsView")
end

function SimulationSummonExchangeTipsView:initUI(ui)
    self.super.initUI(self, ui)
	
	
	self.button_close = TFDirector:getChildByPath(ui, "Button_close")
	self.button_ok = TFDirector:getChildByPath(ui, "Button_ok")
	
	self.panel_SimulationSummons_ = {}
	for i = 1, 2 do
		local _root = TFDirector:getChildByPath(ui, "Panel_SimulationSummon" .. i)
		local _foo = {}
		_foo.root = _root
		_foo.items = TFDirector:getChildByPath(_root, "Panel_items")
		_foo.Image_order = TFDirector:getChildByPath(_root, "Image_order")
		_foo.Label_order = TFDirector:getChildByPath(_root, "Label_order")
		self.panel_SimulationSummons_[i] = _foo
	end
	
	
	
	self._string = {"一", "二", "三"}
	self:refreshView()
end

--[[刷新界面显示]]
function SimulationSummonExchangeTipsView:refreshView()
	
	self:updateSimulationSummon(2, self.replaceDatas_)
	
	local record = SimulationSummonDataMgr:getRecord(self.cid_, self.order_)
	if nil ~= record then
		self:updateSimulationSummon(1, record.items,self.order_)
	else 
		print("record is nil self.cid_=" .. self.cid_ .. " self.order_=" .. self.order_)
	end
	
end


--[[刷新指定Index的召唤结果]]
function SimulationSummonExchangeTipsView:updateSimulationSummon(index,items,order)
	local _foo = self.panel_SimulationSummons_[index]
	print("index=" .. index)
	dump(items)
	if nil ~= _foo then
		_foo.items:removeAllChildren()
		if nil ~= items then
			local itemIndex = 0
			for i = 1, #items do
				itemIndex = itemIndex + 1
				local posX = -445 + (itemIndex-1)*105*0.8
				local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
				Panel_goodsItem:Scale(0.7)
				Panel_goodsItem:setPosition(ccp(posX,-20))
				_foo.items:addChild(Panel_goodsItem)
				
				PrefabDataMgr:setInfo(Panel_goodsItem, items[i].id, items[i].num)
			end
		end
		if nil ~= order then
			_foo.Image_order:setTexture("ui/summon/simulation/" .. order .. ".png")
			_foo.Label_order:setText("第" .. self._string[order] .. "次保存")
		end
	else 
		print("_foo = nil")
	end
end

function SimulationSummonExchangeTipsView:onRecvSimulationSummonReplace(data)
	Utils:showTips(63613)
	print("-------------------------------------------------------------------SimulationSummonExchangeView:onRecvSimulationSummonReplace")
	AlertManager:closeLayer(self)
end

--[[注册事件]]
function SimulationSummonExchangeTipsView:registerEvents()
	self.button_close:onClick(function()
		AlertManager:closeLayer(self)
	end)
	
	self.button_ok:onClick(function()
		SimulationSummonDataMgr:reqSimulateSummonReplace(true, self.order_)
	end)
	 
	EventMgr:addEventListener(self, EV_SUMMON_RES_SIMULATE_SUMMON_REPLACE, handler(self.onRecvSimulationSummonReplace, self))
end


--[[数据初始化]]
function SimulationSummonExchangeTipsView:initData(cid, order, replaceDatas_)
	self.cid_ = cid
	self.replaceDatas_ = replaceDatas_
	self.order_ = order
	self.record_ = SimulationSummonDataMgr:getRecord(cid,order)
end






return SimulationSummonExchangeTipsView