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
* 同屏基础场景
* 
]]

local BaseMapView = import(".BaseMapView")

local BaseOSDScene = class("BaseOSDScene", BaseScene)

function BaseOSDScene:ctor(...)
    self.super.ctor(self, ...)
    
end

function BaseOSDScene:onEnter()
	self.super.onEnter(self)

	self:addView()
end

function BaseOSDScene:addView()
	self.baseView = BaseMapView:new()
	self:addLayer(self.baseView)
	SkyLadderDataMgr:openMainView()
end

function BaseOSDScene:onExit()
    self.super.onExit(self)
end

return BaseOSDScene
