local LeagueTrainingView = class("LeagueTrainingView", BaseLayer)

function LeagueTrainingView:ctor()
    self.super.ctor(self)
    self:initData()
    self:init("lua.uiconfig.league.leagueTrainingView")
end

function LeagueTrainingView:initData()
    self.showModel = nil
    self.curThemeId = -1
    self.stageItems = {}
    self.briefActionFinish = true
    self.themeList = nil
    self.curSelThemeIdx = nil
    self.initSuccess = false
    self.activeItem_ = {}
    self.maxStage_ = LeagueDataMgr:getUnionTrainingMaxActiveStage()
    self.avtiveData_ = LeagueDataMgr:getUnionTrainingActiveInfo()
end

function LeagueTrainingView:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui

    local Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
    self.Panel_stage_item = TFDirector:getChildByPath(Panel_prefab, "Panel_stage_item")
    self.Panel_activeItem = TFDirector:getChildByPath(Panel_prefab, "Panel_activeItem")
    self.Panel_themeItem = TFDirector:getChildByPath(Panel_prefab, "Panel_themeItem")

    local Panel_info = TFDirector:getChildByPath(ui, "Panel_info")
    self.Label_revertTime = TFDirector:getChildByPath(ui, "Label_revertTime")
    self.Button_stage = TFDirector:getChildByPath(ui, "Button_stage")
    self.Image_box = TFDirector:getChildByPath(ui, "Image_box")
    self.Image_stage_red = TFDirector:getChildByPath(ui, "Image_stage_red")
    self.Spine_stage = TFDirector:getChildByPath(ui, "Spine_stage")

    self.Panel_theme = TFDirector:getChildByPath(ui, "Panel_theme")
    self.ListView_theme = UIListView:create(TFDirector:getChildByPath(self.Panel_theme, "ScrollView_theme"))
    self.ListView_theme:setItemsMargin(2)
    local Panel_active = TFDirector:getChildByPath(ui, "Panel_active")
    self.Image_active_progress = TFDirector:getChildByPath(Panel_active, "Image_active_progress")
    self.LoadingBar_activeProgress = TFDirector:getChildByPath(self.Image_active_progress, "LoadingBar_activeProgress")
    self.Image_activeIcon = TFDirector:getChildByPath(Panel_active, "Image_activeIcon")
    self.Label_activeTitle = TFDirector:getChildByPath(Panel_active, "Label_activeTitle")
    self.Label_activeValue = TFDirector:getChildByPath(Panel_active, "Label_activeValue")
    self.Label_activeTitle:setTextById(270510)

    self.Label_theam_title = TFDirector:getChildByPath(Panel_info, "Label_theam_title")
    self.Label_train_name = TFDirector:getChildByPath(Panel_info, "Label_train_name")
    self.Label_train_content = TFDirector:getChildByPath(Panel_info, "Label_train_content")
    self.Image_content_bg = TFDirector:getChildByPath(Panel_info, "Image_content_bg")
    self.Panel_rewards = TFDirector:getChildByPath(Panel_info, "Panel_rewards"):hide()
    local scrollView_reward = TFDirector:getChildByPath(Panel_info, "ScrollView_reward")
    self.ListView_reward = UIListView:create(scrollView_reward)
    self.ListView_reward:setItemsMargin(5)

    self.Button_go = TFDirector:getChildByPath(Panel_info, "Button_go")
    self.Image_times_bg = TFDirector:getChildByPath(Panel_info, "Image_times_bg")
    self.Label_supls_time = TFDirector:getChildByPath(Panel_info, "Label_supls_time")
    self.Button_task = TFDirector:getChildByPath(Panel_info, "Button_task"):hide()
    self.Image_task_red = TFDirector:getChildByPath(self.Button_task, "Image_task_red")

    self.Image_hero = TFDirector:getChildByPath(ui, "Image_hero")
    self:initTaskActive()
    if LeagueDataMgr:getTrainMatrixThemeId() then
        self.initSuccess = true
        self:initThemeList()
        self:updateUI()
    else
        self:timeOut(function()
            LeagueDataMgr:reqTrainMatrixInfo()
        end,0.2)
    end
end

function LeagueTrainingView:initTaskActive()
    local size = self.Image_active_progress:Size()
    for i = #self.avtiveData_, 1, -1 do
        local stageInfo = self.avtiveData_[i]
        local percent = stageInfo.stage / self.maxStage_
        local Panel_activeItem = self.Panel_activeItem:clone()
        local item = {}
        item.root = Panel_activeItem
        item.Panel_geted = TFDirector:getChildByPath(item.root, "Panel_geted")
        item.Panel_notGet = TFDirector:getChildByPath(item.root, "Panel_notGet")
        item.Panel_canGet = TFDirector:getChildByPath(item.root, "Panel_canGet")
        item.Button_geted = TFDirector:getChildByPath(item.root, "Button_geted")
        item.Button_canGet = TFDirector:getChildByPath(item.root, "Button_canGet")
        local spine_receive = TFDirector:getChildByPath(item.root, "Spine_receive")
        spine_receive:playByIndex(0,-1,-1,1)
        item.Button_notGet = TFDirector:getChildByPath(item.root, "Button_notGet")
        item.Label_getValue = TFDirector:getChildByPath(item.root, "Label_getValue")
        item.Label_getValue:setText(stageInfo.stage)
        self.activeItem_[i] = item
        Panel_activeItem:Pos((size.width - 5) * percent, -6):AddTo(self.Image_active_progress,15)
    end
end

function LeagueTrainingView:initThemeList()
    self.ListView_theme:removeAllItems()
    self.themeList = LeagueDataMgr:getTrainMatrixThemeList()
    local curthemeid = LeagueDataMgr:getTrainMatrixThemeId()
    local idx = 1
    for i, v in ipairs(self.themeList) do
        if v.id == curthemeid then
            idx = i
            break
        end
    end
    self.curSelThemeIdx = idx
    for i, v in ipairs(self.themeList) do
        local item = self.Panel_themeItem:clone()
        self:updateThemeItem(item, i)
        if i == self.curSelThemeIdx then
            self.selectItem = item
            self.selectItem:setContentSize(CCSizeMake(350, 170))
        end
        self.ListView_theme:pushBackCustomItem(item)
    end
end

function LeagueTrainingView:updateUI()
    local matrixInfo = LeagueDataMgr:getTrainMatrixInfo()
    local themeCfg = LeagueDataMgr:getTrainMatrixThemeCfg(matrixInfo.theme)
    if not themeCfg then
        return
    end

    self:updatePanelInfo()
    self:updateActiveInfo()
    self:updateRedPoint()
end

function LeagueTrainingView:updateThemeItem(item,idx)
    local Image_bg = TFDirector:getChildByPath(item,"Image_bg")
    local Label_theme = TFDirector:getChildByPath(item,"Label_theme")
    local Panel_clip_hero = TFDirector:getChildByPath(item,"Panel_clip_hero")
    local Image_hero_icon = TFDirector:getChildByPath(item,"Image_hero_icon")
    local Image_lock = TFDirector:getChildByPath(item,"Image_lock")
    local Panel_clip_hero = TFDirector:getChildByPath(item,"Panel_clip_hero")
    local curthemeid = LeagueDataMgr:getTrainMatrixThemeId()
    local cfg = self.themeList[idx]
    Label_theme:setTextById(cfg.trainingtitle)
    Image_hero_icon:setTexture(cfg.subject)
    Image_bg:setGrayEnabled(true)
    Image_hero_icon:setGrayEnabled(true)
    Panel_clip_hero:setContentSize(CCSizeMake(216, 91))
    Panel_clip_hero:setPosition(ccp(200, -62))
    Label_theme:setPosition(ccp(33, 43))
    Image_bg:setScale(1.0)
    if cfg.id == curthemeid then
        Image_bg:setGrayEnabled(false)
        Image_hero_icon:setGrayEnabled(false)
        if self.curSelThemeIdx == idx then
            Panel_clip_hero:setContentSize(CCSizeMake(216, 104))
            Panel_clip_hero:setPosition(ccp(228, -71))
            Label_theme:setPosition(ccp(50, 52))
            Image_bg:setScale(0.8)
            Image_bg:setTexture("ui/league/texun/029.png")
        else
            Image_bg:setTexture("ui/league/texun/019.png")
        end
    elseif self.curSelThemeIdx == idx then
        Panel_clip_hero:setContentSize(CCSizeMake(216, 96))
        Panel_clip_hero:setPosition(ccp(200, -66))
        Label_theme:setPosition(ccp(36, 45))
        Image_bg:setTexture("ui/league/texun/031.png")
        Image_lock:setTexture("ui/league/texun/030.png")
        Image_lock:setScaleX(1.02)
        Image_lock:setScaleY(0.94)
    else
        Image_bg:setTexture("ui/league/texun/019.png")
        Image_lock:setTexture("ui/league/texun/018.png")
        Image_lock:setScaleX(1)
        Image_lock:setScaleY(1)
    end
    Image_lock:setVisible(cfg.id ~= curthemeid)

    Image_bg:setTouchEnabled(true)
    Image_bg:onClick(function()
        if self.curSelThemeIdx == idx then
            return
        end
        local lastIdx = self.curSelThemeIdx
        self.curSelThemeIdx = idx
        if self.selectItem then
            self.selectItem:setContentSize(CCSizeMake(350, 124))
            self:updateThemeItem(self.selectItem, lastIdx)
        end
        item:setContentSize(CCSizeMake(350, 170))
        self:updateThemeItem(item, self.curSelThemeIdx)
        self.selectItem = item
        self:updatePanelInfo()
        self.ListView_theme:doLayout()
    end)
end

function LeagueTrainingView:updatePanelInfo()
    local themeCfg = self.themeList[self.curSelThemeIdx]
    if themeCfg then
        Utils:createHeroModel(themeCfg.hero, self.Image_hero, 0.5, themeCfg.heromodel,true)
        self.Label_theam_title:setTextById(themeCfg.trainingtitle)
        self.Label_train_name:setTextById(themeCfg.trainingtitle1)
        self.Label_train_content:setTextById(themeCfg.trainingdes1)

        local rewards = themeCfg.cleareditem
        local newcount = #rewards
        local oldcount = #self.ListView_reward:getItems()
        if newcount >= oldcount then
            local addcount = newcount - oldcount
            for i = 1, addcount do
                local itemPrefab = PrefabDataMgr:getPrefab("Panel_goodsItem")
                local item = itemPrefab:clone()
                item:setScale(0.7)
                self.ListView_reward:pushBackCustomItem(item)
            end
        else
            local removecount = oldcount - newcount
            for i = 1, removecount do
                self.ListView_reward:removeLastItem()
            end
        end
        for i, v in ipairs(rewards) do
            local item = self.ListView_reward:getItem(i)
            PrefabDataMgr:setInfo(item, v[1])
        end

        local trainMatrixInfo = LeagueDataMgr:getTrainMatrixInfo()
        local bCanFight = tobool(trainMatrixInfo and trainMatrixInfo.theme == themeCfg.id and trainMatrixInfo.remainTimes > 0)
        self.Button_go:setTouchEnabled(bCanFight)
        self.Button_go:setGrayEnabled(not bCanFight)
        self.Image_times_bg:setVisible(LeagueDataMgr:getTrainMatrixThemeId() == themeCfg.id)

        if trainMatrixInfo.theme == themeCfg.id then
            local lefttime = trainMatrixInfo.revertRemain
            local day, hour, min, sec = Utils:getFuzzyDHMS(lefttime, false)
            if day > 0 then
                self.Label_revertTime:setTextById(270500, day, hour)
            elseif hour > 0 then
                self.Label_revertTime:setTextById(270501, hour, min)
            elseif min > 0 then
                self.Label_revertTime:setTextById(270502, min)
            elseif sec > 0 then
                self.Label_revertTime:setTextById(270502, 1)
            end
            self.Label_supls_time:setTextById(270509, trainMatrixInfo.remainTimes)
        else
            self.Label_revertTime:setTextById(270511)
        end
        
        

    else
        self.Button_go:setTouchEnabled(false)
        self.Button_go:setGrayEnabled(true)
    end
end

function LeagueTrainingView:updateActiveInfo()
    local matrixInfo = LeagueDataMgr:getTrainMatrixInfo()
    local receiveIndex = clone(matrixInfo.selfTrainPrizeIndex)
    local myActiveScore = GoodsDataMgr:getItemCount(EC_SItemType.TRAINING_MATRIX_SCORE)
    self.Label_activeValue:setText(tostring(myActiveScore))
    local percent = me.clampf(myActiveScore / self.maxStage_, 0, 1)
    self.LoadingBar_activeProgress:setPercent(percent * 100)
    for i, v in ipairs(self.activeItem_) do
        local stageInfo = self.avtiveData_[i]
        local idx = table.indexOf(receiveIndex, i - 1)
        v.Panel_geted:setVisible(idx ~= -1)
        v.Panel_canGet:setVisible(myActiveScore >= stageInfo.stage and idx == -1)
        v.Panel_notGet:setVisible(myActiveScore < stageInfo.stage)
    end
end

function LeagueTrainingView:showActivePreview(index)
    local stageInfo = self.avtiveData_[index]
    local item = self.activeItem_[index].root
    local wp = item:getParent():convertToWorldSpace(item:Pos())
    self.Image_preview = Utils:previewReward(self.Image_preview, stageInfo.reward)
end

function LeagueTrainingView:onSelfActiveRewardUpdateEvent(data)
    if data.rewards then
        Utils:showReward(data.rewards)
    end
    self:updateActiveInfo()
end

function LeagueTrainingView:updateRedPoint()
    local redPoint = LeagueDataMgr:checkTrainStageRedPoint()
    self.Image_box:setVisible(not redPoint)
    self.Image_stage_red:setVisible(redPoint)
    self.Spine_stage:setVisible(redPoint)

    redPoint = LeagueDataMgr:checkTrainTaskRedPoint()
    self.Image_task_red:setVisible(redPoint)
end

function LeagueTrainingView:onShow()
    self.super.onShow(self)
    self:updateRedPoint()
end

function LeagueTrainingView:startBattle()
    local battleController = require("lua.logic.battle.BattleController")
    local matrixInfo = LeagueDataMgr:getTrainMatrixInfo()
    local themeCfg = LeagueDataMgr:getTrainMatrixThemeCfg(matrixInfo.theme)
    if not themeCfg then
        return
    end
    local formationData = FubenDataMgr:getInitFormation(themeCfg.monster)
    HeroDataMgr:changeDataByFuben(themeCfg.monster, formationData)
    local heros = {}
    for i, v in ipairs(formationData) do
        table.insert(heros, {v.type, v.id})
    end
    battleController.requestFightStart(themeCfg.monster, 0, 0, heros, 0)
end

function LeagueTrainingView:onTrainMatrixInfoChange()
    if self.initSuccess then
        self:updateUI()
    else
        self.initSuccess = true
        self:initThemeList()
        self:updateUI()
    end
end

function LeagueTrainingView:registerEvents()
    EventMgr:addEventListener(self, EV_UNION_TRAINMATRIX_REVERT, handler(self.onTrainMatrixInfoChange, self))
    EventMgr:addEventListener(self, EV_UNION_TRAIN_INFO_UPDATE, handler(self.onTrainMatrixInfoChange, self))
    EventMgr:addEventListener(self, EV_UNION_GET_TRAIN_SELF_ACTIVE_REWARD, handler(self.onSelfActiveRewardUpdateEvent, self))
    EventMgr:addEventListener(self, EV_FUBEN_UPDATE_LIMITHERO, handler(self.startBattle, self))

    self.Image_content_bg:setTouchEnabled(true)
    self.Image_content_bg:onClick(function(sender)
        local themeCfg = self.themeList[self.curSelThemeIdx]
        Utils:openView("league.LeagueTrainingBriefView", themeCfg.id)
    end)

    self.Button_task:onClick(function()
        Utils:openView("league.LeagueTrainingTaskView", true)
    end)

    self.Button_stage:onClick(function()
        Utils:openView("league.LeagueTrainingStageView")
    end)

    self.Button_go:onClick(function()
        local matrixInfo = LeagueDataMgr:getTrainMatrixInfo()
        local themeCfg = LeagueDataMgr:getTrainMatrixThemeCfg(matrixInfo.theme)
        local levelFormation = FubenDataMgr:getLevelFormation(themeCfg.monster)
        if levelFormation then
            self:startBattle()
        else
            FubenDataMgr:send_DUNGEON_LIMIT_HERO_DUNGEON(themeCfg.monster)
            self:addLockLayer()
            self:timeOut(function()
                self:removeLockLayer()
            end,5)
        end
    end)

    for i, v in ipairs(self.activeItem_) do
        v.Button_geted:onClick(function()
            self:showActivePreview(i)
        end)
        v.Button_canGet:onClick(function()
            local stageInfo = self.avtiveData_[i]
            LeagueDataMgr:ReqUnionTrainSelfActivePrize(i - 1)
        end)
        v.Button_notGet:onClick(function()
            self:showActivePreview(i)
        end)
    end
end

return LeagueTrainingView