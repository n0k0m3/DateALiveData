
local EndlessLevelResultView = class("EndlessLevelResultView", BaseLayer)

function EndlessLevelResultView:initData(dropReward)
    local endlessInfo = FubenDataMgr:getEndlessInfo()
    self.nextLevelCid_ = endlessInfo.curStage
    self.nextLevelCfg_ = FubenDataMgr:getEndlessCloisterLevelCfg(self.nextLevelCid_)
    self.dropReward_ = Utils:mergeReward(dropReward)

    self.levelCfg_ = BattleDataMgr:getLevelCfg()
end

function EndlessLevelResultView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.battle.endlessLevelResultView")
end

function EndlessLevelResultView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_touch = TFDirector:getChildByPath(ui, "Panel_touch")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_roleItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_roleItem")

    self.Spine_win = TFDirector:getChildByPath(self.Panel_root, "Spine_win")
    self.Image_remainTime = TFDirector:getChildByPath(self.Panel_root, "Image_remainTime")
    self.Label_remainTime_title = TFDirector:getChildByPath(self.Image_remainTime, "Label_remainTime_title")
    self.Label_remainTime = TFDirector:getChildByPath(self.Image_remainTime, "Label_remainTime")
    self.Image_jump = TFDirector:getChildByPath(self.Panel_root, "Image_jump")
    self.Label_jump_title = TFDirector:getChildByPath(self.Image_jump, "Label_jump_title")
    self.Label_cur_level = TFDirector:getChildByPath(self.Image_jump, "Label_cur_level")
    self.Image_goto = TFDirector:getChildByPath(self.Image_jump, "Image_goto"):hide()
    self.Label_goto = TFDirector:getChildByPath(self.Image_goto, "Label_goto")
    self.Label_goto_level = TFDirector:getChildByPath(self.Image_goto, "Label_goto_level")
    self.Label_jump_level = TFDirector:getChildByPath(self.Image_goto, "Label_jump_level")
    self.Image_hp = TFDirector:getChildByPath(self.Panel_root, "Image_hp"):hide()
    self.Label_hp_title = TFDirector:getChildByPath(self.Image_hp, "Label_hp_title")
    local ScrollView_role = TFDirector:getChildByPath(self.Image_hp, "ScrollView_role")
    self.ListView_role = UIListView:create(ScrollView_role)
    self.Image_reward = TFDirector:getChildByPath(self.Panel_root, "Image_reward")
    self.Label_reward_title = TFDirector:getChildByPath(self.Image_reward, "Label_reward_title")
    local ScrollView_reward = TFDirector:getChildByPath(self.Image_reward, "ScrollView_reward")
    self.ListView_reward = UIListView:create(ScrollView_reward)
    self.ListView_role:setItemsMargin(5)
    self:refreshView()
end

function EndlessLevelResultView:refreshView()
    self.Image_remainTime:hide()
    self.Image_jump:hide()
    self.Image_hp:hide()
    self.Image_reward:hide()
    local actNodes = {}
    table.insert(actNodes, self.Image_remainTime)
    table.insert(actNodes, self.Image_jump)

    self.Label_reward_title:setTextById(301012)
    self.Label_goto:setTextById(310016)

    local isRacingMode = FubenDataMgr:isEndlessRacingMode(self.levelCfg_.id)
    if isRacingMode then
        self:showRacingModeResult()
        table.insert(actNodes, self.Image_hp)
    else
        self:showNormalModeResult()
    end
    table.insert(actNodes, self.Image_reward)

    for i, v in ipairs(self.dropReward_) do
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:Scale(0.7)
        PrefabDataMgr:setInfo(Panel_goodsItem, v.id, v.num)
        self.ListView_reward:pushBackCustomItem(Panel_goodsItem)
    end

    local function runShowAnim()
        local delayTime = 0.4
        self.Image_remainTime:show()
        self.Image_jump:show()
        if isRacingMode then
            self.Image_goto:hide()
            self.Image_hp:show()
            delayTime = 0.55
        end
        self.Image_reward:show()
        ViewAnimationHelper.displayMoveNodes(actNodes, {direction = 2, distance = 250, wait = 0, delay = 0.12, time = 0.12})

        local rewardItems = self.ListView_reward:getItems()
        for i,v in ipairs(rewardItems) do
            ViewAnimationHelper.doScaleFadeInAction(v, {scale = 0.01, upscale = 1.2, uptime = 0.1, downscale = 0.65, downtime = 0.05, delay = i * 0.06 + delayTime})
        end
    end
    self:timeOut(function()
        runShowAnim()
    end, 0.7)
end

function EndlessLevelResultView:showNormalModeResult()
    self.Image_goto:show()
    self.Label_remainTime_title:setTextById(300870)
    self.Label_jump_title:setTextById(310030)

    local fightTime = math.floor(battleController.getTime())
    local jumpLevel = FubenDataMgr:getEndlessJumpLevel(fightTime)
    self.Label_jump_level:setTextById(310029, jumpLevel)

    self.Label_cur_level:setTextById(300873, self.levelCfg_.order)
    if self.nextLevelCfg_.type == EC_EndlessLevelType.BOSS then
        self.Label_goto_level:setTextById(300874, self.nextLevelCfg_.order)
    else
        self.Label_goto_level:setTextById(300873, self.nextLevelCfg_.order)
    end

    local remainMsec = self.levelCfg_.time * 1000 - battleController.getTime()
    local _, hour, min, sec = Utils:getDHMS(math.floor(remainMsec / 1000), true)
    self.Label_remainTime:setTextById(800014, min, sec)

    self.Image_reward:Pos(self.Image_hp:Pos())
end

function EndlessLevelResultView:showRacingModeResult()
    self.Label_remainTime_title:setTextById(310014)
    self.Label_jump_title:setTextById(300872)
    self.Label_hp_title:setTextById(310017)

    local fightTime = math.floor(battleController.getTime() / 1000)
    local _, hour, min, sec = Utils:getDHMS(fightTime, true)
    self.Label_remainTime:setTextById(800014, min, sec)
    self.Label_cur_level:setTextById(300873, self.nextLevelCfg_.order)

    local roleItems = {}
    local formation = FubenDataMgr:getFormation()
    for i, v in ipairs(formation) do
        local Panel_roleItem = self.Panel_roleItem:clone()
        local Panel_role = TFDirector:getChildByPath(Panel_roleItem, "Panel_role")
        local Image_quality = TFDirector:getChildByPath(Panel_role, "Image_quality")
        local Image_playerIcon = TFDirector:getChildByPath(Panel_role, "ClippingNode_mask.Image_playerIcon")
        local Label_level = TFDirector:getChildByPath(Panel_role, "Label_level")
        local Image_pinzhi = TFDirector:getChildByPath(Panel_role, "Image_pinzhi")
        local LoadingBar_hp = TFDirector:getChildByPath(Panel_roleItem, "Image_hp.LoadingBar_hp")
        local Label_addHp = TFDirector:getChildByPath(Panel_roleItem, "Label_addHp")
        local Image_dead = TFDirector:getChildByPath(Panel_roleItem, "Image_dead")

        Image_playerIcon:setTexture(HeroDataMgr:getIconPathById(v.id, v.skinCid))
        Image_pinzhi:setTexture(HeroDataMgr:getQualityPic(v.id, v.quality))
        Label_level:setTextById(800006, v.lvl)
        self.ListView_role:pushBackCustomItem(Panel_roleItem)
        local percent = FubenDataMgr:getEndlessHeroHpPercent(v.id)
        local addHpPercent = self.levelCfg_.hpRecover
        local realPercent = math.max(percent - addHpPercent, 0)
        realPercent = math.min(realPercent, 10000)
        LoadingBar_hp:setPercent(math.floor(realPercent / 100))

        local isDead = realPercent == 0
        Label_addHp:setVisible(not isDead)
        if not isDead then
            if self.levelCfg_.hpRecover > 0 then
                local percentStr = TextDataMgr:getText(800017, math.floor(addHpPercent / 100))
                Label_addHp:setTextById(800008, percentStr)
            else
                Label_addHp:setTextById(800017, math.floor(realPercent / 100))
            end
        end
        Image_dead:setVisible(isDead)
        Panel_roleItem:setGrayEnabled(isDead)

        roleItems[#roleItems + 1] = Panel_roleItem
        Panel_roleItem:setVisible(false)
    end

    local function runRoleAnim()
        for i,v in ipairs(roleItems) do
            local function animOver()
                local spineRole = SkeletonAnimation:create("effect/battle_end_win_02/out/battle_end_win_01")
                spineRole:setPosition(ccp(0, 14))
                spineRole:playByIndex(2, -1, -1, 0)
                v:addChild(spineRole, 5)

                if self.levelCfg_.hpRecover > 0 then
                    local LoadingBar_hp = TFDirector:getChildByPath(v, "Image_hp.LoadingBar_hp")
                    local heroData = formation[i]
                    local percent = FubenDataMgr:getEndlessHeroHpPercent(heroData.id)
                    percent = math.floor(percent / 100)
                    if percent > 0 then
                        local realPercent = math.min(percent, 100)
                        Utils:progressTo(
                            LoadingBar_hp,
                            0.3, realPercent,
                            function()

                            end
                        )
                    end
                end
            end
            v:setVisible(true)
            ViewAnimationHelper.doScaleFadeInAction(v, {scale = 0.01, upscale = 1.2, uptime = 0.1, downtime = 0.05, delay = (i - 1) * 0.12 + 0.4, callback = animOver})
        end
    end
    self:timeOut(function()
        runRoleAnim()
    end, 0.6)
end

function EndlessLevelResultView:registerEvents()
    self.Panel_touch:onClick(function()
            EventMgr:dispatchEvent(EV_FUBEN_ENDLESS_CONTINUE)
            AlertManager:closeLayer(self)
    end)
end

return EndlessLevelResultView
