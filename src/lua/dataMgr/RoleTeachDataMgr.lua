local BaseDataMgr = import(".BaseDataMgr")
local RoleTeachDataMgr = class("RoleTeachDataMgr", BaseDataMgr)
local RoleTachMacro = require("lua.logic.datingPhone.RoleTachMacro")

function RoleTeachDataMgr:ctor()
    self:init()
end

function RoleTeachDataMgr:init()
    self:initData()
    self:registerMsgEvent()
end

function RoleTeachDataMgr:initData()
    -- 基础信息
    self.achieveInfo = nil
    -- 成就数据
    self.achieveGetData = nil
    -- 调教
    self.teachData   = {
        -- 问题集
        [RoleTachMacro.TEACH.Issue] = nil,
        -- 调教
        [RoleTachMacro.TEACH.TeachSelf] = nil,
        -- 审核列表
        [RoleTachMacro.TEACH.CHECK] = {
            -- 审核中
            [RoleTachMacro.CHECK.Doing] = nil,
            -- 审核成功
            [RoleTachMacro.CHECK.Success] = nil,
            -- 审核失败
            [RoleTachMacro.CHECK.Failed] = nil
        }
    }
    -- 调教红点
    self.teachRed = {
        [RoleTachMacro.TEACH.Issue] = false,
        [RoleTachMacro.TEACH.CHECK] = {
            [RoleTachMacro.CHECK.Success] = false,
            [RoleTachMacro.CHECK.Failed] = false
        }
    }
    -- 排行
    self.rankData    = {
        -- 周排行
        [RoleTachMacro.RANK.WeekRank] = nil,
        -- 月排行
        [RoleTachMacro.RANK.SumRank] = nil,
        -- 我的排行数据
        myRankData = {
            [RoleTachMacro.RANK.WeekRank] = nil,
            [RoleTachMacro.RANK.SumRank] = nil,
        }
    }  
end

function RoleTeachDataMgr:onLogin()
    -- RoleTeachDataMgr:SendTeachInfoRequest()
end

function RoleTeachDataMgr:onEnterMain()
    self:SendTeachInfoRequest()
end

function RoleTeachDataMgr:reset()
    -- self:initData()
end

function RoleTeachDataMgr:registerMsgEvent()
    TFDirector:addProto(s2c.DATING_RESP_AITRAINING_INFO, self, self.onRoleTeachInfo)
    TFDirector:addProto(s2c.DATING_RESP_AITRAINING_RANK, self, self.onRevRankData)
    TFDirector:addProto(s2c.DATING_RESP_AITRAINING_QUESTIONS, self, self.onRevChangeIssuePage)
    TFDirector:addProto(s2c.DATING_RESP_AITRAINING_AUDIT, self, self.onRevCheckData)
    TFDirector:addProto(s2c.DATING_RESP_AITRAINING_SUBMIT,self, self.onRecSubmit)
    TFDirector:addProto(s2c.DATING_RESP_AIAUDIT_UPDATE,self, self.onRecTeachRed)
end

function RoleTeachDataMgr:onRoleTeachInfo(event)
    if not event.data then
        return
    end
    self.achieveInfo = event.data
    EventMgr:dispatchEvent(EV_ROLETEACHCURLAYER_REFRESH,RoleTachMacro.PAGETYPE.ACHIEVE)
end

function RoleTeachDataMgr:onRevRankData(event)
    local data = event.data
    if not data then
        return
    end
    if data.type then
        if data.list and #data.list ~= 0 then
            table.sort(data.list , function(a, b)
                return a.rank < b.rank
            end)
            self.rankData[data.type] = data.list
        end
        self.rankData.myRankData[data.type] = data.selfRank
    end
    EventMgr:dispatchEvent(EV_ROLETEACHCURLAYER_REFRESH,RoleTachMacro.PAGETYPE.RANK, RoleTachMacro.RANK.WeekRank)
end

function RoleTeachDataMgr:onRevChangeIssuePage(event)
    local data = event.data
    if not data then
        return
    end
    -- 第一页时不管有无数据都接收
    if #Json.decode(data.jsonList) == 0 and data.page ~= 1 then
        return
    end
    self.teachData[RoleTachMacro.TEACH.Issue] = data
    EventMgr:dispatchEvent(EV_ROLETEACHCURLAYER_REFRESH,RoleTachMacro.PAGETYPE.TEACH, RoleTachMacro.TEACH.Issue)
end

function RoleTeachDataMgr:onRevCheckData(event)
    local data = event.data
    if not data then
        return
    end
     -- 第一页时不管有无数据都接收
    if #Json.decode(data.jsonList) == 0 and data.page ~= 1 then
        return
    end
    local type = data.type
    if type == 0 then
        self.teachData[RoleTachMacro.TEACH.CHECK][RoleTachMacro.CHECK.Doing] = data
        EventMgr:dispatchEvent(EV_ROLETEACHCURLAYER_REFRESH,RoleTachMacro.PAGETYPE.TEACH, RoleTachMacro.TEACH.CHECK,RoleTachMacro.CHECK.Doing)
    elseif type == 1 then
        self.teachData[RoleTachMacro.TEACH.CHECK][RoleTachMacro.CHECK.Success] = data
        EventMgr:dispatchEvent(EV_ROLETEACHCURLAYER_REFRESH,RoleTachMacro.PAGETYPE.TEACH, RoleTachMacro.TEACH.CHECK,RoleTachMacro.CHECK.Success)
    elseif type == 2 then
        self.teachData[RoleTachMacro.TEACH.CHECK][RoleTachMacro.CHECK.Failed] = data
        EventMgr:dispatchEvent(EV_ROLETEACHCURLAYER_REFRESH,RoleTachMacro.PAGETYPE.TEACH, RoleTachMacro.TEACH.CHECK,RoleTachMacro.CHECK.Failed)
    end
end

function RoleTeachDataMgr:onRecSubmit(event)
    if not event.data then
        return
    end
    -- 等待审核的条目数
    local waitCheckNum = event.data.approvalNum
    EventMgr:dispatchEvent(EV_ROLETEACH_SUBNUM, waitCheckNum)
end

function RoleTeachDataMgr:onRecTeachRed(event)
    local data = event.data
    if not data then
        return
    end
    if data.type == 1 then
        self.teachRed[RoleTachMacro.TEACH.Issue] = true
    elseif data.type == 2 then
        if data.param == 1 then
            self.teachRed[RoleTachMacro.TEACH.CHECK][RoleTachMacro.CHECK.Success] = true
        end
        if data.param == 2 then
            self.teachRed[RoleTachMacro.TEACH.CHECK][RoleTachMacro.CHECK.Failed] = true
        end
    end
    EventMgr:dispatchEvent(EV_ROLETEACHRED_REFRESH)
end
----------------------------- public------------------------------

function RoleTeachDataMgr:getAchieveData()
    return self.achieveInfo
end

-- 能否调教
function RoleTeachDataMgr:canTeachRole()
    if not self.achieveInfo then
        return false
    end
    local beginTime = self.achieveInfo.sTime
    local endTime = self.achieveInfo.eTime
    local nowTime = ServerDataMgr:getServerTime()
    if not self:isHaveBoughtTeachCard() or self:roleTeachLostDays() == 0 then 
        return false
    else
        return true
    end 
end

-- 是否购买过调教卡
function RoleTeachDataMgr:isHaveBoughtTeachCard()
    if not self.achieveInfo then
        return false
    end
    if tonumber(self.achieveInfo.eTime) == 0 and tonumber(self.achieveInfo.eTime) == 0 then
        return false
    else
        return true
    end 
end

-- 调教剩余天数
function RoleTeachDataMgr:roleTeachLostDays()
    local days = 0
    if self.achieveInfo then
        local beginTime = self.achieveInfo.sTime
        local endTime = self.achieveInfo.eTime
        local nowTime = ServerDataMgr:getServerTime()
        if beginTime <= nowTime and endTime >= nowTime then
            days = math.ceil((endTime - nowTime) / 3600 /24) 
        end
    end
    return days
end

function RoleTeachDataMgr:getRankDataByTag(tag)
    return self.rankData[tag]
end

function RoleTeachDataMgr:getMyRankData(tag)
    return self.rankData.myRankData[tag]
end

function RoleTeachDataMgr:getTeachDataByTag(...)
    local tab = {...}
    local data = self.teachData
    local temp = nil
    if #tab < 0 then
        Box("No Tag!")
        return temp
    end
    for j, idx in ipairs(tab) do
        temp = data[idx]
        if nil ~= temp then
            data = temp
        else
            return temp
        end
    end
    return data
end

function RoleTeachDataMgr:getRankDataByIdx(idx)
    return self.rankData[idx]
end

-- 获取调教红点显隐
function RoleTeachDataMgr:getTeachRedShow()
    local btnTeachRedBool = false
    if self.teachRed[RoleTachMacro.TEACH.Issue] or 
    self.teachRed[RoleTachMacro.TEACH.CHECK][RoleTachMacro.CHECK.Failed] or 
    self.teachRed[RoleTachMacro.TEACH.CHECK][RoleTachMacro.CHECK.Success] then
        btnTeachRedBool = true
    end
    return self.teachRed,btnTeachRedBool
end

-- 设置取消指定调教红点显示
function RoleTeachDataMgr:setCancnelTeachRed(idx1,idx2)
    if idx1 and not idx2 then
        self.teachRed[idx1] = false
    elseif idx1 and idx2 then
        self.teachRed[idx1][idx2] = false
    end
end

-- 成就红点控制
function RoleTeachDataMgr:getRoleTeachAchieveRed()
    local taskList = TaskDataMgr:getTask(EC_TaskType.ROLE_TEACH)
    for i, v in ipairs(taskList) do
        local taskInfo = TaskDataMgr:getTaskInfo(v)
        if taskInfo and taskInfo.status == EC_TaskStatus.GET then
            return true
        end
    end
    return false
end

------------------------------- request ------------------------------------

-- 点赞、鄙视（like:类型,1 点赞 2 鄙视）0:重置
function RoleTeachDataMgr:SendIsLike(query,reply,like)
    TFDirector:send(c2s.DATING_REQ_AITRAINING_LIKE, {101,query,reply,like})
end

-- 问题池翻页 (changPageNum: 页数改变量)
function RoleTeachDataMgr:SendIssueReques(changPageNum) 
    local targetPage,lastQid
    changPageNum = changPageNum or 0
    targetPage = 1 
    local data = self.teachData[RoleTachMacro.TEACH.Issue]
    if data then
        targetPage =  tonumber(data.page)
        local issues = Json.decode(data.jsonList)
        lastQid = issues[#issues].id 
    end
    targetPage = targetPage + changPageNum
    targetPage = targetPage < 1 and 1 or targetPage
    targetPage = changPageNum == 0 and 1 or targetPage
    TFDirector:send(c2s.DATING_REQ_AITRAINING_QUESTIONS,{101,targetPage,tostring(lastQid)})
end

-- 调教提交 (fellId:好感度选项  0 通用,1 冷淡 2 友善 3 暧昧--0与其他互斥)
function RoleTeachDataMgr:SendTeachCommit(Qid,query,reply,fellIds,type)
    local tab = {101,tostring(Qid),query,reply,fellIds,tonumber(type)}
    TFDirector:send(c2s.DATING_REQ_AITRAINING_SUBMIT,tab)
end

-- 审核列表 (类型- 0 审核中 1 审核通过 2 审核失败)
function RoleTeachDataMgr:SendCheckReques(type,changPageNum)
    local targetPage,lastAid,data
    changPageNum = changPageNum or 0
    targetPage = 0
    lastAid = 0
    
    if type == 0 then
        data = self.teachData[RoleTachMacro.TEACH.CHECK][RoleTachMacro.CHECK.Doing]
    elseif type == 1 then
        data = self.teachData[RoleTachMacro.TEACH.CHECK][RoleTachMacro.CHECK.Success]
    elseif type == 2 then
        data = self.teachData[RoleTachMacro.TEACH.CHECK][RoleTachMacro.CHECK.Failed]
    end
    
    if data then
        targetPage =  tonumber(data.page)
        local list = Json.decode(data.jsonList)
        lastAid = #list == 0 and 0 or list[#list].aid 
    end
    targetPage = targetPage + changPageNum
    targetPage = targetPage < 1 and 1 or targetPage
    targetPage = changPageNum == 0 and 1 or targetPage
    TFDirector:send(c2s.DATING_REQ_AITRAINING_AUDIT,{101,type,targetPage,tostring(lastAid)})
end

-- 排行请求
function RoleTeachDataMgr:SendRankRequest(tag)
    TFDirector:send(c2s.DATING_REQ_AITRAINING_RANK,{101,tag})
end

-- 调教基础信息
function RoleTeachDataMgr:SendTeachInfoRequest()
    TFDirector:send(c2s.DATING_REQ_AITRAINING_INFO, {101})
end

return RoleTeachDataMgr:new()