local DalGame = class("DalGame", BaseLayer)

function DalGame:ctor(param)
    self.super.ctor(self)
    --self:showPopAnim(true)
    self:init("lua.uiconfig.dls.dalGame")
    self:initData(param)
end


function DalGame:initData(param)

    self.param = param
    self.gameCid = param.gameCid
    --self.options = param.options
    print(self.gameCid)
    local gameCfg = DalMapDataMgr:getDlsgameCfg(self.gameCid)
    if not gameCfg then
        return
    end

    self.Label_desc:setText(gameCfg.optionDesc)
    self.Label_title:setText(gameCfg.optionTitle)
    self.gameTypeParam = gameCfg.gameTypeParam
    self:initUILogic()
end

function DalGame:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui
    self.Image_mini = TFDirector:getChildByPath(self.ui, "Image_mini")
    self.Button_close = TFDirector:getChildByPath(self.Image_mini, "Button_close")
    self.Label_desc = TFDirector:getChildByPath(self.ui, "Label_desc")
    self.Label_title = TFDirector:getChildByPath(self.ui, "Label_title")
    self.options = {}
    for i=1,2 do
        local btn = TFDirector:getChildByPath(self.ui, "Button_choose"..i)
        local desc = TFDirector:getChildByPath(btn, "Label_chooseName")
        local Panel_money = TFDirector:getChildByPath(btn, "Panel_money")
        table.insert(self.options,{btn = btn, desc = desc, Panel_money = Panel_money})
    end

end

function DalGame:initUILogic()
    self:updateGameInfo()
end

function DalGame:updateGameInfo()

    local showCnt = 0
    for i=1,2 do
        local chooseParam = self.gameTypeParam[i]
        if not chooseParam then
            self.options[i].btn:setVisible(false)
        else
            self.options[i].btn:setVisible(true)
            showCnt = showCnt + 1
            local chooseStrTextId = chooseParam[2]
            local costId,costNum
            for k,v in pairs(chooseParam[1]) do
                costId = k
                costNum = v
                break
            end
            if costId and costNum then
                self.options[i].Panel_money:setVisible(true)
                local icon = TFDirector:getChildByPath(self.options[i].Panel_money, "icon")
                local num = TFDirector:getChildByPath(self.options[i].Panel_money, "num")
                local descText = TFDirector:getChildByPath(self.options[i].Panel_money, "Label_chooseName1")
                --descText:setTextById(chooseStrTextId)
                descText:setText("描述")
                num:setText(costNum)
                local itemCfg = GoodsDataMgr:getItemCfg(costId)
                if itemCfg then
                    icon:setTexture(itemCfg.icon)
                end
                self.options[i].desc:setText("")
            else
                self.options[i].desc:setTextById(chooseStrTextId)
                self.options[i].Panel_money:setVisible(false)
            end

            self.options[i].btn:onClick(function()
                local tab = {}
                tab[1] = i
                self:Send_gameResult(tab)
            end)
        end
    end

    if showCnt == 1 then
        self.options[1].btn:setPositionY(-110)
    else
        self.options[1].btn:setPositionY(-68)
    end
end

---点击选项回复
function DalGame:onReplyMiniGame(gameCid,awardList,options)

    local gameCfg =  DalMapDataMgr:getDlsgameCfg(gameCid)
    if not gameCfg then
        return
    end

    local replyType = options[1]
    local replyContent = options[2]
    
    if replyType == 1 then
        self:showFinalTaskDialog()
    elseif replyType == 2 then
        Utils:showTips(replyContent)
        self:showFinalTaskDialog()
    elseif replyType == 3 then
        Utils:openView("dalMap.DalMapFight",replyContent)
    elseif replyType == 4 then
        if awardList then
            Utils:showReward(awardList)
        end
        self:timeOut(function()
            self:showFinalTaskDialog()
        end,0.5)
    elseif replyType == 5 then
        local randomDialog = gameCfg.randomDialog
        local dialogIndex = math.random(1,#randomDialog)
        local dialogId = randomDialog[dialogIndex]
        if not dialogId then
            dialogId = replyContent
        end
        if dialogId > 0 then
            local function callback()
                KabalaTreeDataMgr:playStory(1,dialogId,function ()
                    local isFinishBossTask = DalMapDataMgr:isFinishBossTask()
                    local finalPlot = DalMapDataMgr:getFinalPlot()
                    if isFinishBossTask  then
                        if finalPlot ~= 0 then
                            KabalaTreeDataMgr:playStory(1,finalPlot,function ()
                                DalMapDataMgr:setBosstaskState(false)
                                EventMgr:dispatchEvent(EV_CG_END,function()
                                    DalMapDataMgr:showTaskAward(true)
                                end)
                            end)
                        else
                            DalMapDataMgr:setBosstaskState(false)
                            EventMgr:dispatchEvent(EV_CG_END,function()
                                DalMapDataMgr:showTaskAward(true)
                            end)
                        end
                    else
                        EventMgr:dispatchEvent(EV_CG_END)
                    end
                end)
            end
            KabalaTreeDataMgr:openCgView("kabalaTree.KabalaTreeCg",callback)
        end
    end
    AlertManager:closeLayer(self)
end

function DalGame:showFinalTaskDialog()

    local isFinishBossTask = DalMapDataMgr:isFinishBossTask()
    local finalPlot = DalMapDataMgr:getFinalPlot()
    if isFinishBossTask then
        if finalPlot ~= 0 then
            local function callback()
                KabalaTreeDataMgr:playStory(1,finalPlot,function ()
                    DalMapDataMgr:setBosstaskState(false)
                    EventMgr:dispatchEvent(EV_CG_END,function()
                        DalMapDataMgr:showTaskAward(true)
                    end)
                end)
            end
            KabalaTreeDataMgr:openCgView("kabalaTree.KabalaTreeCg",callback)
        else
            DalMapDataMgr:setBosstaskState(false)
            DalMapDataMgr:showTaskAward(true)
        end
    end
end

function DalGame:Send_gameResult(listTab)

    if not listTab then
        return
    end
    dump(listTab)
    TFDirector:send(c2s.OFFICE_EXPLORE_OFFICE_SUBMIT_GAME, {listTab})

end


function DalGame:registerEvents()

    EventMgr:addEventListener(self,EV_DAL_MAP.MiniGameReply,handler(self.onReplyMiniGame, self))

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

end
return DalGame