local NewCityUpdateView = class("NewCityUpdateView", BaseLayer)

function NewCityUpdateView:ctor()
    self.super.ctor(self)
    self:initData()
    self:init("lua.uiconfig.newCity.newCityUpdateView")
end

function NewCityUpdateView:registerEvents()
    EventMgr:addEventListener(self, EV_NEW_CITY.resUpdateFinish, handler(self.onUpdateStatus, self))
end

function NewCityUpdateView:initData()

end

function NewCityUpdateView:initUI(ui)
    self.super.initUI(self,ui)
end

function NewCityUpdateView:onUpdateStatus()
    AlertManager:changeScene(SceneType.NewCity)
end

return NewCityUpdateView