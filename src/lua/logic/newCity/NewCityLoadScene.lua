local NewCityLoadScene = class("LoadScene", BaseScene)

function NewCityLoadScene:ctor(loadtype)
    self.super.ctor(self, loadtype)
    self.loadtimer = nil
    local loadView = nil
    if loadtype == EC_NewCityLoadType.Load then
        loadView = requireNew("lua.logic.newCity.NewCityLoadView"):new()
    elseif loadtype == EC_NewCityLoadType.Update then
        --loadView = requireNew("lua.logic.newCity.NewCityUpdateView"):new()
        loadView = requireNew("lua.logic.newCity.NewCityLoadView"):new()
    else
        loadView = requireNew("lua.logic.newCity.NewCityLoadView"):new()
    end
    self:addLayer(loadView)
end

function NewCityLoadScene:onEnter()
    self.super.onEnter(self)

    SpineCache:getInstance():clearUnused()
    me.TextureCache:removeUnusedTextures()
end

function NewCityLoadScene:onExit()
    self:stopAllActions()
    if self.loadtimer then
        TFDirector:removeTimer(self.loadtimer)
        self.loadtimer = nil
    end

    self.super.onExit(self)
end

return NewCityLoadScene
