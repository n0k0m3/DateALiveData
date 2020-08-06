
local BaseDataMgr = import(".BaseDataMgr")
local CityJobDataMgr = class("CityJobDataMgr", BaseDataMgr)

function CityJobDataMgr:init()
    TFDirector:addProto(s2c.NEW_BUILDING_RESP_PART_TIME_JOB_LIST, self, self.onRecvPartTimeJobList)
    TFDirector:addProto(s2c.NEW_BUILDING_RESP_DO_PART_TIME_JOB, self, self.onRecvDoPartTimeJob)
    TFDirector:addProto(s2c.NEW_BUILDING_RESP_PART_TIME_JOB_AWARD, self, self.onRecvPartTimeJobAward)
    TFDirector:addProto(s2c.NEW_BUILDING_RESP_GIVE_UP_JOB, self, self.onRecvGiveUpJob)

    self.cityJobData_ = {}  --兼职数据
    self.cityJobEvent = nil --正在做的兼职
    self.selectBuildIndex_ = 1


    -- 本地配置数据
    self.cityJobConfigMap_ = TabDataMgr:getData("CityJob")
    self.newBuildConfigMap_ = TabDataMgr:getData("NewBuild")
end

function CityJobDataMgr:reset()
   self.cityJobData_ = {}
   self.cityJobEvent = nil
end

function CityJobDataMgr:onLogin()
    TFDirector:send(c2s.NEW_BUILDING_REQ_PART_TIME_JOB_LIST, {})
    return {
        s2c.NEW_BUILDING_RESP_PART_TIME_JOB_LIST
    }
end

function CityJobDataMgr:onLoginOut()
    self:reset();
end

--获取兼职数据
function CityJobDataMgr:sendReqPartTimeJobList()
    TFDirector:send(c2s.NEW_BUILDING_REQ_PART_TIME_JOB_LIST, {})
end

--开始兼职
function CityJobDataMgr:sendReqDoPartTimeJob(buildingId, jobId)
    TFDirector:send(c2s.NEW_BUILDING_REQ_DO_PART_TIME_JOB, {buildingId, jobId})
end

--领取兼职奖励
function CityJobDataMgr:sendReqPartTimeJobAward(buildingId, jobId)
    TFDirector:send(c2s.NEW_BUILDING_REQ_PART_TIME_JOB_AWARD, {buildingId, jobId})
end

--放弃当前兼职
function CityJobDataMgr:sendReqGiveUpJob(buildingId, jobId)
    TFDirector:send(c2s.NEW_BUILDING_REQ_GIVE_UP_JOB, {buildingId, jobId})
end

function CityJobDataMgr:getCityJobData()
    return self.cityJobData_
end

--获得单个建筑兼职数据
function CityJobDataMgr:getJobInfoListByBuildId(buildingId)
    for i,v in ipairs(self.cityJobData_) do
        if tonumber(v.buildingId) == tonumber(buildingId) then
            return v
        end
    end
    return nil
end

function CityJobDataMgr:sortCityJobData()
    table.sort(self.cityJobData_, function(a, b)
        return a.buildingId < b.buildingId
    end)
    if self.cityJobEvent then
        local jobList = nil
        for i,v in ipairs(self.cityJobData_) do
            if v.buildingId == self.cityJobEvent.buildingId then
                jobList = table.remove(self.cityJobData_, i)
                break
            end
        end
        if jobList then
            table.insert(self.cityJobData_, 1, jobList)
            self:updateBuildingSelectIdx(1)
        end
    end
    EventMgr:dispatchEvent(EV_DATING_EVENT.roomFuncRedPoint)
    EventMgr:dispatchEvent(EV_DATING_EVENT.refreshRedTips)
end

function CityJobDataMgr:checkJobEventDown()
    if self.cityJobEvent and self:getJobEventSuplTime() <= 0 then
        return true
    end
    return false
end

function CityJobDataMgr:buildingJobDown(buildingId)
    if self:checkJobEventDown() and self.cityJobEvent.buildingId == buildingId then
        return true
    end
    return false
end

--兼职任务列表接收
function CityJobDataMgr:onRecvPartTimeJobList(event)
    local data = event.data
    self.cityJobEvent = data.jobEvent
    self.cityJobData_ = {}
    if data.jobLists then
        local jobData = {}
        for k,v in pairs(data.jobLists) do
            local jobInfoList = {}
            jobInfoList.buildingId = v.buildingId
            jobInfoList.jobInfos = v.jobInfos
            jobInfoList.level = v.level
            jobInfoList.exp = v.exp
            self:sortJobInfoList(jobInfoList)
            table.insert(jobData, jobInfoList)
        end
        self.cityJobData_ = jobData
        self:sortCityJobData()
    end
    if self.cityJobEvent then
        for i,v in ipairs(self.cityJobData_) do
            if v.buildingId == self.cityJobEvent.buildingId then
                self:updateBuildingSelectIdx(i)
            end
        end
    end
    EventMgr:dispatchEvent(EV_CITY_PART_TIME_JOB_LIST, {})
end

function CityJobDataMgr:sortJobInfoList(jobInfoList)
    local dayType = NewCityDataMgr:getCitydata().dayType
    table.sort(jobInfoList.jobInfos, function(a, b)
        if a.jobType == b.jobType then
            if a.type == b.type then
                return a.jobId < b.jobId
            else
                return a.type == dayType
            end
        end
        return a.jobType < b.jobType
    end)
end

--兼职任务接收
function CityJobDataMgr:onRecvDoPartTimeJob(event)
    local jobInfos = event.data
    self.cityJobEvent = jobInfos.jobInfo
    local jobInfoList = self:updateCityJobInfo(self.cityJobEvent)
    self:sortCityJobData()
    EventMgr:dispatchEvent(EV_CITY_DO_PART_TIME_JOB, {})
end

--兼职任务奖励接收
function CityJobDataMgr:onRecvPartTimeJobAward(event)
    local data = event.data
    self:updateJobList(data.jobList)
    self.cityJobEvent.rewards = data.rewards
    self.cityJobEvent.extraRewards = data.extraRewards
    self.cityJobEvent.addExp = data.addExp
    self:sortCityJobData()
    EventMgr:dispatchEvent(EV_CITY_PART_TIME_JOB_AWARD, {})
end

--放弃兼职接收
function CityJobDataMgr:onRecvGiveUpJob(event)
    local data = event.data
    local buildingId = self.cityJobEvent.buildingId
    self.cityJobEvent = data.jobEvent
    self:updateJobList(data.jobList)
    self:sortCityJobData()
    for i,v in ipairs(self.cityJobData_) do
        if tonumber(v.buildingId) == tonumber(buildingId) then
            self:updateBuildingSelectIdx(i)
            break
        end
    end
    EventMgr:dispatchEvent(EV_CITY_GIVE_UP_JOB, {})
end

function CityJobDataMgr:updateJobList(jobList)
    for i,v in ipairs(self.cityJobData_) do
        if tonumber(v.buildingId) == tonumber(jobList.buildingId) then
            table.remove(self.cityJobData_, i)
            break
        end
    end
    local newJobList = clone(jobList)
    self:sortJobInfoList(newJobList)
    table.insert(self.cityJobData_, newJobList)
end

--更新单个兼职数据
function CityJobDataMgr:updateCityJobInfo(jobInfo)
    local jobInfoList = self:getJobInfoListByBuildId(jobInfo.buildingId)
    if not jobInfoList then
        jobInfoList = {}
        jobInfoList.buildingId = jobInfo.buildingId
        jobInfoList.jobInfos = {jobInfo}
        table.insert(self.cityJobData_, jobInfoList)
    else
        for i,v in ipairs(jobInfoList.jobInfos) do
            if v.jobId == jobInfo.jobId then
                table.remove(jobInfoList.jobInfos, i)
                table.insert(jobInfoList.jobInfos, jobInfo)
                break
            end
        end
    end
    self:sortJobInfoList(jobInfoList)
    return jobInfoList
end

--没有兼职数据
function CityJobDataMgr:dontHaveAnyJobData()
    return table.count(self.cityJobData_) < 1
end

--判断兼职是否在可做时间范围内（白天或晚上）
function CityJobDataMgr:checkJobEnableInTime(jobInfo)
    local dayType = NewCityDataMgr:getCitydata().dayType
    if jobInfo.type == dayType then
        return true
    end
    return true
end

function CityJobDataMgr:resetWorkingJobInfo()
    self.cityJobEvent = nil
    EventMgr:dispatchEvent(EV_DATING_EVENT.roomFuncRedPoint)
    EventMgr:dispatchEvent(EV_DATING_EVENT.refreshRedTips)
end

function CityJobDataMgr:getWorkingJobInfo()
    return self.cityJobEvent
end

--当前兼职剩余时间
function CityJobDataMgr:getJobEventSuplTime()
    if self.cityJobEvent and self.cityJobEvent.etime then
        return self.cityJobEvent.etime - ServerDataMgr:getServerTime()
    end
    return 0
end

function CityJobDataMgr:getJobInfoListByBuildingId(buildingId)
    for k,v in pairs(self.cityJobData_) do
        if tonumber(v.buildingId) == tonumber(buildingId) then
            return v
        end
    end
    return nil
end

function CityJobDataMgr:getJobInfoListByIdx(idx)
    return self.cityJobData_[idx]
end

local builingIcon = {
    [102] = {normal = "ui/newCity/city_job/027.png", selected = "ui/newCity/city_job/017.png"},
    [103] = {normal = "ui/newCity/city_job/028.png", selected = "ui/newCity/city_job/018.png"},
    [104] = {normal = "ui/newCity/city_job/023.png", selected = "ui/newCity/city_job/013.png"},
    [105] = {normal = "ui/newCity/city_job/025.png", selected = "ui/newCity/city_job/015.png"},
    [106] = {normal = "ui/newCity/city_job/024.png", selected = "ui/newCity/city_job/014.png"},
    [107] = {normal = "ui/newCity/city_job/025.png", selected = "ui/newCity/city_job/015.png"},
}
function CityJobDataMgr:getBuildIconByIdAndState(buildingId, state)
    if state then
        return builingIcon[buildingId].selected
    else
        return builingIcon[buildingId].normal
    end
end

function CityJobDataMgr:getCityJobCfgById(jobId)
    return self.cityJobConfigMap_[jobId]
end

function CityJobDataMgr:getBuildCfgByBuildingId(buildingId)
    return self.newBuildConfigMap_[buildingId]
end

function CityJobDataMgr:getBuildCfgByIdx(idx)
    if self.cityJobData_[idx] then
        return self:getBuildCfgByBuildingId(self.cityJobData_[idx].buildingId)
    end
    return nil
end

function CityJobDataMgr:getBuildingSelectedIndex()
    return self.selectBuildIndex_
end

function CityJobDataMgr:updateBuildingSelectIdx(idx)
    self.selectBuildIndex_ = idx
end


function CityJobDataMgr:getJobSelectedIndex()
    if not self.cityJobEvent then
        for i,v in ipairs(self.cityJobData_) do
            if i == self.selectBuildIndex_ then
                for j,job in ipairs(v.jobInfos) do
                    if job.jobType == 1 and self:checkJobEnableInTime(job) then
                        return j
                    end
                end
            end
        end
    end
    return 1
end

function CityJobDataMgr:checkItemEnableShow(id)
    if id < EC_SItemType.ZHUANZHU or id > EC_SItemType.XINGYUN then 
        return true
    end
    return false
end


return CityJobDataMgr:new()
