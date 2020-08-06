--[[主界面风格]]
local BaseDataMgr = import(".BaseDataMgr")
local MainUISettingMgr = class("MainUISettingMgr.lua", BaseDataMgr)

--[[初始化]]
function MainUISettingMgr:init()
	--主界面切换信息
	TFDirector:addProto(s2c.MEDAL_RESP_UI_CHANGE_INFO, self, self.onRecvChangeInfo)
	--更换UI显示
	TFDirector:addProto(s2c.MEDAL_RESP_CHANGE_UI_CHANGE, self, self.onRecvChange)
	
	self.currentId = -1
	self.uiChange = {}
	self.oldId = -1
	self.wearId = -1
end


function MainUISettingMgr:onLogin()
	self.currentId = -1
	self.uiChange = {}
	self:ReqUiChangeInfo()
	return {s2c.MEDAL_RESP_UI_CHANGE_INFO}
end


function MainUISettingMgr:setCurrentMainUI(id)
	if self.currentId ~= id then
		self.oldId = self.currentId
		self.currentId = id
		if self.oldId ~= -1 then

				local scene = Public:currentScene()
				if scene and scene.___mainLayer then

					AlertManager:closeAll()
					AlertManager:changeScene(SceneType.MainScene)
				end
		else
			self.oldId = self.currentId
		end	
	end
end

function MainUISettingMgr:closeMainLayer( ... )
	if self.wearId ~= -1 then
		self:setCurrentMainUI(self.wearId)
		self.wearId = -1
	end
	
end

function MainUISettingMgr:onRecvChangeInfo(data)
	print("onRecvChangeInfo---------------------------------------------------------------")
	-- dump(data)

	local isAdd = false
	for k, v in pairs(data.data.uiChange) do
		self.uiChange[v.cid] = v
		if 1 == v.ct then
			isAdd = true
		end
		
	end
	if isAdd then
		self.wearId = data.data.wearId
		
	else
		self:setCurrentMainUI(data.data.wearId)
	end
	
	
end

function MainUISettingMgr:onRecvChange(data)
	print("onRecvChange")
	-- dump(data)
	self:setCurrentMainUI(data.data.cid)
end


function MainUISettingMgr:ReqUiChangeInfo()
	TFDirector:send(c2s.MEDAL_REQ_UI_CHANGE_INFO, {})
end

function MainUISettingMgr:ReqChangeUiChange(cid)
	TFDirector:send(c2s.MEDAL_REQ_CHANGE_UI_CHANGE, {cid})
end

function MainUISettingMgr:CheckLock(id)
	for k , v in pairs(self.uiChange) do
		if v.cid == id then
			return false
		end
	end

	--判断是否可以解锁getTimeByDate
	local tb = TabDataMgr:getData("Uichange", id)
	if tb and 2 == tb.titleType then
		local beginTime = Utils:getTimeByDate(tb.beginTime)
		local endTime = Utils:getTimeByDate(tb.endTime)
		
		local servertime = ServerDataMgr:getServerTime()
		if servertime > beginTime and servertime < endTime then
			return false
		end
		
	end
	
	return true
end

function MainUISettingMgr:CheckSelect(id)
	return self.currentId == id
end

function MainUISettingMgr:getui()
	return self.currentId
end

function MainUISettingMgr:getoldui()
	return self.oldId
end

function MainUISettingMgr:getCurUiCfg()
	local tb = TabDataMgr:getData("Uichange", self.currentId)
	return tb
end


return MainUISettingMgr:new()