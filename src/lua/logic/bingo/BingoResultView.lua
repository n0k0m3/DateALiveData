
local BingoResultView = class("BingoResultView", BaseLayer)

function BingoResultView:initData(isPositive,victoryAppearId,animateCallBack)

    self.isPositive = isPositive
    self.animateCallBack = animateCallBack
    self.victoryAppearId = victoryAppearId
    self.roleModelMotionCfg = BingoDataMgr:getRoleModelMotionCfg(victoryAppearId)

end

function BingoResultView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.bingo.bingoResultView")
end

function BingoResultView:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.Panel_player_mask = TFDirector:getChildByPath(self.Panel_root, "Panel_player_mask")

    self.Image_player = TFDirector:getChildByPath(self.Panel_root, "Image_player")

    self.Panel_touch = TFDirector:getChildByPath(self.Panel_root, "Panel_touch")
    self.Panel_touch:setContentSize(GameConfig.WS)
    self.Panel_touch:setSwallowTouch(false)

    EventMgr:dispatchEvent(EV_HIDE_MAIN_LIVE2D)

    self:showModel()

end

function BingoResultView:showModel()
    --face = "Id_happy",
    --voice = "sound/role/sisinai/YOSHINO_297.mp3",
    --self.roleModelMotionCfg.model 210101
    local modelId = self.roleModelMotionCfg.model
    local face = self.roleModelMotionCfg.face
    TFAudio.playSound(self.roleModelMotionCfg.voice)
    Utils:playSound(5017, false)
    self.model = ElvesNpcTable:createLive2dNpcID(modelId,false,false,face,true).live2d
    self.model:newStartAction(face,EC_PRIORITY.FORCE)
    self.Image_player:addChild(self.model,1)
    self.model:setScale(0.6); --缩放
    local posX = self.roleModelMotionCfg.offset.x or 0
    local posY = self.roleModelMotionCfg.offset.y or 0
    local pos = ccp(posX,posY)
    self.model:setPosition(pos);--位置

    Utils:playSound(5017, false)

    local action = Sequence:create({
        EaseSineOut:create(MoveTo:create(0.8, ccp(-300, 0))),
        CCDelayTime:create(1),
        CallFunc:create(function()
            if self.animateCallBack then
                self.animateCallBack()
                AlertManager:closeLayer(self)
                BingoDataMgr:refreshResultViewState()
            end
        end),
    })
    self.Panel_player_mask:runAction(action)
end

function BingoResultView:registerEvents()

    self.Panel_touch:onClick(function ()
        AlertManager:closeLayer(self)
    end)

end

return BingoResultView
