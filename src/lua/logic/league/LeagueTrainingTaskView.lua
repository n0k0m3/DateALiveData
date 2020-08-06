local LeagueTrainingTaskView = class("LeagueTrainingTaskView", BaseLayer)

function LeagueTrainingTaskView:ctor(showBtn)
    self.super.ctor(self)
    self:initData(showBtn)
    self:showPopAnim(true)
    self:init("lua.uiconfig.league.leagueTrainingTaskView")
end

function LeagueTrainingTaskView:registerEvents()
    EventMgr:addEventListener(self, EV_TASK_UPDATE, handler(self.updateTask, self))
    EventMgr:addEventListener(self, EV_TASK_RECEIVE, handler(self.taskReceive, self))

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

function LeagueTrainingTaskView:initData(showBtn)
    self.taskList = LeagueDataMgr:getTrainMatrixInfo().taskList
    self.showBtn = showBtn
end

function LeagueTrainingTaskView:initUI(ui)
    self.super.initUI(self, ui)

    local Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
    self.Panel_taskItem = TFDirector:getChildByPath(Panel_prefab, "Panel_taskItem")

    self.Button_close = TFDirector:getChildByPath(ui, "Button_close")
    local ScrollView_task = TFDirector:getChildByPath(ui, "ScrollView_task")
    self.ListView_task = UIListView:create(ScrollView_task)
    self.ListView_task:setItemsMargin(5)

    self:updateTask()
end

function LeagueTrainingTaskView:updateTask()
    self.ListView_task:removeAllItems()
    local taskList = TaskDataMgr:getTask(EC_TaskType.UNION_TRAIN)
    for i, v in ipairs(taskList) do
        local taskCfg = TaskDataMgr:getTaskCfg(v)
        local taskitem = self.Panel_taskItem:clone():show()
        local Image_icon = TFDirector:getChildByPath(taskitem, "Image_icon")
        local Label_name = TFDirector:getChildByPath(taskitem, "Label_name")
        local Label_desc = TFDirector:getChildByPath(taskitem, "Label_desc")
        local Label_jindu = TFDirector:getChildByPath(taskitem, "Label_jindu")
        local Image_score = TFDirector:getChildByPath(taskitem, "Image_score")
        local btGet = TFDirector:getChildByPath(taskitem, "Button_receive")
        local Button_going = TFDirector:getChildByPath(taskitem, "Button_going")
        local Label_going = TFDirector:getChildByPath(taskitem, "Label_going")
        local Button_geted = TFDirector:getChildByPath(taskitem, "Button_geted")
        local ScrollView_award = UIListView:create(TFDirector:getChildByPath(taskitem, "ScrollView_award"))

        Label_jindu:setVisible(false)
        Image_score:setVisible(false)
        Image_icon:setTexture(taskCfg.icon)
        Label_name:setTextById(taskCfg.name)
        Label_desc:setTextById(taskCfg.des)

        btGet:hide()
        Button_going:hide()
        Button_geted:hide()
        if self.showBtn then
            Button_going:setTouchEnabled(false)
            Button_going:setGrayEnabled(true)
            Button_going:show()
            Label_going:enableOutline(ccc4(255,192,203,255),1)
            local taskInfo = TaskDataMgr:getTaskInfo(v)
            if taskInfo then
                local progress = math.min(taskInfo.progress, taskCfg.progress)
                if progress > 0 then
                    Label_jindu:setVisible(true)
                    Image_score:setVisible(true) 
                    Image_score:setTexture(LeagueDataMgr:getTrainMatrixRankPic(progress))
                end
                if taskInfo.status == EC_TaskStatus.ING then
                    btGet:hide()
                    Button_geted:hide()
                elseif taskInfo.status == EC_TaskStatus.GET then
                    btGet.cid = v
                    btGet:onClick(function(sender)
                        TaskDataMgr:send_TASK_SUBMIT_TASK(sender.cid)
                    end)
                    btGet:show()
                    Button_going:hide()
                    Button_geted:hide()
                elseif taskInfo.status == EC_TaskStatus.GETED then
                    btGet:hide()
                    Button_going:hide()
                    Button_geted:show()
                    Button_geted:setTouchEnabled(false)
                    Button_geted:setGrayEnabled(true)
                end
            end
        end
        for i,v in ipairs(taskCfg.reward) do
            local itemPrefab = PrefabDataMgr:getPrefab("Panel_goodsItem")
            local item = itemPrefab:clone()
            local cfg = GoodsDataMgr:getItemCfg(v.id)
            item:setScale(0.7)
            PrefabDataMgr:setInfo(item, v[1], v[2])
            ScrollView_award:pushBackCustomItem(item)
        end
        self.ListView_task:pushBackCustomItem(taskitem)
    end
end

function LeagueTrainingTaskView:taskReceive(rewards, taskid)
    Utils:showReward(rewards)
end

return LeagueTrainingTaskView