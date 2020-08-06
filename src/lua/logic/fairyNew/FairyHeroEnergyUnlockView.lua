local FairyHeroEnergyUnlockView = class("FairyHeroEnergyUnlockView", BaseLayer)


function FairyHeroEnergyUnlockView:ctor(data)
    self.super.ctor(self,data)
    self.heroIds = data
    self:init("lua.uiconfig.fairyNew.fairyHeroEnergyUnlockView")
end

function FairyHeroEnergyUnlockView:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui

	local ScrollView_hero 		= TFDirector:getChildByPath(ui,"ScrollView_hero")
	self.label_title = TFDirector:getChildByPath(ui,"label_title")
	self.label_title:setTextById(1329140)

	self.ScrollView_hero =  UIListView:create(ScrollView_hero)
   	self.ScrollView_hero:setItemsMargin(-30)
	self.Spine_sprit_unlock = TFDirector:getChildByPath(ui, "Spine_sprit_unlock")


	for i,v in ipairs(self.heroIds) do
		local image_path = HeroDataMgr:getEquipShowHeroIconPath(v)
		local hero_image = Sprite:create(image_path)
		hero_image:setScale(0.6)
		self.ScrollView_hero:pushBackCustomItem(hero_image)
	end
	ScrollView_hero:setPositionX(100 + math.max(0, (6 - #self.heroIds) * 75))

	self.Spine_sprit_unlock:play("chuxian",false)
    self.Spine_sprit_unlock:addMEListener(TFARMATURE_COMPLETE,function()
        self.Spine_sprit_unlock:removeMEListener(TFARMATURE_COMPLETE)
        self.Spine_sprit_unlock:play("xunhuan",true)
    end) 

    self:timeOut(function()
		self.ui:setTouchEnabled(true)
        self.ui:onClick(function()
			AlertManager:closeLayer(self)
		end)
    end, 1)
end

return FairyHeroEnergyUnlockView;
