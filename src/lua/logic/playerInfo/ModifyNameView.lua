local ModifyNameView = class("ModifyNameView", BaseLayer)

local PlayerInfoConfig = require("lua.logic.playerInfo.PlayerInfoConfig")

function ModifyNameView:ctor(data)
    self.super.ctor(self)
    if type(data) ~= "table" then
        data = {data};
    end

    self:initData(data)
    self:showPopAnim(true)
    self:init("lua.uiconfig.playerInfo.modifyNameView")
end

function ModifyNameView:initData(data)
    self.callBack_ = data[1]
    self.isDating   = data[2]
end

function ModifyNameView:initUI(ui)
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

function ModifyNameView:onTouchSendBtn()
    self.TextField_modifyName:setText(self.Label_modifyName:getText())
    -- print("onTouchSendBtn")        --修改名字
    -- local text = self.TextField_modifyName:getText()
    -- if text and #text > 0 then
    --     if not MainPlayer:setPlayerName(text) then
    --         EventMgr:dispatchEvent(EV_CHANGE_NAME_ERROR)
    --     end
    --     self.TextField_modifyName:setText("")
    --     self.ui:timeOut(function()
    --         AlertManager:close()
    --         end,0.3)
    -- else
    --     toastMessage("发送内容不能为空")
    -- end
end

function ModifyNameView:onCloseInputLayer()
    self.TextField_modifyName:closeIME()
end

function ModifyNameView:onChangeNameOk()
    if self.isChangeNameOk then
        return
    end
    EventMgr:dispatchEvent(EV_CHANGE_NAME_OK_TIP)
    self.isChangeNameOk = true
    print("ModifyNameView:onChangeNameOk")
    if self.callBack_ then
        self.callBack_()
    end
    AlertManager:closeLayer(self);
end

function ModifyNameView:onChangeNameError()
    self.ui:timeOut(function() Utils:showTips(200006) end,0.1)
end

function ModifyNameView:registerEvents()

    EventMgr:addEventListener(self, EV_CHANGE_NAME_OK, handler(self.onChangeNameOk, self))
    EventMgr:addEventListener(self, EV_CHANGE_NAME_ERROR, handler(self.onChangeNameError, self))

    local function onTextFieldChangedHandleAcc(input)
        local text = input:getText()
        local list = string.UTF8ToCharArray(text)
        if #list <= 15 then
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
        print("onTextFieldAttachAcc")
        -- EventMgr:dispatchEvent(PlayerInfoConfig.EV_INPUT)
    end

    self.TextField_modifyName:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleAcc)
    self.TextField_modifyName:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
    self.TextField_modifyName:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)

    self.Button_ok:onClick(function()
        --修改名字
        local text = self.Label_modifyName:getText()
        if #text == 0 or not self.Label_modifyName.isSet then
            -- toastMessage("发送内容不能为空")
            Utils:showTips(800104)
        elseif not MainPlayer:setPlayerName(text) then
            EventMgr:dispatchEvent(EV_CHANGE_NAME_ERROR)
        else
            -- if self.callBack_ then
            --     self.callBack_()
            -- end
            -- AlertManager:close()
            EventMgr:dispatchEvent(EV_UPDATE_PLAYERINFO)
        end
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

return ModifyNameView