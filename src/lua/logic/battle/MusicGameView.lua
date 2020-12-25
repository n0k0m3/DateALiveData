local BattleUtils = import(".BattleUtils")
local BattleConfig= import(".BattleConfig")
local enum  = import(".enum")
local ResLoader = import(".ResLoader")
local eEvent      = enum.eEvent
local eCampType  = enum.eCampType

local MusicGameView = class("MusicGameView",BaseLayer)

function MusicGameView:ctor(battleController)
    self.super.ctor(self)
    self:initData(battleController)
    self:init("lua.uiconfig.battle.duanwuGameView")
end

function MusicGameView:initData(battleController)
    self.battleController = battleController
    self.ctr_btns = {}
    self.keys_images = {}
    self.keys_image_bind = {}
    self.effected_keys = {}
    self.curPassTime = 0
    self.timing = false
    self.ctringEnable = false
    self.durationTime = 0
    self.gameIdx = 0
    self.gameData = {}
    self.levelCfg_ = BattleDataMgr:getLevelCfg()
    for i,v in ipairs(self.levelCfg_.rythem) do
        local cfg = TabDataMgr:getData("DungeonRythem", v)
        table.insert(self.gameData,cfg)
    end

    self.maxRound = #self.gameData
    self.successRound = 0
    self.totalPoints = 0
    self.myPoints = 0
end

function MusicGameView:initUI(ui)
    self.super.initUI(self, ui)
    self.panel_root       = TFDirector:getChildByPath(ui, "Panel")
    local size = me.size(me.EGLView:getDesignResolutionSize())


    self.Panel_ctrlPad = TFDirector:getChildByPath(self.panel_root, "Panel_ctrlPad"):hide()
    self.Panel_show = TFDirector:getChildByPath(self.panel_root, "Panel_show"):hide()
    self.Panel_info = TFDirector:getChildByPath(self.panel_root, "Panel_info")
    self.Panel_pause = TFDirector:getChildByPath(self.panel_root, "Panel_pause")
    self.Panel_effect = TFDirector:getChildByPath(self.panel_root, "Panel_effect")
    if size.width/size.height > 1.775 then --1136/640
        self.Panel_show:setSize(size)
        self.Panel_info:setSize(size)
        size.width = size.width - 100
        self.Panel_ctrlPad:setSize(size)
    end
    self.pause_btn  = TFDirector:getChildByPath(self.Panel_pause, "Button_pause")

    self.LoadingBar_time = TFDirector:getChildByPath(self.Panel_show, "LoadingBar_time"):hide()
    self.Panel_keys = TFDirector:getChildByPath(self.Panel_show, "Panel_keys")
    self.Label_progress = TFDirector:getChildByPath(self.Panel_info, "Label_progress")
    self.Label_score = TFDirector:getChildByPath(self.Panel_info, "Label_score")
    self.barLight = ResLoader.createEffect("btlUI_rythemGame",1)
    self.barLight:play("bar",1)
    self.LoadingBar_time:addChild(self.barLight)


    for i=1,3 do
        local foo = {}
        foo.btn = TFDirector:getChildByPath(self.Panel_ctrlPad, "Button_ctrl"..i)
        foo.icon = TFDirector:getChildByPath(foo.btn, "Image_icon")
        self.ctr_btns[i] = foo
    end

    self.Label_progress:setText(self.successRound.."/"..self.maxRound)
    self.Label_score:setText(tostring(self.myPoints))

    self:updateCtrBtnUI()
    self.panel_root:runAction(CCSequence:create({DelayTime:create(0.1), CallFunc:create(function()
        self:checkWarning()
    end)}))
end

function MusicGameView:checkWarning()
    if self.levelCfg_.warningTime then
        BattleUtils.playEffect(BattleConfig.BOSS_WARNING ,false,1)
        EventMgr:dispatchEvent(eEvent.EVENT_BOSS_WARNING, function ()
                self:checkGame()
            end)
    else
        self:checkGame()
    end
end

function MusicGameView:doNextRoundGame()
    self.gameIdx = self.gameIdx + 1
    self.successRound = self.gameIdx - 1
    local data = self.gameData[self.gameIdx]
    self.durationTime = data.timeLimit
    self.finishPoint = data.finishPoint
    self.LoadingBar_time:setPercent(0)
    self:updatePanelInfo()
    self:doNextTimeGame()
    self.curPassTime = 0
    self.timing = false
    self.ctringEnable = false
end

function MusicGameView:doNextTimeGame()
    self.keys_image_bind = {}
    self.effected_keys = {}
    local data = self.gameData[self.gameIdx]
    local length = data.rythLenth
    for i=1,length do
        table.insert(self.keys_image_bind,math.random(1,3))
    end
    self:updatePanelShowUI()
end

function MusicGameView:checkGame()
    if self.gameIdx >= self.maxRound then
        self.successRound = self.gameIdx
        self:updatePanelInfo()
        self:showGameResult()
        return
    end
    self.Panel_ctrlPad:show()
    if self.curPassTime < self.durationTime then
        self:doNextTimeGame()
        return
    end
    self:doNextRoundGame()
end

function MusicGameView:showGameResult()
    self.panel_root:runAction(CCSequence:create({DelayTime:create(1.0),CallFunc:create(function()
        self.battleController.endBattle(true)
        local data = FubenDataMgr:getMusicGameLevelData()
        print("=======111111========",data)
        DuanwuHangUpDataMgr:sendHANGUP_ACT_REQ_DEAL_EVENT(data.id,data.eventid, false,self.myPoints)
        BattleDataMgr:setBattleResutlData({dropReward = {},percent = self.myPoints / math.max(self.totalPoints, 1) * 100})
        Utils:openView("battle.BattleResultView")
    end)}))
end

function MusicGameView:updateCtrBtnUI()
    for i,v in ipairs(self.ctr_btns) do
        v.icon:setTexture(self:getKeyImagePath(i))
    end
end

function MusicGameView:updatePanelShowUI()
    self.Panel_show:show()
    self.Panel_keys:removeAllChildren()
    self.Panel_keys:setOpacity(0)
    self.keys_images = {}
    local scale = #self.keys_image_bind > 5 and 0.75 or 1.0
    local width = #self.keys_image_bind > 5 and 110 or 140
    for i,v in ipairs(self.keys_image_bind) do
        local image = TFImage:create(self:getKeyImagePath(v))
        self.Panel_keys:addChild(image)
        image:setScale(scale)
        image:setPosition(ccp(width / 2 + 2 + (i - 1)*width,52))
        if i < #self.keys_image_bind then
            local arrow = TFImage:create("ui/battle/music_game/01.png")
            arrow:setAnchorPoint(ccp(0,0.5))
            self.Panel_keys:addChild(arrow)
            arrow:setPosition(ccp(image:getPositionX() + image:getSize().width * scale / 2-(15 * scale),52))
        end
        self.keys_images[i] = image
    end
    self.Panel_keys:runAction(CCSequence:create({CCFadeTo:create(0.3, 255),CallFunc:create(function()
            self.timing = true
            self.ctringEnable = true          
    end)}))
end

function MusicGameView:refreshKeyImages(idx)
    for i,image in ipairs(self.keys_images) do
        if i == idx and self.effected_keys[i] and self.effected_keys[i] == self.keys_image_bind[i] then
            local bord = TFImage:create("ui/battle/music_game/05.png")
            image:addChild(bord,-1)
            image:runAction(FadeIn:create(0.1))
            -- local skeletonNode = ResLoader.createEffect("btlUI_rythemGame",1)
            -- skeletonNode:play("button_Right",0)
            -- skeletonNode:addMEListener(TFARMATURE_COMPLETE,function(_skeletonNode)
            --        _skeletonNode:removeFromParent()
            -- end)
            -- image:addChild(skeletonNode,1)
        end
    end
end

function MusicGameView:getKeyImagePath(key)
    if key == 1 then
        return "ui/battle/music_game/08.png"
    elseif key == 2 then
        return "ui/battle/music_game/07.png"
    elseif key == 3 then
        return "ui/battle/music_game/09.png"
    end
    return "ui/battle/music_game/08.png"
end

function MusicGameView:doErrorTips(idx)
    for i,image in ipairs(self.keys_images) do
        if i >= idx then
            local skeletonNode = ResLoader.createEffect("btlUI_rythemGame",1)
            skeletonNode:play("button_Wrong_x",0)
            skeletonNode:addMEListener(TFARMATURE_COMPLETE,function(_skeletonNode)
                    _skeletonNode:removeFromParent()
            end)
            image:addChild(skeletonNode,-1)
            local skeletonNode1 = ResLoader.createEffect("btlUI_rythemGame",1)
            skeletonNode1:play("button_Wrong_s",0)
            skeletonNode1:addMEListener(TFARMATURE_COMPLETE,function(_skeletonNode)
                    _skeletonNode:removeFromParent()
            end)
            image:addChild(skeletonNode1,1)
        end
    end
    
    self.Panel_keys:runAction(CCSequence:create({DelayTime:create(0.2),CCFadeTo:create(0.3, 0), CallFunc:create(function()
        self:doNextTimeGame()
    end)}))
end

function MusicGameView:doCastSkill(dir)
    self.Panel_show:hide()
    local cfg = self.gameData[self.gameIdx]
    local skillPlayCfg = TabDataMgr:getData("DungeonRythemSkillPlay", dir == 1 and cfg.winPlayAI or cfg.failPlayAI)
    local skillIds = {}
    for k,times in pairs(skillPlayCfg.playSkillList) do
        for i=1,times do
            table.insert(skillIds,tonumber(k))
        end
    end
    if dir == 1 then
        self.battleController.preCastMixSkill(eCampType.Hero, skillIds, skillPlayCfg.preMoveLenth)
    else
        self.battleController.preCastMixSkill(eCampType.Monster, skillIds, skillPlayCfg.preMoveLenth)
    end
end

function MusicGameView:onHeroSkillOver(skillId)
    self:checkGame()
end

function MusicGameView:ctrBtnClick(idx)
    if not self.ctringEnable or #self.effected_keys >= #self.keys_image_bind then
        return
    end
    table.insert(self.effected_keys,idx)
    self:refreshKeyImages(#self.effected_keys)
    if idx ~= self.keys_image_bind[#self.effected_keys] then
        self.ctringEnable = false
        self.timing = false
        Utils:playSound(5061, false)
        self:doErrorTips(#self.effected_keys)
    elseif #self.effected_keys == #self.keys_image_bind then
        self.totalPoints = self.totalPoints + self.finishPoint
        self.myPoints = self.myPoints + self.finishPoint
        self.curPassTime = self.durationTime
        self.ctringEnable = false
        self.timing = false
        Utils:playSound(5062, false)
        local skeletonNode = ResLoader.createEffect("btlUI_rythemGame",1)
        skeletonNode:play("success",0)
        skeletonNode:setPosition(me.p(400, 45))
        skeletonNode:addMEListener(TFARMATURE_COMPLETE,function(_skeletonNode)
                _skeletonNode:removeFromParent()
                self:doCastSkill(1)
        end)
        self.Panel_keys:addChild(skeletonNode,5)
        self.Panel_keys:runAction(CCSequence:create({DelayTime:create(0.3),CCFadeTo:create(0.3, 0)}))
        self:updatePanelInfo()
    else
        local cfg = self.gameData[self.gameIdx]
        Utils:playSound(cfg.musicList[#self.effected_keys] or cfg.musicList[1], false)
    end
end

function MusicGameView:updatePanelInfo()
    self.Label_progress:setText(self.successRound.."/"..self.maxRound)
    self.Label_score:setText(tostring(self.myPoints))
end

function MusicGameView:registerEvents()
    --self:addMEListener(TFWIDGET_ENTERFRAME, handler(self.update, self))
    EventMgr:addEventListener(self, eEvent.EVENT_SKILL_OVER, handler(self.onHeroSkillOver, self))

    for i,v in ipairs(self.ctr_btns) do
        v.btn:addMEListener(TFWIDGET_CLICK, function()
            self:ctrBtnClick(i)
        end)
    end

    self.pause_btn:onClick(function()
        local data = {}
        data.maxround = self.maxRound
        data.success = self.successRound
        data.myPoints = self.myPoints
        data.points = math.max(1,self.totalPoints)
        Utils:openView("battle.BattlePauseView",data)
        EventMgr:dispatchEvent(eEvent.EVENT_PAUSE)
    end)
end

function MusicGameView:removeEvents()
    --self:removeMEListener(TFWIDGET_ENTERFRAME)
end


function MusicGameView:update(dt)
    if self.timing then
        self.curPassTime = self.curPassTime + dt
        self.LoadingBar_time:setPercent((1 - self.curPassTime / self.durationTime) * 100)
        self.barLight:setPosition(ccp(-390 + (self.curPassTime / self.durationTime * 780),0))
        if self.curPassTime >= self.durationTime then
            self.LoadingBar_time:hide()
            self.timing = false
            self.ctringEnable = false
            self.totalPoints = self.totalPoints + self.finishPoint
            Utils:playSound(5063, false)
            local skeletonNode = ResLoader.createEffect("btlUI_rythemGame",1)
            skeletonNode:play("fail",0)
            skeletonNode:setPosition(me.p(400, 45))
            skeletonNode:addMEListener(TFARMATURE_COMPLETE,function(_skeletonNode)
                    _skeletonNode:removeFromParent()
                    self:doCastSkill(2)
            end)
            self.Panel_keys:addChild(skeletonNode)
        else
            self.LoadingBar_time:show()
        end
    end
end

return MusicGameView