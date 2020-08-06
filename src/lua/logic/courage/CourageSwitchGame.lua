local CourageSwitchGame = class("CourageSwitchGame", BaseLayer)

function CourageSwitchGame:initData()
    self.isStart = false
    self.switchData = {}
    self.curSwitchData = {false,false,false,false}
    self.failureCnt = 0
    self.maxFailureCnt = 3

    self.res = {}
    self.res[1] = {"ui/activity/courage/game/switch/2.png","ui/activity/courage/game/switch/4.png"}
    self.res[2] = {"ui/activity/courage/game/switch/6.png","ui/activity/courage/game/switch/5.png"}
    self.res[3] = {"ui/activity/courage/game/switch/8.png","ui/activity/courage/game/switch/7.png"}
    self.res[4] = {"ui/activity/courage/game/switch/9.png","ui/activity/courage/game/switch/10.png"}

    if self.uiRes == "courageSwitchGame1" then
        self.res[1] = {"ui/activity/courage/game/switch/2/3.png","ui/activity/courage/game/switch/2/4.png"}
        self.res[2] = {"ui/activity/courage/game/switch/2/3.png","ui/activity/courage/game/switch/2/4.png"}
        self.res[3] = {"ui/activity/courage/game/switch/2/3.png","ui/activity/courage/game/switch/2/4.png"}
        self.res[4] = {"ui/activity/courage/game/switch/2/3.png","ui/activity/courage/game/switch/2/4.png"}
    end
end

function CourageSwitchGame:ctor(eventCfg)
    self.super.ctor(self)

    self.uiRes = eventCfg.gameRes or "courageSwitchGame"
    self.soundId = self.uiRes == "courageSwitchGame" and 5041 or 5026
    self:initData()
    self:init("lua.uiconfig.courage."..self.uiRes)
end

function CourageSwitchGame:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.Panel_game = TFDirector:getChildByPath(self.Panel_root, "Panel_game")
    self.Image_innerbg = TFDirector:getChildByPath(self.Panel_root, "Image_innerbg"):hide()

    self.switch_ = {}
    for i=1,4 do
        local switchPL = TFDirector:getChildByPath(self.Panel_game, "Panel_switch_"..i)
        local Image_dot = TFDirector:getChildByPath(switchPL, "Image_dot")
        local Image_back = TFDirector:getChildByPath(switchPL, "Image_back")
        table.insert(self.switch_,{switchPL = switchPL, dot = Image_dot,Image_back = Image_back, flagId = i, curId = i})
    end

    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close"):hide()

    self.point_ = {}
    for i=1,2 do
        local Image_point = TFDirector:getChildByPath(self.Panel_game, "Image_point"..i)
        self.point_[i] = Image_point
    end

    local gameCfg = CourageDataMgr:getGameCfg()
    for k,v in pairs(gameCfg) do
        if v.type == EC_CourageMiniGameType.SWITCH then
            self.miniGameCfg = v
            break
        end
    end

    self.Label_time = TFDirector:getChildByPath(self.Panel_root, "Label_time")
    self.Image_time = TFDirector:getChildByPath(self.Panel_root, "Image_time")
    self:timeOut(function()
        CourageDataMgr:Send_StartGame(EC_CourageMiniGameType.SWITCH)
    end)
end


function CourageSwitchGame:resetGame()

    self.isStart = false

    local tempData = Utils:shuffle({1,1,1,2})

    local isOriginal = true
    for k,v in ipairs(self.gameParam) do
        if v ~= tempData[k] then
            isOriginal = false
            break
        end
    end

    if isOriginal then
        for i=1,4 do
            tempData[i] =  tempData[i] == 1 and 2 or 1
        end
    end
    for i=1,4 do
        self.switch_[i].flagId = tempData[i]
        self.switch_[i].dot:setTexture(self.res[i][tempData[i]])
    end

    self:checkResult()
end

function CourageSwitchGame:clickSwicth(k)

    if not self.gameParam then
        return
    end
    self.switch_[k].Image_back:runAction(CCRotateBy:create(1,360))

    local curFlagId = self.switch_[k].flagId
    curFlagId = curFlagId == 1 and 2 or 1
    self.switch_[k].flagId= curFlagId
    self.switch_[k].dot:setTexture(self.res[k][curFlagId])
    self:checkResult()
end

function CourageSwitchGame:checkResult()

    local isPass = true
    local result = {}
    for k,v in ipairs(self.switch_) do
        if v.flagId == self.gameParam[k] then
            table.insert(result,v.flagId)
        end
    end
    local resultCnt = #result
    self:turnPoint(resultCnt)
    if resultCnt == 4 then
        CourageDataMgr:Send_GameResult(EC_CourageMiniGameType.SWITCH,result)
    end
end

function CourageSwitchGame:turnPoint(resultCnt)

    if self.uiRes ~= "courageSwitchGame1" then
        return
    end

    local rotate = -60 +(resultCnt-1)*30
    for k,v in ipairs(self.point_) do
        v:runAction(CCRotateTo:create(0.2,rotate))
    end

end

function CourageSwitchGame:timeStart()
    local act = CCSequence:create({
        CCCallFunc:create(function()
            local curTime = ServerDataMgr:getServerTime()
            self:setTime(self.endTime-curTime)
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

function CourageSwitchGame:onRecvGameStart(gameParam)

    if not self.miniGameCfg then
        Box("找不到小游戏")
        return
    end
    self.gameParam = gameParam or {}
    self:resetGame()
    self.endTime = ServerDataMgr:getServerTime() + self.miniGameCfg.time
    self:setTime(self.miniGameCfg.time)
    self:timeStart()
end

function CourageSwitchGame:setTime(remain)
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

function CourageSwitchGame:onRecvGameFinish(data)
    local result = data.success
    dump("CourageSwitchGame onRecvGameFinish:"..tostring(data.success))
    self:showResult(result)
end

function CourageSwitchGame:showResult(result)
    dump("CourageSwitchGame:"..tostring(result))
    if result then

        if self.uiRes ~= "courageSwitchGame1" then
            self.Panel_game:setVisible(false)
        end
        self.Image_innerbg:setVisible(true)
        self:timeOut(function()
            CourageDataMgr:setMinGameResult(result)
            EventMgr:dispatchEvent(EV_COURAGE.EV_MINIGAME_DATING_RESULT)
            AlertManager:closeLayer(self)
        end,1)
    else
        CourageDataMgr:setMinGameResult(result)
        EventMgr:dispatchEvent(EV_COURAGE.EV_MINIGAME_DATING_RESULT)
        AlertManager:closeLayer(self)
    end
end

function CourageSwitchGame:registerEvents()

    EventMgr:addEventListener(self, EV_COURAGE.EV_MINIGAME_FINISH, handler(self.onRecvGameFinish, self))
    EventMgr:addEventListener(self, EV_COURAGE.EV_MINIGAME_START, handler(self.onRecvGameStart, self))

    self.Button_close:onClick(function()
        self:showResult(false)
    end)

    local beginPos, endPos = me.p(0, 0), me.p(0, 0)
    for k,v in ipairs(self.switch_) do
        v.switchPL:onClick(function()
            Utils:playSound(self.soundId)
            self:clickSwicth(k)
        end)
    end

end


return CourageSwitchGame
