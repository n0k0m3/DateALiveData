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


local DicuoLevelReady = requireNew("lua.logic.fuben.FubenReadyView")
DicuoLevelReady.__cname = "DicuoLevelReady"

local function ctor(self, ...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.diCuoLevelReadyView")
end
rawset(DicuoLevelReady, "ctor", ctor)

return DicuoLevelReady