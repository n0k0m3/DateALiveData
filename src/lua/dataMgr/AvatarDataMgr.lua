
local BaseDataMgr = import(".BaseDataMgr")
local AvatarDataMgr = class("AvatarDataMgr", BaseDataMgr)

function AvatarDataMgr:init()
    TFDirector:addProto(s2c.PORTRAIL_RESP_ACTIVATE_PORTRAIT, self, self.onRecvAvatarData)
    TFDirector:addProto(s2c.PORTRAIL_RESP_EQUIP_PORTRAIT, self, self.onRecvUseAvatar)
    TFDirector:addProto(s2c.PORTRAIL_RES_CANCEL_MARK, self, self.onRecvCancelRedpoint)
    TFDirector:addProto(s2c.PORTRAIL_RES_UNLOCK_PORTRAIT, self, self.onRecvAvatarUnlock)
    self.avatarData_ = {}
    self.frameData_ = {}
    self.chatBubbleData_ = {}
    self.m_hex = {
    ["0"] = 0,["1"] = 1,["2"] = 2,["3"] = 3,["4"] = 4,["5"] = 5,["6"] = 6,["7"] = 7,["8"] = 8,["9"] = 9,["a"] = 10,["b"] = 11,["c"] = 12,["d"] = 13,["e"] = 14,["f"] = 15}
    
    --本地数据
    self.avatarConfigMap_ = TabDataMgr:getData("Portrait")
    for k,v in pairs(self.avatarConfigMap_) do
        v.cid = k
    end
    self.m_usingAvatar = 1
    self.m_redMark = false
    self.m_usingFrame  = 1
    self.m_frameRedMark = false
    self.m_usingBubble = 1
    self.m_bubbleRedMark = false
    self.extraData = nil
end

function AvatarDataMgr:reset()
    self.avatarData_ = {}
    self.frameData_ = {}
    self.chatBubbleData_ = {}
end

function AvatarDataMgr:onLogin()
    TFDirector:send(c2s.PORTRAIT_REQ_ACTIVATE_PORTRAITS, {})
    return {s2c.PORTRAIL_RESP_ACTIVATE_PORTRAIT}
end

function AvatarDataMgr:onLoginOut()
    self:reset()
end

--获取已有的头像数据
function AvatarDataMgr:sendReqAvatarData()
    TFDirector:send(c2s.PORTRAIT_REQ_ACTIVATE_PORTRAITS, {})
end

--更换头像
function AvatarDataMgr:sendReqUseAvatar(cid)
    TFDirector:send(c2s.PORTRAIT_REQ_EQUIP_PORTRAIT, {cid})
end

--取消红点
function AvatarDataMgr:sendReqCancelRedpoint(redType)
    if redType == 1 and self.m_redMark then
        TFDirector:send(c2s.PORTRAIT_REQ_CANCEL_MARK, {redType})
    end
    if redType == 2 and self.m_frameRedMark then
        TFDirector:send(c2s.PORTRAIT_REQ_CANCEL_MARK, {redType})
    end 
    if redType == 3 and self.m_bubbleRedMark then
        TFDirector:send(c2s.PORTRAIT_REQ_CANCEL_MARK, {redType})
    end
end

function AvatarDataMgr:onRecvAvatarData(event)
    local data = event.data
    if data.activeCid then
        for k,cid in pairs(data.activeCid) do
            local cfg = self:getAvatarCfgById(cid)
            if cfg then
                if cfg.group == 1 then
                    self:updateOneAvatarInfo(cid)
                elseif cfg.group == 2 then
                    self:updateOneFrameInfo(cid)
                elseif cfg.group == 3 then
                    self:updateOneChatBubbleInfo(cid)
                end
            end
        end
    end
    self.m_usingAvatar = data.equipCid or 0
    self.m_redMark = data.redMark or false
    self.m_usingFrame = data.equipFrameCid or 0
    self.m_frameRedMark = data.frameRedMark or false
    self.m_usingBubble = data.chatFrameCid or 0
    self.m_bubbleRedMark = data.chatRedMark or false
    self.extraData = json.decode(data.ext)

    for k, v in pairs(self.frameData_) do
        local info = self.frameData_[k]
        local flag = false
        for i,cid in pairs(data.activeCid) do
            if tonumber(cid) == tonumber(k) then
                flag = true
                break
            end
        end
        if not flag then
            self.frameData_[k] = nil
        end
    end
end

function AvatarDataMgr:onRecvUseAvatar(event)
    local data = event.data
    if data.portraitType == 1 then
        self.m_usingAvatar = data.equipCid
    elseif data.portraitType == 2 then
        self.m_usingFrame = data.equipCid
    elseif data.portraitType == 3 then
        self.m_usingBubble = data.equipCid
    end
    Utils:showTips(800068)
    EventMgr:dispatchEvent(EV_AVATAR_UPDATE, {})
end

function AvatarDataMgr:onRecvCancelRedpoint(event)
    local data = event.data
    if data.portraitType == 1 then
        self.m_redMark = false
    elseif data.portraitType == 2 then
        self.m_frameRedMark = false
    elseif data.portraitType == 3 then
        self.m_bubbleRedMark = false
    end
    EventMgr:dispatchEvent(EV_AVATAR_UPDATE, {})
end

function AvatarDataMgr:onRecvAvatarUnlock(event)
   local data = event.data
   if data.cid then
        local cfg = self.avatarConfigMap_[data.cid]
        if cfg.group == 1 then
            if data.ct == EC_SChangeType.DELETE then
                self.avatarData_[data.cid] = nil
            else
                if not self.avatarData_[data.cid] then
                    local info = {}
                    info.cid = data.cid
                    self.avatarData_[data.cid] = info
                    self.m_redMark = true
                end
            end
        elseif cfg.group == 2 then
            if data.ct == EC_SChangeType.DELETE then
                self.frameData_[data.cid] = nil
            else
                if not self.frameData_[data.cid] then
                    local info = {}
                    info.cid = data.cid
                    self.frameData_[data.cid] = info
                    self.m_frameRedMark = true
                    local name = TextDataMgr:getText(cfg.name)
                    if #cfg.toggle > 0  then
                        local extraData = self:getExtraData()
                        local month = extraData and extraData.month or 1
                        for k, v in pairs(cfg.toggle) do
                            local months = v.month
                            local month1 = months[1]
                            local month2 = months[2]
                            if month >= month1 and month <= month2 then
                                name = TextDataMgr:getText(v.name)
                                break
                            end
                        end
                    end
                    local tipsView = requireNew("lua.logic.playerInfo.TipsGetAvatarFrame"):new(name)
                end
            end
        elseif cfg.group == 3 then
            if data.ct == EC_SChangeType.DELETE then
                self.chatBubbleData_[data.cid] = nil
            else
                if not self.chatBubbleData_[data.cid] then
                    local info = {}
                    info.cid = data.cid
                    self.chatBubbleData_[data.cid] = info
                    self.m_bubbleRedMark = true
                    local name = TextDataMgr:getText(cfg.name)
                    local tipsView = requireNew("lua.logic.playerInfo.TipsGetMedal"):new(TextDataMgr:getText(270304), name)
                end
            end
        end
        EventMgr:dispatchEvent(EV_AVATAR_UPDATE, {})
   end
end

function AvatarDataMgr:getAvatarData()
    return self.avatarData_
end

function AvatarDataMgr:getBubbleFontColor(cid)
    return self.avatarConfigMap_[cid].fontcolor
end

function AvatarDataMgr:updateOneAvatarInfo(cid)
    local info = self.avatarData_[cid] or {}
    info.cid = cid
    self.avatarData_[info.cid] = info
end

function AvatarDataMgr:updateOneFrameInfo(cid)
    local info = self.frameData_[cid] or {}
    info.cid = cid
    self.frameData_[info.cid] = info
end

function AvatarDataMgr:updateOneChatBubbleInfo(cid)
    local info = self.chatBubbleData_[cid] or {}
    info.cid = cid
    self.chatBubbleData_[info.cid] = info
end

--获取排序后的头像数据
function AvatarDataMgr:getAvatarCfgArrayData(group)
    local avatars = {}
    local using = {}
    local unlocks = {}
    local locks = {}
    local typeCfgs = {}
    local avatar_map = TabDataMgr:getData("Portrait")
    for id,cfg in pairs(avatar_map) do
        if cfg.group == group then
            typeCfgs[cfg.titleType] = typeCfgs[cfg.titleType] or {}
            table.insert(typeCfgs[cfg.titleType], cfg)
        end
    end
    
    function checkCfg(showCfg)
        if showCfg.group == 1 then
            local data = self.avatarData_[showCfg.id]
            if data then
                if data.cid == self.m_usingAvatar then
                    using[#using + 1] = showCfg
                else
                    unlocks[#unlocks + 1] = showCfg
                end
            else
                locks[#locks + 1] = showCfg
            end
        elseif showCfg.group == 2 then
            local data = self.frameData_[showCfg.id]
            if data then
                if data.cid == self.m_usingFrame then
                    using[#using + 1] = showCfg
                else
                    unlocks[#unlocks + 1] = showCfg
                end
            else
                locks[#locks + 1] = showCfg
            end
        elseif showCfg.group == 3 then
            local data = self.chatBubbleData_[showCfg.id]
            if data then
                if data.cid == self.m_usingBubble then
                    using[#using + 1] = showCfg
                else
                    unlocks[#unlocks + 1] = showCfg
                end
            else
                locks[#locks + 1] = showCfg
            end
        end
    end
    for k,cfgs in pairs(typeCfgs) do
        if group == 2 or group == 3 then
            local showCfg
            if #cfgs > 1 then
                table.sort(cfgs,function(a, b)
                    return a.classifyOrder < b.classifyOrder
                end)
                for i = #cfgs, 1, -1  do
                    local info
                    if cfgs[i].group == 1 then
                        info = self.avatarData_[cfgs[i].id]
                    elseif  cfgs[i].group == 2 then
                        info = self.frameData_[cfgs[i].id]
                    else
                        info = self.chatBubbleData_[cfgs[i].id]
                    end
                    if info then
                        showCfg = cfgs[i]
                        break
                    end
                end
                if not showCfg then
                    showCfg = cfgs[1]
                end
            else
                showCfg = cfgs[1]
            end
            checkCfg(showCfg)
        else
            for i,v in ipairs(cfgs) do
                checkCfg(v)
            end
        end
    end

    function sortByOrder(a, b)
        if a.classify == b.classify then
            return a.classifyOrder < b.classifyOrder 
        end
        return a.classify < b.classify
    end
    table.sort(using, sortByOrder)
    table.sort(unlocks, sortByOrder)
    table.sort(locks, sortByOrder)
    avatars = {}
    for i,v in ipairs(using) do
        avatars[v.classify] = avatars[v.classify] or {}
        table.insert(avatars[v.classify], v)
    end
    for i,v in ipairs(unlocks) do
        avatars[v.classify] = avatars[v.classify] or {}
        table.insert(avatars[v.classify], v)
    end
    for i,v in ipairs(locks) do
        avatars[v.classify] = avatars[v.classify] or {}
        table.insert(avatars[v.classify], v)
    end
    local sortData = {}
    for k,v in pairs(avatars) do
        local info = {}
        info.classify = k
        info.cfgs = v
        table.insert(sortData, info)
    end
    table.sort(sortData,function(a, b)
        return a.classify < b.classify
    end)
    return sortData
end

function AvatarDataMgr:getAvatarInfoById(cid)
    return self.avatarData_[cid]
end

function AvatarDataMgr:getAvatarFrameInfoById(cid)
    return self.frameData_[cid]
end

function AvatarDataMgr:getChatBubbleDataById(cid)
    return self.chatBubbleData_[cid]
end

function AvatarDataMgr:getAvatarCfgById(cid)
    return self.avatarConfigMap_[cid]
end

function AvatarDataMgr:getCurUsingCid()
    return self.m_usingAvatar
end

function AvatarDataMgr:getRedMask()
    return self.m_redMark or self.m_frameRedMark or self.m_bubbleRedMark
end

function AvatarDataMgr:getCurUsingFrameCid()
    return self.m_usingFrame
end

function AvatarDataMgr:getCurUsingBubbleCid()
    return self.m_usingBubble
end

function AvatarDataMgr:getFrameRedMask()
    return self.m_frameRedMark
end

function AvatarDataMgr:getSelfAvatarIconPath()
    if self.m_usingAvatar > 0 and self.avatarConfigMap_[self.m_usingAvatar] then
        return self.avatarConfigMap_[self.m_usingAvatar].icon
    end
    return self.avatarConfigMap_[101].icon
end

function AvatarDataMgr:getAvatarIconPath(cid)
    if cid and self.avatarConfigMap_[cid] then
        return self.avatarConfigMap_[cid].icon
    end
    return self.avatarConfigMap_[101].icon
end

function AvatarDataMgr:getSelfAvatarFrameIconPath(cid)
    local cfg
    if self.m_usingFrame > 0 then
        cfg = self.avatarConfigMap_[self.m_usingFrame]
    elseif cid and cid > 0 then
        cfg = self.avatarConfigMap_[cid]
    end
    if cfg then
        if #cfg.toggle > 0  then
            local extraData = self:getExtraData()
            local month = extraData.month or 1
            for k, v in pairs(cfg.toggle) do
                local months = v.month
                local month1 = months[1]
                local month2 = months[2]
                if month >= month1 and month <= month2 then
                    local effect = v.ShowEffect1 ~= "" and v.ShowEffect1 or v.ShowEffect2
                    return v.icon,effect
                end
            end
        end
        local effect = cfg.ShowEffect1 ~= "" and cfg.ShowEffect1 or cfg.ShowEffect2
        return cfg.icon,effect
    end
    return "",""
end

function AvatarDataMgr:getAvatarFrameIconPath(cid)
    local cfg = self.avatarConfigMap_[cid]
    if cfg then
        if #cfg.toggle > 0  then
            local extraData = self:getExtraData()
            local month = extraData.month or 1
            for k, v in pairs(cfg.toggle) do
                local months = v.month
                local month1 = months[1]
                local month2 = months[2]
                if month >= month1 and month <= month2 then
                    return v.icon,v.ShowEffect1 ~= "" and v.ShowEffect1 or v.ShowEffect2
                end
            end
        end
        local effect = cfg.ShowEffect1 ~= "" and cfg.ShowEffect1 or cfg.ShowEffect2
        return cfg.icon,effect
    end
    return "",""
end

function AvatarDataMgr:getCustomFontName(cid)
    if cid and self.avatarConfigMap_[cid] then
        if string.len(self.avatarConfigMap_[cid].font) > 1 then
            return self.avatarConfigMap_[cid].font
        end
    end
    return "font/fangzheng_zhunyuan.ttf"
end

function AvatarDataMgr:getCustomFontColor(cid)
    local r,g,b = 255, 255, 255
    if cid and self.avatarConfigMap_[cid] then
        local stringHex = self.avatarConfigMap_[cid].fontcolor
        stringHex = string.lower(stringHex)
        local pos = 1
        local chars = {}
        for i=1,string.len(stringHex) do
            chars[#chars + 1] = string.sub(stringHex, pos, pos)
            pos = pos + 1
        end
        if #chars > 6 then
            r = self.m_hex[chars[2]] * 16 + self.m_hex[chars[3]]
            g = self.m_hex[chars[4]] * 16 + self.m_hex[chars[5]]
            b = self.m_hex[chars[6]] * 16 + self.m_hex[chars[7]]
        end
    end
    return ccc3(r, g, b)
end

function AvatarDataMgr:getChatCustomContentFrame(cid, isSelf)
    if cid and self.avatarConfigMap_[cid] then
        if isSelf then
            if string.len(self.avatarConfigMap_[cid].minedialog) > 1 then
                return self.avatarConfigMap_[cid].minedialog
            end
        else
            if string.len(self.avatarConfigMap_[cid].theirdialog) > 1 then
                return self.avatarConfigMap_[cid].theirdialog
            end
        end
    end
    if isSelf then
        return "ui/chat/t2.png"
    else
        return "ui/chat/t2.png"
    end
end

function AvatarDataMgr:getExtraData()
    return self.extraData
end

return AvatarDataMgr:new()
