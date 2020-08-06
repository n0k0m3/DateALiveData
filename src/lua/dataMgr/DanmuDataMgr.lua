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
end

function DanmuDataMgr:reset(  )
	-- body
	self.index = {}
    self.danmuGroupVersion = {}
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
	self.allDanmuData[data.type] = self.allDanmuData[data.type] or {} -- 服务器暂时没用这个type  显示type  由 后台控制
	local index = self.index[data.type] or #self.allDanmuData[data.type]

	local danmuCfg = TabDataMgr:getData("Barrage",data.type)
	table.insert(self.allDanmuData[data.type],index,{playerName = MainPlayer:getPlayerName(),content = data.content, sendTime = ServerDataMgr:getServerTime(), showType = danmuCfg.selfShowType})
	self.lastSendTime[data.type] = data.lastSendTime
end

function DanmuDataMgr:onRecvDanmuData(event)
	local data = event.data
	if not data.type then return end
	if self.danmuGroupVersion[data.type] == data.version then
		for k,v in pairs(data.infos) do
			table.insert(self.allDanmuData[data.type],v)
		end
	else
		self.allDanmuData[data.type] = data.infos or {}
    	self.index[data.type] = 1
	end

	local danmuCfg = TabDataMgr:getData("Barrage",data.type)

	for _k,_v in pairs(self.allDanmuData[data.type]) do
		if _v.type ~= 1 then
			_v.showType = _v.showType or danmuCfg.otherShowType[math.random(1,#danmuCfg.otherShowType)]
		else
			_v.showType = _v.showType or danmuCfg.selfShowType
		end
	end
	self.danmuGroupVersion[data.type] = data.version
	for k,v in pairs(self.allDanmuData) do
		table.sort(v,function ( a, b )
			return a.sendTime < b.sendTime
		end)
	end
end

function DanmuDataMgr:reqDanmu( type )
	self.getItemInfoTime = self.getItemInfoTime or {}
	self.getItemInfoTime[type] = self.getItemInfoTime[type] or 0
	if self.getItemInfoTime[type] < os.time() then
		TFDirector:send(c2s.CHAT_REQ_ACQUIRE_BULLET_SCREEN,{self.danmuGroupVersion[type] or 0, type})
		self.getItemInfoTime[type] = os.time() + 60
	end
end

function DanmuDataMgr:getDanmu( type )
	self:reqDanmu(type)
	local danmu = self.allDanmuData[type]
	if danmu and #danmu > 0 then
		local index = self.index[type] or 1
  		EventMgr:dispatchEvent(EV_DANMU_DISPACTH,type,danmu[index])
		index = index%#danmu + 1
		self.index[type] = index
	end
end

function DanmuDataMgr:sendDanmu(type, text)
	if not text or text == "" then return end 
	TFDirector:send(c2s.CHAT_REQ_SEND_BULLET_SCREEN,{text,type})
end

function DanmuDataMgr:getLastSendTimeByType(type)
	return self.lastSendTime[type] or 0
end

return DanmuDataMgr:new()