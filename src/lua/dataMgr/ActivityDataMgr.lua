local BaseDataMgr = import(".BaseDataMgr")
local ActivityDataMgr = class("ActivityDataMgr", BaseDataMgr)
require("lua.logic.activity.json");

function ActivityDataMgr:ctor()
	self.actList = {};
	self:init();
end


function ActivityDataMgr:init()
	TFDirector:addProto(s2c.SIGN_RESP_SIGN_INFOS, self, self.recvActivityList)
	TFDirector:addProto(s2c.SIGN_RESULT_SUBMIT_SIGN, self, self.revcReceiveReward)
	TFDirector:addProto(s2c.SIGN_RESP_SEVEN_CARNIVAL, self, self.revcSevenExList)
	TFDirector:addProto(s2c.SIGN_RESP_PURCH_STORE, self, self.revcBuySevenExGift)
	TFDirector:addProto(s2c.ACTIVITY_RESP_NEW_YEAR_WELFARE_URL, self, self.revcNewYear)
end

function ActivityDataMgr:getIsHaveActs( )
	return table.count(self.actList) > 0;
end

function ActivityDataMgr:getActivitys()
	return self.actList;
end

function ActivityDataMgr:getActivityCnt()
	return table.count(self.actList);
end

function ActivityDataMgr:getActIdx(actID)
	local idx = -1;
	for i,v in ipairs(self.actList) do
		if v.id == actID then
			idx = i;
			break;
		end
	end

	return idx
end

function ActivityDataMgr:getActIdxByID(actID)
	local idx = -1;
	for i,v in ipairs(self.actList) do
		if v.id == actID then
			idx = i;
			break;
		end
	end

	return idx
end

function ActivityDataMgr:getActData(actIdx)
	return self.actList[actIdx];
end

function ActivityDataMgr:getActList(actIdx)
	return self.actList[actIdx]
end

--UI
function ActivityDataMgr:getActTitle(actId)
	local cfg = self:getActivityFirstCfgById(actId, 1)
	if cfg then
		return cfg.name
	end
	return ""
end

function ActivityDataMgr:getActBg(actIdx)
	local act = self.actList[actIdx]
	local actCfg = self:getActivityFirstCfgById(act.id, 1)
	if act.id == EC_ActivityType.SIGN then
		return actCfg.icon
	elseif act.id == EC_ActivityType.SEVENDAY then
		return actCfg.adIcon
	elseif act.id == EC_ActivityType.NEXTDAY then
		return actCfg.adIcon
	elseif act.id == EC_ActivityType.POWER then
		return actCfg.icon
	end
	return ""
end
--UI end

function ActivityDataMgr:getActId(actIdx)
	return self.actList[actIdx].id
end

function ActivityDataMgr:getActEntryCnt(actIdx)
	local act = self.actList[actIdx]
	local count = 0
	if act.id == EC_ActivityType.SIGN then
		local cfgMap = TabDataMgr:getData("Sign")
		for i,v in ipairs(cfgMap) do
			if tostring(v.month) == tostring(act.extendData) then
				count = count + 1
			end
		end
	elseif act.id == EC_ActivityType.SEVENDAY then
		local cfgMap = TabDataMgr:getData("SevenSign")
		for i,v in ipairs(cfgMap) do
			count = count + 1
		end
	end
	return count
end

function ActivityDataMgr:getActOneEntry(actIdx,idx)
	local act = self.actList[actIdx]
	local status = act.awardType[1] or 0
	local rewards = {}
	if act.id == EC_ActivityType.SIGN then
		if act.index < idx then
			status = 2
		elseif act.index > idx then
			status = 0
		end
		local cfgMap = TabDataMgr:getData("Sign")
		for i,v in ipairs(cfgMap) do
			if tostring(v.month) == tostring(act.extendData) and v.signTimes == idx then
				rewards = v.gifts or {}
			end
		end
	elseif act.id == EC_ActivityType.SEVENDAY then
		status = act.awardType[idx]
		local cfgMap = TabDataMgr:getData("SevenSign")
		for i,v in ipairs(cfgMap) do
			if v.signTimes == idx then
				rewards = v.gifts or {}
			end
		end
	end
	return status, rewards
end

function ActivityDataMgr:onLogin()
	TFDirector:send(c2s.SIGN_REQ_SIGN_INFOS, {})
	TFDirector:send(c2s.SIGN_REQ_SEVEN_CARNIVAL, {})
	return {s2c.SIGN_RESP_SIGN_INFOS,s2c.SIGN_RESP_SEVEN_CARNIVAL}
end

function ActivityDataMgr:onLoginOut()
	self.actList = {}
end

function ActivityDataMgr:recvActivityList(event)
	if not event.data.signInfos then
		return
	end

	local isSort = false;
	local ischange = false;
	if table.count(self.actList) < table.count(event.data.signInfos) then
		isSort = true
		ischange = true
	end
	for k,v in pairs(event.data.signInfos) do
		local idx = self:getActIdxByID(v.id)
		if idx == -1 then
			table.insert(self.actList,v);
		else
			self.actList[idx] = v;
		end

		--领取大于等于第3天的7日奖励，弹出5星好评
		if v.id == 2 and ischange == false then
			if v.awardType[3] == 0 then
				CommonManager:setStarEvaluateFlage(true)
			end
		end
	end
	local data = TabDataMgr:getData("DiscreteData",23001).data
	local function sortfunc(a,b)
		local aorder = 1
		local border = 1
		for k, cfg in pairs(data) do
			if cfg.id == a.id then
				aorder = cfg.order
			end
			if cfg.id == b.id then
				border = cfg.order
			end
		end
		return aorder < border
	end

	if table.count(self.actList) > 1 and isSort then
		table.sort(self.actList,sortfunc);
	end

	if ischange then
		EventMgr:dispatchEvent(EV_ACTIVITY_LIST_CHANGE);
	else
		EventMgr:dispatchEvent(EV_ACTIVITY_UPDATE_UI);
	end
end

function ActivityDataMgr:getReceivedIndex(actIdx)
	local act = self:getActList(actIdx)
	if act.id == EC_ActivityType.SIGN then
		return act.index
	elseif act.id == EC_ActivityType.SEVENDAY then

	elseif act.id == EC_ActivityType.NEXTDAY then

	elseif act.id == EC_ActivityType.POWER then

	end
	return act.index
end

function ActivityDataMgr:getIsCanReceive(actIdx)
	local flag = false
	local act = self:getActList(actIdx)
	if act then
		if act.id == EC_ActivityType.SIGN then
			for i,state in ipairs(act.awardType) do
				if state == 1 then
					flag = true
				end
			end
		elseif act.id == EC_ActivityType.SEVENDAY then
			for i,state in ipairs(act.awardType) do
				if state == 1 then
					flag = true
				end
			end
		elseif act.id == EC_ActivityType.NEXTDAY then
			for i,state in ipairs(act.awardType) do
				if state == 1 then
					flag = true
				end
			end
		elseif act.id == EC_ActivityType.POWER then
			for i,state in ipairs(act.awardType) do
				if state == 1 then
					flag = true
				end
			end
		end
	else
		local sevenExTask_ = TaskDataMgr:getTask(EC_TaskType.SEVENEX)
		for k,v in pairs(sevenExTask_) do
			local taskCid = sevenExTask_[k]
	    	local taskInfo = TaskDataMgr:getTaskInfo(taskCid)
	    	if taskInfo.status == EC_TaskStatus.GET then
	    		flag = true
	    	end
		end
	end

	return flag
end

function ActivityDataMgr:getOneDayShowRedPoint(dayIndex)
	local flag = false
	local sevenExTask_ = TaskDataMgr:getTask(EC_TaskType.SEVENEX)
	for k,v in pairs(sevenExTask_) do
		local taskCid = sevenExTask_[k]
    	local taskInfo = TaskDataMgr:getTaskInfo(taskCid)
    	local taskCfg = TaskDataMgr:getTaskCfg(taskCid)
    	if taskInfo.status == EC_TaskStatus.GET and taskCfg.acceptParams.day == dayIndex then
    		flag = true
    	end
	end
	return flag
end

function ActivityDataMgr:getActivityFirstCfgById(actId, idx)
	if actId == EC_ActivityType.SIGN then
		return TabDataMgr:getData("Sign", idx)
	elseif actId == EC_ActivityType.SEVENDAY then
		return TabDataMgr:getData("SevenSign", idx)
	elseif actId == EC_ActivityType.NEXTDAY then
		return TabDataMgr:getData("TomorrowSign", idx)
	elseif actId == EC_ActivityType.POWER then
		return TabDataMgr:getData("EnergySupplement", idx)
	end
end

function ActivityDataMgr:receiveReward(actIdx)
	local isCan = self:getIsCanReceive(actIdx);

	if not isCan then
		Utils:showTips("没有可领取的奖励");
		return;
	end

	self:receiveRewardMsg(actIdx)
end

function ActivityDataMgr:receiveRewardMsg(actIdx)
	local actid = self:getActId(actIdx);
	local msg = {
		actid,
	}

	TFDirector:send(c2s.SIGN_SUBMIT_SIGN, msg);
end

function ActivityDataMgr:revcReceiveReward(event)
	local reward = event.data.rewards;
	if reward and #reward > 0 then
		local id = reward[1].id;
		local itemCfg = GoodsDataMgr:getItemCfg(id);

		if itemCfg.superType ~= EC_ResourceType.HERO then
			Utils:showReward(reward);
		end
	end
end

function ActivityDataMgr:checkRedPoint()
    local ret = false;
    for k,v in pairs(self.actList) do
        if self:getIsCanReceive(k) then
            ret = true;
            break;
        end
    end

    if self.sevenExData and self.sevenExData.day > 0 then
	    local sevenExTask_ = TaskDataMgr:getTask(EC_TaskType.SEVENEX)
	    for k,v in pairs(sevenExTask_) do
	        local taskCid = sevenExTask_[k]
	        local taskInfo = TaskDataMgr:getTaskInfo(taskCid)
	        if taskInfo.status == EC_TaskStatus.GET then
	            ret = true
	        end
	    end
	end

    -- 圣诞签到
    local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.CHRISTMAS_SIGN)
    if #activity > 0 then
        if ActivityDataMgr2:isShowRedPoint(activity[1]) then
            ret = true
        end
    end

	--萌新召唤
	local noobInfo = SummonDataMgr:getNoobInfo()
	if noobInfo and noobInfo.awardState == 1 then
		ret = true
	end

	-- if RechargeDataMgr:isMonthCardCanSign() then
	-- 	ret = true
	-- end

    return ret;
end

function ActivityDataMgr:getSevenExData()
	local sevenExTask_ = TaskDataMgr:getTaskCfgByType(EC_TaskType.SEVENEX);
	local ret = {};
  local serverTime = ServerDataMgr:getServerTime()
	for k,v in pairs(sevenExTask_) do
    	ret[v.acceptParams.day] = ret[v.acceptParams.day] or {}

      if self.sevenExData.state == 1 then    -- 新玩家
          if v.acceptParams.acceptType then
          else
              table.insert(ret[v.acceptParams.day],v.id)
          end
      else
          table.insert(ret[v.acceptParams.day],v.id)
      end
	end
	return ret;
end

function ActivityDataMgr:revcSevenExList(event)
	self.sevenExData = event.data;
end

function ActivityDataMgr:checkSevenExEnable()
	return self.sevenExData and self.sevenExData.day > 0 or false
end

function ActivityDataMgr:getSevenExCurDayTag()
	return self.sevenExData.day;
end

function ActivityDataMgr:isSevenExGiftCanBuy(dayTag)
	local day = dayTag;
	local his = self.sevenExData.storeList;
	if not his  then
		return true;
	end

	local isFind = false
	if his then
		for k,v in pairs(his) do
			if v.storeId == day then
				local dayCfg = TabDataMgr:getData("SevenGift",day);
				if v.num < dayCfg.paytimes then
					return true;
				end

				isFind = true
			end
		end
	end

	return not isFind;
end

function ActivityDataMgr:addSevenExBuyTimes(dayTag)
	local day = dayTag;
	if not self.sevenExData then
		local t = {}
		t.num = 1;
		t.storeId = dayTag
		self.sevenExData = {}
		self.sevenExData.storeList = {};
		table.insert(self.sevenExData.storeList,t);
		return
	end

	local his = self.sevenExData.storeList;
	local isFind = false
	if his then
		for k,v in pairs(his) do
			if v.storeId == day then
				v.num = v.num + 1;
				isFind = true
			end
		end
	end

	if not isFind then
		if self.sevenExData.storeList then
			local t = {}
			t.num = 1;
			t.storeId = dayTag
			table.insert(self.sevenExData.storeList,t);
		end
	end

	if not self.sevenExData.storeList then
		local t = {}
		t.num = 1;
		t.storeId = dayTag
		self.sevenExData.storeList = {};
		table.insert(self.sevenExData.storeList,t);
		return
	end
end

function ActivityDataMgr:getChristmasSignInFlag()
    return self.christmsSignInFlag_
end

function ActivityDataMgr:setChristmasSignInFlag(flag)
    self.christmsSignInFlag_ = flag
end

function ActivityDataMgr:buySevenExGift(dayTag)
	local msg = {
		dayTag
	}
	self.dayTag = dayTag
	TFDirector:send(c2s.SIGN_REQ_PURCH_STORE, msg);
end

function ActivityDataMgr:revcBuySevenExGift(event)
	local curDayTag = self.dayTag--self:getSevenExCurDayTag();
    local curDayCfg = TabDataMgr:getData("SevenGift",curDayTag);
    local item = curDayCfg.item;
    local rewards = {}
    local itemId
    for k,v in pairs(item) do
    	local reward = {};
    	reward.id = k;
    	itemId = k
    	reward.num = v;
    	table.insert(rewards,reward);
    end

    local itemCfg = TabDataMgr:getData("Item",itemId);
    local rewardsItem = {}
    local item = itemCfg.useProfit.fix.items
    for k,v in pairs(item) do
    	local rewardItem = {};
    	rewardItem.id = v.id;
    	rewardItem.num = v.num;
    	table.insert(rewardsItem,rewardItem);
    end

    Utils:showReward(rewardsItem);
    self:addSevenExBuyTimes(self.dayTag)
    EventMgr:dispatchEvent(EV_TASK_UPDATE)
    self.dayTag = nil
end

function ActivityDataMgr:revcNewYear(event)
	dump(event.data.url)
	--Utils:showWebView(event.data.url,nil,true);
	TFDeviceInfo:openUrl(event.data.url);
end

function ActivityDataMgr:sendNewYear()
	TFDirector:send(c2s.ACTIVITY_REQ_NEW_YEAR_WELFARE_URL, {});
end 

return ActivityDataMgr:new()
