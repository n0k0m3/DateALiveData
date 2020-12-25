local FairyAngelEnergyBreakView = class("FairyAngelEnergyBreakView", BaseLayer)


function FairyAngelEnergyBreakView:ctor(data)
    self.super.ctor(self,data)
    self.heroid = data.heroId
    self.isMax = HeroDataMgr:checkAngelBreakReachMax(self.heroid)
	self:showPopAnim(true)
    self:init("lua.uiconfig.fairyNew.fairyEnergyBreakView")
end

function FairyAngelEnergyBreakView:initData(data)
	
end

function FairyAngelEnergyBreakView:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui

	self.Label_title = TFDirector:getChildByPath(ui,"Label_title")
	self.Label_get 	= TFDirector:getChildByPath(ui,"Label_get")
	self.Image_get_res		= TFDirector:getChildByPath(ui,"Image_get_res")
	self.old_lv		= TFDirector:getChildByPath(ui,"old_lv")
	self.cur_lv	= TFDirector:getChildByPath(ui,"cur_lv")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	self.Button_break = TFDirector:getChildByPath(ui,"Button_break")
	local Label_tips1 = TFDirector:getChildByPath(ui,"Label_tips1")
	local Label_tips2 = TFDirector:getChildByPath(ui,"Label_tips2")
	self.Label_tips3 = TFDirector:getChildByPath(ui,"Label_tips3")
	self.Label_title:setText(HeroDataMgr:getHeroWeaponName(self.heroid)..TextDataMgr:getText(10931235))

	local weaponType = HeroDataMgr:getHeroWeaponType(self.heroid)
	if weaponType == 1 then
		Label_tips1:setTextById(63651)
	else
		Label_tips1:setTextById(63652)
	end
	Label_tips2:setTextById(1329132)
	self.Image_max = TFDirector:getChildByPath(ui,"Image_max")
	self.Panel_info = TFDirector:getChildByPath(ui,"Panel_info")

	self.costItems = {}
	for i = 1, 2 do
		local foo = {}
		foo.root = TFDirector:getChildByPath(ui,"Panel_item"..i)
		foo.Image_bg = TFDirector:getChildByPath(foo.root,"Image_bg")
		foo.Panel_item = TFDirector:getChildByPath(foo.root,"Panel_item")
		foo.Label_name = TFDirector:getChildByPath(foo.root,"Label_name")
		foo.Label_cost = TFDirector:getChildByPath(foo.root,"Label_cost")
		foo.Image_select = TFDirector:getChildByPath(foo.root,"Image_select"):hide()
		self.costItems[i] = foo
	end

	self:updateUI()
end

function FairyAngelEnergyBreakView:updateUI()
	self.Button_break:setTouchEnabled(false)
    self.Button_break:setGrayEnabled(true)
    local level = HeroDataMgr:getAngelBreakLevel(self.heroid)
    local breakCfg = HeroDataMgr:getHeroAngelBreakCfg(self.heroid, level)
    self.old_lv:setString("Lv"..breakCfg.AngelLevel)
	
	local rewardCount = 0
	local lastCount = 0
	local curCount = 0
	if table.count(breakCfg.BreakReward) > 0 then
		for k,v in pairs(breakCfg.BreakReward) do
			lastCount = v
			break
		end
	end

	local curCfg = HeroDataMgr:getHeroAngelBreakCfg(self.heroid, self.isMax and level or (level + 1))
	self.cur_lv:setString("Lv"..curCfg.AngelLevel)
	for k,v in pairs(curCfg.BreakReward) do
		curCount = v
		break
	end
	rewardCount = math.max(0, curCount - lastCount)
	rewardCount = math.floor(rewardCount / 100)
	self.Label_get:setString("x"..rewardCount)

	self.costData = curCfg.BreakCost
	for k,info in pairs(self.costData) do
		for cid,num in pairs(info) do
			local foo
			local cfg = GoodsDataMgr:getItemCfg(cid)
			local count = GoodsDataMgr:getItemCount(cid)
			local idx
			if tonumber(cid) == 570002 then
				foo = self.costItems[2]
				idx = 2
				if count >= num then
					self.selectIdx = 2
					self.Button_break:setTouchEnabled(count >= num)
	            	self.Button_break:setGrayEnabled(count < num)
				end
			else
				foo = self.costItems[1]
				idx = 1
				if not self.selectIdx and count >= num then
					self.selectIdx = 1
					self.Button_break:setTouchEnabled(count >= num)
	            	self.Button_break:setGrayEnabled(count < num)
				end
			end
			foo.Panel_item:removeAllChildren()
			local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
	        Panel_goodsItem:Scale(0.7)
	        PrefabDataMgr:setInfo(Panel_goodsItem, cid)
	        Panel_goodsItem:AddTo(foo.Panel_item):Pos(0, 0)
	        foo.Label_name:setTextById(cfg.nameTextId)
	        foo.Label_cost:setString(count.."/"..num)
	        if count < num then
	        	foo.Label_cost:setColor(ccc3(219,50,50))
	        else
	        	foo.Label_cost:setColor(ccc3(48,53,74))
	        end
	        foo.root:setTouchEnabled(true)
	        foo.root:onClick(function()
	            self:onItemSelect(idx)

	            self.Button_break:setTouchEnabled(not self.isMax and count >= num)
	            self.Button_break:setGrayEnabled(self.isMax or count < num)
	        end)
	        break
		end
		
	end
	if not self.selectIdx then
		self.selectIdx = 2
	end
	self:onItemSelect(self.selectIdx)

	if self.isMax then
		self.Image_max:show()
		self.Panel_info:hide()
		self.Label_tips3:setTextById(63646)
		self.Button_break:setTouchEnabled(false)
    	self.Button_break:setGrayEnabled(true)
	else
		self.Label_tips3:setTextById(1329133)
	end
end

function FairyAngelEnergyBreakView:onItemSelect(idx)
	self.selectIdx = idx
	for i,foo in ipairs(self.costItems) do
		if i == idx then
			foo.Image_bg:setTexture("ui/fairy/new_ui/energy/ui_035.png")
			foo.Image_select:setVisible(true)
		else
			foo.Image_bg:setTexture("ui/fairy/new_ui/energy/ui_034.png")
			foo.Image_select:setVisible(false)
		end
	end
end

function FairyAngelEnergyBreakView:registerEvents()
    self.Button_break:onClick(function()
    	local costId
    	local heroid = self.heroid
    	for k,info in pairs(self.costData) do
    		for cid,num in pairs(info) do
    			if self.selectIdx == 2 and tonumber(cid) == 570002 then
	    			costId = tonumber(k)
	    			local function callback()
			    		HeroDataMgr:reqUpgradeAngleSpirit(heroid, costId)
			    	end

			    	if MainPlayer:getOneLoginStatus("LINGLIJUHEANGELTUPO") then
			    		callback();
			    	else
			    		local content = TextDataMgr:getText(1329147);
			    		Utils:openView("common.ReConfirmTipsView", {tittle = 1329146, content = content, reType = "LINGLIJUHEANGELTUPO", confirmCall = callback})
			    	end
			    	AlertManager:closeLayer(self)
	    			return
	    		else
	    			costId = tonumber(k)
	    		end
    		end
    	end

    	local function callback()
    		HeroDataMgr:reqUpgradeAngleSpirit(heroid, costId)
    	end

    	if MainPlayer:getOneLoginStatus("LINGLIJUHEANGELTUPO") then
    		callback();
    	else
    		local content = TextDataMgr:getText(1329149);
    		Utils:openView("common.ReConfirmTipsView", {tittle = 1329148, content = content, reType = "LINGLIJUHEANGELTUPO", confirmCall = callback})
    	end

    	AlertManager:closeLayer(self)
    end)

    self.Button_close:onClick(function()
		AlertManager:closeLayer(self)
	end)
end

return FairyAngelEnergyBreakView;
