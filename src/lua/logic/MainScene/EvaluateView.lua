local EvaluateView = class("EvaluateView", BaseLayer)


function EvaluateView:ctor()
    self.super.ctor(self)
    self:init("lua.uiconfig.MainScene.EvaluateView")
end


function EvaluateView:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	self.Button_cancle = TFDirector:getChildByPath(self.ui,"Button_cancle")
	self.Image_text = TFDirector:getChildByPath(self.ui,"Image_text")
	self.Button_ok = TFDirector:getChildByPath(self.ui,"Button_ok")
	self.Spine_happy = TFDirector:getChildByPath(self.ui,"Spine_happy")
	self:showPopAnim(true)

	self:initUILogic()

end

function EvaluateView:initUILogic()

	if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
		self.Image_text:setTexture("ui/Evaluate/text_pl.png")
		self.Button_ok:setTextureNormal("ui/Evaluate/btn_ok.png")
	elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
		self.Image_text:setTexture("ui/Evaluate/text_pl1.png")
		self.Button_ok:setTextureNormal("ui/Evaluate/btn_ok1.png")
	end

	CommonManager:setStarEvaluateFlage(false)
	self.Spine_happy:play("happy1",false)
	self.Spine_happy:addMEListener(TFARMATURE_COMPLETE,function()
		self.Spine_happy:removeMEListener(TFARMATURE_COMPLETE)
		self:timeOut(function()
	    	self.Spine_happy:play("happy2",true)
	    end, 0)
    end) 

end

function EvaluateView:registerEvents()
	self.Button_cancle:onClick(function()
		self:saveRecord()
    end)

	self.Button_ok:onClick(function()
		self:openEvaluate()
    end)

end

function EvaluateView:openEvaluate()

	if HeitaoSdk then
		if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
			local result = HeitaoSdk.isFunctionSupported("inviteComments")
			if result then
				self:saveRecord()
		    else
		    	AlertManager:closeLayer(self)
			end
		else
			self:saveRecord();
			local url = "https://www.taptap.com/app/79899/review"
    		TFDeviceInfo:openUrl(url);
		end
	else
		self:saveRecord()
	end
	
end

function EvaluateView:saveRecord()
	
	local playerId = MainPlayer:getPlayerId()
    CCUserDefault:sharedUserDefault():setBoolForKey(playerId.."Evaluate",true)
    CCUserDefault:sharedUserDefault():flush()

    AlertManager:closeLayer(self)
end

return EvaluateView
