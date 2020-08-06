local CourageLightGame = class("CourageLightGame", BaseLayer)

function CourageLightGame:initData()
    self.result = {1,2,3,4,5,6}
    self.newResult = {}
    self.tempResult = {}
    self.temp = {}
    self.failureCnt = 0
    self.maxFailureCnt = 3
    self.ResRoot = "ui/activity/courage/game/light/2/"
end

function CourageLightGame:ctor(eventCfg)
    self.super.ctor(self)

    self:initData()
    self.uiRes = eventCfg.gameRes or "courageLightGame"
    self:init("lua.uiconfig.courage."..self.uiRes)
end

function CourageLightGame:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close"):hide()
    self.Image_innerbg = TFDirector:getChildByPath(self.Panel_root, "Image_innerbg"):hide()
    self.Image_bg = TFDirector:getChildByPath(self.Panel_root, "Image_bg")
    self.Panel_game = TFDirector:getChildByPath(self.Panel_root, "Panel_game")
    self.light_ = {}
    for i=1,6 do
        local lightBtn = TFDirector:getChildByPath(self.Panel_game, "Button_light_"..i)
        local Image_light = TFDirector:getChildByPath(lightBtn, "Image_light"):hide()
        table.insert(self.light_,{btn = lightBtn, Image_light = Image_light, flagId = i, iconId = i})
    end

    self.flag_ = {}
    for i=1,6 do
        local flagBtn = TFDirector:getChildByPath(self.Panel_game, "Button_flag_"..i)
        flagBtn:setVisible(false)
        table.insert(self.flag_,{btn = flagBtn})
    end

    local gameCfg = CourageDataMgr:getGameCfg()
    for k,v in pairs(gameCfg) do
        if v.type == EC_CourageMiniGameType.LIGHT then
            self.miniGameCfg = v
            break
        end
    end

    self.Label_time = TFDirector:getChildByPath(self.Panel_root, "Label_time")
    self.Image_time = TFDirector:getChildByPath(self.Panel_root, "Image_time")
    CourageDataMgr:Send_StartGame(EC_CourageMiniGameType.LIGHT)
end

function CourageLightGame:showReConfirm()

    local args = {
        tittle = 2107025,
        content = "否消耗灯油、打火机两种道具",
        reType = EC_OneLoginStatusType.ReConfirm_HotSpotTryPlay,
        confirmCall = function()
            self:timeOut(function()

            end,0.2)
        end,
    }
    Utils:showReConfirm(args)
end

function CourageLightGame:spawnNewResultTab(flagId)
    local resultLen = #self.result
    local firstIndex = table.indexOf(self.result,flagId)
    for i=1,resultLen do
        local index = firstIndex + i - 1
        if index > resultLen then
            index = index - resultLen
        end
        if self.result[index] then
            table.insert(self.newResult,self.result[index])
        end
    end
end

function CourageLightGame:resetGame(init)
    self.newResult = {}
    self.tempResult = {}
    self.temp = {}
    dump(self.gameParam)
    local flagIds = Utils:shuffle(clone(self.gameParam))
    for k,v in ipairs(self.light_) do
        if init then
            v.flagId = flagIds[k]
            v.iconId = table.indexOf(self.gameParam,flagIds[k])
        end
        v.btn:setTouchEnabled(true)
        v.Image_light:setVisible(false)
        if self.uiRes == "courageLightGame1" then
            v.Image_light:setTexture(self.ResRoot..v.flagId..".png")
        end
    end

    for k,v in ipairs(self.flag_) do
        v.btn:setVisible(false)
    end
    self.Image_innerbg:setVisible(false)
end

function CourageLightGame:timeStart()
    local act = CCSequence:create({
        CCCallFunc:create(function()
            local curTime = ServerDataMgr:getServerTime()
            self:setTime(self.endTime - curTime)
            if curTime >= self.endTime then

                self.gameEnd = true
                self.Panel_root:stopAllActions()
                self:showResult(false)
                return
            end
        end),
        CCDelayTime:create(1)
    })
    self.Panel_root:runAction(CCRepeatForever:create(act))
end

function CourageLightGame:onRecvGameStart(gameParam)

    if not self.miniGameCfg then
        Box("找不到小游戏")
        return
    end

    self.gameParam = gameParam or {}
    self:resetGame(true)
    self.endTime = ServerDataMgr:getServerTime() + self.miniGameCfg.time
    self:setTime(self.miniGameCfg.time)
    self:timeStart()
end



function CourageLightGame:onRecvGameFinish(data)

    local result = data.success
    if not data.finished then
        if not result then
            Utils:showTips("点亮失败请重新尝试")
            self:resetGame(false)
        else
            local id = #self.tempResult
            local flagId = self.tempResult[id].flagId
            local iconId = self.tempResult[id].iconId
            self.flag_[iconId].btn:setVisible(true)
            Utils:playSound(5043)
        end
    else
        self:showResult(result)
    end
end

function CourageLightGame:showResult(result)

    dump("CourageLightGame:"..tostring(result))
    if result then
        Utils:playSound(5044)
        if self.uiRes == "courageLightGame1" then
            self.Image_bg:setVisible(false)
            self.Panel_game:setVisible(false)
        end
        self.Image_innerbg:setVisible(true)
        self:timeOut(function()
            CourageDataMgr:setMinGameResult(true)
            EventMgr:dispatchEvent(EV_COURAGE.EV_MINIGAME_DATING_RESULT)
            AlertManager:closeLayer(self)
        end,0.4)
    else
        CourageDataMgr:setMinGameResult(false)
        EventMgr:dispatchEvent(EV_COURAGE.EV_MINIGAME_DATING_RESULT)
        AlertManager:closeLayer(self)
    end
end

function CourageLightGame:setTime(remain)
    local day,hour, min, sec = Utils:getTimeDHMZ(remain, false)
    local str  = string.format("%.2d:%.2d",min, sec)
    self.Label_time:setText(str)

    local color = remain <= 15 and ccc3(255,0,0) or ccc3(67,214,198)
    self.Label_time:setText(str)
    self.Label_time:setColor(color)

    if remain <= 15 then
        if self.isRun then
            return
        end
        self.isRun = true
        local act = CCSequence:create({
            CCRotateTo:create(0.1,15),
            CCRotateTo:create(0.1,-15),
        })
        local act2 = CCSequence:create({
            CCRepeat:create(act,4),
            CCRotateTo:create(0.1,0),
            CCDelayTime:create(2)
        })
        self.Image_time:runAction(CCRepeatForever:create(act2))
    end
end

function CourageLightGame:registerEvents()

    EventMgr:addEventListener(self, EV_COURAGE.EV_MINIGAME_FINISH, handler(self.onRecvGameFinish, self))
    EventMgr:addEventListener(self, EV_COURAGE.EV_MINIGAME_START, handler(self.onRecvGameStart, self))

    self.Button_close:onClick(function()
        self:showResult(false)
    end)

    for k,v in ipairs(self.light_) do
        v.btn:onClick(function()
            if not self.gameParam then
                return
            end
            table.insert(self.tempResult,{flagId = v.flagId, iconId = v.iconId})
            table.insert(self.temp,v.flagId)
            CourageDataMgr:Send_GameResult(EC_CourageMiniGameType.LIGHT,self.temp)
            v.btn:setTouchEnabled(false)
            v.Image_light:setVisible(true)
        end)
    end

end


return CourageLightGame
