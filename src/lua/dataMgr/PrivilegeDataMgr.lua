local BaseDataMgr = import(".BaseDataMgr")
local PrivilegeDataMgr = class("PrivilegeDataMgr", BaseDataMgr)

function PrivilegeDataMgr:ctor()
    self:init()
end

function PrivilegeDataMgr:registerMsgEvent()
    TFDirector:addProto(s2c.ANNIVERSARY2ND_RESP_WISH_TREE_INFO, self, self.onRecvWishTreeInfo)
    TFDirector:addProto(s2c.ANNIVERSARY2ND_RESP_UPGRADE_WISH_TREE, self, self.onRecvUpWishTree)
    TFDirector:addProto(s2c.ANNIVERSARY2ND_RESP_CLUB_WISH_TREE_INFO, self, self.onRecvClubWishTreeInfo)
    TFDirector:addProto(s2c.ANNIVERSARY2ND_RESP_SUBMIT_UNION_PROPS, self, self.onRecvUpClubWishTree)
end

function PrivilegeDataMgr:init()
    self:reset()
    self:registerMsgEvent()

    self.privilegeCfg = TabDataMgr:getData("AnniversaryPrivilege")

    self.clubWishTreeCfg = TabDataMgr:getData("ClubMembership")

    ---乐园卡
    self.wishTreeCfg = TabDataMgr:getData("Membership")

end

function PrivilegeDataMgr:onLogin()
    TFDirector:send(c2s.ANNIVERSARY2ND_REQ_WISH_TREE_INFO, {})
    TFDirector:send(c2s.ANNIVERSARY2ND_REQ_CLUB_WISH_TREE_INFO, {})
    return {s2c.ANNIVERSARY2ND_RESP_WISH_TREE_INFO, s2c.ANNIVERSARY2ND_RESP_CLUB_WISH_TREE_INFO}
end

function PrivilegeDataMgr:reset()


end

function PrivilegeDataMgr:getPrivilegeCfg(privilegeId)
    return self.privilegeCfg[privilegeId]
end

---获取乐园卡特权配置
function PrivilegeDataMgr:getWishTreeCfg(cid)

    if not cid then
        return self.wishTreeCfg
    end

    return self.wishTreeCfg[cid]
end

function PrivilegeDataMgr:getWishTreeByLv(lv)

    for k,v in ipairs(self.wishTreeCfg) do
        if v.level == lv then
            return v
        end
    end
end

function PrivilegeDataMgr:getClubWishTreeCfg(cid)
    if not cid then
        return self.clubWishTreeCfg
    end
    return self.clubWishTreeCfg[cid]
end

function PrivilegeDataMgr:getClubWishTreeByLv(lv)

    for k,v in ipairs(self.clubWishTreeCfg) do
        if v.level == lv then
            return v
        end
    end
end

---获取当前乐园卡等级
function PrivilegeDataMgr:getWishTreeCid()

    return self.curWishTreeCid or 0
end

function PrivilegeDataMgr:getWishTreeLv()
    local curCid = self:getWishTreeCid()
    local cfg = self:getWishTreeCfg(curCid)
    if not cfg then
        return 0
    end
    return cfg.level
end

function PrivilegeDataMgr:setWishTreeCid(cid)
    self.curWishTreeCid = cid
end

function PrivilegeDataMgr:setClubWishTreeInfo(clubInfo)

    if not clubInfo then
        return
    end
    self.curClubeWishTreeCid = clubInfo.id
    self.curClubeWishTreeExp = clubInfo.exp
    self.addedCnt = clubInfo.submitTimes
    self.expLimit = clubInfo.expLimit

    dump(clubInfo)
end

---获取社团许愿卡等级,禁言
function PrivilegeDataMgr:getCurClubWishTreeInfo()
    return self.curClubeWishTreeCid or 0,self.curClubeWishTreeExp or 0
end

function PrivilegeDataMgr:getCurClubWishLv()
    local curCid = self:getCurClubWishTreeInfo()
    local cfg = self:getClubWishTreeCfg(curCid)
    if not cfg then
        return 0
    end
    return cfg.level
end

function PrivilegeDataMgr:getAddedCnt()
    return self.addedCnt or 9
end

function PrivilegeDataMgr:getExpLimit()
    return self.expLimit or 0
end

function PrivilegeDataMgr:isWishTreeCanUp()

    local canUp = false
    local curCid = self:getWishTreeCid()
    local nextCid = curCid + 1
    local memberShipCfg = self:getWishTreeCfg(nextCid)
    if not memberShipCfg then
        return canUp
    end


    local costId,costNum
    for k,v in pairs(memberShipCfg.cost) do
        costId,costNum = k,v
        break
    end

    if not costId or not costNum then
        return canUp
    end

    local costItemCfg = GoodsDataMgr:getItemCfg(costId)
    if not costItemCfg then
        return canUp
    end

    local ownCnt = GoodsDataMgr:getItemCount(costId)
    canUp = ownCnt >= costNum

    return canUp
end

---升级乐园卡信息
function PrivilegeDataMgr:Send_UpWishTreeLv()
    TFDirector:send(c2s.ANNIVERSARY2ND_REQ_UPGRADE_WISH_TREE, {})
end

---取得俱乐部许愿树信息
function PrivilegeDataMgr:Send_GetClubWishTree()
    TFDirector:send(c2s.ANNIVERSARY2ND_REQ_CLUB_WISH_TREE_INFO, {})
end

function PrivilegeDataMgr:Send_UpClubWishTreeLv(cid,perNum,repeatNum)
    local props = {}
    for i=1,repeatNum do
        table.insert(props,{cid,perNum})
    end
    dump(props)
    TFDirector:send(c2s.ANNIVERSARY2ND_REQ_SUBMIT_UNION_PROPS, {props})
end

function PrivilegeDataMgr:onRecvWishTreeInfo(event)

    local data = event.data
    if not data then
        return
    end
    
    self:setWishTreeCid(data.id)
end

function PrivilegeDataMgr:onRecvUpWishTree(event)
    local data = event.data
    if not data then
        return
    end
    self:setWishTreeCid(data.id)
    EventMgr:dispatchEvent(EV_UPDATE_WISHTREE_LV)
end

function PrivilegeDataMgr:onRecvClubWishTreeInfo(event)

    local data = event.data
    if not data then
        return
    end
    self:setClubWishTreeInfo(data.clubInfo)
    EventMgr:dispatchEvent(EV_UPDATE_CLUB_WISHTREE_LV)
end

function PrivilegeDataMgr:onRecvUpClubWishTree(event)

    local data = event.data
    if not data then
        return
    end
    self:setClubWishTreeInfo(data.clubInfo)
    if data.reward then
        Utils:showReward(data.reward);
    end
    EventMgr:dispatchEvent(EV_UPDATE_CLUB_WISHTREE_LV)
end

return PrivilegeDataMgr:new()
