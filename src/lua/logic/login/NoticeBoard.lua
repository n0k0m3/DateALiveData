local NoticeBoard = class("NoticeBoard", BaseLayer)

function NoticeBoard:ctor(data)
    self.super.ctor(self,data)
    self.createTime = os.clock();
    self:init("lua.uiconfig.loginScene.noticeBoard")
end


function NoticeBoard:setUrl(url,noAppend,attach)
	local groupid 	= math.floor(HeitaoSdk.getplatformId() / 10000);
	local pfid 		= HeitaoSdk.getplatformId() % 10000
	self.url = url;
	if not noAppend then
		self.url = url.."?groupid="..groupid.."&pfid="..pfid;
	end

	if attach then
		self.url = self.url.."&"..attach
	end
end

function NoticeBoard:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui;
	self.panel = TFDirector:getChildByPath(ui,"Panel_webView")
	self.closeBtn = TFDirector:getChildByPath(ui,"Button_close"):hide();
	self.bg = TFDirector:getChildByPath(ui,"Image_bg"):hide();
	self.viewDi = TFDirector:getChildByPath(ui,"Image_noticeBoard_1"):hide();

	self.redirectUrl = "http://api-en.datealive.com/yhdzz/special/1"
	TFWebView.AddRedirectUrl(self.redirectUrl)
	TFDirector:addMEGlobalListener("TFDeviceInfo.NativeCall",function(event)
			local _type = "OverrideUrlLoading";
			if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
				_type = "Not OverrideUrlLoading"
			end
			dump(event.data) 
			-- if (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID and event.data[1].type == "Not OverrideUrlLoading" and event.data[1].result ~= self.redirectUrl ) or
			--  (CC_TARGET_PLATFORM == CC_PLATFORM_IOS and  event.data[1].type == _type and event.data[1].result ~= self.redirectUrl) then

			-- 	-- local temp = "http://smi.datealive.com/yhdzz/gofun/34";
			-- 	-- local ret = string.find(temp, "gofun/");
			-- 	-- local temp2 = string.sub(temp,1,ret-1);
			-- 	-- local url = event.data[1].result
			-- 	-- local s, e = string.find(url, "gofun/")
		
			-- 	-- if s then
			-- 	-- 	local _u = string.sub(url,1,s-1);
			-- 	-- 	if _u == temp2 then
			-- 	-- 		if e then
			-- 	-- 			local funid = tonumber(string.sub(url, e + 1))
			-- 	-- 			FunctionDataMgr:enterByFuncId(funid)
			-- 	-- 		end
			-- 	-- 		TFWebView.close()
			-- 	-- 		AlertManager:closeLayer(self)
			-- 	-- 		return
			-- 	-- 	end
			-- 	-- end
			-- end
			local url = event.data[1].result;
			local funcID,noTipsToday,isClose;
			local pStart,pEnd = string.find(url,"gofun/");
			local pramStart,pramEnd = string.find(url,"?");
			isClose = string.find(url,"closewebview");

			if pStart and pramStart then  			--有跳转和今日不再提示
				funcID = string.sub(url,pEnd + 1,pramStart - 1);
				noTipsToday = string.sub(url,pramStart + 1);
			elseif pStart and not pramStart then  	--有跳转没有今日不再提示
				funcID = string.sub(url,pEnd + 1);
			elseif not pStart and pramStart then	--没跳转有今日不再提示
				noTipsToday = string.sub(url,pramStart + 1);
			end
			dump({funcID,noTipsToday,isClose})

			-- 设置今日不在提示  目前只有206类型广告
			if noTipsToday and self.isNoTipsToday then
				noTipsToday = string.sub(noTipsToday,string.find(noTipsToday,"=") + 1);
				FunctionDataMgr:saveType206AdvertisementState(tonumber(noTipsToday));
			end

			dump({funcID,noTipsToday,isClose})
			
			--跳转和关闭
			if funcID then
				FunctionDataMgr:enterByFuncId(tonumber(funcID));
				TFWebView.close();
				AlertManager:closeLayer(self);
				return;
			end

			if isClose then
				TFWebView.close()
				AlertManager:closeLayer(self);
			end
			
			if event.data[1].type == _type and event.data[1].result == self.redirectUrl then
				TFWebView.close()
				AlertManager:closeLayer(self);
			end
		end)

	local skillEff = nil;
    skillEff = SkeletonAnimation:create("effect/newLoading/effects_loading2")
    skillEff:setPosition(ccp(GameConfig.WS.width/2, GameConfig.WS.height/2))
    skillEff:setAnimationFps(GameConfig.ANIM_FPS)
    skillEff:playByIndex(0, -1, -1, 1)
    self:addChild(skillEff,2)

	-- self.ui:setTouchEnabled(true);
	-- if CC_PLATFORM_IOS == CC_TARGET_PLATFORM then
	-- 	self.viewDi:show();
	-- 	self.closeBtn:show();
	-- 	self.closeBtn:setPositionY(self.closeBtn:getPositionY() - 1)
	-- 	self.closeBtn:onClick(function()
	-- 			if os.clock() - self.createTime <= 2 then
	-- 				return
	-- 			end
	-- 	 		TFWebView.close();
	-- 	 		AlertManager:closeLayer(self);
	-- 	 	end)
	-- end
end

function NoticeBoard:setIsRecordNoTipsToday(noTipsToday)
	self.isNoTipsToday = noTipsToday;
end

function NoticeBoard:setCloseCallback(call)
	self.closeCallback = call
end

function NoticeBoard:removeUI()
	self.super.removeUI(self)

	if self.closeCallback then
		self.closeCallback();
	end
end

function NoticeBoard:setViewSize(size)
	if size then
		self.size = size
	else
		self.size = clone(GameConfig.WS)
	end
end

function NoticeBoard:show()
	local pos = self.panel:getParent():convertToWorldSpace(self.panel:getPosition());
	local size = self.size or self.panel:getSize();

	-- local y = 0
	-- if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
	-- 	y = 87
	-- 	size.height = size.height - y
	-- end

	TFWebView.showWebView(self.url, 0, 0, size.width, size.height)
end

return NoticeBoard;