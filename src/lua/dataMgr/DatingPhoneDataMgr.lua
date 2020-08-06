local BaseDataMgr = import(".BaseDataMgr")
local DatingPhoneDataMgr = class("DatingPhoneDataMgr", BaseDataMgr)
local UserDefalt = CCUserDefault:sharedUserDefault()

function DatingPhoneDataMgr:init()
	
	self:initTableData()
	self:registerMsgEvent()

	self.isHaveRequest = false
end

--注册服务器消息事件
function DatingPhoneDataMgr:registerMsgEvent()
	TFDirector:addProto(s2c.DATING_PHONE_DATING_ACCEPT, self, self.onAcceptPhoneDating)
	TFDirector:addProto(s2c.DATINGRESERVE_REMIND, self, self.onDatingPhoneOutTime)
	TFDirector:addProto(s2c.DATINGRESP_PHONE_CHAT, self, self.onDialgueChat)
	TFDirector:addProto(s2c.DATINGPUSH_CHAT, self, self.onRecvRobotDialgue)
	TFDirector:addProto(s2c.DATING_RESP_GET_HEART_STATE, self, self.onRecvHeroState)
	TFDirector:addProto(s2c.DATING_RESP_HEART_STATE, self, self.onRecvRelieveHeroState)

	----主界面提示相关
	TFDirector:addProto(s2c.DATING_RESP_AITRIGGER_TYPE, self, self.onRecvAiTriggerFlag)
	-- 精灵属性
	TFDirector:addProto(s2c.DATING_RESP_AIPROP, self, self.onRecvRoleAttrs)

end

function DatingPhoneDataMgr:initTableData()

	--通讯录
	self.groupCfg = {}
	self.friendCfg = {}
	self.phoneBaseCfg = TabDataMgr:getData("Phone")
	for k,v in pairs(self.phoneBaseCfg) do
		if v.type == 0 then
			table.insert(self.groupCfg,v)
		else
			table.insert(self.friendCfg,v)
		end
	end

	self.relation = {}
	local DatingRule = TabDataMgr:getData("DatingRule")
	for k,v in pairs(DatingRule) do
		if phoneScript ~= 0 then
			self.relation[v.phoneScript] = v.phoneRole
		end
	end

	self.roleMotionCfg = {}
	local aiBoardCfg = TabDataMgr:getData("AIboard")
	for k,v in pairs(aiBoardCfg) do
		self.roleMotionCfg[v.roleid] = v
	end

	self.emotionCfg = TabDataMgr:getData("RoleModelMotion")
	local AImotionCfg = TabDataMgr:getData("AImotion")
	self.faceCfg = {}
	for k,v in ipairs(AImotionCfg) do
		if v.motion ~= "" then
			table.insert(self.faceCfg,v)
		end
	end

    self.voiceCfg = {}
    local AIVoiceCfg = TabDataMgr:getData("AIVoice")
    for k,v in ipairs(AIVoiceCfg) do
        self.voiceCfg[v.voice] = v
    end

	---手机约会主界面提示(时间，等级)
	local phoneMessageKVP = Utils:getKVP(49001)
	self.player_level = phoneMessageKVP.player_level
	self.online = phoneMessageKVP.online
end

function DatingPhoneDataMgr:initUserLocalData()
	self.saveInfo = {}
	local DatingRule = TabDataMgr:getData("DatingRule")
	for k,v in pairs(DatingRule) do
		if v.phoneRole ~= 0 then
			local pid = MainPlayer:getPlayerId()
			local datingInfoStr = UserDefalt:getStringForKey(pid.."phoneRuleScript"..v.id)
			if datingInfoStr ~= "" then
				local datingInfo = string.split(datingInfoStr,"|")
				for k,info in ipairs(datingInfo) do
					local saveInfo =  string.split(info,"_")
					local saveType,content = saveInfo[1],saveInfo[2]
					self:addDatingInfo(v.id,content,saveType)
				end
			end
		end
	end
end

--获取本地保存的dating数据
function DatingPhoneDataMgr:getDaingUserInfo(ruleId)

	return self.saveInfo[ruleId] or {}
end

--
function DatingPhoneDataMgr:addDatingInfo(ruleId,saveContent,saveType)

	if not self.saveInfo[ruleId] then
		self.saveInfo[ruleId] = {}
	end

	saveType = saveType or Enum_PhoneSaveType.SaveType_DaingId

	local datingInfo = self.saveInfo[ruleId]
	if #datingInfo >= 20 then
		table.remove(self.saveInfo[ruleId],1)
	end
	table.insert(self.saveInfo[ruleId],{saveType = saveType,content = saveContent})

end

function DatingPhoneDataMgr:isDatingUserInfo(ruleId,datingId)

	if not self.saveInfo[ruleId] then
		return false
	end

	for k,v in ipairs(self.saveInfo[ruleId]) do		
		if tonumber(v.content) == datingId then
			return true
		end
	end
	return false
end

--本地存储角色的ruleID
function DatingPhoneDataMgr:saveRoleScript(roleId,ruleId)
	local pid = MainPlayer:getPlayerId()
	UserDefalt:setStringForKey(pid.."phoneRoleScript"..roleId,ruleId)
end

function DatingPhoneDataMgr:getRoleScript(roleId)
	local pid = MainPlayer:getPlayerId()
	local datingRuleId = UserDefalt:getStringForKey(pid.."phoneRoleScript"..roleId)
	return tonumber(datingRuleId)
end

function DatingPhoneDataMgr:saveLocalData()

	local pid = MainPlayer:getPlayerId()
	for k,v in pairs(self.saveInfo) do
		local saveKey = pid.."phoneRuleScript"..k
		local str
		for i,saveData in ipairs(v) do
			if saveData.saveType and saveData.content then
				if i ~= 1 then
					str = str.."|"..saveData.saveType.."_"..saveData.content
				else
					str = saveData.saveType.."_"..saveData.content
				end
			end
		end
		if str then
			UserDefalt:setStringForKey(saveKey,str)
		end
	end
end

function DatingPhoneDataMgr:initUserOldLocalData()
	self.saveOldInfo = {}
	local DatingRule = TabDataMgr:getData("DatingRule")
	for k,v in pairs(DatingRule) do
		if v.phoneRole ~= 0 then
			local pid = MainPlayer:getPlayerId()
			local datingInfoStr = UserDefalt:getStringForKey(pid.."phoneRuleScriptOld"..v.id)
			if datingInfoStr ~= "" then
				local datingInfo = string.split(datingInfoStr,"|")
				for k,info in ipairs(datingInfo) do
					local saveInfo =  string.split(info,"_")
					local saveType,content = saveInfo[1],saveInfo[2]
					self:addOldDatingInfo(v.id,content,saveType)
				end
			end
		end
	end
end

function DatingPhoneDataMgr:getDaingUserOldInfo(ruleId)
	return self.saveOldInfo[ruleId] or {}
end

function DatingPhoneDataMgr:addNewDating(ruleId)

	if not self.saveInfo[ruleId] then
		return
	end

	for k,v in ipairs(self.saveInfo[ruleId]) do
		self:addOldDatingInfo(ruleId,v.content,v.saveType)
	end

	local pid = MainPlayer:getPlayerId()
	UserDefalt:setStringForKey(pid.."phoneRuleScript"..ruleId,"")
	self:saveOldLocalData()
end

function DatingPhoneDataMgr:addOldDatingInfo(ruleId,saveContent,saveType)

	if not self.saveOldInfo[ruleId] then
		self.saveOldInfo[ruleId] = {}
	end

	saveType = saveType or 1

	local datingInfo = self.saveOldInfo[ruleId]
	if #datingInfo >= 20 then
		table.remove(self.saveOldInfo[ruleId],1)
	end
	table.insert(self.saveOldInfo[ruleId],{saveType = saveType,content = saveContent})

end

function DatingPhoneDataMgr:saveOldLocalData()
	
	local pid = MainPlayer:getPlayerId()
	for k,v in pairs(self.saveOldInfo) do
		local saveKey = pid.."phoneRuleScriptOld"..k
		local str
		for i,saveData in ipairs(v) do
			if saveData.content and saveData.saveType then
				if i == 1 then
					str = saveData.saveType.."_"..saveData.content
				else
					str = str.."|"..saveData.saveType.."_"..saveData.content
				end
			end
		end
		if str then
			UserDefalt:setStringForKey(saveKey,str)
		end
	end
	--self.saveOldInfo = {}
	self.saveInfo = {}
end

function DatingPhoneDataMgr:setDatingScript(scriptName)
	--手机剧情
	self.PhoneDatingCfg = {}
	local datingCfg = TabDataMgr:getData(scriptName)
	for k,v in pairs(datingCfg) do
		if v.datingType == 5 then
			self.PhoneDatingCfg[v.id] = v
		end
	end
end

function DatingPhoneDataMgr:getGroupCfg()
	return self.groupCfg
end

function DatingPhoneDataMgr:getFriendCfg()
	return self.friendCfg
end

function DatingPhoneDataMgr:getRoleInfoById(roleId)
	for k,v in ipairs(self.friendCfg) do
		local roleCid = v.openType["roleCids"][1]
		if roleCid == roleId then
			return v
		end
	end
end

function DatingPhoneDataMgr:getPhoneBaseCfg(id)
	if id then
		return self.phoneBaseCfg[id]
	else
		return self.phoneBaseCfg
	end
end

function DatingPhoneDataMgr:getDatingCfg()
	return self.PhoneDatingCfg
end

function DatingPhoneDataMgr:getRoleIdByScriptId(scriptId)
	return self.relation[scriptId]
end

function DatingPhoneDataMgr:getDatingCfgById(id)

	if not id then
		return
	end

	if not self.PhoneDatingCfg then
		return
	end

	if not self.PhoneDatingCfg[id] then
		return
	end
	
	local datingInfo = self.PhoneDatingCfg[id]
    datingInfo.nameId = datingInfo.nameId or 0
    datingInfo.text = datingInfo.text or ""
    datingInfo.headIcon = datingInfo.headIcon or ""
    datingInfo.jump = datingInfo.jump or {}
	return datingInfo
end

function DatingPhoneDataMgr:saveOutTimePhoneRuleId(roleId,ruleId)
	local pid = MainPlayer:getPlayerId()
	UserDefalt:setStringForKey(pid.."outTimePhoneRuleId"..roleId,ruleId)
	UserDefalt:flush()
end

function DatingPhoneDataMgr:getOutTimePhoneRuleId(roleId)

	local pid = MainPlayer:getPlayerId()
	local outTimeRuleId = UserDefalt:getStringForKey(pid.."outTimePhoneRuleId"..roleId)
	return tonumber(outTimeRuleId)
end

function DatingPhoneDataMgr:isNewOutTimePhoneDating()

	for k,v in ipairs(self.friendCfg) do
		local outTimeRuleId = self:getOutTimePhoneRuleId(v.id)
		if outTimeRuleId then
			return true
		end 
	end

	return false
end

function DatingPhoneDataMgr:onAcceptPhoneDating(event)
	if event.data then
		EventMgr:dispatchEvent(EV_DATING_EVENT.acceptPhoneDating,event.data.accept)
	end
end

function DatingPhoneDataMgr:onDatingPhoneOutTime(event)

	local data = event.data
	if not data then
		return
	end

	--[[local outTimeRuleId = data.datingRuleCid
	local outTimeReward = data.rewards
	local outTime = data.outTime

	local data = {}
	local outTimeRuleId = 2301002
	local rewards = {}
	rewards[1] = {id = 500007,num = -40}
	rewards[2] = {id = 500008,num = -40}
	local outTimeReward = rewards
	data.datingRuleCid = outTimeRuleId
	data.rewards = rewards
	data.outTime = 1536764400
	local outTime = 1536764400]]

	local ruleCfg = TabDataMgr:getData("DatingRule")[outTimeRuleId]
    if not ruleCfg then
        return
    end

	if not outTimeReward or (not next(outTimeReward)) then
		return
	end

    local phoneRole = ruleCfg.phoneRole

    local isNewPhone,ruleId =  DatingDataMgr:getPhoneDating()
    if ruleId and outTimeRuleId == ruleId then 
    	DatingDataMgr:setPhoneDating(nil,nil,nil)
    end

	self:saveOutTimePhoneRuleId(phoneRole,outTimeRuleId)
	self:saveOutTimeDatingInfo(outTimeRuleId,outTimeReward,outTime)

	EventMgr:dispatchEvent(EV_DATING_EVENT.outTimePhoneDating)
end

--手机约会过期提示
function DatingPhoneDataMgr:saveOutTimeDatingInfo(datingRuleId,outTimeReward,outTime)


	local ruleCfg = TabDataMgr:getData("DatingRule")[datingRuleId]
	if not ruleCfg then
		return
	end

	local phoneRole = ruleCfg.phoneRole
	local phoneScript = ruleCfg.phoneScript

	self:initUserLocalData()
	self:initUserOldLocalData()
	self:saveRoleScript(phoneRole,datingRuleId)
	self:setDatingScript(ruleCfg.callTableName)

	local awardStr
	for k,v in ipairs(outTimeReward) do
		local awardId = v.id
		local num = v.num
		if k == 1 then
			awardStr = awardId..","..num
		else
			awardStr = awardStr.."~"..awardId..","..num
		end
	end

	self:addDatingInfo(datingRuleId,awardStr,Enum_PhoneSaveType.SaveType_Award)
	self:addDatingInfo(datingRuleId,outTime,Enum_PhoneSaveType.SaveType_OutTime)
	self:saveLocalData()
	self:addNewDating(datingRuleId)
end

-------手机AI相关
function DatingPhoneDataMgr:isUsedPhoneAi()
	local pid = MainPlayer:getPlayerId()
	local isFirst = UserDefalt:getBoolForKey("firstUseAi"..pid)
	return isFirst
end

function DatingPhoneDataMgr:setUsedAi()

	local pid = MainPlayer:getPlayerId()
	UserDefalt:setBoolForKey("firstUseAi"..pid,true)
	UserDefalt:flush()

end

function DatingPhoneDataMgr:writeDialogue()

	if not self.dialogue then
		return
	end

	local fileName = MainPlayer:getPlayerId()
	local filePath = me.FileUtils:getWritablePath() .. 'cacheData/phoneDating/'
	if TFFileUtil:existFile(filePath) == false then
		TFFileUtil:createDir(filePath)
	end
	local path = string.format("%s/%s.lua", filePath,fileName)
	Utils:writeTable(self.dialogue , path)
end

function DatingPhoneDataMgr:readDialogue()

	local fileName = MainPlayer:getPlayerId()
	local filePath = me.FileUtils:getWritablePath() .. 'cacheData/phoneDating/'

	local path = string.format("%s%s.lua", filePath,fileName)
	if TFFileUtil:existFile(path) == false then
		return
	end
	self.dialogue = Utils:readTable(path)
end

function DatingPhoneDataMgr:getLocalDialogue()
	return self.dialogue
end

function DatingPhoneDataMgr:insertDialogue(roleId,dialogueStr)

	if not self.dialogue then
		self.dialogue = {}
	end

	if not self.dialogue[roleId] then
		self.dialogue[roleId] = {}
	end

	if #self.dialogue[roleId] > 100 then
		table.remove(self.dialogue[roleId],1)
	end

	table.insert(self.dialogue[roleId],dialogueStr)
end


function DatingPhoneDataMgr:sendAiDialogue(type, msg, roleId)

	local msg = {
		type,
		msg,
		roleId
	}

	TFDirector:send(c2s.DATINGREQ_PHONE_CHAT, msg)
end

--check发送文字上传
function DatingPhoneDataMgr:onDialgueChat(event)
	local data = event.data
	if not data then
		return
	end

	EventMgr:dispatchEvent(EV_DATING_EVENT.checkSendDialogue,data)

end

function DatingPhoneDataMgr:onRecvRobotDialgue(event)

	local data = event.data
	if not data then
		return
	end
	-- dump(data)
	-- Box("getData")
	EventMgr:dispatchEvent(EV_DATING_EVENT.robotDialogue,data)
end

function DatingPhoneDataMgr:getRoleEmotionInfo(roleId)
	return self.roleMotionCfg[roleId]
end

function DatingPhoneDataMgr:getEmotionActionName(actionId,roleModeId)

	if not self.emotionCfg[actionId] then
		-- Box("Wrong actionId:"..tostring(actionId))
		return
	end

	if self.emotionCfg[actionId].model ~= roleModeId then
		-- Box("modeId not match:"..tostring(roleModeId)..","..tostring(self.emotionCfg[actionId].model))
		return
	end

	return self.emotionCfg[actionId].face
end

function DatingPhoneDataMgr:getFaceEmotion()
	return self.faceCfg
end

function DatingPhoneDataMgr:getFaceInfoById(faceId)
	for k,v in ipairs(self.faceCfg) do
		if v.id == faceId then
			return v
		end
	end
end

function DatingPhoneDataMgr:getVoiceByName(fileName)

    return  self.voiceCfg[fileName]
end

--获取精灵状态
function DatingPhoneDataMgr:onRecvHeroState(event)
	local data = event.data
	if not data then
		return
	end

	if data.sealStateInfo then
		for k,v in ipairs(data.sealStateInfo) do
			self.heroForbidState[v.roleId] = v.sealState
		end
	end

end

function DatingPhoneDataMgr:initHeroForbidState()

	self.heroForbidState = {}
	for k,v in pairs(self.phoneBaseCfg) do
		if v.type == 1 then
			self.heroForbidState[k] = Enum_PhoneRoleState.NORMAL
		end
	end
end

--解除精灵状态
function DatingPhoneDataMgr:onRecvRelieveHeroState(event)
	local data = event.data
	if not data then
		return
	end
	local roleId = data.roleId
	local state = data.sealState

	self:setHeroForbidState(roleId,state)

	TFDirector:send(c2s.DATING_REQ_AIPROP, {101})
	if data.sealType == 1 then
		EventMgr:dispatchEvent(EV_DATING_EVENT.relieveForbid,roleId)
	end
end

--获取精灵禁言状态
function DatingPhoneDataMgr:getHeroForbidState(roleId)
	dump(self.heroForbidState)
	return self.heroForbidState[roleId]
end

function DatingPhoneDataMgr:setHeroForbidState(roleId,state)
	self.heroForbidState[roleId] = state
end

function DatingPhoneDataMgr:onLogin()

	self.loginTime = ServerDataMgr:getServerTime()
	self.dialogue = {}
	self:readDialogue()
	self:initHeroForbidState()
	TFDirector:send(c2s.DATING_REQ_GET_RELIEVE_HEART_STATE, {})
	TFDirector:send(c2s.DATING_REQ_AITRIGGER_TYPE, {})
	TFDirector:send(c2s.DATING_REQ_AIPROP, {101})
	return {s2c.DATING_RESP_GET_HEART_STATE,s2c.DATING_RESP_AITRIGGER_TYPE}
end

function DatingPhoneDataMgr:setPhoneBackState(state)
	self.backMainScence = state
end

function DatingPhoneDataMgr:getPhoneBackState()
	return self.backMainScence
end

function DatingPhoneDataMgr:isFisrtVersionTip()
	local pid = MainPlayer:getPlayerId()
	local isFirst = UserDefalt:getBoolForKey("firstVersion"..pid)
	return isFirst
end

function DatingPhoneDataMgr:setFirstVersionTip()

	local pid = MainPlayer:getPlayerId()
	UserDefalt:setBoolForKey("firstVersion"..pid,true)
	UserDefalt:flush()

end

----主界面提示相关

---满足所有主界面弹Ai提示条件发送（在线5分钟，玩家>10级，Ai标记, 没跟ai聊过天）
function DatingPhoneDataMgr:Send_AiTriiger()

	--版本检测
	-- if CC_TARGET_PLATFORM ~= CC_PLATFORM_WIN32 and tonumber(TFDeviceInfo:getCurAppVersion()) < 3.50 then
	-- 	return
	-- end

	--服务器触发检测
	if not self.triggerFlag then
		return
	end

	-- 在线没有和ai聊过天
	if not self:isHaveChatWhihAI() then
		return
	end

	TFDirector:send(c2s.DATING_REQ_AITRIGGER, {os.time(),101})
	-- Box("Request!!!")
	self.isHaveRequest = true
end

function DatingPhoneDataMgr:getHaveRequest()
	return self.isHaveRequest
end

function DatingPhoneDataMgr:needOnlineTime()
	return self.online
end

function DatingPhoneDataMgr:needPlayerLv()
	return self.player_level
end

---清空对应精灵的AI标记
function DatingPhoneDataMgr:Send_ClearAiMessageRedPoint()
	self.messgeRoleId = nil
	TFDirector:send(c2s.DATING_REQ_LOOK_TRIGGER_MESSAGE, {101})
	-- Box("removeTg")
end

function DatingPhoneDataMgr:getTriggerFlag()
	return self.triggerFlag
end

---会主动同步
function DatingPhoneDataMgr:onRecvAiTriggerFlag(event)
	local data = event.data
	if not data then
		return
	end
	-- dump(data)
	-- Box("Tag")
	self.triggerFlag = data.trigger
end

function DatingPhoneDataMgr:onRecvRoleAttrs(event)
	local data = event.data
	if not data then
		return
	end
	if not self.roleAttrData then
		self.roleAttrData = {}
	end
	self.roleAttrData[tostring(data.roleId)] = data
	EventMgr:dispatchEvent(EV_DATING_EVENT.getRoleAttrData)
end

function DatingPhoneDataMgr:getRoleAttrDataById(_id)
	if self.roleAttrData then
		return self.roleAttrData[tostring(_id)]
	end
end

function DatingPhoneDataMgr:setMessgeRoleId(messgeRoleId)
	self.messgeRoleId = messgeRoleId
end

function DatingPhoneDataMgr:getMessageRoleId()
	return self.messgeRoleId
end

-- 是否首次进如第二ai聊天室
function DatingPhoneDataMgr:getIsHadInSceondAI()
	local pid = MainPlayer:getPlayerId()
	local _bool = UserDefalt:getBoolForKey("IsHadInSceondAI"..pid)

	if not _bool then
		UserDefalt:setBoolForKey("IsHadInSceondAI"..pid, true)
	end
	
	return _bool
end

-- 获取主界面背景图纹理和大小
function DatingPhoneDataMgr:keepMainBgTexture(texture)
	if type(texture) == "boolean" then
		self.mainBgTexture = nil
	elseif texture then 
		self.mainBgTexture = texture
	end
	return self.mainBgTexture
end

function DatingPhoneDataMgr:setChatWithAI()
	self.hadChatWithAI = true
end

-- 是否和ai聊过天
function DatingPhoneDataMgr:isHaveChatWhihAI()
	return  nil == self.hadChatWithAI and false or true
end

-- 主界面打招呼红点显示与否
function DatingPhoneDataMgr:isShowBtnAIChatRed()
    if not self:isUsedPhoneAi() or self.btnAiChatRed then
        return true
    else
        return false
    end
end

function DatingPhoneDataMgr:setBtnAIChatRed(_bool)
    if nil ~= _bool then
        self.btnAiChatRed = _bool
    end
end


return DatingPhoneDataMgr:new()