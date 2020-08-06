
local BingoDivinationView = class("BingoDivinationView", BaseLayer)

Enum_gameStage = {
    guess = 1,
    result = 2,
}

function BingoDivinationView:initData()

    self.voteNum = 0
    self.stage = Enum_gameStage.result
    self.victory = BingoDataMgr:getBingoLuckyCardId()
    self.oddsNum = 0
    local victoryInfo = BingoDataMgr:getBingoCardCfg(self.victory)
    if victoryInfo then
        self.oddsNum = victoryInfo.odds
    end

    self.pernum = 10

    self.cardImg = {}
    local bingoCardCfg = BingoDataMgr:getBingoCardCfg()
    for k,v in ipairs(bingoCardCfg) do
        self.cardImg[k] = v.pic
    end

    ---卡面资源
    self.cardImgRes = {}
    self.cardImgRes[1] = {"card_10101.png","card_10102.png"}
    self.cardImgRes[2] = {"card_10201.png","card_10202.png"}
    self.cardImgRes[3] = {"card_10301.png","card_10302.png"}
    self.cardImgRes[4] = {"card_10401.png"}
    self.cardImgRes[5] = {"card_10501.png","card_10502.png"}
    self.cardImgRes[6] = {"card_11201.png"}
    self.cardImgRes[7] = {"card_11301.png","card_11302.png"}

    self.numberTurnTime = 0.05
    local cfg = BingoDataMgr:getMiniGameCfg(EC_BingoGameType.Divination)
    self.limit = cfg.limit
    BingoDataMgr:playCg(cfg.enterDating)

    self.startUpdate = false

end

function BingoDivinationView:onShow()
    self.super.onShow(self)
    AudioExchangePlay.playBGM(self, true,"sound/bgm/kanban/main_qizui_11308.mp3")
end

function BingoDivinationView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.bingo.bingoDivinationView")
end

function BingoDivinationView:initUI(ui)

    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.Image_chip = TFDirector:getChildByPath(self.Panel_root, "Image_chip")
    self.Label_chip = TFDirector:getChildByPath(self.Panel_root, "Label_chip")
    self.Label_chip_delta = TFDirector:getChildByPath(self.Panel_root, "Label_chip_delta")
    self.Button_add_chip = TFDirector:getChildByPath(self.Panel_root, "Button_add_chip")

    self.Button_back = TFDirector:getChildByPath(self.Panel_root, "Button_back")
    self.Button_do = TFDirector:getChildByPath(self.Panel_root, "Button_do"):hide()
    self.Button_xipai = TFDirector:getChildByPath(self.Panel_root, "Button_xipai")
    self.Panel_vote = TFDirector:getChildByPath(self.Panel_root, "Panel_vote")
    self.Panel_result = TFDirector:getChildByPath(self.Panel_root, "Panel_result"):hide()
    self.Label_resultNum = TFDirector:getChildByPath(self.Panel_result, "Label_resultNum")

    self.Image_vote = TFDirector:getChildByPath(self.Panel_root, "Image_vote")
    self.Panel_cards = {}
    for i=1,3 do
        local tab = {}
        tab.pl = TFDirector:getChildByPath(self.Panel_root, "Panel_card_"..i)
        tab.front = TFDirector:getChildByPath(tab.pl, "Button_front_card")
        tab.back = TFDirector:getChildByPath(tab.pl, "Image_back_card")
        tab.numTx = TFDirector:getChildByPath(tab.pl, "Label_num")
        tab.Image_icon = TFDirector:getChildByPath(tab.pl, "Image_icon")
        tab.select = TFDirector:getChildByPath(tab.pl, "Panel_select"):hide()
        tab.Spine_card = TFDirector:getChildByPath(tab.pl, "Spine_card"):hide()
        tab.chooseNum = i
        tab.openNum = i
        tab.id = i
        tab.isOpen = true
        tab.pos = tab.pl:getPosition()
        table.insert(self.Panel_cards,tab)
    end

    self.Label_endtime = TFDirector:getChildByPath(self.Panel_root, "Label_endtime"):hide()
    self.Button_down = TFDirector:getChildByPath(self.Panel_root, "Button_down"):hide()
    self.Button_up = TFDirector:getChildByPath(self.Panel_root, "Button_up"):hide()
    self.Label_vote_num = TFDirector:getChildByPath(self.Panel_root, "Label_vote_num")
    self.Label_vote_num:setSkewX(15)
    self.Label_odds_num = TFDirector:getChildByPath(self.Panel_root, "Label_odds_num")
    self.Label_odds_num:setSkewX(15)

    self.Up_icon = TFDirector:getChildByPath(self.Button_up, "Image_icon")
    self.Down_icon = TFDirector:getChildByPath(self.Button_down, "Image_icon")

    self.Image_voteIcon = TFDirector:getChildByPath(self.Panel_root, "Image_voteIcon")
    self.Image_voteIcon:setTexture("icon/role/activity/113.png")

    self.Label_vote = TFDirector:getChildByPath(self.Panel_root, "Label_vote")
    self.Label_vote:setTextById(13310225)

    self:initVotePanel()
    self:initCars()

    local chipNum = BingoDataMgr:getChipItemNum()
    self.Label_chip:setText(chipNum)
    local topRes = BingoDataMgr:getTopIcon(chipNum)
    self.Image_chip:setTexture(topRes)
end

function BingoDivinationView:initVotePanel()

    self.Label_vote_num:setText(self.voteNum)
    self.Label_odds_num:setText("赔率 x" ..self.oddsNum/10000)

    local chipItemId = BingoDataMgr:getChipItemId(EC_BingoGameType.Divination)
    local itemCfg = GoodsDataMgr:getItemCfg(chipItemId)
    self.Up_icon:setTexture(itemCfg.icon)
    self.Down_icon:setTexture(itemCfg.icon)
    local res = BingoDataMgr:getOddIcon(self.voteNum)
    self.Image_vote:setTexture(res)
end

function BingoDivinationView:initCars()
    local shuffleTab = Utils:shuffle({1,2,3,4,5,6})
    local randomId = math.random(1,2)
    local qizuiRes = self.cardImgRes[7][randomId]
    self.notLuckyNos = {}
    self.stage = Enum_gameStage.result
    self.shuffllId = 0
    local randomTab =  Utils:shuffle({1,2,3})
    for k,v in ipairs(randomTab) do
        local cards = self.Panel_cards[k]
        local cardCfg = BingoDataMgr:getBingoCardCfg(v)
        cards.chooseNum = cardCfg.id
        cards.numTx:setText(v)
        cards.openNum = v
        cards.back:hide()
        cards.isOpen = true
        if not cardCfg.isWin then
            table.insert(self.notLuckyNos,cardCfg.id)
        end
        if v == 1 then
            self.cardImg[v] = "icon/role/activity/"..qizuiRes
        else
            self.shuffllId = self.shuffllId + 1
            local id = shuffleTab[self.shuffllId]
            local randomId = math.random(1,#self.cardImgRes[id])
            self.cardImg[v] = "icon/role/activity/"..self.cardImgRes[id][randomId]
        end
        cards.Image_icon:setTexture(self.cardImg[v])
    end
end

--打乱数组
function BingoDivinationView:shuffle(t)
    if type(t)~="table" then
        return
    end
    math.randomseed(tostring(os.time()):reverse():sub(1, 6))
    local tab={}
    local index=1
    while #t~=0 do
        local n=math.random(0,#t)
        if t[n]~=nil then
            tab[index]=t[n]
            table.remove(t,n)
            index=index+1
        end
    end
    return tab
end

---洗牌
function BingoDivinationView:shuffleCards()

    self.Button_xipai:setVisible(false)
    self.Label_endtime:setVisible(true)
    self.tab = {1,2,3}
    self.tab = self:shuffle(self.tab)
    for k,v in ipairs(self.Panel_cards) do
        self:turnToBack(v)
    end
    self.stage = Enum_gameStage.guess
end

---开牌
function BingoDivinationView:openCards()

    if self.voteNum == 0 then
        Utils:showTips("请先投注")
        return
    end

    if not self.choosedCardIdx then
        return
    end

    local chooseCard = self.Panel_cards[self.choosedCardIdx]
    if not chooseCard then
        return
    end

end

function BingoDivinationView:resetInfo()
    self.luckyCardIdx = nil
    self.choosedCardIdx = nil
    self.voteNum = 0
    self.Label_vote_num:setString(0);
    local res = BingoDataMgr:getOddIcon(0)
    self.Image_vote:setTexture(res)
    self.Button_xipai:setVisible(true)
    self.Button_down:setVisible(false)
    self.Button_up:setVisible(false)
    self.Label_endtime:setVisible(false)

    self.Button_do:setTouchEnabled(true)
    self.Button_do:setGrayEnabled(false)

    self.Button_down:setTouchEnabled(true)
    self.Button_down:setGrayEnabled(false)
    self.Button_up:setTouchEnabled(true)
    self.Button_up:setGrayEnabled(false)

    for k,v in ipairs(self.Panel_cards) do
        if not v.isOpen then
            self:turnToFront(v)
        end
    end
    self.stage = Enum_gameStage.result

    local chipNum = BingoDataMgr:getChipItemNum()
    self.Label_chip:setText(chipNum)
    local topRes = BingoDataMgr:getTopIcon(chipNum)
    self.Image_chip:setTexture(topRes)

    self.animating = false
end

function BingoDivinationView:afterResultAnimation(isWin)

    local chooseCard = self.Panel_cards[self.choosedCardIdx]
    if not chooseCard then
        return
    end

    local luckyCard = self.Panel_cards[self.luckyCardIdx]
    if not luckyCard then
        return
    end
    chooseCard.select:setVisible(false)

    if not isWin then
        self:resetInfo()
        BingoDataMgr:playDatingCfg(EC_BingoGameType.Divination,EC_UnlockType.lose)
        return
    end

    local maxNum = BingoDataMgr:getChipItemNum()-self.tempNum
    local perNum = math.floor(math.sqrt(maxNum)/2)
    local jumpNum = self.voteNum
    local act = Sequence:create({
        CCCallFunc:create(function ()
            jumpNum = jumpNum + perNum
            if jumpNum >= maxNum then
                jumpNum = maxNum
            end
            self.Label_vote_num:setText(jumpNum)
            local res = BingoDataMgr:getOddIcon(jumpNum)
            self.Image_vote:setTexture(res)
            Utils:playSound(5014, false)
            if jumpNum >= maxNum then
                self.Label_vote_num:stopAllActions()
                self.voteNum = 0
                local chipNum = BingoDataMgr:getChipItemNum()
                local delNum = chipNum - self.tempNum
                local topPerNum = math.floor(math.sqrt(delNum)/2)
                local act2 = Sequence:create({
                    CCCallFunc:create(function ()
                        Utils:playSound(5014, false)
                        self.tempNum = self.tempNum + topPerNum
                        if self.tempNum >= chipNum then
                            self.Label_chip:stopAllActions()
                            self.Label_chip:setText(chipNum)
                            local topRes = BingoDataMgr:getTopIcon(chipNum)
                            self.Image_chip:setTexture(topRes)
                            self:resetInfo()
                            BingoDataMgr:playDatingCfg(EC_BingoGameType.Divination,EC_UnlockType.win)
                        else
                            self.Label_chip:setText(self.tempNum)
                            local topRes = BingoDataMgr:getTopIcon(self.tempNum)
                            self.Image_chip:setTexture(topRes)
                        end
                    end),
                    CCDelayTime:create(self.numberTurnTime)
                })
                self.Label_chip:runAction(CCRepeatForever:create(act2))
            end
        end),
        CCDelayTime:create(self.numberTurnTime)
    })
    self.Label_vote_num:runAction(CCRepeatForever:create(act))

end

function BingoDivinationView:guessResult(result)

    self.Button_do:setVisible(false)

    local luckyCard = self.Panel_cards[self.choosedCardIdx]
    local bingoCardCfg = BingoDataMgr:getBingoCardCfg(luckyCard.openNum)
    if not bingoCardCfg then
        return
    end

    local victoryAppear = bingoCardCfg.victoryAppear
    local randomIndx = math.random(1,#victoryAppear)
    local victoryAppearId = victoryAppear[randomIndx]

    local function callback()
       self:afterResultAnimation(result)
    end

    self:timeOut(function()
        BingoDataMgr:openResult(true,victoryAppearId,callback)
    end,0.2)

end

function BingoDivinationView:holdDownAction(isAddOp)
    self.speedTiming = 0
    self.timing = 0
    self.needTime = 0
    self.entryFalg = false
    self.isAddOp = isAddOp
    self.startUpdate = true
end

function BingoDivinationView:onTouchButtonDown()
    self:updateBatchPanel(-self.pernum)
end

function BingoDivinationView:onTouchButtonUp()
    self:updateBatchPanel(self.pernum)
end

function BingoDivinationView:updateBatchPanel(num)

    local preNum = self.voteNum + num
    preNum = preNum <= 0 and 0 or preNum
    if num > 0 and self.voteNum >= self.limit then
        Utils:showTips("已达到最大投注")
        self:stopTimer()
        return
    end

    local deltaChip = preNum
    local chipNum = BingoDataMgr:getChipNum()
    if chipNum == 0 or chipNum < deltaChip then
        Utils:showAccess(500066)
        self:stopTimer()
        return
    end

    self.voteNum = preNum
    self.Label_vote_num:setString(preNum);
    local w = self.Label_chip:getContentSize().width
    local x = self.Label_chip:getPositionX()
    self.Label_chip_delta:setPositionX(w+x+2)
    self.Label_chip_delta:setColor(me.RED)
    self.Label_chip_delta:setText("-"..deltaChip)
end

function BingoDivinationView:turnToFront(card,callback)

    local action = Sequence:create({
        RotateBy:create(0.4, 0, 180),
        CallFunc:create(function()
           self:turnToFront2(card,callback)
        end),
    })
    card.back:runAction(action)
end

function BingoDivinationView:turnToFront2(card,callback)

    local action = Sequence:create({
        CallFunc:create(function()
            card.front:show()
            card.back:hide()
            card.isOpen = true
            if callback then
                self:playSpine(card,callback)
                Utils:playSound(5012, false)
                self.playCnt = 0
            end
        end),
    })
    card.front:runAction(action)
end

function BingoDivinationView:playSpine(card,callback)

    card.Spine_card:play("xunhuan",false)
    card.Spine_card:setVisible(true)
    card.Spine_card:addMEListener(TFARMATURE_COMPLETE,function()
        self.playCnt = self.playCnt + 1
        if self.playCnt >= 4 then
            card.Spine_card:removeMEListener(TFARMATURE_COMPLETE)
            card.Spine_card:play("jeishu",false)
            card.Spine_card:setVisible(false)
            self.playCnt = 0
            if callback then
                callback()
            end
        else
            card.Spine_card:play("xunhuan",false)
        end
    end)
end

function BingoDivinationView:turnToBack(card)
    local action = Sequence:create({
        RotateBy:create(0.4, 0, 180),
        CallFunc:create(function()
            self:turnToBack2(card)
        end),
    })
    card.front:runAction(action)
end

function BingoDivinationView:turnToBack2(card)

    local action = Sequence:create({
        RotateTo:create(0, 0),
        CallFunc:create(function()
            card.front:hide()
            card.back:show()
            card.isOpen = false
            card.front:runAction(Sequence:create({
                RotateTo:create(0, 0),
                CallFunc:create(function()
                    self:turnToBack3(card)
                end)
            }))
        end),
    })
    card.back:runAction(action)
end

function BingoDivinationView:turnToBack3(card)
    local action = Sequence:create({
        EaseSineOut:create(MoveTo:create(0.4, ccp(0, 0))),
        CallFunc:create(function()
            card.numTx:setText(self.tab[card.id])
            card.chooseNum = self.tab[card.id]
            card.openNum = self.tab[card.id]
            card.pl:runAction(EaseSineOut:create(MoveTo:create(0.4, card.pos)))
        end)
    })
    card.pl:runAction(action)
end

function BingoDivinationView:chooseCard(cardIdx)

    local card = self.Panel_cards[cardIdx]
    if not card then
        return
    end

    if cardIdx == self.choosedCardIdx then
        return
    end

    Utils:playSound(5013, false)

    if self.choosedCardIdx then
        self.Panel_cards[self.choosedCardIdx].select:setVisible(false)
    end

    self.choosedCardIdx = cardIdx
    card.select:setVisible(true)

end

function BingoDivinationView:onRecvCardResult(result)

    local chooseCard = self.Panel_cards[self.choosedCardIdx]
    if not chooseCard then
        return
    end


    self.notLuckyNos = self:shuffle(self.notLuckyNos)
    local unLuckyNoId = 1
    self.luckyCardIdx = self.choosedCardIdx
    if not result then
        if self.victory == chooseCard.chooseNum then
            for k,v in ipairs(self.Panel_cards) do
                if k ~= self.choosedCardIdx then
                    self.luckyCardIdx = k
                    break
                end
            end
        else
            for k,v in ipairs(self.Panel_cards) do
                if v.chooseNum == self.victory then
                    self.luckyCardIdx = k
                    break
                end
            end
        end
    end

    for k,v in ipairs(self.Panel_cards) do
        if k ~= self.luckyCardIdx then
            local no = self.notLuckyNos[unLuckyNoId]
            if no then
                v.numTx:setText(no)
                v.openNum = no
                v.Image_icon:setTexture(self.cardImg[no])
                unLuckyNoId = unLuckyNoId + 1
            end
        else
            v.numTx:setText(self.victory)
            v.openNum = self.victory
            v.Image_icon:setTexture(self.cardImg[self.victory])
        end
    end
    self.Label_chip_delta:setText("")
    self:turnToFront(chooseCard,function()
        self:guessResult(result)
    end)
end

function BingoDivinationView:onRecvBingoResult()

    local rewards = BingoDataMgr:getOpenRewards()
    local isWin = #rewards > 0
    self:onRecvCardResult(isWin)

    self.Button_do:setTouchEnabled(false)
    self.Button_do:setGrayEnabled(true)

    self.Button_down:setTouchEnabled(false)
    self.Button_down:setGrayEnabled(true)
    self.Button_up:setTouchEnabled(false)
    self.Button_up:setGrayEnabled(true)


end

function BingoDivinationView:updateItem()

    if not self.animating then
        local chipNum = BingoDataMgr:getChipItemNum()
        self.Label_chip:setText(chipNum)
        local topRes = BingoDataMgr:getTopIcon(chipNum)
        self.Image_chip:setTexture(topRes)
    end
end

function BingoDivinationView:stopTimer()
    self.startUpdate = false
end

function BingoDivinationView:removeEvents()
    self:removeMEListener(TFWIDGET_ENTERFRAME)
end

function BingoDivinationView:update(target , dt)
    if self.startUpdate ~= true then
        return
    end
    self.timing = self.timing + dt
    self.speedTiming = self.speedTiming + dt
    if self.speedTiming >= 3.0 then
        self.entryFalg = true
        self.needTime = 0.01
    elseif self.speedTiming > 0.5 then
        self.entryFalg = true
        self.needTime = 0.05
    end
    if self.onTouchButtonUp and self.onTouchButtonDown then
        if self.entryFalg and self.timing >= self.needTime then
            if self.isAddOp then
                self:onTouchButtonUp()
            else
                self:onTouchButtonDown()
            end
            self.timing = 0
        end
    end
end

function BingoDivinationView:registerEvents()

    EventMgr:addEventListener(self,EV_BAG_ITEM_UPDATE,handler(self.updateItem, self))
    EventMgr:addEventListener(self,EV_BINGOGAME_RESULT,handler(self.onRecvBingoResult, self));

    self.Button_back:onClick(function()
        BingoDataMgr:checkResultViewState()
        AlertManager:closeLayer(self)
    end)

    self.Button_do:onClick(function()
        if self.voteNum == 0 then
            Utils:showTips("请先下注")
            return
        end
        local param = {}
        table.insert(param,self.voteNum)
        local chipNum = BingoDataMgr:getChipItemNum()
        self.tempNum = chipNum-self.voteNum
        self.Label_chip:setText(self.tempNum)
        local topRes = BingoDataMgr:getTopIcon(self.tempNum)
        self.Image_chip:setTexture(topRes)
        self.animating = true
        BingoDataMgr:Send_openBingoGame(EC_BingoGameType.Divination,param)
    end)

    self.Button_down:onTouch(function(event)
        if event.name == "ended" then
            self:stopTimer()
        end
        if event.name == "began" then
            TFAudio.playSound(Utils:getKVP(1001,"ui_clickSound"))
            self:onTouchButtonDown()
            self:holdDownAction(false);
        end
    end)

    self.Button_up:onTouch(function(event)
        if event.name == "ended" then
            self:stopTimer()
        end
        if event.name == "began" then
            TFAudio.playSound(Utils:getKVP(1001,"ui_clickSound"))
            self:onTouchButtonUp()
            self:holdDownAction(true);
        end
    end)

    self.Button_xipai:onClick(function()

        local chipNum = BingoDataMgr:getChipNum()
        if chipNum == 0 then
            Utils:showTips("筹码不够")
            return
        end
        Utils:playSound(5011, false)
        self.Panel_result:setVisible(false)
        self:shuffleCards()
    end)

    for k,v in ipairs(self.Panel_cards) do
        v.pl:onClick(function ()
            if  self.stage == Enum_gameStage.result then
                return
            end
            self.Button_do:setVisible(true)
            self.Button_down:setVisible(true)
            self.Button_up:setVisible(true)
            self.Label_endtime:setVisible(false)
            self:chooseCard(v.id)
        end)
    end

    self.Button_add_chip:onClick(function()
        FunctionDataMgr:jStore(306000)
    end)

    self:addMEListener(TFWIDGET_ENTERFRAME,handler(self.update,self))
end

return BingoDivinationView
