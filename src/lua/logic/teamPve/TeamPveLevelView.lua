TeamPveLevelView = class("TeamPveLevelView",BaseLayer)

function TeamPveLevelView:ctor(trainDungeonCid)
    self.super.ctor(self)
    self:initData(trainDungeonCid)
    local showType = Utils:getKVP(61003,"uiType") or ""
    self:init("lua.uiconfig.teamFight.teamPveLevelView"..showType)
end

function TeamPveLevelView:initData(trainDungeonCid)

    self.trainDungeonCid = trainDungeonCid
    self.trainDungeonCfg = TeamPveDataMgr:getTrainDungeonCfg(trainDungeonCid)
    self.maxPlayerLv = Utils:getKVP(9002,"pmaxlvl")
    self.curCostStat = {id = 0,num = 0,hasnum = 0}
    self.maxActive_ = 200
    self.activeItem_ = {}
    self.trainChapterInfo = TeamPveDataMgr:getTrainChapterInfo(trainDungeonCid)

end

function TeamPveLevelView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_top = TFDirector:getChildByPath(self.Panel_root, "Panel_top")
    self.Label_name = TFDirector:getChildByPath(self.Panel_top, "Label_name")
    self.Label_name:setTextById(self.trainDungeonCfg.capter)
    self.Label_time = TFDirector:getChildByPath(self.Panel_top, "Label_time")

    local startTime = Utils:getTimeData(self.trainChapterInfo.startTime)
    local endTime = Utils:getTimeData(self.trainChapterInfo.endTime)
    self.Label_time:setTextById(111000123, startTime.Month, startTime.Day, endTime.Month, endTime.Day)

    self.Label_Contribute = TFDirector:getChildByPath(self.Panel_top, "Label_num")

    self.Image_active_progress = TFDirector:getChildByPath(self.Panel_top, "Image_active_progress")
    self.LoadingBar_activeProgress = TFDirector:getChildByPath(self.Panel_top, "LoadingBar_activeProgress")
    self.Panel_activeItem = TFDirector:getChildByPath(self.Panel_top, "Panel_activeItem")

    self.Panel_bottom = TFDirector:getChildByPath(self.Panel_root, "Panel_bottom")
    self.dungeonInfo = {}
    for i=1,3 do
        local panelItem = TFDirector:getChildByPath(self.Panel_bottom, "Panel_item"..i)
        self.dungeonInfo[i] = {}
        self.dungeonInfo[i].root = panelItem
        self.dungeonInfo[i].titleTx = TFDirector:getChildByPath(panelItem, "Label_title")
        self.dungeonInfo[i].LvTx = TFDirector:getChildByPath(panelItem, "Label_lv")
        self.dungeonInfo[i].valueTx = TFDirector:getChildByPath(panelItem, "Label_value")
        self.dungeonInfo[i].cntTx = TFDirector:getChildByPath(panelItem, "Label_cnt")
        self.dungeonInfo[i].btnItem = TFDirector:getChildByPath(panelItem, "Button_item")
        self.dungeonInfo[i].lockImg = TFDirector:getChildByPath(panelItem, "Image_lock")
        local LabelTip = TFDirector:getChildByPath(panelItem, "Label")
        LabelTip:setTextById(2101810)
    end

    TFDirector:send(c2s.CHASM_REQ_TRAIN_DUNGEON_INFO, {})
    self:initContributeBar()

end

function TeamPveLevelView:initContributeBar()
    --TEAM_PVE
    self.activeTask_ = TaskDataMgr:getTask(EC_TaskType.TEAM_PVE)
    table.sort(self.activeTask_,function (taskIdA,taskIdB)
        local taskCfgA = TaskDataMgr:getTaskCfg(taskIdA)
        local taskCfgB = TaskDataMgr:getTaskCfg(taskIdB)
        return taskCfgA.progress < taskCfgB.progress
    end)
    if #self.activeTask_ > 0 then
        local taskCfg = TaskDataMgr:getTaskCfg(self.activeTask_[#self.activeTask_])
        self.maxActive_ = taskCfg.progress
    end
    local size = self.Image_active_progress:Size()
    for i, v in ipairs(self.activeTask_) do
        local taskCfg = TaskDataMgr:getTaskCfg(self.activeTask_[i])
        local taskInfo = TaskDataMgr:getTaskInfo(self.activeTask_[i])
        local percent = i/#self.activeTask_
        local Panel_activeItem = self.Panel_activeItem:clone()
        Panel_activeItem:setVisible(true)
        local item = {}
        item.root = Panel_activeItem
        item.Button_geted = TFDirector:getChildByPath(item.root, "Button_geted")
        item.Button_canGet = TFDirector:getChildByPath(item.root, "Button_canGet")
        item.Spine_effect = TFDirector:getChildByPath(item.Button_canGet, "Spine_effect")
        item.Button_notGet = TFDirector:getChildByPath(item.root, "Button_notGet")
        local Label_getValue1 = TFDirector:getChildByPath(item.Button_geted, "Label_getValue")
        local Label_getValue2 = TFDirector:getChildByPath(item.Button_canGet, "Label_getValue")
        local Label_getValue3 = TFDirector:getChildByPath(item.Button_notGet, "Label_getValue")
        item.spine_role = TFDirector:getChildByPath(item.root, "spine_role")
        if Label_getValue1 then
            Label_getValue1:setText(taskCfg.progress)
        end
        Label_getValue2:setText(taskCfg.progress)
        Label_getValue3:setText(taskCfg.progress)
        if item.spine_role then
            item.spine_role:play("idle",true)
        end
        self.activeItem_[i] = item
        Panel_activeItem:Pos(size.width * percent, -3):AddTo(self.Image_active_progress)
    end
    self:updateContributeBar()
end

function TeamPveLevelView:updateContributeBar()

    local count = 0
    for i, v in ipairs(self.activeItem_) do
        local taskCfg = TaskDataMgr:getTaskCfg(self.activeTask_[i])
        local taskInfo = TaskDataMgr:getTaskInfo(self.activeTask_[i])
        if taskInfo then
            v.Button_geted:setVisible(taskInfo.status == EC_TaskStatus.GETED)
            v.Button_canGet:setVisible(taskInfo.status == EC_TaskStatus.GET)
            if taskInfo.status == EC_TaskStatus.GET then
                v.Spine_effect:play("animation",1)
            end
            v.Button_notGet:setVisible(taskInfo.status == EC_TaskStatus.ING)
            count = taskInfo.progress



            if v.spine_role then
                if taskCfg.progress >= self.maxActive_ then
                    local dir = taskInfo.status == EC_TaskStatus.GETED and -1 or 1
                    v.spine_role:setScaleX(dir*math.abs(v.spine_role:getScaleX()))
                end
            end
        
        else
            v.Button_geted:setVisible(false)
            v.Button_canGet:setVisible(false)
            v.Button_notGet:setVisible(true)
        end
    end

    local percent = me.clampf(count / self.maxActive_, 0, 1)
    local hasRoleShow = false
    local basePercent = 1/#self.activeItem_
    local tmpPercent = 0
    local tmpPercent1 = 0
    local lastCfgPercent = 0
    local hasCalc = false

    for i, v in ipairs(self.activeItem_) do
        local taskCfg = TaskDataMgr:getTaskCfg(self.activeTask_[i])
        local cfgPercent = taskCfg.progress/self.maxActive_
        if percent <= cfgPercent and not hasRoleShow then
            v.spine_role:setVisible(true)
            hasRoleShow = true
        else
            v.spine_role:setVisible(false)
        end

        if hasCalc then
            -- 不在计算百分比
        elseif percent < cfgPercent then
            local dd = basePercent/(cfgPercent - lastCfgPercent)
            tmpPercent = tmpPercent + tmpPercent1*dd
            hasCalc = true
        else
            tmpPercent = i*basePercent
            tmpPercent1 = percent - cfgPercent
            lastCfgPercent = cfgPercent
        end
    end
    self.LoadingBar_activeProgress:setPercent(tmpPercent * 100)
    self.Label_Contribute:setText(count)
end

function TeamPveLevelView:updateLevelInfo()

    for k,v in ipairs(self.trainDungeonCfg.dungeonID) do
        local dungeonCfg = TeamPveDataMgr:getTrainDungeonLevelCfg(v)
        if not dungeonCfg then
            self.dungeonInfo[k].root:setVisible(false)
        else
            local dungeonInfo = TeamPveDataMgr:getTrainDungeonInfo(v)
            if dungeonInfo then
                self.dungeonInfo[k].root:setVisible(true)
                self.dungeonInfo[k].titleTx:setTextById(dungeonCfg.levelName)
                self.dungeonInfo[k].LvTx:setTextById(dungeonCfg.levelDesc)
                self.dungeonInfo[k].valueTx:setText(dungeonCfg.battlePoint)
                local maxCnt = dungeonCfg.rewardTime
                local cnt = dungeonInfo.fightCount
                local remainCnt = maxCnt - cnt
                if remainCnt < 0 then
                    remainCnt = 0
                end
                self.dungeonInfo[k].cntTx:setText(remainCnt.."/"..maxCnt)
                self.dungeonInfo[k].btnItem:setTextureNormal(dungeonCfg.bossicon)
                self.dungeonInfo[k].lockImg:setVisible(not dungeonInfo.isOpen)
            end

        end
    end

end

function TeamPveLevelView:showPreview(index)
    local dailyTaskCid = self.activeTask_[index]
    local taskCfg = TaskDataMgr:getTaskCfg(dailyTaskCid)
    Utils:previewReward(self.Image_preview, taskCfg.reward)
end

function TeamPveLevelView:updateInfo()
    self:updateLevelInfo()
end

function TeamPveLevelView:onTaskUpdateEvent()
    self:updateContributeBar()
end

function TeamPveLevelView:onTaskReceiveEvent(reward)
    if self.isShowDating then
        self.needShowReward = reward
        return
    end

    Utils:showReward(reward)
end

function TeamPveLevelView:registerEvents()

    EventMgr:addEventListener(self, EV_TEAMPVE_LEVEL_INFO, handler(self.updateLevelInfo, self))
    EventMgr:addEventListener(self, EV_TASK_UPDATE, handler(self.onTaskUpdateEvent, self))
    EventMgr:addEventListener(self, EV_TASK_RECEIVE, handler(self.onTaskReceiveEvent, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.closeSriptView, function ( ... )
        if self.needShowReward then
            self.isShowDating = nil
            self:onTaskReceiveEvent(self.needShowReward)
            self.needShowReward = nil
        end
    end)

    for i=1,3 do
        self.dungeonInfo[i].btnItem:onClick(function()
            local dungeonId = self.trainDungeonCfg.dungeonID[i]
            if not dungeonId then
                return
            end

            local dungeonCfg = TeamPveDataMgr:getTrainDungeonLevelCfg(dungeonId)
            if not dungeonCfg then
                return
            end

            local dungeonDataInfo = TeamPveDataMgr:getTrainDungeonInfo(dungeonId)
            if not dungeonDataInfo then
                return
            end

            local remainCnt = dungeonCfg.rewardTime - dungeonDataInfo.fightCount
            if remainCnt < 0 then
                remainCnt = 0
            end
            --刷新花费
            for k,v in pairs(dungeonCfg.fightCost) do
                self.curCostStat.id = k
                self.curCostStat.num = v
            end
            self.curCostStat.hasnum = GoodsDataMgr:getItemCount(self.curCostStat.id)

            local playerLv = MainPlayer:getPlayerLv()
            local maxPlvCheckok = true
            if dungeonCfg.lvlLimit[2] and dungeonCfg.lvlLimit[2] < self.maxPlayerLv then
                if playerLv > dungeonCfg.lvlLimit[2] then
                    maxPlvCheckok = false
                end
            end

            if not dungeonDataInfo.isOpen then
                Utils:showError(2101814)
            elseif playerLv < dungeonCfg.lvlLimit[1] then
                Utils:showError(2100100)
            elseif maxPlvCheckok == false then
            else
                --弹出预览
                local previewData = {levelCfg = clone(dungeonCfg),costData = clone(self.curCostStat),remainCnt = remainCnt}
                local view = requireNew("lua.logic.teamPve.TeamPveLevelPreview"):new(previewData)
                AlertManager:addLayer(view)
                AlertManager:show()
            end
        end)
    end

    for i, v in ipairs(self.activeItem_) do
        v.Button_geted:onClick(function()
            self:showPreview(i)
        end)
        v.Button_canGet:onClick(function()
            if self:playTaskDating(self.activeTask_[i]) then
                self.isShowDating = true
            end
            local taskInfo = TaskDataMgr:getTaskInfo(self.activeTask_[i])
            TaskDataMgr:send_TASK_SUBMIT_TASK(taskInfo.cid)
        end)
        v.Button_notGet:onClick(function()
            self:showPreview(i)
        end)
    end
end

function TeamPveLevelView:playTaskDating(taskId)
    local UserDefalt = CCUserDefault:sharedUserDefault()
    local taskDating = Utils:getKVP(61003,"taskDating")
    if taskDating then
        local list = taskDating[taskId]
        if list then
            local datingId = list[self.trainDungeonCid]
            if datingId then
                local isDating = UserDefalt:getStringForKey("isDating"..MainPlayer:getPlayerId().."datingId"..datingId)
                if isDating ~= "true" then
                    UserDefalt:setStringForKey("isDating"..MainPlayer:getPlayerId().."datingId"..datingId,"true")
                    FunctionDataMgr:jStartDating(datingId)
                    return true
                end
            end
        end
    end
    return false
end

return TeamPveLevelView