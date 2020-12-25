local BaseDataMgr = import(".BaseDataMgr")
local OneYearDataMgr = class("OneYearDataMgr", BaseDataMgr)
local UserDefalt = CCUserDefault:sharedUserDefault()

function OneYearDataMgr:ctor()
    self:init()
end

function OneYearDataMgr:registerMsgEvent()

    TFDirector:addProto(s2c.YEAR_LOTTO_RESP_YEAR_LOTTO_INFO, self, self.onRecvCelebrateBaseInfo)
    TFDirector:addProto(s2c.YEAR_LOTTO_RESP_YEAR_LOTTO_LIST, self, self.onRecvLuckyListInfo)
    TFDirector:addProto(s2c.YEAR_LOTTO_RESP_JOIN_YEAR_LOTTO, self, self.onRecvAfterSign)
    TFDirector:addProto(s2c.YEAR_LOTTO_RESP_YEAR_LOTTO_REWARD, self, self.onRecvAfterReward)
    TFDirector:addProto(s2c.YEAR_LOTTO_RESP_YEAR_LOTTO_ADDRESS, self, self.onRecvChangeAddress)
    TFDirector:addProto(s2c.YEAR_LOTTO_RESP_YEAR_LOTTO_NEW_PLAYER, self, self.onRecvNewLuckyListInfo)
    TFDirector:addProto(s2c.YEAR_LOTTO_RESP_YEAR_LOTTO_JOIN_NUM, self, self.onRecvSignPersonNum)
end

function OneYearDataMgr:init()
    self:initData()
    self:registerMsgEvent()
end

function OneYearDataMgr:initData()

    local jsonContent = io.readfile(string.format("address/content.json"))
    if jsonContent == nil or jsonContent == "" then
        return
    end

    self.provinceTab_ = {}
    self.municipalTab_ = {}
    self.townTab = {}
    local addressData = json.decode(jsonContent)
    for k,v in pairs(addressData.data) do
        local provinceId = tonumber(v.label)
        local tab = {}
        tab.value = v.value
        tab.label = provinceId
        table.insert(self.provinceTab_,tab)
        self.municipalTab_[provinceId] = {}
        for _,v2 in pairs(v.children) do
            local municipalId = tonumber(v2.label)
            local municipal = {}
            municipal.value = v2.value
            municipal.label = municipalId
            table.insert(self.municipalTab_[provinceId],municipal)
            self.townTab[municipalId] = {}
            for _,v3 in pairs(v2.children) do
                local town = {}
                town.value = v3.value
                town.label = v3.label
                table.insert(self.townTab[municipalId],town)
            end
        end
    end

    self.cdTime = 60
    self.nextTime = 0
    self.joinStatus = {}
end


function OneYearDataMgr:onLogin()

end

function OneYearDataMgr:onEnterMain()

    self.fiilInfo = {}
    -- self.rewardStatus = 0
    self.signPersonNum = 0
    self.luckyLitMap_ = {}
    self.luckyList = {}
    self:initLuckyTipFlag()
    local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.ONEYEAR_CELEBRATION)
    if #activity > 0 then
        local activityInfo_ = ActivityDataMgr2:getActivityInfo(activity[1])
        if activityInfo_ then
            self:setStageTimeGroup(activityInfo_.extendData.alternately)
            self:setCelebrationRewarsInfo(activityInfo_.extendData.reward)
            TFDirector:send(c2s.YEAR_LOTTO_REQ_YEAR_LOTTO_INFO, {})
            return {s2c.YEAR_LOTTO_RESP_YEAR_LOTTO_INFO}
        end
    end

end

function OneYearDataMgr:getProvince()
    return self.provinceTab_
end

function OneYearDataMgr:getMunicipal(provinceId)
    if not self.municipalTab_[provinceId] then
        return {}
    end
    return self.municipalTab_[provinceId]
end

function OneYearDataMgr:getTown(municipalId)
    if not self.townTab[municipalId] then
        return {}
    end
    return self.townTab[municipalId]
end

function OneYearDataMgr:setSelectProvince(provinceStr)
    self.province = provinceStr
end

---所有填写的信息
function OneYearDataMgr:setFillInfo(fiilInfo)
    self.fiilInfo = fiilInfo
end

---下次能够更改信息的时间
function OneYearDataMgr:setNextTime()
    self.nextTime = ServerDataMgr:getServerTime() + self.cdTime
end

function OneYearDataMgr:getNextTime()
    return self.nextTime
end

function OneYearDataMgr:getFillInfo()
    return self.fiilInfo
end

function OneYearDataMgr:getSignPersonNum()
    return self.signPersonNum
end

function OneYearDataMgr:isSign()
    return self.joinStatus[self:getCurTurnIndex()].joinStatus
end

function OneYearDataMgr:getAwardState()
    return self.rewardStatus
end

function OneYearDataMgr:updateLuckyPlayer(players)

    if not self.luckyLitMap_ then
        self.luckyLitMap_ = {}
    end
    local newplayers = players or {}
    for k,v in ipairs(newplayers) do
        if not self.luckyLitMap_[v.round] then
            self.luckyLitMap_[v.round] = {}
        end
        if not self.luckyLitMap_[v.round][v.prize] then
            self.luckyLitMap_[v.round][v.prize] = {}
        end
        table.insert(self.luckyLitMap_[v.round][v.prize],v)
    end
end

function OneYearDataMgr:getLuckyList(turnId,prizeId)
    if not self.luckyLitMap_[turnId] then
        return {}
    end

    if not self.luckyLitMap_[turnId][prizeId] then
        return {}
    end

    return self.luckyLitMap_[turnId][prizeId]
end

function OneYearDataMgr:setCelebrationRewarsInfo(rewards)
    self.celeBrationAward = rewards or {}
end

function OneYearDataMgr:getCelebrationRewards()
    return self.celeBrationAward
end

---返回：奖励，奖励等次，轮次
function OneYearDataMgr:getRewardsByPrizeId(prizeId)

    if not self.celeBrationAward then
        return {},0,0
    end
    for k,v in ipairs(self.celeBrationAward) do
        local index = table.indexOf(v.list,prizeId)
        if index ~= -1 then
            return v.show,k,index
        end
    end
    return {},0,0
end

---设置每轮次相关时间组
function OneYearDataMgr:setStageTimeGroup(alternately)
    self.alternately = alternately or {}

    -- 数据更改 模拟以前结构
    local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.ONEYEAR_CELEBRATION)
    local activityInfo_ = ActivityDataMgr2:getActivityInfo(activity[1])
    for i, v in ipairs(self.alternately) do
        v.roundendTime = v.registrationTime + activityInfo_.extendData.endTtime
    end

    self.stageTime = {}
    for k,v in ipairs(self.alternately) do
        if not self.stageTime[k] then
            self.stageTime[k] = {}
        end
        table.insert(self.stageTime[k],{beginTime = v.registrationTime,endTime = v.endTtime})   --stage 1
        table.insert(self.stageTime[k],{beginTime = v.drawInfo[1].drawTime,endTime = v.drawInfo[1].closingTime}) --stage 2
        table.insert(self.stageTime[k],{beginTime = v.drawInfo[2].drawTime,endTime = v.drawInfo[2].closingTime}) --stage 3
        table.insert(self.stageTime[k],{beginTime = v.rewardTime,endTime = v.finishTime}) --stage 4
    end
end

-- 抽奖活动结束
function OneYearDataMgr:isOverAllDraw()
    local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.ONEYEAR_CELEBRATION)
    if #activity > 0  and self.alternately then
        local activityInfo_ = ActivityDataMgr2:getActivityInfo(activity[1])
        -- local lastDrawOverTime = self.alternately[#self.alternately].registrationTime + activityInfo_.extendData.endTtime
        local _drawInfo = self.alternately[#self.alternately].drawInfo
        local lastDrawOverTime = _drawInfo[#_drawInfo].closingTime
        return lastDrawOverTime < ServerDataMgr:getServerTime()
    end
    return true
end

-- 报名结束
function OneYearDataMgr:isFinishAllApply()
    local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.ONEYEAR_CELEBRATION)
    if #activity > 0 then
        local activityInfo_ = ActivityDataMgr2:getActivityInfo(activity[1])
        local lastTime = self.alternately[#self.alternately].registrationTime + activityInfo_.extendData.endTtime
        return lastTime < ServerDataMgr:getServerTime()
    end
    return true
end

---获得当前轮数
function OneYearDataMgr:getCurTurnIndex()
    local index
    local curTime = ServerDataMgr:getServerTime()
    for k,v in ipairs(self.alternately) do
        if curTime <= v.roundendTime then
            index = k
            break
        end
    end

    ---小于第一轮的报名时间，默认为第一轮
    if curTime < self.alternately[1].registrationTime then
        index = 1
    end

    ---大于最后一轮的结算时间，默认为最后一轮
    local latsIndex = #self.alternately
    if curTime >= self.alternately[latsIndex].roundendTime then
        index = latsIndex
    end
    return index
end

function OneYearDataMgr:getStageInfoByIndex(index)
    return self.alternately[index]
end

function OneYearDataMgr:getStageTimes()
    return self.stageTime
end

function OneYearDataMgr:getalternately()
    return self.alternately
end

function OneYearDataMgr:getPrizeId()
    return self.realPrize,self.realRound
end

function OneYearDataMgr:checkUpdateStage()
    local curTime = ServerDataMgr:getServerTime()
    for k,times in ipairs(self.stageTime) do
        for _,v in ipairs(times) do
            if curTime == v.beginTime or curTime == v.endTime+1 then
                return true
            end
        end
    end
    return false
end


---获取当前所处阶段 1：报名，2：抽奖一等奖 3：抽二等奖 4：领取奖励
function OneYearDataMgr:getTimeStage(stageIndex)

    local curTime = ServerDataMgr:getServerTime()
    local curStageTime = self.stageTime[stageIndex]
    local isInStage = false
    local stageId = 4  --本轮次已结束（isInStage == false）
    local len = #curStageTime
    for i=len,1,-1 do
        local beginTime = curStageTime[i].beginTime
        local endTime = curStageTime[i].endTime
        if curTime >= beginTime then
            if curTime <= endTime then
                isInStage = true
            end
            stageId = i
            break
        end
    end

    if curTime < curStageTime[1].beginTime then
        stageId = 1
    end

    return stageId,isInStage
end

function OneYearDataMgr:newLuckyList(list)

    if not self.luckyList then
        self.luckyList = {}
    end
    local datalist = list or {}
    local newList = {}
    for k,v in ipairs(datalist) do
        local key = v.sid..v.pid
        if not self.luckyList[key] then
            self.luckyList[key] = v
            table.insert(newList,v)
        end
    end
    return newList
end

function OneYearDataMgr:initLuckyTipFlag()
    local pid = MainPlayer:getPlayerId()
    local tip = UserDefalt:getStringForKey("CelebrationTip"..pid)
    self.luckyTip = tonumber(tip) or 0
end

function OneYearDataMgr:setLuckyTipFlag()
    self.luckyTip = 1
    local pid = MainPlayer:getPlayerId()
    UserDefalt:setStringForKey("CelebrationTip"..pid,self.luckyTip)
end

function OneYearDataMgr:getLuckyTipFlag()
    return self.luckyTip
end

----发送地址更改信息
function OneYearDataMgr:Send_submitAddress(jsonData)
    if not jsonData then
        return
    end
    self:setNextTime()
    TFDirector:send(c2s.YEAR_LOTTO_REQ_YEAR_LOTTO_ADDRESS, {jsonData})
end

function OneYearDataMgr:Send_sign()
    TFDirector:send(c2s.YEAR_LOTTO_REQ_JOIN_YEAR_LOTTO, {})
end

function OneYearDataMgr:Send_GetAward()
    TFDirector:send(c2s.YEAR_LOTTO_REQ_YEAR_LOTTO_REWARD, {})
end

function OneYearDataMgr:Send_GetLuckyList()
    TFDirector:send(c2s.YEAR_LOTTO_REQ_YEAR_LOTTO_LIST, {})
end

---基础信息
function OneYearDataMgr:onRecvCelebrateBaseInfo(event)

    local data = event.data
    if not data then
        return
    end
    for i, v in ipairs(data.roundInfo or {}) do
        self.joinStatus[math.floor(v.round / 1000)] = v
    end
    self.signPersonNum = data.joinNum
    if data.address then
        self.fiilInfo = json.decode(data.address)
    end
    
    self.realPrize = data.realPrize or 0        ---实体奖励
    self.realRound = data.realRound or 0        ---实物奖励轮次
    local flag = self:getLuckyTipFlag()
    if flag ~= 1 and self.realPrize > 0 and self.celeBrationAward then
        Utils:openView("oneYear.CelebrationLuckyTipView")
    end
    EventMgr:dispatchEvent(EV_UPDATE_BASE_ONFO)
end

-- 上一轮开奖时红点显隐
function OneYearDataMgr:isOpenAwardRedShow()
    local curTime = ServerDataMgr:getServerTime()
    local curIndex = self:getCurTurnIndex()
    local sumIndex = #self.alternately
    curIndex = curIndex == sumIndex and sumIndex or (curIndex - 1)
    local _data = self:getStageInfoByIndex(curIndex)
    if _data then
        local num = #_data.drawInfo
        local endTime = _data.drawInfo[num].closingTime
        if curTime > endTime and not self:isOverAllDraw() then 
            local key = "CelebrationView"..MainPlayer:getPlayerId()
            local value = Utils:getLocalSettingValue(key)
            return value == "" or value ~= tostring(endTime)
        else
            return false
        end
    else
        return false
    end
end

-- 
function OneYearDataMgr:isCelebrationRedShow()
    local _bool = false
    local isOpen =  ActivityDataMgr2:isInOpenTimeByType(EC_ActivityType2.ONEYEAR_CELEBRATION)
    if isOpen then
        if not self:isOverAllDraw() then
            -- not self:isSign() or
            if self:isOpenAwardRedShow() then
                _bool = true
            end
        end
    end
    return _bool
end

function OneYearDataMgr:setOpenAwardRedHide()
    local curTime = ServerDataMgr:getServerTime()
    local curIndex = self:getCurTurnIndex()
    local sumIndex = #self.alternately
    curIndex = curIndex == sumIndex and sumIndex or (curIndex - 1)
    local _data = self:getStageInfoByIndex(curIndex)
    if _data then
        local num = #_data.drawInfo
        local endTime = _data.drawInfo[num].closingTime

        if curTime > endTime and not self:isOverAllDraw() then 
            local key = "CelebrationView"..MainPlayer:getPlayerId()
            Utils:setLocalSettingValue(key, endTime)
        end
    end
end

function OneYearDataMgr:onRecvLuckyListInfo(event)
    local data = event.data
    if not data then
        return
    end
    -- dump(data)
    -- Box("data")
    local newList = self:newLuckyList(data.list)
    self:updateLuckyPlayer(newList)
    EventMgr:dispatchEvent(EV_UPDATE_NEW_LUCKYPLAYER)
end

function OneYearDataMgr:test(pid)
    local player = {}
    local tab = {}
    tab.fightPower = 242
    tab.headFrame = 0
    tab.headId = 0
    tab.level = 44
    tab.pName = "479479"..pid
    tab.pid = pid
    tab.prize = 2002
    tab.round = 2000
    tab.sid = 2
    table.insert(player,tab)
    local newList = self:newLuckyList(player)
    self:updateLuckyPlayer(newList)
    EventMgr:dispatchEvent(EV_ADD_NEW_LUCKYPLAYER,newList)
end

function OneYearDataMgr:test2(pid)
    local player = {}
    for i=pid,pid+4 do
        local tab = {}
        tab.fightPower = 242
        tab.headFrame = 0
        tab.headId = 0
        tab.level = 44
        tab.pName = "479479"..i
        tab.pid = pid
        tab.prize = 102
        tab.round = 100
        tab.sid = 2
        table.insert(player,tab)
    end
    local newList = self:newLuckyList(player)
    self:updateLuckyPlayer(newList)
    EventMgr:dispatchEvent(EV_ADD_NEW_LUCKYPLAYER,newList)
end

function OneYearDataMgr:onRecvNewLuckyListInfo(event)

    local data = event.data
    if not data then
        return
    end
    local newList = self:newLuckyList(data.players)
    self:updateLuckyPlayer(newList)
    EventMgr:dispatchEvent(EV_ADD_NEW_LUCKYPLAYER,newList)
end

function OneYearDataMgr:onRecvAfterSign(event)

    local data = event.data
    if not data then
        return
    end
end

function OneYearDataMgr:onRecvAfterReward(event)

    local data = event.data
    if not data then
        return
    end
    -- self.rewardStatus = 2
    EventMgr:dispatchEvent(EV_ACTIVITY_UPDATE_PROGRESS)
    Utils:showReward(data.rewards or {})
end

function OneYearDataMgr:onRecvChangeAddress(event)

    local data = event.data
    if not data then
        return
    end
    EventMgr:dispatchEvent(EV_UPDATE_CHANGE_ADDRESS)
end


function OneYearDataMgr:onRecvSignPersonNum(event)

    local data = event.data
    if not data then
        return
    end
    self.signPersonNum = data.num
    EventMgr:dispatchEvent(EV_UPDATE_SIGN_NUM)

end

return OneYearDataMgr:new();
