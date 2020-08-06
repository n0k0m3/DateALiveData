local ModifySuitNameView = class("ModifySuitNameView", BaseLayer)

function ModifySuitNameView:ctor(posId)
    self.super.ctor(self)
    self:initData(posId)
    self:showPopAnim(true)
    self:init("lua.uiconfig.Equip.modifySuitNameView")
end

function ModifySuitNameView:initData(posId)
    self.posId = posId
end

function ModifySuitNameView:initUI(ui)
    self.super.initUI(self, ui)

    self.Button_ok = TFDirector:getChildByPath(self.ui,"Button_ok")
    self.TextField_modifyName = TFDirector:getChildByPath(self.ui,"TextField_modifyName")
    self.Label_modifyName = TFDirector:getChildByPath(self.ui, "Label_modifyName")

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
    self.inputLayer = require("lua.logic.common.InputLayer"):new(params);
    self:addLayer(self.inputLayer,1000);

end

function ModifySuitNameView:onTouchSendBtn()
    self.TextField_modifyName:setText(self.Label_modifyName:getText())
end

function ModifySuitNameView:onCloseInputLayer()
    self.TextField_modifyName:closeIME()
end

function ModifySuitNameView:onChangeNameOk()
    if self.isChangeNameOk then
        return
    end
    Utils:showTips(800025)
    self.isChangeNameOk = true
    AlertManager:closeLayer(self)
end

function ModifySuitNameView:registerEvents()
    EventMgr:addEventListener(self, EQUIPMENT_SAVE_BACKUP_NAME, handler(self.onChangeNameOk, self))

    local function onTextFieldChangedHandleAcc(input)
        local text = input:getText()
        local list = string.UTF8ToCharArray(text)
        if #list <= 8 then
            local new_text = string.gsub(text, "·", "")
            input:setText(new_text)
            self.Label_modifyName:setText(input:getText())
            self.inputLayer:listener(input:getText())
            print("onTextFieldChangedHandleAcc")
        end
    end

    local function onTextFieldAttachAcc(input)
        local text = ""
        local new_text = string.gsub(text, "·", "")
        input:setText(new_text)
        self.inputLayer:show();
        self.inputLayer:listener(input:getText())
    end

    self.TextField_modifyName:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleAcc)
    self.TextField_modifyName:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
    self.TextField_modifyName:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)

    self.Button_ok:onClick(function()
        --修改预设名
        local text = self.Label_modifyName:getText()
        if #text == 0 or not self.Label_modifyName.isSet then
            -- toastMessage("发送内容不能为空")
            Utils:showTips(800104)
            return
        end
        if Utils:isStringContainSpecialChars(text) ~= nil then
            Utils:showTips(200006)
            return
        end
        EquipmentDataMgr:ReqSaveEquipBackupDecr(self.posId,text)
    end,
    EC_BTN.CLOSE)

    self.ui:onClick(function()
            if not self.isDating then
                AlertManager:closeLayer(self);
            end
        end)

    self.Label_modifyName:onClick(function()
        self.Label_modifyName:setText("")
        self.Label_modifyName.isSet = true
        self.TextField_modifyName:openIME()
    end)
end

return ModifySuitNameView