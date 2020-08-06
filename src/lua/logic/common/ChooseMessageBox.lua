
function showChooseMessageBox(title, msg, okhandle, cancelhandle)
    local params = {
        ["title"]                   = title,
        ["message"]                 = msg,
        ["okhandle"]                = okhandle,
        ["cancelhandle"]            = cancelhandle,
    }

    local layer = require("lua.logic.common.ChooseMessageBox"):new(params)
    local currentScene = Public:currentScene()
    if currentScene.__cname == "LoginScene" then
        layer:setAnchorPoint(me.p(0.5,0.5))
        currentScene:addCustomLayer(layer)
    else
        AlertManager:addLayer(layer,nil,AlertManager.TWEEN_1)
        AlertManager:show()
        layer.isCanNotClose = true
    end
end


local ChooseMessageBox = class("ChooseMessageBox", BaseLayer)

function ChooseMessageBox:initData(data)
    self.params = data
end

function ChooseMessageBox:ctor(data)
    self.super.ctor(self)
    self:initData(data)
    self:init("lua.uiconfig.common.chooseMessageBox")
end

function ChooseMessageBox:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui

    self.Label_title = TFDirector:getChildByPath(self.ui, "Label_title")
    self.Button_ok = TFDirector:getChildByPath(self.ui, "Button_ok")
    self.Button_cancel = TFDirector:getChildByPath(self.ui, "Button_cancel")
    self.Label_content = TFDirector:getChildByPath(self.ui, "Label_content")

    if self.params.title then
        self.Label_title:setText(self.params.title)
    end
    if self.params.message then
        self.Label_content:setString(self.params.message)
    else
        self.Label_content:setString("")
    end
end

function ChooseMessageBox:registerEvents()
    self.Button_cancel:onClick(function()
        if self.params.cancelhandle then
            self.params.cancelhandle()
            return
        end

        local currentScene = Public:currentScene()
        if currentScene.__cname == "LoginScene" then
            self:removeFromParent()
        else
            AlertManager:closeLayer(self)
        end
    end)
    self.Button_ok:onClick(function()
        if self.params.okhandle then
            self.params.okhandle()
            return
        end
        local currentScene = Public:currentScene()
        if currentScene.__cname == "LoginScene" then
            self:removeFromParent()
        else
            AlertManager:closeLayer(self)
        end
    end)
end

return ChooseMessageBox
