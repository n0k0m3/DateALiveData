
local AgoraLevelView = class("AgoraLevelView", BaseLayer)
local LevelModeType = {
    LevelModeType_Story = 1,
    LevelModeType_Challenge = 2
}

function AgoraLevelView:ctor(chapterId)
    self.super.ctor(self)
    self:initData(chapterId)
    self:init("lua.uiconfig.agora.agoraLevelView")
end

function AgoraLevelView:initData(chapterId)
    self.chapterId = chapterId
    AgoraDataMgr:setCurChapterId(chapterId)
    self.chapterInfo = AgoraDataMgr:getChapterCfgInfo(self.chapterId)
    self.challengeCount_ = 0
end

function AgoraLevelView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.tab = {}
    for i=1,2 do
        local tabBtn = TFDirector:getChildByPath(self.Panel_root, "Panel_tab_"..i)
        local selectImg = TFDirector:getChildByPath(tabBtn, "Image_select")
        local btnName = TFDirector:getChildByPath(tabBtn, "Label_name")
        local btnNameStr = i==1 and 303014 or 303015
        btnName:setTextById(btnNameStr)
        table.insert(self.tab,{btn = tabBtn,selectImg = selectImg,btnName = btnName})
    end

    --剧情模式
    self.levelItemPos = {ccp(-154,115),ccp(0,24),ccp(147,83),ccp(-63,-146),ccp(152,-69)}
    self.Panel_story_mode = TFDirector:getChildByPath(self.Panel_root, "Panel_story_mode")
    self.Panel_level = TFDirector:getChildByPath(self.Panel_root, "Panel_level")
    self.Story_Image = TFDirector:getChildByPath(self.Panel_story_mode, "Image_bg")
    self.Story_levelName = TFDirector:getChildByPath(self.Panel_story_mode, "Label_levelName")
    self.Button_ready = TFDirector:getChildByPath(self.Panel_story_mode, "Button_ready")
    self.Label_BtnName = TFDirector:getChildByPath(self.Button_ready, "Label_name")

    --挑战模式
    self.Panel_challenge_mode = TFDirector:getChildByPath(self.Panel_root, "Panel_challenge_mode")
    self.Challenge_Image = TFDirector:getChildByPath(self.Panel_challenge_mode, "Image_bg")
    self.Challenge_levelName = TFDirector:getChildByPath(self.Panel_challenge_mode, "Label_levelName")
    self.Label_describe = TFDirector:getChildByPath(self.Panel_challenge_mode, "Label_describe")
    self.ChallengeReadyBtn = TFDirector:getChildByPath(self.Panel_challenge_mode, "Button_ready")
    self.Label_ChallengeBtnName = TFDirector:getChildByPath(self.ChallengeReadyBtn, "Label_name")
    self.Button_next = TFDirector:getChildByPath(self.Panel_challenge_mode, "Button_next")
    self.Button_before = TFDirector:getChildByPath(self.Panel_challenge_mode, "Button_before")
    self.challengeLevelIcon = TFDirector:getChildByPath(self.Panel_challenge_mode, "Image_icon")
    self.Image_recommend = TFDirector:getChildByPath(self.Panel_challenge_mode, "Image_recommend"):hide()
    self.Label_recommend = TFDirector:getChildByPath(self.Image_recommend, "Label_recommend")

    self.Panel_describe = TFDirector:getChildByPath(self.Panel_root, "Panel_describe")
    self.Label_title = TFDirector:getChildByPath(self.Panel_describe, "Label_title")
    self.Label_title:setTextById(2100045)
    self.Label_describe = TFDirector:getChildByPath(self.Panel_describe, "Label_describe")

    self.Panel_reward = TFDirector:getChildByPath(self.Panel_root, "Panel_reward")
    self.Image_descbg = TFDirector:getChildByPath(self.Panel_reward, "Image_descbg")
    self.Label_title = TFDirector:getChildByPath(self.Image_descbg, "Label_title")
    self.Label_title:setTextById(303016)

    self.Label_Awardtitle = TFDirector:getChildByPath(self.Panel_reward, "Label_title")
    local ScrollView_awardList = TFDirector:getChildByPath(self.Panel_reward, "ScrollView_item")
    self.ListView_awardList = UIListView:create(ScrollView_awardList)

    self.Button_enter = TFDirector:getChildByPath(self.Panel_root, "Button_enter")
    self.Label_desc = TFDirector:getChildByPath(self.Button_enter, "Label_desc")
    self.Label_desc:setTextById(303040)
    self.Label_total = TFDirector:getChildByPath(self.Button_enter, "Label_total")

    self.Button_cost = TFDirector:getChildByPath(self.Panel_root, "Button_cost")
    self.Label_costdesc = TFDirector:getChildByPath(self.Button_cost, "Label_desc")
    self.Label_costdesc:setTextById(491005)
    self.Label_totalcost = TFDirector:getChildByPath(self.Button_cost, "Label_total")
    self.Label_own = TFDirector:getChildByPath(self.Button_cost, "Label_own")
    self.Image_cost = TFDirector:getChildByPath(self.Button_cost, "Image_cost")

    --预制
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
    self.Panel_levelItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_levelItem")
    self.Panel_rewardItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_rewardItem")

    local chooseMode = LevelModeType.LevelModeType_Story
    local isAfter = AgoraDataMgr:isAfterFight()
    if isAfter then
        chooseMode = AgoraDataMgr:getChooseMode()
        if chooseMode == LevelModeType.LevelModeType_Challenge then
            local passAll = AgoraDataMgr:isPassAllStoryLevel(self.chapterId)
            if not passAll then
                chooseMode = LevelModeType.LevelModeType_Story
            end
        end
        AgoraDataMgr:setAfterFightFlag(false)
    end
    chooseMode = chooseMode or LevelModeType.LevelModeType_Story
    self:updatePanel(chooseMode)
end

function AgoraLevelView:onShow()
    self.super.onShow(self)
end

function AgoraLevelView:updatePanel(modeType)

    if modeType == LevelModeType.LevelModeType_Challenge then
        local passAll = AgoraDataMgr:isPassAllStoryLevel(self.chapterId)
        if not passAll then
            Utils:showTips(303021)
            return
        end
    end

    for i=1,2 do
        self.tab[i].selectImg:setVisible(modeType == i)
    end

    self.chooseModeType = modeType

    AgoraDataMgr:setChooseMode(modeType)

    if modeType == LevelModeType.LevelModeType_Story then
        self:updateStoryMode()
    elseif modeType == LevelModeType.LevelModeType_Challenge then
        self:updateChallengeMode()
    end

    self.Panel_story_mode:setVisible(modeType == LevelModeType.LevelModeType_Story)
    self.Panel_challenge_mode:setVisible(modeType == LevelModeType.LevelModeType_Challenge)

    self.Label_Awardtitle:setTextById(303016)
end

--剧情模式
function AgoraLevelView:updateStoryMode()

    if not self.chapterInfo then
        return
    end

    self.Story_Image:setTexture(self.chapterInfo.storydungenPic)
    self.Story_levelName:setTextById(self.chapterInfo.name)

    self:updateLevelList()
end

function AgoraLevelView:updateLevelList()

    self.chooseImg = {}
    self.Panel_level:removeAllChildren()
    if not self.chapterInfo then
        return
    end
    local levels = self.chapterInfo.storydungenID
    local firstLevelId,fistFightLevelId
    for k,levelCid in ipairs(levels) do
        local Panel_levelItem = self.Panel_levelItem:clone()
        local Button_level = Panel_levelItem:getChildByName("Button_level")
        local Label_name = Button_level:getChildByName("Label_name")
        local Image_lock_level = Panel_levelItem:getChildByName("Image_lock_level"):hide()
        local Label_lock_level = Image_lock_level:getChildByName("Label_lock_level")
        local Image_lock_pre = Panel_levelItem:getChildByName("Image_lock_pre"):hide()
        local Image_noCnt = Panel_levelItem:getChildByName("Image_noCnt")
        local Label_noCnt = Image_noCnt:getChildByName("Label_noCnt")
        Label_noCnt:setTextById(303041)
        local Image_invade = Panel_levelItem:getChildByName("Image_invade"):hide()
        local Image_choose = Panel_levelItem:getChildByName("Image_choose"):hide()
        Panel_levelItem:setPosition(self.levelItemPos[k])
        self.Panel_level:addChild(Panel_levelItem)

        self.chooseImg[levelCid] = Image_choose

        local levelCfg = FubenDataMgr:getLevelCfg(levelCid)
        if not levelCfg  then
            Box("wrong levelCid:"..levelCid.." in DungeonLevel")
            return
        end

        if not firstLevelId then
            firstLevelId = levelCid
        end

        local enabled, preIsOpen, levelIsOpen = AgoraDataMgr:checkLevelEnabled(levelCid)
        if enabled then
            fistFightLevelId = levelCid
        else
            if not levelIsOpen then
                Image_lock_level:show()
                Label_lock_level:setTextById(800003, levelCfg.playerLv)
            else
                Image_lock_pre:show()
            end
        end

        local fightCnt = 0
        local levelInfo = AgoraDataMgr:getFightLevelInfoById(levelCid)
        if levelInfo then
            fightCnt = levelInfo.fightCount
        end

        local invadeLevelId =  AgoraDataMgr:isInvadedLevel(levelCid)
        if invadeLevelId then
            local invadeCfg = FubenDataMgr:getLevelCfg(invadeLevelId)
            Button_level:setTextureNormal(invadeCfg.icon)
            Label_name:setTextById(invadeCfg.name)
            Image_invade:setVisible(true)
            local remainCount = AgoraDataMgr:getRemainCount(invadeLevelId)
            Image_noCnt:setVisible(remainCount == 0)
        else
            Label_name:setTextById(levelCfg.name)
            Button_level:setTextureNormal(levelCfg.icon)
            Image_invade:setVisible(false)
            local remainCount = AgoraDataMgr:getRemainCount(levelCid)
            Image_noCnt:setVisible(remainCount == 0)
        end

        Button_level:onClick(function()
            self:chooseStoryLevel(levelCid)
        end)

    end

    if fistFightLevelId then
        firstLevelId = fistFightLevelId
    end
    self:chooseStoryLevel(firstLevelId)
end

function AgoraLevelView:chooseStoryLevel(levelCid)

    for k,v in pairs(self.chooseImg) do
        v:setVisible(levelCid == k)
    end

    local invadeLevelId =  AgoraDataMgr:isInvadedLevel(levelCid)
    if invadeLevelId then
        levelCid = invadeLevelId
        self.Label_BtnName:setTextById(303020)
    else
        self.Label_BtnName:setTextById(303019)
    end

    self.chooseLevelCid = levelCid

    local levelCfg = FubenDataMgr:getLevelCfg(levelCid)
    if not levelCfg then
        Box("levelCid is null")
        return
    end

    local str = TextDataMgr:getText(303017)
    if invadeLevelId then
        str = TextDataMgr:getText(303018)
    end

    local showReward = {}
    local isRandomDrop = AgoraDataMgr:isPassPlotLevel(levelCid)
    if isRandomDrop then
        showReward = levelCfg.dropShow
    else
        if levelCfg.firstDropShow and next(levelCfg.firstDropShow) then
            showReward = levelCfg.firstDropShow
        else
            showReward = levelCfg.dropShow
            isRandomDrop = true
        end
    end

    self.Label_describe:setTextById(levelCfg.victoryTypeDescribeForOpening)
    local desc = FubenDataMgr:getPassCondDesc(levelCid, 1)
    self.Label_describe:setText(desc)
    self:updateAwardList(showReward,not isRandomDrop)

    self.Button_enter:setVisible(true)
    local remainCount = AgoraDataMgr:getRemainCount(levelCid)
    self.Label_total:setText(remainCount .."/"..levelCfg.fightCount)

    local cost = levelCfg.cost[1]
    self:updateLevelCost(cost)
end

--挑战模式
function AgoraLevelView:updateChallengeMode()

    self.challengelevels = self.chapterInfo.challangedungenID
    self.minLevelCnt = 1
    self.maxLevelCnt = #self.challengelevels

    --默认选项
    self.curLevelIndex = 1

    --选择上次选择的
    local levelId = AgoraDataMgr:getLastChooseLevelId(self.chapterId)
    if levelId then
        for k,v in ipairs(self.challengelevels) do
            if v == levelId then
                self.curLevelIndex = k
                break
            end
        end
    end
    self:chooseChallengeLevel(0)
end

--选择挑战关卡
function AgoraLevelView:chooseChallengeLevel(deltaLevelIndex)

    local newLevelIndex = self.curLevelIndex + deltaLevelIndex
    if newLevelIndex > self.maxLevelCnt or newLevelIndex < self.minLevelCnt then
        return
    end

    self.Button_next:setVisible(newLevelIndex < self.maxLevelCnt)
    self.Button_next:setTouchEnabled(newLevelIndex < self.maxLevelCnt)

    self.Button_before:setVisible(newLevelIndex > self.minLevelCnt)
    self.Button_before:setTouchEnabled(newLevelIndex > self.minLevelCnt)

    self.curLevelIndex = newLevelIndex

    local curLevelCid = self.challengelevels[self.curLevelIndex]
    self.chooseLevelCid = curLevelCid

    local levelCfg = FubenDataMgr:getLevelCfg(curLevelCid)
    if not levelCfg then
        Box("curLevelCid is null")
        return
    end

    AgoraDataMgr:saveChallengeChoose(self.chapterId,curLevelCid)
    self.Challenge_levelName:setTextById(levelCfg.name)

    self.Label_describe:setTextById(self.chapterInfo.challengeDescribe)

    self.Label_ChallengeBtnName:setTextById(303019)

    self.challengeLevelIcon:setTexture(levelCfg.icon)

    self.Button_enter:setVisible(false)
    local remainCount = AgoraDataMgr:getRemainCount(curLevelCid)
    self.Label_total:setText(remainCount .."/"..levelCfg.fightCount)

    local cost = levelCfg.cost[1]
    self:updateLevelCost(cost)

    self.Label_recommend:setTextById(303038,"20")

    local showReward = {}
    local isRandomDrop = AgoraDataMgr:isPassPlotLevel(curLevelCid)
    if isRandomDrop then
        showReward = levelCfg.dropShow
    else
        if levelCfg.firstDropShow and next(levelCfg.firstDropShow) then
            showReward = levelCfg.firstDropShow
        else
            showReward = levelCfg.dropShow
            isRandomDrop = true
        end
    end

    self.Label_describe:setTextById(levelCfg.victoryTypeDescribeForOpening)
    local desc = FubenDataMgr:getPassCondDesc(curLevelCid, 1)
    self.Label_describe:setText(desc)
    self:updateAwardList(showReward,not isRandomDrop)
end

--刷新消耗
function AgoraLevelView:updateLevelCost(cost)

    self.Button_cost:setVisible(false)
    if cost then
        local costItemCfg = GoodsDataMgr:getItemCfg(cost[1])
        self.Image_cost:setTexture(costItemCfg.icon)
        local ownNum = GoodsDataMgr:getItemCount(cost[1])
        self.Label_own:setText(ownNum)
        local width = self.Label_own:getContentSize().width
        local posX = self.Label_own:getPositionX()
        self.Label_totalcost:setText("/"..cost[2])
        self.Label_totalcost:setPositionX(posX+width+1)
        local color = cost[2] > ownNum and me.RED or me.WHITE
        self.Label_own:setColor(color)

        self.Button_cost:show()

        self.Button_cost:onClick(function()
            Utils:showInfo(cost[1], nil, true)
        end)
    end
end

--奖励列表
function AgoraLevelView:updateAwardList(awards,isFirstPass)

    self.ListView_awardList:removeAllItems()
    for k,awardId in ipairs(awards) do
        local Panel_rewardItem = self.Panel_rewardItem:clone()
        local Image_itembg = Panel_rewardItem:getChildByName("Image_itembg")

        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        PrefabDataMgr:setInfo(Panel_goodsItem, awardId)
        Panel_goodsItem:Pos(0, 0):AddTo(Image_itembg)

        local Image_first = Panel_rewardItem:getChildByName("Image_first")
        Image_first:setVisible(isFirstPass)

        self.ListView_awardList:pushBackCustomItem(Panel_rewardItem)
    end
end

function AgoraLevelView:fightReady()

    local levelCfg = FubenDataMgr:getLevelCfg(self.chooseLevelCid)
    if not levelCfg then
        return
    end

    local enabled, preIsOpen, levelIsOpen = AgoraDataMgr:checkLevelEnabled(self.chooseLevelCid)
    if not enabled then
        if not preIsOpen then
            Utils:showTips(202001)
            return
        end

        if not levelIsOpen then
            Utils:showTips(800003, levelCfg.playerLv)
            return
        end
    end

    -- 检查消耗
    local isCanFighting = true
    local cost = levelCfg.cost[1]
    if cost then
        local challengeCount = math.max(1, self.challengeCount_)
        isCanFighting = GoodsDataMgr:currencyIsEnough(cost[1], cost[2] * challengeCount)
    end
    if not isCanFighting then
        local goodsCfg = GoodsDataMgr:getItemCfg(cost[1])
        local name = TextDataMgr:getText(goodsCfg.nameTextId)
        Utils:showTips(2100034, name)
        return
    end

    -- 检查剩余次数
    local remainCount = AgoraDataMgr:getRemainCount(self.chooseLevelCid)
    if remainCount < 1 then
        Utils:showTips(202006)
        return
    end

    self.fubenType_ =  FubenDataMgr:getFubenType(self.chooseLevelCid)

    local isDuelMod = false
    if levelCfg.fightingMode == 2 or levelCfg.fightingMode == 3 then
        local view = requireNew("lua.logic.fuben.FubenFlightSquadView"):new(self.chooseLevelCid, isDuelMod, self.challengeCount_)
        AlertManager:addLayer(view)
        AlertManager:show()
    else
        local levelGroupCfg = FubenDataMgr:getLevelGroupCfg(levelCfg.levelGroupId)
        local view = requireNew("lua.logic.fuben.FubenSquadView"):new(self.fubenType_,levelGroupCfg.dungeonChapterId,self.chooseLevelCid, isDuelMod, self.challengeCount_)
        AlertManager:addLayer(view)
        AlertManager:show()
    end

end

function AgoraLevelView:onRecvUpdateLevelInfo(curLevelCid)

    if self.chooseModeType == LevelModeType.LevelModeType_Story then
        self:updateLevelList()
    elseif self.chooseModeType == LevelModeType.LevelModeType_Challenge then

        local curLevelIndex
        for k,v in ipairs(self.challengelevels) do
            if curLevelCid and curLevelCid == v then
                curLevelIndex = k
                break
            end
        end

        if not curLevelIndex then
            return
        end

        local nextLevelCid = self.challengelevels[curLevelIndex+1]
        if nextLevelCid then
            local enabled, preIsOpen, levelIsOpen = AgoraDataMgr:checkLevelEnabled(nextLevelCid)
            if enabled then
                AgoraDataMgr:saveChallengeChoose(self.chapterId,nextLevelCid)
            end
        end
    end

end


function AgoraLevelView:registerEvents()

    EventMgr:addEventListener(self, EV_AGORA.UpdateLevelInfo, handler(self.onRecvUpdateLevelInfo, self))

    for i=1,2 do
        self.tab[i].btn:onClick(function()
            self:updatePanel(i)
        end)
    end

    self.Button_ready:onClick(function()
        self:fightReady()
    end)

    self.ChallengeReadyBtn:onClick(function()
        self:fightReady()
    end)

    self.Button_next:onClick(function()
        self:chooseChallengeLevel(1)
    end)
    self.Button_before:onClick(function()
        self:chooseChallengeLevel(-1)
    end)
end

return AgoraLevelView