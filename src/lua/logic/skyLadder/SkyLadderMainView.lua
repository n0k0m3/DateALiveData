local SkyLadderMainView = class("SkyLadderMainView", BaseLayer)

function SkyLadderMainView:ctor()
    self.super.ctor(self)
    self:initData()
    self:init("lua.uiconfig.skyladder.skyladderMainView")
end

function SkyLadderMainView:initData()

    SkyLadderDataMgr:Send_GetRankListData()

    self.rankIconRes = {
        "ui/activity/assist/038.png",
        "ui/activity/assist/039.png",
        "ui/activity/assist/040.png",
    }

    self.otherDelta = Utils:getKVP(61006, "otherAward")
end

function SkyLadderMainView:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui

    self.Panel_root = TFDirector:getChildByPath(self.ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab")

    --button
    local Image_botton = TFDirector:getChildByPath(self.Panel_root, "Image_botton")
    self.Button_award = TFDirector:getChildByPath(Image_botton, "Button_award")
    local awardBtnLabel = TFDirector:getChildByPath(self.Button_award, "Label_btn")
    awardBtnLabel:setTextById(3202055)
    self.Button_vscard = TFDirector:getChildByPath(Image_botton, "Button_vscard")
    self.Button_task = TFDirector:getChildByPath(Image_botton, "Button_task")
    local taskBtnLabel = TFDirector:getChildByPath(self.Button_task, "Label_btn")
    taskBtnLabel:setTextById(3202060)
    self.Image_tips = TFDirector:getChildByPath(self.Button_task, "Image_tips")
    self.Button_store = TFDirector:getChildByPath(Image_botton, "Button_store")
    self.Button_stage = TFDirector:getChildByPath(Image_botton, "Button_stage")
    local stageBtnLabel = TFDirector:getChildByPath(self.Button_stage, "Label_btn")
    stageBtnLabel:setTextById(3202056)

    self.Button_enter = TFDirector:getChildByPath(Image_botton, "Button_enter")
    self.Label_closeTime = TFDirector:getChildByPath(Image_botton, "Label_closeTime")
    self.Label_EndTimeTip = TFDirector:getChildByPath(Image_botton, "Label_EndTimeTip")

    self.Image_top = TFDirector:getChildByPath(self.Panel_root, "Image_top")
    self.Image_medal = TFDirector:getChildByPath(self.Image_top, "Image_medal")
    self.Label_ladderStage = TFDirector:getChildByPath(self.Image_top, "Label_ladderStage")
    self.Label_ladder_score_max = TFDirector:getChildByPath(self.Image_top, "Label_ladder_score_max")
    self.Image_max = TFDirector:getChildByPath(self.Image_top, "Image_max")
    self.Label_ladder_score_min = TFDirector:getChildByPath(self.Image_top, "Label_ladder_score_min")
    self.Label_blood_num = TFDirector:getChildByPath(self.Image_top, "Label_blood_num")
    local Label_blood_tip = TFDirector:getChildByPath(self.Image_top, "Label_blood_tip")
    Label_blood_tip:setTextById(3202057)

    self.Image_icon_3 = TFDirector:getChildByPath(self.Panel_root, "Image_icon_3")
    self.image_name3 = TFDirector:getChildByPath(self.Image_icon_3, "Label_name")
    self.image_name3:setTextById(3202058)

    self.Image_icon_4 = TFDirector:getChildByPath(self.Panel_root, "Image_icon_4")
    self.image_name4 = TFDirector:getChildByPath(self.Image_icon_4, "Label_name")
    self.image_name4:setTextById(3202059)

    self.Image_normal_icon = TFDirector:getChildByPath(self.Panel_root, "Image_normal_icon")
    self.Label_zone_name = TFDirector:getChildByPath(self.Image_normal_icon, "Label_zone_name")
    self.Label_time_title = TFDirector:getChildByPath(self.Image_normal_icon, "Label_time_title")
    self.Label_raiders =  TFDirector:getChildByPath(self.Image_normal_icon, "Label_raiders")

    self.Label_updatetip = TFDirector:getChildByPath(self.Panel_root, "Label_updatetip")
    self.Panel_myRank = TFDirector:getChildByPath(self.Panel_root, "Panel_myRankItem")

    local ScrollView_rank =  TFDirector:getChildByPath(self.Panel_root, "ScrollView_rank")
    self.ListView_rank = UIListView:create(ScrollView_rank)

    self.Panel_rankItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_rankItem")

    self:initUILogic()

    self:timeOut(function()
        SkyLadderDataMgr:Send_GetLastCircleData()
    end,0.1)
end


function SkyLadderMainView:initUILogic()

    self:checkDirtyHero()
    self:updateBaseInfo()
    self:updateRankInfo()
end

function SkyLadderMainView:onShow()
    self.super.onShow(self)
    self:onTaskUpdateEvent()

end

----检测当前英雄是否装备了其他英雄的锁定装备
function SkyLadderMainView:checkDirtyHero()

    local skyLadderHero = SkyLadderDataMgr:getSkyLadderHeroInfo()
    local dirtyHero = {}
    local roleCnt = HeroDataMgr:getShowCount()
    for i=1,roleCnt do
        local heroid = HeroDataMgr:getSelectedHeroId(i)
        local isHave = HeroDataMgr:getIsHave(heroid)
        if isHave then

            ---检查是否存在装备
            local heroInfo = clone(skyLadderHero[heroid])
            if heroInfo.equipments then
                for k2,v2 in pairs(heroInfo.equipments) do
                    local equipId = v2.equip.id
                    local singleItem = GoodsDataMgr:getSingleItem(equipId)
                    if not singleItem then
                        local index = table.indexOf(dirtyHero, heroid)
                        if index == -1 then
                            table.insert(dirtyHero,heroid)
                        end
                    end
                end
            end

            ---检查是否存在新装备
            if heroInfo.euqipFetterInfo then
                for k2,v2 in pairs(heroInfo.euqipFetterInfo) do
                    local newEquipId = v2.newEquipmentInfo.id
                    local singleItem = GoodsDataMgr:getSingleItem(newEquipId)
                    if not singleItem then
                        local index = table.indexOf(dirtyHero, heroid)
                        if index == -1 then
                            table.insert(dirtyHero,heroid)
                        end
                    end
                end
            end

            for equipPos = 1,3 do
                local equipId = HeroDataMgr:getEquipIdByPos(heroid,equipPos)
                if equipId ~= "none" then
                    local bindHero = SkyLadderDataMgr:getSkyHeroEquipBind(equipId)
                    if bindHero and bindHero ~= heroid then
                        local index = table.indexOf(dirtyHero, heroid)
                        if index == -1 then
                            table.insert(dirtyHero,heroid)
                        end
                    end
                end
            end

            for pos = 1,6 do
                local euipMent = HeroDataMgr:getNewEquipInfoByPos(heroid, pos)
                if euipMent then
                    local bindHero = SkyLadderDataMgr:getSkyHeroNewEquipBind()
                    if bindHero and bindHero ~= heroid then
                        local index = table.indexOf(dirtyHero, heroid)
                        if index == -1 then
                            table.insert(dirtyHero,heroid)
                        end
                    end
                end
            end
        end
    end

    if #dirtyHero == 0 then
        return
    end

    SkyLadderDataMgr:Send_GetHeroNewData(dirtyHero)

end


---段位血量
function SkyLadderMainView:updateBaseInfo()

    self.curSubRankId = SkyLadderDataMgr:getCurSubRankId()
    local rankMatchCfg = SkyLadderDataMgr:getRankMatchCfg(self.curSubRankId)
    if not rankMatchCfg then
        return
    end

    local rankId = rankMatchCfg.rankID
    local nextId = rankMatchCfg.nextID

    self.Image_top:setTexture(EC_SkyLadderBorard[rankId])
    self.Image_medal:setTexture(EC_SkyLadderMedal[rankId])
    self.Image_medal:setScale(0.5)
    local rankName = SkyLadderDataMgr:getRankName(rankId)
    self.Label_ladderStage:setTextById(rankMatchCfg.rankName)
    self.Label_ladderStage:setColor(EC_SkyLadderColor[rankId])
    self.Label_blood_num:setText(rankMatchCfg.bleedLevel)

    self.Label_ladder_score_min:setText(rankMatchCfg.subRankPoint.."-")
    self.Label_ladder_score_min:setColor(EC_SkyLadderColor[rankId])

    local posX = self.Label_ladder_score_min:getPositionX()
    local width = self.Label_ladder_score_min:getContentSize().width
    self.Image_max:setPositionX(posX+width)
    self.Label_ladder_score_max:setText(rankMatchCfg.subRankMaxPoint)
    self.Label_ladder_score_max:setColor(EC_SkyLadderColor[rankId])
    self.Label_ladder_score_max:setPositionX(posX + width + 25)

    self.Image_normal_icon:setTexture(rankMatchCfg.bgPicture)
    self.Label_zone_name:setTextById(rankMatchCfg.regionName)

    local proceedTime = SkyLadderDataMgr:getProceedTime()
    local day, hour, min = Utils:getFuzzyDHMS(proceedTime, true)
    if day == "00" then
        self.Label_raiders:setTextById(800027, hour, min)
    else
        self.Label_raiders:setTextById(800069, day, hour)
    end

    local curSeasonNum = SkyLadderDataMgr:getCurSeasonNum()
    self.Label_EndTimeTip:setTextById(111000120, curSeasonNum)

    local raceEndTime = SkyLadderDataMgr:getRaceEndTime()
    local endTime = Utils:getTimeData(raceEndTime)
    self.Label_closeTime:setTextById(111000121, endTime.Month, endTime.Day, endTime.Hour)

    local textId = 3202063
    local step = SkyLadderDataMgr:getStep()
    if step == EC_SKYLADDER_STEP.PREPARE then
        textId = 3202065
    elseif step == EC_SKYLADDER_STEP.PROCCED then
        textId = 3202063
    elseif step == EC_SKYLADDER_STEP.BALANCE then
        textId = 3202064
    end
    self.Label_time_title:setTextById(textId)

    self.Button_enter:setGrayEnabled(step ~= EC_SKYLADDER_STEP.PROCCED)
    self.Button_enter:setTouchEnabled(step == EC_SKYLADDER_STEP.PROCCED)

end

function SkyLadderMainView:updateRankInfo()

    self.ListView_rank:removeAllItems()
    self.itemIndex = 0
    local rankList = SkyLadderDataMgr:getSkyLadderRankList()
    self.Panel_root:stopAllActions()
    local seqact = Sequence:create({
        DelayTime:create(0.01),
        CallFunc:create(function()
            self.itemIndex = self.itemIndex + 1
            local info = rankList[self.itemIndex]
            if info then
                local rankItem = self.Panel_rankItem:clone()
                rankItem:setOpacity(0)
                self:updateRankItem(rankItem,info)
                self.ListView_rank:pushBackCustomItem(rankItem)
            else
                self.itemIndex = 0
                self.Panel_root:stopAllActions()
            end
        end)
    })
    self.Panel_root:runAction(CCRepeatForever:create(seqact))


    local myRankInfo = SkyLadderDataMgr:getMyRankInfo()
    if myRankInfo then
        self:updateRankItem(self.Panel_myRank,myRankInfo)
    end

    local refreshTime = SkyLadderDataMgr:getRefreshTime()
    self.Label_updatetip:setTextById("r83002", refreshTime)

end

function SkyLadderMainView:updateRankItem(rankItem,rankData)

    rankItem:runAction(CCFadeIn:create(0.3))
    local rankIcon = TFDirector:getChildByPath(rankItem, "Image_rank_icon")
    local rankNum = TFDirector:getChildByPath(rankItem, "Label_rank_num")
    local rankName = TFDirector:getChildByPath(rankItem, "Label_name")
    local rankLv = TFDirector:getChildByPath(rankItem, "Label_level")
    local laderScore = TFDirector:getChildByPath(rankItem, "Label_ladder_score")
    local Image_total_icon = TFDirector:getChildByPath(rankItem, "Image_total_icon")
    local battleScore = TFDirector:getChildByPath(rankItem, "Label_fight_socre")
    local Image_icon = TFDirector:getChildByPath(rankItem, "Image_icon")
    local Image_score_icon = TFDirector:getChildByPath(rankItem, "Image_score_icon")
    local Label_ladder_delta = TFDirector:getChildByPath(rankItem, "Label_ladder_delta")

    if rankData.rank >= 1 and rankData.rank <= 3 then
        rankIcon:setVisible(true)
        rankIcon:setTexture(self.rankIconRes[rankData.rank])
        rankNum:setText("")
    else
        rankIcon:setVisible(false)
        if rankData.rank == 0 then
            rankNum:setTextById(263009)
        else
            rankNum:setText(rankData.rank)
        end
    end

    rankName:setText(rankData.pName)
    rankLv:setText("Lv."..rankData.level)
    laderScore:setText(rankData.laderScore)
    battleScore:setText(rankData.battleScore)

    local width = laderScore:getContentSize().width
    Image_total_icon:setPositionX(-width)

    local headIcon = rankData.headId
    if headIcon == 0 then
        headIcon = 101
    end
    local icon = AvatarDataMgr:getAvatarIconPath(headIcon)
    Image_icon:setTexture(icon)

    if rankData.pid ~= MainPlayer:getPlayerId() then
        Image_icon:onClick(function()
            MainPlayer:sendPlayerId(rankData.pid)
        end)
    end

    local deltaScore = rankData.ladderAddtion
    if deltaScore then
        if deltaScore > 0  then
            Label_ladder_delta:setText("+"..deltaScore)
        else
            Label_ladder_delta:setText(deltaScore)
        end
        Image_score_icon:setVisible(true)
    else
        Label_ladder_delta:setText("")
        Image_score_icon:setVisible(false)
    end

    local width = Label_ladder_delta:getContentSize().width
    Image_score_icon:setPositionX(-width)
end

function SkyLadderMainView:onRecvLastCircleData()

    ---赛季结算弹出
    local lastSeasonData = SkyLadderDataMgr:getLastSeasonData()
    if lastSeasonData then
        Utils:openView("skyLadder.SkyLadderEndSeasonView")
        return
    end

    ---周期结算弹出
    local lastRankList = SkyLadderDataMgr:getLastCircleRankList()
    if lastRankList then
        Utils:openView("skyLadder.SkyLadderEndRankView")
    end
end

function SkyLadderMainView:onQueryInfoEvent(playerInfo)
    Utils:openView("chat.PlayerInfoView", playerInfo)
end

function SkyLadderMainView:onTaskUpdateEvent()
    local isCanReceive = TaskDataMgr:isCanReceiveTask(EC_TaskType.SKYLADDER)
    self.Image_tips:setVisible(isCanReceive)
end

function SkyLadderMainView:registerEvents()

    EventMgr:addEventListener(self, EV_RECV_PLAYERINFO, handler(self.onQueryInfoEvent, self))
    EventMgr:addEventListener(self, EV_SKYLADDER_CURCIRCLE, handler(self.updateBaseInfo, self))
    EventMgr:addEventListener(self, EV_SKYLADDER_RANK, handler(self.updateRankInfo, self))
    EventMgr:addEventListener(self, EV_SKYLADDER_LASTCIRCLE, handler(self.onRecvLastCircleData, self))
    EventMgr:addEventListener(self, EV_TASK_UPDATE, handler(self.onTaskUpdateEvent, self))

    self.Button_award:onClick(function()
        Utils:openView("skyLadder.SkyLadderRewardView")
    end)

    self.Button_vscard:onClick(function()
        Utils:openView("skyLadder.SkyLadderCardView")
    end)

    self.Button_task:onClick(function()
        local step = SkyLadderDataMgr:getStep()
        if step ~= EC_SKYLADDER_STEP.PROCCED then
            Utils:showTips(3203007)
            return
        end
        Utils:openView("skyLadder.SkyLadderTaskView")
    end)

    self.Button_store:onClick(function()
        FunctionDataMgr:jStore(401000)
    end)

    self.Button_stage:onClick(function()
        Utils:openView("skyLadder.SkyLadderStageView")
        --Utils:openView("skyLadder.SkyLadderCardPackageView")

    end)

    self.Button_enter:onClick(function()
        local isNewTurn = SkyLadderDataMgr:isNewTurn()
        if not isNewTurn then
            Utils:openView("skyLadder.SkyLadderZonesView")
        else
            Utils:openView("skyLadder.SkyLadderTipView")
        end
    end)

end

return SkyLadderMainView