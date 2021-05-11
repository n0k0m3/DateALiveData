local BattleScene = class("BattleScene", BaseScene)
function BattleScene:ctor(...)
    self.super.ctor(self, ...)
    self:addView()
    -- self:addMEListener(TFWIDGET_CLEANUP,handler(self._onCleanup,self))
    -- self:musicGame()
    -- if RELEASE_TEST then  --屏蔽testVIew
    --     self.testView = require("lua.logic.test.TestView"):new()
    --     self:addChild(self.testView)
    --     self.testView:setZOrder(9999)
    -- end
end
function BattleScene:addView()
    local fightingMode = BattleDataMgr:getLevelCfg().fightingMode
    local battleView
    if fightingMode == 3 then
        battleView = require("lua.logic.battle.flight.FlightView"):new()
    elseif fightingMode == 2 then
        battleView = require("lua.logic.battle.flight.FlightView"):new()
    else
        battleView = require("lua.logic.battle.BattleView"):new()
    end
    self:addLayer(battleView)
end

function BattleScene:onEnter()
    self.super.onEnter(self)
    CommonManager:checkTipEvent()
end

function BattleScene:onExit()
    self.super.onExit(self)
    SettingDataMgr:resetFPS()
end
-- 战斗资源清理
function BattleScene:_onCleanup()
    print("BattleScene _onCleanup")
    if me.SkeletonDataManager then
        me.SkeletonDataManager:removeUnusedSkeletonData()
    end

    me.TextureCache:removeUnusedTextures()
end

function BattleScene:musicGame()
    local MusicGame = require("lua.logic.battle.MusicGame")
    local musicGame = MusicGame:new()
    self:addLayer(musicGame)
end

function BattleScene:onKeyBack()
    if self.battleView then
        self.battleView:onKeyBack()
    end
end

return BattleScene
