local LoginScene = class("LoginScene", BaseScene)
local TFClientUpdate =  TFClientResourceUpdate:GetClientResourceUpdate()
function LoginScene:ctor(data)
	self.super.ctor(self,data)

	local layer = nil

	-- if HeitaoSdk then
	-- 	layer = require("lua.logic.login.LoginNoticePage"):new()
	-- else
	-- 	layer = require("lua.logic.login.LoginLayer"):new()
	-- end
	Bugly:SetUserId("enter game:"..TFClientUpdate:getCurVersion());
	-- layer = require("lua.logic.login.LoginLayer"):new(data)
 --    self:addLayer(layer)
 	self.data = data;
 	if not CUtils.getVersion or CUtils.getVersion() ~= "1.0.0" then
		me.Director:endToLua();
	end
end


function LoginScene:onEnter(re)
	self.super.onEnter(self)
	if not self.videoView then
		AlertManager:closeAll();
		TFAudio.stopMusic()
		--TFAudio.playMusic("sound/enter_wanyouli_bgm.mp3", true)

		self:showVideoView();
		Utils.isInMovieScene = false
	end
end

function LoginScene:showVideoView(re)
	local OldValue = USE_NATIVE_VLC
    if me.platform == 'android' then
        USE_NATIVE_VLC = true
	end
	
	local videoPth1, videoPth2
	if FunctionDataMgr:isMoJingLoginUI() then
		videoPth1 = "video/loginPart1.mp4"
		videoPth2 = "video/loginPart2.mp4"
	else
		videoPth1 = "video/loginPart1.mp4"
		videoPth2 = "video/loginPart2.mp4"
	end
	

	if self.videoView or re then
		
		if self.videoView then
			self.videoView:removeFromParent();
		end

		local currentScene = Public:currentScene()
	    local videoView = requireNew("lua.logic.common.VideoView"):new(videoPth2)
	    videoView:setAnchorPoint(ccp(0.5, 0.5))
	    videoView:setPosition(ccp((GameConfig.WS.width - videoView:getSize().width)/2 + videoView:getSize().width / 2, (GameConfig.WS.height - videoView:getSize().height)/2 + videoView:getSize().height / 2))
	    currentScene:addChild(videoView)
	    videoView:setEndLoop(true)
	    videoView:setIshowSkip(false)
	    USE_NATIVE_VLC = OldValue

		local layer = require("lua.logic.login.LoginLayer"):new(self.data)
		videoView:addTopLayer(layer)
		layer:setPosition(ccp(-GameConfig.WS.width / 2,-GameConfig.WS.height / 2))
	    self.videoView = videoView;
	    self.layer = layer
	else
		local currentScene = Public:currentScene()
	    local videoView = requireNew("lua.logic.common.VideoView"):new(videoPth1,videoPth2)
	    videoView:setAnchorPoint(ccp(0.5, 0.5))
	    videoView:setPosition(ccp((GameConfig.WS.width - videoView:getSize().width)/2 + videoView:getSize().width / 2, (GameConfig.WS.height - videoView:getSize().height)/2 + videoView:getSize().height / 2))
	    currentScene:addChild(videoView)
	    videoView:setSkipComplete(true)
	    videoView:setEndLoop(true)
	    videoView:setIshowSkip(true)
	    videoView:bindSpecicalCompleteCallBack(function()
	    	videoView:setSkipComplete(false)
	    	videoView:setIshowSkip(false)
    		Utils:sendHttpLog("cartoon_finish_J")
    		local layer = require("lua.logic.login.LoginLayer"):new(self.data)
			videoView:addTopLayer(layer)
			layer:setPosition(ccp(-GameConfig.WS.width / 2,-GameConfig.WS.height / 2))
			self.layer = layer
	    end)
	    USE_NATIVE_VLC = OldValue
	    TFAudio.resumeMusic()

	    self.videoView = videoView
	end
end

function LoginScene:changeVideo(path)
	self.videoView:changeVideo(path)
	self.layer:hide();
end

function LoginScene:removeVideoView()
	if self.videoView then
		self.videoView:removeFromParent();
		self.videoView = nil;
	end
end

function LoginScene:addLoadingLayer(layer)
	if self.videoView then
		self.videoView:addLoadingLayer(layer,999)
	end
end

function LoginScene:addCustomLayer(layer)
	if self.videoView then
		self.videoView:addCustomLayer(layer,999)
	end
end


function LoginScene:onExit()
	self.super.onExit(self)
	Utils.isInMovieScene = false
end

function LoginScene:onKeyBack()
    if self.layer then
    	self.layer:onKeyBack()
    end
end

return LoginScene;
