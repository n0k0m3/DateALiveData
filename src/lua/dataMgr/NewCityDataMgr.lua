local BaseDataMgr = import(".BaseDataMgr")
local NewCityDataMgr = class("NewCityDataMgr", BaseDataMgr)

function NewCityDataMgr:ctor()
    self:init()
    self:reset()
end

function NewCityDataMgr:init()
    self.newBuildTb = TabDataMgr:getData("NewBuild")
    local basicity = TabDataMgr:getData("BasicCity")
    self.basicCityTb = {}
    for k, v in pairs(basicity) do
        self.basicCityTb[v.cityID] = self.basicCityTb[v.cityID] or {}
        self.basicCityTb[v.cityID][v.role] = clone(v)
    end
end

function NewCityDataMgr:reset()
    self.normalCityData = {dayType = 0, buildData = {}, roleData = {}}
    self.remindEvents = {build = {}, buildfuns = {}, role = {}}
    self.remindCount = 0

    self.outsideCityDmata = {buildData = {}, roleData = {}}--外传城建数据
    self.mainCityData = {buildData = {}, roleData = {}}--主线约会城建数据
    self.fubenCityData = {buildData = {}, roleData = {}}--副本约会城建数据
    self.outsideConfList = {}
    self.outsideDataList = {}
    self.mainLineDataList = {}
    self.fuBenDataList = {}
    self.tmpScriptSettlement = {}--剧本获得消耗内容结算整合（整合内容在剧本结束后显示）
    self.buildExtraFuncs = {}

    self.curEntranceConf = nil
    self.curEntranceType = EC_OutsideChoiceType.OutsideChoiceScript

    self.curEntranceId = 1
    self.curOutsideId = 0
    self.curMainLineId = 0
    self.curFubenLineId = 0
    self.curCityType = EC_NewCityType.NewCity_Normal
    self.curDatingCityType = EC_NewCityType.NewCity_Normal
    self.lastMainLineQuality = {}

    self.guideData = nil

    self.scriptFinishCallBack = nil

    self.pre_open_param = nil
end

function NewCityDataMgr:onLogin()
    TFDirector:addProto(s2c.EXTRA_DATING_RESP_OUTSIDE_ACTIVE_INFO, self, self.onRespOutsideActiveInfo)
    TFDirector:addProto(s2c.EXTRA_DATING_RESP_MAIN_INFO, self, self.onRespDatingMainInfo)
    TFDirector:addProto(s2c.EXTRA_DATING_RESP_ENTRANCE_EVENT_CHOICES, self, self.onRespEntranceStart)
    TFDirector:addProto(s2c.EXTRA_DATING_RESP_CHOICES, self, self.onRespEntranceChoices)
    TFDirector:addProto(s2c.EXTRA_DATING_RESP_ENTRANCE_EVENT_CHOOSED, self, self.onRespEntranceEventChoosed)
    TFDirector:addProto(s2c.EXTRA_DATING_SETTLE_INFO, self, self.onRespUpdateDatingMainInfo)
    TFDirector:addProto(s2c.NEW_BUILDING_RESP_GET_ALL_BUILDING_INFO, self, self.onRespNewCityInfo)
    TFDirector:addProto(s2c.NEW_BUILDING_RESP_UPDATE_BUILDING_INFO, self, self.onRespNewCityUpdate)
    TFDirector:addProto(s2c.EXTRA_DATING_RES_FAVOR_DATING_TEST_INFO, self, self.onRespFavorDatingTestInfo)
    TFDirector:addProto(s2c.NEW_BUILDING_RESP_REMIND_SUCCESS, self, self.onRespRemindEventResult)
    TFDirector:addProto(s2c.EXTRA_DATING_RESP_ENTER, self, self.onRespEnterResult)

    --TFDirector:send(c2s.EXTRA_DATING_REQ_OUTSIDE_ACTIVE_INFO, {})--外传活动开放状态
    TFDirector:send(c2s.NEW_BUILDING_REQ_GET_ALL_BUILDING_INFO, {})


    local currectScene = Public:currentScene()
    if currentScene and currentScene.__cname == "NewCityMainScene" then
        TFDirector:send(c2s.SHARE_REQ_INTO_PANEL,{1})
    end

    return {s2c.NEW_BUILDING_RESP_GET_ALL_BUILDING_INFO}
end

function NewCityDataMgr:enterNewCity(citytype, stageid)
    self.curCityType = citytype or EC_NewCityType.NewCity_Normal
    self.curDatingCityType = self.curCityType
    local newCityResLoader = require("lua.logic.newCity.NewCityResLoader")
    if self.curCityType == EC_NewCityType.NewCity_Update then
        newCityResLoader.loadAllRes(clone(self:getCitydata().roleData), EC_NewCityLoadType.Update)
    elseif self.curCityType == EC_NewCityType.NewCity_Normal then
        newCityResLoader.loadAllRes(clone(self:getCitydata().roleData))
    elseif self.curCityType == EC_NewCityType.NewCity_MainLine then
        newCityResLoader.loadAllRes(clone(self.mainCityData.roleData))
    elseif self.curCityType == EC_NewCityType.NewCity_Outside then
        newCityResLoader.loadAllRes(clone(self.outsideCityData.roleData))
    elseif self.curCityType == EC_NewCityType.NewCity_FuBen then
        newCityResLoader.loadAllRes(clone(self.fubenCityData.roleData))
    end
end

function NewCityDataMgr:startEntrance(entranceconf, entrancetype)
    self:sendStartEntranceEvent(entranceconf.id)
    self:setCurEntrance(entranceconf, entrancetype)
    dump(entranceconf, "startEntrance data")
end

function NewCityDataMgr:checkScriptFinishCallBack()
    if self.scriptFinishCallBack then
        self.scriptFinishCallBack()
    end
    self.scriptFinishCallBack = nil
end

function NewCityDataMgr:isHaveScriptFinishCallBack()
    if self.scriptFinishCallBack then
        return true
    end
    return false
end

function NewCityDataMgr:setScriptFinishCallBack(callback)
    self.scriptFinishCallBack = callback
end

function NewCityDataMgr:setCurEntranceId(entranceid)
    self.curEntranceId = entranceid or 1
end

function NewCityDataMgr:setCurEntrance(entranceconf, entrancetype)
    self.curEntranceConf = entranceconf or {}
    self.curEntranceType = entrancetype or EC_DatingChoiceType.ChoiceScript
end

function NewCityDataMgr:getTempScriptSettlement()
    local tmp = clone(self.tmpScriptSettlement)
    return tmp
end

function NewCityDataMgr:getDatingValue(ctype)
    ctype = ctype or self.curDatingCityType
    if ctype == EC_NewCityType.NewCity_Outside then
        return self.curOutsideId
    elseif ctype == EC_NewCityType.NewCity_MainLine then
        return self.curMainLineId
    elseif ctype == EC_NewCityType.NewCity_FuBen then
        return self.curFubenLineId
    end
end

function NewCityDataMgr:getCityDay()
    if self.curCityType == EC_NewCityType.NewCity_Normal or self.curCityType == EC_NewCityType.NewCity_Update then
        return self.normalCityData.dayType    
    else
        return EC_NewCityDayType.Day_Light
    end
end

function NewCityDataMgr:getBuildFuncIsOpen(funcid)
    for k, v in pairs(self.normalCityData.buildData) do
        if v.buildingFuns then
            for fi, fv in ipairs(v.buildingFuns) do
                if fv == funcid then
                    return true
                end
            end
        end
    end
    return false
end

function NewCityDataMgr:getCityBuildIsUnlock(bid)
    local builddata = self.normalCityData.buildData[bid]
    if builddata then
        local islock = builddata.isUnlock
        return islock
    end
    return false
end

function NewCityDataMgr:getCitydata()
    if self.curCityType == EC_NewCityType.NewCity_Normal or self.curCityType == EC_NewCityType.NewCity_Update then
        -- 手动添加年兽数据
        local function getNianshouData()
            local actionInfos = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.NEWYEARDATING)
            local newData = clone(self.normalCityData)
            newData.roleData = newData.roleData or {}
            local function aiLineGet(cityRoleId)
                local ailines = {normal={}, click={}, state={}}
                local cityroleconf = TabDataMgr:getData("CityRole", cityRoleId)
                if cityroleconf then
                    local normal = cityroleconf.dialog or {}
                    for i, v in ipairs(normal) do
                        local line = clone(TabDataMgr:getData("CityLines", v).cityLines) or {}
                        table.insert(ailines.normal, line)
                    end
                    local click = cityroleconf.clickDialog or {}
                    for i, v in ipairs(click) do
                        local line = clone(TabDataMgr:getData("CityLines", v).cityLines) or {}
                        table.insert(ailines.click, line)
                    end
                    local state = cityroleconf.specialDialog or {}
                    for i, sv in ipairs(state) do
                        local slines = {}
                        for i, v in ipairs(sv) do
                            local line = clone(TabDataMgr:getData("CityLines", v).cityLines) or {}
                            table.insert(slines, line)
                        end
                        ailines.state[k] = slines
                    end
                end
                return ailines
            end

            for k,v in pairs(actionInfos) do
                v = ActivityDataMgr2:getActivityInfo(v)
                local hasNianshou = ActivityDataMgr2:getNianShouState( )
                if hasNianshou then
                    local bid = v.extendData.buildingId 
                    local nianshouCfg = TabDataMgr:getData("NianBeast", v.extendData.nianBeastId)
                    newData.roleData[bid] = newData.roleData[bid] or {}
                    local shapev = {}
                    shapev.dressId = nianshouCfg.cityrolemodel
                    shapev.buildingId = bid
                    shapev.randomSeed = v.extendData.randomSeed
                    shapev.datingRuleId = v.extendData.datingId
                    shapev.jumpParamters = v.extendData.jumpParamters or {}
                    shapev.activityId = v.id
                    local roleconf = clone(TabDataMgr:getData("CityRoleModel", nianshouCfg.modelId))
                    shapev.roleType = roleconf.roleType
                    shapev.rolePath = roleconf.rolePath
                    shapev.iconPos = roleconf.iconPos
                    shapev.isFlip = roleconf.flip
                    shapev.modeHead = roleconf.modeHead
                    shapev.roleId = roleconf.modelId
                    shapev.aiWord = aiLineGet(nianshouCfg.cityRoleId)
                    table.insert(newData.roleData[bid],shapev)
                end
            end
            return newData
        end
        return getNianshouData()
    elseif self.curCityType == EC_NewCityType.NewCity_MainLine then
        return self.mainCityData
    elseif self.curCityType == EC_NewCityType.NewCity_Outside then
        return self.outsideCityData
    elseif self.curCityType == EC_NewCityType.NewCity_FuBen then
        return self.fubenCityData
    end
end

function NewCityDataMgr:getDatingLineData()
    if self.curDatingCityType == EC_NewCityType.NewCity_MainLine then
        return self:getMainLineData()
    elseif self.curDatingCityType == EC_NewCityType.NewCity_Outside then
        return self:getOutsideData()
    elseif self.curDatingCityType == EC_NewCityType.NewCity_FuBen then
        return self:getFubenLineData()
    end
    return {}
end

function NewCityDataMgr:getMainLineData()
    return self.mainLineDataList[self.curMainLineId]
end

function NewCityDataMgr:getOutsideData()
    return self.outsideDataList[self.curOutsideId]
end

function NewCityDataMgr:getFubenLineData()
    return self.fuBenDataList[self.curFubenLineId]
end

function NewCityDataMgr:getMainLineBagItemCount(cid)
    local curbag = self.mainLineDataList[self.curMainLineId].bag
    for i,v in ipairs(curbag) do
        if v.id == cid then
            return v.num
        end
    end
    return 0
end

function NewCityDataMgr:getOutsideBagItemCount(cid)
    local curbag = self.outsideDataList[self.curOutsideId].bag
    for i,v in ipairs(curbag) do
        if v.id == cid then
            return v.num
        end
    end
    return 0
end

function NewCityDataMgr:getEntranceConf(entranceid, ctype)
    ctype = ctype or self.curDatingCityType
    local conf = nil
    if ctype == EC_NewCityType.NewCity_MainLine then
        conf = TabDataMgr:getData("FavorScript", entranceid)
    elseif ctype == EC_NewCityType.NewCity_Outside then
        conf = TabDataMgr:getData("OutsideScript", entranceid)
    elseif ctype == EC_NewCityType.NewCity_FuBen then
        conf = TabDataMgr:getData("NovelScript", entranceid)
    end
    return clone(conf) or {}
end

function NewCityDataMgr:getRemindEvents()
    return self.remindEvents
end

function NewCityDataMgr:isHaveRemindEvents()
    return self.remindCount > 0
end

function NewCityDataMgr:isFirtBegenDating(data)
    if data.entrances then
        local entranceconf = self:getEntranceConf(data.entrances[1].entranceId, data.datingType)
        if entranceconf.bindBuild <= 0 and entranceconf.bindRole <= 0 then
            return true, entranceconf
        end
    end
    return false, {}
end

function NewCityDataMgr:checkBuildRedPoint(bid)
    if self.curCityType == EC_NewCityType.NewCity_Normal or self.curCityType == EC_NewCityType.NewCity_Update then
        return false
    elseif self.curCityType == EC_NewCityType.NewCity_MainLine then
        local entrances = self.mainLineDataList[self.curMainLineId].entrances or {}
        for i, v in ipairs(entrances) do
            local conf = self:getEntranceConf(v.entranceId, EC_NewCityType.NewCity_MainLine)
            if conf.bindBuild == bid and conf.eventType ~= 2 then
                return true
            end
        end
    elseif self.curCityType == EC_NewCityType.NewCity_Outside then
        local entrances = self.outsideDataList[self.curOutsideId].entrances or {}
        for i, v in ipairs(entrances) do
            local conf = self:getEntranceConf(v.entranceId, EC_NewCityType.NewCity_Outside)
            if conf.bindBuild == bid and conf.eventType ~= 2 then
                return true
            end
        end
    end
    return false
end

function NewCityDataMgr:getBuildExtraFunc(bid)
    return self.buildExtraFuncs[bid] or {}
end

function NewCityDataMgr:clearBuildExtraFunc()
    self.buildExtraFuncs = {}
end

function NewCityDataMgr:addBuildExtraFunc(bid, funcname, func)
    self.buildExtraFuncs[bid] = self.buildExtraFuncs[bid] or {}
    table.insert(self.buildExtraFuncs[bid], {name = funcname, callback = func})
end

--请求提醒事件已经完成
function NewCityDataMgr:sendFinishRemindMsg(eventtype)
    TFDirector:send(c2s.NEW_BUILDING_REQ_REMIND_SUCCESS, {eventtype})
end

--请求主线，外传，副本约会城建数据 5633
function NewCityDataMgr:sendGetCitySetpData(ctype, sid, roleid)
    local msg = {
        ctype,
        sid,
        roleid or 0
    }
    TFDirector:send(c2s.EXTRA_DATING_REQ_EXTRA_DATING_INFO, msg)
    self.curDatingCityType = ctype
    self.scriptFinishCallBack = nil
end

--请求开始主线，外传，副本事件 5634
function NewCityDataMgr:sendStartEntranceEvent(entranceid)
    --required int32 datingType = 1; //约会类型1 外传 2 主线
    --required int32 entranceId = 2; //入口id
    --required int32 datingValue = 3; //当类型为外传时,值传外传ID,主线则为主线章节
    if not entranceid then
        return
    end
    self.tmpScriptSettlement = {}
    self:setCurEntranceId(entranceid)
    local datingValue = self:getDatingValue()
    if not datingValue then
        return
    end

    local msg = {
        self.curDatingCityType,
        datingValue,
        entranceid,
    }
    TFDirector:send(c2s.EXTRA_DATING_REQ_START_ENTRANCE_EVENT, msg)
end

--发送事件过程选项选择 5635 eventId[事件id或剧本id], choiceType[剧本1/信息2], choice[选择项索引]
function NewCityDataMgr:sendChooseEntranceEvent(eventId, choiceType, choice)
    local msg = {
        self.curDatingCityType,
        self:getDatingValue(),
        eventId,
        self.curEntranceId,
        choiceType,
        choice or 1,
    }
    TFDirector:send(c2s.EXTRA_DATING_REQ_CHOOSE_ENTRANCE_EVENT, msg)
end

--请求事件过程选项信息 5640 eventId[事件id或剧本id], choiceType[剧本1/信息2]
function NewCityDataMgr:sendGetEntranceEventChoices(eventId, choiceType)
    local msg = {
        self.curDatingCityType,
        self:getDatingValue(),
        eventId,
        choiceType,
    }
    TFDirector:send(c2s.EXTRA_DATING_REQ_GET_EVENT_CHOICES, msg)
end

--5660 主线获取数据，测试用
function NewCityDataMgr:sendGetFavorTestInfo(favorid)
    local msg = {
        RoleDataMgr:getCurId(),
        favorid,
    }
    TFDirector:send(c2s.EXTRA_DATING_REQ_FAVOR_DATING_TEST_INFO, msg)
end

--5662
function NewCityDataMgr:sendEnterMainLineDating()
    local msg = {
        self.curMainLineId
    }
    TFDirector:send(c2s.EXTRA_DATING_REQ_ENTER, msg)
end

--2071
function NewCityDataMgr:onRespNewCityInfo(tData)
    local data = tData.data or {}
    self:parseCityData(data, true)
end

--2072
function NewCityDataMgr:onRespNewCityUpdate(tData)
    local data = tData.data or {}
    self:parseCityData(data, true)
end

--2073
function NewCityDataMgr:onRespRemindEventResult(tData)
    local data = tData.data or {}
    if data.isSuccess then
        if data.eventType == EC_NewCityRemindType.Build then
            self.remindEvents.build = {}
        elseif data.eventType == EC_NewCityRemindType.BuildFuncs then
            self.remindEvents.buildfuns = {}
        elseif data.eventType == EC_NewCityRemindType.Role then
            self.remindEvents.role = {}
        end
        EventMgr:dispatchEvent(EV_NEW_CITY.cityRemindEventSuccess)
        self.remindCount = #self.remindEvents.build + #self.remindEvents.buildfuns + #self.remindEvents.role
    end
end

--5639 外传开放信息
function NewCityDataMgr:onRespOutsideActiveInfo(tData)
    local data = tData.data or {}
    data.activeOutsideIds = data.activeOutsideIds or {}
    local outsidetb = TabDataMgr:getData("Outside")
    self.outsideConfList = {}
    for k,table_v in pairs(outsidetb) do
        local key = table_v.outsideId
        self.outsideConfList[key] = {active = false, tbconfig = clone(table_v)}
        for i,ids_v in ipairs(data.activeOutsideIds) do
            if table_v.id == ids_v then
                self.outsideConfList[key].active = true
                break
            end
        end
    end
end

--5633
function NewCityDataMgr:onRespDatingMainInfo(tData)
    local data = tData.data.info or {}
    --dump(data,  "5633 data")
    if data.datingType == EC_NewCityType.NewCity_MainLine then
        self.curMainLineId = data.datingValue
        self.mainLineDataList[data.datingValue] = nil
        self.mainLineDataList[data.datingValue] = clone(data)
        local mainData = self.mainLineDataList[data.datingValue]
        mainData.quality = {}
        data.quality = data.quality or {}
        for i, v in ipairs(data.quality) do
            mainData.quality[v.qualityId] = mainData.quality[v.qualityId] or {}
            mainData.quality[v.qualityId].qualityId = v.qualityId
            mainData.quality[v.qualityId].addvalue = 0
            mainData.quality[v.qualityId].value = v.value
        end
        mainData.stepId = TabDataMgr:getData("FavorScript", mainData.entrances[1].entranceId).stepId
        self.mainCityData = self:constructCityData(data.datingType, mainData)
        EventMgr:dispatchEvent(EV_NEWCITY_DATING_EVENT.recvDatingLineStepInfo, data)
    elseif data.datingType == EC_NewCityType.NewCity_Outside then
        self.curOutsideId = data.datingValue
        self.outsideDataList[data.datingValue] = nil
        self.outsideDataList[data.datingValue] = clone(data)
        local outsideData = self.mainLineDataList[data.datingValue]
        outsideData.stepId = TabDataMgr:getData("OutsideScript", outsideData.entrances[1].entranceId).stepId
        self.outsideCityData = self:constructCityData(data.datingType, outsideData)
    elseif data.datingType == EC_NewCityType.NewCity_FuBen then
        self.curFubenLineId = data.datingValue
        self.fuBenDataList[data.datingValue] = nil
        self.fuBenDataList[data.datingValue] = clone(data)
        local fubenData = self.fuBenDataList[data.datingValue]
        fubenData.stepId = TabDataMgr:getData("NovelScript", fubenData.entrances[1].entranceId).stepId
        self.fubenCityData = self:constructCityData(data.datingType, fubenData)

        local isFirst, etranceconf = self:isFirtBegenDating(data)
        if isFirst then
            self:startEntrance(etranceconf, EC_DatingChoiceType.ChoiceScript)
        else
            self:enterNewCity(EC_NewCityType.NewCity_FuBen)
        end
    end
    self.tmpScriptSettlement = {}
end

--5634
function NewCityDataMgr:onRespEntranceStart(tData)
    local isfirst = tData.data.first
    dump(self.curEntranceConf, "Entrance Start")
    if self.curEntranceType == EC_DatingChoiceType.ChoiceMessage then
        Utils:openView("newCity.NewCityMessageView", self.curEntranceConf.message)
    elseif self.curEntranceType == EC_DatingChoiceType.ChoiceScript then
        if self.curDatingCityType == EC_NewCityType.NewCity_MainLine then
            local tablename = TabDataMgr:getData("Favor", self.curMainLineId).callTableNameF
            DatingDataMgr:setScriptTableName(tablename)
            DatingDataMgr:showDatingLayer(EC_DatingScriptType.MAIN_SCRIPT, self.curEntranceConf.startId, nil, nil, nil, isfirst)
        elseif self.curDatingCityType == EC_NewCityType.NewCity_Outside then
            local tablename = TabDataMgr:getData("Outside", self.curOutsideId).callTableNameF
            DatingDataMgr:setScriptTableName(tablename)
            DatingDataMgr:showDatingLayer(EC_DatingScriptType.OUTSIDE_SCRIPT, self.curEntranceConf.startId, nil, nil, nil, isfirst)
        elseif self.curDatingCityType == EC_NewCityType.NewCity_FuBen then
            local tablename = TabDataMgr:getData("Novel", self.curFubenLineId).callTableNameF
            DatingDataMgr:setScriptTableName(tablename)
            DatingDataMgr:showDatingLayer(EC_DatingScriptType.FUBEN_CITY_SCRIPT, self.curEntranceConf.startId, nil, nil, nil, isfirst)
        end
    end
end

--5640
function NewCityDataMgr:onRespEntranceChoices(tData)
    local data = tData.data.eventId or {}
    EventMgr:dispatchEvent(EV_NEWCITY_DATING_EVENT.OptionChoiceStatus, data)
end

--5635
function NewCityDataMgr:onRespEntranceEventChoosed(tData)
    local data = tData.data or {}
    --重构结算内容（服务器只发消耗和获得的物品）
    local refactorSettlementData = function (orgdata)
        if orgdata.costItems then--有消耗
            self.tmpScriptSettlement.cost = {costItems=clone(orgdata.costItems), items=clone(orgdata.items)}--clone(orgdata)
        end
        if orgdata.stepEnd then--是否是最终结算
            self.tmpScriptSettlement.endId = orgdata.endId
            self.tmpScriptSettlement.finalReward = self.tmpScriptSettlement.finalReward or {}
            local refactorFinalReward = function (fincaldata)
                if fincaldata then
                    local dressData = TabDataMgr:getData("Dress")
                    for i,v in ipairs(fincaldata) do
                        local itemCfg = GoodsDataMgr:getItemCfg(v.id)
                        if itemCfg then
                            if itemCfg.superType == EC_ResourceType.SKIN then
                                v.iconPath = itemCfg.icon
                                v.superType = itemCfg.superType
                                self.tmpScriptSettlement.finalCgs = self.tmpScriptSettlement.finalCgs or {}
                                table.insert(self.tmpScriptSettlement.finalCgs,clone(v))
                            else
                                table.insert(self.tmpScriptSettlement.finalReward,clone(v))
                            end
                        elseif dressData[v.id] then
                            v.iconPath = itemCfg.icon
                            v.superType = itemCfg.superType
                            self.tmpScriptSettlement.finalCgs = self.tmpScriptSettlement.finalCgs or {}
                            table.insert(self.tmpScriptSettlement.finalCgs,clone(v))
                        end
                    end
                end
            end
            refactorFinalReward(orgdata.items)
            refactorFinalReward(orgdata.endItems)
        else
            if orgdata.items then
                for i,v in ipairs(orgdata.items) do
                    self.tmpScriptSettlement.reward = self.tmpScriptSettlement.reward or {}
                    table.insert(self.tmpScriptSettlement.reward,clone(v))
                end
            end
        end
    end

    if self.curEntranceType == EC_DatingChoiceType.ChoiceScript then
        refactorSettlementData(data)
        EventMgr:dispatchEvent(EV_NEWCITY_DATING_EVENT.ScriptChoiceResult, data.quality)
    elseif self.curEntranceType == EC_DatingChoiceType.ChoiceMessage then
        if data.costItems then
            Utils:openView("newCity.NewCityEventSettlementView", {costItems=data.costItems, items=data.items}, true)
        elseif data.items then
            Utils:openView("newCity.NewCityRewardView", data.items, true)
        end
    end
end

--5637
function NewCityDataMgr:onRespUpdateDatingMainInfo(tData)
    local data = tData.data.info or {}
    dump(data, " 5637 data")
    local updateMainLine = function(data)
        local curdata = self.mainLineDataList[data.datingValue]
        local stepid = nil
        local curstepid = curdata.stepId
        if data.entrances and #data.entrances > 0 then
            stepid = TabDataMgr:getData("FavorScript", data.entrances[1].entranceId).stepId
        end
        curdata.bag = data.bag or {}
        curdata.endings = data.endings or curdata.endings
        curdata.entrances = data.entrances or curdata.entrances
        if data.quality then
            self.lastMainLineQuality = self.lastMainLineQuality or {}
            self.lastMainLineQuality[data.datingValue] = clone(curdata.quality)
        end
        data.quality = data.quality or {}
        for i, newv in ipairs(data.quality) do
            curdata.quality[newv.qualityId] = curdata.quality[newv.qualityId] or {}
            local curvalue = curdata.quality[newv.qualityId].value or 0
            curdata.quality[newv.qualityId].qualityId = newv.qualityId
            curdata.quality[newv.qualityId].addvalue = newv.value - curvalue
            curdata.quality[newv.qualityId].value = newv.value
        end
        --if data.stepTime ~= curdata.stepTime then
            curdata.stepTime = data.stepTime
            EventMgr:dispatchEvent(EV_NEWCITY_DATING_EVENT.refreshNewCityInfo)
        --end
        curdata.stepId = stepid or curstepid
        self.mainCityData = self:constructCityData(data.datingType, curdata)
        if stepid ~= curstepid then
            self:setScriptFinishCallBack(function()
                self:enterNewCity(data.datingType)
            end)
            return true
        end
        return false
    end

    local updateOutside = function(data)
        local curdata = self.outsideDataList[data.datingValue]
        local stepid = nil
        local curstepid = curdata.stepId
        if data.entrances and #data.entrances > 0 then
            stepid = TabDataMgr:getData("FavorScript", data.entrances[1].entranceId).stepId
        end
        curdata.bag = data.bag or {}
        curdata.endings = data.endings or curdata.endings
        curdata.stepTime = data.stepTime or curdata.stepTime
        curdata.entrances = data.entrances or curdata.entrances
        if data.stepTime ~= curdata.stepTime then
            curdata.stepTime = data.stepTime
            EventMgr:dispatchEvent(EV_NEWCITY_DATING_EVENT.refreshNewCityInfo)
        end
        curdata.stepId = stepid or curstepid
        self.outsideCityData = self:constructCityData(data.datingType, curdata)
        if stepid ~= curstepid then
            self:setScriptFinishCallBack(function()
                self:enterNewCity(data.datingType)
            end)
            return true
        end
        return false
    end

    local updateFuben = function(data)
        local curdata = self.fuBenDataList[data.datingValue]
        local stepid = nil
        local curstepid = curdata.stepId
        if data.entrances and #data.entrances > 0 then
            stepid = TabDataMgr:getData("NovelScript", data.entrances[1].entranceId).stepId
        end
        curdata.bag = data.bag or {}
        curdata.endings = data.endings or curdata.endings
        curdata.stepTime = data.stepTime or curdata.stepTime
        curdata.entrances = data.entrances or curdata.entrances
        if data.stepTime ~= curdata.stepTime then
            curdata.stepTime = data.stepTime
            EventMgr:dispatchEvent(EV_NEWCITY_DATING_EVENT.refreshNewCityInfo)
        end
        curdata.stepId = stepid or curstepid
        self.fubenCityData = self:constructCityData(data.datingType, curdata)
        if stepid ~= curstepid then
            self:setScriptFinishCallBack(function()
                self:enterNewCity(data.datingType)
            end)
            return true
        end
        return false
    end

    local breload = false
    if data.datingType == EC_NewCityType.NewCity_MainLine then
        breload = updateMainLine(data)
    elseif data.datingType == EC_NewCityType.NewCity_Outside then
        breload = updateOutside(data)
    elseif data.datingType == EC_NewCityType.NewCity_FuBen then
        breload = updateFuben(data)
    end

    if not breload then
        EventMgr:dispatchEvent(EV_NEWCITY_DATING_EVENT.refreshNewCityEvent)
    end
end

--5662
function NewCityDataMgr:onRespEnterResult(tData)
    local data = tData.data
    local canEnter = tobool(data.enter)
    if canEnter then
        EventMgr:dispatchEvent(EV_NEW_CITY.enterMainLine)
    else
        Utils:showTips(100000078)
    end
end

--5660 测试
function NewCityDataMgr:onRespFavorDatingTestInfo(tData)
    local data = tData.data or {}
    dump(data, "5660 data")
    EventMgr:dispatchEvent(EV_NEW_CITY.favorDatingTestData, data)
end

--构建主线，外传，副本城建数据
function NewCityDataMgr:constructCityData(ctype, stepData)
    local tname = ""
    if ctype == EC_NewCityType.NewCity_MainLine then
        tname = "Favor"
    elseif ctype == EC_NewCityType.NewCity_Outside then
        tname = "Outside"
    elseif ctype == EC_NewCityType.NewCity_FuBen then
        tname = "Novel"
    end
    local citydata = {buildData = {}, roleData = {}}
    local cityid = TabDataMgr:getData(tname.."Step", stepData.stepId).basicCity
    --建筑，全部解锁处理，没有建筑功能
    for k, v in pairs(self.newBuildTb) do
        local builddata = {}
        builddata.isUnlock = true
        citydata.buildData[v.id] = builddata
    end
    --人物
    local allRole = {}
    local function roleDataSet(build, role)
        local function aiLineGet()
            local ailines = {normal={}, click={}, state={}}
            local normal = self.basicCityTb[cityid][role].dialog or {}
            for i, v in ipairs(normal) do
                local line = clone(TabDataMgr:getData("CityLines", v).cityLines) or {}
                table.insert(ailines.normal, line)
            end
            local click = self.basicCityTb[cityid][role].clickDialog or {}
            for i, v in ipairs(click) do
                local line = clone(TabDataMgr:getData("CityLines", v).cityLines) or {}
                table.insert(ailines.click, line)
            end
            return ailines
        end
        local roledata = {buildingId=build}
        local roleconf = clone(TabDataMgr:getData("CityRoleModel", role))
        roledata.dressId = role
        roledata.roleType = roleconf.roleType
        roledata.rolePath = roleconf.rolePath
        roledata.iconPos = roleconf.iconPos
        roledata.isFlip = roleconf.flip
        roledata.modeHead = roleconf.modeHead
        roledata.roleId = roleconf.modelId
        roledata.aiWord = aiLineGet()--self.basicCityTb[cityid][role].lines
        return roledata
    end
    for i, v in ipairs(stepData.entrances) do
        local entrancedata = TabDataMgr:getData(tname.."Script", v.entranceId)
        if entrancedata.bindRole > 0 then
            allRole[entrancedata.bindRole] = roleDataSet(entrancedata.bindBuild, entrancedata.bindRole)
        end
    end
    for k, v in pairs(self.basicCityTb[cityid]) do
        if not allRole[k] then
            allRole[v.role] = roleDataSet(v.place, v.role)
        end
    end
    for k, v in pairs(allRole) do
        citydata.roleData[v.buildingId] = citydata.roleData[v.buildingId] or {}
        table.insert(citydata.roleData[v.buildingId], v)
    end
    allRole = {}
    return citydata
end

--解析城建数据
function NewCityDataMgr:parseCityData(data, bsendupdate)
    self.normalCityData.dayType = data.dayType--0 白天，1 晚上

    data.buildinginfos = data.buildinginfos or {}
    local buildinfo = {}
    for i, v in ipairs(data.buildinginfos) do
        buildinfo[v.buildingId] = v
    end
    for k, v in pairs(self.newBuildTb) do
        local buildata = buildinfo[v.id]
        if buildata then
            buildata.isUnlock = true
            self.normalCityData.buildData[v.id] = nil
            self.normalCityData.buildData[v.id] = buildata
        else
            if not self.normalCityData.buildData[v.id] then
                self.normalCityData.buildData[v.id] = {isUnlock = false}
            end
        end
    end

    local function aiLineGet(cityroleid)
        local ailines = {normal={}, click={}, state={}}
        local cityroleconf = TabDataMgr:getData("CityRole", cityroleid)
        if cityroleconf then
            local normal = cityroleconf.dialog or {}
            for i, v in ipairs(normal) do
                local line = clone(TabDataMgr:getData("CityLines", v).cityLines) or {}
                table.insert(ailines.normal, line)
            end
            local click = cityroleconf.clickDialog or {}
            for i, v in ipairs(click) do
                local line = clone(TabDataMgr:getData("CityLines", v).cityLines) or {}
                table.insert(ailines.click, line)
            end
            local state = cityroleconf.specialDialog or {}
            for k, sv in pairs(state) do
                local slines = {}
                for i, v in ipairs(sv) do
                    local line = clone(TabDataMgr:getData("CityLines", v).cityLines) or {}
                    table.insert(slines, line)
                end
                ailines.state[k] = slines
            end
        end
        return ailines
    end
    local broleupdate = false
    if data.roleInRooms then
        broleupdate = true
        data.roleInRooms = data.roleInRooms or {}
        local allRole = {}
        self.normalCityData.roleData = {}
        for i, v in ipairs(data.roleInRooms) do
            local roleid = TabDataMgr:getData("CityRole", v.cityRoleId).roleId
            local roleconf = clone(TabDataMgr:getData("CityRoleModel", v.dressId))
            if roleconf.roleType == 1 then
                if RoleDataMgr:getRoleIdx(roleid) then
                    v.roleType = roleconf.roleType
                    v.rolePath = roleconf.rolePath
                    v.iconPos = roleconf.iconPos
                    v.isFlip = roleconf.flip
                    v.modeHead = roleconf.modeHead
                    v.roleId = roleconf.modelId
                    v.aiWord = aiLineGet(v.cityRoleId)
                    allRole[v.dressId] = v
                end
            else
                v.roleType = roleconf.roleType
                v.rolePath = roleconf.rolePath
                v.iconPos = roleconf.iconPos
                v.isFlip = roleconf.flip
                v.modeHead = roleconf.modeHead
                v.roleId = roleconf.modelId
                v.aiWord = aiLineGet(v.cityRoleId)
                allRole[v.dressId] = v
            end
        end
        for k, v in pairs(allRole) do
            self.normalCityData.roleData[v.buildingId] = self.normalCityData.roleData[v.buildingId] or {}
            table.insert(self.normalCityData.roleData[v.buildingId], v)
        end
        allRole = {}
    end

    if data.remindEvents and self.remindEvent then
        data.remindEvents = data.remindEvents or {}
        for i, v in ipairs(data.remindEvents) do
            if v.eventType == EC_NewCityRemindType.Build then--建筑解封
                table.insert(self.remindEvents.build, v)
            elseif v.eventType == EC_NewCityRemindType.BuildFuncs then--功能解封
                table.insert(self.remindEvents.buildfuns, v)
            elseif v.eventType == EC_NewCityRemindType.Role then--精灵增加
                table.insert(self.remindEvents.role, v)
            end
        end
        self.remindCount = #self.remindEvents.build + #self.remindEvents.buildfuns + #self.remindEvents.role
    end

    if bsendupdate and broleupdate then
        EventMgr:dispatchEvent(EV_NEW_CITY.cityUpdate)
    end
end

function NewCityDataMgr:getCityRoleModeHead(roleid)
    for k, v in pairs(self.normalCityData.roleData) do
        for rk, rv in pairs(v) do
            if rv.roleId == roleid then
                return rv.modeHead
            end
        end
    end
end

function NewCityDataMgr:getCurMainLineFavorCfg()
    if self.curMainLineId <= 0 then return nil end
    local cfg = clone(TabDataMgr:getData("Favor", self.curMainLineId))
    return cfg
end

function NewCityDataMgr:getCurFubenCityNovelCfg()
    local cfg = clone(TabDataMgr:getData("Novel", self.curFubenLineId))
    return cfg
end

function NewCityDataMgr:getMainLineDataQuality()
    if self.mainLineDataList then
        return self.mainLineDataList[self.curMainLineId] and self.mainLineDataList[self.curMainLineId].quality or {}
    else
        return {}
    end
end

function NewCityDataMgr:getLastMainLineQuality()
    local quality = self.lastMainLineQuality[self.curMainLineId] or NewCityDataMgr:getMainLineDataQuality()
    return quality
end

--当前主线对应看板娘id
function NewCityDataMgr:getCurMainLineRoleId()
    if self.curCityType == EC_NewCityType.NewCity_MainLine then
        local curmainid = self.curMainLineId
        if curmainid ~= 0 then 
            local conf = TabDataMgr:getData("Favor", curmainid)
            return conf.role
        end
    end
end

function NewCityDataMgr:getMainLineEndList(id)
    local endList = {}
    if self.mainLineDataList[id] and self.mainLineDataList[id].endings then
        endList = self.mainLineDataList[id].endings
    end
    return endList
end

function NewCityDataMgr:getMainEndOfList( id )
    local data = TabDataMgr:getData("FavorEnd")
    local endOfList = {}
    for k, v in pairs(data) do
        if v.outside and v.outside == id then
            table.insert(endOfList,v)
        end
    end
    return endOfList
end

function NewCityDataMgr:setPreOpenParam(param)
    self.pre_open_param = param
end

function NewCityDataMgr:getPreOpenParam()
    return self.pre_open_param
end

return NewCityDataMgr:new()
