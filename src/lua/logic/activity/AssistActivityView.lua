
local AssistActivityView = class("AssistActivityView", BaseLayer)

function AssistActivityView:initData(activityId)
    self.activityId_ = activityId
end

function AssistActivityView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.assistActivityView")
end

function AssistActivityView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")

    self.Panel_assist_cg_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_assist_cg_item")
    self.Panel_rewardItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_rewardItem")
    self.Label_timing = TFDirector:getChildByPath(self.Panel_root, "Label_timing")

    self.Button_assist_ranking = TFDirector:getChildByPath(self.Panel_root, "Button_assist_ranking")
    self.Button_assist_rank_reward = TFDirector:getChildByPath(self.Panel_root, "Button_assist_rank_reward")
    self.Button_assist_big_reward = TFDirector:getChildByPath(self.Panel_root, "Button_assist_big_reward")
    self.Button_assist_get = TFDirector:getChildByPath(self.Panel_root, "Button_assist_get")
    self.Label_server_assist = TFDirector:getChildByPath(self.Panel_root, "Label_server_assist")
    self.Label_server_assist_value = TFDirector:getChildByPath(self.Panel_root, "Label_server_assist_value")
    self.Label_timing = TFDirector:getChildByPath(self.Panel_root, "Label_timing")
    self.Panel_assist_process = TFDirector:getChildByPath(self.Panel_root, "Panel_assist_process"):hide()
    self.Panel_cg_process = TFDirector:getChildByPath(self.Panel_root, "Panel_cg_process"):hide()
    local Label_rank_reward = TFDirector:getChildByPath(self.Panel_root, "Label_rank_reward")
    Label_rank_reward:setTextById(263000)
    local ScrollView_cg = TFDirector:getChildByPath(self.Panel_root, "ScrollView_cg")
    self.Image_big_cg = TFDirector:getChildByPath(self.Panel_root, "Image_big_cg")

    self.ScrollView_cg = UIGridView:create(ScrollView_cg)
    self.ScrollView_cg:setItemModel(self.Panel_assist_cg_item)
    self.ScrollView_cg:setColumn(6)
    self.ScrollView_cg:setColumnMargin(-30)
    self.ScrollView_cg:setRowMargin(-30)
    ScrollView_cg:setTouchEnabled(false)
    self.Image_big_cg:setVisible(false)
    self.ScrollView_cg:setVisible(false)

    self:refreshView()
end

function AssistActivityView:updateActivity()
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    if self.activityInfo_.activityType ~= EC_ActivityType2.ASSIST then
        return
    end
    self.Panel_assist_process:show()
    self.Panel_cg_process:show()
    self.Label_server_assist:setSkewX(5)
    self.Label_server_assist_value:setSkewX(5)
    self.Label_server_assist:setTextById(263002)
    self.Image_big_cg:setTexture(self.activityInfo_.showIcon)
    self.Image_big_cg:setSize(CCSizeMake(632, 286))

    local items = self.ScrollView_cg:getItems()
    local cgdata = ActivityDataMgr2:getAssistItemInfos(self.activityId_, EC_Activity_Assist_Subtype.CG_LIST)
    local gap = #items - #cgdata
    for i = 1, math.abs(gap) do
        if gap > 0 then
            self.ScrollView_cg:removeItem(1)
        else
            local cgItem = self.Panel_assist_cg_item:clone()
            self.ScrollView_cg:pushBackCustomItem(cgItem)
        end
    end

    for i, cgItem in ipairs(self.ScrollView_cg:getItems()) do
        local itemInfo = cgdata[i]
        local Image_cg = TFDirector:getChildByPath(cgItem, "Image_cg")
        Image_cg:setTexture(itemInfo.extendData.icon)
    end
    self.Image_big_cg:setVisible(true)
    self.ScrollView_cg:setVisible(true)

    self.Button_assist_big_reward:setVisible(false)

    self:updateAssistStageReward(self.activityInfo_)
    self:updateAssistCgUnlock(self.activityInfo_)
    self:updateCountDonw()

    ActivityDataMgr2:requestAssistProgress(self.activityId_)
end

function AssistActivityView:onUpdateAssistUI(data)
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    if self.activityInfo_.activityType ~= EC_ActivityType2.ASSIST then
        return
    end
    self.Label_server_assist_value:setText(tostring(data.process))

    local cgdata = ActivityDataMgr2:getAssistItemInfos(self.activityId_, EC_Activity_Assist_Subtype.CG_LIST)
    local unlockNum = 0
    local delay = 0
    local lastNum = CCUserDefault:sharedUserDefault():getIntegerForKey("assist_cg_unlock_num") or 0
    for i, cgItem in ipairs(self.ScrollView_cg:getItems()) do
        local itemInfo = cgdata[i]
        local Image_cg = TFDirector:getChildByPath(cgItem, "Image_cg")
        local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, itemInfo.id)
        Image_cg:setVisible(true)
        if itemInfo.target > data.process then

        else
            unlockNum = unlockNum + 1
            if itemInfo.rank > lastNum then
                local arr = {}
                table.insert(arr, CCDelayTime:create(delay))
                table.insert(arr, CCFadeOut:create(0.2))
                Image_cg:runAction(CCSequence:create(arr))
                delay = delay + 0.2
            else
                Image_cg:setVisible(false)
            end
        end

        Image_cg:setTouchEnabled(true)
        Image_cg:onClick(function()
            if itemInfo.target > data.process  then
                Utils:showTips(TextDataMgr:getText(263003, itemInfo.target))
            end
        end)
    end
    CCUserDefault:sharedUserDefault():setIntegerForKey("assist_cg_unlock_num", unlockNum)

    local isEnd = ActivityDataMgr2:isEnd(self.activityId_)
    local progressData = ActivityDataMgr2:getAssistProgressData()
    self.Button_assist_big_reward:setVisible(false)
    if progressData and progressData.myRank > 0 and progressData.myRank <= progressData.realItemMinRank then
        if isEnd then
            self.Button_assist_big_reward:setVisible(true)
        end
    end

    self.Button_assist_big_reward:onClick(function()
        if isEnd then
            Utils:showWebView("http://smi.datealive.com/yhdzz/infoSubmit?groupid=3&pfid=101")
        else
            Utils:showTips(263006)
        end
    end)
end

function AssistActivityView:updateAssistStageReward(activityInfo)
    local Label_self_assist = TFDirector:getChildByPath(self.Panel_assist_process, "Label_self_assist")
    local Label_self_assist_value = TFDirector:getChildByPath(self.Panel_assist_process, "Label_self_assist_value")
    local Image_self_progress_bg = TFDirector:getChildByPath(self.Panel_assist_process, "Image_self_progress_bg")
    Label_self_assist:setTextById(263005)
    local Image_assist_boxbg = {}
    local Label_assist = {}
    local Image_assist_box = {}
    local LoadingBar_assist = {}
    for i = 1, 5 do
        table.insert(Image_assist_boxbg, TFDirector:getChildByPath(self.Panel_assist_process, "Image_assist_boxbg"..i))
        table.insert(Label_assist, TFDirector:getChildByPath(self.Panel_assist_process, "Label_assist"..i))
        table.insert(Image_assist_box, TFDirector:getChildByPath(self.Panel_assist_process, "Image_assist_box"..i))
        table.insert(LoadingBar_assist, TFDirector:getChildByPath(Image_self_progress_bg, "LoadingBar_assist"..i))
    end
    local rewardData = ActivityDataMgr2:getAssistItemInfos(activityInfo.id, EC_Activity_Assist_Subtype.STAGE_REWARD)
    local maxCount = #rewardData
    for i=1,5 do
        if i > maxCount then
            Image_assist_boxbg[i]:setVisible(false)
            Label_assist[i]:setVisible(false)
            Image_assist_box[i]:setVisible(false)
            LoadingBar_assist[i]:setVisible(false)
        else
            Image_assist_boxbg[i]:setVisible(true)
            Label_assist[i]:setVisible(true)
            Image_assist_box[i]:setVisible(true)
            LoadingBar_assist[i]:setVisible(true)
        end
    end
    if  maxCount == 5 then
        Image_self_progress_bg:setSize(CCSizeMake(545, 22))
    elseif maxCount == 4 then
        Image_self_progress_bg:setSize(CCSizeMake(436, 22))
    else
        Image_self_progress_bg:setSize(CCSizeMake(316, 22))
    end
    local maxValue = 0
    local targets = {}
    for k, v in pairs(rewardData) do
        maxValue = math.max(maxValue, v.target)
        targets[#targets + 1] = v.target
    end
    local selfValue = GoodsDataMgr:getItemCount(500028)
    Label_self_assist_value:setText(tostring(selfValue))

    for i,v in ipairs(rewardData) do
        if selfValue >= v.target then
            LoadingBar_assist[i]:setPercent(100)
        else
            if i == 1 then
                local percent = selfValue / v.target * 100
                LoadingBar_assist[i]:setPercent(percent)
            else
                local minScore = math.max(selfValue - targets[i - 1], 0)
                local percent = minScore / (v.target - targets[i - 1]) * 100
                LoadingBar_assist[i]:setPercent(percent)
            end
        end
    end

    for i,assist_box in ipairs(Image_assist_box) do
        local data = rewardData[i]
        if data then
            Label_assist[i]:setText(tostring(data.target))
            local img_red = TFDirector:getChildByPath(assist_box, "Image_red")
            img_red:setVisible(false)
            local progressInfo = ActivityDataMgr2:getProgressInfo(activityInfo.activityType, data.id)
            if progressInfo.status == EC_Assist_Item_Status.ING then
                assist_box:setTexture("ui/activity/assist/021.png")
            elseif progressInfo.status == EC_Assist_Item_Status.GET then
                img_red:setVisible(true)
                assist_box:setTexture("ui/activity/assist/021.png")
            else
                assist_box:setTexture("ui/activity/assist/020.png")
            end
        end
        assist_box:setTouchEnabled(true)
        assist_box:onClick(function()
            local progressInfo = ActivityDataMgr2:getProgressInfo(activityInfo.activityType, data.id)
            if progressInfo.status == EC_Assist_Item_Status.ING or progressInfo.status == EC_Assist_Item_Status.GETED then
                local visible = self.Panel_preview:isVisible()
                self.Panel_preview:setVisible(not visible or self.lastSelect ~= i)
                if self.Panel_preview:isVisible() then
                    self.lastSelect = i
                end
                self:showPreview(assist_box, data)
            elseif progressInfo.status == EC_Assist_Item_Status.GET then
                ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(activityInfo.id, data.id)
            end
        end)
    end
    if not self.Panel_preview then
        self.lastSelect = nil
        self.Panel_preview = TFDirector:getChildByPath(self.Panel_assist_process, "Panel_preview"):hide()
        self.Image_preview_zs = TFDirector:getChildByPath(self.Panel_preview, "Image_preview_zs")
        self.Image_preview_diban = TFDirector:getChildByPath(self.Panel_preview, "Image_preview_diban")
        local size_zs = self.Image_preview_zs:Size()
        local size_diban = self.Image_preview_diban:Size()
        self.previewOffsetHeight_ = size_zs.height - size_diban.height
        local ScrollView_preview = TFDirector:getChildByPath(self.Panel_preview, "ScrollView_preview")
        self.ListView_preview = UIListView:create(ScrollView_preview)

        self.Panel_touch = TFDirector:getChildByPath(self.Panel_root, "Panel_touch")
        self.Panel_touch:setSwallowTouch(false)
        self.Panel_touch:setSize(GameConfig.WS)
        self.Panel_touch:onTouch(function()
            self.Panel_preview:hide()
        end)
    end
end

function AssistActivityView:showPreview(node, data)
    self.ListView_preview:removeAllItems()
   for k,v in pairs(data.reward) do
        local itemCfg = GoodsDataMgr:getItemCfg(k)
        local Panel_rewardItem = self.Panel_rewardItem:clone()
        local Panel_icon = TFDirector:getChildByPath(Panel_rewardItem, "Panel_icon")
        local Label_name = TFDirector:getChildByPath(Panel_rewardItem, "Label_name")
        local Label_desc = TFDirector:getChildByPath(Panel_rewardItem, "Label_desc")
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:Scale(0.8)
        PrefabDataMgr:setInfo(Panel_goodsItem, k, v)
        Panel_goodsItem:AddTo(Panel_icon):Pos(0, 0)
        Label_name:setTextById(itemCfg.nameTextId)
        Label_desc:setTextById(itemCfg.desTextId)
        self.ListView_preview:pushBackCustomItem(Panel_rewardItem)
    end
    Utils:setAliginCenterByListView(self.ListView_preview)

    self.ListView_preview:s():Pos(0, 0)
    local size = self.ListView_preview:getContentSize()
    local size1 = self.Panel_preview:Size()
    size1.height = size.height
    self.Panel_preview:Size(size1):Pos(0, 0)
    local size2 = self.Image_preview_diban:Size()
    size2.height = size.height
    self.Image_preview_diban:Size(size2):Pos(0, 0)
    local size3 = self.Image_preview_zs:Size()
    size3.height = size2.height + self.previewOffsetHeight_
    self.Image_preview_zs:Size(size3):Pos(0, 10)

    local pos = node:Pos()
    pos.y = pos.y - 30
    pos.x = math.min(pos.x, 220)
    self.Panel_preview:Pos(pos)
end

function AssistActivityView:updateAssistCgUnlock(activityInfo)
    local Image_line = {}
    local Image_cglock = {}
    local Image_cg_bg = {}
    local Image_cg = {}
    local Label_cg_tips = {}
    for i = 1, 3 do
        table.insert(Image_line, TFDirector:getChildByPath(self.Panel_cg_process, "Image_line"..i))
        table.insert(Image_cglock, TFDirector:getChildByPath(self.Panel_cg_process, "Image_cglock"..i))
        table.insert(Image_cg_bg, TFDirector:getChildByPath(self.Panel_cg_process, "Image_cg_bg"..i))
        table.insert(Label_cg_tips, TFDirector:getChildByPath(self.Panel_cg_process, "Label_cg_tips"..i))
        table.insert(Image_cg, TFDirector:getChildByPath(self.Panel_cg_process, "Image_cg"..i))
    end
    local unlockData = ActivityDataMgr2:getAssistItemInfos(activityInfo.id, EC_Activity_Assist_Subtype.CG_UNLOCK)
    local maxValue = 1
    for k, v in pairs(unlockData) do
        maxValue = math.max(maxValue, v.target)
    end
    local selfValue = ActivityDataMgr2:getAssistCgUnlockNum(activityInfo.id, EC_Activity_Assist_Subtype.CG_UNLOCK)

    for i,cg_img in ipairs(Image_cg) do
        local itemInfo = unlockData[i]
        local tipsDes = ""
        local numIndex = ActivityDataMgr2:getCgRankIndex(activityInfo.id, itemInfo.target)
        if numIndex > 0 then
            tipsDes = TextDataMgr:getText(263004, numIndex)
        end
        Label_cg_tips[i]:setText(tipsDes)

        local progressInfo = ActivityDataMgr2:getProgressInfo(activityInfo.activityType, itemInfo.id)
        local img_red = TFDirector:getChildByPath(Image_cg[i], "Image_red")
        img_red:setVisible(false)
        if progressInfo.status ~= EC_Assist_Item_Status.ING then
            Image_line[i]:setTexture("ui/activity/assist/029.png")
            Image_cg[i]:setTexture(itemInfo.extendData.icon)
            Image_cg[i]:setVisible(true)
            Image_cg[i]:setSize(CCSizeMake(80, 70))
            Image_cglock[i]:setVisible(false)
            Label_cg_tips[i]:setVisible(false)
            if progressInfo.status == EC_Assist_Item_Status.GET then
                img_red:setVisible(true)
            end
            local flag = CCUserDefault:sharedUserDefault():getStringForKey("assist_dating_play"..itemInfo.extendData.jumpInterface)
            if flag ~= "play" then
                local spineUnlock = SkeletonAnimation:create("effect/effect_ui6/effect_ui6")
                spineUnlock:setPosition(ccp(0, 0))
                spineUnlock:playByIndex(0, -1, -1, 0)
                Image_cg[i]:addChild(spineUnlock, 10)
                spineUnlock:addMEListener(TFARMATURE_COMPLETE,function()
                    spineUnlock:setVisible(false)
                end)
                CCUserDefault:sharedUserDefault():setStringForKey("assist_dating_play"..itemInfo.extendData.jumpInterface, "play")
            end
        else
            Image_line[i]:setTexture("ui/activity/assist/028.png")
            Image_cglock[i]:setTexture("ui/activity/assist/049.png")
            Image_cglock[i]:setSize(CCSizeMake(97, 93))
            Image_cg[i]:setVisible(false)
            Image_cglock[i]:setVisible(true)
            Label_cg_tips[i]:setVisible(true)
        end
        Image_line[1]:setSize(CCSizeMake(51, 2))
        Image_line[2]:setSize(CCSizeMake(107, 2))
        Image_line[3]:setSize(CCSizeMake(51, 2))
        Image_cg_bg[i]:setVisible(true)
        Image_cg_bg[i]:setTouchEnabled(true)
        Image_cg_bg[i]:onClick(function()
            progressInfo = ActivityDataMgr2:getProgressInfo(activityInfo.activityType, itemInfo.id)
            if progressInfo.status ~= EC_Assist_Item_Status.ING then
                local jump = itemInfo.extendData.jumpInterface
                local datingRuleCfg = TabDataMgr:getData("DatingRule", jump)
                local start_node_id = datingRuleCfg.start_node_id
                local scriptId = datingRuleCfg.scriptId
                DatingDataMgr:setScriptTableName(datingRuleCfg.callTableName)
                if progressInfo.status == EC_Assist_Item_Status.GET then
                    self.datingId_ = jump
                    self.itemId_ = itemInfo.id
                end
                DatingDataMgr:startDating(jump)
                -- DatingDataMgr:showDatingLayer(datingRuleCfg.type, start_node_id, nil, nil, nil, progressInfo.status == EC_Assist_Item_Status.GET)
            else
                Utils:showTips(263007)
            end
        end)
    end
end

function AssistActivityView:onShow()
    self.super.onShow(self)
    if self.itemId_ then
        self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
        local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, self.itemId_)
        if progressInfo.status ~= EC_Assist_Item_Status.GETED then
            ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId_, self.itemId_)
        end
    end
    self.itemId_ = nil
end

function AssistActivityView:onOpenAssistRanking(data)
    if self.activityInfo_.activityType ~= EC_ActivityType2.ASSIST then
        return
    end
    local score = GoodsDataMgr:getItemCount(500028)
    Utils:openView("activity.AssistRankingView", data, score, 2109027)
end

function AssistActivityView:onDatingCompleted(datingId)
    if self.itemId_ then
        self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
        local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, self.itemId_)
        if progressInfo.status ~= EC_Assist_Item_Status.GETED then
            ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId_, self.itemId_)
        end
    end
    self.itemId_ = nil
end


function AssistActivityView:refreshView()

end

function AssistActivityView:updateCountDonw()
    local isEnd = ActivityDataMgr2:isEnd(self.activityId_)
    local serverTime = ServerDataMgr:getServerTime()
    if isEnd then
        local remainTime = math.max(0, self.activityInfo_.showEndTime - serverTime)
        local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
        if hour == "00" and min ~= "00" then
            hour = "01"
        end
        self.Label_timing:setTextById("r120002", day, hour)
    else
        local remainTime = math.max(0, self.activityInfo_.endTime - serverTime)
        local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
        if hour == "00" and min ~= "00" then
            hour = "01"
        end
        self.Label_timing:setTextById("r120001", day, hour)
    end
end

function AssistActivityView:registerEvents()
    EventMgr:addEventListener(self, EV_ACTIVITY_ASSIST_PROGRESS, handler(self.onUpdateAssistUI, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_ASSIST_RANKING, handler(self.onOpenAssistRanking, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.datingcompleted, handler(self.onDatingCompleted, self))

    self.Button_assist_ranking:onClick(function()
        ActivityDataMgr2:requestAssistRanking(self.activityId_)
    end)

    self.Button_assist_rank_reward:onClick(function()
        local data = ActivityDataMgr2:getAssistItemInfos(self.activityId_, EC_Activity_Assist_Subtype.RANK_REWARD)
        Utils:openView("activity.AssistRankRewardView", data, 263100)
    end)

    self.Button_assist_get:onClick(function()
        Utils:openView("bag.ItemAccessView", 500028)
    end)
end

function AssistActivityView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId_ ~= activitId then return end

    if reward and table.count(reward) > 0 then
        local cgItems = {}
        for i, v in ipairs(reward) do
            local itemCfg = GoodsDataMgr:getItemCfg(v.id)
            if itemCfg and itemCfg.superType == EC_ResourceType.SKIN then
                table.insert(cgItems, v)
            end
        end
        if #cgItems > 0 then
            local view = requireNew("lua.logic.common.GetCgItemView"):new(cgItems)
            AlertManager:addLayer(view,AlertManager.BLOCK_AND_GRAY_CLOSE)
            AlertManager:show()
        else
            Utils:showReward(reward)
        end
    end
end

function AssistActivityView:onUpdateProgressEvent()
    self:updateActivity()
end

function AssistActivityView:onUpdateCountDownEvent()
    self:updateCountDonw()
end

return AssistActivityView
