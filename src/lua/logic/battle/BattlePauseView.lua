local enum          = import(".enum")
local statistics    = import(".Statistics")
local BattleUtils   = import(".BattleUtils")
local victoryDecide = import(".VictoryDecide")
local eEvent        = enum.eEvent
local eBFAddType    = enum.eBFAddType
local ResLoader     = import(".ResLoader")
local PauseView     = class("PauseView", BaseLayer)

function PauseView:initData(data)
    self.levelCid_ = BattleDataMgr:getPointId()
    self.levelCfg_ = BattleDataMgr:getLevelCfg()
    self.data_ = data
end

function PauseView:ctor(data)
    self.super.ctor(self, data)
    self:initData(data)
    self:init("lua.uiconfig.battle.pauseView")
end

function PauseView:initUI(ui)
	self.super.initUI(self, ui)
    self.Button_set   = TFDirector:getChildByPath(ui, "Button_set")
    self.Panel_pause   = TFDirector:getChildByPath(ui, "Panel_pause")
    -- self.Panel_a   = TFDirector:getChildByPath(ui, "Panel_a")
    self.Button_resume = TFDirector:getChildByPath(self.Panel_pause, "Button_resume")
    self.Button_exit   = TFDirector:getChildByPath(self.Panel_pause, "Button_exit")
    self.Button_show_task = TFDirector:getChildByPath(self.Panel_pause, "Button_show_task"):hide()
    --
    self.Button_reopen = TFDirector:getChildByPath(self.Panel_pause, "Button_reopen"):hide()

    self.Label_dian1   = TFDirector:getChildByPath(self.Panel_pause, "Label_dian1")
    self.Label_dian2   = TFDirector:getChildByPath(self.Panel_pause, "Label_dian2")
    --章节名称
    self.Label_title   = TFDirector:getChildByPath(self.Panel_pause, "Label_title")


    self.Label_dian1:setText(TextDataMgr:getText(300835))
    self.Label_dian2:setText(TextDataMgr:getText(300836))

    self.Image_challenge = TFDirector:getChildByPath(self.Panel_pause, "Image_challenge")
    self.Panel_item = {}
    for i = 1, 3 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(self.Panel_pause, "Panel_item" .. i):hide()
        foo.star = TFDirector:getChildByPath(foo.root, "Image_star")
        foo.starGray = TFDirector:getChildByPath(foo.root, "Image_star_gray")
        foo.tip1 = TFDirector:getChildByPath(foo.root, "Label_tip1")
        foo.tip2 = TFDirector:getChildByPath(foo.root, "Label_tip2")
        self.Panel_item[i] = foo

        if self.levelCfg_.dungeonType == EC_FBLevelType.HWX then
            foo.star:setTexture("ui/hwx/map/023.png")
            foo.starGray:setTexture("ui/hwx/map/022.png")
        end
    end

    if self.levelCfg_.dungeonType == EC_FBLevelType.SPRITE 
        or self.levelCfg_.dungeonType == EC_FBLevelType.HUNTER
        or self.levelCfg_.dungeonType == EC_FBLevelType.TXJZ then
        self.Image_challenge:hide()
    else
        self.Image_challenge:show()
    end

    self.Button_reopen:setVisible(self.levelCfg_.dungeonType == EC_FBLevelType.ENDLESS_PLUSS )

    local name = FubenDataMgr:getLevelName(self.levelCfg_.id)
    self.Label_title:setText(name)

    --关卡胜利条件
    --local victoryDecide = battleController.getVictoryDecide()
    local panelVictory  = self.Panel_pause:getChildByName("Panel_victory")
    local victoryCfgs  = victoryDecide.getData()
    panelVictory:setVisible(#victoryCfgs > 0)
    self.nodeTips = {}
    self.nodeTips[1]   = panelVictory:getChildByName("Label_tip1"):hide()
    self.nodeTips[2]   = panelVictory:getChildByName("Label_tip2"):hide()
    for index, victoryCfg in ipairs(victoryCfgs) do
        dump(self.levelCid_)
        local text =  FubenDataMgr:getPassCondDesc(self.levelCid_, index)
        self.nodeTips[index]:setText(text)
        self.nodeTips[index]:show()
    end

    if self.Image_challenge:isVisible() then
        --关卡挑战
        if self.levelCfg_.dungeonType == EC_FBLevelType.TXJZ then
        elseif self.levelCfg_.dungeonType == EC_FBLevelType.SKYLADDER then
            self:showSkyLadderInfo()
        elseif self.levelCfg_.dungeonType == EC_FBLevelType.MUSIC_GAME then
            self:showMusicGameInfo()
        else
            self:showNormalInfo()
        end
    end
    self.Pane_prefab = TFDirector:getChildByPath(ui, "Pane_prefab_item")
    local ScrollView_buffer = TFDirector:getChildByPath(self.Panel_pause, "ScrollView_buffer")
    self.listView = UIListView:create(ScrollView_buffer)
    -- self.listView:setItemsMargin(0)
    local hero = battleController.getCaptain()
    if hero then 
        local bufferEffects = hero:getEffectingBufferEffect()
        for i,bufferEffect in ipairs(bufferEffects) do
            local data = bufferEffect:getData()
            if data.duration ~= 0 and data.iconDisplay then 
                local node = self:createItem(bufferEffect)
                self.listView:pushBackCustomItem(node)
            end
        end
    end
end

function PauseView:createItem(effect)
    local item        = self.Pane_prefab:clone()
    item:show()
    local Image_icon  = TFDirector:getChildByPath(item, "Image_icon")
    local Label_num   = TFDirector:getChildByPath(item, "Label_num")
    Label_num:setSkewX(15)
    local Label_desc  = TFDirector:getChildByPath(item, "Label_desc")
    local Image_time1 = TFDirector:getChildByPath(item, "Image_time1")
    local Image_time2 = TFDirector:getChildByPath(item, "Image_time2")
    local Label_time  = TFDirector:getChildByPath(Image_time1, "Label_time")
    local data = effect:getData()
    if data.duration  == -1 then 
        Image_time2:show()
        Image_time1:hide()
    elseif data.duration  > 0 then
        Image_time1:show()
        Image_time2:hide()
        local time = effect:getSuplusTime()*0.001 --换算苗
        Label_time:setText(string.format("%.2fs",time))
    end
    if ResLoader.isValid(data.icon) then 
        Image_icon:show()
        Image_icon:setTexture(data.icon)
    else
        Image_icon:hide()
    end
    if effect.nAddTimes > 1 then 
        Label_num:show()
        Label_num:setTextById(302201,effect.nAddTimes)
    else
        Label_num:hide()
    end
    if data.iconDes then 
        Label_desc:setTextById(data.iconDes)
    else
        Label_desc:setText("bufferEffect "..data.id.." 没有配置效果描述")
    end
    return item
end

function PauseView:showNormalInfo()
    local starCfg = BattleDataMgr:getBattleData().starCfg
    local index = 1
    for i, starInfo in ipairs(starCfg) do
        local isReach = statistics.getStarIsReach(i)
        local starType = starInfo.starType
        local node  = self.Panel_pause:getChildByName("Panel_item"..index)
        if node then

        node:show()
        local label_tip1 = node:getChildByName("Label_tip1")
        local label_tip2 = node:getChildByName("Label_tip2")
        local curValue   = statistics.getStarRuleValue(starType,starInfo.starParam) or 0
        local starDescribe = EC_FBStarRuleStr[starType]
        local desc = FubenDataMgr:getStarRuleDesc(self.levelCid_, starInfo.pos)
        label_tip1:setText(desc)
        local condRule1, condRule2, condRule3, condRule4, condRule5 = statistics.getAllCondStarType()
        if table.indexOf(condRule1, starType) ~= -1 then
            if isReach then
                label_tip2:setText(string.format("[%s/%s]", curValue, starInfo.starParam))
            else
                label_tip2:setTextById(100000008)
            end
            node:setGrayEnabled(true)
        elseif table.indexOf(condRule2, starType) ~= -1 then
            if isReach then
                label_tip2:setTextById(100000007)
            else
                label_tip2:setTextById(100000009)
            end
            node:setGrayEnabled(not isReach)
        elseif table.indexOf(condRule3, starType) ~= -1 then
            if isReach then
                label_tip2:setTextById(100000007)
            else
                label_tip2:setText(string.format("[%s/%s]", curValue, starInfo.starParam))
            end
            node:setGrayEnabled(not isReach)
        elseif table.indexOf(condRule4, starType) ~= -1 then
            if isReach then
                label_tip2:setTextById(100000007)
            else
                label_tip2:setTextById(100000008)
            end
            node:setGrayEnabled(not isReach)
        elseif table.indexOf(condRule5, starType) ~= -1 then
            if isReach then
                label_tip2:setTextById(100000009)
            else
                label_tip2:setTextById(100000008)
            end
            node:setGrayEnabled(true)
        end
        
        end
        index = index + 1
    end
end

function PauseView:showSkyLadderInfo()
    self.Label_dian2:setTextById(3202048)
    local cfg = SkyLadderDataMgr:getRankMatchLevelCfg(self.levelCfg_.id)
    if cfg then
        self.Panel_item[1].root:setVisible(true)
        self.Panel_item[1].star:setVisible(false)
        self.Panel_item[1].starGray:setVisible(false)
        self.Panel_item[1].tip1:setTextById(3202049)
        self.Panel_item[1].tip2:setText(cfg.passRate)

        if cfg.timeRate > 0 then
            local curTime = statistics.getStarRuleValue(EC_FBStarRule.TIME)
            local remainTime = self.levelCfg_.time - curTime
            remainTime = remainTime > 0 and remainTime or 0
            local rate = math.floor(cfg.timeRate*remainTime)
            self.Panel_item[2].root:setVisible(true)
            self.Panel_item[2].star:setVisible(false)
            self.Panel_item[2].starGray:setVisible(false)
            self.Panel_item[2].tip1:setTextById(3202050)
            self.Panel_item[2].tip2:setText(rate)
            dump({self.levelCfg_.time,cfg.timeRate,curTime,rate})
        end
    end
end

function PauseView:showMusicGameInfo()
    TFDirector:getChildByPath(self.Panel_pause, "Panel_b"):hide()
    TFDirector:getChildByPath(self.Panel_pause, "Image_challenge"):hide()
    self.Label_dian1:setText("成功率")
    local rate = math.floor(self.data_.myPoints/self.data_.points*100)
    local desc = rate.."%".."  ---  ".."(已完成"..self.data_.success.."/"..self.data_.maxround..")"
    self.nodeTips[1]:setText(desc)

    -- self.Panel_item[1].root:setVisible(true)
    -- self.Panel_item[1].star:setVisible(false)
    -- self.Panel_item[1].starGray:setVisible(true)
    -- self.Panel_item[1].tip1:setText("成功率达到90%")
    -- self.Panel_item[1].tip2:hide()

    -- self.Panel_item[2].root:setVisible(true)
    -- self.Panel_item[2].star:setVisible(false)
    -- self.Panel_item[2].starGray:setVisible(true)
    -- self.Panel_item[2].tip1:setText("成功率达到75%")
    -- self.Panel_item[2].tip2:hide()

    -- self.Panel_item[3].root:setVisible(true)
    -- self.Panel_item[3].star:setVisible(false)
    -- self.Panel_item[3].starGray:setVisible(true)
    -- self.Panel_item[3].tip1:setText("成功率达到50%")
    -- self.Panel_item[3].tip2:hide()
end

function PauseView:registerEvents()
    self.Button_resume:addMEListener(TFWIDGET_CLICK, function()
            EventMgr:dispatchEvent(eEvent.EVENT_RESUME)
            AlertManager:closeLayer(self)
        end)
    self.Button_exit:addMEListener(TFWIDGET_CLICK, function()

        if self.levelCfg_.dungeonType == EC_FBLevelType.ENDLESS_PLUSS then
            FubenEndlessPlusDataMgr:Send_ExitChallenge()
        end
        EventMgr:dispatchEvent(eEvent.EVENT_LEAVE)
        AlertManager:closeLayer(self)
    end)

    self.Button_reopen:addMEListener(TFWIDGET_CLICK, function()
        FubenDataMgr:setReopenFlag(true)
        EventMgr:dispatchEvent(eEvent.EVENT_LEAVE)
        AlertManager:closeLayer(self)
    end)

    self.Button_set:addMEListener(TFWIDGET_CLICK, function()
            --EventMgr:dispatchEvent(eEvent.EVENT_LEAVE)
            --AlertManager:closeLayer(self)
            BattleUtils:openView("settings.SettingsView")
        end)

    self.Button_show_task:addMEListener(TFWIDGET_CLICK, function()
            Utils:openView("league.LeagueTrainingTaskView", false)
        end)
end

return PauseView
