
local BattleResultShareView = class("BattleResultShareView", BaseLayer)

function BattleResultShareView:initData()
    self.diffData_ = {
        [EC_FBDiff.SIMPLE] = 300120,
        [EC_FBDiff.HARD] = 300121,
        [EC_FBDiff.LIMBO] = 300122,
    }

    self.statistics_ = BattleDataMgr:getController().getStatistics()
    self.battleType_ = BattleDataMgr:getBattleType()
    self.resultData_ = BattleDataMgr:getBattleResultData()

    self.formation_ = FubenDataMgr:getFormation()
    self.isSingle_ = (#self.formation_ == 1)

    if self.battleType_ == EC_BattleType.COMMON then
        self.levelCid_ = BattleDataMgr:getPointId()
        self.levelCfg_ = FubenDataMgr:getLevelCfg(self.levelCid_)
        self.passTime_ = self.statistics_.time
    elseif self.battleType_ == EC_BattleType.ENDLESS then
        self.levelCid_ = BattleDataMgr:getPointId()
        self.levelCfg_ = FubenDataMgr:getLevelCfg(self.levelCid_)
        self.passTime_ = self.statistics_.endlessTime
    elseif self.battleType_ == EC_BattleType.TEAM_FIGHT then
        local teamFightEndData = TeamFightDataMgr:getBattleEndData()
        self.levelCid_ = BattleDataMgr:getPointId()
        self.levelCfg_ = FubenDataMgr:getLevelCfg(self.levelCid_)
        self.passTime_ = teamFightEndData.fightTime
        self.teamPlayers = teamFightEndData.results
    end
end

function BattleResultShareView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.battle.battleResultShareView")
end

function BattleResultShareView:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_touch = TFDirector:getChildByPath(ui, "Panel_touch")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_role_exp_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_role_exp_item")

    self.Image_battleResul_bg = TFDirector:getChildByPath(self.Panel_root, "Image_battleResul_bg")
    self.Spine_battleResult_splash = TFDirector:getChildByPath(self.Panel_root, "Spine_battleResult_splash")
    self.Spine_battleResult_title = TFDirector:getChildByPath(self.Panel_root, "Spine_battleResult_title")

    self.Image_battleResult_role_mirror = TFDirector:getChildByPath(self.Panel_root, "Image_battleResult_role_mirror")
    self.Image_battleResult_hero = TFDirector:getChildByPath(self.Panel_root, "Image_battleResult_hero")

    self.Panel_info = TFDirector:getChildByPath(self.Panel_root, "Panel_info")

    self.Label_title = TFDirector:getChildByPath(self.Panel_info, "Label_title")
    self.Label_playerName =  TFDirector:getChildByPath(self.Panel_info, "Label_playerName")
    self.Label_playerLevel = TFDirector:getChildByPath(self.Panel_info, "Label_playerLevel")
    self.Label_player_power = TFDirector:getChildByPath(self.Panel_info, "Label_player_power")
    self.Label_player_passTime = TFDirector:getChildByPath(self.Panel_info, "Label_player_passTime"):hide()
    self.Label_player_attackNum = TFDirector:getChildByPath(self.Panel_info, "Label_player_attackNum"):hide() 

    self.Label_role_title = TFDirector:getChildByPath(self.Panel_info, "Label_role_title")
    self.Panel_roles = TFDirector:getChildByPath(self.Panel_info, "Panel_roles")

    self:refreshView()
end

function BattleResultShareView:refreshView()
    if self.battleType_ == EC_BattleType.COMMON then
        local levelGroupCid = self.levelCfg_.levelGroupId
        if levelGroupCid == EC_DailyType.EXP
            or levelGroupCid == EC_DailyType.GOLD
            or levelGroupCid == EC_DailyType.PRAY
            or levelGroupCid == EC_DailyType.XINWU
            or levelGroupCid == EC_DailyType.ZHIDIAN then
            local levelGroupCfg = FubenDataMgr:getLevelGroupCfg(levelGroupCid)
            self.Label_title:setTextById(300883,TextDataMgr:getText(levelGroupCfg.name).." "..TextDataMgr:getText(self.levelCfg_.name))
        elseif self.levelCfg_.dungeonType == EC_FBLevelType.SPRITE then
            local curLevelIndex_ = FubenDataMgr:getCurSpritePassIndex()
            local textName = TextDataMgr:getText(212015).." "..TextDataMgr:getText(self.diffData_[curLevelIndex_])
            self.Label_title:setTextById(300883, textName)
        elseif self.levelCfg_.dungeonType == EC_FBLevelType.KABALATREE then
            local curWorldId = KabalaTreeDataMgr:getCurWorldId()
            local worldName = TabDataMgr:getData("KabalaWorld", curWorldId).worldName
            local textName = TextDataMgr:getText(3004038).." "..TextDataMgr:getText(worldName)
            self.Label_title:setTextById(300883, textName)
        elseif self.levelCfg_.dungeonType == EC_FBLevelType.HALLOWEEN then
            local halloweenName = TextDataMgr:getText(self.levelCfg_.name)
            self.Label_title:setTextById(300883, halloweenName)
        elseif self.levelCfg_.dungeonType == EC_FBLevelType.SPRITE_EXTRA then
            local spriteExtraName = TextDataMgr:getText(self.levelCfg_.name)
            self.Label_title:setTextById(300883, spriteExtraName)
        elseif self.levelCfg_.dungeonType == EC_FBLevelType.THEATER_FIGHTING then
            local name = FubenDataMgr:getLevelName(self.levelCid_)
            self.Label_title:setTextById(300883, name)
        elseif self.levelCfg_.dungeonType == EC_FBLevelType.THEATER_BOSS then
            local theaterLevelCfg = self:getTheaterDungeonLevelCfg(self.levelCid_)
            local name = TextDataMgr:getText(theaterLevelCfg.storydungeonName)
            self.Label_title:setTextById(300883, name)
        elseif self.levelCfg_.dungeonType == EC_FBLevelType.DALMAP then
            local curWorldId =  DalMapDataMgr:getCurWorld()
            local worldName = DalMapDataMgr:getDlsWorldCfg(curWorldId).worldName
            local textName = TextDataMgr:getText(3004038).." "..TextDataMgr:getText(worldName)
            self.Label_title:setTextById(300883, textName)
        elseif self.levelCfg_.dungeonType == EC_FBLevelType.CHRISTMAS then
            self.Label_title:setTextById(self.levelCfg_.name)
        elseif self.levelCfg_.dungeonType == EC_FBLevelType.SKYLADDER then
            local rankMatchLevelCfg = SkyLadderDataMgr:getRankMatchLevelCfg(self.levelCid_)
            if rankMatchLevelCfg then
                local rankMatchCfg = SkyLadderDataMgr:getRankMatchCfg(rankMatchLevelCfg.rankID)
                local rankName = TextDataMgr:getText(rankMatchCfg.rankName)
                local str = TextDataMgr:getText(3202062,rankName)
                local passName = self:getPassCondDesc(self.levelCid_, self.levelCfg_.victoryType[1])
                self.Label_title:setTextById(300883, str..passName)
            end
        elseif self.levelCfg_.dungeonType == EC_FBLevelType.HUNTER then
            local levelname = TextDataMgr:getText(3300023) 
            self.Label_title:setTextById(300883, levelname)
        elseif self.levelCfg_.dungeonType == EC_FBLevelType.WORLD_BOSS then
            self.Label_title:setTextById(16000303, LeagueDataMgr:getCurInvade().lv)
            self.Label_player_passTime:show()
            self.Label_player_attackNum:show()
            local _, min, sec = Utils:getTime(self.passTime_ * 0.001, true)
            local _time = TextDataMgr:getText(800014, min, sec)
            self.Label_player_passTime:setTextById(16000304, _time)
            self.Label_player_attackNum:setTextById(16000312, Utils:converNumWithComma(self.statistics_.hitValue or 0))
        elseif self.levelCfg_.dungeonType == EC_FBLevelType.BOSS_CHALLENGE then
            local levelname = TextDataMgr:getText(12035001) 
            self.Label_title:setTextById(300883, levelname)
        else
            local levelname = FubenDataMgr:getLevelName(self.levelCid_)
            local diffName = TextDataMgr:getText(self.diffData_[self.levelCfg_.difficulty])
            local passName = self:getPassCondDesc(self.levelCid_, self.levelCfg_.victoryType[1])
            self.Label_title:setTextById(300883, diffName.." "..levelname.." "..passName)
        end
    elseif self.battleType_ == EC_BattleType.ENDLESS then
        local chapterName = TextDataMgr:getText(TabDataMgr:getData("DungeonChapter", 401).name)
        local endlessInfo = FubenDataMgr:getEndlessInfo()
        self.Label_title:setTextById(300884, chapterName, endlessInfo.todayBest)
    elseif self.battleType_ == EC_BattleType.TEAM_FIGHT or self.battleType_ == EC_BattleType.HIGH_TEAM_FIGHT then
        if self.levelCfg_ and self.levelCfg_.dungeonType == EC_FBLevelType.HUNTER then
            local levelName = TextDataMgr:getText(3300023)
            self.Label_title:setTextById(300883, levelName)
        else
            local chapterName = TextDataMgr:getText(TabDataMgr:getData("DungeonChapter", 402).name)
            local dungeonCfg = TabDataMgr:getData("ChasmDungeon")[self.levelCid_]
            if not dungeonCfg then
                --春日特训
                dungeonCfg = TabDataMgr:getData("TrainDungeonLevel")[self.levelCid_]
            end

            if not dungeonCfg then
                dungeonCfg = TabDataMgr:getData("HighTeamDungeon")[self.levelCid_]
            end

            if not dungeonCfg then
                dungeonCfg = TabDataMgr:getData("DungeonLevel")[self.levelCid_]
            end
            local realName = dungeonCfg.name or dungeonCfg.levelName
            local levelName = TextDataMgr:getText(realName)
            self.Label_title:setTextById(300883, chapterName.." "..levelName)
        end
    end

    local heroData = self.formation_[1]
    local power = math.floor(HeroDataMgr:getHeroPower(heroData.id))
    self.Label_playerLevel:setTextById(800006, heroData.lvl)
    self.Label_playerName:setText(MainPlayer:getPlayerName())
    -- self.Label_player_power:setText("战力 "..power)
    self.Label_player_power:setTextById(100000010,power)

    self:createHeroPanel()
    self:runAnimationIn()
end


function BattleResultShareView:getPassCondDesc(levelId, type_)
    local passtype_ = {300811, 300812, 300813, 300813, 300814, 300882, 300881}
    local type_ = self.levelCfg_.victoryType[1]
    local param = self.levelCfg_.victoryParam[1]
    local descId = passtype_[type_]
    local desc = ""
    if type_ == EC_LevelPassCond.SPECIFICID then
        local monsterCfg = TabDataMgr:getData("Monster", param[1])
        local monsterName = TextDataMgr:getText(monsterCfg.name)
        desc = TextDataMgr:getText(descId)
        --desc = TextDataMgr:getText(descId)..monsterName
    elseif type_ == EC_LevelPassCond.SPECIFICTYPE then
        local monsterTypeName = TextDataMgr:getText(EC_MonsterTypeName[param[1]])
        desc = TextDataMgr:getText(descId, monsterTypeName)
    elseif type_ == EC_LevelPassCond.SPECIFICCOUNT then
        desc = TextDataMgr:getText(descId)
    else
        if descId then
            desc = TextDataMgr:getText(descId)
        end
    end
    return desc
end

function BattleResultShareView:runAnimationIn()
    self.Spine_battleResult_splash:play("loop",false)
    self.Spine_battleResult_title:play("battle_end_win2",false)
    self.Spine_battleResult_title:addMEListener(TFARMATURE_COMPLETE,function()
        self.enableToShare = true
        self.isEnableTouching = true
        if Utils.gameShare then
            Utils:gameShare()
        end
    end)

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

    -- model:update(0.01)
    -- model:stop()
    -- local hero_sp = CCRenderTexture:create(1136,640)
    -- hero_sp:begin()
    -- self.Image_battleResult_hero:visit()
    -- hero_sp:endToLua()

    -- local hero_pos = ccp(-340, -380)
    -- local sp_hero = Sprite:createWithTexture(hero_sp:getSprite():getTexture())
    -- sp_hero:setAnchorPoint(ccp(0, 0))
    -- sp_hero:setPosition(hero_pos)
    -- sp_hero:setFlipY(true)
    -- sp_hero:setScale(modelInfo.battleEndSize)
    -- model:removeFromParent()
    -- self.Image_battleResult_hero:addChild(sp_hero)

    self.Image_battleResult_hero:setScale(modelInfo.battleEndSize)
    self.modelEndSize = modelInfo.battleEndSize or 1.3

    local model1 = Utils:createHeroModel(heroId, self.Image_battleResult_role_mirror, 0.8, skinCid)
    model1:update(0.1)
    model1:stop()
    local tx = CCRenderTexture:create(1136,640)
    tx:begin()
    self.Image_battleResult_role_mirror:visit()
    tx:endToLua()

    local yinziPos = ccp(-640, -380)
    local yingzi = Sprite:createWithTexture(tx:getSprite():getTexture())
    yingzi:setAnchorPoint(ccp(0, 0))
    yingzi:setPosition(yinziPos)
    yingzi:setFlipY(true)
    yingzi:setScale(self.modelEndSize * 1.05)
    yingzi:setOpacity(35)
    model1:removeFromParent()
    self.Image_battleResult_role_mirror:addChild(yingzi)
end

function BattleResultShareView:createHeroPanel()
    if self.battleType_ == EC_BattleType.TEAM_FIGHT then
        local players = self.teamPlayers
        local battleData = BattleDataMgr:getBattleData()
        local function _getHeroData(pid)
            for i, heroData in ipairs(battleData.heros) do
                if heroData.pid == pid then
                    return heroData
                end
            end
        end
        for i,playerInfo in ipairs(players) do
            local heroData = _getHeroData(playerInfo.pid)
            local item = {}
            item.root = self.Panel_role_exp_item:clone()
            item.Panel_role = TFDirector:getChildByPath(item.root, "Panel_role")
            item.Image_playerIcon = TFDirector:getChildByPath(item.root, "Image_playerIcon")
            item.Image_quality = TFDirector:getChildByPath(item.root, "Image_quality")
            item.Label_level = TFDirector:getChildByPath(item.root, "Label_level")

            item.Image_playerIcon:setTexture(TabDataMgr:getData("HeroSkin",heroData.skinId).heroIcon)
            item.Label_level:setText("Lv."..heroData.lvl)

            self.Panel_roles:addChild(item.root)
            item.root:setPosition(ccp(-((i - 1) *110) , 0))
        end
    else
        for i, v in ipairs(self.formation_) do
            local item = {}
            item.root = self.Panel_role_exp_item:clone()
            item.Panel_role = TFDirector:getChildByPath(item.root, "Panel_role")
            item.Image_playerIcon = TFDirector:getChildByPath(item.root, "Image_playerIcon")
            item.Image_quality = TFDirector:getChildByPath(item.root, "Image_quality")
            item.Label_level = TFDirector:getChildByPath(item.root, "Label_level")

            item.Image_playerIcon:setTexture(HeroDataMgr:getIconPathById(v.id))
            item.Label_level:setText("Lv."..v.lvl)

            self.Panel_roles:addChild(item.root)
            item.root:setPosition(ccp(-((i - 1) *110) , 0))
        end
    end
end

function BattleResultShareView:onShow()

end

function BattleResultShareView:registerEvents()
    self.Panel_root:onClick(function()
        if self.isEnableTouching then
            AlertManager:closeLayer(self)
        end
    end)
end

return BattleResultShareView
