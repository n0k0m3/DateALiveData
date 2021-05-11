
local TheaterDatingResultView = class("TheaterDatingResultView", BaseLayer)

function TheaterDatingResultView:initData(levelCid)
    self.levelCid_ = levelCid
    self.levelCfg_ = FubenDataMgr:getLevelCfg(levelCid)
    self.levelInfo_ = FubenDataMgr:getLevelInfo(levelCid)
    self.theaterLevelCfg_ = FubenDataMgr:getTheaterDungeonLevelCfg(levelCid)

    self.isEnableTouching_ = false
end

function TheaterDatingResultView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.battle.theaterDatingResultView")
end

function TheaterDatingResultView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_touch = TFDirector:getChildByPath(ui, "Panel_touch")

    self.Image_battleResul_bg = TFDirector:getChildByPath(self.Panel_root, "Image_battleResul_bg")
    self.Image_battleResult_role_mirror = TFDirector:getChildByPath(self.Panel_root, "Image_battleResult_role_mirror"):hide()
    self.Image_battleResult_hero = TFDirector:getChildByPath(self.Panel_root, "Image_battleResult_hero"):hide()
    self.Spine_battleResult_splash = TFDirector:getChildByPath(self.Panel_root, "Spine_battleResult_splash"):hide()
    self.Spine_battleResult_dian = TFDirector:getChildByPath(self.Panel_root, "Spine_battleResult_dian"):hide()
    self.Spine_battleResult_title = TFDirector:getChildByPath(self.Panel_root, "Spine_battleResult_title"):hide()

    self.Image_reward = TFDirector:getChildByPath(self.Panel_root, "Image_reward"):hide()
    self.Label_reward_title = TFDirector:getChildByPath(self.Image_reward, "Label_reward_title")
    local ScrollView_reward = TFDirector:getChildByPath(self.Panel_root, "ScrollView_reward"):hide()
    self.ListView_reward = UIListView:create(ScrollView_reward)
    self.ListView_reward:setInertiaScrollEnabled(false)

    self.Image_lingbo = TFDirector:getChildByPath(self.Panel_root, "Image_lingbo"):hide()
    self.Label_lingbo_title = TFDirector:getChildByPath(self.Image_lingbo, "Label_lingbo_title")
    self.Label_lingbo_progress = TFDirector:getChildByPath(self.Image_lingbo, "Label_lingbo_progress")

    self.Label_continue = TFDirector:getChildByPath(self.Panel_root, "Label_continue"):hide()

    self:refreshView()
end

function TheaterDatingResultView:refreshView()
    self.Label_continue:setTextById(800038)
    self.Label_lingbo_title:setTextById(300993)
    self.Label_reward_title:setTextById(300998)

    local theaterBossInfo = FubenDataMgr:getTheaterBossInfo()
    if theaterBossInfo.odeumType == EC_TheaterBossType.LINGBO then
        if not self.levelInfo_ or self.levelInfo_.fightCount == 0 then
            self.Image_lingbo:show()
            local addLingBo = RandomGenerator.random(4, 6)
            self.Label_lingbo_progress:show():setTextById(800008, addLingBo)
        end
    end

    self:createHeroModel()
    self:updateReward()
    self:runAnimationIn()
end

function TheaterDatingResultView:registerEvents()
    self.Panel_touch:onClick(function()
            if self.isEnableTouching_ then
                FubenDataMgr:send_DUNGEON_FIGHT_OVER(self.levelCid_, true, {1}, 1, 1, 1)
                AlertManager:closeLayer(self)
            end
    end)
end

function TheaterDatingResultView:updateReward()
    local msg = DatingDataMgr:getDatingSettlementMsg()
    local reward = msg.goods or {}
    self.Image_reward:setVisible(#reward > 0)
    for i, v in ipairs(reward) do
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:setScale(0.65)
        PrefabDataMgr:setInfo(Panel_goodsItem, v.id, v.num)
        self.ListView_reward:pushBackCustomItem(Panel_goodsItem)
    end
    self.ListView_reward:s():jumpToRight()

    DatingDataMgr:clearDatingSettlementMsg()
end

function TheaterDatingResultView:runAnimationIn()
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
                self.Spine_battleResult_title:play("battle_end_win3",false)
                Utils:playSound(404)
            end,
            0.2
        )
        self:timeOut(function()
                self.Spine_battleResult_title:play("battle_end_win3_1", false)
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
        self.Image_battleResult_role_mirror:setVisible(true)
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
    if self.Image_lingbo:isVisible() then
        table.insert(aniNode, self.Image_lingbo)
    end
    if self.Image_reward:isVisible() then
        table.insert(aniNode, self.Image_reward)
    end
    if #aniNode > 0 then
        ViewAnimationHelper.displayMoveNodes(aniNode, {direction = 1, distance = 150, wait = 0, delay = 0.15, time = 0.5})
    end

    self:timeOut(
        function()
            self.isEnableTouching_ = true
            self.Label_continue:show()
            Utils:blinkRepeatAni(self.Label_continue)
        end,
        1.5
    )
end

function TheaterDatingResultView:createHeroModel()
    local heroCid = self.theaterLevelCfg_.endShow[1]
    local skinCid = self.theaterLevelCfg_.endShow[2]
    local skinInfo = TabDataMgr:getData("HeroSkin", skinCid)
    local modelInfo = TabDataMgr:getData("HeroModle",skinInfo.paint)

    local model = Utils:createHeroModel(heroCid, self.Image_battleResult_hero, 0.8, skinCid)
    local hero_pos = ccp(20, -550)
    hero_pos.x = hero_pos.x + modelInfo.battleEndPosition.x
    hero_pos.y = hero_pos.y + modelInfo.battleEndPosition.y
    model:setPosition(hero_pos)

    self.Image_battleResult_hero:setScale(modelInfo.battleEndSize + 0.5)
    self.modelEndSize = modelInfo.battleEndSize or 1.3

    local model1 = Utils:createHeroModel(heroCid, self.Image_battleResult_role_mirror, 0.8, skinCid)
    model1:update(0.1)
    model1:stop()
    self.Image_battleResult_role_mirror:show()

    local tx = CCRenderTexture:create(1136,1000)
    tx:begin()
    self.Image_battleResult_role_mirror:visit()
    tx:endToLua()

    local yinziPos = ccp(-320, -350)
    local yingzi = Sprite:createWithTexture(tx:getSprite():getTexture())
    yingzi:setAnchorPoint(ccp(0, 0))
    yingzi:setPosition(yinziPos)
    yingzi:setFlipY(true)
    yingzi:setScale(self.modelEndSize * 1.05)
    model1:removeFromParent()
    self.Image_battleResult_role_mirror:addChild(yingzi)
end

return TheaterDatingResultView
