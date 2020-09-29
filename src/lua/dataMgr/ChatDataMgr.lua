
local BaseDataMgr = import(".BaseDataMgr")
local ChatDataMgr = class("ChatDataMgr", BaseDataMgr)
require("lua.logic.dating.DatingPublic")
local socket = require "socket"

--[[
    [1] = {--ChatInfo
        [1] = 'int32':channel   [   聊天类型:1.公共 2.私聊;3.帮派 4.系统 5.队伍]
        [2] = 'int32':fun   [   功能类型:1.聊天 2.深渊组队邀请]
        [3] = 'string':content  [   内容]
        [4] = 'int32':pid   [   说话人的id]
        [5] = 'string':pname    [   说话人名称]
        [6] = 'int32':lvl   [   玩家等级]
        [7] = 'int32':helpFightHeroCid
    }
--]]
-- s2c.CHAT_CHAT_INFO = 2306

-- EC_ChatType = {
--     SYSTEM  = 1,    -- 公共
--     PRIVATE = 2,    -- 私聊
--     GUILD   = 3,    -- 帮派
-- }

-- // 聊天历史消息

-- message RespInitChatInfo{
--     required int32 roomId = 1;
--     repeated ChatInfo msgs = 2;
-- }
-- // s2c.CHAT_RESP_INIT_CHAT_INFO = 2311

-- // 黑名单列表
-- message Blacklist {
--     repeated int32 pids = 1;
-- }
-- s2c.CHAT_BLACKLIST = 2308

--黑名单操作
--[[
    [1] = {--RespBlacklistOperate
    }
--]]
-- s2c.CHAT_RESP_BLACKLIST_OPERATE = 2309

--黑名单刷新
--[[
    [1] = {--ChangeBlacklist
        [1] = {--ChangeType(enum)
            'v4':ChangeType
        },
        [2] = 'int32':pid
    }
--]]
-- s2c.CHAT_CHANGE_BLACKLIST = 2310

--随机房间
--[[
    [1] = {--RespChangeRoom
        [1] = {--RespInitChatInfo
            [1] = 'int32':roomId
            [2] = {--repeated ChatInfo
                [1] = 'int32':chatType  [聊天类型;1.公共,2.私聊;3.帮派;]
                [2] = 'string':content  [消息;]
                [3] = 'int32':pid   [说话人的id]
                [4] = 'string':pname    [说话人名称]
                [5] = {--FunType
                },
            },
        },
    }
--]]
-- s2c.CHAT_RESP_CHANGE_ROOM = 2307

--单个频道储存的最多消息数量
local MAX_MESSAGE_NUM = 80
function ChatDataMgr:init()
    TFDirector:addProto(s2c.CHAT_CHAT_INFO, self, self.onRecvChatInfo)
    TFDirector:addProto(s2c.CHAT_BLACKLIST, self, self.onBlockList)
    TFDirector:addProto(s2c.CHAT_CHANGE_BLACKLIST, self, self.onChangeBlockList)
    TFDirector:addProto(s2c.CHAT_RESP_CHANGE_ROOM, self, self.onChangeRoom)
    TFDirector:addProto(s2c.CHAT_RESP_CHAT_INFO_CHANGE,self,self.reshTeamYq)
    TFDirector:addProto(s2c.CHAT_RESP_SCROLLING_INFO,self,self.onRecvMarquree)
    TFDirector:addProto(s2c.CHAT_INIT_UNION_CHAT_INFO , self ,self.onRecvLeagueHistoryChat )

    self:reset()
    self:initConfigData()
end

-- 加载并格式化配置表数据
function ChatDataMgr:initConfigData()
    self.chatEmotionData = {{},{}}
    self.chatEmotionDict = {}
    for k, cfg in pairs(TabDataMgr:getData("ChatEmotion")) do
        if cfg.type == 1 then
            table.insert( self.chatEmotionData[1], cfg)
        elseif cfg.type == 2 then
            table.insert( self.chatEmotionData[2], cfg)
        end
        self.chatEmotionDict[cfg.converstr] = {emotionres = cfg.emotionres, type = cfg.type}
    end
end

function ChatDataMgr:getEmotionDataByIndex(index)
    return self.chatEmotionData[index]
end

function ChatDataMgr:getRichtextImgDict()
    return self.chatEmotionDict
end

function ChatDataMgr:onLogin()
    EventMgr:addEventListener(self,EV_OFFLINE_EVENT, handler(self.onLoginOut,self))
    TFDirector:addProto(s2c.CHAT_RESP_INIT_CHAT_INFO, self, self.onChatRecordWorldInfo)
    TFDirector:send(c2s.CHAT_REQ_INIT_CHAT_INFO, {})
    EventMgr:addEventListener(self,EV_CHAT_UPDATE_TEAM_INVITE, handler(self.onUpdateTeamInvite, self))
    self:loadPlistDatas()
    self:writePlistDatas()
    self:chatRecordPrivateInfo()

    return {s2c.CHAT_RESP_INIT_CHAT_INFO}
end

function ChatDataMgr:onEnterMain()
    -- local chatInfoList = self.datas[EC_ChatType.WORLD]

    -- for i=#chatInfoList,1,-1 do
    --     local chatInfo = chatInfoList[i]
    --     if FriendDataMgr:isShieldingFriend(chatInfo.pid) then
    --         table.remove(chatInfoList,i)
    --     end
    -- end
end

function ChatDataMgr:getBubbleConfigById(id)
    for k, cfg in pairs(TabDataMgr:getData("ChatUseBubble")) do
        if cfg.portraitid == id then
            return cfg
        end
    end
    return nil
end

function ChatDataMgr:reset()
    self.datas = {}
    --频道消息的阅读状态
    self.readStates = {}
    for key , chatType in pairs(EC_ChatType) do
        self.datas[chatType]   = {}
        self.readStates[chatType] = true
    end

    --屏蔽玩家
    self.blockPlayers = {}

    self.pList = {}

    --私聊记录
    self.pListData = {}
    self.pData_ = {}

    --当前私聊玩家
    self.curPrPlayerId = -1
    self.roomId = 1
    self.curChatInfo = nil

    self.isUnLockSendInfo = true

    self.unionRedpacketStatus = {}

    if self.timer_ then
        TFDirector:removeTimer(self.timer_)
        self.timer_ = nil
    end
end

function ChatDataMgr:onLoginOut()
    self:reset();
end

function ChatDataMgr:clearUnionChatData()
    if self.datas[EC_ChatType.GUILD] then
        self.datas[EC_ChatType.GUILD] = {}
        self.readStates[EC_ChatType.GUILD] = true
        self.unionRedpacketStatus = {}
    end
end

function ChatDataMgr:setReadState(chatType,bRead)
    if self.readStates[chatType] ~= bRead then
        self.readStates[chatType] = bRead
        EventMgr:dispatchEvent(EV_RED_POINT_UPDATE_CHAT)
    end
end

function ChatDataMgr:getReadState(chatType)
    if chatType then
        return self.readStates[chatType]
    else
        for key , _chatType in pairs(EC_ChatType) do
            if not self.readStates[_chatType] then
                return false
            end
        end
        return true
    end
end

function ChatDataMgr:updateUnionRedpacketStatus(playerId, time, count)
    local key = playerId..time
    local  info = self.unionRedpacketStatus[key] or {status = 0, count = 0}
    self.unionRedpacketStatus[key] = info
    if count then
        info.count = count
    else
        if info.status == 0 then
            info.status = 1
        end
    end
    EventMgr:dispatchEvent(EV_UNION_REDPACKET_INFO)
    EventMgr:dispatchEvent(EV_RED_POINT_UPDATE_CHAT)
end

function ChatDataMgr:getUnionRedPacketReadState()
    for k, info in pairs(self.unionRedpacketStatus) do
        if info.count > 0 and info.status == 0 then
            return true
        end
    end
    return false
end

function ChatDataMgr:getRedPacketStatus(playerId, time)
    local key = playerId..time
    local info = self.unionRedpacketStatus[key]
    return info
end

----
function ChatDataMgr:getChatList(chatType)
    local chatInfoList = nil
    if chatType == EC_ChatType.PRIVATE then
        if self.curPrPlayerId ~= -1 then
            chatInfoList = clone(self.pData_[self.curPrPlayerId])
        end
    else
        local data = {}
        --if chatType == EC_ChatType.TEAM_YQ then
        --    for i, v in ipairs(self.datas[EC_ChatType.WORLD]) do
        --        if v.fun == EC_ChatState.TEAM then
        --            table.insert(data,v)
        --        end
        --    end
        --elseif chatType == EC_ChatType.WORLD then
        --    for i, v in ipairs(self.datas[EC_ChatType.WORLD]) do
        --        if v.fun == EC_ChatState.CHAT then
        --            table.insert(data,v)
        --        end
        --    end
        --else
            data = clone(self.datas[chatType])
        --end
        chatInfoList = data
    end

    if not chatInfoList then
        return
    end

    for i=#chatInfoList,1,-1 do
        local chatInfo = chatInfoList[i]
        if chatInfo.pid == MainPlayer:getPlayerId() then
            chatInfo.pname = MainPlayer:getPlayerName()
        end
        if FriendDataMgr:isShieldingFriend(chatInfo.pid) then
            table.remove(chatInfoList,i)
        end
    end

    local newChatinfoList = {}
    for i, v in ipairs(chatInfoList) do
        local info = v
        if info.fun and info.fun == EC_ChatState.TEAM then
            local isShow,timelong = TeamFightDataMgr:checkInviteMsg(info.content)
            if isShow then
                info.timelong = timelong
                table.insert(newChatinfoList,info)
            end
        else
            table.insert(newChatinfoList,info)
        end
    end
    return newChatinfoList
end

---------------
local face_filter = 
{
    ["face0"] = 1,
    ["face1"] = 1,
    ["face2"] = 1,
    ["face3"] = 1,
    ["face4"] = 1,
}

function ChatDataMgr:checkChatInfo(chatInfo)
    if chatInfo.fun and chatInfo.fun == EC_ChatState.TEAM then
        local content = json.decode(chatInfo.content)
        if content and (content.nTeamType == 4 or content.nTeamType == 6)then 
            local battlecfg = TeamFightDataMgr:getTeamLevelCfg(content.nTeamType,content.battleid)
            if battlecfg then
				if content.nTeamType == 4 then
					local difficultySelects = SettingDataMgr:getDifficultyChoice()
					if difficultySelects[battlecfg.challangeLevel] ~= "1" then  --消息被排除
						return false
					end
				elseif content.nTeamType == 6 then
					local battleLevel = TabDataMgr:getData("DiscreteData",81030).data[content.battleid]
					local difficultySelects = SettingDataMgr:getBlackAndWhiteDifficultyChoice()
					if difficultySelects[battleLevel] ~= "1" then  --消息被排除
						print("battleLevel=" .. battleLevel)
						print("---------------------------------------------------------------->paichu1=" .. battleLevel)
						return false
					end
				end
            end
        end
    end
    return true
end

function ChatDataMgr:filteChatInfo()
    self.datas.customRemoveMsg = self.datas.customRemoveMsg or {}
    --self.datas.customRemoveMsg 相关为修复符石挑战切换难度无法显示之前曾经的邀请bug 2020-09-07
    if #self.datas.customRemoveMsg > 0 then
        for k ,v in pairs(self.datas.customRemoveMsg) do
           table.insert(self.datas[EC_ChatType.TEAM_YQ] , v)
        end
        self.datas.customRemoveMsg = {}
    end

    local chatInfoList = self.datas[EC_ChatType.TEAM_YQ]
    local _chatInfoList = {}
    if chatInfoList then
        for i,chatInfo in ipairs(chatInfoList) do
            if self:checkChatInfo(chatInfo) then 
                table.insert(_chatInfoList,chatInfo)
            else
                table.insert(self.datas.customRemoveMsg , chatInfo)
            end
        end
        self.datas[EC_ChatType.TEAM_YQ] = _chatInfoList
    end
end


function ChatDataMgr:onRecvChatInfo(event)
	print("ChatDataMgr:onRecvChatInfo--------------------")
    local chatInfo = event.data
    chatInfo.chatType = chatInfo.chatType or chatInfo.channel
    -- dump({"聊天消息",chatInfo})
	print("chatInfo.fun=" .. chatInfo.fun)
	print("chatInfo.chatType=" .. chatInfo.chatType)
    if chatInfo.chatType == EC_ChatType.SYSTEM then
        local strTag = "#####"
        chatInfo.isStrId = string.find(chatInfo.content , strTag)
        if chatInfo.isStrId then
            local strContent = string.split(chatInfo.content , strTag)
            if GAME_LANGUAGE_VAR == EC_LanguageType.Chinese then
                chatInfo.content = strContent[1]
            else
                chatInfo.content = strContent[2] or chatInfo.content
            end
        end
        chatInfo.pname = TextDataMgr:getText(chatInfo.pname)
    end
    if chatInfo.fun == EC_ChatState.MARQUEEN then -- 跑马灯不影响其他聊天消息
        EventMgr:dispatchEvent(EV_RECV_CHATINFO,chatInfo)
        return
    end
    if chatInfo.chatType  == EC_ChatType.TEAM then  --战斗内表情
        if face_filter[chatInfo.content] then 
            EventMgr:dispatchEvent(EV_RECV_CHATINFO,chatInfo)
            return
        end

    elseif chatInfo.chatType == EC_ChatType.TEAM_YQ then
        if not self:checkChatInfo(chatInfo) then
            return
        end
    end

    local chatInfoList = self.datas[chatInfo.chatType]
    -- local content = {teamid = 111,battlename = "第一副本",levellimit = 10}
    -- chatInfo.content = content
    -- chatInfo.fun = EC_ChatState.TEAM
    -- print("chatInfo ",chatInfo)
    -- print("chatInfo.chatType ",chatInfo.chatType)
    -- print("self.datas ",table.getn(self.datas[1]))

    -- print("onRecvChatInfo chatInfo",chatInfo)

    local redPacketStatus = false
    if chatInfo.fun and chatInfo.fun == EC_ChatState.TEAM then
        if not TeamFightDataMgr:checkInviteMsg(chatInfo.content) then
            return
        end
    end
    if chatInfo.chatType == EC_ChatType.PRIVATE then
        local playerInfo = {}
        playerInfo.playerId = chatInfo.pid
        playerInfo.palyerName = chatInfo.pname
		
        if playerInfo.playerId ~= MainPlayer:getPlayerId() or chatInfo.fun == EC_ChatState.TEAM  then
			print("---------------------------------------addPlayerToPlist")
            self:addPlayerToPlist(playerInfo)
        end

        self:savePlistDatas(chatInfo)
        self:addPlistDatas(self.curPrPlayerId,chatInfo)

        for iu,vu in ipairs(self.pListData) do
            if vu.pid == chatInfo.pid then
                local chatInfoCopy = clone(chatInfo)
                -- table.merge(vu,chatInfoCopy)
                vu.palyerName = chatInfoCopy.pname
                vu.lvl = chatInfoCopy.lvl
                vu.helpFightHeroCid = chatInfoCopy.helpFightHeroCid
            end
        end

    else
        table.insert(chatInfoList,1,chatInfo)
        if chatInfo.fun and chatInfo.fun == EC_ChatState.RED_PACK then
            local content = json.decode(chatInfo.content)
            if content and content.status then
                local key = chatInfo.pid..content.time
                local info = {status = content.status, count = content.count}
                self.unionRedpacketStatus[key] = info
                if content.status == 1 or content.count == 0 then
                    redPacketStatus = true
                end
            end
        end
    end

    for k,v in pairs(self.datas) do
        for iu,vu in ipairs(v) do
            if vu.pid == chatInfo.pid then
                local chatInfoCopy = clone(chatInfo)
                -- table.merge(vu,chatInfoCopy)
                vu.pname = chatInfoCopy.pname
                vu.lvl = chatInfoCopy.lvl
                vu.helpFightHeroCid = chatInfoCopy.helpFightHeroCid
            end
        end
    end

--超过最大数量删除最旧的消息
    if #chatInfoList > MAX_MESSAGE_NUM then
        table.remove(chatInfoList,#chatInfoList)
    end

    if FriendDataMgr:isShieldingFriend(chatInfo.pid) then
        return
    end

--设置对应频道消息的阅读状态
--    if chatInfo.fun and chatInfo.fun == EC_ChatState.TEAM then
--        self:setReadState(EC_ChatType.TEAM_YQ,false)
--    else
    if chatInfo.chatType == EC_ChatType.GUILD then
        if not redPacketStatus then
            self:setReadState(chatInfo.chatType,false)
        end
    else
        self:setReadState(chatInfo.chatType,false)
    end
    --end
    self.curChatInfo = chatInfo
--通知聊天消息变更
    EventMgr:dispatchEvent(EV_RECV_CHATINFO,chatInfo)
end

function ChatDataMgr:onChangeRoom(event)
	print("ChatDataMgr:onChangeRoom--------------------")
    local roomInfo = event.data.roomInfo
    self.roomId = roomInfo.roomId
    local chatInfo_ = roomInfo.msgs or {}
    self.datas[EC_ChatType.WORLD] = {}
    local chatInfoList = self.datas[EC_ChatType.WORLD]
    for i,v in ipairs(chatInfo_) do
        table.insert(chatInfoList,1,v)
    end
--超过最大数量删除最旧的消息
    if #chatInfoList > MAX_MESSAGE_NUM then
        table.remove(chatInfoList,#chatInfoList)
    end
--设置对应频道消息的阅读状态

    --local teamInfoList = {}
    --for i, v in ipairs(chatInfoList) do
    --    if v.fun and v.fun == EC_ChatState.TEAM then
    --        table.insert(teamInfoList,v)
    --    end
    --end
    --if #teamInfoList ~= 0 then
    --    self:setReadState(EC_ChatType.TEAM_YQ,false)
    --end
    --if #teamInfoList < #chatInfoList then
        self:setReadState(EC_ChatType.WORLD,false)
    --end
--通知聊天消息变更
    EventMgr:dispatchEvent(EV_REFRESH_WORLDROOM)
end

function ChatDataMgr:onUpdateTeamInvite()
	print("ChatDataMgr:onUpdateTeamInvite--------------------")
    local eventYq = {}
    eventYq.data = {}
    eventYq.data.msgs = self:getChatList(EC_ChatType.TEAM_YQ) or {}
    eventYq.data.chatType = EC_ChatType.TEAM_YQ
    self:reshTeamYq(eventYq)
    local eventP = {}
    eventP.data = {}
    eventP.data.msgs = self:getChatList(EC_ChatType.PRIVATE) or {}
    eventP.data.chatType = EC_ChatType.PRIVATE
    self:reshTeamYq(eventP)
    local eventG = {}
    eventG.data = {}
    eventG.data.msgs = self:getChatList(EC_ChatType.GUILD) or {}
    eventG.data.chatType = EC_ChatType.GUILD
    self:reshTeamYq(eventG)
end

function ChatDataMgr:reshTeamYq(event)
    local chatInfo = event.data
    chatInfo.chatType = chatInfo.chatType or chatInfo.channel
    local chatInfo_ = chatInfo.msgs or {}
    -- print("刷新组队邀请信息--------- chatInfo ",chatInfo)
    -- print("刷新组队邀请信息--------- chatInfo_ ",chatInfo_)
    self.datas[chatInfo.chatType] = {}
    self.datas.customRemoveMsg = {}
    local chatInfoList = self.datas[chatInfo.chatType]
    for i,v in ipairs(chatInfo_) do
        table.insert(chatInfoList,v)
    end

    local prList = nil
    if self.curPrPlayerId ~= -1 then
        prList = self.pData_[self.curPrPlayerId]
        print("last prList ",prList)
        if prList and table.count(prList) > 0 then
            for iu = table.count(prList), 1,-1 do
                if prList[iu].fun and prList[iu].fun == EC_ChatState.TEAM then
                    local isRemoveInfo = true
                    for i,v in ipairs(chatInfo_) do
                        local content = v.content
                        local contentp = prList[iu].content
                        content = json.decode(content)
                        contentp = json.decode(contentp)
                        if content and content.teamid and content.teamid == contentp.teamid then
                            isRemoveInfo = false
                            break
                        end
                    end
                    if isRemoveInfo then
                        self:setReadState(prList[iu].chatType,true)
                        table.remove(prList,iu)
                    end
                end
            end
        end
        print("new prList ",prList)
    end
    --超过最大数量删除最旧的消息
    if #chatInfoList > MAX_MESSAGE_NUM then
        table.remove(chatInfoList,#chatInfoList)
    end

    local isClearTip = true
    if table.count(chatInfoList) == 0 then
        self:setReadState(chatInfo.chatType,true)
    end
    if self.curChatInfo and self.curChatInfo.fun and self.curChatInfo.fun == EC_ChatState.TEAM then
        for i, v in ipairs(chatInfoList) do
            if v.fun and v.fun == EC_ChatState.TEAM then
                local content = v.content
                local contentp = self.curChatInfo.content
                content = json.decode(content)
                contentp = json.decode(contentp)
                if content and content.teamid and content.teamid == contentp.teamid then
                    isClearTip = false
                    break
                end
            end
        end
        if isClearTip then
            self:setReadState(chatInfo.chatType,true)
        end
        if prList then
            for i, v in ipairs(prList) do
                if v.fun and v.fun == EC_ChatState.TEAM then
                    local content = v.content
                    local contentp = self.curChatInfo.content
                    content = json.decode(content)
                    contentp = json.decode(contentp)
                    if content and content.teamid and content.teamid == contentp.teamid then
                        isClearTip = false
                        break
                    end
                end
            end
        end
        if isClearTip then
            EventMgr:dispatchEvent(EV_RED_POINT_UPDATE_CHAT)
            EventMgr:dispatchEvent(EV_RECV_CHATINFO)
            self.curChatInfo = nil
        end
    end
    --通知聊天消息变更
    EventMgr:dispatchEvent(EV_EV_REFRESH_TEAMYQ)
end

function ChatDataMgr:onRecvMarquree(event)
    local data = event.data
    local scrollingCfg = TabDataMgr:getData("ScrollingDisplay",data.scrollId)
    if scrollingCfg then
        local noticyMsg = {}
        local param = {}
        for k,v in ipairs(scrollingCfg.Param) do
            if v == "Name" then
                table.insert(param,data.params[k])
            elseif v == "SpiritName" then
                local itemId = tonumber(data.params[k])
                local itemCfg = GoodsDataMgr:getItemCfg(itemId)
                table.insert(param, TextDataMgr:getText(itemCfg.nameTextId))
            elseif v == "ItemName" then
                local titleId = tonumber(data.params[k])
                local cfg = TitleDataMgr:getTitleCfg(titleId)
                table.insert(param, TextDataMgr:getText(cfg.notable))
                noticyMsg.customContent = true
                local customText = {}
                local descStr = TextDataMgr:getText(scrollingCfg.Details1)
                local descVec = string.split(descStr, "#")
                for k, v in pairs(descVec) do
                    if v == "name1" then
                        customText[#customText + 1] = {text = param[1] or "",color = ccc3(241,221,130)}
                    elseif v == "name2" then
                        customText[#customText + 1] = {text = param[2] or "",color = EC_ItemQualityColor[cfg.titleStar]}
                    else
                        customText[#customText + 1] = {text = v,color = ccc3(255,255,255)}
                    end
                end
                param = customText
            end
        end
        if scrollingCfg.LayoutName ~= "" then
            if scrollingCfg.Details1 ~= 0 then
                noticyMsg.formatId = scrollingCfg.Details1 
            else
                noticyMsg.formatId = scrollingCfg.Details2
            end
            noticyMsg.param = param
            noticyMsg.Interval = scrollingCfg.Interval
            noticyMsg.Mulriple = scrollingCfg.Mulriple
            local layer 
            if scrollingCfg.LayoutName == "All" then
                local currentScene = Public:currentScene()
                if currentScene then
                    layer = currentScene:getTopLayer()
                end
            else
                layer = AlertManager:getLayerBySpecialName(scrollingCfg.LayoutName)
            end
            if layer then
                Utils:showNoticeNode(layer,noticyMsg)
            end
        end
    end
end

function ChatDataMgr:onBlockList(event)
    self.blockPlayers = event.data
end

function ChatDataMgr:getBlockList()
    return self.blockPlayers
end

function ChatDataMgr:onChangeBlockList(event)
    local changeType = event.data.ct
    local pid = event.data.pid
    local isCheck = false
    for i,v in ipairs(self.blockPlayers) do
        if pid == v then
            isCheck = true
            break
        end
    end
    if isCheck == false then
        table.insert(self.blockPlayers,pid)
    end

    if changeType == 1 then
        self:onBlockPlayers()
    else
        self:onUnBlockPlayers()
    end
end

function ChatDataMgr:onBlockPlayers()
    EventMgr:dispatchEvent(EV_BLOCK_PLAYERS)
end

function ChatDataMgr:onUnBlockPlayers()
    EventMgr:dispatchEvent(EV_UNBLOCK_PLAYERS)
end

function ChatDataMgr:isBlockPlayers(playerId)
    if self.blockPlayers == nil then
        return false
    end
    for i,v in ipairs(self.blockPlayers) do
        if playerId == v then
            return true
        end
    end
    return false
end

function ChatDataMgr:onChatRecordWorldInfo(event)
    local respInitChatInfo = event.data
    self.roomId = respInitChatInfo.roomId
    local chatInfos = respInitChatInfo.msgs

    local chatInfoList = self.datas[EC_ChatType.WORLD]

    if chatInfos == nil then
        return
    end
    for i,v in ipairs(chatInfos) do
        local chatInfo = v
        table.insert(chatInfoList,1,chatInfo)
    end
end

function ChatDataMgr:getWorldRoomId()
    return self.roomId
end

--[[
    [1] = {--ChatMsg
        [1] = 'int32':channel   [   聊天类型:1.公共 2.私聊;3.帮派 4.系统 5.队伍]
        [2] = 'int32':fun   [   功能类型:1.聊天 2.深渊组队邀请]
        [3] = 'string':content  [  内容;]
        [4] = 'int32':playerId  [  私聊玩家编号]
    }
--]]
function ChatDataMgr:sendChatInfo(chatType,content,playerId,chatState)
    if chatType == EC_ChatType.BIG_WORLD then  --同屏聊天消息
        OSDDataMgr:sendChatInfo(content)
    else
        playerId = playerId or 0
        local chatInfo = nil
        chatState = chatState or EC_ChatState.CHAT
        print("chatState ",chatState)
        chatInfo = {
                chatType,
                chatState,
                content,
                playerId
            }
        print("sendChatInfo chatInfo",chatInfo)
        TFDirector:send(c2s.CHAT_CHAT,chatInfo)
    end
end

function ChatDataMgr:setSendInfoUnLockState(isUnLockSendInfo)
    self.isUnLockSendInfo = isUnLockSendInfo
end

function ChatDataMgr:getSendInfoUnLockState()
   return self.isUnLockSendInfo
end

function ChatDataMgr:playWaitSendInfo()
    local function delayToGame(dt)
        self.isUnLockSendInfo = true
    end

    self.timer_ = TFDirector:addTimer(3*1000, 1, nil, delayToGame,function()
        if self.timer_ then
            TFDirector:removeTimer(self.timer_)
            self.timer_ = nil
        end
    end)
end


--[[
    [1] = {--GetBlacklist
    }
--]]
-- c2s.CHAT_GET_BLACKLIST = 2308

function ChatDataMgr:sendBlockList()
    local msg = {}
    TFDirector:send(c2s.CHAT_GET_BLACKLIST,msg)
end

--[[
    [1] = {--ReqBlacklistOperate
        [1] = {--OperateType(enum)
            'v4':OperateType
        },
        [2] = 'int32':targetPid
    }
    enum OperateType{
        ADD = 1;        // 添加
        REMOVED = 2;    // 移除
    }
--]]

-- c2s.CHAT_REQ_BLACKLIST_OPERATE = 2309

function ChatDataMgr:sendBlockPlayer(playerId)
    local msg = {1,playerId}
    TFDirector:send(c2s.CHAT_REQ_BLACKLIST_OPERATE,msg)
end

function ChatDataMgr:sendUnBlockPlayer(playerId)
    local msg = {2,playerId}
    TFDirector:send(c2s.CHAT_REQ_BLACKLIST_OPERATE,msg)
end

function ChatDataMgr:getPrivateList()
    return self.pList
end

function ChatDataMgr:getCurPrPlayerId()
    return self.curPrPlayerId
end

function ChatDataMgr:setCurPrPlayerId(playerId)
    self.curPrPlayerId = playerId
end

function ChatDataMgr:addPlayerToPlist(playerInfo)
    local isCheck = false
    self.curPrPlayerId = playerInfo.playerId
    for i,v in ipairs(self.pList) do
        if playerInfo.playerId == v.playerId then
            isCheck = true
            break
        end
    end
    if isCheck == false then
		print("insert")
        table.insert(self.pList,playerInfo)
    end
end

function ChatDataMgr:savePlistDatas(chatInfo)

    self:loadPlistDatas()
    if self.pListData == nil then
        self.pListData = {}
    end
    local curTime = socket.gettime()
    local pInfo = {}
    pInfo.time = curTime
    pInfo.chatInfo = chatInfo
    table.insert(self.pListData,pInfo)

    self:writePlistDatas()

    return true
end

function ChatDataMgr:loadPlistDatas()
    local fileName = MainPlayer:getPlayerId()
    local filePath = "res/basic/cacheData/privateChatData"
    local str = string.format("%s/%s.lua", filePath,fileName)
    local isFile = me.FileUtils:isFileExist( str )
    if isFile == false then return nil end
    --print "-----------测试读取"
    filePath = "res.basic.cacheData.privateChatData"
    str = string.format("%s.%s", filePath,fileName)
    self.pListData = readTable(str)

    -- local curTime = socket.gettime()
    -- for i = table.count(self.pListData),1,-1 do
    --     local info = self.pListData[i]
    --     if curTime - info.time > 20 then
    --         table.remove(self.pListData,i)
    --     end
    -- end

    for i,v in ipairs(self.pListData) do
        local pid = v.chatInfo.pid
        if self.pData_[pid] == nil then
            self.pData_[pid] = {}
        else
            table.insert(self.pData_[pid],chatInfo)
        end
    end

    for k,v in pairs(self.pData_) do
        local num = table.count(v)
        for i = num,1,-1 do
            local info = v[i]
            if i < (num - 5)  then
                table.remove(v,i)
            end
        end
        num = table.count(v)
        if  num == 0 then
            v = nil
        end
    end

    self.datas[EC_ChatType.PRIVATE] = self.pData_

end

function ChatDataMgr:writePlistDatas()
    local fileName = MainPlayer:getPlayerId()
    local filePath = me.FileUtils:getWritablePath() .. 'cacheData/privateChatData/'

    if TFFileUtil:existFile(filePath) == false then
        TFFileUtil:createDir(filePath)
    end
    local str = string.format("%s/%s.lua", filePath,fileName)
    writeTable(self.pListData,str)
end

function ChatDataMgr:getPlistDatas(pid)
    return self.pData_[pid]
end

function ChatDataMgr:addPlistDatas(pid,chatInfo)
    if self.pData_[pid] == nil then
        self.pData_[pid] = {}
    end
    table.insert(self.pData_[pid],1,chatInfo)
end

function ChatDataMgr:chatRecordPrivateInfo()

    local chatInfoList = self.datas[EC_ChatType.PRIVATE]

    for i,v in ipairs(self.pListData) do
        local chatInfo = v.info
        table.insert(chatInfoList,chatInfo)
    end
end

--随机房间
--[[
    [1] = {--ReqChangeRoom
        [1] = 'int32':roomId    [房间号  < 0 则随机,否则转到指定房间]
    }
--]]
-- c2s.CHAT_REQ_CHANGE_ROOM = 2307

function ChatDataMgr:sendChangeRoom(roomId)
    TFDirector:send(c2s.CHAT_REQ_CHANGE_ROOM,{roomId})
end

--清除大世界聊天信息
function ChatDataMgr:clearBigWorldData()
    if self.datas[EC_ChatType.BIG_WORLD] then
        self.datas[EC_ChatType.BIG_WORLD] = {}
    end
end

--社团历史记录消息
function ChatDataMgr:onRecvLeagueHistoryChat( event )
    local data = event.data
    data.msgs = data.msgs or {}
    for k ,v in pairs(data.msgs) do
        self:onRecvChatInfo({data = v})
    end
end


return ChatDataMgr:new()
