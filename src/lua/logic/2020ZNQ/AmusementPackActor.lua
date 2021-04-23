--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
* -- 游乐园同屏actor
]]

local ResLoader    = require("lua.logic.battle.ResLoader")
local BasicActor =  import("lua.logic.mmoBasicClass.BasicActor")
local MapUtils = import("lua.logic.osd.MapUtils")
local enum = require("lua.logic.battle.enum")
local eDir = enum.eDir
local flyToPos = true
local AmusementPackActor = class("AmusementPackActor",BasicActor)

-- 表情类型
local EmotionType = {
    Small = 1,
    Big   = 2
}

if not AmusementPackActor.prefabe then
	AmusementPackActor.prefabe = createUIByLuaNew("lua.uiconfig.activity.actor_prefab")
	AmusementPackActor.prefabe:retain()
end

local ActorStateType = {
		BORN = 1,
		STAND = 2,
		MOVE = 3,
		SILENCE = 4,
		ACTIVE = 5,
		INIT = 6,
	}

local ActorEventName = {
		BORN = "BORN",
		STAND = "STAND",
		MOVE = "MOVE",
		SILENCE = "SILENCE",
		ACTIVE = "ACTIVE",
		INIT = "INIT",
	}

local eAnimation = {
		STAND = "idle",
		MOVE = "move",
}

function AmusementPackActor:ctor( data )
	-- body
	local events = {
			{name = ActorEventName.INIT, from = {"*"}, to = ActorStateType.INIT},
			{name = ActorEventName.BORN, from = {ActorStateType.INIT}, to = ActorStateType.BORN},
			{name = ActorEventName.STAND, from = {ActorStateType.INIT, ActorStateType.BORN, ActorStateType.MOVE, ActorStateType.ACTIVE}, to = ActorStateType.STAND},
			{name = ActorEventName.MOVE, from = {ActorStateType.BORN, ActorStateType.STAND, ActorStateType.MOVE}, to = ActorStateType.MOVE},
			{name = ActorEventName.SILENCE, from = {ActorStateType.STAND, ActorStateType.MOVE,ActorStateType.ACTIVE}, to = ActorStateType.SILENCE},
			{name = ActorEventName.ACTIVE, from = {ActorStateType.SILENCE}, to = ActorStateType.ACTIVE},
		}

	local initial = {
			event = "initEvent",
			state = ActorStateType.INIT,
			defer = true
		}
	self.super.ctor(self, data, events, initial)
	self:addFSMAfterEvents(ActorStateType.INIT, handler(self.initState,self))
	self:addFSMAfterEvents(ActorStateType.BORN, handler(self.playBorn,self))
	self:addFSMAfterEvents(ActorStateType.STAND, handler(self.playStand,self))
	self:addFSMAfterEvents(ActorStateType.MOVE, handler(self.playMove,self))
	self:addFSMAfterEvents(ActorStateType.SILENCE, handler(self.enterSilence,self))
	self:addFSMAfterEvents(ActorStateType.ACTIVE, handler(self.beActive,self))

	self:addFSMLeaveEvents(ActorStateType.MOVE, handler(self.leaveMove,self))

	self:createActor(data)
	self:doEvent("initEvent")
end

function AmusementPackActor:initState( ... )
	-- body
end

function AmusementPackActor:createActor( actorData )
	-- body
	if actorData.skinCid then
		self:createHero(actorData)
	else
		self:createNpc(actorData)
	end

	if self:isMainHero() then
		self.isTriggerFuc = true
	end

	if actorData.pos then
		self:setPosition3D(actorData.pos.x ,actorData.pos.y, actorData.pos.y)
	end
	
	self.childType = actorData.childType
	self:updateHideNode()
end

function AmusementPackActor:getAnimWithPrefix(anim)
    if self.isSpecialModel == true then
        if self.dir == eDir.LEFT then
            anim = "l_"..anim
        else
            anim = "r_"..anim
        end
    end
    return anim
end

function AmusementPackActor:createSpine( notSetPose )
	-- body
	self.skeletonNode = self:createSkeleton(self.resPath, notSetPose)
end

function AmusementPackActor:createSkeleton( resPath, notSetPose )
	-- body
	local skeletonNode = nil
	 if ResLoader.cacheSpine[resPath] and #ResLoader.cacheSpine[resPath] >= 1 then
    	skeletonNode = ResLoader.cacheSpine[resPath][1]
    	skeletonNode:autorelease()
    	table.remove(ResLoader.cacheSpine[resPath],1)

    	skeletonNode:removeMEListener(TFARMATURE_EVENT)
        skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
        skeletonNode:removeMEListener(TFWIDGET_ENTER)
        skeletonNode:removeMEListener(TFWIDGET_EXIT)
        -- _print("找到 skeleton:"..skeletonNode:retainCount().." "..resPath)
        --重置位置
        skeletonNode:setPosition(me.p(0,0))
        skeletonNode:setAnimationFps(GameConfig.ANIM_FPS)
        skeletonNode:setColor(me.WHITE)
       	skeletonNode:setRotation(0)
        skeletonNode:clearTracks()
    else
		skeletonNode = ResLoader.getSkeletonNode(resPath)
    end
    skeletonNode:setupPoseWhenPlay(not notSetPose)
    return skeletonNode
end

function AmusementPackActor:createHero( actorData )
	local conf = TabDataMgr:getData("CityRoleModel",actorData.skinCid)

	self.speedScale = conf.moveSpeedMultiplier or 1
	local aniPath = conf.rolePath
    self.isFlip = conf.flip
    self.isSpecialModel = not self.isFlip
    self.resPath = aniPath
    self:createSpine()
    self.skeletonNode:setAnimationFps(GameConfig.ANIM_FPS)
    self:playAni(eAnimation.STAND,true)
    self:addChild(self.skeletonNode,1)
	self.skeletonNode:setScale(WorldRoomDataMgr:getCurControl():getModelScale())
	-- body
	local prefabe = AmusementPackActor.prefabe
	local heroUI = TFDirector:getChildByPath(prefabe, "Panel_player"):clone()

	
	self.isCameraScale = false
	self.lable_name = TFDirector:getChildByPath(heroUI,"lable_name")
	self.lable_name:setText(actorData.pname)

	self.image_bubble = TFDirector:getChildByPath(heroUI, "Image_bubble"):hide()
	local label_bubble = TFDirector:getChildByPath(heroUI, "Label_bubble")

	self.defaultImg = self.image_bubble:getTexture()
	self.chatBubbleOffsetSize = CCSize(self.image_bubble:getContentSize().width - label_bubble:getContentSize().width, self.image_bubble:getContentSize().height - label_bubble:getContentSize().height)

	label_bubble:setTextById("r70003")
	self.label_bubble = label_bubble.__richText

	heroUI:setPosition(ccp(0,0))
	self:addChild(heroUI,2)	
	self.showUi = heroUI

	if not self.shadowNode then
		self.shadowNode = TFImage:create("citymap/world/shadow.png")
		self:addChild(self.shadowNode)
	end

	if not self.ghostNode and WorldRoomDataMgr:getCurControl():getGhost() then
		self.ghostNode = TFImage:create(WorldRoomDataMgr:getCurControl():getGhost())
		self.ghostNode:setAnchorPoint(ccp(0.5,0))
		self:addChild(self.ghostNode)
		self.ghostNode:hide()
	end

	self.parmaFlag = nil
    self.isAction = true
    self.cameraScope = WorldRoomDataMgr:getCurControl().cameraFixZ

	self.modelType = 1
end

function AmusementPackActor:createNpc( actorData )
	-- body
	local npcCfg = TabDataMgr:getData("WorldObjectMgr", actorData.decorateId)
	local resCfg = TabDataMgr:getData("WorldObjectResource", npcCfg.resourceId)
	if resCfg then
		if resCfg.resourceType == 2 then
			local aniPath = resCfg.path

			self.speedScale = npcCfg.moveSpeedMultiplier or 1
    		self.resPath = aniPath
    		self:createSpine(resCfg.notSetPose)
		    self:addChild(self.skeletonNode,1)

		 	local _drawNode = TFImage:create("ui/common/img_touming.png") -- 解决对象绘制bug 
		 	self.skeletonNode:addChild(_drawNode)

			self.skeletonNode:setScale(npcCfg.modelScale)
		 else
		 	self.imageNode = TFImage:create(resCfg.path)
		 	if resCfg.anchor and #resCfg.anchor > 0 then
			 	self.imageNode:setAnchorPoint(ccp(resCfg.anchor[1],resCfg.anchor[2]))
			end
		 	self:addChild(self.imageNode)
		 end
		 self.isSpecialModel = resCfg.isSpecialModel
	end

	if npcCfg.interArea and #npcCfg.interArea > 0 then
		self.areaRect = me.rect(0,0,npcCfg.interArea[1],npcCfg.interArea[2])
	end


    self.cameraScope = npcCfg.cameraScope

	self.isCameraScale = false
	-- body
	local prefabe = AmusementPackActor.prefabe
	local npcUI = TFDirector:getChildByPath(prefabe, "Panel_npc"):clone()

	self.image_bubble = TFDirector:getChildByPath(npcUI, "Image_bubble"):hide()
	local label_bubble = TFDirector:getChildByPath(npcUI, "Label_bubble")
	self.defaultImg = self.image_bubble:getTexture()
	self.chatBubbleOffsetSize = CCSize(self.image_bubble:getContentSize().width - label_bubble:getContentSize().width, self.image_bubble:getContentSize().height - label_bubble:getContentSize().height)

	label_bubble:setTextById("r70003")
	self.label_bubble = label_bubble.__richText

	npcUI:setPosition(ccp(0,0))
	self:addChild(npcUI,2)
	self.showUi = npcUI	

	self:setDir(npcCfg.dir)

	if npcCfg.isShowShadow then
		if not self.shadowNode then
			self.shadowNode = TFImage:create("citymap/world/shadow.png")
			self:addChild(self.shadowNode)
		end

		if not self.ghostNode and WorldRoomDataMgr:getCurControl():getGhost() then
			self.ghostNode = TFImage:create(WorldRoomDataMgr:getCurControl():getGhost())
			self.ghostNode:setAnchorPoint(ccp(0.5,0))
			self:addChild(self.ghostNode)
			self.ghostNode:hide()
		end
	end

	if self.audioHandler then
		TFAudio.stopEffect(self.audioHandler)
		self.audioHandler = nil
	end

	if npcCfg.audioId > 0 then
		self.audioId = npcCfg.audioId
	end

	if npcCfg.bgm and npcCfg.bgm ~= "" then
		WorldRoomDataMgr:getCurControl():setCurBgm(npcCfg.bgm)
	end
	
	if npcCfg.aiEnable then
		self.aiModel = requireNew("lua.logic.singleWorldScene.SingleAIBehave"):new({tarNode = self ,life = npcCfg.aiTime, cfgId = npcCfg.aiCfgId})
		self.deleteAi = npcCfg.deleteAi
	end

	if npcCfg.parmaFlag ~= 0 then
		self.parmaFlag = npcCfg.parmaFlag
	end
	self.isAlWayTrigger = npcCfg.isAlWayTrigger
	self.layerOut = npcCfg.layer

	self.modelType = 2

    self.isAction = npcCfg.isAction
end
-- 转换富文本
function AmusementPackActor:setRichContent(lab_content,str,fontColor)

    if type(str) == 'table' then
        return
    end
    local dicts = ChatDataMgr:getRichtextImgDict()
    local strdata = nil
    for _str, value in pairs(dicts) do
        if string.find(str, _str) then
            strdata = value
            if value.type == EmotionType.Small then
                str = string.gsub(str, _str, value.emotionres)
            elseif value.type == EmotionType.Big then
                break
            end
        end
    end
    str = string.gsub(str, "\n", "<br/>")

    fontColor = fontColor or "#49557F"
    
    -- 富文本模拟配置
    local richData =  {
        {
            baseName = "fangzheng_zhunyuan",
            name = "font/fangzheng_zhunyuan.ttf",
            color = fontColor,
            text = "%s",
            clickId = "",
            size = 22,
        },
        align = "left",
    }
    lab_content:Text(TextDataMgr:getFormatText(richData,str))
    lab_content:visit()
    lab_content:setCameraMask(self:getCameraMask())
end

--聊天气泡显示
function AmusementPackActor:playTalk(content, nofadeIn, borderImg)

	if borderImg then
		self.image_bubble:setTexture(borderImg)
	elseif self.defaultImg then
		self.image_bubble:setTexture(self.defaultImg)
	end

	if self.image_bubble then 
		-- self.label_bubble:setText(content)
		self:setRichContent(self.label_bubble,content)

		local size = self.label_bubble:getContentSize()
		self.image_bubble:setContentSize(CCSize(size.width + self.chatBubbleOffsetSize.width, size.height + self.chatBubbleOffsetSize.height))

	    self.image_bubble:stopAllActions()
		self.image_bubble:show()
	    if not nofadeIn then
		    self.image_bubble:setScale(0.2)
		    local actions = 
		    {   
		        ScaleTo:create(0.2,1),
		        DelayTime:create(2),
		        ScaleTo:create(0.2,0.1),
		        Hide:create()
		    }
		    self.image_bubble:runAction(Sequence:create(actions))
		else
		    self.image_bubble:setScale(1)
  			local actions = 
		    {   
		        DelayTime:create(2.5),
		        Hide:create()
		    }
		    self.image_bubble:runAction(Sequence:create(actions))
		end
	end
end

function AmusementPackActor:aiDeleteCallBack(  )
	-- body
	if self.aiModel then
		self.aiModel:setAIEnabled(false)
		if self.deleteAi then
			for k,v in ipairs(self.deleteAi) do
				WorldRoomDataMgr:getCurControl():triggerNpcFunc({interActionId = v, triggerPid = self:getPid()}, true)
			end
		end
	end
end

function AmusementPackActor:manualAddAI( aiCfgId )
	-- body
	self.manualAITab = self.manualAITab or {}
	if not self.manualAITab[aiCfgId] then
		self.manualAITab[aiCfgId] = requireNew("lua.logic.singleWorldScene.SingleAIBehave"):new({tarNode = self ,life = -1, cfgId = aiCfgId})
		self.manualAITab[aiCfgId]:setAIEnabled(true)
	end
end

function AmusementPackActor:manualDeleteAI( aiCfgId )
	-- body
	self.manualAITab = self.manualAITab or {}
	if not self.manualAITab[aiCfgId] then return end
	local ai = self.manualAITab[aiCfgId]
	ai:setAIEnabled(false)
	self.manualAITab[aiCfgId] = nil
end

function AmusementPackActor:aiTalk(talkid)
    self.isTalking = true
   
    self:playTalk(TextDataMgr:getTextEx(talkid))
    self.image_bubble:stopAllActions()
    return self.image_bubble
end

function AmusementPackActor:pauseAudio( ... )
	-- body
	if self.audioHandler then
		TFAudio.pauseEffect(self.audioHandler)
	end

	if self.effectAudioHandler then
		TFAudio.pauseEffect(self.effectAudioHandler)
	end
end

function AmusementPackActor:resumeAudio( valume )
	-- body
	if self.audioHandler then
		TFAudio.resumeEffect(self.audioHandler)
	elseif self.audioId then
		self.audioHandler = Utils:playSound(self.audioId, true)
	end

	if valume and self.lastValume ~= valume then
		self.lastValume = valume
		local baseVol = SettingDataMgr:getSoundMainVal()
    	local effectVol = SettingDataMgr:getSoundEffectVal()
    	
    	if self.audioHandler then
			TFAudio.setEffectsVolumeById(self.audioHandler,baseVol*effectVol*valume)
		end

		if self.effectAudioHandler then
			TFAudio.resumeEffect(self.effectAudioHandler)
			TFAudio.setEffectsVolumeById(self.effectAudioHandler,baseVol*effectVol*valume)
		end
	end

end

function AmusementPackActor:addEffectNode( ... )
	-- body
	local actorData = self:getActorData()
	if actorData.effectId and actorData.effectId > 0 then
		local effectCfg = TabDataMgr:getData("CityRoleModelEffect",actorData.effectId)
		if effectCfg then
			self:actionByCfgId(effectCfg.actionId)
		else
    		print("没有特效配置，id"..actorData.effectId)
		end
	end
end

function AmusementPackActor:needUpdate(  )
	-- body
	return self.aiModel or (self.manualAITab and table.count(self.manualAITab) > 0) or self.parmaFlag
end

function AmusementPackActor:update( dt, actorData, index)
	-- body
	self.super.update(self,dt,actorData)
	index = index or 0

	self.aiUpdateDt = self.aiUpdateDt or 0
	self.aiUpdateDt = self.aiUpdateDt + dt

	if not self.actorAiDt and self.aiUpdateDt > 0.01 then
		self.actorAiDt = 0 + index*0.003
		self.aiUpdateDt = 0
	end

	if self.aiModel and self.actorAiDt and  self.aiUpdateDt >= self.actorAiDt then
		self.actorAiDt = nil
		self.aiModel:update(self.aiUpdateDt)
	end
	self.manualAiUpdateDt = self.manualAiUpdateDt or 0
	self.manualAiUpdateDt = self.manualAiUpdateDt + dt

	if not self.actorManualAiDt and self.manualAiUpdateDt > 0.02 then
		self.actorManualAiDt = 0.01 + index*0.003
		self.manualAiUpdateDt = 0
	end

	if self.manualAITab and self.actorManualAiDt and self.manualAiUpdateDt >= self.actorManualAiDt then
		self.actorManualAiDt = nil
		for k,v in pairs(self.manualAITab) do
			v:update(self.manualAiUpdateDt)
		end
	end
	
	self.updateExDatadt = self.updateExDatadt or 0
	self.updateExDatadt = self.updateExDatadt + dt

	if not self.actorExDataDt and self.updateExDatadt > 0.03  then
		self.actorExDataDt = 0.02 + index*0.003
        self.updateExDatadt = 0
	end
	if self.parmaFlag and self.actorExDataDt and self.updateExDatadt >= self.actorExDataDt then -- 通过标记获取数据
		self.updateExDatadt = nil
        local flagData = Utils:getFlagData(self.parmaFlag)
        if flagData and flagData.worldRiddlesData then
            self:setPosition3D(flagData.worldRiddlesData.lox, flagData.worldRiddlesData.loy, flagData.worldRiddlesData.loy)
        end 
    end
end 

function AmusementPackActor:updateHideNode( ... )
	-- body
 	local showOtherEffect = SettingDataMgr:getWorldShowEffect()
	local showOtherName = SettingDataMgr:getWorldShowName()
	-- if self:isMainHero() then
	-- 	if not self.staticEffect then
	-- 		self:addEffectNode()
	-- 	end
	-- 	return 
	-- end

	if self.lable_name then
		self.lable_name:setVisible(showOtherName)
	end

	if not self.staticEffect and showOtherEffect then
		self:addEffectNode()
	end

	if self.staticEffect and not showOtherEffect then
		self.staticEffect:removeFromParent()
		self.staticEffect = nil
	end
end

function AmusementPackActor:inBuildAction( dt, buildActor )
	-- body
	if not buildActor then return end
	if not self.cachePos then
		self.cachePos = self:getPosition()
	end

	local npcData = WorldRoomDataMgr:getCurControl():getActorDataByPid(buildActor:getPid())
	if not npcData.decorateId then return end
	local npcCfg = TabDataMgr:getData("WorldObjectMgr", npcData.decorateId)

	if not self.inBuilding then
		local index = 0
		if not npcData.inRoomPid then return end
		for k,v in pairs(npcData.inRoomPid) do
			if v == self:getPid() then
				index = k
				break
			end
		end
		local boneCfg = npcCfg.mountPoints[index]
		if not boneCfg then
			print("=======骨骼对应点位配置找不到========"..npcCfg.id.."index"..index)
			if self:isMainHero() then
				local actorData = self:getActorData()
				actorData.buildId = nil
				WorldRoomDataMgr:getCurControl():operateLeaveBuild(buildActor:getPid())
			end
			return 
		end

		self:delayAIAction(boneCfg.aiDelayTime or 5000)
		
		self.focusbuildActor = buildActor
		self:setDir(boneCfg.dir)
		self:playAni(boneCfg.chrAni, true)
		self.followBoneName = boneCfg.bone or "mount1"
		local offsetZ = boneCfg.layer and boneCfg.layer or 1
		self:setZOrder(buildActor:getZOrder() + offsetZ*index)
		if self.shadowNode and table.find(npcCfg.ableFunctionOnBuild,6) == -1 then
			self.shadowNode:hide()
		end

		if self:isMainHero() then
			if npcCfg.cameraScope and npcCfg.cameraScope > 0 then
				WorldRoomDataMgr:getCurControl():changeCameraFixZ(npcCfg.cameraScope)
			end
			EventMgr:dispatchEvent(EV_WORLD_ROKER_VIEW_SHOW,false)
		end

	end
	self.inBuilding = true
	self:doEvent(ActorEventName.SILENCE)

	local pos = buildActor:getBonePosition(self.followBoneName)
	self:setPosition3D(pos.x,pos.y,pos.y)

	if not self.buildPlayOpen and buildActor:actionByCfgId(npcCfg.objectAni_open) then
		self.buildPlayOpen = true
		buildActor:doEvent(ActorEventName.SILENCE)
	end
end

function AmusementPackActor:delayAIAction( delayTime )
	-- body
	if self.aiModel then
		self.aiModel:removeAI()
		self.aiModel:addAITimer(delayTime,function()
			self.aiModel:onBehaveComplete()
		end)
	end
end

function AmusementPackActor:aiAction( )
	-- body
	local actorData = self:getActorData()
	if not actorData then return end
	actorData.buildId = nil
end

function AmusementPackActor:notInBuilding( ... )
	-- body
	if self.inBuilding then
		self.inBuilding = false
		self.buildPlayOpen = false
		self:doEvent(ActorEventName.ACTIVE)

		if self.shadowNode then
			self.shadowNode:show()
		end
	end

	if self.focusbuildActor and self.focusbuildActor.checkCanDoActive then
		self.focusbuildActor:checkCanDoActive()
	end
	
	self.focusbuildActor = nil

	if self.cachePos then
		self:setPosition3D(self.cachePos.x,self.cachePos.y,self.cachePos.y)
		self:moveToStand()
		self.cachePos = nil
	end

	if self.effectAudioHandler then
		TFAudio.stopEffect(self.effectAudioHandler)
		self.effectAudioHandler = nil
	end
	
	if self:isMainHero() then
		local control = WorldRoomDataMgr:getCurControl()
		local cameraScope = self.cameraScope > 0 and self.cameraScope or control.cameraFixZ
		control:changeCameraFixZ(cameraScope)
		EventMgr:dispatchEvent(EV_WORLD_ROKER_VIEW_SHOW,true)
	end
end

function AmusementPackActor:checkCanDoActive( ... )
	-- body
	local actorData = self:getActorData()
	if not actorData.decorateId then return end
	local npcCfg = TabDataMgr:getData("WorldObjectMgr", actorData.decorateId)
	local cfg = TabDataMgr:getData("WorldObjectAction",npcCfg.objectAni_open)
	if not cfg or not self:checkCondition(cfg.playCond) or (actorData.inRoomPid and table.count(actorData.inRoomPid) == 0) then
		self:doEvent(ActorEventName.ACTIVE)
		self:doEvent(ActorEventName.STAND)
	end
end

function AmusementPackActor:addTo( panel )
	-- body
	self.layerOut = self.layerOut or 2
	MapUtils:addChild(panel, self, self.layerOut)  --中层
	-- MapUtils:addChild(panel, self, 1)             --底层
	-- MapUtils:addChild(panel, self, 3)             --顶层
	-- MapUtils:addChild(panel, self, 4)             --boss层
	self:playBorn()
end

function AmusementPackActor:changeSkin( actorData )
	-- body
	self.super.changeSkin(self,actorData)
	self:playBorn()
end

function AmusementPackActor:playBorn()
	-- body
	local function onCallBack()
		if self.aiModel then
			self.aiModel:setAIEnabled(true)
		end
		self:doEvent(ActorEventName.STAND)
	end

	if self.data.decorateId then
		local npcCfg = TabDataMgr:getData("WorldObjectMgr", self.data.decorateId)
		if npcCfg.objectAni_born ~= 0 then
			self:actionByCfgId(npcCfg.objectAni_born,nil,onCallBack)
		else
			onCallBack()
		end
	elseif self.data then
		local bornAction = "born_up"
		self:playEffect("effect/born/born", nil, nil, false, bornAction, false,onCallBack)
		self:playStand()
	else
		onCallBack()
	end
end

function AmusementPackActor:playStand()
	-- body
	if self.data.decorateId then
		local npcCfg = TabDataMgr:getData("WorldObjectMgr", self.data.decorateId)
		self:actionByCfgId(npcCfg.objectAni_idle)
	else
		self:playAni(eAnimation.STAND, true)
		self.playing = false
	end
end

function AmusementPackActor:playMove()
	-- body
	self:playAni(eAnimation.MOVE, true)
	self.playing = false
end

function AmusementPackActor:enterSilence()
	-- body
	self.isSilence = true
end

function AmusementPackActor:beActive()
	-- body
	self.isSilence = false
end

function AmusementPackActor:leaveMove(event)
end

function AmusementPackActor:playAni(action, loop, completeCallback)
	if not self.skeletonNode then return end

	if loop then
		 self.lastLoopAni = action
	end

	local realAction = self:getAnimWithPrefix(action)

	if self.animation == realAction and self.loop and loop then
		if completeCallback then
			completeCallback(self.skeletonNode)
		end
		return  
	end

	self.animation = realAction
	self.loop = loop

	loop = not (not loop)
	local l = loop and 1 or 0

	self.skeletonNode:play(realAction, l)
	if completeCallback and l == 0 then
		self.skeletonNode:addMEListener(TFARMATURE_COMPLETE, function(skeletonNode)
			skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
			completeCallback(skeletonNode)
			if self.lastLoopAni then
				self:playAni(self.lastLoopAni,true)
			end
		end)
	else
		self.skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
		if completeCallback then
			completeCallback(self.skeletonNode)
		end
	end
end

function AmusementPackActor:_onExit(  )
	-- body
	if self.audioHandler then
		TFAudio.stopEffect(self.audioHandler)
		self.audioHandler = nil
	end

	if self.effectAudioHandler then
		TFAudio.stopEffect(self.effectAudioHandler)
		self.effectAudioHandler = nil
	end
end

--播放特效
function AmusementPackActor:playEffect(effectName, followDir, effectScale, isLoop, actionName, fullScene,callFunc)
	local showOtherEffect = SettingDataMgr:getWorldShowEffect()
	if (not self:isMainHero() and not showOtherEffect) 
		or (self.ishide and not fullScene ) then
		if callFunc then
			callFunc()
		end
		return
	end

	
	local skeletonNode = self.staticEffect
	local recoverAni = false
	if effectName ~= "all" then
		local resPath = effectName
		skeletonNode = self:createSkeleton(resPath)
		if not skeletonNode then
			Box("======配置资源特效文件找不到===资源"..effectName)
			return
		end

		skeletonNode:setScale(effectScale)
		if followDir then
			MapUtils:setSkeletonNodeDir(skeletonNode, self:getDir())
		end
		if not fullScene then
			self:addChild(skeletonNode, 2)
		 	local _drawNode = TFImage:create("ui/common/img_touming.png") -- 解决对象绘制bug 
		 	skeletonNode:addChild(_drawNode)
			self:setCameraMask(self:getCameraMask())
		else
			local pos = WorldRoomDataMgr:getCurControl():getBaseMap():convertToNodeSpace(ccp(GameConfig.WS.width/2,GameConfig.WS.height/2))
			skeletonNode:setPosition(pos)
			skeletonNode:setCameraMask(1)
			WorldRoomDataMgr:getCurControl():getBaseMap():addChild(skeletonNode)
		end
	else
		recoverAni = true
	end

	if not skeletonNode then return end

	if actionName then
		skeletonNode:play(actionName, isLoop)
	else
		skeletonNode:playByIndex(0, -1, -1, isLoop and 1 or 0 )
	end



	if isLoop and not fullScene then
		if self.staticEffect then
			self.staticEffect:removeMEListener(TFARMATURE_COMPLETE)
			self.staticEffect:removeFromParent()
		end
		self.staticEffect = skeletonNode
		skeletonNode.loopAni = actionName
	else
		skeletonNode:addMEListener(TFARMATURE_COMPLETE, function(_skeletonNode)
			if callFunc then
				callFunc(_skeletonNode)
			end
			_skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
			if recoverAni then
				_skeletonNode:play(_skeletonNode.loopAni,true)
				return
			end
			self:addCacheSpine(_skeletonNode,effectName)
			_skeletonNode:removeFromParent()
		end)
	end
	return skeletonNode
end

function AmusementPackActor:addCacheSpine( skeletonNode, resPath )
	-- body
	ResLoader.cacheSpine[resPath] = ResLoader.cacheSpine[resPath] or {}
	if #ResLoader.cacheSpine[resPath] <= 20 then -- 同一个spine 最多缓存20个
		table.insert(ResLoader.cacheSpine[resPath],skeletonNode)
		skeletonNode:retain()
	end
end

function AmusementPackActor:doEvent( eventName, ... )
	-- body
	if eventName == ActorEventName.MOVE then
		if self:getState() == ActorStateType.MOVE then
			return
		end
	end
	self.super.doEvent(self,eventName,...)
end

function AmusementPackActor:checkMoveState( ... )
	local state = self:getState()
	if state == ActorStateType.ACTIVE or state == ActorStateType.STAND or state == ActorStateType.MOVE then
		return not self.isSilence
	end
	return false
end

function AmusementPackActor:updateShowNode( actorData )
	-- body
	self:removeAllChildren()
	self.staticEffect = nil
	self.animation = nil
	self.shadowNode = nil
	self.ghostNode = nil
	self.lable_name = nil
	self:createActor(actorData)
	self:doEvent(ActorEventName.ACTIVE)
	self:setCameraMask(self:getCameraMask())
	if self:isMainHero() then
		local control = WorldRoomDataMgr:getCurControl()
		local cameraScope = self.cameraScope > 0 and self.cameraScope or control.cameraFixZ
		control:changeCameraFixZ(cameraScope)
	end
end

function AmusementPackActor:checkCondition( cond )
	-- bodyt
	local suc = true
	local actorData = self:getActorData()
	for k,v in pairs(cond) do
		if k == "playMix" then
			if actorData and actorData.inRoomPid then
				suc = table.count(self:getActorData().inRoomPid) >= v
			else
				suc = false
			end
		end
	end
	return suc
end

function AmusementPackActor:actionByCfgId( cfgId, pagram, callFunc )
	-- body
	local cfg = TabDataMgr:getData("WorldObjectAction",cfgId)
	if not cfg then
		if callFunc then
			callFunc() 
		end
		return  false
	end

	if not self:checkCondition(cfg.playCond) then
		return false
	end

	local finishCallBack = callFunc

	if cfg.finishActionButton and #cfg.finishActionButton > 0 then
		finishCallBack = function ( ... )
			-- body
			for k,v in ipairs(cfg.finishActionButton) do
				WorldRoomDataMgr:getCurControl():playActionButton(v, nil,self:getPid())
			end

			if callFunc then
				callFunc()
			end
		end
	end

	if cfg.aiDelayTime and cfg.aiDelayTime ~= 0 then
		self:delayAIAction( cfg.aiDelayTime)
	end

	if cfg.beStand then
		self:setAutoMove(false)
	end

	if cfg.modelDir and cfg.modelDir ~= 0 then
		self:setDir(cfg.modelDir)
	end

	if cfg.hideShadow and self.shadowNode then
		self.shadowNode:hide()
	end

	if self.effectAudioHandler then
		TFAudio.stopEffect(self.effectAudioHandler)
		self.effectAudioHandler = nil
	end

	local addCallFunc = false
	if cfg.objectAction ~= "" then -- 动作播放
		if not cfg.objectActIsLoop then
			self:doEvent(ActorEventName.SILENCE)
			addCallFunc = true
		end
		self:playAni(cfg.objectAction, cfg.objectActIsLoop, function ( ... )
			-- body
			self:doEvent(ActorEventName.ACTIVE)
			if cfg.hideShadow and self.shadowNode then
				self.shadowNode:show()
			end
			if finishCallBack then
				finishCallBack()
			end
		end)
	end

	if cfg.motionRecourse_1 ~= "" then -- 特效效果
		local skeletonNode = nil
		if addCallFunc then
			skeletonNode = self:playEffect(cfg.motionRecourse_1, cfg.dirFollowObj, 1, cfg.motionActIsLoop, cfg.motionAction_1, cfg.fullScene)
		else
			addCallFunc = true
			skeletonNode = self:playEffect(cfg.motionRecourse_1, cfg.dirFollowObj, 1, cfg.motionActIsLoop, cfg.motionAction_1, cfg.fullScene, finishCallBack)
		end
		if table.count(cfg.offSet) ~= 0 then
			if skeletonNode then
				skeletonNode:setPosition(skeletonNode:getPosition() + ccp(cfg.offSet.x,cfg.offSet.y))
			end
		end
	end

	if not addCallFunc and finishCallBack then
		finishCallBack()
	end

	if cfg.audioId ~= 0 then -- 背景音效
		local distance = WorldRoomDataMgr:getCurControl():getDistanceFromMainHero(self)
		if distance then
			local handler = Utils:playSound(cfg.audioId,cfg.audioLoop)
			cfg.audioRange = cfg.audioRange or 300
			cfg.audioRate = cfg.audioRate or 100
	        local valume = math.min(1,(cfg.audioRange - distance)/(cfg.audioRange*cfg.audioRate/100))
	        valume = math.max(0,valume)

			local baseVol = SettingDataMgr:getSoundMainVal()
	    	local effectVol = SettingDataMgr:getSoundEffectVal()
			TFAudio.setEffectsVolumeById(handler,baseVol*effectVol*valume)
			if cfg.audioLoop then
				self.effectAudioHandler = handler
			end
		end
	end

	if cfg.changeModel and cfg.changeModel.actorCfgId then
		local actorData = WorldRoomDataMgr:getCurControl():createNewEmptyData(cfg.changeModel.actorCfgId)
		actorData.pos = self:getPosition()
		actorData.pid = self:getPid()
		self:updateShowNode(actorData)
		self:playBorn()
	end

	if cfg.recoverModel then
		local actorData = WorldRoomDataMgr:getCurControl():getActorDataByPid(self:getPid())
		self:updateShowNode(actorData)
		self:playBorn()
	end

	if cfg.chatText and cfg.chatText ~= 0 then -- 背景音效
    	self:playTalk(TextDataMgr:getTextEx(cfg.chatText),true, cfg.chatTexture)
	end

	if cfg.manualAICfgId and cfg.manualAICfgId > 0 then
		self:manualAddAI(cfg.manualAICfgId)
	end

	if cfg.manualDelAICfgId and cfg.manualDelAICfgId > 0 then
		self:manualDeleteAI(cfg.manualDelAICfgId)
	end

	return true
end

function AmusementPackActor:removeActor( ... )
	-- body
	self:notInBuilding()
	if  self.aiModel then
		self.aiModel.tarNode = nil
	end

	if self.manualAITab then
		for k ,v in pairs(self.manualAITab) do
			v.tarNode = nil
		end
	end

	self.aiModel = nil
	self.manualAITab = nil
	if self.skeletonNode then -- 缓存现有spine 备用
		self:addCacheSpine(self.skeletonNode,self.resPath)
	end
	self.super.removeActor(self)
end

function AmusementPackActor:serverToMove( pos )
	if flyToPos then
		self:setPosition3D(pos.x,pos.y,pos.y)
	else
	    self:moveTo(pos ,function ( ... )
	        -- body
	        if self:isMainHero() then
	            WorldRoomDataMgr:setColdingState(false)
	        end
	    end)

	    if self:isMainHero() then
	        WorldRoomDataMgr:setColdingState(true)
	    end
	end
end

function AmusementPackActor:setFlipX(flipX)
	self.super.setFlipX(self,flipX)
	if self.ghostNode then
		local scaleX = self.ghostNode:getScaleX()
		if flipX then
			scaleX = -math.abs(scaleX)
		else
			scaleX = math.abs(scaleX)
		end
		self.ghostNode:setScaleX(scaleX)
	end
end

function AmusementPackActor:hideSelf( show )
	-- body
	if self.skeletonNode then
		self.skeletonNode:setVisible(show)
	end
	if self.staticEffect then
		self.staticEffect:setVisible(show)
	end

	if self.ghostNode then
		self.ghostNode:setVisible(not show)
	end
	self.ishide = not show
end

return AmusementPackActor 