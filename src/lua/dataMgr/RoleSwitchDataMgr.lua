local BaseDataMgr = import(".BaseDataMgr")
local RoleSwitchDataMgr = class("RoleSwitchDataMgr", BaseDataMgr)
local UserDefalt = CCUserDefault:sharedUserDefault()

function RoleSwitchDataMgr:ctor()
    self:init()
end

function RoleSwitchDataMgr:registerMsgEvent()
    TFDirector:addProto(s2c.ROLE_RESP_ROTATION, self, self.onRecvUpdateSwitchList)
    TFDirector:addProto(s2c.ROLE_RESP_SET_ROTATION_OPEN, self, self.onRecvChangeSwitchState)
end

function RoleSwitchDataMgr:init()
    self:initData()
    self:registerMsgEvent()
end

function RoleSwitchDataMgr:initData()
    self.dressTable = TabDataMgr:getData("Dress")
    local interval = Utils:getKVP(46021, "interval")
    self.intervalTime = interval or 1800
    self.nextSwitchTime = 0
end


function RoleSwitchDataMgr:onLogin()
    --self:initSwitchList()
    --self:initOpenState()
    -- self.nextSwitchTime = 0
end

function RoleSwitchDataMgr:onEnterMain()
    self:initSwitchList()
    self:initOpenState()
end

function RoleSwitchDataMgr:saveOpenState()

    local pid = MainPlayer:getPlayerId()
    UserDefalt:setStringForKey("RoleSwitchState"..pid,self.openState)
    UserDefalt:flush()
end

function RoleSwitchDataMgr:initOpenState()
    local pid = MainPlayer:getPlayerId()
    local state = UserDefalt:getStringForKey("RoleSwitchState"..pid)
    self.openState = tonumber(state) and tonumber(state) or 0
end

function RoleSwitchDataMgr:getOpenState()
    return self.openState
end

function RoleSwitchDataMgr:setOpenState(state)
    self.openState = state
    self:saveOpenState()
end

function RoleSwitchDataMgr:initSwitchList()
    self.firstFlag = true
    self.nextSwitchTime =  self.intervalTime or 0
    local rotationList,state = RoleDataMgr:getRoleSwitchData()
    self.switchList = {}
    self.allHighDress = {}
    self:setSwitchList(rotationList)
    self:setSwitchState(state)
    self:initAllHighDress()
    self:setDefaultSwitchList()
    self:setNextRole()
end

function RoleSwitchDataMgr:setFirstFlag(firstFlag)
    self.firstFlag = firstFlag
end

function RoleSwitchDataMgr:getFirstFlag()
    return self.firstFlag
end

function RoleSwitchDataMgr:setDefaultSwitchList()
    if not next(self.switchList) then
        for k,v in ipairs(self.allHighDress) do
            local isHave = RoleDataMgr:getIsHave(v.roleId)
            local isHaveDress = GoodsDataMgr:getDress(v.dressId)
            if isHave and isHaveDress then
                table.insert(self.switchList,v.dressId)
            end
        end
    end
end

function RoleSwitchDataMgr:initAllHighDress()
	self.allHighDress = {}
    local roleCnt = RoleDataMgr:getRoleCount()
    for i=1,roleCnt do
        local roleId = RoleDataMgr:getRoleIdByShowIdx(i);
        local dressTab = RoleDataMgr:getDressIdList(roleId)

        for k,v in ipairs(dressTab) do
            local dressCfg = self:getDressCfg(v)
            if dressCfg and dressCfg.type == 2 and not dressCfg.notTurnPlay and dressCfg.masterId == 0 then
                table.insert(self.allHighDress,{roleId = roleId,dressId = v})
            end
        end
    end
end

function RoleSwitchDataMgr:setSwitchAnimateState(aniState)
    self.animateState = aniState
end

function RoleSwitchDataMgr:getSwitchAnimateState()
    return self.animateState
end

function RoleSwitchDataMgr:getNextDressId()
    return self.nextDressId or self.switchList[1]
end

---看板轮换时间控制
function RoleSwitchDataMgr:setNextSwitchTime()
    self.nextSwitchTime = ServerDataMgr:getServerTime() + self.intervalTime
end

function RoleSwitchDataMgr:getNextSwitchTime()
    return self.nextSwitchTime
end

function RoleSwitchDataMgr:resetSwitchTime()
    self:setNextSwitchTime()
    EventMgr:dispatchEvent(EV_START_SWITCH_TIME)
end

function RoleSwitchDataMgr:getRoleIdByDressId(dressId)
    for k,v in ipairs(self.allHighDress) do
        if v.dressId == dressId then
            return v.roleId
        end
    end
end

function RoleSwitchDataMgr:addNewDress(dressId)
    if self.switchList then
		local cfg =  GoodsDataMgr:getItemCfg(dressId)
		if cfg and cfg.masterId ~= 0 then
			return
		end
        self:insertSwitchList(dressId)
    end
end

function RoleSwitchDataMgr:getDressCfg(dressId)
    return self.dressTable[dressId]
end

function RoleSwitchDataMgr:getAllHighDress()
    return self.allHighDress
end

function RoleSwitchDataMgr:resetSwitchList(list)
    self:setSwitchList(list)
end

function RoleSwitchDataMgr:setSwitchList(list)
    self.switchList = list or {}
    for i=#self.switchList,1,-1 do
        local dressId  = self.switchList[i]
        local dressCfg = self:getDressCfg(dressId)
        if not dressCfg or dressCfg.type ~= 2 or dressCfg.notTurnPlay then
            table.remove(self.switchList,i)
        end
    end
end

function RoleSwitchDataMgr:getSwitchList()
    return clone(self.switchList)
end

function RoleSwitchDataMgr:isInSwitchList(dressId)
    local index = table.indexOf(self.switchList, dressId)
    return index ~= -1
end

function RoleSwitchDataMgr:setSwitchState(state)
    self.swicthState = state or false
end

function RoleSwitchDataMgr:getSwitchState()
    return self.swicthState
end

function RoleSwitchDataMgr:handleSwitchList(dressId,isTemp)
    local isInSwitchList = self:isInSwitchList(dressId)
    if isInSwitchList then
        if #self.switchList == 2 then
            Utils:showTips(13310405)
            return
        end
        self:removeFromSwitchList(dressId,isTemp)
    else
        self:insertSwitchList(dressId,isTemp)
    end
end

function RoleSwitchDataMgr:removeFromSwitchList(dressId,isTemp)
    for i=#self.switchList,1,-1 do
        if dressId == self.switchList[i] then
            table.remove(self.switchList,i)
        end
    end
    if not isTemp then
		--检查是否正在使用中
		local roleInfo = RoleDataMgr:getRoleInfo(RoleDataMgr:getUseId())
		if roleInfo.dressId == dressId then
			self:setFirstFlag(false)
			self:setNextRole()
		end

        self:Send_NewSwithList(self.switchList)
    else
        EventMgr:dispatchEvent(EV_UPDATE_SWITCH_LIST)
    end
end

function RoleSwitchDataMgr:insertSwitchList(dressId,isTemp)
	

	local function replaceSameId(dressId)
		local ret
		local cfg = TabDataMgr:getData("Dress", dressId)
		if table.count( cfg.skinGroup) >= 2 then
			for k, v  in pairs( cfg.skinGroup) do
				local index = table.indexOf(self.switchList, v)
				if index ~= -1 then	
					print('存在时装组')
					ret = index		
					break; 
				end
			end
			
		end
		return ret
	end
	
    local newDressCfg = self:getDressCfg(dressId)
    if newDressCfg and newDressCfg.type and newDressCfg.type == 2 and not newDressCfg.notTurnPlay then
		local idx = replaceSameId(dressId)

        local dressData = RoleDataMgr:useDressFindData()
        if dressData and dressData.type and dressData.type == 2 and not dressData.notTurnPlay then
            local index = table.indexOf(self.switchList, dressData.id)
            if index ~= -1 then
				if idx then
					table.remove(self.switchList, idx)
				end
				table.insert(self.switchList,index+1,dressId)

				local tempTab = {}
				for k, v in pairs(self.switchList) do
					table.insert(tempTab, v)
				end
				self.switchList = tempTab
            else
				if idx then
					table.remove(self.switchList, idx)
				end
				table.insert(self.switchList,dressId)
            end
        else
			if idx then
				table.remove(self.switchList, idx)
			end
			table.insert(self.switchList,dressId)
        end
        if not isTemp then
            self:Send_NewSwithList(self.switchList)
        else
            EventMgr:dispatchEvent(EV_UPDATE_SWITCH_LIST)
        end
    end
end

---每次重新打开轮播的列表随机
function RoleSwitchDataMgr:setNewSwitchList()

    if not next(self.switchList) then
        for k,v in ipairs(self.allHighDress) do
            local isHave = RoleDataMgr:getIsHave(v.roleId)
            local isHaveDress = GoodsDataMgr:getDress(v.dressId)
            if isHave and isHaveDress then
                table.insert(self.switchList,v.dressId)
            end
        end
    end
    local newSwitchList = Utils:shuffle(self.switchList)
    dump(newSwitchList)
    local dressData = RoleDataMgr:useDressFindData()
    if dressData and dressData.type and dressData.type == 2 then
        local index = table.indexOf(self.switchList, dressData.id)
        if index ~= -1 then
            local newIndex = table.indexOf(newSwitchList, dressData.id)
            newSwitchList[1],newSwitchList[newIndex] = newSwitchList[newIndex],newSwitchList[1]
        end
    end
    self:Send_NewSwithList(newSwitchList)
end

function RoleSwitchDataMgr:Send_NewSwithList(list)
    TFDirector:send(c2s.ROLE_REQ_SET_ROTATION_LIST, {list})
end

function RoleSwitchDataMgr:Send_TurnSwitchState(state)

    ---打开轮循开关
    if state then
        if #self.switchList < 2 then
            Utils:showTips(13310406)
            return
        end
        self:setNewSwitchList()
    end
    --self:setSwitchState(state)
    TFDirector:send(c2s.ROLE_REQ_SET_ROTATION_OPEN, {state})
end

function RoleSwitchDataMgr:onRecvUpdateSwitchList(event)

    local data = event.data
    if not data then
        return
    end
    self:setSwitchList(data.rotationList)
    EventMgr:dispatchEvent(EV_UPDATE_SWITCH_LIST)
end

function RoleSwitchDataMgr:onRecvChangeSwitchState(event)
    local data = event.data
    if not data then
        return
    end
    self:setSwitchState(data.rotationState)
    if data.rotationState then
        self:setNextSwitchTime()
        --self:setNextRole()
    end
    EventMgr:dispatchEvent(EV_UPDATE_SWITCH_STATE)
end

function RoleSwitchDataMgr:setBgm(dressId)
    local data = self:getDressCfg(dressId)
    if data and data.type and data.type == 2 and data.kanbanBgmId then
        SceneSoundDataMgr:Send_SetBackGround(0,0,data.kanbanBgmId,data.kanbanBgmId)
    end
end

function RoleSwitchDataMgr:switchRole(roleId)
    RoleDataMgr:switchRole(roleId)
end

function RoleSwitchDataMgr:useDress(roleId,dressId)
    if GoodsDataMgr:getDress(dressId) == nil then
        local str = TextDataMgr:getText(304001)
        toastMessage(str)
    else
        RoleDataMgr:sendDress(roleId,dressId)
    end
end

function RoleSwitchDataMgr:setNextRole()

    local isInSwitch = self:getSwitchState()
    if not isInSwitch then
        return
    end

    if not next(self.switchList) then
        return
    end
    ---删除不合理的高级看板
    for i=#self.switchList,1,-1 do
        local dressId  = self.switchList[i]
        local dressCfg = self:getDressCfg(dressId)
        if not dressCfg or dressCfg.type ~= 2 or dressCfg.notTurnPlay then
            table.remove(self.switchList,i)
        end
    end
    dump(self.switchList)
    local nextDressId
    local dressData = RoleDataMgr:useDressFindData()
    local useId = RoleDataMgr:getUseId()

    if dressData and dressData.type and dressData.type == 2 then
        local index = table.indexOf(self.switchList, dressData.id)
        if index ~= -1 then
            local nextId = index + 1
            nextDressId = self.switchList[nextId]
        end
    end
    if not nextDressId then
        nextDressId = self.switchList[1]
    end

    local roleId = self:getRoleIdByDressId(nextDressId)
    if not roleId then
        return
    end

    local ishave = RoleDataMgr:getIsHave(roleId)
    if not ishave then
        return
    end

    local isUnlock = GoodsDataMgr:getDress(nextDressId)
    if not isUnlock then
        return
    end

    ---切换的当前的一致
    if roleId == useId and nextDressId == dressData.id then
        self:resetSwitchTime()
        return
    end

    local firstFlag = self:getFirstFlag()
    if firstFlag then
        return
    end
    self:setNextSwitchTime()
    self:setBgm(nextDressId)
    if tonumber(roleId) ~= tonumber(useId) then
        self.switchRoleID = roleId
        self.switchDressId = nextDressId
        self:switchRole(roleId)
        local bindRoleId = tonumber(isUnlock.roleId)
        if bindRoleId == 0 then
            self:useDress(roleId,nextDressId)
        end
    else
        self:useDress(roleId,nextDressId)
    end

	self.nextDressId = nextDressId

	return nextDressId
end

return RoleSwitchDataMgr:new();
