local BaseDataMgr = import(".BaseDataMgr")
local MailDataMgr = class("MailDataMgr", BaseDataMgr)

local MailType = {
	systemMail = 1,
	redPackMail = 2,
}

function MailDataMgr:ctor()
    self:init()
    self.mails = {}
end

function MailDataMgr:init()
	TFDirector:addProto(s2c.MAIL_MAIL_INFO_LIST, self, self.recvMailList)
	TFDirector:addProto(s2c.MAIL_RESP_OPERATION, self, self.revcSeeMail)
	TFDirector:addProto(s2c.RED_ENVELOPE_RED_ENVELOPE_NOTICE, self, self.recvRedEnvelopeList)
	TFDirector:addProto(s2c.RED_ENVELOPE_NEW_ENVELOPE_NOTICE, self, self.recvNewRedEnvelope)
	TFDirector:addProto(s2c.RED_ENVELOPE_RES_OPEN_ENVELOPE, self, self.revcOpenEnvelope)
	TFDirector:addProto(s2c.RED_ENVELOPE_RES_OPEN_ALL_ENVELOPE, self, self.revcOpenAllEnvelope)
	TFDirector:addProto(s2c.RED_ENVELOPE_RES_FIGHT_ENVELOPE, self, self.revcFightEnvelope)
end

function MailDataMgr:onLogin()
	EventMgr:addEventListener(self,EV_OFFLINE_EVENT, handler(self.onLoginOut,self))
	TFDirector:send(c2s.MAIL_GET_MAILS, {})
	return {s2c.MAIL_MAIL_INFO_LIST}
end

function MailDataMgr:getMailCount(mailType)
	local count = 0
	for k,v in pairs(self.mails) do
		if v.mailType == mailType then
			count = count + 1
		end
	end
	return count
end

function MailDataMgr:getMailTyps()
	-- body
	--屏蔽邮件红包
	local types = {[MailType.systemMail] = 1,--[[[MailType.redPackMail] = 1]]}
	for k,v in pairs(self.mails) do
		types[v.mailType] = 1
	end
	return table.keys(types)
end

function MailDataMgr:getMailUnReceiveCount(mailType)
	local count = 0
	for k,v in pairs(self.mails) do
		if v.mailType == mailType and v.status ~= 2 and v.rewards and table.count(v.rewards) > 0 then
			count = count + 1
		end
	end
	return count
end

function MailDataMgr:getMailId(index)
	return self.showList[index].id
end

function MailDataMgr:getMailShowIndex(id)
	for i,v in ipairs(self.showList) do
		if v.id == id then
			return i;
		end
	end
	return -1
end

function MailDataMgr:getMailHaveRewards(index)
	return self.showList[index].rewards and table.count(self.showList[index].rewards) > 0
end

function MailDataMgr:onLoginOut()
	self.mails = {};
end

function MailDataMgr:checkRedPoint()
	local ret = false;
	for k,v in pairs(self.mails) do
		if v.status == 0 or v.mailType == MailType.redPackMail then
			ret = true;
			break
		end
	end

	return ret;
end

function MailDataMgr:checkRedPointByMailType(mailType)
	local ret = false;
	for k,v in pairs(self.mails) do
		if v.mailType == mailType then
			if v.status == 0 or v.mailType == MailType.redPackMail then
				ret = true;
				break
			end
		end
	end

	return ret;
end

function MailDataMgr:getOneMail(idx)
	local mailInfo = clone(self.showList[idx])
	local strTag = "#####"
	mailInfo.isStrId = string.find(mailInfo.title , strTag)
	if mailInfo.isStrId then
		local strTitle = string.split(mailInfo.title , strTag)
		local strBody = string.split(mailInfo.body , strTag)

		if GAME_LANGUAGE_VAR == EC_LanguageType.Chinese then
			mailInfo.title = strTitle[1]
			mailInfo.body = strBody[1]
		else
			mailInfo.title = strTitle[2] or mailInfo.title
			mailInfo.body = strBody[2] or mailInfo.body
		end
	else
		local bodyStr = string.split(mailInfo.body , ',')
		if #bodyStr > 1 then
			mailInfo.isStrId = true
			local  symbol  = {}
			local bodyInfo = TextDataMgr:getTextAttrCanNil(bodyStr[1])
			if bodyInfo then
				bodyInfo = TextDataMgr:getText(bodyStr[1])
			else
				bodyInfo = bodyStr[1]
			end
			for s in string.gmatch(bodyInfo , '(%%%a)') do
			 	table.insert(symbol , s)
			end
			local symbolInfo = {}
			for i=1 , #symbol , 1 do
				if symbol[i] == "%s" then
					local strInfo = TextDataMgr:getTextAttrCanNil(bodyStr[i+1])
					if strInfo then
						symbolInfo[i] = TextDataMgr:getText(bodyStr[i+1])
					else
						symbolInfo[i] = bodyStr[i+1]
					end
				elseif symbol[i] == "%d" then
					symbolInfo[i] = bodyStr[i+1]
				end
			end
			mailInfo.title = TextDataMgr:getText(mailInfo.title)
			mailInfo.body = TextDataMgr:getText(bodyStr[1] , symbolInfo[1], symbolInfo[2] ,  symbolInfo[3] ,  symbolInfo[4])
		else
			mailInfo.body = tonumber(mailInfo.body)
			mailInfo.title = tonumber(mailInfo.title)
		end
		
	end
	
	return mailInfo
end

function MailDataMgr:getOneKeyTable()
	local ret = {}
	local rewards = {}
	for i,v in ipairs(self.showList) do
		if v.rewards and table.count(v.rewards) ~= 0 and v.status ~= 2 then
			table.insert(ret,v.id);
			for k,v in pairs(v.rewards) do
				table.insert(rewards,v);
			end
		end
	end

	return ret,rewards;
end

function MailDataMgr:initShowList(mailType)
	self.showList = {}
	for k,v in pairs(self.mails) do
		if v.mailType == mailType then
			table.insert(self.showList,v);
		end
	end

	local function sort(a,b)
		if a.status == b.status then
			return a.createTime < b.createTime
		else
			return a.status > b.status
		end
	end

	table.sort(self.showList,sort)
end

function MailDataMgr:recvMailList(event)
	if not event.data.mails then
		return;
	end
	for k,v in pairs(event.data.mails) do
		v.mailType = MailType.systemMail
		local id = v.id.."/"..v.mailType
		if not self.mails[id] then
			self.mails[id] = v
		end
		if v.ct == EC_SChangeType.ADD then
			self.mails[id] = v
		elseif v.ct == EC_SChangeType.DEFAULT then
			self.mails[id] = v
		elseif v.ct == EC_SChangeType.UPDATE then
			table.merge(self.mails[id],v);
		elseif v.ct == EC_SChangeType.DELETE then
			self.mails[id] = nil;
		end
	end

	EventMgr:dispatchEvent(EV_OPERATION_MAIL)
    EventMgr:dispatchEvent(EV_RED_POINT_UPDATE_MAIL)
end

function MailDataMgr:operationMail(index,operation,all)
	local info = self.showList[index]
	if not info then
		return
	end

	if info.mailType == MailType.redPackMail then -- 红包邮件领取
		TFDirector:send(c2s.RED_ENVELOPE_REQ_OPEN_ENVELOPE, {info.id})
		return
	end

	local id = info.id
	self.seeID = id;
	self.operationType = operation
	local msg = {
		{
			id
		},
		self.operationType
	}

	TFDirector:send(c2s.MAIL_MAIL_HANDLE, msg)
end



function MailDataMgr:recvRedEnvelopeList(event)
	-- body
	if not event.data.redEnvelopeInfo then
		return;
	end
	for k,v in pairs(event.data.redEnvelopeInfo) do
		v.mailType = MailType.redPackMail
		v.status = 1
		if v.ct ~= EC_SChangeType.DELETE then
			v.title = TextDataMgr:getText(tonumber(v.title))
			v.body = TextDataMgr:getText(tonumber(v.body),v.senderName)
		end
		local id = v.id.."/"..v.mailType
		if not self.mails[id] then
			self.mails[id] = v
		end
		if v.ct == EC_SChangeType.ADD then
			self.mails[id] = v
		elseif v.ct == EC_SChangeType.DEFAULT then
			self.mails[id] = v
		elseif v.ct == EC_SChangeType.UPDATE then
			table.merge(self.mails[id],v);
		elseif v.ct == EC_SChangeType.DELETE then
			self.mails[id] = nil;
		end
	end

	EventMgr:dispatchEvent(EV_OPERATION_MAIL)
    EventMgr:dispatchEvent(EV_RED_POINT_UPDATE_MAIL)
end

function MailDataMgr:recvNewRedEnvelope(event)
	-- body
	if not event.data.redEnvelopeInfo then
		return;
	end
	local v = event.data.redEnvelopeInfo
	if v.ct ~= EC_SChangeType.DELETE then
		v.title = TextDataMgr:getText(tonumber(v.title))
		v.body = TextDataMgr:getText(tonumber(v.body),v.senderName)
	end
	self:showMailNoticeLayer(v)
end

function MailDataMgr:revcOpenEnvelope(event)
	-- body
	if not event.data then
		return;
	end
	if event.data.result == 1 then
		Utils:showReward(event.data.rewards)
	else
		Utils:showTips(63667)
	end
end

function MailDataMgr:revcOpenAllEnvelope(event)
	-- body
	if not event.data then
		return;
	end
	Utils:showReward(event.data.rewards)
end

function MailDataMgr:revcFightEnvelope(event)
	-- body
	if not event.data then
		return;
	end
	if event.data.result == 1 then
		Utils:showTips(63663)
	elseif event.data.result == -2 then
		Utils:showTips(63666)
	elseif event.data.result == -1 then
		Utils:showTips(63665)
	elseif event.data.result == 0 then
		Utils:showTips(63664)
	end
end

function MailDataMgr:removeAllReceivedMail()
	self.operationType = 3
	local ids = {}
	for k,v in pairs(self.mails) do
		if v.status == 2 then
			ids[#ids + 1] = v.id
		end
	end
	if #ids > 0 then
		local msg = {
			ids,
			3
		}
		TFDirector:send(c2s.MAIL_MAIL_HANDLE, msg)
	end
end

function MailDataMgr:revcSeeMail(event)
	dump(event.data)
	if self.operationType == 1 then
		local layer = require("lua.logic.mail.ShowMail"):new(self.seeID)
        AlertManager:addLayer(layer)
        AlertManager:show()
	end

	if self.operationType == 2 then
		local index = self:getMailShowIndex(self.seeID);
		if index > 0 and self.showList[index] then
			local rewardList = {}
		    for k,v in pairs(event.data.rewards) do
		        table.insert(rewardList,Utils:makeRewardItem(v.id, v.num))
		    end
			Utils:showReward(rewardList)
		end
	end

	if self.operationType == 3 then
		Utils:showTips(800058)
	end

	if self.operationType == "oneKey" then
		local rewardList = {}
	    for k,v in pairs(event.data.rewards) do
	        table.insert(rewardList,Utils:makeRewardItem(v.id, v.num))
	    end
		Utils:showReward(rewardList);
	end

	self.operationType = 0;
end

function MailDataMgr:onKeyGet(mailType)
	if mailType == MailType.redPackMail then -- 红包邮件一键领取
		if #self.showList == 0 then -- 没有可领取红包
			return Utils:showTips(800059)
		end
		TFDirector:send(c2s.RED_ENVELOPE_REQ_OPEN_ALL_ENVELOPE, {})
		return
	end

	local tab = {}
	tab,self.rewards = self:getOneKeyTable()

	if #tab == 0 then
		return Utils:showTips(800059)
	end

	self.operationType = "oneKey";

	local msg = {
		tab,
		2
	}
	TFDirector:send(c2s.MAIL_MAIL_HANDLE, msg)
end

function MailDataMgr:showMailNoticeLayer(mailInfo)
   	local currentScene = Public:currentScene()

   	if currentScene.__cname == "BattleScene" and SettingDataMgr:getBattleRedPack() == 2 then return end

   	if DatingDataMgr:getIsDating() and SettingDataMgr:getDatingRedPack() == 2 then return end

   	if currentScene.__cname ~= "BattleScene" and not DatingDataMgr:getIsDating() and SettingDataMgr:getMainRedPack() == 2 then return end 

   	local layer = require("lua.logic.mail.MailNoticeLayer"):new(mailInfo,function ( ... )
   		-- body
   		local layer = currentScene:getChildByName("mailNotice")
   		layer:removeFromParent()
   	end)
   	layer:setName("mailNotice")
	currentScene:addChild(layer)
end

function MailDataMgr:fightEnvelope(id)
	TFDirector:send(c2s.RED_ENVELOPE_REQ_FIGHT_ENVELOPE, {id})
end

return MailDataMgr:new();
