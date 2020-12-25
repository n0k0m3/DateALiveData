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
* 资源工具
* 
]]
local MapUtils = import("lua.logic.osd.MapUtils")
local ResLoader = require("lua.logic.battle.ResLoader")
local enum = require("lua.logic.battle.enum")
local eResType  =  enum.eResType
local eEffectType = enum.eEffectType

local BasicResUtils = BasicResUtils or {}

--[[-
    --进入同屏场景需要预加载的资源列表
    mapInfo: 地图数据
    heroList: 进入同屏返回的角色列表
-]]
function BasicResUtils:setCollectResListFunc( func )
	-- body
	self.getResList = function (self)
		return func(self)
	end
end

function BasicResUtils:createResInfo(resType, resName)
    return {resType = resType, resName = resName}
end

function BasicResUtils:loadAllRes(callFunc)
	AlertManager:changeScene(SceneType.Load)
    ResLoader.stopTimer()
    ResLoader.timer = TFDirector:addTimer(100, 1, nil, function ()
        ResLoader.stopTimer()
        local resList = self:getResList()
        ResLoader.startLoad(resList, callFunc)
    end) 
end

function BasicResUtils:clean()
	MapUtils:cleanMapParse()
	ResLoader.clean()
end

return BasicResUtils
