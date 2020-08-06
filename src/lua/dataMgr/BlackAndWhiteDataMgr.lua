--[[黑与白数据管理]]
local BaseDataMgr = import(".BaseDataMgr")
local BlackAndWhiteDataMgr = class("BlackAndWhiteDataMgr", BaseDataMgr)

--[[初始化]]
function BlackAndWhiteDataMgr:init()
	--注册请求排行榜返回
	TFDirector:addProto(s2c.NEW_WORLD_RES_BLACK_WHITE_RANK, self, self.onRecvBlackAndWhiteRanking)
	--注册请求主面板
	TFDirector:addProto(s2c.NEW_WORLD_RES_BLACK_WHITE, self, self.onRecvBlackAndWhiteMain)
	--注册刷新
	TFDirector:addProto(s2c.NEW_WORLD_UPDATE_BLACK_WHITE_DAY_TIMES, self, self.onRecvBlackAndWhiteTimes)
	
	
	--读取黑与白HighTeamDungeon表配置
	highTeamDungeon = TabDataMgr:getData("HighTeamDungeon")
	self._highTeamDungeon = {}
    for k, v in pairs(highTeamDungeon) do
		if v.type == 6 then
			table.insert(self._highTeamDungeon, v.id)
		end
    end
	
end


--[[获取黑与白HighTeamDungeon表配置]]
function BlackAndWhiteDataMgr:getCfg()
	return self._highTeamDungeon
end

function BlackAndWhiteDataMgr:onRecvBlackAndWhiteMain(event)
	local data = event.data

	Utils:openView("blackAndWhite.BlackAndWhiteMainView",data)
    EventMgr:dispatchEvent(EV_ACTIVITY_BLACKWHITE_Main, data)
end

function BlackAndWhiteDataMgr:onRecvBlackAndWhiteTimes(event)
	local data = event.data 
	print("------------------------------------------------------------------onRecvBlackAndWhiteTimes")
	dump(data)
	EventMgr:dispatchEvent(EV_ACTIVITY_BLACKWHITE_Main_Update, data)
end

--[[请求排行榜数据回调]]
function BlackAndWhiteDataMgr:onRecvBlackAndWhiteRanking(event)
	print("---------------------------------------onRecvBlackAndWhiteRanking")
	local data = event.data

    EventMgr:dispatchEvent(EV_ACTIVITY_BLACKWHITE_RANKING, data)
end

--[[请求排行榜数据]]
function BlackAndWhiteDataMgr:send_NEW_WORLD_REQ_BLACK_WHITE_RANK()
	print("------------------------------------send_NEW_WORLD_REQ_BLACK_WHITE_RANK")
    TFDirector:send(c2s.NEW_WORLD_REQ_BLACK_WHITE_RANK, {})
end


function BlackAndWhiteDataMgr:send_NEW_WORLD_REQ_BLACK_WHITE()

	local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.BLACK_WHITE)
	if #activity > 0 then
	
		print("------------------------------------send_NEW_WORLD_REQ_BLACK_WHITE")
		TFDirector:send(c2s.NEW_WORLD_REQ_BLACK_WHITE, {})
	else
		Utils:showTips(219007)
	end
end


return BlackAndWhiteDataMgr:new()