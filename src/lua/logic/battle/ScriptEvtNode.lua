local ScriptEvtNode = class("ScriptEvtNode")
local LevelParse = import(".LevelParse")
local KeyStateMgr = import(".KeyStateMgr")
local BattleTimerManager = import(".BattleTimerManager")
local enum       = import(".enum")
local eEvent     = enum.eEvent
local eMode         = enum.eMode
local eDir        = enum.eDir
local ResLoader      = import(".ResLoader")
local AIAgent      = import(".AIAgent")
local BattleGuide = import(".BattleGuide")
local EvtGroupClass = {
	sequence = "EvtSequence",
	spaw = "EvtSpaw",
}
local EvtTypeEnum = {
	curtainEvt = "curtainEvt",
	playTarAnimEvt = "playTarAnimEvt",
	playStoryEvt = "playStoryEvt",
	monsterAIEvt = "monsterAIEvt",
	delayTimeEvt = "delayTimeEvt",
	ctrlEvt = "ctrlEvt",
	cameraMoveEvt = "cameraMoveEvt",
	cameraFollowEvt = "cameraFollowEvt",
	cameraFocalEvt = "cameraFocalEvt",
	playEffectEvt = "playEffectEvt",
	waveScreenEvt = "waveScreenEvt",
	screenMaskEvt = "screenMaskEvt",
	moveHeroEvt = "moveHeroEvt",
	transHeroEvt = "transHeroEvt",
	chatEvt = "chatEvt",
	playSoundEvt = "playSoundEvt",
	BGMVolumeEvt = "BGMVolumeEvt",
	playCGEvt = "playCGEvt",
	battlePauseEvt = "battlePauseEvt",
	playerCtrlEvt = "playerCtrlEvt",
	playVideoEvt = "playVideoEvt",
	moveMapObjEvt = "moveMapObjEvt",
	loadVisualSpineEvt = "loadVisualSpineEvt",
	stopWatchSwitchEvt = "stopWatchSwitchEvt",
	showBattleGuideEvt = "showBattleGuideEvt",
}
function ScriptEvtNode:ctor(param)
	self.complete = false
	self.isRunning = false
	self.EvtRan = false
	self.parent = param.parent
	self.childEvt = {}
	self.NodeCfg = param.cfg
	self.IdxNum = param.idxnum
	self.battleCtrl = param.battleCtrl
	self.callback = nil
	self:initNode()
end

function ScriptEvtNode:initNode()
	self.nodeClass = self.NodeCfg.class
	if self.parent then
		self.parent:addChildEvt(self)
	end
end

function ScriptEvtNode:addChildEvt(evt)
	if evt.IdxNum ~= self.IdxNum and self.IdxNum == evt.parent.IdxNum then
		self.childEvt[#self.childEvt + 1] = evt
	end
end
function ScriptEvtNode:runEvent()
	print("Run::::::::::::::::", self.NodeCfg.evtType or self.nodeClass,"::",self.IdxNum)
	self.isRunning = true
	if self.nodeClass == EvtGroupClass.spaw then
		for i,v in ipairs(self.childEvt) do
			v:runEvent()
		end
	elseif self.nodeClass == EvtGroupClass.sequence then
		self:runNextEvent()
	else
		self:swichEvtBindFunc(self.NodeCfg)
	end
end

function ScriptEvtNode:swichEvtBindFunc(cfg)
	if self.EvtRan == true then
		return
	end
	if cfg.evtType == EvtTypeEnum.curtainEvt then
		self:doCurtainEvt(cfg)
		return
	end
	if cfg.evtType == EvtTypeEnum.playTarAnimEvt then
		self:doPlayTarAnimEvt(cfg)
		return
	end
	if cfg.evtType == EvtTypeEnum.playStoryEvt then
		self:doPlayStoryEvt(cfg)
		return
	end
	if cfg.evtType == EvtTypeEnum.monsterAIEvt then
		self:doMonsterAIEvt(cfg)
		return
	end
	if cfg.evtType == EvtTypeEnum.delayTimeEvt then
		self:doDelayTimeEvt(cfg)
		return
	end
	if cfg.evtType == EvtTypeEnum.ctrlEvt then
		self:doCtrlEvt(cfg)
		return
	end
	if cfg.evtType == EvtTypeEnum.cameraMoveEvt then
		self:doCameraMoveEvt(cfg)
		return
	end
	if cfg.evtType == EvtTypeEnum.cameraFollowEvt then
		self:doCameraFollowEvt(cfg)
		return
	end
	if cfg.evtType == EvtTypeEnum.cameraFocalEvt then
		self:doCameraFocalEvt(cfg)
		return
	end
	if cfg.evtType == EvtTypeEnum.playEffectEvt then
		self:doPlayEffectEvt(cfg)
		return
	end
	if cfg.evtType == EvtTypeEnum.waveScreenEvt then
		self:doWaveScreenEvt(cfg)
		return
	end
	if cfg.evtType == EvtTypeEnum.screenMaskEvt then
		self:doScreenMaskEvt(cfg)
		return
	end
	if cfg.evtType == EvtTypeEnum.moveHeroEvt then
		self:doMoveHeroEvt(cfg)
		return
	end
	if cfg.evtType == EvtTypeEnum.transHeroEvt then
		self:doTransHeroEvt(cfg)
		return
	end
	if cfg.evtType == EvtTypeEnum.chatEvt then
		self:doChatEvt(cfg)
		return
	end
	if cfg.evtType == EvtTypeEnum.playSoundEvt then
		self:doPlaySoundEvt(cfg)
		return
	end
	if cfg.evtType == EvtTypeEnum.BGMVolumeEvt then
		self:doBGMVolumeEvt(cfg)
		return
	end
	if cfg.evtType == EvtTypeEnum.playCGEvt then
		self:doPlayCGEvt(cfg)
		return
	end
	if cfg.evtType == EvtTypeEnum.battlePauseEvt then
		self:doBattlePauseEvt(cfg)
		return
	end
	if cfg.evtType == EvtTypeEnum.playerCtrlEvt then
		self:doPlayerCtrlEvt(cfg)
		return
	end
	if cfg.evtType == EvtTypeEnum.playVideoEvt then
		self:doPlayVideoEvt(cfg)
		return
	end
	if cfg.evtType == EvtTypeEnum.moveMapObjEvt then
		self:doMoveMapObjEvt(cfg)
		return
	end
	if cfg.evtType == EvtTypeEnum.loadVisualSpineEvt then
		self:doLoadVisualSpineEvt(cfg)
		return
	end
	if cfg.evtType == EvtTypeEnum.stopWatchSwitchEvt then
		self:doStopWatchSwitchEvt(cfg)
		return
	end
	if cfg.evtType == EvtTypeEnum.showBattleGuideEvt then
		self:doShowBattleGuideEvt(cfg)
		return
	end
end

function ScriptEvtNode:runNextEvent()
	if self.nodeClass == EvtGroupClass.sequence then
		for i,v in ipairs(self.childEvt) do
			if v.complete == false then
				if v.isRunning == true then
					return
				else
					v:runEvent()
				end
				return
			end
		end

	end
end

function ScriptEvtNode:onComplete()
    if self.complete == false then
        if self.nodeClass == EvtGroupClass.sequence or self.nodeClass == EvtGroupClass.spaw then
		    self:checkChild()
            return
        else
            self.complete = true
            self.isRunning = false
            self.EvtRan = true
        end
    end
	if self.complete == true then
		print("Complete::::::::::",self.NodeCfg.evtType or self.nodeClass,"::",self.IdxNum)
		self.timerhandle = BattleTimerManager:addTimer(33,1,function()
			BattleTimerManager:removeTimer(self.timerhandle)
			self.timerhandle = nil
			if self.parent then
				self.parent:checkChild()
			else
				if self.callback then
					self.callback()
					self.callback = nil
				end
			end
		end,nil)
		-- if self.parent then
		-- 	self.parent:onComplete()
		-- else
		-- 	if self.callback then
		-- 		self.callback()
		-- 		self.callback = nil
		-- 	end
		-- end
	end
end

function ScriptEvtNode:checkChild()
    local iscomplete = true
	if self.nodeClass == EvtGroupClass.sequence then
		for k,v in ipairs(self.childEvt) do
			if v.complete == false then
                iscomplete = false
                if v.isRunning == true then
                	break
                end
				if v.isRunning == false then
					v:runEvent()
					break
				end
				
			end
		end
	end
	if self.nodeClass == EvtGroupClass.spaw then
		for k,v in ipairs(self.childEvt) do
			if v.complete == false then
				iscomplete = false
                break
			end
		end
	end
    if iscomplete == true then
	    self.complete = true
	    self.isRunning = false
        self.EvtRan = true
        self:onComplete()
    end
end

function ScriptEvtNode:registCompleteCallback(callback)
	self.callback = callback
end

---------------Event--------------

function ScriptEvtNode:doCurtainEvt(cfg)
	local duration = 1
	if cfg.duration then
		duration = cfg.duration/1000
	end
	EventMgr:dispatchEvent(EV_BATTLE_CURTAIN,{isShow = cfg.val,duration = duration,callback = handler(self.onComplete,self)})
end

function ScriptEvtNode:doPlayTarAnimEvt(cfg)


	if cfg.tarType == nil or cfg.tarType == 0 then
		local herolist = {}
		if cfg.tarID == 0 or cfg.tarID == -1 then
			local hero = self.battleCtrl.getCaptain()
			herolist[#herolist + 1] = hero
		else
			local enemylist = self.battleCtrl.getEnemyMember()
			for k,v in pairs(enemylist) do
				if v:getData().id == cfg.tarID then
					herolist[#herolist + 1] = v
				end
			end
		end
		for i,v in ipairs(herolist) do
			local curactor = v:getActor()
			if curactor then
				curactor:playAni(cfg.anim, false, function()
					v:cancelToStand()
					self:onComplete()
				end,false)
			end
		end
	else
		print("Play::::::::::::::::",cfg.anim,"======",tostring(os.time()))
		local vhero =  LevelParse:getVisualHero(cfg.tarID)
		if cfg.position then
			vhero:setPosition(cfg.position)
		end

		vhero:playAni({anim = cfg.anim, callback = handler(self.onComplete,self),hide = cfg.hide,idle = cfg.idle,setupPose = cfg.setupPose})

	end

end

function ScriptEvtNode:doPlayStoryEvt(cfg)
	local levelCfg = BattleDataMgr:getLevelCfg()
	if levelCfg.isPlayOncePlot then
		local tag   = "IsHadPlayPlotInFight"..MainPlayer:getPlayerId()..levelCfg.id..cfg.groupID
		local _bool = (Utils:getLocalSettingValue(tag) ~= "")
		if _bool then
			self:onComplete()
			return
		else
			Utils:setLocalSettingValue(tag, "true")
		end
	end

	local formation = {}
	if self.battleCtrl.getBench then
		local teamMembers = self.battleCtrl.getBench()
		for k,v in pairs(teamMembers) do
			local heroCid = v:getData().id
			formation[heroCid] = 1
		end
	end

	EventMgr:dispatchEvent(EV_BATTLE_PLAY_STORYTALK,{groupid = cfg.groupID,formation = formation,callback = handler(self.onComplete,self)})
end

function ScriptEvtNode:doMonsterAIEvt(cfg)
	if cfg.aimAtID and type(cfg.aimAtID) == "table" then
		local enemylist = self.battleCtrl.getEnemyMember()
		for k,v in pairs(enemylist) do
			for s,t in pairs(cfg.aimAtID) do
				if v:getData().id == t then
					v:setAIEnable(cfg.val)
				end
			end
		end
	else
		AIAgent:setEnabled(cfg.val)
	end
	self:onComplete()

end

function ScriptEvtNode:doDelayTimeEvt(cfg)
	self.timmerid = BattleTimerManager:addTimer(cfg.duration,1,function()
			BattleTimerManager:removeTimer(self.timmerid)
            self.timmerid = nil
			self:onComplete()
		end,nil)
end

function ScriptEvtNode:doCtrlEvt(cfg)
	EventMgr:dispatchEvent(EV_BATTLE_CTRLS_SHOW,{list = cfg.list,callback = handler(self.onComplete,self)})
end

function ScriptEvtNode:doCameraMoveEvt(cfg)
	local tmCameraPos = clone(self.battleCtrl.getCameraPos3D())
	tmCameraPos.x = cfg.finalPos.x
	tmCameraPos.y = cfg.finalPos.y
	tmCameraPos.z = cfg.finalPos.z or tmCameraPos.z or 553
	local function handleTimeVal(timeval)
		if timeval and timeval ~= "" then
			return timeval/1000
		else
			return nil
		end
	end
	self.battleCtrl.cameraMoveTo(handleTimeVal(cfg.zoomDuration),tmCameraPos,handleTimeVal(cfg.holdDuration),handleTimeVal(cfg.recoverTime),handler(self.onComplete,self))
end

function ScriptEvtNode:doCameraFollowEvt(cfg)
	if cfg.tarType == nil or cfg.tarType == 0 then
		if cfg.tarID == 0 or cfg.tarID == -1 then
			self.battleCtrl.setCameraMode(eMode.FOLLOW)
			self.battleCtrl.setFocusNode(nil)
			self:onComplete()
		else
			local enemylist = self.battleCtrl.getEnemyMember()
			for k,v in pairs(enemylist) do
				if v:getData().id == cfg.tarID then
					local curactor = v:getActor()
					if curactor then
						self.battleCtrl.setCameraMode(eMode.FOLLOW)
						self.battleCtrl.setFocusNode(curactor)
						self:onComplete()
						return
					end
				end
			end
		end
	else
		local vhero =  LevelParse:getVisualHero(cfg.tarID)
		self.battleCtrl.setCameraMode(eMode.FOLLOW_NODE)
		self.battleCtrl.setFocusNode(vhero)
        self:onComplete()
	end
end

function ScriptEvtNode:doCameraFocalEvt(cfg)
	local tmCameraPos = clone(self.battleCtrl.getCameraPos3D())
	local znum = 553/cfg.scale
	tmCameraPos.z = znum
	local function handleTimeVal(timeval)
		if timeval and timeval ~= "" then
			return timeval/1000
		else
			return nil
		end
	end
	self.battleCtrl.cameraMoveTo(handleTimeVal(cfg.zoomDuration),tmCameraPos,handleTimeVal(cfg.holdDuration),handleTimeVal(cfg.recoverTime),handler(self.onComplete,self))
end

function ScriptEvtNode:doPlayEffectEvt(cfg)
	if  cfg.parentID == 0 then
		local mapLayer = LevelParse:getMapLayer(LevelParse.LayerType.Render)
		if mapLayer then
			local skeletonNode = ResLoader.createEffect(cfg.effectName,1)
		    skeletonNode:play(cfg.animName, false)
		    skeletonNode:setRotation(cfg.rotation)
		    skeletonNode:setPosition(me.p(cfg.addPos.x,cfg.addPos.y))
            skeletonNode:addMEListener(TFARMATURE_COMPLETE,handler(self.onComplete,self))
		    mapLayer:addChild(skeletonNode)
		end
		return
	end

	if cfg.tarType == nil or cfg.tarType == 0 then
		local herolist = {}
		if cfg.tarID == 0 or cfg.tarID == -1 then
			local hero = self.battleCtrl.getCaptain()
			herolist[#herolist + 1] = hero
		else
			local enemylist = self.battleCtrl.getEnemyMember()
			for k,v in pairs(enemylist) do
				if v:getData().id == cfg.tarID then
					herolist[#herolist + 1] = v
				end
			end
		end
		for i,v in ipairs(herolist) do
	        local curactor = v:getActor()
	        if curactor then
	            curactor:playEffect(cfg.effectName,1,cfg.animName,handler(self.onComplete,self))
	        end
		end
	else
		local vhero =  LevelParse:getVisualHero(cfg.tarID)
		if cfg.position then
			vhero:setPosition(cfg.position)
		end
		vhero:playEffect(cfg.effectName,1,cfg.animName,handler(self.onComplete,self))
	end

end

function ScriptEvtNode:doWaveScreenEvt(cfg)
	local data = {
                    shakeCount = cfg.count or 1,
                    shakeType  = cfg.waveStyle or 1,
                    shakeStrength  = 10,
                    shakeInching = false,
                    callFunc = handler(self.onComplete,self)
                 }
    EventMgr:dispatchEvent(eEvent.EVENT_SCREEN_WOBBLE, data)
end

function ScriptEvtNode:doScreenMaskEvt(cfg)
	EventMgr:dispatchEvent(EV_BATTLE_SUPER_MASK, {color = cfg.color,duration = cfg.duration,maskAction = cfg.maskAction ,callback = handler(self.onComplete,self)})
end

function ScriptEvtNode:doMoveHeroEvt(cfg)

	if cfg.tarType == nil or cfg.tarType == 0 then
		local herolist = {}
		if cfg.tarID == 0 or cfg.tarID == -1 then
			local hero = self.battleCtrl.getCaptain()
			herolist[#herolist + 1] = hero
		else
			local enemylist = self.battleCtrl.getEnemyMember()
			for k,v in pairs(enemylist) do
				if v:getData().id == cfg.tarID then
					herolist[#herolist + 1] = v
				end
			end
		end
		for i,v in ipairs(herolist) do
			v:moveToPos(cfg.finalPos,handler(self.onComplete,self))
		end
	else
		local vhero =  LevelParse:getVisualHero(cfg.tarID)
		vhero:moveToPos(cfg,handler(self.onComplete,self))

	end

end

function ScriptEvtNode:doTransHeroEvt(cfg)
	local herolist = {}
	if cfg.tarType == nil or cfg.tarType == 0 then
		if cfg.tarID == 0 or cfg.tarID == -1 then
			local hero = self.battleCtrl.getCaptain()
			herolist[#herolist + 1] = hero
		else
			local enemylist = self.battleCtrl.getEnemyMember()
			for k,v in pairs(enemylist) do
				if v:getData().id == cfg.tarID then
					herolist[#herolist + 1] = v
				end
			end
		end
	else
		local vhero =  LevelParse:getVisualHero(cfg.tarID)
		herolist[#herolist + 1] = vhero

	end
	for i,v in ipairs(herolist) do
		v:setPosition3D(cfg.finalPos.x,cfg.finalPos.y,cfg.finalPos.y)
		v:setLastPosition(cfg.finalPos.x,cfg.finalPos.y,cfg.finalPos.y)
		if cfg.finalDir == 0 then
			v:setDir(eDir.LEFT)
		else
			v:setDir(eDir.RIGHT)
		end
	end
	self:onComplete()
end

function ScriptEvtNode:doChatEvt(cfg)

end

function ScriptEvtNode:doPlaySoundEvt(cfg)
	local effectCfg = TabDataMgr:getData("DungeonLevelSound",cfg["soundID"])
	TFAudio.playEffect(effectCfg.resource,false,1,0,effectCfg.volume)
	self:onComplete()
end

function ScriptEvtNode:doBGMVolumeEvt(cfg)
	if TFAudio.isMusicPlaying() then
		local tmvolume = TFAudio.getMusicVolume()
		local settingVolume = SettingDataMgr:getSoundBgmVal()
		local tarVolume = cfg.volume * settingVolume
		local varVolume = tarVolume - tmvolume
		if varVolume ~= 0 then
			local step = varVolume*0.1
			local timmerid = BattleTimerManager:addTimer(100,10,function()
				BattleTimerManager:removeTimer(timmerid)
				self:onComplete()
			end,function()
				tmvolume = tmvolume + step
				TFAudio.setMusicVolume(tmvolume)
			end)
		else
			self:onComplete()
		end
	else
		self:onComplete()
	end
end

function ScriptEvtNode:doPlayCGEvt(cfg)
	EventMgr:dispatchEvent(EV_BATTLE_PLAYCG_ANIM,{cgid = cfg.CGID,callback = handler(self.onComplete,self)})
end

function ScriptEvtNode:doBattlePauseEvt(cfg)
	if cfg.isPause == true then
		EventMgr:dispatchEvent(eEvent.EVENT_PAUSE)
	else
		EventMgr:dispatchEvent(eEvent.EVENT_RESUME)
	end
	self:onComplete()
end

function ScriptEvtNode:doPlayerCtrlEvt(cfg)
	KeyStateMgr.setEnable(cfg.isEnable)
    self:onComplete()
end

function ScriptEvtNode:doPlayVideoEvt(cfg)
	local pass = FubenDataMgr:isPassPlotLevel(101101)
	if not pass and cfg.videoName == "cg_main_kaichangdonghua" then
		Utils:sendHttpLog("guid_page_N")
	end
	self.videoView = Utils:openView("common.VideoView",string.format("video/%s.mp4",cfg.videoName))
    self.videoView:bindEndCallBack(function()
    	if not pass and cfg.videoName == "cg_main_kaichangdonghua" then
			Utils:sendHttpLog("guid_skip_O")
		end
        self:onComplete()
    end)
end

function ScriptEvtNode:doMoveMapObjEvt(cfg)
	LevelParse:moveObject(cfg)
	self:onComplete()
end

function ScriptEvtNode:doLoadVisualSpineEvt(cfg)
	LevelParse:loadVisualHero(cfg,handler(self.onComplete,self))
end

function ScriptEvtNode:doStopWatchSwitchEvt(cfg)
	self.battleCtrl.setTiming(cfg.val)
	self:onComplete()
end

function ScriptEvtNode:doShowBattleGuideEvt(cfg)
	local curlevelId = BattleDataMgr:getCurLevelCid()
    if FubenDataMgr:isPassPlotLevel(curlevelId) == false then
        BattleGuide:runGuide(cfg.guideId,handler(self.onComplete,self))
    end
    self:onComplete()
	
end
return ScriptEvtNode