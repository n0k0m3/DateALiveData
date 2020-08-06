require('TFFramework.net.TFClientUpdate')
local TFClientUpdate =  TFClientResourceUpdate:GetClientResourceUpdate()

local LoginLayer = class("LoginLayer", BaseLayer)

function LoginLayer:ctor(data)
    self.super.ctor(self,data)
    self.isShowLoingBoard = data;
    self.isEnter = false;
    EventMgr:addEventListener(self, EV_LOGIN_UPDATESERVERNAME, handler(self.updateServerName, self))

	if FunctionDataMgr:isOneYearLoginUI() then
		self:init("lua.uiconfig.loginScene.oneYearloginLayer")
	else
		self:init("lua.uiconfig.loginScene.loginLayerNew1")
	end
end

function LoginLayer:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	LoginLayer.ui = ui


	self.continue = TFDirector:getChildByPath(ui,"continue");
	self.continue:setTextById(800086)
	local tween =
	    {
	        target = self.continue,
	        repeated = -1,
	        {
            	duration = 1,
            	alpha 	 = 0,
	    	},

	        {
            	duration = 1,
            	alpha 	 = 1,
	    	},
	    }
	TFDirector:toTween(tween)

	self.loginBoard = TFDirector:getChildByPath(ui,"loginBoard");
	self.loginBoard:setVisible(false);

	self.versionLabel = TFDirector:getChildByPath(ui,"version")
	self.versionLabel:setString("Ver:"..(TFClientUpdate:getCurVersion()));

	self.apkVersionLabel = TFDirector:getChildByPath(ui,"label_apkVersion")
    local apkVersion = TFDeviceInfo:getCurAppVersion() 
    if apkVersion then
        self.apkVersionLabel:show()
        self.apkVersionLabel:setText("appVer:" .. apkVersion)
    end 

	self.touchLayer = TFDirector:getChildByPath(ui,"backLayer");
	self.touchLayer:setTouchEnabled(true);
	self.touchLayer.logic = self;
	self.touchLayer:addMEListener(TFWIDGET_CLICK, audioClickfun(self.enterNextPage))

	self.chooseImge = {}
	for i=1,3 do
		local Image_shurudi  = TFDirector:getChildByPath(ui,"Image_shurudi"..i)
		self.chooseImge[i]  = TFDirector:getChildByPath(Image_shurudi,"Image_choose")
	end
	
	self.accountInput  = TFDirector:getChildByPath(ui,"account_input");
	self.passwordInput = TFDirector:getChildByPath(ui,"password_input");
	self.codeInput 	   = TFDirector:getChildByPath(ui,"code_input");
	self.Button_closeLogin = TFDirector:getChildByPath(ui,"Button_closeLogin");

	self.passwordInput:setPlaceHolder(TextDataMgr:getText(800087));
	self.passwordInput:setText("");
	self.accountInput:setPlaceHolder(TextDataMgr:getText(800087));
	self.codeInput:setPlaceHolder(TextDataMgr:getText(800088));

	self.loginBtn = TFDirector:getChildByPath(ui,"Button_login");
	self.actBtn   = TFDirector:getChildByPath(ui,"Button_activation");
	self.loginBtn:addMEListener(TFWIDGET_CLICK,audioClickfun(function ( ... )
		self:loginBtnCallback();
	end))
	self.actBtn:addMEListener(TFWIDGET_CLICK,audioClickfun(function ( ... )
		self:loginBtnCallback();
	end))

	self.accountBtn = TFDirector:getChildByPath(ui,"TextButton_account");
	self.accountBtnPosX = self.accountBtn:getPositionX()
	self.accountBtn:addMEListener(TFWIDGET_CLICK,audioClickfun(function ()
			if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
				self:showLoingBoard()
			end
		end));


	self.cleanUpBtn = TFDirector:getChildByPath(ui,"Button_cleanup");
	self.cleanUpBtn:addMEListener(TFWIDGET_CLICK,audioClickfun(function ()
		--Utils:openView("login.CleanUpView")
		local fullModuleName = string.format("lua.logic.%s", "login.CleanUpView")
	    local view = requireNew(fullModuleName):new()
	    self:addLayer(view,998)
	    self.cleanUpView = view
	end));

	self.thanksBtn = TFDirector:getChildByPath(ui,"TextButton_");
	self.thanksBtn:hide()
	self.thanksBtn:addMEListener(TFWIDGET_CLICK,audioClickfun(function ()

			local currentScene = Public:currentScene();
			--currentScene:removeVideoView();

			TFAudio.pauseMusic();

			if CC_PLATFORM_IOS == CC_TARGET_PLATFORM then
				currentScene:changeVideo("video/thanks.mp4");
			else
				MovieScene:create({
					path = "video/thanks.mp4",
					showSkip = true,
					endCall = function() 
						TFAudio.resumeMusic()
						TimeOut(function()
								currentScene:showVideoView(true);
							end,0)
					end
				})
			end
		end));

	self.Button_play = TFDirector:getChildByPath(ui,"Button_play");
	self.Button_playPosX = self.Button_play:getPositionX()
	local vedioPath
	if FunctionDataMgr:isOneYearLoginUI() then
		vedioPath = "video/haiwangxingopenpv.MP4"
	else
		vedioPath = "video/openpv.mp4"
	end
	self.Button_play:addMEListener(TFWIDGET_CLICK,audioClickfun(function ()
		local currentScene = Public:currentScene();
		TFAudio.pauseMusic();
		if CC_PLATFORM_IOS == CC_TARGET_PLATFORM then
			currentScene:changeVideo(vedioPath);
		else
			MovieScene:create({
				path = vedioPath,
				showSkip = true,
				endCall = function()
					TFAudio.resumeMusic()
					TimeOut(function()
						currentScene:showVideoView(true);
					end,0)
				end
			})
		end
	end));

    self.Panel_serverList = TFDirector:getChildByPath(ui, "Panel_serverList")
    self.Panel_serverList:setVisible(GameConfig.Debug)
    self.Label_serverName = TFDirector:getChildByPath(self.Panel_serverList, "Label_serverName")

    self.gameServerList = TFDirector:getChildByPath(ui, "game_serverList")
    self.gameServerList:setVisible(false)
    self.gameServerName = TFDirector:getChildByPath(self.gameServerList, "Label_serverName")
	self.Panel_logo = TFDirector:getChildByPath(ui, "Panel_logo")

	if not FunctionDataMgr:isOneYearLoginUI() then
		local logoImg = TFImage:create("ui/login/logo.png")
		logoImg:setAnchorPoint(ccp(0.5, 0.5))
		logoImg:setPosition(ccp(30,-400))
		-- self.Panel_logo:addChild(logoImg)
	end


	self.Panel_base = TFDirector:getChildByPath(ui,"Panel_base");
	local params = {
		_type = EC_InputLayerType.OK
	}
	self.accInputLayer = require("lua.logic.common.InputLayer"):new(params);
    self:addLayer(self.accInputLayer,1000);

    self.pdInputLayer = require("lua.logic.common.InputLayer"):new(params);
    self:addLayer(self.pdInputLayer,1000);

    self.codeInputLayer = require("lua.logic.common.InputLayer"):new(params);
    self:addLayer(self.codeInputLayer,1000);

    self:refreshView()

    self:login();
end

function LoginLayer:login()
	if CC_TARGET_PLATFORM ~= CC_PLATFORM_WIN32 and HeitaoSdk then
		HeitaoSdk.disableDeviceSleep(true)
		if not self.isShowLoingBoard then
			HeitaoSdk.login();
		else
			HeitaoSdk.loginOut();
		end
		self.accountBtn:setVisible(false)
		self.Button_play:setPositionX(self.accountBtnPosX)
	else

		if not self.isShowLoingBoard then
			local pluginTimer
			pluginTimer = TFDirector:addTimer(0,1,nil,function ()
		                                                TFDirector:removeTimer(pluginTimer)
		                                                self:autoLogin();
			end)
		else
			self:showLoingBoard();
		end
		self.accountBtn:setVisible(true)
		self.Button_play:setPositionX(self.Button_playPosX)
	end

end

function LoginLayer:refreshView()
    self:updateServerName()
end

function LoginLayer:autoLogin()
	if SaveManager:getIsActivat() and not self.isChangeAccount then
		local account,password = SaveManager:getUserInfoDemo();
        -- LogonHelper:setAccount(account)
        -- LogonHelper:setPassword(password)
        -- LogonHelper:setActiveCode(nil)
        -- LogonHelper:setAutoLogin(true)
        LogonHelper:loginTest(account,password,nil,true);
	end
end

function LoginLayer:loginAccountSuccess()
	if self.loginBoard then
		self.loginBoard:setVisible(false);
	end

	if CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
		if not LogonHelper:isVerification() then
			LogonHelper:loginVerification();
		end
	end

	if CC_TARGET_PLATFORM ~= CC_PLATFORM_WIN32 then
		if self.showWebView then
			self:showWebView();
		end
	end
end

function LoginLayer:loginBtnCallback()
	print("account  : "..self.accountInput:getText())
	print("password : "..self.passwordInput:getText())
	print("code     : "..self.codeInput:getText())
	local account  = self.accountInput:getText();
	local password = self.passwordInput:getText();
	local code     = self.codeInput:getText();
	account 	= string.gsub(account," ","");
	password 	= string.gsub(password," ","");
	code 		= string.gsub(code," ","");

	if string.len(account) <= 0 then
		-- toastMessage("用户名不能为空")
		Utils:showTips(800089)
		return
	end

	-- if string.len(password) <= 0 and not GM_MODE then
	-- 	toastMessage("密码不能为空")
	-- 	return
	-- end

	if string.len(account) < 1 then
		-- toastMessage("请输入6-12位字母数字")
		Utils:showTips(800087)
		return
	end

	-- if string.len(password) < 6 and not GM_MODE then
	-- 	toastMessage("请输入6-12位字母数字")
	-- 	return
	-- end

	if GM_MODE then
		LogonHelper:GMLogin(account);
	else
		LogonHelper:loginTest(account,password,code)
	end
end

function LoginLayer:initDefault()
	local userInfo  = SaveManager:getUserInfo()
	local username = userInfo.userName
	if username then
		self.input_name:setText(username)
	end
end

function LoginLayer:removeUI()
	self.super.removeUI(self)
end

function LoginLayer:onWebViewClose()
	if not LogonHelper:isVerification() then
		LogonHelper:loginVerification();
	end
	--self.touchLayer:setTouchEnabled(true);
end

function LoginLayer:registerEvents()
	self.super.registerEvents(self)

    EventMgr:addEventListener(self, "LoginLayer.LoginComplete", handler(self.loginGameServerSuccess, self))
    EventMgr:addEventListener(self, "LoginLayer.LoginSuccess", handler(self.loginAccountSuccess, self))
    EventMgr:addEventListener(self, EV_WEBVIEW_CLOSE, handler(self.onWebViewClose, self))

	local function onTextFieldChangedHandleAcc(input)
       	local text = input:getText()
        local new_text = string.gsub(text, "[^a-zA-Z0-9_]", "")
        input:setText(new_text)
        self.accInputLayer:listener(new_text);
	    self.pdInputLayer:hideAction();
	    self.codeInputLayer:hideAction();
    end

    local function onTextFieldAttachAcc(input)
    	local text = input:getText()
        local new_text = string.gsub(text, "[^a-zA-Z0-9_]", "")
        input:setText(new_text)
        self.accInputLayer:show();
        self.accInputLayer:listener(new_text);
	    self.pdInputLayer:hideAction();
	    self.codeInputLayer:hideAction();

	    self:chooseBox(1)
    end

    self.accountInput:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleAcc)
    self.accountInput:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
    self.accountInput:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)

    local function onTextFieldChangedHandlePD(input)
       	local text = input:getText()
        local new_text = string.gsub(text, "[^a-zA-Z0-9]", "")
        input:setText(new_text)
        self.pdInputLayer:listener(new_text);
	    self.accInputLayer:hideAction();
	    self.codeInputLayer:hideAction();
    end

    local function onTextFieldAttachPD(input)
    	local text = input:getText()
        local new_text = string.gsub(text, "[^a-zA-Z0-9]", "")
        input:setText(new_text)
        self.pdInputLayer:listener(new_text);
    	self.pdInputLayer:show();
	    self.accInputLayer:hideAction();
	    self.codeInputLayer:hideAction();

	    self:chooseBox(2)
    end

    self.passwordInput:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandlePD)
    self.passwordInput:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachPD)
    self.passwordInput:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandlePD)


    local function onTextFieldChangedHandleCD(input)
       	local text = input:getText()
        local new_text = string.gsub(text, "[^a-zA-Z0-9]", "")
        input:setText(new_text)
        self.codeInputLayer:listener(new_text);
	    self.accInputLayer:hideAction();
	    self.pdInputLayer:hideAction();
    end

    local function onTextFieldAttachCD(input)
    	local text = input:getText()
        local new_text = string.gsub(text, "[^a-zA-Z0-9]", "")
        input:setText(new_text)
    	self.codeInputLayer:show();
    	self.codeInputLayer:listener(new_text);
	    self.accInputLayer:hideAction();
	    self.pdInputLayer:hideAction();

	    self:chooseBox(3)
    end

    self.codeInput:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleCD)
    self.codeInput:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachCD)
    self.codeInput:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleCD)

    self.Panel_serverList:onClick(function()
        --Utils:openView("test.ServerListView")
        local view = requireNew("lua.logic.test.ServerListView"):new()
        self:addLayer(view, AlertManager.BLOCK)
        --AlertManager:show()
    end)

    self.gameServerList:onClick(function()
        local view = requireNew("lua.logic.login.ServerChoose"):new()
        self:addLayer(view, AlertManager.BLOCK)
        --AlertManager:show()
    end)

	ADD_KEYBOARD_CLOSE_LISTENER(self, self.ui)

	self.Button_closeLogin:onClick(function()
       	self.loginBoard:setVisible(false)
    end)
end

function LoginLayer:removeEvents()
	self.super.removeEvents(self)
	TFDirector:removeMEGlobalListener("LoginLayer.LoginSuccess", handler(self.loginAccountSuccess, self))
    TFDirector:removeMEGlobalListener("LoginLayer.LoginComplete", handler(self.loginGameServerSuccess, self))
end

function LoginLayer:showLoingBoard()
	self.loginBoard:setVisible(not self.loginBoard:isVisible());
	self.loginBoard:setTouchEnabled(self.loginBoard:isVisible());
	self.loginBoard:setScale(0);

	local tween =
	    {
	        target = self.loginBoard,
	        {
            	duration = 0.2,
            	scale 	 = 1,
	    	},
	    }
	TFDirector:toTween(tween)

	if SaveManager:getIsActivat() then
		local account,password = SaveManager:getUserInfoDemo();
		self.accountInput:setText(account);
		self.passwordInput:setText(password);
	end
end

function LoginLayer:hideLoginBoard()
	self.loginBoard:setVisible(false);
	self.loginBoard:setTouchEnabled(false);
end


function LoginLayer:loginServer()

end

function LoginLayer:loginGameServerSuccess(event)
    hideAllLoading()
    TFDirector:removeMEGlobalListener("LoginLayer.LoginComplete", handler(self.loginGameServerSuccess, self))
    dump("loginGameServerSuccess")
    local currentScene = Public:currentScene()
    if currentScene ~= nil and currentScene.getTopLayer then
        if currentScene.__cname == "LoginScene" then
        	local playerLv = MainPlayer:getPlayerLv()
        	if playerLv <= 5 then
        		MainPlayer:enterGame()
            	AlertManager:changeScene(SceneType.MainScene)
        	else
        		TFAssetsManager:downloadFullAssets(function()
        			MainPlayer:enterGame()
            		AlertManager:changeScene(SceneType.MainScene)
        		end)
        	end
        end
    end
end

function LoginLayer.enterNextPage(sender)
	local self = sender.logic
	if CC_TARGET_PLATFORM ~= CC_PLATFORM_WIN32 and HeitaoSdk then
		if not HeitaoSdk.isLogined() then
			HeitaoSdk.login();
			return;
		end

		if not self.isShowWeb then
			self:showWebView();
			return;
		end

		if not LogonHelper:isVerification() then
			LogonHelper:loginVerification();
			return;
		end
		
		HeitaoSdk.doAntiAddicationQuery();	

		return;
	end

	--AlertManager:changeScene(SceneType.MainScene)
	if not SaveManager:getIsActivat() or not LogonHelper:getIsLogin() then
		self:showLoingBoard();
		return
	end

	if self.loginBoard:isVisible() then
		self:hideLoginBoard();
		return;
	end

	do  --账户登录成功 登录游戏服

		print("--账户登录成功 登录游戏服")

		self:hideLoginBoard();
		--模拟实名认证
		if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
			doAntiAddicationQuery();
		else
			CommonManager:loginServer();
		end
		
	    return;
	end
end


function LoginLayer:updateServerName(groupName, serverName)
    if not groupName then
        groupName = LogonHelper:getGroupName()
        serverName = LogonHelper:getServerName()
    end
    if groupName then
        serverName = serverName or "*"
        local serverGroupConfig = ServerDataMgr:getServerList(groupName)
        local realName = groupName
	    if serverGroupConfig and serverGroupConfig.name then
	        realName = serverGroupConfig.name
	    end
        self.Label_serverName:setText(string.format("%s:%s", realName, serverName))
    else
        self.Label_serverName:setTextById(800090)
    end

    local serverList = ServerDataMgr:getGameServerList();
    self.gameServerList:setVisible(( serverList and table.count(serverList) > 1))
    local isShow = self.gameServerList:isVisible()
    if isShow then
    	local name = ServerDataMgr:getCurrentServerName();
    	dump(name);
    	self.gameServerName:setString(name);
    end

end

function LoginLayer:showWebView()
	dump("show1")
	if not self.isShowWeb then
		Utils:sendHttpLog("informed_page_L")
		self.isShowWeb = true;
		if me.platform == "android" then

			if HeitaoSdk then
				HeitaoSdk.isFunctionSupported("showAnnouncement");
			end
	        
	    else
	    	dump("show2")
	        if tonumber(TFDeviceInfo:getCurAppVersion()) >= 3.10 then
	        	dump("show3")
	            HeitaoSdk.isFunctionSupported("showAnnouncement");
	        else
	            HeitaoSdk.isFunctionSupported("showAnnouncement");
	        end
	    end
	else
		if HeitaoSdk then
			HeitaoSdk.doAntiAddicationQuery();
		end
	end
end

function LoginLayer:chooseBox(index)

	for i=1,3 do
		if i==index then
			self.chooseImge[i]:setVisible(true)
		else
			self.chooseImge[i]:setVisible(false)
		end
	end
end

function LoginLayer:onKeyBack()
    if self.cleanUpView then
        self:removeLayer(self.cleanUpView, true)
        self.cleanUpView = nil
    else
        if HeitaoSdk then
            HeitaoSdk.loginExit()
        else
            Box("真机上调用退出")
        end
    end
end

return LoginLayer;
