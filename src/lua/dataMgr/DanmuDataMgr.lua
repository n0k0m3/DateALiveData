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
* -- 弹幕管理器
]]

local DanmuDataMgr = class("DanmuDataMgr")

function DanmuDataMgr:ctor(data)
	TFDirector:addProto(s2c.CHAT_RES_ACQUIRE_BULLET_SCREEN, self, self.onRecvDanmuData)
	TFDirector:addProto(s2c.CHAT_RES_SEND_BULLET_SCREEN, self, self.onSendDanmuRsp)
	TFDirector:addProto(s2c.CHAT_RES_BULLET_INFO, self, self.onLastSendRsp)
	self.allDanmuData = {}
	self.lastSendTime = {}
	self.danmuGroupVersion = {}
	self.index = {}

	self.datingDanmuData = {}
	self.datingDanmuIndex = {}

	--[[约会弹幕测试代码
	self.test = {
	}

	local dialogueIds = {9100002,9100004,9100005,9100006}
	for i=1,100 do
		local dialogueId = math.random(1,#dialogueIds)
		dialogueId = dialogueIds[dialogueId]
		table.insert(self.test,{playerName = "sdjah", content = "弹幕测试"..dialogueId,dialogueId = dialogueId, type = 2 })
	end--]]


end

function DanmuDataMgr:reset(  )
	-- body
	self.index = {}
    self.danmuGroupVersion = {}
    self.datingDanmuIndex = {}
	self.datingDanmuData = {}
end

function DanmuDataMgr:onLogin()
	-- body
	TFDirector:send(c2s.CHAT_REQ_BULLET_INFO,{EC_DanmuType.ZNQ})
end

function DanmuDataMgr:onLastSendRsp( event )
	local data = event.data
	self.lastSendTime[data.barrageId] = data.lastSendTime
end

function DanmuDataMgr:onSendDanmuRsp( event )
	local data = event.data

	self.lastSendTime[data.type] = data.lastSendTime

	local danmuCfg = TabDataMgr:getData("Barrage",data.type)
	if danmuCfg.barrageType == EC_DanmuType.Dating then
		--self.datingDanmuData[data.type] = self.datingDanmuData[data.type] or {}
		local insertData = {playerName = MainPlayer:getPlayerName(),content = data.content, dialogueId = data.dialogueId,sendTime = ServerDataMgr:getServerTime(), type = 1}
		--table.insert(self.datingDanmuData[data.type],insertData)
		EventMgr:dispatchEvent(EV_DANMU_SEND,insertData)
		return
	end

	self.allDanmuData[data.type] = self.allDanmuData[data.type] or {} -- 服务器暂时没用这个type  显示type  由 后台控制
	local index = self.index[data.type] or #self.allDanmuData[data.type]
	table.insert(self.allDanmuData[data.type],index,{playerName = MainPlayer:getPlayerName(),content = data.content, sendTime = ServerDataMgr:getServerTime(), showType = danmuCfg.selfShowType})

end

function DanmuDataMgr:onRecvDanmuData(event)
	local data = event.data
	if not data.type then return end

	local danmuCfg = TabDataMgr:getData("Barrage",data.type)
	if danmuCfg.barrageType == EC_DanmuType.Dating then
		self:insertDatingDanMu(data.type,data.infos)
	else
		if self.danmuGroupVersion[data.type] == data.version then
			for k,v in pairs(data.infos) do
				table.insert(self.allDanmuData[data.type],v)
			end
		else
			self.allDanmuData[data.type] = data.infos or {}
			self.index[data.type] = 1
		end

		for _k,_v in pairs(self.allDanmuData[data.type]) do
			if _v.type ~= 1 then
				_v.showType = _v.showType or danmuCfg.otherShowType[math.random(1,#danmuCfg.otherShowType)]
			else
				_v.showType = _v.showType or danmuCfg.selfShowType
			end
		end
		for k,v in pairs(self.allDanmuData) do
			table.sort(v,function ( a, b )
				return a.sendTime < b.sendTime
			end)
		end
	end

	---更新版本号，版本号是用来分批次请求的标识
	self.danmuGroupVersion[data.type] = data.version

end

function DanmuDataMgr:reqDanmu( type ,time)
	self.getItemInfoTime = self.getItemInfoTime or {}
	self.getItemInfoTime[type] = self.getItemInfoTime[type] or 0
	if self.getItemInfoTime[type] < os.time() then
		TFDirector:send(c2s.CHAT_REQ_ACQUIRE_BULLET_SCREEN,{self.danmuGroupVersion[type] or 0, type})
		self.getItemInfoTime[type] = os.time() + time
	end
end

function DanmuDataMgr:getDanmu( type )
	if type == EC_DanmuType.EVALUATION then
		local index = self.index[type] or 1
		local commentList = CommentDataMgr:getCommentList()
		local allComment = {}

		if commentList.hotInfo then
			for k,v in pairs(commentList.hotInfo) do
				local hasPrised = CCUserDefault:sharedUserDefault():getStringForKey(MainPlayer:getPlayerId() .. v.playerId .. v.commentDate) == "up"
				local showType = 10
				if v.playerId == MainPlayer:getPlayerId() then
					showType = 9
				end
				table.insert(allComment,{showType = showType, content = v.comment, playerName = v.name, prise = v.prise, hasPrise = hasPrised})
			end
		end
		
		if commentList.newInfo then
			for k,v in pairs(commentList.newInfo) do
				local hasPrised = CCUserDefault:sharedUserDefault():getStringForKey(MainPlayer:getPlayerId() .. v.playerId .. v.commentDate) == "up"
				local showType = 10
				if v.playerId == MainPlayer:getPlayerId() then
					showType = 9
				end
				table.insert(allComment,{showType = showType, content = v.comment, playerName = v.name, prise = v.prise, hasPrise = hasPrised})
			end
		end


		if #allComment == 0 then return end

		index = math.min(#allComment, index)
  		EventMgr:dispatchEvent(EV_DANMU_DISPACTH,type,allComment[index])
		index = index%#allComment + 1
		self.index[type] = index
	else
		local danmuCfg = TabDataMgr:getData("Barrage",type)
		if danmuCfg.barrageType == EC_DanmuType.Dating then
			local data = self:getDatingDanMu(type)
			if not self.datingDanmuIndex[type] then
				self.datingDanmuIndex[type] = 1
			end

			if self.datingDanmuIndex[type] >= #data then
				self:reqDanmu(type,5)
			else
				self:updateDatingDanMuData(type)
			end
		else
			self:reqDanmu(type,60)
			local danmu = self.allDanmuData[type]
			if danmu and #danmu > 0 then
				local index = self.index[type] or 1
				EventMgr:dispatchEvent(EV_DANMU_DISPACTH,type,danmu[index])
				index = index%#danmu + 1
				self.index[type] = index
			end
		end
	end
end

---datingScriptId:optional
function DanmuDataMgr:sendDanmu(type, text, datingScriptId)
	if not text or text == "" then return end 
	TFDirector:send(c2s.CHAT_REQ_SEND_BULLET_SCREEN,{text,type,datingScriptId})
end

function DanmuDataMgr:getLastSendTimeByType(type)
	return self.lastSendTime[type] or 0
end

function DanmuDataMgr:insertDatingDanMu(barrageCid, data)


	if not self.datingDanmuData[barrageCid] then
		self.datingDanmuData[barrageCid] = {}
	end
	table.insertTo(self.datingDanmuData[barrageCid],data)
	EventMgr:dispatchEvent(EV_DANMU_DISPACTH,barrageCid,data)
end

function DanmuDataMgr:updateDatingDanMuData(barrageCid)

	local outData = {}
	local data = self:getDatingDanMu(barrageCid)
	local index = self.datingDanmuIndex[barrageCid] or 1
	for i=index,#data do
		table.insert(outData,data[i])
	end
	self.datingDanmuIndex[barrageCid] = #data
	EventMgr:dispatchEvent(EV_DANMU_DISPACTH,barrageCid,outData)
end
	
function DanmuDataMgr:resetDatingIndex(barrageCid)
	self.datingDanmuIndex[barrageCid] = 1
end

function DanmuDataMgr:getDatingDanMu(barrageCid)
	return self.datingDanmuData[barrageCid] or {}
end
--[[约会弹幕测试代码
function DanmuDataMgr:getTestDanmu()
	EventMgr:dispatchEvent(EV_DANMU_DISPACTH,2101002,self.test)
end

function DanmuDataMgr:addTestDanmu()
	local test = {}
	local dialogueIds = {9100007,9100008,9100009,9100010}
	for i=1,100 do
		local dialogueId = math.random(1,#dialogueIds)
		dialogueId = dialogueIds[dialogueId]
		table.insert(test,{playerName = "sdjah", content = "弹幕测试"..dialogueId,dialogueId = dialogueId, type = 2 })
	end
	EventMgr:dispatchEvent(EV_DANMU_DISPACTH,2101002,test)
end--]]

return DanmuDataMgr:new()