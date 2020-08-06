local SkillPreView = class("SkillPreView", BaseLayer)


function SkillPreView:ctor(data)
    self.super.ctor(self)
    self.path = data;
    self:init("lua.uiconfig.angelNew.skillPreview")
end

function SkillPreView:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui
    TFAudio.stopMusic()

    self.playBtn    = TFDirector:getChildByPath(ui, "Button_skillPreview_1");
    self.closeBtn   = TFDirector:getChildByPath(ui, "Button_close");
    self.playBg     = TFDirector:getChildByPath(ui, "Image_itemInfoView_2");
    self.tips       = TFDirector:getChildByPath(ui, "Image_skillPreview_2(2)");
    self.playBtn:onClick(function()
        self:startVideo()
    end)

    self.closeBtn:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self:playVideo();
end

function SkillPreView:startVideo()
    self.playBtn:hide();
    self.tips:hide();
    self:playVideo()
end

function SkillPreView:playVideo()
    if not self.videoPlayer_ then
        self.videoPlayer_ = VlcPlayer:create({
            filePath = self.path,
            forceVLC = true,
            onVideoPlayComplete = handler(self.onVideoPlayComplete, self),
            viewSize = self.playBg:getSize()
        });
        self.playBg:addChild(self.videoPlayer_,999);
        self.videoPlayer_:setPosition(ccp(-self.playBg:getSize().width / 2 ,-self.playBg:getSize().height / 2))
        self.videoPlayer_:play()
    else
        self.videoPlayer_:setVisible(true)
        self.videoPlayer_:setFile(self.path)
        self.videoPlayer_:play()
    end

    -- self:timeOut(function()
    --     self.videoPlayer_:pause();
    -- end,0)
end

function SkillPreView:onVideoPlayComplete(videoPlayer_)
    self.playBtn:show();
    self.tips:show();
end

return SkillPreView