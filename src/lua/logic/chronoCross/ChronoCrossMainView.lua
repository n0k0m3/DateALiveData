
local ChronoCrossMainView = class("ChronoCrossMainView", BaseLayer)
function ChronoCrossMainView:initData()

    self.chronoDressCfg = Utils:getKVP(46019,"chronoDressAI")

    local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.CHRONO_CROSS)
    self.activityId_ = activity[1]
    if self.activityId_ then
        self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    else
        Box("活动未开启")
        return
    end

    self.maxCnt = 0
    self.severTask = {}
    self.taskData = {}
    local itemIds = ActivityDataMgr2:getItems(self.activityId_)
    for k,v in ipairs(itemIds) do
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, v)
        if itemInfo.extendData.type == EC_ChronoCrossTaskType.Single then
            table.insert(self.taskData,v)
        end
        if itemInfo.extendData.type == EC_ChronoCrossTaskType.AllServer then
            table.insert(self.severTask,v)
            local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, v)
            self.maxCnt = self.maxCnt < itemInfo.target and itemInfo.target or self.maxCnt
        end
    end

end

function ChronoCrossMainView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.chronoCross.chronoCrossMainView")
end

function ChronoCrossMainView:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.Spine_sceneEffect = TFDirector:getChildByPath(self.ui, "Spine_sceneEffect"):hide()
    self.Spine_effectHB = TFDirector:getChildByPath(self.ui, "Spine_effectHB")
    self.Image_bg = TFDirector:getChildByPath(self.ui, "Image_bg")
    self.Image_role = TFDirector:getChildByPath(self.Panel_root, "Image_role")

    self.Label_rank_en = TFDirector:getChildByPath(self.Panel_root, "Label_rank_en")
    self.Label_rank_en:setText("R  /  a  /  n  /  k  /  i  /  n  /  g")

    self.Panel_touch = TFDirector:getChildByPath(self.Panel_root, "Panel_touch")
    self.Panel_touch:setSize(GameConfig.WS)

    self.Label_percent = TFDirector:getChildByPath(self.Panel_root, "Label_percent")
    self.Label_percent_symbol = TFDirector:getChildByPath(self.Panel_root, "Label_percent_symbol")
    self.Image_bar = TFDirector:getChildByPath(self.Panel_root, "Image_bar")
    self.LoadingBar = TFDirector:getChildByPath(self.Panel_root, "LoadingBar")
    self.Panel_spineBg = TFDirector:getChildByPath(self.Panel_root, "Panel_spineBg")
    self.Spine_point = TFDirector:getChildByPath(self.Panel_root, "Spine_point")
    self.Spine_bar = TFDirector:getChildByPath(self.Panel_root, "Spine_bar")
    self.Spine_finish = TFDirector:getChildByPath(self.Panel_root, "Spine_finish"):hide()
    self.Spine_notfinish = TFDirector:getChildByPath(self.Panel_root, "Spine_notfinish"):hide()
    self.originalSize = self.Panel_spineBg:getContentSize()
    self.rankPL = {}
    for i=1,3 do
        local Panel_rankItem = TFDirector:getChildByPath(self.Panel_root, "Panel_rankItem"..i)
        local Label_rank_num = TFDirector:getChildByPath(Panel_rankItem, "Label_rank_num")
        local Label_name = TFDirector:getChildByPath(Panel_rankItem, "Label_name")
        table.insert(self.rankPL,{pl = Panel_rankItem,rankTx = Label_rank_num,nameTx = Label_name})
    end

    local ScrollView_report = TFDirector:getChildByPath(self.Panel_root, "ScrollView_report")
    self.ListView_report = UIListView:create(ScrollView_report)

    self.Label_tip = TFDirector:getChildByPath(self.Panel_root, "Label_tip")
    self.Label_achieve = TFDirector:getChildByPath(self.Panel_root, "Label_achieve")
    self.Image_redtip = TFDirector:getChildByPath(self.Panel_root, "Image_redtip"):hide()
    self.Button_dating = TFDirector:getChildByPath(self.Panel_root, "Button_dating")
    self.Button_achieve = TFDirector:getChildByPath(self.Panel_root, "Button_achieve")
    self.Image_finish = TFDirector:getChildByPath(self.Panel_root, "Image_finish")

    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
    self.Panel_rankItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_rankItem")
    self.Panel_reportItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_reportItem")
    self.Panel_awardItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_awardItem")

    self:updateServerPoint()
    self:updateTask()
    self:showModelInfo()
    self:updateRankList()
    self:initReportList()
    self:updateItem()

    local act = CCSequence:create({
        CCDelayTime:create(5),
        CCCallFunc:create(function()
            TFDirector:send(c2s.ACTIVITY_REQ_GET_ZZALL_SERVER,{})
            TFDirector:send(c2s.ACTIVITY_REQ_ACTIVITY_NOTICE,{})
        end)
    })
    self.Panel_root:runAction(CCRepeatForever:create(act))
end

function ChronoCrossMainView:onShow()
    self.super.onShow(self)
    if not self.model then
        self:createMode()
    end
end

function ChronoCrossMainView:onHide()
    self.super.onHide(self)
    if self.model then
        self.model:removeFromParent()
        self.model = nil
    end
end

function ChronoCrossMainView:createMode()

    local dressTable = TabDataMgr:getData("Dress")
    local data = dressTable[410216]
    if data and data.type and data.type == 2 then
        self.model = ElvesNpcTable:createLive2dNpcID(data.highRoleModel,false,false,nil,false).live2d
        self.model:setTouchEnabled(false)
        self.Image_role:addChild(self.model,1)
        self.model:setScale(0.7); --缩放
        local pos = ccp(330,-50)
        self.model:setPosition(pos);--位置
    end
end

function ChronoCrossMainView:showModelInfo()

    self:createMode()

    local dressTable = TabDataMgr:getData("Dress")
    local data = dressTable[410216]
    if data and data.type and data.type == 2 then

        if data.backgroundEffect and data.backgroundEffect ~= 0 then
            self:refreshEffect(data.backgroundEffect,true)
        end

        if data.kanbanEffect and data.kanbanEffect ~= 0 then
            self:refreshEffect(data.kanbanEffect)
        end
        self.sceneBg = data.background
        self.Image_bg:setTexture(self.sceneBg)

        ---播放随机动作
        local stage = 1
        for k,v in ipairs(self.severTask) do
            local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, v)
            local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, v)
            if progressInfo.progress <= itemInfo.target then
                stage = k
            end
        end

        local dressAiId= self.chronoDressCfg[stage]
        if not dressAiId then
            return
        end
        local config = TabDataMgr:getData("DressAI", dressAiId)
        if not config then
            return
        end
        local index = math.random(1,#config.action)
        local waitFirstTimeIndex = math.random(1,#config.timeRandomFirst)
        local secondTimeIndex = math.random(1,#config.timeRandom)
        local secondActIndex = math.random(1,#config.action)
        local actionName = config.action[index]
        local firstTime = config.timeRandomFirst[waitFirstTimeIndex]
        local secondTime = config.timeRandom[secondTimeIndex]
        local actionName2 = config.action[secondActIndex]
        self:timeOut(function()
            if self.model then
                self.model:newStartAction(actionName,EC_PRIORITY.FORCE)
            end
            self:timeOut(function()
                if self.model then
                    self.model:newStartAction(actionName2,EC_PRIORITY.FORCE)
                end
            end,secondTime)
        end,firstTime)
    end
end

function ChronoCrossMainView:refreshEffect(effectIds,isBgEffect)
    local mgrTab = nil
    local prefab = nil
    if not isBgEffect then
        mgrTab = self.effectSK or {}
        self.effectSK = mgrTab
        prefab = self.Spine_sceneEffect
    else
        mgrTab = self.effectSKB or {}
        self.effectSKB = mgrTab
        prefab = self.Spine_effectHB
    end

    for k,v in pairs(mgrTab) do
        v:removeFromParent()
        mgrTab[k] = nil
    end

    if type(effectIds) ~= "table" then
        local effectId = effectIds
        effectIds = {effectId}
    end

    for k,effectId in pairs(effectIds) do
        mgrTab[effectId] = Utils:createEffectByEffectId(effectId)
        if not mgrTab[effectId] then
            return
        end

        mgrTab[effectId]:setPosition(prefab:getPosition())
        prefab:getParent():addChild(mgrTab[effectId], prefab:getZOrder())
    end
end

function ChronoCrossMainView:updateRankList()

    local myName = MainPlayer:getPlayerName()
    local rankData = ChronoCrossDataMgr:getRankData()
    table.sort(rankData,function(a,b)
        return a.ranking < b.ranking
    end)
    for k,v in ipairs(self.rankPL) do
        local rankInfo = rankData[k]
        if rankInfo then
            v.pl:setVisible(true)
            local color = myName == rankInfo.playerName and ccc3(93,255,221) or ccc3(255,255,255)
            v.rankTx:setColor(color)
            v.nameTx:setColor(color)
            v.rankTx:setText(rankInfo.ranking)
            v.nameTx:setText(rankInfo.playerName)
        else
            v.pl:setVisible(false)
        end
    end
end

function ChronoCrossMainView:updateServerPoint()
    local point = ChronoCrossDataMgr:getServerPoint()
    point = point >= self.maxCnt and self.maxCnt or point

    local percent = math.floor(point/self.maxCnt*100)
    local deltaX = percent >= 98 and -20 or -16
    self.LoadingBar:setPercent(percent)
    local isMax = point >= self.maxCnt
    local color = isMax and ccc3(255,255,255) or ccc3(87,171,229)
    self.Label_percent:setText(percent)
    self.Label_percent:setColor(color)
    self.Spine_finish:setVisible(isMax)
    self.Image_finish:setVisible(isMax)
    self.Spine_notfinish:setVisible(not isMax)
    local w = self.originalSize.width*point/self.maxCnt
    local barX = 320 * point/self.maxCnt
    local pointX = -320 + 642 *point/self.maxCnt
    self.Spine_bar:setPositionX(barX)
    self.Spine_point:setPositionX(pointX+deltaX)
    self.Panel_spineBg:setContentSize(CCSizeMake(w, self.originalSize.height))
    local w = self.Label_percent:getContentSize().width
    self.Label_percent_symbol:setPositionX(w/2-7)
    self.Label_percent_symbol:setColor(color)
end

function ChronoCrossMainView:initReportList()

    self.ListView_report:removeAllItems()
    local reportList = ChronoCrossDataMgr:getReportList()
    for k,v in ipairs(reportList) do
        self:updateReportItem(v)
    end
    self.ListView_report:jumpToBottom()
end

function ChronoCrossMainView:updateReportItem(data,isNewItem)

    local Panel_reportItem = self.Panel_reportItem:clone()
    local Label_report = Panel_reportItem:getChildByName("Label_report")
    local Image_icon = Panel_reportItem:getChildByName("Image_icon")
    local Label_value = Panel_reportItem:getChildByName("Label_value")
    Label_report:setText("【"..data.name.."】收集了")
    Label_value:setText("x"..data.value)
    local itemCfg = GoodsDataMgr:getItemCfg(500070)
    Image_icon:setTexture(itemCfg.icon)
    local myName = MainPlayer:getPlayerName()
    local color = myName == data.name and ccc3(93, 255, 221) or ccc3(106, 121, 151)
    Label_report:setColor(color)
    Label_value:setColor(color)
    local w = Label_report:getContentSize().width
    Image_icon:setPositionX(9+w)
    Label_value:setPositionX(9+w+28)
    self.ListView_report:pushBackCustomItem(Panel_reportItem)
end

function ChronoCrossMainView:insertReportItem()
    local reportList = ChronoCrossDataMgr:getReportList()
    if not next(reportList) then
        return
    end
    self:updateReportItem(reportList[#reportList],true)
    self.ListView_report:scrollToBottom()
end

function ChronoCrossMainView:updateServerTask()

    local w = self.Image_bar:getContentSize().width
    local startPosX = -w/2

    for k,taskId in ipairs(self.severTask) do
        local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, taskId)
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, taskId)
        local itemId,itemNum
        for cid, num in pairs(itemInfo.reward) do
            itemId = cid
            itemNum = num
        end

        local Panel_awardItem = self.Image_bar:getChildByName("Panel_awardItem"..k)
        if not Panel_awardItem then
            Panel_awardItem = self.Panel_awardItem:clone()
            Panel_awardItem:setName("Panel_awardItem"..k)
            self.Image_bar:addChild(Panel_awardItem)

            --local Image_bg = Panel_awardItem:getChildByName("Image_bg")
            --if itemId then
            --    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            --    Panel_goodsItem:setTouchEnabled(false);
            --    Panel_goodsItem:setPosition(ccp(0,0))
            --    PrefabDataMgr:setInfo(Panel_goodsItem,itemId)
            --    Image_bg:addChild(Panel_goodsItem)
            --end

            local Label_num = Panel_awardItem:getChildByName("Label_num")
            local percent = math.floor(itemInfo.target/self.maxCnt*100)
            Label_num:setText(percent.."%")
            local x = itemInfo.target/self.maxCnt*w + startPosX
            Panel_awardItem:setPosition(ccp(x,41))
        end

        local isReceive = progressInfo.status == EC_TaskStatus.GET
        local isGeted = progressInfo.status == EC_TaskStatus.GETED
        local isIng = progressInfo.status == EC_TaskStatus.ING
        local Image_geted = Panel_awardItem:getChildByName("Image_geted")
        local Image_bg = Panel_awardItem:getChildByName("Image_bg")
        local Spine_box = Panel_awardItem:getChildByName("Spine_box")
        Spine_box:play("animation",true)
        Image_geted:setVisible(isGeted)
        Image_bg:setGrayEnabled(isGeted)
        Spine_box:setVisible(isReceive)
        Panel_awardItem:onClick(function()
            if isReceive then
                ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId_,taskId)
            else
                Utils:showInfo(itemId)
            end
        end)
    end
end

function ChronoCrossMainView:updateRedPoint()

    if not self.activityInfo_ then
        return
    end
    local isShow = false
    for _, itemId in ipairs(self.taskData) do
        local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, itemId)
        if progressInfo and progressInfo.status == EC_TaskStatus.GET then
            isShow = true
            break
        end
    end
    self.Image_redtip:setVisible(isShow)
end

function ChronoCrossMainView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId_ ~= activitId then return end
    Utils:showReward(reward)
    self:updateTask()
end

function ChronoCrossMainView:onUpdateProgressEvent()
    self:updateTask()
end

function ChronoCrossMainView:updateTask()
    self:updateRedPoint()
    self:updateServerTask()
end

function ChronoCrossMainView:updateItem()
    local itemCfg = GoodsDataMgr:getItemCfg(500070)
    if not itemCfg then
        return
    end
    local cunt = GoodsDataMgr:getItemCount(500070)
    self.Label_achieve:setText(cunt)
    self.Label_tip:setTextById(itemCfg.nameTextId)
end

function ChronoCrossMainView:registerEvents()
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.updateItem, self))
    EventMgr:addEventListener(self, EV_UPDATE_NOTICE, handler(self.insertReportItem, self))
    EventMgr:addEventListener(self, EV_UPDATE_SERVERPOINT, handler(self.updateServerPoint, self))
    EventMgr:addEventListener(self, EV_UPDATE_CHRONOCROSS_RANK, handler(self.updateRankList, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onUpdateProgressEvent, self))

    self.Button_dating:onClick(function()
        if self.model then
            self.model:removeFromParent()
            self.model = nil
        end
        Utils:openView("chronoCross.ChronoCrossDating")
    end)

    self.Button_achieve:onClick(function()
        Utils:openView("chronoCross.ChronoCrossTaskView")
    end)
end

return ChronoCrossMainView
