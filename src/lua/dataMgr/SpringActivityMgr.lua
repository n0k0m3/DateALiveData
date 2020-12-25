--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local BaseDataMgr = import(".BaseDataMgr")
local SpringActivityMgr = class("SpringActivityMgr", BaseDataMgr)


function SpringActivityMgr:init()
	TFDirector:addProto(s2c.SPRING_FESTIVAL_REQ2020_FESTIVAL_GAME_INIT, self, self.onStatus)

end


function SpringActivityMgr:requestLittleGame(city, point)
	TFDirector:send(c2s.SPRING_FESTIVAL_REQ2020_FESTIVAL_GAME_INIT, {city, point})
end

function SpringActivityMgr:onStatus(event)
	local data = event.data
	if data == nil then
		return
	end
	EventMgr:dispatchEvent(EV_SPRING_ACTIVITY_INIT, data)
end


return SpringActivityMgr




--endregion
