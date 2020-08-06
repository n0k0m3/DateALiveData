
local FubenEndlessView = class("FubenEndlessView", BaseLayer)

function FubenEndlessView:initData(chapterCid)
    self.chapterCid_ = chapterCid
    self.chapterCfg_ = FubenDataMgr:getChapterCfg(chapterCid)

    local endlessInfo = FubenDataMgr:getEndlessInfo()
    local endlessCfg = FubenDataMgr:getEndlessCloisterLevelCfg(endlessInfo.curStage)
    self.endlessCloisterLevel_ = FubenDataMgr:getEndlessCloisterLevel(endlessCfg.week)
    self.perStage_ = 10
    self.selectIndex_ = math.ceil(endlessInfo.todayBest / self.perStage_)
    if self.selectIndex_ == 0 then
        self.selectIndex_ = 1
    end

    self.defalutSelectTabIndex_ = 1
    --屏蔽竞速模式
    -- if FubenDataMgr:isEndlessRacingMode(endlessInfo.curStage) then
    --     self.defalutSelectTabIndex_ = 2
    -- end

    self.costCid_ = 570005
    self.countDownTimer_ = nil
    self.racingRankData_ = {}
    self.normalMaxLevel_ = FubenDataMgr:getEndlessNormalMaxLevel()

    FubenDataMgr:cacheSelectChapter(self.chapterCid_)
    FubenDataMgr:cacheSelectFubenType(EC_FBType.ACTIVITY)
    FubenDataMgr:send_ENDLESS_CLOISTER_REQ_ENDLESS_RANK_LIST()

    if endlessInfo.step == EC_EndlessState.ING then
        self:timeOut(
            function()
                if endlessInfo.nonStopStage ~= 0 then
                    Utils:openView("fuben.FubenEndlessJumpView")
                else  --【屏蔽提示通关
                    -- local levelCid = FubenDataMgr:getCurLevelCid()
                    -- if levelCid then
                    --     local levelCfg = FubenDataMgr:getEndlessCloisterLevelCfg(levelCid)
                    --     if levelCfg and levelCfg.order == self.normalMaxLevel_ and endlessInfo.todayBest >= self.normalMaxLevel_ then
                    --         local tips = TextDataMgr:getText(310025)
                    --         showMessageBox(tips, EC_MessageBoxType.ok)
                    --         FubenDataMgr:setCurLevelCid(nil)
                    --     end
                    -- end
                end
            end,
            0
        )
    end
end

function FubenEndlessView:getClosingStateParams()
    return {FubenDataMgr.selectChapter_}
end

function FubenEndlessView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.fuben.fubenEndlessView")
end

function FubenEndlessView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_rewardItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_rewardItem")
    self.Panel_rankItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_rankItem")
    self.Panel_rankRewardItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_rankRewardItem")

    self.Panel_normal_mode = TFDirector:getChildByPath(self.Panel_root, "Panel_normal_mode")
    local Image_normal_icon = TFDirector:getChildByPath(self.Panel_normal_mode, "Image_normal_icon")
    self.Label_name_title = TFDirector:getChildByPath(Image_normal_icon, "Label_name_title")
    self.Label_name = TFDirector:getChildByPath(Image_normal_icon, "Label_name")
    self.Label_status = TFDirector:getChildByPath(Image_normal_icon, "Label_status")
    self.Label_countDown = TFDirector:getChildByPath(Image_normal_icon, "Label_countDown")
    local Image_reward_title = TFDirector:getChildByPath(self.Panel_normal_mode, "Image_reward_title")
    self.Label_rewardTitle = TFDirector:getChildByPath(Image_reward_title, "Label_rewardTitle")
    self.Label_levelTitle = TFDirector:getChildByPath(Image_reward_title, "Label_levelTitle")
    local Image_desc = TFDirector:getChildByPath(self.Panel_normal_mode, "Image_desc")
    self.Label_desc_title = TFDirector:getChildByPath(Image_desc, "Label_desc_title")
    self.Label_desc = TFDirector:getChildByPath(Image_desc, "Label_desc")
    local Image_raiders = TFDirector:getChildByPath(self.Panel_normal_mode, "Image_raiders")
    self.Label_raiders_title = TFDirector:getChildByPath(Image_raiders, "Label_raiders_title")
    self.Label_raiders = TFDirector:getChildByPath(Image_raiders, "Label_raiders")
    local Image_normal_reward = TFDirector:getChildByPath(self.Panel_normal_mode, "Image_normal_reward")
    local Image_scrollBar = TFDirector:getChildByPath(Image_normal_reward, "Image_scrollBar")
    local Image_scrollBarInner = TFDirector:getChildByPath(Image_scrollBar, "Image_scrollBarInner")
    local scrollBar = UIScrollBar:create(Image_scrollBar, Image_scrollBarInner)
    local ScrollView_reward = TFDirector:getChildByPath(Image_normal_reward, "ScrollView_reward")
    self.ListView_reward = UIListView:create(ScrollView_reward)
    self.ListView_reward:setScrollBar(scrollBar)

    self.Panel_racing_mode = TFDirector:getChildByPath(self.Panel_root, "Panel_racing_mode")
    local Image_diban = TFDirector:getChildByPath(self.Panel_racing_mode, "Image_diban")
    self.Panel_racing_tab = {}
    self.Panel_tab_rank = TFDirector:getChildByPath(Image_diban, "Panel_tab_rank")
    local item = {}
    item.root = self.Panel_tab_rank
    item.Image_select = TFDirector:getChildByPath(item.root, "Image_select")
    item.Label_name = TFDirector:getChildByPath(item.root, "Label_name")
    self.Panel_racing_tab[1] = item
    self.Panel_tab_reward = TFDirector:getChildByPath(Image_diban, "Panel_tab_reward")
    local item = {}
    item.root = self.Panel_tab_reward
    item.Image_select = TFDirector:getChildByPath(item.root, "Image_select")
    item.Label_name = TFDirector:getChildByPath(item.root, "Label_name")
    self.Panel_racing_tab[2] = item
    self.Image_racing_icon = TFDirector:getChildByPath(self.Panel_racing_mode, "Image_racing_icon")
    self.Panel_racing_rank = TFDirector:getChildByPath(self.Panel_racing_mode, "Panel_racing_rank")
    self.Panel_myRank = TFDirector:getChildByPath(self.Panel_racing_rank, "Panel_myRank")
    self.Panel_myRankItem = self.Panel_rankItem:clone()
    self.Panel_myRankItem:AddTo(self.Panel_myRank):Pos(0, 0):ZO(1)
    self.Label_racing_update_time = TFDirector:getChildByPath(self.Panel_myRank, "Label_racing_update_time"):hide()
    local ScrollView_racing_rank = TFDirector:getChildByPath(self.Panel_racing_rank, "ScrollView_racing_rank")
    self.ListView_racing_rank = UIListView:create(ScrollView_racing_rank)
    self.Panel_racing_reward = TFDirector:getChildByPath(self.Panel_racing_mode, "Panel_racing_reward")
    local ScrollView_racing_reward = TFDirector:getChildByPath(self.Panel_racing_reward, "ScrollView_racing_reward")
    self.ListView_racing_reward = UIListView:create(ScrollView_racing_reward)
    local Image_racing_rewardTitle = TFDirector:getChildByPath(self.Panel_racing_reward, "Image_racing_rewardTitle")
    self.Label_racing_rank = TFDirector:getChildByPath(Image_racing_rewardTitle, "Label_racing_rank")
    self.Label_racing_reward = TFDirector:getChildByPath(Image_racing_rewardTitle, "Label_racing_reward")
    local ScrollView_racing_rank = TFDirector:getChildByPath(self.Panel_racing_reward, "ScrollView_racing_rank")

    self.Button_exchangeReward = TFDirector:getChildByPath(self.Panel_root, "Button_exchangeReward")
    self.Label_exchangeReward = TFDirector:getChildByPath(self.Button_exchangeReward, "Label_exchangeReward")
    self.Button_enterPlot = TFDirector:getChildByPath(self.Panel_root, "Button_enterPlot")
    self.Label_enterPlot = TFDirector:getChildByPath(self.Button_enterPlot, "Label_enterPlot")
    local Image_have_diban = TFDirector:getChildByPath(self.Panel_root, "Image_have_diban")
    self.Image_cost_icon = TFDirector:getChildByPath(Image_have_diban, "Image_cost_icon")
    self.Label_cost_num = TFDirector:getChildByPath(Image_have_diban, "Label_cost_num")
    local Image_record = TFDirector:getChildByPath(self.Panel_root, "Image_record")
    self.Label_recordTitle = TFDirector:getChildByPath(Image_record, "Label_recordTitle")
    self.Label_recordTitle_en = TFDirector:getChildByPath(self.Label_recordTitle, "Label_recordTitle_en")
    self.Label_todayRecordTitle = TFDirector:getChildByPath(Image_record, "Label_todayRecordTitle")
    self.Label_todayRecord = TFDirector:getChildByPath(self.Label_todayRecordTitle, "Label_todayRecord")
    self.Label_historyRecordTitle = TFDirector:getChildByPath(Image_record, "Label_historyRecordTitle")
    self.Label_historyRecord = TFDirector:getChildByPath(self.Label_historyRecordTitle, "Label_historyRecord")

    local Image_tab = TFDirector:getChildByPath(self.Panel_root, "Image_tab")
    self.Panel_tab = {}
    for i = 1, 2 do
        local item = {}
        item.root = TFDirector:getChildByPath(Image_tab, "Panel_tab_" .. i)
        item.Image_normal = TFDirector:getChildByPath(item.root, "Image_normal")
        item.Image_select = TFDirector:getChildByPath(item.root, "Image_select")
        item.Label_name = TFDirector:getChildByPath(item.root, "Label_name")
        self.Panel_tab[i] = item
        --屏蔽竞速模式
        if i == 2 then
            item.root:hide()
        end
    end

    self.totalRankBtn = {}
    for i=1,2 do
        local bg = TFDirector:getChildByPath(self.Panel_root, "Image_total_"..i)
        local Label_total_name = TFDirector:getChildByPath(bg, "Label_total_name")
        Label_total_name:setSkewX(15)
        self.totalRankBtn[i] = TFDirector:getChildByPath(bg, "Button_total_rank")
        bg:hide()  --屏蔽排行榜按钮
    end

    self:refreshView()

end

function FubenEndlessView:refreshView()
    self.Label_recordTitle:setTextById(2100003)
    self.Label_todayRecordTitle:setTextById(2100008)
    self.Label_historyRecordTitle:setTextById(2100009)
    self.Label_rewardTitle:setTextById(2100004)
    self.Label_exchangeReward:setTextById(2100005)
    self.Label_enterPlot:setTextById(2100028)
    self.Label_desc_title:setTextById(2100026)
    self.Label_rewardTitle:setTextById(310002)
    self.Label_levelTitle:setTextById(310001)
    self.Label_name_title:setTextById(310010)
    local tabStr = {310003, 310004}
    for i, v in ipairs(self.Panel_tab) do
        v.Label_name:setTextById(tabStr[i])
    end

    local tabStr = {310005, 310006}
    for i, v in ipairs(self.Panel_racing_tab) do
        v.Label_name:setTextById(tabStr[i])
    end
    self.Label_racing_rank:setTextById(310007)
    self.Label_racing_reward:setTextById(310008)

    local costCfg = GoodsDataMgr:getItemCfg(self.costCid_)
    self.Image_cost_icon:setTexture(costCfg.icon)
    self.Label_cost_num:setText(GoodsDataMgr:getItemCount(costCfg.id))

    self:updateEndlessInfo()
    self:addCountDownTimer()

    -- self.Button_newPlayer = TFDirector:getChildByPath(self.Panel_root, "Button_newPlayer")
    -- local activitys = ActivityDataMgr2:getNewPlayerActivityInfo(true)
    -- if #activitys < 1 then
    --     self.Button_newPlayer:setVisible(false)
    -- else
    --     self.Button_newPlayer:setVisible(true)
    --     self.Button_newPlayer:setTouchEnabled(false)
    --     self.Label_newPlayerNumExp = TFDirector:getChildByPath(self.Panel_root, "Label_newPlayerNumExp")
    --     self.Label_newPlayerNumCoin = TFDirector:getChildByPath(self.Panel_root, "Label_newPlayerNumCoin")
    --     local newbleCfg = TabDataMgr:getData("NewbleAdd")
    --     local number = newbleCfg[201].number
    --     if number[1] then
    --         self.Label_newPlayerNumExp:setText(number[1] .. "%")
    --     end
    --     if number[2] then
    --         self.Label_newPlayerNumCoin:setText(number[2] .. "%")
    --     end
    --     self.Image_newPlayerEXP = TFDirector:getChildByPath(self.Panel_root, "Image_newPlayerEXP")
    --     self.Image_newPlayerCoin = TFDirector:getChildByPath(self.Panel_root, "Image_newPlayerCoin")

    --     self.Image_newPlayerEXP:setVisible(number[1])
    --     self.Image_newPlayerCoin:setVisible(number[2])
    --     self.Label_newPlayerNumExp:setVisible(number[1])
    --     self.Label_newPlayerNumCoin:setVisible(number[2])
    -- end
    

    self:selectTab(self.defalutSelectTabIndex_)
end

function FubenEndlessView:selectRacingTab(index)
    if self.selectRacingTabIndex_ == index then return end
    self.selectRacingTabIndex_ = index

    for i, v in ipairs(self.Panel_racing_tab) do
        v.Image_select:setVisible(i == index)
    end

    self.Panel_racing_rank:setVisible(index == 1)
    self.Panel_racing_reward:setVisible(index == 2)

    if self.Panel_racing_rank:isVisible() then
        self:showRacingRank()
    end

    if self.Panel_racing_reward:isVisible() then
        self:showRacingReward()
    end
end

function FubenEndlessView:selectTab(index)
    if self.selectTabIndex_ == index then return end
    self.selectTabIndex_ = index

    for i, v in ipairs(self.Panel_tab) do
        v.Image_normal:setVisible(i ~= index)
        v.Image_select:setVisible(i == index)
    end

    self.Panel_normal_mode:setVisible(index == 1)
    self.Panel_racing_mode:setVisible(index == 2)

    if self.Panel_normal_mode:isVisible() then
        self:showNormalMode()
    end

    if self.Panel_racing_mode:isVisible() then
        self:showRacingMode()
    end
end

function FubenEndlessView:showNormalMode()
    local endlessCfg = FubenDataMgr:getEndlessCloisterLevelCfg(self.endlessCloisterLevel_[1])

    self.Label_raiders:setTextById(endlessCfg.strategyDescribe)
    self.Label_desc:setTextById(endlessCfg.modelDescribe)
    self.Label_name:setTextById(endlessCfg.modelName)

    local showCount = 10
    local maxLevel = math.min(FubenDataMgr:getEndlessNormalMaxLevel(), #self.endlessCloisterLevel_)
    local maxCount = math.floor(maxLevel / self.perStage_)
    showCount = math.min(showCount, maxCount)

    local maxIndex = maxCount
    local midIndex = math.floor(showCount / 2)
    local maxBeginIndex = math.min(self.selectIndex_ + midIndex, maxIndex)
    local minBeginIndex = math.max(self.selectIndex_ - midIndex, 1)
    if self.selectIndex_ - minBeginIndex < maxBeginIndex - self.selectIndex_ then
        beginIndex = minBeginIndex
        endIndex = beginIndex + showCount - 1
    else
        endIndex = maxBeginIndex
        beginIndex = endIndex - showCount + 1
    end

    local items = self.ListView_reward:getItems()
    if #items ~= showCount then
        local selectIndex
        local index = 1
        self.ListView_reward:removeAllItems()
        for i = endIndex, beginIndex, -1 do
            local item = self.Panel_rewardItem:clone()
            self:updateEndlessItem(item, i)
            self.ListView_reward:pushBackCustomItem(item)
            if self.selectIndex_ == i then
                selectIndex = index
            end
            index = index + 1
        end

        selectIndex = selectIndex or maxIndex
        self.ListView_reward:scrollToItem(selectIndex)
    end
end

function FubenEndlessView:showRacingMode()
    self:selectRacingTab(1)
end

function FubenEndlessView:updateEndlessItem(item, index)
    local level = (index - 1) * self.perStage_ + 1
    local levelCid = self.endlessCloisterLevel_[level]
    local endlessCfg = FubenDataMgr:getEndlessCloisterLevelCfg(levelCid)
    local Label_level = TFDirector:getChildByPath(item, "Label_level")
    local Panel_reward = {}
    for i = 1, 3 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(item, "Panel_reward_" .. i)
        foo.Image_icon = TFDirector:getChildByPath(foo.root, "Image_icon")
        foo.Label_count = TFDirector:getChildByPath(foo.root, "Label_count")
        Panel_reward[i] = foo
    end
    local Image_normal = TFDirector:getChildByPath(item, "Image_normal")
    local Image_select = TFDirector:getChildByPath(item, "Image_select")
    local Label_level_normal = TFDirector:getChildByPath(item, "Label_level_normal")
    local Label_level_select = TFDirector:getChildByPath(item, "Label_level_select")

    local isSelect = (index == self.selectIndex_)
    Image_normal:setVisible(not isSelect)
    Image_select:setVisible(isSelect)
    Label_level_normal:setVisible(not isSelect)
    Label_level_select:setVisible(isSelect)

    for i, v in ipairs(Panel_reward) do
        local reward = endlessCfg.floorReward[i]
        if reward then
            v.root:show()
            local goodsCfg = GoodsDataMgr:getItemCfg(reward[1])
            v.Image_icon:setTexture(goodsCfg.icon)
            v.Image_icon:onClick(function()
                    Utils:showInfo(reward[1])
            end)
            v.Label_count:setTextById(800007, reward[2])
        else
            v.root:hide()
        end
    end
    Label_level_normal:setTextById(2100025, level, level + self.perStage_ - 1)
    Label_level_select:setTextById(2100025, level, level + self.perStage_ - 1)
end

function FubenEndlessView:updateEndlessInfo()
    local endlessInfo = FubenDataMgr:getEndlessInfo()
    self.Label_todayRecord:setText(endlessInfo.todayBest)
    self.Label_historyRecord:setText(endlessInfo.historyBest)
    self.Button_enterPlot:setTouchEnabled(endlessInfo.step == EC_EndlessState.ING)
    self.Button_enterPlot:setGrayEnabled(endlessInfo.step ~= EC_EndlessState.ING)

    self:updateCountDonw()
end

function FubenEndlessView:updateCountDonw()
    local endlessInfo = FubenDataMgr:getEndlessInfo()
    local remainTime = math.max(0, endlessInfo.nextStepTime - ServerDataMgr:getServerTime())

    local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
    if day == "00" then
        self.Label_countDown:setTextById(800027, hour, min)
    else
        self.Label_countDown:setTextById(800069, day, hour)
    end
    self.Label_status:setTextById(EC_EndlessStateStr[endlessInfo.step])
end

function FubenEndlessView:showRacingRank()
    local items = self.ListView_racing_rank:getItems()
    local gap = #self.racingRankData_ - #items

    for i = 1, math.abs(gap) do
        if gap < 0 then
            self.ListView_racing_rank:removeItem(1)
        else
            local Panel_rankItem = self.Panel_rankItem:clone()
            self.ListView_racing_rank:pushBackCustomItem(Panel_rankItem)
        end
    end

    for i, v in ipairs(self.racingRankData_) do
        local Panel_rankItem = self.ListView_racing_rank:getItem(i)
        self:updateRacingRankItem(Panel_rankItem, v)
    end

    if self.racingMyRankData_ then
        self.Panel_myRankItem:show()
        self:updateRacingRankItem(self.Panel_myRankItem, self.racingMyRankData_, true)
    else
        self.Panel_myRankItem:hide()
    end

    self.Label_racing_update_time:show():setTextById("r83002", self.refreshRankTime_)
end

function FubenEndlessView:updateRacingRankItem(item, data, isOwn)
    isOwn = tobool(isOwn)
    local Image_normal = TFDirector:getChildByPath(item, "Image_normal")
    local Image_select = TFDirector:getChildByPath(item, "Image_select")
    local Label_rank_normal = TFDirector:getChildByPath(item, "Label_rank_normal")
    local Label_rank_select = TFDirector:getChildByPath(item, "Label_rank_select")
    local Label_name = TFDirector:getChildByPath(item, "Label_name")
    local Label_level = TFDirector:getChildByPath(item, "Label_level")
    local Label_numOfLevel = TFDirector:getChildByPath(item, "Label_numOfLevel")
    local Label_levelDesc = TFDirector:getChildByPath(item, "Label_levelDesc")
    local Label_time = TFDirector:getChildByPath(item, "Label_time")
    local Image_icon = TFDirector:getChildByPath(item, "Image_icon")
    local Image_rank = {}
    for i = 1, 3 do
        Image_rank[i] = TFDirector:getChildByPath(item, "Image_rank_" .. i)
        Image_rank[i]:setVisible(i == data.rank)
    end

    Image_normal:setVisible(not isOwn)
    Image_select:setVisible(isOwn)
    Label_rank_normal:setVisible(not isOwn and data.rank > 3 or data.rank == 0)
    Label_rank_select:setVisible(isOwn and data.rank > 3 or data.rank == 0)
    Label_name:setText(data.pName)
    Label_level:setTextById(800006, data.level)
    Label_numOfLevel:setText(data.stage)
    if data.rank == 0 then
        Label_rank_normal:setTextById(310012)
        Label_rank_select:setTextById(310012)
        local endlessInfo = FubenDataMgr:getEndlessInfo()
        Label_numOfLevel:setText(endlessInfo.todayBest)
        Label_time:hide()
    else
        Label_rank_normal:setText(data.rank)
        Label_rank_select:setText(data.rank)
    end

    if isOwn then
        local icon = AvatarDataMgr:getSelfAvatarIconPath()
        Image_icon:setTexture(icon)
    else
        local headIcon = data.headId
        if headIcon == 0 then
            headIcon = 101
        end
        local icon = AvatarDataMgr:getAvatarIconPath(headIcon)
        Image_icon:setTexture(icon)

        if data.pid ~= MainPlayer:getPlayerId() then
            Image_icon:onClick(function()
                    MainPlayer:sendPlayerId(data.pid)
            end)
        end
    end
    local timestamp = math.floor(data.costTime / 1000)
    local _, hour, min, sec = Utils:getDHMS(timestamp, true)
    Label_time:setTextById(800026, hour, min, sec)
end

function FubenEndlessView:showRacingReward()
    local rankData = Utils:getKVP(46002, "rank")
    local items = self.ListView_racing_reward:getItems()
    local gap = #rankData - #items

    for i = 1, math.abs(gap) do
        if gap > 0 then
            local Panel_rankRewardItem = self.Panel_rankRewardItem:clone()
            self.ListView_racing_reward:pushBackCustomItem(Panel_rankRewardItem)
        else
            self.ListView_racing_reward:removeItem(1)
        end
    end

    for i, v in ipairs(rankData) do
        local Panel_rankRewardItem = self.ListView_racing_reward:getItem(i)
        local Image_normal = TFDirector:getChildByPath(Panel_rankRewardItem, "Image_normal")
        local Image_select = TFDirector:getChildByPath(Panel_rankRewardItem, "Image_select"):hide()
        local Label_level_normal = TFDirector:getChildByPath(Panel_rankRewardItem, "Label_level_normal")
        local Label_level_select = TFDirector:getChildByPath(Panel_rankRewardItem, "Label_level_select"):hide()
        local Panel_reward = {}
        for j = 1, 3 do
            local item = {}
            item.root = TFDirector:getChildByPath(Panel_rankRewardItem, "Panel_reward_" .. j)
            item.Image_icon = TFDirector:getChildByPath(item.root, "Image_icon")
            item.Label_count = TFDirector:getChildByPath(item.root, "Label_count")
            local reward = v.reward[j]
            local itemCfg = GoodsDataMgr:getItemCfg(reward.id)
            item.Image_icon:setTexture(itemCfg.icon)
            item.Label_count:setTextById(800007, reward.num)
            item.Image_icon:onClick(function()
                    Utils:showInfo(reward.id)
            end)
        end
        local Image_rank = {}
        for j = 1, 3 do
            Image_rank[j] = TFDirector:getChildByPath(Panel_rankRewardItem, "Image_rank_" .. j)
            Image_rank[j]:setVisible(j == i)
        end
        Label_level_normal:setVisible(i > 3)
        if i > 3 then
            if v.showStr then
                Label_level_normal:setText(v.showStr)
                Label_level_select:setText(v.showStr)
            else
                Label_level_normal:setTextById(310026, v.rank[1], v.rank[2])
                Label_level_select:setTextById(310026, v.rank[1], v.rank[2])
            end
        end
    end
end

function FubenEndlessView:registerEvents()
    EventMgr:addEventListener(self, EV_RECV_PLAYERINFO, handler(self.onQueryInfoEvent, self))
    EventMgr:addEventListener(self, EV_FUBEN_UPDATEENDLESSINFO, handler(self.onUpdateEndlessInfoEvent, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onUpdateCostEvent, self))
    EventMgr:addEventListener(self, EV_FUBEN_ENDLESS_UPDATERANK, handler(self.onUpdateRacingRankEvent, self))
    EventMgr:addEventListener(self, EV_FUBEN_ENDLESS_JUMPLEVEL, handler(self.onJumpLevelEvent, self))

    self:setBackBtnCallback(function()
            AlertManager:close()
            local view = AlertManager:getLayer(-1)
            if view and view.__cname == "FubenChapterView" then
            else
                Utils:openView("fuben.FubenChapterView")
            end
    end)

    self.Button_enterPlot:onClick(function()
            local endlessInfo = FubenDataMgr:getEndlessInfo()
            if endlessInfo.step ~= EC_EndlessState.ING then
                Utils:showTips(310028)
                return
            end
            local isRacingMode = FubenDataMgr:isEndlessRacingMode(endlessInfo.curStage)
            if self.selectTabIndex_ == 1 then
                if isRacingMode then
                    Utils:showTips(2105003)
                else
                    Utils:openView("fuben.FubenSquadView", EC_FBType.ACTIVITY, self.chapterCid_)
                end
            else
                local openLevel = Utils:getKVP(46001, "newOpenLevel")
                local palyerLevel = MainPlayer:getPlayerLv()
                if MainPlayer:getPlayerLv() >= openLevel then
                    if isRacingMode then
                        local maxLevel = FubenDataMgr:getEndlessMaxLevel()
                        if endlessInfo.todayBest < maxLevel then
                            Utils:openView("fuben.FubenSquadView", EC_FBType.ACTIVITY, self.chapterCid_)
                        else
                            Utils:showTips(2105003)
                        end
                    else
                        Utils:showTips(310011)
                    end
                else
                    Utils:showTips(310027)
                end
            end
    end)

    self.Button_exchangeReward:onClick(function()
            Utils:openView("store.StoreMainView", 130000)
    end)

    for i, v in ipairs(self.Panel_tab) do
        v.root:onClick(function()
                self:selectTab(i)
        end)
    end

    for i, v in ipairs(self.Panel_racing_tab) do
        v.root:onClick(function()
                self:selectRacingTab(i)
        end)
    end

    for i=1,2 do
        self.totalRankBtn[i]:onClick(function()
            Utils:openView("fuben.FubenEndlessTotalRank")
        end)
    end
end

function FubenEndlessView:removeEvents()
    self:removeCountDownTimer()
end

function FubenEndlessView:onCountDownPer(index)
    self:updateEndlessInfo()
end

function FubenEndlessView:addCountDownTimer(storeId)
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.onCountDownPer, self))
    end
end

function FubenEndlessView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
    end
end

function FubenEndlessView:onUpdateEndlessInfoEvent()
    self:updateEndlessInfo()
    local endlessInfo = FubenDataMgr:getEndlessInfo()
    if endlessInfo.step == EC_EndlessState.READY then
        AlertManager:closeAllToLayer(self)
    end
end

function FubenEndlessView:onUpdateCostEvent()
    self.Label_cost_num:setText(GoodsDataMgr:getItemCount(self.costCid_))
end

function FubenEndlessView:onUpdateRacingRankEvent(rankData, myRankData, refreshRankTime)
    self.racingRankData_ = rankData or {}
    self.racingMyRankData_ = myRankData
    self.refreshRankTime_ = refreshRankTime

    if self.selectTabIndex_ == 2 then
        self:showRacingRank()
    end
end

function FubenEndlessView:onQueryInfoEvent(playerInfo)
    local view = AlertManager:getLayer(-1)
    if view.__cname == self.__cname then
        Utils:openView("chat.PlayerInfoView", playerInfo)
    end
end

function FubenEndlessView:onJumpLevelEvent(isJump)
    local endlessInfo = FubenDataMgr:getEndlessInfo()
    local tabIndex = 1
    if FubenDataMgr:isEndlessRacingMode(endlessInfo.curStage) then
        tabIndex = 2
    end
    self:selectTab(tabIndex)
end

return FubenEndlessView
