
local BaseDataMgr = import(".BaseDataMgr")
local TitleDataMgr = class("TitleDataMgr", BaseDataMgr)
local UserDefalt = CCUserDefault:sharedUserDefault()

function TitleDataMgr:init()
    self:registerMsgEvent()
    self:reset()
    self:initData()
end

function TitleDataMgr:registerMsgEvent()
    TFDirector:addProto(s2c.SYSTEM_TITLE_RESP_GET_SYSTEM_TITLE_INFO, self, self.onRecvGetTitleInfo)
    TFDirector:addProto(s2c.SYSTEM_TITLE_RESP_EQUIP_SYSTEM_TITLE, self, self.onRecvEquipTitle)
    TFDirector:addProto(s2c.SYSTEM_TITLE_RESP_TAKE_OFF_SYSTEM_TITLE, self, self.onRecvTakeOffTitle)
end

function TitleDataMgr:onLogin()

    self:readSaveTitleTab()

    TFDirector:send(c2s.SYSTEM_TITLE_REQ_GET_SYSTEM_TITLE_INFO, {})
    return {s2c.PLAYER_FORMATION_INFO_LIST}
end

function TitleDataMgr:reset()
    self.ownTitleList = {}
    self.originalTitle = {}  
    self.equipTitleId = 0
    self.titleRedState = false
end

function TitleDataMgr:initData()

    self.titleBaseCfg = TabDataMgr:getData("TitleBase")
    self.ownTitleList = {}
    self.originalTitle = {}
    self.equipTitleId = 0
    self.titleRedState = false
end

function TitleDataMgr:getTitleClassifyCfg(classify)
    local datas = {}
    for k, v in pairs(self.titleBaseCfg) do
        if classify then 
            if classify == 0 or classify == v.classify then
                datas[v.classify] = datas[v.classify] or {}
                table.insert(datas[v.classify], v)
            end
        else
            datas[v.classify] = datas[v.classify] or {}
            table.insert(datas[v.classify], v)
        end
    end
    local titleCfgs = {}
    for k,cfgs in pairs(datas) do
        local info = {}
        info.classify = k
        info.typeCfgs = {}
        for i, cfg in ipairs(cfgs) do
            info.typeCfgs[cfg.titleType] = info.typeCfgs[cfg.titleType] or {}
            table.insert(info.typeCfgs[cfg.titleType], cfg)
        end
        table.insert(titleCfgs, info)
    end
    table.sort(titleCfgs,function(a, b)
        return a.classify < b.classify
    end)
    return titleCfgs
end

function TitleDataMgr:getEnableShowTitles(classify)
    local titleCfgs = self:getTitleClassifyCfg(classify)
    for i, info in ipairs(titleCfgs) do
        for titleType, cfgs in pairs(info.typeCfgs) do
            if #cfgs > 1 then
                table.sort(cfgs,function(a, b)
                    return a.titleLevel < b.titleLevel
                end)
                local unlockTitle
                for i = #cfgs, 1, -1  do
                    if self:getOwnTitleById(cfgs[i].id) then
                        unlockTitle = cfgs[i]
                        break
                    end
                end
                if not unlockTitle then
                    unlockTitle = cfgs[1]
                end
                info.typeCfgs[titleType] = {unlockTitle}
            end
        end
    end
    local sortCfgs = {}
    local using = {}
    local unlocks = {}
    local locks = {}
    for i,info in ipairs(titleCfgs) do
        for titleType, cfgs in pairs(info.typeCfgs) do
            for j, cfg in ipairs(cfgs) do
                local data = self:getOwnTitleById(cfg.id)
                if data then
                    if data.isEquip then
                        using[#using + 1] = cfg
                    else
                        unlocks[#unlocks + 1] = cfg
                    end
                else
                    locks[#locks + 1] = cfg
                end
            end
        end
    end
    table.sort(unlocks, function (a,b)
        return a.order < b.order
    end )
    table.sort(locks, function (a,b)
        return a.order < b.order
    end )
    for i,v in ipairs(using) do
        table.insert(sortCfgs, v)
    end
    for i,v in ipairs(unlocks) do
        table.insert(sortCfgs, v)
    end
    for i,v in ipairs(locks) do
        table.insert(sortCfgs, v)
    end
    return sortCfgs
end

function TitleDataMgr:getTileCfgByTitleType(titleType)
    local cfgs = {}
    for k, v in pairs(self.titleBaseCfg) do
        if titleType == v.titleType then
            table.insert(cfgs, v)
        end
    end
    table.sort(cfgs,function(a, b)
        return a.titleLevel < b.titleLevel
    end)
    return cfgs
end

function TitleDataMgr:readSaveTitleTab()

    self.saveTitleIdTab = {}
    local pid = MainPlayer:getPlayerId()
    local saveInfoStr = UserDefalt:getStringForKey("checkedId"..pid)
    if saveInfoStr ~= "" then
        local titleTab = string.split(saveInfoStr,"|")
        for k,v in ipairs(titleTab) do
            local titleId = tonumber(v)
            if titleId then
                self.saveTitleIdTab[titleId] = 1
            end
        end
    end
end


function TitleDataMgr:saveCheckedTitleId(titleId)
    if not self.saveTitleIdTab[titleId] then
        local pid = MainPlayer:getPlayerId()
        local saveInfoStr = UserDefalt:getStringForKey("checkedId"..pid)
        saveInfoStr = saveInfoStr..titleId.."|"
        UserDefalt:setStringForKey("checkedId"..pid,saveInfoStr)
        UserDefalt:flush()
        self.saveTitleIdTab[titleId] = 1
    end
end

function TitleDataMgr:isCheckTitleId(titleId)
    return self.saveTitleIdTab[titleId]
end

function TitleDataMgr:checkTitleRedState()
    return self.titleRedState
end

function TitleDataMgr:changeRedState(state)
    self.titleRedState = state
end

function TitleDataMgr:getTitleCfg(titleId)

    if not titleId then
        return self.titleBaseCfg
    end

    return self.titleBaseCfg[titleId]

end

function TitleDataMgr:getNotOwnTitle()

    local notOwnTitle = {}
    for k,v in pairs(self.titleBaseCfg) do
        if not self:getOwnTitleById(k) then
            table.insert(notOwnTitle,v)
        end
    end
    table.sort(notOwnTitle,function(a,b)
        return a.Order < b.Order
    end)
    return notOwnTitle
end

function TitleDataMgr:getOwnTitle()
    table.sort(self.ownTitleList,function(a,b)
        local cfga = self:getTitleCfg(a.titleId)
        local cfgb = self:getTitleCfg(b.titleId)
        return cfga.Order < cfgb.Order
    end)

    return self.ownTitleList
end

function TitleDataMgr:getOwnTitleById(titleId)

    return self.originalTitle[titleId]
end

function TitleDataMgr:getEquipedTitleId()
    return self.equipTitleId
end

function TitleDataMgr:Send_EquipTitleId(titleId)
    TFDirector:send(c2s.SYSTEM_TITLE_REQ_EQUIP_SYSTEM_TITLE, {titleId})
end

function TitleDataMgr:Send_TakeOffTitleId(titleId)
    TFDirector:send(c2s.SYSTEM_TITLE_REQ_TAKE_OFF_SYSTEM_TITLE, {})
end

function TitleDataMgr:onRecvGetTitleInfo(event)

    local data = event.data
    if not data then
        return
    end
    local isUpdate = false
    local systemTitleInfo = data.systemTitleInfos or {}
    for k,v in ipairs(systemTitleInfo) do
        local ct = v.ct
        if ct == EC_SChangeType.ADD or ct == EC_SChangeType.DEFAULT then
            self.originalTitle[v.titleId] = v
            if ct == EC_SChangeType.ADD then
                isUpdate = true
                local cfg = self:getTitleCfg(v.titleId)
                local tipsView = requireNew("lua.logic.playerInfo.TipsGetMedal"):new(TextDataMgr:getText(1327107,""),TextDataMgr:getText(cfg.notable))
                self:changeRedState(true)
            end
        elseif ct == EC_SChangeType.DELETE then
            self.originalTitle[v.titleId] = nil
        elseif ct == EC_SChangeType.UPDATE then
            self.originalTitle[v.titleId] = v
            isUpdate = true
        end
    end

    self.ownTitleList = {}
    for k,v in pairs(self.originalTitle) do
        table.insert(self.ownTitleList,v)
        if v.isEquip then

            self.equipTitleId = v.titleId
        end
    end

    if isUpdate then
        EventMgr:dispatchEvent(EV_UPDATE_TITLE)
    end
end

function TitleDataMgr:onRecvEquipTitle(event)
    local data = event.data
    if not data then
        return
    end
    if self.originalTitle[self.equipTitleId] then
        self.originalTitle[self.equipTitleId].isEquip = false
    end
    self.equipTitleId = data.id
    if self.originalTitle[self.equipTitleId] then
        self.originalTitle[self.equipTitleId].isEquip = true
    end
    EventMgr:dispatchEvent(EV_EQUIP_OR_TAKEOFF_TITLE)

end

function TitleDataMgr:onRecvTakeOffTitle(event)

    local data = event.data
    if not data then
        return
    end
    self.equipTitleId = 0
    EventMgr:dispatchEvent(EV_EQUIP_OR_TAKEOFF_TITLE)
end

function TitleDataMgr:getTitleEffectSkeletonModle(titleId, posType, fixPos)
    local cfg = self:getTitleCfg(titleId)
    if not cfg then
        return
    end
    local position = cfg.excursion2[posType or 1]
    if fixPos then
        position = clone(position)
        position[1] = position[1] + fixPos[1]
        position[2] = position[2] + fixPos[2]
    end
    local size = cfg.size2[posType or 1]
    local skeletonTitleNode = SkeletonAnimation:create(cfg.showEffect)
    skeletonTitleNode:play("animation", true)
    skeletonTitleNode:setScale(size * 0.01)
    skeletonTitleNode:setPosition(ccp(position[1],position[2]))
    return  skeletonTitleNode
end

return TitleDataMgr:new()
