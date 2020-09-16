
local CelebrationView = class("CelebrationView", BaseLayer)
--500014
function CelebrationView:initData(activityId)
    self.targetValue = 100
    self.activityId_ = activityId
    self.awardStrId = {63593,63594,63595}
    self.numRes = {}
    for i=0,9 do
        self.numRes[i] = "ui/activity/oneYear/luckyReward1/num/"..i..".png"
    end

end

function CelebrationView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.oneYear.celebrationView1")
end

function CelebrationView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Label_active_value = TFDirector:getChildByPath(self.Panel_root, "Label_active_value")
    self.Label_active_target = TFDirector:getChildByPath(self.Panel_root, "Label_active_target")
    self.Button_rule = TFDirector:getChildByPath(self.Panel_root, "Button_rule")
    self.Button_address = TFDirector:getChildByPath(self.Panel_root, "Button_address")
    self.Button_goto = TFDirector:getChildByPath(self.Panel_root, "Button_goto")
    self.Label_goto = self.Button_goto:getChildByName("Label_goto")
    self.Button_sign = TFDirector:getChildByPath(self.Panel_root, "Button_sign")
    self.Spine_sign_down = TFDirector:getChildByPath(self.Button_sign, "Spine_sign_down")
    self.Spine_sign_up = TFDirector:getChildByPath(self.Button_sign, "Spine_sign_up")
    self.Image_signed_active = TFDirector:getChildByPath(self.Panel_root, "Image_signed_active")
    self.Button_lucky_list = TFDirector:getChildByPath(self.Panel_root, "Button_lucky_list")
    self.Button_award = TFDirector:getChildByPath(self.Panel_root, "Button_award")
    self.Image_award_geted = TFDirector:getChildByPath(self.Panel_root, "Image_award_geted")
    self.Label_award_geted = TFDirector:getChildByPath(self.Image_award_geted, "Label_award_geted")
    self.Image_geted = TFDirector:getChildByPath(self.Panel_root, "Image_geted")
    self.Label_time = TFDirector:getChildByPath(self.Panel_root, "Label_time")
    self.Label_time:setSkewX(15)
    self.Label_end_time = TFDirector:getChildByPath(self.Panel_root, "Label_end_time")
    self.Label_end_time:setSkewX(15)
    self.Label_notsign_tip = TFDirector:getChildByPath(self.Panel_root, "Label_notsign_tip")
    self.Label_notsign_tip:setTextById(63606)
    self.Label_vote_tip = TFDirector:getChildByPath(self.Panel_root, "Label_vote_tip")
    self.Label_vote_time = TFDirector:getChildByPath(self.Panel_root, "Label_vote_time")
    self.Label_draw_tip = TFDirector:getChildByPath(self.Panel_root, "Label_draw_tip")
    self.Label_draw_time = TFDirector:getChildByPath(self.Panel_root, "Label_draw_time")
    self.Label_draw_tip:setSkewX(15)
    self.Label_draw_time:setSkewX(15)
    self.Label_getReward_time = TFDirector:getChildByPath(self.Panel_root, "Label_getReward_time")
    self.Label_vote_tip:setSkewX(15)
    self.Label_vote_time:setSkewX(15)

    --屏蔽按钮英文版
    self.Button_address:hide()
    self.Button_lucky_list:setPositionY(self.Button_lucky_list:getPositionY() - 100)
    self.Button_rule:setPositionY(self.Button_rule:getPositionY() - 100)


    self.Image_signed = TFDirector:getChildByPath(self.Panel_root, "Image_signed")
    self.Image_not_sign = TFDirector:getChildByPath(self.Panel_root, "Image_not_sign")
    self.Panel_active = TFDirector:getChildByPath(self.Panel_root, "Panel_active")
    self.Panel_sign = TFDirector:getChildByPath(self.Panel_root, "Panel_sign")
    self.Label_sign_num = TFDirector:getChildByPath(self.Panel_root, "Label_sign_num")
    self.Image_signNumTab = {}
    for i=1,6 do
        local numTx = TFDirector:getChildByPath(self.Panel_root, "Image_sign_num"..i)
        table.insert(self.Image_signNumTab,numTx)
    end
    self.Label_sign_tip = TFDirector:getChildByPath(self.Panel_sign, "Label_sign_tip")
    self.Label_sign_tip:setSkewX(15)
    self.Label_targetName = TFDirector:getChildByPath(self.Panel_sign, "Label_targetName")
    self.Label_targetName:setTextById(14075)

    self.firstLuckyNum_ = {}
    self.Panel_draw = TFDirector:getChildByPath(self.Panel_root, "Panel_draw")
    self.Panel_draw_first = TFDirector:getChildByPath(self.Panel_root, "Panel_draw_first")
    self.Label_cur_name = TFDirector:getChildByPath(self.Panel_root, "Label_cur_name")
    self.Label_cur_name_temp = TFDirector:getChildByPath(self.Panel_root, "Label_cur_name_temp")
    self.Label_cur_name_temp:setOpacity(0)
    self.Label_cur_name:setSkewX(15)
    self.Label_cur_name_temp:setSkewX(15)

    local Panel_lucky_item1 = TFDirector:getChildByPath(self.Panel_draw, "Panel_lucky_item1")
    self.Spine_first = TFDirector:getChildByPath(self.Panel_draw, "Spine_first")
    for i=1,9 do
        local tab = {}
        local Panel_userid = TFDirector:getChildByPath(Panel_lucky_item1, "Panel_userid_"..i)
        tab.num = TFDirector:getChildByPath(Panel_userid, "Image_userid")
        tab.spine = TFDirector:getChildByPath(Panel_userid, "Spine_userid")
        self.firstLuckyNum_[i] = tab
    end

    self.Panel_draw_scend = TFDirector:getChildByPath(self.Panel_root, "Panel_draw_scend")
    self.scend_prizeItem_ = {}
    for i =1,5 do
        local tab = {}
        local pl = TFDirector:getChildByPath(self.Panel_draw_scend, "Panel_lucky_item"..i)
        tab.Label_name = TFDirector:getChildByPath(pl, "Label_name")
        tab.Label_name:setSkewX(15)
        tab.Label_name_temp = TFDirector:getChildByPath(pl, "Label_name_temp")
        tab.Label_name_temp:setOpacity(0)
        tab.Spine_baoza = TFDirector:getChildByPath(pl, "Spine_baoza")
        tab.num = {}
        for j=1,9 do
            local Panel_user = TFDirector:getChildByPath(pl, "Panel_user_"..j)
            local Spine_user = TFDirector:getChildByPath(Panel_user, "Spine_user")
            local Image_userid = TFDirector:getChildByPath(Panel_user, "Image_userid")
            tab.num[j] = {spine = Spine_user,Image_userid = Image_userid}
        end
        table.insert(self.scend_prizeItem_,tab)
    end

    self.Panel_openaward = TFDirector:getChildByPath(self.Panel_root, "Panel_openaward")
    local ScrollView_award = TFDirector:getChildByPath(self.Panel_root, "ScrollView_award")
    self.ListView_award = UIListView:create(ScrollView_award)
    self.ListView_award:setItemsMargin(3)

    self.Label_award_tip = TFDirector:getChildByPath(self.Panel_openaward, "Label_award_tip")

    self.Image_luckyaward_item = TFDirector:getChildByPath(self.Panel_root, "Image_luckyaward_item")

    self.Panel_finish = TFDirector:getChildByPath(self.Panel_root, "Panel_finish"):hide()
    self.Image_finished = TFDirector:getChildByPath(self.Panel_finish, "Image_finished")
    self.Image_cool_bg = TFDirector:getChildByPath(self.Panel_finish, "Image_cool_bg")

    TFDirector:getChildByPath(self.Panel_finish , "Label_celebrationView_1"):hide()
    
    self.coolTimeText = {}
    for i=1,4 do
        self.coolTimeText[i] = TFDirector:getChildByPath(self.Image_cool_bg, "Image_time_text"..i)
    end

    self.Label_cool_tip = TFDirector:getChildByPath(self.Panel_finish, "Label_cool_tip")
    self.Label_cool_tip:setSkewX(15)


    OneYearDataMgr:Send_GetLuckyList()

    TFDirector:send(c2s.YEAR_LOTTO_REQ_YEAR_LOTTO_INFO, {})

    self:refreshUI()

end

function CelebrationView:checkState()
    self.Panel_root:stopAllActions()
    local act = CCSequence:create({
        CCCallFunc:create(function()
            local isUpdate = OneYearDataMgr:checkUpdateStage()
            if isUpdate then
                self:updateStageInfo()
            end
        end),
        CCDelayTime:create(1)
    })
    self.Panel_root:runAction(CCRepeatForever:create(act))
end

function CelebrationView:refreshUI()

    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    if self.activityInfo_ then
        dump(self.activityInfo_)
        OneYearDataMgr:setStageTimeGroup(self.activityInfo_.extendData.alternately)
        OneYearDataMgr:setCelebrationRewarsInfo(self.activityInfo_.extendData.reward)
        self.joinPrize = self.activityInfo_.extendData.prize
        self.targetValue = self.activityInfo_.extendData.liveness
        self.livenessId = self.activityInfo_.extendData.livenessId
        self.robe = self.activityInfo_.extendData.robe
        self.spreadQq = self.activityInfo_.extendData.spreadQq

        self:checkState()
        self:updateStageInfo()

        local startDate = Utils:getUTCDate(self.activityInfo_.startTime , GV_UTC_TIME_ZONE)
        local startDateStr = startDate:fmt("%m.%d")
        local endDate = Utils:getUTCDate(self.activityInfo_.endTime , GV_UTC_TIME_ZONE)
        local endDateStr = endDate:fmt("%m.%d")
        self.Label_time:setText(startDateStr)
        self.Label_end_time:setText(endDateStr..GV_UTC_TIME_STRING)
    end
end

function CelebrationView:updateStageInfo()

    local stageIndex = OneYearDataMgr:getCurTurnIndex()
    if not stageIndex then
        self.Panel_root:stopAllActions()
        return
    end

    self.curTurnIndex = stageIndex
    ---获取当前处于什么阶段 1.报名 2.抽奖二等奖 3：抽一等奖 4.显示奖励
    local stage,inStage = OneYearDataMgr:getTimeStage(self.curTurnIndex)
    self.Panel_sign:setVisible(stage == 1)
    self.Panel_draw:setVisible(stage == 2 or stage == 3)
    self.Panel_openaward:setVisible(stage == 4 and inStage)
    self.Panel_active:setVisible(stage ~= 4)
    self.Panel_finish:setVisible(false)

    if stage == 1 then
        self:updateSignInfo()
    elseif stage == 2 or stage == 3 then
        self:updateDrawView(stage)
        self:updateActiveValue()
    elseif stage == 4 then
        self:updateAwardView()
    end

    self:updateTitle(stage,inStage)
end


function CelebrationView:updateTitle(stage,inStage)

    --local curTime = Utils:getLocalDate(ServerDataMgr:getServerTime())
    local curTime = Utils:getUTCDate(ServerDataMgr:getServerTime() , GV_UTC_TIME_ZONE)
    local curTimeStr = curTime:fmt("%Y-%m-%d %H:%M")
    print("stage",self.curTurnIndex,stage,curTimeStr)
    ---stage 1.报名 2.抽奖二等奖 3：抽一等奖 4.显示奖励
    if stage == 1 then
        self.Label_vote_tip:setTextById(112000255, self.curTurnIndex)
        local voteTime = ""
        local stageInfo = OneYearDataMgr:getStageInfoByIndex(self.curTurnIndex)
        if stageInfo then
            local startTime = Utils:getUTCDate(stageInfo.registrationTime, GV_UTC_TIME_ZONE)
            local startDateStr = startTime:fmt("%Y-%m-%d %H:%M")
            local closeTime = Utils:getUTCDate(stageInfo.endTtime, GV_UTC_TIME_ZONE)
            local closeStr = closeTime:fmt("%H:%M")
            voteTime =startDateStr.."-"..closeStr..GV_UTC_TIME_STRING
        end
        self.Label_vote_time:setText(voteTime)
    elseif stage == 2 or stage == 3 then

    elseif stage == 4 then

        if inStage then
            local awardTime = ""
            local curStageInfo = OneYearDataMgr:getStageInfoByIndex(self.curTurnIndex)
            if curStageInfo then
                local startTime = Utils:getUTCDate(curStageInfo.rewardTime, GV_UTC_TIME_ZONE)
                local startDateStr = startTime:fmt("%Y-%m-%d %H:%M")
                local closeTime = Utils:getUTCDate(curStageInfo.finishTime, GV_UTC_TIME_ZONE)
                local closeStr = closeTime:fmt("%H:%M")
                awardTime =startDateStr.."-"..closeStr..GV_UTC_TIME_STRING
            end
            self.Label_getReward_time:setTextById(112000256, awardTime)
        else
            self.Panel_finish:setVisible(true)
            local nextTurnIndex = self.curTurnIndex + 1
            local nextStageInfo = OneYearDataMgr:getStageInfoByIndex(nextTurnIndex)
            if nextStageInfo then
                self.Image_finished:setVisible(false)
                self.Image_cool_bg:setVisible(true)
                local nextStartTime = nextStageInfo.registrationTime
                local curTime = ServerDataMgr:getServerTime()
                local remainTime = nextStartTime - curTime
                if remainTime < 0 then
                    self.Image_finished:setVisible(true)
                    self.Image_cool_bg:setVisible(false)
                    return
                end
                local act = CCSequence:create({
                    CCDelayTime:create(1),
                    CCCallFunc:create(function()
                        local nextStartTime = nextStageInfo.registrationTime
                        local curTime = ServerDataMgr:getServerTime()
                        local remainTime = nextStartTime - curTime
                        if remainTime < 0 then
                            self.Panel_finish:stopAllActions()
                        else
                            local day, hour, min, sec = Utils:getDHMS(remainTime, false)
                            local minStr = string.format("%02d",min)
                            local secStr = string.format("%02d",sec)
                            local timeStr = minStr..secStr
                            for i=1,4 do
                                local timeNum = timeStr[i] and timeStr[i] or "0"
                                self.coolTimeText[i]:setTexture(self.numRes[tonumber(timeNum)])
                            end

                        end
                    end),
                })
                self.Panel_finish:runAction(CCRepeatForever:create(act))
            else
                self.Image_finished:setVisible(true)
                self.Image_cool_bg:setVisible(false)
            end
        end
    end
end

function CelebrationView:updateSignInfo()
    local personNum = OneYearDataMgr:getSignPersonNum()
    local strNum = string.format("%06d",personNum)
    for i=1,#strNum do
        if self.Image_signNumTab[i] then
            self.Image_signNumTab[i]:setTexture("ui/activity/oneYear/luckyReward1/num/"..strNum[i]..".png")
        end
    end
    self:updateActiveValue()
end


function CelebrationView:updateActiveValue()

    local count = GoodsDataMgr:getItemCount(self.livenessId)
    --local color = count < self.targetValue and me.RED or me.WHITE
    --self.Label_active_value:setColor(color)
    self.Label_active_value:setText(count)
    self.Label_active_target:setText("/"..self.targetValue)
    self:updateSignBtnState()
end

function CelebrationView:updateSignBtnState()

    local isSign = OneYearDataMgr:isSign()
    local count = GoodsDataMgr:getItemCount(self.livenessId)
    if count >= self.targetValue then
        self.Image_signed_active:setVisible(isSign)
        self.Button_sign:setVisible(not isSign)
        local stage,inStage = OneYearDataMgr:getTimeStage(self.curTurnIndex)
        local couldHandle = inStage and (not isSign)
        self.Button_sign:setTouchEnabled(couldHandle)
        self.Button_sign:setGrayEnabled(not couldHandle)
        self.Spine_sign_down:setVisible(couldHandle)
        self.Spine_sign_up:setVisible(couldHandle)
    else
        self.Image_signed_active:setVisible(false)
        self.Button_sign:setVisible(false)
    end


    self.Button_goto:setVisible(count < self.targetValue)

end

function CelebrationView:updateDrawView(stage)

    local isSign = OneYearDataMgr:isSign()
    self.Image_signed:setVisible(isSign)
    self.Image_not_sign:setVisible(not isSign)

    local personNum = OneYearDataMgr:getSignPersonNum()
    self.Label_sign_num:setText(personNum)

    local voteTime = ""
    local stageInfo = OneYearDataMgr:getStageInfoByIndex(self.curTurnIndex)
    if stageInfo then
        local startTime = Utils:getUTCDate(stageInfo.drawInfo[1].drawTime, GV_UTC_TIME_ZONE)
        local startDateStr = startTime:fmt("%Y-%m-%d %H:%M")
        local closeTime = Utils:getUTCDate(stageInfo.drawInfo[2].closingTime, GV_UTC_TIME_ZONE)
        local closeStr = closeTime:fmt("%H:%M")
        voteTime =startDateStr.."-"..closeStr..GV_UTC_TIME_STRING
    end
    self.Label_draw_time:setText(voteTime)

    ---抽取奖励类型 1:一等奖 2：二等奖
    local awardType = stage == 2 and 2 or 1
    self.Panel_draw_first:setVisible(awardType == 1)
    self.Panel_draw_scend:setVisible(awardType == 2)

    local pos = awardType == 2 and ccp(-174,67) or ccp(-171,-9)
    local pos1 = awardType == 2 and ccp(34,100) or ccp(31,24)
    self.Label_draw_tip:setTextById(112000257, self.curTurnIndex)
    self.Label_draw_tip:setPosition(pos)
    self.Label_draw_time:setPosition(pos1)

    local allReawards = OneYearDataMgr:getCelebrationRewards()
    if not allReawards then
        return
    end
    local stageInfo = OneYearDataMgr:getStageInfoByIndex(self.curTurnIndex)
    if not stageInfo then
        return
    end

    local firstPrizeId = allReawards[1].list[self.curTurnIndex]
    local scendPrizeId = allReawards[2].list[self.curTurnIndex]
    if awardType == 1 then
        self:showFirstLuckyList(stageInfo.sign,firstPrizeId)
    elseif awardType == 2 then
        self:showScendLuckyList(stageInfo.sign,scendPrizeId)
    end
end

function CelebrationView:showFirstLuckyList(turnNo,prizeId)

    local luckyList = OneYearDataMgr:getLuckyList(turnNo,prizeId)
    if not next(luckyList) then
        return
    end
    local len = #luckyList
    self:updateFirstItem(luckyList[len])
end

function CelebrationView:updateFirstItem(data,isUpdate)

    local strNum = string.format("%09d",data.pid)
    for i=1,#strNum do
        local Image_userid = self.firstLuckyNum_[i].num
        if Image_userid then
            Image_userid:setVisible(not isUpdate)
            Image_userid:setTexture(self.numRes[tonumber(strNum[i])])
        end
    end

    if isUpdate then
        self.Label_cur_name:setText("?????")
        self.Label_cur_name_temp:setText(data.pName)
        self.Label_cur_name_temp:setPosition(ccp(-182,-3))
        for i=1,9 do
            local spine = self.firstLuckyNum_[i].spine
            local index = math.random(0,9)
            spine:setVisible(true)
            spine:play(tostring(index),true)
        end

        self:timeOut(function()
            for i=1,9 do
                local spine = self.firstLuckyNum_[i].spine
                local Image_userid = self.firstLuckyNum_[i].num
                spine:stop()
                spine:setVisible(false)
                Image_userid:setVisible(true)
                if i == 9 then
                    self:firstPrizeAfterAnimate(data.pName)
                end
            end
        end, 30)
    else
        self.Label_cur_name:setText(data.pName)
    end
end

function CelebrationView:firstPrizeAfterAnimate(playerName)

    self.Spine_first:play("baodian",false)
    local seq = CCSequence:create({
        CCSpawn:create({
            CCMoveTo:create(0.1,ccp(-11,-3)),
            CCFadeIn:create(0.1)
        }),
        CCCallFunc:create(function()
            self.Label_cur_name_temp:setOpacity(0)
            self.Label_cur_name:setText(playerName)
        end)
    })
    self.Label_cur_name_temp:runAction(seq)
end

function CelebrationView:showScendLuckyList(turnNo,prizeId)

    local luckyList = OneYearDataMgr:getLuckyList(turnNo,prizeId)
    if not next(luckyList) then
        return
    end

    local startIndx = #luckyList - 5 + 1
    if startIndx < 1 then
        startIndx = 1
    end
    local id = 0
    for i = startIndx,startIndx+4 do
        id = id + 1
        self:updateScendLuckyItem(id,luckyList[i],false)
    end
end

function CelebrationView:updateScendLuckyItem(index,data,isNew)

    if not self.scend_prizeItem_[index] then
        return
    end

    local Label_name = self.scend_prizeItem_[index].Label_name
    local Label_name_temp = self.scend_prizeItem_[index].Label_name_temp
    Label_name_temp:setPosition(ccp(223,21))
    Label_name_temp:setOpacity(0)
    local Spine_baoza = self.scend_prizeItem_[index].Spine_baoza
    if not data then
        Label_name:setText("????????")
        for i=1,9 do
            local numTab = self.scend_prizeItem_[index].num[i]
            numTab.Image_userid:setTexture(self.numRes[0])
        end
        return
    end
    Label_name_temp:setText(data.pName)
    local strNum = string.format("%09d",data.pid)
    for i=1,#strNum do
        local numTab = self.scend_prizeItem_[index].num[i]
        if numTab then
            local Image_userid = numTab.Image_userid
            if Image_userid then
                Image_userid:setTexture(self.numRes[tonumber(strNum[i])])
                Image_userid:setVisible(not isNew)
            end
            numTab.spine:setVisible(isNew)
        end
    end

    if not isNew then
        Label_name:setText(data.pName)
    else
        Label_name:setText("????????")
        for i=1,9 do
            local numTab = self.scend_prizeItem_[index].num[i]
            local Spine_user = numTab.spine
            local index = math.random(0,9)
            Spine_user:setVisible(true)
            Spine_user:play(tostring(index),true)
        end

        self:timeOut(function()
            for i=1,9 do
                local numTab = self.scend_prizeItem_[index].num[i]
                local Image_userid = numTab.Image_userid
                local Spine_user = numTab.spine
                Spine_user:stop()
                Spine_user:setVisible(false)
                Image_userid:setVisible(true)
                if i == 9 then
                    Spine_baoza:play("baodian",false)
                    local seq = CCSequence:create({
                        CCSpawn:create({
                            CCMoveTo:create(0.2,ccp(295,35)),
                            CCFadeIn:create(0.2)
                        }),
                        CCCallFunc:create(function()
                            Label_name_temp:setOpacity(0)
                            Label_name:setText(data.pName)
                        end)
                    })
                    Label_name_temp:runAction(seq)
                end
            end
        end, 20)
    end
end

function CelebrationView:updateAwardView()

    self.ListView_award:removeAllItems()
    local stageInfo = OneYearDataMgr:getStageInfoByIndex(self.curTurnIndex)
    if not stageInfo then
        return
    end

    local isSign = OneYearDataMgr:isSign()
    local prizeId,turnNo = OneYearDataMgr:getPrizeId()
    if prizeId == 0 and isSign then
        prizeId = self.joinPrize
    end

    if turnNo ~= stageInfo.sign and prizeId ~= 0 then
        prizeId = self.joinPrize
    end

    local strId = isSign and 270491 or 63605
    self.Label_award_geted:setTextById(strId)
    self.Label_notsign_tip:setVisible(not isSign)
    self.Label_award_tip:setVisible(isSign)
    if isSign then
        local showReward,prizeType = OneYearDataMgr:getRewardsByPrizeId(prizeId)
        if prizeType ~= 0 then
            self.Label_award_tip:setTextById(self.awardStrId[prizeType])
        else
            self.Label_award_tip:setText("")
        end
        for k,v in pairs(showReward) do
            local itemClone = self.Image_luckyaward_item:clone()
            local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            local itemId = tonumber(k)
            if itemId then
                PrefabDataMgr:setInfo(Panel_goodsItem, itemId, v)
                Panel_goodsItem:setPosition(ccp(0,0))
                itemClone:addChild(Panel_goodsItem)
                self.ListView_award:pushBackCustomItem(itemClone)
            end
        end
        Utils:setAliginCenterByListView(self.ListView_award,true)
    end
    self:updateAwardBtn()
end

function CelebrationView:updateAwardBtn()

    EventMgr:dispatchEvent(EV_ACTIVITY_UPDATE_PROGRESS)
    local stage,inStage = OneYearDataMgr:getTimeStage(self.curTurnIndex)
    if stage == 4 and inStage then
        local awardState = OneYearDataMgr:getAwardState()
        self.Button_award:setVisible(awardState == 1)
        self.Image_geted:setVisible(awardState == 2)
        self.Image_award_geted:setVisible(awardState ~= 1)
    else
        self.Button_award:setVisible(false)
        self.Image_geted:setVisible(false)
        self.Image_award_geted:setVisible(false)
    end

end


function CelebrationView:onUpdateHandle()
    self:updateSignBtnState()
    self:updateAwardBtn()
end

function CelebrationView:updateNewPlayer(newPlayer)
    dump(newPlayer)
    for k,v in ipairs(newPlayer) do
        local awards,awardType = OneYearDataMgr:getRewardsByPrizeId(v.prize)
        if awardType == 1 then
            self:updateFirstItem(v,true)
        elseif awardType == 2 then
            self:updateScendLuckyItem(k,v,true)
        end
    end
end

function CelebrationView:registerEvents()

    EventMgr:addEventListener(self, EV_UPDATE_NEW_LUCKYPLAYER, handler(self.updateStageInfo, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.updateActiveValue, self))
    EventMgr:addEventListener(self, EV_ADD_NEW_LUCKYPLAYER, handler(self.updateNewPlayer, self))
    EventMgr:addEventListener(self, EV_UPDATE_BASE_ONFO, handler(self.updateAwardBtn, self))
    EventMgr:addEventListener(self, EV_UPDATE_BASE_ONFO, handler(self.onUpdateHandle, self))
    EventMgr:addEventListener(self, EV_UPDATE_SIGN_NUM, handler(self.updateSignInfo, self))
    EventMgr:addEventListener(self,"applicationWillEnterForeground",handler(self.refreshUI, self))
    self.Button_rule:onClick(function()
        Utils:openView("oneYear.CelebrationRuleView",self.activityId_)
    end)

    self.Button_address:onClick(function()
        local prizeId,turnNo = OneYearDataMgr:getPrizeId()
        local award,prizeType,luckyTurnIndex = OneYearDataMgr:getRewardsByPrizeId(prizeId)
        print(prizeId,self.joinPrize,prizeType)
        if prizeId == 0 or prizeId == self.joinPrize or prizeType ~= 1 then
            Utils:showTips(TextDataMgr:getText(63603))
            return
        end
        Utils:openView("oneYear.AddressView",self.spreadQq)
    end)

    self.Button_goto:onClick(function()
        --FunctionDataMgr:jPlotFuben()
        FunctionDataMgr:jActivityByType(EC_ActivityType2.ASSIST)
    end)

    self.Button_sign:onClick(function()
        local stage,inStage = OneYearDataMgr:getTimeStage(self.curTurnIndex)
        local isSign = OneYearDataMgr:isSign()
        local couldHandle = inStage and (not isSign)
        if couldHandle then
            OneYearDataMgr:Send_sign()
        end
    end)

    self.Button_lucky_list:onClick(function()
        Utils:openView("oneYear.LuckyListView",self.robe)
        --self.test = self.test and self.test or 0
        --self.test = self.test + 1
        --OneYearDataMgr:test(self.test)
    end)

    self.Button_award:onClick(function()
        OneYearDataMgr:Send_GetAward()
    end)
end

return CelebrationView
