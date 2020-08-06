
local MonthlyCardTipView = class("MonthlyCardTipView", BaseLayer)

local CardType = {
    MonthCard = 1,
    MonthCardEx = 2,
    --SeasonCard = 2,
    --HalfYearCard = 3,
}

function MonthlyCardTipView:initData()
    local cardData = RechargeDataMgr:getMonthCardList()
    local cardType = CardType.MonthCard
    self.cardData_ = cardData[cardType]
    GlobalVarDataMgr:setValue(GV_MONTH_CARD_TIP, false)
end

function MonthlyCardTipView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.recharge.monthlyCardTipView")
end

function MonthlyCardTipView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Label_remain_days = TFDirector:getChildByPath(Image_content, "Label_remain_days")
    self.Button_pay = TFDirector:getChildByPath(Image_content, "Button_pay")
    self.Label_pay = TFDirector:getChildByPath(self.Button_pay, "Label_pay")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")

    self:refreshView()
end

function MonthlyCardTipView:refreshView()
    self.Label_pay:setTextById(1605006, self.cardData_.rechargeCfg.price *0.01)
    self:updateRemainDay()
end

function MonthlyCardTipView:registerEvents()
    EventMgr:addEventListener(self, RechargeDataMgr.RESREWARDTOTALPAY, handler(self.onResRewardTotalPayRsp, self))
    EventMgr:addEventListener(self,EV_RECHARGE_UPDATE,handler(self.onRechargeUpdateEvent, self))

    self.Button_close:onClick(function()
            AlertManager:closeLayer(self)
    end)

    self.Button_pay:onClick(function()
            RechargeDataMgr:getOrderNO(self.cardData_.rechargeCfg.id)
    end)
end

function MonthlyCardTipView:updateRemainDay()
    local remainDay = RechargeDataMgr:getMonthCardLeftTime()
    self.Label_remain_days:setTextById(1605007, remainDay)
end

function MonthlyCardTipView:onResRewardTotalPayRsp(reward)
    Utils:showReward(reward)
end

function MonthlyCardTipView:onRechargeUpdateEvent()
    self:updateRemainDay()
end

return MonthlyCardTipView
