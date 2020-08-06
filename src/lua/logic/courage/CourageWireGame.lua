local CourageWireGame = class("CourageWireGame", BaseLayer)

function CourageWireGame:initData()
    self.isStart = false
    self.failureCnt = 0
    self.maxFailureCnt = 3
    self.goodsItem_ = {}
end

function CourageWireGame:ctor(eventCfg)
    self.super.ctor(self)

    self:initData()
    self.uiRes = eventCfg.gameRes or "courageWireGame"
    self.soundId = self.uiRes == "courageWireGame" and 5038 or 5039
    self:init("lua.uiconfig.courage."..self.uiRes)
end

function CourageWireGame:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close"):hide()
    self.Panel_game = TFDirector:getChildByPath(self.Panel_root, "Panel_game")
    local ScrollView_wire = TFDirector:getChildByPath(self.Panel_game, "ScrollView_wire")

    self.Panel_right = TFDirector:getChildByPath(self.Panel_game, "Panel_right"):hide()

    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
    self.wireItem_ = {}
    for i=1,5 do
        self.wireItem_[i] = TFDirector:getChildByPath(self.Panel_prefab, "Panel_wire_item_"..i)
    end
    self.Panel_wire_item = self.wireItem_[1]
    self.GridView_wire = UIGridView:create(ScrollView_wire)
    self.GridView_wire:setItemModel(self.Panel_wire_item)
    self.GridView_wire:setColumn(4)
    --self.GridView_wire:setColumnMargin(10)
    --self.GridView_wire:setRowMargin(10)

    self.Label_time = TFDirector:getChildByPath(self.Panel_root, "Label_time")
    self.Image_time = TFDirector:getChildByPath(self.Panel_root, "Image_time")
    CourageDataMgr:Send_StartGame(EC_CourageMiniGameType.WIRE)

end


function CourageWireGame:timeStart()
    local act = CCSequence:create({
        CCCallFunc:create(function()
            local curTime = ServerDataMgr:getServerTime()
            local remain = self.endTime - curTime
            self:setTime(remain)
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

function CourageWireGame:addGoodsItem()
    local item = self.GridView_wire:pushBackDefaultItem()
    local foo = {}
    foo.root = item
    foo.isTurn = false
    self.goodsItem_[item] = foo
    return item
end

function CourageWireGame:updateGoodsItem(item,data,id)
    local foo = self.goodsItem_[item]
    if not foo then
        item = self:addGoodsItem();
        foo = self.goodsItem_[item];
    end
    dump(data)

    local turnDgreeId = data[2]
    foo.isAnswer = turnDgreeId ~= 0

    local wireItem = foo.root:getChildByName("item")
    if not wireItem then
        local randomIndex = data[1]
        print(randomIndex)
        wireItem = self.wireItem_[randomIndex]:clone()
        wireItem:setName("item")
        wireItem:setPosition(ccp(0,0))
        local Image_bright = TFDirector:getChildByPath(wireItem, "Image_bright")
        if Image_bright then
            Image_bright:setVisible(false)
        end
        foo.root:addChild(wireItem)
    end
    foo.root:onClick(function()
        if foo.isTurn then
            return
        end
        if not self.gameEnd then
            foo.isTurn = true
            local act = CCSequence:create({
                CCRotateBy:create(0.2,-90),
                CCCallFunc:create(function()
                    local rotate = wireItem:getRotation()
                    rotate = rotate%(-360)
                    local dgreeId = self:getDgreeId(data[1],rotate)
                    self.dgreeId_[id] = turnDgreeId == 0 and 0 or dgreeId
                    foo.isTurn = false
                    self:checkResult()
                end)
            })
            wireItem:runAction(act)
        end
    end)
end

function CourageWireGame:getDgreeId(type_,rotate)
    if type_ == 1 or type_ == 3 then
        return 1
    elseif type_ == 2 then
        if rotate == 0 or rotate == -180 then
            return 1
        else
            return 2
        end
    else
        if rotate == 0 then
            return 1
        elseif rotate == -90 then
            return 2
        elseif rotate == -180 then
            return 3
        elseif rotate == -270 then
            return 4
        end
    end
end

function CourageWireGame:checkResult()

    local isSucceed = true
    for k,v in ipairs(self.result_) do
        if self.dgreeId_[k] ~= v then
            isSucceed = false
            break
        end
    end

    if isSucceed then
        CourageDataMgr:Send_GameResult(EC_CourageMiniGameType.WIRE,self.dgreeId_)
    end
end

function CourageWireGame:showResult(result)
    dump("CourageWireGame:"..tostring(result))
    if result == true then
        Utils:playSound(5038)
        self.Panel_right:setVisible(true)
        for k,v in pairs(self.goodsItem_) do
            if v.isAnswer then
                local item = TFDirector:getChildByPath(v.root, "item")
                local Image_bright = TFDirector:getChildByPath(item, "Image_bright")
                if Image_bright then
                    Image_bright:setVisible(true)
                end
            end
        end
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

function CourageWireGame:onRecvGameStart(gameParam)

    local gameId = gameParam[1]
    local gameCfg = CourageDataMgr:getGameCfg(gameId)
    if not gameCfg then
        Box("wrong gameId")
        return
    end
    dump(gameCfg)
    self.endTime = gameCfg.time + ServerDataMgr:getServerTime()
    self:setTime(gameCfg.time)
    self.gameEnd = false
    self.dgreeId_ = {}
    self.result_ = {}
    for k,v in ipairs(gameCfg.demand) do
        local item = self.GridView_wire:getItem(k)
        if not item then
            item = self:addGoodsItem()
        end
        self:updateGoodsItem(item,v,k)
        self.dgreeId_[k] = v[2] == 0 and 0 or 1
        self.result_[k] = v[2]
    end
    self:timeStart()
end

function CourageWireGame:onRecvGameFinish(data)
    dump("CourageWireGame onRecvGameFinish:"..tostring(data.success))
    self:showResult(data.success)
end

function CourageWireGame:setTime(remain)
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

function CourageWireGame:registerEvents()

    EventMgr:addEventListener(self, EV_COURAGE.EV_MINIGAME_START, handler(self.onRecvGameStart, self))
    EventMgr:addEventListener(self, EV_COURAGE.EV_MINIGAME_FINISH, handler(self.onRecvGameFinish, self))

    self.Button_close:onClick(function()
        self:showResult(false)
    end)

end


return CourageWireGame
