--[[
    @descï¼šWorldBossRankAwardView
]]

local WorldBossRankAwardView = class("WorldBossRankAwardView",BaseLayer)

function WorldBossRankAwardView:initData(curSelectIdx, type, personHurt)
    self.taskItems = {}
    self.curSelectIdx = curSelectIdx or 1
    self.type = type
    self.personHurt = personHurt
end

function WorldBossRankAwardView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.league.worldBossRankAwardView")
end

function WorldBossRankAwardView:initUI(ui)
    self.super.initUI(self,ui)
    self.taskView = UIListView:create(self._ui.ScrollView_members)
    local bar = UIScrollBar:create(self._ui.Image_scrollBar1, self._ui.Image_innerScrollBar1)
    self.taskView:setScrollBar(bar)
    self.taskView:setItemsMargin(5)
    self.awardsView = UIListView:create(self._ui.ScrollView_leagueAward)
    self.awardsView:setItemsMargin(5)
    local bar = UIScrollBar:create(self._ui.Image_scrollBar2, self._ui.Image_innerScrollBar2)
    self.awardsView:setScrollBar(bar)

    self:refreshTaskView()
    self:refreshAwardView()
    self:choosePanel(self.curSelectIdx)
end

function WorldBossRankAwardView:registerEvents()
    self._ui.Button_close:onClick(function()
        AlertManager:close(self)
    end)

    for i, btn in ipairs(self._ui.Panel_btns:getChildren()) do
        local idx = string.gsub(btn:getName(), "btn_", "") 
        idx = tonumber(idx)
        btn:onClick(function()
            self:choosePanel(idx)
        end)
    end

    EventMgr:addEventListener(self, EV_TASK_UPDATE, handler(self.refreshTaskView, self))
    EventMgr:addEventListener(self, EV_TASK_RECEIVE, handler(self.onTaskReceiveEvent, self))
end

function WorldBossRankAwardView:addTaskItem()
    local item = self._ui.Panel_taskItem:clone()
    local foo = {}
    foo.root = item
    foo.Label_name = TFDirector:getChildByPath(foo.root, "Label_name")
    foo.lab_num = TFDirector:getChildByPath(foo.root, "lab_num")
    foo.Button_receive = TFDirector:getChildByPath(foo.root, "Button_receive")
    foo.Label_ing = TFDirector:getChildByPath(foo.root, "Label_ing")
    foo.Label_geted = TFDirector:getChildByPath(foo.root, "Label_geted")
    foo.Image_complete = TFDirector:getChildByPath(foo.root, "Image_complete")
    foo.listAward = UIListView:create(TFDirector:getChildByPath(foo.root, "ScrollView_award"))
    foo.listAward:setItemsMargin(10)
    self.taskItems[item] = foo
    self.taskView:pushBackCustomItem(item)
end

function WorldBossRankAwardView:refreshTaskView()
    local taskList = TaskDataMgr:getTask(EC_TaskType.WORLD_BOSS)
    local num = #taskList - table.count(self.taskView:getItems())
    for i = 1, math.abs(num) do
        if num > 0 then
            self:addTaskItem()
        else
            self.taskView:removeItem(1)
        end 
    end

    local items = self.taskView:getItems()
    for i, v in ipairs(items) do
        local item = self.taskItems[v]
        local taskInfo = TaskDataMgr:getTaskInfo(taskList[i])
        local taskCfg = TaskDataMgr:getTaskCfg(taskList[i])

        if self.type and self.type == 2 then
            item.Button_receive:setVisible(false)
            item.Image_complete:setVisible(false)
            item.Label_ing:setVisible(self.personHurt < taskCfg.progress)
            item.Label_geted:setVisible(self.personHurt >= taskCfg.progress)
        else
            item.Button_receive:setVisible(taskInfo.status == EC_TaskStatus.GET)
            item.Image_complete:setVisible(taskInfo.status == EC_TaskStatus.GET)
            item.Label_ing:setVisible(taskInfo.status == EC_TaskStatus.ING)
            item.Label_geted:setVisible(taskInfo.status == EC_TaskStatus.GETED)
        end

        item.lab_num:setText(taskCfg.progress / 10000 .. "w" )
        item.Button_receive:onClick(function()
            TaskDataMgr:send_TASK_SUBMIT_TASK(taskInfo.cid)
        end)

        local awards = taskCfg.reward
        item.listAward:removeAllItems()
        for i, goodsData in ipairs(awards) do
            local goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            goods:setScale(0.6)
            PrefabDataMgr:setInfo(goods, goodsData[1], goodsData[2])
            item.listAward:pushBackCustomItem(goods)
        end
    end

    if self.personHurt then
        self._ui.lab_biggestHurtNum:setText(Utils:converNumWithComma(self.personHurt))
    else
        local _, num = LeagueDataMgr:getIsRewardsAndMaxNum()
        self._ui.lab_biggestHurtNum:setText(Utils:converNumWithComma(num))
    end
end

function WorldBossRankAwardView:refreshAwardView()
    local awardsData = Utils:getKVP(51101, "rewardList")
    for i, data in ipairs(awardsData) do
        local item = self._ui.Panel_awardItem:clone()
        local img_icon = TFDirector:getChildByPath(item, "img_icon"):hide()
        local Label_rank = TFDirector:getChildByPath(item, "Label_rank")
        local listView = UIListView:create(TFDirector:getChildByPath(item,"ScrollView_award"))
        Label_rank:setSkewX(15)
        listView:setItemsMargin(5)
        local rankTxt = ""
        if data.rank[1] == data.rank[2] then 
            rankTxt = data.rank[1]

            local iconSrc
            if rankTxt == 1 then
                iconSrc = "ui/league/worldBoss/13.png"
            elseif rankTxt == 2 then
                iconSrc = "ui/league/worldBoss/14.png"
            elseif rankTxt == 3 then
                iconSrc = "ui/league/worldBoss/15.png"
            end
            if iconSrc then
                img_icon:setTexture(iconSrc)
                img_icon:show()
            end
        else
            if data.rank[2] ~= 0 then
                rankTxt = data.rank[1].."~"..data.rank[2]
            else
                rankTxt = data.rank[1].." +"
            end
            Label_rank:disableStroke(true)
        end
        Label_rank:setText(rankTxt)
        
        for goodsId, value in pairs(data.reward) do
            local goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            goods:setScale(0.6)
            PrefabDataMgr:setInfo(goods, goodsId, value)
            listView:pushBackCustomItem(goods)
        end
        self.awardsView:pushBackCustomItem(item)
    end
end

function WorldBossRankAwardView:choosePanel(idx)
    for i, btn in ipairs(self._ui.Panel_btns:getChildren()) do
        local tag = string.gsub(btn:getName(), "btn_", "") 
        tag = tonumber(tag)
        TFDirector:getChildByPath(btn, "img_select"):setVisible(idx == tag)
        self._ui["Panel_"..tag]:setVisible(idx == tag)
    end
    self.curSelectIdx = idx
end

function WorldBossRankAwardView:onTaskReceiveEvent(reward)
    Utils:showReward(reward)
end

return WorldBossRankAwardView