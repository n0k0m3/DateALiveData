local FairyEnergyBreakUp = class("FairyEnergyBreakUp", BaseLayer)


function FairyEnergyBreakUp:ctor(data)
    self.super.ctor(self,data)
    self.costData = HeroDataMgr:getEnergyBreakCost()
	self:showPopAnim(true)
    self:init("lua.uiconfig.fairyNew.fairyEnergyBreakUp")
end

function FairyEnergyBreakUp:initData(data)
	
end

function FairyEnergyBreakUp:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui


	self.Label_point_tips 	= TFDirector:getChildByPath(ui,"Label_point_tips")
	self.Label_point		= TFDirector:getChildByPath(ui,"Label_point")
	self.Panel_costItem		= TFDirector:getChildByPath(ui,"Panel_costItem")
	self.Button_cancel = TFDirector:getChildByPath(ui,"Button_cancel")
	self.Button_break = TFDirector:getChildByPath(ui,"Button_break")

	local ScrollView_cost = TFDirector:getChildByPath(ui,"ScrollView_cost")
	self.listView_cost = UIListView:create(ScrollView_cost)
	self.listView_cost:setItemsMargin(100)

	self.breakEnable = true
	self:updateUI()
end

function FairyEnergyBreakUp:updateUI()
	self.Button_break:setTouchEnabled(true)
    self.Button_break:setGrayEnabled(false)
	for i, v in ipairs(self.costData) do
		local costItem = self.Panel_costItem:clone()
		self.listView_cost:pushBackCustomItem(costItem)
		local item = TFDirector:getChildByPath(costItem,"Panel_item")
		local Label_count = TFDirector:getChildByPath(costItem,"Label_count")
		local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
	    PrefabDataMgr:setInfo(Panel_goodsItem, v.id, -1)
	    Panel_goodsItem:Pos(0, 0):AddTo(item)
	    local count = GoodsDataMgr:getItemCount(v.id)
	    Label_count:setText(count.."/"..v.num)
	    if count < v.num then
	    	Label_count:setColor(ccc3(219,50,50))
	    	self.Button_break:setTouchEnabled(false)
    		self.Button_break:setGrayEnabled(true)
    		self.breakEnable = false
	    else
	    	Label_count:setColor(ccc3(255,255,255))
	    end
	end
	
    local breakCfg = HeroDataMgr:getHeroEnergyBreakCfg(HeroDataMgr:getHeroEnergyBreakLevel())
    local curCfg = HeroDataMgr:getHeroEnergyBreakCfg(HeroDataMgr:getHeroEnergyBreakLevel() + 1)
	local rewardCount = 0
	local lastCount = breakCfg.BreakReward
	local curCount = curCfg.BreakReward
	rewardCount = math.max(0, curCount - lastCount)
	self.Label_point:setString("x"..rewardCount)
end

function FairyEnergyBreakUp:registerEvents()
    self.Button_break:onClick(function()
    	HeroDataMgr:reqUpgradeSpirit(0)
    	AlertManager:closeLayer(self)
    end)

    self.Button_cancel:onClick(function()
		AlertManager:closeLayer(self)
	end)
end

return FairyEnergyBreakUp
