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
* -- 找图小游戏
]]

local BaseDataMgr = import(".BaseDataMgr")
local BlockGameDataMgr = class("BlockGameDataMgr", BaseDataMgr)

function BlockGameDataMgr:ctor( data )
    TFDirector:addProto(s2c.ACTIVITY_RESP_SPEED_LINK_INFO, self, self.onRecvBlockInfo)
    TFDirector:addProto(s2c.ACTIVITY_RESP_RESET_SPEED_LINK, self, self.onRecvResetRsp)
    TFDirector:addProto(s2c.ACTIVITY_RESP_FLOP_SPEED_LINK, self, self.onRecvActionRsp)
	-- body
end

function BlockGameDataMgr:reset()

end

function BlockGameDataMgr:onRecvBlockInfo( event )
	-- body
	self.blockInfo_ = event.data.speedLink or {}
	self.successNum = math.floor(table.count(self.blockInfo_)/2)
	EventMgr:dispatchEvent(EV_BLOCKGAME_INFO_RSP)
end

function BlockGameDataMgr:onRecvResetRsp( event )
	-- body
	self.blockInfo_ = {}
	self.successNum = 0
	EventMgr:dispatchEvent(EV_BLOCKGAME_INFO_RSP)
end

function BlockGameDataMgr:onRecvActionRsp( event )
	-- body
	local data = event.data
	local speedInfo = data.speedLink
	local remove = data.remove or {}
	if speedInfo then
		table.insert(self.blockInfo_,speedInfo)
	end

	EventMgr:dispatchEvent(EV_BLOCKGAME_ACTION_RSP, data)

	-- 派发数据到游戏也没进行动作播放
	local removeList = {}
	for k,v in pairs(self.blockInfo_) do
		for _,removeIdx in pairs(remove) do
			if v.location == removeIdx then
				table.insert(removeList,v)
			end
		end 		
	end
	for k,v in pairs(removeList) do
		table.removeItem(self.blockInfo_,v)
	end

	self.successNum = math.floor(table.count(self.blockInfo_)/2)
end

function BlockGameDataMgr:choiceBlock( activityId, idx )
	TFDirector:send(c2s.ACTIVITY_REQ_FLOP_SPEED_LINK,{activityId,idx})
end

function BlockGameDataMgr:resqBlockInfo( activityId )
	TFDirector:send(c2s.ACTIVITY_REQ_SPEED_LINK_INFO,{activityId,idx})
end

function BlockGameDataMgr:resetGame( activityId )
	TFDirector:send(c2s.ACTIVITY_REQ_RESET_SPEED_LINK,{activityId,idx})
end

function BlockGameDataMgr:getBlockInfo_(  )
	-- body
	return self.blockInfo_
end

function BlockGameDataMgr:getSuccessNum(  )
	-- body
	return self.successNum
end

return BlockGameDataMgr:new()