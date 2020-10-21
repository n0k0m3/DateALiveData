
local BingoDiceView = class("BingoDiceView", BaseLayer)

local DiceState = {
    IDLE = "i",
    TURN = "z",
}

function BingoDiceView:initData()
    self.diceData_ = DfwDataMgr:getChessesDice()
    self.diceItems_ = {}
    self.recordVoteNum = {}
    self.diceNum_ = {}
    self.imgeRes = {"002.png","003.png","001.png"}

    self.diceAct = {}
    self.diceAct[1] = {idel = "meijiu_1",turn = "meijiu_3"}
    self.diceAct[2] = {idel = "qinli_1",turn = "qinli_3"}

    self.pernum = 10
    self.numberTurnTime = 0.05
    self.startUpdate = false
    local cfg = BingoDataMgr:getMiniGameCfg(EC_BingoGameType.Dice)
    self.limit = cfg.limit
    BingoDataMgr:playCg(cfg.enterDating)
end

function BingoDiceView:onShow()
    self.super.onShow(self)
    AudioExchangePlay.playBGM(self, true,"sound/bgm/kanban/main_qizui_11308.mp3")
end

function BingoDiceView:ctor(...)
    self.super.ctor(self)
    --self:showPopAnim(true)
    self:initData(...)
    self:init("lua.uiconfig.bingo.bingoDiceView")
end

function BingoDiceView:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    local ScrollView_dice = TFDirector:getChildByPath(self.Panel_root, "ScrollView_dice")
    self.ListView_dice = UIListView:create(ScrollView_dice)
    self.ListView_dice:setItemsMargin(40)
    self.Button_back = TFDirector:getChildByPath(self.Panel_root, "Button_back")
    self.Button_do = TFDirector:getChildByPath(self.Panel_root, "Button_do")

    self.Label_vote = TFDirector:getChildByPath(self.Panel_root, "Label_vote")
    self.Label_vote:setTextById(13310226)

    self.Button_down = TFDirector:getChildByPath(self.Panel_root, "Button_down")
    self.Button_up = TFDirector:getChildByPath(self.Panel_root, "Button_up")
    self.Up_icon = TFDirector:getChildByPath(self.Button_up, "Image_icon")
    self.Down_icon = TFDirector:getChildByPath(self.Button_down, "Image_icon")

    self.VotePanelTab = {}
    for i = EC_DiceVoteType.Big, EC_DiceVoteType.Baozi do
        local tab = {}
        local Panel_vote = TFDirector:getChildByPath(self.Panel_root, "Panel_vote_"..i)
        tab.Panel_vote = Panel_vote
        tab.Button_down = TFDirector:getChildByPath(Panel_vote, "Button_down")
        tab.Button_up = TFDirector:getChildByPath(Panel_vote, "Button_up")
        tab.Label_odds_num = TFDirector:getChildByPath(Panel_vote, "Label_odds_num")
        tab.Label_odds_num:setSkewX(15)
        tab.Label_num = TFDirector:getChildByPath(Panel_vote, "Label_num")
        tab.Label_num:setSkewX(15)
        tab.Image_vote = TFDirector:getChildByPath(Panel_vote, "Image_vote")
        tab.Image_vote:setTexture("ui/activity/bingoGame/dice/"..self.imgeRes[i])
        tab.Image_select = TFDirector:getChildByPath(Panel_vote, "Image_select"):hide()
        tab.Image_voteIcon = TFDirector:getChildByPath(Panel_vote, "Image_voteIcon")
        tab.odds = 0
        tab.jumpNum = 0
        table.insert(self.VotePanelTab,tab)
    end

    self.Label_chip = TFDirector:getChildByPath(self.Panel_root, "Label_chip")
    self.Image_chip = TFDirector:getChildByPath(self.Panel_root, "Image_chip")
    self.Button_add_chip = TFDirector:getChildByPath(self.Panel_root, "Button_add_chip")
    self.Label_chip_delta = TFDirector:getChildByPath(self.Panel_root, "Label_chip_delta")

    local Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
    self.Panel_diceItem = TFDirector:getChildByPath(Panel_prefab, "Panel_diceItem")

    self:initVotePanel()
    self:initDice()
    self:chooseVoteType(EC_DiceVoteType.Big)
    local chipNum = BingoDataMgr:getChipItemNum()
    self.Label_chip:setText(chipNum)
    local topRes = BingoDataMgr:getTopIcon(chipNum)
    self.Image_chip:setTexture(topRes)
end

function BingoDiceView:initVotePanel()

    local chipItemId = BingoDataMgr:getChipItemId(EC_BingoGameType.Dice)
    local itemCfg = GoodsDataMgr:getItemCfg(chipItemId)
    for k,v in ipairs(self.VotePanelTab) do
        local odds = BingoDataMgr:getDiceOddsByType(k)
        v.Label_odds_num:setText(TextDataMgr:getText(13310230 , odds/10000))
        v.Label_num:setText(0)
        local oddRes = BingoDataMgr:getOddIcon(0)
        v.Image_voteIcon:setTexture(oddRes)
        v.odds = odds
        v.jumpNum = 0
        self.recordVoteNum[k] = 0
    end
    self.Up_icon:setTexture(itemCfg.icon)
    self.Down_icon:setTexture(itemCfg.icon)
end

function BingoDiceView:initDice()
    for i, v in ipairs(self.diceData_) do
        if i <= 3 then
            local foo = self:addDiceItem(i)
            local name = self:getDiceAnimation(v, 1, "idel")
            foo.Spine_dice:play(name)
        end
    end
    Utils:setAliginCenterByListView(self.ListView_dice, true)
end

function BingoDiceView:getDiceAnimation(diceCid, point, state)

    if not self.diceAct[point] then
        return "meijiu_1"
    end
    return self.diceAct[point][state]

end

function BingoDiceView:addDiceItem(index)
    local Panel_diceItem = self.Panel_diceItem:clone()
    local foo = {}
    foo.root = Panel_diceItem
    local resPath = "evt_effect_dice"
    foo.Spine_dice = SkeletonAnimation:create(string.format("effect/%s/%s", resPath, resPath))
    foo.root:addChild(foo.Spine_dice)
    foo.Spine_dice:setPosition(ccp(0, -6))
    foo.Label_count = TFDirector:getChildByPath(foo.root, "Label_count")
    self.ListView_dice:pushBackCustomItem(foo.root)
    self.diceItems_[index] = foo
    return foo
end

function BingoDiceView:holdDownAction(isAddOp,btnIdex)
    self.speedTiming = 0
    self.timing = 0
    self.needTime = 0
    self.entryFalg = false
    self.isAddOp = isAddOp
    self.startUpdate = true
end

function BingoDiceView:onTouchButtonDown()

    if not self.diceType then
        Utils:showTips("请选择")
        return
    end
    self:updateBatchPanel(-self.pernum)
end

function BingoDiceView:onTouchButtonUp()
    if not self.diceType then
        Utils:showTips("请选择")
        return
    end
    self:updateBatchPanel(self.pernum)
end

function BingoDiceView:updateBatchPanel(num)

    if not self.VotePanelTab[self.diceType] then
        return
    end

    if not self.recordVoteNum[self.diceType] then
        return
    end

    if num > 0 and self.recordVoteNum[self.diceType] >= self.limit then
        Utils:showTips(111000065)
        self:stopTimer()
        return
    end

    local preNum = self.recordVoteNum[self.diceType] + num
    local chipNum = BingoDataMgr:getChipNum()
    local otherVoteNum = 0
    for k,v in pairs(self.recordVoteNum) do
        otherVoteNum = otherVoteNum + v
    end

    if chipNum < otherVoteNum + num then
        Utils:showAccess(500066)
        self:stopTimer()
        return
    end

    if preNum < 0 then
        return
    end

    if preNum > self.limit then
        return
    end

    self.Label_chip_delta:setVisible(otherVoteNum + num > 0)
    self.Label_chip_delta:setText("-"..(otherVoteNum + num))
    self.Label_chip_delta:setColor(me.RED)
    local w = self.Label_chip:getContentSize().width
    local posX = self.Label_chip:getPositionX();
    self.Label_chip_delta:setPositionX(posX+w+2)

    self.recordVoteNum[self.diceType] = preNum
    self.VotePanelTab[self.diceType].Label_num:setString(preNum);
    self.VotePanelTab[self.diceType].jumpNum = preNum
end

function BingoDiceView:chooseVoteType(diceType)

    if diceType == EC_DiceVoteType.Big then
        if self.recordVoteNum[EC_DiceVoteType.Small] ~= 0 then
            Utils:showTips(13310227)
            return
        end
    elseif diceType == EC_DiceVoteType.Small then
        if self.recordVoteNum[EC_DiceVoteType.Big] ~= 0 then
            Utils:showTips(13310227)
            return
        end
    end

    self.diceType = diceType
    self.VotePanelTab[self.diceType].Image_select:setVisible(true)
end

function BingoDiceView:onRecvDiceResult(luckyCid)
    local diceCfg = BingoDataMgr:getDiceCfg(luckyCid)
    if not diceCfg then
        return
    end

    local victoryAppear = diceCfg.victoryAppear
    local randomIndx = math.random(1,#victoryAppear)
    local victoryAppearId = victoryAppear[randomIndx]
    for i=1,3 do
        self.diceNum_[i] = diceCfg["dice"..i.."Type"]
    end
    self:turnDiceItem(victoryAppearId)
end


function BingoDiceView:turnDiceItem(victoryAppearId)

    local function callback()
        self:stopAnimate()
    end
    for k,v in ipairs(self.diceItems_) do
        local diceCid = self.diceData_[k]
        local diceNum = self.diceNum_[k]
        if diceCid and diceNum then
            local name = self:getDiceAnimation(diceCid, diceNum, "turn")
            v.Spine_dice:play(name,false)
            v.Spine_dice:addMEListener(TFARMATURE_COMPLETE,function()
                v.Spine_dice:removeMEListener(TFARMATURE_COMPLETE)
                if k == 3 then

                    self:timeOut(function()
                        victoryAppearId = victoryAppearId == 1054 and 1055 or victoryAppearId
                        BingoDataMgr:openResult(true,victoryAppearId,callback)
                    end,0.2)
                end
            end)
        end
    end
end

function BingoDiceView:stopAnimate()

    local isWin = false
    local rewards = BingoDataMgr:getOpenRewards()
    if next(rewards) then
        isWin = true
    end

    if not isWin then
        self:initVotePanel()
        local chipNum = BingoDataMgr:getChipItemNum()
        self.Label_chip:setText(chipNum)
        local topRes = BingoDataMgr:getTopIcon(chipNum)
        self.Image_chip:setTexture(topRes)
        BingoDataMgr:playDatingCfg(EC_BingoGameType.Dice,EC_UnlockType.lose)
        self.Button_do:setTouchEnabled(true)
        self.Button_do:setGrayEnabled(false)

        self.Button_down:setTouchEnabled(true)
        self.Button_down:setGrayEnabled(false)
        self.Button_up:setTouchEnabled(true)
        self.Button_up:setGrayEnabled(false)
        self.animating = false
        return
    end

    local winType = BingoDataMgr:getWinType()

    for k,v in ipairs(self.VotePanelTab) do
        local isWinType = false
        for i,type in ipairs(winType) do
            if k == type then
                isWinType = true
                break
            end
        end
        if not isWinType then
            v.Label_num:setText(0)
            local oddRes = BingoDataMgr:getOddIcon(0)
            v.Image_voteIcon:setTexture(oddRes)
            self.recordVoteNum[k] = 0
        end
    end

    local winType = BingoDataMgr:getWinType()
    for i,type in ipairs(winType) do
        if self.recordVoteNum[type] ~= 0 then
            self:runWinNumber(i,type)
        end
    end

end

function BingoDiceView:runWinNumber(i,type)

    local rewards = BingoDataMgr:getOpenRewards()
    local luckyPanel = self.VotePanelTab[type]
    local maxNum = rewards[i].num
    local perNum = math.floor(math.sqrt(maxNum)/2)
    local act = Sequence:create({
        CCCallFunc:create(function ()
            Utils:playSound(5014, false)
            luckyPanel.jumpNum = luckyPanel.jumpNum + perNum
            if luckyPanel.jumpNum >= maxNum then
                luckyPanel.jumpNum = maxNum
            end
            luckyPanel.Label_num:setText(luckyPanel.jumpNum)
            local oddRes = BingoDataMgr:getOddIcon(luckyPanel.jumpNum)
            luckyPanel.Image_voteIcon:setTexture(oddRes)
            if luckyPanel.jumpNum >= maxNum then
                luckyPanel.Label_num:stopAllActions()
                self.recordVoteNum[type] = 0
                luckyPanel.jumpNum = 0
                local chipNum = BingoDataMgr:getChipItemNum()
                local topPerNum = math.floor(math.sqrt(chipNum - self.tempNum)/2)
                if self.tempNum < chipNum then
                    local act2 = Sequence:create({
                        CCCallFunc:create(function ()
                            Utils:playSound(5014, false)
                            self.tempNum = self.tempNum + topPerNum
                            if self.tempNum >= chipNum then
                                self.Label_chip:stopAllActions()
                                self.Button_do:setTouchEnabled(true)
                                self.Button_do:setGrayEnabled(false)
                                self.Button_down:setTouchEnabled(true)
                                self.Button_down:setGrayEnabled(false)
                                self.Button_up:setTouchEnabled(true)
                                self.Button_up:setGrayEnabled(false)
                                for k,v in ipairs(self.VotePanelTab) do
                                    v.Label_num:setText(0)
                                    local oddRes = BingoDataMgr:getOddIcon(0)
                                    v.Image_voteIcon:setTexture(oddRes)
                                end
                                self.animating = false
                                BingoDataMgr:playDatingCfg(EC_BingoGameType.Dice,EC_UnlockType.win)
                                self.Label_chip:setText(chipNum)
                                local topRes = BingoDataMgr:getTopIcon(chipNum)
                                self.Image_chip:setTexture(topRes)
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
            end
        end),
        CCDelayTime:create(self.numberTurnTime)
    })
    luckyPanel.Label_num:runAction(CCRepeatForever:create(act))

end

function BingoDiceView:onRecvBingoResult()

    self.Button_do:setTouchEnabled(false)
    self.Button_do:setGrayEnabled(true)

    self.Button_down:setTouchEnabled(false)
    self.Button_down:setGrayEnabled(true)
    self.Button_up:setTouchEnabled(false)
    self.Button_up:setGrayEnabled(true)

    local resultFormation = BingoDataMgr:getOpenInfomation()
    local luckyCid =  resultFormation[1]
    self:onRecvDiceResult(luckyCid)
end

function BingoDiceView:updateItem()

    if not self.animating then
        local chipNum = BingoDataMgr:getChipItemNum()
        self.Label_chip:setText(chipNum)
        local topRes = BingoDataMgr:getTopIcon(chipNum)
        self.Image_chip:setTexture(topRes)
    end
end

function BingoDiceView:stopTimer()
    self.startUpdate = false
end

function BingoDiceView:update(target , dt)
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

function BingoDiceView:removeEvents()
    self:removeMEListener(TFWIDGET_ENTERFRAME)
end

function BingoDiceView:registerEvents()

    EventMgr:addEventListener(self,EV_BAG_ITEM_UPDATE,handler(self.updateItem, self))
    EventMgr:addEventListener(self,EV_BINGOGAME_RESULT,handler(self.onRecvBingoResult, self));

    self.Button_back:onClick(function()
        BingoDataMgr:checkResultViewState()
        AlertManager:closeLayer(self)
    end)

    self.Button_do:onClick(function()
        local exitVote = false
        for k,v in ipairs(self.recordVoteNum) do
            if v ~= 0 then
                exitVote = true
                break
            end
        end
        if not exitVote then
            Utils:showTips(111000066)
            return
        end

        local cnt = 0
        local param = {}
        for k,v in ipairs(self.recordVoteNum) do
            if v ~= 0 then
                table.insert(param,k)
                table.insert(param,v)
                cnt = cnt + v
            end
        end

        self.Label_chip_delta:setVisible(false)
        local chipNum = BingoDataMgr:getChipItemNum()
        self.tempNum = chipNum-cnt
        self.Label_chip:setText(self.tempNum)
        local topRes = BingoDataMgr:getTopIcon(self.tempNum)
        self.Image_chip:setTexture(topRes)
        Utils:playSound(5015, false)
        self.animating = true
        BingoDataMgr:Send_openBingoGame(EC_BingoGameType.Dice,param)
    end)

    for k,v in ipairs(self.VotePanelTab) do
        v.Panel_vote:onClick(function()
            if self.diceType == k then
                return
            end

            if self.VotePanelTab[self.diceType] then
                self.VotePanelTab[self.diceType].Image_select:setVisible(false)
            end

            self:chooseVoteType(k)
        end)
    end

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

    self.Button_add_chip:onClick(function()
        FunctionDataMgr:jStore(306000)
    end)
    self:addMEListener(TFWIDGET_ENTERFRAME,handler(self.update,self))
end

return BingoDiceView
