local TeachCardShowView = class("TeachCardShowView", BaseLayer)

function TeachCardShowView:ctor()
    self.super.ctor(self)
    self:initData()
    self:showPopAnim(true)
    self:setUsepreProcesUI()
    self:init("lua.uiconfig.iphone.teachCardView")
end

function TeachCardShowView:initData()
    local data = Utils:getKVP(49007)
    self.monthCardData = data.monthCard
    self.weekCardData  = data.weekCard
    self.quarterCardData = data.quarterCard
    self.yearCardData    = data.yearCard
end

function TeachCardShowView:initUI(ui)
    self.super.initUI(self,ui)

	local ReChargeCfg = RechargeDataMgr:getOneRechargeCfg(self.weekCardData.id)
	local costCfg = GoodsDataMgr:getItemCfg(ReChargeCfg.exchangeCost[1].id)
	self._ui.costImgWeek:setTexture(costCfg.icon)
	self._ui.costImgWeek:setScale(0.5)
    self._ui.labWeekOldMoney:setText(ReChargeCfg.exchangeCost[1].num)
  
	local ReChargeCfg = RechargeDataMgr:getOneRechargeCfg(self.monthCardData.id)
	local costCfg = GoodsDataMgr:getItemCfg(ReChargeCfg.exchangeCost[1].id)
	self._ui.costImgMonth:setTexture(costCfg.icon)
	self._ui.costImgMonth:setScale(0.5)
    self._ui.labMonthOldMoney:setText(ReChargeCfg.exchangeCost[1].num)

	local ReChargeCfg = RechargeDataMgr:getOneRechargeCfg(self.quarterCardData.id)
	local costCfg = GoodsDataMgr:getItemCfg(ReChargeCfg.exchangeCost[1].id)
	self._ui.costImgQuarter:setTexture(costCfg.icon)
	self._ui.costImgQuarter:setScale(0.5)
    self._ui.labQuarterOldMoney:setText(ReChargeCfg.exchangeCost[1].num)

	local ReChargeCfg = RechargeDataMgr:getOneRechargeCfg(self.yearCardData.id)
	local costCfg = GoodsDataMgr:getItemCfg(ReChargeCfg.exchangeCost[1].id)
	self._ui.costImgYear:setTexture(costCfg.icon)
	self._ui.costImgYear:setScale(0.5)
    self._ui.labYearOldMoney:setText(ReChargeCfg.exchangeCost[1].num)
end

function TeachCardShowView:registerEvents()
	EventMgr:addEventListener(self, EV_GOODS_EXCHANGE, function()
		AlertManager:closeLayer(self)
	end)


    self._ui.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
    self._ui.btnWeek:onClick(function()
        RechargeDataMgr:getOrderNO(self.weekCardData.id)
        --AlertManager:closeLayer(self)
    end)
    
    self._ui.btnMonth:onClick(function()
        RechargeDataMgr:getOrderNO(self.monthCardData.id)
        --AlertManager:closeLayer(self)
    end)

    self._ui.btnQuarter:onClick(function()
        RechargeDataMgr:getOrderNO(self.quarterCardData.id)
        --AlertManager:closeLayer(self)
    end)

    self._ui.btnYear:onClick(function()
        RechargeDataMgr:getOrderNO(self.yearCardData.id)
        --AlertManager:closeLayer(self)
    end)
end

return TeachCardShowView
