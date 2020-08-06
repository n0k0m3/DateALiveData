local PlayerAccountView = class("PlayerAccountView", BaseLayer)
local PlayerInfoConfig = require("lua.logic.playerInfo.PlayerInfoConfig")

function PlayerAccountView:initData(data)
    self.showid = MainPlayer:getAssistId()
    self.offsetX = data or 0
end

function PlayerAccountView:ctor(data)
    self.super.ctor(self)

    self:initData(data)
    self:init("lua.uiconfig.playerInfo.playerAccountView")
end

function PlayerAccountView:initUI(ui)
    self.super.initUI(self, ui)

    local params = {
        _type = EC_InputLayerType.SEND,
        buttonCallback = function()
            self:onTouchSendBtn()
        end,
        closeCallback = function()
            self:onCloseInputLayer()
        end
    }
    self.inputLayer = require("lua.logic.common.InputLayer"):new(params);
    self:addLayer(self.inputLayer,1000);
    self.inputLayer:setPositionX(-(GameConfig.WS.width - 1136) / 2);

    self:initInfo()
    self:refreshInfo()
end

function PlayerAccountView:initInfo()
    self.Image_bg = TFDirector:getChildByPath(self.ui,"Image_bg")
    self.Image_bg:PosX(self.Image_bg:PosX()+self.offsetX)
    self.Image_head = TFDirector:getChildByPath(self.ui,"Image_head")
    self.Label_playerName = TFDirector:getChildByPath(self.ui,"Label_playerName")
    self.Label_quality = TFDirector:getChildByPath(self.ui,"Label_quality")
    self.Button_modifyName = TFDirector:getChildByPath(self.ui,"Button_modifyName")
    self.Button_lianxi = TFDirector:getChildByPath(self.ui, "Button_lianxi")
    self.Button_mima = TFDirector:getChildByPath(self.ui, "Button_mima")

    self:initAccountInfo()
    self:initGift()
    self:initPhoneBind()
    self:initCertification()
end

function PlayerAccountView:refreshInfo()
    self.showid = MainPlayer:getAssistId()
    local headPath = HeroDataMgr:getPlayerIconPathById(self.showid)
    local qualityStr = HeroDataMgr:getQualityStringById(self.showid)
    local playerName = MainPlayer:getPlayerName()

    self.Image_head:setTexture(headPath)
    self.Label_quality:setString(qualityStr)
    self.Label_playerName:setString(playerName)
    self.Label_pb_name:setTextById(600029)
    self.Label_account_info:setTextById(600030)

    self:refreshAccountInfo()
    self:refreshGift()
end

function PlayerAccountView:initAccountInfo()
    self.Panel_account_info = TFDirector:getChildByPath(self.ui,"Panel_account_info")
    self.Label_account_info = TFDirector:getChildByPath(self.Panel_account_info,"Label_account_info")
    self.TextField_des = TFDirector:getChildByPath(self.ui,"TextField_des"):hide()
    self.Button_account_info_logout = TFDirector:getChildByPath(self.Panel_account_info,"Button_account_info_logout")
end

function PlayerAccountView:refreshAccountInfo()
    local accountStr = CCUserDefault:sharedUserDefault():getStringForKey("account")
    self.Label_account_info:setString(accountStr)
end

function PlayerAccountView:initPhoneBind()
    self.Panel_phoneBind = TFDirector:getChildByPath(self.ui, "Panel_phoneBind")
    self.Label_pb_name = TFDirector:getChildByPath(self.Panel_phoneBind, "Label_pb_name")
    self.Button_bind = TFDirector:getChildByPath(self.Panel_phoneBind, "Button_bind")
end

function PlayerAccountView:initCertification()
    self.Panel_certification = TFDirector:getChildByPath(self.ui, "Panel_certification")
    self.Label_account_info = TFDirector:getChildByPath(self.Panel_certification, "Label_account_info")
    self.Button_certification = TFDirector:getChildByPath(self.Panel_certification, "Button_certification")
end

function PlayerAccountView:initGift()
    self.Button_gift_exchange = TFDirector:getChildByPath(self.ui,"Button_gift_exchange")
end

function PlayerAccountView:refreshGift()

end

function PlayerAccountView:onTouchSendBtn()
    
end

function PlayerAccountView:onCloseInputLayer()
    EventMgr:dispatchEvent(PlayerInfoConfig.EV_OUTPUT)
    self.TextField_des:closeIME()
    self.TextField_des:setText("")
end

function PlayerAccountView:registerEvents()
    local function onTextFieldChangedHandleAcc(input)
        self.Label_gift_info:setString(input:getText())
        self.inputLayer:listener(input:getText())
    end

    local function onTextFieldAttachAcc(input)
        self.inputLayer:show();
        self.inputLayer:listener(input:getText())
        EventMgr:dispatchEvent(PlayerInfoConfig.EV_INPUT)
    end

    self.TextField_des:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleAcc)
    self.TextField_des:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
    self.TextField_des:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)


    self.Button_account_info_logout:onClick(function()
        --登出
        local logoutView = require("lua.logic.playerInfo.LogoutView"):new()
        AlertManager:addLayer(logoutView)
        AlertManager:show()
    end)

    self.Button_gift_exchange:onClick(function()
        local exchangeCodeView = require("lua.logic.playerInfo.ExchangeCodeView"):new()
        AlertManager:addLayer(exchangeCodeView)
        AlertManager:show()
    end)
    local serverid = ServerDataMgr:getCurrentServerID();
    self.Button_gift_exchange:setVisible((serverid ~= 999001));

    self.Button_modifyName:onClick(function()
        --改名
        local modifyNameView = require("lua.logic.playerInfo.ModifyNameView"):new()
        AlertManager:addLayer(modifyNameView)
        AlertManager:show()
    end)

    self.Button_bind:onClick(function()
        Box("绑定手机")
    end)

    self.Button_certification:onClick(function()
        if HeitaoSdk then
            HeitaoSdk.doAntiAddicationQuery();
        else
            Box("实名认证")
        end
    end)

    self.Button_lianxi:onClick(function()
        if HeitaoSdk then
            HeitaoSdk.isFunctionSupported("contactCustomerService");
        else
            Box("联系客服")
        end
    end)

    if HeitaoSdk and (HeitaoSdk.getplatformId() % 10000 == "101" or HeitaoSdk.getplatformId() % 10000 == "173") then
        self.Button_mima:show();
    else
        self.Button_mima:hide();
    end

    self.Button_mima:onClick(function()
        if HeitaoSdk then
            HeitaoSdk.isFunctionSupported("updatePassword");
        else
            Box("修改密码")
        end
    end)
end

return PlayerAccountView