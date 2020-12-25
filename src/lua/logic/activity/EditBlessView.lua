--

local EditBlessView = class("EditBlessView", BaseLayer)
local INPUT_LEN = 20

function EditBlessView:initData(friendId)
    self.friendId = friendId
    self.sendText = ""
    self.blessWords = TabDataMgr:getData("DiscreteData",48002).data.blessWords
end

function EditBlessView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.activity.editBlessView")
end

function EditBlessView:initUI(ui)
    self.super.initUI(self, ui)
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
    self:addLayer(self.inputLayer,1000)

end

function EditBlessView:onTouchSendBtn()
    self._ui.TextField_modifyName:setText(self._ui.Label_modifyName:getText())
end

function EditBlessView:onCloseInputLayer()
    self._ui.TextField_modifyName:closeIME()
end

function EditBlessView:registerEvents()
    EventMgr:addEventListener(self, EV_FRIEND_SENDWISH_SUCCESS,handler(self.onRecvIsSucces, self))

    local function onTextFieldChangedHandleAcc(input)
        local text = input:getText()
        self.sendText = text
        local list = string.UTF8ToCharArray(text)
        if #list <= INPUT_LEN then
            self._ui.Label_modifyName:setText(text)
            self.inputLayer:listener(text)
        end
    end

    local function onTextFieldAttachAcc(input)
        self.inputLayer:show()
        self.inputLayer:listener(input:getText())
    end

    self._ui.TextField_modifyName:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleAcc)
    self._ui.TextField_modifyName:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
    self._ui.TextField_modifyName:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)

    self._ui.Button_ok:onClick(function()
        local text = self._ui.Label_modifyName:getText()
        if #text == 0 or not self._ui.Label_modifyName.isSet then
            Utils:showTips(800104)
        else
            FriendDataMgr:send_SPRING_WISH_REQ_SEND_SPRING_WISH(self.friendId, self._ui.Label_modifyName:getText())
            AlertManager:closeLayer(self)
        end
    end)

    self.ui:onClick(function()
            AlertManager:closeLayer(self)
        end)

    self._ui.Label_modifyName:onClick(function()
        self._ui.Label_modifyName.isSet = true
        self._ui.TextField_modifyName:openIME()
    end)

    self._ui.Button_system:onClick(function()
        -- local chooseView = require("lua.logic.store.QuickBlessView"):new()
        -- AlertManager:addLayer(chooseView)
        -- AlertManager:show()
        -- chooseView:getChooseTxt(function(txt)
        --     self._ui.Label_modifyName:setText(txt)
        --     self._ui.Label_modifyName.isSet = true
        -- end)
        local randNum = math.random(1, #self.blessWords)
        self._ui.Label_modifyName:setTextById(self.blessWords[randNum])
        self._ui.Label_modifyName.isSet = true
    end)
end

function EditBlessView:onRecvIsSucces(data)
    if data.result == 1 then
        if data.rewards and #data.rewards > 0 then
            Utils:showReward(data.rewards)
        else
            Utils:showTips(12103027)
        end
    else
        local word = ""
        for i, v in ipairs(data.word) do
            word = word.." "..v
        end
        -- Utils:showTips( word..":是屏蔽词无法发送!")
        Utils:showTips(12103028)
    end
end

return EditBlessView