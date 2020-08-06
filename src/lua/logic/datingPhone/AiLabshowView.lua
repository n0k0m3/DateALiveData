local AiLabshowView = class("AiLabshowView", BaseLayer)

function AiLabshowView:ctor(...)
    self.super.ctor(self)

    self:initData(...)
    self:showPopAnim(true)
    self:setUsepreProcesUI()
    self:init("lua.uiconfig.iphone.aiLabshowView")
end

function AiLabshowView:initData(type,txtId)
    self.type  = type or 1
    self.labId = txtId
end

function AiLabshowView:initUI(ui)
    self.super.initUI(self,ui)
    if self.type == 1 then
        self._ui.Image_contentS:show()
        self._ui.Image_contentB:hide()
        self._ui.labS:setLineHeight(55)
        self._ui.labS:setTextById(self.labId)
    else
        self._ui.Image_contentS:hide()
        self._ui.Image_contentB:show()
        self._ui.labB:setLineHeight(45)
        self._ui.labB:setWidth(650)
        self._ui.labB:setTextById(self.labId)
        self._ui.labB:retain()
        self._ui.labB:removeFromParent()
        local view = UIListView:create(self._ui.scrollViewB)
        view:pushBackCustomItem(self._ui.labB)
    end
end

function AiLabshowView:registerEvents()
    self._ui.Button_closeS:onClick(function()
        AlertManager:closeLayer(self)
    end)
    self._ui.Button_closeB:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return AiLabshowView
