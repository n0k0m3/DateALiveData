
local FubenTheaterBossView = class("FubenTheaterBossView", BaseLayer)

function FubenTheaterBossView:initData()
    self.Panel_permanent_level = {}
    self.permanentLevelItems_ = {}
    self:updateTheaterData()

    self.globalRank_ = nil
    self.friendRank_ = nil
    self.reqTiming_ = 0
    self.reqChallengeInfoTiming_ = 0

    self.previewReward_ = {}

    FubenDataMgr:send_ODEUM_OPEN_PANEL()
    FubenDataMgr:send_ODEUM_REQ_NOTICE()
    self:addCountDownTimer()
end

function FubenTheaterBossView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.fuben.fubenTheaterBossView")
end

function FubenTheaterBossView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_touch = TFDirector:getChildByPath(ui, "Panel_touch")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_rankItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_rankItem")
    self.Panel_permanent_level_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_permanent_level_item")
    self.Label_contribution_tip_item = TFDirector:getChildByPath(self.Panel_prefab, "Label_contribution_tip_item")
    self.Panel_challengeInfo_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_challengeInfo_item")

    local Image_tab = TFDirector:getChildByPath(self.Panel_root, "Image_tab")
    self.Panel_rank_tab = {}
    self.Panel_tab_rank_global = TFDirector:getChildByPath(Image_tab, "Panel_tab_rank_global")
    local item = {}
    item.root = self.Panel_tab_rank_global
    item.Image_select = TFDirector:getChildByPath(item.root, "Image_select")
    item.Label_name = TFDirector:getChildByPath(item.root, "Label_name")
    self.Panel_rank_tab[1] = item
    self.Panel_tab_rank_friend = TFDirector:getChildByPath(Image_tab, "Panel_tab_rank_friend")
    local item = {}
    item.root = self.Panel_tab_rank_friend
    item.Image_select = TFDirector:getChildByPath(item.root, "Image_select")
    item.Label_name = TFDirector:getChildByPath(item.root, "Label_name")
    self.Panel_rank_tab[2] = item
    local Panel_rank = TFDirector:getChildByPath(self.Panel_root, "Panel_rank")
    self.Panel_myRank = TFDirector:getChildByPath(Panel_rank, "Panel_myRank")
    self.Panel_myRankItem = self.Panel_rankItem:clone()
    self.Panel_myRankItem:AddTo(self.Panel_myRank):Pos(0, 0):ZO(1)
    self.Label_myRank = TFDirector:getChildByPath(self.Panel_myRank, "Label_myRank")
    local ScrollView_global_rank = TFDirector:getChildByPath(Panel_rank, "ScrollView_global_rank")
    self.ListView_global_rank = UIListView:create(ScrollView_global_rank)
    local ScrollView_friend_rank = TFDirector:getChildByPath(Panel_rank, "ScrollView_friend_rank")
    self.ListView_friend_rank = UIListView:create(ScrollView_friend_rank)
    local Image_boss = TFDirector:getChildByPath(self.Panel_root, "Image_boss")
    self.Label_boss_name = TFDirector:getChildByPath(Image_boss, "Label_boss_name")
    local Image_progress = TFDirector:getChildByPath(self.Panel_root, "Image_progress")
    self.LoadingBar_progress = TFDirector:getChildByPath(Image_progress, "LoadingBar_progress")
    self.Label_total_contribution_title = TFDirector:getChildByPath(Image_progress, "Label_total_contribution_title")
    self.Label_total_contribution = TFDirector:getChildByPath(self.Label_total_contribution_title, "Label_total_contribution")
    self.Label_personal_contribution_title = TFDirector:getChildByPath(Image_progress, "Label_personal_contribution_title")
    self.Label_personal_contribution = TFDirector:getChildByPath(self.Label_personal_contribution_title, "Label_personal_contribution")
    self.Label_fubenTheaterBossView_value = TFDirector:getChildByPath(self.Label_total_contribution, "Label_fubenTheaterBossView_value")
    self.Panel_permanent = TFDirector:getChildByPath(Image_progress, "Panel_permanent"):hide()
    self.Panel_lingbo = TFDirector:getChildByPath(Image_progress, "Panel_lingbo"):hide()
    self.Button_max_gray = TFDirector:getChildByPath(self.Panel_lingbo, "Button_max_gray")
    self.Button_max = TFDirector:getChildByPath(self.Panel_lingbo, "Button_max")

    self.Image_clear_time = TFDirector:getChildByPath(self.Panel_root, "Image_clear_time")
    self.Label_clear_time_title = TFDirector:getChildByPath(self.Image_clear_time, "Label_clear_time_title")
    self.Label_clear_time = TFDirector:getChildByPath(self.Image_clear_time, "Label_clear_time")

    self.Image_challenge_info = TFDirector:getChildByPath(self.Panel_root, "Image_challenge_info")
    self.Label_challenge_info_title = TFDirector:getChildByPath(self.Image_challenge_info, "Label_challenge_info_title")
    local ScrollView_challenge_info = TFDirector:getChildByPath(self.Image_challenge_info, "ScrollView_challenge_info")
    self.ListView_challenge_info = UIListView:create(ScrollView_challenge_info)

    self.Image_dropRward = TFDirector:getChildByPath(self.Panel_root, "Image_dropRward")
    self.Label_dropReward = TFDirector:getChildByPath(self.Image_dropRward, "Label_dropReward")
    local ScrollView_dropReward = TFDirector:getChildByPath(self.Image_dropRward, "ScrollView_dropReward")
    self.ListView_dropReward = UIListView:create(ScrollView_dropReward)
    self.Image_contributionReward = TFDirector:getChildByPath(self.Panel_root, "Image_contributionReward")
    self.Label_contributionReward = TFDirector:getChildByPath(self.Image_contributionReward, "Label_contributionReward")
    local ScrollView_contributionReward = TFDirector:getChildByPath(self.Image_contributionReward, "ScrollView_contributionReward")
    self.ListView_contributionReward = UIListView:create(ScrollView_contributionReward)

    self.Button_fighting = TFDirector:getChildByPath(self.Panel_root, "Button_fighting")
    self.Label_fighting = TFDirector:getChildByPath(self.Button_fighting, "Label_fighting")
    self.Button_receive = TFDirector:getChildByPath(self.Panel_root, "Button_receive")
    self.Label_receive = TFDirector:getChildByPath(self.Button_receive, "Label_receive")
    local Image_remainCount = TFDirector:getChildByPath(self.Panel_root, "Image_remainCount")
    self.Label_remainCount = TFDirector:getChildByPath(Image_remainCount, "Label_remainCount")
    self.Label_remainCount_title = TFDirector:getChildByPath(Image_remainCount, "Label_remainCount_title")

    self.Label_permanent_reset_time = TFDirector:getChildByPath(self.Panel_root, "Label_permanent_reset_time"):hide()

    -- self.Image_preview = Utils:previewReward()
    -- self.Image_preview:AddTo(self.Panel_root):setZOrder(1)

    -- self.Label_contribution_tip = self.Label_contribution_tip_item:clone()
    -- self.Label_contribution_tip:AddTo(self.Image_preview)

    self.Label_count_reset_time = TFDirector:getChildByPath(self.Panel_root, "Label_count_reset_time")
    self.Button_task = TFDirector:getChildByPath(self.Panel_root, "Button_task")
    self.Image_myContribution = TFDirector:getChildByPath(self.Panel_root, "Image_myContribution")
    self.Label_myContribution_title = TFDirector:getChildByPath(self.Image_myContribution, "Label_myContribution_title")
    self.Label_myContribution = TFDirector:getChildByPath(self.Image_myContribution, "Label_myContribution")

    self:refreshView()
end

function FubenTheaterBossView:refreshView()
    self.Label_myContribution_title:setTextById(300991)
    self.Label_total_contribution_title:setTextById(300974)
    self.Label_personal_contribution_title:setTextById(300991)
    self.Label_dropReward:setTextById(300976, TextDataMgr:getText(self.levelCfg_.name))
    self.Label_contributionReward:setTextById(300977)
    self.Label_fighting:setTextById(300978)
    self.Label_receive:setTextById(300984)
    self.Label_myRank:setTextById(300980)
    self.Label_remainCount_title:setTextById(300979)
    self.Label_challenge_info_title:setTextById(12010151)
    self.Label_clear_time_title:setTextById(12010153)
    self.Label_permanent_reset_time:setTextById(12010152)

    local count = GoodsDataMgr:getItemCount(EC_SItemType.THEATER_COUNT)
    self.Label_remainCount:setText(count)

    if self.theaterBossInfo_.odeumType == EC_TheaterBossType.LINGBO then
        self.Panel_lingbo:show()
    else
        self.Panel_permanent:show()
    end

    self:updateBossInfo()
    self:updateReward()
    self:updateChallengeInfo()
end

function FubenTheaterBossView:updateReward()
    local levelInfo = FubenDataMgr:getLevelInfo(self.levelCid_)
    local isShowFirstPass = true
    if levelInfo then
        if levelInfo.fightCount > 0 then
            isShowFirstPass = false
        end
    end
    local dropCfg = TabDataMgr:getData("Drop", self.levelCfg_.firstReward)
    local useProfit = dropCfg.useProfit or {}
    local reward = {}
    if useProfit.fix and useProfit.fix.items then
        for i, v in ipairs(useProfit.fix.items) do
            local item = Utils:makeRewardItem(v.id, v.min)
            table.insert(reward, item)
        end
    end
    for i, v in ipairs(reward) do
        local Panel_dropGoodsItem = PrefabDataMgr:getPrefab("Panel_dropGoodsItem"):clone()
        Panel_dropGoodsItem:Scale(0.8)
        self.ListView_dropReward:pushBackCustomItem(Panel_dropGoodsItem)
        local flag = 0
        if isShowFirstPass then
            flag = bit.bor(flag, EC_DropShowType.FIRST_PASS)
        else
            flag = bit.bor(flag, EC_DropShowType.GETED)
        end
        PrefabDataMgr:setInfo(Panel_dropGoodsItem, {v.id, v.num}, flag)
    end

    local contribution_reward = {500001, 555010}
    self.ListView_contributionReward:removeAllItems()
    for i, v in ipairs(contribution_reward) do
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:Scale(0.8)
        self.ListView_contributionReward:pushBackCustomItem(Panel_goodsItem)
        PrefabDataMgr:setInfo(Panel_goodsItem, v)
    end
end

function FubenTheaterBossView:updateBossInfo()
    if not self.levelCfg_ then return end

    self.previewReward_ = clone(self.theaterBossInfo_.nodeStatus)

    self.Label_boss_name:setTextById(self.levelCfg_.name)
    self.Label_personal_contribution:setText(GoodsDataMgr:getItemCount(EC_SItemType.CONTRIBUTION))
    self.Label_myContribution:setText(GoodsDataMgr:getItemCount(EC_SItemType.CONTRIBUTION))

    local maxCfg = self.theaterBossInfo_.nodeStatus[#self.theaterBossInfo_.nodeStatus]
    if self.theaterBossInfo_.odeumType == EC_TheaterBossType.LINGBO then
        local isFull = self.theaterBossInfo_.serverContribution >= maxCfg.contribution
        self.Button_max:setVisible(isFull)
        self.Button_max_gray:setVisible(not isFull)
        self.Label_clear_time:setTextById(12010149)
    else
        local size = self.Panel_permanent:getSize()
        local ap = self.Panel_permanent:getAnchorPoint()
        local isShowCurrent = false
        for i = #self.theaterBossInfo_.nodeStatus, 1, -1 do
            local nodeStatus = self.theaterBossInfo_.nodeStatus[i]
            local Panel_permanent_level_item = self.Panel_permanent_level[i]
            if not Panel_permanent_level_item then
                Panel_permanent_level_item = self:addPermanentLevelItem()
                local rate = nodeStatus.contribution / maxCfg.contribution
                local x = size.width * rate - size.width * ap.x
                local y = 40
                Panel_permanent_level_item:Pos(x, y)
                self.Panel_permanent_level[i] = Panel_permanent_level_item
            end
            local foo = self.permanentLevelItems_[Panel_permanent_level_item]
            foo.Label_current_level:setText(i)
            foo.Label_other_level:setText(i)
            if self.theaterBossInfo_.serverContribution >= nodeStatus.contribution then
                if isShowCurrent then
                    foo.Button_current:hide()
                    foo.Button_other:show()
                else
                    isShowCurrent = true
                    foo.Button_current:show()
                    foo.Button_other:hide()
                end
            else
                foo.Button_current:hide()
                foo.Button_other:show()
            end
        end
        self:updateResetTime()
        self.Label_clear_time:setTextById(12010150)
    end

    local percent = math.min(1, self.theaterBossInfo_.serverContribution / maxCfg.contribution)
    self.LoadingBar_progress:setPercent(percent * 100)

    self.Button_fighting:setVisible(self.theaterBossInfo_.status == EC_TheaterStatus.ING)
    self.Button_receive:setVisible(self.theaterBossInfo_.status == EC_TheaterStatus.CLEARING)
    self.Button_receive:setTouchEnabled(self.theaterBossInfo_.receiveStatus ~= EC_TheaterReceiveStatus.GETED)
    self.Button_receive:setGrayEnabled(self.theaterBossInfo_.receiveStatus == EC_TheaterReceiveStatus.GETED)
    self.Label_permanent_reset_time:setVisible(self.theaterBossInfo_.odeumType == EC_TheaterBossType.PERMANENT)

    local contribution = Utils:format_number_w(self.theaterBossInfo_.serverContribution)
    self.Label_total_contribution:setTextById("r301001", contribution, string.format("%0.2f", percent * 100))
end

function FubenTheaterBossView:addPermanentLevelItem()
    local Panel_permanent_level_item = self.Panel_permanent_level_item:clone()
    local foo = {}
    foo.root = Panel_permanent_level_item
    foo.Button_current = TFDirector:getChildByPath(foo.root, "Button_current")
    local Label_level_title = TFDirector:getChildByPath(foo.Button_current, "Label_level_title")
    Label_level_title:setTextById(300975)
    foo.Label_current_level = TFDirector:getChildByPath(foo.Button_current, "Label_current_level")
    foo.Button_other = TFDirector:getChildByPath(foo.root, "Button_other")
    local Label_level_title = TFDirector:getChildByPath(foo.Button_other, "Label_level_title")
    Label_level_title:setTextById(300975)
    foo.Label_other_level = TFDirector:getChildByPath(foo.Button_other, "Label_other_level")
    self.permanentLevelItems_[foo.root] = foo
    Panel_permanent_level_item:AddTo(self.Panel_permanent)
    return Panel_permanent_level_item
end

function FubenTheaterBossView:selectRankTab(index)
    if self.selectTabIndex_ == index then return end
    self.selectTabIndex_ = index

    if index == 1 then
        if not self.globalRank_ then
            FubenDataMgr:send_ODEUM_REQ_RANK(0)
        end
    else
        if not self.friendRank_ then
            FubenDataMgr:send_ODEUM_REQ_RANK(1)
        end
    end

    for i, v in ipairs(self.Panel_rank_tab) do
        local isSelect = i == index
        v.Image_select:setVisible(isSelect)
    end

    self.ListView_global_rank:setVisible(index == 1)
    self.ListView_friend_rank:setVisible(index == 2)
end

function FubenTheaterBossView:registerEvents()
    EventMgr:addEventListener(self, EV_FUBEN_THEATER_BOSS_INFO, handler(self.onTheaterBossInfoEvent, self))
    EventMgr:addEventListener(self, EV_FUBEN_THEATER_RANK, handler(self.onUpdateRankEvent, self))
    EventMgr:addEventListener(self, EV_RECV_PLAYERINFO, handler(self.onQueryInfoEvent, self))
    EventMgr:addEventListener(self, EV_FUBEN_THEATER_NODE_REWARD, handler(self.onReceiveRewardEvent, self))
    EventMgr:addEventListener(self, EV_FUBEN_THEATER_UPDATE_NOTICE, handler(self.onUpdateNoticeEvent, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onUpdateCountEvent, self))

    for i, v in ipairs(self.Panel_rank_tab) do
        v.root:onClick(function()
                self:selectRankTab(i)
        end)
    end

    local selectIndex = nil
    for i, v in ipairs(self.Panel_permanent_level) do
        local foo = self.permanentLevelItems_[v]
        foo.Button_current:onClick(function()
                -- local visible = self.Image_preview:isVisible()
                -- self.Image_preview:setVisible(not visible or selectIndex ~= i)
                -- if self.Image_preview:isVisible() then
                --     selectIndex = i
                -- end
                -- self.Image_preview:setAnchorPoint(ccp(0.5, -0.6))
                self:showPermanentPreview(i)
        end)

        foo.Button_other:onClick(function()
                -- local visible = self.Image_preview:isVisible()
                -- self.Image_preview:setVisible(not visible or selectIndex ~= i)
                -- if self.Image_preview:isVisible() then
                --     selectIndex = i
                -- end
                -- self.Image_preview:setAnchorPoint(ccp(0.5, -0.4))
                self:showPermanentPreview(i)
        end)
    end

    self.Button_receive:onClick(function()
            local status = self.theaterBossInfo_.receiveStatus
            if status == EC_TheaterReceiveStatus.ING then
                Utils:showTips(300985)
            elseif status == EC_TheaterReceiveStatus.GET then
                FubenDataMgr:send_ODEUM_REQ_NODE_PRIZE()
            end
    end)

    self.Button_fighting:onClick(function()
            if self.theaterBossInfo_.status == EC_TheaterStatus.ING then
                local count = GoodsDataMgr:getItemCount(EC_SItemType.THEATER_COUNT)
                if count > 0 then
                    Utils:openView("fuben.FubenTheaterCountView", self.levelCid_, count)
                else
                    Utils:showTips(300990)
                end
            else
                Utils:showTips(219007)
            end
    end)

    self.Button_max:onClick(function()
            -- local visible = self.Image_preview:isVisible()
            -- self.Image_preview:setVisible(not visible)
            -- self.Image_preview:setAnchorPoint(ccp(0.5, -0.2))
            self:showLingboPreview(1)
    end)

    self.Button_max_gray:onClick(function()
            -- local visible = self.Image_preview:isVisible()
            -- self.Image_preview:setVisible(not visible)
            -- self.Image_preview:setAnchorPoint(ccp(0.5, -0.2))
            self:showLingboPreview(1)
    end)

    self.Panel_touch:setSwallowTouch(false)
    self.Panel_touch:setSize(GameConfig.WS)
    self.Panel_touch:onTouch(function()
            -- self.Image_preview:hide()
    end)

    self.Button_task:onClick(function()
            Utils:openView("fuben.FubenTheaterRewardView")
    end)
end

function FubenTheaterBossView:updateRankItem(item, data, isOwn, isFriend)
    isOwn = tobool(isOwn)
    local Image_normal = TFDirector:getChildByPath(item, "Image_normal")
    local Image_select = TFDirector:getChildByPath(item, "Image_select")
    local Label_rank_normal = TFDirector:getChildByPath(item, "Label_rank_normal")
    local Label_rank_select = TFDirector:getChildByPath(item, "Label_rank_select")
    local Label_name = TFDirector:getChildByPath(item, "Label_name")
    local Label_level = TFDirector:getChildByPath(item, "Label_level")
    local Label_contribution = TFDirector:getChildByPath(item, "Label_contribution")
    local Image_icon = TFDirector:getChildByPath(item, "Image_icon")
    local Image_rank = {}
    for i = 1, 3 do
        Image_rank[i] = TFDirector:getChildByPath(item, "Image_rank_" .. i)
    end
    Image_normal:setVisible(not isOwn)
    Image_select:setVisible(isOwn)

    if isOwn then
        local icon = AvatarDataMgr:getSelfAvatarIconPath()
        Image_icon:setTexture(icon)

        Label_rank_normal:hide()
        Label_rank_select:setVisible(isOwn and self.myRank_ > 3 or self.myRank_ <= 0)
        Label_name:setText(MainPlayer:getPlayerName())
        Label_level:setTextById(800006, MainPlayer:getPlayerLv())
        Label_contribution:setText(self.myContribution_)

        if self.myRank_ <= 0 then
            Label_rank_normal:setTextById(310012)
            Label_rank_select:setTextById(310012)
        else
            Label_rank_normal:setText(self.myRank_)
            Label_rank_select:setText(self.myRank_)
        end
    else
        for i, v in ipairs(Image_rank) do
            v:setVisible(i == data.rank)
        end
        Label_rank_normal:setVisible(not isOwn and data.rank > 3 or data.rank <= 0)
        Label_rank_select:hide()
        Label_rank_normal:setText(data.rank)
        Label_rank_select:setText(data.rank)
        Label_contribution:setText(data.score)
        if isFriend then
            local friendInfo = FriendDataMgr:getFriendInfo(data.playerId)
            Label_name:setText(friendInfo.name)
            Label_level:setTextById(800006, friendInfo.lvl)
            local headIcon = friendInfo.portraitCid
            if headIcon == 0 then
                headIcon = 101
            end
        else
            local headIcon = data.headIcon
            if headIcon == 0 then
                headIcon = 101
            end
            local icon = AvatarDataMgr:getAvatarIconPath(headIcon)
            Image_icon:setTexture(icon)
            Label_name:setText(data.playerName)
            Label_level:setTextById(800006, data.level)
        end

        if data.playerId ~= MainPlayer:getPlayerId() then
            Image_icon:onClick(function()
                    MainPlayer:sendPlayerId(data.playerId)
            end)
        end
    end
end

function FubenTheaterBossView:showPermanentPreview(index)
    local item = self.Panel_permanent_level[index]
    local wp = item:getParent():convertToWorldSpaceAR(item:Pos())
    -- local np = self.Image_preview:getParent():convertToNodeSpaceAR(wp)

    local reward = self.previewReward_[index].nodeRewards
    self.Image_preview = Utils:previewReward(self.Image_preview, reward, 0.5)
    -- self.Image_preview:Pos(np)

    -- local ap = self.Image_preview:getAnchorPoint()
    -- local size = self.Image_preview:getSize()
    -- local anchorPointInPoints = self.Image_preview:getAnchorPointInPoints()
    -- local position = ccpSub(ccp(size.width * 0.5, size.height + 5), anchorPointInPoints)
    -- self.Label_contribution_tip:Pos(position.x, position.y)
    -- local contribution = self.previewReward_[index].contribution
    -- self.Label_contribution_tip:setTextById(300999, Utils:format_number_w(contribution))
end

function FubenTheaterBossView:showLingboPreview(index)
    local item = self.Button_max
    -- local wp = item:getParent():convertToWorldSpaceAR(item:Pos())
    -- local np = self.Image_preview:getParent():convertToNodeSpaceAR(wp)

    local reward = self.previewReward_[index].nodeRewards
    self.Image_preview = Utils:previewReward(self.Image_preview, reward, 0.6)
    -- self.Image_preview:Pos(np)

    -- local ap = self.Image_preview:getAnchorPoint()
    -- local size = self.Image_preview:getSize()
    -- local anchorPointInPoints = self.Image_preview:getAnchorPointInPoints()
    -- local position = ccpSub(ccp(size.width * 0.5, size.height + 5), anchorPointInPoints)
    -- self.Label_contribution_tip:Pos(position.x, position.y)
    -- local contribution = self.previewReward_[index].contribution
    -- self.Label_contribution_tip:setTextById(300999, Utils:format_number_w(contribution))
end

function FubenTheaterBossView:updateTheaterData()
    self.theaterBossInfo_ = FubenDataMgr:getTheaterBossInfo()
    self.levelCid_ = self.theaterBossInfo_.bossDungeonId
    self.levelCfg_ = FubenDataMgr:getLevelCfg(self.levelCid_)
end

function FubenTheaterBossView:updateRank(rankType)
    local data = rankType == 0 and self.globalRank_ or self.friendRank_
    local listView = rankType == 0 and self.ListView_global_rank or self.ListView_friend_rank
    local isFriend = rankType == 1
    for i, v in ipairs(data) do
        local Panel_rankItem = self.Panel_rankItem:clone():hide()
        if rankType == 0 then
            listView:pushBackCustomItem(Panel_rankItem)
        else
            listView:pushBackCustomItem(Panel_rankItem)
        end
        self:updateRankItem(Panel_rankItem, v, false, isFriend)
    end

    self:timeOut(function()
            for i, v in ipairs(listView:getItems()) do
                v:show()
            end
    end, 0)

    self:updateRankItem(self.Panel_myRankItem, nil, true, false)
end

function FubenTheaterBossView:updateChallengeInfo()
    local challengeInfo = FubenDataMgr:getTheaterChallengeInfo()

    local items = self.ListView_challenge_info:getItems()
    local gap = #challengeInfo - #items
    if gap < 0 then
        for i = 1, math.abs(gap) do
            self.ListView_challenge_info:removeItem(1)
        end
    end
    
    for i, info in ipairs(challengeInfo) do
        local item = self.ListView_challenge_info:getItem(i)
        if not item then
            item = self.Panel_challengeInfo_item:clone()
            self.ListView_challenge_info:pushBackCustomItem(item)
        end
        local Label_notice = TFDirector:getChildByPath(item, "Label_notice")
        Label_notice:setTextById("r300998", info.name, info.contribution)
    end

    self.ListView_challenge_info:jumpToBottom()
end

function FubenTheaterBossView:removeEvents()
    self:removeCountDownTimer()
end

function FubenTheaterBossView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.onCountDownPer, self))
    end
end

function FubenTheaterBossView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
        self.countDownTimer_ = nil
    end
end

function FubenTheaterBossView:updateResetTime()
    local itemCfg = GoodsDataMgr:getItemCfg(EC_SItemType.THEATER_COUNT)
    local count = GoodsDataMgr:getItemCount(EC_SItemType.THEATER_COUNT)
    if count < itemCfg.totalMax then
        local itemRecoverCfg = StoreDataMgr:getItemRecoverCfg(11)
        local previousTime = getItemCoolDownTime(EC_SItemType.THEATER_COUNT)
        local nextTime = previousTime + itemRecoverCfg.cooldown
        local remainTime = nextTime - ServerDataMgr:getServerTime()
        local day, hour, min, sec = Utils:getDHMS(remainTime, true)
        self.Label_count_reset_time:setTextById(800026, hour, min, sec)
    else
        self.Label_count_reset_time:setTextById(800026, "00", "00", "00")
    end
end

function FubenTheaterBossView:onCountDownPer()
    if not self.reqTiming_ then
        return
    end
    if self.reqTiming_ >= 60  then
        FubenDataMgr:send_ODEUM_UPDATE_CONTRIBUTION()
        self.reqTiming_ = 0
    end
    self.reqTiming_ = self.reqTiming_ + 1
    if self.reqChallengeInfoTiming_ >= 5 then
        FubenDataMgr:send_ODEUM_REQ_NOTICE()
        self.reqChallengeInfoTiming_ = 0
    end
    self.reqChallengeInfoTiming_ = self.reqChallengeInfoTiming_ + 1

    local itemCfg = GoodsDataMgr:getItemCfg(EC_SItemType.THEATER_COUNT)
    local count = GoodsDataMgr:getItemCount(EC_SItemType.THEATER_COUNT)
    if count <= itemCfg.totalMax then
        self:updateResetTime()
    end
end

function FubenTheaterBossView:onTheaterBossInfoEvent()
    self:updateTheaterData()
    self:updateBossInfo()
end

function FubenTheaterBossView:onUpdateRankEvent(rankType, rankData, myRank, myContribution)
    if rankType == 0 then
        self.globalRank_ = rankData
    else
        self.friendRank_ = rankData
    end
    self.myRank_ = myRank
    self.myContribution_ = myContribution
    self:updateRank(rankType)
end

function FubenTheaterBossView:onQueryInfoEvent(playerInfo)
    local view = AlertManager:getLayer(-1)
    if view.__cname == self.__cname then
        Utils:openView("chat.PlayerInfoView", playerInfo)
    end
end

function FubenTheaterBossView:onReceiveRewardEvent(reward)
    self:updateTheaterData()
    self:updateBossInfo()
    Utils:showReward(reward)
end

function FubenTheaterBossView:onUpdateNoticeEvent()
    self:updateChallengeInfo()
end

function FubenTheaterBossView:onUpdateCountEvent()
    local count = GoodsDataMgr:getItemCount(EC_SItemType.THEATER_COUNT)
    self.Label_remainCount:setText(count)
end

return FubenTheaterBossView
