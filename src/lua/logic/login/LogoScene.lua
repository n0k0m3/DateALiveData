local LogoScene = class("LogoScene", BaseScene)

function LogoScene:ctor(data)
	self.super.ctor(self,data)

	local layer = nil
	layer = require("lua.logic.login.LogoLayer"):new()
    self:addLayer(layer)
end


function LogoScene:onEnter()
	self.super.onEnter(self)
end

function LogoScene:onExit()
	self.super.onExit(self)
end

return LogoScene;