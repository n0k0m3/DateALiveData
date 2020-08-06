local BaseDataMgr = import(".BaseDataMgr")
local RoleDataMgr = class("RoleDataMgr", BaseDataMgr)

function RoleDataMgr:ctor()
    self.roleTable = clone(TabDataMgr:getData("Role"));
    --默认使用的看板娘Id
    self.useId = nil
    --当前切换的看板娘Id
    self.curId = nil

    self.curRoomId = nil

    --看板娘小精灵会同时出现多个状态（显示权重最高的一个状态）
    self.elvesStateList = {}
    self:init()
end

function RoleDataMgr:init()
    TFDirector:addProto(s2c.ROLE_ROLE_INFO, self, self.roleInfoChange)
    TFDirector:addProto(s2c.ROLE_SWITCH_ROLE_RESULT, self, self.switchRoleHandle)
    TFDirector:addProto(s2c.ROLE_TOUCH_ROLE, self, self.onTouchRoleHandle)
    TFDirector:addProto(s2c.ROLE_UNLOCK_ROOM, self, self.onUnLockRoom)
    TFDirector:addProto(s2c.ROLE_CHANGE_ROOM, self, self.onChangeRoom)
    TFDirector:addProto(s2c.EXTRA_DATING_RES_FAVOR_DATING_PANEL, self, self.onRoleMainHandle)
    TFDirector:addProto(s2c.EXTRA_DATING_RES_FAVOR_REWARD, self, self.onMainReward)
    TFDirector:addProto(s2c.EXTRA_DATING_RES_TIGGER_ROLE_NOTICE, self, self.onMainUpdateActivationStateHandel)
    TFDirector:addProto(s2c.EXTRA_DATING_RES_FAVOR_DATING_NOTICES, self, self.onMainUpdateActivationStateSHandel)
    TFDirector:addProto(s2c.EXTRA_DATING_FAVOR_DATING_AWARD, self, self.onRoleMainHandleList)

    self:listenDress()
    self:listenDonate()
    self:resetRoleTable()
    self:resetRoleRoomInfoList()
    self:initAllRoleMainLiveList()
end

function RoleDataMgr:resetRoleTable()
    for k,v in pairs(self.roleTable) do
        local roleInfo = v
        self:resetRoleInfo(roleInfo)
        self:resetMainDatingList(v.id)
        self:resetNewMainDatingList(v.id)
    end
end

function RoleDataMgr:reset()
    self.roleTable = clone(TabDataMgr:getData("Role"))
    self.useId = nil
    self.curId = nil
    self.curRoomId = nil
    self:resetRoleTable()
    self:resetRoleRoomInfoList()
    self:initAllRoleMainLiveList()
end
--[[
    [1] = {--GetRole
    }
--]]
-- c2s.ROLE_GET_ROLE = 1281

function RoleDataMgr:onLogin()
    self:resetLogin()

    TFDirector:addProto(s2c.ROLE_ROLE_INFO_LIST, self, self.roleHandle)
    TFDirector:send(c2s.ROLE_GET_ROLE, {})
    TFDirector:send(c2s.EXTRA_DATING_REQ_FAVOR_DATING_ROLE_STATUE, {})
    TFDirector:send(c2s.EXTRA_DATING_REQ_FAVOR_DATING_AWARD,{})

     --接收玩家数据后发送给服务器语言标识 1 中文 2英文
    local languageTga = nil
    if GAME_LANGUAGE_VAR == "" then  --如果是中文
        languageTga = {1}
    else
        languageTga = {2}
    end
    TFDirector:send(c2s.SIGN_REQ_LANGUGE_SIGN , languageTga)
    return {s2c.ROLE_ROLE_INFO_LIST}
end

function RoleDataMgr:resetLogin()
    --重连清空看板娘绑定的状态
    for k,v in pairs(self.roleTable) do
        self:setElvesState(v.id)
    end
end

function RoleDataMgr:onEnterMain()
    for k,v in pairs(self.roleTable) do
        self:resetMainLiveList(v.id)
    end
    self:refreshRoleRoomInfoList()
end

--所有看板娘信息列表
--[[
    [1] = {--RoleInfoList
        [1] = {--repeated RoleInfo
            [1] = {--ChangeType(enum)
                'v4':ChangeType
            },
            [2] = 'string':id   [ 实例ID]
            [3] = 'int32':cid   [ 配置ID]
            [4] = 'int32':favor [好感度]
            [5] = 'int32':mood  [ 心情]
            [6] = 'int32':status    [ 状态 0:未使用 1:使用]
            [7] = 'repeated int32':unlockGift   [ 解锁的礼品]
            [8] = 'repeated int32':unlockHobby  [ 解锁的爱好]
            [9] = {--DressInfo
                [1] = {--ChangeType(enum)
                    'v4':ChangeType
                },
                [2] = 'string':id   [ 实例ID]
                [3] = 'int32':cid   [ 配置ID]
                [4] = 'string':roleId   [ 装备精灵ID]
                [5] = 'int32':outTime   [过期时间]
            },
            [10] = 'int32':roomId   [房间id]
        },
    }
--]]
-- s2c.ROLE_ROLE_INFO_LIST = 1281

local function changeSid(role)
    local sid = role.id
    local id  = role.cid;
    role.sid  = sid;
    role.id   = id;
end

function RoleDataMgr:roleHandle(event)
    if event.data then
        local roleInfoListData = event.data.roles or {}
        print("看板娘列表信息")

        for i,v in ipairs(roleInfoListData) do
            local roleInfo = {}
            self:roleInfoCopy(roleInfo,v)
            changeSid(roleInfo);
            self.roleTable[v.cid].ishave = roleInfo.isShow
            table.merge(self.roleTable[v.cid],roleInfo);
            if roleInfo.status == 1 then
                self:setUseId(roleInfo.id)
                -- self:setCurId(roleInfo.id)
            end
        end
        EventMgr:dispatchEvent(EV_DATING_EVENT.refreshRole)
        EventMgr:dispatchEvent(EV_DATING_EVENT.refreshRoleModel)
        self:initShowList();
        --EventMgr:dispatchEvent(EV_DATING_EVENT.refreshRedTips)
        self:setRoleSwitchData(event.data.rotationList,event.data.rotationState)
    else
        -- toastMessage("获取看板娘信息失败")
        Utils:showTips(205009)
    end
end

function RoleDataMgr:setRoleSwitchData(rotationList,rotationState)
    self.rotationList = rotationList
    self.rotationState = rotationState
end

function RoleDataMgr:getRoleSwitchData()
    return self.rotationList,self.rotationState
end

function RoleDataMgr:roleInfoCopy(roleInfo,info)
    info = info or {}
    roleInfo.changeType = info.ct or roleInfo.changeType
    roleInfo.id = info.id or roleInfo.id
    roleInfo.cid = info.cid or roleInfo.cid
    roleInfo.favor = info.favor or roleInfo.favor
    if roleInfo.favor > self:getFavorMaxValue(roleInfo.cid) then
        roleInfo.favor = self:getFavorMaxValue(roleInfo.cid)
    end
    if roleInfo.favorLevel and roleInfo.favorLevel < self:favorToLevel(roleInfo.favor,roleInfo.cid) then
        EventMgr:dispatchEvent(EV_DATING_EVENT.refreshFavorLevelUP,roleInfo.favorLevel,self:favorToLevel(roleInfo.favor,roleInfo.cid))
    end
    roleInfo.favorLevel = self:favorToLevel(roleInfo.favor,roleInfo.cid)
    roleInfo.favorPercent, roleInfo.curLvMaxFavor = self:favorToPercent(roleInfo.favor,roleInfo.cid)
    roleInfo.mood = info.mood or roleInfo.mood
    roleInfo.moodLevel = self:moodTomoodLevel(roleInfo.mood,roleInfo.cid)
    roleInfo.status = info.status or roleInfo.status
    roleInfo.unlockGift = info.unlockGift or roleInfo.unlockGift
    roleInfo.unlockHobby = info.unlockHobby or roleInfo.unlockHobby
    roleInfo.useRoomId = info.roomId or roleInfo.useRoomId
    roleInfo.ishave = info.isShow or roleInfo.ishave
    local favoriteIds = info.favoriteIds or {}
    for i, v in ipairs(favoriteIds) do
        self:addLikeGood(v,roleInfo.cid)
    end

    if info.roleState then
        --清除精灵普通三个状态
        self:removeElvesState(roleInfo.cid,EC_ElvesState.hunger)
        self:removeElvesState(roleInfo.cid,EC_ElvesState.angry)
        self:removeElvesState(roleInfo.cid,EC_ElvesState.bored)
        self:addElvesState(roleInfo.cid,info.roleState)
        roleInfo.speState = info.roleState
    end

    if info.favorCriticalPoint ~= nil then
        roleInfo.favorCriticalPoint = info.favorCriticalPoint
    end
    if info.dress then
        roleInfo.dressId = info.dress.cid
    end
    roleInfo.useModel = self:dressFindModel(roleInfo.dressId)
    self:refreshRoleInfo(roleInfo)
end

--单个看板娘信息刷新
--[[
    [1] = {--RoleInfo
        [1] = {--ChangeType(enum)
            'v4':ChangeType
        },
        [2] = 'string':id   [ 实例ID]
        [3] = 'int32':cid   [ 配置ID]
        [4] = 'int32':favor [好感度]
        [5] = 'int32':mood  [ 心情]
        [6] = 'int32':status    [ 状态 0:未使用 1:使用]
        [7] = 'repeated int32':unlockGift   [ 解锁的礼品]
        [8] = 'repeated int32':unlockHobby  [ 解锁的爱好]
        [9] = {--DressInfo
            [1] = {--ChangeType(enum)
                'v4':ChangeType
            },
            [2] = 'string':id   [ 实例ID]
            [3] = 'int32':cid   [ 配置ID]
            [4] = 'string':roleId   [ 装备精灵ID]
            [5] = 'int32':outTime   [过期时间]
        },
        [10] = 'int32':roomId   [房间id]
        [11] = 'bool':favorCriticalPoint    [好感度临界点]
    }
--]]
-- s2c.ROLE_ROLE_INFO = 1283


function RoleDataMgr:roleInfoChange(event)
    if event.data then
        local roleInfo = event.data
        if roleInfo.ct == EC_SChangeType.ADD or roleInfo.ct == EC_SChangeType.DEFAULT then
            local _roleInfo = {}
            self:roleInfoCopy(_roleInfo,roleInfo)
            changeSid(_roleInfo);
            self:getRoleInfo(_roleInfo.cid).ishave = roleInfo.isShow
            table.merge(self.roleTable[_roleInfo.cid],_roleInfo);
            self:initShowList();
            EventMgr:dispatchEvent(EV_DATING_EVENT.addRole)
            self:resetMainLiveList(roleInfo.cid)
        elseif roleInfo.ct == EC_SChangeType.UPDATE then
            self:roleInfoCopy(self:getRoleInfo(roleInfo.cid),roleInfo)
            changeSid(self:getRoleInfo(roleInfo.cid))
            self:resetMainLiveList(roleInfo.cid)
        elseif roleInfo.ct == EC_SChangeType.DELETE then
            self:getRoleInfo(roleInfo.cid).ishave = false;
        end
        EventMgr:dispatchEvent(EV_DATING_EVENT.refreshRole)
        --EventMgr:dispatchEvent(EV_DATING_EVENT.refreshRedTips)
    else
        -- toastMessage("获取当前看板娘信息变化失败")
        Utils:showTips(205010)
    end
end

function RoleDataMgr:initAllRoleMainLiveList()
    print("initAllRoleMainLiveList")
    for k,v in pairs(self.roleTable) do
        v.mainLiveList = self:initMainLive(v.id)
    end
end

function RoleDataMgr:initMainLive_(roleId)
    roleId = roleId or self:getCurId()
    local mainLiveList = {}
    local list = string.split(self.roleTable[roleId].mainLive, ",")
    for i,v in ipairs(list) do
        local mainLive = {}
        mainLive.favor = tonumber(string.split(v, "-")[1])
        mainLive.script = tonumber(string.split(v,"-")[2])
        mainLive.state = EC_DatingScriptState.LOCK
        table.insert(mainLiveList,mainLive)
    end
    return mainLiveList
end

function RoleDataMgr:initMainLive(roleId)
    roleId = roleId or self:getCurId()
    self.cityDatingRuleTable = clone(TabDataMgr:getData("DatingRule"))

    local mainLiveList = {}

    for k,v in pairs(self.cityDatingRuleTable) do
        if v.type == EC_DatingScriptType.MAIN_SCRIPT then
            for ir,vr in ipairs(v.enter_condition["roleCids"]) do
                if vr == roleId then
                    local mainLive = {}
                    mainLive.favor = v.enter_condition["favor"]
                    mainLive.fubenLevelCid = v.enter_condition["fubenLevelCid"]
                    mainLive.script = k
                    mainLive.state = EC_DatingScriptState.LOCK
                    mainLive.currentNodeId = v.start_node_id
                    table.insert(mainLiveList,mainLive)
                    break
                end
            end
        end
    end

    return mainLiveList
end

function RoleDataMgr:getMainLiveList(roleId)
    roleId = roleId or self:getCurId()

    self:sortMainLiveList(self.roleTable[roleId].mainLiveList)
    return self.roleTable[roleId].mainLiveList
end

function RoleDataMgr:sortMainLiveList(mainLiveList)
    local function sortFunc(a,b)
        -- local aState = a.state;
        -- local bState = b.state;

        -- if aState == bState then
        --     return false
        -- else
        --     return aState > bState;
        -- end

        return a.script < b.script
    end

    table.sort(mainLiveList,sortFunc);
end

function RoleDataMgr:getTriggerDatingList(roleId)
    roleId = roleId or self:getCurId()
    return DatingDataMgr:getTriggerDatingInfoListByRoleId(roleId)
end

function RoleDataMgr:getTriggerDatingProByType(roleId,type)
    --DatingDataMgr:getDatingRuleData(v.datingRuleCid).item_type
    local triggerList = self:getTriggerDatingList(roleId) or {}
    local maxNum = 0
    local num = 0
    if type == 1 then  --道具约会
        maxNum = 5
    elseif type == 2 then -- 时装约会
        maxNum = 3
    end
    for i,v in ipairs(triggerList) do
        if type == DatingDataMgr:getDatingRuleData(v.datingRuleCid).item_type then
            num = num + 1
        end
    end

    return math.ceil((num/maxNum) * 100)
end

function RoleDataMgr:getDressDating(roleId)
    local triggerList = self:getTriggerDatingList(roleId) or {}
    local list = {}
    for i,v in ipairs(triggerList) do
        if 1 == DatingDataMgr:getDatingRuleData(v.datingRuleCid).item_type then
            list = list or {}
            table.insert(list,v)
        end
    end
    return list
end

function RoleDataMgr:getGiftsDating(roleId)
    local triggerList = self:getTriggerDatingList(roleId) or {}
    local list = {}
    for i,v in ipairs(triggerList) do
        if 2 == DatingDataMgr:getDatingRuleData(v.datingRuleCid).item_type then
            list = list or {}
            table.insert(list,v)
        end
    end
    return list
end

function RoleDataMgr:getDayBuildList(roleId)
    roleId = roleId or self:getCurId()
    return DatingDataMgr:getBuildListByRoleId(roleId)
end

function RoleDataMgr:getDayDatingPro(roleId)
    local pro = 0
    local dayBuildList = self:getDayBuildList(roleId)
    local finishValue = 0
    local maxValue = 0

    for i, v in ipairs(dayBuildList) do
        local buildId = v.buildId
        local info = DatingDataMgr:getBuildDayScripInfo(buildId)
        finishValue = finishValue + info.process
        maxValue = maxValue + 100
    end

    pro = (finishValue/maxValue) * 100

    return math.ceil(pro)
end

function RoleDataMgr:resetMainLiveList(roleId)
    local roleInfo = self:getRoleInfo(roleId)
    local mainLiveList = self:getMainLiveList(roleId)
    for i,v in ipairs(mainLiveList) do
        local mainLive = v
        local notFinishDatingInfo = DatingDataMgr:getNotFinishDatingInfoByType(EC_DatingScriptType.MAIN_SCRIPT,mainLive.script,roleId)
        if notFinishDatingInfo then
            mainLive.state = EC_DatingScriptState.NO_FINISH
            break
        end
        if table.find(DatingDataMgr:getFinishScriptList(),mainLive.script) ~= -1 then
            mainLive.state = EC_DatingScriptState.NORMAL
        end
        if roleInfo.favor >= mainLive.favor and mainLive.state == EC_DatingScriptState.LOCK then
            local isActivation = true
            --暂时屏蔽关卡限制
             print("mainLive.fubenLevelCid ",mainLive.fubenLevelCid)
             if mainLive.fubenLevelCid then
                 isActivation = FubenDataMgr:isPassPlotLevel(mainLive.fubenLevelCid)
             end
            if isActivation then
                mainLive.state = EC_DatingScriptState.TRIGGER
            end
        end
    end
end

--当前好感度激活的主线约会
function RoleDataMgr:activateMainLive(roleInfo)
    local activateMainLives = {}
    local allMainLives = self:getMainLive(roleInfo.cid)

    for i,v in ipairs(allMainLives) do
        local mainLive = v
        if roleInfo.favor >= mainLive.favor then
            local isInsert = true
            for m,mlv in ipairs(activateMainLives) do
                if mlv.script == mainLive.script then
                    isInsert = false
                end
            end
            if isInsert == true then
                table.insert(activateMainLives,mainLive)
            end
        end
    end

    print("roleInfo.cid ",roleInfo.cid)
    print("activateMainLives ",activateMainLives)
    return activateMainLives
end

function RoleDataMgr:getIsActivateMainLive(script,roleId)
    local activateMainLives = self:getRoleActivateMainLives(roleId)
    for i,v in ipairs(activateMainLives) do
        if v.script == script then
            return true
        end
    end
    return false
end

function RoleDataMgr:setMainLiveStateByIdx(idx,state,roleId)
    local mainLiveList = self:getMainLiveList(roleId)
    mainLiveList[idx].state = state
end

function RoleDataMgr:setMainLiveStateByRuleCid(datingRuleCid,state,roleId)
    local mainLiveList = self:getMainLiveList(roleId)
    for i,v in ipairs(mainLiveList) do
        local mainLive = v
        if mainLive.script == datingRuleCid then
            mainLive.state = state
        end
    end
end

function RoleDataMgr:getMainLiveByIdx(idx,roleId)
    local mainLiveList = self:getMainLiveList(roleId)

    return mainLiveList[idx]
end

function RoleDataMgr:getMainLiveScriptByIdx(idx,roleId)
    local mainLiveList = self:getMainLiveList(roleId)

    return mainLiveList[idx].script
end

function RoleDataMgr:getMainLiveStateByIdx(idx,roleId)
    local mainLiveList = self:getMainLiveList(roleId)

    return mainLiveList[idx].state
end

function RoleDataMgr:getMainLiveStateByRuleCid(datingRuleCid,roleId)
    return self:getMainLiveByRuleCid(datingRuleCid,roleId).state
end

function RoleDataMgr:getMainLiveByRuleCid(datingRuleCid,roleId)
    roleId = roleId or self:getCurId()
    local mainLiveList = self:getMainLiveList(roleId)
    for i,v in ipairs(mainLiveList) do
        local mainLive = v
        if mainLive.script == datingRuleCid then
            return mainLive
        end
    end
end

function RoleDataMgr:getMainLiveDatingState(roleId)
    roleId = roleId or self:getCurId()
    local state = EC_DatingScriptState.NORMAL
    local mainLiveList = self:getMainLiveList(roleId)
    for i,v in ipairs(mainLiveList) do
        local mainLive = v
        state = math.max(state, mainLive.state)
    end

    return state
end

function RoleDataMgr:getMainLiveDatingNewIdx(roleId)
    roleId = self:getCurId()
    local newIdx = nil
    local mainLiveList = self:getMainLiveList(roleId)
    for i,v in ipairs(mainLiveList) do
        local mainLive = v
        state = mainLive.state
        if state == EC_DatingScriptState.TRIGGER then
            newIdx = i
            break
        elseif state == EC_DatingScriptState.NO_FINISH then
            newIdx = i
            break
        elseif state == EC_DatingScriptState.NORMAL then
            newIdx = i
        end
    end
    return newIdx
end

function RoleDataMgr:getDayDatingState(roleId)
    local notFinishDatingInfoList = DatingDataMgr:getNotFinishDatingInfoList()
    return self:getCommonDatingState(EC_DatingScriptType.DAY_SCRIPT,roleId)
end

function RoleDataMgr:getOutSideDatingState(roleId)
    return self:getCommonDatingState(EC_DatingScriptType.OUTSIDE_SCRIPT,roleId)
end

function RoleDataMgr:getTriggerDatingState(roleId)
    local roleTriggerInfoList = self:getTriggerDatingList(roleId)
    local state = EC_DatingScriptState.NORMAL
    if not roleTriggerInfoList then
        return state
    end
    for i,v in ipairs(roleTriggerInfoList) do
        state = math.max(state, v.state)
    end
    print("getTriggerDatingState state",state)
    return state
end

function RoleDataMgr:getCommonDatingState(datingType,roleId)
    roleId = roleId or self:getCurId()
    local state = EC_DatingScriptState.NORMAL
    local notFinishDatingInfoList = DatingDataMgr:getNotFinishDatingInfoList()
    if not notFinishDatingInfoList then
        return state
    end
    for i,v in ipairs(notFinishDatingInfoList) do
        local notFinishDatingInfo = v
        if notFinishDatingInfo.roleCid == roleId and notFinishDatingInfo.datingType == datingType then
           state = EC_DatingScriptState.NO_FINISH
           break
        end
    end
    return state
end

function RoleDataMgr:getDatingIsTip(id)
    id = id or self:getCurId()
    if not self:getIsHave(id) then
        return false
    end
    local notFinishDatingInfoList = DatingDataMgr:getNotFinishDatingInfoList()
    for i,v in ipairs(notFinishDatingInfoList) do
        local notFinishDatingInfo = v
        if notFinishDatingInfo.roleCid == id then
           return true
        end
    end
    if self:getMainLiveDatingState(id) == EC_DatingScriptState.TRIGGER or self:getTriggerDatingState(id) == EC_DatingScriptState.TRIGGER then
        return true
    end
    return false
end

function RoleDataMgr:getDatingIsNotFinish(id)
    id = id or self:getCurId()
    if not self:getIsHave(id) then
        return false
    end
    local notFinishDatingInfoList = DatingDataMgr:getNotFinishDatingInfoList()
    for i,v in ipairs(notFinishDatingInfoList) do
        local notFinishDatingInfo = v
        if notFinishDatingInfo.roleCid == id then
           return true
        end
    end

    return false
end

function RoleDataMgr:getAllRoleDatingIsTip()
    for i,v in ipairs(self.showList) do
        if self:getDatingIsTip(v) and v ~= self:getCurId() then
            return true
        end
    end
    return false
end

function RoleDataMgr:favorToLevel(favor,cid)
    local npcInfo = self.roleTable[cid]
    local favorLevelTable = clone(npcInfo.favorLevels)
    for i,v in ipairs(favorLevelTable) do
        if v == 0 or v == #favorLevelTable then
            table.removeItem(favorLevelTable,v)
        end
    end
    local favorLevel = 1
    for i,v in ipairs(favorLevelTable) do
        if favor > v then
            favorLevel = favorLevel + 1
        else
            break
        end
    end
    -- if favorLevel > #favorLevelTable then
    --     favorLevel = #favorLevelTable
    -- end
    return favorLevel
end

function RoleDataMgr:dressFindModel(dressId)
    local dressTable = TabDataMgr:getData("Dress")
    self.data = dressTable[dressId]
    if self.data then
        return self.data.roleModel
    end
    return nil
end

--切換看板娘請求（使用）
--[[
    [1] = {--SwitchRole
        [1] = 'string':roleId   [ 精灵id]
    }
--]]
-- c2s.ROLE_SWITCH_ROLE = 1285
function RoleDataMgr:switchRole(roleId)
    if not self:getIsHave(roleId) then
        -- toastMessage("看板娘未解锁")
        Utils:showTips(205011)
        return
    end

    local roleSid = self.roleTable[roleId].sid;
    local scriptMsg =
    {
        roleSid
    }
    TFDirector:send(c2s.ROLE_SWITCH_ROLE, scriptMsg)
end

--切換看板娘返回(使用)
--[[
    [1] = {--SwitchRoleResult
        [1] = {--repeated RoleStatusInfo
            [1] = 'string':roleId
            [2] = 'int32':status
        },
    }
--]]
-- s2c.ROLE_SWITCH_ROLE_RESULT = 1285
function RoleDataMgr:switchRoleHandle(event)
    if event.data then
        local roleInfo = event.data.Rolestatus
        local roleId = roleInfo[1].roleId
        local status = roleInfo[1].status
        for k,v in pairs(self.roleTable) do
            if v.sid and v.sid == roleId then
                v.status = status
                self.useId = v.id
            else
                v.status = 0
            end
        end
        EventMgr:dispatchEvent(EV_DATING_EVENT.refreshRoleModel)
        self:initShowList();
        EventMgr:dispatchEvent(EV_DATING_EVENT.switchRole)
    else
        -- toastMessage("切換看板娘失败")
        Utils:showTips(205012)
    end
end

--选择看板娘
function RoleDataMgr:selectRole(roleId)
    self:setCurId(roleId)
    EventMgr:dispatchEvent(EV_KANBAN_SWITCH_SHOW_ONE)
end

function RoleDataMgr:sortRoles()
    local function sortFunc(a,b)
        local arole = self.roleTable[a]
        local brole = self.roleTable[b]
        local ahave = 0;
        local bhave = 0;
        if arole.ishave then ahave = 1;end
        if brole.ishave then bhave = 1;end

        if ahave == bhave then
            return arole.id < brole.id;
        else
            return ahave > bhave;
        end
    end

    table.sort(self.showList,sortFunc);
end

function RoleDataMgr:getRoleIdx(id)
    for i,v in ipairs(self.showList or {}) do
        local role = self.roleTable[v]
        if role.cid == id then
            return i
        end
    end
    return nil
end

function RoleDataMgr:initShowList()
    self.showList = {}
    for k,v in pairs(self.roleTable) do
        if v.isOpen then
            table.insert(self.showList,v.id);
        end
    end
    self:sortRoles();
end

function RoleDataMgr:getIsHave(id)
    return self.roleTable[id] and self.roleTable[id].ishave;
end

function RoleDataMgr:setUseId(roleId)
    self.useId = roleId
end

function RoleDataMgr:getUseId()
    return self.useId;
end

--判断角色看板是否使用中(兼容多人看板)
function RoleDataMgr:checkRoleUseState(roleId)
    if self.useId == roleId then
        return true
    end
    --检测是否为多人看板
    local useRoleInfo = self:getRoleInfo(self.useId)
    if not useRoleInfo or not useRoleInfo.dressId then return false end
    local useDressId = useRoleInfo.dressId
    local relatedDress = TabDataMgr:getData("Dress", useDressId).relatedDress

    for k, v in ipairs(relatedDress or {}) do
        local tmpRoleId = TabDataMgr:getData("Dress", v).belongTo
        if tmpRoleId and tmpRoleId == roleId then
            return true
        end
    end

    return false
end

--判断看板时装是否使用中(兼容多人看板)
function RoleDataMgr:checkDressUseState(dressId, useDressId, checkAll)
    local useRoleInfo = self:getRoleInfo(self.useId)
    if not useRoleInfo or not useRoleInfo.dressId then return false end
    local realDressId = useRoleInfo.dressId
    useDressId = useDressId or realDressId

    if useDressId == dressId then
        return true
    end

    local relatedDress = TabDataMgr:getData("Dress", dressId).relatedDress
    for k, v in ipairs(relatedDress or {}) do
        if v == useDressId or (checkAll and v == realDressId) then
            return true
        end
    end

    return false
end

--判断时装对应的角色是否都拥有(兼容多人看板)
function RoleDataMgr:checkRoleHaveByDressId(dressId)
    local tmpRoleId = TabDataMgr:getData("Dress", dressId).belongTo
    if tmpRoleId == 0 then return true end

    if not self:getIsHave(tmpRoleId) then
        return false
    end

    local relatedDress = TabDataMgr:getData("Dress", dressId).relatedDress
    for k, v in ipairs(relatedDress or {}) do
        local tmpRoleId = TabDataMgr:getData("Dress", v).belongTo
        if tmpRoleId ~= 0 and not self:getIsHave(tmpRoleId) then
            return false
        end 
    end

    return true
end

--获取看板角色好感度等级(兼容多人看板，多人看板取最小的的等级)
function RoleDataMgr:getRoleFavorLv(roleId)
    local roleInfo = self:getRoleInfo(roleId)
    if not roleInfo then return 0 end
    local realFavorLv = roleInfo.favorLevel
    local curDressId = roleInfo.dressId
    local relatedDress = TabDataMgr:getData("Dress", curDressId).relatedDress

    for k, v in ipairs(relatedDress or {}) do
        local tmpRoleId = TabDataMgr:getData("Dress", v).belongTo
        local tmpRoleInfo = self:getRoleInfo(tmpRoleId)
        if tmpRoleInfo and tmpRoleInfo.favorLevel and tmpRoleInfo.favorLevel < realFavorLv then
            realFavorLv = tmpRoleInfo.favorLevel
        end
    end

    return realFavorLv
end

--获取看板角色好感度(兼容多人看板，多人看板取最小的的等级)
function RoleDataMgr:getRoleFavor(roleId)
    local roleInfo = self:getRoleInfo(roleId)
    if not roleInfo then return 0 end
    local realFavor = roleInfo.favor
    local curDressId = roleInfo.dressId
    local relatedDress = TabDataMgr:getData("Dress", curDressId).relatedDress

    for k, v in ipairs(relatedDress or {}) do
        local tmpRoleId = TabDataMgr:getData("Dress", v).belongTo
        local tmpRoleInfo = self:getRoleInfo(tmpRoleId)
        if tmpRoleInfo and tmpRoleInfo.favor and tmpRoleInfo.favor < realFavor then
            realFavor = tmpRoleInfo.favor
        end
    end

    return realFavor
end

function RoleDataMgr:setCurId(roleId)
    self.curId = self:getIsHave(roleId) and roleId or nil
end

function RoleDataMgr:getCurId()
    return self.curId or self.useId
end

function RoleDataMgr:getRoleCount()
    return table.count(self.showList);
end

function RoleDataMgr:getHeadIconPath(id)
    return self.roleTable[id].icon;
end

function RoleDataMgr:getNameIconPath(id)
    return self.roleTable[id].nameicon;
end

function RoleDataMgr:getSmallIconPath(id)
    return self.roleTable[id].smallIcon
end

function RoleDataMgr:getEnName(id)
    local enName = self.roleTable[id].enName;
    return enName or ""
end

function RoleDataMgr:getEnName2(id)
    local enName = self.roleTable[id].enName2;
    return enName or ""
end

function RoleDataMgr:getName(id)
    local nameid = self.roleTable[id].nameId;
    local name = TextDataMgr:getText(nameid);
    return name
end

function RoleDataMgr:getAkira(id)
    local akiraNameId = self.roleTable[id].akiraId
    local akiraName = TextDataMgr:getText(akiraNameId);
    return akiraName
end

function RoleDataMgr:getRoleIdByShowIdx(showidx)
    return self.showList[showidx];
end

function RoleDataMgr:getRoleIdList()
    return self.showList
end

function RoleDataMgr:getDesc(id)
    local descid = self.roleTable[id].describe;
    local desc = TextDataMgr:getText(descid);
    return desc
end

function RoleDataMgr:getModel(id)
    if self.roleTable[id] then
        return self.roleTable[id].useModel or self:getModelList(id)[1];
    end
end

function RoleDataMgr:getModelList(id)
    if self.roleTable[id] then
        return self.roleTable[id].modelList;
    end
end

function RoleDataMgr:getMood(id)
    return self.roleTable[id].mood
end

function RoleDataMgr:getMoodPath(id)
    return self.roleTable[id].moodPath
end

function RoleDataMgr:getMoodLevel(id)
    return self.roleTable[id].moodLevel
end

function RoleDataMgr:getMoodIcon(id,level)
    level = level or self.roleTable[id].moodLevel
    local moodIconName = string.format("%s%d.png",self.roleTable[id].moodPath,level)
    return moodIconName
end

function RoleDataMgr:getMoodDes(id,level,descId)
    level = level or self.roleTable[id].moodLevel
    descId = descId or self.roleTable[id].moodDes[level]
    local desc = TextDataMgr:getText(descId)
    return desc
end

function RoleDataMgr:getMoodBuffId(id,level)
    return self.roleTable[id].moodBuff[level]
end

function RoleDataMgr:getFavor(id)
    id = id or self:getCurId()
    return self.roleTable[id].favor
end

function RoleDataMgr:getFavorCriticalPoint(id)
    id = id or self:getCurId()
    return self.roleTable[id].favorCriticalPoint
end

function RoleDataMgr:isFavorReachCriticality(id)
    if self:isFavorReachMaxValue(id) then
        return false
    end
    -- return self:getFavorCriticalPoint() --取消好感度临界值判断
end

function RoleDataMgr:isFavorReachMaxValue(id)
    return self:getRoleFavor(id) >= self:getFavorMaxValue(id)
end

function RoleDataMgr:getRoleId(modelId)
    for k,v in pairs(self.roleTable) do
        local id = k
        for idx,model in ipairs(self.roleTable[id].modelList) do
            if model == modelId then
                return id
            end
        end
    end
    return
end

function RoleDataMgr:getDressList(id)
    return self.roleTable[id].dress
end

function RoleDataMgr:getDressIndex(id,dressId)
    dressId = dressId or self.roleTable[id].dressId
    for i,v in ipairs(self.roleTable[id].dress) do
        if v == dressId then
            return i
        end
    end
    return 1
end

function RoleDataMgr:getRoleSid(id)
    return self.roleTable[id].sid
end

function RoleDataMgr:getRoleInfo(id)
    id = id or self:getCurId()
    return self.roleTable[id]
end

function RoleDataMgr:getMainIconPath(id,idx)
    local mainIcon = clone(self:getRoleInfo(id).mainIcon)
    local iconPathList = string.split(mainIcon, "-")
    if idx > #iconPathList then
        Box("not found 主线图标 ID:"..tostring(idx))
        return
    end
    return iconPathList[idx]
end

function RoleDataMgr:getRoleDatingBottom(id)
    return self.roleTable[id].datingBottom
end

function RoleDataMgr:getUseRoleInfo()
    return self:getRoleInfo(self.useId)
end

function RoleDataMgr:getCurRoleInfo()
    return self:getRoleInfo(self:getCurId())
end

function RoleDataMgr:getAllGoodInfoList(roleId)
    local goodInfoList = {}
    local giftTable = TabDataMgr:getData("Item")
    for k, v in pairs(giftTable) do
        if v.superType == 8 then
            local goodInfo = {}
            goodInfo.id = k
            goodInfo.subType = v.subType
            table.insert(goodInfoList, goodInfo)
        end
    end

    return goodInfoList
end

function RoleDataMgr:getAllGiftInfoList(roleId)
    local goodInfoList = self:getAllGoodInfoList(roleId)
    local giftInfoList = {}
    for i, v in ipairs(goodInfoList) do
        if v.subType == 2 and GoodsDataMgr:getItemCount(v.id) > 0 then
            table.insert(giftInfoList, v)
        end
    end

    return giftInfoList
end

function RoleDataMgr:getAllFoodInfoList(roleId)
    local goodInfoList = self:getAllGoodInfoList(roleId)
    local foodInfoList = {}
    for i, v in ipairs(goodInfoList) do
        if v.subType == 1 and GoodsDataMgr:getItemCount(v.id) > 0 then
            table.insert(foodInfoList, v)
        end
    end

    return foodInfoList
end

function RoleDataMgr:getuLikeGood()
    local likeGoods = self:getLikeGood()
    local goodInfoList = self:getAllGoodInfoList()
    for i,v in ipairs(goodInfoList) do
        if table.find(likeGoods,v.id) ~= -1 and v.subType == 1 then
            return v.id
        end
    end
end

function RoleDataMgr:getuLikeGift()
    local likeGoods = self:getLikeGood()
    local goodInfoList = self:getAllGoodInfoList()
    for i,v in ipairs(goodInfoList) do
        if table.find(likeGoods,v.id) ~= -1 and v.subType == 2 then
            return v.id
        end
    end
end

function RoleDataMgr:getGiftIdList()

    local useRoleInfo = self:getCurRoleInfo()

    local giftIdList = {}
    table.insertTo(giftIdList,useRoleInfo.openFoodsId)
    table.insertTo(giftIdList,useRoleInfo.openGiftId)
    table.insertTo(giftIdList,useRoleInfo.openEventItemId)

    for i = table.count(giftIdList),1,-1 do
        local id = giftIdList[i]
        local num = GoodsDataMgr:getItemCount(id)
        if num == 0 then
            table.remove(giftIdList,i)
        end
    end

    return giftIdList
end

function RoleDataMgr:getDressIdList(roleId)
    roleId = roleId or self:getUseId()
    local useRoleInfo = self:getRoleInfo(roleId)
    local useDressId = useRoleInfo.dressId
    local dressIdList = {}
    for i,v in ipairs(useRoleInfo.dressIdList) do
        table.insert(dressIdList,v)
    end
    local function sortFunc(a,b)
        local aIsHave = GoodsDataMgr:getDress(a)
        local bIsHave = GoodsDataMgr:getDress(b)
        local ahave = 0;
        local bhave = 0;
        local aType = 0;
        local bType = 0;
        if aIsHave then ahave = 1;end
        if bIsHave then bhave = 1;end
        if self:checkDressUseState(a, useDressId, true) then ahave = 2;end
        if self:checkDressUseState(b, useDressId, true) then bhave = 2;end
        aType = TabDataMgr:getData("Dress",a).type
        bType = TabDataMgr:getData("Dress",b).type
        if ahave == bhave then
            if aType == bType then
                return a < b;
            else
                return aType < bType;
            end
        else
            return ahave > bhave;
        end
    end

    table.sort(dressIdList,sortFunc);

    return dressIdList
end

function RoleDataMgr:getRoleActivateMainLives(roleId)
    roleId = roleId or self:getCurId()
    return self:getRoleInfo(roleId).activateMainLives
end

function RoleDataMgr:getRoleId_(sid)
    for k,v in pairs(self.roleTable) do
        if sid == v.sid then
            return k
        end
    end
end

function RoleDataMgr:getFavorPercent(id)
    if self:getIsHave(id) then
        return self.roleTable[id].favorPercent;
    else
        return 0;
    end
end

function RoleDataMgr:getCurLvMaxFavor(id)
    return self.roleTable[id] and self.roleTable[id].curLvMaxFavor or 0
end

function RoleDataMgr:getLvMaxFavor(id,level)
    if self:getIsHave(id) then
        local npcInfo = self.roleTable[id]
        local favorLevelTable = clone(npcInfo.favorLevels)
        for i,v in ipairs(favorLevelTable) do
            if v == 0 then
                table.removeItem(favorLevelTable,v)
            end
        end
        local _level = level
        if level > #favorLevelTable then
            _level = #favorLevelTable
        end
        local maxFavor = favorLevelTable[_level]
        return maxFavor
    end
    return 0
end

function RoleDataMgr:getFavorMaxLv(id)
    local npcInfo = self.roleTable[id]
    return #npcInfo.favorLevels-1
end

function RoleDataMgr:getFavorDesc(id)
    local level = self:getFavorLevel(id)

    local descid  = EC_FavorType[level];
    return TextDataMgr:getText(descid);
end

function RoleDataMgr:getFavorLevel(id)
    id = id or self:getCurId()
    local level = 1;
    if self:getIsHave(id) then
        level = self.roleTable[id].favorLevel
    end
    return level
end

function RoleDataMgr:favorToPercent(favor,cid)
    local npcInfo = self.roleTable[cid]
    local favorLevelTable = clone(npcInfo.favorLevels)
    for i,v in ipairs(favorLevelTable) do
        if v == 0 then
            table.removeItem(favorLevelTable,v)
        end
    end
    local favorPercent = 0
     for i,v in ipairs(favorLevelTable) do
        if favor <= v then
            local lastFavor = 0
            if i > 1 then
                lastFavor = favorLevelTable[i-1]
            end
            -- favorPercent = (favor - lastFavor) / (v-lastFavor) * 100
            favorPercent = favor/v*100
            return favorPercent,v
        end
    end
end

function RoleDataMgr:favorToTotalPercent(roleId,favor)
    favor = favor or self:getFavor(roleId)
    local npcInfo = self.roleTable[roleId]
    local favorLevelTable = npcInfo.favorLevels
    local favorPercent = (favor/favorLevelTable[#favorLevelTable]) * 100
    return favorPercent
end

function RoleDataMgr:percentToFavor(favorPercent,cid,level)
    local npcInfo = self.roleTable[cid]
    local favorLevelTable = clone(npcInfo.favorLevels)
    for i,v in ipairs(favorLevelTable) do
        if v == 0 then
            table.removeItem(favorLevelTable,v)
        end
    end
    local favor = favorLevelTable[level] * (favorPercent/100)
    for i=1,level-1 do
        favor = favor + favorLevelTable[i]
    end
    return math.ceil(favor)
end

function RoleDataMgr:getFavorMaxValue(cid)
    cid = cid or self:getCurId()
    local npcInfo = self.roleTable[cid]
    local favorLevelTable = clone(npcInfo.favorLevels)
    return favorLevelTable[#favorLevelTable]
end

function RoleDataMgr:moodTomoodLevel(mood,cid)
    local npcInfo = self.roleTable[cid]
    local moodLevelTable = npcInfo.moodLevels or {40,60,80,90,100}
    local moodLevel = 1
    for i,v in ipairs(moodLevelTable) do
        if mood >= v then
            moodLevel = moodLevel + 1
        end
    end
    if moodLevel > #moodLevelTable then
        moodLevel = #moodLevelTable
    end
    return moodLevel
end

function RoleDataMgr:getCurLvMaxMood(cid)
    local npcInfo = self.roleTable[cid]
    local moodLevelTable = npcInfo.moodLevels or {40,60,80,90,100}
    for i,v in ipairs(moodLevelTable) do
        if npcInfo.moodLevel == i then
            return v
        end
    end

    return moodLevelTable[1]
end

--[[
    [1] = {--Donate
        [1] = 'string':roleId   [ 精灵ID]
        [2] = 'int32':itemCid   [ 赠送道具ID]
        [3] = 'int32':num   [ 赠送数量]
    }
--]]
-- c2s.ROLE_DONATE = 1282

function RoleDataMgr:sendDonate(id,itemCid,num)
    local donateMsg = {
        tostring(id),
        itemCid,
        num
    }

    print("donateMsg ",donateMsg)
    local nResult = TFDirector:send(c2s.ROLE_DONATE, donateMsg)

end

--[[
    [1] = {--Donate
    }
--]]
-- s2c.ROLE_DONATE = 1282
function RoleDataMgr:listenDonate()
    TFDirector:addProto(s2c.ROLE_DONATE, self, self.changeDonateHandle)
end

function RoleDataMgr:changeDonateHandle(event)
    if event.data then
        local goodId = event.data.favoriteId
        self:addLikeGood(goodId)
        EventMgr:dispatchEvent(EV_DATING_EVENT.refreshRoleDonate)
    else

    end
end

--[[
    [1] = {--Dress
        [1] = 'string':roleId   [ 精灵ID]
        [2] = 'string':itemId   [ 装备]
    }
--]]
-- c2s.ROLE_DRESS = 1284

function RoleDataMgr:sendDress(roleId,itemCid)
    local itemId = GoodsDataMgr:getDress(itemCid).id
    local dressMsg = {
        tostring(roleId),
        tostring(itemId),
    }

    print("RoleDataMgr:sendDress dressMsg ",dressMsg)
    local nResult = TFDirector:send(c2s.ROLE_DRESS, dressMsg)
end

--[[
    [1] = {--Dress
    }
--]]
-- s2c.ROLE_DRESS = 1284

function RoleDataMgr:listenDress()
    TFDirector:addProto(s2c.ROLE_DRESS, self, self.changeDressHandle)
end

function RoleDataMgr:changeDressHandle(event)
    if event.data then
        EventMgr:dispatchEvent(EV_DATING_EVENT.changeDress)
    else
        -- toastMessage("换装失败")
        Utils:showTips(205013)
    end
end

--[[
    [1] = {--TouchRole
    }
--]]
-- c2s.ROLE_TOUCH_ROLE = 1287
function RoleDataMgr:sendTouchRole()
    if not GoodsDataMgr:getItem(EC_SItemType.ROLETOUCHTIMES) or GoodsDataMgr:getItemCount(EC_SItemType.ROLETOUCHTIMES) == 0 then
        return
    end
    local msg = {}
    TFDirector:send(c2s.ROLE_TOUCH_ROLE,msg)
end

--[[
    [1] = {--TouchRole
    }
--]]
-- s2c.ROLE_TOUCH_ROLE = 1287
function RoleDataMgr:onTouchRoleHandle()
    EventMgr:dispatchEvent(EV_DATING_EVENT.touchRoleToFavor)
end

function RoleDataMgr:refreshRoleInfo(roleInfo)
    local giftTable = TabDataMgr:getData("Item")

    --兴趣爱好
    roleInfo.openHobbyId = roleInfo.unlockHobby
    --喜欢的食物
    roleInfo.openFoodsId = {}
    --喜欢的礼物
    roleInfo.openGiftId = {}
    --特殊道具
    roleInfo.openEventItemId = {}
    if not roleInfo.unlockGift then
        return
    end
    for i,v in ipairs(roleInfo.unlockGift) do
        local giftId = v
        local gift = giftTable[giftId]
        if gift then
        if gift.subType == 1 then
            table.insert(roleInfo.openFoodsId,giftId)
            elseif gift.subType == 2 then
            table.insert(roleInfo.openGiftId,giftId)
            elseif gift.subType == 3 then
            table.insert(roleInfo.openEventItemId,giftId)
            end
        end
    end

end

function RoleDataMgr:resetRoleInfo(roleInfo)
    roleInfo.age = roleInfo.age
    local constellation = clone(roleInfo.constellation)
    roleInfo.constellation = TextDataMgr:getText(constellation)
    roleInfo.threeDimensional = roleInfo.bwh
    -- local bd = clone(roleInfo.birthday)
    -- local birthday = string.split(bd, "-")
    -- roleInfo.birthday = birthday

    --服装
    roleInfo.dressIdList = roleInfo.dress
    roleInfo.modelList = {}
    for k,v in pairs(roleInfo.dressIdList) do
        local model = self:dressFindModel(v)
        table.insert(roleInfo.modelList,model)
    end

    roleInfo.favorLevel = 1
    roleInfo.mood = 60
    roleInfo.moodLevel = self:moodTomoodLevel(roleInfo.mood,roleInfo.id)
    roleInfo.cid = roleInfo.id

    self:roleInfoCopy(roleInfo)
end

function RoleDataMgr:resetRoleRoomInfoList()
    local roomTable = clone(TabDataMgr:getData("Room"))
    local decorationsTable = clone(TabDataMgr:getData("Decorations"))
    self.roomInfoList = {}
    for k,v in pairs(roomTable) do
        local roomInfo = {}
        local roomData = v
        table.merge(roomInfo,roomData);

        local decorationsList = roomData.decorationsList
        roomInfo.decorationsInfoList = {}
        for di,dv in ipairs(decorationsList) do
            local decorationsId = dv
            local decorationsData = decorationsTable[decorationsId]
            table.insert(roomInfo.decorationsInfoList,decorationsData)
        end
        roomInfo.isUnLock = false
        table.insert(self.roomInfoList,roomInfo)
    end

    self:sortRoleRoomList()
end

function RoleDataMgr:sortRoleRoomList()
    local function sortFunc(a,b)
        local aId = a.id
        local bId = b.id

        if aId <= bId then
            return true
        else
            return false
        end
    end

    table.sort(self.roomInfoList,sortFunc);
end

function RoleDataMgr:refreshRoleRoomInfoList()
    for i,v in ipairs(self.roomInfoList) do
        local roomInfo = v
        local id = roomInfo.id
        --房间也是物品，背包有物品表示已经解锁
        if GoodsDataMgr:getItemCount(id) ~= 0 then
            roomInfo.isUnLock = true
        else
            roomInfo.isUnLock = false
        end
    end
end

function RoleDataMgr:refreshRoleRoomInfo(roomId,isUnLock)
    for i,v in ipairs(self.roomInfoList) do
        local roomInfo = v
        local id = roomInfo.id
        if id == roomId then
            roomInfo.isUnLock = isUnLock
            return
        end
    end
end

function RoleDataMgr:getRoleRoomInfoByIdx(idx,roleId)
    roleId = roleId or self:getCurId()
    return self:getRoleRoomInfoList(roleId)[idx]
end

function RoleDataMgr:getRoleRoomInfoById(roomId,roleId)
    roleId = roleId or self:getCurId()
    for i,v in ipairs(self:getRoleRoomInfoList(roleId)) do
        local roomInfo = v
        if roomId == roomInfo.id then
            return roomInfo, i
        end
    end
    Box("not found 房间 ID:"..tostring(roomId))
end

function RoleDataMgr:getRoleRoomInfoId(idx,roleId)
    return self:getRoleRoomInfoByIdx(idx,roleId).id
end

function RoleDataMgr:getRoleRoomInfoList(roleId)
    roleId = roleId or self:getCurId()
    local roleRoomInfoList = {}
    for i,v in ipairs(self.roomInfoList) do
        local roomInfo = v
        if not roomInfo.belongToRole or roomInfo.belongToRole == 0 then
            table.insert(roleRoomInfoList,roomInfo)
        elseif roomInfo.belongToRole == roleId then
            table.insert(roleRoomInfoList,roomInfo)
        end
    end
    return roleRoomInfoList
end

function RoleDataMgr:selectRoleRoom(idx,roleId)
    roleId = roleId or self:getCurId()
    local roomId = self:getRoleRoomInfoByIdx(idx,roleId).id
end

--[[
    [1] = {--ChangeRoom
        [1] = 'int32':roleCid   [ 看板娘id]
        [2] = 'int32':roomCid   [ 房间cid]
    }
--]]
-- c2s.ROLE_CHANGE_ROOM = 1288


function RoleDataMgr:changeRoleRoom(idx,roleId)
    roleId = roleId or self:getCurId()
    local roomId = self:getRoleRoomInfoId(idx,roleId)
    local scriptMsg = {
        roleId,
        roomId
    }

    self.curRoomId = roomId
    TFDirector:send(c2s.ROLE_CHANGE_ROOM, scriptMsg)
end

function RoleDataMgr:onChangeRoom(event)
    local roleId = self:getCurId()
    if event.data then
        self:resetRoleUseRoom(self.curRoomId)
        self.roleTable[roleId].useRoomId = self.curRoomId
        EventMgr:dispatchEvent(EV_DATING_EVENT.changeRoleRoom)
    else
        Utils:showTips(205014)
    end
end


--[[
    [1] = {--UnlockRoom
        [1] = 'int32':roomCid   [ 房间cid]
    }
--]]
-- c2s.ROLE_UNLOCK_ROOM = 1289

function RoleDataMgr:unLockRoleRoom(roomId, roleId)
    local scriptMsg = {
        roomId
    }

    self.curRoomId = roomId

    TFDirector:send(c2s.ROLE_UNLOCK_ROOM, scriptMsg)
end

--[[
    [1] = {--UnlockRoom
        [1] = 'int32':roomCid   [ 房间cid]
    }
--]]
-- s2c.ROLE_UNLOCK_ROOM = 1289

function RoleDataMgr:onUnLockRoom(event)
    if event.data then
        self:refreshRoleRoomInfo(self.curRoomId,true)
        EventMgr:dispatchEvent(EV_DATING_EVENT.unLockRoleRoom)
    else
        Utils:showTips(205015)
    end
end

function RoleDataMgr:getRoleUseRoomId(roleId)
    roleId = roleId or self:getCurId()
    return self.roleTable[roleId].useRoomId or self:getRoleRoomInfoByIdx(1,roleId).id
end

function RoleDataMgr:getRoleUseRoomIdx(roleId)
    roleId = roleId or self:getCurId()
    local roomData,idx = self:getRoleRoomInfoById(self.roleTable[roleId].useRoomId,roleId)
    return idx
end

function RoleDataMgr:getRoomByRoleUse(roomId)
    for i,v in ipairs(self.showList) do
        local useRoomId = self.roleTable[v].useRoomId
        if useRoomId == roomId then
            return v
        end
    end
end

function RoleDataMgr:resetRoleUseRoom(roomId)
    for i,v in ipairs(self.showList) do
        local useRoomId = self.roleTable[v].useRoomId
        if useRoomId == roomId then
            self.roleTable[v].useRoomId = 710001 --恢復默認房間
        end
    end
end

function RoleDataMgr:getUnlockCost(roomId,roleId)
    local roomData = self:getRoleRoomInfoById(roomId,roleId)
    local unlockCost = self:resetUnlockCost(roomData.unlockCost)
    return unlockCost
end

function RoleDataMgr:resetUnlockCost(unlockCost)
    local coUnlockCost = {}
    for k,v in pairs(unlockCost) do
        local unlockCost = {}
        unlockCost.id = k
        unlockCost.cost = v
        table.insert(coUnlockCost,unlockCost)
    end
    self:sortUnlockCost(coUnlockCost)
    return coUnlockCost
end

function RoleDataMgr:sortUnlockCost(coUnlockCost)
    local function sortFunc(a,b)
        return a.id < b.id
    end

    table.sort(coUnlockCost,sortFunc);
end

function RoleDataMgr:getRoleIdBySid(sid)
    for k,v in pairs(self.roleTable) do
        if sid == v.sid then
            return k
        end
    end
end

function RoleDataMgr:getRoleRoomList(roleId)
    return self.roleTable[roleId].roomList
end

--小精灵状态

function RoleDataMgr:setElvesState(roleId,elvesStateList)
    self.roleTable[roleId].elvesStateList = elvesStateList or {}

    self:sortElvesStateList(roleId)
end

function RoleDataMgr:addElvesState(roleId,elvesState)
    if not self.roleTable or not self.roleTable[roleId] then
        return
    end

    self.roleTable[roleId].elvesStateList = self.roleTable[roleId].elvesStateList or {}
    if self:findElvesState(roleId,elvesState) then
        return
    end
    table.insert(self.roleTable[roleId].elvesStateList,elvesState)

    self:sortElvesStateList(roleId)
end

function RoleDataMgr:findElvesState(roleId,elvesState)
    local isFindOk = false
    if not self.roleTable[roleId] then
        return isFindOk
    end
    self.roleTable[roleId].elvesStateList = self.roleTable[roleId].elvesStateList or {}
    for i, v in ipairs(self.roleTable[roleId].elvesStateList) do
        if v == elvesState then
            isFindOk = true
            break
        end
    end
    return isFindOk
end

function RoleDataMgr:removeElvesState(roleId,elvesState)
    if self:findElvesState(roleId,elvesState) then
        table.removeItem(self.roleTable[roleId].elvesStateList,elvesState)

        self:sortElvesStateList(roleId)
    end
end

function RoleDataMgr:sortElvesStateList(roleId)

    for i = #self.roleTable[roleId].elvesStateList, 1, -1 do
        if self.roleTable[roleId].elvesStateList[i] == 0 then
            table.remove(self.roleTable[roleId].elvesStateList,i)
        end
    end

    local function sortFunc(a,b)
        return a < b
    end

    table.sort(self.roleTable[roleId].elvesStateList,sortFunc);

    EventMgr:dispatchEvent(EV_ELVES_EVENT.state, roleId)
    EventMgr:dispatchEvent(EV_DATING_EVENT.refreshRedTips)
end

function RoleDataMgr:getElvesStateList(roleId)
    return self.roleTable[roleId].elvesStateList
end

function RoleDataMgr:checkMainRewardState(roleId)
    local mainLiveList = self:getMainList(roleId)
    local curFavor = self:getFavor(roleId)
    for i, v in ipairs(mainLiveList) do
        local rewardList = self:getDatingRewardListToFavorLevel(roleId,i)
        for kd,vd in pairs(rewardList) do
            if self:getDatingRewardState(roleId,vd.id) ~= EC_TaskStatus.GETED and curFavor >= vd.branchCondition then
                print("self:getDatingRewardState(roleId,vd.id) ",self:getDatingRewardState(roleId,vd.id))
                print("vd.id ",vd.id)
                print("roleId ",roleId)
                return true
            end
        end
        local mainItemInfo = v
        if mainItemInfo then
            local taskId = mainItemInfo.taskId
            if taskId then
                local taskInfo = TaskDataMgr:getTaskInfo(taskId)
                if taskInfo and taskInfo.status == EC_TaskStatus.GET then
                    return true
                end
            end
        end
    end
    return false
end

function RoleDataMgr:checkDayRewardState(roleId)
    --暂时屏蔽信物约会红点提示
    if true then
        return false 
    end
    local buildDataList = self:getDayBuildList(roleId)
    for i, v in ipairs(buildDataList) do
        local data = DatingDataMgr:getBuildDayScripInfo(v.buildId,roleId)
        if data then
            local taskId = data.taskId
            if taskId then
                local taskInfo = TaskDataMgr:getTaskInfo(taskId)

                if not taskInfo then
                    return false;
                end

                if taskInfo.status == EC_TaskStatus.GET then
                    return true
                end
            end
        end
    end
    return false
end

function RoleDataMgr:getElvesShowState(roleId)
    local list = self.roleTable[roleId].elvesStateList

    for k,v in pairs(list) do -- 出游约会状态最优先显示
        if v == EC_ElvesState.datingOut then
            return EC_ElvesState.datingOut
        end
    end
    
    for k,v in pairs(list) do -- 出游约会状态最优先显示
        if v == EC_ElvesState.datingReserveRequest then
            return EC_ElvesState.datingReserveRequest
        end
    end
    
    for k,v in pairs(list) do -- 出游约会状态最优先显示
        if v == EC_ElvesState.datingReserve then
            return EC_ElvesState.datingReserve
        end
    end

    if self:checkDayRewardState(roleId) then
        return EC_ElvesState.reward
    end
--    if self:checkMainRewardState(roleId) then
--        return EC_ElvesState.reward
--    end
    if self:checkNewMainRewardState(roleId) then
        return EC_ElvesState.reward
    end

    if not self.roleTable[roleId].elvesStateList or table.count(self.roleTable[roleId].elvesStateList) == 0 then
        return
    end
    print("self.roleTable[roleId].elvesStateList ",self.roleTable[roleId].elvesStateList)

    return self.roleTable[roleId].elvesStateList[1]
end

function RoleDataMgr:isElvesStateTip()
    local isTip = false
    for i, v in pairs(self.roleTable) do
        if v.ishave and  self:getElvesShowState(v.cid) and self:getElvesShowState(v.cid) ~= 0 then
            isTip = true
            break
        end
    end
    return isTip
end

function RoleDataMgr:getVoiceHandle()
    return self.voiceHandle
end

function RoleDataMgr:setVoiceHandle(voiceHandle)
    self.voiceHandle = voiceHandle
end

function RoleDataMgr:enterDatingToElvesState(roleId,roomId,roleshape,closeCallBack)

    ----城建约会精灵状态
    --EC_ElvesState = {
    --    datingMain = 1, -- 主线约会
    --    datingReserveRequest = 2, -- 预定约会邀请
    --    datingReserve = 3, -- 预定约会
    --    datingOut = 4, -- 出游约会
    --    datingDayNoFinish = 5, -- 日常约会（未完成)
    --    hunger = 6, -- 饥饿
    --    angry = 7, -- 生气
    --    bored = 8, -- 无聊
    --}
    local stateVoice = {
        [EC_ElvesState.datingMain] = "mood_normal",
        [EC_ElvesState.hunger] = "hungry",
        [EC_ElvesState.angry] = "angry",
        [EC_ElvesState.bored] = "boring",
    }
    self:setCurId(roleId)
    local elvesState = self:getElvesShowState(roleId)

    if self.voiceHandle then
        TFAudio.stopEffect(self.voiceHandle)
        self.voiceHandle = nil
    end

    if state and state > 0 and stateVoice[elvesState] then
        self.voiceHandle = VoiceDataMgr:playVoice(stateVoice[elvesState], roleId)
    else
        self.voiceHandle = VoiceDataMgr:playVoice("mood_normal", roleId)
    end
    if elvesState == EC_ElvesState.datingOut or elvesState == EC_ElvesState.datingReserve
            or elvesState == EC_ElvesState.datingReserveRequest then
        self:sendGetDatingScript(elvesState,roomId)
    else
        EventMgr:dispatchEvent(EV_ELVES_EVENT.showUI)
        local layer = require("lua.logic.dating.DatingGiveGiftView"):new(roleshape,closeCallBack)
        AlertManager:addLayer(layer, AlertManager.BLOCK_CLOSE)
        AlertManager:show()
    end

    self:sendUpdateMainActivation()
end

function RoleDataMgr:sendGetDatingScript(elvesState,roomId)
    local cityDatingInfo = DatingDataMgr:getCityDatingInfoByCityId(roomId,self.curId)
    if not cityDatingInfo then
        Box("cityDatingInfo is nil 房间id ".. roomId)
        return
    end
    -- EC_CityDatingState = {
    --     noDating = 0,--无约会（邀请已过）
    --     noAccept = 1,--有邀请未接受
    --     accept = 2, --接受邀请
    --     normal = 3, --正常约会
    --     overtime = 4 --约会超时（预约的时间已过）
    -- }

    print("sssscityDatingInfo ",cityDatingInfo)

    if elvesState == EC_ElvesState.datingReserveRequest then
        DatingDataMgr:showReserveAcceptLayer(cityDatingInfo.datingRuleCid)
    elseif elvesState == EC_ElvesState.datingReserve then
        DatingDataMgr:sendGetSciptMsg(cityDatingInfo.datingType,nil,nil,nil,roomId,cityDatingInfo.cityDatingId)
    elseif elvesState == EC_ElvesState.datingOut then
        DatingDataMgr:sendGetSciptMsg(cityDatingInfo.datingType,nil,nil,nil,roomId,cityDatingInfo.cityDatingId)
    end
end

--手札
--主线，分支奖励

function RoleDataMgr:sendGetMainMsg(roleId)
    --[[
        [1] = {--ReqFavorDatingPanel
            [1] = 'int32':roleId	[精灵ID]
        }
    --]]
    --c2s.EXTRA_DATING_REQ_FAVOR_DATING_PANEL = 5650

    TFDirector:send(c2s.EXTRA_DATING_REQ_FAVOR_DATING_PANEL, {roleId})
end

function RoleDataMgr:sendGetMainReward(rewardId)
    --[[
        [1] = {--ReqFavorReward
            [1] = 'int32':favorDatingId	[Favor表对应id]
        }
    --]]
    --c2s.EXTRA_DATING_REQ_FAVOR_REWARD = 5651

    TFDirector:send(c2s.EXTRA_DATING_REQ_FAVOR_REWARD, {rewardId})
end

function RoleDataMgr:onMainReward(event)
    --[[
	[1] = {--ResFavorReward
		[1] = 'int32':favorDatingId	[Favor表对应id]
		[2] = 'int32':statue	[ 1领取成功]
	}
--]]
--    s2c.EXTRA_DATING_RES_FAVOR_REWARD = 5651

    if event.data then
        print("主线分支领取返回信息")
        dump(event.data)
        local rewardId = event.data.favorDatingId
        if event.data.statue == 1 then
            local mainDatingMap_ = TabDataMgr:getData("Favor")
            self:setDatingRewardState(self:getCurId(),rewardId,EC_TaskStatus.GETED)
            EventMgr:dispatchEvent(EV_DATING_EVENT.getMainReward,mainDatingMap_[rewardId].branchReward)
        end
    end
end

function RoleDataMgr:onRoleMainHandleList(event)
    --[[
	[1] = {--FavorDatingAward
		[1] = {--repeated ResFavorDatingPanel
			[1] = 'int32':roleId	[精灵Id]
			[2] = {--repeated FavorStatueInfo
				[1] = 'int32':favorId	[对应FavorDating表Id]
				[2] = 'int32':statue	[0未激活,1激活 2已领(奖励状态)    //0未激活,1激活 2已领(奖励状态)]
				[3] = 'int32':firstPass	[0还未通关过 1已经通关过]
				[4] = 'int32':energy	[消耗精力]
			},
		},
	}
--]]
--    s2c.EXTRA_DATING_FAVOR_DATING_AWARD = 5663

    if event.data then
        -- print("onRoleMainHandleList event.data ",event.data)
        for i, v in ipairs(event.data.favorList) do
            local uEvent = {}
            uEvent.data = v
            self:onRoleMainHandle(uEvent,true)
        end
    end
end

function RoleDataMgr:onRoleMainHandle(event,isLogin)
    --[[
        [1] = {--ResFavorDatingPanel
            [1] = 'int32':roleId	[精灵Id]
            [2] = {--repeated FavorStatueInfo
                [1] = 'int32':favorId	[对应FavorDating表Id]
                [2] = 'int32':statue	[0未激活,1激活 2已领(奖励状态)    //0未激活,1激活 2已领(奖励状态)]
                [3] = 'int32':firstPass	[0还未通关过 1已经通关过]
                [4] = 'int32':energy	[消耗精力]
            },
        }
    --]]
    if event.data then
        -- print("主线列表信息")
        -- dump(event.data)
        local roleId = event.data.roleId
        local favorStatueInfo = event.data.info
        for i, v in ipairs(self:getMainList(roleId)) do
            for is, vs in ipairs(favorStatueInfo) do
                if v.id == vs.favorId then
                    v.state = vs.statue
                    v.firstPass = vs.firstPass
                    v.energy = vs.energy
                    break
                end
            end
        end

        for i, v in ipairs(self:getDatingRewardList(roleId)) do
            for is, vs in ipairs(favorStatueInfo) do
                if v.id == vs.favorId then
                    v.state = vs.statue
                    v.energy = vs.energy
                    break
                end
            end
        end

        if not isLogin then
            EventMgr:dispatchEvent(EV_DATING_EVENT.getMainList)
        end
    end
end

function RoleDataMgr:resetMainDatingList(roleId)
    local mainDatingMap_ = TabDataMgr:getData("Favor")
    for k, v in pairs(mainDatingMap_) do
        if v.role == roleId then
            if v.type == 1 then
                self.roleTable[roleId].mainList = self.roleTable[roleId].mainList or {}
                table.insert(self.roleTable[roleId].mainList,v)
            elseif v.type == 2 then
                self.roleTable[roleId].rewardList = self.roleTable[roleId].rewardList or {}
                table.insert(self.roleTable[roleId].rewardList,v)
            end
        end
    end
end

function RoleDataMgr:getMainList(roleId)
    local mainList = self.roleTable[roleId].mainList or {}
    self:sortMainList(mainList)
    return mainList
end

function RoleDataMgr:sortMainList(mainList)
    local function sortFunc(a,b)
        return a.id < b.id
    end

    table.sort(mainList,sortFunc);
end

function RoleDataMgr:getMainState(roleId,mainId)
    local main = self:findMain(roleId,mainId)
    if main and main.state then
        return main.state
    else
        return EC_DatingScriptState.TRIGGER
    end
end

function RoleDataMgr:getMainEnergy(roleId,mainId)
    local main = self:findMain(roleId,mainId)
    if main then
        return main.energy or 0
    end
    return 0
end

function RoleDataMgr:getMainFirstPass(roleId,mainId)
    local firstPass = true
    local main = self:findMain(roleId,mainId)
    if main then
        firstPass = (main.firstPass ~= 0) and true or false
    end
    return firstPass
end

function RoleDataMgr:getMainInfo(roleId,mainId)
    local main = self:findMain(roleId,mainId)
    return main
end

function RoleDataMgr:getMainTableName(roleId,mainId)
    local main = self:getMainInfo(roleId,mainId)
    return main.callTableNameF
end

function RoleDataMgr:findMain(roleId,mainId)
    local main = nil
    for i, v in ipairs(self.roleTable[roleId].mainList) do
        if v.id == mainId then
            main = v
            break
        end
    end
    return main
end

function RoleDataMgr:getDatingRewardList(roleId)
    local rewardList = self.roleTable[roleId].rewardList or {}
    return rewardList
end

function RoleDataMgr:getDatingRewardListToFavorLevel(roleId, favorLevel)
    local rewardList = self:getDatingRewardList(roleId)
    local list = {}
    local levelMaxFavor = self:getLvMaxFavor(roleId,favorLevel)
    local lastMaxFavor = 0
    if favorLevel > 1 then
        lastMaxFavor = self:getLvMaxFavor(roleId,favorLevel-1)
    end
    for i, v in ipairs(rewardList) do
        if v.branchCondition >= lastMaxFavor and v.branchCondition < levelMaxFavor then
            table.insert(list, v)
        end
    end

    return list
end

function RoleDataMgr:getDatingRewardState(roleId,rewardId)
    local reward = self:findDatingReward(roleId,rewardId)
    if reward and reward.state then
        return reward.state
    else
        return EC_TaskStatus.ING
    end
end

function RoleDataMgr:findDatingReward(roleId,rewardId)
    local reward = nil
    for i, v in ipairs(self.roleTable[roleId].rewardList) do
        if v.id == rewardId then
            reward = v
            break
        end
    end
    return reward
end

function RoleDataMgr:getDatingRewardInfo(roleId,rewardId)
    local reward = self:findDatingReward(roleId,rewardId)
    return reward.branchReward
end

function RoleDataMgr:setDatingRewardState(roleId,rewardId,state)
    local reward = self:findDatingReward(roleId,rewardId,state)
    if reward then
        reward.state = state
    end
end

--送礼道具加成（根据精灵状态）
function RoleDataMgr:getGoodEffectValue(goodId,elvesState)
    if not elvesState then
        return 0
    end
    local data = TabDataMgr:getData("CityState")
    local effectInfo = data[elvesState].effect
    if effectInfo and  type(effectInfo)=="table" and effectInfo[goodId] then
        return effectInfo[goodId]
    else
        return 0
    end
end

--主线约会属性
function RoleDataMgr:getDatingVariableToRole(roleId)
    return self:getRoleInfo(roleId).datingVariable
end

--送礼喜欢物品标签ID列表
function RoleDataMgr:addLikeGood(goodId,roleId)
    if not goodId then
        return
    end
    roleId = roleId or self:getCurId()
    self.roleTable[roleId].likeGoodList = self.roleTable[roleId].likeGoodList or {}
    if table.find(self.roleTable[roleId].likeGoodList,goodId) == -1 then
        table.insert(self.roleTable[roleId].likeGoodList,goodId)
    else
        return
    end
end

function RoleDataMgr:getLikeGood(roleId)
    roleId = roleId or self:getCurId()

    return self.roleTable[roleId].likeGoodList or {}
end

function RoleDataMgr:onMainUpdateActivationStateHandel(event)
    --[[
	[1] = {--ResTiggerRoleNotice
		[1] = 'int32':favorDatingId	[Favor表对应id]
		[2] = 'int32':statue	[0表示章节状态取消显示 1显示]
	}
--]]
--    s2c.EXTRA_DATING_RES_TIGGER_ROLE_NOTICE = 5652

    if event.data then
        local favorDatingId = event.data.favorDatingId
        local mainData = TabDataMgr:getData("Favor")[favorDatingId]
        if not mainData then
            return
        end
        local statue = event.data.statue
        if not mainData then
            return
        end
        if statue == 1 then
            self:addElvesState(mainData.role,EC_ElvesState.datingMain)
        else
            self:removeElvesState(mainData.role,EC_ElvesState.datingMain)
        end
    end
end

function RoleDataMgr:onMainUpdateActivationStateSHandel(event)
    --[[
    [1] = {--ResFavorDatingNotices
        [1] = {--repeated ResTiggerRoleNotice
            [1] = 'int32':favorDatingId	[Favor表对应id]
            [2] = 'int32':statue	[0表示章节状态取消显示 1显示]
        },
    }
    --]]
    --s2c.EXTRA_DATING_RES_FAVOR_DATING_NOTICES = 5653

    if event.data then
        local data = event.data.favorRoleStatue or {}
        print("主线激活集合列表 data ",data)
        for i, v in ipairs(data) do
            local favorDatingId = v.favorDatingId
            local mainData = TabDataMgr:getData("Favor")[favorDatingId]
            local statue = v.statue
            if statue == 1 and mainData then
                self:addElvesState(mainData.role,EC_ElvesState.datingMain)
            end
        end
    end
end

function RoleDataMgr:sendUpdateMainActivation(roleId)
        --[[
        [1] = {--ReqFreshRoleNotice
            [1] = 'int32':roleId	[精灵id]
        }
        --]]
        --    c2s.EXTRA_DATING_REQ_FRESH_ROLE_NOTICE = 5661
    roleId = roleId or self:getCurId()

    local state = self:getElvesShowState(roleId)
    if state == EC_ElvesState.datingMain then
        print("sendUpdateMainActivation " .. roleId)
        TFDirector:send(c2s.EXTRA_DATING_REQ_FRESH_ROLE_NOTICE, {roleId})
    end
end

function RoleDataMgr:useDressFindData()
    local useRoleInfo = self:getUseRoleInfo()
    if not useRoleInfo then return end
    local dressTable = TabDataMgr:getData("Dress")
    local data = dressTable[useRoleInfo.dressId]

    return data
end

function RoleDataMgr:resetNewMainDatingList(roleId)
    local mainDatingMap_ = TabDataMgr:getData("FavorNew")
    for k, v in pairs(mainDatingMap_) do
        if v.role == roleId then
            if v.type == 1 then
                self.roleTable[roleId].newMainList = self.roleTable[roleId].newMainList or {}
                table.insert(self.roleTable[roleId].newMainList,v)
            elseif v.type == 2 then
                self.roleTable[roleId].newRewardList = self.roleTable[roleId].newRewardList or {}
                table.insert(self.roleTable[roleId].newRewardList,v)
            end
        end
    end
end

function RoleDataMgr:getNewMainList(roleId)
    local newMainList = self.roleTable[roleId].newMainList or {}
    self:sortMainList(newMainList)
    return newMainList
end

function RoleDataMgr:getNewDayDatingState(roleId)
    return self:getCommonDatingState(EC_DatingScriptType.FAVOR_SCRIPT,roleId)
end

--好感度约会已经领取过的奖励id
function RoleDataMgr:getFavorRewardListByRoleId( roleId )
    roleId = roleId or self:getCurId()
    local favorScriptReward = DatingDataMgr:getFavorRewardList()
    local idList = {}
    for _,_info in ipairs(favorScriptReward) do  
        if _info.roleId == roleId and _info.awardId then
            return _info.awardId
        end
    end  
    return idList
end

function RoleDataMgr:getNewDatingRewardList(roleId)
    local newRewardList = self.roleTable[roleId].newRewardList or {}
    return newRewardList
end

function RoleDataMgr:getNewDatingRewardListToFavorLevel(roleId, favorLevel)
    local newRewardList = self:getNewDatingRewardList(roleId)
    local list = {}
    local levelMaxFavor = self:getLvMaxFavor(roleId,favorLevel)
    local lastMaxFavor = 0
    if favorLevel > 1 then
        lastMaxFavor = self:getLvMaxFavor(roleId,favorLevel-1)
    end
    for i, v in ipairs(newRewardList) do
        if v.branchCondition >= lastMaxFavor and v.branchCondition < levelMaxFavor then
            table.insert(list, v)
        end
    end

    return list
end

--好感度约会红点
function RoleDataMgr:checkNewMainRewardState( roleId )
    local getedRewardList = self:getFavorRewardListByRoleId(roleId)
    local rewardIdList = {}
    for _,_id in ipairs(getedRewardList) do      
        rewardIdList[_id] = _id
    end 
    local newRewardList = self:getNewDatingRewardList(roleId)
    local curFavor = self:getFavor(roleId)
    for i, v in ipairs(newRewardList) do
        local itemFavor = v.branchCondition
        if curFavor >= itemFavor and rewardIdList[v.id] == nil then
            return true
        end     
    end
    return false
end

--获取好感度约会单个奖励状态
function RoleDataMgr:getFavorDatingRewardState( roleId, rewardId )
    local getedRewardList = self:getFavorRewardListByRoleId(roleId)
    local rewardIdList = {}
    for _,_id in ipairs(getedRewardList) do      
        rewardIdList[_id] = _id
    end 

    local newRewardList = self:getNewDatingRewardList(roleId)
    local curFavor = self:getFavor(roleId)
    for i, v in ipairs(newRewardList) do
        if v.id == rewardId then
            if curFavor >= v.branchCondition and rewardIdList[v.id] == nil then
                return EC_FavorDatingRewardStatus.STATUS_GET
            end               
            if curFavor >= v.branchCondition and rewardIdList[v.id] then
                return EC_FavorDatingRewardStatus.STATUS_GETED
            end   
            return EC_FavorDatingRewardStatus.STATUS_LOCK      
        end
    end
    return EC_FavorDatingRewardStatus.STATUS_LOCK     
end

function RoleDataMgr:getRoleTable( )
    -- body
    return self.roleTable
end

return RoleDataMgr:new()
