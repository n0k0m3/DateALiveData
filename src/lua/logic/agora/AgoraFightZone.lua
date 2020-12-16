local AgoraFightZone = class("AgoraFightZone", BaseLayer)

function AgoraFightZone:ctor()
    self.super.ctor(self)
    self:initData()
    self:init("lua.uiconfig.agora.agoraFightZone")
end

function AgoraFightZone:initData()

    self.chapterMode = {}

end

function AgoraFightZone:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui

    self.Panel_root = TFDirector:getChildByPath(self.ui, "Panel_root")
    self.Panel_levels = TFDirector:getChildByPath(self.ui, "Panel_levels")
    self.Panel_level_model = TFDirector:getChildByPath(self.Panel_levels, "Panel_level_model"):hide()
    self.Panel_randomItem = TFDirector:getChildByPath(self.Panel_levels, "Panel_randomItem"):hide()
    self.Panel_box = TFDirector:getChildByPath(self.ui, "Panel_box")
    self:updateUILogic()

end

function AgoraFightZone:onShow()

    self.super.onShow(self)
    self:playPlotDialogue()
end

function AgoraFightZone:playPlotDialogue()

    if self.playing then
        return
    end

    local topLayer = AlertManager:getTopLayer()
    if topLayer and topLayer.__cname ~= "AgoraFightZone" then
        return
    end

    local openTimes = AgoraDataMgr:getLevelOpenTime()
    if not openTimes then
        return
    end

    local cfgId,isEnemy,playTime
    local serverTime = ServerDataMgr:getServerTime()
    for k,info in ipairs(openTimes) do
        if serverTime >= info.time then
            cfgId = info.id
            isEnemy = info.isEnemy
            playTime = info.time
        else
            break
        end
    end

    if not cfgId then
        return
    end

    local cfg
    if isEnemy then
        cfg = AgoraDataMgr:getInvadeCfgInfo(cfgId)
    else
        cfg = AgoraDataMgr:getChapterCfgInfo(cfgId)
    end

    if not cfg then
        return
    end

    local groupId = cfg.dialogID
    local saveId = isEnemy and "enemy_"..cfgId or "normal_"..cfgId
    local isPlayed = AgoraDataMgr:isPlayedPlot(saveId)
    if isPlayed then
        return
    end

    if groupId == 0 then
        return
    end
    self.playing = true
    AgoraDataMgr:savePlotDialogue(saveId,playTime)
    local function callback()
        KabalaTreeDataMgr:playStory(1,groupId,function ()
            self.playing = false
            EventMgr:dispatchEvent(EV_CG_END)
        end)
    end
    KabalaTreeDataMgr:openCgView("kabalaTree.KabalaTreeCg",callback)
end

function AgoraFightZone:updateUILogic()

    self:initChapterItem()
    self:updateRandomItem()

    local seqact = Sequence:create({
        DelayTime:create(1),
        CallFunc:create(function()
            self:updateChapterItem()
        end)
    })
    self.Panel_root:runAction(CCRepeatForever:create(seqact))
end

function AgoraFightZone:updateChapterItem()

    local chapterCfg = AgoraDataMgr:getChapterCfgInfo()
    for k,v in pairs(chapterCfg) do

        local isOpen,openTime = AgoraDataMgr:chapterIsOpen(v.id)
        if self.chapterMode[k] and self.chapterMode[k].mode then
            local levelModel = self.chapterMode[k].mode
            local Image_lock = levelModel:getChildByName("Image_close")
            Image_lock:setVisible(not isOpen)

            local isInvaded = AgoraDataMgr:isInvadeChapter(v.id)
            local Image_open = levelModel:getChildByName("Image_open")
            Image_open:setVisible(isOpen and (not isInvaded))

            local Image_invade = levelModel:getChildByName("Image_invade")
            Image_invade:setVisible(isInvaded)

            local Image_item = levelModel:getChildByName("Image_item")
            Image_item:setGrayEnabled(not isOpen)
            Image_item:setVisible(not isOpen)

            if isOpen then
                self:playPlotDialogue()
            end
        end
    end
end

--刷新章节信息
function AgoraFightZone:initChapterItem()

    local lastOpenId
    local chapterCfg = AgoraDataMgr:getChapterCfgInfo()
    for k,v in ipairs(chapterCfg) do

        local position = ccp(v.pos[1],v.pos[2])
        local levelModel = self.Panel_levels:getChildByName("levelModel"..k)
        if not levelModel then
            levelModel = self.Panel_level_model:clone()
            levelModel:setVisible(true)
            levelModel:setPosition(position)
            levelModel:setName("levelModel"..k)
            levelModel:setZOrder(10-k)
            self.Panel_levels:addChild(levelModel)
        end

        --入侵
        local isInvaded = AgoraDataMgr:isInvadeChapter(v.id)
        local Image_invade = levelModel:getChildByName("Image_invade")
        local Label_name = Image_invade:getChildByName("Label_name")
        Label_name:setTextById(v.name)
        Image_invade:setVisible(isInvaded)

        --解锁
        local isOpen,openTime = AgoraDataMgr:chapterIsOpen(v.id)
        local Image_lock = levelModel:getChildByName("Image_close")
        Image_lock:setVisible(not isOpen)
        local Label_name = Image_lock:getChildByName("Label_name")
        Label_name:setTextById(v.name)

        local Image_open = levelModel:getChildByName("Image_open")
        Image_open:setVisible(isOpen and (not isInvaded))
        local Label_name = Image_open:getChildByName("Label_name")
        Label_name:setTextById(v.name)

        local Image_item = levelModel:getChildByName("Image_item")
        Image_item:setTexture(v.pic)
        Image_item:setGrayEnabled(not isOpen)
        Image_item:setVisible(not isOpen)
        local itemPos = ccp(v.skewingPos[1],v.skewingPos[2])
        Image_item:setPosition(itemPos)

        local Button_item = levelModel:getChildByName("Button_item")
        Button_item:setTextureNormal(v.pic)
        local itemPos = ccp(v.skewingPos[1],v.skewingPos[2])
        Button_item:setPosition(itemPos)

        local chooseImge = levelModel:getChildByName("Image_choose"):hide()
        if isOpen then
            lastOpenId = k
        end

        self.chapterMode[k] = {btn = Button_item,chapterId = v.id,chooseImge = chooseImge}
    end

    --[[if lastOpenId then
        self.chooseImge = self.chapterMode[lastOpenId].chooseImge
        self.chapterMode[lastOpenId].chooseImge:show()
    end]]

end

function AgoraFightZone:updateRandomItem()

    local mapBoxes = AgoraDataMgr:getMapBox()
    if not mapBoxes then
        return
    end

    for k,v in ipairs(mapBoxes) do

        local randomItem = self.Panel_randomItem:clone()
        randomItem:setVisible(true)
        local pos =  AgoraDataMgr:getBoxPosition(v.location)
        if pos then
            randomItem:setPosition(pos)
            randomItem:setName("randomItem")
            randomItem:setZOrder(10-k)
            self.Panel_box:addChild(randomItem)

            local eventImg = AgoraDataMgr:getEventInfo(v.eventCid)
            if eventImg then
                local Image_reward = randomItem:getChildByName("Image_reward")
                Image_reward:setTexture(eventImg)
            end
            randomItem:onClick(function()
                TFDirector:send(c2s.CHRISTMAS_REQ_CHRISTMAS_MAP_BOX, {v.location})
            end)
        end
    end
end

function AgoraFightZone:onRecvUpdateMapBox()
    self.Panel_box:removeAllChildren()
    self:updateRandomItem()
end

function AgoraFightZone:onRecvUpdateInvade()
    self:updateChapterItem()
end

function AgoraFightZone:registerEvents()

    EventMgr:addEventListener(self, EV_AGORA.MapBoxUpdate, handler(self.onRecvUpdateMapBox, self))
    EventMgr:addEventListener(self, EV_AGORA.UpdateLevelInfo, handler(self.onRecvUpdateInvade, self))

    for chapterIndex,v in ipairs(self.chapterMode) do
        v.btn:onClick(function()

            local chapterCfg = AgoraDataMgr:getChapterCfgInfo(v.chapterId)
            if not chapterCfg then
                return
            end

            local isOpen,openTime = AgoraDataMgr:chapterIsOpen(v.chapterId)
            if not isOpen then
                local month = tonumber(os.date("%m", ServerDataMgr:customUtcTimestap(openTime)))
                local day = tonumber(os.date("%d", ServerDataMgr:customUtcTimestap(openTime)))
                local hour = tonumber(os.date("%H", ServerDataMgr:customUtcTimestap(openTime)))

                local timsStr = TextDataMgr:getText(303043,month,day,hour)
                local str = TextDataMgr:getText(303042,timsStr..GV_UTC_TIME_STRING)
                Utils:showTips(str)
                return
            end

            Utils:openView("agora.AgoraLevelView",v.chapterId)
        end)
    end
end

return AgoraFightZone