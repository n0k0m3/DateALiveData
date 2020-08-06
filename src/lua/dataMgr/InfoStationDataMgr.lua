local BaseDataMgr = import(".BaseDataMgr")
local InfoStationDataMgr = class("InfoStationDataMgr", BaseDataMgr)

InfoStationDataMgr.UPDATESTATION = "InfoStationDataMgr.UPDATESTATION"

function InfoStationDataMgr:ctor()
	self.station = nil
end

function InfoStationDataMgr:reset()
end

function InfoStationDataMgr:updateStation( station )
	self.station = station
end

function InfoStationDataMgr:getStationList( )
	return self.station
end

function InfoStationDataMgr:getIsOpen( )
	local station = self:getStationList()
	if station == nil then return false end
	return station.isOpen
end

function InfoStationDataMgr:getStartTime( )
	local station = self:getStationList()
	if station == nil then return 0 end
	return station.startTime
end

function InfoStationDataMgr:getEndTime( )
	local station = self:getStationList()
	if station == nil then return 0 end
	return station.endTime
end

function InfoStationDataMgr:getEnterState( )
	local serverTime = ServerDataMgr:getServerTime()
    local stationStartTime = self:getStartTime( )
    local stationEndTime = self:getEndTime( )
    return serverTime >= stationStartTime and serverTime < stationEndTime
end

return InfoStationDataMgr