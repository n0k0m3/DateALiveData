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

local  WorldRoomExtendDataBasicControl = class("WorldRoomExtendDataBasicControl")

function WorldRoomExtendDataBasicControl:clearData(  )
	self.buffList = {}
	self.riddles = {}
end

function WorldRoomExtendDataBasicControl:parseWorldRelevantData( data )
    -- body
    self.extentData = json.decode(data.ext)
end

function WorldRoomExtendDataBasicControl:parseShowTimerData( data )
    -- body
    self.showTimeInfo = data.areaShowTime
end

function WorldRoomExtendDataBasicControl:getShowTimeInfo( ... )
    -- body
    return self.showTimeInfo or {}
end

function WorldRoomExtendDataBasicControl:getExtendData( ... )
    -- body
    return self.extentData or {}
end

function WorldRoomExtendDataBasicControl:parseAllRiddlesData( data )
	-- body
	self.riddles = self.riddles or {}
	if data.roomId ~= self.curRoomId then 
		self.riddles = {}
		self.curRoomId = data.roomId
	end
	local areaRiddles = data.areaRiddles
	for k,v in ipairs(areaRiddles) do
		self:changeRiddlesData(v)
	end
end

function WorldRoomExtendDataBasicControl:parseRiddlesData( data )
	-- body
	local areaRiddles = data.areaRiddles
	for k,v in ipairs(self.riddles) do
		if v.decryptTeamId == data.decryptTeamId then
			self:changeRiddleData(v, {riddles = data.riddles})
		end
	end
end

function WorldRoomExtendDataBasicControl:changeRiddlesData( riddle )
	-- body
	self.riddles = self.riddles or {}
	local addRiddle = false
	for _,_riddle in ipairs(self.riddles) do
		if _riddle.decryptTeamId == riddle.decryptTeamId then
			addRiddle = true
			self:changeRiddleData(_riddle,riddle)
		end
	end

	if not addRiddle then 
		table.insert(self.riddles,riddle) 
	end
end


function WorldRoomExtendDataBasicControl:parseActionCfg( cfgId, actorPid )
	-- body
	local cfg = TabDataMgr:getData("WorldObjectAction",cfgId)
	if not cfg then
		return
	end

	if cfg.result then
		for k,v in pairs(cfg.result) do
			if self[k.."_parseFunc"] then
				self[k.."_parseFunc"](self,v, actorPid)
			end
		end
	end
end

function WorldRoomExtendDataBasicControl:addBuffTargetChr_parseFunc( parama )
	-- body
	self.buffList = self.buffList or {}
	for k, v in ipairs(parama) do
		if table.find(self.buffList,v) == -1 then
			table.insert(self.buffList,v)
		end
	end
end

function WorldRoomExtendDataBasicControl:deleteBuffTargetChr_parseFunc( parama )
	-- body
	if not self.buffList then return end
	for k, v in ipairs(parama) do
		local index = table.find(self.buffList,v)
		if index ~= -1 then
			table.remove(self.buffList,index)
		end
	end
end

-- function WorldRoomExtendDataBasicControl:createFalseDecryptSign_parseFunc( parama, actorPid )
-- 	-- body
-- 	local actorNode = WorldRoomDataMgr:getCurControl():getActorNodeByPid(actorPid)
-- 	if not actorNode then return end
-- 	local pos = actorNode:getPosition()
-- 	self:changeRiddlesData({decryptTeamId = 1, riddles = {{ct = EC_SChangeType.ADD,
-- 										id = parama,
-- 										lox = pos.x,
-- 										loy = pos.y,
-- 										correct = false,
-- 										playerId = 0,
-- 										}}})
-- end

-- function WorldRoomExtendDataBasicControl:createTureDecryptSign_parseFunc( parama, actorPid )
-- 	-- body
-- 	local actorNode = WorldRoomDataMgr:getCurControl():getActorNodeByPid(actorPid)
-- 	if not actorNode then return end
-- 	local pos = actorNode:getPosition()
-- 	self:changeRiddlesData({decryptTeamId = 1,riddles = {{ct = EC_SChangeType.ADD,
-- 										id = parama,
-- 										lox = pos.x,
-- 										loy = pos.y,
-- 										correct = true,
-- 										playerId = 0,
-- 										}}})
-- end

-- function WorldRoomExtendDataBasicControl:deleteDecryptSign_parseFunc( parama, actorPid )
-- 	-- body
-- 	local actorNode = WorldRoomDataMgr:getCurControl():getActorNodeByPid(actorPid)
-- 	if not actorNode then return end
-- 	local pos = actorNode:getPosition()
-- 	self:changeRiddlesData({decryptTeamId = 1,riddles = {{ct = EC_SChangeType.ADD,
-- 										id = parama,
-- 										lox = pos.x,
-- 										loy = pos.y,
-- 										correct = false,
-- 										playerId = actorPid,
-- 										}}})
-- end

function WorldRoomExtendDataBasicControl:getBuffById( buffId )
	-- body
	if not self.buffList then return false end
	return table.find(self.buffList,buffId) ~= -1 
end

function WorldRoomExtendDataBasicControl:changeRiddleData( _riddle, riddle )
	-- body
	for k,v in pairs(riddle) do
		if k == "riddles" then
			_riddle[k] = _riddle[k] or {}
			for _k,_v in ipairs(v) do
				if _v.ct == EC_SChangeType.DELETE then
					for __k,__v in ipairs(_riddle[k]) do
						if __v.id == _v.id then
							table.remove(_riddle[k],__k)
						end
					end
				else
					local hasAdd = false
					for __k,__v in ipairs(_riddle[k]) do
						if __v.id == _v.id then
							_riddle[k][__k] = _v
							hasAdd = true
							break
						end
					end
					if not hasAdd then
						table.insert(_riddle[k],_v)
					end
				end
			end
		else
			_riddle[k] = v
		end
	end
end

function WorldRoomExtendDataBasicControl:getDecryptTeamData( decryptTeamId )
	-- body
	if not self.riddles then return nil end
	for _,_riddle in ipairs(self.riddles) do
		if _riddle.decryptTeamId == decryptTeamId then
			return _riddle
		end
	end
	return nil
end

function WorldRoomExtendDataBasicControl:getRiddleData(riddleId)
	-- body
	if not self.riddles then return nil end
	local riddleCfg = TabDataMgr:getData("Decrypt",riddleId)
	if not riddleCfg then return nil end
	local riddles = self:getDecryptTeamData(riddleCfg.team)
	if riddles then
		for k,v in ipairs(riddles.riddles) do
			if v.id == riddleId then
				return v
			end
		end
	end
	return nil
end

function WorldRoomExtendDataBasicControl:checkHasRiddleByPlayerId(pid)
	-- body
	if not self.riddles then return false end
	for k,v in ipairs(self.riddles) do
		for _k,_v in ipairs(v.riddles) do
			if _v.playerId == pid then
				return true
			end
		end
	end
	return false
end

function WorldRoomExtendDataBasicControl:getDecryptInfo(decryptTeamId)
	-- body
	if not self.riddles then return nil end
	if not decryptTeamId then return self.riddles end
	for k,v in ipairs(self.riddles) do
		if v.decryptTeamId == decryptTeamId then
			return v
		end
	end
	return nil
end

return WorldRoomExtendDataBasicControl