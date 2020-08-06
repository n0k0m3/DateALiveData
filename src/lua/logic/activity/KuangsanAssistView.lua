--[[
 -- 狂三应援活动
]]

local KuangsanAssistView = class("KuangsanAssistView",BaseLayer)

function KuangsanAssistView:ctor(data)
	self.super.ctor(self,data)
	self.activityId = data
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId)
    self.tab_data = {{id = 1, name = "每日任务"},{id = 2, name = "解锁拼图"},{id = 3, name = "应援排行"}}
    self.pic_name_id = {{normal = "022", unlock = "043"},{normal = "023", unlock = "046"},{normal = "024", unlock = "044"},{normal = "025", unlock = "017"},{normal = "026", unlock = "018"},{normal = "027", unlock = "042"},{normal = "028", unlock = "019"},{normal = "029", unlock = "020"},{normal = "030", unlock = "045"}}
    self.selectTabId = nil
    self.totalPoint = 0
    self.realItemMinRank = 100
    self.taskItems_ = {}
    self.rankItems_ = {}
    self.maxPoint = 0
    self.defaultTabId = 1
    self.unlockData = ActivityDataMgr2:getAssistItemInfos(self.activityId, EC_Activity_Assist_Subtype.CG_UNLOCK)
    for k, v in pairs(self.unlockData) do
        self.maxPoint = math.max(self.maxPoint,v.target)
    end
    local serverTime = ServerDataMgr:getServerTime()
    self.isEnd = serverTime > self.activityInfo_.endTime and serverTime < self.activityInfo_.showEndTime
    if self.isEnd then
        self.defaultTabId = 3
    end
    self:init("lua.uiconfig.activity.assistView")
end

function KuangsanAssistView:initUI(ui)
	self.super.initUI(self,ui)
	self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.tab_btn = TFDirector:getChildByPath(self.Panel_root, "tab_btn")
    self.Panel_task_item = TFDirector:getChildByPath(self.Panel_root, "Panel_task_item")
    self.Panel_pic_item = TFDirector:getChildByPath(self.Panel_root, "Panel_pic_item")
    self.Panel_rank_item = TFDirector:getChildByPath(self.Panel_root, "Panel_rank_item")

    self.Panel_head = TFDirector:getChildByPath(self.Panel_root, "Panel_head")
    self.Label_activity_time = TFDirector:getChildByPath(self.Panel_head, "Label_activity_time")
    self.Image_progress_bg = TFDirector:getChildByPath(self.Panel_head, "Image_progress_bg")
    self.LoadingBar_point = TFDirector:getChildByPath(self.Panel_head, "LoadingBar_point")
    self.Image_point_flag = TFDirector:getChildByPath(self.Panel_head, "Image_point_flag")
    self.Label_cur_point_value = TFDirector:getChildByPath(self.Panel_head, "Label_cur_point_value")
    self.Button_reward_show = TFDirector:getChildByPath(self.Panel_head, "Button_reward_show")

 
    self.ListViewTab = UIListView:create(TFDirector:getChildByPath(ui, "ScrollView_tab"))
    self.ListViewTab:setItemsMargin(0)

    self.Panel_task = TFDirector:getChildByPath(self.Panel_root, "Panel_task")
    local ScrollView_task = TFDirector:getChildByPath(self.Panel_task, "ScrollView_task")
    self.ListView_task = UIListView:create(ScrollView_task)
    self.ListView_task:setItemsMargin(-4)

    self.Panel_rank = TFDirector:getChildByPath(self.Panel_root, "Panel_rank")
    local ScrollView_rank = TFDirector:getChildByPath(self.Panel_rank, "ScrollView_rank")
    self.ListView_rank = UIListView:create(ScrollView_rank)
    self.ListView_rank:setItemsMargin(0)
    self.Image_rank_bg = TFDirector:getChildByPath(self.Panel_rank, "Image_rank_bg")
    self.Label_self_rank = TFDirector:getChildByPath(self.Panel_rank, "Label_self_rank")
    self.Image_self_head = TFDirector:getChildByPath(self.Panel_rank, "Image_self_head")
    self.Image_self_frame_cover = TFDirector:getChildByPath(self.Panel_rank, "Image_self_frame_cover")
    self.Label_self_name = TFDirector:getChildByPath(self.Panel_rank, "Label_self_name")
    self.Label_self_level = TFDirector:getChildByPath(self.Panel_rank, "Label_self_level")
    self.Label_self_rank_point = TFDirector:getChildByPath(self.Panel_rank, "Label_self_rank_point")
    self.Button_edit_address = TFDirector:getChildByPath(self.Panel_rank, "Button_edit_address"):hide()

    self.Panel_cg = TFDirector:getChildByPath(self.Panel_root, "Panel_cg")
    self.Image_cg = TFDirector:getChildByPath(self.Panel_cg, "Image_cg")
    self.Button_intro = TFDirector:getChildByPath(self.Panel_cg, "Button_intro")
    self.Panel_unlock = TFDirector:getChildByPath(self.Panel_cg, "Panel_unlock")

    self:initView()
end

function KuangsanAssistView:initView()
	self.tab_items = {}
    for i,v in ipairs(self.tab_data) do
        local item = self.tab_btn:clone()
        TFDirector:getChildByPath(item, "Label_btn_name"):setText(v.name)
        self.ListViewTab:pushBackCustomItem(item)
        self.tab_items[v.id] = item
        item:setTouchEnabled(true)
        item:onClick(function()
            if self.isEnd and v.id < 2 then
                Utils:showTips(219009)
                return
            end
            self:selectTabBtn(v.id)
        end)
    end
    self:selectTabBtn(self.tab_data[self.defaultTabId].id)

    self.unlock_items = {}
    local row = 1
    for i=1,9 do
        local item = self.Panel_pic_item:clone()
        row = math.ceil(i / 3)
        local posX = -34 + ((i - 1) % 3)*127
        local posY = -38 + (- row * 126)
        item:setPosition(ccp(posX,posY))
        self.Panel_unlock:addChild(item)
        self.unlock_items[i] = item
    end
    self:updateCountDonw()
end

function KuangsanAssistView:refreshView()
    self.Panel_task:hide()
    self.Panel_cg:hide()
    self.Panel_rank:hide()
    ActivityDataMgr2:requestAssistProgress(self.activityId)
    if self.selectTabId == 1  then
        self.Panel_task:show()
        self:updateTaskView()
    elseif self.selectTabId == 2  then
        self.Panel_cg:show()
        --ActivityDataMgr2:requestAssistProgress(self.activityId)
    elseif self.selectTabId == 3  then
        self.Panel_rank:show()
        ActivityDataMgr2:send_ACTIVITY_REQ_CROSS_RANK_ACTIVITY(self.activityId)
    end
end

function KuangsanAssistView:updateUnlockItems()
    self.unlockData = ActivityDataMgr2:getAssistItemInfos(self.activityId, EC_Activity_Assist_Subtype.CG_UNLOCK)
    for i,item in ipairs(self.unlock_items) do
        local picIds = self.pic_name_id[i]
        local itemInfo = self.unlockData[i]
        local progress = ActivityDataMgr2:getProgress(self.activityInfo_.activityType, itemInfo.id)
        local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, itemInfo.id)
        local state = progressInfo.status ~= EC_TaskStatus.GETED and (progressInfo.status == EC_TaskStatus.GET or self.totalPoint >= itemInfo.target)
        item:setVisible(progressInfo.status ~= EC_TaskStatus.GETED)
        local imagePic = TFDirector:getChildByPath(item, "Image_pic")
        local Image_pic_unlock = TFDirector:getChildByPath(item, "Image_pic_unlock")
        local normalPic = "ui/activity/assist/kuangsan/"..picIds.normal..".png"
        local unlockPic = "ui/activity/assist/kuangsan/"..picIds.unlock..".png"
        imagePic:setTexture(normalPic)
        Image_pic_unlock:setTexture(unlockPic)
        Image_pic_unlock:setVisible(state)
        TFDirector:getChildByPath(item, "Label_unlock_tip"):setVisible(state)
        TFDirector:getChildByPath(item, "Label_unlock_value"):setText(tostring((itemInfo.target or 0)))
        local Panel_touch = TFDirector:getChildByPath(item, "Panel_touch")
        Panel_touch:setTouchEnabled(state)
        Panel_touch:onClick(function()
            imagePic:setVisible(false)
            Image_pic_unlock:setVisible(false)
            TFDirector:getChildByPath(item, "Label_unlock_tip"):setVisible(false)
            TFDirector:getChildByPath(item, "Label_unlock_value"):setVisible(false)
            TFDirector:getChildByPath(item, "Label_name"):setVisible(false)
            local spineUnlock = SkeletonAnimation:create("effect/pintujiesuo/pintujiesuo")
            spineUnlock:setPosition(ccp(0, 0))
            spineUnlock:playByIndex(0, -1, -1, 0)
            Panel_touch:addChild(spineUnlock, 10)
            spineUnlock:addMEListener(TFARMATURE_COMPLETE,function()
                spineUnlock:setVisible(false)
                item:hide()
                ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, itemInfo.id)
            end)
        end)
    end
end

function KuangsanAssistView:selectTabBtn(id)
    if self.selectTabId == id then
        return
    end
    self.selectTabId = id
    self:refreshView()
    for k, item in pairs(self.tab_items) do
        if k == self.selectTabId then
            TFDirector:getChildByPath(item, "Image_btn_bg"):setTexture("ui/activity/assist/kuangsan/001.png")
            TFDirector:getChildByPath(item, "Label_btn_name"):setColor(ccc3(255,255,255))
        else
            TFDirector:getChildByPath(item, "Image_btn_bg"):setTexture("ui/activity/assist/kuangsan/002.png")
            TFDirector:getChildByPath(item, "Label_btn_name"):setColor(ccc3(153,137,145))
        end
    end
end

function KuangsanAssistView:updatePanelHead(data)
    self.totalPoint = data.process
    self.realItemMinRank = data.realItemMinRank
    local percent
    if self.maxPoint == 0 then
        percent = 0
    else
        percent = math.max(self.totalPoint / self.maxPoint * 100, 1)
    end
    self.Label_cur_point_value:setText(tostring(self.totalPoint))
    self.LoadingBar_point:setPercent(percent)

    local minX = -self.Image_progress_bg:getContentSize().width / 2 + 10
    local maxX = self.Image_progress_bg:getContentSize().width / 2 - 20
    local rang = (percent / 100 - 0.5)
    local posX = percent / 100 * self.Image_progress_bg:getContentSize().width - self.Image_progress_bg:getContentSize().width / 2 + 5
    posX = math.max(posX, minX)
    posX = math.min(posX, maxX)
    self.Image_point_flag:setPositionX(posX)

    self:updateUnlockItems()
end

function KuangsanAssistView:updateTaskView()
    self.taskData_ = ActivityDataMgr2:getAssistItemInfos(self.activityId, EC_Activity_Assist_Subtype.STAGE_REWARD)
    local items = self.ListView_task:getItems()
    local gap = #items - #self.taskData_

    for i = 1, math.abs(gap) do
        if gap > 0 then
            local item = self.ListView_task:getItem(1)
            self.taskItems_[item] = nil
            self.ListView_task:removeItem(1)
        else
            local item = self:addTaskItem()
            self.ListView_task:pushBackCustomItem(item)
        end
    end
    for i, v in ipairs(self.ListView_task:getItems()) do
        self:updateTaskItem(i)
    end
end

function KuangsanAssistView:addTaskItem()
    local Panel_taskItem = self.Panel_task_item:clone()
    local foo = {}
    foo.root = Panel_taskItem
    foo.Label_task_desc = TFDirector:getChildByPath(foo.root, "Label_task_desc")
    foo.Label_percent_value = TFDirector:getChildByPath(foo.root, "Label_percent_value")
    foo.Panel_items = {}
    for i = 1, 3 do
        local reward_item = {}
        reward_item.item = TFDirector:getChildByPath(foo.root, "Panel_item_" .. i)
        reward_item.Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        reward_item.Panel_goodsItem:AddTo(reward_item.item):Pos(40, 40):Scale(0.7)
        foo.Panel_items[i] = reward_item
    end
    foo.Label_geted = TFDirector:getChildByPath(foo.root, "Label_geted")
    foo.Label_geted:setTextById(1300015)

    foo.Button_goto = TFDirector:getChildByPath(foo.root, "Button_goto")
    foo.Label_goto = TFDirector:getChildByPath(foo.Button_goto, "Label_goto")
    foo.Label_goto:setTextById(1300009)
    foo.Button_get = TFDirector:getChildByPath(foo.root, "Button_get")
    foo.Image_can_get = TFDirector:getChildByPath(foo.root, "Image_can_get")
    foo.Image_geted = TFDirector:getChildByPath(foo.root, "Image_geted")

    self.taskItems_[foo.root] = foo

    return Panel_taskItem
end

function KuangsanAssistView:updateTaskItem(index)
    local activityInfo = self.activityInfo_
    local itemInfo = self.taskData_[index]
    local progress = ActivityDataMgr2:getProgress(activityInfo.activityType, itemInfo.id)
    local progressInfo = ActivityDataMgr2:getProgressInfo(activityInfo.activityType, itemInfo.id)

    local item = self.ListView_task:getItem(index)
    local foo = self.taskItems_[item]

    foo.Label_task_desc:setText(itemInfo.extendData.des2)
    foo.Label_percent_value:setTextById(800005, progress, itemInfo.target)
    if progress > tonumber(itemInfo.target)  then
        foo.Label_percent_value:setTextById(800005, itemInfo.target, itemInfo.target)
    end

    local goodsId, goodsNum
    for i, v in ipairs(foo.Panel_items) do
        local id, num = next(itemInfo.reward, goodsId)
        if id then
            goodsId = id
            goodsNum = num
        end
        v.Panel_goodsItem:setVisible(tobool(id))
        if v.Panel_goodsItem:isVisible() then
            PrefabDataMgr:setInfo(v.Panel_goodsItem, goodsId, goodsNum)
        end
    end

    foo.Button_get:setVisible(progressInfo.status == EC_TaskStatus.GET)
    foo.Label_geted:setVisible(progressInfo.status == EC_TaskStatus.GETED)
    foo.Image_geted:setVisible(progressInfo.status == EC_TaskStatus.GETED)
    foo.Image_can_get:setVisible(progressInfo.status == EC_TaskStatus.GET)
    foo.Button_goto:setVisible(progressInfo.status == EC_TaskStatus.ING and itemInfo.extendData.jumpInterface)
    foo.Button_get:onClick(function()
            ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(activityInfo.id, itemInfo.id)
    end)
    foo.Button_goto:onClick(function()
            FunctionDataMgr:enterByFuncId(itemInfo.extendData.jumpInterface)
    end)
end

function KuangsanAssistView:updatePanelRank(data)
    if data.activityId == self.activityId then
        if data.myRank < 1 then
            self.Image_rank_bg:setVisible(false)
            self.Label_self_rank:setVisible(true)
            self.Label_self_rank:setTextById(263009)
        elseif data.myRank <= 3 then
            self.Image_rank_bg:setVisible(true)
            self.Label_self_rank:setVisible(false)
            local num = 37 + data.myRank
            self.Image_rank_bg:setTexture("ui/activity/assist/0"..num..".png")
        else
            local rankStr = tostring("NO."..data.myRank)
            if data.myRank > 10000 then
                rankStr = ">10000"
            end
            self.Label_self_rank:setText(rankStr)
            self.Image_rank_bg:setVisible(false)
            self.Label_self_rank:setVisible(true)
        end

        self.Image_self_head:setTexture(AvatarDataMgr:getSelfAvatarIconPath())
        local frame_icon,effect = AvatarDataMgr:getSelfAvatarFrameIconPath()
        self.Image_self_frame_cover:setTexture(frame_icon)
        self.Label_self_name:setText(MainPlayer:getPlayerName())
        self.Label_self_level:setText("LV."..MainPlayer:getPlayerLv())
        self.Label_self_rank_point:setText(tostring(math.max(0,data.myScore)))

        if self.isEnd and data.myRank > 0 and data.myRank <= self.realItemMinRank then
            self.Button_edit_address:show()
            self.Label_self_rank_point:setVisible(false)
        end

        if data.ranks then
            self.rankData = data.ranks
            local items = self.ListView_rank:getItems()
            local gap = #items - #self.rankData

            for i = 1, math.abs(gap) do
                if gap > 0 then
                    local item = self.ListView_rank:getItem(1)
                    self.ListView_rank:removeItem(1)
                else
                    local item = self.Panel_rank_item:clone()
                    self.ListView_rank:pushBackCustomItem(item)
                end
            end

            for index,v in ipairs(self.rankData) do
                local item = self.ListView_rank:getItem(index)
                local Image_bg = TFDirector:getChildByPath(item, "Image_bg")
                local Image_rank = TFDirector:getChildByPath(item, "Image_rank")
                local Label_rank = TFDirector:getChildByPath(item, "Label_rank")
                local Panel_info = TFDirector:getChildByPath(item, "Panel_info")
                local Image_head = TFDirector:getChildByPath(Panel_info, "Image_head")
                local Image_head_frame = TFDirector:getChildByPath(Panel_info, "Image_head_frame")
                local Image_head_frame_cover = TFDirector:getChildByPath(Panel_info, "Image_head_frame_cover")

                local Label_player_name = TFDirector:getChildByPath(item, "Label_player_name")
                local Label_level = TFDirector:getChildByPath(item, "Label_level")
                local Label_value = TFDirector:getChildByPath(item, "Label_value")

                if index %2 == 0 then
                    Image_bg:setTexture("ui/activity/assist/kuangsan/035.png")
                else
                    Image_bg:setTexture("ui/activity/assist/kuangsan/036.png")
                end
                if v.rank <= 3 then
                    Label_rank:setVisible(false)
                    Image_rank:setVisible(true)
                    local num = 37 + v.rank
                    Image_rank:setTexture("ui/activity/assist/0"..num..".png")
                else
                    Label_rank:setVisible(true)
                    Image_rank:setVisible(false)
                end

                Image_head:setTexture(AvatarDataMgr:getAvatarIconPath(v.headIcon))
                local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getAvatarFrameIconPath(v.frameCid)
                Image_head_frame_cover:setTexture(avatarFrameIcon)

                Label_rank:setText(tostring(v.rank))
                Label_player_name:setText(v.playerName)
                Label_level:setText("LV."..v.level)
                Label_value:setText(v.score)

                Panel_info:setTouchEnabled(false)
            end
        end
    end
end

function KuangsanAssistView:onGetAddressBack()
    Utils:openView("activity.AddressView")
end

function KuangsanAssistView:registerEvents()
    EventMgr:addEventListener(self, EV_ACTIVITY_ASSIST_PROGRESS, handler(self.updatePanelHead, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_ASSIST_RANKING, handler(self.updatePanelRank, self))
    EventMgr:addEventListener(self, EV_GET_ASSIST_ADDRESS, handler(self.onGetAddressBack, self))
    self.Button_reward_show:onClick(function()
        Utils:openView("activity.KuangsanAssistRewardView", self.activityId)
    end)

    self.Button_intro:onClick(function()
        Utils:openView("activity.KuangsanAssistIntroView")
    end)

    self.Button_edit_address:onClick(function()
        TFDirector:send(c2s.ACTIVITY_REQ_SUPPORT_ADDRESS, {})
    end)
end

function KuangsanAssistView:updateCountDonw()
    self.isEnd = ActivityDataMgr2:isEnd(self.activityId)
    local serverTime = ServerDataMgr:getServerTime()
    if self.isEnd then
        self.Label_activity_time:setTextById(219009)
    else
        local remainTime = math.max(0, self.activityInfo_.endTime - serverTime)
        local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
        if day == "00" then
            self.Label_activity_time:setTextById("r41002", hour, min)
        else
            self.Label_activity_time:setTextById("r41001", day, hour)
        end
    end
end

function KuangsanAssistView:onUpdateCountDownEvent()
    self:updateCountDonw()
end

function KuangsanAssistView:onUpdateProgressEvent()
     self:refreshView()
end

function KuangsanAssistView:onUpdateActivityEvent()
    self:refreshView()
end

function KuangsanAssistView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId ~= activitId then return end
    Utils:showReward(reward)
    ActivityDataMgr2:requestAssistProgress(self.activityId)
end

function KuangsanAssistView:onShow()
    self.super.onShow(self)
end

return KuangsanAssistView