local BaseDataMgr = import(".BaseDataMgr")
local MainAdDataMgr = class("MainAdDataMgr", BaseDataMgr)

function MainAdDataMgr:ctor()
    self:init()
    self.mainAdInfo = {}
end

function MainAdDataMgr:init()
	TFDirector:addProto(s2c.SIGN_RESP_MAIN_AD_BOARD_INFO, self, self.onRecvMainAdInfo)
end

function MainAdDataMgr:onRecvMainAdInfo(event)

	local data = event.data
    if not data then 
    	return 
    end
    -- dump(data)
    -- self.mainAdInfo = data.mainAdBoardInfo
    -- EventMgr:dispatchEvent(EV_MAIN_AD);
    local mainAdList = {}
    for i,_data in ipairs(data.mainAdBoardInfo) do
        if not(_data.activityType == 4) then
            table.insert(mainAdList, _data)
        end
    end
    self.mainAdInfo = mainAdList
    EventMgr:dispatchEvent(EV_MAIN_AD);
    
    local station = nil
    for i,_data in ipairs(data.mainAdBoardInfo) do
        if _data.activityType == 4 then
            station = _data
            break
        end
    end
    InfoStationDataMgr:updateStation( station )
    EventMgr:dispatchEvent(InfoStationDataMgr.UPDATESTATION)
end

function MainAdDataMgr:getAdInfoById(id)

    for k,v in ipairs(self.mainAdInfo) do
        if v.Id == id then
            return v
        end
    end

end

function MainAdDataMgr:getMainBoardInfo()
	return self.mainAdInfo
end

function MainAdDataMgr:onLogin()

	TFDirector:send(c2s.SIGN_REQ_MAIN_AD_BOARD_INFO, {})
	return {s2c.SIGN_RESP_MAIN_AD_BOARD_INFO}
end



return MainAdDataMgr:new();
