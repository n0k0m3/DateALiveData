
local LoadView  = require("lua.logic.load.LoadView")
local LoadScene = class("LoadScene", BaseScene)
function LoadScene:ctor(...)
    self.super.ctor(self, ...)
    local loadView = LoadView:new()
    self:addLayer(loadView)
    SpineCache:getInstance():clearUnused();
    me.TextureCache:removeUnusedTextures();
    collectgarbage("collect");
end
function LoadScene:onEnter()
    self.super.onEnter(self)
end
return LoadScene
