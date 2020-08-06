local PhoneScene = class("PhoneScene", BaseScene)
local TFClientUpdate =  TFClientResourceUpdate:GetClientResourceUpdate()
function PhoneScene:ctor(data)
	self.super.ctor(self,data)

	local layer = nil
	layer = require("lua.logic.datingPhone.PhoneMainViewAI"):new(data)
 	self:addLayer(layer)
end


function PhoneScene:onEnter(re)
	self.super.onEnter(self)
	AlertManager:closeAll();
	TFAudio.stopMusic()
end

function PhoneScene:onExit()
	self.super.onExit(self)
end

return PhoneScene;