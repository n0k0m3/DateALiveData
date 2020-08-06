local LogoLayer = class("LogoLayer", function(...)
	local layer = TFPanel:create()
	return layer
end)

function LogoLayer:ctor(data)

	if CC_TARGET_PLATFORM ~= CC_PLATFORM_WIN32 and HeitaoSdk then
	    HeitaoSdk.disableDeviceSleep(true)
	end

	--删除热更起始版本设置文件
	if CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
		local uName = "src/TFFramework/net/TFClientUpdate.lua"
	 	if TFFileUtil:existFile(uName) then
	 		local fullpath = me.FileUtils:fullPathForFilename(uName);
	 		if not string.find(fullpath,"assets") then
	 			me.FileUtils:removeFile(fullpath);
	 		end
	 	end
	 end
	
    self:showLogo();
end

function LogoLayer:removeUI()
	self.super.removeUI(self)
end

function LogoLayer:showLogo()
	local vedioPath,_bool
	if FunctionDataMgr:isOneYearLoginUI() then
		vedioPath = "video/haiwangxingopenpv.MP4"
		_bool = false
	else
		vedioPath = "video/openpv.mp4"
		_bool = true
	end
	local isPlay = CCUserDefault:sharedUserDefault():getBoolForKey("isPlayOpenVideoNew");
	local isPlayOnYearVedio = CCUserDefault:sharedUserDefault():getBoolForKey("isPlayOpenOneYearVideoNew");

	local function playVedio()
		Utils:sendHttpLog("first_page_H")
		MovieScene:create({
			path = vedioPath,
			showSkip = _bool,
			endCall = function() 
				Utils:sendHttpLog("jump_over_I")
				self:enterGame()
			end
		})
	end

 	if not isPlay then
		playVedio()
		CCUserDefault:sharedUserDefault():setBoolForKey("isPlayOpenVideoNew",true);
	elseif not isPlayOnYearVedio then
		playVedio()
		CCUserDefault:sharedUserDefault():setBoolForKey("isPlayOpenOneYearVideoNew",true);
	else 
		TimeOut(function()
				self:enterGame()
			end,0)
	end
end

function LogoLayer:enterGame()
	AlertManager:changeScene(SceneType.LOGIN)
end

return LogoLayer;
