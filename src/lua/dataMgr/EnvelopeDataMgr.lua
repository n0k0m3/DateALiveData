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

local BaseDataMgr = import(".BaseDataMgr")
local EnvelopeDataMgr = class("EnvelopeDataMgr", BaseDataMgr)

function EnvelopeDataMgr:init()
	-- body
    TFDirector:addProto(s2c.RED_ENVELOPE_RES_TRIGGER_SPRING_ENVELOPE,self,self.onRecvTriggerEnvelopeRsp)
    TFDirector:addProto(s2c.RED_ENVELOPE_RES_FIGHT_SPRING_ENVELOPE,self,self.onRecvCheckRedPacket)
    TFDirector:addProto(s2c.RED_ENVELOPE_SPRING_ENVELOPE_NOTICE,self,self.onRecvEvelopeInfo)
    self:reset()
end

function EnvelopeDataMgr:reset( ... )
	-- body
	self.envelopeInfos = {}
end

function EnvelopeDataMgr:reqRedPacket(cid, id, time)
    -- body
    TFDirector:send(c2s.RED_ENVELOPE_REQ_FIGHT_SPRING_ENVELOPE,{ id, time, cid})
end

--查看红包
function EnvelopeDataMgr:onRecvCheckRedPacket(event)
    local data = event.data
    if data then
        if data.redPacketDetailInfo.status == 1 then
            ChatDataMgr:updateCommonRedpacketStatus(data.redPacketDetailInfo.senderId, data.redPacketDetailInfo.createTime)
            Utils:openView("redPack.CommonOpenRedPacketView", data.redPacketDetailInfo)
        else
            if data.redPacketDetailInfo.status == -1 then
                Utils:showTips(63665)
            elseif data.redPacketDetailInfo.status == -2 then
                Utils:showTips(63666)
            end

            Utils:openView("redPack.CommonRedPacketDetailView", data.redPacketDetailInfo)
        end
        local getCount = data.redPacketDetailInfo.record and #data.redPacketDetailInfo.record or 0
        local count = data.redPacketDetailInfo.count - getCount
        ChatDataMgr:updateCommonRedpacketStatus(data.redPacketDetailInfo.senderId, data.redPacketDetailInfo.createTime, count)
    end
end

function EnvelopeDataMgr:onRecvTriggerEnvelopeRsp(event)
    local data = event.data
    if not data then return end
    if data.rewards then
        Utils:showReward(data.rewards)
    end
end

function EnvelopeDataMgr:triggerEnvelopeRsp(cid, bless)
    TFDirector:send(c2s.RED_ENVELOPE_REQ_TRIGGER_SPRING_ENVELOPE, { bless, cid})
end

function EnvelopeDataMgr:onRecvEvelopeInfo(event)
    local data = event.data
    if not data then return end
    if data.springEnvelopeInfo then
       	for k,v in pairs(data.springEnvelopeInfo) do
       		self.envelopeInfos[v.id] = v
       	end
    end
    EventMgr:dispatchEvent(EV_RED_POINT_UPDATE_CHAT)
end

function EnvelopeDataMgr:getRedEnvelopeInfo( id )
	-- body
	return self.envelopeInfos[id] or {id = id, sendCount = 0, receiveCount = 0, lastTime = 0, money = 0}
end

return EnvelopeDataMgr:new()
