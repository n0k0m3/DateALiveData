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
local UtilsCheckCondFunc = class("UtilsCheckCondFunc")

function UtilsCheckCondFunc.check_itemState( parama )
	-- body
	local itemId, num = next(parama)
	return GoodsDataMgr:getItemCount(itemId) >= num
end

function UtilsCheckCondFunc.check_worldActorNumByChildType( parama )
	-- body
	if not WorldRoomDataMgr:getCurControl() or not WorldRoomDataMgr:getCurControl().getActorNumByChildType or #parama < 3 then
		return false
	end

	local  cmpType = parama[3]
	if cmpType == 1 then
		return WorldRoomDataMgr:getCurControl():getActorNumByChildType(parama[1]) <= parama[2]
	elseif cmpType == 2 then
		return WorldRoomDataMgr:getCurControl():getActorNumByChildType(parama[1]) >= parama[2]
	elseif cmpType == 3 then
		return WorldRoomDataMgr:getCurControl():getActorNumByChildType(parama[1]) == parama[2]
	elseif cmpType == 4 then
		return WorldRoomDataMgr:getCurControl():getActorNumByChildType(parama[1]) < parama[2]
	elseif cmpType == 5 then
		return WorldRoomDataMgr:getCurControl():getActorNumByChildType(parama[1]) > parama[2]
	end
	return false
end

function UtilsCheckCondFunc.check_catId( parama )
	-- body
	if not parama then return false end
	local catInfo = MaokaActivityMgr:getCatInfo(parama)
	return catInfo and catInfo.taskId == 0
end

function UtilsCheckCondFunc.check_catToyList( parama )
	-- body
	if not parama then return false end
	return MaokaActivityMgr:getToyInfo(parama) and true or false
end

function UtilsCheckCondFunc.check_catMaidId( parama )
	if not parama then return false end
	return MaokaActivityMgr:getMaidId() == parama
end

function UtilsCheckCondFunc.check_worldActorBuffId( parama )
	if not parama then return false end
	return WorldRoomDataMgr:getCurExtDataControl():getBuffById(parama)
end

function UtilsCheckCondFunc.check_worldRiddlesIsShow( parama )
	if not parama then return false end
	local riddleInfo = WorldRoomDataMgr:getCurExtDataControl():getRiddleData(parama)

	if not riddleInfo then return false end
	if riddleInfo.playerId ~= 0 then return false end
	if riddleInfo.correct then return false end
	return true
end

function UtilsCheckCondFunc.check_worldRiddlesIsCorrect( parama )
	if not parama then return false end
	local riddleInfo = WorldRoomDataMgr:getCurExtDataControl():getRiddleData(parama)
	if not riddleInfo then return false end
	return riddleInfo.correct
end

function UtilsCheckCondFunc.check_worldRiddlesData( parama )
	if not parama then return nil end
	local riddleInfo = WorldRoomDataMgr:getCurExtDataControl():getRiddleData(parama)
	return riddleInfo and true or false
end

function UtilsCheckCondFunc.check_worldRiddlesInMySelf( parama )
	if not parama then return nil end
	local riddleInfo = WorldRoomDataMgr:getCurExtDataControl():getRiddleData(parama)
	if not riddleInfo then return false end
	return riddleInfo.playerId == MainPlayer:getPlayerId()
end

function UtilsCheckCondFunc.check_worldRiddlesInActor( parama, actorPid )
	if not parama or not actorPid then return nil end
	local riddleInfo = WorldRoomDataMgr:getCurExtDataControl():getRiddleData(parama)
	if not riddleInfo then return false end
	return riddleInfo.playerId == actorPid
end

function UtilsCheckCondFunc.check_noWorldRiddles( parama )
	local hasRiddle =  WorldRoomDataMgr:getCurExtDataControl():checkHasRiddleByPlayerId(MainPlayer:getPlayerId())
	return not hasRiddle
end

function UtilsCheckCondFunc.check_worldDecryptSuccess( parama )
	local DecryptInfo = WorldRoomDataMgr:getCurExtDataControl():getDecryptInfo(parama)
	return DecryptInfo and DecryptInfo.success
end

function UtilsCheckCondFunc.get_worldRiddlesData( parama )
	if not parama then return nil end
	local riddleInfo = WorldRoomDataMgr:getCurExtDataControl():getRiddleData(parama)
	return riddleInfo
end

function UtilsCheckCondFunc.check_modelType( parama )
	if not parama then return nil end
	return  parama == WorldRoomDataMgr:getCurControl():getMainHero().modelType
end  

function UtilsCheckCondFunc.check_serverTimeRange( parama )
	if not parama then return nil end
	local curTime = ServerDataMgr:getServerTime()
	return  parama[1] <= curTime and parama[2] > curTime
end

function UtilsCheckCondFunc.check_repairsBuildLevel( parama )
	-- body
	local exp,level = ActivityDataMgr2:getBuildRepairInfo()
	return parama[1] <= level and parama[2] >= level
end   

function UtilsCheckCondFunc.check_worldDecryptResetTime( parama )
	-- body
	if not parama then return false end
	local riddleInfo = WorldRoomDataMgr:getCurExtDataControl():getDecryptTeamData(parama[1])
	if not riddleInfo then return false end
	local curTime = ServerDataMgr:getServerTime()
	return riddleInfo.nextTriggerTime - curTime >= parama[2]
end        

return UtilsCheckCondFunc