
local TxjzResultView = class("TxjzResultView", BaseLayer)

function TxjzResultView:initData()
    self.levelCid_ = BattleDataMgr:getPointId()
    self.levelCfg_ = FubenDataMgr:getLevelCfg(self.levelCid_)
    self.statistics_ = BattleDataMgr:getController().getStatistics()
    self.victoryDecide_ = BattleDataMgr:getController().getVictoryDecide()

    self.battleType_ = BattleDataMgr:getBattleType()
    self.resultData_ = BattleDataMgr:getBattleResultData()
    self.formation_ = FubenDataMgr:getFormation()
    self.isEnableTouching_ = false
    self.rewardList_ = {}
    for i, v in ipairs(self.resultData_.dropReward) do
        if v.id == EC_SItemType.PLAYEREXP then
            self.playerExp_ = v
        elseif v.id == EC_SItemType.SPIRITEXP then
            self.spiritExp_ = v
        elseif v.id == EC_SItemType.FAVOR then
            self.favorExp_ = v
        elseif v.id == EC_SItemType.CONTRIBUTION then
            self.contribution_ = v
        else
            table.insert(self.rewardList_, v)
        end
    end
end

function TxjzResultView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.battle.txjzResultView")
end

function TxjzResultView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_touch = TFDirector:getChildByPath(ui, "Panel_touch")

    self.Image_battleResul_bg = TFDirector:getChildByPath(self.Panel_root, "Image_battleResul_bg")
    self.Image_battleResult_role_mirror = TFDirector:getChildByPath(self.Panel_root, "Image_battleResult_role_mirror"):hide()
    self.Image_battleResult_hero = TFDirector:getChildByPath(self.Panel_root, "Image_battleResult_hero"):hide()
    self.Spine_battleResult_splash = TFDirector:getChildByPath(self.Panel_root, "Spine_battleResult_splash"):hide()
    self.Spine_battleResult_dian = TFDirector:getChildByPath(self.Panel_root, "Spine_battleResult_dian"):hide()
    self.Spine_battleResult_title = TFDirector:getChildByPath(self.Panel_root, "Spine_battleResult_title"):hide()

    self.Image_contribution = TFDirector:getChildByPath(self.Panel_root, "Image_contribution")
    self.Label_contribution_title = TFDirector:getChildByPath(self.Image_contribution, "Label_contribution_title")
    self.Spine_cjtx_score = TFDirector:getChildByPath(self.Image_contribution, "Spine_cjtx_score")
    self.Image_hurt = TFDirector:getChildByPath(self.Panel_root, "Image_hurt")
    self.Label_hurt_title = TFDirector:getChildByPath(self.Image_hurt, "Label_hurt_title")
    self.Label_hurt = TFDirector:getChildByPath(self.Image_hurt, "Label_hurt")
    self.Image_reward = TFDirector:getChildByPath(self.Panel_root, "Image_reward")
    self.Label_reward_title = TFDirector:getChildByPath(self.Image_reward, "Label_reward_title")
    local ScrollView_reward = TFDirector:getChildByPath(self.Panel_root, "ScrollView_reward"):hide()
    self.ListView_reward = UIListView:create(ScrollView_reward)
    self.ListView_reward:setInertiaScrollEnabled(false)
    self.Label_continue = TFDirector:getChildByPath(self.Panel_root, "Label_continue"):hide()

    self:refreshView()
end

function TxjzResultView:refreshView()
    self.Label_continue:setTextById(800038)
    -- self.Label_contribution_title:setTextById(300994)
    -- self.Label_hurt_title:setTextById(300997)
    self.Label_reward_title:setTextById(300998)

    self.Label_hurt:setText(self.victoryDecide_.getScore())
    local score_effect_animations = {"d_loop", "c_loop","b_loop", "a_loop", "s_loop"}
    local rating = self.victoryDecide_.getRating()
    dump(score_effect_animations[rating])
    self.Spine_cjtx_score:play(score_effect_animations[rating], 1)

    self:createHeroModel()
    self:updateReward()
    self:runAnimationIn()
end

function TxjzResultView:registerEvents()
    self.Panel_touch:onClick(function()
            if self.isEnableTouching_ then
                battleController.popLastScence(  )
            end
    end)
end

function TxjzResultView:updateReward()
    self.Image_reward:setVisible(#self.rewardList_ > 0)
    for i, v in ipairs(self.rewardList_) do
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:setScale(0.65)
        PrefabDataMgr:setInfo(Panel_goodsItem, v.id, v.num)
        self.ListView_reward:pushBackCustomItem(Panel_goodsItem)
    end
    self.ListView_reward:s():jumpToRight()
end

function TxjzResultView:runAnimationIn()
    local function runBgAnim()
        local acts = {}
        table.insert(acts, CCSpawn:create({CCScaleTo:create(1, 1.1), CCFadeTo:create(1, 255)}))
        self.Image_battleResul_bg:setVisible(true)
        self.Image_battleResul_bg:setOpacity(0)
        self.Image_battleResul_bg:runAction(CCSequence:create(acts))
    end

    local function runTitleAnim()
        self.Spine_battleResult_dian:setVisible(true)
        self.Spine_battleResult_dian:stop()
        self.Spine_battleResult_dian:play("animation",false)
        self:timeOut(
            function()
                self.Spine_battleResult_title:setVisible(true)
                self.Spine_battleResult_title:stop()
                self.Spine_battleResult_title:play("battle_end_win1",false)
                Utils:playSound(404)
            end,
            0.2
        )
        self:timeOut(function()
                self.Spine_battleResult_title:play("battle_end_win2", false)
        end, 1)
    end

    local function runRoleMirrorAnim()
        local arr = {}
        local act1 = CCMoveBy:create(0.6, ccp(-300, 0))
        local act2 = CCFadeTo:create(0.6, 35)
        act1 = EaseSineIn:create(act1)
        act2 = EaseSineIn:create(act2)
        table.insert(arr, CCDelayTime:create(0.3))
        table.insert(arr, CCSpawn:create({act1, act2}))
        self.Image_battleResult_role_mirror:Show():PosX(self.Image_battleResult_role_mirror:PosX() + 300)
        self.Image_battleResult_role_mirror:setOpacity(0)
        self.Image_battleResult_role_mirror:runAction(CCSequence:create(arr))
    end

    local function runRoleAnim()
        local arr1 = {}
        local act3 = CCScaleTo:create(0.4, self.modelEndSize)
        local act4 = CCFadeTo:create(0.4, 255)
        act3 = EaseSineOut:create(act3)
        act4 = EaseSineOut:create(act4)
        table.insert(arr1, CCSpawn:create({act3, act4}))
        self.Image_battleResult_hero:setVisible(true)
        self.Image_battleResult_hero:setOpacity(50)
        self.Image_battleResult_hero:runAction(CCSequence:create(arr1))
    end

    local function runRewardAni()
        for i, v in ipairs(self.ListView_reward:getItems()) do
            self.ListView_reward:s():show()
            ViewAnimationHelper.doScaleFadeInAction(v, {scale = 0.01, upscale = 1.0, uptime = 0.1, downscale = 0.65, downtime = 0.05, delay = i * 0.06 + 0.6, callback = animOver})
        end
    end

    self.Spine_battleResult_splash:setVisible(true)
    self.Spine_battleResult_splash:play("start",false)

    self:timeOut(
        function()
            runBgAnim()
        end,
        0.1
    )

    self:timeOut(
        function()
            self.Spine_battleResult_splash:play("loop",true)
        end,
        0.9
    )

    self:timeOut(
        function()
            runRoleAnim()
            runRoleMirrorAnim()
            self.Image_battleResult_role_mirror:setVisible(true)
        end,
        0.15
    )

    self:timeOut(
        function()
            runTitleAnim()
        end,
        0.7
    )

    self:timeOut(
        function()
            runRewardAni()
        end,
        1.0
    )

    local aniNode = {}
    aniNode = {self.Image_contribution, self.Image_hurt}
    if self.Image_reward:isVisible() then
        table.insert(aniNode, self.Image_reward)
    end
    ViewAnimationHelper.displayMoveNodes(aniNode, {direction = 1, distance = 150, wait = 0, delay = 0.15, time = 0.1})

    self:timeOut(
        function()
            self.isEnableTouching_ = true
            self.Label_continue:show()
            Utils:blinkRepeatAni(self.Label_continue)
        end,
        1.5
    )
end

function TxjzResultView:createHeroModel()
    local heroData = self.formation_[1]
    local heroCid = heroData.id
    local skinCid = heroData.skinCid or HeroDataMgr:getCurSkin(heroId)
    local skinInfo = TabDataMgr:getData("HeroSkin", skinCid)
    local modelInfo = TabDataMgr:getData("HeroModle",skinInfo.paint)

    local model = Utils:createHeroModel(heroCid, self.Image_battleResult_hero, 0.8, skinCid)
    local hero_pos = ccp(20, -550)
    hero_pos.x = hero_pos.x + modelInfo.battleEndPosition.x
    hero_pos.y = hero_pos.y + modelInfo.battleEndPosition.y
    model:setPosition(hero_pos)

    self.Image_battleResult_hero:setScale(modelInfo.battleEndSize + 0.5)
    self.modelEndSize = modelInfo.battleEndSize or 1.3

    self.Image_battleResult_role_mirror:show()
    local model1 = Utils:createHeroModel(heroCid, self.Image_battleResult_role_mirror, 0.8, skinCid)
    model1:update(0.1)
    model1:stop()
    local tx = CCRenderTexture:create(1136,1000)
    tx:begin()
    self.Image_battleResult_role_mirror:visit()
    tx:endToLua()
    
    local yinziPos = ccp(-220, -380)
    yinziPos.x = yinziPos.x + modelInfo.battleEndYingziPos.x
    yinziPos.y = yinziPos.y + modelInfo.battleEndYingziPos.y
    local yingzi = Sprite:createWithTexture(tx:getSprite():getTexture())
    yingzi:setAnchorPoint(ccp(0, 0))
    yingzi:setPosition(yinziPos)
    yingzi:setFlipY(true)
    yingzi:setScale(self.modelEndSize * 1.05)
    model1:removeFromParent()
    self.Image_battleResult_role_mirror:addChild(yingzi)
end

return TxjzResultView
