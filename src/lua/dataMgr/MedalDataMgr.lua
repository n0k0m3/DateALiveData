
local BaseDataMgr = import(".BaseDataMgr")
local MedalDataMgr = class("MedalDataMgr", BaseDataMgr)

function MedalDataMgr:init()
    TFDirector:addProto(s2c.MEDAL_RESP_ACTIVATE_MEDALS, self, self.onRecvActivateMedals)
    TFDirector:addProto(s2c.MEDAL_RESP_EQUIP_MEDAL, self, self.onRecvEquipMedal)
    TFDirector:addProto(s2c.MEDAL_RESP_TAKE_OFF_MEDAL, self, self.onRecvTakeOffMedal)
    self.medalData_ = {}
    
    --勋章本地数据
    self.medalConfigMap_ = TabDataMgr:getData("Medal")
    for k,v in pairs(self.medalConfigMap_) do
        v.cid = k
    end
end

function MedalDataMgr:reset()
    self.medalData_ = {}
end

function MedalDataMgr:chageDataToFriend(friend)
    if not self.myMedalData then
        self.myMedalData = clone(self.medalData_)
    end
    self.medalData_ = {}
    if friend.medal then
        for i, v in ipairs(friend.medal) do
            self.medalData_[v.cid] = v
        end
    end
end

function MedalDataMgr:changeDataToSelf()
    if self.myMedalData then
        self.medalData_ = clone(self.myMedalData)
        self.myMedalData = nil
    end
end

function MedalDataMgr:onLogin()
    
end

--获取已有的勋章数据
function MedalDataMgr:sendReqActivateMedals()
    TFDirector:send(c2s.MEDAL_REQ_ACTIVATE_MEDALS, {})
end

--穿戴勋章
function MedalDataMgr:sendReqEquipMedal(medalId)
    TFDirector:send(c2s.MEDAL_REQ_EQUIP_MEDAL, {medalId})
end

--卸下勋章
function MedalDataMgr:sendReqTakeOffMedal(medalId)
    TFDirector:send(c2s.MEDAL_REQ_TAKE_OFF_MEDAL, {medalId})
end

function MedalDataMgr:onRecvActivateMedals(event)
    local data = event.data
    -- print("medalData ==========================",data)
    if data.medal then
        for k,medalInfo in pairs(data.medal) do
            self:updateOneMedalInfo(medalInfo)
        end
    end
    EventMgr:dispatchEvent(EV_MEDAL_RESP_ACTIVATE_MEDALS, {})
end

function MedalDataMgr:onRecvEquipMedal(event)
    local data = event.data
    EventMgr:dispatchEvent(EV_MEDAL_WEAR_MEDAL_SUCCESS, data)
end

function MedalDataMgr:onRecvTakeOffMedal(event)
    local data = event.data
    EventMgr:dispatchEvent(EV_MEDAL_DROP_MEDAL_SUCCESS, data)
end

function MedalDataMgr:getMedalData()
    return self.medalData_
end

function MedalDataMgr:updateOneMedalInfo(medalInfo)
    local info = self.medalData_[medalInfo.cid] or {}
    for k,v in pairs(medalInfo) do
        info[k] = v
    end
    self.medalData_[medalInfo.cid] = info
    if medalInfo.ct == EC_MedalChangeType.ADD then
        local currentScene = Public:currentScene()
        if currentScene and currentScene:getTopLayer() and currentScene:getTopLayer().__cname == "MainLayer" then
            local unlockMedalView = requireNew("lua.logic.playerInfo.UnlockMedalView"):new(medalInfo.cid)
            AlertManager:addLayer(unlockMedalView,AlertManager.BLOCK_AND_GRAY_CLOSE)
            AlertManager:show()
        else
            local medalCfg = self:getMedalCfgById(medalInfo.cid)
            local tipsView = requireNew("lua.logic.playerInfo.TipsGetMedal"):new(TextDataMgr:getText(2480001),TextDataMgr:getText(medalCfg.name))
        end
    end
end

--获取排序后的勋章配置数据
function MedalDataMgr:getMedalCfgArrayData(sortType)
    local medalCfgData = {}
    local wears = {}
    local unlocks = {}
    local locks = {}
    for id,cfg in pairs(self.medalConfigMap_) do
        local medalInfo = self.medalData_[id]
        if medalInfo then
            if medalInfo.isEquip then
                wears[#wears + 1] = cfg
            else
                unlocks[#unlocks + 1] = cfg
            end
        else
            locks[#locks + 1] = cfg
        end
    end
    function sortByOrder(a, b)
        return a.order < b.order
    end
    table.sort(wears, sortByOrder)
    table.sort(unlocks, sortByOrder)
    table.sort(locks, sortByOrder)
    for i,v in ipairs(wears) do
        medalCfgData[#medalCfgData + 1] = v
    end
    for i,v in ipairs(unlocks) do
        medalCfgData[#medalCfgData + 1] = v
    end
    for i,v in ipairs(locks) do
        medalCfgData[#medalCfgData + 1] = v
    end
    local sortData = {}
    if sortType ~= 0 then
        for i,v in ipairs(medalCfgData) do
            if v.MedalType == sortType then
                sortData[#sortData + 1] = v
            end
        end
        return sortData
    end
    return medalCfgData
end

--判断是否有可以供更换的勋章
function MedalDataMgr:checkEnableReplaceMedal(medalId)
    for k,v in pairs(self.medalData_) do
        if v.cid ~= medalId then
            return true
        end
    end
    return false
end

function MedalDataMgr:getUnlockMedelCount()
    return table.count(self.medalData_)
end

function MedalDataMgr:getEquipedMedalCount()
    local count = 0
    for k,v in pairs(self.medalData_) do
        if v.isEquip then
            count = count + 1
        end
    end
    return count
end

function MedalDataMgr:getMedelInfoById(medalId)
    return self.medalData_[medalId]
end

function MedalDataMgr:getMedalCfgById(medalId)
    return self.medalConfigMap_[medalId]
end

function MedalDataMgr:getMedalStarBg(star)
    if star == 3 then
        return "ui/playerInfo/medal/ui_13.png"
    elseif star == 4 then
        return "ui/playerInfo/medal/ui_14.png"
    elseif star == 5 then
        return "ui/playerInfo/medal/ui_15.png"
    elseif star == 6 then
        return "ui/playerInfo/medal/ui_16.png"
    end
    return "ui/playerInfo/medal/ui_13.png"
end

function MedalDataMgr:onEnterMain()

end

return MedalDataMgr:new()
