
local RechargeJumpView = class("RechargeJumpView", BaseLayer)

function RechargeJumpView:initData(data)
    self.itmeID = data
end

function RechargeJumpView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.common.rechargeJumpView")
end

function RechargeJumpView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Label_title = TFDirector:getChildByPath(Image_content, "Label_title")
    self.Label_title_en = TFDirector:getChildByPath(Image_content, "Label_title_en")
    self.Button_recharge = TFDirector:getChildByPath(Image_content, "Button_recharge")
    self.Label_recharge = TFDirector:getChildByPath(Image_content, "Label_recharge")
    self.Label_tips = TFDirector:getChildByPath(Image_content, "Label_tips")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")

    self:refreshView()
end

function RechargeJumpView:refreshView()
    if self.itmeID == EC_SItemType.DIAMOND  then  
        self.Label_title:setTextById(800048)
        self.Label_tips:setTextById(800047)
        self.Label_recharge:setTextById(1454001)
    elseif self.itmeID == EC_SItemType.TokenMoney then
        self.Label_title:setTextById(14300073)
        self.Label_tips:setTextById(14300074)
        self.Label_recharge:setTextById(14300075)
    end
end

function RechargeJumpView:registerEvents()
    self.Button_recharge:onClick(function()
            AlertManager:closeLayer(self)
            if self.itmeID == EC_SItemType.TokenMoney then
                FunctionDataMgr:jPay(4)
            else
                FunctionDataMgr:jPay()
            end
    end)
    self.Button_close:onClick(function()
            AlertManager:closeLayer(self)
    end)
end

return RechargeJumpView
