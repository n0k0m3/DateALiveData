TeamPveMainView = class("TeamPveMainView",BaseLayer)

function TeamPveMainView:ctor()
    self.super.ctor(self)
    self:initData()
    local showType = Utils:getKVP(61003,"uiType") or ""
    self:init("lua.uiconfig.teamFight.teamPveMainView"..showType)
end

function TeamPveMainView:initData()
    self.modelId = Utils:getKVP(61003,"model")

    FubenDataMgr:cacheSelectChapter(EC_ActivityFubenType.TEAM_PVE)
    FubenDataMgr:cacheSelectFubenType(EC_FBType.ACTIVITY)
end

function TeamPveMainView:onShow()
    self.super.onShow(self)
    local UserDefalt = CCUserDefault:sharedUserDefault()
    local datingId = Utils:getKVP(61003,"guideDating")
    if datingId then
        local isDating = UserDefalt:getStringForKey("isDating"..MainPlayer:getPlayerId().."datingId"..datingId)
        if isDating ~= "true" then
            UserDefalt:setStringForKey("isDating"..MainPlayer:getPlayerId().."datingId"..datingId,"true")
            FunctionDataMgr:jStartDating(datingId)
        end
    end
    self:initLive2d()
end

function TeamPveMainView:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Button_store = TFDirector:getChildByPath(self.Panel_root, "Button_store")
    self.Node_role = TFDirector:getChildByPath(self.Panel_root, "Node_role")

    self.cellItem = TFDirector:getChildByPath(self.Panel_root, "Panel_levelClone")
    local ScrollView_Dungeon= TFDirector:getChildByPath(self.Panel_root, "ScrollView_Dungeon")
    self.ListView_Dungeon = UIListView:create(ScrollView_Dungeon)
    --self.ListView_Dungeon:setItemsMargin(10)

    EventMgr:dispatchEvent(EV_HIDE_MAIN_LIVE2D)
    --self:initLive2d()

    self:updateDungeonList()

end

function TeamPveMainView:initLive2d()

    if self.elvesRole then
        self.elvesRole:stopAllActions()
        self.elvesRole:removeFromParent()
        self.elvesRole = nil

        if self.timeOutTimer or self.timeOutTimer_1 then
            self:stopAllActions()
        end
    end

    self.elvesRole = ElvesNpcTable:createLive2dNpcID(self.modelId,false,false,nil,false).live2d
    self.elvesRole.touchNode.isCloseTouchFollow = true
    self.elvesRole:registerEvents()
    self.Node_role:addChild(self.elvesRole)

    local dressAiId= Utils:getKVP(61003,"AI")
    if not dressAiId then
        return
    end
    local config = TabDataMgr:getData("DressAI", dressAiId)
    if not config then
        return
    end
    local index = math.random(1,#config.action)
    local waitFirstTimeIndex = math.random(1,#config.timeRandomFirst)
    local actionName = config.action[index]
    local firstTime = config.timeRandomFirst[waitFirstTimeIndex]

    function circleFunc(  )
        local secondTimeIndex = math.random(1,#config.timeRandom)
        local secondActIndex = math.random(1,#config.action)
        local secondTime = config.timeRandom[secondTimeIndex]
        local actionName2 = config.action[secondActIndex]
        self.timeOutTimer_1 = self:timeOut(function()
            if self.elvesRole then
                local currentScene = Public:currentScene()
                if currentScene then
                    if self == currentScene:getTopLayer() then
                        self.elvesRole:newStartAction(actionName2,EC_PRIORITY.FORCE)
                    end
                end
            end
            self.timeOutTimer_1 = nil
            circleFunc( )
        end,secondTime)
    end
    self.timeOutTimer =  self:timeOut(function()
        if self.elvesRole then
            self.elvesRole:newStartAction(actionName,EC_PRIORITY.FORCE)
        end
        circleFunc()
        self.timeOutTimer = nil
    end,firstTime)

end

function TeamPveMainView:updateDungeonList()

    self.ListView_Dungeon:removeAllItems()
    local dungeonCfg = TeamPveDataMgr:getTrainDungeonCfg()
    local trainChapterInfo = TeamPveDataMgr:getTrainChapterInfo()

    for k,v in ipairs(dungeonCfg) do
        local trainChapterData = trainChapterInfo[k]
        if trainChapterData then
            local dungeonItem = self.cellItem:clone()
            dungeonItem:setVisible(true)

            local Button_level = TFDirector:getChildByPath(dungeonItem, "Button_level")
            Button_level:setTextureNormal(v.pic)

            local lineImg = TFDirector:getChildByPath(dungeonItem, "Image_line")
            lineImg:setTexture(v.titlepic)

            local Label_name = TFDirector:getChildByPath(dungeonItem, "Label_name")
            Label_name:setTextById(v.capter)

            local startTime = Utils:getTimeData(trainChapterData.startTime)
            local endTime = Utils:getTimeData(trainChapterData.endTime)
            local Label_time = TFDirector:getChildByPath(dungeonItem, "Label_time")
            Label_time:setTextById(111000123, startTime.Month, startTime.Day, endTime.Month, endTime.Day)

            local isOpen = trainChapterData.isOpen
            local lockImg = TFDirector:getChildByPath(dungeonItem, "Image_lock")
            lockImg:setVisible(not isOpen)

            self.ListView_Dungeon:pushBackCustomItem(dungeonItem)

            Button_level:onClick(function()
                if not isOpen then
                    Utils:showTips(2101815)
                    return
                end
                TeamPveDataMgr:openLevelView(k)
            end)
            lockImg:setTouchEnabled(true)
            lockImg:onClick(function()
                Utils:showTips(2101815)
            end)
        end
    end

end

function TeamPveMainView:updateListInfo()
    self:updateDungeonList()
end

function TeamPveMainView:registerEvents()

    EventMgr:addEventListener(self, EV_TEAMPVE_UPDATE_INFO, handler(self.updateListInfo, self))
    self.Button_store:onClick(function()
        Utils:openView("store.StoreMainView", 205000)
    end)
end

return TeamPveMainView