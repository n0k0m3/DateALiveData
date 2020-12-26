
local BattleResultView = class("BattleResultView", BaseLayer)

function BattleResultView:initData()
    self.statistics_ = BattleDataMgr:getController().getStatistics()
    self.battleType_ = BattleDataMgr:getBattleType()
    self.resultData_ = BattleDataMgr:getBattleResultData() or {}
    local dropReward = {}
    self.rewardList_ = {}
    self.rewardList_simulationTrial = {} --模拟试炼奖励
    if self.battleType_ == EC_BattleType.COMMON then
        self.levelCid_ = BattleDataMgr:getPointId()
        self.levelCfg_ = FubenDataMgr:getLevelCfg(self.levelCid_)
        dropReward = self.resultData_.dropReward
        self.passTime_ = self.statistics_.time
    elseif self.battleType_ == EC_BattleType.ENDLESS then
        self.levelCid_ = BattleDataMgr:getPointId()
        self.levelCfg_ = FubenDataMgr:getEndlessCloisterLevelCfg(self.levelCid_)
        dropReward = self.statistics_.endlessReward
        local endlessInfo = FubenDataMgr:getEndlessInfo()
        self.passTime_ = endlessInfo.todayCostTime
    elseif self.battleType_ == EC_BattleType.TEAM_FIGHT then
        local teamFightEndData = TeamFightDataMgr:getBattleEndData()
        --TODO 临时克隆数据
        -- if teamFightEndData.rewards then
        --     for i,v in ipairs(teamFightEndData.results) do
        --         v.rewards = clone(teamFightEndData.rewards)
        --     end 
        -- end
        -- dump(teamFightEndData)
        -- teamFightEndData.results[2] = clone(teamFightEndData.results[1])
        -- teamFightEndData.results[3] = clone(teamFightEndData.results[1])
        -- teamFightEndData.results[4] = clone(teamFightEndData.results[1])
        -- teamFightEndData.results[5] = clone(teamFightEndData.results[1])
        
        self.levelCid_ = BattleDataMgr:getPointId()
        self.levelCfg_ = FubenDataMgr:getLevelCfg(self.levelCid_)
        dropReward = teamFightEndData.rewards or {}
        self.passTime_ = teamFightEndData.fightTime
        self.teamPlayers = teamFightEndData.results
        self.isMassReward = teamFightEndData.isSpecial
        --是否是虚拟结算
        self.invented     =  teamFightEndData.invented
        --荣誉值
        self.huntingHonor =  teamFightEndData.huntingHonor or 0
    end
    
    for i, v in ipairs(dropReward or {}) do
        if v.id == EC_SItemType.PLAYEREXP then
            self.playerExp_ = v
        elseif v.id == EC_SItemType.SPIRITEXP then
            self.spiritExp_ = v
        elseif v.id == EC_SItemType.FAVOR then
            self.favorExp_ = v
        elseif v.id == EC_SItemType.CONTRIBUTION then
            self.contribution_ = v
        else
            if v.id >=599801 and v.id <= 599895 then --模拟试炼额外奖励
                table.insert(self.rewardList_simulationTrial,v)
            else
                table.insert(self.rewardList_,v)
            end
        end
    end
    if self.passTime_ then
        self.passTime_ = math.floor(self.passTime_)
    end

    self.formation_ = FubenDataMgr:getFormation()
    self.isSingle_ = (#self.formation_ == 1)

    self.touchCount_ = 0
end

function BattleResultView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.battle.battleResultView")
end

function BattleResultView:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_touch = TFDirector:getChildByPath(ui, "Panel_touch")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
    self.Button_battleResultView_1 = TFDirector:getChildByPath(ui, "Button_battleResultView_1"):hide()

    self.Panel_rewardItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_rewardItem")
    self.Panel_role_exp_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_role_exp_item")

    self.Image_battleResul_bg = TFDirector:getChildByPath(self.Panel_root, "Image_battleResul_bg")
    self.Spine_battleResult_splash = TFDirector:getChildByPath(self.Panel_root, "Spine_battleResult_splash")
    self.Spine_battleResult_dian = TFDirector:getChildByPath(self.Panel_root, "Spine_battleResult_dian")
    self.Spine_battleResult_title = TFDirector:getChildByPath(self.Panel_root, "Spine_battleResult_title")

    self.Image_battleResult_role_mirror = TFDirector:getChildByPath(self.Panel_root, "Image_battleResult_role_mirror")
    self.Image_battleResult_hero = TFDirector:getChildByPath(self.Panel_root, "Image_battleResult_hero")

    self.Panel_reward = TFDirector:getChildByPath(self.Panel_root, "Panel_reward"):hide()
    self.Image_playerIcon = TFDirector:getChildByPath(self.Panel_reward, "Image_playerIcon")
    self.Label_playerName =  TFDirector:getChildByPath(self.Panel_reward, "Label_playerName")
    self.Label_playerLevel = TFDirector:getChildByPath(self.Panel_reward, "Label_playerLevel")
    self.Label_playerExp = TFDirector:getChildByPath(self.Panel_reward, "Label_playerExp")
    self.LoadingBar_playerExp = TFDirector:getChildByPath(self.Panel_reward, "Image_playerExp.LoadingBar_playerExp")
    self.Image_reward = TFDirector:getChildByPath(self.Panel_reward, "Image_reward")
    self.Label_reward_title = TFDirector:getChildByPath(self.Image_reward, "Label_reward_title")
    self.PageView_reward = TFDirector:getChildByPath(self.Panel_reward, "PageView_reward")
    self.Button_rightArrow = TFDirector:getChildByPath(self.Image_reward, "Button_rightArrow")
    self.Button_leftArrow = TFDirector:getChildByPath(self.Image_reward, "Button_leftArrow")
    self.Panel_role_exps = TFDirector:getChildByPath(self.Panel_reward, "Panel_role_exps")

    self.Image_exp_bg = TFDirector:getChildByPath(self.Panel_reward, "Image_exp_bg")
    self.Image_playerExp = TFDirector:getChildByPath(self.Panel_reward, "Image_playerExp")
    self.Image_role_bg = TFDirector:getChildByPath(self.Panel_reward, "Image_role_bg")
    self.Image_reward = TFDirector:getChildByPath(self.Panel_reward, "Image_reward")
    -- 扩展奖励
    self.Image_extend          = TFDirector:getChildByPath(self.Panel_reward, "Image_extend"):hide()
    self.Label_extend_title    = TFDirector:getChildByPath(self.Panel_reward, "Label_extend_title")
    self.Label_extend_title_en = TFDirector:getChildByPath(self.Panel_reward, "Label_extend_title_en")
    self.Label_extend_value    = TFDirector:getChildByPath(self.Panel_reward, "Label_extend_value")
    self.Panel_extend          = TFDirector:getChildByPath(self.Panel_reward, "Panel_extend")
    --------------------------------
    self.ScrollView_reward = TFDirector:getChildByPath(self.Panel_reward, "ScrollView_reward")
    self.list_reward = UIListView:create(self.ScrollView_reward)
    self.list_reward:setItemsMargin(10)


    self.Panel_evaluation = TFDirector:getChildByPath(self.Panel_root, "Panel_evaluation"):hide()
    self.Image_pass_time = TFDirector:getChildByPath(self.Panel_evaluation, "Image_pass_time"):hide()
    self.Label_time_title = TFDirector:getChildByPath(self.Image_pass_time, "Label_time_title")
    self.Label_time_title_flag = TFDirector:getChildByPath(self.Image_pass_time, "Label_time_title_flag")
    self.Label_pass_time = TFDirector:getChildByPath(self.Image_pass_time, "Label_pass_time")
    self.Image_pass_review = TFDirector:getChildByPath(self.Panel_evaluation, "Image_pass_review"):hide()
    self.Label_review_title = TFDirector:getChildByPath(self.Image_pass_review, "Label_review_title")
    self.Panel_target = {}
    for i = 1, 3 do
        local item = {}
        item.root = TFDirector:getChildByPath(self.Panel_evaluation, "Panel_target_" .. i)
        item.Image_star = TFDirector:getChildByPath(item.root, "Image_star")
        item.Image_star_gray = TFDirector:getChildByPath(item.root, "Image_star_gray")
        item.Label_target = TFDirector:getChildByPath(item.root, "Label_target")
        item.Label_target_gray = TFDirector:getChildByPath(item.root, "Label_target_gray")
        self.Panel_target[i] = item

        if self.levelCfg_ and self.levelCfg_.dungeonType == EC_FBLevelType.HWX then
            item.Image_star:setTexture("ui/hwx/map/023.png")
            item.Image_star_gray:setTexture("ui/hwx/map/022.png")
        end


    end
    self.Image_effect = {}
    self.Image_effect[1] = TFDirector:getChildByPath(self.Panel_evaluation, "Image_battleResultView_2(3)")
    self.Image_effect[2] = TFDirector:getChildByPath(self.Panel_evaluation, "Image_battleResultView_2(2)")
    self.Image_effect[3] = TFDirector:getChildByPath(self.Panel_evaluation, "Image_battleResultView_2")
    self.Image_lingbo = TFDirector:getChildByPath(self.Panel_root, "Image_lingbo"):hide()
    self.Label_lingbo_title = TFDirector:getChildByPath(self.Panel_evaluation, "Label_lingbo_title")
    self.Label_lingbo_progress = TFDirector:getChildByPath(self.Image_lingbo, "Label_lingbo_progress")
    self.Image_contribution = TFDirector:getChildByPath(self.Panel_evaluation, "Image_contribution"):hide()
    self.Label_contribution_title = TFDirector:getChildByPath(self.Image_contribution, "Label_contribution_title")
    self.Label_contribution = TFDirector:getChildByPath(self.Image_contribution, "Label_contribution")

    self.Image_endless = TFDirector:getChildByPath(self.Panel_evaluation, "Image_endless"):hide()
    self.Label_endless_level = TFDirector:getChildByPath(self.Image_endless, "Label_endless_level")
    self.Label_endless_title = TFDirector:getChildByPath(self.Image_endless, "Label_endless_title")

    self.Image_skyladder_fight = TFDirector:getChildByPath(self.Panel_evaluation, "Image_skyladder_fight"):hide()
    self.Label_ladder_fight_core = TFDirector:getChildByPath(self.Image_skyladder_fight, "Label_ladder_fight_core")

    self.Image_skyladder_time = TFDirector:getChildByPath(self.Panel_evaluation, "Image_skyladder_time"):hide()
    self.Label_skyladder_time_score = TFDirector:getChildByPath(self.Image_skyladder_time, "Label_skyladder_time_score")

    self.Image_score = TFDirector:getChildByPath(self.Panel_evaluation, "Image_score"):hide()
    self.Label_score = TFDirector:getChildByPath(self.Image_score, "Label_score")

	self.Image_monster_score = TFDirector:getChildByPath(self.Panel_evaluation, "Image_monster_score"):Hide()
	self.Image_monster_score.curScore = TFDirector:getChildByPath(self.Image_monster_score, "score_cur")
	self.Image_monster_score.historyScore = TFDirector:getChildByPath(self.Image_monster_score, "score_history")
	self.Image_monster_score.maxScore = TFDirector:getChildByPath(self.Image_monster_score, "score_max")

    --试炼精灵
    self.Panel_simlationTrial = TFDirector:getChildByPath(self.Panel_evaluation, "Panel_simlationTrial"):hide()
    self.Panel_simlationTrial.Image_reward1 = TFDirector:getChildByPath(self.Panel_simlationTrial, "Image_reward1")
    self.Panel_simlationTrial.Image_reward2 = TFDirector:getChildByPath(self.Panel_simlationTrial, "Image_reward2")
    local Label_con_reward_name1 = TFDirector:getChildByPath(self.Panel_simlationTrial.Image_reward1, "Label_con_reward_name1")
    local Label_con_reward_name2 = TFDirector:getChildByPath(self.Panel_simlationTrial.Image_reward1, "Label_con_reward_name2")
    Label_con_reward_name1:setSkewX(10)
    Label_con_reward_name2:setSkewX(10)
    local Image_con_reward_1  = TFDirector:getChildByPath(self.Panel_simlationTrial.Image_reward1, "Image_con_reward_1")
    local Image_con_reward_2  = TFDirector:getChildByPath(self.Panel_simlationTrial.Image_reward1, "Image_con_reward_2")
    local Label_extend_title_ = TFDirector:getChildByPath(self.Panel_simlationTrial.Image_reward1, "Label_extend_title")
    local Image_con_box1  = TFDirector:getChildByPath(self.Panel_simlationTrial.Image_reward1, "Image_con_box1")
    local Image_con_box2  = TFDirector:getChildByPath(self.Panel_simlationTrial.Image_reward1, "Image_con_box2")
    self.Panel_simlationTrial.Image_lock = TFDirector:getChildByPath(self.Panel_simlationTrial, "Image_con_lock")
    local Label_con_tip = TFDirector:getChildByPath(self.Panel_simlationTrial.Image_lock, "Label_con_tip")
    local simulationId = FubenDataMgr:getSelectSimulationHeroId()
    local cfg = FubenDataMgr:getSimulationTrialCfg(simulationId)
    if cfg then
        local resCfg = cfg.battleResult
        Label_con_tip:setTextById(resCfg.contip)
        Image_con_box1:setTexture(resCfg.box1)
        Image_con_box2:setTexture(resCfg.box2)
        Label_con_reward_name1:setTextById(resCfg.rewardName1)
        Label_con_reward_name2:setTextById(resCfg.rewardName2)
        Label_extend_title_:setTextById(resCfg.extendTitle)

        if resCfg.boxFrame then
            Image_con_reward_1:setTexture(resCfg.boxFrame)
            Image_con_reward_2:setTexture(resCfg.boxFrame)
        end
    end

    --if simulationId == 110211 then
    --    Label_con_tip:setTextById(2108110)
	--	local image = "ui/battle/result/0001.png"
	--	local Image_con_reward_1  = TFDirector:getChildByPath(self.Panel_simlationTrial.Image_reward1, "Image_con_reward_1")
	--	local Image_con_reward_2  = TFDirector:getChildByPath(self.Panel_simlationTrial.Image_reward1, "Image_con_reward_2")
	--	Image_con_reward_1:setTexture(image)
	--	Image_con_reward_2:setTexture(image)
    --    Image_con_box1:setTexture("ui/battle/result/zhezhi1.png")
    --    Image_con_box2:setTexture("ui/battle/result/zhezhi2.png")
    --    Label_con_reward_name1:setTextById(2108160)
    --    Label_con_reward_name2:setTextById(2108161)
    --    Label_extend_title_:setTextById(2108164)
    --elseif simulationId == 111411 then
    --    Label_con_tip:setTextById(2108154)
    --    Image_con_box1:setTexture("ui/battle/result/00033.png")
    --    Image_con_box2:setTexture("ui/battle/result/00044.png")
    --    Label_con_reward_name1:setTextById(2108162)
    --    Label_con_reward_name2:setTextById(2108163)
    --    Label_extend_title_:setTextById(2108165)
    --elseif simulationId == 111511 then
    --    Label_con_tip:setTextById(2108155)
    --    Image_con_box1:setTexture("ui/battle/result/00033.png")
    --    Image_con_box2:setTexture("ui/battle/result/00044.png")
    --    Label_con_reward_name1:setTextById(2108162)
    --    Label_con_reward_name2:setTextById(2108163)
    --    Label_extend_title_:setTextById(2108165)
    --elseif simulationId == 110113 then
    --    Label_con_tip:setTextById(2108194)
    --    Image_con_box1:setTexture("ui/battle/result/00333.png")
    --    Image_con_box2:setTexture("ui/battle/result/00444.png")
    --    Label_con_reward_name1:setTextById(2108197)
    --    Label_con_reward_name2:setTextById(2108198)
    --    Label_extend_title_:setTextById(2108199)
    --elseif simulationId == 110414 then
    --    Label_con_tip:setTextById(2108221)
    --    Image_con_box1:setTexture("ui/simulation_trial5/box3_1.png")
    --    Image_con_box2:setTexture("ui/simulation_trial5/box3.png")
    --    Label_con_reward_name1:setTextById(2108224)
    --    Label_con_reward_name2:setTextById(2108225)
    --    Label_extend_title_:setTextById(2108226)
    --end
    self.Panel_simlationTrial.ScrollView_reward = TFDirector:getChildByPath(self.Panel_simlationTrial, "ScrollView_reward")
    self.Panel_simlationTrial.list_reward = UIListView:create(self.Panel_simlationTrial.ScrollView_reward)
    self.Panel_simlationTrial.list_reward:setItemsMargin(10)


    self.Label_continue = TFDirector:getChildByPath(self.Panel_root, "Label_continue")
    self.teamAttackPage = TFDirector:getChildByPath(self.Panel_root, "Panel_team_Attack"):hide()
    self.Button_share = TFDirector:getChildByPath(self.Panel_root, "Button_share"):hide()

    self.teamAttackPage.Label_passtime_value = self.teamAttackPage:getChildByName("Label_passtime_value")
    self.teamAttackPage.Image_team_pass_time = self.teamAttackPage:getChildByName("Image_team_pass_time"):hide()
    self.teamAttackPage.Label_team_pass_time = self.teamAttackPage.Image_team_pass_time:getChildByName("Label_team_pass_time")

    self.Image_attackNum = TFDirector:getChildByPath(self.Panel_evaluation, "Image_attackNum"):Hide()
    self.Label_attackNum = TFDirector:getChildByPath(self.Image_attackNum, "Label_attackNum")

    self:refreshView()
end

function BattleResultView:refreshTeamPage()

    local timestamp = self.passTime_ / 1000
    local hour, min, sec = Utils:getTime(timestamp, true)
    self.teamAttackPage.Label_passtime_value:setTextById(800014, min, sec)
    local players = self.teamPlayers
    local playerCount = #players
    local battleData = BattleDataMgr:getBattleData()
    local item_model = self.teamAttackPage:getChildByName("Panel_item_1")
    local posY = -180
    if playerCount > 3 then
        posY = -180
        item_model:setScale(0.75)
    else
        posY = -240
        item_model:setScale(1)
    end  
    local TeamItemPosCfg = {
        [1] = {me.p(0,posY)},
        [2] = {me.p(-180,posY),me.p(180,posY)},
        [3] = {me.p(-320,posY),me.p(0,posY),me.p(320,posY)},
        [4] = {me.p(-375,posY),me.p(-125,posY),me.p(125,posY),me.p(375,posY)},
        [5] = {me.p(-440,posY),me.p(-220,posY),me.p(0,posY),me.p(220,posY),me.p(440,posY)},
    }
    local function _getHeroData(pid)
        for i, heroData in ipairs(battleData.heros) do
            if heroData.pid == pid then
                return heroData
            end
        end
    end
    local totalHurt = 0
    for i,v in ipairs(players) do
        totalHurt = totalHurt + v.hurt
    end
-- Box("playerCount11:"..tostring(playerCount))
    self.teamHeroItems = {}
    for i=1,playerCount do
        local playerInfo = players[i]
        local panel_item = item_model
        if i ~= 1 then
            panel_item = item_model:clone()
            panel_item:show()
            self.teamAttackPage:addChild(panel_item)
        end
     
        panel_item:setVisible(true)
        panel_item:setPosition(TeamItemPosCfg[playerCount][i])
        local roleRewad  = panel_item:getChildByName("Panel_reward") --奖励
        local Image_bg3 = roleRewad:getChildByName("Image_bg3")
        Image_bg3:setVisible(MainPlayer:getPlayerId() == playerInfo.pid)
        local Image_syts = roleRewad:getChildByName("Image_syts") -- 收益提升
        Image_syts:setVisible(self.isMassReward)
        local ScrollView_role_reward = roleRewad:getChildByName("ScrollView_role_reward") -- 收益提升

        local roleRewardList = UIListView:create(ScrollView_role_reward)
        panel_item.roleRewardList = roleRewardList
        roleRewardList:setItemsMargin(3)
        if playerInfo.rewards then
            for i, v in ipairs(playerInfo.rewards) do 
                if v.id ~= EC_SItemType.PLAYEREXP and v.id ~= EC_SItemType.SPIRITEXP and
                    v.id ~= EC_SItemType.FAVOR and v.id ~= EC_SItemType.CONTRIBUTION then
                    local item = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
                    item:setScale(0.7)
                    roleRewardList:pushBackCustomItem(item)
                    PrefabDataMgr:setInfo(item, v.id, v.num)
                end
            end
        end

        local roleitem   = panel_item:getChildByName("Panel_item")
        panel_item.roleitem = roleitem
        panel_item.pid   = playerInfo.pid
        self.teamHeroItems[i] = panel_item
        local hero_panel = roleitem:getChildByName("Panel_hero")
        local info_panel = roleitem:getChildByName("Panel_info")
        local mvp_panel = roleitem:getChildByName("Panel_mvp")
        local fight_panel = roleitem:getChildByName("Panel_fight")
        local ctrl_panel = roleitem:getChildByName("Panel_ctrl")
        local heroData =_getHeroData(playerInfo.pid)
        local skinInfo = TabDataMgr:getData("HeroSkin", heroData.skinId)
        hero_panel:getChildByName("Image_role_bg"):setTexture(skinInfo.backdrop)
        hero_panel:getChildByName("Image_role_bg"):setVisible(true)
        hero_panel:getChildByName("Panel_role"):setVisible(true)
        info_panel:getChildByName("Image_pinzhi"):setTexture(HeroDataMgr:getQualityPic(nil,heroData.quality))
        local hero_panel_size = hero_panel:getContentSize()
        local model_panel = hero_panel:getChildByName("Panel_role")
        local model = Utils:createTeamHeroModel(-1, model_panel,heroData.skinId)
        if playerInfo.pid == MainPlayer:getPlayerId() then
            self.mySkinId = heroData.skinId
        end
        -- model:update(0.001)
        -- model:stop()
        -- local hero_camera = CCRenderTexture:create(hero_panel_size.width, hero_panel_size.height, kCCTexture2DPixelFormat_RGBA8888)
        -- local camerapos = hero_panel:convertToWorldSpace(me.p(0,hero_panel_size.height/2))
        -- hero_camera:setPosition(me.p(camerapos))
        -- hero_camera:begin()
        -- model_panel:visit()
        -- hero_camera:endToLua()
        -- local hero_pic = Sprite:createWithTexture(hero_camera:getSprite():getTexture())
        -- hero_pic:setFlipY(true)
        -- hero_pic:setPosition(me.p(0,hero_panel_size.height/2))
        -- hero_panel:addChild(hero_pic,2)
        -- model:removeFromParent()
        -- local shadowModel = Utils:createHeroModel(-1, model_panel, 0.75,heroData.skinId)
        -- shadowModel:update(0.001)
        -- shadowModel:stop()
        -- shadowModel:setColor(ccc3(0, 0, 0))
        info_panel:setOpacity(0)
        info_panel:runAction(Sequence:create({DelayTime:create(2.5),FadeIn:create(0.1)}))
        info_panel:getChildByName("Image_captain_bg"):setVisible(MainPlayer:getPlayerId() == playerInfo.pid)
        info_panel:getChildByName("Label_name"):setString(tostring(heroData.pname))
        info_panel:getChildByName("Label_name"):setVisible(true)
        -- if playerInfo.mvp == true then
        --     self.UIAnimPlayList[2] = self.uiAnimList[2][i]
        -- end
        ctrl_panel:getChildByName("Image_ctrl_bg"):setTexture("ui/fight_result/lianji_ditu_2.png")
        fight_panel:getChildByName("Label_fight_percent"):enableOutline(ccc4(48,53,74,255),1)
        fight_panel:getChildByName("Image_num_bg"):setTexture("ui/fight_result/number_2.png")
        if playerInfo.mvp == true then
            ctrl_panel:getChildByName("Image_ctrl_bg"):setTexture("ui/fight_result/lianji_ditu_1.png")
            fight_panel:getChildByName("Label_fight_percent"):enableOutline(ccc4(241,120,44,255),1)
            fight_panel:getChildByName("Image_num_bg"):setTexture("ui/fight_result/number_1.png")
            --创建mvp特效
            local mvpEffectA = SkeletonAnimation:create("effect/effect_ui20/effect_ui20")
            mvpEffectA:setAnimationFps(GameConfig.ANIM_FPS)
            mvpEffectA:setPosition(me.p(8,205))
            mvp_panel:addChild(mvpEffectA)
            mvpEffectA:setVisible(false)
            local mvpEffectB = SkeletonAnimation:create("effect/effect_ui20/effect_ui20")
            mvpEffectB:setAnimationFps(GameConfig.ANIM_FPS)
            mvpEffectB:setPosition(me.p(1,430))
            mvp_panel:addChild(mvpEffectB)
            mvpEffectB:setVisible(false)
            local mvpEffectC = SkeletonAnimation:create("effect/effect_ui20/effect_ui20")
            mvpEffectC:setAnimationFps(GameConfig.ANIM_FPS)
            mvpEffectC:setPosition(me.p(-13,16))
            mvp_panel:addChild(mvpEffectC)
            mvpEffectC:setVisible(false)
            mvpEffectA:addMEListener(TFARMATURE_COMPLETE,function(sklete)
                sklete:removeMEListener(TFARMATURE_COMPLETE)
                mvpEffectB:setVisible(true)
                mvpEffectB:play("MVP2", -1)
                mvpEffectC:setVisible(true)
                mvpEffectC:play("xunhuan", -1)
                sklete:removeFromParent()
                self:timeOut(function()
                    self.isEnableTouching = true
                    self.Label_continue:setVisible(true)
                end, 0.5)
                
            end)
            local mvpShowAct = {DelayTime:create(3.0),FadeIn:create(0.1),CallFunc:create(function()
                mvpEffectA:setVisible(true)
                mvpEffectA:play("ALL", 1)
            end)}
            mvp_panel:setOpacity(0)
            mvp_panel:runAction(Sequence:create(mvpShowAct))
        end
        fight_panel:getChildByName("Label_fight_num"):setString(tostring(playerInfo.hurt))
        fight_panel:getChildByName("Label_fight_num"):setVisible(true)
        totalHurt = math.max(1,totalHurt)
        fight_panel:getChildByName("Label_fight_percent"):setString(string.format("%d%%",math.floor(playerInfo.hurt/totalHurt *100 + 0.5)))
        fight_panel:getChildByName("Image_num_bg"):setVisible(true)
        fight_panel:getChildByName("Image_fight_logo"):setVisible(true)

        local btn_add_frd = ctrl_panel:getChildByName("Button_add_friend")
        btn_add_frd:setVisible(false)
        local btn_thumb = ctrl_panel:getChildByName("Button_thumb")
        btn_thumb:setTextureNormal("ui/fight_result/like_1.png")
        btn_thumb:setVisible(false)
        local btn_inform = ctrl_panel:getChildByName("Button_inform")
        btn_inform.pinfo = playerInfo
        btn_inform.pdata = heroData
        btn_inform:setTextureNormal("ui/fight_result/inform_1.png")
        btn_inform:setVisible(false)

        ctrl_panel:getChildByName("Image_ctrl_bg"):setVisible(false)
        local heroRelation = self:getFriendStatus(playerInfo.pid)
        btn_thumb.pid = playerInfo.pid
        btn_thumb:onClick(function()
            btn_thumb:setTouchEnabled(false)
            btn_thumb:setTextureNormal("ui/fight_result/like_2.png")
            --send thump up message
            TeamFightDataMgr:requestGiveThumbUp(btn_thumb.pid,self.levelCid_)
            TFAudio.playEffect("sound/ui/function_004.mp3",false,1,0)
        end)

        btn_inform:onClick(function()
            btn_inform:setTouchEnabled(false)
            local alertparams = clone(EC_GameAlertParams)
            alertparams.msg = TextDataMgr:getText(2100155, btn_inform.pdata.pname)
            alertparams.comfirmCallback = function()
                --send thump up message
                local heroIns = battleController.getPlayer(btn_inform.pinfo.pid)
                local hurted = heroIns and heroIns:getRevHurtValue() or btn_inform.pinfo.hurt ---这个判断的主要作用是防止有玩家在符石挑战中途掉线 导致heroIns 为空
                local informInfo = {btn_inform.pinfo.pid,self.levelCid_,btn_inform.pinfo.hurt,hurted,self.passTime_}
                --TeamFightDataMgr:requestInformPlayer(informInfo)
                Utils:openView("playerInfo.TipOff",informInfo)
                -- btn_inform:setTextureNormal("ui/fight_result/inform_2.png")
                -- btn_inform:getChildByName("Label_title"):setTextById(100000082)
                self.btn_inform = btn_inform;
            end
            alertparams.cancelCallback = function()
                btn_inform:setTouchEnabled(true)
            end
            showGameAlert(alertparams)
            
        end)
        if heroRelation ~= -1 then
            btn_inform:getChildByName("Label_title"):setTextById(2100154)
            btn_inform:setVisible(true)
        end
        if heroRelation == 1 then
            -- btn_thumb:setPosition(me.p(0,45))
            btn_thumb:setVisible(true)
        end

        if heroRelation == 0 then
            btn_add_frd.pid = playerInfo.pid
            -- btn_add_frd:setPosition(me.p(-45,45))
            btn_add_frd:setVisible(true)
            btn_add_frd:onClick(function()
                btn_add_frd:setTouchEnabled(false)
                btn_add_frd:setGrayEnabled(true)
                FriendDataMgr:addFriend(btn_add_frd.pid)
            end)
            -- btn_thumb:setPosition(me.p(45,45))
            btn_thumb:setVisible(true)

        end
        if panel_item then
            panel_item:setOpacity(0)
            local actArr = {DelayTime:create(1.5),FadeIn:create(1)}
            panel_item:runAction(Sequence:create(actArr))
        end
    end

    if BattleDataMgr:getController().isBossChallenge() then
        local Panel_flags = self.teamAttackPage:getChildByName("Panel_flags")
        local Panel_flag_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_flag_item")
        local bossCfg = TeamFightDataMgr:getBattleCfg()
        local goalDescribe = bossCfg.goalDescribe
        local medalItems = {500128,500129,500130}
        for i,desc in ipairs(goalDescribe) do
            local item = Panel_flag_item:clone()
            local icon = TFDirector:getChildByPath(item,"Image_icon")
            local itemCfg = GoodsDataMgr:getItemCfg(medalItems[i])
            icon:setTexture(itemCfg.icon)
            TFDirector:getChildByPath(item,"Label_desc"):setText(desc)
            local isReach = FubenDataMgr:judgeStarIsActive(bossCfg.dungeonID, i)
            TFDirector:getChildByPath(item,"Image_state"):setVisible(isReach)
            item:setPosition(ccp(-1,-(i - 1) * item:getContentSize().height))
            Panel_flags:addChild(item)
        end

        if playerCount > 1 then
            for i,v in ipairs(self.teamHeroItems) do
                v:setScale(v:getScale() * (1- playerCount * 0.07))
                v:setPositionX(v:getPositionX() - i * (playerCount * 30) - 30)
            end
        end
        Panel_flags:setOpacity(0)
        Panel_flags:runAction(Sequence:create({DelayTime:create(2.0),FadeIn:create(1.0)}))
    end
    if TeamFightDataMgr.nTeamType == 9 then
        self.teamAttackPage.Image_team_pass_time:show()
        local _, hour, min, sec = Utils:getDHMS(self.passTime_*0.001, true)
        local millisecond = math.floor(math.floor(self.passTime_)%1000)
        local milsec = string.format("%.3d", millisecond)
        self.teamAttackPage.Label_team_pass_time:setText(string.format("%s:%s:%s" , min, sec,milsec))

        if playerCount > 2 then
            for i,v in ipairs(self.teamHeroItems) do
                v:setScale(v:getScale() * 0.9)
                v:setPositionX(v:getPositionX() - i * 50)
            end
        end
    end
end

function BattleResultView:getFriendStatus(pid)
    if MainPlayer:getPlayerId() == pid then
        return -1
    end
    if FriendDataMgr:isFriend(pid) then
        return 1
    end
    return 0
end

function BattleResultView:refreshView()
    
	dump(self.levelCfg_)
    if self.battleType_ == EC_BattleType.COMMON then
        local levelGroupCid = self.levelCfg_.levelGroupId
        if FubenDataMgr:isSimulationGroup(1,levelGroupCid) then --模拟试炼第一章
        
            self.Image_pass_time:hide()
            self.Image_pass_review:hide()
            self.Image_endless:hide()
            self.Image_score:hide()
            for i, v in ipairs(self.Image_effect) do
                v:hide()
            end
            self.Panel_simlationTrial:show()
            ------------
            self.Panel_simlationTrial.Image_lock:setVisible(not FubenDataMgr:hasFAN_ZHE())
            local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            self.Panel_simlationTrial.list_reward:removeAllItems()
            
            local size = self.Panel_simlationTrial.list_reward:getContentSize()
            size.width = #self.rewardList_simulationTrial * 79
            self.Panel_simlationTrial.list_reward:setContentSize(size)
            for i, v in ipairs(self.rewardList_simulationTrial) do --rewardList_simulationTrial
                local item = Panel_goodsItem:clone()
                item:setScale(0.65)
                self.Panel_simlationTrial.list_reward:pushBackCustomItem(item)
                PrefabDataMgr:setInfo(item, v.id, v.num)
            end
        elseif BattleDataMgr:isMusicGameLevel() then
            self.Image_pass_time:show()
            self.Image_pass_review:setVisible(false)
            self.Label_time_title:setTextById(13316479)
            self.Label_time_title_flag:setVisible(false)
            self.Label_pass_time:setText(string.format("%.2f",self.resultData_.percent).."%")
        else
            self.Image_pass_time:show()

            if self.levelCfg_.isHideTarget then
                self.Image_pass_review:hide()
            else
                self.Image_pass_review:setVisible(#self.levelCfg_.starType > 0)
                for i, v in ipairs(self.Panel_target) do
                    v.root:show()
                end
                for i, v in ipairs(self.Image_effect) do
                    v:hide()
                end
            end

            if self.Image_pass_time:isVisible() then
                local levelGroupCid = self.levelCfg_.levelGroupId
                if levelGroupCid == EC_DailyType.EXP or levelGroupCid == EC_DailyType.GOLD then
                    self.Label_time_title:setTextById(300621)
                    self.Label_pass_time:setText(self.statistics_.endScore)
                elseif levelGroupCid == EC_DailyType.PRAY then
                    self.Label_time_title:setTextById(300622)
                    self.Label_pass_time:setText(self.statistics_.killNum)
                elseif levelGroupCid == EC_DailyType.ZHIDIAN then
                    self.Label_time_title:setTextById(300623)
                    self.Label_pass_time:setText(self.statistics_.maxComboNum)
                else
                    if self.levelCfg_.dungeonType == EC_FBLevelType.HALLOWEEN then
                        local timestamp = self.passTime_ / 1000
                        -- local msec = string.format("%02d", self.passTime_ % 1000 * 0.1)
                        local hour, min, sec = Utils:getTime(timestamp, true)
                        self.Label_pass_time:setTextById(800014, min, sec)
                    elseif self.levelCfg_.dungeonType == EC_FBLevelType.THEATER_FIGHTING then
                        local theaterBossInfo = FubenDataMgr:getTheaterBossInfo()
                        self.Image_lingbo:setVisible(theaterBossInfo.odeumType == EC_TheaterBossType.LINGBO)
                        local _, min, sec = Utils:getTime(self.passTime_ * 0.001, true)
                        self.Label_pass_time:setTextById(800014, min, sec)


					elseif self.levelCfg_.dungeonType == EC_FBLevelType.MONSTER_TRIAL then
						local _, min, sec = Utils:getTime(self.passTime_ * 0.001, true)
                        self.Label_pass_time:setTextById(800014, min, sec)

						self.Image_pass_review:Hide()
						self.Image_monster_score:Show()
						local monsterData = FubenDataMgr:getMonsterTrialSettlementData()
						self.Image_monster_score.curScore:setText(monsterData.score)
						self.Image_monster_score.historyScore:setText(monsterData.history)
						self.Image_monster_score.maxScore:setText(monsterData.maxScore)

                    elseif self.levelCfg_.dungeonType == EC_FBLevelType.SKYLADDER then
                        local cfg = SkyLadderDataMgr:getRankMatchLevelCfg(self.levelCfg_.id)
                        if cfg then
                            self.Image_skyladder_fight:setVisible(true)
                            self.Label_ladder_fight_core:setText(cfg.passRate)
                            if cfg.timeRate > 0 then
                                local curTime = math.ceil(self.passTime_ / 1000)
                                local remainTime = self.levelCfg_.time - curTime
                                remainTime = remainTime > 0 and remainTime or 0
                                local rate = math.floor(cfg.timeRate*remainTime)
                                dump({self.levelCfg_.time,cfg.timeRate,remainTime,curTime})
                                self.Image_skyladder_time:setVisible(true)
                                    self.Label_skyladder_time_score:setText(rate)
                            end
                        end
                        local _, min, sec = Utils:getTime(self.passTime_ * 0.001, true)
                        self.Label_pass_time:setTextById(800014, min, sec)
                    elseif self.levelCfg_.dungeonType == EC_FBLevelType.HWX_TOWER then
                        local _, min, sec = Utils:getTime(self.passTime_ * 0.001, true)
                        self.Label_pass_time:setTextById(800014, min, sec)
                        local displayCfg = LinkageHwxDataMgr:getCityDisplayCfg(self.levelCid_)
                        if displayCfg and 3 == displayCfg.displayDetail then
                            self.Image_skyladder_fight:setVisible(true)
                            local timeRate = 1
                            local curTime = math.ceil(self.passTime_ / 1000)
                            local remainTime = self.levelCfg_.time - curTime
                            remainTime = remainTime > 0 and remainTime or 0
                            local rate = math.floor(timeRate*remainTime)
                            dump({self.levelCfg_.time,timeRate,remainTime,curTime})
                            self.Label_ladder_fight_core:setText(rate)
                        end
                    elseif self.levelCfg_.dungeonType == EC_FBLevelType.KUANGSAN_FIGHTING then
                        local _, min, sec = Utils:getTime(self.passTime_ * 0.001, true)
                        self.Label_pass_time:setTextById(800014, min, sec)
                        local cfg = FubenDataMgr:getKsanLevelInfo(self.levelCfg_.id)
                        if cfg and cfg.displayDetail == 3 then
                            local activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.KUANGSAN_FUBEN)[1]
                            if activityId then
                                local activityInfo = ActivityDataMgr2:getActivityInfo(activityId)
                                local historyInfo = activityInfo.historyInfo
                                if historyInfo then
                                    local data
                                    for k,v in pairs(historyInfo.cities) do
                                        if v.dungeon == self.levelCfg_.id then
                                            data = v
                                            break
                                        end
                                    end
                                    if data.score then
                                        self.Image_skyladder_fight:setVisible(true)
                                        self.Label_ladder_fight_core:setText(data.score)
                                    end
                                end
                            end
                        end

                        local displayMap = TabDataMgr:getData("MojinDungeonDisplay")
                        for k, v in pairs(displayMap) do
                            if v.dungeon == self.levelCid_ and v.displayDetail == 3 then
                                self.Image_score:show()
                                local activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.NEWYEAR_FUBEN)[1]
                                local activityInfo = ActivityDataMgr2:getActivityInfo(activityId)
                                local scoreData = activityInfo.extendData.battlePoints
                                local score = 0
                                for i, v in ipairs(scoreData) do
                                    if self.statistics_.hitValue >= v[1] then
                                        score = v[2]
                                        break
                                    end
                                end
                                self.Label_score:setText(score)
                                break
                            end
                        end
                    else
                        local _, min, sec = Utils:getTime(self.passTime_ * 0.001, true)
                        self.Label_pass_time:setTextById(800014, min, sec)
                    end
                    self.Label_time_title:setTextById(300618)
                end
            end
        end
    elseif self.battleType_ == EC_BattleType.ENDLESS then
        self.Image_pass_time:show()
        for i, v in ipairs(self.Image_effect) do
            v:hide()
        end
        self.Image_endless:show()

        -- 通关时间
        if self.Image_pass_time:isVisible() then
            self.Label_time_title:setTextById(300618)
            local _, min, sec = Utils:getTime(math.ceil(self.passTime_ * 0.001), true)
            self.Label_pass_time:setTextById(800014, min, sec)
        end

    elseif self.battleType_ == EC_BattleType.TEAM_FIGHT then
		
		if self.levelCfg_.teamType == 6 then
			print("-------------------self.levelCfg_.teamType == 6=" .. self.passTime_)
			self.Panel_evaluation:show()
			self.Image_pass_time:show()
			self.Label_time_title:setTextById(300618)
            local _, min, sec = Utils:getTime(math.ceil(self.passTime_ * 0.001), true)
            self.Label_pass_time:setTextById(800014, min, sec)
		end
		
        for i, v in ipairs(self.Panel_target) do
            v.root:show()
        end
        for i, v in ipairs(self.Image_effect) do
            v:hide()
        end
        --组队追猎计划显示贡献度
        if self.levelCfg_.dungeonType == EC_FBLevelType.HUNTER then 
            self.Image_exp_bg:hide()
            self.Image_extend:show()
            self.Label_extend_title:setTextById(3300026)--贡献度
            self.Label_extend_value:setText("+"..self.huntingHonor)
        else
            self.Image_exp_bg:show()
            self.Image_extend:hide()
        end

        --组队战斗虚拟结算只显示第二屏
        if self.invented then
			if self.levelCfg_.teamType ~= 6 then
				self.Panel_evaluation:hide()
			end	
            self.teamAttackPage:hide()
            self.Image_battleResult_role_mirror:setVisible(true)
            self.Label_continue:setVisible(false)
            self:checkBtnShareEnableShow()
            self:timeOut(function()
                -- self.Panel_reward:show()
                -- self:showReward()
                -- self:runRoleAnim()
                -- self:runRoleMirrorAnim()
                self:runTeamHeroAnim()
            end,0.1)
            --延迟开启点击 
            self:timeOut(function()
                self.touchCount_ = 1 -- 跳过第一屏
                self.isEnableTouching = true
            end,2.5)
        else
            self:refreshTeamPage()
            self.teamAttackPage:show()
        end
    end

    local levelCfg = BattleDataMgr:getLevelCfg()
    self.Image_attackNum:setVisible(levelCfg.dungeonType == EC_FBLevelType.WORLD_BOSS)

    -- 通关评价
    if self.Image_pass_review:isVisible() then
        self.Label_review_title:setTextById(300619)
        for i, v in ipairs(self.Panel_target) do
            local isReach = FubenDataMgr:judgeStarIsActive(self.levelCid_, i, true)
            local desc = FubenDataMgr:getStarRuleDesc(self.levelCid_, i)
            v.Image_star:setVisible(isReach)
            v.Image_star_gray:setVisible(not isReach)
            v.Label_target:setVisible(isReach)
            v.Label_target_gray:setVisible(not isReach)
            v.Label_target:setText(desc)
            v.Label_target_gray:setText(desc)
        end
    end
    -- 最高层数
    if self.Image_endless:isVisible() then
        self.Label_endless_title:setTextById(2100015)
        local endlessInfo = FubenDataMgr:getEndlessInfo()
        self.Label_endless_level:setTextById(2100016, endlessInfo.todayBest)
    end
    -- 万由里灵波值
    if self.Image_lingbo:isVisible() then
        local addLingBo = RandomGenerator.random(4, 6)
        self.Label_lingbo_progress:show():setTextById(800008, addLingBo)
    end
    -- 万由里贡献度
    if self.Image_contribution:isVisible() then
        self.Label_contribution_title:setTextById(300994)
        local count = 0
        if self.contribution_ then
            count = self.contribution_.num
        end
        self.Label_contribution:setTextById(800008, count)
    end
    -- 世界boss造成伤害
    if self.Image_attackNum:isVisible() then
        self.Label_attackNum:setText(Utils:converNumWithComma(self.statistics_.hitValue or 0))
    end

    self.Label_reward_title:setTextById(300620)
    self.Label_continue:setTextById(800038)
    Utils:blinkRepeatAni(self.Label_continue)

    self:updateReward()
    self:createHeroPanel()

    self.Label_continue:setVisible(false)
    self.Image_battleResult_hero:setVisible(false)
    self.Image_battleResult_role_mirror:setVisible(false)
    self.Spine_battleResult_splash:setVisible(false)
    self.Spine_battleResult_title:setVisible(false)
    self.Spine_battleResult_dian:setVisible(false)
    self.Image_battleResul_bg:setVisible(false)
    self.Image_battleResul_bg:setOpacity(0)

    self:runAnimationIn()
end

function BattleResultView:runRoleMirrorAnim()
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

function BattleResultView:runRoleAnim()
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

function BattleResultView:runAnimationIn()
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
        self:timeOut(function()
            self.Spine_battleResult_title:setVisible(true)
            self.Spine_battleResult_title:stop()
            self.Spine_battleResult_title:play("battle_end_win1",false)
            Utils:playSound(404)
        end, 0.2)
    end

    self.Spine_battleResult_splash:setVisible(true)
    self.Spine_battleResult_splash:play("start",false)

    self:timeOut(function()
        runBgAnim()
    end, 0.1)

    self:timeOut(function()
        self.Spine_battleResult_splash:play("loop",true)
    end, 0.9)
    self:timeOut(function()
        runTitleAnim()
    end, 0.7)
    if self.battleType_ ~= EC_BattleType.TEAM_FIGHT then
        self:timeOut(function()
            self:runRoleAnim()
            self:runRoleMirrorAnim()
            self.Image_battleResult_role_mirror:setVisible(true)
        end, 0.15)

        self:timeOut(function()
            self:showEvaluation()
            self.isEnableTouching = true
            self.Label_continue:setVisible(true)
        end, 1.5)
    end

    
end

function BattleResultView:runTeamHeroAnim()
    if self.teamHeroItems then 
        for i, item in ipairs(self.teamHeroItems) do
            item.roleitem:moveTo(0.4,0,84)
        end
    end
    --战斗胜利移出去
    if self.Spine_battleResult_title then
        local arr1 = {}
        local act3 = CCMoveBy:create(0.4,ccp(150,0))
        local act4 = CCFadeOut:create(0.4)
        act3 = EaseSineOut:create(act3)
        act4 = EaseSineOut:create(act4)
        table.insert(arr1, CCSpawn:create({act3, act4}))
        self.Spine_battleResult_title:runAction(CCSequence:create(arr1))
    end
end


function BattleResultView:createHeroPanel()
    local heroData = self.formation_[1]
    local heroId = heroData.id
    local skinCid = heroData.skinCid or HeroDataMgr:getCurSkin(heroId)
    local skinInfo = TabDataMgr:getData("HeroSkin", skinCid)
    local modelInfo = TabDataMgr:getData("HeroModle",skinInfo.paint)

    local model = Utils:createHeroModel(heroId, self.Image_battleResult_hero, 0.8, skinCid)
    local hero_pos = ccp(20, -550)
    hero_pos.x = hero_pos.x + modelInfo.battleEndPosition.x
    hero_pos.y = hero_pos.y + modelInfo.battleEndPosition.y
    model:setPosition(hero_pos)

    self.Image_battleResult_hero:setScale(modelInfo.battleEndSize + 0.5)
    self.modelEndSize = modelInfo.battleEndSize or 1.3

    local model1 = Utils:createHeroModel(heroId, self.Image_battleResult_role_mirror, 0.8, skinCid)
    model1:update(0.1)
    model1:stop()
    local tx = CCRenderTexture:create(1136,1000)
    tx:begin()
    self.Image_battleResult_role_mirror:visit()
    tx:endToLua()
    
    local yinziPos = ccp(-340, -380)
    yinziPos.x = yinziPos.x + modelInfo.battleEndYingziPos.x
    yinziPos.y = yinziPos.y + modelInfo.battleEndYingziPos.y
    local yingzi = Sprite:createWithTexture(tx:getSprite():getTexture())
    yingzi:setAnchorPoint(ccp(0, 0))
    yingzi:setPosition(yinziPos)
    yingzi:setFlipY(true)
    yingzi:setScale(self.modelEndSize * 1.05)
    model1:removeFromParent()
    self.Image_battleResult_role_mirror.model = nil
    self.Image_battleResult_role_mirror:addChild(yingzi)
end

function BattleResultView:showEvaluation()
    if self.battleType_ == EC_BattleType.TEAM_FIGHT then
        return
    end

    self.Panel_evaluation:show()
    self.Panel_reward:hide()
    self:showEvaluationNodesAnim()
end

function BattleResultView:showEvaluationNodesAnim()
    local actNodes = {}
    actNodes[#actNodes + 1] = self.Image_pass_time
    if self.Image_pass_review:isVisible() then
        actNodes[#actNodes + 1] = self.Image_pass_review
    end
    if self.Image_contribution:isVisible() then
        actNodes[#actNodes + 1] = self.Image_contribution
    end
    if self.Image_endless:isVisible() then
        actNodes[#actNodes + 1] = self.Image_endless
    end
    if self.Image_lingbo:isVisible() then
        actNodes[#actNodes + 1] = self.Image_lingbo
    end
    if self.Panel_simlationTrial:isVisible() then 
     actNodes[#actNodes + 1] = self.Panel_simlationTrial
    end
    if self.Image_attackNum:isVisible() then
        actNodes[#actNodes + 1] = self.Image_attackNum
    end
    ViewAnimationHelper.displayMoveNodes(actNodes, {direction = 1, distance = 150, wait = 0, delay = 0.15, time = 0.1})

    for i,v in ipairs(self.Panel_target) do
        local imgStar = v.Image_star
        ViewAnimationHelper.doScaleFadeInAction(imgStar, {scale = 0.01, upscale = 1.8, uptime = 0.1, downscale = 1.0, downtime = 0.05, delay = i * 0.08 + 0.25})
    end
    --
    if self.Panel_simlationTrial:isVisible() then 
        local rewardItems = self.Panel_simlationTrial.list_reward:getItems()
        for i,v in ipairs(rewardItems) do
            ViewAnimationHelper.doScaleFadeInAction(v, {scale = 0.01, upscale = 1.0, uptime = 0.1, downscale = 0.65, downtime = 0.05, delay = i * 0.06 + 0.6, callback = animOver})
        end
    end
end

function BattleResultView:showRewardsNodesAnim()
    local actNodes = {}
    actNodes[#actNodes + 1] = self.Panel_extend
    actNodes[#actNodes + 1] = self.Image_role_bg
    actNodes[#actNodes + 1] = self.Image_reward

    ViewAnimationHelper.displayMoveNodes(actNodes, {direction = 1, distance = 150, wait = 0, delay = 0.2, time = 0.1})

    for i = #self.roles_item, 1, -1 do
        local item = self.roles_item[i].root
        local function animOver()
            local spineRole = SkeletonAnimation:create("effect/battle_end_win_02/out/battle_end_win_01")
            spineRole:setPosition(ccp(0, 14))
            spineRole:play("battle_end_win3", false)
            --spineRole:playByIndex(2, -1, -1, 0)
            item:addChild(spineRole, 5)
        end
        ViewAnimationHelper.doScaleFadeInAction(item, {scale = 0.01, upscale = 1.2, uptime = 0.1, downtime = 0.05, delay = (#self.roles_item - i) * 0.06 + 0.3, callback = animOver})
    end
    local rewardItems = self.list_reward:getItems()
    for i,v in ipairs(rewardItems) do
        ViewAnimationHelper.doScaleFadeInAction(v, {scale = 0.01, upscale = 1.0, uptime = 0.1, downscale = 0.65, downtime = 0.05, delay = i * 0.06 + 0.6, callback = animOver})
    end
    self:timeOut(function()
        Utils:playSound(405)
    end, 0.3)
end

function BattleResultView:playPlayerExpAni()
    local cachePlayerInfo = FubenDataMgr:getCachePlayerInfo()
    local levelUpCfg = TabDataMgr:getData("LevelUp", cachePlayerInfo.level)
    self.LoadingBar_playerExp:setPercent(cachePlayerInfo.percent)
    local curPlayLevel = MainPlayer:getPlayerLv()
    local curExp = MainPlayer:getPlayerExp()
    local offsetLevel = curPlayLevel - cachePlayerInfo.level
    local addExp = 0
    if offsetLevel > 0 then
         for i = 1, offsetLevel do
            levelCfg = TabDataMgr:getData("LevelUp", curPlayLevel - i)
            addExp = addExp + levelCfg.playerExp
        end
    end
    addExp = addExp + curExp - cachePlayerInfo.exp
    addExp = math.max(0, addExp)
    self.Label_playerExp:setText("+"..addExp)

    local percent = {}
    for i = 1, offsetLevel do
        table.insert(percent, 100)
    end
    table.insert(percent, MainPlayer:getExpProgress())
    local co
    local function resume()
        coroutine.resume(co)
    end
    local function yield()
        coroutine.yield(co)
    end
    local tempLevel = cachePlayerInfo.level
    co = coroutine.create(function()
            for i, v in ipairs(percent) do
                Utils:progressTo(
                    self.LoadingBar_playerExp,
                    0.3, v,
                    function()
                        if i < #percent then
                            self.LoadingBar_playerExp:setPercent(0)
                        end
                        tempLevel = tempLevel + 1
                        resume()
                    end
                )
                if i < #percent then
                    local curPercent = self.LoadingBar_playerExp:getPercent()
                    local posX = curPercent / 100 * 200 - 100
                    local spineExp = SkeletonAnimation:create("effect/battle_end_win_02/out/battle_end_win_01")
                    spineExp:setPosition(ccp(posX, 0))
                    spineExp:play("battle_end_win4", false)
                    self.Image_playerExp:addChild(spineExp, 5)
                    local acts = {}
                    acts[#acts + 1] = CCMoveBy:create(0.5, ccp(100 - posX, 0))
                    acts[#acts + 1] = CCCallFunc:create(function ()
                        spineExp:setPosition(ccp(0, 0))
                        spineExp:setScaleX(0.95)
                        spineExp:play("battle_end_win5", false)
                    end)
                    spineExp:runAction(Sequence:create(acts))
                end
                yield()

                tempLevel = math.min(curPlayLevel, tempLevel)
                local levelUpCfg = TabDataMgr:getData("LevelUp", tempLevel)
                local curExp = MainPlayer:getPlayerExp()
                self.Label_playerLevel:setTextById(800006, tempLevel)
            end
    end)
    resume()
end

function BattleResultView:playSingleExpAni()
    local rawHeroData = self.formation_[1]
    local isOwnHero = rawHeroData.limitType == EC_BattleHeroType.OWN
    self.Panel_single_exp:setVisible(isOwnHero)
    if not isOwnHero then return end

    self.Panel_single_exp:show()
	local levelUpCfg = TabDataMgr:getData("LevelUp", rawHeroData.lvl)
    local percent = rawHeroData.exp / levelUpCfg.heroExp * 100
    if percent == 100 then
        percent = 0
        self.LoadingBar_single_exp:setPercent(percent)
    end
    self.Label_single_level:setTextById(800006, rawHeroData.lvl)
    self.LoadingBar_single_exp:setPercent(percent)
    local levelUpExp = HeroDataMgr:getLevelUpExp(rawHeroData.id)
    self.Label_single_rate:setTextById(800005, rawHeroData.exp, levelUpExp)

    local heroData = HeroDataMgr:getHero(rawHeroData.id)
    local offsetLevel = heroData.lvl - rawHeroData.lvl
    local percent = {}
    for i = 1, offsetLevel do
        table.insert(percent, 100)
    end
    table.insert(percent, HeroDataMgr:getExpPercent(heroData.id))

    local co
    local function resume()
        coroutine.resume(co)
    end
    local function yield()
        coroutine.yield(co)
    end
    local tempLevel = rawHeroData.lvl
    co = coroutine.create(function()
            for i, v in ipairs(percent) do
                Utils:progressToEx(
                    self.LoadingBar_single_exp,
                    0.4, v,
                    function()
                        if i < #percent then
                            self.LoadingBar_single_exp:setPercent(0)
                        end
                        tempLevel = tempLevel + 1
                        resume()
                    end
                )
                yield()
                tempLevel = math.min(heroData.lvl, tempLevel)
                local levelUpCfg = TabDataMgr:getData("LevelUp", tempLevel)
                self.Label_single_rate:setTextById(800005, heroData.exp, levelUpCfg.heroExp)
                self.Label_single_level:setTextById(800006, tempLevel)
            end
    end)
    resume()
end

function BattleResultView:showReward()
    self.Panel_reward:show()
    self.Panel_evaluation:hide()

    self:showRewardsNodesAnim()

    self:timeOut(function()
        self:playPlayerExpAni()
    end, 0)

    self:timeOut(function()
        self:updateRoleExps()
        self.isTouchEnabled = true
    end, 0.1)
end

function BattleResultView:updateReward()
    self.Label_playerName:setText(MainPlayer:getPlayerName())

    self.roles_item = {}
    for i, v in ipairs(self.formation_) do
        local item = {}
        item.root = self.Panel_role_exp_item:clone()
        item.Panel_role = TFDirector:getChildByPath(item.root, "Panel_role")
        item.Image_playerIcon = TFDirector:getChildByPath(item.root, "Image_playerIcon")
        item.Image_quality = TFDirector:getChildByPath(item.root, "Image_quality")
        item.Label_level = TFDirector:getChildByPath(item.root, "Label_level")
        item.Image_pinzhi = TFDirector:getChildByPath(item.Panel_role, "Image_pinzhi")

        item.Image_roleExp = TFDirector:getChildByPath(item.root, "Image_roleExp")
        item.LoadingBar_roleExp = TFDirector:getChildByPath(item.root, "LoadingBar_roleExp")
        item.Label_exp = TFDirector:getChildByPath(item.root, "Label_exp")
        item.Image_playerIcon:setTexture(HeroDataMgr:getIconPathById(v.id, v.skinCid))
        item.Label_level:setTextById(800006, v.lvl)
        item.Image_pinzhi:setTexture(HeroDataMgr:getQualityPic(v.id, v.quality))

        self.Panel_role_exps:addChild(item.root)
        item.root:setPosition(ccp(-((i - 1) *95)-40 , 55))
        self.roles_item[i] = item
        item.Image_roleExp:setVisible(not v.isLimitHero)
        item.Label_exp:setVisible(not v.isLimitHero)
    end
    if self.battleType_ == EC_BattleType.TEAM_FIGHT then
        self.Image_reward:getChildByName("Image_mass_sign"):setVisible(self.isMassReward)
    else
        self.Image_reward:getChildByName("Image_mass_sign"):setVisible(false)
    end
    self.Image_reward:setVisible(#self.rewardList_ > 0)
    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    self.list_reward:removeAllItems()
    for i, v in ipairs(self.rewardList_) do
        local item = Panel_goodsItem:clone()
        item:setScale(0.65)
        self.list_reward:pushBackCustomItem(item)
        PrefabDataMgr:setInfo(item, v.id, v.num)
    end
    local minX = math.min((#self.rewardList_ * 79), self.ScrollView_reward:getSize().width)
    self.ScrollView_reward:setPositionX(self.ScrollView_reward:getPositionX() - minX)
end

function BattleResultView:updateRoleExps()
    for i, v in ipairs(self.roles_item) do
        local rawHeroData = self.formation_[i]
        local isBattle = tobool(rawHeroData)
        if isBattle then
            if rawHeroData.isLimitHero then

            else
                local levelUpCfg = TabDataMgr:getData("LevelUp", rawHeroData.lvl)
                local percent
                if levelUpCfg.heroExp <= 0 then
                    percent = 0
                else
                    percent = rawHeroData.exp / levelUpCfg.heroExp * 100
                end

                if percent == 100 then
                    percent = 0
                    v.LoadingBar_roleExp:setPercent(percent)
                end
                v.LoadingBar_roleExp:setPercent(0)

                local heroData = HeroDataMgr:getHero(rawHeroData.id)
                local offsetLevel = heroData.lvl - rawHeroData.lvl
                local addExp = 0
                if offsetLevel > 0 then
                     for i = 1, offsetLevel do
                        levelCfg = TabDataMgr:getData("LevelUp", heroData.lvl - i)
                        addExp = addExp + levelCfg.heroExp
                    end
                end
                addExp = addExp + heroData.exp - rawHeroData.exp
                addExp = math.max(0, addExp)
                v.Label_exp:setText("+"..addExp)

                local percent = {}
                for i = 1, offsetLevel do
                    table.insert(percent, 100)
                end
                table.insert(percent, HeroDataMgr:getExpPercent(heroData.id))

                local co
                local function resume()
                    coroutine.resume(co)
                end
                local function yield()
                    coroutine.yield(co)
                end
                local tempLevel = rawHeroData.lvl
                co = coroutine.create(function()
                        for j, p in ipairs(percent) do
                            Utils:progressTo(
                                v.LoadingBar_roleExp,
                                0.4, p,
                                function()
                                    if j < #percent then
                                        v.LoadingBar_roleExp:setPercent(0)
                                    end
                                    tempLevel = tempLevel + 1
                                    resume()
                                end
                            )
                            yield()
                            tempLevel = math.min(heroData.lvl, tempLevel)
                            v.Label_level:setTextById(800006, tempLevel)
                        end
                end)
                resume()
            end
        end
    end
end

function BattleResultView:onShow()
    self.super.onShow(self)
    if self.blockUI then
        self.blockUI:setOpacity(100)
    end
    self:checkShowAssitPlayerInfo()
end

function BattleResultView:onTeamFightRewardRefresh(data)
	print("---------------------------------------------------------------------------------------------------onTeamFightRewardRefresh")
	dump(self.levelCfg_)
    dump({"onTeamFightRewardRefresh",data})
    if self.teamHeroItems then 
        for i, node in ipairs(self.teamHeroItems) do
            if node.pid == data.pid then 
                local list = node.roleRewardList
                list:removeAllItems()
                if data.rewards then 
                    for ii, v in ipairs(data.rewards) do 
                        if v.id ~= EC_SItemType.PLAYEREXP and v.id ~= EC_SItemType.SPIRITEXP and 
                            v.id ~= EC_SItemType.FAVOR and v.id ~= EC_SItemType.CONTRIBUTION then
                            local item = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
                            item:setScale(0.7)
                            list:pushBackCustomItem(item)
                            PrefabDataMgr:setInfo(item, v.id, v.num)   
                        end
                    end
                end
            end
        end
    end
end

function BattleResultView:onShowPlayerInfoView(playerInfo)
    Utils:openView("chat.PlayerInfoViewSimple", playerInfo)
end

function BattleResultView:checkShowAssitPlayerInfo()
    if not self.checked then
        self.checked = true
        local data = BattleDataMgr:getServerData()
        if data and data.helpPid and data.helpPid > 0 then 
            --好友列表沒有滿并且不是好友时弹出用户信息面板
            if not FriendDataMgr:friendIsFull() and not FriendDataMgr:isFriend(data.helpPid) then 
                MainPlayer:sendPlayerId(data.helpPid)
            end
        end
    end
end

function BattleResultView:registerEvents()
    EventMgr:addEventListener(self, EV_RECV_PLAYERINFO, handler(self.onShowPlayerInfoView, self))
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_HERO_REWARD, handler(self.onTeamFightRewardRefresh, self))
    self.Button_leftArrow:onClick(function()
            local curPageIndex = self.PageView_reward:getCurPageIndex()
            local index = math.max(0, curPageIndex - 1)
            self.PageView_reward:scrollToPage(index)
    end)

    self.Button_rightArrow:onClick(function()
            local curPageIndex = self.PageView_reward:getCurPageIndex()
            local index = math.max(self.PageView_reward:getPageCount() - 1, curPageIndex + 1)
            self.PageView_reward:scrollToPage(index)
    end)

    self.PageView_reward:addMEListener(TFPAGEVIEW_SCROLLENDED, function()
                                           local curPageIndex = self.PageView_reward:getCurPageIndex()
                                           local pageCount = self.PageView_reward:getPageCount()
                                           self.Button_rightArrow:setVisible(pageCount > 1 and curPageIndex == 0)
                                           self.Button_leftArrow:setVisible(pageCount > 1 and curPageIndex == pageCount - 1)
    end)
    self.panelRootClickFunc = function()
            if self.isEnableTouching then
                self.isEnableTouching = false
                self:timeOut(function()
                    self.isEnableTouching = true
                end, 2)
                self.touchCount_ = self.touchCount_ + 1
                if self.touchCount_ == 1 then
                    -- self.Panel_evaluation:hide()
                    -- self.teamAttackPage:hide()
                    -- self.Panel_reward:show()
                    -- if self.battleType_ == EC_BattleType.TEAM_FIGHT then
                    --     self:runRoleAnim()
                    --     self:runRoleMirrorAnim()
                    --     self.Image_battleResult_role_mirror:setVisible(true)
                    -- end
                    -- self:showReward()
                    -- self.Label_continue:setVisible(false)
                    -- self:checkBtnShareEnableShow()
                
                    -------TODO 修改
                    self.Panel_evaluation:hide()
                    -- self.teamAttackPage:hide()
                    -- self.Panel_reward:show()
                    if self.battleType_ == EC_BattleType.TEAM_FIGHT then
                        -- self:runRoleAnim()
                        -- self:runRoleMirrorAnim()
                        -- self.Image_battleResult_role_mirror:setVisible(true)

                        -- 展示奖励
                        self:runTeamHeroAnim()
                    elseif BattleDataMgr:isMusicGameLevel() then
                        AlertManager:changeScene(SceneType.MainScene)
                        return
                    else
                        self.teamAttackPage:hide()
                        self.Panel_reward:show()
                        self:showReward()
                    end
                    self.Label_continue:setVisible(false)
                    self:checkBtnShareEnableShow()
                else
                    if self.battleType_ == EC_BattleType.TEAM_FIGHT then
                        TeamFightDataMgr:reset()
                    end
                    if self.levelCfg_.dungeonType == EC_FBLevelType.HWX then
                        LinkageHwxDataMgr:Send_cityBaseInfo()
                    end
                    if GuideDataMgr:isInNewGuide() and AlertManager:getMainSceneCacheLayerNum() < 1 then
                        AlertManager:setOpenFubenCom(true)
                    end
                    if battleController.lastSceneName == "BaseOSDScene" then 
                        local OSDControl = require("lua.logic.osd.OSDControl")
                        OSDControl:enterOSD({})
                    else
                        AlertManager:changeScene(SceneType.MainScene)
                    end
                end
            end
    end
    self.Panel_root:onClick(self.panelRootClickFunc)

    self.Button_battleResultView_1:onClick(function()
            local passTime = self.passTime_
            local dropReward = self.dropReward_
            AlertManager:closeLayer(self)
            TFDirector:addTimer(1000, 1, function()
                                    Utils:openView("battle.BattleResultView")
            end)
    end)

    local shareClick = false
    self.Button_share:onClick(function()
        if not shareClick then
            shareClick = true
            local view = requireNew("lua.logic.battle.BattleResultShareView"):new()
            AlertManager:addLayer(view)
            self:timeOut(function()
                AlertManager:show()
                shareClick = false
            end, 0.2)
        end
    end)

    EventMgr:addEventListener(self,EV_REPORT_SUCCESS,handler(self.EV_REPORT_SUCCESS, self));
end

function BattleResultView:EV_REPORT_SUCCESS()
    if self.btn_inform then
        self.btn_inform:setTextureNormal("ui/fight_result/inform_2.png")
        self.btn_inform:getChildByName("Label_title"):setTextById(100000082)
    end
end
    
function BattleResultView:checkBtnShareEnableShow()
    if HeitaoSdk and CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID and --[[TFDeviceInfo:getCurAppVersion() == "3.00" and--]] not (HeitaoSdk.getplatformId() % 10000 == 101) then
        return
    end

    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS--[[ and TFDeviceInfo:getCurAppVersion() == "2.80"--]] then
        return
    end
    self.Button_share:show()
end

function BattleResultView:specialKeyBackLogic( )
    GuideDataMgr:setPlotLvlBackState(false)
    self:panelRootClickFunc()
    return true
end

return BattleResultView
