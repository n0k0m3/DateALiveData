local FairyEnergyResetView = class("FairyEnergyResetView", BaseLayer)


function FairyEnergyResetView:ctor(data)
    self.super.ctor(self,data)
    self.energyType = data.energyType
	self:showPopAnim(true)
    self:init("lua.uiconfig.fairyNew.fairyEnergyResetView")
end

function FairyEnergyResetView:initData(data)

end

function FairyEnergyResetView:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui

	self.Label_tips1 	= TFDirector:getChildByPath(ui,"Label_tips1")
	self.Image_cost_res		= TFDirector:getChildByPath(ui,"Image_cost_res")
	self.Image_icon		= TFDirector:getChildByPath(ui,"Image_icon")
	self.Label_tips3	= TFDirector:getChildByPath(ui,"Label_tips3")
	self.Label_get	= TFDirector:getChildByPath(ui,"Label_get")
	self.Button_reset	= TFDirector:getChildByPath(ui,"Button_reset")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	self.Label_tips3:setTextById(1329126)
	self:updateUI()
end

function FairyEnergyResetView:updateUI()
	self.Image_icon:setTexture(HeroDataMgr:getEnergyResetAttrIcon(self.energyType))
	local exchange = TabDataMgr:getData("DiscreteData",51507).data.Exchange
	local data = HeroDataMgr:getHeroEnergyUseData()
	local usePoint = 0
	for k,v in pairs(data) do
		if tonumber(k) == self.energyType then	
			usePoint = v
		end
	end
	if table.count(exchange) < 1 then
		self.Image_cost_res:setVisible(false)
		self.Label_tips1:setTextById(1329125)
	else
		self.Image_cost_res:setVisible(true)
	end
	self.Label_get:setString("x0")
	self.Label_get:setString("x"..usePoint)
	self.Button_reset:setTouchEnabled(usePoint > 0)
    self.Button_reset:setGrayEnabled(usePoint <= 0)
end

function FairyEnergyResetView:registerEvents()
    self.Button_reset:onClick(function()
    	AlertManager:closeLayer(self)
    	HeroDataMgr:resetSpiritPoints(self.energyType)
    end)

    self.Button_close:onClick(function()
		AlertManager:closeLayer(self)
	end)
end

return FairyEnergyResetView;
