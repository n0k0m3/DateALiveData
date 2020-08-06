local KabalaTreeGame = class("KabalaTreeGame", BaseLayer)

function KabalaTreeGame:ctor(param)
    self.super.ctor(self)
    --self:showPopAnim(true)
    self:init("lua.uiconfig.kabalaTree.kabalaTreeGame")
    self:initData(param)
end


function KabalaTreeGame:initData(param)

    self.param = param

    self.gameCid = param.gameCid
    self.options = param.options

    self.kabalaDiceCfg = TabDataMgr:getData("KabalaDiceButton")
    self.gameCfg = KabalaTreeDataMgr:getKabalaGameCfg(self.gameCid)
    if not self.gameCfg then
        return
    end

    self.gameType = self.gameCfg.gameType


    --[[Enum_TriggerGameType = {
        WiseCube = 1001,        --智者魔方
        ChipGame = 1002,        --博弈筹码
        Forgotton = 1003,       --遗忘残迹
        Dice = 1004,            --卡巴拉之骰
        Divination = 1005,      --占卜之源
    }]]

    self:initUILogic()
end

function KabalaTreeGame:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui

    self.Image_mini = TFDirector:getChildByPath(self.ui, "Image_mini"):hide()
    self.Button_close = TFDirector:getChildByPath(self.Image_mini, "Button_close")
    self.Panel_Divination = TFDirector:getChildByPath(self.ui, "Panel_Divination"):hide()
    self.Divination_title = TFDirector:getChildByPath(self.Panel_Divination, "Label_title")
    self.Label_desc = TFDirector:getChildByPath(self.Panel_Divination, "Label_desc")
    self.Label_effect_desc = TFDirector:getChildByPath(self.Panel_Divination, "Label_effect_desc")
    self.Image_buff = TFDirector:getChildByPath(self.Panel_Divination, "Image_buff")
    self.Label_effect = TFDirector:getChildByPath(self.Panel_Divination, "Label_effect")
    self.Button_DivinationOk = TFDirector:getChildByPath(self.Panel_Divination, "Button_ok")
    self.Button_DivinationBuy = TFDirector:getChildByPath(self.Panel_Divination, "Button_buy")
    self.Divination_text = TFDirector:getChildByPath(self.Panel_Divination, "Label_text")
    self.Image_DivinationCost = TFDirector:getChildByPath(self.Panel_Divination, "Image_cost")
    self.Label_DivinationCost = TFDirector:getChildByPath(self.Panel_Divination, "Label_cost")
    self.Label_free = TFDirector:getChildByPath(self.Panel_Divination, "Label_free")

    self.Panel_WiseCube = TFDirector:getChildByPath(self.ui, "Panel_WiseCube"):hide()
    self.Panel_ChipGame = TFDirector:getChildByPath(self.ui, "Panel_ChipGame"):hide()
    self.Panel_Forgotton = TFDirector:getChildByPath(self.ui, "Panel_Forgotton"):hide()

    self.Panel_dice = TFDirector:getChildByPath(self.ui, "Panel_dice"):hide()
    self.diceTitle = TFDirector:getChildByPath(self.Panel_dice, "Label_title")
    self.Button_dice_close = TFDirector:getChildByPath(self.Panel_dice, "Button_dice_close")
    self.Label_dice = TFDirector:getChildByPath(self.Panel_dice, "Label_dice")
    self.Label_dice:setTextById(3004112)
    self.diceOptions = {}
    for i=1,6 do
        local btn = TFDirector:getChildByPath(self.Panel_dice, "Button_dice_options_"..i)
        local desc = TFDirector:getChildByPath(btn, "Label_Name")
        local icon = TFDirector:getChildByPath(btn, "Image_dice_icon")
        table.insert(self.diceOptions,{btn = btn, desc = desc, icon = icon})
    end
    self.Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab")


    self.panelInfo = {
        [Enum_TriggerGameType.WiseCube] = self.Panel_WiseCube,
        [Enum_TriggerGameType.ChipGame] = self.Panel_ChipGame,
        [Enum_TriggerGameType.Forgotton] = self.Panel_Forgotton,
        [Enum_TriggerGameType.Dice] = self.Panel_dice,
        [Enum_TriggerGameType.Divination] = self.Panel_Divination,
    }
end

function KabalaTreeGame:initUILogic()

    self.panelInfo[self.gameType]:setVisible(true)
    self.Image_mini:setVisible(self.gameType ~= Enum_TriggerGameType.Dice)
    
    self:updateGameInfo()
end

function KabalaTreeGame:updateGameInfo()

    if self.gameType == Enum_TriggerGameType.Dice then
        self:updateGameDice()
    elseif self.gameType == Enum_TriggerGameType.Divination then
        self:updateGameDivination()
    end
    
end

-------- 卡巴拉之骰 -------------
function KabalaTreeGame:updateGameDice()

    self.answerList = {}
    self.clickCnt = 0
    self.diceTitle:setTextById(3003023)
    dump(self.options)
    self.newOptions = self:shuffle(clone(self.options))
    --dump(self.newOptions)
    for i=1,6 do
        if not self.newOptions[i] then
            self.diceOptions[i].btn:setVisible(false)
        else
            local diceInfo = self.kabalaDiceCfg[self.newOptions[i]]
            if diceInfo then
                self.diceOptions[i].btn:setVisible(true)
                self.diceOptions[i].desc:setTextById(diceInfo.buttonName)
                self.diceOptions[i].icon:setTexture(diceInfo.buttonDocument)
                self.diceOptions[i].btn:onClick(function()
                    self:clickOptions(i)
                end)
            end
        end
    end
end

function KabalaTreeGame:clickOptions(i)

    dump(self.options)
    self.clickCnt = self.clickCnt + 1
    print(self.newOptions[i],self.options[self.clickCnt])
    --rigth
    if self.newOptions[i] == self.options[self.clickCnt] then
        self.diceOptions[i].btn:setTouchEnabled(false)
        self.diceOptions[i].btn:setGrayEnabled(true)
        table.insert(self.answerList,self.newOptions[i])
        if self.clickCnt == 6 then
            self:Send_gameResult(self.answerList)
        end
    else
        for i=1,6 do
            self.diceOptions[i].btn:setTouchEnabled(true)
            self.diceOptions[i].btn:setGrayEnabled(false)
        end
        if self.clickCnt == 1 then
            Utils:showTips(3004113)
        else
            Utils:showTips(3004114)
        end
        self.clickCnt = 0
        self.answerList = {}
    end
end

--打乱数组
function KabalaTreeGame:shuffle(t)
    if type(t)~="table" then
        return
    end
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

-------- 占卜之源 -------------
function KabalaTreeGame:updateGameDivination()
    dump(self.options)
    self.usedCnt = self.options[1]
    self.buffCid = self.options[2]
    if not self.usedCnt or not self.buffCid then
        return
    end

    self.Divination_title:setTextById(3003024)
    self.Label_desc:setTextById(3004115)

    local buffInfo = KabalaTreeDataMgr:getBuffCfgInfo(self.buffCid)
    if buffInfo.timerType == 2 then
        local str = TextDataMgr:getText(3004043,buffInfo.timerTypeParam)
        self.Label_effect:setText(str)
    else
        self.Label_effect:setTextById(3004042)
    end

    local itemCfg = GoodsDataMgr:getItemCfg(self.buffCid)
    if not itemCfg then
        return
    end
    self.Label_effect_desc:setTextById(itemCfg.desTextId)

    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    Panel_goodsItem:setScale(1.1)
    PrefabDataMgr:setInfo(Panel_goodsItem, self.buffCid)

    Panel_goodsItem:setPosition(ccp(0,0))
    Panel_goodsItem:setTouchEnabled(true)
    Panel_goodsItem:onClick(function()
        Utils:showInfo(self.buffCid)
    end)
    self.Image_buff:addChild(Panel_goodsItem)
    self.Image_buff:setTexture("")

    --消耗
    local cnt = #self.gameCfg.gameTypeParam.answer
    local str = TextDataMgr:getText(3004052,self.usedCnt.."/"..cnt)
    self.Divination_text:setText(str)
    local costInfo = self.gameCfg.gameTypeParam.answer[self.usedCnt+1]
    if not costInfo then
        self.Button_DivinationBuy:setTouchEnabled(false)
        self.Button_DivinationBuy:setGrayEnabled(true)
        self.Label_free:setTextById(303041)
        self.Image_DivinationCost:setVisible(false)
        self.Label_DivinationCost:setText("")
        return
    end

    for k,v in pairs(costInfo) do
        self.costId = k
        self.costNum = v
        break
    end

    --免费
    if not self.costId then
        self.Image_DivinationCost:setVisible(false)
        self.Label_DivinationCost:setText("")
        self.Label_free:setTextById(3004050)
        self.Button_DivinationBuy:setTouchEnabled(true)
        self.Button_DivinationBuy:setGrayEnabled(false)
    else
        self.Label_free:setText("")
        local itemCfg = GoodsDataMgr:getItemCfg(self.costId)
        if not itemCfg then
            return
        end
        self.Image_DivinationCost:setVisible(true)
        self.Image_DivinationCost:setTexture(itemCfg.icon)
        self.Label_DivinationCost:setText(self.costNum)

        local isEnought = GoodsDataMgr:currencyIsEnough(self.costId,self.costNum)
        self.Button_DivinationBuy:setTouchEnabled(isEnought)
        self.Button_DivinationBuy:setGrayEnabled(not isEnought)
    end

end

function KabalaTreeGame:Send_gameResult(listTab)

    if not listTab then
        return
    end
    dump(listTab)
    TFDirector:send(c2s.QLIPHOTH_SUBMIT_GAME, {listTab})
end

---点击选项回复
function KabalaTreeGame:onReplyMiniGame(gameCid,awardList,options)

    local gameCfg = KabalaTreeDataMgr:getKabalaGameCfg(gameCid)
    if not gameCfg then
        return
    end

    local gameType = gameCfg.gameType
    if gameType == Enum_TriggerGameType.Dice then
        if awardList then
            Utils:showReward(awardList)
        end
        AlertManager:closeLayer(self)
    elseif gameType == Enum_TriggerGameType.Divination then

        if not options then
            return
        end

        --确定
        if #options == 1 then
            Utils:openView("kabalaTree.KabalaTreeAwardBuff",options[1])
            AlertManager:closeLayer(self)
        else
            self.options = options
            self:updateGameDivination()
        end
    end
end

function KabalaTreeGame:registerEvents()

    EventMgr:addEventListener(self,EV_REPLY_MINIGAME,handler(self.onReplyMiniGame, self))

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_dice_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_DivinationOk:onClick(function()
        self:Send_gameResult({1})
    end)

    self.Button_DivinationBuy:onClick(function()
        self:Send_gameResult({})
    end)
end

return KabalaTreeGame