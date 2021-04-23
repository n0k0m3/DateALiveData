
local BaseDataMgr = import(".BaseDataMgr")
local FriendDataMgr = class("FriendDataMgr", BaseDataMgr)

function FriendDataMgr:onLogin()
    TFDirector:send(c2s.FRIEND_REQ_FRIENDS, {})
    self:send_FRIEND_REQ_GET_FRIEND_INVITE_INFO()
    self:send_APPRENTICE_REQ_APPRENTICE_LIST()
    self:send_APPRENTICE_REQ_REWARD_STATUS()
    return {s2c.FRIEND_RESP_FRIENDS}
end

function FriendDataMgr:onEnterMain()

end

function FriendDataMgr:reset()
    self.originFriend_ = {}
    self.recommendFriend_ = {}
    self.receiveCount_ = 0
    self.lastReceiveTime_ = 0
    self.friendInviteInfo_ = {}
    self.friendWishWordDec = {}
    self.masterDataDic = {[EC_FriendMaster.Master] = {}, [EC_FriendMaster.Apprentice] = {}}  -- 师门，徒弟
    self.masterApplyDic = {}     -- 申请列表
    self.isMasterExist = {state = false, id = nil}     -- 是否有师父
    self.isApprenticeExist = {state = false, id = nil} -- 是否有徒弟
    self.isInCD = false -- 师徒是否处于冷却中
    self.taskListDic = {} -- 领了任务奖励的阶段
    self.famousListDic = {} -- 领了名师奖励的等级
end

function FriendDataMgr:init()
    TFDirector:addProto(s2c.FRIEND_RESP_FRIENDS, self, self.onRecvFriends)
    TFDirector:addProto(s2c.FRIEND_RESP_RECOMMEND_FRIENDS, self, self.onRecvRecommendFriends)
    TFDirector:addProto(s2c.FRIEND_RESP_QUERY_PLAYER, self, self.onRecvQueryPlayer)
    TFDirector:addProto(s2c.FRIEND_RESP_OPERATE, self, self.onRecvOperateFriend)
    TFDirector:addProto(s2c.FRIEND_RESP_CLEAR_FRIEND_RECEIVE, self, self.onRecvReceiveCount)
    --羁友
    TFDirector:addProto(s2c.FRIEND_RESP_GET_FRIEND_INVITE_INFO, self, self.onRecvFriendInviteInfo)
    TFDirector:addProto(s2c.FRIEND_RESP_BIND_INVITE_CODE, self, self.onRecvBindInviteCode)
    TFDirector:addProto(s2c.FRIEND_RESP_REWARD_INVITE, self, self.onRecvRewardInvite)
    -- 寄语
    TFDirector:addProto(s2c.SPRING_WISH_SPRING_WISH_NOTICE, self, self.onRecvWishWord)
    TFDirector:addProto(s2c.SPRING_WISH_RES_SEND_SPRING_WISH, self, self.onRecvSendWish)
    TFDirector:addProto(s2c.SPRING_WISH_RES_READ_SPRING_WISH, self, self.onRecvRewards) 
    TFDirector:addProto(s2c.SPRING_WISH_RES_READ_ALL_SPRING_WISH, self, self.onRecvRewards) 
    TFDirector:addProto(s2c.SPRING_WISH_RES_GET_REWARD, self, self.onRecvRewards)
    -- 师徒
    TFDirector:addProto(s2c.APPRENTICE_APPRENTICE_NOTICE, self, self.onRecvMasterData) -- 师徒等列表
    TFDirector:addProto(s2c.APPRENTICE_RES_RECOMMEND_LIST, self, self.onRecvMasteApplyList) -- 师徒申请推荐列表
    TFDirector:addProto(s2c.APPRENTICE_RES_HANDLE_APPRENTICE, self, self.onRecvMasteAllApply) -- 申请
    TFDirector:addProto(s2c.APPRENTICE_RES_SEND_GIFT, self, self.onRecvGiveGift)
    TFDirector:addProto(s2c.APPRENTICE_RES_FETCH_GIFT, self, self.onRecvGetGift)
    TFDirector:addProto(s2c.APPRENTICE_RES_SEARCH_PLAYER, self, self.onRecvSearchPlayer)
    TFDirector:addProto(s2c.APPRENTICE_RES_TASK_REWARD, self, self.onRecvGetGift)
    TFDirector:addProto(s2c.APPRENTICE_RES_FAMOUS_REWARD, self, self.onRecvGetGift)
    TFDirector:addProto(s2c.APPRENTICE_RES_REWARD_STATUS, self, self.onRecvTaskStatus)
    
    self.originFriend_ = {}
    self.recommendFriend_ = {}
    self.receiveCount_ = 0
    self.lastReceiveTime_ = 0
    self.friendInviteInfo_ = {}
    self.maxFriendsNum_ = Utils:getKVP(7001, "maxFriendsNum")
    self.maxReceiveCount_ = Utils:getKVP(7001, "receiveFriendshipTimes")
    self:initCfgs()
end

function FriendDataMgr:initCfgs()
    self.instructorLevelCfg = {}
    local instructorLevelCfg = TabDataMgr:getData("InstructorLevel")
    for i, v in pairs(instructorLevelCfg) do 
        table.insert(self.instructorLevelCfg, v)
    end
    table.sort(self.instructorLevelCfg, function(a, b)
        return a.instructorlevel < b.instructorlevel
    end)

    self.drillmasterTaskCfg = {}
    local tabCfg = TabDataMgr:getData("DrillmasterTask")
    for i, v in pairs(tabCfg) do
        if not self.drillmasterTaskCfg[v.rewardType] then
            self.drillmasterTaskCfg[v.rewardType] = {}
        end
        table.insert(self.drillmasterTaskCfg[v.rewardType], v)
    end
end

function FriendDataMgr:getFriend(status)
    if status == EC_Friend.ADD then
        return self.recommendFriend_
    else
        local friend = {}
        for pid, v in pairs(self.originFriend_) do
            if v.status == status then
                table.insert(friend, pid)
            end

        end
        if status == EC_Friend.FRIEND then
            -- local receiveList = {}
            -- local notReceiveList = {}
            -- for i, v in ipairs(friend) do
            --     local friendInfo = self:getFriendInfo(v)
            --     if friendInfo.receive then
            --         table.insert(receiveList, v)
            --     else
            --         table.insert(notReceiveList, v)
            --     end
            -- end
            -- table.sort(receiveList, function(a, b)
            --                local infoA = self:getFriendInfo(a)
            --                local infoB = self:getFriendInfo(b)
            --                if infoA.lvl == infoB.lvl then
            --                    return infoA.pid < infoB.pid
            --                end
            --                return infoA.lvl > infoB.lvl
            -- end)
            -- table.sort(notReceiveList, function(a, b)
            --                local infoA = self:getFriendInfo(a)
            --                local infoB = self:getFriendInfo(b)
            --                if infoA.lvl == infoB.lvl then
            --                    return infoA.pid < infoB.pid
            --                end
            --                return infoA.lvl > infoB.lvl
            -- end)
            -- friend = {}
            -- table.insertTo(friend, receiveList)
            -- table.insertTo(friend, notReceiveList)
        elseif status == EC_Friend.ADD then
            table.sort(friend, function(a, b)
                local infoA = self:getFriendInfo(a)
                local infoB = self:getFriendInfo(b)
                return infoA.time > infoB.time
            end)
        elseif status == EC_Friend.SHIELDING then
            table.sort(friend, function(a, b)
                local infoA = self:getFriendInfo(a)
                local infoB = self:getFriendInfo(b)
                if infoA.lvl == infoB.lvl then
                    return infoA.time > infoB.time
                end
                return infoA.lvl > infoB.lvl
            end)
        end
        return friend
    end
end

function FriendDataMgr:friendIsFull()
    local friend = self:getFriend(EC_Friend.FRIEND)
    return #friend >= self.maxFriendsNum_
end

function FriendDataMgr:isFriend(pid)
    local friendInfo = self:getFriendInfo(pid)
    local rets = friendInfo and friendInfo.status == EC_Friend.FRIEND
    return rets
end

function FriendDataMgr:addFriend(pid)
    if self:friendIsFull() then
        Utils:showTips(210005)
    elseif self:isFriend(pid) then
        Utils:showTips(210001)
    elseif self:isShieldingFriend(pid) then
        Utils:showTips(700042)
    elseif pid == MainPlayer:getPlayerId() then
        Utils:showTips(700053)
    else
        self:removeRecommendFriend(pid)
        self:send_FRIEND_REQ_OPERATE(EC_FriendOp.APPLY_FRIEND, {pid})
    end
end

function FriendDataMgr:getMaxFriendNum()
    return self.maxFriendsNum_
end

function FriendDataMgr:getMaxReceiveCount()
    return self.maxReceiveCount_
end

function FriendDataMgr:agreeFriendApply(pid)
    local friend = self:getFriend(EC_Friend.FRIEND)
    if #friend + #pid > self.maxFriendsNum_ then
        Utils:showTips(210006)
    else
        self:send_FRIEND_REQ_OPERATE(EC_FriendOp.AGREE_APPLY, pid)
    end
end

function FriendDataMgr:isShieldingFriend(pid)
    local friendInfo = self:getFriendInfo(pid)
    local rets = friendInfo and friendInfo.status == EC_Friend.SHIELDING
    return rets
end

function FriendDataMgr:getReceiveCount()
    return self.receiveCount_
end

function FriendDataMgr:getLastRecevieTime()
    return self.lastReceiveTime_
end

function FriendDataMgr:removeRecommendFriend(pid)
    local index
    for i, v in ipairs(self.recommendFriend_) do
        if v.pid == pid then
            index = i
            table.remove(self.recommendFriend_, i)
            break
        end
    end
    EventMgr:dispatchEvent(EV_FRIEND_REMOVEADDFRIEND, index)
end

function FriendDataMgr:getFriendInfo(pid)
	if pid then
		return self.originFriend_[pid]
	end
	return self.originFriend_
end

function FriendDataMgr:setFriendHelpCDtime(pid, cdTime)
    local friendInfo = self:getFriendInfo(pid)
    friendInfo.helpCDtime = cdTime
end

function FriendDataMgr:isCanGiven(pid)
    local friendInfo = self:getFriendInfo(pid)
    local isCanGiven = tobool(friendInfo and friendInfo.canSend)
    return isCanGiven
end

function FriendDataMgr:isCanReceive(pid)
    local friendInfo = self:getFriendInfo(pid)
    return friendInfo and friendInfo.receive
end

function FriendDataMgr:isCanRecvFriendShip()
    local canReceive = false
    local friend = self:getFriend(EC_Friend.FRIEND)
    for i, v in ipairs(friend) do
        if self:isCanReceive(v) then
            canReceive = true
            break
        end
    end
    local receiveCount = self:getReceiveCount()
    canReceive = canReceive and (receiveCount < self.maxReceiveCount_)
    return canReceive
end

function FriendDataMgr:isHaveFriendRequest()
    local friend = self:getFriend(EC_Friend.APPLY)
    local isFull = self:friendIsFull()
    return #friend > 0 and not isFull
end

function FriendDataMgr:isShowRedPointInMainView()
    local isOpen = FunctionDataMgr:isOpen(28)
    local isShow = false
    local isHaveRequest = self:isHaveFriendRequest()
    if isOpen then
        local isCanRecvFriendShip = self:isCanRecvFriendShip()
        isShow = isHaveRequest or isCanRecvFriendShip
    end
    return isShow
end

-- 好友寄语按钮显隐
function FriendDataMgr:isWishBtnShow(frinedId)
    local _bool = true
    -- 活动时间到了关闭了
    local info = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.FRIEND_BLESS)
    if #info == 0 then
        _bool = false
    else 
        local data = ActivityDataMgr2:getActivityInfo(info[1]) 
        local servertime = ServerDataMgr:getServerTime()
        if data.endTime < servertime then
            _bool = false
        end
    end

    -- 是否可以发送寄语
    if self:getFriendWishWordData().sendFriend then
        for i, id in ipairs(self:getFriendWishWordData().sendFriend) do
            if id == frinedId then
                _bool = false
                break
            end
        end 
    end
    return _bool
end

-- 是否有未读寄语
function FriendDataMgr:isBlessWordNoRead()
    local words = self:getFriendWishWordDec()
    local isHave = false
    if words and  #words ~= 0 then
        for i, v in ipairs(words) do
            if not v.read then
                isHave = true
            end
        end
    end
    return isHave
end

-- 是否领取过结算奖励
function FriendDataMgr:isHadGetLastReward()
    return self:getFriendWishWordData().getReward
end

function FriendDataMgr:getFriendWishWordDec()
    local tab = {}
    for i, v in pairs(self.friendWishWordDec or {}) do
        table.insert(tab, v)
    end
    return tab
end

function FriendDataMgr:getFriendWishWordData()
    return self.friendWishWordData or {}
end

function FriendDataMgr:splitGoods(goodsId)
    local goodsInfo = GoodsDataMgr:getSingleItem(goodsId)
    local goodsCfg = GoodsDataMgr:getItemCfg(goodsInfo.cid)
    local goods = {}
    if goodsCfg.pileUp then
        if goodsCfg.pileUp then
            local count = math.floor(goodsInfo.num / goodsCfg.gridMax)
            for i = 1, count do
                local cItem = clone(goodsInfo)
                cItem.num = goodsCfg.gridMax
                local remain = table.insert(goods, cItem)
            end
        end
        local remainNum = math.fmod(goodsInfo.num, goodsCfg.gridMax)
        if remainNum > 0 then
            local cItem = clone(goodsInfo)
            cItem.num = remainNum
            table.insert(goods, cItem)
        end
    else
        table.insert(goods, clone(goodsInfo))
    end

    return goods
end

-- 师傅可赠送背包材料数据
function FriendDataMgr:getMasterCanGiveData()
    local data = {["sum"] = {}} 
    local allBagData = GoodsDataMgr:getAllBagData()
    local filtData   = Utils:getKVP(90024)

    for key, value in pairs(filtData) do
        if not data[key] then
            data[key] = {}
        end
    end

    for key, value in pairs(filtData) do
        -- local tmpData = GoodsDataMgr:getItemsBySuperTyper(value.superType, value.subType)
        for i, item in ipairs(allBagData) do
            local _data = GoodsDataMgr:getSingleItem(item.id)
            local _cfg  = GoodsDataMgr:getItemCfg(_data.cid)

            local _boolType = false
            if _cfg.superType == value.superType then
                if not _cfg.subType then
                    _boolType = true
                else
                    if _cfg.subType == value.subType then
                        _boolType = true
                    end
                end
            end

            local _qualityBool = false
            for i, _quality in ipairs(value.quality) do
                if _cfg.quality == _quality then
                    _qualityBool = true
                end
            end

            local _smallTypebBool = true
            if value.smallType then
                if value.smallType ~= _cfg.smallType then
                    _smallTypebBool = false
                end
            end

            if _qualityBool and _smallTypebBool and _boolType then
                 -- 只是涉及部分参数需要
                 _data["superType"] = _cfg.superType
                 _data["skillType"] = _cfg.skillType
                 table.insert(data["sum"], clone(_data))
                 table.insert(data[key], clone(_data))
            end
        end
    end
    return data
end

function FriendDataMgr:getMasterDataByType(type)
    local tmpData = {}
    if not self.masterDataDic[type] then return tmpData end
    for i, v in pairs(self.masterDataDic[type]) do
        table.insert(tmpData, v)
    end
    table.sort(tmpData, function(a, b)
        local isTopA = a.type == EC_FriendMasterType.Master or a.type == EC_FriendMasterType.Apprentice
        local isTopB = b.type == EC_FriendMasterType.Master or b.type == EC_FriendMasterType.Apprentice
        if isTopA and not isTopB then
            return true
        elseif not isTopA and isTopB then
            return false
        elseif a.type == b.type then
            if a.finished and not b.finished then
                return false
            elseif not a.finished and b.finished then
                return true
            end
        end
    end)
    return tmpData
end

function FriendDataMgr:getMasterApplyList()
    local tmpData = {}
    for i, v in pairs(self.masterApplyDic) do
        table.insert(tmpData, v)
    end
    return tmpData
end

-- 是否可以拜师
function FriendDataMgr:isCanApplyMater()
    -- lv< = 60 and 没有师父 and 冷却时间过了 或者 已出师 
    local limitLv  = Utils:getKVP(90023, "apprenticeClass")
    local playerLv = MainPlayer:getPlayerLv()
    if self:isApprenticeFinished() then
        return false
    end
    if self.isInCD then
        return false
    end
    if not self.isMasterExist.state and limitLv[1] <= playerLv and playerLv <= limitLv[2] then
        return true
    else
        return false
    end
end

--  是否可以收徒
function FriendDataMgr:isCanGetApprentice()
    -- lv > 60 and 没有徒弟 and 冷却时间过了
    local limitLv  = Utils:getKVP(90023, "apprenticeLevel")
    local playerLv = MainPlayer:getPlayerLv()
    if self.isInCD then
        return false
    end
    if not self.isApprenticeExist.state and limitLv[1] <= playerLv and playerLv <= limitLv[2] then
        return true
    else
        return false
    end
end

-- 判断师徒对应所属列表Type
function FriendDataMgr:getMasterTypeById(id)
    for type, v in pairs(self.masterDataDic) do
        if v[id] then
            return type
        end
    end
end

-- 是否有师父、徒弟
function FriendDataMgr:isHaveMasterApprentice()
    return self.isMasterExist.state, self.isApprenticeExist.state
end

-- 返回师父和徒弟的id
function FriendDataMgr:getBothId()
    return self.isMasterExist.id, self.isApprenticeExist.id
end

-- 徒弟是否出师
function FriendDataMgr:isApprenticeFinished()
    local limitLv  = Utils:getKVP(90023, "apprenticeClass")
    local playerLv = MainPlayer:getPlayerLv()
    if self.isMasterExist.state or (not self.isMasterExist.state and not self.isApprenticeExist.state) then  -- 作为徒弟 自己是否出师
        return self.apprenticeFinished or false
    else  -- 作为师父 自己当前教育的学员是否出师
        if self.isApprenticeExist.id then
            local info = self.masterDataDic[EC_FriendMaster.Apprentice][self.isApprenticeExist.id]
            return info.finished
        end
        return false
    end
end

-- 拜师收徒是否处于冷却中
function FriendDataMgr:getIsInCD()
    return self.isInCD
end

-- 名师奖励指定等级有没领取
function FriendDataMgr:getFamousBoolByLv(lv)
    return nil ~= self.famousListDic[lv]
end

-- 任务奖励的指定阶段有没有领取
function FriendDataMgr:getTaskBoolByStage(idx)
    return nil ~= self.taskListDic[idx]
end

-- 根据名师经验获得等级
function FriendDataMgr:getFamousLvByExperience(num)
    num = num or 0
    local famousLv = nil
    for i, v in ipairs(self.instructorLevelCfg) do 
        if v.updateExp > num and not famousLv then
            famousLv = v.instructorlevel - 1
            break
        elseif v.updateExp == num then
            famousLv = v.instructorlevel
            break
        end
    end
    -- 达到最大等级
    local biggstLvData = self.instructorLevelCfg[#self.instructorLevelCfg]
    if num >= biggstLvData.updateExp then
        famousLv = biggstLvData.instructorlevel
    end
    return famousLv or 0
end

function FriendDataMgr:getInstructorLevelCfg()
    return self.instructorLevelCfg
end

function FriendDataMgr:getDrillmasterTaskCfg(type)
    return self.drillmasterTaskCfg[type]
end

-- 是否有名师奖励可领取
function FriendDataMgr:isHaveMasterAwardsCanGet()
    local _bool = false
    local experienceItemId  = Utils:getKVP(90023, "experienceItemId")
    local exprienceItemNum = GoodsDataMgr:getItemCount(experienceItemId) or 0
    local curFamousLv = self:getFamousLvByExperience(exprienceItemNum)
    for i, v in ipairs(self.instructorLevelCfg) do
        local isHadGet = self:getFamousBoolByLv(v.instructorlevel)
        if v.instructorlevel <= curFamousLv and not isHadGet  then
            _bool = true
            break
        end
    end
    return _bool
end

-- 是否有任务奖励可领取
function FriendDataMgr:isHaveMasterTaskAwardCanGet()
    local type  = nil
    local _bool = false
    if self.isMasterExist.state then
        type = 2
    elseif self.isApprenticeExist.state then
        type = 1
    end

    if type then
        for i, v in ipairs(self.drillmasterTaskCfg[type]) do
            local isHadGet = self:getTaskBoolByStage(v.taskStage)
            local isFinishAllLittleTask = true
            for j, taskCid in pairs(v.finishParams) do
                local taskInfo = TaskDataMgr:getTaskInfo(taskCid)
                if taskInfo then
                    if taskInfo.status == EC_TaskStatus.ING then
                        isFinishAllLittleTask = false
                        break
                    end
                else
                    isFinishAllLittleTask = false
                end
            end
            if isFinishAllLittleTask and not isHadGet then
                _bool = true
                break
            end 
        end
    end

    if self:isApprenticeFinished() then
        _bool = false
    end

    return _bool
end

-- 申请列表红点显隐
function FriendDataMgr:isApplyBtnRedShow()
    return table.count(self.masterApplyDic) ~= 0
end

-- 是否有师父赠礼
function FriendDataMgr:isHaveMasterGiveGift()
    local _bool = false
    if self.isMasterExist.state then
        local data = self:getMasterDataByType(EC_FriendMaster.Master)
        for i, v in ipairs(data) do
            if v.type == EC_FriendMasterType.Master and v.hasGift then
                _bool = true
                break
            end
        end
    end
    return _bool
end

-- 师徒相关红点显隐
function FriendDataMgr:isMasterRelationShow()
    local _bool = false
    if self:isHaveMasterAwardsCanGet() or self:isHaveMasterTaskAwardCanGet() or self:isApplyBtnRedShow() or self:isHaveMasterGiveGift() then
        _bool = true
    end
    return _bool
end

------------------------------------------------------------

function FriendDataMgr:send_FRIEND_REQ_RECOMMEND_FRIENDS()
    TFDirector:send(c2s.FRIEND_REQ_RECOMMEND_FRIENDS, {})
end

function FriendDataMgr:send_FRIEND_REQ_QUERY_PLAYER(playerId)
    TFDirector:send(c2s.FRIEND_REQ_QUERY_PLAYER, {playerId})
end

function FriendDataMgr:send_FRIEND_REQ_OPERATE(type_, targets)
    TFDirector:send(c2s.FRIEND_REQ_OPERATE, {type_, targets})
end

--羁友消息发送
--3078
function FriendDataMgr:send_FRIEND_REQ_GET_FRIEND_INVITE_INFO()
    TFDirector:send(c2s.FRIEND_REQ_GET_FRIEND_INVITE_INFO, {})
end

--3079
function FriendDataMgr:send_FRIEND_REQ_BIND_INVITE_CODE(inviteCode)
    local msg = {
        inviteCode
    }
    TFDirector:send(c2s.FRIEND_REQ_BIND_INVITE_CODE, msg)
end

--3080
function FriendDataMgr:send_FRIEND_REQ_REWARD_INVITE(rewardCid)
    local msg = {
        rewardCid
    }
    TFDirector:send(c2s.FRIEND_REQ_REWARD_INVITE, msg)
end
 
-- 7501
function FriendDataMgr:send_SPRING_WISH_REQ_SEND_SPRING_WISH(friendId, content)
    TFDirector:send(c2s.SPRING_WISH_REQ_SEND_SPRING_WISH, {friendId, content})
end

-- 7502
function FriendDataMgr:send_SPRING_WISH_REQ_READ_SPRING_WISH(id)
    TFDirector:send(c2s.SPRING_WISH_REQ_READ_SPRING_WISH, {id})
end

-- 7503
function FriendDataMgr:send_SPRING_WISH_REQ_READ_ALL_SPRING_WISH()
    TFDirector:send(c2s.SPRING_WISH_REQ_READ_ALL_SPRING_WISH, {})
end

-- 7504
function FriendDataMgr:send_SPRING_WISH_REQ_DELETE_SPRING_WISH(id)
    TFDirector:send(c2s.SPRING_WISH_REQ_DELETE_SPRING_WISH, {id})
end

-- 7505
function FriendDataMgr:send_SPRING_WISH_REQ_GET_REWARD()
    TFDirector:send(c2s.SPRING_WISH_REQ_GET_REWARD, {})
end

-- 7901 -- @kind 1请求列表,2刷新   @type 1徒弟推荐列表,2师父推荐列表
function FriendDataMgr:send_APPRENTICE_REQ_RECOMMEND_LIST(kind, type)
    TFDirector:send(c2s.APPRENTICE_REQ_RECOMMEND_LIST, {kind, type})
end

-- 7902
--[[
    -- @desc:服务器给的协议备注
    //type=1，申请收徒，playerId是潜在徒弟id
    //type=2，申请拜师，playerId是潜在师父id
    //type=3，同意收徒申请，playerId是申请人id
    //type=4，拒绝收徒申请，playerId是申请人id
    //type=5，同意拜师申请，playerId是申请人id
    //type=6，拒绝拜师申请，playerId是申请人id
    //type=7，师父解除关系，playerId是徒弟id
    //type=8，徒弟解除关系，playerId是师父id
    //type=9，师父点击出师，playerId是徒弟id
    //type=10，徒弟点击出师，playerId是师父id
]]
function FriendDataMgr:send_APPRENTICE_REQ_HANDLE_APPRENTICE(type, playerId)
    TFDirector:send(c2s.APPRENTICE_REQ_HANDLE_APPRENTICE, {playerId, type})
end

-- 7903
function FriendDataMgr:send_APPRENTICE_REQ_APPRENTICE_LIST()
    TFDirector:send(c2s.APPRENTICE_REQ_APPRENTICE_LIST, {})
end

-- 7904
function FriendDataMgr:send_APPRENTICE_REQ_SEND_GIFT(giftsTab)
    TFDirector:send(c2s.APPRENTICE_REQ_SEND_GIFT, {giftsTab})
end

-- 7905
function FriendDataMgr:send_APPRENTICE_REQ_FETCH_GIFT()
    TFDirector:send(c2s.APPRENTICE_REQ_FETCH_GIFT, {})
end

-- 7907
function FriendDataMgr:send_APPRENTICE_REQ_SEARCH_PLAYER(id)
    TFDirector:send(c2s.APPRENTICE_REQ_SEARCH_PLAYER, {id})
end

-- 7908
function FriendDataMgr:send_APPRENTICE_REQ_TASK_REWARD(taskId)
    TFDirector:send(c2s.APPRENTICE_REQ_TASK_REWARD, {taskId})
end

-- 7909
function FriendDataMgr:send_APPRENTICE_REQ_FAMOUS_REWARD(lv)
    TFDirector:send(c2s.APPRENTICE_REQ_FAMOUS_REWARD, {lv})
end

-- 7910
function FriendDataMgr:send_APPRENTICE_REQ_REWARD_STATUS()
    TFDirector:send(c2s.APPRENTICE_REQ_REWARD_STATUS, {})
end


function FriendDataMgr:onRecvRecommendFriends(event)
    local data = event.data
    if not data.friends then return end
    self.recommendFriend_ = data.friends
    EventMgr:dispatchEvent(EV_FRIEND_RECOMMENDFRIEND)
end

function FriendDataMgr:onRecvQueryPlayer(event)
    local data = event.data
    EventMgr:dispatchEvent(EV_FRIEND_QUERYPLAYER, data)
end

function FriendDataMgr:onRecvFriends(event)
    local data = event.data
    self.receiveCount_ = data.receiveCount
    self.lastReceiveTime_ = data.lastReceiveTime
    if not data.friends then return end

    local function attrAssgin(target, src)
        for k, v in pairs(src) do
            target[k] = v
        end
    end

    for i, v in ipairs(data.friends) do
        local oldItem, newItem
        if v.ct == EC_SChangeType.DEFAULT then
            oldItem = self.originFriend_[v.pid]
            newItem = {}
            attrAssgin(newItem, v)
            self.originFriend_[v.pid] = newItem
        elseif v.ct == EC_SChangeType.ADD then
            oldItem = self.originFriend_[v.pid]
            newItem = {}
            attrAssgin(newItem, v)
            self.originFriend_[v.pid] = newItem
        elseif v.ct == EC_SChangeType.UPDATE then
            newItem = self.originFriend_[v.pid] or {}
            oldItem = clone(newItem)
            attrAssgin(newItem, v)
        elseif v.ct == EC_SChangeType.DELETE then
            oldItem = self.originFriend_[v.pid]
            newItem = nil
            self.originFriend_[v.pid] = nil
        end
    end
    EventMgr:dispatchEvent(EV_FRIEND_UPDATE)
end

function FriendDataMgr:onRecvOperateFriend(event)
    local data = event.data

    if data.type == EC_FriendOp.SHIELD_PLAYER then
        for i, v in ipairs(data.targets) do
            self:removeRecommendFriend(v)
        end
    elseif data.type == EC_FriendOp.APPLY_FRIEND then
        Utils:showTips(700047)
    end

    EventMgr:dispatchEvent(EV_FRIEND_OPERATEFRIEND, data.type, data.targets)
end

function FriendDataMgr:onRecvReceiveCount(event)
    local data = event.data
    self.receiveCount_ = 0
    for pid, v in pairs(self.originFriend_) do
        if v.status == EC_Friend.FRIEND then
            v.receive = false
            v.canSend = true
        end
    end
    EventMgr:dispatchEvent(EV_FRIEND_UPDATE)
end

--羁友消息回复
--3078
function FriendDataMgr:onRecvFriendInviteInfo(event)
    local data = event.data or {}
    --dump(data, "FriendDataMgr:onRecvFriendInviteInfo")
    -- required bool showInviteCode = 1;		// 是否显示邀请码（达到指定等级后显示自己的邀请码）
    -- required int32 limitLev = 2;           //邀请码限制等级
    -- optional string selfInviteCode = 3;    //自己的邀请码
    -- optional string bindInviteCode = 4;    //已绑定的别人的邀请码
    -- optional int32 maxBindNum = 5;         //邀请码最大可绑定数量
    -- repeated InviteRewardInfo rewardInfos = 6;	// 好友邀请奖励领取信息
    -- optional int32 bindNum = 7;            //自己的邀请码已被绑定的次数
    local invitedata = {}
    invitedata.bOpen = tobool(data.open)
    invitedata.bShowCode = tobool(data.showInviteCode)
    invitedata.limitLev = data.limitLev
    invitedata.selfCode = data.selfInviteCode or ""
    MainPlayer:setSelfInviteCode(invitedata.selfCode)
    invitedata.bindCode = data.bindInviteCode
    invitedata.bindNum = data.bindNum or 0
    invitedata.maxBindNum = data.maxBindNum or 0
    --0-不可领取 1-可领取 2-已领取
    invitedata.rewardList0 = {}--不可领取
    invitedata.rewardList1 = {}--可领取
    invitedata.rewardList2 = {}--已领取
    local rewardInfos = data.rewardInfos or {}
    for i, v in ipairs(rewardInfos) do
        if v.status == 0 then
            table.insert(invitedata.rewardList0, clone(v))
        elseif v.status == 1 then
            table.insert(invitedata.rewardList1, clone(v))
        elseif v.status == 2 then
            table.insert(invitedata.rewardList2, clone(v))
        end
    end
    table.sort(invitedata.rewardList0, function(a, b)
        return a.cid < b.cid
    end)
    table.sort(invitedata.rewardList1, function(a, b)
        return a.cid < b.cid
    end)
    table.sort(invitedata.rewardList2, function(a, b)
        return a.cid < b.cid
    end)
    self.friendInviteInfo_ = nil
    self.friendInviteInfo_ = invitedata
    EventMgr:dispatchEvent(EV_FRIEND_INVITE_UPDATE, invitedata)
end

--3079
function FriendDataMgr:onRecvBindInviteCode(event)
    Utils:showTips(263105)
end

--3080
function FriendDataMgr:onRecvRewardInvite(event)
    local data = event.data or {}
    local rewardlist = data.rewardInfos or {}
    local itemList = data.rewardItems or {}
    for i, v in ipairs(rewardlist) do
        for oldi, oldv in ipairs(self.friendInviteInfo_.rewardList1) do
            if v.cid == oldv.cid then
                table.remove(self.friendInviteInfo_.rewardList1, oldi)
                table.insert(self.friendInviteInfo_.rewardList2, clone(v))
                Utils:showReward(itemList)
                EventMgr:dispatchEvent(EV_FRIEND_INVITE_UPDATE, self.friendInviteInfo_)
                return
            end
        end
    end
end

-- 7506
function FriendDataMgr:onRecvWishWord(event)
    local data = event.data or {}
    if not self.friendWishWordDec then
        self.friendWishWordDec = {}
    end

    self.friendWishWordData = data
    if data.changeType == EC_SChangeType.DELETE then
        if data.springWishInfo then
            for i, v in ipairs(data.springWishInfo) do
                if self.friendWishWordDec[v.id] then
                    self.friendWishWordDec[v.id]  = nil
                end
            end
        end
    else
        if data.springWishInfo then
            for i, v in ipairs(data.springWishInfo) do
                self.friendWishWordDec[v.id] = v
            end
        end
    end
    EventMgr:dispatchEvent(EV_FRIEND_WISHWORD_UPDATE)
    EventMgr:dispatchEvent(EV_FRIEND_UPDATE)
    EventMgr:dispatchEvent(EV_ACTIVITY_UPDATE_PROGRESS)
end

-- 7501
function FriendDataMgr:onRecvSendWish(event)
    local data = event.data 
    if not data then
        return
    end
    EventMgr:dispatchEvent(EV_FRIEND_SENDWISH_SUCCESS, data)
end

function FriendDataMgr:onRecvRewards(event)
    local data = event.data 
    if not data then
        return
    end
    if data and data.rewards then
        Utils:showReward(data.rewards)
    end
end

-- 7906
function FriendDataMgr:onRecvMasterData(event)
    local data = event.data or {}
    if not data then
        return
    end
    dump(data)
    self.isInCD = data.isCD
    self.apprenticeFinished = data.finished  -- 针对作为徒弟是否出师
    -- @type: 1师父，2师门，3徒弟，4申请收徒，5申请拜师
    for i, v in ipairs(data.apprenticeList or {}) do
        if v.ct == EC_SChangeType.DELETE then
            if v.type == EC_FriendMasterType.Master or v.type == EC_FriendMasterType.SameGate then
                if v.type == EC_FriendMasterType.Master then  -- 删除对象为师父时 对应师门内容清空(应服务器要求)
                    self.masterDataDic[EC_FriendMaster.Master]= nil
                    self.masterDataDic[EC_FriendMaster.Master] = {}
                    self.isMasterExist = {state = false, id = nil}
                else
                    self.masterDataDic[EC_FriendMaster.Master][v.playerId] = nil
                end
                EventMgr:dispatchEvent(EV_FRIEND_MASTER_UPDATE, EC_FriendMaster.Master)
            elseif v.type == EC_FriendMasterType.Apprentice then
                if self.isApprenticeExist.state and self.isApprenticeExist.id == v.playerId and not v.finished then
                    self.isApprenticeExist = {state = false, id = nil}
                end
                self.masterDataDic[EC_FriendMaster.Apprentice][v.playerId] = nil
                EventMgr:dispatchEvent(EV_FRIEND_MASTER_UPDATE, EC_FriendMaster.Apprentice)
            else
                self.masterApplyDic[v.playerId] = nil
                EventMgr:dispatchEvent(EV_FRIEND_MASTERAPPLYLIST_UPDATE, self:getMasterApplyList())
            end
        else
            if v.type == EC_FriendMasterType.Master or v.type == EC_FriendMasterType.SameGate then
                if v.type == EC_FriendMasterType.Master then
                    if  not data.finished  then
                        self.isMasterExist = {state = true, id = v.playerId}
                    else
                        self.isMasterExist = {state = false, id = nil}
                    end
                end
                if nil == self.masterDataDic[EC_FriendMaster.Master][v.playerId] then
                    --  服务器可能不会下发的数据 给个默认值
                    if not v["famousExp"] then
                        v["famousExp"] = 0
                    end
                    self.masterDataDic[EC_FriendMaster.Master][v.playerId] = v
                else
                    for key, value in pairs(v) do
                        self.masterDataDic[EC_FriendMaster.Master][v.playerId][key] = value
                    end
                end
                EventMgr:dispatchEvent(EV_FRIEND_MASTER_UPDATE, EC_FriendMaster.Master)
            elseif v.type == EC_FriendMasterType.Apprentice then
                if nil == self.masterDataDic[EC_FriendMaster.Apprentice][v.playerId] and not v.finished then
                    self.isApprenticeExist = {state = true, id = v.playerId}
                else
                    -- 更新
                    if self.isApprenticeExist.state and self.isApprenticeExist.id == v.playerId and v.finished then
                        self.isApprenticeExist = {state = false, id = nil}
                        self.apprenticeFinished = v.finished
                    end
                end

                if nil == self.masterDataDic[EC_FriendMaster.Apprentice][v.playerId] then
                    if not v["famousExp"] then
                        v["famousExp"] = 0
                    end
                    self.masterDataDic[EC_FriendMaster.Apprentice][v.playerId] = v
                else
                    for key, value in pairs(v) do
                        self.masterDataDic[EC_FriendMaster.Apprentice][v.playerId][key] = value
                    end
                end
                EventMgr:dispatchEvent(EV_FRIEND_MASTER_UPDATE, EC_FriendMaster.Apprentice)
            else
                if nil == self.masterApplyDic[v.playerId] then
                    self.masterApplyDic[v.playerId] = v
                else
                    for key, value in pairs(self.masterApplyDic[v.playerId]) do
                        if nil ~= v[key] then
                            value = v[key]
                        end
                    end
                end
                EventMgr:dispatchEvent(EV_FRIEND_MASTERAPPLYLIST_UPDATE, self:getMasterApplyList())
            end
        end
    end
end

function FriendDataMgr:onRecvMasteApplyList(event)
    local data = event.data 
    if not data then
        return
    end
    EventMgr:dispatchEvent(EV_FRIEND_MASTERRECOMMEND_UPDATE, data.recommendList or {})
end

--[[
    //type=1，申请收徒
    //type=2，申请拜师
    //type=3，同意收徒申请
    //type=4，拒绝收徒申请
    //type=5，同意拜师申请
    //type=6，拒绝拜师申请
    //type=7，师父解除关系
    //type=8，徒弟解除关系
    //type=9，师父点击出师
    //type=10，徒弟点击出师
]]
function FriendDataMgr:onRecvMasteAllApply(event)
    local data = event.data 
    if not data then
        return
    end
    if data.success then
        local type = data.type
        if type == 1 or type == 2 then
            Utils:showTips(1340058)
            FriendDataMgr:send_APPRENTICE_REQ_RECOMMEND_LIST(1, type)
        elseif type == 9 or type == 10 then
            EventMgr:dispatchEvent(EV_FRIEND_OUTMASTER_UPDATE)
        end
    end
end

function FriendDataMgr:onRecvGiveGift(event)
    local data = event.data 
    if not data then
        return
    end
    if data.success then
        Utils:showTips(1340033)
        EventMgr:dispatchEvent(EV_FREND_MASTERGIVEGIFT_UPDATE)
    else
        Utils:showTips(1340034)
    end
end

function FriendDataMgr:onRecvGetGift(event)
    local data = event.data 
    if not data then
        return
    end
    if data.rewards then
        Utils:showReward(data.rewards)
    end
    EventMgr:dispatchEvent(EV_FREND_MASTERGITGIFT_UPDATE)
end

function FriendDataMgr:onRecvSearchPlayer(event)
    local data = event.data 
    if not data then
        return
    end
    if data.success then
        EventMgr:dispatchEvent(EV_FRIEND_MASTERRECOMMEND_UPDATE, data.apprenticeInfo or {})
    else
        Utils:showTips(1340035)
    end
end

function FriendDataMgr:onRecvTaskStatus(event)
    local data = event.data 
    if not data then
        return
    end

    data.taskList = data.taskList or {}
    data.famousList = data.famousList or {}

    if #data.taskList == 0 then
        self.taskListDic = nil
        self.taskListDic = {}
    else
        for i, v in ipairs(data.taskList) do
            self.taskListDic[v] = v
        end
    end

    if #data.famousList == 0 then
        self.famousListDic = nil
        self.famousListDic = {}
    else
        for i, v in ipairs(data.famousList) do
            self.famousListDic[v] = v
        end
    end
    EventMgr:dispatchEvent(EV_FRIEND_MASTERGETREWARD_UPDATE)
end

return FriendDataMgr:new()
