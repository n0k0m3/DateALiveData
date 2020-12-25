
local FishGame = class("FishGame", BaseLayer)
local Fish = import(".Fish")
function FishGame:ctor(gameData)
    self.super.ctor(self)
    self:initData(gameData)
    self.topBarFileName = "NewYearMiniGame"
    self:init("lua.uiconfig.NewYear.fishGame")
end

function FishGame:initData(gameData)

    self.minRoate,self.maxRoate,self.hungTime,self.lineDir = -45,45,0.015,1
    self.deltaLen = 4

    self.gameData = gameData

    self.poolFloor = {-160,-80,0,80,160}
    self.initFishPosX = {-400,-200,0,200,400}

    self.luckyFishId = nil

    self.overseaPosY = 110

    local kvpCfg = Utils:getKVP(90010)
    self.endTime = ServerDataMgr:getServerTime() + kvpCfg.Time

    self.fishData = self.gameData.pool or {}

    self.fishCfg = TabDataMgr:getData("MJziyuan")
    self.totalScore = 0

    self.luckyFishData = {}
end

function FishGame:initUI(ui)

    self.super.initUI(self, ui)
    self.ui = ui

    self.Panel_touch = TFDirector:getChildByPath(self.ui, "Panel_touch")
    self.Panel_touch:setSize(GameConfig.WS)

    self.Panel_root = TFDirector:getChildByPath(self.ui, "Panel_root")

    self.Image_background = TFDirector:getChildByPath(self.ui, "Image_background")

    self.Image_fishline = TFDirector:getChildByPath(self.ui,"Image_fishline")
    self.Image_hook = TFDirector:getChildByPath(self.ui,"Image_hook")
    self.minLen = self.Image_fishline:getContentSize().height
    self.Panel_point = TFDirector:getChildByPath(self.ui,"Panel_point")
    self.Spine_shuihua = TFDirector:getChildByPath(self.ui,"Spine_shuihua"):hide()
    self.Spine_shuihua:play("animation",false)

    self.Panel_bucket = TFDirector:getChildByPath(self.ui,"Panel_bucket")

    self.Panel_pool = TFDirector:getChildByPath(self.ui,"Panel_pool")
    local h = self.Panel_pool:getContentSize().height
    self.Panel_pool:setContentSize(CCSizeMake(GameConfig.WS.width,h))
    self.Label_fishscore = TFDirector:getChildByPath(self.Panel_pool,"Label_fishscore")
    self.Label_fishscore:setScale(0)

    self.Panel_ui_bucket = TFDirector:getChildByPath(self.ui,"Panel_ui_bucket")
    self.Panel_ui_bucket:setPositionX(-GameConfig.WS.width/2+10)

    self.Panel_ui_info = TFDirector:getChildByPath(self.ui,"Panel_ui_info")
    self.Panel_ui_info:setPositionX(GameConfig.WS.width/2-10)
    self.Image_time_bg = TFDirector:getChildByPath(self.Panel_ui_info,"Image_time_bg")
    self.Label_time = TFDirector:getChildByPath(self.Panel_ui_info,"Label_time")
    self.Label_score = TFDirector:getChildByPath(self.Panel_ui_info,"Label_score")
    self.Label_score:setText("0")
    self.Label_score_delta = TFDirector:getChildByPath(self.Panel_ui_info,"Label_score_delta")
    self.Label_score_delta:setOpacity(0)
    self.deltaPos = self.Label_score_delta:getPosition()

    self.Label_result = TFDirector:getChildByPath(self.ui,"Label_result"):hide()

    self.fishbucket_ = {}
    for i=1,4 do
        local icon = TFDirector:getChildByPath(self.ui,"Image_fishicon_"..i)
        icon:setScale(0.1)
        table.insert(self.fishbucket_,{icon = icon,haveFish = false})
    end

    self.spineSuccess = SkeletonAnimation:create("effect/effect_MJyouxichenggong/MJyouxichenggong")
    self.spineSuccess:setPosition(ccp(0,0))
    self.Panel_root:addChild(self.spineSuccess, 10)


    self.Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab")
    self.Panel_fish = TFDirector:getChildByPath(self.Panel_prefab, "Panel_fish")


    self:spawnFish()
    self:rest()
    self:startTimer()
end

function FishGame:startTimer()
    local act = CCSequence:create({
        CCCallFunc:create(function()
            local curTime = ServerDataMgr:getServerTime()
            local remainTime = self.endTime - curTime
            if remainTime <= 0 then
                self.Label_time:stopAllActions()
                self:SendFinishGame()
                return
            end

            local color = remainTime <= 10 and ccc3(255,0,0) or ccc3(255,255,255)
            self.Label_time:setColor(color)

            if remainTime <= 10 then
                local act = CCSequence:create({
                    CCRotateTo:create(0.1,10),
                    CCRotateTo:create(0.1,-10),
                })
                local act2 = CCSequence:create({
                    CCRepeat:create(act,4),
                    CCRotateTo:create(0.1,0),
                    CCDelayTime:create(2)
                })
                self.Image_time_bg:runAction(CCRepeatForever:create(act2))
            end

            local day,hour, min, sec = Utils:getTimeDHMZ(remainTime, false)
            local str  = string.format("%.2d:%.2d",min, sec)
            self.Label_time:setText(str)
        end),
        CCDelayTime:create(1)
    })
    self.Label_time:runAction(CCRepeatForever:create(act))
end

function FishGame:SendFinishGame(result)

    self.gameEnd = true

    for k,v in ipairs(self.fish) do
        v:stop()
    end
    self.Image_fishline:stopAllActions()
    self.Image_time_bg:stopAllActions()
    self.Label_time:stopAllActions()

    if not result then
        self.Label_result:show()
        self.Label_result:setText("游戏失败")
        self:timeOut(function()
            AlertManager:closeLayer(self)
        end,1)
        return
    end

    ActivityDataMgr2:Req2020FestivalGameFinish(self.gameData.group, self.luckyFishData)
end

function FishGame:finishGame(data)

    if not data.status then
        self.Label_result:show()
        self.Label_result:setText("游戏失败")

        self:timeOut(function()
            AlertManager:closeLayer(self)
        end,1)
    else
        TFAudio.playSound("sound/dating_sound/dating_285.mp3")
        self.spineSuccess:play("animation", false)
        self.spineSuccess:addMEListener(TFARMATURE_COMPLETE,function(spine,animationName)
            self.spineSuccess:removeMEListener(TFARMATURE_COMPLETE)
            local param = {
                gameType = EC_NewYearGameType.Fish,
                rewards = data.rewards
            }
            ActivityDataMgr2:showGameResult(param)
            AlertManager:closeLayer(self)
        end)
    end

end

function FishGame:spawnFish()

    local fishParam = {
        maxDistance = GameConfig.WS.width/2,
        poolFloor = clone(self.poolFloor),
        initPosX = clone(self.initFishPosX)
    }

    self.fishData = Utils:shuffle(self.fishData)
    self.fish = {}
    for k,v in ipairs(self.fishData) do
        local fishInfo = self.fishCfg[v]
        if fishInfo then
            local oneFish = Fish:new(self.Panel_fish,self.Panel_pool,fishParam,fishInfo)
            oneFish:create()
            table.insert(self.fish,oneFish)
        end
    end
end

function FishGame:rest()
    self.Image_fishline:stopAllActions()
    self:hangFishLine()
    self.luckyFishId = nil
    self.gameEnd = false
    self.isStretch = false
    self:putInBag()
end

function FishGame:hangFishLine()

    local roate = self.Image_fishline:getRotation()
    if roate >= self.maxRoate then
        self.lineDir = -1
    elseif roate <= self.minRoate then
        self.lineDir = 1
    end
    local act = CCRotateBy:create(self.hungTime,self.lineDir)
    local actfun = CCCallFunc:create(function()
        self:hangFishLine(self.lineDir)
    end)
    local seq = CCSequence:create({act,actfun})
    self.Image_fishline:runAction(seq)
end

function FishGame:goFishing()

    self.isPlayOutWarter = false
    self.Image_fishline:stopAllActions()
    local act = CCSequence:create({
        CCCallFunc:create(function ()
            self:looseOrtight(self.deltaLen)
        end)
    })

    self.Image_fishline:runAction(CCRepeatForever:create(act))
end

function FishGame:endFishing()

    self.isPlayOutWarter = false
    self.Image_fishline:stopAllActions()

    self:catchFish()

    local act = CCSequence:create({
        CCCallFunc:create(function ()
            local contentSize = self.Image_fishline:getContentSize()
            if contentSize.height <= self.minLen then
                self:rest()
            else
                self:looseOrtight(-self.deltaLen)
            end
        end)
    })

    self.Image_fishline:runAction(CCRepeatForever:create(act))
end

function FishGame:catchFish()

    if not self.luckyFishId then
        return
    end

    local luckyFish = self.fish[self.luckyFishId]
    if not luckyFish then
        return
    end

    local obj = luckyFish:getObj()
    if not obj then
        return
    end


    self.fishRes = luckyFish:getRes()
    self.score = luckyFish:getScore()
    self.luckyFishCid = luckyFish:getCid()


    self.Label_fishscore:setText("+"..self.score)
    local act = CCSequence:create({
        CCScaleTo:create(0.2,1),
        CCDelayTime:create(0.5),
        CCCallFunc:create(function()
            self.Label_fishscore:setText("")
            self.Label_fishscore:setScale(0)
        end)
    })
    self.Label_fishscore:runAction(act)
    local pos = obj:getPosition()
    self.Label_fishscore:setPosition(pos)

    local fish = obj:clone()
    fish:setPosition(ccp(0,0))
    fish:setName("hookFish")
    local fishBaseInfo = self.fishCfg[self.luckyFishCid].fishBaseInfo
    local spineFish = SkeletonAnimation:create(fishBaseInfo.spineRes)
    spineFish:play("animation",false)
    spineFish:setPosition(ccp(fishBaseInfo.offset[1],fishBaseInfo.offset[2]))
    fish:addChild(spineFish)
    self.Panel_point:addChild(fish)

    luckyFish:destroy()
end

function FishGame:putInBag()

    local hookFish = self.Panel_point:getChildByName("hookFish")
    if not hookFish then
        return
    end

    local pos = hookFish:getPosition()
    local worldPoint = self.Panel_point:getParent():convertToWorldSpaceAR(pos)
    pos = self.Panel_bucket:convertToNodeSpaceAR(worldPoint)

    local fish = hookFish:clone()
    local fishBaseInfo = self.fishCfg[self.luckyFishCid].fishBaseInfo
    local spineFish = SkeletonAnimation:create(fishBaseInfo.spineRes)
    spineFish:play("animation",false)
    spineFish:setPosition(ccp(fishBaseInfo.offset[1],fishBaseInfo.offset[2]))
    fish:addChild(spineFish)
    fish:setPosition(pos)
    self.Panel_bucket:addChild(fish)

    hookFish:removeFromParent()

    local pos = self.Label_score:getPosition()
    self.Label_score_delta:setText("+"..self.score)
    local act = CCSpawn:create({
        CCMoveTo:create(0.8,pos),
        CCFadeIn:create(0.8)
    })
    local seq = CCSequence:create({
        act,
        CCCallFunc:create(function()
            self.totalScore = self.totalScore + self.score
            self.Label_score:setText(self.totalScore)
            self.Label_score_delta:setOpacity(0)
            self.Label_score_delta:setPosition(self.deltaPos)
        end)
    })
    self.Label_score_delta:runAction(seq)

    local spawnAct = CCSpawn:create({
        CCMoveTo:create(0.3,ccp(0,0)),
        CCScaleTo:create(0.3,0.2)
    })
    local act = CCSequence:create({
        spawnAct,
        CCCallFunc:create(function()

            local bagId
            for k,v in ipairs(self.fishbucket_) do
                if not v.haveFish then
                    v.icon:setTexture(self.fishRes)
                    v.icon:runAction(CCScaleTo:create(0.1,1))
                    v.haveFish = true
                    bagId = k
                    table.insert(self.luckyFishData,self.luckyFishCid)
                    break
                end
            end
            if bagId and bagId == 4 then
                self:SendFinishGame(true)
            end
        end)
    })
    fish:runAction(act)
end

function FishGame:looseOrtight(delta,fishObj)

    self.isStretch = true
    local contentSize = self.Image_fishline:getContentSize()
    local len = contentSize.height +delta
    local w = contentSize.width
    self.Image_fishline:setContentSize(CCSizeMake(w,len))
    local hookPosY = len - 3
    self.Image_hook:setPositionY(-hookPosY)
    self:spawnWaterFlower(delta)
    if delta > 0 then
        local luckyFishId,isTouchBorder = self:check()
        if luckyFishId or isTouchBorder then
            self.luckyFishId = luckyFishId
            self:endFishing()
        end
    end
end

function FishGame:spawnWaterFlower(delta)

    local pos = self.Panel_point:getPosition()
    local worldPoint = self.Panel_point:getParent():convertToWorldSpaceAR(pos)
    pos = self.Image_background:convertToNodeSpaceAR(worldPoint)

    if not self.isPlayOutWarter then
        if (pos.y - self.overseaPosY)*(delta/math.abs(delta)) <= 0 then
            self.Spine_shuihua:setVisible(true)
            self.Spine_shuihua:play("animation",false)
            self.isPlayOutWarter = true

            self.Spine_shuihua:setPosition(pos)

        end
    end

end

function FishGame:check()
    local pos = self.Panel_point:getPosition()
    local worldPoint = self.Panel_point:getParent():convertToWorldSpaceAR(pos)
    pos = self.Panel_pool:convertToNodeSpaceAR(worldPoint)

    local luckyFishId
    for k,v in ipairs(self.fish) do
        local fishPos = v:getPosition()
        local boxSize = v:getBoxSize()
        if fishPos and boxSize then
            local width,height = boxSize.width,boxSize.height
            local rightBorder = fishPos.x + width/2
            local leftBorder = fishPos.x - width/2
            local topBorder = fishPos.y + height/2
            local btmBorder = fishPos.y -height/2
            if pos.x < rightBorder and pos.x > leftBorder and
                    pos.y < topBorder and pos.y > btmBorder then
                v:stop()
                luckyFishId = k
                break
            end
        end
    end
    local isTouchBorder = self:touchBorder(pos)
    return luckyFishId,isTouchBorder
end

function FishGame:touchBorder(pos)

    local poosSize = self.Panel_pool:getContentSize()
    local width,height = poosSize.width,poosSize.height
    if pos.y <= -height/2 or pos.x >= width/2 or pos.x <= -width/2 then
        return true
    end
    return false
end

function FishGame:registerEvents()
    EventMgr:addEventListener(self,EV_NEW_YEAR_GAME_FINISH, handler(self.finishGame, self))
    self.Panel_touch:onClick(function()
        if self.gameEnd or self.isStretch then
            return
        end
        self:goFishing()
    end)

end

return FishGame