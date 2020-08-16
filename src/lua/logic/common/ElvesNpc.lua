local Npc = {}

local TTFLive2D = class("TTFLive2D",function()
	if Npc.isUseLive3 then
		return TFLive2D3:create()
	end
	return TFLive2D:create()
end)

function TTFLive2D:ctor(roleInfo)

	self:add(roleInfo.rolePath, roleInfo.roleName)
	-- 重写setScale()
	self._setScale = self.setScale
	self.setScale = self.__setScale
	self:setScale(0.55)
	self.type = roleInfo.type

	self._setPosition = self.setPosition
	self.setPosition = self.__setPosition
	self:setPosition(self:getPosition())

	self.defaultScale = self:getScale()
	self.roleName = roleInfo.roleName
	self.head = {}
	self.body = {}
	self.fubu = {}
	self.tui = {}
	self.hand = {}
	self.parts_ = {}
	self.lastTouchPartsName = nil
	self.isClick = true
	self.favorLevel = nil
	self.isTouch = roleInfo.isTouch or false
	self.isSendTouch = roleInfo.isSendTouch or false
	self:setTouchEnabled(true)
	self.modelId = roleInfo.modelId
	self.defaultAcName = roleInfo.defaultAcName
    self.isShowText = roleInfo.isShowText
    self.roleTextViewExPos = ccp(330,80)

	self.timer_ = nil

	self:setColor(me.WHITE)

	print("new modelId ", self.modelId)
	self:refreshFavorLevel()

	self:addMEListener(TFLIVE2D_TAP, handler(self.onTap,self))
	self:addMEListener(TFWIDGET_EXIT, handler(self._onCleanUp,self))

end

function TTFLive2D:__setScale(value)
	self:_setScale(value)
	if self.expression then
		self.expression:_setScale(value)
	end
end

function TTFLive2D:__setPosition(x,y)
    if not y then
        self:_setPosition(x)
    else
        self:_setPosition(ccp(x, y))
    end
    -- print("__setPosition x : ",x)
    -- print("__setPosition y : ",y)
	if self.type == 1 then
		local disHeight = me.Director:getWinSize().height/2
		-- print("__setPosition disHeight ",disHeight)
		self:_setPosition(self:getPosition().x,self:getPosition().y + disHeight)
	end
	-- print("__setPosition Pos : ",self:Pos())
end

function TTFLive2D:onTap(sender, idx, x, y)

	local state = RoleSwitchDataMgr:getSwitchAnimateState()
	if state then
		return
	end

	if sender.isTouch == false and not sender.clickFun then
		return
	end
	local checkStr = ""
	if sender:checkHit(idx, EC_HIT_AREA_NAME.HEAD, x, y) then
		print("head")
		sender:kanbanTouchEvent(sender.head)
		checkStr = EC_HIT_AREA_NAME.HEAD
	elseif sender:checkHit(idx, EC_HIT_AREA_NAME.BODY, x, y) then
		print("body")
		sender:kanbanTouchEvent(sender.body)
		checkStr = EC_HIT_AREA_NAME.BODY
	elseif sender:checkHit(idx, EC_HIT_AREA_NAME.FUBU, x, y) then
		print("fubu")
		sender:kanbanTouchEvent(sender.fubu)
		checkStr = EC_HIT_AREA_NAME.FUBU
	elseif sender:checkHit(idx, EC_HIT_AREA_NAME.TUI, x, y) then
		print("tui")
		sender:kanbanTouchEvent(sender.tui)
		checkStr = EC_HIT_AREA_NAME.TUI
	elseif sender:checkHit(idx, EC_HIT_AREA_NAME.HAND_R, x, y) then
		print("hand_r")
		sender:kanbanTouchEvent(sender.hand)
		checkStr = EC_HIT_AREA_NAME.HAND_R
	elseif sender:checkHit(idx, EC_HIT_AREA_NAME.HAND_L, x, y) then
		print("hand_l")
		sender:kanbanTouchEvent(sender.hand)
		checkStr = EC_HIT_AREA_NAME.HAND_L
	end

	if #checkStr > 0 and self.isSendTouch then
		EventMgr:dispatchEvent(EV_DATING_EVENT.touchRole)
	end

	if sender.clickFun  and sender.isClick == true and #checkStr > 0 then
		local jumpid = tonumber(sender.jumpTable[string.format("%s",checkStr)])
		print(sender.jumpTable)
		if jumpid == nil or jumpid == 0 then
			Box("jumpid错误")
		else
			sender.clickFun(jumpid)
			sender.clickFun = nil
		end
		return
	end

	if self.node and self.node.clickFun then
		self.node.clickFun()
	end

	if checkStr == "" then
		return
	else

	end
end
function TTFLive2D:refreshFavorLevel()
	if not self.modelId then
		return
	end
	local lastFavorLevel = self.favorLevel
	local roleId = RoleDataMgr:getRoleId(self.modelId)
	local roleInfo = RoleDataMgr:getRoleInfo(roleId)
	if not roleInfo then
		return
	end
	self.favorLevel = roleInfo.favorLevel
	-- if lastFavorLevel and lastFavorLevel >= self.favorLevel then
	-- 	return
	-- end
	local kanBanInfo = self:parseKanBanInfo(self.modelId)
	if kanBanInfo then
		self:bindKanBanInfo(kanBanInfo)
	end
	self:playDefaultAction()
end

function TTFLive2D:parseKanBanInfo(modelId,favorLevel)
	local favorLevel = favorLevel or self.favorLevel
	local kanBanInfo = {}
	local iTable = TabDataMgr:getData("Interaction")
	for k,v in pairs(iTable) do
		if (modelId == nil or (modelId and v.modelId == modelId)) and v.favor == favorLevel then
			self.defaultAct = v.defaultAct
			if v.position== EC_HIT_AREA_NAME.HEAD then
				kanBanInfo.head = v
			elseif v.position == EC_HIT_AREA_NAME.BODY then
				kanBanInfo.body = v
			elseif v.position == EC_HIT_AREA_NAME.FUBU then
				kanBanInfo.fubu = v
			elseif v.position == EC_HIT_AREA_NAME.TUI then
				kanBanInfo.tui = v
			elseif v.position == "hand" then
				kanBanInfo.hand = v
			end
		 end
	end
	return kanBanInfo
end

function TTFLive2D:bindKanBanInfo(kanBanInfo)
	self:bindKanBanTouchPartsInfo(self.head,kanBanInfo.head)
	self:bindKanBanTouchPartsInfo(self.body,kanBanInfo.body)
	self:bindKanBanTouchPartsInfo(self.fubu,kanBanInfo.fubu)
	self:bindKanBanTouchPartsInfo(self.tui,kanBanInfo.tui)
	self:bindKanBanTouchPartsInfo(self.hand,kanBanInfo.hand)
end

function TTFLive2D:bindKanBanTouchPartsInfo(live2dParts,kanBanInfoParts)
	if kanBanInfoParts == nil then

		return
	end
	live2dParts.consecutiveClicks = 0 					 -- 部位连续点击次数
	live2dParts.partsName = kanBanInfoParts.position	 -- 部位名
	live2dParts.favor = kanBanInfoParts.favor			 -- 好感度
	live2dParts.condition1 = {} --普通事件触发条件
	live2dParts.condition1.type = tonumber(string.split(kanBanInfoParts.condition1,";")[1])
	live2dParts.condition1.clickNum = tonumber(string.split(kanBanInfoParts.condition1,";")[2])
	live2dParts.voice1 = string.split(kanBanInfoParts.voice1, "-")    		 --普通事件语音
	live2dParts.action1 = string.split(kanBanInfoParts.action1, "-") 		 --普通事件动画
	live2dParts.lines1 = kanBanInfoParts.lines1			 --普通事件台词
	live2dParts.condition2 = {} --特殊事件触发条件
	live2dParts.condition2.type = tonumber(string.split(kanBanInfoParts.condition2,";")[1])
	live2dParts.condition2.clickNum = tonumber(string.split(kanBanInfoParts.condition2,";")[2])
	live2dParts.voice2 = kanBanInfoParts.voice2			 --特殊事件语音
	live2dParts.action2 = kanBanInfoParts.action2		 --特殊事件动画
	live2dParts.lines2 = kanBanInfoParts.lines2			 --特殊事件台词
	live2dParts.lineShow = kanBanInfoParts.lineShow		 --看板娘台词组
	live2dParts.lineStop = kanBanInfoParts.lineStop		 --看板娘台词时间组
	live2dParts.effect = kanBanInfoParts.effect		 	 --特效名字
	live2dParts.anime = kanBanInfoParts.anime		 	 --特效名字
end

function TTFLive2D:kanbanTouchEvent(live2dParts, textPos)

	if self.lastTouchPartsName == nil then
		self.lastTouchPartsName = live2dParts.partsName
	elseif self.lastTouchPartsName ~= live2dParts.partsName then
		self[string.format("%s",self.lastTouchPartsName)].consecutiveClicks = 0
		self.lastTouchPartsName = live2dParts.partsName
	end

	-- print("live2dParts ",live2dParts)
	-- print("live2dParts.consecutiveClicks ",live2dParts.consecutiveClicks)
	--TFAudio:stopAllEffects()
	if live2dParts and live2dParts.consecutiveClicks then
		local clickNum = live2dParts.consecutiveClicks
		clickNum = clickNum + 1
		local isPlayOk = nil -- -1失败，其他成功
		--特殊触发条件类型为2（连续点击同一个部位三次触发）
		if live2dParts.condition2.type == 2 and clickNum == live2dParts.condition2.clickNum then
			isPlayOk = self:newStartAction(live2dParts.action2,EC_PRIORITY.NORMAL,nil,nil,nil,0,true)
			-- print("live2dParts.voice2",live2dParts.voice2)
			 if isPlayOk ~= -1  then
			-- 	if tonumber(live2dParts.voice2) == 0 then
			-- 	else
			-- 		self:playVoice(string.format("sound/role/%s.mp3",live2dParts.voice2))
			-- 	end
			 	self:showKanbanLines(live2dParts, textPos)
			-- 	live2dParts.consecutiveClicks = 0
			 end
		else
			local action1 = nil
			local voice1 = nil
			local actIdx = nil
			if type(live2dParts.action1) == "string" then
				action1 = live2dParts.action1
			elseif type(live2dParts.action1) == "table" then
				actIdx = math.random(1,#live2dParts.action1)
				action1 = live2dParts.action1[actIdx]
			end
			if type(live2dParts.voice1) == "string" then
				voice1 = live2dParts.voice1
			elseif type(live2dParts.voice1) == "table" and actIdx then
				if #live2dParts.voice1 < actIdx then
					actIdx = 1
				end
				voice1 = live2dParts.voice1[actIdx]
			end
			print("play action1",action1)
			-- print("play voice1",voice1)
			isPlayOk = self:newStartAction(action1,EC_PRIORITY.NORMAL,nil,nil,nil,0,true)
			 if isPlayOk ~= -1 then
			-- 	if tonumber(voice1) == 0 then
			-- 	else
			-- 		self:playVoice(string.format("sound/role/%s.mp3",voice1))
			-- 	end
			 	self:showKanbanLines(live2dParts, textPos)
			-- 	live2dParts.consecutiveClicks = live2dParts.consecutiveClicks + 1
			 end
		end

		if live2dParts.effect and live2dParts.effect ~= "" then
			local ske = SkeletonAnimation:create(live2dParts.effect)
			if live2dParts.anime and live2dParts.anime ~= "" then
				ske:play(live2dParts.anime,false);
			else
				ske:playByIndex(0,-1,-1,0);
			end
	        self:addChild(ske)
	        ske:addMEListener(TFARMATURE_COMPLETE,function ( ... )
	        	ske:removeMEListener(TFARMATURE_COMPLETE)
	        	ske:removeFromParent(true)
	        end)
		end

		if self.isSendTouch and isPlayOk and isPlayOk ~= -1 then
			if RoleDataMgr:isFavorReachCriticality(RoleDataMgr:getUseId()) then
				Utils:showTips(304002)
			else
				if RoleDataMgr:isFavorReachMaxValue(RoleDataMgr:getUseId()) then
					-- local name = TextDataMgr:getTextAttr(RoleDataMgr:getUseRoleInfo().nameId).text
					-- local str = string.format(TextDataMgr:getTextAttr(900307).text,name)
					-- Utils:showTips(str)
				else
					RoleDataMgr:sendTouchRole()
				end
			end
		end
	end
end

function TTFLive2D:showKanbanLines(live2dParts,pos)
	--显示对话
    if not self.isShowText or not live2dParts.lineShow or #live2dParts.lineShow == 0 then
        return
    end

	if self.roleTextView then
		self.roleTextView:stopAllActions()
		self.roleTextView:removeFromParent()
		self.roleTextView = nil
	end

	local idx = 1

	local showRoleTextView = nil
	showRoleTextView = function(lines)
		local data = {}
		data.lines = lines
		data.pos = pos or self.roleTextViewExPos
		self.roleTextView = require("lua.logic.role.RoleTextViewEx"):new(data)
		self.roleTextView:setRotation(self:getRotation())
		self:getParent():addChild(self.roleTextView,1000);

		if live2dParts.lineStop and live2dParts.lineStop[idx] then
			local time = live2dParts.lineStop[idx]
			self.roleTextView:timeOut(function()
				self.roleTextView:removeFromParent()
				self.roleTextView = nil
				idx = idx + 1
				if idx > #live2dParts.lineShow then
					return
				end
				showRoleTextView(live2dParts.lineShow[idx])
			end,time)
		else
			self.roleTextView:timeOut(function()
				self.roleTextView:removeFromParent()
				self.roleTextView = nil
			end,2.0)
			return
		end
	end

	showRoleTextView(live2dParts.lineShow[idx])
end

function TTFLive2D:setRoleTextViewExVisible( visible )
	-- body
	if self.roleTextView then
		self.roleTextView:setVisible(visible)
	end
end

function TTFLive2D:playVoice(voice)
    if self.effectHandle then
        TFAudio.stopEffect(self.effectHandle)
    end
	self.effectHandle = TFAudio.playVoice(voice,false)
    local baseVol = SettingDataMgr:getSoundMainVal()
    local voiceVol = SettingDataMgr:getSoundVoiceVal()
    AudioEngine:setVolume(self.effectHandle,baseVol * voiceVol)
end

function TTFLive2D:bindClickJumpFun(clickFun,jumpTable)
	self.jumpTable = {}
	self.jumpTable[EC_HIT_AREA_NAME.HEAD] = jumpTable[EC_HIT_AREA_NAME.HEAD]
	self.jumpTable[EC_HIT_AREA_NAME.BODY] = jumpTable[EC_HIT_AREA_NAME.BODY]
	self.jumpTable[EC_HIT_AREA_NAME.FUBU] = jumpTable[EC_HIT_AREA_NAME.FUBU]
	self.jumpTable[EC_HIT_AREA_NAME.TUI] = jumpTable[EC_HIT_AREA_NAME.TUI]
	self.jumpTable[EC_HIT_AREA_NAME.HAND_R] = jumpTable[EC_HIT_AREA_NAME.HAND_R]
	self.jumpTable[EC_HIT_AREA_NAME.HAND_L] = jumpTable[EC_HIT_AREA_NAME.HAND_L]

	self.clickFun = clickFun
end

function TTFLive2D:newStartPlayLoopAction(interval,acName)
	self.loopAcName = acName
    self:stopPlayLoopAction()
	self.timerID_ = TFDirector:addTimer(interval, -1, nil, handler(self.newUpdateLoopAction, self))
end

function TTFLive2D:newUpdateLoopAction()
	if not self.loopAcName then
		return
	end

	local isOK = self:startMotion(0,self.loopAcName, 0, EC_PRIORITY.IDLE)
	print("live2d ",self)
	print("loop play action = ",self.loopAcName)
	print("isOK = ",isOK)
end

function TTFLive2D:stopPlayLoopAction()
    if self.timerID_ then
    	self:stopAllActions()
        TFDirector:removeTimer(self.timerID_)
        self.timerID_ = nil
    end
end
function TTFLive2D:playDefaultAction(priority)
	if not self.defaultAct and not self.defaultAcName then
		return
	end
	if true then --动画默认动画暂时不主动播放
		return
	end
	print("self.defaultAcName ",self.defaultAcName)
	print("self.defaultAct ",self.defaultAct)
	self:newStartAction(self.defaultAcName or self.defaultAct,priority or EC_PRIORITY.IDLE,9,self.defaultAcName or self.defaultAct,9*1000)
end

function TTFLive2D:setDefaultAct(defaultAct)
	self.defaultAct = defaultAct
end

function TTFLive2D:getVoicePath()
    return self.voicePath
end

function TTFLive2D:setVoiceVolume(soundValue)
    local voicePath = self:getVoicePath()
    if voicePath and AudioEngine.setPathVolume then
        local baseVol = SettingDataMgr:getSoundMainVal()
        local voiceVol = SettingDataMgr:getSoundVoiceVal()
        AudioEngine:setPathVolume(voicePath,baseVol*voiceVol*soundValue*2)
    end
end

function TTFLive2D:newStartAction(acName,priority,deyTime,loopName,interval,soundValue,isPlaySound)

	-- if Npc.isUseLive3 then
	-- 	return
	-- end
	if #acName == 0 then
		return
	end
	self:stopPlayLoopAction()
	print("acName newStartAction",acName)
	print("priority newStartAction",priority)

    soundValue = soundValue or 1
	local voicePath = Npc:getModelBindVoicePath(self.modelId,acName)
	--if voicePath == nil then return end
    self.voicePath = voicePath
	self:setVoiceVolume(soundValue)

	local isOK = self:startMotion(0,acName, 0, priority)
	if isOK ~= -1 and (isPlaySound or (self.type == 1 and self.isTouch and self.isSendTouch and AudioEngine.setPathVolume)) then
		self:playVoice(voicePath)
	end
	--if self.type == 0 then
	--	local backID = self:getCurrentEffectID(0)
	--	if backID then
	--		print("进来播放音效了")
	--		local baseVol = SettingDataMgr:getSoundMainVal()
	--		local voiceVol = SettingDataMgr:getSoundVoiceVal()
	--		AudioEngine:setVolume(backID, baseVol*voiceVol*2)
	--	end
	--else
    --
	--end
	print("isOK newStartAction",isOK)
	if deyTime == nil or not loopName then
		return isOK
	end
	local function playFun()
		self:newStartPlayLoopAction(interval,loopName)
	end
	local acFun = {
		DelayTime:create(deyTime),
		CallFunc:create(playFun)
	}
	self:runAction(CCSequence:create(acFun))
	return isOK
end

function TTFLive2D:playExpression(eName)
	if #eName == 0 then
		return
	end
	local isOK = self:setExpression(0,eName)
	print("playExpression eName",eName)
	print("playExpression isOK",isOK)
end

function TTFLive2D:onRefreshFavorLevel()
	self:refreshFavorLevel()
end

function TTFLive2D:registerEvents()
	self.addlisFun = handler(self.onRefreshFavorLevel, self)
	TFDirector:addMEGlobalListener(EV_DATING_EVENT.refreshRole , self.addlisFun)
end

function TTFLive2D:removeEvents()
	TFDirector:removeMEGlobalListener(EV_DATING_EVENT.refreshRole, self.addlisFun)
end

function TTFLive2D:_onCleanUp()
    print("live2d object is removed!!")
    self:stopAllActions()
	self:removeEvents()
	self:stopPlayLoopAction()
	self:stopRenderAction(self,false)
	self:stopTimer()
	if self.roleTextView then
		self.roleTextView:stopAllActions()
		self.roleTextView:removeFromParent()
		self.roleTextView = nil
	end
end

function TTFLive2D:removeExpression()
	if self.expression then
		self.expression:removeFromParent()
		self.expression = nil
	end
end

function TTFLive2D:addExpression(expressionInfo)
	self:removeExpression()
	if expressionInfo and expressionInfo.roleName and tonumber(expressionInfo.roleName) ~= 0 then
		local expression = TTFLive2D:createWithRole(expressionInfo)
		expression:newStartAction(expressionInfo.roleAction,EC_PRIORITY.FORCE)
		self:addChild(expression)
		self.expression = expression
	end
end

--以剪切的方式消失
function TTFLive2D:playClipOut()
    self:timeOut(function()
        local tx = CCRenderTexture:create(self:getSize().width,self:getSize().height)
        tx:begin();
        self:visit();
        tx:endToLua();
        self:hide()

        local sp = Sprite:createWithTexture(tx:getSprite():getTexture());
        local size = self:getSize();
		if self.type == 0 then
			size = self:getParent():getSize()
		end
        sp:Pos(size.width / 2,size.height / 2)
        self:getParent():addChild(sp,self:getZOrder());
        sp:setFlipY(true)

        local clippingNode = CCClippingNode:create()
        local stencil = Sprite:create("ui/999.png")
        clippingNode:setInverted(true)
        stencil:scaleTo(4.5,100)
        stencil:Pos(size.width / 2,size.height / 2)
        clippingNode:setStencil(stencil)
        clippingNode:setAlphaThreshold(0.05)
        sp:retain()
        sp:removeFromParent()
        clippingNode:addChild(sp)
        sp:release()
        self:getParent():addChild(clippingNode, 100)
        end,0)
end

local TFLive2dTimer = nil;
function TTFLive2D:addRenderTexture()
	local tx = CCRenderTexture:create(self:getSize().width,self:getSize().height)
	tx:begin();
	self:visit();
	tx:endToLua();
	self:hide()

	local sp = Sprite:createWithTexture(tx:getSprite():getTexture());
	local size = self:getSize();
	if self.type == 0 then
		sp:Pos(1136 / 2,size.height / 2)
	else
		sp:Pos(size.width / 2,size.height / 2)
	end

	self:getParent():addChild(sp,self:getZOrder());
	sp:setFlipY(true)

	local function delayToGame(dt)

		if tolua.isnull(self) then
			TFDirector:removeTimer(TFLive2dTimer);
	    	self.timer_ = nil
	    	TFLive2dTimer = nil;
	    	return;
		end

		self:show()
		local tx = CCRenderTexture:create(self:getSize().width,self:getSize().height)
		tx:begin();
		self:visit();
		tx:endToLua();
		self:hide()

		sp:setTexture(tx:getSprite():getTexture());
		--self:stopTimer()
	end
	self.timer_ = TFDirector:addTimer(10, -1, nil, delayToGame)
	TFLive2dTimer = self.timer_;

	return sp
end

function TTFLive2D:showGray(time,dTime)
	self:stopTimer()
	if self.sp then
		self.sp:stopAllActions()
		self.sp:RemoveSelf()
		self.sp = nil
	end
	local sp = self:addRenderTexture()
	sp:setOpacity(255)
	sp:setColor(ccc3(0,0,0));
	self.sp = sp
	if dTime then
		sp:setOpacity(0)
		sp:fadeIn(dTime)
	end
	sp:timeOut(function()
		self:stopTimer()
		self:show()
		sp:RemoveSelf()
		self.sp = nil
		end,time)
end

function TTFLive2D:stopTimer()
	if self.timer_ then
	    TFDirector:removeTimer(self.timer_)
	    self.timer_ = nil
	    TFLive2dTimer = nil;
	end
end

function TTFLive2D:playOut(time)

	self:stopTimer()
	if self.sp then
		self.sp:stopAllActions()
		self.sp:RemoveSelf()
		self.sp = nil
	end
	local sp = self:addRenderTexture()
	self.sp = sp
	self:hide()
	sp:fadeOut(time)
	sp:timeOut(function()
		self:stopTimer()
		sp:RemoveSelf()
		self.sp = nil
		end,time)

	return sp
end


function TTFLive2D:playIn(time)
	self:stopTimer()
	self:hide()
	if self.sp then
		self.sp:stopAllActions()
		self.sp:RemoveSelf()
		self.sp = nil
	end
	local sp = self:addRenderTexture()
	self.sp = sp
	sp:setOpacity(0)
	sp:fadeIn(time)

	sp:timeOut(function()
		self:stopTimer()
		self:show()
		sp:RemoveSelf()
		self.sp = nil
		end,time)
	return sp
end

function TTFLive2D:playMoveLeftIn(time)
	local sp = self:playIn(time)
	sp:PosX(sp:PosX() + 50)
	sp:moveBy(time,-50,0)
end
function TTFLive2D:playMoveRightIn(time)
	local sp = self:playIn(time)
	sp:PosX(sp:PosX() - 50)
	sp:moveBy(time,50,0)
end
function TTFLive2D:playMoveUpIn(time)
	local sp = self:playIn(time)
	sp:PosY(sp:PosY() - 50)
	sp:moveBy(time,0,50)
end

function TTFLive2D:playMoveLeftOut(time)
	local sp = self:playOut(time)
	sp:moveBy(time,-35,0)
end
function TTFLive2D:playMoveRightOut(time)
	local sp = self:playOut(time)
	sp:moveBy(time,35,0)
end
function TTFLive2D:playMoveDownOut(time)
	local sp = self:playOut(time)
	sp:moveBy(time,0,-35)
end

function TTFLive2D:stopRenderAction(isShow)
	self:stopTimer()
	if self.sp then
		self.sp:stopAllActions()
		self.sp:RemoveSelf()
		self.sp = nil
	end
	self:setVisible(isShow)
end

function TTFLive2D:createWithRole(roleInfo)
	return TTFLive2D:new(roleInfo)
end

function TTFLive2D:playEyeBlink()
	if self.type == 0 then
		self:setEyeBlinkEnabled(0, true)
		self:setEyeBlinkInterval(0, 5000)
	end
end

function TTFLive2D:changeEyeMaxValue(value)
	if self.type == 0 then
		self:setEyeMaxValue(0, value)
	end
end

function TTFLive2D:playNovoice()
	print("playNovoice播放说话动画")
	if self.type == 0 then
		self:setLipSync(0, true)
	end
end

function TTFLive2D:stopNovoice()
	print("stopNovoice停止说话动画")
	if self.type == 0 then
		self:setLipSync(0, false)
	end
end

function TTFLive2D:playNovoiceTuZui()
	print("playNovoiceTuZui播放说话动画")
	if self.type == 0 then
		self:setCustomParam(0, true,"PARAM_TUZUI")
	end
end

function TTFLive2D:stopNovoiceTuZui()
	print("playNovoiceTuZui停止说话动画")
	if self.type == 0 then
		self:setCustomParam(0, false,"PARAM_TUZUI")
	end
end

--获取当前看板娘动画绑定音效的时间（目前只支持2.0）
function TTFLive2D:getCurrentEffectTime()
	if self.type == 0 then
		local time = self:getCurrentEffectDuration(0)
		print("getCurrentEffectTime time ",time)
		return time
	end
	return 0
end

local ElvesNpc = class("ElvesNpc")


function ElvesNpc:ctor(isUseLive3)
	self.isUseLive3 = isUseLive3 or false
end

function ElvesNpc:create(isUseLive3)
	return self:new(isUseLive3)
end

function ElvesNpc:createNpcNode(roleTable)
	local _ElvesNpc = ElvesNpc:create();

	local node = CCNode:create():Size(me.Director:getWinSize())
	node:OnBegan(function(sender, pos)

	end)
	node:OnMoved(function(sender, pos)

	end)
	node:OnEnded(function(sender, pos)
		if node.clickFun then
			node.clickFun()
		end
	end)

	_ElvesNpc.node = node

	Npc = _ElvesNpc
	return _ElvesNpc
end

function ElvesNpc:bindClickFun(clickFun)
	self.node.clickFun = clickFun
end


function ElvesNpc:addLive2dNpc(roleInfo,expressionInfo)
	local live2d =  TTFLive2D:createWithRole(roleInfo)
	live2d:addExpression(expressionInfo)
	self.zorder = self.zorder and self.zorder + 1 or 0
	self.node:addChild(live2d, self.zorder)

	live2d:playEyeBlink()

	return live2d
end

function ElvesNpc:addLive2dNpcID(modelId,defaultAcName,eModelId,eActionName)
	local live2d = self:createLive2dNpcID(modelId,false,false,defaultAcName).live2d
	self:addExpressionID(live2d,eModelId,eActionName)
	self.zorder = self.zorder and self.zorder + 1 or 0
	self.node:addChild(live2d, self.zorder)

	live2d:playEyeBlink()

	return live2d
end

function ElvesNpc:addExpressionID(model,eModelId,actionName)
	if not eModelId or eModelId == 0 then
		return
	end
	model:removeExpression()
	local expression = self:createLive2dNpcID(eModelId,false,false).live2d
	expression:newStartAction(actionName,EC_PRIORITY.FORCE)
	model:addChild(expression)
	expression:Pos(10,100)
	model.expression = expression
end

function ElvesNpc:createLive2dNpc(roleInfo,expressionInfo)
	local live2d =  TTFLive2D:createWithRole(roleInfo)
	live2d:addExpression(expressionInfo)

	live2d:playEyeBlink()

	return live2d
end

function ElvesNpc:createLive2dNpcID(modelId,isTouch,isSendTouch,defaultAcName,isShowText)
	local modelData = self:getModelInfo(modelId)
	if not modelData then
		return
	end
	local isUseLive3 = false
	if modelData.type == 1 then
		isUseLive3 = true
	end

	local _ElvesNpc = ElvesNpc:create(isUseLive3); -- true使用3.0

	Npc = _ElvesNpc

	local roleInfo = {}
	roleInfo.modelId = modelId
	roleInfo.isTouch = isTouch
	roleInfo.isSendTouch = isSendTouch
	roleInfo.defaultAcName = defaultAcName
	roleInfo.rolePath = modelData.rolePath
	roleInfo.roleName = modelData.roleName
	roleInfo.type = modelData.type
    roleInfo.isShowText = isShowText

	print("ElvesNpc:createLive2dNpcID roleInfo: ",roleInfo)

	_ElvesNpc.live2d = TTFLive2D:createWithRole(roleInfo)

	local node = CCNode:create():Size(CCSizeMake(2000,2000))
	node:OnBegan(function(sender, pos)
		_ElvesNpc.live2d:handleTouchBegan(pos.x, pos.y)
	end)
	node:OnMoved(function(sender, pos)
		if not node.isCloseTouchFollow then
			_ElvesNpc.live2d:handleTouchMoved(pos.x, pos.y)
		end
	end)
	node:OnEnded(function(sender, pos)
		_ElvesNpc.live2d:handleTouchEnded(pos.x, pos.y)
	end)
	node:setSwallowTouch(false)
	node.isCloseTouchFollow = modelData.isCloseTouchFollow
	node:setAnchorPoint(ccp(0.5,0.5))
	_ElvesNpc.live2d:setTouchEnabled(false)
	_ElvesNpc.live2d:addChild(node)
	_ElvesNpc.live2d.touchNode = node

	return _ElvesNpc
end

function ElvesNpc:getModelInfo(modelId)
	local modelData = nil
	local mTable = TabDataMgr:getData("RoleModel")
	modelData = mTable[modelId]
	return clone(modelData) or {}
end

function ElvesNpc:getModelBindVoicePath(modelId,actionName)
	local modelData = self:getModelInfo(modelId)
	local str = string.format("%s/%s",modelData.rolePath,modelData.roleName)
	local jsonContent = io.readfile(str)
	local data         = json.decode(jsonContent) --模型数据
	local newAddStr = "newPath/"
	local motions  = data.motions or data.FileReferences.Motions
	if motions and motions[actionName] and motions[actionName][1] then
		local sound = motions[actionName][1]["sound"] or motions[actionName][1]["Sound"] -- 2.0,3.0字段大小写不同
		local tablePath = string.split(sound, newAddStr)
		print("tablePath", tablePath)
		local filePath = tablePath[table.count(tablePath)]
		print("filePath", filePath)
		return filePath
	end
end

function ElvesNpc:resetModelBindVoicePath(modelId)
	local modelData = self:getModelInfo(modelId)
	local str = string.format("%s/%s",modelData.rolePath,modelData.roleName)
	local jsonContent = io.readfile(str)
	local data         = json.decode(jsonContent) --模型数据
	local motions  = data.motions or data.FileReferences.Motions
	local newAddStr = "newPath/"
	local f = string.find(jsonContent,"newPath")
	if f then
		return
	end
	for k, v in pairs(motions) do
		if v[1] then
			if v[1]["Sound"] then
				print("last v[1]Sound ",v[1]["Sound"])
				v[1]["Sound"] = string.format(newAddStr.."%s",v[1]["Sound"])
				print("new v[1]Sound ",v[1]["Sound"])
			end
		end
	end
	Box("bbbbbbbb")
	--io.writefile(str,json.encode(data))
	local filePath = me.FileUtils:fullPathForFilename(str)
	self:writeToFile(filePath,json.encode(data))

end

function ElvesNpc:writeToFile(szPath,szContent)
	-- body
	if not szPath then return end

	local fileHandle = nil
	local bWriteRet  = false
	local bCreateDir = false


	fileHandle = io.open(szPath,"wb",szPath)
	if not fileHandle then
		self.szErr             = "wirte file " .. szPath .." error"
		return false
	else
		if szContent then
			bWriteRet = fileHandle:write(szContent)
		end
		fileHandle:close()
	end

	return true
end

function ElvesNpc:resLoader(modelId)
	local modelData = self:getModelInfo(modelId)
	local str = string.format("%s/%s",modelData.rolePath,modelData.roleName)
	local jsonContent = io.readfile(str)
	print("\n")
	print("resLoader modelId: ",modelId)
	print("str ",str)
	local data         = json.decode(jsonContent) --模型数据
	local defaultResList = data.textures or data.FileReferences.Textures
	local function asynCallFunc( ... )

	end
    for k , texture in pairs(defaultResList) do
        print("ElvesNpc:resLoader texture",texture)
        me.TextureCache:addFileAsync(texture,asynCallFunc,1)
    end
end


return ElvesNpc
