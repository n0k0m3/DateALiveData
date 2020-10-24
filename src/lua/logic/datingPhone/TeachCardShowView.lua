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

    self._ui.labWeekOldMoney:setText(self.weekCardData.oldPrice)
    self._ui.labWeekMoney:setText(self.weekCardData.newPrice)

    self._ui.labMonthOldMoney:setText(self.monthCardData.oldPrice)
    self._ui.labMonthMoney:setText(self.monthCardData.newPrice)

    self._ui.labQuarterOldMoney:setText(self.quarterCardData.oldPrice)
    self._ui.labQuarterMoney:setText(self.quarterCardData.newPrice)

    self._ui.labYearOldMoney:setText(self.yearCardData.oldPrice)
    self._ui.labYearMoney:setText(self.yearCardData.newPrice)
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
        AlertManager:closeLayer(self)
    end)
    
    self._ui.btnMonth:onClick(function()
        RechargeDataMgr:getOrderNO(self.monthCardData.id)
        AlertManager:closeLayer(self)
    end)

    self._ui.btnQuarter:onClick(function()
        RechargeDataMgr:getOrderNO(self.quarterCardData.id)
        AlertManager:closeLayer(self)
    end)

    self._ui.btnYear:onClick(function()
        RechargeDataMgr:getOrderNO(self.yearCardData.id)
        AlertManager:closeLayer(self)
    end)
end

return TeachCardShowView
