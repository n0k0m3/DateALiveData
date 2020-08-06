
local CrazyDiamondRechargeJumpView = class("CrazyDiamondRechargeJumpView", BaseLayer)

function CrazyDiamondRechargeJumpView:initData( activityId )
    self.activityId = activityId
end

function CrazyDiamondRechargeJumpView:ctor( activityId )
    self.super.ctor(self)
    self:initData(activityId)
    self:showPopAnim(true)
    self:init("lua.uiconfig.activity.crazyDiamondRechargeJumpView")
end

function CrazyDiamondRechargeJumpView:initUI(ui)
    self.super.initUI(self, ui)

    self.rootPanel = TFDirector:getChildByPath(ui, "panel_root")
    self.rechargeBtn = TFDirector:getChildByPath(self.rootPanel, "btn_recharge")
    self.closeBtn = TFDirector:getChildByPath(self.rootPanel, "btn_close")
    self.tipsLabel = TFDirector:getChildByPath(ui,"label_tips")

    local open = CrazyDiamondDataMgr:getOpen(self.activityId)
    local totalPayDiamond = RechargeDataMgr:getTotalPay()
    local payDiamond = math.max(0, open - totalPayDiamond*0.01)
    self.tipsLabel:setTextById(100000337, payDiamond)
end

function CrazyDiamondRechargeJumpView:registerEvents()
    self.rechargeBtn:onClick(function()
        AlertManager:closeLayer(self)       
        FunctionDataMgr:jPay()          
    end)
    self.closeBtn:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return CrazyDiamondRechargeJumpView
