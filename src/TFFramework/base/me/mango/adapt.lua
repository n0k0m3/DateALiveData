
math.mod = math.mod or math.fmod

local _getChildren = CCNode.getChildren

local cs_MT = {
	count = function(t)
		return #t
	end,
	objectAtIndex = function(t, idx)
		return t[idx + 1]
	end,
}
cs_MT.__index = cs_MT

local function getChildren(node)
	local cs = _getChildren(node)
	setmetatable(cs, cs_MT)
	return cs
end
CCNode.getChildren = getChildren

function LogAsync()
	__log("log:async")
end

function LogSync()
	__log("log:sync")
end

CCTexture2D = Texture2D
CCSprite 	= Sprite
CCDelayTime = DelayTime
CCCallFuncN = CallFuncN
CCCallFunc  = CallFunc
CCShow 		= Show
CCHide 		= Hide
CCPlace 	= Place
CCActionInterval = ActionInterval
CCSequence = Sequence
CCRepeat = Repeat
CCRepeatForever = RepeatForever
CCSpawn = Spawn
CCRotateTo = RotateTo
CCRotateBy = RotateBy
CCMoveBy = MoveBy
CCMoveTo = MoveTo
CCSkewTo = SkewTo
CCSkewBy = SkewBy
CCJumpBy = JumpBy
CCJumpTo = JumpTo
CCBezierBy = BezierBy
CCBezierTo = BezierTo
CCScaleTo = ScaleTo
CCScaleBy = ScaleBy
CCBlink = Blink
CCFadeTo = FadeTo
CCFadeIn = FadeIn
CCFadeOut = FadeOut
CCTintTo = TintTo
CCTintBy = TintBy
CCDelayTime = DelayTime
CCReverseTime = ReverseTime
CCAnimate = Animate
CCTargetedAction = TargetedAction
CCActionFloat = ActionFloat
CCSizeTo = SizeTo
CCSizeBy = SizeBy
CCTargetedAction = TargetedAction
CCOrbitCamera = OrbitCamera

__log 		= __log or print

local function Sequence_create(seq, arr)
	local tab = {}
	local size = arr:size()
	for i = 0, size - 1 do 
		tab[#tab + 1] = arr:objectAtIndex(i)
	end
	return seq:createWithTable(tab)
end
rawset(Sequence, "create", Sequence_create)