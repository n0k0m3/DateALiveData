
local BingoTurnPlateView = class("BingoTurnPlateView", BaseLayer)

function BingoTurnPlateView:initData()
    self.voteNum_ = {}
    self.beginId = 1
    self.maxGidId = 20
    self.pernum = 10
    self.numberTurnTime = 0.05
    self.startUpdate = false
    local cfg = BingoDataMgr:getMiniGameCfg(EC_BingoGameType.Turnplate)
    self.limit = cfg.limit

    self.scale = {0.6,0.6,0.8,0.8,1}

    BingoDataMgr:playCg(cfg.enterDating)
end

function BingoTurnPlateView:onShow()
    self.super.onShow(self)
    AudioExchangePlay.playBGM(self, true,"sound/bgm/kanban/main_qizui_11308.mp3")
end

function BingoTurnPlateView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.bingo.bingoTurnPlateView")
end

function BingoTurnPlateView:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.itemList = {}
    for i=1,self.maxGidId do
        local tab = {}
        tab.bg = TFDirector:getChildByPath(self.Panel_root, "Image_turn_"..i)
        tab.icon = TFDirector:getChildByPath(tab.bg, "Image_icon")
        tab.Image_wei1 = TFDirector:getChildByPath(tab.bg, "Image_wei1")
        tab.Image_wei2 = TFDirector:getChildByPath(tab.bg, "Image_wei2")
        tab.Image_select = TFDirector:getChildByPath(tab.bg, "Image_select")
        tab.Image_up = TFDirector:getChildByPath(tab.bg, "Image_up")
        tab.pos = tab.bg:getPosition()
        table.insert(self.itemList,tab)
    end
    self.itemSeletImg = TFDirector:getChildByPath(self.Panel_root, "Image_item_select"):hide()

    self.voteTab = {}
    for i=1,5 do
        local tab = {}
        tab.bg = TFDirector:getChildByPath(self.Panel_root, "Panel_vote_"..i)
        tab.Label_num = TFDirector:getChildByPath(tab.bg, "Label_num")
        tab.Label_num:setSkewX(15)
        tab.Label_odds_num = TFDirector:getChildByPath(tab.bg, "Label_odds_num")
        tab.Label_odds_num:setSkewX(15)
        tab.Image_vote = TFDirector:getChildByPath(tab.bg, "Image_vote")
        tab.Image_icon = TFDirector:getChildByPath(tab.bg, "Image_icon")
        tab.Image_select = TFDirector:getChildByPath(tab.bg, "Image_select"):hide()
        tab.odds = 0
        tab.jumpNum = 0
        tab.pos = tab.bg:getPosition()
        table.insert(self.voteTab,tab)
    end

    self.Label_chip = TFDirector:getChildByPath(self.Panel_root, "Label_chip")
    self.Image_chip = TFDirector:getChildByPath(self.Panel_root, "Image_chip")
    self.Label_chip_delta = TFDirector:getChildByPath(self.Panel_root, "Label_chip_delta")

    self.Label_vote = TFDirector:getChildByPath(self.Panel_root, "Label_vote")
    self.Label_vote:setTextById(13310224)

    self.Button_up = TFDirector:getChildByPath(self.Panel_root, "Button_up")
    self.Up_icon = TFDirector:getChildByPath(self.Button_up, "Image_icon")
    self.Button_down = TFDirector:getChildByPath(self.Panel_root, "Button_down")
    self.Down_icon = TFDirector:getChildByPath(self.Button_down, "Image_icon")
    self.Button_do = TFDirector:getChildByPath(self.Panel_root, "Button_do")
    self.Button_back = TFDirector:getChildByPath(self.Panel_root, "Button_back")
    self.Button_add_chip = TFDirector:getChildByPath(self.Panel_root, "Button_add_chip")

    self:initVoteItem()
    self:initWheelItem()
    self:selectVoteItem(3)

    local chipNum = BingoDataMgr:getChipItemNum()
    self.Label_chip:setText(chipNum)
    local topRes = BingoDataMgr:getTopIcon(chipNum)
    self.Image_chip:setTexture(topRes)
end

function BingoTurnPlateView:initVoteItem()

    local chipItemId = BingoDataMgr:getChipItemId(EC_BingoGameType.Turnplate)
    local itemCfg = GoodsDataMgr:getItemCfg(chipItemId)
    if not itemCfg then
        return
    end
    for k,v in ipairs(self.voteTab) do
        local info = BingoDataMgr:getWheelGroupInfo(k)
        if info then
            v.Label_num:setText(0)
            self.voteNum_[k] = 0
            local odds = info.odds/10000
            v.Label_odds_num:setText("赔率 x"..odds)
            v.Image_vote:setTexture(info.portrait)
            v.Image_vote:setScale(self.scale[k])
            v.Image_icon:setScale(0.5)
            local res = BingoDataMgr:getOddIcon(0)
            v.Image_icon:setTexture(res)
            v.odds = info.odds
            local w = v.Label_num:getContentSize().width
            local x = v.Label_num:getPositionX()
            v.Image_icon:setPositionX(x-w/2)
        end
    end
    self.Image_chip:setTexture(itemCfg.icon)
    self.Up_icon:setTexture(itemCfg.icon)
    self.Down_icon:setTexture(itemCfg.icon)

end

function BingoTurnPlateView:initWheelItem()

    for k,v in ipairs(self.itemList) do
        local cfg = BingoDataMgr:getBingoWheelCfg(k)
        if cfg then
            v.icon:setScale(0.8)
            v.icon:setTexture(cfg.icon)

            v.icon:setOpacity(255*0.3)
            v.Image_wei1:setOpacity(0)
            v.Image_wei2:setOpacity(0)
            v.Image_select:setOpacity(255)
            v.Image_select:hide()
            v.Image_up:hide()
        end
    end

end


function BingoTurnPlateView:selectVoteItem(id)

    if self.lastSelectId then
        self.voteTab[self.lastSelectId].Image_select:setVisible(false)
    end

    local selectVoteItem = self.voteTab[id]
    if not selectVoteItem then
        return
    end

    selectVoteItem.Image_select:setVisible(true)
    self.lastSelectId = id

end

function BingoTurnPlateView:holdDownAction(isAddOp)

    self.speedTiming = 0
    self.timing = 0
    self.needTime = 0
    self.entryFalg = false
    self.isAddOp = isAddOp
    self.startUpdate = true

end

function BingoTurnPlateView:onTouchButtonDown()
    self:updateBatchPanel(-self.pernum)
end

function BingoTurnPlateView:onTouchButtonUp()
    self:updateBatchPanel(self.pernum)
end

function BingoTurnPlateView:removeEvents()
    self:removeMEListener(TFWIDGET_ENTERFRAME)
end

function BingoTurnPlateView:updateBatchPanel(num)

    if not self.voteNum_[self.lastSelectId] or not self.voteTab[self.lastSelectId] then
        return
    end

    if num > 0 and self.voteNum_[self.lastSelectId] >= self.limit then
        Utils:showTips("已达到最大投注")
        self:stopTimer()
        return
    end

    local preNum = self.voteNum_[self.lastSelectId] + num
    local otherVoteNum = 0
    for k,v in pairs(self.voteNum_) do
        otherVoteNum = otherVoteNum + v
    end

    local ownChipNum = BingoDataMgr:getChipNum()
    if ownChipNum < otherVoteNum + num then
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

    self.voteNum_[self.lastSelectId] = preNum
    self.voteTab[self.lastSelectId].Label_num:setString(preNum);
    local w = self.voteTab[self.lastSelectId].Label_num:getContentSize().width
    local x = self.voteTab[self.lastSelectId].Label_num:getPositionX()
    self.voteTab[self.lastSelectId].Image_icon:setPositionX(x-w/2)
    self.voteTab[self.lastSelectId].jumpNum = preNum
end

function BingoTurnPlateView:startTurn(stopId)

    self.Button_do:setTouchEnabled(false)
    self.Button_do:setGrayEnabled(true)

    self.Button_down:setTouchEnabled(false)
    self.Button_down:setGrayEnabled(true)
    self.Button_up:setTouchEnabled(false)
    self.Button_up:setGrayEnabled(true)

    local lastStopItemGid = self.itemList[self.beginId]
    if lastStopItemGid then
        lastStopItemGid.Image_select:setVisible(false)
        lastStopItemGid.icon:setOpacity(255*0.3)
    end

    if self.beginId >= 20 then
        self.beginId = 0
    end

    self.randomId = stopId
    self.randomId = self.randomId + 20 * 3
    self.realId = self.beginId
    self.turnNo = 1
    self.step = 0
    self.beginDownSpeed = self.randomId - 10
    self:moveToNext(self.beginId + 1)
end

function BingoTurnPlateView:moveToNext(nextId)

    local itemGid = self.itemList[nextId]
    if not itemGid then
        return
    end

    Utils:playSound(5018, false)

    itemGid.Image_select:setVisible(true)
    itemGid.icon:setOpacity(255)

    self.realId = self.realId + 1
    self.step = self.step + 1
    if nextId == self.beginId then
        self.turnNo = self.turnNo + 1
    end

    local t = 0.05
    if self.step <= 20 then
        t = 0.1 - self.step*0.05/20
    elseif self.step >= self.beginDownSpeed then
        local index = self.step - self.beginDownSpeed
        t = 0.05 + index*0.05
    end

    itemGid.Image_wei1:setOpacity(255)
    itemGid.Image_wei1:runAction(CCFadeOut:create(0.4))
    itemGid.Image_wei2:setOpacity(255)
    itemGid.Image_wei2:runAction(CCFadeOut:create(0.5))

    local pos = itemGid.pos
    local act = Sequence:create({
        EaseSineOut:create(MoveTo:create(t, pos)),
        CallFunc:create(function()
            if self.realId == self.randomId then
                self:animateStop(nextId)
                return
            end
            itemGid.icon:setOpacity(255*0.3)
            itemGid.Image_select:setVisible(false)
            nextId = nextId + 1
            if nextId > self.maxGidId then
                nextId = nextId % self.maxGidId
            end
            self:moveToNext(nextId)
        end)
    })
    self.itemSeletImg:runAction(act)
end

function BingoTurnPlateView:animateStop(nextId)

    self.itemSeletImg:stopAllActions()
    self.beginId = nextId
    local wheelCfg = BingoDataMgr:getBingoWheelCfg(nextId)
    if not wheelCfg then
        return
    end
    local victoryAppear = wheelCfg.victoryAppear
    local randomIndx = math.random(1,#victoryAppear)

    local victoryAppearId = victoryAppear[randomIndx]
    local function callback()
        self:playResultAnimate(wheelCfg.group)
    end

    local isPositive = true
    if nextId >= 5 and nextId <= 14 then
        isPositive = false
    end

    self:timeOut(function ()
        BingoDataMgr:openResult(true,victoryAppearId,callback)
    end,0.2)
end

function BingoTurnPlateView:playResultAnimate(groupId)

    local isWin = false
    local rewards = BingoDataMgr:getOpenRewards()
    if next(rewards) then
        isWin = true
    end

    for k,v in ipairs(self.voteTab) do
        if groupId ~= k then
            v.Label_num:setText(0)
            self.voteNum_[k] = 0
        end
    end

    if not isWin then
        self.Button_do:setTouchEnabled(true)
        self.Button_do:setGrayEnabled(false)
        self.voteTab[groupId].Label_num:setText(0)
        self.voteNum_[groupId] = 0
        local chipNum = BingoDataMgr:getChipItemNum()
        self.Label_chip:setText(chipNum)
        local topRes = BingoDataMgr:getTopIcon(chipNum)
        self.Image_chip:setTexture(topRes)
        BingoDataMgr:playDatingCfg(EC_BingoGameType.Turnplate,EC_UnlockType.lose)

        self.Button_down:setTouchEnabled(true)
        self.Button_down:setGrayEnabled(false)
        self.Button_up:setTouchEnabled(true)
        self.Button_up:setGrayEnabled(false)
        self.animating = false
        return
    end


    local luckyGroup = self.voteTab[groupId]
    local maxNum = BingoDataMgr:getChipItemNum()-self.tempNum
    local perNum = math.floor(math.sqrt(maxNum)/2)
    local act = Sequence:create({
        CCCallFunc:create(function ()
            Utils:playSound(5014, false)
            luckyGroup.jumpNum = luckyGroup.jumpNum + perNum
            if luckyGroup.jumpNum >= maxNum then
                luckyGroup.jumpNum = maxNum
            end
            luckyGroup.Label_num:setText(luckyGroup.jumpNum)
            local res = BingoDataMgr:getOddIcon(luckyGroup.jumpNum)
            luckyGroup.Image_icon:setTexture(res)
            if luckyGroup.jumpNum >= maxNum then
                luckyGroup.Label_num:stopAllActions()
                self.voteNum_[groupId] = 0
                luckyGroup.jumpNum = 0
                local chipNum = BingoDataMgr:getChipItemNum()
                local topPerNum = math.floor(math.sqrt(chipNum-self.tempNum)/2)
                local act2 = Sequence:create({
                    CCCallFunc:create(function ()
                        Utils:playSound(5014, false)
                        self.tempNum = self.tempNum + topPerNum
                        if self.tempNum >= chipNum then
                            self.Label_chip:stopAllActions()
                            self.Button_do:setTouchEnabled(true)
                            self.Button_do:setGrayEnabled(false)
                            luckyGroup.Label_num:setText(0)
                            local res = BingoDataMgr:getOddIcon(0)
                            luckyGroup.Image_icon:setTexture(res)
                            BingoDataMgr:playDatingCfg(EC_BingoGameType.Turnplate,EC_UnlockType.win)
                            self.animating = false
                            self.Button_down:setTouchEnabled(true)
                            self.Button_down:setGrayEnabled(false)
                            self.Button_up:setTouchEnabled(true)
                            self.Button_up:setGrayEnabled(false)
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
        end),
        CCDelayTime:create(self.numberTurnTime)
    })
    luckyGroup.Label_num:runAction(CCRepeatForever:create(act))
end



function BingoTurnPlateView:onRecvBingoResult()
    local resultFormation = BingoDataMgr:getOpenInfomation()
    local stopId=  resultFormation[1]
    self:startTurn(stopId)
end

function BingoTurnPlateView:updateItem()

    if not self.animating then
        local chipNum = BingoDataMgr:getChipItemNum()
        self.Label_chip:setText(chipNum)
        local topRes = BingoDataMgr:getTopIcon(chipNum)
        self.Image_chip:setTexture(topRes)
    end
end

function BingoTurnPlateView:stopTimer()
    self.startUpdate = false
end

function BingoTurnPlateView:update(target , dt)
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

function BingoTurnPlateView:registerEvents()

    EventMgr:addEventListener(self,EV_BAG_ITEM_UPDATE,handler(self.updateItem, self))
    EventMgr:addEventListener(self,EV_BINGOGAME_RESULT,handler(self.onRecvBingoResult, self));

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

    for k,v in ipairs(self.voteTab) do
        v.bg:onClick(function()

            if k == self.lastSelectId then
                return
            end

            self:selectVoteItem(k)
        end)
    end

    self.Button_do:onClick(function()
        local param = {}
        local num = 0
        for k,v in pairs(self.voteNum_) do
            if v ~= 0 then
                table.insert(param,k)
                table.insert(param,v)
                num = num + v
            end
        end

        if num == 0 then
            Utils:showTips("请投注")
            return
        end

        local chipNum = BingoDataMgr:getChipItemNum()
        self.tempNum = chipNum-num
        self.Label_chip:setText(self.tempNum)
        local topRes = BingoDataMgr:getTopIcon(self.tempNum)
        self.Image_chip:setTexture(topRes)
        self.Label_chip_delta:setVisible(false)
        self.animating = true
        BingoDataMgr:Send_openBingoGame(EC_BingoGameType.Turnplate,param)
    end)

    self.Button_back:onClick(function()
        BingoDataMgr:checkResultViewState()
        AlertManager:closeLayer(self)
    end)

    self.Button_add_chip:onClick(function()
        FunctionDataMgr:jStore(306000)
    end)
    self:addMEListener(TFWIDGET_ENTERFRAME,handler(self.update,self))
end

return BingoTurnPlateView
