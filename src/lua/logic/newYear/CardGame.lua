
local CardGame = class("CardGame", BaseLayer)

function CardGame:initData(gameData)

    self.gameData = gameData
    dump(self.gameData)

    self.cardCnt = 6
    self.max_moveDis = 45
    self.centerPos = ccp(0,-260)
    self.radius = 300
    self.deltaDegree = 15
    self.PI = 3.1415926
    self.curCardCnt = 6

    local gameCfg = TabDataMgr:getData("MJfenzu")[self.gameData.group]

    self.luckyCnt = gameCfg.matchNum

    self.result = clone(self.gameData.result)

    ---分别剩1,2,3,4,5,6张牌时，第一张牌的位置
    self.firstDegree = {90,96,105,110,120,128}

    self.startPos = ccp(0,-342)

    self.animateTime = {}
    self.animateTime.chupai1 = 0.2
    self.animateTime.chupai2 = {0.18,0.14,0.12,0.12,0.14,0.18}
    self.animateTime.waite = 0.5
    self.animateTime.toBack = 0.35
    self.animateTime.toCenter = 0.25
    self.animateTime.toFront = 0.35
    self.animateTime.fold = 0.1
    self.animateTime.unfold = 0.1

    self.path = "ui/newyear/cardGame/baiyang.png"

    self.cardData_ = {}
    local gameCfg = TabDataMgr:getData("MJziyuan")
    for k,v in pairs(gameCfg) do
        if v.gametype == EC_NewYearGameType.Divine then
            table.insert(self.cardData_,v)
        end
    end

    self.kvpCfg = Utils:getKVP(90011)
    self.spinePos = ccp(0,114)
end

function CardGame:ctor(gameData)
    self.super.ctor(self)
    --self:showPopAnim(true)
    self:initData(gameData)
    self.topBarFileName = "NewYearMiniGame"
    self:init("lua.uiconfig.NewYear.cardGame")
end

function CardGame:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.Panel_touch = TFDirector:getChildByPath(self.Panel_root, "Panel_touch"):hide()
    self.Panel_touch:setSize(GameConfig.WS)
    self.Panel_cards = TFDirector:getChildByPath(self.Panel_root, "Panel_cards")

    self.Image_live2d = TFDirector:getChildByPath(self.Panel_root, "Image_live2d")

    self.Spine_center = TFDirector:getChildByPath(self.Panel_root, "Spine_center")
    self.Spine_center:stop()

    --self.Image_bg = TFDirector:getChildByPath(self.Panel_root, "Image_bg")
    --self.Image_bg:setTexture("/scene/bg/bg_wanoudian2.png")

    self.luckyPL_ = {}
    for i=1,self.luckyCnt do
        local pl = TFDirector:getChildByPath(self.Panel_cards, "Panel_lucky_pos"..i)
        local centerpl = TFDirector:getChildByPath(pl, "Panel_center")
        local Spine_card = TFDirector:getChildByPath(pl, "Spine_card")
        Spine_card:hide()
        pl:setZOrder(self.cardCnt + i)
        local ps = pl:getPosition()
        table.insert(self.luckyPL_,{pl = pl,centerpl = centerpl,Spine_card = Spine_card,pos = ps,isNill = true})
    end

    self.dialog = TFDirector:getChildByPath(ui, "dialog")
    self.Label_tip = TFDirector:getChildByPath(ui, "Label_tip")
    self.Label_tip:setTextById(2460091)

    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
    self.Panel_card = TFDirector:getChildByPath(self.Panel_prefab, "Panel_card")

    local startPos = -294
    local deltaSize = 120
    self.cards_ = {}
    for i=1,self.cardCnt do
        local cardClone = self.Panel_card:clone()
        local posX = startPos + (i-1) * deltaSize
        cardClone:setPosition(ccp(posX,0))
        self.Panel_cards:addChild(cardClone)

        local tab = {}
        tab.pl = cardClone
        tab.pl:setZOrder(i)
        tab.front = TFDirector:getChildByPath(tab.pl, "Image_front")
        tab.itemIcon = TFDirector:getChildByPath(tab.front, "Image_icon")
        tab.back = TFDirector:getChildByPath(tab.pl, "Image_card")
        tab.pos = ccp(posX,0)
        tab.originalPos = tab.pl:getPosition()
        tab.roate = 0
        tab.lineAngel = 0
        tab.moveTo = i
        tab.isMove = false
        tab.inQueue = true
        table.insert(self.cards_,tab)
    end

    self:initUILogic()
end

function CardGame:initUILogic()

    EventMgr:dispatchEvent(EV_HIDE_MAIN_LIVE2D)

    self.luckyCardData_ = {}
    self:resetCardInfo(self.curCardCnt)
    self:initLive2d()
    self.dialog:show()
end

function CardGame:initLive2d()

    self.elvesNpc = ElvesNpcTable:createLive2dNpcID(self.kvpCfg.level2d,true,true,nil,false).live2d
    self.elvesNpc:setScale(0.4)
    self.elvesNpc:setPosition(ccp(20, -380))
    self.Image_live2d:addChild(self.elvesNpc, 1)

    local act = CCSequence:create({
        CCCallFunc:create(function()
            self.elvesNpc:newStartAction(self.kvpCfg.sayhello,EC_PRIORITY.FORCE)
        end),
        CCDelayTime:create(10)
    })
    self.Image_live2d:runAction(CCRepeatForever:create(act))

end

function CardGame:resetCardInfo(totalCards)

    self.Panel_touch:setVisible(false)
    local first = self.firstDegree[totalCards]
    for i=1,self.cardCnt do
        self.cards_[i].pl:setVisible(i <= totalCards)
        if i <= totalCards then
            local degree = first - (i-1)*self.deltaDegree
            local x,y = self:getCirclePos(degree)
            self.cards_[i].pl:setPosition(ccp(x,y))
            self.cards_[i].pos = ccp(x,y)
            local rotaion = degree - 90
            self.cards_[i].pl:setRotation(-rotaion)
            self.cards_[i].roate = -rotaion
            local angle = self:getLineAngel(ccp(x,y),self.centerPos)
            self.cards_[i].lineAngel = math.deg(angle)
            self.cards_[i].front:hide()
            self.cards_[i].back:show()
            self.cards_[i].pl:setZOrder(i)
            self.cards_[i].pl:setScale(1)
            self.cards_[i].isMove = false
        end
    end

end

function CardGame:changeCardGray(chooedIndex,opacity)

    for i=1,self.cardCnt do
        if i ~= chooedIndex then
            self.cards_[i].pl:setGrayEnabled(opacity)
        end
    end
end

function CardGame:moveToCenter(id)
    self.Panel_touch:setVisible(true)
    self.cards_[id].pl:setZOrder(10)
    local act = CCSequence:create({
        CCSpawn:create({
            CCMoveTo:create(self.animateTime.toCenter, self.spinePos),
            CCRotateTo:create(self.animateTime.toCenter, 0),
            CCScaleTo:create(self.animateTime.toCenter,1.2)
        }),
        CCCallFunc:create(function()

            self.Spine_center:play("animation",0)
            self.Spine_center:addMEListener(TFARMATURE_COMPLETE,function()
                self.Spine_center:removeMEListener(TFARMATURE_COMPLETE)
                self.cards_[id].itemIcon:hide()
                local luckyCardInfo,index = self:getLuckyCard()
                local res = luckyCardInfo.param == 3 and "ui/newyear/cardGame/pai.png" or "ui/newyear/cardGame/front.png"
                self.cards_[id].front:setTexture(res)
                self:turnLuckyCard(id)
            end)

        end)
    })
    self.cards_[id].pl:runAction(act)
end

function CardGame:turnLuckyCard(id)

    Utils:playSound(5022)
    local card = self.cards_[id]
    if not card then
        return
    end

    local function callBack()
        self:moveToluckyPos(id)
    end

    local action = Sequence:create({
        CallFunc:create(function()
            card.itemIcon:show()
            local luckyCardInfo,index = self:getLuckyCard()
            local res = luckyCardInfo.param == 3 and luckyCardInfo.res2 or luckyCardInfo.res
            card.itemIcon:setTexture(res)
            self:removeResult()
            table.insert(self.luckyCardData_,luckyCardInfo)
            table.remove(self.cardData_,index)
            ViewAnimationHelper.doCameraAction(card.front,card.back,self.animateTime.toFront,callBack)
        end),
    })
    self.cards_[id].back:runAction(action)
end

function CardGame:getLuckyCard()

    if not self.result then
        return
    end

    local luckyNum = self.result[1]
    local index = math.random(1,#self.cardData_)
    for k,v in ipairs(self.cardData_) do
        if v.id == luckyNum then
            index = k
            break
        end
    end
    return self.cardData_[index],index
end

function CardGame:removeResult()
    if not self.result then
        return
    end
    table.remove(self.result,1)
end

function CardGame:moveToluckyPos(id)

    local posId
    for k,v in ipairs(self.luckyPL_) do
        if v.isNill then
            posId = k
            break
        end
    end

    if not posId then
        return
    end

    local front = self.cards_[id].front:clone()
    front:setPosition(ccp(0,0))
    self.luckyPL_[posId].centerpl:addChild(front)
    local pos = self.cards_[id].pl:getPosition()
    self.luckyPL_[posId].pl:setPosition(pos)
    self.luckyPL_[posId].isNill = false
    self.luckyPL_[posId].Spine_card:show()

    self.Image_live2d:stopAllActions()
    self.dialog:hide()
    self.cards_[id].pl:setVisible(false)
    ViewAnimationHelper.doCameraAction(self.cards_[id].back,self.cards_[id].front,self.animateTime.toBack)
    local targetPos = self.luckyPL_[posId].pos
    local act = CCSequence:create{
        CCDelayTime:create(0.3),
        CCSpawn:create({
            CCMoveTo:create(0.4,targetPos),
            CCScaleTo:create(0.4,1)
        }),
        CCCallFunc:create(function()
            self.curCardCnt =  self.curCardCnt - 1
            self:resetCardInfo(self.curCardCnt)
            self:showResult()
        end)
    }
    self.luckyPL_[posId].pl:runAction(act)
end

function CardGame:showResult()
    local remainCnt = self.cardCnt - self.luckyCnt
    if self.curCardCnt > remainCnt then
        return
    end

    self.elvesNpc:newStartAction(self.kvpCfg.success,EC_PRIORITY.FORCE)
    for i=1,self.cardCnt do
        self.cards_[i].pl:setVisible(false)
    end
    local delatPosX = 50
    local posX = math.abs(self.luckyPL_[1].pos.x)
    local posY = self.luckyPL_[1].pos.y
    self.luckyPL_[1].pl:runAction(CCMoveTo:create(0.2,ccp(-posX + delatPosX,posY)))
    self.luckyPL_[3].pl:runAction(CCMoveTo:create(0.2,ccp(posX - delatPosX,posY)))

    ActivityDataMgr2:Req2020FestivalGameFinish(self.gameData.group, self.gameData.result)

    --Utils:openView("newYear.CardResult",self.luckyCardData_)
    --self:timeOut(function()
    --    local view = requireNew("lua.logic.newYear.CardResult"):new(self.luckyCardData_)
    --    AlertManager:addLayer(view, AlertManager.BLOCK)
    --    AlertManager:show()
    --end,0.2)

end

function CardGame:onRecvResult(data)

    local function callback()
        local param = {
            gameType = EC_NewYearGameType.Divine,
            rewards = data.rewards
        }
        ActivityDataMgr2:showGameResult(param)
        AlertManager:closeLayer(self)
    end

    local view = requireNew("lua.logic.newYear.CardResult"):new(self.luckyCardData_,callback)
    AlertManager:addLayer(view, AlertManager.BLOCK)
    AlertManager:show()
end

function CardGame:registerEvents()

    EventMgr:addEventListener(self,EV_NEW_YEAR_GAME_FINISH, handler(self.onRecvResult, self))
    local beginPos, endPos = me.p(0, 0), me.p(0, 0)
    for i=1,self.cardCnt do
        self.cards_[i].pl:onTouch(function(event)
            if event.name == "began" then
                self.cards_[i].pl:setScale(1)
                beginPos = event.target:getTouchStartPos()
                self:changeCardGray(i,true)
            elseif event.name == "moved" then
                local movePos = event.target:getTouchMovePos()
                local moveEndlPos = self.Panel_cards:convertToNodeSpaceAR(movePos)
                local beginLocalPos = self.cards_[i].pos
                if moveEndlPos.y <= beginLocalPos.y then
                    return
                end
                local disFlag = beginLocalPos.x >= 0 and 1 or -1
                local dis = self:getDistance(moveEndlPos,beginLocalPos)
                local moveDis = self.max_moveDis
                if self.max_moveDis > math.sqrt(dis)  then
                    moveDis = math.sqrt(dis)
                end
                local rad = math.rad(self.cards_[i].lineAngel)
                local disX = moveDis*math.cos(rad)*disFlag
                local disY = moveDis*math.sin(rad)*disFlag
                self.cards_[i].pl:setPosition(ccp(beginLocalPos.x+disX,beginLocalPos.y+disY))
            elseif event.name == "ended" then
                endPos = event.target:getTouchEndPos()

                local endLocalPos = self.cards_[i].pl:getPosition()
                local originalPos = self.cards_[i].pos
                local dis = self:getDistance(endLocalPos,originalPos)
                if math.sqrt(dis) < self.max_moveDis-5 then
                    self.cards_[i].pl:setPosition(originalPos)
                    self.cards_[i].pl:setScale(1)
                    self:changeCardGray(i,false)
                else
                    ---开始抽卡
                    local sendResult = true
                    if sendResult then
                        self.cards_[i].pl:setPosition(originalPos)
                        self:changeCardGray(i,false)
                        self.cards_[i].pl:setScale(1)
                        self:moveToCenter(i)
                    end
                end
            end
        end)
    end
end

function CardGame:getCirclePos(degree)
    local x   =   self.centerPos.x   +   self.radius   *   math.cos(math.rad(degree))
    local y   =   self.centerPos.y   +   self.radius   *   math.sin(math.rad(degree))
    return x,y
end

function CardGame:getDistance(pos1,pos2)
    local dis = (pos2.y - pos1.y)*(pos2.y - pos1.y) + (pos2.x - pos1.x)*(pos2.x - pos1.x)
    return dis
end

function CardGame:getLineAngel(pos1,pos2)
    local k = (pos2.y - pos1.y)/(pos2.x - pos1.x)
    return math.atan(k)
end

return CardGame
