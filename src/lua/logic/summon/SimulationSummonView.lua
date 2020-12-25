local SimulationSummonView = class("SimulationSummonView", BaseLayer)

function SimulationSummonView:ctor(...)
    self.super.ctor(self)
	
	dump(...)
    self:initData(...)
    self:init("lua.uiconfig.summon.SimulationSummonView")
end

function SimulationSummonView:initData(data)
	self.data_ = data
end

function SimulationSummonView:onRecvSimulationSummonReplace(data)
end

--[[注册事件]]
function SimulationSummonView:registerEvents()
	EventMgr:addEventListener(self, EV_SUMMON_RES_SIMULATE_SUMMON_REPLACE, handler(self.onRecvSimulationSummonReplace, self))
end	

function SimulationSummonView:initUI(ui)
    self.super.initUI(self, ui)
	
	self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
	self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
	
	self.Panel_summonItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_summonItem")
	
	local ScrollView_summon = TFDirector:getChildByPath(self.Panel_root, "ScrollView_summon")
    self.ListView_summon = UIListView:create(ScrollView_summon)
	self.ListView_summon:setItemsMargin(10)
	
	
	
	
	--ss
	self.orangeSummonCfgs_ = {}   		--橙色卡池
	self.simulationSummonIcons_ = {}	--ui
	for i = 1, 4 do
		local _root = TFDirector:getChildByPath(self.Panel_root, "Image_SimulationSummonIcon" .. i)
		local _lock = TFDirector:getChildByPath(_root, "Image_lock"):hide()
        local _lockTip = TFDirector:getChildByPath(_lock, "Label_lock")
		local _effect = TFDirector:getChildByPath(ui, "Spine_SimulationSummonView_" .. (i + 1))
		
		_foo = {}
		
		_foo.root = _root
		_foo.lock = _lock
		_foo._effect = _effect
		_foo._lockTip = _lockTip
		self.simulationSummonIcons_[i] = _foo
	end
	self.simulationSummonIcons_[1].index = 5
	self.simulationSummonIcons_[2] .index = 4
	self.simulationSummonIcons_[3] .index = 2
	self.simulationSummonIcons_[4] .index = 2
	
	self.Spine_SimulationSummonView_1 = TFDirector:getChildByPath(ui, "Spine_SimulationSummonView_1")
	self.Spine_SimulationSummonView_1:playByIndex(1,-1)
	
	
	
	
	--卡池配置数据列表
	self.summonCfgs_ = {}	
	--UI列表卡池子项	
	self.summonItems_ = {}
	--当前选择卡池序号
	self.selectIndex_ = 0
	--当前选择卡池配置数据
	self.selectSummonCfg_ = null
	
	SimulationSummonDataMgr:resetAlreadyHaveHero()
	self:sortTableData()
	self:refreshView()
end


--[[卡池排序  规则按照开启状态以及等级]]
function SimulationSummonView:sortTableData()
	local datas = TabDataMgr:getData("SimulatedCall")
	
	for k, v in pairs(datas) do
		if nil ~= v.firework and string.len(v.firework) > 0 then
			table.insert(self.orangeSummonCfgs_, v)
		else
			table.insert(self.summonCfgs_, v)
		end
		
		
	end
	
	--排序
	table.sort(self.summonCfgs_, function(a, b)
		--判断开启
		local _aOpen = SimulationSummonDataMgr:checkIsOpenById(a.id)
		local _bOpen = SimulationSummonDataMgr:checkIsOpenById(b.id)
		if _bOpen == _aOpen then
			return a.reorder < b.reorder
		else 
			return not  (_bOpen and (not _aOpen))
		end
		--判断等级
		return false
	end)
	
	--排序
	table.sort(self.orangeSummonCfgs_, function(a, b)
		--判断开启
		local _aOpen = SimulationSummonDataMgr:checkIsOpenById(a.id)
		local _bOpen = SimulationSummonDataMgr:checkIsOpenById(b.id)
		if _bOpen == _aOpen then
			return a.reorder < b.reorder
		else 
			return not  (_bOpen and (not _aOpen))
		end
		--判断等级
		return false
	end)
	
end


function SimulationSummonView:addSummonItem(i)
    local Panel_summonItem = self.Panel_summonItem:clone()
    local foo = {}
    foo.root = Panel_summonItem
	
    foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select")  
    --foo.Image_icon = TFDirector:getChildByPath(foo.root, "Image_icon")
    foo.Label_name = TFDirector:getChildByPath(foo.root, "Label_name")
    foo.Image_upTips = TFDirector:getChildByPath(foo.root, "Image_upTips")
	foo.Image_lock = TFDirector:getChildByPath(foo.root, "Image_lock")
	foo.Label_lock = TFDirector:getChildByPath(foo.root, "Label_lock")
	
	foo.Image_modle = TFDirector:getChildByPath(foo.root, "Image_modle")
    foo.model_pos = foo.Image_modle:getPosition()
    foo.id = i
    self.ListView_summon:pushBackCustomItem(foo.root)
    self.summonItems_[i] = foo
end

function SimulationSummonView:updateSummonItem2(index)
	local summonCfg = self.orangeSummonCfgs_[index]
    local foo = self.simulationSummonIcons_[index]
	if nil == summonCfg then
		return
	end
	
	foo.root:setTexture(summonCfg.firework)
	foo.lock:setVisible(not SimulationSummonDataMgr:checkIsOpenById(summonCfg.id))
    foo._lockTip:setVisible(summonCfg.unlocklevel ~= 0)
    foo._lockTip:setTextById(15010119,summonCfg.unlocklevel)
	foo._effect:setVisible( SimulationSummonDataMgr:checkIsOpenById(summonCfg.id))
	foo._effect:playByIndex(foo.index, -1)
    
    foo.root:onClick(function()
		if SimulationSummonDataMgr:checkIsOpenById(summonCfg.id) then
			if self.data_.lastCid ~= nil and self.data_.lastResult ~= nil then
				showMessageBox("上一次招募未完成", EC_MessageBoxType.ok, function()
					AlertManager:close()
					--Utils:openView("summon.SimulationSummonView",self.data_)
					Utils:openView("summon.SimulationSummonResultView",self.data_.lastCid, self.data_.lastResult)
					self.data_.lastCid = nil
					self.data_.lastResult = nil
				end)
			
			else
				Utils:openView("summon.SimulationSummonMainView",summonCfg.id, 1)
			end
		else 
			Utils:showTips(63609)
		end
    end)
end

function SimulationSummonView:updateSummonItem(index)
    local summonCfg = self.summonCfgs_[index]
    local foo = self.summonItems_[index]
    --foo.Image_icon:setTexture(summonCfg.smallIcon)
    foo.Label_name:setTextById(summonCfg.name2)
	foo.Image_lock:setVisible(not SimulationSummonDataMgr:checkIsOpenById(summonCfg.id))
    foo.Label_lock:setVisible(summonCfg.unlocklevel ~= 0)
    foo.Label_lock:setTextById(15010119,summonCfg.unlocklevel)
    foo.Image_upTips:setTexture(HeroDataMgr:getQualityPic(summonCfg.spirit, HeroDataMgr:getRarity(summonCfg.spirit)))
	foo.Image_upTips:Scale(0.3)
		
	foo.Image_modle:setPosition(foo.model_pos)
    local skinid = HeroDataMgr:getCurSkin(summonCfg.spirit)
    local model = Utils:createHeroModel(summonCfg.spirit, foo.Image_modle, 0.55, skinid,true)
    model:update(0.1)
    model:stop()
	--local cfg = TabDataMgr:getData("HeroDispatch",summonCfg.spirit)
    foo.Image_modle:setPosition(ccp(foo.model_pos.x + (summonCfg.spiritShifting[1] or 0),foo.model_pos.y + (summonCfg.spiritShifting[2] or 0)))
	
    foo.root:onClick(function()
		--self:selectSummon(index)
		if SimulationSummonDataMgr:checkIsOpenById(summonCfg.id) then
			if self.data_.lastCid ~= nil and self.data_.lastResult ~= nil then
				showMessageBox("上一次招募未完成", EC_MessageBoxType.ok, function()
					AlertManager:close()
					--Utils:openView("summon.SimulationSummonView",self.data_)
					Utils:openView("summon.SimulationSummonResultView",self.data_.lastCid, self.data_.lastResult)
					self.data_.lastCid = nil
					self.data_.lastResult = nil
				end)
			else
				Utils:openView("summon.SimulationSummonMainView",summonCfg.id,2)
			end	
		else 
			Utils:showTips(63609)
		end
    end)
end

function SimulationSummonView:selectSummon(index)

    --if self.selectIndex_ == index then return end
    --self.selectIndex_ = index

    --self.selectSummonCfg_ = self.summonCfgs_[self.selectIndex_]
    --local summonCfg = SummonDataMgr:getSummonCfg(summon[1].id)
    --for i, foo in pairs(self.summonItems_) do
    --    foo.Image_select:setVisible(i == index)
    --end

    --if summonCfg.summonType == EC_SummonType.HOT_ROLE then
    --    self:selectHotTab(self.selectHotTabIndex_)
    --else
     --   self.currentSummon_ = summon
     --   self:updateSelectInfo()
    --end
	
	
	
end


function SimulationSummonView:refreshView()
	self.ListView_summon:removeAllItems()
    self.summonItems_ = {}
	
	local _select = self.selectIndex_
	for i, v in ipairs(self.summonCfgs_) do
        self:addSummonItem(i)
		self:updateSummonItem(i)
		if _select == 0 then
			_select = i
		end
    end
	
	self:selectSummon(_select)
	
	
	--设置橙色的
	for i = 1,  #self.orangeSummonCfgs_ do
		self:updateSummonItem2(i)
	end
end


return SimulationSummonView