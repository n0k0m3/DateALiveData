
local SummonSpeedView = class("SummonSpeedView", BaseLayer)

function SummonSpeedView:initData()

end

function SummonSpeedView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.summon.summonSpeedView")
end

function SummonSpeedView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    local Image_bg = TFDirector:getChildByPath(ui, "Image_bg")
    self.Button_close = TFDirector:getChildByPath(Image_bg, "Button_close")
    self.Label_title = TFDirector:getChildByPath(Image_bg, "Label_title")
    self.Button_ok = TFDirector:getChildByPath(Image_bg, "Button_ok")
    self.Label_content = TFDirector:getChildByPath(Image_bg, "Label_content")
end

function SummonSpeedView:setContent(formatId,params)
    self.Label_content:setTextById(formatId, unpack(params))
end

function SummonSpeedView:setCallback(callback)
    self.callback_ = callback
end

function SummonSpeedView:registerEvents()
    self.Button_close:onClick(
        function()
            AlertManager:closeLayer(self)
        end,
        EC_BTN.CLOSE)

    self.Button_ok:onClick(function()
            if type(self.callback_) == "function" then
                local callback = self.callback_
                AlertManager:closeLayer(self)
                callback()
            end
    end)
end

return SummonSpeedView
