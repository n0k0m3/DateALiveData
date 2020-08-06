
local SummonContractMainView = class("SummonContractMainView", BaseLayer)

function SummonContractMainView:initData()
    self.taskItems_ = {}
    self.contractInfo = SummonDataMgr:getSummonContractInfo()
    self.contractCfg = TabDataMgr:getData("ContractSpirit",self.contractInfo.taskIndenture)
end

function SummonContractMainView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.summon.summonContractMainView")
end

function SummonContractMainView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_taskItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_taskItem")

    self.Button_details = TFDirector:getChildByPath(self.Panel_root, "Button_details")
    local Image_task = TFDirector:getChildByPath(self.Panel_root, "Image_task")
    self.Label_title = TFDirector:getChildByPath(Image_task, "Label_title")
    self.Label_cur_level = TFDirector:getChildByPath(Image_task, "Label_cur_level")
    self.Label_level = TFDirector:getChildByPath(self.Label_cur_level, "Label_level")
    local Image_scrollBar = TFDirector:getChildByPath(Image_task, "Image_scrollBar")
    local Image_scrollBarInner = TFDirector:getChildByPath(Image_scrollBar, "Image_scrollBarInner")
    local scrollBar = UIScrollBar:create(Image_scrollBar, Image_scrollBarInner)
    local ScrollView_task = TFDirector:getChildByPath(Image_task, "ScrollView_task")
    self.GridView_task = UIGridView:create(ScrollView_task)
    self.GridView_task:setItemModel(self.Panel_taskItem)
    self.GridView_task:setColumn(3)
    self.GridView_task:setScrollBar(scrollBar)
    local Image_contract = TFDirector:getChildByPath(self.Panel_root, "Image_contract")
    self.Label_contract = TFDirector:getChildByPath(Image_contract, "Label_contract")
    self.Label_timing = TFDirector:getChildByPath(Image_contract, "Label_timing")
    self.Label_cond = TFDirector:getChildByPath(Image_contract, "Label_cond")
    self.Image_contract = Image_contract
    self.Button_build = TFDirector:getChildByPath(self.Panel_root, "Button_build")
    self.Label_build = TFDirector:getChildByPath(self.Button_build, "Label_build")
    self.Image_flag = TFDirector:getChildByPath(self.Panel_root, "Image_flag")
    self.Label_num = TFDirector:getChildByPath(self.Image_flag, "Label_num")
    local Image_cost = TFDirector:getChildByPath(self.Panel_root, "Image_cost")
    self.Image_raw_costIcon = TFDirector:getChildByPath(Image_cost, "Image_raw_costIcon")
    self.Label_raw_costNum = TFDirector:getChildByPath(Image_cost, "Label_raw_costNum")
    self.Image_costIcon = TFDirector:getChildByPath(Image_cost, "Image_costIcon")
    self.Label_costNum = TFDirector:getChildByPath(Image_cost, "Label_costNum")

    self.Button_summon = TFDirector:getChildByPath(self.Panel_root, "Button_summon")
    local Label_summon = TFDirector:getChildByPath(self.Button_summon, "Label_summon")
    Label_summon:setTextById(1325318)
    self.particle_effect = TFDirector:getChildByPath(self.Panel_root,"particle_effect"):hide()

    self.spine_effect = TFDirector:getChildByPath(self.Button_build,"spine_effect"):hide()

    self:refreshView()
end

function SummonContractMainView:addTaskItem()
    local foo = {}
    foo.root = self.Panel_taskItem:clone()
    foo.panel_root = TFDirector:getChildByPath(foo.root, "panel_root")
    foo.Button_task = TFDirector:getChildByPath(foo.root, "Button_task")
    foo.Label_desc = TFDirector:getChildByPath(foo.Button_task, "Label_desc")
    foo.Image_icon = TFDirector:getChildByPath(foo.Button_task, "Image_icon")
    foo.Label_name = TFDirector:getChildByPath(foo.Button_task, "Label_name")
    foo.Image_geted = TFDirector:getChildByPath(foo.root, "Image_geted")
    foo.Image_notGet = TFDirector:getChildByPath(foo.root, "Image_notGet")
    foo.Image_gou = TFDirector:getChildByPath(foo.root, "Image_gou")
    foo.spine_effect = TFDirector:getChildByPath(foo.root, "spine_effect"):hide()
    local Label_geted = TFDirector:getChildByPath(foo.Image_gou, "Label_geted")
    Label_geted:setTextById(700033)
    self.taskItems_[foo.root] = foo
    self.GridView_task:pushBackCustomItem(foo.root)
end

function SummonContractMainView:removeUI(  )
    -- body
    self.super.removeUI(self)
    if self.timer then
        TFDirector:stopTimer(self.timer)
        TFDirector:removeTimer(self.timer)
        self.timer = nil
    end
end

function SummonContractMainView:refreshView()
    self.Label_title:setTextById( 1325301)
    self.Label_cur_level:setTextById(1325302)
    self.Label_contract:setTextById(1325304)
    self:updateContractState()

    local function flushLabelTime()
        local remainTime = 0
        if self.contractInfo.summonInfo then
            remainTime = math.max(self.contractInfo.summonInfo.endTime - ServerDataMgr:getServerTime())
        end
        local day,hour,min,sec = Utils:getTimeDHMZ(remainTime)
        self.Label_timing:setTextById(1325313, hour, min, sec)
        self.Image_contract:setVisible(remainTime > 0)
        self.Button_summon:setVisible(remainTime > 0)
    end
    flushLabelTime()
    self.timer = TFDirector:addTimer(1000,-1,nil,flushLabelTime)
end

function SummonContractMainView:updateContractState()
    self.contractInfo = SummonDataMgr:getSummonContractInfo()
    self.contractCfg = TabDataMgr:getData("ContractSpirit",self.contractInfo.taskIndenture)
    local canBuy,cfg = SummonDataMgr:getCanBuildContract()
    -- if self.contractInfo.actIndentures and #self.contractInfo.actIndentures > 0  then
    --     local lastStageBuy = false
    --     for k,v in pairs(self.contractInfo.actIndentures) do
    --         local cfg = TabDataMgr:getData("ContractSpirit",v)
    --         if cfg.NextStage == 0 then
    --             lastStageBuy = true
    --         end
    --     end

    --     if canBuy then
    --         self.Label_build:setTextById(1325317)
    --     elseif lastStageBuy then
    --         self.Label_build:setTextById(1325319)
    --     else
    --         self.Label_build:setTextById(1325306,cfg.DemandLevel[1])
    --     end
    -- else
    --     self.Label_build:setTextById(1325305)
    -- end

    self.Label_build:setTextById(1325305,cfg.Price)
    self.Label_num:setText(cfg.ShowMultiple)
    local lastStageBuy = false

    if self.contractInfo.actIndentures and #self.contractInfo.actIndentures > 0  then
        for k,v in pairs(self.contractInfo.actIndentures) do
            local cfg = TabDataMgr:getData("ContractSpirit",v)
            if cfg.NextStage == 0 then
                lastStageBuy = true
            end
        end
    end

    if lastStageBuy then
        self.Label_build:setTextById(1325319)
        self.Image_flag:hide()
    end

    self.Button_build:setTouchEnabled(canBuy)
    self.Button_build:setGrayEnabled(not canBuy)

    self.Label_level:setText(MainPlayer:getPlayerLv())
    cfg = cfg or self.contractInfo
    self.Label_raw_costNum:setText(cfg.OriginalCost)
    self.Label_costNum:setText(cfg.Price)
    self:updateAllTaskItem()
end

function SummonContractMainView:updateAllTaskItem()
    local items = self.GridView_task:getItems()
    self.showCfg = SummonDataMgr:getShowTaskItemList()
    local taskList = self.showCfg.items
    local gaps = #taskList - #items
    for i = 1, math.abs(gaps) do
        if gaps > 0 then
            self:addTaskItem()
        else
            local item = self.GridView_task:getItem(1)
            self.taskItems_[item] = nil
            self.GridView_task:removeItem(1)
        end
    end
    for i, v in ipairs(self.GridView_task:getItems()) do
        local taskCid = taskList[i]
        local taskCfg = TaskDataMgr:getTaskCfg(taskCid)
        local taskInfo = TaskDataMgr:getTaskInfo(taskCid) or {status = EC_TaskStatus.ING}
        local foo = self.taskItems_[v]
        local reward = taskCfg.reward[1]
        local rewardCid, rewardNum = reward[1], reward[2]
        local rewardCfg = GoodsDataMgr:getItemCfg(rewardCid)
        local name = TextDataMgr:getText(rewardCfg.nameTextId)
        foo.Image_icon:setTexture(rewardCfg.icon)
        foo.Label_name:setTextById(800037, name, rewardNum)
        foo.Label_desc:setTextById(taskCfg.des)

        foo.Button_task:setTouchEnabled(taskInfo.status ~= EC_TaskStatus.GETED)
        foo.Image_geted:setVisible(taskInfo.status == EC_TaskStatus.GETED)
        foo.Image_gou:setVisible(taskInfo.status == EC_TaskStatus.GETED)
        foo.Image_notGet:setVisible(taskInfo.status == EC_TaskStatus.ING)
        foo.Button_task:onClick(function()
                if not self.contractInfo.actIndentures or table.find(self.contractInfo.actIndentures,self.showCfg.id ) == -1 then
                    Utils:showTips(1325316)
                elseif taskInfo.status == EC_TaskStatus.ING then
                    Utils:showTips(1325310)
                elseif taskInfo.status == EC_TaskStatus.GET then
                    TaskDataMgr:send_TASK_SUBMIT_TASK(taskCid)
                end
        end)
    end
    self:checkShowBuyStageAni()
end

function SummonContractMainView:registerEvents()
    EventMgr:addEventListener(self, EV_TASK_UPDATE, handler(self.updateContractState, self))
    EventMgr:addEventListener(self, EV_TASK_RECEIVE, handler(self.onTaskReceiveEvent, self))
    EventMgr:addEventListener(self, EV_UPDATE_SUMMONCONTRACT, handler(self.updateContractState, self))

    self.Button_details:onClick(function()
            Utils:openView("summon.SummonContractDetailsView")
    end)

    self.Button_build:onClick(function()
        local canBuy, cfg = SummonDataMgr:getCanBuildContract( )
        if canBuy then
            RechargeDataMgr:getOrderNO(cfg.SellingPrice);
        end
    end)

    self.Button_summon:onClick(function()
            FunctionDataMgr:jSummon(1)
    end)
end

function SummonContractMainView:onTaskUpdateEvent()
    self:updateAllTaskItem()
end

function SummonContractMainView:onTaskReceiveEvent(reward)
    Utils:showReward(reward)
end

-- function SummonContractMainView:checkShowTaskAni(  )
--     if not self.lastShowId  then 
--         self.lastShowId = self.showCfg.id 
--     end
--     if self.showCfg.id ~= self.lastShowId  then --显示新阶段
--         self:showTaskItemEffect()
--         self.GridView_task.scrollView_:scrollToTop()
--         self.lastShowId  = self.showCfg.id
--     end
-- end

function SummonContractMainView:checkShowBuyStageAni(  )
    local canBuy,cfg = SummonDataMgr:getCanBuildContract()
    if not self.lastBuyStageId  then 
        self.lastBuyStageId  = cfg.id 
    end
    if canBuy and cfg.id ~= self.lastBuyStageId  then --显示新阶段
        Utils:openView("summon.SummonContractResult",handler(self.playStageChallengeEffect,self))
        self.lastBuyStageId  = cfg.id
    end
end

function SummonContractMainView:showTaskItemEffect(  )
    -- body
    for i, v in ipairs(self.GridView_task:getItems()) do
        local foo = self.taskItems_[v]
        foo.panel_root:hide()
        local seq = {
            DelayTime:create(0.5 + (i - 1 )* 0.1),
            CallFunc:create(function()
                    foo.spine_effect:show()
                    foo.spine_effect:addMEListener(TFARMATURE_COMPLETE,function()
                            foo.panel_root:show()
                        end)
                    foo.spine_effect:play("animation",0)
                end),
        }
        foo.root:runAction(CCSequence:create(seq))
    end
end

function SummonContractMainView:playStageChallengeEffect()
    self.particle_effect:setPosition(ccp(568,320))
    self.particle_effect:show()
    self.ui:setAnimationCallBack("particle_ani", TFANIMATION_END, function()
            self.spine_effect:addMEListener(TFARMATURE_COMPLETE,function()
                            self.spine_effect:removeMEListener(TFARMATURE_COMPLETE)
                            self.spine_effect:play("animation3",1)
                        end)
            self.spine_effect:show()
            self.spine_effect:play("animation2",0)
            self.particle_effect:hide()
        end)
    self.ui:runAnimation("particle_ani",1)

    self:showTaskItemEffect()
    self.GridView_task.scrollView_:scrollToTop()
end

return SummonContractMainView
