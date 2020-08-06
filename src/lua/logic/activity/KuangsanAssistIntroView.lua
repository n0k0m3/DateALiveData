local KuangsanAssistIntroView = class("KuangsanAssistIntroView", BaseLayer)

function KuangsanAssistIntroView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.activity.kuangsanAssistIntroView")
end

function KuangsanAssistIntroView:initData()
    
end

function KuangsanAssistIntroView:initUI(ui)
    self.super.initUI(self,ui)

    self.Panel_reward_item = TFDirector:getChildByPath(ui, "Panel_reward_item")

    local Label_tittle = TFDirector:getChildByPath(ui, "Label_tittle")

    self.Button_close = TFDirector:getChildByPath(ui, "Button_close")

    self.Label_desc = TFDirector:getChildByPath(ui, "Label_desc")
    self.Label_desc:setTextById(14300081)
end

function KuangsanAssistIntroView:registerEvents()
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return KuangsanAssistIntroView
