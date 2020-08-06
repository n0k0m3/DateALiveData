
local DefaultLayer = class("DefaultLayer", function(...)
	local layer = TFPanel:create()
	return layer
end)


local displayResList = require('default.defultdisplay')

function DefaultLayer:ctor(data)

	if not CUtils.getVersion or CUtils.getVersion() ~= "1.0.0" then
		me.Director:endToLua();
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
	
	 --删除小包配置文件
	if CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
		local uName = "src/lua/table/PackBranch.lua"
	 	if TFFileUtil:existFile(uName) then
	 		local fullpath = me.FileUtils:fullPathForFilename(uName);
	 		if not string.find(fullpath,"assets") then
	 			me.FileUtils:removeFile(fullpath);
	 		end
	 	end
	 end

	Utils:sendHttpLog("icon_C")
	local __path = "video/shanpin.mp4";
	if not TFFileUtil:existFile(__path) then
		TimeOut(function()
				self:enterGame();
			end,0)
		return
	end

	TimeOut(function()
			MovieScene:create({
			path = __path,
			showSkip = false,
			endCall = function() 
				self:enterGame()
			end
		})
		end,0);

	do return end

	-- self.picNum = 0
	-- for k,display in pairs(displayResList) do
	-- 	-- print("display: ", display)

	-- 	self.picNum = self.picNum + 1
	-- end

	-- self.picIndex = 1
	-- -- print("self.picNum = ", self.picNum )

	-- if self.picNum < 1 then
	-- 	-- print("没有默认图片， 直接进入游戏")
	-- 	local function delayToGame()
	--     	TFDirector:removeTimer(self.timer)
	--         self.timer = nil

	--         self:enterGame()
	--     end
	--     self.timer = TFDirector:addTimer(100, -1, nil, delayToGame)
	-- 	return
	-- end

 --    self:changeImage()

 --    local function delayToAction()
 --    	TFDirector:removeTimer(self.timer)
 --        self.timer = nil
 --        self:startAction()
 --  --       local effectParticle = TFParticle:create("ui/logo/logoyinghua/Plist/sakura1.plist")
	-- 	-- self:addChild(effectParticle)
 --    end
 --    self.timer = TFDirector:addTimer(500, -1, nil, delayToAction)

	--  local function playVideo()
	--  	local videoSize = {1386,640};
	--     local width = GameConfig.WS.width;
	--     local height = videoSize[2] * (width / videoSize[1]);
	--     self.width = width;
	--     self.height = height;

	--     if videoSize[2] > GameConfig.WS.height then
	--         self.height = GameConfig.WS.height;
	--         self.width  = videoSize[1] * (GameConfig.WS.height / videoSize[2]);
	-- 	end
	-- 	if USE_NATIVE_VLC then 
	-- 		self.video  =  VideoVLC:create("video/shanpin.mp4",self.width,self.height);
	-- 		self.video:addMEListener(TFWIDGET_COMPLETED, function(node)
	-- 			self:enterGame();
	-- 		end)
	-- 	else 
	-- 		self.video = VlcPlayer:create({filePath = "video/shanpin.mp4", showSkip = false, onVideoPlayComplete = function(node)
	-- 			self:enterGame();
	-- 		end})
	-- 	end
	-- 	self.video:setAnchorPoint(me.p(0.5,0.5))
	--     self.video:setPosition(ccp(GameConfig.WS.width / 2,GameConfig.WS.height / 2));
	--     self:addChild(self.video);
	--     self.video:play();
	-- end

	-- playVideo()
end



function DefaultLayer:removeUI()

end

function DefaultLayer:registerEvents()

end

function DefaultLayer:removeEvents()
	TFDirector:removeTimer(self.timer)
    self.timer = nil
end

function DefaultLayer:changeImage()

	if self.showImage then
		self.showImage:removeFromParent()
		self.showImage = nil
	end

	-- print("显示图片 = ", displayResList[self.picIndex].name)

	local image = TFImage:create()

    image:setTexture(displayResList[self.picIndex].name)
    image:setAnchorPoint(ccp(0.5, 0.5))
    self:addChild(image)

    local pDirector = CCDirector:sharedDirector()


    -- local frameSize = pDirector:getOpenGLView():getFrameSize()
    local frameSize = GameConfig.WS--pDirector:getOpenGLView():getFrameSize()
    image:setPosition(ccp(frameSize.width/2, frameSize.height/2))

    local imageSize  	= image:getSize()
    local imageWidth 	= imageSize.width
    local imageHeight 	= imageSize.height

    --image:setScaleX(frameSize.width/imageWidth)
    --image:setScaleY(frameSize.height/imageHeight)


    -- print("frameSize = ", frameSize)
    -- print("imageWidth = ", imageWidth)
    -- print("imageHeight = ", imageHeight)
    --
    self.showImage = image
end

-- 开始
function DefaultLayer:startAction()
	function fadeOut()
		-- print("imageAction")
		local tween =
	    {
	        target = self.showImage,

	        {
            	duration = 1,
            	alpha 	 = 0,
	    	},

	        {
		        duration = 0,
	            onComplete = function ()
		            TFDirector:killAllTween()
	                -- print("step action complete")
	                self.picIndex = self.picIndex + 1
	                -- print("self.picIndex = ", self.picIndex)
	                if self.picIndex > self.picNum then
	                	-- print("显示完成，准备进入游戏")
	                	self:enterGame();
	                	--self:showLogo()
	                else
	                	-- print("开始下一场图片")
	                	self:changeImage()
	                	self:startAction()
	                end
	            end,
	        }

	    }
	    TFDirector:toTween(tween)
	end

	-- self:enterGame()

	local function fadeInAndOut()
		local tween =
	    {
	        target = self.showImage,

	        {
	         	ease = {type=TFEaseType.EASE_IN, rate=5}, --由慢到快
            	duration = 1,
            	alpha 	 = 1,
	    	},

	        {
            	duration = 1,
            	alpha 	 = 0,
	    	},

	        {
		        duration = 0,
	            onComplete = function ()
		            TFDirector:killAllTween()
	                self.picIndex = self.picIndex + 1
	                if self.picIndex > self.picNum then
	                	-- print("显示完成，准备进入游戏")
	                	self:enterGame();
	                	--self:showLogo()
	                else
	                	-- print("开始下一场图片")
	                	self:changeImage()
	                	self:startAction()
	                end
	            end,
	        }

	    }
	    TFDirector:toTween(tween)
	end

	if self.picIndex > 1 then
		self.showImage:setAlpha(0)
		fadeInAndOut()
	else
		fadeOut()
	end

end

function DefaultLayer:showLogo()
	local logoAni = SkeletonAnimation:create("ui/logo/logoAni/logo");
	logoAni:setPosition(ccp(GameConfig.WS.width / 2,GameConfig.WS.height / 2));
	logoAni:playByIndex(0, -1, -1, 0)
	self:addChild(logoAni)


	local timer
	local function delayToAction()
    	TFDirector:removeTimer(timer)
        timer = nil
        self:enterGame()
    end
    timer = TFDirector:addTimer(3500, -1, nil, delayToAction)
end

function DefaultLayer:enterGame()
	if TFClientObbDownload and TFPlugins.isUseObbDown then
		if TFClientObbDownload:GetInstance():CheckDownloadObb("http://dx.pic.infinite.tw/mhqx/twcs/ios/") then
    		local ObbDownlaodLayer = require("lua.logic.login.ObbDownloadLayer")
    		AlertManager:changeScene(ObbDownlaodLayer:scene())
    		return
    	end
	end

	if TFClientResourceUpdate == nil then
        local UpdateLayer   = require("lua.logic.login.UpdateLayer")
        AlertManager:changeScene(UpdateLayer:scene())
    else
        local UpdateLayer   = require("lua.logic.login.UpdateLayer_new")
        AlertManager:changeScene(UpdateLayer:scene())
    end
end

return DefaultLayer