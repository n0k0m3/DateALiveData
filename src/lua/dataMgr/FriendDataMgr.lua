
local BaseDataMgr = import(".BaseDataMgr")
local FriendDataMgr = class("FriendDataMgr", BaseDataMgr)

function FriendDataMgr:onLogin()
    TFDirector:send(c2s.FRIEND_REQ_FRIENDS, {})
    self:send_FRIEND_REQ_GET_FRIEND_INVITE_INFO()
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

    self.originFriend_ = {}
    self.recommendFriend_ = {}
    self.receiveCount_ = 0
    self.lastReceiveTime_ = 0
    self.friendInviteInfo_ = {}
    self.maxFriendsNum_ = Utils:getKVP(7001, "maxFriendsNum")
    self.maxReceiveCount_ = Utils:getKVP(7001, "receiveFriendshipTimes")
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
    return self.originFriend_[pid]
end

function FriendDataMgr:setFriendHelpCDtime(pid, cdTime)
    local friendInfo = self:getFriendInfo(pid)
    friendInfo.helpCDtime = cdTime
end

function FriendDataMgr:isCanGiven(pid)
    local friendInfo = self:getFriendInfo(pid)
    local isCanGiven = tobool(friendInfo.canSend)
    return isCanGiven
end

function FriendDataMgr:isCanReceive(pid)
    local friendInfo = self:getFriendInfo(pid)
    return friendInfo.receive
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

return FriendDataMgr:new()
