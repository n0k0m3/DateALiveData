
local BaseDataMgr = import(".BaseDataMgr")
local StoreDataMgr = class("StoreDataMgr", BaseDataMgr)

function StoreDataMgr:onLogin()
    TFDirector:send(c2s.PLAYER_REQ_BUY_RESOURCES_LOG, {})
    TFDirector:send(c2s.STORE_GET_COMMODITY_BUY_LOG, {})
    TFDirector:send(c2s.STORE_GET_STORE_INFO, {})
    return {s2c.STORE_COMMODITY_BUY_LOGS, s2c.PLAYER_RESP_BUY_RESOURCES_LOG, s2c.STORE_STORE_DATA_INFO}
end

function StoreDataMgr:onEnterMain()

end

function StoreDataMgr:reset()
    self.commodity_ = {}
    self.storeInfo_ = {}
    self.buyInfo_ = {}
    self.commodityState = {};
    self.itemRecoverInfo_ = {}
    self.commodity_ = {}
    self.storeMap_ = {}
    self.commodityMap_ = {}
    self.store_ = {}
end

function StoreDataMgr:init()
    TFDirector:addProto(s2c.STORE_COMMODITY_BUY_LOGS, self, self.onRecvBuyInfo)
    TFDirector:addProto(s2c.STORE_STORE_DATA_INFO, self, self.onRecvStoreInfo)
    TFDirector:addProto(s2c.STORE_BUY_GOODS, self, self.onRecvBuyGoodsSuccess)
    TFDirector:addProto(s2c.STORE_REFRESH_STORE, self, self.onRecvRefreshShop)
    TFDirector:addProto(s2c.STORE_SELL_INFO, self, self.onRecvSellGoods)
    TFDirector:addProto(s2c.PLAYER_RESP_BUY_RESOURCES_LOG, self, self.onRecvResourceBuyLog)
    TFDirector:addProto(s2c.PLAYER_RESP_BUY_RESOURCES, self, self.onRecvBuyResource)
    TFDirector:addProto(s2c.STORE_RES_SELL_GOODS_PREVIEW, self, self.onRecvSellPreview)

    -- 次数道具
    self.itemRecoverMap_ = TabDataMgr:getData("ItemRecover")

    self:reset()
end

function StoreDataMgr:sortWithCommodity(storeId)
    local commodity = self.commodity_[storeId]
    local storeCfg = self:getStoreCfg(storeId)
    local orderType = 1;
    if storeCfg.extra then
        local jsonData = json.decode(storeCfg.extra);
        orderType = jsonData.orderType or 1;
    end 

    table.sort(commodity, function(a, b)
        local cfgA = self.commodityMap_[a]
        local cfgB = self.commodityMap_[b]
        if cfgA and cfgB then
            if orderType == 1 then
                return cfgA.order < cfgB.order
            else
                local stateA = self:getCommodityState(cfgA.id);
                local stateB = self:getCommodityState(cfgB.id);
                if stateA == stateB then
                    return cfgA.order < cfgB.order
                else
                    return stateA < stateB;
                end
            end
        else
            return false
        end
    end)
end

function StoreDataMgr:getStore(storeType)
    local store = {}
    for i, v in ipairs(self.store_) do
        local cfg = self.storeMap_[v]
        if cfg.storeType == storeType then
            table.insert(store, v)
        end
    end
    return store
end

function StoreDataMgr:isOpen(storeCid)
    local cfg = self:getStoreCfg(storeCid)
    local isOpen = false
    if cfg.openContType == 1 then    -- 玩家等级
        isOpen = MainPlayer:getPlayerLv() >= cfg.openContVal
    elseif cfg.openContType == 2 then  -- 关卡等级
        isOpen = FubenDataMgr:isPassPlotLevel(cfg.openContVal)
    elseif cfg.openContType == 3 then  -- 社团等级
        if LeagueDataMgr:checkSelfInUnion() then
            isOpen = LeagueDataMgr:getUnionLevel() >= cfg.openContVal
        end
    elseif cfg.openContType == 4 or cfg.openContType == 5 then  -- 七日狂欢开启,七日狂欢关闭
        isOpen = true
    elseif cfg.openContType == 7 then    -- 春日祭活动开启
        isOpen = true
    elseif cfg.openContType == 8 then    -- 十香生日活动开启
        isOpen = true
    end

    if storeCid == 100000 then     -- 普通商店放到补给站
        isOpen = false
    end 

    return isOpen
end

function StoreDataMgr:getOpenStore(storeType)
    local condStore = {}
    local store = {}
    -- 开启条件判断
    for i, v in ipairs(self.store_) do
        local cfg = self.storeMap_[v]
        if cfg.storeType == storeType then
            if self:isOpen(v) then
                table.insert(condStore, v)
            end
        end
    end
    -- 开启时间判断
    for i, v in ipairs(condStore) do
        local isOpen = self:isOpenTime(v)
        if isOpen then
            table.insert(store, v)
        end
    end

    return store
end

function StoreDataMgr:isOpenTime(storeId)
    local storeCfg = self:getStoreCfg(storeId)
    local serverTime = ServerDataMgr:getServerTime()
    local rets = true
    if storeCfg.showBeginTime and storeCfg.showEndTime then
        rets = serverTime >= storeCfg.showBeginTime and serverTime < storeCfg.showEndTime
    end
    return rets, storeCfg.showEndTime
end

function StoreDataMgr:getStoreCfg(storeId)
    return self.storeMap_[storeId]
end

function StoreDataMgr:getItemRecoverCfg(cid)
    return self.itemRecoverMap_[cid]
end

function StoreDataMgr:isUnlockCommodity(commodityCid)

    ---isShow:是否展示出来
    local isUnlock,isShow = false,false
    local commodityCfg = self:getCommodityCfg(commodityCid)
    if not commodityCfg then
        return false,false
    end
    if commodityCfg.openContType == 1 then    -- 玩家等级
        isUnlock = MainPlayer:getPlayerLv() >= commodityCfg.openContVal
    elseif commodityCfg.openContType == 2 then  -- 关卡等级
        isUnlock = FubenDataMgr:isPassPlotLevel(commodityCfg.openContVal)
    elseif commodityCfg.openContType == 3 then  -- 社团等级
        --isUnlock = LeagueDataMgr:getUnionLevel() >= commodityCfg.openContVal
        isUnlock = true
    elseif commodityCfg.openContType == 4 or commodityCfg.openContType == 5 then  -- 七日狂欢开启,七日狂欢关闭
        isUnlock = true
    elseif commodityCfg.openContType == 7 then    -- 大富翁商店
        isUnlock = true
    elseif commodityCfg.openContType == 8 then    -- 十香生日活动商店
        isUnlock = true
    elseif commodityCfg.openContType == 14 then ---个人特权
        isUnlock = PrivilegeDataMgr:getWishTreeLv() >= commodityCfg.openContVal
        isShow = true
    end
    return isUnlock,isShow,commodityCfg.openContVal
end

function StoreDataMgr:getCommodity(storeId)
    local canBuyCommodity = {}
    local notBuyCommodity = {}
    local serverTime = ServerDataMgr:getServerTime()
    for i, v in ipairs(self.commodity_[storeId] or {}) do
        local commodityCfg = self:getCommodityCfg(v)
        local isUnlock,isShow = self:isUnlockCommodity(v)
        local isOpen = true
        if commodityCfg.showBeginTime and commodityCfg.showEndTime and commodityCfg.showBeginTime ~= "" and commodityCfg.showEndTime ~= "" then
            isOpen = serverTime >= commodityCfg.showBeginTime and serverTime < commodityCfg.showEndTime
        end
        if isOpen then
            print(isUnlock,isShow)
            if isUnlock or isShow then
                local isCanBuy = self:getRemainBuyCount(v)
                if isCanBuy then
                    table.insert(canBuyCommodity, v)
                else
                    table.insert(notBuyCommodity, v)
                end
            end
        end

    end

    local commodity = {}
    table.insertTo(commodity, canBuyCommodity)
    table.insertTo(commodity, notBuyCommodity)

    return commodity
end

function StoreDataMgr:getCommodityCfg(commodityId)
    return self.commodityMap_[commodityId]
end

function StoreDataMgr:getStoreInfo(storeId)
    if storeId then
        return self.storeInfo_[storeId]
    else
        return self.storeInfo_
    end
end

function StoreDataMgr:getBuyInfo(commodityId)
    if commodityId then
        return self.buyInfo_[commodityId]
    else
        return self.buyInfo_
    end
end

function StoreDataMgr:getItemRecoverInfo(cid)
    return self.itemRecoverInfo_[cid]
end

function StoreDataMgr:getItemRecoverBuyCount(cid)
    local itemRecoverInfo = self:getItemRecoverInfo(cid)
    local count = 0
    if itemRecoverInfo then
        count = itemRecoverInfo.count
    end
    return count
end

function StoreDataMgr:canBuyItemRecover(cid, count)
    local itemRecoverCfg = self:getItemRecoverCfg(cid)
    local canBuy = false
    local condIndex
    if itemRecoverCfg.price then
        local price = itemRecoverCfg.price[count]
        for i, v in ipairs(price) do
            local reach = true
            for _, cost in ipairs(v) do
                if not GoodsDataMgr:currencyIsEnough(cost.id, cost.num) then
                    reach = false
                    break
                end
            end
            if reach then
                canBuy = true
                condIndex = i
                break
            end
        end
    end
    return canBuy, condIndex
end

function StoreDataMgr:getMaxRecoverCount(cid)
    return self:getItemRecoverCfg(cid).maxRecoverCount
end

function StoreDataMgr:getBuyItemRecoverFromInfo(cid,count)
    local itemRecoverCfg = self:getItemRecoverCfg(cid)
    local goodsInfo = {}
    if itemRecoverCfg.price then
        local price = itemRecoverCfg.price[count]
        -- print("price ",price)
        for i, v in ipairs(price) do
            -- print("v ",v)
            for it,vt in ipairs(v) do
                goodsInfo[vt.id] = vt.num
            end
        end
    end
    return goodsInfo
end

function StoreDataMgr:canContinueBuyItemRecover(cid)
    local hadUseNum = 0
    local isHavePrivilege, cfg = RechargeDataMgr:getIsHavePrivilegeByType(104)
    local _cfg = self:getItemRecoverInfo(cid)
    if isHavePrivilege and cfg.privilege.itemRecoverId == cid and _cfg then
        if not _cfg.discountNum then
            hadUseNum = cfg.privilege.chance
        end
    end 

    local itemRecoverCfg = self:getItemRecoverCfg(cid)
    local buyCount = self:getItemRecoverBuyCount(cid)
    local maxCount = #itemRecoverCfg.price
    local remainCount = me.clampf(maxCount + hadUseNum - buyCount, 0, maxCount)
    local canBuy = (remainCount > 0)
    return canBuy
end

function StoreDataMgr:getNowBuyCount(commodityId, logType)
    local buyCount = 0
    local buyInfo = self.buyInfo_[commodityId]
    if buyInfo and buyInfo[logType] then
        buyCount = buyInfo[logType].nowBuyCount
    end
    return buyCount
end

function StoreDataMgr:getTotalBuyCount(commodityId, logType)
    local buyCount = 0
    local buyInfo = self.buyInfo_[commodityId]
    if buyInfo and buyInfo[logType] then
        buyCount = buyInfo[logType].totalBuyCount
    end
    return buyCount
end

function StoreDataMgr:getRemainBuyCount(commodityCid)
    local commodityCfg = self:getCommodityCfg(commodityCid)
    if commodityCfg.limitType == EC_StoreBuyLimit.DAY then
        local nowBuyCount = self:getNowBuyCount(commodityCid, EC_StoreBuyLogType.PERSONAL)
        local remainCount = math.max(0, commodityCfg.limitVal - nowBuyCount)
        local isCanBuy = remainCount > 0
        return isCanBuy, remainCount
    elseif commodityCfg.limitType == EC_StoreBuyLimit.TIME then
        local nowBuyCount = self:getNowBuyCount(commodityCid, EC_StoreBuyLogType.PERSONAL)
        local remainCount = math.max(0, commodityCfg.limitVal - nowBuyCount)
        local isCanBuy = remainCount > 0
        return isCanBuy, remainCount
    elseif commodityCfg.limitType == EC_StoreBuyLimit.FOREVER then
        local totalBuyCount = self:getTotalBuyCount(commodityCid, EC_StoreBuyLogType.PERSONAL)
        local remainCount = math.max(0, commodityCfg.limitVal - totalBuyCount)
        local isCanBuy = remainCount > 0
        return isCanBuy, remainCount
    elseif commodityCfg.limitType == EC_StoreBuyLimit.WHOLESERVER then
        local serverNowBuyCount = self:getNowBuyCount(commodityCid, EC_StoreBuyLogType.WHOLESERVER)
        local serverRemainBuyCount = commodityCfg.limitVal - serverNowBuyCount
        local personNowBuyCount = self:getNowBuyCount(commodityCid, EC_StoreBuyLogType.PERSONAL)
        local personalRemainBuyCount = commodityCfg.serLimit - personNowBuyCount
        local isCanBuy = serverRemainBuyCount > 0 and personalRemainBuyCount > 0
        return isCanBuy, serverRemainBuyCount, personalRemainBuyCount
    elseif commodityCfg.limitType == EC_StoreBuyLimit.NONE then
        return true
    end
end

function StoreDataMgr:getMaxBuyCount(commodityCid)
    local commodityCfg = self:getCommodityCfg(commodityCid)
    local costId = commodityCfg.priceType
    local costNum = commodityCfg.priceVal

    local buyCount = INT_MAXVALUE
    for i = 1, math.min(#costId, #costNum) do
        local haveNum = GoodsDataMgr:getItemCount(costId[i])
        local count = math.floor(haveNum / costNum[i])
        if buyCount then
            buyCount = math.min(buyCount, count)
        else
            buyCount = count
        end
    end
    return buyCount
end

function StoreDataMgr:currencyIsEnough(commodityCid, count)
    count = count or 1
    local commodityCfg = self:getCommodityCfg(commodityCid)
    local costId = commodityCfg.priceType
    local costNum = commodityCfg.priceVal
    local isEnough = true
    for i = 1, math.min(#costId, #costNum) do
        if not GoodsDataMgr:currencyIsEnough(costId[i], costNum[i] * count) then
            isEnough = false
            break
        end
    end
    return isEnough
end

function StoreDataMgr:getCommodityState(commodityCid)
    return self.commodityState[commodityCid] or  1;
end

-- 对应id有无免费刷新次数
function StoreDataMgr:isFreeRefreshByStoreId(storeId)
    local _bool = false
    local isHavePrivilege, cfg = RechargeDataMgr:getIsHavePrivilegeByType(106)
    local limitNum = cfg.privilege.storeTypeList[storeId]
    local freeNum = self:getStoreInfo(storeId).freeNum or 0
    if isHavePrivilege and limitNum and limitNum > freeNum then
        _bool = true
    end
    return _bool
end

-----------------------------------------------------

function StoreDataMgr:sendSellGoods(goods)
    TFDirector:send(c2s.STORE_SELL_INFO, {goods})
end

function StoreDataMgr:send_PLAYER_REQ_BUY_RESOURCES(id, num)
    num = num or 1
    TFDirector:send(c2s.PLAYER_REQ_BUY_RESOURCES, {id, num})
end

function StoreDataMgr:send_STORE_BUY_GOODS(commodityId, num)
    TFDirector:send(c2s.STORE_BUY_GOODS, {commodityId, num})
end

function StoreDataMgr:send_STORE_SELL_GOODS_PREVIEW(goods)
    TFDirector:send(c2s.STORE_SELL_GOODS_PREVIEW, {goods})
end

function StoreDataMgr:__handleStoreInfo(storeData)

    local storeCid = storeData.storeId
    if storeData.store then
        storeData.store.showCurrency = storeData.store.showCurrency or {}
        storeData.store.id = storeCid
        self.storeMap_[storeCid] = storeData.store
    end
    if storeData.commoditys then
        self.commodity_[storeCid] = {}

        for _, commodityCfg in ipairs(storeData.commoditys) do
            commodityCfg.storeId = storeCid
            if commodityCfg.tag then
                commodityCfg.tag = tonumber(commodityCfg.tag)
            else
                commodityCfg.tag = 0
            end
            if commodityCfg.sellDescribtion then
                commodityCfg.sellDescribtion = string.format("r%s", commodityCfg.sellDescribtion)
            else
                commodityCfg.sellDescribtion = ""
            end
            if commodityCfg.buyBeginTime then
                local date = TFDate(commodityCfg.buyBeginTime):tolocal()
                commodityCfg.buyBeginTime = {
                    year = date:getyear(),
                    month = date:getmonth(),
                    day = date:getday(),
                    hour = date:gethours(),
                    min = date:getminutes(),
                    sec = date:getseconds(),
                }
            else
                commodityCfg.buyBeginTime = {}
            end
            if commodityCfg.buyEndTime then
                local date = TFDate(commodityCfg.buyEndTime):tolocal()
                commodityCfg.buyEndTime = {
                    year = date:getyear(),
                    month = date:getmonth(),
                    day = date:getday(),
                    hour = date:gethours(),
                    min = date:getminutes(),
                    sec = date:getseconds(),
                }
            else
                commodityCfg.buyEndTime = {}
            end
            commodityCfg.extendData = {}
            if commodityCfg.extra then
                commodityCfg.extendData = json.decode(commodityCfg.extra)
            end

            table.insert(self.commodity_[storeCid], commodityCfg.id)
            self.commodityMap_[commodityCfg.id] = commodityCfg
        end
        self:sortWithCommodity(storeCid)
    end
    if storeData.storeRefresh then
        self.storeInfo_[storeCid] = storeData.storeRefresh
    end
    if storeData.pic then
        self.storeInfo_[storeCid].pic = storeData.pic
    end
    if storeData.groupRefreshTime then
        self.storeInfo_[storeCid].groupRefreshTime = storeData.groupRefreshTime
    end
end

function StoreDataMgr:onRecvStoreInfo(event)
    local data = event.data
    if not data.stores then return end

    self.storeMap_ = {}
    self.commodityMap_ = {}
    self.store_ = {}

    if data.stores then
        for i, v in ipairs(data.stores) do
            table.insert(self.store_, v.storeId)
            self:__handleStoreInfo(v)
        end
        EventMgr:dispatchEvent(EV_STORE_UPDATE_CFG)
    end
end

function StoreDataMgr:onRecvBuyGoodsSuccess(event)
    local data = event.data
    if not data then return end
    EventMgr:dispatchEvent(EV_STORE_BUY_SUCCESS, data)
end

function StoreDataMgr:onRecvRefreshShop(event)
    local data = event.data
    if not data then return end

    local storeId = {}
    if data.stores then
        for i, v in ipairs(data.stores) do
            table.insert(storeId, v.storeId)
            self:__handleStoreInfo(v)
        end
        EventMgr:dispatchEvent(EV_STORE_REFRESH, storeId)
    end
end


function StoreDataMgr:onRecvBuyInfo(event)
    local data = event.data
    if not data then return end
    local buyInfo = data.buyLogs
    if buyInfo then
        for i, v in ipairs(buyInfo) do
            self.buyInfo_[v.cid] = self.buyInfo_[v.cid] or {}
            self.buyInfo_[v.cid][v.type] = v
            self.commodityState[v.cid] = v.storeState;
        end
        EventMgr:dispatchEvent(EV_STORE_BUYINFO_UPDATE)
    end
end

function StoreDataMgr:onRecvSellGoods(event)
    local data = event.data
    if not data then return end
    EventMgr:dispatchEvent(EV_STORE_SELL_SUCCESS, data.rewards or {})
end

function StoreDataMgr:onRecvResourceBuyLog(event)
    local data = event.data
    if not data.logs then return end

    local function attrAssgin(target, src)
        for k, v in pairs(src) do
            target[k] = v
        end
    end
    for i, v in ipairs(data.logs) do
        local oldItem, newItem
        if v.ct == EC_SChangeType.DEFAULT then
            oldItem = self.itemRecoverInfo_[v.cid]
            newItem = {}

            attrAssgin(newItem, v)
            self.itemRecoverInfo_[v.cid] = newItem
        elseif v.ct == EC_SChangeType.ADD then
            oldItem = self.itemRecoverInfo_[v.cid]
            newItem = {}
            attrAssgin(newItem, v)
            self.itemRecoverInfo_[v.cid] = newItem
        elseif v.ct == EC_SChangeType.UPDATE then
            newItem = self.itemRecoverInfo_[v.cid]
            oldItem = clone(newItem)
            if nil == newItem then
                self.itemRecoverInfo_[v.cid] = v
            else
                attrAssgin(newItem, v)
            end
        elseif v.ct == EC_SChangeType.DELETE then
            oldItem = self.itemRecoverInfo_[v.cid]
            newItem = nil
            self.itemRecoverInfo_[v.cid] = nil
        end
        EventMgr:dispatchEvent(EV_STORE_RESOURCEBUYLOG_UPDATE, v.cid)
    end
end

function StoreDataMgr:onRecvBuyResource(event)
    local data = event.data
    EventMgr:dispatchEvent(EV_STORE_BUYRESOURCE, data.cid, data.count)
end

function StoreDataMgr:onRecvSellPreview(event)
    local data = event.data or {}
    EventMgr:dispatchEvent(EV_BAG_SELL_PREVIEW, data.rewards)
end

return StoreDataMgr:new()
