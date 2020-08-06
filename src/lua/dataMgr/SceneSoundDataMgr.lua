local BaseDataMgr = import(".BaseDataMgr")
local SceneSoundDataMgr = class("SceneSoundDataMgr", BaseDataMgr)

function SceneSoundDataMgr:init()
    self:initData()
    self:registerMsgEvent()
end

function SceneSoundDataMgr:initData()

    self.MainSceneChangeMap = {}
    self.MainSceneChangeCfg = TabDataMgr:getData("MainSceneChange")
    for k,v in pairs(self.MainSceneChangeCfg) do
        if v.sortForMainScene > 0 then
            if not self.MainSceneChangeMap[v.groupBelong] then
                self.MainSceneChangeMap[v.groupBelong] = {}
            end
            table.insert(self.MainSceneChangeMap[v.groupBelong],v)
        end
    end

    for k,v in pairs(self.MainSceneChangeMap) do
        table.sort(v,function(a,b)
            return a.sortForMainScene < b.sortForMainScene
        end)
    end

    self.mainSceneGroupIdMap= {}
    local groupCfg = TabDataMgr:getData("MainSceneGroup")
    for k,v in pairs(groupCfg) do
        if self.MainSceneChangeMap[v.id] then
            table.insert(self.mainSceneGroupIdMap,v)
        end
    end

    table.sort(self.mainSceneGroupIdMap,function(a,b)
        return a.id < b.id
    end)

    self.soundCfg = {}
    local sound = TabDataMgr:getData("Sound")
    for k,v in pairs(sound) do
        if v.sortForMainBgm > 0 then
            table.insert(self.soundCfg,v)
        end
    end

    table.sort(self.soundCfg,function(a,b)
        return a.sortForMainBgm < b.sortForMainBgm
    end)

    self.kvpData  = Utils:getKVP(46017)
    self:reset()
end

function SceneSoundDataMgr:reset()

    self.curDayCid = nil
    self.curNightCid = nil

    self.curDayBgmCid = nil
    self.curNightBgmCid = nil

    self.tempDayBgmCid = nil
    self.tempNightBgmCid = nil

    self.tempDaySceneCid = nil
    self.tempNightSceneCid = nil

    self.isDefaultDay = false
    self.isDefaultNight = false
    self.isDefaultDayBgm = false
    self.isDefaultNightBgm = false
end

function SceneSoundDataMgr:onLogin()

    TFDirector:send(c2s.PLAYER_REQ_BACKGROUND_INFO, {})
    return {s2c.PLAYER_RES_BACKGROUND_INFO}
end

function SceneSoundDataMgr:getDefaultData()
    return self.isDefaultDay,self.isDefaultNight,self.isDefaultDayBgm,self.isDefaultNightBgm
end

function SceneSoundDataMgr:getSceneGroupMap()

    return self.mainSceneGroupIdMap
end

function SceneSoundDataMgr:getMainSceneChangeMap(groupId)
    return self.MainSceneChangeMap[groupId]
end

function SceneSoundDataMgr:getMainSceneChange(cid)
    return self.MainSceneChangeCfg[cid]
end

function SceneSoundDataMgr:getSoundCfg(cid)
    if not cid then
        return self.soundCfg
    end
    return self.soundCfg[cid]
end

function SceneSoundDataMgr:getSoundInfoByCid(cid)

    for k,v in ipairs(self.soundCfg) do
        if cid == v.id then
            return v
        end
    end
end

function SceneSoundDataMgr:getCurSceneGroup()
    local groupId
    for k,v in pairs(self.MainSceneChangeCfg) do
        if self.curDayCid == v.id or self.curNightCid == v.id then
            groupId = v.groupBelong
            break
        end
    end
    return groupId
end

function SceneSoundDataMgr:isUsingGroup(groupId)
    local isUsingDay,isUsingNight = false,false
    for k,v in pairs(self.MainSceneChangeCfg) do
        if self.tempDaySceneCid == v.id then
            if groupId == v.groupBelong then
                isUsingDay = true
            end
        end
        if self.tempNightSceneCid == v.id then
            if groupId == v.groupBelong then
                isUsingNight = true
            end
        end
    end
    return isUsingDay,isUsingNight
end

function SceneSoundDataMgr:getCurSceneCid()
    return self.curDayCid,self.curNightCid
end

function SceneSoundDataMgr:getTempSceneCid()
    return self.tempDaySceneCid,self.tempNightSceneCid
end

function SceneSoundDataMgr:setTempSceneCid(tempDaySceneCid,tempNightSceneCid)
    self.tempDaySceneCid = tempDaySceneCid or self.tempDaySceneCid
    self.tempNightSceneCid = tempNightSceneCid or self.tempNightSceneCid
end

function SceneSoundDataMgr:getCurSceneBgmId()
    return self.curDayBgmCid,self.curNightBgmCid
end

function SceneSoundDataMgr:getTempBgmCid()
    return self.tempDayBgmCid,self.tempNightBgmCid
end

function SceneSoundDataMgr:setTempBgmCid(tempDayBgmCid,tempNightBgmCid)
    self.tempDayBgmCid = tempDayBgmCid or self.tempDayBgmCid
    self.tempNightBgmCid = tempNightBgmCid or self.tempNightBgmCid
end

function SceneSoundDataMgr:sceneIsChanged()

    if self.tempDaySceneCid and self.tempDaySceneCid ~= self.curDayCid then
        return true
    end

    if self.tempNightSceneCid and self.tempNightSceneCid ~= self.curNightCid then
        return true
    end

    if self.tempDayBgmCid and self.tempDayBgmCid ~= self.curDayBgmCid then
        print(self.tempDayBgmCid,self.curDayBgmCid)
        return true
    end

    if self.tempNightBgmCid and self.tempNightBgmCid ~= self.curNightBgmCid then
        return true
    end

    return false
end

function SceneSoundDataMgr:resetTempSaveData()
    self:setTempSceneCid(self.curDayCid,self.curNightCid)
    self:setTempBgmCid(self.curDayBgmCid,self.curNightBgmCid)
end

function SceneSoundDataMgr:Send_SetBackGround(dayBackground,nightBackground,dayBGM,nightBGM)
    dayBackground = dayBackground or 0
    nightBackground = nightBackground or 0
    dayBGM = dayBGM or 0
    nightBGM = nightBGM or 0
    local tab = {
        dayBackground,
        nightBackground,
        dayBGM,
        nightBGM
    }
    TFDirector:send(c2s.PLAYER_REQ_SET_BACKGROUND, tab)
end

--获得当前设置的背景和音乐
function SceneSoundDataMgr:onRecvCurEquipInfo(event)

    local data = event.data
    if not data then
        return
    end

    self.curDayCid = data.dayBackground and data.dayBackground or self.kvpData.defaultDayScene
    self.curNightCid = data.nightBackground and data.nightBackground or self.kvpData.defaultDayScene

    self.curDayBgmCid = data.dayBGM and data.dayBGM or self.kvpData.defaultDayBgm
    self.curNightBgmCid = data.nightBGM and data.nightBGM or self.kvpData.defaultNightBgm

    self.tempDaySceneCid = data.dayBackground and data.dayBackground or self.kvpData.defaultDayScene
    self.tempNightSceneCid = data.nightBackground and data.nightBackground or self.kvpData.defaultDayScene

    self.tempDayBgmCid = data.dayBGM and data.dayBGM or self.kvpData.defaultDayBgm
    self.tempNightBgmCid = data.nightBGM and data.nightBGM or self.kvpData.defaultNightBgm

    self.isDefaultDay = data.dayBackground == nil
    self.isDefaultNight = data.nightBackground == nil
    self.isDefaultDayBgm = data.dayBGM == nil
    self.isDefaultNightBgm = data.nightBGM == nil
end

function SceneSoundDataMgr:onRecvSetBackGround(event)

    local data = event.data
    if not data then
        return
    end

    self.curDayCid = data.dayBackground or self.curDayCid
    self.curNightCid = data.nightBackground or self.curNightCid

    self.curDayBgmCid = data.dayBGM or self.curDayBgmCid
    self.curNightBgmCid = data.nightBGM or self.curNightBgmCid

    self.tempDaySceneCid = data.dayBackground or self.curDayCid
    self.tempNightSceneCid = data.nightBackground or self.curNightCid

    self.tempDayBgmCid = data.dayBGM or self.curDayBgmCid
    self.tempNightBgmCid = data.nightBGM or self.curNightBgmCid

    self.isDefaultDay = data.dayBackground == nil
    self.isDefaultNight = data.nightBackground == nil
    self.isDefaultDayBgm = data.dayBGM == nil
    self.isDefaultNightBgm = data.nightBGM == nil

    EventMgr:dispatchEvent(EV_CHANGE_MAINSCENE_INFO)

end

function SceneSoundDataMgr:onRecvUpdateTime(event)

    EventMgr:dispatchEvent(EV_CHANGE_MAINSCENE_INFO)
end

function SceneSoundDataMgr:registerMsgEvent()

    TFDirector:addProto(s2c.PLAYER_RES_BACKGROUND_INFO, self, self.onRecvCurEquipInfo)
    TFDirector:addProto(s2c.PLAYER_RES_SET_BACKGROUND, self, self.onRecvSetBackGround)
    TFDirector:addProto(s2c.PLAYER_UPDATE_BACKGROUND_TIME, self, self.onRecvUpdateTime)

end

return SceneSoundDataMgr:new()
