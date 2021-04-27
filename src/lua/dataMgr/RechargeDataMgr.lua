local BaseDataMgr = import(".BaseDataMgr")
local RechargeDataMgr = class("RechargeDataMgr", BaseDataMgr)
local UserDefalt = CCUserDefault:sharedUserDefault()
RechargeDataMgr.RESREWARDTOTALPAY = "RechargeDataMgr.RESREWARDTOTALPAY" --领取累计充值奖励

--add to update
function RechargeDataMgr:ctor()
    self:init()
	self:reset()
end

function RechargeDataMgr:reset()
	self.monthCardSignData = {}--月卡签到数据
	self.monthCardGiftData = {}--月卡礼包数据
	self.fundDataDic = {}  -- 养成基金数据

	self.pushGiftData = nil
end

function RechargeDataMgr:init()
	TFDirector:addProto(s2c.RECHARGE_GET_RECHARGE_CFG, self, self.recvGoodsList)
	TFDirector:addProto(s2c.RECHARGE_GET_BUY_RECORD_INFO,self,self.recvRecordInfo)
	TFDirector:addProto(s2c.RECHARGE_GET_MONTH_CARD_INFO,self,self.recvMonthCard)
	TFDirector:addProto(s2c.RECHARGE_GET_ORDER_NO,self,self.recvGetOrderNo)
	TFDirector:addProto(s2c.RECHARGE_RECHARGE_SUCCESS,self,self.recvRechargeOk)
	TFDirector:addProto(s2c.RECHARGE_BUY_RECORD_INFO,self,self.updateRecordInfo)
	TFDirector:addProto(s2c.RECHARGE_BUY_MONTH_CARD_INFO,self,self.updateMonthCardInfo)
	TFDirector:addProto(s2c.RECHARGE_RES_CHARGE_EXCHANGE,self,self.RECHARGE_RES_CHARGE_EXCHANGE)
	

	TFDirector:addProto(s2c.RECHARGE_RES_TOTAL_PAY_REWARD_INFO,self,self.recvTotalPayRewardInfo)
	TFDirector:addProto(s2c.RECHARGE_RES_TOTAL_PAY_REWARD_CFG,self,self.recvTotalPayRewardCfg)
	TFDirector:addProto(s2c.RECHARGE_RES_REWARD_TOTAL_PAY,self,self.recvRewardTotalPay)

	TFDirector:addProto(s2c.RECHARGE_GET_MONTH_CARD_WELFARE_INFO,self,self.recvMonthCardInfo)
	TFDirector:addProto(s2c.RECHARGE_RES_MONCARD_SIGN,self,self.recvMonthCardSign)
	TFDirector:addProto(s2c.RECHARGE_RES_MONCARD_STORE,self,self.recvMonthCardGiftBuy)

	--新加的触发式限时礼包的推送
	--TFDirector:addProto(s2c.RECHARGE_RES_TRIGGER_GIFT_INFO, self, self.recvTriggerGiftInfo)
    TFDirector:addProto(s2c.RECHARGE_RES_TRIGGER_GIFT_INFO,self, self.recvTriggerGift)

	TFDirector:addProto(s2c.RECHARGE_RESP_RECEIVE_SYS_FUN_INFO,self,self.recvGrowFundList)
	TFDirector:addProto(s2c.RECHARGE_RESP_GET_FUN_AWARD,self,self.recvGrowFundAwards)
	TFDirector:addProto(s2c.RECHARGE_RESP_WEEK_CARD_INFO, self, self.onRecvWeekCardInfo)
	TFDirector:addProto(s2c.RECHARGE_RESP_GET_WEEK_AWARD, self, self.onRecvWeekSignAward)

	TFDirector:addProto(s2c.RECHARGE_RESP_WEEK_CARD_INFO, self, self.onRecvWeekCardInfo)
	TFDirector:addProto(s2c.RECHARGE_RESP_GET_WEEK_AWARD, self, self.onRecvWeekSignAward)

	TFDirector:addProto(s2c.RECHARGE_PUSH_CHANGE_RECHARGE_CFG, self, self.recvGoodsList)

	TFDirector:addProto(s2c.RECHARGE_RESP_WEEK_CARD_INFO, self, self.onRecvWeekCardInfo)
	TFDirector:addProto(s2c.RECHARGE_RESP_GET_WEEK_AWARD, self, self.onRecvWeekSignAward)

	TFDirector:addProto(s2c.RECHARGE_PUSH_CHANGE_RECHARGE_CFG, self, self.recvGoodsList)

	--s2c.RECHARGE_BUY_MONTH_CARD_INFO

	if HeitaoSdk then
		HeitaoSdk.setPayCallBack(function(result)
				self:payCallback(result)
			end)
	end

	self.rechargeCfg = TabDataMgr:getData("Recharge")
	self.rechargeGiftBagCfg = TabDataMgr:getData("RechargeGiftBag")


end

function RechargeDataMgr:payCallback(result)
	--dump(result);
end

function RechargeDataMgr:recvRechargeOk(event)
	local cfg = self:getOneRechargeCfg(event.data.cid);
	if not cfg then return end

	local buy_count = self:getBuyCount(event.data.cid);
	--dump(cfg)
	--钻石或者礼包
	local reward = cfg.item;
	if buy_count == 1 and cfg.firstBuyItem then
		reward = cfg.firstBuyItem
	end

	--月卡  
	if cfg.days and cfg.days > 0 and cfg.type ~= 6 and cfg.type ~= 0 then
		Utils:openView("store.MCardActivated")
	end

	if not reward or table.count(reward) <= 0 then
		reward = cfg.presentItem
	end

	if reward and table.count(reward) > 0 then
		local batchCount = event.data.buyCount
		local tempReward = {}
		if batchCount and batchCount > 1 then
			for k, v in pairs(reward) do
				table.insert(tempReward, {id = v.id, num=v.num * batchCount})
			end
		else
			tempReward = reward
		end
		Utils:showReward(tempReward);
	end

	EventMgr:dispatchEvent(EV_RECHARGE_UPDATE, reward);
end

function RechargeDataMgr:onLogin()
	TFDirector:send(c2s.RECHARGE_GET_RECHARGE_CFG, {})
	TFDirector:send(c2s.RECHARGE_GET_BUY_RECORD_INFO, {})
	TFDirector:send(c2s.RECHARGE_GET_MONTH_CARD_INFO, {})
	TFDirector:send(c2s.RECHARGE_REQ_RECEIVE_SYS_FUN_INFO, {})
	TFDirector:send(c2s.RECHARGE_REQ_GIFT_LOGIN_CHECK, {})
	self:sendGetTotalPayRewardInfo()
	self:sendGetTotalPayRewardCfg()
	self:sendGetMonthCardInfo()
	self:sendWeekCardInfo()

	return {
			s2c.RECHARGE_GET_RECHARGE_CFG,
			s2c.RECHARGE_GET_BUY_RECORD_INFO,
			s2c.RECHARGE_GET_MONTH_CARD_INFO,
			s2c.RECHARGE_RES_GIFT_LOGIN_CHECK,
			--s2c.RECHARGE_RES_TOTAL_PAY_REWARD_INFO,
			--s2c.RECHARGE_RES_TOTAL_PAY_REWARD_CFG
		}
end

function RechargeDataMgr:getOneRechargeCfg(cid)
	for k,v in pairs(self.goodsList or {}) do
		for k2,v2 in pairs(v) do
			if v2.rechargeCfg.id == cid then
				return v2;
			end
		end
	end
end

function RechargeDataMgr:getBuyCount(cid)
	if not self.recordInfo[cid] then
		return 0;
	end

	return self.recordInfo[cid].buy_count;
end

function RechargeDataMgr:getOrderNO(goodsid, extraInfo)
	--[[判断是否代币兑换]]
	local goods = self:getOneRechargeCfg(goodsid)
	if goods.buyType and goods.buyType == 1 then
		if goods.packType and next(goods.packType) then
			if goods.packType[1] == 1002 then
				Utils:openView("store.TokenPopViewNew",goodsid);
			else
				Utils:openView("store.TokenPopView",goodsid);
			end
		elseif false then
			Utils:openView("store.BuyConfirmView2", goodsid)
		else
			Utils:openView("common.ConfirmBoxViewSmall", goodsid, extraInfo)
		end
		--Utils:openView("store.TokenPopView",goodsid);
	else
		local msg = {
			goodsid,
			extraInfo
		}
		self.curPayId = goodsid;
		TFDirector:send(c2s.RECHARGE_GET_ORDER_NO, msg)
	end
end

function RechargeDataMgr:recvGetOrderNo(event)
	--dump(event.data)
	local cfg = self:getOneRechargeCfg(self.curPayId);
	if not cfg then return end

	--[[ --屏蔽充值类型特殊处理
	local _type = 0;
	if cfg.upgradeId then --月卡
		_type = cfg.type;
	end

	-- 区分相同金额不同计费点
	local appversion = TFDeviceInfo:getCurAppVersion();
	if CC_TARGET_PLATFORM ~= CC_PLATFORM_WIN32 and tonumber(appversion) >= 3.40 and cfg.type == 2 and not cfg.upgradeId then
		_type = 6;
	end
	--end]]
	if event.data.orderNo == "" then
		Utils:showTips(190000568)
		return
	end
	if HeitaoSdk then
		HeitaoSdk.pay(tostring(self.curPayId),
			cfg.name2,
			cfg.des3,
			tostring(cfg.rechargeCfg.price*0.01),
			"1",
			tostring(cfg.type),
			TextDataMgr:getText(13003), --钻石
			"10",
			tostring(MainPlayer:getPlayerId()).."_"..event.data.orderNo,
			tostring(MainPlayer:getPlayerId()),
			MainPlayer:getPlayerName(),
			tostring(ServerDataMgr:getServerGroupID()),
			"1",
			"1",
			tostring(MainPlayer:getPlayerLv()),
			"1",
			tostring(GoodsDataMgr:getDiamond())
			)
	end
end

function RechargeDataMgr:getMonthCardList()

	if not self.goodsList then
		return
	end
    local ret = {}
    for k,v in pairs(self.goodsList.monthCardCfg) do
    	--if v.type ~= 7 or (me.platform == "ios") or me.platform == "win32" or (me.platform == "android" and HeitaoSdk and ((HeitaoSdk.getplatformId()~=3 and HeitaoSdk.getplatformId() ~= 1) or  (HeitaoSdk.getplatformId() == 1 and tonumber(TFDeviceInfo:getCurAppVersion()) == 1.13)))then
		-- 开启月卡续订
		--if v.type ~= 7 then
		if true then
		    table.insert(ret,v)
        end
    end
    return ret
end

function RechargeDataMgr:getSubscribeMonthCardCfg( ... )
	for k,v in pairs(self.goodsList.monthCardCfg) do
        if v.type == 7 then			--ios月卡配置
        	return v
        end
    end
    return nil
end

function RechargeDataMgr:getRechargeList()
	local list = {};
	if not self.goodsList or not self.goodsList.rechargeGiftBagCfg then
		return
	end
	for k,v in pairs(self.goodsList.rechargeGiftBagCfg) do
		if v.interfaceType == 1 then
			table.insert(list,v);
		end
	end

	return list;
end

function RechargeDataMgr:getGiftSingleData(giftId)
	for k,v in pairs(self.goodsList.rechargeGiftBagCfg) do
		if giftId == v.rechargeCfg.id then
			return v
		end
	end
	return nil
end

function RechargeDataMgr:getGiftData(giftIds)
	local list = {};

	if not self.goodsList or not self.goodsList.rechargeGiftBagCfg then
		return
	end

	if giftIds then
		for k,v in pairs(self.goodsList.rechargeGiftBagCfg) do
			if table.find(giftIds,v.rechargeCfg.id) ~= -1 then
				table.insert(list,v);
			end
		end
	else
		for k,v in pairs(self.goodsList.rechargeGiftBagCfg) do
			if v.interfaceType == 2 then
				if (v.rechargeCfg.id ~= 100
					and v.rechargeCfg.id ~= 91001
					and v.rechargeCfg.id ~= 91002
					and v.rechargeCfg.id ~= 91003
					and v.rechargeCfg.id ~= 91004
					and v.rechargeCfg.id ~= 910001
					and v.rechargeCfg.id ~= 910002
					and v.rechargeCfg.id ~= 910003) then
					table.insert(list,v);
				end
			end
		end
	end

	list = self:sortGiftList(list)
	return list;
end

function RechargeDataMgr:getLimitGiftData()
	local list = {}

	if not self.goodsList or not self.goodsList.rechargeGiftBagCfg then
		return nil
	end

	
	for k,v in pairs(self.goodsList.rechargeGiftBagCfg) do
		if (v.interfaceType == 10 or v.interfaceType == 14) and v.isTrigger then
			table.insert(list,v)
		end
	end

	list = self:sortGiftList(list)
	return list
end

--英文版独有获取礼包方法
function RechargeDataMgr:getGiftDataByInterfaceType(giftType)
	local list = {};

	if not self.goodsList or not self.goodsList.rechargeGiftBagCfg then
		return
	end

	local serverTime = ServerDataMgr:getServerTime()
	for k,v in pairs(self.goodsList.rechargeGiftBagCfg) do
		if v.interfaceType == giftType and v.startDate and v.endDate then
			if serverTime >= v.startDate and serverTime < v.endDate then
				table.insert(list,v)
			end
		elseif v.interfaceType == giftType then
			table.insert(list,v);
		end
	end
	local tab1 = {}
	local tab2 = {}
	for k,v in pairs(list) do
		local left = v.buyCount - self:getBuyCount(v.rechargeCfg.id)
		if left > 0 then
			table.insert(tab1,v)
		else
			table.insert(tab2,v)
		end
	end

	table.sort(tab1,function (a,b)

		local buyCnt1 = a.buyCount - self:getBuyCount(a.rechargeCfg.id)
		local buyCnt2 = b.buyCount - self:getBuyCount(b.rechargeCfg.id)

		local orderId1 = a.rechargeCfg.id;--self:getGiftBagOrderId(a.rechargeCfg.id)
		local orderId2 = b.rechargeCfg.id;--self:getGiftBagOrderId(b.rechargeCfg.id)
		return orderId1 > orderId2
	end)

	table.sort(tab2,function (a,b)
		
		local buyCnt1 = a.buyCount - self:getBuyCount(a.rechargeCfg.id)
		local buyCnt2 = b.buyCount - self:getBuyCount(b.rechargeCfg.id)
		local orderId1 = a.rechargeCfg.id;--self:getGiftBagOrderId(a.rechargeCfg.id)
		local orderId2 = b.rechargeCfg.id;--self:getGiftBagOrderId(b.rechargeCfg.id)
		return orderId1 > orderId2
	end)

	for k,v in pairs(tab2) do
		tab1[#tab1 + 1] = v
	end

	list = tab1;
	return list;
end


function RechargeDataMgr:getNewBirdGiftData()
	local list = {}

	if not self.goodsList or not self.goodsList.rechargeGiftBagCfg then
		return
	end

	
	for k,v in pairs(self.goodsList.rechargeGiftBagCfg) do
		if v.interfaceType == 11 then
			table.insert(list,v)
		end
	end

	list = self:sortGiftList(list)
	return list
end

function RechargeDataMgr:getWarOrderGiftData()
	local list = {};
	if not self.goodsList or not self.goodsList.rechargeGiftBagCfg then
		return
	end
	for k,v in pairs(self.goodsList.rechargeGiftBagCfg) do
		if v.interfaceType == 8 then
			table.insert(list,v)
		end
	end
	list = self:sortGiftList(list)
	
	return list
end

function RechargeDataMgr:sortGiftList(list)
	list = list or {}
	local tab1 = {}
	local tab2 = {}
	for k,v in pairs(list) do
		local left = v.buyCount - self:getBuyCount(v.rechargeCfg.id)
		if left > 0 then
			table.insert(tab1,v)
		else
			table.insert(tab2,v)
		end
	end

	table.sort(tab1,function (a,b)
		local orderId1 = a.rechargeCfg.id
		local orderId2 = b.rechargeCfg.id
		return orderId1 > orderId2
	end)

	table.sort(tab2,function (a,b)
		local orderId1 = a.rechargeCfg.id
		local orderId2 = b.rechargeCfg.id
		return orderId1 > orderId2
	end)

	for k,v in pairs(tab2) do
		tab1[#tab1 + 1] = v
	end

	return tab1
end

function RechargeDataMgr:recvGoodsList(event)
	local function existInOldDataById(data ,id)
		local _bool = false
		for i, _data in ipairs(data) do
			if _data.rechargeCfg.id == id then
				_bool = true
			end
		end
		return _bool
	end
	local function changeDataById(sumData, changeData, changeType)
		if not sumData or not changeData then
			return
		end
		for j, newData in ipairs(changeData) do
			if existInOldDataById(sumData, newData.rechargeCfg.id) then
				for i, _data in ipairs(sumData) do
					if _data.rechargeCfg.id == newData.rechargeCfg.id then
						if changeType == EC_SChangeType.UPDATE then
							sumData[i] = newData
						elseif changeType == EC_SChangeType.DELETE then
							sumData[i] = nil
						end
					end
				end
			else
				table.insert(sumData, newData)
			end
		end
	end

	local data = event.data

	if data.rechargeGiftBagCfg or data.monthCardCfg then  -- 4360
		self.goodsList = data
	else                                                  -- 4369
		if self.goodsList then 
			changeDataById(self.goodsList.rechargeGiftBagCfg, data.updateCreateGiftCfg, EC_SChangeType.UPDATE)
			changeDataById(self.goodsList.rechargeGiftBagCfg, data.deleteGiftCfg, EC_SChangeType.DELETE)
			changeDataById(self.goodsList.monthCardCfg, data.updateCreateMonthCardCfg, EC_SChangeType.UPDATE)
			changeDataById(self.goodsList.monthCardCfg, data.deleteMonthCardCfg, EC_SChangeType.DELETE)
		end
	end

	self.limitGoodsList = {}
	self.sevenGiftBag = {}		--7日狂欢礼包，类型3

	if not self.goodsList or not self.goodsList.rechargeGiftBagCfg then
		return
	end

	for k,v in pairs(self.goodsList.rechargeGiftBagCfg) do

		if v.startDate then
			table.insert(self.limitGoodsList,v)
		end

		if v.interfaceType == 3 then
			table.insert(self.sevenGiftBag,v)
		end
	end

	table.sort(self.sevenGiftBag,function (a,b)
		return a.order < b.order
	end)

	self:checkNewGiftBag()
end

function RechargeDataMgr:recvTriggerGift(event)
	if event.data then
		self.pushGiftData = {}
		if event.data.rechargeGiftBagCfg then
			if self.goodsList and self.goodsList.rechargeGiftBagCfg then
				for i,j in pairs(event.data.rechargeGiftBagCfg) do
					for k,v in pairs(self.goodsList.rechargeGiftBagCfg) do
						if v.rechargeCfg.id == j.rechargeCfg.id then
							v.triggerEndDate = j.triggerEndDate						
							if event.data.pushStatus == 1 then
								v.isTrigger = true
								table.insert(self.pushGiftData, j)
							else
								v.isTrigger = false
							end
							break
						end
					end
				end
			end
			--self.pushGiftData = event.data.rechargeGiftBagCfg
		else
			self:resetPushGift()
			if self.goodsList and self.goodsList.rechargeGiftBagCfg then
				for k,v in pairs(self.goodsList.rechargeGiftBagCfg) do
					if v.interfaceType == 14 then
						v.isTrigger = false
					end
				end
			end
		end
		EventMgr:dispatchEvent(EV_LIMIT_GIFT_PUSH,{})
	end
end

-- 4374 养成基金
function RechargeDataMgr:recvGrowFundList(event)
	if not event.data then
		 return 
	end
	local dataList = event.data.fundInfo or {}
	if not self.fundDataDic then
		self.fundDataDic = {}
	end

	for i ,data in ipairs(dataList) do
		if data.ct == EC_SChangeType.DELETE then
			self.fundDataDic[data.id] = nil
		else
			self.fundDataDic[data.id] = data
		end
	end
	EventMgr:dispatchEvent(EV_GROWFUND_UPDATE)
end

function RechargeDataMgr:recvGrowFundAwards(event)
	local data = event.data or {}
	Utils:showReward(data.reward)
	EventMgr:dispatchEvent(EV_RECHARGE_UPDATE)
end

function RechargeDataMgr:onRecvWeekCardInfo(event)
	self.weekCardInfo = event.data
	EventMgr:dispatchEvent(EV_WEEKCARD_UPDATE)
	EventMgr:dispatchEvent(EV_PRIVILEGE_UPDATE, EC_CardPrivilege.Week)
end

function RechargeDataMgr:onRecvWeekSignAward(event)
	local data = event.data or {}
	Utils:showReward(data.rewards)
end	

function RechargeDataMgr:getWeekCardInfo()
	return self.weekCardInfo
end

function RechargeDataMgr:getCardPrivilegeByType(type)
	local tmp = {}
	local tab = TabDataMgr:getData("Privilege")
	for i, v in pairs(tab) do
		if type and v.type == type then
			table.insert(tmp, v)
		end
	end
	return tmp
end

-- 根据id获取是否有对应特权和相应配置
function RechargeDataMgr:getIsHavePrivilegeByType(id)
	local _bool = false
	local cfg   = nil
	--英文版暂时屏蔽以下id
	if id == 103 then
		return _bool , cfg
	end
	if id == 101 and (not(GlobalFuncDataMgr:isOpen(11))) then
		return _bool , cfg
	end

	local tab = TabDataMgr:getData("Privilege")
	for i, v in pairs(tab) do
		if v.privilegeId == id then
			if v.type == EC_CardPrivilege.Month then
				_bool = self.monthCard.etime > 0
			elseif v.type == EC_CardPrivilege.Week then
				_bool = self.weekCardInfo.etime > 0
			end
			cfg = v
			break
		end
	end
	if not cfg then
		Box("ERROR ID:".. id)
		return
	end
	return _bool, cfg
end

function RechargeDataMgr:getGrowFundById(id)
	if self.fundDataDic then
		return self.fundDataDic[id]
	end
	return nil
end

-- 养成基金红点显隐
function RechargeDataMgr:isGrowFundViewShowRed()
	local _bool = false
	-- 可领取奖励
	for _, v in pairs(self.fundDataDic or {}) do
		if not v.todayAward then
			_bool = true
			break
		end
	end
	-- 未购买 (一天只提醒一次)
	if (not self.fundDataDic or #self.fundDataDic == 0) and not RechargeDataMgr:getDayHadInFundView() then
		_bool = true
	end

	return _bool
end

function RechargeDataMgr:getDayHadInFundView()
	local pid = MainPlayer:getPlayerId()
	local lastDate = UserDefalt:getStringForKey("GrowFundLastDate"..pid)
	local nowDate = os.date("%Y%m%d")
	return lastDate == nowDate
end

-- 
function RechargeDataMgr:setDayHadInFundView()
	local pid = MainPlayer:getPlayerId()
	local nowDate = os.date("%Y%m%d")
	UserDefalt:setStringForKey("GrowFundLastDate"..pid, nowDate)
end


function RechargeDataMgr:getLimitGiftBagTime()
	if self.goodsList and self.goodsList.rechargeGiftBagCfg then
		for k,v in pairs(self.goodsList.rechargeGiftBagCfg) do
			if v.type == 10 and v.interfaceType == 14 and v.triggerEndDate then
				return v.triggerEndDate or 0
			end
		end
	end
	return 0
end

function RechargeDataMgr:getPushGift(idx)
	self.pushGiftData = self.pushGiftData or{}
	if idx then
		return self.pushGiftData[idx]
	end
	return self.pushGiftData
end

function RechargeDataMgr:tiggerGift(idx)
	if self.pushGiftData and self.pushGiftData[idx] then
		table.remove(self.pushGiftData, idx)
	end
end

function RechargeDataMgr:resetPushGift()
	self.pushGiftData = nil
end

function RechargeDataMgr:recvRecordInfo(event)
	self.recordInfo = {};

	if table.count(event.data) == 0 then
		return;
	end

	for k,v in pairs(event.data.info) do
	 	self.recordInfo[v.cid] = v;
	end

	--dump(self.recordInfo);
end

function RechargeDataMgr:checkNewGiftBag()

	self.newGiftBagRecord = {}
	local pid = MainPlayer:getPlayerId()
	local saveRecord = UserDefalt:getStringForKey("newGiftBag"..pid)
	if saveRecord == "" then
		self:saveInitGiftBag()
	else
		self.oldRecord = {}
		local saveInfo = string.split(saveRecord,"|")
		for k,v in ipairs(saveInfo) do
			local giftBagId = tonumber(v)
			if giftBagId then
				self.oldRecord[giftBagId] = 1
			end
		end
		self:saveGiftBag(saveRecord)
	end

end

function RechargeDataMgr:saveInitGiftBag()

	local serverTime = ServerDataMgr:getServerTime()
	local recordStr = ""
	for k,v in pairs(self.goodsList.rechargeGiftBagCfg) do
		if v.type == 6 and v.rechargeCfg.id ~= 100 then

			if v.startDate then
				if serverTime >= v.startDate and serverTime < v.endDate then
					local giftBagId = v.rechargeCfg.id
					recordStr = recordStr .."|"..giftBagId
				end
			else
				local giftBagId = v.rechargeCfg.id
				recordStr = recordStr .."|"..giftBagId
			end
		end
	end

	local pid = MainPlayer:getPlayerId()
	UserDefalt:setStringForKey("newGiftBag"..pid,recordStr)
	UserDefalt:flush()

end

function RechargeDataMgr:saveGiftBag()

	local newRecord = ""
	local serverTime = ServerDataMgr:getServerTime()
	for k,v in pairs(self.goodsList.rechargeGiftBagCfg) do
		if v.type == 6 and v.rechargeCfg.id ~= 100 then
			local giftBagId = v.rechargeCfg.id
			if v.startDate then
				if serverTime >= v.startDate and serverTime < v.endDate then
					if not self.oldRecord[giftBagId] then
						self.newGiftBagRecord[giftBagId] = 1
					end
					newRecord = newRecord .."|"..giftBagId
				end
			else
				if not self.oldRecord[giftBagId] then
					self.newGiftBagRecord[giftBagId] = 1
				end
				newRecord = newRecord .."|"..giftBagId
			end
		end
	end

	local pid = MainPlayer:getPlayerId()
	UserDefalt:setStringForKey("newGiftBag"..pid,newRecord)
	UserDefalt:flush()
end

function RechargeDataMgr:isNewOpenGiftBag(giftBagId)

	return self.newGiftBagRecord[giftBagId]
end

function RechargeDataMgr:clearNewGiftBagFlag(giftBagId)
	if self.newGiftBagRecord[giftBagId] then
		self.newGiftBagRecord[giftBagId] = nil
	end
end

function RechargeDataMgr:existNewGiftBag()

	local cnt = 0
	if self.newGiftBagRecord then
		for k,v in pairs(self.newGiftBagRecord) do
			cnt = cnt + 1
		end
	end

	return cnt > 0
end


function RechargeDataMgr:getGiftRecordStr()

	local recordStr = ""
	for k,v in pairs(self.goodsList.rechargeGiftBagCfg) do
		local record = v.rechargeCfg.id.."-"..flag
		recordStr = recordStr .."|"..record
	end

	return recordStr
end

function RechargeDataMgr:getSevenGiftBag(day)
	return self.sevenGiftBag[day]
end

function RechargeDataMgr:updateRecordInfo(event)
	self.recordInfo = self.recordInfo or {}

	self.recordInfo[event.data.cid] = event.data;
end

function RechargeDataMgr:updateMonthCardInfo(event)
	self.monthCard = event.data.monthCardInfo;
end

function RechargeDataMgr:recvMonthCard(event)
	self.monthCard = event.data;
	EventMgr:dispatchEvent(EV_PRIVILEGE_UPDATE, EC_CardPrivilege.Month)
end

function RechargeDataMgr:getMonthCardLeftTime()
	return self.monthCard.surplus_Gain_Count or 0
end

function RechargeDataMgr:showRechageLayer(...)

	local currentScene = Public:currentScene()
	if currentScene and currentScene:getTopLayer() and  currentScene:getTopLayer().__cname == "RechargeMain" then
    	return;
	end
	Utils:openView("store.RechargeMain",...)
	-- local recharge = requireNew("lua.logic.store.RechargeMain"):new(...)
 --    AlertManager:addLayer(recharge)
 --    AlertManager:show()
end


function RechargeDataMgr:getTagType(rechargeCfgId)

	if not self.rechargeCfg[rechargeCfgId] then
		return 2
	end

	local goodsId = self.rechargeCfg[rechargeCfgId].goodsId
	if not self.rechargeGiftBagCfg[goodsId] then
		return 2
	end
	
	return self.rechargeGiftBagCfg[goodsId].tagIcon
end

function RechargeDataMgr:getGiftBagOrderId(rechargeCfgId)

	if not self.rechargeCfg[rechargeCfgId] then
		return 1
	end

	local goodsId = self.rechargeCfg[rechargeCfgId].goodsId
	if not self.rechargeGiftBagCfg[goodsId] then
		return 1
	end

	return self.good[goodsId].order
end

function RechargeDataMgr:haveLimiteTimeItem()

	local serverTime = ServerDataMgr:getServerTime()
	local limitGoodsList = self:getLimitGoodsList()
	if not limitGoodsList then
		return false
	end

	for k,v in ipairs(limitGoodsList) do
		if serverTime >= v.startDate and serverTime < v.endDate then
			if self:getBuyCount(v.rechargeCfg.id) == 0 then
				return true
			end
		end
	end

	return false
end

function RechargeDataMgr:existGiftBagNewFlag()

	local existNew = false
	local haveLimitTime = self:haveLimiteTimeItem()
	local serverTime = ServerDataMgr:getServerTime();
	local time = os.date("*t",serverTime)
	local exist = self:existNewGiftBag()

	if haveLimitTime or (time.wday - 1 == 1 or time.day == 1) or exist then
		existNew = true
	end

	return existNew
end

function RechargeDataMgr:getLimitGoodsList()
	return self.limitGoodsList
end

function RechargeDataMgr:setClickMainLayerFlag()
	self.clickMainLayer = true
end

function RechargeDataMgr:getClickMainLayerFlag()
	return self.clickMainLayer
end

function RechargeDataMgr:setRechargeTabFlag()
	self.rechargeTabFlag = true
end

function RechargeDataMgr:getRechargeTabFlag()
	return self.rechargeTabFlag
end

function RechargeDataMgr:payBySdk()

end

function pay(productId,  productName, productDesc,  productPrice, productCount,  productType, coinName,  coinRate,extendInfo,  roleId, roleName,  zoneId, zoneName,  partyName, roleLevel,  roleVipLevel,balance)

    local args = nil
    local ok  = false
    local ret = nil

    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        args = {
            productId       	= productId,
            productName        	= productName, 
            productDesc       	= productDesc,
            productPrice  		= productPrice, 
            productCount    	= productCount,
            productType   		= productType,
            coinName    		= coinName,
            coinRate 			= coinRate,
            extendInfo 			= extendInfo,
            roleId				= roleId,
            roleName       		= roleName,
            zoneId       		= zoneId,
            zoneName    		= zoneName,
            partyName       	= partyName,
            roleLevel       	= roleLevel,
            roleVipLevel        = roleVipLevel,
            balance 			= balance
            -- sycee, level, viplevel, month, party      = custom
        }

        print("HeitaoSdk.pay" , args)

        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "pay", args)
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
    	args = {
            productId,
            productName, 
            productDesc,
            productPrice, 
            productCount,
            productType,
            coinName,
            coinRate,
            extendInfo,
            roleId,
            roleName,
            zoneId,
            zoneName,
            partyName,
            roleLevel,
            roleVipLevel,
            balance      
        }
        print("HeitaoSdk.pay" , args)
        ok,ret = TFLuaOcJava.callStaticMethod(HeitaoSdk.classname, "pay", args)
    end
end

if HeitaoSdk then
	HeitaoSdk.pay = pay;
end

--==================== 累计充值 REQ BEGIN ====================
--获取累充领奖领取信息
function RechargeDataMgr:sendGetTotalPayRewardInfo(  )
	TFDirector:send(c2s.RECHARGE_GET_TOTAL_PAY_REWARD_INFO, {})
end

--获取累充领奖配置信息
function RechargeDataMgr:sendGetTotalPayRewardCfg(  )
	TFDirector:send(c2s.RECHARGE_GET_TOTAL_PAY_REWARD_CFG, {})
end

--请求领取累充奖励
function RechargeDataMgr:sendRewardTotalPay( id )
	TFDirector:send(c2s.RECHARGE_REQ_REWARD_TOTAL_PAY, {id})
end

--4365 
function RechargeDataMgr:sendGetMonthCardInfo()
	TFDirector:send(c2s.RECHARGE_GET_MONTH_CARD_WELFARE_INFO, {})
end

--4366
function RechargeDataMgr:sendMonthCardSignIn()
	TFDirector:send(c2s.RECHARGE_REQ_MONTH_CARD_SIGN, {})
end

--4367
function RechargeDataMgr:sendMonthCardGiftBy(id)
	TFDirector:send(c2s.RECHARGE_REQ_MONTH_CARD_STORE, {id})
end

-- 4387 周卡信息
function RechargeDataMgr:sendWeekCardInfo()
	TFDirector:send(c2s.RECHARGE_REQ_WEEK_CARD_INFO, {})
end

-- 4388
function RechargeDataMgr:sendWeekCardSign()
	TFDirector:send(c2s.RECHARGE_REQ_GET_WEEK_AWARD, {})
end


--==================== 累计充值 REQ BEGIN ====================

--==================== 累计充值 RSP BEGIN ====================
function RechargeDataMgr:recvTotalPayRewardInfo( event )
	self.totalPayRewardInfo = event.data

	EventMgr:dispatchEvent(EV_TRECHARGE_RES_TOTAL_PAY_REWARD_INFO)
	
	--dump(event.data, "recvTotalPayRewardInfo: ")
end

function RechargeDataMgr:recvTotalPayRewardCfg( event )
	self.totalPayRewardCfg = event.data
	--dump(event.data, "recvTotalPayRewardCfg: ")
end

function RechargeDataMgr:recvRewardTotalPay( event )
	local resRewardTotalPay = event.data
	--dump(event.data, "recvRewardTotalPay: ")
	self:updateRewardIds(resRewardTotalPay.id)
	EventMgr:dispatchEvent(RechargeDataMgr.RESREWARDTOTALPAY, resRewardTotalPay.items)
end
--==================== 累计充值 RSP END ====================

--4365 月卡信息
function RechargeDataMgr:recvMonthCardInfo(event)
	local data = event.data or {}
	----dump(data, "RechargeDataMgr:recvMonthCardInfo")
	self.monthCardSignData = clone(data.signInfo)

	local gifts = data.storeInfo or {}
	self.monthCardGiftData = {}
	for i, v in ipairs(gifts) do
		--英文版独有更改gift解析ext字段
		local giftData = clone(v)
		giftData.ext = json.decode(giftData.ext)
		table.insert(self.monthCardGiftData, giftData)
	end
	table.sort(self.monthCardGiftData, function(a, b)
		return a.order < b.order
	end)
    EventMgr:dispatchEvent(EV_MONTHCARD_STATUS_UPDATE)
end

--4366 月卡签到
function RechargeDataMgr:recvMonthCardSign(event)
	local data = event.data or {}
	----dump(data, "RechargeDataMgr:recvMonthCardSign")
	self.monthCardSignData = clone(data.signInfo)
	Utils:showReward(data.rewards)
    EventMgr:dispatchEvent(EV_MONTHCARD_STATUS_UPDATE)
end

--4367 月卡礼包购买
function RechargeDataMgr:recvMonthCardGiftBuy(event)
	local data = event.data or {}
	----dump(data, "RechargeDataMgr:recvMonthCardGiftBuy")
    local price = {}
	for i, v in ipairs(self.monthCardGiftData) do
		if v.id == data.id then
			Utils:showReward(data.rewards)
			v.buyCount = data.buyCount
            price = v.price
			break
		end
	end
    EventMgr:dispatchEvent(EV_MONTHCARD_GIFT_UPDATE, data.id, data.buyCount, price)
end

function RechargeDataMgr:getTotalPayRewardInfo( )
	-- self.totalPayRewardInfo = 
	-- {
	-- 	totalPay = 400,
	-- 	rewardIds = {1},
	-- }
	return self.totalPayRewardInfo
end

function RechargeDataMgr:getTotalPayRewardCfg( )
	-- self.totalPayRewardCfg = 
	-- {
	-- 	rewardCfgs = 
	-- 	{
	-- 		{
	-- 			id = 1,
	-- 			amount = 100,
	-- 			items = {{id = 500002, num = 2000},{id = 570033, num = 2000}},
	-- 			order = 1,
	-- 			des = "xx礼包包含XX质点、XX奖励",
	-- 		},
	-- 		{
	-- 			id = 2,
	-- 			amount = 500,
	-- 			items = {{id = 500002, num = 2000},{id = 570033, num = 2000},{id = 570002, num = 2000}},
	-- 			order = 2,
	-- 			des = "xx礼包包含XX质点、XX奖励",
	-- 		},
	-- 		{
	-- 			id = 3,
	-- 			amount = 600,
	-- 			items = {{id = 500002, num = 2000},{id = 570033, num = 2000},{id = 570002, num = 2000}},
	-- 			order = 3,
	-- 			des = "xx礼包包含XX质点、XX奖励",
	-- 		},
	-- 		{
	-- 			id = 4,
	-- 			amount = 700,
	-- 			items = {{id = 500002, num = 2000},{id = 570033, num = 2000},{id = 570002, num = 2000}},
	-- 			order = 4,
	-- 			des = "xx礼包包含XX质点、XX奖励",
	-- 		},
	-- 		{
	-- 			id = 5,
	-- 			amount = 1000,
	-- 			items = {{id = 500002, num = 2000},{id = 570033, num = 2000},{id = 570002, num = 2000}},
	-- 			order = 5,
	-- 			des = "xx礼包包含XX质点、XX奖励",
	-- 		},
	-- 	}
	-- }
	return self.totalPayRewardCfg
end

--累积充值钻石
function RechargeDataMgr:getTotalPay( )
	local totalPayRewardInfo = self:getTotalPayRewardInfo()
	if totalPayRewardInfo == nil then return 0 end
	return totalPayRewardInfo.totalPay
end

--已领取过的累充奖励id集合
function RechargeDataMgr:getRewardIds( )
	local totalPayRewardInfo = self:getTotalPayRewardInfo()
	if totalPayRewardInfo == nil then return {} end
	if totalPayRewardInfo.rewardIds == nil then return {} end
	return totalPayRewardInfo.rewardIds
end

function RechargeDataMgr:updateRewardIds( rewardId )
	local totalPayRewardInfo = self:getTotalPayRewardInfo()
	if totalPayRewardInfo == nil then return end
	for _,_rewardId in ipairs(totalPayRewardInfo.rewardIds) do
		if _rewardId == rewardId then
			return
		end
	end
	table.insert(totalPayRewardInfo.rewardIds, rewardId)
end

--累充奖励配置信息
function RechargeDataMgr:getRewardCfgs( )
	local totalPayRewardCfg = self:getTotalPayRewardCfg()
	if totalPayRewardCfg == nil then return {} end
	return totalPayRewardCfg.rewardCfgs
end

function RechargeDataMgr:getRewardCfgsBySort( )
	local function sortTable( list )
		table.sort(list, function( a, b )
			if a.order < b.order then
				return true
			elseif a.order > b.order then
				return false
			else
				if a.id < b.id then
					return true
				else
					return false
				end
			end
		end)
	end

	local rewardReachList = {}
	local rewardCfgs = self:getRewardCfgs()
	for i,_rewardCfg in ipairs(rewardCfgs) do
		if self:getRewardIdReachState(_rewardCfg.id) and (not self:getRewardState(_rewardCfg.id))  then
			table.insert(rewardReachList, _rewardCfg)
		end
	end
	sortTable(rewardReachList)

	local rewardUnReachList = {}
	for i,_rewardCfg in ipairs(rewardCfgs) do
		if not self:getRewardIdReachState(_rewardCfg.id) then
			table.insert(rewardUnReachList, _rewardCfg)
		end
	end
	sortTable(rewardUnReachList)

	local rewardList = {}
	for i,_rewardCfg in ipairs(rewardCfgs) do
		if self:getRewardState(_rewardCfg.id) then
			table.insert(rewardList, _rewardCfg)
		end
	end
	sortTable(rewardList)
	
	local rewardCfgList = {}
	for _,_reward in ipairs(rewardReachList) do
		table.insert(rewardCfgList, _reward)
	end
	for _,_reward in ipairs(rewardUnReachList) do
		table.insert(rewardCfgList, _reward)
	end
	for _,_reward in ipairs(rewardList) do
		table.insert(rewardCfgList, _reward)
	end
	return rewardCfgList
end

--已经达成的所有档位
function RechargeDataMgr:getReachRewardIdList( )
	local totalPay = self:getTotalPay()
	local totalPayRewardCfg = self:getRewardCfgs()
	local rewardIdList = {}
	for i,_config in ipairs(totalPayRewardCfg) do
		if totalPay >= _config.amount then
			table.insert(rewardIdList, _config.id)
		end
	end
	return rewardIdList
end

--未达成的最近档位所需充值钻石数
function RechargeDataMgr:getNextRewardCfgAmount( )
	local rewardIdList = self:getReachRewardIdList()
	local rewardCfgs = self:getRewardCfgs()
	local index = math.min(#rewardIdList + 1, #rewardCfgs)
	local rewardCfg = rewardCfgs[index]
	if rewardCfg == nil then return 0 end
	return rewardCfg.amount
end

--累计充值档位达成状态
function RechargeDataMgr:getRewardIdReachState( rewardId )
	local rewardIdList = self:getReachRewardIdList()
	for i,_rewardId in ipairs(rewardIdList) do
		if _rewardId == rewardId then
			return true
		end
	end
	return false
end

--累计充值档位领取状态
function RechargeDataMgr:getRewardState( rewardId )
	local rewardIds = self:getRewardIds()
	for i,_rewardId in ipairs(rewardIds) do
		if _rewardId == rewardId then
			return true
		end
	end
	return false
end

function RechargeDataMgr:getCanRewardList( )
	local totalPay = self:getTotalPay()
	local totalPayRewardCfg = self:getRewardCfgs()
	local rewardIdList = {}
	for i,_config in ipairs(totalPayRewardCfg) do
		if totalPay >= _config.amount and _config.canReward then
			table.insert(rewardIdList, _config.id)
		end
	end
	return rewardIdList
end

function RechargeDataMgr:getTotalRedDotState( )
	local rewardIds = self:getRewardIds() 
	local canRewardIdList = self:getCanRewardList()
	return #canRewardIdList > #rewardIds
end

function RechargeDataMgr:getTotalOpenId( )
    return 66
end

function RechargeDataMgr:getMonthCardSignData()
	return self.monthCardSignData
end

function RechargeDataMgr:getMonthCardGiftData()
	return self.monthCardGiftData
end

function RechargeDataMgr:isMonthCardCanSign()
    return tobool(self.monthCardSignData.canSign)
end

function RechargeDataMgr:isMonthCardGiftCanBuy(id)
	for i, v in ipairs(self.monthCardGiftData) do
		if v.id == id then
			for ci, cv in ipairs(v.price) do
				local owncount = GoodsDataMgr:getItemCount(cv.id)
				return tobool(owncount >= cv.num), tobool(v.buyCount > 0)
			end
			break
		end
	end
	return false, false
end

--[[代币]]
function RechargeDataMgr:getTokenMoneyData()
	local list = {};
	if not self.goodsList or not self.goodsList.rechargeGiftBagCfg then
		return
	end
	for k,v in pairs(self.goodsList.rechargeGiftBagCfg) do
		if v.interfaceType == 10 then
			table.insert(list,v);
		end
	end

	return list;
end

--2周年
function RechargeDataMgr:getAnniversary2yearData()
	local list = {};
	if not self.goodsList or not self.goodsList.rechargeGiftBagCfg then
		return
	end
	for k,v in pairs(self.goodsList.rechargeGiftBagCfg) do
		if v.interfaceType == 15 then
			table.insert(list,v);
		end
	end

	list = self:sortGiftList(list)
	return list;
end

--根据面板类型获取对应的礼包列表
function RechargeDataMgr:getGiftListByType(interfaceType)
	local list = {}
	if not self.goodsList or not self.goodsList.rechargeGiftBagCfg then
		return
	end
	for k,v in pairs(self.goodsList.rechargeGiftBagCfg) do
		if v.interfaceType == interfaceType then
			table.insert(list, v)
		end
	end

	list = self:sortGiftList(list)
	return list
end

--根据面板类型获取剩余可购买礼包的数量
function RechargeDataMgr:getLeftGiftCnt(interfaceType)
	local leftCnt = 0
	if not self.goodsList or not self.goodsList.rechargeGiftBagCfg then
		return leftCnt
	end
	local serverTime = ServerDataMgr:getServerTime()
	for k, v in pairs(self.goodsList.rechargeGiftBagCfg) do
		local left = v.buyCount - self:getBuyCount(v.rechargeCfg.id)
		--v.buyCount等于0不限购
		if v.interfaceType == interfaceType and (v.buyCount == 0 or left > 0) then
			if v.startDate and v.endDate then
	            if serverTime >= v.startDate and serverTime < v.endDate then
	               leftCnt = leftCnt + 1
	            end
	        else
	            leftCnt = leftCnt + 1
	        end
		end
	end
	return leftCnt
end

--判断特殊礼包是否可以购买
function RechargeDataMgr:checkSpecialGiftId(id)
	if not self.goodsList or not self.goodsList.rechargeGiftBagCfg then
		return false
	end
	local serverTime = ServerDataMgr:getServerTime()
	for k, v in pairs(self.goodsList.rechargeGiftBagCfg) do
		local left = v.buyCount - self:getBuyCount(v.rechargeCfg.id)
		--v.buyCount等于0不限购
		if v.rechargeCfg.id == id and (v.buyCount == 0 or left > 0) then
			if v.startDate and v.endDate then
	            if serverTime >= v.startDate and serverTime < v.endDate then
	               return true
	            end
	        end
		end
	end
	return false
end

function RechargeDataMgr:RECHARGE_REQ_CHARGE_EXCHANGE(rechargeId,discountId,redPackId,bless,buyCount)
	discountId = discountId or ""
	redPackId = redPackId or 0
	bless = bless or ""
	buyCount = buyCount or 0
	local msg = {
		rechargeId,
		discountId,
		redPackId,
		bless,
		buyCount,
	}

	TFDirector:send(c2s.RECHARGE_REQ_CHARGE_EXCHANGE, msg)
end

function RechargeDataMgr:RECHARGE_RES_CHARGE_EXCHANGE(event)
	EventMgr:dispatchEvent(EV_GOODS_EXCHANGE, event.data)
end

-- 养成基金奖励领取
function RechargeDataMgr:SendGrowFundRward(id)
	TFDirector:send(c2s.RECHARGE_REQ_GET_FUN_AWARD,{id})
end

function RechargeDataMgr:currencyIsEnough(allCost, buyNum)
	buyNum = buyNum or 1
	local enough = true
	local noEnoughItem;
	for i = 1, #allCost do
		local cost = allCost[i]
        local haveNum = GoodsDataMgr:getItemCount(cost["id"])
        if haveNum < cost["num"] * buyNum then
			enough = false
			noEnoughItem = cost
			break;
		end     
    end
	return enough, noEnoughItem
end

function RechargeDataMgr:getWeekCardCanSign()
	local info = self:getWeekCardInfo()
	local isHaveCard = tobool((info.etime - ServerDataMgr:getServerTime()) > 0)
	return (isHaveCard and info.canSign)
end

--获取月卡信息
function RechargeDataMgr:getMonthCardInfo(  )
	return self.monthCard
end

return RechargeDataMgr:new();
