local CityJobView = class("CityJobView",BaseLayer)

function CityJobView:initData(data)
    self.cityJobData_ = {}
    self.workingJobInfo = nil
    self.passTime = 0

    self.accelerateData = TabDataMgr:getData("DiscreteData",1100011).data
    
    self.selectBuildIndex_ = CityJobDataMgr:getBuildingSelectedIndex()
    self.selectJobIndex_ = CityJobDataMgr:getJobSelectedIndex()

    CityJobDataMgr:sendReqPartTimeJobList()
end

function CityJobView:ctor(data)
    self.super.ctor(self,data)

    self:initData()

    self:init("lua.uiconfig.dating.cityJobView")
end

function CityJobView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui
    self:addLockLayer()

    self.Image_bg = TFDirector:getChildByPath(self.ui,"Image_bg")
    self.Label_no_work_place = TFDirector:getChildByPath(self.ui,"Label_no_work_place"):hide()
    self.Panel_prefab = TFDirector:getChildByPath(self.ui,"Panel_prefab")

    self:initBuildPanelScroll()
    self:initJobPanel()
    self:initRewardPanel()

    self:setBackBtnCallback(function()
         AlertManager:closeLayer(self)
    end)
end

--领取奖励成功
function CityJobView:onGetJobReward()
    local view = requireNew("lua.logic.city.GetJobRewardView"):new(clone(CityJobDataMgr:getWorkingJobInfo()))
    AlertManager:addLayer(view,AlertManager.BLOCK_AND_GRAY_CLOSE)
    AlertManager:show()
    self.workingJobInfo = nil
    CityJobDataMgr:resetWorkingJobInfo()
    self:onReloadJobUI()
end

--刷新数据源
function CityJobView:onRefreshJobData()
    self.cityJobData_ = CityJobDataMgr:getCityJobData()
    self.workingJobInfo = CityJobDataMgr:getWorkingJobInfo()
    self.selectBuildIndex_ = CityJobDataMgr:getBuildingSelectedIndex()
    self.selectJobIndex_ = CityJobDataMgr:getJobSelectedIndex()
end

function CityJobView:onReloadJobUI()
    self:onRefreshJobData()
    self:loadBuildScroll()
    self:loadJobPanel()
    self:refreshRewardPanel()
    self:refreshJobBtnState()
    self:updatePanelAccelerate()
    if CityJobDataMgr:dontHaveAnyJobData() then
        self.Panel_reward_info:hide()
        self.Label_no_work_place:show()
        self.Label_no_jobs:show()
        self.Panel_job_event:hide()
        self.Button_start_job:hide()
    else
        self.Panel_reward_info:show()
        self.Label_no_work_place:hide()
        if table.count(CityJobDataMgr:getJobInfoListByIdx(self.selectBuildIndex_).jobInfos) < 1 and not self.workingJobInfo then
            self.Label_no_jobs:show()
            self.Panel_job_event:hide()
            self.Button_start_job:hide()
        else
            self.Label_no_jobs:hide()
        end
    end
end

function CityJobView:onGiveUpJobSuccess()
    CCUserDefault:sharedUserDefault():setIntegerForKey("give_up_city_job_time", ServerDataMgr:getServerTime())
    self:onRefreshJobUI()
end

function CityJobView:onRecvAccelerateInfo()
    self:updatePanelAccelerate()
end

function CityJobView:onRefreshJobUI()
    self:onReloadJobUI()
end

function CityJobView:initRewardPanel()
    self.Panel_reward_info = TFDirector:getChildByPath(self.ui,"Panel_reward_info")
    self.Panel_attr_info = TFDirector:getChildByPath(self.Panel_reward_info,"Panel_attr_info")
    self.Image_attr_icon = TFDirector:getChildByPath(self.Panel_attr_info,"Image_attr_icon")
    self.Panel_mod_reward = TFDirector:getChildByPath(self.Panel_reward_info,"Panel_mod_reward")
    self.Panel_extra_reward = TFDirector:getChildByPath(self.Panel_reward_info,"Panel_extra_reward")

    self.Label_build_name = TFDirector:getChildByPath(self.Panel_reward_info,"Label_build_name")
    self.Label_job_level = TFDirector:getChildByPath(self.Panel_reward_info,"Label_job_level")
    self.LoadingBar_lv = TFDirector:getChildByPath(self.Panel_reward_info,"LoadingBar_lv")
    self.Label_curExp = TFDirector:getChildByPath(self.Panel_reward_info,"Label_curExp")

    self.ScrollView_mod = UIGridView:create(TFDirector:getChildByPath(self.Panel_mod_reward,"ScrollView_mod"))
    self.ScrollView_extra = UIGridView:create(TFDirector:getChildByPath(self.Panel_extra_reward,"ScrollView_extra"))
    self.Panel_goodsItem_prefab = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    self.Panel_goodsItem_prefab:setScale(0.8)
    self.ScrollView_mod:setColumn(3)
    self.ScrollView_mod:setItemModel(self.Panel_goodsItem_prefab)

    self.ScrollView_extra:setColumn(2)
    self.ScrollView_extra:setItemModel(self.Panel_goodsItem_prefab)

    TFDirector:getChildByPath(self.Panel_mod_reward,"Label_modTitle"):setTextById(2400008)
    TFDirector:getChildByPath(self.Panel_extra_reward,"Label_extraTitle"):setTextById(2400009)
    TFDirector:getChildByPath(self.Panel_attr_info,"Label_attr5"):setTextById(900744)
    TFDirector:getChildByPath(self.Panel_attr_info,"Label_attr4"):setTextById(900746)
    TFDirector:getChildByPath(self.Panel_attr_info,"Label_attr2"):setTextById(900747)
    TFDirector:getChildByPath(self.Panel_attr_info,"Label_attr3"):setTextById(900748)
    TFDirector:getChildByPath(self.Panel_attr_info,"Label_attr1"):setTextById(900745)

end

function CityJobView:refreshRewardPanel()
    local jobInfo = self.workingJobInfo or self:getJobInfoByIndex(self.selectJobIndex_)
    if not jobInfo then
        return
    end
    local jobCfg = CityJobDataMgr:getCityJobCfgById(jobInfo.jobId)
    local buildCfg = CityJobDataMgr:getBuildCfgByBuildingId(jobInfo.buildingId)

    local jobInfoList = CityJobDataMgr:getJobInfoListByBuildingId(jobInfo.buildingId)
    self.Label_build_name:setTextById(buildCfg.nameId)
    if table.count(buildCfg.jobLevels) > 0 and jobInfoList.level > table.count(buildCfg.jobLevels) then
        self.Label_job_level:setTextById(2400002, jobInfoList.level)
        self.Label_curExp:setText("Max")
        self.LoadingBar_lv:setPercent(100)
    else
        local level = math.min(jobInfoList.level, table.count(buildCfg.jobLevels))
        self.Label_job_level:setTextById(2400002, jobInfoList.level)
        self.Label_curExp:setTextById("r90003",jobInfoList.exp, " (+"..jobCfg.jobExp..")", "/"..buildCfg.jobLevels[level])
        local percent = jobInfoList.exp / buildCfg.jobLevels[level] * 100
        self.LoadingBar_lv:setPercent(percent)
    end
    local resultShow3 = jobCfg.resultShow3

    local attrs = {EC_SItemType.MEILI, EC_SItemType.ZHISHI, EC_SItemType.XINGYUN, EC_SItemType.WENROU, EC_SItemType.ZHUANZHU}
    local maxValue = 0
    local valueArray = {0,0,0,0,0}
    for i,v in ipairs(attrs) do
        local str = "Label_attr_value"..i
        local valueLabel = TFDirector:getChildByPath(self.Panel_attr_info,str)
        local itemCfg = GoodsDataMgr:getItemCfg(v) or nil
        local count = GoodsDataMgr:getItemCount(v) or 0
        if resultShow3[v] then
            local addValue = resultShow3[v]
            if itemCfg and count >= itemCfg.totalMax then
                addValue = 0
            end
            valueLabel:setText(tostring(count).."(+"..addValue..")")
        else
            valueLabel:setText(tostring(count).."(+0)")
        end
        maxValue = math.max(maxValue, itemCfg.totalMax)
        valueArray[i] = count
    end

    self:drawAttrPolygon(maxValue, valueArray)

    local mod_reward = clone(jobInfo.rewards)
    if not mod_reward then
        mod_reward = {}
        for k,v in pairs(jobCfg.resultShow1) do
            local item = {}
            item.id = tonumber(k)
            item.num = v
            table.insert(mod_reward,item)
        end
    end
    local extraRewards = {}
    if jobInfo.jobType == 3 then
        for i,v in ipairs(mod_reward) do
            for i,id in ipairs(jobCfg.resultShow2) do
                if v.id == id then
                    table.remove(mod_reward, i)
                    extraRewards[#extraRewards + 1] = v
                end
            end
        end
    end

    self.ScrollView_mod:removeAllItems()
    for i, v in ipairs(mod_reward) do
        if CityJobDataMgr:checkItemEnableShow(v.id) then
            local itemReward = self.Panel_goodsItem_prefab:clone()
            PrefabDataMgr:setInfo(itemReward, v.id, v.num)
            self.ScrollView_mod:pushBackCustomItem(itemReward)
        end
    end

    local extra_reward = {}
    if jobInfo.jobType == 3 then
        extra_reward = jobInfo.extraRewards or extraRewards
    else
        for k,v in pairs(jobCfg.resultShow2) do
            extra_reward[#extra_reward + 1] = {id = v, num = 1}
        end
    end
    self.ScrollView_extra:removeAllItems()
    for i, v in ipairs(extra_reward) do
        if CityJobDataMgr:checkItemEnableShow(v.id) then
            local itemReward = self.Panel_goodsItem_prefab:clone()
            PrefabDataMgr:setInfo(itemReward, v.id, v.num)
            if jobInfo.jobType ~= 3 then
                TFDirector:getChildByPath(itemReward, "Label_count"):hide()
            end
            self.ScrollView_extra:pushBackCustomItem(itemReward)
        end
    end
end

function CityJobView:drawAttrPolygon(maxValue, valueArray)
    self.Image_attr_icon:removeAllChildren()
    local PI = 3.1415926
    local polygonMax = 70.5
    local solidMax = 70
    local percents = {0, 0, 0, 0, 0}
    local baseMax = maxValue
    local baseValue = baseMax / 5
    for i,v in ipairs(valueArray) do
        percents[i] = math.min(1, (v + baseValue) / baseMax)
    end
    local points = {
    ccp(0, polygonMax * percents[1]),
    ccp(-polygonMax * math.cos(1 / 10 * PI) * percents[2], polygonMax * math.sin(1 / 10 * PI) * percents[2]),
    ccp(-polygonMax * math.sin(1 / 5 * PI) * percents[3], -polygonMax * math.cos(1 / 5 * PI) * percents[3]),
    ccp(polygonMax * math.sin(1 / 5 * PI) * percents[4], -polygonMax * math.cos(1 / 5 * PI) * percents[4]), 
    ccp(polygonMax * math.cos(1 / 10 * PI) * percents[5], polygonMax * math.sin(1 / 10 * PI) * percents[5]),
    }
    local pointsSolid = {
    ccp(0, solidMax * percents[1]),
    ccp(-solidMax * math.cos(1 / 10 * PI) * percents[2], solidMax * math.sin(1 / 10 * PI) * percents[2]),
    ccp(-solidMax * math.sin(1 / 5 * PI) * percents[3], -solidMax * math.cos(1 / 5 * PI) * percents[3]),
    ccp(solidMax * math.sin(1 / 5 * PI) * percents[4], -solidMax * math.cos(1 / 5 * PI) * percents[4]), 
    ccp(solidMax * math.cos(1 / 10 * PI) * percents[5], solidMax * math.sin(1 / 10 * PI) * percents[5]),
    }
    
    local attrNodeSide = TFDrawNode:create()
    self.Image_attr_icon:addChild(attrNodeSide, 100)
    attrNodeSide:drawPoly(points, true, ccc4(1, 1, 1, 0.5))
    attrNodeSide:setPosition(ccp(0, -6))

    local attrNode = TFDrawNode:create()
    self.Image_attr_icon:addChild(attrNode, 100)
    attrNode:drawSolidPoly(pointsSolid, ccc4(227 / 255, 115 / 255, 147 / 255, 1))
    attrNode:setPosition(ccp(0, -6))
end

function CityJobView:initBuildPanelScroll()
    self.Panel_scroll = TFDirector:getChildByPath(self.ui,"Panel_scroll")
    local ScrollView_build = TFDirector:getChildByPath(self.Panel_scroll,"ScrollView_build")
    self.buildScroll = UIListView:create(ScrollView_build)
    self.buildScroll:setItemsMargin(5)
    self.Panel_buildItem = TFDirector:getChildByPath(self.Panel_prefab,"Panel_buildItem")

    self:loadBuildScroll()
end

function CityJobView:loadBuildScroll()
    self.buildScroll:removeAllItems()
    for i,v in ipairs(CityJobDataMgr:getCityJobData()) do
        local buildItem = self.Panel_buildItem:clone()
        self:updateBuildItem(buildItem,i)
        self.buildScroll:pushBackCustomItem(buildItem)
        buildItem:Touchable(true)
        buildItem:onClick(function()
            self:selectBuild(i)
            end)
    end
end

function CityJobView:refreshBuildScroll()
    for i,v in ipairs(self.buildScroll:getItems()) do
        self:updateBuildItem(v,i)
    end
end

function CityJobView:updateBuildItem(buildItem,idx)
    local buildCfg = CityJobDataMgr:getBuildCfgByIdx(idx)
    local jobInfoList = CityJobDataMgr:getJobInfoListByIdx(idx)
    local Image_bg = TFDirector:getChildByPath(buildItem,"Image_bg")
    local LoadingBar_job = TFDirector:getChildByPath(buildItem,"LoadingBar_job")
    local Label_percent = TFDirector:getChildByPath(buildItem,"Label_percent"):hide()
    local Image_build = TFDirector:getChildByPath(buildItem,"Image_build")
    local Label_name = TFDirector:getChildByPath(buildItem,"Label_name")
    local Image_lock = TFDirector:getChildByPath(buildItem,"Image_lock")

    Label_name:setTextById(buildCfg.nameId)
    if self.workingJobInfo and self.selectBuildIndex_ == idx then
        local supTime = CityJobDataMgr:getJobEventSuplTime()
        if supTime <= 0 then
            Image_bg:setTexture("ui/newCity/city_job/021.png")
            LoadingBar_job:setTexture("ui/newCity/city_job/022.png")
            Image_build:setTexture(CityJobDataMgr:getBuildIconByIdAndState(jobInfoList.buildingId, true))
            Label_percent:setText("100%")
            Label_percent:setColor(ccc3(48, 53, 74))
            LoadingBar_job:setPercent(100)
        else
            Image_bg:setTexture("ui/newCity/city_job/008.png")
            LoadingBar_job:setTexture("ui/newCity/city_job/020.png")
            Image_build:setTexture(CityJobDataMgr:getBuildIconByIdAndState(jobInfoList.buildingId, false))
            local jobCfg = CityJobDataMgr:getCityJobCfgById(self.workingJobInfo.jobId)
            local percent = math.max((1 - (supTime / jobCfg.costTime)) * 100, 1)
            percent = math.min(percent, 100)
            Label_percent:setText(tostring(math.floor(percent)).."%")
            Label_percent:setColor(ccc3(255, 255, 255))
            LoadingBar_job:setPercent(percent)
        end
    else
        if self.selectBuildIndex_ == idx then
            Image_build:setTexture(CityJobDataMgr:getBuildIconByIdAndState(jobInfoList.buildingId, true))
            Image_bg:setTexture("ui/newCity/city_job/021.png")
        else
            Image_build:setTexture(CityJobDataMgr:getBuildIconByIdAndState(jobInfoList.buildingId, false))
            Image_bg:setTexture("ui/newCity/city_job/008.png")
        end
        LoadingBar_job:setTexture("ui/newCity/city_job/020.png")
        Label_percent:setTextById(2400021)
        LoadingBar_job:setPercent(0)
        Label_percent:setColor(ccc3(255, 255, 255))
    end
end

function CityJobView:selectBuild(idx)
    if self.selectBuildIndex_ == idx then
        return
    end
    if self.workingJobInfo  then
        if self.workingJobInfo.jobType == 2 and CityJobDataMgr:getJobEventSuplTime() > 0 then   --正在xx兼职
            local buildCfg = CityJobDataMgr:getBuildCfgByBuildingId(self.workingJobInfo.buildingId)
            Utils:showTips(TextDataMgr:getText(2400017, TextDataMgr:getText(buildCfg.nameId)))
        else
            Utils:showTips(2400018) --奖励未领取
        end
        return
    end
    
    CityJobDataMgr:updateBuildingSelectIdx(idx)
    self.selectBuildIndex_ = idx
    self:refreshBuildScroll()
    self.selectJobIndex_ = 1
    self:refreshJobPanel()
    self:refreshRewardPanel()
    self:refreshJobBtnState()
end

function CityJobView:initJobPanel()
    self.Panel_job = TFDirector:getChildByPath(self.ui,"Panel_job")
    self.Label_no_jobs = TFDirector:getChildByPath(self.Panel_job,"Label_no_jobs"):hide()
    self.Button_start_job = TFDirector:getChildByPath(self.Panel_job,"Button_start_job")
    self.Panel_job_event = TFDirector:getChildByPath(self.Panel_job,"Panel_job_event"):hide()
    self.Label_working = TFDirector:getChildByPath(self.Panel_job_event,"Label_working")
    self.Image_line = TFDirector:getChildByPath(self.Panel_job_event,"Image_line")
    self.Label_over_time = TFDirector:getChildByPath(self.Panel_job_event,"Label_over_time")
    self.Panel_working = TFDirector:getChildByPath(self.Panel_job_event,"Panel_working")
    self.Image_event_bg = TFDirector:getChildByPath(self.Panel_job_event,"Image_event_bg")
    self.Label_job_down = TFDirector:getChildByPath(self.Panel_job_event,"Label_job_down")
    self.Image_down_icon = TFDirector:getChildByPath(self.Panel_job_event,"Image_down_icon")
    self.Panel_job_title = TFDirector:getChildByPath(self.Panel_job,"Panel_job_title")

    local job_list = TFDirector:getChildByPath(self.Panel_job,"ScrollView_job_list")

    TFDirector:getChildByPath(self.Button_start_job,"Label_start_job"):setTextById(2400010)

    self.scrollViewJob = UIListView:create(job_list)
    self.Panel_jobItem = TFDirector:getChildByPath(self.Panel_prefab,"Panel_jobItem")
    self.Button_start_job:onClick(handler(self.onJobStateBtnClick,self))

    self.Panel_accelerate = TFDirector:getChildByPath(self.Panel_job , "Panel_accelerate")
    local Label_desc = TFDirector:getChildByPath(self.Panel_accelerate , "Label_desc")
    Label_desc:setTextById(190000187 ,self.accelerateData.time/60)
    self.Button_accelerate = TFDirector:getChildByPath(self.Panel_accelerate , "Button_accelerate")
    self.Button_accelerate:onClick(handler(self.onJobAccelerateClick,self))

    self:loadJobPanel()
    self:refreshJobBtnState()
end

function CityJobView:updatePanelAccelerate()
    local Label_accelerate_limit = TFDirector:getChildByPath(self.Panel_accelerate , "Label_accelerate_limit")
    local acclereteMax =  CityJobDataMgr:getPrivilegeFreeWrokAccelerateNum() + self.accelerateData.max
    local lastDaySpeedNum = self.accelerateData.max - CityJobDataMgr:getWorlAccelerateData().speedNum
    local lastFreeSpeedNum = CityJobDataMgr:getPrivilegeFreeWrokAccelerateNum() - CityJobDataMgr:getWorlAccelerateData().freeSpeedNum
    if lastFreeSpeedNum < 0 then 
        lastFreeSpeedNum = 0 
    end
    Label_accelerate_limit:setTextById(270609 , lastDaySpeedNum + lastFreeSpeedNum ,acclereteMax)


    local Image_accele_icon = TFDirector:getChildByPath(self.Panel_accelerate , "Image_accele_icon")
    local Label_accele_num = TFDirector:getChildByPath(self.Panel_accelerate , "Label_accele_num")

    local Label_accelerate_free = TFDirector:getChildByPath(self.Button_accelerate , "Label_accelerate_free")

    Image_accele_icon:show()
    Label_accele_num:show()

    self.accelerateCost = 0
    self.costId = 0
    Label_accelerate_free:setTextById(11311043)
    if lastDaySpeedNum >0 or lastFreeSpeedNum > 0 then  --可加速
        self.Button_accelerate:setTouchEnabled(true)
        self.Button_accelerate:setGrayEnabled(false)
        if lastFreeSpeedNum > 0 then
            Image_accele_icon:hide()
            Label_accele_num:hide()
            Label_accelerate_free:setText(TextDataMgr:getText(2106010).." "..TextDataMgr:getText(11311043))
        else
            local costIdx = self.accelerateData.max - lastDaySpeedNum + 1
            local costData = self.accelerateData.useItem[costIdx]
            for k ,v in pairs(costData) do
                Image_accele_icon:setTexture(GoodsDataMgr:getItemCfg(k).icon)
                Label_accele_num:setTextById(302201 , v)
                self.accelerateCost = v
                self.costId = k
                local ownNum = GoodsDataMgr:getItemCount(self.costId)
                if ownNum >= v then
                    Label_accele_num:setFontColor(ccc3(255 , 255 , 255))
                else
                    Label_accele_num:setFontColor(ccc3(255 , 0 , 0))
                end
            end
        end
    else
        self.Button_accelerate:setTouchEnabled(false)
        self.Button_accelerate:setGrayEnabled(true)
        Image_accele_icon:hide()
        Label_accele_num:hide()
    end
    
end

function CityJobView:onJobStateBtnClick(btn)
    if self.workingJobInfo then
        if CityJobDataMgr:getJobEventSuplTime() <= 0 then
            CityJobDataMgr:sendReqPartTimeJobAward(self.workingJobInfo.buildingId, self.workingJobInfo.jobId)
        else
            local lastTime = CCUserDefault:sharedUserDefault():getIntegerForKey("give_up_city_job_time")
            if ServerDataMgr:getServerTime() - lastTime < 30 then   --两次放弃兼职间隔最少30秒
                Utils:showTips(2400020)
                return
            end
            local function reaGiveUp()
                CityJobDataMgr:sendReqGiveUpJob(self.workingJobInfo.buildingId, self.workingJobInfo.jobId)
            end
            Utils:openView("common.ReConfirmTipsView", {tittle = 2400019, content = TextDataMgr:getText(2400016), reType = EC_BuildWorkLogTipsType.ReConfirm_GiveUpJob, confirmCall = reaGiveUp})
        end
    else
        local jobInfo = self:getJobInfoByIndex(self.selectJobIndex_) 
        if not jobInfo then
            return
        end
        if jobInfo.jobType ~= 3 then
            local jobCfg = CityJobDataMgr:getCityJobCfgById(jobInfo.jobId)
            local energy = GoodsDataMgr:getItemCount(EC_SItemType.ENERGY)
            local cost = 0
            for k,v in pairs(jobCfg.costVim) do
                cost = tonumber(v)
            end
            if energy >= cost then
                CityJobDataMgr:sendReqDoPartTimeJob(jobInfo.buildingId, jobInfo.jobId)
                GameGuide:checkGuideEnd(self.guideFuncId)
            else
                --tips short energy
                Utils:showTips(206035)
            end
        end
    end
end

--兼职加速按钮响应
function CityJobView:onJobAccelerateClick()
    if self.accelerateCost == 0 then  --如果是免费的
         CityJobDataMgr:sendWorkAccelerate()
    else
        local ownNum = GoodsDataMgr:getItemCount(self.costId)
        if ownNum >= self.accelerateCost then
            CityJobDataMgr:sendWorkAccelerate()
        else
            Utils:showTips(204002)
        end
    end
end

--刷新按钮状态
function CityJobView:refreshJobBtnState()

    self.Panel_accelerate:hide()  --加速面板显示 只有开始兼职后且未完成前显示
    if self:checkBtnEnableShow() then
        self.Button_start_job:show()
    else
        self.Button_start_job:hide()
    end 
    if self.workingJobInfo then
        if CityJobDataMgr:getJobEventSuplTime() > 0 then
            TFDirector:getChildByPath(self.Button_start_job,"Label_start_job"):setTextById(2400012)
            self.Panel_accelerate:show()
        else
            TFDirector:getChildByPath(self.Button_start_job,"Label_start_job"):setTextById(2400013)
        end
    else
        TFDirector:getChildByPath(self.Button_start_job,"Label_start_job"):setTextById(2400010)
    end

    --GoodsDataMgr:getItemCfg(firstCostId).icon
end

function CityJobView:checkBtnEnableShow()
    if CityJobDataMgr:dontHaveAnyJobData() then
        return false
    end
    if self.workingJobInfo then
        return true
    end

    local jobInfo = self:getJobInfoByIndex(self.selectJobIndex_)
    if jobInfo.jobType == 3 or not CityJobDataMgr:checkJobEnableInTime(jobInfo) then
        return false
    end

    return true
end

function CityJobView:loadJobPanel()
    self.scrollViewJob:removeAllItems()
    self.selectJobItem = nil
    if CityJobDataMgr:dontHaveAnyJobData() then
        return
    end
    if self.workingJobInfo then
        self.Panel_job_event:show()
        self:refreshJobEvent()
        self.Panel_job_title:hide()
        return
    end
    self.Panel_job_event:hide()
    self.Panel_job_title:show()
    local jobInfoList = CityJobDataMgr:getJobInfoListByIdx(self.selectBuildIndex_)
    local jobInfos = jobInfoList and jobInfoList.jobInfos or {}
    for i,v in ipairs(jobInfos) do
        local jobItem = self.Panel_jobItem:clone()
        self:updateJobItem(jobItem,i)
        self.scrollViewJob:pushBackCustomItem(jobItem)
        jobItem:Touchable(true)
        jobItem:onClick(function()
            self:selectJob(jobItem, i)
            end)
        if self.selectJobIndex_ == i then
            self.selectJobItem = jobItem
        end
    end
end

--刷新正在兼职面板
function CityJobView:refreshJobEvent()
    if CityJobDataMgr:getJobEventSuplTime() > 0 then
        self.Image_down_icon:hide()
        self.Image_event_bg:show()
        self.Label_working:show()
        self.Image_line:setTexture("ui/newCity/city_job/010.png")
        self.Panel_working:show()
        self.Label_job_down:hide()
        self:updateCountDonw()
        self:addCountDownTimer()
    else
        self.Image_down_icon:show()
        self.Image_event_bg:hide()
        self.Label_working:hide()
        self.Image_line:setTexture("ui/newCity/city_job/012.png")
        self.Panel_working:hide()
        self.Label_job_down:show()
        self:removeCountDownTimer()
        self:refreshJobBtnState()
    end
end

function CityJobView:removeEvents()
    self:removeCountDownTimer()
end

function CityJobView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.updateCountDonw, self))
    end
end

function CityJobView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
        self.countDownTimer_ = nil
    end
end

function CityJobView:updateCountDonw()
    local remainTime = math.max(0, CityJobDataMgr:getJobEventSuplTime())
    if remainTime == 0 then
        self:refreshJobEvent()
        self:refreshBuildScroll()
        self.Panel_working:hide()
        return
    end
    local _, hour, min, sec = Utils:getDHMS(remainTime, false)
    if min < 1 and sec > 1 then
        min = min + 1
    end
    if hour < 1 then
        min = math.max(1, min)
    end
    self.Label_over_time:setTextById("r90002", hour, min)
    self.passTime  = self.passTime + 1
    if self.passTime > 10 then
        self.passTime = 0
        self:refreshBuildScroll()
    end
end

function CityJobView:refreshJobPanel()
    if CityJobDataMgr:dontHaveAnyJobData() then
        return
    end 
    for i,jobItem in ipairs(self.scrollViewJob:getItems()) do
        self:updateJobItem(jobItem,i)
    end
end

function CityJobView:updateJobItem(jobItem,idx)
    local jobInfo = self:getJobInfoByIndex(idx)
    if not jobInfo then
        return
    end
    local jobCfg = CityJobDataMgr:getCityJobCfgById(jobInfo.jobId)

    local Label_name = TFDirector:getChildByPath(jobItem,"Label_name")
    local Panel_energy = TFDirector:getChildByPath(jobItem,"Panel_energy")
    local Label_energy_cost = TFDirector:getChildByPath(Panel_energy,"Label_energy_cost")
    local Label_already_down = TFDirector:getChildByPath(jobItem,"Label_already_down"):hide()
    local Panel_cover = TFDirector:getChildByPath(jobItem,"Panel_cover"):hide()
    local Label_time_limit = TFDirector:getChildByPath(jobItem,"Label_time_limit")
    local Label_time_need = TFDirector:getChildByPath(jobItem,"Label_time_need")
    local Image_energy = TFDirector:getChildByPath(jobItem,"Image_energy")
    local Image_selected = TFDirector:getChildByPath(jobItem,"Image_selected"):hide()

    Label_name:setTextById(jobCfg.name)
    for i=1,5 do
        local str = string.format("Image_star%02d",i)
        local starItem = TFDirector:getChildByPath(jobItem,str)
        if jobCfg.quality >= i then
            starItem:show()
        else
            starItem:hide()
        end
    end
    if jobInfo.jobType == 3 then
        Label_already_down:show()
        Panel_cover:show()
        Panel_energy:hide()
    else
        Panel_energy:show()
    end
    if not CityJobDataMgr:checkJobEnableInTime(jobInfo) then
        Panel_cover:show()
    end
    if jobInfo.type == 1 then
        Label_time_limit:setText("18:00-06:00")
    else
        Label_time_limit:setText("06:00-18:00")
    end
    local cost = 0
    local costCfg = nil
    for k,v in pairs(jobCfg.costVim) do
        cost = tonumber(v)
        costCfg = GoodsDataMgr:getItemCfg(k)
    end
    if costCfg then
        Image_energy:setTexture(costCfg.icon)
    end
    Label_energy_cost:setText(tostring(cost))
    local _, hour, min, sec = Utils:getDHMS(jobCfg.costTime, false)
    Label_time_need:setTextById("r90001", hour)
    if idx == self.selectJobIndex_ then
        Image_selected:show()
    end
end

function CityJobView:updateJobSelctState(item, isSelected)
    local Image_selected = TFDirector:getChildByPath(item,"Image_selected")
    if isSelected then
        Image_selected:show()
    else
        Image_selected:hide()
    end
end

function CityJobView:getJobInfoByIndex(idx)
    if CityJobDataMgr:dontHaveAnyJobData() then
        return
    end 
    local jobInfoList = CityJobDataMgr:getJobInfoListByIdx(self.selectBuildIndex_)
    local jobInfos = jobInfoList and jobInfoList.jobInfos or nil
    return jobInfos and jobInfos[idx] or nil
end

function CityJobView:selectJob(item, idx)
    if self.workingJobInfo or self.selectJobIndex_ == idx then
        return
    end
    local jobInfo = self:getJobInfoByIndex(idx)
    if jobInfo.jobType == 1 and not CityJobDataMgr:checkJobEnableInTime(jobInfo) then
        Utils:showTips(2400015)
    end
    self.selectJobIndex_ = idx
    self:refreshJobPanel()
    self:refreshRewardPanel()
    self:refreshJobBtnState()
    if self.selectJobItem then
        self:updateJobSelctState(self.selectJobItem, false)
    end
    self:updateJobSelctState(item, true)
end

function CityJobView:registerEvents()
    EventMgr:addEventListener(self, EV_CITY_PART_TIME_JOB_LIST, handler(self.onReloadJobUI, self))
    EventMgr:addEventListener(self, EV_CITY_DO_PART_TIME_JOB, handler(self.onRefreshJobUI, self))
    EventMgr:addEventListener(self, EV_CITY_PART_TIME_JOB_AWARD, handler(self.onGetJobReward, self))
    EventMgr:addEventListener(self, EV_CITY_GIVE_UP_JOB, handler(self.onGiveUpJobSuccess, self))
    EventMgr:addEventListener(self, EV_NEW_BUILDING_RES_SPEED_PART_TIME_JOB, handler(self.onRecvAccelerateInfo, self))

    
    
    for i,buildItem in ipairs(self.buildScroll:getItems()) do
        buildItem:Touchable(true)
        buildItem:onClick(function()
            self:selectBuild(i)
            end)
    end

    self:setMainBtnCallback(function()
        if GuideDataMgr:isInNewGuide() then
            AlertManager:removeMainSecneCacheLayers()
            self:timeOut(function()
                AlertManager:changeScene(SceneType.MainScene)
            end,0.01)
        else
            AlertManager:changeScene(SceneType.MainScene)
        end
    end)
end

function CityJobView:setCloseCallback(callBack)
    self.closeCallBack = callBack
end

function CityJobView:onClose()
    self.super.onClose(self)

end

function CityJobView:onShow()
    self.super.onShow(self)
    self:timeOut(function()
        self:removeLockLayer()
        GameGuide:checkGuide(self);
    end,0.02)
    self:updatePanelAccelerate()
end



---------------------------guide------------------------------

--引导装备质点
function CityJobView:excuteGuideFunc17001(guideFuncId)
    local targetNode = self.Button_start_job
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end


return CityJobView
