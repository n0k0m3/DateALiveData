

--[[
params = {
    ["message"]                 = message;
    ["okCallfunc"]              = okCallfunc;
    ["_type"]                   = MessageBoxType,
}
]]

EC_MessageBoxType = {
    ok = 1,
    okAndCancel = 2
}

function showMessageBox( msg , _type,okhandle , cancelhandle)
    local params = {
        ["message"]                 = msg,
        ["okhandle"]                = okhandle,
        ["cancelhandle"]            = cancelhandle,
        ["_type"]                   = _type,
    }

    local layer = require("lua.logic.common.MessageBox"):new(params)
    local currentScene = Public:currentScene();
    if currentScene.__cname == "LoginScene" then
        layer:setAnchorPoint(me.p(0.5,0.5))
        currentScene:addCustomLayer(layer)
    else
        AlertManager:addLayer(layer,nil,AlertManager.TWEEN_1)
        AlertManager:show()
        layer.isCanNotClose = true
    end
end

local MessageBox = class("MessageBox", BaseLayer)

CREATE_PANEL_FUN(MessageBox)

function MessageBox:ctor(data)
    self.super.ctor(self,data)
    self.params = data
    self:showPopAnim(true)
    self:init("lua.uiconfig.common.messageBox")
end

function MessageBox:initUI(ui)
    self.super.initUI(self,ui)

    self.Button_cancel      = TFDirector:getChildByPath(ui,"Button_cancel");
    self.Button_ok          = TFDirector:getChildByPath(ui,"Button_ok");
    self.tips               = TFDirector:getChildByPath(ui,"tips2");

    if self.params.message then
        self.tips:setString(self.params.message);
    end

    self.Button_cancel:setVisible(self.params._type == EC_MessageBoxType.okAndCancel);

    if self.params._type == EC_MessageBoxType.ok then
        self.Button_ok:setPositionX(self.Button_ok:getPositionX() - 235)
    end
end

function MessageBox:registerEvents()
    self.Button_cancel:addMEListener(TFWIDGET_CLICK,function ()
        if self.params.cancelhandle then
            self.params.cancelhandle();
            return
        end

        local currentScene = Public:currentScene();
        if currentScene.__cname == "LoginScene" then
            self:removeFromParent();
        else
            AlertManager:closeLayer(self)
        end
    end)

    self.Button_ok:addMEListener(TFWIDGET_CLICK,function()
        if self.params.okhandle then
            self.params.okhandle();
            return
        end
        local currentScene = Public:currentScene();
        if currentScene.__cname == "LoginScene" then
            self:removeFromParent();
        else
            AlertManager:closeLayer(self)
        end
    end)
end

function MessageBox:removeUI()
    self.super.removeUI(self);
end

return MessageBox;
