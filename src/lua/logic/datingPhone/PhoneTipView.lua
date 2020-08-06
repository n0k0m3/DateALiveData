local PhoneTipView = class("PhoneTipView", BaseLayer)

function PhoneTipView:ctor(data)
    self.super.ctor(self)
    self:initData(data)
    self:showPopAnim(true)
    self:init("lua.uiconfig.iphone.PhoneTipView")
end

function PhoneTipView:initData(data)

    self.berforeValue = data.preNum
    self.afterValue = data.afterNum
    self.roleId = data.roleId
    self.itemId = data.itemId
end

function PhoneTipView:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui

    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")
    self.Button_ok = TFDirector:getChildByPath(self.ui, "Button_ok")
    self.Label_value1 = TFDirector:getChildByPath(self.ui, "Label_value1")
    self.Label_value2 = TFDirector:getChildByPath(self.ui, "Label_value2")
    self.Label_PhoneTipView_1 = TFDirector:getChildByPath(self.ui, "Label_PhoneTipView_1")

    self.Label_PhoneTipView_1:setTextById(13300277)
    self.Label_value1:setText(self.berforeValue)
    self.Label_value2:setText(self.afterValue)

end

function PhoneTipView:registerEvents()

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_ok:onClick(function()
        AlertManager:closeLayer(self)
    end)

end

return PhoneTipView