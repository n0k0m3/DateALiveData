--[[
    desc: 精灵调教卡页面
]] 
local RoleTeachBuyView = class("RoleTeachBuyView", BaseLayer)
local RoleTachMacro = require("lua.logic.datingPhone.RoleTachMacro")

function RoleTeachBuyView:ctor()
    self.super.ctor(self)
    self:initData()
    -- self:showPopAnim(true)
    self:setUsepreProcesUI()
    self:init("lua.uiconfig.iphone.roleTeachBuyView")
end

function RoleTeachBuyView:initData()
    local data = Utils:getKVP(49007)
    self.monthCardData   = data.monthCard
    self.weekCardData    = data.weekCard
    self.quarterCardData = data.quarterCard
    self.yearCardData    = data.yearCard
end

function RoleTeachBuyView:initUI(ui)
    self.super.initUI(self,ui)
    self._ui.labTxt:setTextById(14240014)

	local ReChargeCfg = RechargeDataMgr:getOneRechargeCfg(self.weekCardData.id)
	local costCfg = GoodsDataMgr:getItemCfg(ReChargeCfg.exchangeCost[1].id)
    --self._ui.labOldWeekNum:setText(self.weekCardData.oldPrice)
    self._ui.labWeekNum:setText(ReChargeCfg.exchangeCost[1].num)
	self._ui.costImgWeek:setTexture(costCfg.icon)

	local ReChargeCfg = RechargeDataMgr:getOneRechargeCfg(self.monthCardData.id)
	local costCfg = GoodsDataMgr:getItemCfg(ReChargeCfg.exchangeCost[1].id)
	--self._ui.labOldMonthNum:setText(self.monthCardData.oldPrice)
    self._ui.labMonthNum:setText(ReChargeCfg.exchangeCost[1].num)
	self._ui.costImgMonth:setTexture(costCfg.icon)

	local ReChargeCfg = RechargeDataMgr:getOneRechargeCfg(self.quarterCardData.id)
	local costCfg = GoodsDataMgr:getItemCfg(ReChargeCfg.exchangeCost[1].id)
	--self._ui.labOldQuarterNum:setText(self.quarterCardData.oldPrice)
    self._ui.labQuarterNum:setText(ReChargeCfg.exchangeCost[1].num)
	self._ui.costImgQuarter:setTexture(costCfg.icon)

	local ReChargeCfg = RechargeDataMgr:getOneRechargeCfg(self.yearCardData.id)
	local costCfg = GoodsDataMgr:getItemCfg(ReChargeCfg.exchangeCost[1].id)
    --self._ui.labOldYearNum:setText(self.yearCardData.oldPrice)
    self._ui.labYearNum:setText(ReChargeCfg.exchangeCost[1].num)
	self._ui.costImgYear:setTexture(costCfg.icon)
end

function RoleTeachBuyView:registerEvents()
    self._ui.btn_weekCard:onClick(function()
        RechargeDataMgr:getOrderNO(self.weekCardData.id)
    end)
    
    self._ui.btn_monthCard:onClick(function()
        RechargeDataMgr:getOrderNO(self.monthCardData.id)
    end)

    self._ui.btn_quarterCard:onClick(function()
        RechargeDataMgr:getOrderNO(self.quarterCardData.id)
    end)

    self._ui.btn_yearCard:onClick(function()
        RechargeDataMgr:getOrderNO(self.yearCardData.id)
    end)
    
    self._ui.btn_GoTeach:onClick(function()
        -- Utils:openView("datingPhone.RoleTeachFuncLayer", nil,RoleTachMacro.PAGETYPE.TEACH)
        Utils:openView("datingPhone.SceondAIChatView")
    end)
end

return RoleTeachBuyView