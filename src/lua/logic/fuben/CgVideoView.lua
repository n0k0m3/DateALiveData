
local CgVideoView = class("CgVideoView", BaseLayer)

function CgVideoView:initData(mainLineId)
    self.mainLineId_ = mainLineId
    self.mainLine_ = FubenDataMgr:getMainLineCfg(self.mainLineId_)
	TFAudio.stopMusic()
    SafeAudioExchangePlay().stopAllBgm()
end

function CgVideoView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.fuben.cgVideoView")
end

function CgVideoView:initUI(ui)
	self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    local panel = TFPanel:create();
    panel:setContentSize(GameConfig.WS);
    panel:setBackGroundColorType(1);
    panel:setBackGroundColor(ccc3(0,0,0));
    panel:setBackGroundColorOpacity(255);
    self.ui:addChild(panel);
    panel:setTouchEnabled(true);
    self.videoPanel = panel;

    self.videoPlayer_ = TFVideoPlayer:create()
    self.videoPanel:addChild(self.videoPlayer_,99999)
    self.videoPlayer_:addMEListener(TFVIDEO_COMPLETE, handler(self.onVideoPlayComplete, self))
    local width = GameConfig.WS.width;
    local height = 640 * (GameConfig.WS.width / 1386);
    self.videoPlayer_:setSize(CCSizeMake(width,height))
    self.videoPlayer_:setAnchorPoint(me.p(0.5,0.5))
    self.videoPlayer_:setPosition(ccp(GameConfig.WS.width / 2,GameConfig.WS.height / 2));
    --self.videoPlayer_:setFullScreenEnabled(false);
end

function CgVideoView:onVideoPlayComplete()
    self.videoPanel:removeFromParent();
    EventMgr:dispatchEvent(EV_FUBEN_PHASECOMPLETE)
end

return CgVideoView
