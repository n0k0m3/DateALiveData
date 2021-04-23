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
    self:initSubTitle(self.filePath)

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
            self.video  = VideoVLC:create(self.filePath,self.width,self.height, handler(self.startSubTitleUpdate, self))
            self.video:setSkipTime(0)
        elseif me.platform == "ios" then
            if self.forceVLC then
                if VideoVLC.getVersion then
                    self.video  = VideoVLC:createWithNative(self.filePath,self.width,self.height, handler(self.startSubTitleUpdate, self))
                    self.video:setSkipTime(0)
                    self.video:bringToTop()
                else
                    self.video  = VideoVLC:create(self.filePath,self.width,self.height, handler(self.startSubTitleUpdate, self))
                end
            else
                self.video  = VideoVLC:createWithNative(self.filePath,self.width,self.height, handler(self.startSubTitleUpdate, self))
                self.video:setSkipTime(0)
            end
        else
            self.video  = VideoVLC:create(self.filePath,self.width,self.height, handler(self.startSubTitleUpdate, self))
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
        if self.filePath == "video/loginPart1.mp4" or self.filePath == "video/loginPart6.mp4" then
            local currentScene = Public:currentScene()
            if currentScene and currentScene.__cname == "LoginScene" then
                currentScene:loginVideoOver()
            end
        end
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
    self.skipBtn:setAnchorPoint(ccp(1 , 0.5))
    self.skipBtn.isShow = false
    self.skipBtn:setOpacity(0)
    self.skipBtn:Pos(GameConfig.WS.width,50)
    self:addChild(self.skipBtn, 100)
    self.skipBtn:setScale(1.5)

    -- local size = self.skipBtn:getSize();
    -- self.skipBtn:setSize(ccs(size.width * 2,self.height * 2))

    self.skipBtn:onClick(function()
        if self.filePath == "video/loginPart1.mp4" or self.filePath == "video/loginPart6.mp4" then
            local currentScene = Public:currentScene()
            if currentScene and currentScene.__cname == "LoginScene" then
                currentScene:loginVideoOver()
            end
        end
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

function VlcPlayer:getVideoLength( )
    if self.video and self.video:isPlaying() then
        return self.video:getMediaPlayerLength()
    end
    return 0
end

function VlcPlayer:getVideoTime( )
    if self.video and self.video:isPlaying() then
        return self.video:getMediaPlayerTime()
    end
    return 0
end

function VlcPlayer:setSubTitle( time, text)
    if self.subTitleLabel == nil then return end
    self.subTitleLabel:setText(text)
end

function VlcPlayer:initSubTitle( filePath )
    local function initLabel( )
        self.subTitleLabel = TFLabel:create()
        self.subTitleLabel:setFontName("font/MFLiHei_Noncommercial.ttf")
        self.subTitleLabel:setAnchorPoint(ccp(0.5,0.5))
        self.subTitleLabel:setFontSize(28)
        --self.subTitleLabel:setFontColor(color)
        self.subTitleLabel:setPosition(ccp(GameConfig.WS.width*0.5, 80)) 
        self:addChild(self.subTitleLabel,999999)
        self.subTitleLabel:setText("")
        self.subTitleLabel:enableStroke(ccc3(0, 0, 0), 1)

        if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
            self.videoNameLabel = TFLabel:create()
            self.videoNameLabel:setFontName("font/fangzheng_zhunyuan.ttf")
            self.videoNameLabel:setFontSize(20)
            self.videoNameLabel:setAnchorPoint(ccp(1, 0.5))
            self.videoNameLabel:setPosition(ccp(GameConfig.WS.width, 10)) 
            self:addChild(self.videoNameLabel,999999)
            self.videoNameLabel:setText(filePath)
            self.videoNameLabel:enableStroke(ccc3(0, 0, 0), 1)
        end
    end
    initLabel()

    local function initInfo( )
        self.subTitle = {}
        self.subTitleWait = {}
        self.subTitlePlaying = {}
        self.subTitleEnd = {}

        local idx = filePath:match(".+()%.%w+$") --获取文件后缀
        if idx then filePath = filePath:sub(1, idx - 1) end
        local split = string.split(filePath, "/")
        local subTitleCfg = TFGlobalUtils:requireGlobalFile("lua.table.Video_" ..split[#split])
        for _,_cfg in ipairs(subTitleCfg) do
            local begin_split1 = string.split(_cfg.beginTime, ",")
            local begin_split2 = string.split(begin_split1[1], ":")
            local begin_hour = tonumber(begin_split2[1])
            local begin_mintue  = tonumber(begin_split2[2])
            local begin_scend  = tonumber(begin_split2[3])
            local begin_milli = tonumber(begin_split1[2])
            local beginTime = (begin_hour*60*60 + begin_mintue*60 + begin_scend)*1000 + begin_milli

            local end_split1 = string.split(_cfg.endTime, ",")
            local end_split2 = string.split(end_split1[1], ":")
            local end_hour = tonumber(end_split2[1])
            local end_mintue  = tonumber(end_split2[2])
            local end_scend  = tonumber(end_split2[3])
            local end_milli = tonumber(end_split1[2])
            local endTime = (end_hour*60*60 + end_mintue*60 + end_scend)*1000 + end_milli
            table.insert(self.subTitle, {content = _cfg.content, beginTime = beginTime, endTime = endTime})
        end
    end
    initInfo()
end

function VlcPlayer:triggerBeginSubTitle( info )
    self.subTitleLabel:setText(info.content)
    self.subTitleLabel:stopAllActions()
    self.subTitleLabel:setOpacity(0)
    self.subTitleLabel:runAction(CCFadeIn:create(0.3))
end

function VlcPlayer:triggerEndSubTitle( info )
    self.subTitleLabel:stopAllActions()
    self.subTitleLabel:setOpacity(255)
    self.subTitleLabel:runAction(CCFadeOut:create(0.3))
end

function VlcPlayer:startSubTitleUpdate( vedioTime, videoLength )
    if self.subTitle == nil then return end

    --查找需要显示的字幕
    for _idx,_info in ipairs(self.subTitle) do
        if _info.beginTime <= vedioTime and  _info.endTime > vedioTime then
            table.insert(self.subTitleWait, _info)
            table.remove(self.subTitle, _idx)
            break
        end
    end

    for _idx,_info in ipairs(self.subTitleWait) do
        self:triggerBeginSubTitle(_info)
        table.insert(self.subTitlePlaying, _info)
        table.remove(self.subTitleWait, _idx)
        break
    end

    --查找隐藏的字幕
    for _idx,_info in ipairs(self.subTitlePlaying) do
        if _info.beginTime < vedioTime and _info.endTime <= vedioTime then
            self:triggerEndSubTitle( _info )
            table.insert(self.subTitleEnd, _info)
            table.remove(self.subTitlePlaying, _idx)
        end
    end
end 

return VlcPlayer