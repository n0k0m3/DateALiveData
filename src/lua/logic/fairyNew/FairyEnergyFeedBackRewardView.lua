local FairyEnergyFeedBackRewardView = class("FairyEnergyFeedBackRewardView", BaseLayer)


function FairyEnergyFeedBackRewardView:ctor(data)
    self.super.ctor(self,data)
    self:initData(data)
	self:showPopAnim(true)
    self:init("lua.uiconfig.fairyNew.fairyEnergyFeedBackRewardView")
end

function FairyEnergyFeedBackRewardView:initData(data)
	self.heroViews = data.heroViews
end

function FairyEnergyFeedBackRewardView:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui

	self.Panel_rewards_item = TFDirector:getChildByPath(ui,"Panel_rewards_item")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	self.Button_get = TFDirector:getChildByPath(ui,"Button_get")
	local Label_tips = TFDirector:getChildByPath(ui,"Label_tips")
	Label_tips:setTextById(63653)
	local ScrollView_rewards = TFDirector:getChildByPath(ui,"ScrollView_rewards")
	self.listView_rewards = UIListView:create(ScrollView_rewards)
	self.listView_rewards:setItemsMargin(5)

	self:updateUI()
end

function FairyEnergyFeedBackRewardView:updateUI()
	for i, data in ipairs(self.heroViews) do
		local rewardItem = self.Panel_rewards_item:clone()
		self.listView_rewards:pushBackCustomItem(rewardItem)
		local hero_item = TFDirector:getChildByPath(rewardItem,"Panel_hero_item")
		local icon = TFDirector:getChildByPath(hero_item,"Image_icon")
		icon:setTexture(HeroDataMgr:getIconPathById(data.hero))
		local Label_energy = TFDirector:getChildByPath(hero_item,"Label_energy")
		Label_energy:setString(data.level)

		local listView_goods = UIListView:create(TFDirector:getChildByPath(rewardItem,"ScrollView_goods"))
		listView_goods:setItemsMargin(5)
		for i,v in ipairs(data.rewards) do
			local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
	        Panel_goodsItem:Scale(0.8)
	        PrefabDataMgr:setInfo(Panel_goodsItem, v.id, v.num)
	        listView_goods:pushBackCustomItem(Panel_goodsItem)
		end
	end
end

function FairyEnergyFeedBackRewardView:registerEvents()
    self.Button_get:onClick(function()
    	HeroDataMgr:reqOldSpiritFeedback()
    	AlertManager:closeLayer(self)
    end)

    self.Button_close:onClick(function()
		AlertManager:closeLayer(self)
	end)
end

return FairyEnergyFeedBackRewardView
