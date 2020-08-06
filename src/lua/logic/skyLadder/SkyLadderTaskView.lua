local SkyLadderTaskView = class("SkyLadderTaskView", BaseLayer)

function SkyLadderTaskView:ctor()
    self.super.ctor(self)
    self:initData()
    self:showPopAnim(true)
    self:init("lua.uiconfig.skyladder.skyladderTaskView")
end

function SkyLadderTaskView:initData()

    local curSubRankId = SkyLadderDataMgr:getCurSubRankId()
    local rankMatchCfg = SkyLadderDataMgr:getRankMatchCfg(curSubRankId)
    if not rankMatchCfg then
        Box("wrong curSubRankId:"..curSubRankId)
        return
    end
    self.mainTaskId = rankMatchCfg.weekMainTask
end

function SkyLadderTaskView:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui

    self.Panel_root = TFDirector:getChildByPath(self.ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab")

    self.Image_left_bg = TFDirector:getChildByPath(self.ui, "Image_left_bg")
    self.Image_get = TFDirector:getChildByPath(self.Image_left_bg, "Image_get")
    self.Spine_get = TFDirector:getChildByPath(self.Image_left_bg, "Spine_get")
    self.Label_title = TFDirector:getChildByPath(self.Image_left_bg, "Label_title")
    self.Button_award = TFDirector:getChildByPath(self.Image_left_bg, "Button_award")
    self.Label_progress = TFDirector:getChildByPath(self.Image_left_bg, "Label_progress")
    self.LoadingBar_card = TFDirector:getChildByPath(self.Image_left_bg, "LoadingBar_card")
    self.Image_progress_icon = TFDirector:getChildByPath(self.Image_left_bg, "Image_progress_icon")
    self.Image_progress_icon:setTexture("icon/item/goods/500100.png")
    self.Label_cardtip = TFDirector:getChildByPath(self.Panel_root, "Label_cardtip")
    local ScrollView_task = TFDirector:getChildByPath(self.Panel_root, "ScrollView_task")
    self.ListView_task = UIListView:create(ScrollView_task)
    self.ListView_task:setItemsMargin(4)

    self.Panel_task_cell = TFDirector:getChildByPath(self.Panel_prefab, "Panel_task_cell")

    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")

    self:updateTaskInfo()
end

function SkyLadderTaskView:updateTaskInfo()

    self.skyladderTask = TaskDataMgr:getTask(EC_TaskType.SKYLADDER)
    self:updateMainTaskInfo()
    self:updateTaskListInfo()
end

function SkyLadderTaskView:updateMainTaskInfo()

    local taskInfo = TaskDataMgr:getTaskInfo(self.mainTaskId)
    local taskCfg = TaskDataMgr:getTaskCfg(self.mainTaskId)
    if not taskInfo or not taskCfg then
        return
    end
    self.Label_title:setTextById(taskCfg.name)

    local progress = math.min(taskInfo.progress, taskCfg.progress)
    local taskPercent = math.floor(progress/taskCfg.progress*100)
    self.LoadingBar_card:setPercent(taskPercent)
    self.Label_progress:setTextById(800005, progress, taskCfg.progress)

    self.Label_cardtip:setTextById(taskCfg.des,taskCfg.progress)

    self.Button_award:setTextureNormal(taskCfg.icon)
    self.Button_award:setScale(0.7)
    self.Image_get:setVisible(taskInfo.status == EC_TaskStatus.GET)
    self.Spine_get:setVisible(taskInfo.status == EC_TaskStatus.GET)

    local itemId
    local reward = taskCfg.reward[1]
    if reward then
        itemId = reward[1]
    end

    self.Button_award:onClick(function ()
        if taskInfo.status == EC_TaskStatus.GET then
            TaskDataMgr:send_TASK_SUBMIT_TASK(taskInfo.cid)
        else
            Utils:showInfo(itemId)
        end
    end)
end

function SkyLadderTaskView:updateTaskListInfo()

    self.ListView_task:removeAllItems()
    for k,v in ipairs(self.skyladderTask) do
        local taskInfo = TaskDataMgr:getTaskInfo(v)
        local taskCfg = TaskDataMgr:getTaskCfg(v)
        if taskCfg and taskInfo and self.mainTaskId ~= v then
            print(taskCfg.id)
            local taskItem = self.Panel_task_cell:clone()
            local Label_task_name = TFDirector:getChildByPath(taskItem, "Label_task_name")
            Label_task_name:setTextById(taskCfg.name)

            local Label_task_tip = TFDirector:getChildByPath(taskItem, "Label_task_tip")
            Label_task_tip:setTextById(taskCfg.des,taskCfg.progress)

            local Image_bg = TFDirector:getChildByPath(taskItem, "Image_bg")
            local imgBgRes = taskInfo.status == EC_TaskStatus.GETED and "ui/skyladder/main/027.png" or "ui/skyladder/main/030.png"
            Image_bg:setTexture(imgBgRes)

            local Image_finish = TFDirector:getChildByPath(taskItem, "Image_finish")
            Image_finish:setVisible(taskInfo.status == EC_TaskStatus.GETED)

            local Image_get = TFDirector:getChildByPath(taskItem, "Image_get")
            Image_get:setVisible(taskInfo.status == EC_TaskStatus.GET)

            local Image_bar_bg = TFDirector:getChildByPath(taskItem, "Image_bar_bg")
            Image_bar_bg:setVisible(taskInfo.status == EC_TaskStatus.ING)

            local progress = math.min(taskInfo.progress, taskCfg.progress)
            local taskPercent = math.floor(progress/taskCfg.progress*100)
            local LoadingBar_task = TFDirector:getChildByPath(taskItem, "LoadingBar_task")
            LoadingBar_task:setPercent(taskPercent)
            local Label_task_pro = TFDirector:getChildByPath(taskItem, "Label_task_pro")
            Label_task_pro:setTextById(800005, progress, taskCfg.progress)

            local reward = taskCfg.reward
            for i=1,2 do
                local awardItem = TFDirector:getChildByPath(taskItem, "Panel_award_"..i)
                local awardInfo = reward[i]
                if awardInfo then
                    awardItem:setVisible(true)
                    local itemId,itemCnt = awardInfo[1],awardInfo[2]
                    local Label_cnt = TFDirector:getChildByPath(awardItem, "Label_cnt")
                    Label_cnt:setText("x"..itemCnt)
                    local width = Label_cnt:getContentSize().width
                    local Image_icon = TFDirector:getChildByPath(awardItem, "Image_icon")
                    if i==2 then
                        Image_icon:setPositionX(-width/2)
                    end
                    local goodsCfg = GoodsDataMgr:getItemCfg(itemId)
                    if goodsCfg then
                        Image_icon:setTexture(goodsCfg.icon)
                    end

                    awardItem:onClick(function()
                        Utils:showInfo(itemId)
                    end)
                else
                    awardItem:setVisible(false)
                end

                if i == 2 then
                    local posX = Label_task_name:getPositionX()
                    local w = Label_task_name:getContentSize().width
                    awardItem:setPositionX(posX+w+49)
                end
            end

            --v.Panel_geted:setVisible(taskInfo.status == EC_TaskStatus.GETED)
            --v.Panel_canGet:setVisible(taskInfo.status == EC_TaskStatus.GET)
            --v.Panel_notGet:setVisible(taskInfo.status == EC_TaskStatus.ING)

            taskItem:onClick(function()
                if taskInfo.status == EC_TaskStatus.GET then
                    TaskDataMgr:send_TASK_SUBMIT_TASK(taskInfo.cid)
                end
            end)

            self.ListView_task:pushBackCustomItem(taskItem)
        end
    end
end

function SkyLadderTaskView:onTaskUpdateEvent()
    self:updateTaskInfo()
end

function SkyLadderTaskView:onTaskReceiveEvent(reward)
    Utils:showReward(reward)
end

function SkyLadderTaskView:registerEvents()
    EventMgr:addEventListener(self, EV_TASK_UPDATE, handler(self.onTaskUpdateEvent, self))
    EventMgr:addEventListener(self, EV_TASK_RECEIVE, handler(self.onTaskReceiveEvent, self))
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return SkyLadderTaskView