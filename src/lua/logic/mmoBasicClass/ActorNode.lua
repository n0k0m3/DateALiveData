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
* 
]]
local BasicActor    = import(".BasicActor")
local OSDEnum    = import(".OSDEnum")
local StateEvent = OSDEnum.StateEvent
local HeroState  = OSDEnum.HeroState
local HeroType   = OSDEnum.HeroType

local ActorNode = class("ActorNode" ,BasicActor)

function ActorNode:ctor( data )
	-- body
	local events ={
		{name = StateEvent.FSM_BORN, from = {HeroState.OSD_STAND}, to = HeroState.OSD_BORN},
		{name = StateEvent.FSM_STAND, from = {StateMachine.WILDCARD}, to = HeroState.OSD_STAND},
		{name = StateEvent.FSM_MOVE, from = {HeroState.OSD_BORN, HeroState.OSD_STAND, HeroState.OSD_MOVE}, to = HeroState.OSD_MOVE},
	}

	local initial = {
		event = StateEvent.FSM_STAND,
		state = HeroState.OSD_STAND,
	}

	self.super.ctor(self,events,initial)

	self:initData(data)
end

function ActorNode:initData( data )
	-- body
	self:addFSMAfterEvents(HeroState.OSD_BORN,handler(self.playBorn,self))
	self:addFSMAfterEvents(HeroState.OSD_STAND,handler(self.playStand,self))
	self:addFSMAfterEvents(HeroState.OSD_MOVE,handler(self.onMove,self))

	self:addFSMLeaveEvents(HeroState.OSD_MOVE,handler(self.cleanAutoPath,self))
end

--出生效果
function ActorNode:playBorn()
	local function onCallBack()
		self:doEvent(StateEvent.FSM_STAND)
	end

	if self.data and self.data.bornEffect then
		local bornEffect = "born"
		local bornAction = "born_up"
		self:playEffect(bornEffect, nil, bornAction, onCallBack)
		self:playStand()
	else
		onCallBack()
	end
end

--待机
function ActorNode:playStand()
	if self.animation ~= eAnimation.STAND then  
		self:playAni(eAnimation.STAND, true)
	end
end

--移动动作
function ActorNode:playMove()
	if self.animation ~= eAnimation.MOVE then
		self:playAni(eAnimation.MOVE, true)
	end
end


return ActorNode