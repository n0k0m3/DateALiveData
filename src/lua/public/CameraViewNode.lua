--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
* 
]]

local CameraViewNode = class("CameraViewNode",function()
    return CCNode:create()
end)

function CameraViewNode:ctor( data )
	if HeitaoSdk then
		self.cameraRunning = true
		HeitaoSdk.initializeAR()
		HeitaoSdk.openAR()
	end
end

function CameraViewNode:register( )
	self:addMEListener(TFWIDGET_DRAW, handler(self.renderAR, self))
end

function CameraViewNode:dispose( ... )
	-- body
	if HeitaoSdk then
		HeitaoSdk.closeAR()
		HeitaoSdk.releaseAR()
	end
	self:removeMEListener(TFWIDGET_DRAW)
end

function CameraViewNode:renderAR()
	-- body
	--if not self:isVisible() then return end
	if HeitaoSdk then
		HeitaoSdk.renderAR()
	end
end

function CameraViewNode:changeCamera( )
	-- body
	if HeitaoSdk then
		HeitaoSdk.changeAR()
	end
end

return CameraViewNode