local FubenFlightSquadView = class("FubenFlightSquadView", BaseLayer)

function FubenFlightSquadView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.fuben.fubenFlightSquadView")
end

function FubenFlightSquadView:initData(levelCid, isDuelMod, challengeCount)
    self.name = "FubenSquadView"
    self.isDuelMod_ = isDuelMod
    self.challengeCount_ = challengeCount
    self.calChallengeCount_ = math.max(1, challengeCount)
    self.levelCid_ = levelCid
    self.levelCfg_ = FubenDataMgr:getLevelCfg(levelCid)
    local levelGroupCfg = FubenDataMgr:getLevelGroupCfg(self.levelCfg_.levelGroupId)
    local type_ = self.levelCfg_.heroLimitType
    self.isLimitHero_ = (type_ == EC_LimitHeroType.LIMIT_NJ or type_ == EC_LimitHeroType.LIMIT_J)
    self.isDisableHero_ = (self.levelCfg_.heroLimitType == EC_LimitHeroType.DISABLE)

    self.formationData_ = {}
    self.moveFlag_ = false

    if self.isLimitHero_ then
        local levelFormation = FubenDataMgr:getLevelFormation(self.levelCid_)
        if levelFormation then
            self.formationData_ = FubenDataMgr:getInitFormation(self.levelCid_)
        else
            FubenDataMgr:send_DUNGEON_LIMIT_HERO_DUNGEON(self.levelCid_)
            self.isRequestLimitFormation_ = true
        end
    else
        self.formationData_ = FubenDataMgr:getInitFormation(self.levelCid_)
    end

    if not self.isRequestLimitFormation_ then
        if self.isLimitHero_ or self.isDisableHero_ then
            HeroDataMgr:changeDataByFuben(self.levelCid_, self.formationData_)
        end
    end
end

function FubenFlightSquadView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Label_myTeam = TFDirector:getChildByPath(self.Panel_root, "Label_myTeam")

    self.Label_captain = TFDirector:getChildByPath(self.Panel_root, "Label_captain")
    self.member_root = TFDirector:getChildByPath(self.Panel_root, "Panel_memeber")
    self.member_Panel_role = TFDirector:getChildByPath(self.member_root, "Panel_role")
    self.member_Button_head = TFDirector:getChildByPath(self.member_root, "Button_head")
    self.member_Panel_model = TFDirector:getChildByPath(self.member_Panel_role, "Panel_model")
    self.member_Image_captain = TFDirector:getChildByPath(self.member_Panel_role, "Image_captain")
    self.member_Label_name = TFDirector:getChildByPath(self.member_Panel_role, "Label_name")
    self.member_Image_limit_type = TFDirector:getChildByPath(self.member_Panel_role, "Image_limit_type")
    self.member_Label_limit_type = TFDirector:getChildByPath(self.member_Image_limit_type, "Label_limit_type")
    self.member_Image_disable_type = TFDirector:getChildByPath(self.member_Panel_role, "Image_disable_type")
    self.member_Label_disable_type = TFDirector:getChildByPath(self.member_Image_disable_type, "Label_disable_type")
    self.member_Image_try_type = TFDirector:getChildByPath(self.member_root, "Image_try_type")
    self.member_Label_try_type = TFDirector:getChildByPath(self.member_Image_try_type, "Label_try_type")
    self.member_Panel_add = TFDirector:getChildByPath(self.member_root, "Panel_add")
    self.member_Button_add = TFDirector:getChildByPath(self.member_Panel_add, "Button_add")
    self.member_Label_empty = TFDirector:getChildByPath(self.member_Panel_add, "Label_empty")

    self.Label_mode = TFDirector:getChildByPath(self.Panel_root, "Label_mode")


    self.Image_cost = TFDirector:getChildByPath(self.Panel_root, "Image_cost")
    self.Label_costNum = TFDirector:getChildByPath(self.Image_cost, "Label_costNum")
    self.Image_costIcon = TFDirector:getChildByPath(self.Image_cost, "Image_costIcon")
    self.Label_cost = TFDirector:getChildByPath(self.Image_cost, "Label_cost")
    self.Button_fighting = TFDirector:getChildByPath(self.Panel_root, "Button_fighting")
    self.video_frame = TFDirector:getChildByPath(self.Panel_root, "Panel_preview_frame")
    self.Panel_preview_mask = TFDirector:getChildByPath(self.Panel_root, "Panel_preview_mask")
    self.Image_mode = TFDirector:getChildByPath(self.video_frame, "Image_mode")
    self.Button_play = TFDirector:getChildByPath(self.video_frame, "Button_play")
    self.preview_image = TFDirector:getChildByPath(self.video_frame, "Panel_video_preview_img")
    self.preview_image:setTexture(self.levelCfg_.previewPicture)


    self.Button_play:onClick(function ()
        self.preview_image:hide()
        self.preview_image:setZOrder(2)
        self.Panel_preview_mask:setZOrder(3)
        self.Image_mode:setZOrder(5)
        self.Button_play:setZOrder(5)
        self.Button_play:setTouchEnabled(false)
        local videoCfg = TabDataMgr:getData("Video", self.levelCfg_.previewVideo)
        if tolua.isnull(self.videoPlayer) then
            ---@type VlcPlayer
            self.videoPlayer = VlcPlayer:create({filePath = videoCfg.path,
                                                 viewSize = ccs(670, 396),
                                                 forceVLC = true,   
                                                 onVideoPlayComplete = handler(self.onVideoPlayComplete, self)})
            self.videoPlayer:setAnchorPoint(ccp(0.5, 0.5))
            self.video_frame:addChild(self.videoPlayer, 10)
        else
            self.videoPlayer:setZOrder(10)
            self.videoPlayer:setFile(videoCfg.path)
        end
        self.videoPlayer:play()
    end)

    self:refreshView()
end

function FubenFlightSquadView:refreshView()
    --self:calMoveRect()

    self.Label_myTeam:setTextById(300010)
    if self.levelCfg_.fightingMode == 2 then
        self.Label_mode:setTextById(300021)
        self.Image_mode:setTexture("ui/fuben/flight_mode.png")
    elseif self.levelCfg_.fightingMode == 3 then
        self.Label_mode:setTextById(300022)
        self.Image_mode:setTexture("ui/fuben/bump_mode.png")
    end

    if not self.isRequestLimitFormation_ then
        self:updateFormation()
    end

    local cost = self.levelCfg_.cost[1]
    if cost then
        self.Image_cost:show()
        local costItemCfg = GoodsDataMgr:getItemCfg(cost[1])
        self.Image_costIcon:setTexture(costItemCfg.icon)
        self.Label_costNum:setText(cost[2] * self.calChallengeCount_)
    end
    self.Label_cost:setTextById(300020)
end

function FubenFlightSquadView:onVideoPlayComplete()
    if self.videoPlayer then
        self.preview_image:show()
        self.videoPlayer:setZOrder(1)
        self.preview_image:setZOrder(2)
        self.Panel_preview_mask:setZOrder(3)
        self.Image_mode:setZOrder(5)
        self.Button_play:setZOrder(5)
        self.Button_play:setTouchEnabled(true)

        self.videoPlayer:removeFromParent()
        self.videoPlayer = nil
    end
end

function FubenFlightSquadView:removeEvents()
    FubenDataMgr:resetLevelFormation(self.levelCid_)
    EventMgr:removeEventListenerByTarget(self)
end

function FubenFlightSquadView:registerEvents()
    EventMgr:addEventListener(self, EV_FORMATION_CHANGE, handler(self.onUpdateFormationEvent, self))
    EventMgr:addEventListener(self, EV_FUBEN_UPDATE_LIMITHERO, handler(self.onLimitHeroEvent, self))

    self.Button_fighting:onClick(function()
        local cost = self.levelCfg_.cost[1]
        local isCanFighting = true
        if cost then
            isCanFighting = GoodsDataMgr:currencyIsEnough(cost[1], cost[2] * self.calChallengeCount_)
        end

        if isCanFighting then
            if #self.formationData_ == 0 then
                Utils:showTips(2100116)
                return
            end

            local levelGroupCfg = FubenDataMgr:getLevelGroupCfg(self.levelCfg_.levelGroupId)
            local heros = {}
            for i, v in ipairs(self.formationData_) do
                table.insert(heros, {v.type, v.id})
            end
            local enabled = true
            if self.isDisableHero_ then
                for i, v in ipairs(self.formationData_) do
                    if table.indexOf(self.levelCfg_.heroForbiddenID, v.data.cid) ~= -1 then
                        enabled = false
                        break
                    end
                end
            end
            if enabled then
                if self.levelCfg_.fightingMode == 2 or self.levelCfg_.fightingMode == 3 then
                    local flightController = require("lua.logic.battle.flight.FlightController")
                    flightController.requestFightStart(self.levelCid_, 0, 0, heros, self.challengeCount_, self.isDuelMod_)
                else
                    local battleController = require("lua.logic.battle.BattleController")
                    battleController.requestFightStart(self.levelCid_, 0, 0, heros)
                end
            else
                Utils:showTips(2100035)
            end
        else
            local goodsCfg = GoodsDataMgr:getItemCfg(cost[1])
            local name = TextDataMgr:getText(goodsCfg.nameTextId)
            Utils:showTips(2100034, name)
        end
    end)

    self:setBackBtnCallback(function()
            HeroDataMgr:changeDataToSelf()
            AlertManager:close()
    end)
    self:setMainBtnCallback(function()
            HeroDataMgr:changeDataToSelf()
    end)
end

function FubenFlightSquadView:updateFormation()
    local formationData = self.formationData_[1]
    local isBattle = tobool(formationData)
    self.member_Panel_role:setVisible(isBattle)
    self.member_Panel_add:setVisible(not isBattle)
    self.member_Label_limit_type:setTextById(300016)
    self.member_Label_try_type:setTextById(300015)
    self.member_Label_disable_type:setTextById(300017)
    self.member_Label_empty:setTextById(300018)

    if isBattle then
        self.member_Image_limit_type:setVisible(self.isLimitHero_)
        self.member_Image_disable_type:setVisible(self.isDisableHero_)
        self.member_Image_try_type:hide()
        if self.isDisableHero_ then
            local index = table.indexOf(self.levelCfg_.heroForbiddenID, formationData.data.cid)
            self.member_Image_disable_type:setVisible(index ~= -1)
        elseif self.isLimitHero_ then
            self.member_Image_limit_type:setVisible(formationData.type == EC_BattleHeroType.LIMIT)
        end

        local heroData = formationData.data
        local skinData = TabDataMgr:getData("HeroSkin", heroData.skinCid)
        -- v.Image_icon:setTexture(skinData.endIcon)
        self.member_Label_name:setTextById(skinData.nameTextId)
        self.member_Button_head:setTextureNormal(skinData.backdrop)

        local model = Utils:createHeroModel(heroData.id,  self.member_Panel_model, 0.45, heroData.skinCid)
        model:update(0.1)
        model:stop()
    end

    self.member_Button_head:onClick(function()
        local heroTab = HeroDataMgr:getHero()
        if 1 < #heroTab then
            Utils:showTips(300011)
        else
            if self.isLimitHero_ or self.isDisableHero_ then
                HeroDataMgr:changeFormation(1, false)
            else
                HeroDataMgr:changeFormation(1)
            end
        end
    end)
    self.member_Button_add:onClick(function()
        local heroTab = HeroDataMgr:getHero()
        if 1 < #heroTab then
            Utils:showTips(300011)
        else
            if self.isLimitHero_ or self.isDisableHero_ then
                HeroDataMgr:changeFormation(1, false)
            else
                HeroDataMgr:changeFormation(1)
            end
        end
    end)
end

function FubenFlightSquadView:makeFormationData(heroData, type_, id)
    return {
        data = clone(heroData),
        type = type_,
        id = id,
    }
end

function FubenFlightSquadView:onUpdateFormationEvent(heroCid, oldHeroCid)
    if self.isLimitHero_ or self.isDisableHero_ then
        local index
        if oldHeroCid then
            FubenDataMgr:casLevelFormation(self.levelCid_, heroCid, oldHeroCid)
            for i, v in ipairs(self.formationData_) do
                if v.data.cid == oldHeroCid then
                    local heroData = HeroDataMgr:getHero(heroCid)
                    self.formationData_[i] = self:makeFormationData(heroData, EC_BattleHeroType.OWN, heroCid)
                    if self.isLimitHero_ then
                        FubenDataMgr:casLevelFormation(self.levelCid_, oldHeroCid, heroCid)
                    end
                    break
                end
            end
        else
            for i, v in ipairs(self.formationData_) do
                if v.data.cid == heroCid then
                    index = i
                    break
                end
            end
            if index then
                table.remove(self.formationData_, index)
                if self.isLimitHero_ then
                    FubenDataMgr:removeLevelFormation(self.levelCid_, heroCid)
                end
            else
                local heroData = HeroDataMgr:getHero(heroCid)
                table.insert(self.formationData_, self:makeFormationData(heroData, EC_BattleHeroType.OWN, heroCid))
                if self.isLimitHero_ then
                    FubenDataMgr:addLevelFormation(self.levelCid_, heroCid)
                end
            end
        end
    else
        self.formationData_ = {}
        for i = 1, 3 do
            local isOn = HeroDataMgr:getIsFormationOn(i)
            if isOn then
                local id = HeroDataMgr:getHeroIdByFormationPos(i)
                local heroData = HeroDataMgr:getHero(id)
                table.insert(self.formationData_, self:makeFormationData(heroData, EC_BattleHeroType.OWN, heroData.cid))
            end
        end
    end
    self:updateFormation()
end

function FubenFlightSquadView:onLimitHeroEvent()
    self.formationData_ = FubenDataMgr:getInitFormation(self.levelCid_)
    if self.isLimitHero_ or self.isDisableHero_ then
        HeroDataMgr:changeDataByFuben(self.levelCid_, self.formationData_)
    end
    self:updateFormation()
end

return FubenFlightSquadView
