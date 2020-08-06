local NewCityMainScene = class("NewCityMainScene", BaseScene)

function NewCityMainScene:ctor()
    self.super.ctor(self)

    local layer = requireNew("lua.logic.newCity.NewCityMainLayer"):new()
    self:addLayer(layer)
    self.cityLayer = layer

    --SpineCache:getInstance():clearUnused()
    --me.TextureCache:removeUnusedTextures()
end

function NewCityMainScene:onEnter()
    self.super.onEnter(self)
    --TFDirector:send(c2s.SHARE_REQ_INTO_PANEL,{1})
end

function NewCityMainScene:onExit()
    self.super.onExit(self)
    --TFDirector:send(c2s.SHARE_REQ_INTO_PANEL,{0})
end

function NewCityMainScene:onKeyBack()
    if self.cityLayer then
		self.cityLayer:onKeyBack()
	end
end

return NewCityMainScene
