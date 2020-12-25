--[[
    @desc：WorldBossView
]]

local WorldBossView = class("WorldBossView",BaseLayer)

-- 士气间隔刷新时间
local RequestTime = 10 * 1000 

function WorldBossView:initData()
    self.requestTime = RequestTime
end

function WorldBossView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.league.worldBossView")
    LeagueDataMgr:send_JU_NAI_INVASION_REQ_JU_NAI_INVASION_INFO()
end

function WorldBossView:initUI(ui)
    self.super.initUI(self,ui)

    self._ui.Panel_item:hide()
    self.listViewTips = UIListView:create(self._ui.ScrollView_tips)
    self.listViewTips:setItemsMargin(0)
    self.listViewAwards = UIListView:create(self._ui.ScrollView_awards)
    self.listViewAwards:setItemsMargin(10)

    -- self._ui.lab_bossName:setSkewX(15)
    self._ui.lab_bossLv1:setSkewX(15)
    self._ui.Label_worldBossViewArt1:setSkewX(15)
    self._ui.Label_worldBossViewArt2:setSkewX(15)
    self._ui.Label_worldBossViewArt3:setSkewX(15)

    self._ui.Panel_left:hide()
    self._ui.Panel_right:hide()
end

function WorldBossView:registerEvents()
    EventMgr:addEventListener(self, EV_UNION_QUIT_UNION, handler(self.onQuitUnionBack, self))
    EventMgr:addEventListener(self, EV_LEAGUE_WORLDBOSS_INFO, handler(self.refreshView, self))
    EventMgr:addEventListener(self, EV_LEAGUE_WORLDBOSS_MORALE_UPDATE, handler(self.refreshMoraleNum, self))
    EventMgr:addEventListener(self, EV_BATTLE_FIGHTOVER, handler(self.refreshView, self))
    EventMgr:addEventListener(self, EV_LEAGUE_WORLDBOSS_ATTACKINFO_UPDATE, function(data)
        self:refreshMoraleNum()
        if not AlertManager:getLayerBySpecialName("WorldBossMoraleView") then
            Utils:openView("league.WorldBossMoraleView", data)
        end
    end)
    EventMgr:addEventListener(self, EV_LEAGUE_WORLDBOSS_LEAGUERANK_UPDATE, function(data)
        self:refreshMoraleNum()
        if not AlertManager:getLayerBySpecialName("WorldBossHurtRankView") then
            Utils:openView("league.WorldBossHurtRankView", data)
        end
    end)
    
    self._ui.btn_personAward:onClick(function()
        Utils:openView("league.WorldBossRankAwardView")
    end)
    
    self._ui.btn_leagueRankAward:onClick(function()
        Utils:openView("league.WorldBossRankAwardView", 2)
    end)

    self._ui.btn_leagueHurtAward:onClick(function()
        LeagueDataMgr:send_JU_NAI_INVASION_REQ_GET_UNION_RANK(1)
    end)

    self._ui.btn_lastWeekRank:onClick(function()
        LeagueDataMgr:send_JU_NAI_INVASION_REQ_GET_UNION_RANK(2)
    end)

    self._ui.btn_morale:onClick(function()
        LeagueDataMgr:send_JU_NAI_INVASION_REQ_GET_UNION_PLAYER_ATTR()
    end)

    if not self.timer then
        self.timer = TFDirector:addTimer(1000, -1, nil, handler(self.timerFunc, self))
    end
    self:timerFunc()
end

-- 第四阶段第一次战斗结束后显示
function WorldBossView:playeFightOverCg()
    local tag = "WorldBossTypeCg"..MainPlayer:getPlayerId()
    local _bool = Utils:getLocalSettingValue(tag) ~= ""
    local cfg = LeagueDataMgr:getCurInvade()

    if not cfg then
        return
    end
    local levelInfo = FubenDataMgr:getLevelInfo(cfg.dungeonLevelId)
    local hadFightCount = 0
    if levelInfo then
        hadFightCount = levelInfo.fightCount
    end
    if LeagueDataMgr:getCurInvade().type ~= EC_WorldBossType.World or _bool or hadFightCount ~= 1 then
        return
    end

    local function screenCallback()
        KabalaTreeDataMgr:playStory(1,9339,function ()
            EventMgr:dispatchEvent(EV_CG_END,function()
                Utils:setLocalSettingValue(tag,"true")
            end)
        end)
    end
    KabalaTreeDataMgr:openCgView("kabalaTree.KabalaTreeCg",screenCallback)
end

function WorldBossView:onQuitUnionBack()
    AlertManager:closeAll()
    AlertManager:changeScene(SceneType.MainScene)
end

function WorldBossView:timerFunc()
    local data = LeagueDataMgr:getWorldBossInfo()
    if table.count(data) ~= 0 then
        self:refreshLabTime(data)
        -- 每10s刷新一次士气
        self.requestTime = self.requestTime - 1
        if self.requestTime <= 0 then
            self.requestTime = RequestTime
            -- LeagueDataMgr:send_JU_NAI_INVASION_REQ_GET_UNION_MORALE()
        end
    end
end

function WorldBossView:refreshLabTime(data)
    local time = (data.showTime - ServerDataMgr:getServerTime())
    if time <= 0 then
        LeagueDataMgr:send_JU_NAI_INVASION_REQ_JU_NAI_INVASION_INFO()
    else
        local day, hour, min, sec = Utils:getFuzzyDHMS(time)
        local _txtId
        local curType = LeagueDataMgr:getCurInvade().type
        if curType == EC_WorldBossType.World then
            _txtId = data.type == 2 and 16000309 or 16000301
        else
            _txtId = data.type == 2 and 16000302 or 16000301
        end
        self._ui.lab_lastTime:setTextById(_txtId, hour + day*24, min)
    end
end

function WorldBossView:refreshView()
   
    local data = LeagueDataMgr:getWorldBossInfo() 
    local cfg = LeagueDataMgr:getCurInvade()

    if data and table.count(data) ~= 0 then
        self._ui.Panel_left:show()
        self._ui.Panel_right:show()
    end

    local hadFightCount = 0
    local isWin = false
    local lastCount
    if cfg.type  ~= EC_WorldBossType.REST then
        local levelInfo = FubenDataMgr:getLevelInfo(cfg.dungeonLevelId)
        if levelInfo then
            hadFightCount = levelInfo.fightCount
            isWin = levelInfo.win
        end
        lastCount = FubenDataMgr:getPlotLevelRemainFightCount(cfg.dungeonLevelId)

        self._ui.lab_lastChallengeNum:setText(lastCount)
        if cfg.type == EC_WorldBossType.Normal then
            self._ui.btn_goFight:setGrayEnabled(data.type == 1 or isWin or lastCount <= 0)
        else
            self._ui.btn_goFight:setGrayEnabled(data.type == 1 or lastCount <= 0)
        end
    else
        self._ui.btn_goFight:setGrayEnabled(true)
    end

    self._ui.btn_goFight:onClick(function(sender)
        if cfg.type  == EC_WorldBossType.REST then
            Utils:showTips(16000224)
            sender:setGrayEnabled(true)
            return
        end
        if cfg.type == EC_WorldBossType.Normal then
            if data.type == 1 or isWin or lastCount <= 0 then
                if isWin then
                    Utils:showTips(16000223)
                elseif lastCount <= 0 then
                    Utils:showTips(16000222)
                else
                    Utils:showTips(16000224)
                end
                sender:setGrayEnabled(true)
                return
            end
        end
        if cfg.type == EC_WorldBossType.World then
            if data.type == 1 or lastCount <= 0 then
                if lastCount <= 0 then
                    Utils:showTips(16000222)
                else
                    Utils:showTips(16000224)
                end
                sender:setGrayEnabled(true)
                return
            end
        end
        FubenDataMgr:cacheSelectFubenType(EC_FBType.WORLD_BOSS)
        LeagueDataMgr:send_JU_NAI_INVASION_REQ_GET_UNION_MORALE()

        local levelCfg = FubenDataMgr:getLevelCfg(cfg.dungeonLevelId)
        local chapterCfg_ = FubenDataMgr:getChapterCfg(levelCfg.dungeonChapterId)

        LeagueDataMgr:keepBeforeFightWorldBossType()
        Utils:openView("fuben.FubenSquadView", levelCfg.dungeonType, cfg.dungeonLevelId)
    end)

    self._ui.panel_btns:setVisible(cfg.type == EC_WorldBossType.World)
    self._ui.btn_morale:setVisible(cfg.type ~= EC_WorldBossType.REST)

    self._ui.btn_lastWeekRank:setVisible(cfg.type ~= EC_WorldBossType.World)

    self.listViewTips:removeAllItems()
    for i, txtId in ipairs(cfg.fightDesc) do
        local panel = self._ui.Panel_item:clone()
        local lab = TFDirector:getChildByPath(panel, "lab_tip")
        lab:setTextById(txtId)
        panel:show()
        self.listViewTips:pushBackCustomItem(panel)
    end

    self.listViewAwards:removeAllItems()
    local awards = TabDataMgr:getData("DungeonLevel",cfg.dungeonLevelId).firstDropShow
    for i, goodsId in ipairs(awards) do
        local goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        PrefabDataMgr:setInfo(goods, goodsId)
        goods:setScale(0.6)
        self.listViewAwards:pushBackCustomItem(goods)
    end

    self._ui.lab_bossLv:setText(cfg.lv)
    self._ui.lab_bossLv1:setText(cfg.lv)

    self._ui.Spine_boss:setFile(cfg.bossModel)
    self._ui.Spine_boss:play("animation", true)
    self:refreshLabTime(LeagueDataMgr:getWorldBossInfo())
    self:refreshMoraleNum()
end

function WorldBossView:refreshMoraleNum()
    self._ui.lab_moraleNum:setText(LeagueDataMgr:getMorale())
end

function WorldBossView:onShow()
    local tag = "WorldBossDating"..MainPlayer:getPlayerId()
    if Utils:getLocalSettingValue(tag) == "" then
        DatingDataMgr:startDating(920)
        Utils:setLocalSettingValue(tag,"true") 
    end

    self:playeFightOverCg()

    local _bool = LeagueDataMgr:getIsRewardsAndMaxNum()
    self._ui.img_redtipAward:setVisible(_bool)
    self._ui.img_redtipFight:setVisible(LeagueDataMgr:isWorldBossOpenRedShow())
end

function WorldBossView:removeEvents()
    if self.timer then
        TFDirector:removeTimer(self.timer)
        self.timer = nil
    end
end

return WorldBossView