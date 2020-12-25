local SimulationSummonMainView = class("SimulationSummonMainView", BaseLayer)

function SimulationSummonMainView:ctor(...)
    self.super.ctor(self)
	
	--dump(...)
    self:initData(...)
    self:init("lua.uiconfig.summon.SimulationSummonMainView")
end

function SimulationSummonMainView:initData(id, showType)
	self.initSelectId_ = id
	self.showType_ = showType
end

function SimulationSummonMainView:initUI(ui)
    self.super.initUI(self, ui)
	

	self.Panel_hero 	    = TFDirector:getChildByPath(ui, "Panel_hero")
	self.Image_hero			= TFDirector:getChildByPath(ui, "Image_hero")
	self.hero_pos = self.Image_hero:getPosition()
	
	self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
	self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
	
	self.Panel_summonItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_summonItem")
	
	self.Button_buy = TFDirector:getChildByPath(ui, "Button_buy")
	self.Label_summon = TFDirector:getChildByPath(self.Button_buy, "Label_summon")
	
	self.Button_duihuan = TFDirector:getChildByPath(ui, "Button_duihuan")
	
	local ScrollView_summon = TFDirector:getChildByPath(self.Panel_root, "ScrollView_summon")
    self.ListView_summon = UIListView:create(ScrollView_summon)
	self.ListView_summon:setItemsMargin(5)
	
	
	self.zmIcon = TFDirector:getChildByPath(ui, "Image_itemIcondh")
	self.zmCount = TFDirector:getChildByPath(ui, "Label_itemCountdh")
	self.dhIcon = TFDirector:getChildByPath(ui, "Image_itemIcon")
	self.dhCount = TFDirector:getChildByPath(ui, "Label_itemCount")
	self.dhName = TFDirector:getChildByPath(ui, "Label_itemName")
	self.endTime = TFDirector:getChildByPath(ui, "Label_time")
    self.endTime:setSkewX(10)
    self.Label_time_tp = TFDirector:getChildByPath(ui, "Label_time_tp")
    self.Label_time_tp:setSkewX(10)
	self.Button_preview = TFDirector:getChildByPath(ui,"Button_preview")
	self.Label_zmcs = TFDirector:getChildByPath(ui,"Label_zmcs")
	self.Label_dhcs = TFDirector:getChildByPath(ui,"Label_dhcs")
	self.Label_dhcst = TFDirector:getChildByPath(ui,"Label_SimulationSummonCont")
	self.Label_zmcst = TFDirector:getChildByPath(ui,"Label_SimulationSummonCountl")

	self.Image_SimulationSummonsizidi = TFDirector:getChildByPath(ui,"Image_SimulationSummonsizidi")
	self.Label_SimulationSummonsizi = TFDirector:getChildByPath(ui,"Label_SimulationSummonsizi")
	
	self.Label_SimulationSummonMainView_1 = TFDirector:getChildByPath(ui, "Label_SimulationSummonMainView_1")
	
	
	self.Image_bg = TFDirector:getChildByPath(ui,"Image_bg")
	self.Image_jb = TFDirector:getChildByPath(ui,"Image_jb")
	
	self.Image_SimulationSummombgs = {}
	local _panel = TFDirector:getChildByPath(ui,"Panel_SimulationSummon")
	for i = 1, 3 do
		local image = TFDirector:getChildByPath(_panel,"Image_SimulationSummombg" .. i)
		table.insert(self.Image_SimulationSummombgs, image)
	end
	
	

	self.simulationSummonIcons_ = {}
	for i = 1, 3 do
		local _root = TFDirector:getChildByPath(self.Panel_root, "Image_SimulationSummonIcon" .. i)
		local _icon = TFDirector:getChildByPath(_root, "Image_icon")
		local _name = TFDirector:getChildByPath(_root, "Label_name")
		local _stars = {}
		for j = 1, 5 do
			local _star = TFDirector:getChildByPath(_root, "Image_star_" .. j)
			_stars[j] = _star
		end
		
		
		_foo = {}
		
		_foo.root = _root
		_foo.icon = _icon
		_foo.name = _name
		_foo.stars = _stars
		self.simulationSummonIcons_[i] = _foo
	end
	
	
	--卡池配置数据列表
	self.summonCfgs_ = {}	
	--UI列表卡池子项	
	self.summonItems_ = {}
	--当前选择卡池序号
	self.selectIndex_ = 0
	--当前选择卡池配置数据
	self.selectSummonCfg_ = nil
	self.summonCfg_ = TabDataMgr:getData("Summon",11009)
	
	local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.SIMULATION_SUMMON)
	
	print("=====================ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.SIMULATION_SUMMON)")
    --self.activityId_ = activity[1]
    if #activity > 0 then
		 self.activityId_ = activity[1]
        self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
		--print("--------------------------------------------------------------------------------------------BlackAndWhiteMainView:initData")
		--dump(self.activityInfo_)
		self.endTime_ = self.activityInfo_.showEndTime
    else
        Utils:showTips(219007)
        return
    end
	
	--local endtime = string.format("%s-%s-%s %s:%s:%s", self.summonCfg_.showEndDate[1],self.summonCfg_.showEndDate[2],self.summonCfg_.showEndDate[3],self.summonCfg_.showEndDate[4],self.summonCfg_.showEndDate[5],self.summonCfg_.showEndDate[6])
	
	--print("endtime=" .. endtime)
	
	--print(self.endTime_)
	
	self.costItemId = -1
	self.costNum  =-1
	
	self:sortTableData()
	self:refreshView()
	self:updateCountDonw()
end

--[[召唤一次的结果]]
function SimulationSummonMainView:onRecvSimulationSummon(data)
	dump(data)
	
	Utils:openView("summon.SimulationSummonResultView", self.selectSummonCfg_.id, data.item or {})
	self:updateView()
end


function SimulationSummonMainView:onCountDownPer()
	self:updateCountDonw()
end


function SimulationSummonMainView:updateCountDonw()
    local serverTime = ServerDataMgr:getServerTime()
    local remainTime = math.max(0, self.endTime_ - serverTime)
    local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
	self.endTime:setText(day .. "天" .. hour .. "时" .. min .. "分")
end


function SimulationSummonMainView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
    end
end
function SimulationSummonMainView:removeEvents()
    self:removeCountDownTimer()
end

function SimulationSummonMainView:updateView()
	local select = self.selectIndex_
	self.selectIndex_ = -1
	self:selectSummon(select)
end

--[[注册事件]]
function SimulationSummonMainView:registerEvents()

    EventMgr:addEventListener(self, EV_SUMMON_RES_SIMULATE_SUMMON_EXCHANGE, handler(self.updateView, self))
	EventMgr:addEventListener(self, EV_SUMMON_RES_SIMULATE_SUMMON, handler(self.onRecvSimulationSummon, self))
	if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.onCountDownPer, self))
    end
	self.Button_buy:onClick(function()
		
		if nil == self.selectSummonCfg_ then
			Utils:showError("选择的卡池无效");
			return
		end
		
		local simulationSummon = SimulationSummonDataMgr:getSimulationSummon(self.selectSummonCfg_.id)
		if(nil == simulationSummon) then
			Utils:showTips(63609)
			return
		end

		local dhcs = self.selectSummonCfg_.exchangeQuantity - (simulationSummon ~= nil and simulationSummon.exchangeCount or 0)
		if dhcs <= 0 then
			Utils:showTips(63635)
			return	
		end
		
		
		--判断有没有次数可以招募
		if simulationSummon.simulateSummonCount >= self.selectSummonCfg_.freeQuantity and simulationSummon.sysSimulateSummonCount >= self.selectSummonCfg_.recruitQuantity then
			Utils:showTips(63623)
			return	
		end	
		
		
		
		
		
		--判断是否可以免费招募
		local _canUse = false
		if not _canUse then
			if simulationSummon.simulateSummonCount < self.selectSummonCfg_.freeQuantity then
				_canUse = true
				for k, v in pairs(self.selectSummonCfg_.freeConsump) do
					if GoodsDataMgr:getItemCount(k, false) < v then
						_canUse = false
						break
					end
				end
			end
		end
		--判断是否可以使用道具招募
		if not _canUse then
			if simulationSummon.sysSimulateSummonCount < self.selectSummonCfg_.recruitQuantity then
				local  consume = self:getCount(self.selectSummonCfg_,simulationSummon.sysSimulateSummonCount) 
				_canUse = true
				for k, v in pairs(consume) do
					if GoodsDataMgr:getItemCount(k, false) < v then
						_canUse = false
						break
					end
				end
			end
		end
		if _canUse then
			local tips =  MainPlayer:getOneLoginStatus(EC_OneLoginStatusType.ReConfirm_SimulationSummon)
			--Box(tostring(tips))
			if self.costNum > -1 and self.costItemId > -1 and not tips then
				local rstr = TextDataMgr:getTextAttr(63638)
				local formatStr = rstr and rstr.text or ""
				local content = string.format(formatStr, self.costNum, TabDataMgr:getData("Item", self.costItemId).icon)
				Utils:openView("common.ReConfirmTipsView", {tittle = 1200041, content = content, reType = EC_OneLoginStatusType.ReConfirm_SimulationSummon, confirmCall = function()
				SimulationSummonDataMgr:reqSimulateSummon(self.selectSummonCfg_.id)
				end})
			else
				SimulationSummonDataMgr:reqSimulateSummon(self.selectSummonCfg_.id)
			end	
			
		else
			if simulationSummon.simulateSummonCount >= self.selectSummonCfg_.freeQuantity then
				Utils:showTips(63616)
			elseif simulationSummon.sysSimulateSummonCount >= self.selectSummonCfg_.recruitQuantity then
				Utils:showTips(63635)
			else
				Utils:showTips(63616)
			end	
			
		end
    end)
	
	self.Button_duihuan:onClick(function()
		Utils:openView("summon.SimulationSummonExchangeView", self.selectSummonCfg_.id, 1)
	end)
	
	self.Button_preview:onClick(function()
        --local summonCfg = SummonDataMgr:getSummonCfg(self.activityInfo.extendData.summon[1])
		print("self.summonCfg_.groupId=" .. self.summonCfg_.groupId)
        Utils:openView("summon.SummonPreviewView", self.summonCfg_.groupId)
    end)
end


--[[卡池排序  规则按照开启状态以及等级]]
function SimulationSummonMainView:sortTableData()
	local datas = TabDataMgr:getData("SimulatedCall")
	
	for k, v in pairs(datas) do
		--if SimulationSummonDataMgr:checkIsOpenById(v.id) then 
			if self.showType_ == 1 and  nil ~= v.firework and string.len(v.firework) > 0 then
				table.insert(self.summonCfgs_, v)
			elseif 	self.showType_ == 2 and  (nil == v.firework or string.len(v.firework) == 0) then
				table.insert(self.summonCfgs_, v)
			end
		--end
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
	
end


function SimulationSummonMainView:addSummonItem(i)
    local Panel_summonItem = self.Panel_summonItem:clone()
    local foo = {}
    foo.root = Panel_summonItem
	
    foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select")  
    foo.Image_icon = TFDirector:getChildByPath(foo.root, "Image_icon")
    foo.Label_name = TFDirector:getChildByPath(foo.root, "Label_name")
    --foo.Image_upTips = TFDirector:getChildByPath(foo.root, "Image_upTips"):hide()
	foo.Image_lock = TFDirector:getChildByPath(foo.root, "Image_lock")
    foo.id = i
    self.ListView_summon:pushBackCustomItem(foo.root)
    self.summonItems_[i] = foo
end

function SimulationSummonMainView:updateSummonItem(index)
    local summonCfg = self.summonCfgs_[index]
    local foo = self.summonItems_[index]
    foo.Label_name:setTextById(summonCfg.name2)
    foo.Label_name:setSkewX(15)
	foo.Image_lock:setVisible(not SimulationSummonDataMgr:checkIsOpenById(summonCfg.id))
	--foo.Image_lock:hide()
    foo.root:onClick(function()
		self:selectSummon(index)
    end)
end

function SimulationSummonMainView:selectSummon(index)

    if self.selectIndex_ == index then return end

	local simulationSummon = SimulationSummonDataMgr:getSimulationSummon(self.summonCfgs_[index].id)
	if(nil == simulationSummon) then
		Utils:showTips(63609)
		return
	end
	
	
    self.selectIndex_ = index

    self.selectSummonCfg_ = self.summonCfgs_[self.selectIndex_]
    for i, foo in pairs(self.summonItems_) do
        foo.Image_select:setVisible(i == index)
        local color = i == index and ccc3(255,255,255) or ccc3(175,223,254)
        foo.Label_name:setColor(color)
        local outLineColor = i == index and ccc4(88,111,188,255) or ccc4(64,64,139,255)
        foo.Label_name:enableOutline(outLineColor,2)
    end
	
	
	for k, particleId in ipairs(self.selectSummonCfg_.displayParticles) do
		local _foo = self.simulationSummonIcons_[k]
		if nil ~= _foo then
			local _cfgEquip = TabDataMgr:getData("Equipment", particleId)
			if nil ~= _cfgEquip then
				--dump(_cfgEquip)
				_foo.name:setTextById(_cfgEquip.name)
				_foo.icon:setTexture(_cfgEquip.equipPaint)
				--Utils:openView("Equipment.EquipmentInfo", {equipmentId = equipid, fromBag = true})
				_foo.icon:onClick(function()
					Utils:openView("Equipment.EquipmentInfo", {equipmentId = particleId, fromBag = false})
				end)
			end
		end
	end 
	
	
	 self.Image_hero:stopAllActions()
    self.Image_hero:setPosition(self.hero_pos)
    ViewAnimationHelper.doMoveFadeInAction(self.Image_hero, {direction = 1, distance = 30, ease = 1})

    self.anim_hero = Utils:createHeroModel(self.selectSummonCfg_.spirit, self.Image_hero)
    self.anim_hero:setScale(0.76)
	
	self.Image_hero:setPosition(ccp(self.hero_pos.x + (self.selectSummonCfg_.spiritShifting1[1] or 0),-100 + self.hero_pos.y + (self.selectSummonCfg_.spiritShifting1[2] or 0)))
	
	self.costItemId = -1
	self.costNum  =-1
	--招募消耗
	local simulationSummon = SimulationSummonDataMgr:getSimulationSummon(self.selectSummonCfg_.id)
	--判断是否可以进行道具招募
	local _canFree = false
	if simulationSummon.simulateSummonCount < self.selectSummonCfg_.freeQuantity then
		_canFree = true
		for k, v in pairs(self.selectSummonCfg_.freeConsump) do
			print("kkkkkkk=" .. k .. "	v=" .. v)
			if GoodsDataMgr:getItemCount(k, false) < v then
				_canFree = false
				break
			end
		end
	end	
	
	if _canFree then
		for k, v in pairs(self.selectSummonCfg_.freeConsump) do
			self.zmIcon:setTexture(GoodsDataMgr:getItemCfg(k).icon)
			self.zmCount:setText("X" ..v)
			break
		end
	else
		local consume = self:getCount(self.selectSummonCfg_,simulationSummon ~= nil and simulationSummon.sysSimulateSummonCount or 0)
		for k, v in pairs(consume) do
			self.zmIcon:setTexture(GoodsDataMgr:getItemCfg(k).icon)
			self.zmCount:setText("X" ..v)
			self.costItemId = k
			self.costNum  = v
			break
		end
	end
		
	
	--兑换消耗
	for k, v in pairs(self.selectSummonCfg_.freeConsump) do
		local _cfg = GoodsDataMgr:getItemCfg(k)
		self.dhIcon:setTexture(_cfg.icon)
		self.dhCount:setText(GoodsDataMgr:getItemCount(k, false))
		--dump(_cfg)
		self.dhName:setText("当前拥有" .. TextDataMgr:getTextAttr(_cfg.nameTextId).text)
		break
	end
	
	--print("self.selectSummonCfg_.exchangeQuantity=" .. self.selectSummonCfg_.exchangeQuantity)
	--print("simulationSummon.exchangeCount=" .. simulationSummon.exchangeCount)
	
	self.Label_zmcs:setText(self.selectSummonCfg_.recruitQuantity - (simulationSummon ~= nil and simulationSummon.sysSimulateSummonCount or 0))
	self.Label_dhcs:setText(self.selectSummonCfg_.exchangeQuantity - (simulationSummon ~= nil and simulationSummon.exchangeCount or 0))

	
	local quality = HeroDataMgr:getRarity(self.selectSummonCfg_.spirit)
	print("-------------------------------------------quality=" .. quality)
	self.Image_bg:setTexture("ui/summon/simulation/db" .. (quality >= 5 and "2" or "") ..  ".png")
	self.Image_jb:setTexture("ui/summon/simulation/jb" .. (quality >= 5 and "2" or "") ..  ".png")
	
	local imagePath = "ui/summon/simulation/" .. (quality >= 5 and "111-1" or "111") ..  ".png"
	for k, v in ipairs(self.Image_SimulationSummombgs) do
		v:setTexture(imagePath)
	end
	
	self.Image_SimulationSummonsizidi:setTexture("ui/summon/simulation/si" .. (quality >= 5 and "2" or "1") .. ".png")
	local color = (quality >= 5 and ccc3(175,103,38) or ccc3(150,207,252))
	self.Label_SimulationSummonsizi:setFontColor(color)
	self.Label_SimulationSummonsizi:setTextById(self.selectSummonCfg_.coordinates)

	--print("--------------------------------------->")
	--print("----------------" .. self.Label_SimulationSummonsizi:getColor())
	
	print(self.selectSummonCfg_.relatedSummon)
	self.summonCfg_ = TabDataMgr:getData("Summon",self.selectSummonCfg_.relatedSummon)
	--local endtime = string.format("%s-%s-%s %s:%s:%s", self.summonCfg_.showEndDate[1],self.summonCfg_.showEndDate[2],self.summonCfg_.showEndDate[3],self.summonCfg_.showEndDate[4],self.summonCfg_.showEndDate[5],self.summonCfg_.showEndDate[6])
	
	--self.endTime_ = Utils:getTimeByDate(endtime)
	
	--if quality >= 5 then
	--	self.endTime:enableStroke(ccc4(0XAF,0X67,0X26,0XFF),1)
	--	self.Label_SimulationSummonMainView_1:enableStroke(ccc4(0XAF,0X67,0X26,0XFF),1)
	--	self.Label_dhcst:enableStroke(ccc4(0XAF,0X67,0X26,0XFF),1)
	--	self.Label_zmcst:enableStroke(ccc4(0XAF,0X67,0X26,0XFF),1)
	--else
	--	self.endTime:enableStroke(ccc4(0X5F,0X2A,0XB7,0XFF),1)
	--	self.Label_SimulationSummonMainView_1:enableStroke(ccc4(0X5F,0X2A,0XB7,0XFF),1)
	--	self.Label_dhcst:enableStroke(ccc4(0X5F,0X2A,0XB7,0XFF),1)
	--	self.Label_zmcst:enableStroke(ccc4(0X5F,0X2A,0XB7,0XFF),1)
	--end
	--

end


function SimulationSummonMainView:refreshView()
	self.ListView_summon:removeAllItems()
    self.summonItems_ = {}
	local _select = self.selectIndex_
	
	
	self.Label_dhcst:setTextById(63621)
	self.Label_zmcst:setTextById(63620)
	self.Label_summon:setTextById(63622)
	
	for i, v in ipairs(self.summonCfgs_) do
        self:addSummonItem(i)
		self:updateSummonItem(i)
		
		if v.id == self.initSelectId_ then
			_select = i
			self.initSelectId_ = 0
		end
    end
	
	self:selectSummon(_select)
end

function SimulationSummonMainView:getCount(cfg, count)
	local consume = nil
	if nil ~= cfg and nil ~= cfg.recruitmentConsump then
		local _curIndex = 0
		local _find  =false
		for k, v in pairs(cfg.recruitmentConsump) do
			if nil ~= v.count[count + 1] then
				consume = v.consume
				break
			end
		end
	end
	
	if nil == consume then
		count = count - 1
		if nil ~= cfg and nil ~= cfg.recruitmentConsump then
			local _curIndex = 0
			local _find  =false
			for k, v in pairs(cfg.recruitmentConsump) do
				if nil ~= v.count[count + 1] then
					consume = v.consume
					break
				end
			end
		end
	end
	
	return consume
end




return SimulationSummonMainView