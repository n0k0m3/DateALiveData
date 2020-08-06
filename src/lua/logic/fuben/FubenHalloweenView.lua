
local UserDefault = CCUserDefault:sharedUserDefault()
local FubenHalloweenView = class("FubenHalloweenView", BaseLayer)

function FubenHalloweenView:initData(chapterCid)
    self.chapterCid_ = chapterCid
    self.chapterCfg_ = FubenDataMgr:getChapterCfg(self.chapterCid_)
    local pid = MainPlayer:getPlayerId()
    self.KEY_FUBEN_HALLOWEEN_INDEX = string.format("key_%s_fuben_halloween_index", pid)

    self.diffData_ = {
        [1] = {
            name = 2109006,
            diban = "ui/fuben/halloween/nandu_1.png",
        },
        [2] = {
            name = 2109007,
            diban = "ui/fuben/halloween/nandu_2.png",
        },
        [3] = {
            name = 2109008,
            diban = "ui/fuben/halloween/nandu_3.png",
        },
        [4] = {
            name = 2109009,
            diban = "ui/fuben/halloween/nandu_4.png",
        },
    }

    self.taskItems_ = {}
    self.level_ = {}
    self.task_ = {}
    self.levelPassState_ = {}

    self:updateHalloweenInfo()
    for i, v in ipairs(self.activityInfo_.items) do
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, v)
        if itemInfo.subType == EC_Activity_Assist_Subtype.LEVEL then
            local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, v)
            local levelCid = itemInfo.extendData.jumpInterface
            table.insert(self.level_, levelCid)
            self.levelPassState_[levelCid] = (progressInfo.status == 1)
        elseif itemInfo.subType == EC_Activity_Assist_Subtype.TASK then
            table.insert(self.task_, v)
        end
    end
    self:sortWithTask()


    local cacheSelectIndex = UserDefault:getStringForKey(self.KEY_FUBEN_HALLOWEEN_INDEX)
    if cacheSelectIndex and #cacheSelectIndex > 0 then
        cacheSelectIndex = tonumber(cacheSelectIndex)
    else
        cacheSelectIndex = nil
    end
    local selectIndex = 1
    if cacheSelectIndex then
        selectIndex = cacheSelectIndex
    else
        for i, v in ipairs(self.level_) do
            local isPass = self.levelPassState_[v]
            if isPass then
                selectIndex = i
            end
        end
    end
    self.selectIndex_ = clampf(selectIndex, 1, #self.level_)
end

function FubenHalloweenView:getClosingStateParams()
    return {FubenDataMgr.selectChapter_}
end

function FubenHalloweenView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.fuben.fubenHalloweenView")
end

function FubenHalloweenView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_levelItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_levelItem")
    self.Panel_rankItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_rankItem")
    self.Panel_taskItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_taskItem")

    self.Button_exchange = TFDirector:getChildByPath(self.Panel_root, "Button_exchange")
    self.Label_exchange = TFDirector:getChildByPath(self.Button_exchange, "Label_exchange")
    self.Button_ready = TFDirector:getChildByPath(self.Panel_root, "Button_ready")
    self.Label_ready = TFDirector:getChildByPath(self.Button_ready, "Label_ready")
    self.Image_cost = TFDirector:getChildByPath(self.Panel_root, "Image_cost")
    self.Image_cost_icon = TFDirector:getChildByPath(self.Image_cost, "Image_cost_icon")
    self.Label_cost_num = TFDirector:getChildByPath(self.Image_cost, "Label_cost_num")
    self.Button_left = TFDirector:getChildByPath(self.Panel_root, "Button_left")
    self.Button_right = TFDirector:getChildByPath(self.Panel_root, "Button_right")
    self.PageView_level = TFDirector:getChildByPath(self.Panel_root, "PageView_level")
    local Panel_reward = TFDirector:getChildByPath(self.Panel_root, "Panel_reward")
    self.Label_reward = TFDirector:getChildByPath(Panel_reward, "Label_reward")
    local ScrollView_reward = TFDirector:getChildByPath(Panel_reward, "ScrollView_reward")
    self.ListView_reward = UIListView:create(ScrollView_reward)
    self.Label_time = TFDirector:getChildByPath(self.Panel_root, "Label_time")

    self.Panel_page_default = TFDirector:getChildByPath(self.Panel_root, "Panel_page_default")
    self.Panel_page_rank = TFDirector:getChildByPath(self.Panel_root, "Panel_page_rank")
    self.Panel_page_task = TFDirector:getChildByPath(self.Panel_root, "Panel_page_task")

    local Image_default = TFDirector:getChildByPath(self.Panel_page_default, "Image_default")
    self.Label_default_tips = TFDirector:getChildByPath(Image_default, "Label_default_tips")
    self.Label_default_title = TFDirector:getChildByPath(Image_default, "Label_default_title")

    local Image_rank = TFDirector:getChildByPath(self.Panel_page_rank, "Image_rank")
    self.Label_rank_title = TFDirector:getChildByPath(Image_rank, "Label_rank_title")
    self.Button_detailed = TFDirector:getChildByPath(Image_rank, "Button_detailed")
    self.Button_rank = TFDirector:getChildByPath(Image_rank, "Button_rank")
    self.Label_rank = TFDirector:getChildByPath(self.Button_rank, "Label_rank")
    self.Label_diff = TFDirector:getChildByPath(Image_rank, "Label_diff")
    local ScrollView_rank = TFDirector:getChildByPath(Image_rank, "ScrollView_rank")
    self.ListView_rank = UIListView:create(ScrollView_rank)

    local Image_task = TFDirector:getChildByPath(self.Panel_page_task, "Image_task")
    self.Label_task_title = TFDirector:getChildByPath(Image_task, "Label_task_title")
    local Image_scrollBar = TFDirector:getChildByPath(Image_task, "Image_scrollBar")
    local Image_scrollBarInner = TFDirector:getChildByPath(Image_scrollBar, "Image_scrollBarInner")
    local scrollBar = UIScrollBar:create(Image_scrollBar, Image_scrollBarInner)
    local ScrollView_task = TFDirector:getChildByPath(Image_task, "ScrollView_task")
    self.ListView_task = UIListView:create(ScrollView_task)
    self.ListView_task:setScrollBar(scrollBar)
    self.Label_passTime = TFDirector:getChildByPath(Image_task, "Label_passTime")

    self:refreshView()
end

function FubenHalloweenView:refreshView()
    self.Label_ready:setTextById(2100047)
    self.Label_exchange:setTextById(800042)
    self.Label_reward:setTextById(2109032)
    self.Label_time:setTextById(2109001)

    for i, v in ipairs(self.level_) do
        local levelCfg = FubenDataMgr:getLevelCfg(v)
        local diffData = self.diffData_[levelCfg.difficulty]
        local Panel_levelItem = self.Panel_levelItem:clone()
        local Image_diff = TFDirector:getChildByPath(Panel_levelItem, "Image_diff")
        local Label_diff = TFDirector:getChildByPath(Image_diff, "Label_diff")
        local Image_icon = TFDirector:getChildByPath(Panel_levelItem, "Image_icon")
        local Label_advice_level = TFDirector:getChildByPath(Image_diff, "Label_advice_level")
        self.PageView_level:addPage(Panel_levelItem)

        Image_diff:setTexture(diffData.diban)
        Label_diff:setTextById(diffData.name)
        Image_icon:setTexture(levelCfg.icon)
        Label_advice_level:setTextById(2109005, levelCfg.playerLv)
    end

    self.PageView_level:scrollToPage(self.selectIndex_ - 1, 0)
    self:updateShowPage()
end

function FubenHalloweenView:updateShowPage()
    self.Panel_page_default:setVisible(self.showType_ == 1)
    self.Panel_page_rank:setVisible(self.showType_ == 2)
    self.Panel_page_task:setVisible(self.showType_ == 3)

    if self.Panel_page_default:isVisible() then
        self:showDefault()
    end

    if self.Panel_page_rank:isVisible() then
        self:showRank()
    end

    if self.Panel_page_task:isVisible() then
        self:showTask()
    end
end

function FubenHalloweenView:sortWithTask()
    local task = {}
    local getData = {}
    local ingData = {}
    local getedData = {}
    for i, v in ipairs(self.task_) do
        local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, v)
        if progressInfo.status == EC_TaskStatus.GET then
            table.insert(getData, v)
        elseif progressInfo.status == EC_TaskStatus.GETED then
            table.insert(getedData, v)
        elseif progressInfo.status == EC_TaskStatus.ING then
            table.insert(ingData, v)
        end
    end
    table.insertTo(task, getData)
    table.insertTo(task, ingData)
    table.insertTo(task, getedData)
    self.task_ = task
end

function FubenHalloweenView:showDefault()
    self.Label_default_tips:setTextById(2109033)
    self.Label_default_title:setTextById(2109002)
end

function FubenHalloweenView:showRank()
    ActivityDataMgr2:send_ACTIVITY_REQ_RANK_ACTIVITY(self.activityInfo_.id)
    self.Label_rank_title:setTextById(2109002)
    self.Label_rank:setTextById(2109003)
end

function FubenHalloweenView:addTaskItem()
    local Panel_taskItem = self.Panel_taskItem:clone()
    local foo = {}
    foo.root = Panel_taskItem
    foo.Image_tag = TFDirector:getChildByPath(foo.root, "Image_tag")
    foo.Label_desc = TFDirector:getChildByPath(foo.root, "Label_desc")
    foo.Button_get = TFDirector:getChildByPath(foo.root, "Button_get")
    foo.Label_get = TFDirector:getChildByPath(foo.Button_get, "Label_get")
    foo.Label_notGet = TFDirector:getChildByPath(foo.root, "Label_notGet")
    foo.Label_geted = TFDirector:getChildByPath(foo.root, "Label_geted")
    local ScrollView_reward = TFDirector:getChildByPath(foo.root, "ScrollView_reward")
    foo.ListView_reward = UIListView:create(ScrollView_reward)

    foo.Label_get:setTextById(700013)
    foo.Label_notGet:setTextById(2109034)
    foo.Label_geted:setTextById(700033)

    self.taskItems_[foo.root] = foo
    self.ListView_task:pushBackCustomItem(Panel_taskItem)
end

function FubenHalloweenView:showTask()
    self.Label_task_title:setTextById(2109002)
    self.Label_passTime:setVisible(self.fightTime_ and self.fightTime_ > 0)

    local items = self.ListView_task:getItems()
    local gap = #self.task_ - #items
    for i = 1, math.abs(gap) do
        if gap < 0 then
            local item = self.ListView_task:getItem(1)
            self.ListView_task:removeItem(1)
            self.taskItems_[item] = nil
        else
            local item = self:addTaskItem()
        end
    end
    for i, v in ipairs(self.task_) do
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, v)
        local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, v)
        local item = self.ListView_task:getItem(i)
        local foo = self.taskItems_[item]
        foo.Label_desc:setText(itemInfo.extendData.des2)
        foo.ListView_reward:removeAllItems()
        for rewardCid, rewardNum in pairs(itemInfo.reward) do
            local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            Panel_goodsItem:Scale(0.6)
            PrefabDataMgr:setInfo(Panel_goodsItem, rewardCid, rewardNum)
            foo.ListView_reward:pushBackCustomItem(Panel_goodsItem)
        end
        foo.Label_notGet:setVisible(progressInfo.status == EC_TaskStatus.ING)
        foo.Button_get:setVisible(progressInfo.status == EC_TaskStatus.GET)
        foo.Label_geted:setVisible(progressInfo.status == EC_TaskStatus.GETED)
        foo.Button_get:onClick(function()
                ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityInfo_.id, v)
        end)
    end

    if self.Label_passTime:isVisible() then
        local timestamp = self.fightTime_ / 1000
        local msec = string.format("%02d", self.fightTime_ % 1000 * 0.1)
        local hour, min, sec = Utils:getTime(timestamp, true)
        self.Label_passTime:setTextById(2109037, min, sec, msec)
    end
end

function FubenHalloweenView:updateTaskItem(index)

end

function FubenHalloweenView:registerEvents()
    EventMgr:addEventListener(self, EV_RECV_PLAYERINFO, handler(self.onQueryInfoEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_LESS_RANK, handler(self.onUpdateLessRankEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_MORE_RANK, handler(self.onUpdateMoreRankEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onUpdateTaskProgressEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.onUpdateActivityEvent, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onItemUpdateEvent, self))

    self.Button_detailed:onClick(function()
            local data = ActivityDataMgr2:getAssistItemInfos(self.activityInfo_.id, EC_Activity_Assist_Subtype.RANK_REWARD)
            Utils:openView("activity.AssistRankRewardView", data, 2109025)
    end)

    self.Button_rank:onClick(function()
            ActivityDataMgr2:send_ACTIVITY_REQ_ACTIVITY_RANK(self.activityInfo_.id)
    end)


    self.Button_ready:onClick(function()
            if ActivityDataMgr2:isEnd(self.activityInfo_.id) then
                Utils:showTips(2109036)
            else
                local index = self.PageView_level:getCurPageIndex()
                local levelCid = self.level_[index + 1]
                if table.indexOf(self.notOpenLevel_, levelCid) == -1 then
                    UserDefault:setStringForKey(self.KEY_FUBEN_HALLOWEEN_INDEX, self.selectIndex_)
                    Utils:openView("fuben.FubenSquadView", self.chapterCfg_.type, self.chapterCid_, levelCid)
                else
                    Utils:showTips(2109031)
                end
            end
    end)

    self.PageView_level:addMEListener(
        TFPAGEVIEW_SCROLLENDED,
        function()
            local index = self.PageView_level:getCurPageIndex()
            self:selectLevel(index + 1)
        end
    )

    self.Button_left:onClick(function()
            local index = self.PageView_level:getCurPageIndex()
            index = math.max(0, index - 1)
            self.PageView_level:scrollToPage(index)
    end)

    self.Button_right:onClick(function()
            local index = self.PageView_level:getCurPageIndex()
            index = math.min(#self.level_, index + 1)
            local levelCid = self.level_[index]
            if self.levelPassState_[levelCid] then
                self.PageView_level:scrollToPage(index)
            else
                Utils:showTips(2109014)
            end
    end)

    self.Button_exchange:onClick(function()
            FunctionDataMgr:jHalloweenStore()
    end)
end

function FubenHalloweenView:selectLevel(index)
    self.selectIndex_ = index
    local levelCid = self.level_[index]
    local levelCfg = FubenDataMgr:getLevelCfg(self.level_[index])
    local isPass = self.levelPassState_[levelCid]

    self.Button_left:setVisible(index > 1)
    self.Button_right:setVisible(index < #self.level_)

    self.ListView_reward:removeAllItems()

    local dropShow = levelCfg.firstDropShow
    if isPass then
        dropShow = levelCfg.dropShow
    end

    for i, v in ipairs(dropShow) do
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:Scale(0.9)
        Panel_goodsItem:getChildByName("Image_firstpass"):setVisible(not isPass)
        PrefabDataMgr:setInfo(Panel_goodsItem, v)
        self.ListView_reward:pushBackCustomItem(Panel_goodsItem)
    end
    self:updateCost()
end

function FubenHalloweenView:updateCost()
    local levelCid = self.level_[self.selectIndex_]
    local levelCfg = FubenDataMgr:getLevelCfg(levelCid)
    local cost = levelCfg.cost
    self.Image_cost:setVisible(#cost > 0)
    if self.Image_cost:isVisible() then
        local costCid = cost[1][1]
        local costNum = cost[1][2]
        local costCfg = GoodsDataMgr:getItemCfg(costCid)
        self.Image_cost_icon:setTexture(costCfg.icon)
        local isEnough = GoodsDataMgr:currencyIsEnough(costCid, costNum)
        local haveNum = GoodsDataMgr:getItemCount(costCid)
        if isEnough then
            self.Label_cost_num:setTextById("r82001", costNum, haveNum)
        else
            self.Label_cost_num:setTextById("r82002", costNum, haveNum)
        end
        self.Image_cost_icon:onClick(function()
                Utils:showInfo(costCid, nil, true)
        end)
    end
end

local function formatScore(score)
    local timestamp = math.floor(score / 1000)
    local msec = string.format("%.2d", math.mod(score, 1000))
    local hour, min, sec = Utils:getTime(timestamp, true)
    local str = TextDataMgr:getText(800026, min, sec, msec)
    return str
end

function FubenHalloweenView:onUpdateLessRankEvent(activitId, rank)
    if activitId ~= self.activityInfo_.id then return end

    self.ListView_rank:removeAllItems()
    for i = 1, 3 do
        local data = rank[i]
        if data then
            local Panel_rankItem = self.Panel_rankItem:clone()
            self.ListView_rank:pushBackCustomItem(Panel_rankItem)
            local Button_item = TFDirector:getChildByPath(Panel_rankItem, "Button_item")
            local Image_order = {}
            for j = 1, 3 do
                Image_order[i] = TFDirector:getChildByPath(Button_item, "Image_order_" .. j)
                Image_order[i]:setVisible(i == j)
            end
            local Image_icon = TFDirector:getChildByPath(Button_item, "Image_player_icon_bg.ClippingNode_icon.Image_icon")
            local Label_name = TFDirector:getChildByPath(Button_item, "Label_name")
            local Label_time = TFDirector:getChildByPath(Button_item, "Label_time")

            Label_time:setText(formatScore(data.score))
            Label_name:setText(data.playerName)
            local headIcon = data.headIcon
            if headIcon == 0 then
                headIcon = 101
            end
            local icon = AvatarDataMgr:getAvatarIconPath(headIcon)
            Image_icon:setTexture(icon)

            Button_item:onClick(function()
                    MainPlayer:sendPlayerId(data.playerId)
            end)
        end
    end
end

function FubenHalloweenView:updateHalloweenInfo()
    local halloweenActivity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.HALLOWEEN)
    if #halloweenActivity == 0 then return end

    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(halloweenActivity[1])
    self.notOpenLevel_ = self.activityInfo_.extendData.dungeonNotOpenIds
    self.fightTime_ = self.activityInfo_.extendData.fightTime
    self.showType_ = self.activityInfo_.extendData.pannelType
end

function FubenHalloweenView:onUpdateMoreRankEvent(data)
    if data.activityId ~= self.activityInfo_.id then return end
    Utils:openView("activity.AssistRankingView", data, nil, 2109026, formatScore)
end

function FubenHalloweenView:onQueryInfoEvent(playerInfo)
    local view = AlertManager:getLayer(-1)
    if view.__cname == self.__cname then
        Utils:openView("chat.PlayerInfoView", playerInfo)
    end
end

function FubenHalloweenView:onUpdateTaskProgressEvent()
    self:sortWithTask()
    self:showTask()
end

function FubenHalloweenView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityInfo_.id ~= activitId then return end
    self:showTask()
    Utils:showReward(reward)
end

function FubenHalloweenView:onUpdateActivityEvent()
    self:updateHalloweenInfo()
    self:updateShowPage()
end

function FubenHalloweenView:onItemUpdateEvent()
    self:updateCost()
end

return FubenHalloweenView
