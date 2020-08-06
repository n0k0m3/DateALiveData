local SummonGetHeroView = class("SummonGetHeroView", BaseLayer)

function SummonGetHeroView:initData(heroId, isSummon)
    self.isSummon_ = tobool(isSummon)
    self.heroId_ = heroId
    self.heroCfg_ = GoodsDataMgr:getItemCfg(heroId)
end

function SummonGetHeroView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.summon.summonGetHeroView")
end

function SummonGetHeroView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self:refreshView()
end

function SummonGetHeroView:onShow()
    self.super.onShow(self)
    if self.heroCfg_.rarity >= 3 then
        CommonManager:setStarEvaluateFlage(true)
    end

    local OldValue = USE_NATIVE_VLC
    if me.platform == 'android' then
        USE_NATIVE_VLC = true
    end

    local currentScene = Public:currentScene()
    -- local videoView = Utils:openView("common.VideoView", unpack(self.heroCfg_.bornVideo))
    local videoView = requireNew("lua.logic.common.VideoView"):new(unpack(self.heroCfg_.bornVideo))
    videoView:setAnchorPoint(ccp(0.5, 0.5))
    videoView:setPosition(ccp((GameConfig.WS.width - videoView:getSize().width)/2 + videoView:getSize().width / 2, (GameConfig.WS.height - videoView:getSize().height)/2 + videoView:getSize().height / 2))
    currentScene:addChild(videoView)
    videoView:setEndLoop(true)
    videoView:setIshowShare(true)
    videoView:bindVideoClickCallBack(function(index)
            if index > 1 then
                videoView:stopVideo()
                AlertManager:closeLayer(self)
                videoView:removeFromParent()
                EventMgr:dispatchEvent(EV_SUMMON_TOUCH_CONTINUE)
            end
            return false
    end)
    USE_NATIVE_VLC = OldValue

    AudioExchangePlay.stopAllBgm()
    TFAudio.playBmg("sound/card2.mp3")
    VoiceDataMgr:playVoiceByHeroID("hero_get",self.heroId_)
end

function SummonGetHeroView:refreshView()

end

function SummonGetHeroView:registerEvents()

end

return SummonGetHeroView
