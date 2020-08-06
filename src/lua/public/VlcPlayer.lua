VlcPlayer = class('VlcPlayer',function()
	local panel = BaseLayer:create()
	return panel
end)

--[[
params = {
    ["filePath"]           	= ""
    ["onVideoPlayComplete"] = onVideoPlayComplete
}
]]

function VlcPlayer:ctor(params)
	self.filePath = params.filePath
	self.videoCfg = TabDataMgr and TabDataMgr:getData("Video") or {}
    self.onVideoPlayComplete = params.onVideoPlayComplete
    self.onVideoClick = params.onVideoClick
    self.onSkipClick = params.onSkipClick
    self.onVideoTimeChanged = params.onVideoTimeChanged
    self.viewSize = params.viewSize or GameConfig.WS
    self.forceVLC = params.forceVLC
    self.androidUseTextureView = params.androidUseTextureView

    if params.showSkip == nil then params.showSkip = true end
    self.isShowSkipBtn = params.showSkip or false
	self:init()
end

function VlcPlayer:getVideoSizeByCfg()
    local ret = { 1386, 640 }
	for k,v in pairs(self.videoCfg ) do
		if v.path == self.filePath then
			ret =  v.size
		end
    end

    local pDirector = CCDirector:sharedDirector();
    local frameSize = pDirector:getOpenGLView():getFrameSize();
    local baseSize = CCSize(1136 , 640);
    self.realSize = CCSize(math.ceil(frameSize.width * baseSize.height / frameSize.height) , baseSize.height);
    if self.realSize.width > 1386 and ret[1] >= 1386 then
        ret[1] = self.realSize.width
    end

    return ret;
end

function VlcPlayer:getVideShowType()
    for k,v in pairs(self.videoCfg ) do
        if v.path == self.filePath then
            return v.isFullScreen
        end
    end

    return false
end

function VlcPlayer:init()
    self:setContentSize(self.viewSize)
    -- self:setBackGroundColorType(1)
    -- self:setBackGroundColor(ccc3(0,0,0))
    -- self:setBackGroundColorOpacity(255)
    self:setTouchEnabled(true)

    local isFullScreen = self:getVideShowType()
    local videoSize = self:getVideoSizeByCfg()

    if not isFullScreen  then
        local width = self.viewSize.width
        local height =  self.viewSize.height --videoSize[2] * (self.viewSize.width / videoSize[1])
        self.width = videoSize[1] *  (self.viewSize.height / videoSize[2]) --width
        self.height = height
    else
        local width = self.viewSize.width
        local height =  videoSize[2] * (self.viewSize.width / videoSize[1])
        self.width = width
        self.height = height
        if videoSize[2] > self.viewSize.height then
            self.height = self.viewSize.height
            self.width  = videoSize[1] * (self.viewSize.height / videoSize[2])
        end
    end

    dump({self.filePath,videoSize,self.width,self.height,self.viewSize})

    self.video = nil
    local EventTag = TFWIDGET_COMPLETED
    -- if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
    --     EventTag    = TFVIDEO_COMPLETE
    --     self.video  = TFVideoPlayer:create()
    --     self.video:setSize(CCSizeMake(width,height))
    --     self.video:setFileName(self.filePath)
    --     --self.video:sendToBack()
    -- else
    --     EventTag    = TFWIDGET_COMPLETED

    if USE_NATIVE_VLC or not TFVideoPlayer.createWithVLC then
        if me.platform == "win32" then
            self.video  = VideoVLC:create(self.filePath,self.width,self.height)
            self.video:setSkipTime(0)
        elseif me.platform == "ios" then
            if self.forceVLC then
                if VideoVLC.getVersion then
                    self.video  = VideoVLC:createWithNative(self.filePath,self.width,self.height)
                    self.video:setSkipTime(0)
                    self.video:bringToTop()
                else
                    self.video  = VideoVLC:create(self.filePath,self.width,self.height)
                end
            else
                self.video  = VideoVLC:createWithNative(self.filePath,self.width,self.height)
                self.video:setSkipTime(0)
            end
        else
            self.video  = VideoVLC:create(self.filePath,self.width,self.height)
            self.video:setSkipTime(0)
        end
        EventTag    = TFWIDGET_COMPLETED
    else
        if self.androidUseTextureView and TFVideoPlayer.createWithTextureVLC then
            self.video  = TFVideoPlayer:createWithTextureVLC()
        else
            self.video  = TFVideoPlayer:createWithVLC()
        end
        self.video:setSize(ccs(self.width,self.height))
        self.video:setFileName(self.filePath)
        if self.forceVLC then
            self.video:bringToTop()
        else
            self.video:sendToBack()
        end
        EventTag    = TFVIDEO_COMPLETE

        function self.video:setFile(filePath, width, height)
            self:setFileName(filePath)
            --self:sendToBack()
            self:setSize(ccs(width, height))
        end

        local _play = self.video.play
        function self.video:play(loop)
            _play(self)
            self:setLoop(loop)
        end
    end

    self.video:addMEListener(EventTag, function(node)
        if self.onVideoPlayComplete then
            self.startTime = 0
            self.touchNum  = 0
            self.onVideoPlayComplete(node)
        end
    end)

    self.video:addMEListener(100001, function(node)
        if self.onVideoTimeChanged then
            self.onVideoTimeChanged()
        end
    end)

    --end

    self.video:setAnchorPoint(me.p(0.5,0.5))
    self.video:setPosition(ccp(self.viewSize.width / 2,self.viewSize.height / 2))

    self:addChild(self.video)

    if not self.isShowSkipBtn then return end

    -- if CC_TARGET_PLATFORM ~= CC_PLATFORM_IOS then
    self:initSkipBtn()
    self:addMEListener(TFWIDGET_CLICK, audioClickfun(function ( ... )
        print("点击视频 self.skipBtn.isShow ",self.skipBtn.isShow)

        local onVideoClick = self.onVideoClick

        local canSkip = true
        if onVideoClick then
            canSkip = onVideoClick()
        end

        if not self.skipBtn.isShow and canSkip then
            self:showSkipBtn()

            self.skipBtn:timeOut(function()
                self:hideSkipBtn()
            end,5)
        end
    end))
    -- else
    --     self.startTime = 0--os.clock()
    --     self.touchNum  = 0
    --     self:onTouch(function(event)

    --             if CC_TARGET_PLATFORM ~= CC_PLATFORM_IOS then
    --                 return
    --             end

    --             if event.name == "began" then
    --                 if self.startTime == 0 then
    --                     self.startTime = os.clock()
    --                 end

    --                 if self.startTime ~= 0 and os.clock() - self.startTime < 3 then
    --                     self.touchNum = self.touchNum + 1
    --                     dump("点击"..self.touchNum.."次")
    --                 end

    --                 if self.touchNum >= 3 then
    --                     if self.onVideoPlayComplete then
    --                         self.video:stop()
    --                         self.onVideoPlayComplete()
    --                     end
    --                 end

    --                 if os.clock() - self.startTime >= 3 then
    --                     self.startTime = os.clock()
    --                     self.touchNum  = 1
    --                     dump("点击"..self.touchNum.."次")
    --                 end
    --             end
    --         end)
    -- end

end

function VlcPlayer:initSkipBtn()
    self.skipBtn = TFImage:create("ui/dating/skipVideo.png")
    self.skipBtn.isShow = false
    self.skipBtn:setOpacity(0)
    self.skipBtn:Pos(GameConfig.WS.width - 100,50)
    self:addChild(self.skipBtn, 100)
    self.skipBtn:setScale(1.5)

    -- local size = self.skipBtn:getSize();
    -- self.skipBtn:setSize(ccs(size.width * 2,self.height * 2))

    self.skipBtn:onClick(function()
        if self.onVideoPlayComplete then
            self:showSkipBtn()
            self.onVideoPlayComplete(self, true)
            --self.onVideoPlayComplete = nil
            if self.onSkipClick then
                self.onSkipClick()
                --self.onSkipClick = nil
            end
        end
    end)
    self.skipBtn:Touchable(false)
end

function VlcPlayer:showSkipBtn()
    -- if os.clock() - self.startTime < 2 then
    --     return
    -- end

    local fadeInAc = {
        CCCallFunc:create(function()
                self.skipBtn.isShow = true
                self.skipBtn:Touchable(true)
            end),
        FadeIn:create(0.5)
    }
    self.skipBtn:runAction(CCSequence:create(fadeInAc))
end

function VlcPlayer:hideSkipBtn()
    local fadeOutAc = {
        CCCallFunc:create(function()
                self.skipBtn:Touchable(false)
            end),
        FadeOut:create(0.5),
        CCCallFunc:create(function()
                self.skipBtn.isShow = false
            end)
    }
    self.skipBtn:runAction(CCSequence:create(fadeOutAc))
end

function VlcPlayer:play(loop)
    self.startTime = os.clock();
    if self.video then
        if loop == nil then loop = false end
        self.video:play(loop)
	end
end

function VlcPlayer:setFile(filePath)
	if self.video then
		self.filePath = filePath
        dump(self.filePath)
        local isFullScreen = self:getVideShowType()
        local videoSize = self:getVideoSizeByCfg()
        dump(videoSize)

        if not isFullScreen  then
            local width = self.viewSize.width
            local height =  self.viewSize.height --videoSize[2] * (self.viewSize.width / videoSize[1])
            self.width = videoSize[1] *  (self.viewSize.height / videoSize[2]) --width
            self.height = height
        else
            local width = self.viewSize.width
            local height =  videoSize[2] * (self.viewSize.width / videoSize[1])
            self.width = width
            self.height = height
            if videoSize[2] > self.viewSize.height then
                self.height = self.viewSize.height
                self.width  = videoSize[1] * (self.viewSize.height / videoSize[2])
            end
        end
        dump({self.filePath,videoSize,self.width,self.height,self.viewSize})

        self.video:setFile(filePath, self.width, self.height)
	end
end

function VlcPlayer:pause()
    if self.video then
        self.video:pause()
    end
end

function VlcPlayer:resume()
    if self.video then
         self.video:resume()
    end
end

function VlcPlayer:showShare()
    if HeitaoSdk and CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID --[[and TFDeviceInfo:getCurAppVersion() == "3.00" --]]and not (HeitaoSdk.getplatformId() % 10000 == 101)  then
        return
    end

    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS --[[and TFDeviceInfo:getCurAppVersion() == "2.80"--]] then
        return;
    end

    if self.shareImg then
        return;
    end

    self.shareImg = TFImage:create("ui/common/btn_share.png")
    self.shareImg:Pos(-GameConfig.WS.width / 2 + 50, -GameConfig.WS.height / 2 + 50)
    self:addChild(self.shareImg, 999);
    self.shareImg:setTouchEnabled(true);
    self.shareImg:onClick(function()
            self.shareImg:setVisible(false);
            Utils:gameShare();
        end);
end

function VlcPlayer:showSkip(isShow)
    if self.skipBtn then
        self.skipBtn:setVisible(isShow);
    end
end

return VlcPlayer