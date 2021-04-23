local BattleUtils      = import("..BattleUtils")
local BattleConfig     = import("..BattleConfig")
local ResLoader        = import("..ResLoader")
local BattleMap        = import("..BattleMap")
local enum             = import("..enum")
local BattleMgr        = import("..BattleMgr")
local statistics       = import("..Statistics")
local victoryDecide    = import("..VictoryDecide")
local FlightCamera     = import("..BattleCamera")
local flightController = import(".FlightController")
local FlightKeyBoard   = import(".FlightKeyBoard")

local eEvent                 = enum.eEvent
local eCameraFlag            = enum.eCameraFlag;
local eHurtType              = enum.eHurtType
local eShakeType             = enum.eShakeType
local eBufferEffectIconEvent = enum.eBufferEffectIconEvent
local FlightView               = class("FlightView", BaseLayer)
CREATE_SCENE_FUN(FlightView)

local eShaderType = {
    BLUR    = 1,
    BLAST   = 2,
    DEFAULT = 3,
}

function FlightView:_onExit()
    --战斗数据清理
    self:exitBattle()
    me.TextureCache:removeUnusedTextures()
    TFDirector:clearMovieClipCache()
    me.FrameCache:removeUnusedSpriteFrames()
    SpineCache:getInstance():clearUnused();
    GuideDataMgr:setIsBattle(false)
end

function FlightView:removeEvents()
    self:removeMEListener(TFWIDGET_ENTERFRAME)
    if self.keyBoard then
        self.keyBoard:removeEvents()
    end
    EventMgr:removeEventListenerByTarget(self)
end

function FlightView:ctor(...)
    self.super.ctor(self, ...)
    self.lastTime       = 0
    self.endMsgFlag_    = false
    self.endAniFlag_    = false
    self.uProgressFlag_ = false
    self.dropReward_    = {}
    self.fuzzyTime      = 0
    self.fuzzyLevel     = 0
    self.fuzzyDecay     = 0
    self.blastLevel     = 0
    self.pause_         = false
    self.timing_        = nil

    local data          = BattleDataMgr:getBattleData()
    flightController.init(data)
    self.battleType_    = data.battleType
    self.levelCid_      = data.pointId
    self.statistics_    = statistics
    self.victoryDecide_ = victoryDecide
    self.levelCfg_      = BattleDataMgr:getLevelCfg()
    self.isCountdwon_   = (self.levelCfg_.time > 0)
    self.passLevelCond_ = self.victoryDecide_.nViewType

    self.isScoreLevel_ = false
    local starCfg = statistics.getStarCfg()
    for i, v in ipairs(starCfg) do
        if v.starType == EC_FBStarRule.SCORE then
            self.isScoreLevel_ = true
            break
        end
    end

    self:init("lua.uiconfig.battle.flightView")
    --加载地图
    self:loadMap()
    --创建摄像机
    self.camera = FlightCamera:new(flightController)
    --初始化战斗管理器
    self:refreshView()
    --开始战斗
    -- self:timeOut(function ()
end

function FlightView:initUI(ui)
    self.super.initUI(self, ui)

    -- 战斗层
    self.Panel_fight   = TFDirector:getChildByPath(ui, "Panel_fight")
    self.Panel_map     = TFDirector:getChildByPath(self.Panel_fight, "Panel_map")
    -- self.Panel_role    = TFDirector:getChildByPath(self.Panel_fight, "Panel_role")
    self.Panel_effect  = TFDirector:getChildByPath(self.Panel_fight, "Panel_effect")

    -- ui层
    self.Panel_ui          = TFDirector:getChildByPath(ui, "Panel_ui")
    self.Panel_ui:setTouchEnabled(false)

    --幕布
    self.curtain_panel     = self.Panel_ui:getChildByName("Panel_curtain")

    --CG动画层
    self.CGAnim_panel      = self.Panel_ui:getChildByName("Panel_CGAnim")

    --剧情对话
    self.storyTalk_panel   = self.Panel_ui:getChildByName("Panel_StoryTalk")
    --关卡胜利条件
    self.Panel_victory    = TFDirector:getChildByPath(self.Panel_ui, "Panel_victory"):hide()
    self.Image_common_victory = TFDirector:getChildByPath(self.Panel_victory, "Image_common_victory")
    self.textVictoryTitle  = TFDirector:getChildByPath(self.Image_common_victory, "Label_title")
    self.textVictorycontent= TFDirector:getChildByPath(self.Image_common_victory, "Label_content")
    self.image_time = TFDirector:getChildByPath(self.Panel_ui, "Image_v_time"):hide()
    self.label_time = TFDirector:getChildByPath(self.image_time , "Label_v_time")
    TFDirector:getChildByPath(self.Panel_victory, "Image_halloween_1"):hide()
    TFDirector:getChildByPath(self.Panel_victory, "Image_halloween_2"):hide()

    --挑战进度显示
    self.Panel_progress = TFDirector:getChildByPath(self.Panel_ui, "Panel_progress")
    self.Panel_progress:hide()
    self.label_tip1 = self.Panel_progress:getChildByName("Label_tip1")
    self.label_tip2 = self.Panel_progress:getChildByName("Label_tip2")
    self.Image_star = self.Panel_progress:getChildByName("Image_star")
    self.label_tip1:setSkewX(15)
    self.label_tip2:setSkewX(15)

    self.Panel_ui_effect_top = TFDirector:getChildByPath(self.Panel_ui, "Panel_ui_effect_top")
    self.Panel_ui_effect_top:setTouchEnabled(false)
    self.Panel_top              = TFDirector:getChildByPath(self.Panel_ui, "Panel_top"):hide()

    self.panel_victory_time = TFDirector:getChildByPath(self.Panel_top,"Panel_time")
    self.label_victory_time = TFDirector:getChildByPath(self.panel_victory_time,"Label_time")

    ---控制队员
    self.playerNode = self.Panel_top:getChildByName("Panel_captain")
    self.playerNode.imageHead = self.playerNode:getChildByName("Image_head")

    local image_hp = self.playerNode:getChildByName("Image_hp")
    self.playerNode.loadingBar_hp = image_hp:getChildByName("LoadingBar_hp")

    self.playerNode:show()

    --boss
    self.bossNode = self.Panel_top:getChildByName("Panel_boss")
    self.bossNode:hide()

    TFDirector:getChildByPath(self.Panel_top, "Image_gather"):hide()

    -- 无尽模式
    TFDirector:getChildByPath(self.Panel_top, "Panel_endlessTip"):hide()
    TFDirector:getChildByPath(self.Panel_top, "Panel_endlessStop"):hide()
    TFDirector:getChildByPath(self.Panel_top, "Panel_endlessResult"):hide()
    TFDirector:getChildByPath(self.Panel_top, "Panel_endlessBuff"):hide()
    TFDirector:getChildByPath(self.Panel_top, "Image_endless_victory"):hide()

    -- 常规开场通关条件提示
    self.Panel_commonPassTip     = TFDirector:getChildByPath(self.Panel_top, "Panel_commonPassTip"):hide()
    self.Label_commonPassContent = TFDirector:getChildByPath(self.Panel_commonPassTip, "Label_commonPassContent")
    -- 关卡属性限定提示
    self.Panel_propLimitTip      = TFDirector:getChildByPath(self.Panel_top, "Panel_propLimitTip"):hide()
    self.Label_propLimitTitle    = TFDirector:getChildByPath(self.Panel_top, "Image_propLimitTitle.Label_propLimitTitle")
    self.Label_propLimit         = TFDirector:getChildByPath(self.Panel_propLimitTip, "Label_propLimit")

    self.keyBoard = FlightKeyBoard:new()
    self.Panel_top:addChild(self.keyBoard, 10)

    local pSize = self.Panel_top:getSize()
    local cSize = self.keyBoard:getSize()
    self.keyBoard:setPosition(me.p((pSize.width - cSize.width)/2,(pSize.height - cSize.height)/2))


    --self.Panel_top:getChildByName("Panel_team_rank"):setVisible(false)

    self.Panel_flight_helpTips = TFDirector:getChildByPath(self.Panel_top, "Panel_flight_helpTips"):hide()
    self.Label_flight_helpTips = TFDirector:getChildByPath(self.Panel_flight_helpTips, "Label_flight_helpTips")
end

function FlightView:refreshView()
    self:showPrewarTip()
    self:reLoadVictoryView()
end


function FlightView:showPrewarTip()
    if self.battleType_ == EC_BattleType.ENDLESS then
        local action = Sequence:create({
                Show:create(),
                DelayTime:create(2),
                Hide:create(),
        })
        self.Panel_endlessTip:runAction(action)
        self.Label_endlessLevel:setTextById(300832, self.levelCfg_.order)
    elseif self.battleType_ == EC_BattleType.COMMON then
        local action = Sequence:create({
                Show:create(),
                DelayTime:create(2),
                Hide:create(),
        })
        self.Panel_commonPassTip:runAction(action)
        self.Label_commonPassContent:setTextById(self.levelCfg_.victoryTypeDescribeForOpening)

        if self.levelCfg_.fightingMode == 2 or self.levelCfg_.fightingMode == 3 then
            if self.levelCfg_.fightingMode == 2 then
                self.Label_flight_helpTips:setTextById(300624)
            else
                self.Label_flight_helpTips:setTextById(300625)
            end
            local action = Sequence:create({
                    DelayTime:create(2),
                    Show:create(),
                    DelayTime:create(3),
                    Hide:create(),
            })
            self.Panel_flight_helpTips:runAction(action)
        end
    end
    if self.levelCfg_.limitAttributesDescribe and #self.levelCfg_.limitAttributesDescribe > 0 then
        local offsetX = GameConfig.WS.width * 0.5
        self.Panel_propLimitTip:PosX(self.Panel_propLimitTip:PosX() - offsetX)
        self.Label_propLimitTitle:setTextById(300823)
        self.Label_propLimit:setTextById(self.levelCfg_.limitAttributesDescribe)
        local action = Sequence:create({
            DelayTime:create(2),
            Show:create(),
            MoveBy:create(0.3, ccp(offsetX, 0)),
            DelayTime:create(3),
            MoveBy:create(0.3, ccp(-offsetX, 0)),
            Hide:create(),
        })
        self.Panel_propLimitTip:runAction(action)
    end
end

local titleTexts = {300811 ,300812,300813,300814,300814,300868}
function FlightView:refreshVictoryState()
    local victoryCfgs = victoryDecide.getData()
    local viewType    = victoryDecide.nViewType
    --local parentNode = self.Panel_victoryType[viewType]:show()

    if viewType ~=0 then
        local text = TextDataMgr:getText(titleTexts[viewType])
        self.textVictoryTitle:setText(text)
        self.textVictoryTitle:show()
    end
    if viewType == 0 then
    elseif viewType == EC_LevelPassCond.DESTORY then  -- (歼灭模式)
        -- print("歼灭模式:[",victoryDecide.nStage,"/",battleController.getMaxStage(),"]")
        local _, hour, min, sec = Utils:getDHMS(victoryDecide.nSecondTime, true)
        self.label_victory_time:setText(string.format("%s:%s", min, sec))
    elseif viewType == EC_LevelPassCond.SURVIVAL then  -- (生存模式)   300815
        if not self.isScoreLevel_ then
            self.textVictorycontent:setText(string.format("%s:%s", min, sec))
        end
        local _, hour, min, sec = Utils:getDHMS(victoryDecide.nSecondTime, true)
        self.label_victory_time:setText(string.format("%s:%s", min, sec))
    elseif viewType == EC_LevelPassCond.SPECIFICID  then --限时击杀
        local _, hour, min, sec = Utils:getDHMS(victoryDecide.nSecondTime, true)
        self.label_victory_time:setText(string.format("%s:%s", min, sec))
        local maxNum = 0
        local num    = 0
        local desc   = 0
        local cfg = victoryCfgs[1]
        local node = parentNode.node
        node:show()
        num    = victoryDecide.getKillTargetNum(cfg.victoryParam[1])
        maxNum = cfg.victoryParam[2]
        self.textVictorycontent:setText(string.format("%s/%s",num,maxNum))
        --local monsterCfg  = TabDataMgr:getData("Monster", cfg.victoryParam[1])
        --if monsterCfg.targetIcon then
        --    node.imageIcon:setTexture(monsterCfg.targetIcon)
        --end
        --node.textNum:setText(string.format("[%s/%s]",num,maxNum))
        --node.imagekill:setVisible(num >= maxNum )
    --elseif viewType == EC_LevelPassCond.SPECIFICTYPE
    --    or viewType == EC_LevelPassCond.SPECIFICCOUNT then
    --    local maxNum = 0
    --    local num    = 0
    --    local desc   = 0
    --    for index, cfg in ipairs(victoryCfgs) do
    --        local node = parentNode.nodes[index]
    --        node:show()
    --        if cfg.victoryType == EC_LevelPassCond.SPECIFICTYPE  then
    --            num    = victoryDecide.getKillTypeNum(cfg.victoryParam[1])
    --            maxNum = cfg.victoryParam[2]
    --        elseif cfg.victoryType == EC_LevelPassCond.SPECIFICCOUNT then
    --            num    = victoryDecide.getKillNum()
    --            maxNum = cfg.victoryParam[1]
    --        end
    --        node.textNum:setText(string.format("[%s/%s]",num,maxNum))
    --        node.imagekill:setVisible(num >= maxNum )
    --    end
    --elseif viewType == EC_LevelPassCond.GUARDMODE then
    --
    end
    --if victoryDecide.nSecondTime < 11 and victoryDecide.nSecondTime > 0 then
    --    self.image_time:show()
    --    self.label_time:setText(tostring(victoryDecide.nSecondTime))
    --else
    --    self.image_time:hide()
    --end

    self.Panel_victory:setVisible(self.isScoreLevel_)
    if self.isScoreLevel_ then
        self.textVictoryTitle:setTextById(300626)
        self.textVictorycontent:show()
    end
end
-- 300811  副本（300001–301000）通关条件标题 歼灭模式
-- 300812  副本（300001–301000）通关条件标题 生存模式
-- 300813  副本（300001–301000）通关条件标题 限时击杀
-- 300814  副本（300001–301000）通关条件标题 击杀目标
function FlightView:reLoadVictoryView()
    --local viewType = victoryDecide.nViewType
    --local parentNode = self.Panel_victoryType[viewType]:show()
    --if viewType == EC_LevelPassCond.DESTORY then  -- (歼灭模式)
    --    local levelCfg = BattleDataMgr:getLevelCfg()
    --    local maxStage = levelCfg.victoryParam[1][1]
    --    parentNode.nodes = {}
    --    for index=1,3 do
    --        local node = parentNode:getChildByName("Image_stageCur_"..tostring(index))
    --        if index <= maxStage then
    --            node.imageState1 = node:getChildByName("Image_stagePass_1")
    --            node.imageState2 = node:getChildByName("Image_stagePass_2")
    --            parentNode.nodes[index] = node
    --            node:show()
    --        else
    --            node:hide()
    --        end
    --    end
    --    parentNode.textTime  = parentNode:getChildByName("Label_time")
    --elseif viewType == EC_LevelPassCond.SURVIVAL   --生存
    --    or viewType == EC_LevelPassCond.SPECIFICID then  --限时击杀
    --    local image_bg1 = parentNode:getChildByName("Image_bg1")
    --    parentNode.node = parentNode:getChildByName("Image_bg2")
    --    parentNode.textTime        = image_bg1:getChildByName("Label_time")
    --    parentNode.node.textNum    = parentNode.node:getChildByName("Label_num")
    --    parentNode.node.imagekill  = parentNode.node:getChildByName("Image_kill")
    --    parentNode.node.imageIcon  = parentNode.node:getChildByName("Image_icon")
    --    parentNode.node.imageIcon:setTexture("ui/battle/defaut_icon.png") --设置默认头像
    --
    --
    --elseif viewType == EC_LevelPassCond.SPECIFICTYPE
    --    or viewType == EC_LevelPassCond.SPECIFICCOUNT then
    --    parentNode.nodes = {}
    --    for index=1,2 do
    --        local node      = parentNode:getChildByName("Image_bg"..tostring(index))
    --        node:hide()
    --        node.textNum    = node:getChildByName("Label_num")
    --        node.imagekill  = node:getChildByName("Image_kill")
    --        node.imageIcon  = node:getChildByName("Image_icon")
    --        node.imageIcon:setTexture("ui/battle/defaut_icon.png") --设置默认头像
    --        parentNode.nodes[index] = node
    --    end
    --elseif viewType == EC_LevelPassCond.GUARDMODE then  -- 守护模式
    --    local node = parentNode:getChildByName("Image_guardProgress")
    --    parentNode.nodes = {}
    --    for index =1,3 do
    --        parentNode.nodes[index] = node:getChildByName("LoadingBar_"..tostring(index))
    --    end
    --end
    -- self.image_victory_title:setText(title)
    self:refreshVictoryState()
end

function FlightView:_fadeOut()
    local panel = TFPanel:create()
    -- BattleMgr.bindActionMgr(panel)
    -- panel:setAnchorPoint(me.p(0.5,0.5))
    panel:setBackGroundColorType(TF_LAYOUT_COLOR_SOLID)
    panel:setBackGroundColor(me.c3b(0, 0, 0))
    panel:setSize(self:getSize())
    local callback = CallFunc:create(function()
        panel:removeFromParent()
    end)
    local actions  = { FadeOut:create(1), callback }
    panel:runAction(Sequence:create(actions))

    self:addChild(panel)
end

function FlightView:onShow()
    self.super.onShow(self)
    print("------------onShow-------------")
    if not self.bOnShow then
        self.Panel_fight:setCameraMask(eCameraFlag.CF_MAP)
        self:_fadeOut()
        self.bOnShow = true
        flightController.start()
    end
end

function FlightView:exitBattle()
    flightController.exitBattle()
    --清理场景上的节点
    self.Panel_map:removeAllChildren()
end


--加载地图
function FlightView:loadMap()
    self.mapView = BattleMap:new(flightController)
    self.Panel_map:addChild(self.mapView)
end

function FlightView:onPause()
    self.pause_ = true
    flightController.pause()
    flightController.pauseOrResume(true)
    TFAudio:pauseAllEffects()
    TFAudio:pauseMusic()
end

function FlightView:onResume()
    self.pause_ = false
    flightController.resume()
    flightController.pauseOrResume(false)
    TFAudio:resumeMusic()
    TFAudio:resumeAllEffects()
end

function FlightView:onLeave()
    if self.battleType_ == EC_BattleType.ENDLESS then
        if self.endlessTimer_ then
            TFDirector:removeTimer(self.endlessTimer_)
            self.endlessTimer_ = nil
        end
        self:showEndlessResult()
    else
        self:showFuben()
    end
end

function FlightView:backGame()
    self:onResume()
end

function FlightView:registerEvents()
    -------全局事件-----
    EventMgr:addEventListener(self, eEvent.EVENT_ACTOR_ADD_TO_LAYER, handler(self.onActorAddToLayer, self))
    EventMgr:addEventListener(self, eEvent.EVENT_TIP, handler(self.showTip, self))
    EventMgr:addEventListener(self, eEvent.EVENT_EFFECT_ADD_TO_LAYER, handler(self.onEffectAddToLayer, self))
    EventMgr:addEventListener(self, eEvent.EVENT_SCREEN_WOBBLE, handler(self.onScreenWobble, self))
    EventMgr:addEventListener(self, eEvent.EVENT_CAMERA_EVENT, handler(self.onCameraEvent, self))
    EventMgr:addEventListener(self, eEvent.EVENT_SHOW_BATTLE_START, handler(self.onBattleStart, self))
    EventMgr:addEventListener(self, eEvent.EVENT_SHOW__STACE_CLEAR, handler(self.onStaceClear, self))
    EventMgr:addEventListener(self, eEvent.EVENT_PAUSE, handler(self.onPause, self))
    EventMgr:addEventListener(self, eEvent.EVENT_RESUME, handler(self.onResume, self))
    EventMgr:addEventListener(self, eEvent.EVENT_LEAVE, handler(self.onLeave, self))
    --英雄状态
    EventMgr:addEventListener(self, eEvent.EVENT_SHOW_STATE, handler(self.onShowState, self))
    --update
    self:addMEListener(TFWIDGET_ENTERFRAME, handler(self.update, self))
    self:addMEListener(TFWIDGET_EXIT, handler(self._onExit, self))
    -- 主线进度更新
    EventMgr:addEventListener(self, EV_FUBEN_UPDATEMAINLINEPROGRESS, handler(self.onUpdateMainLineProgressEvent, self))
    -- 常规战斗结束
    EventMgr:addEventListener(self, EV_BATTLE_FIGHTOVER, handler(self.onEndBattleEvent, self))
    -------------UI事件--------------
    ---- 暂停
    --self.Button_pause:onClick(function()
    --    self:commonPauseGame()
    --    self:onPause()
    --end)

    --幕布
    EventMgr:addEventListener(self, EV_BATTLE_CURTAIN, handler(self.curtainEvtHandle, self))

    ---- 恢复
    --self.Button_resume:onClick(function()
    --    self.Panel_pause_root:hide()
    --    self:onResume()
    --end)
    --
    ---- 离开
    --self.Button_exit:onClick(function()
    --    self.Button_exit:setTouchEnabled(false)
    --    self:onLeave()
    --end)

    EventMgr:addEventListener(self, eEvent.EVENT_CAPTAIN_CHANGE, handler(self.onCaptainChange, self))
    --角色属性变更
    EventMgr:addEventListener(self, eEvent.EVENT_HERO_ATTR_CHANGE, handler(self.onHeroAttrChange, self))
    --boss变更通知UI刷新
    EventMgr:addEventListener(self, eEvent.EVENT_BOSS_CHANGE, handler(self.onBossChange, self))
    --boss出现预警
    EventMgr:addEventListener(self, eEvent.EVENT_BOSS_WARNING, handler(self.onBossWarning, self))
    --引导前进
    EventMgr:addEventListener(self, eEvent.EVENT_SHOW_GO, handler(self.onShowGo, self))
    --显示挑战进度
    EventMgr:addEventListener(self, eEvent.EVENT_SHOW_CHALLENGE_PROGRESS, handler(self.onShowChallengeProgress, self))
    --onShowHitLine
    EventMgr:addEventListener(self, eEvent.EVENT_SHOW_HITLINE, handler(self.onShowHitLine, self))
    EventMgr:addEventListener(self,eEvent.EVENT_VISUAL_HERO_ADD_TO_LAYER, handler(self.onAddVisualHeroToLayer, self))
    --
    EventMgr:addEventListener(self, eEvent.EVENT_HIT_BLUR, handler(self.onHitBlur, self))
    EventMgr:addEventListener(self, eEvent.EVENT_HIT_BLAST, handler(self.onHitBlast, self))
    EventMgr:addEventListener(self, eEvent.EVENT_MAP_MASK, handler(self.onMapMask, self))
    --EventMgr:addEventListener(self, eEvent.EVENT_ADDTO_UI_EFFECT, handler(self.onAddToUIEffect, self))
    EventMgr:addEventListener(self, eEvent.EVENT_ASSIT_COUNT_DOWN, handler(self.onAssitCountDown, self))
    EventMgr:addEventListener(self, eEvent.EVENT_FIX_CAMERA_Z, handler(self.onFixCameraZ, self))
    EventMgr:addEventListener(self, eEvent.EVENT_REFRESH_VICTORY_STATE, handler(self.refreshVictoryState, self))
    EventMgr:addEventListener(self, eEvent.EVENT_BUFFER_EFFECT_ICON, handler(self.onBufferEffectIcon, self))
    EventMgr:addEventListener(self,eEvent.EVENT_KEYBOARD_SHOW, handler(self.onKeyBoardShow,self))
    EventMgr:addEventListener(self,eEvent.EVENT_BATTLE_UI_SHOW, handler(self.onBattleUIShow,self))
    --显示目标提示
    EventMgr:addEventListener(self,eEvent.EVENT_PREWARTIP_SHOW, handler(self.showPrewarTip, self))
    EventMgr:addEventListener(self, eEvent.EVENT_KILL_SCORE, handler(self.onUpdateScoreEvent, self))
    EventMgr:addEventListener(self, eEvent.EVENT_CHANGE_MAP_SPEED, function (value) self.mapView:setSpeed(value) end)

    --游戏切后台处理
    EventMgr:addEventListener(self,EV_APP_ENTERBACKGROUND, handler(self.onEnterBackGround,self))

    --EventMgr:dispatchEvent("FUCK_TEST_FUCK", deltaSpeed)
end

function FlightView:onKeyBack()
    Utils:openView("battle.BattlePauseView")
    self:onPause()
end

function FlightView:onEnterBackGround()
    Utils:openView("battle.BattlePauseView")
    self:onPause()
end

function FlightView:onKeyBoardShow(isShow)
    self.keyBoard:setVisible(isShow)
end

function FlightView:onBattleUIShow(isShow)
    self.Panel_ui:setVisible(isShow)
    self.Panel_effect:setVisible(isShow)
end


--buffer effect icon state change
function FlightView:onBufferEffectIcon(object, state)
    print("icon event:", state)
    local listView = self.captainIconListView
    local hero
    if state == eBufferEffectIconEvent.RELOAD then --重先载入(切换角色时触发)
        hero = object
    else
        hero = object.host
    end
    if hero:isBoss() then
        listView = self.bossIconListView
        if self.bossIconListView.objectId ~= hero:getObjectID() then
            return
        end
    else
        listView = self.captainIconListView
    end

    if state == eBufferEffectIconEvent.ADD then --添加
        listView:createItem(object,true)
    elseif state == eBufferEffectIconEvent.REMOVE then --移除
        listView:removeItem(object)
    elseif state == eBufferEffectIconEvent.UPDATE_ADDTIMES then --更新次数
        listView:refresh(object)
    elseif state == eBufferEffectIconEvent.TWINKLE  then --闪烁
        listView:twinkle(object)
    elseif state == eBufferEffectIconEvent.RELOAD then --重先载入(切换角色时触发)
        listView:reload(object)
    end
end

--功能状态变更
function FlightView:onFuncStateChange(func)
    if func then
        if func.switchType == EC_FunctionEnum.TEAM_FIGHT then
            if not func.open then
                AlertManager:changeScene(SceneType.MainScene)
            end
        end
    end
end

function FlightView:onFixCameraZ(time, fixZ)
    if self.camera then
        self.camera:setFixZ(time, fixZ)
    end
end

function FlightView:onMapMask(visible)
    if visible then
        self.mapView:showMask()
    else
        self.mapView:hideMask()
    end
end

--显示挑战进度 356
function FlightView:onShowHitLine(pos)
    local skeletonNode = ResLoader.createEffect("effects_HitLine", 1)
    local actIdx       = RandomGenerator._random(0, 3)
    skeletonNode:playByIndex(actIdx, 0)
    skeletonNode:setPosition(pos)
    skeletonNode:addMEListener(TFARMATURE_COMPLETE, function(_skeletonNode)
        _skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
        _skeletonNode:removeFromParent()
    end)
    self.mapView:addObject3(skeletonNode)
end

--显示挑战进度 356
function FlightView:onShowChallengeProgress(index)
    local statistics = self.statistics_
    local starCfg = statistics:getStarCfg()
    local starInfo = starCfg[index]
    local starType = starInfo.starType
    local starDescribe = EC_FBStarRuleStr[starType]
    if starInfo then
        local isReach = statistics.getStarIsReach(index)
        self.Panel_progress:show()
        self.Panel_progress:stopAllActions()
        self.Panel_progress:fadeIn(0.1)
        self.Panel_progress:timeOut(function ()
            self.Panel_progress:fadeOut(0.5)
        end,2)
        -- if isReach then
        --     self.label_tip2:setColor(me.c3b(0x00,0xff,0x00))
        -- else
        --     self.label_tip2:setColor(me.c3b(0xBB,0xBB,0xBB))
        -- end

        self.label_tip1:setText(TextDataMgr:getText(starDescribe ,starInfo.starParam))
        local curValue = statistics.getStarRuleValue(starType,starInfo.starParam)
        local desc = FubenDataMgr:getStarRuleDesc(self.levelCid_, starInfo.pos)
        self.label_tip1:setText(desc)
        local condRule1, condRule2, condRule3, condRule4, condRule5 = statistics.getAllCondStarType()
        if table.indexOf(condRule1, starType) ~= -1 then
            if isReach then
                self.label_tip2:setTextById(100000006, curValue, starInfo.starParam)
            else
                self.label_tip2:setTextById(800063)
            end
            self.Image_star:setGrayEnabled(true)
        elseif table.indexOf(condRule2, starType) ~= -1 then
            if isReach then
                self.label_tip2:setTextById(300611)
            else
                self.label_tip2:setTextById(304004)
            end
            self.Image_star:setGrayEnabled(not isReach)
        elseif table.indexOf(condRule3, starType) ~= -1 then
            if isReach then
                self.label_tip2:setTextById(300611)
            else
                self.label_tip2:setTextById(100000006, curValue, starInfo.starParam)
            end
            self.Image_star:setGrayEnabled(not isReach)
        elseif table.indexOf(condRule4, starType) ~= -1 then
            if isReach then
                self.label_tip2:setTextById(100000007)
            else
                self.label_tip2:setTextById(100000008)
            end
            self.Image_star:setGrayEnabled(not isReach)
        elseif table.indexOf(condRule5, starType) ~= -1 then
            if isReach then
                self.label_tip2:setTextById(100000009)
            else
                self.label_tip2:setTextById(100000008)
            end
            self.Image_star:setGrayEnabled(true)
        end
    end
end

--引导前进
function FlightView:onShowGo(visible)
    self.image_go:stopAllActions()
    if not visible then
        self.image_go:hide()
    else
        self.image_go:runAction(RepeatForever:create(Blink:create(2, 3)))
        self.image_go:show()
    end
end

--boss 预警动画
function FlightView:onBossWarning(name, action, pos, callFunc)
    local size         = self.Panel_ui_effect_top:getSize()
    local skeletonNode = ResLoader.createEffect(name, 0.45)
    if action then
        skeletonNode:play(action, 0)
    else
        skeletonNode:playByIndex(0, 0)
    end
    skeletonNode:setPosition(me.p(size.width, pos.y))
    skeletonNode:addMEListener(TFARMATURE_COMPLETE, function(_skeletonNode)
        _skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
        _skeletonNode:removeFromParent()
        if callFunc then
            callFunc()
        end
    end)
    self.mapView:addObject(skeletonNode, 1)
end

function FlightView:onCaptainChange(hero)
    self.playerNode.loadingBar_hp:setPercent(hero:getHpPercent()*0.01)
    self.playerNode.imageHead:setTexture(hero:getData().fightIcon)
    self.Panel_top:show()
end

function FlightView:onHeroAttrChange(hero)
    self.playerNode.loadingBar_hp:setPercent(hero:getHpPercent()*0.01)

    if flightController.getCaptain() and self.isScoreLevel_ then
        self:onUpdateScoreEvent()
    end
end
--怪物属性刷新
function FlightView:onBossChange(hero)
    if hero then
        if self.bossNode.objectId ~= hero:getObjectID() then
            self.bossIconListView.objectId = hero:getObjectID()
            self.bossIconListView:reload(hero) --重先载入buffer图标
            self.bossNode.objectId = hero:getObjectID()
        end
        self.bossNode:show()
        self.bossNode:stopAllActions()
        -- local num = math.max(hero:getData().healthBar,1)
        -- self.bossNode.label_loadbar_num:setText(string.format("x%s",num))
        --血条(一共几条,显示当前的百分比)
        local index , percent = hero:getHpPercentEx()
        local showIndex = (index -1)%4 + 1
        local showIndex_= -1
        self.bossNode.label_loadbar_num:setText(string.format("x%s",index))
        if index > 1 then
            showIndex_= showIndex -1
            showIndex_ = showIndex_ < 1 and (showIndex_ + 4) or showIndex_
        end
        for i=1,4 do
            local loadbar = self.bossNode.loadingBarHps[i]
            if showIndex == i then
                loadbar:show()
                loadbar:setPercent(percent)
                loadbar:setZOrder(1)
            elseif showIndex_ == i then
                loadbar:show()
                loadbar:setPercent(100)
                loadbar:setZOrder(0)
            else
                loadbar:hide()
            end
        end

        --护盾值
        self.bossNode.loadingBar_np:setPercent(hero:getShieldPercent()*0.01)
        --霸体值
        if hero:getMaxResist() > 0 then
            self.bossNode.image_bg_nnp:show()
            self.bossNode.loadingBar_nnp:show()
            self.bossNode.loadingBar_nnp:setPercent(hero:getResistPercent()*0.01)
        else
            self.bossNode.image_bg_nnp:hide()
            self.bossNode.loadingBar_nnp:hide()
        end

        self.bossNode.label_name:setText(hero:getName())
        -- self.bossNode.label_affix:setText("[飞毛腿]")
        self.bossNode.label_affix:setText("")
        local position = self.bossNode.label_name:getPosition()
        local size     = self.bossNode.label_name:getSize()
        position = me.pAdd(position,me.p(size.width,0))
        self.bossNode.label_affix:setPosition(position)
        --死亡倒计时2秒消失
        if hero:getHpPercent() == 0 then
            self.bossNode:timeOut(function()
                self.bossNode:hide()
            end, 2)
        end
    else
        self.bossNode:hide()
    end

end

function FlightView:update(target, deltaTime)
    if self.pause_ then
        return
    end
    deltaTime = deltaTime*1000
    flightController.update(deltaTime)
    BattleMgr.loop(deltaTime * 0.001)
    self.camera:update(deltaTime)
    self.mapView:update(self.camera)
    if flightController.mapScroll then
        self.mapView:updateMap(deltaTime)
    end
    --self:updateTime()
end

--角色添加到战斗场景
function FlightView:onActorAddToLayer(child)
    child:addTo(self.mapView)
end

function FlightView:onEffectAddToLayer(effect, index)
    index = index or 2
    self.mapView:addObject(effect, index)
end

function FlightView:onAddVisualHeroToLayer(vHero,index)
    index = index or 2
    self.mapView:addObject(vHero,index)
end

function FlightView:createTipModel(hurtType, deltaHp, offsetPos, isPG)
    offsetPos  = offsetPos or ccp(0, 0)
    isPG       = isPG or false
    local node = CCNode:create()
    local font
    if deltaHp < 0 then
        if hurtType == eHurtType.CRIT then
            font = self.labelBMFont_yellow:clone():show()
        else
            if isPG then
                font = self.labelBMFont_white:clone():show()
            else
                font = self.labelBMFont_red:clone():show()
            end
        end
        font:setText(string.format("%s", math.abs(deltaHp)))
    elseif deltaHp > 0 then
        font = self.labelBMFont_greed:clone():show()
        font:setText(string.format("%s", math.abs(deltaHp)))
    end
    if font then
        if hurtType == eHurtType.PREICE then
            --穿透时增加标示
            local posX  = 30 - font:getSize().width / 2
            posX        = posX > 0 and 0 or posX
            local image = TFImage:create()
            image:setTexture("ui/battle/pierce.png")
            image:setPositionX(posX)
            node:addChild(image)
        end
        font:setPosition(offsetPos)
        node:addChild(font)
    end
    return node
end



--蚊子展示
function FlightView:onShowState(state,pos)
    --local node = self.prefab_wenzi:clone()
    --node:setText(state)
    --node:setPosition(pos)
    --node:setCameraMask(eCameraFlag.CF_MAP)
    --node:setZOrder(201)
    --self.Panel_effect:addChild(node)
    --BattleUtils.tipAniRed(node)
end

function FlightView:showTip(deltaHp,pos,hurtType)
    -- Sprite:create("ui/dating/icon/btn_slider.png") --
    -- local root = CCNode:create()

    --local node
    --if deltaHp < 0 then
    --    deltaHp = math.abs(deltaHp)
    --    if hurtType == eHurtType.PUGONG then
    --        node = self:createNumNode(eNumNodeType.PuGong,deltaHp)
    --    elseif hurtType == eHurtType.SKILL then
    --        node = self:createNumNode(eNumNodeType.JiNeng,deltaHp)
    --    elseif hurtType == eHurtType.PARRY then --格挡(属于普通攻击)
    --        node = self:createNumNode(eNumNodeType.PuGong,deltaHp)
    --        self:onShowState(eShowState.GeDang,me.p(pos.x,pos.y + 40))
    --    elseif hurtType == eHurtType.PREICE then --穿透
    --        node = self:createNumNode(eNumNodeType.ChuanTou,deltaHp)
    --    elseif hurtType == eHurtType.CRIT then --暴击
    --        node = self:createNumNode(eNumNodeType.BaoJi,deltaHp)
    --    elseif hurtType == eHurtType.DODGE then --miss
    --        self:onShowState(eShowState.Miss,pos)
    --        return
    --    elseif hurtType == eHurtType.DODGE1 then --闪避
    --        self:onShowState(eShowState.ShanBi,pos)
    --        return
    --    end
    --else
    --    node = self:createNumNode(eNumNodeType.ZhiYu,deltaHp)
    --end
    --if node then
    --    BattleUtils.tipAni(node)
    --    node:setPosition(pos)
    --    node:setCameraMask(self.Panel_effect:getCameraMask())
    --    node:setZOrder(200)
    --    self.Panel_effect:addChild(node)
    --end
end

local shakePoints = {
    me.p(0, 1),
    me.p(1, 0),
    me.p(0, -1),
    me.p(-1, 0)
}
--屏幕震动
function FlightView:onScreenWobble(data)
    -- if not self.cameraSprite then
    --     return
    -- end
    local screenWobbleNode = self.Panel_map
    if not screenWobbleNode.defaultPos then
        screenWobbleNode.defaultPos = screenWobbleNode:getPosition()
    end
    screenWobbleNode:stopAllActions()
    screenWobbleNode:setScale(1)
    screenWobbleNode:setPosition(self.Panel_map.defaultPos) --还原默认位置

    local shakeCount= data.shakeCount
    local shakeType = data.shakeType   --震动类型
    local shakeStrength  = data.shakeStrength
    local shakeInching   = data.shakeInching
    shakeType = shakeType or 1
    shakeCount= shakeCount or 2
    shakeStrength  = shakeStrength or 10 --抖动时候是移动的像素 /缩放时是缩放比,取值范围 0 - 100
    local actions = {}
    local flag = 1
    if shakeType == eShakeType.MOVE then --
        local point1 = me.pMult(shakePoints[RandomGenerator._random(4)],shakeStrength)
        local sign   = RandomGenerator._randomSign()
        local point2 = me.p(point1.y*sign,point1.x*sign)
        local point3 = me.pAdd(point1,point2)
        point3 = me.pMult(point3,-1)
        -- print(point1,point2,point3)
        for i = 1, shakeCount do
            if shakeInching then
                flag = i
            end
            table.insert(actions, MoveBy:create(0.03, me.pMult(point1,1/flag)))
            table.insert(actions, MoveBy:create(0.03, me.pMult(point2,1/flag)))
            table.insert(actions, MoveBy:create(0.03, me.pMult(point3,1/flag)))
        end

    elseif shakeType == eShakeType.SCALE then --缩放
        local scale = shakeStrength/100
        -- table.insert(actions, ScaleTo:create(0.1, 1.0))
        for i = 1, shakeCount do
            if shakeInching then
                flag = i
            end
            table.insert(actions, ScaleTo:create(0.1*i, 1 + scale/flag))
            table.insert(actions, ScaleTo:create(0.1*i, 1.0))
        end
    end
    --抖屏回调
    if data.callFunc then
        table.insert(actions, CallFunc:create(data.callFunc))
    end
    screenWobbleNode:runAction(Sequence:create(actions))
end

function FlightView:onCameraEvent(...)
    self.camera:runAction(...)
end

function FlightView:onBattleStart(callback)
    local size         = self.Panel_ui_effect_top:getSize()
    local skeletonNode = ResLoader.createEffect("battle_Start", 1)
    skeletonNode:playByIndex(0, 0)
    skeletonNode:setPosition(me.p(size.width / 2, size.height / 2))
    skeletonNode:addMEListener(TFARMATURE_COMPLETE, function(_skeletonNode)
        _skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
        _skeletonNode:removeFromParent()
        if callback then
            callback()
        end
    end)
    self.Panel_ui_effect_top:addChild(skeletonNode)
end

function FlightView:onStaceClear(result, callback)
    local function _callFunc()
        if self.battleType_ == EC_BattleType.COMMON then
            self.endAniFlag_ = true
            self:commonFightResult()
            if callback then
                callback()
            end
        elseif self.battleType_ == EC_BattleType.ENDLESS then   --TODO 后续无尽模式需要再做处理
            Box("TODO无尽模式胜利失败处理")
        end
    end
    if self.levelCfg_ and self.levelCfg_.isPlayVictorAction then  --是否展示胜利失败动画
        local size = self.Panel_ui_effect_top:getSize()
        local bWin = result
        local skeletonNode
        if bWin then
            skeletonNode = ResLoader.createEffect("battle_end_win",1)
        else
            skeletonNode = ResLoader.createEffect("battle_end_defeated",1)
        end
        skeletonNode:play("animation", 0)
        skeletonNode:setPosition(me.p(size.width/2, size.height/2))
        skeletonNode:addMEListener(TFARMATURE_COMPLETE,function(_skeletonNode)
            _callFunc()
        end)
        self.Panel_ui_effect_top:addChild(skeletonNode)
    else
        _callFunc()
    end

    -- local size = self.Panel_ui_effect_top:getSize()
    -- local bWin = result
    -- if self.battleType_ == EC_BattleType.COMMON then
    --     self:timeOut(function()
    --         print("---------战斗结束--------", bWin)
    --         local skeletonNode
    --         if bWin then
    --             skeletonNode = ResLoader.createEffect("battle_end_win", 1)
    --         else
    --             skeletonNode = ResLoader.createEffect("battle_end_defeated", 1)

    --         end
    --         skeletonNode:play("animation", 0)
    --         skeletonNode:setPosition(me.p(size.width / 2, size.height / 2))
    --         skeletonNode:addMEListener(TFARMATURE_COMPLETE, function(_skeletonNode)
    --             _skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
    --             -- _skeletonNode:removeFromParent()
    --             self.endAniFlag_ = true
    --             self:commonFightResult()
    --             if callback then
    --                 callback()
    --             end
    --         end)
    --         self.Panel_ui_effect_top:addChild(skeletonNode)
    --     end, 1)
    -- elseif self.battleType_ == EC_BattleType.ENDLESS then
    --     self.Panel_endlessResult:show()
    --     self.Label_endlessPassTime:setVisible(bWin)
    --     if bWin then
    --         local time              = math.floor(self.statistics_.time * 0.001)

    --         local _, hour, min, sec = Utils:getDHMS(time, true)
    --         local timeStr           = TextDataMgr:getText(800014, min, sec)
    --         self.Label_endlessPassTime:setTextById(2100024, timeStr)
    --         self.Label_endlessResult:setTextById(2100022)
    --     else
    --         self.Label_endlessResult:setTextById(2100023)
    --     end
    --     self:timeOut(function()
    --         self.endAniFlag_ = true
    --         self.Panel_endlessResult:hide()
    --         self:endlessFightResult()
    --     end, 2)
    -- end
end

function FlightView:onUpdateMainLineProgressEvent()
    self.uProgressFlag_ = true
    self:commonFightResult()
end

function FlightView:onEndBattleEvent(dropReward, isWin)
    self.dropReward_ = dropReward
    self.endMsgFlag_ = true
    self.isWin_      = isWin
    self:commonFightResult()
end

function FlightView:mainLineFightResult()
    if self.endMsgFlag_ and self.endAniFlag_ then
        self.endMsgFlag_ = false
        self.endAniFlag_ = false
        self:showFuben()
        if self.uProgressFlag_ then
            self.uProgressFlag_ = false
            EventMgr:dispatchEvent(EV_FUBEN_UPDATEMAINLINEPROGRESS)
        end
    end
end

function FlightView:normalFightResult()
    if self.endMsgFlag_ and self.endAniFlag_ then
        self.endMsgFlag_ = false
        self.endAniFlag_ = false

        local levelId    = BattleDataMgr:getPointId()
        if self.isWin_ then
            local view = Utils:openView("battle.BattleResultView", self.dropReward_, flightController.getTime())
            view:setCameraMask(eCameraFlag.CF_UI)
        else
            self:showFuben()
        end
    end
end

--返回活动副本

function FlightView:showFuben()

    AlertManager:changeScene(SceneType.MainScene)
    --FubenDataMgr:openFuben()
end

function FlightView:commonFightResult()
    local battleType = BattleDataMgr:getBattleType()
    if battleType == EC_BattleType.COMMON then
        self:normalFightResult()
    elseif battleType == EC_BattleType.ENDLESS then

    elseif battleType == EC_BattleType.TEAM_FIGHT then

    end
end

--function FlightView:endlessFightResult()
--    local isWin = battleController.isWin()
--    if self.endAniFlag_ then
--        if isWin then
--            if self.endMsgFlag_ then
--                local endlessInfo = FubenDataMgr:getEndlessInfo()
--                if endlessInfo.step == EC_EndlessState.ING then
--                    local endlessCloisterLevel = FubenDataMgr:getEndlessCloisterLevel(self.levelCfg_.week)
--                    local maxLevel = FubenDataMgr:getEndlessMaxLevel()
--                    if self.levelCfg_.order < #endlessCloisterLevel and self.levelCfg_.order < maxLevel then
--                        self:endlessCountDown()
--                    else
--                        self:showEndlessResult()
--                    end
--                else
--                    local seq = Sequence:create({
--                            Show:create(),
--                            DelayTime:create(2),
--                            CallFunc:create(function()
--                                    self:showEndlessResult()
--                            end)
--                    })
--                    self.Panel_endlessStop:runAction(seq)
--                end
--            end
--        else
--            self:showEndlessResult()
--        end
--    end
--end

function FlightView:showEndlessResult()
    if #self.statistics_.endlessPassLevel > 0 then
        local view = Utils:openView("battle.EndlessResultView")
        view:setCameraMask(eCameraFlag.CF_UI)
    else
        self:showFuben()
    end
end

--function FlightView:endlessCountDown()
--    local textId = {
--        2100029,
--        2100030,
--        2100031,
--        2100032,
--        2100033,
--    }
--    local countdownTime = 5
--    local countdownInterval = 1
--    local aniInterval = 0.2
--    local aniTiming = 0
--    local countdownTiming = 0
--    local textIndex = 1
--    local nextLevelCfg = FubenDataMgr:getEndlessCloisterLevelCfg(self.nextLevelCid_)
--    self.Label_endlessCountDown:show()
--    self.Label_endlessCountDown:setTextById(textId[textIndex], nextLevelCfg.order, countdownTime)
--    self.endlessTimer_ = TFDirector:addTimer(1000, 5000 / 1000,
--                        function()
--                            FubenDataMgr:send_ENDLESS_CLOISTER_REQ_START_FIGHT_ENDLESS()
--                        end,
--                        function(dt)
--                            countdownTime = countdownTime - 1
--                            if countdownTime > 0 then
--                                textIndex = textIndex + 1
--                                if textIndex > #textId then
--                                    textIndex = 1
--                                end
--                                self.Label_endlessCountDown:setTextById(textId[textIndex], nextLevelCfg.order, countdownTime)
--                            end
--                        end
--    )
--end

function FlightView:onHitBlur(fuzzyTime,fuzzyLevel)
    -- fuzzyTime       = 2000
    -- fuzzyLevel      = 50
    self.fuzzyTime  = fuzzyTime
    self.fuzzyLevel = fuzzyLevel
    self.fuzzyDecay = self.fuzzyLevel / self.fuzzyTime
    -- self:applyShader(eShaderType.BLUR)
end

function FlightView:onHitBlast(blastLevel)
    self.blastLevel = blastLevel
    -- self:applyShader(eShaderType.BLAST)
end

function FlightView:handleShader(dt)
    self:initCameraSprite()
    if BattleConfig.SHADER_BLUR and self.cameraSprite.shaderType == eShaderType.BLUR then  --是否开启模糊效果

        if self.fuzzyTime > 0 then
            -- print("xxxxxxx"..self.fuzzyTime , self.fuzzyTime*self.fuzzyDecay)
            self.captureSprite = true

            local _GLProgramState = self.cameraSprite:getGLProgramState()
            _GLProgramState:setUniformInt("flagBlur", 1)

            _GLProgramState:setUniformFloat("f_mlen", self.fuzzyTime*self.fuzzyDecay)
            local point = self.camera:getRoleAnchorPoint()
            _GLProgramState:setUniformVec2("v_center", point)

            self.fuzzyTime = self.fuzzyTime - dt
        else
            if self.captureSprite then
                self.captureSprite = nil
                --模糊效果关闭
                local _GLProgramState = self.cameraSprite:getGLProgramState()
                _GLProgramState:setUniformInt("flagBlur", 0)
            end
        end
    end
end

--创建特效纹理
function FlightView:initCameraSprite()
    if not self.cameraSprite then
        self.cameraSprite  = Sprite:createWithTexture(self.camera.camera1Texture)
        BattleMgr.bindActionMgr(self.cameraSprite)
        self.cameraSprite:setCameraMask(eCameraFlag.CF_EFFECT_BLAST)
        self.Panel_fight:addChild(self.cameraSprite)
        self.cameraSprite:setFlipY(true)
        self.cameraSprite:setAnchorPoint(me.p(0.5,0.5))
        local size = self.Panel_fight:getSize()
        self.cameraSprite.defaultPos = me.p(size.width/2,size.height/2)
        self.cameraSprite:setPosition(self.cameraSprite.defaultPos)
        --解决气浪安卓不能显示的问题
        local cameraSpriteBlast = Sprite:createWithTexture(self.camera.camera3Texture)
        BattleMgr.bindActionMgr(cameraSpriteBlast)
        cameraSpriteBlast:setFlipY(true)
        cameraSpriteBlast:setAnchorPoint(me.p(0.5,0.5))
        cameraSpriteBlast:setPosition(self.cameraSprite.defaultPos)
        self.Panel_fight:addChild(cameraSpriteBlast)
    end
end

function FlightView:applyShader(shaderType)
    local obj = self.cameraSprite
    if obj and obj.shaderType ~= shaderType then
        if shaderType == eShaderType.BLUR then
            obj:setShaderProgram("DalMotionblur")
            local size = self.cameraSprite:getSize()
            local _GLProgramState = self.cameraSprite:getGLProgramState()
            _GLProgramState:setUniformFloat("f_ins", 1/size.width)
        elseif shaderType == eShaderType.BLAST then         -- 气浪
            -- local DalBlast = me.ShaderCache:getGLProgram("DalBlast")
            -- local _GLProgramState = GLProgramState:getOrCreateWithGLProgram(DalBlast)
            -- obj:setGLProgramState(_GLProgramState)
            obj:setShaderProgram("DalBlast")
            local _GLProgramState = obj:getGLProgramState()
            _GLProgramState:setUniformTexture("maskTex",  self.camera.camera2Texture)
            _GLProgramState:setUniformTexture("noiseTex", self.noiseSprite:getTexture())
            _GLProgramState:setUniformInt("flag", 1)
            _GLProgramState:setUniformFloat("GlowRange", self.blastLevel)
            _GLProgramState:setUniformVec2("TextureSize", ccp(1/me.winSize.width, 1/me.winSize.height))
        else
            obj:setShaderProgramDefault(true)
        end
        obj.shaderType = shaderType
    end
end

--function FlightView:onEndlessPassEvent(nextLevelCid, dropReward)
--    self.endMsgFlag_ = true
--    self.nextLevelCid_ = nextLevelCid
--    self.statistics_.endlessPassEvent(self.levelCid_, dropReward)
--    self:endlessFightResult()
--end

function FlightView:onUpdateScoreEvent()
    local score = statistics.getScore()
    self.textVictorycontent:setText(score)
end

function FlightView:specialKeyBackLogic( )
    GuideDataMgr:setPlotLvlBackState(true)
    return false
end

return FlightView
