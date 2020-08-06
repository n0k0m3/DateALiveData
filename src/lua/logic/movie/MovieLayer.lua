
local MovieLayer = class("MovieLayer", function(...)
	local layer = TFPanel:create()
	return layer
end)

function MovieLayer:ctor(params)
    Utils.isInMovieScene = true
    params = params or { }
    params.path = params.path or ""
    params.endCall = params.endCall or (function() end)
    params.onVideoClick = params.onVideoClick or (function() return true end)
    params.onSkipClick = params.onSkipClick or (function() end)
    if params.showSkip == nil then params.showSkip = true end
    if params.autoFree == nil then params.autoFree = true end

    self.params = params
    self.scene = params.scene

    if me.platform == 'android' and self.scene and not USE_NATIVE_VLC then         
        self.scene:setOpacity(0)
    end

    local videoSize = { 1386, 640 }
    local width = GameConfig.WS.width
    local height = videoSize[2] * (width / videoSize[1])
    self.width = width
    self.height = height

    if videoSize[2] > GameConfig.WS.height then
        self.height = GameConfig.WS.height
        self.width  = videoSize[1] * (GameConfig.WS.height / videoSize[2])
    end
    self.video = VlcPlayer:create({
        filePath = params.path,
        showSkip = params.showSkip,
        onVideoClick = params.onVideoClick,
        onSkipClick = params.onSkipClick,
        androidUseTextureView = params.androidUseTextureView,
        onVideoTimeChanged = function()
            self:onTimeChanged()
        end,
        onVideoPlayComplete = function(...)
            self:onCompleted(...)
        end
    })
    self.video:setAnchorPoint(me.p(0.5, 0.5))
    self.video:setPosition(ccp(GameConfig.WS.width / 2,GameConfig.WS.height / 2))
    self:addChild(self.video)
    self.video:play()
end

function MovieLayer:play(isLoop)
    self.video:play(isLoop)
end

function MovieLayer:stop()
    self.video:stop()
end

function MovieLayer:pause()
    self.video:pause()
end

function MovieLayer:showShare()
    self.video:showShare();
end

function MovieLayer:onTimeChanged()
    -- print_("MovieLayer:onTimeChanged")
    self.scene:setOpacity(255)
end

function MovieLayer:onCompleted(...)
    print_("MovieLayer:onCompleted")
    if self.params.endCall then
        self.params.endCall(...)
    end
    if self.params and self.params.autoFree then
        self:dispose()
    end
end

function MovieLayer:registerEvents()

end

function MovieLayer:removeEvents()

end

function MovieLayer:onExit()
    Utils.isInMovieScene = false
end

function MovieLayer:dispose()
    Utils.isInMovieScene = false
    DelayCall(function()
        me.Director:setTopScene(nil)
    end)
end

return MovieLayer