--[[
    @desc: 全服应援主界面
]]

local AllServerAssistanceMainView = class("AllServerAssistanceMainView", BaseLayer)

local Panel_Tag = {
    [1] = "task",     -- 任务
    [2] = "progress", -- 进度
    [3] = "rank"      -- 社团
}

function AllServerAssistanceMainView:initData()
    ActivityDataMgr:sendWORLD_HELP_REQ_REWARD_RECORD()
    ActivityDataMgr:sendWORLD_HELP_REQ_RANK_INFO(2)

    self.listViewTaskItems = {}
    self.allServerProgressItems = {}
    self.personProgressItems = {}

    self.activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.ALLSERVER_ASSISTANCE)[1]
    self.activityInfo =  ActivityDataMgr2:getActivityInfo(self.activityId)
end

function AllServerAssistanceMainView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.allServerAssistanceMainView")
end

function AllServerAssistanceMainView:initUI(ui)
    self.super.initUI(self,ui)

    self.listViewTask = UIListView:create(self._ui.ScrollView_Task)
    local bar = UIScrollBar:create(self._ui.Image_scrollBarModel, self._ui.Image_scrollBarInner)
    self.listViewTask:setScrollBar(bar)
    self.listViewTask:setItemsMargin(5)

    self.listAllServer = UIListView:create(self._ui.ScrollView_progress)
    self.listAllServer:setItemsMargin(5)

    self.listAllPerson = UIListView:create(self._ui.ScrollView_personList)
    self.listAllPerson:setItemsMargin(0)

    self.rankTableView = Utils:scrollView2TableView(self._ui.ScrollView_rank)
    self.rankTableView:hide()

    self._ui.panel_personItems:hide()
    self._ui.item_allServerProgress:hide()

    local curTime = ServerDataMgr:getServerTime()
    local txtId, lastTime
    if curTime < self.activityInfo.extendData.time then
        txtId = 63805
        lastTime = self.activityInfo.extendData.time - curTime
    else
        txtId = 63806
        lastTime = self.activityInfo.endTime - curTime
    end
    self._ui.lab_statusTag:setTextById(txtId)

    local hours = math.floor(lastTime / 3600)
    local hourTxt = hours % 24
    local dayTxt = (hours - hourTxt) / 24
    self._ui.lab_timeDay1:setText(dayTxt)
    self._ui.lab_timeDay2:setText(dayTxt)
    self._ui.lab_timeDay3:setText(dayTxt)
    self._ui.lab_timeHour1:setText(hourTxt)
    self._ui.lab_timeHour2:setText(hourTxt)
    self._ui.lab_timeHour3:setText(hourTxt)
end

function AllServerAssistanceMainView:registerEvents()
    for i, btn in ipairs(self._ui.panel_btns:getChildren()) do
        local btnName = btn:getName()
        local tag = string.gsub(btnName,"btn_","")
        btn:onClick(function()
            self:choosePanelByTag(tag)
        end)
    end

    self._ui.btn_showDetails:onClick(function()
        Utils:openView("activity.AllServerPersonRankView")
    end)

    EventMgr:addEventListener(self, EV_ALLSERVER_ASSISTANCE_RANK, handler(self.onRecvRankData,self))
    EventMgr:addEventListener(self, EV_ALLSERVER_ASSISTANCE_AWARD, handler(self.onRecvGetAward,self))
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.refreshTaskView, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.updatePersonProgres, self))

    self.rankTableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.rankCellSize,self))
    self.rankTableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCells,self))
    self.rankTableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex,self))

    self:choosePanelByTag(Panel_Tag[1])
end

function AllServerAssistanceMainView:onRecvRankData(data)
    if data.type == 2 then
        self.rankData = data
        self.rankData.rank = self.rankData.rank or {}
        table.sort(self.rankData.rank, function(a, b)
            return a.rank < b.rank
        end)
    end
end

function AllServerAssistanceMainView:onRecvGetAward(type)
    if type == 1 then
        self:updatePersonProgres()
    elseif type == 2 then
        self:updateAllServerProgres()
    end
end

function AllServerAssistanceMainView:onSubmitSuccessEvent(activitId, itemId, reward)
    Utils:showReward(reward)
end

function AllServerAssistanceMainView:rankCellSize()
    local size = self._ui.item_rank:getContentSize()
    return size.height, size.width
end

function AllServerAssistanceMainView:numberOfCells()
    return #self.rankData.rank 
end

function AllServerAssistanceMainView:tableCellAtIndex(tableView, idx)
    local cell = tableView:dequeueCell()
    local item = nil
	if nil == cell then
        cell = TFTableViewCell:create()
        item = self._ui.item_rank:clone()
		item.idx = idx
        item:show()
        item:setPosition(ccp(0,0))
        cell:addChild(item)
        cell.item = item	
	else
		item = cell.item
    end
	self:refreshCell(item, idx + 1)
    return cell
end

function AllServerAssistanceMainView:refreshCell(item, idx)
    local data = self.rankData.rank[idx]

    local bg = TFDirector:getChildByPath(item, "bg")
    local lab_rankNum = TFDirector:getChildByPath(item, "lab_rankNum")
    local icon = TFDirector:getChildByPath(item, "icon")
    local lab_name = TFDirector:getChildByPath(item, "lab_name")
    local lab_channel = TFDirector:getChildByPath(item, "lab_channel")
    local lab_sorce = TFDirector:getChildByPath(item, "lab_sorce")
    local panel_rewards = TFDirector:getChildByPath(item, "panel_rewards")
    lab_sorce:setSkewX(15)

    if idx % 2 ==0 then
        bg:setTexture("ui/activity/allServerAssistance/rank/004.png")
    else
        bg:setTexture("ui/activity/allServerAssistance/rank/003.png")
    end
    lab_rankNum:setText(data.rank)
    lab_sorce:setText(data.score)
    local emblemCfg = LeagueDataMgr:getEmblemCfgById(data.unionIcon or 101)
    icon:setTexture(emblemCfg.icon)
    icon:setSize(CCSizeMake(80,80))
    lab_name:setText(data.name)

    if not panel_rewards.items then
        panel_rewards.items = {}
        for i = 1, table.count(panel_rewards:getChildren()) do
            local goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            goods:setScale(0.5)
            goods:AddTo(TFDirector:getChildByPath(panel_rewards,string.format("pos_%s", i))):Pos(ccp(0, 0))
            table.insert(panel_rewards.items, goods)
        end
    end
    
    local awards = self:getAwardsByRankIdx(data.rank)
    for i, goods in ipairs(panel_rewards.items) do
        goods:setVisible(nil ~= awards[i])
        if awards[i] then
            if goods.ListView_star then
                goods.ListView_star:removeAllItems()
            end
            goods.ListView_star   = nil
            PrefabDataMgr:setInfo(goods,awards[i].id, awards[i].num)
        end
    end
end

function AllServerAssistanceMainView:choosePanelByTag(tag)
    for i, btn in ipairs(self._ui.panel_btns:getChildren()) do
        local btnName = btn:getName()
        local _tag = string.gsub(btnName,"btn_","") 
        local img_select = TFDirector:getChildByPath(btn, "img_select")
        local img_iconNormol = TFDirector:getChildByPath(btn, "img_iconNormol")
        img_select:setVisible(tag == _tag)
        img_iconNormol:setVisible(not img_select:isVisible())
    end

    local panelChooseFunc = {
        [Panel_Tag[1]] = function()
            if table.count(self.listViewTaskItems) == 0 then
                self:refreshTaskView()
            end
        end,
        [Panel_Tag[2]] = function()
            if table.count(self.allServerProgressItems) == 0 or table.count(self.personProgressItems) == 0 then
                self:initProgressPanel()
            end
        end,
        [Panel_Tag[3]] = function()
            if not self.rankTableView:isVisible() then
                self:refreshRankView()
            end
        end,
    }
    local func = panelChooseFunc[tag]
    if nil == func then
        Box("传入Tag没有对应方法~")
    else
        func()
    end

    for i, panel in ipairs(self._ui.panel_contents:getChildren()) do
        panel:setVisible(panel:getName() == string.format("panel_%s",tag))
    end
end

function AllServerAssistanceMainView:addTaskItem()
    local item_task = self._ui.item_task:clone()
    local foo = {}
    foo.rewards = {}
    foo.root = item_task
    foo.bg_dayRefresh = TFDirector:getChildByPath(foo.root, "bg_dayRefresh")
    foo.bg_noRefresh = TFDirector:getChildByPath(foo.root, "bg_noRefresh")
    foo.bg_hadGetted = TFDirector:getChildByPath(foo.root, "bg_hadGetted")
    foo.panel_taskItemContent = TFDirector:getChildByPath(foo.root, "panel_taskItemContent")
    foo.lab_taskItemDisc = TFDirector:getChildByPath(foo.panel_taskItemContent, "lab_taskItemDisc")
    foo.lab_taskItemProgressNum = TFDirector:getChildByPath(foo.panel_taskItemContent, "lab_taskItemProgressNum")
    foo.btn_taskItemGo = TFDirector:getChildByPath(foo.panel_taskItemContent, "btn_taskItemGo")
    foo.btn_taskItemGet = TFDirector:getChildByPath(foo.panel_taskItemContent, "btn_taskItemGet")
    foo.lab_taskItemHadGetted = TFDirector:getChildByPath(foo.panel_taskItemContent, "lab_taskItemHadGetted")
    local bg_taskItemRewards = TFDirector:getChildByPath(foo.panel_taskItemContent, "bg_taskItemRewards")
    for i, v in ipairs(bg_taskItemRewards:getChildren()) do
        local goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        goodsItem:setScale(0.7)
        goodsItem:AddTo(v):Pos(0,0):ZO(1)
        foo.rewards[i] = goodsItem
    end
    self.listViewTaskItems[foo.root] = foo
    return item_task
end

function AllServerAssistanceMainView:refreshTaskView()
     -- 成就列表
    local itemIds = {}
    for i, id in ipairs(self.activityInfo.items) do
        local info = ActivityDataMgr2:getItemInfo(EC_ActivityType2.ALLSERVER_ASSISTANCE, id)
        local curTime = ServerDataMgr:getServerTime() * 1000
        if curTime >= info.extendData.stime and curTime <= info.extendData.etime then
            table.insert(itemIds, id)
        end
    end
    table.sort(itemIds, function(idA, idB)
        local progressInfoA = ActivityDataMgr2:getProgressInfo(EC_ActivityType2.ALLSERVER_ASSISTANCE, idA)
        local progressInfoB = ActivityDataMgr2:getProgressInfo(EC_ActivityType2.ALLSERVER_ASSISTANCE, idB)
        if progressInfoA.status == progressInfoB.status then
            return idA < idB
        elseif progressInfoA.status == EC_TaskStatus.GETED then
            return false
        elseif progressInfoB.status == EC_TaskStatus.GETED then
            return true
        elseif progressInfoA.status == EC_TaskStatus.GET then
            return true
        elseif progressInfoB.status == EC_TaskStatus.GET then
            return false
        end
    end)

    local taskCount = table.count(itemIds)
    local items = self.listViewTask:getItems()
    local gap = taskCount - #items
    if gap > 0 then
        for i = 1, math.abs(gap) do
            local taskItem = self:addTaskItem()
            self.listViewTask:pushBackCustomItem(taskItem)
        end
    else
        for i = 1, math.abs(gap) do
            self.listViewTask:removeItem(1)
        end
    end

    for i, v in ipairs(self.listViewTask:getItems()) do
        local taskId = itemIds[i]
        local itemInfo = ActivityDataMgr2:getItemInfo(EC_ActivityType2.ALLSERVER_ASSISTANCE, taskId)
        local progressInfo = ActivityDataMgr2:getProgressInfo(EC_ActivityType2.ALLSERVER_ASSISTANCE, taskId)
        local item = self.listViewTaskItems[v]
        local awards = {}
        for _id, _num in pairs(itemInfo.reward) do
            table.insert(awards, {id = _id, num = _num})
        end
        item.lab_taskItemDisc:setText(itemInfo.extendData.des2)
        for i, goods in ipairs(item.rewards) do
            local award = awards[i]
            goods:setVisible(nil ~= award)
            if award then
                PrefabDataMgr:setInfo(goods, award.id, award.num)
            end
        end
        item.lab_taskItemProgressNum:setText(progressInfo.progress.."/"..itemInfo.target)
        item.bg_dayRefresh:setVisible(itemInfo.extendData.resetType ~= 1)
        item.bg_noRefresh:setVisible(itemInfo.extendData.resetType == 1)
        item.bg_hadGetted:setVisible(progressInfo.status == EC_TaskStatus.GETED)
        item.btn_taskItemGo:setVisible(progressInfo.status == EC_TaskStatus.ING)
        item.btn_taskItemGet:setVisible(progressInfo.status == EC_TaskStatus.GET)
        item.lab_taskItemHadGetted:setVisible(progressInfo.status == EC_TaskStatus.GETED)

        item.btn_taskItemGo:onClick(function()
            -- 策划说的 这里写死 
            if itemInfo.extendData.jumpInterface == 95 then
                if FunctionDataMgr:checkFuncOpen(itemInfo.extendData.jumpInterface) then
                    if not LeagueDataMgr:checkSelfInUnion() then
                        Utils:showTips(63824)
                        return
                    end
                else
                    return
                end
            end

            FunctionDataMgr:enterByFuncId(itemInfo.extendData.jumpInterface)
        end)

        item.btn_taskItemGet:onClick(function()
            ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(progressInfo.id, taskId)
        end)
    end
end

function AllServerAssistanceMainView:initProgressPanel()
    local _count1 = table.count(self.activityInfo.extendData.world.score)
    for i = 1, _count1 do
        local item = self._ui.item_allServerProgress:clone()
        item:show()
        local foo = {}
        foo.root = item
        foo.bg_normal = TFDirector:getChildByPath(item, "bg_normal")
        foo.lab_num1 = TFDirector:getChildByPath(foo.bg_normal, "lab_num")
        foo.lab_numLast1 = TFDirector:getChildByPath(foo.bg_normal, "lab_numLast")
        foo.lab_ing = TFDirector:getChildByPath(foo.bg_normal, "lab_ing")
        foo.img_complete = TFDirector:getChildByPath(foo.bg_normal, "img_complete")
        foo.bg_canGet = TFDirector:getChildByPath(item, "bg_canGet")
        foo.lab_num2 = TFDirector:getChildByPath(foo.bg_canGet, "lab_num")
        foo.lab_numLast2 = TFDirector:getChildByPath(foo.bg_canGet, "lab_numLast")
        foo.bg_hadGetted = TFDirector:getChildByPath(item, "bg_hadGetted")
        foo.bar_allServerProgress = TFDirector:getChildByPath(item, "img_barDi.bar_allServerProgress")
        self.listAllServer:pushBackCustomItem(item)
        self.allServerProgressItems[foo.root] = foo
    end

    local _count2 = table.count(self.activityInfo.extendData.personal.score)
    for i = 1, _count2 do
        local personItem = self._ui.panel_personItems:clone()
        personItem:show()
        -- local size = self._ui.bar_personProgress:getContentSize()
        -- personItem:AddTo(self._ui.img_personProgressDi)
        -- personItem:setPositionX(size.width / _count2 * i - 30)
        local foo = {}
        foo.root = personItem
        foo.btn_notGet = TFDirector:getChildByPath(foo.root, "btn_notGet")
        foo.btn_canGet = TFDirector:getChildByPath(foo.root, "btn_canGet")
        foo.btn_getted = TFDirector:getChildByPath(foo.root, "btn_getted")
        foo.bar_person = TFDirector:getChildByPath(foo.root, "img_personDi.bar_person")
        foo.lab_num = TFDirector:getChildByPath(foo.root, "img_personDi.lab_num")
        self.listAllPerson:pushBackCustomItem(personItem)
        self.personProgressItems[foo.root] = foo
    end
    self._ui.lab_progressDisc:setTextById(63803)

    self:updateAllServerProgres()
    self:updatePersonProgres()
end

function AllServerAssistanceMainView:isDataExistByIdx(data, idx)
    local _bool = false
    for i, v in ipairs(data) do
        if (idx - 1) == v then
            _bool = true
            break
        end
    end
    return _bool
end

function AllServerAssistanceMainView:updateAllServerProgres()
    local scoreData = ActivityDataMgr:getAllServerAsScoreData()
    local serverRecords = scoreData.serverRecord or {}
    local scores = self.activityInfo.extendData.world.score
    local rewards = self.activityInfo.extendData.world.reward
    local maxScore = scores[table.count(scores)][1]
    local curServerScore = tonumber(scoreData.serverScore)
    local percent = curServerScore / maxScore
    percent = percent > 1 and 1 or percent
    self._ui.lab_allServerPercent:setString(string.format( "%0.2f", percent*100)  .."%")
    self._ui.lab_progressNum:setText(curServerScore.."/"..maxScore)

    for i , v in ipairs(self.listAllServer:getItems()) do
        local item = self.allServerProgressItems[v]

        local _score = scores[i][1]
        local lastNum = _score % 10000
        local shiWanNum = (_score - lastNum) / 100000

        item.lab_num1:setText(shiWanNum)
        item.lab_num2:setText(shiWanNum)
        item.lab_numLast1:setText(lastNum)
        item.lab_numLast2:setText(lastNum)
        local isHadGet = self:isDataExistByIdx(serverRecords, i)
        local curPersonScore = GoodsDataMgr:getItemCount(self.activityInfo.extendData.itemId)
        local awardScoreLimit = self.activityInfo.extendData.awardLimit
        local status
        if curServerScore < _score then  -- 进行中
            status = EC_TaskStatus.ING
            item.bg_normal:setTexture("ui/activity/allServerAssistance/progress/008.png")
        else
            if not isHadGet then -- 可领取
                status = EC_TaskStatus.GET
            else                 -- 已领取
                status = EC_TaskStatus.GETED
                item.bg_normal:setTexture("ui/activity/allServerAssistance/progress/015.png")
            end
        end
        item.lab_ing:setVisible(status == EC_TaskStatus.ING)
        item.img_complete:setVisible(status == EC_TaskStatus.GET or status == EC_TaskStatus.GETED)
        item.bg_normal:setVisible(status == EC_TaskStatus.ING or status == EC_TaskStatus.GETED)
        item.bg_canGet:setVisible(status == EC_TaskStatus.GET)
        item.bg_hadGetted:setVisible(status == EC_TaskStatus.GETED)

        local _percent = 0
        if i == 1 then
            _percent = curServerScore / _score
        else
            local lastScore  = scores[i - 1][1]
            if curServerScore > lastScore then
                _percent = (curServerScore - lastScore)/(_score - lastScore)
            end
        end
        _percent = _percent > 1 and 1 or _percent
        item.bar_allServerProgress:setPercent(_percent * 100)

        item.bg_canGet:setTouchEnabled(true)
        item.bg_canGet:onClick(function()
            if curPersonScore >= awardScoreLimit then
                ActivityDataMgr:sendWORLD_HELP_REQ_TAKE_REWARD(i, 2)
            else
                Utils:showTips(63812)
            end
        end)
        
        item.bg_normal:setTouchEnabled(true)
        item.bg_normal:onClick(function()
            local tmp = {}
            for _id, _num in pairs(rewards[i]) do
                table.insert(tmp,  {id = tonumber(_id), num = _num})
            end
            Utils:previewReward(nil, tmp)
        end)
    end
end

function AllServerAssistanceMainView:updatePersonProgres()
    local scoreData = ActivityDataMgr:getAllServerAsScoreData()
    local personRecords = scoreData.personalRecord or {}
    local scores = self.activityInfo.extendData.personal.score
    local rewards = self.activityInfo.extendData.personal.reward
    local maxScore = scores[table.count(scores)][1]
    local curPersonScore = GoodsDataMgr:getItemCount(self.activityInfo.extendData.itemId)
    local percent = curPersonScore / maxScore
    percent = percent > 1 and 1 or percent
    self._ui.lab_progressPersonCurNum:setText(curPersonScore)
    self._ui.lab_progressPersonNum:setText("/"..maxScore)
    self._ui.lab_personPercent:setText(string.format( "%0.2f", percent*100)  .."%")

    for  i , v in ipairs(self.listAllPerson:getItems()) do 
        local item = self.personProgressItems[v]
        local _score = scores[i][1]

        item.lab_num:setText(_score)

        local isHadGet = self:isDataExistByIdx(personRecords, i)
        local state 
        if curPersonScore < _score then 
            state = EC_Assist_Item_Status.ING
        else
            if not isHadGet then 
                state = EC_Assist_Item_Status.GET
            else                 
                state = EC_Assist_Item_Status.GETED
            end
        end
        item.btn_notGet:setVisible(state == EC_Assist_Item_Status.ING)
        item.btn_canGet:setVisible(state == EC_Assist_Item_Status.GET)
        item.btn_getted:setVisible(state == EC_Assist_Item_Status.GETED) 

        local _percent = 0
        if i == 1 then
            _percent = curPersonScore / _score
        else
            local lastScore  = scores[i - 1][1]
            if curPersonScore > lastScore then
                _percent = (curPersonScore - lastScore)/(_score - lastScore)
            end
        end
        _percent = _percent > 1 and 1 or _percent
        if _percent == 1 then
            item.lab_num:setColor(ccc3(73,83,125))
        else
            item.lab_num:setColor(me.WHITE)
        end
        item.bar_person:setPercent(_percent * 100)

        item.btn_notGet:onClick(function()
            local tmp = {}
            for _id, _num in pairs(rewards[i]) do
                table.insert(tmp,  {id = tonumber(_id), num = _num})
            end
            Utils:previewReward(nil, tmp)
        end)
        item.btn_canGet:onClick(function()
             ActivityDataMgr:sendWORLD_HELP_REQ_TAKE_REWARD(i, 1)
        end)
    end
end

function AllServerAssistanceMainView:getAwardsByRankIdx(rankIdx)
    local tmpIdx 
    local awards = {}
    local unionData = self.activityInfo.extendData.union
    for i, v in ipairs(unionData.rank) do
        if #v == 1 then
            if v[1] == rankIdx then
                tmpIdx = i
                break
            end
        else
            if v[1] <= rankIdx and rankIdx <= v[2] then
                tmpIdx = i
                break
            end
        end
    end
    if tmpIdx then
        for _id , _num in pairs(unionData.reward[tmpIdx]) do
            table.insert(awards,{id = tonumber(_id), num = _num})
        end
    end
    return awards
end

function AllServerAssistanceMainView:refreshRankView()
    if not self.rankData then
        return
    end

    self.rankTableView:reloadData()
    self.rankTableView:show()
    
    -- 我的社团排名
    self._ui.lab_mySorce:setSkewX(15)
    local myRankData = self.rankData.myUnionRank
    if not myRankData then  -- 没有社团
        self._ui.panne_myRank:hide()
        self._ui.btn_showDetails:setTouchEnabled(false)
        self._ui.lab_showDetails:setTextById(63804)
        self.rankTableView:setPositionY(self._ui.panne_myRank:getPositionY())
        local size = self.rankTableView:getViewSize()
        self.rankTableView:setViewSize(ccs(size.width, size.height + self._ui.panne_myRank:getContentSize().height))
        local contentSize = self.rankTableView:getContentSize()
        self.rankTableView:setContentOffsetInDuration(ccp(0,-contentSize.height),0)
        return
    end
    local txt
    if myRankData.rank > self.activityInfo.extendData.unionCount then
        txt = TextDataMgr:getText(14240013)
    else
        txt = myRankData.rank
    end
    self._ui.lab_myRankNum:setText(txt)
    local emblemCfg = LeagueDataMgr:getEmblemCfgById(myRankData.unionIcon or 101)
    self._ui.myIcon:setTexture(emblemCfg.icon)
    self._ui.myIcon:setSize(CCSizeMake(80,80))
    self._ui.lab_mySorce:setText(myRankData.score)
    self._ui.lab_myName:setText(myRankData.name)
    local awards = self:getAwardsByRankIdx(myRankData.rank)
    for i = 1, table.count(awards) do
        local goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        PrefabDataMgr:setInfo(goods,awards[i].id, awards[i].num)
        goods:setScale(0.5)
        goods:AddTo(TFDirector:getChildByPath(self._ui.panel_myRewards,string.format("pos_%s", i))):Pos(ccp(0,0))

    end 
end

return AllServerAssistanceMainView