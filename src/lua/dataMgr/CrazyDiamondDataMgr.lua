local BaseDataMgr = import(".BaseDataMgr")
local CrazyDiamondDataMgr = class("CrazyDiamondDataMgr", BaseDataMgr)

function CrazyDiamondDataMgr:ctor()
    self:init()
end

function CrazyDiamondDataMgr:init()
	self.activityList = {}
	self.crazyDiamondCfgList = {}
	for _,_cfg in pairs(TabDataMgr:getData("CrazyDiamond")) do
		table.insert(self.crazyDiamondCfgList, _cfg)
	end
	table.sort(self.crazyDiamondCfgList, function( a,b )
		return a.id < b.id
	end)

	TFDirector:addProto(s2c.ACTIVITY_RESP_CRAZY_DIAMOND_DRAW, self, self.onRespCrazyDiamondDrawRsp)
end

--true: 表示为抽奖，false：表示为获取活动信息
function CrazyDiamondDataMgr:sendReqCrazyDiamondDraw( activityId, isDraw )
	TFDirector:send(c2s.ACTIVITY_REQ_CRAZY_DIAMOND_DRAW, {activityId, isDraw})
end

function CrazyDiamondDataMgr:onRespCrazyDiamondDrawRsp( event )
	local data = event.data
	local exit = false
	for i,_activity in ipairs(self.activityList) do
		if _activity.id == data.id then
			_activity.allCrazyDiamondRank = data.allCrazyDiamondRank
			_activity.ownCrazyDiamondRank = data.ownCrazyDiamondRank
			_activity.diamondNum = data.diamondNum
			_activity.surplusDraw = data.surplusDraw
			_activity.totalMoney = data.totalMoney
			exit = true
			break
		end
	end
	if(not exit) then
		table.insert(self.activityList, data)
	end
	EventMgr:dispatchEvent(EV_ACTIVITY_RESP_CRAZY_DIAMOND_DRAW, data)
end

--抽奖总榜
function CrazyDiamondDataMgr:getAllCrazyDiamondRank( id )
	for i,_activity in ipairs(self.activityList) do
		if _activity.id == id then
			return _activity.allCrazyDiamondRank or {}
		end
	end
	return {}
end

--个人抽奖信息统计
function CrazyDiamondDataMgr:getOwnCrazyDiamondRank( id )
	for i,_activity in ipairs(self.activityList) do
		if _activity.id == id then
			return _activity.ownCrazyDiamondRank or {}
		end
	end
	return {}
end

--当前轮次抽奖获取的钻石数
function CrazyDiamondDataMgr:getDiamondNum( id )
	for i,_activity in ipairs(self.activityList) do
		if _activity.id == id then
			return _activity.diamondNum
		end
	end
	return 0
end

--剩余抽奖次数
function CrazyDiamondDataMgr:getSurplusDraw( id )
	for i,_activity in ipairs(self.activityList) do
		if _activity.id == id then
			return _activity.surplusDraw
		end
	end
	return 0
end

function CrazyDiamondDataMgr:getActivityInfo( id )
	local activityInfo = ActivityDataMgr2:getActivityInfo(id)
	return activityInfo
end

--剩余抽奖次数
function CrazyDiamondDataMgr:getSurplusAndMaxDraw( id )
	for i,_activity in ipairs(self.activityList) do
		if _activity.id == id then
			return _activity.surplusDraw, #self.crazyDiamondCfgList
		end
	end
	return #self.crazyDiamondCfgList,#self.crazyDiamondCfgList
end

--剩余次数对应的最高钻石数和最低钻石数
function CrazyDiamondDataMgr:getminRewardAndMaxReward( id )
	local ownCrazyDiamondRank = self:getOwnCrazyDiamondRank(id)
	for i,_cfg in ipairs(self.crazyDiamondCfgList) do
		if _cfg.id == (#ownCrazyDiamondRank + 1) then
			return _cfg.minReward, _cfg.maxReward
		end
	end
	return self.crazyDiamondCfgList[#self.crazyDiamondCfgList].minReward, self.crazyDiamondCfgList[#self.crazyDiamondCfgList].maxReward
end
--获取钻石面板显示数量
function CrazyDiamondDataMgr:getDiamondRewardShow( id  , oldRank)
	local ownCrazyDiamondRank = oldRank or self:getOwnCrazyDiamondRank(id)
	for i,_cfg in ipairs(self.crazyDiamondCfgList) do
		if _cfg.id == (#ownCrazyDiamondRank + 1) then
			return _cfg.rewardShow
		end
	end
	return self.crazyDiamondCfgList[#self.crazyDiamondCfgList].rewardShow
end

--钻石消耗
function CrazyDiamondDataMgr:getCost( id )
	local ownCrazyDiamondRank = self:getOwnCrazyDiamondRank(id)
	if #ownCrazyDiamondRank >= #self.crazyDiamondCfgList then
		local array = string.split(self.crazyDiamondCfgList[#self.crazyDiamondCfgList].cost, ":")
		return tonumber(array[1]),tonumber(array[2])
	end

	for i,_cfg in ipairs(self.crazyDiamondCfgList) do
		if _cfg.id == (#ownCrazyDiamondRank + 1) then
			local array = string.split(_cfg.cost, ":")
			return tonumber(array[1]),tonumber(array[2])
		end
	end
	return 0,0
end

--充值数
function CrazyDiamondDataMgr:getOpen( id )
	local ownCrazyDiamondRank = self:getOwnCrazyDiamondRank(id)
	if #ownCrazyDiamondRank >= #self.crazyDiamondCfgList then
		return 0
	end
	for i,_cfg in ipairs(self.crazyDiamondCfgList) do
		if _cfg.id == (#ownCrazyDiamondRank + 1) then
			return _cfg.open
		end
	end
	return 0
end

--获取疯狂砖石活动信息
function CrazyDiamondDataMgr:sendOpenReqCrazyDiamondDraw( )
	local activityList = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.CRAZY_DIAMOND)
	for i,_activity in ipairs(activityList) do
		self:sendReqCrazyDiamondDraw(_activity, false)
	end
end

--红点状态
function CrazyDiamondDataMgr:getCrazyDiamondRedPoint( id )
	return self:getSurplusDraw(id) > 0
end

--获取招财猫累充
function CrazyDiamondDataMgr:getTotalPay(id )
	for i,_activity in ipairs(self.activityList) do
		if _activity.id == id then
			return _activity.totalMoney
		end
	end
	return 0
end

return CrazyDiamondDataMgr:new()