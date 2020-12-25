
local ConfirmConvertView = class("ConfirmConvertView", BaseLayer)


function ConfirmConvertView:ctor()
    self.super.ctor(self)
    self:showPopAnim(true)
    self:init("lua.uiconfig.common.confirmConvertView")
end

function ConfirmConvertView:initUI(ui)
    self.super.initUI(self, ui)


    self.Label_title = TFDirector:getChildByPath(ui, "Label_title")
    self.Button_ok = TFDirector:getChildByPath(ui, "Button_ok")
    self.Button_close = TFDirector:getChildByPath(ui, "Button_cancel")
    self.Image_select_di = TFDirector:getChildByPath(ui,"Image_select_di")
    self.Image_select  = TFDirector:getChildByPath(ui,"Image_select"):hide()
    self.Label_content = TFDirector:getChildByPath(ui,"Label_content")
    self.Label_change = TFDirector:getChildByPath(ui,"Label_change")

    self.Label_content:setTextById(490026)
    self.Label_change:setTextById(800045)
end


function ConfirmConvertView:setCallback(callback)
    self.callback = callback
end

function ConfirmConvertView:setRecoverTipsShow(  )
    self.Label_content:setTextById(490032)
end

function ConfirmConvertView:setGoodTipsShow()
    self.Label_content:setTextById(490027)
end

function ConfirmConvertView:registerEvents()
    self.Image_select_di:onClick(function()
        if self.Image_select:isVisible() then
            self.Image_select:hide();
            MainPlayer:setOneLoginStatus(EC_OneLoginStatusType.ReConfirm_EquipConvert, 0)
        else
            self.Image_select:show();
            MainPlayer:setOneLoginStatus(EC_OneLoginStatusType.ReConfirm_EquipConvert, 1)
        end
    end)
    self.Button_ok:onClick(function()
            if type(self.callback) == "function" then
                local callback = self.callback
                AlertManager:closeLayer(self)
                callback()
            end
    end)
    self.Button_close:onClick(
        function()
            AlertManager:closeLayer(self)
        end,
        EC_BTN.CLOSE)
end

return ConfirmConvertView
