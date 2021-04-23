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
local SingleWorldSceneActor = requireNew("lua.logic.2020ZNQ.AmusementPackActor")

if not SingleWorldSceneActor.prefabe then
	SingleWorldSceneActor.prefabe = createUIByLuaNew("lua.uiconfig.activity.actor_prefab")
	SingleWorldSceneActor.prefabe:retain()
end

local function createActor( self, actorData )
	-- body
	if actorData.skinCid then
		self:createHero(actorData)
	else
		self:createNpc(actorData)
	end

	if actorData.pos then
		self:setPosition3D(actorData.pos.x ,actorData.pos.y, actorData.pos.y)
	end
	self.childType = actorData.childType
	self.isSingeActor = true
	self:updateHideNode()
end
rawset(SingleWorldSceneActor, "createActor", createActor)

local function createSpine( self, ... )
	-- body
	 if ResLoader.cacheSpine[self.resPath] and #ResLoader.cacheSpine[self.resPath] >= 1 then
    	self.skeletonNode = ResLoader.cacheSpine[self.resPath][1]
    	self.skeletonNode:autorelease()
    	table.remove(ResLoader.cacheSpine[self.resPath],1)

    	self.skeletonNode:removeMEListener(TFARMATURE_EVENT)
        self.skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
        self.skeletonNode:removeMEListener(TFWIDGET_ENTER)
        self.skeletonNode:removeMEListener(TFWIDGET_EXIT)
        -- _print("找到 skeleton:"..skeletonNode:retainCount().." "..resPath)
        --重置位置
        self.skeletonNode:setPosition(me.p(0,0))
        self.skeletonNode:setAnimationFps(GameConfig.ANIM_FPS)
        self.skeletonNode:setColor(me.WHITE)
        self.skeletonNode:setRotation(0)
        self.skeletonNode:clearTracks()
    else
		self.skeletonNode = ResLoader.getSkeletonNode(self.resPath)
    end
end
rawset(SingleWorldSceneActor, "createSpine", createSpine)

local function createHero( self, actorData )
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
	local prefabe = SingleWorldSceneActor.prefabe
	local heroUI = TFDirector:getChildByPath(prefabe, "Panel_player"):clone()

	
	self.lable_name = TFDirector:getChildByPath(heroUI,"lable_name")
	self.lable_name:setText(actorData.pname)

	self.image_bubble = TFDirector:getChildByPath(heroUI, "Image_bubble"):hide()
	local label_bubble = TFDirector:getChildByPath(heroUI, "Label_bubble")
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
	end


	if conf.aiEnable then
		self.aiModel = requireNew("lua.logic.singleWorldScene.SingleAIBehave"):new({tarNode = self, life = conf.aiTime })
		self.deleteAi = conf.deleteAi
	end

    self.isAction = true
end
rawset(SingleWorldSceneActor, "createHero", createHero)

local function createNpc( self, actorData )
	-- body
	local npcCfg = TabDataMgr:getData("WorldObjectMgr", actorData.decorateId)
	local resCfg = TabDataMgr:getData("WorldObjectResource", npcCfg.resourceId)
	if resCfg then
		if resCfg.resourceType == 2 then
			local aniPath = resCfg.path

			self.speedScale = npcCfg.moveSpeedMultiplier or 1
    		self.resPath = aniPath
    		self:createSpine()
		    self:addChild(self.skeletonNode,1)

		 	local _drawNode = TFImage:create("ui/common/img_touming.png") -- 解决对象绘制bug 
		 	self.skeletonNode:addChild(_drawNode)
		 	self.isSpecialModel = resCfg.isSpecialModel
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

	 self.isCameraScale = false
	-- body
	local prefabe = SingleWorldSceneActor.prefabe
	local npcUI = TFDirector:getChildByPath(prefabe, "Panel_npc"):clone()

	self.image_bubble = TFDirector:getChildByPath(npcUI, "Image_bubble"):hide()
	local label_bubble = TFDirector:getChildByPath(npcUI, "Label_bubble")
	self.label_bubble = label_bubble

	npcUI:setPosition(ccp(0,0))
	self:addChild(npcUI,2)
	self.showUi = npcUI	

	self:setDir(npcCfg.dir)

	if self.audioHandler then
		TFAudio.stopEffect(self.audioHandler)
		self.audioHandler = nil
	end
	
	if npcCfg.isShowShadow then
		if not self.shadowNode then
			self.shadowNode = TFImage:create("citymap/world/shadow.png")
			self:addChild(self.shadowNode)
		end

		if not self.ghostNode and WorldRoomDataMgr:getCurControl():getGhost() then
			self.ghostNode = TFImage:create(WorldRoomDataMgr:getCurControl():getGhost())
			self.ghostNode:setAnchorPoint(ccp(0.5,0))
			self:addChild(self.ghostNode)
		end
	end

	if npcCfg.audioId > 0 then
		self.audioId = npcCfg.audioId
	end

	if npcCfg.bgm and npcCfg.bgm ~= "" then
		WorldRoomDataMgr:getCurControl():setCurBgm(npcCfg.bgm)
	end
	
	if npcCfg.aiEnable then
		self.aiModel = requireNew("lua.logic.singleWorldScene.SingleAIBehave"):new({tarNode = self ,life = npcCfg.aiTime})
		self.deleteAi = npcCfg.deleteAi
	end
	self.isAlWayTrigger = npcCfg.isAlWayTrigger
	self.isAction = npcCfg.isAction

	self.isTriggerFuc = npcCfg.isTrigger
end
rawset(SingleWorldSceneActor, "createNpc", createNpc)

return SingleWorldSceneActor 