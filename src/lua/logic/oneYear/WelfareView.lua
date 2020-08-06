
local WelfareView = class("WelfareView", BaseLayer)

function WelfareView:initData(activityId)

    self.centerPos = ccp(0,0)
    --self.radius = 10
    self.radius = 100
    --self.deltaDegree = 20
    self.deltaDegree = 7
    self.PI = 3.1415926
    --self.max_moveDis = 200
    self.max_moveDis = 45

    ---分别剩1,2,3,4,5,6张牌时，第一张牌的位置
    self.firstDegree = {90,100,110,120,130,140}
    self.firstDegree = {90,94,97,100,104,108}

    self.color = {ccc3(231,167,60),ccc3(182,135,255),ccc3(87,171,229)}

    self.celebrationSummon = {}
    self.summon_ = SummonDataMgr:getCelebrationSummon()
    for k,v in ipairs(self.summon_) do
        for i,info in ipairs(v) do
            table.insert(self.celebrationSummon,info)
        end
    end
    self.summonId = self.celebrationSummon[1].id
    self.activityId_ = activityId
    self.startPos = ccp(0,-342)

    self.spineResName = {"effects_ZNQ_fanka_cheng","effects_ZNQ_fanka_zi","effects_ZNQ_fanka_lan"}

    --1:出牌
    self.animateTime = {}
    self.animateTime.chupai1 = 0.2
    self.animateTime.chupai2 = {0.18,0.14,0.12,0.12,0.14,0.18}
    self.animateTime.waite = 0.5
    self.animateTime.toBack = 0.35
    self.animateTime.toCenter = 0.25
    self.animateTime.toFront = 0.35
    self.animateTime.fold = 0.1
    self.animateTime.unfold = 0.1
end

function WelfareView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.oneYear.welfareView")
end

function WelfareView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.Panel_card = TFDirector:getChildByPath(self.Panel_root, "Panel_card")
    --self.Panel_card:setSize(GameConfig.WS)
    self.Panel_touch = TFDirector:getChildByPath(self.Panel_root, "Panel_touch")
    self.Panel_touch:setSize(GameConfig.WS)
    self.Button_preview = TFDirector:getChildByPath(self.Panel_root, "Button_preview")
    self.Button_record = TFDirector:getChildByPath(self.Panel_root, "Button_record")
    self.Label_time = TFDirector:getChildByPath(self.Panel_root, "Label_time")
    self.centerPos = ccp(0,-GameConfig.WS.height/2)
    self.centerPos = ccp(0,-GameConfig.WS.height/2 - 520)
    self.radius = GameConfig.WS.height/2
    self.radius = 900
    self.cards = {}
    for i=1,6 do
        local tab = {}
        tab.pl = TFDirector:getChildByPath(self.Panel_root, "Panel_card_"..i)
        tab.pl:setZOrder(i)
        tab.front = TFDirector:getChildByPath(tab.pl, "Panel_front")
        local qualityBg = {}
        qualityBg[1] = TFDirector:getChildByPath(tab.front, "Image_quality_bg1")
        qualityBg[2] = TFDirector:getChildByPath(tab.front, "Image_quality_bg2")
        qualityBg[3] = TFDirector:getChildByPath(tab.front, "Image_quality_bg3")
        tab.itemIcon = TFDirector:getChildByPath(tab.front, "Image_item")
        tab.qualityBg = qualityBg
        tab.Label_name = TFDirector:getChildByPath(tab.front, "Label_name")
        tab.Label_num = TFDirector:getChildByPath(tab.front, "Label_num")
        tab.back = TFDirector:getChildByPath(tab.pl, "Image_back_card")
        tab.Spine_bg = TFDirector:getChildByPath(tab.pl, "Spine_bg")
        tab.Spine_front = TFDirector:getChildByPath(tab.pl, "Spine_front")
        tab.pos = tab.pl:getPosition()
        tab.originalPos = tab.pl:getPosition()
        tab.roate = 0
        tab.lineAngel = 0
        tab.moveTo = i
        tab.isMove = false
        tab.inQueue = true
        table.insert(self.cards,tab)
    end

    self.Label_vote_cnt = TFDirector:getChildByPath(self.Panel_root, "Label_vote_cnt")
    self.Image_cost = TFDirector:getChildByPath(self.Panel_root, "Image_cost")
    self.Label_num = TFDirector:getChildByPath(self.Image_cost, "Label_num")
    self.Image_icon = TFDirector:getChildByPath(self.Image_cost, "Image_icon")
    self.Image_cost_icon = TFDirector:getChildByPath(self.Panel_root, "Image_cost_icon")
    self.Spine_chupai = TFDirector:getChildByPath(self.Panel_root, "Spine_chupai"):hide()
    self.Spine_xipai = TFDirector:getChildByPath(self.Panel_root, "Spine_xipai")
    self.Spine_chupai2 = TFDirector:getChildByPath(self.Panel_root, "Spine_chupai2")
    self:initUILogic()
end

function WelfareView:updateActivity()
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    local startDate = Utils:getLocalDate(self.activityInfo_.startTime)
    local startDateStr = startDate:fmt("%m.%d")
    local endDate = Utils:getLocalDate(self.activityInfo_.endTime)
    local endDateStr = endDate:fmt("%m.%d")
    self.Label_time:setTextById(800041, startDateStr, endDateStr)
end

function WelfareView:initUILogic()

    self.cardNums = SummonDataMgr:getCelebrationCnt(self.summonId)
    --if self.cardNums == 6 then
    --    self:resetVotePool()
    --else
    --    self.Panel_touch:setVisible(false)
    --    self:updateCard(self.cardNums)
    --end
    self.Panel_touch:setVisible(false)
    self:updateCard(self.cardNums)
    --local drawnode = DrawNode:create()
    --drawnode:drawDot(self.centerPos,self.radius,ccc4(1,1,0,1))
    --self.Panel_card:addChild(drawnode)

    self:updateSummonCost()

    self:updateDayVoteNum()

end

---当卡牌数是6张的时候展示
function WelfareView:resetVotePool()

    self.Panel_touch:setVisible(true)
    local award = SummonDataMgr:getCelebrationPrize(self.summonId)
    for i=1,6 do
        self.cards[i].back:setVisible(false)
        self.cards[i].pl:setVisible(true)
        self.cards[i].pl:setPosition(self.startPos)
        self.cards[i].pl:setOpacity(0)
        self.cards[i].pl:setRotation(0)
        self.cards[i].moveTo = 1
        self.cards[i].isMove = false
        self.cards[i].front:show()
        self.cards[i].inQueue = true
        self.cards[i].pl:setZOrder(i)

        if award[i] then
            local poolQuality = SummonDataMgr:getCelebrationPoolQuality(award[i].id,award[i].num)
            local color = self.color[poolQuality]
            for j=1,3 do
                self.cards[i].qualityBg[j]:setVisible(j == poolQuality)
            end
            local goodCfg = GoodsDataMgr:getItemCfg(award[i].id)
            if goodCfg then

                local Panel_goodsItem = self.cards[i].itemIcon:getChildByName("Panel_goodsItem")
                if not Panel_goodsItem then
                    Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
                    Panel_goodsItem:setPosition(ccp(0,0))
                    Panel_goodsItem:setScale(0.7)
                    Panel_goodsItem:setName("Panel_goodsItem")
                    self.cards[i].itemIcon:addChild(Panel_goodsItem)
                end
                local Image_frame = TFDirector:getChildByPath(Panel_goodsItem, "Image_frame"):hide()
                PrefabDataMgr:setInfo(Panel_goodsItem, award[i].id)
                Panel_goodsItem:setSwallowTouch(false)
                self.cards[i].itemIcon:show()
                self.cards[i].Label_name:setTextById(goodCfg.nameTextId)
                self.cards[i].Label_name:setColor(color)
            end
            self.cards[i].Label_num:setText("x"..award[i].num)
            self.cards[i].Label_num:setColor(color)
        end
    end

    self.Spine_chupai:setVisible(true)
    self:playStartAnimate(1)
end

function WelfareView:playStartAnimate(i)

    self.Spine_chupai2:play("animation",false)
    local act = CCSequence:create({
        CCSpawn:create({
           CCFadeIn:create(self.animateTime.chupai1),
           CCMoveTo:create(self.animateTime.chupai1,ccp(0,self.cards[i].originalPos.y)),
        }),
        CCMoveTo:create(self.animateTime.chupai2[i],ccp(self.cards[i].originalPos.x,self.cards[i].originalPos.y)),
        CCCallFunc:create(function()
            local nextIndex = i + 1
            if nextIndex > 6 then
                self:timeOut(function ()
                    self:allCardsTurnToBlack(6)
                end, self.animateTime.waite)
            else
                self:playStartAnimate(nextIndex)
            end
            self.cards[i].pl:stopAllActions()
        end)
    })
    self.cards[i].pl:runAction(act)
end

function WelfareView:allCardsTurnToBlack(i)

    ViewAnimationHelper.doCameraAction(self.cards[i].back,self.cards[i].front,self.animateTime.toBack,function()
        local nextIndex = i - 1
        if nextIndex < 1 then
            self.Spine_chupai:setVisible(false)
            self:playShuffleCardsAni()
        else
            self:allCardsTurnToBlack(nextIndex)
        end
    end)

    --self:turnToBack(self.cards[i],function()
    --    local nextIndex = i + 1
    --    if nextIndex > 6 then
    --        self.Spine_chupai:setVisible(false)
    --        self:playShuffleCardsAni()
    --    else
    --        self:allCardsTurnToBlack(nextIndex)
    --    end
    --end)
end

function WelfareView:allCardsTurnToFront(i)
    ViewAnimationHelper.doCameraAction(self.cards[i].front,self.cards[i].back,0.5,function()
        local nextIndex = i + 1
        if nextIndex > 6 then
            dump("allCardsTurnToFront end")
        else
            self:allCardsTurnToFront(nextIndex)
        end
    end)
end

function WelfareView:playShuffleCardsAni()

    for i=1,6 do
        self.cards[i].back:runAction(CCOrbitCamera:create(0, 1, 0, 0, 0, 0, 0))
        self.cards[i].front:runAction(CCOrbitCamera:create(0, 1, 0, 0, 0, 0, 0))
        self.cards[i].pl:setPositionX(0)
    end

    self.Panel_card:setVisible(false)
    self.Spine_xipai:setVisible(true)
    self.Spine_xipai:play("animation",false)
    self.Spine_xipai:addMEListener(TFARMATURE_COMPLETE,function()
        self.Spine_xipai:removeMEListener(TFARMATURE_COMPLETE)
        self:updateCardBaseInfo(self.cardNums)
        self.Panel_card:setVisible(true)
        for i=1,6 do
            self:playXipaiAnimate(i)
        end
        self.Spine_xipai:setVisible(false)
        self.Panel_touch:setVisible(false)
    end)
end

function WelfareView:playXipaiAnimate(id)

    local act = CCSequence:create({
        CCSpawn:create({
            CCMoveTo:create(0.2,self.cards[id].pos),
            CCRotateTo:create(0.2,self.cards[id].roate)
        }),
        CCCallFunc:create(function()
            print("playXipaiAnimate",id)
        end)
    })
    self.cards[id].pl:runAction(act)
end

function WelfareView:updateDayVoteNum()
    local summonCfg = SummonDataMgr:getSummonCfg(self.summonId)
    if summonCfg then
        local voteCnt,maxCnt = SummonDataMgr:getDayVoteCnt(summonCfg.groupId)
        local lefeCnt = maxCnt - voteCnt
        lefeCnt = lefeCnt < 0 and 0 or lefeCnt
        self.Label_vote_cnt:setText("今日剩余"..lefeCnt.."/"..maxCnt.."次翻牌，消耗"..self.costItem_[1].num.."个")
    end
end

function WelfareView:updateSummonCost()

    self.costItem_ = {}

    local summonCfg = SummonDataMgr:getSummonCfg(self.summonId)
    if not summonCfg then
        return
    end

    for j, cost in ipairs(summonCfg.cost) do
        local costIndex = j
        local costId, costNum
        for id, num in pairs(cost) do
            costId = id
            costNum = num
            break
        end

        local ownNum = GoodsDataMgr:getItemCount(costId)
        local costCfg = GoodsDataMgr:getItemCfg(costId)
        self.Image_icon:setTexture(costCfg.icon)
        self.Image_cost_icon:setTexture(costCfg.icon)
        self.Label_num:setText("拥有："..ownNum)
        self.Image_icon:onClick(function()
            Utils:showInfo(costId, nil, true)
        end)

        self.costItem_[1] = {
            id = costId,
            num = costNum,
            index = costIndex,
        }
    end
end

function WelfareView:updateCard(totalCards)

    local first = self.firstDegree[totalCards]
    for i=1,6 do
        self.cards[i].pl:setVisible(i <= totalCards)
        if i <= totalCards then
            local degree = first - (i-1)*self.deltaDegree
            local x,y = self:getCirclePos(degree)
            self.cards[i].pl:setPosition(ccp(x,y))
            self.cards[i].pos = ccp(x,y)
            local rotaion = degree - 90
            self.cards[i].pl:setRotation(-rotaion)
            self.cards[i].roate = -rotaion
            local angle = self:getLineAngel(ccp(x,y),self.centerPos)
            self.cards[i].lineAngel = math.deg(angle)
            self.cards[i].front:hide()
        end
    end
end

function WelfareView:updateCardBaseInfo(totalCards)
    local first = self.firstDegree[totalCards]
    for i=1,6 do
        self.cards[i].pl:setVisible(i <= totalCards)
        if i <= totalCards then
            local degree = first - (i-1)*self.deltaDegree
            local x,y = self:getCirclePos(degree)
            self.cards[i].pos = ccp(x,y)
            local rotaion = degree - 90
            self.cards[i].roate = -rotaion
            local angle = self:getLineAngel(ccp(x,y),self.centerPos)
            self.cards[i].lineAngel = math.deg(angle)
        end
    end
end

function WelfareView:foldCard(id)

    local nextMoveTo = self.cards[id].moveTo - 1
    if nextMoveTo <= 0 then
        self.cards[id].pl:stopAllActions()
        self.cards[id].isMove = false
        local isEnd = true
        for i=1,6 do
            if self.cards[i].isMove then
                isEnd = false
                break
            end
        end
        if isEnd then
            self:resetCard()
        end
        return
    end

    self.cards[id].moveTo = nextMoveTo
    self.cards[id].isMove = true

    if not self.cards[id].inQueue then
        if id > 1 and (not self.cards[id - 1].isMove) then
            self:foldCard(id - 1)
        end
        self:foldCard(id)
        return
    end

    local act = CCSequence:create({
        CCSpawn:create({
            CCMoveTo:create(self.animateTime.fold,self.cards[self.cards[id].moveTo].pos),
            CCRotateTo:create(self.animateTime.fold,self.cards[self.cards[id].moveTo].roate)
        }),
        CCCallFunc:create(function()
            if id > 1 and (not self.cards[id - 1].isMove) then
                self:foldCard(id - 1)
            end
            self:foldCard(id)
        end)
    })
    self.cards[id].pl:runAction(act)
end

function WelfareView:resetCard()

    self:updateCardBaseInfo(self.cardNums)

    for i=1,6 do
        self.cards[i].moveTo = 1
        self.cards[i].isMove = false
        self.cards[i].pl:setPosition(self.cards[1].pos)
        self.cards[i].pl:setRotation(self.cards[1].roate)
        self.cards[i].front:hide()
        self.cards[i].back:show()
        self.cards[i].inQueue = true
        self.cards[i].pl:setZOrder(i)
    end

    self:timeOut(function()
        self:unFoldCard(self.cardNums)
    end,1)

end

function WelfareView:unFoldCard(id)

    local nextMoveTo = self.cards[id].moveTo + 1
    if nextMoveTo > id then
        self.cards[id].pl:stopAllActions()
        self.cards[id].isMove = false
        local isEnd = true
        for i=1,6 do
            if self.cards[i].isMove then
                isEnd = false
                break
            end
        end
        if isEnd then
            self.Panel_touch:setVisible(false)
        end
        return
    end

    self.cards[id].moveTo = nextMoveTo
    self.cards[id].isMove = true

    if not self.cards[id].inQueue then
        if id > 1 and (not self.cards[id - 1].isMove) then
            self:unFoldCard(id - 1)
        end
        self:unFoldCard(id)
        return
    end

    local act = CCSequence:create({
        CCSpawn:create({
            CCMoveTo:create(self.animateTime.unfold,self.cards[self.cards[id].moveTo].pos),
            CCRotateTo:create(self.animateTime.unfold,self.cards[self.cards[id].moveTo].roate)
        }),
        CCCallFunc:create(function()
            if id > 1 and (not self.cards[id - 1].isMove) then
                self:unFoldCard(id - 1)
            end
            self:unFoldCard(id)
        end)
    })
    self.cards[id].pl:runAction(act)
end

function WelfareView:moveToCenter(id)
    self.Panel_touch:setVisible(true)
    self.cards[id].pl:setZOrder(10)
    local act = CCSequence:create({
        CCSpawn:create({
            CCMoveTo:create(self.animateTime.toCenter, ccp(0, 0)),
            CCRotateTo:create(self.animateTime.toCenter, 0),
            CCScaleTo:create(self.animateTime.toCenter,1.2)
        }),
        CCCallFunc:create(function()
            for i=1,3 do
                self.cards[id].qualityBg[i]:setVisible(false)
            end
            self.cards[id].itemIcon:hide()
            self:turnLuckyCard(id)
        end)
    })
    self.cards[id].pl:runAction(act)
end

function WelfareView:turnLuckyCard(id)

    local function callback()

        self.cards[id].back:runAction(CCOrbitCamera:create(0, 1, 0, 0, 0, 0, 0))
        self.cards[id].front:runAction(CCOrbitCamera:create(0, 1, 0, 0, 0, 0, 0))

        local poolQuality = SummonDataMgr:getCelebrationPoolQuality(self.rewardItemId,self.rewardItemNum)
        local spineRes = self.spineResName[poolQuality]
        self.cards[id].Spine_bg:play(spineRes.."2",false)
        self.cards[id].Spine_front:play(spineRes,false)
        self.cards[id].Spine_front:addMEListener(TFARMATURE_COMPLETE,function()
            self.cards[id].Spine_front:removeMEListener(TFARMATURE_COMPLETE)
            self:timeOut(function()
                self.cards[self.chooseCardId].pl:setScale(0.92)
                self:changeCardGray(self.chooseCardId,false)
                Utils:showReward(self.reward)
                self.cards[id].pl:hide()
                for i=1,6 do
                    self.cards[i].moveTo = i
                end

                ---修改新一轮的第一张牌的位置，
                if self.cardNums >= 1 then
                    local degree = self.firstDegree[self.cardNums]
                    local x,y = self:getCirclePos(degree)
                    self.cards[1].pos = ccp(x,y)
                    local rotaion = degree - 90
                    self.cards[1].roate = -rotaion
                    if self.cardNums == 6 then
                        self:resetVotePool()
                    else
                        self:foldCard(6)
                    end

                else
                    --抽空
                end
            end)
        end)
    end
    self:turnToFront(self.cards[id],callback)
end

function WelfareView:turnToFront(card,callback)

    local action = Sequence:create({
        --RotateBy:create(0.4, 0, 180),
        CallFunc:create(function()
            local poolQuality = SummonDataMgr:getCelebrationPoolQuality(self.rewardItemId,self.rewardItemNum)
            local color = self.color[poolQuality]
            for i=1,3 do
                card.qualityBg[i]:setVisible(i == poolQuality)
            end
            card.itemIcon:show()
            local goodCfg = GoodsDataMgr:getItemCfg(self.rewardItemId)
            if goodCfg then

                card.Label_name:setTextById(goodCfg.nameTextId)
                card.Label_name:setColor(color)
                local Panel_goodsItem = card.itemIcon:getChildByName("Panel_goodsItem")
                if not Panel_goodsItem then
                    Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
                    Panel_goodsItem:setPosition(ccp(0,0))
                    Panel_goodsItem:setScale(0.7)
                    Panel_goodsItem:setName("Panel_goodsItem")
                    card.itemIcon:addChild(Panel_goodsItem)
                end
                local Image_frame = TFDirector:getChildByPath(Panel_goodsItem, "Image_frame"):hide()
                PrefabDataMgr:setInfo(Panel_goodsItem, self.rewardItemId)
                Panel_goodsItem:setSwallowTouch(false)
                card.itemIcon:show()
            end
            card.Label_num:setText("x"..self.rewardItemNum)
            card.Label_num:setColor(color)
            --self:turnToFront2(card,callback)
            ViewAnimationHelper.doCameraAction(card.front,card.back,self.animateTime.toFront,callback)
        end),
    })
    card.back:runAction(action)
end

function WelfareView:turnToFront2(card,callback)

    local action = Sequence:create({
        CallFunc:create(function()
            card.front:show()
            card.back:hide()
            card.back:runAction(RotateBy:create(0, 0, 180))
            card.isOpen = true
            Utils:playSound(5012, false)
        end),
        CCDelayTime:create(1),
        CallFunc:create(function()
            if callback then
                callback()
            end
        end)
    })
    card.front:runAction(action)
end

function WelfareView:turnToBack(card,callback)
    local action = Sequence:create({
        RotateBy:create(0.4, 0, 180),
        CallFunc:create(function()
            self:turnToBack2(card,callback)
        end),
    })
    card.front:runAction(action)
end

function WelfareView:turnToBack2(card,callback)

    local action = Sequence:create({
        RotateTo:create(0, 0),
        CallFunc:create(function()
            card.front:hide()
            card.back:show()
            card.isOpen = false
            card.front:runAction(Sequence:create({
                RotateTo:create(0, 0),
                CallFunc:create(function()
                    if callback then
                        callback()
                    end
                end)
            }))
        end),
    })
    card.back:runAction(action)
end

function WelfareView:changeCardGray(chooedIndex,opacity)

    for i=1,6 do
        if i ~= chooedIndex then
            self.cards[i].pl:setGrayEnabled(opacity)
        end
    end
end

function WelfareView:Send_Summon(id)
    local summonCfgInfo =  self.celebrationSummon[1]
    if not summonCfgInfo then
        return false
    end
    local cost = self.costItem_[1]
    if not GoodsDataMgr:currencyIsEnough(cost.id, cost.num) then
        Utils:showTips(303046)
        return false
    end

    local summonCfg = SummonDataMgr:getSummonCfg(self.summonId)
    if not summonCfg then
        return false
    end

    local voteCnt,maxCnt = SummonDataMgr:getDayVoteCnt(summonCfg.groupId)
    if voteCnt >= maxCnt then
        Utils:showTips(63607)
        return false
    end

    SummonDataMgr:send_SUMMON_SUMMON(summonCfgInfo.id, cost.index)
    self.chooseCardId = id
    return true
end

function WelfareView:onSummonHistoryEvent(historyData)
    Utils:openView("oneYear.WelfareRecordView",historyData)
end

function WelfareView:onItemUpdateEvent()
    self:updateSummonCost()
end

function WelfareView:onSummonResultEvent(reward,fixIte,summonId)
    if summonId ~= self.summonId then
        return
    end

    self.reward = reward
    self.rewardItemId = self.reward[1].id
    self.rewardItemNum = self.reward[1].num
    self:updateSummonCost()
    self.cards[self.chooseCardId].inQueue = false
    self:moveToCenter(self.chooseCardId)
end

function WelfareView:onSummonCountUpdateEvent()
    self.cardNums = SummonDataMgr:getCelebrationCnt(self.summonId)
end

function WelfareView:registerEvents()

    EventMgr:addEventListener(self, EV_UPDATE_VOTE_DAYNUM, handler(self.updateDayVoteNum, self))
    EventMgr:addEventListener(self, EV_SUMMON_CELEBRATION_COUNT, handler(self.onSummonCountUpdateEvent, self))
    EventMgr:addEventListener(self, EV_SUMMON_RESULT, handler(self.onSummonResultEvent, self))
    EventMgr:addEventListener(self, EV_SUMMON_HISTORY, handler(self.onSummonHistoryEvent, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onItemUpdateEvent, self))

    local beginPos, endPos = me.p(0, 0), me.p(0, 0)
    for i=1,6 do
        self.cards[i].pl:onTouch(function(event)
            if event.name == "began" then
                self.cards[i].pl:setScale(1)
                beginPos = event.target:getTouchStartPos()
                self:changeCardGray(i,true)
            elseif event.name == "moved" then
                local movePos = event.target:getTouchMovePos()
                local moveEndlPos = self.Panel_card:convertToNodeSpaceAR(movePos)
                local beginLocalPos = self.cards[i].pos
                if moveEndlPos.y <= beginLocalPos.y then
                    return
                end

                local disFlag = beginLocalPos.x >= 0 and 1 or -1
                local dis = self:getDistance(moveEndlPos,beginLocalPos)
                local moveDis = self.max_moveDis
                if self.max_moveDis > math.sqrt(dis)  then
                    moveDis = math.sqrt(dis)
                end
                local rad = math.rad(self.cards[i].lineAngel)
                local disX = moveDis*math.cos(rad)*disFlag
                local disY = moveDis*math.sin(rad)*disFlag
                self.cards[i].pl:setPosition(ccp(beginLocalPos.x+disX,beginLocalPos.y+disY))
            elseif event.name == "ended" then
                endPos = event.target:getTouchEndPos()
                
                --local endLocalPos = self.Panel_card:convertToNodeSpaceAR(endPos)
                local endLocalPos = self.cards[i].pl:getPosition()
                local originalPos = self.cards[i].pos
                local beginLocalPos = self.Panel_card:convertToNodeSpaceAR(beginPos)
                local dis = self:getDistance(endLocalPos,originalPos)
                if math.sqrt(dis) < self.max_moveDis-5 then
                    self.cards[i].pl:setPosition(originalPos)
                    self.cards[i].pl:setScale(0.92)
                    self:changeCardGray(i,false)
                else
                    ---开始抽卡
                    local sendResult = self:Send_Summon(i)
                    if not sendResult then
                        self.cards[i].pl:setPosition(originalPos)
                        self:changeCardGray(i,false)
                        self.cards[i].pl:setScale(0.92)
                    end
                end

            end
        end)
    end

    self.Button_preview:onClick(function()

        Utils:openView("oneYear.WelfareScanView")

    end)

    self.Button_record:onClick(function()
        local summonCfg = SummonDataMgr:getSummonCfg(self.summonId)
        SummonDataMgr:send_SUMMON_REQ_HISTORY_RECORD({summonCfg.groupId})
    end)

end

function WelfareView:getCirclePos(degree)
    local x   =   self.centerPos.x   +   self.radius   *   math.cos(math.rad(degree))
    local y   =   self.centerPos.y   +   self.radius   *   math.sin(math.rad(degree))
    return x,y
end

function WelfareView:getLineAngel(pos1,pos2)
    local k = (pos2.y - pos1.y)/(pos2.x - pos1.x)
    return math.atan(k)
end

function WelfareView:getDistance(pos1,pos2)
    local dis = (pos2.y - pos1.y)*(pos2.y - pos1.y) + (pos2.x - pos1.x)*(pos2.x - pos1.x)
    return dis
end

return WelfareView
