local enum         = import(".enum")
local eDir         = enum.eDir
local eEvent     = enum.eEvent
local eMode         = enum.eMode
local eCameraFlag = enum.eCameraFlag
local VisualHero = class("VisualHero",function()
    local node = CCNode:create()
    return node
end)


function VisualHero:initData(param)

	self.modelId = param.modelId
	self.spineCfg = TabDataMgr:getData("StoryModel",self.modelId)
    self.battleCtrl = param.controller
    if self.spineCfg.model then
        print("Model Loading:",self.spineCfg.model)
    else
        print("Nil :",self.modelId)
    end
    
    self:setVisible(false)
    if param.show and param.show == true then
        self:setVisible(true)
    end
    self.madeCallback = param.callback
    if param.asyc and param.asyc == true then
        self:loadHeroModel()
    else
        self:makeHeroModel()
    end
    self.order = param.order
    self.AnimFrameEvtIdx = 0
    self.curPlayAnim = ""
end

function VisualHero:ctor(param)
	self:initData(param)
    self:setPosition(me.p(0,0))
    EventMgr:dispatchEvent(eEvent.EVENT_VISUAL_HERO_ADD_TO_LAYER,self,self.order or 2)
end

function VisualHero:setScale(scale)
    -- print("scale",scale)
end

function VisualHero:_setScale(scale)
    CCNode.setScale(self,scale)
end

function VisualHero:spineFrameEvent(...)
	local event = self:getSpineFrameEvtData(...)
	if event.name == "effect" then
		-- local effectCfg = string.split(event.paramS)
		-- self:playEffect(effectCfg[1],effectCfg[2],effectCfg[3])
	elseif event.name == "music" then
		-- local soundID = event.paramN
        self.curPlayAnim = event.animation
        -- print(event.skeleton:getTime())
        self.AnimFrameEvtIdx = self.AnimFrameEvtIdx + 1
		self:playSound()
	elseif string.match(event.name,"jingtou") then
        self.battleCtrl.setCameraMode(eMode.FOLLOW_NODE)
        self.battleCtrl.setFocusNode(self)
    else

	end
end

function VisualHero:onComplete()
	

end

function VisualHero:setPosition3D(px,py,pz)
	self:setPosition(me.p(px,py))
end

function VisualHero:setDir(dir)
	if dir == eDir.LEFT then
        self:setFlipX(true)
    elseif dir == eDir.RIGHT then
        self:setFlipX(false)
    end
end

function VisualHero:moveToPos(cfg,callback)
    local finalPos = cfg.finalPos
    local duration = cfg.duration
    local moveAnim = cfg.moveAnim
    local endAnim = cfg.endAnim
	local actarr = {MoveTo:create(finalPos,duration),CallFunc:create(function()
        if endAnim then
            self.skeletonModel:play(endAnim,-1)
        end
		if callback then
			callback()
		end
	end)}
    if moveAnim then
        self.skeletonModel:play(moveAnim,-1)
    end
	self:runAction(Sequence:create(actarr))
end
function VisualHero:getSpineFrameEvtData(...)
    local data = {...}
    local event =  {
            skeleton  = data[1], --动画节点
            animation = data[2], --动作名称
            name      = data[3], --事件名称
            paramN     = data[4], --整型参数
            paramF     = data[5], --浮点型参数
            paramS     = data[6]       --字符串参数
            }
    return event
end

function VisualHero:makeHeroModel()
	local ResLoader = require("lua.logic.battle.ResLoader")
	local tmskeletonNode = ResLoader.createSkeletonAnimation(string.format("modle/story/%s/%s",self.spineCfg.model,self.spineCfg.model),self.spineCfg.modelSize)
	self:setVisualModel(tmskeletonNode)
end

function VisualHero:setVisualModel(tmskeletonNode)
    tmskeletonNode:setCameraMask(eCameraFlag.CF_MAP)
    self:addChild(tmskeletonNode)
    self.skeletonModel = tmskeletonNode
    self.skeletonModel:setupPoseWhenPlay(false)
    self.skeletonModel:addMEListener(TFARMATURE_EVENT,handler(self.spineFrameEvent,self))
    self.skeletonModel:addMEListener(TFARMATURE_COMPLETE,function(skeletonNode)
                if self.isAnimIdle == false then
                    if self.idleAnim ~= "" then
                        self.isAnimIdle = true
                        self.curPlayAnim = self.idleAnim
                        skeletonNode:play(self.idleAnim,true)
                    else
                        if self.isNeedHide == true then
                            self:setVisible(false)
                        end
                    end
                    if self.completeCallback then
                        self.completeCallback()
                    end
                end
            end)
    if self.madeCallback then
        print("Model Loaded:",self.spineCfg.model)
        self.madeCallback()
    end
end

function VisualHero:loadHeroModel()
    local ResLoader = require("lua.logic.battle.ResLoader")
    ResLoader.createSkeletonAnimationAsync(string.format("modle/story/%s/%s",self.spineCfg.model,self.spineCfg.model),self.spineCfg.modelSize,handler(self.setVisualModel,self))
end

function VisualHero:playAni(param)
	self.completeCallback = param.callback
    self.isNeedHide = param.hide or true
    self.idleAnim = param.idle or ""
	self:setVisible(true)
    self.isAnimIdle = false
    if param.setupPose and param.setupPose == true then
        self.skeletonModel:setupPoseWhenPlay(true)
    end
    self.AnimFrameEvtIdx = 0
    self.curPlayAnim = param.anim
	self.skeletonModel:play(param.anim,false)
end

function VisualHero:playSound()
    local tmEvtName = "music"..self.AnimFrameEvtIdx
    -- Box(string.format("Spine:%s\b\bAnim:%s\b\bEvent:%s",self.spineCfg.model,self.curPlayAnim,tmEvtName))
    local soundCfg = BattleDataMgr:getScriptSoundData(self.spineCfg.model,self.curPlayAnim,tmEvtName)
    if soundCfg then
        for k,v in pairs(soundCfg) do
            if v.resource and v.resource ~= "" then
                if v.musicType == 1 then
                    TFAudio.playVoice(v.resource,false)
                else
                    -- Box(string.format("Spine:%s\b\bAnim:%s\b\bEvent:%s,%s",self.spineCfg.model,self.curPlayAnim,tmEvtName,v.resource))
                    TFAudio.playEffect(v.resource, false, 1, 0, (v.volume/100))
                end
            end
        end
    end
    
end

function VisualHero:playEffect(effectName,effectScale,actionName,callFunc)
	local ResLoader = require("lua.logic.battle.ResLoader")
	local tmskeletonNode = ResLoader.createEffect(effectName,effectScale)
    tmskeletonNode:play(actionName, false)
	tmskeletonNode:setPosition(me.p(0,0))
    tmskeletonNode:addMEListener(TFARMATURE_COMPLETE,function(skeletonNode)
            skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
            skeletonNode:removeFromParent()
            if callFunc then
            	callFunc()
            end
        end)
	self:addChild(tmskeletonNode,2)

end

function VisualHero:getBoundingBox(boneName)
    local rect = self.skeletonModel:getBoundingBox2(boneName)
    -- dump(rect)
    if math.abs(rect.origin.x) > 8192
        or  math.abs(rect.origin.y) > 8192
        or  rect.size.width > 8192
        or  rect.size.height > 8192  then --非法碰撞框
        rect.size.width = 0
        rect.size.width = 0
        rect.origin.x   = 0
        rect.origin.y   = 0
    end
    local pos  = ccp(self:getPosition())
    rect.origin.x = rect.origin.x + pos.x
    rect.origin.y = rect.origin.y + pos.y
    return rect
end

function VisualHero:getRelativeBoundingBox(boneName)
    return self.skeletonModel:getBoundingBox2(boneName)
end

function VisualHero:getBonePosition(boneName)
    local pos    = self:getRelativeBonePosition(boneName)
    return me.pAdd(self:getPosition() , pos)
end

function VisualHero:getRelativeBonePosition(boneName)
    local  pos    = self.skeletonModel:getBonePosition(boneName)
    local scaleX  = self.skeletonModel:getScaleX()
    local scaleY  = self.skeletonModel:getScaleY()
    return ccp(pos.x*scaleX,pos.y*scaleY)
end

return VisualHero