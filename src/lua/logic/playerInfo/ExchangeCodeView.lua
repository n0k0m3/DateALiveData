local ExchangeCodeView = class("ExchangeCodeView", BaseLayer)

function ExchangeCodeView:ctor(data)
    self.super.ctor(self)
    self:initData(data)
    self:showPopAnim(true)
    self:init("lua.uiconfig.playerInfo.exchangeCodeView")
end

function ExchangeCodeView:initData(data)
 
end

function ExchangeCodeView:initUI(ui)
    self.super.initUI(self, ui)

    self.Button_ok = TFDirector:getChildByPath(self.ui,"Button_ok")
    self.TextField_exchangeCode = TFDirector:getChildByPath(self.ui,"TextField_exchangeCode")


    self.ui:setTouchEnabled(true)

    local params = {
        _type = EC_InputLayerType.OK,
        buttonCallback = function()
            self:onTouchSendBtn()
        end,
        closeCallback = function()
            self:onCloseInputLayer()
        end
    }
    self.inputLayer = require("lua.logic.common.InputLayer"):new(params)
    self:addLayer(self.inputLayer,1000);

end

function ExchangeCodeView:onTouchSendBtn()

end

function ExchangeCodeView:onExchangeGiftEvent(rewards)
    --礼包获取提示弹窗
    rewards = rewards or {}
    local gifts = {}
    for i,v in ipairs(rewards) do
        local gift = Utils:makeRewardItem(v.id, v.num)
        table.insert(gifts,gift)
    end
    AlertManager:close();
    Utils:showReward(gifts)
    if self.callBack_ then
        self.callBack_()
    end
end

function ExchangeCodeView:onCloseInputLayer()
    self.TextField_exchangeCode:closeIME()
end


function ExchangeCodeView:onChangeNameError()
    self.ui:timeOut(function() Utils:showTips(200006) end,0.1)
end

function ExchangeCodeView:registerEvents()
   EventMgr:addEventListener(self, EV_EXCHANGE_GIFT_CODE, handler(self.onExchangeGiftEvent, self))

    local function onTextFieldChangedHandleAcc(input)
        self.TextField_exchangeCode:setString(input:getText())
        self.inputLayer:listener(input:getText())
    end

    local function onTextFieldAttachAcc(input)
        self.inputLayer:show()
        self.inputLayer:listener(input:getText())
    end

    self.TextField_exchangeCode:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleAcc)
    self.TextField_exchangeCode:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
    self.TextField_exchangeCode:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)

    self.Button_ok:onClick(function()
        --兑换礼物
        local content = self.TextField_exchangeCode:getText()
        if content and #content > 0 then
            MainPlayer:sendExchangeGift(content)
        else
            -- toastMessage("发送内容不能为空")
            Utils:showTips(800104)
        end
    end,
    EC_BTN.CLOSE)

    self.ui:onClick(function()
            if not self.isDating then
                AlertManager:closeLayer(self);
            end
        end)
end

return ExchangeCodeView