local VideoView = class("VideoView", BaseLayer)

function VideoView:initData(...)
    self.videoPathList_ = {...}
    self.videoPathIndex_ = 1
    self.videoPlayer_ = nil

    self.isEndLoop = false
    self.isSkipComplete = false
end

function VideoView:ctor(...)
    self.super.ctor(self)

    self:initData(...)

    self:init("lua.uiconfig.common.videoView")
end

function VideoView:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui
    TFAudio.pauseMusic()

    self:startVideo()

   
end

function VideoView:setEndLoop(loop)
    self.isEndLoop = loop
end

function VideoView:setSkipComplete(isSkipComplete)
    self.isSkipComplete = isSkipComplete
end

function VideoView:bindSpecicalCompleteCallBack(fun)
    self.specicalCompleteCallBack_ = fun
end

function VideoView:bindEndCallBack(fun)
    self.callBackfun_ = fun
end

function VideoView:bindVideoClickCallBack(fun)
    self.videoClickCallBackfun_ = fun
end

function VideoView:startVideo()
    self:playVideo(self.videoPathList_[self.videoPathIndex_])
end

function VideoView:stopVideo()
    if self.videoPlayer_ and self.videoPlayer_.dispose then
        self.videoPlayer_:dispose()
    end

    local callBackfun_ = self.callBackfun_
    if callBackfun_ then
        callBackfun_()
    end

    --TODO CLOSE
    -- if self.danmuMark then
    --     self.danmuMark:removeEvents()
    -- end

    AlertManager:closeLayer(self)

end

--播放视频
function VideoView:playVideo(video, isEnd)
    print("video ",video)
    print("video ",video)
    if type(video) == "number" then
        local videoCfg = TabDataMgr:getData("Video",video)
        if videoCfg then
            video = videoCfg.path
        end
    end

    --TODO CLOSE
    -- if self.danmuMark then
    --     self.danmuMark:removeEvents()
    --     self.danmuMark:removeFromParent()
    --     self.danmuMark = nil
    -- end

    if not self.videoPlayer_ then
        -- self.videoPlayer_ = VlcPlayer:create({filePath = video,onVideoPlayComplete = handler(self.onVideoPlayComplete, self)});
        -- self.ui:addChild(self.videoPlayer_,999);
            -- self.videoPlayer_:play()
        
        self.videoPlayer_ = MovieScene:create({
            path = video,
            showSkip = true,
            autoFree = false,
            androidUseTextureView = false, --#self.videoPathList_ > 1,
            onVideoClick = function(...)
                if self.onVideoClick then 
                    return self:onVideoClick(...)
                end
                return false
            end,
            endCall = function(...)
                if self.onVideoPlayComplete then 
                    if self.isSkipComplete == true then
                        self:onVideoPlayComplete()
                    else
                        self:onVideoPlayComplete(...)
                    end
                end
            end
        })
    else
        self.videoPlayer_:setVisible(true)
        self.videoPlayer_:setFile(video)
        self.videoPlayer_:play(isEnd and self.isEndLoop)
    end

    --TODO CLOSE
    -- local danmuId = Utils:getDanmuId(EC_DanmuType.VIDEO,video)
    -- if danmuId then
    --     local param = {
    --         id = danmuId,
    --         offset = 60,
    --         danmuHeight = 580,
    --         autoRun = true,
    --         rowNum = 8
    --     }
    --     self.danmuMark = Utils:createDanmuMark(param)
    --     self.danmuMark:setZOrder(2)
    --     self.videoPlayer_:addChild(self.danmuMark)
    -- end

    dump(self:getPosition());
end

function VideoView:onVideoClick()
    if self.videoClickCallBackfun_ then
        return self.videoClickCallBackfun_(self.videoPathIndex_)
    end
    return true
end

function VideoView:onVideoPlayComplete(videoPlayer_, isSkip)
    if isSkip and not self.topLayer then
        self:stopVideo()
        if self.jumpCallBack then
            self.jumpCallBack()
        end
        return
    end

    if self.videoPathIndex_ < #self.videoPathList_ and self.specicalCompleteCallBack_ then
        self.specicalCompleteCallBack_()
    end

    self.videoPathIndex_ = self.videoPathIndex_ + 1
    if self.videoPathIndex_ > #self.videoPathList_ and not self.isEndLoop then
        self:stopVideo()
    else
        if self.videoPathIndex_ > #self.videoPathList_ then
            self.videoPathIndex_ = #self.videoPathList_;
        end

        if self.topLayer then
            self.topLayer:show();
            self:setIshowSkip(false)
        end
        self:playVideo(self.videoPathList_[self.videoPathIndex_], self.videoPathIndex_ >= #self.videoPathList_)
    end
end

function VideoView:setIshowShare(isShow)
    if self.videoPlayer_ and isShow then
        self.videoPlayer_:showShare();
    end
end

function VideoView:setIshowSkip(isShow)
    if self.videoPlayer_ then
        self.videoPlayer_:showSkip(isShow);
    end
end

function VideoView:addTopLayer(layer)
    if self.videoPlayer_ then
        self.videoPlayer_:addLayer(layer);
        self.topLayer = layer;
    end
end

function VideoView:addLoadingLayer(layer)
    if self.videoPlayer_ and self.videoPlayer_.addLoadingLayer then
        self.videoPlayer_:addLoadingLayer(layer);
    end
end

function VideoView:addCustomLayer(layer)
    if self.videoPlayer_ then
        self.videoPlayer_:addCustomLayer(layer);
    end
end

function VideoView:changeVideo(path)
    self.videoPlayer_:setFile(path);
    self.videoPlayer_:play(false)
    self:setIshowSkip(true)
end

function VideoView:removeUI()
    self.super.removeUI(self)
    TFAudio.resumeMusic();
end

function VideoView:registerEvents( )
    self.super.registerEvents(self)
    EventMgr:addEventListener(self,EV_TRAIT_COLLECTIONDID_CHANGE, handler(self.onTraitCollectionDidChange,self))
end

function VideoView:onTraitCollectionDidChange( )
    -- body
    if self.videoPlayer_ == nil then return end
    self.videoPlayer_:updateUIUserInterfaceStyle()
end

function  VideoView:bindJumpCustomFunction(jumpCallBack)
    self.jumpCallBack = jumpCallBack
end

return VideoView
