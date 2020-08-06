local CourageDirGame = class("CourageDirGame", BaseLayer)

function CourageDirGame:initData()
    self.tempResult = {}
    self.isMove = false
end

function CourageDirGame:ctor(...)
    self.super.ctor(self)

    self:initData(...)
    self:init("lua.uiconfig.courage.courageDirGame")
end

function CourageDirGame:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.dir_ = {}
    for i=1,4 do
        local panel = TFDirector:getChildByPath(self.Panel_root, "Panel_dir_item_"..i)
        local btn = TFDirector:getChildByPath(panel, "Button_item")
        table.insert(self.dir_,{panel = panel,btn = btn, id = i})
    end

    self.Image_time = TFDirector:getChildByPath(self.Panel_root, "Image_time")
    self.Label_time = TFDirector:getChildByPath(self.Panel_root, "Label_time")

    self.Panel_close = TFDirector:getChildByPath(self.Panel_root, "Panel_close")
    self.BtnClose = TFDirector:getChildByPath(self.Panel_close, "Button_item"):hide()

    local layerName = {"CourageBigMap","CourageBagView","CourageComposeView"}
    for k,v in ipairs(layerName) do
        local isLayerInQueue,layer = AlertManager:isLayerInQueue(v)
        if isLayerInQueue then
            AlertManager:closeLayer(layer)
        end
    end

    local gameCfg = CourageDataMgr:getGameCfg()
    for k,v in pairs(gameCfg) do
        if v.type == EC_CourageMiniGameType.LIGHT then
            self.miniGameCfg = v
            break
        end
    end

    CourageDataMgr:Send_StartGame(EC_CourageMiniGameType.MAZE)
end


function CourageDirGame:timeStart()
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

function CourageDirGame:setTime(remain)
    local day,hour, min, sec = Utils:getTimeDHMZ(remain, false)
    local str  = string.format("%.2d:%.2d",min, sec)
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

function CourageDirGame:checkResult(k)

    for id,v in ipairs(self.dir_) do
        v.panel:setVisible(k == id)
    end

    self.isMove = true
    local function callback()
        self.isMove = false
        if self.dir_ then
            for id,v in ipairs(self.dir_) do
                v.panel:setVisible(true)
            end
        end
    end
    EventMgr:dispatchEvent(EV_COURAGE.EV_MINIGAME_MOVE,callback)

    local index = #self.tempResult
    if self.gameParam[index] == self.dir_[k].id then
        self.dir_[k].btn:setTouchEnabled(false)
        self.dir_[k].panel:setGrayEnabled(true)
        if index == 4 then
            CourageDataMgr:Send_GameResult(EC_CourageMiniGameType.MAZE,self.tempResult)
        end
        EventMgr:dispatchEvent(EV_COURAGE.EV_MINIGAME_RESULT,"成功")
    else
        self.tempResult = {}
        for k,v in ipairs(self.dir_) do
            v.btn:setTouchEnabled(true)
            v.panel:setGrayEnabled(false)
        end
        EventMgr:dispatchEvent(EV_COURAGE.EV_MINIGAME_RESULT,"失败")
    end
end

function CourageDirGame:onRecvGameFinish(data)
    local result = data.success
    self:showResult(result)
end

function CourageDirGame:showResult(result)
    dump("CourageDirGame:"..tostring(result))
    CourageDataMgr:setMinGameResult(result)
    EventMgr:dispatchEvent(EV_COURAGE.EV_MINIGAME_DATING_RESULT)
    AlertManager:closeLayer(self)
end

function CourageDirGame:onRecvGameStart(gameParam)

    if not self.miniGameCfg then
        Box("找不到小游戏")
        return
    end

    self.clickIndex = 0
    self.gameParam = gameParam or {}
    dump(self.gameParam)
    local result = Utils:shuffle(clone(gameParam))
    dump(result)
    for k,v in ipairs(self.dir_) do
        v.id = result[k]
    end
    self.endTime = ServerDataMgr:getServerTime() + self.miniGameCfg.time
    self:setTime(self.miniGameCfg.time)
    self:timeStart()
end

function CourageDirGame:registerEvents()

    EventMgr:addEventListener(self, EV_COURAGE.EV_MINIGAME_FINISH, handler(self.onRecvGameFinish, self))
    EventMgr:addEventListener(self, EV_COURAGE.EV_MINIGAME_START, handler(self.onRecvGameStart, self))

    self.BtnClose:onClick(function()
        self:showResult(false)
    end)

    for k,v in ipairs(self.dir_) do
        v.btn:onClick(function()
            if self.isMove then
                return
            end
            if not self.gameParam then
                return
            end
            table.insert(self.tempResult,v.id)
            self:checkResult(k)
        end)
    end

end


return CourageDirGame
