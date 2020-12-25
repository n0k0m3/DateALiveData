
local BaseDataMgr = import(".BaseDataMgr")
local DatingDataMgr = class("DatingDataMgr", BaseDataMgr)
local DatingConfig = require("lua.logic.dating.DatingConfig")


function DatingDataMgr:ctor()
    --�Ѿ�ͨ���ľ���
    self.finishScriptIds = {}
    self.favorScriptReward = {}
    --�Ѿ�ͨ�����ճ����
    self.dayScriptEndIds = {}
    self.dayScriptEndInfos = {}
    self.dayScriptBadEndInfos = {}
    self.datingSettlementMsg = {}
    self.datingType = EC_DatingScriptType.MAIN_SCRIPT
    self.curDatingScript = {}
    self.reviewTable = {}
    self.notFinishDatingInfoList = {}
    self.cityDatingInfoList = {}
    self.triggerDatingInfoList = {}
    self.finishDayScriptEndId = 0
    self.defaultScore = 60
    self.isDating = false

    self.datingRuleTable = clone(TabDataMgr:getData("DatingRule"))
    self.scriptTableName = nil
    -- --�ճ�Լ��������
    -- EC_DayDatingEndType = {
    --     HAPPYEND = 1,
    --     TUREEND = 2,
    --     NORMALEND = 3,
    --     BADEND = 4,
    --     HIDDENEND = 5
    -- }

    self.endTypeConfig_ = {
            [1] = {
                iconPath = "ui/dating/dayDating/5.png",
                starPath = "ui/316.png",
                typeBottomPath = "ui/324.png",
                headPath = "2.png",
                endName = 901234,
                endIcon = "ui/newCity/dating_result/026.png",
                endVoiceType = "good_end",
                endActionName = "happyend"
            },
            [2] = {
                iconPath = "ui/dating/dayDating/3.png",
                starPath = "ui/317.png",
                typeBottomPath = "ui/325.png",
                headPath = "3.png",
                endName = 901235,
                endIcon = "ui/newCity/dating_result/025.png",
                endVoiceType = "good_end",
                endActionName = "trueend"
            },
            [3] = {
                iconPath = "ui/dating/dayDating/2.png",
                starPath = "ui/318.png",
                typeBottomPath = "ui/326.png",
                headPath = "4.png",
                endName = 901236,
                endIcon = "ui/newCity/dating_result/029.png",
                endVoiceType = "bad_end",
                endActionName = "normalend"
            },
            [4] = {
                iconPath = "ui/dating/dayDating/1.png",
                starPath = "ui/319.png",
                typeBottomPath = "ui/327.png",
                headPath = "5.png",
                endName = 901237,
                endIcon = "ui/newCity/dating_result/028.png",
                endVoiceType = "bad_end",
                endActionName = "badend"
            },
            [5] = {
                iconPath = "ui/dating/dayDating/4.png",
                starPath = "ui/315.png",
                typeBottomPath = "ui/323.png",
                headPath = "1.png",
                endName = 901238,
                endIcon = "ui/newCity/dating_result/027.png",
                endVoiceType = "hidden_end",
                endActionName = "hiddenend"
            },
        }

    self:init()
end

function DatingDataMgr:init()
    self:initRoleSetData()
    self:initDayScriptEnds()
end

function DatingDataMgr:onLogin()
    self:resetLogin()

    TFDirector:addProto(s2c.DATING_GET_DATING_INFO, self, self.onGetDatingListInfoHandle)
    TFDirector:addProto(s2c.DATING_UPDATE_TRIGGER_DATING, self, self.updateTriggerDatingHandle)
    TFDirector:addProto(s2c.DATING_CITY_DATING_INFO, self, self.updateCityDatingInfoHandle)
    TFDirector:addProto(s2c.DATING_CITY_DATING_INFO_LIST, self, self.updateCityDatingInfoListHandle)
    TFDirector:addProto(s2c.DATING_ACCEPT_DATING_INVITATION, self, self.acceptDatingInvitationHandle)
    TFDirector:addProto(s2c.DATING_DATING_FAIL, self, self.datingFailHandle)
    TFDirector:addProto(s2c.DATING_DATING_SCRIPT, self, self.datingScriptMsgHandle)
    TFDirector:addProto(s2c.DATING_DIALOGUE, self, self.dialogueMsgHandle)
    TFDirector:addProto(s2c.DATING_DATING_SETTLEMENT, self, self.datingSettlementMsgHandle)
    TFDirector:addProto(s2c.DATING_CONTINUE_DATING, self, self.continueDatingHandle)
    TFDirector:addProto(s2c.DATING_RES_RECEIVE_NEW_FAVOR_AWARD, self, self.onResReceiveNewFavorAward)  

    TFDirector:send(c2s.DATING_GET_DATING_INFO, {})

    EventMgr:addEventListener(self, EV_CATCHDOLL_END, handler(self.showDatingLayer, self))
    return {s2c.DATING_GET_DATING_INFO}
end

function DatingDataMgr:resetLogin()
    self.isPhoneDatingNew = nil
    self.phoneRuleId = nil
    self.datingTimeFrame = nil
end

function DatingDataMgr:onEnterMain()

end

function DatingDataMgr:addScriptId(scriptId)
    table.insert(self.finishScriptIds,scriptId)
end

function DatingDataMgr:getFinishScriptList()
    return self.finishScriptIds
end

function DatingDataMgr:checkScriptIdIsFinish(ruleCid)
    if self.isDating then return end
    local isSingleDating = self:checkIsSingleDating(ruleCid)
    if isSingleDating then
        if Utils:getLocalSettingValue("singleDating"..ruleCid) == "true" then -- 纯客户端单机约会添加本地验证
            return true
        else
            return false
        end
    end

    if table.find(self.finishScriptIds,ruleCid) == -1 then
        return false
    else
        return true
    end
end

--[[
    [1] = {--GetDatingInfo
        [1] = {--repeated NotFinishDating
            [1] = 'int32':score [����]
            [2] = 'int32':datingType    [Լ������]
            [3] = 'int32':currentNodeId [��ǰ���е��Ľڵ�]
            [4] = {--BranchNodes
                [1] = {--repeated BranchNode
                    [1] = 'int32':datingId  [Լ������id]
                    [2] = 'repeated int32':nextNodeIds  [�¼��ڵ�id]
                },
            },
            [5] = 'int32':selectedNode  [��ѡ��ڵ�]
            [6] = 'repeated int32':roleCid  [������id]
            [7] = 'int32':datingRuleCid [Լ��id]
        },
        [2] = 'repeated int32':datingRuleCid    [�Ѿ�ͨ���ľ籾id]
        [3] = 'repeated int32':endings  [�籾�����ڵ�]
        [4] = {--repeated CityDatingInfo
            [1] = {--ChangeType(enum)
                'v4':ChangeType
            },
            [2] = 'string':cityDatingId [����Լ��id]
            [3] = 'repeated int32':datingTimeFrame  [Լ��ʱ��]
            [4] = 'int32':datingRuleCid [Լ��cid]
            [5] = 'int32':date  [Լ������]
            [6] = 'int32':state [Ԥ��Լ��״̬ 0:��Լ�� 1:������,δ���� 2:�ѽ������� 3:����Լ��ʱ�� 4:Լ��ʱ���ѹ�]
        },
        [5] = {--repeated UpdateTriggerDating
            [1] = 'int32':roleId
            [2] = 'repeated int32':datingRuleCid
        },
    }
--]]
-- s2c.DATING_GET_DATING_INFO = 1539

function DatingDataMgr:onGetDatingListInfoHandle(event)
    if event.data then
        local uFD = {}
        -- print("login dating data")
        -- dump(event.data)
        self.finishScriptIds = event.data.datingRuleCid or {}
        self.favorScriptReward = event.data.favorAward or {}

        self.dayScriptEndIds = event.data.endings or {}
        self:resetDayScriptEnds()

        self.notFinishDatingInfoList = event.data.notFinishDating or {}
        self:resetNotFinishDatingInfoList()

        self.cityDatingInfoList = event.data.cityDatingInfoList or {}
        self:resetCityDatingInfoList()

        self.triggerDatingInfoList = event.data.triggerDating or {}
        self:resetTriggerDatingInfoList()
        EventMgr:dispatchEvent(EV_DATING_EVENT.onLogin)
    end
end

function DatingDataMgr:setCurDatingMsg(datingRuleCid)

    self:setCurMsg()
end

function DatingDataMgr:resetNotFinishDatingInfoList()
    -- print("self.notFinishDatingInfoList ",self.notFinishDatingInfoList)
    for i,v in ipairs(self.notFinishDatingInfoList) do
        local roleCidList = v.roleCid
        if type(roleCidList) == "table" then
            if #roleCidList == 1 then
                if v.datingType == EC_DatingScriptType.DAY_SCRIPT then
                    self:addElvesStateToDatingType(roleCidList[1],v.datingType,EC_DatingScriptState.NO_FINISH)
                end
            end
            v.roleCidList = roleCidList
            if self.datingRuleTable[v.datingRuleCid] then
                v.roleCid = self.datingRuleTable[v.datingRuleCid].roleId
            end
        end
    end
end

local function changeUState(cityDatingInfo)
    cityDatingInfo.uState = cityDatingInfo.state -- ����Լ��״̬
    cityDatingInfo.state = EC_DatingScriptState.LOCK --Լ��ͨ��״̬
end

-- --Լ��״̬
-- EC_DatingScriptState = {
--     LOCK      = -1,--δ����
--     NORMAL    = 0,
--     TRIGGER   = 1, --����Լ��
--     NO_FINISH = 2, -- δ���
--     FAIL      = 3 --Լ��ʧ�ܣ�ԤԼ��Լ����ڣ�
-- }

-- --Լ������
-- EC_DatingScriptType = {
--     MAIN_SCRIPT = 1, -- ���߾籾
--     DAY_SCRIPT = 2, -- �ճ��籾
--     RESERVE_SCRIPT = 3, -- ԤԼԼ��籾
--     TRIGGER_SCRIPT = 4, -- ����Լ��籾(�¼�Լ��)
--     WORK_SCRIPT = 5,  --��Լ��籾
--     OUT_SCRIPT = 6, --����Լ��籾
--     OUTSIDE_SCRIPT = 7, -- �⴫Լ��籾
-- }

-- --����Լ��״̬(ԭ����Լ��)����Լ��������򹤣����Σ�����
-- EC_CityDatingState = {
--     noDating = 0,--��Լ�ᣨ�����ѹ���
--     noAccept = 1,--������δ����
--     accept = 2, --��������
--     normal = 3, --����Լ��
--     overtime = 4 --Լ�ᳬʱ��ԤԼ��ʱ���ѹ���
-- }

function DatingDataMgr:resetTriggerDatingInfoList()
    for i,v in ipairs(self.triggerDatingInfoList) do
        local roleTriggerInfo = v

        self:resetRoleTriggerInfo(roleTriggerInfo)
    end
end

function DatingDataMgr:updateRoleTriggerInfo(roleTriggerInfo)
    local idx = nil
    local uRoleTriggerInfo = nil
    local uDatingRuleCid = roleTriggerInfo.datingRuleCid[1]
    for i,v in ipairs(self.triggerDatingInfoList) do
        if roleTriggerInfo.roleId == v. roleId then
            idx = i
            uRoleTriggerInfo = v
        end
    end

    self:resetRoleTriggerInfo(roleTriggerInfo,uRoleTriggerInfo)
    if idx and self.triggerDatingInfoList[idx] then
        self.triggerDatingInfoList[idx] = roleTriggerInfo
    else
        table.insert(self.triggerDatingInfoList,roleTriggerInfo)
    end

    local tDatingInfo = nil
    for i, v in ipairs(roleTriggerInfo.tdInfoList) do
        if uDatingRuleCid == v.datingRuleCid then
            tDatingInfo = v
            break
        end
    end

    if tDatingInfo then
        self:showDatingLayer(EC_DatingScriptType.SHOW_SCRIPT,tDatingInfo.currentNodeId,false,tDatingInfo.datingRuleCid,nil,true)
    end

end

function DatingDataMgr:resetRoleTriggerInfo(roleTriggerInfo,uRoleTriggerInfo)
    local datingRuleCidList = roleTriggerInfo.datingRuleCid or {}

    if uRoleTriggerInfo then
        roleTriggerInfo.tdInfoList = uRoleTriggerInfo.tdInfoList
    else
        roleTriggerInfo.tdInfoList = {}
    end

    for iu,vu in ipairs(datingRuleCidList) do
        local triggerDatingInfo = {}
        triggerDatingInfo.datingRuleCid = vu
        triggerDatingInfo.currentNodeId = self.datingRuleTable[vu].start_node_id
        self:checkTriggerDatingInfoState(triggerDatingInfo)
        table.insert(roleTriggerInfo.tdInfoList,triggerDatingInfo)
    end
end

function DatingDataMgr:checkTriggerDatingInfoState(triggerDatingInfo)
    if table.find(self.finishScriptIds,triggerDatingInfo.datingRuleCid) ~= -1 then
        triggerDatingInfo.state = EC_DatingScriptState.NORMAL
    else
        triggerDatingInfo.state = EC_DatingScriptState.TRIGGER
    end
end

function DatingDataMgr:addTriggerDatingInfo(triggerDatingInfo)
    triggerDatingInfo.state = EC_DatingScriptState.TRIGGER
    table.insert(self.triggerDatingInfoList,triggerDatingInfo)
end

function DatingDataMgr:getTriggerDatingInfoList()
    return self.triggerDatingInfoList
end

function DatingDataMgr:getTriggerDatingInfoListByRoleId(roleId)
    for i,v in ipairs(self.triggerDatingInfoList) do
        local roleTriggerInfo = v
        if roleTriggerInfo.roleId == roleId then
            return roleTriggerInfo.tdInfoList
        end
    end
end

function DatingDataMgr:getTriggerDatingInfo(datingRuleCid)
    local roleTDInfoList = RoleDataMgr:getTriggerDatingList()
    if not roleTDInfoList then
        return
    end
    for i,v in ipairs(roleTDInfoList) do
        if v.datingRuleCid == datingRuleCid then
            return v
        end
    end
end

function DatingDataMgr:updateTriggerDatingState(datingRuleCid,state)
    state = state or EC_DatingScriptState.NORMAL
    local triggerDatingInfo = self:getTriggerDatingInfo(datingRuleCid)
    if triggerDatingInfo then
        triggerDatingInfo.state = state
    end
    --EventMgr:dispatchEvent(EV_DATING_EVENT.refreshRedTips)
end

function DatingDataMgr:resetCityDatingInfoList()
    for i,v in ipairs(self.cityDatingInfoList) do
        local cityDatingInfo = v
        self:initCityDatingInfo(cityDatingInfo)
        self:updateCityDatingInfo(cityDatingInfo)
        self:cityDatingInfoBindNotFinishDatingInfo(cityDatingInfo)
        self:addElvesStateToDatingType(cityDatingInfo.roleId,cityDatingInfo.datingType,cityDatingInfo.state)
        if cityDatingInfo.state == EC_CityDatingState.noAccept then
            self:triggerPhoneDating(cityDatingInfo,true)
        end
    end
end

function DatingDataMgr:cityDatingInfoBindNotFinishDatingInfo(datingInfo)
    for ni,nv in ipairs(self.notFinishDatingInfoList) do
        if nv.datingRuleCid and nv.datingRuleCid == datingInfo.datingRuleCid then
            datingInfo.state = EC_DatingScriptState.NO_FINISH
            datingInfo.notFinishDatingInfo = nv
            break
        end
    end
end

function DatingDataMgr:initCityDatingInfo(cityDatingInfo)
    local data = self.datingRuleTable[cityDatingInfo.datingRuleCid]

    if data then 
        cityDatingInfo.cityId = data.enter_condition["buildingCid"]
        -- print("cityDatingInfo.cityId ",cityDatingInfo.cityId)
        cityDatingInfo.roleId = data.roleId
        cityDatingInfo.roleModelId = data.roleModelId
        cityDatingInfo.datingType = data.type
        cityDatingInfo.data = data
    end
end

function DatingDataMgr:updateCityDatingInfo(cityDatingInfo)
    changeUState(cityDatingInfo)
    if cityDatingInfo.uState == EC_CityDatingState.noAccept then
        cityDatingInfo.state = EC_DatingScriptState.TRIGGER
    elseif cityDatingInfo.uState == EC_CityDatingState.normal then
        cityDatingInfo.state = EC_DatingScriptState.NORMAL
    elseif cityDatingInfo.uState == EC_CityDatingState.overtime then
        cityDatingInfo.state = EC_DatingScriptState.FAIL
    elseif cityDatingInfo.uState == EC_CityDatingState.noDating or cityDatingInfo.uState == EC_CityDatingState.accept then
        cityDatingInfo.state = EC_DatingScriptState.LOCK
    end

    if cityDatingInfo.uState == EC_CityDatingState.accept then
        self:setAcceptPhoneRole(cityDatingInfo)
    else
        self:removeAcceptPhoneRole(cityDatingInfo)
    end
end

function DatingDataMgr:getCityDatingInfoList()
    return self.cityDatingInfoList
end

function DatingDataMgr:isHaveCityDating()
    if self.cityDatingInfoList and #self.cityDatingInfoList ~= 0 then
        return true
    end
    return false
end

function DatingDataMgr:getReserveFailScript(isClear)
    for i,v in ipairs(self.cityDatingInfoList) do
        local cityDatingInfo = clone(v)
        if cityDatingInfo.datingType == EC_DatingScriptType.RESERVE_SCRIPT and cityDatingInfo.state == EC_DatingScriptState.FAIL then
            if isClear then
                self:removeCityDatingInfo(cityDatingInfo.cityDatingId)
            end
            return cityDatingInfo
        end
    end
end

function DatingDataMgr:addCityDatingInfo(cityDatingInfo)
    table.insert(self.cityDatingInfoList,cityDatingInfo)

    self:addElvesStateToDatingType(cityDatingInfo.roleId,cityDatingInfo.datingType,cityDatingInfo.state)
end

function DatingDataMgr:addElvesStateToDatingType(roleId,datingType,datingState)
    -- print("addElvesStateToDatingType roleId ",roleId)
    -- print("addElvesStateToDatingType datingType ",datingType)
    -- print("addElvesStateToDatingType datingState ",datingState)

    ----Լ�����Ͷ�Ӧ����״̬��ϵ
    --EC_ElvesStateToDatingScriptType = {
    --    [EC_DatingScriptType.MAIN_SCRIPT] = EC_ElvesState.datingMain,
    --    [EC_DatingScriptType.RESERVE_SCRIPT] = {EC_ElvesState.datingReserveRequest,EC_ElvesState.datingReserve},
    --    [EC_DatingScriptType.OUT_SCRIPT] = EC_ElvesState.datingOut,
    --    [EC_DatingScriptType.DAY_SCRIPT] = EC_ElvesState.datingDayNoFinish,
    --}

    local elvesState = EC_ElvesStateToDatingScriptType[datingType]
    if datingType == EC_DatingScriptType.RESERVE_SCRIPT then
        if datingState == EC_DatingScriptState.TRIGGER then
            elvesState = EC_ElvesStateToDatingScriptType[datingType .. 1]
        elseif datingState == EC_DatingScriptState.NORMAL then
            elvesState = EC_ElvesStateToDatingScriptType[datingType .. 2]
        else
            self:removElvesStateToDatingType(roleId,datingType,EC_DatingScriptState.TRIGGER)
            self:removElvesStateToDatingType(roleId,datingType,EC_DatingScriptState.NORMAL)
        end
    end

    -- print("addElvesStateToDatingType elvesState ",elvesState)
    RoleDataMgr:addElvesState(roleId,elvesState)
    
end

function DatingDataMgr:removElvesStateToDatingType(roleId,datingType,datingState)
    if datingType == EC_DatingScriptType.RESERVE_SCRIPT then
        RoleDataMgr:removeElvesState(roleId,EC_ElvesStateToDatingScriptType[datingType .. 1])
        RoleDataMgr:removeElvesState(roleId,EC_ElvesStateToDatingScriptType[datingType .. 2])
    else
        RoleDataMgr:removeElvesState(roleId,EC_ElvesStateToDatingScriptType[datingType])
    end

end

function DatingDataMgr:removeCityDatingInfo(cityDatingId)
    local cityDatingInfo = self:getCityDatingInfoByCityDatingId(cityDatingId)
    if not cityDatingInfo then
        return
    end
    table.removeItem(self.cityDatingInfoList,cityDatingInfo)

    self:removElvesStateToDatingType(cityDatingInfo.roleId,cityDatingInfo.datingType,cityDatingInfo.state)
end

function DatingDataMgr:getCityDatingInfoByCityId(cityId,roleId)
    for i,v in ipairs(self.cityDatingInfoList) do
        local cityDatingInfo = v
        if cityDatingInfo.cityId == cityId and cityDatingInfo.roleId == roleId then
            return cityDatingInfo
        end
    end
end

function DatingDataMgr:getCityDatingInfoByRuleCid(datingType,ruleCid)
    for i,v in ipairs(self.cityDatingInfoList) do
        local cityDatingInfo = v
        if cityDatingInfo.datingType == datingType and cityDatingInfo.datingRuleCid == ruleCid then
            return cityDatingInfo
        end
    end
end

function DatingDataMgr:getCityDatingInfoByCityDatingId(cityDatingId)
    for i,v in ipairs(self.cityDatingInfoList) do
        local cityDatingInfo = v
        if cityDatingInfo.cityDatingId == cityDatingId then
            return cityDatingInfo
        end
    end
end

function DatingDataMgr:getCityDatingUState(datingType,cityId)
    return self:getCityDatingInfo(datingType,cityId).uState
end

function DatingDataMgr:getCityDatingState(datingType,cityId)
    return self:getCityDatingInfo(datingType,cityId).state
end

function DatingDataMgr:getCityDatingCurrentNodeId(datingType,ruleCid,msg)
    local cityDatingInfo = self:getCityDatingInfoByRuleCid(datingType,ruleCid)
    -- local datingRuleCid = cityDatingInfo.datingRuleCid
    -- local uState = cityDatingInfo.uState

    local cData = self.datingRuleTable[ruleCid]

    if cityDatingInfo and cityDatingInfo.uState and cityDatingInfo.uState == EC_CityDatingState.noAccept then
        local ruzCid = cData.other_script_ids[1]
        local ruZData = self.datingRuleTable[ruzCid]
        msg.currentNodeId = ruZData.start_node_id
        msg.datingId = cityDatingInfo.cityDatingId
    -- elseif uState == EC_CityDatingState.normal then
    --     -- msg.currentNodeId = cData.start_node_id   --Ԥ��Լ�������籾������Լ��ͨ�þ籾��
    -- elseif uState == EC_CityDatingState.overtime then
    --     -- msg.currentNodeId = cData.other_script_start_node_id[2] --ʧ�ܾ籾��Ԥ����ʱ������
    -- elseif uState == EC_CityDatingState.noDating or uState == EC_CityDatingState.accept then
    --     return nil
    else
        msg.currentNodeId = cData.start_node_id
    end

    return msg.currentNodeId
end

function DatingDataMgr:getCityDatingRoleId(datingType,ruleCid)
    local cityDatingInfo = self:getCityDatingInfoByRuleCid(datingType,ruleCid)
    return cityDatingInfo.roleId
end

function DatingDataMgr:getCityDatingModelId(datingType,ruleCid)
    local cityDatingInfo = self:getCityDatingInfoByRuleCid(datingType,ruleCid)
    return cityDatingInfo.roleModelId or RoleDataMgr:getModel(self:getCityDatingRoleId())
end

function DatingDataMgr:getCityDatingLines(datingType,ruleCid)
    local cityDatingInfo = self:getCityDatingInfoByRuleCid(datingType,ruleCid)
    return cityDatingInfo.data["lines"]
end

function DatingDataMgr:getCityDatingBg(datingType,ruleCid)
    local cityDatingInfo = self:getCityDatingInfoByRuleCid(datingType,ruleCid)
    return cityDatingInfo.data["backGround"]
end

function DatingDataMgr:getCityDatingBuildId(datingType,ruleCid)
    local cityDatingInfo = self:getCityDatingInfoByRuleCid(datingType,ruleCid)
    return cityDatingInfo.data["buildingId"]
end

function DatingDataMgr:getCityDatingRoleAction(datingType,ruleCid,idx)
    local cityDatingInfo = self:getCityDatingInfoByRuleCid(datingType,ruleCid)
    return cityDatingInfo.data["action" .. idx]
end

function DatingDataMgr:getCityDatingRoleIdle(datingType,ruleCid)
    local cityDatingInfo = self:getCityDatingInfoByRuleCid(datingType,ruleCid)
    return cityDatingInfo.data["idle"]
end

function DatingDataMgr:getCityDatingAnswer(datingType,ruleCid)
    -- print("datingType ",datingType)
    -- print("ruleCid ",ruleCid)
    local cityDatingInfo = self:getCityDatingInfoByRuleCid(datingType,ruleCid)
    return cityDatingInfo.data["other_info"].answer
end

function DatingDataMgr:getCityDatingTimeFrame(datingType,ruleCid)
    local cityDatingInfo = self:getCityDatingInfoByRuleCid(datingType,ruleCid)
    return cityDatingInfo.datingTimeFrame
end

function DatingDataMgr:getCityDatingId(datingType,ruleCid)
    local cityDatingInfo = self:getCityDatingInfoByRuleCid(datingType,ruleCid)
    return cityDatingInfo.cityDatingId
end

function DatingDataMgr:getCityNotFinishDatingInfo(datingType,cityId)
    local notFinishDatingInfo = self:getCityDatingInfo(datingType,cityId).notFinishDatingInfo

    if notFinishDatingInfo then
        local msg = {}
        msg.branchNodes = notFinishDatingInfo.branchNodes
        msg.currentNodeId = notFinishDatingInfo.currentNodeId
        msg.datingType = notFinishDatingInfo.datingType
        msg.datingRuleCid = notFinishDatingInfo.datingRuleCid
        msg.state = EC_DatingScriptState.NO_FINISH
        msg.isFirst = notFinishDatingInfo.isFirst

        -- print("getCityNotFinishDatingInfo ",msg)

        self:setCurMsg(msg)
        return notFinishDatingInfo
    end
end

function DatingDataMgr:getNotFinishDatingInfoList()
    return self.notFinishDatingInfoList
end

function DatingDataMgr:getNotFinishDatingInfoByType(datingType,scriptId,roleId,isClear)
    roleId = roleId or RoleDataMgr:getCurId()
    local notFinishDatingInfoList = self.notFinishDatingInfoList
    if not notFinishDatingInfoList then
        return
    end

    local NFD = nil

    for i,v in ipairs(notFinishDatingInfoList) do
        local notFinishDatingInfo = clone(v)
        if roleId == notFinishDatingInfo.roleCid then

            if scriptId and scriptId == notFinishDatingInfo.datingRuleCid then
                if isClear then
                    table.removeItem(notFinishDatingInfoList,v)
                end
                NFD = notFinishDatingInfo
            elseif not scriptId and datingType and datingType == notFinishDatingInfo.datingType then
                if isClear then
                    table.removeItem(notFinishDatingInfoList,v)
                end
                NFD = notFinishDatingInfo
            end
        end
    end

    if NFD and isClear then
        local msg = {}
        msg.branchNodes = NFD.branchNodes
        msg.currentNodeId = NFD.currentNodeId
        msg.datingType = NFD.datingType
        msg.datingRuleCid = NFD.datingRuleCid
        msg.state = EC_DatingScriptState.NO_FINISH
        msg.isFirst = NFD.isFirst

        self:setCurMsg(msg)
    end
    return NFD
end

function DatingDataMgr:getNotFinishDatingScriptId(datingType,roleId)
    roleId = roleId or RoleDataMgr:getCurId()
    local notFinishDatingInfo = self:getNotFinishDatingInfoByType(datingType,nil,roleId)
    return notFinishDatingInfo.datingRuleCid
end

function DatingDataMgr:addNotFinishDatingInfo(score,datingType,currentNodeId,branchNodes,selectedNode,roleCid,datingRuleCid,isFirst)
    -- //δ���Լ��
    -- message NotFinishDating {
    --     required int32 score = 1; //����
    --     required int32 datingType = 2; //Լ������
    --     required int32 currentNodeId = 3; //��ǰ���е��Ľڵ�
    --     optional BranchNodes branchNodes = 4; //��֧�ڵ�
    --     optional int32 selectedNode = 5; //��ѡ��ڵ�
    --     required int32 roleCid = 6;//������id
    -- }

    if not self.notFinishDatingInfoList then
        self.notFinishDatingInfoList = {}
    end

    roleCid = roleCid or RoleDataMgr:getCurId()
    for i,v in ipairs(self.notFinishDatingInfoList) do
        if roleCid == v.roleCid and datingType and datingType == v.datingType then
            table.removeItem(self.notFinishDatingInfoList,v)
        end
    end

    local notFinishDatingInfo = {}
    notFinishDatingInfo.score = score
    notFinishDatingInfo.datingType = datingType
    notFinishDatingInfo.currentNodeId = currentNodeId
    notFinishDatingInfo.branchNodes = branchNodes
    notFinishDatingInfo.selectedNode = selectedNode
    notFinishDatingInfo.datingRuleCid = datingRuleCid
    notFinishDatingInfo.roleCid = roleCid or RoleDataMgr:getCurId()
    notFinishDatingInfo.isFirst = isFirst

    table.insert(self.notFinishDatingInfoList,notFinishDatingInfo)
    --EventMgr:dispatchEvent(EV_DATING_EVENT.refreshRedTips)


    if datingType == EC_DatingScriptType.DAY_SCRIPT then
        self:addElvesStateToDatingType(notFinishDatingInfo.roleCid,datingType,EC_DatingScriptState.NO_FINISH)
    end

end

function DatingDataMgr:setScriptType(scriptType)
    self.datingType = scriptType
end

function DatingDataMgr:getScriptType()
    return self.datingType
end

function DatingDataMgr:setDatingState(datingState)
    self.datingState = datingState
end

function DatingDataMgr:getDatingState()
    return self.datingState
end

function DatingDataMgr:checkIsSingleDating( datingRuleId )
    local datingRuleCfg = TabDataMgr:getData("DatingRule",datingRuleId)
    if not datingRuleCfg then return false end
    local datingType = datingRuleCfg.type
    local styleId = datingType*10 
    if datingRuleCfg.datingTypeNew then
        styleId = datingRuleCfg.datingTypeNew
    end
    local extentData = TabDataMgr:getData("DatingTypeMgr")[styleId] or TabDataMgr:getData("DatingTypeMgr")[1000]
    if extentData.optionActType ~= 1 and  extentData.optionActType ~= 2 and (extentData.resultActionType == 5 or extentData.resultActionType == 3) then -- 不需要服务器验证合法性的约会直接开始前端约会
        return true
    end
    return false
end

function DatingDataMgr:startDating(datingRuleId)
    local datingRuleCfg = TabDataMgr:getData("DatingRule",datingRuleId)
    if not datingRuleCfg then
        Box("datingRuleId:"..tostring(datingRuleId))
        return
    end
    local datingTabName = datingRuleCfg.callTableName
    local datingType = datingRuleCfg.type
    local start_node_id = datingRuleCfg.start_node_id
    self:setScriptTableName(datingTabName)

    if self:checkIsSingleDating(datingRuleId) then
        local event = {}
        event.data = {}
        event.data.datingRuleCid = datingRuleId
        event.data.isFirst = false
        event.data.datingId = start_node_id
        self:datingScriptMsgHandle(event)
        return
    end

    if self:getNotFinishDatingInfoByType(datingType,datingRuleId,nil,true) then
        self:showDatingLayer(datingType)
    else
        self:sendGetSciptMsg(datingType,datingRuleCfg.roleId,nil,datingRuleId)
    end
end
-- // ��ȡ�籾
--[[
    [1] = {--GetScriptMsg
        [1] = {--ScriptType(enum)
            'v4':ScriptType
        },
        [2] = 'int32':roleId    [����id]
        [3] = 'int32':buildId   [ ����id]
        [4] = 'int32':scriptId  [�籾id]
        [5] = 'int32':cityId    [ ����id]
        [6] = 'string':cityDatingId [ ����Լ��id]
    }
--]]
-- c2s.DATING_GET_SCRIPT = 1537

--���ͻ�ȡ�籾����

function DatingDataMgr:sendGetSciptMsg(scriptType,roleId,buildId,scriptId,cityId,cityDatingId)
    roleId = roleId or RoleDataMgr:getCurId()

    if scriptType == EC_DatingScriptType.FUBEN_SCRIPT then
        roleId = 0
    end

    local scriptMsg =
    {
        scriptType,
        roleId or 0,
        buildId or 0,
        scriptId or 0,
        cityId or 0,
        cityDatingId or "",
    }
    -- print("c scriptMsg ",scriptMsg)
    local nResult = TFDirector:send(c2s.DATING_GET_SCRIPT, scriptMsg)
end


--ѡ��ѡ��
--[[
    [1] = {--DialogueMsg
        [1] = 'int32':branchNodeId  [ ��֧�ڵ�id]
        [2] = 'int32':selectedNodeId    [ѡ��Ľڵ�id]
        [3] = 'bool':isLastNode [�Ƿ�����ڵ�]
    }
--]]

--[[
    [1] = {--DialogueMsg
        [1] = 'int32':branchNodeId  [ ��֧�ڵ�id]
        [2] = 'int32':selectedNodeId    [ѡ��Ľڵ�id]
        [3] = 'bool':isLastNode [�Ƿ�����ڵ�]
        [4] = 'int32':datingType    [Լ������]
        [5] = 'int32':roleId    [����id]
    }
--]]
-- c2s.DATING_DIALOGUE = 1538

function DatingDataMgr:sendDialogueMsg(branchNodeId,selectedNodeId,datingType,roleId)
    --ѡ��ID
    roleId = roleId or RoleDataMgr:getCurId()
    local dialogueMsg = nil


    local isGameOver

    if selectedNodeId then
        isGameOver = false
    else
        isGameOver = true
        print("���ͽ������")
    end

    if isGameOver and branchNodeId then
        self:setFinishDayScriptEndId(branchNodeId)
        if datingType == EC_DatingScriptType.DAY_SCRIPT then
            self:removElvesStateToDatingType(roleId,datingType,EC_DatingScriptState.NO_FINISH)
            if self.notFinishDatingInfoList then
                for i,v in ipairs(self.notFinishDatingInfoList) do
                    if roleId == v.roleCid and datingType and datingType == v.datingType then
                        table.removeItem(self.notFinishDatingInfoList,v)
                    end
                end
            end
        end

    end

    if not selectedNodeId then
        selectedNodeId = branchNodeId
        branchNodeId = 0
    end

    local datingId
    if self:getCurDatingScript() then
        datingId = self:getCurDatingScript().datingId
    end
    datingId = datingId or "0"
    dialogueMsg = {
        branchNodeId,
        selectedNodeId,
        isGameOver,
        datingType,
        roleId,
        datingId
    }
    print("dialogueMsg ",dialogueMsg)
    TFDirector:send(c2s.DATING_DIALOGUE, dialogueMsg)

end

--[[
    [1] = {--DatingScriptMsg    [ͨ�þ籾]
        [1] = 'int32':datingRuleCid [�籾cid]
        [2] = {--BranchNodes
            [1] = {--repeated BranchNode
                [1] = 'int32':datingId  [Լ������id]
                [2] = 'repeated int32':nextNodeIds  [�¼��ڵ�id]
            },
        },
    }
--]]
-- s2c.DATING_DATING_SCRIPT = 1542

function DatingDataMgr:datingScriptMsgHandle(event)
    print("datingScriptMsgHandle ")
    if event.data then

        print("datingScriptMsgHandle event.data",event.data)

        self:clearReviewTable()

        local ruleCid = event.data.datingRuleCid
        local cData = self.datingRuleTable[ruleCid]
        local msg = {}
        msg.branchNodes = event.data.branchNodes
        msg.currentNodeId = cData.start_node_id
        msg.datingType = cData.type
        msg.datingRuleCid = ruleCid
        msg.state = EC_DatingScriptState.NO_FINISH
        msg.isFirst = event.data.isFirst
        msg.datingId = event.data.datingId

        if msg.datingType == EC_DatingScriptType.RESERVE_SCRIPT then
            self:getCityDatingCurrentNodeId(msg.datingType,ruleCid,msg)
        end

        if msg.datingType == EC_DatingScriptType.PHONE_SCRIPT then
            EventMgr:dispatchEvent(EV_DATING_EVENT.phoneDating)
        else
            self:setCurMsg(msg)
            self:showDatingLayer(msg.datingType)
        end
        -- EventMgr:dispatchEvent(EV_DATING_EVENT.getDating,event.data)
    end
end

function DatingDataMgr:showReserveAcceptLayer(ruleCid)
    local msg = {}
    msg.datingType = EC_DatingScriptType.RESERVE_SCRIPT
    msg.datingRuleCid = ruleCid
    msg.state = EC_DatingScriptState.TRIGGER
    self:getCityDatingCurrentNodeId(msg.datingType,ruleCid,msg)
    self:setCurMsg(msg)

    self:showDatingLayer(msg.datingType)
end

function DatingDataMgr:showDatingLayer(datingType,currentNodeId,isNoF,scriptId,isFubenShowBackBtn,isFirst)

    isFubenShowBackBtn = isFubenShowBackBtn or false

    if datingType == EC_DatingScriptType.FUBEN_SCRIPT or datingType == EC_DatingScriptType.FUBEN_CITY_SCRIPT then
        EventMgr:dispatchEvent(EV_FUBEN_ENTER_DATING_LEVEL)
    end
    if not datingType then
        self:setMiniGameOption()
    elseif (datingType == EC_DatingScriptType.SHOW_SCRIPT or datingType == EC_DatingScriptType.FUBEN_SCRIPT
            or datingType == EC_DatingScriptType.SPECIAL_SCRIPT or datingType == EC_DatingScriptType.MAIN_SCRIPT
            or datingType == EC_DatingScriptType.OUTSIDE_SCRIPT or datingType == EC_DatingScriptType.FUBEN_CITY_SCRIPT
            or datingType == EC_DatingScriptType.FAVOR_SCRIPT or datingType == 20)
            and currentNodeId then
        local msg = {}
        msg.currentNodeId = currentNodeId
        msg.datingType = datingType
        msg.state = EC_DatingScriptState.NO_FINISH
        msg.datingRuleCid = scriptId
        msg.isFirst = isFirst or false
        print("isFirst " , isFirst)
        print("88888888888888888", msg)
        self:setCurMsg(msg)
    elseif isNoF then
        local noFInfo = self:getNotFinishDatingInfoByType(datingType,nil,nil,true)
        if not noFInfo then
            return
        end
    elseif not self.curDatingScript then
        return
    end

    if not isNoF and self.curDatingScript.datingType then
        DatingDataMgr:clearReviewTable(DatingConfig.ReviewKey.YUEHUI_KEY,self.curDatingScript.datingType)
    end

    if not datingType or datingType == EC_DatingScriptType.DAY_SCRIPT or datingType == EC_DatingScriptType.FAVOR_SCRIPT then
        AlertManager:closeAll()
    end

    self:setIsDating(true)
    local view = requireNew("lua.logic.dating.DatingScriptView"):new(isFubenShowBackBtn,isNoF)
    AlertManager:addLayer(view,AlertManager.BLOCK)
    AlertManager:show()
end

function DatingDataMgr:setIsDating(isDating)
    self.isDating = isDating
end

function DatingDataMgr:getIsDating()
    return self.isDating
end

function DatingDataMgr:saveMiniGameOption(jumpTable,currentId)
    self.miniGameOptionList = jumpTable
    self.currentId = currentId
end

function DatingDataMgr:getMiniGameOption()
    return self.miniGameOptionList
end

function DatingDataMgr:setMiniGameOption()

    if not self.miniGameOptionList then
        return
    end
    local gameResult = false
    if self.curDatingScript.datingType == EC_DatingScriptType.COURAGE_SCRIPT then
        gameResult = CourageDataMgr:getMiniGameResult()
    else
        gameResult = CatchDollDataMgr:getGameWin()
    end

    if gameResult then
        self.curDatingScript.id = self.miniGameOptionList[1]
    else
        self.curDatingScript.id = self.miniGameOptionList[2]
    end

    if self.curDatingScript.datingType == EC_DatingScriptType.FUBEN_SCRIPT or self.curDatingScript.datingType == EC_DatingScriptType.SHOW_SCRIPT then

    else
        local roleId = self:getDatingRuleRoleId(self.curDatingScript.datingRuleCid)
        print(self.currentId,self.curDatingScript.id,self.curDatingScript.datingType,roleId)
        self:sendDialogueMsg(self.currentId,self.curDatingScript.id,self.curDatingScript.datingType,roleId)
    end
end

function DatingDataMgr:getMiniGameScriptId()
    return self.currentId
end

function DatingDataMgr:setCurMsg(msg)
    self.curDatingScript = {}
    self.curDatingScript.id = msg.currentNodeId
    self.curDatingScript.optionList = msg.branchNodes
    self.curDatingScript.datingType = msg.datingType
    self.curDatingScript.datingRuleCid = msg.datingRuleCid
    self.curDatingScript.state = msg.state
    self.curDatingScript.isFirst = msg.isFirst or false
    self.curDatingScript.datingId = msg.datingId

    self:setScriptType(msg.datingType)
    -- self:saveMiniGameOption()
end

function DatingDataMgr:getDatingRuleData(datingRuleCid)
    return self.datingRuleTable[datingRuleCid]
end

function DatingDataMgr:getDatingRuleDataByStartId(startNodeId)
    for k,v in pairs(self.datingRuleTable) do
        if v.start_node_id == startNodeId then
            return v
        end
    end
end

function DatingDataMgr:getDatingRuleCallTableName(datingRuleCid)
    local sTableName
    if datingRuleCid then
        sTableName = self.datingRuleTable[datingRuleCid].callTableName
    else
        sTableName = self:getScriptTableName()
    end
    self:setScriptTableName()
    return sTableName
end

function DatingDataMgr:getDatingRuleDungeonDateDes(datingRuleCid)
    return self.datingRuleTable[datingRuleCid].dungeonDateDes
end

function DatingDataMgr:getDatingRuleDungeonRoleId(datingRuleCid)
    return self.datingRuleTable[datingRuleCid].dungeonRoleId
end

function DatingDataMgr:getDatingRuleDungeonDateHeart(datingRuleCid)
    return self.datingRuleTable[datingRuleCid].dungeonDateHeart
end

function DatingDataMgr:getIsSettlement(datingRuleCid)
    return table.count(self.datingRuleTable[datingRuleCid].dungeonDateHeart)>0
end

function DatingDataMgr:getDatingRuleRoleId(datingRuleCid)
    if not datingRuleCid then
        return
    end
    local roleId = self:getDatingRuleDungeonRoleId(datingRuleCid)
    if not roleId or roleId == 0 then
        roleId = self.datingRuleTable[datingRuleCid].roleId
    end
    return roleId
end

function DatingDataMgr:getCurDatingScript()
    return self.curDatingScript
end

function DatingDataMgr:getCurDatingScriptRuleCid()
    return self.curDatingScript.datingRuleCid
end

function DatingDataMgr:dialogueMsgHandle(event)
    if event.data then
        EventMgr:dispatchEvent(EV_DATING_EVENT.refreshScore,event.data)
    end
end

-- //�籾������Ϣ
function DatingDataMgr:datingSettlementMsgHandle(event)
    print("Լ����")
    if event.data then
        local msg = event.data
        print("====msg ",msg)
        if msg.obsolete then
        else
            self.datingSettlementMsg = {}
            self.datingSettlementMsg.score = msg.score
            self.datingSettlementMsg.favor = msg.favor
            self.datingSettlementMsg.mood = msg.mood
            self.datingSettlementMsg.rewards = msg.rewards
            self.datingSettlementMsg.scriptId = msg.scriptId
            self.datingSettlementMsg.starList = msg.starList
            self.datingSettlementMsg.endId = msg.endId

            print("777777777777777777777777777777777", self.datingSettlementMsg)

            local cData = self.datingRuleTable[msg.scriptId]
            if cData.type == EC_DatingScriptType.PHONE_SCRIPT then
                EventMgr:dispatchEvent(EV_DATING_EVENT.triggerPhoneDating,false,msg.scriptId,msg.rewards)
            end

            self:addScriptId(msg.scriptId)
            self:updateTriggerDatingState(msg.scriptId)
            RoleDataMgr:setMainLiveStateByRuleCid(msg.scriptId,EC_DatingScriptState.NORMAL)

            self:resetDatingSettlement()
        end
        EventMgr:dispatchEvent(EV_DATING_EVENT.refreshSettlement,msg.obsolete)
        EventMgr:dispatchEvent(EV_DATING_EVENT.cityDatingTips)
    end
end

function DatingDataMgr:getDeScore()
    return self.defaultScore
end

function DatingDataMgr:resetDatingSettlement()

    local dressData = TabDataMgr:getData("Dress")
    local rewards = self.datingSettlementMsg.rewards or {}

    for i,v in ipairs(rewards) do
        print(v.id)
        if dressData[v.id] then
            v.iconPath = dressData[v.id].icon
            self.datingSettlementMsg.dressData = self.datingSettlementMsg.dressData or {}
            table.insert(self.datingSettlementMsg.dressData,v)
        else
            local itemData = GoodsDataMgr:getItemCfg(v.id)
            if itemData then
                v.iconPath = itemData.icon
                if v.id == EC_SItemType.CURFAVOR then
                    self.datingSettlementMsg.favor = self.datingSettlementMsg.favor or v.num
                elseif v.id == EC_SItemType.CURMOOD then
                    self.datingSettlementMsg.mood = self.datingSettlementMsg.mood or v.num
                elseif itemData.superType == EC_ResourceType.SKIN then
                    self.datingSettlementMsg.cgs = self.datingSettlementMsg.cgs or {}
                    table.insert(self.datingSettlementMsg.cgs,v)
                else
                    print("insert goods ",v.id)
                    self.datingSettlementMsg.goods = self.datingSettlementMsg.goods or {}
                    table.insert(self.datingSettlementMsg.goods,v)
                end
            end
        end
    end

end

-- //����Լ������
-- //code = 1544
-- message AnswerDatingInvitationMsg {
--     required string datingId = 1; //Լ��id
--     required int32 answer = 2; //�ش�
-- }
-- c2s.DATING_ANSWER_DATING_INVITATION = 1544

function DatingDataMgr:answerDatingInvitationMsg(datingId,answer)
    local msg = {datingId,answer}
    TFDirector:send(c2s.DATING_ANSWER_DATING_INVITATION, msg)
end

--����Լ��
--[[
    [1] = {--ContinueDating
        [1] = 'int32':datingType    [Լ������]
        [2] = 'int32':datingRuleCid [ Լ��id]
    }
--]]
-- c2s.DATING_CONTINUE_DATING = 1552
--����Լ��δ���Լ������Լ���ʱ���������֤��ǰԼ���ͷ�ȡ�� (��ʱ����Ŀǰ����)
function DatingDataMgr:sendContinueDating(datingType,datingRuleCid)
    local msg = {datingType,datingRuleCid}
    TFDirector:send(c2s.DATING_CONTINUE_DATING, msg)
end

function DatingDataMgr:continueDatingHandle(event)

end

--Լ��ʧ�ܣ���ʱ֧������Լ���з�������0ֱ��ʧ�ܣ�
--[[
    [1] = {--DatingFail
        [1] = 'int32':datingRuleCid
    }
--]]
-- s2c.DATING_DATING_FAIL = 1551

function DatingDataMgr:datingFailHandle(event)
    if event.data then
        local ruleCid = event.data.datingRuleCid
        local state = EC_DatingScriptState.NORMAL
        if not self:checkScriptIdIsFinish(ruleCid) then
            state = EC_DatingScriptState.TRIGGER
        end
        RoleDataMgr:setMainLiveStateByRuleCid(ruleCid,state)
        EventMgr:dispatchEvent(EV_DATING_EVENT.datingFail)
    end
end

--[[
    [1] = {--UpdateTriggerDating
        [1] = 'int32':roleId
        [2] = 'repeated int32':datingRuleCid
    }
--]]
-- s2c.DATING_UPDATE_TRIGGER_DATING = 1550

function DatingDataMgr:updateTriggerDatingHandle(event)
    if event.data then
        print("触发约会 event.data ",event.data)
        local roleTriggerInfo = event.data

        self:updateRoleTriggerInfo(roleTriggerInfo)
    end
end

--[[
    [1] = {--CityDatingInfo
        [1] = {--ChangeType(enum)
            'v4':ChangeType
        },
        [2] = 'string':cityDatingId [����Լ��id]
        [3] = 'repeated int32':datingTimeFrame  [Լ��ʱ��]
        [4] = 'int32':datingRuleCid [Լ��cid]
        [5] = 'int32':date  [Լ������]
        [6] = 'int32':state [Ԥ��Լ��״̬ 0:��Լ�� 1:������,δ���� 2:�ѽ������� 3:����Լ��ʱ�� 4:Լ��ʱ���ѹ�]
    }
--]]
-- s2c.DATING_CITY_DATING_INFO = 1549

function DatingDataMgr:updateCityDatingInfoHandle(event)

    if event.data then
        local uCityDatingInfo = event.data
        local ct = event.data.ct
        print("updateCityDatingInfoHandle uCityDatingInfo ",uCityDatingInfo)
        if ct == EC_SChangeType.ADD then
            self:initCityDatingInfo(uCityDatingInfo)
            self:updateCityDatingInfo(uCityDatingInfo)
            self:addCityDatingInfo(uCityDatingInfo)
            self:triggerPhoneDating(uCityDatingInfo,true)
        elseif ct == EC_SChangeType.DELETE then
            local dType = nil
            local cityDatingInfo = self:getCityDatingInfoByCityDatingId(uCityDatingInfo.cityDatingId)
            if cityDatingInfo then
                dType = cityDatingInfo.datingType
            end
            self:removeCityDatingInfo(uCityDatingInfo.cityDatingId)
            self:triggerPhoneDating(uCityDatingInfo,false)
            if not event.data.inDating and dType and self.curDatingScript and self.curDatingScript.datingType == dType then
                EventMgr:dispatchEvent(EV_DATING_EVENT.delectCityDating,uCityDatingInfo.datingRuleCid)
            end
        elseif ct == EC_SChangeType.UPDATE then
            self:updateCityDatingInfo(uCityDatingInfo)
            if uCityDatingInfo.uState == EC_CityDatingState.overtime then
                EventMgr:dispatchEvent(EV_DATING_EVENT.datingOverTime)
            end
            local cityDatingInfo = self:getCityDatingInfoByCityDatingId(uCityDatingInfo.cityDatingId)
            if not cityDatingInfo then
                cityDatingInfo = clone(uCityDatingInfo)
            else
                table.merge(cityDatingInfo,uCityDatingInfo)
            end
            self:addElvesStateToDatingType(cityDatingInfo.roleId,cityDatingInfo.datingType,cityDatingInfo.state)
            self:triggerPhoneDating(uCityDatingInfo,false)
        end
        EventMgr:dispatchEvent(EV_DATING_EVENT.cityDatingTips)
    end
end

--[[
    [1] = {--CityDatingInfoList
    [1] = {--CityDatingInfo
        [1] = {--ChangeType(enum)
            'v4':ChangeType
        },
        [2] = 'string':cityDatingId [����Լ��id]
        [3] = 'repeated int32':datingTimeFrame  [Լ��ʱ��]
        [4] = 'int32':datingRuleCid [Լ��cid]
        [5] = 'int32':date  [Լ������]
        [6] = 'int32':state [Ԥ��Լ��״̬ 0:��Լ�� 1:������,δ���� 2:�ѽ������� 3:����Լ��ʱ�� 4:Լ��ʱ���ѹ�]
    },
    }
--]]
-- s2c.DATING_CITY_DATING_INFO_LIST = 1548

function DatingDataMgr:updateCityDatingInfoListHandle(event)
    if event.data then
        print("updateCityDatingInfoListHandle")
        local cityDatingInfoList = event.data.cityDatingInfo
        print("cityDatingInfoList ",cityDatingInfoList)
        for i,v in ipairs(cityDatingInfoList) do
            local par = {}
            par.data = clone(v)
            self:updateCityDatingInfoHandle(par)
        end
    end
end

function DatingDataMgr:triggerPhoneDating(uCityDatingInfo,isNew)

    local ruleId = uCityDatingInfo.datingRuleCid
    local datingTimeFrame = uCityDatingInfo.datingTimeFrame
    local ruleCfg = TabDataMgr:getData("DatingRule")[ruleId]
    
    if not ruleCfg then
        return
    end

    local phoneRole = ruleCfg.phoneRole
    if phoneRole ~= 0 then
        self:setPhoneDating(ruleId,isNew,datingTimeFrame)
        EventMgr:dispatchEvent(EV_DATING_EVENT.triggerPhoneDating,isNew,ruleId)
    end
end

function DatingDataMgr:setAcceptPhoneRole(uCityDatingInfo)

    local ruleId = uCityDatingInfo.datingRuleCid
    local ruleCfg = TabDataMgr:getData("DatingRule")[ruleId]
    if not ruleCfg then
        return
    end

    local phoneRole = ruleCfg.phoneRole
    if not self.acceptPhoneRole then
        self.acceptPhoneRole = {}
    end
    self.acceptPhoneRole[phoneRole] = 1
end

function DatingDataMgr:removeAcceptPhoneRole(uCityDatingInfo)
    local ruleId = uCityDatingInfo.datingRuleCid
    local ruleCfg = TabDataMgr:getData("DatingRule")[ruleId]
    if not ruleCfg then
        return
    end

    local phoneRole = ruleCfg.phoneRole
    if self.acceptPhoneRole and self.acceptPhoneRole[phoneRole] then
        self.acceptPhoneRole[phoneRole] = nil
    end
end

function DatingDataMgr:isAcceptPhoneRole(phoneRole)

    if not self.acceptPhoneRole then
        return
    end

    return self.acceptPhoneRole[phoneRole]
end

function DatingDataMgr:getPhoneDating()

    return self.isPhoneDatingNew,self.phoneRuleId,self.datingTimeFrame
end

function DatingDataMgr:setPhoneDating(phoneRuleId,isNew,datingTimeFrame)

    self.isPhoneDatingNew = isNew
    self.phoneRuleId = phoneRuleId
    self.datingTimeFrame = datingTimeFrame
end

function DatingDataMgr:acceptDatingInvitationHandle(event)
    EventMgr:dispatchEvent(EV_DATING_EVENT.cityDatingTips)
    EventMgr:dispatchEvent(EV_DATING_EVENT.acceptDating)
    --״̬������ݸ��ĵ�����Լ��ͨ��ˢ��

    -- local ruleCid = event.data.datingId --Ԥ��Լ��id
    -- local cityDatingInfo = self:getCityDatingInfoByRuleCid(EC_DatingScriptType.RESERVE_SCRIPT,ruleCid)
    -- cityDatingInfo.date = event.data.datingTime
    -- cityDatingInfo.uState = state
end

function DatingDataMgr:getSettlementModel(ruleCid)
    if not self:getDatingRuleData(ruleCid) then
        Bugly:ReportLuaException("ruleCid: ========================= " .. ruleCid)
        return
    end
    return self:getDatingRuleData(ruleCid).modelId
end

function DatingDataMgr:clearReviewTable(reviewKey,scriptType)
    local reviewTable = {}
    self:saveReviewTable(reviewTable,reviewKey,scriptType)
end

function DatingDataMgr:saveReviewTable(reviewTable,reviewKey,scriptType)
    if not reviewKey then
        reviewKey = DatingConfig.ReviewKey.YUEHUI_KEY
    end
    scriptType = scriptType or ""
    -- local roleId = RoleDataMgr:getCurId()
    if not RoleDataMgr:getCurId() then
        return
    end
    local roleId = RoleDataMgr:getRoleSid(RoleDataMgr:getCurId())
    reviewKey = reviewKey .. scriptType .. tostring(roleId)
    table.saveTable(reviewTable,reviewKey)
end

function DatingDataMgr:readReviewTable(reviewKey,scriptType)
    if not reviewKey then
        reviewKey = DatingConfig.ReviewKey.YUEHUI_KEY
    end
    scriptType = scriptType or ""
    -- local roleId = RoleDataMgr:getCurId()
    if not RoleDataMgr:getCurId() then
        return
    end
    local roleId = RoleDataMgr:getRoleSid(RoleDataMgr:getCurId())
    reviewKey = reviewKey .. scriptType .. tostring(roleId)
    self.reviewTable = table.readTable(reviewKey) or {}
    return self.reviewTable
end

function DatingDataMgr:isFinishEndIds(scriptId)
    for i,v in ipairs(self.dayScriptEndIds) do
        if v == scriptId then
            return true
        end
    end
    return false
end

function DatingDataMgr:getDayScriptEndIds()
    return self.dayScriptEndIds
end

function DatingDataMgr:setFinishDayScriptEndId(scriptId)
    self.finishDayScriptEndId = scriptId
    local isAdd = true
    for i,v in ipairs(self.dayScriptEndIds) do
        if v == scriptId then
            isAdd = false
            break
        end
    end
    if isAdd then
        table.insert(self.dayScriptEndIds,scriptId)
        self:resetDayScriptEnds()
    end
end

function DatingDataMgr:getFinishDayScriptEndId()
    return self.finishDayScriptEndId
end

function DatingDataMgr:getFinishDayScriptEndType(scriptId)
    for k,v in pairs(self.dayScriptEndInfos[RoleDataMgr:getCurId()]) do
        local uDayScripInfo = v
        if uDayScripInfo.endList then
            for index,endInfo in ipairs(uDayScripInfo.endList) do
                if table.find(endInfo.list,scriptId) ~= -1 then
                    return endInfo.type
                end
            end
        end
    end

    if self.dayScriptBadEndInfos.list then
        if table.find(self.dayScriptBadEndInfos.list,scriptId) ~= -1 then
            return 4
        end
    end

    return 4 -- bad���
end

function DatingDataMgr:resetDayScriptEnds()
    for k,v in pairs(self.dayScriptEndInfos) do
        for ki,vi in pairs(v) do
            local uDayScripInfo = vi
            local endList = uDayScripInfo.endList
            local listNum = 0
            local finishListNum = 0
            for i,v in ipairs(endList) do
                local endInfo = v
                endInfo.finishList = {}
                for idx,endId in ipairs(self.dayScriptEndIds) do
                    if table.find(endInfo.list,endId) ~= -1 then
                        table.insert(endInfo.finishList,endId)
                    end
                end
                for id,vd in ipairs(endInfo.infoList) do
                    local info = vd
                    if table.find(endInfo.finishList,info.endId) ~= -1 then
                        info.isFinsh = true
                    else
                        info.isFinsh = false
                    end
                end

                endInfo.process = (table.count(endInfo.finishList) / table.count(endInfo.list)) * 100
                listNum = listNum + table.count(endInfo.list)
                finishListNum = finishListNum + table.count(endInfo.finishList)
            end
            uDayScripInfo.process = ( finishListNum / listNum ) * 100
        end
    end
end

function DatingDataMgr:initDayScriptEnds()

    -- --�ճ�Լ��������
    -- EC_DayDatingEndType = {
    --     HAPPYEND = 1,
    --     TUREEND = 2,
    --     NORMALEND = 3,
    --     BADEND = 4,
    --     HIDDENEND = 5
    -- }

    local dayScriptTable = TabDataMgr:getData("DatingProcess")
    self.dayScriptEndInfos = {}
    for k,v in pairs(dayScriptTable) do
        if v.role then
            self.dayScriptEndInfos[v.role] = self.dayScriptEndInfos[v.role] or {}
            if v.build then
                local uDayScripInfo = {}
                local moodPath = v.mood
                uDayScripInfo.endList = {}
                uDayScripInfo.favorLevel = v.favorLevel
                uDayScripInfo.buildIcon = v.buildIcon
                uDayScripInfo.icon = v.icon
                uDayScripInfo.smallIcon = v.smallIcon
                uDayScripInfo.datingScript = v.datingScript
                uDayScripInfo.titleName = v.titleName
                uDayScripInfo.cgAnimation = v.cgAnimation
                uDayScripInfo.taskId = v.taskId
                uDayScripInfo.cg = v.cg
                uDayScripInfo.buildDes = v.buildDes
                for index=1,5 do
                    local endIdx = "end" .. index
                    local endTitle = "end" .. index .. "Title"
                    if index == 4 then
                        self.dayScriptBadEndInfos.list = v[endIdx]
                        self.dayScriptBadEndInfos.type = index
                    else
                        if v[endIdx] then
                            local endInfo = {}
                            endInfo.list = v[endIdx]
                            endInfo.infoList = {}
                            endInfo.type = index

                            endInfo.endTitleList = v[endTitle]
                            for idx,endId in ipairs(endInfo.list) do
                                local info = {}
                                info.isFinsh = false
                                info.endId = endId
                                info.desId = endInfo.endTitleList[idx]
                                info.type = index
                                table.insert(endInfo.infoList,info)
                            end
                            endInfo.moodPath = moodPath
                            table.insert(uDayScripInfo.endList,endInfo)
                        end
                    end
                end
                self.dayScriptEndInfos[v.role][v.build] = uDayScripInfo
            end
        end
    end
end


function DatingDataMgr:getToRoleDayScripInfo(roleId)
    roleId = roleId or RoleDataMgr:getCurId()
    return self.dayScriptEndInfos[roleId]
end

function DatingDataMgr:selectBuildItem(buildId,roleId)
    roleId = roleId or RoleDataMgr:getCurId()
    return self.dayScriptEndInfos[roleId][buildId]
end

function DatingDataMgr:getBuildListByRoleId(roleId)

    local buildData = self:getToRoleDayScripInfo(roleId)
    local buildData_ = {}
    if not buildData then return buildData_ end
    local buildTable = TabDataMgr:getData("NewBuild")
    if not buildData then return buildData_ end
    for k,v in pairs(buildData) do
        local buildId = k
        for kb,vb in pairs(buildTable) do
            if kb == buildId then
                vb.buildId = buildId
                self:bindBuildState(vb,roleId,v.datingScript)
                table.insert(buildData_,vb)
                break
            end
        end
    end

    self:sortBuildList(buildData_)
    return buildData_
end

function DatingDataMgr:bindBuildState(buildInfo,roleId,id)

    --�����Ƿ����
    buildInfo.isUnlock = NewCityDataMgr:getCityBuildIsUnlock(buildInfo.id)

    if not self.datingRuleTable[id] then
        Box("not find id frome datingRule :" .. id)
        return
    end

    local data = self.datingRuleTable[id].enter_condition
    buildInfo.enter_condition = data
    buildInfo.isFavorPass = RoleDataMgr:getFavor(roleId) >= data.favor
    buildInfo.isFubenPass = FubenDataMgr:isPassPlotLevel(data.pass)
    buildInfo.daytime = data.time
end

function DatingDataMgr:sortBuildList(buildData)
    local function sortFunc(a,b)
        local aunlock = self:isBuildEndUnLock(a)
        local bunlock = self:isBuildEndUnLock(b)
        local ahave = 0;
        local bhave = 0;
        if aunlock then ahave = 1;end
        if bunlock then bhave = 1;end

        if ahave == bhave then
            return a.buildId < b.buildId;
        else
            return ahave > bhave;
        end
    end

    table.sort(buildData,sortFunc);
end

function DatingDataMgr:getBuildDayScripInfo(buildId,roleId)
    roleId = roleId or RoleDataMgr:getCurId()
    if self.dayScriptEndInfos[roleId] then
        return self.dayScriptEndInfos[roleId][buildId]
    end
end

function DatingDataMgr:getBuildEndList(buildId,roleId)
    roleId = roleId or RoleDataMgr:getCurId()
    if self.dayScriptEndInfos[roleId][buildId] then
        return self.dayScriptEndInfos[roleId][buildId].endList
    end
end

function DatingDataMgr:getBuildEndProcess(buildId,roleId)
    roleId = roleId or RoleDataMgr:getCurId()
    if self.dayScriptEndInfos[roleId][buildId] then
        return self.dayScriptEndInfos[roleId][buildId].process
    end
end

function DatingDataMgr:getBuildEndUnLockFavorLevel(buildId,roleId)
    roleId = roleId or RoleDataMgr:getCurId()
    if self.dayScriptEndInfos[roleId][buildId] then
        return self.dayScriptEndInfos[roleId][buildId].favorLevel
    end
end

function DatingDataMgr:getBuildIcon(buildId,roleId)
    roleId = roleId or RoleDataMgr:getCurId()
    if self.dayScriptEndInfos[roleId][buildId] then
        return self.dayScriptEndInfos[roleId][buildId].buildIcon
    end
end

function DatingDataMgr:getBuildIcon2(buildId,roleId)
    roleId = roleId or RoleDataMgr:getCurId()
    if self.dayScriptEndInfos[roleId][buildId] then
        return self.dayScriptEndInfos[roleId][buildId].icon
    end
end

function DatingDataMgr:getBuildSmallIcon(buildId,roleId)
    roleId = roleId or RoleDataMgr:getCurId()
    if self.dayScriptEndInfos[roleId][buildId] then
        return self.dayScriptEndInfos[roleId][buildId].smallIcon
    end
end

function DatingDataMgr:isBuildEndUnLock(buildInfo)
    local isFavorPass = buildInfo.isFavorPass
    local isFubenPass = buildInfo.isFubenPass

    return isFavorPass and isFubenPass
end

function DatingDataMgr:getEndInfoByIdx(buildId,endIdx,roleId)
    roleId = roleId or RoleDataMgr:getCurId()
    if self.dayScriptEndInfos[roleId][buildId] then
        return self.dayScriptEndInfos[roleId][buildId].endList[endIdx]
    end
end

function DatingDataMgr:getEndInfoByType(buildId,endType,roleId)
    roleId = roleId or RoleDataMgr:getCurId()
    if self.dayScriptEndInfos[roleId][buildId] then
        local endList = self.dayScriptEndInfos[roleId][buildId].endList
        for i,v in ipairs(endList) do
            if v.type == endType then
            return v
            end
        end
    end
end

function DatingDataMgr:getEndTitleList(endInfo)
    if endInfo then
        return endInfo.endTitleList
    end
end

function DatingDataMgr:getEndProcess(endInfo)
    if endInfo then
        return endInfo.process
    end
end

function DatingDataMgr:getEndIdList(endInfo)
    if endInfo then
        local list = {}
        for i, v in ipairs(endInfo.endList) do
            for fi, fv in ipairs(v.list) do
                table.insert(list, fv)
            end
        end

        return list
    end
end

function DatingDataMgr:getEndFinishIdList(endInfo)
    if endInfo then
        local finishList = {}
        for i, v in ipairs(endInfo.endList) do
            for fi, fv in ipairs(v.finishList) do
                table.insert(finishList, fv)
            end
        end

        return finishList
    end
end

function DatingDataMgr:getBuildAllEndInfoList(buildId,roleId)
    local endList = self:getBuildEndList(buildId,roleId)
    local bAllEndList = {}
    for i,v in ipairs(endList) do
        local endInfo = v
        local infoList = self:getEndInfoList(endInfo)
        for idx,uEndInfo in ipairs(infoList) do
            -- uEndInfo.isFinsh --�Ƿ����
            -- uEndInfo.endId  --���ID
            -- uEndInfo.desId  --��ֱ��⣨˵����
            -- uEndInfo.type   --�������
            table.insert(bAllEndList,uEndInfo)
        end
    end
    return bAllEndList
end

function DatingDataMgr:getEndInfoList(endInfo)
    if endInfo then
        return endInfo.infoList
    end
end

function DatingDataMgr:getuEndInfoByIdx(endInfo,uEndInfoIdx)
    local info = nil
    if endInfo then
        info = endInfo.infoList[uEndInfoIdx]
    else
        return info
    end
-- info.isFinsh --�Ƿ����
-- info.endId  --���ID
-- info.desId  --��ֱ��⣨˵����
-- info.type   --�������
    return info
end

function DatingDataMgr:getuEndInfoByEndId(endInfo,endId)
    local info = nil
    if endInfo then
        for i,v in ipairs(endInfo.infoList) do
            if v.endId == endId then
                info = v
                return info
            end
        end
    else
        return info
    end
    return info
end

function DatingDataMgr:getEndTypeConfig(endType)
    return self.endTypeConfig_[endType]
end

function DatingDataMgr:getEndTypeConfigEndName(endType)
    return TextDataMgr:getText(self.endTypeConfig_[endType].endName)
end

function DatingDataMgr:getEndTypeConfigEndVoiceType(endType)
    print("getEndTypeConfigEndVoiceType endType ",endType)
    return self.endTypeConfig_[endType].endVoiceType
end

function DatingDataMgr:getEndTypeConfigEndActionName(endType)
    print("getEndTypeConfigEndActionName endType ",endType)
    return self.endTypeConfig_[endType].endActionName
end

function DatingDataMgr:getEndTypeConfigHead(endType)
    return self.endTypeConfig_[endType].headPath
end

function DatingDataMgr:getEndTypeConfigIcon(endType)
    return self.endTypeConfig_[endType].endIcon
end

function DatingDataMgr:getDatingSettlementMsg()
    return clone(self.datingSettlementMsg)
end

function DatingDataMgr:clearDatingSettlementMsg()
    self.datingSettlementMsg = {}
end

function DatingDataMgr:initRoleSetData()
    local roleSet = TabDataMgr:getData("RoleSet")
    self.roleSet_ = {}
    for k, v in pairs(roleSet) do
        self.roleSet_[v.place] = v
    end
end

function DatingDataMgr:getRoleSetCfg(id)
    if id then
        return self.roleSet_[id]
    else
        return self.roleSet_
    end
end

function DatingDataMgr:buyDayDatingTimes()
    -- StoreDataMgr:send_PLAYER_REQ_BUY_RESOURCES(EC_SItemType.DAYDATINGTIMES)
    --ʹ��itemRecover��Ӧ��cid�ݲ�ʹ�õ���id
    StoreDataMgr:send_PLAYER_REQ_BUY_RESOURCES(2)
end

function DatingDataMgr:getDayDatingTimes()
    return GoodsDataMgr:getItemCount(EC_SItemType.DAYDATINGTIMES)
end

function DatingDataMgr:getDayDatingMaxTimes()
    local data = GoodsDataMgr:getItemCfg(EC_SItemType.DAYDATINGTIMES)
    return data.totalMax
end

function DatingDataMgr:getDayDatingExchangeTimes()
    local itemRecoverCfg = StoreDataMgr:getItemRecoverCfg(2)
    if itemRecoverCfg.price then
        return #itemRecoverCfg.price
    else
        return 0
    end
end

function DatingDataMgr:setScriptTableName(name)
    self.scriptTableName = name
end

function DatingDataMgr:getScriptTableName()
    return self.scriptTableName
end

function DatingDataMgr:getReserveScriptTime()
    local reserveRoleId = nil
    for i,v in ipairs(RoleDataMgr:getRoleIdList()) do
        local roleId = v
        local info = self:getCityDatingInfoByRuleCid(EC_DatingScriptType.RESERVE_SCRIPT,roleId)
        if info then
            reserveRoleId = roleId
            break
        end
    end
    if not reserveRoleId then
        return
    end
    local buildId = DatingDataMgr:getCityDatingBuildId(EC_DatingScriptType.RESERVE_SCRIPT,reserveRoleId)
    local uState = self:getCityDatingUState(EC_DatingScriptType.RESERVE_SCRIPT,buildId)
    if uState == EC_CityDatingState.accept then
        local reserveDatingInfo = {}
        local timeStr = nil
        local datingTimeFrame = DatingDataMgr:getCityDatingTimeFrame(EC_DatingScriptType.RESERVE_SCRIPT,reserveRoleId)
        timeStr = timeStr .. string.format("%02d",datingTimeFrame[1]) .. ":"
        timeStr = timeStr .. string.format("%02d",datingTimeFrame[2]) .. "-"
        timeStr = timeStr .. string.format("%02d",datingTimeFrame[3]) .. ":"
        timeStr = timeStr .. string.format("%02d",datingTimeFrame[4]) .. ""

        reserveDatingInfo.timeStr = timeStr
        reserveDatingInfo.buildId = buildId
        reserveDatingInfo.roleId = reserveRoleId

        return reserveDatingInfo
    end
end

function DatingDataMgr:reset()
    --�Ѿ�ͨ���ľ���
    self.finishScriptIds = {}
    self.favorScriptReward = {}
    --�Ѿ�ͨ�����ճ����
    self.dayScriptEndIds = {}
    self.dayScriptEndInfos = {}
    self.datingSettlementMsg = {}
    self.datingType = EC_DatingScriptType.MAIN_SCRIPT
    self.curDatingScript = {}
    self.reviewTable = {}

    self.notFinishDatingInfoList = {}
    self.cityDatingInfoList = {}
    self.finishDayScriptEndId = 0
    self.defaultScore = 60
    self:initDayScriptEnds()
end

function DatingDataMgr:onLoginOut()
    self:reset();
end

function DatingDataMgr:triggerDating( _cname, triggerType, triggerParam )
    -- body
    if self.isDating then return end
    local triggerCfgs = TabDataMgr:getData("DatingTrigger")
    for k,v in ipairs(triggerCfgs) do
        if (v.fileName == "all" or v.fileName == _cname) and triggerType == v.triggerType then
            local trigger = true
            if v.triggerParam then
                for _k,_v in pairs(v.triggerParam) do
                    if triggerParam and triggerParam[_k] ~= _v then
                        trigger = false
                    end
                 end
            end

            if not v.isRepeatable and self:checkScriptIdIsFinish(v.datingRuleId) then -- 能否重复触发逻辑
               trigger = false
            end

            if trigger then
                self:setIsDating(true)
                if self:checkIsSingleDating(v.datingRuleId) then
                    Utils:setLocalSettingValue("singleDating"..v.datingRuleId,"true")
                end
                self:startDating(v.datingRuleId)
                break;
            end

        end
    end
end

function DatingDataMgr:getFavorRewardList( )
    return self.favorScriptReward
end

function DatingDataMgr:sendReqReceiveNewFavorAward( awardId )
    local msg = {awardId}
    TFDirector:send(c2s.DATING_REQ_RECEIVE_NEW_FAVOR_AWARD, msg)
end

function DatingDataMgr:onResReceiveNewFavorAward( event )
    local data = event.data
    local awardId = data.awardId

    local mainDatingMap_ = TabDataMgr:getData("FavorNew")
    local roleId = mainDatingMap_[awardId].role
    local exitRole = false
    for _, _info in ipairs(self.favorScriptReward) do
        if _info.roleId == roleId then
            local tmpArr = _info.awardId or {}
            local exit = false
            for k, v in ipairs(_info.awardId or {}) do
                if v == awardId then
                    exit = true
                    break
                end
            end
            if not exit then
                table.insert(tmpArr, awardId)
            end
            _info.awardId = tmpArr

            exitRole = true
        end
    end

    if not exitRole then
        table.insert(self.favorScriptReward, {roleId = roleId, awardId = {awardId}})
    end

    Utils:showReward(data.rewards)
    EventMgr:dispatchEvent(EV_GETFAVORDATING_REWARD)
end

return DatingDataMgr:new()
