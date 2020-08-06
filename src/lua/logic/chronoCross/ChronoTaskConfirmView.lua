
local ChronoTaskConfirmView = class("ChronoTaskConfirmView", BaseLayer)

function ChronoTaskConfirmView:initData(tipType,callback)
    self.tipType = tipType
    if type(tipType) == "table" then
        self.titleStrId = tipType.titleStrId
        self.tipStrId = tipType.tipStrId
    else
        self.titleStrId = tipType == 1 and 13310303 or 13310305
        self.tipStrId = tipType == 1 and 13310304 or 13310306
    end
    self.callback = callback
end

function ChronoTaskConfirmView:ctor(tipType,callback)
    self.super.ctor(self)
    self:initData(tipType,callback)
    self:showPopAnim(true)
    self:init("lua.uiconfig.chronoCross.chronoTaskConfirmView")
end

function ChronoTaskConfirmView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Label_title = TFDirector:getChildByPath(Image_content, "Label_title")
    self.Label_title_en = TFDirector:getChildByPath(Image_content, "Label_title_en")
    self.Button_ok = TFDirector:getChildByPath(Image_content, "Button_ok")
    self.Label_recharge = TFDirector:getChildByPath(Image_content, "Label_recharge")
    self.Label_tips = TFDirector:getChildByPath(Image_content, "Label_tips")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")
    self.Button_cancle = TFDirector:getChildByPath(Image_content, "Button_cancle")
    self:refreshView()
end

function ChronoTaskConfirmView:refreshView()
    self.Label_title:setTextById(self.titleStrId)
    self.Label_tips:setTextById(self.tipStrId)
end

function ChronoTaskConfirmView:registerEvents()

    self.Button_ok:onClick(function()
        if self.callback then
            self.callback()
            AlertManager:closeLayer(self)
        end
    end)
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
    self.Button_cancle:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return ChronoTaskConfirmView
